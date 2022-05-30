VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ClsMovimSwaps"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Public swNumOperacion       As Double
Public swNumFlujo           As Integer
Public swTipoFlujo          As Integer
Public swTipoSwap           As Integer
Public swCarteraInversion   As Integer
Public swTipoOperacion      As String
Public swCodCliente         As Double
Public swFechaCierre        As Date
Public swFechaInicio        As Date
Public swFechaTermino       As Date
Public swFechaInicioFlujo   As Date
Public swFechaVenceFlujo    As Date
Public swFechaFijacionTasa  As Date
Public swCMoneda            As Integer
Public swCCapital           As String
Public swCAmortiza          As String
Public swCSaldo             As String
Public swCInteres           As String
Public swCSpread            As String
Public swCCodigoTasa        As Integer
Public swCValorTasa         As String
Public swCValorTasaHoy      As String
Public swCCodAmoCapital     As Integer
Public swCMesAmoCapital     As Integer
Public swCCodAmoInteres     As Integer
Public swCMesAmoInteres     As Integer
Public swCBase              As Integer
Public swVMoneda            As Integer
Public swVCapital           As String
Public swVAmortiza          As String
Public swVSaldo             As String
Public swVInteres           As String
Public swVSpread            As String
Public swVCodigoTasa        As Integer
Public swVValorTasa         As String
Public swVValorTasaHoy      As String
Public swVCodAmoCapital     As Integer
Public swVMesAmoCapital     As Integer
Public swVCodAmoInteres     As Integer
Public swVMesAmoInteres     As Integer
Public swVBase              As Integer
Public swOperador           As String
Public swOperadorCliente    As Double
Public swEstadoFlujo        As Integer
Public swModalidadPago      As String
Public swPagMoneda          As Integer
Public swPagDocumento       As Integer
Public swPagMonto           As String
Public swPagMontoUSD        As Double
Public swPagMontoCLP        As Double
Public swRecMoneda          As Integer
Public swRecDocumento       As Integer
Public swRecMonto           As String
Public swRecMontoUSD        As Double
Public swRecMontoCLP        As Double
Public swObservaciones      As String
Public swFechaModifica      As Date
Public swCMontoUSD          As String
Public swCMontoCLP          As String
Public swVMontoUSD          As String
Public swVMontoCLP          As String
Public swNomCliente         As String
Public swRutCliente         As String
Public swActualizar         As Integer
Public swEspecial           As Integer
Public ParidadCompra        As Double
Public ParidadVenta         As Double
Public swAreaResp           As String
Public swCartNorm           As String
Public swSubCartNorm        As String
Public swLibro              As String
Public swObservacion        As String

Public Function grabar() As Boolean

