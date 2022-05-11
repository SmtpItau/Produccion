VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form BacMntMn 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Monedas"
   ClientHeight    =   4755
   ClientLeft      =   2655
   ClientTop       =   2145
   ClientWidth     =   6825
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmntmn.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4755
   ScaleWidth      =   6825
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   17
      Top             =   0
      Width           =   6825
      _ExtentX        =   12039
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   5910
         Top             =   30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   12
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntmn.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntmn.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntmn.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntmn.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntmn.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntmn.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntmn.frx":4BB8
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntmn.frx":507E
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntmn.frx":5575
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntmn.frx":596E
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntmn.frx":5D64
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntmn.frx":62A1
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.ComboBox cmbBase 
      BackColor       =   &H00FFFFFF&
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   5760
      Style           =   2  'Dropdown List
      TabIndex        =   18
      TabStop         =   0   'False
      Top             =   4920
      Visible         =   0   'False
      Width           =   1500
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   555
      Left            =   0
      TabIndex        =   19
      Top             =   540
      Width           =   6810
      _Version        =   65536
      _ExtentX        =   12012
      _ExtentY        =   979
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
      Begin VB.TextBox txtGlosaMoneda 
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
         Height          =   300
         Left            =   2100
         MaxLength       =   30
         TabIndex        =   1
         Top             =   165
         Width           =   4575
      End
      Begin VB.TextBox txtCodigo 
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
         Left            =   1515
         MaxLength       =   3
         MouseIcon       =   "Bacmntmn.frx":6762
         MousePointer    =   99  'Custom
         TabIndex        =   0
         Top             =   165
         Width           =   555
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Código Moneda "
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
         TabIndex        =   20
         Top             =   195
         Width           =   1335
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   2550
      Left            =   0
      TabIndex        =   21
      Top             =   1020
      Width           =   6810
      _Version        =   65536
      _ExtentX        =   12012
      _ExtentY        =   4498
      _StockProps     =   14
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ComboBox TXTBASE 
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
         ItemData        =   "Bacmntmn.frx":6A6C
         Left            =   5220
         List            =   "Bacmntmn.frx":6A79
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   465
         Width           =   1515
      End
      Begin VB.ComboBox CmbTipoMoneda 
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
         Left            =   5220
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   795
         Width           =   1515
      End
      Begin VB.ComboBox cmbPeriodo 
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
         Left            =   2220
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   810
         Width           =   1335
      End
      Begin VB.TextBox txtSimbolo 
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
         Left            =   2220
         MaxLength       =   5
         TabIndex        =   4
         Top             =   480
         Width           =   1335
      End
      Begin VB.TextBox txtNemo 
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
         Left            =   2220
         MaxLength       =   5
         TabIndex        =   2
         Top             =   150
         Width           =   1335
      End
      Begin VB.TextBox txtCODIGOFOX 
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
         Left            =   5220
         MaxLength       =   6
         TabIndex        =   11
         Top             =   1455
         Width           =   1515
      End
      Begin VB.ComboBox CmbPais 
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
         Left            =   2220
         Style           =   2  'Dropdown List
         TabIndex        =   12
         Top             =   1800
         Width           =   4515
      End
      Begin VB.ComboBox cmbCanasta 
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
         Left            =   2220
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   1470
         Width           =   1335
      End
      Begin BACControles.TXTNumero intPaisBCCH 
         Height          =   300
         Left            =   5205
         TabIndex        =   22
         TabStop         =   0   'False
         Top             =   1815
         Visible         =   0   'False
         Width           =   1515
         _ExtentX        =   2672
         _ExtentY        =   529
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
         Max             =   "999"
      End
      Begin BACControles.TXTNumero intCodBCCH 
         Height          =   315
         Left            =   5220
         TabIndex        =   9
         Top             =   1140
         Width           =   1515
         _ExtentX        =   2672
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
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Max             =   "99999"
      End
      Begin BACControles.TXTNumero itbRedondeo 
         Height          =   315
         Left            =   5205
         TabIndex        =   3
         Top             =   120
         Width           =   1515
         _ExtentX        =   2672
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
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Max             =   "9"
      End
      Begin BACControles.TXTNumero intCsBancos 
         Height          =   315
         Left            =   2220
         TabIndex        =   8
         Top             =   1140
         Width           =   1335
         _ExtentX        =   2355
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
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Max             =   "999"
      End
      Begin BACControles.TXTNumero txtCODIGOFOX1 
         Height          =   315
         Left            =   870
         TabIndex        =   23
         TabStop         =   0   'False
         Top             =   2850
         Visible         =   0   'False
         Width           =   1515
         _ExtentX        =   2672
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
         Text            =   "0"
         Text            =   "0"
         Max             =   "999"
      End
      Begin BACControles.TXTNumero IntCodDivEsp 
         Height          =   315
         Left            =   2220
         TabIndex        =   40
         Top             =   2160
         Width           =   1335
         _ExtentX        =   2355
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
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Max             =   "99"
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Codigo Divisa ESPAÑA"
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
         Index           =   13
         Left            =   75
         TabIndex        =   39
         Top             =   2205
         Width           =   1800
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Código  SUPER"
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
         Left            =   90
         TabIndex        =   34
         Top             =   1200
         Width           =   1185
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Tipo Moneda "
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
         Left            =   3735
         TabIndex        =   33
         Top             =   840
         Width           =   1110
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Periodo"
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
         Left            =   90
         TabIndex        =   32
         Top             =   855
         Width           =   645
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Base"
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
         Left            =   3735
         TabIndex        =   31
         Top             =   540
         Width           =   405
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Redondeo"
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
         Left            =   3735
         TabIndex        =   30
         Top             =   165
         Width           =   840
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "ISO CODES"
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
         Left            =   90
         TabIndex        =   29
         Top             =   555
         Width           =   855
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Nemotécnico  "
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
         Left            =   90
         TabIndex        =   28
         Top             =   195
         Width           =   1170
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Código  BCCH"
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
         Left            =   3735
         TabIndex        =   27
         Top             =   1200
         Width           =   1125
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Codigo Pais Mon. BCCH "
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
         Index           =   9
         Left            =   75
         TabIndex        =   26
         Top             =   1860
         Width           =   1965
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Código Contable"
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
         Index           =   10
         Left            =   3735
         TabIndex        =   25
         Top             =   1545
         Width           =   1365
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Código  Canasta"
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
         Index           =   11
         Left            =   90
         TabIndex        =   24
         Top             =   1515
         Width           =   1335
      End
   End
   Begin Threed.SSFrame SSFrame3 
      Height          =   1110
      Left            =   0
      TabIndex        =   35
      Top             =   3525
      Width           =   6810
      _Version        =   65536
      _ExtentX        =   12012
      _ExtentY        =   1958
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
      Begin VB.ComboBox Cmb_ocurrencia 
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
         Left            =   1065
         Style           =   2  'Dropdown List
         TabIndex        =   37
         Top             =   705
         Width           =   2145
      End
      Begin VB.CheckBox Check5 
         Alignment       =   1  'Right Justify
         Caption         =   "Inicio Día"
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
         Left            =   120
         TabIndex        =   36
         Top             =   420
         Width           =   2190
      End
      Begin VB.CheckBox Check1 
         Alignment       =   1  'Right Justify
         Caption         =   "Moneda Extranjera"
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
         Height          =   195
         Left            =   3405
         TabIndex        =   14
         Top             =   165
         Width           =   2160
      End
      Begin VB.CheckBox Check2 
         Alignment       =   1  'Right Justify
         Caption         =   "Referencial Mercado "
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
         Height          =   195
         Left            =   3390
         TabIndex        =   15
         Top             =   390
         Width           =   2175
      End
      Begin VB.CheckBox Check3 
         Alignment       =   1  'Right Justify
         Caption         =   "Fuerte"
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
         Height          =   270
         Left            =   120
         TabIndex        =   13
         Top             =   135
         Width           =   2190
      End
      Begin VB.CheckBox Check4 
         Alignment       =   1  'Right Justify
         Caption         =   "Moneda Local"
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
         Height          =   195
         Left            =   3390
         TabIndex        =   16
         Top             =   615
         Width           =   2175
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Ocurrencia"
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
         Index           =   12
         Left            =   135
         TabIndex        =   38
         Top             =   735
         Width           =   900
      End
   End
