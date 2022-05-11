Attribute VB_Name = "BACSQL"
Option Explicit
Global SqlConexion As ADODB.Connection
Global SqlResultado As ADODB.Recordset
Global Consulta As String
Global Conexion As String

Function BAC_SQL_FETCH(ByRef Arreglo As Variant) As Boolean
On Error GoTo ErrFetch
   Dim I             As Integer
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
      For I = 1 To Conta
         tmpValor = Trim(SqlResultado.Fields(I - 1))
         If IsNumeric(tmpValor) Then
            If gsc_PuntoDecim = "." Then
               Mc = InStr(1, tmpValor, ",")
               If Mc > 0 Then
                   tmpValor = Mid(tmpValor, 1, Mc - 1) & "." & Mid(tmpValor, Mc + 1)
               End If
            End If
         ElseIf IsDate(tmpValor) Then
            Arreglo(I) = IIf(IsNull(tmpValor), "", Format(tmpValor, "DD/MM/YYYY"))
         End If
         Arreglo(I) = IIf(IsNull(tmpValor), "", tmpValor)
      Next

       SqlResultado.MoveNext
 
  BAC_SQL_FETCH = True
Exit Function

ErrFetch:
    If Err.Number = 3705 Then
       SqlResultado.Close
       Resume
    End If
     MsgBox "Se ha producido un error al ejecutar :" & Chr(10) & Chr(10) & _
            Err.Description, vbOKOnly + vbExclamation
     Exit Function
    

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
   If Err.Number <> 3704 Then
     MsgBox "Error al recuperar datos desde Sql :" & Chr(10) & Chr(10) & Err.Description, vbOKOnly + vbExclamation
   End If
     Exit Function
End Function

Function BAC_SQL_EXECUTE(Procedimiento As String, Optional Arreglo As Variant) As Boolean
On Error GoTo ErrEjecuta
 BAC_SQL_EXECUTE = False
 
   Dim I As Integer
   Dim Conta As Integer, Mc
   Dim Sql As String

   Sql = Procedimiento

   gsc_PuntoDecim = Mid$(Format(0#, "0.0"), 2, 1)

   If IsMissing(Arreglo) Then
      Conta = -1
   Else
      Conta = UBound(Arreglo)
   End If

   For I = 0 To Conta
      If TypeName(Arreglo(I)) = "String" Then
         If IsDate(Arreglo(I)) Then
            Sql = Sql & " '" & Format(Arreglo(I), feFECHA) & "',"
         Else
            If InStr(1, Arreglo(I), "'") > 0 Then
              If Len(Arreglo(I)) <= 128 Then
               Sql = Sql & " [" & Arreglo(I) & "],"
              Else
                Arreglo(I) = Replace(Arreglo(I), "'", "^")
                Sql = Sql & " '" & Arreglo(I) & "',"
              End If
            Else
             Sql = Sql & " '" & Arreglo(I) & "',"
            End If
         End If
      ElseIf TypeName(Arreglo(I)) = "Date" Then
         Sql = Sql & " '" & Format(Arreglo(I), feFECHA) & "',"
      Else
         If gsc_PuntoDecim = "," Then
            Mc = InStr(1, Arreglo(I), ",")
            If Mc > 0 Then
                Arreglo(I) = Mid(Arreglo(I), 1, Mc - 1) & "." & Mid(Arreglo(I), Mc + 1)
            End If
         End If
         Sql = Sql & " " & Arreglo(I) & ","
      End If
   Next I

   If Conta > -1 Then
      Sql = Mid(Sql, 1, Len(Sql) - 1)
   End If

   VerSQL = Sql
   
   SqlResultado.Open VerSQL, SqlConexion, adOpenForwardOnly, adLockReadOnly

   BAC_SQL_EXECUTE = True

 Exit Function
ErrEjecuta:
    If Err.Number = 3705 Then
       SqlResultado.Close
       Resume
    End If
    If Err.Number = -2147467259 Then
       Resume
    End If

     Clipboard.Clear
     Clipboard.SetText VerSQL

     MsgBox "Se ha producido un error al ejecutar " & Procedimiento & Chr(10) & Chr(10) & _
            Err.Description, vbOKOnly + vbExclamation
     
     Exit Function

End Function



Function BAC_LOGIN(sUser$, sPWD$) As Boolean

On Error GoTo ErrConectar
  BAC_LOGIN = False
  
  Conexion = "Connect Timeout=" & giSQL_LoginTimeOut & _
             ";Extended Properties='DRIVER=SQL Server;SERVER=" & Trim(gsSQL_Server$) & _
             ";UID=" & Trim(gsSQL_Login$) & _
             ";PWD=" & Trim(gsSQL_Password$) & _
             ";WSID=" & gsBAC_Term & _
             ";DATABASE=" & Trim(gsSQL_DataBase) & "'"

 Set SqlConexion = New ADODB.Connection
 
 SqlConexion.CommandTimeout = giSQL_QueryTimeOut
 
 SqlConexion.Open Conexion

 Set SqlResultado = New ADODB.Recordset
 SqlResultado.CursorLocation = adUseClient

  BAC_LOGIN = True

    Exit Function
ErrConectar:
       MsgBox "Error al conectar a Sql" & Chr(10) & Chr(10) & Err.Description, vbOKOnly + vbExclamation
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
     MsgBox "Error al desconectar: " & Err.Description, vbOKOnly + vbExclamation
     Exit Function
End Function
'
