VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form FRM_FILTRO_CONSULTA 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Filtro Consulta"
   ClientHeight    =   3210
   ClientLeft      =   1380
   ClientTop       =   1590
   ClientWidth     =   8475
   Icon            =   "FRM_FILTRO_CONSULTA.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3210
   ScaleWidth      =   8475
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   19
      Top             =   0
      Width           =   8475
      _ExtentX        =   14949
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Aceptar"
            Description     =   "Aceptar"
            Object.ToolTipText     =   "Aceptar Datos"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Cancelar"
            Description     =   "Cancelar"
            Object.ToolTipText     =   "Cancelar "
            ImageIndex      =   10
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   5880
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   25
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":4C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":5064
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":551E
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":59F1
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":5E35
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":639C
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":686B
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":6C8A
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":7182
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":757B
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":79FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":7EC4
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":83BB
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":8871
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":8C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":902C
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":9423
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":982C
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_FILTRO_CONSULTA.frx":9CEA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   2730
      Index           =   0
      Left            =   0
      TabIndex        =   15
      Top             =   465
      Width           =   6000
      _Version        =   65536
      _ExtentX        =   10583
      _ExtentY        =   4815
      _StockProps     =   14
      Caption         =   "Filtros"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin Threed.SSFrame SSFrame1 
         Height          =   690
         Left            =   60
         TabIndex        =   16
         Top             =   255
         Width           =   5850
         _Version        =   65536
         _ExtentX        =   10319
         _ExtentY        =   1217
         _StockProps     =   14
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
         Font3D          =   4
         Begin VB.TextBox Txt_Instrumento 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   1710
            MaxLength       =   8
            TabIndex        =   0
            Top             =   210
            Width           =   3435
         End
         Begin VB.Label Label1 
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
            ForeColor       =   &H00800000&
            Height          =   270
            Left            =   135
            TabIndex        =   17
            Top             =   255
            Width           =   1215
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   1770
         Left            =   60
         TabIndex        =   18
         Top             =   900
         Width           =   5850
         _Version        =   65536
         _ExtentX        =   10319
         _ExtentY        =   3122
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin BACControles.TXTFecha txtFecProceso 
            Height          =   330
            Left            =   1710
            TabIndex        =   6
            Top             =   930
            Width           =   1290
            _ExtentX        =   2275
            _ExtentY        =   582
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   402133
            MinDate         =   18264
            Text            =   "25/10/2000"
         End
         Begin VB.ComboBox cmb_Moneda 
            Enabled         =   0   'False
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
            Left            =   1710
            Style           =   2  'Dropdown List
            TabIndex        =   4
            Top             =   555
            Width           =   3950
         End
         Begin VB.TextBox txtCliente 
            Enabled         =   0   'False
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
            Left            =   1710
            Locked          =   -1  'True
            MousePointer    =   99  'Custom
            MultiLine       =   -1  'True
            TabIndex        =   2
            Top             =   195
            Width           =   3930
         End
         Begin Threed.SSCheck chkCliente 
            Height          =   315
            Left            =   120
            TabIndex        =   1
            Top             =   195
            Width           =   1440
            _Version        =   65536
            _ExtentX        =   2540
            _ExtentY        =   556
            _StockProps     =   78
            Caption         =   "Cliente"
            ForeColor       =   8421376
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Font3D          =   3
         End
         Begin Threed.SSCheck chkFecProceso 
            Height          =   315
            Left            =   120
            TabIndex        =   5
            Top             =   945
            Width           =   1440
            _Version        =   65536
            _ExtentX        =   2540
            _ExtentY        =   556
            _StockProps     =   78
            Caption         =   "Fec. Proceso"
            ForeColor       =   8421376
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Font3D          =   3
         End
         Begin Threed.SSCheck chkMoneda 
            Height          =   315
            Left            =   120
            TabIndex        =   3
            Top             =   555
            Width           =   1440
            _Version        =   65536
            _ExtentX        =   2540
            _ExtentY        =   556
            _StockProps     =   78
            Caption         =   "Moneda"
            ForeColor       =   8421376
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Font3D          =   3
         End
         Begin BACControles.TXTFecha txtFecVcto 
            Height          =   330
            Left            =   1710
            TabIndex        =   8
            Top             =   1305
            Width           =   1290
            _ExtentX        =   2275
            _ExtentY        =   582
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   402133
            MinDate         =   18264
            Text            =   "25/10/2000"
         End
         Begin Threed.SSCheck chkFecvcto 
            Height          =   315
            Left            =   120
            TabIndex        =   7
            Top             =   1320
            Width           =   1440
            _Version        =   65536
            _ExtentX        =   2540
            _ExtentY        =   556
            _StockProps     =   78
            Caption         =   "Fec. Vcto"
            ForeColor       =   8421376
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Font3D          =   3
         End
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1815
      Index           =   1
      Left            =   6030
      TabIndex        =   20
      Top             =   480
      Width           =   2445
      _Version        =   65536
      _ExtentX        =   4313
      _ExtentY        =   3201
      _StockProps     =   14
      Caption         =   "Ordenado Por"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin Threed.SSOption optOrdenado 
         Height          =   315
         Index           =   2
         Left            =   105
         TabIndex        =   11
         Top             =   840
         Width           =   2205
         _Version        =   65536
         _ExtentX        =   3881
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Fecha Operación"
         ForeColor       =   8421376
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
      End
      Begin Threed.SSOption optOrdenado 
         Height          =   315
         Index           =   1
         Left            =   105
         TabIndex        =   10
         Top             =   555
         Width           =   2205
         _Version        =   65536
         _ExtentX        =   3881
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Moneda"
         ForeColor       =   8421376
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
      End
      Begin Threed.SSOption optOrdenado 
         Height          =   315
         Index           =   0
         Left            =   105
         TabIndex        =   9
         Top             =   255
         Width           =   2205
         _Version        =   65536
         _ExtentX        =   3881
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Cliente"
         ForeColor       =   128
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Value           =   -1  'True
         Font3D          =   3
      End
      Begin Threed.SSOption optOrdenado 
         Height          =   315
         Index           =   3
         Left            =   105
         TabIndex        =   12
         Top             =   1140
         Width           =   2205
         _Version        =   65536
         _ExtentX        =   3881
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Instrumento"
         ForeColor       =   8421376
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
      End
      Begin Threed.SSOption optOrdenado 
         Height          =   315
         Index           =   4
         Left            =   105
         TabIndex        =   22
         Top             =   1470
         Width           =   2205
         _Version        =   65536
         _ExtentX        =   3881
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Nº Operación"
         ForeColor       =   8421376
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   870
      Index           =   2
      Left            =   6030
      TabIndex        =   21
      Top             =   2325
      Width           =   2445
      _Version        =   65536
      _ExtentX        =   4313
      _ExtentY        =   1535
      _StockProps     =   14
      Caption         =   "Consulta de"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin Threed.SSOption optConsulta 
         Height          =   300
         Index           =   2
         Left            =   105
         TabIndex        =   14
         Top             =   495
         Width           =   2205
         _Version        =   65536
         _ExtentX        =   3881
         _ExtentY        =   529
         _StockProps     =   78
         Caption         =   "Operaciones Vigentes"
         ForeColor       =   8421376
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
      End
      Begin Threed.SSOption optConsulta 
         Height          =   225
         Index           =   0
         Left            =   105
         TabIndex        =   13
         Top             =   255
         Width           =   2205
         _Version        =   65536
         _ExtentX        =   3881
         _ExtentY        =   397
         _StockProps     =   78
         Caption         =   "Operaciones del Día"
         ForeColor       =   128
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Value           =   -1  'True
         Font3D          =   3
      End
   End