End
Attribute VB_Name = "BacMntMn"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim OptLocal         As String
Dim Categoria        As Integer
Dim codigo           As String
Dim CodigoFox        As String
Dim CodigoCor        As Double
Dim ValorFox         As Integer
Dim Tasa             As Double
Dim SW               As Integer
Dim i                As Integer
Dim lCodigo          As Long
Dim Sql              As String
Dim Datos()

Private Sub PROC_Habilitacontroles(Valor As Integer)

   On Error GoTo Errores

   txtCodigo.Enabled = Not Valor
   txtNemo.Enabled = Valor
   txtSimbolo.Enabled = Valor
   txtGlosaMoneda.Enabled = Valor
   itbRedondeo.Enabled = Valor
   cmbBase.Enabled = Valor
   TXTBASE.Enabled = Valor
   CmbTipoMoneda.Enabled = Valor
   CmbPeriodo.Enabled = Valor
   intCsBancos.Enabled = Valor
   intCodBCCH.Enabled = Valor
   intPaisBCCH.Enabled = Valor
   txtCODIGOFOX.Enabled = Valor
   Toolbar1.Buttons(2).Enabled = Valor
   Toolbar1.Buttons(4).Enabled = Not Valor
   cmbPais.Enabled = Valor
   CmbCanasta.Enabled = Valor
   Cmb_ocurrencia.Enabled = Valor
   SSFrame3.Enabled = Valor
   SSFrame1.Enabled = Valor
   IntCodDivEsp.Enabled = Valor '05/11/2004 Jspp Campo para interfaz a España
   On Error GoTo 0

   Exit Sub

