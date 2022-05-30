VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Object = "{62D4B10A-EF7E-11D3-8E55-0008C7599BA7}#1.0#0"; "BAC_CONTROLESANT.OCX"
Begin VB.Form BacModSwapTasa 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Swaps de Tasas"
   ClientHeight    =   6420
   ClientLeft      =   1425
   ClientTop       =   2325
   ClientWidth     =   10890
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   -1  'True
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "BacSwapTMod.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6420
   ScaleWidth      =   10890
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton btnCalcular 
      Caption         =   "&Calcular Flujo"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   5310
      Picture         =   "BacSwapTMod.frx":0442
      Style           =   1  'Graphical
      TabIndex        =   63
      Top             =   5625
      Width           =   1365
   End
   Begin VB.Frame framBarra 
      Height          =   510
      Left            =   45
      TabIndex        =   58
      Top             =   5670
      Visible         =   0   'False
      Width           =   5190
      Begin ComctlLib.ProgressBar Barra 
         Height          =   240
         Left            =   90
         TabIndex        =   59
         Top             =   180
         Width           =   5010
         _ExtentX        =   8837
         _ExtentY        =   423
         _Version        =   327682
         Appearance      =   1
      End
   End
   Begin VB.CommandButton btnGrabar 
      Caption         =   "&Grabar"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   6705
      Picture         =   "BacSwapTMod.frx":0884
      Style           =   1  'Graphical
      TabIndex        =   55
      Top             =   5625
      Width           =   1365
   End
   Begin VB.CommandButton btnNuevo 
      Caption         =   "&Limpiar"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   8100
      Picture         =   "BacSwapTMod.frx":0CC6
      Style           =   1  'Graphical
      TabIndex        =   54
      Top             =   5625
      Width           =   1365
   End
   Begin VB.CommandButton btnSalir 
      Caption         =   "&Salir"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   9495
      Picture         =   "BacSwapTMod.frx":1108
      Style           =   1  'Graphical
      TabIndex        =   53
      Top             =   5625
      Width           =   1365
   End
   Begin VB.Frame Frame1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1635
      Left            =   5085
      TabIndex        =   48
      Top             =   -45
      Width           =   5745
      Begin VB.ComboBox cmbOperador 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1620
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   5
         ToolTipText     =   "Operador de Cliente (si no hay opciones, defina Cliente)"
         Top             =   1185
         Width           =   2625
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
         Left            =   1530
         MaxLength       =   50
         TabIndex        =   4
         Text            =   "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
         ToolTipText     =   "Nombre de Cliente (Doble Click invoca ayuda)"
         Top             =   540
         Width           =   4020
      End
      Begin VB.TextBox txtRut 
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
         Left            =   180
         MaxLength       =   13
         TabIndex        =   3
         Text            =   "999.999.999-K"
         ToolTipText     =   "Rut de Cliente (Doble Click invoca ayuda)"
         Top             =   540
         Width           =   1335
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Cliente"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   21
         Left            =   150
         TabIndex        =   50
         Top             =   225
         Width           =   555
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Operador"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   20
         Left            =   210
         TabIndex        =   49
         Top             =   1185
         Width           =   750
      End
   End
   Begin VB.Frame frmVendimos 
      Caption         =   "Pagamos..."
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
      Height          =   1650
      Left            =   5475
      TabIndex        =   33
      Top             =   1575
      Width           =   5355
      Begin BAC_Controles.UserControl_Numero txtTasaVenta 
         Height          =   330
         Left            =   1350
         TabIndex        =   12
         Top             =   765
         Width           =   1005
         _ExtentX        =   1773
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         Max             =   "999.999999"
         DecimalPlaces   =   4
      End
      Begin VB.ComboBox cmbTasaVenta 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   855
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   11
         ToolTipText     =   "Tasa de Negocio"
         Top             =   360
         Width           =   1785
      End
      Begin VB.ComboBox cmbBaseVenta 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1335
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   13
         ToolTipText     =   "Base en que se encuentra expresada Tasa (para calculo de intereses)"
         Top             =   1200
         Width           =   1305
      End
      Begin VB.ComboBox cmbMonedaPagamos 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2865
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   14
         ToolTipText     =   "Moneda con equivalente del documento"
         Top             =   800
         Width           =   2385
      End
      Begin VB.ComboBox cmbDocumentoPagamos 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2865
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   15
         ToolTipText     =   "Documento con el que Pagaremos"
         Top             =   1200
         Width           =   2385
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Tasa"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   14
         Left            =   120
         TabIndex        =   38
         Top             =   360
         Width           =   555
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Valor Tasa"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   13
         Left            =   120
         TabIndex        =   37
         Top             =   800
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
         Left            =   2415
         TabIndex        =   36
         Top             =   795
         Width           =   195
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Base Tasa"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   11
         Left            =   120
         TabIndex        =   35
         Top             =   1200
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
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   10
         Left            =   2910
         TabIndex        =   34
         Top             =   450
         Width           =   1275
      End
   End
   Begin VB.Frame frmCompramos 
      Caption         =   "Recibimos..."
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
      Height          =   1650
      Left            =   30
      TabIndex        =   27
      Top             =   1575
      Width           =   5355
      Begin BAC_Controles.UserControl_Numero txtTasaCompra 
         Height          =   330
         Left            =   1350
         TabIndex        =   7
         Top             =   765
         Width           =   1005
         _ExtentX        =   1773
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         Max             =   "999.999999"
         DecimalPlaces   =   4
      End
      Begin VB.ComboBox cmbDocumentoRecibimos 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2865
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   10
         ToolTipText     =   "Documento que Recibiremos"
         Top             =   1200
         Width           =   2385
      End
      Begin VB.ComboBox cmbMonedaRecibimos 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2865
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   9
         ToolTipText     =   "Moneda con equivalente del documento"
         Top             =   800
         Width           =   2385
      End
      Begin VB.ComboBox cmbBaseCompra 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1335
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   8
         ToolTipText     =   "Base en que se encuentra expresada Tasa (para calculo de intereses)"
         Top             =   1200
         Width           =   1305
      End
      Begin VB.ComboBox cmbTasaCompra 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   855
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   6
         ToolTipText     =   "Tasa de Negocio"
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
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   9
         Left            =   2865
         TabIndex        =   32
         Top             =   450
         Width           =   1275
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Base Tasa"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   8
         Left            =   120
         TabIndex        =   31
         Top             =   1200
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
         Left            =   2415
         TabIndex        =   30
         Top             =   795
         Width           =   195
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Valor Tasa"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   6
         Left            =   120
         TabIndex        =   29
         Top             =   800
         Width           =   1035
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Tasa"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   5
         Left            =   120
         TabIndex        =   28
         Top             =   360
         Width           =   555
      End
   End
   Begin TabDlg.SSTab tabFlujos 
      Height          =   2250
      Left            =   30
      TabIndex        =   39
      Top             =   3330
      Width           =   10845
      _ExtentX        =   19129
      _ExtentY        =   3969
      _Version        =   393216
      TabHeight       =   520
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Times New Roman"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "Definiciones"
      TabPicture(0)   =   "BacSwapTMod.frx":1412
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "lblSwapTasa(15)"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "lblSwapTasa(16)"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "lblSwapTasa(17)"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "lblSwapTasa(3)"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "lblSwapTasa(2)"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).Control(5)=   "lblSwapTasa(18)"
      Tab(0).Control(5).Enabled=   0   'False
      Tab(0).Control(6)=   "lblSwapTasa(19)"
      Tab(0).Control(6).Enabled=   0   'False
      Tab(0).Control(7)=   "lblSwapTasa(4)"
      Tab(0).Control(7).Enabled=   0   'False
      Tab(0).Control(8)=   "txtFecTermino"
      Tab(0).Control(8).Enabled=   0   'False
      Tab(0).Control(9)=   "txtFecPrimerVcto"
      Tab(0).Control(9).Enabled=   0   'False
      Tab(0).Control(10)=   "cmbAmortizaCapital"
      Tab(0).Control(10).Enabled=   0   'False
      Tab(0).Control(11)=   "cmbAmortizaInteres"
      Tab(0).Control(11).Enabled=   0   'False
      Tab(0).Control(12)=   "optEntFisica"
      Tab(0).Control(12).Enabled=   0   'False
      Tab(0).Control(13)=   "optCompensa"
      Tab(0).Control(13).Enabled=   0   'False
      Tab(0).Control(14)=   "cmbCarteraInversion"
      Tab(0).Control(14).Enabled=   0   'False
      Tab(0).Control(15)=   "txtFecInicio"
      Tab(0).Control(15).Enabled=   0   'False
      Tab(0).Control(16)=   "Frame2(1)"
      Tab(0).Control(16).Enabled=   0   'False
      Tab(0).ControlCount=   17
      TabCaption(1)   =   "Flujos Recibimos"
      TabPicture(1)   =   "BacSwapTMod.frx":142E
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "fgrdFlujosRecibe"
      Tab(1).Control(0).Enabled=   0   'False
      Tab(1).Control(1)=   "fgrdFlujos"
      Tab(1).Control(1).Enabled=   0   'False
      Tab(1).ControlCount=   2
      TabCaption(2)   =   "Flujos Pagamos"
      TabPicture(2)   =   "BacSwapTMod.frx":144A
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "fgrdFlujosPaga"
      Tab(2).Control(0).Enabled=   0   'False
      Tab(2).ControlCount=   1
      Begin VB.Frame Frame2 
         Height          =   1635
         Index           =   1
         Left            =   6570
         TabIndex        =   61
         Top             =   450
         Width           =   15
      End
      Begin BAC_Controles.UserControl_Fecha txtFecInicio 
         Height          =   285
         Left            =   5130
         TabIndex        =   18
         Top             =   585
         Width           =   1230
         _ExtentX        =   2170
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
         Text            =   "18-05-2000"
      End
      Begin VB.ComboBox cmbCarteraInversion 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   8715
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   24
         ToolTipText     =   "Cartera de Inversión"
         Top             =   1560
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
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   315
         Left            =   8685
         Style           =   1  'Graphical
         TabIndex        =   21
         ToolTipText     =   "Modalidad de Pago de Contrato y/o Flujos"
         Top             =   540
         Value           =   -1  'True
         Width           =   1905
      End
      Begin VB.OptionButton optEntFisica 
         Caption         =   "&Entrega Física"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   315
         Left            =   8700
         Style           =   1  'Graphical
         TabIndex        =   22
         ToolTipText     =   "Modalidad de Pago de Contrato y/o Flujos"
         Top             =   945
         Width           =   1905
      End
      Begin VB.ComboBox cmbAmortizaInteres 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1200
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   17
         ToolTipText     =   "Período de Amortización de Intereses"
         Top             =   1560
         Width           =   2000
      End
      Begin VB.ComboBox cmbAmortizaCapital 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1200
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   16
         ToolTipText     =   "Período de Amortización de Capital"
         Top             =   1080
         Width           =   2000
      End
      Begin MSFlexGridLib.MSFlexGrid fgrdFlujos 
         Height          =   1800
         Left            =   -74820
         TabIndex        =   46
         Top             =   2070
         Visible         =   0   'False
         Width           =   10335
         _ExtentX        =   18230
         _ExtentY        =   3175
         _Version        =   393216
         Rows            =   3
         Cols            =   9
         AllowBigSelection=   0   'False
         ScrollBars      =   2
         SelectionMode   =   1
         AllowUserResizing=   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin MSDBGrid.DBGrid fgrdFlujosPaga 
         Height          =   1755
         Left            =   -74955
         OleObjectBlob   =   "BacSwapTMod.frx":1466
         TabIndex        =   56
         Top             =   405
         Width           =   10410
      End
      Begin MSDBGrid.DBGrid fgrdFlujosRecibe 
         Height          =   1755
         Left            =   -74955
         OleObjectBlob   =   "BacSwapTMod.frx":1E2B
         TabIndex        =   57
         Top             =   405
         Width           =   10680
      End
      Begin BAC_Controles.UserControl_Fecha txtFecPrimerVcto 
         Height          =   285
         Left            =   5130
         TabIndex        =   19
         Top             =   1080
         Width           =   1230
         _ExtentX        =   2170
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
         Text            =   "18-05-2000"
      End
      Begin BAC_Controles.UserControl_Fecha txtFecTermino 
         Height          =   285
         Left            =   5130
         TabIndex        =   20
         Top             =   1575
         Width           =   1230
         _ExtentX        =   2170
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
         Text            =   "18-05-2000"
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
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   4
         Left            =   6735
         TabIndex        =   51
         Top             =   1560
         Width           =   1710
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
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   19
         Left            =   6780
         TabIndex        =   47
         Top             =   780
         Width           =   1650
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Primer Vencimiento"
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
         Index           =   18
         Left            =   3360
         TabIndex        =   45
         Top             =   1080
         Width           =   1665
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
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   2
         Left            =   3360
         TabIndex        =   44
         Top             =   600
         Width           =   1065
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
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
         Height          =   240
         Index           =   3
         Left            =   3360
         TabIndex        =   43
         Top             =   1560
         Width           =   1275
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
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   17
         Left            =   360
         TabIndex        =   42
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
         TabIndex        =   41
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
         TabIndex        =   40
         Top             =   600
         Width           =   1545
      End
   End
   Begin VB.Frame fraOperacion 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1635
      Left            =   30
      TabIndex        =   23
      Top             =   -45
      Width           =   5040
      Begin VB.TextBox TxtValorMoneda 
         BackColor       =   &H00E0E0E0&
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00008000&
         Height          =   315
         Left            =   3375
         TabIndex        =   62
         Text            =   "Text1"
         Top             =   750
         Width           =   1590
      End
      Begin VB.Frame Frame2 
         Height          =   60
         Index           =   0
         Left            =   135
         TabIndex        =   60
         Top             =   585
         Width           =   4785
      End
      Begin BAC_Controles.UserControl_Numero txtCapital 
         Height          =   330
         Left            =   855
         TabIndex        =   2
         Top             =   1215
         Width           =   2490
         _ExtentX        =   4392
         _ExtentY        =   582
         BackColor       =   14737632
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "-999999999999.9999"
         Max             =   "999999999999.9999"
         DecimalPlaces   =   4
         Separator       =   -1  'True
      End
      Begin VB.OptionButton optCompra 
         Caption         =   "&Recibimos"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   330
         Left            =   1740
         Style           =   1  'Graphical
         TabIndex        =   52
         ToolTipText     =   "Tipo de Operación ... Compra/Venta"
         Top             =   200
         Value           =   -1  'True
         Width           =   1575
      End
      Begin VB.OptionButton optVenta 
         Caption         =   "&Pagamos"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   330
         Left            =   3345
         Style           =   1  'Graphical
         TabIndex        =   0
         ToolTipText     =   "Tipo de Operación ... Compra/Venta"
         Top             =   200
         Width           =   1575
      End
      Begin VB.ComboBox cmbMoneda 
         BackColor       =   &H00E0E0E0&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   870
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   1
         ToolTipText     =   "Moneda Capital"
         Top             =   750
         Width           =   2500
      End
      Begin VB.Label etqNumOper 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00008000&
         Height          =   330
         Left            =   180
         TabIndex        =   64
         ToolTipText     =   "Número Operación"
         Top             =   180
         Width           =   1410
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Capital"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   1
         Left            =   150
         TabIndex        =   26
         Top             =   1230
         Width           =   555
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Index           =   0
         Left            =   150
         TabIndex        =   25
         Top             =   750
         Width           =   675
      End
   End
