Attribute VB_Name = "Global_Accesos"

Sub PROC_CARGA_TIPO_USUARIO(Combo As Object)
Dim Datos()

Envia = Array("T", "")

If Not BAC_SQL_EXECUTE("SP_BUSCA_ACCESO_USUARIO", Envia) Then Exit Sub

Combo.Clear

Do While BAC_SQL_FETCH(Datos)

   Combo.AddItem Datos(1)

Loop

     
End Sub


Sub PROC_CARGA_USUARIO(Combo As Object)
Dim Datos()
Dim digitos As String
Dim sw As Integer

digitos = "123456789"

Envia = Array("U", "")

If Not BAC_SQL_EXECUTE("SP_BUSCA_ACCESO_USUARIO", Envia) Then Exit Sub

Combo.Clear

Do While BAC_SQL_FETCH(Datos)
     
   sw = 0
   
'   For i = 1 To Len(digitos)
'
'        If Right(Datos(1), 1) = Mid(digitos, i, 1) Then
'
'            sw = 1
'
'        End If
'
'   Next i
   
   If sw <> 1 Then Combo.AddItem Datos(1)
   
Loop

End Sub

Sub PROC_CARGA_SISTEMAS(Combo As Object)
Dim Datos()

Envia = Array("S")

If Not BAC_SQL_EXECUTE("SP_BUSCA_ACCESO_USUARIO", Envia) Then Exit Sub

Combo.Clear

Do While BAC_SQL_FETCH(Datos)

   Combo.AddItem Datos(1)

Loop

End Sub

Function Valida_Configuracion_Regional() As Boolean

    Valida_Configuracion_Regional = False
    
    If CStr(Format(CDate("31/12/2000"), feFECHA)) <> Format("31/12/2000", feFECHA) Then
       
       Exit Function
    
    End If
    
    Valida_Configuracion_Regional = True

End Function


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

 
