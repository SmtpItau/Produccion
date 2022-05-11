Attribute VB_Name = "Control_linea_IDD"
Option Explicit
Dim blnRealizaProceso As Boolean
Dim blnConexionExitosa As Boolean
Public strMensajeError
Global gblnProcesoExitosoXXX As Boolean
Dim strRespWS As String
Dim strRespuestaProceso As String
Dim strMsgXml As String
Dim strMsgXml_Body As Variant
Dim strAlert As String
Dim strFlagSuccess As String
Dim strDetalleResp As String
Global glngNroTicketxx As Long
Dim Datos()
Dim lCanNodos As Long


Global glngNroTicketAnulacion As Long
Global glngRutClienteArt84 As Long
Global glngCodClienteArt84 As Long
'+++jcamposd
Dim strIDRegistro As String
Dim strCustac As String
Dim strOK As String
Dim strCodSuc As String
Dim strAccOff As String
Dim strTipCre As String
Dim strConAnt As String
Dim strCurdes As String
Dim strMonto As String
Dim strMtoAr84 As String
Dim strPlazo As String
Dim strNumOpf As String
Dim strTasa As String
Dim strSpread As String
Dim strOK2 As String
Dim strBanco1 As String
Dim strSubCli As String
Dim strBanco2 As String


'---jcamposd



Global gblNombreClienteArt84 As String

' Parametros utilizados
Dim strCodEntidad As String
Dim strCodUsuario As String
Dim strDateTime As String
Dim strRutCteEmisor As String
Dim strCodCliente As String
Dim strCodMonedaIBS As String
Dim intCantDiasPermanencia As Integer
Dim strNumSolicitudSistema As String
Dim intCodigoDeuda As Integer
Dim intCodigoTransaccion As Integer
Dim strCodigoProductoIBS As String
Dim strCodigoProducto As String
Dim intCodigoPaisSBIF As Integer
Dim strIndicador As String
Dim iRow As Integer
Dim strEmisor As String
Dim strSerieDoc As String
Dim intPlazo As Integer
Dim intTicket As Integer
Dim intTicketAnulacion As Integer
Dim strSistemaOrigen As String
Dim strArrayRespuestas() As String
Private Const gsSQL_Database_comun = "BacParamSuda"
Private Const gsSQL_Database_fwsuda = "Bacfwdsuda"
Global gblSW_Valor_MTM        As Double
Global gblSW_Plazo                  As Integer
Global gblSW_MontoReserva As Double
Global gblstrCodMonedaIBS As String
Global gblintTipoSwap As Integer
Global gstrGuardaComo As String


Private Const strSeparador = "_________________________________________________________________"
Private Const strMsgNoConecta = " No se ha podido conectar con servicio IBS "
Public Const strMsgGeneralxxx = strSeparador + vbNewLine + vbNewLine + " Por control de lineas Articulo 84" + vbNewLine + strSeparador


Dim strURL As String
Dim strRutaWS As String


' DIRECCION DEL WS
'Private Const strURL = "http://localhost:59175/WsInterfazArt84.asmx"
'Private Const strURL = "http://172.18.55.24:9998/WSArticulo84.asmx"

Global gstrNrosOperacionesIBSXXX As String

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
Function blnOperacionCumpleArt84String(strXML As String) As Boolean
blnRealizaProceso = False

' proceso que crea el archivo XML y lo envía al WS
Call CreaInterfazXML_String(cSoapMargenString, strXML)

' Reviso si el proceso se generó correctamente
If blnConexionExitosa Then
    ' analizo la respuesta identificando
    If blnCumpleMargen(strRespuestaProceso) Then
        blnRealizaProceso = True
    Else
        blnRealizaProceso = False
    End If
End If
blnOperacionCumpleArt84String = blnRealizaProceso
End Function
Sub GeneraArchivoInterfaz(Frm As Form)
Dim dblTipoCambio As Double
Dim dblMontoGarantizado As Double
Dim strTipoPayOff As String
Dim dblPesoFijoAsia As Double

