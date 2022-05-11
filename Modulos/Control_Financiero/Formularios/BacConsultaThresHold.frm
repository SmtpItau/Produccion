VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form BacConsultaThresHold 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Operaciones ThresHold"
   ClientHeight    =   6585
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9690
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6585
   ScaleWidth      =   9690
   Begin BACControles.TXTNumero TxtCodCli 
      Height          =   330
      Left            =   420
      TabIndex        =   11
      Top             =   7485
      Width           =   1485
      _ExtentX        =   2619
      _ExtentY        =   582
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
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
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   10
      Top             =   0
      Width           =   9690
      _ExtentX        =   17092
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   8
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Vista Previa"
            Object.ToolTipText     =   "Vista previa"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Excel"
            Object.ToolTipText     =   "Generacion de Excel"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Word"
            Object.ToolTipText     =   "Word"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Generar Interfaz"
            Object.ToolTipText     =   "Generar Interfaz"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            ImageIndex      =   8
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   8850
         Top             =   0
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
               Picture         =   "BacConsultaThresHold.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacConsultaThresHold.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacConsultaThresHold.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacConsultaThresHold.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacConsultaThresHold.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacConsultaThresHold.frx":4A42
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacConsultaThresHold.frx":591C
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacConsultaThresHold.frx":67F6
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   1755
      Left            =   15
      TabIndex        =   1
      Top             =   375
      Width           =   9660
      Begin VB.TextBox TXTRut 
         Alignment       =   1  'Right Justify
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
         Left            =   150
         Locked          =   -1  'True
         TabIndex        =   14
         Text            =   "0"
         Top             =   930
         Width           =   1635
      End
      Begin VB.ComboBox cmbreporte 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         ItemData        =   "BacConsultaThresHold.frx":6B10
         Left            =   1800
         List            =   "BacConsultaThresHold.frx":6B12
         Style           =   2  'Dropdown List
         TabIndex        =   13
         Top             =   1275
         Width           =   6075
      End
      Begin MSComDlg.CommonDialog Cd_Archivo 
         Left            =   8595
         Top             =   675
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin VB.ComboBox cmbpro 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1830
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   375
         Width           =   4410
      End
      Begin VB.ComboBox cmbSistema 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   150
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   375
         Width           =   1665
      End
      Begin BACControles.TXTFecha txt_fecha 
         Height          =   315
         Left            =   6240
         TabIndex        =   9
         Top             =   375
         Width           =   1665
         _ExtentX        =   2937
         _ExtentY        =   556
         Enabled         =   -1  'True
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "19-02-2010"
      End
      Begin VB.Label Lbl_Tipo_Reporte 
         AutoSize        =   -1  'True
         Caption         =   "Tipo Reporte"
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
         Left            =   120
         TabIndex        =   12
         Top             =   1350
         Width           =   1065
      End
      Begin VB.Label lbl_modulo 
         AutoSize        =   -1  'True
         Caption         =   "Sistema"
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
         Left            =   165
         TabIndex        =   6
         Top             =   150
         Width           =   675
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Producto"
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
         Left            =   1845
         TabIndex        =   5
         Top             =   150
         Width           =   750
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Fecha"
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
         Left            =   6255
         TabIndex        =   4
         Top             =   150
         Width           =   480
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Cliente"
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
         Left            =   165
         TabIndex        =   3
         Top             =   735
         Width           =   585
      End
      Begin VB.Label LblNombre 
         BackColor       =   &H80000009&
         BorderStyle     =   1  'Fixed Single
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
         Left            =   1800
         TabIndex        =   2
         Top             =   930
         Width           =   6060
      End
   End
   Begin MSFlexGridLib.MSFlexGrid Grilla 
      Height          =   4350
      Left            =   15
      TabIndex        =   0
      Top             =   2175
      Width           =   9645
      _ExtentX        =   17013
      _ExtentY        =   7673
      _Version        =   393216
      Cols            =   17
      RowHeightMin    =   300
      BackColor       =   -2147483633
      BackColorFixed  =   -2147483646
      ForeColorFixed  =   -2147483639
      BackColorBkg    =   -2147483636
      WordWrap        =   -1  'True
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
      AllowUserResizing=   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
End
Attribute VB_Name = "BacConsultaThresHold"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hWnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Private Declare Function ShellExecuteForExplore Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hWnd As Long, ByVal lpOperation As String, ByVal lpFile As String, lpParameters As Any, lpDirectory As Any, ByVal nShowCmd As Long) As Long

Const iColOperador = 1
Const iColSistema = 2
Const iColProducto = 3
Const iColRutCli = 4
Const iColNombre = 5
Const iColnOpe = 6
Const iColBloq = 7
Const iColMotivo = 8
Const iColTipoOpe = 9
Const iColFecha = 10
Const iColFecVcto = 11
Const iColPlazoRes = 12
Const iColNocional = 13
Const iColTasaFwd = 14
Const iColMtm = 15
Const iColMtoThresHold = 16
Const iColExcesos = 17

Public Enum EShellShowConstants
    essSW_HIDE = 0
    essSW_MAXIMIZE = 3
    essSW_MINIMIZE = 6
    essSW_SHOWMAXIMIZED = 3
    essSW_SHOWMINIMIZED = 2
    essSW_SHOWNORMAL = 1
    essSW_SHOWNOACTIVATE = 4
    essSW_SHOWNA = 8
    essSW_SHOWMINNOACTIVE = 7
    essSW_SHOWDEFAULT = 10
    essSW_RESTORE = 9
    essSW_SHOW = 5
End Enum

Private Const ERROR_FILE_NOT_FOUND = 2&
Private Const ERROR_PATH_NOT_FOUND = 3&
Private Const ERROR_BAD_FORMAT = 11&
Private Const SE_ERR_ACCESSDENIED = 5        ' access denied
Private Const SE_ERR_ASSOCINCOMPLETE = 27
Private Const SE_ERR_DDEBUSY = 30
Private Const SE_ERR_DDEFAIL = 29
Private Const SE_ERR_DDETIMEOUT = 28
Private Const SE_ERR_DLLNOTFOUND = 32
Private Const SE_ERR_FNF = 2                ' file not found
Private Const SE_ERR_NOASSOC = 31
Private Const SE_ERR_PNF = 3                ' path not found
Private Const SE_ERR_OOM = 8                ' out of memory
Private Const SE_ERR_SHARE = 26

