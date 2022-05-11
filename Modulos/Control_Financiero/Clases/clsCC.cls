VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCC"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'variables locales para almacenar los valores de las propiedades
Private mvarId_tipo_cliente As Long
Private mvarforma_pago_entregamos As Long
Private mvarforma_pago_recibimos As Long
Private mvarcodigo_cliente As Long
Private mvarrut_cliente As Long
Private mvartc_forward As String
Private mvarprecio_forward As String
Private mvarpuntos_fwd As String
Private mvartc_spot As String
Private mvarmonto_conversion As String
Private mvarmonto_origen As String
Private mvarmonto_compensacion As Double
Private mvarmodalidad As Double
Private mvarmoneda_compensacion As Long
Private mvarid_tc_referencia As Integer
Private mvarfecha_fixing As String
Private mvarfecha_termino As String
Private mvarfecha_inicio As String
Private mvarfecha_cierre As String
Private mvarmoneda_conversion As Integer
Private mvarmoneda_origen As Integer
Private mvartipo_operacion As String
Private mvarid_producto As String
Private mvarID_Sistema As String
Private mvarNumero_Operacion As Long

Private mvarNumero_Operacion_KONDOR As Long

Private mvarId_broker As String
Private mvarId_Indice_Referencia As String

Private mvarstrEstado As String
Private mvarstrMensaje As String

Private mvarwsURL As String
Private mvarwsACTION As String

Private mvarCodigoProducto As String
Private mvarCodigoProductoEquivalente As String
Private mvarNumeroOperacion As Long
Private mvarTipoOperacion As String
Private mvarIndicadorAccion As String
Private mvarFechaOperacion As String
Private mvarEjecutivo As String
Private mvarMoneda As String

Private mvarRut As String
Private mvarDigitoVerificador As String

Private mvarSucursalRut As Integer
Private mvarMontoOperacion As Double
Private mvarFormaPago As String
Private mvarCodigoValuta As String
Private mvarNombreCliente As String
Private mvarBanco As String
Private mvarCuentaCorrienteBeneficiarioVendedor As String
Private mvarClaveAbif As String
Private mvarCuentaCorrienteComprador As String
Private mvarCodigoDcvComprador As String
Private mvarCuentaCorrienteVendedor As String
Private mvarCodigoDcvVendedor As String
Private mvarMontoOriginal As Double
Private mvarFechaInicio As String
Private mvarTasaInteres As Double
Private mvarMontoInteres As Double
Private mvarMontoVencimiento As Double
Private mvarFechaVencimiento As String
Private mvarTipoReajustabilidad As String
Private mvarTasaPacto As Double
Private mvarMontoFinal As Double
Private mvarMontoNominal As Double
Private mvarTasaDescuento As Double
Private mvarValorTasaDescuento As Double
Private mvarCustodia As String
Private mvarNumeroInstrumentos As Integer
Private mvarMontoTotalTransado As Double
Private mvarCodigoMndaFx As String
Private mvarMontoFX As Double
Private mvarTasaCambio As Double
Private mvarFechaValorMx As String
Private mvarFormaPagoNegocio As String
Private mvarIndicadorSesion As String

Private mvarCodigoPais  As String
Private mvarCodigoBancoReceptor  As String
Private mvarCodigoSucursal  As String
Private mvarCodigoCuentaCorriente  As String
Private mvarIdCliente  As String
Private mvarIdBeneficiario  As String

Private mvarNombreClienteBeneficiario_3 As String
Private mvarNombreClienteBeneficiario_4 As String
Private mvarUsuarioMDP As String
Private mvarUsuarioIngreso As String
Private mvarCargoCtaCte As String
Private mvarSobregiroCtaCte As String
'--> 2021.09.27 cvegasan nGine Campos codigo sistema
Private mvarCodigoSistema As String
'--< 2021.07.27 cvegasan nGine Campos  codigo sistema
'--> 2021.07.01 cvegasan nGine Campos nuevos en la definición del WS
Private mvarPvpReferencia As String
Private mvarPvpMoneda As String
Private mvarPvpTasaCambio As Double
Private mvarPvpMonto As Double
Private mvarBancoIntermediario As String
Private mvarCuentaIntermediario As String
Private mvarPaisIntermediario As String

Private mvarCodigoCanal As Long
Private mvarCodigoAplicacion As String
Private mvarNombreAplicacion As String
'--< 2021.07.01 cvegasan nGine Campos nuevos en la definición del WS

Private mvarNemonicoTipoInstrumento As String
Private mvarValorNominal As Double
Private mvarTir As Double
Private mvarValorCompra As Double
Private mvarClaveOperacion As String
Private mvarCorrelativoRegistro As Double

Private mvarMDPEstado As Integer
Private mvarMDPMensaje As String

Public Property Let Estado(ByVal vData As String)
    mvarstrEstado = vData
End Property

Public Property Get Estado() As String
    Estado = mvarstrEstado
End Property
Public Property Let Mensaje(ByVal vData As String)
    mvarstrMensaje = vData
End Property
Public Property Get Mensaje() As String
    Mensaje = mvarstrMensaje
End Property
Public Property Let wsACTION(ByVal vData As String)
    mvarwsACTION = vData
End Property
Public Property Get wsACTION() As String
    wsACTION = mvarwsACTION
End Property
Public Property Let wsURL(ByVal vData As String)
    mvarwsURL = vData
End Property
Public Property Get wsURL() As String
    wsURL = mvarwsURL
End Property
Public Property Let Id_Indice_Referencia(ByVal vData As String)
    mvarId_Indice_Referencia = vData
End Property
Public Property Get Id_Indice_Referencia() As String
    Id_Indice_Referencia = mvarId_Indice_Referencia
End Property
Public Property Let Id_broker(ByVal vData As String)
    mvarId_broker = vData
End Property
Public Property Get Id_broker() As String
    Id_broker = mvarId_broker
End Property
Public Property Let Numero_Operacion(ByVal vData As Long)
    mvarNumero_Operacion = vData
End Property
Public Property Get Numero_Operacion() As Long
    Numero_Operacion = mvarNumero_Operacion
End Property

Public Property Let Numero_Operacion_KONDOR(ByVal vDataKONDOR As Long)
    mvarNumero_Operacion_KONDOR = vDataKONDOR
End Property
Public Property Get Numero_Operacion_KONDOR() As Long
    Numero_Operacion_KONDOR = mvarNumero_Operacion_KONDOR
End Property

Public Property Let Id_sistema(ByVal vData As String)
    mvarID_Sistema = vData
End Property
Public Property Get Id_sistema() As String
    Id_sistema = mvarID_Sistema
End Property
Public Property Let id_producto(ByVal vData As String)
    mvarid_producto = vData
End Property
Public Property Get id_producto() As String
    id_producto = mvarid_producto
End Property
Public Property Let Tipo_Operacion(ByVal vData As String)
    mvartipo_operacion = vData
End Property
Public Property Get Tipo_Operacion() As String
    Tipo_Operacion = mvartipo_operacion
End Property
Public Property Let moneda_origen(ByVal vData As Integer)
    mvarmoneda_origen = vData
End Property
Public Property Get moneda_origen() As Integer
    moneda_origen = mvarmoneda_origen
End Property
Public Property Let moneda_conversion(ByVal vData As Integer)
    mvarmoneda_conversion = vData
End Property
Public Property Get moneda_conversion() As Integer
    moneda_conversion = mvarmoneda_conversion
End Property
Public Property Let fecha_cierre(ByVal vData As String)
    mvarfecha_cierre = vData
End Property
Public Property Get fecha_cierre() As String
    fecha_cierre = mvarfecha_cierre
End Property
Public Property Let Fecha_Inicio(ByVal vData As String)
    mvarfecha_inicio = vData
End Property
Public Property Get Fecha_Inicio() As String
    Fecha_Inicio = mvarfecha_inicio
End Property
Public Property Let fecha_termino(ByVal vData As String)
    mvarfecha_termino = vData
End Property
Public Property Get fecha_termino() As String
    fecha_termino = mvarfecha_termino
End Property
Public Property Let Fecha_fixing(ByVal vData As String)
    mvarfecha_fixing = vData
End Property
Public Property Get Fecha_fixing() As String
    Fecha_fixing = mvarfecha_fixing
End Property
Public Property Let id_tc_referencia(ByVal vData As Integer)
    mvarid_tc_referencia = vData
End Property
Public Property Get id_tc_referencia() As Integer
    id_tc_referencia = mvarid_tc_referencia
End Property
Public Property Let moneda_compensacion(ByVal vData As Long)
    mvarmoneda_compensacion = vData
End Property
Public Property Get moneda_compensacion() As Long
    moneda_compensacion = mvarmoneda_compensacion
End Property
Public Property Let Modalidad(ByVal vData As Double)
    mvarmodalidad = vData
End Property
Public Property Get Modalidad() As Double
    Modalidad = mvarmodalidad
End Property
Public Property Let monto_compensacion(ByVal vData As Double)
    mvarmonto_compensacion = vData
End Property
Public Property Get monto_compensacion() As Double
    monto_compensacion = mvarmonto_compensacion
End Property
Public Property Let Monto_Origen(ByVal vData As String)
    mvarmonto_origen = vData
End Property
Public Property Get Monto_Origen() As String
    Monto_Origen = mvarmonto_origen
End Property
Public Property Let monto_conversion(ByVal vData As String)
    mvarmonto_conversion = vData
End Property
Public Property Get monto_conversion() As String
    monto_conversion = mvarmonto_conversion
End Property
Public Property Let tc_spot(ByVal vData As String)
    mvartc_spot = vData
End Property
Public Property Get tc_spot() As String
    tc_spot = mvartc_spot
End Property
Public Property Let Puntos_fwd(ByVal vData As String)
    mvarpuntos_fwd = vData
End Property
Public Property Get Puntos_fwd() As String
    Puntos_fwd = mvarpuntos_fwd
End Property
Public Property Let precio_forward(ByVal vData As String)
    mvarprecio_forward = vData
End Property
Public Property Get precio_forward() As String
    precio_forward = mvarprecio_forward
End Property
Public Property Let tc_forward(ByVal vData As String)
    mvartc_forward = vData
End Property
Public Property Get tc_forward() As String
    tc_forward = mvartc_forward
End Property
Public Property Let RUT_CLIENTE(ByVal vData As Long)
    mvarrut_cliente = vData
End Property
Public Property Get RUT_CLIENTE() As Long
    RUT_CLIENTE = mvarrut_cliente
End Property
Public Property Let CODIGO_CLIENTE(ByVal vData As Long)
    mvarcodigo_cliente = vData
