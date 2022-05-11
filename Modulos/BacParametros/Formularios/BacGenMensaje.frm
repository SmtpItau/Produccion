VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacGenMensaje 
   Caption         =   "Monitoreo de Operaciones"
   ClientHeight    =   6510
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   13740
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   6510
   ScaleWidth      =   13740
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   255
      Index           =   0
      Left            =   525
      Picture         =   "BacGenMensaje.frx":0000
      ScaleHeight     =   255
      ScaleWidth      =   255
      TabIndex        =   7
      Top             =   1455
      Visible         =   0   'False
      Width           =   255
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4275
      Top             =   30
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
            Picture         =   "BacGenMensaje.frx":015A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacGenMensaje.frx":05AC
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacGenMensaje.frx":08C6
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacGenMensaje.frx":0BE0
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacGenMensaje.frx":0EFA
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   13740
      _ExtentX        =   24236
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList2"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   10
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Busca"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpia"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprime"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Ver en Pantalla"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "G e n e r a   P a g o   E l e c t r ó n i c o "
            ImageIndex      =   6
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Datos del Beneficiario"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Ingreso de Claves"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Refundir Operaciones"
            ImageIndex      =   9
         EndProperty
      EndProperty
      BorderStyle     =   1
      MouseIcon       =   "BacGenMensaje.frx":134E
      Begin VB.Timer Timer1 
         Interval        =   5000
         Left            =   8220
         Top             =   30
      End
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   5040
         Top             =   30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   9
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacGenMensaje.frx":17A0
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacGenMensaje.frx":267A
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacGenMensaje.frx":3554
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacGenMensaje.frx":442E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacGenMensaje.frx":5308
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacGenMensaje.frx":5622
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacGenMensaje.frx":64FC
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacGenMensaje.frx":73D6
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacGenMensaje.frx":82B0
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSFrame Filtro1 
      Height          =   885
      Left            =   45
      TabIndex        =   0
      Top             =   465
      Width           =   7620
      _Version        =   65536
      _ExtentX        =   13441
      _ExtentY        =   1561
      _StockProps     =   14
      Caption         =   "Búsqueda de Operación"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin BACControles.TXTNumero txtNrOperacion 
         Height          =   315
         Left            =   6075
         TabIndex        =   6
         Top             =   465
         Width           =   1455
         _ExtentX        =   2566
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
         Min             =   "0"
         Max             =   "999999999"
      End
      Begin VB.ComboBox CMB_TpOperacion 
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
         Left            =   2790
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   465
         Width           =   3225
      End
      Begin VB.ComboBox CMB_sistema 
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
         Left            =   135
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   465
         Width           =   2595
      End
      Begin VB.Label LBL_3 
         AutoSize        =   -1  'True
         Caption         =   "N° Operación"
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
         Left            =   6060
         TabIndex        =   5
         Top             =   240
         Width           =   1155
      End
      Begin VB.Label LBL_2 
         AutoSize        =   -1  'True
         Caption         =   "Tipo Operación"
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
         Left            =   2775
         TabIndex        =   3
         Top             =   240
         Width           =   1320
      End
      Begin VB.Label LBL_1 
         AutoSize        =   -1  'True
         Caption         =   "Sistema"
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
         Left            =   135
         TabIndex        =   1
         Top             =   240
         Width           =   675
      End
   End
   Begin VB.Frame Filtro2 
      Height          =   900
      Left            =   7680
      TabIndex        =   12
      Top             =   450
      Width           =   6045
      Begin VB.ComboBox cmbEstado 
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
         Left            =   2940
         Style           =   2  'Dropdown List
         TabIndex        =   16
         Top             =   465
         Width           =   2850
      End
      Begin VB.ComboBox cmbMoneda 
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
         Left            =   45
         Style           =   2  'Dropdown List
         TabIndex        =   14
         Top             =   465
         Width           =   2850
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Estado"
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
         Left            =   2940
         TabIndex        =   15
         Top             =   240
         Width           =   600
      End
      Begin VB.Label Label1 
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
         Left            =   60
         TabIndex        =   13
         Top             =   240
         Width           =   690
      End
   End
   Begin VB.Frame Detalle 
      Height          =   4350
      Left            =   60
      TabIndex        =   9
      Top             =   1275
      Width           =   13650
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   345
         Index           =   0
         Left            =   135
         Picture         =   "BacGenMensaje.frx":918A
         ScaleHeight     =   345
         ScaleWidth      =   375
         TabIndex        =   19
         Top             =   195
         Visible         =   0   'False
         Width           =   375
      End
      Begin MSFlexGridLib.MSFlexGrid GRD_mensajes 
         Height          =   4155
         Left            =   45
         TabIndex        =   10
         Top             =   165
         Width           =   13545
         _ExtentX        =   23892
         _ExtentY        =   7329
         _Version        =   393216
         Cols            =   16
         FixedCols       =   0
         RowHeightMin    =   315
         BackColor       =   -2147483633
         ForeColor       =   -2147483625
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   8421504
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
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
      Begin BACControles.TXTNumero TXTNumero1 
         Height          =   375
         Left            =   4905
         TabIndex        =   11
         Top             =   465
         Visible         =   0   'False
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   661
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
   End
   Begin VB.Frame Fr_Mensaje 
      ForeColor       =   &H00FF0000&
      Height          =   900
      Left            =   60
      TabIndex        =   17
      Top             =   5595
      Width           =   13635
      Begin VB.Label Lbl_Mensaje 
         Alignment       =   2  'Center
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   570
         Left            =   60
         TabIndex        =   18
         Top             =   210
         Width           =   13500
      End
   End