End
Attribute VB_Name = "BacModSwapTasa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private mTotalRows&, mTotalRowsRec& ' Contiene las filas totales del conjunto de registros
Private UserData() As Variant ' Matriz de 2 dimensiones que contiene registros
Private Const MAXCOLS = 10 ' Número máximo de campos del conjunto de registros.

Private UserDataRec() As Variant ' Matriz de 2 dimensiones que contiene registros
Private Const MAXCOLSRec = 10 ' Número máximo de campos del conjunto de re

Dim PasoTexto As String

'**Variables utilizadas en la funcion de Recalculo de Interes
Public RecFecha As Date
Public RecTasa As Double
Public RecMontoResto As Double
Public RecMontoAmort As Double
Public RecFecVencAnt As Date
'**


Function BuscaCliente(RutCli As Long)

Dim RutCliente As New clsCliente

    With RutCliente
        If .LeerRut(RutCli) Then
            txtRut.MaxLength = 13
            txtRut = Format(.clrut, "###,###,###") & "-" & .cldv
            txtCliente = .clnombre
            txtCliente.Tag = .clcodcli
        Else
            MsgBox "Rut  no ha sido encontrado en datos de Cliente", vbInformation, Msj
            txtRut.SetFocus
        End If
    End With
    
Set RutCliente = Nothing


