VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form FRM_ING_RENOVACIONES 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ingreso de Renovaciones"
   ClientHeight    =   6990
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9225
   Icon            =   "FRM_ING_RENOVACIONES.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6990
   ScaleWidth      =   9225
   Begin VB.Frame FRM_VALOR_ESTIMADO 
      Caption         =   "Valor Estimado"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1095
      Left            =   90
      TabIndex        =   54
      Top             =   5880
      Width           =   9150
      Begin BACControles.TXTNumero FTB_VALOR_ESTIMADO1 
         Height          =   345
         Left            =   2880
         TabIndex        =   55
         Top             =   270
         Width           =   2025
         _ExtentX        =   3572
         _ExtentY        =   609
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
      Begin BACControles.TXTNumero FTB_VALOR_ESTIMADO2 
         Height          =   345
         Left            =   2880
         TabIndex        =   56
         Top             =   660
         Width           =   2025
         _ExtentX        =   3572
         _ExtentY        =   609
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
      Begin BACControles.TXTNumero FTB_VALOR_ESTIMADO3 
         Height          =   345
         Left            =   6930
         TabIndex        =   57
         Top             =   210
         Width           =   2025
         _ExtentX        =   3572
         _ExtentY        =   609
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
      Begin BACControles.TXTNumero FTB_VALOR_ESTIMADO4 
         Height          =   345
         Left            =   6930
         TabIndex        =   58
         Top             =   600
         Width           =   2025
         _ExtentX        =   3572
         _ExtentY        =   609
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
      Begin VB.Label LBL_COMISIONES_PAGADAS_CORREDOR 
         Caption         =   "Comisiones Pagadas a Corredor"
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
         Left            =   60
         TabIndex        =   62
         Top             =   300
         Width           =   2745
      End
      Begin VB.Label LBL_DESCUENTO_BONO 
         Caption         =   "Descuento Bono"
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
         Left            =   60
         TabIndex        =   61
         Top             =   660
         Width           =   1665
      End
      Begin VB.Label LBL_OTROS 
         Caption         =   "Otros"
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
         Left            =   5010
         TabIndex        =   60
         Top             =   660
         Width           =   1095
      End
      Begin VB.Label LBL_COSTO_EMISION_BONO 
         Caption         =   "Costo Emisi�n Bono"
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
         Left            =   5010
         TabIndex        =   59
         Top             =   300
         Width           =   2235
      End
   End
   Begin Threed.SSFrame Frm_Original 
      Height          =   735
      Left            =   45
      TabIndex        =   44
      Top             =   495
      Width           =   9225
      _Version        =   65536
      _ExtentX        =   16272
      _ExtentY        =   1296
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
      Enabled         =   0   'False
      Begin BACControles.TXTNumero Txt_Numero_Acuerdo 
         Height          =   315
         Left            =   6150
         TabIndex        =   1
         Top             =   270
         Width           =   1815
         _ExtentX        =   3201
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
      Begin BACControles.TXTNumero Txt_Numero_Operacion 
         Height          =   315
         Left            =   2040
         TabIndex        =   0
         Top             =   270
         Width           =   1815
         _ExtentX        =   3201
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
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Label2 
         Caption         =   "Numero Acuerdo"
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
         Left            =   4650
         TabIndex        =   46
         Top             =   330
         Width           =   1485
      End
      Begin VB.Label Label1 
         Caption         =   "Numero Operacion"
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
         Left            =   420
         TabIndex        =   45
         Top             =   300
         Width           =   1575
      End
   End
   Begin VB.Frame FRM_Instrumento 
      Caption         =   "Instrumento"
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
      Height          =   1065
      Left            =   60
      TabIndex        =   41
      Top             =   1230
      Width           =   3375
      Begin VB.TextBox TXT_Familia 
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
         TabIndex        =   3
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
         MaxLength       =   15
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   2
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
         TabIndex        =   43
         Top             =   330
         Width           =   1065
      End
      Begin VB.Label LBL_Codigo_Inst 
         Caption         =   "C�digo"
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
         TabIndex        =   42
         Top             =   645
         Width           =   1065
      End
   End
   Begin VB.Frame FRM_MONEDA 
      Height          =   2835
      Left            =   75
      TabIndex        =   34
      Top             =   2325
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
         TabIndex        =   7
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
         TabIndex        =   12
         Top             =   2460
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
         TabIndex        =   9
         Top             =   915
         Width           =   2055
      End
      Begin BACControles.TXTNumero FTB_Spread 
         Height          =   315
         Left            =   1185
         TabIndex        =   11
         Top             =   1680
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         Min             =   "0"
         Max             =   "999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero FTB_Tasa 
         Height          =   315
         Left            =   1185
         TabIndex        =   10
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         Min             =   "0"
         Max             =   "999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero FTB_Monto 
         Height          =   315
         Left            =   1185
         TabIndex        =   8
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         Min             =   "1"
         Max             =   "999999999999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero FTB_Total_Tasa 
         Height          =   315
         Left            =   1185
         TabIndex        =   52
         Top             =   2055
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         Min             =   "0"
         Max             =   "999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin VB.Label LBL_Total_Tasa 
         Caption         =   "Tasa Total"
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
         TabIndex        =   53
         Top             =   2085
         Width           =   1020
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
         Left            =   120
         TabIndex        =   38
         Top             =   1305
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
         Left            =   120
         TabIndex        =   37
         Top             =   2475
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
         Left            =   120
         TabIndex        =   36
         Top             =   930
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
         Left            =   120
         TabIndex        =   35
         Top             =   1680
         Width           =   1065
      End
   End
   Begin VB.Frame FRM_FECHAS 
      Height          =   2940
      Left            =   3480
      TabIndex        =   30
      Top             =   2295
      Width           =   5745
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
         Style           =   2  'Dropdown List
         TabIndex        =   15
         Top             =   1020
         Width           =   2055
      End
      Begin BACControles.TXTFecha TXT_Fecha_Ven 
         Height          =   315
         Left            =   2295
         TabIndex        =   17
         Top             =   1785
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
         TabIndex        =   13
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
      Begin BACControles.TXTFecha TXT_Fecha_Cuota 
         Height          =   315
         Left            =   2295
         TabIndex        =   14
         Top             =   600
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
      Begin BACControles.TXTNumero FTB_Cuotas 
         Height          =   315
         Left            =   2295
         TabIndex        =   16
         Top             =   1410
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
         Max             =   "999"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero FTB_Gracia 
         Height          =   315
         Left            =   2295
         TabIndex        =   18
         Top             =   2130
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
      Begin BACControles.TXTNumero FTB_Decimales 
         Height          =   315
         Left            =   2295
         TabIndex        =   50
         Top             =   2550
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
      End
      Begin VB.Label LBL_Decimales 
         Caption         =   "Nro Decimales"
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
         TabIndex        =   51
         Top             =   2610
         Width           =   1965
      End
      Begin VB.Label LBL_Gracia 
         Caption         =   "Nro Per�odos de Gracia"
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
         TabIndex        =   49
         Top             =   2235
         Width           =   1965
      End
      Begin VB.Label LBL_Numero_Cuotas 
         Caption         =   "N�mero de Cuotas"
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
         TabIndex        =   48
         Top             =   1485
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
         TabIndex        =   47
         Top             =   660
         Width           =   1890
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
         TabIndex        =   33
         Top             =   1830
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
         TabIndex        =   32
         Top             =   1080
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
         TabIndex        =   31
         Top             =   240
         Width           =   1935
      End
   End
   Begin VB.Frame FRM_ACUERDO 
      Height          =   705
      Left            =   75
      TabIndex        =   28
      Top             =   5175
      Width           =   3375
      Begin BACControles.TXTNumero FTB_Acuerdo 
         Height          =   315
         Left            =   1950
         TabIndex        =   19
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
         Caption         =   "N�mero Acuerdo"
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
         TabIndex        =   29
         Top             =   270
         Width           =   1815
      End
   End
   Begin VB.Frame FRM_CAPITALIZACION 
      Height          =   720
      Left            =   3450
      TabIndex        =   27
      Top             =   5175
      Width           =   5790
      Begin BACControles.TXTFecha TXT_Fecha_Capitaliza 
         Height          =   315
         Left            =   2295
         TabIndex        =   21
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
         TabIndex        =   20
         Top             =   270
         Width           =   1740
         _Version        =   65536
         _ExtentX        =   3069
         _ExtentY        =   397
         _StockProps     =   78
         Caption         =   "Capitalizaci�n"
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
      Caption         =   "Acreedor"
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
      Height          =   1065
      Left            =   3480
      TabIndex        =   23
      Top             =   1230
      Width           =   5745
      Begin VB.TextBox TXT_Digito 
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
         Left            =   2595
         TabIndex        =   5
         Top             =   300
         Width           =   255
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
         TabIndex        =   6
         Top             =   645
         Width           =   3855
      End
      Begin BACControles.TXTNumero FTB_Rut 
         Height          =   315
         Left            =   960
         TabIndex        =   4
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
      Begin VB.Label Label11 
         Alignment       =   2  'Center
         Caption         =   "-"
         Height          =   255
         Left            =   2430
         TabIndex        =   26
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
         TabIndex        =   25
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
         TabIndex        =   24
         Top             =   330
         Width           =   765
      End
   End
   Begin MSComctlLib.Toolbar TBL_MENU 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   22
      Top             =   0
      Width           =   9225
      _ExtentX        =   16272
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
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
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Calcular"
            Object.ToolTipText     =   "Calcular"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   6720
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
               Picture         =   "FRM_ING_RENOVACIONES.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":4C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":5064
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":551E
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":59F1
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":5E35
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":639C
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":686B
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":6C8A
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":7182
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":757B
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":79FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":7EC4
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":83BB
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":8871
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":8C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":902C
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":9423
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":982C
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_RENOVACIONES.frx":9CEA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_ING_RENOVACIONES"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cHay_Datos As String
Dim cOptLocal  As String

