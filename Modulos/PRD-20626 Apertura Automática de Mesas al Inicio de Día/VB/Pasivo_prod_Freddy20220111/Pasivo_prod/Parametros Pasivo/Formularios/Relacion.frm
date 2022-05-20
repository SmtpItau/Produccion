VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Begin VB.Form bacMntPlaOper 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Código de Comercio  para Planilla Automáticas"
   ClientHeight    =   4455
   ClientLeft      =   3630
   ClientTop       =   2700
   ClientWidth     =   5310
   FillStyle       =   0  'Solid
   Icon            =   "Relacion.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4455
   ScaleWidth      =   5310
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4650
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Relacion.frx":000C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Relacion.frx":0EE6
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Relacion.frx":1DC0
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Relacion.frx":2C9A
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Relacion.frx":2FB4
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   9
      Top             =   0
      Width           =   5310
      _ExtentX        =   9366
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame fraRelacion 
      Height          =   3960
      Left            =   0
      TabIndex        =   10
      Top             =   480
      Width           =   5295
      _Version        =   65536
      _ExtentX        =   9340
      _ExtentY        =   6985
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ComboBox Cmb_Sistema 
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
         Left            =   1860
         Style           =   2  'Dropdown List
         TabIndex        =   21
         Top             =   240
         Width           =   2700
      End
      Begin VB.ComboBox CmbCodCli 
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
         Left            =   3780
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   2685
         Width           =   1440
      End
      Begin VB.ComboBox cmbOperacion 
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
         Left            =   1860
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   1650
         Width           =   3360
      End
      Begin VB.TextBox txtGlosa 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   75
         Locked          =   -1  'True
         MaxLength       =   40
         TabIndex        =   7
         TabStop         =   0   'False
         Top             =   3015
         Width           =   5160
      End
      Begin VB.TextBox txtComercio 
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
         Left            =   1860
         MaxLength       =   5
         MouseIcon       =   "Relacion.frx":3E8E
         MousePointer    =   99  'Custom
         TabIndex        =   6
         Top             =   2685
         Width           =   795
      End
      Begin VB.ComboBox cmbCodigoOMA 
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
         Left            =   1860
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   5
         TabStop         =   0   'False
         Top             =   2340
         Visible         =   0   'False
         Width           =   3360
      End
      Begin VB.ComboBox CmbTipCli 
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
         Left            =   1860
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   1995
         Width           =   3360
      End
      Begin VB.ComboBox CmbCod_Prod 
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
         Left            =   1860
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   615
         Width           =   3360
      End
      Begin VB.ComboBox CmbFisico 
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
         Left            =   1860
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   1305
         Width           =   3360
      End
      Begin VB.ComboBox CmbMoneda 
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
         Left            =   1860
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   960
         Width           =   3360
      End
      Begin VB.TextBox TxtCondicion 
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
         Left            =   90
         MaxLength       =   10
         TabIndex        =   8
         Top             =   3525
         Width           =   5160
      End
      Begin VB.Label Label2 
         Caption         =   "Sistema Origen"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   255
         Left            =   120
         TabIndex        =   22
         Top             =   285
         Width           =   1455
      End
      Begin VB.Label lblRelacion 
         AutoSize        =   -1  'True
         Caption         =   "Nacionalidad"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   4
         Left            =   2745
         TabIndex        =   19
         Top             =   2760
         Width           =   1020
      End
      Begin VB.Label lblRelacion 
         AutoSize        =   -1  'True
         Caption         =   "Código de Comercio"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   3
         Left            =   135
         TabIndex        =   18
         Top             =   2760
         Width           =   1695
      End
      Begin VB.Label lblRelacion 
         AutoSize        =   -1  'True
         Caption         =   "Código OMA"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   2
         Left            =   135
         TabIndex        =   17
         Top             =   2430
         Visible         =   0   'False
         Width           =   1020
      End
      Begin VB.Label lblRelacion 
         AutoSize        =   -1  'True
         Caption         =   "Tipo de Operación"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   0
         Left            =   105
         TabIndex        =   16
         Top             =   1710
         Width           =   1500
      End
      Begin VB.Label lblRelacion 
         AutoSize        =   -1  'True
         Caption         =   "Código Producto"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   1
         Left            =   105
         TabIndex        =   15
         Top             =   675
         Width           =   1380
      End
      Begin VB.Label lblRelacion 
         AutoSize        =   -1  'True
         Caption         =   "Tipo Cliente"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   6
         Left            =   120
         TabIndex        =   14
         Top             =   2085
         Width           =   990
      End
      Begin VB.Label lblRelacion 
         AutoSize        =   -1  'True
         Caption         =   "Vencimiento Físico"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   8
         Left            =   120
         TabIndex        =   13
         Top             =   1350
         Width           =   1575
      End
      Begin VB.Label lblRelacion 
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   7
         Left            =   120
         TabIndex        =   12
         Top             =   1005
         Width           =   660
      End
      Begin VB.Label lblRelacion 
         AutoSize        =   -1  'True
         Caption         =   "Condición"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   5
         Left            =   120
         TabIndex        =   11
         Top             =   3330
         Width           =   825
      End
   End
