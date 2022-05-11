Attribute VB_Name = "Nuevos"
Option Explicit

Global TipVent  As String
Global FecInip  As String
Global UmInip   As String
Global ValInip  As String
Global TasaP    As String
Global PlazoP   As String
Global BaseP    As String
Global MonedaP  As String
Global FecVenp  As String
Global UmVenp   As String
Global ValVenp  As String
Global Rutcart  As String
Global DvCart   As String
Global NomCart  As String
Global rutcli   As String
Global DvCli    As String
Global codcli   As String
Global NomCli   As String
Global GloCart  As String
Global lNumoper As String
Global RutCart1 As String
Global TipCart  As String
Global ValMon   As Double

' Validacion Grabacion

Global Grabacion_Operacion As Boolean

' Declaro constantes para controlar switch de sistemas

Global Const ACSW_PD = 1
Global Const ACSW_RC = 2
Global Const ACSW_RV = 3
Global Const ACSW_CO = 4
Global Const ACSW_DV = 5
Global Const ACSW_CM = 6
Global Const ACSW_MESA = 7
Global Const ACSW_PC = 8
Global Const ACSW_FD = 9
Global Const ACSW_finmes = 10
Global Const varGsMsgOpen = "Apertura de Mesa no se ha realizado"
Global Const varGsMsgCierre = "Cierre de mesa no se ha realizado"
Global Const varGsMsgRC = "Proceso de recompras no se ha realizado"
Global Const varGsMsgRV = "Proceso de reventas no se ha realizado"
Global Const varGsMsgPD = "Parametros Diarios no han sido Ingresados"
Global Const varGsMsgPC = "Procesos de Cierre ya se Iniciaron"
Global Const varGsMsgDV = "Devengamiento ya fue Realizado"
Global Const varGsMsgFD = "Fin de día no ha sido realizado, verifique secuencia de procesos"


Public Function Controla_RUT(tex As Control, tex1 As Control) As Boolean
   Dim Valida As Integer
   Dim idRut$, IdDig$

   idRut$ = tex1
   IdDig$ = tex1

   Valida = True

   If Trim$(idRut$) = "" Or Trim$(IdDig$) = "" Or (Trim$(idRut$) = "0" And Trim$(IdDig$) = "") Then
      Valida = False
   End If
    
   If ValidaRut(tex.Text) <> tex1.Text Then
      Valida = False
   End If

   Controla_RUT = Valida

End Function


Function ActArcIni(cString As String) As Integer
    
        ActArcIni = WriteINI("windows", "device", cString, "win.ini")
    
End Function

Function RoundBac(nDato As Double, nPos As Integer) As Double
Dim iPospto%, cDato$, nDecpos1%, nDecpos2%
Dim nNum1#, nNum2#
Dim cPto$
Dim nPosres%
    
    nDecpos1 = 0
    cDato = LTrim(RTrim(Str(nDato)))
    cPto = IIf(gsc_PuntoDecim = ",", ".", ",")
    iPospto = InStr(1, cDato, cPto)
    If nPos > 0 Then
        nDecpos2 = Val(Mid(cDato, iPospto + nPos + 1, 1))
        nDecpos1 = Val(Mid(cDato, iPospto + nPos, 1))
        If nDecpos2 > 4 Then nDecpos1 = nDecpos1 + 1
        nPosres% = Len(Mid(cDato, 1, iPospto) + Mid(cDato, iPospto + 1, nPos - 1))
        cDato = Mid(cDato, 1, nPosres) + LTrim(RTrim(Str(nDecpos1)))
    Else
        nDecpos2 = Val(Mid(cDato, iPospto + nPos + 1, 1))
        If nDecpos2 > 4 Then nDecpos1 = 1
        'RoundBac = Val(Mid(cDato, 1, iPospto - 1)) + nDecpos1
        RoundBac = Val(Mid(cDato, 1, iPospto)) + nDecpos1
    End If

End Function





Public Function BACValIngNumGrid(ByVal KeyValue As Integer) As Integer
'   Function    :   BACValIngNumGrid
'   Objetivo    :   Valida el ingreso de no numericos en la grillas
'   Autor       :   Victor Barra
'   Fecha       :   Febrero 2000
'==============================================================================
    
    If Not IsNumeric(Chr(KeyValue)) And (KeyValue <> 44 And KeyValue <> 46 And KeyValue <> 8 And KeyValue <> 45) Then
        KeyValue = 0
    End If
    
    BACValIngNumGrid = KeyValue
    
End Function

