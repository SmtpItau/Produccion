VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form FRM_ING_CORFO 
   Caption         =   "Créditos"
   ClientHeight    =   5010
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8385
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5010
   ScaleWidth      =   8385
   Begin MSComctlLib.Toolbar TBL_MENU 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   43
      Top             =   0
      Width           =   8385
      _ExtentX        =   14790
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
               Picture         =   "FRM_ING_CORFO.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_CORFO.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_CORFO.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_CORFO.frx":20CE
               Key             =   ""
            EndProperty
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
      TabIndex        =   38
      Top             =   540
      Width           =   4875
      Begin BACControles.TXTNumero FTB_Rut 
         Height          =   315
         Left            =   945
         TabIndex        =   3
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
         Min             =   "0"
         Max             =   "99999999"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.TextBox TXT_Nombre 
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
         MaxLength       =   35
         TabIndex        =   5
         Top             =   645
         Width           =   3855
      End
      Begin VB.TextBox TXT_Digito 
         Enabled         =   0   'False
         Height          =   315
         Left            =   2595
         TabIndex        =   4
         Top             =   300
         Width           =   255
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
         TabIndex        =   41
         Top             =   330
         Width           =   765
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
         TabIndex        =   40
         Top             =   660
         Width           =   825
      End
      Begin VB.Label Label11 
         Alignment       =   2  'Center
         Caption         =   "-"
         Height          =   255
         Left            =   2430
         TabIndex        =   39
         Top             =   330
         Width           =   135
      End
   End
   Begin VB.Frame FRM_CAPITALIZACION 
      Height          =   720
      Left            =   3510
      TabIndex        =   37
      Top             =   4275
      Width           =   4860
      Begin BACControles.TXTFecha TXT_Fecha_Capitaliza 
         Height          =   315
         Left            =   2295
         TabIndex        =   20
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
         Text            =   "16/04/2003"
      End
      Begin Threed.SSCheck SCHK_Capitaliza 
         Height          =   225
         Left            =   120
         TabIndex        =   19
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
   Begin VB.Frame FRM_ACUERDO 
      Height          =   705
      Left            =   30
      TabIndex        =   36
      Top             =   4275
      Width           =   3375
      Begin BACControles.TXTNumero FTB_Acuerdo 
         Height          =   315
         Left            =   1905
         TabIndex        =   18
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
         Min             =   "0"
         Max             =   "999999999"
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
         TabIndex        =   44
         Top             =   270
         Width           =   1815
      End
   End
   Begin VB.Frame FRM_CUOTAS 
      Height          =   1335
      Left            =   3510
      TabIndex        =   31
      Top             =   2955
      Width           =   4860
      Begin BACControles.TXTNumero FTB_Gracia 
         Height          =   315
         Left            =   2295
         TabIndex        =   17
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
         Min             =   "0"
         Max             =   "99"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero FTB_Cuotas 
         Height          =   315
         Left            =   2280
         TabIndex        =   15
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
         Min             =   "1"
         Max             =   "99"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTFecha TXT_Fecha_Cuota 
         Height          =   315
         Left            =   2295
         TabIndex        =   16
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
         Text            =   "16/04/2003"
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
         TabIndex        =   34
         Top             =   960
         Width           =   1965
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
         TabIndex        =   33
         Top             =   600
         Width           =   1890
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
         TabIndex        =   32
         Top             =   240
         Width           =   1905
      End
   End
   Begin VB.Frame FRM_FECHAS 
      Height          =   1335
      Left            =   3495
      TabIndex        =   28
      Top             =   1620
      Width           =   4875
      Begin BACControles.TXTFecha TXT_Fecha_Ven 
         Height          =   315
         Left            =   2295
         TabIndex        =   13
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
         Text            =   "16/04/2003"
      End
      Begin BACControles.TXTFecha TXT_Fecha_Otor 
         Height          =   315
         Left            =   2295
         TabIndex        =   12
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
         Text            =   "16/04/2003"
      End
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
         TabIndex        =   14
         Top             =   930
         Width           =   1770
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
         TabIndex        =   35
         Top             =   240
         Width           =   1935
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
         TabIndex        =   30
         Top             =   960
         Width           =   2160
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
         TabIndex        =   29
         Top             =   600
         Width           =   2190
      End
   End
   Begin VB.Frame FRM_MONEDA 
      Height          =   2670
      Left            =   30
      TabIndex        =   21
      Top             =   1620
      Width           =   3375
      Begin BACControles.TXTNumero FTB_Spread 
         Height          =   315
         Left            =   1185
         TabIndex        =   9
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "0"
         Max             =   "999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero FTB_Tasa 
         Height          =   315
         Left            =   1185
         TabIndex        =   8
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "0"
         Max             =   "999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero FTB_Monto 
         Height          =   315
         Left            =   1185
         TabIndex        =   7
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "1"
         Max             =   "999999999999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
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
         TabIndex        =   11
         Top             =   2025
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
         TabIndex        =   10
         Top             =   1665
         Width           =   1095
      End
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
         TabIndex        =   6
         Top             =   225
         Width           =   2055
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
         TabIndex        =   27
         Top             =   1305
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
         TabIndex        =   26
         Top             =   2025
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
         TabIndex        =   25
         Top             =   1665
         Width           =   1065
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
         TabIndex        =   24
         Top             =   945
         Width           =   1005
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
         TabIndex        =   23
         Top             =   585
         Width           =   990
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
         TabIndex        =   22
         Top             =   225
         Width           =   1020
      End
   End
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
      TabIndex        =   0
      Top             =   540
      Width           =   3375
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
         MaxLength       =   15
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   1
         Top             =   300
         Width           =   2025
      End
      Begin VB.TextBox TXT_Familia 
         Enabled         =   0   'False
         Height          =   315
         Left            =   1185
         TabIndex        =   2
         Top             =   645
         Width           =   1155
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
         TabIndex        =   45
         Top             =   645
         Width           =   1065
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
         TabIndex        =   42
         Top             =   330
         Width           =   1065
      End
   End