Private Sub Cmb_Base_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
    
End Sub

Private Sub Cmb_Moneda_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
    
End Sub
Private Sub Cmb_Moneda_LostFocus()
  Call FUNC_ELIJE_TASA
End Sub


Private Function FUNC_ELIJE_TASA()
If CMB_Moneda.ListIndex = -1 Then Exit Function
If CMB_Moneda.ItemData(CMB_Moneda.ListIndex) = 998 Then
  For I% = 0 To CMB_Tipo_Tasa.ListCount - 1
   If 333 = CMB_Tipo_Tasa.ItemData(I%) Then
    CMB_Tipo_Tasa.ListIndex = I%
    Exit For
   End If
  Next I%
CMB_Tipo_Tasa.Enabled = False
Me.FTB_Tasa.Enabled = True
FTB_Spread.Enabled = False
Else
CMB_Tipo_Tasa.Enabled = True
End If
End Function
Private Sub CMB_Periodo_Click()
        Call FUNC_SUMA_FECHAS(Me.TXT_Fecha_Cuota.Text, FTB_Cuotas.Text)
End Sub

Private Sub CMB_PERIODO_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
    
End Sub

Private Sub CMB_Tipo_Tasa_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
    
End Sub

Private Sub CMB_Tipo_Tasa_LostFocus()
    Call FUNC_CON_VALOR_MONEDA(CMB_Tipo_Tasa, FTB_Tasa)
   'Call PROC_Tipo_Tasa
   FTB_Total_Tasa.Text = CDbl(FTB_Tasa.Text) + CDbl(FTB_Spread.Text)