Public Function BuscaGlosa(obj As Object, CODI As String) As Long
Dim f   As Long
Dim Max As Long
        
    BuscaGlosa = -1
    Max = obj.coleccion.Count
            
    For f = 1 To Max
        If Trim$(obj.coleccion(f).glosa) = Trim(CODI) Then
            BuscaGlosa = f - 1
            Exit For
        End If
    Next f
            
End Function

'Public Sub BacGrabarTX()
'Dim sWinTipo$
'Dim sPasa$
'Dim iContador   As Integer
'Dim iConta      As Integer
'
'    Set BacFrmIRF = BAC_Parametros.ActiveForm
'
'    If Chequear_MesaIng() = False Then
'         Exit Sub
'    End If
'
'    sWinTipo$ = Mid$(BacFrmIRF.Tag, 1, 2)
'
'    sPasa = True
'    iContador = 0
'
'    If sWinTipo$ = "RC" Or sWinTipo$ = "RV" Or sWinTipo$ = "AC" Then
'        If Val(BacFrmIRF.TxtTasaAnt.Text) <= 0 Then
'            MsgBox "Debe aplicar tasa de descuento para grabar anticipo de pacto.", vbCritical, gsBac_Version
'            sPasa = False
'        End If
'    End If
'
'    If sWinTipo$ = "CP" Or sWinTipo$ = "CI" Or sWinTipo$ = "VP" Or sWinTipo$ = "VI" Or sWinTipo$ = "RC" Or sWinTipo$ = "RV" Or sWinTipo$ = "IB" Or sWinTipo$ = "ST" Or sWinTipo$ = "IC" Or sWinTipo$ = "AC" Then
'
'       If sWinTipo$ = "IB" Then
'
'          If Val(BacFrmIRF.FltMtoini.Text) = 0 Then
'             MsgBox "Debe Ingresar Monto Inicial.", vbCritical, gsBac_Version
'             Exit Sub
'          End If
'
'          If Val(BacFrmIRF.FltTasa.Text) = 0 Then
'             MsgBox "Debe Ingresar Tasa.", vbCritical, gsBac_Version
'             Exit Sub
'          End If
'
'          If Val(BacFrmIRF.IntBase.Text) = 0 Then
'             MsgBox "Debe Ingresar Base.", vbCritical, gsBac_Version
'             Exit Sub
'          End If
'
'          If Val(BacFrmIRF.Lbl_Mt_Final.Caption) = 0 Then
'             MsgBox "Operación No Tiene Monto Final.", vbCritical, gsBac_Version
'             Exit Sub
'          End If
'
'       End If
'
'     ' Verifica que la Grilla no este vacia CP CI
'        If sWinTipo$ = "CP" Or sWinTipo$ = "CI" Then
'            BacFrmIRF.Data1.Recordset.MoveFirst
'            Do While Not BacFrmIRF.Data1.Recordset.EOF
'              ' Verifica que el registro esté con datos
'                If Trim$(BacFrmIRF.Data1.Recordset("tm_instser")) <> "" Then
'                    iContador = iContador + 1
'                End If
'                BacFrmIRF.Data1.Recordset.MoveNext
'            Loop
'            If iContador = 0 Then
'                sPasa = False
'                MsgBox "No Existen Registros a Grabar.", vbCritical, gsBac_Version
'            End If
'            BacFrmIRF.Data1.Recordset.MoveFirst
'        End If
'
'       ' Verifica que la Grilla no este vacia VP VI
'       ' Verifica Los Valores Presentes y tir venta VP VI
'
'        iContador = 0
'        iConta = 0
'        If sWinTipo$ = "VP" Or sWinTipo$ = "VI" Or sWinTipo$ = "ST" Then
'            If BacFrmIRF.Data1.Recordset.RecordCount > 0 Then
'                 BacFrmIRF.Data1.Recordset.MoveFirst
'                Do While Not BacFrmIRF.Data1.Recordset.EOF
'                    If BacFrmIRF.Data1.Recordset("tm_venta") = "P" Or BacFrmIRF.Data1.Recordset("tm_venta") = "V" Then
'                        iContador = iContador + 1
'                        If BacFrmIRF.Data1.Recordset("tm_vp") = 0 Or BacFrmIRF.Data1.Recordset("tm_tir") = 0 Then
'                            iConta = iConta + 1
'                        End If
'                    End If
'                    BacFrmIRF.Data1.Recordset.MoveNext
'                Loop
'                If iContador = 0 Then
'                    sPasa = False
'                    MsgBox "No Existen Documentos Asignados para Grabar.", vbCritical, gsBac_Version
'                End If
'            Else
'                sPasa = False
'                MsgBox "No Existen Registros Marcados para Grabar.", vbCritical, gsBac_Version
'            End If
'
'            If iConta > 0 Then
'                sPasa = False
'                MsgBox "Existen Registros con Valores en Cero.", vbCritical, gsBac_Version
'            End If
'
'        End If
'
'     ' Verifica Los Valores Presentes CP CI
'       iContador = 0
'       If sPasa = True And (sWinTipo$ = "CP" Or sWinTipo$ = "CI") Then
'          BacFrmIRF.Data1.Recordset.MoveFirst
'          Do While Not BacFrmIRF.Data1.Recordset.EOF
'             'Verifica que el registro esté con datos
'             If BacFrmIRF.Data1.Recordset("tm_mt") = 0 Then
'                iContador = iContador + 1
'             End If
'             BacFrmIRF.Data1.Recordset.MoveNext
'          Loop
'
'          If iContador <> 0 Then
'             sPasa = False
'             MsgBox "Existen Registros con Valores en Cero.", vbCritical, gsBac_Version
'          End If
'          BacFrmIRF.Data1.Recordset.MoveFirst
'       End If
'
'     ' Valido Emisores para los papeles
'       iContador = 0
'       If sPasa = True And (sWinTipo$ = "CP" Or sWinTipo$ = "CI") Then
'          BacFrmIRF.Data1.Recordset.MoveFirst
'          Do While Not BacFrmIRF.Data1.Recordset.EOF
'             'Verifica que el registro esté con datos
'             If BacFrmIRF.Data1.Recordset("tm_rutemi") = 0 Then
'                iContador = iContador + 1
'             End If
'             BacFrmIRF.Data1.Recordset.MoveNext
'          Loop
'
'          If iContador <> 0 Then
'             sPasa = False
'             MsgBox "Existen Registros sin emisores asociados.", vbCritical, gsBac_Version
'          End If
'          BacFrmIRF.Data1.Recordset.MoveFirst
'       End If
'
'       ' Verifica Fechas de disponibilidad En VI
'
'        iContador = 0
'        If sPasa = True And (sWinTipo$ = "VI") Then
'            BacFrmIRF.Data1.Recordset.MoveFirst
'            Do While Not BacFrmIRF.Data1.Recordset.EOF
'                If BacFrmIRF.Data1.Recordset("tm_venta") = "P" Or BacFrmIRF.Data1.Recordset("tm_venta") = "V" Then
'                    If CDate(BacFrmIRF.Data1.Recordset("tm_fecsal")) < CDate(BacFrmIRF.TxtFecVct.Text) Then
'                        MsgBox "Instrumento " + BacFrmIRF.Data1.Recordset("tm_instser") + " No Disponible a la Fecha Vcto. Venta Pacto.", vbCritical, gsBac_Version
'                        iContador = iContador + 1
'                    End If
'                End If
'                BacFrmIRF.Data1.Recordset.MoveNext
'            Loop
'            If iContador <> 0 Then
'                sPasa = False
'            End If
'        End If
'
'      ' Realizo validación de papeles no BCCH y plazo pacto sea mayor a DIAS_PACTO_PAPEL_NO_CENTRAL
'        If sPasa = True And ((sWinTipo$ = "VI") Or (sWinTipo$ = "CI")) Then
'            If BacFrmIRF.txtplazo.Text < DIAS_PACTO_PAPEL_NO_CENTRAL Then
'                BacFrmIRF.Data1.Recordset.MoveFirst
'                Do While Not BacFrmIRF.Data1.Recordset.EOF
'
'                    If sWinTipo$ = "VI" Then
'                        If BacFrmIRF.Data1.Recordset("tm_venta") = "V" Then
'                            If CDbl(BacFrmIRF.Data1.Recordset("tm_rutemi")) <> 97029000 Then
'                                sPasa = False
'                                Exit Do
'                            End If
'                        End If
'                    Else
'                        If CDbl(BacFrmIRF.Data1.Recordset("tm_rutemi")) <> 97029000 Then
'                            sPasa = False
'                            Exit Do
'                        End If
'                    End If
'                    BacFrmIRF.Data1.Recordset.MoveNext
'                Loop
'                If sPasa = False Then
'                    MsgBox "Pacto contiene papeles que no son emitidos por el Banco Central." & vbCrLf & vbCrLf & "Plazo pacto es menor a " & DIAS_PACTO_PAPEL_NO_CENTRAL & ". No se puede realizar esta operación.", vbExclamation, gsBac_Version
'                End If
'            End If
'        End If
'
'        If sPasa = True And (sWinTipo$ = "VI" Or sWinTipo$ = "CI") Then
'           If BacFrmIRF.TxtTasa.Text = 0 Then
'              MsgBox "Falta Tasa del Pacto.", 16
'              sPasa = False
'           End If
'        End If
'
'      ' Chequeo de Ventas y Compras con Pacto con Pago de Cupon Durante el Pacto
'      ' VB+- 15/05/2000 se cambio validacion, que sea valida solamamente para las compras con pacto
'        If sPasa = True And (sWinTipo$ = "CI") Then
'      ' If sPasa = True And (sWinTipo$ = "VI" Or sWinTipo$ = "CI") Then
'
'            If BacFrmIRF.TxtTasa.Text = 0 Then
'               MsgBox "Falta Tasa del Pacto.", 16
'               sPasa = False
'            End If
'
'            BacFrmIRF.Data1.Recordset.MoveFirst
'            If sWinTipo$ = "CI" Then
'                Do While Not BacFrmIRF.Data1.Recordset.EOF
'                    'If (CDate(BacFrmIRF.Data1.Recordset("tm_fecpcup")) < CDate(BacFrmIRF.TxtFecVct.Text)) And (Mid$(BacFrmIRF.Data1.Recordset("tm_instser"), 1, 3) <> "PCD" And Mid$(BacFrmIRF.Data1.Recordset("tm_instser"), 1, 3) <> "PRD") Then
'                     '   sPasa = False
'                     '   MsgBox BacFrmIRF.Data1.Recordset("tm_instser") + " Tiene Vencimiento Durante el Pacto.", vbCritical, gsBac_Version
'                    'End If
'                    ' lo elimine yo el david dio la idea
'                    BacFrmIRF.Data1.Recordset.MoveNext
'                Loop
'            Else
'                Do While Not BacFrmIRF.Data1.Recordset.EOF
'                    If BacFrmIRF.Data1.Recordset("tm_venta") = "P" Or BacFrmIRF.Data1.Recordset("tm_venta") = "V" Then
'                        If (CDate(BacFrmIRF.Data1.Recordset("tm_fecpcup")) < CDate(BacFrmIRF.TxtFecVct.Text)) And (Mid$(BacFrmIRF.Data1.Recordset("tm_instser"), 1, 3) <> "PCD" And Mid$(BacFrmIRF.Data1.Recordset("tm_instser"), 1, 3) <> "PRD") Then
'                            sPasa = False
'                            MsgBox BacFrmIRF.Data1.Recordset("tm_instser") + " con Vencimiento de Cupón Durante el Pacto.", vbCritical, gsBac_Version
'                        End If
'                    End If
'                    BacFrmIRF.Data1.Recordset.MoveNext
'                Loop
'            End If
'        End If
'      ' Cheque Cuando es una pantalla de captaciones
'        If sWinTipo$ = "IC" Then ' pantalla de captaciones
'            sPasa = True
'        End If
'
'        ' Chequea si Existen Perfiles para el Instrumento
'
'        If sPasa = True And (sWinTipo$ = "CP" Or sWinTipo$ = "CI") Then
'            BacFrmIRF.Data1.Recordset.MoveFirst
'            Do While Not BacFrmIRF.Data1.Recordset.EOF
'                If BacFrmIRF.Data1.Recordset("tm_refnomi") = "X" Then
'                    MsgBox "No Existe Definición Contable para " + BacFrmIRF.Data1.Recordset("tm_instser"), vbCritical, gsBac_Version
'                    iContador = iContador + 1
'                End If
'                If Mid$(BacFrmIRF.Data1.Recordset("tm_instser"), 1, 6) = "PCDUS$" And BacFrmIRF.Data1.Recordset("tm_monemi") = 995 And sWinTipo$ = "CP" Then
'                    MsgBox "No Existe Definición Contable para PCDUS$ Dólar Acuerdo.", vbCritical, gsBac_Version
'                    iContador = iContador + 1
'                End If
'              ' VB+- 09/06/2000 Se valida que se le haya definido un tipo de custodia
'                If IsNull(BacFrmIRF.Data1.Recordset("tm_custodia")) Then
'                    MsgBox "Debe definir custodia para instrumento " & Trim$(BacFrmIRF.Data1.Recordset("tm_instser")) & " antes de grabar, Verifique ", vbExclamation, gsBac_Version
'                    iContador = iContador + 1
'                End If
'
'                If IsNull(BacFrmIRF.Data1.Recordset("tm_rutemi")) Or CDbl(BacFrmIRF.Data1.Recordset("tm_rutemi")) = 0 Then
'                    MsgBox "Instrumento ingresado " & Trim$(BacFrmIRF.Data1.Recordset("tm_instser")) & " debe tener algun emisor asociado, Verifique ", vbExclamation, gsBac_Version
'                    iContador = iContador + 1
'                End If
'
'                BacFrmIRF.Data1.Recordset.MoveNext
'            Loop
'            If iContador <> 0 Then
'                sPasa = False
'            End If
'            BacFrmIRF.Data1.Recordset.MoveFirst
'        End If
'
'        If sPasa = True Then
'            BacIrfGr.Caption = BacFrmIRF.Caption + " : Grabación"
'            BacIrfGr.Tag = sWinTipo$
'            BacIrfGr.Show vbModal
'        Else
'            Exit Sub
'       End If
'
'    ElseIf sWinTipo$ = "CAM" Then
'
'    ElseIf sWinTipo$ = "FWD" Then
'
'    End If
'
'End Sub
Public Function CI_DatosPacto(sFecIniP$, sFecVenP$, dValIniP#, dValVenP#, dTasPact#, iBasPact%, iMonPact%, FormHandle&) As Boolean
On Error GoTo BacErrorHandler

Dim Sql$

    CI_DatosPacto = False
    
    Sql = "Update mdci SET "
    Sql = Sql & "tm_fecinip = '" & sFecIniP & "',"
    Sql = Sql & "tm_fecvenp = '" & sFecVenP & "',"
    Sql = Sql & "tm_valinip = " & dValIniP & ","
    Sql = Sql & "tm_valvenp = " & dValVenP & ","
    Sql = Sql & "tm_taspact = " & dTasPact & ","
    Sql = Sql & "tm_taspact = " & dTasPact & ","
    Sql = Sql & "tm_baspact = " & iBasPact & ","
    Sql = Sql & "tm_monpact = " & iMonPact & " "
    Sql = Sql & "WHERE tm_hwnd = " & FormHandle
    
    DB.Execute Sql
    
    CI_DatosPacto = True
    Exit Function
    
BacErrorHandler:

    MsgBox "Problemas en actualización de datos del pacto: " & err.Description & ". Verifique ", vbCritical
    Exit Function
    
End Function


Sub PROC_POSICIONA_TEXTOX(Grilla As Control, texto As Control)

    texto.Top = Grilla.CellTop + Grilla.Top
    texto.Left = Grilla.CellLeft + Grilla.Left
    texto.Height = Grilla.CellHeight + 20
    texto.Width = Grilla.CellWidth

End Sub

Public Function F_BuscaRepetidoGrilla(Col As Long, Gril As Control, Busca_Col As Variant) As Boolean
Dim Fila%
Dim Row_Old, Col_Old As Long

F_BuscaRepetidoGrilla = False

 With Gril
    Row_Old = .Row: Col_Old = .Col
    For Fila% = 1 To .Rows - 1
        .Row = Fila%
        If Trim$(.TextMatrix(.Row, Col)) <> "" Then
            If Trim$(.TextMatrix(.Row, Col)) = Busca_Col Then
                If .Row <> Row_Old Then
                    .Row = Row_Old: .Col = Col_Old
                     MsgBox " Existe Codigo en la Tabla ", 16
                     F_BuscaRepetidoGrilla = True
                     Exit Function
                End If
            End If
        End If
    Next Fila%
   .Row = Row_Old: .Col = Col_Old
 End With

End Function

Public Function F_BacLimpiaGrilla(ByRef ObjGril As Object)
 
 Dim Fila%, Col%

 With ObjGril
 
    For Fila% = 1 To .Rows - 1
        For Col% = 0 To .Cols - 1
            .TextMatrix(Fila%, Col%) = ""
        Next
    Next
    
 End With
    
End Function

Public Function F_FomateaValor(nMonto As Variant, Saca As String, Remplazo As String) As String

Dim sCadena       As String
Dim iPosicion     As Integer
Dim sFormato      As String

   
   sCadena = CStr(nMonto)
   
   F_FomateaValor = sCadena
        
     iPosicion = 1
     
   Do While iPosicion > 0
        
         iPosicion = InStr(1, sCadena, Saca)

        If iPosicion = 0 Then
           Exit Do
         Else
            sCadena = Mid$(sCadena, 1, iPosicion - 1) + Mid$(sCadena, iPosicion + 1)
        End If
   Loop
   
         iPosicion = InStr(1, sCadena, Remplazo)

         If iPosicion = 0 Then
            F_FomateaValor = sCadena
          Else
            F_FomateaValor = Mid$(sCadena, 1, iPosicion - 1) + Remplazo + Mid$(sCadena, iPosicion + 1)
         End If
         
End Function