End
Attribute VB_Name = "FRM_FILTRO_CONSULTA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Dim cHay_Datos          As String
Dim nCodigo_Instrumento As Double
Dim cGlosa_Instrumento  As String
Dim cDig_Cliente        As String
Dim nCodigo_Cliente     As Double
Dim nRut_Cliente        As Double
Dim nTipo_Orden         As Integer
Dim nTipo_Filtro        As Integer
Dim cTitulo_Orden       As String
Dim cFecha_Proceso      As String
Dim cFecha_Vcto         As String
Dim nMoneda             As Integer

Dim objCodTabla            As Object
Dim objProducto            As Object
Dim ObjEntidades           As Object
Dim VengodeAyuda           As Boolean

Private Sub chkCliente_Click(Value As Integer)

   If Value Then

      chkCliente.ForeColor = &H80&
      txtCliente.Enabled = True

   Else

      chkCliente.ForeColor = &H808000
      txtCliente.Text = ""
      txtCliente.Tag = ""
      txtCliente.Enabled = False

   End If

End Sub


Private Sub chkFecProceso_Click(Value As Integer)

   If Value Then

      chkFecProceso.ForeColor = &H80&
      txtFecProceso.Enabled = True

      If txtFecProceso.Text = "" Then

         txtFecProceso.Text = GLB_Fecha_Proceso

      End If

   Else

      chkFecProceso.ForeColor = &H808000
      txtFecProceso.Enabled = False

   End If

