VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Begin VB.Form FRM_MNT_SERIES_SUB_INV 
   Caption         =   "Mantenedor de Instrumentos para T - Look"
   ClientHeight    =   3255
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6915
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   3255
   ScaleWidth      =   6915
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6915
      _ExtentX        =   12197
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
            ImageIndex      =   5
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4470
         Top             =   60
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
               Picture         =   "FRM_MNT_SERIES_SUB_INV.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_SERIES_SUB_INV.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_SERIES_SUB_INV.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_SERIES_SUB_INV.frx":20CE
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_SERIES_SUB_INV.frx":2FA8
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   645
      Left            =   30
      TabIndex        =   1
      Top             =   450
      Width           =   6870
      Begin VB.TextBox txtSerie 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1170
         MaxLength       =   20
         TabIndex        =   2
         Top             =   210
         Width           =   1440
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Instrumento"
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
         Left            =   75
         TabIndex        =   4
         Top             =   270
         Width           =   1035
      End
      Begin VB.Label lblInGlosa 
         Alignment       =   2  'Center
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Height          =   315
         Left            =   2610
         TabIndex        =   3
         Top             =   210
         Width           =   4170
      End
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   2145
      Left            =   15
      TabIndex        =   5
      Top             =   1110
      Width           =   6915
      _ExtentX        =   12197
      _ExtentY        =   3784
      _Version        =   393216
      FixedCols       =   0
      BackColor       =   -2147483644
      ForeColor       =   -2147483641
      BackColorFixed  =   -2147483646
      ForeColorFixed  =   -2147483639
      BackColorBkg    =   -2147483645
      GridColor       =   -2147483648
      GridColorFixed  =   -2147483640
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
      AllowUserResizing=   2
   End
End
Attribute VB_Name = "FRM_MNT_SERIES_SUB_INV"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim cSerie  As String
Dim iCodigo As String
Dim cGlosa  As String
Dim dFecVen As Date

Private Sub NombresGrilla()
   Grid.Rows = 2
   Grid.Cols = 3
   
   Grid.TextMatrix(0, 0) = "Familia"
   Grid.TextMatrix(0, 1) = "Series"
   Grid.TextMatrix(0, 2) = "Fcha Vcto."
   Grid.ColWidth(0) = 1000
   Grid.ColWidth(1) = 3000
   Grid.ColWidth(2) = 1500
End Sub

Private Sub Form_Load()
   Me.Top = 0: Me.Left = 0
   Me.Icon = BACSwapParametros.Icon
   Call NombresGrilla
   Call CargarLista
End Sub

Private Sub CargarLista()
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, "CON"
   If Not Bac_Sql_Execute("SP_MNT_INSTRUMENTOS_SUBYACENTES_INV_EXT", Envia) Then
      MsgBox "Se ha producido un error en la Busqueda de información", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   Grid.Rows = 1
   Do While Bac_SQL_Fetch(Datos())
      Grid.Rows = Grid.Rows + 1
      Grid.TextMatrix(Grid.Rows - 1, 0) = Datos(1)
      Grid.TextMatrix(Grid.Rows - 1, 1) = Datos(2)
      Grid.TextMatrix(Grid.Rows - 1, 2) = Format(Datos(3), "DD/MM/YYYY")
   Loop
End Sub

Private Function ValidarSerie(xSerie As String) As Boolean
   Dim Datos()
   
   ValidarSerie = False
   Envia = Array()
   AddParam Envia, "VAL"
   AddParam Envia, CDbl(0)
   AddParam Envia, UCase(xSerie)
   If Not Bac_Sql_Execute("SP_MNT_INSTRUMENTOS_SUBYACENTES_INV_EXT", Envia) Then
      MsgBox "Se ha producido un error en la Busqueda de información", vbExclamation, TITSISTEMA
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) < 0 Then
         MsgBox Datos(2), vbExclamation, TITSISTEMA
         Exit Function
      Else
         cSerie = Datos(3)
         iCodigo = Datos(2)
         cGlosa = Datos(4)
         dFecVen = Datos(5)
      End If
   End If
   ValidarSerie = True
   
End Function


Private Sub Form_Resize()
   On Error GoTo ErrResize

   If Me.Height <= 4110 Then
      Me.Height = 4110
   End If
   If Me.Width <= 6960 Then
      Me.Width = 6960
   End If
   
   Frame1.Width = Me.Width - 150
   Grid.Width = Frame1.Width
   Grid.Height = (Me.Height - (Frame1.Height + 100)) - 800
   
   If Me.Width <= 6960 Then
      Me.Width = 6960
   End If
   If Me.Height <= 4110 Then
      Me.Height = 4110
   End If
   
   On Error GoTo 0
Exit Sub
ErrResize:
   On Error GoTo 0
End Sub

Private Sub Eliminar()
   Envia = Array()
   AddParam Envia, "DEL"
   AddParam Envia, CDbl(iCodigo)
   AddParam Envia, Trim(cSerie)
   AddParam Envia, Format(dFecVen, "YYYYMMDD")
   If Not Bac_Sql_Execute("SP_MNT_INSTRUMENTOS_SUBYACENTES_INV_EXT", Envia) Then
      MsgBox "Se ha producido un error en la Busqueda de información", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   Call CargarLista
End Sub

Private Sub Grabar()
   Envia = Array()
   AddParam Envia, "GRB"
   AddParam Envia, CDbl(iCodigo)
   AddParam Envia, Trim(cSerie)
   AddParam Envia, Format(dFecVen, "YYYYMMDD")
   If Not Bac_Sql_Execute("SP_MNT_INSTRUMENTOS_SUBYACENTES_INV_EXT", Envia) Then
      MsgBox "Se ha producido un error en la Busqueda de información", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   Call CargarLista
End Sub

Private Sub Grid_DblClick()
   Dim DelCod  As Integer
   Dim DelSer  As String
   
   DelCod = Val(Grid.TextMatrix(Grid.RowSel, 0))
   DelSer = Grid.TextMatrix(Grid.RowSel, 1)
   
   Envia = Array()
   AddParam Envia, "CON"
   AddParam Envia, CDbl(DelCod)
   AddParam Envia, DelSer
   If Not Bac_Sql_Execute("SP_MNT_INSTRUMENTOS_SUBYACENTES_INV_EXT", Envia) Then
      MsgBox "Se ha producido un error en la Busqueda de información", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   If Bac_SQL_Fetch(Datos()) Then
      txtSerie.Tag = Datos(1)
      txtSerie.Text = Datos(2)
      lblInGlosa.Caption = Datos(4)

      cSerie = Datos(2)
      iCodigo = Datos(1)
      cGlosa = Datos(4)
      dFecVen = Datos(3)
   End If
   Toolbar1.Buttons(4).Enabled = True
End Sub

Private Sub Limpiar()
   cSerie = ""
   iCodigo = 0
   cGlosa = ""
   dFecVen = "01011900"
   txtSerie.Tag = 0
   txtSerie.Text = ""
   lblInGlosa.Caption = ""
   Toolbar1.Buttons(4).Enabled = False
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call Limpiar
      Case 2
         Call CargarLista
         Call Limpiar
      Case 3
         Call Grabar
         Call Limpiar
      Case 4
         Call Eliminar
         Call Limpiar
      Case 5
         Unload Me
   End Select
End Sub

Private Sub txtSerie_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If ValidarSerie(txtSerie.Text) = False Then
         Exit Sub
      Else
         Me.txtSerie.Text = cSerie
         Me.lblInGlosa.Caption = cGlosa
      End If
   End If
End Sub