End Function
Function BuscaValorTasa(objeto As Object, CodTasa As String)

Dim objTasas As New ClsTasas

With objTasas
    '***Traspaso de Valores a Variables
    If (cmbMoneda.ListIndex = -1) Then
        .CodMoneda = 0
    Else
        .CodMoneda = cmbMoneda.ItemData(cmbMoneda.ListIndex)
    End If
    .CodTasa = CodTasa
    .fecha = Date
Set .TxtObjeto = objeto
    '***
    
    .LeerTasa   'funcion que lee valor tasa

    Set objTasas = Nothing

End With

    

End Function
Function LimpiarDatos()
    
    'limpia textos
    txtCapital.Text = 0
    txtRut = ""
    txtCliente = ""
    txtCliente.Tag = 0
    txtFecInicio.Text = Format(Date, "dd/mm/yyyy")
    txtFecPrimerVcto.Text = Format(Date, "dd/mm/yyyy")
    txtFecTermino.Text = Format(Date, "dd/mm/yyyy")
    TxtValorMoneda.Text = 0
    txtTasaCompra.Text = 0
    txtTasaVenta.Text = 0
    
    'limpia combos
    cmbMoneda.ListIndex = -1
    cmbOperador.ListIndex = -1
    cmbTasaCompra.ListIndex = -1
    cmbBaseCompra.ListIndex = -1
    cmbMonedaRecibimos.ListIndex = -1
    cmbDocumentoRecibimos.ListIndex = -1
    cmbTasaVenta.ListIndex = -1
    cmbBaseVenta.ListIndex = -1
    cmbMonedaPagamos.ListIndex = -1
    cmbDocumentoPagamos.ListIndex = -1
    cmbAmortizaCapital.ListIndex = -1
    cmbAmortizaInteres.ListIndex = -1
    
    tabFlujos.Tab = 0
    'tabFlujos.TabEnabled(1) = False
    'tabFlujos.TabEnabled(2) = False
    
End Function



Private Sub btnCalcular_Click()

If ValidaDatos Then
        '****
        'Inicializacion de Barra
        Barra.Value = Barra.Min
        
        tabFlujos.Tag = "Recibimos"
        Call CalculoInteres(txtTasaCompra.Text, cmbBaseCompra, UserDataRec, MAXCOLSRec)
        '****
        tabFlujos.Tag = "Pagamos"
        Call CalculoInteres(txtTasaVenta.Text, cmbBaseVenta, UserData, MAXCOLS)
        '****
        'Despues del los procesos habilita paneles del tab
        Barra.Value = Barra.Max
        tabFlujos.TabEnabled(1) = True
        tabFlujos.TabEnabled(2) = True
        'Invisibilzar barra
        framBarra.Visible = False
        Barra.Value = Barra.Min
    
        btnGrabar.Enabled = True
        
    Else
        btnGrabar.Enabled = False
    End If

    

End Sub

Private Sub btnGrabar_Click()

    
    '*** Proceso de Almacenamiento de datos
    Call grabardatos
    '***
    Call LimpiarDatos
    btnGrabar.Enabled = False
    
End Sub

Private Sub btnNuevo_Click()
    
    Call LimpiarDatos
    
End Sub
Function ValidaDatos() As Boolean

    ValidaDatos = False
    
    'Datos minimos requeridos para realizar operacion de calculo
    
    'Compra
    If txtCapital.Text = "" Then
        MsgBox "Debe ingresar Monto Capital", vbInformation, Msj
        txtCapital.SetFocus
        Exit Function
    ElseIf Not IsNumeric(Val(txtCapital.Text)) Then
        MsgBox "Monto Capital Incorrecto!", vbInformation, Msj
        txtCapital.SetFocus
        Exit Function
    End If
    If txtCapital.Text <= 0 Then
        MsgBox "Monto Capital debe ser Mayor a CERO", vbInformation, Msj
        txtCapital.SetFocus
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
    
    If cmbAmortizaCapital.ListIndex = -1 Then
        MsgBox "Debe seleccionar Opción de Amortización de Capital", vbInformation, Msj
        cmbAmortizaCapital.SetFocus
        Exit Function
    End If
    
    'Venta
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
    
    If cmbAmortizaInteres.ListIndex = -1 Then
        MsgBox "Debe seleccionar Opción de Amortización de Interés", vbInformation, Msj
        cmbAmortizaInteres.SetFocus
        Exit Function
    End If
    
    'Común
    If txtFecInicio.Text = "" Then
        MsgBox "Debe ingresar Fecha Inicio de Contrato", vbInformation, Msj
        txtFecInicio.SetFocus
        Exit Function
    ElseIf Not IsDate(txtFecInicio.Text) Then
        MsgBox "Fecha Inicio de Contrato está Incorrecta!", vbInformation, Msj
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
    End If
        
    If txtCliente.Tag = "" Then
        MsgBox "Debe Ingresar Cliente", vbInformation, Msj
        txtCliente.SetFocus
        Exit Function
    End If
  
    ValidaDatos = True
    
End Function


Function grabardatos()

Dim objGrabaSwap As New ClsMovimSwaps
Dim SQL As String
Dim i As Integer
Dim Datos()
Dim fecInteres As String


With objGrabaSwap
'hacer begin transaction

    SQL = "BEGIN TRANSACTION"
    
    If SQL_Execute(SQL) Then
        Exit Function
    End If
    
    'Saca numero de ultima operacion
    SQL = " Exec sp_UltimaOperacion " _
          & "'" & Sistema & "', '" & Entidad & "' "
    
    If SQL_Execute(SQL) <> 0 Then
        MsgBox "Problemas para crear número de Operación!", vbCritical, Msj
        Exit Function
    Else
        If SQL_Fetch(Datos()) = 0 Then
            .swNumOperacion = Val(Datos(0))            'Numero de la Operacion
        Else
            .swNumOperacion = 21                               'Primera Operacion creada
        End If
    End If
    
    .swTipoSwap = 1                                                                                     'Tipo de Swap (Tasa - Monedas)
    .swCarteraInversion = .SacaCodigo(cmbCarteraInversion)                         'Codigo de Cartera de Inversion
    .swTipoOperacion = IIf(optCompra.Value = True, "C", "V")                       'Tipo de Operacion (Compra-Venta)
    .swCodCliente = IIf(txtRut.Tag = "", 0, txtRut.Tag)                                    'Codigo cliente
    .swCMoneda = .SacaCodigo(cmbMonedaRecibimos)                                 'Moneda de Compra
    .swCCapital = .FormatNum(txtCapital.Text)                                                      'Monto Capital
    .swFechaCierre = gsBAC_Fecp                                                              'Fecha Termino
    .swFechaInicio = txtFecInicio.Text                                                          'Fecha Primer Vencimiento
    .swFechaTermino = txtFecTermino.Text                                                           'Fecha Termino amortizacion
    .swCCodAmoCapital = Val(Trim(Right(cmbAmortizaCapital, 10)))              'Codigo tipo amortizacion de capital
    .swCMesAmoCapital = Int(.SacaCodigo(cmbAmortizaCapital) / 30)            'Valor de meses
    .swCCodAmoInteres = Val(Trim(Right(cmbAmortizaInteres, 10)))              'Codigo tipo amortizacion de interes
    .swCMesAmoInteres = Int(.SacaCodigo(cmbAmortizaInteres) / 30)            'Valor de meses
    .swCBase = cmbBaseCompra                                                                   'Monto base Compra
    .swVMoneda = .SacaCodigo(cmbMonedaPagamos)                                   'Codigo Moneda de Venta
    .swVCapital = .FormatNum(txtCapital.Text)                                              'Monto capital Venta
    .swVCodAmoCapital = Val(Trim(Right(cmbAmortizaCapital, 10)))             'Codigo tipo de amortizacion Tasa
    .swVMesAmoCapital = Int(.SacaCodigo(cmbAmortizaCapital) / 30)           'Valor de meses
    .swVCodAmoInteres = Val(Trim(Right(cmbAmortizaInteres, 10)))             'Codigo tipo amortizacion de interes
    .swVMesAmoInteres = Int(.SacaCodigo(cmbAmortizaInteres) / 30)           'Valor de meses
    .swVBase = cmbBaseVenta                                                                     'Monto Base Venta
    .swOperador = "Usuario"
    .swOperadorCliente = 11                                                                         'Codigo del Operador
    .swCMontoCLP = 0                                                                                'Monto compra en Pesos
    .swCMontoUSD = 0                                                                                'Monto Compra en moneda pactada
    .swVMontoCLP = 0                                                                                'Monto Venta en Pesos
    .swVMontoUSD = 0                                                                                'Monto Venta en moneda pactada
    
