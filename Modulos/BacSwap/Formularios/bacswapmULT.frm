VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacOpeSwapMonedaULT 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Swaps de Monedas"
   ClientHeight    =   7095
   ClientLeft      =   660
   ClientTop       =   1125
   ClientWidth     =   10890
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   7095
   ScaleWidth      =   10890
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   15
      TabIndex        =   67
      Top             =   -15
      Width           =   10875
      _ExtentX        =   19182
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   4
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Calcular Flujo"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Grabar"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Limpiar"
            Object.Tag             =   ""
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   ""
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin Threed.SSPanel etqNumOper 
         Height          =   435
         Left            =   5715
         TabIndex        =   70
         Top             =   15
         Width           =   5085
         _Version        =   65536
         _ExtentX        =   8969
         _ExtentY        =   767
         _StockProps     =   15
         Caption         =   "Modificación Operacion N° :"
         ForeColor       =   8388736
         BackColor       =   -2147483644
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   3600
      Left            =   45
      TabIndex        =   76
      Top             =   450
      Width           =   3570
      Begin VB.OptionButton optCompra_Sacar 
         Caption         =   "Entregamos"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   330
         Left            =   150
         Style           =   1  'Graphical
         TabIndex        =   78
         ToolTipText     =   "Tipo de Operación ... Compra/Venta"
         Top             =   915
         Visible         =   0   'False
         Width           =   1575
      End
      Begin VB.OptionButton optVenta_Sacar 
         Caption         =   "Recibimos"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   330
         Left            =   1785
         Style           =   1  'Graphical
         TabIndex        =   77
         ToolTipText     =   "Tipo de Operación ... Compra/Venta"
         Top             =   915
         Value           =   -1  'True
         Visible         =   0   'False
         Width           =   1575
      End
      Begin VB.Label lblMonedas 
         Alignment       =   2  'Center
         Caption         =   "USD / UFR"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800080&
         Height          =   285
         Left            =   585
         TabIndex        =   81
         Top             =   540
         Width           =   2415
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         Caption         =   "Recibimos"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   285
         Left            =   225
         TabIndex        =   80
         Top             =   180
         Width           =   1530
      End
      Begin VB.Label Label2 
         Alignment       =   2  'Center
         Caption         =   "Entregamos"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   285
         Left            =   1785
         TabIndex        =   79
         Top             =   180
         Width           =   1530
      End
      Begin VB.Line Line1 
         BorderColor     =   &H80000005&
         Index           =   0
         X1              =   90
         X2              =   3465
         Y1              =   150
         Y2              =   150
      End
      Begin VB.Line Line1 
         BorderColor     =   &H8000000C&
         Index           =   1
         X1              =   90
         X2              =   3465
         Y1              =   840
         Y2              =   840
      End
      Begin VB.Line Line2 
         BorderColor     =   &H80000005&
         X1              =   90
         X2              =   90
         Y1              =   150
         Y2              =   840
      End
      Begin VB.Line Line3 
         BorderColor     =   &H8000000C&
         X1              =   3450
         X2              =   3450
         Y1              =   165
         Y2              =   855
      End
   End
   Begin VB.Frame frmVendimos 
      Caption         =   "Entregamos"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000C0&
      Height          =   3630
      Left            =   7305
      TabIndex        =   33
      Top             =   450
      Width           =   3540
      Begin VB.ComboBox cmbAmortizaInteresVendemos 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1065
         Style           =   2  'Dropdown List
         TabIndex        =   13
         ToolTipText     =   "Período de Amortización de Intereses"
         Top             =   1185
         Width           =   2220
      End
      Begin BACControles.TXTNumero txtSpreadVenta 
         Height          =   330
         Left            =   1455
         TabIndex        =   16
         Top             =   2205
         Width           =   1005
         _ExtentX        =   1773
         _ExtentY        =   582
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "-9999"
         Max             =   "9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txtTasaVenta 
         Height          =   330
         Left            =   1455
         TabIndex        =   15
         Top             =   1860
         Width           =   1005
         _ExtentX        =   1773
         _ExtentY        =   582
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "-9999"
         Max             =   "9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txtCapitalVenta 
         Height          =   345
         Left            =   825
         TabIndex        =   12
         Top             =   825
         Width           =   2595
         _ExtentX        =   4577
         _ExtentY        =   609
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin VB.ComboBox cmbMonedaVenta 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   45
         Style           =   2  'Dropdown List
         TabIndex        =   10
         ToolTipText     =   "Moneda Capital Venta"
         Top             =   480
         Width           =   2310
      End
      Begin VB.ComboBox cmbTasaVenta 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1455
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   14
         ToolTipText     =   "Tasa de Negocio"
         Top             =   1515
         Width           =   1830
      End
      Begin VB.ComboBox cmbBaseVenta 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1455
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   17
         ToolTipText     =   "Base en que se encuentra expresada Tasa (para calculo de intereses)"
         Top             =   2550
         Width           =   1380
      End
      Begin VB.ComboBox cmbMonedaPagamos 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1455
         Style           =   2  'Dropdown List
         TabIndex        =   18
         ToolTipText     =   "Moneda con equivalente del documento"
         Top             =   2895
         Width           =   2000
      End
      Begin VB.ComboBox cmbDocumentoPagamos 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1455
         Style           =   2  'Dropdown List
         TabIndex        =   19
         ToolTipText     =   "Documento con el que Pagaremos"
         Top             =   3240
         Width           =   2000
      End
      Begin BACControles.TXTNumero txtValorMonedaVenta 
         Height          =   330
         Left            =   2370
         TabIndex        =   11
         Top             =   480
         Width           =   1065
         _ExtentX        =   1879
         _ExtentY        =   582
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
         Min             =   "-9999"
         Max             =   "9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Interés"
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
         Height          =   210
         Index           =   30
         Left            =   90
         TabIndex        =   75
         Top             =   1275
         Width           =   600
      End
      Begin VB.Label lblTcVenta 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "T/C"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800080&
         Height          =   285
         Left            =   2370
         TabIndex        =   49
         Top             =   165
         Visible         =   0   'False
         Width           =   1035
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Capital"
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
         Height          =   210
         Index           =   27
         Left            =   75
         TabIndex        =   47
         Top             =   900
         Width           =   555
      End
      Begin VB.Label lblSwapTasa 
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
         ForeColor       =   &H00800000&
         Height          =   210
         Index           =   26
         Left            =   75
         TabIndex        =   46
         Top             =   255
         Width           =   660
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
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
         ForeColor       =   &H00800000&
         Height          =   210
         Index           =   25
         Left            =   75
         TabIndex        =   43
         Top             =   2280
         Width           =   585
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "%"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   24
         Left            =   2580
         TabIndex        =   42
         Top             =   2235
         Width           =   195
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
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
         ForeColor       =   &H00800000&
         Height          =   210
         Index           =   14
         Left            =   75
         TabIndex        =   38
         Top             =   1590
         Width           =   390
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Valor Tasa"
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
         Height          =   210
         Index           =   13
         Left            =   75
         TabIndex        =   37
         Top             =   1935
         Width           =   870
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "%"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   12
         Left            =   2580
         TabIndex        =   36
         Top             =   1920
         Width           =   195
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Base Tasa"
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
         Height          =   210
         Index           =   11
         Left            =   75
         TabIndex        =   35
         Top             =   2610
         Width           =   840
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Pagamos ..."
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
         Height          =   210
         Index           =   10
         Left            =   75
         TabIndex        =   34
         Top             =   2985
         Width           =   945
      End
   End
   Begin VB.Frame frmCompramos 
      Caption         =   "Recibimos"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   3630
      Left            =   3675
      TabIndex        =   27
      Top             =   450
      Width           =   3540
      Begin VB.ComboBox cmbAmortizaInteresCompramos 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1200
         Style           =   2  'Dropdown List
         TabIndex        =   3
         ToolTipText     =   "Período de Amortización de Intereses"
         Top             =   1170
         Width           =   2085
      End
      Begin BACControles.TXTNumero txtSpreadCompra 
         Height          =   330
         Left            =   1500
         TabIndex        =   6
         Top             =   2205
         Width           =   1005
         _ExtentX        =   1773
         _ExtentY        =   582
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "-9999"
         Max             =   "9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txtTasaCompra 
         Height          =   330
         Left            =   1500
         TabIndex        =   5
         Top             =   1860
         Width           =   1005
         _ExtentX        =   1773
         _ExtentY        =   582
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "-9999"
         Max             =   "9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txtCapitalCompra 
         Height          =   330
         Left            =   840
         TabIndex        =   2
         Top             =   825
         Width           =   2595
         _ExtentX        =   4577
         _ExtentY        =   582
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin VB.ComboBox cmbMonedaCompra 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   60
         Style           =   2  'Dropdown List
         TabIndex        =   0
         ToolTipText     =   "Moneda Capital"
         Top             =   480
         Width           =   2280
      End
      Begin VB.ComboBox cmbDocumentoRecibimos 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1500
         Style           =   2  'Dropdown List
         TabIndex        =   9
         ToolTipText     =   "Documento que Recibiremos"
         Top             =   3240
         Width           =   2000
      End
      Begin VB.ComboBox cmbMonedaRecibimos 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1500
         Style           =   2  'Dropdown List
         TabIndex        =   8
         ToolTipText     =   "Moneda con equivalente del documento"
         Top             =   2895
         Width           =   2000
      End
      Begin VB.ComboBox cmbBaseCompra 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1500
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   7
         ToolTipText     =   "Base en que se encuentra expresada Tasa (para calculo de intereses)"
         Top             =   2550
         Width           =   1365
      End
      Begin VB.ComboBox cmbTasaCompra 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         ItemData        =   "bacswapmULT.frx":0000
         Left            =   1500
         List            =   "bacswapmULT.frx":0002
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   4
         ToolTipText     =   "Tasa de Negocio"
         Top             =   1515
         Width           =   1785
      End
      Begin BACControles.TXTNumero txtValorMonedaCompra 
         Height          =   330
         Left            =   2370
         TabIndex        =   1
         Top             =   480
         Width           =   1065
         _ExtentX        =   1879
         _ExtentY        =   582
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
         Min             =   "-9999"
         Max             =   "9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Interés"
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
         Height          =   210
         Index           =   17
         Left            =   90
         TabIndex        =   74
         Top             =   1260
         Width           =   600
      End
      Begin VB.Label lblTcCompraxx 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "T/C"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800080&
         Height          =   285
         Left            =   2385
         TabIndex        =   48
         Top             =   180
         Visible         =   0   'False
         Width           =   1050
      End
      Begin VB.Label lblSwapTasa 
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
         ForeColor       =   &H00800000&
         Height          =   210
         Index           =   0
         Left            =   75
         TabIndex        =   45
         Top             =   270
         Width           =   660
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Capital"
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
         Height          =   210
         Index           =   1
         Left            =   75
         TabIndex        =   44
         Top             =   885
         Width           =   555
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
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
         ForeColor       =   &H00800000&
         Height          =   210
         Index           =   23
         Left            =   75
         TabIndex        =   41
         Top             =   2265
         Width           =   585
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "%"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   22
         Left            =   2610
         TabIndex        =   40
         Top             =   2280
         Width           =   195
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Recibimos ..."
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
         Height          =   210
         Index           =   9
         Left            =   75
         TabIndex        =   32
         Top             =   2970
         Width           =   1050
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Base Tasa"
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
         Height          =   210
         Index           =   8
         Left            =   75
         TabIndex        =   31
         Top             =   2625
         Width           =   840
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "%"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   7
         Left            =   2610
         TabIndex        =   30
         Top             =   1920
         Width           =   195
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Valor Tasa"
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
         Height          =   210
         Index           =   6
         Left            =   75
         TabIndex        =   29
         Top             =   1905
         Width           =   870
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
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
         ForeColor       =   &H00800000&
         Height          =   210
         Index           =   5
         Left            =   75
         TabIndex        =   28
         Top             =   1575
         Width           =   390
      End
   End
   Begin TabDlg.SSTab tabFlujos 
      Height          =   2670
      Left            =   30
      TabIndex        =   39
      Top             =   4095
      Width           =   10800
      _ExtentX        =   19050
      _ExtentY        =   4710
      _Version        =   393216
      TabHeight       =   520
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "Definiciones"
      TabPicture(0)   =   "bacswapmULT.frx":0004
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Frame4"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "Frame2(1)"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "Frame3"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "Frame5"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).ControlCount=   4
      TabCaption(1)   =   "Flujos Recibimos"
      TabPicture(1)   =   "bacswapmULT.frx":0020
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "fgFlujosCompra"
      Tab(1).Control(1)=   "cmbModalidad"
      Tab(1).Control(2)=   "txtAmortiza"
      Tab(1).Control(3)=   "txtFechaRecib"
      Tab(1).ControlCount=   4
      TabCaption(2)   =   "Flujos Entregamos"
      TabPicture(2)   =   "bacswapmULT.frx":003C
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "txtFechaPag"
      Tab(2).Control(1)=   "txtAmortizaVen"
      Tab(2).Control(2)=   "cmbModalidadVen"
      Tab(2).Control(3)=   "fgFlujosVenta"
      Tab(2).ControlCount=   4
      Begin VB.Frame Frame5 
         Caption         =   "Amortización Entregamos"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800080&
         Height          =   1365
         Left            =   7440
         TabIndex        =   71
         Top             =   330
         Width           =   3270
         Begin VB.ComboBox cmbAmortizaCapitalVendemos 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   795
            Style           =   2  'Dropdown List
            TabIndex        =   72
            ToolTipText     =   "Período de Amortización de Capital"
            Top             =   375
            Width           =   2205
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   "Capital"
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
            Height          =   210
            Index           =   31
            Left            =   90
            TabIndex        =   73
            Top             =   405
            Width           =   555
         End
      End
      Begin BACControles.TXTFecha txtFechaPag 
         Height          =   285
         Left            =   -74010
         TabIndex        =   66
         Top             =   1125
         Width           =   1275
         _ExtentX        =   2249
         _ExtentY        =   503
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
         Text            =   "20/08/2001"
      End
      Begin BACControles.TXTNumero txtAmortizaVen 
         Height          =   330
         Left            =   -71670
         TabIndex        =   65
         Top             =   1125
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   582
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
      End
      Begin BACControles.TXTFecha txtFechaRecib 
         Height          =   330
         Left            =   -72885
         TabIndex        =   64
         Top             =   1125
         Width           =   1230
         _ExtentX        =   2170
         _ExtentY        =   582
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
         Text            =   "20/08/2001"
      End
      Begin BACControles.TXTNumero txtAmortiza 
         Height          =   330
         Left            =   -71760
         TabIndex        =   63
         Top             =   765
         Width           =   1950
         _ExtentX        =   3440
         _ExtentY        =   582
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
      End
      Begin VB.Frame Frame3 
         Caption         =   "Amortización Recibimos"
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
         Height          =   1365
         Left            =   4290
         TabIndex        =   52
         Top             =   330
         Width           =   3135
         Begin VB.ComboBox cmbAmortizaCapitalCompramos 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   795
            Style           =   2  'Dropdown List
            TabIndex        =   20
            ToolTipText     =   "Período de Amortización de Capital"
            Top             =   360
            Width           =   2085
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   "Capital"
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
            Height          =   210
            Index           =   16
            Left            =   90
            TabIndex        =   53
            Top             =   405
            Width           =   555
         End
      End
      Begin VB.ComboBox cmbModalidadVen 
         Height          =   315
         Left            =   -68610
         Style           =   2  'Dropdown List
         TabIndex        =   51
         ToolTipText     =   "Con tecla Enter acepta modificación"
         Top             =   540
         Visible         =   0   'False
         Width           =   1445
      End
      Begin VB.ComboBox cmbModalidad 
         Height          =   315
         Left            =   -66270
         Style           =   2  'Dropdown List
         TabIndex        =   50
         ToolTipText     =   "Con tecla Enter acepta modificación"
         Top             =   1035
         Visible         =   0   'False
         Width           =   1445
      End
      Begin VB.Frame Frame2 
         Caption         =   "Fechas"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800080&
         Height          =   2235
         Index           =   1
         Left            =   75
         TabIndex        =   56
         Top             =   330
         Width           =   4200
         Begin BACControles.TXTFecha txtFecPrimerVcto 
            Height          =   300
            Left            =   270
            TabIndex        =   24
            Top             =   1770
            Width           =   1290
            _ExtentX        =   2275
            _ExtentY        =   529
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "20/08/2001"
         End
         Begin BACControles.TXTFecha txtFecTermino 
            Height          =   300
            Left            =   270
            TabIndex        =   22
            Top             =   930
            Width           =   1260
            _ExtentX        =   2223
            _ExtentY        =   529
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "20/08/2001"
         End
         Begin BACControles.TXTFecha txtFecInicio 
            Height          =   300
            Left            =   270
            TabIndex        =   21
            Top             =   420
            Width           =   1260
            _ExtentX        =   2223
            _ExtentY        =   529
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "20/08/2001"
         End
         Begin VB.ComboBox cmbEspecial 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   270
            Style           =   2  'Dropdown List
            TabIndex        =   23
            Top             =   1425
            Width           =   1500
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   "Término"
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
            Height          =   210
            Index           =   3
            Left            =   120
            TabIndex        =   62
            Top             =   720
            Width           =   705
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   "Inicio"
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
            Height          =   210
            Index           =   2
            Left            =   135
            TabIndex        =   61
            Top             =   210
            Width           =   435
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   "Amotización Especial"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800080&
            Height          =   210
            Index           =   18
            Left            =   135
            TabIndex        =   60
            Top             =   1230
            Width           =   1740
         End
         Begin VB.Label lblFechaTermino 
            BorderStyle     =   1  'Fixed Single
            Caption         =   "lblFechaTermino"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   300
            Left            =   1530
            TabIndex        =   59
            Top             =   930
            Width           =   2460
         End
         Begin VB.Label lblFechaPrimerAmort 
            BorderStyle     =   1  'Fixed Single
            Caption         =   "lblFechaPrimerAmort"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   300
            Left            =   1575
            TabIndex        =   58
            Top             =   1770
            Width           =   2460
         End
         Begin VB.Label lblFechaInicio 
            BorderStyle     =   1  'Fixed Single
            Caption         =   "lblFechaInicio"
            BeginProperty DataFormat 
               Type            =   1
               Format          =   "d-MMM-yy"
               HaveTrueFalseNull=   0
               FirstDayOfWeek  =   0
               FirstWeekOfYear =   0
               LCID            =   13322
               SubFormatType   =   3
            EndProperty
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   300
            Left            =   1530
            TabIndex        =   57
            Top             =   420
            Width           =   2460
         End
      End
      Begin VB.Frame Frame4 
         Height          =   945
         Left            =   4305
         TabIndex        =   54
         Top             =   1620
         Width           =   6405
         Begin VB.OptionButton optEntFisica 
            Caption         =   "&Entrega Física"
            BeginProperty Font 
               Name            =   "Verdana"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000C0&
            Height          =   315
            Left            =   3270
            Style           =   1  'Graphical
            TabIndex        =   26
            ToolTipText     =   "Modalidad de Pago de Contrato y/o Flujos"
            Top             =   435
            Width           =   3000
         End
         Begin VB.OptionButton optCompensa 
            Caption         =   "&Compensación"
            BeginProperty Font 
               Name            =   "Verdana"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   315
            Left            =   90
            Style           =   1  'Graphical
            TabIndex        =   25
            ToolTipText     =   "Modalidad de Pago de Contrato y/o Flujos"
            Top             =   435
            Value           =   -1  'True
            Width           =   3000
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   "Modalidad de Pago"
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
            Height          =   210
            Index           =   19
            Left            =   2430
            TabIndex        =   55
            Top             =   150
            Width           =   1545
         End
      End
      Begin MSFlexGridLib.MSFlexGrid fgFlujosVenta 
         Height          =   2235
         Left            =   -74910
         TabIndex        =   82
         Top             =   420
         Width           =   10635
         _ExtentX        =   18759
         _ExtentY        =   3942
         _Version        =   393216
         RowHeightMin    =   315
         BackColor       =   -2147483644
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483643
         BackColorBkg    =   -2147483645
         GridColor       =   -2147483644
         GridColorFixed  =   -2147483642
         GridLines       =   2
         GridLinesFixed  =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin MSFlexGridLib.MSFlexGrid fgFlujosCompra 
         Height          =   2235
         Left            =   -74865
         TabIndex        =   83
         Top             =   420
         Width           =   10620
         _ExtentX        =   18733
         _ExtentY        =   3942
         _Version        =   393216
         RowHeightMin    =   315
         BackColor       =   -2147483644
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483643
         BackColorBkg    =   -2147483645
         GridColor       =   -2147483644
         GridColorFixed  =   -2147483642
         GridLines       =   2
         GridLinesFixed  =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin VB.Label Lbl_Num_Oper_Oculto 
      BorderStyle     =   1  'Fixed Single
      Height          =   435
      Left            =   165
      TabIndex        =   84
      Top             =   7575
      Width           =   2430
   End
   Begin VB.Label lblSwapTasa 
      AutoSize        =   -1  'True
      Caption         =   "Flujos Vencidos"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Index           =   28
      Left            =   345
      TabIndex        =   69
      Top             =   6825
      Visible         =   0   'False
      Width           =   1560
   End
   Begin VB.Label Simbologia 
      BackColor       =   &H00FFFFC0&
      BorderStyle     =   1  'Fixed Single
      Height          =   240
      Left            =   75
      TabIndex        =   68
      Top             =   6810
      Visible         =   0   'False
      Width           =   240
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   1785
      Top             =   240
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   4
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacswapmULT.frx":0058
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacswapmULT.frx":0372
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacswapmULT.frx":068C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacswapmULT.frx":09A6
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacOpeSwapMonedaULT"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Const FormatEspecial = "###,###,###,##0.###0"
Const FormatEsp = "###,###,###"
Const FormatEsp1 = "###0.###0"

