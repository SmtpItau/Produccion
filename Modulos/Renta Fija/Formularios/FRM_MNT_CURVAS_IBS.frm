VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_CURVAS_IBS 
   Caption         =   "Mantenedor de Cuervas para Cartera IBS"
   ClientHeight    =   5415
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5415
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   5415
   ScaleWidth      =   5415
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5415
      _ExtentX        =   9551
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar Información"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   7
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3915
         Top             =   30
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
               Picture         =   "FRM_MNT_CURVAS_IBS.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CURVAS_IBS.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CURVAS_IBS.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CURVAS_IBS.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CURVAS_IBS.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CURVAS_IBS.frx":4A42
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CURVAS_IBS.frx":591C
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   615
      Left            =   15
      TabIndex        =   8
      Top             =   435
      Width           =   5385
      Begin VB.ComboBox cmdCurvaNombre 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1440
         TabIndex        =   10
         Text            =   "cmdCurvaNombre"
         Top             =   180
         Width           =   3810
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Curna Nombre"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   105
         TabIndex        =   9
         Top             =   240
         Width           =   1200
      End
   End
   Begin VB.Frame CuaFil 
      Enabled         =   0   'False
      Height          =   600
      Left            =   15
      TabIndex        =   5
      Top             =   975
      Width           =   5385
      Begin VB.ComboBox cmbMonFilt 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1455
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   180
         Width           =   3810
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Moneda Filtro"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   105
         TabIndex        =   6
         Top             =   225
         Width           =   1125
      End
   End
   Begin VB.Frame Marco 
      Enabled         =   0   'False
      Height          =   3900
      Left            =   15
      TabIndex        =   1
      Top             =   1500
      Width           =   5385
      Begin BACControles.TXTNumero txtGrilla 
         Height          =   345
         Left            =   1395
         TabIndex        =   4
         Top             =   945
         Visible         =   0   'False
         Width           =   1020
         _ExtentX        =   1799
         _ExtentY        =   609
         BackColor       =   -2147483646
         ForeColor       =   -2147483639
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.ComboBox cmbMonedas 
         BackColor       =   &H80000002&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   330
         Left            =   150
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   945
         Visible         =   0   'False
         Width           =   1065
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   3705
         Left            =   45
         TabIndex        =   2
         Top             =   135
         Width           =   5295
         _ExtentX        =   9340
         _ExtentY        =   6535
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
         RowHeightMin    =   315
         BackColor       =   -2147483644
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483645
         GridColor       =   -2147483644
         GridColorFixed  =   -2147483642
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_MNT_CURVAS_IBS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Enum MisEventos
   [Consultar] = 1
   [Borrar] = 2
   [Grabar] = 3
   [Monedas] = 4
   [LeerCurvas] = 5
End Enum

Private Sub ProcLeeCurvas()
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(MisEventos.LeerCurvas)
   If Not Bac_Sql_Execute("SP_MNT_CURVA_CAPTA_IBS", Envia) Then
      MsgBox "Error al leer monedas.", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   cmdCurvaNombre.Clear
   Do While Bac_SQL_Fetch(Datos())
      cmdCurvaNombre.AddItem Datos(1)
   Loop
End Sub

Private Sub Nombres()
   Grid.Cols = 5
   Grid.TextMatrix(0, 0) = "Moneda":         Grid.ColWidth(0) = 2000
   Grid.TextMatrix(0, 1) = "Plazo Desde":    Grid.ColWidth(1) = 1200
   Grid.TextMatrix(0, 2) = "Plazo Hasta":    Grid.ColWidth(2) = 1200
   Grid.TextMatrix(0, 3) = "Tasa":           Grid.ColWidth(3) = 1200
   Grid.TextMatrix(0, 4) = "CodMon":         Grid.ColWidth(4) = 0
End Sub

Private Sub CargaMonedas(MiCombo As ComboBox, Optional miMoneda As Integer)
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(MisEventos.Monedas)
   If Not Bac_Sql_Execute("SP_MNT_CURVA_CAPTA_IBS", Envia) Then
      MsgBox "Error al leer monedas.", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   MiCombo.Clear
   Do While Bac_SQL_Fetch(Datos())
      If miMoneda = 0 Or miMoneda = Val(Datos(2)) Then
         MiCombo.AddItem Datos(1)
         MiCombo.ItemData(MiCombo.NewIndex) = Val(Datos(2))
      End If
   Loop
End Sub


