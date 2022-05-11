VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCarte"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public ObjCartera  As Object
Public coleccion  As New Collection

'MFCAR : TABLA DE TIPO DE CARTERA
'--------------------------------
Public rccodpro             As Integer
Public rcrut                As String
Public rcnombre             As String
Public rcClasifQh           As String


Public Function EliminarCar(iCodProducto As Variant, idSistema As Variant, nCodigo As String, xCodProducto As Variant) As Boolean
   Dim Sql  As String
   Dim imax As Integer
   Dim iLin As Integer

   EliminarCar = True
   Envia = Array()
   AddParam Envia, iCodProducto
   AddParam Envia, idSistema
   AddParam Envia, nCodigo
   AddParam Envia, xCodProducto
   If Not BAC_SQL_EXECUTE("Sp_mdrceliminacar ", Envia) Then
      MsgBox "Error en la eliminacion", vbCritical
      EliminarCar = False
         
   End If

   Call LimpiarTodos

End Function


Public Function GrabarCar(iCodProducto As Integer) As Boolean

   Dim Fila       As Long
   Dim Sql        As String

   GrabarCar = False
   Envia = Array()
   AddParam Envia, iCodProducto
   AddParam Envia, rcrut
   AddParam Envia, rcnombre
   

   If Not BAC_SQL_EXECUTE("sp_mdrcgrabar ", Envia) Then
      Exit Function

   End If

   GrabarCar = True

End Function


Public Function ProGrabarCar(iCodProducto As Integer) As Boolean

   Dim Fila       As Long
   Dim Sql        As String
   Dim grabar     As Integer
    
   ProGrabarCar = False
    
   'Inicia una Transacción
   

   If Not BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then
      grabar = 1
      Exit Function

   End If
    
   'Graba todos los elementos o miembros de la colección
   For Fila = 1 To coleccion.Count

      If coleccion(Fila).GrabarCar(iCodProducto) = False Then

         

         If Not BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
            grabar = 3
            Exit Function

         End If

      End If

   Next Fila

   'Si no hubo error compromete la transacción
   

   If Not BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then
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
   Dim Rut        As String
   Call LimpiarTodos
   
   RefrescaCar = False
   
   imax = oControl.Rows - 1

   With oControl
      
      For iLin = 1 To imax

         .Row = iLin

         Set objBuffer = New clsCarte
         
         .Col = 1
         If .Text <> "" Then
            
            .Col = 1: objBuffer.rcrut = .Text
            .Col = 2: objBuffer.rcnombre = .Text
      

            coleccion.Add objBuffer

            Set objBuffer = Nothing
         
         End If

      Next iLin
      
      RefrescaCar = True
      
   End With

End Function


Public Function LeerCarProducto(iCodProducto, idSistema As Variant, ISubproducto)

   Dim objBuffer     As Object
   Dim Sql           As String
   Dim Datos()

   LeerCarProducto = False
   
   Call LimpiarTodos
   ' esta mdrc es de futuro por tipo de cartere
   ' la otra mdrc es de trader por entidad
   Dim Aux As String
   Aux = BACMNTCR.cmbtablacartera.Text
   Envia = Array()
   AddParam Envia, iCodProducto
   AddParam Envia, idSistema
   AddParam Envia, ISubproducto

   If Not BAC_SQL_EXECUTE("sp_mdrcleercodigo ", Envia) Then
      Exit Function
   End If
   
   Do While BAC_SQL_FETCH(Datos())
   
      Set objBuffer = New clsCarte

      objBuffer.rcrut = Datos(1)
      objBuffer.rcnombre = Datos(2)
      objBuffer.rcClasifQh = Datos(3)
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


Public Function Control2Combo(oControl As Object) As Boolean

   Dim imax    As Integer
   Dim iLin    As Integer

   Control2Combo = False

   imax = coleccion.Count

   oControl.Clear

   With oControl

      For iLin = 1 To imax
         .AddItem coleccion(iLin).rcnombre
         .ItemData(.NewIndex) = coleccion(iLin).rcrut

         Control2Combo = True

      Next iLin

   End With

End Function

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
        
         .Col = 1: .Text = coleccion(iLin).rcrut
         .Col = 2: .Text = coleccion(iLin).rcnombre
         .Col = 3: .Text = coleccion(iLin).rcClasifQh
         CargarGrid = True
      
      Next iLin

   
   End With
 
   
End Function

