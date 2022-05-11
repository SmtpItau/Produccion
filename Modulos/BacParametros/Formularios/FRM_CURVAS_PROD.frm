VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_CURVAS_PROD 
   Caption         =   "Curvas por Producto.-"
   ClientHeight    =   4605
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10335
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   4605
   ScaleWidth      =   10335
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10335
      _ExtentX        =   18230
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      ToolTips        =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5100
         Top             =   60
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   6
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CURVAS_PROD.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CURVAS_PROD.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CURVAS_PROD.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CURVAS_PROD.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CURVAS_PROD.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CURVAS_PROD.frx":4A42
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame CuadroCurva 
      Height          =   540
      Left            =   45
      TabIndex        =   1
      Top             =   450
      Width           =   10245
      Begin VB.ComboBox Tipo 
         Enabled         =   0   'False
         Height          =   315
         Left            =   8385
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   135
         Width           =   1740
      End
      Begin VB.TextBox Descripcion 
         Enabled         =   0   'False
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
         Left            =   3870
         TabIndex        =   5
         Top             =   135
         Width           =   4035
      End
      Begin VB.TextBox Curva 
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
         Left            =   630
         Locked          =   -1  'True
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   3
         Top             =   150
         Width           =   2250
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Tipo"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   180
         Index           =   2
         Left            =   7995
         TabIndex        =   6
         Top             =   210
         Width           =   300
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Descripción"
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
         Left            =   3000
         TabIndex        =   4
         Top             =   210
         Width           =   810
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Curva"
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
         Top             =   210
         Width           =   435
      End
   End
   Begin VB.Frame CuadroGrid 
      Enabled         =   0   'False
      Height          =   3660
      Left            =   45
      TabIndex        =   8
      Top             =   915
      Width           =   10245
      Begin BACControles.TXTNumero txtTasa 
         Height          =   315
         Left            =   1605
         TabIndex        =   11
         Top             =   1620
         Visible         =   0   'False
         Width           =   795
         _ExtentX        =   1402
         _ExtentY        =   556
         BackColor       =   -2147483646
         ForeColor       =   -2147483643
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.ComboBox ComboGrid 
         BackColor       =   &H80000002&
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000005&
         Height          =   315
         Left            =   750
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   1620
         Visible         =   0   'False
         Width           =   870
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   3450
         Left            =   30
         TabIndex        =   9
         Top             =   135
         Width           =   10170
         _ExtentX        =   17939
         _ExtentY        =   6085
         _Version        =   393216
         Rows            =   3
         Cols            =   8
         FixedCols       =   0
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483633
         Enabled         =   0   'False
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   1
      End
   End
End
Attribute VB_Name = "FRM_CURVAS_PROD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Const Modulo = 0
Private Const Producto = 1
Private Const Moneda = 2
Private Const Instrumento = 3
Private Const Emisor = 4
Private Const TasaDesde = 5
Private Const TasaHasta = 6
Private Const IndTasaSwap = 7
Private Const IndBaseSwap = 8
Private Const CurAlter = 9
Private Const Spread = 10
Private Const CurSpread = 11
Private Const RutEmisor = 12
Private Const Indicador = 13

Private Sub HabilitaTool()
   Toolbar1.Buttons(1).Enabled = True
   Toolbar1.Buttons(2).Enabled = True
   Toolbar1.Buttons(3).Enabled = True
   Toolbar1.Buttons(4).Enabled = True
   Toolbar1.Buttons(5).Enabled = True
End Sub

