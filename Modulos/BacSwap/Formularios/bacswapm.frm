VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{297EB2E9-9343-11D5-B8DF-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form BacOpeSwapMoneda 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Swap de Monedas"
   ClientHeight    =   7395
   ClientLeft      =   660
   ClientTop       =   1125
   ClientWidth     =   10710
   Icon            =   "bacswapm.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   7395
   ScaleWidth      =   10710
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   45
      TabIndex        =   84
      Top             =   0
      Width           =   10620
      _ExtentX        =   18733
      _ExtentY        =   847
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
            Object.ToolTipText     =   "Calcula Flujos"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Limpia"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Grabar"
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
      Begin VB.Label Label1 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Label1"
         Height          =   240
         Left            =   4140
         TabIndex        =   85
         Top             =   540
         Width           =   1320
      End
   End
   Begin VB.Frame Frame2 
      Height          =   750
      Index           =   0
      Left            =   0
      TabIndex        =   56
      Top             =   6525
      Width           =   10650
      Begin VB.Frame framBarra 
         Height          =   510
         Left            =   90
         TabIndex        =   63
         Top             =   180
         Visible         =   0   'False
         Width           =   5190
         Begin ComctlLib.ProgressBar Barra 
            Height          =   240
            Left            =   90
            TabIndex        =   64
            Top             =   180
            Width           =   5010
            _ExtentX        =   8837
            _ExtentY        =   423
            _Version        =   327682
            Appearance      =   1
         End
      End
      Begin VB.CommandButton cmdCalcula 
         Caption         =   "&Calcula Flujos"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   800
         Left            =   5355
         Picture         =   "bacswapm.frx":08CA
         Style           =   1  'Graphical
         TabIndex        =   12
         Top             =   1275
         Visible         =   0   'False
         Width           =   1300
      End
      Begin VB.CommandButton cmdLimpia 
         Caption         =   "&Limpia"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   800
         Left            =   6660
         Picture         =   "bacswapm.frx":0BD4
         Style           =   1  'Graphical
         TabIndex        =   18
         Top             =   1275
         Visible         =   0   'False
         Width           =   1300
      End
      Begin VB.CommandButton cmdGrabar 
         Caption         =   "&Grabar"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   800
         Left            =   7965
         Picture         =   "bacswapm.frx":0EDE
         Style           =   1  'Graphical
         TabIndex        =   16
         Top             =   1275
         Visible         =   0   'False
         Width           =   1300
      End
      Begin VB.CommandButton cmdSalir 
         Caption         =   "&Salir"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   800
         Left            =   9250
         Picture         =   "bacswapm.frx":1320
         Style           =   1  'Graphical
         TabIndex        =   17
         Top             =   1275
         Visible         =   0   'False
         Width           =   1300
      End
      Begin VB.Label Simbologia 
         BackColor       =   &H00FFFFC0&
         BorderStyle     =   1  'Fixed Single
         Height          =   240
         Left            =   6300
         TabIndex        =   59
         Top             =   315
         Visible         =   0   'False
         Width           =   240
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Flujos Vencidos"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   28
         Left            =   6615
         TabIndex        =   58
         Top             =   315
         Visible         =   0   'False
         Width           =   1395
      End
      Begin VB.Label EtqMensaje 
         Caption         =   "EtqMensaje"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   285
         Left            =   360
         TabIndex        =   57
         Top             =   360
         Width           =   3885
      End
   End
   Begin VB.Frame Frame1 
      Height          =   3510
      Left            =   45
      TabIndex        =   21
      Top             =   495
      Width           =   3525
      Begin Threed.SSPanel etqNumOper 
         Height          =   375
         Left            =   240
         TabIndex        =   86
         Top             =   720
         Width           =   615
         _Version        =   65536
         _ExtentX        =   1085
         _ExtentY        =   661
         _StockProps     =   15
         Caption         =   "SSPanel1"
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.24
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.OptionButton optCompra 
         Caption         =   "&Compramos"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   405
         Left            =   165
         Style           =   1  'Graphical
         TabIndex        =   0
         ToolTipText     =   "Tipo de Operación ... Compra/Venta"
         Top             =   195
         Value           =   -1  'True
         Width           =   1575
      End
      Begin VB.OptionButton optVenta 
         Caption         =   "&Vendemos"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   420
         Left            =   1815
         Style           =   1  'Graphical
         TabIndex        =   1
         ToolTipText     =   "Tipo de Operación ... Compra/Venta"
         Top             =   180
         Width           =   1575
      End
      Begin VB.ComboBox cmbOperador 
         Height          =   315
         Left            =   150
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   23
         ToolTipText     =   "Operador de Cliente (si no hay opciones, defina Cliente)"
         Top             =   3000
         Width           =   3225
      End
      Begin VB.TextBox txtCliente 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   150
         MaxLength       =   50
         MouseIcon       =   "bacswapm.frx":162A
         TabIndex        =   20
         ToolTipText     =   "Nombre de Cliente (Doble Click invoca ayuda)"
         Top             =   2160
         Width           =   3240
      End
      Begin VB.TextBox txtRut 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   1755
         MouseIcon       =   "bacswapm.frx":1934
         TabIndex        =   19
         ToolTipText     =   "Rut de Cliente (Doble Click invoca ayuda)"
         Top             =   1680
         Width           =   1635
      End
      Begin VB.Label lblMonedas 
         Alignment       =   2  'Center
         Caption         =   "USD / UFR"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   510
         TabIndex        =   51
         Top             =   1080
         Width           =   2415
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Cliente"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   21
         Left            =   120
         TabIndex        =   41
         Top             =   1680
         Width           =   720
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Operador"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   20
         Left            =   150
         TabIndex        =   40
         Top             =   2640
         Width           =   780
      End
   End
   Begin VB.Frame frmVendimos 
      Caption         =   "Vendemos ..."
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000C0&
      Height          =   3570
      Left            =   7155
      TabIndex        =   29
      Top             =   450
      Width           =   3465
      Begin BACControles.TXTNumero txtSpreadVenta 
         Height          =   285
         Left            =   2055
         TabIndex        =   78
         Top             =   1920
         Width           =   1020
         _ExtentX        =   1799
         _ExtentY        =   503
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
         Max             =   "999.999999"
      End
      Begin BACControles.TXTNumero txtTasaVenta 
         Height          =   285
         Left            =   2040
         TabIndex        =   77
         Top             =   1560
         Width           =   1035
         _ExtentX        =   1826
         _ExtentY        =   503
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
         Max             =   "999.999999"
      End
      Begin BACControles.TXTNumero txtCapitalVenta 
         Height          =   300
         Left            =   840
         TabIndex        =   76
         Top             =   765
         Width           =   2415
         _ExtentX        =   4260
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
      End
      Begin VB.ComboBox cmbMonedaVenta 
         Height          =   315
         Left            =   840
         Style           =   2  'Dropdown List
         TabIndex        =   3
         ToolTipText     =   "Moneda Capital Venta"
         Top             =   360
         Width           =   1545
      End
      Begin VB.ComboBox cmbTasaVenta 
         Height          =   315
         Left            =   1560
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   6
         ToolTipText     =   "Tasa de Negocio"
         Top             =   1155
         Width           =   1785
      End
      Begin VB.ComboBox cmbBaseVenta 
         Height          =   315
         Left            =   2010
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   7
         ToolTipText     =   "Base en que se encuentra expresada Tasa (para calculo de intereses)"
         Top             =   2295
         Width           =   1305
      End
      Begin VB.ComboBox cmbMonedaPagamos 
         Height          =   315
         Left            =   1320
         Style           =   2  'Dropdown List
         TabIndex        =   10
         ToolTipText     =   "Moneda con equivalente del documento"
         Top             =   2760
         Width           =   2000
      End
      Begin VB.ComboBox cmbDocumentoPagamos 
         Height          =   315
         Left            =   1320
         Style           =   2  'Dropdown List
         TabIndex        =   11
         ToolTipText     =   "Documento con el que Pagaremos"
         Top             =   3120
         Width           =   2000
      End
      Begin VB.Label lblTcVenta 
         Alignment       =   2  'Center
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   375
         Left            =   2400
         TabIndex        =   55
         Top             =   360
         Width           =   975
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Capital"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   27
         Left            =   120
         TabIndex        =   50
         Top             =   795
         Width           =   585
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   26
         Left            =   120
         TabIndex        =   49
         Top             =   405
         Width           =   630
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Spread"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   25
         Left            =   120
         TabIndex        =   46
         Top             =   1965
         Width           =   1035
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "%"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   24
         Left            =   3120
         TabIndex        =   45
         Top             =   1965
         Width           =   195
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Tasa"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   14
         Left            =   120
         TabIndex        =   34
         Top             =   1200
         Width           =   555
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Valor Tasa"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   13
         Left            =   120
         TabIndex        =   33
         Top             =   1605
         Width           =   1035
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "%"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   12
         Left            =   3120
         TabIndex        =   32
         Top             =   1560
         Width           =   195
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Base Tasa"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   11
         Left            =   120
         TabIndex        =   31
         Top             =   2340
         Width           =   1035
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Pagamos ..."
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   10
         Left            =   120
         TabIndex        =   30
         Top             =   2760
         Width           =   1275
      End
   End
   Begin VB.Frame frmCompramos 
      Caption         =   "Compramos ..."
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   3570
      Left            =   3630
      TabIndex        =   22
      Top             =   450
      Width           =   3495
      Begin BACControles.TXTNumero txtSpreadCompra 
         Height          =   285
         Left            =   2040
         TabIndex        =   75
         Top             =   1920
         Width           =   1020
         _ExtentX        =   1799
         _ExtentY        =   503
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
         Max             =   "999.999999"
      End
      Begin BACControles.TXTNumero txtTasaCompra 
         Height          =   285
         Left            =   2040
         TabIndex        =   74
         Top             =   1560
         Width           =   1020
         _ExtentX        =   1799
         _ExtentY        =   503
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
         Max             =   "999.999999"
      End
      Begin BACControles.TXTNumero txtCapitalCompra 
         Height          =   300
         Left            =   840
         TabIndex        =   73
         Top             =   765
         Width           =   2415
         _ExtentX        =   4260
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
         Min             =   "-999999999999.99990"
         Max             =   "999999999999.9999"
      End
      Begin VB.ComboBox cmbMonedaCompra 
         Height          =   315
         Left            =   840
         Style           =   2  'Dropdown List
         TabIndex        =   2
         ToolTipText     =   "Moneda Capital"
         Top             =   360
         Width           =   1545
      End
      Begin VB.ComboBox cmbDocumentoRecibimos 
         Height          =   315
         Left            =   1320
         Style           =   2  'Dropdown List
         TabIndex        =   9
         ToolTipText     =   "Documento que Recibiremos"
         Top             =   3120
         Width           =   2000
      End
      Begin VB.ComboBox cmbMonedaRecibimos 
         Height          =   315
         Left            =   1320
         Style           =   2  'Dropdown List
         TabIndex        =   8
         ToolTipText     =   "Moneda con equivalente del documento"
         Top             =   2760
         Width           =   2000
      End
      Begin VB.ComboBox cmbBaseCompra 
         Height          =   315
         Left            =   2010
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   5
         ToolTipText     =   "Base en que se encuentra expresada Tasa (para calculo de intereses)"
         Top             =   2310
         Width           =   1305
      End
      Begin VB.ComboBox cmbTasaCompra 
         Height          =   315
         Left            =   1560
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   4
         ToolTipText     =   "Tasa de Negocio"
         Top             =   1155
         Width           =   1785
      End
      Begin VB.Label lblTcCompra 
         Alignment       =   2  'Center
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   375
         Left            =   2400
         TabIndex        =   54
         Top             =   360
         Width           =   975
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   0
         Left            =   120
         TabIndex        =   48
         Top             =   405
         Width           =   630
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Capital"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   1
         Left            =   120
         TabIndex        =   47
         Top             =   795
         Width           =   585
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Spread"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   23
         Left            =   120
         TabIndex        =   44
         Top             =   1965
         Width           =   1035
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "%"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   22
         Left            =   3120
         TabIndex        =   43
         Top             =   1965
         Width           =   195
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Recibimos ..."
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   9
         Left            =   120
         TabIndex        =   28
         Top             =   2760
         Width           =   1275
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Base Tasa"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   8
         Left            =   120
         TabIndex        =   27
         Top             =   2340
         Width           =   1035
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "%"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   7
         Left            =   3120
         TabIndex        =   26
         Top             =   1560
         Width           =   195
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Valor Tasa"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   6
         Left            =   120
         TabIndex        =   25
         Top             =   1605
         Width           =   1035
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Tasa"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   5
         Left            =   120
         TabIndex        =   24
         Top             =   1200
         Width           =   555
      End
   End
   Begin TabDlg.SSTab tabFlujos 
      Height          =   2445
      Left            =   30
      TabIndex        =   35
      Top             =   4080
      Width           =   10665
      _ExtentX        =   18812
      _ExtentY        =   4313
      _Version        =   393216
      TabHeight       =   520
      BackColor       =   -2147483644
      TabCaption(0)   =   "Definiciones"
      TabPicture(0)   =   "bacswapm.frx":1C3E
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "lblSwapTasa(3)"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "lblSwapTasa(2)"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "lblSwapTasa(18)"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "lblSwapTasa(19)"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "lblSwapTasa(4)"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).Control(5)=   "lblFechaTermino"
      Tab(0).Control(5).Enabled=   0   'False
      Tab(0).Control(6)=   "lblFechaPrimerAmort"
      Tab(0).Control(6).Enabled=   0   'False
      Tab(0).Control(7)=   "lblFechaInicio"
      Tab(0).Control(7).Enabled=   0   'False
      Tab(0).Control(8)=   "optEntFisica"
      Tab(0).Control(8).Enabled=   0   'False
      Tab(0).Control(9)=   "optCompensa"
      Tab(0).Control(9).Enabled=   0   'False
      Tab(0).Control(10)=   "cmbCarteraInversion"
      Tab(0).Control(10).Enabled=   0   'False
      Tab(0).Control(11)=   "Frame2(1)"
      Tab(0).Control(11).Enabled=   0   'False
      Tab(0).Control(12)=   "Frame3"
      Tab(0).Control(12).Enabled=   0   'False
      Tab(0).Control(13)=   "txtFecInicio"
      Tab(0).Control(13).Enabled=   0   'False
      Tab(0).Control(14)=   "txtFecPrimerVcto"
      Tab(0).Control(14).Enabled=   0   'False
      Tab(0).Control(15)=   "txtFecTermino"
      Tab(0).Control(15).Enabled=   0   'False
      Tab(0).ControlCount=   16
      TabCaption(1)   =   "Flujos Compramos"
      TabPicture(1)   =   "bacswapm.frx":1C5A
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "fgFlujosCompra"
      Tab(1).Control(1)=   "cmbModalidad"
      Tab(1).Control(2)=   "txtAmortiza"
      Tab(1).ControlCount=   3
      TabCaption(2)   =   "Flujos Vendemos"
      TabPicture(2)   =   "bacswapm.frx":1C76
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "fgFlujosVenta"
      Tab(2).Control(1)=   "cmbModalidadVen"
      Tab(2).Control(2)=   "txtAmortizaVen"
      Tab(2).ControlCount=   3
      Begin BACControles.TXTNumero txtAmortizaVen 
         Height          =   255
         Left            =   -73800
         TabIndex        =   83
         Top             =   720
         Visible         =   0   'False
         Width           =   1695
         _ExtentX        =   2990
         _ExtentY        =   450
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   0
         Text            =   "0"
         Text            =   "0"
         Max             =   "9999999999.9999"
      End
      Begin BACControles.TXTNumero txtAmortiza 
         Height          =   255
         Left            =   -73800
         TabIndex        =   82
         Top             =   600
         Visible         =   0   'False
         Width           =   1695
         _ExtentX        =   2990
         _ExtentY        =   450
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   0
         Text            =   "0"
         Text            =   "0"
      End
      Begin BACControles.TXTFecha txtFecTermino 
         Height          =   300
         Left            =   2280
         TabIndex        =   81
         Top             =   1965
         Width           =   1215
         _ExtentX        =   2143
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "25/10/2000"
      End
      Begin BACControles.TXTFecha txtFecPrimerVcto 
         Height          =   300
         Left            =   2280
         TabIndex        =   80
         Top             =   1605
         Width           =   1215
         _ExtentX        =   2143
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "25/10/2000"
      End
      Begin BACControles.TXTFecha txtFecInicio 
         Height          =   300
         Left            =   2280
         TabIndex        =   79
         Top             =   1245
         Width           =   1215
         _ExtentX        =   2143
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "25/10/2000"
      End
      Begin VB.Frame Frame3 
         Caption         =   "Amortización de ..."
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   735
         Left            =   270
         TabIndex        =   65
         Top             =   405
         Width           =   6135
         Begin VB.ComboBox cmbAmortizaInteres 
            Height          =   315
            Left            =   3900
            Style           =   2  'Dropdown List
            TabIndex        =   68
            ToolTipText     =   "Período de Amortización de Intereses"
            Top             =   315
            Width           =   2000
         End
         Begin VB.ComboBox cmbAmortizaCapital 
            Height          =   315
            Left            =   930
            Style           =   2  'Dropdown List
            TabIndex        =   66
            ToolTipText     =   "Período de Amortización de Capital"
            Top             =   315
            Width           =   2000
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   "Interés"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   225
            Index           =   17
            Left            =   3195
            TabIndex        =   69
            Top             =   360
            Width           =   585
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   "Capital"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   225
            Index           =   16
            Left            =   225
            TabIndex        =   67
            Top             =   360
            Width           =   585
         End
      End
      Begin VB.Frame Frame2 
         Height          =   1860
         Index           =   1
         Left            =   6525
         TabIndex        =   62
         Top             =   405
         Width           =   15
      End
      Begin VB.ComboBox cmbModalidadVen 
         Height          =   315
         Left            =   -68610
         Style           =   2  'Dropdown List
         TabIndex        =   61
         ToolTipText     =   "Con tecla Enter acepta modificación"
         Top             =   540
         Visible         =   0   'False
         Width           =   1445
      End
      Begin VB.ComboBox cmbModalidad 
         Height          =   315
         Left            =   -66270
         Style           =   2  'Dropdown List
         TabIndex        =   60
         ToolTipText     =   "Con tecla Enter acepta modificación"
         Top             =   1035
         Visible         =   0   'False
         Width           =   1445
      End
      Begin MSFlexGridLib.MSFlexGrid fgFlujosVenta 
         Height          =   1965
         Left            =   -74865
         TabIndex        =   53
         Top             =   360
         Width           =   10425
         _ExtentX        =   18389
         _ExtentY        =   3466
         _Version        =   393216
         BackColor       =   12632256
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         GridColor       =   16777215
         GridLines       =   2
      End
      Begin MSFlexGridLib.MSFlexGrid fgFlujosCompra 
         Height          =   1965
         Left            =   -74865
         TabIndex        =   52
         Top             =   360
         Width           =   10425
         _ExtentX        =   18389
         _ExtentY        =   3466
         _Version        =   393216
         FixedCols       =   0
         BackColor       =   12632256
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         GridColor       =   16777215
         GridLines       =   2
      End
      Begin VB.ComboBox cmbCarteraInversion 
         Height          =   315
         Left            =   8490
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   15
         ToolTipText     =   "Cartera de Inversión"
         Top             =   1740
         Width           =   1935
      End
      Begin VB.OptionButton optCompensa 
         Caption         =   "&Compensación"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   435
         Left            =   8460
         Style           =   1  'Graphical
         TabIndex        =   13
         ToolTipText     =   "Modalidad de Pago de Contrato y/o Flujos"
         Top             =   585
         Value           =   -1  'True
         Width           =   1900
      End
      Begin VB.OptionButton optEntFisica 
         Caption         =   "&Entrega Física"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   435
         Left            =   8460
         Style           =   1  'Graphical
         TabIndex        =   14
         ToolTipText     =   "Modalidad de Pago de Contrato y/o Flujos"
         Top             =   1065
         Width           =   1900
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
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   285
         Left            =   3555
         TabIndex        =   72
         Top             =   1260
         Width           =   2580
      End
      Begin VB.Label lblFechaPrimerAmort 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "lblFechaPrimerAmort"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   285
         Left            =   3555
         TabIndex        =   71
         Top             =   1620
         Width           =   2580
      End
      Begin VB.Label lblFechaTermino 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "lblFechaTermino"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   285
         Left            =   3555
         TabIndex        =   70
         Top             =   1980
         Width           =   2580
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Cartera de Inversión"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   4
         Left            =   6690
         TabIndex        =   42
         Top             =   1740
         Width           =   1680
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Modalidad de Pago"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   19
         Left            =   6735
         TabIndex        =   39
         Top             =   1005
         Width           =   1500
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Prim. Amort. Capital"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   18
         Left            =   390
         TabIndex        =   38
         Top             =   1665
         Width           =   1710
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Inicio"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   2
         Left            =   390
         TabIndex        =   37
         Top             =   1320
         Width           =   990
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Término"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   3
         Left            =   390
         TabIndex        =   36
         Top             =   2010
         Width           =   1230
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   5580
      Top             =   6750
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
            Picture         =   "bacswapm.frx":1C92
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacswapm.frx":1FAC
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacswapm.frx":22C6
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacswapm.frx":25E0
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacOpeSwapMoneda"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim cMonedaCom$
Dim cMonedaVen$
Dim nEquivUSD$
Dim cTipoOperacion$
Dim nDiasInteres#
Dim nDiasCapital#
Dim PasoTexto  As String
Dim cModalidad As String
Dim nNumOper   As Integer
Dim cOperSwap  As String
Dim lEntrada   As Boolean
Dim OperSwap As String
Dim FechaCierre As Date
Dim ValorDolarObs  As Double
Dim DatosPorMoneda()
Dim TotDatPorMon As Double

