Attribute VB_Name = "Bacreportes"
Option Explicit

Sub Imprimir_Papeletas(Tipoper As String, Numoper As Double, Destino As Integer, Mensaje As String)
    On Error GoTo ErrorImpPapeletas 'JBH, 29-10-2009
    Call limpiar_cristal
   
    BAC_INVERSIONES.BacRpt.Destination = Destino
    Select Case Tipoper
        Case "CP"
        BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "PAPELE_COMPRA.RPT"
        BAC_INVERSIONES.BacRpt.WindowTitle = "COMPRA DE INSTRUMENTOS"
        
        BAC_INVERSIONES.BacRpt.StoredProcParam(0) = "CP"
        BAC_INVERSIONES.BacRpt.StoredProcParam(1) = Numoper
        BAC_INVERSIONES.BacRpt.StoredProcParam(2) = GLB_LIBRO
        BAC_INVERSIONES.BacRpt.StoredProcParam(3) = GLB_CARTERA_NORMATIVA
        BAC_INVERSIONES.BacRpt.StoredProcParam(4) = GLB_CARTERA
        
        BAC_INVERSIONES.BacRpt.Connect = CONECCION
        BAC_INVERSIONES.BacRpt.Action = 1
    
        Case "VP"
        BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "PAPELE_VENTA.RPT"
        BAC_INVERSIONES.BacRpt.WindowTitle = "VENTA DE INSTRUMENTOS"
        
        BAC_INVERSIONES.BacRpt.StoredProcParam(0) = "VP"
        BAC_INVERSIONES.BacRpt.StoredProcParam(1) = CDbl(Numoper)
        BAC_INVERSIONES.BacRpt.StoredProcParam(2) = GLB_LIBRO
        BAC_INVERSIONES.BacRpt.StoredProcParam(3) = GLB_CARTERA_NORMATIVA
        BAC_INVERSIONES.BacRpt.StoredProcParam(4) = GLB_CARTERA
        
        BAC_INVERSIONES.BacRpt.Connect = CONECCION
        BAC_INVERSIONES.BacRpt.Action = 1
        
        Case "CPI"  'Compras Intramesas
            BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "PAPELE_COMPRAIM.RPT"
            BAC_INVERSIONES.BacRpt.WindowTitle = "COMPRA DE TICKETS INTRAMESAS"
    
            BAC_INVERSIONES.BacRpt.StoredProcParam(0) = "CP"
            BAC_INVERSIONES.BacRpt.StoredProcParam(1) = Numoper
            BAC_INVERSIONES.BacRpt.StoredProcParam(2) = GLB_LIBRO
            BAC_INVERSIONES.BacRpt.StoredProcParam(3) = GLB_CARTERA_NORMATIVA
            BAC_INVERSIONES.BacRpt.StoredProcParam(4) = GLB_CARTERA
            BAC_INVERSIONES.BacRpt.StoredProcParam(5) = "245"
    
            BAC_INVERSIONES.BacRpt.Connect = CONECCION
            BAC_INVERSIONES.BacRpt.Action = 1
        
        Case "VPI"  'Ventas Intramesas
            BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "PAPELE_VENTAIM.RPT"
            BAC_INVERSIONES.BacRpt.WindowTitle = "VENTA DE TICKETS INTRAMESAS"
    
            BAC_INVERSIONES.BacRpt.StoredProcParam(0) = "VP"
            BAC_INVERSIONES.BacRpt.StoredProcParam(1) = CDbl(Numoper)
            BAC_INVERSIONES.BacRpt.StoredProcParam(2) = GLB_LIBRO
            BAC_INVERSIONES.BacRpt.StoredProcParam(3) = GLB_CARTERA_NORMATIVA
            BAC_INVERSIONES.BacRpt.StoredProcParam(4) = GLB_CARTERA
            BAC_INVERSIONES.BacRpt.StoredProcParam(5) = "245"
            BAC_INVERSIONES.BacRpt.Connect = CONECCION
            BAC_INVERSIONES.BacRpt.Action = 1
        
        
    End Select

'    If Tipoper = "CP" Then
''        BAC_INVERSIONES.BacRpt.pr
'        BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "PAPELE_COMPRA.RPT"
'        BAC_INVERSIONES.BacRpt.WindowTitle = "COMPRA DE INSTRUMENTOS"
'
'        BAC_INVERSIONES.BacRpt.StoredProcParam(0) = "CP"
'        BAC_INVERSIONES.BacRpt.StoredProcParam(1) = Numoper
'        BAC_INVERSIONES.BacRpt.StoredProcParam(2) = GLB_LIBRO
'        BAC_INVERSIONES.BacRpt.StoredProcParam(3) = GLB_CARTERA_NORMATIVA
'        BAC_INVERSIONES.BacRpt.StoredProcParam(4) = GLB_CARTERA
'
'        BAC_INVERSIONES.BacRpt.Connect = CONECCION
'        BAC_INVERSIONES.BacRpt.Action = 1
'
'    Else
'        BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "PAPELE_VENTA.RPT"
'        BAC_INVERSIONES.BacRpt.WindowTitle = "VENTA DE INSTRUMENTOS"
'
'        BAC_INVERSIONES.BacRpt.StoredProcParam(0) = "VP"
'        BAC_INVERSIONES.BacRpt.StoredProcParam(1) = CDbl(Numoper)
'        BAC_INVERSIONES.BacRpt.StoredProcParam(2) = GLB_LIBRO
'        BAC_INVERSIONES.BacRpt.StoredProcParam(3) = GLB_CARTERA_NORMATIVA
'        BAC_INVERSIONES.BacRpt.StoredProcParam(4) = GLB_CARTERA
'
'        BAC_INVERSIONES.BacRpt.Connect = CONECCION
'        BAC_INVERSIONES.BacRpt.Action = 1
'    End If

    
    Call limpiar_cristal
    Exit Sub
ErrorImpPapeletas:
    If Dir(BAC_INVERSIONES.BacRpt.ReportFileName, vbArchive) = "" Then
        MsgBox "Atención! falta el archivo: " & BAC_INVERSIONES.BacRpt.ReportFileName, vbCritical, gsBac_Version
    Else
        MsgBox "Se ha producido el siguiente error: " & err.Description, vbCritical, gsBac_Version
    End If


End Sub



Function imp_fax(Numope, Tipoper)
    If giAceptar Then

        Call limpiar_cristal
    
        Screen.MousePointer = 11
        BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "Fax_confirmacion.rpt"
        BAC_INVERSIONES.BacRpt.WindowTitle = "FAX DE CONFIRMACIÓN"
        BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Tipoper
        BAC_INVERSIONES.BacRpt.StoredProcParam(1) = Numope
        BAC_INVERSIONES.BacRpt.StoredProcParam(2) = telefono_Bech
        BAC_INVERSIONES.BacRpt.StoredProcParam(3) = Fax_Bech
        BAC_INVERSIONES.BacRpt.StoredProcParam(4) = telefono_Contra
        BAC_INVERSIONES.BacRpt.StoredProcParam(5) = Fax_Contra
        BAC_INVERSIONES.BacRpt.Destination = gsBac_Papeleta
        BAC_INVERSIONES.BacRpt.Connect = CONECCION
        BAC_INVERSIONES.BacRpt.Action = 1
    
        Screen.MousePointer = 0
        
        Call limpiar_cristal

    End If
End Function

