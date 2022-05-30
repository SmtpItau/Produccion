VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacOpeSwapTasa 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Swaps de Tasas"
   ClientHeight    =   6360
   ClientLeft      =   1425
   ClientTop       =   2325
   ClientWidth     =   9600
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6360
   ScaleWidth      =   9600
   ShowInTaskbar   =   0   'False
   Begin VB.TextBox txtFlujoTasa 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   3960
      TabIndex        =   44
      Text            =   "999.999999"
      ToolTipText     =   "Tasa Flujo"
      Top             =   5520
      Width           =   1125
   End
   Begin VB.TextBox txtFlujoMonto 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   1680
      TabIndex        =   43
      Text            =   "999,999,999,999.9999"
      ToolTipText     =   "Monto Amortización de Capital"
      Top             =   5520
      Width           =   2205
   End
   Begin VB.TextBox txtFlujoVence 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   360
      TabIndex        =   42
      Text            =   "dd/mm/yyyy"
      ToolTipText     =   "Fecha Vencimiento del Flujo"
      Top             =   5520
      Width           =   1245
   End
   Begin TabDlg.SSTab tabFlujos 
      Height          =   2250
      Left            =   135
      TabIndex        =   35
      Top             =   3240
      Width           =   9375
      _ExtentX        =   16536
      _ExtentY        =   3969
      _Version        =   327680
      TabHeight       =   520
      TabCaption(0)   =   "Definiciones"
      TabPicture(0)   =   "Bacoswap.frx":0000
      Tab(0).ControlCount=   5
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "lblSwapTasa(15)"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "lblSwapTasa(16)"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "lblSwapTasa(17)"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "cmbAmortizaCapital"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "cmbAmortizaInteres"
      Tab(0).Control(4).Enabled=   0   'False
      TabCaption(1)   =   "Compramos"
      TabPicture(1)   =   "Bacoswap.frx":001C
      Tab(1).ControlCount=   6
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "lblSwapTasaFlujos(0)"
      Tab(1).Control(0).Enabled=   0   'False
      Tab(1).Control(1)=   "lblSwapTasaFlujos(1)"
      Tab(1).Control(1).Enabled=   0   'False
      Tab(1).Control(2)=   "lblSwapTasaFlujos(2)"
      Tab(1).Control(2).Enabled=   0   'False
      Tab(1).Control(3)=   "lblSwapTasaFlujos(3)"
      Tab(1).Control(3).Enabled=   0   'False
      Tab(1).Control(4)=   "lblSwapTasaFlujos(4)"
      Tab(1).Control(4).Enabled=   0   'False
      Tab(1).Control(5)=   "lstFlujos(0)"
      Tab(1).Control(5).Enabled=   0   'False
      TabCaption(2)   =   "Vendemos"
      TabPicture(2)   =   "Bacoswap.frx":0038
      Tab(2).ControlCount=   1
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "MSFlexGrid1"
      Tab(2).Control(0).Enabled=   0   'False
      Begin MSFlexGridLib.MSFlexGrid MSFlexGrid1 
         Height          =   1815
         Left            =   -74955
         TabIndex        =   50
         Top             =   360
         Width           =   9285
         _ExtentX        =   16378
         _ExtentY        =   3201
         _Version        =   327680
         Rows            =   4
         Cols            =   5
         FixedCols       =   0
      End
      Begin VB.ListBox lstFlujos 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1530
         Index           =   0
         Left            =   -74820
         TabIndex        =   41
         Top             =   600
         Width           =   9015
      End
      Begin VB.ComboBox cmbAmortizaInteres 
         Height          =   315
         Left            =   1320
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   39
         ToolTipText     =   "Moneda Capital"
         Top             =   1560
         Width           =   2000
      End
      Begin VB.ComboBox cmbAmortizaCapital 
         Height          =   315
         Left            =   1320
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   37
         ToolTipText     =   "Moneda Capital"
         Top             =   1080
         Width           =   2000
      End
      Begin VB.Label lblSwapTasaFlujos 
         AutoSize        =   -1  'True
         Caption         =   "Total"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   4
         Left            =   -68160
         TabIndex        =   49
         Top             =   360
         Width           =   525
      End
      Begin VB.Label lblSwapTasaFlujos 
         AutoSize        =   -1  'True
         Caption         =   "Interes"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   3
         Left            =   -69840
         TabIndex        =   48
         Top             =   360
         Width           =   735
      End
      Begin VB.Label lblSwapTasaFlujos 
         AutoSize        =   -1  'True
         Caption         =   "Tasa"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   2
         Left            =   -71040
         TabIndex        =   47
         Top             =   360
         Width           =   420
      End
      Begin VB.Label lblSwapTasaFlujos 
         AutoSize        =   -1  'True
         Caption         =   "Amortización"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   1
         Left            =   -73320
         TabIndex        =   46
         Top             =   360
         Width           =   1260
      End
      Begin VB.Label lblSwapTasaFlujos 
         AutoSize        =   -1  'True
         Caption         =   "Vencimiento"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   0
         Left            =   -74760
         TabIndex        =   45
         Top             =   360
         Width           =   1155
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Interes"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   17
         Left            =   360
         TabIndex        =   40
         Top             =   1560
         Width           =   570
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
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   16
         Left            =   360
         TabIndex        =   38
         Top             =   1080
         Width           =   630
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Amortización de ..."
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   15
         Left            =   360
         TabIndex        =   36
         Top             =   600
         Width           =   1545
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
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   3060
      Left            =   6840
      TabIndex        =   24
      Top             =   75
      Width           =   2655
      Begin VB.ComboBox cmbTasaVenta 
         Height          =   315
         Left            =   720
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   29
         ToolTipText     =   "Moneda Capital"
         Top             =   360
         Width           =   1785
      End
      Begin VB.TextBox txtTasaVenta 
         Height          =   285
         Left            =   1200
         TabIndex        =   28
         Text            =   "999.999999"
         ToolTipText     =   "Monto Capital"
         Top             =   840
         Width           =   1035
      End
      Begin VB.ComboBox cmbBaseVenta 
         Height          =   315
         Left            =   1200
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   27
         ToolTipText     =   "Moneda Capital"
         Top             =   1320
         Width           =   1305
      End
      Begin VB.ComboBox cmbMonedaPagamos 
         Height          =   315
         Left            =   120
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   26
         ToolTipText     =   "Moneda Capital"
         Top             =   2040
         Width           =   2385
      End
      Begin VB.ComboBox cmbDocumentoPagamos 
         Height          =   315
         Left            =   120
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   25
         ToolTipText     =   "Moneda Capital"
         Top             =   2520
         Width           =   2385
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Tasa"
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
         Index           =   14
         Left            =   120
         TabIndex        =   34
         Top             =   360
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
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   13
         Left            =   120
         TabIndex        =   33
         Top             =   840
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
         Left            =   2280
         TabIndex        =   32
         Top             =   840
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
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   11
         Left            =   120
         TabIndex        =   31
         Top             =   1320
         Width           =   1035
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Pagamos"
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
         Index           =   10
         Left            =   120
         TabIndex        =   30
         Top             =   1800
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
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   3060
      Left            =   4080
      TabIndex        =   13
      Top             =   75
      Width           =   2655
      Begin VB.ComboBox cmbDocumentoRecibimos 
         Height          =   315
         Left            =   120
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   23
         ToolTipText     =   "Moneda Capital"
         Top             =   2520
         Width           =   2385
      End
      Begin VB.ComboBox cmbMonedaRecibimos 
         Height          =   315
         Left            =   120
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   21
         ToolTipText     =   "Moneda Capital"
         Top             =   2040
         Width           =   2385
      End
      Begin VB.ComboBox cmbBaseCompra 
         Height          =   315
         Left            =   1200
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   19
         ToolTipText     =   "Moneda Capital"
         Top             =   1320
         Width           =   1305
      End
      Begin VB.TextBox txtTasaCompra 
         Height          =   285
         Left            =   1200
         TabIndex        =   16
         Text            =   "999.999999"
         ToolTipText     =   "Monto Capital"
         Top             =   840
         Width           =   1035
      End
      Begin VB.ComboBox cmbTasaCompra 
         Height          =   315
         Left            =   720
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   14
         ToolTipText     =   "Moneda Capital"
         Top             =   360
         Width           =   1785
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Recibimos"
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
         Index           =   9
         Left            =   120
         TabIndex        =   22
         Top             =   1800
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
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   8
         Left            =   120
         TabIndex        =   20
         Top             =   1320
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
         Left            =   2280
         TabIndex        =   18
         Top             =   840
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
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   6
         Left            =   120
         TabIndex        =   17
         Top             =   840
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
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   5
         Left            =   120
         TabIndex        =   15
         Top             =   360
         Width           =   555
      End
   End
   Begin VB.Frame fraOperacion 
      Height          =   3015
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3855
      Begin VB.ComboBox cmbCarteraInversion 
         Height          =   315
         Left            =   1200
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   11
         ToolTipText     =   "Cartera de Inversión"
         Top             =   2520
         Width           =   2505
      End
      Begin VB.TextBox txtFecTermino 
         Height          =   285
         Left            =   2040
         TabIndex        =   9
         Text            =   "dd/mm/yyyy"
         ToolTipText     =   "Fecha Termino de Contrato"
         Top             =   2040
         Width           =   1665
      End
      Begin VB.TextBox txtFecInicio 
         Height          =   285
         Left            =   2040
         TabIndex        =   7
         Text            =   "dd/mm/yyyy"
         ToolTipText     =   "Fecha Inicio de Contrato"
         Top             =   1680
         Width           =   1665
      End
      Begin VB.OptionButton optVenta 
         Caption         =   "&Vendemos"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   375
         Left            =   2040
         Style           =   1  'Graphical
         TabIndex        =   6
         Top             =   240
         Width           =   1575
      End
      Begin VB.OptionButton optCompra 
         Caption         =   "&Compramos"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   375
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   5
         Top             =   240
         Value           =   -1  'True
         Width           =   1575
      End
      Begin VB.ComboBox cmbMoneda 
         Height          =   315
         Left            =   1200
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   4
         ToolTipText     =   "Moneda Capital"
         Top             =   720
         Width           =   2500
      End
      Begin VB.TextBox txtCapital 
         Height          =   285
         Left            =   1200
         TabIndex        =   2
         Text            =   "0"
         ToolTipText     =   "Monto Capital"
         Top             =   1080
         Width           =   2500
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Cartera"
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
         Index           =   4
         Left            =   120
         TabIndex        =   12
         Top             =   2520
         Width           =   795
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Fecha Termino"
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
         Index           =   3
         Left            =   120
         TabIndex        =   10
         Top             =   2040
         Width           =   1515
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Fecha Inicio"
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
         Index           =   2
         Left            =   120
         TabIndex        =   8
         Top             =   1680
         Width           =   1515
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Capital"
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
         Index           =   1
         Left            =   120
         TabIndex        =   3
         Top             =   1080
         Width           =   795
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Moneda"
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
         Index           =   0
         Left            =   120
         TabIndex        =   1
         Top             =   720
         Width           =   795
      End
   End
