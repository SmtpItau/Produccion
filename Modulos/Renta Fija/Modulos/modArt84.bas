Attribute VB_Name = "modArt84"
Option Explicit
' Variables publicas
Public gstrMensajesError
Global gblnProcesoExitoso As Boolean
Global gblnAnalizaMargen As Boolean
Global glngNroTicket As Long
Global gdblNroOperacionIBS As Double
Global gstrNrosOperacionesIBS As String
Global gstrDetMontosImputables As String
Global gstrMontosEnviados As String


' variables locales
Dim ObjEmisor      As New clsEmisor
Dim ObjCliente     As New clsCliente

Dim blnRealizaProceso As Boolean
Dim blnConexionExitosa As Boolean
Dim strRespWS As String
Dim strRespuestaProceso As String
Dim strMsgXml As String
Dim strMsgXml_Body As Variant
Dim strAlert As String
Dim strFlagSuccess As String
Dim strDetalleResp As String
Dim strRutaWS As String

Dim Datos()
' arreglo que contiene las respuestas del servicio
Dim strArrayRespuestas() As String
' variable para contar nodos
Dim lCanNodos As Long

' Parametros utilizados
Dim strCodEntidad As String
Dim strCodUsuario As String
Dim strDateTime As String
Dim strRutCteEmisor As String
Dim strCodigoCteEmisor As String
Dim strCodMonedaIBS As String
Dim dblMontoReserva As Double
Dim dblMontoGarantizado As Double
Dim dblMontoMTM As Double
Dim intCantDiasPermanencia As Integer
Dim strNumSolicitudSistema As String
Dim intCodigoDeuda As Integer
Dim intCodigoTransaccion As Integer
Dim strCodigoProductoIBS As String
Dim intCodigoPaisSBIF As Integer
Dim strIndicador As String
Dim iRow As Integer
Dim strEmisor As String
Dim strSerieDoc As String
Dim strSistemaOrigen As String
Dim intTicket As Integer
Dim intPlazo As Integer
Dim strURL As String
Dim strProducto As String
Dim strTipoPayOFF As String
Dim dblPesoFijoAsia As Double


Private Const strSeparador = "_________________________________________________________________"
Private Const strMsgNoConecta = " No se ha podido conectar con servicio IBS "
Public Const strMsgGeneral = strSeparador + vbNewLine + vbNewLine + " Por control de lineas Articulo 84" + vbNewLine + strSeparador

' CABECERA DEL XML QUE SE GENERA DINAMICAMENTE
Private Const cSOAP_Margenes_Art84_Header = "<?xml version='1.0' encoding='utf-8'?>" & _
"<soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>" & _
  "<soap:Body>" & _
    "<CalculaMargenGlobal><Items>"

' FINALIZACION DEL XML QUE SE GENERA DINAMICAMENTE
Private Const cSOAP_Margenes_Art84_End = "</Items></CalculaMargenGlobal>" & _
    "</soap:Body></soap:Envelope>"


Private Const cSoapMargenString = "<?xml version='1.0' encoding='utf-8'?>" & _
"<soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>" & _
  "<soap:Body>" & _
    "<ConsultaIBSXml xmlns='IBS'>" & _
      "<XmlString>string</XmlString>" & _
    "</ConsultaIBSXml>" & _
  "</soap:Body>" & _
"</soap:Envelope>"
Function blnEmisorNoImputa(strCodEmisor As String) As Boolean
Dim blnImputa As Boolean
blnImputa = False
Const catEmisoresNoImputables = "9911"
Envia = Array()

AddParam Envia, catEmisoresNoImputables
If Not Bac_Sql_Execute(gsSQL_Database_comun & "..sp_leercodigos", Envia) Then Exit Function
Do While Bac_SQL_Fetch(Datos())
    If Trim(UCase(Datos(7))) = Trim(UCase(strCodEmisor)) Then
        blnImputa = True
        blnEmisorNoImputa = True
        Exit Function
    End If
Loop
blnEmisorNoImputa = blnImputa
End Function
Function blnOperacionCumpleArt84String(strXML As String) As Boolean
blnRealizaProceso = False

' proceso que crea el archivo XML y lo envía al WS
Call CreaInterfazXMLArt84SOAP_String(cSoapMargenString, strXML)
' Reviso si el proceso se generó correctamente
If blnConexionExitosa Then
    ' analizo la respuesta identificando alertas para los casos que no cumple el márgen
    If blnCumpleMargen(strRespuestaProceso) Then
        blnRealizaProceso = True
    Else
        blnRealizaProceso = False
    End If
End If
blnOperacionCumpleArt84String = blnRealizaProceso
End Function
Sub GeneraArchivoInterfazGrillaCI(Frm As Form)

'GeneraArchivoInterfazGrillaCI_contraparte

'Dim mfgGrilla As MSFlexGrid
''Set mfgGrilla = BacIrfGr.mfgTemporal
'Set mfgGrilla = Frm.Table1

strCodEntidad = "3"                         ' 3=mesa dinero
strCodUsuario = gsBac_User$                 ' Usuario Registrado en sistema

strRutCteEmisor = Trim(Frm.txtRutCli.Text)      ' rut contraparte
strCodigoCteEmisor = Trim(Frm.TxtCodCli.Text)



strCodMonedaIBS = "CLP"                     ' CLP= Chilean pesos
dblMontoReserva = 0
If CDbl(BacCI.txtIniPMS.Text) > 0 Then
    dblMontoReserva = CDbl(BacCI.txtIniPMS.Text)
End If
dblMontoGarantizado = 0                     ' no se utiliza


dblMontoMTM = 0                             ' RF no utiliza este valor
intCantDiasPermanencia = 1                  ' 1= dura un solo dia
strNumSolicitudSistema = 0                  ' se envia con valor 0
intCodigoDeuda = 5                          ' 5= deuda bonos
intCodigoTransaccion = 1                    ' 1 Ingresa simulación con reserva + Realiza calculo control de márgenes + Entrega cupo disponible con Flag si cumple o no con el límite de endeudamiento + Código de alarma si presenta bloqueo por alarma
strCodigoProductoIBS = "MD01"               ' MD01 = Mesa de dinero
intCodigoPaisSBIF = 160                     ' 160 = CHILE
strIndicador = "A"                          ' A=Activo
strSistemaOrigen = "BTR"                    ' BTR        RENTA FIJA

intTicket = lngTraeTicketArt84()            ' nro ticket unico que sirve para identificar la peticion contra nro de operacion (IBS)
intPlazo = 1


' seteo parametros utilizados para calculos de bilaterales
strProducto = "0"
strTipoPayOFF = "0"
dblPesoFijoAsia = 0


' guardo ticket generado
glngNroTicket = intTicket


strMsgXml = ""
strMsgXml_Body = ""
strSerieDoc = ""
gstrMontosEnviados = ""

strMsgXml_Body = "<Item><strEntidad>" & strCodEntidad & "</strEntidad>" & _
            "<strCodUsuario>" & strCodUsuario & "</strCodUsuario>" & _
            "<strRutCte>" & strRutCteEmisor & "</strRutCte>" & _
            "<intCodigoCliente>" & strCodigoCteEmisor & "</intCodigoCliente>" & _
            "<strCodMonedaIBS>" & strCodMonedaIBS & "</strCodMonedaIBS>" & _
            "<dblMontoOperacion>" & dblMontoReserva & "</dblMontoOperacion>" & _
            "<dblMontoMTM>" & dblMontoMTM & "</dblMontoMTM>" & _
            "<dblMontoGarantizado>" & dblMontoGarantizado & "</dblMontoGarantizado>" & _
            "<intCantDiasPermanencia>" & intCantDiasPermanencia & "</intCantDiasPermanencia>" & _
            "<strNumSolicitudSistema>" & strNumSolicitudSistema & "</strNumSolicitudSistema>" & _
            "<intCodigoDeuda>" & intCodigoDeuda & "</intCodigoDeuda>" & _
            "<intCodigoTransaccion>" & intCodigoTransaccion & "</intCodigoTransaccion>" & _
            "<strCodigoProductoIBS>" & strCodigoProductoIBS & "</strCodigoProductoIBS>" & _
            "<intCodigoPaisSBIF>" & intCodigoPaisSBIF & "</intCodigoPaisSBIF>" & _
            "<strIndicador>" & strIndicador & "</strIndicador>" & _
            "<strSistema>" & strSistemaOrigen & "</strSistema>" & _
            "<intTicket>" & intTicket & "</intTicket>" & _
            "<intPlazo>" & intPlazo & "</intPlazo>" & _
            "<strProducto>" & strProducto & "</strProducto></Item>"
            
            
