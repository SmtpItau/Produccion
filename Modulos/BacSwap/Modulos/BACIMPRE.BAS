Attribute VB_Name = "BacImpresion"
Option Explicit
Public ObjConsulta      As Object
Function ImprimePapeleta(NroOperacion, OrigenDatos, Donde, TipSwap) As Boolean

    On Error GoTo Control
    
    Call BacLimpiaParamCrw
    
    If gsBac_QUEDEF <> gsBac_IMPWIN Then ' And tipo = 1 Then
        Call ActArcIni(gsBac_QUEDEF)
    End If
    
    ImprimePapeleta = False
    
    With BACSwap.Crystal
    
        If Donde = "Pantalla" Then
            .Destination = crptToWindow  'Vista previa pantalla
        Else
            .Destination = crptToPrinter   'Directo a Impresora
        End If
        
        Select Case TipSwap
            
            Case 1
                .ReportFileName = gsRPT_Path & "BacPapeletaTasa.rpt"
                .WindowTitle = "Papeleta Swap de Tasas"
                .StoredProcParam(0) = Val(NroOperacion)
                .StoredProcParam(1) = GLB_LIBRO
                .StoredProcParam(2) = GLB_CARTERA_NORMATIVA
                .StoredProcParam(3) = GLB_SUB_CARTERA_NORMATIVA
                .StoredProcParam(4) = GLB_CARTERA
                .StoredProcParam(5) = GLB_AREA_RESPONSABLE
                
            Case 2
                .ReportFileName = gsRPT_Path & "BacPapeletaMon.rpt"
                .WindowTitle = "Papeleta Swap de Moneda"
                .StoredProcParam(0) = Val(NroOperacion)
                .StoredProcParam(1) = GLB_LIBRO
                .StoredProcParam(2) = GLB_CARTERA_NORMATIVA
                .StoredProcParam(3) = GLB_SUB_CARTERA_NORMATIVA
                .StoredProcParam(4) = GLB_CARTERA
                .StoredProcParam(5) = GLB_AREA_RESPONSABLE
              
            Case 3
            
                .ReportFileName = gsRPT_Path & "PapeletaFra.rpt"
                .WindowTitle = "Papeleta Forward Rate Agreements"
               .StoredProcParam(0) = NroOperacion
            
            Case 4
                .ReportFileName = gsRPT_Path & "BacPapeletaTasa.rpt"
                .WindowTitle = "Papeleta Swap promedio Camara."
                .StoredProcParam(0) = Val(NroOperacion)
               
            Case Else
                MsgBox "Papeleta no definida para este producto", vbExclamation
                Exit Function
            
        End Select
        
        .Connect = swConeccion
        
        .Action = 1 'Envio
        
         If gsBac_QUEDEF <> gsBac_IMPWIN Then ' And tipo = 1 Then
            Call ActArcIni(gsBac_IMPWIN)
         End If
        
        ImprimePapeleta = True
    
    End With
    
    Exit Function

Control:
    
    MsgBox BACSwap.Crystal.LastErrorString, vbCritical, Msj

End Function

Public Function BacLeeCapituloIX_A3(Mes, Year)
    On Error GoTo Control
    
    Call BacLimpiaParamCrw

    With BACSwap.Crystal
      .Destination = crptToWindow  'Vista previa pantalla
      .ReportFileName = gsRPT_Path & "baccap9anexo3.rpt"
      .WindowTitle = "Capitulo IX Anexo 3"
      .StoredProcParam(0) = Mes
      .StoredProcParam(1) = Year
      .StoredProcParam(2) = CDbl(Bac_Apoderados.Txt_Rut1)
      .Connect = swConeccion
      .Action = 1
    End With

    Exit Function

Control:
    
    MsgBox BACSwap.Crystal.LastErrorString, vbCritical, Msj
End Function

