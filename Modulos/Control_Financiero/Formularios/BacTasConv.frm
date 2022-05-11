VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacTasConv 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Tasas Maximas Convencionales"
   ClientHeight    =   3825
   ClientLeft      =   1665
   ClientTop       =   1785
   ClientWidth     =   10470
   Icon            =   "BacTasConv.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3825
   ScaleWidth      =   10470
   Begin MSFlexGridLib.MSFlexGrid GrillaTmp_X 
      Height          =   2100
      Left            =   3510
      TabIndex        =   9
      Top             =   1530
      Visible         =   0   'False
      Width           =   3420
      _ExtentX        =   6033
      _ExtentY        =   3704
      _Version        =   393216
      Cols            =   1
      FixedCols       =   0
      BackColorBkg    =   -2147483645
   End
   Begin BACControles.TXTNumero txtBacNumero 
      Height          =   375
      Left            =   120
      TabIndex        =   8
      Top             =   3000
      Visible         =   0   'False
      Width           =   2655
      _ExtentX        =   4683
      _ExtentY        =   661
      BackColor       =   16777215
      ForeColor       =   8388608
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Text            =   "0,0000"
      Text            =   "0,0000"
      Min             =   "0"
      Max             =   "9999999999999"
      CantidadDecimales=   "4"
      MarcaTexto      =   -1  'True
   End
   Begin BACControles.TXTNumero txtBacNumero1 
      Height          =   390
      Left            =   120
      TabIndex        =   7
      Top             =   2595
      Visible         =   0   'False
      Width           =   2655
      _ExtentX        =   4683
      _ExtentY        =   688
      BackColor       =   16777215
      ForeColor       =   8388608
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Text            =   "0"
      Text            =   "0"
      Min             =   "0"
      Max             =   "9999"
      MarcaTexto      =   -1  'True
   End
   Begin VB.Frame Frame1 
      Height          =   780
      Left            =   15
      TabIndex        =   2
      Top             =   510
      Width           =   10440    
      Begin VB.ComboBox cmb_Moneda 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   2070
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   270
         Width           =   4185
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   675
         TabIndex        =   3
         Top             =   315
         Width           =   690
      End
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   2145
      Left            =   75
      TabIndex        =   1
      ToolTipText     =   "Presione Enter para Modificar una Celda o Presione con el Mouse un DobleClick"
      Top             =   1500
      Width           =   10320
      _ExtentX        =   18203
      _ExtentY        =   3784
      _Version        =   393216
      Rows            =   3
      FixedRows       =   2
      RowHeightMin    =   315
      BackColor       =   -2147483644
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorSel    =   8388608
      ForeColorSel    =   16777215
      BackColorBkg    =   -2147483645
      GridColor       =   16777215
      GridColorFixed  =   16777215
      FocusRect       =   0
      GridLines       =   2
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   10470
      _ExtentX        =   18468
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   7
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "guardar"
            Object.ToolTipText     =   "Grabar"
            Object.Tag             =   "1"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Buscar"
            Object.Tag             =   "2"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            Object.Tag             =   "3"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpia"
            Object.Tag             =   "4"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir por pantalla"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir directo impresora"
            Object.Tag             =   "5"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   "6"
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
      OLEDropMode     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3600
         Top             =   -45
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   7
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTasConv.frx":030A
               Key             =   "Guardar"
               Object.Tag             =   "1"
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTasConv.frx":075C
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTasConv.frx":0A78
               Key             =   "Buscar"
               Object.Tag             =   "2"
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTasConv.frx":0ECA
               Key             =   "Eliminar"
               Object.Tag             =   "3"
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTasConv.frx":131C
               Key             =   "Limpiar"
               Object.Tag             =   "4"
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTasConv.frx":1636
               Key             =   "Salir"
               Object.Tag             =   "5"
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTasConv.frx":1950
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame2 
      Height          =   2415
      Left            =   15
      TabIndex        =   4
      Top             =   1305
      Width           =   10440
      Begin VB.TextBox Text1 
         Height          =   285
         Left            =   510
         TabIndex        =   6
         Text            =   "Text1"
         Top             =   300
         Width           =   1635
      End
   End
End
Attribute VB_Name = "BacTasConv"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Msg, Col, KEYCODE, KeyAscii
Dim SwG As Integer
Const MSG1 = "Número: "
Dim i As Long
Dim PosGrilla As Long
Dim Monto As Variant
Dim Okey As Integer
Dim V1 As String, V2 As String, V3 As String
Dim V4 As String, V5 As String, V6 As String
Dim Modif As Boolean, Chao As Boolean
Dim ValoresNuevos As String
Dim ValoresAntiguos As String
Dim colpress As Integer
Dim rowpress As Integer