strMsgXml = cSOAP_Margenes_Art84_Header + strMsgXml_Body + cSOAP_Margenes_Art84_End
' GENERO EL ARCHIVO Y ANALISO LA RESPUESTA ENTREGADA POR EL WS
If Not blnOperacionCumpleArt84String(strMsgXml) Then
End If

' Asigno variable global que será ocupada en los formularios
gblnProcesoExitoso = blnRealizaProceso
End Sub
Sub GeneraArchivoInterfazGrillaVI(Frm As Form, strRutCteContraparte As String, strCodCliente As String)

strCodEntidad = "3"                         ' 3=mesa dinero
strCodUsuario = gsBac_User$                 ' Usuario Registrado en sistema
strRutCteEmisor = strRutCteContraparte      ' rut contraparte
strCodigoCteEmisor = strCodCliente          ' codigo de la contraparte
strCodMonedaIBS = "CLP"                     ' CLP= Chilean pesos
dblMontoReserva = CDbl(Frm.txtIniPMP.Text)
dblMontoGarantizado = 0                     ' no se utiliza
dblMontoMTM = 0                             ' RF no utiliza este valor
intCantDiasPermanencia = 1                  ' 1= dura un solo dia
strNumSolicitudSistema = 0                  ' se envia con valor 0
intCodigoDeuda = 5                          ' 5= deuda bonos
intCodigoTransaccion = 1                    ' 1 Ingresa simulación con reserva + Realiza calculo control de márgenes + Entrega cupo disponible con Flag si cumple o no con el límite de endeudamiento + Código de alarma si presenta bloqueo por alarma
strCodigoProductoIBS = "MD01"               ' MD01 = Mesa de dinero
intCodigoPaisSBIF = 160                     ' 160 = CHILE
strIndicador = "A"                          ' A=Activo
strSistemaOrigen = "BTR"                    ' BTR        RENTA FIJA
intTicket = lngTraeTicketArt84()            ' nro ticket unico que sirve para identificar la peticion
                                            ' contra nro de operacion (IBS)
intPlazo = 1

' guardo ticket generado
glngNroTicket = intTicket

' seteo parametros utilizados para calculos de bilaterales
strProducto = "0"
strTipoPayOFF = "0"
dblPesoFijoAsia = 0


gstrMontosEnviados = ""
'*************************************************
' CAMBIO TEMPORAL  PARA REVISAR DATOS ENVIADOS
'*************************************************
If Len(gstrMontosEnviados) = 0 Then
   gstrMontosEnviados = "Rut Emisor : " & strRutCteEmisor & vbNewLine & "Monto Imputado : " & dblMontoReserva
End If



strMsgXml = ""
strMsgXml_Body = ""

strMsgXml_Body = "<Item><strEntidad>" & strCodEntidad & "</strEntidad>" & _
"<strCodUsuario>" & strCodUsuario & "</strCodUsuario>" & _
"<strRutCte>" & strRutCteEmisor & "</strRutCte>" & _
"<intCodigoCliente>" & strCodigoCteEmisor & "</intCodigoCliente>" & _
"<strCodMonedaIBS>" & strCodMonedaIBS & "</strCodMonedaIBS>" & _
"<dblMontoOperacion>" & dblMontoReserva & "</dblMontoOperacion>" & _
"<dblMontoMTM>" & dblMontoMTM & "</dblMontoMTM>" & _
"<dblMontoGarantizado>" & dblMontoGarantizado & "</dblMontoGarantizado>" & _
"<intCantDiasPermanencia>" & intCantDiasPermanencia & "</intCantDiasPermanencia>" & _
"<strNumSolicitudSistema>" & strNumSolicitudSistema & "</strNumSolicitudSistema>" & _
"<intCodigoDeuda>" & intCodigoDeuda & "</intCodigoDeuda>" & _
"<intCodigoTransaccion>" & intCodigoTransaccion & "</intCodigoTransaccion>" & _
"<strCodigoProductoIBS>" & strCodigoProductoIBS & "</strCodigoProductoIBS>" & _
"<intCodigoPaisSBIF>" & intCodigoPaisSBIF & "</intCodigoPaisSBIF>" & _
"<strIndicador>" & strIndicador & "</strIndicador>" & _
"<strSistema>" & strSistemaOrigen & "</strSistema>" & _
"<intTicket>" & intTicket & "</intTicket>" & _
"<intPlazo>" & intPlazo & "</intPlazo>" & _
"<strProducto>" & strProducto & "</strProducto></Item>"

strMsgXml = cSOAP_Margenes_Art84_Header + strMsgXml_Body + cSOAP_Margenes_Art84_End
' GENERO EL ARCHIVO Y ANALISO LA RESPUESTA ENTREGADA POR EL WS
If Not blnOperacionCumpleArt84String(strMsgXml) Then
   'strMensaje = gstrMensajeErrorServicio
End If
' Asigno variable global que será ocupada en los formularios
gblnProcesoExitoso = blnRealizaProceso
End Sub
Public Function FUNC_BUSCA_VALOR_MONEDA_CONTABLE(Moneda As Integer, Fecha As String) As Double
    Dim Datos()
    FUNC_BUSCA_VALOR_MONEDA_CONTABLE = 0#
    If Moneda <> 999 Then  ' VB+- 25/07/2000 se excluye moneda 13 pues es dolar dolar y tipo cambio es 1

        Envia = Array(CDbl(Moneda), Format(Fecha, feFECHA))
        If Not Bac_Sql_Execute(gsSQL_Database_comun & "..SP_LEE_VALOR_MONEDA_CONTABLE", Envia) Then
            Exit Function
        End If
        If Not Bac_SQL_Fetch(Datos()) Then
            Exit Function
        End If
        FUNC_BUSCA_VALOR_MONEDA_CONTABLE = CDbl(Datos(1))
    Else
        If Moneda = 13 Then
            Moneda = 994 ' Dolar Observado
            Envia = Array(CDbl(Moneda), Format(Fecha, feFECHA))
            If Not Bac_Sql_Execute(gsSQL_Database_comun & "..SP_LEE_VALOR_MONEDA_CONTABLE", Envia) Then
                Exit Function
            End If
            If Not Bac_SQL_Fetch(Datos()) Then
                Exit Function
            End If
            If CDbl(Datos(1)) = 0 Then
                MsgBox "Tipo de cambio, para la moneda seleccionada es de valor 0, verifique tipos de cambios del día", vbExclamation, "BAC Trader"
                Exit Function
            End If
            FUNC_BUSCA_VALOR_MONEDA_CONTABLE = CDbl(Datos(1))
        Else
            FUNC_BUSCA_VALOR_MONEDA_CONTABLE = 1
        End If
    End If
End Function
Sub GeneraArchivoInterfazGrillaIB(Frm As Form)
Dim dblTipoCambio As Double
Dim dblMontoPaso As Double
Dim lngCodDO As Long

strCodEntidad = "3"                         ' 3=mesa dinero
strCodUsuario = gsBac_User$                 ' Usuario Registrado en sistema
strRutCteEmisor = Trim(Frm.txtRutCli.Text)      ' rut contraparte
strCodigoCteEmisor = Trim(Frm.TxtCodCli.Text)

strEmisor = Trim(Frm.TxtNomCli.Text)

