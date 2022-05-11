VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "colCortes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public oColCortes        As New Collection

Dim mvarSerie              As String
Dim mvarMoneda             As String
Dim mvarTipOper            As String
Dim mvarInstrumento        As String
Dim mvarNominalOper        As Double
Dim mvarNominal            As Double
Dim mvarNominalVenta       As Double

Public Property Let Serie(sSerie As String)

   mvarSerie = sSerie

End Property

Public Property Get Serie() As String

   Serie = mvarSerie

End Property

Public Property Let Moneda(sMoneda As String)

   mvarMoneda = sMoneda

End Property

Public Property Get Moneda() As String

   Moneda = mvarMoneda

End Property

Public Property Let TipOper(sTipOper As String)

   mvarTipOper = sTipOper

End Property

Public Property Get TipOper() As String

   TipOper = mvarTipOper

End Property

Public Property Let NominalOper(nNominal As Double)

   mvarNominalOper = nNominal

End Property

Public Property Get NominalOper() As Double

   NominalOper = mvarNominalOper

End Property

Public Property Let NominalVenta(nNominal As Double)

   mvarNominalVenta = nNominal

End Property

Public Property Get NominalVenta() As Double

   NominalVenta = mvarNominalVenta

End Property

Public Property Get Nominal() As Double

   Nominal = mvarNominal

End Property

Public Sub NuevoItem()

   Dim objBuffer        As Object

   Set objBuffer = New estCortes

   oColCortes.Add objBuffer

   Set objBuffer = Nothing

End Sub

Public Sub RemoveTodo(nEstado As Integer)

   Dim iitem         As Integer

   For iitem = oColCortes.Count To 1 Step -1
      oColCortes.Remove iitem

   Next iitem

   If nEstado = 0 Then
      NuevoItem

   End If

End Sub

Public Sub RemoveItem(nRow As Integer)

   oColCortes.Remove nRow

   Call CalcularNominal

End Sub

Public Function CheckNominal() As Integer

   If Format(mvarNominal, "0.0000") = Format(mvarNominalOper, "0.0000") Then
      CheckNominal = 0

   ElseIf Val(Format(mvarNominal, "0.0000")) > Val(Format(mvarNominalOper, "0.0000")) Then
      CheckNominal = 2

   Else
      CheckNominal = 1

   End If

End Function

Public Sub CalcularNominal()

   Dim iCortes             As Integer

   mvarNominal = 0

   For iCortes = 1 To oColCortes.Count
      If mvarTipOper = "CP" Or mvarTipOper = "CI" Then
         mvarNominal = mvarNominal + (oColCortes(iCortes).MtoCort * oColCortes(iCortes).CantCortD)

      ElseIf mvarTipOper = "VI" Or mvarTipOper = "VP" Then
         mvarNominal = mvarNominal + (oColCortes(iCortes).MtoCort * oColCortes(iCortes).CantCortV)

      End If

   Next iCortes

End Sub