fecInteres = .swFechaInicio
For i = 1 To mTotalRows
    .swNumFlujo = i                                                                                     'Correlativo de la Operacion
    .swFechaInicioFlujo = fecInteres
    .swFechaVenceFlujo = Grilla.fecvence
    .swCAmortiza = .FormatNum(fgrdFlujosRecibe.Columns(2))                    'Monto amortizado en Compra
    .swCSaldo = .FormatNum(fgrdFlujosRecibe.Columns(8))                         'Monto no amortizado (Saldo) en compra
    .swCInteres = .FormatNum(fgrdFlujosRecibe.Columns(4))                       'Monto Interes de Compra
    .swCSpread = 0
    .swCCodigoTasa = .SacaCodigo(cmbTasaCompra)                                 'Codigo de tasa compra
    .swCValorTasa = .FormatNum(fgrdFlujosRecibe.Columns(3))                 'Valor Tasa
    .swCValorTasaHoy = txtTasaCompra.Tag                                             'Valor Tasa del dia
    .swVAmortiza = .FormatNum(fgrdFlujosPaga.Columns(2))                      'Monto Amortizado en Venta
    .swVSaldo = .FormatNum(fgrdFlujosPaga.Columns(8))                            'Monto no amortizado (Saldo) en Venta
    .swVInteres = .FormatNum(fgrdFlujosPaga.Columns(4))                          'Monto Interes de Compra
    .swVSpread = 0
    .swVCodigoTasa = .SacaCodigo(cmbTasaVenta)                                     'Codigo de tasa Venta
    .swVValorTasa = .FormatNum(fgrdFlujosPaga.Columns(3))                     'Valor Tasa Venta
    .swVValorTasaHoy = txtTasaVenta.Tag                                                 'Valor Tasa del dia
    
    .swEstadoFlujo = 1
    If optCompensa.Value = True Then
        .swModalidadPago = "C"
    Else
        .swModalidadPago = "E"
    End If
    
    .swPagMoneda = .SacaCodigo(cmbMonedaPagamos)                               'Codigo Moneda Pagamos
    .swPagDocumento = .SacaCodigo(cmbDocumentoPagamos)                     'Codigo documento Pagamos
    .swPagMonto = 1 '.FormatNum(1)
    .swPagMontoUSD = 1 ' .FormatNum(1)
    .swPagMontoCLP = 1 '.FormatNum(1)
    .swRecMoneda = .SacaCodigo(cmbMonedaRecibimos)                             'Codigo Moneda Recibimos
    .swRecDocumento = .SacaCodigo(cmbDocumentoRecibimos)                   'Codigo Documento Recibimos
    .swRecMonto = 1 '.FormatNum(1)
    .swRecMontoUSD = 1 '  .FormatNum(1)
    .swRecMontoCLP = 1 ' .FormatNum(1)
    .swObservaciones = "obs"
    .swFechaModifica = Date
    
    fecInteres = Grilla.fecven
    If Not .grabar Then
        SQL = "ROLLBACK TRANSACTION"
        If SQL_Execute(SQL) <> 0 Then
            MsgBox "Problemas al deshacer la operacion", vbCritical, Msj
            
            Exit Function
        End If
        MsgBox "No terminó proceso de ingreso de datos", vbCritical, Msj
        Exit Function
    End If
    
Next

End With
            
SQL = "COMMIT TRANSACTION"
If SQL_Execute(SQL) <> 0 Then
    MsgBox "Problemas al grabar datos", vbCritical, Msj
End If

Set objGrabaSwap = Nothing

End Function
Function LLenafgrdFlujos()

Dim i As Integer
Dim Grilla As Object

    
    If tabFlujos.Tag = "Pagamos" Then
        Set Grilla = fgrdFlujosPaga
    ElseIf tabFlujos.Tag = "Recibimos" Then
        Set Grilla = fgrdFlujosRecibe
    End If
    
    With Grilla
    ' Quita las columnas antiguas
    For i = .Columns.Count - 1 To 0 Step -1
        .Columns.Remove i
    Next i
    
    ' Agrega nuevas columnas
    For i = 0 To 9
        .Columns.Add i
        If i < 7 Then
            .Columns(i).Visible = True
        Else
            .Columns(i).Visible = False
        End If
    Next i
    
    .Columns(0).Caption = "Nro."
    .Columns(1).Caption = "Vencimiento"
    .Columns(2).Caption = "Amortización " & Trim(cmbAmortizaCapital)
    .Columns(3).Caption = "Tasa"
    .Columns(4).Caption = "Interés " & Trim(cmbAmortizaInteres)
    .Columns(5).Caption = "Total"
    .Columns(6).Caption = "Modalidad"
    .Columns(1).Button = True
    .Columns(7).Caption = "Documento Pago"
    .Columns(8).Caption = "Saldo amortizar"
    .Columns(9).Caption = "Fecha Vcto. Anterior"
    
    
    
    .Columns(0).DefaultValue = Format(Date, gsc_FechaDMA)
    
    .Columns(0).Width = TextWidth(" 99 ")  '800
    .Columns(1).Width = TextWidth(" 99/99/9999 ")
    .Columns(2).Width = TextWidth(" 999,999,999,999.9999 ")
    .Columns(3).Width = TextWidth(" 999.999999 ")
    .Columns(4).Width = TextWidth(" 999,999,999,999.9999 ")
    .Columns(5).Width = TextWidth(" 999,999,999,999.9999 ")
    .Columns(6).Width = TextWidth(" ENTREGA FISICA ")
    
    .Columns(2).Alignment = 1
    .Columns(3).Alignment = 1
    .Columns(4).Alignment = 1
    .Columns(5).Alignment = 1
    
    .Refresh
    
    Set Grilla = Nothing
    
    End With

    tabFlujos.TabIndex = 2

End Function

Private Sub btnSalir_Click()

    Unload Me

End Sub

Private Sub cmbAmortizaCapital_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbAmortizaInteres.SetFocus

End Sub

Private Sub cmbAmortizaCapital_LostFocus()

    If btnGrabar.Enabled = True Then
        btnCalcular_Click
    End If

End Sub

Private Sub cmbAmortizaInteres_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then txtFecInicio.SetFocus

End Sub

Private Sub cmbAmortizaInteres_LostFocus()

    If btnGrabar.Enabled = True Then
        btnCalcular_Click
    End If

End Sub

Private Sub cmbBaseCompra_Click()
    'Posiciona base ventas deacuerdo a base compras
    If cmbBaseCompra.ListIndex <> -1 Then
        Call bacBuscarCombo(cmbBaseVenta, cmbBaseCompra.ItemData(cmbBaseCompra.ListIndex))
    End If

End Sub

Private Sub cmbBaseCompra_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbMonedaRecibimos.SetFocus

End Sub

Private Sub cmbBaseVenta_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbMonedaPagamos.SetFocus

End Sub

Private Sub cmbDocumentoPagamos_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbAmortizaCapital.SetFocus

End Sub

Private Sub cmbDocumentoRecibimos_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbTasaVenta.SetFocus

End Sub

Private Sub cmbMoneda_Click()

    If cmbMoneda.ListIndex <> -1 Then
        txtTasaVenta.Text = ValorMoneda(cmbMoneda.ItemData(cmbMoneda.ListIndex), Date)
    End If

End Sub

Private Sub cmbMoneda_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then txtCapital.SetFocus

End Sub

Private Sub cmbMonedaPagamos_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbDocumentoPagamos.SetFocus

End Sub

Private Sub cmbMonedaRecibimos_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbDocumentoRecibimos.SetFocus
    
End Sub

Private Sub cmbOperador_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbTasaCompra.SetFocus

End Sub

Private Sub cmbTasaCompra_Click()

    If cmbTasaCompra.ListIndex > -1 Then
        Call BuscaValorTasa(txtTasaCompra, cmbTasaCompra.ItemData(cmbTasaCompra.ListIndex))
    End If

End Sub

Private Sub cmbTasaCompra_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then txtTasaCompra.SetFocus

End Sub

