VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_MATRIZ_CONTROL 
   Caption         =   "Matriz de Control."
   ClientHeight    =   4680
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7155
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   4680
   ScaleWidth      =   7155
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7155
      _ExtentX        =   12621
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar Informacion"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   2760
         Top             =   45
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   5
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_MATRIZ_CONTROL.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_MATRIZ_CONTROL.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_MATRIZ_CONTROL.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_MATRIZ_CONTROL.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_MATRIZ_CONTROL.frx":3B68
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame fraCuadro 
      Height          =   4200
      Left            =   0
      TabIndex        =   1
      Top             =   435
      Width           =   7095
      Begin VB.Frame fraFiltro 
         Height          =   1230
         Left            =   75
         TabIndex        =   2
         Top             =   120
         Width           =   6930
         Begin VB.ComboBox cmbMoneda 
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   1200
            Style           =   2  'Dropdown List
            TabIndex        =   8
            Top             =   825
            Width           =   2925
         End
         Begin VB.ComboBox cmbProducto 
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   1200
            Style           =   2  'Dropdown List
            TabIndex        =   6
            Top             =   495
            Width           =   4170
         End
         Begin VB.ComboBox cmbSistema 
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   1200
            Style           =   2  'Dropdown List
            TabIndex        =   4
            Top             =   165
            Width           =   4170
         End
         Begin VB.Label Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Moneda"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Index           =   2
            Left            =   100
            TabIndex        =   7
            Top             =   885
            Width           =   675
         End
         Begin VB.Label Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Producto"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Index           =   1
            Left            =   100
            TabIndex        =   5
            Top             =   555
            Width           =   765
         End
         Begin VB.Label Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Sistema"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Index           =   0
            Left            =   100
            TabIndex        =   3
            Top             =   225
            Width           =   690
         End
      End
      Begin VB.Frame fraGrid 
         Height          =   2880
         Left            =   75
         TabIndex        =   9
         Top             =   1260
         Width           =   6930
         Begin BACControles.TXTNumero TxtIngreso 
            Height          =   270
            Left            =   2190
            TabIndex        =   11
            Top             =   855
            Visible         =   0   'False
            Width           =   915
            _ExtentX        =   1614
            _ExtentY        =   476
            BackColor       =   -2147483646
            ForeColor       =   -2147483639
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BorderStyle     =   0
            Text            =   "0"
            Text            =   "0"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin MSFlexGridLib.MSFlexGrid Grid 
            Height          =   2700
            Left            =   30
            TabIndex        =   10
            Top             =   135
            Width           =   6870
            _ExtentX        =   12118
            _ExtentY        =   4763
            _Version        =   393216
            Rows            =   3
            Cols            =   3
            FixedRows       =   2
            FixedCols       =   0
            RowHeightMin    =   315
            BackColor       =   -2147483644
            BackColorFixed  =   -2147483646
            ForeColorFixed  =   -2147483639
            BackColorSel    =   -2147483646
            BackColorBkg    =   -2147483645
            GridColor       =   -2147483644
            GridColorFixed  =   -2147483640
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
            AllowUserResizing=   1
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
      End
   End
End
Attribute VB_Name = "FRM_MNT_MATRIZ_CONTROL"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Enum xCarga
   [Sistema] = 1
   [Producto] = 2
   [Moneda] = 3
End Enum

Public Sub Alinear(nGrid As MSFlexGrid, nText As Object)
    On Error Resume Next
    nText.Top = nGrid.Top + nGrid.CellTop + 10
    nText.Left = nGrid.Left + nGrid.CellLeft + 50
    nText.Width = nGrid.CellWidth - 10
    nText.Height = nGrid.CellHeight - 10
    
    nText.Text = nGrid.TextMatrix(nGrid.RowSel, nGrid.ColSel)
    nText.SelStart = Len(nText.Text)
    nText.Visible = True
    nText.SetFocus
End Sub