strCodMonedaIBS = "CLP"                     ' CLP= Chilean pesos
dblMontoReserva = 0
dblMontoGarantizado = 0                     ' no se utiliza
dblMontoMTM = 0                             ' RF no utiliza este valor
intCantDiasPermanencia = 1                  ' 1= dura un solo dia
strNumSolicitudSistema = 0                  ' se envia con valor 0
intCodigoDeuda = 5                          ' 5= deuda bonos
intCodigoTransaccion = 1                    ' 1 Ingresa simulación con reserva + Realiza calculo control de márgenes + Entrega cupo disponible con Flag si cumple o no con el límite de endeudamiento + Código de alarma si presenta bloqueo por alarma
strCodigoProductoIBS = "MD01"               ' MD01 = Mesa de dinero
intCodigoPaisSBIF = 160                     ' 160 = CHILE
strIndicador = "A"                          ' A=Activo
strSistemaOrigen = "BTR"                    ' BTR        RENTA FIJA
intTicket = lngTraeTicketArt84()            ' nro ticket unico que sirve para identificar la peticion contra nro de operacion (IBS)
intPlazo = 1

' guardo ticket generado
glngNroTicket = intTicket

' seteo parametros utilizados para calculos de bilaterales
strProducto = "0"
strTipoPayOFF = "0"
dblPesoFijoAsia = 0


'OBTENGO NOMBRE GENERICO PARA EL EMISOR
dblMontoReserva = CDbl(BacInter.FltMtoini.Text)
If BacInter.CmbMoneda.Text = "CLP" Then
    dblMontoPaso = dblMontoReserva
Else
    dblTipoCambio = dblTraeTipoCambio(CLng(BacInter.CmbMoneda.ItemData(BacInter.CmbMoneda.ListIndex)))
    dblMontoPaso = CDbl(BacInter.FltMtoini.Text) * dblTipoCambio
End If

dblMontoReserva = Round(dblMontoPaso, 0)


gstrMontosEnviados = ""
'*************************************************
' CAMBIO TEMPORAL  PARA REVISAR DATOS ENVIADOS
'*************************************************
If Len(gstrMontosEnviados) = 0 Then
   gstrMontosEnviados = "Emisor : " & strEmisor & vbNewLine & "Monto Imputado : " & dblMontoReserva
End If


strMsgXml = ""
strMsgXml_Body = ""
strMsgXml_Body = "<Item><strEntidad>" & strCodEntidad & "</strEntidad>" & _
            "<strCodUsuario>" & strCodUsuario & "</strCodUsuario>" & _
            "<strRutCte>" & strRutCteEmisor & "</strRutCte>" & _
            "<intCodigoCliente>" & strCodigoCteEmisor & "</intCodigoCliente>" & _
            "<strCodMonedaIBS>" & strCodMonedaIBS & "</strCodMonedaIBS>" & _
            "<dblMontoOperacion>" & dblMontoReserva & "</dblMontoOperacion>" & _
            "<dblMontoMTM>" & dblMontoMTM & "</dblMontoMTM>" & _
            "<dblMontoGarantizado>" & dblMontoGarantizado & "</dblMontoGarantizado>" & _
            "<intCantDiasPermanencia>" & intCantDiasPermanencia & "</intCantDiasPermanencia>" & _
            "<strNumSolicitudSistema>" & strNumSolicitudSistema & "</strNumSolicitudSistema>" & _
            "<intCodigoDeuda>" & intCodigoDeuda & "</intCodigoDeuda>" & _
            "<intCodigoTransaccion>" & intCodigoTransaccion & "</intCodigoTransaccion>" & _
            "<strCodigoProductoIBS>" & strCodigoProductoIBS & "</strCodigoProductoIBS>" & _
            "<intCodigoPaisSBIF>" & intCodigoPaisSBIF & "</intCodigoPaisSBIF>" & _
            "<strIndicador>" & strIndicador & "</strIndicador>" & _
            "<strSistema>" & strSistemaOrigen & "</strSistema>" & _
            "<intTicket>" & intTicket & "</intTicket>" & _
            "<intPlazo>" & intPlazo & "</intPlazo>" & _
            "<strProducto>" & strProducto & "</strProducto></Item>"
            
' concateno los string para generar XML final
strMsgXml = cSOAP_Margenes_Art84_Header + strMsgXml_Body + cSOAP_Margenes_Art84_End
' GENERO EL ARCHIVO Y ANALISO LA RESPUESTA ENTREGADA POR EL WS
If Not blnOperacionCumpleArt84String(strMsgXml) Then
End If
' Asigno variable global que será ocupada en los formularios
gblnProcesoExitoso = blnRealizaProceso
End Sub
Sub GeneraArchivoInterfazGrillaCP(Frm As Form)
Dim mfgGrilla As MSFlexGrid
Set mfgGrilla = Frm.Table1

strCodEntidad = "3"                         ' 3=mesa dinero
strCodUsuario = gsBac_User$                 ' Usuario Registrado en sistema

strRutCteEmisor = "" 'Trim(txtRutCli.Text)  ' rut emisor
strCodigoCteEmisor = "0"
strCodMonedaIBS = "CLP"                     ' CLP= Chilean pesos
dblMontoReserva = 0
dblMontoGarantizado = 0                     ' no se utiliza
dblMontoMTM = 0                             ' RF no utiliza este valor
intCantDiasPermanencia = 1                  ' 1= dura un solo dia
strNumSolicitudSistema = 0                  ' se envia con valor 0
intCodigoDeuda = 5                          ' 5= deuda bonos
intCodigoTransaccion = 1                    ' 1 Ingresa simulación con reserva + Realiza calculo control de márgenes + Entrega cupo disponible con Flag si cumple o no con el límite de endeudamiento + Código de alarma si presenta bloqueo por alarma
strCodigoProductoIBS = "MD01"               ' MD01 = Mesa de dinero
intCodigoPaisSBIF = 160                     ' 160 = CHILE
strIndicador = "A"                          ' A=Activo
strSistemaOrigen = "BTR"                    ' BTR        RENTA FIJA

intTicket = lngTraeTicketArt84()            ' nro ticket unico que sirve para identificar la peticion contra nro de operacion (IBS)
intPlazo = 1

' guardo ticket generado
glngNroTicket = intTicket


' seteo parametros utilizados para calculos de bilaterales
strProducto = "0"
strTipoPayOFF = "0"
dblPesoFijoAsia = 0


strMsgXml = ""
strMsgXml_Body = ""

gstrMontosEnviados = ""