Dim cMonedaCom$
Dim cMonedaVen$
Dim nEquivUSD$
Dim cTipoOperacion$
Dim nDiasInteres#
Dim nDiasCapital#
Dim PasoTexto           As String
Dim cModalidad          As String
Dim nNumoper            As Integer
Dim cOperSwap           As String

Dim lEntrada            As Boolean
Dim FechaCierre         As Date
Dim ValorDolarObs       As Double
Dim DatosPorMoneda()
Dim TotDatPorMon        As Double
Dim DesgloseAmort       As String
Dim objMoneda           As New ClsMoneda

Dim ValorAnt            As String
Dim ValorUlt            As String
Dim nPaisOrigen         As Integer
Dim cSwMxC              As String
Dim cRrdaC              As String
Dim cSwMxV              As String
Dim cRrdaV              As String

Private Enum xOperacion
   [Compra] = 1
   [Venta] = 2
End Enum
Private Enum xConsulta
   [moneda] = 1
   [Documento] = 2
End Enum

Private Sub CargaMonedaDocPagoLocal(ByVal iMoneda As Integer, ByRef objCarga As ComboBox, Optional QueCarga As xConsulta)
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, "PCS"
   AddParam Envia, iMoneda
   AddParam Envia, CDbl(QueCarga)
   If Not Bac_Sql_Execute("SP_MONEDA_DOC_PAGO", Envia) Then
      Exit Sub
   End If
   objCarga.Clear
   Do While Bac_SQL_Fetch(Datos())
      objCarga.AddItem Datos(2)
      objCarga.ItemData(objCarga.NewIndex) = Val(Datos(1))
   Loop
End Sub

Private Sub cmbMonedaCompra_Click()
   Dim SQL$
   Dim Datos()
   Dim nCodMon%
   Dim Peri
   Dim MiMoneda   As New ClsMoneda
   Dim iCodMonVta As Integer
   Dim iCodMonCom As Integer
   Dim iValMonVta As Double
   Dim iValMonCom As Double
   Dim iNemMonCom As String
   Dim iNemMonVta As String
   Dim iMxMonCom  As String
   Dim iMxMonVta  As String
   Const iCodMonDolar = 13
   
   If cmbMonedaVenta.ListIndex = -1 Then
      Exit Sub
   End If
   iCodMonVta = cmbMonedaVenta.ItemData(cmbMonedaVenta.ListIndex)
   If cmbMonedaCompra.ListIndex = -1 Then
      Exit Sub
   End If
   iCodMonCom = cmbMonedaCompra.ItemData(cmbMonedaCompra.ListIndex)
   
   If iCodMonVta = iCodMonCom Then
      Call bacBuscarCombo(cmbMonedaVenta, Val(cmbMonedaCompra.Tag))
   End If
   
   
   Call MiMoneda.LeerxCodigo(iCodMonCom)
      iValMonCom = IIf(iCodMonCom = iCodMonDolar, gsBAC_DolarObs, MiMoneda.vmValor)
      iNemMonCom = MiMoneda.mnnemo
      iMxMonCom = MiMoneda.mnmx
      cSwMxC = MiMoneda.mnmx
      cRrdaC = MiMoneda.mnrrda
      nEquivUSD$ = MiMoneda.mnrefusd
   
   Call MiMoneda.LeerxCodigo(iCodMonVta)
      iValMonVta = IIf(iCodMonVta = iCodMonDolar, gsBAC_DolarObs, MiMoneda.vmValor)
      iNemMonVta = MiMoneda.mnnemo
      iMxMonVta = MiMoneda.mnmx
      cSwMxV = MiMoneda.mnmx
      cRrdaV = MiMoneda.mnrrda
   
   If iCodMonCom = 999 Then
      txtValorMonedaCompra.CantidadDecimales = 0
   Else
      txtValorMonedaCompra.CantidadDecimales = 4
   End If
   
   If iCodMonCom = iCodMonDolar Then
      txtValorMonedaCompra.Text = Format(iValMonCom, TipoFormato(iNemMonCom))
      If iCodMonVta = iCodMonDolar Then
         Call bacBuscarCombo(cmbMonedaVenta, 998)
      Else
         If iMxMonVta = "C" Then
            txtValorMonedaVenta.Text = Format(CDbl(F_Trae_paridad_bcch(iNemMonVta, Format(gsBAC_Fecp, "yyyymmdd"))), TipoFormato(iNemMonVta))
         Else
            txtValorMonedaVenta.Text = Format(iValMonVta, TipoFormato(iNemMonVta))
         End If
      End If
   Else
      If iMxMonCom = "C" And iCodMonCom <> iCodMonDolar Then
         txtValorMonedaCompra.Text = Format(CDbl(F_Trae_paridad_bcch(iNemMonCom, Format(gsBAC_Fecp, "yyyymmdd"))), TipoFormato(iNemMonCom))
      Else
         txtValorMonedaCompra.Text = IIf(iCodMonCom = 999, 1, iValMonCom)
      End If
   End If
   
   '--> Busca Tasas asociadas
   Peri = 0
   If cmbAmortizaInteresCompramos.ListIndex <> -1 Then
      Peri = Val(Trim(Right(cmbAmortizaInteresCompramos, 10)))
   End If
   Call CargaTasaMoneda(cmbTasaCompra, iCodMonCom, 0, Peri)
   Call CargaMonedaDocPagoLocal(cmbMonedaCompra.ItemData(cmbMonedaCompra.ListIndex), cmbMonedaRecibimos, moneda)
   lblMonedas.Caption = iNemMonCom & " / " & iNemMonVta
   cmbMonedaCompra.Tag = cmbMonedaCompra.ItemData(cmbMonedaCompra.ListIndex)
   
   
   Call Conversion(True)
   
   Set MiMoneda = Nothing
End Sub

Private Sub cmbMonedaVenta_Click()
   Dim SQL$
   Dim Datos()
   Dim nCodMon%
   Dim Peri       As Integer
   Dim MiMoneda   As New ClsMoneda
   Dim iCodMonVta As Integer
   Dim iCodMonCom As Integer
   Dim iValMonVta As Double
   Dim iValMonCom As Double
   Dim iNemMonCom As String
   Dim iNemMonVta As String
   Dim iMxMonCom  As String
   Dim iMxMonVta  As String
   Const iCodMonDolar = 13
   
   If cmbMonedaVenta.ListIndex = -1 Then
      Exit Sub
   End If
   iCodMonVta = cmbMonedaVenta.ItemData(cmbMonedaVenta.ListIndex)
   If cmbMonedaCompra.ListIndex = -1 Then
      Exit Sub
   End If
   iCodMonCom = cmbMonedaCompra.ItemData(cmbMonedaCompra.ListIndex)
   
   If iCodMonVta = iCodMonCom Then
      Call bacBuscarCombo(cmbMonedaCompra, Val(cmbMonedaVenta.Tag))
   End If
   
   
   Call MiMoneda.LeerxCodigo(iCodMonCom)
      iValMonCom = IIf(iCodMonCom = iCodMonDolar, gsBAC_DolarObs, MiMoneda.vmValor)
      iNemMonCom = MiMoneda.mnnemo
      iMxMonCom = MiMoneda.mnmx
      cSwMxC = MiMoneda.mnmx
      cRrdaC = MiMoneda.mnrrda
   
   Call MiMoneda.LeerxCodigo(iCodMonVta)
      iValMonVta = IIf(iCodMonVta = iCodMonDolar, gsBAC_DolarObs, MiMoneda.vmValor)
      iNemMonVta = MiMoneda.mnnemo
      iMxMonVta = MiMoneda.mnmx
      cSwMxV = MiMoneda.mnmx
      cRrdaV = MiMoneda.mnrrda
      nEquivUSD$ = MiMoneda.mnrefusd
   
   If iCodMonVta = 999 Then
      txtValorMonedaVenta.CantidadDecimales = 0
   Else
      txtValorMonedaVenta.CantidadDecimales = 4
   End If

   If iCodMonVta = iCodMonDolar Then
      txtValorMonedaVenta.Text = gsBAC_DolarObs
      If iCodMonCom = iCodMonDolar Then
         Call bacBuscarCombo(cmbMonedaCompra, 998)
      Else
         Call objMoneda.LeerxCodigo(iCodMonCom)
         iValMonCom = objMoneda.vmValor
         txtValorMonedaCompra.Text = Format(iValMonCom, TipoFormato(objMoneda.mnnemo))
      End If
   Else
      If MiMoneda.mnmx = "C" And iCodMonVta <> iCodMonDolar Then
         txtValorMonedaVenta.Text = Format(CDbl(F_Trae_paridad_bcch(MiMoneda.mnnemo, Format(gsBAC_Fecp, "yyyymmdd"))), TipoFormato(MiMoneda.mnnemo))
      Else
         txtValorMonedaVenta.Text = IIf(iCodMonVta = 999, 1, iValMonVta)
      End If
   End If
   
   '--> Busca Tasas por la moneda seleccionada
   Peri = 0
   If cmbAmortizaInteresVendemos.ListIndex <> -1 Then
      Peri = Val(Trim(Right(cmbAmortizaInteresVendemos, 10)))
   End If
   Call CargaTasaMoneda(cmbTasaVenta, iCodMonVta, 0, Peri)
   Call CargaMonedaDocPagoLocal(cmbMonedaVenta.ItemData(cmbMonedaVenta.ListIndex), cmbMonedaPagamos, moneda)
   lblMonedas.Caption = iNemMonCom & " / " & iNemMonVta
   cmbMonedaVenta.Tag = cmbMonedaVenta.ItemData(cmbMonedaVenta.ListIndex)
   Call Conversion(False)
   
   Set MiMoneda = Nothing
End Sub

Private Sub CargaTasaMoneda(ByRef objCarga As ComboBox, ByVal CodMoneda As Integer, ByVal CodTasa As Integer, ByVal CodPeriodo As Integer)
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(CodMoneda)
   AddParam Envia, CDbl(CodTasa)
   AddParam Envia, CDbl(CodPeriodo)
   If Not Bac_Sql_Execute("SP_RETORNA_TASAMONEDA", Envia) Then
      Exit Sub
   End If
   Call BacControlWindows(10)
   objCarga.Clear
   Do While Bac_SQL_Fetch(Datos())
      objCarga.AddItem Datos(2)
      objCarga.ItemData(objCarga.NewIndex) = CDbl(Datos(1))
   Loop
   
End Sub

Private Sub MuestraDatosMoneda(ByRef Arreglo As Variant)
   Dim iMaxCount  As Integer
   Dim iMinCount  As Integer
   Dim iCadena    As String
   
   iMaxCount = 303 ' UBound(Arreglo)
   iMinCount = 1
   iCadena = ""
   For iMinCount = 1 To iMaxCount
      iCadena = ""
      iCadena = iCadena & CStr(Arreglo(1, iMinCount)) & "-" & CStr(Arreglo(2, iMinCount)) & "-" & CStr(Arreglo(3, iMinCount)) & "-" & CStr(Arreglo(4, iMinCount)) & "-" & CStr(Arreglo(5, iMinCount))
      Debug.Print iCadena
   Next iMinCount
   
End Sub

Private Function CambiaColorCeldas(Grd As Object)
   Dim I, j
   
   For I = 1 To Grd.Rows - 1
      If Grd.TextMatrix(I, Grd.Cols - 1) = "CH" Then
         Grd.Row = I
         For j = 1 To Grd.Cols - 1
            Grd.Col = j
            Grd.CellForeColor = &HFFFFC0
         Next j
      End If
   Next I
    
End Function


Function SugerirFechaPrimVecto(OpOperacion As String)
   Dim DiasCap, DiasInt    As Integer
   Dim AmortizaCapital     As ComboBox
   Dim AmortizaInteres     As ComboBox
   Dim FecPrimerVcto       As Object
   Dim fecInicio           As Object
   Dim fecTermino          As Object

   If OpOperacion = "C" Then
      Set AmortizaCapital = cmbAmortizaCapitalCompramos
      Set AmortizaInteres = cmbAmortizaInteresCompramos
      Set FecPrimerVcto = txtFecPrimerVcto
      Set fecInicio = txtFecInicio
      Set fecTermino = txtFecTermino
      DesgloseAmort = SacaTipoPeriodo(cmbBaseCompra)
   Else
      Set AmortizaCapital = cmbAmortizaCapitalVendemos
      Set AmortizaInteres = cmbAmortizaInteresVendemos
      Set FecPrimerVcto = txtFecPrimerVcto
      Set fecInicio = txtFecInicio
      Set fecTermino = txtFecTermino
      DesgloseAmort = SacaTipoPeriodo(cmbBaseVenta)
   End If

   'Sugiere fecha Primer y Ultimo vencimiento
   If AmortizaCapital.ListIndex = -1 Or AmortizaInteres.ListIndex = -1 Then
      FecPrimerVcto.Text = CreaFechaProx(fecInicio, 1, Day(fecInicio), DesgloseAmort)
   Else
      DiasCap = ValorAmort(AmortizaCapital, DesgloseAmort)
      DiasInt = ValorAmort(AmortizaInteres, DesgloseAmort)
      DiasCap = IIf(DiasCap <= 0, DiasInt, DiasCap)
      'Primer Vencimiento
      FecPrimerVcto.Text = CreaFechaProx(fecInicio.Text, DiasCap, Day(fecInicio.Text), DesgloseAmort)
      fecTermino.Text = FecPrimerVcto.Text
   End If

End Function

Function ValidaFechasIngreso(Cual, Evento, Operacion As String) As Boolean
   Dim fecInicio     As Object
   Dim fecTermino    As Object
   Dim FecPrimerVcto As Object

   ValidaFechasIngreso = False
    
   If Operacion = "C" Then
      Set fecInicio = txtFecInicio
      Set fecTermino = txtFecPrimerVcto
      Set FecPrimerVcto = txtFecPrimerVcto
   Else
      Set fecInicio = txtFecInicio
      Set fecTermino = txtFecPrimerVcto
      Set FecPrimerVcto = txtFecPrimerVcto
   End If

   Select Case Cual
      Case 1
         If fecInicio.Text <> "" Then
            If IsDate(fecInicio.Text) Then
               fecInicio.Text = Format(fecInicio.Text, gsc_FechaDMA)
               fecInicio.Text = ValidaFecha(fecInicio.Text)
               lblFechaInicio = BacFechaStr(fecInicio.Text)
               Call SugerirFechaPrimVecto(Operacion)
               If CDate(fecTermino.Text) < CDate(FecPrimerVcto.Text) Then
                  fecTermino.Text = FecPrimerVcto.Text
               End If
            Else
               MsgBox "Fecha de Inicio no es válida", vbInformation, Msj
               fecInicio.SetFocus
            End If
         End If
      Case 2
         If FecPrimerVcto.Text <> "" And lblFechaTermino.ForeColor <> vbRed And lblFechaInicio.ForeColor <> vbRed Then
            If IsDate(FecPrimerVcto.Text) Then
               If CDate(FecPrimerVcto.Text) <= CDate(txtFecInicio.Text) Then
                  MsgBox "Fecha de Primer Vencimiento no puede ser menor o igual a Fecha de Inicio", vbInformation, Msj
                  Call SugerirFechaPrimVecto("C")
                  FecPrimerVcto.SetFocus
                  Set fecInicio = Nothing
                  Set fecTermino = Nothing
                  Set FecPrimerVcto = Nothing
                  
                  Exit Function
               ElseIf Format(FecPrimerVcto.Text, "yyyymmdd") <= Format(gsBAC_Fecp, "yyyymmdd") Then
                  MsgBox "Fecha Primer Vencimiento de Amortización de Capital no puede ser menor o igual a Fecha de Proceso", vbInformation, Msj
                  FecPrimerVcto.SetFocus
                  Set fecInicio = Nothing
                  Set fecTermino = Nothing
                  Set FecPrimerVcto = Nothing
                  
                  Exit Function
               ElseIf Not BacEsHabil(FecPrimerVcto.Text) Then
                  MsgBox "Fecha Primer Vencimiento de Amortización de Capital no es día hábil", vbInformation, Msj
                  FecPrimerVcto.SetFocus
                  Set fecInicio = Nothing
                  Set fecTermino = Nothing
                  Set FecPrimerVcto = Nothing
                  
                  Exit Function
               End If
               FecPrimerVcto.Text = Format(FecPrimerVcto.Text, gsc_FechaDMA)
               lblFechaPrimerAmort = BacFechaStr(FecPrimerVcto.Text)
            Else
               MsgBox "Fecha de Primer Vencimiento no es válida", vbInformation, Msj
               FecPrimerVcto.SetFocus
            End If
         End If
      Case 3
         If fecTermino.Text <> "" And lblFechaPrimerAmort.ForeColor <> vbRed And lblFechaInicio.ForeColor <> vbRed Then
            If IsDate(fecTermino.Text) Then
               fecTermino.Text = Format(fecTermino.Text, gsc_FechaDMA)
               lblFechaTermino = BacFechaStr(fecTermino.Text)
               If CDate(fecTermino.Text) < CDate(FecPrimerVcto.Text) Then
                  MsgBox "Fecha Termino de Operación no puede ser menor a Fecha de primer Vencimiento de Amortización de Capital", vbInformation, Msj
                  fecTermino.SetFocus
                  Set fecInicio = Nothing
                  Set fecTermino = Nothing
                  Set FecPrimerVcto = Nothing
                  
                  Exit Function
               ElseIf Not BacEsHabil(fecTermino.Text) Then
                  MsgBox "Fecha de Término no es día hábil", vbInformation, Msj
                  fecTermino.SetFocus
                  Set fecInicio = Nothing
                  Set fecTermino = Nothing
                  Set FecPrimerVcto = Nothing
                  
                  Exit Function
               End If
            Else
               MsgBox "Fecha Termino de Vencimientos no es válida", vbInformation, Msj
               fecTermino.SetFocus
            End If
         End If
   End Select
   ValidaFechasIngreso = True

