VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsCarte"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Option Explicit

Public objcartera  As Object
Public coleccion  As New Collection

'MFCAR : TABLA DE TIPO DE CARTERA
'--------------------------------
Public rccodpro             As Integer
Public rcrut                As Long
Public rcdv                 As String
Public rcnombre             As String

Public Function EliminarCar(icodproducto As Integer) As Boolean
   Dim SQL  As String
   Dim imax As Integer
   Dim iLin As Integer

   EliminarCar = True
   
   SQL = "Exec Sp_rceliminacar " & icodproducto

   If SQL_Execute(SQL) <> 0 Then
      MsgBox "Error en la eliminacion", vbCritical, "MENSAJE"
      EliminarCar = False
         
   End If

   Call LimpiarTodos

End Function


Public Function GrabarCar(icodproducto As Integer) As Boolean
   Dim Fila       As Long
   Dim SQL        As String
    
   GrabarCar = False
   
   SQL = "EXEC sp_rcgrabarcar  " & Chr(10)
   SQL = SQL & icodproducto & "," & Chr(10)
   SQL = SQL & rcrut & "," & Chr(10)
   SQL = SQL & "'" & rcdv & "'," & Chr(10)
   SQL = SQL & "'" & rcnombre & "'"
    
    
   If SQL_Execute(SQL) <> 0 Then
      Exit Function
   
   End If
    
   GrabarCar = True

End Function


Public Function ProGrabarCar(icodproducto As Integer) As Boolean

   Dim Fila       As Long
   Dim SQL        As String
   Dim grabar     As Integer
    
   ProGrabarCar = False
    
   'Inicia una Transacción
   SQL = "BEGIN TRANSACTION"

   If SQL_Execute(SQL) <> 0 Then
      grabar = 1
      Exit Function
   End If
    
   'Elimina todos los items para una tabla
   SQL = "Exec Sp_rceliminacar " & icodproducto

   If SQL_Execute(SQL) <> 0 Then

      SQL = "ROLLBACK TRANSACTION"

      If SQL_Execute(SQL) <> 0 Then
         grabar = 2
         Exit Function

      End If

      Exit Function

   End If
    
   'Graba todos los elementos o miembros de la colección
   For Fila = 1 To coleccion.Count

      If coleccion(Fila).GrabarCar(icodproducto) = False Then

         SQL = "ROLLBACK TRANSACTION"

         If SQL_Execute(SQL) <> 0 Then
            grabar = 3
            Exit Function

         End If

      End If

   Next Fila

   'Si no hubo error compromete la transacción
   SQL = "COMMIT TRANSACTION"

   If SQL_Execute(SQL) <> 0 Then
      grabar = 4
      Exit Function
   
   End If
     
   ProGrabarCar = True

End Function


Public Function RefrescaCar(oControl As Object)
'iCodProducto As Integer,

   Dim objBuffer  As Object
   Dim iLin       As Integer
   Dim imax       As Integer
   Dim rut        As String
   Call LimpiarTodos
   
   RefrescaCar = False
   
   imax = oControl.Rows - 1

   With oControl
      
      For iLin = 1 To imax

         .Row = iLin

         Set objBuffer = New clsCarte
         
        ' objBuffer.rccodpro = iCodProducto
         .Col = 1
         If .Text <> "" Then
            
            .Col = 1: objBuffer.rcrut = Mid$(.Text, 1, InStr(1, .Text, "-") - 1)
                      objBuffer.rcdv = Mid$(.Text, (InStr(1, .Text, "-") + 1), 1)
            .Col = 2: objBuffer.rcnombre = .Text
      

            coleccion.Add objBuffer

            Set objBuffer = Nothing
         
         End If

      Next iLin
      
      RefrescaCar = True
      
   End With

End Function



Public Function LeerCarProducto(icodproducto As Integer)

   Dim objBuffer     As Object
   Dim SQL           As String
   Dim Datos()

   LeerCarProducto = False
   
   SQL = "EXECUTE sp_rcleerfwd " & icodproducto

   If SQL_Execute(SQL) <> 0 Then
      Exit Function
   End If
   
   Do While SQL_Fetch(Datos()) = 0
   
      Set objBuffer = New clsCarte

      objBuffer.rcrut = Val(Datos(1))
      objBuffer.rcdv = Datos(2)
      objBuffer.rcnombre = Datos(3)

      coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop
   
   LeerCarProducto = True
   
End Function


Public Sub LimpiarTodos()

   Dim iLin       As Integer
   Dim imax       As Integer

   imax = coleccion.Count

   For iLin = imax To 1 Step -1

      coleccion.Remove iLin

   Next iLin

End Sub


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
        
         .Col = 1: .Text = coleccion(iLin).rcrut & "-" & coleccion(iLin).rcdv
         .Col = 2: .Text = coleccion(iLin).rcnombre
         CargarGrid = True
      
      Next iLin

   
   End With
 
   
End Function