If mfgGrilla.Rows > 0 Then
    For iRow = 1 To mfgGrilla.Rows - 1
         dblMontoReserva = CDbl(mfgGrilla.TextMatrix(iRow, 5))
         strRutCteEmisor = Trim(mfgGrilla.TextMatrix(iRow, 15))
         If strRutCteEmisor = "" Or strRutCteEmisor = "0" Then
            strRutCteEmisor = strTraeEmisorSerie(Trim(mfgGrilla.TextMatrix(iRow, 0)), "R")
         End If

         
         strCodigoCteEmisor = strTraeGenericoByRut(strRutCteEmisor, "C")
         
         If strCodigoCteEmisor = "" Then
            strCodigoCteEmisor = "0"
         End If
         
         strEmisor = Trim(mfgGrilla.TextMatrix(iRow, 0))
         
         '*************************************************
         ' CAMBIO TEMPORAL  PARA REVISAR DATOS ENVIADOS
         '*************************************************
         If Len(gstrMontosEnviados) = 0 Then
            gstrMontosEnviados = "Serie : " & strEmisor & vbNewLine & "Monto Imputado : " & dblMontoReserva
         Else
            gstrMontosEnviados = gstrMontosEnviados & vbNewLine & "Serie : " & strEmisor & vbNewLine & "Monto Imputado : " & dblMontoReserva
         End If
         
         
         If strMsgXml_Body = "" Then
            strMsgXml_Body = "<Item><strEntidad>" & strCodEntidad & "</strEntidad>" & _
            "<strCodUsuario>" & strCodUsuario & "</strCodUsuario>" & _
            "<strRutCte>" & strRutCteEmisor & "</strRutCte>" & _
            "<intCodigoCliente>" & strCodigoCteEmisor & "</intCodigoCliente>" & _
            "<strCodMonedaIBS>" & strCodMonedaIBS & "</strCodMonedaIBS>" & _
            "<dblMontoOperacion>" & dblMontoReserva & "</dblMontoOperacion>" & _
            "<dblMontoMTM>" & dblMontoMTM & "</dblMontoMTM>" & _
            "<dblMontoGarantizado>" & dblMontoGarantizado & "</dblMontoGarantizado>" & _
            "<intCantDiasPermanencia>" & intCantDiasPermanencia & "</intCantDiasPermanencia>" & _
            "<strNumSolicitudSistema>" & strNumSolicitudSistema & "</strNumSolicitudSistema>" & _
            "<intCodigoDeuda>" & intCodigoDeuda & "</intCodigoDeuda>" & _
            "<intCodigoTransaccion>" & intCodigoTransaccion & "</intCodigoTransaccion>" & _
            "<strCodigoProductoIBS>" & strCodigoProductoIBS & "</strCodigoProductoIBS>" & _
            "<intCodigoPaisSBIF>" & intCodigoPaisSBIF & "</intCodigoPaisSBIF>" & _
            "<strIndicador>" & strIndicador & "</strIndicador>" & _
            "<strSistema>" & strSistemaOrigen & "</strSistema>" & _
            "<intTicket>" & intTicket & "</intTicket>" & _
            "<intPlazo>" & intPlazo & "</intPlazo>" & _
            "<strProducto>" & strProducto & "</strProducto></Item>"
        Else
             strMsgXml_Body = strMsgXml_Body & "<Item><strEntidad>" & strCodEntidad & "</strEntidad>" & _
            "<strCodUsuario>" & strCodUsuario & "</strCodUsuario>" & _
            "<strRutCte>" & strRutCteEmisor & "</strRutCte>" & _
            "<intCodigoCliente>" & strCodigoCteEmisor & "</intCodigoCliente>" & _
            "<strCodMonedaIBS>" & strCodMonedaIBS & "</strCodMonedaIBS>" & _
            "<dblMontoOperacion>" & dblMontoReserva & "</dblMontoOperacion>" & _
            "<dblMontoMTM>" & dblMontoMTM & "</dblMontoMTM>" & _
            "<dblMontoGarantizado>" & dblMontoGarantizado & "</dblMontoGarantizado>" & _
            "<intCantDiasPermanencia>" & intCantDiasPermanencia & "</intCantDiasPermanencia>" & _
            "<strNumSolicitudSistema>" & strNumSolicitudSistema & "</strNumSolicitudSistema>" & _
            "<intCodigoDeuda>" & intCodigoDeuda & "</intCodigoDeuda>" & _
            "<intCodigoTransaccion>" & intCodigoTransaccion & "</intCodigoTransaccion>" & _
            "<strCodigoProductoIBS>" & strCodigoProductoIBS & "</strCodigoProductoIBS>" & _
            "<intCodigoPaisSBIF>" & intCodigoPaisSBIF & "</intCodigoPaisSBIF>" & _
            "<strIndicador>" & strIndicador & "</strIndicador>" & _
            "<strSistema>" & strSistemaOrigen & "</strSistema>" & _
            "<intTicket>" & intTicket & "</intTicket>" & _
            "<intPlazo>" & intPlazo & "</intPlazo>" & _
            "<strProducto>" & strProducto & "</strProducto></Item>"
        End If
    Next iRow
End If

'Call Frm.Data1.Refresh

strMsgXml = cSOAP_Margenes_Art84_Header + strMsgXml_Body + cSOAP_Margenes_Art84_End
' GENERO EL ARCHIVO Y ANALISO LA RESPUESTA ENTREGADA POR EL WS
If Not blnOperacionCumpleArt84String(strMsgXml) Then
   'strMensaje = gstrMensajeErrorServicio
End If
gblnProcesoExitoso = blnRealizaProceso
End Sub
Function strTraeRutEmisor(strGenerico As String) As String
    strTraeRutEmisor = ""
    Call ObjEmisor.LeerPorGenerico(strGenerico)
    strTraeRutEmisor = ObjEmisor.emrut
End Function
Function blnCumpleMargen(strResp As String) As Boolean
Dim iCnt As Integer
Dim blnResult As Boolean

gstrMensajesError = ""
strAlert = ""
If Len(strResp) > 0 Then
    If lCanNodos > 0 Then
        For iCnt = 0 To lCanNodos
            If Len(strArrayRespuestas(iCnt)) > 0 Then
                blnResult = False
                If iCnt = 0 Then
                    gstrMensajesError = strArrayRespuestas(iCnt)
                Else
                    gstrMensajesError = gstrMensajesError & vbNewLine & strArrayRespuestas(iCnt)
                End If
            End If
        Next
    Else
        gstrMensajesError = "Error al leer XML Respuesta"
    End If
Else
    blnResult = True
End If
blnCumpleMargen = blnResult
End Function
Function strTraeGenericoByRut(strRut As String, Optional strCampo As String) As String
strTraeGenericoByRut = ""
If ObjEmisor.LeerPorRut(CLng(strRut), "O") Then
    If strCampo = "C" Then ' C= cod cliente
        strTraeGenericoByRut = Trim(ObjEmisor.emcodigo)
    ElseIf strCampo = "N" Then  ' N= nombre cliente
        strTraeGenericoByRut = Trim(ObjEmisor.emnombre)
    ElseIf strCampo = "D" Then  ' D= Digito Verificador
        strTraeGenericoByRut = Trim(ObjEmisor.emdv)
    Else
        strTraeGenericoByRut = Trim(ObjEmisor.emgeneric)
    End If
    
    
End If
End Function
Private Function strTraeClienteByRut(strRut As String, strCodCliente As String)
Dim Datos()
strTraeClienteByRut = ""

Envia = Array(CDbl(strRut), CDbl(strCodCliente))
If Not Bac_Sql_Execute(gsSQL_Database_comun & "..SP_MDCLLEERRUT1", Envia) Then
    Exit Function
End If

If Bac_SQL_Fetch(Datos()) Then
'        clrut = CDbl(Val(Datos(1)))
'        cldv = Datos(2)
'        clcodigo = CDbl(Val(Datos(3)))
        strTraeClienteByRut = Datos(4)
'        clgeneric = Datos(5)
'        cldirecc = Datos(6)
'        clcomuna = CDbl(Val(Datos(7)))
'        clregion = CDbl(Val(Datos(8)))
'        cltipcli = Datos(9)
'        clfecingr = Datos(10)
'        clctacte = Datos(11)
'        clfono = Datos(12)
'        clfax = Datos(13)
'        cltipocliente = CDbl(Val(Datos(14)))
'        clcalidadjuridica = CDbl(Val(Datos(15)))
'        clciudad = CDbl(Val(Datos(16)))
'        clentidad = CDbl(Val(Datos(17)))
'        clmercado = CDbl(Val(Datos(18)))
'        clgrupo = CDbl(Val(Datos(19)))
'        clapoderado = Datos(20)
'        clpais = CDbl(Val(Datos(21)))
'        cl1nombre = Datos(22)
'        cl2nombre = Datos(23)
'        cl1apellido = Datos(24)
'        cl2apellido = Datos(25)
'        clglosab = Datos(26)
'        clctausd = Datos(27)
'        climplic = Datos(28)
'        claba = Datos(29)
'        clchips = Datos(30)
'        clswift = Datos(31)
'        clopcion = Datos(32)
End If

End Function
Private Function getDescriptionError(strCod As String) As String
Select Case CLng(strCod)
    Case 1
        getDescriptionError = "Control de Márgenes"
    Case 2
        getDescriptionError = "Riesgo País"
    Case 213
        getDescriptionError = "Cliente con prohibición de Crédito"
    Case 214
        getDescriptionError = "Cliente con Exceso de Márgenes"
    Case 506
        getDescriptionError = "Cliente con Excepciones Administrativas Duras"
    Case Else
        getDescriptionError = "Error de comunicación con el control de Márgenes (Art84 On Line)"
End Select
End Function
Private Function Cuenta(Palabra As String, Letra As String) As Long
Dim Lugar As Long
Dim Total As Long
Do While Len(Palabra) > 0
   Lugar = InStr(Palabra, Letra)
   If Lugar = 0 Then Exit Do
   Total = Total + 1
   Palabra = Mid(Palabra, Lugar + 1)
Loop
Cuenta = Total
End Function
Private Sub CreaInterfazXMLArt84SOAP_String(strXML As String, strParametro As String)
Dim parser As DOMDocument
Set parser = New DOMDocument
Dim strLastString As String
' cargar el código SOAP para Art84