Private objCodigo As New clsCodigo
Private objMoneda As New clsMoneda
Private objFPago  As New clsForPago
Dim ValorAnt As String
Dim ValorUlt As String


Function ValidaFechasIngreso(Cual) As Boolean

    ValidaFechasIngreso = False

    Select Case Cual
        Case 1
            
            Call CalculaFechas
        
        Case 2
    
            lblFechaPrimerAmort = BacFechaStr(txtFecPrimerVcto.Text)
            If Format(txtFecInicio.Text, "yyyymmdd") >= Format(txtFecPrimerVcto.Text, "yyyymmdd") Then
                MsgBox "Fecha Vencimiento Primera Amort. Capital debe ser Mayor que la Fecha de Inicio", vbInformation, Msj
                txtFecPrimerVcto.SetFocus
                Exit Function
            ElseIf Format(txtFecPrimerVcto.Text, "yyyymmdd") <= Format(gsBAC_Fecp, "yyyymmdd") Then
                MsgBox "Fecha Primer Vencimiento por Amortización de Capital" & vbCrLf & "debe ser Mayor que la Fecha de Proceso", vbInformation, Msj
                txtFecPrimerVcto.Text = txtFecTermino.Text
                txtFecPrimerVcto.SetFocus
                Exit Function
            ElseIf Not BacEsHabil(CStr(txtFecPrimerVcto.Text)) Then
                MsgBox "Fecha Primer Vencimiento de Capital no es día Hábil", vbCritical, Msj
                txtFecPrimerVcto.SetFocus
                Exit Function
            End If
        
        Case 3
        
            lblFechaTermino = BacFechaStr(txtFecTermino.Text)
            If CDate(txtFecPrimerVcto.Text) > CDate(txtFecTermino.Text) Then
               MsgBox "Fecha Termino debe ser Mayor que la Fecha del primer Vencimiento", vbInformation, Msj
               txtFecPrimerVcto.SetFocus
               Exit Function
            ElseIf Not BacEsHabil(CStr(txtFecTermino.Text)) Then
                MsgBox "Fecha de Término no es día hábil", vbCritical, Msj
                txtFecTermino.SetFocus
                Me.MousePointer = 0
                Exit Function
            ElseIf Not ValidaPeriodos Then
                txtFecTermino.SetFocus
                Me.MousePointer = 0
                Exit Function
            End If
                
    End Select

    ValidaFechasIngreso = True

End Function

'********************************************************
Private Function ValidaPeriodos() As Boolean
Dim dFechaVencimiento, UltimoVcto As Date
Dim nPlazoMin%
Dim DiaVcto  As Integer

    cmdCalcula.Enabled = False

    Me.MousePointer = 11
    
    ValidaPeriodos = False
    If False Then
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
    End If
    
    nPlazoMin = IIf(nDiasCapital > nDiasInteres, nDiasInteres, IIf(nDiasCapital <= 0, 1, nDiasCapital))
    
    dFechaVencimiento = DateAdd("m", nDiasCapital, txtFecInicio.Text)

    If Not BacEsHabil(CStr(dFechaVencimiento)) Then
        dFechaVencimiento = BacProxHabil(CStr(dFechaVencimiento))
    End If
    If dFechaVencimiento = CDate(txtFecPrimerVcto.Text) Then
        dFechaVencimiento = DateAdd("m", nPlazoMin, txtFecInicio.Text)
        If Not BacEsHabil(CStr(dFechaVencimiento)) Then
            dFechaVencimiento = BacProxHabil(CStr(dFechaVencimiento))
        End If
    Else
        dFechaVencimiento = CDate(txtFecPrimerVcto.Text)
    End If
    
    DiaVcto = Day(txtFecPrimerVcto.Text)
    
    While CDate(dFechaVencimiento) <= CDate(txtFecTermino.Text)
        UltimoVcto = dFechaVencimiento
        dFechaVencimiento = CreaFechaProx(dFechaVencimiento, nPlazoMin, DiaVcto)
    Wend
    
    If CDate(UltimoVcto) <> CDate(txtFecTermino.Text) Then
        If Abs(DateDiff("d", CDate(UltimoVcto), CDate(txtFecTermino.Text))) > 10 Then
            Me.MousePointer = 0
            MsgBox "Fecha Termino de Contrato NO concuerda con períodos de Amortización", vbInformation, Msj
            Exit Function
        End If
    End If
    
    Me.MousePointer = 0
    cmdCalcula.Enabled = True
    ValidaPeriodos = True

End Function

Function BuscaCliente(RutCli As Long)
Dim Cliente As New clsCliente
    
    If Cliente.LeerxRut(RutCli, 0) Then
        txtRut.MaxLength = 13
        txtRut = Format(Cliente.clrut, "###,###,###") & "-" & Cliente.cldv
        txtCliente = Cliente.clnombre
        txtCliente.Tag = Cliente.clcodigo
    Else
        MsgBox "Rut  no ha sido encontrado en datos de Cliente", vbInformation, Msj
        txtRut.SetFocus
    End If
    
    Set Cliente = Nothing

End Function

