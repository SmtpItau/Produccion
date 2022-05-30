VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsparidad"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Option Explicit
  'estructura de la tabla MFPA

Public pcodigo As Long
Public pfecha  As String
Public pperiodo As Integer
Public pbid As Double
Public pask As Double
Public puncom As Double
Public punven As Double

Function Grabar()

Dim SQL As String
     
    Grabar = False
    
  SQL = "Exec Sp_grabaparidadFWD1" & Chr(10)
  SQL = SQL & pcodigo & "," & Chr(10)
  SQL = SQL & "'" & Format$(pfecha, "mm/dd/yyyy") & "'" & ","
  SQL = SQL & pperiodo & "," & Chr(10)
  SQL = SQL & BacFormatoSQL(pbid) & "," & Chr(10)
  SQL = SQL & BacFormatoSQL(pask) & "," & BacFormatoSQL(puncom) & "," & punven & Chr(10)
 
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
    
    Call limpiar
    Grabar = True
End Function


Sub limpiar()

pcodigo = 0
pfecha = ""
pperiodo = 0
pbid = 0
pask = 0
puncom = 0
punven = 0

End Sub