On Error GoTo Err_CreaInterfaz
    parser.loadXML strXML
    parser.SelectSingleNode("/soap:Envelope/soap:Body/ConsultaIBSXml/XmlString").Text = strParametro
    blnConexionExitosa = False
    enviarComando parser.XML, "IBS/ConsultaIBSXml"
    
    If blnConexionExitosa Then
        gblnAnalizaMargen = True
        strRespuestaProceso = strAlert
    End If
    Exit Sub
    
Err_CreaInterfaz:
    MsgBox err.Description, vbCritical, "Problemas al Generar XML de comunicación"
End Sub
Private Sub enviarComando(ByVal sXml As String, ByVal sSoapAction As String)
    ' Enviar el comando al servicio Web
    '
    ' usar XMLHTTPRequest para enviar la información al servicio Web
    Dim oHttReq As XMLHTTPRequest
    Set oHttReq = New XMLHTTPRequest
    
    Dim strMetodoWeb As String
    strMetodoWeb = "WSArticulo84.asmx"
    
    
    strURL = "http://" & strGetUrlService + strMetodoWeb
    
    ' PRUEBAS EN AMBIENTE LOCAL
    'strURL = "http://localhost:57729/WSArticulo84.asmx"
      
    On Error GoTo Err_Comando
    
    ' Enviar el comando de forma síncrona (se espera a que se reciba la respuesta)
    oHttReq.Open "POST", strURL, False
    ' las cabeceras a enviar al servicio Web
    ' (no incluir los dos puntos en el nombre de la cabecera)
    oHttReq.setRequestHeader "Content-Type", "text/xml; charset=utf-8"
    oHttReq.setRequestHeader "SOAPAction", sSoapAction
    ' enviar el comando
    oHttReq.send sXml
    ' este será el texto recibido del servicio Web
    procesarRespuesta oHttReq.responseText
    Exit Sub
    
Err_Comando:
    blnConexionExitosa = False
    MsgBox err.Description
End Sub
Private Sub procesarRespuesta(ByVal S As String)
    ' procesar la respuesta recibida del servicio Web
    strRespWS = S
    ' Poner los datos en el analizador de XML
    Dim success As Boolean
    Dim parser As DOMDocument
    Set parser = New DOMDocument
    Dim Doc As New MSXML.DOMDocument
   
    ' Elimino caracteres invalidos
    S = strReemplaceInvalidChar(S)
    
    
    ' Parseo string a XML
    parser.loadXML S
        
    On Error GoTo Err_Procesa
    
    strAlert = ""
    
    ' Obtengo flag que indica si el proceso se realizo correctamente (1=Proceso de comunicación Correcto - 0=Proceso de comunicación con errores)
    strFlagSuccess = parser.SelectSingleNode("/soap:Envelope/soap:Body/ConsultaIBSXmlResponse/ConsultaIBSXmlResult/Header/FLAG").Text
    ' si el proceso se efectuo correctamente
    If strFlagSuccess = "1" Then
        ' Recorro archivo XML, generado a partir de string de retorno
        Call LeeXML(strRespWS) '(App.Path & "TEMP.xml")
            
        blnConexionExitosa = True
        strRespuestaProceso = strAlert
        If err.Number > 0 Then
            blnConexionExitosa = False
        End If
    Else
        Call LeeErrores(strRespWS) '(App.Path & "TEMP.xml")
        
'        gstrMensajesError = vbNewLine & strSeparador & vbNewLine & "Existen Problemas de comunicación con el proceso de análisis de Márgenes" & _
'            vbNewLine & "Detalle Error : " & vbNewLine & strAlert & vbNewLine & strSeparador & vbNewLine & _
'            "Favor Intentar nuevamente o Informar a Sistemas"
            
            
         gstrMensajesError = vbNewLine & strSeparador & vbNewLine & "Existen Problemas de comunicación con el proceso de análisis de Márgenes" & vbNewLine & _
               strMsgNoConecta & vbNewLine & strSeparador & vbNewLine & _
            "Favor Intentar nuevamente o Informar a Sistemas"
            
        blnConexionExitosa = False
    End If
    
    Exit Sub
Err_Procesa:
    blnConexionExitosa = False
    MsgBox err.Description, vbCritical, "Problema al Procesar respuesta"
End Sub
Private Sub BorraFile(strPath As String)
    Call Kill(strPath)
End Sub
'*****************************************************************************
' Funcion que obtiene datos del emisor a partir de la serie del documento
'*****************************************************************************
Function strTraeEmisorSerie(strSerie As String, Optional strCampo As String) As String
Dim strError As String
strTraeEmisorSerie = ""

    Envia = Array(strSerie)
    If Not Bac_Sql_Execute("SP_CHKINSTSER", Envia) Then
        MsgBox "Serie no pudo ser validada", vbExclamation, gsBac_Version
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        strError = Val(Datos(1))
        If strError = 0 Then
            If Format(Datos(10), "yyyymmdd") <= Format(gsBac_Fecp, "yyyymmdd") Then
                MsgBox "Serie ingresada esta vencida ", vbInformation, gsBac_Version
             '   CPCI_ChkSerie = False
                Exit Function
            End If
            If strCampo = "R" Then
                ' RUT
                strTraeEmisorSerie = Datos(5)
            Else
                strTraeEmisorSerie = Datos(12)
            End If
        End If
    Else
        MsgBox "No se pudo chequear la serie", vbExclamation, gsBac_Version
    End If
End Function
Private Sub LeeErrores(strRuta As String)
Dim xmlDoc As DOMDocument
Dim objNodeList As IXMLDOMNodeList
Dim objNodeAlertList As IXMLDOMNodeList
Dim objHoraError As IXMLDOMNode
Dim objLineaError As IXMLDOMNode
Dim objMetodo As IXMLDOMNode
Dim objClase As IXMLDOMNode
Dim objErrorDesc As IXMLDOMNode
Dim objNode As IXMLDOMNode
Dim objNodeAlert As IXMLDOMNode
Dim XMLurl As String
Dim strRet As String
Dim strDetAterta As String
Dim strGlosa As String

' variable para contar nodos
lCanNodos = 0
Dim lContador As Long

Set xmlDoc = New DOMDocument
XMLurl = strRuta
xmlDoc.async = False

strDetAterta = ""
strAlert = ""

gstrNrosOperacionesIBS = ""

On Error GoTo Err_LeeXML
' Cargo el XML para su transformación y análisis
If xmlDoc.loadXML(XMLurl) = False Then
    MsgBox ("XML LOAD ERROR")
Else
    ' identifico nodos que traen respuestas por items (EVENTO_APLICACION/LOG_ERRORES_APLICACION)
    Set objNodeList = xmlDoc.SelectNodes("//EVENTO_APLICACION/LOG_ERRORES_APLICACION")
    ' cuento los nodos items del XML
    lCanNodos = objNodeList.Length
    ' redimensiono arreglo
    ReDim strArrayRespuestas(lCanNodos)
    ' inicializo contador
    lContador = 0
    ' recorro cada nodo
    For Each objNode In objNodeList
        ' cargo objetos con la información de cada tag
        Set objHoraError = objNode.SelectSingleNode("HORA")
        Set objLineaError = objNode.SelectSingleNode("LINEA")
        Set objMetodo = objNode.SelectSingleNode("METODO")
        Set objClase = objNode.SelectSingleNode("CLASE")
        Set objErrorDesc = objNode.SelectSingleNode("ERROR")
        strGlosa = "Detalle error: " & objErrorDesc.Text & vbNewLine & _
               "Clase / Metodo : " & objClase.Text & " / " & objMetodo.Text & vbNewLine & "Linea : " & objLineaError.Text
        
        If lContador = 0 Then
            strAlert = strGlosa
        Else
            strAlert = strAlert & vbNewLine & strSeparador & vbNewLine & strGlosa
        End If
        lContador = lContador + 1
    Next objNode
End If
Exit Sub
Err_LeeXML:
    MsgBox err.Description, vbCritical, "Problema al Leer XML"