End
Attribute VB_Name = "bacMntPlaOper"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
   Private I&
   Private xLine$
   Private xStr$
   Private Datos()
   Dim OptLocal As String

Private Sub Refresh_PlanillaOperacion()
    If Len(Trim(cmbOperacion.Text)) <= 0 Or CmbCod_Prod.ListCount <= 0 Then
        Exit Sub
    End If
    
    Envia = Array()
    AddParam Envia, Trim(Right(CmbCod_Prod.Text, 5))
    AddParam Envia, IIf(Trim(Right(Me.CmbTipCli.Text, 5)) = Empty, 0, Trim(Right(Me.CmbTipCli.Text, 5)))
    AddParam Envia, IIf(Right(cmbOperacion.Text, 1) = 1, "C", "V")
    AddParam Envia, IIf(Right(Me.CmbMoneda.Text, 3) = Empty, 0, Right(Me.CmbMoneda.Text, 3))
    AddParam Envia, IIf(Me.CmbFisico.Text = "NO", "N", "S")
    AddParam Envia, Right(Me.Cmb_Sistema.Text, 3)
    
   If BAC_SQL_EXECUTE("sp_planilla_operacion", Envia) Then
      txtComercio.Text = ""
      
      txtGlosa.Text = ""
      If BAC_SQL_FETCH(Datos()) Then
         txtComercio.Text = Datos(1)
         txtGlosa.Text = Datos(3)
         bacBuscarCombo cmbOperacion, CDbl(Datos(4))
         bacBuscarCombo cmbCodigoOMA, CDbl(Datos(5))
         Me.TxtCondicion.Text = Datos(2)
      End If
   End If
End Sub

Private Sub Cmb_Sistema_Click()

    Call Cargar_Datos

End Sub


Private Sub CmbCod_Prod_Click()
      If Me.CmbCod_Prod.ListIndex > -1 Then
         Call Refresh_PlanillaOperacion
         Me.Toolbar1.Buttons(2).Enabled = True  ' << Grabar
         Me.Toolbar1.Buttons(3).Enabled = True  ' << eliminar
         
      End If
End Sub


Private Sub CmbCodcLI_Click()
'MsgBox Trim(Right(CmbCodCli.Text, 1))
End Sub

Private Sub cmbCodigoOMA_Change()
   txtComercio.Text = ""
   txtGlosa.Text = ""
End Sub
Private Sub cmbCodigoOMA_Click()
   txtComercio.Text = 0
   txtGlosa.Text = 0
End Sub

Private Sub cmbCodigoOMA_LostFocus()
    If cmbCodigoOMA.ListIndex >= 0 Then
        cmbCodigoOMA.Tag = cmbCodigoOMA.ItemData(cmbCodigoOMA.ListIndex)
      
    Else
        cmbCodigoOMA.Tag = ""
    End If
End Sub

