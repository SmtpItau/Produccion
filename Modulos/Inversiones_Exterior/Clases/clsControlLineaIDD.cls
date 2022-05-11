VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsControlLineaIDD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
' VARIABLES
' INI-VAR GLOBALES
Private mvarObjDom As Object
Private mvarObjXmlHttp As Object
Private sSOAP_ConsultaIDD_Header As String
Private sSOAP_ConsultaIDD_Body As String
Private sSOAP_ConsultaIDD_End As String
Private strMsgXml As String

' FIN-VAR GLOBALES

' PROPERTIES
' INI-PROPERTIES
'============================================================
Private mvarURLWebService As String
Private mvarWebMethod As String
Private mvarEstado As String

Private mvarCode As Integer
Private mvarNumeroIDD As Long
Private mvarCodigoRespuesta As Integer
Private mvarDescripcionError  As String
Private mvarDescription  As String
Private mvarNumeroIddAnula As Long

'====== PROPERTIES ENTRADA ==================================
Private mvarInModulo As String
Private mvarInProducto As String
Private mvarInOperacion As Long
Private mvarInDocumento As Long
Private mvarInCorrelativo As Long
'====== PROPERTIES ENTRADA ==================================

'====== PROPERTIES QUE VAN AL WEBSERVICE ====================
Private mvarWsIdRegistro As String        'Fijo = "ID19620798C0120731"
Private mvarWsCodAS400Cliente As Double
Private mvarWsFiller0 As String           'Fijo = "Y"
Private mvarWsCodSucursal As Integer      'Fijo = 11
Private mvarWsCodOficina As String        'Fijo = "MSD"
Private mvarWsFacility As Integer
Private mvarWsFiller1 As String           'Fijo = 000000
Private mvarWsMonedaOperacion As String
Private mvarWsMontoCorporativo As Double
Private mvarWsMontoArticulo84 As Double
Private mvarWsPlazoOperacion As Long
Private mvarWsFiller2 As String
Private mvarWsFiller3 As String             'Fijo = 0000000
Private mvarWsFiller4 As String             'Fijo = 00000
Private mvarWsAccion As String            'Valores posibles "Y"=Aplica;"N"=Consulta;"R"=Reversa Monto
Private mvarWsMonedaOrigen As String
Private mvarWsFiller5 As String           'Fijo = Space(16)
Private mvarWsSubCliente As Long
Private mvarWsFiller6 As String           'Fijo = Space (134)
'====== PROPERTIES QUE VAN AL WEBSERVICE ====================


'URLWebService
Public Property Let URLWebService(ByVal vData As String)
    mvarURLWebService = vData
End Property
Public Property Get URLWebService() As String
    URLWebService = mvarURLWebService
End Property

'WebMethod
Public Property Let WebMethod(ByVal vData As String)
    mvarWebMethod = vData
End Property
Public Property Get WebMethod() As String
    WebMethod = mvarWebMethod
End Property

'Estado
Public Property Let Estado(ByVal vData As String)
    mvarEstado = vData
End Property
Public Property Get Estado() As String
    Estado = mvarEstado
End Property

'CODE
Public Property Let Code(ByVal vData As Integer)
    mvarCode = vData
End Property
Public Property Get Code() As Integer
    Code = mvarCode
End Property

'CodigoRespuesta
Public Property Let CodigoRespuesta(ByVal vData As Long)
    mvarCodigoRespuesta = vData
End Property
Public Property Get CodigoRespuesta() As Long
    CodigoRespuesta = mvarCodigoRespuesta
End Property

'NumeroIDD
Public Property Let NumeroIDD(ByVal vData As Long)
    mvarNumeroIDD = vData
End Property
Public Property Get NumeroIDD() As Long
    NumeroIDD = mvarNumeroIDD
End Property

'DescripcionError
Public Property Let DescripcionError(ByVal vData As String)
    mvarDescripcionError = vData
End Property
Public Property Get DescripcionError() As String
    DescripcionError = mvarDescripcionError
End Property

'Descripcion
Public Property Let Description(ByVal vData As String)
    mvarDescription = vData