Errores:
   On Error GoTo 0

End Sub

Private Function FUNC_ValidaDatos() As Integer

   On Error GoTo Errores

   Dim sCadena          As String

   FUNC_ValidaDatos = False

   sCadena = ""

   If txtCodigo.Text = "" Then
      sCadena = sCadena & "- Codigo de Moneda está vacío" & vbCrLf
   End If

   If Trim$(txtGlosaMoneda.Text) = "" Then
      sCadena = sCadena & "- Descripción de la Moneda está vacía" & vbCrLf
    
   End If

   If Trim$(txtNemo.Text) = "" Then
      sCadena = sCadena & "- Nemotécnico está vacío" & vbCrLf

   End If

   If Trim$(txtSimbolo.Text) = "" And right(CmbTipoMoneda, 2) <> 4 Then
      sCadena = sCadena & "- Símbolo de la Moneda está vacía" & vbCrLf

   End If

   If Trim$(TXTBASE.Text) = "" And right(CmbTipoMoneda, 2) <> 4 Then
      sCadena = sCadena & "- Base de la Moneda está vacía" & vbCrLf

   End If


   If Trim$(txtCODIGOFOX.Text) = "" And right(CmbTipoMoneda, 2) <> 4 Then
      sCadena = sCadena & "- Código Contable está vacío" & vbCrLf

   End If

   If Trim$(cmbPais.Text) = "" And right(CmbTipoMoneda, 2) <> 4 Then
      sCadena = sCadena & "- Código Pais Moneda BCCH está vacío" & vbCrLf

   End If

   If sCadena <> "" Then
      sCadena = "FALTA INGRESAR LOS SIGUIENTES DAT0S" & vbCrLf & vbCrLf & sCadena
      MsgBox sCadena, vbExclamation, Me.Caption
   Else
      FUNC_ValidaDatos = True
   End If
 


   On Error GoTo 0

   Exit Function

Errores:
   On Error GoTo 0

End Function

Private Sub PROC_LIMPIAR()

   txtCodigo.Text = ""
   txtGlosaMoneda.Text = ""
   txtNemo.Text = ""
   txtSimbolo.Text = ""
   CmbPeriodo.ListIndex = -1
   intCsBancos.Text = ""
   intCodBCCH.Text = ""
   itbRedondeo.Text = ""
   intPaisBCCH.Text = ""
   CmbTipoMoneda.ListIndex = -1
   txtCODIGOFOX.Text = ""
   Check1.Value = 0
   Check2.Value = 0
   Check3.Value = 0
   Check4.Value = 0
   Check5.Value = 0
   cmbPais.ListIndex = -1
   CmbCanasta.ListIndex = -1
   Cmb_ocurrencia.ListIndex = -1
   IntCodDivEsp.Text = "" '05/11/2004 Jspp Campo para interfaz a España
   Toolbar1.Buttons(3).Enabled = False

   Call PROC_Habilitacontroles(False)

