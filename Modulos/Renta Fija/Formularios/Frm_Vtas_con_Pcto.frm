VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Frm_Vtas_con_Pcto 
   Caption         =   "Ventas Con Pacto.-"
   ClientHeight    =   9375
   ClientLeft      =   420
   ClientTop       =   2055
   ClientWidth     =   12780
   ForeColor       =   &H8000000F&
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   9375
   ScaleWidth      =   12780
   Begin VB.Frame Fra_FCIC 
      Height          =   420
      Left            =   6330
      TabIndex        =   63
      Top             =   480
      Width           =   6420
      Begin Threed.SSCheck CHK_FCIC 
         Height          =   195
         Left            =   240
         TabIndex        =   64
         ToolTipText     =   "FACILIDAD DE CREDITO CONDICIONAL "
         Top             =   135
         Width           =   2655
         _Version        =   65536
         _ExtentX        =   4683
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "FCIC -  Facilidad de Crédito"
         ForeColor       =   16711680
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
   End
   Begin VB.Frame fra_LCGP 
      Height          =   420
      Left            =   0
      TabIndex        =   56
      Top             =   480
      Width           =   6290
      Begin Threed.SSCheck CHK_BCCH 
         Height          =   195
         Left            =   120
         TabIndex        =   62
         ToolTipText     =   "LÍNEA DE CREDITO GARANTIA PRENDARIA "
         Top             =   135
         Width           =   2655
         _Version        =   65536
         _ExtentX        =   4683
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "LCGP -  Banco Central Chile"
         ForeColor       =   16711680
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
      Begin VB.TextBox Txt_Operacion 
         Height          =   285
         Left            =   10365
         TabIndex        =   60
         Top             =   -5000
         Width           =   1740
      End
      Begin VB.CheckBox Chk_Folio 
         Caption         =   "Folio Soma Manual"
         Height          =   270
         Left            =   7410
         TabIndex        =   59
         Top             =   -5000
         Width           =   1875
      End
      Begin VB.CheckBox Chk_Detalle 
         Caption         =   "Mostrar Detalle Soma"
         Height          =   270
         Left            =   4560
         TabIndex        =   58
         Top             =   -5000
         Width           =   1935
      End
      Begin VB.ComboBox Combo_Doc 
         Height          =   315
         Left            =   2055
         Style           =   2  'Dropdown List
         TabIndex        =   57
         Top             =   -5000
         Width           =   2010
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1380
      Index           =   2
      Left            =   9480
      TabIndex        =   13
      Top             =   855
      Width           =   3285
      _Version        =   65536
      _ExtentX        =   5794
      _ExtentY        =   2434
      _StockProps     =   14
      Caption         =   "Vencimiento"
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
      Alignment       =   1
      Font3D          =   3
      Begin BACControles.TXTNumero txtVenPMP 
         Height          =   330
         Left            =   1230
         TabIndex        =   14
         Top             =   615
         Width           =   1950
         _ExtentX        =   3440
         _ExtentY        =   582
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
         Max             =   "999999999999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txtdiferencia 
         Height          =   330
         Left            =   1230
         TabIndex        =   15
         Top             =   1005
         Width           =   1950
         _ExtentX        =   3440
         _ExtentY        =   582
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
         Max             =   "999999999999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTFecha TxtFecVct 
         Height          =   315
         Left            =   1845
         TabIndex        =   40
         Top             =   255
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   556
         Enabled         =   -1  'True
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "16/11/2000"
      End
      Begin Threed.SSPanel PnlDiaFin 
         Height          =   240
         Left            =   645
         TabIndex        =   41
         Top             =   300
         Width           =   1125
         _Version        =   65536
         _ExtentX        =   1984
         _ExtentY        =   423
         _StockProps     =   15
         Caption         =   "Miércoles"
         ForeColor       =   16711680
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   0
         Font3D          =   3
         Alignment       =   5
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "UF"
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
         Index           =   8
         Left            =   120
         TabIndex        =   17
         Top             =   690
         Width           =   255
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Monto Saldo"
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
         Index           =   0
         Left            =   120
         TabIndex        =   16
         Top             =   1035
         Width           =   1140
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   12120
      Top             =   600
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   13
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Vtas_con_Pcto.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Vtas_con_Pcto.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Vtas_con_Pcto.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Vtas_con_Pcto.frx":0A86
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Vtas_con_Pcto.frx":0ED8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Vtas_con_Pcto.frx":11F2
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Vtas_con_Pcto.frx":1644
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Vtas_con_Pcto.frx":195E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Vtas_con_Pcto.frx":1C78
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Vtas_con_Pcto.frx":1F92
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Vtas_con_Pcto.frx":23E4
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Vtas_con_Pcto.frx":26FE
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Vtas_con_Pcto.frx":2A18
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid GrillaGrabarPctos 
      Height          =   1395
      Left            =   525
      TabIndex        =   27
      Top             =   3945
      Visible         =   0   'False
      Width           =   11085
      _ExtentX        =   19553
      _ExtentY        =   2461
      _Version        =   393216
      FixedCols       =   0
   End
   Begin VB.Frame Frame1 
      Caption         =   "Total Operacion"
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
      Height          =   555
      Left            =   9465
      TabIndex        =   45
      Top             =   2235
      Width           =   3285
      Begin BACControles.TXTNumero TxtTotal 
         Height          =   315
         Left            =   435
         TabIndex        =   46
         Top             =   195
         Width           =   2730
         _ExtentX        =   4815
         _ExtentY        =   556
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
         Min             =   "-99999999999999"
         Max             =   "999999999999999"
         Separator       =   -1  'True
      End
   End
   Begin VB.Frame Cuadrodvp 
      Caption         =   "DVP"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   75
      TabIndex        =   42
      Top             =   2280
      Width           =   2820
      Begin VB.OptionButton OptDvp 
         Caption         =   "&Si"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   1425
         TabIndex        =   44
         TabStop         =   0   'False
         Top             =   195
         Width           =   735
      End
      Begin VB.OptionButton OptDvp 
         Caption         =   "&No"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   615
         TabIndex        =   43
         TabStop         =   0   'False
         Top             =   195
         Width           =   705
      End
   End
   Begin VB.Frame frm_Soma 
      Caption         =   "Instrumentos en el SOMA"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3240
      Left            =   240
      TabIndex        =   20
      Top             =   6495
      Width           =   14775
      Begin MSFlexGridLib.MSFlexGrid GridErroresSOMA 
         Height          =   855
         Left            =   0
         TabIndex        =   31
         Top             =   2160
         Width           =   11895
         _ExtentX        =   20981
         _ExtentY        =   1508
         _Version        =   393216
         Rows            =   1
         Cols            =   6
      End
      Begin MSFlexGridLib.MSFlexGrid GridFolioSOMA 
         Height          =   1935
         Left            =   -45
         TabIndex        =   28
         Top             =   240
         Width           =   2055
         _ExtentX        =   3625
         _ExtentY        =   3413
         _Version        =   393216
         Rows            =   1
         FixedRows       =   0
      End
      Begin VB.PictureBox PicProgree 
         BorderStyle     =   0  'None
         Height          =   525
         Left            =   11970
         ScaleHeight     =   525
         ScaleWidth      =   2265
         TabIndex        =   23
         Top             =   1485
         Width           =   2265
         Begin ComctlLib.ProgressBar Progreso 
            Height          =   225
            Left            =   225
            TabIndex        =   24
            Top             =   210
            Width           =   2835
            _ExtentX        =   5001
            _ExtentY        =   397
            _Version        =   327682
            Appearance      =   0
         End
         Begin VB.Label LblProgreso 
            Caption         =   "CARGANDO .... "
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   255
            TabIndex        =   25
            Top             =   0
            Width           =   2730
         End
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Generar FLI. "
         Height          =   345
         Left            =   12240
         TabIndex        =   22
         Top             =   225
         Visible         =   0   'False
         Width           =   2070
      End
      Begin MSFlexGridLib.MSFlexGrid GrillaSoma 
         Height          =   2040
         Left            =   1980
         TabIndex        =   21
         TabStop         =   0   'False
         Top             =   150
         Width           =   9825
         _ExtentX        =   17330
         _ExtentY        =   3598
         _Version        =   393216
         Cols            =   10
         FixedCols       =   0
         BackColor       =   12632256
         ForeColor       =   0
         BackColorFixed  =   8388608
         ForeColorFixed  =   16777215
         BackColorSel    =   16744576
         ForeColorSel    =   16777215
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
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
   Begin BACControles.TXTNumero TxtIngreso 
      Height          =   195
      Left            =   3000
      TabIndex        =   19
      Top             =   2880
      Visible         =   0   'False
      Width           =   915
      _ExtentX        =   1614
      _ExtentY        =   344
      BackColor       =   16744576
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
   End
   Begin Threed.SSFrame Frame 
      Height          =   1425
      Index           =   0
      Left            =   30
      TabIndex        =   0
      Top             =   855
      Width           =   2880
      _Version        =   65536
      _ExtentX        =   5080
      _ExtentY        =   2514
      _StockProps     =   14
      Caption         =   "Inicio"
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
      Begin BACControles.TXTFecha TxtFecIni 
         Height          =   315
         Left            =   1440
         TabIndex        =   1
         Top             =   285
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "16/11/2000"
      End
      Begin Threed.SSPanel PnlDiaIni 
         Height          =   315
         Left            =   105
         TabIndex        =   2
         Top             =   285
         Width           =   1095
         _Version        =   65536
         _ExtentX        =   1931
         _ExtentY        =   556
         _StockProps     =   15
         Caption         =   "Miércoles"
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
         BevelOuter      =   0
         Font3D          =   3
         Alignment       =   1
      End
      Begin BACControles.TXTNumero txtIniPMS 
         Height          =   330
         Left            =   825
         TabIndex        =   3
         TabStop         =   0   'False
         Top             =   975
         Width           =   1935
         _ExtentX        =   3413
         _ExtentY        =   582
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
         Max             =   "999999999999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txtIniPMP 
         Height          =   330
         Left            =   825
         TabIndex        =   4
         TabStop         =   0   'False
         Top             =   615
         Width           =   1935
         _ExtentX        =   3413
         _ExtentY        =   582
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
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "$$"
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
         Height          =   255
         Index           =   2
         Left            =   105
         TabIndex        =   6
         Top             =   1005
         Width           =   345
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "UF"
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
         Index           =   1
         Left            =   105
         TabIndex        =   5
         Top             =   645
         Width           =   255
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1905
      Index           =   3
      Left            =   6330
      TabIndex        =   32
      Top             =   855
      Width           =   3105
      _Version        =   65536
      _ExtentX        =   5477
      _ExtentY        =   3360
      _StockProps     =   14
      Caption         =   "Transferencia"
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
      Alignment       =   2
      Font3D          =   3
      Begin BACControles.TXTNumero Txt_VFTran 
         Height          =   300
         Left            =   1395
         TabIndex        =   33
         Top             =   810
         Width           =   1650
         _ExtentX        =   2910
         _ExtentY        =   529
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,0000"
         Text            =   "0,0000"
         CantidadDecimales=   "04"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero Txt_TasaTran 
         Height          =   315
         Left            =   2025
         TabIndex        =   51
         Top             =   450
         Width           =   1005
         _ExtentX        =   1773
         _ExtentY        =   556
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         CantidadDecimales=   "4"
      End
      Begin BACControles.TXTNumero Txt_DifTran 
         Height          =   300
         Left            =   1395
         TabIndex        =   34
         Top             =   1170
         Width           =   1650
         _ExtentX        =   2910
         _ExtentY        =   529
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,0000"
         Text            =   "0,0000"
         CantidadDecimales=   "04"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero Txt_Dif_CLP 
         Height          =   300
         Left            =   1395
         TabIndex        =   35
         Top             =   1530
         Width           =   1650
         _ExtentX        =   2910
         _ExtentY        =   529
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
         Min             =   "-9999999999999999"
         Separator       =   -1  'True
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Resultado"
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
         Index           =   7
         Left            =   60
         TabIndex        =   39
         Top             =   1200
         Width           =   870
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Tasa Trans."
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
         Index           =   11
         Left            =   60
         TabIndex        =   38
         Top             =   480
         Width           =   1035
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Val. Fin. Trans."
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
         Index           =   9
         Left            =   60
         TabIndex        =   37
         Top             =   840
         Width           =   1320
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Resultado CLP"
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
         Index           =   10
         Left            =   60
         TabIndex        =   36
         Top             =   1575
         Width           =   1275
      End
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Mostrar Detalle SOMA"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Left            =   6480
      TabIndex        =   26
      Top             =   1920
      Width           =   1920
   End
   Begin VB.CheckBox CheckFolioSOMAManual 
      Caption         =   "Folio SOMA Manual"
      Height          =   255
      Left            =   8520
      TabIndex        =   29
      Top             =   1920
      Width           =   1815
   End
   Begin BACControles.TXTNumero TxtFolioSoma 
      Height          =   255
      Left            =   10440
      TabIndex        =   30
      Top             =   1920
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   450
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
   Begin Threed.SSFrame Frame 
      Height          =   1935
      Index           =   1
      Left            =   2925
      TabIndex        =   7
      Top             =   855
      Width           =   3360
      _Version        =   65536
      _ExtentX        =   5927
      _ExtentY        =   3413
      _StockProps     =   14
      Caption         =   "Pacto"
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
      Alignment       =   2
      Font3D          =   3
      Begin VB.TextBox Txt_Tmp 
         Enabled         =   0   'False
         Height          =   285
         Left            =   840
         TabIndex        =   54
         Top             =   975
         Width           =   765
      End
      Begin VB.ComboBox CmbMon 
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
         Left            =   840
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   270
         Width           =   1290
      End
      Begin BACControles.TXTNumero txtTipoCambio 
         Height          =   315
         Left            =   2205
         TabIndex        =   10
         Top             =   270
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   556
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         CantidadDecimales=   "4"
      End
      Begin BACControles.TXTNumero TxtPlazo 
         Height          =   315
         Left            =   2415
         TabIndex        =   49
         Top             =   1275
         Width           =   900
         _ExtentX        =   1588
         _ExtentY        =   556
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
      Begin BACControles.TXTNumero TxtTasa 
         Height          =   315
         Left            =   2415
         TabIndex        =   47
         Top             =   615
         Width           =   900
         _ExtentX        =   1588
         _ExtentY        =   556
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         CantidadDecimales=   "4"
      End
      Begin VB.ComboBox CmbBase 
         BackColor       =   &H00FFFFFF&
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
         ItemData        =   "Frm_Vtas_con_Pcto.frx":38F2
         Left            =   330
         List            =   "Frm_Vtas_con_Pcto.frx":38FF
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   1560
         Visible         =   0   'False
         Width           =   795
      End
      Begin BACControles.TXTNumero TXT_Spread 
         Height          =   300
         Left            =   2430
         TabIndex        =   61
         Top             =   945
         Width           =   870
         _ExtentX        =   1535
         _ExtentY        =   529
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         CantidadDecimales=   "4"
      End
      Begin VB.Label Lbl_Spread 
         Caption         =   "Spread"
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
         Height          =   270
         Left            =   1725
         TabIndex        =   55
         Top             =   1020
         Width           =   585
      End
      Begin VB.Label Lbl_TasaTmp 
         Caption         =   "TMP"
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
         Height          =   285
         Left            =   90
         TabIndex        =   53
         Top             =   1020
         Width           =   495
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Tasa"
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
         Index           =   3
         Left            =   75
         TabIndex        =   50
         Top             =   645
         Width           =   435
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Plazo"
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
         Index           =   5
         Left            =   90
         TabIndex        =   48
         Top             =   1320
         Width           =   660
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
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
         Index           =   6
         Left            =   75
         TabIndex        =   12
         Top             =   270
         Width           =   690
      End
      Begin VB.Label Label 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Base"
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
         Index           =   4
         Left            =   150
         TabIndex        =   11
         Top             =   1935
         Width           =   435
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   495
      Left            =   0
      TabIndex        =   52
      Top             =   0
      Width           =   12780
      _ExtentX        =   22543
      _ExtentY        =   873
      ButtonWidth     =   847
      ButtonHeight    =   820
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   14
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar Operación"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdFiltrar"
            Description     =   "Filtrar"
            Object.ToolTipText     =   "Filtrar Papeles"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "cmdVerMarcados"
            Description     =   "VerMarcados"
            Object.ToolTipText     =   "Modificar o Liberar Papeles"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdVerTodos"
            Description     =   "VerTodos"
            Object.ToolTipText     =   "Ver Todos los papeles"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "cmdVender"
            Description     =   "Vender"
            Object.ToolTipText     =   "Vender Papeles"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "cmdRestaurar"
            Description     =   "Restaurar"
            Object.ToolTipText     =   "Restaurar Papel"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdCapturar"
            Description     =   "CARGA_SOMA_EXCEL"
            Object.ToolTipText     =   "Captura de Operaciones desde Sistema SOMA"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Key             =   "CmdInfCargaSOMA"
            Description     =   "InfCargaSOMA"
            Object.ToolTipText     =   "Informe de CARGASOMA"
            ImageIndex      =   12
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Detalle"
            Description     =   "Detalle"
            Object.ToolTipText     =   "Detalle"
            ImageIndex      =   13
         EndProperty
         BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir de la Ventana"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button14 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Ayuda"
            Description     =   "Ayuda"
            Object.ToolTipText     =   "Ayuda"
            ImageIndex      =   10
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSFlexGridLib.MSFlexGrid Grilla 
      Height          =   6660
      Left            =   0
      TabIndex        =   18
      TabStop         =   0   'False
      Top             =   2805
      Width           =   12075
      _ExtentX        =   21299
      _ExtentY        =   11748
      _Version        =   393216
      Cols            =   27
      FixedCols       =   2
      BackColor       =   12632256
      ForeColor       =   0
      BackColorFixed  =   8388608
      ForeColorFixed  =   16777215
      BackColorSel    =   16744576
      ForeColorSel    =   16777215
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
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
Attribute VB_Name = "Frm_Vtas_con_Pcto"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public iAceptar               As Boolean
Public CarterasFinancieras    As String
Public CarterasNormativas     As String
Public LGCP_Familia           As String ' 20181221.RCH.LCGP
Public MihWnd                 As Long
Public nMaximoIngreso         As Double
''REQ.6006
Public nMarca                 As String
Public nSerie                 As String
Public sCarteraNorm           As String
Public dTasaRef               As Double
Public dNominal               As Double
Public sCarteraNormCod        As String
Public dRutEmisor             As Double

Public nFolioSOMA             As Long
Public cNombreArchivo         As String
Public bDistribucionManual    As Boolean

Public cCodCartFin        As String
Public cCodLibro          As String
Public TotDiario As String
Public nom_archivo As String
Public carga As Integer

Private Enum bEstado
   [Normal] = 0
   [Tomado] = 1
   [VtaTotal] = 2
   [VtaParcial] = 3
   [BloqueoPacto] = 4   ' PRD-6005
End Enum

Const FDec4Dec = "#,##0.0000"
Const FDec2Dec = "#,##0.00"
Const FDec0Dec = "#,##0"

Const Col_Marca = 0
Const COL_Serie = 1
Const Col_Moneda = 2
Const Col_Nominal = 3
Const Col_Tir = 4
Const Col_VPar = 5
Const Col_MT = 6
Const Col_PlzRes = 7
Const Col_Margen = 8
Const Col_ValInicial = 9

Const Col_Custodia = 11
Const Col_ClaveDcv = 12
Const Col_CarteraSuper = 10


Const Col_Nominal_ORIG = 13
Const Col_Tir_ORIG = 14
Const Col_VPar_ORIG = 15
Const Col_MT_ORIG = 16
Const Col_Margen_ORIG = 17
Const Col_ValInicial_ORIG = 18
Const Col_CodCarteraSuper = 19
Const Col_BloqueoPacto = 20      ' PRD-6005
Const Col_HairCut = 21           ' PRD-6007
Const Col_Emisor = 24            ' PRD-6006
Const Col_ID_SOMA = 22           ' PRD-6010
Const Col_Correla_SOMA = 23      ' PRD-6010
Const Col_Nemo_Emisor = 25       ' PRD-6006



'PRD-6006            CASS 09-12-2010 ---> Grilla Detalle Pacto
Const ColD_Documento = 0
Const ColD_Correlativo = 1
Const ColD_NominalVenta = 2
Const ColD_TirVenta = 3
Const ColD_PvpVenta = 4
Const ColD_ValorVenta = 5
Const ColD_TasaEstimada = 7
Const ColD_VParVenta = 8
Const ColD_NumUltCup = 9
Const ColD_InstSer = 10
Const ColD_RutEmisor = 11
Const ColD_MonedaEmision = 12
Const ColD_FechaEmision = 13
Const ColD_FechaVencimiento = 14
Const ColD_FecProxCupon = 15
Const ColD_Convexidad = 16
Const ColD_DurationModificado = 17
Const ColD_DurationMacaulay = 18
Const ColD_icustodia = 19
Const ColD_ClaveDcv = 20
Const ColD_CarteraSuper = 21
Const ColD_DiasDisponibles = 22
Const ColD_Margen = 23
Const ColD_ValorInicial = 24
Const ColD_HairCut = 26
Const ColD_IDSoma = 27
Const ColD_CorrelaSoma = 28
Const ColD_InCodigo = 29
Const ColD_MarcaVta = 30
Const ColD_Libro = 31



Const CajaSinMarcar = &HE0E0E0
Const CajaBloqeado = vbBlack
Const CajaVtaTotal = &HFF0000
Const CajaVtaParcial = &HFFFF00

Const FnteSinMarcar = &H0&
Const FnteBloqeado = vbWhite
Const FnteVtaTotal = &HFFFFFF
Const FnteVtaParcial = &H0&

Dim nModoCalculo     As Integer
Dim cMascara         As String
Dim nNominal         As Double
Dim nTir             As Double
Dim nPvp             As Double
Dim nMonto           As Double
Dim cFecCal          As String
Dim nFactor          As Double
Dim nValorInicial    As Double
Dim cUsuario         As String
Dim nVentana         As Double
Dim nMontoAnterior   As Double

Dim nNumOperFli      As Long
Dim oPagoParcial     As Boolean
Dim EstaPagando      As Boolean
Dim cSql             As String
Dim ErrAnula         As String
Dim nAlturaFila      As Long

'PRD-6006            CASS 09-12-2010
Dim dTipcam#
Dim sFecPro          As String
Public nDolarOb      As Double
Public nUf           As Double
Public glBacCpDvpVi  As DvpCp
Public bCargaArchivo          As Boolean
Public SwErrorArch            As Boolean
Public MiExcel    As Object
Public MiLibro    As Object
Public nominalr As Long
Public tserie As String
Public sSerie As String
Public X As Integer
Public selhaircut As Integer
Public formatorepo As String

Private Function ChangeColorSetting(ByVal Fila As Long, Estado As bEstado)
   Dim nContador     As Long
   Dim bColorCaja    As Variant
   Dim bColorFont    As Variant
   Dim nColumna      As Long

       If Estado = Normal Then Let bColorCaja = vbBlack:           Let bColorFont = vbBlack
       If Estado = Tomado Then Let bColorCaja = vbGreen + vbWhite: Let bColorFont = vbWhite
     If Estado = VtaTotal Then Let bColorCaja = vbBlue:            Let bColorFont = vbWhite
   If Estado = VtaParcial Then Let bColorCaja = vbCyan:            Let bColorFont = vbBlack
   If Estado = BloqueoPacto Then Let bColorCaja = vbYellow:        Let bColorFont = vbRed   ' PRD-6005

   Let nColumna = GRILLA.ColSel
   Let GRILLA.Row = IIf(Estado = 4, Fila, GRILLA.RowSel)   ' PRD-6005
   Let GRILLA.Redraw = False

   For nContador = 3 To GRILLA.cols - 1
      Let GRILLA.Col = nContador
      Let GRILLA.CellBackColor = bColorCaja
      Let GRILLA.CellForeColor = bColorFont
   Next nContador
   Let GRILLA.Col = nColumna
   Let GRILLA.Redraw = True
   
'   If Estado = VtaParcial Then
'           nominalr = GRILLA.TextMatrix(GRILLA.Row, 3)
'   End If

   
   
End Function

  

'Private Sub SettingGridSoma(ByRef xGrilla As MSFlexGrid)
'   Let xGrilla.Rows = 2:   Let xGrilla.FixedRows = 1
'   Let xGrilla.cols = 10:   Let xGrilla.FixedCols = 0
'
'   Let xGrilla.TextMatrix(0, 0) = "Serie":               Let xGrilla.ColWidth(0) = 1300
'   Let xGrilla.TextMatrix(0, 1) = "Nominal":             Let xGrilla.ColWidth(1) = 2000
'   Let xGrilla.TextMatrix(0, 2) = "Tasa":                Let xGrilla.ColWidth(2) = 1000
'   Let xGrilla.TextMatrix(0, 3) = "Valor Referencial":   Let xGrilla.ColWidth(3) = 2500
'   Let xGrilla.TextMatrix(0, 4) = "Plazo":               Let xGrilla.ColWidth(4) = 1000
'   Let xGrilla.TextMatrix(0, 5) = "Margen":              Let xGrilla.ColWidth(5) = 1000
'   Let xGrilla.TextMatrix(0, 6) = "Valor Inicial":       Let xGrilla.ColWidth(6) = 2500
'   Let xGrilla.TextMatrix(0, 7) = "ID":                  Let xGrilla.ColWidth(7) = 1000  'PRD-6010
'   Let xGrilla.TextMatrix(0, 8) = "Correlativo":         Let xGrilla.ColWidth(8) = 1000  'PRD-6010
'   Let xGrilla.TextMatrix(0, 9) = "RutEmisor":           Let xGrilla.ColWidth(9) = 1500  'PRD-6010
'   Let xGrilla.Rows = 1
'End Sub