Private Sub cmbOperacion_Click()
    If cmbOperacion.ListIndex >= 0 Then
        cmbOperacion.Tag = cmbOperacion.ItemData(cmbOperacion.ListIndex)
        cmbOperacion.Tag = IIf(cmbOperacion.Tag = "1", "C", "V")
        'Carga_Listas Left(cmbOperacion, 1) & "OPERACIONESxDOCUMENTO", cmbCodigoOMA
        Carga_Listas "OPERACIONESxDOCUMENTO", cmbCodigoOMA
    Else
        cmbOperacion.Tag = ""
        Carga_Listas "OPERACIONESxDOCUMENTO", cmbCodigoOMA
    End If
    cmbCodigoOMA_LostFocus
End Sub

Private Sub cmbOperacion_LostFocus()
    If cmbOperacion.ListIndex >= 0 Then
        cmbOperacion.Tag = cmbOperacion.ItemData(cmbOperacion.ListIndex)
        cmbOperacion.Tag = Mid(cmbOperacion, 1, 1)
    Else
        cmbOperacion.Tag = ""
    End If
    cmbCodigoOMA_LostFocus
End Sub

Private Sub cmdActualizar_Click()
    Call Refresh_PlanillaOperacion
End Sub

Private Sub cmdlimpiar_Click()
   CmbCod_Prod.ListIndex = -1
   cmbCodigoOMA.ListIndex = -1
   CmbFisico.ListIndex = 1
   CmbMoneda.ListIndex = -1
   cmbOperacion.ListIndex = -1
   CmbTipCli.ListIndex = -1
   CmbCodCli.ListIndex = -1 'JSPP 25/11/2004 tipo de Cliente
   Me.txtComercio.Text = 0
   Me.TxtCondicion.Text = ""
   Me.txtGlosa.Text = ""
   Me.CmbCod_Prod.SetFocus
   Me.Toolbar1.Buttons(4).Enabled = True
Exit Sub
   
   Dim Recorre
    '<< Codigos OMA >>
    Carga_Listas Right(cmbOperacion, 1) & "OPERACIONESxDOCUMENTO", cmbCodigoOMA
    
    '<< Codigos de Comercio y Concepto >>
    txtComercio.Text = CDbl(0)
    txtGlosa.Text = ""
    
    Me.CmbCod_Prod.ListIndex = 0
    Me.CmbFisico.ListIndex = 0
    
    For Recorre = 0 To Me.CmbMoneda.ListCount
      If Trim(Mid(Me.CmbMoneda.List(Recorre), 1, 3)) = UCase("usd") Then
         Me.CmbMoneda.ListIndex = Recorre
         Exit For
      End If
    Next Recorre
    
    Me.cmbOperacion.ListIndex = 0
    Me.CmbTipCli.ListIndex = 0
    Me.TxtCondicion = ""
    
End Sub
Private Sub cmdSalir_Click()
    Unload Me
End Sub

Private Sub CmbTipCli_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
   Call Toolbar1_ButtonClick(Toolbar1.Buttons(4))
   'Me.txtComercio.SetFocus
End If
End Sub


Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, ""
   Call cmdlimpiar_Click
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer


If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

opcion = 0
   Select Case KeyCode

         Case vbKeyLimpiar
               opcion = 1

         Case vbKeyGrabar
               opcion = 2
         
         Case vbKeyBuscar
               opcion = 4

         Case vbKeyEliminar
               opcion = 3

         Case vbKeySalir
               opcion = 5
   End Select

   If opcion <> 0 Then
   
      KeyCode = 0
      If Toolbar1.Buttons(opcion).Enabled Then
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
      End If

   End If

End If

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
     Bac_SendKey vbKeyTab
  End If
End Sub

Private Sub Form_Load()
   OptLocal = Opt
   Me.Top = 0
   Me.Left = 0
   WindowState = 0
   Top = 1
   Left = 15
   
Cmb_Sistema.AddItem "CAMBIO" & Space(150) & "BCC"
Cmb_Sistema.AddItem "FORWARD" & Space(150) & "BFW"
Cmb_Sistema.AddItem "SWAP" & Space(150) & "SWP"
Cmb_Sistema.AddItem "RENTA FIJA" & Space(150) & "BTR"
Cmb_Sistema.AddItem "INVERSIÓN EXTERIOR" & Space(150) & "INV"
Cmb_Sistema.ListIndex = 0
   