End
Attribute VB_Name = "BacGenMensaje"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim DATOS()
Public iAceptarGrupo As Boolean

Const nFechaProc = 1
Const nVencimientos = 2

Public Function FUNC_VALIDA_VENC_SWAP() As Boolean
   Let FUNC_VALIDA_VENC_SWAP = True
   
   Let Lbl_Mensaje.Caption = ""
   Let Screen.MousePointer = vbHourglass

   If Not Bac_Sql_Execute("SP_VAL_MENSAJES_PCS") Then
      Let Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intentar validar el estado de los vencimientos SWAP", vbCritical
      Exit Function
   End If
   
   Do While Bac_SQL_Fetch(DATOS())
      If DATOS(nFechaProc) <> "OK" Then
         Let FUNC_VALIDA_VENC_SWAP = False
         Lbl_Mensaje.Caption = "No se puede verificar la existencia de pagos para la generacion de mensajes del motor de pago para SWAP, debido a que las fechas de proceso de Swap y Parametros son distintas"
      Else
         If DATOS(nVencimientos) <> "OK" Then
            Let FUNC_VALIDA_VENC_SWAP = False
            Lbl_Mensaje.Caption = "No se ha realizado la verificacion de vencimientos Swap"
         End If
      End If
   Loop
   
   Let Screen.MousePointer = vbDefault
End Function

Private Sub Cmb_Sistema_Click()
   Dim ls_cd_sistema, ls_tipo_operacion

   Call CMB_TpOperacion.Clear

   Let ls_cd_sistema = Right(CMB_SISTEMA.Text, 3)

   Envia = Array()
   AddParam Envia, ls_cd_sistema
   If Cmb_Sistema.ListIndex <> -1 Then
      If Bac_Sql_Execute("SP_BTR_LISTA_PRODUCTOS", Envia) Then
         CMB_TpOperacion.Enabled = True
         Do While Bac_SQL_Fetch(DATOS())
            CMB_TpOperacion.AddItem DATOS(1) & Space(90) & DATOS(2)
         Loop
      End If
   End If

End Sub

Private Sub Cmb_sistema_KeyPress(KeyAscii As Integer)
   If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 8 And KeyAscii <> 13 Then
      Let KeyAscii = 0
   End If
   If KeyAscii = vbKeyReturn Then
      If CMB_SISTEMA.Text <> " " Then
         Let CMB_TpOperacion.Enabled = True
         Call CMB_TpOperacion.SetFocus
      End If
   End If
End Sub

Private Sub CMB_TpOperacion_KeyPress(KeyAscii As Integer)
   If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 8 And KeyAscii <> 13 Then
      Let KeyAscii = 0
   End If
   If KeyAscii = vbKeyReturn Then
      If txtNrOperacion.Text <> " " Then
         Call txtNrOperacion.SetFocus
      End If
   End If
End Sub

Private Sub CargaCombosInicio()
   Dim DATOS()
   Dim Envia
   
   Envia = Array()
   If Bac_Sql_Execute("SP_BTR_SISTEMAS_ACTIVOS") Then
      Do While Bac_SQL_Fetch(Datos())
         Cmb_Sistema.AddItem Datos(2) & Space(90) & Datos(1)
      Loop
   End If

   Envia = Array()
   AddParam Envia, "M"
   If Not Bac_Sql_Execute("SP_BTR_SISTEMAS_ACTIVOS", Envia) Then
      Exit Sub
   End If
   
   cmbMoneda.Clear
   cmbMoneda.AddItem "<< TODAS >>"
   cmbMoneda.ItemData(cmbMoneda.NewIndex) = 0
   Do While Bac_SQL_Fetch(DATOS())
      cmbMoneda.AddItem DATOS(3)
      cmbMoneda.ItemData(cmbMoneda.NewIndex) = DATOS(1)
   Loop

   Envia = Array()
   AddParam Envia, "E"
   If Not Bac_Sql_Execute("SP_BTR_SISTEMAS_ACTIVOS", Envia) Then
      Exit Sub
   End If
   
   cmbEstado.Clear
   cmbEstado.AddItem "<< TODOS >> " & Space(100) & "-" & " "
   Do While Bac_SQL_Fetch(DATOS())
      cmbEstado.AddItem DATOS(2) & Space(100) & "-" & DATOS(1)
   Loop