Private Sub SettingGridVisible(ByRef xGrilla As MSFlexGrid)
   Dim nContador  As Long

   Let xGrilla.WordWrap = True

   Let xGrilla.Rows = 2:      Let xGrilla.cols = 26 ' VB+- 25/01/2010 Se agregan 2 columas para el tema de la carteras  ' PRD-6005 - PRD-6007
   Let xGrilla.Row = 1:       Let xGrilla.Col = 1
   Let xGrilla.FixedRows = 1: Let xGrilla.FixedCols = 3
   
   Let xGrilla.RowHeight(0) = 500
   Let xGrilla.TextMatrix(0, Col_Marca) = "M":                              Let xGrilla.ColWidth(Col_Marca) = 500:          Let xGrilla.TextMatrix(1, Col_Marca) = ""
   Let xGrilla.TextMatrix(0, COL_Serie) = "Serie":                          Let xGrilla.ColWidth(COL_Serie) = 1300:         Let xGrilla.TextMatrix(1, COL_Serie) = ""
   Let xGrilla.TextMatrix(0, Col_Moneda) = "UM":                            Let xGrilla.ColWidth(Col_Moneda) = 500:         Let xGrilla.TextMatrix(1, Col_Moneda) = ""
   Let xGrilla.TextMatrix(0, Col_Nominal) = "Nominal":                      Let xGrilla.ColWidth(Col_Nominal) = 2000:       Let xGrilla.TextMatrix(1, Col_Nominal) = Format(0#, FDec4Dec)
   
   Let xGrilla.TextMatrix(0, Col_Tir) = "Tasa Referencial":                 Let xGrilla.ColWidth(Col_Tir) = 1000:           Let xGrilla.TextMatrix(1, Col_Tir) = Format(0#, FDec4Dec)
'   If Tipo_Operacion = "VI" Then
'      Let xGrilla.TextMatrix(0, Col_Tir) = "Tasa":                 Let xGrilla.ColWidth(Col_Tir) = 1000:           Let xGrilla.TextMatrix(1, Col_Tir) = Format(0#, FDec4Dec)
'   End If
   
   Let xGrilla.TextMatrix(0, Col_VPar) = "%Vpar":                           Let xGrilla.ColWidth(Col_VPar) = 900:           Let xGrilla.TextMatrix(1, Col_VPar) = Format(0#, FDec4Dec)
   
   Let xGrilla.TextMatrix(0, Col_MT) = "Valor Referencial":                 Let xGrilla.ColWidth(Col_MT) = 2500:            Let xGrilla.TextMatrix(1, Col_MT) = Format(0#, FDec0Dec)
   If Tipo_Operacion = "VI" Then
      Let xGrilla.TextMatrix(0, Col_MT) = "Valor Presente":                 Let xGrilla.ColWidth(Col_MT) = 2500:            Let xGrilla.TextMatrix(1, Col_MT) = Format(0#, FDec0Dec)
   End If
   
   Let xGrilla.TextMatrix(0, Col_PlzRes) = "Plazo Residual":                Let xGrilla.ColWidth(Col_PlzRes) = 1000:        Let xGrilla.TextMatrix(1, Col_PlzRes) = Format(0#, FDec0Dec)
   
   Let xGrilla.TextMatrix(0, Col_Margen) = "Margen":                        Let xGrilla.ColWidth(Col_Margen) = 1000:        Let xGrilla.TextMatrix(1, Col_Margen) = Format(0#, FDec4Dec)
'   If Tipo_Operacion = "VI" Then
'        Let xGrilla.ColWidth(Col_Margen) = 0
'   End If
      
   
   Let xGrilla.TextMatrix(0, Col_ValInicial) = "Valor Inicial":             Let xGrilla.ColWidth(Col_ValInicial) = 2500:    Let xGrilla.TextMatrix(1, Col_ValInicial) = Format(0#, FDec0Dec)
   If Tipo_Operacion = "VI" Then
      Let xGrilla.ColWidth(Col_ValInicial) = 0
   End If
   
   Let xGrilla.TextMatrix(0, Col_Custodia) = "Custodia":                    Let xGrilla.ColWidth(Col_Custodia) = 1500:      Let xGrilla.TextMatrix(1, Col_Custodia) = ""
   Let xGrilla.TextMatrix(0, Col_ClaveDcv) = "Clave DCV":                   Let xGrilla.ColWidth(Col_ClaveDcv) = 0:         Let xGrilla.TextMatrix(1, Col_ClaveDcv) = ""
   Let xGrilla.TextMatrix(0, Col_CarteraSuper) = "Cartera Super":           Let xGrilla.ColWidth(Col_CarteraSuper) = 3000:  Let xGrilla.TextMatrix(1, Col_CarteraSuper) = ""   'VB+-25/01/2010

   Let xGrilla.TextMatrix(0, Col_Nominal_ORIG) = "Nom. Original":           Let xGrilla.ColWidth(Col_Nominal_ORIG) = 0:     Let xGrilla.TextMatrix(1, Col_Nominal_ORIG) = Format(0#, FDec4Dec)
   Let xGrilla.TextMatrix(0, Col_Tir_ORIG) = "Tasa Original":               Let xGrilla.ColWidth(Col_Tir_ORIG) = 0:         Let xGrilla.TextMatrix(1, Col_Tir_ORIG) = Format(0#, FDec4Dec)
   Let xGrilla.TextMatrix(0, Col_VPar_ORIG) = "vPar Original":              Let xGrilla.ColWidth(Col_VPar_ORIG) = 0:        Let xGrilla.TextMatrix(1, Col_VPar_ORIG) = Format(0#, FDec4Dec)
   Let xGrilla.TextMatrix(0, Col_MT_ORIG) = "Valor Ref. Original":          Let xGrilla.ColWidth(Col_MT_ORIG) = 0:          Let xGrilla.TextMatrix(1, Col_MT_ORIG) = Format(0#, FDec4Dec)
   Let xGrilla.TextMatrix(0, Col_Margen_ORIG) = "Margen Original":          Let xGrilla.ColWidth(Col_Margen_ORIG) = 0:      Let xGrilla.TextMatrix(1, Col_Margen_ORIG) = Format(0#, FDec0Dec)
   Let xGrilla.TextMatrix(0, Col_ValInicial_ORIG) = "vInicial Original":    Let xGrilla.ColWidth(Col_ValInicial_ORIG) = 0:  Let xGrilla.TextMatrix(1, Col_ValInicial_ORIG) = Format(0#, FDec0Dec)
   Let xGrilla.TextMatrix(0, Col_CodCarteraSuper) = "Cód. Cartera Super":   Let xGrilla.ColWidth(Col_CodCarteraSuper) = 0:  Let xGrilla.TextMatrix(1, Col_CodCarteraSuper) = ""  'VB+-25/01/2010
   Let xGrilla.TextMatrix(0, Col_BloqueoPacto) = "Bloqueo Pacto":           Let xGrilla.ColWidth(Col_BloqueoPacto) = 2000:  Let xGrilla.TextMatrix(1, Col_BloqueoPacto) = Format(0#, FDec4Dec)  ' PRD-6005
   
   Let xGrilla.TextMatrix(0, Col_HairCut) = "HairCut(%)":                   Let xGrilla.ColWidth(Col_HairCut) = 1000:       Let xGrilla.TextMatrix(1, Col_HairCut) = Format(0#, FDec4Dec)       ' PRD-6007
'   If Tipo_Operacion = "VI" Then
'      Let xGrilla.ColWidth(Col_HairCut) = 0
'   End If
   
   Let xGrilla.TextMatrix(0, Col_ID_SOMA) = "ID SOMA(%)":                   Let xGrilla.ColWidth(Col_ID_SOMA) = 1000:       Let xGrilla.TextMatrix(1, Col_ID_SOMA) = Format(0#, FDec0Dec)       ' PRD-6010
   If Tipo_Operacion = "VI" Then
      Let xGrilla.ColWidth(Col_ID_SOMA) = 0
   End If
   
   Let xGrilla.TextMatrix(0, Col_Correla_SOMA) = "Correla_SOMA(%)":         Let xGrilla.ColWidth(Col_Correla_SOMA) = 1100:  Let xGrilla.TextMatrix(1, Col_Correla_SOMA) = Format(0#, FDec0Dec)  ' PRD-6010
   If Tipo_Operacion = "VI" Then
      Let xGrilla.ColWidth(Col_Correla_SOMA) = 0
   End If

   Let xGrilla.TextMatrix(0, Col_Emisor) = "Emisor":                        Let xGrilla.ColWidth(Col_Emisor) = 1000:        Let xGrilla.TextMatrix(1, Col_Emisor) = Format(0#, FDec0Dec)        ' PRD-6006
   Let xGrilla.TextMatrix(0, Col_Nemo_Emisor) = "Nemo Emisor":              Let xGrilla.ColWidth(Col_Nemo_Emisor) = 1000:   Let xGrilla.TextMatrix(1, Col_Nemo_Emisor) = ""                     ' PRD-6006
   
End Sub

Private Function Valorizacion_Pactos_REPO_TXT(ByVal xTecla As KeyCodeConstants, Optional SW As Boolean)
   Dim nMargen As Double
   Dim Datos()
   Dim sCalculoVInicial As String * 1
   Dim dMontoNominalOriginal As Double
   Dim dMontoPresenteOriginal As Double
   Dim dRespaldoNominal    As Double
   Dim Filasel As Integer
   
   With GRILLA
     For Filasel = 1 To GRILLA.Rows - 1
       If GRILLA.TextMatrix(Filasel, 0) = "P" Then
          GRILLA.RowSel = Filasel
          Exit For
       End If
     Next Filasel
   End With
   
   'ARM trae haircut y tasa referencial desde mantenedores
   Call carga_haircut
   Call carga_tasaref_soma
   

    If xTecla = vbKeyV Then
        Let nModoCalculo = 3
        Let nFactor = 0
    Else
        If GRILLA.ColSel = Col_Marca Then: Let nModoCalculo = 2
        If GRILLA.ColSel = Col_Nominal Then: Let nModoCalculo = 2
        If GRILLA.ColSel = Col_Tir Then: Let nModoCalculo = 2
        If GRILLA.ColSel = Col_MT Then: Let nModoCalculo = 3
        If GRILLA.ColSel = Col_ValInicial Then: Let nModoCalculo = 4
   
        If nModoCalculo = 3 Then
            If nMontoAnterior = 0 Then
                Let nFactor = 1
            Else
                Let nFactor = (CDbl(TxtIngreso.text) / nMontoAnterior)
            End If
        End If
      
        If nModoCalculo = 4 Then
            If nMontoAnterior = 0 Then
                Let nFactor = 1
            Else
                Let nFactor = Round((TxtIngreso.text / GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), 0)
                Let GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = nFactor
                Let nFactor = nFactor / nMontoAnterior
            End If
        End If
        
    End If

   dRespaldoNominal = GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal)
   
    If nModoCalculo = 3 Then
        If GRILLA.ColSel = Col_MT Then
            Let nMonto = GRILLA.TextMatrix(GRILLA.RowSel, Col_MT)
        End If
        
        If GRILLA.ColSel = Col_ValInicial Then
            If CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)) = 0 Then
                Let nMonto = GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) / 1
            Else
                Let nMonto = Round(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) / GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen), 0)
            ' Let nMonto = grilla.TextMatrix(grilla.RowSel, Col_ValInicial) / grilla.TextMatrix(grilla.RowSel, Col_Margen)
            End If
            
        End If
         
    End If
   
    sCalculoVInicial = "N"
    
    If nModoCalculo = 4 Then
        sCalculoVInicial = "S"
        Let nModoCalculo = 3
    End If
   
    If (oPagoParcial And EstaPagando) Then  '--> Es para asignar todo los papales como calculados
        If xTecla = vbKeyV Then
            sCalculoVInicial = "T"
        ElseIf GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal) = GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG) And GRILLA.ColSel = Col_Nominal Then
            sCalculoVInicial = "T"
        ElseIf GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = GRILLA.TextMatrix(GRILLA.RowSel, Col_MT_ORIG) And GRILLA.ColSel = Col_MT Then
            sCalculoVInicial = "T"
        ElseIf GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) = GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial_ORIG) And GRILLA.ColSel = Col_ValInicial Then
            sCalculoVInicial = "T"
        End If
    End If
  
    If sCalculoVInicial <> "T" Then
        If (oPagoParcial And EstaPagando) Then  '--> Es para asignar todo los papales como calculados
        
            If GRILLA.ColSel = Col_MT Or GRILLA.ColSel = Col_ValInicial Then
                Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal) = dRespaldoNominal
                'Let grilla.TextMatrix(grilla.RowSel, Col_Nominal) = Round(((grilla.TextMatrix(grilla.RowSel, Col_MT) * Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)) / Grilla.TextMatrix(Grilla.RowSel, Col_MT_ORIG)), 0)
                ' Let grilla.TextMatrix(grilla.RowSel, Col_Nominal) = ((grilla.TextMatrix(grilla.RowSel, Col_MT) * grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)) / Grilla.TextMatrix(Grilla.RowSel, Col_MT_ORIG))
                
            End If
        
        End If
    End If
    
    Let cMascara = GRILLA.TextMatrix(GRILLA.RowSel, COL_Serie)
    Let nNominal = GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal)
    Let nTir = GRILLA.TextMatrix(GRILLA.RowSel, Col_Tir)
    Let nPvp = GRILLA.TextMatrix(GRILLA.RowSel, Col_VPar)
    Let nMonto = GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) * IIf(SW, nFactor, 1)
    Let nMargen = GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)
    Let dMontoNominalOriginal = GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)
    Let dMontoPresenteOriginal = GRILLA.TextMatrix(GRILLA.RowSel, Col_MT_ORIG)
    
    
    Let cFecCal = Format(gsBac_Fecp, "yyyymmdd")
    Let nValorInicial = GRILLA.TextMatrix(GRILLA.RowSel, 6)
    Let cUsuario = gsBac_User
    Let nVentana = MihWnd

    Envia = Array()
    AddParam Envia, nModoCalculo
    AddParam Envia, cMascara
    AddParam Envia, nNominal
    AddParam Envia, CDbl(GRILLA.TextMatrix(Filasel, Col_Tir)) 'nTir
    AddParam Envia, nPvp
    AddParam Envia, nMonto
    AddParam Envia, cFecCal
    AddParam Envia, nFactor
    AddParam Envia, nValorInicial
    AddParam Envia, cUsuario
    AddParam Envia, nVentana
    
    If GRILLA.ColSel = Col_Nominal And CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)) <> CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal)) And xTecla <> vbKeyV Then
        AddParam Envia, "N"
    Else
        AddParam Envia, IIf(oPagoParcial, "S", "N") '--> Este es nuevo para control de valorizacion
    End If
    
    AddParam Envia, sCalculoVInicial
    
    If oPagoParcial And EstaPagando And GRILLA.ColSel = Col_Nominal Then
        AddParam Envia, "N"
    Else
        AddParam Envia, IIf(oPagoParcial And EstaPagando, "S", "N") '--> Este es el ultimo control para la valorizacion del pago
    End If
    
    AddParam Envia, CDbl(dMontoNominalOriginal)
    AddParam Envia, CDbl(dMontoPresenteOriginal)
    AddParam Envia, GRILLA.TextMatrix(GRILLA.RowSel, Col_CodCarteraSuper)
    AddParam Envia, CDbl(GRILLA.TextMatrix(Filasel, Col_HairCut)) 'CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_HairCut))   'PRD-6007 - 6010
    AddParam Envia, CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ID_SOMA)) 'PRD-6010
    AddParam Envia, CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Correla_SOMA))  'PRD-6010
    AddParam Envia, CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Emisor))
    
    'If Not Bac_Sql_Execute("dbo.SP_VALORIZADETALLEFLI_6007_6010", Envia) Then 'PRD-6006 CASS 06-10-2010
    If Not Bac_Sql_Execute("dbo.SP_VALORIZADETALLEPACTOS", Envia) Then
        Call MsgBox("Se ha producido un error en la Valorizacion del instrumento.", vbExclamation, App.Title)
        Call SoltarPapel
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then
    
        If Datos(1) < 0 Then
        
            Call MsgBox(Datos(2), vbExclamation, App.Title)
            Call SoltarPapel
            
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Tir) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Tir_ORIG)), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_VPar) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_VPar_ORIG)), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT_ORIG)), FDec0Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen_ORIG)), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial_ORIG)), FDec0Dec)
            
            On Error Resume Next
            Call GRILLA.SetFocus
            On Error GoTo 0
            
        Else
        
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal) = Format(Datos(2), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Tir) = Format(Datos(3), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_VPar) = Format(Datos(4), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = Format(Datos(5), FDec0Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) = Format(Datos(6), FDec0Dec)
            
            If GRILLA.ColSel = Col_MT Or GRILLA.ColSel = Col_Tir Then
                If Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT)) * CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), FDec0Dec) <> Format(CDbl(Datos(6)), FDec0Dec) Then
                    Let GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT)) * CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), FDec0Dec)
                End If
            End If
            If GRILLA.ColSel = Col_ValInicial Then
                If Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial)) / CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), FDec0Dec) <> Format(CDbl(Datos(5)), FDec0Dec) Then
                    Let GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial)) / CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), FDec0Dec)
                End If
            End If
            
            
        End If
        
    End If
    
    Call subCOLOREA_Registro
    Call ActualizaMontoOperacion
   


End Function

Private Sub Check1_Click()
'   If Check1.Value = 1 Then
'      If GrillaSoma.Rows <> GrillaSoma.FixedRows Then
'         Let Me.Height = 9600
'         'PRD-6010
'         frm_Soma.Visible = True
'         frm_Soma.Enabled = True
'         frm_Soma.Top = 6195
'      End If
'   Else
'      Let Me.Height = 6900
'      PRD -6010
'      frm_Soma.Visible = False
'      frm_Soma.Enabled = False
'   End If
End Sub
Private Sub CheckFolioSOMAManual_Click()

   If CheckFolioSOMAManual.Value = 1 Then
      TxtFolioSoma.Enabled = True
   Else
      TxtFolioSoma.Enabled = False
   End If
   
End Sub

Sub LGCP_Visible(bFlag As Boolean)

'      Combo_Doc.Visible = True
'      Me.Chk_Detalle.Visible = True
'      Me.Chk_Folio.Visible = True
'      Txt_Operacion.Visible = True
      Me.Lbl_TasaTmp.Visible = bFlag
      Txt_Tmp.Visible = bFlag
      Txt_Tmp.text = Proc_TasaPoliticaMonetaria
      'ARM se asigna por defecto el valor de tmp a tasa
      Me.TxtTasa.text = Txt_Tmp.text
      Lbl_Spread.Visible = bFlag
      TXT_Spread.Visible = bFlag
      Toolbar1.Buttons(10).Enabled = False ' Not bFlag

End Sub

Private Sub CHK_BCCH_Click(Value As Integer)
  If CHK_BCCH.Value = 1 Then
'      Combo_Doc.Visible = True
'      Me.Chk_Detalle.Visible = True
'      Me.Chk_Folio.Visible = True
'      Txt_Operacion.Visible = True
'      Me.Lbl_TasaTmp.Visible = True
'      Txt_Tmp.Visible = True
'      Txt_Tmp.text = Proc_TasaPoliticaMonetaria
'      'ARM se asigna por defecto el valor de tmp a tasa
'      Me.TxtTasa.text = Txt_Tmp.text
'      Lbl_Spread.Visible = True
'      TXT_Spread.Visible = True
'      Toolbar1.Buttons(10).Enabled = True
      LGCP_Visible (True)
   Else
'      Combo_Doc.Visible = False
'      Me.Chk_Detalle.Visible = False
'      Me.Chk_Folio.Visible = False
'      Txt_Operacion.Visible = False
'      Lbl_TasaTmp.Visible = False
'      Txt_Tmp.Visible = False
'      Lbl_Spread.Visible = False
'      TXT_Spread.Visible = False
'      Toolbar1.Buttons(10).Enabled = False
    LGCP_Visible (False)
   End If
End Sub

Private Sub Chk_Detalle_Click()
 If Chk_Detalle.Value = 1 Then
    
      If Not (Me.WindowState = vbMaximized) Then
        Let Me.Height = 9000
      End If
      'PRD-6010
      GRILLA.Height = 3000
      frm_Soma.Visible = True
      frm_Soma.Top = 5800
      frm_Soma.Enabled = True
 Else
      If GrillaSoma.Rows <> GrillaSoma.FixedRows Then
         If Not (Me.WindowState = vbMaximized) Then
            Let Me.Height = 8100
         End If
         'PRD-6010
         GRILLA.Height = 4000
         frm_Soma.Visible = False
         frm_Soma.Enabled = False
      End If
  End If
End Sub

Private Sub CHK_FCIC_Click(Value As Integer)
    
    If CHK_FCIC.Value = 1 Then
        LGCP_Visible (False)
    End If

End Sub

Private Sub CmbMon_Change()
Dim MonPac As Integer
  Dim nRedon   As Integer
    If CmbMon.ListIndex = -1 Then
        Exit Sub
    End If
    CmbBase.ListIndex = CmbMon.ListIndex
    MonPac = CmbMon.ItemData(CmbMon.ListIndex)
    
    If CmbMon.ItemData(CmbMon.ListIndex) = 999 Then
       txtIniPMP.CantidadDecimales = 0
       nRedon = 0
    Else
       txtIniPMP.CantidadDecimales = BacDatGrMon.mndecimal
       nRedon = BacDatGrMon.mndecimal
    End If

    If CDbl(CmbMon.Tag) <> MonPac Then
        If dTipcam = 0 Then
          txtIniPMP.text = 0
        Else
          txtIniPMP.text = Round(TxtTotal.text / dTipcam#, nRedon)
        End If
    End If
    BacControlWindows 12

End Sub

Private Sub CmbMon_Click()
'   Let Label(1).Caption = CmbMon.Text
'   TxtTipoCambio.Text = Format(CDbl(funcBuscaTipcambio(CmbMon.ItemData(CmbMon.ListIndex), TxtFecIni.Text)), "#,##0.0000")
    Dim NemMon      As String
    Dim i           As Integer
    Dim nRedon      As Integer
    Dim nResp       As Integer
    Dim k As Integer
    
    dTipcam# = 0
    k = 0
    
    If CmbMon.ListIndex <> -1 Then
        NemMon = Trim$(CmbMon.List(CmbMon.ListIndex))
        Label(1).Caption = NemMon
        Label(8).Caption = NemMon
        
        Call funcFindDatGralMoneda(CmbMon.ItemData(CmbMon.ListIndex))
        SwMx = BacDatGrMon.mnmx
    
        If CmbMon.text = UCase("clp") Then
            txtIniPMP.CantidadDecimales = 0
            txtVenPMP.CantidadDecimales = 0
            Txt_VFTran.CantidadDecimales = 0
            Txt_DifTran.CantidadDecimales = 0
        Else
            txtIniPMP.CantidadDecimales = BacDatGrMon.mndecimal
            txtVenPMP.CantidadDecimales = BacDatGrMon.mndecimal
            Txt_VFTran.CantidadDecimales = BacDatGrMon.mndecimal
            Txt_DifTran.CantidadDecimales = BacDatGrMon.mndecimal
        End If
        
        If giMonLoc <> CmbMon.ItemData(CmbMon.ListIndex) Then
            sFecPro = Str(gsBac_Fecp)
            dTipcam# = funcBuscaTipcambio(CmbMon.ItemData(CmbMon.ListIndex), sFecPro)
            
            If dTipcam# = 0 And CmbMon.ItemData(CmbMon.ListIndex) <> 13 Then
                nResp = MsgBox("Tipo de cambio para : " & NemMon & " con fecha " & gsBac_Fecp & Chr(10) & Chr(13) & " NO ha sido ingresado." & Chr(10) & Chr(13) & " Desea Ingresarlo ? ", vbExclamation + vbYesNo, TITSISTEMA)
                                
                If nResp = 6 Then
                    txtTipoCambio.Enabled = IIf(SwMx = "C", True, False)
                    txtTipoCambio.text = dTipcam#
                    txtTipoCambio.SetFocus
                Else
                    For i% = 0 To CmbMon.ListCount - 1
                      
                       If Mid(CmbMon.List(i%), 1, 3) = "CLP" Then 'waldo
                          CmbMon.ListIndex = i%
                          Exit For
                       End If
                       
                    Next i%
                
                End If
            ElseIf dTipcam# = 0 And CmbMon.ItemData(CmbMon.ListIndex) = 13 Then
                   dTipcam# = funcBuscaTipcambio(994, sFecPro)
            End If
        Else
            dTipcam# = IIf(CmbMon.ItemData(CmbMon.ListIndex) = 13, nDolarOb, 1)
        End If
        
        txtTipoCambio.text = dTipcam#
        txtTipoCambio.Enabled = IIf(SwMx = "C", True, False)
        
        If CmbMon.ItemData(CmbMon.ListIndex) = 999 Then
            nRedon = 0
        Else
            nRedon = BacDatGrMon.mndecimal
        End If
        
        If dTipcam# = 0 Then
           txtIniPMP.text = 0
        Else
           txtIniPMP.text = Round(CDbl(TxtTotal.text / dTipcam#), nRedon)
        End If
        
        Call CalcularValorFinal
    End If


End Sub

Private Sub cmbMon_GotFocus()
    If CmbMon.ListIndex <> -1 Then
        CmbMon.Tag = CmbMon.ItemData(CmbMon.ListIndex)
    Else
        CmbMon.Tag = "0"
    End If

End Sub



Private Sub Combo_Doc_Click()
 
    nom_archivo = Mid(Combo_Doc.text, 1, 4)
End Sub

'Private Sub Command1_Click()
'   Call Realizar_Fli_Soma
'End Sub

Private Sub Form_Activate()

    Me.Tag = "VI"
    Tipo_Operacion = "VI"
    BacControlWindows 30
'    iFlagKeyDown = True
   Me.Top = 0
   Me.Left = 0
    Screen.MousePointer = vbDefault
'
'    RutCartV = nRutCartV
'    DvCartV = cDvCartV
'    NomCartV = cNomCartV
'    FiltraVentaAutomatico = False
    nDolarOb = funcBuscaTipcambio(994, sFecPro)
    nUf = funcBuscaTipcambio(998, sFecPro)
    Exit Sub

BacErrHnd:
    
    Screen.MousePointer = vbDefault
    On Error GoTo 0
    Exit Sub

End Sub

Private Sub Form_Load()
   Dim nSw%
   Dim nCont%

   Let Frm_Vtas_con_Pcto.bDistribucionManual = False
   Me.Top = 0
   Me.Left = 0
   Let Screen.MousePointer = vbHourglass
   
   Let frm_Soma.Visible = False
   Let Icon = BacTrader.Icon
 '  Let Top = 0:               Let Me.Left = 0:              Let Me.Height = 6900
   
   Let Caption = "Ventas Con Pacto - VI"
   Let Tipo_Operacion = "VI"
   Let MihWnd = CDbl(Me.hWnd)
   Let nNumOperFli = 0
   Let EstaPagando = False
   Let oPagoParcial = False
   Let EstaPagando = False
   Let nMaximoIngreso = 0
   
   'PRD-6010
   Let nFolioSOMA = 0
   Let TxtFolioSoma.Enabled = False

'   Let Toolbar1.Buttons(10).Enabled = False  20181220.RCH.LCGP
   Let Toolbar1.Buttons(11).Enabled = False

   Let TxtFecIni.text = Format(gsBac_Fecp, "dd/mm/yyyy")
   
   TxtTotal.Enabled = False   'PRD-6006 CASS 28-12-2010
   
   Call funcFindMonVal(Me.CmbMon, CmbBase, "VI")
   
   If CmbMon.ListCount > -1 Then
      CmbMon.ListIndex = 0
   End If

   Call SettingGridVisible(GRILLA)
   'Call SettingGridSoma(GrillaSoma) '-->PRD-6006 CASS 21-12-2010

   Toolbar1.Buttons(5).Tag = "Ver Sel."
   Toolbar1.Buttons(5).ToolTipText = "Ver Selección"
   
   If CmbMon.ListIndex > -1 Then
      CmbMon.ListIndex = 0
      sFecPro = Str(gsBac_Fecp)
      dTipcam# = funcBuscaTipcambio(CmbMon.ItemData(CmbMon.ListIndex), sFecPro)
   End If
   
   '-->PRD-6006 CASS 21-12-2010
   '-- MAP
    TxtFecIni.text = Format$(gsBac_Fecp, "dd/mm/yyyy")
    
    
    nSw = 0
    nCont = 1
    
    Do While nSw = 0
       TxtPlazo.text = nCont
       TxtFecVct.text = Format$(DateAdd("d", TxtPlazo.text, TxtFecIni.text), "dd/mm/yyyy")
       
       If EsFeriado(CDate(TxtFecVct.text), "00001") Then
            nCont = nCont + 1
       Else
            nSw = 1
       End If
    Loop
    
    TxtPlazo.text = DateDiff("D", TxtFecIni.text, TxtFecVct.text)
   '-- MAP
   
   PnlDiaIni.Caption = BacDiaSem(TxtFecIni.text)
   PnlDiaFin.Caption = BacDiaSem(TxtFecVct.text)
   Call Proc_Consulta_Porcentaje_Transacciones("VI")
   Call LeeModoControlPT               'PRD-3860, modo silencioso
   '-->PRD-6006 CASS 21-12-2010
   
   Call Fnc_Genera_Cortes
   
   
   'ARM PRD-9873
      Me.CHK_BCCH.Value = 0
      CHK_BCCH.Enabled = False
       Let Toolbar1.Buttons(1).Enabled = False
      Me.Combo_Doc.AddItem "[Selecione Operacion]"
      Me.Combo_Doc.AddItem "SPL"
      Me.Combo_Doc.AddItem "REPO"
      Me.Combo_Doc.ListIndex = 0
      Call CHK_BCCH_Click(0)
      
   'ARM PRD-9873
   
   Call LGCP_Visible(False) '20181220.RCH.LGCP
   
   Let Screen.MousePointer = vbDefault
End Sub

Private Sub Form_Resize()
On Error GoTo BacErrHnd

Dim lScaleWidth&, lScaleHeight&, lPosIni&

    ' Cuando la ventana es minimizada, se ignora la rutina.-
    If Me.WindowState = 1 Then
        ' Pinta borde del icono.-
        Dim X!, y!, j%

        X = Me.Width
        y = Me.Height
        For j% = 1 To 15
            Line (0, 0)-(X, 0), QBColor(Int(Rnd * 15))
            Line (X, 0)-(X, y), QBColor(Int(Rnd * 15))
            Line (X, y)-(0, y), QBColor(Int(Rnd * 15))
            Line (0, y)-(0, 0), QBColor(Int(Rnd * 15))
            DoEvents
        Next
        Exit Sub

    End If

  ' Escalas de medida de la ventana.-
    lScaleWidth& = Me.ScaleWidth
    lScaleHeight& = Me.ScaleHeight

  ' Resize la ventana customizado.-
    If Me.WindowState <> 1 And Me.Width > 400 And Me.Height > 9000 Then  '  2100  'PRD-6010
        GRILLA.Width = Me.Width - 300
        GRILLA.Height = Me.Height - 5300   'PRD-6010
    Else
        GRILLA.Height = Me.Height - 3010 '2500   'PRD-6010
    End If

      Exit Sub

BacErrHnd:

    On Error GoTo 0
    Resume Next

End Sub


Private Sub Form_Unload(Cancel As Integer)
   carga = 0
   Call SoltarTodos
   

   Me.LGCP_Familia = ""     '20181226.RCH.LCGP
End Sub

Private Function SoltarTodos()

   Envia = Array()
   AddParam Envia, CDbl(3) '--> Limpia tabla
   AddParam Envia, Trim(GRILLA.TextMatrix(GRILLA.RowSel, COL_Serie))
   AddParam Envia, Trim(gsBac_User)
   AddParam Envia, CDbl(Me.hWnd)
   AddParam Envia, CDbl(0)
   
   'If Not Bac_Sql_Execute("dbo.SP_LEE_BLOQUEO_FLI_6005_6006", Envia) Then
   If Not Bac_Sql_Execute("dbo.SP_LEE_BLOQUEO_PACTOS", Envia) Then         'PRD-6006 CASS 23-12-2010
      Let Me.MousePointer = vbDefault
      Call MsgBox("Se ha producido un error al tratar de tomar el registro.", vbExclamation, App.Title)
      Exit Function
   End If
   
End Function






Private Sub OptDvp_Click(Index As Integer)
   Select Case Index
      Case 0
         glBacCpDvpVi = No
      Case 1
         glBacCpDvpVi = Si
   End Select
   Toolbar1.Enabled = True
End Sub



Private Sub TXT_Spread_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
     If TXT_Spread.text > 0.25 Or TXT_Spread.text < 0 Then
        MsgBox ("Spread no puede ser menor que 0 o mayor que 0.25 "), vbInformation, TITSISTEMA
     Else
      Dim Monto As Double
         Monto = CDbl(Txt_Tmp.text) + CDbl(TXT_Spread.text)
        TxtTasa.text = Monto 'Txt_Tmp.Text + TXT_Spread.Text
        Call calcula
       End If
    End If
    
End Sub

Private Sub Txt_TasaTran_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      Bac_SendKey vbKeyTab
End If
End Sub

Private Sub Txt_TasaTran_LostFocus()
    CalcularValorFinal
    
    If Txt_VFTran.text > 0 And Txt_TasaTran.text <> 0 Then '--> Ctrl con Tasa Negativa
        If Not Proc_Valida_Tasa_Transferencia(CDbl(TxtTasa.text), CDbl(Txt_TasaTran.text)) Then
            'se omite enviar desde aqui mensaje ya que lo envia la funcion de validacion
        End If
    End If
End Sub

Private Sub TxtFecVct_Change()
   TxtPlazo.text = DateDiff("D", TxtFecIni.text, TxtFecVct.text)
End Sub

Private Sub TxtFecVct_LostFocus()
    Dim u As Integer
    
    u = 0
    If Format(TxtFecVct.text, "yyyymmdd") < Format(TxtFecIni.text, "yyyymmdd") Then
       MsgBox "La Fecha de Vencimiento debe ser Mayor a Fecha de Inicio.", 16
       TxtFecVct.text = Format$(DateAdd("d", TxtPlazo.text, TxtFecIni.text), "dd/mm/yyyy")
       u = 1
     '  Exit Sub
    End If

    TxtPlazo.Tag = TxtPlazo.text
    TxtPlazo.text = DateDiff("d", TxtFecIni.text, TxtFecVct.text)
    
    PnlDiaFin.Caption = BacDiaSem(TxtFecVct.text)
    If EsFeriado(CDate(TxtFecVct.text), "00001") Then
        MsgBox "La Fecha de Vcto. ingresada retorna un día No Hábil; Por favor reingrese", vbCritical, "FERIADOS"
        TxtPlazo.text = TxtPlazo.Tag
        TxtFecVct.text = Format$(DateAdd("d", TxtPlazo.text, TxtFecIni.text), "dd/mm/yyyy")
        PnlDiaFin.Caption = BacDiaSem(TxtFecVct.text)
        u = 1
        'Exit Sub
    End If
    
    If TxtPlazo.text = 0 Then
        MsgBox "Fecha de Vcto. Ingresada igual a la de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
        TxtPlazo.text = TxtPlazo.Tag
        TxtFecVct.text = Format$(DateAdd("d", TxtPlazo.text, TxtFecIni.text), "dd/mm/yyyy")
        u = 1
        'Exit Sub
    End If
    
    Call CalcularValorFinal
    
    If u = 1 Then
        'TxtFecVct.SetFocus
    End If

End Sub

Private Sub TxtFolioSoma_GotFocus()
'PRD-6010
   Let nFolioSOMA = TxtFolioSoma.text
End Sub

Private Sub TxtIngreso_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim cFormato         As Variant
   If KeyCode = vbKeyEscape Then
      Let GRILLA.Enabled = True
      Let Toolbar1.Enabled = True
      Let TxtIngreso.Visible = False
      Call GRILLA.SetFocus
   End If

   If KeyCode = vbKeyReturn Then
      
      If bDistribucionManual = True Then
         If MsgBox("Se perderá asignacion Manual, continúa ? ", vbOKCancel) = vbCancel Then
            Call TxtIngreso.SetFocus
            Exit Sub
         End If
      End If
 
      
      
      If TxtIngreso.text = 0 Then
         Call MsgBox("Valor ingresado no es valido...", vbExclamation, App.Title)
         Call TxtIngreso.SetFocus
         Exit Sub
      End If
      
      
      
      
      Let cFormato = IIf(TxtIngreso.CantidadDecimales = 0, FDec0Dec, FDec4Dec)

      'ARM carga aircut

      'PRD-6005
      If GRILLA.ColSel = Col_Tir Then
            If CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)) = 0 Then
                Call MsgBox("No existe Nominal disponible.", vbExclamation, App.Title)
                Let TxtIngreso.text = CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG))
                Call TxtIngreso.SetFocus
                Exit Sub
            End If
      End If
      'PRD-6005

      If GRILLA.ColSel = Col_MT Then
      
            If (oPagoParcial Or EstaPagando) And CDbl(TxtIngreso.text) > CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT_ORIG)) Then
                MsgBox "Monto ingresado no puede ser mayor o igual valor del papel", vbExclamation
                Let TxtIngreso.text = CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT))
                Call TxtIngreso.SetFocus
                Exit Sub
            Else
                Let nMontoAnterior = CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT))
            End If
            
            If (oPagoParcial Or EstaPagando) And CDbl(TxtIngreso.text) >= CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT_ORIG)) And GRILLA.TextMatrix(GRILLA.RowSel, 0) = "P" Then
                MsgBox "Monto ingresado no puede ser mayor o igual valor del papel", vbExclamation
                Let TxtIngreso.text = CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT))
                Call TxtIngreso.SetFocus
                Exit Sub
            Else
                Let nMontoAnterior = CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT))
            End If
            
            'PRD-6005
            If CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)) = 0 Then
                Call MsgBox("No existe Nominal disponible.", vbExclamation, App.Title)
                Let TxtIngreso.text = CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG))
                Call TxtIngreso.SetFocus
                Exit Sub
            End If
            'PRD-6005
      End If
      
      If GRILLA.ColSel = Col_ValInicial Then
            If (oPagoParcial Or EstaPagando) And CDbl(TxtIngreso.text) > CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial_ORIG)) Then
                MsgBox "Monto ingresado no puede ser mayor o igual valor del papel", vbExclamation
                Let TxtIngreso.text = CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial))
                Call TxtIngreso.SetFocus
                Exit Sub
            Else
                Let nMontoAnterior = CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial))
            End If
            'PRD-6005
            If CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)) = 0 Then
                Call MsgBox("No existe Nominal disponible.", vbExclamation, App.Title)
                Let TxtIngreso.text = CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG))
                Call TxtIngreso.SetFocus
                Exit Sub
            End If
            'PRD-6005
             
      End If

      If GRILLA.ColSel = Col_Nominal Then
         If CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)) < CDbl(TxtIngreso.text) Then
            Call MsgBox("Nominal disponible es menor al ingresado.", vbExclamation, App.Title)
            Let TxtIngreso.text = CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG))
            Call TxtIngreso.SetFocus
            Exit Sub
         End If
      '   TxtTotal.Text = TxtIngreso.Text
      
      End If
      
      Let GRILLA.Enabled = True
      Let Toolbar1.Enabled = True
      
     
      Let GRILLA.TextMatrix(GRILLA.RowSel, GRILLA.ColSel) = Format(TxtIngreso.text, cFormato)
      
      Let TxtIngreso.Visible = False
      Call GRILLA.SetFocus
      
      
      If TomarPapel Then
        Call Valorizacion_Pactos(vbKeyReturn)
        TxtTotal.text = VENTA_SumarTotal() 'PRD-6006 CASS 28-12-2010

      End If
      
   End If
   
   'Arm Carga valor Haircut
   
     
   
