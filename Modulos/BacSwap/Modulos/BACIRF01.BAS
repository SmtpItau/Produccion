Attribute VB_Name = "BacVentana"
Option Explicit
Sub BacIrfNueVentana(ByVal sTipOper$, Optional ByVal sNomlist As Variant)

   Dim FrmOpr           As Form
   Dim sCodVentana      As String
   Dim iNumVentana%
   
   Screen.MousePointer = 11

   'Halla el número de ventana correspondiente.-
   iNumVentana% = BacIrfNumVentana(sTipOper$)
    
   If iNumVentana% = 0 Then
      Screen.MousePointer = 0
      Exit Sub
    
   End If
    
   'Asigna el form dependiendo del tipo
   Select Case Mid$(sTipOper$, 1, 4)
   Case "SWTA"
      Set FrmOpr = New BacOpeSwapTasaULT
      sCodVentana = "SWT"
      Tipo_Producto = "ST"
      MiTipoSwapTasa = [Swap de Tasas]
   
   Case "SWMN"
      Set FrmOpr = New BacOpeSwapMonedaULT
      sCodVentana = "SWM"
      Tipo_Producto = "SM"

   Case "FRAN"
      Set FrmOpr = New FRM_SWAP_OP_FRA 'bacOpeFRA
      sCodVentana = "FRA"
      Tipo_Producto = "FR"
   Case "SPCA"
      Set FrmOpr = New BacOpeSwapTasaULT
      sCodVentana = "SPC"
      Tipo_Producto = "SP"
      MiTipoSwapTasa = [Swap Promedio Camara]
   
   Case Else
      Screen.MousePointer = 0
      Exit Sub
   End Select

   'Asigna el Tag para identificar al Form
   FrmOpr.Tag = sTipOper$ & Format$(iNumVentana%, "00") & sCodVentana

   'Setean el Caption del form para la ventana correspondiente
   Select Case Mid$(sTipOper$, 1, 4)
   Case "SWTA"
      FrmOpr.Caption = iNumVentana% & ".- Swap de Tasas"

   Case "SWMN"
      FrmOpr.Caption = iNumVentana% & ".- Swap de Monedas"
      
   Case "FRAN"
      FrmOpr.Caption = iNumVentana% & ".- Forward Rate Agreements"
    
   Case "SPCA"
      FrmOpr.Caption = iNumVentana% & ".- Swap Promedio Camara"
      
   End Select
    
   FrmOpr.Show 'vbNormal%
    
   Screen.MousePointer = 0
   
End Sub
'--------------------------------------------------------------------------
'Calcula el numero de ventana que corresponde
'En el Tag de guarda el tipo de ventana (Ej.: CP,CI,...) mas el correlativo
'de la ventana (CP01,CI03)
'De hecho el gcNumeroMaximo de ventanas debe ser menor a 10 y mayor a uno
'Devuelve 0 si excedió el numero maximo de ventanas
'-------------------------------------------------------------------------
Function BacIrfNumVentana(sTipOper$) As Integer
 
   Dim I%
   Dim iNumVentanas%
   Dim iUltVentana%
   Dim cInfo$

   iNumVentanas% = 0
   
   For I% = 1 To Forms.Count
      
      cInfo$ = Forms(I% - 1).Tag
      
      If Mid$(cInfo$, 1, 5) = sTipOper$ Then
         iNumVentanas% = iNumVentanas% + 1
         iUltVentana% = Val(Mid$(cInfo$, 6, 2))

      End If
   
   Next I%
    
   If iNumVentanas% > gcMaximoVentanas Then
      MsgBox "NUMERO MAXIMO DE VENTANAS ABIERTAS EXCEDIDO", 48, "MENSAJE"
      BacIrfNumVentana = 0
      
   Else
      If iNumVentanas% = 0 Then
         BacIrfNumVentana = 1
         
      Else
         BacIrfNumVentana = iUltVentana% + 1
         
      End If
           
   End If

End Function
Public Sub BacIrfSelCartera()

'   Dim i%
'   For i% = 1 To Forms.Count - 1

'      If Forms(i%).name = "BacDI" Then
      
'         BacIrfSl.Show vbModal%
'         Exit Sub
      
'      End If

'   Next
   
'   BacDI.Show vbNormal%

End Sub