End Sub

Private Sub Form_Load()
   Let Me.Icon = BACSwapParametros.Icon
   Let Me.Top = 0:        Let Me.Left = 0
   Let Me.Width = 14925:  Let Me.Height = 8195

   Let CMB_TpOperacion.Enabled = False
   Let Toolbar1.Buttons(3).Enabled = False:  Let Toolbar1.Buttons(4).Enabled = False

   Call CargaCombosInicio
   Call dibuja_grilla
End Sub

Private Sub dibuja_grilla()
   Dim m   As Integer
   Dim mm  As Integer

   Let Toolbar1.Buttons(3).Enabled = False
   Let Toolbar1.Buttons(4).Enabled = False

   Let CMB_SISTEMA.ListIndex = -1
   Let txtNrOperacion.Text = "0"
   Let CMB_TpOperacion.ListIndex = -1: Let CMB_TpOperacion.Enabled = False
   Let cmbMoneda.ListIndex = -1
   Let cmbEstado.ListIndex = -1

   Let GRD_mensajes.Rows = 2:       Let GRD_mensajes.Cols = 15
   Let GRD_mensajes.FixedRows = 1:  Let GRD_mensajes.FixedCols = 0

   Let GRD_mensajes.TextMatrix(0, 0) = "M":                    Let GRD_mensajes.ColWidth(0) = 350
   Let GRD_mensajes.TextMatrix(0, 1) = "Estado":               Let GRD_mensajes.ColWidth(1) = 1000
   Let GRD_mensajes.TextMatrix(0, 2) = "Tip Oper":             Let GRD_mensajes.ColWidth(2) = 3000
   Let GRD_mensajes.TextMatrix(0, 3) = "# Oper.":              Let GRD_mensajes.ColWidth(3) = 700
   Let GRD_mensajes.TextMatrix(0, 4) = "Nombre/Razón Social":  Let GRD_mensajes.ColWidth(4) = 3000
   Let GRD_mensajes.TextMatrix(0, 5) = "Mon.":                 Let GRD_mensajes.ColWidth(5) = 500
   Let GRD_mensajes.TextMatrix(0, 6) = "Monto Operación":      Let GRD_mensajes.ColWidth(6) = 1500
   Let GRD_mensajes.TextMatrix(0, 7) = "Forma Pago":           Let GRD_mensajes.ColWidth(7) = 1400
   Let GRD_mensajes.TextMatrix(0, 8) = "Sistema":              Let GRD_mensajes.ColWidth(8) = 0
   Let GRD_mensajes.TextMatrix(0, 9) = "Fecha Inicio":         Let GRD_mensajes.ColWidth(9) = 1150
   Let GRD_mensajes.TextMatrix(0, 10) = "Fecha Valuta":        Let GRD_mensajes.ColWidth(10) = 1150
   Let GRD_mensajes.TextMatrix(0, 11) = "Liq.":                Let GRD_mensajes.ColWidth(11) = 420
   Let GRD_mensajes.TextMatrix(0, 12) = "Tipcli":              Let GRD_mensajes.ColWidth(12) = 0
   Let GRD_mensajes.TextMatrix(0, 13) = "Mensaje":             Let GRD_mensajes.ColWidth(13) = 2500
   Let GRD_mensajes.TextMatrix(0, 14) = "Agrupado":            Let GRD_mensajes.ColWidth(14) = 0

   Let GRD_mensajes.Font.Name = "Arial"
   Let GRD_mensajes.Font.Size = 8

   Let GRD_mensajes.GridLinesFixed = flexGridFlat
   Let GRD_mensajes.AllowUserResizing = flexResizeColumns
   Let GRD_mensajes.Rows = GRD_mensajes.Rows - 1
End Sub

