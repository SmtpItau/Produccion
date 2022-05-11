Attribute VB_Name = "Nuevos"
Option Explicit
'VARIABLES DE ADMINISTRACION
'Global gsUsuario As String
Global gsSistema As String
'Global gsTerminal As String
Global gsNombreUs As String
Global gsUsuarioReal As String
Global Sql As String
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
Global Codcli   As String
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
    varssql = "EXECUTE sp_sw_parametros "
    
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
    varssql = "Sp_OpePen_lineas"
    
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
    
   If BacValidaRut(tex.Text, tex1.Text) = False Then
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

   Proc_Carga_Parametros = True
   
'    cSql = "sp_parametros_sistema"

    If Bac_Sql_Execute("sp_parametros_sistema") Then

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
            
            gsBac_TCambio = Datos(13)
           
          ' Variable que contiene el plazo minimo de pactos para papeles no BCCH
            DIAS_PACTO_PAPEL_NO_CENTRAL = Datos(14)
            MONTO_PATRIMONIO_EFECTIVO = Datos(15)
            
            BacTrader.Pnl_UF.Caption = "U.F. : " + Format(Datos(12), FDecimal)
            BacTrader.Pnl_DO.Caption = "D.O. : " + Format(Datos(13), FDecimal)
            BacTrader.Pnl_DO.Refresh
            BacTrader.Pnl_UF.Refresh
            BacTrader.Pnl_Entidad.Caption = gsBac_Clien
            BacTrader.Pnl_Fecha.Caption = gsBac_Fecp
        End If
    Else
       Proc_Carga_Parametros = False
       Exit Function
    
    End If
    
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
    cSql = cSql & "EXECUTE sp_moditesoreria "
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
    cSql = cSql & "EXECUTE sp_grabatesoreria "
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
    cSql = cSql & "EXECUTE sp_borratesoreria "
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
Dim Sql         As String
Dim Datos()
    
    ValidaRango% = False
    
'    Sql = "sp_verifica_pvmd '" & Serie & "', "
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
    
    If Bac_Sql_Execute("sp_verifica_pvmd", Envia) Then
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
    Max = obj.Coleccion.Count
            
    For F = 1 To Max
        If Trim$(obj.Coleccion(F).Glosa) = Trim(codi) Then
            BuscaGlosa = F - 1
            Exit For
        End If
    Next F
            
End Function

