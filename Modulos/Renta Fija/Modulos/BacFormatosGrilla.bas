Attribute VB_Name = "BacFormatosGrilla"
Option Explicit
   Global Const Cafe = &H40&
   Global Const Blanco = &HFFFFFF
   Global Const Verde = &H808000
   Global Const Gris = &H80000004
   Global Const Azul = &HFF0000
   Global Const Celeste = &HFFFF00
   Global Const Plomo = &H808080
   Global Const AzulOsc = &H800000
   Global Const Rojo = &HFF&
   Global gsNumVentana
   Global Negro As String

Enum DvpCp
   [Si] = 1
   [No] = 0
End Enum



Public Function LenArray(Arreglo() As Variant) As Integer
On Error GoTo ErrorArreglo
   Dim x, A       As Integer

   Do While True
      A = Arreglo(x)
      x = x + 1
   Loop
ErrorArreglo:
   LenArray = x
End Function

'Public Sub PosicionarTexto(Grilla As Control, Texto As Control)
'    Texto.Top = Grilla.CellTop + Grilla.Top + 10
'    Texto.Left = Grilla.CellLeft + Grilla.Left + 10
'    Texto.Width = Grilla.CellWidth - 40
'    Texto.Height = Grilla.CellHeight - 40
'End Sub
'Sub PROC_POSI_TEXTO(Grilla As Control, Texto As Control)
' '  SE ESTA AUTILIZANDO EN PROCESO DE INICIO DE DIA
'    Texto.Top = Grilla.CellTop + Grilla.Top + 20
'    Texto.Left = Grilla.CellLeft + Grilla.Left + 20
'    Texto.Height = Grilla.CellHeight - 30
'    Texto.Width = Grilla.CellWidth - 30
'End Sub
Function FX_Operaciones_Seleccionada(Grid As MSFlexGrid) As Boolean
   Dim Cont%, c%
   
   FX_Operaciones_Seleccionada = False

   For c = 1 To Grid.Rows - 1
      Grid.Redraw = False
      Grid.Row = c
      If Grid.CellForeColor = Blanco Then
         Cont = Cont + 1
      End If
      Grid.Redraw = True
   Next c

   If Cont > 1 Then
      MsgBox "¡ Tiene más de una Operación Seleccionada !", vbExclamation, TITSISTEMA
   ElseIf Cont = 0 Then
      MsgBox "¡ Debe Seleccionar al menos una Operación !", vbExclamation, TITSISTEMA
   ElseIf Cont = 1 Then
      FX_Operaciones_Seleccionada = True
   End If

End Function
Public Function LargoArreglo(A) As Integer
On Error GoTo ErrorArray
   Dim x As Integer
   x = 0
   Do While True
      If IsNumeric(A(x)) Then
      
      End If
      x = x + 1
   Loop
ErrorArray:
   LargoArreglo = x
End Function


Function Formato_Grilla(Grilla As MSFlexGrid)
   Dim x       As Integer
   With Grilla
      .ForeColorSel = Azul
      .ForeColor = AzulOsc
      .Gridlines = flexGridInset
      .GridLinesFixed = flexGridNone
      .ForeColorFixed = Blanco
      .BackColorFixed = Verde
      .BackColor = Gris
      .BackColorSel = AzulOsc
      .BackColorBkg = Gris 'PLOMO
      .Font.bold = False
      .ForeColorSel = Blanco
   End With
End Function
Function Centrar_Titulos(Grilla As MSFlexGrid)
Dim x, Y As Integer

With Grilla
      'Centrar Titulos
   If .FixedRows = 2 Then
      For x = 0 To .Cols - 1
         .Row = 0
         .Col = x
         .CellAlignment = 4
      Next x
   ElseIf .FixedRows = 1 Then
      For Y = 1 To 1
         .Row = Y - 1
         For x = 0 To .Cols - 1
            .Col = x
            .CellAlignment = 4
         Next x
      Next Y
   End If
End With

End Function
Function Ancho_Filas(Grilla As MSFlexGrid)
   Dim x%
   With Grilla
      .Redraw = False
      For x = 0 To .Rows - 1
         If x = 0 Then
            .RowHeight(x) = 315
         Else
            .RowHeight(x) = 315
         End If
      Next x
      .Redraw = True
      .RowHeight(.Rows - 1) = 0
   End With
End Function
Function IcoForm(FORMULARIO As Form)
   With FORMULARIO
      .Icon = LoadPicture(App.Path & "\BAC.ICO")
   End With
End Function
Function Cargar_Imagenes(Tool As Toolbar, ImageList As ImageList)
'
'  Esta funcion carga imagenes a un ImageList y a una toolbar
'
Dim ImgX As ListImage