End Sub

Private Function SoltarPapel() As Boolean
   Dim Datos()
   
   Let SoltarPapel = True
   
   If GRILLA.TextMatrix(GRILLA.RowSel, Col_Marca) = "V" Or GRILLA.TextMatrix(GRILLA.RowSel, Col_Marca) = "P" Then
      Call BacBeginTransaction

      Envia = Array()
      AddParam Envia, CDbl(2) '--> Indica Desblequero o Resauracion
      AddParam Envia, Trim(GRILLA.TextMatrix(GRILLA.RowSel, COL_Serie))
      AddParam Envia, Trim(gsBac_User)
      AddParam Envia, CDbl(Me.hWnd)
      AddParam Envia, CDbl(0)
      AddParam Envia, Trim(GRILLA.TextMatrix(GRILLA.RowSel, Col_CodCarteraSuper))
      AddParam Envia, CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Emisor))
      
      'If Not Bac_Sql_Execute("dbo.SP_LEE_BLOQUEO_FLI_6005_6006", Envia) Then 'PRD-6006 CASS  06-12-2010
      If Not Bac_Sql_Execute("dbo.SP_LEE_BLOQUEO_PACTOS", Envia) Then
         Call BacRollBackTransaction
         Let Me.MousePointer = vbDefault
         Call MsgBox("Se ha producido un error al tratar de tomar el registro.", vbExclamation, App.Title)
         Let SoltarPapel = False
         Exit Function
      End If
      
      If Bac_SQL_Fetch(Datos()) Then
         Call BacCommitTransaction
         Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Marca) = ""
         Call ChangeColorSetting(GRILLA.RowSel, Normal)
        'PRD-6005
         If GRILLA.TextMatrix(GRILLA.RowSel, Col_BloqueoPacto) <> 0 Then
           Call ChangeColorSetting(GRILLA.RowSel, BloqueoPacto)
         End If
      
      End If
   Else
      If GRILLA.TextMatrix(GRILLA.RowSel, Col_Marca) <> "" Then
         Call MsgBox("El registro no se puede desbloquear... por que lo tiene tomado otro usuario.", vbExclamation, App.Title)
         Call GRILLA.SetFocus
         Let SoltarPapel = False
      End If
   End If
   
   Call ActualizaMontoOperacion
   
End Function

Private Function TomarPapel() As Boolean
   Dim Datos()
   Dim nMarca     As String
   Dim nMoninal   As Double
   
   Let TomarPapel = True
   
   If GRILLA.TextMatrix(GRILLA.RowSel, Col_Marca) = "*" Then
      Let Me.MousePointer = vbDefault
      Call MsgBox("Documento se encuentra tomado por otro usuario.", vbExclamation, App.Title)
      Call GRILLA.SetFocus
      Let TomarPapel = False
      Exit Function
   End If

   Let nMoninal = CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal))

   Envia = Array()
   AddParam Envia, CDbl(1) '--> Indica Blequero
   AddParam Envia, Trim(GRILLA.TextMatrix(GRILLA.RowSel, COL_Serie))
   AddParam Envia, Trim(gsBac_User)
   AddParam Envia, CDbl(Me.hWnd)
   AddParam Envia, nMoninal
   AddParam Envia, GRILLA.TextMatrix(GRILLA.RowSel, Col_CodCarteraSuper)
   AddParam Envia, CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Emisor))
   
   'If Not Bac_Sql_Execute("dbo.SP_LEE_BLOQUEO_FLI_6005_6006", Envia) Then
   If Not Bac_Sql_Execute("dbo.SP_LEE_BLOQUEO_PACTOS", Envia) Then
      Let Me.MousePointer = vbDefault
      Call MsgBox("Se ha producido un error al tratar de tomar el registro.", vbExclamation, App.Title)
      Let TomarPapel = False
      Exit Function
   End If
   
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) < 0 Then
         Call MsgBox(Datos(2), vbExclamation, App.Title)
         Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Marca) = "*"
         Call ChangeColorSetting(GRILLA.RowSel, Tomado)
         Let TomarPapel = False
      Else
         ' RevisaColores
         Call subCOLOREA_Registro
      End If
   End If

   Call ActualizaMontoOperacion
   
   If Val(txtdiferencia.text) < 0 Then
      Call SoltarPapel
      Let TomarPapel = False
      Exit Function
    End If
   
   ''REQ.6006
   If GRILLA.TextMatrix(GRILLA.RowSel, Col_Marca) = "P" Then
      Toolbar1.Buttons(12).Enabled = True
   End If
   
End Function

Private Sub subCOLOREA_Registro()

    If CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)) <> CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal)) Then
       Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Marca) = "P"
       Let GRILLA.TextMatrix(GRILLA.RowSel, Col_ClaveDcv) = FUNC_GENERA_CLAVE_DCV
       Call ChangeColorSetting(GRILLA.RowSel, VtaParcial)
    Else
       Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Marca) = "V"
       Let GRILLA.TextMatrix(GRILLA.RowSel, Col_ClaveDcv) = FUNC_GENERA_CLAVE_DCV
       Call ChangeColorSetting(GRILLA.RowSel, VtaTotal)
    End If
    
End Sub


Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)
    Dim Datos()
    Dim nColumna         As Long
    Dim bPermiteEscribir As Boolean
    Dim nMoninal         As Double

    If GRILLA.TextMatrix(GRILLA.RowSel, COL_Serie) = "" Then
        Exit Sub
    End If

    Let Me.MousePointer = vbHourglass
    Let nColumna = GRILLA.ColSel

    If KeyCode = vbKeyReturn Then  '->> Genera el ingreso de datos sobre la grilla, haciendo visible un texto sobre la celda seleccionada <<-'
  
        Let bPermiteEscribir = False
    
        If GRILLA.ColSel = Col_Nominal Then:      Let TxtIngreso.CantidadDecimales = 4: Let bPermiteEscribir = True
        If GRILLA.ColSel = Col_Tir Then:          Let TxtIngreso.CantidadDecimales = 4: Let bPermiteEscribir = True
        If GRILLA.ColSel = Col_MT Then:           Let TxtIngreso.CantidadDecimales = 0: Let bPermiteEscribir = True
        If GRILLA.ColSel = Col_ValInicial Then:   Let TxtIngreso.CantidadDecimales = 0: Let bPermiteEscribir = True
        
        If KeyCode = vbKeyV Or KeyCode = vbKeyR Then
            bPermiteEscribir = False
        End If
        
        If ((oPagoParcial Or EstaPagando) And GRILLA.ColSel = Col_Tir) Then
            bPermiteEscribir = False
        End If
        
        If GRILLA.TextMatrix(GRILLA.RowSel, COL_Serie) = "" Then
            bPermiteEscribir = False
        End If

        If bPermiteEscribir = True Then
            
            Call PROC_POSI_TEXTO(GRILLA, TxtIngreso)
         
            TxtIngreso.text = CDbl(GRILLA.TextMatrix(GRILLA.RowSel, GRILLA.ColSel))
            TxtIngreso.SelLength = Len(TxtIngreso.text)
        
            Let TxtIngreso.Visible = True
            Let TxtIngreso.text = GRILLA.TextMatrix(GRILLA.RowSel, GRILLA.ColSel)
            Let GRILLA.Enabled = False
            Let Toolbar1.Enabled = False
            Call TxtIngreso.SetFocus
            
        End If
    End If
        
        
    If KeyCode = vbKeyV Then '->> Genera venta del Documento Seleccionado <<-'
    ' PRD-6005
      Toolbar1.Buttons(5).Enabled = True     'PRD-6010
      If GRILLA.RowSel Then
        If CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)) = 0 Then
           Call MsgBox("No existe nominal disponible.", vbExclamation, App.Title)
           Let Me.MousePointer = vbDefault
           Exit Sub
        Else
           If TomarPapel Then
               Call Valorizacion_Pactos(vbKeyV)
               TxtTotal.text = VENTA_SumarTotal() 'PRD-6006 CASS 28-12-2010
           End If
        End If
      End If
      ' PRD-6005
    End If
        
        
    If KeyCode = vbKeyR Then   '->> Genera la Restauración del Documento Seleccionado <<-'
    
'        PRD-6006 CASS 28-12-2010
'        Let GrillaSoma.Rows = 1
'
'        If GrillaSoma.Rows > GrillaSoma.FixedRows Then
'            Let GrillaSoma.Rows = 1
'            GridFolioSOMA.Clear
'            Let GridFolioSOMA.Rows = 1
'          ' Let grilla.Rows = 1
'          ' PRD-6010
'          ' Call SoltarTodos
'          ' Let grilla.Col = nColumna
'            Let Me.MousePointer = vbDefault
'            Exit Sub
'        End If
        
        Call SoltarPapel
        
        TxtTotal.text = VENTA_SumarTotal() 'PRD-6006 CASS 28-12-2010
        
        Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)), FDec4Dec)
        Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Tir) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Tir_ORIG)), FDec4Dec)
        Let GRILLA.TextMatrix(GRILLA.RowSel, Col_VPar) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_VPar_ORIG)), FDec4Dec)
        Let GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT_ORIG)), FDec0Dec)
        Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen_ORIG)), FDec4Dec)
        Let GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial_ORIG)), FDec0Dec)
    End If
        
    Let GRILLA.Col = nColumna
    Let Me.MousePointer = vbDefault
    
End Sub

' Sub Graba()
'
'    If Not Proc_Valida_Tasa_Transferencia(CDbl(TxtTasa.Text), CDbl(Txt_TasaTran.Text)) Then
'        Txt_TasaTran.SetFocus
'        Exit Sub
'    End If
'
'    BacIrfGr.proMoneda = Trim$(Mid$(CmbMon.Text, 1, 3))
'    BacIrfGr.proMtoOper = TxtTotal.Text
'    BacIrfGr.proHwnd = Hwnd
'    BacIrfGr.cCodLibro = BacVI.cCodLibro
'    BacIrfGr.cCodCartFin = BacVI.cCodCartFin
'
'    TxtFecVct_LostFocus
'
'    BacIrfGr.oValorDVP = "glBacCpDvpVi"
'    BacIrfGr.oDVP = glBacCpDvpVi
'    'Call BacGrabarTX
'    Call BacGrabaPacto
'
'    BacControlWindows 100
'
'    If Grabacion_Operacion Then
'        FiltraVentaAutomatico = True
'        giAceptar = True
'        Call TipoFiltro
'        Me.Tag = "VI"
'        Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_20400", "01", "Graba Ventas Con Pacto", "", "", " ")
'    End If
'
'End Sub

Private Function GrabarPactos()
    
    Dim nNumOperacion               As Long
    Dim nContador                   As Long
    Dim objdatosoperacion           As New colOperaciones
    Dim Datos()
   
    Let Me.MousePointer = vbHourglass
    
    Call Func_Limpiar_Estr_Grabar
    
    Set BacFrmIRF = BacTrader.ActiveForm
    Let BacFrmIRF.Tag = "VI"
    Let BacGrabar.TipOper = "VI"
    Let BacGrabar.mFCIC = IIf(CHK_FCIC.Value = True, "S", "N")
    
''''PRD-6006 CASS 09-12-2010
    If Not Proc_Valida_Tasa_Transferencia(CDbl(TxtTasa.text), CDbl(Txt_TasaTran.text)) Then
        Txt_TasaTran.SetFocus
        Exit Function
    End If

    BacIrfGr.proMoneda = Trim$(Mid$(CmbMon.text, 1, 3))
    BacIrfGr.proMtoOper = TxtTotal.text
    BacIrfGr.proHwnd = hWnd
    BacIrfGr.cCodLibro = Frm_Vtas_con_Pcto.cCodLibro
    BacIrfGr.cCodCartFin = Frm_Vtas_con_Pcto.cCodCartFin

    '****** 20181227.RCH.LCGP
    If Me.CHK_BCCH.Value = True Then
        BacIrfGrSinDVP.LCGP_Cliente = gsBac_RutBCCH
    Else
        BacIrfGrSinDVP.LCGP_Cliente = ""
    End If
    '****** 20181227.RCH.LCGP

    TxtFecVct_LostFocus

    BacIrfGr.oValorDVP = "glBacCpDvpVi"
    BacIrfGr.oDVP = glBacCpDvpVi

    Call BacGrabaPacto  '''CASS PRD-6006
    
'   'Call BacGrabarTX
    
    Let nFolioSOMA = TxtFolioSoma.text   'PRD-6010
    