End Sub
Private Sub LeeXML(strXMLRuta As String)
Dim xmlDoc As DOMDocument
Dim objNodeList As IXMLDOMNodeList
Dim objNodeWarningList As IXMLDOMNodeList
Dim objNodeCalculoIBSList As IXMLDOMNodeList
Dim objNodeAlertList As IXMLDOMNodeList
Dim objFlagCumplimiento As IXMLDOMNode
Dim objCorrIngresoIBS As IXMLDOMNode
Dim objNombreCliente As IXMLDOMNode
Dim objDetAlerta As IXMLDOMNode
Dim objFlagAlerta As IXMLDOMNode
Dim objCodAlerta As IXMLDOMNode
Dim objNode As IXMLDOMNode
Dim objNodeAlert As IXMLDOMNode
Dim objNodeCalculos As IXMLDOMNode

' nuevos nodos
Dim objCodeError As IXMLDOMNode
Dim objDescError As IXMLDOMNode
Dim objSourceError As IXMLDOMNode
Dim objMontoOperacion As IXMLDOMNode
Dim objRutCliente As IXMLDOMNode

Dim XMLurl As String
Dim strRet As String
Dim strDetAterta As String
Dim strDescripcionAlerta As String
Dim strDetCalculos As String
Dim strClienteRetorno As String
Dim strRutCliente As String
Dim lContador As Long

' variable para contar nodos
lCanNodos = 0
Set xmlDoc = New DOMDocument
XMLurl = strXMLRuta
xmlDoc.async = False
strDetAterta = ""

gstrNrosOperacionesIBS = ""
gstrDetMontosImputables = ""

On Error GoTo Err_LeeXML
' Cargo el XML para su transformación y análisis
'If xmlDoc.Load(XMLurl) = False Then
If xmlDoc.loadXML(XMLurl) = False Then
    MsgBox "ERROR AL CARGAR XML DE RESPUESTA", vbCritical, "Error en control de Margenes Art84"
    strAlert = "Error de comunicacion con Broker"
Else
    ' identifico nodos que traen respuestas por items (Data/OutputIBS)
    Set objNodeList = xmlDoc.SelectNodes("//Data/OutputIBS")
    ' cuento los nodos items del XML
    lCanNodos = objNodeList.Length
    ' redimensiono arreglo
    ReDim strArrayRespuestas(lCanNodos)
    ' inicializo contador
    lContador = 0
    ' recorro cada nodo
    For Each objNode In objNodeList
        ' cargo objetos con la información de cada tag
        Set objFlagCumplimiento = objNode.SelectSingleNode("flagCumplimiento")
        Set objCorrIngresoIBS = objNode.SelectSingleNode("correlativoIngresoIBS")
        Set objNombreCliente = objNode.SelectSingleNode("nombreCliente")
                        
        If Len(gstrNrosOperacionesIBS) = 0 Then
            gstrNrosOperacionesIBS = objCorrIngresoIBS.Text
        Else
            gstrNrosOperacionesIBS = gstrNrosOperacionesIBS & " ; " & objCorrIngresoIBS.Text
        End If
        
        ' identifico si el item analizado cumple el margen
         If Trim(objFlagCumplimiento.Text) = "N" Then        ' No cumple margen
        ' solo cargo alertas y mensajes cuando la operación no cumpla
        ' con los márgenes asociados al Art84
            ' limpio variable
            strDetAterta = ""

            ' identifico nodos con Warnings asociados al envío
            Set objNodeWarningList = objNode.SelectNodes("footer/FooterOutputIBS/errors/error")
            If objNodeWarningList.Length > 0 Then
                ' recorro cada nodo
                For Each objNodeAlert In objNodeWarningList
                    ' cargo objetos con la información de cada tag con los mensajes de respuesta
                    Set objCodeError = objNodeAlert.SelectSingleNode("code")
                    Set objDescError = objNodeAlert.SelectSingleNode("description")
                    Set objSourceError = objNodeAlert.SelectSingleNode("source")
                    
                    Set objNodeCalculoIBSList = objNode.SelectNodes("CalculosIBS")
                    If objNodeCalculoIBSList.Length > 0 Then
                        For Each objNodeCalculos In objNodeCalculoIBSList
                            Set objMontoOperacion = objNodeCalculos.SelectSingleNode("MONTO_OPERACION")
                            Set objRutCliente = objNodeCalculos.SelectSingleNode("RUT_CLIENTE")
                            If Len(objRutCliente.Text) > 0 Then
                                strRutCliente = objRutCliente.Text
                            End If
                            If Len(objMontoOperacion.Text) > 0 Then
                                strDetCalculos = objMontoOperacion.Text
                            Else
                                strDetCalculos = "No se pudo obtener el monto imputado"
                            End If
                        Next
                    End If
                     ' concateno las alertas
                    If strDetAterta = "" Then
                        strDetAterta = objDescError.Text & vbNewLine & "Monto Imputado : " & strDetCalculos
                    Else
                        strDetAterta = strDetAterta & vbNewLine & objDescError.Text & vbNewLine & "Monto Imputado :" & strDetCalculos
                    End If
                Next
            End If
            
             ' identifico nodos que traen mensajes de alerta
            Set objNodeAlertList = objNode.SelectNodes("alerta/alerta")
            If objNodeAlertList.Length > 0 Then
                ' recorro cada nodo
                For Each objNodeAlert In objNodeAlertList
                    ' cargo objetos con la información de cada tag con los mensajes de respuesta
                    Set objFlagAlerta = objNodeAlert.SelectSingleNode("flagAlerta")
                    Set objCodAlerta = objNodeAlert.SelectSingleNode("codigoAlerta")
                    Set objDetAlerta = objNodeAlert.SelectSingleNode("descripcionAlerta")
                     ' concateno las alertas
                    If strDescripcionAlerta = "" Then
                        strDescripcionAlerta = objDetAlerta.Text
                    Else
                        If Trim(objDetAlerta.Text) <> Trim(strDescripcionAlerta) Then
                            strDescripcionAlerta = strDescripcionAlerta & vbNewLine & objDetAlerta.Text
                        End If
                    End If
                Next
            End If
            
            
            
            ' identifico nodos que traen mensajes de alerta
            Set objNodeAlertList = objNode.SelectNodes("alerta/alerta/alerta/DetalleAlertasIBS")
            If objNodeAlertList.Length > 0 Then
                ' recorro cada nodo
                For Each objNodeAlert In objNodeAlertList
                    ' cargo objetos con la información de cada tag con los mensajes de respuesta
                    Set objFlagAlerta = objNodeAlert.SelectSingleNode("flagAlerta")
                    Set objCodAlerta = objNodeAlert.SelectSingleNode("codigoAlerta")
                    Set objDetAlerta = objNodeAlert.SelectSingleNode("detalleAlerta")
                     ' concateno las alertas
                    If strDetAterta = "" Then
                        strDetAterta = objDetAlerta.Text
                    Else
                        strDetAterta = strDetAterta & vbNewLine & objDetAlerta.Text
                    End If
                Next
            End If
            
            Set objNodeCalculoIBSList = objNode.SelectNodes("CalculosIBS")
            If objNodeCalculoIBSList.Length > 0 Then
                For Each objNodeCalculos In objNodeCalculoIBSList
                    Set objMontoOperacion = objNodeCalculos.SelectSingleNode("MONTO_OPERACION")
                    Set objRutCliente = objNodeCalculos.SelectSingleNode("RUT_CLIENTE")
                    If Len(objRutCliente.Text) > 0 Then
                        strRutCliente = objRutCliente.Text
                    End If
                    
                    If gstrDetMontosImputables = "" Then
                        If Len(objMontoOperacion.Text) > 0 Then
                            gstrDetMontosImputables = "Monto(s) Imputado(s) : " & objMontoOperacion.Text
                        Else
                            gstrDetMontosImputables = "Monto(s) Imputado(s) : No se pudo obtener el monto imputado"
                        End If
                        gstrDetMontosImputables = gstrDetMontosImputables & vbNewLine & "Rut Imputado : " & strRutCliente
                    Else
                        gstrDetMontosImputables = gstrDetMontosImputables & vbNewLine & _
                        "Monto(s) Imputado(s) : " & objMontoOperacion.Text & vbNewLine & "Rut Imputado : " & strRutCliente
                    End If

                Next
            End If
            
            
            
            strClienteRetorno = objNombreCliente.Text
            If Len(strClienteRetorno) = 0 Then
                strClienteRetorno = strTraeGenericoByRut(strRutCliente, "N")
            End If
            If Len(strClienteRetorno) = 0 Then
                strClienteRetorno = strTraeClienteByRut(strRutCliente, "1")
            End If
            
            strArrayRespuestas(lContador) = vbNewLine & strSeparador & vbNewLine & "Cliente: " & strClienteRetorno & vbNewLine & "Codigo Operacion: " & objCorrIngresoIBS.Text & vbNewLine & _
                "Detalle Alerta : " & strDescripcionAlerta & vbNewLine & strDetAterta
            ' concateno detalle de la operación + las alertas concatenadas
            strRet = objFlagCumplimiento.Text & "-" & objCorrIngresoIBS.Text & "-" & objNombreCliente.Text & " | " & strDetAterta
            If strAlert = "" Then
                strAlert = strRet
            Else
                strAlert = strAlert & " ;" & strRet
            End If
            lContador = lContador + 1
        Else
            
            Set objNodeCalculoIBSList = objNode.SelectNodes("CalculosIBS")
            If objNodeCalculoIBSList.Length > 0 Then
                For Each objNodeCalculos In objNodeCalculoIBSList
                    Set objMontoOperacion = objNodeCalculos.SelectSingleNode("MONTO_OPERACION")
                    Set objRutCliente = objNodeCalculos.SelectSingleNode("RUT_CLIENTE")
                    If Len(objRutCliente.Text) > 0 Then
                        strRutCliente = objRutCliente.Text
                    End If
                    
                    If gstrDetMontosImputables = "" Then
                        If Len(objMontoOperacion.Text) > 0 Then
                            gstrDetMontosImputables = "Monto(s) Imputado(s) : " & objMontoOperacion.Text
                        Else
                            gstrDetMontosImputables = "Monto(s) Imputado(s) : No se pudo obtener el monto imputado"
                        End If
                        gstrDetMontosImputables = gstrDetMontosImputables & vbNewLine & "Rut Imputado : " & strRutCliente
                    Else
                        gstrDetMontosImputables = gstrDetMontosImputables & vbNewLine & _
                        "Monto(s) Imputado(s) : " & objMontoOperacion.Text & vbNewLine & "Rut Imputado : " & strRutCliente
                    End If

                Next
            End If
            
            
            Set objNodeWarningList = objNode.SelectNodes("footer/FooterOutputIBS/errors/error")
            If objNodeWarningList.Length > 0 Then
                ' recorro cada nodo
                For Each objNodeAlert In objNodeWarningList
                    ' cargo objetos con la información de cada tag con los mensajes de respuesta
                    Set objCodeError = objNodeAlert.SelectSingleNode("code")
                    Set objDescError = objNodeAlert.SelectSingleNode("description")
                    Set objSourceError = objNodeAlert.SelectSingleNode("source")
                    
                    Set objNodeCalculoIBSList = objNode.SelectNodes("CalculosIBS")
                    If objNodeCalculoIBSList.Length > 0 Then
                        For Each objNodeCalculos In objNodeCalculoIBSList
                            Set objMontoOperacion = objNodeCalculos.SelectSingleNode("MONTO_OPERACION")
                            Set objRutCliente = objNodeCalculos.SelectSingleNode("RUT_CLIENTE")
                            If Len(objRutCliente.Text) > 0 Then
                                strRutCliente = objRutCliente.Text
                            End If
                            If gstrDetMontosImputables = "" Then
                                If Len(objMontoOperacion.Text) > 0 Then
                                    gstrDetMontosImputables = "Monto(s) Imputado(s) : " & objMontoOperacion.Text
                                Else
                                    gstrDetMontosImputables = "Monto(s) Imputado(s) : No se pudo obtener el monto imputado"
                                End If
                                gstrDetMontosImputables = gstrDetMontosImputables & vbNewLine & "Rut Imputado : " & strRutCliente
                            Else
                                gstrDetMontosImputables = gstrDetMontosImputables & vbNewLine & _
                                "Monto(s) Imputado(s) : " & objMontoOperacion.Text & vbNewLine & "Rut Imputado : " & strRutCliente
                            End If
                         Next
                    End If
                    
                Next
            End If
         End If
    Next objNode