Private Sub FormateaGrid()
   Let Grid.Rows = 3:             Grid.FixedRows = 2
   Let Grid.Cols = Indicador + 1: Grid.FixedCols = 0
   
   Let Grid.Font.Name = "Thaoma"
   Let Grid.Font.Size = 8
   Let Grid.RowHeightMin = 350
   
   Let Grid.TextMatrix(0, Modulo) = "Modulo":            Let Grid.ColWidth(Modulo) = 2000:                                                            Let Grid.ColAlignment(Modulo) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, Producto) = "Producto":        Let Grid.ColWidth(Producto) = 3000:                                                          Let Grid.ColAlignment(Producto) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, Moneda) = "Moneda":            Let Grid.ColWidth(Moneda) = 1000:                                                            Let Grid.ColAlignment(Moneda) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, Instrumento) = "Instrumento":  Let Grid.ColWidth(Instrumento) = 1500:                                                       Let Grid.ColAlignment(Instrumento) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, Emisor) = "Emisor":            Let Grid.ColWidth(Emisor) = 2500:                                                            Let Grid.ColAlignment(Emisor) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, TasaDesde) = "Emisión":        Let Grid.ColWidth(TasaDesde) = 1100:   Let Grid.TextMatrix(1, TasaDesde) = "Desde":          Let Grid.ColAlignment(TasaDesde) = flexAlignRightCenter
   Let Grid.TextMatrix(0, TasaHasta) = "Emisión":        Let Grid.ColWidth(TasaHasta) = 1100:   Let Grid.TextMatrix(1, TasaHasta) = "Hasta":          Let Grid.ColAlignment(TasaHasta) = flexAlignRightCenter
   Let Grid.TextMatrix(0, IndTasaSwap) = "Tipo":         Let Grid.ColWidth(IndTasaSwap) = 1000: Let Grid.TextMatrix(1, IndTasaSwap) = "Tasa":         Let Grid.ColAlignment(IndTasaSwap) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, IndBaseSwap) = "Base":         Let Grid.ColWidth(IndBaseSwap) = 0:    Let Grid.TextMatrix(1, IndBaseSwap) = "Base":         Let Grid.ColAlignment(IndBaseSwap) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, CurAlter) = "Curva":           Let Grid.ColWidth(CurAlter) = 1500:    Let Grid.TextMatrix(1, CurAlter) = "Alternativa":     Let Grid.ColAlignment(CurAlter) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, Spread) = "Spread":            Let Grid.ColWidth(Spread) = 1000:                                                            Let Grid.ColAlignment(Spread) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, CurSpread) = "Curva":          Let Grid.ColWidth(CurSpread) = 1500:   Let Grid.TextMatrix(1, CurSpread) = "Spread":         Let Grid.ColAlignment(CurSpread) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, RutEmisor) = "RutEmi":         Let Grid.ColWidth(RutEmisor) = 0:                                                            Let Grid.ColAlignment(RutEmisor) = flexAlignRightCenter
   Let Grid.TextMatrix(0, Indicador) = "Indicador":      Let Grid.ColWidth(Indicador) = 1500:                                                         Let Grid.ColAlignment(Indicador) = flexAlignLeftCenter
End Sub

Private Sub CargaTiposCurvas()
   Tipo.Clear
   Tipo.AddItem "TASA":    Tipo.ItemData(Tipo.NewIndex) = 0
   Tipo.AddItem "SPREAD":  Tipo.ItemData(Tipo.NewIndex) = 1
   Tipo.ListIndex = 0
End Sub

Private Sub ComboGrid_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim sLimpia As Boolean

   sLimpia = False

   If KeyCode = vbKeyReturn Then
      If Mid(Grid.TextMatrix(Grid.RowSel, Grid.ColSel), 1, 100) <> Mid(ComboGrid.Text, 1, 100) Then
         sLimpia = True
      End If
      Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = ComboGrid.Text
      If Grid.ColSel = Instrumento Then
         Let Grid.TextMatrix(Grid.RowSel, RutEmisor) = ComboGrid.Text
      End If

      If sLimpia = True Then
         Call LimpiaColumnas(Grid.RowSel, Grid.ColSel + 1)
      End If
      Let Grid.Enabled = True
      Let ComboGrid.Visible = False
   End If

   If KeyCode = vbKeyEscape Then
      Let Grid.Enabled = True
      Let ComboGrid.Visible = False
   End If

End Sub

