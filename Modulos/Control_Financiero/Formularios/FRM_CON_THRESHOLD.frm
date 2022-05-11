VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form FRM_CON_THRESHOLD 
   Caption         =   "Consulta de Cartera Threshold"
   ClientHeight    =   5250
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   8625
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   5250
   ScaleWidth      =   8625
   Begin Threed.SSPanel sProgress 
      Align           =   2  'Align Bottom
      Height          =   315
      Left            =   0
      TabIndex        =   16
      Top             =   4935
      Width           =   8625
      _Version        =   65536
      _ExtentX        =   15214
      _ExtentY        =   556
      _StockProps     =   15
      ForeColor       =   -2147483641
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   1
      BevelInner      =   1
      FloodType       =   1
      FloodColor      =   -2147483646
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8625
      _ExtentX        =   15214
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
         NumButtons      =   10
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   5
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            ImageIndex      =   6
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   7
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   8
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4950
         Top             =   15
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
               Picture         =   "FRM_CON_THRESHOLD.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CON_THRESHOLD.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CON_THRESHOLD.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CON_THRESHOLD.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CON_THRESHOLD.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CON_THRESHOLD.frx":4A42
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CON_THRESHOLD.frx":591C
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CON_THRESHOLD.frx":67F6
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FraFiltro 
      Height          =   1665
      Left            =   45
      TabIndex        =   1
      Top             =   375
      Width           =   8565
      Begin VB.ComboBox CmbThreshold 
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
         Left            =   6165
         Style           =   2  'Dropdown List
         TabIndex        =   19
         Top             =   930
         Width           =   1650
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
         ItemData        =   "FRM_CON_THRESHOLD.frx":6B10
         Left            =   1725
         List            =   "FRM_CON_THRESHOLD.frx":6B12
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   1260
         Width           =   6090
      End
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
         Left            =   60
         Locked          =   -1  'True
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   8
         Text            =   "0"
         Top             =   930
         Width           =   1650
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
         Left            =   60
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   345
         Width           =   1665
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
         Left            =   1740
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   345
         Width           =   4410
      End
      Begin BACControles.TXTFecha txt_fecha 
         Height          =   315
         Left            =   6150
         TabIndex        =   4
         Top             =   345
         Width           =   1665
         _ExtentX        =   2937
         _ExtentY        =   556
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
      Begin BACControles.TXTNumero TxtCodCli 
         Height          =   315
         Left            =   1425
         TabIndex        =   14
         Top             =   930
         Width           =   285
         _ExtentX        =   503
         _ExtentY        =   556
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
      Begin MSComDlg.CommonDialog Command 
         Left            =   7920
         Top             =   615
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Threshold"
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
         Left            =   6210
         TabIndex        =   18
         Top             =   735
         Width           =   855
      End
      Begin VB.Label LblEtiquetaMensaje 
         Alignment       =   2  'Center
         Caption         =   "FAVOR ESPERE ... Buscando Información...."""
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   225
         Left            =   1050
         TabIndex        =   17
         Top             =   705
         Visible         =   0   'False
         Width           =   4410
      End
      Begin VB.Label LblNombre 
         BackColor       =   &H80000005&
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
         Left            =   1725
         TabIndex        =   12
         Top             =   930
         Width           =   4425
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
         Left            =   75
         TabIndex        =   11
         Top             =   735
         Width           =   585
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
         Left            =   60
         TabIndex        =   10
         Top             =   1335
         Width           =   1065
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
         Left            =   6165
         TabIndex        =   7
         Top             =   150
         Width           =   480
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
         Left            =   1755
         TabIndex        =   6
         Top             =   150
         Width           =   750
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
         Left            =   75
         TabIndex        =   5
         Top             =   135
         Width           =   675
      End
   End
   Begin VB.Frame FraDetalle 
      Height          =   3000
      Left            =   45
      TabIndex        =   13
      Top             =   1950
      Width           =   8565
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   2820
         Left            =   30
         TabIndex        =   15
         Top             =   135
         Width           =   8490
         _ExtentX        =   14975
         _ExtentY        =   4974
         _Version        =   393216
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         ForeColorSel    =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483630
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   1
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
   End
End
Attribute VB_Name = "FRM_CON_THRESHOLD"
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

Private Enum EShellShowConstants
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

Dim MiUltimaConsulaSql  As String