End Property
Public Property Get Description() As String
    Description = mvarDescription
End Property

'NumeroIddAnula
Public Property Let NumeroIddAnula(ByVal vData As Long)
    mvarNumeroIddAnula = vData
End Property
Public Property Get NumeroIddAnula() As Long
    NumeroIddAnula = mvarNumeroIddAnula
End Property

'====== PROPERTIES ENTRADA ==================================
'Modulo
Public Property Let Modulo(ByVal vData As String)
     mvarInModulo = vData
End Property
Public Property Get Modulo() As String
    Modulo = mvarInModulo
End Property

'Producto
Public Property Let Producto(ByVal vData As String)
     mvarInProducto = vData
End Property
Public Property Get Producto() As String
    Producto = mvarInProducto
End Property

'Operacion
Public Property Let Operacion(ByVal vData As Long)
     mvarInOperacion = vData
End Property
Public Property Get Operacion() As Long
    Operacion = mvarInOperacion
End Property

'Documento
Public Property Let Documento(ByVal vData As Long)
    mvarInDocumento = vData
End Property
Public Property Get Documento() As Long
    Documento = mvarInDocumento
End Property

'Correlativo
Public Property Let Correlativo(ByVal vData As Long)
    mvarInCorrelativo = vData
End Property
Public Property Get Correlativo() As Long
    Correlativo = mvarInCorrelativo
End Property

'CheckControlLínea
'Public Property Let CheckControlLínea(ByVal vData As Long)
'    mvarCheckControlLínea = vData
'End Property
'Public Property Get CheckControlLínea() As Long
'    CheckControlLínea = mvarCheckControlLínea
'End Property
'====== PROPERTIES ENTRADA ==================================

'====== PROPERTIES QUE VAN AL WEBSERVICE ====================
'IdRegistro
Public Property Let IdRegistro(ByVal vData As String)
    mvarWsIdRegistro = vData
End Property
Public Property Get IdRegistro() As String
    IdRegistro = mvarWsIdRegistro
End Property

'CodAS400Cliente
Public Property Let CodAS400Cliente(ByVal vData As Long)
    mvarWsCodAS400Cliente = vData
End Property
Public Property Get CodAS400Cliente() As Long
    CodAS400Cliente = mvarWsCodAS400Cliente
End Property

'Filler0
Public Property Let Filler0(ByVal vData As String)
    mvarWsFiller0 = vData
End Property
Public Property Get Filler0() As String
    Filler0 = mvarWsFiller0
End Property

'CodSucursal
Public Property Let CodSucursal(ByVal vData As Integer)
    mvarWsCodSucursal = vData
End Property
Public Property Get CodSucursal() As Integer
    CodSucursal = mvarWsCodSucursal
End Property

'CodOficina
Public Property Let CodOficina(ByVal vData As String)
    mvarWsCodOficina = vData
End Property
Public Property Get CodOficina() As String
    CodOficina = mvarWsCodOficina
End Property

'Facility
Public Property Let Facility(ByVal vData As Integer)
    mvarWsFacility = vData
End Property
Public Property Get Facility() As Integer
    Facility = mvarWsFacility
End Property

'Filler1
Public Property Let Filler1(ByVal vData As String)
    mvarWsFiller1 = vData
End Property
Public Property Get Filler1() As String
    Filler1 = mvarWsFiller1
End Property

'MonedaOperacion
Public Property Let MonedaOperacion(ByVal vData As String)
    mvarWsMonedaOperacion = vData
End Property
Public Property Get MonedaOperacion() As String
    MonedaOperacion = mvarWsMonedaOperacion
End Property

'MontoCorporativo
Public Property Let MontoCorporativo(ByVal vData As Double)
    mvarWsMontoCorporativo = vData
End Property
Public Property Get MontoCorporativo() As Double
    MontoCorporativo = mvarWsMontoCorporativo
End Property

'MontoArticulo84
Public Property Let MontoArticulo84(ByVal vData As Double)
    mvarWsMontoArticulo84 = vData
End Property
Public Property Get MontoArticulo84() As Double
    MontoArticulo84 = mvarWsMontoArticulo84
