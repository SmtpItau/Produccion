Attribute VB_Name = "BacEstructura"
Option Explicit



'Type BacValorizaInput
'   ModCal               As Integer
'   FecCal               As String
'   Codigo               As Long
'   Mascara              As String
'   MonEmi               As Integer
'   Fecemi               As String
'   FecVen               As String
'   TasEmi               As Double
'   BasEmi               As Integer
'   TasEst               As Double
'   Nominal              As Double
'   Tir                  As Double
'   Pvp                  As Double
'   Mt                   As Double
'   TasEstNew            As Double
'   TasEmiNew            As Double
'End Type

' -----------------------------------------------------------------
' Tipo de Datos de Salida para el valorizador
' -----------------------------------------------------------------
'Type BacValorizaOutput
'   Nominal              As Double
'   Tir                  As Double
'   Pvp                  As Double
'   Mt                   As Double
'   MtUM                 As Double
'   Mt100                As Double
'   Van                  As Double
'   Vpar                 As Double
'   NumUCup              As Integer
'   FecUCup              As String
'   IntUCup              As Double
'   AmoUCup              As Double
'   SalUCup              As Double
'   NumPCup              As Integer
'   FecPCup              As String
'   IntPCup              As Double
'   AmoPCup              As Double
'   SalPCup              As Double
'   DuratMac             As Double
'   DuratMod             As Double
'   Convexid             As Double
'   TasEst               As Double
'   TasEstNew            As Double
'   TasEmiNew            As Double
'End Type


' -----------------------------------------------------------------
' Estructura datos de emisión.-
' -----------------------------------------------------------------
'Type BacDatEmiType
'   iOK                  As Integer
'   sInstSer             As String * 12
'   lRutemi              As Long
'   iMonemi              As Integer
'   sFecEmi              As String * 10
'   sFecVct              As String * 10
'   dTasEmi              As Double
'   iBasemi              As Integer
'   sRefNomi             As String * 1
'   sLecEmi              As String * 6
'   sGeneri              As String * 6
'
'   ' para datos extras en ventas
'   sFecpcup             As String * 10
'   dNumOper             As Double
'   sTipOper             As String * 3
'   sFecVtoP             As String * 10
'   iDiasDis             As Integer
'
'End Type

'Type BacTypeChkSerie
'   nError      As Integer
'   cMascara    As String
'   nCodigo     As Long
'  nSerie      As String
'   sFamilia    As String
'   nRutemi     As Long
'   nMonemi     As Integer
'   fTasemi     As Double
'   fBasemi     As Integer
'   dFecemi     As String
'   dFecven     As String
'   cRefnomi    As String
'   cGenemi     As String
'   cNemmon     As String
'   nCorMin     As Double
'   cSeriado    As String
'   cLeeEmi     As String
'   dFecpcup    As String
'End Type

Type TypeGrabar
   TipOper           As String
   Rutcart           As Long
   DigCart           As String
   NomCart           As String
   TipCart           As Integer
   ForPagoIni        As Integer
   ForPagoVcto       As Integer
   VamosVienen       As String
   RutCliente        As Long
   DigCliente        As String
   NomCliente        As String
   CodCliente        As Long
   TipoCliente       As String
   CodOrigen         As Integer
   CodDestino        As Integer
   CodEjecutivo      As String
   Observ            As String
   CtaCteIni         As String
   CtaCtevcto        As String
   Monedapago        As Integer
   utiliza_Lc        As Boolean
   TipOperAux        As String
   
   ''''''fli
   PagMan            As String
   Mercado           As String
   Sucursal          As String
   AreaResponsable   As String
   Fecha_PagoMañana  As String
   Laminas           As String
   Tipo_Inversion    As String
   CtaCteInicio      As String
   SucInicio         As String
   CtaCteFinal       As String
   SucFinal          As String
   FecInip           As String
   FecVenp           As String
   MonPacto          As Integer
   TasPacto          As Double
   DiasPacto         As Double
   BasePacto         As Double
   Comision          As Double
   'custodia          As Integer
   custodia          As String
   costoFondoOrigen  As Double
   costoFondoFinal   As Double
   TotalOperacion    As Double
   SaldoLibreta      As Double
   cmbOperador       As String
   mFCIC             As String
   ''''''
