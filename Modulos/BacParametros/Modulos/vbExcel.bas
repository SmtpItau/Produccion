Attribute VB_Name = "vbExcel"
Public Sub ControlWindows(I&)
   Dim n&
   For n = 1 To I
      DoEvents
   Next
End Sub

Public Sub AbrirExcel(ByRef AppExcel As Object, Visible As Boolean)
   On Error GoTo ErrorOpen
   
   Dim intErr As Integer

   On Error GoTo ErrorOpen

   Set AppExcel = GetObject(, "Excel.Application")

Salir:
    
    On Error GoTo 0
Exit Sub
ErrorOpen:
   Set AppExcel = CreateObject("Excel.Application")
   GoTo Salir
End Sub


Public Function FuncCreaMarco()
On Error Resume Next
    Selection.Borders(xlDiagonalDown).LineStyle = xlNone
    Selection.Borders(xlDiagonalUp).LineStyle = xlNone
    With Selection.Borders(xlEdgeLeft)
        .LineStyle = xlContinuous
        .ColorIndex = 0
        .TintAndShade = 0
        .Weight = xlThin
    End With
    With Selection.Borders(xlEdgeTop)
        .LineStyle = xlContinuous
        .ColorIndex = 0
        .TintAndShade = 0
        .Weight = xlThin
    End With
    With Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .ColorIndex = 0
        .TintAndShade = 0
        .Weight = xlThin
    End With
    With Selection.Borders(xlEdgeRight)
        .LineStyle = xlContinuous
        .ColorIndex = 0
        .TintAndShade = 0
        .Weight = xlThin
    End With
    Selection.Borders(xlInsideVertical).LineStyle = xlNone
    Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
On Error GoTo 0
End Function