strCodEntidad = "3"                         ' 3=mesa dinero
strCodUsuario = gsBac_User$                 ' Usuario Registrado en sistema
strRutCteEmisor = Replace(Trim(Frm.txtRut.Tag), ".", "")  ' rut contraparte
  
  
dblMontoGarantizado = 0                     ' no se utiliza
intCantDiasPermanencia = 1                  ' 1= dura un solo dia
strNumSolicitudSistema = 0                  ' se envia con valor 0
intCodigoDeuda = 7                          ' 7= deuda swap
intCodigoTransaccion = 1                    ' 1 Ingresa simulación con reserva + Realiza calculo control de márgenes + Entrega cupo disponible con Flag si cumple o no con el límite de endeudamiento + Código de alarma si presenta bloqueo por alarma

strCodigoProductoIBS = "MD01"               ' MD01 = Mesa de dinero
intCodigoPaisSBIF = 160                     ' 160 = CHILE
strIndicador = "A"                          ' A=Activo
strCodCliente = Frm.txtCliente.Tag

intTicket = lngTraeTicketArt84()            ' nro ticket unico que sirve para identificar la peticion contra nro de operacion (IBS)
intPlazo = gblSW_Plazo


'If (gblintTipoSwap = "1") Then
'strCodigoProducto = "ST"
'End If

'If (gblintTipoSwap = "2") Then
'    strCodigoProducto = "SM"
'End If

'If (gblintTipoSwap = "4") Then
'strCodigoProducto = "SP"
'End If


strSistemaOrigen = "PCS"

glngNroTicketxx = intTicket

gblNombreClienteArt84 = Frm.txtCliente.text


Call LimpiarVariablesMensajes

'variables fijas

strIDRegistro = "ID19620798C0120731"
'strCustac
strOK = "Y"
strCodSuc = "11"
strAccOff = "MSD"
strTipCre = ""
strConAnt = "000000"
strNumOpf = "0000000"
strTasa = "0000000"
strSpread = "00000"
strOK2 = "Y"
strBanco1 = "                    "
strSubCli = "0000001"
strBanco2 = " "



'
strMsgXml = ""
strMsgXml_Body = ""
strMsgXml_Body = "<Item><strIDRegistro>" & strIDRegistro & "</strIDRegistro>" & _
                "<Custac>" & strCustac & "</Custac>" & _
                "<OK>" & strOK & "</OK>" & _
                "<CodSuc>" & strCodSuc & "</CodSuc>" & _
                "<AccOff>" & strAccOff & "</AccOff>" & _
                "<TipCre>" & strTipCre & "</TipCre>" & _
                "<ConAnt>" & strConAnt & "</ConAnt>" & _
                "<Curdes>" & strCurdes & "</Curdes>" & _
                "<Monto>" & strMonto & "</Monto>" & _
                "<MtoAr84>" & strMtoAr84 & "</MtoAr84>" & _
                "<Plazo>" & strPlazo & "</Plazo>" & _
                "<NumOpf>" & strNumOpf & "</NumOpf>" & _
                "<Tasa>" & strTasa & "</Tasa>" & _
                "<Spread>" & strSpread & "</Spread>" & _
                "<OK2>" & strOK2 & "</OK2>" & _
                "<Banco1>" & strBanco1 & "</Banco1>" & _
                "<SubCli>" & strSubCli & "</SubCli>" & _
                "<Banco2>" & strBanco2 & "</Banco2>" & _
                "</Item>"