Private Function FuncSettingGrid()
   Let Grilla.Rows = 2:       Let Grilla.Cols = 20
   Let Grilla.FixedRows = 1:  Let Grilla.FixedCols = 0
   
   Let Grilla.TextMatrix(0, 0) = "MODULO":            Let Grilla.ColWidth(0) = 900:      Let Grilla.ColAlignment(0) = flexAlignLeftCenter
   Let Grilla.TextMatrix(0, 1) = "PRODUCTO":          Let Grilla.ColWidth(1) = 2200:      Let Grilla.ColAlignment(1) = flexAlignLeftCenter
   Let Grilla.TextMatrix(0, 2) = "RUT CLIENTE":       Let Grilla.ColWidth(2) = 0:         Let Grilla.ColAlignment(2) = flexAlignLeftCenter
   Let Grilla.TextMatrix(0, 3) = "COD CLIENTE":       Let Grilla.ColWidth(3) = 0:         Let Grilla.ColAlignment(3) = flexAlignLeftCenter
   Let Grilla.TextMatrix(0, 4) = "NOMBRE CLIENTE":    Let Grilla.ColWidth(4) = 3000:      Let Grilla.ColAlignment(4) = flexAlignLeftCenter
   Let Grilla.TextMatrix(0, 5) = "N° CONTRATO":       Let Grilla.ColWidth(5) = 1200:      Let Grilla.ColAlignment(5) = flexAlignRightCenter
   Let Grilla.TextMatrix(0, 6) = "TIPO OPERACION":    Let Grilla.ColWidth(6) = 1400:      Let Grilla.ColAlignment(6) = flexAlignLeftCenter
   Let Grilla.TextMatrix(0, 7) = "FECHA CIERRE":      Let Grilla.ColWidth(7) = 1300:      Let Grilla.ColAlignment(7) = flexAlignLeftCenter
   Let Grilla.TextMatrix(0, 8) = "FECHA TERMINO":     Let Grilla.ColWidth(8) = 1300:      Let Grilla.ColAlignment(8) = flexAlignLeftCenter
   Let Grilla.TextMatrix(0, 9) = "PLAZO":             Let Grilla.ColWidth(9) = 900:       Let Grilla.ColAlignment(9) = flexAlignRightCenter
   Let Grilla.TextMatrix(0, 10) = "MONTO NOCIONAL":   Let Grilla.ColWidth(10) = 2000:     Let Grilla.ColAlignment(10) = flexAlignRightCenter
   Let Grilla.TextMatrix(0, 11) = "TASA":             Let Grilla.ColWidth(11) = 0:        Let Grilla.ColAlignment(11) = flexAlignRightCenter
   Let Grilla.TextMatrix(0, 12) = "VALOR MERCADO":    Let Grilla.ColWidth(12) = 2000:     Let Grilla.ColAlignment(12) = flexAlignRightCenter
   Let Grilla.TextMatrix(0, 13) = "MONTO THRESHOLD":  Let Grilla.ColWidth(13) = 2000:     Let Grilla.ColAlignment(13) = flexAlignRightCenter
   Let Grilla.TextMatrix(0, 14) = "MONTO EXCESO":     Let Grilla.ColWidth(14) = 2000:     Let Grilla.ColAlignment(14) = flexAlignRightCenter
   Let Grilla.TextMatrix(0, 15) = "MONTO REC":        Let Grilla.ColWidth(15) = 2000:     Let Grilla.ColAlignment(15) = flexAlignRightCenter

   Let Grilla.TextMatrix(0, 16) = "MTO. NOCIONAL $":  Let Grilla.ColWidth(16) = 2000:     Let Grilla.ColAlignment(16) = flexAlignRightCenter

   Let Grilla.TextMatrix(0, 17) = "APLICA THRESHOLD": Let Grilla.ColWidth(17) = 1600:     Let Grilla.ColAlignment(17) = flexAlignLeftCenter
   Let Grilla.TextMatrix(0, 18) = "MONEDA":           Let Grilla.ColWidth(18) = 0:        Let Grilla.ColAlignment(18) = flexAlignLeftCenter
   Let Grilla.TextMatrix(0, 19) = "CONTRATO NUEVO":   Let Grilla.ColWidth(19) = 1500:     Let Grilla.ColAlignment(19) = flexAlignLeftCenter
  
End Function

Private Function FuncLoadReportes()
   Call cmbreporte.Clear
   Call cmbreporte.AddItem("1. INFORME DE CARTERA DERIVADOS (Forward y Swap)"):  Let cmbreporte.ItemData(cmbreporte.NewIndex) = 0
   Call cmbreporte.AddItem("2. CARTOLA THRESHOLD CLIENTE"):                      Let cmbreporte.ItemData(cmbreporte.NewIndex) = 1
   Call cmbreporte.AddItem("3. CARTOLA THRESHOLD EJECUTIVO"):                    Let cmbreporte.ItemData(cmbreporte.NewIndex) = 2
    Let cmbreporte.ListIndex = 0
End Function

Private Function FuncLoadModulos()
   Dim SQLDatos()

   If Not Bac_Sql_Execute("SP_CMBSISTEMATHRESHOLD") Then
      Call MsgBox("Se ha generado un error al leer los modulos.", vbExclamation, App.Path)
      Exit Function
   End If
   Call cmbSistema.Clear
   Call cmbSistema.AddItem("<< TODOS >>" & Space(150) & "")
   Do While Bac_SQL_Fetch(SQLDatos())
      Call cmbSistema.AddItem(SQLDatos(2) & Space(150) & SQLDatos(1))
   Loop
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
      Call cmbpro.AddItem(SQLDatos(2) & Space(150) & SQLDatos(4))
   Loop
End Function

Private Function FuncLimpiar()
   Let cmbSistema.ListIndex = -1
   Let cmbpro.ListIndex = -1
   Let txt_fecha.Text = gsBAC_Fecp
   Let TXTRut.Text = 0
   Let TxtCodCli.Text = 0
   Let LblNombre.Caption = ""
   Let Grilla.Rows = 1
End Function

Private Sub cmbreporte_Click()
   Call FuncLimpiar
   
   If Grilla.Rows = Grilla.FixedRows Then
      Call FuncSettigToolbar(False)
   Else
      Call FuncSettigToolbar(True)
   End If
End Sub

Private Sub Form_Load()
   Let Me.Icon = BacControlFinanciero.Icon
   Let Me.top = 0: Let Me.Left = 0
   Let txt_fecha.Text = gsBAC_Fecp
   Let sProgress.FloodType = 0
   Let LblEtiquetaMensaje.Caption = " Actualizando Información. "
   
   Call CmbThreshold.AddItem("<< TODOS >>" & Space(100) & " ")
   Call CmbThreshold.AddItem("CON THRESHOLD" & Space(100) & "S")
   Call CmbThreshold.AddItem("SIN THRESHOLD" & Space(100) & "N")
    Let CmbThreshold.ListIndex = 0
   
   Call FuncSettingGrid
   Call FuncLoadModulos
   Call FuncLoadReportes
   Call FuncSettigToolbar(False)
   