End Property

'PlazoOperacion
Public Property Let PlazoOperacion(ByVal vData As Long)
    mvarWsPlazoOperacion = vData
End Property
Public Property Get PlazoOperacion() As Long
    PlazoOperacion = mvarWsPlazoOperacion
End Property

'Filler2
Public Property Let Filler2(ByVal vData As String)
    mvarWsFiller2 = vData
End Property
Public Property Get Filler2() As String
    Filler2 = mvarWsFiller2
End Property

'Filler3
Public Property Let Filler3(ByVal vData As String)
    mvarWsFiller3 = vData
End Property
Public Property Get Filler3() As String
    Filler3 = mvarWsFiller3
End Property

'Filler4
Public Property Let Filler4(ByVal vData As String)
    mvarWsFiller4 = vData
End Property
Public Property Get Filler4() As String
    Filler4 = mvarWsFiller4
End Property

'Accion
Public Property Let Accion(ByVal vData As String)
    mvarWsAccion = vData
End Property
Public Property Get Accion() As String
    Accion = mvarWsAccion
End Property

'MonedaOrigen
Public Property Let MonedaOrigen(ByVal vData As String)
    mvarWsMonedaOrigen = vData
End Property
Public Property Get MonedaOrigen() As String
    MonedaOrigen = mvarWsMonedaOrigen
End Property

'Filler5
Public Property Let Filler5(ByVal vData As String)
    mvarWsFiller5 = vData
End Property
Public Property Get Filler5() As String
    Filler5 = mvarWsFiller5
End Property

'SubCliente
Public Property Let SubCliente(ByVal vData As Long)
    mvarWsSubCliente = vData
End Property
Public Property Get SubCliente() As Long
    SubCliente = mvarWsSubCliente
End Property

'Filler6
Public Property Let Filler6(ByVal vData As String)
    mvarWsFiller6 = vData
End Property
Public Property Get Filler6() As String
    Filler6 = mvarWsFiller6
End Property
'====== PROPERTIES QUE VAN AL WEBSERVICE ====================
'============================================================
' FIN-PROPERTIES

' Obtiene parametros para generar la URL de conexion
Private Function Fn_Str_GetUrl_WebService() As String
    Dim Datos()
    Dim intCodParam As Integer
    Dim strUrl_WebService As String
    
    'intCodParam = 9924 '9924=  URL WS IDD
    strUrl_WebService = ""
    
    envia = Array(intCodParam)
    If Not Bac_Sql_Execute(gsSQL_Database_comun & "..sp_leetabla", envia) Then
        Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        strUrl_WebService = Trim(Datos(5))
    Loop
    
    Fn_Str_GetUrlService_WebService = strUrl_WebService
End Function

Public Function fn_Codigo_Descripcion_Retorno(ByVal mvarObjDomxml As String, Nodo As String, NodoPath As String) As Variant
    Dim xmlDoc As DOMDocument
    Dim objNode As IXMLDOMNode
    Dim objNodeList As IXMLDOMNodeList
    Dim objNodeError As IXMLDOMNode
       
    Set xmlDoc = New DOMDocument
    xmlDoc.loadXML mvarObjDomxml
    Set objNodeList = xmlDoc.selectNodes(NodoPath)
   
        ' Recorro cada nodo
        For Each objNode In objNodeList
            If objNode.baseName <> "RqUID" And NodoPath <> "//" Then
                Set objNodeError = objNode.selectSingleNode(Nodo)
            Else
                Set objNodeError = objNode.selectSingleNode(NodoPath & Nodo) '//RqUID
                Exit For
            End If
        Next
    
    fn_Codigo_Descripcion_Retorno = objNodeError.Text
End Function

Private Sub LimpiarVariablesMensajes()
    sSOAP_ConsultaIDD_Header = ""
    sSOAP_ConsultaIDD_Body = ""
    sSOAP_ConsultaIDD_End = ""
    strMsgXml = ""
End Sub

