VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Clstipoper"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public objOper   As Object
Public Coleccion As New Collection

Public Sub LlenaCombo(objControl As Object)

Dim Filas As Long
Dim Max   As Long

    objControl.Clear
    Max = Coleccion.Count
    For Filas = 1 To Max
        objControl.AddItem Coleccion(Filas).nombre
        objControl.ItemData(objControl.NewIndex) = Coleccion(Filas).codigo
    Next Filas
          
End Sub

Public Sub Llama()
Dim SQL As String
Dim Datos()


    SQL = "Execute Sp_LeeTiposOperador"
    If SQL_Execute(SQL) <> 0 Then
       MsgBox "Error en la lectura", 48
       Exit Sub
    End If
    
    Call LimpiaColeccion
    
    Do While SQL_Fetch(Datos()) = 0
        Dim objBuf As New Clsoper
        With objBuf
            .nombre = Trim$(Datos(1))
            .codigo = Val(Datos(2))
        End With
        Coleccion.Add objBuf
        Set objBuf = Nothing
    Loop

    
End Sub
Public Sub LimpiaColeccion()
Dim Filas   As Long
Dim Max     As Long
          
    Max = Coleccion.Count
    For Filas = 1 To Max
        Coleccion.Remove 1
    Next Filas
          
End Sub
 



Private Sub Class_Initialize()
                Set objOper = New Clsoper
End Sub


Private Sub Class_Terminate()
                Set objOper = Nothing
End Sub