End
Attribute VB_Name = "BacOpeSwapTasa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Private Sub Form_Load()

    '------------- Tasas
    cmbTasaCompra.Clear
    cmbTasaCompra.AddItem "Fija": cmbTasaCompra.ItemData(cmbTasaCompra.NewIndex) = 0
    cmbTasaCompra.AddItem "Variable": cmbTasaCompra.ItemData(cmbTasaCompra.NewIndex) = 1
    
    cmbTasaVenta.Clear
    cmbTasaVenta.AddItem "Fija": cmbTasaVenta.ItemData(cmbTasaVenta.NewIndex) = 0
    cmbTasaVenta.AddItem "Variable": cmbTasaVenta.ItemData(cmbTasaVenta.NewIndex) = 1
    
    '------------- Bases
    cmbBaseCompra.Clear
    cmbBaseCompra.AddItem "Base  30": cmbBaseCompra.ItemData(cmbBaseCompra.NewIndex) = 30
    cmbBaseCompra.AddItem "Base 360": cmbBaseCompra.ItemData(cmbBaseCompra.NewIndex) = 360
    cmbBaseCompra.AddItem "Base 365": cmbBaseCompra.ItemData(cmbBaseCompra.NewIndex) = 365
    
    cmbBaseVenta.Clear
    cmbBaseVenta.AddItem "Base  30": cmbBaseVenta.ItemData(cmbBaseVenta.NewIndex) = 30
    cmbBaseVenta.AddItem "Base 360": cmbBaseVenta.ItemData(cmbBaseVenta.NewIndex) = 360
    cmbBaseVenta.AddItem "Base 365": cmbBaseVenta.ItemData(cmbBaseVenta.NewIndex) = 365
    
    '------------ Monedas de Pago
    cmbMonedaRecibimos.Clear
    cmbMonedaRecibimos.AddItem "Dólar Observado": cmbMonedaRecibimos.ItemData(cmbMonedaRecibimos.NewIndex) = 994
    cmbMonedaRecibimos.AddItem "Dólar Acuerdo": cmbMonedaRecibimos.ItemData(cmbMonedaRecibimos.NewIndex) = 995
    cmbMonedaRecibimos.AddItem "Dólar USA": cmbMonedaRecibimos.ItemData(cmbMonedaRecibimos.NewIndex) = 13
    cmbMonedaRecibimos.AddItem "Unidad de Fomento": cmbMonedaRecibimos.ItemData(cmbMonedaRecibimos.NewIndex) = 998
    cmbMonedaRecibimos.AddItem "Pesos": cmbMonedaRecibimos.ItemData(cmbMonedaRecibimos.NewIndex) = 999
    
    cmbMonedaPagamos.Clear
    cmbMonedaPagamos.AddItem "Dólar Observado": cmbMonedaPagamos.ItemData(cmbMonedaPagamos.NewIndex) = 994
    cmbMonedaPagamos.AddItem "Dólar Acuerdo": cmbMonedaPagamos.ItemData(cmbMonedaPagamos.NewIndex) = 995
    cmbMonedaPagamos.AddItem "Dólar USA": cmbMonedaPagamos.ItemData(cmbMonedaPagamos.NewIndex) = 13
    cmbMonedaPagamos.AddItem "Unidad de Fomento": cmbMonedaPagamos.ItemData(cmbMonedaPagamos.NewIndex) = 998
    cmbMonedaPagamos.AddItem "Pesos": cmbMonedaPagamos.ItemData(cmbMonedaPagamos.NewIndex) = 999
    
    '------------ Documentos de Pago
    cmbDocumentoRecibimos.Clear
    cmbDocumentoRecibimos.AddItem "No Aplicable": cmbDocumentoRecibimos.ItemData(cmbDocumentoRecibimos.NewIndex) = 0
    cmbDocumentoRecibimos.AddItem "Vale Vista": cmbDocumentoRecibimos.ItemData(cmbDocumentoRecibimos.NewIndex) = 1
    cmbDocumentoRecibimos.AddItem "Vale Camara": cmbDocumentoRecibimos.ItemData(cmbDocumentoRecibimos.NewIndex) = 2
    cmbDocumentoRecibimos.AddItem "Cheque Empresa": cmbDocumentoRecibimos.ItemData(cmbDocumentoRecibimos.NewIndex) = 3
    cmbDocumentoRecibimos.AddItem "Cheque Bancario": cmbDocumentoRecibimos.ItemData(cmbDocumentoRecibimos.NewIndex) = 4
    cmbDocumentoRecibimos.AddItem "Telex Hoy (Fondos Hoy)": cmbDocumentoRecibimos.ItemData(cmbDocumentoRecibimos.NewIndex) = 5
    cmbDocumentoRecibimos.AddItem "Telex 24 hrs": cmbDocumentoRecibimos.ItemData(cmbDocumentoRecibimos.NewIndex) = 6
    cmbDocumentoRecibimos.AddItem "Telex 48 hrs": cmbDocumentoRecibimos.ItemData(cmbDocumentoRecibimos.NewIndex) = 7
    
    cmbDocumentoPagamos.Clear
    cmbDocumentoPagamos.AddItem "No Aplicable": cmbDocumentoPagamos.ItemData(cmbDocumentoPagamos.NewIndex) = 0
    cmbDocumentoPagamos.AddItem "Vale Vista": cmbDocumentoPagamos.ItemData(cmbDocumentoPagamos.NewIndex) = 1
    cmbDocumentoPagamos.AddItem "Vale Camara": cmbDocumentoPagamos.ItemData(cmbDocumentoPagamos.NewIndex) = 2
    cmbDocumentoPagamos.AddItem "Cheque Empresa": cmbDocumentoPagamos.ItemData(cmbDocumentoPagamos.NewIndex) = 3
    cmbDocumentoPagamos.AddItem "Cheque Bancario": cmbDocumentoPagamos.ItemData(cmbDocumentoPagamos.NewIndex) = 4
    cmbDocumentoPagamos.AddItem "Telex Hoy (Fondos Hoy)": cmbDocumentoPagamos.ItemData(cmbDocumentoPagamos.NewIndex) = 5
    cmbDocumentoPagamos.AddItem "Telex 24 hrs": cmbDocumentoPagamos.ItemData(cmbDocumentoPagamos.NewIndex) = 6
    cmbDocumentoPagamos.AddItem "Telex 48 hrs": cmbDocumentoPagamos.ItemData(cmbDocumentoPagamos.NewIndex) = 7
    
    
    '----------- Flujos
    lstFlujos(0).Clear
    lstFlujos(0).AddItem "99/99/9999 999,999,999,999.9999 999.999999 999,999,999,999.9999 999,999,999,999.9999 Compensación   Vigente  "
    lstFlujos(0).AddItem "99/99/9999 999,999,999,999.9999 999.999999 999,999,999,999.9999 999,999,999,999.9999 Entrega Física Venciendo"
    lstFlujos(0).AddItem "99/99/9999 999,999,999,999.9999 999.999999 999,999,999,999.9999 999,999,999,999.9999 Entrega Física Vencida  "
    


    
End Sub

Private Sub optCompra_Click()

    tabFlujos.ForeColor = &HFF0000
    
End Sub


End Sub

Private Sub optVenta_Click()

      tabFlujos.ForeColor = &HFF&

End Sub
