VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsProductos"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public coleccion     As New Collection


Public Function ActualizaMdaProducto(iCodProducto As Integer, oControl As Object)

   Dim objBuffer  As Object
   Dim iLin       As Integer
   Dim imax       As Integer
   
   Call LimpiarTodos

   imax = oControl.Rows - 1

   With oControl
      
      For iLin = 1 To imax

         .Row = iLin

         Set objBuffer = New clsProducto
         
         objBuffer.CodProd = iCodProducto

         .Col = 0: objBuffer.CodMda = Val(.Text)
         .Col = 2: objBuffer.Glosa = .Text
         .Col = 1: objBuffer.Estado = IIf(.Text = "X", "1", "0")

         coleccion.Add objBuffer

         Set objBuffer = Nothing

      Next iLin

   End With

End Function

Public Function CargarGrid(oControl As Object)

   Dim imax    As Integer
   Dim iLin    As Integer

   imax = coleccion.Count

   With oControl
      .Rows = 1

      For iLin = 1 To imax

         .Rows = .Rows + 1
         .Row = .Rows - 1
         .Col = 0: .Text = coleccion(iLin).CodMda
         .Col = 1: .Text = IIf(coleccion(iLin).Estado = "1", "X", " ")
         .Col = 2: .Text = coleccion(iLin).Glosa

      Next iLin

   End With

End Function

Public Function CargarCombo(oControl As Object)

   Dim imax    As Integer
   Dim iLin    As Integer

   imax = coleccion.Count

   With oControl
      For iLin = 1 To imax
         If coleccion(iLin).Estado = "1" Then
            .AddItem coleccion(iLin).Glosa
            .ItemData(.NewIndex) = coleccion(iLin).CodMda

         End If

      Next iLin

   End With

End Function

Public Function EliminarMdaProducto(iCodProducto As Integer) As Boolean

   Dim Sql  As String
   Dim imax As Integer
   Dim iLin As Integer

   EliminarMdaProducto = True

   Sql = "EXECUTE sp_mdmpeliminar " & iCodProducto

   If SQL_Execute(Sql) > 0 Then
      MsgBox "Error en la grabación", vbCritical, "MENSAJE"
      EliminarMdaProducto = False
         
   End If

   Call LimpiarTodos

End Function

Public Function GrabarMdaProducto() As Boolean

   Dim Sql  As String
   Dim imax As Integer
   Dim iLin As Integer

   GrabarMdaProducto = True

   imax = coleccion.Count

   For iLin = 1 To imax

      Sql = "EXECUTE sp_mdmpgrabar "
      Sql = Sql & coleccion(iLin).CodProd & ","
      Sql = Sql & coleccion(iLin).CodMda & ","
      Sql = Sql & "'" & coleccion(iLin).Estado & "'"

      If SQL_Execute(Sql) > 0 Then
         MsgBox "Error en la grabación", vbCritical, "MENSAJE"
         GrabarMdaProducto = False
         Exit For
         
      End If

   Next iLin

   Call LimpiarTodos

End Function

Public Function LeerMdaProducto(iCodProducto As Integer)

   Dim objBuffer     As Object
   Dim Sql           As String
   Dim Datos()

   Sql = "EXECUTE sp_mdmpleer " & iCodProducto

   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer las monedas por producto", vbCritical, "MENSAJE"
      Exit Function
   
   End If
   
   Do While SQL_Fetch(Datos()) = 0
   
      Set objBuffer = New clsProducto

      objBuffer.CodProd = iCodProducto
      objBuffer.CodMda = Val(Datos(1))
      objBuffer.Glosa = Datos(2)
      objBuffer.Estado = IIf(iCodProducto = 0, "1", Datos(3))

      coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop

End Function

Public Sub LimpiarTodos()

   Dim iLin       As Integer
   Dim imax       As Integer

   imax = coleccion.Count

   For iLin = imax To 1 Step -1

      coleccion.Remove iLin

   Next iLin

End Sub
