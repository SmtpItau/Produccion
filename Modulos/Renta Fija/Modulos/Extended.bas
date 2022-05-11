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




'Global Configuracion As String
Global VerSql  As String
Global Envia() As Variant

Public Function Bac_Sql_Execute(Procedimiento As String, Optional Arreglo As Variant) As Boolean
Dim I As Integer
   Dim Conta As Integer, Mc
   Dim Sql As String
   On Error GoTo ErroresFuncion
   
   Bac_Sql_Execute = True
   Sql = Procedimiento
   
   If IsMissing(Arreglo) Then
   
      Conta = -1
      
   Else
   
      Conta = UBound(Arreglo)
      
   End If
            
   For I = 0 To Conta
   
      If TypeName(Arreglo(I)) = "String" Then
      
         If IsDate(Arreglo(I)) Then 'And Len(Arreglo(I)) = 8 Then
            Sql = Sql & " '" & Format(Arreglo(I), feFECHA) & "',"
         
         Else
            Sql = Sql & " '" & Arreglo(I) & "',"
         
         End If
      
      ElseIf TypeName(Arreglo(I)) = "Date" Then
         Sql = Sql & " '" & Format(Arreglo(I), feFECHA) & "',"
      
      Else
         If gsBac_PtoDec = "," Then
            
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

   VerSql = Sql

   If miSQL.SQL_Execute(Sql) <> 0 Then
      Bac_Sql_Execute = False
   End If

Exit Function
ErroresFuncion:
   
   If err.Number = 9 Then
      
      Conta = -1
      Resume Next
   
   Else
      
      MsgBox err.Description, , err.Number
      
   End If

End Function


Function Bac_SQL_Fetch(ByRef Arreglo As Variant) As Boolean
'On Error Resume Next
   Dim Datos()
   Dim I             As Integer
   Dim Conta         As Integer
   Dim Mc            As Integer
   Dim dblValor      As Double
   Dim strNumero     As String
   Dim tmpValor      As Variant
   
   Bac_SQL_Fetch = False
   
   If miSQL.SQL_Fetch(Datos) = 0 Then
      Conta = UBound(Datos)
      ReDim Arreglo(Conta)
      For I = 1 To Conta
         Bac_SQL_Fetch = True
         tmpValor = Trim(Datos(I))
         If IsNumeric(tmpValor) Then
            If gsc_PuntoDecim = "." Then
               Mc = InStr(1, tmpValor, ",")
               If Mc > 0 Then
                   tmpValor = Mid(tmpValor, 1, Mc - 1) & "." & Mid(tmpValor, Mc + 1)
               End If
            End If
         ElseIf IsDate(tmpValor) Then
            Arreglo(I) = Format(tmpValor, "DD/MM/YYYY")
         End If
         Arreglo(I) = tmpValor
      Next
   End If
   
End Function


Public Function BacCtrlTransMonto(xMonto As Variant) As String

       BacCtrlTransMonto = xMonto
   
End Function


Public Sub AddParam(ByRef Arreglo As Variant, Parametro As Variant)
   
   On Error GoTo errorcuenta:
   
   cuenta = UBound(Arreglo) + 1
   ReDim Preserve Arreglo(cuenta)
   Arreglo(cuenta) = Parametro
   
   Exit Sub

errorcuenta:
   
   cuenta = 1
   Resume Next

End Sub



Public Function BacBeginTransaction() As Boolean

   BacBeginTransaction = True
        
   If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
 
      MsgBox "Problemas al Iniciar la transacción", vbCritical, "MENSAJE"
      BacBeginTransaction = False
    
   End If

End Function

Public Function BacRollBackTransaction() As Boolean

   BacRollBackTransaction = True
        
   If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
 
      MsgBox "Problemas al Confirmar la transacción", vbCritical, "MENSAJE"
      BacRollBackTransaction = False
    
   End If

End Function

Public Function BacCommitTransaction() As Boolean

   BacCommitTransaction = True
        
   If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
 
      MsgBox "Problemas al Confirmar la transacción", vbCritical, "MENSAJE"
      BacCommitTransaction = False
    
   End If

End Function





Public Function TransMonto2(xMonto As Variant, xDec As Integer) As String

   Dim Largo As Integer
   Dim xmonto2 As String
   Largo = 0
   TransMonto = ""
   xmonto2 = ""

    For x = 1 To Len(xMonto)
        If Mid(xMonto, x, 1) = "," Then
            xMonto = xMonto & ""
            Largo = Len(Mid(xMonto, x + 1, Len(xMonto)))
         Else
            xmonto2 = xmonto2 & Mid(xMonto, x, 1)
        End If
    Next
    
    For I = 1 To (xDec - Largo)
        xmonto2 = xmonto2 & 0
    Next
    
   TransMonto2 = xmonto2
   
End Function

'--**
Public Function BacCtrlTransMonto2(xMonto As Variant) As String
  Dim tmpValor      As String
   xMonto = Format(xMonto, "#####0.000000")
   tmpValor = xMonto

   If gsBac_PtoDec = "," Then

      Mc = InStr(1, xMonto, ",")
      If Mc > 0 Then
         tmpValor = Mid(xMonto, 1, Mc - 1) & "." & Mid(xMonto, Mc + 1)
      End If

   End If

   BacCtrlTransMonto2 = tmpValor


End Function
'--**
 