Dim Fila As Long
Dim Sql  As String
Dim NumeroOperacion As Double
Dim I As Integer
    
    grabar = False
    
    Envia = Array()
    AddParam Envia, CDbl(swActualizar)
    AddParam Envia, CDbl(swNumOperacion)       'Numero Operacion
    AddParam Envia, CDbl(swNumFlujo)           'Numero Correlativo del Vecimiento
    AddParam Envia, CDbl(swTipoFlujo)           'Tipo de Flujo 1 Compra 2 Venta
    AddParam Envia, CDbl(swTipoSwap)           'Tipo de Swaps
    AddParam Envia, CDbl(swCarteraInversion)   'Codigo Cartera de Inversion
    AddParam Envia, swTipoOperacion            'Codigo Tipo de operacion
    AddParam Envia, CDbl(swCodCliente)         'Codigo de cliente
    AddParam Envia, CDbl(swRutCliente)    'Rut de cliente
    AddParam Envia, Format(swFechaCierre, "yyyymmdd")      'Fecha Cierre de contrato
    AddParam Envia, Format(swFechaInicio, "yyyymmdd")      'Fecha Inicio
    AddParam Envia, Format(swFechaTermino, "yyyymmdd")     'Fecha Ultimo Vencimiento/Termino
    AddParam Envia, Format(swFechaInicioFlujo, "yyyymmdd") 'Fecha Inicio del Periodo de Amortizacion
    AddParam Envia, Format(swFechaVenceFlujo, "yyyymmdd")  'Fecha Vencimiento Periodo
    AddParam Envia, CDbl(swCMoneda)            'Codigo de Moneda para Compra
    AddParam Envia, CDbl(swCCapital)      'Monto Capital para Compra
    AddParam Envia, CDbl(swCAmortiza)     'Monto amortizado en Compra
    AddParam Envia, CDbl(swCSaldo)        'Saldo Pendiente ( no amortizado)
    AddParam Envia, CDbl(swCInteres)      'Monto Interes de amortizacion
    AddParam Envia, CDbl(swCSpread)       'Spread
    AddParam Envia, CDbl(swCCodigoTasa)        'Codigo de tasa en compra
    AddParam Envia, CDbl(swCValorTasa)    'Valor de Tasa en Compra
    AddParam Envia, CDbl(swCValorTasaHoy) 'Valor de tasa del dia
    AddParam Envia, CDbl(swCCodAmoCapital)     'Codigo del tipo de Amortizacion del monto capital
    AddParam Envia, CDbl(swCMesAmoCapital)     'Monto en meses de amort. del capital
    AddParam Envia, CDbl(swCCodAmoInteres)     'Codigo del tipo de Amortizacion del interes
    AddParam Envia, CDbl(swCMesAmoInteres)     'Monto en meses de amort. del capital
    AddParam Envia, CDbl(swCBase)              'Base especificada en Compra
    AddParam Envia, CDbl(swVMoneda)            'Codigo de Moneda para Venta
    AddParam Envia, CDbl(swVCapital)      'Monto Capital para Venta
    AddParam Envia, CDbl(swVAmortiza)     'Monto amortizado en Venta
    AddParam Envia, CDbl(swVSaldo)        'Saldo Pendiente ( no amortizado)
    AddParam Envia, CDbl(swVInteres)      'Monto Interes de amortizacion
    AddParam Envia, CDbl(swVSpread)       'Spread
    AddParam Envia, CDbl(swVCodigoTasa)        'Codigo de tasa en Venta
    AddParam Envia, CDbl(swVValorTasa)    'Valor de Tasa especificado para la Venta
    AddParam Envia, CDbl(swVValorTasaHoy) 'Valor de tasa del dia
    AddParam Envia, CDbl(swVCodAmoCapital)     'Codigo del tipo de Amortizacion del monto capital
    AddParam Envia, CDbl(swVMesAmoCapital)     'Monto en meses de amort. del capital
    AddParam Envia, CDbl(swVCodAmoInteres)
    AddParam Envia, CDbl(swVMesAmoInteres)
    AddParam Envia, CDbl(swVBase)
    AddParam Envia, swOperador
    AddParam Envia, CDbl(swOperadorCliente)
    AddParam Envia, CDbl(swEstadoFlujo)
    AddParam Envia, swModalidadPago
    AddParam Envia, CDbl(swPagMoneda)
    AddParam Envia, CDbl(swPagDocumento)
    AddParam Envia, CDbl(swPagMonto)
    AddParam Envia, CDbl(swPagMontoUSD)
    AddParam Envia, CDbl(swPagMontoCLP)
    AddParam Envia, CDbl(swRecMoneda)
    AddParam Envia, CDbl(swRecDocumento)
    AddParam Envia, CDbl(swRecMonto)
    AddParam Envia, CDbl(swRecMontoUSD)
    AddParam Envia, CDbl(swRecMontoCLP)
    AddParam Envia, swObservaciones
    AddParam Envia, Format(swFechaModifica, "yyyymmdd")
    AddParam Envia, CDbl(swCMontoUSD)
    AddParam Envia, CDbl(swVMontoCLP)
    AddParam Envia, CDbl(swCMontoUSD)
    AddParam Envia, CDbl(swVMontoCLP)
    AddParam Envia, CDbl(swEspecial)
    AddParam Envia, Format(swFechaFijacionTasa, "YYYYMMDD")
    AddParam Envia, "-" & Format(Time, "HH:MM:SS") & "-"
    AddParam Envia, CDbl(ParidadCompra)
    AddParam Envia, CDbl(ParidadVenta)
    AddParam Envia, Trim(swAreaResp)
    AddParam Envia, Trim(swCartNorm)
    AddParam Envia, Trim(swSubCartNorm)
    AddParam Envia, Trim(swLibro)

    If Not Bac_Sql_Execute("SP_GRABAMOVIMIENTOSSWAPS", Envia) Then
        Exit Function
    End If

    grabar = True

End Function
Public Function FormatNum(numero As Variant) As String

    If numero = 0 Then
        FormatNum = 0
    Else
        FormatNum = bacTranMontoSql(Format(numero, "###########0.0###"))
    End If

End Function
