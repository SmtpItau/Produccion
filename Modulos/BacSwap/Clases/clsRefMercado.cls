VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsRefMercado"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Private inttiposwap As Integer
Private strModalidad  As String
Private intdiasvalor As Integer
Private intidtipocambio As Integer
Private strglosa As String
Private intCod As Integer


Public Property Let TipoSwap(ByVal vData As Integer)
    inttiposwap = vData
End Property

Public Property Get TipoSwap() As Integer
    TipoSwap = inttiposwap
End Property

Public Property Let Modalidad(ByVal vData As String)
    strModalidad = vData
End Property

Public Property Get Modalidad() As String
    Modalidad = strModalidad
End Property

Public Property Let DiasValor(ByVal vData As Integer)
    intdiasvalor = vData
End Property

Public Property Get DiasValor() As Integer
    DiasValor = intdiasvalor
End Property
Public Property Let idtipocambio(ByVal vData As Integer)
    intidtipocambio = vData
End Property

Public Property Get idtipocambio() As Integer
    idtipocambio = intidtipocambio
End Property
Public Property Let Glosa(ByVal vData As String)
    strglosa = vData
End Property
Public Property Get Glosa() As String
    Glosa = strglosa
End Property
Public Property Let Cod(ByVal vData As Integer)
    intCod = vData
End Property
Public Property Get Cod() As Integer
    Cod = intCod
End Property
