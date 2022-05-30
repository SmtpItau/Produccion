VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clscodtabs"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public objcodtab   As Object
Public Coleccion  As New Collection

Public Function CargarGrid(oControl As Object) As Boolean

   Dim imax    As Integer
   Dim iLin    As Integer
   
   CargarGrid = False

   imax = Coleccion.Count

   With oControl
      .Rows = 1

      For iLin = 1 To imax

         .Rows = .Rows + 1
         .Row = .Rows - 1
        '.Col = 0: .Text = coleccion(iLin).CodMda
         .Col = 1: .Text = Coleccion(iLin).codigo
         .Col = 2: .Text = Coleccion(iLin).Glosa
         CargarGrid = True
      Next iLin

   
   End With
  ' CargarGrid = imax
   
End Function


Public Function RefrescaTbl(oControl As Object)

   Dim objBuffer  As Object
   Dim iLin       As Integer
   Dim imax       As Integer
   Dim rut        As String
   
   Call LimpiarTodosTbl
   
   RefrescaTbl = False
   
   imax = oControl.Rows - 1

   With oControl
      
      For iLin = 1 To imax
      
         .Row = iLin
      
         Set objBuffer = New clscodtab
         
         .Col = 1
         If .Text <> "" Then
                        
            .Col = 1: objBuffer.codigo = .Text
            .Col = 2: objBuffer.Glosa = .Text
      
            Coleccion.Add objBuffer
         
            Set objBuffer = Nothing
         
         End If
         
      Next iLin
      
      RefrescaTbl = True
      
   End With
   
End Function

Public Sub LimpiarTodosTbl()

   Dim iLin       As Integer
   Dim imax       As Integer

   imax = Coleccion.Count

   For iLin = imax To 1 Step -1

      Coleccion.Remove iLin

   Next iLin

End Sub

Public Function LeerOperadores() As Boolean

   Dim SQL           As String
   Dim objBuffer     As Object
   Dim Datos()

   LeerOperadores = False

   SQL = "execute sp_prleercartera "
'   Sql = Sql + "'" + cCodcart + "'"
          
   If SQL_Execute(SQL) > 0 Then
      Exit Function

   End If

   Call VaciarColeccion

   Do While SQL_Fetch(Datos()) = 0

      Set objBuffer = New ClsMFPR

      With objBuffer
         .prcartera = Datos(1)
         .prcodmon1 = Datos(2)
         .prcodmon2 = Datos(3)
         .prglosa = Datos(4)
         .prdecpr = Val(Datos(5))
         .prdectc = Val(Datos(6))
         .prbase = Val(Datos(7))
         .prtippr = Datos(8)
         .prtipmod = Datos(9)
         .prprmmon1 = Datos(10)
         .prprmmon2 = Datos(11)
         .prprogcal = Datos(12)
         .prprogdev = Datos(13)

      End With

      Coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop

   LeerOperadores = True

End Function

Public Function grabar(CodTab As Integer) As Integer

   Dim Fila As Long
   Dim SQL  As String
    
   grabar = False
                
   'Inicia una Transacción
   SQL = "BEGIN TRANSACTION"

   If SQL_Execute(SQL) > 0 Then
      grabar = 1
      Exit Function
    
   End If

   'Graba todos los elementos o miembros de la colección
   For Fila = 1 To Coleccion.Count

      If Coleccion(Fila).grabar(CodTab) = False Then

         SQL = "ROLLBACK TRANSACTION"

         If SQL_Execute(SQL) > 0 Then
            grabar = 3
            Exit Function

         End If

      End If

   Next Fila

   'Si no hubo error compromete la transacción
   SQL = "COMMIT TRANSACTION"

   If SQL_Execute(SQL) > 0 Then
      grabar = 4
      Exit Function

   End If

   grabar = True

End Function

Public Sub Coleccion2Control(objControl As Object)

   Dim Filas      As Long
   Dim IdGlosa    As String * 25
   Dim Max        As Long
          
   With objControl
      objControl.Clear 'borra los datos del combo

      Max = Coleccion.Count

      For Filas = 1 To Max
         IdGlosa = Coleccion(Filas).Glosa
         .AddItem IdGlosa
         .ItemData(.NewIndex) = Coleccion(Filas).codigo

      Next Filas

   End With

End Sub

'Lee todos los codigos de una Tabla
Public Function LeerCodigos(ByVal ncodtab As Integer) As Boolean

   Dim SQL        As String
   Dim objBuffer  As Object
   Dim Datos()

   LeerCodigos = False

   SQL = "EXECUTE sp_mdtcleercodigos " & ncodtab

   If SQL_Execute(SQL) > 0 Then
      Exit Function

   End If
     
   Call VaciarColeccion
              
   Do While SQL_Fetch(Datos()) = 0
                
      Set objBuffer = New clscodtab

      With objBuffer
         .codigo = Val(Datos(1))
         .Glosa = Trim$(Datos(2))

      End With

      Coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop

   LeerCodigos = True

End Function

'Lee las tablas fijas del sistema
Public Function LeerTablas() As Boolean

   Dim SQL           As String
   Dim objBuffer     As Object
   Dim Datos()

   LeerTablas = False

   SQL = "EXECUTE sp_mdtbleer"

   If SQL_Execute(SQL) > 0 Then
      Exit Function

   End If

   Call VaciarColeccion

   Do While SQL_Fetch(Datos()) = 0

      Set objBuffer = New clscodtab

      With objBuffer
         .codigo = Val(Datos(1))
         .Glosa = Trim$(Datos(2))

      End With

      Coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop

   LeerTablas = True

End Function

Sub VaciarColeccion()

   Dim Filas As Long
   Dim Max   As Long

   Max = Coleccion.Count
   For Filas = 1 To Max
      Coleccion.Remove 1

   Next Filas

End Sub