'    BacControlWindows 100
'    Call BacIrfGr.Show(vbModal)
    
      ''    If giAceptar Then
      ''        objdatosoperacion.Rutcart = BacGrabar.Rutcart
      ''        objdatosoperacion.DigCart = BacGrabar.DigCart
      ''        objdatosoperacion.TipCart = BacGrabar.TipCart
      ''        objdatosoperacion.ForPagoIni = BacGrabar.ForPagoIni
      ''        objdatosoperacion.ForPagoVcto = BacGrabar.ForPagoVcto
      ''        objdatosoperacion.VamosVienen = BacGrabar.VamosVienen
      ''        objdatosoperacion.RutCliente = BacGrabar.RutCliente
      ''        objdatosoperacion.NomCliente = BacGrabar.NomCliente
      ''        objdatosoperacion.CodCliente = BacGrabar.CodCliente
      ''        objdatosoperacion.Observ = BacGrabar.Observ
      ''        objdatosoperacion.Mercado = BacGrabar.Mercado
      ''        objdatosoperacion.Sucursal = BacGrabar.Sucursal
      ''        objdatosoperacion.AreaResponsable = BacGrabar.AreaResponsable
      ''        objdatosoperacion.Fecha_PagoMañana = BacGrabar.Fecha_PagoMañana
      ''        objdatosoperacion.Laminas = BacGrabar.Laminas
      ''        objdatosoperacion.Tipo_Inversion = BacGrabar.Tipo_Inversion
      ''        objdatosoperacion.CtaCteInicio = BacGrabar.CtaCteInicio
      ''        objdatosoperacion.SucInicio = BacGrabar.SucInicio
      ''        objdatosoperacion.CtaCteFinal = BacGrabar.CtaCteFinal
      ''        objdatosoperacion.SucFinal = BacGrabar.SucFinal
      ''        objdatosoperacion.costoFondoOperacionesOr = BacGrabar.costoFondoOrigen
      ''        objdatosoperacion.costoFondoOperacionesFi = BacGrabar.costoFondoFinal
      ''        objdatosoperacion.CodOrigen = BacGrabar.CodOrigen
      ''        objdatosoperacion.CodDestino = BacGrabar.CodDestino
      ''        objdatosoperacion.CodEjecutivo = BacGrabar.CodEjecutivo
      ''        objdatosoperacion.Observ = BacGrabar.Observ
      ''        objdatosoperacion.custodia = BacGrabar.custodia
      ''
      ''        If Not BacBeginTransaction Then
      ''            Let Me.MousePointer = vbDefault
      ''            Exit Function
      ''        End If
      ''
      ''        If Not Bac_Sql_Execute("SP_OPMDAC") Then
      ''            Let Me.MousePointer = vbDefault
      ''            Call MsgBox("Se ha generado un error al intentar leer el correlativo de operación.", vbExclamation, App.Title)
      ''            Exit Function
      ''        End If
      ''
      ''        If Bac_SQL_Fetch(Datos()) Then
      ''            nNumOperacion = Val(Datos(1))
      ''        End If
      ''
      ''        For nContador = 1 To Me.GrillaGrabarPctos.Rows - 1
      ''
      ''            cSql = "EXECUTE dbo.Sp_Grabarfli_6007_6010 "
      ''            cSql = cSql & nNumOperacion & ","                                           '--> 01
      ''            cSql = cSql & objdatosoperacion.Rutcart & ","                               '--> 02
      ''            cSql = cSql & Val(objdatosoperacion.TipCart) & ","                          '--> 03
      ''            cSql = cSql & GrillaGrabarPctos.TextMatrix(nContador, 0) & ","                '--> 04
      ''            cSql = cSql & GrillaGrabarPctos.TextMatrix(nContador, 1) & ","                '--> 05
      ''            cSql = cSql & BacMontoFli(GrillaGrabarPctos.TextMatrix(nContador, 2)) & ","   '--> 06
      ''            cSql = cSql & BacMontoFli(GrillaGrabarPctos.TextMatrix(nContador, 3)) & ","   '--> 07
      ''            cSql = cSql & BacMontoFli(GrillaGrabarPctos.TextMatrix(nContador, 4)) & ","   '--> 08
      ''            cSql = cSql & BacMontoFli(GrillaGrabarPctos.TextMatrix(nContador, 5)) & ","   '--> 09
      ''            cSql = cSql & 0 & ","                                                       '--> 10
      ''            cSql = cSql & BacMontoFli(GrillaGrabarPctos.TextMatrix(nContador, 7)) & ","   '--> 11
      ''            cSql = cSql & BacMontoFli(GrillaGrabarPctos.TextMatrix(nContador, 8)) & ","   '--> 12
      ''            cSql = cSql & GrillaGrabarPctos.TextMatrix(nContador, 9) & ","                '--> 13
      ''            cSql = cSql & objdatosoperacion.RutCliente & ","                            '--> 14
      ''            cSql = cSql & objdatosoperacion.CodCliente & ","                            '--> 15
      ''            cSql = cSql & "'" & objdatosoperacion.custodia & "',"                       '--> 16 Custodia
      ''            cSql = cSql & objdatosoperacion.ForPagoIni & ","                            '--> 17
      ''            cSql = cSql & objdatosoperacion.ForPagoVcto & ","                           '--> 18
      ''            cSql = cSql & "'" & objdatosoperacion.VamosVienen & "',"                    '--> 19
      ''            cSql = cSql & "'" & gsBac_User & "',"                                       '--> 20
      ''            cSql = cSql & "'" & gsBac_Term & "',"                                       '--> 21
      ''            cSql = cSql & "'" & Format(TxtFecIni.Text, "yyyymmdd") & "',"               '--> 22
      ''            cSql = cSql & 999 & ","                                                     '--> 23
      ''            cSql = cSql & 0 & ","                                                       '--> 24
      ''            cSql = cSql & 0 & ","                                                       '--> 25
      ''            cSql = cSql & BacMontoFli(GrillaGrabarPctos.TextMatrix(nContador, 24)) & ","  '--> 26
      ''            cSql = cSql & BacMontoFli(GrillaGrabarPctos.TextMatrix(nContador, 24)) & ","  '--> 27
      ''            cSql = cSql & "'" & GrillaGrabarPctos.TextMatrix(nContador, 10) & "',"        '--> 28
      ''            cSql = cSql & GrillaGrabarPctos.TextMatrix(nContador, 11) & ","               '--> 29
      ''            cSql = cSql & GrillaGrabarPctos.TextMatrix(nContador, 12) & ","               '--> 30
      ''            cSql = cSql & "'" & GrillaGrabarPctos.TextMatrix(nContador, 13) & "',"        '--> 31
      ''            cSql = cSql & "'" & GrillaGrabarPctos.TextMatrix(nContador, 14) & "',"        '--> 32
      ''            cSql = cSql & nContador & ","                                               '--> 33
      ''            cSql = cSql & "'" & GrillaGrabarPctos.TextMatrix(nContador, 15) & "',"        '--> 34
      ''            cSql = cSql & BacMontoFli(GrillaGrabarPctos.TextMatrix(nContador, 16)) & ","  '--> 35
      ''            cSql = cSql & BacMontoFli(GrillaGrabarPctos.TextMatrix(nContador, 17)) & ","  '--> 36
      ''            cSql = cSql & BacMontoFli(GrillaGrabarPctos.TextMatrix(nContador, 18)) & ","  '--> 37
      ''            cSql = cSql & "'" & GrillaGrabarPctos.TextMatrix(nContador, 19) & "',"        '--> 38
      ''            cSql = cSql & "'" & GrillaGrabarPctos.TextMatrix(nContador, 20) & "',"        '--> 39
      ''            cSql = cSql & BacMontoFli(GrillaGrabarPctos.TextMatrix(nContador, 23)) & ","  '--> 40
      ''            cSql = cSql & BacMontoFli(GrillaGrabarPctos.TextMatrix(nContador, 24)) & ","  '--> 41
      ''            cSql = cSql & "'" & GrillaGrabarPctos.TextMatrix(nContador, 21) & "',"        '--> 42
      ''            cSql = cSql & "'" & objdatosoperacion.TipCart & "',"                        '--> 43
      ''            cSql = cSql & "'" & objdatosoperacion.Mercado & "',"                        '--> 44
      ''            cSql = cSql & "'" & objdatosoperacion.Sucursal & "',"                       '--> 45
      ''            cSql = cSql & "'" & objdatosoperacion.AreaResponsable & "',"                '--> 46
      ''            cSql = cSql & "'" & Format(objdatosoperacion.Fecha_PagoMañana, feFECHA) & "'," '--> 47
      ''            cSql = cSql & "'" & objdatosoperacion.Laminas & "',"                        '--> 48
      ''            cSql = cSql & "'" & objdatosoperacion.Tipo_Inversion & "',"                 '--> 49
      ''            cSql = cSql & "'" & objdatosoperacion.CtaCteInicio & "',"                   '--> 50
      ''            cSql = cSql & "'" & objdatosoperacion.SucInicio & "',"                      '--> 51
      ''            cSql = cSql & "'" & objdatosoperacion.CtaCteFinal & "',"                    '--> 52
      ''            cSql = cSql & "'" & objdatosoperacion.SucFinal & "',"                       '--> 53
      ''            cSql = cSql & "'" & objdatosoperacion.Observ & "',"                         '--> 54
      ''            cSql = cSql & GrillaGrabarPctos.TextMatrix(nContador, 22) & ","               '--> 55
      ''            cSql = cSql & BacMontoFli(GrillaGrabarPctos.TextMatrix(nContador, 23)) & ","  '--> 56
      ''            cSql = cSql & BacMontoFli(GrillaGrabarPctos.TextMatrix(nContador, 24)) & ","  '--> 57
      ''
      ''            'Ojo que los pactos no usan SOMA
      ''            If GrillaSoma.Rows > GrillaSoma.FixedRows Then
      ''                Dim nNumeroSOMA   As Long
      ''                Let nNumeroSOMA = LeeCorrelativoSOMA
      ''
      ''                cSql = cSql & nNumeroSOMA & ","                                         '--> 58
      ''                cSql = cSql & nNumeroSOMA & ","                                         '--> 59
      ''
      ''
      ''            Else
      ''                cSql = cSql & 0 & ","                                                   '--> 58
      ''                cSql = cSql & 0 & ","                                                   '--> 59
      ''            End If
      ''             cSql = cSql & BacMontoFli(GrillaGrabarPctos.TextMatrix(nContador, 26)) & "," '--> 60  PRD-6007
      ''             cSql = cSql & "'" & "FLI" & "',"                 '--> 61  PRD-6007
      ''             If CheckFolioSOMAManual.Value = 1 Then
      ''                cSql = cSql & nFolioSOMA & ","                '--> 62  PRD-6010
      ''                cSql = cSql & TraeCorrelativoBCCH(nFolioSOMA) '--> 63  PRD-6010
      ''             Else
      ''                cSql = cSql & GrillaGrabarPctos.TextMatrix(nContador, 27) & "," '--> 62  PRD-6010
      ''                cSql = cSql & GrillaGrabarPctos.TextMatrix(nContador, 28) & "," '--> 63  PRD-6010
      ''             End If
      ''                cSql = cSql & CheckFolioSOMAManual.Value & ","                '-->     PRD-6010
      ''                cSql = cSql & "'" & cNombreArchivo & "'"                      '-->     PRD-6010
      ''
      ''
      ''
      ''            If miSQL.SQL_Execute(cSql) <> 0 Then
      ''                Let Me.MousePointer = vbDefault
      ''                Call BacRollBackTransaction
      ''                Call MsgBox("Se ha producido un error en la Grabacion de la Operación.", vbCritical, App.Title)
      ''                Exit Function
      ''            End If
      ''
      ''
      ''         Envia = Array()
      ''         AddParam Envia, objdatosoperacion.Rutcart
      ''         AddParam Envia, CDbl(GrillaGrabarPctos.TextMatrix(nContador, 0))    '--> Documento
      ''         AddParam Envia, CDbl(GrillaGrabarPctos.TextMatrix(nContador, 1))    '--> Correlativo
      ''         AddParam Envia, MihWnd                                            '--> Ventana
      ''         AddParam Envia, gsBac_User                                        '--> Usuario
      ''         AddParam Envia, nNumOperacion
      ''         If Not Bac_Sql_Execute("SP_GRABACORTES_FLI", Envia) Then
      ''            Let Me.MousePointer = vbDefault
      ''            Call BacRollBackTransaction
      ''            Call MsgBox("Se ha producido un error en la Grabacion de los cortes.", vbCritical, App.Title)
      ''            Exit Function
      ''         End If
      ''
      ''         If gsBac_Lineas = "S" Then
      ''            Envia = Array()
      ''            AddParam Envia, nNumOperacion
      ''            AddParam Envia, CDbl(GrillaGrabarPctos.TextMatrix(nContador, 0))
      ''            AddParam Envia, CDbl(GrillaGrabarPctos.TextMatrix(nContador, 1))
      ''            AddParam Envia, nContador
      ''            AddParam Envia, objdatosoperacion.RutCliente
      ''            AddParam Envia, objdatosoperacion.CodCliente
      ''            AddParam Envia, gsBac_User
      ''            AddParam Envia, gsBac_Fecp
      ''            AddParam Envia, Format(TxtFecIni.Text, "yyyymmdd")
      ''            AddParam Envia, CDbl(GrillaGrabarPctos.TextMatrix(nContador, 5))
      ''            If Not Bac_Sql_Execute("Sp_Lineas_FLI", Envia) Then
      ''               Let Me.MousePointer = vbDefault
      ''               Call BacRollBackTransaction
      ''               Call MsgBox("Se ha producido un error en la Grabacion de Líneas para el FLI.", vbCritical, App.Title)
      ''               Exit Function
      ''            End If
      ''         End If
      ''
      ''      Next nContador
      ''
      '''-- >   GRABACION GENERAL DEL FLI
      ''' -------------------------------------- < --
      ''    Call GrabaGeneral_Fli(nNumOperacion, "FLI", Str(Me.txtVenPMP.Text), 0)
      '''-- >
      ''
      ''      If Not BacCommitTransaction Then
      ''         Let Me.MousePointer = vbDefault
      ''         Call MsgBox("Se ha producido un error al confirmar la operación FLI.", vbCritical, App.Title)
      ''      End If
      ''
      ''      Let Me.MousePointer = vbDefault
      ''      Call MsgBox("Operación fue grabada con éxito " & vbCrLf & vbCrLf & "Número de Operación: " & nNumOperacion, vbInformation, App.Title)
      ''
      ''      Call Resumen_Folios_SOMA_Cargados(cNombreArchivo)     'PRD-6010
      ''
      ''      Call LimpiarPantalla
      ''
      ''   End If
    Me.MousePointer = 0
End Function

Private Function LimpiarPantalla()
   Let bDistribucionManual = False
   Call SoltarTodos
   Let GRILLA.Rows = 1
   Let GrillaGrabarPctos.Rows = 1
   Let GrillaSoma.Rows = 1
   Call ActualizaMontoOperacion
   
   Call SettingGridVisible(GRILLA)
   
   Let Toolbar1.Buttons(1).Enabled = False
   Let Toolbar1.Buttons(3).Enabled = True
'   Let Toolbar1.Buttons(10).Enabled = False 20181220.RCH.LCGP
   Let Toolbar1.Buttons(11).Enabled = False
   
End Function

'Private Function LeeCorrelativoSOMA() As Long
'   Dim DATOS()
'
'   Let LeeCorrelativoSOMA = 1
'
'   If Not Bac_Sql_Execute("Sp_Entrega_Correl_Soma") Then
'      Exit Function
'   End If
'   Do While Bac_SQL_Fetch(DATOS())
'      LeeCorrelativoSOMA = IIf(DATOS(1) = 0, 1, DATOS(1))
'   Loop
'End Function

Private Sub CargaGrillaGrabar()
   Dim Datos()
   Dim iContador As Integer
   
   Let GrillaGrabarPctos.Rows = 2: Let GrillaGrabarPctos.cols = 32   'PRD-6006 CASS 10-12-2010
    
   Let GrillaGrabarPctos.TextMatrix(0, ColD_Documento) = "Documento"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_Correlativo) = "Correlativo"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_NominalVenta) = "NominalVenta"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_TirVenta) = "TirVenta"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_PvpVenta) = "PvpVenta"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_ValorVenta) = "ValorVenta"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_TasaEstimada) = "TasaEstimada"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_VParVenta) = "VParVenta"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_NumUltCup) = "NumUltCup"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_InstSer) = "InstSer"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_RutEmisor) = "RutEmisor"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_MonedaEmision) = "MonedaEmision"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_FechaEmision) = "FechaEmision"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_FechaVencimiento) = "FechaVencimiento"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_FecProxCupon) = "FecProxCupon"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_Convexidad) = "Convexidad"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_DurationModificado) = "DurationModificado"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_DurationMacaulay) = "DurationMacaulay"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_icustodia) = "custodia"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_ClaveDcv) = "ClaveDCV"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_CarteraSuper) = "CarteraSuper"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_DiasDisponibles) = "DiasDisponibles"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_Margen) = "Margen"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_ValorInicial) = "ValorInicial"
'   Let GrillaGrabarPctos.TextMatrix(0, ColDet_CarteraSuper) = "CarteraSuper"
   Let GrillaGrabarPctos.TextMatrix(0, ColD_HairCut) = "HairCut"           'PRD-6007
   Let GrillaGrabarPctos.TextMatrix(0, ColD_IDSoma) = "IDSoma"             'PRD-6010
   Let GrillaGrabarPctos.TextMatrix(0, ColD_CorrelaSoma) = "CorrelaSoma"   'PRD-6010
   Let GrillaGrabarPctos.TextMatrix(0, ColD_InCodigo) = "InCodigo"         'PRD-6006 CASS 10-12-2010
   Let GrillaGrabarPctos.TextMatrix(0, ColD_MarcaVta) = "MarcaVta"         'PRD-6006 CASS 10-12-2010
   Let GrillaGrabarPctos.TextMatrix(0, ColD_Libro) = "CodLibro"            'PRD-6006 CASS 10-12-2010
   
   Envia = Array()
   AddParam Envia, gsBac_User
   AddParam Envia, MihWnd
   
   If Not Bac_Sql_Execute("dbo.SP_PREGRABADO_PACTOS", Envia) Then
      Exit Sub
   End If
   
   Let GrillaGrabarPctos.Rows = 1
   
   Do While Bac_SQL_Fetch(Datos())
      Let GrillaGrabarPctos.Rows = GrillaGrabarPctos.Rows + 1
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_Documento) = Datos(1)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_Correlativo) = Datos(2)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_NominalVenta) = Datos(3)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_TirVenta) = Datos(4)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_PvpVenta) = Datos(5)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_ValorVenta) = Datos(6)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_TasaEstimada) = Datos(7)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_VParVenta) = Datos(8)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_NumUltCup) = Datos(9)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_InstSer) = Datos(10)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_RutEmisor) = Datos(11)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_MonedaEmision) = Datos(12)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_FechaEmision) = Format(Datos(13), "YYYYMMDD")
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_FechaVencimiento) = Datos(14)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_FecProxCupon) = Format(Datos(15), "YYYYMMDD")
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_Convexidad) = Datos(16)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_DurationModificado) = Datos(17)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_DurationMacaulay) = Datos(18)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_icustodia) = Datos(19)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_ClaveDcv) = Trim(Datos(20))
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_CarteraSuper) = Datos(21)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_DiasDisponibles) = Datos(22)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_Margen) = Datos(23)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_ValorInicial) = Datos(24)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, 25) = Datos(25)                       '--> "CarteraSuper" VB+- 25/01/2010
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_HairCut) = Datos(26)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_HairCut) = Datos(27)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_CorrelaSoma) = Datos(28)
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_InCodigo) = Datos(29)  'PRD-6006 CASS 10-12-2010
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_MarcaVta) = Datos(30)  'PRD-6006 CASS 10-12-2010
      Let GrillaGrabarPctos.TextMatrix(GrillaGrabarPctos.Rows - 1, ColD_Libro) = Datos(31)     'PRD-6006 CASS 10-12-2010
   Loop

   For iContador = 1 To GrillaGrabarPctos.Rows - 1
       GrillaGrabarPctos.TextMatrix(iContador, ColD_ClaveDcv) = IIf(GrillaGrabarPctos.TextMatrix(iContador, ColD_icustodia) = "D" And GrillaGrabarPctos.TextMatrix(iContador, ColD_ClaveDcv) = "", FUNC_GENERA_CLAVE_DCV, GrillaGrabarPctos.TextMatrix(iContador, ColD_ClaveDcv))
   Next

End Sub


' -------------------------------------------------------------------------------------------
'Private Sub GrabaGeneral_Fli(nNumOperacion As Long, sTipoOperacion As String, dTotalOperacion As Double, iPago As Integer)
'' -------------------------------------------------------------------------------------------
''
''
''
'' ===========================================================================================
'Dim irows As Long
'
'
'    Envia = Array()
'    AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")                    '--> Fecha Operacion
'    AddParam Envia, nNumOperacion                                     '--> Documento
'    AddParam Envia, sTipoOperacion                                    '--> Tipo Operacion
'    AddParam Envia, dTotalOperacion                                   '--> Total Operacion
'    AddParam Envia, iPago                                             '--> Pago
'    AddParam Envia, gsBac_User                                        '--> Usuario
'
'    If Not Bac_Sql_Execute("dbo.sp_graba_fli_general", Envia) Then
'       Let Me.MousePointer = vbDefault
'       Call BacRollBackTransaction
'       Call MsgBox("Se ha producido un error en la Grabacion general del FLI.", vbCritical, App.Title)
'       Exit Sub
'    End If
'
'
'    For irows = 1 To GRILLA.Rows - 1
'        If GRILLA.TextMatrix(irows, Col_Marca) <> "" Then
'            cSql = "EXECUTE dbo.sp_graba_papeletaFLI  "
'            cSql = cSql & "'" & Format(gsBac_Fecp, "yyyymmdd") & "',"
'            cSql = cSql & nNumOperacion & ",0,"
'            cSql = cSql & "'" & GRILLA.TextMatrix(irows, COL_Serie) & "',"
'            cSql = cSql & Str(GRILLA.TextMatrix(irows, Col_Nominal)) & ","
'            cSql = cSql & Str(GRILLA.TextMatrix(irows, Col_Tir)) & ","
'            cSql = cSql & Str(GRILLA.TextMatrix(irows, Col_MT)) & ","
'            cSql = cSql & Str(GRILLA.TextMatrix(irows, Col_Margen)) & ","
'            cSql = cSql & Str(GRILLA.TextMatrix(irows, Col_ValInicial)) & ","
'            cSql = cSql & "'" & GRILLA.TextMatrix(irows, Col_CodCarteraSuper) & "'" ' VB+-25/01/2010
'
''            Envia = Array()
''            AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")                    '--> Fecha Operacion
''            AddParam Envia, nNumOperacion                                     '--> Documento
''            AddParam Envia, 0
''            AddParam Envia, grilla.TextMatrix(irows, COL_Serie)
''            AddParam Envia, Str(grilla.TextMatrix(irows, Col_Nominal))
''            AddParam Envia, Str(grilla.TextMatrix(irows, Col_Tir))
''            AddParam Envia, Str(grilla.TextMatrix(irows, Col_MT))
''            AddParam Envia, Str(grilla.TextMatrix(irows, Col_Margen))
''            AddParam Envia, Str(grilla.TextMatrix(irows, Col_ValInicial))
''            AddParam Envia, grilla.TextMatrix(irows, Col_CodCarteraSuper) ' VB+-25/01/2010
''            If Not Bac_Sql_Execute("dbo.sp_graba_papeletaFLI", Envia) Then
'             If miSQL.SQL_Execute(cSql) <> 0 Then
'               Let Me.MousePointer = vbDefault
'               Call BacRollBackTransaction
'               Call MsgBox("Se ha producido un error en la Grabacion general del FLI.", vbCritical, App.Title)
'               Exit Sub
'            End If
'
'        End If
'
'    Next irows
'
'
'End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    
    Dim dNumdocu As Long
    Dim Datos()

    Select Case Button.Index
        Case 1
        
            If CDbl(TxtTasa.text) = 0 Then
               MsgBox "Falta Tasa del Pacto.", 16
               Exit Sub
            End If

            If EstaPagando = False Then
            
                If Not Chequea_Parametros(ACSW_PD, varGsMsgPD, 0) Then
                    Exit Sub
                End If
                
                If ValidaPapelesaGrabar = False Then
                    Exit Sub
                End If
   
                Call CargaGrillaGrabar
                
                Call GrabarPactos
                
'               Call GrabarFli

            End If
            
         
'          ' _________________________________________________
'          ' se realiza el pago del FLI
'          ' =================================================
'            If EstaPagando = True Then
'
'                If MsgBox("¿Esta seguro de grabar la transaccion de pago Parcial?", vbQuestion + vbYesNo + vbDefaultButton2, "Pago Parcial Fli") = vbNo Then
'                    Exit Sub
'                End If
'                BacControlWindows 100
'                If oPagoParcial = True Then
'
'                    If CDbl(IIf(Me.txtdiferencia.Text = "", 0, Me.txtdiferencia.Text)) < 0 Then
'                        Call MsgBox("la transaccion presenta saldo negativo, favor revisar datos ingresados", vbExclamation, App.Title)
'                        Exit Sub
'                    End If
'
'                    If Not ValidaPapelesaGrabarPAGOS Then
'                        Exit Sub
'                    End If
'                    If Me.txtdiferencia.Text = 0 Then
'                        Call MsgBox("la transaccion no presenta pagos favor revisar datos ingresados", vbExclamation, App.Title)
'                        Exit Sub
'                    End If
'
'                    If Not validaTOTALSaldoPendiente() Then
'                        Call MsgBox("la transaccion presenta diferencias al pagar contra el saldo, favor revisar datos ingresados", vbExclamation, App.Title)
'                        Exit Sub
'                    End If
'
'                    If Not BacBeginTransaction Then
'                       Call MsgBox("Se ha producido un error en la transaccion para generar los pagos.", vbExclamation, App.Title)
'                       Exit Sub
'                    End If
'
'                    Envia = Array()
'                    AddParam Envia, CDbl(nNumOperFli)
'
'                    If Not Bac_Sql_Execute("SP_BUSCA_NUM_OPER_PAGOS", Envia) Then
'                       Call BacRollBackTransaction
'                       Call MsgBox("Se ha producido un error en la generación de los pagos.", vbExclamation, App.Title)
'                       Exit Sub
'                    End If
'
'                    If Bac_SQL_Fetch(DATOS()) Then
'                       dNumdocu = Val(DATOS(1))
'                    End If
'
'
'                    Envia = Array()
'                    AddParam Envia, nNumOperFli
'                    AddParam Envia, gsBac_User
'                    AddParam Envia, gsBac_Term
'                    AddParam Envia, MihWnd
'                    AddParam Envia, dNumdocu  ' --> Numero de pago

'                    If Not Bac_Sql_Execute("dbo.SP_PAGO_TOTAL_PARCIAL_FLI", Envia) Then
'                        Call BacRollBackTransaction
'                        Call MsgBox("Se ha producido un error en la generación de los pagos.", vbExclamation, App.Title)
'                        Exit Sub
'                    End If

'                    Envia = Array()
'                    AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")                       '--> Fecha Operacion
'                    AddParam Envia, nNumOperFli                                          '--> Documento
'                    AddParam Envia, "FLIP"                                               '--> Tipo Operacion
'                    AddParam Envia, Str(Me.txtdiferencia.Text)                           '--> Total Operacion
'                    AddParam Envia, dNumdocu                                             '--> Pago
'                    AddParam Envia, gsBac_User                                           '--> Usuario

'                    If Not Bac_Sql_Execute("dbo.sp_graba_fli_general", Envia) Then
'                        Let Me.MousePointer = vbDefault
'                        Call BacRollBackTransaction
'                        Call MsgBox("Se ha producido un error en la Grabacion general del FLI.", vbCritical, App.Title)
'                        Exit Sub
'                    End If

'                    Dim irows As Long
'
'                    For irows = 1 To Grilla.Rows - 1
'
'                        If Grilla.TextMatrix(irows, Col_Marca) <> "V" Then
'                            cSql = ""
'                            cSql = cSql & "EXECUTE dbo.sp_graba_papeletaFLI "
'                            cSql = cSql & "'" & Format(gsBac_Fecp, "yyyymmdd") & "',"
'                            cSql = cSql & nNumOperFli & ","
'                            cSql = cSql & dNumdocu & ","
'                            cSql = cSql & "'" & Grilla.TextMatrix(irows, COL_Serie) & "',"
'
'                          '  Envia = Array()
'                          '  AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")                    '--> Fecha Operacion
'                          '  AddParam Envia, nNumOperFli                                     '--> Documento
'                          '  AddParam Envia, dNumdocu
'                          '  AddParam Envia, grilla.TextMatrix(irows, COL_Serie)
'                            If Grilla.TextMatrix(irows, Col_Marca) = "P" Then
'                              '  AddParam Envia, Str(grilla.TextMatrix(irows, Col_Nominal_ORIG) - grilla.TextMatrix(irows, Col_Nominal))
'                                cSql = cSql & Str(Grilla.TextMatrix(irows, Col_Nominal_ORIG) - Grilla.TextMatrix(irows, Col_Nominal)) & ","
'                            Else
'                            '  AddParam Envia, Str(grilla.TextMatrix(irows, Col_Nominal_ORIG))
'                                cSql = cSql & Str(Grilla.TextMatrix(irows, Col_Nominal_ORIG)) & ","
'                            End If
'
'                          ' AddParam Envia, Str(grilla.TextMatrix(irows, Col_Tir))
'                            cSql = cSql & Str(Grilla.TextMatrix(irows, Col_Tir)) & ","
'
'                            If Grilla.TextMatrix(irows, Col_Marca) = "P" Then
'                              ' AddParam Envia, Str(grilla.TextMatrix(irows, Col_MT_ORIG) - grilla.TextMatrix(irows, Col_MT))
'                                cSql = cSql & Str(Grilla.TextMatrix(irows, Col_MT_ORIG) - Grilla.TextMatrix(irows, Col_MT)) & ","
'                            Else
'                              ' AddParam Envia, Str(grilla.TextMatrix(irows, Col_MT_ORIG))
'                                cSql = cSql & Str(Grilla.TextMatrix(irows, Col_MT_ORIG)) & ","
'                            End If
'
'                          ' AddParam Envia, Str(grilla.TextMatrix(irows, Col_Margen))
'                            cSql = cSql & Str(Grilla.TextMatrix(irows, Col_Margen)) & ","
'
'                            If Grilla.TextMatrix(irows, Col_Marca) = "P" Then
'                              ' AddParam Envia, Str(grilla.TextMatrix(irows, Col_ValInicial_ORIG) - grilla.TextMatrix(irows, Col_ValInicial))
'                                cSql = cSql & Str(Grilla.TextMatrix(irows, Col_ValInicial_ORIG) - Grilla.TextMatrix(irows, Col_ValInicial)) & ","
'                            Else
'                               ' AddParam Envia, Str(grilla.TextMatrix(irows, Col_ValInicial_ORIG))
'                                cSql = cSql & Str(Grilla.TextMatrix(irows, Col_ValInicial_ORIG)) & ","
'                            End If
'
'                          ' AddParam Envia, grilla.TextMatrix(irows, Col_CodCarteraSuper)
'                            cSql = cSql & "'" & Grilla.TextMatrix(irows, Col_CodCarteraSuper) & "'"
'                            If miSQL.SQL_Execute(cSql) <> 0 Then
'                           ' If Not Bac_Sql_Execute("dbo.sp_graba_papeletaFLI", Envia) Then
'                               Let Me.MousePointer = vbDefault
'                               Call BacRollBackTransaction
'                               Call MsgBox("Se ha producido un error en la Grabacion general del FLI.", vbCritical, App.Title)
'                               Exit Sub
'                            End If
'                        End If
'                    Next irows
'
'                    If Not BacCommitTransaction Then
'                        Call MsgBox("Se ha producido un error en la confirmación de los pagos.", vbExclamation, App.Title)
'                        Exit Sub
'                    End If
'
'                    Call MsgBox("Se ha generado correctamente el pago de la Operacion: " & gsNmoper_Fli, vbInformation, App.Title)
'
'                    Let EstaPagando = False
'                    Call LimpiarPantalla
'                End If
'            End If
'
        Case 3
            Call Filtrar
            Me.Label(8).Caption = "Monto Pago"
            Me.Label(0).Caption = "Monto Saldo"
            Let nNumOperFli = 0
            Let EstaPagando = False
            Let oPagoParcial = False
            Let Toolbar1.Buttons(1).Enabled = True
            

        Case 4
        
'            Me.Label(0).Caption = "Monto Pago"
'            Me.Label(8).Caption = "Monto Saldo"
'
'            Call Modificacion_Pago_Fli
'
'            Let Toolbar1.Buttons(1).Enabled = True
'
'            If Grilla.Rows > 2 Then
'
'                If Grilla.TextMatrix(1, 2) <> "" Then
'                    Let Toolbar1.Buttons(3).Enabled = True
'                Else
'                    Let Toolbar1.Buttons(3).Enabled = True
'                End If
'            End If
            
'PRD-6010
        Case 5
            Call SeleccionVentas
'PRD-6010
            
        Case 10
            carga = 1
            If Me.Combo_Doc.ListIndex < 1 Then
               MsgBox ("Debe Seleccionar tipo de operacion"), vbInformation, TITSISTEMA
               Exit Sub
            End If

'            Let Toolbar1.Buttons(10).Enabled = False  20181220.RCH.LCGP
            Let Command1.Enabled = False
            Let PicProgree.Visible = True
            Let Progreso.Max = 50
            Let Progreso.Value = 0
            Let LblProgreso.Caption = "Cargando Archivo...  " & Trim(Progreso.Value) & " %"
            
            Call BacControlWindows(10)
            Call Me.Refresh
            ''Call LoadFile_Soma
            Call LimpiaGrillaErroresSOMA
            FRM_Archivo_REPO.Show (vbModal)
            If bCargaArchivo Then
                SeleccionVentas
            End If
'        Case 11
'            Call Imprimir_Informe_Errores_SOMA

        Case 12 ''REQ.6006
            
            If GRILLA.TextMatrix(GRILLA.RowSel, Col_Marca) <> "P" Then
               MsgBox "Advertencia: Solo Venta Parcial permite redistribuir cortes."
               'Exit Sub  'MAP 6006 Intervención bajo prueba interna
            End If
            
           If GRILLA.Rows > 1 Then
           
                nMarca = GRILLA.TextMatrix(GRILLA.RowSel, 0)
                nSerie = GRILLA.TextMatrix(GRILLA.RowSel, 1)
                dTasaRef = GRILLA.TextMatrix(GRILLA.RowSel, 4)
                sCarteraNorm = GRILLA.TextMatrix(GRILLA.RowSel, 10)
                dNominal = GRILLA.TextMatrix(GRILLA.RowSel, 3)
                sCarteraNormCod = GRILLA.TextMatrix(GRILLA.RowSel, 19)
                dRutEmisor = GRILLA.TextMatrix(GRILLA.RowSel, Col_Emisor)
                'Call BacFrmDet.Show(vbModal)
                 Call BacPctoDet.Show(vbModal) 'PRD-6006 CASS 24-12-2010
            Else
                nMarca = ""
                nSerie = ""
                dTasaRef = 0#
                sCarteraNorm = ""
                dNominal = 0#
                sCarteraNormCod = ""
                dRutEmisor = 0
                'Call BacFrmDet.Show(vbModal)
                 Call BacPctoDet.Show(vbModal) 'PRD-6006 CASS 24-12-2010

            End If
            
        Case 13
            Call Unload(Me)

    End Select
    
End Sub

'Private Function ControlOperativo(ByVal xTipo As String, ByVal nOperacion As Long) As Boolean
'   Dim DATOS()
'
'   Let ControlOperativo = False
'
'   Envia = Array()
'   AddParam Envia, nOperacion
'   AddParam Envia, xTipo
'   If Not Bac_Sql_Execute("dbo.SP_CONTROL_FLI", Envia) Then
'      Exit Function
'   End If
'   If Bac_SQL_Fetch(DATOS()) Then
'      Let ControlOperativo = IIf(DATOS(1) < 0, False, True)
'   End If
'
'   If ControlOperativo = False Then
'      Call MsgBox(DATOS(2), vbExclamation, App.Title)
'   End If
'
'End Function

'Private Function Modificacion_Pago_Fli()
'   Dim DATOS()
'
'    If gsNmoper_Fli <> 0 Then
'        Call SoltarTodos
'    End If
'
'   Let gsNmoper_Fli = 0
'   Let oPagoParcial = False
'   Let Tipo_Pago_total = False
'
'   Let BacMod.SSOption1.Visible = False
'   Call BacMod.Show(vbModal)
'
'   Let oPagoParcial = Tipo_Pago_parcial
'
'
'
'   If oPagoParcial = False And Tipo_Pago_total = False Then
'      Let EstaPagando = False
'   Else
'      Let EstaPagando = True
'   End If
'
'   If Tipo_Pago_total = True Then
'      Let nNumOperFli = gsNmoper_Fli
'      Let EstaPagando = True
'
'      If Not ControlOperativo("T", nNumOperFli) Then
'         Exit Function
'      End If
'
'      Envia = Array()
'      AddParam Envia, CDbl(nNumOperFli)
'      AddParam Envia, "T"
'      If Not Bac_Sql_Execute("SVC_CMP_NUM_OPR", Envia) Then
'         Exit Function
'      End If
'      If Bac_SQL_Fetch(DATOS()) Then
'         If DATOS(1) <> 0 Then
'            Exit Function
'         End If
'      End If
'
'      If Not BacBeginTransaction Then
'         Call MsgBox("Se ha producido un error en la transaccion para generar los pagos.", vbExclamation, App.Title)
'         Exit Function
'      End If
'
'      Envia = Array()
'      AddParam Envia, nNumOperFli
'      AddParam Envia, gsBac_User
'      AddParam Envia, gsBac_Term
'      AddParam Envia, MihWnd
'
'      If Not Bac_Sql_Execute("dbo.SP_PAGO_TOTAL_FLI", Envia) Then
'         Call BacRollBackTransaction
'         Call MsgBox("Se ha producido un error en la generación de los pagos.", vbExclamation, App.Title)
'         Exit Function
'      End If
'
'      If Not BacCommitTransaction Then
'         Call MsgBox("Se ha producido un error en la confirmación de los pagos.", vbExclamation, App.Title)
'         Exit Function
'      End If
'
'      Call MsgBox("Se ha generado correctamente el pago de la Operacion: " & gsNmoper_Fli, vbInformation, App.Title)
'      Call LimpiarPantalla
'   End If
'
'   If EstaPagando = False Then
'      Exit Function
'   End If
'
'   If Tipo_Pago_parcial = True Then
'      Let nNumOperFli = gsNmoper_Fli
'      Let oPagoParcial = True
'      Let EstaPagando = True
'
'      Envia = Array()
'      AddParam Envia, nNumOperFli
'      AddParam Envia, gsBac_User
'      AddParam Envia, MihWnd
'
'      If Not Bac_Sql_Execute("dbo.SP_FILTRO_FLI_PPARCIAL", Envia) Then
'         Let Screen.MousePointer = vbDefault
'         Call MsgBox("Se ha originado un error en la lectura de operaciones." & vbCrLf & vbCrLf & VerSql, vbExclamation, App.Title)
'         Exit Function
'      End If
'
'      Let GRILLA.Rows = 1
'
'      Do While Bac_SQL_Fetch(DATOS())
'         Let GRILLA.Rows = GRILLA.Rows + 1
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Marca) = ""
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, COL_Serie) = DATOS(1)
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Moneda) = DATOS(2)
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Nominal) = Format(DATOS(3), FDec4Dec)
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Tir) = Format(DATOS(4), FDec4Dec)
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_VPar) = Format(DATOS(5), FDec4Dec)
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_MT) = Format(DATOS(6), FDec0Dec)
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_PlzRes) = Format(DATOS(7), FDec0Dec)
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Margen) = Format(DATOS(8), FDec4Dec)
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_ValInicial) = Format(DATOS(9), FDec0Dec)
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Custodia) = "DCV"
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_ClaveDcv) = ""
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_CarteraSuper) = DATOS(10)
'
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Nominal_ORIG) = Format(DATOS(3), FDec4Dec)
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Tir_ORIG) = Format(DATOS(4), FDec4Dec)
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_VPar_ORIG) = Format(DATOS(5), FDec4Dec)
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_MT_ORIG) = Format(DATOS(6), FDec4Dec)
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Margen_ORIG) = Format(DATOS(8), FDec4Dec)
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_ValInicial_ORIG) = Format(DATOS(9), FDec0Dec)
'         Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_CodCarteraSuper) = DATOS(11)
'
'      Loop
'
'      Let Me.MousePointer = vbDefault
'      Call ActualizaMontoPAGO
'
'
'   End If
'
'End Function
'

Private Function Valorizacion_Pactos_REPO_EXCEL(ByVal xTecla As KeyCodeConstants, Optional SW As Boolean)
   Dim nMargen As Double
   Dim Datos()
   Dim sCalculoVInicial As String * 1
   Dim dMontoNominalOriginal As Double
   Dim dMontoPresenteOriginal As Double
   Dim dRespaldoNominal    As Double
   Dim Fila As Integer
   
   With GRILLA
     For Fila = 1 To GRILLA.Rows - 1
       If GRILLA.TextMatrix(Fila, 0) = "P" Then
          GRILLA.RowSel = Fila
          Exit For
       End If
     Next Fila
   End With
   
   'ARM trae haircut y tasa referencial desde mantenedores
   Call carga_haircut
   Call carga_tasaref_soma
   

    If xTecla = vbKeyV Then
        Let nModoCalculo = 3
        Let nFactor = 0
    Else
        If GRILLA.ColSel = Col_Marca Then: Let nModoCalculo = 2
        If GRILLA.ColSel = Col_Nominal Then: Let nModoCalculo = 2
        If GRILLA.ColSel = Col_Tir Then: Let nModoCalculo = 2
        If GRILLA.ColSel = Col_MT Then: Let nModoCalculo = 3
        If GRILLA.ColSel = Col_ValInicial Then: Let nModoCalculo = 4
   
        If nModoCalculo = 3 Then
            If nMontoAnterior = 0 Then
                Let nFactor = 1
            Else
                Let nFactor = (CDbl(TxtIngreso.text) / nMontoAnterior)
            End If
        End If
      
        If nModoCalculo = 4 Then
            If nMontoAnterior = 0 Then
                Let nFactor = 1
            Else
                Let nFactor = Round((TxtIngreso.text / GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), 0)
                Let GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = nFactor
                Let nFactor = nFactor / nMontoAnterior
            End If
        End If
        
    End If

   dRespaldoNominal = GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal)
   
    If nModoCalculo = 3 Then
        If GRILLA.ColSel = Col_MT Then
            Let nMonto = GRILLA.TextMatrix(GRILLA.RowSel, Col_MT)
        End If
        
        If GRILLA.ColSel = Col_ValInicial Then
            If CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)) = 0 Then
                Let nMonto = GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) / 1
            Else
                Let nMonto = Round(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) / GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen), 0)
            ' Let nMonto = grilla.TextMatrix(grilla.RowSel, Col_ValInicial) / grilla.TextMatrix(grilla.RowSel, Col_Margen)
            End If
            
        End If
         
    End If
   
    sCalculoVInicial = "N"
    
    If nModoCalculo = 4 Then
        sCalculoVInicial = "S"
        Let nModoCalculo = 3
    End If
   
    If (oPagoParcial And EstaPagando) Then  '--> Es para asignar todo los papales como calculados
        If xTecla = vbKeyV Then
            sCalculoVInicial = "T"
        ElseIf GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal) = GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG) And GRILLA.ColSel = Col_Nominal Then
            sCalculoVInicial = "T"
        ElseIf GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = GRILLA.TextMatrix(GRILLA.RowSel, Col_MT_ORIG) And GRILLA.ColSel = Col_MT Then
            sCalculoVInicial = "T"
        ElseIf GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) = GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial_ORIG) And GRILLA.ColSel = Col_ValInicial Then
            sCalculoVInicial = "T"
        End If
    End If
  
    If sCalculoVInicial <> "T" Then
        If (oPagoParcial And EstaPagando) Then  '--> Es para asignar todo los papales como calculados

            If GRILLA.ColSel = Col_MT Or GRILLA.ColSel = Col_ValInicial Then
                Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal) = dRespaldoNominal
                'Let grilla.TextMatrix(grilla.RowSel, Col_Nominal) = Round(((grilla.TextMatrix(grilla.RowSel, Col_MT) * Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)) / Grilla.TextMatrix(Grilla.RowSel, Col_MT_ORIG)), 0)
                ' Let grilla.TextMatrix(grilla.RowSel, Col_Nominal) = ((grilla.TextMatrix(grilla.RowSel, Col_MT) * grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)) / Grilla.TextMatrix(Grilla.RowSel, Col_MT_ORIG))
                
            End If
        
        End If
    End If
    
    Let cMascara = GRILLA.TextMatrix(GRILLA.RowSel, COL_Serie)
    Let nNominal = GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal)
    Let nTir = GRILLA.TextMatrix(GRILLA.RowSel, Col_Tir)
    Let nPvp = GRILLA.TextMatrix(GRILLA.RowSel, Col_VPar)
    Let nMonto = GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) * IIf(SW, nFactor, 1)
 '   Let nMargen = GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)
    Let dMontoNominalOriginal = GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)
    Let dMontoPresenteOriginal = GRILLA.TextMatrix(GRILLA.RowSel, Col_MT_ORIG)
    
    
    Let cFecCal = Format(gsBac_Fecp, "yyyymmdd")
    Let nValorInicial = GRILLA.TextMatrix(GRILLA.RowSel, 6)
    Let cUsuario = gsBac_User
    Let nVentana = MihWnd

    Envia = Array()
    AddParam Envia, nModoCalculo
    AddParam Envia, cMascara
    AddParam Envia, nNominal
    AddParam Envia, CDbl(GRILLA.TextMatrix(Fila, Col_Tir)) 'nTir
    AddParam Envia, nPvp
    AddParam Envia, nMonto
    AddParam Envia, cFecCal
    AddParam Envia, nFactor
    AddParam Envia, nValorInicial
    AddParam Envia, cUsuario
    AddParam Envia, nVentana
    
    If GRILLA.ColSel = Col_Nominal And CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)) <> CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal)) And xTecla <> vbKeyV Then
        AddParam Envia, "N"
    Else
        AddParam Envia, IIf(oPagoParcial, "S", "N") '--> Este es nuevo para control de valorizacion
    End If
    
    AddParam Envia, sCalculoVInicial
    
    If oPagoParcial And EstaPagando And GRILLA.ColSel = Col_Nominal Then
        AddParam Envia, "N"
    Else
        AddParam Envia, IIf(oPagoParcial And EstaPagando, "S", "N") '--> Este es el ultimo control para la valorizacion del pago
    End If
    
    AddParam Envia, CDbl(dMontoNominalOriginal)
    AddParam Envia, CDbl(dMontoPresenteOriginal)
    AddParam Envia, GRILLA.TextMatrix(GRILLA.RowSel, Col_CodCarteraSuper)
    AddParam Envia, CDbl(GRILLA.TextMatrix(Fila, Col_HairCut)) 'CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_HairCut))   'PRD-6007 - 6010
    AddParam Envia, CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ID_SOMA)) 'PRD-6010
    AddParam Envia, CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Correla_SOMA))  'PRD-6010
    AddParam Envia, CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Emisor))
    
    'If Not Bac_Sql_Execute("dbo.SP_VALORIZADETALLEFLI_6007_6010", Envia) Then 'PRD-6006 CASS 06-10-2010
    If Not Bac_Sql_Execute("dbo.SP_VALORIZADETALLEPACTOS", Envia) Then
        Call MsgBox("Se ha producido un error en la Valorizacion del instrumento.", vbExclamation, App.Title)
        Call SoltarPapel
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then
    
        If Datos(1) < 0 Then
        
            Call MsgBox(Datos(2), vbExclamation, App.Title)
            Call SoltarPapel
            
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Tir) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Tir_ORIG)), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_VPar) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_VPar_ORIG)), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT_ORIG)), FDec0Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen_ORIG)), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial_ORIG)), FDec0Dec)
            
            On Error Resume Next
            Call GRILLA.SetFocus
            On Error GoTo 0
            
        Else
        
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal) = Format(Datos(2), FDec4Dec)
           ' Let Grilla.TextMatrix(Grilla.RowSel, Col_Tir) = Format(DATOS(3), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_VPar) = Format(Datos(4), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = Format(Datos(5), FDec0Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) = Format(Datos(6), FDec0Dec)
            
            If GRILLA.ColSel = Col_MT Or GRILLA.ColSel = Col_Tir Then
                If Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT)) * CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen_ORIG)), FDec0Dec) <> Format(CDbl(Datos(6)), FDec0Dec) Then
                    Let GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT)) * CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), FDec0Dec)
                End If
            End If
            If GRILLA.ColSel = Col_ValInicial Then
                If Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial)) / CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), FDec0Dec) <> Format(CDbl(Datos(5)), FDec0Dec) Then
                    Let GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial)) / CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), FDec0Dec)
                End If
            End If
            
            
        End If
        
    End If
    
    Call subCOLOREA_Registro
    Call ActualizaMontoOperacion
   

End Function

Private Function Valorizacion_Pactos(ByVal xTecla As KeyCodeConstants, Optional SW As Boolean)
   
   Dim nMargen As Double
   Dim Datos()
   Dim sCalculoVInicial As String * 1
   Dim dMontoNominalOriginal As Double
   Dim dMontoPresenteOriginal As Double
   Dim dRespaldoNominal    As Double

    If xTecla = vbKeyV Then
        Let nModoCalculo = 3
        Let nFactor = 0
    Else
        If GRILLA.ColSel = Col_Marca Then: Let nModoCalculo = 2
        If GRILLA.ColSel = Col_Nominal Then: Let nModoCalculo = 2
        If GRILLA.ColSel = Col_Tir Then: Let nModoCalculo = 2
        If GRILLA.ColSel = Col_MT Then: Let nModoCalculo = 3
        If GRILLA.ColSel = Col_ValInicial Then: Let nModoCalculo = 4
   
        If nModoCalculo = 3 Then
            If nMontoAnterior = 0 Then
                Let nFactor = 1
            Else
                Let nFactor = (CDbl(TxtIngreso.text) / nMontoAnterior)
            End If
        End If
      
        If nModoCalculo = 4 Then
            If nMontoAnterior = 0 Then
                Let nFactor = 1
            Else
                Let nFactor = Round((TxtIngreso.text / GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), 0)
                Let GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = nFactor
                Let nFactor = nFactor / nMontoAnterior
            End If
        End If
        
    End If

   dRespaldoNominal = GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal)
   
    If nModoCalculo = 3 Then
        If GRILLA.ColSel = Col_MT Then
            Let nMonto = GRILLA.TextMatrix(GRILLA.RowSel, Col_MT)
        End If
        
        If GRILLA.ColSel = Col_ValInicial Then
            If CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)) = 0 Then
                Let nMonto = GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) / 1
            Else
                Let nMonto = Round(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) / GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen), 0)
            ' Let nMonto = grilla.TextMatrix(grilla.RowSel, Col_ValInicial) / grilla.TextMatrix(grilla.RowSel, Col_Margen)
            End If
            
        End If
         
    End If
   
    sCalculoVInicial = "N"
    
    If nModoCalculo = 4 Then
        sCalculoVInicial = "S"
        Let nModoCalculo = 3
    End If
   
    If (oPagoParcial And EstaPagando) Then  '--> Es para asignar todo los papales como calculados
        If xTecla = vbKeyV Then
            sCalculoVInicial = "T"
        ElseIf GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal) = GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG) And GRILLA.ColSel = Col_Nominal Then
            sCalculoVInicial = "T"
        ElseIf GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = GRILLA.TextMatrix(GRILLA.RowSel, Col_MT_ORIG) And GRILLA.ColSel = Col_MT Then
            sCalculoVInicial = "T"
        ElseIf GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) = GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial_ORIG) And GRILLA.ColSel = Col_ValInicial Then
            sCalculoVInicial = "T"
        End If
    End If
  
    If sCalculoVInicial <> "T" Then
        If (oPagoParcial And EstaPagando) Then  '--> Es para asignar todo los papales como calculados
        
            If GRILLA.ColSel = Col_MT Or GRILLA.ColSel = Col_ValInicial Then
                Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal) = dRespaldoNominal
                'Let grilla.TextMatrix(grilla.RowSel, Col_Nominal) = Round(((grilla.TextMatrix(grilla.RowSel, Col_MT) * Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)) / Grilla.TextMatrix(Grilla.RowSel, Col_MT_ORIG)), 0)
                ' Let grilla.TextMatrix(grilla.RowSel, Col_Nominal) = ((grilla.TextMatrix(grilla.RowSel, Col_MT) * grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)) / Grilla.TextMatrix(Grilla.RowSel, Col_MT_ORIG))
                
            End If
        
        End If
    End If
    
    Let cMascara = GRILLA.TextMatrix(GRILLA.RowSel, COL_Serie)
    Let nNominal = GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal)
    Let nTir = GRILLA.TextMatrix(GRILLA.RowSel, Col_Tir)
    Let nPvp = GRILLA.TextMatrix(GRILLA.RowSel, Col_VPar)
    Let nMonto = GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) * IIf(SW, nFactor, 1)
    Let nMargen = GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)
    Let dMontoNominalOriginal = GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)
    Let dMontoPresenteOriginal = GRILLA.TextMatrix(GRILLA.RowSel, Col_MT_ORIG)
    
    
    Let cFecCal = Format(gsBac_Fecp, "yyyymmdd")
    Let nValorInicial = GRILLA.TextMatrix(GRILLA.RowSel, 6)
    Let cUsuario = gsBac_User
    Let nVentana = MihWnd

    Envia = Array()
    AddParam Envia, nModoCalculo
    AddParam Envia, cMascara
    AddParam Envia, nNominal
    AddParam Envia, nTir
    AddParam Envia, nPvp
    AddParam Envia, nMonto
    AddParam Envia, cFecCal
    AddParam Envia, nFactor
    AddParam Envia, nValorInicial
    AddParam Envia, cUsuario
    AddParam Envia, nVentana
    
    If GRILLA.ColSel = Col_Nominal And CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)) <> CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal)) And xTecla <> vbKeyV Then
        AddParam Envia, "N"
    Else
        AddParam Envia, IIf(oPagoParcial, "S", "N") '--> Este es nuevo para control de valorizacion
    End If
    
    AddParam Envia, sCalculoVInicial
    
    If oPagoParcial And EstaPagando And GRILLA.ColSel = Col_Nominal Then
        AddParam Envia, "N"
    Else
        AddParam Envia, IIf(oPagoParcial And EstaPagando, "S", "N") '--> Este es el ultimo control para la valorizacion del pago
    End If
    
    AddParam Envia, CDbl(dMontoNominalOriginal)
    AddParam Envia, CDbl(dMontoPresenteOriginal)
    AddParam Envia, GRILLA.TextMatrix(GRILLA.RowSel, Col_CodCarteraSuper)
    AddParam Envia, CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_HairCut))   'PRD-6007 - 6010
    AddParam Envia, CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ID_SOMA)) 'PRD-6010
    AddParam Envia, CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Correla_SOMA))  'PRD-6010
    AddParam Envia, CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Emisor))
    
    'If Not Bac_Sql_Execute("dbo.SP_VALORIZADETALLEFLI_6007_6010", Envia) Then 'PRD-6006 CASS 06-10-2010
    If Not Bac_Sql_Execute("dbo.SP_VALORIZADETALLEPACTOS", Envia) Then
        Call MsgBox("Se ha producido un error en la Valorizacion del instrumento.", vbExclamation, App.Title)
        Call SoltarPapel
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then
    
        If Datos(1) < 0 Then
        
            Call MsgBox(Datos(2), vbExclamation, App.Title)
            Call SoltarPapel
            
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Tir) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Tir_ORIG)), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_VPar) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_VPar_ORIG)), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT_ORIG)), FDec0Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen_ORIG)), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial_ORIG)), FDec0Dec)
            
            On Error Resume Next
            Call GRILLA.SetFocus
            On Error GoTo 0
            
        Else
        
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal) = Format(Datos(2), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Tir) = Format(Datos(3), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_VPar) = Format(Datos(4), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = Format(Datos(5), FDec0Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) = Format(Datos(6), FDec0Dec)
            
            If GRILLA.ColSel = Col_MT Or GRILLA.ColSel = Col_Tir Then
                If Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT)) * CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), FDec0Dec) <> Format(CDbl(Datos(6)), FDec0Dec) Then
                    Let GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT)) * CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), FDec0Dec)
                End If
            End If
            If GRILLA.ColSel = Col_ValInicial Then
                If Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial)) / CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), FDec0Dec) <> Format(CDbl(Datos(5)), FDec0Dec) Then
                    Let GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial)) / CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), FDec0Dec)
                End If
            End If
            
            
        End If
        
    End If
    
    Call subCOLOREA_Registro
    Call ActualizaMontoOperacion
   
End Function

Private Function ValidaSeriesTomadas()
   Dim nContador  As Long

   For nContador = 1 To GRILLA.Rows - 1
      If GRILLA.TextMatrix(nContador, Col_Marca) <> "" And GRILLA.TextMatrix(nContador, Col_Marca) <> "*" Then
         Let GRILLA.Row = nContador
         Call SoltarPapel
      End If
   Next nContador

End Function

Private Sub Filtrar()

   Dim Datos()
   Let bDistribucionManual = False
   Call ValidaSeriesTomadas

   Let Me.CarterasFinancieras = ""
   Let Me.CarterasNormativas = ""
   Let Me.LGCP_Familia = Me.LGCP_Familia  '20181221.RCH.LCGP
   
 '  BacIrfSl.oFiltroDVP = glBacCpDvpVi
    
   Call FRM_FILTRO_FLI.Show(vbModal)

   If Frm_Vtas_con_Pcto.iAceptar = False Then Exit Sub
   'Let Screen.MousePointer = vbHourglass    ' PRD-6005
   CHK_BCCH.Value = IIf(Me.LGCP_Familia = "", False, True) '20181226.RCH.LCGP
   CHK_FCIC.Enabled = IIf(Me.LGCP_Familia = "", True, False)   '20181226.RCH.LCGP
   fra_LCGP.Enabled = False
   
   Envia = Array()
   AddParam Envia, gsBac_User
   AddParam Envia, CarterasFinancieras
   AddParam Envia, CarterasNormativas
   AddParam Envia, MihWnd
   AddParam Envia, "VI"                 ' PRD-6005 'PRD-6006 CASS 13-12-2010
   AddParam Envia, LGCP_Familia         '20181226.RCH.LCGP
   
   'If Not Bac_Sql_Execute("SP_FILTRO_FLI_6005_6007_MAP_ModUsr001", Envia) Then 'PRD-6006 CASS
   If Not Bac_Sql_Execute("SP_FILTRO_PACTOS", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha originado un error en la lectura de operaciones." & vbCrLf & vbCrLf & VerSql, vbExclamation, App.Title)
      Exit Sub
   End If
   
   Let GRILLA.Rows = 1
   Do While Bac_SQL_Fetch(Datos())
      Let GRILLA.Rows = GRILLA.Rows + 1
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Marca) = ""
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, COL_Serie) = Datos(1)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Moneda) = Datos(2)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Nominal) = Format(Datos(3), FDec4Dec)
     
       If Datos(3) < 1000 And Datos(2) = "UF" Then
          Datos(3) = Datos(3) * 1000
          Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Nominal) = Format(Datos(3), FDec4Dec)
       End If
   '   tserie = datos(1)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Tir) = Format(Datos(4), FDec4Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_VPar) = Format(Datos(5), FDec4Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_MT) = Format(Datos(6), FDec0Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_PlzRes) = Format(Datos(7), FDec0Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Margen) = Format(Datos(8), FDec4Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_ValInicial) = Format(Datos(9), FDec0Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Custodia) = "DCV"
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_ClaveDcv) = ""
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_CarteraSuper) = Datos(10)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Nominal_ORIG) = Format(Datos(3), FDec4Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Tir_ORIG) = Format(Datos(4), FDec4Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_VPar_ORIG) = Format(Datos(5), FDec4Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_MT_ORIG) = Format(Datos(6), FDec4Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Margen_ORIG) = Format(Datos(8), FDec4Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_ValInicial_ORIG) = Format(Datos(9), FDec0Dec)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_CodCarteraSuper) = Datos(11)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_BloqueoPacto) = Format(Datos(12), FDec4Dec)  ' PRD-6005
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_HairCut) = Format(Datos(13), FDec4Dec)       ' PRD-6007
      'Call ChangeColorSetting(grilla.Rows - 1, Normal)
      ' PRD-6005
      If CDbl(GRILLA.TextMatrix(GRILLA.Rows - 1, Col_BloqueoPacto)) <> 0 Then
        Call ChangeColorSetting(GRILLA.Rows - 1, BloqueoPacto)
      End If
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_ID_SOMA) = 0                                   ' PRD-6010
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Correla_SOMA) = 0                              ' PRD-6010
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Emisor) = Format(Datos(14), FDec0Dec)          ' PRD-6006
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, Col_Nemo_Emisor) = Trim(Datos(15))                 ' PRD-6006
      ' Agregar Campo glosa emisor
      TxtTotal.Enabled = True
   Loop
      
   TxtTotal.text = VENTA_SumarTotal
   
   Let Me.MousePointer = vbDefault
   GRILLA.AllowUserResizing = flexResizeColumns 'MAP 6005 Solo para Certificar
   Call ActualizaMontoOperacion
   'ARM PRD-7893
   CHK_BCCH.Enabled = True
 
End Sub

Function carga_haircut()
  Dim Serie As String
  Dim i As Integer
  With GRILLA
    For i = 1 To GRILLA.Rows - 1
    If GRILLA.TextMatrix(i, 0) = "P" Then
     Serie = GRILLA.TextMatrix(i, COL_Serie)
     tserie = Serie
     selhaircut = i
     Let GRILLA.TextMatrix(i, Col_HairCut) = Format(haircut, FDec4Dec)
     
     End If
    Next
  End With
End Function


Function carga_tasaref_soma()
  Dim Serie As String
  Dim i As Integer
  With GRILLA
    For i = 1 To GRILLA.Rows - 1
     If GRILLA.TextMatrix(i, 0) = "P" Then
     Serie = GRILLA.TextMatrix(i, COL_Serie)
     tserie = Serie
     Let GRILLA.TextMatrix(i, Col_Tir) = Format(tasa_referencial, FDec4Dec)
     End If
    Next
  End With
End Function
Function carga_margen_soma()
   Dim Serie As String
'  Dim x As Integer
  With GRILLA
    For X = 1 To GRILLA.Rows - 1
     Serie = GRILLA.TextMatrix(X, COL_Serie)
     tserie = Serie
     Let GRILLA.TextMatrix(X, Col_Margen) = Format(margen_soma, FDec4Dec)
    Next
  End With

End Function
Public Function VENTA_SumarTotal() As Double
   
   Dim nTotal As Double
   Dim nContador As Double
       
   VENTA_SumarTotal = 0
   nTotal = 0
   nContador = 0
   
   For nContador = 1 To GRILLA.Rows - 1
       If GRILLA.TextMatrix(nContador, Col_Marca) = "V" Or GRILLA.TextMatrix(nContador, Col_Marca) = "P" Then
         nTotal = nTotal + IIf(GRILLA.TextMatrix(nContador, Col_Moneda) = "USD", Round(GRILLA.TextMatrix(nContador, Col_MT) * gsBac_TCambio, 0), GRILLA.TextMatrix(nContador, Col_MT))
       End If
   Next
   
   VENTA_SumarTotal = nTotal
    
End Function

'Private Function LoadFile_Soma() As Boolean
'   Dim oFile      As String
'   Dim oPath      As String
'   Dim MiExcel    As Object
'   Dim MiLibro    As Object
'   Dim MiHoja     As Object
'   Dim nFilas     As Long
'   Dim nContador  As Long
'   Dim nSwith     As Boolean
'
'   If Right(gsBac_DIRSOMA, 1) <> "\" Then
'      Let gsBac_DIRSOMA = gsBac_DIRSOMA & "\"
'   End If
'
'   Let oFile = "CargaSOMA" & Format(gsBac_Fecp, "MM") & Format(gsBac_Fecp, "DD") & ".XlS"
'   Let oPath = gsBac_DIRSOMA & oFile
'
'   If Dir(oPath) = "" Then
'      Call MsgBox("El archivo requerido para la carga. [" & oFile & "]. no se encuentra... Favor Revisar.", vbExclamation, App.Title)
'      Exit Function
'   End If
'
'   Let Screen.MousePointer = vbHourglass
'   Let nFilas = 50
'
'   Set MiExcel = CreateObject("Excel.Application")
'   Set MiLibro = MiExcel.Workbooks.Open(oPath)
'
'   Set MiHoja = Nothing
'   Set MiHoja = MiLibro.Worksheets("FLI")
'
'   Let GrillaSoma.Rows = 2
'   Let GrillaSoma.Redraw = False
'
'   For nContador = 2 To nFilas
'
'      Let Progreso.Value = nContador
'      Let LblProgreso.Caption = "Cargando Archivo...  " & Trim(Progreso.Value) & " %"
'
'      If (UCase(MiHoja.Cells(nContador - 1, "C")) = UCase("Mnemotécnico")) Then
'         Let nSwith = True
'      End If
'
'      If nSwith = True Then
'         If UCase(Trim(MiHoja.Cells(nContador, "B"))) = UCase(Trim("VALOR INICIAL PACTO: ")) Then
'            Let Progreso.Value = 50
'            Let LblProgreso.Caption = "Carga Finalizada. 100 %"
'            Exit For
'         End If
'
'         If Trim(MiHoja.Cells(nContador, "C")) <> "" Then
'            Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 0) = MiHoja.Cells(nContador, "C")
'            Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 1) = Format(CDbl(MiHoja.Cells(nContador, "D")), FDec4Dec)
'            Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 2) = Format(CDbl(MiHoja.Cells(nContador, "F")), FDec4Dec)
'            Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 3) = Format(CDbl(MiHoja.Cells(nContador, "G")), FDec0Dec)
'            Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 4) = Format(CDbl(MiHoja.Cells(nContador, "E")), FDec0Dec)
'            Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 5) = Format(CDbl(MiHoja.Cells(nContador, "I")), FDec4Dec)
'            Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 6) = Format(CDbl(MiHoja.Cells(nContador, "J")), FDec0Dec)
'            Let GrillaSoma.Rows = GrillaSoma.Rows + 1
'         End If
'      End If
'
'   Next nContador
'
'   Let GrillaSoma.Rows = GrillaSoma.Rows - 1
'
'   Set MiHoja = Nothing
'   Call MiLibro.Close
'   Set MiExcel = Nothing
'
'   Let GrillaSoma.Redraw = True
'   Let Progreso.Value = 0
'   Let LblProgreso.Caption = "Lectura de Archivo SOMA"
'   Let Screen.MousePointer = vbDefault
'End Function

'Private Function CargaArchivo_Soma() As Boolean
''PRD-6010
'   Dim oPath      As String
'   Dim Sql$, DATOS(), xLine$
'   Dim nContador  As Long
'   Dim nEstado    As Long
'   Dim Arreglo()  As String
'   Dim x As Long
'   Dim ContLinea  As Long
'   Dim nNumoper   As Long
'   Dim nCorrela   As Long
'   Dim nValida    As Long
'   Dim nFilas     As Long
'   Dim nFilFolio  As Long
'   Dim error      As String
'   Dim Msg        As String
'   Dim sSerie     As String
'   Dim nRutEmisor As Double
'
'   Dim nResul     As Long
'   Dim CantFolioSOMA  As Long
'
'   Let error = ""
'   Let Msg = ""
'
'
'   ContLinea = 0
'   nContador = 0
'
'   If Right(gsBac_DIRSOMA, 1) <> "\" Then
'      Let gsBac_DIRSOMA = gsBac_DIRSOMA & "\"
'   End If
'
'   Let cNombreArchivo = "Fli" & Format(gsBac_Fecp, "YY") & Format(gsBac_Fecp, "MM") & Format(gsBac_Fecp, "DD") & ".txt"
'   Let oPath = gsBac_DIRSOMA & cNombreArchivo
'
'   If Dir(oPath) = "" Then
'      Call MsgBox("El archivo requerido para la carga. [" & cNombreArchivo & "]. no se encuentra... Favor Revisar.", vbExclamation, App.Title)
'      Exit Function
'   End If
'
'   GrillaSoma.Clear
'   Call SettingGridSoma(GrillaSoma)
'   Let GrillaSoma.Rows = 2
'   Let CantFolioSOMA = 0
'
'   Call LimpiaGrillaErroresSOMA
'   Call CargaFoliosSOMABac
'   Call BuscaFolioAnulado(oPath, cNombreArchivo)
'
'      '-- carga operaciones
'    On Error GoTo errOpen
'    Open oPath For Input Access Read Shared As #1
'
'    On Error GoTo errRead
'
'    Do While Not EOF(1)
'
'
'        Line Input #1, xLine
'
'
'         Arreglo = Split(xLine, vbTab)
'         nEstado = 0
'
'         If EOF(1) Then
'            If xLine = "" Then
'               Exit Do
'            End If
'         End If
'
'
'         If Arreglo(0) = "ID" Then
'             ContLinea = 0
'         End If
'
'
'         ContLinea = ContLinea + 1
'
'        If ContLinea = 1 Then
'
'                For x = 0 To UBound(Arreglo)
'
'                  Select Case nEstado
'                    Case 0
'                        If Arreglo(x) = "ID" Then
'                            nEstado = 1
'                        Else
'                            GoTo errRead
'                        End If
'                    Case 1
'                        If Arreglo(x) = "Fecha" Then
'                            nEstado = 2
'                        Else
'                            GoTo errRead
'                        End If
'                    Case 2
'                        If Arreglo(x) = "Institucion" Then
'                            nEstado = 3
'                        Else
'                            GoTo errRead
'                        End If
'                    Case 3
'                        If Arreglo(x) = "Monto Nominal" Then
'                            Exit For
'                        Else
'                            GoTo errRead
'                        End If
'                  End Select
'
'                Next x
'
'        End If
'
'        If ContLinea = 2 Then
'             nNumoper = Arreglo(0)
'
'        End If
'
'
'        If ContLinea = 3 Then
'
'
'                For x = 0 To UBound(Arreglo)
'
'                  Select Case nEstado
'                    Case 0
'                        If Arreglo(x) = "Correlativo" Then
'                            nEstado = 1
'
'                        Else
'                            GoTo errRead
'                        End If
'                    Case 1
'                        If Arreglo(x) = "Mnemotecnico" Then
'                            nEstado = 2
'                        Else
'                            GoTo errRead
'                        End If
'                    Case 2
'                        If Arreglo(x) = "Monto Nominal" Then
'                            nEstado = 3
'                        Else
'                            GoTo errRead
'                        End If
'                    Case 3
'                        If Arreglo(x) = "Valor Inicial" Then
'                            Exit For
'                        Else
'                            GoTo errRead
'                        End If
'                  End Select
'
'
'
'                Next x
'
'
'        End If
'
'        If ContLinea >= 4 Then
'
'
'
'             Envia = Array()
'             AddParam Envia, CDbl(nNumoper)
'             AddParam Envia, Arreglo(1)
'             AddParam Envia, gsBac_User
'             AddParam Envia, CarterasFinancieras
'             AddParam Envia, CarterasNormativas
'             AddParam Envia, MihWnd
'             AddParam Envia, "FLI"
'
'             If Not Bac_Sql_Execute("Sp_ValidaArchivo_BCCH", Envia) Then
'                Call BacRollBackTransaction
'                Call MsgBox("Se ha producido un error en la busqueda.", vbExclamation, App.Title)
'                Exit Function
'             End If
'
'             If Bac_SQL_Fetch(DATOS()) Then
'                nValida = Val(DATOS(1))
'                sSerie = DATOS(2)
'                nRutEmisor = DATOS(3)
'             End If
'
'
'           If Arreglo(0) <> "" And nValida = 0 Then
'              Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 0) = sSerie ''Arreglo(1)
'              Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 1) = Format(CDbl(Arreglo(2)), FDec4Dec)
'              Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 2) = 0#
'              Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 3) = 0#
'              Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 4) = 0
'              Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 5) = 0#
'              Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 6) = Format(CDbl(Arreglo(3)), FDec4Dec)
'              Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 7) = Format(CDbl(nNumoper), FDec0Dec)
'              Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 8) = Format(CDbl(Arreglo(0)), FDec0Dec)
'              Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 9) = nRutEmisor
'
'              Let GrillaSoma.Rows = GrillaSoma.Rows + 1
'
'           Else
'
'              nFilas = GrillaSoma.Rows - 1
'              If Arreglo(0) <> "" Then
'                 Call EliminaFolioSomaGrilla(nFilas, CDbl(nNumoper))
'
'                 If nValida = 2 And CantFolioSOMA < 1 Then
'                    Let error = error & "  Serie instrumento [" & Arreglo(1) & "] no esta disponible en cartera BAC, la cual corresponde al siguiente Folio  SOMA: [" & nNumoper & "]" & vbCrLf
'                    Let Msg = "Serie Instrumento no está disponible"
'                    Call Llena_GrillaErroresSOMA(Format(CDbl(nNumoper), FDec0Dec), Format(CDbl(Arreglo(0))), Arreglo(1), Msg, Format(CDbl(Arreglo(3)), FDec4Dec), 0)
'
'                 Else
'                    If ContLinea = 4 Then
'                        Let error = error & "  Folio SOMA   [" & nNumoper & "] ya se encuentra cargado en BAC." & vbCrLf
'                        Let Msg = "Folio SOMA, ya se encuentra cargado"
'                        Call Llena_GrillaErroresSOMA(Format(CDbl(nNumoper), FDec0Dec), Format(CDbl(Arreglo(0))), Arreglo(1), Msg, Format(CDbl(Arreglo(3)), FDec4Dec), 0)
'                        CantFolioSOMA = CantFolioSOMA + 1
'
'                    End If
'
'                 End If
'              End If
'
'           End If
'
'
'        End If
'
'
'
'        nContador = nContador + 1
'
'        Let Progreso.Value = nContador
'
'
'    Loop
'
'
'  If Len(error) > 0 Or Len(ErrAnula) > 0 Then
'      Call MsgBox("Se han encontrado las siguientes Observaciones:" & vbCrLf & vbCrLf & error & vbCrLf & ErrAnula & vbCrLf, vbExclamation, App.Title)
'  End If
'
'    Close #1
'
'    Exit Function
'
'
'errOpen:
'    Exit Function
'
'errRead:
'    MsgBox "No se pudo continuar la lectura del archivo. Favor Revisar." & oPath & vbCrLf & err.Description, vbCritical
'''    GoTo fin  'Se elimina 6010
'
'
'
''PRD-6010
'End Function