Function BuscarDatos()

    Dim Mantencion As New clsMantencionSwap
    Dim RutPaso As String
    Dim total As Double
    Dim i, Hasta, desde, j As Integer
    
    Call InicializaGrid(fgFlujosCompra)
    Call InicializaGrid(fgFlujosVenta)
    
    fgFlujosCompra.Rows = 1
    fgFlujosVenta.Rows = 1
    desde = 1
    j = 1
    
    With Mantencion
        
    If cOperSwap = "ModificacionCartera" Then
        
        'Busca datos en cartera  historica - movimientos vencidos
        .NumOperacion = nNumOper
        .TipoOperacion = 4
        If Not .LeerDatos Then
            Set Mantencion = Nothing
        
        ElseIf .coleccion.Count > 0 Then
        
            Hasta = .coleccion.Count
            fgFlujosCompra.Rows = Hasta + 1
            fgFlujosVenta.Rows = Hasta + 1
            For i = desde To Hasta
                
                fgFlujosCompra.TextMatrix(i, 0) = .coleccion(i).swNumFlujo & "  "
                fgFlujosCompra.TextMatrix(i, 1) = .coleccion(i).swFechaVenceFlujo
                fgFlujosCompra.TextMatrix(i, 2) = Format(.coleccion(i).swCAmortiza, "###,###,###,##0.###0")
                fgFlujosCompra.TextMatrix(i, 3) = Format(.coleccion(i).swCInteres, "###,###,###,##0.###0")
                total = Val(.coleccion(i).swCInteres) + Val(.coleccion(i).swCAmortiza)
                fgFlujosCompra.TextMatrix(i, 4) = Format(total, "###,###,###,##0.###0")
                fgFlujosCompra.TextMatrix(i, 5) = .coleccion(i).swCSaldo
                fgFlujosCompra.TextMatrix(i, 6) = .coleccion(i).swFechaInicioFlujo

                fgFlujosCompra.TextMatrix(i, 7) = 0
                fgFlujosCompra.TextMatrix(i, 8) = 0
                fgFlujosCompra.TextMatrix(i, 9) = "CH"              'Datos Cartera Historica
                fgFlujosCompra.TextMatrix(i, 10) = IIf(.coleccion(i).swModalidadPago = "C", "Compensación" & Space(50) & "C" _
                                                    , "Ent. Fisica" & Space(50) & "E")
                total = 0
                
                fgFlujosVenta.TextMatrix(i, 0) = .coleccion(i).swNumFlujo & "  "
                fgFlujosVenta.TextMatrix(i, 1) = .coleccion(i).swFechaVenceFlujo
                fgFlujosVenta.TextMatrix(i, 2) = Format(.coleccion(i).swVAmortiza, "###,###,###,##0.###0")
                fgFlujosVenta.TextMatrix(i, 3) = Format(.coleccion(i).swVInteres, "###,###,###,##0.###0")
                total = Val(.coleccion(i).swVInteres) + Val(.coleccion(i).swVAmortiza)
                fgFlujosVenta.TextMatrix(i, 4) = Format(total, "###,###,###,##0.###0")
                fgFlujosVenta.TextMatrix(i, 5) = .coleccion(i).swVSaldo
                fgFlujosVenta.TextMatrix(i, 6) = .coleccion(i).swFechaInicioFlujo
                fgFlujosVenta.TextMatrix(i, 7) = 0
                fgFlujosVenta.TextMatrix(i, 8) = 0
                fgFlujosVenta.TextMatrix(i, 9) = "CH"               'Datos Cartera Historica
                fgFlujosVenta.TextMatrix(i, 10) = IIf(.coleccion(i).swModalidadPago = "C", "Compensación" & Space(50) & "C" _
                                                    , "Ent. Fisica" & Space(50) & "E")
                total = 0
                
            Next i
            
            j = fgFlujosCompra.Rows
            lblSwapTasa(22).Visible = True
           ' Simbologia.Visible = True
        
        End If
        'Limpiar
        Set .coleccion = Nothing
                
    End If
              
    .NumOperacion = nNumOper
    .TipoOperacion = swModTipoOpe
    If Not .LeerDatos Then
        Set Mantencion = Nothing
        MsgBox "Operación no ha sido encontrada", vbCritical, Msj
        Exit Function
    End If
    
    'Ubica datos en la pantalla
     i = 1
    Hasta = .coleccion.Count
    etqNumOper.Tag = nNumOper
    etqNumOper.Caption = nNumOper
    
    If .coleccion(i).swTipoOperacion = "C" Then
        optCompra.Value = True
    Else
        optVenta.Value = True
    End If
    If .coleccion(1).swModalidadPago = "C" Then
        optCompensa.Value = True
    Else
        optEntFisica.Value = True
    End If
    
    txtCapitalCompra.Text = .coleccion(i).swCCapital
    txtCapitalVenta.Text = .coleccion(i).swVCapital
    txtCapitalVenta.Tag = .coleccion(i).swVCapital
    txtCapitalCompra.Tag = .coleccion(i).swCCapital
    
    FechaCierre = .coleccion(i).swFechaCierre
    txtFecTermino.Text = .coleccion(i).swFechaTermino 'swFechaCierre
    txtFecInicio.Text = .coleccion(i).swFechaInicio
    'txtFecPrimerVcto.Text = .coleccion(i).swFechaVenceFlujo
    txtTasaCompra.Text = .coleccion(i).swCValorTasa
    txtTasaVenta.Text = .coleccion(i).swVValorTasa
    
    txtSpreadCompra.Text = .coleccion(i).swCSpread
    txtSpreadVenta.Text = .coleccion(i).swVSpread
        
    Call bacBuscarCombo(cmbMonedaCompra, .coleccion(i).swCMoneda)
    Call bacBuscarCombo(cmbMonedaVenta, .coleccion(i).swVMoneda)
    Call bacBuscarCombo(cmbCarteraInversion, .coleccion(i).swCarteraInversion)
    
    Call bacBuscarCombo(cmbAmortizaCapital, .coleccion(i).swCCodAmoCapital)
    Call bacBuscarCombo(cmbAmortizaInteres, .coleccion(i).swCCodAmoInteres)
    
    Call BuscaCmbAmortiza(cmbBaseCompra, .coleccion(i).swCBase)
    Call BuscaCmbAmortiza(cmbBaseVenta, .coleccion(i).swVBase)
    
    Call bacBuscarCombo(cmbTasaCompra, .coleccion(i).swCCodigoTasa)
    Call bacBuscarCombo(cmbTasaVenta, .coleccion(i).swVCodigoTasa)
    
    Call LlenaMonDocPago(cmbMonedaRecibimos, DatosPorMoneda(), 1, _
                    .coleccion(i).swCMoneda, TotDatPorMon, 1)
    Call LlenaMonDocPago(cmbMonedaPagamos, DatosPorMoneda(), 1, _
                    .coleccion(i).swVMoneda, TotDatPorMon, 1)
    Call bacBuscarCombo(cmbMonedaPagamos, .coleccion(i).swPagMoneda)
    Call bacBuscarCombo(cmbMonedaRecibimos, .coleccion(i).swRecMoneda)
    
    Call LlenaMonDocPago(cmbDocumentoRecibimos, DatosPorMoneda(), 1, _
                    .coleccion(i).swPagMoneda, TotDatPorMon, 2)
    Call LlenaMonDocPago(cmbDocumentoPagamos, DatosPorMoneda(), 1, _
                     .coleccion(i).swRecMoneda, TotDatPorMon, 2)
    Call bacBuscarCombo(cmbDocumentoPagamos, .coleccion(i).swPagDocumento)
    Call bacBuscarCombo(cmbDocumentoRecibimos, .coleccion(i).swRecDocumento)
    
    txtCliente.Tag = .coleccion(i).swCodCliente
    txtCliente.Text = .coleccion(i).swNomCliente
    txtRut.Tag = .coleccion(i).swRutCliente
    If (.coleccion(i).swRutCliente) <> "" Then
        txtRut.Text = BacFormatoRut(.coleccion(i).swRutCliente)  'Rutpaso
    End If
    
    If .coleccion(i).swOperadorCliente <> 0 Then
    
     If InStr(1, .coleccion(i).swRutCliente, "-") > 0 Then
        .coleccion(i).swRutCliente = Left(.coleccion(i).swRutCliente, InStr(1, .coleccion(i).swRutCliente, "-") - 1)
        Call Operadores(cmbOperador, Trim(.coleccion(i).swRutCliente), .coleccion(i).swCodCliente)
        Call bacBuscarCombo(cmbOperador, .coleccion(i).swOperadorCliente)
    End If
    
   End If
   
    nDiasCapital# = 0
    nDiasInteres# = 0
    If cmbAmortizaCapital.ListIndex <> -1 Then
        nDiasCapital# = Left$(cmbAmortizaCapital.ItemData(cmbAmortizaCapital.ListIndex), 3)
    End If
    If cmbAmortizaInteres.ListIndex <> -1 Then
        nDiasInteres# = Left$(cmbAmortizaInteres.ItemData(cmbAmortizaInteres.ListIndex), 3)
    End If
    
    
    'Llenar arreglos con datos
    
    fgFlujosCompra.Rows = fgFlujosCompra.Rows + (Hasta)
    fgFlujosVenta.Rows = fgFlujosVenta.Rows + (Hasta)
    For i = 1 To Hasta
        
        fgFlujosCompra.TextMatrix(j, 0) = .coleccion(i).swNumFlujo & "  "
        fgFlujosCompra.TextMatrix(j, 1) = .coleccion(i).swFechaVenceFlujo
        fgFlujosCompra.TextMatrix(j, 2) = Format(.coleccion(i).swCAmortiza, "###,###,###,##0.###0")
        fgFlujosCompra.TextMatrix(j, 3) = Format(.coleccion(i).swCInteres, "###,###,###,##0.###0")
        total = Val(.coleccion(i).swCInteres) + Val(.coleccion(i).swCAmortiza)
        fgFlujosCompra.TextMatrix(j, 4) = Format(total, "###,###,###,##0.###0")
        fgFlujosCompra.TextMatrix(j, 5) = .coleccion(i).swCSaldo
        fgFlujosCompra.TextMatrix(j, 6) = .coleccion(i).swFechaInicioFlujo
        fgFlujosCompra.TextMatrix(j, 7) = 0
        fgFlujosCompra.TextMatrix(j, 8) = 0
        fgFlujosCompra.TextMatrix(j, 9) = "C"        'Datos de cartera
        fgFlujosCompra.TextMatrix(i, 10) = IIf(.coleccion(i).swModalidadPago = "C", "Compensación" & Space(50) & "C" _
                                            , "Ent. Fisica" & Space(50) & "E")
        fgFlujosCompra.TextMatrix(j, 11) = .coleccion(i).swPagMontoUSD
        fgFlujosCompra.TextMatrix(j, 12) = .coleccion(i).swPagMontoCLP
        
        
        total = 0
        fgFlujosVenta.TextMatrix(j, 0) = .coleccion(i).swNumFlujo & "  "
        fgFlujosVenta.TextMatrix(j, 1) = .coleccion(i).swFechaVenceFlujo
        fgFlujosVenta.TextMatrix(j, 2) = Format(.coleccion(i).swVAmortiza, "###,###,###,##0.###0")
        fgFlujosVenta.TextMatrix(j, 3) = Format(.coleccion(i).swVInteres, "###,###,###,##0.###0")
        total = Val(.coleccion(i).swVInteres) + Val(.coleccion(i).swVAmortiza)
        fgFlujosVenta.TextMatrix(j, 4) = Format(total, "###,###,###,##0.###0")
        fgFlujosVenta.TextMatrix(j, 5) = .coleccion(i).swVSaldo
        fgFlujosVenta.TextMatrix(j, 6) = .coleccion(i).swFechaInicioFlujo
        fgFlujosVenta.TextMatrix(j, 7) = 0
        fgFlujosVenta.TextMatrix(j, 8) = 0
        fgFlujosVenta.TextMatrix(j, 9) = "C"         'Datos de cartera
        fgFlujosVenta.TextMatrix(i, 10) = IIf(.coleccion(i).swModalidadPago = "C", "Compensación" & Space(50) & "C" _
                                            , "Ent. Fisica" & Space(50) & "E")
        fgFlujosVenta.TextMatrix(j, 11) = .coleccion(i).swPagMontoUSD
        fgFlujosVenta.TextMatrix(j, 12) = .coleccion(i).swPagMontoCLP
        
        total = 0
        j = j + 1
    Next i
    
    Set .coleccion = Nothing
    
    If CDbl(fgFlujosCompra.TextMatrix(1, 2)) > 0 Then
        txtFecPrimerVcto.Text = fgFlujosCompra.TextMatrix(1, 1)
    Else
        txtFecPrimerVcto.Text = fgFlujosCompra.TextMatrix(2, 1)
    End If
    
    End With
    
    lblFechaInicio = BacFechaStr(txtFecInicio.Text)
    lblFechaPrimerAmort = BacFechaStr(txtFecPrimerVcto.Text)
    lblFechaTermino = BacFechaStr(txtFecTermino.Text)
        
    Call CambiaColorCeldas(fgFlujosVenta)
    Call CambiaColorCeldas(fgFlujosCompra)
    
    Set Mantencion = Nothing
    
End Function