Private Sub Inserta_Fila()
   Dim DATOS()
   Dim ls_cd_sistema       As String
   Dim ls_tipo_operacion   As String
   Dim ld_nro_operacion    As Double
   Dim MiMoneda            As Integer
   Dim MiEstado            As String
    
   Call BacControlWindows(20)
   
   Let Screen.MousePointer = vbHourglass
   Let Toolbar1.Buttons(3).Enabled = True:   Let Toolbar1.Buttons(4).Enabled = True
   
   Let ls_cd_sistema = Right(CMB_SISTEMA.Text, 3)
   Let ls_tipo_operacion = Trim(Right(CMB_TpOperacion.Text, 5))
   Let ld_nro_operacion = Val(txtNrOperacion.Text)
   
   Let MiMoneda = 0
   If cmbMoneda.ListIndex > 0 Then
      MiMoneda = cmbMoneda.ItemData(cmbMoneda.ListIndex)
   End If
   
   Let MiEstado = ""
   If cmbEstado.ListIndex > 0 Then
      MiEstado = Trim(Right(cmbEstado.Text, 1))
   End If
   
   Let ld_nro_operacion = IIf(ld_nro_operacion > 999999999, ld_nro_operacion = 999999999, ld_nro_operacion)
   
   Envia = Array()
   AddParam Envia, ls_cd_sistema
   AddParam Envia, ls_tipo_operacion
   AddParam Envia, ld_nro_operacion
   AddParam Envia, MiMoneda
   AddParam Envia, MiEstado
   If Not Bac_Sql_Execute("SP_BTR_GENERA_MENSAJES", Envia) Then
      Screen.MousePointer = vbDefault
      MsgBox "Error" & vbCrLf & vbCrLf & "No se ha podido efectuar la consulta.", vbCritical, TITSISTEMA
      Exit Sub
   End If
   
   Let GRD_mensajes.Rows = 1:  Let GRD_mensajes.Rows = 2
   Let GRD_mensajes.Redraw = False
   
   Do While Bac_SQL_Fetch(DATOS())
      Let GRD_mensajes.TextMatrix(GRD_mensajes.Rows - 1, 1) = Format(DATOS(1), "dd/mm/yyyy")
      Let GRD_mensajes.TextMatrix(GRD_mensajes.Rows - 1, 2) = DATOS(2)
      Let GRD_mensajes.TextMatrix(GRD_mensajes.Rows - 1, 3) = IIf(DATOS(16) = "A", DATOS(3) & Space(100) & DATOS(17), DATOS(3))
      Let GRD_mensajes.TextMatrix(GRD_mensajes.Rows - 1, 4) = DATOS(4)
      Let GRD_mensajes.TextMatrix(GRD_mensajes.Rows - 1, 5) = DATOS(5)
      Let GRD_mensajes.TextMatrix(GRD_mensajes.Rows - 1, 6) = IIf(DATOS(5) = "CLP", Format(DATOS(6), "#,##0"), Format(DATOS(6), "#,##0.00"))
      Let GRD_mensajes.TextMatrix(GRD_mensajes.Rows - 1, 7) = DATOS(7)
      Let GRD_mensajes.TextMatrix(GRD_mensajes.Rows - 1, 8) = DATOS(10)
      Let GRD_mensajes.TextMatrix(GRD_mensajes.Rows - 1, 9) = DATOS(11)
      Let GRD_mensajes.TextMatrix(GRD_mensajes.Rows - 1, 10) = DATOS(12)
      Let GRD_mensajes.TextMatrix(GRD_mensajes.Rows - 1, 11) = DATOS(13)
      Let GRD_mensajes.TextMatrix(GRD_mensajes.Rows - 1, 12) = DATOS(14)
      Let GRD_mensajes.TextMatrix(GRD_mensajes.Rows - 1, 13) = DATOS(15)
      Let GRD_mensajes.TextMatrix(GRD_mensajes.Rows - 1, 14) = DATOS(16)

      If DATOS(16) = "A" Then
         Call Pintar_Celdas(GRD_mensajes.Rows - 1, &H80000018, &H80000017)
      Else
         Call Pintar_Celdas(GRD_mensajes.Rows - 1, &H8000000F, &H80000012)
      End If

      Let GRD_mensajes.Row = GRD_mensajes.Rows - 1
      Let GRD_mensajes.Col = 0
      Let GRD_mensajes.CellPictureAlignment = 4
      Set GRD_mensajes.CellPicture = Me.SinCheck(0).Image
      
      Let GRD_mensajes.Rows = GRD_mensajes.Rows + 1
   Loop
   
   Let GRD_mensajes.Rows = GRD_mensajes.Rows - 1
   Let GRD_mensajes.Redraw = True
   
   Let Screen.MousePointer = vbDefault
End Sub

Private Sub Form_Resize()
   On Error GoTo ErrResize
   
   Let Filtro2.Width = Me.Width - 7800

   Let Fr_Mensaje.Width = Me.Width - 200
   Let Fr_Mensaje.Top = Me.Height - 1200
   Let Fr_Mensaje.Height = 800
   Let Lbl_Mensaje.Width = Fr_Mensaje.Width - 200
   Let Lbl_Mensaje.Height = Fr_Mensaje.Height - 250
    
   Let Detalle.Height = Fr_Mensaje.Top - 1300
   Let Detalle.Width = Me.Width - 200
   Let GRD_mensajes.Width = Detalle.Width - 70
   Let GRD_mensajes.Height = Detalle.Height - 200