'Private Sub EliminaFolioSomaGrilla(FILAS As Long, nOper As Long)
'   'PRD-6010
'   Dim nCont   As Long
'
'   For nCont = 1 To FILAS - 1
'     If GrillaSoma.TextMatrix(nCont, 7) = nOper Then   '' And GrillaSoma.TextMatrix(nCont, 7) = ""
'       GrillaSoma.RemoveItem nCont
'     End If
'   Next nCont
'   'PRD-6010
'End Sub

'Private Sub CargaFoliosSOMABac()
''PRD-6010
'Dim DATOS()
'
'GridFolioSOMA.Clear
'
'   Let GridFolioSOMA.TextMatrix(0, 0) = "Folio SOMA"
'   Let GridFolioSOMA.TextMatrix(0, 1) = "Oper BAC"
'
'
'Let GridFolioSOMA.Rows = 1
'   Envia = Array()
'   AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")
'   AddParam Envia, "FLI"
'   If Not Bac_Sql_Execute("dbo.Sp_TraeFoliosSOMA", Envia) Then
'      Let Screen.MousePointer = vbDefault
'      Call MsgBox("Se ha originado un error en la lectura de operaciones." & vbCrLf & vbCrLf & VerSql, vbExclamation, App.Title)
'      Exit Sub
'   End If
'
'   Do While Bac_SQL_Fetch(DATOS())
'      Let GridFolioSOMA.Rows = GridFolioSOMA.Rows + 1
'      Let GridFolioSOMA.TextMatrix(GridFolioSOMA.Rows - 1, 0) = DATOS(1)
'      Let GridFolioSOMA.TextMatrix(GridFolioSOMA.Rows - 1, 1) = DATOS(2)
'
'   Loop
'
''PRD-6010
'End Sub

'Private Sub BuscaFolioAnulado(ruta As String, NombreArchivo As String)
'         'PRD-6010
'         Dim xLine
'         Dim nFilFolio As Long
'         Dim nResul    As Long
'         Dim oFile     As String
'         Dim Msg       As String
'
'         Let ErrAnula = ""
'         Let Msg = ""
'
'               For nFilFolio = 1 To GridFolioSOMA.Rows - 1
'
'                  Open ruta For Input Access Read Shared As #1
'                   Do While Not EOF(1)
'
'
'                    Line Input #1, xLine
'
'                    If InStr(xLine, GridFolioSOMA.TextMatrix(nFilFolio, 0)) = 0 Then
'                        Let nResul = nResul + 1
'                    Else
'                        Let nResul = 0
'                        Exit Do
'                    End If
'
'                   Loop
'
'
'                    If nResul > 1 Then
'                       Let ErrAnula = ErrAnula & " Falta anular operación FLI en BAC con número [" & CDbl(GridFolioSOMA.TextMatrix(nFilFolio, 1)) & "], que referencia a folio SOMA[" & CDbl(GridFolioSOMA.TextMatrix(nFilFolio, 0)) & "], que ya no existe en archivo [" & NombreArchivo & "]" & vbCrLf
'                       Let Msg = "Debe Anular Oparación FLI en BAC [" & CDbl(GridFolioSOMA.TextMatrix(nFilFolio, 1)) & "], ya que no existe Folio SOMA en Archivo"
'                       Call Llena_GrillaErroresSOMA(Format(CDbl(GridFolioSOMA.TextMatrix(nFilFolio, 0)), FDec0Dec), 0, "", Msg, 0, 0)
'                       nResul = 0
'                    End If
'
'                           Close #1
'
'               Next nFilFolio
'
'            'PRD-6010
'End Sub

'Function SacarDatos(sCadena$, sCaracter$, sRetornar$, Optional bRetornaResto) As Variant
'    Dim sDecMil As String
'
'    SacarDatos = ""
'    If InStr(sCadena, sCaracter) > 0 Then
'        SacarDatos = Left(sCadena, InStr(sCadena, sCaracter) - 1)
'        sCadena = Mid(sCadena, InStr(sCadena, sCaracter) + Len(sCaracter))
'    ElseIf Not IsMissing(bRetornaResto) Then
'        If bRetornaResto Then
'            SacarDatos = sCadena
'            sCadena = ""
'        End If
'    End If
'
'    SacarDatos = BacStrTran((SacarDatos), vbCrLf, "")
'
'    '---- convierte para retornar
'    Select Case UCase(sRetornar)
'    Case "ID"
'        If SacarDatos = "" Then
'            SacarDatos = "0"
'        End If
'
'        'Primero se reemplaza el separador que es punto
'        SacarDatos = BacStrTran((SacarDatos), ".", "")
'        'segundo se reemplaza el decimal que es coma por punto para sql
'        ''****************************
'        '' VGS 14/04/2005
'        ''****************************
'        If InStr(1, SacarDatos, ",") > 0 Then
'            If gsc_PuntoDecim = "," Then
'                SacarDatos = SacarDatos
'            Else
'                SacarDatos = BacStrTran((SacarDatos), ",", ".")
'            End If
'        End If
'        ''****************************
'    Case "D", "F", "FECHA"
'        If Trim(SacarDatos) <> "" Then
'            SacarDatos = CDate(SacarDatos)
'        End If
'
'    End Select
'
'End Function
'Private Function Carga_Oper_Soma_Grilla_FLI()
'   Dim nCont As Long
'
'   For nCont = 1 To GrillaSoma.Rows - 1
'       Call Grilla_KeyDown(vbKeyReturn, 0)
'   Next nCont
'
'End Function