Call Cargar_Datos
Call Cargar_Datos_2

Me.Icon = BAC_Parametros.Icon
   
Me.Toolbar1.Buttons(1).Enabled = True ' << limpiar
Me.Toolbar1.Buttons(2).Enabled = False ' << Guardar
Me.Toolbar1.Buttons(3).Enabled = False ' << Eliminar
   
   
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
End Sub

Sub Cargar_Datos_2()

   CmbFisico.Clear
   CmbFisico.AddItem "SI"
   CmbFisico.AddItem "NO"
    
   CmbFisico.Clear
   CmbFisico.AddItem "SI"
   CmbFisico.AddItem "NO"
   CmbFisico.Enabled = False
   
   cmbOperacion.Clear
   cmbOperacion.AddItem "Compras" & Space(100) & "1": cmbOperacion.ItemData(cmbOperacion.NewIndex) = 1
   cmbOperacion.AddItem "Ventas" & Space(100) & "2": cmbOperacion.ItemData(cmbOperacion.NewIndex) = 2
   bacBuscarCombo cmbOperacion, 1
   cmbOperacion_LostFocus
   
   'JSPP 25/11/2004 Mantencion de codigos de comercio para planillas automaticas
   CmbCodCli.Clear
   CmbCodCli.AddItem "NACIONAL" & Space(30) & " " & 1
   CmbCodCli.AddItem "EXTRANJERO" & Space(30) & " " & 2
    
End Sub

Sub Consulta(ByVal SW As Double, ByRef xCombo As ComboBox)
Dim Datos()

   Envia = Array()
   AddParam Envia, CDbl(SW)
   AddParam Envia, Right(Cmb_Sistema.Text, 3)
   
   If Not BAC_SQL_EXECUTE("Sp_Trae_Datos_Comercio_Operaciones", Envia) Then
      MsgBox " Problemas en la Carga "
      Exit Sub
   End If
   xCombo.Clear
   Do While BAC_SQL_FETCH(Datos())
      xCombo.AddItem Datos(2) & Space(100) & Datos(1)
   Loop

End Sub

Sub Cargar_Datos()
   Call Consulta(2, Me.CmbCod_Prod)
   Call Consulta(3, Me.CmbTipCli)
   Call Consulta(5, Me.CmbMoneda)
End Sub

Function Validadatos_Graba(Valida As Integer) As Boolean
Dim cFalta$
   cFalta = ""
   Validadatos_Graba = True
   
   If Me.CmbCod_Prod.ListIndex < 0 Then
      cFalta = cFalta & "- Producto"
      Validadatos_Graba = False
   End If
   If Me.CmbFisico.ListIndex < 0 Then
      cFalta = cFalta & "- Vcto. Fisico"
      Validadatos_Graba = False
   End If
   If Me.CmbMoneda.ListIndex < 0 Then
      cFalta = cFalta & "- Moneda"
      Validadatos_Graba = False
   End If
   If Me.cmbOperacion.ListIndex < 0 Then
      cFalta = cFalta & "- Operacion"
      Validadatos_Graba = False
   End If
   If Me.CmbTipCli.ListIndex < 0 Then
      cFalta = cFalta & "- Tipo Cliente"
      Validadatos_Graba = False
   End If
   If Valida = 1 Then
   If Len(Me.txtComercio.Text) <= 0 Or Me.txtComercio.Text = "0" Or Me.txtComercio.Text = " " Then 'JSPP 26/11/2004 Mantencion de codigos de comercio para planillas automaticas
      cFalta = cFalta & "- Codigo Comercio"
      Validadatos_Graba = False
   End If
   End If
   
   If Len(Me.CmbCodCli.Text) <= 0 Then  'JSPP 26/11/2004 Mantencion de codigos de comercio para planillas automaticas
      cFalta = cFalta & "- Nacionalidad"
      Validadatos_Graba = False
   End If
   
   If Validadatos_Graba = False Then
      MsgBox "Falta " & cFalta, vbExclamation
      Exit Function
   End If