End Sub

Private Function FuncLoadDatos()
    On Error GoTo ERRLOAD
   Dim SQLDatos()
   Dim Threshold  As String
   Dim nMoneda    As Integer
   Dim nContador  As Long
   Dim nRegistros As Long
   Dim Modulo     As String
   Dim Producto   As String
   
   Let Modulo = Trim(Right(cmbSistema.List(cmbSistema.ListIndex), 3))
   Let Producto = Trim(Right(cmbpro.List(cmbpro.ListIndex), 5))
   Let Threshold = Trim(Right(CmbThreshold.List(CmbThreshold.ListIndex), 5))
   
   Call BacControlWindows(5)
   Let LblEtiquetaMensaje.Visible = True
   Let Screen.MousePointer = vbHourglass
   Call Me.Refresh
   Call BacControlWindows(5)
   
   Envia = Array()
   AddParam Envia, txt_fecha.Text
   AddParam Envia, Modulo
   AddParam Envia, Producto
   AddParam Envia, TXTRut.Text
   AddParam Envia, TxtCodCli.Text
   AddParam Envia, Threshold
   If Not Bac_Sql_Execute("dbo.SP_LEER_CARTERA_THRESHOLD", Envia) Then
      Let LblEtiquetaMensaje.Visible = False
      Let Screen.MousePointer = vbDefault
      Call MsgBox("e ha generado un error al leer la cartera threshold.", vbExclamation, App.Title)
      Exit Function
   End If

   Let MiUltimaConsulaSql = VerSql

   Let nContador = 0
   Let sProgress.FloodType = 1
   Let sProgress.FloodPercent = 0

   Let Grilla.Rows = 1
   Let Grilla.Redraw = False
   Let sProgress.ForeColor = &H80000007

   Do While Bac_SQL_Fetch(SQLDatos())
      Let nContador = nContador + 1
      Let Grilla.Rows = Grilla.Rows + 1

      Let nRegistros = CDbl(SQLDatos(18))
      Let Grilla.TextMatrix(Grilla.Rows - 1, 0) = SQLDatos(1)
      Let Grilla.TextMatrix(Grilla.Rows - 1, 1) = SQLDatos(2)
      Let Grilla.TextMatrix(Grilla.Rows - 1, 2) = SQLDatos(3)
      Let Grilla.TextMatrix(Grilla.Rows - 1, 3) = SQLDatos(4)
      Let Grilla.TextMatrix(Grilla.Rows - 1, 4) = SQLDatos(5)
      Let Grilla.TextMatrix(Grilla.Rows - 1, 5) = SQLDatos(6)
      Let Grilla.TextMatrix(Grilla.Rows - 1, 6) = IIf(SQLDatos(7) = "C", "COMPRA", "VENTA   ") & " - " & SQLDatos(20)
      Let Grilla.TextMatrix(Grilla.Rows - 1, 7) = SQLDatos(8)
      Let Grilla.TextMatrix(Grilla.Rows - 1, 8) = SQLDatos(9)
      Let Grilla.TextMatrix(Grilla.Rows - 1, 9) = Format(SQLDatos(10), FEntero)
      Let Grilla.TextMatrix(Grilla.Rows - 1, 10) = Format(SQLDatos(11), IIf(Val(SQLDatos(19)) = 999, FEntero, FDecimal))
      Let Grilla.TextMatrix(Grilla.Rows - 1, 11) = Format(SQLDatos(12), FDecimal)
      Let Grilla.TextMatrix(Grilla.Rows - 1, 12) = Format(SQLDatos(13), FEntero)
      Let Grilla.TextMatrix(Grilla.Rows - 1, 13) = Format(SQLDatos(14), FEntero)
      Let Grilla.TextMatrix(Grilla.Rows - 1, 14) = Format(SQLDatos(15), FEntero)
      Let Grilla.TextMatrix(Grilla.Rows - 1, 15) = Format(SQLDatos(16), FEntero)
      
      Let Grilla.TextMatrix(Grilla.Rows - 1, 16) = Format(SQLDatos(21), FEntero)
      
      Let Grilla.TextMatrix(Grilla.Rows - 1, 17) = IIf(SQLDatos(17) = "S", "SI", "NO")
      Let Grilla.TextMatrix(Grilla.Rows - 1, 18) = Val(SQLDatos(19))
      Let Grilla.TextMatrix(Grilla.Rows - 1, 19) = SQLDatos(22)

      Let sProgress.FloodPercent = ((nContador * 100) / nRegistros)
      If sProgress.FloodPercent >= 50 Then
         Let sProgress.ForeColor = &H8000000E
      End If
      Call BacControlWindows(1)
   Loop

   Let Grilla.Redraw = True
   Let Screen.MousePointer = vbDefault

   Let LblEtiquetaMensaje.Visible = False
   Let sProgress.FloodType = 0
   Let sProgress.FloodPercent = 0

   If Grilla.Rows = Grilla.FixedRows Then
      Call FuncSettigToolbar(False)
   Else
      Call FuncSettigToolbar(True)
   End If
   On Error GoTo 0
Exit Function
ERRLOAD:
    Resume Next
End Function