Private Sub cmbTasaVenta_Click()

    If cmbTasaVenta.ListIndex > -1 Then
        Call BuscaValorTasa(txtTasaVenta, cmbTasaVenta.ItemData(cmbTasaVenta.ListIndex))
    End If
    
End Sub

Private Sub cmbTasaVenta_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then txtTasaVenta.SetFocus

End Sub

Private Sub fgrdFlujosPaga_BeforeColEdit(ByVal ColIndex As Integer, ByVal KeyAscii As Integer, Cancel As Integer)
  
    '***Para cancelar que modifiquen columna
   
    If ColIndex = 0 Then
        Cancel = True
    End If
    '***
    
End Sub

Private Sub fgrdFlujosPaga_BeforeUpdate(Cancel As Integer)


    If Not ValidaModificaciones(fgrdFlujosPaga) Then
        tabFlujos.Tag = "Pagamos"
        With fgrdFlujosPaga
        RecFecha = .Columns(1)                                                            'Fecha Amortizacion
        RecTasa = .Columns(3)                                                              'Valor Tasa
        RecMontoResto = .Columns(8)                                                   'Monto Restante del Capital no amortizado
        RecMontoAmort = IIf(.Columns(2) = ".", 0, .Columns(2))             'Monto amortizado
        RecFecVencAnt = .Columns(9)                                                  'Fecha de Vencimiento Anterior
        
        Call RecalcularInteres(cmbBaseVenta, .Bookmark, UserData())
        End With
        
    Else    'Cancelacion de modificaciones del Usuario
        Cancel = 0
    End If

End Sub

Private Sub fgrdFlujosPaga_ButtonClick(ByVal ColIndex As Integer)

    If ColIndex = 2 Then
        
    End If

End Sub

Private Sub fgrdFlujosPaga_UnboundAddData(ByVal RowBuf As MSDBGrid.RowBuffer, NewRowBookmark As Variant)
Dim iCol As Integer

mTotalRows = mTotalRows + 1
ReDim Preserve UserData(MAXCOLS - 1, mTotalRows - 1)
NewRowBookmark = mTotalRows - 1 'Establece el marcador a la última fila.

' El bucle siguiente agrega un nuevo registro a la base de datos.
For iCol = 0 To UBound(UserData, 1)
    If Not IsNull(RowBuf.Value(0, iCol)) Then
        UserData(iCol, mTotalRows - 1) = RowBuf.Value(0, iCol)
    Else
        ' Si no se establece ningún valor para la columna, usa DefaultValue
        UserData(iCol, mTotalRows - 1) = fgrdFlujosPaga.Columns(iCol).DefaultValue
    End If
Next iCol

End Sub
Function ValidaModificaciones(ByRef Grilla As DBGrid) As Boolean

    'Valida cambios de grilla
    ValidaModificaciones = True
    With Grilla
    If .Columns(1).Value = "" Then
        MsgBox "Debe escribir Fecha Primer Vencimiento", vbInformation, Msj
        Exit Function
    End If
    If Not IsDate(.Columns(1).Value) Then
        MsgBox "Fecha de Vencimiento está incorrecta", vbInformation, Msj
        Exit Function
    End If
    If .Columns(2).Value = "" Then
        MsgBox "Debe ingresar monto Amortización", vbInformation, Msj
        Exit Function
    End If
    If Not IsNumeric(.Columns(2).Value) Then
        MsgBox "Monto Amortización incorrecto!", vbInformation, Msj
        Exit Function
    Else
        .Columns(2).Value = Format(.Columns(2).Value, "###,###,###,###,###.####")
    End If
    
    
    End With
    
    
    ValidaModificaciones = False

End Function
Private Sub fgrdFlujosPaga_UnboundDeleteRow(Bookmark As Variant)
Dim iCol As Integer, iRow As Integer

' Mueve todas las filas encima de la fila eliminada de
' la matriz.

For iRow = Bookmark + 1 To mTotalRows - 1
    For iCol = 0 To MAXCOLS - 1
        UserData(iCol, iRow - 1) = UserData(iCol, iRow)
    Next iCol
Next iRow
mTotalRows = mTotalRows - 1

End Sub

Private Sub fgrdFlujosPaga_UnboundReadData(ByVal RowBuf As MSDBGrid.RowBuffer, StartLocation As Variant, ByVal ReadPriorRows As Boolean)

Dim CurRow&, iRow As Integer, iCol As Integer, iRowsFetched As Integer, iIncr As Integer
' DBGrid está solicitando filas, así que se las damos

If ReadPriorRows Then
    iIncr = -1
Else
    iIncr = 1
End If

' Si StartLocation es Null, empieza a leer por el final
' o por el principio del conjunto de datos.
If IsNull(StartLocation) Then
    If ReadPriorRows Then
        CurRow& = RowBuf.RowCount - 1
    Else
        CurRow& = 0
    End If
Else
    ' Busca la posición para empezar a leer, basándose en el marcador
    ' StartLocation y en la variable iIncr
    CurRow& = CLng(StartLocation) + iIncr
End If

' Transfiere datos de nuestra matriz de conjunto de datos al objeto RowBuf
' que DBGrid utiliza para presentar los datos
For iRow = 0 To RowBuf.RowCount - 1
    If CurRow& < 0 Or CurRow& >= mTotalRows& Then Exit For
    For iCol = 0 To UBound(UserData, 1)
        RowBuf.Value(iRow, iCol) = UserData(iCol, CurRow&)
    Next iCol
    ' Establece el marcador mediante CurRow&, que es también
    ' nuestro índice de matriz
    RowBuf.Bookmark(iRow) = CStr(CurRow&)
    CurRow& = CurRow& + iIncr
    iRowsFetched = iRowsFetched + 1
Next iRow
RowBuf.RowCount = iRowsFetched

End Sub


Private Sub fgrdFlujosPaga_UnboundWriteData(ByVal RowBuf As MSDBGrid.RowBuffer, WriteLocation As Variant)
Dim iCol As Integer
' Se están actualizando los datos

' Actualiza cada columna de la matriz de conjuntos de datos
For iCol = 0 To MAXCOLS - 1
    If Not IsNull(RowBuf.Value(0, iCol)) Then
        UserData(iCol, WriteLocation) = RowBuf.Value(0, iCol)
    End If
Next iCol

End Sub

Private Sub fgrdFlujosRecibe_BeforeColEdit(ByVal ColIndex As Integer, ByVal KeyAscii As Integer, Cancel As Integer)
 '***Para cancelar que modifiquen columna
    If ColIndex = 0 Then
        Cancel = True
    End If
    '***
End Sub

Private Sub fgrdFlujosRecibe_BeforeUpdate(Cancel As Integer)

If Not ValidaModificaciones(fgrdFlujosRecibe) Then
    tabFlujos.Tag = "Recibimos"
    
    With fgrdFlujosRecibe
    RecFecha = .Columns(1)                                                            'Fecha Amortizacion
    RecTasa = .Columns(3)                                                              'Valor Tasa
    RecMontoResto = .Columns(8)                                                   'Monto Restante del Capital no amortizado
    RecMontoAmort = IIf(.Columns(2) = ".", 0, .Columns(2))             'Monto amortizado
    RecFecVencAnt = .Columns(9)                                                  'Fecha de Vencimiento Anterior
    
    Call RecalcularInteres(cmbBaseCompra, .Bookmark, UserDataRec())
    
    End With
Else    'Cancelacion de modificaciones del Usuario
    Cancel = 0
End If

End Sub

Private Sub fgrdFlujosRecibe_UnboundAddData(ByVal RowBuf As MSDBGrid.RowBuffer, NewRowBookmark As Variant)
Dim iCol As Integer

mTotalRowsRec = mTotalRowsRec + 1
ReDim Preserve UserDataRec(MAXCOLSRec - 1, mTotalRowsRec - 1)
NewRowBookmark = mTotalRowsRec - 1 'Establece el marcador a la última fila.

' El bucle siguiente agrega un nuevo registro a la base de datos.
For iCol = 0 To UBound(UserDataRec, 1)
    If Not IsNull(RowBuf.Value(0, iCol)) Then
        UserDataRec(iCol, mTotalRowsRec - 1) = RowBuf.Value(0, iCol)
    Else
        ' Si no se establece ningún valor para la columna, usa DefaultValue
        UserDataRec(iCol, mTotalRowsRec - 1) = fgrdFlujosRecibe.Columns(iCol).DefaultValue
    End If
Next iCol


