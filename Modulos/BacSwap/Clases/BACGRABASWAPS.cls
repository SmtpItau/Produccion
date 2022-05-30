VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Class1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public Function Grabar(CodTab As Integer) As Boolean

Dim Fila As Long
Dim SQL  As String
    
    Grabar = False
    
    SQL = "EXEC sp_TcGrabar1  " & Chr(10)
    SQL = SQL & CodTab & "," & Chr(10)
    SQL = SQL & codigo & "," & Chr(10)
    SQL = SQL & "'" & glosa & "'"
    
    If SQL_Execute(SQL) <> 0 Then
        Exit Function
    End If
    
'    Call Limpiar
    
    Grabar = True

End Function