End Function

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim varaux2 As String
Dim Ctrl_boton_graba As Integer
Dim Datos()
Ctrl_boton_graba = 0
   Select Case Button.Index
      Case 1
         
         Call Cargar_Datos
         Call Cargar_Datos_2
         Call cmdlimpiar_Click
         Call Refresh_PlanillaOperacion

         Me.Toolbar1.Buttons(2).Enabled = False ' << grabar
         Me.Toolbar1.Buttons(3).Enabled = False  ' << eliminar
         
         Me.CmbCod_Prod.SetFocus
         
      Case 2
         Ctrl_boton_graba = 1
         If Validadatos_Graba(Ctrl_boton_graba) = False Then
            Exit Sub
         End If
         
         Envia = Array()
         AddParam Envia, Trim(Right(Me.CmbCod_Prod, 5))
         AddParam Envia, Right(Me.CmbMoneda, 3)
         AddParam Envia, Left(Me.CmbFisico, 1)
         AddParam Envia, Left(Me.cmbOperacion, 1)
         AddParam Envia, CDbl(Right(Me.CmbTipCli, 3))
         AddParam Envia, Me.txtComercio
         AddParam Envia, Me.TxtCondicion
         AddParam Envia, Trim(Right(Me.CmbCodCli.Text, 1)) 'JSPP 26/11/2004 Mantencion de codigos de comercio para planillas automaticas
         AddParam Envia, Right(Me.Cmb_Sistema.Text, 3)
         
         If Not BAC_SQL_EXECUTE("sp_Graba_PlanillaOperacion ", Envia) Then
            MsgBox "Error En Grabacion", vbCritical
            Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Codigo Producto: " & txtComercio.Text & " Moneda: " & CmbMoneda.Text & " Vencimiento: " & CmbFisico.Text & " Tipo Operación: " & cmbOperacion.Text & " Tipo Cliente: " & CmbTipCli.Text & " Cod. Comercio: " & txtComercio.Text, "", "")
            Exit Sub
         End If

         If BAC_SQL_FETCH(Datos()) Then
            If Datos(1) < 0 Then
               MsgBox Datos(2), vbExclamation
            Else
               MsgBox Datos(2), vbInformation
            End If
         End If

         
         Me.Toolbar1.Buttons(2).Enabled = False ' << Grabar
         Me.Toolbar1.Buttons(3).Enabled = False  ' << Eliminar
         

         Call LogAuditoria("01", OptLocal, Me.Caption, "", "Codigo Producto: " & txtComercio.Text & " Moneda: " & CmbMoneda.Text & " Vencimiento: " & CmbFisico.Text & " Tipo Operación: " & cmbOperacion.Text & " Tipo Cliente: " & CmbTipCli.Text & " Cod. Comercio: " & txtComercio.Text)
         Call cmdlimpiar_Click
         
      Case 3
          If Validadatos_Graba(Ctrl_boton_graba) = False Then
            Exit Sub
         End If
         
         Envia = Array()
         AddParam Envia, Trim(Right(Me.CmbCod_Prod, 5))
         AddParam Envia, Right(Me.CmbMoneda, 3)
         AddParam Envia, Left(Me.CmbFisico, 1)
         AddParam Envia, Left(Me.cmbOperacion, 1)
         AddParam Envia, CDbl(Right(Me.CmbTipCli, 3))
         AddParam Envia, Me.txtComercio
         AddParam Envia, Me.TxtCondicion
         AddParam Envia, Trim(Right(Me.CmbCodCli.Text, 1)) 'JSPP 26/11/2004 Mantencion de codigos de comercio para planillas automaticas
         AddParam Envia, Right(Me.Cmb_Sistema.Text, 3)
         
         If Not BAC_SQL_EXECUTE("Sp_Elimina_PlanillaOperacion", Envia) Then
            MsgBox "Error al Eliminar", vbCritical
            Call LogAuditoria("03", OptLocal, Me.Caption & " Error al Eliminar- Codigo Producto: " & txtComercio.Text & " Moneda: " & CmbMoneda.Text & " Vencimiento: " & CmbFisico.Text & " Tipo Operación: " & cmbOperacion.Text & " Tipo Cliente: " & CmbTipCli.Text & " Cod. Comercio: " & txtComercio.Text, "", "")
            Exit Sub
         End If

         If BAC_SQL_FETCH(Datos()) Then
            If Datos(1) < 0 Then
               MsgBox Datos(2), vbExclamation
            Else
               MsgBox Datos(2), vbInformation
            End If
         End If
         
         Me.Toolbar1.Buttons(2).Enabled = False ' << Grabar
         Me.Toolbar1.Buttons(3).Enabled = False  ' << Eliminar
         

         Call LogAuditoria("03", OptLocal, Me.Caption, "", "Codigo Producto: " & txtComercio.Text & " Moneda: " & CmbMoneda.Text & " Vencimiento: " & CmbFisico.Text & " Tipo Operación: " & cmbOperacion.Text & " Tipo Cliente: " & CmbTipCli.Text & " Cod. Comercio: " & txtComercio.Text)
         Call cmdlimpiar_Click

      Case 4
         If Validadatos_Graba(Ctrl_boton_graba) = False Then
            Exit Sub
         End If
         
         Envia = Array()
         AddParam Envia, Trim(Right(Me.CmbCod_Prod, 5))
         AddParam Envia, Right(Me.CmbMoneda, 3)
         AddParam Envia, Left(Me.CmbFisico, 1)
         AddParam Envia, Left(Me.cmbOperacion, 1)
         AddParam Envia, CDbl(Right(Me.CmbTipCli, 3))
         AddParam Envia, Me.txtComercio
         AddParam Envia, Me.TxtCondicion
         AddParam Envia, Trim(Right(Me.CmbCodCli.Text, 1)) 'JSPP 26/11/2004 Mantencion de codigos de comercio para planillas automaticas
         AddParam Envia, Right(Me.Cmb_Sistema.Text, 3)
         
         If Not BAC_SQL_EXECUTE("Sp_Buscar_PlanillaOperacion", Envia) Then
            MsgBox "Error al Buscar", vbCritical
            Exit Sub
         End If
         Me.Toolbar1.Buttons(4).Enabled = False
         If BAC_SQL_FETCH(Datos()) Then
            Me.txtComercio.Text = Datos(1)
            Me.TxtCondicion.Text = Datos(2)
            Call txtComercio_KeyPress(13)
         Else
            Me.txtComercio.SetFocus
         End If
      
   
      Case 5
         
         Unload Me
         
   End Select