Sub Validar_Dias_Desde()
    
    On Error GoTo Detectar_Error
    Dim xx, j, z, Cont
    
    Cont = Grid.Rows - 2
    
    For z = 2 To Grid.Rows - 2
        i = 0
        xx = Grid.TextMatrix(z + i, 1)
        
        For i = 1 To Cont
            If i <> Cont Then
                
            End If
        Next i
        
        Cont = Cont - 1
    
    Next z
    
    Exit Sub

Detectar_Error:
    MsgBox Err.Description, 16, TITSISTEMA

End Sub
'Valida textos en blanco
Function Textos_en_Blanco() As Integer
    On Error GoTo Detectar_Error
    
    Dim Y As Integer, G As Integer, k As Integer
    Y = Grid.Rows - 1
    Textos_en_Blanco = 0
    
    For k = 1 To 5
    
        If Grid.TextMatrix(Y, k) = "" Or Grid.TextMatrix(Y, k) = "." Then
            Textos_en_Blanco = 1: Exit Function
        End If
    Next k
    
    Exit Function

Detectar_Error:
    MsgBox Err.Description, 16, TITSISTEMA
End Function

Sub Elimina_Grilla()
    On Error GoTo Detectar_Error
    Dim Cont As Integer
    Dim DATOS()
    Dim Y As Integer
    Cont = 0
    Grid.SetFocus
    If Grid.RowSel = 1 Then Exit Sub 'Aquì se valida que la última fila no fija no se elimine
        If Textos_en_Blanco = 1 Then
            If Grid.Rows > 3 Then
                Grid.RemoveItem (Grid.Row)
                Grid.SetFocus
                Exit Sub
            Else
                Grid.Col = 0
                Grid.Rows = 2
                Grid.Rows = 3
                Grid.Col = 1
                Grid.Row = 2
            End If
        End If
        
        Grid.SetFocus

        If Grid.Rows = 3 Then
            Grid.Rows = 2
            Grid.Rows = 3
        Else
            Grid.RemoveItem (Grid.Row)
        End If

        Grid.SetFocus
    Exit Sub

Detectar_Error:
    MsgBox Err.Description, 16, TITSISTEMA
End Sub
Sub Eliminar_Datos()
    On Error GoTo Detectar_Error
    Dim Cont As Integer
    Dim DATOS()
    Dim Y As Integer
    Cont = 0
    Grid.SetFocus
    If Grid.RowSel = 1 Then Exit Sub 'Aquì se valida que la última fila no fija no se elimine
        Msg = MsgBox("¿ Está Seguro de querer eliminar ?", vbYesNo + vbExclamation + vbDefaultButton1)
    
        If Msg = 6 Then
            
            For i = 1 To Grid.Rows - 1
                Grid.Row = i
                If Grid.CellBackColor = vbRed Then
                    Envia = Array(CDbl(cmb_Moneda.ItemData(cmb_Moneda.ListIndex)), _
                             CDbl(Grid.TextMatrix(Grid.RowSel, 1)), _
                             CDbl(Grid.TextMatrix(Grid.RowSel, 2)), _
                             CDbl(Grid.TextMatrix(Grid.RowSel, 3)), _
                             CDbl(Grid.TextMatrix(Grid.RowSel, 4)), _
                             CDbl(Grid.TextMatrix(Grid.RowSel, 5)) _
                             )

                    If Bac_Sql_Execute("BACPARAMSUDA..SP_TasaSMConvencional_ELIMINA", Envia) Then
'                        Call Grabar_Log_AUDITORIA("Opt20001", "03", "Elimina Tasas", "TASAS_MAXIMAS_CONVENCIONAL", ValoresAntiguos, "Sin Datos")
                    End If
        
                   If Textos_en_Blanco = 1 Then
                
                       If Grid.Rows > 3 Then
                           Grid.RemoveItem (Grid.Row)
                           Exit Sub
                       Else
                           Grid.Col = 0
                           Grid.Rows = 2
                           Grid.Rows = 3
                           Grid.Col = 1
                           Grid.Row = 2
                       End If
                   End If
                
                   Grid.SetFocus
        
                    If Grid.Rows = 3 Then
                        Grid.Rows = 2
                        Grid.Rows = 3
                    End If
                    Cont = Cont + 1
                End If
            Next i
            
            If Cont = 0 Then
                MsgBox "No se Selecciono Ninguna Línea de Detalle", vbExclamation, TITSISTEMA
            End If
        End If
        Grid.SetFocus
    
    Exit Sub