End If
Exit Sub
Err_LeeXML:
    MsgBox err.Description, vbCritical, "Problema al Leer XML"
End Sub
Function gdblObtieneValorPesos(dblMontoUSD As Double) As Double
Dim aTim As New clsValorMoneda
Dim Valor_Moneda As Double
    Valor_Moneda = FUNC_BUSCA_VALOR_MONEDA(998, Format(gsBac_Fecp, "DD/MM/YYYY"))
    gdblObtieneValorPesos = Valor_Moneda * dblMontoUSD
End Function
Function lngTraeTicketArt84() As Long
Dim Datos()
Dim cSql As String
Dim lngRespuesta As Long
lngRespuesta = 0

Envia = Array()

If Not Bac_Sql_Execute(gsSQL_Database_comun & "..SP_TICKET_ARTICULO_84", Envia) Then Exit Function
If Bac_SQL_Fetch(Datos()) Then
    lngRespuesta = Datos(1)
End If

lngTraeTicketArt84 = lngRespuesta
End Function

Function dblTraeTipoCambio(lCodMoneda As Integer) As Double
Dim dblTipoCambio As Double
Dim lngCodDO As Long
dblTipoCambio = 0

' codigo moneda dolar observado
lngCodDO = 994
If lCodMoneda = 13 Then ' 13=USD
    dblTipoCambio = FUNC_BUSCA_VALOR_MONEDA_CONTABLE(CInt(lngCodDO), Format(gsBac_Fecp, "DD/MM/YYYY"))
    If dblTipoCambio = 0 Then
        dblTipoCambio = FUNC_BUSCA_VALOR_MONEDA(CInt(lngCodDO), Format(gsBac_Fecp, "DD/MM/YYYY"))
    End If
    ' ******************************************
    ' reviso proceso  con fecha anterior
    ' si aun no encuentra tipo de cambio contable, realizar consulta con fecha del ultimo proceso registrado
    If dblTipoCambio = 0 Then
        dblTipoCambio = FUNC_BUSCA_VALOR_MONEDA_CONTABLE(CInt(lngCodDO), Format(gsBac_Feca, "DD/MM/YYYY"))
    End If
    ' reviso valor moneda con fecha del proceso anterior
    If dblTipoCambio = 0 Then
        dblTipoCambio = FUNC_BUSCA_VALOR_MONEDA(CInt(lngCodDO), Format(gsBac_Feca, "DD/MM/YYYY"))
    End If
Else
    dblTipoCambio = FUNC_BUSCA_VALOR_MONEDA_CONTABLE(lCodMoneda, Format(gsBac_Fecp, "DD/MM/YYYY"))
    If dblTipoCambio = 0 Then
        dblTipoCambio = FUNC_BUSCA_VALOR_MONEDA(lCodMoneda, Format(gsBac_Fecp, "DD/MM/YYYY"))
    End If
    ' ******************************************
    ' reviso proceso  con fecha anterior
    ' si aun no encuentra tipo de cambio contable, realizar consulta con fecha del ultimo proceso registrado
    If dblTipoCambio = 0 Then
        dblTipoCambio = FUNC_BUSCA_VALOR_MONEDA_CONTABLE(lCodMoneda, Format(gsBac_Feca, "DD/MM/YYYY"))
    End If
    ' reviso valor moneda con fecha del proceso anterior
    If dblTipoCambio = 0 Then
        dblTipoCambio = FUNC_BUSCA_VALOR_MONEDA(lCodMoneda, Format(gsBac_Feca, "DD/MM/YYYY"))
    End If
End If
dblTraeTipoCambio = dblTipoCambio
End Function
Sub GeneraConfirmacionProceso(lNroTicket As Long, lNroOperacion As Long, strSistemaOrigen As String, strNrosIBS As String)
Dim strArray() As String
Dim lCuenta As Long
Dim iCont As Integer
Dim strTemp As String

'
strTemp = strNrosIBS
lCuenta = 0
lCuenta = Cuenta(strTemp, ";")
ReDim strArray(lCuenta)
strArray = Split(strNrosIBS, ";")

