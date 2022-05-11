VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clscodtabs"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public objcodtab   As Object
Public coleccion  As New Collection

Public Function CargarGrid(oControl As Object) As Boolean

   Dim imax    As Integer
   Dim iLin    As Integer
   
   CargarGrid = False

   imax = coleccion.Count

   With oControl
      .Rows = 1

      For iLin = 1 To imax

         .Rows = .Rows + 1
         .Row = .Rows - 1
        '.Col = 0: .Text = coleccion(iLin).CodMda
         .Col = 1: .Text = coleccion(iLin).codigo
         .Col = 2: .Text = coleccion(iLin).glosa
         CargarGrid = True
      Next iLin

   
   End With
  ' CargarGrid = imax
   
End Function


Public Function RefrescaTbl(oControl As Object)

   Dim objBuffer  As Object
   Dim iLin       As Integer
   Dim imax       As Integer
   Dim Rut        As String
   
   Call LimpiarTodosTbl
   
   RefrescaTbl = False
   
   imax = oControl.Rows - 1

   With oControl
      
      For iLin = 1 To imax
      
         .Row = iLin
      
         Set objBuffer = New clsCodTab
         
         .Col = 1
         If .Text <> "" Then
                        
            .Col = 1: objBuffer.codigo = .Text
            .Col = 2: objBuffer.glosa = .Text
      
            coleccion.Add objBuffer
         
            Set objBuffer = Nothing
         
         End If
         
      Next iLin
      
      RefrescaTbl = True
      
   End With
   
End Function

Public Sub LimpiarTodosTbl()

   Dim iLin       As Integer
   Dim imax       As Integer

   imax = coleccion.Count

   For iLin = imax To 1 Step -1

      coleccion.Remove iLin

   Next iLin

End Sub


Public Function Grabar(CodTab As Integer) As Integer

   Dim Fila As Long
   Dim Sql  As String
    
   Grabar = False
                
   'Inicia una Transacción
   

   If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
      Grabar = 1
      Exit Function
    
   End If

   'Graba todos los elementos o miembros de la colección
   For Fila = 1 To coleccion.Count

      If coleccion(Fila).Grabar(CodTab) = False Then

         

         If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
            Grabar = 3
            Exit Function

         End If

      End If

   Next Fila

   'Si no hubo error compromete la transacción
   

   If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
      Grabar = 4
      Exit Function

   End If

   Grabar = True

End Function

Public Sub Coleccion2Control(objControl As Object)

   Dim Filas      As Long
   Dim IdGlosa    As String * 25
   Dim Max        As Long
          
   With objControl
      objControl.Clear 'borra los datos del combo

      Max = coleccion.Count

      For Filas = 1 To Max
         IdGlosa = coleccion(Filas).glosa
         .AddItem IdGlosa
         .ItemData(.NewIndex) = coleccion(Filas).codigo

      Next Filas

   End With

End Sub

'Lee todos los codigos de una Tabla
Public Function LeerCodigos(ByVal ncodtab As Integer) As Boolean

   Dim Sql        As String
   Dim objBuffer  As Object
   Dim Datos()

   LeerCodigos = False
   Envia = Array()
   AddParam Envia, ncodtab

   If Not Bac_Sql_Execute("sp_mdtcleercodi ", Envia) Then
      Exit Function

   End If
     
   Call VaciarColeccion
   
   Do While Bac_SQL_Fetch(Datos())
      
                            
      Set objBuffer = New clsCodTab
      
      With objBuffer
         .codigo = Val(Datos(1))
         .glosa = Trim$(Datos(2))

      End With

      coleccion.Add objBuffer

      Set objBuffer = Nothing
   
   Loop

   LeerCodigos = True

End Function

Sub VaciarColeccion()

   Dim Filas As Long
   Dim Max   As Long

   Max = coleccion.Count
   For Filas = 1 To Max
      coleccion.Remove 1

   Next Filas

End Sub