ErrResize:
   On Error GoTo 0
End Sub

Private Sub GRD_mensajes_Click()
   
   If GRD_mensajes.Rows > 1 Then
      If GRD_mensajes.Col < 11 Then
         Let GRD_mensajes.Col = 0

         If Trim(GRD_mensajes.TextMatrix(GRD_mensajes.Row, 0)) = "X" Then
            Let GRD_mensajes.CellPictureAlignment = 4
            Let GRD_mensajes.TextMatrix(GRD_mensajes.Row, 0) = ""
            Set GRD_mensajes.CellPicture = Me.SinCheck(0).Image
         Else
            Set GRD_mensajes.CellPicture = Me.ConCheck(0).Image
            Let GRD_mensajes.CellPictureAlignment = 4
            Let GRD_mensajes.TextMatrix(GRD_mensajes.Row, 0) = Space(100) + "X"

            If Val(GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 12)) <> 1 Then
               If GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 5) = "CLP" Then
                  If MsgBox("¿ Desea completar los datos del beneficiario. ?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
                     Let FRM_MNT_DatosReceptor.txtRecep_Rut.Enabled = True
                     Let FRM_MNT_DatosReceptor.nNumOper = Val(Left(GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 3), 50))
                     Let FRM_MNT_DatosReceptor.cSistema = GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 8)
                     Let FRM_MNT_DatosReceptor.iMoneda = GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 5)
                     Call FRM_MNT_DatosReceptor.Show(vbModal)
                  End If
               End If
            Else
               Let FRM_MNT_DatosReceptor.txtRecep_Rut.Enabled = False
            End If
            
         End If
      End If
      
      If GRD_mensajes.Col = 11 Then
         Let GRD_mensajes.Col = 11
         If Trim(GRD_mensajes.TextMatrix(GRD_mensajes.Row, 11)) = "X" Then
            Let GRD_mensajes.TextMatrix(GRD_mensajes.Row, 11) = ""
            Set GRD_mensajes.CellPicture = Me.SinCheck(0).Image
         Else
            Set GRD_mensajes.CellPicture = Me.ConCheck(0).Image
            Let GRD_mensajes.CellPictureAlignment = 4
            Let GRD_mensajes.TextMatrix(GRD_mensajes.Row, 11) = Space(100) + "X"
         End If
         Call graba_liquidacion_Lbtr
      End If
   End If

End Sub


Function cambia_estado_Lbtr()
   Dim iContador       As Integer
   Dim Columna         As Integer
   Dim Fila            As Integer

   Let Columna = GRD_mensajes.Col
   Let Fila = GRD_mensajes.Row

   For iContador = 0 To GRD_mensajes.Rows - 1
      If Trim(GRD_mensajes.TextMatrix(iContador, 0)) = "X" Then
         Let GRD_mensajes.TextMatrix(iContador, 0) = ""

         Envia = Array()
         AddParam Envia, GRD_mensajes.TextMatrix(iContador, 8)
         AddParam Envia, Val(Left(GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 3), 50))
         If Not Bac_Sql_Execute("SP_BTR_CAMBIA_ESTADO_LBTR", Envia) Then
            MsgBox "Error Actualización" & vbCrLf & vbCrLf & "Se ha producido un error al Actualizar Registro.", vbExclamation, TITSISTEMA
            Exit Function
         End If
      End If
    Next iContador

    Call Inserta_Fila
    Let GRD_mensajes.Col = Columna
    Let GRD_mensajes.Row = Fila
End Function

