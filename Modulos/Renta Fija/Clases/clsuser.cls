VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsUsuario"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Option Explicit

Public usuario      As String
Public nombre       As String


Private Sub Limpiar()

    usuario = ""
    nombre = ""
    
End Sub


Private Sub Class_Initialize()
    Call Limpiar
End Sub