End Sub

Private Sub PROC_GeneraCodigo()

   If Not BAC_SQL_EXECUTE("SP_GENERA_COD") Then
      Exit Sub

   End If

   If BAC_SQL_FETCH(Datos()) Then
      CodigoCor = CDbl(Datos(1)) + 1

   End If

End Sub

Private Sub Check1_Click()

   If Check1.Value = 1 Then
      Check2.Value = 0
      Check4.Value = 0
   End If

End Sub

Private Sub Check1_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then
      Check2.SetFocus

   End If

End Sub

Private Sub Check2_Click()

   If Check2.Value = 1 Then
      Check1.Value = 0

   End If

End Sub

Private Sub Check2_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then
      Check4.SetFocus

   End If

End Sub

Private Sub Check3_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then
      Check1.SetFocus

   End If

End Sub

Private Sub Check4_Click()

   If Check4.Value = 1 Then
      Check1.Value = 0
   End If


End Sub

Private Sub Check4_KeyPress(KeyAscii As Integer)


   If KeyAscii = vbKeyReturn Then
      txtGlosaMoneda.SetFocus

   End If

End Sub

Private Sub cmbCanasta_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      txtCODIGOFOX.SetFocus

   End If

End Sub

Private Sub CmbPais_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Check3.SetFocus

   End If

End Sub

Private Sub cmbPeriodo_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then
      CmbTipoMoneda.SetFocus

   End If

End Sub

Private Sub CmbTipoMoneda_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then
      intCsBancos.SetFocus

   End If

End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

   Dim iOpcion          As Integer

   On Error GoTo Errores

   iOpcion = 0

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
      Select Case KeyCode
      Case vbKeyLimpiar
         iOpcion = 1

      Case vbKeyGrabar
         iOpcion = 2

      Case vbKeyEliminar
         iOpcion = 3

      Case vbKeyBuscar
         iOpcion = 4

      Case vbKeySalir
         iOpcion = 5

      End Select

      If iOpcion <> 0 Then
         If Toolbar1.Buttons(iOpcion).Enabled Then
            Call Toolbar1_ButtonClick(Toolbar1.Buttons(iOpcion))

         End If

         KeyCode = 0

      End If

   End If

   On Error GoTo 0

   Exit Sub

Errores:
   Resume Next
   On Error GoTo 0

End Sub

Private Sub Form_Load()

   On Error GoTo Errores

   OptLocal = Opt

   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")

   Me.top = 0
   Me.left = 0
   SW = 0

   Toolbar1.Buttons(3).Enabled = False
   Call PROC_Habilitacontroles(False)

   'Show

   TXTBASE.Clear
   TXTBASE.AddItem "30"
   TXTBASE.AddItem "360"
   TXTBASE.AddItem "365"
   TXTBASE.ListIndex = 0

   CmbPeriodo.Clear
   CmbPeriodo.AddItem "DIARIO" & Space(50) & "1"
   CmbPeriodo.AddItem "MENSUAL" & Space(50) & "30"

   CmbPeriodo.ListIndex = 0

   Call PROC_CargaPais

   'Lena combo tipo moneda
   '------------------------------
   If Not Llenar_Combos(CmbTipoMoneda, MDMN_TIPOMONEDA) Then       'Código 216
      MsgBox "Combo se encuentra vacio ", vbCritical
      Exit Sub

   End If

   CmbTipoMoneda.ListIndex = 0

   With CmbCanasta
      .Clear
      .AddItem " "
      .AddItem "1"
      .AddItem "2"
      .AddItem "3"

   End With
   
   Envia = Array(216, "PCA")
   
   
   If BAC_SQL_EXECUTE("Sp_TcLeeCodigos1", Envia) Then
      Cmb_ocurrencia.Clear
      Cmb_ocurrencia.AddItem "NO APLICA"
      Cmb_ocurrencia.ItemData(Cmb_ocurrencia.NewIndex) = 0
      Do While BAC_SQL_FETCH(Datos())
         Cmb_ocurrencia.AddItem Datos(2)
         Cmb_ocurrencia.ItemData(Cmb_ocurrencia.NewIndex) = Datos(1)

      Loop

   End If

   Cmb_ocurrencia.ListIndex = -1
   On Error GoTo 0

   Exit Sub

