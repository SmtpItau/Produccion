VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsConsultaSwap"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public TipProd              As String
Public NumOperacion         As Double
Public TipoOperacion        As String
Public CodTipoOp            As String
Public Cliente              As String
Public FechaInicio          As String
Public FechaVenc            As String
Public MonedaOp             As String
Public MontoOp              As Double
Public TasaBase             As Double
Public MontoConv            As Double
Public TasaConv             As Double
Public Modalidad            As String
Public CodigoCliente        As Double
Public RutCliente           As String
Public NumFlujo             As Integer
Public iValorICP            As Double
Public FechaLiq             As String 'Incorporada el día 02-04-2015


Public Area_Responsable     As String
Public Cartera_Normativa    As String
Public SubCartera_Normativa As String
Public Libro                As String