End Type


Type TypeFilroMoneda
     Monedapago      As String
     valor           As Double
End Type

Type TypeFilro
   RutCartera        As Long
   TipCartera        As Integer
   ClasCarteraSuper  As String
   FiltroFamilia     As String
   FiltroEmisor      As String
   FiltroMoneda      As String
   FiltroMonedaPago  As String
   FiltroCartera     As String
   FechaDesde        As Variant
   FechaHasta        As Variant
   Serie             As String
   Sort              As Integer
   CpCi              As Integer
   Monedapago(10)    As TypeFilroMoneda
End Type

Type TypeRegModificar
   Usuario           As String
   Terminal          As String
   Hora              As String
   FechaProceso      As String
   NumeroDocumento   As Long
   Correlativo       As Long
   NumeroOperacion   As Long
   TipoOperacion     As String
   ValorCompra       As Double
   RutCliente        As Long
   CodigoCliente     As Long
   FormaPagoInicio   As Integer
   FormaPagoVcto     As Integer
   Estado            As String

End Type

Type TypeApoderadosIb
     Apoderado         As String
     Rut               As String
End Type


Type TypeParametrosAceptaOper
     Mail             As Boolean
     Pagar            As Boolean
     Aprobar          As Boolean
     imprimir         As Boolean
     Caption          As String
End Type

Type TypeFilroCado
   FechaIni           As Variant
   FechaFin           As Variant
   OperacionIni       As Long
   OperacionFin       As Long
   RutCli             As Long
   CodCli             As Long
   EstadoPago(2)      As Boolean
   EstadoOperacion(5) As Boolean
   TiposOperacion(12) As Boolean
   FormasPago(10)     As Boolean
   EstadoInyector(10) As Boolean
   Sort               As Integer
   Desc               As Boolean
End Type


Type TypeLogInyector
     TipOper           As String
     NumeroOperacion   As Long
End Type

Type TypePagoManual
     TipOper           As String
     NumeroOperacion   As Long
     modo              As String
     Return            As Boolean
End Type


'----------------------------------

Type TypeMenuForm
     Name             As String
     Caption          As String
     Enabled          As Boolean
     Index            As Integer
End Type

Public vOpc_50218(14)  As TypeMenuForm
Public vOpc_50500(8)   As TypeMenuForm
Public vOpc_50211(18)  As TypeMenuForm
Public vOpc_50222(0)   As TypeMenuForm
Public vOpc_50219(5)   As TypeMenuForm
Public vOpc_50224(2)   As TypeMenuForm
Public vOpc_70300(8)   As TypeMenuForm
Public vOpc_22012(2)   As TypeMenuForm
Public vOpc_22013(0)   As TypeMenuForm
Public vOpc_21503(3)   As TypeMenuForm

'----------------------------------

Public BacGrabar            As TypeGrabar
Public BacFiltro            As TypeFilro
Public BacFiltroCado        As TypeFilroCado
Public BacRegMod            As TypeRegModificar
Public bacApoderadorIb(1)   As TypeApoderadosIb
Public bacLogInyector       As TypeLogInyector
Public bacPagoManual        As TypePagoManual
Public ParametrosAceptaOper As TypeParametrosAceptaOper



'-----------------------------------


Type TypeCargaBolsa
     InstSer               As String
     Nominal               As Double
     MtBolsa               As Double
     CodCustodia           As Integer
     CodClasifCarteraSuper As Integer
End Type


'-----------------------------------

Type TypeLimite84Detalle
     Correlativo           As Integer
     Instrumento           As String
     Limite                As String
     Monto                 As Double
     Rut                   As String
     NOMBRE                As String
     Exceso                As String
End Type


Type TypeLimite84
     Exceso               As String
     Acepta               As Boolean
     Detalle()            As TypeLimite84Detalle
End Type



'-----------------------------------

Type TypeLimiteLibera
     Limite                As String
     Operacion             As Long
     Correlativo           As Integer
     Rut                   As Long
     Codigo                As Long
     modo                  As Integer
End Type

Global Const EnviaaVisado_ = 1
Global Const Visar_ = 2
Global Const Consulta_ = 3


Public BacLimite84         As TypeLimite84
Public BacLimiteLibera     As TypeLimiteLibera