Errores:
   MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
   On Error GoTo 0
   Unload Me
   Exit Sub
End Sub

Private Sub PROC_CargaPais()

   If BAC_SQL_EXECUTE("Sp_corresponsales_cmbpais") Then
      cmbPais.Clear

      Do While BAC_SQL_FETCH(Datos())
         cmbPais.AddItem Datos(1) + Space(100) + Datos(2)
         cmbPais.ItemData(cmbPais.NewIndex) = Datos(2)

      Loop

   End If

   cmbPais.ListIndex = -1

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")

End Sub

Private Sub intCodBCCH_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then
      CmbCanasta.SetFocus

   End If

End Sub

Private Sub intCsBancos_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then
      intCodBCCH.SetFocus

   End If

End Sub

Private Sub intPaisBCCH_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then
      txtCODIGOFOX.SetFocus

   End If

End Sub

Private Sub itbRedondeo_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then
      txtSimbolo.SetFocus

   End If

End Sub

Private Sub SSFrame1_Click()

   Bac_SendKey (vbKeyTab)

End Sub

Private Sub SSFrame2_Click()

   Bac_SendKey (vbKeyTab)

End Sub

Private Sub SSFrame3_Click()

   Bac_SendKey (vbKeyTab)

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Dim lNumero          As Long
   Dim sMoneda          As String
   Dim sReferencia      As String
   Dim sReferenciaUSD   As String
   Dim sMonedaLocal     As String
   Dim dCodigoCAnasta   As Double

   On Error GoTo Errores

   Select Case Button.Index
   Case 4
      Call TxtCodigo_LostFocus

   Case 2
      If FUNC_ValidaDatos() = False Then
         Exit Sub

      End If

      Screen.MousePointer = 11

      If CodigoCor = 0 Then PROC_GeneraCodigo
         Envia = Array()
         AddParam Envia, CDbl(txtCodigo.Text)
         AddParam Envia, txtNemo.Text
         AddParam Envia, txtSimbolo.Text
         AddParam Envia, txtGlosaMoneda.Text
         AddParam Envia, CDbl(itbRedondeo.Text)
         AddParam Envia, CDbl(Val(TXTBASE.Text))
         AddParam Envia, Trim(right(CmbTipoMoneda.Text, 5))
         AddParam Envia, CDbl(Trim(right(CmbPeriodo, 2)))
         AddParam Envia, CDbl(intCsBancos.Text)
         AddParam Envia, txtCODIGOFOX.Text
         AddParam Envia, CDbl(CodigoCor)
         AddParam Envia, CDbl(intCodBCCH.Text)
         AddParam Envia, CDbl(right(Trim(cmbPais.Text), 10)) 'CDbl(intPaisBCCH.Text) ' VB +- 06/06/2000 Se agrega la grabación del codigo del pais del BCCH  para BAC-CAMBIOS

         sMoneda = IIf(Check1.Value = 1, 0, 1)
         sReferencia = IIf(Check2.Value = 1, 1, 0)
         sReferenciaUSD = IIf(Check3.Value = 1, 1, 0)
         sMonedaLocal = IIf(Check4.Value = 1, 1, 0)

         If Trim(CmbCanasta.Text) <> "" Then
            dCodigoCAnasta = CDbl(CmbCanasta.Text)

         Else
            dCodigoCAnasta = 0

         End If

         AddParam Envia, sMoneda
         AddParam Envia, sReferencia
         AddParam Envia, sReferenciaUSD
         AddParam Envia, sMonedaLocal
         AddParam Envia, dCodigoCAnasta
         AddParam Envia, IIf(Check5.Value = 1, 1, 0)
         AddParam Envia, Cmb_ocurrencia.ItemData(Cmb_ocurrencia.ListIndex)
         AddParam Envia, CDbl(IntCodDivEsp.Text)        '05/11/2004 Jspp Campo para interfaz a España
      If Not BAC_SQL_EXECUTE("sp_mngrabar ", Envia) Then
         MsgBox "Operación no se realizó con exito", vbCritical
         Call LogAuditoria("01", OptLocal, Me.Caption + " Error al grabar- Codigo: " & txtCodigo.Text & " Nemotécnico" & txtNemo.Text & " Codigo Super: " & intCsBancos.Text & " Moneda: " & CmbTipoMoneda.Text & " Redondeo: " & itbRedondeo.Text, "", "")
         Screen.MousePointer = vbDefault
         On Error GoTo 0
         Exit Sub

      End If


      If BAC_SQL_FETCH(Datos()) Then
         If Datos(1) < 0 Then
            MsgBox Datos(2), vbExclamation

         Else
            MsgBox Datos(2), vbInformation
            Call PROC_LIMPIAR