Sub CalculaFechas()
Dim nDias As Integer
Dim nDia1#
Dim nDia2#
Dim nDiasMay As Integer
    
    If IsNumeric(nDiasCapital#) And IsNumeric(nDiasInteres#) Then
    
    If Not nDiasCapital# > 0 And Not nDiasInteres# > 0 Then Exit Sub
    
    If nDiasCapital# = -1 Or nDiasCapital# = 0 Then
        nDia1# = nDiasInteres#
        nDia2# = nDiasInteres#
        nDias = nDiasInteres#
        'txtFecPrimerVcto.Text = BacMasMes(txtFecInicio.Text, CInt(nDiasInteres))
        
        txtFecPrimerVcto.Text = CreaFechaProx(txtFecInicio.Text, CInt(nDiasInteres), Day(txtFecInicio.Text))
   Else
        nDia1# = IIf(nDiasCapital# <= 0, 999, nDiasCapital#)
        nDia2# = IIf(nDiasInteres# <= 0, 999, nDiasInteres#)
        nDias = IIf(nDia1# < nDia2#, nDiasCapital#, nDiasInteres#)
        txtFecPrimerVcto.Text = CreaFechaProx(txtFecInicio.Text, CInt(nDiasCapital), Day(txtFecInicio.Text)) 'BacMasMes(txtFecInicio.Text, CInt(nDiasCapital))
    End If
    
    nDiasMay = IIf(nDia1# > nDia2#, nDia1#, nDia2#)
    
    lblFechaPrimerAmort = BacFechaStr(txtFecPrimerVcto.Text)
    txtFecTermino.Text = CreaFechaProx(txtFecInicio.Text, CInt(nDiasMay), Day(txtFecInicio.Text)) ' BacMasMes(txtFecInicio.Text, nDiasMay) ' txtFecPrimerVcto.Text
    lblFechaTermino = BacFechaStr(txtFecTermino.Text)
End If
    
End Sub


Function CalculaMonto(xTipOpe As String, nMonto As Double, nTCambio As Double, nCodMon As Integer) As Double
Dim nMtoCnv#, nTCcnv#, nCodCnv%
'****************************************************************
'* Calcula monto de Conversion de Moneda base a Moneda de Contraparte *
'****************************************************************
 nCodCnv = 0
 nTCcnv = 0
    If UCase(xTipOpe) = "C" Then
      If cmbMonedaVenta.ListIndex <> -1 Then
        nCodCnv = cmbMonedaVenta.ItemData(cmbMonedaVenta.ListIndex)
        nTCcnv = CDbl(lblTcVenta.Tag)
      End If
    Else
      If cmbMonedaCompra.ListIndex <> -1 Then
        nCodCnv = cmbMonedaCompra.ItemData(cmbMonedaCompra.ListIndex)
        nTCcnv = CDbl(lblTcCompra.Tag)
      End If
    End If
        
    '---- Convierte de Mon a Cnv
    If nCodMon = 13 Then
        If nCodCnv = 998 Or nCodCnv = 999 Then '--- Es Moneda Local
            nMtoCnv = Round(Round(nMonto * nTCambio, 0) / IIf(nTCcnv = 0, 1, nTCcnv), 4)
        ElseIf nEquivUSD$ = "1" Then
            nMtoCnv = Round(nMonto / nTCcnv, 2)
        Else
            nMtoCnv = Round(nMonto * nTCcnv, 2)
        End If
            
    Else
        If nCodMon = 998 Or nCodMon = 999 Then '--- Es Moneda Local
            nMtoCnv = Round(Round(nMonto * nTCambio, 0) / IIf(nTCcnv = 0, 1, nTCcnv), 2)
        ElseIf nEquivUSD$ = "1" Then
            nMtoCnv = Round(nMonto * nTCambio, 2)
        Else
            nMtoCnv = Round(BacDiv(nMonto, nTCambio), 2)
        End If
        
    End If
    
    If InStr("cv", xTipOpe) > 0 Then
    '---- Continua, esta generando los flujos
        CalculaMonto = nMtoCnv
    ElseIf xTipOpe = "C" Then
        txtCapitalVenta.Tag = nMtoCnv
        txtCapitalVenta.Text = CStr(nMtoCnv)
    Else
        txtCapitalCompra.Tag = nMtoCnv
        txtCapitalCompra.Text = CStr(nMtoCnv)
    End If

End Function

Function CalculaVeces(ByVal dFechaVenc As Date, xFechaTer As Date, ByVal nMeses As Integer)
Dim nVeces As Integer
Dim nMes   As Integer
Dim TotalFilas As Integer

CalculaVeces = 0

If nDiasCapital# > nDiasInteres# Then
    nMes = nDiasInteres#
Else
   If nDiasCapital# > 0 Then
      nMes = nDiasCapital#
   Else
      nMes = nDiasInteres#
   End If
End If

'---- Periodo Especial de vencimiento o Amortización de Capital
If DateDiff("m", txtFecInicio.Text, dFechaVenc) <> nMes Then
    CalculaVeces = 1
End If

TotalFilas = (fgFlujosCompra.Rows - 1)

CalculaVeces = CalculaVeces + CInt((TotalFilas * nMes) / nMeses)

End Function

Sub IniciaVar()
 
'------------- Bases
If False Then
    Call CargaCombos(cmbBaseCompra, 11, Sistema, "sp_CargaDatosComunes", 1, 1, 2)
    Call CargaCombos(cmbBaseVenta, 11, Sistema, "sp_CargaDatosComunes", 1, 1, 2)
    '------------- Cartera de Inversion
    Call CargaCombos(cmbCarteraInversion, 4, Sistema, "sp_CargaDatosComunes", 0, 1, 2)
    '------------- Amortizacion de Capital
    Call CargaCombos(cmbAmortizaCapital, 43, Sistema, "sp_leer_periodo", 1, 1, 3)
    '------------- Amortizacion de Interes
    Call CargaCombos(cmbAmortizaInteres, 44, Sistema, "sp_leer_periodo", 1, 1, 3)
    '------------ Monedas de Mercado
    Call CargaCombos(cmbMonedaCompra, 2, Sistema, "sp_LeerMonedasProducto", 0, 2, 1)
    Call CargaCombos(cmbMonedaVenta, 2, Sistema, "sp_LeerMonedasProducto", 0, 2, 1)

Else
    objCodigo.CargaObjetos cmbBaseCompra, 211
    objCodigo.CargaObjetos cmbBaseVenta, 211
    objCodigo.CargaObjetos cmbCarteraInversion, 1004
    '------------- Amortizacion de Capital
    Call LlenaComboAmortiza(cmbAmortizaCapital, 1043, Sistema)
    '------------- Amortizacion de Interes
    Call LlenaComboAmortiza(cmbAmortizaInteres, 1044, Sistema)
    objMoneda.CargaxProducto 2, cmbMonedaCompra
    objMoneda.CargaxProducto 2, cmbMonedaVenta
End If

'------------ Monedas de Pago
cmbMonedaRecibimos.Clear
cmbMonedaPagamos.Clear

'------------- Tasas
cmbTasaCompra.Clear
cmbTasaVenta.Clear

cmbOperador.Clear

'------------ Documentos de Pago
cmbDocumentoPagamos.Clear
cmbDocumentoRecibimos.Clear

'-------------- Fecha de Inicio
txtFecInicio.Text = gsBAC_Fecp

'-------------- Deshabilita Cardex de dbGrillas
Call IniciaFlujos(fgFlujosCompra)
Call IniciaFlujos(fgFlujosVenta)
tabFlujos.Tab = 0
tabFlujos.TabEnabled(1) = False
tabFlujos.TabEnabled(2) = False

cmbModalidad.AddItem "Compensación" & Space(50) & "C"
cmbModalidad.AddItem "Ent. Física " & Space(50) & "E"
cmbModalidadVen.AddItem "Compensación" & Space(50) & "C"
cmbModalidadVen.AddItem "Ent. Física " & Space(50) & "E"

'----------- Inicializa Variables de Módulo
cMonedaCom$ = ""
cMonedaVen$ = ""
nEquivUSD$ = ""
cTipoOperacion$ = H_COMPRA
cModalidad = "C"
cOperSwap = IIf(Mid$(cOperSwap, 1, 1) = "M", cOperSwap, "Ingreso")

'-------------------- Inicializa Objetos de Texto
txtCapitalCompra.Text = 0
txtCapitalVenta.Text = 0
txtTasaCompra.Text = 0
txtTasaVenta.Text = 0
txtSpreadCompra.Text = 0
txtSpreadVenta.Text = 0

txtCliente.Text = ""
txtRut.Text = ""
txtFecInicio.Text = (gsBAC_Fecp)
txtFecPrimerVcto.Text = (gsBAC_Fecp)
txtFecTermino.Text = (gsBAC_Fecp)
lblFechaInicio = BacFechaStr(txtFecInicio.Text)
lblFechaPrimerAmort = BacFechaStr(txtFecPrimerVcto.Text)
lblFechaTermino = BacFechaStr(txtFecTermino.Text)


lblMonedas.Caption = ""
lblTcCompra.Caption = ""
lblTcCompra.Tag = 0
lblTcVenta.Caption = ""
lblTcVenta.Tag = 0
txtCapitalVenta.Tag = 0
txtCapitalCompra.Tag = 0
lEntrada = True

'------------ Selecionada Moneda de Entrada
optCompra_Click


End Sub

Function ValidaDatos()
Dim nVecesCap As Integer
Dim nVecesInt As Integer
Dim nRes      As Integer
  
  ValidaDatos = False
  
  Call HabilitaPanles(False)
  
  '-< Control sobre Monedas
  If cmbMonedaCompra.ListIndex = -1 Or cmbMonedaVenta.ListIndex = -1 Then
        MsgBox "No ha indicado las Monedas a Transar", vbInformation, Msj
        If cmbMonedaCompra.Enabled = True Then
            cmbMonedaCompra.SetFocus
        Else
            cmbMonedaVenta.SetFocus
        End If
        Exit Function
        
  End If

  '-< Control sobre montos
  If Trim(txtCapitalCompra.Text) = 0 Or Trim(txtCapitalCompra.Text) = 0 Then
        MsgBox "No a ingresado los Montos de Capital", vbInformation, Msj
        txtCapitalCompra.SetFocus
        Exit Function
  End If
  
  '-< Control sobre Tipos de Tasas
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
    
  '-< Control sobre Tasas
  If Trim(txtTasaCompra.Text) = 0 Or Trim(txtTasaCompra.Text) = 0 Then
        MsgBox "Debe Ingresar valor de Tasas para realizar Cálculo", vbInformation, Msj
        txtTasaCompra.SetFocus
        Exit Function
  End If

  '-< Control sobre Base de cálculo
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
  
  '-< Control sobre Amortización
  If cmbAmortizaInteres.ListIndex = -1 Then
        MsgBox "No a definido los períodos de Amortización", vbInformation, Msj
        cmbAmortizaInteres.SetFocus
        Exit Function
  End If
  If cmbAmortizaCapital.ListIndex = -1 Then
        MsgBox "No a definido los periodos de Amortización", vbInformation, Msj
        cmbAmortizaCapital.SetFocus
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
  
  
  '----- ALEJANDRA esto si se puede , lo que no se puede es que el inicio = termino o primer vcto
  If CDate(txtFecPrimerVcto.Text) > CDate(txtFecTermino.Text) Then
        MsgBox "Fecha Primer Vencimiento NO puede ser posterior a la de Término", vbInformation, Msj
        txtFecTermino.SetFocus
        Exit Function
  End If
  
 '-------------------------<<<<<  OK  >>>>>
 Dim elMayor
 Dim difMeses As Integer
 Dim fecInicio As Date
    
    fecInicio = txtFecInicio.Text
    difMeses = DateDiff("d", fecInicio, txtFecPrimerVcto.Text)
    If difMeses > 28 Then
        difMeses = DateDiff("m", fecInicio, txtFecPrimerVcto.Text)
    Else
        difMeses = 0
    End If
      'If IIf(difMeses <> nDiasCapital, difMeses <> nDiasInteres, False) Then
    If IIf(difMeses <> nDiasCapital, difMeses = nDiasInteres, False) Then
        fecInicio = txtFecPrimerVcto.Text
    End If
    
    elMayor = IIf(nDiasCapital# > nDiasInteres#, nDiasCapital#, nDiasInteres#)
    difMeses = DateDiff("m", fecInicio, txtFecTermino.Text)
 
    'If (difMeses / elMayor) <> Int(difMeses / elMayor) Then
    '    MsgBox "Fecha de Término no está dentro del rango especificado", vbInformation, Msj
    '    txtFecTermino.Text = txtFecPrimerVcto.Text
    '    txtFecTermino.SetFocus
    '    Exit Function
    'End If
 
 
    nRes = DateDiff("m", txtFecInicio.Text, txtFecPrimerVcto.Text)
 
    '-< Control de Calce de Fechas
    If nDiasCapital# <= 0 Then
        nVecesCap = 1       'Tipos de Amortizacion Bullet y Bonos
    Else
        nVecesCap = difMeses / nDiasCapital
        If fecInicio <> CDate(txtFecInicio.Text) And nRes < nDiasCapital Then
              nVecesCap = CDbl(nVecesCap + 1)
        End If
  End If
  
    nVecesInt = difMeses / nDiasInteres#
    If fecInicio <> CDate(txtFecInicio.Text) And nRes < nDiasInteres Then
        nVecesInt = CDbl(nVecesInt + 1)
    End If
  
    If nVecesInt = 0 Then nVecesInt = 1
  
   If True Then             '---- PENDIENTE revisar tolerancia y dias por termino
        nRes = 0
    ElseIf nVecesCap > nVecesInt Then
        nRes = nVecesCap Mod nVecesInt
    ElseIf nVecesCap < nVecesInt Then
        nRes = nVecesInt Mod nVecesCap
    ElseIf nVecesCap = -1 Or nVecesInt = -1 Then
        nRes = -1
    End If
  
    If nRes <> 0 Then
        MsgBox "Períodos no concuerdan, revise fechas límites", vbInformation, Msj
        txtFecInicio.SetFocus
        Exit Function
    End If
    
    Call HabilitaPanles(True)
    
    Call ValidaPeriodos
    
    ValidaDatos = cmdCalcula.Enabled
  
End Function

Private Sub cmbAmortizaCapital_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then SendKeys ("{Tab}")
End Sub


Private Sub cmbAmortizaCapital_LostFocus()

If cmbAmortizaCapital.ListIndex = -1 Then Exit Sub
nDiasCapital# = Left$(cmbAmortizaCapital.ItemData(cmbAmortizaCapital.ListIndex), 3)

End Sub


Private Sub cmbAmortizaInteres_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then txtFecInicio.SetFocus ' SendKeys ("{Tab}")

End Sub


Private Sub cmbAmortizaInteres_LostFocus()

If cmbAmortizaInteres.ListIndex = -1 Then Exit Sub

    nDiasInteres# = Left$(cmbAmortizaInteres.ItemData(cmbAmortizaInteres.ListIndex), 3)

End Sub

Private Sub cmbBaseCompra_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then SendKeys ("{Tab}")
End Sub

Private Sub cmbBaseVenta_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then SendKeys ("{Tab}")
End Sub

Private Sub cmbCarteraInversion_KeyPress(KeyAscii As Integer)
    'If KeyAscii = 13 Then SendKeys ("{Tab}")
    If KeyAscii = 13 Then cmdCalcula.SetFocus
    
End Sub

Private Sub cmbDocumentoPagamos_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then cmbAmortizaCapital.SetFocus
End Sub

Private Sub cmbDocumentoRecibimos_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then SendKeys ("{Tab}")
End Sub

Private Sub cmbModalidad_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 Then
        With fgFlujosCompra
        If .Col = 10 Then
            .TextMatrix(.Row, 10) = cmbModalidad
            fgFlujosVenta.TextMatrix(.Row, 10) = cmbModalidad
        End If
        cmbModalidad.Visible = False
        .SetFocus
        End With
    End If
    
End Sub

Private Sub cmbModalidadVen_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        With fgFlujosVenta
        If .Col = 10 Then
            .TextMatrix(.Row, 10) = cmbModalidadVen
            fgFlujosCompra.TextMatrix(.Row, 10) = cmbModalidadVen
        End If
        cmbModalidad.Visible = False
        .SetFocus
        End With
    End If

End Sub

Private Sub cmbMonedaCompra_Click()
Dim Sql$
Dim Datos()
Dim nCodMon%

If cmbMonedaCompra.ListIndex = -1 Then Exit Sub

'Busca Valor Moneda
 cmbMonedaCompra.Tag = Left$(cmbMonedaCompra.ItemData(cmbMonedaCompra.ListIndex), 3)
 nCodMon% = cmbMonedaCompra.Tag
 
 objMoneda.LeerxCodigo nCodMon
 
 cMonedaCom$ = objMoneda.mnnemo
 lblTcCompra.Tag = objMoneda.vmValor
 lblTcCompra.Caption = Format(lblTcCompra.Tag, TipoFormato(cMonedaCom$))

 If nCodMon = 13 Then
     lblTcCompra.Caption = gsBAC_DolarObs
     lblTcCompra.Tag = gsBAC_DolarObs
 End If
 lblMonedas.Caption = cMonedaCom$ & " / " & cMonedaVen$
 
 objMoneda.CargaTasas nCodMon, cmbTasaCompra
 cmbTasaCompra.AddItem "FIJA"
 cmbTasaCompra.ItemData(cmbTasaCompra.NewIndex) = 0
 
 
 objFPago.CargaxMoneda Val(cmbMonedaCompra.Tag), 0, cmbMonedaRecibimos
   
 cmbDocumentoRecibimos.Clear

 
 'objMoneda.CargaObjectos cmbMonedaRecibimos, "PAGADORA"
 
If False Then
 
 Sql$ = giSQL_DatabaseCommon
 Sql$ = Sql$ & "..sp_Nemo_Valor 'PCS'"
 Sql$ = Sql$ & ", " & nCodMon%
 Sql$ = Sql$ & ",'" & Format(gsBAC_Fecp, "yyyymmdd") & "'"
 
 Envia = Array()
 AddParam Envia, "PCS"
 AddParam Envia, CDbl(nCodMon)
 AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
 
'If MISQL.SQL_Execute(Sql$) = 0 Then
If Bac_Sql_Execute("Sp_Nemo_Valor", Envia) Then
 
'    If MISQL.SQL_Fetch(DATOS()) = 0 Then
    If Bac_SQL_Fetch(Datos()) Then
        cMonedaCom$ = Datos(1)
        lblTcCompra.Tag = BacStrTran((Datos(2)), ".", gsc_PuntoDecim)
        lblTcCompra.Caption = Format(Val(lblTcCompra.Tag), TipoFormato(cMonedaCom$))
        nEquivUSD$ = Datos(3)
    Else
        cMonedaCom$ = ""
        lblTcCompra.Caption = 1
        lblTcCompra.Tag = 1
        nEquivUSD$ = "1"
    End If
    If nCodMon = 13 Then
        lblTcCompra.Caption = gsBAC_DolarObs
        lblTcCompra.Tag = gsBAC_DolarObs
    End If
    lblMonedas.Caption = cMonedaCom$ & " / " & cMonedaVen$
    
    'Busca Tasas asociadas
    
    Call TasasPorMoneda(cmbTasaCompra, _
                                     nCodMon%, _
                                     42, _
                                     IIf(cOperSwap = "ModificacionCartera", Format(FechaCierre, "yyyymmdd"), Format(gsBAC_Fecp, "yyyymmdd")))
    
    'Call LlenaComboPagRec(cmbDocumentoRecibimos, nCodMon%)
    Call LlenaMonDocPago(cmbMonedaRecibimos, DatosPorMoneda(), 1, _
                    nCodMon%, TotDatPorMon, 1)
                    
End If
End If

End Sub

Private Sub cmbMonedaCompra_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then SendKeys ("{Tab}")
End Sub

Private Sub cmbMonedaPagamos_Click()

    If optEntFisica.Value = True Then
        'SI ES ENTREGA FISICA SE RECIBE Y SE PAGA EN LA MISMA MONEDA
        cmbMonedaPagamos.ListIndex = cmbMonedaRecibimos.ListIndex
    End If
    
    If cmbMonedaPagamos.ListIndex >= 0 And cmbMonedaPagamos.ListCount <> 0 Then
         objFPago.CargaxMoneda Val(cmbMonedaVenta.Tag), cmbMonedaPagamos.ItemData(cmbMonedaPagamos.ListIndex), cmbDocumentoPagamos
    End If
    
    If False Then
    Call LlenaMonDocPago(cmbDocumentoPagamos, DatosPorMoneda(), _
                                           cmbMonedaPagamos.Tag, _
                                           SacaCodigo(cmbMonedaPagamos), TotDatPorMon, 2)
    End If
    
End Sub

Private Sub cmbMonedaPagamos_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then SendKeys ("{Tab}")
End Sub

Private Sub cmbMonedaRecibimos_Click()
    
    If optEntFisica.Value = True Then
        'SI ES ENTREGA FISICA SE RECIBE Y SE PAGA EN LA MISMA MONEDA
        cmbMonedaRecibimos.ListIndex = cmbMonedaPagamos.ListIndex
    End If
    
    objFPago.CargaxMoneda Val(cmbMonedaCompra.Tag), cmbMonedaRecibimos.ItemData(cmbMonedaRecibimos.ListIndex), cmbDocumentoRecibimos
    
    If False Then
    Call LlenaMonDocPago(cmbDocumentoRecibimos, DatosPorMoneda(), _
                                           cmbMonedaRecibimos.Tag, _
                                           SacaCodigo(cmbMonedaRecibimos), TotDatPorMon, 2)
    End If
End Sub

Private Sub cmbMonedaRecibimos_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then SendKeys ("{Tab}")
End Sub

Private Sub cmbMonedaVenta_Click()
 Dim Sql$
Dim Datos()
Dim nCodMon%

If cmbMonedaVenta.ListIndex = -1 Then Exit Sub

'Busca valor de la moneda
 cmbMonedaVenta.Tag = Left$(cmbMonedaVenta.ItemData(cmbMonedaVenta.ListIndex), 3)
 nCodMon% = cmbMonedaVenta.Tag
 
 objMoneda.LeerxCodigo nCodMon
 
 cMonedaVen$ = objMoneda.mnnemo
 lblTcVenta.Tag = objMoneda.vmValor
 lblTcVenta.Caption = Format(lblTcVenta.Tag, TipoFormato(cMonedaVen$))
 
 If nCodMon = 13 Then
     lblTcVenta.Caption = gsBAC_DolarObs
     lblTcVenta.Tag = gsBAC_DolarObs
 End If
 lblMonedas.Caption = cMonedaCom$ & " / " & cMonedaVen$
 
 If objMoneda.CargaTasas(nCodMon, cmbTasaVenta) = False Then
    MsgBox "Error de Carga de Sp ", 16, Msj
 End If
 
 cmbTasaVenta.AddItem "FIJA"
 cmbTasaVenta.ItemData(cmbTasaVenta.NewIndex) = 0
 
 
 objFPago.CargaxMoneda Val(cmbMonedaVenta.Tag), 0, cmbMonedaPagamos
 cmbDocumentoPagamos.Clear
    
 
 'If objMoneda.CargaObjectos(cmbMonedaPagamos, "PAGADORA") = False Then
 '      MsgBox "Error de Carga de Sp ", 16, Msj
 ' End If
 
 
If False Then
 Sql$ = giSQL_DatabaseCommon
 Sql$ = Sql$ & "..sp_Nemo_Valor "
 Sql$ = Sql$ & "'PCS', "
 Sql$ = Sql$ & nCodMon% & ", '"
 Sql$ = Sql$ & Format(gsBAC_Fecp, "yyyymmdd") & "'"
 
 Envia = Array()
 AddParam Envia, "PCS"
 AddParam Envia, CDbl(nCodMon%)
 AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
 
 'If MISQL.SQL_Execute(Sql$) = 0 Then
 If Bac_Sql_Execute("Sp_Nemo_Valor", Envia) Then
 
'    If MISQL.SQL_Fetch(DATOS()) = 0 Then
    If Bac_SQL_Fetch(Datos()) Then
       cMonedaVen$ = Datos(1)
       lblTcVenta.Tag = BacStrTran((Datos(2)), ".", gsc_PuntoDecim)
       lblTcVenta.Caption = Format(lblTcVenta.Tag, TipoFormato(cMonedaVen$))
       
    Else
        cMonedaVen$ = ""
        lblTcVenta.Caption = 0
        lblTcVenta.Tag = 0
    End If
    
    If nCodMon = 13 Then
        lblTcCompra.Caption = gsBAC_DolarObs
        lblTcCompra.Tag = gsBAC_DolarObs
    End If
    lblMonedas.Caption = cMonedaCom$ & " / " & cMonedaVen$
    
    'Busca Tasas por la moneda seleccionada
    Call TasasPorMoneda(cmbTasaVenta, _
                                     nCodMon%, _
                                     42, _
                                     IIf(cOperSwap = "ModificacionCartera", Format(FechaCierre, "yyyymmdd"), Format(gsBAC_Fecp, "yyyymmdd")))
    
    'Call LlenaComboPagRec(cmbDocumentoPagamos, nCodMon%)
    
    Call LlenaMonDocPago(cmbMonedaPagamos, DatosPorMoneda(), 1, _
                    nCodMon%, TotDatPorMon, 1)
                    
End If
End If

End Sub

Private Sub cmbMonedaVenta_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then SendKeys ("{Tab}")
End Sub

Private Sub cmbOperador_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then SendKeys ("{Tab}")
End Sub

Private Sub cmbTasaCompra_Click()

   If cmbTasaVenta.ListIndex >= 0 And cmbTasaCompra.ListIndex >= 0 Then
 
    If cmbTasaVenta.ItemData(cmbTasaVenta.ListIndex) = cmbTasaCompra.ItemData(cmbTasaCompra.ListIndex) And cmbTasaVenta.ItemData(cmbTasaVenta.ListIndex) = 0 Then
        MsgBox "No pueden ser ambas tasas Fijas", vbExclamation, Msj
    End If
  End If
    txtTasaCompra.Tag = Trim(Right(cmbTasaCompra, 15))
End Sub

Private Sub cmbTasaCompra_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then SendKeys ("{Tab}")
End Sub

Private Sub cmbTasaVenta_Click()

    If cmbTasaVenta.ListIndex >= 0 And cmbTasaCompra.ListIndex >= 0 Then
        If cmbTasaVenta.ItemData(cmbTasaVenta.ListIndex) = cmbTasaCompra.ItemData(cmbTasaCompra.ListIndex) And cmbTasaVenta.ItemData(cmbTasaVenta.ListIndex) = 0 Then
            MsgBox "No pueden ser ambas tasas Fijas", vbExclamation, Msj
        End If
    End If
    
    If cmbTasaVenta.ListIndex >= 0 Then
        txtTasaVenta.Tag = Trim(Right(cmbTasaVenta, 15))
    Else
        txtTasaVenta.Tag = ""
    End If
End Sub

Private Sub cmbTasaVenta_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then SendKeys ("{Tab}")
End Sub

Private Sub cmdCalcula_Click()

If Not ValidaDatos() Then
    Exit Sub
End If

If True Then
    If Not optVenta.Value Then
        Call GeneraFlujos(fgFlujosCompra, fgFlujosVenta, "C")
    Else
        Call GeneraFlujos(fgFlujosVenta, fgFlujosCompra, "V")
    End If
    
Else
  
    Barra.Value = Barra.Min
    framBarra.Visible = True
    
    Barra.Value = Barra.Max
    
    'Invisibilizar barra
    framBarra.Visible = False
    Barra.Value = Barra.Min

End If

cmdGrabar.Enabled = True
    
End Sub

Sub HabilitaPanles(ByVal xValor)
    tabFlujos.TabEnabled(1) = xValor
    tabFlujos.TabEnabled(2) = xValor
End Sub

Private Sub cmdGrabar_Click()
Dim m

Me.MousePointer = 11

If ValidaDatos() Then

   '----------- Control de Cliente
   If txtRut.Text = "" Or txtCliente.Text = "" Then
      MsgBox "Debe Ingresar datos del Cliente", vbCritical, Msj
      txtRut.SetFocus
      GoTo Fin
   End If
   
   '---------control de Formas de Pago
   If cmbMonedaRecibimos.ListIndex = -1 Then
      MsgBox "Debe Ingresar Moneda de Pago", vbCritical, Msj
      cmbMonedaRecibimos.SetFocus
      GoTo Fin
   End If
   
   If cmbDocumentoRecibimos.ListIndex = -1 Then
      MsgBox "Debe Ingresar Documento de Pago", vbCritical, Msj
      cmbDocumentoRecibimos.SetFocus
      GoTo Fin
   End If
   
   If cmbMonedaPagamos.ListIndex = -1 Then
      MsgBox "Debe Ingresar Moneda de Pago", vbCritical, Msj
      cmbMonedaPagamos.SetFocus
      GoTo Fin
   End If
   If cmbDocumentoPagamos.ListIndex = -1 Then
      MsgBox "Debe Ingresar Documento de Pago", vbCritical, Msj
      cmbDocumentoPagamos.SetFocus
      GoTo Fin
   End If
   
   
   
   '-------------------Control de cartera de Inversión
   If cmbCarteraInversion.ListIndex = -1 Then
      MsgBox "Debe definir Cartera de Inversión", vbCritical, Msj
      tabFlujos.Tab = 0
      cmbCarteraInversion.SetFocus
      GoTo Fin
   End If
    If (fgFlujosCompra.TextMatrix(1, 1) = "" Or fgFlujosVenta.TextMatrix(1, 1) = "") Or tabFlujos.TabEnabled(1) = False Then
    

        MsgBox "Debe realizar Calculo de flujos!", vbCritical, Msj
        GoTo Fin
    End If

    
    
    If GrabarSwapMonedas() Then
       Me.MousePointer = 0

       MsgBox "Operación No. " & Str(nNumOper) & " fue Grabada con Exito", vbInformation, Msj
       
        If ImprimePapeleta(nNumOper, _
                                    IIf(cOperSwap = "Modificacion" Or cOperSwap = "Ingreso", 1, 3), _
                                    IIf(cOperSwap = "Ingreso", gsBAC_Fecp, FechaCierre), _
                                    2) Then
        
            EtqMensaje.Caption = "Informe enviado a Impresora!"
            BacControlWindows 100
            EtqMensaje.Caption = ""
        End If
       
       Call IniciaVar
       cmdGrabar.Enabled = True
    
    End If
       
End If

Fin:
      Me.MousePointer = 0

End Sub

Function GrabarSwapMonedas() As Boolean

Dim objGrabaSwap As New ClsMovimSwaps
Dim Sql As String
Dim i, Actualiza As Integer
Dim Datos()
Dim fecInteres As String
Dim Hasta As Long
Dim OperSwap As String

'********************************************************************
'* Rutina que graba los datos de operaciones nuevas y Operaciones Modificadas *
'********************************************************************
GrabarSwapMonedas = False


Call SacarValoresSWMoneda(ValorUlt)

With objGrabaSwap
'hacer begin transaction

    Sql = "BEGIN TRANSACTION"
    
    If MISQL.SQL_Execute(Sql) Then
        Exit Function
    End If
    
    If cOperSwap = "Ingreso" Then
    
        'Saca numero de ultima operacion
        Envia = Array()
        AddParam Envia, Sistema
        AddParam Envia, Entidad

        If Not Bac_Sql_Execute("Sp_UltimaOperacion", Envia) Then
            MsgBox "Problemas para crear número de Operación!", vbCritical, Msj
            Exit Function
        Else
            If Bac_SQL_Fetch(Datos()) Then
                .swNumOperacion = Val(Datos(1))        'Numero de la Operacion
            Else
                .swNumOperacion = 1                    'Primera Operacion creada
            End If
        End If
        nNumOper = .swNumOperacion
        FechaCierre = gsBAC_Fecp
        Actualiza = 1
        
    ElseIf cOperSwap = "Modificacion" Or cOperSwap = "ModificacionCartera" Then
        'modificaciones del diario o de vigentes
        Sql = " Exec sp_modificaswaps " _
              & Str(nNumOper) & ", '" & Format(gsBAC_Fecp, "yyyymmdd") & "' "
        
        Envia = Array()
        AddParam Envia, CDbl(nNumOper)
        AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
        
        If Not Bac_Sql_Execute("Sp_ModificaSwaps", Envia) Then
            MsgBox "Problemas al verificar Operación a modificar!", vbCritical, Msj
            Exit Function
        End If
        .swNumOperacion = nNumOper
        Actualiza = IIf(cOperSwap = "Modificacion", 1, 2)   'Si actualizara la tabla de MovDiario
        ' La fecha de cierre se recupero en funcion BuscarDatos, variable FechaCierre
    End If
    
    'Datos Generales
    .swActualizar = Actualiza
    .swTipoSwap = OP_SWAP_MONEDAS                                         'Tipo de Swap (Tasa - Monedas)
    .swCarteraInversion = SacaCodigo(cmbCarteraInversion)                 'Codigo de Cartera de Inversion
    .swTipoOperacion = cTipoOperacion$                                    'Tipo de Operacion (Compra-Venta)
    .swCodCliente = IIf(txtCliente.Tag = "", 0, txtCliente.Tag)           'Codigo cliente
    .swRutCliente = txtRut.Tag       'Rut cliente sin digito verificador
    .swOperador = Left(gsBAC_User$, 10)                                   'ingresa nombre usuario con max. de 10 caract.
    .swOperadorCliente = SacaCodigo(cmbOperador)                          'Codigo del Operador
    .swFechaModifica = gsBAC_Fecp
    
    'Datos de Compra
    .swCMoneda = SacaCodigo(cmbMonedaCompra)                              'Moneda de Compra
    .swCCapital = .FormatNum(txtCapitalCompra.Text)                       'Monto Capital
    .swFechaCierre = FechaCierre                                          'Fecha del dia en que se realiza operacion
    .swFechaInicio = txtFecInicio.Text                                    'Fecha Primer Vencimiento
    .swFechaTermino = txtFecTermino.Text                                  'Fecha Termino amortizacion
    .swCCodAmoCapital = Val(cmbAmortizaCapital.ItemData(cmbAmortizaCapital.ListIndex)) 'Codigo tipo amortizacion de capital
    .swCMesAmoCapital = nDiasCapital#                                     'Valor de meses
    .swCCodAmoInteres = Val(cmbAmortizaInteres.ItemData(cmbAmortizaInteres.ListIndex)) 'Codigo tipo amortizacion de interes
    .swCMesAmoInteres = nDiasInteres#                                     'Valor de meses
    .swCBase = cmbBaseCompra                                              'Monto base Compra
    .swCMontoCLP = 0                                                      'Monto compra en Pesos
    .swCMontoUSD = 0                                                      'Monto Compra en moneda pactada
    .swCValorTasaHoy = .FormatNum(txtTasaCompra.Text)                     'Valor Tasa del dia
    .swCSpread = .FormatNum(txtSpreadCompra.Text)
    .swCCodigoTasa = SacaCodigo(cmbTasaCompra)                            'Codigo de tasa compra
    .swPagMoneda = SacaCodigo(cmbMonedaPagamos)                           'Codigo Moneda Pagamos
    .swPagDocumento = SacaCodigo(cmbDocumentoPagamos)                     'Codigo documento Pagamos

    'Datos de Venta
    .swVMoneda = SacaCodigo(cmbMonedaVenta)                               'Codigo Moneda de Venta
    .swVCapital = .FormatNum(txtCapitalVenta.Text)                        'Monto capital Venta
    .swVCodAmoCapital = Val(Trim(Right(cmbAmortizaCapital, 10)))          'Codigo tipo de amortizacion Tasa
    .swVMesAmoCapital = nDiasCapital#                                     'Valor de meses
    .swVCodAmoInteres = Val(Trim(Right(cmbAmortizaInteres, 10)))          'Codigo tipo amortizacion de interes
    .swVMesAmoInteres = nDiasInteres#                                     'Valor de meses
    .swVBase = cmbBaseVenta                                               'Monto Base Venta
    .swVMontoCLP = 0                                                      'Monto Venta en Pesos
    .swVMontoUSD = 0                                                      'Monto Venta en moneda pactada
    .swVCodigoTasa = SacaCodigo(cmbTasaVenta)                             'Codigo de tasa Venta
    .swVValorTasaHoy = .FormatNum(txtTasaVenta.Text)                      'Valor Tasa del dia
    .swVSpread = .FormatNum(txtSpreadVenta.Text)
    .swRecMoneda = SacaCodigo(cmbMonedaRecibimos)                         'Codigo Moneda Recibimos
    .swRecDocumento = SacaCodigo(cmbDocumentoRecibimos)                   'Codigo Documento Recibimos
    .swObservaciones = "s/o"
    
    
    fecInteres = fgFlujosCompra.TextMatrix(1, 1)
    
    '***   CH = Cartera Historica
    
For i = 1 To fgFlujosCompra.Rows - 1
    If fgFlujosCompra.TextMatrix(i, 1) <> "" Then
    
        .swNumFlujo = fgFlujosCompra.TextMatrix(i, 0)                                               'Correlativo de la Operacion
        .swFechaInicioFlujo = fgFlujosCompra.TextMatrix(i, 6)
        .swFechaVenceFlujo = fgFlujosCompra.TextMatrix(i, 1)
        
        .swCAmortiza = .FormatNum(fgFlujosCompra.TextMatrix(i, 2))                    'Monto amortizado en Compra
        .swCSaldo = .FormatNum(fgFlujosCompra.TextMatrix(i, 5))                         'Monto no amortizado (Saldo) en compra
        .swCInteres = .FormatNum(fgFlujosCompra.TextMatrix(i, 3))                       'Monto Interes de Compra
        .swCValorTasa = .FormatNum(txtTasaCompra.Text)
        .swPagMonto = .FormatNum(CDbl(fgFlujosCompra.TextMatrix(i, 2)) + CDbl(fgFlujosCompra.TextMatrix(i, 5)))
        .swPagMontoUSD = .FormatNum((fgFlujosCompra.TextMatrix(i, 11)))
        .swPagMontoCLP = .FormatNum((fgFlujosCompra.TextMatrix(i, 12)))
    
        .swVAmortiza = .FormatNum(fgFlujosVenta.TextMatrix(i, 2))                     'Monto Amortizado en Venta
        .swVSaldo = .FormatNum(fgFlujosVenta.TextMatrix(i, 5))                           'Monto no amortizado (Saldo) en Venta
        .swVInteres = .FormatNum(fgFlujosVenta.TextMatrix(i, 4))                          'Monto Interes de Compra
        .swVValorTasa = .FormatNum(txtTasaVenta.Text)
        .swRecMonto = .FormatNum(CDbl(fgFlujosVenta.TextMatrix(i, 2)) + CDbl(fgFlujosVenta.TextMatrix(i, 5)))
        .swRecMontoUSD = .FormatNum(fgFlujosVenta.TextMatrix(i, 11))
        .swRecMontoCLP = .FormatNum(fgFlujosVenta.TextMatrix(i, 12))
        
        .swEstadoFlujo = 1
        .swModalidadPago = Right(fgFlujosVenta.TextMatrix(i, 10), 1)  'cModalidad
    
        If Not .Grabar Then
            Sql = "ROLLBACK TRANSACTION"
            If MISQL.SQL_Execute(Sql) <> 0 Then
                MsgBox "Problemas al deshacer la operación", vbCritical, Msj
                Exit Function
            End If
            MsgBox "No terminó proceso de ingreso de datos", vbCritical, Msj
            Exit Function
        End If
    End If
    
Next


Call GRABALOG(cOperSwap, "Opc_20200", .swNumOperacion, .swTipoSwap, ValorAnt, ValorUlt)
   

            
            
Sql = "COMMIT TRANSACTION"
If MISQL.SQL_Execute(Sql) <> 0 Then
    MsgBox "Problemas al grabar datos", vbCritical, Msj
    Exit Function
End If

End With

Set objGrabaSwap = Nothing

GrabarSwapMonedas = True

End Function

Private Sub cmdLimpia_Click()

    Me.MousePointer = 11
    Call IniciaVar
    Me.MousePointer = 0

End Sub

Private Sub cmdSalir_Click()
    Unload Me
End Sub

Private Sub fgFlujosCompra_EnterCell()
With fgFlujosCompra

    If .TextMatrix(.Row, 9) = "CH" Then Exit Sub ' Si es modificacion de cartera los flujos de cartera
    
    'txtTasa.Visible = False
    txtAmortiza.Visible = False
    cmbModalidad.Visible = False
    'txtTasa.Text = 0
    txtAmortiza.Text = 0
    
    If .Row = 0 Then Exit Sub
    If cTipoOperacion$ <> "C" Then Exit Sub
    
    Select Case .Col
    Case 2
        If nDiasCapital# = -1 Then
            'cambio en monto amortizacion
            txtAmortiza.Width = .CellWidth
            txtAmortiza.Left = .CellLeft + 130
            txtAmortiza.Top = .CellTop + 360
            txtAmortiza.Text = .TextMatrix(.Row, 2)
            txtAmortiza.Tag = .Row
            txtAmortiza.Visible = True
            txtAmortiza.SetFocus
        End If
    'Case 3
        'txtTasa.Left = .CellLeft + 50
        'txtTasa.Top = .CellTop + 410
        'txtTasa.Text = .TextMatrix(.Row, 3)
        'txtTasa.Tag = .Row
        'txtTasa.Visible = True
        'txtTasa.SetFocus
    Case 10
        cmbModalidad.Width = .CellWidth
        cmbModalidad.Left = .CellLeft + 130
        cmbModalidad.Top = .CellTop + 360
        cmbModalidad.ListIndex = IIf(Right(.TextMatrix(.Row, 10), 1) = "C", 0, 1)
        cmbModalidad.Tag = .Row
        cmbModalidad.Visible = True
        cmbModalidad.SetFocus
    End Select
    
End With

End Sub

Private Sub fgFlujosCompra_LostFocus()
Dim i As Integer
Dim SumAmortCom  As Double
Dim SumAmortVen As Double
Dim nTasa As Double
Dim Res

    SumAmortCom = 0
  '  Exit Sub
  
    If nDiasCapital# = -1 And cTipoOperacion$ = "C" Then
        'Amortizacion de capital BONOS
        For i = 1 To fgFlujosCompra.Rows - 1
            SumAmortCom = SumAmortCom + CDbl(fgFlujosCompra.TextMatrix(i, 2))
        Next
        If SumAmortCom <> CDbl(txtCapitalCompra.Text) Then
            Res = MsgBox("Amortización acumulada no corresponde. ¿Recalcular Montos con Cambio?", vbQuestion + vbYesNo, Msj)
            If Res = vbYes Then
                txtCapitalCompra.Tag = SumAmortCom
                txtCapitalCompra.Text = txtCapitalCompra.Tag
                Call CalculaMonto(cTipoOperacion$, txtCapitalCompra.Tag, lblTcCompra.Tag, cmbMonedaCompra.Tag)
                nTasa = Val(txtTasaCompra.Text) + Val(txtSpreadCompra.Text)
                Call CalculoInteresBonos(cmbBaseCompra, nTasa, txtCapitalCompra.Tag, fgFlujosCompra)
                nTasa = Val(txtTasaVenta.Text) + Val(txtSpreadVenta.Text)
                Call CalculoInteresBonos(cmbBaseVenta, nTasa, txtCapitalVenta.Tag, fgFlujosVenta)
            End If
        End If
    End If

End Sub

Private Sub fgFlujosCompra_Scroll()

    cmbModalidad.Visible = False
'    txtTasa.Visible = False
    txtAmortiza.Visible = False

End Sub

Private Sub fgFlujosVenta_EnterCell()

With fgFlujosVenta

    If .TextMatrix(.Row, 9) = "CH" Then Exit Sub ' Si es modificacion de cartera los flujos de cartera
    
    txtAmortizaVen.Visible = False
    cmbModalidadVen.Visible = False
    txtAmortizaVen.Text = 0
    
    If .Row = 0 Then Exit Sub
    If cTipoOperacion$ <> "V" Then Exit Sub
    
    Select Case .Col
    Case 2
        If nDiasCapital# = -1 Then
            'cambio en monto amortizacion
            txtAmortizaVen.Width = .CellWidth
            txtAmortizaVen.Left = .CellLeft + 130
            txtAmortizaVen.Top = .CellTop + 360
            txtAmortizaVen.Text = .TextMatrix(.Row, 2)
            txtAmortizaVen.Tag = .Row
            txtAmortizaVen.Visible = True
            txtAmortizaVen.SetFocus
        End If
    
    Case 10
        cmbModalidadVen.Width = .CellWidth
        cmbModalidadVen.Left = .CellLeft + 130
        cmbModalidadVen.Top = .CellTop + 360
        cmbModalidadVen.ListIndex = IIf(Right(.TextMatrix(.Row, 10), 1) = "C", 0, 1)
        cmbModalidadVen.Tag = .Row
        cmbModalidadVen.Visible = True
        cmbModalidadVen.SetFocus
    End Select
    
End With

End Sub

Private Sub fgFlujosVenta_LostFocus()
Dim i As Integer
Dim SumAmortCom  As Double
Dim SumAmortVen As Double
Dim nTasa As Double
Dim Res

    SumAmortCom = 0
  '  Exit Sub
  
    If nDiasCapital# = -1 And cTipoOperacion$ = "V" Then
        'Amortizacion de capital BONOS
        For i = 1 To fgFlujosCompra.Rows - 1
            SumAmortCom = SumAmortCom + CDbl(fgFlujosCompra.TextMatrix(i, 2))
        Next
        If SumAmortCom <> CDbl(txtCapitalCompra.Text) Then
            Res = MsgBox("Amortización acumulada no corresponde. ¿Recalcular Montos con Cambio?", vbQuestion + vbYesNo, Msj)
            If Res = vbYes Then
                txtCapitalCompra.Tag = SumAmortCom
                Call CalculaMonto("C", txtCapitalCompra.Tag, lblTcVenta.Tag, cmbMonedaCompra.Tag)
                nTasa = Val(txtTasaCompra.Text) + Val(txtSpreadCompra.Text)
                Call CalculoInteresBonos(cmbBaseCompra, nTasa, SumAmortCom, fgFlujosCompra)
                nTasa = Val(txtTasaVenta.Text) + Val(txtSpreadVenta.Text)
                Call CalculoInteresBonos(cmbBaseVenta, nTasa, SumAmortVen, fgFlujosVenta)
            End If
        End If
    End If

End Sub
Private Sub SacarValoresSWMoneda(cadena As String)
    
   With Me
    cadena = 1 & "; " & "Cartera: " & Trim(.cmbCarteraInversion) & ";"
    cadena = cadena & "Tipo Op: " & IIf(.optCompra.Value = True, "C", "V") & ";"
    cadena = cadena & "Cod Cliente: " & IIf(.txtCliente.Tag = "", 0, .txtCliente.Tag) & ";" & "Rut Cli: " & .txtRut.Text & ";"
    cadena = cadena & "Fecha Cierre: " & " " & ";" & "Fecha Inicio: " & .txtFecInicio.Text & ";" & "FechaTermino: " & .txtFecTermino.Text & ";"
    cadena = cadena & "CAmoCapital:" & Trim(Left(.cmbAmortizaCapital, 30)) & ";"
    cadena = cadena & "CAmoInteres:" & Trim(Left(.cmbAmortizaInteres, 30)) & ";"
    cadena = cadena & "CBase:" & .cmbBaseCompra & ";"
    cadena = cadena & "VAmoCapital:" & Trim(Left(.cmbAmortizaCapital, 30)) & ";"
    cadena = cadena & "VAmoInteres:" & Trim(Left(.cmbAmortizaInteres, 30)) & ";"
    cadena = cadena & "VBase :" & .cmbBaseVenta & ";"
    cadena = cadena & "Operador :" & Left(gsBAC_User$, 10) & ";" & "Cod Oper :" & Trim(.cmbOperador) & ";"
     cadena = cadena & "CValorTasa :" & .txtTasaCompra.Text & ";"
    cadena = cadena & "VValorTasa :" & .txtTasaVenta.Text & ";"
    cadena = cadena & "PagMoneda :" & Trim(.cmbMonedaPagamos) & ";" & "PagDocumento :" & Trim(.cmbDocumentoPagamos) & ";"
    cadena = cadena & "RecMoneda :" & Trim(.cmbMonedaRecibimos) & ";" & "RecDocumento :" & Trim(.cmbDocumentoRecibimos) & ";"
    cadena = cadena & "FechaModifica :" & gsBAC_Fecp
    cadena = cadena & "CMoneda: " & Trim(.cmbMonedaCompra) & ";"
    cadena = cadena & "CCapital: " & .txtCapitalCompra.Text & ";"
    cadena = cadena & "VMoneda:" & Trim(.cmbMonedaVenta) & ";"
    cadena = cadena & "VCapital:" & .txtCapitalVenta.Text & ";"
    cadena = cadena & "CSpread:" & Trim(.txtSpreadCompra.Text) & ";"
    cadena = cadena & "VSpread:" & .txtSpreadVenta.Text & ";"

   End With
   
End Sub
Private Sub Form_Load()
Me.Icon = BACSwap.Icon
cOperSwap = swOperSwap
nNumOper = swModNumOpe
swOperSwap = ""

'Posiciona Formulario
 Me.Top = 60
 Me.Left = 100
'--------------- Identificadores

tabFlujos.Tab = 0
fgFlujosCompra.Tag = H_COMPRA
fgFlujosVenta.Tag = H_VENTA

EtqMensaje.Caption = ""
'------------ Inicializa Objetos y Variables
Call MonYDocxMoneda(DatosPorMoneda(), TotDatPorMon)
Call IniciaVar

If cOperSwap = "Ingreso" Then
        
    etqNumOper.Visible = False
    cmdGrabar.Enabled = False
    ValorDolarObs = gsBAC_DolarObs
    
Else
    'Modificaciones
    
    etqNumOper.Visible = True
    Call BuscarDatos
    
    tabFlujos.TabEnabled(1) = True
    tabFlujos.TabEnabled(2) = True

    If cOperSwap = "ModificacionCartera" Then
     '   Call Deshabilitar
    End If
    cmdGrabar.Enabled = False
    
    ValorDolarObs = ValorMoneda(994, CStr(FechaCierre))
    
    Call SacarValoresSWMoneda(ValorAnt)
    
End If

End Sub

Private Sub IniciaFlujos(obj As Object)

With obj

    .Clear
    .FixedRows = 0
    .Rows = 2
    .FixedRows = 1
    .FixedCols = 1
    
    .Cols = 13
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
    .TextMatrix(0, 11) = "MontoUSD"
    .TextMatrix(0, 12) = "MontoCLP"
            
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
    .ColWidth(11) = TextWidth("")
    .ColWidth(12) = TextWidth("")
    
    obj.Col = obj.Cols - 1
    obj.Row = 0
    Do
        obj.CellAlignment = flexAlignCenterCenter
        obj.Col = obj.Col - 1
    Loop Until obj.Col = 0
     
    .RowHeightMin = 300

End With

End Sub


Private Function GeneraFlujos(objBase As Object, objCnv As Object, cTipo As String) As Boolean
Dim dFechaVencimiento, dFechaInicio, dFechaTermino As Date
Dim dFechaVencCap, dFechaVencInt, UltimoVcto, dFecha  As Date
Dim nPlazoMin, nPlazoMax, nFila, nPlazo, Amortiza As Integer
Dim nAmortiza#, nTotal#, nSaldo#, nInteres#, nTasa#, nSpread#, nBase%, nPrecio#, nMoneda%
Dim cnvAmortiza#, cnvTotal#, cnvSaldo#, cnvInteres#, cnvTasa#, cnvSpread#, cnvBase%
Dim lEspecial As Boolean
Dim DiaVcto, CodMon As Integer
Dim FactorUSDc As Double
Dim FactorUSDv As Double
Dim FactorCLPc As Double
Dim FactorCLPv As Double
Dim FactorCLP As Double
Dim MontoUSDc As Double
Dim MontoCLPv As Double
Dim MontoUSDv As Double
Dim MontoCLPc As Double

Dim CodMonV As Integer
Dim CodMonC As Integer
Dim FechaProceso As Date
Dim MonFuerteV, MonFuerteC As Integer
Dim FactorDiv As Integer
Dim DiasAmortCap As Integer



GeneraFlujos = False
    

    FechaProceso = IIf(cOperSwap = "Ingreso", gsBAC_Fecp, FechaCierre)
    
    If cmbMonedaVenta.ListIndex <> -1 Then
        CodMonV = cmbMonedaVenta.ItemData(cmbMonedaVenta.ListIndex)
    Else
        CodMonV = 994 'dolar  observado
    End If
   
    If cmbMonedaCompra.ListIndex <> -1 Then
        CodMonC = cmbMonedaCompra.ItemData(cmbMonedaCompra.ListIndex)
    Else
        CodMonC = 994 'dolar  observado
    End If
    
    FactorUSDc = 0:     FactorUSDv = 0
    FactorCLP = 0
    Dim ValMonedas As New clsMoneda
    
    If ValMonedas.LeerxCodigo(CodMonV) Then
        FactorUSDv = ValMonedas.vmValor    'equivalencia a 1 dolar
        MonFuerteV = ValMonedas.mnrefusd   'Caracteristica moneda ( fuerte o no)
    End If
    ValMonedas.Limpiar
    
    If optEntFisica.Value = True Then
        FactorUSDc = FactorUSDv
        MonFuerteC = MonFuerteV
    Else
        If ValMonedas.LeerxCodigo(CodMonC) Then
            FactorUSDc = ValMonedas.vmValor    'equivalencia a 1 dolar
            MonFuerteC = ValMonedas.mnrefusd   'Caracteristica moneda ( fuerte o no)
        End If
        ValMonedas.Limpiar
    End If
    
    Set ValMonedas = Nothing
    FactorCLP = ValorDolarObs

    '---- Inicializa Grillas
    Call IniciaFlujos(objBase)
    Call IniciaFlujos(objCnv)

    '---------Define periodo menor y mayor
    If nDiasCapital# > nDiasInteres# Then
        nPlazoMin = nDiasInteres#
        nPlazoMax = nDiasCapital#
    Else
       If nDiasCapital# > 0 Then
          nPlazoMin = nDiasCapital#
       Else
           nPlazoMin = nDiasInteres#
       End If
       nPlazoMax = nDiasInteres#
    End If
 
    If nDiasCapital# <= 0 Then
        DiasAmortCap = nDiasInteres#
        FactorDiv = nDiasInteres# 'ValorAmort(cmbAmortizaInteres, "M")
    Else
        DiasAmortCap = nDiasCapital#
        FactorDiv = nDiasCapital# 'ValorAmort(cmbAmortizaCapital, "M")
    End If
 
     '---- Es Especial
    dFecha = CreaFechaProx(txtFecInicio.Text, DiasAmortCap, Day(txtFecInicio.Text))
    'GoSub Fecha_Habil_Proximo
    dFechaVencimiento = dFecha
    lEspecial = (CDate(txtFecPrimerVcto.Text) <> dFechaVencimiento)

    '---- Define fechas para generar Flujos
    dFechaInicio = txtFecInicio.Text
    dFechaTermino = txtFecTermino.Text
    
            '---- Primer Vencimiento
    If lEspecial Then
        dFechaVencimiento = txtFecPrimerVcto.Text
        dFechaVencInt = dFechaVencimiento
        dFechaVencCap = dFechaVencimiento
    Else
        dFecha = CreaFechaProx(txtFecInicio.Text, nPlazoMin, Day(txtFecInicio.Text))
        'GoSub Fecha_Habil_Proximo
        dFechaVencimiento = dFecha
        dFechaVencInt = CreaFechaProx(txtFecInicio.Text, nDiasInteres, Day(txtFecInicio.Text))
        dFechaVencCap = CreaFechaProx(txtFecInicio.Text, DiasAmortCap, Day(txtFecInicio.Text))
    End If
    
    DiaVcto = Day(txtFecPrimerVcto.Text)
    
    '-------Definición Amortización de Capital
    
    If (nDiasCapital <= 0 Or txtFecPrimerVcto.Text = txtFecTermino.Text) And Not lEspecial Then
        Amortiza = 1
    Else
        Amortiza = (DateDiff("m", txtFecPrimerVcto.Text, dFechaTermino) / FactorDiv)
        Amortiza = IIf(Amortiza = 0, 1, Amortiza)
        Amortiza = Amortiza + 1
    End If
    
    
    Barra.Visible = True
    Barra.Min = 0
    Barra.Value = IIf(lEspecial, 0, 1)
    
    '---- Capital
    If cTipo = "C" Then
        '---- Base
        nSaldo = txtCapitalCompra.Tag
        nPrecio = lblTcCompra.Tag
        nMoneda = cmbMonedaCompra.Tag
        nTasa = txtTasaCompra.Text
        nSpread = txtSpreadCompra.Text
        nBase = cmbBaseCompra.Text
        '---- Cnv
        cnvTasa = txtTasaVenta.Text
        cnvSpread = txtSpreadVenta.Text
        cnvBase = cmbBaseVenta.Text
    Else
        '---- Base
        nSaldo = txtCapitalVenta.Tag
        nPrecio = CDbl(lblTcVenta.Caption)
        nMoneda = cmbMonedaVenta.Tag
        nTasa = txtTasaVenta.Text
        nSpread = txtSpreadVenta.Text
        nBase = cmbBaseVenta.Text
        '---- Cnv
        cnvTasa = txtTasaCompra.Text
        cnvSpread = txtSpreadCompra.Text
        cnvBase = cmbBaseCompra.Text
    End If
    
    nAmortiza = Round(nSaldo / Amortiza, 4) 'MONTO A AMORTIZAR
    
    Barra.Max = nAmortiza + 6
    
    If Amortiza = 1 Then
        dFechaVencCap = txtFecTermino.Text
    End If

    '---- Comienza a generar Fechas
    nFila = 0
    While dFechaVencimiento <= dFechaTermino
    
            Barra.Value = Barra.Value + 1
            MontoUSDv = 0:        MontoCLPv = 0:      MontoUSDc = 0:        MontoCLPc = 0
            
            '---- Llena Grillas base y conversion
            nFila = nFila + 1
            GoSub GeneraFlujo
                        
            nPlazo = DateDiff("d", CDate(dFechaInicio), CDate(dFechaVencimiento))
            cnvSaldo = CalculaMonto(LCase(cTipo), nSaldo, nPrecio, nMoneda)
            
            '---- Amortiza Interes
            dFecha = dFechaVencInt
            'GoSub Fecha_Habil_Proximo
            If CDate(dFechaVencimiento) = CDate(dFecha) Then
                If nBase = 30 Then
                    nInteres = Round(nSaldo * (nTasa / 100) * (Round(nPlazo / 30, 0) * 30 / 360), 4)
                Else
                    nInteres = Round(nSaldo * (nTasa / 100) * (nPlazo / nBase), 4)
                End If
                If cnvBase = 30 Then
                    cnvInteres = Round(cnvSaldo * ((cnvTasa / 100) + (cnvSpread / 100)) * (Round(nPlazo / 30, 0) * 30 / 360), 4)
                Else
                    cnvInteres = Round(cnvSaldo * ((cnvTasa / 100) + (cnvSpread / 100)) * (nPlazo / cnvBase), 4)
                End If
                '---- Amortización de Intereses
                objBase.TextMatrix(nFila, 3) = BacFormatoMonto(nInteres, 4)
                objCnv.TextMatrix(nFila, 3) = BacFormatoMonto(cnvInteres, 4)
                '---- Proxima Amortización de Interes
                dFecha = CreaFechaProx(dFechaVencInt, nDiasInteres, DiaVcto)
                dFechaVencInt = dFecha
            Else
                nInteres = 0
                cnvInteres = 0
            End If
        
            '---- Amortiza Capital
            dFecha = dFechaVencCap
            'GoSub Fecha_Habil_Proximo
            If CDate(dFechaVencimiento) = CDate(dFecha) Then
                If dFecha = dFechaTermino Then
                    nAmortiza = nSaldo
                    nSaldo = 0
                Else
                    nSaldo = nSaldo - nAmortiza
                End If
                cnvAmortiza = CalculaMonto(LCase(cTipo), nAmortiza, nPrecio, nMoneda)
                nInteres = CDbl(nInteres + nAmortiza)
                cnvInteres = CDbl(cnvInteres + cnvAmortiza)
                '---- Amortización de Capital
                objBase.TextMatrix(nFila, 2) = BacFormatoMonto(nAmortiza, 4)
                objCnv.TextMatrix(nFila, 2) = BacFormatoMonto(cnvAmortiza, 4)
                '---- Proxima Amortización de Capital
                dFecha = CreaFechaProx(dFechaVencCap, DiasAmortCap, DiaVcto)
                dFechaVencCap = dFecha
            End If
            
          'Monto en dolares
           MontoUSDc = IIf(MonFuerteC = 1, (nAmortiza * FactorUSDc), (BacDiv(nAmortiza, FactorUSDc)))
           ' A Pesos
           MontoCLPc = (MontoUSDc * FactorCLP)
           'Monto en dolares
           MontoUSDv = IIf(CDbl(MonFuerteV) = 1, (cnvAmortiza * FactorUSDv), (BacDiv(cnvAmortiza, FactorUSDv)))
           ' A Pesos
           MontoCLPv = MontoUSDv * FactorCLP
        
        'If CodMoneda = 999 Or CodMoneda = 998 Then
        '    ' A Pesos
        '    MontoCLPc = (InteresC * FactorUSDc)
        '    MontoCLPv = InteresV * FactorUSDc
        '    MontoCLPc = Round(MontoCLPc, 0)
        '    MontoCLPv = Round(MontoCLPv, 0)
        '
        '    'Monto en dolares
        '    MontoUSDc = (BacDiv(MontoCLPc, CDbl(FactorCLP)))
        '    MontoUSDc = Round(MontoUSDc, 3)
        '
        '    MontoUSDv = (BacDiv(MontoCLPv, CDbl(FactorCLP)))
        '    MontoUSDv = Round(MontoUSDv, 3)
        '
        'Else
        '
        '    'Monto en dolares
        '    MontoUSDc = IIf(Val(MonFuerteC) = 1, (InteresC * FactorUSDc), (BacDiv(InteresC, CDbl(FactorUSDc))))
        '    MontoUSDc = Round(MontoUSDc, 3)
        '    ' A Pesos
        '    MontoCLPc = (MontoUSDc * FactorCLP)
        '    'Monto en dolares
        '    MontoUSDv = IIf(Val(MonFuerteC) = 1, (InteresV * FactorUSDc), (BacDiv(InteresV, CDbl(FactorUSDc))))
        '    MontoUSDv = Round(MontoUSDv, 3)
        '    ' A Pesos
        '    MontoCLPv = MontoUSDv * FactorCLP
        'End If
        
        
            
            '---- Saldo Capital
            cnvSaldo = CalculaMonto(LCase(cTipo), nAmortiza + nSaldo, nPrecio, nMoneda) - cnvAmortiza
            objBase.TextMatrix(nFila, 5) = BacFormatoMonto(nSaldo, 5)
            objCnv.TextMatrix(nFila, 5) = BacFormatoMonto(cnvSaldo, 5)
            '---- Total
            objBase.TextMatrix(nFila, 4) = BacFormatoMonto(nInteres, 4)
            objCnv.TextMatrix(nFila, 4) = BacFormatoMonto(cnvInteres, 4)
            
            objBase.TextMatrix(nFila, 11) = MontoUSDc
            objBase.TextMatrix(nFila, 12) = MontoCLPc
            objCnv.TextMatrix(nFila, 11) = MontoUSDv
            objCnv.TextMatrix(nFila, 12) = MontoCLPv
        
            '---- Próximo vencimiento
            dFechaInicio = dFechaVencimiento
            
            dFecha = CreaFechaProx(dFechaVencimiento, nPlazoMin, DiaVcto)
            dFechaVencimiento = dFecha
            
            If dFechaVencimiento > dFechaTermino Then
                If Abs(DateDiff("d", CDate(dFecha), CDate(dFechaTermino))) <= 10 Then
                    dFechaVencimiento = dFechaTermino
                    dFechaVencInt = dFechaTermino
                    dFechaVencCap = dFechaTermino
                    dFecha = dFechaVencimiento
                    DiaVcto = Day(dFechaVencimiento)
                End If
            End If
            
            objBase.Rows = objBase.Rows + 1
            objCnv.Rows = objCnv.Rows + 1
    Wend
           
    objBase.Rows = nFila + 1
    objCnv.Rows = objBase.Rows

    GeneraFlujos = True
    Barra.Visible = False
    
    Exit Function
    
'Fecha_Habil_Proximo:
'        If Not BacEsHabil(CStr(dFecha)) Then
'            dFecha = BacProxHabil(CStr(dFecha))
'        End If
'        Return
    
GeneraFlujo:
        objBase.TextMatrix(nFila, 0) = Format(nFila, "#0")
        objBase.TextMatrix(nFila, 1) = Format(dFechaVencimiento, gsc_FechaDMA)
        objBase.TextMatrix(nFila, 2) = BacFormatoMonto(0, 4)
        objBase.TextMatrix(nFila, 3) = BacFormatoMonto(0, 4)
        objBase.TextMatrix(nFila, 4) = BacFormatoMonto(0, 4)
        objBase.TextMatrix(nFila, 6) = Format(dFechaInicio, gsc_FechaDMA)
        objBase.TextMatrix(nFila, 8) = 0
        objBase.TextMatrix(nFila, 10) = IIf(cModalidad = "C", "Compensación" & Space(50) & cModalidad _
                                                , "Ent. Fisica" & Space(50) & cModalidad)
                                                
        objCnv.TextMatrix(nFila, 0) = Format(nFila, "#0")
        objCnv.TextMatrix(nFila, 1) = Format(dFechaVencimiento, gsc_FechaDMA)
        objCnv.TextMatrix(nFila, 2) = BacFormatoMonto(0, 4)
        objCnv.TextMatrix(nFila, 3) = BacFormatoMonto(0, 4)
        objCnv.TextMatrix(nFila, 4) = BacFormatoMonto(0, 4)
        objCnv.TextMatrix(nFila, 6) = Format(dFechaInicio, gsc_FechaDMA)
        objCnv.TextMatrix(nFila, 8) = 0
        objCnv.TextMatrix(nFila, 10) = IIf(cModalidad = "C", "Compensación" & Space(50) & cModalidad _
                                                , "Ent. Fisica" & Space(50) & cModalidad)
    
        Return

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
Dim i           As Integer
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
     
     For i = 0 To .Cols - 1
         .Col = i
         .CellAlignment = flexAlignCenterCenter
     Next
     
    .RowHeightMin = 300

End With

'---- Flujos
'Call CalculaCortes(fgrdFlujos)
'If fgrdFlujos.TextMatrix(1, 1) = "X" Then
'    Exit Sub
'End If

'If fgrdFlujos = fgFlujosCompra Then
'    Barra.Max = (fgrdFlujos.Rows * 2) + 5
'End If

'---- Calculo de Intereses
Barra.Value = Barra.Value + 1                               'Incremento Barra (avanza)
'Call CalculaInteres(fgrdFlujos, nMonto, nTasa, nBase)

Set fgrdFlujos = Nothing
 
End Sub
Sub InicializaGrid(ByRef grid As Object)

Dim i As Integer

With grid

     .Clear
     .FixedRows = 0
     .Rows = 2
     '.Rows = nCortes
     .FixedRows = 1
     .FixedCols = 1
     .Cols = 13
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
     .TextMatrix(0, 10) = "Modalidad"
    
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
     
     For i = 0 To .Cols - 1
         .Col = i
         .CellAlignment = flexAlignCenterCenter
     Next
     
    .RowHeightMin = 300

     
End With
 

End Sub

Private Sub Form_Unload(Cancel As Integer)

    If cOperSwap = "ModificacionCartera" Or cOperSwap = "Modificacion" Then
        BacConsultaOper.Show
    End If
    
End Sub

Private Sub optCompensa_Click()

cModalidad = "C"

End Sub

Private Sub optCompensa_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbCarteraInversion.SetFocus

End Sub

Private Sub optCompra_Click()
Dim i As Integer
Dim nPaso As String

If Not lEntrada Then
    optVenta_Click
    cTipoOperacion$ = H_COMPRA
    Exit Sub
End If

cTipoOperacion$ = H_COMPRA

cmbMonedaVenta.Tag = 998
Call bacBuscarCombo(cmbMonedaVenta, Val(cmbMonedaVenta.Tag))
objMoneda.CargaObjectos cmbMonedaPagamos, "PAGADORA"
If False Then   '--- CHECKED
Call LlenaMonDocPago(cmbMonedaPagamos, DatosPorMoneda(), 1, _
                    Val(cmbMonedaVenta.Tag), TotDatPorMon, 1)
End If
cmbMonedaCompra.Tag = 13
If bacBuscarCombo(cmbMonedaCompra, Val(cmbMonedaCompra.Tag)) = 0 Then
    cmbMonedaCompra.Tag = 994
    Call bacBuscarCombo(cmbMonedaCompra, Val(cmbMonedaCompra.Tag))
End If
objMoneda.CargaObjectos cmbMonedaRecibimos, "PAGADORA"

If False Then   '--- CHECKED
Call LlenaMonDocPago(cmbMonedaRecibimos, DatosPorMoneda(), 1, _
                    Val(cmbMonedaCompra.Tag), TotDatPorMon, 1)
End If
cmbMonedaVenta.Enabled = True
cmbMonedaCompra.Enabled = False
lEntrada = False

End Sub


Private Sub optCompra_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then cmbMonedaVenta.SetFocus

End Sub


Private Sub optEntFisica_Click()

cModalidad = "E"

End Sub

Private Sub optEntFisica_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 Then cmbCarteraInversion.SetFocus
    
End Sub

Private Sub optVenta_Click()
Dim nPaso As String
Dim nPaso1 As String
Dim CodPaso As Integer
Dim CodPaso1 As Integer
Dim CodTasaC As Integer
Dim CodTasaV As Integer
Dim i As Integer

Dim Traspaso(9, 2) As Variant ' Columna 1 Lo que es de Compra y 2 de Venta

cTipoOperacion$ = H_VENTA

For i = 1 To 9    ' inicializa en cero
    Traspaso(i, 1) = 0
    Traspaso(i, 2) = 0
Next

'---- Cambia Moneda
Traspaso(1, 1) = Val(cmbMonedaVenta.Tag)
Traspaso(1, 2) = Val(cmbMonedaCompra.Tag)
'lblTcCompra.Tag
Traspaso(2, 1) = lblTcVenta.Tag
Traspaso(2, 2) = lblTcCompra.Tag
Traspaso(3, 1) = CDbl(txtCapitalVenta.Tag)
Traspaso(3, 2) = CDbl(txtCapitalCompra.Tag)
'---- Cambia Tasa
If cmbTasaVenta.ListIndex > -1 Then
    Traspaso(4, 1) = cmbTasaVenta.ItemData(cmbTasaVenta.ListIndex)
End If
If cmbTasaCompra.ListIndex > -1 Then
    Traspaso(4, 2) = cmbTasaCompra.ItemData(cmbTasaCompra.ListIndex)
End If
'---- Cambia Valor Tasa
Traspaso(5, 1) = CDbl(txtTasaVenta.Text)
Traspaso(5, 2) = CDbl(txtTasaCompra.Text)
'---- Cambia Spread
Traspaso(6, 1) = CDbl(txtSpreadVenta.Text)
Traspaso(6, 2) = CDbl(txtSpreadCompra.Text)
'---- Cambia Base
Traspaso(7, 1) = cmbBaseVenta
Traspaso(7, 2) = cmbBaseCompra
'---- Cambia Moneda de Pago
If cmbMonedaPagamos.ListIndex > -1 Then
    Traspaso(8, 1) = cmbMonedaPagamos.ItemData(cmbMonedaPagamos.ListIndex)
End If
If cmbMonedaRecibimos.ListIndex > -1 Then
    Traspaso(8, 2) = cmbMonedaRecibimos.ItemData(cmbMonedaRecibimos.ListIndex)
End If
'---- Cambia documento de Pago
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
' TRASPASO DE DATOS A TEXTOS Y COMBOS
'**** Posiciona Moneda
Call bacBuscarCombo(cmbMonedaCompra, Val(Traspaso(1, 1)))
Call bacBuscarCombo(cmbMonedaVenta, Val(Traspaso(1, 2)))
cmbMonedaCompra.Tag = Val(Traspaso(1, 1))
cmbMonedaVenta.Tag = Val(Traspaso(1, 2))
cmbMonedaCompra.Enabled = Not optCompra.Value
cmbMonedaVenta.Enabled = Not cmbMonedaCompra.Enabled
'**** Valores de Conversion
lblTcCompra.Caption = Traspaso(2, 1)
lblTcCompra.Tag = Traspaso(2, 1)
lblTcVenta.Caption = Traspaso(2, 2)
lblTcVenta.Tag = Traspaso(2, 2)

'**** Valores de Capital
txtCapitalCompra.Tag = Traspaso(3, 1)
txtCapitalCompra.Text = Traspaso(3, 1)
txtCapitalVenta.Text = Traspaso(3, 2)
txtCapitalVenta.Tag = Traspaso(3, 2)
'**** Posiciona Tasas
Call bacBuscarCombo(cmbTasaCompra, Traspaso(4, 1))
Call bacBuscarCombo(cmbTasaVenta, Traspaso(4, 2))
'**** Valores de Tasas
txtTasaCompra.Text = Traspaso(5, 1)
txtTasaVenta.Text = Traspaso(5, 2)
'**** Valores de Spread
txtSpreadCompra.Text = Traspaso(6, 1)
txtSpreadVenta.Text = Traspaso(6, 2)
'**** Posiciona Base
Call BacBuscaTxtCombo(cmbBaseCompra, CStr(Traspaso(7, 1)))
Call BacBuscaTxtCombo(cmbBaseVenta, CStr(Traspaso(7, 2)))
''**** Posiciona Moneda de pago
'Call LlenaMonDocPago(cmbMonedaRecibimos, DatosPorMoneda(), 1, _
                    Traspaso(1, 1), TotDatPorMon, 1)
'Call LlenaMonDocPago(cmbMonedaPagamos, DatosPorMoneda(), 1, _
                    Traspaso(1, 2), TotDatPorMon, 1)
'**** Posiciona Moneda de pago
Call bacBuscarCombo(cmbMonedaRecibimos, Traspaso(8, 1))
Call bacBuscarCombo(cmbMonedaPagamos, Traspaso(8, 2))

'Call LlenaMonDocPago(cmbDocumentoRecibimos, DatosPorMoneda(), 1, _
                     Traspaso(8, 1), TotDatPorMon, 2)
    
'Call LlenaMonDocPago(cmbDocumentoPagamos, DatosPorMoneda(), 1, _
                     Traspaso(8, 2), TotDatPorMon, 2)

