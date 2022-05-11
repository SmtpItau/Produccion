Attribute VB_Name = "BacModContratosDerivados"
Public Function CargaTipContrato(Combo As ComboBox)
    Dim Datos()
    
    If Not Bac_Sql_Execute("SP_TRAECONTRATO") Then
        MsgBox "Problemas al Intentar llanar el combo", vbExclamation + vbOKOnly
        Exit Function
    End If
    
    Combo.Clear

    Do While Bac_SQL_Fetch(Datos())
        Combo.AddItem Datos(2) & Space(80) & Datos(1)
    Loop
    
    If Combo.ListCount > 0 Then
        Combo.ListIndex = -1
    End If
End Function

Public Function DevuelveDV(rut As String) As String

   Dim i       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim Digito  As String
   Dim Multi   As Double

   BacDevuelveDig = ""

   rut = Format(rut, "000000000")
   D = 2
   Suma = 0
   For i = 9 To 1 Step -1
      Multi = Val(Mid$(rut, i, 1)) * D
     Suma = Suma + Multi
      D = D + 1
      
      If D = 8 Then
         D = 2
      
      End If
   Next i
    
   Divi = (Suma \ 11)
   Multi = Divi * 11
   Digito = Trim$(Str$(11 - (Suma - Multi)))
    
   If Digito = "10" Then
      Digito = "K"
   
   End If
    
   If Digito = "11" Then
      Digito = "0"
   
   End If
    
   BacDevuelveDig = UCase(Digito)

End Function

