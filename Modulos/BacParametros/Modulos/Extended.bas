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

Public Function Bac_Sql_Execute(Procedimiento As String, Optional Arreglo As Variant) As Boolean
   Dim i As Integer
   Dim Conta As Integer, Mc
   Dim SQL As String
   On Error GoTo ErroresFuncion
   Bac_Sql_Execute = True
   SQL = Procedimiento
   

   
   If IsMissing(Arreglo) Then
   
      Conta = -1
      
   Else
   
      Conta = UBound(Arreglo)
      
   End If
            
   For i = 0 To Conta
      
      If TypeName(Arreglo(i)) = "String" Then
      
         If IsDate(Arreglo(i)) And Len(Arreglo(i)) >= 8 Then
         
            SQL = SQL & " '" & Format(Arreglo(i), feFecha) & "',"
            
         Else
         
            SQL = SQL & " '" & Arreglo(i) & "',"
            
         End If
         
         
      ElseIf TypeName(Arreglo(i)) = "Date" Then
         
         SQL = SQL & " '" & Format(Arreglo(i), feFecha) & "',"
            
      Else
         
         If gsc_PuntoDecim = "," Then
            
            Mc = InStr(1, Arreglo(i), ",")
            
            If Mc > 0 Then
                
                Arreglo(i) = Mid(Arreglo(i), 1, Mc - 1) & "." & Mid(Arreglo(i), Mc + 1)
            
            End If
         
         End If
         
         SQL = SQL & " " & Arreglo(i) & ","
      
      End If
      
   Next i
      
   If Conta > -1 Then
      
      SQL = Mid(SQL, 1, Len(SQL) - 1)
      
   End If
      
   VerSql = SQL
'   MsgBox VerSql
'  Debug.Print VerSql

   If MISQL.SQL_Execute(SQL) <> 0 Then
      
      Bac_Sql_Execute = False
   
  End If
   
   Exit Function

ErroresFuncion:
   
   If Err.Number = 9 Then
      
      Conta = -1
      Resume Next
   
   Else
      
      MsgBox Err.Description, , Err.Number
      
   End If

End Function


Function Bac_SQL_Fetch(ByRef Arreglo As Variant) As Boolean
'On Error Resume Next
   Dim Datos()
   Dim i             As Integer
   Dim Conta         As Integer
   Dim Mc            As Integer
   Dim dblValor      As Double
   Dim strNumero     As String
   Dim tmpValor      As Variant
   
   Bac_SQL_Fetch = False
   
   If MISQL.SQL_Fetch(Datos) = 0 Then
      Conta = UBound(Datos)
      ReDim Arreglo(Conta)
      For i = 1 To Conta
         Bac_SQL_Fetch = True
         tmpValor = Trim(Datos(i))
         If IsNumeric(tmpValor) Then
            If gsc_PuntoDecim = "," Then
               Mc = InStr(1, tmpValor, ".")
               If Mc > 0 Then
                   tmpValor = Mid(tmpValor, 1, Mc - 1) & "." & Mid(tmpValor, Mc + 1)
               End If
            End If
         ElseIf IsDate(tmpValor) Then
            Arreglo(i) = Format(tmpValor, "DD/MM/YYYY")
         ElseIf IsNull(tmpValor) Then
            tmpValor = ""
         End If
         
         Arreglo(i) = tmpValor
      Next
   End If
   
End Function


Public Function BacCtrlTransMonto(xMonto As Variant) As String

   Dim sCadena       As String
   Dim iPosicion     As Integer
   Dim sFormato      As String
   Dim tmpValor      As String
   
   xMonto = Format(xMonto, "#####0.0000")
   
   tmpValor = xMonto
   
   If gsc_PuntoDecim = "," Then
   
      Mc = InStr(1, xMonto, ",")
      
      If Mc > 0 Then
      
         tmpValor = Mid(xMonto, 1, Mc - 1) & "." & Mid(xMonto, Mc + 1)
         
      End If
      
   End If
   
   BacCtrlTransMonto = tmpValor
   
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
