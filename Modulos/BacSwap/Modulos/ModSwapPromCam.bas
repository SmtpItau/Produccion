Attribute VB_Name = "ModSwapPromCam"
Option Explicit
Public Const ICP = 800
Public Const Base = 360

Public Enum SwapTasasAs
   [Swap de Tasas] = 1
   [Swap Promedio Camara] = 4
End Enum
Global MiTipoSwapTasa   As SwapTasasAs

Public Function ChequeaICPdelDia() As Boolean
   Dim iValorICP  As Double
   ChequeaICPdelDia = False
   iValorICP = ValorMoneda(ICP, gsBAC_Fecp)
   
   If iValorICP <> 0# Then
      ChequeaICPdelDia = True
   End If
End Function

Public Function iValorIndiceCamaraPromedio() As Double
   iValorIndiceCamaraPromedio = ValorMoneda(ICP, gsBAC_Fecp)
End Function

Public Function iValorTasaCamaraPromedio(iMoneda As Integer) As Double
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(iMoneda)
   If Not Bac_Sql_Execute("SRV_CALCULO_TPCA", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) = -1 Then
         iValorTasaCamaraPromedio = Format(0#, "###0.0000000000")
         iValorTasaCamaraPromedio = Datos(0)
         MsgBox "Calculo No Realizado." & vbCrLf & vbCrLf & Datos(2), vbExclamation, TITSISTEMA
      Else
         iValorTasaCamaraPromedio = Format(Datos(1), "###0.0000000000")
         iValorTasaCamaraPromedio = Datos(1)
      End If
   End If
   
End Function

Function Leer_Registro(Nombre_App As String, Seccion As String, Llave As String) As String
   Leer_Registro = ""
   Leer_Registro = GetSetting(Nombre_App, Seccion, Llave)
End Function
Function Escribir_Registro(Nombre_App As String, Seccion As String, Llave As String, Valor As Variant)
   SaveSetting Nombre_App, Seccion, Llave, Valor
End Function