'[OK]
Public Sub RecuperaDatosLineaIDD()
On Error GoTo Err_RecuperaDatosLineaIDD
Dim Datos()
    envia = Array()
    AddParam envia, Me.Modulo
    AddParam envia, Me.Producto
    AddParam envia, Me.Operacion
    AddParam envia, Me.Documento
    AddParam envia, Me.Correlativo
    
    If Not Bac_Sql_Execute("BacLineas..SP_TRAE_DATOS_OPERACION_IDD", envia) Then
        Exit Sub
    End If
       
    Do While Bac_SQL_Fetch(Datos())
        Me.IdRegistro = "ID19620798C0120731"    'String     18 FIJO
        Me.CodAS400Cliente = Datos(1)           'Numérico    7 OK
        Me.Filler0 = "Y"                        'String      1 FIJO
        Me.CodSucursal = 11                     'Numérico    2 FIJO
        Me.CodOficina = "MSD"                   'String      3 FIJO
        Me.Facility = Datos(3)                  'Numérico    3 OK
        Me.Filler1 = String(6, "0")             'Numérico    6 FIJO
        '--> 2018.02.13 cvegasan Control de Líneas de Crédito Tesorería - BAC - 171018109
        Me.MonedaOperacion = Datos(7)           'String      4      Conversión moneda a AS400 999->(CHEZ)
        Me.MontoCorporativo = Datos(5)          'Numérico    13,2  Monto Operación
        Me.MontoArticulo84 = 0                  'Numérico    13,2 2018.02.13 Valor que se actualiza después de la búsqueda
        '--< 2018.02.13 cvegasan Control de Líneas de Crédito Tesorería - BAC - 171018109
        Me.PlazoOperacion = Datos(4)            'Numérico    5
        Me.Filler2 = String(7, "0")             'Numérico    7 FIJO
        Me.Filler3 = String(7, "0")             'Numérico    7 FIJO
        Me.Filler4 = String(5, "0")             'Numérico    5 FIJO
        ' ESTA VARIABLE SE ASIGNA EL INICIO
        'Me.Accion = "N"                        'String      1 "Y" = Aplica; "N" = Consulta; "R" = Reversa Monto
        Me.MonedaOrigen = ""                    ' String      4 [PENDIENTE]
        Me.Filler5 = String(16, " ")            ' String     16 FIJO
        Me.SubCliente = Datos(2)                ' Numérico    7
        Me.Filler6 = String(134, " ")           ' String    134 FIJO
        Me.NumeroIddAnula = Datos(8)            ' En caso de anulación toma el número IDD para ejecucion del SERVICIO
    Loop
       
Err_RecuperaDatosLineaIDD:
    If err.Number <> 0 Then
        MsgBox "Error en procedimiento RecuperaDatosLineaIDD: " & err.Number & " - " & err.Description, vbOKOnly + vbExclamation
    End If
End Sub

Public Sub EjecutaProcesoWsLineaIDD()
    On Error GoTo Err_PWs
    Dim Datos()
    Dim strRetXML As String
    Dim errorEjecucion As String
    
    Call LimpiarVariablesMensajes
'+++fmo 20180911 por monto no mayor a numeric(11)
    Call modificar_montos_usd
