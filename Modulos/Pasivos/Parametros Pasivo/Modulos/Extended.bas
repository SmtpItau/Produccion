Attribute VB_Name = "Extended"

         '--------------------------------------------------------------'
         '                                                              '
         '     FUNCIONES PARA EL CAMBIO DE CONFIGURACION REGIONAL       '
         '                                                              '
         '                 SQL-SERVER V/S BAC-CONTROLES                 '
         '                                                              '
         '                                                              '
         '     CREADO POR  : CRISTIAN LABARCA ROJAS                     '
         '     FECHA       : 21/MARZO/2001                              '
         '                                                              '
         '--------------------------------------------------------------'



Global VerSql  As String
Global Envia() As Variant


Public Sub PROC_TITULO_MODULO(cId_Sistema As String, cVersion As String)
Dim Datos()
Dim cSeparador As String
 
   
   cVersion = "_" & cVersion
   
   Envia = Array()
   AddParam Envia, cId_Sistema
   AddParam Envia, cVersion
   
   If Not BAC_SQL_EXECUTE("SP_CON_TITULO_SISTEMA", Envia) Then
      MsgBox "Problema ejecutando Consulta", vbExclamation
   
   End If
   
   If BAC_SQL_FETCH(Datos()) Then
      App.Title = Datos(1)
   
   End If
 
End Sub

 
Public Function BacCtrlTransMonto(xMonto As Variant) As String

    BacCtrlTransMonto = xMonto
    Exit Function
   
End Function

Public Function BacCtrlDesTransMonto(xMonto As Variant) As String

   Dim sCadena       As String
   Dim iPosicion     As Integer
   Dim sFormato      As String
   Dim tmpValor      As String
   
   tmpValor = xMonto
   
   If gsc_PuntoDecim = "," Then
   
      Mc = InStr(1, xMonto, ".")
      
      If Mc > 0 Then
      
         tmpValor = Mid(xMonto, 1, Mc - 1) & "," & Mid(xMonto, Mc + 1)
         
      End If
      
   End If
   
   BacCtrlDesTransMonto = Format(tmpValor, "#,###0.0000")
   
End Function

Public Sub AddParam(ByRef Arreglo As Variant, Parametro As Variant)
   
   On Error GoTo errorcuenta:
   
   Cuenta = UBound(Arreglo) + 1
   ReDim Preserve Arreglo(Cuenta)
   Arreglo(Cuenta) = Parametro
   
   Exit Sub

errorcuenta:
   
   Cuenta = 1
   Resume Next

End Sub



Public Function BacBeginTransaction() As Boolean
On Error GoTo ERRBEGIN
   BacBeginTransaction = False
        
   SqlConexion.BeginTrans
   
   BacBeginTransaction = True
   
Exit Function
ERRBEGIN:
    MsgBox "Error al iniciar transaccion : " & vbCrLf & vbCrLf & err.Description, vbOKOnly + vbExclamation
    Exit Function
    

End Function

Public Function BacRollBackTransaction() As Boolean

On Error GoTo ERRROLLBACK
   BacRollBackTransaction = False
        
   SqlConexion.RollbackTrans
   
   BacRollBackTransaction = True
   
Exit Function
ERRROLLBACK:
    MsgBox "Error al cancelar transaccion : " & vbCrLf & vbCrLf & err.Description, vbOKOnly + vbExclamation
    Exit Function

End Function

Public Function BacCommitTransaction() As Boolean

On Error GoTo ERRCOMMIT
   BacCommitTransaction = False
        
   SqlConexion.CommitTrans
   
   BacCommitTransaction = True
   
Exit Function
ERRCOMMIT:
    MsgBox "Error al concluir transaccion : " & vbCrLf & vbCrLf & err.Description, vbOKOnly + vbExclamation
    Exit Function

End Function