End Property
Public Property Get CODIGO_CLIENTE() As Long
    CODIGO_CLIENTE = mvarcodigo_cliente
End Property
Public Property Let forma_pago_recibimos(ByVal vData As Long)
    mvarforma_pago_recibimos = vData
End Property
Public Property Get forma_pago_recibimos() As Long
    forma_pago_recibimos = mvarforma_pago_recibimos
End Property
Public Property Let forma_pago_entregamos(ByVal vData As Long)
    mvarforma_pago_entregamos = vData
End Property
Public Property Get forma_pago_entregamos() As Long
    forma_pago_entregamos = mvarforma_pago_entregamos
End Property
Public Property Let id_tipo_cliente(ByVal vData As Long)
    mvarId_tipo_cliente = vData
End Property
Public Property Get id_tipo_cliente() As Long
    id_tipo_cliente = mvarId_tipo_cliente
End Property
Public Property Let NumeroOperacion(ByVal vData As Long)
    mvarNumeroOperacion = vData
End Property

Public Property Get NumeroOperacion() As Long
    NumeroOperacion = mvarNumeroOperacion
End Property
Public Property Let CodigoProducto(ByVal vData As String)
    mvarCodigoProducto = vData
End Property

Public Property Get CodigoProductoEquivalente() As String
    CodigoProductoEquivalente = mvarCodigoProductoEquivalente
End Property

Public Property Let CodigoProductoEquivalente(ByVal vData As String)
    mvarCodigoProductoEquivalente = vData
End Property

Public Property Get CodigoProducto() As String
    CodigoProducto = mvarCodigoProducto
End Property
Public Property Let TipoOperacion(ByVal vData As String)
    mvarTipoOperacion = vData
End Property

Public Property Get TipoOperacion() As String
    TipoOperacion = mvarTipoOperacion
End Property
Public Property Let IndicadorAccion(ByVal vData As String)
    mvarIndicadorAccion = vData
End Property
Public Property Get IndicadorAccion() As String
    IndicadorAccion = mvarIndicadorAccion
End Property
Public Property Let FechaOperacion(ByVal vData As String)
    mvarFechaOperacion = vData
End Property
Public Property Get FechaOperacion() As String
    FechaOperacion = mvarFechaOperacion
End Property
Public Property Let Ejecutivo(ByVal vData As String)
    mvarEjecutivo = vData
End Property
Public Property Get Ejecutivo() As String
    Ejecutivo = mvarEjecutivo
End Property
Public Property Let Moneda(ByVal vData As String)
    mvarMoneda = vData
End Property
Public Property Get Moneda() As String
    Moneda = mvarMoneda
End Property
Public Property Let DigitoVerificador(ByVal vData As String)
    mvarDigitoVerificador = vData
End Property
Public Property Get DigitoVerificador() As String
    DigitoVerificador = mvarDigitoVerificador
End Property
Public Property Let SucursalRut(ByVal vData As Integer)
    mvarSucursalRut = vData
End Property
Public Property Get SucursalRut() As Integer
    SucursalRut = mvarSucursalRut
End Property
Public Property Let MontoOperacion(ByVal vData As Double)
    mvarMontoOperacion = vData
End Property
Public Property Get MontoOperacion() As Double
    MontoOperacion = mvarMontoOperacion
End Property
Public Property Let FormaPago(ByVal vData As String)
    mvarFormaPago = vData
End Property
Public Property Get FormaPago() As String
    FormaPago = mvarFormaPago
End Property
Public Property Let CodigoValuta(ByVal vData As String)
    mvarCodigoValuta = vData
End Property
Public Property Get CodigoValuta() As String
    CodigoValuta = mvarCodigoValuta
End Property
Public Property Let NombreCliente(ByVal vData As String)
    mvarNombreCliente = vData
End Property
Public Property Get NombreCliente() As String
    NombreCliente = mvarNombreCliente
End Property
Public Property Let Banco(ByVal vData As String)
    mvarBanco = vData
End Property
Public Property Get Banco() As String
    Banco = mvarBanco
End Property
Public Property Let CuentaCorrienteBeneficiarioVendedor(ByVal vData As String)
    mvarCuentaCorrienteBeneficiarioVendedor = vData
End Property
Public Property Get CuentaCorrienteBeneficiarioVendedor() As String
    CuentaCorrienteBeneficiarioVendedor = mvarCuentaCorrienteBeneficiarioVendedor
End Property
Public Property Let ClaveAbif(ByVal vData As String)
    mvarClaveAbif = vData
End Property
Public Property Get ClaveAbif() As String
    ClaveAbif = mvarClaveAbif
End Property
Public Property Let CuentaCorrienteComprador(ByVal vData As String)
    mvarCuentaCorrienteComprador = vData
End Property
Public Property Get CuentaCorrienteComprador() As String
    CuentaCorrienteComprador = mvarCuentaCorrienteComprador
End Property
Public Property Let CodigoDcvComprador(ByVal vData As String)
    mvarCodigoDcvComprador = vData
End Property
Public Property Get CodigoDcvComprador() As String
    CodigoDcvComprador = mvarCodigoDcvComprador
End Property
Public Property Let CuentaCorrienteVendedor(ByVal vData As String)
    mvarCuentaCorrienteVendedor = vData
End Property
Public Property Get CuentaCorrienteVendedor() As String
    CuentaCorrienteVendedor = mvarCuentaCorrienteVendedor
End Property
Public Property Let CodigoDcvVendedor(ByVal vData As String)
    mvarCodigoDcvVendedor = vData
End Property
Public Property Get CodigoDcvVendedor() As String
    CodigoDcvVendedor = mvarCodigoDcvVendedor
End Property
Public Property Let MontoOriginal(ByVal vData As Double)
    mvarMontoOriginal = vData
End Property
Public Property Get MontoOriginal() As Double
    MontoOriginal = mvarMontoOriginal
End Property
Public Property Let FechaInicio(ByVal vData As String)
    mvarFechaInicio = vData
End Property
Public Property Get FechaInicio() As String
    FechaInicio = mvarFechaInicio
End Property
Public Property Let TasaInteres(ByVal vData As Double)
    mvarTasaInteres = vData
End Property
Public Property Get TasaInteres() As Double
    TasaInteres = mvarTasaInteres
End Property
Public Property Let MontoInteres(ByVal vData As Double)
    mvarMontoInteres = vData
End Property
Public Property Get MontoInteres() As Double
    MontoInteres = mvarMontoInteres
End Property
Public Property Let MontoVencimiento(ByVal vData As Double)
    mvarMontoVencimiento = vData
End Property
Public Property Get MontoVencimiento() As Double
    MontoVencimiento = mvarMontoVencimiento
End Property
Public Property Let FechaVencimiento(ByVal vData As String)
    mvarFechaVencimiento = vData
End Property
Public Property Get FechaVencimiento() As String
    FechaVencimiento = mvarFechaVencimiento
End Property
Public Property Let TipoReajustabilidad(ByVal vData As String)
    mvarTipoReajustabilidad = vData
End Property
Public Property Get TipoReajustabilidad() As String
    TipoReajustabilidad = mvarTipoReajustabilidad
End Property
Public Property Let TasaPacto(ByVal vData As Double)
    mvarTasaPacto = vData
End Property
Public Property Get TasaPacto() As Double
    TasaPacto = mvarTasaPacto
End Property
Public Property Let MontoFinal(ByVal vData As Double)
    mvarMontoFinal = vData
End Property
Public Property Get MontoFinal() As Double
    MontoFinal = mvarMontoFinal
End Property
Public Property Let MontoNominal(ByVal vData As Double)
    mvarMontoNominal = vData
End Property
Public Property Get MontoNominal() As Double
    MontoNominal = mvarMontoNominal
End Property
Public Property Let TasaDescuento(ByVal vData As Double)
    mvarTasaDescuento = vData
End Property
Public Property Get TasaDescuento() As Double
    TasaDescuento = mvarTasaDescuento
End Property
Public Property Let ValorTasaDescuento(ByVal vData As Double)
    mvarValorTasaDescuento = vData
End Property
Public Property Get ValorTasaDescuento() As Double
    ValorTasaDescuento = mvarValorTasaDescuento
End Property
Public Property Let Custodia(ByVal vData As String)
    mvarCustodia = vData
End Property
Public Property Get Custodia() As String
    Custodia = mvarCustodia
End Property
Public Property Let NumeroInstrumentos(ByVal vData As Integer)
    mvarNumeroInstrumentos = vData
End Property
Public Property Get NumeroInstrumentos() As Integer
    NumeroInstrumentos = mvarNumeroInstrumentos
End Property
Public Property Let MontoTotalTransado(ByVal vData As Double)
    mvarMontoTotalTransado = vData
End Property
Public Property Get MontoTotalTransado() As Double
    MontoTotalTransado = mvarMontoTotalTransado
End Property
Public Property Let CodigoMndaFx(ByVal vData As String)
    mvarCodigoMndaFx = vData
End Property
Public Property Get CodigoMndaFx() As String
    CodigoMndaFx = mvarCodigoMndaFx
End Property
Public Property Let MontoFX(ByVal vData As Double)
    mvarMontoFX = vData
End Property
Public Property Get MontoFX() As Double
    MontoFX = mvarMontoFX
End Property
Public Property Let TasaCambio(ByVal vData As Double)
    mvarTasaCambio = vData
End Property
Public Property Get TasaCambio() As Double
    TasaCambio = mvarTasaCambio
End Property
Public Property Let FechaValorMx(ByVal vData As String)
    mvarFechaValorMx = vData
End Property
Public Property Get FechaValorMx() As String
    FechaValorMx = mvarFechaValorMx
End Property
Public Property Let FormaPagoNegocio(ByVal vData As String)
    mvarFormaPagoNegocio = vData
End Property
Public Property Get FormaPagoNegocio() As String
    FormaPagoNegocio = mvarFormaPagoNegocio
End Property
Public Property Let IndicadorSesion(ByVal vData As String)
    mvarIndicadorSesion = vData
End Property
Public Property Get IndicadorSesion() As String
    IndicadorSesion = mvarIndicadorSesion
End Property
Public Property Let NombreClienteBeneficiario_3(ByVal vData As String)
    mvarNombreClienteBeneficiario_3 = vData
End Property
Public Property Get NombreClienteBeneficiario_3() As String
    NombreClienteBeneficiario_3 = mvarNombreClienteBeneficiario_3
End Property
Public Property Let NombreClienteBeneficiario_4(ByVal vData As String)
    mvarNombreClienteBeneficiario_4 = vData