Call bacBuscarCombo(cmbDocumentoRecibimos, Traspaso(9, 1))
Call bacBuscarCombo(cmbDocumentoPagamos, Traspaso(9, 2))

'si esta deshabilitado recalcula
If tabFlujos.TabEnabled(1) = True Then
    cmdCalcula_Click
End If

Exit Sub


cTipoOperacion$ = H_VENTA

'---- Cambia Moneda
CodPaso = cmbMonedaVenta.Tag
nPaso = lblTcVenta.Caption
CodPaso1 = Val(cmbMonedaCompra.Tag)
nPaso1 = lblTcCompra.Caption

CodTasaV = 0
CodTasaC = 0
If cmbTasaVenta.ListIndex > -1 Then
    CodTasaV = cmbTasaVenta.ItemData(cmbTasaVenta.ListIndex)
End If
If cmbTasaCompra.ListIndex > -1 Then
    CodTasaC = cmbTasaCompra.ItemData(cmbTasaCompra.ListIndex)
End If

Call bacBuscarCombo(cmbMonedaVenta, CodPaso1)

'cmbMonedaVenta.Tag = codPaso1
Call bacBuscarCombo(cmbMonedaCompra, CodPaso)

'cmbMonedaCompra.Tag = codPaso
lblTcVenta.Caption = nPaso1
lblTcCompra.Caption = nPaso