'Private Function Realizar_Fli_Soma()
'   Dim nNumCargas As Long
'   Dim nFilasSoma As Long
'   Dim nFilas     As Long
'
'   Dim xSerie     As String
'   Dim xNominal   As Double
'   Dim xTasa      As Double
'   Dim xValor     As Double
'
'   Dim xPlazo     As Long
'   Dim xMargen    As Double
'   Dim xVInicial  As Double
'   Dim xIdSOMA    As Long
'   Dim xCorrelaSOMA As Long
'   Dim xRutEmisor As Double
'
'
'
'   Dim err      As String
'   Dim error      As String
'   Dim nFil     As Long
'   Dim Msg        As String
'
'   Let err = ""
'   Let error = ""
'   Let Msg = ""
'
'   Let GRILLA.Redraw = False
'   Let nNumCargas = 0
'
'   Call LimpiaFolioSOMA_GRILLA   'PRD-6010
'
'   On Error GoTo ErrStock
'
'   '->> Lee Filas de la Grilla SOMA
'   For nFilasSoma = 1 To GrillaSoma.Rows - 2
'
'      '->> Asigna variables SOMA
'      If Trim(GrillaSoma.TextMatrix(nFilasSoma, 0)) = "" Then
'        Exit Function
'      End If
'
'      Let xSerie = Trim(GrillaSoma.TextMatrix(nFilasSoma, 0))
'      Let xNominal = GrillaSoma.TextMatrix(nFilasSoma, 1)
'      Let xTasa = GrillaSoma.TextMatrix(nFilasSoma, 2)
'      Let xValor = GrillaSoma.TextMatrix(nFilasSoma, 6)        'PRD-6010
'      Let xPlazo = GrillaSoma.TextMatrix(nFilasSoma, 4)
'      Let xMargen = GrillaSoma.TextMatrix(nFilasSoma, 5)
'      Let xVInicial = GrillaSoma.TextMatrix(nFilasSoma, 6)
'      Let xIdSOMA = GrillaSoma.TextMatrix(nFilasSoma, 7)       'PRD-6010
'      Let xCorrelaSOMA = GrillaSoma.TextMatrix(nFilasSoma, 8)  'PRD-6010
'      Let xRutEmisor = GrillaSoma.TextMatrix(nFilasSoma, 9)    'PRD-6010
'
'
'      Let err = ""
'
'      '->> Lee Filas de la Grilla de Operaciones
'      For nFilas = 1 To GRILLA.Rows - 1
'
'         '->> Valida que corresponda a la Serie
'         If GRILLA.TextMatrix(nFilas, COL_Serie) = xSerie Then
'
'            If CDbl(GRILLA.TextMatrix(nFilas, Col_Nominal)) < xNominal And CDbl(GRILLA.TextMatrix(nFilas, Col_Emisor)) = CDbl(xRutEmisor) Then
'               If VerificaSerieSOMA(xSerie, xIdSOMA, xCorrelaSOMA) = True Then
'                  Exit For
'               End If
'               Let err = err & "Falta Stock o disponibilidad de Nominal para la serie: [" & xSerie & "], la cual corresponde a Folio SOMA: [" & xIdSOMA & "]" & vbCrLf     'PRD-6010
'               Let Msg = "Falta Stock o disponibilidad de Nominal"
'               Call Llena_GrillaErroresSOMA(Format(CDbl(xIdSOMA), FDec0Dec), Format(CDbl(xCorrelaSOMA)), xSerie, Msg, xNominal, GRILLA.TextMatrix(nFilas, Col_Nominal))
'               Exit For
'
'            Else
'
'           'PRD-6010
'              If CDbl(GRILLA.TextMatrix(nFilas, Col_Emisor)) = CDbl(xRutEmisor) Then
'                If VerificaSerieSOMA(xSerie, xIdSOMA, xCorrelaSOMA) = True Then
'                  Let err = err & "Serie Instrumento [" & xSerie & "] ya tiene asignado un Folio SOMA. Debe cargar nuevamente el siguiente Folio Soma [" & xIdSOMA & "]" & vbCrLf
'                  Let Msg = "Serie Instrumento ya tiene asignado un Folio SOMA"
'                  Call Llena_GrillaErroresSOMA(Format(CDbl(xIdSOMA), FDec0Dec), Format(CDbl(xCorrelaSOMA)), xSerie, Msg, xNominal, GRILLA.TextMatrix(nFilas, Col_Nominal))
'                  Exit For
'                End If
'              Else
'                 Exit For
'              End If
'           'PRD-6010
'
'               If Len(err) = 0 Then
'                  Let nNumCargas = nNumCargas + 1
'                  Let GRILLA.TextMatrix(nFilas, Col_Nominal) = Format(xNominal, FDec4Dec)
'                  Let GRILLA.TextMatrix(nFilas, Col_Tir) = Format(xTasa, FDec4Dec)
'                  Let GRILLA.TextMatrix(nFilas, Col_MT) = Format(xValor, FDec0Dec) / IIf(GRILLA.TextMatrix(nFilas, Col_Margen) = 0, 1, GRILLA.TextMatrix(nFilas, Col_Margen)) 'PRD-6010
'                  Let GRILLA.TextMatrix(nFilas, Col_ValInicial) = Format(xVInicial, FDec0Dec)
'                  Let GRILLA.TextMatrix(nFilas, Col_ID_SOMA) = Format(xIdSOMA, FDec0Dec)      'PRD-6010
'                  Let GRILLA.TextMatrix(nFilas, Col_Correla_SOMA) = Format(xCorrelaSOMA, FDec0Dec) 'PRD-6010
'
'                  Let GRILLA.Row = nFilas:   Let GRILLA.Col = Col_Tir
'
'                  If TomarPapel Then
'                        Let TxtIngreso.Text = GRILLA.TextMatrix(nFilas, Col_Nominal)
'                        Call Valorizacion_Pactos(vbKeyV)
'
'                  End If
'               End If
'
'            End If
'         End If
'      Next nFilas
'
'        Let error = error + err
'
'        'PRD-6010
'        If Len(err) <> 0 Then
'
'           For nFil = 1 To GRILLA.Rows - 1
'              If xIdSOMA = GRILLA.TextMatrix(nFil, Col_ID_SOMA) Then
'                  Let GRILLA.TextMatrix(nFil, Col_ID_SOMA) = Format(0, FDec0Dec)
'                  Let GRILLA.TextMatrix(nFil, Col_Correla_SOMA) = Format(0, FDec0Dec)
'                  Call SoltarPapel
'              End If
'           Next nFil
'
'        End If
'        'PRD-6010
'
'
'   Next nFilasSoma
'
'   Let GRILLA.Redraw = True
'   Call GRILLA.SetFocus
'
'   If nNumCargas < GrillaSoma.Rows - 2 Then
'   'PRD-6010
''''
''''      Call MsgBox("Existen Series sin Disponibilidad para cargar el SOMA.", vbExclamation, App.Title)
''''      Call SoltarTodos
''''      Let grilla.Rows = 1
''''      Let GrillaSoma.Rows = 1
''''
''''      Let Toolbar1.Buttons(2).Enabled = False
''''      Let Toolbar1.Buttons(3).Enabled = True
''''      Let Toolbar1.Buttons(10).Enabled = False
''''      Let Toolbar1.Buttons(11).Enabled = False
'   'PRD-6010
'   End If
'
'    If nNumCargas = GrillaSoma.Rows - 2 And nNumCargas <> 0 Then
'      Call MsgBox("Todos lo Folios SOMA han sido cargados.", vbExclamation, App.Title)
''''      Let Toolbar1.Buttons(10).Enabled = False
'    End If
'
'ErrStock:
'   If Len(error) > 0 Then
'      Call MsgBox("Se han encontrado Observaciones en la carga del Fli SOMA :" & vbCrLf & vbCrLf & error, vbExclamation, App.Title)
'      Let Toolbar1.Buttons(10).Enabled = False
'      Let Toolbar1.Buttons(11).Enabled = False
'   End If
'   Exit Function
'
'End Function

'Private Function VerificaSerieSOMA(SerieSoma As String, FolioSOMA As Long, CorrelaSOMA As Long) As Boolean
''PRD-6010
'Dim nContador  As Long
'Dim nCant      As Long
'
'    Let VerificaSerieSOMA = False
'    Let nCant = 0
'
'    For nContador = 1 To GRILLA.Rows - 1
'
'      If (GRILLA.TextMatrix(nContador, COL_Serie) = SerieSoma) And (GRILLA.TextMatrix(nContador, Col_ID_SOMA) = FolioSOMA And (GRILLA.TextMatrix(nContador, Col_Correla_SOMA) = CorrelaSOMA)) Then   '' (grilla.TextMatrix(nContador, Col_Correla_SOMA) <> 0)
'
'               Let VerificaSerieSOMA = True
'               Exit Function
'      End If
'
'    Next nContador
'
'
'    If VerificaSerieSOMA = False Then
'        VerificaSerieSOMA = False
'        Exit Function
'    End If
'
'   VerificaSerieSOMA = True
'
''PRD-6010
'End Function


Private Function ValidaPapelesaGrabar() As Boolean
    Dim nContador  As Long
    Dim bControl    As Boolean

    Let ValidaPapelesaGrabar = False
    Let bControl = False
    
    For nContador = 1 To GRILLA.Rows - 1
        If GRILLA.TextMatrix(nContador, Col_Marca) = "P" Or GRILLA.TextMatrix(nContador, Col_Marca) = "V" Then
            Let ValidaPapelesaGrabar = True
            Exit Function
        End If
        
    Next nContador
    
    If ValidaPapelesaGrabar = False Then
        Call MsgBox("No se han seleccioando papeles para la venta", vbInformation, App.Title)
        ValidaPapelesaGrabar = False
        Exit Function
    End If
    
   ValidaPapelesaGrabar = True
   
End Function


'Private Function ValidaPapelesaGrabarPAGOS() As Boolean
'   Dim nContador  As Long
'
'   Let ValidaPapelesaGrabarPAGOS = False
'
'   For nContador = 1 To GRILLA.Rows - 1
'
'            If GRILLA.TextMatrix(nContador, Col_Marca) = "V" And CDbl(Round(GRILLA.TextMatrix(nContador, Col_MT), 0)) <> CDbl(Round(GRILLA.TextMatrix(nContador, Col_MT_ORIG), 0)) Then
'                MsgBox "si esta pagando por el total del nominal debe realizarlo por el monto original", vbExclamation
'                Exit Function
'            End If
'            If GRILLA.TextMatrix(nContador, Col_Marca) = "P" And CDbl(GRILLA.TextMatrix(nContador, Col_MT)) = CDbl(GRILLA.TextMatrix(nContador, Col_MT_ORIG)) Then
'                MsgBox "si esta pagando parcial no puede pagar el monto total del papel", vbExclamation
'                Exit Function
'            End If
'
'   Next nContador
'
'   Let ValidaPapelesaGrabarPAGOS = True
'
'End Function


Private Sub ActualizaMontoOperacion()
   Dim nMonto     As Double
   Dim nContador  As Long
   Dim fTotal     As Double
   
   Let nMonto = 0
   Let fTotal = 0
   
   For nContador = 1 To GRILLA.Rows - 1
        Let fTotal = fTotal + IIf(Modificacion, GRILLA.TextMatrix(nContador, Col_ValInicial_ORIG), 0)
        If GRILLA.TextMatrix(nContador, Col_Marca) = "P" Or GRILLA.TextMatrix(nContador, Col_Marca) = "V" Then
         Let nMonto = nMonto + GRILLA.TextMatrix(nContador, 6)
        End If
   Next nContador

   If nMonto = 0 And GRILLA.Rows > GRILLA.FixedRows Then
      '--> Deshabilita Botones del Fli, hasta que no se ejecute el Filtro
    '  Let Toolbar1.Buttons(10).Enabled = True  20181220.RCH.LCGP
      Let Toolbar1.Buttons(11).Enabled = True
      '--> Deshabilita Botones del Fli, hasta que no se ejecute el Filtro
   End If
   
   
   If oPagoParcial Then
        Let txtIniPMP.text = 0
        Let txtIniPMS.text = 0
        Let txtVenPMP.text = nMonto
        Let txtdiferencia.text = (fTotal - nMonto)
        If (fTotal - nMonto) < 0 Then
            MsgBox "Debe verificar Monto a cancelar dado que saldo no puede ser negativo", vbExclamation, "Validación Pagos"
            
        End If
    Else
        Let txtIniPMP.text = nMonto
        Let txtIniPMS.text = nMonto
        Let txtVenPMP.text = nMonto
        Let txtdiferencia.text = 0
    End If
End Sub

'Private Function validaTOTALSaldoPendiente() As Boolean
'Dim nMonto          As Double
'Dim nContador       As Long
'Dim fTotal          As Double
'Dim bExistePend     As Boolean
'
'    Let nMonto = 0
'    Let fTotal = 0
'    Let bExistePend = False
'    Let validaTOTALSaldoPendiente = False
'
'
'    For nContador = 1 To GRILLA.Rows - 1
'        Let fTotal = fTotal + IIf(Modificacion, GRILLA.TextMatrix(nContador, Col_ValInicial_ORIG), 0)
'        If GRILLA.TextMatrix(nContador, Col_Marca) <> "V" Then
'            bExistePend = True
'            Exit For
'        End If
'    Next nContador
'
'   Let validaTOTALSaldoPendiente = IIf(Not bExistePend And CDbl(Me.txtdiferencia.Text) <> 0, False, True)
'
'End Function
'
'Private Sub ActualizaMontoPAGO()
'   Dim nMonto     As Double
'   Dim nContador  As Long
'
'   Let nMonto = 0
'
'   For nContador = 1 To GRILLA.Rows - 1
'         Let nMonto = nMonto + GRILLA.TextMatrix(nContador, Col_ValInicial)
'   Next nContador
'
'   Let txtIniPMP.Text = 0
'   Let txtIniPMS.Text = 0
'   Let txtVenPMP.Text = 0
'   Let txtdiferencia.Text = nMonto
'End Sub


'Private Sub Imprimir_Informe_Errores_SOMA()
'   On Error GoTo ErrPrinter
'
'   BacTrader.bacrpt.WindowState = crptMaximized
'   BacTrader.bacrpt.ReportFileName = RptList_Path & "ObsCargaSoma.RPT"
'   Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
'   BacTrader.bacrpt.StoredProcParam(0) = Format$(gsBac_Fecp, "yyyymmdd")
'   BacTrader.bacrpt.StoredProcParam(1) = "FLI"
'   BacTrader.bacrpt.Connect = CONECCION
'   BacTrader.bacrpt.Action = 1
'   BacTrader.bacrpt.Destination = 0
'
'   On Error GoTo 0
'Exit Sub
'ErrPrinter:
'   MsgBox "Problemas en Impresión de Informe de Errores SOMA: " & err.Description, vbExclamation, gsBac_Version
'   On Error GoTo 0
'End Sub

'Private Function TraeCorrelativoBCCH(nFolioBCCH As Long) As Long
''PRD-6010
'   Dim DATOS()
'
'   Let TraeCorrelativoBCCH = 1
'   Envia = Array()
'   AddParam Envia, nFolioBCCH
'   If Not Bac_Sql_Execute("Sp_Trae_Correla_BCCH") Then
'      Exit Function
'   End If
'   Do While Bac_SQL_Fetch(DATOS())
'      TraeCorrelativoBCCH = DATOS(1)
'   Loop
''PRD-6010
'End Function


'Private Sub LimpiaFolioSOMA_GRILLA()
''PRD-6010
'   Dim nFila As Long
'
'   For nFila = 1 To GRILLA.Rows - 1
'      Let GRILLA.TextMatrix(nFila, Col_ID_SOMA) = Format(0, FDec0Dec)      'PRD-6010
'      Let GRILLA.TextMatrix(nFila, Col_Correla_SOMA) = Format(0, FDec0Dec) 'PRD-6010
'   Next nFila
''PRD-6010
'End Sub

'
'Private Sub Resumen_Folios_SOMA_Cargados(nNomArch As String)
''PRD-6010
'Dim nFila As Long
'Dim SOMACargados  As String
'Dim SOMANoCargados  As String
'
'   For nFila = 1 To GRILLA.Rows - 1
'        If GRILLA.TextMatrix(nFila, Col_ID_SOMA) <> 0 Then
'            Let SOMACargados = SOMACargados & GRILLA.TextMatrix(nFila, Col_ID_SOMA) & " - " & GRILLA.TextMatrix(nFila, Col_Correla_SOMA) & ". Serie : " & GRILLA.TextMatrix(nFila, COL_Serie) & vbCrLf
'            Call Grabar_Log_Carga_SOMA("FLI", GRILLA.TextMatrix(nFila, Col_ID_SOMA), GRILLA.TextMatrix(nFila, Col_Correla_SOMA), GRILLA.TextMatrix(nFila, COL_Serie), nNomArch, GRILLA.TextMatrix(nFila, Col_ID_SOMA) & " - " & GRILLA.TextMatrix(nFila, Col_Correla_SOMA) & ". Serie : " & GRILLA.TextMatrix(nFila, COL_Serie) & ". Cargada correctamente.", CDbl(GRILLA.TextMatrix(nFila, Col_Nominal)), 0)
'        End If
'   Next nFila
'
'
'   For nFila = 1 To GridErroresSOMA.Rows - 1
'        If GridErroresSOMA.TextMatrix(nFila, 0) <> "" Then
'            Let SOMANoCargados = SOMANoCargados & GridErroresSOMA.TextMatrix(nFila, 0) & " - " & GridErroresSOMA.TextMatrix(nFila, 3) & vbCrLf
'            Call Grabar_Log_Carga_SOMA("FLI", GridErroresSOMA.TextMatrix(nFila, 0), GridErroresSOMA.TextMatrix(nFila, 1), GridErroresSOMA.TextMatrix(nFila, 2), nNomArch, GridErroresSOMA.TextMatrix(nFila, 0) & " - " & GridErroresSOMA.TextMatrix(nFila, 3), CDbl(GridErroresSOMA.TextMatrix(nFila, 4)), CDbl(GridErroresSOMA.TextMatrix(nFila, 5)))
'        End If
'   Next nFila
'
'
'   If SOMACargados <> "" Or SOMANoCargados <> "" Then
'       MsgBox "Los siguiente Folios SOMA fueron cargados correctamente : " & vbCrLf & SOMACargados & vbCrLf _
'            & "Los siguientes Folios SOMA  No fueron cargados : " & vbCrLf & SOMANoCargados & vbCrLf
'    End If
'
'
''PRD-6010
'End Sub


'Private Sub Llena_GrillaErroresSOMA(Numoper As Long, Correla As Long, Serie As String, mensaje As String, NominalSoma As Double, NominalBac As Double)
''PRD-6010
'   Let GridErroresSOMA.Rows = GridErroresSOMA.Rows + 1
'   Let GridErroresSOMA.TextMatrix(GridErroresSOMA.Rows - 1, 0) = Numoper
'   Let GridErroresSOMA.TextMatrix(GridErroresSOMA.Rows - 1, 1) = Correla
'   Let GridErroresSOMA.TextMatrix(GridErroresSOMA.Rows - 1, 2) = Serie
'   Let GridErroresSOMA.TextMatrix(GridErroresSOMA.Rows - 1, 3) = mensaje
'   Let GridErroresSOMA.TextMatrix(GridErroresSOMA.Rows - 1, 4) = NominalSoma
'   Let GridErroresSOMA.TextMatrix(GridErroresSOMA.Rows - 1, 5) = NominalBac
'
''PRD-6010
'End Sub

'
'Private Sub LimpiaGrillaErroresSOMA()
''PRD-6010
'   GridErroresSOMA.Clear
'
'   Let GridErroresSOMA.TextMatrix(0, 0) = "Folio SOMA":  Let GridErroresSOMA.ColWidth(0) = 700
'   Let GridErroresSOMA.TextMatrix(0, 1) = "Corre SOMA":  Let GridErroresSOMA.ColWidth(1) = 500
'   Let GridErroresSOMA.TextMatrix(0, 2) = "Serie SOMA":  Let GridErroresSOMA.ColWidth(2) = 1500
'   Let GridErroresSOMA.TextMatrix(0, 3) = "Error SOMA":  Let GridErroresSOMA.ColWidth(3) = 3000
'   Let GridErroresSOMA.TextMatrix(0, 4) = "Nominal SOMA":  Let GridErroresSOMA.ColWidth(4) = 2000
'   Let GridErroresSOMA.TextMatrix(0, 5) = "Nominal SOMA":  Let GridErroresSOMA.ColWidth(5) = 2000
''PRD-6010
'End Sub

'Private Sub Grabar_Log_Carga_SOMA(TipoOper As String, FolioSOMA As Long, CorrelaSOMA As Long, Serie As String, NombreArch As String, Observ As String, NominalSoma As Double, NominalBac As Double)
''PRC-6010
' Envia = Array()
' AddParam Envia, gsBac_Fecp
' AddParam Envia, gsBac_Term
' AddParam Envia, gsBac_User
' AddParam Envia, GLB_ID_SISTEMA
' AddParam Envia, TipoOper
' AddParam Envia, FolioSOMA
' AddParam Envia, CorrelaSOMA
' AddParam Envia, Serie
' AddParam Envia, CDbl(NominalSoma)
' AddParam Envia, CDbl(NominalBac)
' AddParam Envia, NombreArch
' AddParam Envia, Observ
' If Not Bac_Sql_Execute("Sp_Graba_Log_Carga_Archivo_SOMA", Envia) Then
'     MsgBox "Problemas al Grabar Log de carga archivo SOMA : " & NombreArch, vbCritical
' End If
'
''PRC-6010
'End Sub

Sub SeleccionVentas()
      'PRD-6010
      Dim nFila As Long
      
       If Toolbar1.Buttons(5).Tag = "Ver Todos" Then
              Toolbar1.Buttons(5).Tag = "Ver Sel."
              Toolbar1.Buttons(5).ToolTipText = "Ver Selección"
             
              For nFila = 1 To GRILLA.Rows - 1
                 If GRILLA.TextMatrix(nFila, Col_Marca) <> "V" And GRILLA.TextMatrix(nFila, Col_Marca) <> "P" Then
                    GRILLA.RowHeight(nFila) = nAlturaFila
                 End If
              Next nFila
      
              
       Else
              Toolbar1.Buttons(5).Tag = "Ver Todos"
              Toolbar1.Buttons(5).ToolTipText = "Ver Todos"
              For nFila = 1 To GRILLA.Rows - 1
                 If GRILLA.TextMatrix(nFila, Col_Marca) <> "V" And GRILLA.TextMatrix(nFila, Col_Marca) <> "P" Then
                    Let nAlturaFila = GRILLA.RowHeight(nFila)
                    GRILLA.RowHeight(nFila) = 0
                 End If
              Next nFila
      
              
       End If
         
'PRD-6010
End Sub

'PRD-6006. CASS
Private Sub CalcularValorFinal()

    Dim Base%, Tasa#, ValIni#, Plazo&, TasaTran#

    Base = funcBaseMoneda(CmbMon.ItemData(CmbMon.ListIndex))

    Plazo = CDbl(TxtPlazo.text)
    If Plazo = 0 Then Exit Sub
       
    ValIni = CDbl(txtIniPMP.text)
    If ValIni = 0 Then Exit Sub
        
    Tasa = CDbl(TxtTasa.text)
    TasaTran = CDbl(Txt_TasaTran.text)
    
    If Tasa = 0 Then Exit Sub
   
    If CmbMon.ItemData(CmbMon.ListIndex) = 999 Then
        txtVenPMP.CantidadDecimales = 0
    Else
        txtVenPMP.CantidadDecimales = BacDatGrMon.mndecimal
    End If

    If dTipcam# = 1 Then
      txtVenPMP.text = BacCtrlTransMonto(Int(VI_ValorFinal(ValIni#, Tasa#, Plazo&, Base%)))
      Txt_VFTran.text = BacCtrlTransMonto(Int(VI_ValorFinal(ValIni#, TasaTran#, Plazo&, Base%)))
    Else
       txtVenPMP.text = Round(BacCtrlTransMonto(VI_ValorFinal(ValIni#, Tasa#, Plazo&, Base%)), txtVenPMP.CantidadDecimales)
       Txt_VFTran.text = BacCtrlTransMonto(VI_ValorFinal(ValIni#, TasaTran#, Plazo&, Base%))
    End If
    
   '->   Formula Original.-
   ' Txt_DifTran.Text = (txtVenPMP.Text - Txt_VFTran.Text) / (1 + TasaTran / 100 * Plazo / 360)
    
   '->   Cambio Realizado el 15-05-2013.-
    Txt_DifTran.text = (Txt_VFTran.text - txtVenPMP.text) / (1 + TasaTran / 100 * Plazo / 360)
        
    If dTipcam# = 1 Then
        Txt_Dif_CLP.text = Txt_DifTran.text
    Else
        Txt_Dif_CLP.text = Txt_DifTran.text * dTipcam#
    End If
    
 
End Sub


Private Sub txtIniPMP_Change()
    Call CalcularValorFinal
    
    If CmbMon.text = "CLP" Then
      txtIniPMS.text = CDbl(TxtTotal.text)
    Else
      txtIniPMS.text = CDbl(TxtTotal.text)
    End If
End Sub

'PRD-6006 CASS
Private Sub TxtPlazo_GotFocus()
  TxtPlazo.Tag = TxtPlazo.text
End Sub

Private Sub TxtPlazo_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      Bac_SendKey vbKeyTab
   End If
   
   If KeyAscii = 13 Then
     If TxtPlazo.text < 0 Then
        MsgBox ("No puede ingresar plazo menor que cero"), vbInformation, TITSISTEMA
        TxtPlazo.text = 1
     Else
        Call calcula
    End If
   End If
End Sub

'PRD-6006 CASS
Private Sub TxtPlazo_LostFocus()


   Dim Datos()
'   Dim rs As Recordset
'   Dim Sql As String
'
    If TxtPlazo.text <> TxtPlazo.Tag Then

'        Sql = "SELECT SUM(tm_vp) As Total FROM mdventa WHERE ( tm_venta = 'V' OR tm_venta = 'P' ) AND tm_hwnd = " & Hwnd & " AND tm_diasdisp < " & txtplazo.Text
'        Set rs = db.OpenRecordset(Sql, dbOpenSnapshot)

        SQL = "SELECT SUM(Valor_Presente) As Total FROM DETALLE_VTAS_CON_PCTO WHERE ( marca = 'S' ) AND Ventana = " & hWnd & " AND Plazo < " & TxtPlazo.text

         If Not Bac_Sql_Execute(SQL) Then
            Let Me.MousePointer = vbDefault
            Call MsgBox("Se ha producido un error al tratar de tomar el registro.", vbExclamation, App.Title)
            Exit Sub
         End If
      
         Do While Bac_SQL_Fetch(Datos())
            If Not IsNull(Datos(1)) Then
               If Datos(1) > 0 Then
                    MsgBox "Existen Inst. Seleccionados con menor disponibilidad al Plazo ingresado, Debe Desmarcar", vbCritical, "Días Pacto"
                    TxtPlazo.text = TxtPlazo.Tag
                    TxtPlazo.SetFocus
                    TxtFecVct.text = Format$(DateAdd("d", TxtPlazo.text, TxtFecIni.text), "dd/mm/yyyy")
                    Exit Sub
               End If
            End If
         Loop

'        If rs.RecordCount > 0 Then
'            If Not IsNull(rs.Fields("Total")) Then
'                If rs.Fields("Total") > 0 Then
'                    MsgBox "Existen Inst. Seleccionados con menor disponibilidad al Plazo ingresado, Debe Desmarcar", vbCritical, "Días Pacto"
'                    txtplazo.Text = txtplazo.Tag
'                    txtplazo.SetFocus
'                    TxtFecVct.Text = Format$(DateAdd("d", txtplazo.Text, TxtFecIni.Text), "dd/mm/yyyy")
'                    Exit Sub
'                End If
'            End If
'        End If
'
        TxtFecVct.text = Format$(DateAdd("d", TxtPlazo.text, TxtFecIni.text), "dd/mm/yyyy")
        PnlDiaFin.Caption = BacDiaSem(TxtFecVct.text)

        If EsFeriado(CDate(TxtFecVct.text), "00001") Then
            MsgBox "La Fecha de Vcto. ingresada retorna un día No Hábil; Por favor reingrese", vbCritical, "Feriados"
            TxtPlazo.text = TxtPlazo.Tag
            TxtFecVct.text = Format$(DateAdd("d", TxtPlazo.text, TxtFecIni.text), "dd/mm/yyyy")
            PnlDiaFin.Caption = BacDiaSem(TxtFecVct.text)
            Exit Sub
        End If

        If TxtPlazo.text = 0 Then
            MsgBox "Fecha de Vcto. Ingresada igual a la de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
            TxtPlazo.text = TxtPlazo.Tag
            TxtPlazo.SetFocus
            TxtFecVct.text = Format$(DateAdd("d", TxtPlazo.text, TxtFecIni.text), "dd/mm/yyyy")
        Exit Sub

    End If

'    Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= " & txtplazo.Text
    Toolbar1.Buttons(6).Tag = "Ver Sel."
'    Data1.Refresh
'
'    TxtCartera.Text = VENTA_SumarCartera(Hwnd, txtplazo.Text, Toolbar1)

    Call CalcularValorFinal

  End If

End Sub

Private Sub TxtTasa_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      Bac_SendKey vbKeyTab
   End If
   
   If KeyAscii = 13 Then
      Call calcula
   End If
End Sub

'PRD-6006 CASS
Private Sub TxtTasa_LostFocus()
   Dim k
   k = 0

   ' If Txt_TasaTran.Text = 0 And TxtTasa.Text <> 0 Then
     Txt_TasaTran.text = TxtTasa.text
   ' End If

    Call CalcularValorFinal

    'Aplicar Control de Precios y Tasas
    'Como aun no conozco al cliente...
    Ctrlpt_RutCliente = "0"
    Ctrlpt_CodCliente = "0"
    
    If CDbl(TxtTasa.text) > 0 Then
        If ControlPreciosTasas("VI", CmbMon.ItemData(CmbMon.ListIndex), TxtPlazo.text, TxtTasa.text) = "S" Then
            If Ctrlpt_ModoOperacion <> "S" Then 'PRD-3860, modo silencioso
            MsgBox Ctrlpt_Mensaje, vbExclamation, TITSISTEMA
        End If
    End If
    End If
End Sub

Private Sub txtTipoCambio_KeyPress(KeyAscii As Integer)
    If KeyAscii = vbKeyReturn Then
        Call txtTipoCambio_LostFocus
    End If

End Sub

Private Sub txtTipoCambio_LostFocus()
        dTipcam# = txtTipoCambio.text
        Call TxtTotal_Change
        Call CalcularValorFinal
'        Bac_SendKey vbKeyTab

End Sub

Private Sub TxtTotal_Change()

    Dim nRedon As Integer
    Dim AuxdTipCam    As Double
    
    txtIniPMS.text = TxtTotal.text
    TxtTotal.text = IIf(TxtTotal.text = "", "0", TxtTotal.text)
    
    If SwMx = "C" And CmbMon.ItemData(CmbMon.ListIndex) <> 999 Then
        nRedon = BacDatGrMon.mndecimal
    ElseIf SwMx = " " And CmbMon.ItemData(CmbMon.ListIndex) = 999 Then
        nRedon = 0
    Else
        nRedon = BacDatGrMon.mndecimal
    End If
    
   
    If dTipcam = 0 Then
        txtIniPMP.text = 0
    Else
        txtIniPMP.text = Round(TxtTotal.text / dTipcam, nRedon)
    End If
    
'   'PRD-6006 cass 09-12-2010
'    TxtSel.Text = TxtTotal.Text
    
'    If Toolbar1.Buttons(6).Tag = "Ver Sel." And CDbl(TxtTotal.Text) = 0 Then
'       Toolbar1.Buttons(6).Enabled = False
'    Else
'      Toolbar1.Buttons(6).Enabled = True
'    End If
    

End Sub

Private Sub TxtTotal_GotFocus()
  TxtTotal.Tag = TxtTotal.text
End Sub


'Private Sub TxtTotal_KeyDown(KeyCode As Integer, Shift As Integer)
''   'PRD-6006 cass 09-12-2010
'
''If KeyCode = 13 Then
''    Tecla = "13"
''Else
''    Tecla = ""
''End If
'End Sub

Private Sub TxtTotal_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        Sendkeys$ "{TAB}"
    End If
        

End Sub

'Private Sub TxtTotal_LostFocus()
'   '   Dim dTotalNuevo#, dTotalActual#
'   '
'   '   '''' se revisar tiene problemas graves
'   '   Dim I As Integer
'   '   On Error GoTo error
'   '
'   '   If Table1.TextMatrix(1, 0) = "" Then
'   '       Exit Sub
'   '   End If
'   '
'   '   If Not Table1.Row = 1 Then
'   '      Call Colocardata1
'   '   Else
'   '       Data1.Recordset.MoveFirst
'   '   End If
'   '
'   '    If TxtTotal.Tag <> TxtTotal.Text Then
'   '
'   '        dTotalActual# = TxtTotal.Tag
'   '        dTotalNuevo# = TxtTotal.Text
'   '
'   '        Call VENTA_ValorizarTotal(Data1, dTotalNuevo#, dTotalActual#)
'   '        Data1.Refresh
'   '        Data1.Recordset.MoveFirst
'   ''        For I = 1 To Table1.Rows - 1
'   '          Table1.Row = I
'   '          Call Llenar_Grilla
'   ''          If Not Data1.Recordset.EOF Then
'   ''            Data1.Recordset.MoveNext
'   ''          End If
'   ''        Next I
'   '        Table1.Refresh
'   '    End If
'   'error:
'   '
'   'Screen.MousePointer = vbDefault
'   '
'   ''MsgBox Error(err), vbCritical, gsBac_Version
'   '
'   'Exit Sub
'End Sub

'PRD-6006 CASS 13-12-2010
Public Function Calcula_Monto_Mx(Monto As Double, Monemis As Integer, MonPacto As Integer) As Double
      Dim Monto_Peso As Double
      Dim nFactor As Double
      Dim nRedon  As Integer
      Dim nparidad As Double
      If Monemis = 13 Then
          Monto_Peso = Round(Monto * nDolarOb, 0)
      Else
          Monto_Peso = Monto
      End If
      
      If MonPacto = 998 Then
          nFactor = nUf
          nRedon = 4
      ElseIf MonPacto = 999 Then
          nFactor = 1
          nRedon = 0
      ElseIf MonPacto = 13 Then
          nFactor = CDbl(txtTipoCambio.text) ''nDolarOb
          nRedon = 2
      Else
      '    nparidad = funcBuscaTipcambio(MonPacto, sFecPro)
          nFactor = CDbl(txtTipoCambio.text) '''funcBuscaTipcambio(MonPacto, sFecPro)
          nRedon = 4
      End If
      
      Calcula_Monto_Mx = Round(Monto_Peso / nFactor, nRedon)

End Function

Private Sub TxtTotal_LostFocus()
      Dim dTotalNuevo#, dTotalActual#
      Dim nContador As Double
'
'      '''' se revisar tiene problemas graves
'      Dim I As Integer
      On Error GoTo Error
'
'      If Grilla.TextMatrix(1, 0) = "" Then
'          Exit Sub
'      End If
'
'      If Not Table1.Row = 1 Then
'          Call Colocardata1
'      Else
'          Data1.Recordset.MoveFirst
'      End If
'
          If TxtTotal.Tag <> TxtTotal.text Then
              dTotalActual# = TxtTotal.Tag
              dTotalNuevo# = TxtTotal.text
              
               'PRD-6006 CASS 28-12-2010
               Let nMontoAnterior = TxtTotal.Tag
               Let TxtIngreso.text = TxtTotal.text
               GRILLA.ColSel = Col_MT
               For nContador = 1 To GRILLA.Rows - 1
                  If GRILLA.TextMatrix(nContador, Col_Marca) = "V" Or GRILLA.TextMatrix(nContador, Col_Marca) = "P" Then
                        GRILLA.RowSel = nContador
                        Call Valorizacion_Pactos(vbKeyReturn, True)
                        'lNumReg& = lNumReg& + 1
                  End If
               Next
              
               Let nMontoAnterior = 0
               Let TxtIngreso.text = 0
             
 '             Call VENTA_ValorizarTotal(dTotalNuevo#, dTotalActual#)
''              Data1.Refresh
''              Data1.Recordset.MoveFirst
'      '        For I = 1 To Table1.Rows - 1
'                TABLE1.Row = I
'                Call Llenar_Grilla
'      '          If Not Data1.Recordset.EOF Then
'      '            Data1.Recordset.MoveNext
'      '          End If
'      '        Next I
'              TABLE1.Refresh
          End If
          Exit Sub
Error:
      Screen.MousePointer = vbDefault
      MsgBox Error(err), vbCritical, gsBac_Version

'Exit Sub
End Sub

'ARM PRD-9837
Public Function CargaArchivo_REPO(ByRef xGrilla As MSFlexGrid) As Boolean

'PRD-6010
   Dim oPath      As String
   Dim SQL$, Datos(), xLine$
   Dim nContador  As Long
   Dim nEstado    As Long
   Dim Arreglo()  As String
   Dim X As Long
   Dim ContLinea  As Long
   Dim nNumoper   As Long
   Dim nCorrela   As Long
   Dim nValida    As Long
   Dim nFilas     As Long
   Dim nFilFolio  As Long
   Dim Error      As String
   Dim Msg        As String
   Dim sSerie     As String
   Dim nRutEmisor As Double
   
   Dim nResul     As Long
   Dim CantFolioREPO  As Long
   
   Let Error = ""
   Let Msg = ""
  
   Let SwErrorArch = False
   Let formatorepo = "TXT"

   ContLinea = 0
   nContador = 0
   
   If Right(gsBac_DIRSOMA, 1) <> "\" Then
      Let gsBac_DIRSOMA = gsBac_DIRSOMA & "\"
   End If
   
   Let cNombreArchivo = nom_archivo & Format(gsBac_Fecp, "YY") & Format(gsBac_Fecp, "MM") & Format(gsBac_Fecp, "DD") & ".txt"
   Let oPath = gsBac_DIRSOMA & cNombreArchivo

   If Dir(oPath) = "" Then
      Call MsgBox("El archivo requerido para la carga. [" & cNombreArchivo & "]. no se encuentra... Favor Revisar.", vbExclamation, App.Title)
      Exit Function
   End If
   
   xGrilla.Clear
   Call SettingGridREPO(xGrilla)
   Let xGrilla.Rows = 2
   Let CantFolioREPO = 0
   
   Call LimpiaGrillaErroresSOMA
   Call CargaFoliosREPOBac(GridFolioSOMA)
   Call BuscaFolioAnulado(oPath, cNombreArchivo, GridFolioSOMA)
      
      '-- carga operaciones
    On Error GoTo errOpen
    Open oPath For Input Access Read Shared As #1
    
    On Error GoTo errRead
        
    Do While Not EOF(1)
    
               
        Line Input #1, xLine
       
       
         Arreglo = Split(xLine, vbTab)
         nEstado = 0
         
         If EOF(1) Then
            If xLine = "" Then
               Exit Do
            End If
         End If
         
            
         If Arreglo(1) = "Id.Oferta" Then
             ContLinea = 0
         End If
               
         
         ContLinea = ContLinea + 1
        
        If ContLinea = 1 Then
        
                For X = 0 To UBound(Arreglo)
         
                  Select Case nEstado
                    Case 0
                        If Arreglo(X) = "Fecha Operación" Then
                            nEstado = 1
                        Else
                            GoTo errRead
                        End If
                    Case 1
                        If Arreglo(X) = "Id.Oferta" Then
                            nEstado = 2
                        Else
                            GoTo errRead
                        End If
                    Case 2
                        If Arreglo(X) = "Institución" Then
                            nEstado = 3
                        Else
                            GoTo errRead
                        End If
                    Case 3
                        If Arreglo(X) = "Correlativo" Then
                        '    Exit For
                        nEstado = 4
                        Else
                            GoTo errRead
                        End If
                     Case 4
                         If Arreglo(X) = "Mnemotécnico" Then
                         nEstado = 5
                          Else
                        GoTo errRead
                        End If
                      Case 5
                          If Arreglo(X) = "Monto Nominal" Then
                         nEstado = 6
                          Else
                        GoTo errRead
                        End If
                      Case 6
                          If Arreglo(11) = "Valor Inicial" Then
                          nEstado = 7
                          Else
                        GoTo errRead
                        End If
                      Case 7
                          If Arreglo(12) = "Valor Inicial Acumulado" Then
                         nEstado = 8
                          Else
                        GoTo errRead
                        End If
                      Case 8
                          If Arreglo(13) = "Interés por Cobrar" Then
                         nEstado = 9
                          Else
                        GoTo errRead
                        End If
                       Case 9
                          If Arreglo(14) = "Total Diario" Then
                        Exit For
                          Else
                        GoTo errRead
                        End If
                  End Select
        
                Next X
        
        End If
        
        If ContLinea = 2 Then
            ' nNumoper = Arreglo(0)
           ContLinea = 4
        End If
        
        
'        If ContLinea = 3 Then
'
'
'                For x = 0 To UBound(Arreglo)
'
'                  Select Case nEstado
'                    Case 0
'                        If Arreglo(x) = "Correlativo" Then
'                            nEstado = 1
'
'                        Else
'                            GoTo errRead
'                        End If
'                    Case 1
'                        If Arreglo(x) = "Serie" Then
'                            nEstado = 2
'                        Else
'                            GoTo errRead
'                        End If
'                    Case 2
'                        If Arreglo(x) = "Monto Nominal" Then
'                            nEstado = 3
'                        Else
'                            GoTo errRead
'                        End If
'                    Case 3
'                        If Arreglo(x) = "Valor Presente" Then
'                            Exit For
'                        Else
'                            GoTo errRead
'                        End If
'                  End Select
'
'
'
'                Next x
'
'
'        End If
        
        If ContLinea >= 4 Then
        
            
        
             Envia = Array()
             AddParam Envia, Arreglo(1) 'CDbl(nNumoper)
             AddParam Envia, Arreglo(4)
             AddParam Envia, gsBac_User
             AddParam Envia, CarterasFinancieras
             AddParam Envia, CarterasNormativas
             AddParam Envia, MihWnd
             AddParam Envia, "REPO"
                            
             If Not Bac_Sql_Execute("SP_VALIDAARCHIVO_BCCH", Envia) Then
                Call BacRollBackTransaction
                Call MsgBox("Se ha producido un error en la busqueda.", vbExclamation, App.Title)
                Exit Function
             End If
                    
             If Bac_SQL_Fetch(Datos()) Then
                nValida = Val(Datos(1))
                sSerie = Datos(2)
                nRutEmisor = Datos(3)
             End If


           If Arreglo(0) <> "" And nValida = 2 Then
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 0) = sSerie
                
                If Format(Arreglo(5), FDec0Dec) < 1000 Then
                Arreglo(5) = Arreglo(5) * 1000
                End If
                
                Let xGrilla.TextMatrix(xGrilla.Rows - 1, 1) = Format(CDbl(Replace(Arreglo(5), ",", "")), FDec4Dec)
                
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 2) = 0#
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 3) = 0#
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 4) = 0
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 5) = 0#
                Let xGrilla.TextMatrix(xGrilla.Rows - 1, 6) = Format(Arreglo(6), FDec4Dec) 'Format(CDbl(Replace(Arreglo(6), ":", ",")), 0)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 7) = Format(CDbl(Arreglo(1)), FDec0Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 8) = Format(CDbl(Arreglo(3)), FDec0Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 9) = nRutEmisor
                Let xGrilla.TextMatrix(xGrilla.Rows - 1, 10) = Format(Replace(Arreglo(12), ",", "."), FDec0Dec) 'UCase(MiHoja.Cells(nContador - 1, "M"))
                Let xGrilla.TextMatrix(xGrilla.Rows - 1, 11) = Arreglo(13) 'UCase(MiHoja.Cells(nContador - 1, "N"))
                Let xGrilla.TextMatrix(xGrilla.Rows - 1, 12) = Arreglo(14) 'UCase(MiHoja.Cells(nContador - 1, "O"))
              Let xGrilla.Rows = xGrilla.Rows + 1
              
           Else
                 
              nFilas = xGrilla.Rows - 1
              If Arreglo(0) <> "" Then
                 Call EliminaFolioREPOGrilla(nFilas, CDbl(nNumoper))
                 
                 If nValida = 0 And CantFolioREPO < 1 Then
                    Let Error = Error & "  Serie instrumento [" & Arreglo(1) & "] no esta disponible en cartera BAC, la cual corresponde al siguiente Folio  SOMA: [" & nNumoper & "]" & vbCrLf
                    Let Msg = "Serie Instrumento no está disponible"
                    Call Llena_GrillaErroresREPO(Format(CDbl(nNumoper), FDec0Dec), Format(CDbl(Arreglo(0))), Arreglo(1), Msg, Format(CDbl(Arreglo(3)), FDec4Dec), 0)
                    
                 Else
                    If ContLinea = 4 Then
                        Let Error = Error & "  Folio SOMA   [" & nNumoper & "] ya se encuentra cargado en BAC." & vbCrLf
                        Let Msg = "Folio SOMA, ya se encuentra cargado"
                        Call Llena_GrillaErroresREPO(Format(CDbl(nNumoper), FDec0Dec), Format(CDbl(Arreglo(0))), Arreglo(1), Msg, Format(CDbl(Arreglo(3)), FDec4Dec), 0)
                        CantFolioREPO = CantFolioREPO + 1
                        
                    End If
                    
                 End If
              End If
           
           End If
        
        
        End If

          
        
        nContador = nContador + 1
          
        Let Progreso.Value = nContador
       

    Loop
    
    
  If Len(Error) > 0 Or Len(ErrAnula) > 0 Then
      Call MsgBox("Se han encontrado las siguientes Observaciones:" & vbCrLf & vbCrLf & Error & vbCrLf & ErrAnula & vbCrLf, vbExclamation, App.Title)
  End If
           
    Close #1

    Exit Function
    
   
