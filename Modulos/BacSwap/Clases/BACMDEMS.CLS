VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsEmisores"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public objEmisor As Object
Public Coleccion As New Collection

Public Sub VaciarColeccion()

Dim Filas&, Max&
          
    Max& = Coleccion.Count
    For Filas& = 1 To Max&
        Coleccion.Remove 1
    Next Filas&
          
End Sub
Public Function LeerEmisores(IdNombre As String) As Boolean

'Consulta Emisores ordenados alfabeticamente por nombre y llena una coleccion

Dim SQL   As String
Dim IdRow As Integer
Dim Datos()
 
    LeerEmisores = False
    SQL = "Exec sp_EMLeerNombres " & "'" & IdNombre & "'"
          
    If SQL_Execute(SQL) <> 0 Then
       Exit Function
    End If
       
    'Elimino todos los miembros de la colección
    Call VaciarColeccion
    
    Do While SQL_Fetch(Datos()) = 0
        Dim objBuf As New clsEmisor
        With objBuf
           .emcodigo = Val(Datos(1))
           .emrut = Val(Datos(2))
           .emdv = Datos(3)
           .emnombre = Datos(4)
           .emgeneric = Datos(5)
           .emdirecc = Datos(6)
           .emcomuna = Datos(7)
           .emtipo = Datos(8)
        End With
        Coleccion.Add objBuf
        Set objBuf = Nothing
    Loop
    
    LeerEmisores = True

End Function


Public Sub Coleccion2Control(objControl As Object)

Dim Filas   As Long
Dim IdGlosa As String * 40
Dim Max     As Long
          
    objControl.Clear
    Max& = Coleccion.Count
    For Filas = 1 To Max&
        IdGlosa = Coleccion(Filas).emnombre
        objControl.AddItem IdGlosa
        objControl.ItemData(objControl.NewIndex) = Coleccion(Filas).emrut
    Next Filas
    
End Sub



Private Sub Class_Initialize()

    Set objEmisor = New clsEmisor
    
End Sub


Private Sub Class_Terminate()

    Set objEmisor = Nothing
    
End Sub