Detectar_Error:
    MsgBox Err.Description, 16, TITSISTEMA
End Sub

Private Sub cmb_Moneda_Change()
    If cmb_Moneda.Text <> "" Then
        Toolbar1.Buttons(4).Enabled = True
    End If
End Sub

Private Sub Form_Load()
Me.top = 0
Me.Left = 0
    Call Limpia
    Call Cargar_Grilla
    'Call Grabar_Log_AUDITORIA("Opt20001", "08", "", "", "", "")
    cmb_Moneda.ListIndex = -1
End Sub

Private Sub Form_Unload(Cancel As Integer)
    'Call Grabar_Log_AUDITORIA("Opt20001", "07", "", "", "", "")
End Sub

Private Sub Grid_DblClick()

     Call Grid_KeyPress(13)
End Sub

Private Sub Grid_KeyPress(KeyAscii As Integer)
On Error GoTo Detectar_Error

Dim fil, Col As Integer

With Grid
            fil = .Row
            Col = .Col

        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = False
        Toolbar1.Buttons(3).Enabled = True
        Toolbar1.Buttons(4).Enabled = True
        
        If KeyAscii >= 48 And KeyAscii <= 57 Then
            txtBacNumero.Text = .TextMatrix(.Row, .Col)
            txtBacNumero1.Text = .TextMatrix(.Row, .Col)
        End If
        
        If .Col = 2 Or .Col = 1 Then
            txtBacNumero1.Max = 9999
            txtBacNumero1.Visible = True
            txtBacNumero1.MarcaTexto = False
            PROC_POSICIONA_TEXTO Grid, txtBacNumero1

          If KeyAscii <> 13 Then
              txtBacNumero1.Text = (Chr(KeyAscii))
          Else
              txtBacNumero1.Text = .TextMatrix(fil, Col)
          End If

          txtBacNumero1.SetFocus
          
         Exit Sub
        End If
        'Numeros del 0... al 9

        If Grid.Col = 3 Or Grid.Col = 4 Then
            txtBacNumero.Max = 999999999999999#
            txtBacNumero.Visible = True
            PROC_POSICIONA_TEXTO Grid, txtBacNumero
            txtBacNumero.Tag = txtBacNumero.Text
    
            fil = .Row
            Col = .Col
            
            txtBacNumero.Text = (Chr(KeyAscii))
            txtBacNumero.SetFocus
            txtBacNumero.MarcaTexto = False
              
              
          If KeyAscii <> 13 Then
              txtBacNumero.Text = (Chr(KeyAscii))
          Else
              txtBacNumero.Text = .TextMatrix(fil, Col)
          End If
          txtBacNumero.SetFocus
        End If

        If Grid.Col = 5 Then
            txtBacNumero.Max = 9999
            txtBacNumero.Visible = True
            PROC_POSICIONA_TEXTO Grid, txtBacNumero
            txtBacNumero.Tag = txtBacNumero.Text
    
            fil = .Row
            Col = .Col
            txtBacNumero.MarcaTexto = False
          
          If KeyAscii <> 13 Then
              txtBacNumero.Text = (Chr(KeyAscii))
          Else
              txtBacNumero.Text = .TextMatrix(fil, Col)
          End If

          txtBacNumero.SetFocus
        
        End If
    
    Exit Sub
    
End With
Detectar_Error:
    MsgBox Err.Description, 16, TITSISTEMA
End Sub

