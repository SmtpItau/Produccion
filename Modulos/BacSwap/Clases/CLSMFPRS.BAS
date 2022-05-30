Attribute VB_Name = "CLSMFPRS"
Option Explicit

Public objProducto As Object
Public Coleccion As New Collection

Public Sub LLenaControl(objControl As Object)

Dim Filas   As Long
Dim IdGlosa As String
Dim Max     As Long
          
    objControl.Clear
    Max = Coleccion.Count
    For Filas = 1 To Max
        IdGlosa = Coleccion(Filas).pprglosa
        objControl.AddItem IdGlosa
'        objControl.ItemData(objControl.NewIndex) = Coleccion(Filas).clrut
    Next Filas
    
End Sub

Public Sub VaciarColeccion()

Dim Filas&, Max&
          
    Max& = Coleccion.Count
    For Filas& = 1 To Max&
        Coleccion.Remove 1
    Next Filas&
          
End Sub