End Sub
Sub PROC_Tipo_Tasa()
If CMB_Tipo_Tasa.Text <> "" Then
    If CMB_Tipo_Tasa.ItemData(CMB_Tipo_Tasa.ListIndex) = 333 Then
        FTB_Spread.Text = 0
        FTB_Spread.Enabled = False
        FTB_Tasa.Enabled = True
    Else
        FTB_Spread.Enabled = True
        Me.FTB_Tasa.Enabled = False
        
    End If
End If
End Sub
Private Sub Form_Activate()

    PROC_CARGA_AYUDA Me
    
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

   Me.Icon = FRM_MDI_PASIVO.Icon
   Me.top = 0
   Me.left = 0
   
   cOptLocal = GLB_Opcion_Menu
   Txt_Numero_Operacion.Text = FRM_RENOVACIONES.Txt_Numero.Text
   Call FUNC_LLENAR_COMBOS
   Call FUNC_LIMPIAR_PANTALLA
   
   
   Call PROC_LOG_AUDITORIA("07", cOptLocal, Me.Caption, "", "")
   
   Txt_Numero_Operacion.Text = FRM_RENOVACIONES.Txt_Numero.Text
   
   GLB_Confirmar = False
   
   PROC_BUSCA_DATOS
   FTB_Total_Tasa.Enabled = False
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call PROC_LOG_AUDITORIA("08", cOptLocal, Me.Caption, "", "")
   FRM_RENOVACIONES.Show
   
End Sub

Private Sub FTB_Cuotas_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
    
End Sub

Private Sub FTB_Cuotas_LostFocus()

   If Val(FTB_Cuotas.Text) < Val(FTB_Gracia.Text) Then
   
       MsgBox ("N�mero de Cuotas no puede ser menor a n�mero de Gracia"), vbOKOnly + vbInformation
       FTB_Cuotas.Text = 0
       FTB_Cuotas.SetFocus
       Exit Sub
       
   End If
   
       If Val(FTB_Cuotas.Text) <> 0 Then
       
           Call FUNC_SUMA_FECHAS(Me.TXT_Fecha_Cuota.Text, FTB_Cuotas.Text)
           
       End If

End Sub

