VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{297EB2E9-9343-11D5-B8DF-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form frmCerVp 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Certificado Venta Definitiva"
   ClientHeight    =   1290
   ClientLeft      =   2385
   ClientTop       =   2580
   ClientWidth     =   3660
   Icon            =   "frmCerVp.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1290
   ScaleWidth      =   3660
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   450
      Left            =   0
      TabIndex        =   4
      Top             =   30
      Width           =   3660
      _ExtentX        =   6456
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbimprimir"
            Description     =   "IMPRIMIR"
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbsalir"
            Description     =   "SALIR"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2835
      Top             =   1470
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCerVp.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCerVp.frx":0624
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin BACControles.TXTNumero txtNumOpe 
      Height          =   375
      Left            =   2400
      TabIndex        =   3
      Top             =   600
      Width           =   975
      _ExtentX        =   1720
      _ExtentY        =   661
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
   End
   Begin Threed.SSCommand Cmd_Cancelar 
      Height          =   480
      Left            =   1275
      TabIndex        =   2
      Top             =   1560
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   847
      _StockProps     =   78
      Caption         =   "&Salir"
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
      Font3D          =   3
   End
   Begin Threed.SSCommand Cmd_Aceptar 
      Height          =   480
      Left            =   45
      TabIndex        =   1
      Top             =   1560
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   847
      _StockProps     =   78
      Caption         =   "&Imprimir"
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
      Font3D          =   3
   End
   Begin VB.Label Label1 
      Caption         =   "Número de Operación"
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
      Height          =   225
      Left            =   90
      TabIndex        =   0
      Top             =   660
      Width           =   2055
   End
End
Attribute VB_Name = "frmCerVp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Private Sub Cmd_Aceptar_Click()
'    giAceptar% = True
'    xCodigo = txtNumOpe.Text
'    Unload Me
End Sub

Private Sub Cmd_cancelar_Click()
'    Unload frmCerVp
End Sub

Private Sub Form_Load()
giAceptar% = False
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Description)
    Case "IMPRIMIR"
        Call TBARIMPRIMIR
    Case "SALIR"
        Call TBARSALIR
End Select
End Sub
Private Sub TBARIMPRIMIR()
    giAceptar% = True
    xCodigo = txtNumOpe.Text
    Unload Me
End Sub
Private Sub TBARSALIR()
    Unload frmCerVp
End Sub