'            Call PROC_Habilitacontroles(True)
            txtCodigo.SetFocus

         End If

      End If

      Screen.MousePointer = vbDefault
      On Error GoTo 0

      Exit Sub

   Case 3
      If (MsgBox("Seguro de Eliminar la moneda :" & Chr(13) & txtGlosaMoneda.Text, vbQuestion + vbYesNo)) = vbYes Then
         Envia = Array()
         AddParam Envia, CDbl(txtCodigo.Text)

         If Not BAC_SQL_EXECUTE("Sp_BacMntMn_Eliminar", Envia) Then
            MsgBox "Error Al Ejecutar Procedimiento", vbCritical
            Call LogAuditoria("03", OptLocal, Me.Caption + " Error al eliminar- Codigo: " & txtCodigo.Text & " Nemotécnico" & txtNemo.Text & " Codigo Super: " & intCsBancos.Text & " Moneda: " & CmbTipoMoneda.Text & " Redondeo: " & itbRedondeo.Text, "", "")
            On Error GoTo 0
            Exit Sub

         End If

         If BAC_SQL_FETCH(Datos()) Then
            If Datos(1) = "OK" Then
               MsgBox "La Moneda ha sido Eliminada", vbInformation
               Call LogAuditoria("03", OptLocal, Me.Caption, "Codigo: " & txtCodigo.Text & " Nemotécnico" & txtNemo.Text & " Codigo Super: " & intCsBancos.Text & " Moneda: " & CmbTipoMoneda.Text & " Redondeo: " & itbRedondeo.Text, "")

            Else
               MsgBox Datos(2), vbInformation

            End If

         Else
            MsgBox "La Moneda no se ha podido Eliminar", vbCritical, TITSISTEMA
            Call LogAuditoria("03", OptLocal, Me.Caption + " Error al eliminar- Codigo: " & txtCodigo.Text & " Nemotécnico" & txtNemo.Text & " Codigo Super: " & intCsBancos.Text & " Moneda: " & CmbTipoMoneda.Text & " Redondeo: " & itbRedondeo.Text, "", "")
            Call PROC_LIMPIAR
         End If

         Call PROC_LIMPIAR

         Toolbar1.Buttons(2).Enabled = False
         txtCodigo.SetFocus

         On Error GoTo 0

         Exit Sub

      End If

   Case 1
      Call PROC_LIMPIAR
      txtCodigo.SetFocus

   Case 5
      Unload Me

   End Select

   On Error GoTo 0

   Exit Sub

Errores:
   Screen.MousePointer = vbDefault
   On Error GoTo 0

End Sub

Private Sub TXTBASE_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then
      CmbPeriodo.SetFocus

   End If

End Sub

Private Sub txtCodigo_DblClick()

   auxilio = 100
   Call PROC_CodigoMoneda

   If txtCodigo.Enabled = True Then
      txtCodigo.SetFocus
      Call PROC_Habilitacontroles(True)
   End If

End Sub

Private Sub PROC_CodigoMoneda()

   On Error GoTo Errores

   MousePointer = 11

   Call PROC_LIMPIAR

   MiTag = "MDMN"
   BacAyuda.Show 1

   If giAceptar% = True Then
      txtCodigo.Text = gsCodigo$
      Call PROC_Habilitacontroles(True)
      TxtCodigo_LostFocus

   End If

   MousePointer = 0
   txtGlosaMoneda.SetFocus

   On Error GoTo 0

   Exit Sub