Function Imprime_papeleta_Lbtr()
   On Error GoTo errorimpresion
   Dim iContador       As Long
   Dim Columna         As Integer
   Dim Fila            As Integer
   Dim cMoneda         As String
   
   Let Screen.MousePointer = vbHourglass
   Let Columna = GRD_mensajes.Col
   Let Fila = GRD_mensajes.Row

   For iContador = 0 To GRD_mensajes.Rows - 1

      If Trim(GRD_mensajes.TextMatrix(iContador, 0)) = "X" Then

         Let cMoneda = GRD_mensajes.TextMatrix(iContador, 5)

         If GRD_mensajes.TextMatrix(iContador, 14) = "A" Then
            MsgBox "No es posible imprimir mensaje para Op. agrupadas.", vbExclamation, App.Title
         Else
            If Trim(GRD_mensajes.TextMatrix(iContador, 1)) <> "Anulado" Then
               Envia = Array()
               AddParam Envia, GRD_mensajes.TextMatrix(iContador, 8)
               AddParam Envia, Val(Left(GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 3), 50))
               AddParam Envia, "I"
               If Not Bac_Sql_Execute("SP_BTR_CAMBIA_ESTADO_LBTR", Envia) Then
                  MsgBox "Error de Actualización" & vbCrLf & vbCrLf & "Se ha producido un error al Actualizar Registro.", vbExclamation, TITSISTEMA
                  Exit Function
               End If

               Call limpiar_cristal

               Let GRD_mensajes.TextMatrix(iContador, 0) = ""
               Let BACSwapParametros.BACParam.Destination = crptToPrinter
               Let BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & IIf(cMoneda = "CLP", "Mensajes_Swift_LBtr.Rpt", "MENSAJE_SWIFT_LBTR_MX.rpt")
               Let BACSwapParametros.BACParam.StoredProcParam(0) = GRD_mensajes.TextMatrix(iContador, 8)
               Let BACSwapParametros.BACParam.StoredProcParam(1) = Val(Left(GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 3), 50))
               Let BACSwapParametros.BACParam.Connect = SwConeccion
               Let BACSwapParametros.BACParam.WindowState = crptMaximized
               Let BACSwapParametros.BACParam.Action = 1
            End If
         End If

      End If

   Next iContador

   Let Screen.MousePointer = vbDefault
   Let GRD_mensajes.Col = Columna
   Let GRD_mensajes.Row = Fila

   Let Screen.MousePointer = vbDefault
Exit Function
errorimpresion:
   MsgBox Err.Description, vbExclamation, TITSISTEMA
End Function


Private Sub Timer1_Timer()
   If Not FUNC_VALIDA_VENC_SWAP Then
      If Lbl_Mensaje.ForeColor = vbBlue Then
         Let Lbl_Mensaje.ForeColor = vbRed
      Else
         Let Lbl_Mensaje.ForeColor = vbBlue
      End If
   End If
End Sub

Private Sub txtNrOperacion_KeyPress(KeyAscii As Integer)
   If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 8 And KeyAscii <> vbKeyReturn Then
      Let KeyAscii = 0
   End If
   If KeyAscii = vbKeyReturn Then
      If CMB_SISTEMA.Text <> " " Then
         CMB_SISTEMA.SetFocus
      End If
   End If
End Sub

Sub Reporte_lbtr()
   On Error GoTo Err_Print
   
   Call limpiar_cristal
   
   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "Mensajes_Swift_LBtr.Rpt"
   BACSwapParametros.BACParam.WindowShowPrintBtn = False
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.Destination = crptToWindow
   BACSwapParametros.BACParam.StoredProcParam(0) = GRD_mensajes.TextMatrix(BacGenMensaje.GRD_mensajes.Row, 8)
   BACSwapParametros.BACParam.StoredProcParam(1) = CDbl(Val(Left(GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 3), 50)))
   BACSwapParametros.BACParam.Action = 1
    
   On Error GoTo 0
Exit Sub
Err_Print:
   MsgBox BACSwapParametros.BACParam.ReportFileName & ", " & Err.Description, vbInformation, TITSISTEMA
End Sub

Function Mensaje_pantalla_Lbtr()
   On Error GoTo errorimpresion
   Dim iContador     As Long
   Dim Columna       As Integer
   Dim Fila          As Integer
   Dim cMoneda       As String
   
   Columna = GRD_mensajes.Col
   Fila = GRD_mensajes.Row
    
   For iContador = 0 To GRD_mensajes.Rows - 1
      If Trim(GRD_mensajes.TextMatrix(iContador, 0)) = "X" Then
         Let cMoneda = GRD_mensajes.TextMatrix(iContador, 5)
         
         If GRD_mensajes.TextMatrix(iContador, 14) = "A" Then
            MsgBox "No es posible imprimir mensaje swift para un Grupo.", vbExclamation, App.TaskVisible
         Else
            Call limpiar_cristal
   
            BACSwapParametros.BACParam.WindowShowPrintBtn = False
            BACSwapParametros.BACParam.Destination = crptToWindow
            If GRD_mensajes.TextMatrix(iContador, 5) = "CLP" Then
               BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "Mensajes_Swift_LBtr.Rpt"
            Else
               BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "MENSAJE_SWIFT_LBTR_MX.rpt"
            End If
            BACSwapParametros.BACParam.StoredProcParam(0) = GRD_mensajes.TextMatrix(iContador, 8)
            BACSwapParametros.BACParam.StoredProcParam(1) = Val(Left(GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 3), 50))
            BACSwapParametros.BACParam.Connect = SwConeccion
            BACSwapParametros.BACParam.WindowState = crptMaximized
            BACSwapParametros.BACParam.Action = 1
         End If
      End If

   Next iContador

   Let GRD_mensajes.Col = Columna
   Let GRD_mensajes.Row = Fila

