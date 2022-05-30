VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Clsoperadors"
Attribute VB_Creatable = True
Attribute VB_Exposed = False
Option Explicit

Public objOperador As Object
Public coleccion As New Collection

Public Sub LLenarCombo(objControl As Object)

Dim Filas As Long
Dim Max   As Long

    objControl.Clear
    Max = coleccion.Count
    For Filas = 1 To Max
        objControl.AddItem coleccion(Filas).tonombre
        objControl.ItemData(objControl.NewIndex) = coleccion(Filas).tocodigo
    Next Filas
          
End Sub


Private Sub Class_Initialize()
 Set objOperador = New Clsoperadr
End Sub


Private Sub Class_Terminate()
 Set objOperador = Nothing
End Sub
Public Function LeerOperadores() As Boolean
Dim SQL   As String
Dim Datos()
 
    LeerOperadores = False
    SQL = "Exec sp_LeerOperadores "
          
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
       
    Call VaciarColeccion
    
    Do While SQL_Fetch(Datos()) = 0
        Dim objBuf As New Clsoperadr
        With objBuf
            .tocodigo = Val(Datos(1))
            .tonombre = Datos(2)
        End With
        coleccion.Add objBuf
        Set objBuf = Nothing
    Loop
    
    LeerOperadores = True

End Function
Public Sub VaciarColeccion()

Dim Filas&, Max&
          
    Max& = coleccion.Count
    For Filas& = 1 To Max&
        coleccion.Remove 1
    Next Filas&
          
End Sub