Private Sub Curva_DblClick()
   Call Limpiar

   Let BacAyuda.Tag = "CURVAS"
   Call BacAyuda.Show(vbModal)

   If giAceptar = True Then
      Let Curva.Text = gsNombre
      Let Tipo.Text = IIf(gsNemo = "S", "SPREAD", "TASA")
      Let Descripcion = gsDescripcion$

      Call BuscarCurvasProProducto
      Call HabilitaTool
   End If

End Sub

Private Sub Limpiar()
   Let CuadroGrid.Enabled = True
   Let Grid.Rows = 2
   Let Grid.Enabled = True
   Let Curva.Text = ""
   Let Descripcion.Text = ""
   Let Tipo.ListIndex = -1
End Sub

Private Sub Form_Load()
   Let Me.Icon = BACSwapParametros.Icon
   Let Me.Top = 0: Let Me.Left = 0
   
   Call CargaTiposCurvas
   Call FormateaGrid
End Sub

Private Sub Form_Resize()
   On Error Resume Next
      Let CuadroCurva.Width = Me.Width - 150
      Let CuadroGrid.Width = CuadroCurva.Width
      Let Grid.Width = CuadroGrid.Width - 150

      Let CuadroGrid.Height = Me.Height - 1400
      Let Grid.Height = CuadroGrid.Height - 250
   On Error GoTo 0
End Sub

Private Sub GRID_DblClick()
   If Grid.ColSel = CurAlter Or Grid.ColSel = CurSpread Then
      Call Grid_KeyDown(vbKeyReturn, 0)
   End If
End Sub

Private Function RetornaNumero(KeyNum As Variant) As Integer
   Select Case KeyNum
      Case vbKeyNumpad0: RetornaNumero = 0
      Case vbKeyNumpad1: RetornaNumero = 1
      Case vbKeyNumpad2: RetornaNumero = 2
      Case vbKeyNumpad3: RetornaNumero = 3
      Case vbKeyNumpad4: RetornaNumero = 4
      Case vbKeyNumpad5: RetornaNumero = 5
      Case vbKeyNumpad6: RetornaNumero = 6
      Case vbKeyNumpad7: RetornaNumero = 7
      Case vbKeyNumpad8: RetornaNumero = 8
      Case vbKeyNumpad9: RetornaNumero = 9
   End Select