Private Function FuncSettigToolbar(ByVal xValor As Boolean)
   Dim nTipoInforme  As Integer

   If cmbreporte.ListIndex = -1 Then
      Exit Function
   End If

   Let nTipoInforme = cmbreporte.ItemData(cmbreporte.ListIndex)

   If nTipoInforme = 0 Then
      Let Toolbar1.Buttons(4).Enabled = xValor
      Let Toolbar1.Buttons(5).Enabled = xValor
      Let Toolbar1.Buttons(6).Enabled = xValor
      
      Let Toolbar1.Buttons(7).Enabled = False
      Let Toolbar1.Buttons(8).Enabled = False
   Else
      Let Toolbar1.Buttons(4).Enabled = False
      Let Toolbar1.Buttons(5).Enabled = False
      Let Toolbar1.Buttons(6).Enabled = False
      
      Let Toolbar1.Buttons(7).Enabled = xValor
      Let Toolbar1.Buttons(8).Enabled = xValor
   End If
End Function

Private Sub Form_Resize()
   On Error Resume Next
   FraFiltro.Width = Me.Width - 180
   FraDetalle.Width = FraFiltro.Width
   FraDetalle.Height = Me.Height - 2800

   Grilla.Width = FraDetalle.Width - 150
   Grilla.Height = FraDetalle.Height - 200

   On Error GoTo 0
End Sub

Private Sub cmbSistema_Click()
   If cmbSistema.ListIndex = -1 Then
      Exit Sub
   End If
   Call FuncLoadProducto(Right(cmbSistema.List(cmbSistema.ListIndex), 3))
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call FuncLimpiar
      Case 3
         Call FuncLoadDatos
      Case 4
         Call FuncGenInforme(crptToWindow)
      Case 5
         Call FuncGenInforme(crptToPrinter)
      Case 6
         Call FuncGenExcell
      
      Case 7
         Call FuncGenCARTOLASTHRESHOLD
      Case 8
         Call FrmCargaArchivoThresHold.Show(vbModal)
      Case 10
         Call Unload(Me)
   End Select
End Sub

Private Function FunnReadPathFile(ByRef PathFile As String) As Boolean
   On Error GoTo ErrorAction
   
   Let FunnReadPathFile = False

   Let Command.CancelError = True
   Let Command.FileName = "CarteraThreshold.xls"
  Call Command.ShowSave
   
   Let PathFile = Command.FileName
   Let FunnReadPathFile = True
   On Error GoTo 0
Exit Function
ErrorAction:
   Screen.MousePointer = vbDefault
   If Not Err.Number = 32755 Then
      Call MsgBox(Err.Description, vbExclamation, App.Title)
   End If
End Function


Private Function FuncGenExcellNew()

End Function