Private Sub FTB_Gracia_LostFocus()

   If Val(FTB_Gracia.Text) > Val(FTB_Cuotas.Text) Then

      MsgBox ("N�mero de Gracia no puede sobre pasar n�mero de Cuotas"), vbOKOnly + vbInformation
      FTB_Gracia.Text = 0
      FTB_Gracia.SetFocus
    
   End If

End Sub
Private Sub FTB_Monto_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub
Private Sub FTB_Spread_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub
Private Sub FTB_Spread_LostFocus()
  FTB_Total_Tasa.Text = CDbl(FTB_Tasa.Text) + CDbl(FTB_Spread.Text)
End Sub
Private Sub FTB_Tasa_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub
Private Sub FTB_Tasa_LostFocus()
    FTB_Total_Tasa.Text = CDbl(FTB_Tasa.Text) + CDbl(FTB_Spread.Text)
End Sub
Private Sub FTB_VALOR_ESTIMADO1_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub
Private Sub FTB_VALOR_ESTIMADO2_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub
Private Sub FTB_VALOR_ESTIMADO3_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub
Private Sub FTB_VALOR_ESTIMADO4_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub
Private Sub SCHK_Capitaliza_Click(Value As Integer)
    If SCHK_Capitaliza.Value = True Then
        TXT_Fecha_Capitaliza.Text = DateAdd("m", -6, CDate(Me.TXT_Fecha_Cuota.Text))
        Me.TXT_Fecha_Capitaliza.Enabled = True
    Else
        Me.TXT_Fecha_Capitaliza.Text = TXT_Fecha_Otor.Text
        Me.TXT_Fecha_Capitaliza.Enabled = False
    End If
End Sub
Private Sub SCHK_Capitaliza_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
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
      
          Call PROC_REFRESCAR_DATOS
          
          If GLB_Confirmar = True Or GLB_Confirmar = False Then
                Unload FRM_MAN_FLUJOS_RENOVACION
          End If
    
          GLB_Confirmar = False
          Call FUNC_CALCULAR_FLUJOS
      
      Case "GRABAR"
      
        Dim Datos()
        GLB_Envia = Array("PSV")
          
'            If (objCentralizacion.Chequeo_Estado(GLB_Sistema, "bloqueo", False) And objCentralizacion.Error = 0) Then
'
'               MsgBox objCentralizacion.Mensaje, vbExclamation
'               Grd_Consulta.SetFocus
'               Exit Sub
'
'            End If

      If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
         Do While FUNC_LEE_RETORNO_SQL(Datos())

             If Datos(5) = 1 And Datos(6) = "MESA" Then

                MsgBox "Mesa esta bloqueada", vbExclamation
                Grd_Consulta.SetFocus
                Exit Sub

            End If

         Loop
     End If
                                                      
          If Not FUNC_VALIDAR_DATOS Then
              
              Exit Sub
          
          End If
          
          If Not FUNC_VALIDAR_CAMBIO_DATOS Then
             GLB_Confirmar = False
          End If
          
          If Val(FTB_Rut.Text) = 0 Then
              
              'MsgBox "Debe ingresar el rut de cliente", vbOKOnly + vbInformation
              'Exit Sub
          
          ElseIf TXT_Nombre.Text = "" Then
              
              MsgBox "Debe ingresar nombre de cliente", vbOKOnly + vbInformation
              Exit Sub
          
          ElseIf Val(FTB_Acuerdo.Text) = 0 Then
              
              MsgBox "Debe ingresar n�mero de acuerdo", vbOKOnly + vbInformation
              DoEvents
            '  FTB_Acuerdo.SetFocus
              Exit Sub
          
          End If
          
          If GLB_Confirmar = False Then
              
              MsgBox ("Debe generar y aceptar flujo de vencimientos"), vbOKOnly + vbInformation
              Exit Sub
          
          Else
          
'              If (objCentralizacion.Chequeo_Estado(GLB_Sistema, "bloqueo", False) And objCentralizacion.Error = 0) Then
'
'                  MsgBox objCentralizacion.Mensaje, vbExclamation
'                  Exit Sub
'
'              End If

'''''              If Chequeo_Estado(GLB_Sistema, "MESA", False) Then
'''''
'''''                  MsgBox "Mesa esta bloqueada", vbExclamation
'''''                  Exit Sub
'''''
'''''              End If
      
              Call FUNC_GRABAR_RENOVACION
              
              If GLB_Aceptar = True Then
                  
                  Unload Me
              
              End If
          
          End If
              
      
      Case "SALIR"
          
         Unload Me
   
   End Select

End Sub

Private Sub TXT_Fecha_Capitaliza_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)

End Sub

Private Sub TXT_Fecha_Capitaliza_LostFocus()

