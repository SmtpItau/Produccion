VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form FRM_ING_PREPAGOS 
   Caption         =   "Pre-Pagos"
   ClientHeight    =   5040
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8415
   LinkTopic       =   "Form1"
   ScaleHeight     =   5040
   ScaleWidth      =   8415
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame FRM_Instrumento 
      Caption         =   "Instrumento"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1065
      Left            =   45
      TabIndex        =   41
      Top             =   540
      Width           =   3375
      Begin VB.TextBox TXT_Familia 
         Enabled         =   0   'False
         Height          =   315
         Left            =   1185
         TabIndex        =   43
         Top             =   645
         Width           =   1155
      End
      Begin VB.TextBox TXT_Instrumento 
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
         Left            =   1185
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   42
         Top             =   300
         Width           =   2025
      End
      Begin VB.Label LBL_Codigo 
         Caption         =   "Tipo"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   45
         Top             =   330
         Width           =   1065
      End
      Begin VB.Label LBL_Codigo_Inst 
         Caption         =   "Código"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   135
         TabIndex        =   44
         Top             =   645
         Width           =   1065
      End
   End
   Begin VB.Frame FRM_MONEDA 
      Height          =   2670
      Left            =   30
      TabIndex        =   28
      Top             =   1620
      Width           =   3375
      Begin VB.ComboBox CMB_Moneda 
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
         Left            =   1185
         Style           =   2  'Dropdown List
         TabIndex        =   34
         Top             =   225
         Width           =   2055
      End
      Begin VB.ComboBox CMB_Base 
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
         Left            =   1185
         Style           =   2  'Dropdown List
         TabIndex        =   33
         Top             =   1665
         Width           =   1095
      End
      Begin VB.ComboBox CMB_Tipo_Tasa 
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
         Left            =   1185
         Style           =   2  'Dropdown List
         TabIndex        =   32
         Top             =   2025
         Width           =   2055
      End
      Begin BACControles.TXTNumero FTB_Spread 
         Height          =   315
         Left            =   1185
         TabIndex        =   29
         Top             =   1305
         Width           =   1155
         _ExtentX        =   2037
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
      Begin BACControles.TXTNumero FTB_Tasa 
         Height          =   315
         Left            =   1185
         TabIndex        =   30
         Top             =   930
         Width           =   1155
         _ExtentX        =   2037
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
      Begin BACControles.TXTNumero FTB_Monto 
         Height          =   315
         Left            =   1185
         TabIndex        =   31
         Top             =   570
         Width           =   2025
         _ExtentX        =   3572
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
      Begin VB.Label LBL_Moneda 
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
         Height          =   255
         Left            =   120
         TabIndex        =   40
         Top             =   225
         Width           =   1020
      End
      Begin VB.Label LBL_Monto 
         Caption         =   "Monto"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   39
         Top             =   585
         Width           =   990
      End
      Begin VB.Label LBL_Tasa 
         Caption         =   "Tasa"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   105
         TabIndex        =   38
         Top             =   945
         Width           =   1005
      End
      Begin VB.Label LBL_Base 
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
         Height          =   255
         Left            =   105
         TabIndex        =   37
         Top             =   1665
         Width           =   1065
      End
      Begin VB.Label LBL_Tipo_Tasa 
         Caption         =   "Tipo Tasa"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   105
         TabIndex        =   36
         Top             =   2025
         Width           =   1005
      End
      Begin VB.Label LBL_Spread 
         Caption         =   "Spread"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   105
         TabIndex        =   35
         Top             =   1305
         Width           =   1065
      End
   End
   Begin VB.Frame FRM_FECHAS 
      Height          =   1335
      Left            =   3495
      TabIndex        =   21
      Top             =   1620
      Width           =   4875
      Begin VB.ComboBox CMB_Periodo 
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
         Left            =   2295
         TabIndex        =   24
         Top             =   930
         Width           =   1770
      End
      Begin BACControles.TXTFecha TXT_Fecha_Ven 
         Height          =   315
         Left            =   2295
         TabIndex        =   22
         Top             =   555
         Width           =   1770
         _ExtentX        =   3122
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
         Text            =   "16-04-2003"
      End
      Begin BACControles.TXTFecha TXT_Fecha_Otor 
         Height          =   315
         Left            =   2295
         TabIndex        =   23
         Top             =   180
         Width           =   1770
         _ExtentX        =   3122
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
         Text            =   "16-04-2003"
      End
      Begin VB.Label LBL_Fecha_Vence 
         Caption         =   "Fecha de Vencimiento"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   27
         Top             =   600
         Width           =   2190
      End
      Begin VB.Label LBL_Periodo 
         Caption         =   "Periodo de Vencimiento"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   26
         Top             =   960
         Width           =   2160
      End
      Begin VB.Label LBL_Fecha_Otorga 
         Caption         =   "Fecha Otorgamiento"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   120
         TabIndex        =   25
         Top             =   240
         Width           =   1935
      End
   End
   Begin VB.Frame FRM_CUOTAS 
      Height          =   1335
      Left            =   3510
      TabIndex        =   14
      Top             =   2955
      Width           =   4860
      Begin BACControles.TXTNumero TXT_Gracia 
         Height          =   315
         Left            =   2295
         TabIndex        =   15
         Top             =   915
         Width           =   690
         _ExtentX        =   1217
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
      Begin BACControles.TXTNumero FTB_Cuotas 
         Height          =   315
         Left            =   2280
         TabIndex        =   16
         Top             =   165
         Width           =   705
         _ExtentX        =   1244
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
      Begin BACControles.TXTFecha TXT_Fecha_Cuota 
         Height          =   315
         Left            =   2295
         TabIndex        =   17
         Top             =   540
         Width           =   1755
         _ExtentX        =   3096
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
         Text            =   "16-04-2003"
      End
      Begin VB.Label LBL_Numero_Cuotas 
         Caption         =   "Número de Cuotas"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   135
         TabIndex        =   20
         Top             =   240
         Width           =   1905
      End
      Begin VB.Label LBL_Fecha_PCuota 
         Caption         =   "Fecha Primera Cuota"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   19
         Top             =   600
         Width           =   1890
      End
      Begin VB.Label LBL_Gracia 
         Caption         =   "Nro Períodos de Gracia"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   18
         Top             =   960
         Width           =   1965
      End
   End
   Begin VB.Frame FRM_ACUERDO 
      Height          =   705
      Left            =   30
      TabIndex        =   11
      Top             =   4275
      Width           =   3375
      Begin BACControles.TXTNumero TXT_Acuerdo 
         Height          =   315
         Left            =   1905
         TabIndex        =   12
         Top             =   225
         Width           =   1335
         _ExtentX        =   2355
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
      Begin VB.Label LBL_Acuerdo 
         Caption         =   "Número Acuerdo"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   90
         TabIndex        =   13
         Top             =   270
         Width           =   1815
      End
   End
   Begin VB.Frame FRM_CAPITALIZACION 
      Height          =   720
      Left            =   3510
      TabIndex        =   8
      Top             =   4275
      Width           =   4860
      Begin BACControles.TXTFecha TXT_Fecha_Capitaliza 
         Height          =   315
         Left            =   2295
         TabIndex        =   9
         Top             =   210
         Width           =   1755
         _ExtentX        =   3096
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
         Text            =   "16-04-2003"
      End
      Begin Threed.SSCheck SCHK_Capitaliza 
         Height          =   225
         Left            =   120
         TabIndex        =   10
         Top             =   270
         Width           =   1740
         _Version        =   65536
         _ExtentX        =   3069
         _ExtentY        =   397
         _StockProps     =   78
         Caption         =   "Capitalización"
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
   Begin VB.Frame FRM_Cliente 
      Caption         =   "Cliente"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1065
      Left            =   3495
      TabIndex        =   1
      Top             =   540
      Width           =   4875
      Begin VB.TextBox Text8 
         Enabled         =   0   'False
         Height          =   315
         Left            =   2595
         TabIndex        =   4
         Top             =   300
         Width           =   255
      End
      Begin VB.TextBox Text7 
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
         Left            =   945
         TabIndex        =   3
         Top             =   645
         Width           =   3855
      End
      Begin BACControles.TXTNumero FTB_Rut 
         Height          =   315
         Left            =   945
         TabIndex        =   2
         Top             =   300
         Width           =   1470
         _ExtentX        =   2593
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
      Begin VB.Label Label11 
         Alignment       =   2  'Center
         Caption         =   "-"
         Height          =   255
         Left            =   2430
         TabIndex        =   7
         Top             =   330
         Width           =   135
      End
      Begin VB.Label LBL_Nombre 
         Caption         =   "Nombre"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   6
         Top             =   660
         Width           =   825
      End
      Begin VB.Label LBL_Rut 
         Caption         =   "Rut"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   330
         Width           =   765
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8415
      _ExtentX        =   14843
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Calcular"
            Object.ToolTipText     =   "Calcular"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   6435
         Top             =   45
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   4
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_PREPAGOS.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_PREPAGOS.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_PREPAGOS.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_PREPAGOS.frx":20CE
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_ING_PREPAGOS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
