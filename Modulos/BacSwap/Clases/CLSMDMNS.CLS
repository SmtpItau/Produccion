VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Clstipmonedas"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit
 
Public objmoneda As Object
Public Coleccion As New Collection

Public Function BuscaCombo(nCod As Integer) As Long
Dim Max As Long
Dim Filas As Long
BuscaCombo = -1

Max = Coleccion.Count
For Filas = 1 To Max
        If Coleccion(Filas).codigo = nCod Then
                    BuscaCombo = Filas - 1
                    Exit Function
        End If
Next Filas

End Function

Public Sub LlenaCombo(objControl As Object)

Dim Filas As Long
Dim Max   As Long

objControl.Clear
Max = Coleccion.Count
For Filas = 1 To Max
        objControl.AddItem Coleccion(Filas).Nemo
        objControl.ItemData(objControl.NewIndex) = Coleccion(Filas).codigo
Next Filas
          
End Sub

Public Sub Llama()
Dim SQL As String
Dim Datos()

SQL = "Execute Sp_LeeMonedas"
If SQL_Execute(SQL) <> 0 Then
       MsgBox "Error en la lectura de las Monedas ", 48
       Exit Sub
End If
    
Call LimpiaColeccion
    
Do While SQL_Fetch(Datos()) = 0
        Dim objBuf As New ClsTipomoneda
        With objBuf
            .Nemo = Trim$(Datos(1))
            .codigo = Val(Datos(2))
            .Base = Val(Datos(3))
            .Valor = Val(Datos(4))
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
                Set objmoneda = New ClsTipomoneda
                
End Sub


Private Sub Class_Terminate()
                    Set objmoneda = Nothing
End Sub