End
Attribute VB_Name = "FRM_ING_CORFO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cHay_Datos As String

Private Sub Cmb_Base_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub

Private Sub Cmb_Moneda_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub


Private Sub CMB_PERIODO_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub

Private Sub CMB_Tipo_Tasa_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub


Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
   
   Dim nOpcion        As Integer

   On Error GoTo Errores
   nOpcion = 0

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
   
      Select Case KeyCode
      Case vbKeyLimpiar
         nOpcion = 1

      Case vbKeyGrabar:
         nOpcion = 2

      Case vbKeyCalcular:
         nOpcion = 3

      Case vbKeySalir:
         nOpcion = 4

      End Select

      If nOpcion <> 0 Then
         If TBL_MENU.Buttons(nOpcion).Enabled Then
            Call TBL_Menu_ButtonClick(TBL_MENU.Buttons(nOpcion))
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
If GLB_Opcion_Menu = "Opcion_Menu_3201" Then
    Caption = "Crédito Corfo"
End If
Me.Icon = FRM_MDI_PASIVO.Icon
Me.Top = 1150
Me.Left = 30

Call FUNC_LLENAR_COMBOS
Call FUNC_LIMPIAR_PANTALLA

End Sub

Private Function PROC_CON_INSTRUMENTO()

     
   On Error GoTo Error_Con_Familia
   
   Pbl_cTipo_Instrumento = "CORFO"
   cMiTag = "MDIN"
   FRM_AYUDA.Show 1
   If GLB_Aceptar% = True Then
      cHay_Datos = "N"
      TXT_Familia.Text = GLB_codigo$
      TXT_Instrumento.Text = GLB_nombre$
      cHay_Datos = "S"
   End If
   Exit Function
   
Error_Con_Familia:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
    Exit Function

End Function


Private Sub FTB_Cuotas_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub

Private Sub FTB_Cuotas_LostFocus()
If Val(FTB_Cuotas.Text) < Val(FTB_Gracia.Text) Then
    MsgBox ("Número de Cuotas no puede ser menor a número de Gracia"), vbOKOnly + vbInformation
    FTB_Cuotas.Text = 0
    FTB_Cuotas.SetFocus
End If
End Sub

Private Sub FTB_Gracia_LostFocus()
If Val(FTB_Gracia.Text) > Val(FTB_Cuotas.Text) Then
    MsgBox ("Número de Gracia no puede sobre pasar número de Cuotas"), vbOKOnly + vbInformation
    FTB_Gracia.Text = 0
    FTB_Gracia.SetFocus
End If
End Sub

Private Sub FTB_Monto_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub

