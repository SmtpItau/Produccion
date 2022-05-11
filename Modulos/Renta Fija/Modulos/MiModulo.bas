Attribute VB_Name = "MiModulo"
Option Explicit

Dim AHORA As Integer
Dim pl(2) As Integer
Private Sub Form_Paint()
'   AHORA = 0
'   Dim X As Integer
'   With Grilla
'      .GridLines = flexGridInset
'      .SelectionMode = flexSelectionByRow
'      .FocusRect = flexFocusNone
'      .Rows = 10
'      .Cols = 5
'      .FixedRows = 1
'      .FixedCols = 0
'      .RowHeight(0) = 500
'      .TextMatrix(0, 0) = "Uno"
'      .TextMatrix(0, 1) = "Dos"
'      .TextMatrix(0, 2) = "Tres"
'      .TextMatrix(0, 3) = "Cuatro"
'      .TextMatrix(0, 4) = "Cinco"
'      .Row = 1
'      For X = 0 To .Cols - 1
'         .FixedAlignment(X) = 4
'         .Col = X
'         .CellForeColor = 16777215
'         .CellBackColor = &HFF&
'      Next X
'      For X = 1 To .Rows - 1
'         .TextMatrix(X, 0) = X
'         .TextMatrix(X, 1) = X
'         .TextMatrix(X, 2) = X
'         .TextMatrix(X, 3) = X
'         .TextMatrix(X, 4) = X
'      Next X
'      .Row = 1: .Col = 0
'   End With
'   AHORA = 1
End Sub

Private Sub grilla_Click()
   VerificaCambio
   'Dim X
   'For X = 0 To grilla.Cols - 1
   '      grilla.FixedAlignment(X) = 4
   '      grilla.Col = X
   '      grilla.CellForeColor = 16777215
   '      grilla.CellBackColor = &HFF&
   'Next X
   'AHORA = 1
End Sub

Private Sub grilla_EnterCell()
'pl(1) = pl(2)
'pl(2) = grilla.Row
End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)
   VerificaCambio
End Sub

Private Sub VerificaCambio()

End Sub

Private Sub grilla_SelChange()
'   If AHORA = 1 Then
'      Dim y
'      y = Grilla.Row
'      Grilla.Row = 1
'      Grilla.Col = 0: Grilla.CellBackColor = &HC0C0C0
'      Grilla.CellForeColor = &HFF0000
'      Grilla.Col = 1: Grilla.CellBackColor = &HC0C0C0
'      Grilla.CellForeColor = &HFF0000
'      Grilla.Col = 2: Grilla.CellBackColor = &HC0C0C0
'      Grilla.CellForeColor = &HFF0000
'      Grilla.Col = 3: Grilla.CellBackColor = &HC0C0C0
'      Grilla.CellForeColor = &HFF0000
'      Grilla.Col = 4: Grilla.CellBackColor = &HC0C0C0
'      Grilla.CellForeColor = &HFF0000
'      Grilla.Row = y
'      Grilla.Col = 0
'      AHORA = 0
'   End If
End Sub