End Function

Function BuscarDatos()
   Dim Mantencion    As New clsMantencionSwap
   Dim RutPaso       As String
   Dim total         As Double
   Dim I             As Integer
   Dim Hasta         As Integer
   Dim desde         As Integer
   Dim j             As Integer
   Dim lPrimero      As Boolean
    
   Call LLenafgrdFlujos(fgFlujosCompra)
   Call LLenafgrdFlujos(fgFlujosVenta)
    
   fgFlujosCompra.Rows = 1
   fgFlujosVenta.Rows = 1
   desde = 1
   j = 1
    
   With Mantencion
      If cOperSwap = "ModificacionCartera" Then
         'Busca datos en cartera  historica - movimientos vencidos
         Mantencion.NumOperacion = nNumoper
         Mantencion.TipoOperacion = 4
         If Not Mantencion.LeerDatos Then
            Set Mantencion = Nothing
         ElseIf Mantencion.coleccion.Count > 0 Then
            Hasta = Mantencion.coleccion.Count
            For I = 1 To Hasta
               If Mantencion.coleccion(I).swTipoFlujo = 1 Then
                  fgFlujosCompra.Rows = fgFlujosCompra.Rows + 1
                  j = fgFlujosCompra.Rows - 1
               End If
               fgFlujosCompra.TextMatrix(j, 0) = (Mantencion.coleccion(I).swNumFlujo) & "  "
               fgFlujosCompra.TextMatrix(j, 1) = Format(Mantencion.coleccion(I).swFechaVenceFlujo, "dd/mm/yyyy")
               fgFlujosCompra.TextMatrix(j, 2) = Format(BacStrTran((Mantencion.coleccion(I).swCAmortiza), ".", gsc_PuntoDecim), FormatEspecial)
               fgFlujosCompra.TextMatrix(j, 3) = Format(BacStrTran((Mantencion.coleccion(I).swCValorTasa), ".", gsc_PuntoDecim), FormatEspecial)
               fgFlujosCompra.TextMatrix(j, 4) = Format(BacStrTran((Mantencion.coleccion(I).swCInteres), ".", gsc_PuntoDecim), FormatEspecial)
               fgFlujosCompra.TextMatrix(j, 5) = Format(total, FormatEspecial)
               fgFlujosCompra.TextMatrix(j, 6) = IIf(Mantencion.coleccion(I).swModalidadPago = "C", "Compensación" & Space(50) & "C", "Ent. Fisica" & Space(50) & "F")
               fgFlujosCompra.TextMatrix(j, 8) = BacStrTran((Mantencion.coleccion(I).swCSaldo), ".", gsc_PuntoDecim)
               fgFlujosCompra.TextMatrix(j, 9) = Format(Mantencion.coleccion(I).swFechaInicioFlujo, "dd/mm/yyyy")
               fgFlujosCompra.TextMatrix(j, 10) = BacStrTran((Mantencion.coleccion(I).swRecMonto), ".", gsc_PuntoDecim)
               fgFlujosCompra.TextMatrix(j, 11) = BacStrTran((Mantencion.coleccion(I).swRecMontoUSD), ".", gsc_PuntoDecim)
               fgFlujosCompra.TextMatrix(j, 12) = BacStrTran((Mantencion.coleccion(I).swRecMontoCLP), ".", gsc_PuntoDecim)
               fgFlujosCompra.TextMatrix(j, 13) = "CH"
            Next I
               
            For I = 1 To Hasta
               If Mantencion.coleccion(I).swTipoFlujo = 2 Then
                  fgFlujosVenta.Rows = fgFlujosVenta.Rows + 1
                  j = fgFlujosVenta.Rows - 1
               End If
               fgFlujosVenta.TextMatrix(j, 0) = .coleccion(I).swNumFlujo & "  "
               fgFlujosVenta.TextMatrix(j, 1) = Format(.coleccion(I).swFechaVenceFlujo, "dd/mm/yyyy")
               fgFlujosVenta.TextMatrix(j, 2) = Format(.coleccion(I).swVAmortiza, FormatEspecial)
               fgFlujosVenta.TextMatrix(j, 3) = Format(.coleccion(I).swVValorTasa, FormatEsp1)
               fgFlujosVenta.TextMatrix(j, 4) = Format(.coleccion(I).swVInteres, FormatEspecial)
               fgFlujosVenta.TextMatrix(j, 5) = Format(total, FormatEspecial)
               fgFlujosVenta.TextMatrix(j, 6) = IIf(.coleccion(I).swModalidadPago = "C", "Compensación" & Space(50) & "C", "Ent. Fisica" & Space(50) & "F")
               fgFlujosVenta.TextMatrix(j, 8) = BacStrTran((.coleccion(I).swVSaldo), ".", gsc_PuntoDecim)
               fgFlujosVenta.TextMatrix(j, 9) = Format(.coleccion(I).swFechaInicioFlujo, "dd/mm/yyyy")
               fgFlujosVenta.TextMatrix(j, 10) = BacStrTran((.coleccion(I).swPagMonto), ".", gsc_PuntoDecim)
               fgFlujosVenta.TextMatrix(j, 11) = BacStrTran((.coleccion(I).swPagMontoUSD), ".", gsc_PuntoDecim)
               fgFlujosVenta.TextMatrix(j, 12) = BacStrTran((.coleccion(I).swPagMontoCLP), ".", gsc_PuntoDecim)
               fgFlujosVenta.TextMatrix(j, 13) = "CH"
            Next I
            j = fgFlujosCompra.Rows
            lblSwapTasa(22).Visible = True
         End If
         Set Mantencion.coleccion = Nothing
      End If
      
      Mantencion.NumOperacion = nNumoper
      Mantencion.TipoOperacion = swModTipoOpe
      
      If Not Mantencion.LeerDatos Then
         Set Mantencion = Nothing
         MsgBox "Operación no ha sido encontrada", vbCritical, Msj
         Exit Function
      End If
      
      'Ubica datos en la pantalla
      I = 1
      Hasta = Mantencion.coleccion.Count
      etqNumOper.Caption = etqNumOper.Caption & nNumoper
      
      If Mantencion.coleccion(1).swModalidadPago = "C" Then
         optCompensa.Value = True
      Else
         optEntFisica.Value = True
      End If
      
      FechaCierre = Mantencion.coleccion(I).swFechaCierre
      txtFecTermino.Text = Mantencion.coleccion(I).swFechaTermino
      txtFecInicio.Text = Mantencion.coleccion(I).swFechaInicio
    
      lPrimero = True
      For I = 1 To Hasta
         If Mantencion.coleccion(I).swTipoFlujo = 1 Then
            If lPrimero Then
               txtCapitalCompra.Text = Mantencion.coleccion(I).swCCapital
               txtCapitalCompra.Tag = Mantencion.coleccion(I).swCCapital
               txtSpreadCompra.Text = Mantencion.coleccion(I).swCSpread
               Call bacBuscarCombo(cmbMonedaCompra, Mantencion.coleccion(I).swCMoneda)
               Call BuscaCmbAmortiza(cmbAmortizaCapitalCompramos, Mantencion.coleccion(I).swCCodAmoCapital)
               Call BuscaCmbAmortiza(cmbAmortizaInteresCompramos, Mantencion.coleccion(I).swCCodAmoInteres)
               cmbAmortizaInteresCompramos.Tag = Mantencion.coleccion(I).swCCodAmoInteres
               Call bacBuscarCombo(cmbBaseCompra, Mantencion.coleccion(I).swCBase)
               Call bacBuscarCombo(cmbTasaCompra, Mantencion.coleccion(I).swCCodigoTasa)
               Call bacBuscarCombo(cmbMonedaRecibimos, Mantencion.coleccion(I).swRecMoneda)
               Call bacBuscarCombo(cmbDocumentoRecibimos, Mantencion.coleccion(I).swRecDocumento)
               txtTasaCompra.Text = Mantencion.coleccion(I).swCValorTasa
               lPrimero = False
            End If
            fgFlujosCompra.Rows = fgFlujosCompra.Rows + 1
            j = fgFlujosCompra.Rows - 1
                
            fgFlujosCompra.TextMatrix(j, 0) = (Mantencion.coleccion(I).swNumFlujo) & "  "
            fgFlujosCompra.TextMatrix(j, 1) = Format(Mantencion.coleccion(I).swFechaVenceFlujo, "dd/mm/yyyy")
            fgFlujosCompra.TextMatrix(j, 2) = Format(BacStrTran((Mantencion.coleccion(I).swCAmortiza), ".", gsc_PuntoDecim), FormatEspecial)
            fgFlujosCompra.TextMatrix(j, 3) = Format(BacStrTran((Mantencion.coleccion(I).swCValorTasa), ".", gsc_PuntoDecim), FormatEspecial)
            fgFlujosCompra.TextMatrix(j, 4) = Format(BacStrTran((Mantencion.coleccion(I).swCInteres), ".", gsc_PuntoDecim), FormatEspecial)
            total = Format(BacStrTran((Mantencion.coleccion(I).swCAmortiza), ".", gsc_PuntoDecim), FormatEspecial) + CDbl(BacStrTran((Mantencion.coleccion(I).swCInteres), ".", gsc_PuntoDecim))
            fgFlujosCompra.TextMatrix(j, 5) = Format(total, FormatEspecial)
            fgFlujosCompra.TextMatrix(j, 6) = IIf(Mantencion.coleccion(I).swModalidadPago = "C", "Compensación" & Space(50) & "C", "Ent. Fisica" & Space(50) & "F")
            fgFlujosCompra.TextMatrix(j, 8) = BacStrTran((Mantencion.coleccion(I).swCSaldo), ".", gsc_PuntoDecim)
            fgFlujosCompra.TextMatrix(j, 9) = Format(Mantencion.coleccion(I).swFechaInicioFlujo, "dd/mm/yyyy")
            fgFlujosCompra.TextMatrix(j, 10) = BacStrTran((Mantencion.coleccion(I).swRecMonto), ".", gsc_PuntoDecim)
            fgFlujosCompra.TextMatrix(j, 11) = BacStrTran((Mantencion.coleccion(I).swRecMontoUSD), ".", gsc_PuntoDecim)
            fgFlujosCompra.TextMatrix(j, 12) = BacStrTran((Mantencion.coleccion(I).swRecMontoCLP), ".", gsc_PuntoDecim)
            fgFlujosCompra.TextMatrix(j, 13) = "C"
         End If
      Next I

      lPrimero = True
      For I = 1 To Hasta
         If Mantencion.coleccion(I).swTipoFlujo = 2 Then
            If lPrimero Then
               txtCapitalVenta.Text = Mantencion.coleccion(I).swVCapital
               txtCapitalVenta.Tag = Mantencion.coleccion(I).swVCapital
               txtSpreadVenta.Text = Mantencion.coleccion(I).swVSpread
               Call bacBuscarCombo(cmbMonedaVenta, Mantencion.coleccion(I).swVMoneda)
               Call BuscaCmbAmortiza(cmbAmortizaCapitalVendemos, Mantencion.coleccion(I).swVCodAmoCapital)
               Call BuscaCmbAmortiza(cmbAmortizaInteresVendemos, Mantencion.coleccion(I).swVCodAmoInteres)
               cmbAmortizaInteresVendemos.Tag = Mantencion.coleccion(I).swVCodAmoInteres
               Call bacBuscarCombo(cmbBaseVenta, Mantencion.coleccion(I).swVBase)
               Call bacBuscarCombo(cmbTasaVenta, Mantencion.coleccion(I).swVCodigoTasa)
               Call bacBuscarCombo(cmbMonedaPagamos, Mantencion.coleccion(I).swPagMoneda)
               Call bacBuscarCombo(cmbDocumentoPagamos, Mantencion.coleccion(I).swPagDocumento)
               txtTasaVenta.Text = Mantencion.coleccion(I).swVValorTasa
               lPrimero = False
            End If
                
            fgFlujosVenta.Rows = fgFlujosVenta.Rows + 1
            j = fgFlujosVenta.Rows - 1
            
            fgFlujosVenta.TextMatrix(j, 0) = Mantencion.coleccion(I).swNumFlujo & "  "
            fgFlujosVenta.TextMatrix(j, 1) = Format(Mantencion.coleccion(I).swFechaVenceFlujo, "dd/mm/yyyy")
            fgFlujosVenta.TextMatrix(j, 2) = Format(Mantencion.coleccion(I).swVAmortiza, FormatEspecial)
            fgFlujosVenta.TextMatrix(j, 3) = Format(Mantencion.coleccion(I).swVValorTasa, FormatEsp1)
            fgFlujosVenta.TextMatrix(j, 4) = Format(Mantencion.coleccion(I).swVInteres, FormatEspecial)
            total = Format(Mantencion.coleccion(I).swVAmortiza, FormatEspecial) + CDbl(BacStrTran((.coleccion(I).swVInteres), ".", gsc_PuntoDecim))
            fgFlujosVenta.TextMatrix(j, 5) = Format(total, FormatEspecial)
            fgFlujosVenta.TextMatrix(j, 6) = IIf(Mantencion.coleccion(I).swModalidadPago = "C", "Compensación" & Space(50) & "C", "Ent. Fisica" & Space(50) & "F")
            fgFlujosVenta.TextMatrix(j, 8) = BacStrTran((Mantencion.coleccion(I).swVSaldo), ".", gsc_PuntoDecim)
            fgFlujosVenta.TextMatrix(j, 9) = Format(Mantencion.coleccion(I).swFechaInicioFlujo, "dd/mm/yyyy")
            fgFlujosVenta.TextMatrix(j, 10) = BacStrTran((Mantencion.coleccion(I).swPagMonto), ".", gsc_PuntoDecim)
            fgFlujosVenta.TextMatrix(j, 11) = BacStrTran((Mantencion.coleccion(I).swPagMontoUSD), ".", gsc_PuntoDecim)
            fgFlujosVenta.TextMatrix(j, 12) = BacStrTran((Mantencion.coleccion(I).swPagMontoCLP), ".", gsc_PuntoDecim)
            fgFlujosVenta.TextMatrix(j, 13) = "C"
         End If
      Next I
      Set Mantencion.coleccion = Nothing
            
      If CDbl(fgFlujosCompra.TextMatrix(1, 2)) > 0 Then
         txtFecPrimerVcto.Text = fgFlujosCompra.TextMatrix(1, 1)
      Else
         txtFecPrimerVcto.Text = fgFlujosCompra.TextMatrix(2, 1)
      End If
        
      nDiasCapital# = 0
      nDiasInteres# = 0
      cmbAmortizaCapitalCompramos_LostFocus
   End With
    
   lblFechaInicio = BacFechaStr(txtFecInicio.Text)
   lblFechaPrimerAmort = BacFechaStr(txtFecPrimerVcto.Text)
   lblFechaTermino = BacFechaStr(txtFecTermino.Text)
        
   Call CambiaColorCeldas(fgFlujosVenta)
   Call CambiaColorCeldas(fgFlujosCompra)
   Set Mantencion = Nothing

End Function