Public Sub BacGrabarTX()
Dim sWinTipo$
Dim sPasa$
Dim iContador   As Integer
Dim iConta      As Integer

    Set BacFrmIRF = BacTrader.ActiveForm
    
    If Chequear_MesaIng() = False Then
         Exit Sub
    End If
    
    sWinTipo$ = Mid$(BacFrmIRF.Tag, 1, 2)
    
    sPasa = True
    iContador = 0
    
    If sWinTipo$ = "RC" Or sWinTipo$ = "RV" Or sWinTipo$ = "AC" Then
        If BacFrmIRF.TxtTasaAnt.Text = "" And Val(BacFrmIRF.TxtTasaAnt.Text) = 0 Then
            MsgBox "Debe aplicar tasa de descuento para grabar anticipo de pacto.", vbCritical, gsBac_Version
            sPasa = False
        End If
    End If
    
    If sWinTipo$ = "CP" Or sWinTipo$ = "CI" Or sWinTipo$ = "VP" Or sWinTipo$ = "VI" Or sWinTipo$ = "RC" Or sWinTipo$ = "RV" Or sWinTipo$ = "IB" Or sWinTipo$ = "ST" Or sWinTipo$ = "IC" Or sWinTipo$ = "AC" Then
    
       If sWinTipo$ = "IB" Then
          
          If Val(BacFrmIRF.FltMtoini.Text) = 0 Then
             MsgBox "Debe Ingresar Monto Inicial.", vbCritical, gsBac_Version
             Exit Sub
          End If
          
          If CDbl(BacFrmIRF.FltTasa.Text) = 0 Then
             MsgBox "Debe Ingresar Tasa.", vbCritical, gsBac_Version
             Exit Sub
          End If

          If Val(BacFrmIRF.IntBase.Text) = 0 Then
             MsgBox "Debe Ingresar Base.", vbCritical, gsBac_Version
             Exit Sub
          End If
          
          If Val(BacFrmIRF.Lbl_Mt_Final.Caption) = 0 Then
             MsgBox "Operación No Tiene Monto Final.", vbCritical, gsBac_Version
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
        If sWinTipo$ = "VP" Or sWinTipo$ = "VI" Or sWinTipo$ = "ST" Then
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
             If BacFrmIRF.Data1.Recordset("tm_rutemi") = 0 Then
                iContador = iContador + 1
             End If
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
        If sPasa = True And (sWinTipo$ = "VI") Then
            BacFrmIRF.Data1.Recordset.MoveFirst
            Do While Not BacFrmIRF.Data1.Recordset.EOF
                If BacFrmIRF.Data1.Recordset("tm_venta") = "P" Or BacFrmIRF.Data1.Recordset("tm_venta") = "V" Then
                    If CDate(BacFrmIRF.Data1.Recordset("tm_fecsal")) < CDate(BacFrmIRF.TxtFecVct.Text) Then
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
        If sPasa = True And ((sWinTipo$ = "VI")) Then  'Or (sWinTipo$ = "CI")
            If BacFrmIRF.txtplazo.Text < DIAS_PACTO_PAPEL_NO_CENTRAL Then
                BacFrmIRF.Data1.Recordset.MoveFirst
                Do While Not BacFrmIRF.Data1.Recordset.EOF
                
                    If sWinTipo$ = "VI" Then
                        If BacFrmIRF.Data1.Recordset("tm_venta") = "V" Then
                            If CDbl(BacFrmIRF.Data1.Recordset("tm_rutemi")) <> 97029000 Then
                                sPasa = False
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
                    MsgBox "Pacto contiene papeles que no son emitidos por el Banco Central." & vbCrLf & vbCrLf & "Plazo pacto es menor a " & DIAS_PACTO_PAPEL_NO_CENTRAL & ". No se puede realizar esta operación.", vbExclamation, gsBac_Version
                End If
            End If
        End If
        
        If sPasa = True And (sWinTipo$ = "VI" Or sWinTipo$ = "CI") Then
           If CDbl(BacFrmIRF.TxtTasa.Text) = 0 Then
              MsgBox "Falta Tasa del Pacto.", 16
              sPasa = False
           End If
        End If
        
      ' Chequeo de Ventas y Compras con Pacto con Pago de Cupon Durante el Pacto
      ' VB+- 15/05/2000 se cambio validacion, que sea valida solamamente para las compras con pacto
        If sPasa = True And (sWinTipo$ = "CI") Then
      ' If sPasa = True And (sWinTipo$ = "VI" Or sWinTipo$ = "CI") Then
        
            If CDbl(BacFrmIRF.TxtTasa.Text) = 0 Then
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
                        If (CDate(BacFrmIRF.Data1.Recordset("tm_fecpcup")) < CDate(BacFrmIRF.TxtFecVct.Text)) And (Mid$(BacFrmIRF.Data1.Recordset("tm_instser"), 1, 3) <> "PCD" And Mid$(BacFrmIRF.Data1.Recordset("tm_instser"), 1, 3) <> "PRD") Then
                            sPasa = False
                            MsgBox BacFrmIRF.Data1.Recordset("tm_instser") + " con Vencimiento de Cupón Durante el Pacto.", vbCritical, gsBac_Version
                        End If
                    End If
                    BacFrmIRF.Data1.Recordset.MoveNext
                Loop
            End If
        End If
      ' Cheque Cuando es una pantalla de captaciones
        If sWinTipo$ = "IC" Then ' pantalla de captaciones
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
                
                If IsNull(BacFrmIRF.Data1.Recordset("tm_rutemi")) Or CDbl(BacFrmIRF.Data1.Recordset("tm_rutemi")) = 0 Then
                    MsgBox "Instrumento ingresado " & Trim$(BacFrmIRF.Data1.Recordset("tm_instser")) & " debe tener algun emisor asociado, Verifique ", vbExclamation, gsBac_Version
                    iContador = iContador + 1
                End If
                
                BacFrmIRF.Data1.Recordset.MoveNext
            Loop
            If iContador <> 0 Then
                sPasa = False
            End If
            BacFrmIRF.Data1.Recordset.MoveFirst
        End If
       
        If sPasa = True Then
            BacIrfGr.Caption = BacFrmIRF.Caption + " : Grabación"
            BacIrfGr.Tag = sWinTipo$
            BacIrfGr.Show vbModal
        Else
            Grabacion_Operacion = False
            Exit Sub
       End If

    ElseIf sWinTipo$ = "CAM" Then
    
    ElseIf sWinTipo$ = "FWD" Then

    End If