'---fmo 20180911 por monto no mayor a numeric(11)
    
    'Genero HEADER del XML
    sSOAP_ConsultaIDD_Header = _
    "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ns='http://itau.cl/xmlns/BankPortfolioAndTreasury/CorporateTreasury/Tesoreria/1'>" & _
    "<soapenv:Header/>" & _
    "<soapenv:Body>" & _
        "<ns:ControlLineaCreditoTesoreriaRq xmlns:ns='http://itau.cl/xmlns/BankPortfolioAndTreasury/CorporateTreasury/Tesoreria/1'>" & _
            "<MsgRqHdr>" & _
                "<AsyncRqUID>1</AsyncRqUID>" & _
                                "<ContextRqHdr>" & _
                                                "<ChnlId>11</ChnlId>" & "<ChnlDesc>1</ChnlDesc>" & _
                                                "<AppId>1</AppId>" & "<Browser>1</Browser>" & _
                                                "<ClientIp>1</ClientIp>" & "<LangCode>1</LangCode>" & _
                                                "<TimeStamp>1</TimeStamp>" & "<Token>1</Token>" & _
                                                "<MobileKey>1</MobileKey>" & _
                                                "<DevInfo>" & "<DevName>1</DevName>" & "</DevInfo>" & _
                                                "<MsgAuthCode>" & "<ClientTerminalSeqNum>1</ClientTerminalSeqNum>" & "<MacValue>1</MacValue>" & "</MsgAuthCode>" & _
                                                "<NetworkTrnData>" & "<OriginatorType>1</OriginatorType>" & "</NetworkTrnData>" & _
                                                "<PartyRef>" & _
                                                    "<PartyKeys>" & _
                                                        "<LoginIdent>" & _
                                                            "<LoginName>ITAINTER</LoginName>" & _
                                                        "</LoginIdent>" & _
                                                    "</PartyKeys>" & _
                                                "</PartyRef>" & _
                                "</ContextRqHdr>" & _
            "</MsgRqHdr>"
    
    'Genero BODY del XML
    '2017.10.18 Se elimina de Exchrate y se agrega al final OfferInfo con el facility
     sSOAP_ConsultaIDD_Body = _
                    "<PartyRec> <PartyId>" & Me.CodAS400Cliente & "</PartyId> </PartyRec>" & _
                    "<FIData><BranchName>" & Me.CodOficina & "</BranchName>" & _
                    "<BranchIdent>" & Me.CodSucursal & "</BranchIdent></FIData>" & _
                    "<AcctTrnInfo>" & _
                        "<TotalCurAmt><Amt>" & Str(Me.MontoCorporativo) & "</Amt></TotalCurAmt>" & _
                        "<CurA84Amt><Amt>" & Str(Me.MontoArticulo84) & "</Amt></CurA84Amt>" & _
                            "<ExchangeRate>" & _
                                "<BaseCurCode><CurCodeValue>" & Me.MonedaOperacion & "</CurCodeValue></BaseCurCode>" & _
                                "<ContraCurCode><CurCodeValue>" & Me.MonedaOrigen & "</CurCodeValue></ContraCurCode>" & _
                            "</ExchangeRate>" & _
                    "</AcctTrnInfo>" & _
                    "<EffTimeFrame><Duration><Count>" & Me.PlazoOperacion & "</Count></Duration></EffTimeFrame>" & _
                    "<RecSelect>" & Me.Accion & "</RecSelect>" & _
                    "<ForExDealRec><ForExDealId>" & Me.SubCliente & "</ForExDealId></ForExDealRec>" & _
                    "<OfferInfo><PricingPlanIdent>" & Me.Facility & "</PricingPlanIdent></OfferInfo>"
    
    'Genero PIE del XML
    sSOAP_ConsultaIDD_End = _
         "</ns:ControlLineaCreditoTesoreriaRq>" & _
       "</soapenv:Body>" & _
    "</soapenv:Envelope>"

    ' XML final que va al WS
    strMsgXml = sSOAP_ConsultaIDD_Header + sSOAP_ConsultaIDD_Body + sSOAP_ConsultaIDD_End
    Set mvarObjDom = CreateObject("MSXML2.DOMDocument")
    Set mvarObjXmlHttp = CreateObject("MSXML2.XMLHTTP")
   
    'Obtengo parámetros de URL y Nombre WS desde el Archivo INI
    Me.URLWebService = gsBac_Url_WebService
    Me.WebMethod = gsBac_Url_WebMethod
    'Cargar Xml
    mvarObjDom.async = False
    mvarObjDom.loadXML strMsgXml

    'Proceso Apertura de WS
    mvarObjXmlHttp.Open "POST", Me.URLWebService, False
    
    'Creando cabecera Mensaje y acción del mismo
    mvarObjXmlHttp.setRequestHeader "Content-Type", "text/xml; charset=utf-8"
    mvarObjXmlHttp.setRequestHeader "SOAPAction", Me.WebMethod ' "IBS/ConsultaIBSXml"
    
    'Envío del XML al WS formateado (REQUEST)
    mvarObjXmlHttp.send mvarObjDom.XML
    
    'Retorno del XML WS (RESPONSE)
    strRetXML = mvarObjXmlHttp.responseText
    
    'Cierro conexión y objeto
    Set mvarObjXmlHttp = Nothing
    
    '--> [RETORNO WS] Obtengo el campo (CODE) del XML
    'Retorno el estado del consumo 0 = OK ejecución servicio, <> 0 'ERROR' con XPATH
    Me.Code = fn_Codigo_Descripcion_Retorno(strRetXML, "StatusCode", "//MsgRsHdr/Status")
    If Me.Code = 0 Then ' Code = 0 hubo retorno de WS
        'Obtengo CodigoRespuesta
        Me.CodigoRespuesta = fn_Codigo_Descripcion_Retorno(strRetXML, "StatusCode", "//MsgRsHdr/Status/AdditionalStatus")
        Select Case Me.CodigoRespuesta
            Case 200: 'Exitosa con reserva de linea O = OK
                    Me.NumeroIDD = fn_Codigo_Descripcion_Retorno(strRetXML, "RqUID", "//")
                    Me.DescripcionError = ""
            Case 201: 'Exitosa con error en validación R=Rechazado
                    Me.NumeroIDD = 0
                    Me.DescripcionError = fn_Codigo_Descripcion_Retorno(strRetXML, "StatusDesc", "//MsgRsHdr/Status/AdditionalStatus")
        End Select
        
        'Actualizo datos de retorno del WS en la Tabla Transacciones_IDD
        envia = Array()
        AddParam envia, Me.CodigoRespuesta   ' 200 estado='O' de lo contrario 'R'
        AddParam envia, Me.Modulo            ' BTR
        AddParam envia, Me.Producto          ' CP
        AddParam envia, Me.Operacion         ' 199266
        AddParam envia, Me.Documento         ' 199266
        AddParam envia, Me.Correlativo       ' 1
        AddParam envia, Me.DescripcionError  ' En caso de que sea 201 se graba error IDD, de lo contrario ""
        AddParam envia, Me.NumeroIDD         ' En caso Ok Actualiza Numero IDD, de lo contrario "0"
        AddParam envia, MarcaAplicaLinea     ' 1='N' 0='S' [Variable Global]
        If Not Bac_Sql_Execute("BacLineas..SP_ACTUALIZA_DATOS_OPERACION_IDD", envia) Then
            MsgBox "No actualizo datos en proceso control IDD", vbInformation
            Exit Sub
        End If
        If Bac_SQL_Fetch(Datos()) Then
            errorEjecucion = CDbl(Datos(1))
            If errorEjecucion = -1 Then
                MsgBox errorEjecucion, vbInformation
            End If
        End If
        
    Else ' Code = -1 u otro valor ERROR de conexión WS
        Me.Description = fn_Codigo_Descripcion_Retorno(strRetXML, "StatusDesc", "//MsgRsHdr/Status/AdditionalStatus")
        MsgBox "Error en invocación de Servicio Broker LineaIDD: " & Me.Description, vbOKOnly + vbExclamation
    End If
    '--< [RETORNO WS] Obtengo el campo (CODE) del XML
Exit Sub

Err_PWs:
    MsgBox "Error en procedimiento EjecutaProcesoWsLineaIDD: " & err.Number & " - " & err.Description, vbOKOnly + vbExclamation
End Sub
'+++fmo 20180911 por monto no mayor a numeric(11)
Sub modificar_montos_usd()
    On Error GoTo Err_modif
    
    Me.MontoCorporativo = Format((Me.MontoCorporativo / gsBac_DolarObs), "0.0#")
    Me.MontoArticulo84 = Format((Me.MontoArticulo84 / gsBac_DolarObs), "0.0#")
    Me.MonedaOperacion = "US.D"
    Me.MonedaOrigen = ""
Exit Sub

Err_modif:
    MsgBox "Error en procedimiento modificar montos a USD: " & err.Number & " - " & err.Description, vbOKOnly + vbExclamation
End Sub
'---fmo 20180911 por monto no mayor a numeric(11)