Sub IniciaVar()
    Call objMoneda.CargaBases(cmbBaseCompra)
    Call objMoneda.CargaBases(cmbBaseVenta)
       
    Call LlenaComboAmortiza(cmbAmortizaCapitalCompramos, 1043, Sistema)
    Call LlenaComboAmortiza(cmbAmortizaCapitalVendemos, 1043, Sistema)
    Call LlenaComboAmortiza(cmbAmortizaInteresCompramos, 1044, Sistema)
    Call LlenaComboAmortiza(cmbAmortizaInteresVendemos, 1044, Sistema)
    
    cmbMonedaRecibimos.Clear
    cmbMonedaPagamos.Clear
    Call objMoneda.CargaxProducto(OP_SWAP_MONEDAS, cmbMonedaCompra)
    Call objMoneda.CargaxProducto(OP_SWAP_MONEDAS, cmbMonedaVenta)
    
    cmbTasaCompra.Clear
    cmbTasaVenta.Clear
    
    cmbDocumentoPagamos.Clear
    cmbDocumentoRecibimos.Clear
    cmbEspecial.Clear
    
    cmbEspecial.AddItem "Normal ": cmbEspecial.ItemData(cmbEspecial.NewIndex) = 0
    cmbEspecial.AddItem "Capital": cmbEspecial.ItemData(cmbEspecial.NewIndex) = 1
    cmbEspecial.AddItem "Interes": cmbEspecial.ItemData(cmbEspecial.NewIndex) = 2
    cmbEspecial.ListIndex = 0
    
    Call LLenafgrdFlujos(fgFlujosCompra)
    Call LLenafgrdFlujos(fgFlujosVenta)
    
    tabFlujos.Tab = 0
    tabFlujos.TabEnabled(1) = False
    tabFlujos.TabEnabled(2) = False
    
    cmbModalidad.AddItem "Compensación" & Space(50) & "C"
    cmbModalidad.AddItem "Ent. Física " & Space(50) & "E"
    cmbModalidadVen.AddItem "Compensación" & Space(50) & "C"
    cmbModalidadVen.AddItem "Ent. Física " & Space(50) & "E"
    
    cMonedaCom$ = ""
    cMonedaVen$ = ""
    nEquivUSD$ = ""
    cTipoOperacion$ = H_COMPRA
    cModalidad = "C"
    cOperSwap = IIf(Mid$(cOperSwap, 1, 1) = "M", cOperSwap, "Ingreso")
    
    txtCapitalCompra.Text = 0
    txtCapitalVenta.Text = 0
    txtTasaCompra.Text = 0
    txtTasaVenta.Text = 0
    txtSpreadCompra.Text = 0
    txtSpreadVenta.Text = 0

    txtFecInicio.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
    txtFecPrimerVcto.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
    txtFecTermino.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
    lblFechaInicio = BacFechaStr(txtFecInicio.Text)
    lblFechaPrimerAmort = BacFechaStr(txtFecPrimerVcto.Text)
    lblFechaTermino = BacFechaStr(txtFecTermino.Text)
    
    lblMonedas.Caption = ""
    txtValorMonedaCompra.Text = 0#
    txtValorMonedaCompra.Tag = 0#
    
    txtValorMonedaVenta.Text = 0#
    txtValorMonedaVenta.Tag = 0#
    
    txtCapitalVenta.Tag = 0
    txtCapitalCompra.Tag = 0
    cmbAmortizaInteresCompramos.Tag = 0
    cmbAmortizaInteresVendemos.Tag = 0
    lEntrada = True
    nPaisOrigen = 0
    etqNumOper.Visible = False
    
    Call bacBuscarCombo(cmbMonedaCompra, 13)
    Call bacBuscarCombo(cmbMonedaVenta, 998)
   
   '------------------------------------------------------------- GLCF
  
   txtFechaRecib.Visible = False
   txtAmortiza.Visible = False
   cmbModalidad.Visible = False
   txtAmortiza.Text = 0
   
   txtAmortizaVen.Visible = False
   cmbModalidadVen.Visible = False
   txtFechaPag.Visible = False
   txtAmortizaVen.Text = 0

   If cOperSwap = "Ingreso" Then
      etqNumOper.Visible = False
      Toolbar1.Buttons(2).Enabled = False
      ValorDolarObs = gsBAC_DolarObs
      
      Call BuscaCmbAmortiza(cmbAmortizaCapitalCompramos, 6)
      Call BuscaCmbAmortiza(cmbAmortizaInteresCompramos, 3)
      Call BuscaCmbAmortiza(cmbAmortizaCapitalVendemos, 6)
      Call BuscaCmbAmortiza(cmbAmortizaInteresVendemos, 3)
      
      cmbMonedaVenta.Tag = 998
      Call bacBuscarCombo(cmbMonedaVenta, Val(cmbMonedaVenta.Tag))
      Call CargaMonedaDocPagoLocal(999, cmbMonedaPagamos, moneda)
      
      cmbMonedaCompra.Tag = 13
      Call bacBuscarCombo(cmbMonedaCompra, Val(cmbMonedaCompra.Tag))
      Call CargaMonedaDocPagoLocal(13, cmbMonedaRecibimos, moneda)
      
      Call CargaMonedaDocPagoLocal(cmbMonedaVenta.ItemData(cmbMonedaVenta.ListIndex), cmbMonedaPagamos, moneda)
      If cmbMonedaCompra.ListIndex > -1 Then
         Call CargaMonedaDocPagoLocal(cmbMonedaCompra.ItemData(cmbMonedaCompra.ListIndex), cmbMonedaRecibimos, moneda)
      End If
      Call cmbMonedaCompra_Click
   End If

   
   
End Sub

Private Function ValidaFlujosconMontos() As Boolean
   Dim iTipoFlujo As Integer
   Dim iContador  As Integer
   Dim iMonto     As Double
   
   ValidaFlujosconMontos = False
   
   For iTipoFlujo = 1 To 2
      If iTipoFlujo = 1 Then
         iMonto = 0#
         For iContador = 1 To fgFlujosCompra.Rows - 1
            iMonto = iMonto + fgFlujosCompra.TextMatrix(iContador, 2)
         Next iContador
         If iMonto > CDbl(txtCapitalCompra.Text) Then
            MsgBox "Capital en " & cmbMonedaCompra.Text & " es inferior a la sumatoria de los flujos ", vbExclamation, TITSISTEMA
            Exit Function
         End If
         If iMonto < CDbl(txtCapitalCompra.Text) Then
            MsgBox "Capital en " & cmbMonedaCompra.Text & " es superior a la sumatoria de los flujos ", vbExclamation, TITSISTEMA
            Exit Function
         End If
      End If
      If iTipoFlujo = 2 Then
         iMonto = 0#
         For iContador = 1 To fgFlujosVenta.Rows - 1
            iMonto = iMonto + fgFlujosVenta.TextMatrix(iContador, 2)
         Next iContador
         If iMonto > CDbl(txtCapitalVenta.Text) Then
            MsgBox "Capital en " & cmbMonedaVenta.Text & " es inferior a la sumatoria de los flujos ", vbExclamation, TITSISTEMA
            Exit Function
         End If
         If iMonto < CDbl(txtCapitalVenta.Text) Then
            MsgBox "Capital en " & cmbMonedaVenta.Text & " es superior a la sumatoria de los flujos ", vbExclamation, TITSISTEMA
            Exit Function
         End If
      End If
   Next iTipoFlujo
   
   ValidaFlujosconMontos = True
End Function