cmbMonedaVenta.Enabled = False ' ((Val(cmbMonedaVenta.Tag) <> 13) And optVenta.Value <> True)
cmbMonedaCompra.Enabled = True '((Val(cmbMonedaCompra.Tag) <> 13) And optCompra.Value <> True)

'---- Cambia Montos
nPaso = txtCapitalVenta.Tag
txtCapitalVenta.Tag = txtCapitalCompra.Tag
txtCapitalCompra.Tag = nPaso
txtCapitalVenta.Text = txtCapitalVenta.Tag
txtCapitalCompra.Text = txtCapitalCompra.Tag

'---- Cambia Tasa & Valor
    
Call bacBuscarCombo(cmbTasaVenta, CodTasaC)
Call bacBuscarCombo(cmbTasaCompra, CodTasaV)


nPaso = CDbl(txtTasaVenta.Text)
txtTasaVenta.Text = txtTasaCompra.Text
txtTasaCompra.Text = nPaso

'---- Cambia Spread
nPaso = CDbl(txtSpreadVenta.Text)
txtSpreadVenta.Text = txtSpreadCompra.Text
txtSpreadCompra.Text = nPaso

'---- Cambia Base
nPaso = cmbBaseVenta
Call BacBuscaTxtCombo(cmbBaseVenta, cmbBaseCompra)
Call BacBuscaTxtCombo(cmbBaseCompra, nPaso)