Private Sub CargarDatos()
   Dim Datos()
   Dim miFiltro   As Integer
   If cmbMonFilt.ListIndex = -1 Then
      miFiltro = 0
   Else
      miFiltro = cmbMonFilt.ItemData(cmbMonFilt.ListIndex)
   End If
   
   Envia = Array()
   AddParam Envia, CDbl(MisEventos.Consultar)
   AddParam Envia, cmdCurvaNombre.Text
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(miFiltro)
   If Not Bac_Sql_Execute("SP_MNT_CURVA_CAPTA_IBS", Envia) Then
      MsgBox "Error al leer monedas.", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   Grid.Rows = 1
   Do While Bac_SQL_Fetch(Datos())
      Grid.Rows = Grid.Rows + 1
      Grid.TextMatrix(Grid.Rows - 1, 0) = Datos(1)
      Grid.TextMatrix(Grid.Rows - 1, 1) = Datos(2)
      Grid.TextMatrix(Grid.Rows - 1, 2) = Datos(3)
      Grid.TextMatrix(Grid.Rows - 1, 3) = Format(Datos(4), FDecimal)
      Grid.TextMatrix(Grid.Rows - 1, 4) = Datos(5)
   Loop
   
End Sub

Private Sub cmbMonedas_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If cmbMonedas.ListIndex = -1 Then
         cmbMonedas.Visible = False
         Grid.Enabled = True
         Toolbar1.Enabled = True
         Grid.SetFocus
         Exit Sub
      End If
      
      Grid.TextMatrix(Grid.RowSel, 0) = cmbMonedas.Text
      Grid.TextMatrix(Grid.RowSel, 4) = cmbMonedas.ItemData(cmbMonedas.ListIndex)
      cmbMonedas.Visible = False
      Grid.Enabled = True
      Toolbar1.Enabled = True
      Grid.SetFocus
      Toolbar1.Buttons(2).Enabled = True
   End If
   If KeyCode = vbKeyEscape Then
      cmbMonedas.Visible = False
      Grid.Enabled = True
      Toolbar1.Enabled = True
      Grid.SetFocus
   End If
End Sub

Private Sub cmbMonFilt_Click()
   Call CargarDatos
   If cmbMonFilt.ListIndex > -1 Then
      Call CargaMonedas(cmbMonedas, IIf(cmbMonFilt.ListIndex = -1, 0, cmbMonFilt.ItemData(cmbMonFilt.ListIndex)))
   Else
      cmbMonedas.Clear
   End If
End Sub
Private Sub cmdCurvaNombre_Click()
   Call cmdCurvaNombre_KeyDown(vbKeyReturn, 0)
End Sub

