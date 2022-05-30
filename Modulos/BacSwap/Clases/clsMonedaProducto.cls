VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsMonedaProducto"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public MfCodMon  As Integer
Public MfMonPag  As Integer
Public MnGlosa   As String
Public MfCodFor  As Integer
Public Glosa     As String

Public Sub Limpiar()
   MfCodMon = 0
   MfMonPag = 0
   MnGlosa = ""
   MfCodFor = 0
   Glosa = ""
End Sub