Private Sub Nombres()
   Let Grilla.Rows = 2:       Let Grilla.Cols = 18
   Let Grilla.FixedRows = 1:  Let Grilla.FixedCols = 0

   Let Grilla.TextMatrix(0, 0) = "":                   Let Grilla.ColWidth(0) = 0
   Let Grilla.TextMatrix(0, 1) = "Operador":           Let Grilla.ColWidth(1) = 0 '1500
   Let Grilla.TextMatrix(0, 2) = "Sistema":            Let Grilla.ColWidth(2) = 1500
   Let Grilla.TextMatrix(0, 3) = "Producto":           Let Grilla.ColWidth(3) = 2500
   Let Grilla.TextMatrix(0, 4) = "Rut Cliente":        Let Grilla.ColWidth(4) = 0
   Let Grilla.TextMatrix(0, 5) = "Nombre":             Let Grilla.ColWidth(5) = 4500
   Let Grilla.TextMatrix(0, 6) = "N°Ope":              Let Grilla.ColWidth(6) = 1000
   Let Grilla.TextMatrix(0, 7) = "Bloqueado":          Let Grilla.ColWidth(7) = 0
   Let Grilla.TextMatrix(0, 8) = "Motivo":             Let Grilla.ColWidth(8) = 0
   Let Grilla.TextMatrix(0, 9) = "Tipo Ope":           Let Grilla.ColWidth(9) = 1000
   Let Grilla.TextMatrix(0, 10) = "Fecha":             Let Grilla.ColWidth(10) = 1000
   Let Grilla.TextMatrix(0, 11) = "Fec.Vcto.":         Let Grilla.ColWidth(11) = 1000
   Let Grilla.TextMatrix(0, 12) = "Plazo Residual":    Let Grilla.ColWidth(12) = 1200
   Let Grilla.TextMatrix(0, 13) = "Nocional":          Let Grilla.ColWidth(13) = 2000
   Let Grilla.TextMatrix(0, 14) = "Tasa Forward":      Let Grilla.ColWidth(14) = 2000
   Let Grilla.TextMatrix(0, 15) = "MTM":               Let Grilla.ColWidth(15) = 2000
   Let Grilla.TextMatrix(0, 16) = "Monto ThresHold":   Let Grilla.ColWidth(16) = 2000
   Let Grilla.TextMatrix(0, 17) = "Excesos":           Let Grilla.ColWidth(17) = 2000

   Let Grilla.Font.Size = 8
   Let Grilla.Font.Name = "Arial"
   Let Grilla.RowHeight(0) = 500
End Sub

Private Function FuncLoadModulos()
   Dim SQLDatos()

   If Not Bac_Sql_Execute("SP_CMBSISTEMATHRESHOLD") Then
      Call MsgBox("Se ha generado un error al leer los modulos.", vbExclamation, App.Path)
      Exit Function
   End If
   Call cmbSistema.Clear
   Do While Bac_SQL_Fetch(SQLDatos())
      Call cmbSistema.AddItem(SQLDatos(2) & Space(150) & SQLDatos(1))
   Loop
End Function

Private Function FuncLoadReportes()
   cmbreporte.Clear
   Call cmbreporte.AddItem("1. INFORME DE CARTERA DERIVADOS (Forward y Swap)"):  Let cmbreporte.ItemData(cmbreporte.NewIndex) = 0
   Call cmbreporte.AddItem("2. CARTOLA THRESHOLD CLIENTE"):                      Let cmbreporte.ItemData(cmbreporte.NewIndex) = 1
   Call cmbreporte.AddItem("3. CARTOLA THRESHOLD EJECUTIVO"):                    Let cmbreporte.ItemData(cmbreporte.NewIndex) = 2
End Function

Private Function FuncLoadProducto(ByVal xProducto As Variant)
   Dim SQLDatos()

   Call cmbpro.Clear
   Call cmbpro.AddItem("<< TODOS >>")

   Envia = Array()
   AddParam Envia, xProducto
   If Not Bac_Sql_Execute("SP_CMBPRODUCTOTHRESHOLD", Envia) Then
      Call MsgBox("Se ha generado un error al leer los productos asociados al modulo", vbExclamation, App.Title)
      Exit Function
   End If
   Do While Bac_SQL_Fetch(SQLDatos)
      Call cmbpro.AddItem(SQLDatos(2) & Space(150 - Len(SQLDatos(1))) & SQLDatos(2))
   Loop
End Function

Private Sub cmbSistema_Click()

   If cmbSistema.ListIndex = -1 Then
      Exit Sub
   End If

   Call FuncLoadProducto(Right(cmbSistema.List(cmbSistema.ListIndex), 3))

End Sub

Private Sub Form_Load()
   Let Me.top = 0: Let Me.Left = 0
   Let Me.Icon = BacControlFinanciero.Icon
   Me.txt_fecha.Text = gsBAC_Fecp

   Call FuncLoadModulos
   Call FuncLoadReportes
   Call Nombres
   Call FuncClear
End Sub


Private Function FuncClear()
   Let TXTRut.Text = 0
   Let TxtCodCli.Text = 0
   Let LblNombre.Caption = ""
   Let Grilla.Rows = 1: Let Grilla.Rows = 2

   Call FuncHabilitaGrilla(False)
End Function

Private Function FuncHabilitaGrilla(ByVal MiValor As Boolean)
   Dim MiTipoInforme As Long

   Let MiTipoInforme = 0
   If cmbreporte.ListIndex >= 0 Then
      Let MiTipoInforme = cmbreporte.ItemData(cmbreporte.ListIndex)
   End If

   Let Toolbar1.Buttons(3).Enabled = IIf(MiValor = False, False, IIf(MiTipoInforme = 0, True, False))
   Let Toolbar1.Buttons(4).Enabled = IIf(MiValor = False, False, IIf(MiTipoInforme = 0, True, False))
   Let Toolbar1.Buttons(5).Enabled = IIf(MiValor = False, False, IIf(MiTipoInforme = 0, True, False))
   Let Toolbar1.Buttons(6).Enabled = IIf(MiValor = False, False, IIf(MiTipoInforme > 0, True, False))
   Let Toolbar1.Buttons(7).Enabled = IIf(MiValor = False, False, IIf(MiTipoInforme > 0, True, False))

   If cmbreporte.ListIndex < 0 Then
      Let cmbreporte.ListIndex = 0
   End If

   Let txt_fecha.Enabled = True
   If cmbreporte.ItemData(cmbreporte.ListIndex) > 0 Then
      Let txt_fecha.Text = Format(gsBAC_Fecp, "dd-mm-yyyy")
      Let txt_fecha.Enabled = False
   End If
End Function

Private Sub cmbreporte_Click()
   Call FuncClear
End Sub

Private Sub TitulosGrilla()
    Grilla.Rows = 17: Grilla.FixedRows = 0
    Grilla.Cols = 5:  Grilla.FixedCols = 0
End Sub

Private Sub cmdBuscar()
   Call FuncLoadDatos(IIf(cmbreporte.ListIndex = 0, 2, cmbreporte.ListIndex))
End Sub

