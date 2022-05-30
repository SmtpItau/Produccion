VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsCarters"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Option Explicit

Public ObjCartera As Object
Public coleccion As New Collection

Public Sub VaciarColeccion()

   Dim Filas&, Max&

   Max& = coleccion.Count

   For Filas& = 1 To Max&
      coleccion.Remove 1

   Next Filas&

End Sub

'Consulta cartera ordenados alfabeticamente y llena una colección
Public Function LeerCartera(cartera As String) As Boolean

   Dim Sql           As String
   Dim IdRow         As Integer
   Dim objBuffer     As Object
   Dim Datos()

   LeerCartera = False

   Sql = "exec sp_crleernombres1" & "'" & cartera & "'"

   If SQL_Execute(Sql) <> 0 Then
      Exit Function

   End If

   Call VaciarColeccion

   Do While SQL_Fetch(Datos()) = 0

      Set objBuffer = New clsCarter

      With objBuffer
         .rut = Val(Datos(1))
         .dig = Datos(2)
         .nombre = Datos(3)

      End With

      coleccion.Add objBuffer
      Set objBuffer = Nothing

    Loop

    LeerCartera = True

End Function

Private Sub Class_Initialize()

   Set ObjCartera = New Clscartera

End Sub

Private Sub Class_Terminate()

   Set ObjCartera = Nothing

End Sub