'"<strIDRegistro>" & strIDRegistro & "</strIDRegistro>"
'"<strCustac>" & strCustac &"</strCustac>"
'"<strOK>" & strOK & "</strOK>"
'"<strCodSuc>" & strCodSuc & "</strCodSuc>"
'"<strAccOff>" & strAccOff & "</strAccOff>"
'"<strTipCre>" & strTipCre & "</strTipCre>"
'"<strConAnt>" & strConAnt & "</strConAnt>"
'"<strCurdes>" & strCurdes & "</strCurdes>"
'"<strMonto>" & strMonto & "</strMonto>"
'"<strMtoAr84>" & strMtoAr84 & "</strMtoAr84>"
'"<strPlazo>" & strPlazo & "</strPlazo>"
'"<strNumOpf>" & strNumOpf & "</strNumOpf>"
'"<strTasa>" & strTasa & "</strTasa>"
'"<strSpread>" & strSpread & "</strSpread>"
'"<strOK2>" & strOK2 & "</strOK2>"
'"<strBanco1>" & strBanco1 & "</strBanco1>"
'"<strSubCli>" & strSubCli & "</strSubCli>"
'"<strBanco2>" & strBanco2 & "</strBanco2>"
'</Item>
'
''''''strMsgXml = ""
''''''strMsgXml_Body = ""
''''''strMsgXml_Body = "<Item><strEntidad>" & strCodEntidad & "</strEntidad>" & _
''''''            "<strCodUsuario>" & strCodUsuario & "</strCodUsuario>" & _
''''''            "<strRutCte>" & strRutCteEmisor & "</strRutCte>" & _
''''''            "<intCodigoCliente>" & strCodCliente & "</intCodigoCliente>" & _
''''''            "<strCodMonedaIBS>" & gblstrCodMonedaIBS & "</strCodMonedaIBS>" & _
''''''            "<dblMontoOperacion>" & gblSW_MontoReserva & "</dblMontoOperacion>" & _
''''''            "<dblMontoMTM>" & gblSW_Valor_MTM & "</dblMontoMTM>" & _
''''''            "<dblMontoGarantizado>" & dblMontoGarantizado & "</dblMontoGarantizado>" & _
''''''            "<intCantDiasPermanencia>" & intCantDiasPermanencia & "</intCantDiasPermanencia>" & _
''''''            "<strNumSolicitudSistema>" & strNumSolicitudSistema & "</strNumSolicitudSistema>" & _
''''''            "<intCodigoDeuda>" & intCodigoDeuda & "</intCodigoDeuda>" & _
''''''            "<intCodigoTransaccion>" & intCodigoTransaccion & "</intCodigoTransaccion>" & _
''''''            "<strCodigoProductoIBS>" & strCodigoProductoIBS & "</strCodigoProductoIBS>" & _
''''''            "<intCodigoPaisSBIF>" & intCodigoPaisSBIF & "</intCodigoPaisSBIF>" & _
''''''            "<strIndicador>" & strIndicador & "</strIndicador>" & _
''''''            "<strSistema>" & strSistemaOrigen & "</strSistema>" & _
''''''            "<intTicket>" & intTicket & "</intTicket>" & _
''''''            "<intPlazo>" & intPlazo & "</intPlazo>" & _
''''''            "<strProducto>" & gblintTipoSwap & "</strProducto></Item>"

' concateno los string para generar XML final
strMsgXml = cSOAP_Margenes_Art84_Header + strMsgXml_Body + cSOAP_Margenes_Art84_End
' GENERO EL ARCHIVO Y ANALISO LA RESPUESTA ENTREGADA POR EL WS
If Not blnOperacionCumpleArt84String(strMsgXml) Then
End If
' Asigno variable global que será ocupada en los formularios
gblnProcesoExitosoXXX = blnRealizaProceso
End Sub
Function blnCumpleMargen(strResp As String) As Boolean
Dim iCnt As Integer
Dim blnResult As Boolean

strMensajeError = ""
If Len(strResp) > 0 Then
        If lCanNodos > 0 Then
        For iCnt = 0 To lCanNodos
            If Len(strArrayRespuestas(iCnt)) > 0 Then
                blnResult = False
                If iCnt = 0 Then
                    strMensajeError = strArrayRespuestas(iCnt)
                Else
                    strMensajeError = strMensajeError & vbNewLine & strArrayRespuestas(iCnt)
                End If
            End If
        Next
    Else
        strMensajeError = "Error al leer XML Respuesta"
    End If
