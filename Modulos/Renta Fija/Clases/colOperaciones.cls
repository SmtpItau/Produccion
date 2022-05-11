VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "colOperaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public oColCompras         As New Collection

Dim mvarTotalOperacion     As Double
Dim mvarTotalMercado       As Double
Dim mvarTotalResultado     As Double
Dim mvarRutCart            As Long
Dim mvarDigCart            As String
Dim mvarNomCart            As String
Dim mvarTipCart            As String
Dim mvarForPagoIni         As Integer
Dim mvarForPagoVcto        As Integer
Dim mvarVamosVienen        As String
Dim mvarRutCliente         As Long
Dim mvarDigCliente         As String
Dim mvarNomCliente         As String
Dim mvarCodCliente         As Long
Dim mVarObserv             As String
Dim mvarMercado            As String
Dim mvarSucursal           As String
Dim mvarAreaResponsable    As String
Dim mvarFecha_PagoMañana   As String
Dim mvarLaminas            As String
Dim mvarTipo_Inversion     As String
Dim mvarCtaCteInicio       As String
Dim mvarSucInicio          As String
Dim mvarCtaCteFinal        As String
Dim mvarSucFinal           As String
Dim mvarFecInip            As String
Dim mvarFecVenp            As String
Dim mvarCostoFondoComprasOr As Double
Dim mvarCostoFondoComprasFi As Double
Dim mVarBolsa               As Integer
Dim mVarCodOrigen          As Integer
Dim mVarCodDestino         As Integer
Dim mVarCodEjecutivo       As String
Dim mvarcustodia           As String


Dim Sql                    As String
Dim Datos()


Public Property Get FecInip() As String

   FecInip = mvarFecInip

End Property


Public Property Let FecInip(nFecInip As String)

   mvarFecInip = nFecInip

End Property

Public Property Get custodia() As String
   custodia = mvarcustodia
End Property
Public Property Let custodia(scustodia As String)

mvarcustodia = scustodia

End Property

Public Property Get SucFinal() As String

   SucFinal = mvarSucFinal

End Property


Public Property Let SucFinal(nSucFinal As String)

   mvarSucFinal = nSucFinal

End Property

Public Property Get CtaCteFinal() As String

   CtaCteFinal = mvarCtaCteFinal

End Property


Public Property Let CtaCteFinal(nCtaCteFinal As String)

   mvarCtaCteFinal = nCtaCteFinal

End Property

Public Property Get SucInicio() As String

   SucInicio = mvarSucInicio

End Property


Public Property Let SucInicio(nSucInicio As String)

   mvarSucInicio = nSucInicio

End Property

Public Property Get CtaCteInicio() As String

   CtaCteInicio = mvarCtaCteInicio

End Property


Public Property Let CtaCteInicio(nCtaCteInicio As String)

   mvarCtaCteInicio = nCtaCteInicio

End Property

Public Property Get Descripcion() As String

   Descripcion = "COMPRAS DEFINITIVAS"

End Property

Public Property Get TipoOperacion() As String

   TipoOperacion = "CP"

End Property

Public Property Get TotalOperacion() As Double

   TotalOperacion = mvarTotalOperacion

End Property

Public Property Get TotalMercado() As Double

   TotalMercado = mvarTotalMercado

End Property

Public Property Get TotalResultado() As Double

   TotalResultado = mvarTotalResultado

End Property

Public Property Let Rutcart(nRutCart As Long)

   mvarRutCart = nRutCart

End Property

Public Property Get Mercado() As String

   Mercado = mvarMercado

End Property

Public Property Let Mercado(cMercado As String)

   mvarMercado = cMercado

End Property

Public Property Get Sucursal() As String

   Sucursal = mvarSucursal

End Property

Public Property Let Sucursal(cSucursal As String)

   mvarSucursal = cSucursal

End Property


Public Property Get AreaResponsable() As String

    AreaResponsable = mvarAreaResponsable

End Property

Public Property Let AreaResponsable(cAreaResponsable As String)

   mvarAreaResponsable = cAreaResponsable

End Property


Public Property Get Fecha_PagoMañana() As String

    Fecha_PagoMañana = mvarFecha_PagoMañana

End Property