End Property
Public Property Get NombreClienteBeneficiario_4() As String
    NombreClienteBeneficiario_4 = mvarNombreClienteBeneficiario_4
End Property
Public Property Let UsuarioMDP(ByVal vData As String)
    mvarUsuarioMDP = vData
End Property
Public Property Get UsuarioMDP() As String
    UsuarioMDP = mvarUsuarioMDP
End Property
Public Property Let UsuarioIngreso(ByVal vData As String)
    mvarUsuarioIngreso = vData
End Property
Public Property Get UsuarioIngreso() As String
    UsuarioIngreso = mvarUsuarioIngreso
End Property
Public Property Let CargoCtaCte(ByVal vData As String)
    mvarCargoCtaCte = vData
End Property
Public Property Get CargoCtaCte() As String
    CargoCtaCte = mvarCargoCtaCte
End Property
Public Property Let SobregiroCtaCte(ByVal vData As String)
    mvarSobregiroCtaCte = vData
End Property
Public Property Get SobregiroCtaCte() As String
    SobregiroCtaCte = mvarSobregiroCtaCte
End Property
Public Property Let Rut(ByVal vData As String)
    mvarRut = vData
End Property

Public Property Get Rut() As String
    Rut = mvarRut
End Property
Public Property Let CodigoPais(ByVal vData As String)
    mvarCodigoPais = vData
End Property
Public Property Get CodigoPais() As String
    CodigoPais = mvarCodigoPais
End Property
Public Property Let CodigoBancoReceptor(ByVal vData As String)
    mvarCodigoBancoReceptor = vData
End Property
Public Property Get CodigoBancoReceptor() As String
    CodigoBancoReceptor = mvarCodigoBancoReceptor
End Property
Public Property Let CodigoSucursal(ByVal vData As String)
    mvarCodigoSucursal = vData
End Property
Public Property Get CodigoSucursal() As String
    CodigoSucursal = mvarCodigoSucursal
End Property
Public Property Let CodigoCuentaCorriente(ByVal vData As String)
    mvarCodigoCuentaCorriente = vData
End Property
Public Property Get CodigoCuentaCorriente() As String
    CodigoCuentaCorriente = mvarCodigoCuentaCorriente
End Property
Public Property Let IdCliente(ByVal vData As String)
    mvarIdCliente = vData
End Property
Public Property Get IdCliente() As String
    IdCliente = mvarIdCliente
End Property
Public Property Let IdBeneficiario(ByVal vData As String)
    mvarIdBeneficiario = vData
End Property
Public Property Get IdBeneficiario() As String
    IdBeneficiario = mvarIdBeneficiario
End Property
Public Property Let NemonicoTipoInstrumento(ByVal vData As String)
    mvarNemonicoTipoInstrumento = vData
End Property
Public Property Get NemonicoTipoInstrumento() As String
    NemonicoTipoInstrumento = mvarNemonicoTipoInstrumento
End Property
Public Property Let ValorNominal(ByVal vData As Double)
    mvarValorNominal = vData
End Property
Public Property Get ValorNominal() As Double
    ValorNominal = mvarValorNominal
End Property
Public Property Let Tir(ByVal vData As Double)
    mvarTir = vData
End Property
Public Property Get Tir() As Double
    Tir = mvarTir
End Property
Public Property Let ValorCompra(ByVal vData As Double)
    mvarValorCompra = vData
End Property
Public Property Get ValorCompra() As Double
    ValorCompra = mvarValorCompra
End Property
Public Property Let ClaveOperacion(ByVal vData As String)
    mvarClaveOperacion = vData
End Property
Public Property Get ClaveOperacion() As String
    ClaveOperacion = mvarClaveOperacion
End Property
Public Property Let CorrelativoRegistro(ByVal vData As Double)
    mvarCorrelativoRegistro = vData
End Property
Public Property Get CorrelativoRegistro() As Double
    CorrelativoRegistro = mvarCorrelativoRegistro
End Property
Public Property Let MDPEstado(ByVal vData As Integer)
    mvarMDPEstado = vData
End Property

Public Property Get MDPEstado() As Integer
    MDPEstado = mvarMDPEstado
End Property
Public Property Let MDPMensaje(ByVal vData As String)
    mvarMDPMensaje = vData
End Property

Public Property Get MDPMensaje() As String
    MDPMensaje = mvarMDPMensaje
End Property

'--> 2021.07.01 Campos nuevos en la definición del WS
Public Property Let PvpReferencia(ByVal vData As String)
    mvarPvpReferencia = vData
End Property
Public Property Get PvpReferencia() As String
    PvpReferencia = mvarPvpReferencia
End Property

Public Property Let PvpMoneda(ByVal vData As String)
    mvarPvpMoneda = vData
End Property
Public Property Get PvpMoneda() As String
    PvpMoneda = mvarPvpMoneda
End Property

Public Property Let PvpTasaCambio(ByVal vData As Double)
    mvarPvpTasaCambio = vData
End Property
Public Property Get PvpTasaCambio() As Double
    PvpTasaCambio = mvarPvpTasaCambio
End Property

Public Property Let PvpMonto(ByVal vData As Double)
    mvarPvpMonto = vData
End Property
Public Property Get PvpMonto() As Double
    PvpMonto = mvarPvpMonto
End Property

Public Property Let BancoIntermediario(ByVal vData As String)
    mvarBancoIntermediario = vData
End Property
Public Property Get BancoIntermediario() As String
    BancoIntermediario = mvarBancoIntermediario
End Property

Public Property Let CuentaIntermediario(ByVal vData As String)
    mvarCuentaIntermediario = vData
End Property
Public Property Get CuentaIntermediario() As String
    CuentaIntermediario = mvarCuentaIntermediario
End Property

Public Property Let PaisIntermediario(ByVal vData As String)
    mvarPaisIntermediario = vData
End Property
Public Property Get PaisIntermediario() As String
    PaisIntermediario = mvarPaisIntermediario
End Property

Public Property Let CodigoCanal(ByVal vData As String)
    mvarCodigoCanal = vData
End Property
Public Property Get CodigoCanal() As String
    CodigoCanal = mvarCodigoCanal
End Property

Public Property Let CodigoAplicacion(ByVal vData As String)
    mvarCodigoAplicacion = vData
End Property
Public Property Get CodigoAplicacion() As String
    CodigoAplicacion = mvarCodigoAplicacion
End Property

Public Property Let NombreAplicacion(ByVal vData As String)
    mvarNombreAplicacion = vData
End Property
Public Property Get NombreAplicacion() As String
    NombreAplicacion = mvarNombreAplicacion
End Property
'--< 2021.07.01 Campos nuevos en la definición del WS
'--> 2021.09.27 cvegasan nGine Campos codigo sistema
Public Property Let CodigoSistema(ByVal vData As String)
    mvarCodigoSistema = vData
End Property

Public Property Get CodigoSistema() As String
    CodigoSistema = mvarCodigoSistema
End Property
'--< 2021.09.27 cvegasan nGine Campos codigo sistema

Public Function buscarXML(ByVal tag As String, ByVal xml As String) As String
    Dim tag1, tag2
    tag1 = "<" & UCase(tag) & ">"
    tag2 = "</" & UCase(tag) & ">"
    iPosI = InStr(UCase(xml), tag1) + Len(tag1)
    iPosF = InStr(UCase(xml), tag2)
    If iPosI = 0 Or iPosF = 0 Then
        buscarXML = "N/A"
    Else
        buscarXML = Mid(xml, iPosI, iPosF - iPosI)
    End If
End Function

Private Function ParsearRequest_CC_ANULACIONPAGOCRG() As String
Dim StrBody As String

    StrBody = "<?xml version=""1.0"" encoding=""utf-8""?>" & vbCrLf
    StrBody = "<soapenv:Envelope xmlns:soapenv=""http://schemas.xmlsoap.org/soap/envelope/"" xmlns:ns=""http://itau.cl/xmlns/Payments/PaymentsExecution/PaymentsExecution/CancelPaymentNGINE/1"">" & vbCrLf
    StrBody = StrBody & "<soapenv:Header/>" & vbCrLf
    StrBody = StrBody & "<soapenv:Body>" & vbCrLf
    StrBody = StrBody & "<ns:CancelPaymentNGINERq>" & vbCrLf
    StrBody = StrBody & "<MsgRqHdr>" & vbCrLf
        StrBody = StrBody & "<ContextRqHdr>" & vbCrLf
            StrBody = StrBody & "<CodigoCanal>" & Me.CodigoCanal & "</CodigoCanal>" & vbCrLf
            StrBody = StrBody & "<CodigoAplicacion>" & Me.CodigoAplicacion & "</CodigoAplicacion>" & vbCrLf
            StrBody = StrBody & "<NombreAplicacion>" & Me.NombreAplicacion & "</NombreAplicacion>" & vbCrLf
         StrBody = StrBody & "</ContextRqHdr>" & vbCrLf
    StrBody = StrBody & "</MsgRqHdr>" & vbCrLf
    StrBody = StrBody & "<AcctRec>" & vbCrLf
        StrBody = StrBody & "<AcctInfo>" & vbCrLf
            StrBody = StrBody & "<AcctIdent>" & vbCrLf
                StrBody = StrBody & "<CodigoProducto>" & CStr(Me.CodigoProducto) & "</CodigoProducto>" & vbCrLf
            StrBody = StrBody & "</AcctIdent>" & vbCrLf
        StrBody = StrBody & "</AcctInfo>" & vbCrLf
        StrBody = StrBody & "<AcctEnvr>" & vbCrLf
            StrBody = StrBody & "<PartyKeys>" & vbCrLf
                StrBody = StrBody & "<LoginIdent>" & vbCrLf
                    StrBody = StrBody & "<NumeroOperacion>" & CStr(Me.NumeroOperacion) & "</NumeroOperacion>" & vbCrLf
                StrBody = StrBody & "</LoginIdent>" & vbCrLf
            StrBody = StrBody & "</PartyKeys>" & vbCrLf
        StrBody = StrBody & "</AcctEnvr>" & vbCrLf
        StrBody = StrBody & "<SvcIdent>" & vbCrLf
            StrBody = StrBody & "<UsuarioIngreso>" & CStr(Me.UsuarioIngreso) & "</UsuarioIngreso>" & vbCrLf
        StrBody = StrBody & "</SvcIdent>" & vbCrLf
    StrBody = StrBody & "</AcctRec>" & vbCrLf
            StrBody = StrBody & "</ns:CancelPaymentNGINERq>" & vbCrLf
        StrBody = StrBody & "</soapenv:Body>" & vbCrLf
    StrBody = StrBody & "</soapenv:Envelope>" & vbCrLf

    '--> Reemplaza tags XML por la equivalencia del Broker de ITAU
    StrBody = Replace(StrBody, "CodigoCanal", "ChnlId", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CodigoAplicacion", "AppId", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "NombreAplicacion", "AppName", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CodigoProducto", "AcctIdentType", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "NumeroOperacion", "LoginAuthority", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "UsuarioIngreso", "SvcName", 1, 2, vbTextCompare)
    '--< Reemplaza tags XML por la equivalencia del Broker de ITAU

