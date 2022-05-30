VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsCarteras"
Attribute VB_Creatable = True
Attribute VB_Exposed = False
Option Explicit

Public ObjCartera As Object
Public coleccion As New Collection

Public Function LeerCarteras() As Boolean

   Dim Sql           As String
   Dim objBuffer     As Object
   Dim Datos()

   LeerCarteras = False

   Sql = "execute sp_leercarteras "

   If SQL_Execute(Sql) <> 0 Then
      Exit Function

   End If

   Call VaciarColeccion

   Do While SQL_Fetch(Datos()) = 0

      Set objBuffer = New Clscartera
      
      With objBuffer
         .rccodcar = Val(Datos(1))
         .rcrut = Val(Datos(2))
         .rcdv = Datos(3)
         .rcnombre = Datos(4)
         .rcnumoper = Val(Datos(5))
         .rctelefono = Datos(6)
         .rcfax = Datos(7)
         .rcdirecc = Datos(8)

      End With

      coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop

   LeerCarteras = True

End Function

Public Sub LLenarCombo(objControl As Object)

   Dim Filas As Long
   Dim Max   As Long

   With objControl

      .Clear

      Max = coleccion.Count

      For Filas = 1 To Max
         .AddItem coleccion(Filas).rcnombre
         .ItemData(.NewIndex) = coleccion(Filas).rcrut

      Next Filas

   End With

End Sub

Public Sub VaciarColeccion()

   Dim Filas&, Max&

   Max& = coleccion.Count

   For Filas& = 1 To Max&
      coleccion.Remove 1

   Next Filas&

End Sub