Public Property Let Fecha_PagoMañana(cFecha_PagoMañana As String)

   mvarFecha_PagoMañana = cFecha_PagoMañana

End Property


Public Property Get Laminas() As String

    Laminas = mvarLaminas
    
End Property

Public Property Let Laminas(cLaminas As String)

   mvarLaminas = cLaminas

End Property



Public Property Get Tipo_Inversion() As String

    Tipo_Inversion = mvarTipo_Inversion

End Property

Public Property Let Tipo_Inversion(cTipo_Inversion As String)

   mvarTipo_Inversion = cTipo_Inversion

End Property


Public Property Let Observ(cObserv As String)

   mVarObserv = cObserv

End Property
Public Property Get Rutcart() As Long

   Rutcart = mvarRutCart

End Property

Public Property Let DigCart(sDigCart As String)

   mvarDigCart = sDigCart

End Property

Public Property Get DigCart() As String

   DigCart = mvarDigCart

End Property


Public Property Let NomCart(sNomCart As String)

   mvarNomCart = sNomCart

End Property

Public Property Get NomCart() As String

   NomCart = mvarNomCart

End Property

Public Property Get Observ() As String

   Observ = mVarObserv

End Property

Public Property Let TipCart(nTipCart As String)

   mvarTipCart = nTipCart

End Property

Public Property Get TipCart() As String

   TipCart = mvarTipCart

End Property

Public Property Let ForPagoIni(nForPagoIni As Integer)

   mvarForPagoIni = nForPagoIni

End Property

Public Property Get ForPagoIni() As Integer

   ForPagoIni = mvarForPagoIni

End Property

Public Property Let ForPagoVcto(nForPagoVcto As Integer)

   mvarForPagoVcto = nForPagoVcto

End Property

Public Property Get ForPagoVcto() As Integer

   ForPagoVcto = mvarForPagoVcto

End Property

Public Property Let VamosVienen(sVamosVienen As String)

   mvarVamosVienen = sVamosVienen

End Property

Public Property Get VamosVienen() As String

   VamosVienen = mvarVamosVienen

End Property

Public Property Let RutCliente(nRutCliente As Long)

   mvarRutCliente = nRutCliente

End Property

Public Property Get RutCliente() As Long

   RutCliente = mvarRutCliente

End Property

Public Property Let NomCliente(sNomCliente As String)

   mvarNomCliente = sNomCliente

End Property

Public Property Get NomCliente() As String

   NomCliente = mvarNomCliente

End Property

Public Property Let CodCliente(nCodCliente As Long)

   mvarCodCliente = nCodCliente

End Property

Public Property Get CodCliente() As Long

   CodCliente = mvarCodCliente

End Property

Public Property Get costoFondoOperacionesOr() As Double

    costoFondoOperacionesOr = mvarCostoFondoComprasOr
    
End Property

Public Property Let costoFondoOperacionesOr(dblCostoFondo As Double)

    mvarCostoFondoComprasOr = dblCostoFondo
    
End Property
Public Property Get costoFondoOperacionesFi() As String
    
    costoFondoOperacionesFi = mvarCostoFondoComprasFi

End Property

Public Property Let costoFondoOperacionesFi(dblCostoFondoFinal As String)
    
    mvarCostoFondoComprasFi = dblCostoFondoFinal

End Property
Public Property Let Bolsa(nBolsa As Integer)
    mVarBolsa = nBolsa
End Property
Public Property Get Bolsa() As Integer
    Bolsa = mVarBolsa
End Property
'**************


Public Property Let CodOrigen(nCodOrigen As Integer)

   mVarCodOrigen = nCodOrigen

End Property

Public Property Let CodEjecutivo(nCodEjecutivo As String)

   mVarCodEjecutivo = nCodEjecutivo

End Property

Public Property Get CodOrigen() As Integer

   CodOrigen = mVarCodOrigen

End Property

Public Property Get CodEjecutivo() As String

   CodEjecutivo = mVarCodEjecutivo

End Property


Public Property Let CodDestino(nCodDestino As Integer)

   mVarCodDestino = nCodDestino

End Property

Public Property Get CodDestino() As Integer
   
   CodDestino = mVarCodDestino

End Property