'---- Cambia Pago
If cmbMonedaRecibimos.ListIndex > -1 Then
    CodPaso = cmbMonedaRecibimos.ItemData(cmbMonedaRecibimos.ListIndex)
End If
If cmbMonedaPagamos.ListIndex > -1 Then
    CodPaso1 = cmbMonedaPagamos.ItemData(cmbMonedaPagamos.ListIndex)
End If
Call LlenaMonDocPago(cmbMonedaRecibimos, DatosPorMoneda(), 1, _
                    SacaCodigo(cmbMonedaCompra), TotDatPorMon, 1)
    
Call LlenaMonDocPago(cmbMonedaPagamos, DatosPorMoneda(), 1, _
                    SacaCodigo(cmbMonedaVenta), TotDatPorMon, 1)
    
Call bacBuscarCombo(cmbMonedaRecibimos, Val(CodPaso1))
Call bacBuscarCombo(cmbMonedaPagamos, CodPaso)

'---- Documento
If cmbDocumentoRecibimos.ListIndex > -1 Then
    CodPaso = cmbDocumentoRecibimos.ItemData(cmbDocumentoRecibimos.ListIndex)
End If
If cmbDocumentoPagamos.ListIndex > -1 Then
    CodPaso1 = cmbDocumentoPagamos.ItemData(cmbDocumentoPagamos.ListIndex)
