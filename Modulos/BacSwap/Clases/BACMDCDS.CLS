VERSION 1.0 CLASS
BEGIN
  MultiUse = 0   'False
END
Attribute VB_Name = "clsDCarteras"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public objDCartera As Object
Public Coleccion As New Collection

Public Sub Coleccion2Control(objControl As Object)

Dim Filas   As Long
Dim IdGlosa As String * 40
Dim Max     As Long
          
    objControl.Clear
    Max = Coleccion.Count
    
    For Filas = 1 To Max
        IdGlosa = Coleccion(Filas).rcnombre
        objControl.AddItem IdGlosa
        objControl.ItemData(objControl.NewIndex) = Coleccion(Filas).rcrut
    Next Filas
    
End Sub

Public Function LeerDCarteras(DcNombre As String) As Boolean

'Consulta Dueños de Carteras ordenados alfabeticamente por nombre

Dim SQL   As String
Dim IdRow As Integer
Dim Datos()

    LeerDCarteras = False
    SQL = "Exec sp_RcLeerNombres " & "'" & DcNombre & "'"
          
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
       
    'Elimino todos los miembros de la coleccion
    Call VaciarColeccion
    
    'Recupera los datos y llena la coleccion
    Do While SQL_Fetch(Datos()) = 0
        Dim objBuf As New clsDCartera
        With objBuf
            .rccodcar = Val(Datos(1))
            .rcrut = Val(Datos(2))
            .rcdv = Datos(3)
            .rcnombre = Datos(4)
            .rcnumoper = Val(Datos(5))
            .rctelefono = Datos(6)
            .rcfax = Datos(7)
            .rcdirecc = Datos(8)
        End With
        Coleccion.Add objBuf
        Set objBuf = Nothing
    Loop

    LeerDCarteras = True
 
End Function
Private Sub VaciarColeccion()

Dim Filas&, Max&
          
    Max& = Coleccion.Count
    For Filas& = 1 To Max&
        Coleccion.Remove 1
    Next Filas&
          
End Sub

Private Sub Class_Initialize()

    Set objDCartera = New clsDCartera
    
End Sub


Private Sub Class_Terminate()

    Set objDCartera = Nothing
    
End Sub