Private Sub Validar()
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(4).Enabled = False
   
   If cmbSistema.ListIndex >= 0 And cmbProducto.ListIndex >= 0 And cmbMoneda.ListIndex >= 0 Then
      Toolbar1.Buttons(2).Enabled = True
   End If
End Sub

Private Sub BuscarInformacion(ByVal cSistema As String, ByVal cProducto As String, ByVal iMoneda As Long)
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(4)
   AddParam Envia, cSistema
   AddParam Envia, cProducto
   AddParam Envia, iMoneda
   If Not Bac_Sql_Execute("SP_MNT_MATRIZ_CONTROL", Envia) Then
      Exit Sub
   End If
   Grid.Rows = 2
   Do While Bac_SQL_Fetch(Datos())
      Grid.Rows = Grid.Rows + 1
      Grid.TextMatrix(Grid.Rows - 1, 0) = Format(Datos(1), "#,##0")
      Grid.TextMatrix(Grid.Rows - 1, 1) = Format(Datos(2), "#,##0")
      Grid.TextMatrix(Grid.Rows - 1, 2) = Format(Datos(3), "#,##0.0000")
   Loop
   
   Grid.Enabled = True
   
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = True
   Toolbar1.Buttons(4).Enabled = True
   
   cmbSistema.Enabled = False
   cmbProducto.Enabled = False
   cmbMoneda.Enabled = False
End Sub

Private Sub CaragParametros(QueCarga As xCarga, ObjCarga As ComboBox, Optional cSistema As String, Optional cProducto As String)
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(QueCarga)
   If QueCarga = Producto Then
      AddParam Envia, cSistema
   End If
   If QueCarga = Moneda Then
      AddParam Envia, cSistema
      AddParam Envia, cProducto
   End If
   If Not Bac_Sql_Execute("SP_MNT_MATRIZ_CONTROL", Envia) Then
      Exit Sub
   End If
   ObjCarga.Clear
   Do While Bac_SQL_Fetch(Datos())
      ObjCarga.AddItem Datos(2) & Space(500) & Datos(1)
      If QueCarga = Moneda Then
         ObjCarga.ItemData(ObjCarga.NewIndex) = Datos(1)
      End If
   Loop
End Sub


Private Sub Nombres_Grilla()
   Grid.Rows = 3
   Grid.Cols = 3
   Grid.FixedCols = 0
   Grid.FixedRows = 2
   
   Grid.TextMatrix(0, 0) = "Plazo":    Grid.TextMatrix(1, 0) = "Desde":    Grid.ColWidth(0) = 1500:   Grid.ColAlignment(0) = flexAlignRightCenter
   Grid.TextMatrix(0, 1) = "Plazo":    Grid.TextMatrix(1, 1) = "Hasta":    Grid.ColWidth(1) = 1500:   Grid.ColAlignment(1) = flexAlignRightCenter
   Grid.TextMatrix(0, 2) = "Ancho":    Grid.TextMatrix(1, 2) = "Banda":    Grid.ColWidth(2) = 1500:   Grid.ColAlignment(2) = flexAlignRightCenter
   
   Grid.Rows = 2
End Sub

Private Sub ValorDefecto()
   If Grid.Rows <= Grid.FixedRows Then
   Else
      If Grid.Rows > 3 Then
         Grid.TextMatrix(Grid.Rows - 1, 0) = CDbl(Grid.TextMatrix(Grid.Rows - 2, 1) + 1)
         Grid.TextMatrix(Grid.Rows - 1, 1) = CDbl(Grid.TextMatrix(Grid.Rows - 1, 0) + 1)
         Grid.TextMatrix(Grid.Rows - 1, 2) = "0.0000"
      Else
         Grid.TextMatrix(Grid.Rows - 1, 0) = "0"
         Grid.TextMatrix(Grid.Rows - 1, 1) = "1"
         Grid.TextMatrix(Grid.Rows - 1, 2) = "0.0000"
      End If
   End If
End Sub

Private Sub cmbMoneda_Click()
   Call Validar
End Sub