End Sub

Private Sub fgrdFlujosRecibe_UnboundDeleteRow(Bookmark As Variant)
Dim iCol As Integer, iRow As Integer

' Mueve todas las filas encima de la fila eliminada de
' la matriz.

For iRow = Bookmark + 1 To mTotalRowsRec - 1
    For iCol = 0 To MAXCOLSRec - 1
        UserDataRec(iCol, iRow - 1) = UserDataRec(iCol, iRow)
    Next iCol
Next iRow
mTotalRowsRec = mTotalRowsRec - 1

End Sub

Private Sub fgrdFlujosRecibe_UnboundReadData(ByVal RowBuf As MSDBGrid.RowBuffer, StartLocation As Variant, ByVal ReadPriorRows As Boolean)
Dim CurRow&, iRow As Integer, iCol As Integer, iRowsFetched As Integer, iIncr As Integer
' DBGrid está solicitando filas, así que se las damos

If ReadPriorRows Then
    iIncr = -1
Else
    iIncr = 1
End If

' Si StartLocation es Null, empieza a leer por el final
' o por el principio del conjunto de datos.
If IsNull(StartLocation) Then
    If ReadPriorRows Then
        CurRow& = RowBuf.RowCount - 1
    Else
        CurRow& = 0
    End If
Else
    ' Busca la posición para empezar a leer, basándose en el marcador
    ' StartLocation y en la variable iIncr
    CurRow& = CLng(StartLocation) + iIncr
End If

' Transfiere datos de nuestra matriz de conjunto de datos al objeto RowBuf
' que DBGrid utiliza para presentar los datos
For iRow = 0 To RowBuf.RowCount - 1
    If CurRow& < 0 Or CurRow& >= mTotalRowsRec& Then Exit For
    For iCol = 0 To UBound(UserDataRec, 1)
        RowBuf.Value(iRow, iCol) = UserDataRec(iCol, CurRow&)
    Next iCol
    ' Establece el marcador mediante CurRow&, que es también
    ' nuestro índice de matriz
    RowBuf.Bookmark(iRow) = CStr(CurRow&)
    CurRow& = CurRow& + iIncr
    iRowsFetched = iRowsFetched + 1
Next iRow
RowBuf.RowCount = iRowsFetched

End Sub

Private Sub fgrdFlujosRecibe_UnboundWriteData(ByVal RowBuf As MSDBGrid.RowBuffer, WriteLocation As Variant)
Dim iCol As Integer
' Se están actualizando los datos

' Actualiza cada columna de la matriz de conjuntos de datos
For iCol = 0 To MAXCOLSRec - 1
    If Not IsNull(RowBuf.Value(0, iCol)) Then
        UserDataRec(iCol, WriteLocation) = RowBuf.Value(0, iCol)
    End If
Next iCol

End Sub

Private Sub Form_Load()

    '------------- Monedas
    Call LlenaComboCodGeneral(cmbMoneda, 42, Sistema, 2)
    
    '------------- Tasas
    Call LlenaComboCodGeneral(cmbTasaCompra, 42, Sistema, 1)
    Call LlenaComboCodGeneral(cmbTasaVenta, 42, Sistema, 1)
    
    '------------- Bases
    Call LlenaComboCodGeneral(cmbBaseCompra, 11, Sistema, 1)
    Call LlenaComboCodGeneral(cmbBaseVenta, 11, Sistema, 1)
    
    '------------ Monedas de Pago
    Call LlenaComboCodGeneral(cmbMonedaRecibimos, 9, Sistema, 1)
    Call LlenaComboCodGeneral(cmbMonedaPagamos, 9, Sistema, 1)
    
    '------------ Documentos de Pago
    Call LlenaComboCodGeneral(cmbDocumentoRecibimos, 1, Sistema, 1)
    Call LlenaComboCodGeneral(cmbDocumentoPagamos, 1, Sistema, 1)
    
    '------------ Tipos de Amortizacion
    Call LlenaComboAmortiza(cmbAmortizaInteres, 44, Sistema)
    Call LlenaComboAmortiza(cmbAmortizaCapital, 43, Sistema)
    
    '------------ Tipos de Amortizacion
    Call LlenaComboCodGeneral(cmbCarteraInversion, 4, Sistema, 1)
        
    Call LimpiarDatos
    
    
    Call BuscarDatos
    
    'No permite agregar lineas a las grillas
    fgrdFlujosRecibe.AllowAddNew = False
    fgrdFlujosPaga.AllowAddNew = False
    
    
End Sub
Function BuscarDatos()
    Dim Mantencion As New clsMantencionSwap
    Dim Rutpaso As String
    Dim Total As Double
    Dim i, Hasta As Integer
    Dim FecVencAnt As Date
    
    With Mantencion
        
    .NumOperacion = swModNumOpe
    .TipoOperacion = swModTipoOpe
    If Not .LeerDatos Then
        Set Mantencion = Nothing
        MsgBox "Operación no ha sido encontrada", vbCritical, Msj
        Exit Function
    End If
                
    'Ubica datos en la pantalla
    
    i = 1
    Hasta = .coleccion.Count
    etqNumOper = swModNumOpe
    txtCapital.Text = .coleccion(i).swCCapital
    
    Call bacBuscarCombo(cmbMoneda, .coleccion(i).swCMoneda)
    Call bacBuscarCombo(cmbCarteraInversion, .coleccion(i).swCarteraInversion)
    
    Call BuscaCmbAmortiza(cmbAmortizaCapital, .coleccion(i).swCCodAmoCapital)
    Call BuscaCmbAmortiza(cmbAmortizaInteres, .coleccion(i).swCCodAmoInteres)
    
    Call BuscaCmbAmortiza(cmbBaseCompra, .coleccion(i).swCBase)
    Call BuscaCmbAmortiza(cmbBaseVenta, .coleccion(i).swVBase)
    
    Call bacBuscarCombo(cmbTasaCompra, .coleccion(i).swCCodigoTasa)
    
    Call bacBuscarCombo(cmbTasaVenta, .coleccion(i).swVCodigoTasa)
    
    Call bacBuscarCombo(cmbOperador, .coleccion(i).swOperadorCliente)
    
    Call bacBuscarCombo(cmbMonedaPagamos, .coleccion(i).swPagMoneda)
    
    Call bacBuscarCombo(cmbDocumentoPagamos, .coleccion(i).swPagDocumento)
    
    Call bacBuscarCombo(cmbMonedaRecibimos, .coleccion(i).swRecMoneda)
    
    Call bacBuscarCombo(cmbDocumentoRecibimos, .coleccion(i).swRecDocumento)
    
    
    txtCliente.Tag = .coleccion(i).swCodCliente
    txtCliente.Text = .coleccion(i).swNomCliente
    If (.coleccion(i).swRutCliente) <> "" Then
        txtRut.Text = BacFormatoRut(.coleccion(i).swRutCliente)  'Rutpaso
    End If
    txtFecTermino.Text = .coleccion(i).swFechaCierre
    txtFecInicio.Text = .coleccion(i).swFechaInicio
    txtFecPrimerVcto.Text = .coleccion(i).swFechaInicioFlujo
    
    txtTasaCompra.Text = .coleccion(i).swCValorTasa
    txtTasaVenta.Text = .coleccion(i).swCValorTasa

    If .coleccion(i).swTipoOperacion = 1 Then
        optCompra.Value = True
    Else
        optVenta.Value = True
    End If
    If .coleccion(1).swModalidadPago = "C" Then
        optCompensa.Value = True
    Else
        optEntFisica.Value = True
    End If
    
    
    For i = 1 To Hasta
        ReDim Preserve UserDataRec(MAXCOLSRec - 1, i + 1)
        
        UserDataRec(0, i - 1) = .coleccion(i).swNumFlujo
        UserDataRec(1, i - 1) = .coleccion(i).swFechaVenceFlujo
        UserDataRec(2, i - 1) = Format(.coleccion(i).swCAmortiza, "###,###,###,##0.###0")
        UserDataRec(8, i - 1) = .coleccion(i).swCSaldo
        UserDataRec(4, i - 1) = Format(.coleccion(i).swCInteres, "###,###,###,##0.###0")
        UserDataRec(3, i - 1) = Format(.coleccion(i).swCValorTasa, "###0.###0")
        Total = Val(.coleccion(i).swCInteres) + Val(.coleccion(i).swCAmortiza)
        UserDataRec(5, i - 1) = Format(Total, "###,###,###,##0.###0")
        Total = 0
        UserDataRec(6, i - 1) = .coleccion(i).swModalidadPago
        UserDataRec(9, i - 1) = .coleccion(i).swFechaInicioFlujo
        
        mTotalRows& = i
        
        ReDim Preserve UserData(MAXCOLS - 1, i + 1)
        UserData(0, i - 1) = .coleccion(i).swNumFlujo
        UserData(1, i - 1) = .coleccion(i).swFechaInicioFlujo
        UserData(2, i - 1) = Format(.coleccion(i).swVAmortiza, "###,###,###,##0.###0")
        UserData(8, i - 1) = .coleccion(i).swVSaldo
        UserData(4, i - 1) = Format(.coleccion(i).swVInteres, "###,###,###,##0.###0")
        UserData(3, i - 1) = Format(.coleccion(i).swVValorTasa, "###0.###0")
        Total = Val(.coleccion(i).swVInteres) + Val(.coleccion(i).swVAmortiza)
        UserData(5, i - 1) = Format(Total, "###,###,###,##0.###0")
        Total = 0
        UserData(6, i - 1) = .coleccion(i).swModalidadPago
        UserData(9, i - 1) = .coleccion(i).swFechaVenceFlujo
        
        mTotalRowsRec& = i
        
    Next i
        
    End With
    
     tabFlujos.Tag = "Pagamos"
    Call LLenafgrdFlujos
    tabFlujos.Tag = "Recibimos"
    Call LLenafgrdFlujos
    
    Set Mantencion = Nothing
    