errOpen:
carga = 0
    Exit Function
    
errRead:
    MsgBox "No se pudo continuar la lectura del archivo. Favor Revisar." & oPath & vbCrLf & err.Description, vbCritical
    Let SwErrorArch = True

End Function
'ARM PRD-9873
Public Sub BuscaFolioAnulado(Ruta As String, NombreArchivo As String, ByRef xGrilla As MSFlexGrid)
'PRD-6010
Dim xLine
Dim nFilFolio As Long
Dim nResul    As Long
Dim oFile     As String
Dim Msg       As String

Let ErrAnula = ""
Let Msg = ""
           
               For nFilFolio = 1 To xGrilla.Rows - 1
                              
                  Open Ruta For Input Access Read Shared As #1
                   Do While Not EOF(1)
    
               
                    Line Input #1, xLine
          
                     If xGrilla.TextMatrix(nFilFolio, 0) <> 0 Then
          
                    If InStr(xLine, xGrilla.TextMatrix(nFilFolio, 0)) = 0 Then
                        Let nResul = nResul + 1
                    Else
                        Let nResul = 0
                        Exit Do
                    End If
                     End If
                    
                   Loop
                   
                   
                    If nResul > 1 Then
                       Let ErrAnula = ErrAnula & " Falta anular operación FLI en BAC con número [" & CDbl(xGrilla.TextMatrix(nFilFolio, 1)) & "], que referencia a folio SOMA[" & CDbl(xGrilla.TextMatrix(nFilFolio, 0)) & "], que ya no existe en archivo [" & NombreArchivo & "]" & vbCrLf
                       Let Msg = "Debe Anular Oparación FLI en BAC [" & CDbl(xGrilla.TextMatrix(nFilFolio, 1)) & "], ya que no existe Folio SOMA en Archivo"
                       Call Llena_GrillaErroresREPO(Format(CDbl(xGrilla.TextMatrix(nFilFolio, 0)), FDec0Dec), 0, "", Msg, 0, 0)
                       nResul = 0
                    End If
                    
                           Close #1
         
               Next nFilFolio
                   
'PRD-6010
End Sub



'ARM PRD-9837
'ARM PRD-9837
Private Sub LimpiaGrillaErroresSOMA()
'PRD-6010
 Dim nFila As Long
   GridErroresSOMA.Clear
   Let GridErroresSOMA.Rows = 1:   Let GridErroresSOMA.FixedRows = 0
   Let GridErroresSOMA.cols = 6:   Let GridErroresSOMA.FixedCols = 0

   Let GridErroresSOMA.TextMatrix(0, 0) = "Folio SOMA":  Let GridErroresSOMA.ColWidth(0) = 700
   Let GridErroresSOMA.TextMatrix(0, 1) = "Corre SOMA":  Let GridErroresSOMA.ColWidth(1) = 500
   Let GridErroresSOMA.TextMatrix(0, 2) = "Serie SOMA":  Let GridErroresSOMA.ColWidth(2) = 1500
   Let GridErroresSOMA.TextMatrix(0, 3) = "Error SOMA":  Let GridErroresSOMA.ColWidth(3) = 3000
   Let GridErroresSOMA.TextMatrix(0, 4) = "Nominal SOMA":  Let GridErroresSOMA.ColWidth(4) = 2000
   Let GridErroresSOMA.TextMatrix(0, 5) = "Nominal BAC":   Let GridErroresSOMA.ColWidth(5) = 2000
   
 

   For nFila = 1 To GridErroresSOMA.Rows - 1
      Let GridErroresSOMA.TextMatrix(nFila, 0) = Format(0, FDec0Dec)
      Let GridErroresSOMA.TextMatrix(nFila, 1) = Format(0, FDec0Dec)
      Let GridErroresSOMA.TextMatrix(nFila, 2) = ""
      Let GridErroresSOMA.TextMatrix(nFila, 3) = ""
      Let GridErroresSOMA.TextMatrix(nFila, 4) = 0#
      Let GridErroresSOMA.TextMatrix(nFila, 5) = 0#

   Next nFila
'PRD-6010
End Sub

'ARM PRD-9837
Public Function CargaArchivo_REPO_Excel(ByRef xGrilla As MSFlexGrid) As Boolean
   Dim oFile      As String
   Dim oPath      As String
   Dim MiExcel    As Object
   Dim MiLibro    As Object
   Dim MiHoja     As Object
   Dim nFilas     As Long
   Dim nContador  As Long
   Dim nSwith     As Boolean
      
   Dim CantFolioSOMA As Long
   Dim ContLinea     As Long
   Dim X             As Long
   Dim nEstado       As Long
   Dim Datos()
   Dim Msg           As String
   Dim Error         As String
   Dim nNumoper      As Long
   Dim nValida       As Long
   Dim sSerie        As String
   Dim nRutEmisor    As Double
   
   If Right(gsBac_DIRSOMA, 1) <> "\" Then
      Let gsBac_DIRSOMA = gsBac_DIRSOMA & "\"
   End If
   
   Let SwErrorArch = False
   Let cNombreArchivo = nom_archivo & Format(gsBac_Fecp, "YY") & Format(gsBac_Fecp, "MM") & Format(gsBac_Fecp, "DD") & ".xlsx"
   Let oPath = gsBac_DIRSOMA & cNombreArchivo

   If Dir(oPath) = "" Then
      Call MsgBox("El archivo requerido para la carga. [" & cNombreArchivo & "]. no se encuentra... Favor Revisar.", vbExclamation, App.Title)
      Exit Function
   End If
    
   Let Error = ""
   Let Msg = ""
  

   ContLinea = 0
   nContador = 0
   
   xGrilla.Clear
   Call SettingGridREPO(xGrilla)
   Let xGrilla.Rows = 2
   Let xGrilla.Redraw = False
   Let formatorepo = "XSL"

   Let CantFolioSOMA = 0
   
   Call LimpiaGrillaErroresSOMA
   Call CargaFoliosREPOBac(GridFolioSOMA)
   Call BuscaFolioAnuladoExcel(oPath, cNombreArchivo, GridFolioSOMA)

   Let Screen.MousePointer = vbHourglass
   Let nFilas = 50

   Set MiExcel = CreateObject("Excel.Application")
   Set MiLibro = MiExcel.Workbooks.Open(oPath)

   Set MiHoja = Nothing
   Set MiHoja = MiLibro.Worksheets(1)

   
   On Error GoTo errRead

   For nContador = 2 To nFilas

      Let Progreso.Value = nContador
      Let LblProgreso.Caption = "Cargando Archivo...  " & Trim(Progreso.Value) & " %"
      Let nEstado = 0
      
      
      If (UCase(MiHoja.Cells(nContador - 1, "A")) <> UCase("")) Then ' if para celda ""
      
         If (UCase(MiHoja.Cells(nContador - 1, "A")) = UCase("id.Oferta")) Then
             ContLinea = 0
         End If
               
         
         ContLinea = ContLinea + 1
        
        If ContLinea = 1 Then

                For X = 0 To 8

                  Select Case nEstado
                    Case 0
                        If (UCase(MiHoja.Cells(nContador - 1, "A")) = UCase("Fecha Operación")) Then
                            nEstado = 1
                        Else
                            GoTo errRead
                        End If
                    Case 1
                        If (UCase(MiHoja.Cells(nContador - 1, "B")) = UCase("id.oferta")) Then
                            nEstado = 2
                        Else
                            GoTo errRead
                        End If
                    Case 2
                        If (UCase(MiHoja.Cells(nContador - 1, "C")) = UCase("Institución")) Then
                            nEstado = 3
                        Else
                            GoTo errRead
                        End If
                    Case 3
                        If (UCase(MiHoja.Cells(nContador - 1, "D")) = UCase("Correlativo")) Then
                            nEstado = 4
                        Else
                            GoTo errRead
                        End If
                    Case 4
                        If (UCase(MiHoja.Cells(nContador - 1, "F")) = UCase("Monto Nominal")) Then
                           nEstado = 5
                        Else
                            GoTo errRead
                        End If
                    Case 5
                        If (UCase(MiHoja.Cells(nContador - 1, "L")) = UCase("Valor Inicial")) Then
                          nEstado = 6
                        Else
                            GoTo errRead
                        End If
                    Case 6
                        If (UCase(MiHoja.Cells(nContador - 1, "M")) = UCase("Valor Inicial Acumulado")) Then
                          nEstado = 7
                        Else
                            GoTo errRead
                        End If
                    Case 7
                        If (UCase(MiHoja.Cells(nContador - 1, "N")) = UCase("Interés por Cobrar")) Then
                          nEstado = 8
                        Else
                            GoTo errRead
                        End If
                    Case 8
                        If (UCase(MiHoja.Cells(nContador - 1, "O")) = UCase("Total Diario")) Then
                            Exit For
                        Else
                            GoTo errRead
                        End If
                  End Select

                Next X

        End If
        
        
        If ContLinea = 2 Then
          '   nNumoper = UCase(MiHoja.Cells(nContador - 1, "A"))
             ContLinea = 4
        End If
        
        
        If ContLinea = 3 Then


                For X = 0 To 3

                  Select Case nEstado
                    Case 0
                        If (UCase(MiHoja.Cells(nContador - 1, "A")) = UCase("Correlativo")) Then
                            nEstado = 1

                        Else
                            GoTo errRead
                        End If
                    Case 1
                        If (UCase(MiHoja.Cells(nContador - 1, "B")) = UCase("Serie")) Then
                            nEstado = 2
                        Else
                            GoTo errRead
                        End If
                    Case 2
                        If (UCase(MiHoja.Cells(nContador - 1, "C")) = UCase("Monto Nominal")) Then
                            nEstado = 3
                        Else
                            GoTo errRead
                        End If
                    Case 3
                        If (UCase(MiHoja.Cells(nContador - 1, "D")) = UCase("Valor Presente")) Then
                            Exit For
                        Else
                            GoTo errRead
                        End If
                  End Select



                Next X


        End If
        

 
        If ContLinea >= 4 Then

             Envia = Array()
             AddParam Envia, UCase(MiHoja.Cells(nContador - 1, "B")) 'CDbl(nNumoper)
             AddParam Envia, UCase(MiHoja.Cells(nContador - 1, "E"))
             AddParam Envia, gsBac_User
             AddParam Envia, CarterasFinancieras
             AddParam Envia, CarterasNormativas
             AddParam Envia, MihWnd
             AddParam Envia, "Repo"

             If Not Bac_Sql_Execute("SP_VALIDAARCHIVO_BCCH", Envia) Then
                Call BacRollBackTransaction
                Call MsgBox("Se ha producido un error en la busqueda.", vbExclamation, App.Title)
                Exit Function
             End If

             If Bac_SQL_Fetch(Datos()) Then
                nValida = Val(Datos(1))
                sSerie = Datos(2)
                nRutEmisor = Datos(3)
             End If


              
           Dim nominaxl As Double
           If UCase(MiHoja.Cells(nContador - 1, "A")) <> "" And nValida = 2 Then
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 0) = sSerie
              
              'Let xGrilla.TextMatrix(xGrilla.Rows - 1, 1) = Format(CDbl(Replace(UCase(MiHoja.Cells(nContador - 1, "F")), ",", "")), FDec0Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 1) = UCase(MiHoja.Cells(nContador - 1, "F"))
              
                  
              If Format(xGrilla.TextMatrix(xGrilla.Rows - 1, 1), FDec0Dec) < 1000 Then
                    nominaxl = Format(xGrilla.TextMatrix(xGrilla.Rows - 1, 1), FDec4Dec) * 1000
                    '= Format(CDbl(Replace(UCase(MiHoja.Cells(nContador - 1, "F")), ",", "")), FDec4Dec) * 1000
                    Let xGrilla.TextMatrix(xGrilla.Rows - 1, 1) = Format(nominaxl, FDec4Dec)
               Else
                    Let xGrilla.TextMatrix(xGrilla.Rows - 1, 1) = Format(CDbl(Replace(UCase(MiHoja.Cells(nContador - 1, "F")), ",", "")), FDec4Dec)
              End If
              
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 2) = 0#
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 3) = 0#
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 4) = 0
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 5) = 0#
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 6) = Format(CDbl(Replace(UCase(MiHoja.Cells(nContador - 1, "L")), ",", "")), FDec0Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 7) = UCase(MiHoja.Cells(nContador - 1, "B")) 'Format(CDbl(nNumoper), FDec0Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 8) = UCase(MiHoja.Cells(nContador - 1, "D"))
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 9) = nRutEmisor
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 10) = UCase(Replace(MiHoja.Cells(nContador - 1, "M"), ",", "."))
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 11) = UCase(Replace(MiHoja.Cells(nContador - 1, "N"), ",", "."))
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 12) = UCase(Replace(MiHoja.Cells(nContador - 1, "O"), ",", "."))
              TotDiario = xGrilla.TextMatrix(xGrilla.Rows - 1, 12)
              Let xGrilla.Rows = xGrilla.Rows + 1


           Else

              nFilas = xGrilla.Rows - 1
              If UCase(MiHoja.Cells(nContador - 1, "A")) <> "" Then
                 Call EliminaFolioREPOGrilla(nFilas, CDbl(nNumoper))

                 If nValida = 2 And CantFolioSOMA < 1 Then
                    Let Error = Error & "  Serie instrumento [" & UCase(MiHoja.Cells(nContador - 1, "B")) & "] no esta disponible en cartera BAC, la cual corresponde al siguiente Folio  SOMA: [" & nNumoper & "]" & vbCrLf
                    Let Msg = "Serie Instrumento no está disponible"
                    Call Llena_GrillaErroresREPO(Format(CDbl(nNumoper), FDec0Dec), Format(CDbl(UCase(MiHoja.Cells(nContador - 1, "A")))), UCase(MiHoja.Cells(nContador - 1, "B")), Msg, Format(CDbl(UCase(MiHoja.Cells(nContador - 1, "D"))), FDec4Dec), 0)

                 Else
                    If ContLinea = 4 Then
                        Let Error = Error & "  Folio SOMA   [" & nNumoper & "] ya se encuentra cargado en BAC." & vbCrLf
                        Let Msg = "Folio SOMA, ya se encuentra cargado"
                        Call Llena_GrillaErroresREPO(Format(CDbl(nNumoper), FDec0Dec), Format(CDbl(UCase(MiHoja.Cells(nContador - 1, "A")))), UCase(MiHoja.Cells(nContador - 1, "B")), Msg, Format(CDbl(UCase(MiHoja.Cells(nContador - 1, "D"))), FDec4Dec), 0)
                        CantFolioSOMA = CantFolioSOMA + 1

                    End If

                 End If
              End If

           End If


        End If

        

        
    End If   ' if para celda ""
              
        Let Progreso.Value = nContador

   Next nContador
   
   If Len(Error) > 0 Or Len(ErrAnula) > 0 Then
      Call MsgBox("Se han encontrado las siguientes Observaciones:" & vbCrLf & vbCrLf & Error & vbCrLf & ErrAnula & vbCrLf, vbExclamation, App.Title)
   End If
   
   
   Set MiHoja = Nothing
   Call MiLibro.Close
   Set MiExcel = Nothing
   
   Let xGrilla.Redraw = True
   Let Progreso.Value = 0
   Let LblProgreso.Caption = "Lectura de Archivo SOMA"
   Let Screen.MousePointer = vbDefault
   
   Call calcula
   
   
   Exit Function
   
errRead:
    MsgBox "No se pudo continuar la lectura del archivo. Favor Revisar." & oPath & vbCrLf & err.Description, vbCritical
    Let SwErrorArch = True
   