'If TXT_Fecha_Ven.Enabled Then
'
'    If CDate(TXT_Fecha_Otor.Text) >= CDate(TXT_Fecha_Capitaliza.Text) Then
'        MsgBox ("Fecha de capitalizaci�n no puede ser menor o igual a fecha de Otorgamiento"), vbOKOnly + vbInformation
'        TXT_Fecha_Capitaliza.Text = TXT_Fecha_Otor.Text
'
'    ElseIf CDate(TXT_Fecha_Cuota.Text) <= CDate(TXT_Fecha_Capitaliza.Text) Then
'
'        MsgBox ("Fecha capitalizaci�n no puede ser mayor o igual a fecha de primera cuota"), vbOKOnly + vbInformation
'        TXT_Fecha_Capitaliza.Text = TXT_Fecha_Otor.Text
'
'    Else
'        Call FUNC_CALCULA_DIF_FECHAS(TXT_Fecha_Cuota.Text, TXT_Fecha_Ven.Text, "Y")
'
'    End If
'
'End If


If TXT_Fecha_Capitaliza.Enabled Then
    If CDate(Me.TXT_Fecha_Capitaliza.Text) >= CDate(Me.TXT_Fecha_Cuota.Text) Then
        MsgBox ("Fecha Capitalizaci�n no puede ser mayor a Fecha Primera Cuota"), vbOKOnly + vbInformation
    End If
    If CDate(Me.TXT_Fecha_Capitaliza.Text) < CDate(Me.TXT_Fecha_Otor.Text) Then
        MsgBox ("Fecha Capitalizaci�n no puede ser menor a Fecha de Otorgamiento"), vbOKOnly + vbInformation
    End If
End If

End Sub

Private Sub TXT_Fecha_Cuota_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)

End Sub

Private Sub TXT_Fecha_Cuota_LostFocus()

  If TXT_Fecha_Ven.Enabled Then
       If CDate(TXT_Fecha_Otor.Text) >= CDate(TXT_Fecha_Ven.Text) Then
           MsgBox ("Fecha Vencimiento no puede ser mayor o igual a fecha de Otorgamiento"), vbOKOnly + vbInformation
           TXT_Fecha_Ven.Text = GLB_Fecha_Proceso
       ElseIf CDate(TXT_Fecha_Ven.Text) < CDate(TXT_Fecha_Cuota.Text) Then
           MsgBox ("Fecha Vencimiento no puede ser menor a Fecha de Primera Cuota"), vbOKOnly + vbInformation
           TXT_Fecha_Ven.Text = GLB_Fecha_Proceso
       Else
           Call FUNC_CALCULA_DIF_FECHAS(TXT_Fecha_Cuota.Text, TXT_Fecha_Ven.Text, "Y")
           Call FUNC_SUMA_FECHAS(Me.TXT_Fecha_Cuota.Text, FTB_Cuotas.Text)
       End If
   End If


End Sub

Private Sub TXT_Fecha_Otor_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)

End Sub

Private Sub TXT_Fecha_Otor_LostFocus()

   If TXT_Fecha_Otor.Enabled Then
       If CDate(TXT_Fecha_Otor.Text) > GLB_Fecha_Proceso Then
           MsgBox ("Fecha de otorgamiento no puede ser mayor a Fecha de Proceso"), vbOKOnly + vbInformation
           TXT_Fecha_Otor.Text = GLB_Fecha_Proceso
       End If
   End If

End Sub

Private Sub TXT_Fecha_Ven_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)

End Sub

Private Sub FTB_Gracia_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)

End Sub

Private Function FUNC_LLENAR_COMBOS()

   If FUNC_LLENA_MONEDA(CMB_Moneda, "3", -1) Then
         ' If CMB_Moneda.ListIndex = -1 Then Exit Function
          
          CMB_Moneda.ListIndex = 0
   
   Else
           
           FUNC_LLENAR_COMBOS = False
   
   End If
   
   If FUNC_LLENA_BASES(CMB_Base, "") Then
          
          CMB_Base.ListIndex = 0
   
   Else
          
          FUNC_LLENAR_COMBOS = False
   
   End If
   
   If FUNC_LLENA_MONEDA(CMB_Tipo_Tasa, "1", -1) Then
          
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

   PROC_BUSCA_DATOS
   
End Function

Sub PROC_VALORES_DEFECTO()

Dim I As Integer
'
'   Dim Valor_Defecto As Valores_Defecto
'   Call GLB_objControl.PROC_VALORES_DEFECTO("CORFO", Valor_Defecto)
'
'
'   With Valor_Defecto
'
'      PROC_ESTABLECE_DEFECTO CMB_Moneda, Val(.cValor_codigo_moneda)
'      PROC_ESTABLECE_DEFECTO CMB_Tipo_Tasa, .nValor_tipo_tasa
'      PROC_ESTABLECE_DEFECTO CMB_Periodo, .nValor_tipo_periodo
'
'   End With