'Despliega el encabezado de la grilla
Sub Cargar_Grilla()
    On Error GoTo Detectar_Error
    Dim m As Integer, mm As Integer
    Grid.Rows = 3
    Grid.Cols = 6
    Grid.FixedRows = 2
    Grid.FixedCols = 0
    
    Grid.TextMatrix(0, 1) = "Plazo "
    Grid.TextMatrix(1, 1) = "Desde "
    
    Grid.TextMatrix(0, 2) = "Plazo "
    Grid.TextMatrix(1, 2) = "Hasta"

    
    Grid.TextMatrix(0, 3) = "Monto (U.F) "
    Grid.TextMatrix(1, 3) = "Inicial": Grid.ColWidth(0) = 1500
        
    Grid.TextMatrix(0, 4) = "Monto (U.F) "
    Grid.TextMatrix(1, 4) = "Final"
    
    
    Grid.TextMatrix(0, 5) = "Tasa "
    Grid.TextMatrix(1, 5) = "  %  "
    
    Grid.ColWidth(0) = 0
    'Se establece el ancho a cada celda
    For m = 1 To Grid.Cols - 1
        Grid.ColWidth(m) = 2000
    Next m
    'Se establece el alto a cada celda
    For m = 0 To Grid.Rows - 2
        Grid.RowHeight(m) = 227
    Next m
    For m = 0 To Grid.Rows - 1
        
        For mm = 0 To Grid.Cols - 1
            Grid.Col = mm
            Grid.Row = m
            Grid.CellFontBold = True  'Devuelve o establece el estilo negrita para el texto de la celda actual
            Grid.GridLinesFixed = flexGridNone 'No se dibujan líneas entre las celdas. En el control MSFlexGrid, éste es el valor predeterminado de la propiedad GridLines.
        Next mm
    Next m
    
    Grid.CellFontBold = False
    Grid.Rows = Grid.Rows - 1
    
    If Grid.Rows > 2 Then
        Grid.Col = 0
        Grid.ColSel = Grid.Cols - 1
    Else
        Grid.Col = 0
        Grid.ColSel = 0
    End If
    
    Exit Sub
    
Detectar_Error:
    MsgBox Err.Description, 16, TITSISTEMA
End Sub

Private Sub Buscar()
    On Error GoTo Detectar_Error
    
    Dim DATOS()
    Dim sql As String

With Grid
    V2 = cmb_Moneda.ItemData(cmb_Moneda.ListIndex)
    
    cmb_Moneda.Enabled = False
    
    .Rows = 2
    
    .Enabled = True
    .AddItem ("")
    .RowHeight(2) = 315
    .Row = 2
    .Col = 1
    .SetFocus
    
    .TextMatrix(.Rows - 1, 0) = 0
    .TextMatrix(.Rows - 1, 1) = 0
    .TextMatrix(.Rows - 1, 2) = 0
    .TextMatrix(.Rows - 1, 3) = "0.0000"
    .TextMatrix(.Rows - 1, 4) = "0.0000"
    .TextMatrix(.Rows - 1, 5) = "0.0000"

    
       Envia = Array(CDbl(V2))
    If Bac_Sql_Execute("BACPARAMSUDA..Sp_tasaMconvencional_buscar", Envia) Then
        i = 2
        Grid.Enabled = True
        SwG = 1
        
        Do While Bac_SQL_Fetch(DATOS())
            SwG = 0
            Grid.Rows = i + 1
            Grid.RowHeight(Grid.Rows - 1) = 315
            Grid.RowHeight(i) = 315
            Grid.TextMatrix(i, 1) = Format(DATOS(2), FEntero)  'Plazo Desde
            Grid.TextMatrix(i, 2) = Format(DATOS(3), FEntero)  'Plazo Hasta
            Grid.TextMatrix(i, 3) = Format(DATOS(4), FDecimal) 'Monto minimo-  Inicial
            Grid.TextMatrix(i, 4) = Format(DATOS(5), FDecimal) 'Monto maximo -Final
            Grid.TextMatrix(i, 5) = Format(DATOS(6), FDecimal) 'Tasa
            i = i + 1
            Toolbar1.Buttons(3).Enabled = True
        Loop
    End If
    
    If SwG = 1 Then
        Grid.TextMatrix(2, 1) = 1
    End If
    
    If KEYCODE = 46 Then
        Toolbar1.Buttons(2).Enabled = True
        Call Eliminar_Datos
    End If
    
    Grid.SetFocus
End With
    Exit Sub
    
Detectar_Error:
    MsgBox Err.Description, 16, TITSISTEMA
End Sub

Private Sub cmb_Moneda_Click()
    If cmb_Moneda.Text <> "" Then
        Toolbar1.Buttons(2).Enabled = True
        Toolbar1.Buttons(4).Enabled = True
        Call Buscar
    End If
End Sub

Private Sub cmb_Moneda_KeyDown(KEYCODE As Integer, Shift As Integer)
    'Enter
    If KEYCODE = 13 And cmb_Moneda <> "" Then
        Call Buscar
    End If
    'Escape
    If KEYCODE = 27 Then
        Unload Me
    End If
End Sub