Function ValidaDatos()
   Dim nVecesCap As Integer
   Dim nVecesInt As Integer
   Dim nRes      As Integer
  
   ValidaDatos = False
  
   Call HabilitaPanles(False)

   If Not ChequeaCierreMesa() Then
      MsgBox "No se puede Grabar Operacion, Mesa de Dinero está Cerrada!!!", vbExclamation, Msj
      Exit Function
   End If
   If cmbMonedaCompra.ListIndex = -1 Or cmbMonedaVenta.ListIndex = -1 Then
      MsgBox "No ha indicado las Monedas a Transar", vbInformation, Msj
      If cmbMonedaCompra.Enabled = True Then
         cmbMonedaCompra.SetFocus
      Else
         cmbMonedaVenta.SetFocus
      End If
      Exit Function
   End If
   If Trim(txtCapitalCompra.Text) = 0 Or Trim(txtCapitalCompra.Text) = 0 Then
      MsgBox "No a ingresado los Montos de Capital", vbInformation, Msj
      txtCapitalCompra.SetFocus
      Exit Function
   End If
   If cmbTasaCompra.ListIndex = -1 Then
      MsgBox "No ha definido el Tipo de Tasa", vbInformation, Msj
      cmbTasaCompra.SetFocus
      Exit Function
   End If
   If cmbTasaVenta.ListIndex = -1 Then
      MsgBox "No ha definido el Tipo de Tasa", vbInformation, Msj
      cmbTasaVenta.SetFocus
      Exit Function
   End If
   If Trim(txtTasaCompra.Text) = 0 Or Trim(txtTasaCompra.Text) = 0 Then
      MsgBox "Debe Ingresar valor de Tasas para realizar Cálculo", vbInformation, Msj
      txtTasaCompra.SetFocus
      Exit Function
   End If
   If cmbBaseCompra.ListIndex = -1 Then
      MsgBox "No ha definido la Base de Cálculo", vbInformation, Msj
      cmbBaseCompra.SetFocus
      Exit Function
   End If
   If cmbBaseVenta.ListIndex = -1 Then
      MsgBox "No ha definido la Base de Cálculo", vbInformation, Msj
      cmbBaseVenta.SetFocus
      Exit Function
   End If
   If cmbAmortizaInteresCompramos.ListIndex = -1 Then
      MsgBox "No a definido los períodos de Amortización Compra", vbInformation, Msj
      cmbAmortizaInteresCompramos.SetFocus
      Exit Function
   End If
   If cmbAmortizaInteresVendemos.ListIndex = -1 Then
      MsgBox "No a definido los períodos de Amortización Venta", vbInformation, Msj
      cmbAmortizaInteresVendemos.SetFocus
      Exit Function
   End If
   If cmbAmortizaCapitalCompramos.ListIndex = -1 Then
      MsgBox "No a definido los periodos de Amortización Compras", vbInformation, Msj
      cmbAmortizaCapitalCompramos.SetFocus
      Exit Function
   End If
   If cmbAmortizaCapitalVendemos.ListIndex = -1 Then
      MsgBox "No a definido los periodos de Amortización Ventas", vbInformation, Msj
      cmbAmortizaCapitalVendemos.SetFocus
      Exit Function
   End If
   If Not BacEsHabil(CStr(txtFecInicio.Text)) Then
      MsgBox "Fecha de Inicio no es día hábil", vbCritical, Msj
      txtFecInicio.SetFocus
      Me.MousePointer = 0
      Exit Function
   End If
   
   If Not BacEsHabil(CStr(txtFecPrimerVcto.Text)) Then
      MsgBox "Fecha Primer Vencimiento de Capital no es día Hábil", vbCritical, Msj
      txtFecPrimerVcto.SetFocus
      Me.MousePointer = 0
      Exit Function
   End If

   If Not BacEsHabil(CStr(txtFecTermino.Text)) Then
      MsgBox "Fecha de Término no es día hábil", vbCritical, Msj
      txtFecTermino.SetFocus
      Me.MousePointer = 0
      Exit Function
   End If
   If CDate(txtFecInicio.Text) = CDate(txtFecTermino.Text) Then
      MsgBox "Fecha Inicio no  puede ser igual a Fecha de Término", vbInformation, Msj
      txtFecTermino.SetFocus
      Exit Function
   End If
   If CDate(txtFecPrimerVcto.Text) > CDate(txtFecTermino.Text) Then
      MsgBox "Fecha Primer Vencimiento NO puede ser posterior a la de Término", vbInformation, Msj
      txtFecTermino.SetFocus
      Exit Function
   End If
   
   Dim elMayor
   Dim difMeses   As Integer
   Dim fecInicio  As Date
    
   fecInicio = txtFecInicio.Text
   difMeses = DateDiff("d", fecInicio, txtFecPrimerVcto.Text)
   
   If difMeses > 28 Then
      difMeses = DateDiff("m", fecInicio, txtFecPrimerVcto.Text)
   Else
      difMeses = 0
   End If
    
   If IIf(difMeses <> nDiasCapital, difMeses = nDiasInteres, False) Then
      fecInicio = txtFecPrimerVcto.Text
   End If
    
   elMayor = IIf(nDiasCapital# > nDiasInteres#, nDiasCapital#, nDiasInteres#)
   difMeses = DateDiff("m", fecInicio, txtFecTermino.Text)
   nRes = DateDiff("m", txtFecInicio.Text, txtFecPrimerVcto.Text)
 
   Call HabilitaPanles(True)
        
   Toolbar1.Buttons(1).Enabled = True
   ValidaDatos = Toolbar1.Buttons(1).Enabled
End Function

Private Sub cmbAmortizaCapitalCompramos_Click()
   Call cmbAmortizaCapitalCompramos_LostFocus
End Sub

Private Sub cmbAmortizaCapitalCompramos_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      SendKeys ("{Tab}")
   End If
End Sub

Private Sub cmbAmortizaCapitalCompramos_LostFocus()
   If cmbAmortizaCapitalCompramos.ListIndex = -1 Then
      Exit Sub
   End If
   DesgloseAmort = SacaTipoPeriodo(cmbBaseCompra)
   nDiasCapital# = ValorAmort(cmbAmortizaCapitalCompramos, DesgloseAmort)
End Sub

Private Sub cmbAmortizaCapitalVendemos_Click()
   cmbAmortizaCapitalVendemos_LostFocus
End Sub

Private Sub cmbAmortizaCapitalVendemos_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      SendKeys ("{Tab}")
   End If
End Sub

Private Sub cmbAmortizaCapitalVendemos_LostFocus()
   If cmbAmortizaCapitalVendemos.ListIndex = -1 Then
      Exit Sub
   End If
   DesgloseAmort = SacaTipoPeriodo(cmbBaseVenta)
   nDiasCapital# = ValorAmort(cmbAmortizaCapitalVendemos, DesgloseAmort)
End Sub
Private Sub cmbAmortizaInteresCompramos_Click()
   Call cmbAmortizaInteresCompramos_LostFocus
End Sub
Private Sub cmbAmortizaInteresCompramos_GotFocus()
   cmbAmortizaInteresCompramos.Tag = SacaCodigo(cmbAmortizaInteresCompramos)
End Sub
Private Sub cmbAmortizaInteresCompramos_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      txtFecInicio.SetFocus
   End If
End Sub
Private Sub cmbAmortizaInteresCompramos_LostFocus()
   If cmbAmortizaInteresCompramos.ListIndex = -1 Then
      Exit Sub
   End If
   nDiasInteres# = ValorAmort(cmbAmortizaInteresCompramos, DesgloseAmort)
   If CDbl(cmbAmortizaInteresCompramos.Tag) = SacaCodigo(cmbAmortizaInteresCompramos) Then
   End If
   
   If cmbMonedaCompra.ListIndex > -1 Then
      Call CargaTasaMoneda(cmbTasaCompra, cmbMonedaCompra.ItemData(cmbMonedaCompra.ListIndex), 0, Val(Right(cmbAmortizaInteresCompramos.Text, 5)))
   End If
   cmbAmortizaInteresCompramos.Tag = SacaCodigo(cmbAmortizaInteresCompramos)
End Sub
Private Sub cmbAmortizaInteresVendemos_Click()
   cmbAmortizaInteresVendemos_LostFocus
End Sub
Private Sub cmbAmortizaInteresVendemos_GotFocus()
    cmbAmortizaInteresVendemos.Tag = SacaCodigo(cmbAmortizaInteresVendemos)
End Sub
Private Sub cmbAmortizaInteresVendemos_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      txtFecInicio.SetFocus
   End If
End Sub

Private Sub cmbAmortizaInteresVendemos_LostFocus()
   If cmbAmortizaInteresCompramos.ListIndex = -1 Then
      Exit Sub
   End If
   nDiasInteres# = ValorAmort(cmbAmortizaInteresVendemos, DesgloseAmort)
   If CDbl(cmbAmortizaInteresVendemos.Tag) = SacaCodigo(cmbAmortizaInteresVendemos) Then
   End If
   If cmbMonedaVenta.ListIndex > -1 Then
      Call CargaTasaMoneda(cmbTasaVenta, cmbMonedaVenta.ItemData(cmbMonedaVenta.ListIndex), 0, Val(Right(cmbAmortizaInteresVendemos, 10)))
   End If
   cmbAmortizaInteresVendemos.Tag = SacaCodigo(cmbAmortizaInteresVendemos)
End Sub

Private Sub cmbBaseCompra_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      SendKeys ("{Tab}")
   End If
End Sub

Private Sub cmbBaseVenta_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      SendKeys ("{Tab}")
   End If
End Sub

Private Sub cmbDocumentoPagamos_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      cmbAmortizaCapitalCompramos.SetFocus
   End If
End Sub

Private Sub cmbDocumentoRecibimos_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      SendKeys ("{Tab}")
   End If
End Sub

Private Sub cmbEspecial_Click()
   If cmbEspecial.ListIndex < 0 Then
      cmbEspecial.ListIndex = 0
   End If
   If Not txtFecPrimerVcto.Visible Then
      txtFecPrimerVcto.Text = txtFecInicio.Text
   End If
   txtFecPrimerVcto.Enabled = (cmbEspecial.ItemData(cmbEspecial.ListIndex) > 0)
   txtFecPrimerVcto.Visible = txtFecPrimerVcto.Enabled
   lblFechaPrimerAmort.Visible = txtFecPrimerVcto.Enabled
End Sub

Private Sub cmbEspecial_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      If txtFecPrimerVcto.Visible Then
         txtFecPrimerVcto.SetFocus
      Else
         If optCompensa.Value Then
            optCompensa.SetFocus
         Else
            optEntFisica.SetFocus
         End If
      End If
   End If
End Sub

Private Sub cmbModalidad_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyEscape Then
      cmbModalidad.Visible = False
      fgFlujosCompra.Enabled = True
      fgFlujosCompra.SetFocus
      Exit Sub
   End If
   If KeyAscii = vbKeyReturn Then
      If fgFlujosCompra.Col = 10 Then
         fgFlujosCompra.TextMatrix(fgFlujosCompra.Row, 10) = cmbModalidad
         fgFlujosVenta.TextMatrix(fgFlujosCompra.Row, 10) = cmbModalidad
      End If
      fgFlujosCompra.Enabled = True
      cmbModalidad.Visible = False
      fgFlujosCompra.SetFocus
   End If
End Sub

Private Sub cmbModalidadVen_KeyPress(KeyAscii As Integer)
    
   If KeyAscii = vbKeyEscape Then
      cmbModalidadVen.Visible = False
      fgFlujosVenta.SetFocus
      Exit Sub
   End If
   If KeyAscii = vbKeyReturn Then
      If fgFlujosVenta.Col = 10 Then
         fgFlujosVenta.TextMatrix(fgFlujosVenta.Row, 10) = cmbModalidadVen
         fgFlujosCompra.TextMatrix(fgFlujosVenta.Row, 10) = cmbModalidadVen
      End If
      cmbModalidadVen.Visible = False
      fgFlujosVenta.SetFocus
   End If
End Sub

Private Sub cmbMonedaCompra_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      SendKeys ("{Tab}")
   End If
End Sub

Private Sub cmbMonedaPagamos_Click()
   Call CargaMonedaDocPagoLocal(cmbMonedaPagamos.ItemData(cmbMonedaPagamos.ListIndex), cmbDocumentoPagamos, Documento)
End Sub

Private Sub cmbMonedaPagamos_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      SendKeys ("{Tab}")
   End If
End Sub

Private Sub cmbMonedaRecibimos_Click()
   Call CargaMonedaDocPagoLocal(cmbMonedaRecibimos.ItemData(cmbMonedaRecibimos.ListIndex), cmbDocumentoRecibimos, Documento)
End Sub

Private Sub cmbMonedaRecibimos_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      SendKeys ("{Tab}")
   End If
End Sub


Private Sub cmbMonedaVenta_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      SendKeys ("{Tab}")
   End If
End Sub

Private Sub CmbOperador_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      SendKeys ("{Tab}")
   End If
End Sub

Private Sub cmbTasaCompra_Click()
   If cmbTasaCompra.ListIndex > -1 Then
      txtTasaCompra.Tag = ValorTasas(cmbMonedaCompra.ItemData(cmbMonedaCompra.ListIndex), Format(gsBAC_Fecp, "yyyymmdd"), Val(Trim(Right(cmbAmortizaInteresCompramos, 10))), cmbTasaCompra.ItemData(cmbTasaCompra.ListIndex))    ' T rim(Right(cmbTasaVenta, 15))
      txtTasaCompra.Text = txtTasaCompra.Tag
   End If
End Sub

Private Sub cmbTasaCompra_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      SendKeys ("{Tab}")
   End If
End Sub

Private Sub cmbTasaVenta_Click()
   If cmbTasaVenta.ListIndex > -1 Then
      txtTasaVenta.Tag = ValorTasas(cmbMonedaVenta.ItemData(cmbMonedaVenta.ListIndex), Format(gsBAC_Fecp, "yyyymmdd"), Val(Trim(Right(cmbAmortizaInteresCompramos, 10))), cmbTasaVenta.ItemData(cmbTasaVenta.ListIndex))    ' T rim(Right(cmbTasaVenta, 15))
      txtTasaVenta.Text = txtTasaVenta.Tag
   End If
End Sub

Private Sub cmbTasaVenta_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      SendKeys ("{Tab}")
   End If
End Sub

Private Sub cmdCalcula_Click()
   If Not ValidaDatos() Then
      Toolbar1.Buttons(2).Enabled = False
      Exit Sub
   End If
   CalculoInteresModificado ("V")
   CalculoInteresModificado ("C")
   Toolbar1.Buttons(2).Enabled = True
End Sub

Sub HabilitaPanles(ByVal xValor)
   tabFlujos.TabEnabled(1) = xValor
   tabFlujos.TabEnabled(2) = xValor
End Sub

Private Sub cmdGrabar_Click()
   Dim m
   
   If ValidaDatos() Then
      
      If cmbMonedaRecibimos.ListIndex = -1 Then          '---------control de Formas de Pago
         MsgBox "Debe Ingresar Moneda de Pago", vbCritical, Msj
         cmbMonedaRecibimos.SetFocus
         Exit Sub
      End If
      If cmbDocumentoRecibimos.ListIndex = -1 Then
         MsgBox "Debe Ingresar Documento de Pago", vbCritical, Msj
         cmbDocumentoRecibimos.SetFocus
         Exit Sub
      End If
      If cmbMonedaPagamos.ListIndex = -1 Then
         MsgBox "Debe Ingresar Moneda de Pago", vbCritical, Msj
         cmbMonedaPagamos.SetFocus
         Exit Sub
      End If
      If cmbDocumentoPagamos.ListIndex = -1 Then
         MsgBox "Debe Ingresar Documento de Pago", vbCritical, Msj
         cmbDocumentoPagamos.SetFocus
         Exit Sub
      End If
      

      If fgFlujosCompra.Rows = 1 Or fgFlujosVenta.Rows = 1 Then
         MsgBox "Debe realizar Cálculo de Flujos", vbCritical, Msj
         Exit Sub
      End If
            
      BacGrabar.MiTipoSwap = OP_SWAP_MONEDAS
      BacGrabar.Show vbModal
            
      If GLB_bCancelar = False And cOperSwap = "Ingreso" Then
         Call IniciaVar
      ElseIf GLB_bCancelar = True Then
          Exit Sub
      Else
            Unload Me
      End If
   End If
End Sub

Private Sub cmdLimpia_Click()
    Me.MousePointer = 11
    Call IniciaVar
    Me.MousePointer = 0
End Sub

Private Sub cmdSalir_Click()
    Unload Me
End Sub
Private Sub fgFlujosCompra_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Or KeyAscii >= 48 And KeyAscii <= 57 Then
      With fgFlujosCompra
    
         If .TextMatrix(.Row, 13) = "CH" Then
            Exit Sub ' Si es modificacion de cartera los flujos de cartera
         End If
         txtFechaRecib.Visible = False
         txtAmortiza.Visible = False
         cmbModalidad.Visible = False
         txtAmortiza.Text = 0#
         If .Row = 0 Then
            Exit Sub
         End If
        
         'If cTipoOperacion$ <> "C" Then '--> Hoy 26/05/2006
         '   Exit Sub
         'End If
        
         Select Case .Col
            Case 1
               txtFechaRecib.Left = .CellLeft + .Left ' 300
               txtFechaRecib.Top = .CellTop + .Top ' 410
               txtFechaRecib.Text = .TextMatrix(.Row, 1)
               txtFechaRecib.Width = .CellWidth
               txtFechaRecib.Tag = .Row
              '.Enabled = False --> Hoy 26/05/2006
               txtFechaRecib.Visible = True
               txtFechaRecib.SetFocus
            Case 2
               If nDiasCapital# = -1 Then
                  txtAmortiza.Width = .CellWidth
                  txtAmortiza.Left = .CellLeft + .Left ' 300
                  txtAmortiza.Top = .CellTop + .Top '410
                  txtAmortiza.Text = .TextMatrix(.Row, 2)
                  txtAmortiza.Tag = .Row
                  txtAmortiza.Visible = True
                  
                  If cmbMonedaCompra.ItemData(cmbMonedaCompra.ListIndex) = 999 Then
                     txtAmortiza.CantidadDecimales = 0
                  Else
                     txtAmortiza.CantidadDecimales = 4
                  End If
                  
                  txtAmortiza.Text = Chr(KeyAscii)
                  txtAmortiza.SelStart = Len(txtAmortiza.Text) - (txtAmortiza.CantidadDecimales + 1)
                  txtAmortiza.SetFocus
               End If
            Case 6
               cmbModalidad.Width = .CellWidth
               cmbModalidad.Left = .CellLeft + .Left  '300
               cmbModalidad.Top = .CellTop + .Top  '410
               cmbModalidad.ListIndex = IIf(Right(.TextMatrix(.Row, 6), 1) = "C", 0, 1)
               cmbModalidad.Tag = .Row
              '.Enabled = False --> Hoy 26/05/2006
               cmbModalidad.Visible = True
               cmbModalidad.SetFocus
         End Select
      End With
   End If
End Sub

Private Sub fgFlujosCompra_LostFocus()
   Dim I             As Integer
   Dim SumAmortCom   As Double
   Dim SumAmortVen   As Double
   Dim nTasa         As Double
   Dim Res

   SumAmortCom = 0
   If nDiasCapital# = -1 And cTipoOperacion$ = "C" Then
      'Amortizacion de capital BONOS
      For I = 1 To fgFlujosCompra.Rows - 1
         SumAmortCom = SumAmortCom + CDbl(fgFlujosCompra.TextMatrix(I, 2))
      Next I
      If SumAmortCom <> CDbl(txtCapitalCompra.Text) Then
         nTasa = Val(txtTasaCompra.Text) + Val(txtSpreadCompra.Text)
         Call CalculoInteresBonos("C")
         nTasa = Val(txtTasaVenta.Text) + Val(txtSpreadVenta.Text)
         Call CalculoInteresBonos("V")
      End If
   
   End If
End Sub

Private Sub fgFlujosCompra_Scroll()
   cmbModalidad.Visible = False
   txtAmortiza.Visible = False
End Sub

Private Sub fgFlujosVenta_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Or KeyAscii >= vbKey0 And KeyAscii <= vbKey9 Then
      With fgFlujosVenta
         If .TextMatrix(.Row, 13) = "CH" Then
            Exit Sub ' Si es modificacion de cartera los flujos de cartera
         End If
         txtAmortizaVen.Visible = False
         cmbModalidadVen.Visible = False
         txtFechaPag.Visible = False
         txtAmortizaVen.Text = 0
         
         If .Row = 0 Then
            Exit Sub
         End If
        
        ' If cTipoOperacion$ <> "V" Then '--> Hoy 26/05/2006
        '    Exit Sub
        ' End If
        
         Select Case .Col
            Case 1
               txtFechaPag.Left = .CellLeft + .Left '300
               txtFechaPag.Top = .CellTop + .Top ' 410
               txtFechaPag.Text = .TextMatrix(.Row, 1)
               txtFechaPag.Width = .CellWidth
               txtFechaPag.Tag = .Row
               txtFechaPag.Visible = True
               txtFechaPag.SetFocus
            Case 2
               If nDiasCapital# = -1 Then
                  'cambio en monto amortizacion
                  txtAmortizaVen.Width = .CellWidth
                  txtAmortizaVen.Left = .CellLeft + .Left '+ 300
                  txtAmortizaVen.Top = .CellTop + .Top '+ 410
                  txtAmortizaVen.Text = .TextMatrix(.Row, 2)
                  txtAmortizaVen.Tag = .Row
                  If cmbMonedaVenta.ItemData(cmbMonedaVenta.ListIndex) = 999 Then
                     txtAmortizaVen.CantidadDecimales = 0
                  Else
                     txtAmortizaVen.CantidadDecimales = 4
                  End If
                  txtAmortizaVen.Text = Chr(KeyAscii)
                  txtAmortizaVen.SelStart = Len(txtAmortizaVen.Text) - (txtAmortizaVen.CantidadDecimales + 1)
                  txtAmortizaVen.Visible = True
                  txtAmortizaVen.SetFocus
               End If
            Case 6
               cmbModalidadVen.Width = .CellWidth
               cmbModalidadVen.Left = .CellLeft + .Left '+ 300
               cmbModalidadVen.Top = .CellTop + .Top '+ 410
               cmbModalidadVen.ListIndex = IIf(Right(.TextMatrix(.Row, 6), 1) = "C", 0, 1)
               cmbModalidadVen.Tag = .Row
               cmbModalidadVen.Visible = True
               cmbModalidadVen.SetFocus
         End Select
      End With
   End If
End Sub

Private Sub fgFlujosVenta_LostFocus()
   Dim I             As Integer
   Dim SumAmortCom   As Double
   Dim SumAmortVen   As Double
   Dim nTasa         As Double
   Dim Res
   
   SumAmortCom = 0
   If nDiasCapital# = -1 And cTipoOperacion$ = "V" Then
     'Amortizacion de capital BONOS
      For I = 1 To fgFlujosCompra.Rows - 1
         SumAmortCom = SumAmortCom + CDbl(fgFlujosCompra.TextMatrix(I, 2))
      Next I
      
      If SumAmortCom <> CDbl(txtCapitalCompra.Text) Then
         nTasa = Val(txtTasaCompra.Text) + Val(txtSpreadCompra.Text)
         Call CalculoInteresBonos("C")
         nTasa = Val(txtTasaVenta.Text) + Val(txtSpreadVenta.Text)
         Call CalculoInteresBonos("V")
      End If
   End If
   
End Sub

Private Sub Form_Activate()
   Tipo_Producto = "SM"
   Set oFormulario = Me
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   Me.Top = 60: Me.Left = 100

   cOperSwap = swOperSwap
   nNumoper = swModNumOpe
   Lbl_Num_Oper_Oculto.Caption = nNumoper
   swOperSwap = ""
   Tipo_Producto = "SM"
   '--------------- Identificadores

   tabFlujos.Tab = 0
   fgFlujosCompra.Tag = H_COMPRA
   fgFlujosVenta.Tag = H_VENTA
   
   'EtqMensaje.Caption = ""
   '------------ Inicializa Objetos y Variables
   Call MonYDocxMoneda(DatosPorMoneda(), TotDatPorMon)
   
   Call IniciaVar
  
        'Modificaciones
    If cOperSwap <> "Ingreso" Then
        etqNumOper.Visible = True
        
        Call CargaMonedaDocPagoLocal(cmbMonedaVenta.ItemData(cmbMonedaVenta.ListIndex), cmbMonedaPagamos, moneda)
        Call CargaMonedaDocPagoLocal(cmbMonedaCompra.ItemData(cmbMonedaCompra.ListIndex), cmbMonedaRecibimos, moneda)
        
        Call BuscarDatos
        
        tabFlujos.TabEnabled(1) = True
        tabFlujos.TabEnabled(2) = True
        
        If objMoneda.ValorMoneda(994, CStr(FechaCierre)) Then
           ValorDolarObs = objMoneda.vmValor    'valor dolar obs. para convertir monto
        End If
        
        If Not ChequeaCierreMesa() Then
           Toolbar1.Buttons(1).Enabled = False
           Toolbar1.Buttons(2).Enabled = False
           Toolbar1.Buttons(3).Enabled = False
           MsgBox "Operacion no puede ser Modificada. Mesa ha cerrado!! "
        End If
    End If

End Sub


Function CalculoInteresModificado(Opcion As String)
   Dim FechaAmortiza             As Date
   Dim FechaAmortizaCap          As Date
   Dim FechaAmortizaInt          As Date
   Dim FechaFin                  As Date
   Dim FechaVencAnt              As Date
   Dim FTermino                  As Date
   Dim FInicio                   As Date
   Dim FPrimerVcto               As Date
   Dim DiasAmortCap              As Integer
   Dim DiasAmortInt              As Integer
   Dim DiaAmort                  As Integer
   Dim FactorDiv                 As Integer
   Dim cuenta                    As Integer
   Dim MontoCapital              As Double
   Dim RestoCapital              As Double
   Dim MontoGrd                  As Double
   Dim MontoAmortCap             As Double
   Dim FechaProceso              As String
   Dim DivCap                    As Integer
   Dim Cuadratura                As Double
   Dim PlazoMin                  As Long
   Dim Grilla                    As Object
   Dim Base                      As Integer
   Dim Tasa                      As Double
   Dim CodigoMoneda              As Integer
   Dim CodigoAmortizaEsp         As Integer
   Dim strBase                   As String
   Dim PlazoDias                 As Integer
   Dim nRedondeo                 As Integer
    
   If Opcion = "C" Then
      Set Grilla = fgFlujosCompra
      MontoCapital = CDbl(txtCapitalCompra.Text)                             'Monto Capital
      strBase = cmbBaseCompra
      Tasa = CDbl(txtTasaCompra.Text) + CDbl(txtSpreadCompra.Text)
      DesgloseAmort = "M"
      CodigoMoneda = SacaCodigo(cmbMonedaCompra)
      DiasAmortCap = ValorAmort(cmbAmortizaCapitalCompramos, DesgloseAmort) 'Total de dias o meses real para Amortizacion Capital
      DiasAmortInt = ValorAmort(cmbAmortizaInteresCompramos, DesgloseAmort) 'Total de dias o meses para Amortizacion del Interes
      PlazoDias = ValorAmort(cmbAmortizaInteresCompramos, DesgloseAmort)    'Total de dias o meses para Amortizacion del Interes
      FInicio = CDate(txtFecInicio.Text)
      FTermino = CDate(txtFecTermino.Text)
      FPrimerVcto = CDate(txtFecPrimerVcto.Text)
      CodigoAmortizaEsp = cmbEspecial.ItemData(cmbEspecial.ListIndex)
   Else
      Set Grilla = fgFlujosVenta
      MontoCapital = CDbl(txtCapitalVenta.Text)                             'Monto Capital
      strBase = cmbBaseVenta
      Tasa = (txtTasaVenta.Text) + CDbl(txtSpreadVenta.Text)
      DesgloseAmort = "M"
      CodigoMoneda = SacaCodigo(cmbMonedaVenta)
      DiasAmortCap = ValorAmort(cmbAmortizaCapitalVendemos, DesgloseAmort) 'Total de dias o meses real para Amortizacion Capital
      DiasAmortInt = ValorAmort(cmbAmortizaInteresVendemos, DesgloseAmort)     'Total de dias o meses para Amortizacion del Interes
      PlazoDias = ValorAmort(cmbAmortizaInteresVendemos, DesgloseAmort)
      FInicio = CDate(txtFecInicio.Text)
      FTermino = CDate(txtFecTermino.Text)
      FPrimerVcto = CDate(txtFecPrimerVcto.Text)
      CodigoAmortizaEsp = cmbEspecial.ItemData(cmbEspecial.ListIndex)
   End If
    
   Grilla.Rows = 1
   cuenta = 1
   FactorDiv = 1
   FechaProceso = IIf(OperSwap = "Ingreso", gsBAC_Fecp, FechaCierre)
    
   If DiasAmortCap > DiasAmortInt Then
      PlazoMin = DiasAmortInt
   Else
      PlazoMin = IIf(DiasAmortCap > 0, DiasAmortCap, DiasAmortInt)
   End If
        
   '---- Define fechas para generar Flujos
   FechaFin = CDate(FTermino)
   FechaVencAnt = CDate(FInicio)
   
   Select Case cmbEspecial.ItemData(cmbEspecial.ListIndex)
      Case 0      'NORMAL
        'Para los casos que el período es BULLET ó BONO Amortizacion de monto en fecha final
         DiaAmort = Day(FInicio)
         FechaAmortizaCap = IIf(DiasAmortCap > 0, CreaFechaProx(FInicio, DiasAmortCap, DiaAmort, DesgloseAmort), CDate(FTermino))
         FechaAmortizaInt = CreaFechaProx(FInicio, DiasAmortInt, Day(FInicio), DesgloseAmort)
         FechaAmortiza = FechaAmortizaInt ' FechaIniAmort
         
         If FechaAmortiza > FechaFin Then
            FechaAmortiza = FechaFin
         End If
         
      Case 1      'CAPITAL
         FechaAmortizaCap = CDate(FPrimerVcto)
         FechaAmortizaInt = CDate(FPrimerVcto)
         FechaAmortiza = CDate(FPrimerVcto)
         DiaAmort = Day(FPrimerVcto)
      Case 2      'INTERES
         DiaAmort = Day(FPrimerVcto)
         FechaAmortizaCap = IIf(DiasAmortCap > 0, CreaFechaProx(FPrimerVcto, DiasAmortCap, DiaAmort, DesgloseAmort), CDate(FTermino))
         FechaAmortizaInt = CDate(FPrimerVcto)
         FechaAmortiza = CDate(FPrimerVcto)
   End Select
    
   If DiasAmortCap > 0 Then
      DivCap = DiasAmortCap
      FactorDiv = BacDiv(DateDiff("m", FechaAmortizaCap, CDate(FechaFin)), CDbl(DivCap))
      'Sera cero cuando las fechas son iguales
      FactorDiv = FactorDiv + 1
   End If
   If FactorDiv = 0 Then
      MsgBox "Fechas Ingresadas no concuerdan com períodos de Amortización seleccionados", vbCritical, Msj
      txtFecTermino.SetFocus
      Exit Function
   End If
   If CodigoMoneda = 999 Then
      nRedondeo = 0
   Else
      nRedondeo = 4
   End If
   
   MontoAmortCap = Round((CDbl(MontoCapital) / FactorDiv), nRedondeo)
   'Para que la sumatoria de montos amortizados cuadre con Capital
   Cuadratura = MontoCapital - (MontoAmortCap * FactorDiv)
    
   While FechaAmortiza <= FechaFin
      MontoGrd = 0
      If FechaAmortizaCap = FechaAmortiza Then 'Si corresponde Amortizacion de Capital
         If FechaAmortizaCap = FechaFin Then 'Suma diferencia al ultimo vencimiento de Capital
            MontoAmortCap = MontoAmortCap + Cuadratura
         End If
         MontoGrd = MontoAmortCap
         '***Próxima Fecha Vcto. Amort. Capital
         FechaAmortizaCap = CreaFechaProx(FechaAmortizaCap, DiasAmortCap, DiaAmort, DesgloseAmort)
      End If
      
      With Grilla
         .Rows = .Rows + 1
         .TextMatrix(cuenta, 0) = cuenta & "  "
         .TextMatrix(cuenta, 1) = Format(FechaAmortiza, gsc_FechaDMA)
         .TextMatrix(cuenta, 2) = Format(MontoGrd, IIf(CodigoMoneda = 999, "###,###,###,##0", FormatEspecial))
         .TextMatrix(cuenta, 3) = Format(Tasa, "##0.###0")
         .TextMatrix(cuenta, 6) = IIf(optCompensa.Value = True, "Compensación" & Space(50) & "C", "Ent. Fisica" & Space(50) & "E")
      End With
      FechaVencAnt = FechaAmortiza
      FechaAmortiza = CreaFechaProx(FechaAmortiza, PlazoMin, DiaAmort, DesgloseAmort)
      
      If FechaAmortiza > FechaFin And Abs(DateDiff("d", CDate(FechaAmortiza), CDate(FechaFin))) <= 10 Then
         FechaAmortiza = FechaFin
         FechaAmortizaCap = FechaFin
      Else
         If FechaAmortiza > FechaFin And CDate(Grilla.TextMatrix(cuenta, 1)) < FechaFin Then
            FechaAmortiza = FechaFin
            FechaAmortizaCap = FechaFin
         ElseIf Abs(DateDiff("d", CDate(FechaFin), CDate(FechaAmortiza))) <= 10 Then
            FechaAmortiza = FechaFin
            FechaAmortizaCap = FechaFin
         End If
      End If
      If 1 = 2 Then
         If FechaAmortiza > FechaFin And Abs(DateDiff("d", CDate(FechaAmortiza), CDate(FechaFin))) <= 10 Then
            FechaAmortiza = FechaFin
            FechaAmortizaCap = FechaFin
         Else
            If Abs(DateDiff("d", CDate(FechaFin), CDate(FechaAmortiza))) <= 10 Then
               FechaAmortiza = FechaFin
               FechaAmortizaCap = FechaFin
            End If
         End If
      End If
      cuenta = cuenta + 1
   Wend

   If FechaAmortiza >= FechaFin Then
      Call CalculoInteresBonos(Opcion)
   End If
End Function

Function CalculoInteresBonos(TipOpcion As String)
   Dim Grd                As MSFlexGrid
   Dim Spread, Base, Tasa As Double
   Dim FechaAmortiza      As Date
   Dim FechaVencAnt       As Date
   Dim FecVAnt            As Date
   Dim DiasDif            As Integer
   Dim cuenta             As Integer
   Dim MontoAmortiza      As Double
   Dim MontoGrd           As Double
   Dim Interes            As Double
   Dim Plazo              As Double
   Dim RestoCapital       As Double
   Dim TotalVenc          As Double
   Dim CodMoneda          As Integer
   Dim FactorUSD          As Double
   Dim MontoCLP           As Double
   Dim FactorCLP          As Double
   Dim MontoUSD           As Double
   Dim MonFuerteC         As Double
   Dim Referencial        As Integer
   Dim PeriDias           As String
   Dim PeriBase           As String
   Dim fecInicio          As Date
   Dim MontoCapital       As Double
   Dim CodigoMoneda       As Integer
   Dim BaseStr            As String
   Dim PlazoDias          As Double
   Dim nRedondeo          As Integer
   Dim nParidad#
    
   Spread = 0
   FactorCLP = ValorDolarObs
   
   If TipOpcion = "C" Then
      Set Grd = fgFlujosCompra
      PlazoDias = ValorAmort(cmbAmortizaInteresCompramos, "D")
      BaseStr = cmbBaseCompra
      fecInicio = txtFecInicio.Text
      MontoCapital = (txtCapitalCompra.Text)                             'Monto Capital
      CodMoneda = SacaCodigo(cmbMonedaCompra)
   Else
      Set Grd = fgFlujosVenta
      PlazoDias = ValorAmort(cmbAmortizaInteresVendemos, "D")
      BaseStr = cmbBaseVenta
      fecInicio = txtFecInicio.Text
      MontoCapital = (txtCapitalVenta.Text)                             'Monto Capital
      CodMoneda = SacaCodigo(cmbMonedaVenta)
   End If
   
   FactorCLP = ValorDolarObs
   Dim Pasito
   Pasito = Right(BaseStr, 10)
   PeriDias = Trim(Left(Pasito, 5))
   PeriBase = Trim(Right(Pasito, 5))
   
   If PeriBase = "A" Then  ' De Actual
      Base = 365
   Else
      Base = PeriBase     'Base asignada para calculo
   End If
        
    DiasDif = DateDiff("d", CDate(fecInicio), CDate(Grd.TextMatrix(1, 1)))
       
    FechaVencAnt = CDate(fecInicio)
    MontoAmortiza = MontoCapital
    
    CodMoneda = IIf(CodMoneda = 0, 994, CodMoneda)
    
    Dim ValMonedas As New ClsMoneda
    
    With ValMonedas
    
        If .LeerxCodigo(CodMoneda) Then
            FactorUSD = .vmValor     'equivalencia a 1 dolar
            MonFuerteC = .mnrefusd   'Caracteristica moneda ( fuerte o no)
            Referencial = .mnrefmerc 'Referencial Mercado
        End If
        .Limpiar
        
    End With
    
    Set ValMonedas = Nothing
    
    With Grd
      For cuenta = 1 To .Rows - 1
         FechaAmortiza = .TextMatrix(cuenta, 1)
         MontoGrd = .TextMatrix(cuenta, 2)
         RestoCapital = CDbl(.TextMatrix(cuenta, 2)) 'MontoAmortCap
         Tasa = CDbl(.TextMatrix(cuenta, 3))
            
         If PeriDias = "A" Then
            DiasDif = DateDiff("d", CDate(FechaVencAnt), CDate(FechaAmortiza))
         Else
            DiasDif = BacDifDias30(CDate(FechaVencAnt), CDate(FechaAmortiza))
         End If
         FecVAnt = FechaVencAnt
         FechaVencAnt = .TextMatrix(cuenta, 1)
         Plazo = DiasDif / Val(Base)
         If CodMoneda = 999 Then
            nRedondeo = 0
         Else
            nRedondeo = 4
         End If
         Interes = Round(MontoAmortiza * (Tasa / 100) * (Plazo), nRedondeo)
         
         If CodMoneda = 999 Or CodMoneda = 998 Then
            MontoCLP = Round((Interes * FactorUSD), 0)
            MontoUSD = Round((BacDiv(MontoCLP, CDbl(FactorCLP))), 3)
         ElseIf CodMoneda = 13 Or Referencial = 1 Then
            MontoUSD = Interes
            MontoUSD = Round(MontoUSD, 4)
            MontoCLP = Round((MontoUSD * FactorCLP), 0)
         Else
            If TipOpcion = "V" Then
               If cSwMxV = "C" And CodMoneda <> 13 Then
                  nParidad# = Me.txtValorMonedaCompra.Text
                  MontoUSD = IIf(cRrdaV = "M", (Interes * nParidad#), (BacDiv(Interes, nParidad#)))
               Else
                  MontoUSD = IIf(Val(MonFuerteC) = 1, (Interes * FactorUSD), (BacDiv(Interes, CDbl(FactorUSD))))
               End If
            Else
               If cSwMxC = "C" And CodMoneda <> 13 Then
                  nParidad# = txtValorMonedaCompra.Text
                  MontoUSD = IIf(cRrdaV = "M", (Interes * nParidad#), (BacDiv(Interes, nParidad#)))
               Else
                  MontoUSD = IIf(Val(MonFuerteC) = 1, (Interes * FactorUSD), (BacDiv(Interes, CDbl(FactorUSD))))
               End If
            End If
            MontoUSD = Round(MontoUSD, 3)
            MontoCLP = Round((MontoUSD * FactorCLP), 0)
         End If
                        
         TotalVenc = MontoGrd + Interes
         '***Traspaso de Datos a Arreglo
         .TextMatrix(cuenta, 0) = cuenta
         .TextMatrix(cuenta, 1) = Format(FechaAmortiza, gsc_FechaDMA)
         .TextMatrix(cuenta, 2) = Format(MontoGrd, IIf(CodMoneda = 999, "###,###,###,##0", FormatEspecial))
         .TextMatrix(cuenta, 3) = Format(Tasa, "####0.###0")
         .TextMatrix(cuenta, 4) = Format(Interes, IIf(CodMoneda = 999, "###,###,###,##0", FormatEspecial))
         .TextMatrix(cuenta, 5) = Format(TotalVenc, IIf(CodMoneda = 999, "###,###,###,##0", FormatEspecial))
         .TextMatrix(cuenta, 8) = MontoAmortiza - RestoCapital
         .TextMatrix(cuenta, 9) = FecVAnt
         .TextMatrix(cuenta, 10) = MontoAmortiza
         .TextMatrix(cuenta, 11) = MontoUSD
         .TextMatrix(cuenta, 12) = MontoCLP
         MontoAmortiza = MontoAmortiza - RestoCapital
      Next
   End With
   Set Grd = Nothing

End Function


Sub CreaFgrd(cFlujo As String)
Dim nCortes     As Integer
Dim nPeriodoMin As Integer
Dim nDias       As Integer
Dim nDia1#
Dim nDia2#
Dim fgrdFlujos  As Object
Dim nMonto      As Double
Dim nTasa       As Double
Dim nBase       As Integer
Dim I           As Integer
Dim nDiasCap#


Exit Sub

nDia1# = IIf(nDiasCapital# <= 0, 1, nDiasCapital#)
nDia2# = IIf(nDiasInteres# <= 0, 1, nDiasInteres#)

If nDiasCapital# = -1 Then
    nDiasCap# = 0
Else
    nDiasCap# = nDiasCapital#
End If
nDias = IIf(nDia1# > nDia2#, nDiasInteres#, nDiasCap#)

If cFlujo = H_COMPRA Then
   Set fgrdFlujos = fgFlujosCompra
   nTasa = Val(txtTasaCompra.Text) + Val(txtSpreadCompra.Text)
   nMonto = txtCapitalCompra.Tag
   nBase = cmbBaseCompra
Else
   Set fgrdFlujos = fgFlujosVenta
   nTasa = Val(txtTasaVenta.Text) + Val(txtSpreadVenta.Text)
   nMonto = txtCapitalVenta.Tag
   nBase = cmbBaseVenta
End If

'---- Titulos de Grilla
With fgrdFlujos

     .Clear
     .FixedRows = 0
     .Rows = 2
     .FixedRows = 1
     .FixedCols = 1
     
     .Cols = 11
     .TextMatrix(0, 0) = "Nro."
     .TextMatrix(0, 1) = "Vencimiento"
     .TextMatrix(0, 2) = "Amortización"
     .TextMatrix(0, 3) = "Interes"
     .TextMatrix(0, 4) = "Total"
     .TextMatrix(0, 5) = "Saldo Amortizacion"
     .TextMatrix(0, 6) = "Inicio Flujo"
     .TextMatrix(0, 7) = "Valor USD"
     .TextMatrix(0, 8) = "Valor $"
     .TextMatrix(0, 9) = "si es de cartera historica"
     .TextMatrix(0, 10) = "Compensación"
    
     .ColWidth(0) = TextWidth(" 9999 ")
     .ColWidth(1) = TextWidth("   99/99/9999   ")
     .ColWidth(2) = TextWidth("  999,999,999,999.9999 ")
     .ColWidth(3) = TextWidth("  999,999,999,999.9999 ")
     .ColWidth(4) = TextWidth("  999,999,999,999.9999 ")
     .ColWidth(5) = TextWidth("  999,999,999,999.9999 ")
     .ColWidth(6) = TextWidth("")
     .ColWidth(7) = TextWidth("")
     .ColWidth(8) = TextWidth("")
     .ColWidth(9) = TextWidth("")
     .ColWidth(10) = 1440
             
     .Row = .Rows - 1
     Do While .Row > 0
         .TextMatrix(.Row, 0) = .Row
         .Row = .Row - 1
     Loop
     
     For I = 0 To .Cols - 1
         .Col = I
         .CellAlignment = flexAlignCenterCenter
     Next
     
    .RowHeightMin = 300

End With


Set fgrdFlujos = Nothing
 
End Sub
Function LLenafgrdFlujos(ByRef Grilla As Object)

Dim I As Integer
    
    With Grilla
    .Cols = 14

    'columnas visibles
    .TextMatrix(0, 0) = "Nro."
    .TextMatrix(0, 1) = "Vencimiento"
    .TextMatrix(0, 2) = "Amortización " '& Trim(cmbAmortizaCapitalCompramos)
    .TextMatrix(0, 3) = "Tasa"
    .TextMatrix(0, 4) = "Interés " '& Trim(cmbAmortizaInteresCompramos)
    .TextMatrix(0, 5) = "Total"
    .TextMatrix(0, 6) = "Modalidad"
     'columnas invisibles
    .TextMatrix(0, 7) = "Documento Pago"
    .TextMatrix(0, 8) = "Saldo amortizar"
    .TextMatrix(0, 9) = "Fecha Vcto. Anterior"
    .TextMatrix(0, 10) = "Monto en moneda seleccionada"
    .TextMatrix(0, 11) = "Monto en USD que paga./recib."
    .TextMatrix(0, 12) = "Monto en $ que paga./recib."
    .TextMatrix(0, 13) = "Ubicacion del Dato "
    
    .ColWidth(0) = TextWidth("99999")
    .ColWidth(1) = 1280
    .ColWidth(2) = TextWidth(" 999,999,999,999.9999 ")
    .ColWidth(3) = 0
    .ColWidth(4) = 2000
    .ColWidth(5) = TextWidth(" 999,999,999,999.9999 ")
    .ColWidth(6) = 1440
    
    .ColWidth(7) = 0
    .ColWidth(8) = 0
    .ColWidth(9) = 0
    .ColWidth(10) = 0
    .ColWidth(11) = 0
    .ColWidth(12) = 0
    .ColWidth(13) = 0
    
    .Row = 0
    For I = 0 To .Cols - 1
        .Col = I
        .CellAlignment = flexAlignCenterCenter
    Next
    .RowHeightMin = 300
    .ColAlignment(1) = flexAlignCenterCenter
    
    Set Grilla = Nothing
    
    End With

    tabFlujos.TabIndex = 2

End Function

Private Sub Form_Unload(Cancel As Integer)

    Set objMoneda = Nothing
    If cOperSwap = "ModificacionCartera" Or cOperSwap = "Modificacion" Then
        BacConsultaOper.Show
    End If
    
End Sub

Function ValorTasas(CodMon As Integer, sFecha, Periodo, CodTasa) As Double

'Saca datos tabla mdperiodos y llena combo
Dim SQL   As String
Dim Datos()
Dim I As Integer

    Envia = Array()
    AddParam Envia, CDbl(CodMon)
    AddParam Envia, CodTasa
    AddParam Envia, Periodo
    AddParam Envia, sFecha
    
    If Not Bac_Sql_Execute("SP_LEER_TASASMONEDAS", Envia) Then
        MsgBox "No se encontraron Tasas asociadas a ésta Moneda!", vbInformation, Msj
        Exit Function
    End If
           
    If Bac_SQL_Fetch(Datos()) Then
        ValorTasas = Datos(8)
    Else
        ValorTasas = 0
    End If

End Function


Private Sub optCompensa_Click()
    cModalidad = "C"

End Sub


Private Sub optCompra_Click()
    Dim I As Integer
    Dim nPaso As String
    
    If Not lEntrada Then
        optVenta_Click
        cTipoOperacion$ = H_COMPRA
        Exit Sub
    End If
    
    cTipoOperacion$ = H_COMPRA
    
    cmbMonedaVenta.Tag = 998
    Call bacBuscarCombo(cmbMonedaVenta, Val(cmbMonedaVenta.Tag))
    Call LlenaMonDocPago(cmbMonedaPagamos, DatosPorMoneda(), 1, Val(cmbMonedaVenta.Tag), TotDatPorMon, 1)
    
    cmbMonedaCompra.Tag = 13
    Call bacBuscarCombo(cmbMonedaCompra, Val(cmbMonedaCompra.Tag))
    Call LlenaMonDocPago(cmbMonedaRecibimos, DatosPorMoneda(), 1, Val(cmbMonedaCompra.Tag), TotDatPorMon, 1)
    
    lEntrada = False
    'txtValorMonedaCompra.Enabled = False
End Sub

Private Sub optCompra_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      If cmbMonedaCompra.Enabled = True Then
         cmbMonedaCompra.SetFocus
      Else
         txtCapitalCompra.SetFocus
      End If
   End If
End Sub

Private Sub optEntFisica_Click()
   cModalidad = "E"
End Sub



Private Sub optVenta_Click()
   Dim nPaso            As String
   Dim nPaso1           As String
   Dim CodPaso          As Integer
   Dim CodPaso1         As Integer
   Dim CodTasaC         As Integer
   Dim CodTasaV         As Integer
   Dim I                As Integer
   Dim Traspaso(10, 2)  As Variant ' Columna 1 Lo que es de Compra y 2 de Venta
   
   cTipoOperacion$ = H_VENTA
   
   For I = 1 To 10    ' inicializa en cero
      Traspaso(I, 1) = 0
      Traspaso(I, 2) = 0
   Next I

   '---- Cambia Moneda
   Traspaso(1, 1) = Val(cmbMonedaVenta.Tag)
   Traspaso(1, 2) = Val(cmbMonedaCompra.Tag)
   Traspaso(2, 2) = txtValorMonedaVenta.Tag
   Traspaso(2, 2) = txtValorMonedaCompra.Tag
   Traspaso(3, 1) = CDbl(txtCapitalVenta.Tag)
   Traspaso(3, 2) = CDbl(txtCapitalCompra.Tag)
   '---- Cambia Tasa

   If cmbTasaVenta.ListIndex > -1 Then
      Traspaso(4, 1) = cmbTasaVenta.ItemData(cmbTasaVenta.ListIndex)
   End If
   If cmbTasaCompra.ListIndex > -1 Then
      Traspaso(4, 2) = cmbTasaCompra.ItemData(cmbTasaCompra.ListIndex)
   End If
   Traspaso(5, 1) = CDbl(txtTasaVenta.Text)
   Traspaso(5, 2) = CDbl(txtTasaCompra.Text)
   Traspaso(6, 1) = CDbl(txtSpreadVenta.Text)
   Traspaso(6, 2) = CDbl(txtSpreadCompra.Text)
   Traspaso(7, 1) = cmbBaseVenta
   Traspaso(7, 2) = cmbBaseCompra

   If cmbMonedaPagamos.ListIndex > -1 Then
      Traspaso(8, 1) = cmbMonedaPagamos.ItemData(cmbMonedaPagamos.ListIndex)
   End If
   If cmbMonedaRecibimos.ListIndex > -1 Then
      Traspaso(8, 2) = cmbMonedaRecibimos.ItemData(cmbMonedaRecibimos.ListIndex)
   End If
   If cmbDocumentoPagamos.ListIndex > -1 Then
      Traspaso(9, 1) = cmbDocumentoPagamos.ItemData(cmbDocumentoPagamos.ListIndex)
   End If
   If cmbDocumentoRecibimos.ListIndex > -1 Then
      Traspaso(9, 2) = cmbDocumentoRecibimos.ItemData(cmbDocumentoRecibimos.ListIndex)
   End If
   
   cmbMonedaPagamos.Clear
   cmbMonedaRecibimos.Clear
   cmbDocumentoPagamos.Clear
   cmbDocumentoRecibimos.Clear
   
   Call bacBuscarCombo(cmbMonedaCompra, Val(Traspaso(1, 1)))
   Call bacBuscarCombo(cmbMonedaVenta, Val(Traspaso(1, 2)))
   
   cmbMonedaCompra.Tag = Val(Traspaso(1, 1))
   cmbMonedaVenta.Tag = Val(Traspaso(1, 2))
   txtValorMonedaCompra.Text = Traspaso(2, 1)
   txtValorMonedaCompra.Tag = Traspaso(2, 1)
   txtValorMonedaCompra.Enabled = True
   txtValorMonedaVenta.Text = Traspaso(2, 2)
   txtValorMonedaVenta.Tag = Traspaso(2, 2)
   txtCapitalCompra.Tag = Traspaso(3, 1)
   txtCapitalCompra.Text = Traspaso(3, 1)
   txtCapitalVenta.Text = Traspaso(3, 2)
   txtCapitalVenta.Tag = Traspaso(3, 2)
   
   Call bacBuscarCombo(cmbTasaCompra, Traspaso(4, 1))
   Call bacBuscarCombo(cmbTasaVenta, Traspaso(4, 2))
   
   txtTasaCompra.Text = Traspaso(5, 1)
   txtTasaVenta.Text = Traspaso(5, 2)
   txtSpreadCompra.Text = Traspaso(6, 1)
   txtSpreadVenta.Text = Traspaso(6, 2)

   Call BacBuscaTxtCombo(cmbBaseCompra, CStr(Traspaso(7, 1)))
   Call BacBuscaTxtCombo(cmbBaseVenta, CStr(Traspaso(7, 2)))
   Call bacBuscarCombo(cmbMonedaRecibimos, Traspaso(8, 1))
   Call bacBuscarCombo(cmbMonedaPagamos, Traspaso(8, 2))
   Call bacBuscarCombo(cmbDocumentoRecibimos, Traspaso(9, 1))
   Call bacBuscarCombo(cmbDocumentoPagamos, Traspaso(9, 2))
   
   If tabFlujos.TabEnabled(1) = True Then
      cmdCalcula_Click
   End If
   
End Sub

Private Sub optVenta_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      cmbMonedaCompra.SetFocus
   End If
End Sub
Private Sub tabFlujos_Click(PreviousTab As Integer)
   Select Case PreviousTab
      Case 1
         cmbModalidad.Visible = False
         txtAmortiza.Visible = False
      Case 2
         cmbModalidadVen.Visible = False
         txtAmortizaVen.Visible = False
   End Select
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
   Select Case Button.Index
      Case 1
         cmdCalcula_Click
      Case 2
         If ValidaFlujosconMontos = True Then
            Call cmdGrabar_Click
         End If
      Case 3
         cmdLimpia_Click
         etqNumOper.Visible = False
         Lbl_Num_Oper_Oculto.Caption = 0
         cOperSwap = "Ingreso"
         Screen.MousePointer = vbDefault
      Case 4
         Unload Me
   End Select
End Sub


Private Sub txtAmortiza_KeyPress(KeyAscii As Integer)
   Dim I          As Integer
   Dim SumAmort   As Double

   If KeyAscii = vbKeyEscape Then
      txtAmortiza.Visible = False
      txtAmortiza.Text = 0
      fgFlujosCompra.SetFocus
      Exit Sub
   End If

   If KeyAscii <> vbKeyReturn Then
      Exit Sub
   End If

   If fgFlujosCompra.Col <> 2 Then
      Exit Sub
   End If

   If txtAmortiza.Text <> fgFlujosCompra.TextMatrix(fgFlujosCompra.Row, 2) Then
      SumAmort = 0
      If fgFlujosCompra.TextMatrix(I, 2) = "" Then
         Exit Sub
      End If
      
      If nDiasCapital# = -1 And cTipoOperacion$ = "C" Then
         
         If Not ValidaModificaciones(fgFlujosCompra) Then
            'Amortizacion de capital BONOS
            For I = 1 To fgFlujosCompra.Rows - 1
               If I = Val(fgFlujosCompra.Row) Then
                  SumAmort = SumAmort + CDbl(txtAmortiza.Text)
               Else
                  SumAmort = SumAmort + CDbl(fgFlujosCompra.TextMatrix(I, 2))
               End If
            Next I
            
            If SumAmort <> CDbl(txtCapitalCompra.Text) Then
               fgFlujosCompra.TextMatrix(fgFlujosCompra.Row, 2) = txtAmortiza.Text
               Call CalculoInteresBonos("C")
               For I = 1 To fgFlujosVenta.Rows - 1
                  If CDate(fgFlujosVenta.TextMatrix(I, 1)) = CDate(fgFlujosCompra.TextMatrix(fgFlujosCompra.Row, 1)) Then
                     Call CalculoInteresBonos("V")
                     Exit For
                  End If
               Next I
            End If
            fgFlujosCompra.TextMatrix(fgFlujosCompra.Row, 2) = txtAmortiza.Text
            Call CalculoInteresBonos("V")
         End If
      
      End If
   End If

   txtAmortiza.Visible = False
   txtAmortiza.Text = 0
   fgFlujosCompra.SetFocus

End Sub


Private Sub txtAmortiza_KeyUp(KeyCode As Integer, Shift As Integer)
   With fgFlujosCompra
      Select Case KeyCode
         Case vbKeyUp
            If .Row > 1 Then
               .Row = .Row - 1
            End If
         Case vbKeyDown
            If .Row > 0 And .Row < .Rows - 1 Then
               .Row = .Row + 1
            End If
        End Select
    End With
End Sub

Private Sub txtAmortizaVen_KeyPress(KeyAscii As Integer)
   Dim I          As Integer
   Dim SumAmort   As Double

   If KeyAscii <> vbKeyReturn Then
      Exit Sub
   End If
    
   If fgFlujosVenta.Col <> 2 Then
      Exit Sub
   End If
   
   If txtAmortizaVen.Text <> fgFlujosVenta.TextMatrix(fgFlujosVenta.Row, 2) Then
      SumAmort = 0
      If fgFlujosVenta.TextMatrix(I, 2) = "" Then
         Exit Sub
      End If
        
      If nDiasCapital# = -1 And cTipoOperacion$ = "C" Then
         If Not ValidaModificaciones(fgFlujosVenta) Then
            'Amortizacion de capital BONOS
            For I = 1 To fgFlujosVenta.Rows - 1
               If I = Val(fgFlujosVenta.Row) Then
                  SumAmort = SumAmort + CDbl(txtAmortizaVen.Text)
               Else
                  SumAmort = SumAmort + CDbl(fgFlujosVenta.TextMatrix(I, 2))
               End If
            Next
            
            If SumAmort <> CDbl(txtCapitalVenta.Text) Then
                  fgFlujosVenta.TextMatrix(fgFlujosVenta.Row, 2) = txtAmortizaVen.Text
                  Call CalculoInteresBonos("V")
                  For I = 1 To fgFlujosCompra.Rows - 1
                     If CDate(fgFlujosCompra.TextMatrix(I, 1)) = CDate(fgFlujosVenta.TextMatrix(fgFlujosVenta.Row, 1)) Then
                        Call CalculoInteresBonos("C")
                        Exit For
                     End If
                  Next
            End If
               
               fgFlujosVenta.TextMatrix(fgFlujosVenta.Row, 2) = txtAmortizaVen.Text
               Call CalculoInteresBonos("C")
            End If
            
        End If
        
    End If
    txtAmortizaVen.Visible = False
    txtAmortizaVen.Text = 0
    fgFlujosVenta.SetFocus

End Sub

Private Sub txtCapitalCompra_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then SendKeys ("{Tab}")
   
End Sub


Private Sub txtCapitalCompra_LostFocus()
   Call Conversion(True)
End Sub

Private Sub txtCapitalVenta_LostFocus()
   Call Conversion(False)
End Sub

Private Sub txtCapitalVenta_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then SendKeys ("{Tab}")
End Sub
Private Sub txtFecInicio_Change()

    txtFecInicio.Text = Format(txtFecInicio.Text, gsc_FechaDMA)
    lblFechaInicio.Caption = BacFechaStr(txtFecInicio.Text)
    If Not BacEsHabil(txtFecInicio.Text) Then
        lblFechaInicio.ForeColor = vbRed
    Else
        lblFechaInicio.ForeColor = vbBlue
    End If
    
End Sub

Private Sub txtFecInicio_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        If ValidaFechasIngreso(1, 0, "C") Then
            SendKeys ("{Tab}")
        End If
    End If
    
End Sub


Private Sub txtFecPrimerVcto_Change()
    txtFecPrimerVcto.Text = Format(txtFecPrimerVcto.Text, gsc_FechaDMA)
    lblFechaPrimerAmort.Caption = BacFechaStr(txtFecPrimerVcto.Text)
    
    If Not BacEsHabil(txtFecPrimerVcto.Text) Then
        lblFechaPrimerAmort.ForeColor = vbRed
    Else
        lblFechaPrimerAmort.ForeColor = vbBlue
    End If
    
End Sub

Private Sub txtFecPrimerVcto_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
    
        If ValidaFechasIngreso(2, 0, "C") Then
            txtFecTermino.SetFocus
        End If
        
    End If
    
End Sub

Private Sub txtFecPrimerVcto_LostFocus()
    Call txtFecPrimerVcto_Change
    Call ValidaFechasIngreso(2, 0, "C")

End Sub

Function ValidaModificaciones(ByRef Grilla As Object) As Boolean

    'Valida cambios de grilla
    ValidaModificaciones = True
    With Grilla
    If .TextMatrix(.Row, 1) = "" Then
        MsgBox "Debe escribir Fecha Primer Vencimiento", vbInformation, Msj
        Exit Function
    End If
    If Not IsDate(.TextMatrix(.Row, 1)) Then
        MsgBox "Fecha de Vencimiento está incorrecta", vbInformation, Msj
        Exit Function
    End If
    If .TextMatrix(.Row, 2) = "" Then
        MsgBox "Debe ingresar monto Amortización", vbInformation, Msj
        Exit Function
    End If
    If Not IsNumeric(.TextMatrix(.Row, 2)) Then
        MsgBox "Monto Amortización incorrecto!", vbInformation, Msj
        Exit Function
    Else
        .TextMatrix(.Row, 2) = Format(.TextMatrix(.Row, 2), "###,###,###,###,##0.###0")
    End If
    
    If (.TextMatrix(.Row, 3)) = "" Then .TextMatrix(.Row, 3) = 0
    
    If Not IsNumeric(.TextMatrix(.Row, 3)) Then
        MsgBox "Monto Tasa incorrecto!", vbInformation, Msj
        Exit Function
    Else
        .TextMatrix(.Row, 3) = Format(.TextMatrix(.Row, 3), "##,##0.###0")
    End If
    
    End With
    
    ValidaModificaciones = False

End Function

Private Sub txtFecTermino_Change()

    txtFecTermino.Text = Format(txtFecTermino.Text, gsc_FechaDMA)
    lblFechaTermino.Caption = BacFechaStr(txtFecTermino.Text)
    If Not BacEsHabil(txtFecTermino.Text) Then
        lblFechaTermino.ForeColor = vbRed
    Else
        lblFechaTermino.ForeColor = vbBlue
    End If
    
End Sub

Private Sub txtFecTermino_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        If ValidaFechasIngreso(3, 0, "C") Then
            SendKeys ("{Tab}")
        End If
    End If
    
End Sub

Private Sub txtFechaPag_KeyPress(KeyAscii As Integer)
    Call FechaVenceFlujo(txtFechaPag, KeyAscii, "V")
End Sub

Function FechaVenceFlujo(ByRef Fecha As Object, Tecla As Integer, TipOpcion As String)
    On Error GoTo Error
    Dim iDec%
    Dim total#
    Dim OldFecha, NewFecha As Date
    Dim vMsg
    Dim sFormat$
    Dim oGrilla As Object
    Dim mGrilla As Object
    Dim obase As String
    Dim mbase As String
    Dim oTipOp As String
    Dim mTipOp As String
    Dim I As Integer
    Dim FechaInicio As Date
    Dim fechaTermino
    
   Screen.MousePointer = vbHourglass
 
   If Tecla = vbKeyReturn Or Tecla = vbKeyEscape Then
      If TipOpcion = "C" Then
         Set mGrilla = fgFlujosCompra
         mbase = cmbBaseCompra
         mTipOp = "C"
         Set oGrilla = fgFlujosVenta
         obase = cmbBaseVenta
         oTipOp = "V"
         FechaInicio = txtFecInicio.Text
         fechaTermino = txtFecTermino.Text
         total = CDbl(txtCapitalCompra.Text)
      Else
         Set mGrilla = fgFlujosVenta
         mbase = cmbBaseVenta
         mTipOp = "V"
         Set oGrilla = fgFlujosCompra
         obase = cmbBaseCompra
         oTipOp = "C"
         FechaInicio = txtFecInicio.Text
         fechaTermino = txtFecTermino.Text
         total = CDbl(txtCapitalVenta.Text)
      End If
      With mGrilla
         If .Col = 1 Then
            If Tecla = vbKeyEscape Then
               GoTo Fin
            End If
            '-- para validar fecha
            If .Row = 1 Then
               OldFecha = FechaInicio
            Else
               OldFecha = .TextMatrix(.Row - 1, .Col)
            End If
            If .Row + 1 = .Rows Then
               'NewFecha = fechaTermino
            Else
               NewFecha = .TextMatrix(.Row + 1, .Col)
            End If
         End If
         iDec = 5
         sFormat = "#,##0" + IIf(iDec = 0, "", "." + String(iDec, "0"))
                
         If Not ValidaDatosCambio Then
            GoTo Fin
         End If
         If Not BacEsHabil(Fecha.Text) Then
'            MsgBox "Fecha corresponde a un día no hábil, se define próximo hábil", vbCritical, "Control de Vencimientos"
'            Fecha.Text = BacProxHabil(Fecha.Text)
'            SendKeys "{HOME}{LEFT}"
'            Exit Function
         End If
        
         OldFecha = .TextMatrix(.Row, .Col)
         NewFecha = Fecha.Text
         If CDate(NewFecha) = CDate(OldFecha) Then
            .Enabled = True
            .SetFocus
            GoTo Fin
         End If
        
         '---- Modifica Vencimiento de Flujo
         .TextMatrix(.Row, .Col) = NewFecha
            
         If .Row + 1 = .Rows Then
            If mTipOp = "C" Then
               txtFecTermino.Text = NewFecha
               If OldFecha = CDate(txtFecTermino.Text) Then
                  txtFecTermino.Text = NewFecha
               End If
            Else
               txtFecTermino.Text = NewFecha
               If CDate(txtFecTermino.Text) = OldFecha Then
                  txtFecTermino.Text = NewFecha
               End If
            End If
         End If
       
         If .Row + 1 < .Rows Then
            .TextMatrix(.Row + 1, 9) = NewFecha                 '---- Modifica Inicio de Flujo Posterior
         End If

         Call CalculoInteresBonos(mTipOp)
            
         If cmbAmortizaInteresCompramos.ListIndex = cmbAmortizaInteresVendemos.ListIndex Then
            For I = 1 To oGrilla.Rows - 1
               If CDate(oGrilla.TextMatrix(I, 1)) = CDate(OldFecha) Then
                  oGrilla.TextMatrix(I, 1) = NewFecha
                  If oGrilla.Row + 1 < oGrilla.Rows Then
                     oGrilla.TextMatrix(oGrilla.Row + 1, 9) = NewFecha  '---- Modifica Inicio de Flujo Posterior
                  End If
                  Call CalculoInteresBonos(oTipOp)
                  Exit For
               End If
            Next
         End If
            GoTo Fin
      End With
   End If
        
   Screen.MousePointer = vbDefault
   Exit Function
Fin:
   Screen.MousePointer = vbDefault
   Set oGrilla = Nothing
   Set mGrilla = Nothing
   Fecha.Visible = False
   Exit Function
Error:
   Screen.MousePointer = vbDefault
   MsgBox "ERROR : " & err.Description, vbOKOnly + vbCritical
   Set oGrilla = Nothing
   Fecha.Visible = False
   Exit Function
End Function


Public Function ValidaDatosCambio()
   On Error GoTo Error
   
   ValidaDatosCambio = False
   'Datos minimos requeridos para realizar operacion de calculo
    
   'Compra
   If txtCapitalCompra.Text = "" Then
      MsgBox "Debe ingresar Monto Capital", vbInformation, Msj
      txtCapitalCompra.SetFocus
      Exit Function
   End If
   If Val(txtCapitalCompra.Text) <= 0 Then
      MsgBox "Monto Capital debe ser Mayor a CERO", vbInformation, Msj
      txtCapitalCompra.SetFocus
      Exit Function
   End If
   If cmbTasaCompra.ListIndex = -1 Then
      MsgBox "Debe seleccionar el tipo de Tasa en Recibimos", vbInformation, Msj
      cmbTasaCompra.SetFocus
      Exit Function
   End If
   If txtTasaCompra.Text = "" Then
      MsgBox "Debe ingresar Monto Tasa Compra", vbInformation, Msj
      txtTasaCompra.SetFocus
      Exit Function
   ElseIf Not IsNumeric(txtTasaCompra.Text) Then
      MsgBox "Monto de Tasa está Incorrecto!", vbInformation, Msj
      txtTasaCompra.SetFocus
      Exit Function
   End If
   If cmbBaseCompra.ListIndex = -1 Then
      MsgBox "Debe seleccionar Base Tasa en Compras", vbInformation, Msj
      cmbBaseCompra.SetFocus
      Exit Function
   End If
   If cmbAmortizaCapitalCompramos.ListIndex = -1 Then
      MsgBox "Debe seleccionar Opción de Amortización de Capital", vbInformation, Msj
      cmbAmortizaCapitalCompramos.SetFocus
      Exit Function
   End If
    
   'Venta
   If txtCapitalVenta.Text = "" Then
      MsgBox "Debe ingresar Monto Capital Venta", vbInformation, Msj
      txtCapitalVenta.SetFocus
      Exit Function
   End If
   If Val(txtCapitalVenta.Text) <= 0 Then
      MsgBox "Monto Capital Venta debe ser Mayor a CERO", vbInformation, Msj
      txtCapitalVenta.SetFocus
      Exit Function
   End If
   If cmbTasaVenta.ListIndex = -1 Then
      MsgBox "Debe seleccionar el tipo de Tasa en Pagamos", vbInformation, Msj
      cmbTasaVenta.SetFocus
      Exit Function
   End If
   If txtTasaVenta.Text = "" Then
      MsgBox "Debe ingresar Monto Tasa Venta", vbInformation, Msj
      txtTasaVenta.SetFocus
      Exit Function
   ElseIf Not IsNumeric(txtTasaVenta.Text) Then
      MsgBox "Monto de Tasa Venta está Incorrecto!", vbInformation, Msj
      txtTasaVenta.SetFocus
      Exit Function
   End If
   If cmbBaseVenta.ListIndex = -1 Then
      MsgBox "Debe seleccionar Base Tasa en Venta", vbInformation, Msj
      cmbBaseVenta.SetFocus
      Exit Function
   End If
   If cmbAmortizaInteresCompramos.ListIndex = -1 Then
      MsgBox "Debe seleccionar Opción de Amortización de Interés", vbInformation, Msj
      cmbAmortizaInteresCompramos.SetFocus
      Exit Function
   End If
    
   If txtFecInicio.Text = "" Then
      MsgBox "Debe ingresar Fecha Inicio de Contrato", vbInformation, Msj
      txtFecInicio.SetFocus
      Exit Function
   ElseIf Not IsDate(txtFecInicio.Text) Then
      MsgBox "Fecha Inicio de Contrato está Incorrecta!", vbInformation, Msj
      txtFecInicio.SetFocus
      Exit Function
   ElseIf Not BacEsHabil(txtFecInicio.Text) Then
      MsgBox "Fecha de Inicio no es día hábil", vbInformation, Msj
      txtFecInicio.SetFocus
      Exit Function
   End If
   
   If txtFecTermino.Text = "" Then
      MsgBox "Debe ingresar Fecha Termino de Contrato", vbInformation, Msj
      txtFecTermino.SetFocus
      Exit Function
   ElseIf Not IsDate(txtFecTermino.Text) Then
      MsgBox "Fecha Termino de Contrato está Incorrecta!", vbInformation, Msj
      txtFecTermino.SetFocus
      Exit Function
   ElseIf Not BacEsHabil(txtFecTermino.Text) Then
      MsgBox "Fecha de Término no es día hábil", vbInformation, Msj
      txtFecTermino.SetFocus
      Exit Function
   End If
   ValidaDatosCambio = True
Exit Function
Error:
   ValidaDatosCambio = False
   MsgBox "ERROR : " & err.Description, vbOKOnly + vbCritical
   Exit Function
End Function

Private Sub txtFechaRecib_KeyPress(KeyAscii As Integer)
   Call FechaVenceFlujo(txtFechaRecib, KeyAscii, "C")
End Sub

Private Sub txtSpreadCompra_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then SendKeys ("{Tab}")
End Sub

Private Sub txtSpreadVenta_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then SendKeys ("{Tab}")
End Sub

Private Sub txtTasaCompra_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then SendKeys ("{Tab}")
End Sub

Private Sub txtTasaVenta_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then SendKeys ("{Tab}")
End Sub

Private Function F_Trae_paridad_bcch(nCod As String, Fecp As String) As Double
   Dim SQL$
   Dim Datos()

   SQL$ = "SP_TRAE_PARIDAD_SPOT_BCCH " _
        & "'" & nCod & "', '" & Fecp & "' "

   If MISQL.SQL_Execute(SQL) <> 0 Then
      MsgBox "Problemas para Rescatar Paridad del BCCH", vbCritical, "ERROR DE CALCULO"
      F_Trae_paridad_bcch = 1
      Exit Function
   Else
      If MISQL.SQL_Fetch(Datos()) = 0 Then
         If Datos(1) = -1 Then
            'MsgBox "Paridad del BCCH no existe o no esta Ingresada", vbCritical, "ERROR DE CALCULO"
            F_Trae_paridad_bcch = 1
         Else
            F_Trae_paridad_bcch = Datos(1)
         End If
      End If
   End If
End Function

Private Sub txtValorMonedaCompra_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call Conversion(True)
      
      SendKeys ("{Tab}")
   End If
End Sub

Private Sub txtValorMonedaVenta_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call Conversion(False)
      
      SendKeys ("{Tab}")
   End If
End Sub



Private Function RecalculoMontos(Optional iVenta As Boolean) As Double
   
Exit Function
   
   Dim MiMoneda      As New ClsMoneda
   Dim iMonedaCompra As Integer
   Dim iMonedaVenta  As Integer
   Dim iMontoMon     As Double
   Dim iMontoUsd     As Double
   Dim iTcUsdClp     As Double
   Dim iParidadMx    As Double
   Dim iMontoCnv     As Double
   Dim iMnRrda       As String
   Dim iMnMx         As String
   Dim MonedaLocal   As String
   Dim iMoneda       As Integer
   Dim iEquivUSD     As Double
   Dim iDecimales    As Integer
   
   MonedaLocal = "998,999,995,994"
   RecalculoMontos = 0#
   If cmbMonedaCompra.ListIndex = -1 Or cmbMonedaVenta.ListIndex = -1 Then
      Exit Function
   End If
   
   iMonedaCompra = cmbMonedaCompra.ItemData(cmbMonedaCompra.ListIndex)
   iMonedaVenta = cmbMonedaVenta.ItemData(cmbMonedaVenta.ListIndex)
  
   If iVenta = True Then
      iMontoMon = txtCapitalVenta.Text
   Else
      iMontoMon = txtCapitalCompra.Text
   End If
   
   If iMonedaCompra = 13 Then
      iMontoUsd = txtCapitalCompra.Text
      iTcUsdClp = txtValorMonedaCompra.Text
      iParidadMx = txtValorMonedaVenta.Text
      Call MiMoneda.LeerxCodigo(iMonedaVenta)
      iMnRrda = MiMoneda.mnrrda
      iMnMx = MiMoneda.mnmx
      iMoneda = MiMoneda.mncodigo
      iEquivUSD = MiMoneda.mnrefusd
   Else
      iMontoUsd = txtCapitalVenta.Text
      iTcUsdClp = txtValorMonedaVenta.Text
      iParidadMx = txtValorMonedaCompra.Text
      Call MiMoneda.LeerxCodigo(iMonedaCompra)
      iMnRrda = MiMoneda.mnrrda
      iMnMx = MiMoneda.mnmx
      iMoneda = MiMoneda.mncodigo
      iEquivUSD = MiMoneda.mnrefusd
   End If

   If InStr(1, MonedaLocal, iMoneda) = 0 Then
      iTcUsdClp = gsBAC_DolarObs
   End If

   iMontoCnv = 0#
   If iMnMx = "" And InStr(1, MonedaLocal, iMoneda) > 0 Then
      If iMonedaCompra = 13 Then
         If iMoneda = 999 Then
            iMontoCnv = Round((iMontoMon * iTcUsdClp) / iParidadMx, 0)
         Else
            If iVenta = True Then
               If iTcUsdClp > 0 Then
                  iMontoCnv = Round((iMontoMon * iParidadMx) / iTcUsdClp, 0)
               End If
            Else
               iMontoCnv = Round((iMontoMon * iTcUsdClp) / iParidadMx, 4)
            End If
         End If
      Else
         If iMoneda = 999 Then
            iMontoCnv = Round((iMontoMon * iParidadMx) / iTcUsdClp, 0)
         Else
            If iVenta = True Then
               iMontoCnv = Round((iMontoMon * iTcUsdClp) / iParidadMx, 4)
            Else
               iMontoCnv = Round((iMontoMon * iParidadMx) / iTcUsdClp, 4)
            End If
         End If
      End If
   ElseIf iMnMx = "" And iEquivUSD = 1 Then
      iMontoCnv = Round(BacDiv((iMontoMon * iTcUsdClp), iParidadMx), 4)
   ElseIf iMnMx = "" Then
      iMontoCnv = Round(iMontoMon * iParidadMx, 4)
   ElseIf iMnMx <> "" Then
      If iMonedaCompra = 13 Then
         'Recibo USD Entrego MX
         If iMnRrda = "D" Then
            If iVenta = True Then
               iMontoCnv = Round(BacDiv(iMontoMon, iParidadMx), 4)
            Else
               iMontoCnv = Round(iMontoMon * iParidadMx, 4)
            End If
         Else
            If iVenta = True Then
               iMontoCnv = Round(iMontoMon * iParidadMx, 4)
            Else
               iMontoCnv = Round(BacDiv(iMontoMon, iParidadMx), 4)
            End If
         End If
      Else
         'Recibo MX Entrego USD
         If iMnRrda = "D" Then
            If iVenta = True Then
               iMontoCnv = Round(iMontoMon * iParidadMx, 4)
            Else
               iMontoCnv = Round(BacDiv(iMontoMon, iParidadMx), 4)
            End If
         Else
            If iVenta = True Then
               iMontoCnv = Round(BacDiv(iMontoMon, iParidadMx), 4)
            Else
               iMontoCnv = Round(iMontoMon * iParidadMx, 4)
            End If
         End If
      End If
   End If

   If iMoneda = 13 Then
     ' txtCapitalVenta.CantidadDecimales = iDecimales
      If iVenta = True Then
         txtCapitalCompra.Text = iMontoCnv
      Else
         txtCapitalVenta.Text = iMontoCnv
      End If
   Else
     ' txtCapitalVenta.CantidadDecimales = iDecimales
      If iVenta = True Then
         txtCapitalCompra.Text = iMontoCnv
      Else
         txtCapitalVenta.Text = iMontoCnv
      End If
   End If
   
End Function

Function calculamontoMx(cTipOpe As String, nMto As Double, nTCambio As Double, nCodMon As Integer, cSwchMx As String, cRdda As String) As Double
   Dim nMtoCnv       As Double
   Dim nParidad      As Double


   If UCase(cTipOpe) = "C" And cSwMxV = "C" And cmbMonedaVenta.ItemData(cmbMonedaVenta.ListIndex) <> 13 Then
      nParidad = txtValorMonedaVenta.Text  'F_Trae_paridad_bcch(cMonedaVen$, Format(gsBAC_Fecp, "yyyymmdd"))
      If cRdda = "D" Then
         nMtoCnv = Round(BacDiv(nMto, nParidad), 2)
      Else
         nMtoCnv = Round(nMto * nParidad, 2)
      End If
   ElseIf UCase(cTipOpe) = "V" And cSwMxV = "C" And cmbMonedaVenta.ItemData(cmbMonedaVenta.ListIndex) <> 13 Then
      nParidad = txtValorMonedaVenta.Text  'F_Trae_paridad_bcch(cMonedaVen$, Format(gsBAC_Fecp, "yyyymmdd"))
      If cRdda = "D" Then
         nMtoCnv = Round(nMto * nParidad, 2)
      Else
         nMtoCnv = Round(BacDiv(nMto, nParidad), 2)
      End If
   End If
   calculamontoMx = nMtoCnv
Exit Function

End Function


Function CalculaMonto(xTipOpe As String, nMonto As Double, nTCambio As Double, nCodMon As Integer) As Double
    Dim nMtoCnv#, nTCcnv#, nCodCnv%
    Dim nParidad#
    Dim cMon$
    Dim cSMx$
    '****************************************************************
    '* Calcula monto de Conversion de Moneda base a Moneda de Contraparte *
    '****************************************************************
    nCodCnv = 0
    nTCcnv = 0
    
    If UCase(xTipOpe) = "C" Then
    
      If cmbMonedaVenta.ListIndex <> -1 Then
        nCodCnv = cmbMonedaVenta.ItemData(cmbMonedaVenta.ListIndex)
        nTCcnv = Me.txtValorMonedaVenta.Text  ' CDbl(lblTcVenta.Tag)
        cMon$ = cMonedaVen$
        cSMx$ = cSwMxC
      End If
      
    Else
    
      If cmbMonedaCompra.ListIndex <> -1 Then
        nCodCnv = cmbMonedaCompra.ItemData(cmbMonedaCompra.ListIndex)
        nTCcnv = txtValorMonedaCompra.Text  ' CDbl(lblTcCompra.Tag)
        cMon$ = cMonedaCom$
        cSMx$ = cSwMxV
      End If
      
    End If


    '---- Convierte de Mon a Cnv
    If nCodMon = 13 Then
    
        If nCodCnv = 998 Or nCodCnv = 999 Or nCodCnv = 995 Then '--- Es Moneda Local
            nMtoCnv = Round(Round(nMonto * nTCambio, 0) / IIf(nTCcnv = 0, 1, nTCcnv), 4)
        ElseIf nEquivUSD$ = "1" Then
            'nMtoCnv = Round(BacDiv(nMonto, nTCcnv), 2)
            nMtoCnv = Round(BacDiv((nMonto * nTCambio), nTCcnv), 2)
        Else
            nMtoCnv = Round(nMonto * nTCcnv, 2)
        End If
            
    Else
    
        If nCodMon = 998 Or nCodMon = 999 Or nCodMon = 995 Then '--- Es Moneda Local
            nMtoCnv = Round(Round(nMonto * nTCambio, 0) / IIf(nTCcnv = 0, 1, nTCcnv), 2)
        ElseIf nEquivUSD$ = "1" Then
            'nMtoCnv = Round(nMonto * nTCambio, 2)
            nMtoCnv = Round(BacDiv((nMonto * nTCambio), nTCcnv), 2)
        Else
            nMtoCnv = Round(BacDiv(nMonto, nTCambio), 2)
        End If
        
    End If
CalculaMonto = nMtoCnv
End Function


Private Function Conversion(ByVal Compra As Boolean) As Double
   Dim MisMonedas    As New ClsMoneda
   '>> Compra / Lado Derecho del FRM
   Dim MonedaM1      As Integer
   Dim MontoM1       As Double
   Dim ParidadM1     As Double
   Dim ValMoneda1    As Double
   Dim mnRRda1       As String
   '>> Venta / Lado Izquierdo del FRM
   Dim MonedaM2      As Integer
   Dim MontoM2       As Double
   Dim ParidadM2     As Double
   Dim ValMoneda2    As Double
   Dim mnRRda2       As String
      
     
   
   '>> Compra / Lado Derecho del FRM
   MonedaM1 = cmbMonedaCompra.ItemData(cmbMonedaCompra.ListIndex)
   MontoM1 = txtCapitalCompra.Text
   Call MisMonedas.LeerxCodigo(MonedaM1)
   mnRRda1 = MisMonedas.mnrrda
   If MonedaM1 <> 13 And MonedaM1 <> 999 And MonedaM1 <> 998 Then
      ParidadM1 = txtValorMonedaCompra.Text
   Else
      ParidadM1 = ParidadMoneda(MonedaM1)
      ValMoneda1 = txtValorMonedaCompra.Text
   End If
   If MonedaM1 = 999 Or MonedaM1 = 998 Or MonedaM1 = 13 Or MonedaM1 = 994 Or MonedaM1 = 997 Then
      txtValorMonedaCompra.Enabled = False
   Else
      txtValorMonedaCompra.Enabled = True
   End If
   
   '>> Venta / Lado Derecho del FRM
   MonedaM2 = cmbMonedaVenta.ItemData(cmbMonedaVenta.ListIndex)
   MontoM2 = txtCapitalVenta.Text
   Call MisMonedas.LeerxCodigo(MonedaM2)
   mnRRda2 = MisMonedas.mnrrda
   If MonedaM2 <> 13 And MonedaM2 <> 999 And MonedaM2 <> 998 Then
      ParidadM2 = txtValorMonedaVenta.Text
   Else
      ParidadM2 = ParidadMoneda(MonedaM2)
      ValMoneda2 = txtValorMonedaVenta.Text
   End If
   If MonedaM2 = 999 Or MonedaM2 = 998 Or MonedaM2 = 13 Or MonedaM2 = 994 Or MonedaM2 = 997 Then
      txtValorMonedaVenta.Enabled = False
   Else
      txtValorMonedaVenta.Enabled = True
   End If
   
   
   '>> Digita monto Compra Lado Derecho
   If Compra = True Then
      If mnRRda1 = "M" Then
         MontoM2 = MontoM1 * ParidadM1
         If mnRRda2 = "M" Then
            MontoM2 = BacDiv(MontoM2, ParidadM2)
         Else
            MontoM2 = MontoM2 * ParidadM2
         End If
      Else
         MontoM2 = BacDiv(MontoM1, ParidadM1)
         If mnRRda2 = "M" Then
            MontoM2 = BacDiv(MontoM2, ParidadM2)
         Else
            MontoM2 = MontoM2 * ParidadM2
         End If
      End If
      
      If MonedaM2 = 999 Then
         txtCapitalVenta.Text = Round(MontoM2, 0)
      Else
         txtCapitalVenta.Text = Round(MontoM2, 4)
      End If
   End If
   
   '>> Digita monto Venta Lado Izquierdo
   If Compra = False Then
      If mnRRda2 = "M" Then
         MontoM1 = MontoM2 * ParidadM2
         If mnRRda1 = "M" Then
            MontoM1 = BacDiv(MontoM1, ParidadM1)
         Else
            MontoM1 = MontoM1 * ParidadM1
         End If
      Else
         MontoM1 = BacDiv(MontoM2, ParidadM2)
         If mnRRda1 = "M" Then
            MontoM1 = BacDiv(MontoM1, ParidadM1)
         Else
            MontoM1 = MontoM1 * ParidadM1
         End If
      End If
   
      If MonedaM1 = 999 Then
         txtCapitalCompra.Text = Round(MontoM1, 0)
      Else
         txtCapitalCompra.Text = Round(MontoM1, 4)
      End If
   End If
   
   Set MisMonedas = Nothing
End Function

Private Function ParidadMoneda(ByVal Codigo As Integer) As Double
   Dim Datos()
   
   ParidadMoneda = 0#
   
   If Codigo = 999 Then
      ParidadMoneda = gsBAC_DolarObs
      Exit Function
   End If
   If Codigo = 998 Then
      ParidadMoneda = gsBAC_DolarObs / gsBAC_ValmonUF
      Exit Function
   End If
   If Codigo = 13 Then
      ParidadMoneda = 1
      Exit Function
   End If
   
   Envia = Array()
   AddParam Envia, Codigo
   AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
   If Not Bac_Sql_Execute("SP_LEER_VALORMONEDA", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      ParidadMoneda = CDbl(Datos(4))
   Else
      ParidadMoneda = 0#
   End If
End Function