Private Function FuncGenExcell()
   Dim MiExcell   As Object
   Dim MiLibro    As Object
   Dim MiHoja     As Object
   Dim PathFile   As String
   Dim nFilas     As Long
   Dim nContador  As Long
   Dim SQLDatos()
   
   If FunnReadPathFile(PathFile) = False Then
      Exit Function
   End If
   If Dir(PathFile) <> "" Then
      Call Kill(PathFile)
   End If
   
   Set MiExcell = CreateObject("Excel.Application")
   Set MiLibro = MiExcell.Application.Workbooks.Add
   Set MiHoja = MiLibro.Sheets.Add
   Set MiSheet = MiExcell.ActiveSheet

   Let sProgress.ForeColor = &H80000007
   Let Screen.MousePointer = vbHourglass
   Let sProgress.FloodType = 1
   
   
   MiSheet.Name = "Cartera Threshold"

   MiFila = 1
   MiHoja.Cells(MiFila, 1) = "MODULO":             MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
   MiHoja.Cells(MiFila, 2) = "PRODUCTO":           MiHoja.Cells(MiFila, 2).Font.Name = "Arial": MiHoja.Cells(MiFila, 2).Font.Size = 8
   MiHoja.Cells(MiFila, 3) = "RUT CLIENTE":        MiHoja.Cells(MiFila, 3).Font.Name = "Arial": MiHoja.Cells(MiFila, 3).Font.Size = 8
   MiHoja.Cells(MiFila, 4) = "COD CLIENTE":        MiHoja.Cells(MiFila, 4).Font.Name = "Arial": MiHoja.Cells(MiFila, 4).Font.Size = 8
   MiHoja.Cells(MiFila, 5) = "NOMBRE CLIENTE":     MiHoja.Cells(MiFila, 5).Font.Name = "Arial": MiHoja.Cells(MiFila, 5).Font.Size = 8
   MiHoja.Cells(MiFila, 6) = "N° CONTRATO":        MiHoja.Cells(MiFila, 6).Font.Name = "Arial": MiHoja.Cells(MiFila, 6).Font.Size = 8
   MiHoja.Cells(MiFila, 7) = "TIPO OPERACION":     MiHoja.Cells(MiFila, 7).Font.Name = "Arial": MiHoja.Cells(MiFila, 7).Font.Size = 8
   MiHoja.Cells(MiFila, 8) = "FECHA DE CIERRE":    MiHoja.Cells(MiFila, 8).Font.Name = "Arial": MiHoja.Cells(MiFila, 8).Font.Size = 8
   MiHoja.Cells(MiFila, 9) = "FECHA DE TERMINO":   MiHoja.Cells(MiFila, 9).Font.Name = "Arial": MiHoja.Cells(MiFila, 9).Font.Size = 8
   MiHoja.Cells(MiFila, 10) = "PLAZO":             MiHoja.Cells(MiFila, 10).Font.Name = "Arial": MiHoja.Cells(MiFila, 10).Font.Size = 8
   MiHoja.Cells(MiFila, 11) = "MONTO NOCIONAL":    MiHoja.Cells(MiFila, 11).Font.Name = "Arial": MiHoja.Cells(MiFila, 11).Font.Size = 8
   MiHoja.Cells(MiFila, 12) = "TASA":              MiHoja.Cells(MiFila, 12).Font.Name = "Arial": MiHoja.Cells(MiFila, 12).Font.Size = 8
   MiHoja.Cells(MiFila, 13) = "VALOR MERCADO":     MiHoja.Cells(MiFila, 13).Font.Name = "Arial": MiHoja.Cells(MiFila, 13).Font.Size = 8
   MiHoja.Cells(MiFila, 14) = "MONTO THRESHOLD":   MiHoja.Cells(MiFila, 14).Font.Name = "Arial": MiHoja.Cells(MiFila, 14).Font.Size = 8
   MiHoja.Cells(MiFila, 15) = "MONTO EXCESO":      MiHoja.Cells(MiFila, 15).Font.Name = "Arial": MiHoja.Cells(MiFila, 15).Font.Size = 8
   MiHoja.Cells(MiFila, 16) = "MONTO REC":         MiHoja.Cells(MiFila, 16).Font.Name = "Arial": MiHoja.Cells(MiFila, 16).Font.Size = 8
   MiHoja.Cells(MiFila, 17) = "MTO. NOCIONAL $":   MiHoja.Cells(MiFila, 17).Font.Name = "Arial": MiHoja.Cells(MiFila, 17).Font.Size = 8
   MiHoja.Cells(MiFila, 18) = "APLICA THRESHOLD":  MiHoja.Cells(MiFila, 18).Font.Name = "Arial": MiHoja.Cells(MiFila, 18).Font.Size = 8
   MiHoja.Cells(MiFila, 19) = "MONEDA":            MiHoja.Cells(MiFila, 19).Font.Name = "Arial": MiHoja.Cells(MiFila, 19).Font.Size = 8
   MiHoja.Cells(MiFila, 20) = "CONTRATO NUEVO":    MiHoja.Cells(MiFila, 20).Font.Name = "Arial": MiHoja.Cells(MiFila, 20).Font.Size = 8
   MiHoja.Cells(MiFila, 21) = "MONTO GARANTIAS":   MiHoja.Cells(MiFila, 21).Font.Name = "Arial": MiHoja.Cells(MiFila, 21).Font.Size = 8
   MiHoja.Cells(MiFila, 22) = "ESTADO CLINTE":     MiHoja.Cells(MiFila, 22).Font.Name = "Arial": MiHoja.Cells(MiFila, 22).Font.Size = 8
   MiHoja.Cells(MiFila, 23) = "MENSAJE":           MiHoja.Cells(MiFila, 23).Font.Name = "Arial": MiHoja.Cells(MiFila, 23).Font.Size = 8

   MiUltimaConsulaSql = Replace(MiUltimaConsulaSql, "dbo.SP_LEER_CARTERA_THRESHOLD", "dbo.SP_INFORME_CARTERA_THRESHOLD")
      
   If Not Bac_Sql_Execute(MiUltimaConsulaSql) Then
      Call MiHoja.Application.Workbooks.Close
      Call MiExcell.Application.Workbooks.Close
   
      Set MiExcell = Nothing
      Set MiLibro = Nothing
      Set MiHoja = Nothing
      Set MiSheet = Nothing
      
      Exit Function
   End If
   
   Let nContador = 0
   Do While Bac_SQL_Fetch(SQLDatos())
      nContador = nContador + 1
      MiFila = MiFila + 1
       
       MiHoja.Cells(MiFila, 1) = SQLDatos(1):  MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
       MiHoja.Cells(MiFila, 2) = SQLDatos(2):  MiHoja.Cells(MiFila, 2).Font.Name = "Arial": MiHoja.Cells(MiFila, 2).Font.Size = 8
       MiHoja.Cells(MiFila, 3) = SQLDatos(3):  MiHoja.Cells(MiFila, 3).Font.Name = "Arial": MiHoja.Cells(MiFila, 3).Font.Size = 8
       MiHoja.Cells(MiFila, 4) = SQLDatos(4):  MiHoja.Cells(MiFila, 4).Font.Name = "Arial": MiHoja.Cells(MiFila, 4).Font.Size = 8
       MiHoja.Cells(MiFila, 5) = SQLDatos(5):  MiHoja.Cells(MiFila, 5).Font.Name = "Arial": MiHoja.Cells(MiFila, 5).Font.Size = 8
       MiHoja.Cells(MiFila, 6) = SQLDatos(6):  MiHoja.Cells(MiFila, 6).Font.Name = "Arial": MiHoja.Cells(MiFila, 6).Font.Size = 8
       MiHoja.Cells(MiFila, 7) = SQLDatos(7):  MiHoja.Cells(MiFila, 7).Font.Name = "Arial": MiHoja.Cells(MiFila, 7).Font.Size = 8
       MiHoja.Cells(MiFila, 8) = SQLDatos(8):  MiHoja.Cells(MiFila, 8).Font.Name = "Arial": MiHoja.Cells(MiFila, 8).Font.Size = 8
       MiHoja.Cells(MiFila, 9) = SQLDatos(9):  MiHoja.Cells(MiFila, 9).Font.Name = "Arial": MiHoja.Cells(MiFila, 9).Font.Size = 8
      MiHoja.Cells(MiFila, 10) = SQLDatos(10): MiHoja.Cells(MiFila, 10).Font.Name = "Arial": MiHoja.Cells(MiFila, 10).Font.Size = 8
      MiHoja.Cells(MiFila, 11) = SQLDatos(11): MiHoja.Cells(MiFila, 11).Font.Name = "Arial": MiHoja.Cells(MiFila, 11).Font.Size = 8
      MiHoja.Cells(MiFila, 12) = SQLDatos(12): MiHoja.Cells(MiFila, 12).Font.Name = "Arial": MiHoja.Cells(MiFila, 12).Font.Size = 8
      MiHoja.Cells(MiFila, 13) = SQLDatos(13): MiHoja.Cells(MiFila, 13).Font.Name = "Arial": MiHoja.Cells(MiFila, 13).Font.Size = 8
      MiHoja.Cells(MiFila, 14) = SQLDatos(14): MiHoja.Cells(MiFila, 14).Font.Name = "Arial": MiHoja.Cells(MiFila, 14).Font.Size = 8
      MiHoja.Cells(MiFila, 15) = SQLDatos(15): MiHoja.Cells(MiFila, 15).Font.Name = "Arial": MiHoja.Cells(MiFila, 15).Font.Size = 8
      MiHoja.Cells(MiFila, 16) = SQLDatos(16): MiHoja.Cells(MiFila, 16).Font.Name = "Arial": MiHoja.Cells(MiFila, 16).Font.Size = 8
      MiHoja.Cells(MiFila, 17) = SQLDatos(28): MiHoja.Cells(MiFila, 17).Font.Name = "Arial": MiHoja.Cells(MiFila, 17).Font.Size = 8
      MiHoja.Cells(MiFila, 18) = SQLDatos(17): MiHoja.Cells(MiFila, 18).Font.Name = "Arial": MiHoja.Cells(MiFila, 18).Font.Size = 8
      MiHoja.Cells(MiFila, 19) = SQLDatos(20): MiHoja.Cells(MiFila, 19).Font.Name = "Arial": MiHoja.Cells(MiFila, 19).Font.Size = 8
      MiHoja.Cells(MiFila, 20) = SQLDatos(29): MiHoja.Cells(MiFila, 20).Font.Name = "Arial": MiHoja.Cells(MiFila, 20).Font.Size = 8
      MiHoja.Cells(MiFila, 21) = SQLDatos(21): MiHoja.Cells(MiFila, 21).Font.Name = "Arial": MiHoja.Cells(MiFila, 21).Font.Size = 8
      MiHoja.Cells(MiFila, 22) = SQLDatos(22): MiHoja.Cells(MiFila, 22).Font.Name = "Arial": MiHoja.Cells(MiFila, 22).Font.Size = 8
      MiHoja.Cells(MiFila, 23) = SQLDatos(23): MiHoja.Cells(MiFila, 23).Font.Name = "Arial": MiHoja.Cells(MiFila, 23).Font.Size = 8

      nFilas = Grilla.Rows - 1
      
      
      Let sProgress.FloodPercent = (nContador * 100) / nFilas
      If sProgress.FloodPercent >= 50 Then
         Let sProgress.ForeColor = &H8000000E
      End If
      Call BacControlWindows(1)
   Loop