Private Sub cmbProducto_Click()
   Dim cSistema   As String
   Dim cProducto  As String
   
   cSistema = Trim(Right(cmbSistema.Text, 10))
   cProducto = Trim(Right(cmbProducto.Text, 10))
   
   Call CaragParametros(Moneda, cmbMoneda, cSistema, cProducto)
   
   Call Validar
End Sub

Private Sub cmbSistema_Click()
   Dim cSistema   As String
   cSistema = Trim(Right(cmbSistema.Text, 5))
   
   Call CaragParametros(Producto, cmbProducto, cSistema)
   
   cmbProducto.ListIndex = -1
   cmbMoneda.Clear
   
   Call Validar
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF1 Then
      Frm_Help.Show
   End If
End Sub

Private Sub Form_Load()
   Me.Top = 0: Me.Left = 0
   Me.Icon = BacControlFinanciero.Icon
   
   Call Nombres_Grilla
   Call ValorDefecto
   Call CaragParametros(Sistema, cmbSistema)
   Grid.Enabled = False
   
   Call Validar
End Sub

Private Sub Form_Resize()
   On Error GoTo ErrorResize
   fraCuadro.Width = Me.Width - 150
   fraFiltro.Width = fraCuadro.Width - 150
   fraGrid.Width = fraCuadro.Width - 150
   Grid.Width = fraCuadro.Width - 220
   
   fraCuadro.Height = Me.Height - 850
   fraGrid.Height = fraCuadro.Height - 1320
   Grid.Height = fraCuadro.Height - 1500
Exit Sub
ErrorResize:

End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyInsert Then
      Grid.Rows = Grid.Rows + 1
      Call ValorDefecto
   End If
   If KeyCode = vbKeyDelete Then
      If Grid.Rows > 3 Then
         Grid.RemoveItem (Grid.RowSel)
         Exit Sub
      End If
      If Grid.RowSel = Grid.FixedRows Then
         Grid.Rows = 2
      End If
   End If
   If KeyCode = vbKeyReturn Then
      If Grid.ColSel = 0 Then: TxtIngreso.CantidadDecimales = 0
      If Grid.ColSel = 1 Then: TxtIngreso.CantidadDecimales = 0
      If Grid.ColSel = 2 Then: TxtIngreso.CantidadDecimales = 4
      
      TxtIngreso.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
      Call Alinear(Grid, TxtIngreso)
      TxtIngreso.Enabled = True
      TxtIngreso.SetFocus
      Grid.Enabled = False
      Toolbar1.Enabled = False
   End If
   
End Sub

Private Sub Limpiar()
   Grid.Rows = 2
   
   cmbSistema.ListIndex = -1
   cmbProducto.ListIndex = -1
   cmbMoneda.ListIndex = -1
   
   cmbSistema.Enabled = True
   cmbProducto.Enabled = True
   cmbMoneda.Enabled = True
   
   Grid.Enabled = False
   
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(4).Enabled = False
End Sub