End Sub

Private Sub TXT_Fecha_Ven_LostFocus()

If TXT_Fecha_Ven.Enabled Then

    If CDate(TXT_Fecha_Otor.Text) >= CDate(TXT_Fecha_Ven.Text) Then
    
        MsgBox ("Fecha Vencimiento no puede ser mayor o igual a fecha de Otorgamiento"), vbOKOnly + vbInformation
        TXT_Fecha_Ven.Text = GLB_Fecha_Proceso
        
    ElseIf CDate(TXT_Fecha_Ven.Text) < CDate(TXT_Fecha_Cuota.Text) Then
    
        MsgBox ("Fecha Vencimiento no puede ser menor a Fecha de Primera Cuota"), vbOKOnly + vbInformation
        TXT_Fecha_Ven.Text = GLB_Fecha_Proceso
        
    Else
    
        Call FUNC_CALCULA_DIF_FECHAS(TXT_Fecha_Cuota.Text, TXT_Fecha_Ven.Text, "Y")
        
    End If
    
End If

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
    PROC_AGREGA_PARAMETRO GLB_Envia, "CORFO"
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
    GLB_Frm = Me.Name
    GLB_Cantidad_Decimal = 0
    GLB_Cantidad_Decimal = Val(FTB_Decimales.Text)
    Unload FRM_MAN_FLUJOS_RENOVACION
    FRM_MAN_FLUJOS_RENOVACION.Show 1
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
       
       MsgBox ("N�mero de Gracia debe ser menor a n�mero de cuotas"), vbOKOnly + vbInformation
       Exit Function
   
   ElseIf Format(TXT_Fecha_Cuota.Text, "YYYYMMDD") >= Format(TXT_Fecha_Ven.Text, "YYYYMMDD") Then
       
       MsgBox ("Verifique fecha de vencimiento y fecha primera cuota"), vbOKOnly + vbInformation
       Exit Function
   
   ElseIf CDate(TXT_Fecha_Cuota.Text) <= CDate(Me.TXT_Fecha_Otor.Text) Then
       
       MsgBox ("Verifique fecha de otorgamiento y fecha primera cuota"), vbOKOnly + vbInformation
       Exit Function
   
   ElseIf CDbl(FTB_Cuotas.Text) > 999 Then
       
       MsgBox ("N�mero de cuotas debe ser menor a 1000"), vbOKOnly + vbInformation
       Exit Function
      
   ElseIf Val(FTB_Decimales.Text) > 4 Then
       
       MsgBox ("M�ximo 4 decimales"), vbOKOnly + vbInformation
       Exit Function
   
   End If

   
   FUNC_VALIDAR_DATOS = True

End Function

Private Function FUNC_GRABAR_RENOVACION()

   If FTB_Rut.Text = 0 Then
      GLB_Formulario = Me.Name + "_B"
   Else
      GLB_Formulario = Me.Name
   End If
   
   FRM_ING_GRABACION.Show 1

End Function

Sub PROC_BUSCA_DATOS()