Errores:
   On Error GoTo 0

End Sub

Private Sub txtcodigo_GotFocus()

   SW = 1

End Sub

Private Sub TxtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyF3 Then
      Call PROC_CodigoMoneda
      If txtGlosaMoneda.Enabled Then txtGlosaMoneda.SetFocus
      Exit Sub

   End If

   If KeyCode = vbKeyReturn Then
      KeyCode = 0
      Call TxtCodigo_LostFocus

      If txtGlosaMoneda.Enabled = True Then
         txtGlosaMoneda.SetFocus

      End If

   End If

End Sub


Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

   If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 8 Then
      KeyAscii = 0

   End If

End Sub

Private Sub TxtCodigo_LostFocus()

   On Error GoTo Errores

   MousePointer = 11

   If txtCodigo.Text = "" Then
      MousePointer = 0
      On Error GoTo 0
      Exit Sub

   End If

   If CDbl(txtCodigo.Text) = 0 Then
      MousePointer = 0
      On Error GoTo 0
      Exit Sub

   End If

   lCodigo = txtCodigo.Text
   Call FUNC_LeerPorCodigo(lCodigo)
   MousePointer = 0
   If Val(txtCodigo.Text) > 0 Then
        PROC_Habilitacontroles True
        txtGlosaMoneda.SetFocus
   End If

   On Error GoTo 0

   Exit Sub

Errores:

   If swa <> 1000 Then
      DoEvents
      MousePointer = 0
      txtNemo.Enabled = True
      txtSimbolo.Enabled = True
      txtCodigo.Enabled = False
      txtGlosaMoneda.Enabled = False
      itbRedondeo.Enabled = True
      TXTBASE.Enabled = True
      CmbTipoMoneda.Enabled = True
      CmbPeriodo.Enabled = True
      intCsBancos.Enabled = True
      txtCODIGOFOX.Enabled = True
      intCodBCCH.Enabled = True
      intPaisBCCH.Enabled = True
      Toolbar1.Buttons(1).Enabled = True
      Toolbar1.Buttons(2).Enabled = True
      Toolbar1.Buttons(3).Enabled = False
      IntCodDivEsp.Enabled = True  '05/11/2004 Jspp Campo para interfaz a España
   Else
      MousePointer = 0
      txtGlosaMoneda.Enabled = True
      txtNemo.Enabled = True
      txtSimbolo.Enabled = True
      txtCodigo.Enabled = True
      txtGlosaMoneda.Enabled = True
      itbRedondeo.Enabled = True
      TXTBASE.Enabled = True
      CmbTipoMoneda.Enabled = True
      CmbPeriodo.Enabled = True
      intCsBancos.Enabled = True
      txtCODIGOFOX.Enabled = True
      intCodBCCH.Enabled = True
      intPaisBCCH.Enabled = True
      Toolbar1.Buttons(1).Enabled = True
      Toolbar1.Buttons(2).Enabled = True
      Toolbar1.Buttons(3).Enabled = False
      IntCodDivEsp.Enabled = True  '05/11/2004 Jspp Campo para interfaz a España
   End If

   On Error GoTo 0

   SW = 0

End Sub