End Sub

Private Sub txtComercio_DblClick()
   If cmbOperacion.ListIndex = -1 Then Exit Sub
   
    BacControlWindows 100
    MiTag = "tbCodigosComercio" & cmbOperacion.ItemData(cmbOperacion.ListIndex) & "" 'cmbCodigoOMA.Tag
    BacAyuda.Show 1
    If giAceptar = True Then
        txtComercio.Text = gsCodigo
        txtGlosa.Text = gsGlosa
    End If
    
End Sub

Private Sub txtComercio_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF3 Then txtComercio_DblClick
End Sub


Private Sub txtComercio_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
    Envia = Array()
      AddParam Envia, txtComercio.Text
   If txtComercio.Text <> "" Then

      If Not BAC_SQL_EXECUTE("sp_leer_codigos_comercio", Envia) Then
          MsgBox "Error al Buscar Código de Comercio", vbInformation
          Exit Sub
      End If

      If BAC_SQL_FETCH(Datos()) Then
            txtGlosa = Datos(2)
      Else
            MsgBox "Código de Comercio NO EXISTE", vbInformation
            Me.txtComercio.Text = ""
            Me.txtGlosa.Text = ""
      End If
   End If
    ElseIf KeyAscii = 8 Then

    ElseIf InStr("0123456789Kk", Chr(KeyAscii)) > 0 Then
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
    Else
        KeyAscii = 0
    End If
End Sub

Private Sub TxtCondicion_KeyPress(KeyAscii As Integer)
KeyAscii = Caracter(KeyAscii)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