End Function




Function CalculoInteres(TasaStr As String, BaseStr As String, ByRef Arreglo As Variant, MaxColumnas As Double) As Double
    Dim Spread, Base, Tasa As Double
    Dim FechaAmortiza, FechaAmortizaCap, FechaAmortizaInt As Date
    Dim FechaIniAmortCap, FechaIniAmortInt, FechaIniAmort As Date
    Dim FechaFin, FechaVencAnt As Date
    Dim DiasAmortCap, DiasAmortInt As Integer
    Dim Cont As Integer
    Dim DiasDif, DifDias As Integer
    Dim TopeCalc, cuenta As Integer
    Dim MontoAmortiza, MontoCapital, MontoGrd As Double
    Dim Interes, Plazo, MontoCalcAmort As Double
    Dim RestoCapital As Double
    Dim MontoAmortCap, MontoAmortInt As Double
    Dim dias%
    Dim CuentaAmCap As Integer
    Dim TotalVenc As Double
    '*************************************
    '* Primer Calculo Amortizacion de Interes  *
    '*************************************
    
    Barra.Value = Barra.Value + 1                               'Incremento Barra (avanza)
  
    MontoCapital = (txtCapital.Text)                             'Monto Capital
    
    DiasAmortCap = cmbAmortizaCapital.ItemData(cmbAmortizaCapital.ListIndex)    'Total de dias real para Amortizacion Capital
    dias = cmbAmortizaCapital.ItemData(cmbAmortizaCapital.ListIndex)
    FechaAmortizaCap = CDate(txtFecPrimerVcto.Text)
    
    DiasAmortInt = cmbAmortizaInteres.ItemData(cmbAmortizaInteres.ListIndex)       'Total de dias real para Amortizacion del Interes
    
    Base = BaseStr                                                                                                     'Base asignada para calculo
    Tasa = TasaStr
    
    If DiasAmortCap = 0 Then
        'Para los casos que el período es BULLET ó BONO
        dias = DiasAmortInt
    Else
        dias = IIf((DiasAmortCap <= DiasAmortInt), DiasAmortCap, DiasAmortInt)
    End If
    
    If tabFlujos.Tag = "Recibimos" Then                                                        'Cuando es el 1er. proceso da valor máx. a la barra (aprox.)
        Barra.Max = (((CDate(txtFecTermino.Text) - CDate(txtFecPrimerVcto.Text)) / dias) + 3) * 2
        framBarra.Visible = True
    End If
    
    '***Inicializaciones de Fecha
    FechaIniAmort = txtFecPrimerVcto.Text
    FechaIniAmortCap = CDate(txtFecPrimerVcto.Text)
    FechaIniAmortInt = CDate(txtFecPrimerVcto.Text)
    FechaAmortiza = FechaIniAmort
    FechaFin = CDate(txtFecTermino.Text)
    FechaVencAnt = CDate(txtFecInicio.Text)
    '***
    
    DiasDif = CDate(txtFecPrimerVcto.Text) - CDate(txtFecInicio.Text)   'Diferencia de Dias entre fechas de inicio y primer vcto.
    
    '***Veces en que se Dividira Capital para amortizar
    DifDias = Int((CDate(FechaFin) - CDate(txtFecPrimerVcto.Text)) / DiasAmortCap) 'Diferencia de dias entre fecha Primer y Ultimo Vcto.
    DifDias = IIf(DifDias% = 0, 1, DifDias)                                        'Factor para dividir monto capital
    '***
    MontoAmortiza = MontoCapital
    
    '***Monto a amortizar en los vctos.
    MontoAmortCap = CDbl(MontoCapital) / (DifDias + 1)
    MontoAmortCap = Format(MontoAmortCap, "###,###,###,###.#0")
    MontoAmortInt = 0
   '***
    cuenta = 1
    CuentaAmCap = 0
    While FechaAmortiza <= FechaFin
        Barra.Value = Barra.Value + 1                                                'Incremento de barra
        '***
        ReDim Preserve Arreglo(MaxColumnas - 1, cuenta + 1)           'Agregar fila al arreglo
            
        'Verificar si corresponde amortizacion de capital
        If FechaAmortizaCap = FechaAmortiza Then
            MontoGrd = MontoAmortCap
            
            '***Próxima Fecha Vcto. Amort. Capital
            CuentaAmCap = CuentaAmCap + 1
            FechaAmortizaCap = CreaFechaProx(FechaIniAmortCap, (DiasAmortCap * CuentaAmCap))
            '***
            RestoCapital = MontoAmortCap
        Else
            MontoGrd = 0
            RestoCapital = 0
        End If
        
        '*** Calculo
        MontoCalcAmort = (Tasa / 100) '+ (Spread / 100)
        Plazo = DiasDif / Base
        Interes = MontoAmortiza * (MontoCalcAmort) * (Plazo)
        '***
                
        TotalVenc = MontoGrd + Interes
        
        '***Traspaso de Datos a Arreglo
        Arreglo(0, cuenta - 1) = cuenta
        Arreglo(1, cuenta - 1) = Format(FechaAmortiza, gsc_FechaDMA)
        Arreglo(2, cuenta - 1) = MontoGrd
        Arreglo(3, cuenta - 1) = Tasa
        Arreglo(4, cuenta - 1) = Format(Interes, "###,###,###,###.###0")
        Arreglo(5, cuenta - 1) = TotalVenc
        Arreglo(8, cuenta - 1) = MontoAmortiza
        Arreglo(9, cuenta - 1) = FechaVencAnt
        '***
        
        '***Actualizacion de datos para Prox. amortizacion
        FechaVencAnt = FechaAmortiza
        FechaAmortizaInt = CreaFechaProx((FechaIniAmortInt), (DiasAmortInt * cuenta))
        FechaAmortiza = CreaFechaProx((FechaIniAmort), (dias * cuenta))
        DiasDif = CDate(FechaAmortiza) - CDate(FechaVencAnt)
        MontoAmortiza = MontoAmortiza - RestoCapital
        '***
        
        If tabFlujos.Tag = "Recibimos" Then                         'Incremento del total de filas del arreglo
            mTotalRowsRec& = cuenta
        ElseIf tabFlujos.Tag = "Pagamos" Then
            mTotalRows& = cuenta
        End If
        
        cuenta = cuenta + 1
        
    Wend
    
    Call LLenafgrdFlujos

End Function
Function SugerirFechaPrimVecto()
Dim DiasCap, DiasInt, DiasASumar As Integer
Dim FechaResultado As Date