End Sub
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
    
    db.Execute Sql
    
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
   Laminas$, Tipo_Inversion$, CtaCteInicio$, SucInicio$, CtaCteFinal$, SucFinal$) As Double
   
Dim Datos()
Dim iCorrela%
Dim iCorrVent%
Dim sMascara$, sInstSer$, sGenEmi$, sNemMon$, dNominal#, dTir#, dPvp#, sFecpcup$
Dim dVPar#, dVpTirV#, dVpTirV100#, iNumUCup%, dTasEst#, sFecEmi$, sFecVen$
Dim sMdse$, lCodigo&, sSerie$, iMonemi%, lRutemi&, dTasEmi#, iBasemi%
Dim dTipcam#
Dim sFecIniP$, sFecVenP$, dValIniP#, dValVenP#, dTasPact#
Dim lPlazo&, iBasPact%, iMonPact%, dTotalIniMP#, dTotalVenMP#
Dim dFactor#, dTotalaux#
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

On Error GoTo BacErrorHandler

    sFecIniP$ = hForm.TxtFecIni.Text
    sFecVenP$ = hForm.TxtFecVct.Text
    dTotalIniMP# = Val(hForm.txtIniPMP.Text)
    dTotalVenMP# = Val(hForm.txtVenPMP.Text)
    dTasPact# = CDbl(hForm.TxtTasa.Text)
    lPlazo& = Val(hForm.txtplazo.Text)
    iMonPact% = Val(hForm.CmbMon.ItemData(BacFrmIRF.CmbMon.ListIndex))
    iBasPact% = funcBaseMoneda(iMonPact%) ' Val(hForm.cmbBase.List(BacFrmIRF.cmbBase.ListIndex))
    dTipcam# = funcBuscaTipcambio(iMonPact%, Str(gsBac_Fecp))
    sFecPro = Format$(gsBac_Fecp, "mm/dd/yyyy")
    
    
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

    hForm.Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hForm.hWnd & " AND tm_diasdisp >= " & hForm.txtplazo.Text & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
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
                
            
                    If Not Lineas_ChequearGrabar("BTR", "VI ", dNumoper, dNumdocu, CDbl(dNumdocu), CDbl(lRutCli), CDbl(nCodigo), dVpTirV#, gsBac_TCambio, BacFrmIRF.TxtFecVct.Text, CDbl(lRutemi&), iMonemi%, hForm.Data1.Recordset("tm_fecven"), CDbl(lCodigo&), sSerie$, 0, "C", 0, "N", 0, gsBac_Fecp, 0) Then
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


                    If .Data1.Recordset.AbsolutePosition <> .Data1.Recordset.RecordCount Then
                        dFactor = dValIniP / dTotalIniMP
                        dValVenP = dTotalVenMP# * dFactor
                        dTotalaux = dTotalaux + dValVenP
                    Else
                        dValVenP = dTotalVenMP# - dTotalaux
                    End If
                
                    If dTipcam# = 1 Then
                        dValVenP = CVar(Format(dValIniP * (((dTasPact / (iBasPact * 100#)) * DateDiff("d", CDate(hForm.TxtFecIni.Text), CDate(hForm.TxtFecVct.Text))) + 1), "##,###,###,###,##0"))
                    Else
                        dValVenP = CVar(dValIniP / dTipcam# * (((dTasPact / (iBasPact * 100#)) * DateDiff("d", CDate(hForm.TxtFecIni.Text), CDate(hForm.TxtFecVct.Text))) + 1))
                    End If

                End With
                
                
                                    
'               Sql = "sp_grabarvi " & Chr$(10)
'               Sql = Sql & dNumoper & "," & Chr$(10)
'               Sql = Sql & lRutCar & "," & Chr$(10)
'               Sql = Sql & iTipCar & "," & Chr$(10)
'               Sql = Sql & BacFormatoSQL(dNumdocu) & "," & Chr$(10)
'               Sql = Sql & iCorrela & "," & Chr$(10)
'               Sql = Sql & BacFormatoSQL(dNominal) & "," & Chr$(10)
'               Sql = Sql & BacFormatoSQL(dTir) & "," & Chr$(10)
'               Sql = Sql & BacFormatoSQL(dPvp) & "," & Chr$(10)
'               Sql = Sql & BacFormatoSQL(dVpTirV) & "," & Chr$(10)
'               Sql = Sql & BacFormatoSQL(dVpTirV100) & "," & Chr$(10)
'               Sql = Sql & BacFormatoSQL(dTasEst) & "," & Chr$(10)
'               Sql = Sql & BacFormatoSQL(dVPar) & "," & Chr$(10)
'               Sql = Sql & BacFormatoSQL(iNumUCup) & "," & Chr$(10)
'               Sql = Sql & lRutCli & "," & Chr$(10)
'               Sql = Sql & nCodigo & "," & Chr$(10)
'               Sql = Sql & "'" & sTipCus & "'," & Chr$(10)
'               Sql = Sql & iForPagI & "," & Chr$(10)
'               Sql = Sql & iForPagV & "," & Chr$(10)
'               Sql = Sql & "'" & sRetiro & "'," & Chr$(10)
'               Sql = Sql & "'" & gsUsuario & "'," & Chr$(10)
'               Sql = Sql & "'" & gsTerminal & "'," & Chr$(10)
            
               'Datos del Pacto
               '----------------------------------------------
'               Sql = Sql & "'" & Format(sFecVenP, "MM/DD/yyyy") & "'," & Chr$(10)
'               Sql = Sql & BacFormatoSQL(iMonPact) & "," & Chr$(10)
'               Sql = Sql & BacFormatoSQL(dTasPact) & "," & Chr$(10)
'               Sql = Sql & BacFormatoSQL(iBasPact) & "," & Chr$(10)
'               Sql = Sql & BacFormatoSQL(dValIniP) & "," & Chr$(10)
'               Sql = Sql & BacFormatoSQL(dValVenP) & "," & Chr$(10)
               '----------------------------------------------
            
'               Sql = Sql & "'" & sInstSer & "'," & Chr$(10)
'               Sql = Sql & Str(lRutemi) & "," & Chr$(10)
'               Sql = Sql & Str(iMonemi) & "," & Chr$(10)
'               Sql = Sql & "'" & Format(CDate(sFecEmi$), "dd/mm/yyyy") & "'," & Chr$(10)
'               Sql = Sql & "'" & Format(CDate(sFecVen$), "dd/mm/yyyy") & "'," & Chr$(10)
'               Sql = Sql & iCorrVent & "," & Chr$(10)
'               Sql = Sql & "'" & Format(CDate(sFecpcup$), "dd/mm/yyyy") & "'," & Chr$(10)
'               Sql = Sql & dConvex & "," & Chr$(10)
'               Sql = Sql & dDurMod & "," & Chr$(10)
'               Sql = Sql & dDurmac & "," & Chr$(10)
'               Sql = Sql & "'" & sTipCus & "'," & Chr$(10)
'               Sql = Sql & "'" & clave_dcv & "'," & Chr$(10)
'               Sql = Sql & dTPFE & "," & Chr$(10)
'               Sql = Sql & dTCCE & "," & Chr$(10)
'               Sql = Sql & "'" & cCarteraSuper & "'," & Chr$(10)   'Este es el Codigo de Categoría Cartera Super
'               Sql = Sql & "'" & TCart$ & "'," & Chr$(10)
'               Sql = Sql & "'" & Mercado$ & "'," & Chr$(10)
'               Sql = Sql & "'" & Sucursal$ & "'," & Chr$(10)
'               Sql = Sql & "'" & AreaResponsable$ & "'," & Chr$(10)
'               Sql = Sql & "'" & Format(Fecha_PagoMañana$, feFECHA) & "'," & Chr$(10)
'               Sql = Sql & "'" & Laminas$ & "'," & Chr$(10)
'               Sql = Sql & "'" & Tipo_Inversion$ & "'," & Chr$(10)
'               Sql = Sql & "'" & CtaCteInicio$ & "'," & Chr$(10)
'               Sql = Sql & "'" & SucInicio$ & "'," & Chr$(10)
'               Sql = Sql & "'" & CtaCteFinal$ & "'," & Chr$(10)
'               Sql = Sql & "'" & SucFinal$ & "'"
               
               
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
            
               If Not Bac_Sql_Execute("sp_grabarvi", Envia) Then
                   GoTo BacErrorHandler
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

    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_Term, gsBac_User, _
     "BTR", "Opc_20400", "01", "Venta con Pacto", "mdvi,mdmo,mddi", Valor_antiguo, " ")



    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        GoTo BacErrorHandler
    End If
    
    VI_GrabarTx = dNumoper
    
    Exit Function
        
BacErrorHandler:

    MsgBox "NO SE COMPLETO LA GRABACION DE VENTA CON PACTO CON EXITO", vbExclamation, gsBac_Version
    
    If FlagTx = True Then
        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
            MsgBox " NO SE PUDO REALIZAR ROLLBACK", vbExclamation, gsBac_Version
        End If
    End If
   
    VI_GrabarTx = 0
    Exit Function
    
End Function


Public Function CI_GrabarTx( _
   lRutCar&, iTipCar%, lForPagI&, lForPagV&, sTipCus$, sRetiro$, sPagMan$, sObserv$, _
   lRutCli&, nCodigo&, hForm As Form, dTPFE As Double, dTCCE As Double, TCart$, _
   Mercado$, Sucursal$, AreaResponsable$, Fecha_PagoMañana$, Laminas$, Tipo_Inversion$, _
   CtaCteInicio$, SucInicio$, CtaCteFinal$, SucFinal$) As Double

Dim Sql$
Dim Datos()
Dim iCorrela%
Dim sMascara$, sInstSer$, sGenEmi$, sNemMon$, dNominal#, dTir#
Dim dPvp#, dVPar#, dMt#, dMt100#, iNumUCup%, dTasEst#, sFecEmi$
Dim sFecVen$, sMdse$, lCodigo&, sSerie$, iMonemi%, lRutemi&
Dim dTasEmi#, iBasemi%
Dim dTirMcd#, dPvpMcd#, dMtMcd#, dMtMcd100#
Dim dTipcam#
Dim sFecIniP$, sFecVenP$, dValIniP#, dValVenP#, dTasPact#, sFecpcup$
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

On Error GoTo BacErrorHandler



    dMontoAfecto_PFE = 0
    dMontoAfecto_CCE = 0
    
    sFecIniP$ = Format$(BacFrmIRF.TxtFecIni.Text, "yyyymmdd")
    sFecVenP$ = Format$(BacFrmIRF.TxtFecVct.Text, "yyyymmdd")
    
    Fecha_Pacto$ = BacFrmIRF.TxtFecVct.Text
    
    dTotalIniMP# = CDbl(BacFrmIRF.txtIniPMP.Text)
    dTotalVenMP# = CDbl(BacFrmIRF.txtVenPMP.Text)
    dTasPact# = CDbl(BacFrmIRF.TxtTasa.Text) 'aqui
    lPlazo& = Val(BacFrmIRF.txtplazo.Text)
    iMonPact% = Val(BacFrmIRF.CmbMon.ItemData(BacFrmIRF.CmbMon.ListIndex))
    iBasPact% = funcBaseMoneda(iMonPact%) ' Val(hForm.cmbBase.List(BacFrmIRF.cmbBase.ListIndex))
    dTipcam# = funcBuscaTipcambio(iMonPact%, Str(gsBac_Fecp))

    sFecPro = Format$(Now, "mm/dd/yyyy")

    FlagTx = False
        
                
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        GoTo BacErrorHandler
    End If
    
    FlagTx = True
                   
  ' Obtengo Numero de operación
  ' -----------------------------------------------------------------------------
    If Not Bac_Sql_Execute("sp_opmdac") Then
        GoTo BacErrorHandler
    End If
                
    If Bac_SQL_Fetch(Datos()) Then
        dNumdocu = Val(Datos(1))
    End If
  ' =============================================================================
  
  
  
    '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then

        Dim Mensaje     As String

        Mensaje = ""
        hForm.Data1.Recordset.MoveFirst
        iCorrela% = 0
                 
        Do While Not hForm.Data1.Recordset.EOF
        
            If Trim$(hForm.Data1.Recordset("tm_instser")) <> "" Then
            
                iCorrela% = iCorrela% + 1
            
                If Not Lineas_ChequearGrabar("BTR", "CI ", dNumdocu, dNumdocu, CDbl(iCorrela), CDbl(lRutCli), CDbl(nCodigo), hForm.Data1.Recordset("tm_mt"), gsBac_TCambio, BacFrmIRF.TxtFecVct.Text, hForm.Data1.Recordset("tm_rutemi"), hForm.Data1.Recordset("tm_monemi"), hForm.Data1.Recordset("tm_fecven"), hForm.Data1.Recordset("tm_codigo"), hForm.Data1.Recordset("tm_mdse"), 0, "C", 0, "N", 0, gsBac_Fecp, 0) Then
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
              ' VB-
              
              ' -------------------
              ' -------------------
              
                cCarteraSuper = IIf(IsNull(.Data1.Recordset("tm_carterasuper")), "T", .Data1.Recordset("tm_carterasuper"))
                            
                If .Data1.Recordset.AbsolutePosition <> .Data1.Recordset.RecordCount Then
                    dFactor = dValIniP / dTotalIniMP
                    dValVenP = dTotalVenMP# * dFactor
                    dTotalaux = dTotalaux + dValVenP
                Else
                    dValVenP = dTotalVenMP# - dTotalaux
                End If
                            
                If dTipcam# = 1 Then
                    dValVenP = CVar(Format(dValIniP * (((dTasPact / (iBasPact * 100#)) * DateDiff("d", CDate(hForm.TxtFecIni.Text), CDate(hForm.TxtFecVct.Text))) + 1), "##,###,###,###,##0"))
                Else
                    dValVenP = CVar(dValIniP / dTipcam# * (((dTasPact / (iBasPact * 100#)) * DateDiff("d", CDate(hForm.TxtFecIni.Text), CDate(hForm.TxtFecVct.Text))) + 1))
                End If
                            
            End With
                
            iCorrela% = iCorrela% + 1
            
            

'            Sql = "sp_grabarci " & Chr$(10)
'            Sql = Sql & lRutCar & "," & Chr$(10)
'            Sql = Sql & iTipCar & "," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(dNumdocu) & "," & Chr$(10)
'            Sql = Sql & iCorrela & "," & Chr$(10)
'            Sql = Sql & "'" & sMascara & "'," & Chr$(10)
'            Sql = Sql & "'" & sInstSer & "'," & Chr$(10)
'            Sql = Sql & "'" & sGenEmi & "'," & Chr$(10)
'            Sql = Sql & "'" & sNemMon & "'," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(dNominal) & "," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(dTir) & "," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(dPvp) & "," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(dMt) & "," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(dMt100) & "," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(dTasEst) & "," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(dVPar) & "," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(iNumUCup) & "," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(dTirMcd) & "," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(dPvpMcd) & "," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(dMtMcd) & "," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(dMtMcd100) & "," & Chr$(10)
'            Sql = Sql & "'" & sMdse & "'," & Chr$(10)
'            Sql = Sql & lCodigo & "," & Chr$(10)
'            Sql = Sql & "'" & sSerie & "'," & Chr$(10)
'            Sql = Sql & "'" & Format(sFecEmi, "yyyymmdd") & "'," & Chr$(10)
'            Sql = Sql & "'" & Format(sFecVen, "yyyymmdd") & "'," & Chr$(10)
'            Sql = Sql & iMonemi & "," & Chr$(10)
'            Sql = Sql & lRutemi & "," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(dTasEmi) & "," & Chr$(10)
'            Sql = Sql & iBasemi & "," & Chr$(10)
'            Sql = Sql & lRutCli & "," & Chr$(10)
'            Sql = Sql & nCodigo & "," & Chr$(10)
'            Sql = Sql & lForPagI & "," & Chr$(10)
'            Sql = Sql & lForPagV & "," & Chr$(10)
'            Sql = Sql & "'" & sTipCus & "'," & Chr$(10)
'            Sql = Sql & "'" & sRetiro & "'," & Chr$(10)
'            Sql = Sql & "'" & gsUsuario & "'," & Chr$(10)
'            Sql = Sql & "'" & gsTerminal & "'," & Chr$(10)

          ' Datos del Pacto
          ' =====================================================================
'            Sql = Sql & "'" & Format(sFecVenP, "yyyymmdd") & "'," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(iMonPact) & "," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(dTasPact) & "," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(iBasPact) & "," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(dValIniP) & "," & Chr$(10)
'            Sql = Sql & BacFormatoSQL(dValVenP) & "," & Chr$(10)
          ' =====================================================================
          
'            Sql = Sql & "'" & Format(sFecpcup, "dd/mm/yyyy") & "'," & Chr$(10)
'            Sql = Sql & "'" & cCustodiaDCV & "'," & Chr$(10)
'            Sql = Sql & "'" & cClaveDCV & "'," & Chr$(10)
'          ' VB+- 27/06/2000 Se agregan datos de Duratión a sentencia de grabación
'            Sql = Sql & dConvexidad & "," & Chr$(10)
'            Sql = Sql & dDuratMac & "," & Chr$(10)
'            Sql = Sql & dDuratMod & "," & Chr$(10)
'            Sql = Sql & dTPFE & "," & Chr$(10)
'            Sql = Sql & dTCCE & "," & Chr$(10)
'            Sql = Sql & "'" & cCarteraSuper & "'," & Chr$(10)   'Este es el Codigo de Categoría Cartera Super
'            Sql = Sql & "'" & TCart$ & "'," & Chr$(10)
'            Sql = Sql & "'" & Mercado$ & "'," & Chr$(10)
'            Sql = Sql & "'" & Sucursal$ & "'," & Chr$(10)
'            Sql = Sql & "'" & AreaResponsable$ & "'," & Chr$(10)
'            Sql = Sql & "'" & Format(Fecha_PagoMañana$, feFECHA) & "'," & Chr$(10)
'            Sql = Sql & "'" & Laminas$ & "'," & Chr$(10)
'            Sql = Sql & "'" & Tipo_Inversion$ & "'," & Chr$(10)
'            Sql = Sql & "'" & CtaCteInicio$ & "'," & Chr$(10)
'            Sql = Sql & "'" & SucInicio$ & "'," & Chr$(10)
'            Sql = Sql & "'" & CtaCteFinal$ & "'," & Chr$(10)
'            Sql = Sql & "'" & SucFinal$ & "'"

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
                  
            If Not Bac_Sql_Execute("sp_grabarci", Envia) Then
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
        
    End If
    '********** Fin

    
  ' VB+ debe Envia a grabar Tesorería
  ' =====================================
  '  If Not funcGrabaTesoreria(BacIrfGr.Tag, dNumdocu#, BacIrfGr.txtRutCli.Text, BacIrfGr.TxtCodCli.Text, BacIrfGr.proMtoOper, "$$", "H", BacIrfGr.CmbFPagoIni.ItemData(BacIrfGr.CmbFPagoIni.ListIndex), IIf(BacIrfGr.ChkVamos.Value = True, "V", "I"), BacIrfGr.txtRutCar.Text) Then
  '      GoTo BacErrorHandler
  '      Exit Function
  '  End If
  ' =====================================
  ' VB-
   
   
  ' Actualizo Limites ART 84 Emisor/Inst/Plazo
  ' ----------------------------------------------------------------------------------------------------
  '  If Not funcValidacionLimites_CI(BacIrfGr.txtRutCli.Text, BacIrfGr.proMtoOper, "S") Then
  '          GoTo BacErrorHandler
  '      Exit Function
  '  End If
    
  ' Se Obvia control de limites de Settlement por reunion del día 27/07/2000
  ' Actualizo Limites SETTLEMENT
  ' ----------------------------------------------------------------------------------------------------
  '  If Not funcValidaLimites_SETTLEMENT(BacIrfGr.txtRutCli.Text, BacIrfGr.TxtCodCli.Text, "CI", dNumdocu, 1, BacIrfGr.CmbFPagoIni.ItemData(BacIrfGr.CmbFPagoIni.ListIndex), BacIrfGr.proMtoOper, "S", 0, 0, 0) Then
  '          GoTo BacErrorHandler
  '      Exit Function
  '  End If
  ' Se Obvia control de limites de Settlement por reunion del día 27/07/2000
  ' Grabo Exceso Limites SETTLEMENT
  ' ----------------------------------------------------------------------------------------------------
  '  If iCodExcesoSETTLE <> 0 Then
  '      If Not funcGrabaExcesos(dNumdocu, 1, "CI", "SETTLE", iCodExcesoSETTLE, dMtoExcesoSETTLE, "G", Val(lPlazo), BacIrfGr.txtRutCli, BacIrfGr.TxtCodCli.Text, BacIrfGr.proMtoOper) Then
  '           GoTo BacErrorHandler
  '      End If
  '  End If
  

  ' Actualizo Limites PFE y CCE
  ' ----------------------------------------------------------------------------------------------------
  '  If Not funcValidacionLimites_PFE_CCE_CI(BacIrfGr.txtRutCli.Text, BacIrfGr.TxtCodCli.Text, 0, "S", dTPFE, dTCCE, 0, 0, 0, 0) Then
  '           GoTo BacErrorHandler
  '      Exit Function
  '  End If
    
  ' Grabo Exceso Limites PFE
  ' ----------------------------------------------------------------------------------------------------
  '  If iCodExcesoPFEcce <> 0 Then
  '      If Not funcGrabaExcesos(dNumdocu, 1, "CI", "PFECCE", iCodExcesoPFEcce, dMtoExcesoPFEcce, "G", Val(lPlazo), BacIrfGr.txtRutCli, BacIrfGr.TxtCodCli.Text, dTPFE) Then
  '          GoTo BacErrorHandler
  '      End If
  '      iCodExcesoPFEcce = 0
  '      dMtoExcesoPFEcce = 0
  '  End If
    
  ' Grabo Exceso Limites CCE
  ' ----------------------------------------------------------------------------------------------------
  '  If iCodExcesopfeCCE_1 <> 0 Then
  '      If Not funcGrabaExcesos(dNumdocu, 1, "CI", "PFECCE", iCodExcesopfeCCE_1, dMtoExcesopfeCCE_1, "G", Val(lPlazo), BacIrfGr.txtRutCli, BacIrfGr.TxtCodCli.Text, dTCCE) Then
  '           GoTo BacErrorHandler
  '      End If
  '      iCodExcesopfeCCE_1 = 0
  '      dMtoExcesopfeCCE_1 = 0
  '  End If
    Valor_antiguo = " "
    Valor_antiguo = "Operacion:" & dNumdocu & ";CI;" & "Rut Cliente:" & lRutCli & ";Codigo Cliente:" & nCodigo & ";Forma de Pago Inicio:" & lForPagI & ";Forma de Pago Venc:" & lForPagV & ";Tasa Pacto=" & dTasPact

    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_Term, gsBac_User, _
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
Sub PROC_POSICIONA_TEXTOX(grilla As Control, texto As Control)

    texto.Top = grilla.CellTop + grilla.Top
    texto.Left = grilla.CellLeft + grilla.Left
    texto.Height = grilla.CellHeight + 20
    texto.Width = grilla.CellWidth

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


