VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsmonexs"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Option Explicit

Public objmonex As Object
Public coleccion As New Collection
Public Sub VaciarColeccion()

   Dim Filas   As Long
   Dim Max     As Long
          
   Max = coleccion.Count

   For Filas = 1 To Max
      coleccion.Remove 1

   Next Filas

End Sub

Public Sub Coleccion2Control(objControl As Object)

   Dim Filas As Long
   Dim Max   As Long

   With objControl

      .Clear

      Max = coleccion.Count

      For Filas = 1 To Max
         .AddItem coleccion(Filas).mxdescrip
         .ItemData(.NewIndex) = coleccion(Filas).mxcodigo

      Next Filas

   End With

End Sub

'Lee todas las monedas y llena una colecccion
Public Function LeerMonedas(cMonref As Long) As Boolean
    
   Dim Sql           As String
   Dim objBuffer     As Object
   Dim Datos()
    
   LeerMonedas = False
    
   Sql = "execute sp_leemonexfwd "
   Sql = Sql & cMonref & "," & "'0'"

   If SQL_Execute(Sql) > 0 Then
      Exit Function

   End If
    
   Call VaciarColeccion
    
   Do While SQL_Fetch(Datos()) = 0

      Set objBuffer = New clsmonex

      With objBuffer
         .mxcodigo = Val(Datos(1))
         .mxglosamoneda = Datos(2)
         .mxdescrip = (Datos(3))
         .mxfactor = Val(Datos(4))
         .mxpais = Datos(5)
         .mxnemobcch = Datos(6)

      End With

      coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop

   LeerMonedas = True

End Function

Public Sub LlenaCombo(objControl As Object)

   Dim Filas As Long
   Dim Max   As Long

   With objControl

      .Clear

      Max = coleccion.Count

      For Filas = 1 To Max
         .AddItem coleccion(Filas).mxglosamoneda
         .ItemData(.NewIndex) = coleccion(Filas).mxcodigo

      Next Filas

   End With

End Sub

Private Sub Class_Initialize()
   
   Set objmonex = New clsmonex

End Sub

Private Sub Class_Terminate()
 
   Set objmonex = Nothing

End Sub