''''   For nContador = 1 To Grilla.Rows - 1
''''      MiFila = MiFila + 1
''''      MiHoja.Cells(MiFila, 1) = Grilla.TextMatrix(nContador, 0):   MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 2) = Grilla.TextMatrix(nContador, 1):   MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 3) = Grilla.TextMatrix(nContador, 2):   MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 4) = Grilla.TextMatrix(nContador, 3):   MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 5) = Grilla.TextMatrix(nContador, 4):   MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 6) = Grilla.TextMatrix(nContador, 5):   MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 7) = Grilla.TextMatrix(nContador, 6):   MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 8) = Grilla.TextMatrix(nContador, 7):   MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 9) = Grilla.TextMatrix(nContador, 8):   MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 10) = Grilla.TextMatrix(nContador, 9):  MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 11) = Grilla.TextMatrix(nContador, 10): MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 12) = Grilla.TextMatrix(nContador, 11): MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 13) = Grilla.TextMatrix(nContador, 12): MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 14) = Grilla.TextMatrix(nContador, 13): MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 15) = Grilla.TextMatrix(nContador, 14): MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 16) = Grilla.TextMatrix(nContador, 15): MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 17) = Grilla.TextMatrix(nContador, 16): MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 18) = Grilla.TextMatrix(nContador, 17): MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 19) = Grilla.TextMatrix(nContador, 18): MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''      MiHoja.Cells(MiFila, 20) = Grilla.TextMatrix(nContador, 19): MiHoja.Cells(MiFila, 1).Font.Name = "Arial": MiHoja.Cells(MiFila, 1).Font.Size = 8
''''
''''      Let sProgress.FloodPercent = (nContador * 100) / nFilas
''''      If sProgress.FloodPercent >= 50 Then
''''         Let sProgress.ForeColor = &H8000000E
''''      End If
''''      Call BacControlWindows(1)
''''   Next nContador
   
   Call MiHoja.SaveAs(PathFile)
   
   Call MiHoja.Application.Workbooks.Close
   Call MiExcell.Application.Workbooks.Close

   Set MiExcell = Nothing
   Set MiLibro = Nothing
   Set MiHoja = Nothing
   Set MiSheet = Nothing
   
  'Call Shell("C:\Archivos de programa\Microsoft Office\Office12\EXCEL.EXE " & PathFile)

   Let Screen.MousePointer = vbDefault
   Let sProgress.FloodType = 0
   Let sProgress.FloodPercent = 0

   Call MsgBox("Archivo se ha generado en la ruta seleccionada." & vbCrLf & PathFile, vbInformation, App.Title)

End Function


Private Sub txt_fecha_LostFocus()
   If txt_fecha.Text > gsBAC_Fecp Then
      Call MsgBox("No se puede seleecionar una fecha mayor a la fecha de proceso.", vbExclamation, App.Title)
      txt_fecha.Text = gsBAC_Fecp
   End If
End Sub

