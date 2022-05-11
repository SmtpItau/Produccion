VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FRM_MNT_VALORES_CURVAS 
   Caption         =   "Curvas de Tasas y Spread"
   ClientHeight    =   5460
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5400
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   5460
   ScaleWidth      =   5400
   Begin Threed.SSPanel Flood 
      Align           =   2  'Align Bottom
      Height          =   315
      Left            =   0
      TabIndex        =   11
      Top             =   5145
      Width           =   5400
      _Version        =   65536
      _ExtentX        =   9525
      _ExtentY        =   556
      _StockProps     =   15
      ForeColor       =   -2147483634
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.26
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   1
      BevelInner      =   1
      FloodType       =   1
      FloodColor      =   -2147483635
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5400
      _ExtentX        =   9525
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   7
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cargar archivos de tasas"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComDlg.CommonDialog MiCommand 
         Left            =   2550
         Top             =   15
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   3360
         Top             =   45
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   12
         ImageHeight     =   12
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   1
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_VALORES_CURVAS.frx":0000
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4365
         Top             =   60
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   8
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_VALORES_CURVAS.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_VALORES_CURVAS.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_VALORES_CURVAS.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_VALORES_CURVAS.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_VALORES_CURVAS.frx":4A42
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_VALORES_CURVAS.frx":591C
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_VALORES_CURVAS.frx":5C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_VALORES_CURVAS.frx":6B10
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame CuadroFecha 
      Height          =   765
      Left            =   0
      TabIndex        =   1
      Top             =   435
      Width           =   5400
      Begin MSComctlLib.Toolbar Toolbar2 
         Height          =   270
         Left            =   4950
         TabIndex        =   10
         Top             =   390
         Width           =   300
         _ExtentX        =   529
         _ExtentY        =   476
         ButtonWidth     =   503
         ButtonHeight    =   476
         AllowCustomize  =   0   'False
         Style           =   1
         ImageList       =   "ImageList2"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   1
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "REFRESCAR"
               ImageIndex      =   1
            EndProperty
         EndProperty
      End
      Begin VB.ComboBox Curvas 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1560
         Style           =   2  'Dropdown List
         TabIndex        =   5
         TabStop         =   0   'False
         Top             =   375
         Width           =   3345
      End
      Begin BACControles.TXTFecha Fecha 
         Height          =   315
         Left            =   75
         TabIndex        =   3
         TabStop         =   0   'False
         Top             =   375
         Width           =   1320
         _ExtentX        =   2328
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "25/01/2007"
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Curvas"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   1575
         TabIndex        =   4
         Top             =   150
         Width           =   510
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Fecha"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   105
         TabIndex        =   2
         Top             =   150
         Width           =   435
      End
   End
   Begin VB.Frame CuadroDetalle 
      Enabled         =   0   'False
      Height          =   3990
      Left            =   0
      TabIndex        =   6
      Top             =   1125
      Width           =   5400
      Begin VB.ComboBox oComboBox 
         BackColor       =   &H8000000D&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   330
         Left            =   2925
         Style           =   2  'Dropdown List
         TabIndex        =   12
         Top             =   750
         Visible         =   0   'False
         Width           =   915
      End
      Begin BACControles.TXTNumero NumeroGrid 
         Height          =   270
         Left            =   2055
         TabIndex        =   9
         Top             =   765
         Visible         =   0   'False
         Width           =   885
         _ExtentX        =   1561
         _ExtentY        =   476
         BackColor       =   -2147483635
         ForeColor       =   -2147483634
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   3510
         Left            =   30
         TabIndex        =   8
         Top             =   435
         Width           =   5340
         _ExtentX        =   9419
         _ExtentY        =   6191
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         Enabled         =   -1  'True
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label Descripcion 
         Alignment       =   2  'Center
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Nombre Curva"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   300
         Left            =   45
         TabIndex        =   7
         Top             =   135
         Width           =   5280
      End
   End
End
Attribute VB_Name = "FRM_MNT_VALORES_CURVAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim grilla()
Dim oMensaje   As String

