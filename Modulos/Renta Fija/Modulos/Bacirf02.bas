Attribute VB_Name = "Nuevos"
''============================
''Historial de Modificaciones
''============================
''Dia 07/04/2005
''Por Victor Gonzalez S.   : Cambio normativo de la SBIF restriccion para utilizar Instrumentos distintos del BCCH
''                           por moneda.
''                           1.- Papales distintos del BCCH y en CLP,USD u OBS minimo 30 Días
''                           2.- Papales distintos del BCCH y en UF,IVP u otras minimo 90 Días
''                           Solicitado por Cristian Mascareño.

Option Explicit
'VARIABLES DE ADMINISTRACION
'Global gsUsuario As String
Global gsSistema As String
'Global gsTerminal As String
Global gsNombreUs As String
Global gsUsuarioReal As String
Global SQL As String

'==========================================================================
' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Limites de Permanencia
' INICIO
'==========================================================================
Global gsCartera As Integer
Global gsCartAvfs   As Boolean
Global gsIndCartera As Integer
'==========================================================================
' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Limites de Permanencia
' FIN
'==========================================================================


'''''''''
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
Global RutCli   As String
Global DvCli    As String
Global CodCli   As String
Global NomCli   As String
Global GloCart  As String
Global lNumoper As String
Global RutCart1 As String
Global TipCart  As String
Global ValMon   As Double
Global Fecha As String
'Eugenio variable globales para los apoderados
Global Apoderado1 As String
Global Apoderado2 As String
Global RutApoderado1 As String
Global RutApoderado2 As String

Global gsBacCpDvpVp As String

Global AutorizaVP As Boolean


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

''PRD-6006 CASS 09-12-2010 ---> Grilla Pacto
Const Col_Marca = 0
Const COL_Serie = 1
Const Col_Moneda = 2
Const Col_Nominal = 3
Const Col_Tir = 4
Const Col_VPar = 5
Const Col_MT = 6
Const Col_PlzRes = 7
Const Col_Margen = 8
Const Col_ValInicial = 9

Const Col_Custodia = 11
Const Col_ClaveDcv = 12
Const Col_CarteraSuper = 10

Const Col_Nominal_ORIG = 13
Const Col_Tir_ORIG = 14
Const Col_VPar_ORIG = 15
Const Col_MT_ORIG = 16
Const Col_Margen_ORIG = 17
Const Col_ValInicial_ORIG = 18
Const Col_CodCarteraSuper = 19
Const Col_BloqueoPacto = 20      ' PRD-6005
Const Col_HairCut = 21           ' PRD-6007
Const Col_Emisor = 24            ' PRD-6006
Const Col_ID_SOMA = 22           ' PRD-6010
Const Col_Correla_SOMA = 23      ' PRD-6010
Const Col_Nemo_Emisor = 25       ' PRD-6006


'PRD-6006            CASS 09-12-2010 ---> Grilla Detalle Pacto
Const ColDet_Documento = 0
Const ColDet_Correlativo = 1
Const ColDet_NominalVenta = 2
Const ColDet_TirVenta = 3
Const ColDet_PvpVenta = 4
Const ColDet_ValorVenta = 5
Const ColDet_TasaEstimada = 7
Const ColDet_VParVenta = 8
Const ColDet_NumUltCup = 9
Const ColDet_InstSer = 10
Const ColDet_RutEmisor = 11
Const ColDet_MonedaEmision = 12
Const ColDet_FechaEmision = 13
Const ColDet_FechaVencimiento = 14
Const ColDet_FecProxCupon = 15
Const ColDet_Convexidad = 16
Const ColDet_DurationModificado = 17
Const ColDet_DurationMacaulay = 18
Const ColDet_icustodia = 19
Const ColDet_ClaveDcv = 20
Const ColDet_CarteraSuper = 21
Const ColDet_DiasDisponibles = 22
Const ColDet_Margen = 23
Const ColDet_ValorInicial = 24
'Const ColDet_CarteraSuper = 25
Const ColDet_HairCut = 26
Const ColDet_IDSoma = 27
Const ColDet_CorrelaSoma = 28
Const ColDet_InCodigo = 29
Const ColDet_MarcaVta = 30
Const ColDet_Libro = 31

Public Function FUNC_BUSCA_VALOR_MONEDA(Moneda As Integer, Fecha As String) As Double
    Dim Datos()

    FUNC_BUSCA_VALOR_MONEDA = 0#
    
    If Moneda <> 13 And Moneda <> 999 Then  ' VB+- 25/07/2000 se excluye moneda 13 pues es dolar dolar y tipo cambio es 1
'        Sql = "SP_VMLEERIND "
'        Sql = Sql & Moneda & ",'"
'        Sql = Sql & Format(Fecha, feFECHA) & "'"

        Envia = Array(CDbl(Moneda), Format(Fecha, feFECHA))
              
        If Not Bac_Sql_Execute("SP_VMLEERIND", Envia) Then
            Exit Function
        End If
    
        If Not Bac_SQL_Fetch(Datos()) Then
            Exit Function
        End If
    
        If CDbl(Datos(1)) = 0 Then
            MsgBox "Tipo de cambio, para la moneda seleccionada es de valor 0, verifique tipos de cambios del día", vbExclamation, "BAC Trader"
            Exit Function
        End If
    
        FUNC_BUSCA_VALOR_MONEDA = Val(Datos(1))
    Else
        FUNC_BUSCA_VALOR_MONEDA = 1
    End If
    

End Function

Public Function Chequea_Parametros(ByVal parEiCampo As Integer, ByVal parEsMensaje As String, ByVal parEiValida As Integer) As Boolean
Dim varssql    As String
Dim varvDataSql()

On Error GoTo ErrChequeo

    Chequea_Parametros = False
    varssql = "EXECUTE SP_SW_PARAMETROS "
    
    If miSQL.SQL_Execute(varssql) = 0 Then
    
        Do While miSQL.SQL_Fetch(varvDataSql) = 0
            If Val(varvDataSql(parEiCampo)) = parEiValida Then
                MsgBox parEsMensaje, vbExclamation, gsBac_Version
                Exit Function
            End If
        Loop
    End If
    
    Chequea_Parametros = True
    Exit Function
    
ErrChequeo:
    MsgBox "Problemas en chequeo de control procesos: " & err.Description & ". Verifique", vbCritical, gsBac_Version
    Exit Function
End Function

Public Function Chequea_OpePenLinCred() As Boolean
Dim varssql    As String
Dim varvDataSql()

On Error GoTo ErrChequeoLin

    Chequea_OpePenLinCred = False
    varssql = "SP_OPEPEN_LINEAS"
    
    If miSQL.SQL_Execute(varssql) = 0 Then
    
        Do While miSQL.SQL_Fetch(varvDataSql) = 0
            If Val(varvDataSql(1)) > 0 Then
                MsgBox "Existen Operaciones con Lineas de Crédito Pendientes", vbExclamation, gsBac_Version
                Exit Function
            End If
        Loop
    Else
        Exit Function
    End If
    
    Chequea_OpePenLinCred = True
    Exit Function
    
ErrChequeoLin:
    MsgBox "Problemas en chequeo de control procesos: " & err.Description & ". Verifique", vbCritical, gsBac_Version
    Exit Function
End Function

Public Function Controla_RUT(tex As Control, tex1 As Control) As Boolean

   Dim Valida As Integer
   Dim idRut$, IdDig$

   idRut$ = tex1
   IdDig$ = tex1

   Valida = True

   If Trim$(idRut$) = "" Or Trim$(IdDig$) = "" Or (Trim$(idRut$) = "0" And Trim$(IdDig$) = "") Then
      Valida = False
   
   End If
    
   If BacValidaRut(tex.text, tex1.text) = False Then
      Valida = False

   End If

   Controla_RUT = Valida

End Function


Public Function Proc_Carga_Parametros() As Boolean
    '=========================================================================
    'SubRutina   :   Proc_Carga_parametros
    'Objetivo    :   Realiza la carga de los parametros principales del sistema
    'Fecha       :   Marzo, 2000
    'Autor       :   Victor Barra Fuentes
    '=========================================================================
    Dim Datos()
    Dim cSql    As String

    Proc_Carga_Parametros = False
   
    If Bac_Sql_Execute("SP_PARAMETROS_SISTEMA") Then

        If Bac_SQL_Fetch(Datos()) Then
        
            gsBac_Fecp = Datos(1)
            gsBac_Clien = Datos(2)
            gsBac_Fecx = Datos(3)
            gsBac_RutC = Datos(4)
            gsBac_DigC = Datos(5)
            gsBac_RutComi = Datos(6)
            gsBac_PrComi = Datos(7)
            gsBac_Iva = Datos(8)
            
            gsBac_CartRUT = Datos(9)
            gsBac_CartDV = Datos(10)
            gsBac_CartNOM = Datos(11)
            
            gsBac_Feca = Datos(16)
            
            gsBAC_FecConFin = gsBac_Feca 'PROD-10967
            
            gsBac_TCambio = Datos(13)
            
            ''--REQ.6004
            gsBac_RutBCCH = Datos(18)
            gsBac_FPagoBCCH = Datos(19)
            gsBac_NomBCCH = Datos(20)
            gsBac_NomFPagoBCCH = Trim(Datos(21))
            
            '--LD1-COR-035
            gsValor_UF = IIf(IsNull(Datos(12)), 0, Format(Datos(12), FDecimal))
            gsValor_DO = IIf(IsNull(Datos(13)), 0, Format(Datos(13), FDecimal))
            '--LD1-COR-035
            
          ' Variable que contiene el plazo minimo de pactos para papeles no BCCH
            DIAS_PACTO_PAPEL_NO_CENTRAL = Datos(14)
            MONTO_PATRIMONIO_EFECTIVO = Datos(15)
            DIAS_PACTO_PAPEL_NO_CENTRAL_90 = 1 '--> 90. 08-10-2008
            
            BacTrader.Pnl_UF.Caption = "U.F. : " + Format(Datos(12), FDecimal)
            BacTrader.Pnl_DO.Caption = "D.O. : " + Format(Datos(13), FDecimal)
            BacTrader.Pnl_DO.Refresh
            BacTrader.Pnl_UF.Refresh
            BacTrader.Pnl_Entidad.Caption = gsBac_Clien
            BacTrader.Pnl_Fecha.Caption = gsBac_Fecp
        End If
    Else
       Exit Function
    End If
    
    Proc_Carga_Parametros = True
    
End Function

Function ActArcIni(cString As String) As Integer
    
        ActArcIni = WriteINI("windows", "device", cString, "win.ini")
    
End Function

Public Function funcModificaTesoreria(parEsTipoper As String, _
                                    parEdNumOper As Double, _
                                    parEdRutCli As Double, _
                                    parEdCodCli As Double, _
                                    parEdMtoOper As Double, _
                                    parEsMoneda As String, _
                                    parEsPago As String, _
                                    parEiForPago As Integer, _
                                    parEsRetiro As String, _
                                    parEdRutCart As Double) As Boolean
                                    
' ==========================================================================================
' Función       :   funcGrabaTesoreria
' Objetivo      :   Realiza la grabación de los datos en las tablas de control de tesoreria
' Fecha         :   Marzo, 2000
' Autor         :   Victor Barra Fuentes
' ==========================================================================================
Dim cSql    As String
Dim Datos()

On Error GoTo ErrTeso

    funcModificaTesoreria = False

    cSql = ""
    cSql = cSql & "EXECUTE SP_MODITESORERIA "
    cSql = cSql & "'" & Format$(gsBac_Fecp, "yyyymmdd") & "', "
    cSql = cSql & "'" & parEsTipoper & "', "
    cSql = cSql & CStr(parEdNumOper) & ", "
    cSql = cSql & CStr(parEdRutCli) & ", "
    cSql = cSql & CStr(parEdCodCli) & ", "
    cSql = cSql & CStr(parEdMtoOper) & ", "
    cSql = cSql & "'" & parEsMoneda & "', "
    cSql = cSql & "'" & parEsPago & "', "
    cSql = cSql & "'" & Trim$(CStr(parEiForPago)) & "', "
    cSql = cSql & "'" & parEsRetiro & "', "
    cSql = cSql & CStr(parEdRutCart) & " "
        
    
    If miSQL.SQL_Execute(cSql) = 0 Then
        Do While Bac_SQL_Fetch(Datos())
              If Val(Datos(1)) <> 0 Then
                MsgBox "Problemas en la actualización de información en Tesorería", vbCritical, gsBac_Version
                Exit Function
            End If
        Loop
    End If
    
    funcModificaTesoreria = True
    Exit Function
ErrTeso:
    MsgBox "Problemas en actualización de datos en tesorería: " & err.Description & ". Verifique.", vbCritical, gsBac_Version
    Exit Function

End Function
Public Function funcGrabaTesoreria(parEsTipoper As String, _
                                    parEdNumOper As Double, _
                                    parEdRutCli As Double, _
                                    parEdCodCli As Double, _
                                    parEdMtoOper As Double, _
                                    parEsMoneda As String, _
                                    parEsPago As String, _
                                    parEiForPago As Integer, _
                                    parEsRetiro As String, _
                                    parEdRutCart As Double) As Boolean
                                    
' ==========================================================================================
' Función       :   funcGrabaTesoreria
' Objetivo      :   Realiza la grabación de los datos en las tablas de control de tesoreria
' Fecha         :   Marzo, 2000
' Autor         :   Victor Barra Fuentes
' ==========================================================================================
Dim cSql    As String
Dim Datos()

On Error GoTo ErrTeso

    funcGrabaTesoreria = False

    cSql = ""
    cSql = cSql & "EXECUTE SP_GRABATESORERIA "
    cSql = cSql & "'" & Format$(gsBac_Fecp, "yyyymmdd") & "', "
    cSql = cSql & "'" & parEsTipoper & "', "
    cSql = cSql & CStr(parEdNumOper) & ", "
    cSql = cSql & CStr(parEdRutCli) & ", "
    cSql = cSql & CStr(parEdCodCli) & ", "
    cSql = cSql & CStr(parEdMtoOper) & ", "
    cSql = cSql & "'" & parEsMoneda & "', "
    cSql = cSql & "'" & parEsPago & "', "
    cSql = cSql & "'" & Trim$(CStr(parEiForPago)) & "', "
    cSql = cSql & "'" & parEsRetiro & "', "
    cSql = cSql & CStr(parEdRutCart) & " "
        
    
    If miSQL.SQL_Execute(cSql) = 0 Then
        Do While Bac_SQL_Fetch(Datos())
              If Val(Datos(1)) <> 0 Then
                MsgBox "Problemas en la actualización de información en Tesorería", vbCritical, gsBac_Version
                Exit Function
            End If
        Loop
    End If
    
    funcGrabaTesoreria = True
    Exit Function
ErrTeso:
    MsgBox "Problemas en actualización de datos en tesorería: " & err.Description & ". Verifique.", vbCritical, gsBac_Version
    Exit Function

End Function

Public Function funcBorraTesoreria(parEsTipoper As String, parEdNumOper As Double) As Boolean
                                    
' ==========================================================================================
' Función       :   funcBorraTesoreria
' Objetivo      :   Realiza la eliminación de los datos de la tablas de tesorería
' Fecha         :   Marzo, 2000
' Autor         :   Victor Barra Fuentes
' ==========================================================================================
Dim cSql    As String
Dim Datos()

On Error GoTo ErrTeso

    funcBorraTesoreria = False

    cSql = ""
    cSql = cSql & "EXECUTE SP_BORRATESORERIA "
    cSql = cSql & "'" & parEsTipoper & "', "
    cSql = cSql & CStr(parEdNumOper)
    
    
    If miSQL.SQL_Execute(cSql) = 0 Then
        Do While Bac_SQL_Fetch(Datos())
              If Val(Datos(1)) <> 0 Then
                MsgBox "Problemas en la actualización de información en Tesorería", vbCritical, gsBac_Version
                Exit Function
            End If
        Loop
    End If
    
    funcBorraTesoreria = True
    
    Exit Function
    
ErrTeso:
    MsgBox "Problemas en eliminación de datos en tesorería: " & err.Description & ". Verifique.", vbCritical, gsBac_Version
    Exit Function

End Function

Function RoundBac(nDato As Double, nPos As Integer) As Double
Dim iPospto%, cDato$, nDecpos1%, nDecpos2%
Dim nNum1#, nNum2#
Dim cPto$
Dim nPosres%
    
    nDecpos1 = 0
    cDato = LTrim(RTrim(Str(nDato)))
    cPto = IIf(gsBac_PtoDec = ",", ".", ",")
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

Function ValidaRango(Serie As String, FecVen As String, tir As Double, Cota_SUP As Double, Cota_INF As Double, Porcentaje As Double) As Integer
Dim SQL         As String
Dim Datos()
    
    ValidaRango% = False
    
'    Sql = "SP_VERIFICA_PVMD '" & Serie & "', "
'    Sql = Sql & tir & ",'" & Format(FecVen$, "yyyymmdd") & "'"
    
  ' VB+- 02/03/2000 Se cambia
    'Sql = "DECLARE @cota_sup    NUMERIC (19,02) ," & Chr(10)
    'Sql = Sql & "        @cota_inf    NUMERIC (19,02) ," & Chr(10)
    'Sql = Sql & "        @porcentaje  NUMERIC (19,02)" & Chr(10)
    'Sql = Sql & "SP_VERIFICA_MDPV '" & Serie$ & "',"
    'Sql = Sql & tir# & ",'" & Format(FecVen$, "yyyymmdd") & "',"
    'Sql = Sql & "@cota_sup    OUTPUT, @cota_inf OUTPUT, @porcentaje OUTPUT" & Chr(10)
    'Sql = Sql & "SELECT @cota_sup    , @cota_inf , @porcentaje"
    
    Envia = Array(Serie, CDbl(tir), Format(FecVen, "yyyymmdd"))
    
    If Bac_Sql_Execute("SP_VERIFICA_PVMD", Envia) Then
        If Bac_SQL_Fetch(Datos()) Then
            If Val(Datos(1)) <> 0 And Val(Datos(2)) <> 0 Then
                Cota_SUP# = CDbl(Datos(1))
                Cota_INF# = CDbl(Datos(2))
                Porcentaje# = CDbl(Datos(3))
                
                If tir# > Cota_SUP# Or tir# < Cota_INF# Then
                    ValidaRango% = False
                Else
                    ValidaRango% = True
                End If
            Else
                ValidaRango% = True
            End If
        End If
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

Public Function BuscaGlosa(obj As Object, codi As String) As Long
Dim F   As Long
Dim Max As Long
        
    BuscaGlosa = -1
    Max = obj.coleccion.Count
            
    For F = 1 To Max
        If Trim$(obj.coleccion(F).Glosa) = Trim(codi) Then
            BuscaGlosa = F - 1
            Exit For
        End If
    Next F
            
End Function

Public Sub BacGrabarTX()

    Dim sWinTipo$
    Dim sPasa$
    Dim sPasa90$
    Dim sPasa90No   As Boolean
    Dim iContador   As Integer
    Dim iConta      As Integer

    Set BacFrmIRF = BacTrader.ActiveForm
    
    If Chequear_MesaIng() = False Then
        If Trim(Mid$(BacFrmIRF.Tag, 1, 2)) = "VP" Then
            Call oLimPermanencia_vp.Fx_EliminaRegistroLimite(oLimPermanencia_vp.RelacionId)
        End If
        Exit Sub
    End If
    
    '> CONECTIVIDAD CON EL AS400 >> IDD ITAU
        '-> As400Monto_Cap = Lbl_Monto_Inicio_pesos.Caption
        '-> As400TasaIC_Cap = Msk_Tasa.Text
        '-> As400PlazoIC_Cap = Txt_Dias.Text
    '> CONECTIVIDAD CON EL AS400 >> IDD ITAU
    
    sWinTipo$ = Mid$(BacFrmIRF.Tag, 1, 2)
    
    sPasa = True
    iContador = 0
    
    If sWinTipo$ = "RC" Or sWinTipo$ = "RV" Or sWinTipo$ = "AC" Then
        If BacFrmIRF.TxtTasaAnt.text = "" And CDbl(BacFrmIRF.TxtTasaAnt.text) = 0 Then
            MsgBox "Debe aplicar tasa de descuento para grabar anticipo de pacto.", vbCritical, gsBac_Version
            sPasa = False
        End If
    End If
    
    '-> LD1_035
    
    If sWinTipo$ = "CP" Or sWinTipo$ = "CI" Or sWinTipo$ = "VP" Or (sWinTipo$ = "VI" Or sWinTipo$ = "RP") Or sWinTipo$ = "RC" Or sWinTipo$ = "RV" Or sWinTipo$ = "IB" Or sWinTipo$ = "ST" Or sWinTipo$ = "IC" Or sWinTipo$ = "RI" Or sWinTipo$ = "AC" Then
       If sWinTipo$ = "IB" Then
          
          If Val(BacFrmIRF.FltMtoini.text) = 0 Then
             MsgBox "Debe Ingresar Monto Inicial.", vbCritical, gsBac_Version
             Exit Sub
          End If
          
          'If CDbl(BacFrmIRF.FltTasa.Text) = 0 Then
          If CDbl(BacFrmIRF.FltTasa.text) = 0 And BacFrmIRF.ChkContraBCCH.Value = 0 Then 'REQ.6008
             MsgBox "Debe Ingresar Tasa.", vbCritical, gsBac_Version
             Exit Sub
          End If

          If Val(BacFrmIRF.IntBase.text) = 0 Then
             MsgBox "Debe Ingresar Base.", vbCritical, gsBac_Version
             Exit Sub
          End If
          
          If Val(BacFrmIRF.Lbl_Mt_Final.Caption) = 0 Then
             MsgBox "Operación No Tiene Monto Final.", vbCritical, gsBac_Version
             Exit Sub
          End If
          
          ''REQ.6008
          If BacFrmIRF.ChkContraBCCH.Value = 1 And CDbl(BacFrmIRF.TasaTpm.text) = 0 Then
             MsgBox "Operación No Tiene Tasa TPM.", vbCritical, gsBac_Version
             BacFrmIRF.TasaTpm.SetFocus
             Exit Sub
          End If
          
       End If
    
     ' Verifica que la Grilla no este vacia CP CI
        If sWinTipo$ = "CP" Or sWinTipo$ = "CI" Then
            BacFrmIRF.Data1.Recordset.MoveFirst
            Do While Not BacFrmIRF.Data1.Recordset.EOF
              ' Verifica que el registro esté con datos
                If Trim$(BacFrmIRF.Data1.Recordset("tm_instser")) <> "" Then
                    iContador = iContador + 1
                End If
                BacFrmIRF.Data1.Recordset.MoveNext
            Loop
            If iContador = 0 Then
                sPasa = False
                MsgBox "No Existen Registros a Grabar.", vbCritical, gsBac_Version
            End If
            BacFrmIRF.Data1.Recordset.MoveFirst
        End If
              
       ' Verifica que la Grilla no este vacia VP VI
       ' Verifica Los Valores Presentes y tir venta VP VI
       
        iContador = 0
        iConta = 0
        If sWinTipo$ = "VP" Or (sWinTipo$ = "VI" Or sWinTipo$ = "RP") Or sWinTipo$ = "ST" Then
            If BacFrmIRF.Data1.Recordset.RecordCount > 0 Then
                 BacFrmIRF.Data1.Recordset.MoveFirst
                Do While Not BacFrmIRF.Data1.Recordset.EOF
                    If BacFrmIRF.Data1.Recordset("tm_venta") = "P" Or BacFrmIRF.Data1.Recordset("tm_venta") = "V" Then
                        iContador = iContador + 1
                        If BacFrmIRF.Data1.Recordset("tm_vp") = 0 Then
                            iConta = iConta + 1
                        End If
                    End If
                    BacFrmIRF.Data1.Recordset.MoveNext
                Loop
                If iContador = 0 Then
                    sPasa = False
                    MsgBox "No Existen Documentos Asignados para Grabar.", vbCritical, gsBac_Version
                End If
            Else
                sPasa = False
                MsgBox "No Existen Registros Marcados para Grabar.", vbCritical, gsBac_Version
            End If
            
            If iConta > 0 Then
                sPasa = False
                MsgBox "Existen Registros con Valores en Cero.", vbCritical, gsBac_Version
            End If
            
        End If
                       
     ' Verifica Los Valores Presentes CP CI
       iContador = 0
       If sPasa = True And (sWinTipo$ = "CP" Or sWinTipo$ = "CI") Then
          BacFrmIRF.Data1.Recordset.MoveFirst
          Do While Not BacFrmIRF.Data1.Recordset.EOF
             'Verifica que el registro esté con datos
             If BacFrmIRF.Data1.Recordset("tm_mt") = 0 Then
                iContador = iContador + 1
             End If
             'ARM
             If BacFrmIRF.Data1.Recordset("tm_mt") <> 0 Then
             iContador = 0
             End If
             'ARM
             BacFrmIRF.Data1.Recordset.MoveNext
          Loop
   
          If iContador <> 0 Then
             sPasa = False
             MsgBox "Existen Registros con Valores en Cero.", vbCritical, gsBac_Version
          End If
          BacFrmIRF.Data1.Recordset.MoveFirst
       End If
                 
     ' Valido Emisores para los papeles
       iContador = 0
       If sPasa = True And (sWinTipo$ = "CP" Or sWinTipo$ = "CI") Then
          BacFrmIRF.Data1.Recordset.MoveFirst
          Do While Not BacFrmIRF.Data1.Recordset.EOF
             'Verifica que el registro esté con datos
             If BacFrmIRF.Data1.Recordset("tm_rutemi") = 0 And Trim(BacFrmIRF.Data1.Recordset("tm_instser")) <> "FMUTUO" Then
                iContador = iContador + 1
             End If
             'ARM
             If BacFrmIRF.Data1.Recordset("tm_rutemi") <> 0 Then
               iContador = 0
             End If
          'ARM
   
             BacFrmIRF.Data1.Recordset.MoveNext
          Loop
   
          If iContador <> 0 Then
             sPasa = False
             MsgBox "Existen Registros sin emisores asociados.", vbCritical, gsBac_Version
          End If
          BacFrmIRF.Data1.Recordset.MoveFirst
       End If
                 
       ' Verifica Fechas de disponibilidad En VI
       
        iContador = 0
        If sPasa = True And (sWinTipo$ = "VI" Or sWinTipo$ = "RP") Then
            BacFrmIRF.Data1.Recordset.MoveFirst
            Do While Not BacFrmIRF.Data1.Recordset.EOF
                If BacFrmIRF.Data1.Recordset("tm_venta") = "P" Or BacFrmIRF.Data1.Recordset("tm_venta") = "V" Then
                    If CDate(BacFrmIRF.Data1.Recordset("tm_fecsal")) < CDate(BacFrmIRF.TxtFecVct.text) Then
                        MsgBox "Instrumento " + BacFrmIRF.Data1.Recordset("tm_instser") + " No Disponible a la Fecha Vcto. Venta Pacto.", vbCritical, gsBac_Version
                        iContador = iContador + 1
                    End If
                End If
                BacFrmIRF.Data1.Recordset.MoveNext
            Loop
            If iContador <> 0 Then
                sPasa = False
            End If
        End If
        
      ' Realizo validación de papeles no BCCH y plazo pacto sea mayor a DIAS_PACTO_PAPEL_NO_CENTRAL
        sPasa90 = True
        sPasa90No = True
        
        Const BCCHTGRINP = "97029000:61533000:60805000"
        Const MonedaEmision = "998"
           If sPasa = True And ((sWinTipo$ = "VI" Or sWinTipo$ = "RP")) Then 'Or (sWinTipo$ = "CI")
            If BacFrmIRF.TxtPlazo.text < DIAS_PACTO_PAPEL_NO_CENTRAL_90 Then
                BacFrmIRF.Data1.Recordset.MoveFirst
                Do While Not BacFrmIRF.Data1.Recordset.EOF
                
                    If (sWinTipo$ = "VI" Or sWinTipo$ = "RP") Then
                        '' VGS 07/04/2005
                        If BacFrmIRF.Data1.Recordset("tm_venta") = "V" Then
                        
                           If InStr(1, BCCHTGRINP, CDbl(BacFrmIRF.Data1.Recordset("tm_rutemi"))) = 0 Then
                              If InStr(1, MonedaEmision, BacFrmIRF.Data1.Recordset("tm_monemi")) > 0 Then
                                 If Val(BacFrmIRF.TxtPlazo.text) < Val(DIAS_PACTO_PAPEL_NO_CENTRAL_90) Then
                                    sPasa90No = False
                                    Exit Do
                                 End If
                              End If
                           End If
                           
                           If CDbl(BacFrmIRF.Data1.Recordset("tm_rutemi")) <> 97029000 And CDbl(BacFrmIRF.Data1.Recordset("tm_rutemi")) <> 61533000 _
                           And CDbl(BacFrmIRF.Data1.Recordset("tm_rutemi")) <> 60805000 _
                           And InStr(1, "999- 13-994-998", BacFrmIRF.Data1.Recordset("tm_monemi")) > 0 _
                            And BacFrmIRF.TxtPlazo.text < DIAS_PACTO_PAPEL_NO_CENTRAL Then
                                sPasa = False
                                Exit Do
                           ElseIf CDbl(BacFrmIRF.Data1.Recordset("tm_rutemi")) <> 97029000 And CDbl(BacFrmIRF.Data1.Recordset("tm_rutemi")) <> 61533000 _
                                    And CDbl(BacFrmIRF.Data1.Recordset("tm_rutemi")) <> 60805000 _
                                    And InStr(1, "999- 13-994-998", BacFrmIRF.Data1.Recordset("tm_monemi")) = 0 _
                                    And BacFrmIRF.TxtPlazo.text < DIAS_PACTO_PAPEL_NO_CENTRAL_90 Then
                                sPasa90 = False
                                Exit Do
                           End If
                        End If
                    Else
                        If CDbl(BacFrmIRF.Data1.Recordset("tm_rutemi")) <> 97029000 Then
                            sPasa = False
                            Exit Do
                        End If
                    End If
                    BacFrmIRF.Data1.Recordset.MoveNext
                Loop
               If sPasa = False Then
                  MsgBox "Pacto contiene papeles que no son emitidos por el Banco Central." & vbCrLf & vbCrLf & "Plazo pacto es menor a " & DIAS_PACTO_PAPEL_NO_CENTRAL & " días. No se puede realizar esta operación.", vbExclamation, TITSISTEMA
               End If
               If sPasa90 = False Then
                  MsgBox "Pacto contiene papeles que no son emitidos por el Banco Central." & vbCrLf & vbCrLf & "Plazo pacto es menor a " & DIAS_PACTO_PAPEL_NO_CENTRAL_90 & " días. No se puede realizar esta operación.", vbExclamation, TITSISTEMA
                  sPasa = False
               End If
               If sPasa90No = False Then
                  MsgBox "Pacto contiene instrumentos en moneda U.F." & vbCrLf & vbCrLf & "Plazo del pacto es menor a " & DIAS_PACTO_PAPEL_NO_CENTRAL_90 & " días. No se puede realizar esta operación.", vbExclamation, TITSISTEMA
                  sPasa = False
               End If
            End If
        End If
        
        If sPasa = True And ((sWinTipo$ = "VI" Or sWinTipo$ = "RP") Or sWinTipo$ = "CI") Then
           If CDbl(BacFrmIRF.TxtTasa.text) = 0 Then
              MsgBox "Falta Tasa del Pacto.", 16
              sPasa = False
           End If
           If CDbl(BacFrmIRF.txtTipoCambio.text) = 0 Then
              MsgBox "Falta Tipo de Cambio para el Pacto.", 16
              sPasa = False
           End If
        End If
        
      ' Chequeo de Ventas y Compras con Pacto con Pago de Cupon Durante el Pacto
      ' VB+- 15/05/2000 se cambio validacion, que sea valida solamamente para las compras con pacto
        If sPasa = True And (sWinTipo$ = "CI") Then
      ' If sPasa = True And (sWinTipo$ = "VI" Or sWinTipo$ = "CI") Then
        
            If CDbl(BacFrmIRF.TxtTasa.text) = 0 Then
               MsgBox "Falta Tasa del Pacto.", 16
               sPasa = False
            End If
        
            BacFrmIRF.Data1.Recordset.MoveFirst
            
            If sWinTipo$ = "CI" Then
                Do While Not BacFrmIRF.Data1.Recordset.EOF
                    'If (CDate(BacFrmIRF.Data1.Recordset("tm_fecpcup")) < CDate(BacFrmIRF.TxtFecVct.Text)) And (Mid$(BacFrmIRF.Data1.Recordset("tm_instser"), 1, 3) <> "PCD" And Mid$(BacFrmIRF.Data1.Recordset("tm_instser"), 1, 3) <> "PRD") Then
                     '   sPasa = False
                     '   MsgBox BacFrmIRF.Data1.Recordset("tm_instser") + " Tiene Vencimiento Durante el Pacto.", vbCritical, gsBac_Version
                    'End If
                    ' lo elimine yo el david dio la idea
                    BacFrmIRF.Data1.Recordset.MoveNext
                Loop
            Else
                Do While Not BacFrmIRF.Data1.Recordset.EOF
                    If BacFrmIRF.Data1.Recordset("tm_venta") = "P" Or BacFrmIRF.Data1.Recordset("tm_venta") = "V" Then
                        If (CDate(BacFrmIRF.Data1.Recordset("tm_fecpcup")) < CDate(BacFrmIRF.TxtFecVct.text)) And (Mid$(BacFrmIRF.Data1.Recordset("tm_instser"), 1, 3) <> "PCD" And Mid$(BacFrmIRF.Data1.Recordset("tm_instser"), 1, 3) <> "PRD") Then
                            sPasa = False
                            MsgBox BacFrmIRF.Data1.Recordset("tm_instser") + " con Vencimiento de Cupón Durante el Pacto.", vbCritical, gsBac_Version
                        End If
                    End If
                    BacFrmIRF.Data1.Recordset.MoveNext
                Loop
            End If
        End If
      
      ' Cheque Cuando es una pantalla de captaciones
        If sWinTipo$ = "IC" Or sWinTipo$ = "RI" Then ' pantalla de captaciones
            sPasa = True
        End If
                
        ' Chequea si Existen Perfiles para el Instrumento
        If sPasa = True And (sWinTipo$ = "CP" Or sWinTipo$ = "CI") Then
            BacFrmIRF.Data1.Recordset.MoveFirst
            Do While Not BacFrmIRF.Data1.Recordset.EOF
                If BacFrmIRF.Data1.Recordset("tm_refnomi") = "X" Then
                    MsgBox "No Existe Definición Contable para " + BacFrmIRF.Data1.Recordset("tm_instser"), vbCritical, gsBac_Version
                    iContador = iContador + 1
                End If
                If Mid$(BacFrmIRF.Data1.Recordset("tm_instser"), 1, 6) = "PCDUS$" And BacFrmIRF.Data1.Recordset("tm_monemi") = 995 And sWinTipo$ = "CP" Then
                    MsgBox "No Existe Definición Contable para PCDUS$ Dólar Acuerdo.", vbCritical, gsBac_Version
                    iContador = iContador + 1
                End If
              ' VB+- 09/06/2000 Se valida que se le haya definido un tipo de custodia
                If IsNull(BacFrmIRF.Data1.Recordset("tm_custodia")) Then
                    MsgBox "Debe definir custodia para instrumento " & Trim$(BacFrmIRF.Data1.Recordset("tm_instser")) & " antes de grabar, Verifique ", vbExclamation, gsBac_Version
                    iContador = iContador + 1
                End If
                
'               If CDbl(BacFrmIRF.Data1.Recordset("tm_rutemi") = 0) And Trim(BacFrmIRF.Data1.Recordset("tm_instser")) <> "FMUTUO" Then
'                MsgBox "Instrumento ingresado " & Trim$(BacFrmIRF.Data1.Recordset("tm_instser")) & " debe tener algun emisor asociado, Verifique ", vbExclamation, gsBac_Version
'                iContador = iContador + 1
'                End If
                
                BacFrmIRF.Data1.Recordset.MoveNext
            Loop
            If iContador <> 0 Then
                sPasa = False
            End If
            
            BacFrmIRF.Data1.Recordset.MoveFirst
        End If
       
        If sPasa = True Then
            If Tipo_Operacion = "CP" Or Tipo_Operacion = "CI" Then
            BacIrfGr.Caption = BacFrmIRF.Caption + " : Grabación"
            Else
                BacIrfGrSinDVP.Caption = BacIrfGrSinDVP.Caption + " : Grabación"
            End If
           'BacIrfGr.Tag = sWinTipo$
           'BacIrfGr.Show vbModal
            If Tipo_Operacion = "CP" Or Tipo_Operacion = "CI" Then
               'BacIrfGrDVP.Show vbModal
            BacIrfGr.Tag = sWinTipo$
            BacIrfGr.Show vbModal
        Else
               BacIrfGrSinDVP.Tag = sWinTipo$
               BacIrfGrSinDVP.Show vbModal
            End If
        Else
            Grabacion_Operacion = False
            Exit Sub
        End If

    ElseIf sWinTipo$ = "CAM" Then
    
    ElseIf sWinTipo$ = "FWD" Then

    End If

End Sub


''PRD-6006 CASS 09-12-2010
Public Sub BacGrabaPacto()

    Dim sWinTipo$
    Dim sPasa$
    Dim sPasa90$
    Dim sPasa90No   As Boolean
    Dim iContador   As Integer
    Dim iConta      As Integer
    Dim Envia
    
    Dim nContador  As Integer  'PRD-6006 CASS 09-12-2010
    
    Set BacFrmIRF = BacTrader.ActiveForm
    
    If Chequear_MesaIng() = False Then
         Exit Sub
    End If
    
    sWinTipo$ = Mid$(BacFrmIRF.Tag, 1, 2)
    
    sPasa = True
    iContador = 0
    
    If sWinTipo$ = "CP" Or sWinTipo$ = "CI" Or sWinTipo$ = "VP" Or (sWinTipo$ = "VI" Or sWinTipo$ = "RP") Or sWinTipo$ = "RC" Or sWinTipo$ = "RV" Or sWinTipo$ = "IB" Or sWinTipo$ = "ST" Or sWinTipo$ = "IC" Or sWinTipo$ = "AC" Then
    
        iContador = 0
        iConta = 0
        
        If sWinTipo$ = "VP" Or (sWinTipo$ = "VI" Or sWinTipo$ = "RP") Or sWinTipo$ = "ST" Then
           If Frm_Vtas_con_Pcto.GRILLA.Rows > 1 Then
              For nContador = 1 To Frm_Vtas_con_Pcto.GRILLA.Rows - 1
                    If Frm_Vtas_con_Pcto.GRILLA.TextMatrix(nContador, Col_Marca) = "P" Or Frm_Vtas_con_Pcto.GRILLA.TextMatrix(nContador, Col_Marca) = "V" Then
                        iContador = iContador + 1
                        If Frm_Vtas_con_Pcto.GRILLA.TextMatrix(nContador, Col_Tir) = 0 Then
                            iConta = iConta + 1
                        End If
                    End If
               
               Next
               
               If iContador = 0 Then
                    sPasa = False
                    MsgBox "No Existen Documentos Asignados para Grabar.", vbCritical, gsBac_Version
               End If
            Else
                sPasa = False
                MsgBox "No Existen Registros Marcados para Grabar.", vbCritical, gsBac_Version
            End If
            
            If iConta > 0 Then
                sPasa = False
                MsgBox "Existen Registros con Valores en Cero.", vbCritical, gsBac_Version
            End If
            
        End If
                       
       ' Verifica Fechas de disponibilidad En VI
        iContador = 0
        If sPasa = True And (sWinTipo$ = "VI" Or sWinTipo$ = "RP") Then
            For nContador = 1 To Frm_Vtas_con_Pcto.GrillaGrabarPctos.Rows - 1
                    If CDate(Frm_Vtas_con_Pcto.GrillaGrabarPctos.TextMatrix(nContador, ColDet_FechaVencimiento)) < CDate(BacFrmIRF.TxtFecVct.text) Then
                        MsgBox "Instrumento " + Frm_Vtas_con_Pcto.GrillaGrabarPctos.TextMatrix(nContador, ColDet_InstSer) + " No Disponible a la Fecha Vcto. Venta Pacto.", vbCritical, gsBac_Version
                        iContador = iContador + 1
                    End If
            Next
            If iContador <> 0 Then
                sPasa = False
            End If
        End If
        
      ' Realizo validación de papeles no BCCH y plazo pacto sea mayor a DIAS_PACTO_PAPEL_NO_CENTRAL
        sPasa90 = True
        sPasa90No = True
        
        Const BCCHTGRINP = "97029000:61533000:60805000"
        Const MonedaEmision = "998"
           If sPasa = True And ((sWinTipo$ = "VI" Or sWinTipo$ = "RP")) Then 'Or (sWinTipo$ = "CI")
            If BacFrmIRF.TxtPlazo.text < DIAS_PACTO_PAPEL_NO_CENTRAL_90 Then
                For nContador = 1 To Frm_Vtas_con_Pcto.GrillaGrabarPctos.Rows - 1
                    If (sWinTipo$ = "VI" Or sWinTipo$ = "RP") Then
                           If InStr(1, BCCHTGRINP, CDbl(Frm_Vtas_con_Pcto.GrillaGrabarPctos.TextMatrix(nContador, ColDet_RutEmisor))) = 0 Then
                              If InStr(1, MonedaEmision, Frm_Vtas_con_Pcto.GrillaGrabarPctos.TextMatrix(nContador, ColDet_MonedaEmision)) > 0 Then
                                 If Val(BacFrmIRF.TxtPlazo.text) < Val(DIAS_PACTO_PAPEL_NO_CENTRAL_90) Then
                                    sPasa90No = False
                                    Exit For
                                 End If
                              End If
                           End If
                           
                           If CDbl(Frm_Vtas_con_Pcto.GrillaGrabarPctos.TextMatrix(nContador, ColDet_RutEmisor)) <> 97029000 And CDbl(Frm_Vtas_con_Pcto.GrillaGrabarPctos.TextMatrix(nContador, ColDet_RutEmisor)) <> 61533000 _
                           And CDbl(Frm_Vtas_con_Pcto.GrillaGrabarPctos.TextMatrix(nContador, ColDet_RutEmisor)) <> 60805000 _
                           And InStr(1, "999- 13-994-998", Frm_Vtas_con_Pcto.GrillaGrabarPctos.TextMatrix(nContador, ColDet_MonedaEmision)) > 0 _
                           And BacFrmIRF.TxtPlazo.text < DIAS_PACTO_PAPEL_NO_CENTRAL Then
                           
                                sPasa = False
                                    Exit For

                           ElseIf CDbl(Frm_Vtas_con_Pcto.GrillaGrabarPctos.TextMatrix(nContador, ColDet_RutEmisor)) <> 97029000 And CDbl(Frm_Vtas_con_Pcto.GrillaGrabarPctos.TextMatrix(nContador, ColDet_RutEmisor)) <> 61533000 _
                                    And CDbl(Frm_Vtas_con_Pcto.GrillaGrabarPctos.TextMatrix(nContador, ColDet_RutEmisor)) <> 60805000 _
                                    And InStr(1, "999- 13-994-998", Frm_Vtas_con_Pcto.GrillaGrabarPctos.TextMatrix(nContador, ColDet_MonedaEmision)) = 0 _
                                    And BacFrmIRF.TxtPlazo.text < DIAS_PACTO_PAPEL_NO_CENTRAL_90 Then
                                sPasa90 = False
                                    Exit For

                           End If
                    Else
                        If CDbl(Frm_Vtas_con_Pcto.GrillaGrabarPctos.TextMatrix(nContador, ColDet_RutEmisor)) <> 97029000 Then
                            sPasa = False
                            Exit For
                        End If
                    End If
                Next
               
               If sPasa = False Then
                  MsgBox "Pacto contiene papeles que no son emitidos por el Banco Central." & vbCrLf & vbCrLf & "Plazo pacto es menor a " & DIAS_PACTO_PAPEL_NO_CENTRAL & " días. No se puede realizar esta operación.", vbExclamation, TITSISTEMA
               End If
               
               If sPasa90 = False Then
                  MsgBox "Pacto contiene papeles que no son emitidos por el Banco Central." & vbCrLf & vbCrLf & "Plazo pacto es menor a " & DIAS_PACTO_PAPEL_NO_CENTRAL_90 & " días. No se puede realizar esta operación.", vbExclamation, TITSISTEMA
                  sPasa = False
               End If
               
               If sPasa90No = False Then
                  MsgBox "Pacto contiene instrumentos en moneda U.F." & vbCrLf & vbCrLf & "Plazo del pacto es menor a " & DIAS_PACTO_PAPEL_NO_CENTRAL_90 & " días. No se puede realizar esta operación.", vbExclamation, TITSISTEMA
                  sPasa = False
               End If
            
            End If
        End If
        
        If sPasa = True And ((sWinTipo$ = "VI" Or sWinTipo$ = "RP") Or sWinTipo$ = "CI") Then
           If CDbl(BacFrmIRF.TxtTasa.text) = 0 Then
              MsgBox "Falta Tasa del Pacto.", 16
              sPasa = False
           End If
           If CDbl(BacFrmIRF.txtTipoCambio.text) = 0 Then
              MsgBox "Falta Tipo de Cambio para el Pacto.", 16
              sPasa = False
           End If
        End If
        
        If sPasa = True Then
            BacIrfGr.Caption = BacFrmIRF.Caption + " : Grabación"
            'BacIrfGr.Tag = sWinTipo$
            'BacIrfGr.Show vbModal
            
         '/********************************************/
            If Tipo_Operacion = "VI" Then
               BacIrfGrSinDVP.Tag = sWinTipo$
               BacIrfGrSinDVP.Show vbModal
            Else
            BacIrfGr.Tag = sWinTipo$
            BacIrfGr.Show vbModal
            End If
       '/*******************************************/
        Else
            Grabacion_Operacion = False
            Exit Sub
        End If

    End If

End Sub


Public Function CI_DatosPacto(sFecIniP$, sFecVenP$, dValIniP#, dValVenP#, dTasPact#, iBasPact%, iMonPact%, FormHandle&) As Boolean
On Error GoTo BacErrorHandler

Dim SQL$

    CI_DatosPacto = False
    
    SQL = "Update mdci SET "
    SQL = SQL & "tm_fecinip = '" & sFecIniP & "',"
    SQL = SQL & "tm_fecvenp = '" & sFecVenP & "',"
    SQL = SQL & "tm_valinip = " & dValIniP & ","
    SQL = SQL & "tm_valvenp = " & dValVenP & ","
    SQL = SQL & "tm_taspact = " & dTasPact & ","
    SQL = SQL & "tm_taspact = " & dTasPact & ","
    SQL = SQL & "tm_baspact = " & iBasPact & ","
    SQL = SQL & "tm_monpact = " & iMonPact & " "
    SQL = SQL & "WHERE tm_hwnd = " & FormHandle
    
    db.Execute SQL
    
    CI_DatosPacto = True
    Exit Function
    
BacErrorHandler:

    MsgBox "Problemas en actualización de datos del pacto: " & err.Description & ". Verifique ", vbCritical, gsBac_Version
    Exit Function
    
End Function
Public Function VI_GrabarTx( _
   lRutCar&, iTipCar%, iForPagI&, iForPagV&, sTipCus$, sRetiro$, _
   sPagMan$, sObserv$, lRutCli&, nCodigo, hForm As Form, dTPFE As Double, _
   dTCCE As Double, TCart$, Mercado$, Sucursal$, AreaResponsable$, Fecha_PagoMañana$, _
   Laminas$, Tipo_Inversion$, CtaCteInicio$, SucInicio$, CtaCteFinal$, SucFinal$, Repos$) As Double
   
Dim Datos()
Dim iCorrela%
Dim iCorrVent%
Dim sMascara$, sInstSer$, sGenEmi$, sNemMon$, dNominal#, dTir#, dPvp#, sFecpcup$
Dim dVPar#, dVpTirV#, dVpTirV100#, iNumUCup%, dTasEst#, sFecEmi$, sFecVen$
Dim sMdse$, lCodigo&, sSerie$, iMonemi%, lRutemi&, dTasEmi#, iBasemi%
Dim dTipcam#
Dim sFecIniP$, sFecVenP$, dValIniP#, dValVenP#, dTasPact#
Dim lPlazo&, iBasPact%, iMonPact%, dTotalIniMP#, dTotalVenMP#
Dim dFactor#, dTotalaux#, dValIniUm#
Dim dNumoper#
Dim sFecPro$
Dim Resultado%
Dim Correlativo&
Dim dConvex     As Double
Dim dDurMod     As Double
Dim dDurmac     As Double
Dim clave_dcv   As String
Dim FlagTx      As Boolean
Dim dNumdocu    As Double
Dim cCarteraSuper As String
Dim nRedon       As Integer
Dim Codigo_Libro$
'++GRC Req007
Dim dPlazoRes   As Integer
Dim dMargen     As Double
Dim dValInicial As Double
Dim dCorr_SOMA  As Integer
Dim dNumOper_SOMA As Integer
'--GRC Req007
Dim nTirTran     As Double
Dim nVFTran      As Double
Dim nDifTran_MO  As Double
Dim nDifTran_CLP As Double

Dim resControlPT As String
Dim Mensaje_CPT As String

On Error GoTo BacErrorHandler

    sFecIniP$ = hForm.TxtFecIni.text
    sFecVenP$ = hForm.TxtFecVct.text
    dTotalIniMP# = CDbl(hForm.txtIniPMP.text)
    dTotalVenMP# = CDbl(hForm.txtVenPMP.text)
    dTasPact# = CDbl(hForm.TxtTasa.text)
    lPlazo& = Val(hForm.TxtPlazo.text)
    iMonPact% = Val(hForm.CmbMon.ItemData(BacFrmIRF.CmbMon.ListIndex))
    iBasPact% = funcBaseMoneda(iMonPact%) ' Val(hForm.cmbBase.List(BacFrmIRF.cmbBase.ListIndex))
    nRedon = BacDatGrMon.mndecimal
    dTipcam# = CDbl(hForm.txtTipoCambio.text)
    sFecPro = Format$(gsBac_Fecp, "mm/dd/yyyy")
    
    If Repos$ = "RP" Then
        nTirTran = 0
        nVFTran = 0
        nDifTran_MO = 0
        nDifTran_CLP = 0
    Else
         nTirTran = hForm.Txt_TasaTran.text
         nVFTran = hForm.Txt_VFTran.text
         nDifTran_MO = hForm.Txt_DifTran.text
         nDifTran_CLP = hForm.Txt_Dif_CLP.text
    End If
    
    FlagTx = False
    
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        GoTo BacErrorHandler
    End If
    
    FlagTx = True

    If Not Bac_Sql_Execute("SP_OPMDAC") Then
       GoTo BacErrorHandler
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
        dNumoper = Val(Datos(1))
    End If

    hForm.Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hForm.hWnd & " AND tm_diasdisp >= " & hForm.TxtPlazo.text & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
    hForm.Data1.Refresh
    
    '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then

        Dim Mensaje     As String

        Mensaje = ""
        hForm.Data1.Recordset.MoveFirst
        iCorrela% = 0
                 
        Do While Not hForm.Data1.Recordset.EOF
        
            If hForm.Data1.Recordset("tm_venta") = "P" Or BacFrmIRF.Data1.Recordset("tm_venta") = "V" Then
                If Trim$(hForm.Data1.Recordset("tm_instser")) <> "" Then
            
                    
                    With hForm
                        dNumdocu = .Data1.Recordset("tm_numdocu")
                        dNumdocu = .Data1.Recordset("tm_correla")
                        dNominal = .Data1.Recordset("tm_nominal")
                        dVpTirV# = .Data1.Recordset("tm_vp")
                        sFecVen$ = .Data1.Recordset("tm_fecven")
                        lCodigo& = .Data1.Recordset("tm_codigo")
                        iMonemi% = .Data1.Recordset("tm_monemi")
                        lRutemi& = .Data1.Recordset("tm_rutemi")
                        sSerie$ = .Data1.Recordset("tm_mdse")
                    End With
                
                    If Not Lineas_ChequearGrabar("BTR", "VI ", dNumoper, dNumdocu, CDbl(dNumdocu), CDbl(lRutCli), CDbl(nCodigo), dVpTirV#, gsBac_TCambio, BacFrmIRF.TxtFecVct.text, CDbl(lRutemi&), iMonemi%, hForm.Data1.Recordset("tm_fecven"), CDbl(lCodigo&), sSerie$, 0, "C", 0, "N", 0, gsBac_Fecp, 0, 0, hForm.Data1.Recordset("tm_tir"), dTasPact#, hForm.Data1.Recordset("tm_instser")) Then
                    'If Not Lineas_ChequearGrabar("BTR", "VI ", dNumoper, dNumdocu, CDbl(dNumdocu), CDbl(lRutCli), CDbl(nCodigo), dVpTirV#, gsBac_TCambio, BacFrmIRF.TxtFecVct.Text, CDbl(lRutemi&), iMonemi%, hForm.Data1.Recordset("tm_fecven"), CDbl(lCodigo&), sSerie$, 0, "C", 0, "N", 0, gsBac_Fecp, 0, 0) Then
                        GoTo BacErrorHandler
                    End If
                    
                End If
                
            End If
            
            hForm.Data1.Recordset.MoveNext
        Loop
        
        Mensaje = Mensaje & Lineas_Chequear("BTR", "VI ", dNumoper, " ", " ", " ")
        
        If Mensaje <> "" Then
        
            MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical
            
            If FlagTx = True Then
                If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                    MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
                End If
            End If

            VI_GrabarTx = 0
            
            Exit Function
            
        End If
    
    End If
    
    '********** Fin

    'PRD-3860, (modo silencioso)
    If Ctrlpt_ModoOperacion = "S" Then
        Mensaje_CPT = ""
    Else
        Mensaje_CPT = Ctrlpt_Mensaje
    End If
    'fin PRD-3860


    '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then

       Dim Mensaje_Con As String
       Dim SwResp      As Integer

       Mensaje_Con = Lineas_ConsultaOperacion("BTR", "VI ", dNumoper, " ", " ", " ")

       'PRD-3860, agregarle el mensaje del control de precios y tasas si está en modo normal
       If Trim(Mensaje_CPT) <> "" Then
            Mensaje_Con = Mensaje_Con & vbCrLf & vbCrLf & Mensaje_CPT
       End If
       'fin PRD-3860

       If Trim(Mensaje_Con) = "" And InStr(1, UCase(Mensaje_Con), "OK") > 0 Then
           SwResp = MsgBox("ATENCION" & vbCrLf & "LA OPERACION GENERARA LOS SIGUIENTES ERRORES" & Mensaje_Con & vbCrLf & vbCrLf & "¿Desea Grabar la Operación ?", vbYesNo + vbExclamation, hForm.Caption)

           If SwResp <> vbYes Then
           
               Call Lineas_BorraConsultaOperacion("BTR", dNumoper)

               If FlagTx = True Then
                   If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                       MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
                   End If
               End If
               Exit Function

           End If
       End If
    End If
    '********** Fin

    iCorrela% = 0
    iCorrVent = 1
    
    hForm.Data1.Recordset.MoveFirst
    Do While Not hForm.Data1.Recordset.EOF
        
        If hForm.Data1.Recordset("tm_venta") = "P" Or BacFrmIRF.Data1.Recordset("tm_venta") = "V" Then
            If Trim$(hForm.Data1.Recordset("tm_instser")) <> "" Then
                With hForm
                    lRutCar = .Data1.Recordset("tm_rutcart")
                    dNumdocu = .Data1.Recordset("tm_numdocu")
                    iCorrela = .Data1.Recordset("tm_correla")
                    sMascara$ = .Data1.Recordset("tm_mascara")
                    sInstSer$ = .Data1.Recordset("tm_instser")
                    sGenEmi$ = .Data1.Recordset("tm_genemi")
                    sNemMon$ = .Data1.Recordset("tm_nemmon")
                    dNominal = .Data1.Recordset("tm_nominal")
                    dTir# = .Data1.Recordset("tm_tir")
                    dPvp# = .Data1.Recordset("tm_pvp")
                    dVPar# = .Data1.Recordset("tm_vpar")
                    dVpTirV# = .Data1.Recordset("tm_vp")
                    dVpTirV100# = .Data1.Recordset("tm_vp100")
                    iNumUCup% = .Data1.Recordset("tm_numucup")
                    dTasEst# = .Data1.Recordset("tm_tasest")
                    sFecEmi$ = .Data1.Recordset("tm_fecemi")
                    sFecVen$ = .Data1.Recordset("tm_fecven")
                    lCodigo& = .Data1.Recordset("tm_codigo")
                    iMonemi% = .Data1.Recordset("tm_monemi")
                    lRutemi& = .Data1.Recordset("tm_rutemi")
                    dTasEmi# = .Data1.Recordset("tm_tasemi")
                    iBasemi% = .Data1.Recordset("tm_basemi")
                    sTipCus = .Data1.Recordset("tm_custodia")

                    sSerie$ = .Data1.Recordset("tm_serie")
                    sFecpcup$ = .Data1.Recordset("tm_fecpcup")
                    dValIniP = .Data1.Recordset("tm_vp")
                    dConvex = .Data1.Recordset("tm_convex")
                    dDurMod = .Data1.Recordset("tm_duratmod")
                    dDurmac = .Data1.Recordset("tm_duratmac")
                    sTipCus = Mid$(.Data1.Recordset("tm_custodia"), 1, 1)
                    clave_dcv = IIf(IsNull(.Data1.Recordset("tm_clave_dcv")), "", .Data1.Recordset("tm_clave_dcv"))
                    
                    cCarteraSuper = IIf(IsNull(.Data1.Recordset("tm_carterasuper")), "", .Data1.Recordset("tm_carterasuper"))
                    Codigo_Libro$ = IIf(IsNull(.Data1.Recordset("tm_id_libro")), "", .Data1.Recordset("tm_id_libro"))
                    '++GRC Req007
                    If Repos = "RP" Then
                        dPlazoRes = .Data1.Recordset("tm_diasdisp")
                        dMargen = .Data1.Recordset("tm_margen")
                        dValInicial = .Data1.Recordset("tm_valinicial")
                        If TipoCarga_RP = "A" Then
                            dCorr_SOMA = .Data1.Recordset("tm_Corr_SOMA")
                            dNumOper_SOMA = .Data1.Recordset("tm_NumOper_SOMA")
                        End If
                    End If
                    '--GRC Req007
                    
                     If dTipcam = 1 And iMonemi% <> 13 Then
                        dValIniUm = dValIniP
                     Else
'vgs                    dValIniUm = Round(dValIniP / dTipcam, 4)
                        dValIniUm = Round(BacFrmIRF.Calcula_Monto_Mx(dValIniP, iMonemi%, 999) / dTipcam, nRedon)
                        
                     End If

                     If iMonPact% <> 13 Then
                        dValIniP = Round(BacFrmIRF.Calcula_Monto_Mx(dValIniP, iMonemi%, 999), nRedon)
                     Else
                        dValIniP = Round(BacFrmIRF.Calcula_Monto_Mx(dValIniP, iMonemi%, iMonPact%), nRedon)
                     End If
                     
                     dFactor = dValIniUm / dTotalIniMP

                     If dTipcam = 1 Then
                        dValVenP = Round(dTotalVenMP * dFactor, 0)
                     Else
                        dValVenP = Round(dTotalVenMP * dFactor, 4)
                     End If

                     If (dValVenP + dTotalaux) >= dTotalVenMP Then
                        dValVenP = dValVenP + (dTotalVenMP - (dValVenP + dTotalaux))
                     End If
                        
                     dTotalaux = dTotalaux + dValVenP

                End With
               
                Envia = Array()
                AddParam Envia, dNumoper
                AddParam Envia, CDbl(lRutCar)
                AddParam Envia, CDbl(iTipCar)
                AddParam Envia, dNumdocu
                AddParam Envia, CDbl(iCorrela)
                AddParam Envia, dNominal
                AddParam Envia, dTir
                AddParam Envia, dPvp
                AddParam Envia, dVpTirV
                AddParam Envia, dVpTirV100
                AddParam Envia, dTasEst
                AddParam Envia, dVPar
                AddParam Envia, CDbl(iNumUCup)
                AddParam Envia, CDbl(lRutCli)
                AddParam Envia, CDbl(nCodigo)
                AddParam Envia, sTipCus
                AddParam Envia, CDbl(iForPagI)
                AddParam Envia, CDbl(iForPagV)
                AddParam Envia, sRetiro
                AddParam Envia, gsUsuario
                AddParam Envia, gsTerminal
               'Datos del Pacto
               '----------------------------------------------
                AddParam Envia, Format(sFecVenP, "yyyymmdd")
                AddParam Envia, CDbl(iMonPact)
                AddParam Envia, (dTasPact)
                AddParam Envia, CDbl(iBasPact)
                AddParam Envia, dValIniP
                AddParam Envia, dValVenP
               '----------------------------------------------
            
                AddParam Envia, sInstSer
                AddParam Envia, CDbl(lRutemi)
                AddParam Envia, CDbl(iMonemi)
                AddParam Envia, Format(CDate(sFecEmi), "yyyymmdd")
                AddParam Envia, Format(CDate(sFecVen), "yyyymmdd")
                AddParam Envia, CDbl(iCorrVent)
                AddParam Envia, Format(CDate(sFecpcup), "yyyymmdd")
                AddParam Envia, dConvex
                AddParam Envia, dDurMod
                AddParam Envia, dDurmac
                AddParam Envia, sTipCus
                AddParam Envia, clave_dcv
                AddParam Envia, dTPFE
                AddParam Envia, dTCCE
                AddParam Envia, cCarteraSuper  'Este es el Codigo de Categoría Cartera Super
                AddParam Envia, TCart
                AddParam Envia, Mercado
                AddParam Envia, Sucursal
                AddParam Envia, AreaResponsable
                AddParam Envia, Format(Fecha_PagoMañana, feFECHA)
                AddParam Envia, Laminas
                AddParam Envia, Tipo_Inversion
                AddParam Envia, CtaCteInicio
                AddParam Envia, SucInicio
                AddParam Envia, CtaCteFinal
                AddParam Envia, SucFinal
                AddParam Envia, sObserv$
                AddParam Envia, dTipcam#
                AddParam Envia, Codigo_Libro$
                
                '++GRC Req007
                If Repos = "RP" Then
                    AddParam Envia, dPlazoRes
                    AddParam Envia, dMargen
                    AddParam Envia, dValInicial
                    If TipoCarga_RP = "A" Then
                        AddParam Envia, dCorr_SOMA
                        AddParam Envia, dNumOper_SOMA
                    End If
                    If Not Bac_Sql_Execute("SP_GRABARRP", Envia) Then
                        GoTo BacErrorHandler
                    End If
                Else
                '--GRC Req007
 
                AddParam Envia, nTirTran
                AddParam Envia, nVFTran
                AddParam Envia, nDifTran_MO
                AddParam Envia, nDifTran_CLP
               If Not Bac_Sql_Execute("SP_GRABARVI", Envia) Then
                   GoTo BacErrorHandler
               End If
                End If
            
               Correlativo = hForm.Data1.Recordset("tm_correlao")
               
               If VPVI_GrabarCortesSQL(lRutCar, dNumdocu, iCorrela, dNumoper, Correlativo) = False Then
                   GoTo BacErrorHandler
               End If
            
               iCorrVent% = iCorrVent% + 1
            End If
         End If
                
         hForm.Data1.Recordset.MoveNext
        
    Loop
    
    '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then
    
        If Not Lineas_GrbOperacion("BTR", "VI ", dNumoper, dNumoper, " ", " ", " ") Then
            GoTo BacErrorHandler
        End If
        
    End If
    '********** Fin

   
   
   ' Actualizo Limites SETTLEMENT
   ' ==============================================================================================================================================================================================
   '  If Not funcValidaLimites_SETTLEMENT(BacIrfGr.txtRutCli.Text, BacIrfGr.TxtCodCli.Text, "VI", dNumdocu, 1, BacIrfGr.CmbFPagoIni.ItemData(BacIrfGr.CmbFPagoIni.ListIndex), BacIrfGr.proMtoOper, "S", 0, 0, 0) Then
   '     GoTo BacErrorHandler
   '     Exit Function
   '  End If
   ' ----------------------------------------------------------------------------------------------------
   ' Grabo Exceso Limites SETTLEMENT
   ' ----------------------------------------------------------------------------------------------------
   ' If iCodExcesoSETTLE <> 0 Then
   '    If Not funcGrabaExcesos(dNumoper, 1, "VI", "SETTLE", iCodExcesoSETTLE, dMtoExcesoSETTLE, "G", (DateDiff("d", CDate(hForm.TxtFecIni.Text), CDate(hForm.TxtFecVct.Text))), BacIrfGr.txtRutCli.Text, BacIrfGr.TxtCodCli.Text, BacIrfGr.proMtoOper) Then
   '           GoTo BacErrorHandler
   '    End If
   ' End If
    
   ' Actualizo Limites PFE y CCE
   ' ----------------------------------------------------------------------------------------------------
   ' Public Function funcValidacionLimites_PFE_CCE_VI(dRut , nCod , dTotal , cTipo , ByRef dPFE , ByRef dCCE , ByRef iCodExceso_PFE , ByRef dMtoExceso_PFE , ByRef iCodExceso_CCE , ByRef dMtoExceso_CCE )
   '  If Not funcValidacionLimites_PFE_CCE_VI(BacIrfGr.txtRutCli.Text, BacIrfGr.TxtCodCli.Text, 0, "S", dTPFE, dTCCE, 0, 0, 0, 0) Then
   '           GoTo BacErrorHandler
   '      Exit Function
   '  End If
    
  ' Grabo Exceso Limites PFE
  ' ----------------------------------------------------------------------------------------------------
   ' If iCodExcesoPFEcce <> 0 Then
   '     If Not funcGrabaExcesos(dNumoper, 1, "VI", "PFECCE", iCodExcesoPFEcce, dMtoExcesoPFEcce, "G", (DateDiff("d", CDate(hForm.TxtFecIni.Text), CDate(hForm.TxtFecVct.Text))), BacIrfGr.txtRutCli.Text, BacIrfGr.TxtCodCli.Text, dTPFE) Then
   '          GoTo BacErrorHandler
   '     End If
   '     iCodExcesoPFEcce = 0
   '     dMtoExcesoPFEcce = 0
   ' End If
    
  ' Grabo Exceso Limites CCE
  ' ----------------------------------------------------------------------------------------------------
  '  If iCodExcesopfeCCE_1 <> 0 Then
  '      If Not funcGrabaExcesos(dNumoper, 1, "VI", "PFECCE", iCodExcesopfeCCE_1, dMtoExcesopfeCCE_1, "G", (DateDiff("d", CDate(hForm.TxtFecIni.Text), CDate(hForm.TxtFecVct.Text))), BacIrfGr.txtRutCli.Text, BacIrfGr.TxtCodCli.Text, dTCCE) Then
  '           GoTo BacErrorHandler
  '      End If
  '      iCodExcesopfeCCE_1 = 0
  '      dMtoExcesopfeCCE_1 = 0
  '  End If
    Valor_antiguo = " "
    Valor_antiguo = "Operacion:" & dNumoper & ";VI;" & "Rut Cliente:" & lRutCli & "Codigo Cliente:" & nCodigo & ";Forma de Pago Inicio:" & iForPagI & ";Forma de Pago Venc:" & iForPagV & ";Tasa Pacto:" & dTasPact

    'Grabación del control de precios y tasas
    resControlPT = ControlPreciosTasas("VI", iMonPact%, lPlazo&, dTasPact#, False)
    
    If Ctrlpt_AplicarControl Then
    If Ctrlpt_ModoOperacion = "S" Then
        'Modo silencioso
        Ctrlpt_codProducto = "VI"
        Ctrlpt_NumOp = dNumoper
        Ctrlpt_NumDocu = ""
        Ctrlpt_TipoOp = "V"
        Ctrlpt_Correlativo = 1
        Call GrabaModoSilencioso
    Else
            'grabar el instrumento ssi EnviarCF = "S"
            If EnviarCF = "S" Then
        Ctrlpt_codProducto = "VI"
        Ctrlpt_NumOp = dNumoper
        Ctrlpt_NumDocu = ""
        Ctrlpt_TipoOp = "V"
        Ctrlpt_Correlativo = 1
        Call GrabaLineaPendPrecios
                Call GrabaModoSilencioso    '--> PRD-10494 Incidencia 1
    End If
    End If
    End If

    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, _
     "BTR", "Opc_20400", "01", "Venta con Pacto", "mdvi,mdmo,mddi", Valor_antiguo, " ")

    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        GoTo BacErrorHandler
    End If
    
    VI_GrabarTx = dNumoper
    
    Exit Function
        
BacErrorHandler:

    '++GRC Req007
    If Repos = "RP" Then
        MsgBox "NO SE COMPLETO LA GRABACION DE REPOS CON EXITO", vbExclamation, gsBac_Version
    Else
    '--GRC Req007
    MsgBox "NO SE COMPLETO LA GRABACION DE VENTA CON PACTO CON EXITO", vbExclamation, gsBac_Version
    '++GRC Req007
    End If
    '--GRC Req007
    
    If FlagTx = True Then
        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
            MsgBox " NO SE PUDO REALIZAR ROLLBACK", vbExclamation, gsBac_Version
        End If
    End If
   
    VI_GrabarTx = 0
    Exit Function
    
End Function

Public Function VI_GrabarTx_NuevoForm( _
   lRutCar&, iTipCar%, iForPagI&, iForPagV&, sTipCus$, sRetiro$, _
   sPagMan$, sObserv$, lRutCli&, nCodigo, hForm As Form, dTPFE As Double, _
   dTCCE As Double, TCart$, Mercado$, Sucursal$, AreaResponsable$, Fecha_PagoMañana$, _
   Laminas$, Tipo_Inversion$, CtaCteInicio$, SucInicio$, CtaCteFinal$, SucFinal$, Repos$) As Double
      
   Dim Datos()
   Dim iCorrela%
   Dim iCorrVent%
   Dim sMascara$, sInstSer$, sGenEmi$, sNemMon$, dNominal#, dTir#, dPvp#, sFecpcup$
   Dim dVPar#, dVpTirV#, dVpTirV100#, iNumUCup%, dTasEst#, sFecEmi$, sFecVen$
   Dim sMdse$, lCodigo&, sSerie$, iMonemi%, lRutemi&, dTasEmi#, iBasemi%
   Dim dTipcam#
   Dim sFecIniP$, sFecVenP$, dValIniP#, dValVenP#, dTasPact#
   Dim lPlazo&, iBasPact%, iMonPact%, dTotalIniMP#, dTotalVenMP#
   Dim dFactor#, dTotalaux#, dValIniUm#, dTotalIniaux#
   Dim dNumoper#
   Dim sFecPro$
   Dim Resultado%
   Dim Correlativo&
   Dim dConvex     As Double
   Dim dDurMod     As Double
   Dim dDurmac     As Double
   Dim clave_dcv   As String
   Dim FlagTx      As Boolean
   Dim dNumdocu    As Double
   Dim cCarteraSuper As String
   Dim nRedon       As Integer
   Dim Codigo_Libro$
   '++GRC Req007
   Dim dPlazoRes   As Integer
   Dim dMargen     As Double
   Dim dValInicial As Double
   Dim dCorr_SOMA  As Integer
   Dim dNumOper_SOMA As Integer
   '--GRC Req007
   Dim nTirTran     As Double
   Dim nVFTran      As Double
   Dim nDifTran_MO  As Double
   Dim nDifTran_CLP As Double
   
   Dim resControlPT As String
   Dim Mensaje_CPT As String
   
   Dim iDetCorrelativo As Integer 'PRD-6006-CASS 10-12-2010
   
   On Error GoTo BacErrorHandler

    sFecIniP$ = hForm.TxtFecIni.text
    sFecVenP$ = hForm.TxtFecVct.text
    dTotalIniMP# = CDbl(hForm.txtIniPMP.text)
    dTotalVenMP# = CDbl(hForm.txtVenPMP.text)
    dTasPact# = CDbl(hForm.TxtTasa.text)
    lPlazo& = Val(hForm.TxtPlazo.text)
    iMonPact% = Val(hForm.CmbMon.ItemData(BacFrmIRF.CmbMon.ListIndex))
    iBasPact% = funcBaseMoneda(iMonPact%) ' Val(hForm.cmbBase.List(BacFrmIRF.cmbBase.ListIndex))
    nRedon = BacDatGrMon.mndecimal
    dTipcam# = CDbl(hForm.txtTipoCambio.text)
    sFecPro = Format$(gsBac_Fecp, "mm/dd/yyyy")
    
    If Repos$ = "RP" Then
        nTirTran = 0
        nVFTran = 0
        nDifTran_MO = 0
        nDifTran_CLP = 0
    Else
        nTirTran = hForm.Txt_TasaTran.text
        nVFTran = hForm.Txt_VFTran.text
        nDifTran_MO = hForm.Txt_DifTran.text
        nDifTran_CLP = hForm.Txt_Dif_CLP.text
    End If
    
    FlagTx = False
    
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        GoTo BacErrorHandler
    End If
    
    FlagTx = True

    If Not Bac_Sql_Execute("SP_OPMDAC") Then
       GoTo BacErrorHandler
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
        dNumoper = Val(Datos(1))
    End If

    '********** Linea -- Mkilo
       If gsBac_Lineas = "S" Then
   
           Dim Mensaje     As String
   
           Mensaje = ""
           
           iCorrela% = 0
           iDetCorrelativo = 0 'PRD-6006 CASS 10-12-2010
           
           For iDetCorrelativo = 1 To hForm.GrillaGrabarPctos.Rows - 1
   
                         With hForm
                           dNumdocu = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_Documento)        '.Data1.Recordset("tm_numdocu")
                           dNumdocu = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_Correlativo)      '.Data1.Recordset("tm_correla")
                           dNominal = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_NominalVenta)     '.Data1.Recordset("tm_nominal")
                           dVpTirV# = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_PvpVenta)         '.Data1.Recordset("tm_vp")
                           sFecVen$ = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_FechaVencimiento) '.Data1.Recordset("tm_fecven")
                           lCodigo& = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_InCodigo)         '.Data1.Recordset("tm_codigo")
                           iMonemi% = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_MonedaEmision)    '.Data1.Recordset("tm_monemi")
                           lRutemi& = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_RutEmisor)        '.Data1.Recordset("tm_rutemi")
                           sSerie$ = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_InstSer)              '.Data1.Recordset("tm_mdse")
                         End With
                   
                       'If Not Lineas_ChequearGrabar("BTR", "VI ", dNumoper, dNumdocu, CDbl(dNumdocu), CDbl(lRutCli), CDbl(nCodigo), dVpTirV#, gsBac_TCambio, BacFrmIRF.TxtFecVct.Text, CDbl(lRutemi&), iMonemi%, hForm.Data1.Recordset("tm_fecven"), CDbl(lCodigo&), sSerie$, 0, "C", 0, "N", 0, gsBac_Fecp, 0, 0, hForm.Data1.Recordset("tm_tir"), dTasPact#, hForm.Data1.Recordset("tm_instser")) Then 'PRD-6006 CASS 09-12-2010
                        If Not Lineas_ChequearGrabar("BTR", _
                                                      "VI ", _
                                                      dNumoper, _
                                                      dNumdocu, _
                                                      CDbl(dNumdocu), _
                                                      CDbl(lRutCli), _
                                                      CDbl(nCodigo), _
                                                      dVpTirV#, _
                                                      gsBac_TCambio, _
                                                      BacFrmIRF.TxtFecVct.text, _
                                                      CDbl(lRutemi&), _
                                                      iMonemi%, _
                                                      CDate(sFecVen$), _
                                                      CDbl(lCodigo&), _
                                                      sSerie$, _
                                                      0, _
                                                      "C", _
                                                      0, _
                                                      "N", _
                                                      0, _
                                                      gsBac_Fecp, _
                                                      0, _
                                                      0, _
                                                      hForm.GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_TirVenta), _
                                                      dTasPact#, hForm.GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_InstSer)) Then
                           GoTo BacErrorHandler
                       End If
                       
           Next
           
           Mensaje = Mensaje & Lineas_Chequear("BTR", "VI ", dNumoper, " ", " ", " ")
           
           If Mensaje <> "" Then
           
               MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical
               
               If FlagTx = True Then
                   If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                       MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
                   End If
               End If
   
               VI_GrabarTx_NuevoForm = 0
               
               Exit Function
               
           End If
       
       End If
    
    '********** Fin

      'PRD-3860, (modo silencioso)
      If Ctrlpt_ModoOperacion = "S" Then
          Mensaje_CPT = ""
      Else
          Mensaje_CPT = Ctrlpt_Mensaje
      End If
      'fin PRD-3860


       '********** Linea -- Mkilo
       If gsBac_Lineas = "S" Then
   
             Dim Mensaje_Con As String
             Dim SwResp      As Integer
      
             Mensaje_Con = Lineas_ConsultaOperacion("BTR", "VI ", dNumoper, " ", " ", " ")
      
             'PRD-3860, agregarle el mensaje del control de precios y tasas si está en modo normal
             If Trim(Mensaje_CPT) <> "" Then
                  Mensaje_Con = Mensaje_Con & vbCrLf & vbCrLf & Mensaje_CPT
             End If
             'fin PRD-3860
      
             If Trim(Mensaje_Con) = "" And InStr(1, UCase(Mensaje_Con), "OK") > 0 Then
                 SwResp = MsgBox("ATENCION" & vbCrLf & "LA OPERACION GENERARA LOS SIGUIENTES ERRORES" & Mensaje_Con & vbCrLf & vbCrLf & "¿Desea Grabar la Operación ?", vbYesNo + vbExclamation, hForm.Caption)
      
                 If SwResp <> vbYes Then
                 
                     Call Lineas_BorraConsultaOperacion("BTR", dNumoper)
      
                     If FlagTx = True Then
                         If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                             MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
                         End If
                     End If
                     Exit Function
      
                 End If
             End If
             
       End If
       '********** Fin
   
       'iCorrela% = 0            'PRD-6006 CASS 10-12-2010
       iDetCorrelativo = 0
       iCorrVent = 1
       
       Dim iUltimoRegistro As Long
       Let iUltimoRegistro = hForm.GrillaGrabarPctos.Rows - 1

       
           For iDetCorrelativo = 1 To hForm.GrillaGrabarPctos.Rows - 1
           
                   With hForm
                   
                       lRutCar = gsBac_CartRUT                                                                 '.Data1.Recordset("tm_rutcart")
                       dNumdocu = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_Documento)             '.Data1.Recordset("tm_numdocu")
                       iCorrela = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_Correlativo)           '.Data1.Recordset("tm_correla")
                       sInstSer$ = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_InstSer)              '.Data1.Recordset("tm_instser")
                       dNominal = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_NominalVenta)          '.Data1.Recordset("tm_nominal")
   
                       dTir# = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_TirVenta)                 '.Data1.Recordset("tm_tir")
                       dPvp# = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_VParVenta)                '.Data1.Recordset("tm_pvp")
                       dVPar# = 0                                                                              '.Data1.Recordset("tm_vpar")
                       dVpTirV# = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_ValorVenta)             '.Data1.Recordset("tm_vp")
                       dVpTirV100# = 0                                                                         '.Data1.Recordset("tm_vp100")
                       iNumUCup% = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_NumUltCup)            '.Data1.Recordset("tm_numucup")
                       dTasEst# = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_TasaEstimada)          '.Data1.Recordset("tm_tasest")
   
                       sFecEmi$ = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_FechaEmision)          '.Data1.Recordset("tm_fecemi")
                       sFecVen$ = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_FechaVencimiento)      '.Data1.Recordset("tm_fecven")
                       lCodigo& = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_InCodigo)              '.Data1.Recordset("tm_codigo")
                       iMonemi% = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_MonedaEmision)         '.Data1.Recordset("tm_monemi")
                       lRutemi& = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_RutEmisor)             '.Data1.Recordset("tm_rutemi")
                       dTasEmi# = 0                                                                            '.Data1.Recordset("tm_tasemi")  'No se esta grabando
                       iBasemi% = 0                                                                            '.Data1.Recordset("tm_basemi")  'No se esta grabando
                       sTipCus = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_icustodia)              '.Data1.Recordset("tm_custodia")
   
                       sSerie$ = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_InstSer)                '.Data1.Recordset("tm_serie")
                       sFecpcup$ = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_FecProxCupon)         '.Data1.Recordset("tm_fecpcup") 'Fecha Pago Prox CUpon
                       dValIniP = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_ValorInicial)          '.Data1.Recordset("tm_vp")       'Valor Pte con la Tir Mercado
                       dConvex = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_Convexidad)             '.Data1.Recordset("tm_convex")    'Faltan
                       dDurMod = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_DurationModificado)     '.Data1.Recordset("tm_duratmod")  'Faltan
                       dDurmac = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_DurationMacaulay)       '.Data1.Recordset("tm_duratmac")  'Faltan
                       
                       sTipCus = Mid$(.GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_icustodia), 1, 1)  'Mid$(.Data1.Recordset("tm_custodia"), 1, 1)
                       clave_dcv = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_ClaveDcv)             'IIf(IsNull(.Data1.Recordset("tm_clave_dcv")), "", .Data1.Recordset("tm_clave_dcv"))
                       
                       cCarteraSuper = IIf(IsNull(.GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_CarteraSuper)), "", .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_CarteraSuper)) ''IIf(IsNull(.Data1.Recordset("tm_carterasuper")), "", .Data1.Recordset("tm_carterasuper"))
                       Codigo_Libro$ = .GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_Libro)                                                                'IIf(IsNull(.Data1.Recordset("tm_id_libro")), "", .Data1.Recordset("tm_id_libro"))
                       
                       '++GRC Req007
                       If Repos = "RP" Then
                           dPlazoRes = .Data1.Recordset("tm_diasdisp")
                           dMargen = .Data1.Recordset("tm_margen")
                           dValInicial = .Data1.Recordset("tm_valinicial")
                           If TipoCarga_RP = "A" Then
                               dCorr_SOMA = .Data1.Recordset("tm_Corr_SOMA")
                               dNumOper_SOMA = .Data1.Recordset("tm_NumOper_SOMA")
                           End If
                       End If
                       '--GRC Req007
                       
                        If dTipcam = 1 And iMonemi% <> 13 Then
                           dValIniUm = dValIniP
                        Else
   'vgs                    dValIniUm = Round(dValIniP / dTipcam, 4)
                           dValIniUm = Round(BacFrmIRF.Calcula_Monto_Mx(dValIniP, iMonemi%, 999) / dTipcam, nRedon)
                           
                        End If
   
                        If iMonPact% <> 13 Then
                           dValIniP = Round(BacFrmIRF.Calcula_Monto_Mx(dValIniP, iMonemi%, 999), nRedon)
                        Else
                           dValIniP = Round(BacFrmIRF.Calcula_Monto_Mx(dValIniP, iMonemi%, iMonPact%), nRedon)
                        End If
                        
                        dFactor = dValIniUm / dTotalIniMP
   
                        If dTipcam = 1 Then
                           dValVenP = Round(dTotalVenMP * dFactor, 0)
                        Else
                           dValVenP = Round(dTotalVenMP * dFactor, 4)
                        End If
   
                        If (dValVenP + dTotalaux) >= dTotalVenMP Then
                           dValVenP = dValVenP + (dTotalVenMP - (dValVenP + dTotalaux))
                        End If
                           
                                               
                        dTotalIniaux# = dTotalIniaux + dValIniP
                        dTotalaux = dTotalaux + dValVenP
                        
                    '' Ajuste  de  decimales
                    '' Valor Inicial
                        If iDetCorrelativo = iUltimoRegistro And dTotalIniMP <> dTotalaux Then
                            dValIniP = dValIniP + (dTotalIniMP - dTotalIniaux)
                        End If
                                        
                    '' Valor Final
                        If iDetCorrelativo = iUltimoRegistro And dTotalVenMP <> dTotalaux Then
                            dValVenP = dValVenP + (dTotalVenMP - dTotalaux)
                        End If
   
                   End With
                  
                   Envia = Array()
                   AddParam Envia, dNumoper
                   AddParam Envia, CDbl(lRutCar)
                   AddParam Envia, CDbl(iTipCar)
                   AddParam Envia, dNumdocu
                   AddParam Envia, CDbl(iCorrela)
                   AddParam Envia, dNominal
                   AddParam Envia, dTir
                   AddParam Envia, dPvp
                   AddParam Envia, dVpTirV
                   AddParam Envia, dVpTirV100
                   AddParam Envia, dTasEst
                   AddParam Envia, dVPar
                   AddParam Envia, CDbl(iNumUCup)
                   AddParam Envia, CDbl(lRutCli)
                   AddParam Envia, CDbl(nCodigo)
                   AddParam Envia, sTipCus
                   AddParam Envia, CDbl(iForPagI)
                   AddParam Envia, CDbl(iForPagV)
                   AddParam Envia, sRetiro
                   AddParam Envia, gsUsuario
                   AddParam Envia, gsTerminal
                  'Datos del Pacto
                  '----------------------------------------------
                   AddParam Envia, Format(sFecVenP, "yyyymmdd")
                   AddParam Envia, CDbl(iMonPact)
                   AddParam Envia, (dTasPact)
                   AddParam Envia, CDbl(iBasPact)
                   AddParam Envia, dValIniP
                   AddParam Envia, dValVenP
                  '----------------------------------------------
               
                   AddParam Envia, sInstSer
                   AddParam Envia, CDbl(lRutemi)
                   AddParam Envia, CDbl(iMonemi)
                   'AddParam Envia, Format(CDate(sFecEmi), "yyyymmdd") 'PRD-6006 13-12-2010
                   AddParam Envia, sFecEmi
                   AddParam Envia, Format(CDate(sFecVen), "yyyymmdd")
                   AddParam Envia, CDbl(iCorrVent)
                   'AddParam Envia, Format(CDate(sFecpcup), "yyyymmdd") 'PRD-6006 13-12-2010
                   AddParam Envia, sFecpcup
                   AddParam Envia, dConvex
                   AddParam Envia, dDurMod
                   AddParam Envia, dDurmac
                   AddParam Envia, sTipCus
                   AddParam Envia, clave_dcv
                   AddParam Envia, dTPFE
                   AddParam Envia, dTCCE
                   AddParam Envia, cCarteraSuper  'Este es el Codigo de Categoría Cartera Super
                   AddParam Envia, TCart
                   AddParam Envia, Mercado
                   AddParam Envia, Sucursal
                   AddParam Envia, AreaResponsable
                   AddParam Envia, Format(Fecha_PagoMañana, feFECHA)
                   AddParam Envia, Laminas
                   AddParam Envia, Tipo_Inversion
                   AddParam Envia, CtaCteInicio
                   AddParam Envia, SucInicio
                   AddParam Envia, CtaCteFinal
                   
                   '    AddParam Envia, SucFinal    --20190104.RCH.LCGP
                   If BacGrabar.mFCIC = "S" Then
                        AddParam Envia, "FCIC"
                   ElseIf Repos = "LCGP" Then
                        AddParam Envia, "LCGP"
                   Else
                        AddParam Envia, SucFinal
                   End If
                   
                   '--20190104.RCH.LCGP
                   AddParam Envia, sObserv$
                   AddParam Envia, dTipcam#
                   AddParam Envia, Codigo_Libro$
                   
                   '++GRC Req007
                   If Repos = "RP" Then
                       AddParam Envia, dPlazoRes
                       AddParam Envia, dMargen
                       AddParam Envia, dValInicial
                       If TipoCarga_RP = "A" Then
                           AddParam Envia, dCorr_SOMA
                           AddParam Envia, dNumOper_SOMA
                       End If
                       If Not Bac_Sql_Execute("SP_GRABARRP", Envia) Then
                           GoTo BacErrorHandler
                       End If
                   Else
                   '--GRC Req007
                        AddParam Envia, nTirTran
                        AddParam Envia, nVFTran
                        AddParam Envia, nDifTran_MO
                        AddParam Envia, nDifTran_CLP
                       
                        If Not Bac_Sql_Execute("SP_GRABARVI", Envia) Then
                           GoTo BacErrorHandler
                        End If
                   End If
               
                  'Correlativo = hForm.Data1.Recordset("tm_correlao")'PRD-6006 13-12-2010
                  
                  'Maria Paz Navarro
                  'Se realizara mantencion de cortes con Sp_genera_cortes
                  'despues de la grabacion de la operacion de pacto
                  'Faltaria monitorear las ventas definitivas
                  'If VtasConPcto_GrabarCortesSQL(hForm.GrillaGrabarPctos.TextMatrix(iDetCorrelativo, ColDet_MarcaVta), lRutCar&, dNumdocu, iCorrela, dNumoper) = False Then
                  '   GoTo BacErrorHandler
                  'End If
               
                iCorrVent% = iCorrVent% + 1
       Next
       
         '********** Linea -- Mkilo
         If gsBac_Lineas = "S" Then
         
             If Not Lineas_GrbOperacion("BTR", "VI ", dNumoper, dNumoper, " ", " ", " ") Then
                 GoTo BacErrorHandler
             End If
             
         End If
         '********** Fin
   
          Valor_antiguo = " "
          Valor_antiguo = "Operacion:" & dNumoper & ";VI;" & "Rut Cliente:" & lRutCli & "Codigo Cliente:" & nCodigo & ";Forma de Pago Inicio:" & iForPagI & ";Forma de Pago Venc:" & iForPagV & ";Tasa Pacto:" & dTasPact
      
          'Grabación del control de precios y tasas
          resControlPT = ControlPreciosTasas("VI", iMonPact%, lPlazo&, dTasPact#, False)
          
    If Ctrlpt_AplicarControl Then
         If Ctrlpt_ModoOperacion = "S" Then
             'Modo silencioso
             Ctrlpt_codProducto = "VI"
             Ctrlpt_NumOp = dNumoper
             Ctrlpt_NumDocu = ""
             Ctrlpt_TipoOp = "V"
             Ctrlpt_Correlativo = 1
             Call GrabaModoSilencioso
         Else
             'grabar el instrumento ssi EnviarCF = "S"
             If EnviarCF = "S" Then
             Ctrlpt_codProducto = "VI"
             Ctrlpt_NumOp = dNumoper
             Ctrlpt_NumDocu = ""
             Ctrlpt_TipoOp = "V"
             Ctrlpt_Correlativo = 1
             Call GrabaLineaPendPrecios
                Call GrabaModoSilencioso    '--> PRD-10494 Incidencia 1
         End If
         End If
       
    End If
        'Control de Bloqueos de Clientes, PRD-6066
        motBloqueoClt = ""
        codBloqueoClt = -1
        
        If ClienteBloqueado("BTR", CDbl(lRutCli), CDbl(nCodigo), codBloqueoClt, motBloqueoClt) Then
            Call GrabaBloqueoCliente("BTR", "VI", dNumoper, "V", codBloqueoClt, motBloqueoClt)
        End If
        'fin PRD-6066


    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, _
     "BTR", "Opc_20400", "01", "Venta con Pacto", "mdvi,mdmo,mddi", Valor_antiguo, " ")

    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        GoTo BacErrorHandler
    End If
    
    Call Fnc_Genera_Cortes

    VI_GrabarTx_NuevoForm = dNumoper
    
    Exit Function
        
BacErrorHandler:

    '++GRC Req007
    If Repos = "RP" Then
        MsgBox "NO SE COMPLETO LA GRABACION DE REPOS CON EXITO", vbExclamation, gsBac_Version
    Else
         '--GRC Req007
          MsgBox "NO SE COMPLETO LA GRABACION DE VENTA CON PACTO CON EXITO", vbExclamation, gsBac_Version
         '++GRC Req007
    End If
    '--GRC Req007
    
    If FlagTx = True Then
        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
            MsgBox " NO SE PUDO REALIZAR ROLLBACK", vbExclamation, gsBac_Version
        End If
    End If
   
    VI_GrabarTx_NuevoForm = 0
    Exit Function
    

End Function

Public Function Fnc_Genera_Cortes()
    'CASS 02-03-2011. Se agrega la mantención de cortes.
    Fnc_Genera_Cortes = False
    
    If BacBeginTransaction() Then
    
      If Not Bac_Sql_Execute("SP_GENERA_CORTES") Then
         MsgBox "Ha ocurrido un error al generar cortes", vbExclamation, gsBac_Version
         BacRollBackTransaction
         Exit Function
      End If

      Call BacCommitTransaction
    End If

    Fnc_Genera_Cortes = True
    
End Function

'PRD-6006 CASS 14-12-2010
Public Function VtasConPcto_GrabarCortesSQL(MarcaVta As String, Rutcart&, NumDocu#, correla%, Numoper#) As Boolean
    
    Dim Datos()
    
    VtasConPcto_GrabarCortesSQL = False

    Envia = Array(NumDocu, _
             correla%)
    
    If Not Bac_Sql_Execute("SP_TRAE_CORTES", Envia) Then
      MsgBox "Ha ocurrido un error al ejecutar procedimientos."
      Exit Function
    End If
    
    If MarcaVta = "P" Then
       Do While Not Bac_SQL_Fetch(Datos())
            Envia = Array(CDbl(Datos(1)), _
                    NumDocu#, _
                    CDbl(correla%), _
                    Numoper, _
                    CDbl(Datos(5)), _
                    CDbl(Datos(4)))

                    If Not Bac_Sql_Execute("SP_VTCORTESPARCIAL", Envia) Then
                        Exit Function
                    End If
       Loop
    Else
        Envia = Array(CDbl(Rutcart&), _
                NumDocu#, _
                CDbl(correla%), _
                Numoper#)
                
                If Not Bac_Sql_Execute("SP_VTCORTESTOTAL", Envia) Then
                   Exit Function
                End If
    End If

    VtasConPcto_GrabarCortesSQL = True
    
End Function

Public Function CI_GrabarTx( _
   lRutCar&, iTipCar%, lForPagI&, lForPagV&, sTipCus$, sRetiro$, sPagMan$, sObserv$, _
   lRutCli&, nCodigo&, hForm As Form, dTPFE As Double, dTCCE As Double, TCart$, _
   Mercado$, Sucursal$, AreaResponsable$, Fecha_PagoMañana$, Laminas$, Tipo_Inversion$, _
   CtaCteInicio$, SucInicio$, CtaCteFinal$, SucFinal$, Codigo_Libro$, _
   Ejecutivo$, Rentabilidad$, iforpagSub&, iforpagSub2&) As Double

Dim SQL$
Dim Datos()
Dim iCorrela%
Dim sMascara$, sInstSer$, sGenEmi$, sNemMon$, dNominal#, dTir#
Dim dPvp#, dVPar#, dMt#, dMt100#, iNumUCup%, dTasEst#, sFecEmi$
Dim sFecVen$, sMdse$, lCodigo&, sSerie$, iMonemi%, lRutemi&
Dim dTasEmi#, iBasemi%
Dim dTirMcd#, dPvpMcd#, dMtMcd#, dMtMcd100#
Dim dTipcam#
Dim sFecIniP$, sFecVenP$, dValIniP#, dValVenP#, dTasPact#, sFecpcup$
Dim dTasCFdo#
Dim lPlazo&, iBasPact%, iMonPact%, dTotalIniMP#, dTotalVenMP#
Dim dFactor#, dTotalaux#
Dim sFecPro$
Dim Resultado%
Dim Correlativo&
Dim CorteMin#
Dim Fecha_Pacto         As String
Dim FlagTx              As Boolean
Dim dNumdocu            As Double
Dim cCustodiaDCV        As String
Dim cClaveDCV           As String
'VB+- 27/06/2000 se crean estas variables para grabar en las compras propias estos datos
Dim dConvexidad         As Double
Dim dDuratMac           As Double
Dim dDuratMod           As Double
Dim dMontoAfecto_PFE    As Double
Dim dMontoAfecto_CCE    As Double
Dim cCarteraSuper       As String
Dim dValInipapel        As Double
Dim nRedon              As Integer
Dim TipoCli             As String
Dim Validar_Depositos   As Boolean
Dim Mensaje_DP          As String
Dim Dias_Deposito#
Dim nMonto              As Double
Dim nDifTran_MO         As Double
Dim nDifTran_CLP        As Double
Dim nTirTran            As Double
Dim nVFTran             As Double

Dim resControlPT As String
Dim Mensaje_CPT As String

On Error GoTo BacErrorHandler

    dMontoAfecto_PFE = 0
    dMontoAfecto_CCE = 0
    
    sFecIniP$ = Format$(BacFrmIRF.TxtFecIni.text, "yyyymmdd")
    sFecVenP$ = Format$(BacFrmIRF.TxtFecVct.text, "yyyymmdd")
    
    Fecha_Pacto$ = BacFrmIRF.TxtFecVct.text
    
    dTotalIniMP# = CDbl(BacFrmIRF.txtIniPMP.text)
    dTotalVenMP# = CDbl(BacFrmIRF.txtVenPMP.text)
    dTasPact# = CDbl(BacFrmIRF.TxtTasa.text) 'aqui

    '-> dTasCFdo# = CDbl(hForm.TXTCostoFdo.text) '--> ?
    dTasCFdo# = dTasPact

    lPlazo& = Val(BacFrmIRF.TxtPlazo.text)
    iMonPact% = Val(BacFrmIRF.CmbMon.ItemData(BacFrmIRF.CmbMon.ListIndex))
    iBasPact% = funcBaseMoneda(iMonPact%) ' Val(hForm.cmbBase.List(BacFrmIRF.cmbBase.ListIndex))
    nRedon = BacDatGrMon.mndecimal
    dTipcam# = CDbl(BacFrmIRF.txtTipoCambio.text) '' VGS funcBuscaTipcambio(IIf(iMonPact% = 13, 994, iMonPact%), Str(gsBac_Fecp))
    Call funcFindDatGralMoneda(iMonPact%)
    SwMx = BacDatGrMon.mnmx
    sFecPro = Format$(Now, "mm/dd/yyyy")
    
    
    nTirTran = hForm.Txt_TasaTran.text
    nVFTran = hForm.Txt_VFTran.text
    nDifTran_MO = hForm.Txt_DifTran.text
    nDifTran_CLP = hForm.Txt_Dif_CLP.text

    FlagTx = False
    Validar_Depositos = False
        
    SQL = "SELECT cltipcli FROM VIEW_CLIENTE WHERE clrut=" & lRutCli

    If Not Bac_Sql_Execute(SQL) Then
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then
        TipoCli = Datos(1)
    End If

    If TipoCli <> "1" Then
       Validar_Depositos = True
    End If
    
    '***********************************************************************
    
    Envia = Array()
    AddParam Envia, 6
    AddParam Envia, GLB_ID_SISTEMA
    AddParam Envia, Tipo_Operacion
    AddParam Envia, Codigo_Libro$
    AddParam Envia, GLB_CARTERA_NORMATIVA
    
    If Not Bac_Sql_Execute("SP_CON_INFO_COMBO", Envia) Then
        Screen.MousePointer = vbDefault
        Exit Function
    End If
    
    cCarteraSuper = ""

    If Bac_SQL_Fetch(Datos()) Then
            cCarteraSuper = Trim(Datos(2))
    End If

    If cCarteraSuper = "" Then
        Screen.MousePointer = vbDefault
        MsgBox "No se ha definido una Cartera Super por defecto para las compras con pacto.", vbExclamation
        Exit Function
    End If

    '***********************************************************************
             
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        GoTo BacErrorHandler
    End If
    
    FlagTx = True
                   
  ' Obtengo Numero de operación
  ' -----------------------------------------------------------------------------
    If Not Bac_Sql_Execute("SP_OPMDAC") Then
        GoTo BacErrorHandler
    End If
                
    If Bac_SQL_Fetch(Datos()) Then
        dNumdocu = Val(Datos(1))
    End If
  ' =============================================================================
  '********** valida madurez minima a los depositos de clientes distintos a bancos y financieras
    
    If Validar_Depositos = True Then

        hForm.Data1.Recordset.MoveFirst
        Mensaje_DP = ""
        Do While Not hForm.Data1.Recordset.EOF

           If Trim$(hForm.Data1.Recordset("tm_instser")) <> "" Then
                    With hForm
                        sFecEmi$ = .Data1.Recordset("tm_fecemi")
                        lCodigo& = .Data1.Recordset("tm_CODIGO")
                        sInstSer$ = .Data1.Recordset("tm_instser")
                        sNemMon$ = .Data1.Recordset("tm_nemmon")
                        Dias_Deposito# = DateDiff("d", CDate(.Data1.Recordset("tm_fecemi")), gsBac_Fecp)
                        Dias_Deposito# = DateDiff("d", gsBac_Fecp, CDate(.Data1.Recordset("tm_fecven")))
                    End With

                    '--> Controla que los días del Deposito no sean menores a los días del Pacto
                    If Dias_Deposito# < lPlazo& Then
                       Mensaje_DP = Mensaje_DP + "Serie :  " & sInstSer$ & "  " & sNemMon$ & "    Fecha emisión :  " & sFecEmi$ & "    Madurez : " & Dias_Deposito# & "  días  " + Chr(10) + Chr(13)
                    End If

                    'If lCodigo& = 14 Or lCodigo& = 9 Then
                    '   If Dias_Deposito# < 30 Then
                    '      Mensaje_DP = Mensaje_DP + "Serie :  " & sInstSer$ & "  " & sNemMon$ & "    Fecha emisión :  " & sFecEmi$ & "    Madurez : " & Dias_Deposito# & "  días  " + Chr(10) + Chr(13)
                    '   End If
                    'End If
                    '
                    'If lCodigo& = 11 Then
                    '   If Dias_Deposito# < 90 Then
                    '      Mensaje_DP = Mensaje_DP + "Serie :  " & sInstSer$ & "  " & sNemMon$ & "    Fecha emisión :  " & sFecEmi$ & "    Madurez : " & Dias_Deposito# & "  días  " + Chr(10) + Chr(13)
                    '   End If
                    'End If
            End If

            hForm.Data1.Recordset.MoveNext
        Loop

        If Mensaje_DP <> "" Then
            ''''Mensaje_DP = Mensaje_DP + Chr(10) + Chr(13) + "Madurez mínima es de 90 días para depósitos emitidos en UF y de 30 días para depósitos emitidos en CLP y DO desde su último endoso."
            Mensaje_DP = Mensaje_DP + Chr(10) + Chr(13) + "Madurez de los instrumentos debe ser superior a la madurez del pacto."
            MsgBox "Error al Chequear Papeles para Comprar : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje_DP, vbCritical
            CI_GrabarTx = 0
            
            If FlagTx = True Then
                If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                    MsgBox "No se pudo realizar devolución de transacción inicializada, Favor de comunicar al administrador de sistema", vbCritical, gsBac_Version
                End If
            End If

            Exit Function
        End If

    End If

    '********** Fin
  
    '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then

        Dim Mensaje     As String

        Mensaje = ""
        hForm.Data1.Recordset.MoveFirst
        iCorrela% = 0
                 
        Do While Not hForm.Data1.Recordset.EOF
        
            If Trim$(hForm.Data1.Recordset("tm_instser")) <> "" Then
            
                iCorrela% = iCorrela% + 1
                
                If CDbl(iMonPact) = 13 Then
                    nMonto = dTotalIniMP * gsBac_TCambio
                Else
                    nMonto = hForm.Data1.Recordset("tm_mt")
                End If
            
                If Not Lineas_ChequearGrabar("BTR", "CI ", dNumdocu, dNumdocu, CDbl(iCorrela), CDbl(lRutCli), CDbl(nCodigo), nMonto, gsBac_TCambio, BacFrmIRF.TxtFecVct.text, hForm.Data1.Recordset("tm_rutemi"), hForm.Data1.Recordset("tm_monemi"), hForm.Data1.Recordset("tm_fecven"), hForm.Data1.Recordset("tm_codigo"), hForm.Data1.Recordset("tm_mdse"), CDbl(iMonPact), "C", 0, "N", 0, gsBac_Fecp, 0, CDbl(lForPagI), hForm.Data1.Recordset("tm_TIR"), dTasPact#, hForm.Data1.Recordset("tm_instser")) Then 'hForm.Data1.Recordset("tm_codigo")
                    GoTo BacErrorHandler
                End If
                
            End If
            
            hForm.Data1.Recordset.MoveNext
        Loop
        
        
        Mensaje = Mensaje & Lineas_Chequear("BTR", "CI ", dNumdocu, " ", " ", " ")
        
        If Mensaje <> "" Then
        
            MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical
            
            If FlagTx = True Then
                If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                    MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
                End If
            End If

            CI_GrabarTx = 0
            
            Exit Function
            
        End If
    
    End If
    
    '********** Fin
  
    'PRD-3860 (modo silencioso)
    If Ctrlpt_ModoOperacion = "S" Then
        Mensaje_CPT = ""
    Else
        Mensaje_CPT = Ctrlpt_Mensaje
    End If
    If Trim(Mensaje_CPT) <> "" Then
        Mensaje_CPT = vbCrLf & vbCrLf & Mensaje_CPT
    End If
    
    'fin PRD-3860

    '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then

       Dim Mensaje_Con As String
       Dim SwResp      As Integer

       Mensaje_Con = Lineas_ConsultaOperacion("BTR", "CI ", dNumdocu, " ", " ", " ") & Mensaje_CPT

       If Trim(Mensaje_Con) = "" And InStr(1, UCase(Mensaje_Con), "OK") > 0 Then
            If Mensaje_Con <> "OK" Then
           SwResp = MsgBox("ATENCION" & vbCrLf & "LA OPERACION GENERARA LOS SIGUIENTES ERRORES" & Mensaje_Con & vbCrLf & vbCrLf & "¿Desea Grabar la Operación ?", vbYesNo + vbExclamation, hForm.Caption)

           If SwResp <> vbYes Then
           
               Call Lineas_BorraConsultaOperacion("BTR", dNumdocu)

               If FlagTx = True Then
                   If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                       MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
                   End If
               End If
               Exit Function

           End If
             End If
       End If


    End If
    '********** Fin

            
    iCorrela% = 0
    
    hForm.Data1.Recordset.MoveFirst
    Do While Not hForm.Data1.Recordset.EOF
                
        If Trim$(hForm.Data1.Recordset("tm_instser")) <> "" Then
                    
            With hForm
                sMascara$ = .Data1.Recordset("tm_mascara")
                sInstSer$ = .Data1.Recordset("tm_instser")
                sGenEmi$ = .Data1.Recordset("tm_genemi")
                sNemMon$ = .Data1.Recordset("tm_nemmon")
                dNominal# = .Data1.Recordset("tm_nominal")
                dTir# = .Data1.Recordset("tm_tir")
                dPvp# = .Data1.Recordset("tm_pvp")
                dVPar# = .Data1.Recordset("tm_vpar")
                dMt# = .Data1.Recordset("tm_mt")
                dMt100# = .Data1.Recordset("tm_mt100")
                dTirMcd# = .Data1.Recordset("tm_tirmcd")
                dPvpMcd# = .Data1.Recordset("tm_pvpmcd")
                dMtMcd# = .Data1.Recordset("tm_mtmcd")
                dMtMcd100# = .Data1.Recordset("tm_mtmcd100")
                iNumUCup% = .Data1.Recordset("tm_numucup")
                dTasEst# = .Data1.Recordset("tm_tasest")
                sFecEmi$ = .Data1.Recordset("tm_fecemi")
                sFecVen$ = .Data1.Recordset("tm_fecven")
                sMdse$ = .Data1.Recordset("tm_mdse")
                lCodigo& = .Data1.Recordset("tm_codigo")
                iMonemi% = .Data1.Recordset("tm_monemi")
                lRutemi& = .Data1.Recordset("tm_rutemi")
                dTasEmi# = .Data1.Recordset("tm_tasemi")
                iBasemi% = .Data1.Recordset("tm_basemi")
                sSerie$ = .Data1.Recordset("tm_serie")
                sFecpcup$ = .Data1.Recordset("tm_fecpcup")
                dValIniP = .Data1.Recordset("tm_mt")
                cCustodiaDCV = Mid$(.Data1.Recordset("tm_custodia"), 1, 1)
                cClaveDCV = IIf(IsNull(.Data1.Recordset("tm_clave_dcv")), "", .Data1.Recordset("tm_clave_dcv"))
              ' VB+ 27/06/2000  Se Agregan estas variables para guardar estos datos en la grabación
              ' -------------------------------------------------------
                dConvexidad = .Data1.Recordset("tm_convexidad")
                dDuratMac = .Data1.Recordset("tm_durationmac")
                dDuratMod = .Data1.Recordset("tm_durationmod")
              ' -------------------------------------------------------
                      
                If .Data1.Recordset.AbsolutePosition <> .Data1.Recordset.RecordCount Then
                    dFactor = BacFrmIRF.Calcula_Monto_Mx(dValIniP, iMonemi%, iMonPact%) / dTotalIniMP
                    dValVenP = dTotalVenMP# * dFactor
                    dTotalaux = dTotalaux + dValVenP
                Else
                    dValVenP = dTotalVenMP# - dTotalaux
                End If
                            
                If dTipcam# = 1 Or iMonemi% = 13 Then
                    If iMonPact% <> 999 Then
                        dValVenP = CVar(Format((BacFrmIRF.Calcula_Monto_Mx(dValIniP, iMonemi%, iMonPact%)) * (((dTasPact / (iBasPact * 100#)) * DateDiff("d", CDate(hForm.TxtFecIni.text), CDate(hForm.TxtFecVct.text))) + 1), "##,###,###,###,##0.00"))
                    Else
                        dValVenP = CVar(Format((BacFrmIRF.Calcula_Monto_Mx(dValIniP, iMonemi%, iMonPact%)) * (((dTasPact / (iBasPact * 100#)) * DateDiff("d", CDate(hForm.TxtFecIni.text), CDate(hForm.TxtFecVct.text))) + 1), "##,###,###,###,##0"))
                    End If
                Else
                    dValVenP = CVar(dValIniP / dTipcam# * (((dTasPact / (iBasPact * 100#)) * DateDiff("d", CDate(hForm.TxtFecIni.text), CDate(hForm.TxtFecVct.text))) + 1))
                End If
                
''                dValIniP = Round(BacFrmIRF.Calcula_Monto_Mx(dValIniP, iMonemi%, iMonPact%), nRedon)
                If iMonPact% <> 13 Then
                    dValIniP = Round(BacFrmIRF.Calcula_Monto_Mx(dValIniP, iMonemi%, 999), nRedon)
                Else
                    dValIniP = Round(BacFrmIRF.Calcula_Monto_Mx(dValIniP, iMonemi%, iMonPact%), nRedon)
                End If
            End With
                
            iCorrela% = iCorrela% + 1
            
            Envia = Array()
            AddParam Envia, CDbl(lRutCar)
            AddParam Envia, iTipCar
            AddParam Envia, dNumdocu
            AddParam Envia, CDbl(iCorrela)
            AddParam Envia, sMascara
            AddParam Envia, sInstSer
            AddParam Envia, sGenEmi
            AddParam Envia, sNemMon
            AddParam Envia, dNominal
            AddParam Envia, dTir
            AddParam Envia, dPvp
            AddParam Envia, dMt
            AddParam Envia, dMt100
            AddParam Envia, dTasEst
            AddParam Envia, dVPar
            AddParam Envia, CDbl(iNumUCup)
            AddParam Envia, dTirMcd
            AddParam Envia, dPvpMcd
            AddParam Envia, dMtMcd
            AddParam Envia, dMtMcd100
            AddParam Envia, sMdse
            AddParam Envia, CDbl(lCodigo)
            AddParam Envia, sSerie
            AddParam Envia, Format(sFecEmi, "yyyymmdd")
            AddParam Envia, Format(sFecVen, "yyyymmdd")
            AddParam Envia, CDbl(iMonemi)
            AddParam Envia, CDbl(lRutemi)
            AddParam Envia, dTasEmi
            AddParam Envia, CDbl(iBasemi)
            AddParam Envia, CDbl(lRutCli)
            AddParam Envia, CDbl(nCodigo)
            AddParam Envia, CDbl(lForPagI)
            AddParam Envia, CDbl(lForPagV)
            AddParam Envia, sTipCus
            AddParam Envia, sRetiro
            AddParam Envia, gsUsuario
            AddParam Envia, gsTerminal
                       
          ' Datos del Pacto
          ' =====================================================================
            AddParam Envia, sFecVenP
            AddParam Envia, CDbl(iMonPact)
            AddParam Envia, dTasPact
            AddParam Envia, CDbl(iBasPact)
            AddParam Envia, dValIniP
            AddParam Envia, dValVenP
          ' =====================================================================
          
            AddParam Envia, Format(sFecpcup, "yyyymmdd")
            AddParam Envia, cCustodiaDCV
            AddParam Envia, cClaveDCV
          ' VB+- 27/06/2000 Se agregan datos de Duratión a sentencia de grabación
            AddParam Envia, dConvexidad
            AddParam Envia, dDuratMac
            AddParam Envia, dDuratMod
            AddParam Envia, dTPFE
            AddParam Envia, dTCCE
            AddParam Envia, cCarteraSuper    'Este es el Codigo de Categoría Cartera Super
            AddParam Envia, TCart
            AddParam Envia, Mercado
            AddParam Envia, Sucursal
            AddParam Envia, AreaResponsable
            AddParam Envia, Format(Fecha_PagoMañana$, feFECHA)
            AddParam Envia, Laminas
            AddParam Envia, Tipo_Inversion
            AddParam Envia, CtaCteInicio
            AddParam Envia, SucInicio
            AddParam Envia, CtaCteFinal
            AddParam Envia, SucFinal
            AddParam Envia, sObserv$
            AddParam Envia, dTipcam#
            AddParam Envia, Codigo_Libro$
            
            AddParam Envia, nTirTran
            AddParam Envia, nVFTran
            AddParam Envia, nDifTran_MO
            AddParam Envia, nDifTran_CLP
            
            
            ''''''''LD1-COR-035
            AddParam Envia, Ejecutivo
            AddParam Envia, iforpagSub
            AddParam Envia, iforpagSub2
            AddParam Envia, dTasCFdo#
            ''''''''LD1-COR-035
                  
            If Not Bac_Sql_Execute("SP_GRABARCI", Envia) Then
                GoTo BacErrorHandler
            End If
                                 
            CorteMin# = hForm.Data1.Recordset("tm_cortemin")
            Correlativo = hForm.Data1.Recordset("tm_correlativo")
                     
            If CO_GrabarCortesSQL(lRutCar, dNumdocu, iCorrela, dNominal, Correlativo, CorteMin#) = False Then
                GoTo BacErrorHandler
            End If
                     
        End If
                            
        hForm.Data1.Recordset.MoveNext
               
    Loop
    
    
    '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then
    
        If Not Lineas_GrbOperacion("BTR", "CI ", dNumdocu, dNumdocu, " ", " ", " ") Then
            GoTo BacErrorHandler
        End If
        
        If MarcaAplicaLinea = 1 Then
        
            '+++CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
            iCorrela% = 1
            'Para cada linea de compra llamamos al IDD
            hForm.Data1.Recordset.MoveFirst
            Do While Not hForm.Data1.Recordset.EOF
                Dim oParametrosLinea As New clsControlLineaIDD
    
                With oParametrosLinea
                    .Modulo = "BTR"
                    .Producto = "CI"
                    .Operacion = dNumdocu
                    .Documento = dNumdocu
                    .Correlativo = iCorrela%
                    .Accion = "Y"
    
                    .RecuperaDatosLineaIDD
                    
                    .MontoArticulo84 = hForm.Data1.Recordset("tm_mt") 'imputa el valor presente
                    
                    .EjecutaProcesoWsLineaIDD
                End With
                Set oParametrosLinea = Nothing
                
                On Error GoTo seguirGrabacionCI 'si existe error debe seguir con flujo bac
                
                iCorrela% = iCorrela% + 1
                hForm.Data1.Recordset.MoveNext
                
            Loop
            '---CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
        End If
    End If
    '********** Fin
seguirGrabacionCI:
    
    Valor_antiguo = " "
    Valor_antiguo = "Operacion:" & dNumdocu & ";CI;" & "Rut Cliente:" & lRutCli & ";Codigo Cliente:" & nCodigo & ";Forma de Pago Inicio:" & lForPagI & ";Forma de Pago Venc:" & lForPagV & ";Tasa Pacto=" & dTasPact

    'Grabación del control de precios y tasas
    resControlPT = ControlPreciosTasas("CI", iMonPact%, lPlazo&, dTasPact#, False)
    
    If Ctrlpt_AplicarControl Then
    If Ctrlpt_ModoOperacion = "S" Then
        Ctrlpt_codProducto = "CI"
        Ctrlpt_NumOp = dNumdocu
        Ctrlpt_NumDocu = ""
        Ctrlpt_TipoOp = "C"
        Ctrlpt_Correlativo = 1
        Call GrabaModoSilencioso
    Else
        'grabar el instrumento ssi EnviarCF = "S"
        If EnviarCF = "S" Then
        Ctrlpt_codProducto = "CI"
        Ctrlpt_NumOp = dNumdocu
        Ctrlpt_NumDocu = ""
        Ctrlpt_TipoOp = "C"
        Ctrlpt_Correlativo = 1
        Call GrabaLineaPendPrecios
        Call GrabaModoSilencioso    '--> PRD-10494 Incidencia 1
    End If
    End If
    End If

    'Control de Bloqueos de Clientes, PRD-6066
    motBloqueoClt = ""
    codBloqueoClt = -1
    If ClienteBloqueado("BTR", CDbl(lRutCli), CDbl(nCodigo), codBloqueoClt, motBloqueoClt) Then
        Call GrabaBloqueoCliente("BTR", "CI", dNumdocu, "C", codBloqueoClt, motBloqueoClt)
    End If
    'fin PRD-6066

    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, _
     "BTR", "Opc_20300", "01", "Compra con Pacto", "mdci,mdmo,mddi", Valor_antiguo, " ")

    
    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        GoTo BacErrorHandler
    End If
    
    CI_GrabarTx = dNumdocu
    Exit Function
        
BacErrorHandler:

    MsgBox "Problemas en grabación de operación de compras con pacto: " & err.Description & ". Comunique al Administrador. ", vbCritical, gsBac_Version
    
    If FlagTx = True Then
        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
            MsgBox "No se logro realizar < ROLLBACK > de la transacción de grabación de compra con pacto, Comunique al Administrador.", vbCritical, gsBac_Version
        End If
    End If
    
    CI_GrabarTx = 0
    Exit Function
    
End Function

Public Sub BacAgrandaGrilla(oGrilla As Object, Row_ToTal As Long)

Dim Fila%

     With oGrilla
           .Redraw = False
        If .Rows < Row_ToTal Then

            For Fila% = 1 To (Row_ToTal - .Rows)
                .Rows = .Rows + 1
            Next Fila%
            
        Else
            .Rows = .Rows + 1
        End If
      .Redraw = True
    End With
     
End Sub
Sub PROC_POSICIONA_TEXTOX(GRILLA As Control, texto As Control)

    texto.Top = GRILLA.CellTop + GRILLA.Top
    texto.Left = GRILLA.CellLeft + GRILLA.Left
    texto.Height = GRILLA.CellHeight + 20
    texto.Width = GRILLA.CellWidth

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
                     MsgBox " Existe Codigo en la Tabla ", 16, " Mensaje "
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
        For Col% = 0 To .cols - 1
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

Public Function Proc_Valida_Fecha() As Boolean
    '=========================================================================
    'SubRutina   :   Proc_Carga_parametros
    'Objetivo    :   Verifica la fecha del sistema sea igual a la fecha MDAC
    'Fecha       :   Septiembre, 2013
    'Autor       :   Alejandro Contreras G.
    '=========================================================================
Dim cSql    As String
Dim Datos()
Dim xSistema As String
xSistema = "BTR"

On Error GoTo ErrTeso

    Proc_Valida_Fecha = False

    cSql = ""
    cSql = cSql & "EXECUTE Sp_Valida_Fechas_Cierre "
    cSql = cSql & "'" & Format$(gsBac_Fecp, "yyyymmdd") & "', "
    cSql = cSql & CStr(xSistema) & " "
        
        
    If Bac_Sql_Execute(cSql) Then
        Do While Bac_SQL_Fetch(Datos)
              If Val(Datos(1)) <> 0 Then
                MsgBox "Fechas no coinciden, la del Sistema con la de Proceso, el Sistema se Cerrará", vbCritical, gsBac_Version
                Exit Function
            End If
        Loop
    End If
    
    Proc_Valida_Fecha = True
    Exit Function
ErrTeso:
    MsgBox "Problemas con Procedimiento Sp_Valida_Fechas_Cierre : " & err.Description & ". Verifique.", vbCritical, gsBac_Version
    Exit Function
End Function