Else
    blnResult = True
End If
blnCumpleMargen = blnResult
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
End Select
End Function
Private Function cuenta(Palabra As String, Letra As String) As Long
Dim Lugar As Long
Dim total As Long
Do While Len(Palabra) > 0
   Lugar = InStr(Palabra, Letra)
   If Lugar = 0 Then Exit Do
   total = total + 1
   Palabra = Mid(Palabra, Lugar + 1)
Loop
cuenta = total
End Function

Private Sub CreaInterfazXML_String(strXML As String, strParametro As String)
Dim parser As DOMDocument
Set parser = New DOMDocument
Dim strLastString As String
' cargar el código SOAP para Art84
parser.loadXML strXML
parser.SelectSingleNode("/soap:Envelope/soap:Body/ConsultaIBSXml/XmlString").text = strParametro
blnConexionExitosa = False
'enviarComando parser.XML, "http://tempuri.org/CapturaMargenGlobal"
enviarComando parser.XML, "IBS/ConsultaIBSXml"

If blnConexionExitosa Then
    strRespuestaProceso = strAlert
End If
End Sub

Private Sub enviarComando(ByVal sXml As String, ByVal sSoapAction As String)
    ' Enviar el comando al servicio Web
    '
    ' usar XMLHTTPRequest para enviar la información al servicio Web
    Dim oHttReq As XMLHTTPRequest
    Set oHttReq = New XMLHTTPRequest
    
    'strURL = "http://localhost:57729/WSArticulo84.asmx"
    
    Dim strMetodoWeb As String
    strMetodoWeb = "WSArticulo84.asmx"
    
    strURL = "http://" & strGetUrlService + strMetodoWeb
    
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
    Dim Doc As New msxml.DOMDocument

    S = strReemplaceInvalidChar(S)

    ' Parseo string a XML
    parser.loadXML S


    ' Obtengo flag que indica si el proceso se realizo correctamente (1=Proceso de comunicación Correcto - 0=Proceso de comunicación con errores)
    strFlagSuccess = parser.SelectSingleNode("/soap:Envelope/soap:Body/ConsultaIBSXmlResponse/ConsultaIBSXmlResult/Header/FLAG").text
    ' si el proceso se efectuo correctamente
   If strFlagSuccess = "1" Then
        
        Call LeeXML(strRespWS)

        blnConexionExitosa = True
        strRespuestaProceso = strAlert
        If err.Number > 0 Then
            blnConexionExitosa = False
        End If
    Else
        
        Call LeeErrores(strRespWS)
        
        strMensajeError = vbNewLine & strSeparador & vbNewLine & "Existen Problemas de comunicación con el proceso de análisis de Márgenes" & _
            vbNewLine & "Detalle Error : " & vbNewLine & strAlert & vbNewLine & strSeparador & vbNewLine & _
            "Favor Intentar nuevamente o Informar a Sistemas"
        
        strMensajeError = vbNewLine & strSeparador & vbNewLine & "Existen Problemas de comunicación con el proceso de análisis de Márgenes" & _
             strMsgNoConecta & vbNewLine & strSeparador & vbNewLine & _
            "Favor Intentar nuevamente o Informar a Sistemas"
        
        blnConexionExitosa = False
        
    End If

    Exit Sub
Err_Procesa:
    blnConexionExitosa = False
    MsgBox err.Description
End Sub
Private Sub BorraFile(strPath As String)
Call Kill(strPath)
End Sub


'*****************************************************************************
' Funcion que obtiene datos del emisor a partir de la serie del documento    *
' obtenido de la base de datos ACCESS que se encuentra en la ubicacion local *
'*****************************************************************************
Function strTraeEmisorSerieByMDB(strSerie As String, Data1 As Data) As String
Dim rs As Recordset
Dim SQL As String
Dim nTotal As Double