Private Sub FTB_Rut_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
    
    If Val(Trim(FTB_Rut.Text)) > 0 Then
        TXT_Digito.Text = FUNC_DEVUELVEDIG(FTB_Rut.Text)
    End If

End Sub

Private Sub FTB_Spread_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub

Private Sub FTB_Tasa_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub

Private Sub SCHK_Capitaliza_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub

Private Sub SCHK_Capitaliza_LostFocus()
If SCHK_Capitaliza.Value = True Then
    Me.TXT_Fecha_Capitaliza.Enabled = True
Else
    Me.TXT_Fecha_Capitaliza.Enabled = False
End If
End Sub

Private Sub Text7_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub

Private Sub FTB_Acuerdo_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub

Private Sub TBL_Menu_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Trim(UCase(Button.Key))
Case "LIMPIAR"
    Call FUNC_LIMPIAR_PANTALLA

Case "CALCULAR"
    GLB_Confirmar = False
    Call FUNC_CALCULAR_FLUJOS

Case "GRABAR"
    If Not FUNC_VALIDAR_DATOS Then
        Exit Sub
    End If
    
    If Val(FTB_Rut.Text) = 0 Then
        MsgBox "Debe ingresar el rut de cliente", vbOKOnly + vbInformation
        Exit Sub
    ElseIf TXT_Nombre.Text = "" Then
        MsgBox "Debe ingresar nombre de cliente", vbOKOnly + vbInformation
        Exit Sub
    ElseIf Val(FTB_Acuerdo.Text) = 0 Then
        MsgBox "Debe ingresar número de acuerdo", vbOKOnly + vbInformation
        Exit Sub
    End If
    
    If GLB_Confirmar = False Then
        MsgBox ("Debe generar y aceptar flujo de vencimientos"), vbOKOnly + vbInformation
        Exit Sub
    Else
        Call FUNC_GRABAR_CORFO
        If GLB_Aceptar = True Then
            Call FUNC_LIMPIAR_PANTALLA
        End If
    End If
        

Case "SALIR"
    Unload Me
End Select
End Sub


Private Sub TXT_Fecha_Capitaliza_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub

Private Sub TXT_Fecha_Cuota_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub

Private Sub TXT_Fecha_Otor_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub

Private Sub TXT_Fecha_Ven_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub

Private Sub FTB_Gracia_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub

Private Sub Txt_Instrumento_DblClick()
    Call PROC_CON_INSTRUMENTO
End Sub

Private Sub Txt_Instrumento_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call PROC_CON_INSTRUMENTO
End Sub

Private Sub Txt_Instrumento_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub



Private Function FUNC_LLENAR_COMBOS()

If FUNC_LLENA_MONEDA(CMB_Moneda, "3") Then
       CMB_Moneda.ListIndex = 0
Else
        FUNC_LLENAR_COMBOS = False
End If
If FUNC_LLENA_BASES(CMB_Base, "") Then
       CMB_Base.ListIndex = 0
Else
       FUNC_LLENAR_COMBOS = False
End If

If FUNC_LLENA_MONEDA(CMB_Tipo_Tasa, "1") Then
       CMB_Tipo_Tasa.ListIndex = 0
Else
        FUNC_LLENAR_COMBOS = False
End If

If FUNC_CON_CMBAMORTIZA(CMB_Periodo, GLB_Sistema) Then
        CMB_Periodo.ListIndex = 0
Else
        FUNC_LLENAR_COMBOS = False
End If

End Function


Private Function FUNC_LIMPIAR_PANTALLA()

Me.TXT_Fecha_Otor.Text = GLB_Fecha_Proceso
Me.TXT_Fecha_Ven.Text = GLB_Fecha_Proceso
Me.TXT_Fecha_Capitaliza.Text = GLB_Fecha_Proceso
Me.TXT_Fecha_Capitaliza.Enabled = False
Me.TXT_Fecha_Cuota.Text = GLB_Fecha_Proceso
Me.FTB_Rut.Text = ""
Me.TXT_Instrumento.Text = ""
Me.TXT_Familia.Text = ""
Me.TXT_Digito.Text = ""
Me.TXT_Nombre.Text = ""
Me.FTB_Cuotas.Text = 0
Me.FTB_Monto.Text = 0
Me.FTB_Spread.Text = 0
Me.FTB_Tasa.Text = 0
Me.FTB_Gracia.Text = 0
Me.SCHK_Capitaliza.Value = False
Me.FTB_Acuerdo.Text = 0
Call PROC_VALORES_DEFECTO
End Function