Exit Function
errorimpresion:
   MsgBox Err.Description, vbExclamation, TITSISTEMA
End Function

Function graba_liquidacion_Lbtr()

   Envia = Array()
   AddParam Envia, GRD_mensajes.TextMatrix(BacGenMensaje.GRD_mensajes.Row, 8)
   AddParam Envia, Val(Left(GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 3), 50))
   AddParam Envia, Trim(GRD_mensajes.TextMatrix(BacGenMensaje.GRD_mensajes.Row, 11))
   If Not Bac_Sql_Execute("SP_GRABA_LIQUIDACION_LBTR", Envia) Then
      MsgBox "Error al actualizar liquidación MDLBTR", vbExclamation
      Exit Function
   End If
End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim DATOS()

   Select Case Button.Index
      Case 1
         Call Inserta_Fila
      Case 2
         Let GRD_mensajes.Rows = 1
         Let CMB_SISTEMA.ListIndex = -1
         Let CMB_TpOperacion.ListIndex = -1
         Let txtNrOperacion.Text = "0"
         Let CMB_TpOperacion.Enabled = False
         Let cmbMoneda.ListIndex = -1
         Let cmbEstado.ListIndex = -1
      Case 3
         Call Imprime_papeleta_Lbtr
      Case 4
         Call Mensaje_pantalla_Lbtr
      Case 5
         Unload Me
      Case 7
         Let Toolbar1.Enabled = False
         Call Conectar_As400
         Let Toolbar1.Enabled = True
      Case 8
         If GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 5) = "CLP" Then
            FRM_MNT_DatosReceptor.nNumOper = Val(Left(GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 3), 50))
            FRM_MNT_DatosReceptor.cSistema = GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 8)
            FRM_MNT_DatosReceptor.iMoneda = GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 5)
            FRM_MNT_DatosReceptor.Show 1
         End If
         If GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 5) <> "CLP" Then
            FRM_MNT_DatosSwiftMx.NumeroOperacion = Val(Left(GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 3), 50))
            FRM_MNT_DatosSwiftMx.Sistema = GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 8)
            FRM_MNT_DatosSwiftMx.Show 1
         End If
      Case 9
         FRM_MNT_CLAVES.Operacion = Val(Left(GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 3), 50))
         FRM_MNT_CLAVES.Sistema = GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 8)

         Envia = Array()
         AddParam Envia, "V"
         AddParam Envia, CDbl(FRM_MNT_CLAVES.Operacion)
         If Not Bac_Sql_Execute("SP_CARGA_CLAVES_DCV", Envia) Then
            Exit Sub
         End If
         If Bac_SQL_Fetch(DATOS()) Then
            If DATOS(1) = 0 Then
               FRM_MNT_CLAVES.Show 1
            Else
               MsgBox "AVISO" & vbCrLf & vbCrLf & DATOS(2), vbExclamation, TITSISTEMA
            End If
         End If
      Case 10

         Let iAceptarGrupo = False
         Call FRM_MNT_AGRUPACION.Show(vbModal)
         If iAceptarGrupo = True Then
            Call Inserta_Fila
         End If

    End Select
End Sub