Private Sub TxtIngreso_KeyDown(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyEscape Then
      Grid.Enabled = True
      TxtIngreso.Visible = False
      Toolbar1.Enabled = True
      Grid.SetFocus
   End If
   
   If KeyCode = vbKeyReturn Then
      If ValidarBandas(Grid.RowSel, Grid.ColSel, TxtIngreso.Text) = True Then
         Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = TxtIngreso.Text
         
         Grid.Enabled = True
         TxtIngreso.Visible = False
         Toolbar1.Enabled = True
         Grid.SetFocus
      End If
   End If
   
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim cSistema   As String
   Dim cProducto  As String
   Dim iMoneda    As Integer
   
   
   Select Case Button.Index
      Case 1
         Call Limpiar
      Case 2
         cSistema = Trim(Right(cmbSistema.Text, 5))
         cProducto = Trim(Right(cmbProducto.Text, 5))
         iMoneda = cmbMoneda.ItemData(cmbMoneda.ListIndex)

         Call BuscarInformacion(cSistema, cProducto, iMoneda)
      Case 3
         Call GrabarInformacion
      Case 4
         Call Eliminar
      Case 5
         Unload Me
   End Select
End Sub

Private Sub Eliminar()
   Dim cSistema   As String
   Dim cProducto  As String
   Dim iMoneda    As Long
   
   If MsgBox("¿ Esta segúro que desea eliminar los registros. ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
      Exit Sub
   End If
   
   cSistema = Trim(Right(cmbSistema.Text, 5))
   cProducto = Trim(Right(cmbProducto.Text, 5))
   iMoneda = cmbMoneda.ItemData(cmbMoneda.ListIndex)
  
   Envia = Array()
   AddParam Envia, CDbl(5)
   AddParam Envia, cSistema
   AddParam Envia, cProducto
   AddParam Envia, CDbl(iMoneda)
   If Not Bac_Sql_Execute("SP_MNT_MATRIZ_CONTROL", Envia) Then
      Exit Sub
   End If
   
   MsgBox "Proceso de Eliminación ha fnalizado correctamente", vbInformation, TITSISTEMA
   Call Limpiar
End Sub

Private Sub GrabarInformacion()
   On Error GoTo ErroGrabacion
   Dim iContador  As Long
   Dim cSistema   As String
   Dim cProducto  As String
   Dim iMoneda    As Long
   Dim iDesde     As Long
   Dim iHasta     As Long
   Dim iBanda     As Double
   
   
   cSistema = Trim(Right(cmbSistema.Text, 5))
   cProducto = Trim(Right(cmbProducto.Text, 5))
   iMoneda = cmbMoneda.ItemData(cmbMoneda.ListIndex)
   
   Call Bac_Sql_Execute("Begin Transaction")
   
   Envia = Array()
   AddParam Envia, CDbl(5)
   AddParam Envia, cSistema
   AddParam Envia, cProducto
   AddParam Envia, CDbl(iMoneda)
   If Not Bac_Sql_Execute("SP_MNT_MATRIZ_CONTROL", Envia) Then
      GoTo ErroGrabacion
   End If
   
   For iContador = 2 To Grid.Rows - 1
      iDesde = CDbl(Grid.TextMatrix(iContador, 0))
      iHasta = CDbl(Grid.TextMatrix(iContador, 1))
      iBanda = CDbl(Grid.TextMatrix(iContador, 2))
      
      Envia = Array()
      AddParam Envia, CDbl(6)
      AddParam Envia, cSistema
      AddParam Envia, cProducto
      AddParam Envia, CDbl(iMoneda)
      
      AddParam Envia, CDbl(iDesde)
      AddParam Envia, CDbl(iHasta)
      AddParam Envia, CDbl(iBanda)
      If Not Bac_Sql_Execute("SP_MNT_MATRIZ_CONTROL", Envia) Then
         GoTo ErroGrabacion
      End If
      
   Next iContador
   
   Call Bac_Sql_Execute("Commit Transaction")
   MsgBox "Proceso de Grabación ha fnalizado correctamente", vbInformation, TITSISTEMA
   
   Call Limpiar
Exit Sub
ErroGrabacion:
   Call Bac_Sql_Execute("Rollback Transaction")
   MsgBox "Se ha producido un error en la grabación" & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
End Sub

Private Function ValidarBandas(ByVal Fila As Long, ByVal Columna As Long, ByVal Monto As Double) As Boolean
   Dim iValorPaso As Double
   
   ValidarBandas = False

   If Columna = 2 Then
      ValidarBandas = True
      Exit Function
   End If
      
   If Columna = 0 Then
      iValorPaso = Grid.TextMatrix(Fila - 1, 1)
   End If
   If Columna = 1 Then
      iValorPaso = Grid.TextMatrix(Fila, 0)
   End If
   
   If Monto > iValorPaso Then
     'if (Monto - iValorPaso) = 1 Then
      ValidarBandas = True
      Exit Function
   End If
   
   MsgBox " Valor ingresado no es valido", vbExclamation, TITSISTEMA
   TxtIngreso.SetFocus
End Function
