VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Clscartera"
Attribute VB_Creatable = True
Attribute VB_Exposed = False
Option Explicit

Public rccodcar     As Double
Public rcrut        As Double
Public rcdv         As String
Public rcnombre     As String
Public rcnumoper    As Double
Public rctelefono   As String
Public rcfax        As String
Public rcdirecc     As String
Private Sub Limpiar()

   rccodcar = 0
   rcrut = 0
   rcdv = ""
   rcnombre = ""
   rcnumoper = 0
   rctelefono = ""
   rcfax = ""
   rcdirecc = ""

End Sub