End Sub

Private Sub chkFecVcto_Click(Value As Integer)

   If Value Then
      chkFecvcto.ForeColor = &H80&
      txtFecVcto.Enabled = True

      If txtFecVcto.Text >= GLB_Fecha_Proceso Then
         txtFecVcto.Text = GLB_Fecha_Proceso

      End If

   Else
      chkFecvcto.ForeColor = &H808000
      txtFecVcto.Text = GLB_Fecha_Proceso
      txtFecVcto.Enabled = False

   End If

End Sub

Private Sub chkMoneda_Click(Value As Integer)

   If Value Then
   
      chkMoneda.ForeColor = &H80&
      CMB_Moneda.Enabled = True

   Else
      chkMoneda.ForeColor = &H808000
      CMB_Moneda.Enabled = False
      CMB_Moneda.ListIndex = 0

   End If


End Sub

Private Sub PROC_ACEPTAR()

   Dim cCadena_Ejecutable As String
   Dim nMoneda As Integer
   If CMB_Moneda.ListIndex = -1 Then
     nMoneda = 0
   Else
     nMoneda = CMB_Moneda.ItemData(CMB_Moneda.ListIndex)
   End If
         

     If optOrdenado(0).Value Then
      
         nTipo_Orden = 0
         cTitulo_Orden = "  |  (Ordenado por Cliente)"

      ElseIf optOrdenado(1).Value Then
      
         nTipo_Orden = 1
         cTitulo_Orden = "  |  (Ordenado por Moneda)"

      ElseIf optOrdenado(2).Value Then
      
         nTipo_Orden = 2
         cTitulo_Orden = "  |  (Ordenado por Fec. Operación)"

      ElseIf optOrdenado(3).Value Then
      
         nTipo_Orden = 3
         cTitulo_Orden = "  |  (Ordenado por Instrumento)"
      
      ElseIf optOrdenado(4).Value Then
      
         nTipo_Orden = 4
         cTitulo_Orden = "  |  (Ordenado por Numero Operación)"

      End If

      If Trim(TXT_Instrumento.Text) = "" Then
      
         nCodigo_Instrumento = 0
         
      End If
      
      If Trim(txtCliente.Text) = "" Then
      
         nRut_Cliente = 0
         nCodigo_Cliente = 0
         
      End If

      If chkFecProceso.Value Then
      
         cFecha_Proceso = Format(txtFecProceso.Text, "yyyymmdd")
         
      Else
      
         cFecha_Proceso = "''"
         
      End If
      
      If chkFecvcto.Value Then
      
         cFecha_Vcto = Format(txtFecProceso.Text, "yyyymmdd")
      
      Else
         
         cFecha_Vcto = "''"
      
      End If
      
      If Me.chkMoneda.Value Then
         nMoneda = CMB_Moneda.ItemData(CMB_Moneda.ListIndex)
      Else
         nMoneda = 0
      End If
      
      If optConsulta(0).Value Then        'Operaciones del día

         cCadena_Ejecutable = "SP_CON_OPERACIONES_DIA " & 0 & "," & nTipo_Orden & "," & nCodigo_Instrumento & "," & nRut_Cliente & "," & nCodigo_Cliente & "," & nMoneda & "," & cFecha_Proceso & "," & cFecha_Vcto
         

         GLB_Titulo_Consulta = "CONSULTA (OPERACIONES DEL DIA" + cTitulo_Orden + ")"

      ElseIf optConsulta(2).Value Then    'Operaciones Vigentes

         cCadena_Ejecutable = "SP_CON_OPERACIONES_DIA " & 1 & "," & nTipo_Orden & "," & nCodigo_Instrumento & "," & nRut_Cliente & "," & nCodigo_Cliente & "," & nMoneda & "," & cFecha_Proceso & "," & cFecha_Vcto


         GLB_Titulo_Consulta = "CONSULTA (OPERACIONES VIGENTES" + cTitulo_Orden + ")"

      End If
   
   FRM_CONSULTA_OPERACIONES.txt_Cadena_Ejecutable = cCadena_Ejecutable

   Unload Me