With Tool

       .ButtonHeight = 22: .ButtonWidth = 22
    Set ImgX = ImageList.ListImages.Add(, "Bac", LoadPicture(App.Path + "\Img\Bac_n.ico"))
    Set ImgX = ImageList.ListImages.Add(, "Devenga", LoadPicture(App.Path + "\Img\Devengar.ico"))
    Set ImgX = ImageList.ListImages.Add(, "Archivo", LoadPicture(App.Path + "\Img\Field.ico"))
       Tool.ImageList = ImageList
    
    Dim btnX As Button
    
    Tool.Buttons.Add , , , tbrSeparator
      
      Set btnX = Tool.Buttons.Add(, "Bac", , tbrDefault, "Bac")
    btnX.ToolTipText = "BacSistemas"
    btnX.Description = btnX.ToolTipText
      Set btnX = Tool.Buttons.Add(, "Devenga", , tbrDefault, "Devenga")
    btnX.ToolTipText = "Devengamiento"
    btnX.Description = btnX.ToolTipText
      Set btnX = Tool.Buttons.Add(, "Archivo", , tbrDefault, "Archivo")
    btnX.ToolTipText = "Abrir Archivo"
    btnX.Description = btnX.ToolTipText
    
End With
End Function

Sub IntraDay_Marca_Operacion(Grid As MSFlexGrid, Fila As Integer, Caja As String, Letra As String)
   Dim c As Integer
With Grid
   .Redraw = False
   For c = 0 To .Cols - 1
      .Row = Fila
      .Col = c
      .CellBackColor = Val(Caja)
      .CellForeColor = Val(Letra)
   Next
   .Redraw = True
End With
End Sub
Sub IntraDay_Formato(Grilla As MSFlexGrid)
With Grilla
   
   .Clear
   .Rows = 3:   .Cols = 8
   .FixedRows = 2:   .FixedCols = 0
   .RowHeight(0) = 315:   .RowHeight(1) = 315
   
   .ColWidth(0) = 1000
   .ColWidth(1) = 1000
   .ColWidth(2) = 1000
   .ColWidth(3) = 1500
   .ColWidth(4) = 2000
   .ColWidth(5) = 2000
   .ColWidth(6) = 0
   .ColWidth(7) = 0
   
   .TextMatrix(0, 0) = "Numero     ":  .TextMatrix(1, 0) = "Operación"
   .TextMatrix(0, 1) = "Tipo       ":  .TextMatrix(1, 1) = "Operación"
   .TextMatrix(0, 2) = "Nombre     ":  .TextMatrix(1, 2) = "Cliente"
   .TextMatrix(0, 3) = "Precio     ":  .TextMatrix(1, 3) = "Operación"
   .TextMatrix(0, 4) = "Monto  USD ":  .TextMatrix(1, 4) = "Operación"
   .TextMatrix(0, 5) = "Monto CLP  ":  .TextMatrix(1, 5) = "Operación"
   .TextMatrix(0, 6) = "Estado     ":  .TextMatrix(1, 6) = "Operación"
   .TextMatrix(0, 7) = "Marcado    ":  .TextMatrix(1, 7) = ""
    
End With
End Sub

Function Agrega_Quita_CV(Grid_Orig As MSFlexGrid, F As Integer, Grid_Dest As MSFlexGrid, Agrega As Boolean)
   Dim x%
If Agrega = True Then
   Grid_Dest.Rows = Grid_Dest.Rows + 1
   Grid_Dest.TextMatrix(Grid_Dest.Rows - 2, 0) = Grid_Orig.TextMatrix(F, 0) 'Numero Operacion
   Grid_Dest.TextMatrix(Grid_Dest.Rows - 2, 1) = Grid_Orig.TextMatrix(F, 4) 'Nombre Cliente
   Grid_Dest.TextMatrix(Grid_Dest.Rows - 2, 2) = 0
   Grid_Dest.TextMatrix(Grid_Dest.Rows - 2, 3) = 0
   Grid_Dest.RowHeight(Grid_Dest.Rows - 2) = 315
   
ElseIf Agrega = False Then
   
   For x = 2 To Grid_Dest.Rows - 2
      If Grid_Dest.TextMatrix(x, 0) = Grid_Orig.TextMatrix(F, 0) Then
         Grid_Dest.RemoveItem (x)
      End If
   Next x
   
End If
End Function


Sub Intraday_Formato_X(Grid As MSFlexGrid)
   With Grid
      .Rows = 3:   .Cols = 1
      .FixedRows = 2:   .FixedCols = 0
      .TextMatrix(0, 0) = "Ocupado":   .TextMatrix(1, 0) = "Por"
      .RowHeight(0) = 250:   .RowHeight(0) = 250
      .Rows = 2:   .Row = 1
      '.SetFocus
   End With
End Sub

Public Function LeerArchivoTexto() As String
   Dim MiCadena, MiNúmero
   
   Open "PRUEBA" For Input As #1 ' Abre el archivo para recibir los datos.
   
   Do While Not EOF(1)  ' Repite el bucle hasta el final del archivo.
      Input #1, MiCadena, MiNúmero  ' Lee el carácter en dos variables.
    
   Loop
   
   Close #1 ' Cierra el archivo.
End Function

Sub MeTamaño(obj As Form)
   obj.Top = 0
   obj.Left = 0
   obj.Height = 5145
   obj.Width = 8275
End Sub


Function Valoriza() As Boolean
   
'   Valoriza = False
'
'   MsgBox "Faltan Posiciones de Monedas"
'   If Not Bac_Sql_Execute("Sp_Valorizacion_Poscam", Format(gsBAC_Fecp, feFECHA)) Then
'
'   End If
'
'   If Not Bac_SQL_Fetch(Datos()) Then
'
'   End If
'   Valoriza = True
'
End Function