strTraeEmisorSerieByMDB = ""
Data1.DatabaseName = gsMDB_Path & gsMDB_Database
Data1.RecordsetType = 1
Data1.RecordSource = "SELECT tm_genemi  FROM mdci WHERE tm_instser = " & Trim(strSerie)
Data1.Recordset.MoveFirst

Do While Not Data1.Recordset.EOF
    If Data1.Recordset(3) <> "" Then
      strTraeEmisorSerieByMDB = Trim(Data1.Recordset("tm_genemi"))
      Exit Function
    End If
Loop
End Function

Private Sub LeeXML(strRuta As String)
Dim xmlDoc As DOMDocument
Dim objNodeList As IXMLDOMNodeList
Dim objNodeWarningList As IXMLDOMNodeList
Dim objNodeCalculoIBSList As IXMLDOMNodeList
Dim objNodeAlertList As IXMLDOMNodeList
Dim objNodeAlertListFooter As IXMLDOMNodeList
Dim objFlagCumplimiento As IXMLDOMNode
Dim objCorrIngresoIBS As IXMLDOMNode
Dim objNombreCliente As IXMLDOMNode
Dim objDetAlerta As IXMLDOMNode
Dim objFlagAlerta As IXMLDOMNode
Dim objCodAlerta As IXMLDOMNode
Dim objNode As IXMLDOMNode
Dim objNodeCalculoIBS As IXMLDOMNode
Dim objNodeAlert As IXMLDOMNode
Dim objNodeCalculos As IXMLDOMNode
Dim objNodeAlertFooter As IXMLDOMNode



' nuevos nodos
Dim objCodeError As IXMLDOMNode
Dim objDescError As IXMLDOMNode
Dim objSourceError As IXMLDOMNode
Dim objMontoOperacion As IXMLDOMNode


Dim XMLurl As String
Dim strRet As String
Dim strDetAterta As String
Dim strDetCalculos As String
Dim strDetAtertaFooter As String
Dim lContador As Long

' variable para contar nodos
lCanNodos = 0
Set xmlDoc = New DOMDocument
XMLurl = strRuta
xmlDoc.async = False
strDetAterta = ""


gstrNrosOperacionesIBSXXX = ""

On Error GoTo Err_LeeXML
' Cargo el XML para su transformación y análisis
'If xmlDoc.Load(XMLurl) = False Then

If xmlDoc.loadXML(XMLurl) = False Then

    MsgBox ("XML LOAD ERROR")
    strAlert = "Error de comunicacion con Broker"