End Function
Private Function calcula()

    Dim Base%, Tasa#, ValIni#, Plazo&, TasaTran#

    Base = funcBaseMoneda(CmbMon.ItemData(CmbMon.ListIndex))

    Plazo = CDbl(TxtPlazo.text)
    If Plazo = 0 Then Exit Function
       
    ValIni = CDbl(txtIniPMP.text)
    If ValIni = 0 Then Exit Function
        
    Tasa = CDbl(TxtTasa.text)
    TasaTran = CDbl(Txt_TasaTran.text)
    
    If Tasa = 0 Then Exit Function
   
    If CmbMon.ItemData(CmbMon.ListIndex) = 999 Then
        txtVenPMP.CantidadDecimales = 0
    Else
        txtVenPMP.CantidadDecimales = BacDatGrMon.mndecimal
    End If

    If dTipcam# = 1 Then
    '  txtVenPMP.Text = BacCtrlTransMonto(Int(VI_ValorFinal(ValIni#, Tasa#, Plazo&, Base%)))
    '  Txt_VFTran.Text = BacCtrlTransMonto(Int(VI_ValorFinal(ValIni#, Tasa#, Plazo&, Base%)))
      
      txtVenPMP.text = BacCtrlTransMonto(Round(VI_ValorFinal(ValIni#, Tasa#, Plazo&, Base%), 0))
      Txt_VFTran.text = BacCtrlTransMonto(Round(VI_ValorFinal(ValIni#, Tasa#, Plazo&, Base%), 0))
    Else
      txtVenPMP.text = BacCtrlTransMonto(VI_ValorFinal(ValIni#, Tasa#, Plazo&, Base%))
      Txt_VFTran.text = BacCtrlTransMonto(VI_ValorFinal(ValIni#, TasaTran#, Plazo&, Base%))
    End If
   
   
   '->   Formula Original.-
    '->  Txt_DifTran.Text = (txtVenPMP.Text - Txt_VFTran.Text) / (1 + TasaTran / 100 * Plazo / 360)
    
   '->   Cambio Realizado el 15-05-2013.-
         Txt_DifTran.text = (Txt_VFTran.text - txtVenPMP.text) / (1 + TasaTran / 100 * Plazo / 360)

    If dTipcam# = 1 Then
        Txt_Dif_CLP.text = Txt_DifTran.text
    Else
        Txt_Dif_CLP.text = Txt_DifTran.text * dTipcam#
    End If
End Function

'ARM PRD-9837
Private Sub Llena_GrillaErroresREPO(Numoper As Long, correla As Long, Serie As String, Mensaje As String, NominalSoma As Double, NominalBac As Double)
'PRD-6010
   Let GridErroresSOMA.Rows = GridErroresSOMA.Rows + 1
   Let GridErroresSOMA.TextMatrix(GridErroresSOMA.Rows - 1, 0) = Numoper
   Let GridErroresSOMA.TextMatrix(GridErroresSOMA.Rows - 1, 1) = correla
   Let GridErroresSOMA.TextMatrix(GridErroresSOMA.Rows - 1, 2) = Serie
   Let GridErroresSOMA.TextMatrix(GridErroresSOMA.Rows - 1, 3) = Mensaje
   Let GridErroresSOMA.TextMatrix(GridErroresSOMA.Rows - 1, 4) = NominalSoma
   Let GridErroresSOMA.TextMatrix(GridErroresSOMA.Rows - 1, 5) = NominalBac

'PRD-6010
End Sub


'ARM Private
Sub EliminaFolioREPOGrilla(Filas As Long, nOper As Long)
'PRD-6010
Dim nCont   As Long

For nCont = 1 To Filas - 1
  If GrillaSoma.TextMatrix(nCont, 7) = nOper Then   '' And GrillaSoma.TextMatrix(nCont, 7) = ""
    GrillaSoma.RemoveItem nCont
  End If
Next nCont
'PRD-6010
End Sub

'ARM PRD-9837
Public Sub BuscaFolioAnuladoExcel(Ruta As String, NombreArchivo As String, ByRef xGrilla As MSFlexGrid)
'PRD-6010
Dim xLine
Dim nFilFolio As Long
Dim nResul    As Long
Dim oFile     As String
Dim Msg       As String
Dim oPath     As String
Dim MiHoja    As Object
Dim nContador As Long
Dim nFilas    As Long
Dim ContLinea As Long
Dim X         As Long
Dim nEstado   As Long
Dim nNumoper  As Long
Let ErrAnula = ""
Let Msg = ""


   If Dir(Ruta) = "" Then
      Call MsgBox("El archivo requerido para la carga. [" & NombreArchivo & "]. no se encuentra... Favor Revisar.", vbExclamation, App.Title)
      Exit Sub
   End If

   Let nFilas = 50
   
   Set MiExcel = CreateObject("Excel.Application")
   Set MiLibro = MiExcel.Workbooks.Open(Ruta)

   Set MiHoja = Nothing
   Set MiHoja = MiLibro.Worksheets(1)

   

       For nFilFolio = 1 To xGrilla.Rows - 1
           
              For nContador = 2 To nFilas
              
               If UCase(MiHoja.Cells(nContador - 1, "A")) <> UCase("") Then
                                          
                  If xGrilla.TextMatrix(nFilFolio, 0) <> 0 Then
                    If InStr(UCase(MiHoja.Cells(nContador - 1, "A")), xGrilla.TextMatrix(nFilFolio, 0)) = 0 Then
                        Let nResul = nResul + 1
                    Else
                        Let nResul = 0
                        Exit For
                    End If
               End If
               End If
              
              Next nContador
              
                    If nResul > 1 Then
                       Let ErrAnula = ErrAnula & " Falta anular operación FLI en BAC con número [" & CDbl(xGrilla.TextMatrix(nFilFolio, 1)) & "], que referencia a folio SOMA[" & CDbl(xGrilla.TextMatrix(nFilFolio, 0)) & "], que ya no existe en archivo [" & NombreArchivo & "]" & vbCrLf
                       Let Msg = "Debe Anular Oparación FLI en BAC [" & CDbl(xGrilla.TextMatrix(nFilFolio, 1)) & "], ya que no existe Folio SOMA en Archivo"

                       nResul = 0
                    End If

      Next nFilFolio
      
      Set MiHoja = Nothing
      Call MiLibro.Close
      Set MiExcel = Nothing


'PRD-6010
End Sub



'ARM PRD-9837
Public Sub CargaFoliosREPOBac(ByRef xGrilla As MSFlexGrid)
'PRD-6010
Dim Datos()

xGrilla.Clear

   Let xGrilla.TextMatrix(0, 0) = "Folio SOMA"
   Let xGrilla.TextMatrix(0, 1) = "Oper BAC"


Let xGrilla.Rows = 1
   Envia = Array()
   AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")
   AddParam Envia, "Repo"
   If Not Bac_Sql_Execute("dbo.SP_TRAEFOLIOSSOMA", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha originado un error en la lectura de operaciones." & vbCrLf & vbCrLf & VerSql, vbExclamation, App.Title)
      Exit Sub
   End If
   
   Do While Bac_SQL_Fetch(Datos())
      Let xGrilla.Rows = xGrilla.Rows + 1
      Let xGrilla.TextMatrix(xGrilla.Rows - 1, 0) = Datos(1)
      Let xGrilla.TextMatrix(xGrilla.Rows - 1, 1) = Datos(2)
      
   Loop
     
'PRD-6010


End Sub
'ARM PRD-9837
Private Function Proc_TasaPoliticaMonetaria()
    Dim Datos()
    Dim nTasa As Double
    
    If Not Bac_Sql_Execute("SP_TASAPOLITICAMONETARIA") Then
        MsgBox "Error al Rescatar Tasa Política Monetaria", vbInformation, App.Title
        Exit Function
    End If

    Do While Bac_SQL_Fetch(Datos())
        nTasa = BacCtrlTransMonto(Datos(1))
    Loop
    
    If nTasa <> 0 Then
      Proc_TasaPoliticaMonetaria = nTasa
    End If
End Function

'ARM PRD-9837

Private Sub SettingGridREPO(ByRef xGrilla As MSFlexGrid)
   Let xGrilla.Rows = 2:   Let xGrilla.FixedRows = 1
   Let xGrilla.cols = 13:   Let xGrilla.FixedCols = 0

   Let xGrilla.TextMatrix(0, 0) = "Serie":               Let xGrilla.ColWidth(0) = 1300
   Let xGrilla.TextMatrix(0, 1) = "Nominal":             Let xGrilla.ColWidth(1) = 2000
   Let xGrilla.TextMatrix(0, 2) = "Tasa":                Let xGrilla.ColWidth(2) = 1000
   Let xGrilla.TextMatrix(0, 3) = "Valor Referencial":   Let xGrilla.ColWidth(3) = 2500
   Let xGrilla.TextMatrix(0, 4) = "Plazo":               Let xGrilla.ColWidth(4) = 1000
   Let xGrilla.TextMatrix(0, 5) = "Margen":              Let xGrilla.ColWidth(5) = 1000
   Let xGrilla.TextMatrix(0, 6) = "Valor Inicial":       Let xGrilla.ColWidth(6) = 2500
   Let xGrilla.TextMatrix(0, 7) = "ID":                  Let xGrilla.ColWidth(7) = 1000  'PRD-6010
   Let xGrilla.TextMatrix(0, 8) = "Correlativo":         Let xGrilla.ColWidth(8) = 1000  'PRD-6010
   Let xGrilla.TextMatrix(0, 9) = "RutEmisor":           Let xGrilla.ColWidth(9) = 1500  'PRD-6010
   Let xGrilla.TextMatrix(0, 10) = "Valor Inicial Acumulado": Let xGrilla.ColWidth(10) = 2000
   Let xGrilla.TextMatrix(0, 11) = "Interés por Cobrar":      Let xGrilla.ColWidth(11) = 2000
   Let xGrilla.TextMatrix(0, 12) = "Total Diario":            Let xGrilla.ColWidth(12) = 2000
   Let xGrilla.Rows = 1
End Sub


'ARM PRD-9837

'ARM PRD-9837
    Public Function Realizar_Fli_Soma()
   Dim nNumCargas As Long
   Dim nFilasSoma As Long
   Dim nFilas     As Long
   
   Dim xSerie     As String
   Dim xNominal   As Double
   Dim xTasa      As Double
   Dim xValor     As Double
   
   Dim xPlazo     As Long
   Dim xMargen    As Double
   Dim xVInicial  As Double
   Dim xIdSOMA    As Long
   Dim xCorrelaSOMA As Long
   Dim xRutEmisor As Double
   
   
   
   Dim err      As String
   Dim Error      As String
   Dim nFil     As Long
   Dim Msg        As String
   Dim nCont     As Long
   Dim Conta     As Long
   Dim Mensaje   As String
   Dim SumNominal As Double
   Dim DifNominal As Double
   Dim nFactorSoma As Double
   Dim nNominalArchSOMA As Double
   Dim SW         As Boolean
   Dim DescFLI    As Double
   Dim TotDiario As String
   
   Let err = ""
   Let Error = ""
   Let Msg = ""
   Let Conta = 0
   Let Mensaje = ""
   Let SumNominal = 0
   Let nNominalArchSOMA = 0
   
   Let GRILLA.Redraw = False
   Let nNumCargas = 0
   Let DescFLI = 0
    Let TotDiario = 0
   Call LimpiaFolioREPO_GRILLA   'PRD-6010
   
   On Error GoTo ErrStock
   
   '->> Lee Filas de la Grilla SOMA
   For nFilasSoma = 1 To GrillaSoma.Rows - 2
      
      Let DifNominal = 0
      Let SumNominal = 0
      Let Conta = 0
      Let DescFLI = 0
      Let SW = False
     
      '->> Asigna variables SOMA
      If Trim(GrillaSoma.TextMatrix(nFilasSoma, 0)) = "" Then
        Exit Function
        
      End If
      
      Let xSerie = Trim(GrillaSoma.TextMatrix(nFilasSoma, 0))
      Let xNominal = GrillaSoma.TextMatrix(nFilasSoma, 1)
      Let xTasa = GrillaSoma.TextMatrix(nFilasSoma, 2)
      Let xValor = GrillaSoma.TextMatrix(nFilasSoma, 6)        'PRD-6010
      Let xPlazo = GrillaSoma.TextMatrix(nFilasSoma, 4)
      Let xMargen = GrillaSoma.TextMatrix(nFilasSoma, 5)
      Let xVInicial = GrillaSoma.TextMatrix(nFilasSoma, 6)
     ' Let totDiario = totDiario + xVInicial
      Let xIdSOMA = GrillaSoma.TextMatrix(nFilasSoma, 7)       'PRD-6010
      Let xCorrelaSOMA = GrillaSoma.TextMatrix(nFilasSoma, 8)  'PRD-6010
      Let xRutEmisor = GrillaSoma.TextMatrix(nFilasSoma, 9)    'PRD-6010
      
      Let nNominalArchSOMA = xNominal
      Let DescFLI = GrillaSoma.TextMatrix(nFilasSoma, 1)
      
      Let err = ""
     Let bCargaArchivo = False
      
      
        For nCont = 1 To GRILLA.Rows - 1
          If GRILLA.TextMatrix(nCont, COL_Serie) = xSerie And CDbl(GRILLA.TextMatrix(nCont, Col_Emisor)) = CDbl(xRutEmisor) Then
            Let SumNominal = SumNominal + GRILLA.TextMatrix(nCont, Col_Nominal)
            Let SW = False
            If xNominal <= CDbl(GRILLA.TextMatrix(nCont, Col_Nominal)) Then
               If xNominal = CDbl(GRILLA.TextMatrix(nCont, Col_Nominal)) Then
                   Let SW = True
               End If
               Exit For
            End If
             Let Conta = Conta + 1
             Let Mensaje = Mensaje + " " + GRILLA.TextMatrix(nCont, COL_Serie) + " " + GRILLA.TextMatrix(nCont, Col_Nominal)
          End If
        Next nCont
              
      '->> Lee Filas de la Grilla de Operaciones
      For nFilas = 1 To GRILLA.Rows - 1

         '->> Valida que corresponda a la Serie
         If GRILLA.TextMatrix(nFilas, COL_Serie) = xSerie Then

            If CDbl(SumNominal) < xNominal And CDbl(GRILLA.TextMatrix(nFilas, Col_Emisor)) = CDbl(xRutEmisor) Then
               If VerificaSerieREPO(xSerie, xIdSOMA, xCorrelaSOMA) = True Then
                  Exit For
               End If
               If VerificaSerieREPO_Errores(xSerie, xIdSOMA, xCorrelaSOMA) = True Then
                  Let err = err & "Serie Instrumento [" & xSerie & "] No será cargado, por problemas en otros registros correspondiente Folio Soma [" & xIdSOMA & "]" & vbCrLf
                  Let Msg = "Serie Instrumento no será cargada por problemas en otros registros correspondientes al mismo folio"
                  Call Llena_GrillaErroresREPO(Format(CDbl(xIdSOMA), FDec0Dec), Format(CDbl(xCorrelaSOMA)), xSerie, Msg, xNominal, GRILLA.TextMatrix(nFilas, Col_Nominal))
                  Exit For
               End If

               Let err = err & "Falta Stock o disponibilidad de Nominal para la serie: [" & xSerie & "], la cual corresponde a Folio SOMA: [" & xIdSOMA & "]" & vbCrLf     'PRD-6010
               Let Msg = "Falta Stock o disponibilidad de Nominal"
               Call Llena_GrillaErroresREPO(Format(CDbl(xIdSOMA), FDec0Dec), Format(CDbl(xCorrelaSOMA)), xSerie, Msg, xNominal, GRILLA.TextMatrix(nFilas, Col_Nominal))
               Exit For
               
            Else
               
           'PRD-6010
              If CDbl(GRILLA.TextMatrix(nFilas, Col_Emisor)) = CDbl(xRutEmisor) And Conta <= 1 Then
                If VerificaSerieREPO(xSerie, xIdSOMA, xCorrelaSOMA) = True Then
                  Let err = err & "Serie Instrumento [" & xSerie & "] ya tiene asignado un Folio SOMA. Debe cargar nuevamente el siguiente Folio Soma [" & xIdSOMA & "]" & vbCrLf
                  Let Msg = "Serie Instrumento ya tiene asignado un Folio SOMA"
                  Call Llena_GrillaErroresREPO(Format(CDbl(xIdSOMA), FDec0Dec), Format(CDbl(xCorrelaSOMA)), xSerie, Msg, xNominal, GRILLA.TextMatrix(nFilas, Col_Nominal))
                  Exit For
                End If
              Else
                  If xNominal = 0 Then
                     Exit For
                  End If
              End If
              
              If VerificaSerieREPO_Errores(xSerie, xIdSOMA, xCorrelaSOMA) = True Then
                  Let err = err & "Serie Instrumento [" & xSerie & "] No será cargado, por problemas en otros registros correspondiente Folio Soma [" & xIdSOMA & "]" & vbCrLf
                  Let Msg = "Serie Instrumento no será cargada por problemas en otros registros correspondientes al mismo folio"
                  Call Llena_GrillaErroresREPO(Format(CDbl(xIdSOMA), FDec0Dec), Format(CDbl(xCorrelaSOMA)), xSerie, Msg, xNominal, GRILLA.TextMatrix(nFilas, Col_Nominal))
                 Exit For
              End If
           'PRD-6010
               

               If Len(err) = 0 And CDbl(GRILLA.TextMatrix(nFilas, Col_Emisor)) = CDbl(xRutEmisor) And DescFLI <> 0 Then
                  Let DifNominal = CDbl(xNominal) - GRILLA.TextMatrix(nFilas, Col_Nominal)
                  Let nFactorSoma = CDbl(xVInicial / nNominalArchSOMA)
                  If GRILLA.TextMatrix(nFilas, Col_Nominal) = CDbl(xNominal) And SW = True Then
                        
                     Let nNumCargas = nNumCargas + 1
                     Let GRILLA.TextMatrix(nFilas, Col_Nominal) = GRILLA.TextMatrix(nFilas, Col_Nominal) ''Format(xNominal, FDec4Dec)
                     Let GRILLA.TextMatrix(nFilas, Col_Tir) = Format(xTasa, FDec4Dec)
                     Let GRILLA.TextMatrix(nFilas, Col_MT) = CDbl(GRILLA.TextMatrix(nFilas, Col_Nominal) * nFactorSoma) / IIf(GRILLA.TextMatrix(nFilas, Col_Margen) = 0, 1, GRILLA.TextMatrix(nFilas, Col_Margen)) 'PRD-6010
                     Let GRILLA.TextMatrix(nFilas, Col_ValInicial) = CDbl(GRILLA.TextMatrix(nFilas, Col_Nominal) * nFactorSoma) '' Format(xVInicial, FDec0Dec)
                     Let GRILLA.TextMatrix(nFilas, Col_ID_SOMA) = Format(xIdSOMA, FDec0Dec)      'PRD-6010
                     Let GRILLA.TextMatrix(nFilas, Col_Correla_SOMA) = Format(xCorrelaSOMA, FDec0Dec) 'PRD-6010

                        Let GRILLA.Row = nFilas:   Let GRILLA.Col = Col_Tir

                        If TomarPapel Then
                                Toolbar1.Buttons(5).Enabled = True
                                Let TxtIngreso.text = GRILLA.TextMatrix(nFilas, Col_Nominal)
                                Call Valorizacion_Fli(vbKeyV)
                                Let bCargaArchivo = True
    
                        End If
                        Let xNominal = DifNominal
                        Exit For
                  End If
                    If SW = False Then
                     If GRILLA.TextMatrix(nFilas, Col_Nominal) < CDbl(xNominal) Then
                        
                        Let nNumCargas = nNumCargas + 1
                        Let GRILLA.TextMatrix(nFilas, Col_Nominal) = GRILLA.TextMatrix(nFilas, Col_Nominal) ''Format(xNominal, FDec4Dec)
                        Let GRILLA.TextMatrix(nFilas, Col_Tir) = Format(xTasa, FDec4Dec)
                        Let GRILLA.TextMatrix(nFilas, Col_MT) = CDbl(GRILLA.TextMatrix(nFilas, Col_Nominal) * nFactorSoma) / IIf(GRILLA.TextMatrix(nFilas, Col_Margen) = 0, 1, GRILLA.TextMatrix(nFilas, Col_Margen)) 'PRD-6010
                        Let GRILLA.TextMatrix(nFilas, Col_ValInicial) = CDbl(GRILLA.TextMatrix(nFilas, Col_Nominal) * nFactorSoma) '' Format(xVInicial, FDec0Dec)
                        Let GRILLA.TextMatrix(nFilas, Col_ID_SOMA) = Format(xIdSOMA, FDec0Dec)      'PRD-6010
                        Let GRILLA.TextMatrix(nFilas, Col_Correla_SOMA) = Format(xCorrelaSOMA, FDec0Dec) 'PRD-6010

                        Let GRILLA.Row = nFilas:   Let GRILLA.Col = Col_Tir

                        If TomarPapel Then
                                Toolbar1.Buttons(5).Enabled = True
                                Let TxtIngreso.text = GRILLA.TextMatrix(nFilas, Col_Nominal)
                                Call Valorizacion_Fli(vbKeyV)
                                Let bCargaArchivo = True
    
                        End If
                        Let xNominal = DifNominal
                    Else
                        Let DifNominal = CDbl(xNominal)
                        Let nNumCargas = nNumCargas + 1
                        Let GRILLA.TextMatrix(nFilas, Col_Nominal) = Format(CDbl(DifNominal), FDec4Dec) ''Format(xNominal, FDec4Dec)
                        tserie = xSerie
                        Let GRILLA.TextMatrix(nFilas, Col_Tir) = tasa_referencial 'Format(xTasa, FDec4Dec)
                        Let GRILLA.TextMatrix(nFilas, Col_MT) = Format(CDbl(DifNominal * nFactorSoma) / IIf(GRILLA.TextMatrix(nFilas, Col_Margen) = 0, 1, GRILLA.TextMatrix(nFilas, Col_Margen)), FDec0Dec) 'PRD-6010
                        Let GRILLA.TextMatrix(nFilas, Col_ValInicial) = Format(CDbl(DifNominal * CDbl(nFactorSoma)), FDec4Dec)
                        Let GRILLA.TextMatrix(nFilas, Col_ID_SOMA) = Format(xIdSOMA, FDec0Dec)      'PRD-6010
                        Let GRILLA.TextMatrix(nFilas, Col_Correla_SOMA) = Format(xCorrelaSOMA, FDec0Dec) 'PRD-6010
                   '    Let GRILLA.TextMatrix(nFilas, Col_Margen) = margen_soma
                        Let GRILLA.Row = nFilas:   Let GRILLA.Col = Col_Tir

                        If TomarPapel Then
                            Toolbar1.Buttons(5).Enabled = True
                            Let TxtIngreso.text = GRILLA.TextMatrix(nFilas, Col_Nominal)
                            Call Valorizacion_Fli(vbKeyV)
                            Let bCargaArchivo = True
                        End If
                        
                        If Conta = 0 Then
                           Exit For
                        End If
                  
                        
                    End If
                  End If
                  
                   Let DescFLI = DescFLI - GRILLA.TextMatrix(nFilas, Col_Nominal)
                End If
               
            End If
         End If
      Next nFilas
      
        Let Error = Error + err
        
        'PRD-6010
        If Len(err) <> 0 Then
        
           For nFil = 1 To GRILLA.Rows - 1
              If xIdSOMA = GRILLA.TextMatrix(nFil, Col_ID_SOMA) Then
                  Let GRILLA.TextMatrix(nFil, Col_ID_SOMA) = Format(0, FDec0Dec)
                  Let GRILLA.TextMatrix(nFil, Col_Correla_SOMA) = Format(0, FDec0Dec)
                  Call SoltarPapel
                  Let GRILLA.TextMatrix(nFil, Col_Nominal) = Format(CDbl(GRILLA.TextMatrix(nFil, Col_Nominal_ORIG)), FDec4Dec)
                  Let GRILLA.TextMatrix(nFil, Col_Tir) = Format(CDbl(GRILLA.TextMatrix(nFil, Col_Tir_ORIG)), FDec4Dec)
                  Let GRILLA.TextMatrix(nFil, Col_VPar) = Format(CDbl(GRILLA.TextMatrix(nFil, Col_VPar_ORIG)), FDec4Dec)
                  Let GRILLA.TextMatrix(nFil, Col_MT) = Format(CDbl(GRILLA.TextMatrix(nFil, Col_MT_ORIG)), FDec0Dec)
                  Let GRILLA.TextMatrix(nFil, Col_Margen) = Format(CDbl(GRILLA.TextMatrix(nFil, Col_Margen_ORIG)), FDec4Dec)
                  Let GRILLA.TextMatrix(nFil, Col_ValInicial) = Format(CDbl(GRILLA.TextMatrix(nFil, Col_ValInicial_ORIG)), FDec0Dec)
                  
              End If
           Next nFil
        
        End If
        'PRD-6010
        
        
   Next nFilasSoma

 
 '
   Let GRILLA.Redraw = True
'''   Call GRILLA.SetFocus
   
   If nNumCargas < GrillaSoma.Rows - 2 Then
   'PRD-6010
'''
'''      Call MsgBox("Existen Series sin Disponibilidad para cargar el SOMA.", vbExclamation, App.Title)
'''      Call SoltarTodos
'''      Let grilla.Rows = 1
'''      Let GrillaSoma.Rows = 1
'''
'''      Let Toolbar1.Buttons(2).Enabled = False
'''      Let Toolbar1.Buttons(3).Enabled = True
'''      Let Toolbar1.Buttons(10).Enabled = False
'''      Let Toolbar1.Buttons(11).Enabled = False
   'PRD-6010
   End If
   
    If nNumCargas = GrillaSoma.Rows - 2 And nNumCargas <> 0 Then
      Call MsgBox("Todos lo Folios SOMA han sido cargados.", vbExclamation, App.Title)
'''      Let Toolbar1.Buttons(10).Enabled = False
    End If
   
ErrStock:
   If Len(Error) > 0 Then
      Call MsgBox("Se han encontrado Observaciones en la carga del Fli SOMA :" & vbCrLf & vbCrLf & Error, vbExclamation, App.Title)
'      Let Toolbar1.Buttons(10).Enabled = False 20181220.RCH.LCGP
      Let Toolbar1.Buttons(11).Enabled = False
   End If
  
 ' Verifica que que valorize solo cuando este cargado el archivo
  Dim X As Integer
  Dim carga As String

   With GRILLA
     For X = 1 To GRILLA.Rows - 1
       If GRILLA.TextMatrix(X, 0) = "P" Then
          carga = "OK"
          Exit For
       End If
     Next X
   End With

   
 If carga = "OK" Then
    If formatorepo = "XSL" Then
     Call Valorizacion_Pactos_REPO_EXCEL(vbKeyReturn, True)
    Else
     Call Valorizacion_Pactos_REPO_TXT(vbKeyReturn, True)
    End If
End If
   Exit Function
   
End Function

Function tasa_referencial()
 Dim SqlDatos()
 Envia = Array()
 AddParam Envia, Mid(tserie, 1, 3)
       If Not Bac_Sql_Execute("dbo.SP_TRAE_TASA_REFERENCIAL ", Envia) Then
        Call MsgBox("Se ha producido un error al cargar tasa referencial.", vbExclamation, App.Title)
        
        Exit Function
    End If
     If Bac_SQL_Fetch(SqlDatos()) Then
               tasa_referencial = SqlDatos(1)
               Exit Function
     Else
               tasa_referencial = Format(0, FDec4Dec)
               Exit Function
     End If
End Function
Function haircut()
 Dim SqlDatos()
 Envia = Array()
 nom_archivo = ""
 Dim C As Integer
 C = 1
 If Combo_Doc.Visible = True And Combo_Doc.ListIndex <> 0 Then
    nom_archivo = Combo_Doc.text
 Else
    nom_archivo = "REPO"
 End If
 
 'AddParam Envia, Mid(nom_archivo, 1, 3)
 AddParam Envia, Mid(tserie, 1, 3)
       If Not Bac_Sql_Execute("dbo.SP_TRAE_HAIRCUT_SOMA", Envia) Then
       ' Call MsgBox("Se ha producido un error al cargar margen de instrumento soma.", vbExclamation, App.Title)
        
        Exit Function
    End If
     If Bac_SQL_Fetch(SqlDatos()) Then
               haircut = SqlDatos(1)
               Exit Function
     Else
               haircut = 0 'Grilla.TextMatrix(selhaircut, 10)
               C = C + 1
               Exit Function
     End If
End Function

Function margen_soma()
 Dim SqlDatos()
 Envia = Array()
 nom_archivo = ""
 Dim C As Integer
 C = 1
 If Combo_Doc.Visible = True And Combo_Doc.ListIndex <> 0 Then
    nom_archivo = Combo_Doc.text
 Else
    nom_archivo = "REPO"
 End If
 
 AddParam Envia, Mid(nom_archivo, 1, 3)
 AddParam Envia, Mid(tserie, 1, 3)
       If Not Bac_Sql_Execute("dbo.SP_MARGEN_INSTRUMENTO_SOMA", Envia) Then
       ' Call MsgBox("Se ha producido un error al cargar margen de instrumento soma.", vbExclamation, App.Title)
        
        Exit Function
    End If
     If Bac_SQL_Fetch(SqlDatos()) Then
               margen_soma = SqlDatos(1)
               Exit Function
     Else
               margen_soma = GRILLA.TextMatrix(X, 8)
               C = C + 1
               Exit Function
     End If
End Function
'ARM PRD - 9837
Private Function Valorizacion_Fli(ByVal xTecla As KeyCodeConstants)
Dim nMargen As Double
Dim Datos()
Dim sCalculoVInicial As String * 1
Dim dMontoNominalOriginal As Double
Dim dMontoPresenteOriginal As Double
Dim dRespaldoNominal    As Double

    If xTecla = vbKeyV Then
        Let nModoCalculo = 3
        Let nFactor = 0
    Else
        If GRILLA.ColSel = Col_Marca Then: Let nModoCalculo = 2
        If GRILLA.ColSel = Col_Nominal Then: Let nModoCalculo = 2
        If GRILLA.ColSel = Col_Tir Then: Let nModoCalculo = 2
        If GRILLA.ColSel = Col_MT Then: Let nModoCalculo = 3
        If GRILLA.ColSel = Col_ValInicial Then: Let nModoCalculo = 4
   
        If nModoCalculo = 3 Then
            If nMontoAnterior = 0 Then
                Let nFactor = 1
            Else
                Let nFactor = (CDbl(TxtIngreso.text) / nMontoAnterior)
            End If
        End If
      
        If nModoCalculo = 4 Then
            If nMontoAnterior = 0 Then
                Let nFactor = 1
            Else
                Let nFactor = Round((TxtIngreso.text / GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), 0)
                Let GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = nFactor
                Let nFactor = nFactor / nMontoAnterior
            End If
        End If
        
    End If

   dRespaldoNominal = GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal)
   
    If nModoCalculo = 3 Then
        If GRILLA.ColSel = Col_MT Then
            Let nMonto = GRILLA.TextMatrix(GRILLA.RowSel, Col_MT)
        End If
        
        If GRILLA.ColSel = Col_ValInicial Then
            If CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)) = 0 Then
                Let nMonto = GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) / 1
            Else
                Let nMonto = Round(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) / GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen), 0)
            ' Let nMonto = Grilla.TextMatrix(Grilla.RowSel, Col_ValInicial) / Grilla.TextMatrix(Grilla.RowSel, Col_Margen)
            End If
            
        End If
         
    End If
   
    sCalculoVInicial = "N"
    
    If nModoCalculo = 4 Then
        sCalculoVInicial = "S"
        Let nModoCalculo = 3
    End If
   
    If (oPagoParcial And EstaPagando) Then  '--> Es para asignar todo los papales como calculados
        If xTecla = vbKeyV Then
            sCalculoVInicial = "T"
        ElseIf GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal) = GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG) And GRILLA.ColSel = Col_Nominal Then
            sCalculoVInicial = "T"
        ElseIf GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = GRILLA.TextMatrix(GRILLA.RowSel, Col_MT_ORIG) And GRILLA.ColSel = Col_MT Then
            sCalculoVInicial = "T"
        ElseIf GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) = GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial_ORIG) And GRILLA.ColSel = Col_ValInicial Then
            sCalculoVInicial = "T"
        End If
    End If
  
    If sCalculoVInicial <> "T" Then
        If (oPagoParcial And EstaPagando) Then  '--> Es para asignar todo los papales como calculados
        
            If GRILLA.ColSel = Col_MT Or GRILLA.ColSel = Col_ValInicial Then
                Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal) = dRespaldoNominal
                'Let Grilla.TextMatrix(Grilla.RowSel, Col_Nominal) = Round(((Grilla.TextMatrix(Grilla.RowSel, Col_MT) * Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)) / Grilla.TextMatrix(Grilla.RowSel, Col_MT_ORIG)), 0)
                ' Let Grilla.TextMatrix(Grilla.RowSel, Col_Nominal) = ((Grilla.TextMatrix(Grilla.RowSel, Col_MT) * Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)) / Grilla.TextMatrix(Grilla.RowSel, Col_MT_ORIG))
                
            End If
        
        End If
    End If
    
    Let cMascara = GRILLA.TextMatrix(GRILLA.RowSel, COL_Serie)
    Let nNominal = GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal)
    Let nTir = GRILLA.TextMatrix(GRILLA.RowSel, Col_Tir)
    Let nPvp = GRILLA.TextMatrix(GRILLA.RowSel, Col_VPar)
    Let nMonto = GRILLA.TextMatrix(GRILLA.RowSel, Col_MT)
    Let nMargen = GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)
    Let dMontoNominalOriginal = GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)
    Let dMontoPresenteOriginal = GRILLA.TextMatrix(GRILLA.RowSel, Col_MT_ORIG)
    
    
    Let cFecCal = Format(gsBac_Fecp, "yyyymmdd")
    Let nValorInicial = GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial)
    Let cUsuario = gsBac_User
    Let nVentana = MihWnd

    Envia = Array()
    AddParam Envia, nModoCalculo
    AddParam Envia, cMascara
    AddParam Envia, nNominal
    AddParam Envia, nTir
    AddParam Envia, nPvp
    AddParam Envia, nMonto
    AddParam Envia, cFecCal
    AddParam Envia, nFactor
    AddParam Envia, nValorInicial
    AddParam Envia, cUsuario
    AddParam Envia, nVentana
    
   
    If GRILLA.ColSel = Col_Nominal And CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)) <> CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal)) And xTecla <> vbKeyV Then
        AddParam Envia, "N"
    Else
        AddParam Envia, IIf(oPagoParcial, "S", "N") '--> Este es nuevo para control de valorizacion
    End If
    
    AddParam Envia, sCalculoVInicial
    
    If oPagoParcial And EstaPagando And GRILLA.ColSel = Col_Nominal Then
        AddParam Envia, "N"
    Else
        AddParam Envia, IIf(oPagoParcial And EstaPagando, "S", "N") '--> Este es el ultimo control para la valorizacion del pago
    End If
    
    AddParam Envia, CDbl(dMontoNominalOriginal)
    AddParam Envia, CDbl(dMontoPresenteOriginal)
    AddParam Envia, GRILLA.TextMatrix(GRILLA.RowSel, Col_CodCarteraSuper)
    AddParam Envia, CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_HairCut))   'PRD-6007 - 6010
    AddParam Envia, CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ID_SOMA)) 'PRD-6010
    AddParam Envia, CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Correla_SOMA))  'PRD-6010
    AddParam Envia, CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Emisor))


    
    If Not Bac_Sql_Execute("dbo.SP_VALORIZADETALLEFLI", Envia) Then
        Call MsgBox("Se ha producido un error en la Valorizacion del instrumento.", vbExclamation, App.Title)
        Call SoltarPapel
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then
    
        If Datos(1) < 0 Then
        
            Call MsgBox(Datos(2), vbExclamation, App.Title)
            Call SoltarPapel
            
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal_ORIG)), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Tir) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Tir_ORIG)), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_VPar) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_VPar_ORIG)), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT_ORIG)), FDec0Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen_ORIG)), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial_ORIG)), FDec0Dec)
            
            On Error Resume Next
            Call GRILLA.SetFocus
            On Error GoTo 0
            
        Else
        
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Nominal) = Format(Datos(2), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_Tir) = Format(Datos(3), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_VPar) = Format(Datos(4), FDec4Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = Format(Datos(5), FDec0Dec)
            Let GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) = Format(Datos(6), FDec0Dec)
            
            If GRILLA.ColSel = Col_MT Or GRILLA.ColSel = Col_Tir Then
                If Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT)) * CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), FDec0Dec) <> Format(CDbl(Datos(6)), FDec0Dec) Then
                    Let GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_MT)) * CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), FDec0Dec)
                End If
            End If
            If GRILLA.ColSel = Col_ValInicial Then
                If Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial)) / CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), FDec0Dec) <> Format(CDbl(Datos(5)), FDec0Dec) Then
                    Let GRILLA.TextMatrix(GRILLA.RowSel, Col_MT) = Format(CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_ValInicial)) / CDbl(GRILLA.TextMatrix(GRILLA.RowSel, Col_Margen)), FDec0Dec)
                End If
            End If
            
            
        End If
        
    End If
    
    Call subCOLOREA_Registro
    Call ActualizaMontoOperacion
   
End Function


'ARM PRD-9837
Private Function VerificaSerieREPO_Errores(SerieSoma As String, FolioSOMA As Long, CorrelaSOMA As Long) As Boolean
'PRD-6010
Dim nContador  As Long
Dim VerificaSerieSOMA_Errores As Boolean

    Let VerificaSerieSOMA_Errores = False
    
    For nContador = 1 To GridErroresSOMA.Rows - 1

      If (CDbl(GridErroresSOMA.TextMatrix(nContador, 0)) = FolioSOMA) Then
           
               Let VerificaSerieSOMA_Errores = True
               Exit Function
      End If
        
    Next nContador
    
    If VerificaSerieSOMA_Errores = False Then
        VerificaSerieSOMA_Errores = False
        Exit Function
    End If

   VerificaSerieSOMA_Errores = True
   
'PRD-6010
End Function




'ARM PRD - 9837
Private Function VerificaSerieREPO(SerieSoma As String, FolioSOMA As Long, CorrelaSOMA As Long) As Boolean
'PRD-6010
Dim nContador  As Long
Dim nCant      As Long
Dim VerificaSerieSOMA As Boolean

    Let VerificaSerieSOMA = False
    Let nCant = 0
    
    For nContador = 1 To GRILLA.Rows - 1

      If (GRILLA.TextMatrix(nContador, COL_Serie) = SerieSoma) And (GRILLA.TextMatrix(nContador, Col_ID_SOMA) <> FolioSOMA And (GRILLA.TextMatrix(nContador, Col_Correla_SOMA) = CorrelaSOMA)) Then   '' (grilla.TextMatrix(nContador, Col_Correla_SOMA) <> 0)
           
               Let VerificaSerieSOMA = True
               Exit Function
      End If
        
    Next nContador
    
    
    If VerificaSerieSOMA = False Then
        VerificaSerieSOMA = False
        Exit Function
    End If

   VerificaSerieSOMA = True
   
'PRD-6010
End Function




'ARM PRD-9837
Private Sub LimpiaFolioREPO_GRILLA()
'PRD-6010
   Dim nFila As Long
   
   For nFila = 1 To GRILLA.Rows - 1
      Let GRILLA.TextMatrix(nFila, Col_ID_SOMA) = Format(0, FDec0Dec)      'PRD-6010
      Let GRILLA.TextMatrix(nFila, Col_Correla_SOMA) = Format(0, FDec0Dec) 'PRD-6010
   Next nFila
'PRD-6010
End Sub