If lCuenta > 0 Then
    For iCont = 0 To lCuenta
        Call GrabaConfirmacionProceso(lNroTicket, lNroOperacion, strSistemaOrigen, Val(strArray(iCont)))
    Next
Else
    Call GrabaConfirmacionProceso(lNroTicket, lNroOperacion, strSistemaOrigen, Val(strNrosIBS))
End If

End Sub
Private Sub GrabaConfirmacionProceso(lTicket As Long, lOperacion As Long, strSistemaOri As String, lNroIBS As Long)
Dim Datos()
    Envia = Array(CLng(lTicket), CLng(lOperacion), strSistemaOri, lNroIBS)
    If Not Bac_Sql_Execute(gsSQL_Database_comun & "..SP_I_ART84_INPWSIBS_OPE_TICK", Envia) Then
        Exit Sub
    End If
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) < 0 Then
            MsgBox "Error al Grabar ticket de procedimiento Art84", vbExclamation, "BAC Trader"
            Exit Sub
        End If
    End If
End Sub
Function blnProcesoArt84Activo(strSistemaOrigen As String) As Boolean
Dim blnResult As Boolean
Dim intCodParam As Integer
Dim Datos()

intCodParam = 8604 '8604=  HABILITA CONTROL ART84 (0=S , 1=N)
blnResult = False

Envia = Array(intCodParam, Trim(strSistemaOrigen))
If Not Bac_Sql_Execute(gsSQL_Database_comun & "..SP_CON_PROCESO_ACTIVO", Envia) Then
    Exit Function
End If
If Bac_SQL_Fetch(Datos()) Then
    If Datos(1) < 0 Then
        MsgBox "Error al Identificar estado del servicio control de Márgenes", vbExclamation, "BAC Trader"
        Exit Function
    Else
        If CInt(Datos(1)) = 1 Then
            blnResult = True
        Else
            blnResult = False
        End If
    End If
End If
blnProcesoArt84Activo = blnResult
End Function
Function blnAnulaControlMargenes(dblNumOpera As Double, strSistemaOri As String, strRut As String, strCodigo As String) As Boolean
Dim strSistemaOrigen As String
Dim lngNeoTicket As Long
Dim dblCorrelativoIBS As Double

' obtiene nuevo numero de tickets
lngNeoTicket = lngTraeTicketArt84()
' obtiene numero de correlativo IBS a partir del nro de operación y cod. sistema origen
dblCorrelativoIBS = dblTraeCorrIbsByOperacion(dblNumOpera, Trim(strSistemaOri))


strCodEntidad = "3"                         ' 3=mesa dinero
strCodUsuario = gsBac_User$                 ' Usuario Registrado en sistema
strRutCteEmisor = Trim(strRut)              ' rut contraparte
strCodigoCteEmisor = Trim(strCodigo)

strCodMonedaIBS = "CLP"                     ' CLP= Chilean pesos
dblMontoReserva = 0
dblMontoGarantizado = 0                     ' no se utiliza
intCantDiasPermanencia = 1                  ' 1= dura un solo dia
strNumSolicitudSistema = dblCorrelativoIBS  ' se envia con valor 0
intCodigoDeuda = 5                          ' 5= deuda bonos
intCodigoTransaccion = 4                    ' 4 Eliminación Simulación con Reserva
strCodigoProductoIBS = "MD01"               ' MD01 = Mesa de dinero
intCodigoPaisSBIF = 160                     ' 160 = CHILE
strIndicador = "A"                          ' A=Activo
strSistemaOrigen = "BTR"                    ' BTR        RENTA FIJA

intTicket = lngNeoTicket
strProducto = "0"


strMsgXml = ""
strMsgXml_Body = ""
strMsgXml_Body = "<Item><strEntidad>" & strCodEntidad & "</strEntidad>" & _
            "<strCodUsuario>" & strCodUsuario & "</strCodUsuario>" & _
            "<strRutCte>" & strRutCteEmisor & "</strRutCte>" & _
            "<intCodigoCliente>" & strCodigoCteEmisor & "</intCodigoCliente>" & _
            "<strCodMonedaIBS>" & strCodMonedaIBS & "</strCodMonedaIBS>" & _
            "<dblMontoOperacion>" & dblMontoReserva & "</dblMontoOperacion>" & _
            "<dblMontoMTM>" & dblMontoReserva & "</dblMontoMTM>" & _
            "<dblMontoGarantizado>" & dblMontoGarantizado & "</dblMontoGarantizado>" & _
            "<intCantDiasPermanencia>" & intCantDiasPermanencia & "</intCantDiasPermanencia>" & _
            "<strNumSolicitudSistema>" & strNumSolicitudSistema & "</strNumSolicitudSistema>" & _
            "<intCodigoDeuda>" & intCodigoDeuda & "</intCodigoDeuda>" & _
            "<intCodigoTransaccion>" & intCodigoTransaccion & "</intCodigoTransaccion>" & _
            "<strCodigoProductoIBS>" & strCodigoProductoIBS & "</strCodigoProductoIBS>" & _
            "<intCodigoPaisSBIF>" & intCodigoPaisSBIF & "</intCodigoPaisSBIF>" & _
            "<strIndicador>" & strIndicador & "</strIndicador>" & _
            "<strSistema>" & strSistemaOrigen & "</strSistema>" & _
            "<intTicket>" & intTicket & "</intTicket>" & _
            "<intPlazo>" & intPlazo & "</intPlazo>" & _
            "<strProducto>" & strProducto & "</strProducto></Item>"
            
' concateno los string para generar XML final
strMsgXml = cSOAP_Margenes_Art84_Header + strMsgXml_Body + cSOAP_Margenes_Art84_End
' GENERO EL ARCHIVO Y ANALISO LA RESPUESTA ENTREGADA POR EL WS
If Not blnOperacionCumpleArt84String(strMsgXml) Then
    blnAnulaControlMargenes = False
Else
    blnAnulaControlMargenes = True
End If

End Function
Function dblTraeCorrIbsByOperacion(lNumOperacion As Double, strCodSistema As String) As Double
Dim Datos()
Dim cSql As String
Dim lngRespuesta As Long
lngRespuesta = 0

Envia = Array(lNumOperacion, strCodSistema)
If Not Bac_Sql_Execute(gsSQL_Database_comun & "..SP_CON_CORRELATIVO_IBS", Envia) Then Exit Function
If Bac_SQL_Fetch(Datos()) Then
    lngRespuesta = Datos(1)
End If

dblTraeCorrIbsByOperacion = lngRespuesta
End Function
Function strGetUrlService() As String
Dim blnResult As Boolean
Dim intCodParam As Integer
Dim Datos()

intCodParam = 8605 '8605=  URL WS ART84
blnResult = False

strRutaWS = ""

Envia = Array(intCodParam)
If Not Bac_Sql_Execute(gsSQL_Database_comun & "..SP_CON_RUTA_WS", Envia) Then
    Exit Function
End If
Do While Bac_SQL_Fetch(Datos())
    If Len(Trim(Datos(1))) > 0 Then
        If Len(strRutaWS) = 0 Then
            strRutaWS = Trim(Datos(1))
        Else
            strRutaWS = strRutaWS & Trim(Datos(1))
        End If
    End If
Loop
strGetUrlService = strRutaWS
End Function
Function strReemplaceInvalidChar(strText As String) As String
Dim strTemporal As String


'MsgBox strText, vbInformation, "Original"

strTemporal = Replace(strText, "Á", "A")
strTemporal = Replace(strTemporal, "É", "E")
strTemporal = Replace(strTemporal, "Í", "I")
strTemporal = Replace(strTemporal, "Ó", "O")
strTemporal = Replace(strTemporal, "Ú", "U")
strTemporal = Replace(strTemporal, "á", "a")
strTemporal = Replace(strTemporal, "é", "e")
strTemporal = Replace(strTemporal, "í", "i")
strTemporal = Replace(strTemporal, "ó", "o")
strTemporal = Replace(strTemporal, "ú", "u")
strTemporal = Replace(strTemporal, "Ñ", "N")
strTemporal = Replace(strTemporal, "ñ", "n")


'MsgBox strTemporal, vbInformation, "Modificado"

strReemplaceInvalidChar = strTemporal

End Function