Private Sub NombresGrilla()
   Let Grid.Rows = 2:         Let Grid.FixedRows = 1
   Let Grid.Cols = 6:         Let Grid.FixedCols = 0

   Let Grid.Font.Name = "Tahoma"
   Let Grid.Font.Size = 8
   Let Grid.RowHeightMin = 315

   Let Grid.TextMatrix(0, 0) = "Dias":        Let Grid.ColWidth(0) = 1000: Let Grid.ColAlignment(0) = flexAlignRightCenter
   Let Grid.TextMatrix(0, 1) = "Valor BID":   Let Grid.ColWidth(1) = 1000: Let Grid.ColAlignment(1) = flexAlignRightCenter
   Let Grid.TextMatrix(0, 2) = "Valor ASK":   Let Grid.ColWidth(2) = 1000: Let Grid.ColAlignment(2) = flexAlignRightCenter
   Let Grid.TextMatrix(0, 3) = "Curva":       Let Grid.ColWidth(3) = 0:    Let Grid.ColAlignment(3) = flexAlignRightCenter
   Let Grid.TextMatrix(0, 4) = "Tipo":        Let Grid.ColWidth(4) = 800:  Let Grid.ColAlignment(4) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, 5) = "Origen":      Let Grid.ColWidth(5) = 800:  Let Grid.ColAlignment(5) = flexAlignLeftCenter

   Let Grid.Rows = 1
End Sub

Private Sub Curvas_Click()
   Let Descripcion.Caption = ""
   Let CuadroDetalle.Enabled = True
   
   If Curvas.ListIndex = -1 Then
      Exit Sub
   End If
   
   Let Descripcion.Caption = Trim(Mid(Curvas.Text, InStr(1, Curvas.Text, " ")))
   Let CuadroDetalle.Enabled = True
   Call CunsultaCurvas
End Sub

Private Sub Fecha_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call CunsultaCurvas
   End If
End Sub

Private Sub Form_Load()
   Let Me.Icon = BACSwapParametros.Icon
   Let Me.Top = 0:       Let Me.Left = 0
   Let Me.Height = 5550: Let Me.Width = 5520

   Let Descripcion.Caption = "<< Sin Selección >>"
   Let Fecha.Text = Format(gsbac_fecp, "dd/mm/yyyy")

   Call NombresGrilla
   Call CargaCurvasCreadas
   
   Let Flood.FloodPercent = 0
End Sub

Private Sub CargaCurvasCreadas()
   Dim Datos()

   Envia = Array()
   AddParam Envia, CDbl(0)
   If Not Bac_Sql_Execute("SP_MNT_CURVAS", Envia) Then
      Exit Sub
   End If
   Call Curvas.Clear
   Do While Bac_SQL_Fetch(Datos())
      Call Curvas.AddItem(Trim(Datos(1)) & String(80 - Len(Trim(Datos(1))), " ") & Datos(2))
   Loop
End Sub

Private Sub Form_Resize()
   On Error Resume Next
   Let CuadroFecha.Width = Me.Width - 150
   Let CuadroDetalle.Width = CuadroFecha.Width
   Let Grid.Width = CuadroDetalle.Width - 130
   Let Descripcion.Width = Grid.Width - 25
   Let CuadroDetalle.Height = Me.Height - 1950
   Let Grid.Height = CuadroDetalle.Height - 500
   On Error GoTo 0