Private Sub Grid_KeyDown(KEYCODE As Integer, Shift As Integer)
    On Error GoTo Detectar_Error
    Dim SW3 As Integer
    Dim Y As Integer
    Dim G As Integer
    Dim k As Integer

    Toolbar1.Buttons(1).Enabled = True
    'Insertar
    If KEYCODE = 45 Then
        
        If Textos_en_Blanco = 1 Then
            MsgBox "Ya existe una fila insertada", vbExclamation
            Grid.SetFocus: Exit Sub
        Else
            
            If Not Valida_montos Then
               Grid.SetFocus
               Exit Sub
            End If
            
            SwG = 1
            Toolbar1.Buttons(1).Enabled = True
            Grid.AddItem ("")
            Grid.RowHeight(Grid.Rows - 1) = 315
            Grid.SetFocus

            Grid.TextMatrix(Grid.Rows - 1, 1) = 0
            Grid.TextMatrix(Grid.Rows - 1, 2) = 0
            Grid.TextMatrix(Grid.Rows - 1, 3) = "0.0000"
            Grid.TextMatrix(Grid.Rows - 1, 4) = "0.0000"
            Grid.TextMatrix(Grid.Rows - 1, 5) = "0.0000"
            
            Grid.Col = 1
            Grid.Row = Grid.Rows - 1
            
        End If
    End If
    
    Dim x_row, x_col As Integer
    If KEYCODE = 46 Then
        If CDbl(Grid.TextMatrix(Grid.Row, 1)) <> 0 And CDbl(Grid.TextMatrix(Grid.Row, 2)) <> 0 And CDbl(Grid.TextMatrix(Grid.Row, 3)) <> 0 And CDbl(Grid.TextMatrix(Grid.Row, 4)) <> 0 And CDbl(Grid.TextMatrix(Grid.Row, 5)) <> 0 Then
            
            x_row = Grid.Row
            x_col = Grid.Col
            
            If Grid.CellBackColor = 0 Then
                For i = 0 To Grid.Cols - 1
                    Grid.Col = i
                    Grid.CellBackColor = vbRed
                Next
            Else
                If Grid.CellBackColor = &H80000004 Then
                    For i = 0 To Grid.Cols - 1
                        Grid.Col = i
                        Grid.CellBackColor = vbRed
                    Next
                Else
                    For i = 0 To Grid.Cols - 1
                        Grid.Col = i
                        Grid.CellBackColor = &H80000004
                    Next
                End If
            End If
            
            Grid.Row = x_row
            Grid.Col = x_col
        Else
            Call Elimina_Grilla
        End If
    End If
    
    colpress = Grid.Col
    rowpress = Grid.Row
    
Exit Sub

Detectar_Error:
    MsgBox Err.Description, 16, TITSISTEMA
End Sub

Function Valida_montos() As Boolean
With Grid
        
Valida_montos = False
        
    If CDbl(.TextMatrix(.Rows - 1, 3)) = 0 And CDbl(.TextMatrix(.Rows - 1, 4)) = 0 Then
       MsgBox "Ambos montos de la ultima fila estan en cero", vbCritical, TITSISTEMA
       Exit Function
    End If
    
    If CDbl(.TextMatrix(.Rows - 1, 3)) >= CDbl(.TextMatrix(.Rows - 1, 4)) Then
       MsgBox "El monto final no puede ser menor o igual que el monto inicial", vbCritical, TITSISTEMA
       Exit Function
    End If

    If CDbl(.TextMatrix(.Rows - 1, 1)) = 0 And CDbl(.TextMatrix(.Rows - 1, 2)) = 0 Then
       MsgBox "ambos plazos de la ultima fila estan en cero", vbCritical, TITSISTEMA
       Exit Function
    End If
    
    If CDbl(.TextMatrix(.Rows - 1, 1)) >= CDbl(.TextMatrix(.Rows - 1, 2)) Then
       MsgBox "El plazo desde no puede ser mayor o igual que el plazo hasta", vbCritical, TITSISTEMA
       Exit Function
    End If
    
Valida_montos = True

End With
End Function

Private Sub Grid_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
    colpress = Grid.Col
    rowpress = Grid.Row
End Sub