Sub PROC_VALORES_DEFECTO()
Dim I As Integer
   
   Dim Valor_Defecto As Valores_Defecto
   Call GLB_objControl.PROC_VALORES_DEFECTO("CORFO", Valor_Defecto)


   With Valor_Defecto
   
      PROC_ESTABLECE_DEFECTO CMB_Moneda, Val(.cValor_codigo_moneda)
      PROC_ESTABLECE_DEFECTO CMB_Tipo_Tasa, .nValor_tipo_tasa
      PROC_ESTABLECE_DEFECTO CMB_Periodo, .nValor_tipo_periodo
   End With

End Sub


Private Sub Txt_Instrumento_LostFocus()
On Error GoTo Error_Familia

    If Trim(TXT_Instrumento.Text) = "" Then Exit Sub
    
    If Not FUNC_CON_INSTRUMENTO(TXT_Instrumento.Text) Then
        MsgBox "Instrumento no existe", vbOKOnly + vbExclamation
        TXT_Familia.Text = ""
        TXT_Instrumento.Text = ""
        TXT_Instrumento.SetFocus
        Exit Sub
        
    End If
    
Exit Sub

Error_Familia:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
    Exit Sub

End Sub

Private Sub TXT_Nombre_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub


Function FUNC_CON_INSTRUMENTO(cFamilia As String) As Boolean
Dim Datos()

    FUNC_CON_INSTRUMENTO = False

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, ""
    PROC_AGREGA_PARAMETRO GLB_Envia, 0
    PROC_AGREGA_PARAMETRO GLB_Envia, cFamilia
    
    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_INST_BONOS", GLB_Envia) Then
        If FUNC_LEE_RETORNO_SQL(Datos()) Then
            TXT_Familia.Text = Datos(1)
            FUNC_CON_INSTRUMENTO = True
        End If
    Else
        Exit Function
    End If
    
End Function

Private Function FUNC_CALCULAR_FLUJOS()

    If Not FUNC_VALIDAR_DATOS Then
        Exit Function
    End If
FRM_MAN_FLUJOS.Show 1

End Function


Private Function FUNC_VALIDAR_DATOS()
FUNC_VALIDAR_DATOS = False

If TXT_Instrumento = "" Then
    MsgBox ("Debe ingresar instrumento"), vbOKOnly + vbInformation
    Exit Function
ElseIf Val(FTB_Tasa.Text) = 0 Then
    MsgBox ("Debe ingresar Tasa"), vbOKOnly + vbInformation
    Exit Function
ElseIf Val(FTB_Cuotas.Text) = 0 Then
    MsgBox ("Debe ingresar cantidad de cuotas"), vbOKOnly + vbInformation
    Exit Function
ElseIf CDate(TXT_Fecha_Otor.Text) >= CDate(Me.TXT_Fecha_Ven.Text) Then
    MsgBox ("Verifique fecha de otorgamiento y vencimiento"), vbOKOnly + vbInformation
    Exit Function
ElseIf Val(FTB_Monto.Text) = 0 Then
    MsgBox ("Debe ingresar monto original"), vbOKOnly + vbInformation
    Exit Function
ElseIf Val(FTB_Gracia.Text) >= Val(FTB_Cuotas.Text) Then
    MsgBox ("Número de Gracia debe ser menor a número de cuotas"), vbOKOnly + vbInformation
    Exit Function
ElseIf Format(TXT_Fecha_Cuota.Text, "YYYYMMDD") >= Format(TXT_Fecha_Ven.Text, "YYYYMMDD") Then
    MsgBox ("Verifique fecha de vencimiento y fecha primera cuota"), vbOKOnly + vbInformation
    Exit Function
ElseIf CDate(TXT_Fecha_Cuota.Text) <= CDate(Me.TXT_Fecha_Otor.Text) Then
    MsgBox ("Verifique fecha de otorgamiento y fecha primera cuota"), vbOKOnly + vbInformation
    Exit Function
End If

FUNC_VALIDAR_DATOS = True
End Function

Private Function FUNC_GRABAR_CORFO()

GLB_Formulario = Me.Name
FRM_ING_GRABACION.Show 1

End Function