Dim vDatos_Retorno()
Dim nContador As Integer

      GLB_Envia = Array()
      PROC_AGREGA_PARAMETRO GLB_Envia, Val(Txt_Numero_Operacion.Text)
     
      If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_RENOVACION_OPERACION", GLB_Envia) Then
      
         MsgBox "No fue posible leer informaci�n", vbOKOnly + vbCritical
         Exit Sub
         
      Else
      
        
         Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
         
            Txt_Numero_Acuerdo.Text = Format(vDatos_Retorno(2), GLB_Formato_Entero)
            
            TXT_Instrumento.Text = Trim(vDatos_Retorno(3))
            TXT_Familia.Text = vDatos_Retorno(4)
            FTB_Rut.Text = vDatos_Retorno(5)
            TXT_Digito.Text = vDatos_Retorno(6)
            TXT_Nombre.Text = vDatos_Retorno(7)
            Me.FTB_VALOR_ESTIMADO1.Text = vDatos_Retorno(37)
            Me.FTB_VALOR_ESTIMADO2.Text = vDatos_Retorno(38)
            Me.FTB_VALOR_ESTIMADO3.Text = vDatos_Retorno(39)
            Me.FTB_VALOR_ESTIMADO4.Text = vDatos_Retorno(40)
            For nContador = 0 To CMB_Moneda.ListCount - 1
            
               CMB_Moneda.ListIndex = nContador
               
               If CDbl(CMB_Moneda.ItemData(CMB_Moneda.ListIndex)) = CDbl(vDatos_Retorno(8)) Then
                  
                  Exit For
               
               End If
                  
            Next
               
            FTB_Monto.Text = Round(vDatos_Retorno(9), 2) '9
            FTB_Tasa.Text = vDatos_Retorno(10)
            FTB_Total_Tasa.Text = FTB_Tasa.Text
            FTB_Spread.Text = vDatos_Retorno(11)
            
            
            For nContador = 0 To CMB_Base.ListCount - 1
            
               CMB_Base.ListIndex = nContador
               
               If CDbl(CMB_Base.ItemData(CMB_Base.ListIndex)) = CDbl(vDatos_Retorno(12)) Then
                  
                  Exit For
               
               End If
                  
            Next
            
            For nContador = 0 To CMB_Tipo_Tasa.ListCount - 1
            
               CMB_Tipo_Tasa.ListIndex = nContador
               
               If CDbl(CMB_Tipo_Tasa.ItemData(CMB_Tipo_Tasa.ListIndex)) = CDbl(vDatos_Retorno(13)) Then
                  
                  Exit For
               
               End If
                  
            Next
            
            TXT_Fecha_Otor.Text = vDatos_Retorno(14)
          
            
            For nContador = 0 To CMB_Periodo.ListCount - 1
            
               CMB_Periodo.ListIndex = nContador
               
               If CDbl(CMB_Periodo.ItemData(CMB_Periodo.ListIndex)) = CDbl(vDatos_Retorno(16)) Then
                  
                  Exit For
               
               End If
                  
            Next
            
            FTB_Cuotas.Text = vDatos_Retorno(17)
            TXT_Fecha_Cuota.Text = vDatos_Retorno(18)
            FTB_Gracia.Text = 0
            FTB_Acuerdo.Text = 0
            FTB_Acuerdo.Text = Txt_Numero_Acuerdo.Text
            
            If CDbl(FTB_Rut.Text) = 0 Then
               FRM_ACUERDO.Enabled = False
            Else
               FRM_ACUERDO.Enabled = True
            End If
            
            'RETORNO DE NUEVOS DATOS
            '***********************
            FTB_Decimales.Text = vDatos_Retorno(33)
            FTB_Gracia.Text = vDatos_Retorno(34)
            
            TXT_Fecha_Capitaliza.Enabled = False
            SCHK_Capitaliza.Value = vDatos_Retorno(36)
            
            '[IF QUE PREGUNTA SI TIENE O NO FECHA DE COLOCACION]
            '***************************************************
            If vDatos_Retorno(36) = -1 Then
                TXT_Fecha_Capitaliza.Text = vDatos_Retorno(35) '[FECHA COLOCACI�N]
                TXT_Fecha_Capitaliza.Enabled = True
            Else
                TXT_Fecha_Capitaliza.Text = vDatos_Retorno(14)
                TXT_Fecha_Capitaliza.Enabled = False
            End If
            'FIN CAMBIO
            '**********
            
            TXT_Fecha_Ven.Text = vDatos_Retorno(15)
         Loop
     End If
End Sub

Private Function FUNC_SUMA_FECHAS(dFecha_Desde As Date, nDias As Double)
Dim nSum_Dia    As Date

If CMB_Periodo.Text = "ANUAL" Then
    nSum_Dia = dFecha_Desde + ((nDias * 365) - 365)
ElseIf CMB_Periodo.Text = "SEMESTRAL" Then
    nSum_Dia = dFecha_Desde + (((nDias * 365) / 2) - 180)
ElseIf CMB_Periodo.Text = "MENSUAL" Then
    nSum_Dia = dFecha_Desde + ((nDias * 365) / 12 - 30)
ElseIf CMB_Periodo.Text = "TRIMESTRAL" Then
    nSum_Dia = dFecha_Desde + ((nDias - 1) * 90)
ElseIf CMB_Periodo.Text = "DIARIO" And (Val(Me.FTB_Cuotas.Text) = 1 Or Val(Me.FTB_Cuotas.Text) = 0) Then
  nSum_Dia = DateAdd("d", 0, TXT_Fecha_Cuota.Text)
ElseIf CMB_Periodo.Text = "DIARIO" And Val(Me.FTB_Cuotas.Text) > 1 Then
  nSum_Dia = DateAdd("d", Val(FTB_Cuotas.Text) - 1, TXT_Fecha_Cuota.Text)
End If

TXT_Fecha_Ven.Text = nSum_Dia
End Function