Private Sub TxtRut_DblClick()
   'BacAyuda.Tag = "Cliente"
   'BacAyuda.Show 1
   BacAyudaCliente.Tag = "Cliente"
   BacAyudaCliente.Show 1
   If giAceptar = True Then
      TXTRut.Text = RetornoAyuda
      TxtCodCli.Text = RetornoAyuda2
      LblNombre.Caption = RetornoAyuda3
   End If
End Sub


Function FuncGenInforme(ByVal xDestiono As DestinationConstants) As Integer
   On Error GoTo ErrorInforme
   Dim Modulo     As String
   Dim Producto   As String
   Dim Threshold  As String
   
   Let Modulo = Trim(Right(cmbSistema.List(cmbSistema.ListIndex), 3))
   Let Producto = Trim(Right(cmbpro.List(cmbpro.ListIndex), 5))
   Let Threshold = Trim(Right(CmbThreshold.List(CmbThreshold.ListIndex), 5))

   Call Limpiar_Cristal
   
   BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "INFORME_CARTERA_THRESHOLD.rpt" '--> "Informe_Movimientos_ThresHold.rpt"
   BacControlFinanciero.CryFinanciero.Destination = xDestiono
   BacControlFinanciero.CryFinanciero.WindowTitle = TITSISTEMA & "INFORME DE CARTERA THRESHOLD."
   BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format(txt_fecha.Text, "yyyy-mm-dd 00:00:00.000")
   BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Modulo
   BacControlFinanciero.CryFinanciero.StoredProcParam(2) = Producto
   BacControlFinanciero.CryFinanciero.StoredProcParam(3) = CDbl(TXTRut.Text)
   BacControlFinanciero.CryFinanciero.StoredProcParam(4) = CDbl(TxtCodCli.Text)
   BacControlFinanciero.CryFinanciero.StoredProcParam(5) = Threshold
   BacControlFinanciero.CryFinanciero.StoredProcParam(6) = gsBAC_User
   BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
   BacControlFinanciero.CryFinanciero.Connect = swConeccion
   BacControlFinanciero.CryFinanciero.Action = 1

Exit Function
ErrorInforme:
   ErrorInforme BacControlFinanciero.CryFinanciero.ReportFileName
End Function