Private Function Conectar_As400() As Boolean
   Dim ObjMt202103     As New clsMt202103
   Dim iContador       As Long
   Dim oSistema        As String
   Dim iMoneda         As String
   Dim iNumoper        As Double
   Dim MsgOperaciones  As String
    
   Let Toolbar1.Buttons(7).Enabled = False
   Let Screen.MousePointer = vbHourglass
   Let MsgOperaciones = ""
   
   For iContador = 1 To GRD_mensajes.Rows - 1

      If Trim(GRD_mensajes.TextMatrix(iContador, 0)) = "X" Then

         Let iNumoper = Val(Left(GRD_mensajes.TextMatrix(iContador, 3), 50))
         Let oSistema = GRD_mensajes.TextMatrix(iContador, 8)
         Let iMoneda = GRD_mensajes.TextMatrix(iContador, 5)

         If UCase(GRD_mensajes.TextMatrix(iContador, 1)) = UCase("PENDIENTE") Or UCase(GRD_mensajes.TextMatrix(iContador, 1)) = UCase("IMPRESO") Then
            If ValidaSwiftReceptor(CLng(iNumoper), oSistema, iMoneda) = True Then
               If ObjMt202103.GeneraMt(iNumoper, oSistema, iMoneda) = False Then

               Else
                  If GRD_mensajes.TextMatrix(iContador, 14) = "A" Then
                     MsgOperaciones = MsgOperaciones & Trim(Right(GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 3), 20)) & vbCrLf
                  Else
                     MsgOperaciones = MsgOperaciones & iNumoper & vbCrLf
                  End If
               End If
            End If
         
         Else
            If UCase(GRD_mensajes.TextMatrix(iContador, 1)) = UCase("ENVIADO") Then
               If GRD_mensajes.TextMatrix(iContador, 14) = "A" Then
                  MsgBox "Grupo ya enviado : " & Trim(Right(GRD_mensajes.TextMatrix(GRD_mensajes.RowSel, 3), 20)) & vbCrLf & "Sistema Origen : " & oSistema & vbCrLf & vbCrLf & "¡ No se puede reenviar !", vbExclamation, TITSISTEMA
               Else
                  MsgBox "Operación ya enviada : " & iNumoper & vbCrLf & "Sistema Origen : " & oSistema & vbCrLf & vbCrLf & "¡ No se puede reenviar !", vbExclamation, TITSISTEMA
               End If
            End If
            If UCase(GRD_mensajes.TextMatrix(iContador, 1)) = UCase("ANULADO") Then
               MsgBox "Operación Anulada : " & iNumoper & vbCrLf & "Sistema Origen : " & oSistema & vbCrLf & vbCrLf & "¡ No se puede enviar !", vbExclamation, TITSISTEMA
            End If
         End If
         
      End If
      
      GRD_mensajes.TextMatrix(iContador, 0) = ""
      GRD_mensajes.Row = iContador
      Set GRD_mensajes.CellPicture = Me.SinCheck(0).Image
   Next iContador
    
   Set ObjMt202103 = Nothing
   
   Let Screen.MousePointer = vbDefault
   
   If MsgOperaciones = "" Then
   Else
      MsgBox "Se han transmitido las Operaciones y/o Grupos :" & vbCrLf & MsgOperaciones & vbCrLf & "En forma correcta.", vbInformation, TITSISTEMA
   End If
   
   Call Inserta_Fila
    
   Toolbar1.Buttons(7).Enabled = True
   
End Function

Private Function ValidaSwiftReceptor(nNumOper As Long, Optional Id_Sistema As Variant, Optional iMoneda As String) As Boolean
   On Error GoTo ErrorDatos
   Dim DATOS()
   Dim oMensaje   As String

   ValidaSwiftReceptor = False

   If iMoneda = "USD" Then
      ValidaSwiftReceptor = True
      Exit Function
   End If

   oMensaje = ""
   
   Envia = Array()
   AddParam Envia, CDbl(nNumOper)
   AddParam Envia, Trim(Id_Sistema)
   AddParam Envia, iMoneda
   If Not Bac_Sql_Execute("SP_DATOS_RECEPTOR_BENEFICIARIO", Envia) Then
      GoTo ErrorDatos
   End If

   If Bac_SQL_Fetch(DATOS()) Then
      If Val(DATOS(13)) <> 1 Then
         oMensaje = ""
         If Trim(DATOS(5)) = "" Then
            oMensaje = oMensaje & "W - Falta Dirección del Beneficiario. " & vbCrLf
         End If
         If (Trim(DATOS(6)) = "" Or Trim(DATOS(6)) = "0" Or Trim(DATOS(6)) = "1") Or Len(Trim(DATOS(6))) < 2 Then
            oMensaje = oMensaje & "E  - Falta Cuenta del Beneficiario. " & vbCrLf
         End If
         If Val(Trim(DATOS(7))) = 0 Then
            oMensaje = oMensaje & "E  - Falta Institución Receptora " & vbCrLf
         End If
         If Trim(DATOS(11)) = "" Or Len(Trim(DATOS(11))) < 2 Then
            oMensaje = oMensaje & "E  - Falta Codigo Swift Institución Receptora." & vbCrLf
         End If
      End If
      
      If Trim(oMensaje) = "" Then
         ValidaSwiftReceptor = True
      Else
         If MsgBox("ERRORES - ADVERTENCIAS " & vbCrLf & vbCrLf & oMensaje & vbCrLf & vbCrLf & " ¿ Desea enviar de todas formas ? ", vbExclamation + vbYesNo, TITSISTEMA) = vbYes Then
            ValidaSwiftReceptor = True
         End If
      End If

   End If

   On Error GoTo 0

Exit Function
ErrorDatos:
   MsgBox "Error en Función de Validación Swift Receptor." & vbCrLf & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
   On Error GoTo 0
End Function

Private Sub Pintar_Celdas(ByVal iFila As Long, bColor As Variant, fColor As Variant)
   Dim iContador  As Integer

   GRD_mensajes.Row = iFila
   For iContador = 0 To GRD_mensajes.Cols - 1
      GRD_mensajes.Col = iContador
      GRD_mensajes.CellBackColor = bColor
      GRD_mensajes.CellForeColor = fColor
   Next iContador
End Sub