Private Function FUNC_CALCULA_DIF_FECHAS(dFecha_Desde As Date, dFecha_Hasta As Date, cTipo As String)
Dim nDif_ano    As Double

If CDate(dFecha_Desde) > CDate(dFecha_Hasta) Then
    MsgBox ("Fecha Vencimiento no puede ser menor a Fecha de Otorgamiento"), vbInformation
    dtbfechavcto.Text = GLB_Fecha_Proceso
    ftbplazo.Text = 0
    dtbfechavcto.SetFocus
    Exit Function
End If

nDif_ano = DateDiff(cTipo, dFecha_Desde, dFecha_Hasta)

If CMB_Periodo = "ANUAL" Then
    Me.FTB_Cuotas.Text = ((nDif_ano / 365) + 1)
ElseIf CMB_Periodo = "SEMESTRAL" Then
    Me.FTB_Cuotas.Text = ((nDif_ano / 360) * 2) + 1
ElseIf CMB_Periodo = "MENSUAL" Then
    Me.FTB_Cuotas.Text = ((nDif_ano / 360) * 12) + 1
ElseIf CMB_Periodo = "TRIMESTRAL" Then
    Me.FTB_Cuotas.Text = (nDif_ano / 360) * 6
ElseIf CMB_Periodo = "DIARIO" Then
    Me.FTB_Cuotas.Text = DateDiff("d", dFecha_Desde, dFecha_Hasta) + 1
End If
End Function

Private Sub PROC_DEVUELE_ENABLED()
FTB_Rut.Enabled = True
TXT_Nombre.Enabled = True
CMB_Moneda.Enabled = True
FTB_Monto.Enabled = True
FTB_Tasa.Enabled = True
FTB_Spread.Enabled = True
CMB_Base.Enabled = True
CMB_Tipo_Tasa.Enabled = True
TXT_Fecha_Otor.Enabled = True
TXT_Fecha_Ven.Enabled = True
FTB_Cuotas.Enabled = True
CMB_Periodo.Enabled = True
TXT_Fecha_Cuota.Enabled = True
FTB_Gracia.Enabled = True
FTB_Acuerdo.Enabled = True
SCHK_Capitaliza.Enabled = True
FTB_Rut.SetFocus
End Sub

Private Function FUNC_VALIDAR_CAMBIO_DATOS()

FUNC_VALIDAR_CAMBIO_DATOS = False

If GLB_Confirmar = True Then
   If FTB_Tasa.Text <> GLB_lc_tasa Then
       Exit Function
   ElseIf TXT_Fecha_Cuota.Text <> GLB_lc_fecha_cuota Then
       Exit Function
   ElseIf FTB_Cuotas.Text <> GLB_lc_cuota Then
       Exit Function
   ElseIf TXT_Fecha_Otor.Text <> GLB_lc_fecha_otor Then
       Exit Function
   ElseIf FTB_Monto.Text <> GLB_lc_monto Then
       Exit Function
   ElseIf FTB_Gracia.Text <> GLB_lc_gracia Then
       Exit Function
   ElseIf CMB_Moneda.Text <> GLB_lc_moneda Then
       Exit Function
   ElseIf CMB_Periodo.Text <> GLB_lc_periodo Then
       Exit Function
   ElseIf CMB_Tipo_Tasa.Text <> GLB_lc_tipo_tasa Then
       Exit Function
   ElseIf FTB_Spread.Text <> GLB_lc_spread Then
       Exit Function
   ElseIf TXT_Fecha_Ven.Text <> GLB_lc_fecha_vencim Then
       Exit Function
   ElseIf CMB_Base.Text <> GLB_lc_base Then
       Exit Function
   End If
End If

FUNC_VALIDAR_CAMBIO_DATOS = True
End Function
Sub PROC_REFRESCAR_DATOS()

   GLB_lc_tasa = FTB_Tasa.Text
   GLB_lc_fecha_cuota = TXT_Fecha_Cuota.Text 'CDate(TXT_Fecha_Cuota.Text)
   GLB_lc_cuota = FTB_Cuotas.Text
   GLB_lc_fecha_otor = TXT_Fecha_Otor.Text
   GLB_lc_monto = FTB_Monto.Text
   GLB_lc_gracia = FTB_Gracia.Text
   GLB_lc_moneda = CMB_Moneda.Text
   GLB_lc_base = CMB_Base.Text
   GLB_lc_periodo = CMB_Periodo.Text
   GLB_lc_tipo_tasa = CMB_Tipo_Tasa.Text
   GLB_lc_spread = FTB_Spread.Text
   GLB_lc_fecha_vencim = TXT_Fecha_Ven.Text
   GLB_Cantidad_Decimal = FTB_Decimales.Text
End Sub