Private Sub Grid_MouseUp(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Grid.Col = colpress
    Grid.Row = rowpress
End Sub

Private Sub Grid_Scroll()
    Me.txtBacNumero.Visible = False
    Me.txtBacNumero1.Visible = False
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    On Error GoTo Detectar_Error
    
    Dim DATOS()
    
    Select Case Button.Index
        
        Case 1
            If Me.txtBacNumero.Visible <> True And Me.txtBacNumero1.Visible <> True Then
                Call Grabar
                'Call Limpia_grilla
               ' Call Buscar
            End If

        Case 2
            If cmb_Moneda.Text <> "" Then
                Call Buscar
                cmb_Moneda.Enabled = False
            Else
                cmb_Moneda.Enabled = True
                MsgBox "Debe Seleccionar Producto y Moneda", vbInformation, "Información"
            End If
        
        Case 3
            If Grid.TextMatrix(Grid.Row, 1) <> "" Then
                Call Eliminar_Datos
            Else
                Call Elimina_Grilla
            End If
            Call Limpia_grilla
            Call Buscar
        
        Case 4
            cmb_Moneda.Enabled = True
            Me.txtBacNumero1.Visible = False
            Me.txtBacNumero.Visible = False
            Call Limpia
        
        Case 5 'Imprime
            Call Proc_Imprimir_Toll(0)
        
        Case 6 'Imprime
            Call Proc_Imprimir_Toll(1)
        
        Case 7
            Unload Me
    End Select
    
    Exit Sub

Detectar_Error:
    MsgBox Err.Description, 16, TITSISTEMA
End Sub

Function Proc_Imprimir_Toll(x_Destination As Integer)
On Error GoTo Print_d

    Call LimpiarCristal
    BacControlFinanciero.CryFinanciero.WindowTitle = "Informe Tasas Maximas Convensionales"
    BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "inf_tasas_maximas_convensionales.rpt"
    BacControlFinanciero.CryFinanciero.StoredProcParam(0) = 0
    BacControlFinanciero.CryFinanciero.Connect = swConeccion
    BacControlFinanciero.CryFinanciero.Destination = x_Destination
    BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
    BacControlFinanciero.CryFinanciero.Action = 1

    Exit Function

Print_d:
    MsgBox Err.Description, vbCritical, TITSISTEMA
End Function

Sub Limpia_grilla()
    Me.top = 0
    Me.Left = 0
    On Error GoTo Detectar_Error

    Dim DATOS()
  
    Grid.Rows = 2
    Grid.Col = 0
    Grid.Enabled = False
    
    Exit Sub

Detectar_Error:
    MsgBox Err.Description, 16, TITSISTEMA
End Sub

Sub Limpia()
    Me.top = 0
    Me.Left = 0
    On Error GoTo Detectar_Error
    
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = False
    Toolbar1.Buttons(4).Enabled = False
    
    Dim DATOS()
  
    cmb_Moneda.Clear
    If Bac_Sql_Execute("bacParamSuda..SP_TASAMCONVENCIONAL_cmbmoneda") Then

        cmb_Moneda.Clear

        Do While Bac_SQL_Fetch(DATOS())
           
            cmb_Moneda.AddItem Datos(1)
            cmb_Moneda.ItemData(cmb_Moneda.NewIndex) = Datos(2)

        Loop

    End If
    
    Grid.Rows = 2
    Grid.Col = 0
    Grid.Enabled = False
    
    Exit Sub

Detectar_Error:
    MsgBox Err.Description, 16, TITSISTEMA
End Sub

Function Valida_Rangos(i As Long) As Boolean
    
    Valida_Rangos = True
    If CDbl(Grid.TextMatrix(i, 2)) <= 5000 And CDbl(Grid.TextMatrix(i, 4)) < 90 Then
        If CDbl(Grid.TextMatrix(i, 5)) = "31,16" Then
            Exit Function
        Else
            MsgBox "Porcentaje Incorrecto", vbInformation, TITSISTEMA
            Valida_Rangos = False
        End If
    ElseIf CDbl(Grid.TextMatrix(i, 2)) > 5000 And CDbl(Grid.TextMatrix(i, 4)) < 90 Then
        If CDbl(Grid.TextMatrix(i, 5)) = "15,95" Then
            Exit Function
        Else
            MsgBox "Porcentaje Incorrecto", vbInformation, TITSISTEMA
            Valida_Rangos = False
        End If
    ElseIf CDbl(Grid.TextMatrix(i, 2)) <= 200 And CDbl(Grid.TextMatrix(i, 4)) >= 90 Then
        If CDbl(Grid.TextMatrix(i, 5)) = "48,18" Then
            Exit Function
        Else
            MsgBox "Porcentaje Incorrecto", vbInformation, TITSISTEMA
            Valida_Rangos = False
        End If
    ElseIf CDbl(Grid.TextMatrix(i, 2)) > 200 And CDbl(Grid.TextMatrix(i, 2)) <= 5000 And CDbl(Grid.TextMatrix(i, 4)) >= 90 Then
        If CDbl(Grid.TextMatrix(i, 5)) = "34,26" Then
            Exit Function
        Else
            MsgBox "Porcentaje Incorrecto", vbInformation, TITSISTEMA
            Valida_Rangos = False
        End If
    ElseIf CDbl(Grid.TextMatrix(i, 2)) > 5000 And CDbl(Grid.TextMatrix(i, 4)) >= 90 Then
        If CDbl(Grid.TextMatrix(i, 5)) = "24,68" Then
            Exit Function
        Else
            MsgBox "Porcentaje Incorrecto", vbInformation, TITSISTEMA
            Valida_Rangos = False
        End If
    End If
End Function

Function Valida_Campos_Grilla(i As Long) As Boolean
    Valida_Campos_Grilla = True
    If CDbl(Grid.TextMatrix(i, 3)) = 0 And CDbl(Grid.TextMatrix(i, 4)) = 0 And CDbl(Grid.TextMatrix(i, 5)) = 0 Then
        MsgBox "Todos los Datos de la Línea de Detalle N° " & i - 1 & " se Encuentran en 0, estos datos no seran grabados.", vbInformation, "Información"
        Valida_Campos_Grilla = False
        Exit Function
    End If
End Function

Sub Grabar()
    On Error GoTo Detectar_Error
    Dim DATOS()
    Dim Y As Integer
    
        If Textos_en_Blanco = 0 Then
        
        If Not Valida_Datos_Repetidos_Grabar Then
            MsgBox "Los Datos Ingresados en la Línea N° " & PosGrilla & " ya Existen", vbInformation, TITSISTEMA
            Exit Sub
        End If
        
        If Not Valida_montos Then
            Grid.SetFocus
            Exit Sub
        End If
        
        Envia = Array(CDbl(cmb_Moneda.ItemData(cmb_Moneda.ListIndex)))
        
        If Bac_Sql_Execute("BACPARAMSUDA..sp_tasasmconvencional_elimina1", Envia) Then
            If Not Bac_SQL_Fetch(DATOS()) Then
            End If
        End If

        For i = 2 To Grid.Rows - 1
            Grid.Row = i
            If Grid.CellBackColor <> vbRed Then
            
                If Valida_Campos_Grilla(i) Then
                    Envia = Array(CDbl(cmb_Moneda.ItemData(cmb_Moneda.ListIndex)), _
                                   CDbl(Grid.TextMatrix(i, 1)), _
                                   CDbl(Grid.TextMatrix(i, 2)), _
                                   CDbl(Grid.TextMatrix(i, 3)), _
                                   CDbl(Grid.TextMatrix(i, 4)), _
                                   CDbl(Grid.TextMatrix(i, 5)) _
                                   )
   
                    If Bac_Sql_Execute("BACPARAMSUDA..SP_TasaMConvencional_Graba ", Envia) Then
                        
                        If Bac_SQL_Fetch(DATOS()) Then
                            
                            Select Case DATOS(1)
                                
                                Case Is = "OK": Okey = 1
                                                                                                           
                            End Select
                        End If
                    End If
                End If
            End If
        Next i
        
        If Okey = 1 Then MsgBox "La información ha sido Grabada", vbInformation + vbOKOnly, TITSISTEMA: Grid.SetFocus
        If Okey = 0 Then MsgBox "Se Eliminaron Todos los Detalles de la Grilla", vbInformation + vbOKOnly, TITSISTEMA: Grid.SetFocus
        If Chao <> True Then
            Grid.SetFocus
        End If
        
        Okey = 0
        Modif = False
    Else
        MsgBox "No debe dejar textos en blanco", vbExclamation: Grid.SetFocus
    End If
    
    Exit Sub

Detectar_Error:
    MsgBox Err.Description, 16, TITSISTEMA
End Sub

Private Sub txtBacNumero_Change()
    Modif = True
End Sub

Private Sub txtBacNumero_GotFocus()
     txtBacNumero.SelStart = Len(txtBacNumero.Text) - 5
End Sub

Private Sub txtBacNumero_KeyPress(KeyAscii As Integer)
    On Error GoTo Detectar_Error
    Dim Contador As Integer
    
    If KeyAscii = 13 Then
            Grid.Text = Format(txtBacNumero.Text, FDecimal)
                    
            If Grid.Col <> 5 Then
                   Grid.Col = Grid.Col + 1: Grid.SetFocus
            Else
                   Grid.SetFocus
            End If
    
            txtBacNumero.Visible = False
            Exit Sub
            
   End If
    If KeyAscii = 27 Then
        txtBacNumero.Visible = False
    End If
   
    colpress = Grid.Col
    rowpress = Grid.Row
   
    
    Exit Sub

Detectar_Error:
    MsgBox Err.Description, 16, TITSISTEMA
End Sub

Private Function Valida_Datos_Repetidos() As Boolean
    Dim i, z As Integer

    Valida_Datos_Repetidos = True
    z = Grid.Rows - 1
    For i = 2 To Grid.Rows - 2
        If Grid.TextMatrix(i, 1) = Grid.TextMatrix(z, 1) And Grid.TextMatrix(i, 2) = Grid.TextMatrix(z, 2) And Grid.TextMatrix(i, 3) = Grid.TextMatrix(z, 3) And Grid.TextMatrix(i, 4) = Grid.TextMatrix(z, 4) And Grid.TextMatrix(i, 5) = Grid.TextMatrix(z, 5) Then
            Valida_Datos_Repetidos = False
            PosGrilla = Grid.Row - 1
            Exit Function
        End If
    Next i
End Function

Private Function Valida_Datos_Repetidos_Grabar() As Boolean
    Dim i, j, z As Integer

    Valida_Datos_Repetidos_Grabar = True
    z = 3
    For i = 2 To Grid.Rows - 1
        For j = z To Grid.Rows - 1
            If Grid.TextMatrix(i, 1) = Grid.TextMatrix(j, 1) And Grid.TextMatrix(i, 2) = Grid.TextMatrix(j, 2) And Grid.TextMatrix(i, 3) = Grid.TextMatrix(j, 3) And Grid.TextMatrix(i, 4) = Grid.TextMatrix(j, 4) And Grid.TextMatrix(i, 5) = Grid.TextMatrix(j, 5) Then
                Valida_Datos_Repetidos_Grabar = False
                PosGrilla = Grid.Row - 1
                Exit Function
            End If
        Next j
        z = z + 1
    Next i
End Function

Private Sub txtBacNumero_LostFocus()
     txtBacNumero.Text = 0
     txtBacNumero.Visible = False
End Sub

Private Sub txtBacNumero1_GotFocus()
     txtBacNumero1.SelStart = Len(txtBacNumero1.Text)
End Sub

Private Sub txtBacNumero1_KeyPress(KeyAscii As Integer)
    On Error GoTo Detectar_Error
    If KeyAscii = 13 Then
            Grid.Text = Format(Me.txtBacNumero1.Text, FEntero)
            Grid.Text = Format(Grid.Text, FEntero)
                    
            If Grid.Col <> 5 Then
                   Grid.Col = Grid.Col + 1: Grid.SetFocus
            Else
                   Grid.SetFocus
            End If
    
            Me.txtBacNumero1.Visible = False
            Exit Sub
            
   End If
    If KeyAscii = 27 Then
        'Grid.Text = Format(Me.txtBacNumero1.Tag, FEntero)
        'Grid.Text = Format(Grid.Text, FEntero)
        txtBacNumero1.Visible = False
    End If
   
    colpress = Grid.Col
    rowpress = Grid.Row
   
    Exit Sub

Detectar_Error:
    MsgBox Err.Description, 16, TITSISTEMA
End Sub

Private Sub txtBacNumero_Validate(Cancel As Boolean)
'    If SwG <> 1 Then Monto = Grid.Text
'        Grid.Text = Me.txtBacNumero.Text
'        Me.Grid.Text = Me.txtBacNumero.Text
'    If Error <> True Then
'        Me.txtBacNumero.Visible = False
'        Grid.Text = Format(Grid.Text, FDecimal)
'    Else
'        Me.txtBacNumero.Visible = False
'        Me.Grid.Text = Monto
'        Error = False: Grid.SetFocus
'    End If
End Sub

Private Sub txtBacNumero1_LostFocus()
txtBacNumero1.Text = 0
txtBacNumero1.Visible = False
End Sub

Private Sub txtBacNumero1_Validate(Cancel As Boolean)
'    If SwG <> 1 Then Monto = Grid.Text
'        Grid.Text = Me.txtBacNumero1.Text
'        If Error <> True Then
'            Validar_Dias_Desde
'            If Error <> True Then
'                Me.txtBacNumero1.Visible = False
'                Grid.Text = Format(Grid.Text, FEntero)
'            Else
'                Grid.Text = Monto: Error = False
'                Me.txtBacNumero1.Visible = False
'            End If
'        Else
'            Me.txtBacNumero1.Visible = False
'            Me.Grid.Text = Monto
'            Error = False: Grid.SetFocus
'        End If
'
'    Exit Sub
'
'Detectar_Error:
'    MsgBox Err.Description, 16, TITSISTEMA
End Sub