End Sub

Private Sub Form_Activate()

   PROC_CARGA_AYUDA Me

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim Opcion As Integer

   Opcion = 0

   If KeyCode = vbKeyReturn Then
      KeyCode = 0
      FUNC_ENVIA_TECLA vbKeyTab
      Exit Sub
   End If

    If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

      Select Case KeyCode

         Case VbkeyAceptar:
                           Opcion = 1

         Case vbKeySalir:
                           Opcion = 2


      End Select

      If Opcion <> 0 Then
         If Toolbar1.Buttons(Opcion).Enabled Then
            Call Toolbar1_ButtonClick(Toolbar1.Buttons(Opcion))
         End If

      End If

   End If

End Sub

Private Sub Form_Load()
   
   If FUNC_LLENA_MONEDA(CMB_Moneda, "", -1) Then
       CMB_Moneda.ListIndex = 0
   End If
   PROC_CENTRAR_PANTALLA Me
   Call PROC_LOG_AUDITORIA("07", "E", Me.Caption, "", "")

End Sub

Private Sub Form_Unload(Cancel As Integer)
   
   Call PROC_LOG_AUDITORIA("08", "E", Me.Caption, "", "")

End Sub

Private Sub optConsulta_Click(Index As Integer, Value As Integer)

   optConsulta(0).ForeColor = &H808000
   optConsulta(2).ForeColor = &H808000
   optConsulta(Index).ForeColor = &H80&

   If Index = 0 Then
   
      chkFecProceso.Enabled = False

   ElseIf Index = 1 Or Index = 3 Then
   
      chkFecProceso.Enabled = (Index <> 3)

   Else
   
      chkFecProceso.Enabled = True

   End If

   If Not chkFecProceso.Enabled Then
   
      chkFecProceso.Value = False

   End If

End Sub

Private Sub optOrdenado_Click(Index As Integer, Value As Integer)

   optOrdenado(0).ForeColor = &H808000
   optOrdenado(1).ForeColor = &H808000
   optOrdenado(2).ForeColor = &H808000
   optOrdenado(3).ForeColor = &H808000
   optOrdenado(4).ForeColor = &H808000
   optOrdenado(Index).ForeColor = &H80&

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   
   Select Case Button.Index
      
      Case 1          '"Aceptar"
         
         Call PROC_ACEPTAR
      
      Case 2          '"Cancelar"
         
         Unload Me
   
   End Select
   
   GLB_Oopcion_Tlb = Button.Index
   
End Sub

Private Sub Txt_Instrumento_DblClick()

   Call PROC_CON_INSTRUMENTO
   
End Sub

Private Sub Txt_Instrumento_KeyDown(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyF3 Then Call PROC_CON_INSTRUMENTO

End Sub

Private Sub txtCliente_DblClick()

   Call PROC_CON_CLIENTE

End Sub

Private Sub txtCliente_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyF3 Then Call PROC_CON_CLIENTE

End Sub

Sub PROC_CON_INSTRUMENTO()

On Error GoTo Error_Con_Familia

   cHay_Datos = "N"
   Pbl_cTipo_Instrumento = ""
   cMiTag = "MDIN"
   FRM_AYUDA.Show 1

   If GLB_Aceptar = True Then

      TXT_Instrumento.Enabled = True
      TXT_Instrumento.Text = GLB_nombre
      nCodigo_Instrumento = GLB_codigo
      cGlosa_Instrumento = GLB_nombre
      TXT_Instrumento.SetFocus
      FUNC_ENVIA_TECLA vbKeyReturn
      cHay_Datos = "S"

   End If

   Exit Sub

Error_Con_Familia:
    
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
    
    Exit Sub

End Sub

Sub PROC_CON_CLIENTE()
On Error GoTo Error_Cliente
    'Ayuda para Emisores
    '----------------------------------
    cMiTag = "CLIENTE"
    FRM_AYUDA.Show 1
    If GLB_Aceptar = True Then
    
        nRut_Cliente = GLB_rut$
        cDig_Cliente = GLB_Digito$
        txtCliente.Text = GLB_Descripcion$
        nCodigo_Cliente = GLB_codigo$
        
    End If
    Exit Sub
    
Error_Cliente:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
    Exit Sub
    
End Sub

