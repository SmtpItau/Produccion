VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsTPremio"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public prcodi    As Integer
Public prserie   As String
Public prcupon   As Integer
Public prpremio  As Currency

Public Function Grabar() As Boolean

Dim SQL As String
Dim Fila As Long

    Grabar = False
        
    SQL = ""
    SQL = "EXEC Sp_TPGrabar  " & Chr(10)
    SQL = SQL & prcodi & ","
    SQL = SQL & "'" & prserie & "',"
    SQL = SQL & prcupon & ","
    SQL = SQL & BacStrTran(Trim$(CStr(prpremio)), ",", ".")
    If SQL_Execute(SQL) <> 0 Then
        Exit Function
    End If
    
    Grabar = True
  
End Function

Private Sub Class_Initialize()

End Sub


Private Sub Class_Terminate()

End Sub