'Sugiere fecha Pimer y Ultimo vencimiento


    'If txtFecPrimerVcto.Text = "" Then
        If cmbAmortizaCapital.ListIndex = -1 Or cmbAmortizaInteres.ListIndex = -1 Then Exit Function
        DiasCap = cmbAmortizaCapital.ItemData(cmbAmortizaCapital.ListIndex)
        DiasInt = cmbAmortizaInteres.ItemData(cmbAmortizaInteres.ListIndex)
          
        'Primer Vencimiento
        DiasASumar = IIf((DiasCap <= DiasInt), DiasCap, DiasInt)
        FechaResultado = CreaFechaProx(txtFecInicio.Text, DiasASumar)
        txtFecPrimerVcto.Text = FechaResultado
        
        'Primer Ultimo Vencimiento
        DiasASumar = IIf((DiasCap >= DiasInt), DiasCap, DiasInt)
        FechaResultado = CreaFechaProx(txtFecPrimerVcto.Text, DiasASumar)
        txtFecTermino.Text = FechaResultado
        
        
    'End If

End Function

Function RecalcularInteres(Base, filGrd As Integer, ByRef Arreglo As Variant)
    '***Variables publicas que se llenan antes de entrar a esta funcion
    'Public RecFecVencAnt As Date
    '***
    Dim Tasa As Double
    Dim FechaAmortiza, FechaVencAnt As Date
    Dim DifDias, cuenta, DiasDif  As Integer
    Dim MontoAmortiza, MontoCapital As Double
    Dim Interes, Plazo, MontoCalcAmort, MontoAmortCap As Double
    Dim ObjetoGrid As Object
    Dim TotalVenc As Double
    
  
  If tabFlujos.Tag = "Recibimos" Then
    Set ObjetoGrid = fgrdFlujosRecibe
  Else
    Set ObjetoGrid = fgrdFlujosPaga
  End If
  
  With ObjetoGrid
    '.Row = filGrd
    MontoCapital = CDbl(txtCapital.Text)   'Monto Capital
    Tasa = RecTasa                                   'Tasa
    MontoAmortiza = RecMontoResto        'Monto Amortizado en el Calculo de interes
    MontoAmortCap = RecMontoAmort     'Monto que vence ("amortizado")
    
    FechaAmortiza = RecFecha                  'Fecha de Vencimiento o Amortizacion
    FechaVencAnt = RecFecVencAnt        'Fecha Vcto. anterior
    If filGrd = 0 Then                                  'Primera fila
        DiasDif = CDate(FechaAmortiza) - CDate(txtFecInicio.Text)    'Dias distancia
    Else
        '.Row = filGrd - 1                               'Posicionarse fila anterior
        '.Columns(1)            'Fecha anterior
        '.Row = filGrd                                    'Fila real
        DiasDif = CDate(FechaAmortiza) - CDate(FechaVencAnt)     'Dias distancia
    End If

    '*** Calculo
    MontoCalcAmort = (Tasa / 100) '+ (Spread / 100)
    Plazo = DiasDif / Base
    Interes = MontoAmortiza * (MontoCalcAmort) * (Plazo)
    '***
    
    TotalVenc = MontoAmortCap + Interes
        
    cuenta = filGrd                                      'Posicion del registro en el arreglo
    '***Traspaso de datos a Arreglo
    Arreglo(0, cuenta) = cuenta + 1
    Arreglo(1, cuenta) = FechaAmortiza
    Arreglo(2, cuenta) = MontoAmortCap
    Arreglo(4, cuenta) = Format(Interes, "###,###,###,###.###0") ' Interes
    Arreglo(3, cuenta) = Tasa
    '***
    .Refresh                                               'Refresca, actualiza grilla
    End With

End Function

Private Sub optCompensa_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbCarteraInversion.SetFocus

End Sub

Private Sub optEntFisica_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbCarteraInversion.SetFocus

End Sub

Private Sub txtCapital_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then txtRut.SetFocus

End Sub

Private Sub txtCapital_LostFocus()


    If btnGrabar.Enabled = True Then
        btnCalcular_Click
    End If

End Sub

Private Sub txtCliente_DblClick()
'Solicita Ayuda
Dim carac As String
Dim AyudaCli As New clsCliente

    
    With AyudaCli
    If .leepornombre(carac) Then
        BacAyudaSwap.Tag = "Cliente"
        
        BacAyudaSwap.Show 1
    Else
        MsgBox "No Existen Datos para ayuda solicitada", vbExclamation, Msj
        Exit Sub
    End If
    End With
    
    txtRut = Format(gsCodigo, "###,###,###") & "-" & gsDigito
    txtCliente = gsnombre
    txtCliente.Tag = gscodcli
    
    AyudaCli.limpiar
    
    Set AyudaCli = Nothing

End Sub

Private Sub txtFecInicio_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then txtFecPrimerVcto.SetFocus

End Sub

Private Sub txtFecInicio_LostFocus()

    If txtFecInicio.Text <> "" Then
        If IsDate(txtFecInicio.Text) Then
            txtFecInicio.Text = Format(txtFecInicio.Text, gsc_FechaDMA)
            txtFecInicio.Text = VALIDAFECHA(txtFecInicio.Text)
            
            Call SugerirFechaPrimVecto
            
            If txtFecPrimerVcto.Text <> "" And txtFecTermino.Text = "" Then txtFecTermino.Text = txtFecPrimerVcto.Text
        Else
            MsgBox "Fecha de Inicio no es válida", vbInformation, Msj
            txtFecInicio.SetFocus
        End If
    End If

    If btnGrabar.Enabled = True Then
        btnCalcular_Click
    End If

End Sub

Private Sub txtFecPrimerVcto_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then txtFecTermino.SetFocus

End Sub

Private Sub txtFecPrimerVcto_LostFocus()

    If txtFecPrimerVcto.Text <> "" Then
        If IsDate(txtFecPrimerVcto.Text) Then
            If CDate(txtFecPrimerVcto.Text) < CDate(txtFecInicio.Text) Then
                MsgBox "Fecha de Primer Vencimiento no puede ser menor a Fecha de Inicio", vbInformation, Msj
                txtFecPrimerVcto.SetFocus
                Exit Sub
            End If
            
            txtFecPrimerVcto.Text = Format(txtFecPrimerVcto.Text, gsc_FechaDMA)
                         
        Else
            MsgBox "Fecha de Primer Vencimiento no es válida", vbInformation, Msj
            txtFecPrimerVcto.SetFocus
        End If
    End If

End Sub

Private Sub txtFecTermino_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        If optCompensa.Value = True Then
            optCompensa.SetFocus
        Else
            optEntFisica.SetFocus
        End If
    End If
    
End Sub

Private Sub txtFecTermino_LostFocus()

    If txtFecTermino.Text <> "" Then
        If IsDate(txtFecTermino.Text) Then
            If CDate(txtFecTermino.Text) < CDate(txtFecPrimerVcto.Text) Then
                MsgBox "Fecha Termino de Vencimientos no puede ser menor a Fecha de Primer Vencimiento", vbInformation, Msj
                txtFecTermino.SetFocus
                Exit Sub
            End If
            
            txtFecTermino.Text = Format(txtFecTermino.Text, gsc_FechaDMA)
                         
        Else
            MsgBox "Fecha Termino de Vencimientos no es válida", vbInformation, Msj
            txtFecTermino.SetFocus
        End If
    End If

End Sub



Private Sub txtRut_Change()

 '   txtRut.MaxLength = 9

End Sub

Private Sub txtRut_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then txtCliente.SetFocus

End Sub

Private Sub txtRut_LostFocus()

    
    If txtRut <> "" Then
        If IsNumeric(txtRut) Then
            Call BuscaCliente(txtRut)
        End If
    
    End If
    
End Sub

Private Sub txtTasaCompra_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbBaseCompra.SetFocus

End Sub

Private Sub txtTasaCompra_LostFocus()

    If txtTasaCompra.Text <> "" Then
        If Not IsNumeric(txtTasaCompra.Text) Then
            'txtTasaCompra = Format(txtTasaCompra.Text, "###.######")
        'Else
            MsgBox "Monto de Tasa de Compra está incorrecto", vbInformation, Msj
            txtTasaCompra.SetFocus
        End If
    End If

End Sub

Private Sub txtTasaVenta_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbBaseVenta.SetFocus

End Sub

Private Sub txtTasaVenta_LostFocus()

    If txtTasaVenta.Text <> "" Then
        If Not IsNumeric(txtTasaVenta.Text) Then
            'txtTasaVenta = Format(txtTasaVenta, "###.######")
        'Else
            MsgBox "Monto en Tasa de Venta está incorrecto", vbInformation, Msj
            txtTasaVenta.SetFocus
        End If
    End If


End Sub

Private Sub txtCliente_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbOperador.SetFocus

End Sub