Else
    ' identifico nodos que traen respuestas por items (Data/OutputIBS)
    Set objNodeList = xmlDoc.SelectNodes("//Data/OutputIBS")
    Set objNodeAlertListFooter = xmlDoc.SelectNodes("//Data/OutputIBS/footer/FooterOutputIBS/errors/error")


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
             
               
        If Len(gstrNrosOperacionesIBSXXX) = 0 Then
            gstrNrosOperacionesIBSXXX = objCorrIngresoIBS.text
        Else
            gstrNrosOperacionesIBSXXX = gstrNrosOperacionesIBSXXX & " ; " & objCorrIngresoIBS.text
        End If
        
        ' identifico si el item analizado cumple el margen
         If Trim(objFlagCumplimiento.text) = "N" Then        ' No cumple margen
        ' solo cargo alertas y mensajes cuando la operación no cumpla
        ' con los márgenes asociados al Art84
            ' limpio variable
            strDetAterta = ""
            strDetCalculos = ""
            strDetAtertaFooter = ""
            
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
                            
                            strDetCalculos = objMontoOperacion.text
                        Next
                    End If
                     ' concateno las alertas
                    If strDetAterta = "" Then
                        strDetAterta = objDescError.text & vbNewLine & "Monto Imputado : " & strDetCalculos
                    Else
                        strDetAterta = strDetAterta & vbNewLine & objDescError.text & vbNewLine & "Monto Imputado :" & strDetCalculos
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
                    If strDetAterta = "" Then
                        strDetAterta = objFlagAlerta.text & " " & objCodAlerta.text & " " & objDetAlerta.text
                    Else
                        strDetAterta = strDetAterta & " " & objFlagAlerta.text & " " & objCodAlerta.text & " " & objDetAlerta.text
                    End If
                Next
            End If
            
            
            
                   'Tag Footer
            
            
                
              For Each objNodeAlertFooter In objNodeAlertListFooter
              
                Set objCodAlerta = objNodeAlertFooter.SelectSingleNode("code")
                Set objDetAlerta = objNodeAlertFooter.SelectSingleNode("description")
                 ' concateno las alertas
                If strDetAterta = "" Then
                    strDetAtertaFooter = objCodAlerta.text & " " & objDetAlerta.text
                Else
                    strDetAtertaFooter = objCodAlerta.text & " " & objDetAlerta.text
                End If
              
              
              Next
                
            
            'Fin Tag Footer
            
               
               
          If strDetAterta <> "" Then
            
            strArrayRespuestas(lContador) = vbNewLine & strSeparador & vbNewLine & "Cliente: " & objNombreCliente.text & vbNewLine & "Codigo Operacion: " & objCorrIngresoIBS.text & vbNewLine & _
                "Detalle Alerta : " & strDetAterta
            strRet = objFlagCumplimiento.text & "-" & objCorrIngresoIBS.text & "-" & objNombreCliente.text & " | " & strDetAterta
            
            Else
            
              strArrayRespuestas(lContador) = vbNewLine & strSeparador & vbNewLine & "Cliente: " & gblNombreClienteArt84 & vbNewLine & "Codigo Operacion: " & objCorrIngresoIBS.text & vbNewLine & _
                "Detalle Alerta : " & strDetAtertaFooter
                
                 strRet = objFlagCumplimiento.text & "-" & objCorrIngresoIBS.text & "-" & objNombreCliente.text & " | " & strDetAterta

            End If
               
            
                
         
            If strAlert = "" Then
                strAlert = strRet
            Else
                strAlert = strAlert & " ;" & strRet
            End If
            lContador = lContador + 1
        End If
    Next objNode
End If
Exit Sub
Err_LeeXML:
    MsgBox err.Description, vbCritical, "Problema al Leer XML"
End Sub

Function lngTraeTicketArt84() As Long
Dim Datos()
Dim cSQL As String
Dim lngRespuesta As Long
lngRespuesta = 0

Envia = Array()

If Not Bac_Sql_Execute(gsSQL_Database_comun & "..SP_TICKET_ARTICULO_84", Envia) Then Exit Function
If Bac_SQL_Fetch(Datos()) Then
    lngRespuesta = Datos(1)
End If


lngTraeTicketArt84 = lngRespuesta
End Function

Sub GeneraConfirmacionProcesoXXX(lNroTicket As Long, lNroOperacion As Long, strSistemaOrigen As String, strNrosIBS As String)
Dim strArray() As String
Dim lCuenta As Long
Dim iCont As Integer

lCuenta = cuenta(strNrosIBS, ";")
ReDim strArray(lCuenta)
For iCont = 0 To lCuenta
    If lCuenta = 0 Then
        Call GrabaConfirmacionProceso(lNroTicket, lNroOperacion, strSistemaOrigen, Val(strNrosIBS))
    Else
    Call GrabaConfirmacionProceso(lNroTicket, lNroOperacion, strSistemaOrigen, Val(strArray(iCont)))
    End If
Next
End Sub
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
Dim strglosa As String

' variable para contar nodos
lCanNodos = 0
Dim lContador As Long

Set xmlDoc = New DOMDocument
XMLurl = strRuta
xmlDoc.async = False

strDetAterta = ""
strAlert = ""

On Error GoTo Err_LeeXML
' Cargo el XML para su transformación y análisis