End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim iValor     As Double
   Dim iContador  As Integer

   If KeyCode = vbKeyC And Shift = 2 Then
      grilla = Array()
      ReDim grilla(Grid.Rows - 1, Grid.Cols)  'Preserve
      For iContador = 1 To Grid.Rows - 1
         Let grilla(iContador, 1) = Grid.TextMatrix(iContador, 0)
         Let grilla(iContador, 2) = Grid.TextMatrix(iContador, 1)
         Let grilla(iContador, 3) = Grid.TextMatrix(iContador, 2)
      Next iContador
   End If

   If KeyCode = vbKeyV And Shift = 2 Then
      Let Grid.Rows = 1
      For iContador = 1 To UBound(grilla())
         Let Grid.Rows = Grid.Rows + 1
         Let Grid.TextMatrix(iContador, 0) = grilla(iContador, 1)
         Let Grid.TextMatrix(iContador, 1) = grilla(iContador, 2)
         Let Grid.TextMatrix(iContador, 2) = grilla(iContador, 3)
      Next iContador
   End If

   If KeyCode = vbKeyReturn Then
      If Grid.ColSel = 4 Then
         Call oComboBox.Clear
         Call oComboBox.AddItem("TIR"): Call oComboBox.AddItem("CERO")
         Call AJObjeto(Grid, oComboBox)
         Call Habilitacion(True, oComboBox)
         If Trim(Grid.TextMatrix(Grid.RowSel, Grid.ColSel)) <> "" Then
            Let oComboBox.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
         End If
         Exit Sub
      End If
      If Grid.ColSel = 5 Then
         Call oComboBox.Clear
         Call oComboBox.AddItem("TM"): Call oComboBox.AddItem("MC")
         Call AJObjeto(Grid, oComboBox)
         Call Habilitacion(True, oComboBox)
         If Trim(Grid.TextMatrix(Grid.RowSel, Grid.ColSel)) <> "" Then
            Let oComboBox.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
         End If
         Exit Sub
      End If

      If Grid.Rows = Grid.FixedRows Then
         Exit Sub
      End If
      
      Let NumeroGrid.CantidadDecimales = 0
      If Grid.ColSel >= 1 Then
         Let NumeroGrid.CantidadDecimales = 4
      End If
      Let NumeroGrid.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
      Call AJObjeto(Grid, NumeroGrid)
      Call Habilitacion(True, NumeroGrid)
   End If

   If KeyCode = vbKeyInsert Then
      Let Grid.Rows = Grid.Rows + 1
      If Grid.TextMatrix(Grid.Rows - 2, 0) = "" Or Grid.TextMatrix(Grid.Rows - 2, 0) = "Dias" Then
         Let iValor = Val(Grid.TextMatrix(Grid.Rows - 2, 0))
      Else
         Let iValor = CDbl(Grid.TextMatrix(Grid.Rows - 2, 0))
      End If
      
      Let Grid.TextMatrix(Grid.Rows - 1, 0) = Format((iValor + 1), FEntero)
      Let Grid.TextMatrix(Grid.Rows - 1, 1) = Format(0#, FDecimal)
      Let Grid.TextMatrix(Grid.Rows - 1, 2) = Format(0#, FDecimal)
   End If

   If KeyCode = vbKeyDelete Then
      If (Grid.Rows - 1) <= Grid.FixedRows Then
         Let Grid.Rows = Grid.FixedRows
      Else
         Call Grid.RemoveItem(Grid.RowSel)
      End If
   End If
End Sub

Private Sub NumeroGrid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If Grid.ColSel = 0 Then
         If Validacion = False Then
            Exit Sub
         End If
      End If
      Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = IIf(Grid.ColSel = 0, Format(NumeroGrid.Text, FEntero), Format(NumeroGrid.Text, FDecimal))
      Call Habilitacion(False, NumeroGrid)
      Call Grid.SetFocus
   End If
   If KeyCode = vbKeyEscape Then
      Call Habilitacion(False, NumeroGrid)
      Call Grid.SetFocus
   End If
End Sub

Private Function Validacion() As Boolean
   Dim iValor  As Double

   Let Validacion = False
   Let iValor = NumeroGrid.Text

   If Grid.Rows > Grid.FixedRows Then
      If Grid.RowSel = 1 And Grid.Rows = 2 Then
         Let Validacion = True
         Exit Function
      End If
      If Grid.RowSel = (Grid.Rows - 1) Then
         If iValor <= CDbl(Grid.TextMatrix(Grid.RowSel - 1, 0)) Then
            Call MsgBox("Imposible asignar la periodicidad... Debe ser mayor al anterior Items.", vbExclamation, TITSISTEMA)
            Call NumeroGrid.SetFocus
            Exit Function
         End If
      End If
      If Grid.RowSel = Grid.FixedRows Then
         If iValor >= CDbl(Grid.TextMatrix(Grid.RowSel + 1, 0)) Then
            Call MsgBox("Imposible asignar la periodicidad... Debe ser menor al Items Posterior.", vbExclamation, TITSISTEMA)
            Call NumeroGrid.SetFocus
            Exit Function
         End If
      End If
      If Grid.RowSel > Grid.FixedRows Then
         If (Grid.Rows - 1) > Grid.RowSel Then
            If iValor >= CDbl(Grid.TextMatrix(Grid.RowSel + 1, 0)) Then
               Call MsgBox("Imposible asignar la periodicidad... Debe ser menor al Items Posterior.", vbExclamation, TITSISTEMA)
               Call NumeroGrid.SetFocus
               Exit Function
            End If
         End If
         If iValor <= CDbl(Grid.TextMatrix(Grid.RowSel - 1, 0)) Then
            Call MsgBox("Imposible asignar la periodicidad... Debe ser mayor al anterior Items.", vbExclamation, TITSISTEMA)
            Call NumeroGrid.SetFocus
            Exit Function
         End If
      End If
   End If

   Let Validacion = True
End Function

Private Sub oComboBox_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If Grid.ColSel = 0 Then
         If Validacion = False Then
            Exit Sub
         End If
      End If
      Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = oComboBox.List(oComboBox.ListIndex)
      Call Habilitacion(False, oComboBox)
      Call Grid.SetFocus
   End If
   If KeyCode = vbKeyEscape Then
      Call Habilitacion(False, oComboBox)
      Call Grid.SetFocus
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call GrabarCurvas
      Case 3
         Call Eliminar
      Case 6
         Call CargarCurvasExcell
      Case 7
         Unload Me
   End Select
End Sub

Private Sub CargarCurvasExcell()
   On Error GoTo ErrorExcell
   Dim cCurva           As String
   Dim iPeriodo         As Double
   Dim iBid             As Double
   Dim iAsk             As Double
   Dim cTipo            As String
   Dim cOrigen          As String
   Dim cMensaje         As String
   Dim iContador        As Long
   Dim cArchivo         As String
   Dim MiExcell         As New Excel.Application '--> Se retiran los comentarios.- N.N.
   Dim MiLibro          As New Excel.Workbook    '--> Se retiran los comentarios.- N.N.
   Dim MiHoja           As New Excel.Worksheet   '--> Se retiran los comentarios.- N.N.
   Dim grilla()
   Dim iValProgress     As Long
   
   FRM_MNT_CURVAS_OPCIONES.Hide
   
   If ExistenCargadas() = True Then
      Exit Sub
   End If
   
   If VerififcaSistemaOpciones = True Then
     If FRM_MNT_CURVAS_OPCIONES.ExistenSmile() = True Then
        Exit Sub
     End If
   End If
   
   Let Grid.Rows = 1
   Let Curvas.ListIndex = -1
   
   Let Me.MousePointer = vbHourglass
   Let Screen.MousePointer = vbHourglass
   
   Let Toolbar1.Enabled = False
   
   Let Flood.Visible = True
   Let Flood.FloodPercent = 0
   Let Flood.ForeColor = vbBlack
   
   Let MiCommand.CancelError = True
   Let MiCommand.FileName = ""
   Let MiCommand.Filter = "*.xls"
   Call MiCommand.ShowOpen
   
   If MiCommand.FileName = "" Then
      Let Me.MousePointer = vbDefault
      Let Screen.MousePointer = vbDefault
      Let Toolbar1.Enabled = True
      Exit Sub
   End If

   Set MiExcell = CreateObject("Excel.Application")
   Set MiLibro = MiExcell.Workbooks.Open(MiCommand.FileName)
   Set MiHoja = MiLibro.Worksheets(1)


   Let Grid.Redraw = False
   Let Grid.Cols = 6
   Let Grid.ColWidth(3) = 0
   Let Grid.Rows = 1
   
   Let iValProgress = MiHoja.Columns.End(xlDown).Row - 1

   For iContador = 1 To 65000

      Let Flood.FloodPercent = IIf(((iContador * 100) / (iValProgress)) >= 98, 98, ((iContador * 100) / (iValProgress)))
      If Flood.FloodPercent >= 48 Then
         Let Flood.ForeColor = vbWhite
      End If

      If MiHoja.Cells(iContador, "A") = "" And MiHoja.Cells(iContador, "B") = "" Then
         Let Flood.FloodPercent = 100
         Call BacControlWindows(1)       '--> Se cambia la cantidad de refresco.- N.N.
         Exit For
      End If

      If IsNumeric(MiHoja.Cells(iContador, "B")) = True Then

         If cCurva <> "" And iContador > 1 And MiHoja.Cells(iContador, "A") = "" Then
            Exit For
         End If

         Let Grid.Rows = Grid.Rows + 1
         Let Grid.TextMatrix(Grid.Rows - 1, 3) = MiHoja.Cells(iContador, "A")
         Let Grid.TextMatrix(Grid.Rows - 1, 0) = MiHoja.Cells(iContador, "B")
         Let Grid.TextMatrix(Grid.Rows - 1, 1) = CDbl(MiHoja.Cells(iContador, "C"))
         Let Grid.TextMatrix(Grid.Rows - 1, 2) = CDbl(MiHoja.Cells(iContador, "D"))
         Let Grid.TextMatrix(Grid.Rows - 1, 4) = MiHoja.Cells(iContador, "E")
         Let Grid.TextMatrix(Grid.Rows - 1, 5) = MiHoja.Cells(iContador, "F")
         Let cCurva = MiHoja.Cells(iContador, "B")
      End If
      
'20090421 - Ingreso de Curvas para Opciones
'--
      If VerififcaSistemaOpciones = True Then
           Call CargarExcelOpciones(MiLibro.Worksheets(2), iContador)
      End If
'--

      Call BacControlWindows(1)
   Next iContador


   Call MiLibro.Close
   Set MiExcell = Nothing
   Set MiLibro = Nothing
   Set MiHoja = Nothing

   Let Flood.FloodPercent = 0
   Let Flood.ForeColor = vbBlack
   Let cMensaje = ""

   For iContador = 1 To Grid.Rows - 1
      Call BacControlWindows(1)
      Let Flood.FloodPercent = ((iContador * 100) / (Grid.Rows - 1))
      If Flood.FloodPercent >= 48 Then
         Let Flood.ForeColor = vbWhite
      End If

      Let iPeriodo = Grid.TextMatrix(iContador, 0)
      Let iBid = Grid.TextMatrix(iContador, 1)
      Let iAsk = Grid.TextMatrix(iContador, 2)
      Let cCurva = Grid.TextMatrix(iContador, 3)
      Let cTipo = Grid.TextMatrix(iContador, 4)
      Let cOrigen = Grid.TextMatrix(iContador, 5)
      
      If ValidaExistencia(cCurva, cMensaje) = True Then
         
         If CargaExcell(cCurva, iPeriodo, iBid, iAsk, cTipo, cOrigen) = False Then
            Let Me.MousePointer = vbDefault
            Let Screen.MousePointer = vbDefault
            Let Toolbar1.Enabled = True
            Let Grid.Rows = 1
            Let Grid.Redraw = True
            Let Flood.Visible = False
            Call MsgBox("E - Error en la Validación de Tipo y Origen." & vbCrLf & vbCrLf & oMensaje, vbExclamation, App.Title)
            Exit Sub
         End If
         
      End If
      
        '20090421 - Ingreso de Curvas para Opciones
        '--
          If VerififcaSistemaOpciones = True Then
              Call FRM_MNT_CURVAS_OPCIONES.CargarCurvasOpciones(iContador)
          End If
        '--
   Next iContador

    '+++jcamposd marca acción en LOG
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                    , gsbac_fecp _
                    , gsBac_IP _
                    , gsBAC_User _
                    , "PCA" _
                    , "Opc_IngresoCurvas" _
                    , "01" _
                    , iValProgress & " valores de curvas " _
                    , " " _
                    , " " _
                    , " ")
   
   '---jcamposd

   Let Toolbar1.Enabled = True
   Let Grid.Redraw = True
   Let Me.MousePointer = vbDefault
   Let Screen.MousePointer = vbDefault
   Let Toolbar1.Enabled = True

   Let Grid.Rows = 1
   Let Flood.FloodPercent = 100

   '20090421 - Ingreso de Curvas para Opciones
'--
  If VerififcaSistemaOpciones = True Then
     Let FRM_MNT_CURVAS_OPCIONES.Flood.FloodPercent = 100
     Call FRM_MNT_CURVAS_OPCIONES.ConsultaCurvasOpciones
  End If
'--

   If cMensaje <> "" Then
      Call MsgBox("Errores" & vbCrLf & vbCrLf & cMensaje & vbCrLf & vbCrLf & "... Favor primero crear curva.", vbExclamation, TITSISTEMA)
   Else

'20090421 - Ingreso de Curvas para Opciones
'--
     If VerififcaSistemaOpciones = False Then
        Call MsgBox("Carga Finalizada solo para derivados Forward y Swap." & vbCrLf & vbCrLf & "para Módulo Opciones no se cargó información Smile, ya que módulo aún no se encuentra activo.", vbInformation, TITSISTEMA)
     Else
'--
        Let FRM_MNT_CURVAS_OPCIONES.Left = FRM_MNT_VALORES_CURVAS.Width + 2000
        FRM_MNT_CURVAS_OPCIONES.Show
      Call MsgBox("Carga Finalizada." & vbCrLf & vbCrLf & "La carga de los factores se ha realizado en forma correcta.", vbInformation, TITSISTEMA)
   End If

   End If

   Let Flood.Visible = False
   If VerififcaSistemaOpciones = True Then
      Let FRM_MNT_CURVAS_OPCIONES.Flood.Visible = False
   End If

Exit Sub
ErrorExcell:
   Let Me.MousePointer = vbDefault
   Let Screen.MousePointer = vbDefault
   Let Toolbar1.Enabled = True

   If Err.Number = 32755 Then
      Exit Sub
   End If

   Set MiExcell = Nothing
   Set MiLibro = Nothing
   Set MiHoja = Nothing

   Call NombresGrilla
   Let Flood.FloodPercent = 0
   Let Grid.Redraw = True

   Call MsgBox("Error Carga" & vbrlf & vbCrLf & "Se ha originado un error al tratar de cargar el Archivo Excell.", vbExclamation, TITSISTEMA)
End Sub

Private Sub CargarExcelOpciones(Hoja, Cont As Long)   ' As Excel.Worksheets
'20090421 - Ingreso de Curvas para Opciones (SMILE)
'--
      If Hoja.Cells(Cont, "A") = "" And Hoja.Cells(Cont, "B") = "" Then
     'Let Flood.FloodPercent = 100  '--> Se Retira avance de Barra de progreso.- N.N.
      Call BacControlWindows(1)     '--> Se cambia cantidad de Refrescos.- N.N.
         Exit Sub
      End If
      If IsNumeric(Hoja.Cells(Cont, "B")) = True Then
         If FRM_MNT_CURVAS_OPCIONES.CmbParMda <> "" And Cont > 1 And Hoja.Cells(Cont, "A") = "" Then
            Exit Sub
         End If
         Let FRM_MNT_CURVAS_OPCIONES.Grid.Rows = FRM_MNT_CURVAS_OPCIONES.Grid.Rows + 1
         Let FRM_MNT_CURVAS_OPCIONES.Grid.TextMatrix(FRM_MNT_CURVAS_OPCIONES.Grid.Rows - 1, 0) = Hoja.Cells(Cont, "B")
         Let FRM_MNT_CURVAS_OPCIONES.Grid.TextMatrix(FRM_MNT_CURVAS_OPCIONES.Grid.Rows - 1, 1) = CDbl(Hoja.Cells(Cont, "E"))
         Let FRM_MNT_CURVAS_OPCIONES.Grid.TextMatrix(FRM_MNT_CURVAS_OPCIONES.Grid.Rows - 1, 2) = CDbl(Hoja.Cells(Cont, "F"))
         Let FRM_MNT_CURVAS_OPCIONES.Grid.TextMatrix(FRM_MNT_CURVAS_OPCIONES.Grid.Rows - 1, 3) = CDbl(Hoja.Cells(Cont, "G"))
         Let FRM_MNT_CURVAS_OPCIONES.Grid.TextMatrix(FRM_MNT_CURVAS_OPCIONES.Grid.Rows - 1, 4) = Hoja.Cells(Cont, "A")
         Let FRM_MNT_CURVAS_OPCIONES.Grid.TextMatrix(FRM_MNT_CURVAS_OPCIONES.Grid.Rows - 1, 5) = Hoja.Cells(Cont, "C")
         Let FRM_MNT_CURVAS_OPCIONES.Grid.TextMatrix(FRM_MNT_CURVAS_OPCIONES.Grid.Rows - 1, 6) = Hoja.Cells(Cont, "D")
         Let FRM_MNT_CURVAS_OPCIONES.Grid.TextMatrix(FRM_MNT_CURVAS_OPCIONES.Grid.Rows - 1, 7) = Hoja.Cells(Cont, "H")
      End If
'--
End Sub

Private Function CargaExcell(curva As String, Plazo As Double, vBid As Double, vAsk As Double, cTipo As String, cOrigen As String) As Boolean
   Dim Datos()
   
   Let CargaExcell = False
   Let oMensaje = ""

   Envia = Array()
   AddParam Envia, CDbl(7)
   AddParam Envia, Format(Fecha.Text, "yyyymmdd")
   AddParam Envia, curva
   AddParam Envia, CDbl(Plazo)
   AddParam Envia, CDbl(vBid)
   AddParam Envia, CDbl(vAsk)
   AddParam Envia, cTipo
   AddParam Envia, cOrigen
   If Not Bac_Sql_Execute("SP_MNT_CURVAS", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) < 0 Then
         oMensaje = Datos(2)
         Exit Function
      End If
   End If
      
   Envia = Array()
   AddParam Envia, CDbl(6)
   AddParam Envia, Format(Fecha.Text, "yyyymmdd")
   AddParam Envia, curva
   AddParam Envia, CDbl(Plazo)
   AddParam Envia, CDbl(vBid)
   AddParam Envia, CDbl(vAsk)
   AddParam Envia, cTipo
   AddParam Envia, cOrigen
   If Not Bac_Sql_Execute("SP_MNT_CURVAS", Envia) Then
      Exit Function
   End If
   
   
   Let CargaExcell = True
End Function

Private Function ValidaExistencia(cCurva As String, ByRef Mensaje As String) As Boolean
   Dim Datos()
   
   Let ValidaExistencia = False
   
   Envia = Array()
   AddParam Envia, CDbl(5)
   AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
   AddParam Envia, cCurva
   If Not Bac_Sql_Execute("SP_MNT_CURVAS", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) < 0 Then
         If InStr(1, Mensaje, cCurva) = 0 Then
            Let Mensaje = Mensaje & Datos(2) & vbCrLf
         End If
         Exit Function
      End If
   End If
   
   Let ValidaExistencia = True
End Function

Private Function ExistenCargadas() As Boolean
   Dim Datos()
   
   ExistenCargadas = False
   
   Envia = Array()
   AddParam Envia, CDbl(4)
   AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
   If Not Bac_Sql_Execute("SP_MNT_CURVAS", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) < 0 Then
         If MsgBox("Carga de Curvas ." & vbCrLf & vbCrLf & Datos(2) & vbCrLf & vbCrLf & "¿ Desea volver a cargar ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
            Let ExistenCargadas = True
         End If
      End If
   End If
End Function


Private Sub AJObjeto(Marco As MSFlexGrid, Objeto As Control)
   On Error Resume Next

   Let Objeto.Top = Marco.CellTop + Marco.Top
   Let Objeto.Left = Marco.CellLeft + Marco.Left
   Let Objeto.Height = Marco.CellHeight + 20
   Let Objeto.Width = Marco.CellWidth

   On Error GoTo 0
End Sub

Private Sub Habilitacion(ByVal iVal_ As Boolean, iObjeto As Object)
   Let Toolbar1.Enabled = Not iVal_
   Let CuadroFecha.Enabled = Not iVal_
   Let Grid.Enabled = Not iVal_
   Let iObjeto.Visible = iVal_

   If iVal_ = True Then
      Call iObjeto.SetFocus
   Else
      Call Grid.SetFocus
   End If
End Sub

Private Sub Eliminar()

    Dim curva As String
    
   If MsgBox("Esperando Confirmación ..." & vbCrLf & vbCrLf & "¿ Esta seguro de Querer Eliminar en Forma Permanente la Curva ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
      Exit Sub
   End If

   curva = Trim(Left(Curvas.Text, 20))

   Envia = Array()
   AddParam Envia, CDbl(2)
   AddParam Envia, Format(Fecha.Text, "yyyymmdd")
   AddParam Envia, Trim(Left(Curvas.Text, 20))
   If Not Bac_Sql_Execute("SP_MNT_CURVAS", Envia) Then
      MsgBox "Error." & vbCrLf & vbCrLf & "... Error en la Eliminación de la Curva.", vbExclamation, TITSISTEMA
      Exit Sub
   End If

   If VerififcaSistemaOpciones = True Then
       Call FRM_MNT_CURVAS_OPCIONES.EliminaCurvasOpciones(Fecha.Text)
   End If

   Call MsgBox("Tarea Finalizada." & vbCrLf & vbCrLf & "Curva ha Sido Eliminada ...", vbInformation, App.Title)
   Let Curvas.ListIndex = -1
   Let Grid.Rows = 1
   
   '+++jcamposd marca acción en LOG, cuando parametro es 6 graba
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                    , gsbac_fecp _
                    , gsBac_IP _
                    , gsBAC_User _
                    , "PCA" _
                    , "Opc_IngresoCurvas" _
                    , "03" _
                    , curva & " Curva Elimiada" _
                    , " " _
                    , " " _
                    , " ")
   
   '---jcamposd
   
End Sub


Private Sub GrabarCurvas()
   On Error GoTo ErrSaveData
   Dim iContador  As Long
   Dim dFecha     As Date
   Dim cCurva     As String
   Dim iDias      As Long
   Dim vValorBID  As Double
   Dim vValorASK  As Double
   Dim cTipo      As String
   Dim cOrigen    As String
   
   If MsgBox("¿ Esta seguro que desea Actualizar los valores ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
      Exit Sub
   End If
   
   Call BacBeginTransaction
   
   Let dFecha = CDate(Fecha.Text)
   Let cCurva = Trim(Mid(Curvas.Text, 1, 50))
   
   Envia = Array()
   AddParam Envia, CDbl(2)
   AddParam Envia, Format(dFecha, "yyyymmdd")
   AddParam Envia, cCurva
   If Not Bac_Sql_Execute("SP_MNT_CURVAS", Envia) Then
      GoTo ErrSaveData
   End If

   Let Flood.FloodPercent = 0
   For iContador = 1 To Grid.Rows - 1
      Let Flood.FloodPercent = ((iContador * 100) / (Grid.Rows - 1))
   
      Let iDias = Grid.TextMatrix(iContador, 0)
      Let vValorBID = Grid.TextMatrix(iContador, 1)
      Let vValorASK = Grid.TextMatrix(iContador, 2)
      Let cTipo = Grid.TextMatrix(iContador, 4)
      Let cOrigen = Grid.TextMatrix(iContador, 5)
      
      Envia = Array()
      AddParam Envia, CDbl(3)
      AddParam Envia, Format(dFecha, "yyyymmdd")
      AddParam Envia, cCurva
      AddParam Envia, CDbl(iDias)
      AddParam Envia, CDbl(vValorBID)
      AddParam Envia, CDbl(vValorASK)
      AddParam Envia, cTipo
      AddParam Envia, cOrigen
      If Not Bac_Sql_Execute("SP_MNT_CURVAS", Envia) Then
         GoTo ErrSaveData
      End If
   Next iContador
   
   '+++jcamposd marca acción en LOG
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                    , gsbac_fecp _
                    , gsBac_IP _
                    , gsBAC_User _
                    , "PCA" _
                    , "Opc_IngresoCurvas" _
                    , "02" _
                    , iContador & " Registros de Curvas" _
                    , " " _
                    , " " _
                    , " ")
   '---jcamposd
   
   

   Call BacCommitTransaction
   Call MsgBox("Acción Ok." & vbCrLf & vbCrLf & "Actualización de valores a la fecha ha finalizado Ok.", vbInformation, App.Title)
   Let Flood.FloodPercent = 0
   
Exit Sub
ErrSaveData:
   Call BacRollBackTransaction
   Call MsgBox("Acción Error." & vbCrLf & vbCrLf & "Error en la actualización de valores para la fecha.", vbInformation, App.Title)
End Sub

Private Sub CunsultaCurvas()
   Dim cCurva  As String
   Dim dFecha  As Date
   Dim Datos()
   
   Let dFecha = CDate(Fecha.Text)
   Let cCurva = Trim(Mid(Curvas.Text, 1, 50))
   
   Envia = Array()
   AddParam Envia, CDbl(1)
   AddParam Envia, Format(dFecha, "yyyymmdd")
   AddParam Envia, cCurva
   If Not Bac_Sql_Execute("SP_MNT_CURVAS", Envia) Then
      Call MsgBox("Acción Error." & vbCrLf & vbCrLf & "Error en la consulta de valores a la fecha.", vbExclamation, App.Title)
      Exit Sub
   End If
   Let Grid.Rows = Grid.FixedRows
   Do While Bac_SQL_Fetch(Datos())
      Let Grid.Rows = Grid.Rows + 1
      Let Grid.TextMatrix(Grid.Rows - 1, 0) = Format(Datos(3), FEntero)  '--> Dias
      Let Grid.TextMatrix(Grid.Rows - 1, 1) = Format(Datos(4), FDecimal) '--> Bid
      Let Grid.TextMatrix(Grid.Rows - 1, 2) = Format(Datos(5), FDecimal) '--> Ask
      Let Grid.TextMatrix(Grid.Rows - 1, 3) = Datos(2)                   '--> Curva
      Let Grid.TextMatrix(Grid.Rows - 1, 4) = Datos(6)                   '--> Tipo
      Let Grid.TextMatrix(Grid.Rows - 1, 5) = Datos(7)                   '--> Origen
   Loop
End Sub

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)
   Call CargaCurvasCreadas
End Sub
