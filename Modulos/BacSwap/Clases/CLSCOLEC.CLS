VERSION 1.0 CLASS
BEGIN
   MultiUse = 0   'False

END

Attribute VB_Name = "clsDCarteras"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public objColeccion As New Collection

Public Sub Coleccion2Control(objControl As Object)

Dim Filas   As Long
Dim IdGlosa As String * 40

    objControl.Clear
    For Filas = 1 To objColeccion.Count
        IdGlosa = objColeccion(Filas).cdnombre
        objControl.AddItem IdGlosa
        objControl.ItemData(objControl.NewIndex) = objColeccion(Filas).cdrut
    Next Filas

End Sub

Public Function LeerDCarteras(DcNombre As String) As Boolean

'Consulta Dueños de Carteras ordenados alfabeticamente por nombre

Dim SQL   As String
Dim IdRow As Integer
Dim Datos()

    LeerDCarteras = False
    SQL = "Exec sp_CdLeerNombres " & "'" & DcNombre & "'"

    If sm_Execute(SQL) <> 0 Then
       Exit Function
    End If

    'Elimino todos los miembros de la coleccion
    Call VaciarColeccion

    'Recupera los datos y llena la coleccion
    Do While sm_Fetch(Datos()) = 0
        Dim oDc As New clsDCarteras
        With oDc
            .cdcodcar = Val(Datos(1))
            .cdrut = Val(Datos(2))
            .cddv = Datos(3)
            .cdnombre = Datos(4)
            .cdnumoper = Val(Datos(5))
            .cdtelefono = Datos(6)
            .cdfax = Datos(7)
            .cddirecc = Datos(8)
        End With
        objColeccion.Add oDc
        Set oDc = Nothing
    Loop

    LeerDCarteras = True

End Function
Private Sub VaciarColeccion()

Dim Filas&, Max&

    Max& = objColeccion.Count
    For Filas& = 1 To Max&
        objColeccion.Remove 1
    Next Filas&

End Sub