Private Sub cmdCurvaNombre_KeyDown(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyReturn Then
      If ExisteTexto(cmdCurvaNombre.Text) = False Then
         If MsgBox("¿ Esta Seguro de Crear esta Curva. ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
            Exit Sub
         Else
            cmdCurvaNombre.AddItem cmdCurvaNombre.Text
            cmbMonedas.ListIndex = -1
            Grid.Rows = 2
         End If
      End If
      CuaFil.Enabled = True
      Marco.Enabled = True
   End If
   
End Sub
Private Function ExisteTexto(MiTex As String) As Boolean
   Dim iContador As Long
   
   ExisteTexto = False
   For iContador = 0 To cmdCurvaNombre.ListCount - 1
      If cmdCurvaNombre.List(iContador) = MiTex Then
         ExisteTexto = True
      End If
   Next iContador
   
End Function

Private Sub cmdCurvaNombre_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub Form_Load()
   Me.Icon = BacTrader.Icon
      
   Call Nombres
   Call ProcLeeCurvas
   Call CargaMonedas(cmbMonedas)
   Call CargaMonedas(cmbMonFilt)
   cmbMonFilt.AddItem "<< TODAS >>"
   cmbMonFilt.ItemData(cmbMonFilt.NewIndex) = 0
   
   Call CargarDatos
End Sub

Private Sub Form_Resize()
   On Error GoTo ErrorResize
      
      Marco.Width = Me.Width - 150
      Marco.Height = Me.Height - 2000
      Frame1.Width = Marco.Width
      
      CuaFil.Width = Marco.Width
      
      Grid.Width = Marco.Width - 100
      Grid.Height = Marco.Height - 200
      
   On Error GoTo 0
Exit Sub
ErrorResize:
End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Select Case Grid.ColSel
         Case 0
            Call PROC_POSI_TEXTO(Grid, cmbMonedas)
            If Grid.TextMatrix(Grid.RowSel, 0) <> "" Then
               cmbMonedas.Text = Grid.TextMatrix(Grid.RowSel, 0)
            End If
            cmbMonedas.Visible = True
            Grid.Enabled = False
            Toolbar1.Enabled = False
            cmbMonedas.SetFocus
         Case 1, 2, 3
            Call PROC_POSI_TEXTO(Grid, txtGrilla)
            If Grid.ColSel = 1 Then txtGrilla.CantidadDecimales = 0
            If Grid.ColSel = 2 Then txtGrilla.CantidadDecimales = 0
            If Grid.ColSel = 3 Then txtGrilla.CantidadDecimales = 4
            txtGrilla.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
            txtGrilla.Visible = True
            Grid.Enabled = False
            Toolbar1.Enabled = False
            txtGrilla.SetFocus
      End Select
   End If
   
   If KeyCode = vbKeyInsert Then
      If Grid.Rows = 1 Then
         Grid.Rows = Grid.Rows + 1
      ElseIf Grid.TextMatrix(Grid.Rows - 1, 3) <> 0 Then
         Grid.Rows = Grid.Rows + 1
      End If
   End If
   
   If KeyCode = vbKeyDelete Then
      If MsgBox("¿ Esta se guro que desea eliminar la fila seleccionada ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
         Grid.SetFocus
         Exit Sub
      End If
      If Grid.Rows >= 3 Then
         Grid.RemoveItem (Grid.RowSel)
      Else
         Grid.Rows = 1
      End If
      Grid.SetFocus
      Toolbar1.Buttons(2).Enabled = True
   End If
   
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call CargarDatos
      Case 2
         Call Grabacion
      Case 3
         Unload Me
   End Select
End Sub


Private Sub Grabacion()
   On Error GoTo ErrorEliminacion
   Dim iContador As Integer
   Dim miFiltro   As Integer
   
   If cmbMonFilt.ListIndex = -1 Then
      miFiltro = 0
   Else
      miFiltro = cmbMonFilt.ItemData(cmbMonFilt.ListIndex)
   End If

   Call BacBeginTransaction
   
   Envia = Array()
   AddParam Envia, CDbl(MisEventos.Borrar)
   AddParam Envia, ""
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(miFiltro)
   If Not Bac_Sql_Execute("SP_MNT_CURVA_CAPTA_IBS", Envia) Then
      GoTo ErrorEliminacion
   End If
   
   For iContador = 1 To Grid.Rows - 1
      
      If Val(Grid.TextMatrix(iContador, 4)) <> 0 Then
         Envia = Array()
         AddParam Envia, CDbl(MisEventos.Grabar)
         AddParam Envia, cmdCurvaNombre.Text
         AddParam Envia, CDbl(Grid.TextMatrix(iContador, 4))
         AddParam Envia, CDbl(Grid.TextMatrix(iContador, 1))
         AddParam Envia, CDbl(Grid.TextMatrix(iContador, 2))
         AddParam Envia, CDbl(Grid.TextMatrix(iContador, 3))
         AddParam Envia, CDbl(miFiltro)
         If Not Bac_Sql_Execute("SP_MNT_CURVA_CAPTA_IBS", Envia) Then
            GoTo ErrorEliminacion
         End If
      End If
   Next iContador
   
   Call BacCommitTransaction
   MsgBox "Tarea Finalizada" & vbCrLf & vbCrLf & "Grabación de Cuervas ha finalizado en forma correcta.", vbInformation, TITSISTEMA
   
   Grid.Rows = 1
   cmbMonFilt.ListIndex = -1
   cmdCurvaNombre.Text = ""
   cmdCurvaNombre.ListIndex = -1
   Grid.Rows = 1
   
Exit Sub
ErrorEliminacion:
   Call BacRollBackTransaction
   MsgBox "Tarea Abortada" & vbCrLf & vbCrLf & "Grabación de Cuervas ha finalizado con problemas.", vbInformation, TITSISTEMA
End Sub

Private Sub txtGrilla_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = txtGrilla.Text
      txtGrilla.Visible = False
      Grid.Enabled = True
      Toolbar1.Enabled = True
      If Grid.ColSel = 3 Then
         Toolbar1.Buttons(2).Enabled = True
      End If
      Grid.SetFocus
      Toolbar1.Buttons(2).Enabled = True
   End If
   If KeyCode = vbKeyEscape Then
      txtGrilla.Visible = False
      Grid.Enabled = True
      Toolbar1.Enabled = True
      Grid.SetFocus
   End If
End Sub