ParsearRequest_CC_ANULACIONPAGOCRG = StrBody

End Function

Private Function ParsearRequest_CC_INGRESARPAGODOCUMENTO() As String
Dim StrBody As String
    StrBody = "<?xml version=""1.0"" encoding=""utf-8""?>" & vbCrLf
    StrBody = "<soapenv:Envelope xmlns:soapenv=""http://schemas.xmlsoap.org/soap/envelope/"" xmlns:ns=""http://itau.cl/xmlns/Payments/PaymentsExecution/PaymentsExecution/setPaymentDocumentNgine/1"">" & vbCrLf
    StrBody = StrBody & "<soapenv:Header/>" & vbCrLf
    StrBody = StrBody & "<soapenv:Body>" & vbCrLf
    StrBody = StrBody & "<ns:setPaymentDocumentNgineRq>" & vbCrLf
    StrBody = StrBody & "<MsgRqHdr>" & vbCrLf
        StrBody = StrBody & "<ContextRqHdr>" & vbCrLf
            StrBody = StrBody & "<CodigoCanal>" & Me.CodigoCanal & "</CodigoCanal>" & vbCrLf
            StrBody = StrBody & "<CodigoAplicacion>" & Me.CodigoAplicacion & "</CodigoAplicacion>" & vbCrLf
            StrBody = StrBody & "<NombreAplicacion>" & Me.NombreAplicacion & "</NombreAplicacion>" & vbCrLf
        StrBody = StrBody & "</ContextRqHdr>" & vbCrLf
    StrBody = StrBody & "</MsgRqHdr>" & vbCrLf
    StrBody = StrBody & "<AcctRec>" & vbCrLf
        StrBody = StrBody & "<CodigoProducto>" & CStr(Me.CodigoProducto) & "</CodigoProducto>" & vbCrLf
         StrBody = StrBody & "<AcctInfo>" & vbCrLf
                StrBody = StrBody & "<NemonicoTipoInstrumento>" & CStr(Me.NemonicoTipoInstrumento) & "</NemonicoTipoInstrumento>" & vbCrLf
                StrBody = StrBody & "<CurCode>" & vbCrLf
                    StrBody = StrBody & "<ValorNominal>" & Replace(CStr(Me.ValorNominal), ",", ".") & "</ValorNominal>" & vbCrLf
                StrBody = StrBody & "</CurCode>" & vbCrLf
                StrBody = StrBody & "<AcctPeriodData>" & vbCrLf
                    StrBody = StrBody & "<ValorCompra>" & Replace(CStr(Me.ValorCompra), ",", ".") & "</ValorCompra>" & vbCrLf
                    StrBody = StrBody & "<Tir>" & Replace(CStr(Me.Tir), ",", ".") & "</Tir>" & vbCrLf
                StrBody = StrBody & "</AcctPeriodData>" & vbCrLf
                StrBody = StrBody & "<AcctType>" & vbCrLf
                   StrBody = StrBody & "<ClaveOperacion>" & CStr(Me.ClaveOperacion) & "</ClaveOperacion>" & vbCrLf
                StrBody = StrBody & "</AcctType>" & vbCrLf
                StrBody = StrBody & "<OrigInitialAmount>" & vbCrLf
                    StrBody = StrBody & "<NumeroOperacion>" & CStr(Me.NumeroOperacion) & "</NumeroOperacion>" & vbCrLf
                    StrBody = StrBody & "<CorrelativoRegistro>" & CStr(Me.CorrelativoRegistro) & "</CorrelativoRegistro>" & vbCrLf
                StrBody = StrBody & "</OrigInitialAmount>" & vbCrLf
             StrBody = StrBody & "</AcctInfo>" & vbCrLf
         StrBody = StrBody & "</AcctRec>" & vbCrLf
      StrBody = StrBody & "</ns:setPaymentDocumentNgineRq>" & vbCrLf
   StrBody = StrBody & "</soapenv:Body>" & vbCrLf
