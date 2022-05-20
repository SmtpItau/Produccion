Attribute VB_Name = "BACSQL"
Option Explicit
Global SqlConexion As ADODB.Connection
Global SqlResultado As ADODB.Recordset
Global Consulta As String
Global Conexion As String

Function BAC_SQL_FETCH(ByRef Arreglo As Variant) As Boolean
On Error GoTo ErrFetch
   Dim i             As Integer
   Dim Conta         As Integer
   Dim Mc            As Integer
   Dim dblValor      As Double
   Dim strNumero     As String
   Dim tmpValor      As Variant

  BAC_SQL_FETCH = False
  
   If Not HayDatos Then
       Exit Function
   End If
   
   If SqlResultado.EOF Then
      Exit Function
   End If
   
      Conta = SqlResultado.Fields.Count
      ReDim Arreglo(1 To Conta)
      For i = 1 To Conta
         tmpValor = Trim(SqlResultado.Fields(i - 1))
         If IsNumeric(tmpValor) Then
            If gsc_PuntoDecim = "." Then
               Mc = InStr(1, tmpValor, ",")
               If Mc > 0 Then
                   tmpValor = Mid(tmpValor, 1, Mc - 1) & "." & Mid(tmpValor, Mc + 1)
               End If
            End If
         ElseIf IsDate(tmpValor) Then
            Arreglo(i) = IIf(IsNull(tmpValor), "", Format(tmpValor, "DD/MM/YYYY"))
         End If
         Arreglo(i) = IIf(IsNull(tmpValor), "", tmpValor)
      Next

       SqlResultado.MoveNext
 
  BAC_SQL_FETCH = True
Exit Function

ErrFetch:
    If err.Number = 3705 Then
       SqlResultado.Close
       Resume
    End If
     MsgBox "Se ha producido un error al ejecutar :" & Chr(10) & Chr(10) & _
            err.Description, vbOKOnly + vbExclamation
     Exit Function
    

End Function


Function FUNC_INFORMACION_CONEXION_DESKMANAGER(ByRef rst_mensajes As ADODB.Recordset) As Boolean
'------------------------------------------
'EBQ: Determinar nombre de BD Desk-Manager
'------------------------------------------
   On Error GoTo ERRINFORMACION
   
   FUNC_INFORMACION_CONEXION_DESKMANAGER = False
   
   cDatabase = FUNC_LEER_REGISTRO("SISTEMAS BAC", "BASE DE DATOS", "DB_DESKMANAGER")
   
   FUNC_INFORMACION_CONEXION_DESKMANAGER = True
   
ERRINFORMACION:
End Function

Function HayDatos() As Boolean
On Error GoTo ErrDatos
  HayDatos = False

  If SqlResultado.RecordCount = 0 Then
      Exit Function
  End If

 HayDatos = True

 Exit Function
ErrDatos:
   If err.Number <> 3704 Then
     MsgBox "Error al recuperar datos desde Sql :" & Chr(10) & Chr(10) & err.Description, vbOKOnly + vbExclamation
   End If
     Exit Function
End Function

Function BAC_SQL_EXECUTE(Procedimiento As String, Optional Arreglo As Variant) As Boolean
On Error GoTo ErrEjecuta
 BAC_SQL_EXECUTE = False
 
   Dim i As Integer
   Dim Conta As Integer, Mc
   Dim Sql As String

   Sql = Procedimiento

   gsc_PuntoDecim = Mid$(Format(0#, "0.0"), 2, 1)

   If IsMissing(Arreglo) Then
      Conta = -1
   Else
      Conta = UBound(Arreglo)
   End If

   For i = 0 To Conta
      If TypeName(Arreglo(i)) = "String" Then
         If IsDate(Arreglo(i)) Then
            Sql = Sql & " '" & Format(Arreglo(i), feFecha) & "',"
         Else
            If InStr(1, Arreglo(i), "'") > 0 Then
              If Len(Arreglo(i)) <= 128 Then
               Sql = Sql & " [" & Arreglo(i) & "],"
              Else
                Arreglo(i) = Replace(Arreglo(i), "'", "^")
                Sql = Sql & " '" & Arreglo(i) & "',"
              End If
            Else
             Sql = Sql & " '" & Arreglo(i) & "',"
            End If
         End If
      ElseIf TypeName(Arreglo(i)) = "Date" Then
         Sql = Sql & " '" & Format(Arreglo(i), feFecha) & "',"
      Else
         If gsc_PuntoDecim = "," Then
            Mc = InStr(1, Arreglo(i), ",")
            If Mc > 0 Then
                Arreglo(i) = Mid(Arreglo(i), 1, Mc - 1) & "." & Mid(Arreglo(i), Mc + 1)
            End If
         End If
         Sql = Sql & " " & Arreglo(i) & ","
      End If
   Next i

   If Conta > -1 Then
      Sql = Mid(Sql, 1, Len(Sql) - 1)
   End If

   VerSql = Sql
   
   SqlResultado.Open VerSql, SqlConexion, adOpenForwardOnly, adLockReadOnly

   BAC_SQL_EXECUTE = True

 Exit Function
ErrEjecuta:
    If err.Number = 3705 Then
       SqlResultado.Close
       Resume
    End If
    If err.Number = -2147467259 Then
       Resume
    End If
     Clipboard.Clear
     Clipboard.SetText VerSql

     MsgBox "Se ha producido un error al ejecutar " & Procedimiento & Chr(10) & Chr(10) & _
            err.Description, vbOKOnly + vbExclamation
     
     Exit Function

End Function


Function BAC_LOGIN(sUser$, sPWD$) As Boolean

On Error GoTo ErrConectar
  BAC_LOGIN = False
  
  Conexion = "Connect Timeout=" & giSQL_LoginTimeOut & _
             ";Extended Properties='DRIVER=SQL Server;SERVER=" & Trim(gsSQL_Server$) & _
             ";UID=" & gsSQL_Login & _
             ";PWD=" & gsSQL_Password & _
             ";WSID=" & gsBAC_Term & _
             ";DATABASE=" & Trim(gsSQL_Database) & "'"
 Set SqlConexion = New ADODB.Connection
 
 SqlConexion.CommandTimeout = giSQL_QueryTimeOut
 
 SqlConexion.Open Conexion

 Set SqlResultado = New ADODB.Recordset
 SqlResultado.CursorLocation = adUseClient

  BAC_LOGIN = True

    Exit Function
ErrConectar:
       MsgBox "Error al conectar a Sql" & Chr(10) & Chr(10) & err.Description, vbOKOnly + vbExclamation
       Exit Function

End Function
Function DesconectarSql() As Boolean
On Error GoTo ErrDesconectar
  DesconectarSql = False

   SqlConexion.Close

   Set SqlConexion = Nothing

  DesconectarSql = True
Exit Function
ErrDesconectar:
     MsgBox "Error al desconectar: " & err.Description, vbOKOnly + vbExclamation
     Exit Function
End Function