Private Function FuncLoadDatos(ByVal TipoInforme As Long)
   Dim SQLDatos()

   Let Screen.MousePointer = vbHourglass

   Envia = Array()
   AddParam Envia, Trim(Right(cmbSistema.List(cmbSistema.ListIndex), 3))
   AddParam Envia, Trim(Right(cmbpro.List(cmbpro.ListIndex), 2))
   AddParam Envia, Format(txt_fecha.Text, "yyyymmdd")
   AddParam Envia, CDbl(TXTRut.Text)
   AddParam Envia, CDbl(TxtCodCli.Text)
   AddParam Envia, gsBAC_User
   AddParam Envia, TipoInforme
   If Not Bac_Sql_Execute("SP_CARTERA_THRESHOLD", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha generado un error en la Consulta de los Datos.", vbExclamation, App.Title)
      Exit Function
   End If

   Let Grilla.Rows = Grilla.FixedRows
   Let Grilla.Redraw = False

   Do While Bac_SQL_Fetch(SQLDatos())
      Grilla.Rows = Grilla.Rows + 1
      Grilla.TextMatrix(Grilla.Rows - 1, 0) = ""
      Grilla.TextMatrix(Grilla.Rows - 1, iColOperador) = SQLDatos(1)
      Grilla.TextMatrix(Grilla.Rows - 1, iColSistema) = IIf((SQLDatos(2) = "BFW"), "BACFORWARD", "BACSWAP")
      Grilla.TextMatrix(Grilla.Rows - 1, iColProducto) = SQLDatos(3)
      Grilla.TextMatrix(Grilla.Rows - 1, iColRutCli) = SQLDatos(4)
      Grilla.TextMatrix(Grilla.Rows - 1, iColNombre) = SQLDatos(5)
      Grilla.TextMatrix(Grilla.Rows - 1, iColnOpe) = SQLDatos(6)
      Grilla.TextMatrix(Grilla.Rows - 1, iColBloq) = SQLDatos(7)
      Grilla.TextMatrix(Grilla.Rows - 1, iColMotivo) = SQLDatos(8)
      Grilla.TextMatrix(Grilla.Rows - 1, iColTipoOpe) = SQLDatos(10)
      Grilla.TextMatrix(Grilla.Rows - 1, iColFecha) = SQLDatos(11)
      Grilla.TextMatrix(Grilla.Rows - 1, iColFecVcto) = SQLDatos(12)
      Grilla.TextMatrix(Grilla.Rows - 1, iColPlazoRes) = SQLDatos(13)
      Grilla.TextMatrix(Grilla.Rows - 1, iColNocional) = Format(SQLDatos(14), FDecimal)
      Grilla.TextMatrix(Grilla.Rows - 1, iColTasaFwd) = Format(SQLDatos(15), FDecimal)
      Grilla.TextMatrix(Grilla.Rows - 1, iColMtm) = Format(SQLDatos(16), FDecimal)
      Grilla.TextMatrix(Grilla.Rows - 1, iColMtoThresHold) = Format(SQLDatos(17), FDecimal)
      Grilla.TextMatrix(Grilla.Rows - 1, iColExcesos) = Format(SQLDatos(18), FDecimal)
   Loop
   Let Grilla.Redraw = True
   Let Screen.MousePointer = vbDefault

   If Grilla.Rows > Grilla.FixedRows Then
      Call FuncHabilitaGrilla(True)
   End If
End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1:  Call cmdBuscar
      Case 2:  Call cmdLimpiar
      Case 3:  Call ImprimirPapeletaMovimientos(crptToWindow)
      Case 4:  Call ImprimirPapeletaMovimientos(crptToPrinter)
      Case 5:  Call ReporteExcel("SP_MOVIMIENTOS_THRESHOLD")
      Case 6:  Call GeneraDocumentoWord
      Case 7:
         If ValidaExisteDatos = True Then
            Call FrmCargaArchivoThresHold.Show(vbModal)
         Else
            Call MsgBox("No Existe información para Generar Interfaz.", vbExclamation, App.Title)
         End If
      Case 8
         Call Unload(Me)
   End Select

End Sub




Private Function ValidaExisteDatos()
   Dim Envia()
   Dim Datos()

   Let ValidaExisteDatos = False

   Envia = Array()

   AddParam Envia, Trim(Right(cmbSistema.List(cmbSistema.ListIndex), 3))
   AddParam Envia, Trim(Right(cmbpro.List(cmbpro.ListIndex), 2))
   AddParam Envia, Format(txt_fecha.Text, "yyyymmdd")
   AddParam Envia, CDbl(TXTRut.Text)
   AddParam Envia, CDbl(TxtCodCli.Text)
   AddParam Envia, gsBAC_User
   AddParam Envia, cmbreporte.ListIndex
   If Not Bac_Sql_Execute("SP_CARTOLA_CLIENTE", Envia) Then
      Screen.MousePointer = vbDefault
      MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      Let ValidaExisteDatos = True
   End If
End Function

Public Sub GeneraDocumentoWord()
   Dim Datos()
   Dim HTML                   As String
   Dim StyleMsoNormalTable    As String
   Dim Titulos                As String
   Dim I                      As Integer
   Dim cNombreCli             As String
   Dim HTMLTABLE              As String
   Dim SaltoPagina            As String
   Dim Encabezado             As String
   Dim NewEncabezado          As String
   Dim NomArchivo             As String
   Dim PathArchivo            As String
   Dim NomLogo                As String
   Dim PathLogo               As String
   Dim cProdCli               As String
   Dim TablaProdCliente       As String
   Dim NewProdCli             As String
   Dim StyleMsoNormalTable2   As String
   Dim TitulosSWAP            As String
   Dim TablaProdClienteSWAP   As String
   Dim oExistenDatos          As Boolean
   Dim TopMHTML               As String
   Dim PieMHTML               As String

   If MsgBox("Se imprimiran todas las operaciones visualizadas en pantalla en forma automatica. " & vbCrLf & vbCrLf & "¿ Desea continuar ?", vbQuestion + vbYesNo, App.Title) = vbNo Then
      Exit Sub
   End If

   Screen.MousePointer = vbHourglass

   Let NomArchivo = "InformeCartolaClientes.doc"
   Let PathArchivo = gsRPT_Path
   Let PathLogo = gsRPT_Path
   Let NomLogo = "Logo.jpg"

   TopMHTML = LeeMHTML(PathLogo & "Img\" & "Top_Imagen.txt")


   Envia = Array()
   AddParam Envia, Trim(Right(cmbSistema.List(cmbSistema.ListIndex), 3))
   AddParam Envia, Trim(Right(cmbpro.List(cmbpro.ListIndex), 2))
   AddParam Envia, Format(txt_fecha.Text, "yyyymmdd")
   AddParam Envia, CDbl(TXTRut.Text)
   AddParam Envia, CDbl(TxtCodCli.Text)
   AddParam Envia, gsBAC_User
   AddParam Envia, cmbreporte.ListIndex
   If Not Bac_Sql_Execute("SP_CARTOLA_CLIENTE", Envia) Then
      Screen.MousePointer = vbDefault
      MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
      Exit Sub
   End If

         StyleMsoNormalTable = "Table.MsoNormalTable" & _
            " {mso-style-name:Tabla normal;" & _
            " mso-tstyle-rowband-size:0;" & _
            " mso-tstyle-colband-size:0;" & _
            " mso-style-noshow:yes;" & _
            " mso-style-priority:99;" & _
            " mso-style-qformat:yes;" & _
            " mso-style-parent:'';" & _
            " mso-padding-alt:0cm 1.4pt 0cm 1.4pt;" & _
            " mso-para-margin:0cm;" & _
            " mso-para-margin-bottom:.0001pt;" & _
            " mso-pagination:widow-orphan;" & _
            " font-size:8.0pt;" & _
            " font-family:Arial Narrow;}"

        StyleMsoNormalTable2 = "Table.MsoNormalTable2" & _
           " {mso-style-name:Tabla normal;" & _
           " mso-tstyle-rowband-size:0;" & _
           " mso-tstyle-colband-size:0;" & _
           " mso-style-noshow:yes;" & _
           " mso-style-priority:99;" & _
           " mso-style-qformat:yes;" & _
           " mso-style-parent:'';" & _
           " mso-padding-alt:0cm 1.4pt 0cm 1.4pt;" & _
           " mso-para-margin:0cm;" & _
           " mso-para-margin-bottom:.0001pt;" & _
           " mso-pagination:widow-orphan;" & _
           " font-size:9.0pt;" & _
           " font-family:Arial Narrow;}"


        SaltoPagina = "<SPAN><BR CLEAR=ALL STYLE='MSO-SPECIAL-CHARACTER:LINE-BREAK;PAGE-BREAK-BEFORE:ALWAYS'></SPAN>"


        Encabezado = "<TABLE ALIGN =3DCENTER width=3D640 class=3DMsoNormalTable2 BORDER=3D0 CELLSPACING=3D0 CELLPADDING=3D0>" & _
                     "<TR BGCOLOR=3D#000000>" & _
                     "<TD WIDTH=3D640><img src=3D'dsfsdf_image001.jpg' width=3D'640' HEIGHT=3D'56' alt='Logo'/></TD>" & _
                     "</TR>" & _
                     "<TR><TD WIDTH=3D640>Cartola de Derivados al " & Format(Date, "dd-mm-yyyy") & "</TD></TR>" & "<TR><TD WIDTH=640><HR></TD></TR>" & _
                     "<TR><TD WIDTH=3D640>Señor(es)</TD></TR>" & _
                     "<TR><TD WIDTH=3D640>#cNomCli#</TD></TR>" & _
                     "<TR><TD WIDTH=3D640>#cDirCli#</TD></TR>" & _
                     "<TR><TD WIDTH=3D640><HR></TD></TR>" & _
                     "<TR><TD WIDTH=3D640>Cartera Forward</TD></TR>" & _
                     "<TR><TD WIDTH=3D640>&nbsp;</TD></TR>" & _
                     "</TABLE>"


        Titulos = "<TR BGCOLOR=3D#000000>" & _
                    "<TD width=3D50>N°</TD>" & _
                    "<TD width=3D50>Operación</TD>" & _
                    "<TD width=3D100>Fecha Inicio</TD>" & _
                    "<TD width=3D100>Fecha<BR>Vencimiento</TD>" & _
                    "<TD width=3D70>Pzo.Residual</TD>" & _
                    "<TD width=3D70>Nocional</TD>" & _
                    "<TD width=3D70>Monto<br>Final</TD>" & _
                    "<TD width=3D70>Precio Futuro</TD>" & _
                    "<TD width=3D70>Modalidad de <br>Pago</TD>" & _
                    "#TitColMtm#" & _
                    "</TR>"

        TitulosSWAP = "<TR BGCOLOR=3D#000000>" & _
                    "<TD width=3D50>N°</TD>" & _
                    "<TD width=3D50>Flujo</TD>" & _
                    "<TD width=3D100>Fecha Inicio</TD>" & _
                    "<TD width=3D100>Fecha<BR>Vencimiento</TD>" & _
                    "<TD width=3D70>Próximo<BR>Vecimiento</TD>" & _
                    "<TD width=3D70>Nocional</TD>" & _
                    "<TD width=3D70>Tasas</TD>" & _
                    "#TitColMtmSwap#" & _
                    "</TR>"


        TablaProdCliente = "<TABLE ALIGN =3DCENTER class=3DMsoNormalTable width=3D640>" & _
                        "<TR COLSPAN=10><TD WIDTH=3D640><HR></TD></TR>" & _
                        "<TR COLSPAN=10><TD WIDTH=3D640>#ProdCli#</TD></TR>" & _
                        "</TABLE>"

        TablaProdClienteSWAP = "<TABLE ALIGN =3DCENTER class=3DMsoNormalTable width=3D640>" & _
                        "<TR COLSPAN=7><TD WIDTH=3D640><HR></TD></TR>" & _
                        "<TR COLSPAN=7><TD WIDTH=3D640>#ProdCli#</TD></TR>" & _
                        "</TABLE>"


        HTML = TopMHTML & "<HTML>" & _
                "<HEAD>" & _
                "<STYLE>" & _
                StyleMsoNormalTable & _
                StyleMsoNormalTable2 & _
                "</STYLE>" & _
                "</HEAD><BODY><DIV>"

        HTMLTABLE = "<TABLE ALIGN =3DCENTER width=3D640 class=3DMsoNormalTable BORDER=3D1 CELLSPACING=3D0 CELLPADDING=3D0 >"

        I = 1

        Let oExistenDatos = False

        Do While Bac_SQL_Fetch(Datos())
            Let oExistenDatos = True

           ' Cuando es el primer registro
            If Trim(cNombreCli) = "" Then
                 NewEncabezado = Replace(Encabezado, "#cNomCli#", Datos(5))
                 NewEncabezado = Replace(NewEncabezado, "#cDirCli#", Datos(19))
                 HTML = HTML & NewEncabezado
            End If

           'Cuando cambia el cliente
            If cNombreCli <> Datos(5) And Trim(cNombreCli) <> "" Then

                 NewEncabezado = Replace(Encabezado, "#cNomCli#", Datos(5))
                 NewEncabezado = Replace(NewEncabezado, "#cDirCli#", Datos(19))

                 HTML = HTML & "</TABLE><BR>" & SaltoPagina & NewEncabezado

            End If

            If Trim(cProdCli) = "" Then
                    If Trim(Datos(2)) = "PCS" Then 'Tabla de Productos
                       NewProdCli = Replace(TablaProdClienteSWAP, "#ProdCli#", Datos(17))
                       HTML = HTML & NewProdCli & HTMLTABLE & IIf(cmbreporte.ListIndex = 1, Replace(TitulosSWAP, "#TitColMtmSwap#", ""), Replace(TitulosSWAP, "#TitColMtmSwap#", "<TD width=3D100>Mark to Market<br>pesos</TD>"))
                    Else
                       NewProdCli = Replace(TablaProdCliente, "#ProdCli#", Datos(17))
                       HTML = HTML & NewProdCli & HTMLTABLE & IIf(cmbreporte.ListIndex = 1, Replace(Titulos, "#TitColMtm#", ""), Replace(Titulos, "#TitColMtm#", "<TD width=3D100>Mark to Market<br>pesos</TD>"))
                    End If

            End If

            'Cuando la moneda
            If Trim(cProdCli) <> Datos(16) And Trim(cProdCli) <> "" Then

                    If cNombreCli <> Datos(5) And Trim(cNombreCli) <> "" Then
                        HTML = HTML & ""
                    Else
                        HTML = HTML & "</TABLE><BR>"
                    End If

                    If Trim(Datos(2)) = "PCS" Then
                       NewProdCli = Replace(TablaProdClienteSWAP, "#ProdCli#", Datos(17))

                       HTML = HTML & NewProdCli & HTMLTABLE & IIf(cmbreporte.ListIndex = 1, Replace(TitulosSWAP, "#TitColMtmSwap#", ""), Replace(TitulosSWAP, "#TitColMtmSwap#", "<TD width=3D100>Mark to Market<br>pesos</TD>"))
                    Else
                       NewProdCli = Replace(TablaProdCliente, "#ProdCli#", Datos(17))
                       HTML = HTML & NewProdCli & HTMLTABLE & IIf(cmbreporte.ListIndex = 1, Replace(Titulos, "#TitColMtm#", ""), Replace(Titulos, "#TitColMtm#", "<TD width=3D100>Mark to Market<br>pesos</TD>"))
                    End If

                    I = 1
            End If


            If Trim(Datos(2)) = "BFW" Then
                HTML = HTML & "<TR>"
                HTML = HTML & "<TD align=3Dright width=3D50 " & StyleTD & ">" & I & "</TD>"
                HTML = HTML & "<TD align=3Dright width=3D50 " & StyleTD & ">" & Datos(6) & "</TD>"
                HTML = HTML & "<TD align=3Dcenter width=3D100 " & StyleTD & ">" & Datos(9) & "</TD>"
                HTML = HTML & "<TD align=3Dcenter width=3D100 " & StyleTD & ">" & Datos(10) & "</TD>"
                HTML = HTML & "<TD align=3Dright width=3D70 " & StyleTD & ">" & Datos(11) & "</TD>"
                HTML = HTML & "<TD align=3Dright width=3D70 " & StyleTD & ">" & Format(Datos(12), FDecimal) & "</TD>"
                HTML = HTML & "<TD align=3Dright width=3D70 " & StyleTD & ">" & Format(Datos(13), FDecimal) & "</TD>"
                HTML = HTML & "<TD align=3Dright width=3D70 " & StyleTD & ">" & Format(Datos(14), FDecimal) & "</TD>"
                HTML = HTML & "<TD align=3Dleft width=3D70 " & StyleTD & ">" & Datos(18) & "</TD>"
                HTML = HTML & IIf(cmbreporte.ListIndex = 1, "", "<TD align=3Dright width=3D70 " & StyleTD & ">" & Format(Datos(15), FEntero) & "</TD>")
                HTML = HTML & "</TR>"
            Else
                HTML = HTML & "<TR>"
                HTML = HTML & "<TD align=3Dright width=3D50 " & StyleTD & ">" & I & "</TD>"
                HTML = HTML & "<TD align=3Dright width=3D50 " & StyleTD & ">" & Datos(24) & "</TD>"
                HTML = HTML & "<TD align=3Dcenter width=3D100 " & StyleTD & ">" & Datos(25) & "</TD>"
                HTML = HTML & "<TD align=3Dcenter width=3D100 " & StyleTD & ">" & Datos(26) & "</TD>"
                HTML = HTML & "<TD align=3Dright width=3D70 " & StyleTD & ">" & Datos(27) & "</TD>"
                HTML = HTML & "<TD align=3Dright width=3D70 " & StyleTD & ">" & Format(Datos(28), FEntero) & "</TD>"
                HTML = HTML & "<TD align=3Dright width=3D70 " & StyleTD & ">" & Format(Datos(29), FDecimal) & "</TD>"
                HTML = HTML & IIf(cmbreporte.ListIndex = 1, "", "<TD align=3Dright width=3D70 " & StyleTD & "> " & Format(Datos(15), FEntero) & " </TD>")
                HTML = HTML & "</TR>"
            End If

            cProdCli = Datos(16)
            cNombreCli = Datos(5)
            I = I + 1
        Loop

        If oExistenDatos = False Then
            Screen.MousePointer = vbDefault
            Call MsgBox("No Existe información para Generar Documento Word.", vbExclamation, App.Title)
            Exit Sub
        End If

        PieMHTML = LeeMHTML(PathLogo & "Img\" & "Pie_Imagen.txt")

        Let HTML = HTML & "</TABLE></DIV></BODY></HTML>" & PieMHTML

        Call ImprimeDocumento(HTML, PathArchivo, NomArchivo)

        Screen.MousePointer = vbDefault
End Sub

Public Function LeeMHTML(NomArchivo As String)
        Dim HFile%
        Dim tmpPieMHTML As String
        Dim PieMHTML As String
        Let COdImage = ""

        HFile% = FreeFile

        Open NomArchivo For Input As #HFile%
        PieMHTML = ""

        Do While Not EOF(HFile)

            Line Input #HFile, tmpPieMHTML
            PieMHTML = PieMHTML & tmpPieMHTML & vbCrLf
        Loop

        LeeMHTML = PieMHTML

        Close #HFile%

End Function




Public Sub ImprimeDocumento(DocumentoHtml As String, PathArchivo As String, NomArchivo As String)

        Dim HFile%

        HFile% = FreeFile


        If Trim(Dir(PathArchivo & NomArchivo)) <> "" Then
          Kill (PathArchivo & NomArchivo)
        End If

        Open PathArchivo & NomArchivo For Append Access Write Shared As #HFile%

        Write #HFile%, DocumentoHtml & sLogEvent$

        Close #HFile%


        ShellEx PathArchivo & NomArchivo, , , , "print", Me.hWnd

End Sub

Public Function ShellEx( _
        ByVal sFile As String, _
        Optional ByVal eShowCmd As EShellShowConstants = essSW_SHOWDEFAULT, _
        Optional ByVal sParameters As String = "", _
        Optional ByVal sDefaultDir As String = "", _
        Optional sOperation As String = "open", _
        Optional Owner As Long = 0 _
    ) As Boolean
Dim lR As Long
Dim lErr As Long, sErr As Long
    If (InStr(UCase$(sFile), ".EXE") <> 0) Then
        eShowCmd = 0
    End If
    On Error Resume Next
    If (sParameters = "") And (sDefaultDir = "") Then
        lR = ShellExecuteForExplore(Owner, sOperation, sFile, 0, 0, essSW_SHOWNORMAL)
    Else
        lR = ShellExecute(Owner, sOperation, sFile, sParameters, sDefaultDir, eShowCmd)
    End If
    If (lR < 0) Or (lR > 32) Then
        ShellEx = True
    Else
        'raise an appropriate error:
        lErr = vbObjectError + 1048 + lR
        Select Case lR
        Case 0
            lErr = 7: sErr = "Out of memory"
        Case ERROR_FILE_NOT_FOUND
            lErr = 53: sErr = "File not found"
        Case ERROR_PATH_NOT_FOUND
            lErr = 76: sErr = "Path not found"
        Case ERROR_BAD_FORMAT
            sErr = "The executable file is invalid or corrupt"
        Case SE_ERR_ACCESSDENIED
            lErr = 75: sErr = "Path/file access error"
        Case SE_ERR_ASSOCINCOMPLETE
            sErr = "This file type does not have a valid file association."
        Case SE_ERR_DDEBUSY
            lErr = 285: sErr = "The file could not be opened because the target application is busy. Please try again in a moment."
        Case SE_ERR_DDEFAIL
            lErr = 285: sErr = "The file could not be opened because the DDE transaction failed. Please try again in a moment."
        Case SE_ERR_DDETIMEOUT
            lErr = 286: sErr = "The file could not be opened due to time out. Please try again in a moment."
        Case SE_ERR_DLLNOTFOUND
            lErr = 48: sErr = "The specified dynamic-link library was not found."
        Case SE_ERR_FNF
            lErr = 53: sErr = "File not found"
        Case SE_ERR_NOASSOC
            sErr = "No application is associated with this file type."
        Case SE_ERR_OOM
            lErr = 7: sErr = "Out of memory"
        Case SE_ERR_PNF
            lErr = 76: sErr = "Path not found"
        Case SE_ERR_SHARE
            lErr = 75: sErr = "A sharing violation occurred."
        Case Else
            sErr = "An error occurred occurred whilst trying to open or print the selected file."
        End Select

        Err.Raise lErr, , App.EXEName & ".GShell", sErr
        ShellEx = False
    End If

End Function


Public Function IniciaWordListadoLog(cNombreDocumento As String) As Word.Document
   Dim Wrd As Variant
   Dim UbicacionDeDocumentos As String

   On Error Resume Next

   Set Wrd = GetObject(, "Word.Application")

   If Err.Number <> 0 Then
      Set Wrd = New Word.Application
   End If

   Err.Clear
   On Error GoTo 0

   Wrd.Application.Visible = True
   UbicacionDeDocumentos = gsRPT_PathBCC

   Set IniciaWordListadoLog = Wrd.Documents.Add(UbicacionDeDocumentos & cNombreDocumento)

   Call BacControlWindows(1)
End Function


Sub cmdLimpiar()
   Grilla.Rows = 1
   txt_fecha.Text = ""
   cmbSistema.ListIndex = -1
   cmbpro.ListIndex = -1
   TXTRut.Text = ""
   LblNombre.Caption = ""

   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(4).Enabled = False
   Toolbar1.Buttons(5).Enabled = False
   Toolbar1.Buttons(6).Enabled = False
   Toolbar1.Buttons(7).Enabled = False

   txt_fecha.Text = Format(gsBAC_Fecp, "DD-MM-YYYY")
End Sub

Private Sub TXTRut_Cli_Change()
    TXTRut.Text = 0
End Sub
Private Sub TXTRut_Change()
   If Len(TXTRut.Text) = 0 Then
      TXTRut.Text = 0
   End If
End Sub

Private Sub TxtRut_DblClick()
   BacAyuda.Tag = "Cliente"
   BacAyuda.Show 1
   If giAceptar = True Then
      TXTRut.Text = RetornoAyuda
      TxtCodCli.Text = RetornoAyuda2
      LblNombre.Caption = RetornoAyuda3
   End If
End Sub


Private Sub BuscarDatosMovimientos()

        On Error GoTo ErrorBuscar
        Dim I%
        Dim Datos()

        Screen.MousePointer = vbHourglass

        Envia = Array()
        AddParam Envia, Trim(Right(cmbSistema.List(cmbSistema.ListIndex), 3))
        AddParam Envia, Trim(Right(cmbpro.List(cmbpro.ListIndex), 2))
        AddParam Envia, Format(txt_fecha.Text, "yyyymmdd")
        AddParam Envia, CDbl(TXTRut.Text)
        AddParam Envia, CDbl(TxtCodCli.Text)
        AddParam Envia, gsBAC_User

        If Not Bac_Sql_Execute("SP_CARTERA_THRESHOLD", Envia) Then
           Screen.MousePointer = vbDefault
           MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
           Exit Sub
        End If

        Grilla.Rows = Grilla.FixedRows

        Do While Bac_SQL_Fetch(Datos())

            Grilla.Rows = Grilla.Rows + 1
            Grilla.Row = Grilla.Rows - 1
            Grilla.TextMatrix(Grilla.Row, 0) = ""
            Grilla.TextMatrix(Grilla.Row, iColOperador) = Datos(1)
            Grilla.TextMatrix(Grilla.Row, iColSistema) = IIf((Datos(2) = "BFW"), "BACFORWARD", "BACSWAP")
            Grilla.TextMatrix(Grilla.Row, iColProducto) = Datos(3)
            Grilla.TextMatrix(Grilla.Row, iColRutCli) = Datos(4)
            Grilla.TextMatrix(Grilla.Row, iColNombre) = Datos(5)
            Grilla.TextMatrix(Grilla.Row, iColnOpe) = Datos(6)
            Grilla.TextMatrix(Grilla.Row, iColBloq) = Datos(7)
            Grilla.TextMatrix(Grilla.Row, iColMotivo) = Datos(8)
            Grilla.TextMatrix(Grilla.Row, iColTipoOpe) = Datos(10)
            Grilla.TextMatrix(Grilla.Row, iColFecha) = Datos(11)
            Grilla.TextMatrix(Grilla.Row, iColFecVcto) = Datos(12)
            Grilla.TextMatrix(Grilla.Row, iColPlazoRes) = Datos(13)
            Grilla.TextMatrix(Grilla.Row, iColNocional) = Format(Datos(14), FDecimal)
            Grilla.TextMatrix(Grilla.Row, iColTasaFwd) = Format(Datos(15), FDecimal)
            Grilla.TextMatrix(Grilla.Row, iColMtm) = Format(Datos(16), FDecimal)
            Grilla.TextMatrix(Grilla.Row, iColMtoThresHold) = Format(Datos(17), FDecimal)
            Grilla.TextMatrix(Grilla.Row, iColExcesos) = Format(Datos(18), FDecimal)
        Loop

        Grilla.Col = 0
        If Grilla.Row > Grilla.FixedRows Then
            Grilla.Row = Grilla.FixedRows
        End If

        If Grilla.Rows = Grilla.FixedRows Then
            Call MsgBox("No se encontro información.", vbInformation, App.Title)
        End If

        Screen.MousePointer = vbDefault

    Exit Sub
ErrorBuscar:
        MsgBox Err.Description, vbExclamation, TITSISTEMA
        Screen.MousePointer = vbDefault
End Sub

Function ImprimirPapeletaMovimientos(ByVal xDestino As Integer) As Integer

   On Error GoTo ErrorInforme

      Call Limpiar_Cristal

      BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBCC & "Informe_Movimientos_ThresHold.rpt"
      BacControlFinanciero.CryFinanciero.Destination = xDestino
      BacControlFinanciero.CryFinanciero.WindowTitle = TITSISTEMA & " - Papeleta de Movimientos ThresHold"
      BacControlFinanciero.CryFinanciero.StoredProcParam(0) = IIf(Trim(Right(cmbSistema.List(cmbSistema.ListIndex), 3)) = "", " ", Trim(Right(cmbSistema.List(cmbSistema.ListIndex), 3)))
      BacControlFinanciero.CryFinanciero.StoredProcParam(1) = IIf(Trim(Right(cmbpro.List(cmbpro.ListIndex), 2)) = "", " ", Trim(Right(cmbpro.List(cmbpro.ListIndex), 2)))
      BacControlFinanciero.CryFinanciero.StoredProcParam(2) = Format(txt_fecha.Text, "yyyy-mm-dd 00:00:00.000")
      BacControlFinanciero.CryFinanciero.StoredProcParam(3) = CDbl(TXTRut.Text)
      BacControlFinanciero.CryFinanciero.StoredProcParam(4) = CDbl(TxtCodCli.Text)
      BacControlFinanciero.CryFinanciero.StoredProcParam(5) = gsBAC_User
      BacControlFinanciero.CryFinanciero.Connect = swConeccion
      BacControlFinanciero.CryFinanciero.Action = 1

Exit Function
ErrorInforme:
   ErrorInforme BacControlFinanciero.CryFinanciero.ReportFileName

End Function

Function ImprimirPapeletaCartera(ByVal xDestino As Integer) As Integer

   On Error GoTo ErrorInforme

      Call Limpiar_Cristal

      BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBCC & "Informe_Cartera_ThresHold.rpt"
      BacControlFinanciero.CryFinanciero.Destination = xDestino
      BacControlFinanciero.CryFinanciero.WindowTitle = TITSISTEMA & " - Papeleta de Cartera Derivados"
      BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Trim(Right(cmbSistema.List(cmbSistema.ListIndex), 3))
      BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Trim(Right(cmbpro.List(cmbpro.ListIndex), 2))
      BacControlFinanciero.CryFinanciero.StoredProcParam(2) = Format(txt_fecha.Text, "yyyy-mm-dd 00:00:00.000")
      BacControlFinanciero.CryFinanciero.StoredProcParam(3) = CDbl(TXTRut.Text)
      BacControlFinanciero.CryFinanciero.StoredProcParam(4) = CDbl(TxtCodCli.Text)
      BacControlFinanciero.CryFinanciero.StoredProcParam(5) = gsBAC_User
      BacControlFinanciero.CryFinanciero.Connect = swConeccion
      BacControlFinanciero.CryFinanciero.Action = 1
      Exit Function

   Exit Function
ErrorInforme:
   ErrorInforme BacControlFinanciero.CryFinanciero.ReportFileName

End Function

Sub ReporteExcel(storedprocedure As String)
    Dim nFila1      As Long
    Dim nFila2      As Long
    Dim ruta        As String
    Dim Crea_xls    As Boolean
    Dim retorno     As Double
    Dim oDatos()
    Dim MiExcell         ''''As New EXCEL.Application
    Dim MiLibro          ''''As New EXCEL.Workbook
    Dim MiHoja           ''''As New EXCEL.Worksheet
    Dim MiSheet          As Object
    Dim ExcelActivo      As Boolean

    On Error GoTo CONTROLA_ERROR

    Screen.MousePointer = vbHourglass

    Cd_Archivo.CancelError = True
    Cd_Archivo.FileName = ""
    Cd_Archivo.Filter = "ReporteThresHold*.xls"
    Cd_Archivo.DialogTitle = "Exportar Archivo Movimientos ThresHold"
    Cd_Archivo.ShowSave

    DoEvents

    If Dir(Cd_Archivo.FileName) <> "" Then
       If MsgBox("Archivo ya existe, desea reemplazar el archivo", vbQuestion + vbYesNo) = vbNo Then
          Screen.MousePointer = vbDefault
          Cd_Archivo.FileName = ""
          Exit Sub
       Else
          Call Kill(Cd_Archivo.FileName)
       End If
    End If

    Set MiExcell = CreateObject("Excel.Application")
    Set MiLibro = MiExcell.Application.Workbooks.Add
    Set MiHoja = MiLibro.Sheets(1)
    Set MiSheet = MiExcell.ActiveSheet

    ExcelActivo = True

    MiExcell.DisplayAlerts = False
    MiExcell.Worksheets(3).Delete
    MiExcell.Worksheets(2).Delete
    MiExcell.DisplayAlerts = True

    MiLibro.Sheets("Hoja1").Name = "INFORME_THRESHOLD"
    MiLibro.Sheets("Hoja2").Name = "TBL_POND_DIVISAS"

    MiLibro.Worksheets("INFORME_THRESHOLD").Cells(1, "A") = "" '"OPERADOR"
    MiLibro.Worksheets("INFORME_THRESHOLD").Cells(1, "B") = "SISTEMA"
    MiLibro.Worksheets("INFORME_THRESHOLD").Cells(1, "C") = "PRODUCTO"
    MiLibro.Worksheets("INFORME_THRESHOLD").Cells(1, "D") = "RUT CLIENTE"
    MiLibro.Worksheets("INFORME_THRESHOLD").Cells(1, "E") = "NOMBRE"
    MiLibro.Worksheets("INFORME_THRESHOLD").Cells(1, "F") = "NOPERACION"
    MiLibro.Worksheets("INFORME_THRESHOLD").Cells(1, "G") = "BLOQUEADO"
    MiLibro.Worksheets("INFORME_THRESHOLD").Cells(1, "H") = "MOTIVO"
    MiLibro.Worksheets("INFORME_THRESHOLD").Cells(1, "I") = "TIPO OPER."
    MiLibro.Worksheets("INFORME_THRESHOLD").Cells(1, "J") = "FECHA"
    MiLibro.Worksheets("INFORME_THRESHOLD").Cells(1, "K") = "FECHA VCTO."
    MiLibro.Worksheets("INFORME_THRESHOLD").Cells(1, "L") = "PLAZO RESIDUAL"
    MiLibro.Worksheets("INFORME_THRESHOLD").Cells(1, "M") = "NOCIONAL"
    MiLibro.Worksheets("INFORME_THRESHOLD").Cells(1, "N") = "TASA FORWARD"
    MiLibro.Worksheets("INFORME_THRESHOLD").Cells(1, "O") = "MTM"
    MiLibro.Worksheets("INFORME_THRESHOLD").Cells(1, "P") = "MONTO THRESHOLD"
    MiLibro.Worksheets("INFORME_THRESHOLD").Cells(1, "Q") = "MONTO EXCESOS"
    MiLibro.Worksheets("INFORME_THRESHOLD").Columns("C:C").EntireColumn.AutoFit


    Dim Datos()
    Dim nFila   As Long
    Dim oExistenDatos As Boolean

    Let oExistenDatos = False

    Envia = Array()
    AddParam Envia, Trim(Right(cmbSistema.List(cmbSistema.ListIndex), 3))
    AddParam Envia, Trim(Right(cmbpro.List(cmbpro.ListIndex), 2))
    AddParam Envia, Format(txt_fecha.Text, "yyyymmdd")
    AddParam Envia, CDbl(TXTRut.Text)
    AddParam Envia, CDbl(TxtCodCli.Text)
    AddParam Envia, gsBAC_User

    If Not Bac_Sql_Execute(storedprocedure, Envia) Then
       MsgBox "Error en SqlServer", vbCritical, TITSISTEMA
       Exit Sub
    End If

    Let nFila = 2

    Do While Bac_SQL_Fetch(Datos())

        Let oExistenDatos = True

        MiLibro.Worksheets("INFORME_THRESHOLD").Cells(nFila, "B") = IIf((Datos(2) = "BFW"), "BACFORWARD", "BACSWAP")
        MiLibro.Worksheets("INFORME_THRESHOLD").Cells(nFila, "C") = Datos(3)
        MiLibro.Worksheets("INFORME_THRESHOLD").Cells(nFila, "D") = Datos(4)
        MiLibro.Worksheets("INFORME_THRESHOLD").Cells(nFila, "E") = Datos(5)
        MiLibro.Worksheets("INFORME_THRESHOLD").Cells(nFila, "F") = Datos(6)
        MiLibro.Worksheets("INFORME_THRESHOLD").Cells(nFila, "G") = Datos(7)
        MiLibro.Worksheets("INFORME_THRESHOLD").Cells(nFila, "H") = Datos(8)
        MiLibro.Worksheets("INFORME_THRESHOLD").Cells(nFila, "I") = Datos(10)
        MiLibro.Worksheets("INFORME_THRESHOLD").Cells(nFila, "J") = Datos(11)
        MiLibro.Worksheets("INFORME_THRESHOLD").Cells(nFila, "K") = Datos(12)
        MiLibro.Worksheets("INFORME_THRESHOLD").Cells(nFila, "L") = Datos(13)
        MiLibro.Worksheets("INFORME_THRESHOLD").Cells(nFila, "M") = Format(Datos(14), FDecimal)
        MiLibro.Worksheets("INFORME_THRESHOLD").Cells(nFila, "N") = Format(Datos(15), FDecimal)
        MiLibro.Worksheets("INFORME_THRESHOLD").Cells(nFila, "O") = Format(Datos(16), FDecimal)
        MiLibro.Worksheets("INFORME_THRESHOLD").Cells(nFila, "P") = Format(Datos(17), FDecimal)
        MiLibro.Worksheets("INFORME_THRESHOLD").Cells(nFila, "Q") = Format(Datos(18), FDecimal)
        MiLibro.Worksheets("INFORME_THRESHOLD").Columns("C:C").EntireColumn.AutoFit
        Crea_xls = True
        Let nFila = nFila + 1
    Loop

    With MiExcell.Selection
        .HorizontalAlignment = xlRight
        .VerticalAlignment = xlBottom
        .WrapText = False
        .Orientation = 0
        .AddIndent = False
        .ShrinkToFit = False
        .MergeCells = False
    End With

    If oExistenDatos = False Then
         Call MsgBox("No Existe información para la generación de Excel.", vbExclamation, App.Title)
         Exit Sub
    End If

    If Crea_xls Then
        MiExcell.DisplayAlerts = False
        MiHoja.SaveAs (Cd_Archivo.FileName)
        MiExcell.DisplayAlerts = True
    Else
        GoSub CIERRA_EXCEL

        MousePointer = vbDefault
        MsgBox "No se encontró Información para generar el Excel", vbExclamation, gsBac_Version
        Exit Sub
    End If

    Screen.MousePointer = vbDefault
    Call MsgBox("Archivo ha sido generado en :" & vbCrLf & Cd_Archivo.FileName & vbCrLf & "", vbInformation, App.Title)
   MsgBox "El archivo excel con los factores de ponderacion ha sido generado con exito", vbInformation, gsBac_Version

    MiLibro.Activate
    MiLibro.Application.Visible = True 'MAP 20080702 Para ver lo que va en el Excel y no usar Shell


    Exit Sub

CIERRA_EXCEL:
      MiExcell.DisplayAlerts = False
      MiHoja.Application.Workbooks.Close
      MiExcell.Application.Workbooks.Close
      MiExcell.Application.Quit

'''      MiLibro.Close
'''      MiExcell.Visible = False
'''      MiExcell.Quit

      Set MiExcell = Nothing
      Set MiLibro = Nothing
      Set MiHoja = Nothing
      Return

CONTROLA_ERROR:
      Screen.MousePointer = vbDefault

      If Err.Number = cdlCancel Then
         Exit Sub
      End If

      MsgBox CStr(Err.Number) + vbCrLf + Err.Description, vbExclamation + vbOKOnly

      If ExcelActivo = True Then
         GoSub CIERRA_EXCEL
      End If

      Exit Sub

FORMATEA_EXCEL:

    MiExcell.Range("A1:C1").Select
    With MiExcell.Selection.Interior
        .ColorIndex = 1
        .Pattern = xlSolid
    End With
    MiExcell.Selection.Font.ColorIndex = 2
    MiExcell.Range("A2").Select
    MiExcell.Range(MiExcell.Selection, MiExcell.ActiveCell.SpecialCells(xlLastCell)).Select
    MiExcell.Selection.Borders(xlDiagonalDown).LineStyle = xlNone
    MiExcell.Selection.Borders(xlDiagonalUp).LineStyle = xlNone
    With MiExcell.Selection.Borders(xlEdgeLeft)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlEdgeTop)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlEdgeRight)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlInsideVertical)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    With MiExcell.Selection.Borders(xlInsideHorizontal)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .ColorIndex = xlAutomatic
    End With
    MiExcell.Columns("C:C").EntireColumn.AutoFit

    Return


End Sub