End If

Call LlenaMonDocPago(cmbDocumentoRecibimos, DatosPorMoneda(), 1, _
                    SacaCodigo(cmbMonedaRecibimos), TotDatPorMon, 2)
    
Call LlenaMonDocPago(cmbDocumentoPagamos, DatosPorMoneda(), 1, _
                    SacaCodigo(cmbMonedaPagamos), TotDatPorMon, 2)

Call bacBuscarCombo(cmbDocumentoRecibimos, CodPaso1)
Call bacBuscarCombo(cmbDocumentoPagamos, CodPaso)

'si esta deshabilitado recalcula
If tabFlujos.TabEnabled(1) = True Then
    cmdCalcula_Click
End If

End Sub



Private Sub optVenta_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then cmbMonedaCompra.SetFocus

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
      Call cmdCalcula_Click
   Case 2
      Call cmdLimpia_Click
   Case 3
      Call cmdGrabar_Click
   Case 4
      Call cmdSalir_Click
End Select
End Sub

Private Sub txtAmortiza_KeyPress(KeyAscii As Integer)
    Dim nTasa  As Double
    
    If KeyAscii = 13 Then
        With fgFlujosCompra
        
        If .Col = 2 Then
            If txtAmortiza.Text <> .TextMatrix(.Row, 2) Then
                 .TextMatrix(.Row, 2) = txtAmortiza.Text
                 fgFlujosVenta.TextMatrix(.Row, 2) = CalculaMonto("v", txtAmortiza.Tag, lblTcVenta.Tag, cmbMonedaVenta.Tag)
                nTasa = CDbl(txtTasaCompra.Text) + CDbl(txtSpreadCompra.Text)
                Call CalculoInteresBonos(cmbBaseCompra, nTasa, txtCapitalCompra.Text, fgFlujosCompra)
                nTasa = CDbl(txtTasaVenta.Text) + CDbl(txtSpreadVenta.Text)
                Call CalculoInteresBonos(cmbBaseVenta, nTasa, txtCapitalVenta.Text, fgFlujosVenta)
            End If
        End If
        txtAmortiza.Visible = False
        txtAmortiza.Text = 0
        .SetFocus
        
        End With
    End If
    
End Sub

Function CalculoInteresBonos(BaseStr As String, nTasa As Double, nMonto As Double, ByRef Grd As Object)
    Dim Base As Double
    Dim FechaAmortiza As Date
    Dim FechaVencAnt, FecVAnt As Date
    Dim DiasAmortCap, DiasAmortInt As Integer
    Dim DiasDif  As Integer
    Dim cuenta As Integer
    Dim MontoAmortiza, MontoCapital, MontoGrd As Double
    Dim Interes, Plazo, MontoCalcAmort As Double
    Dim RestoCapital As Double
    Dim TotalVenc As Double
    'Barra.Value = Barra.Value + 1                               'Incremento Barra (avanza)
   
    Base = BaseStr    'Base asignada para calculo
    FechaVencAnt = CDate(txtFecInicio.Text)
    MontoAmortiza = nMonto 'CDbl((txtCapital.Text))
    
    With Grd
    For cuenta = 1 To .Rows - 1
    
        FechaAmortiza = .TextMatrix(cuenta, 1)
        MontoGrd = Grd.TextMatrix(cuenta, 2)
        RestoCapital = CDbl(Grd.TextMatrix(cuenta, 2)) 'MontoAmortCap
        DiasDif = CDate(FechaAmortiza) - CDate(FechaVencAnt)
        FecVAnt = FechaVencAnt
        FechaVencAnt = Grd.TextMatrix(cuenta, 1)
        
        If Base = 30 Then
            Interes = Round(MontoAmortiza * (nTasa / 100) * (Round(DiasDif / 30, 0) * 30 / 360), 4)
        Else
            Interes = Round(MontoAmortiza * (nTasa / 100) * (DiasDif / Base), 4)
        End If
        
        'MontoCalcAmort = (nTasa / 100)
        'Plazo = DiasDif / Base
        'Interes = MontoAmortiza * (MontoCalcAmort) * (Plazo)
        
        '***
        TotalVenc = MontoGrd + Interes
        MontoAmortiza = MontoAmortiza - RestoCapital
        
        '***Traspaso de Datos a Arreglo
        .TextMatrix(cuenta, 0) = cuenta + 1
        .TextMatrix(cuenta, 1) = Format(FechaAmortiza, gsc_FechaDMA)
        .TextMatrix(cuenta, 2) = Format(MontoGrd, "###,###,###,##0.###0")
        .TextMatrix(cuenta, 3) = Format(Interes, "###,###,###,##0.###0")
        .TextMatrix(cuenta, 4) = Format(TotalVenc, "###,###,###,##0.###0")
        .TextMatrix(cuenta, 5) = MontoAmortiza
        .TextMatrix(cuenta, 6) = Format(FechaVencAnt, gsc_FechaDMA)  ' O INICIO DEL FLUJO
        '***
    Next
    End With
    
End Function

Private Sub txtAmortiza_KeyUp(KeyCode As Integer, Shift As Integer)
    
    With fgFlujosCompra
    Select Case KeyCode
        Case 38
            'sube
            If .Row > 1 Then .Row = .Row - 1
         Case 40
            'baja
            If .Row > 0 And .Row < .Rows - 1 Then .Row = .Row + 1
    End Select
    End With
    
End Sub


Private Sub txtAmortizaVen_KeyPress(KeyAscii As Integer)

Dim nTasa  As Double
    
    If KeyAscii = 13 Then
        With fgFlujosVenta
        
        If .Col = 2 Then
            If txtAmortizaVen.Text <> .TextMatrix(.Row, 2) Then
                 .TextMatrix(.Row, 2) = txtAmortizaVen.Text
                 fgFlujosCompra.TextMatrix(.Row, 2) = CalculaMonto("v", txtAmortizaVen.Tag, lblTcCompra.Tag, cmbMonedaVenta.Tag)
                nTasa = Val(txtTasaCompra.Text) + Val(txtSpreadCompra.Text)
                Call CalculoInteresBonos(cmbBaseCompra, nTasa, txtCapitalCompra.Text, fgFlujosCompra)
                nTasa = Val(txtTasaVenta.Text) + Val(txtSpreadVenta.Text)
                Call CalculoInteresBonos(cmbBaseVenta, nTasa, txtCapitalVenta.Text, fgFlujosVenta)
            End If
        End If
        txtAmortizaVen.Visible = False
        txtAmortizaVen.Text = 0
        .SetFocus
        
        End With
    End If

End Sub


Private Sub txtCapitalCompra_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then SendKeys ("{Tab}")
   
End Sub

Private Sub txtCapitalCompra_LostFocus()
    
    txtCapitalCompra.Tag = CDbl(txtCapitalCompra.Text)
    Call CalculaMonto("C", Val(txtCapitalCompra.Tag), Val(lblTcCompra.Tag), Val(cmbMonedaCompra.Tag))
    
End Sub



Private Sub txtCapitalVenta_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then SendKeys ("{Tab}")

End Sub

Private Sub txtCapitalVenta_LostFocus()

    'txtCapitalVenta.Tag = BacStrTran(txtCapitalVenta.Text, gsc_SeparadorMiles, "")
    txtCapitalVenta.Tag = CDbl(txtCapitalVenta.Text)
    Call CalculaMonto("V", Val(txtCapitalVenta.Tag), Val(lblTcVenta.Tag), Val(cmbMonedaVenta.Tag))

End Sub


Private Sub txtCliente_DblClick()

    txtRut_DblClick
    
End Sub

Private Sub txtCliente_KeyPress(KeyAscii As Integer)
Dim Cliente As New clsCliente
    
    If KeyAscii = 13 Then
        
        If Len(Trim(txtCliente)) <= 5 And txtRut = "" Then

            If Not Cliente.LeerxNombre(Trim(txtCliente)) Then
                MsgBox "No Existe Cliente con Nombre similar!", vbExclamation, Msj
                Exit Sub
            End If
            
            txtRut = Format(Cliente.clrut, "###,###,###") & "-" & Cliente.cldv
            txtCliente = Cliente.clnombre
            txtCliente.Tag = Cliente.clcodigo
            
            Call Cliente.CargaOperador(cmbOperador, Cliente.clrut, Cliente.clcodigo)
                    
        Else
            SendKeys ("{Tab}")
        End If
    
    End If

    Set Cliente = Nothing

End Sub

Private Sub txtFecInicio_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        If ValidaFechasIngreso(1) Then
            SendKeys ("{Tab}")
        End If
    End If
    
End Sub

Private Sub txtFecInicio_LostFocus()

    Call ValidaFechasIngreso(1)

    

End Sub

Private Sub txtFecPrimerVcto_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        If ValidaFechasIngreso(2) Then
            SendKeys ("{Tab}")
        End If
    End If
    
End Sub

Private Sub txtFecPrimerVcto_LostFocus()

    Call ValidaFechasIngreso(2)
    
    If DateDiff("d", txtFecTermino.Text, txtFecPrimerVcto.Text) > 0 Then
        txtFecTermino.Text = txtFecPrimerVcto.Text
    End If

End Sub


Private Sub txtFecTermino_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        If ValidaFechasIngreso(3) Then
            SendKeys ("{Tab}")
        End If
    End If
    
End Sub

Private Sub txtRut_DblClick()
Dim Cliente As New clsCliente
    
    If Not Cliente.Ayuda("") Then
        MsgBox "No Existen Datos para ayuda solicitada", vbExclamation, Msj
        Exit Sub
    End If
    
    BacAyudaSwap.Tag = "Cliente"
    BacAyudaSwap.Show 1
    
    If giAceptar Then
        If Cliente.LeerxRut(Val(gsCodigo), Val(gsCodCli)) Then
            txtRut = Format(Cliente.clrut, "###,###,###") & "-" & Cliente.cldv
            txtRut.Tag = Cliente.clrut
            txtCliente = Cliente.clnombre
            txtCliente.Tag = Cliente.clcodigo
            Cliente.CargaOperador cmbOperador, Cliente.clrut, Cliente.clcodigo
        End If
    End If
    
    Set Cliente = Nothing

End Sub

Private Sub txtRut_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 Then
        If txtRut <> "" Then
            If IsNumeric(txtRut) Then
                Call BuscaCliente(txtRut)
            Else
                SendKeys ("{Tab}")
            End If
        End If
    End If
    
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