Private Function FUNC_LeerPorCodigo(CodMon As Long) As Boolean

   Dim iCodigoCanasta      As Integer
   Dim iOcurrencia         As Integer
   
   FUNC_LeerPorCodigo = False

   Envia = Array()
   AddParam Envia, CodMon

   If Not BAC_SQL_EXECUTE("SP_MNLEER ", Envia) Then
      Exit Function

   End If

   If BAC_SQL_FETCH(Datos()) Then
      If Val(Datos(1)) < 0 Then
            MsgBox Datos(2), vbExclamation, gsBac_Version
            Toolbar1.Buttons(3).Enabled = False
            txtCodigo.Text = ""
            Exit Function
      Else
          Toolbar1.Buttons(3).Enabled = True
          txtNemo.Text = Datos(2)
          txtSimbolo.Text = Datos(3)
          txtGlosaMoneda.Text = Datos(4)
          itbRedondeo.Text = Datos(5)
          TXTBASE.Enabled = True
          
          If Val(Datos(6)) <> 0 Then
            TXTBASE.Text = Val(Datos(6))
          Else
            TXTBASE.Text = 360
          End If
          
          If Datos(7) <> "" Then
             CmbTipoMoneda.ListIndex = IIf(BuscaEnCombo(CmbTipoMoneda, Str(CDbl(Datos(7))), "C") = -1, 0, BuscaEnCombo(CmbTipoMoneda, Str(Datos(7)), "C")) ''''''' ARREGLAR
          End If
    
          CmbPeriodo.ListIndex = IIf(BuscaEnCombo(CmbPeriodo, Str(CDbl(Datos(9))), "C") = -1, 0, BuscaEnCombo(CmbPeriodo, Str(CDbl(Datos(9))), "C"))
          intCsBancos.Text = Datos(10)
          txtCODIGOFOX.Text = Datos(11) ''''''' ARREGLAR
          CodigoCor = Datos(13)
          intCodBCCH.Text = Datos(8)
          intPaisBCCH.Text = Datos(12)
    
          Check1.Value = IIf(Datos(14) = 0, 1, 0)
          Check2.Value = IIf(Datos(15) = 1, 1, 0)
          Check3.Value = IIf(Datos(16) = 1, 1, 0)
          Check4.Value = IIf(Datos(17) = 1, 1, 0)
          iCodigoCanasta = Datos(18)
          Check5.Value = IIf(Datos(19) = 1, 1, 0)
          iOcurrencia = Datos(20)
          IntCodDivEsp.Text = Datos(21) '05/11/2004 Jspp Campo para interfaz a España
          
          TXTBASE.Enabled = True
          If Val(Datos(6)) <> 0 Then
             TXTBASE.Text = Val(Datos(6))
          End If
          
      End If
   Else
      Toolbar1.Buttons(3).Enabled = False
      swa = 1000
      txtNemo.Text = " "
      txtGlosaMoneda.Text = ""
      txtSimbolo.Text = ""
      itbRedondeo.Text = 0
      TXTBASE.ListIndex = -1
      CmbTipoMoneda.ListIndex = 0
      CmbPeriodo.ListIndex = 0
      intCsBancos.Text = 0
      txtCODIGOFOX.Text = ""
      IntCodDivEsp.Text = 0
      txtGlosaMoneda.SetFocus
      IntCodDivEsp.Text = 0 '05/11/2004 Jspp Campo para interfaz a España
   End If

   For i = 0 To cmbPais.ListCount - 1
      If Trim(right(cmbPais.List(i), 10)) = intPaisBCCH.Text Then
         cmbPais.ListIndex = i

      End If

   Next i

   For i = 0 To CmbCanasta.ListCount - 1
      If Trim(CmbCanasta.List(i)) = iCodigoCanasta Then
         CmbCanasta.ListIndex = i

      End If

   Next i

   For i = 0 To Cmb_ocurrencia.ListCount - 1
      If Cmb_ocurrencia.ItemData(i) = iOcurrencia Then
         Cmb_ocurrencia.ListIndex = i
      End If

   Next i

   FUNC_LeerPorCodigo = True

End Function
Private Sub txtCODIGOFOX_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then
      cmbPais.SetFocus
   End If

End Sub
Private Sub txtGlosaMoneda_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then
      Call PROC_Habilitacontroles(True)
      txtNemo.Enabled = True
      txtNemo.SetFocus
   End If

End Sub

Private Sub txtGlosaMoneda_KeyPress(KeyAscii As Integer)

   Call BacToUCase(KeyAscii)
   KeyAscii = Caracter(KeyAscii)

End Sub

Private Sub txtNemo_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then
      itbRedondeo.SetFocus

   End If

End Sub

Private Sub txtNemo_KeyPress(KeyAscii As Integer)

   Call BacToUCase(KeyAscii)
   KeyAscii = Caracter(KeyAscii)

End Sub

Private Sub txtSimbolo_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then
      TXTBASE.SetFocus

   End If

End Sub

Private Sub txtSimbolo_KeyPress(KeyAscii As Integer)

   Call BacToUCase(KeyAscii)
   KeyAscii = Caracter(KeyAscii)

End Sub