StrBody = StrBody & "</soapenv:Envelope>" & vbCrLf

    '--> Reemplaza tags XML por la equivalencia del Broker de ITAU
    StrBody = Replace(StrBody, "CodigoCanal", "ChnlId", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CodigoAplicacion", "AppId", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "NombreAplicacion", "AppName", 1, 2, vbTextCompare)

    StrBody = Replace(StrBody, "CodigoProducto", "AcctId", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "NumeroOperacion", "Amt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "NemonicoTipoInstrumento", "Desc", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "ValorNominal", "CurCodeValue", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "Tir", "Count", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "ValorCompra", "AcctPeriodType", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "ClaveOperacion", "AcctTypeValue", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CorrelativoRegistro", "USDAmt", 1, 2, vbTextCompare)
    '--< Reemplaza tags XML por la equivalencia del Broker de ITAU
ParsearRequest_CC_INGRESARPAGODOCUMENTO = StrBody
End Function

Private Function ParsearRequest_CC_INGRESARPAGOMESACRG() As String
Dim StrBody As String

StrBody = "<soapenv:Envelope xmlns:soapenv=""http://schemas.xmlsoap.org/soap/envelope/"" xmlns:ns=""http://itau.cl/xmlns/Payments/PaymentsExecution/PaymentsExecution/PaymentTrxTradersCrg/1"">" & vbCrLf
    StrBody = StrBody & "<soapenv:Header/>" & vbCrLf
    StrBody = StrBody & "<soapenv:Body>" & vbCrLf
        StrBody = StrBody & "<ns:PaymentTrxTradersCrgRq>" & vbCrLf
            StrBody = StrBody & "<MsgRqHdr>" & vbCrLf
                StrBody = StrBody & "<ContextRqHdr>" & vbCrLf
                    StrBody = StrBody & "<CodigoCanal>" & Me.CodigoCanal & "</CodigoCanal>" & vbCrLf
                    StrBody = StrBody & "<CodigoAplicacion>" & Me.CodigoAplicacion & "</CodigoAplicacion>" & vbCrLf
                    StrBody = StrBody & "<NombreAplicacion>" & Me.NombreAplicacion & "</NombreAplicacion>" & vbCrLf
                StrBody = StrBody & "</ContextRqHdr>" & vbCrLf
            StrBody = StrBody & "</MsgRqHdr>" & vbCrLf
            StrBody = StrBody & "<AcctInfo>" & vbCrLf
                StrBody = StrBody & "<FechaOperacion>" & CStr(Me.FechaOperacion) & "</FechaOperacion>" & vbCrLf
                StrBody = StrBody & "<CreditAcctData>" & vbCrLf
                    StrBody = StrBody & "<FechaValorMx>" & CStr(Me.FechaValorMx) & "</FechaValorMx>" & vbCrLf
                StrBody = StrBody & "</CreditAcctData>" & vbCrLf
                StrBody = StrBody & "<AcctIdent>" & vbCrLf
                    StrBody = StrBody & "<TipoOperacion>" & CStr(Me.TipoOperacion) & "</TipoOperacion>" & vbCrLf
                    StrBody = StrBody & "<NumeroOperacion>" & CStr(Me.NumeroOperacion) & "</NumeroOperacion>" & vbCrLf
                    StrBody = StrBody & "<IndicadorAccion>" & CStr(Me.IndicadorAccion) & "</IndicadorAccion>" & vbCrLf
                StrBody = StrBody & "</AcctIdent>" & vbCrLf
                StrBody = StrBody & "<AcctPeriodData>" & vbCrLf
                    StrBody = StrBody & "<Moneda>" & CStr(Me.Moneda) & "</Moneda>" & vbCrLf
                    StrBody = StrBody & "<MontoOperacion>" & Replace(CStr(Me.MontoOperacion), ",", ".") & "</MontoOperacion>" & vbCrLf
                StrBody = StrBody & "</AcctPeriodData>" & vbCrLf
                '--> 2021.08.04 INI cvegasan mostrar código de moneda
                'StrBody = StrBody & "<CodigoProducto>" & CStr(Me.CodigoProducto) & "</CodigoProducto>" & vbCrLf
                StrBody = StrBody & "<CodigoProducto>" & CStr(Me.CodigoProductoEquivalente) & "</CodigoProducto>" & vbCrLf
                '--< 2021.08.04 FIN cvegasan mostrar código de moneda
                StrBody = StrBody & "<FechaInicio>" & CStr(Me.FechaInicio) & "</FechaInicio>" & vbCrLf
                StrBody = StrBody & "<AcctPeriodDataMX>" & vbCrLf
                    StrBody = StrBody & "<MontoTotalTransado>" & Replace(CStr(Me.MontoTotalTransado), ",", ".") & "</MontoTotalTransado>" & vbCrLf
                StrBody = StrBody & "</AcctPeriodDataMX>" & vbCrLf
                StrBody = StrBody & "<NumeroInstrumentos>" & CStr(Me.NumeroInstrumentos) & "</NumeroInstrumentos>" & vbCrLf
                StrBody = StrBody & "<IndicadorSesion>" & CStr(Me.IndicadorSesion) & "</IndicadorSesion>" & vbCrLf
            StrBody = StrBody & "</AcctInfo>" & vbCrLf
            StrBody = StrBody & "<AcctRec>" & vbCrLf
                StrBody = StrBody & "<CuentaCorrienteBeneficiarioVendedor>" & CStr(Me.CuentaCorrienteBeneficiarioVendedor) & "</CuentaCorrienteBeneficiarioVendedor>" & vbCrLf
                StrBody = StrBody & "<AcctInfo>" & vbCrLf
                    StrBody = StrBody & "<UsuarioIngreso>" & CStr(Me.UsuarioIngreso) & "</UsuarioIngreso>" & vbCrLf
                    StrBody = StrBody & "<FIData>" & vbCrLf
                        StrBody = StrBody & "<SobregiroCtaCte>" & CStr(Me.SobregiroCtaCte) & "</SobregiroCtaCte>" & vbCrLf
                        StrBody = StrBody & "<MontoFX>" & Replace(CStr(Me.MontoFX), ",", ".") & "</MontoFX>" & vbCrLf
                    StrBody = StrBody & "</FIData>" & vbCrLf
                    StrBody = StrBody & "<AcctBal>" & vbCrLf
                        StrBody = StrBody & "<CurAmt>" & vbCrLf
                            StrBody = StrBody & "<MontoNominal>" & Replace(CStr(Me.MontoNominal), ",", ".") & "</MontoNominal>" & vbCrLf
                            StrBody = StrBody & "<MontoVencimiento>" & Replace(CStr(Me.MontoVencimiento), ",", ".") & "</MontoVencimiento>" & vbCrLf
                        StrBody = StrBody & "</CurAmt>" & vbCrLf
                    StrBody = StrBody & "</AcctBal>" & vbCrLf
                    StrBody = StrBody & "<CurCode>" & vbCrLf
                        StrBody = StrBody & "<PvpMonto>" & CStr(Me.PvpMonto) & "</PvpMonto>" & vbCrLf
                    StrBody = StrBody & "</CurCode>" & vbCrLf
                    StrBody = StrBody & "<AcctIdent>" & vbCrLf
                        StrBody = StrBody & "<Banco>" & CStr(Me.Banco) & "</Banco>" & vbCrLf
                    StrBody = StrBody & "</AcctIdent>" & vbCrLf
                    StrBody = StrBody & "<AcctPeriodData>" & vbCrLf
                        StrBody = StrBody & "<TasaPacto>" & Replace(CStr(Me.TasaPacto), ",", ".") & "</TasaPacto>" & vbCrLf
                        StrBody = StrBody & "<TasaInteres>" & Replace(CStr(Me.TasaInteres), ",", ".") & "</TasaInteres>" & vbCrLf
                    StrBody = StrBody & "</AcctPeriodData>" & vbCrLf
                    StrBody = StrBody & "<AcctType>" & vbCrLf
                        StrBody = StrBody & "<FormaPago>" & CStr(Me.FormaPago) & "</FormaPago>" & vbCrLf
                    StrBody = StrBody & "</AcctType>" & vbCrLf
                    StrBody = StrBody & "<OrigInitialAmount>" & vbCrLf
                        StrBody = StrBody & "<MontoFinal>" & Replace(CStr(Me.MontoFinal), ",", ".") & "</MontoFinal>" & vbCrLf
                        StrBody = StrBody & "<ValorTasaDescuento>" & Replace(CStr(Me.ValorTasaDescuento), ",", ".") & "</ValorTasaDescuento>" & vbCrLf
                    StrBody = StrBody & "</OrigInitialAmount>" & vbCrLf
                    StrBody = StrBody & "<CargoCtaCte>" & CStr(Me.CargoCtaCte) & "</CargoCtaCte>" & vbCrLf
                    StrBody = StrBody & "<UsuarioMDP>" & CStr(Me.UsuarioMDP) & "</UsuarioMDP>" & vbCrLf
                    StrBody = StrBody & "<FechaVencimiento>" & CStr(Me.FechaVencimiento) & "</FechaVencimiento>" & vbCrLf
                    StrBody = StrBody & "<PaymentAmont>" & vbCrLf
                        StrBody = StrBody & "<MontoInteres>" & Replace(CStr(Me.MontoInteres), ",", ".") & "</MontoInteres>" & vbCrLf
                    StrBody = StrBody & "</PaymentAmont>" & vbCrLf
                    StrBody = StrBody & "<MXPaymentAmont>" & vbCrLf
                        StrBody = StrBody & "<MontoOriginal>" & Replace(CStr(Me.MontoOriginal), ",", ".") & "</MontoOriginal>" & vbCrLf
                        'Tipo cambio
                        StrBody = StrBody & "<PvpTasaCambio>" & CStr(Me.PvpTasaCambio) & "</PvpTasaCambio>" & vbCrLf
                    StrBody = StrBody & "</MXPaymentAmont>" & vbCrLf
                    StrBody = StrBody & "<TasaCambio>" & Replace(CStr(Me.TasaCambio), ",", ".") & "</TasaCambio>" & vbCrLf
                    StrBody = StrBody & "<FormaPagoNegocio>" & CStr(Me.FormaPagoNegocio) & "</FormaPagoNegocio>" & vbCrLf
                    StrBody = StrBody & "<CodigoDcvVendedor>" & CStr(Me.CodigoDcvVendedor) & "</CodigoDcvVendedor>" & vbCrLf
                    StrBody = StrBody & "<Custodia>" & CStr(Me.Custodia) & "</Custodia>" & vbCrLf
                    StrBody = StrBody & "<PvpMoneda>" & CStr(Me.PvpMoneda) & "</PvpMoneda>" & vbCrLf
                StrBody = StrBody & "</AcctInfo>" & vbCrLf
                StrBody = StrBody & "<rutCliente>" & CStr(Me.Rut) & "-" & CStr(Me.DigitoVerificador) & "</rutCliente>" & vbCrLf
                StrBody = StrBody & "<AcctStatus>" & vbCrLf
                    StrBody = StrBody & "<TipoReajustabilidad>" & CStr(Me.TipoReajustabilidad) & "</TipoReajustabilidad>" & vbCrLf
                    'TRN PVP
                    StrBody = StrBody & "<PvpReferencia>" & CStr(Me.PvpReferencia) & "</PvpReferencia>" & vbCrLf
                StrBody = StrBody & "</AcctStatus>" & vbCrLf
                StrBody = StrBody & "<AcctEnvr>" & vbCrLf
                    StrBody = StrBody & "<CuentaCorrienteComprador>" & CStr(Me.CuentaCorrienteComprador) & "</CuentaCorrienteComprador>" & vbCrLf
                    StrBody = StrBody & "<CuentaCorrienteVendedor>" & CStr(Me.CuentaCorrienteVendedor) & "</CuentaCorrienteVendedor>" & vbCrLf
                    StrBody = StrBody & "<NombreCliente>" & CStr(Me.NombreCliente) & "</NombreCliente>" & vbCrLf
                    StrBody = StrBody & "<PartyKeys>" & vbCrLf
                        StrBody = StrBody & "<LoginIdent>" & vbCrLf
                            StrBody = StrBody & "<SucursalRut>" & CStr(Me.SucursalRut) & "</SucursalRut>" & vbCrLf
                        StrBody = StrBody & "</LoginIdent>" & vbCrLf
                    StrBody = StrBody & "</PartyKeys>" & vbCrLf
                    StrBody = StrBody & "<CodigoDcvComprador>" & CStr(Me.CodigoDcvComprador) & "</CodigoDcvComprador>" & vbCrLf
                StrBody = StrBody & "</AcctEnvr>" & vbCrLf
                StrBody = StrBody & "<CollateralData>" & vbCrLf
                    StrBody = StrBody & "<TasaDescuento>" & CStr(Me.TasaDescuento) & "</TasaDescuento>" & vbCrLf
                StrBody = StrBody & "</CollateralData>" & vbCrLf
                StrBody = StrBody & "<SvcIdent>" & vbCrLf
                    StrBody = StrBody & "<NombreClienteBeneficiario_3>" & CStr(Me.NombreClienteBeneficiario_3) & "</NombreClienteBeneficiario_3>" & vbCrLf
                    StrBody = StrBody & "<NombreClienteBeneficiario_4>" & CStr(Me.NombreClienteBeneficiario_4) & "</NombreClienteBeneficiario_4>" & vbCrLf
                StrBody = StrBody & "</SvcIdent>" & vbCrLf
            StrBody = StrBody & "</AcctRec>" & vbCrLf
            StrBody = StrBody & "<PartySel>" & vbCrLf
                StrBody = StrBody & "<ClaveAbif>" & CStr(Me.ClaveAbif) & "</ClaveAbif>" & vbCrLf
                StrBody = StrBody & "<CodigoValuta>" & CStr(Me.CodigoValuta) & "</CodigoValuta>" & vbCrLf
                StrBody = StrBody & "<CodigoMndaFx>" & CStr(Me.CodigoMndaFx) & "</CodigoMndaFx>" & vbCrLf
                StrBody = StrBody & "<Ejecutivo>" & CStr(Me.Ejecutivo) & "</Ejecutivo>" & vbCrLf
            StrBody = StrBody & "</PartySel>" & vbCrLf
        StrBody = StrBody & "</ns:PaymentTrxTradersCrgRq>" & vbCrLf
    StrBody = StrBody & "</soapenv:Body>" & vbCrLf
StrBody = StrBody & "</soapenv:Envelope>" & vbCrLf


    '--> Reemplaza tags XML por la equivalencia del Broker de ITAU
    StrBody = Replace(StrBody, "CodigoCanal", "ChnlId", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CodigoAplicacion", "AppId", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "NombreAplicacion", "AppName", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CodigoProducto", "ProductIdent", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "NumeroOperacion", "AcctIdentValue", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "TipoOperacion", "AcctIdentType", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "IndicadorAccion", "AcctType", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "FechaOperacion", "OpenDt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "Ejecutivo", "FullName", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "Moneda", "AcctAmtType", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "RutCliente", "TerminalIdent", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "SucursalRut", "LoginAuthority", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "MontoOperacion", "Amt", 1, , vbTextCompare)
    StrBody = Replace(StrBody, "FormaPago", "AcctTypeValue", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CodigoValuta", "IssuedIdentValue", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "NombreCliente", "LoginName", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "Banco", "AcctIdentValue", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CuentaCorrienteBeneficiarioVendedor", "AcctId", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "ClaveAbif", "PersonIndicator", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CuentaCorrienteComprador", "CreateRefIdent", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CodigoDcvComprador", "ServerTerminalSeqNum", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CuentaCorrienteVendedor", "LastUpdateRqUID", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CodigoDcvVendedor", "UPIC", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "MontoOriginal", "Amt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "FechaInicio", "FfDt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "TasaInteres", "Count", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "MontoInteres", "USDAmt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "MontoVencimiento", "USDAmt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "FechaVencimiento", "FfDt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "TipoReajustabilidad", "StatusDesc", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "TasaPacto", "AcctPeriodType", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "MontoFinal", "Amt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "MontoNominal", "Amt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "ValorTasaDescuento", "USDAmt", 1, 2, vbBinaryCompare)
    StrBody = Replace(StrBody, "TasaDescuento", "CollateralInd", 1, 2, vbBinaryCompare)
    StrBody = Replace(StrBody, "Custodia", "CLABE", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "NumeroInstrumentos", "DaysCall", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "MontoTotalTransado", "Amt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CodigoMndaFx", "IssuedIdentType", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "MontoFX", "AgentBranchName", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "PvpTasaCambio", "USDAmt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "TasaCambio", "RemainingPmtCount", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "FechaValorMx", "DueDt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "FormaPagoNegocio", "IBAN", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "IndicadorSesion", "AcctApplIdent", 1, , vbTextCompare)
    StrBody = Replace(StrBody, "NombreClienteBeneficiario_3", "SvcProviderName", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "NombreClienteBeneficiario_4", "SvcName", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "UsuarioIngreso", "Desc", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "UsuarioMDP", "InsAval", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CargoCtaCte", "InsInd", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "SobregiroCtaCte", "FIIdent", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "PvpReferencia", "AcctStatusCode", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "PvpMoneda", "AcctUse", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "PvpMonto", "CurCodeValue", 1, 2, vbTextCompare)
    '--< Reemplaza tags XML por la equivalencia del Broker de ITAU

ParsearRequest_CC_INGRESARPAGOMESACRG = StrBody
End Function

Private Function ParsearRequest_CC_INGRESARPAGOMESAPICRG() As String
Dim StrBody As String
    StrBody = "<soapenv:Envelope xmlns:soapenv=""http://schemas.xmlsoap.org/soap/envelope/"" xmlns:ns=""http://itau.cl/xmlns/Payments/PaymentExecution/PaymentExecution/PaymentTrxTradersPiCrg/1"">" & vbCrLf
    StrBody = StrBody & "<soapenv:Header/>" & vbCrLf
    StrBody = StrBody & "<soapenv:Body>" & vbCrLf
        StrBody = StrBody & "<ns:PaymentTrxTradersPiCrgRq>" & vbCrLf
            StrBody = StrBody & "<MsgRqHdr>" & vbCrLf
                StrBody = StrBody & "<ContextRqHdr>" & vbCrLf
                    StrBody = StrBody & "<CodigoCanal>" & Me.CodigoCanal & "</CodigoCanal>" & vbCrLf
                    StrBody = StrBody & "<CodigoAplicacion>" & Me.CodigoAplicacion & "</CodigoAplicacion>" & vbCrLf
                    StrBody = StrBody & "<NombreAplicacion>" & Me.NombreAplicacion & "</NombreAplicacion>" & vbCrLf
                StrBody = StrBody & "</ContextRqHdr>" & vbCrLf
         StrBody = StrBody & "</MsgRqHdr>" & vbCrLf
         StrBody = StrBody & "<AcctInfo>" & vbCrLf
                StrBody = StrBody & "<FechaOperacion>" & CStr(Me.FechaOperacion) & "</FechaOperacion>" & vbCrLf
                StrBody = StrBody & "<FIData>" & vbCrLf
                    StrBody = StrBody & "<Ejecutivo>" & CStr(Me.Ejecutivo) & "</Ejecutivo>" & vbCrLf
                StrBody = StrBody & "</FIData>" & vbCrLf
                StrBody = StrBody & "<AcctIdent>" & vbCrLf
                    StrBody = StrBody & "<TipoOperacion>" & CStr(Me.TipoOperacion) & "</TipoOperacion>" & vbCrLf
                    StrBody = StrBody & "<NumeroOperacion>" & CStr(Me.NumeroOperacion) & "</NumeroOperacion>" & vbCrLf
                    StrBody = StrBody & "<IndicadorAccion>" & CStr(Me.IndicadorAccion) & "</IndicadorAccion>" & vbCrLf
                StrBody = StrBody & "</AcctIdent>" & vbCrLf
                StrBody = StrBody & "<InitialAmount>" & vbCrLf
                        StrBody = StrBody & "<CurCode>" & vbCrLf
                            StrBody = StrBody & "<Moneda>" & CStr(Me.Moneda) & "</Moneda>" & vbCrLf
                        StrBody = StrBody & "</CurCode>" & vbCrLf
                StrBody = StrBody & "</InitialAmount>" & vbCrLf
                '--> 2021.08.04 INI cvegasan mostrar código de moneda
                'StrBody = StrBody & "<CodigoProducto>" & CStr(Me.CodigoProducto) & "</CodigoProducto>" & vbCrLf
                 StrBody = StrBody & "<CodigoProducto>" & CStr(Me.CodigoProductoEquivalente) & "</CodigoProducto>" & vbCrLf
                '--< 2021.08.04 FINI cvegasan mostrar código de moneda
         StrBody = StrBody & "</AcctInfo>" & vbCrLf
         StrBody = StrBody & "<PartySel>" & vbCrLf
                StrBody = StrBody & "<PartyKeys>" & vbCrLf
                    StrBody = StrBody & "<IdCliente>" & CStr(Me.IdCliente) & "</IdCliente>" & vbCrLf
                    StrBody = StrBody & "<IdBeneficiario>" & CStr(Me.IdBeneficiario) & "</IdBeneficiario>" & vbCrLf
                StrBody = StrBody & "</PartyKeys>" & vbCrLf
                 ' <!--Faltaba incorporar BancoIntermediario-->
                StrBody = StrBody & "<BancoIntermediario>" & CStr(Me.BancoIntermediario) & "</BancoIntermediario>" & vbCrLf
                StrBody = StrBody & "<RutCliente>" & CStr(Me.Rut) & "-" & CStr(Me.DigitoVerificador) & "</RutCliente>" & vbCrLf
                 '<!--Faltaba CuentaIntermediario-->
                StrBody = StrBody & "<CuentaIntermediario>" & CStr(Me.CuentaIntermediario) & "</CuentaIntermediario>" & vbCrLf
                StrBody = StrBody & "<NombreCliente>" & CStr(Me.NombreCliente) & "</NombreCliente>" & vbCrLf
                 '<!--Faltaba incorporar PaisIntermediario-->
                StrBody = StrBody & "<PaisIntermediario>" & CStr(Me.PaisIntermediario) & "</PaisIntermediario>" & vbCrLf
                StrBody = StrBody & "<NombreClienteBeneficiario_3>" & CStr(Me.NombreClienteBeneficiario_3) & "</NombreClienteBeneficiario_3>" & vbCrLf
                StrBody = StrBody & "<NombreClienteBeneficiario_4>" & CStr(Me.NombreClienteBeneficiario_4) & "</NombreClienteBeneficiario_4>" & vbCrLf
         StrBody = StrBody & "</PartySel>" & vbCrLf
         StrBody = StrBody & "<AcctRef>" & vbCrLf
            StrBody = StrBody & "<AcctRec>" & vbCrLf
                StrBody = StrBody & "<CuentaCorrienteBeneficiarioVendedor>" & CStr(Me.CuentaCorrienteBeneficiarioVendedor) & "</CuentaCorrienteBeneficiarioVendedor>" & vbCrLf
                StrBody = StrBody & "<AcctInfo>" & vbCrLf
                    StrBody = StrBody & "<TipoReajustabilidad>" & CStr(Me.TipoReajustabilidad) & "</TipoReajustabilidad>" & vbCrLf
                    StrBody = StrBody & "<Custodia>" & CStr(Me.Custodia) & "</Custodia>" & vbCrLf 'Si o No
                    StrBody = StrBody & "<FechaInicio>" & CStr(Me.FechaInicio) & "</FechaInicio>" & vbCrLf 'yyyy-MM-dd
                    StrBody = StrBody & "<FIData>" & vbCrLf
                        StrBody = StrBody & "<PostAddr>" & vbCrLf
                            StrBody = StrBody & "<CountryCode>" & vbCrLf
                                StrBody = StrBody & "<CodigoPais>" & CStr(Me.CodigoPais) & "</CodigoPais>" & vbCrLf '840 USA US
                            StrBody = StrBody & "</CountryCode>" & vbCrLf
                        StrBody = StrBody & "</PostAddr>" & vbCrLf
                    StrBody = StrBody & "</FIData>" & vbCrLf
                    StrBody = StrBody & "<AcctBal>" & vbCrLf
                        StrBody = StrBody & "<InterestRateYield>" & vbCrLf
                            StrBody = StrBody & "<ValorTasaDescuento>" & Replace(CStr(Me.ValorTasaDescuento), ",", ".") & "</ValorTasaDescuento>" & vbCrLf
                            StrBody = StrBody & "<TasaDescuento>" & Replace(CStr(Me.TasaDescuento), ",", ".") & "</TasaDescuento>" & vbCrLf
                        StrBody = StrBody & "</InterestRateYield>" & vbCrLf
                        StrBody = StrBody & "<TotalCurAmt>" & vbCrLf
                            StrBody = StrBody & "<MontoTotalTransado>" & Replace(CStr(Me.MontoTotalTransado), ",", ".") & "</MontoTotalTransado>" & vbCrLf
                        StrBody = StrBody & "</TotalCurAmt>" & vbCrLf
                        StrBody = StrBody & "<RwdDueAmt>" & vbCrLf
                            StrBody = StrBody & "<MontoVencimiento>" & Replace(CStr(Me.MontoVencimiento), ",", ".") & "</MontoVencimiento>" & vbCrLf
                        StrBody = StrBody & "</RwdDueAmt>" & vbCrLf
                        StrBody = StrBody & "<RwdBalAmt>" & vbCrLf
                            StrBody = StrBody & "<MontoNominal>" & Replace(CStr(Me.MontoNominal), ",", ".") & "</MontoNominal>" & vbCrLf
                        StrBody = StrBody & "</RwdBalAmt>" & vbCrLf
                        StrBody = StrBody & "<RwdFinalAmt>" & vbCrLf
                            StrBody = StrBody & "<MontoFinal>" & Replace(CStr(Me.MontoFinal), ",", ".") & "</MontoFinal>" & vbCrLf
                        StrBody = StrBody & "</RwdFinalAmt>" & vbCrLf
                    StrBody = StrBody & "</AcctBal>" & vbCrLf
                    StrBody = StrBody & "<IntRateData>" & vbCrLf
                        StrBody = StrBody & "<RateMatrixTier>" & vbCrLf
                            StrBody = StrBody & "<TasaInteres>" & Replace(CStr(Me.TasaInteres), ",", ".") & "</TasaInteres>" & vbCrLf
                            StrBody = StrBody & "<MontoInteres>" & Replace(CStr(Me.MontoInteres), ",", ".") & "</MontoInteres>" & vbCrLf
                            StrBody = StrBody & "<TasaPacto>" & Replace(CStr(Me.TasaPacto), ",", ".") & "</TasaPacto>" & vbCrLf
                        StrBody = StrBody & "</RateMatrixTier>" & vbCrLf
                    StrBody = StrBody & "</IntRateData>" & vbCrLf
                    StrBody = StrBody & "<FechaVencimiento>" & CStr(Me.FechaVencimiento) & "</FechaVencimiento>" & vbCrLf
                    StrBody = StrBody & "<RelationshipMgr>" & vbCrLf
                        StrBody = StrBody & "<UsuarioIngreso>" & CStr(Me.UsuarioIngreso) & "</UsuarioIngreso>" & vbCrLf
                        StrBody = StrBody & "<UsuarioMDP>" & CStr(Me.UsuarioMDP) & "</UsuarioMDP>" & vbCrLf
                    StrBody = StrBody & "</RelationshipMgr>" & vbCrLf
                    StrBody = StrBody & "<CurAmt>" & vbCrLf
                        StrBody = StrBody & "<MontoOriginal>" & Replace(CStr(Me.MontoOriginal), ",", ".") & "</MontoOriginal>" & vbCrLf
                    StrBody = StrBody & "</CurAmt>" & vbCrLf
                    StrBody = StrBody & "<NumeroInstrumentos>" & CStr(Me.NumeroInstrumentos) & "</NumeroInstrumentos>" & vbCrLf
                    StrBody = StrBody & "<CargoCtaCte>" & CStr(Me.CargoCtaCte) & "</CargoCtaCte>" & vbCrLf
                    StrBody = StrBody & "<SobregiroCtaCte>" & CStr(Me.SobregiroCtaCte) & "</SobregiroCtaCte>" & vbCrLf
                StrBody = StrBody & "</AcctInfo>" & vbCrLf
                StrBody = StrBody & "<AcctEnvr>" & vbCrLf
                    StrBody = StrBody & "<PassbkKeys>" & vbCrLf
                        StrBody = StrBody & "<ClaveAbif>" & CStr(Me.ClaveAbif) & "</ClaveAbif>" & vbCrLf
                    StrBody = StrBody & "</PassbkKeys>" & vbCrLf
                StrBody = StrBody & "</AcctEnvr>" & vbCrLf
            StrBody = StrBody & "</AcctRec>" & vbCrLf
            StrBody = StrBody & "<AcctInfo>" & vbCrLf
                StrBody = StrBody & "<FIData>" & vbCrLf
                    StrBody = StrBody & "<Banco>" & CStr(Me.Banco) & "</Banco>" & vbCrLf
                    StrBody = StrBody & "<SucursalRut>" & CStr(Me.SucursalRut) & "</SucursalRut>" & vbCrLf
                StrBody = StrBody & "</FIData>" & vbCrLf
                StrBody = StrBody & "<AcctType>" & vbCrLf
                    StrBody = StrBody & "<FormaPago>" & CStr(Me.FormaPago) & "</FormaPago>" & vbCrLf
                StrBody = StrBody & "</AcctType>" & vbCrLf
                StrBody = StrBody & "<PaidAmt>" & vbCrLf
                    StrBody = StrBody & "<MontoOperacion>" & Replace(CStr(Me.MontoOperacion), ",", ".") & "</MontoOperacion>" & vbCrLf
                StrBody = StrBody & "</PaidAmt>" & vbCrLf
                StrBody = StrBody & "<CodigoValuta>" & CStr(Me.CodigoValuta) & "</CodigoValuta>" & vbCrLf
            StrBody = StrBody & "</AcctInfo>" & vbCrLf
            StrBody = StrBody & "<ToAcctRef>" & vbCrLf
                StrBody = StrBody & "<AcctRec>" & vbCrLf
                    StrBody = StrBody & "<CuentaCorrienteVendedor>" & CStr(Me.CuentaCorrienteVendedor) & "</CuentaCorrienteVendedor>" & vbCrLf
                    StrBody = StrBody & "<AcctInfo>" & vbCrLf
                    StrBody = StrBody & "<FIData>" & vbCrLf
                        StrBody = StrBody & "<CodigoBancoReceptor>" & CStr(Me.CodigoBancoReceptor) & "</CodigoBancoReceptor>" & vbCrLf
                        StrBody = StrBody & "<CodigoSucursal>" & CStr(Me.CodigoSucursal) & "</CodigoSucursal>" & vbCrLf
                    StrBody = StrBody & "</FIData>" & vbCrLf
                    StrBody = StrBody & "<AcctIdent>" & vbCrLf
                        StrBody = StrBody & "<CodigoCuentaCorriente>" & CStr(Me.CodigoCuentaCorriente) & "</CodigoCuentaCorriente>" & vbCrLf
                    StrBody = StrBody & "</AcctIdent>" & vbCrLf
                StrBody = StrBody & "</AcctInfo>" & vbCrLf
                StrBody = StrBody & "<AcctEnvr>" & vbCrLf
                    StrBody = StrBody & "<PartyKeys>" & vbCrLf
                        StrBody = StrBody & "<CodigoDcvVendedor>" & CStr(Me.CodigoDcvVendedor) & "</CodigoDcvVendedor>" & vbCrLf
                    StrBody = StrBody & "</PartyKeys>" & vbCrLf
                StrBody = StrBody & "</AcctEnvr>" & vbCrLf
            StrBody = StrBody & "</AcctRec>" & vbCrLf
        StrBody = StrBody & "</ToAcctRef>" & vbCrLf
        StrBody = StrBody & "<FromAcctRef>" & vbCrLf
            StrBody = StrBody & "<AcctRec>" & vbCrLf
                StrBody = StrBody & "<CuentaCorrienteComprador>" & CStr(Me.CuentaCorrienteComprador) & "</CuentaCorrienteComprador>" & vbCrLf
                StrBody = StrBody & "<AcctEnvr>" & vbCrLf
                    StrBody = StrBody & "<PartyKeys>" & vbCrLf
                        StrBody = StrBody & "<CodigoDcvComprador>" & CStr(Me.CodigoDcvComprador) & "</CodigoDcvComprador>" & vbCrLf
                    StrBody = StrBody & "</PartyKeys>" & vbCrLf
                StrBody = StrBody & "</AcctEnvr>" & vbCrLf
            StrBody = StrBody & "</AcctRec>" & vbCrLf
        StrBody = StrBody & "</FromAcctRef>" & vbCrLf
    StrBody = StrBody & "</AcctRef>" & vbCrLf
        StrBody = StrBody & "</ns:PaymentTrxTradersPiCrgRq>" & vbCrLf
    StrBody = StrBody & "</soapenv:Body>" & vbCrLf
StrBody = StrBody & "</soapenv:Envelope>" & vbCrLf

    '--> Reemplaza tags XML por la equivalencia del Broker de ITAU
    StrBody = Replace(StrBody, "CodigoCanal", "ChnlId", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CodigoAplicacion", "AppId", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "NombreAplicacion", "AppName", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CodigoProducto", "ProductIdent", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "NumeroOperacion", "AcctIdentValue", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "TipoOperacion", "AcctIdentType", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "IndicadorAccion", "AcctType", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "FechaOperacion", "OpenDt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "Ejecutivo", "Name", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "Moneda", "CurCodeValue", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "RutCliente", "IssuedIdentValue", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "SucursalRut", "FIIdent", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "MontoOperacion", "Amt", 1, , vbTextCompare)
    StrBody = Replace(StrBody, "FormaPago", "AcctTypeValue", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CodigoValuta", "ScrollCode", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "NombreCliente", "FullName", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "BancoIntermediario", "PersonIndicator", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "Banco", "BranchIdent", 1, 2, vbBinaryCompare)
    StrBody = Replace(StrBody, "CuentaCorrienteBeneficiarioVendedor", "AcctId", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "ClaveAbif", "PassbkId", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CuentaCorrienteComprador", "AcctId", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CodigoDcvComprador", "PartyId", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CuentaCorrienteVendedor", "AcctId", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CodigoDcvVendedor", "PartyId", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "MontoOriginal", "Amt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "FechaInicio", "OpenDt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "TasaInteres", "Rate", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "MontoInteres", "Amt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "MontoVencimiento", "Amt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "FechaVencimiento", "ClosedDt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "TipoReajustabilidad", "ResettableType", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "TasaPacto", "PactRate", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "MontoFinal", "Amt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "MontoNominal", "Amt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "ValorTasaDescuento", "Amt", 1, 2, vbBinaryCompare)
    StrBody = Replace(StrBody, "TasaDescuento", "Rate", 1, 2, vbBinaryCompare)
    StrBody = Replace(StrBody, "Custodia", "Custody", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "NumeroInstrumentos", "NumberInstruments", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "MontoTotalTransado", "Amt", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CodigoPais", "CountryCodeValue", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CodigoBancoReceptor", "BranchIdent", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CodigoSucursal", "FIIdent", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CodigoCuentaCorriente", "AcctIdentValue", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "IdCliente", "PartyId", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "IdBeneficiario", "PEPPartyId", 1, , vbTextCompare)
    StrBody = Replace(StrBody, "NombreClienteBeneficiario_3", "FullName3", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "NombreClienteBeneficiario_4", "FullName4", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "UsuarioIngreso", "RelationshipMgrIdent", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "UsuarioMDP", "RelationshipRole", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CargoCtaCte", "CACharge", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "SobregiroCtaCte", "CAOverdraft", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "CuentaIntermediario", "IssuedIdentType", 1, 2, vbTextCompare)
    StrBody = Replace(StrBody, "PaisIntermediario", "PostalCode", 1, 2, vbTextCompare)
    '--< Reemplaza tags XML por la equivalencia del Broker de ITAU
ParsearRequest_CC_INGRESARPAGOMESAPICRG = StrBody
End Function

Public Function CC_ANULACIONPAGOCRG() As String
On Error GoTo Err_PW
Dim objDom As Object
Dim objXmlHttp As Object
Dim strXmlBody As String

    Set objDom = CreateObject("MSXML2.DOMDocument")
    Set objXmlHttp = CreateObject("MSXML2.XMLHTTP")
   
    'Preparar Cuerpo del Mensaje
    strXmlBody = ParsearRequest_CC_ANULACIONPAGOCRG
    'Cargar Xml
    objDom.async = False
    objDom.LoadXml strXmlBody

    'Proceso apertura de WS para el paso por el MDP directo deben ir  Me.wsURL Me.wsACTION
    'Al hacerlos pasar por el Broker deben ir al revés, Me.wsACTION y luego Me.wsURL
    
    'objXmlHttp.Open "POST", Me.wsURL, False
    'Creando cabecera Mensaje y acción del mismo
    'objXmlHttp.setRequestHeader "Content-Type", "text/xml; charset=utf-8"
    'objXmlHttp.setRequestHeader "SOAPAction", Me.wsACTION
    
    objXmlHttp.Open "POST", Me.wsACTION, False
    objXmlHttp.setRequestHeader "Content-Type", "text/xml; charset=utf-8"
    objXmlHttp.setRequestHeader "SOAPAction", Me.wsURL
    
    'envío del mensaje formateado
    objXmlHttp.send objDom.xml

    'tomo el mensaje de retorno
    strret = objXmlHttp.responseText
    '--> 2022.04.07 INI cvegasan Se agrega grabar xml en tabla LOG
    Envia = Array()
    AddParam Envia, "CC_ANULACIONPAGOCRG"
    AddParam Envia, strXmlBody
    If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_GRABA_LOG_XML", Envia) Then
        Exit Function
    End If
    '--< 2022.04.07 FIN cvegasan Se agrega grabar xml en tabla LOG
    'Cierro conección y objeto
    Set objXmlHttp = Nothing
    
    'Parseo la respuesta del consumo para retornarla.
    'Capturo seccion <AdditionalStatus> </AdditionalStatus> que viene en XML de retorno
    Me.Mensaje = buscarXML("AdditionalStatus", strret)
    Me.Estado = buscarXML("StatusCode", Me.Mensaje)
    Me.Mensaje = buscarXML("StatusDesc", Me.Mensaje)
   
    'Retorno el estado del consumo
    If Me.Estado = "0" Then
        Me.Mensaje = "OK"
        CC_ANULACIONPAGOCRG = Me.Mensaje
    Else
        CC_ANULACIONPAGOCRG = "ERROR " & Me.Mensaje
    End If
    
    Exit Function
    
Err_PW:
    Me.Estado = "-1"
    Me.Mensaje = "Problema de conexión: " & Err.Number & " - " & Err.Description
    CC_ANULACIONPAGOCRG = Me.Mensaje
End Function

Public Function CC_INGRESARPAGODOCUMENTO() As String
On Error GoTo Err_PW
Dim objDom As Object
Dim objXmlHttp As Object
Dim strXmlBody As String

    Set objDom = CreateObject("MSXML2.DOMDocument")
    Set objXmlHttp = CreateObject("MSXML2.XMLHTTP")
   
    'Preparar Cuerpo del Mensaje
    strXmlBody = ParsearRequest_CC_INGRESARPAGODOCUMENTO
    
    'Cargar Xml
    objDom.async = False
    objDom.LoadXml strXmlBody

    'Proceso apertura de WS para el paso por el MDP directo deben ir  Me.wsURL Me.wsACTION
    'Al hacerlos pasar por el Broker deben ir al revés, Me.wsACTION y luego Me.wsURL
    'objXmlHttp.Open "POST", Me.wsURL, False
    'Creando cabecera Mensaje y acción del mismo
    'objXmlHttp.setRequestHeader "Content-Type", "text/xml; charset=utf-8"
    'objXmlHttp.setRequestHeader "SOAPAction", Me.wsACTION

    objXmlHttp.Open "POST", Me.wsACTION, False
    objXmlHttp.setRequestHeader "Content-Type", "text/xml; charset=utf-8"
    objXmlHttp.setRequestHeader "SOAPAction", Me.wsURL
    
    'envío del mensaje formateado
    objXmlHttp.send objDom.xml

    'tomo el mensaje de retorno
    strret = objXmlHttp.responseText
    '--> 2022.04.07 INI cvegasan Se agrega grabar xml en tabla LOG
    Envia = Array()
    AddParam Envia, "CC_INGRESARPAGODOCUMENTO"
    AddParam Envia, strXmlBody
    If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_GRABA_LOG_XML", Envia) Then
        Exit Function
    End If
    '--< 2022.04.07 FIN cvegasan Se agrega grabar xml en tabla LOG
    'Cierro conección y objeto
    Set objXmlHttp = Nothing
    
    'Parseo la respuesta del consumo para retornarla.
    'Capturo seccion <AdditionalStatus> </AdditionalStatus> que viene en XML de retorno
    Me.Mensaje = buscarXML("AdditionalStatus", strret)
    Me.Estado = buscarXML("StatusCode", Me.Mensaje)
    Me.Mensaje = buscarXML("StatusDesc", Me.Mensaje)
    
    'Retorno el estado del consumo
    If Me.Estado = "0" Then
        Me.Mensaje = "OK"
        CC_INGRESARPAGODOCUMENTO = Me.Mensaje
    Else
        CC_INGRESARPAGODOCUMENTO = "ERROR " & Me.Mensaje
    End If

Exit Function

Err_PW:
    Me.Estado = "-1"
    Me.Mensaje = "Problema de conexión: " & Err.Number & " - " & Err.Description
    CC_INGRESARPAGODOCUMENTO = Me.Mensaje
End Function

Public Function CC_INGRESARPAGOMESACRG() As String
On Error GoTo Err_PW
Dim objDom As Object
Dim objXmlHttp As Object
Dim strXmlBody As String

    Set objDom = CreateObject("MSXML2.DOMDocument")
    Set objXmlHttp = CreateObject("MSXML2.XMLHTTP")
   
   'Preparar Cuerpo del Mensaje
    strXmlBody = ParsearRequest_CC_INGRESARPAGOMESACRG
    
    'Cargar Xml
    objDom.async = False
    objDom.LoadXml strXmlBody

    'Proceso apertura de WS para el paso por el MDP directo deben ir  Me.wsURL Me.wsACTION
    'Al hacerlos pasar por el Broker deben ir al revés, Me.wsACTION y luego Me.wsURL
    'objXmlHttp.Open "POST", Me.wsURL, False
    'Creando cabecera Mensaje y acción del mismo
    'objXmlHttp.setRequestHeader "Content-Type", "text/xml; charset=utf-8"
    'objXmlHttp.setRequestHeader "SOAPAction", Me.wsACTION

    objXmlHttp.Open "POST", Me.wsACTION, False
    objXmlHttp.setRequestHeader "Content-Type", "text/xml; charset=utf-8"
    objXmlHttp.setRequestHeader "SOAPAction", Me.wsURL

    'envío del mensaje formateado
    objXmlHttp.send objDom.xml

    'tomo el mensaje de retorno
    strret = objXmlHttp.responseText
    '--> 2022.04.07 INI cvegasan Se agrega grabar xml en tabla LOG
    Envia = Array()
    AddParam Envia, "CC_INGRESARPAGOMESACRG"
    AddParam Envia, strXmlBody
    If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_GRABA_LOG_XML", Envia) Then
        Exit Function
    End If
    '--< 2022.04.07 FIN cvegasan Se agrega grabar xml en tabla LOG
    'Cierro conección y objeto
    Set objXmlHttp = Nothing
    
    'Parseo la respuesta del consumo para retornarla.
    'Capturo seccion <AdditionalStatus> </AdditionalStatus> que viene en XML de retorno
    Me.Mensaje = buscarXML("AdditionalStatus", strret)
    Me.Estado = buscarXML("StatusCode", Me.Mensaje)
    Me.Mensaje = buscarXML("StatusDesc", Me.Mensaje)
   
    'Retorno el estado del consumo
    If Me.Estado = "0" Then
        CC_INGRESARPAGOMESACRG = Me.Mensaje
    Else
        CC_INGRESARPAGOMESACRG = "ERROR " & Me.Mensaje
    End If
    
Exit Function

Err_PW:
    Me.Estado = "-1"
    Me.Mensaje = "Problema de conexión: " & Err.Number & " - " & Err.Description
    CC_INGRESARPAGOMESACRG = Me.Mensaje
End Function

Public Function CC_INGRESARPAGOMESAPICRG() As String
On Error GoTo Err_PW
Dim objDom As Object
Dim objXmlHttp As Object
Dim strXmlBody As String

    Set objDom = CreateObject("MSXML2.DOMDocument")
    Set objXmlHttp = CreateObject("MSXML2.XMLHTTP")
    'Preparar Cuerpo del Mensaje
    strXmlBody = ParsearRequest_CC_INGRESARPAGOMESAPICRG
    
    'Cargar Xml
    objDom.async = False
    objDom.LoadXml strXmlBody

    'Proceso apertura de WS para el paso por el MDP directo deben ir  Me.wsURL Me.wsACTION
    'Al hacerlos pasar por el Broker deben ir al revés, Me.wsACTION y luego Me.wsURL
    'objXmlHttp.Open "POST", Me.wsURL, False
    'Creando cabecera Mensaje y acción del mismo
    'objXmlHttp.setRequestHeader "Content-Type", "text/xml; charset=utf-8"
    'objXmlHttp.setRequestHeader "SOAPAction", Me.wsACTION

    objXmlHttp.Open "POST", Me.wsACTION, False
    objXmlHttp.setRequestHeader "Content-Type", "text/xml; charset=utf-8"
    objXmlHttp.setRequestHeader "SOAPAction", Me.wsURL

    'envío del mensaje formateado
    objXmlHttp.send objDom.xml

    'tomo el mensaje de retorno
    strret = objXmlHttp.responseText
    '--> 2022.04.07 INI cvegasan Se agrega grabar xml en tabla LOG
    Envia = Array()
    AddParam Envia, "CC_INGRESARPAGOMESAPICRG"
    AddParam Envia, strXmlBody
    If Not Bac_Sql_Execute("bacparamsuda..SP_NGINE_GRABA_LOG_XML", Envia) Then
        Exit Function
    End If
    '--< 2022.04.07 FIN cvegasan Se agrega grabar xml en tabla LOG
    'Cierro conección y objeto
    Set objXmlHttp = Nothing
    
    'Parseo la respuesta del consumo para retornarla.
    'Capturo seccion <AdditionalStatus> </AdditionalStatus> que viene en XML de retorno
    Me.Mensaje = buscarXML("AdditionalStatus", strret)
    Me.Estado = buscarXML("StatusCode", Me.Mensaje)
    Me.Mensaje = buscarXML("StatusDesc", Me.Mensaje)

    'Retorno el estado del consumo
    If Me.Estado = "0" Then
        Me.Mensaje = "OK"
        CC_INGRESARPAGOMESAPICRG = Me.Mensaje
    Else
        If Me.Estado = "N/A" Then Me.Estado = "1"
        CC_INGRESARPAGOMESAPICRG = "ERROR " & Me.Mensaje
    End If
    
Exit Function

Err_PW:
    Me.Estado = "-1"
    Me.Mensaje = "Problema de conexión: " & Err.Number & " - " & Err.Description
    CC_INGRESARPAGOMESAPICRG = Me.Mensaje
End Function



