VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsCodigos"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

'Agregar un campo que indique si se puede mantener o no.
Public objTabCod As Object
Public coleccion As New Collection
Sub Agregar(codigo As String, Glosa As String)

   Dim objBuffer As Object

   Set objBuffer = New clsCodigo
   
   With objBuffer
      .codigo = codigo
      .Glosa = Glosa
   
   End With
   
   coleccion.Add objBuffer
   
   Set objBuffer = Nothing

End Sub

Public Function grabar(CodTab As Integer) As Integer

   Dim Fila As Long
   Dim Sql  As String

   grabar = False

   'Inicia una Transacción
   If SQL_Execute("BEGIN TRANSACTION") > 0 Then
      grabar = 1
      Exit Function

   End If

   'Elimina todos los items para una tabla
   Sql = "Exec Sp_TcEliminaCodigos1 " & CodTab    'OJO DMV

   If SQL_Execute(Sql) > 0 Then
      If SQL_Execute("ROLLBACK TRANSACTION") > 0 Then
         grabar = 2
         Exit Function

      End If
      Exit Function

   End If
    
   'Graba todos los elementos o miembros de la colección
   For Fila = 1 To coleccion.Count
      If coleccion(Fila).grabar(CodTab) = False Then
         If SQL_Execute("ROLLBACK TRANSACTION") > 0 Then
            grabar = 3
            Exit Function

         End If

      End If

   Next Fila

   'Si no hubo error compromete la transacción
   If SQL_Execute("COMMIT TRANSACTION") > 0 Then
      grabar = 4
      Exit Function
   
   End If
    
   grabar = True

End Function

'Lee todos los codigos de una Tabla
Public Function LeerCodigos(ByVal ncodtab As Integer) As Boolean

   Dim Sql           As String
   Dim objBuffer     As Object
   Dim Datos()

   LeerCodigos = False

   Sql = "EXECUTE sp_mdtcleercodigos " & ncodtab

   If SQL_Execute(Sql) > 0 Then
      Exit Function

   End If

   Call VaciarColeccion

   Do While SQL_Fetch(Datos()) = 0

      Set objBuffer = New clsCodigo

      With objBuffer
         .codigo = Val(Datos(1))
         .Glosa = Trim$(Datos(2))

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
         IdGlosa = coleccion(Filas).Glosa
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
         .Col = 1: .Text = Mid$(coleccion(Filas).Glosa, 126, 3)
         .Col = 2: .Text = Mid$(coleccion(Filas).Glosa, 1, 25)

      Next Filas

   End With

End Sub

'Lee las tablas fijas del sistema
Public Function LeerTablas() As Boolean

   Dim Sql           As String
   Dim objBuffer     As Object
   Dim Datos()

   LeerTablas = False
    
   Sql = "EXECUTE sp_mdtbleer"
    
   If SQL_Execute(Sql) > 0 Then
      Exit Function

   End If
          
   Call VaciarColeccion
             
   Do While SQL_Fetch(Datos()) = 0
      Set objBuffer = New clscodtab
      
      With objBuffer
         .codigo = Val(Datos(1))
         .Glosa = Trim$(Datos(2))

      End With

      coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop

   LeerTablas = True

End Function

Function LeerEntidad()
   Dim Sql           As String
   Dim objBuffer     As Object
   Dim Datos()

   LeerEntidad = False

   Sql = "EXECUTE sp_leerEntidad " ' & ncodtab

   If SQL_Execute(Sql) > 0 Then
      Exit Function

   End If

   Call VaciarColeccion

   Do While SQL_Fetch(Datos()) = 0

      Set objBuffer = New clsCodigo

      With objBuffer
         .codigo = Val(Datos(2))
         .Glosa = Trim$(Datos(1))

      End With

      coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop

   LeerEntidad = True

End Function