'If xmlDoc.Load(XMLurl) = False Then
    
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
        strglosa = "Detalle error: " & objErrorDesc.text & vbNewLine & _
               "Clase / Metodo : " & objClase.text & " / " & objMetodo.text & vbNewLine & "Linea : " & objLineaError.text
        
        If lContador = 0 Then
            strAlert = strglosa
        Else
            strAlert = strAlert & vbNewLine & strSeparador & vbNewLine & strglosa
        End If
        lContador = lContador + 1
    Next objNode
End If
Exit Sub
Err_LeeXML:
    MsgBox err.Description, vbCritical, "Problema al Leer XML"
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

Function blnProcesoArt84ActivoXXX(strSistemaOrigen As String) As Boolean
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
blnProcesoArt84ActivoXXX = blnResult
End Function
Sub GeneraArchivoAnulacion(lngNumeroOpe As Long, lngRutCliente As Long, lngCodigoCliente As Long)
Dim dblTipoCambio As Double
Dim dblMontoReserva As Double
Dim dblMontoMTM As Double
Dim dblMontoGarantizado As Double
Dim strTipoPayOff As String
Dim dblPesoFijoAsia As Double



'FWD
gstrNrosOperacionesIBSXXX = CStr(dblTraeCorrIbsByOperacion(lngNumeroOpe, "PCS"))


strCodEntidad = "3"                         ' 3=mesa dinero
strCodUsuario = gsBac_User$                 ' Usuario Registrado en sistema
strRutCteEmisor = CStr(lngRutCliente)   ' rut contraparte

gblstrCodMonedaIBS = ""

dblMontoReserva = 0
dblMontoMTM = 0
dblMontoGarantizado = 0                     ' no se utiliza

intCantDiasPermanencia = 1                  ' 1= dura un solo dia
strNumSolicitudSistema = 0                  ' se envia con valor 0
intCodigoDeuda = 5                          ' 5= deuda bonos
intCodigoTransaccion = 4                    ' Anulación


strCodigoProductoIBS = "MD01"                   ' MD01 = Mesa de dinero
intCodigoPaisSBIF = 160                     ' 160 = CHILE
strIndicador = "A"                          ' A=Activo
strCodCliente = CStr(lngCodigoCliente)

dblMontoReserva = 0


intTicketAnulacion = lngTraeTicketArt84()            ' nro ticket unico que sirve para identificar la peticion contra nro de operacion (IBS)
intPlazo = 0


strSistemaOrigen = "PCS"


strTipoPayOff = ""
dblPesoFijoAsia = 0
strCodigoProducto = ""

glngNroTicketAnulacion = intTicketAnulacion

strMsgXml = ""
strMsgXml_Body = ""
strMsgXml_Body = "<Item><strEntidad>" & strCodEntidad & "</strEntidad>" & _
            "<strCodUsuario>" & strCodUsuario & "</strCodUsuario>" & _
            "<strRutCte>" & strRutCteEmisor & "</strRutCte>" & _
             "<intCodigoCliente>" & strCodCliente & "</intCodigoCliente>" & _
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
            "<strProducto>" & strCodigoProducto & "</strProducto></Item>"

' concateno los string para generar XML final
strMsgXml = cSOAP_Margenes_Art84_Header + strMsgXml_Body + cSOAP_Margenes_Art84_End
' GENERO EL ARCHIVO Y ANALISO LA RESPUESTA ENTREGADA POR EL WS
If Not blnOperacionCumpleArt84String(strMsgXml) Then
End If
' Asigno variable global que será ocupada en los formularios
gblnProcesoExitosoXXX = blnRealizaProceso
End Sub

Function dblTraeCorrIbsByOperacion(lNumOperacion As Long, strCodSistema As String) As Double
Dim Datos()
Dim cSQL As String
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

strReemplaceInvalidChar = strTemporal

End Function
Private Sub LimpiarVariablesMensajes()
    strMsgXml = ""
    strAlert = ""
    strRespWS = ""
    strMensajeError = ""
End Sub


