VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCodigos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public codigo    As Integer
Public glosa     As String
Public objTabCod As Object
Public coleccion As New Collection
Sub Agregar(codigo As String, glosa As String)

   Dim objBuffer As Object

   Set objBuffer = New clsCodigo
   
   With objBuffer
      .codigo = codigo
      .glosa = glosa
   
   End With
   
   coleccion.Add objBuffer
   
   Set objBuffer = Nothing

End Sub

'Lee todos los codigos de una Tabla
Public Function LeerCodigos(ByVal ncodtab As Integer) As Boolean

   Dim Sql           As String
   Dim objBuffer     As Object
   Dim Datos()

   LeerCodigos = False

    Envia = Array()
    AddParam Envia, ncodtab
    
    
   If Not Bac_Sql_Execute("sp_Leer_TC ", Envia) Then
      Exit Function
   End If

   Call VaciarColeccion

   Do While Bac_SQL_Fetch(Datos())

      Set objBuffer = New clsCodigo

      With objBuffer
         .codigo = Val(Datos(2))
         .glosa = Trim$(Datos(3))

      End With

      coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop

   LeerCodigos = True

End Function

Public Sub VaciarColeccion()

   Dim Filas As Long
   Dim Max   As Long

   Max = coleccion.Count
   For Filas = 1 To Max
      coleccion.Remove 1

   Next Filas

End Sub

Public Sub Coleccion2Control(objControl As Object)

   Dim Filas      As Long
   Dim IdGlosa    As String * 25
   Dim Max        As Long

   With objControl

      .Clear 'borra los datos del combo
      Max = coleccion.Count

      For Filas = 1 To Max
         IdGlosa = coleccion(Filas).glosa
         .AddItem IdGlosa
         .ItemData(objControl.NewIndex) = coleccion(Filas).codigo

      Next Filas

   End With

End Sub

Public Sub coleccion2grilla(objControl As Object)

   Dim Filas   As Long
   Dim Max     As Long

   With objControl

      .Rows = 1

      Max = coleccion.Count

      For Filas = 1 To Max
         .Rows = .Rows + 1
         .Row = .Rows - 1
         .Col = 1: .Text = Mid$(coleccion(Filas).glosa, 126, 3)
         .Col = 2: .Text = Mid$(coleccion(Filas).glosa, 1, 25)

      Next Filas

   End With

End Sub