Private Function FuncGenCARTOLASTHRESHOLD()
   Dim NombreArchivo          As String         '--> NomArchivo
   Dim PathArchivo            As String
   Dim ArchivoImagen          As String
   Dim TopMHTML               As String
   Dim StyleMsoNormalTable    As String
   Dim StyleMsoNormalTable2   As String
   Dim SaltoPagina            As String
   Dim Encabezado             As String
   Dim Titulos                As String
   Dim TitulosSWAP            As String
   Dim TablaProdCliente       As String
   Dim TablaProdClienteSWAP   As String
   Dim HTML                   As String
   Dim HTMLTABLE              As String
   Dim nContador              As Long
   Dim NewEncabezado          As String
   Dim Datos()
   

   Let Screen.MousePointer = vbHourglass
   Let sProgress.FloodType = 1
   Let sProgress.FloodPercent = 0

   Let NombreArchivo = "InformeCartolaClientes.doc"
   Let PathArchivo = gsRPT_Path
   Let ArchivoImagen = gsRPT_Path + "Logo.jpg"
   Let TOPHtml = LeeMHTML(PathArchivo & "Img\" & "Top_Imagen.txt")
   
   Let StyleMsoNormalTable = FuncLoadStyle(1)
   Let StyleMsoNormalTable2 = FuncLoadStyle(2)
   Let SaltoPagina = FuncLoadStyle(3)
   Let Encabezado = FuncLoadStyle(4)
   Let Titulos = FuncLoadStyle(5)
   Let TitulosSWAP = FuncLoadStyle(6)
   Let TablaProdCliente = FuncLoadStyle(7)
   Let TablaProdClienteSWAP = FuncLoadStyle(8)
   
   Envia = Array()
   AddParam Envia, Trim(Right(cmbSistema.List(cmbSistema.ListIndex), 3))
   AddParam Envia, Trim(Right(cmbpro.List(cmbpro.ListIndex), 2))
   AddParam Envia, Format(txt_fecha.Text, "yyyymmdd")
   AddParam Envia, CDbl(TXTRut.Text)
   AddParam Envia, CDbl(TxtCodCli.Text)
   AddParam Envia, gsBAC_User
   AddParam Envia, cmbreporte.ListIndex
   If Not Bac_Sql_Execute("SP_CARTOLA_CLIENTE", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha generado un error en la carga de información", vbExclamation, App.Title)
      Exit Function
   End If

   Let HTML = TopMHTML & "<HTML>" & "<HEAD>" & "<STYLE>" & StyleMsoNormalTable & StyleMsoNormalTable2 & "</STYLE>" & "</HEAD><BODY><DIV>"
   Let HTMLTABLE = "<TABLE ALIGN =3DCENTER width=3D640 class=3DMsoNormalTable BORDER=3D1 CELLSPACING=3D0 CELLPADDING=3D0 >"
   Let nContador = 1

   Do While Bac_SQL_Fetch(Datos())
   
     'Cuando es el primer registro
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
         nContador = 1
      End If

      If Trim(Datos(2)) = "BFW" Then
         HTML = HTML & "<TR>"
         HTML = HTML & "<TD align=3Dright width=3D50 " & StyleTD & ">" & nContador & "</TD>"
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
         HTML = HTML & "<TD align=3Dright width=3D50 " & StyleTD & ">" & nContador & "</TD>"
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
      nContador = nContador + 1
   Loop

   Let PieMHTML = LeeMHTML(PathArchivo & "Img\" & "Pie_Imagen.txt")
   Let HTML = HTML & "</TABLE></DIV></BODY></HTML>" & PieMHTML

   Call ImprimeDocumento(HTML, PathArchivo, NombreArchivo)

End Function

Private Function FuncLoadStyle(ByVal nFormato As Integer) As String
   
   If nFormato = 1 Then
      Let FuncLoadStyle = "Table.MsoNormalTable" & _
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
   End If
   
   If nFormato = 2 Then
      Let FuncLoadStyle = "Table.MsoNormalTable2" & _
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
   End If
   
   If nFormato = 3 Then
      Let FuncLoadStyle = "<SPAN><BR CLEAR=ALL STYLE='MSO-SPECIAL-CHARACTER:LINE-BREAK;PAGE-BREAK-BEFORE:ALWAYS'></SPAN>"
   End If
   
   If nFormato = 4 Then
      Let FuncLoadStyle = "<TABLE ALIGN =3DCENTER width=3D640 class=3DMsoNormalTable2 BORDER=3D0 CELLSPACING=3D0 CELLPADDING=3D0>" & _
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
   End If

   If nFormato = 5 Then
      Let FuncLoadStyle = "<TR BGCOLOR=3D#000000>" & _
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
   End If
   
   If nFormato = 6 Then
      Let FuncLoadStyle = "<TR BGCOLOR=3D#000000>" & _
                         "<TD width=3D50>N°</TD>" & _
                         "<TD width=3D50>Flujo</TD>" & _
                         "<TD width=3D100>Fecha Inicio</TD>" & _
                         "<TD width=3D100>Fecha<BR>Vencimiento</TD>" & _
                         "<TD width=3D70>Próximo<BR>Vecimiento</TD>" & _
                         "<TD width=3D70>Nocional</TD>" & _
                         "<TD width=3D70>Tasas</TD>" & _
                         "#TitColMtmSwap#" & _
                         "</TR>"
   End If
   
   
   If nFormato = 7 Then
      Let FuncLoadStyle = "<TABLE ALIGN =3DCENTER class=3DMsoNormalTable width=3D640>" & _
                         "<TR COLSPAN=10><TD WIDTH=3D640><HR></TD></TR>" & _
                         "<TR COLSPAN=10><TD WIDTH=3D640>#ProdCli#</TD></TR>" & _
                         "</TABLE>"
   End If
   
   If nFormato = 8 Then
      Let FuncLoadStyle = "<TABLE ALIGN =3DCENTER class=3DMsoNormalTable width=3D640>" & _
                         "<TR COLSPAN=7><TD WIDTH=3D640><HR></TD></TR>" & _
                         "<TR COLSPAN=7><TD WIDTH=3D640>#ProdCli#</TD></TR>" & _
                         "</TABLE>"
   End If

End Function

Private Function LeeMHTML(NomArchivo As String)
   Dim tmpPieMHTML   As String
   Dim PieMHTML      As String
   Dim HFile%
   
   Let COdImage = ""
   Let PieMHTML = ""
   Let HFile% = FreeFile

   Open NomArchivo For Input As #HFile%
        
   Do While Not EOF(HFile)
      Line Input #HFile, tmpPieMHTML
      PieMHTML = PieMHTML & tmpPieMHTML & vbCrLf
   Loop
   
   Let LeeMHTML = PieMHTML

   Close #HFile%
End Function

Private Sub ImprimeDocumento(DocumentoHtml As String, PathArchivo As String, NomArchivo As String)
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


Private Function ShellEx(ByVal sFile As String, _
        Optional ByVal eShowCmd As EShellShowConstants = essSW_SHOWDEFAULT, _
        Optional ByVal sParameters As String = "", _
        Optional ByVal sDefaultDir As String = "", _
        Optional sOperation As String = "open", _
        Optional Owner As Long = 0 _
    ) As Boolean
    
   Dim lR      As Long
   Dim lErr    As Long
   Dim sErr    As Long

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
      lErr = vbObjectError + 1048 + lR
      Select Case lR
         Case 0:                       lErr = 7: sErr = "Out of memory"
         Case ERROR_FILE_NOT_FOUND:    lErr = 53: sErr = "File not found"
         Case ERROR_PATH_NOT_FOUND:    lErr = 76: sErr = "Path not found"
         Case ERROR_BAD_FORMAT:        sErr = "The executable file is invalid or corrupt"
         Case SE_ERR_ACCESSDENIED:     lErr = 75: sErr = "Path/file access error"
         Case SE_ERR_ASSOCINCOMPLETE:  sErr = "This file type does not have a valid file association."
         Case SE_ERR_DDEBUSY:          lErr = 285: sErr = "The file could not be opened because the target application is busy. Please try again in a moment."
         Case SE_ERR_DDEFAIL:          lErr = 285: sErr = "The file could not be opened because the DDE transaction failed. Please try again in a moment."
         Case SE_ERR_DDETIMEOUT:       lErr = 286: sErr = "The file could not be opened due to time out. Please try again in a moment."
         Case SE_ERR_DLLNOTFOUND:      lErr = 48: sErr = "The specified dynamic-link library was not found."
         Case SE_ERR_FNF:              lErr = 53: sErr = "File not found"
         Case SE_ERR_NOASSOC:          sErr = "No application is associated with this file type."
         Case SE_ERR_OOM:              lErr = 7: sErr = "Out of memory"
         Case SE_ERR_PNF:              lErr = 76: sErr = "Path not found"
         Case SE_ERR_SHARE:            lErr = 75: sErr = "A sharing violation occurred."
         Case Else:                    sErr = "An error occurred occurred whilst trying to open or print the selected file."
      End Select

      Err.Raise lErr, , App.EXEName & ".GShell", sErr
      ShellEx = False
   End If

End Function