End Function

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim cSistema      As String
   Dim cProducto     As String
   Dim cMoneda       As String
   Dim cInstrumento  As String

   If Grid.ColSel = TasaDesde Or Grid.ColSel = TasaHasta Then
      If KeyCode >= vbKeyNumpad0 And KeyCode <= vbKeyNumpad9 Then
         Let Grid.Enabled = False
         Let txtTasa.Visible = True
         Call AJObjeto(Grid, txtTasa)
         Call txtTasa.SetFocus
         Let txtTasa.Text = Format(RetornaNumero(KeyCode), FDecimal)
         Call txtTasa.SetFocus
      End If
   End If

   If KeyCode = vbKeyBack And Grid.Rows > 2 And Grid.RowSel >= 2 Then
      If Grid.TextMatrix(Grid.RowSel, Grid.ColSel) <> "" Then
         If MsgBox("¿ Esta seguro que desea borra el contenido de esta Celda. ?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
            Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = ""
            Call Grid.SetFocus
         End If
      End If
   End If

   If KeyCode = vbKeyReturn Then
   
      Let cSistema = Trim(Right(Grid.TextMatrix(Grid.RowSel, Modulo), 5))
      Let cProducto = Trim(Right(Grid.TextMatrix(Grid.RowSel, Producto), 5))
      Let cMoneda = Trim(Right(Grid.TextMatrix(Grid.RowSel, Moneda), 5))
      Let cInstrumento = Trim(Left(Grid.TextMatrix(Grid.RowSel, Instrumento), 100))

      If Grid.ColSel = Modulo Then
         Call CargaComboGrilla(Grid.ColSel, ComboGrid)
      End If

      If Grid.ColSel = Producto Then
         If cSistema = "" Then
            Exit Sub
         End If
         Call CargaComboGrilla(Grid.ColSel, ComboGrid, cSistema)
      End If

      If Grid.ColSel = Moneda Then
         If cProducto = "" Then
            Call CargaComboGrilla(Grid.ColSel, ComboGrid, cSistema & "','" & cProducto)
            Exit Sub
         End If
         Call CargaComboGrilla(Grid.ColSel, ComboGrid, cSistema & "','" & cProducto)
      End If
      '+++COLTES, jcamposd 20171205, se suma bex
      If (Grid.ColSel = Instrumento And cSistema = "BTR") Or (Grid.ColSel = Instrumento And cSistema = "BFW" And cProducto = "10") Or (Grid.ColSel = Instrumento And cSistema = "BEX") Then
         If cProducto = "" Then
            Exit Sub
         End If
         Call CargaComboGrilla(Grid.ColSel, ComboGrid, cSistema & "','" & cProducto)
      End If

      
      If Grid.ColSel = Emisor And (cSistema = "BTR" Or cSistema = "BEX") Then
         If cInstrumento = "" Then
            Exit Sub
         End If
        '+++COLTES, jcamposd 20171205 se suma bex
        If cSistema = "BTR" Then
            Let BacAyuda.Tag = "EMISOR"
        Else
            Let BacAyuda.Tag = "EMISOR_BONOS_EXT"
        End If
        '---COLTES, jcamposd 20171205 se suma bex
         Call BacAyuda.Show(vbModal)
         If giAceptar% = True Then
            Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = gsDescripcion$ & Space(100) & gsGenerico$
         End If
      End If

      If Grid.ColSel = CurAlter Then
         Let BacAyuda.Tag = "CURVAS_T"
         Call BacAyuda.Show(vbModal)
         If giAceptar = True Then
            Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = gsNombre
         End If
         Call Grid.SetFocus
      End If

      If Grid.ColSel = Spread Then
         Call CargaComboGrilla(Grid.ColSel, ComboGrid)
      End If

      If Grid.ColSel = CurSpread Then
         BacAyuda.Tag = "CURVAS_S"
         BacAyuda.Show 1
         If giAceptar = True Then
            Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = gsNombre
         End If
         Grid.SetFocus
      End If

      If cSistema = "BTR" And (Grid.ColSel = TasaDesde Or Grid.ColSel = TasaHasta) Then
         Grid.Enabled = False
         txtTasa.Text = Format(0, FDecimal)
         If Grid.TextMatrix(Grid.RowSel, Grid.ColSel) <> "" Then
            txtTasa.Text = CDbl(Grid.TextMatrix(Grid.RowSel, Grid.ColSel))
         End If
         txtTasa.Visible = True
         Call AJObjeto(Grid, txtTasa)
         txtTasa.SetFocus
      End If

      If Grid.ColSel = IndTasaSwap And cSistema = "PCS" Then 'And cProducto = "SM" Then
         Call CargaComboGrilla(Grid.ColSel, ComboGrid)
      End If
      If Grid.ColSel = IndBaseSwap And cSistema = "PCS" Then 'And cProducto = "SM" Then
         Call CargaComboGrilla(Grid.ColSel, ComboGrid, cSistema)
      End If

      If Grid.ColSel = Indicador Then
         Call CargaComboGrilla(Grid.ColSel, ComboGrid, cSistema)
      End If
   End If

   If KeyCode = vbKeyInsert Then
      Grid.Rows = Grid.Rows + 1
      Call AgregaValoresDefault
      Grid.SetFocus
   End If

   If KeyCode = vbKeyDelete Then
      If Grid.Rows = Grid.FixedRows + 1 Then
         Grid.Rows = Grid.FixedRows
         Grid.Rows = Grid.FixedRows + 1
      Else
         Grid.RemoveItem (Grid.RowSel)
      End If
      Grid.SetFocus
   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call BuscarCurvasProProducto
      Case 2
         Call GrabarCurvasProducto
      Case 3
      Case 4
      Case 5
      Case 6
         Unload Me
   End Select
End Sub

Private Sub GrabarCurvasProducto()
   On Error GoTo ErrSaveData
   Dim iContador        As Long
   Dim cCurvaProducto   As String
   Dim cSistema         As String
   Dim cProducto        As String
   Dim iMoneda          As Integer
   Dim cInstrumento     As String
   Dim cEmisor          As String
   Dim cCurvaAlter      As String
   Dim sSpread          As String
   Dim cCurvaSpread     As String
   Dim nTasaDesde       As Double
   Dim nTasaHasta       As Double
   Dim cTipoTasa        As String
   Dim cTipoBase        As String
   Dim iIndicador       As Integer

   Let cCurvaProducto = Curva.Text

   Call BacBeginTransaction

   Envia = Array()
   AddParam Envia, CDbl(2)
   AddParam Envia, cCurvaProducto
   If Not Bac_Sql_Execute("SP_MNT_CURVAS_PRODUCTO", Envia) Then
      GoTo ErrSaveData
   End If

   For iContador = 2 To Grid.Rows - 1
      Let cSistema = Trim(Right(Grid.TextMatrix(iContador, Modulo), 3))
      Let cProducto = Trim(Right(Grid.TextMatrix(iContador, Producto), 7))
      Let cProducto = IIf(cProducto = "", "*", cProducto)

      Let iMoneda = Val(Trim(Right(Grid.TextMatrix(iContador, Moneda), 5)))
      Let iMoneda = IIf(iMoneda = 0, 0, iMoneda)

      If cSistema = "" And cProducto = "*" And iMoneda = 0 Then
         Exit For
      End If

      Let cInstrumento = Trim(IIf(Grid.TextMatrix(iContador, Instrumento) = "", "*", Left(Grid.TextMatrix(iContador, Instrumento), 30)))

      If Grid.TextMatrix(iContador, Emisor) = "" Then
         Let cEmisor = "*"
      Else
         Let cEmisor = Trim(IIf(Grid.TextMatrix(iContador, Emisor) = "", "*", Right(Grid.TextMatrix(iContador, Emisor), 10)))
      End If

      Let cCurvaAlter = Grid.TextMatrix(iContador, CurAlter)
      Let sSpread = IIf(Grid.TextMatrix(iContador, Spread) = "", "N", Left(Grid.TextMatrix(iContador, Spread), 1))
      Let cCurvaSpread = Grid.TextMatrix(iContador, CurSpread)

      Let nTasaDesde = Grid.TextMatrix(iContador, TasaDesde)
      Let nTasaHasta = Grid.TextMatrix(iContador, TasaHasta)

      Let cTipoTasa = Grid.TextMatrix(iContador, IndTasaSwap)
      Let cTipoTasa = IIf(cTipoTasa = "", "N", Trim(Right(cTipoTasa, 2)))
      Let cTipoBase = Val(Right(Grid.TextMatrix(iContador, IndBaseSwap), 4))

      Let iIndicador = Val(Right(Grid.TextMatrix(iContador, Indicador), 5))

      Envia = Array()
      AddParam Envia, CDbl(3)
      AddParam Envia, cCurvaProducto
      AddParam Envia, cSistema
      AddParam Envia, cProducto
      AddParam Envia, iMoneda
      AddParam Envia, cInstrumento
      AddParam Envia, cEmisor
      AddParam Envia, cCurvaAlter
      AddParam Envia, sSpread
      AddParam Envia, cCurvaSpread
      AddParam Envia, nTasaDesde
      AddParam Envia, nTasaHasta
      AddParam Envia, cTipoTasa
      AddParam Envia, cTipoBase
      AddParam Envia, iIndicador
      If Not Bac_Sql_Execute("SP_MNT_CURVAS_PRODUCTO", Envia) Then
         GoTo ErrSaveData
      End If
   Next iContador

   Call BacCommitTransaction

   MsgBox "Actualización Ok." & vbCrLf & vbCrLf & "Grabación ha finalizado en forma correcta.", vbInformation, TITSISTEMA

   Call Limpiar

   On Error GoTo 0
Exit Sub
ErrSaveData:
   Call BacRollBackTransaction
   MsgBox "Error de Grabación." & vbCrLf & vbCrLf & "No se ha podido finalizar la grabación." & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
   On Error GoTo 0
End Sub

Private Sub BuscarCurvasProProducto()
   On Error GoTo ErrReadCurprod
   Dim cCurvaProducto   As String

   Let cCurvaProducto = Curva.Text

   Envia = Array()
   AddParam Envia, CDbl(1)
   AddParam Envia, cCurvaProducto
   If Not Bac_Sql_Execute("SP_MNT_CURVAS_PRODUCTO", Envia) Then
      GoTo ErrReadCurprod
   End If

   Grid.Rows = 2
   Do While Bac_SQL_Fetch(Datos())
      Grid.Rows = Grid.Rows + 1
      Grid.TextMatrix(Grid.Rows - 1, Modulo) = Datos(2)
      Grid.TextMatrix(Grid.Rows - 1, Producto) = Datos(3)
      Grid.TextMatrix(Grid.Rows - 1, Moneda) = Datos(4)
      Grid.TextMatrix(Grid.Rows - 1, Instrumento) = Datos(5)
      Grid.TextMatrix(Grid.Rows - 1, Emisor) = Datos(6)

      Grid.TextMatrix(Grid.Rows - 1, TasaDesde) = Format(Datos(11), FDecimal)
      Grid.TextMatrix(Grid.Rows - 1, TasaHasta) = Format(Datos(12), FDecimal)

      Grid.TextMatrix(Grid.Rows - 1, CurAlter) = Datos(7)
      Grid.TextMatrix(Grid.Rows - 1, Spread) = Datos(8)
      Grid.TextMatrix(Grid.Rows - 1, CurSpread) = Datos(9)
      Grid.TextMatrix(Grid.Rows - 1, RutEmisor) = Datos(10)

      Grid.TextMatrix(Grid.Rows - 1, IndTasaSwap) = Datos(13) & Space(100) & Left(Datos(13), 1)
      Grid.TextMatrix(Grid.Rows - 1, IndBaseSwap) = Datos(14) & Space(100) & Right(Datos(14), 1)

      Grid.TextMatrix(Grid.Rows - 1, Indicador) = Datos(15)
   Loop

   On Error GoTo 0
Exit Sub
ErrReadCurprod:
   On Error GoTo 0
   MsgBox "ERROR LECTURA " & vbCrLf & vbCrLf & "Problemas en la Carga de Curvas por Producto.", vbExclamation, TITSISTEMA
End Sub

Private Sub CargaComboGrilla(ByVal Columna As Integer, ByRef Objeto As ComboBox, Optional oCadena As String)
   On Error GoTo ErrorCargaElemento
   Dim Datos()
   Dim iContador  As Integer
   Dim cTexto     As String
   Dim cProducto  As String

   Envia = Array()
   AddParam Envia, Columna
   If Columna > 0 Then
      AddParam Envia, oCadena
   End If
   If Columna = Indicador Then  '--> 8
      AddParam Envia, Right(Grid.TextMatrix(Grid.RowSel, Producto), 2)
      AddParam Envia, ""
      AddParam Envia, Val(Trim(Right(Grid.TextMatrix(Grid.RowSel, Moneda), 5)))
   End If

   If Not Bac_Sql_Execute("CARGA_COMBO_GRILLA_CURVAS", Envia) Then
      GoTo ErrorCargaElemento
   End If

   Objeto.Clear
   If Columna = Emisor Then '--> 4
      Objeto.AddItem "*" & Space(100) & ""
   End If
   If Columna = Spread Then '--> 6
      Objeto.Clear
      Objeto.AddItem "SI" & Space(100) & "S"
      Objeto.AddItem "NO" & Space(100) & "N"
   End If
   If Columna = IndTasaSwap Then  '--> 6
      Objeto.Clear
      Objeto.AddItem "FIJA" & Space(100) & "F"
      Objeto.AddItem "VARIABLE" & Space(100) & "V"
   End If
   If Columna = IndBaseSwap Then  '--> 8
      Objeto.Clear
      Objeto.AddItem " " & Space(100) & "0"
   End If

   Do While Bac_SQL_Fetch(Datos())
      If Columna = Indicador Then
         Objeto.AddItem Datos(1) & Space(100) & Datos(2)
         Let Objeto.ItemData(Objeto.NewIndex) = Val(Datos(3))
      Else
         Objeto.AddItem Datos(1) & Space(100) & Datos(2)
      End If
      
      If Columna = Instrumento Then   '--> 3
         Let Objeto.ItemData(Objeto.NewIndex) = Val(Datos(3))
      End If
   Loop

   Let cTexto = Mid(Grid.TextMatrix(Grid.RowSel, Grid.ColSel), 1, 100)
   If cTexto <> "" Then
      For iContador = 0 To Objeto.ListCount - 1
         If Objeto.List(iContador) Like "*" & cTexto & "*" Then
            Let Objeto.ListIndex = iContador
         End If
      Next iContador
   Else
      Let Objeto.ListIndex = -1
   End If
   
   Call AJObjeto(Grid, Objeto)
   
   Let Objeto.Visible = True
   Call Objeto.SetFocus
   Let Grid.Enabled = False

   On Error GoTo 0
Exit Sub
ErrorCargaElemento:
   MsgBox "Problemas en la Carga de Contenido Para Asignación", vbExclamation, TITSISTEMA
   On Error GoTo 0
End Sub

Private Sub AJObjeto(Marco As MSFlexGrid, Objeto As Control)
   On Error Resume Next
   Let Objeto.Top = Marco.CellTop + Marco.Top
   Let Objeto.Left = Marco.CellLeft + Marco.Left
   Let Objeto.Height = Marco.CellHeight + 20
   Let Objeto.Width = Marco.CellWidth
   On Error GoTo 0
End Sub

Private Sub LimpiaColumnas(ByVal iFila As Integer, ByVal iColumna As Integer)
   Dim iContador  As Integer

   For iContador = iColumna To Grid.Cols - 1
      Let Grid.TextMatrix(iFila, iContador) = ""
   Next iContador

   If iColumna <= TasaDesde Then
      Let Grid.TextMatrix(iFila, TasaDesde) = Format(0, FDecimal)
      Let Grid.TextMatrix(iFila, TasaHasta) = Format(0, FDecimal)
   End If
End Sub

Private Sub txtTasa_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyEscape Then
      Let Grid.Enabled = True
      Let txtTasa.Visible = False
      Call Grid.SetFocus
   End If
   If KeyCode = vbKeyReturn Then
      Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = txtTasa.Text
      Let Grid.Enabled = True
      Let txtTasa.Visible = False
      Call Grid.SetFocus
   End If
End Sub

Private Sub AgregaValoresDefault()
   Let Grid.TextMatrix(Grid.Rows - 1, Modulo) = ""
   Let Grid.TextMatrix(Grid.Rows - 1, Producto) = ""
   Let Grid.TextMatrix(Grid.Rows - 1, Moneda) = "" & Space(100) & "0"
   Let Grid.TextMatrix(Grid.Rows - 1, Instrumento) = Space(100) & "0"
   Let Grid.TextMatrix(Grid.Rows - 1, Emisor) = ""
   Let Grid.TextMatrix(Grid.Rows - 1, TasaDesde) = Format(0#, FDecimal)
   Let Grid.TextMatrix(Grid.Rows - 1, TasaHasta) = Format(0#, FDecimal)
   Let Grid.TextMatrix(Grid.Rows - 1, IndTasaSwap) = ""
   Let Grid.TextMatrix(Grid.Rows - 1, IndBaseSwap) = 0
   Let Grid.TextMatrix(Grid.Rows - 1, CurAlter) = ""
   Let Grid.TextMatrix(Grid.Rows - 1, Spread) = ""
   Let Grid.TextMatrix(Grid.Rows - 1, CurSpread) = ""
   Let Grid.TextMatrix(Grid.Rows - 1, RutEmisor) = ""
   Let Grid.TextMatrix(Grid.Rows - 1, Indicador) = -1
End Sub
