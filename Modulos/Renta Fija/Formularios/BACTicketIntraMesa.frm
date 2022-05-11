VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Frm_TicketIntramesa 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ticket Intramesa ( Productos Renta Fija ) "
   ClientHeight    =   9825
   ClientLeft      =   405
   ClientTop       =   885
   ClientWidth     =   12165
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   9825
   ScaleWidth      =   12165
   Begin VB.Frame Frm_Final 
      Height          =   975
      Left            =   135
      TabIndex        =   10
      Top             =   2175
      Width           =   9255
      Begin VB.ComboBox CmbMesaOrigen 
         Height          =   315
         Left            =   165
         Style           =   2  'Dropdown List
         TabIndex        =   45
         Top             =   510
         Width           =   2775
      End
      Begin VB.ComboBox CmbMesaDestino 
         Height          =   315
         Left            =   3210
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   510
         Width           =   3060
      End
      Begin VB.Label Label25 
         Caption         =   "Portafolio"
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   150
         TabIndex        =   46
         Top             =   270
         Width           =   975
      End
      Begin VB.Label Label26 
         Caption         =   "Contraparte"
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   3225
         TabIndex        =   11
         Top             =   270
         Width           =   3015
      End
   End
   Begin VB.TextBox Text2VP 
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   0  'None
      ForeColor       =   &H00800000&
      Height          =   240
      Left            =   2760
      TabIndex        =   40
      Top             =   7080
      Visible         =   0   'False
      Width           =   720
   End
   Begin BACControles.TXTNumero TEXT1vp 
      Height          =   300
      Left            =   3600
      TabIndex        =   41
      Top             =   7080
      Visible         =   0   'False
      Width           =   630
      _ExtentX        =   1111
      _ExtentY        =   529
      BackColor       =   16777215
      ForeColor       =   255
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
      Min             =   "-99"
      Max             =   "99999999999.9999"
      Separator       =   -1  'True
      MarcaTexto      =   -1  'True
   End
   Begin VB.Data Data2 
      Caption         =   "Data para las ventas"
      Connect         =   "Access"
      DatabaseName    =   "C:\BTRADER\Mdb\BACTRD.mdb"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   345
      Left            =   9480
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   "TICKET_VENTA"
      Top             =   7440
      Visible         =   0   'False
      Width           =   2415
   End
   Begin VB.ComboBox Combo1 
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00800000&
      Height          =   315
      ItemData        =   "BACTicketIntraMesa.frx":0000
      Left            =   0
      List            =   "BACTicketIntraMesa.frx":000D
      Sorted          =   -1  'True
      Style           =   2  'Dropdown List
      TabIndex        =   39
      Top             =   9840
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.TextBox Text1 
      BackColor       =   &H00800000&
      BorderStyle     =   0  'None
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   255
      TabIndex        =   36
      TabStop         =   0   'False
      Top             =   5820
      Visible         =   0   'False
      Width           =   980
   End
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   "C:\BTRADER\Mdb\BACTRD.mdb"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   345
      Left            =   5535
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   "TICKET_Compra"
      Top             =   9285
      Visible         =   0   'False
      Width           =   3885
   End
   Begin VB.Frame frm_Principal 
      Height          =   735
      Left            =   120
      TabIndex        =   12
      Top             =   600
      Width           =   9255
      Begin VB.ComboBox cmbTipoPago 
         Height          =   315
         ItemData        =   "BACTicketIntraMesa.frx":0027
         Left            =   4050
         List            =   "BACTicketIntraMesa.frx":0031
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   330
         Width           =   2370
      End
      Begin VB.ComboBox Cmb_TipoOperacion 
         Height          =   315
         Left            =   135
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   345
         Width           =   3735
      End
      Begin BACControles.TXTFecha FechaPago 
         Height          =   315
         Left            =   7050
         TabIndex        =   3
         Top             =   330
         Width           =   1755
         _ExtentX        =   3096
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   2
         Text            =   "01/01/1900"
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Modo de Pago"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   2
         Left            =   4095
         TabIndex        =   15
         Top             =   120
         Width           =   1245
      End
      Begin VB.Label Etiquetas 
         Caption         =   "Fecha de Pago"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   14
         Left            =   7050
         TabIndex        =   14
         Top             =   120
         Width           =   1485
      End
      Begin VB.Label Label1 
         Caption         =   "Producto"
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   120
         TabIndex        =   13
         Top             =   120
         Width           =   2775
      End
   End
   Begin VB.Frame Frm_Secundario 
      Height          =   855
      Left            =   120
      TabIndex        =   0
      Top             =   1320
      Width           =   9255
      Begin VB.ComboBox CmbCarteraDestino 
         Height          =   315
         ItemData        =   "BACTicketIntraMesa.frx":0042
         Left            =   3195
         List            =   "BACTicketIntraMesa.frx":0044
         Style           =   2  'Dropdown List
         TabIndex        =   43
         Top             =   405
         Width           =   3105
      End
      Begin VB.ComboBox CmbCarteraOrigen 
         Height          =   315
         ItemData        =   "BACTicketIntraMesa.frx":0046
         Left            =   135
         List            =   "BACTicketIntraMesa.frx":0048
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   405
         Width           =   2835
      End
      Begin BACControles.TXTNumero TxtTotal 
         Height          =   315
         Left            =   6480
         TabIndex        =   5
         Top             =   405
         Width           =   2685
         _ExtentX        =   4736
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,00"
         Text            =   "0,00"
         Max             =   "99999999999999.99999999999"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
      End
      Begin VB.Label Label24 
         Caption         =   "Cartera Destino"
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   3210
         TabIndex        =   44
         Top             =   150
         Width           =   3015
      End
      Begin VB.Label lblTot 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Total Operación"
         ForeColor       =   &H00800000&
         Height          =   240
         Left            =   6480
         TabIndex        =   9
         Top             =   135
         Width           =   2175
      End
      Begin VB.Label Label23 
         Caption         =   "Cartera Origen"
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   120
         TabIndex        =   8
         Top             =   165
         Width           =   1815
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   495
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   12165
      _ExtentX        =   21458
      _ExtentY        =   873
      ButtonWidth     =   847
      ButtonHeight    =   820
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdLimpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   16
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdGrabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Procesa"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "CmdFiltrar"
            Description     =   "Filtar"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   18
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   0
      Top             =   -120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   19
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":004A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":049C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":0AC6
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":0C20
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":0F3A
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":1254
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":156E
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":1888
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":1CDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":212C
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":2446
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":2898
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":2CEA
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":2E44
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":3296
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":35B0
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":38CA
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":3D1C
            Key             =   ""
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BACTicketIntraMesa.frx":4036
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSFrame Frm_Pactos 
      Height          =   1725
      Left            =   120
      TabIndex        =   16
      Top             =   3240
      Width           =   9240
      _Version        =   65536
      _ExtentX        =   16298
      _ExtentY        =   3043
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
      Font3D          =   3
      Begin VB.ComboBox CmbMoneda 
         Appearance      =   0  'Flat
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
         ItemData        =   "BACTicketIntraMesa.frx":4F10
         Left            =   465
         List            =   "BACTicketIntraMesa.frx":4F12
         Style           =   2  'Dropdown List
         TabIndex        =   22
         Top             =   540
         Width           =   1380
      End
      Begin BACControles.TXTNumero IntBase 
         Height          =   255
         Left            =   7560
         TabIndex        =   17
         Top             =   1800
         Visible         =   0   'False
         Width           =   1215
         _ExtentX        =   2143
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
         Text            =   "0"
         Text            =   "0"
         Max             =   "99999999999.9999999"
      End
      Begin BACControles.TXTFecha Dtefecven 
         Height          =   315
         Left            =   4410
         TabIndex        =   18
         Top             =   1185
         Width           =   1575
         _ExtentX        =   2778
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
         Text            =   "13/11/2000"
      End
      Begin BACControles.TXTNumero Intdias 
         Height          =   315
         Left            =   3210
         TabIndex        =   19
         Top             =   1185
         Width           =   615
         _ExtentX        =   1085
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
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero FltTasa 
         Height          =   315
         Left            =   5025
         TabIndex        =   20
         Top             =   540
         Width           =   1455
         _ExtentX        =   2566
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
         Text            =   "0,00000"
         Text            =   "0,00000"
         Min             =   "-99"
         CantidadDecimales=   "5"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
         SelStart        =   2
      End
      Begin BACControles.TXTNumero FltMtoini 
         Height          =   315
         Left            =   2040
         TabIndex        =   21
         Top             =   540
         Width           =   2415
         _ExtentX        =   4260
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
         Min             =   "0"
         Max             =   "99999999999999.999"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin Threed.SSPanel Lbl_Mt_Inicial 
         Height          =   315
         Left            =   165
         TabIndex        =   23
         Top             =   1185
         Width           =   2820
         _Version        =   65536
         _ExtentX        =   4974
         _ExtentY        =   556
         _StockProps     =   15
         Caption         =   "0"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         Alignment       =   4
      End
      Begin Threed.SSPanel Lbl_Mt_Final 
         Height          =   315
         Left            =   6300
         TabIndex        =   24
         Top             =   1185
         Width           =   2670
         _Version        =   65536
         _ExtentX        =   4710
         _ExtentY        =   556
         _StockProps     =   15
         Caption         =   "0"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         Alignment       =   4
      End
      Begin Threed.SSPanel Lbl_ValMon 
         Height          =   315
         Left            =   7080
         TabIndex        =   25
         Top             =   540
         Width           =   1890
         _Version        =   65536
         _ExtentX        =   3334
         _ExtentY        =   556
         _StockProps     =   15
         Caption         =   "0"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         Alignment       =   4
      End
      Begin Threed.SSPanel Pnl_MX 
         Height          =   315
         Left            =   105
         TabIndex        =   26
         Top             =   525
         Visible         =   0   'False
         Width           =   285
         _Version        =   65536
         _ExtentX        =   503
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   0
         BackColor       =   12582912
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
      End
      Begin VB.Label Lbl_Titulo_Fin 
         AutoSize        =   -1  'True
         Caption         =   "Monto Final $$"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   6945
         TabIndex        =   35
         Top             =   990
         Width           =   1050
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Tasa Interes"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   4995
         TabIndex        =   34
         Top             =   345
         Width           =   885
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Monto Inicial $$"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   2040
         TabIndex        =   33
         Top             =   345
         Width           =   1125
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   465
         TabIndex        =   32
         Top             =   345
         Width           =   585
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         Caption         =   "Vencimiento"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   4425
         TabIndex        =   31
         Top             =   990
         Width           =   870
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         Caption         =   "Dias"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   3345
         TabIndex        =   30
         Top             =   990
         Width           =   315
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Valor Moneda"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   7515
         TabIndex        =   29
         Top             =   345
         Width           =   990
      End
      Begin VB.Label Lbl_Titulo_Ini 
         AutoSize        =   -1  'True
         Caption         =   "Monto Inicial $$"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   840
         TabIndex        =   28
         Top             =   990
         Width           =   1125
      End
      Begin VB.Label Label5 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   330
         Left            =   3870
         TabIndex        =   27
         Top             =   1185
         Width           =   450
      End
   End
   Begin BACControles.TXTNumero TEXT2 
      Height          =   315
      Left            =   240
      TabIndex        =   37
      TabStop         =   0   'False
      Top             =   6285
      Visible         =   0   'False
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   556
      BackColor       =   8388608
      ForeColor       =   16777215
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
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
      Min             =   "-99"
      Max             =   "999999999999,9999"
      Separator       =   -1  'True
   End
   Begin MSFlexGridLib.MSFlexGrid Table1 
      Height          =   3975
      Left            =   90
      TabIndex        =   38
      Top             =   5115
      Width           =   9270
      _ExtentX        =   16351
      _ExtentY        =   7011
      _Version        =   393216
      Cols            =   14
      FixedCols       =   0
      RowHeightMin    =   315
      BackColor       =   -2147483633
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorSel    =   8388608
      ForeColorSel    =   -2147483643
      BackColorBkg    =   12632256
      GridColorFixed  =   -2147483635
      ScrollTrack     =   -1  'True
      Enabled         =   0   'False
      FocusRect       =   2
      HighLight       =   2
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
   Begin MSFlexGridLib.MSFlexGrid table2 
      Height          =   3975
      Left            =   120
      TabIndex        =   42
      Top             =   5040
      Width           =   9255
      _ExtentX        =   16325
      _ExtentY        =   7011
      _Version        =   393216
      Cols            =   24
      FixedCols       =   2
      FocusRect       =   0
   End
End
Attribute VB_Name = "Frm_TicketIntramesa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim bCargaCombos    As Boolean
Dim Formato_Monto   As String
Dim Datos()


Public bFlagDpx         As Boolean      'Permite solo el ingreso de los dpx
Public bajoOk           As Boolean
Public oTipoPago        As Integer
Public gSQLMesas        As String

Dim SwEmision           As Boolean
Dim FormHandle          As Long
Dim bufNominal          As Double

Dim REGISTRO            As Integer
Dim Tecla               As String
Dim Monto               As Double
Dim Antes               As Double
Dim bCancelar           As Boolean
Dim nContador           As Integer
Dim iFlagKeyDown
Dim Envia()


       
Const cSuma = 0
Const cInstrumento = 1
Const cCantidad = 2
Const cTir = 3
Const cPrecio = 4
Const cMonto = 5
Const cCustodia = 6
Const cClave = 7
Const cCartera = 8


'Const tckCol_Marca = 0
Const tckCol_SERIE = 0
Const tckCol_UM = 1
Const tckCol_NOMINAL = 2
Const tckCol_TIR = 3
Const tckCol_VPAR = 4
Const tckCol_VPS = 5
Const tckCol_CUST = 6




'----> Variables para las ventas
Public FiltraVentaAutomatico  As Boolean

Public Fila                   As Integer
Public FiltroAutomatico       As Boolean

Dim SWPintando             As Boolean
Dim Columna                As Integer
Dim bufRutCart             As Long
Dim objDCartera            As New clsDCartera
Dim sFiltro                As String
Dim nRutCartV              As String
Dim cDvCartV               As String
Dim cNomCartV              As String
Dim valor                  As String
Dim z                      As Integer
Dim Color                  As String
Dim colorletra             As String
Dim columnita              As Integer
Dim filita                 As Integer
Dim bold                   As String

'Variables Constantes de Columnas de la grilla Table2
Const nColEstado = 0
Const nColSerie = 1
Const nColMoneda = 2
Const nColNominal = 3
Const nColTir = 4
Const nColVPar = 5
Const nColValorPresente = 6
Const nColCustodia = 7
Const nColClaveDCV = 8
Const nColTirCompra = 9
Const nColVParCompra = 10
Const nColValorCompra = 11
Const nColUtilidad = 12

Const nColTTran = 13
Const nColVTran = 14
Const nColVPTran = 15
Const nColDifTran = 16
Const nColDif_CLP = 17

Const nColCarteraSuper = 18 '13
Const nColDurationMac = 19 '14
Const nColDurationMod = 20 '15
Const nColConvex = 21 '16

Const nColLibro = 22 '17
Const nColValuta = 23 '18

'constantes de posicion de datos en arreglo de consulta para
'procedimiento SP_FILTRARCART_VP

Const Pos_RutCartera = 0
Const Pos_CartFin = 1
Const Pos_CadenaFamilia = 2
Const Pos_CadenaEmisor = 3
Const Pos_CadenaMoneda = 4
Const Pos_CadenaSerie = 5
Const Pos_CartSuper = 6
Const Pos_Usuario = 7
Const Pos_Libro = 8
            
Public cCodCartFin        As String
Public cCodLibro          As String

Public bSelPagoMañana     As Boolean









Function TOOLFILTRAR()
Dim Envia1          As Variant
Dim Sql             As String
Dim Datos()
Dim nSw%
Dim x               As Integer
Dim oContador       As Long

On Error GoTo ErrFiltro


    oContador = 1
    nSw = 0
    
    If Not (Me.cmbTipoPago.ListIndex <> -1) Then
        Call MsgBox("Debe seleccionar el tipo de pago antes de filtrar", vbExclamation, "Venta Definitivas")
        Exit Function
    End If
    
    If Not (Me.CmbCarteraOrigen.ListIndex <> -1) Then
        Call MsgBox("Debe seleccionar el tipo de pago antes de filtrar", vbExclamation, "Venta Definitivas")
        Exit Function
    End If

    If Me.CmbCarteraOrigen.Enabled = True Then
        Me.CmbCarteraOrigen.Enabled = False
    End If
    
    Frm_TicketIntramesa.bFlagDpx = bFlagDpx
    Call Frm_SelCP_Ticket.Show(vbModal)
   
    Envia1 = ENVIA2
    valor = True

    If giAceptar% = True Then
    
        Call TICKETVENTA_EliminarBloqueados(Data2, FormHandle)
        Call TICKETVENTA_BorrarTx(FormHandle)
        Envia = Envia1
       
        Screen.MousePointer = vbKeyReturn
        Sql = "DBO.SP_LIS_FILTRO_VP_TICKET"
        
        If Bac_Sql_Execute(Sql, Envia) Then
            Let sFiltro = gSQL
            Let bSelPagoMañana = False
            
            If Data2.Recordset.RecordCount > 0 Then
                db.Execute "DELETE * FROM TICKET_VENTA"
                Data2.Refresh
            End If
                
            Do While Bac_SQL_Fetch(Datos())
                If Datos(12) <> "" Then
                    Call TICKETVENTA_Agregar(Data2, Datos(), Hwnd, "VP")
                    Call Data2.Recordset.MoveLast
                    Let nSw = 1
                End If
                Let oContador = oContador + 1
            Loop
            
            Call table2.Clear
            Let table2.Rows = 2
            
            Call VP_Nombre_Grilla
            Call VP_llenar_Grilla
            
            If nSw > 0 Then
               ' Let Toolbar1.Buttons(6).Tag = "Ver Sel."
                Let Data2.RecordSource = "SELECT * FROM TICKET_VENTA WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= 1"
                Call Data2.Refresh

                Let TxtTotal.Text = TICKETVENTA_SumarTotal(FormHandle)
              ' Flt_Result.Caption = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")
               ' Let TxtCartera.Text = TICKETVENTA_SumarCartera(FormHandle, "1", Toolbar1)
                Let table2.Enabled = True
            Else
               ' Let Toolbar1.Buttons(6).Tag = "Ver Sel."
                Let table2.Col = nColSerie
'                Let Toolbar1.Buttons(6).Enabled = False
                Let table2.Enabled = False
              ' TxtInv.Enabled = True
            End If

            If table2.Row = 0 Then
               Toolbar1.Buttons(3).Enabled = False
               Toolbar1.Buttons(4).Enabled = False
            End If
            
            If Data2.Recordset.RecordCount > 0 Then
                Toolbar1.Buttons(2).Enabled = True
                Toolbar1.Buttons(3).Enabled = True
            End If
        Else
            Let table2.Rows = 1
        End If

        
        Let Screen.MousePointer = vbDefault

    End If
    Exit Function
    
ErrFiltro:

    Let Table1.Redraw = True
    Call MsgBox("Problemas en filtro de cartera para ventas definitivas: " & err.Description)
    Let Screen.MousePointer = vbDefault
    Exit Function
    
End Function



Private Sub callSTART()
    
    Call subLIMPIAR
    FormHandle = Me.Hwnd
    
    
End Sub

Private Sub CmbCarteraDestino_Click()

    If Me.CmbCarteraDestino.ListIndex <> -1 Then
        If Me.CmbMesaDestino.Enabled = True Then
            Call Me.CmbMesaDestino.SetFocus
        End If
    End If

End Sub

Private Sub CmbCarteraOrigen_KeyPress(KeyAscii As Integer)

    If KeyAscii = vbKeyReturn Then
        Call CmbCarteraOrigen_Click
    End If

End Sub

Private Sub Table1_DblClick()
  If Table1.ColSel = tckCol_SERIE And Table1.TextMatrix(Table1.Row, tckCol_SERIE) = "" Then
            Text1.Visible = True
            Text1.SetFocus
  End If
End Sub

Private Sub table2_GotFocus()
    Let Text2VP.Font.bold = True
End Sub

Private Sub TEXT1vp_KeyDown(KeyCode As Integer, Shift As Integer)
Dim I           As Integer
Dim Fila        As Integer
Dim Anterior    As Double
Dim v           As String
Dim Colum       As Integer
Dim nTopRow     As Integer
Dim Columna     As Integer
Dim reg         As Double


    If KeyCode = vbKeyEscape Then
        Let TEXT1vp.Visible = False
        Let TEXT1vp.Text = 0
        Call table2.SetFocus
    End If

    Let nTopRow = table2.TopRow

    Let Fila = table2.Row
    Let Antes_Flag = True
    Let tipo = "VP"
    Let Anterior = table2.TextMatrix(table2.Row, table2.Col)

    If KeyCode = vbKeyReturn Then
    
        Let Colum = table2.Col
        
        If Not table2.Row = 1 Then
            Call Colocardata2
        Else
            Call Data2.Recordset.MoveFirst
        End If
  
        'ENTEREDIT
        Let iFlagKeyDown = False
   
        If table2.Col = nColNominal Then
            Let bufNominal = Val(Data2.Recordset("tm_nominalo"))
        End If
        'UPDATE
        On Error GoTo ExitEditError

        Let MousePointer = vbHourglass
           
        Let Columna = table2.Col
    
        If Data2.Recordset.RecordCount = 0 Then
            Let MousePointer = vbDefault
            Exit Sub
        End If

        Call Data2.Recordset.Edit
        
        Call BacControlWindows(60)
        Let table2.TextMatrix(table2.Row, table2.Col) = TEXT1vp.Text
    
        If Columna = nColNominal Then
            Let Data2.Recordset!tm_nominal = TEXT1vp.Text
            Call Data2.Recordset.Update
        
            If TICKETVENTA_VerDispon(FormHandle, Data2) Then
                If CDbl(table2.TextMatrix(table2.Row, nColNominal)) <> Data2.Recordset("tm_nominalo") Then
                    If CDbl(table2.TextMatrix(table2.Row, nColNominal)) > bufNominal Then
                    
                        Call MsgBox("Valor nominal ingresado es mayor al monto nominal disponible " & vbCrLf & vbCrLf & " Debido a esto se restaurara  el valor nominal original", vbExclamation, "Mensaje")
                        Call Data2.Recordset.Edit
                        Let Data2.Recordset("tm_nominal") = Data2.Recordset("tm_nominalo")
                        Call Data2.Recordset.Update
                        Call BacControlWindows(30)
                            
                        If Data2.Recordset("tm_venta") = "V" Or Data2.Recordset("tm_venta") = "P" Then
                            If TICKETVENTA_DesBloquear(FormHandle, Data2) Then
                                Call Data2.Recordset.Edit
                                Let Data2.Recordset("tm_venta") = " "
                                Let Data2.Recordset("tm_clave_dcv") = " "
                                Call Data2.Recordset.Update
                            End If
                        End If
                            
                        Call TICKETVENTA_Restaurar(Data2)
                        'Call CO_EliminarCortesMDB(FormHandle, Data2.Recordset("tm_correlao"))
                    Else
                        'If VPVI_LeerCortes(Data2, FormHandle) Then
                            If Trim(Data2.Recordset("tm_venta")) = "" And Data2.Recordset("tm_nominal") <> Data2.Recordset("tm_nominalo") Then
                                If TICKETVENTA_Bloquear(FormHandle, Data2) Then
                                    Call Data2.Recordset.Edit
                                    Let Data2.Recordset("tm_venta") = "P"
                                    Let Data2.Recordset("tm_clave_dcv") = " "
                                      
                                    Call Data2.Recordset.Update
                                Else
                                    Data2.Recordset.Edit
                                    Data2.Recordset("tm_venta") = "*"
                                    Data2.Recordset.Update
                                End If
                            Else
                                If Data2.Recordset("tm_venta") = "V" Then
                                    Data2.Recordset.Edit
                                    Data2.Recordset("tm_venta") = "P"
                                    Data2.Recordset("tm_clave_dcv") = " "
                                    Data2.Recordset.Update
                                End If
                            End If
                            
'                            Else
'                                If Data2.Recordset("tm_venta") = "V" Or Data2.Recordset("tm_venta") = "P" Then
'                                    If TICKETVENTA_DesBloquear(FormHandle, Data2) Then
'                                        Data2.Recordset.Edit
'                                        Data2.Recordset("tm_venta") = " "
'                                        Data2.Recordset("tm_custodia") = " "
'                                        Data2.Recordset.Update
'                                    End If
'                                End If
'                                Call TICKETVENTA_Restaurar(Data2)
'                                If Trim(Data2.Recordset("tm_venta")) <> "" Then
'                                    Call TICKETVENTA_DesBloquear(FormHandle, Data2)
'                                    'Call CO_EliminarCortesMDB(FormHandle, Data2.Recordset("tm_correlativo"))
'                                End If
'                            End If
                       End If
                    Else
                        If Data2.Recordset("tm_venta") = "P" Then
                            Data2.Recordset.Edit
                            Data2.Recordset("tm_venta") = "V"
                            Data2.Recordset("tm_clave_dcv") = ""
                            Data2.Recordset.Update
                                
                        ElseIf Data2.Recordset("tm_venta") = " " Then
                                If TICKETVENTA_Bloquear(FormHandle, Data2) Then
                                    Data2.Recordset.Edit
                                    Data2.Recordset("tm_venta") = "V"
                                   Data2.Recordset("tm_clave_dcv") = ""
                            
                                    Data2.Recordset.Update
                                Else
                                    Data2.Recordset.Edit
                                    Data2.Recordset("tm_venta") = "*"
                                    Data2.Recordset.Update
                                End If
                        End If
                    End If
                End If
                        
                If CDbl(table2.TextMatrix(table2.Row, Ven_TIR)) <> 0 Then
                    Call TICKETVENTA_Valorizar(2, Data2, FechaPago.Text)
                ElseIf CDbl(table2.TextMatrix(table2.Row, Ven_TIR)) <> 0 Then
                        Call TICKETVENTA_Valorizar(1, Data2, FechaPago.Text)
                ElseIf CDbl(table2.TextMatrix(table2.Row, Ven_VPAR)) <> 0 Then
                        Call TICKETVENTA_Valorizar(3, Data2, FechaPago.Text)
                End If
        
    ElseIf Columna = nColTir Then
        Data2.Recordset!TM_TIR = TEXT1vp.Text
        Data2.Recordset.Update
        
        Call TICKETVENTA_Valorizar(2, Data2, FechaPago.Text)
            
        Data2.Recordset.Edit
        Data2.Recordset!TM_TIR_TRAN = 0
        Data2.Recordset!TM_Pvp_TRAN = 0
        Data2.Recordset!tm_vp_TRAN = 0
        Data2.Recordset!tm_VP_TRAN_MO = 0
        Data2.Recordset.Update


    ElseIf Columna = nColVPar Then
            Data2.Recordset!TM_Pvp = TEXT1vp.Text
            Data2.Recordset.Update
            
            Call TICKETVENTA_Valorizar(1, Data2, FechaPago.Text)
            
            If Not Antes_Flag Then
                table2.TextMatrix(table2.Row, table2.Col) = Anterior
                Data2.Recordset.Edit
                Data2.Recordset!TM_Pvp_TRAN = Anterior
                Data2.Recordset.Update
            Else
                Data2.Recordset.Edit
                Data2.Recordset!TM_TIR_TRAN = Data2.Recordset("tm_tir")
                Data2.Recordset!TM_Pvp_TRAN = Data2.Recordset("tm_pvp")
                Data2.Recordset!tm_vp_TRAN = Data2.Recordset("tm_vp")
                Data2.Recordset!tm_VP_TRAN_MO = Data2.Recordset("tm_VpMo")
                Data2.Recordset.Update

            End If
          
    ElseIf Columna = nColValorPresente Then
            Data2.Recordset!TM_VP = TEXT1vp.Text
            Data2.Recordset.Update
            
            Call TICKETVENTA_Valorizar(3, Data2, FechaPago.Text)
            
            If Not Antes_Flag Then
                table2.TextMatrix(table2.Row, table2.Col) = Anterior
                Data2.Recordset.Edit
                Data2.Recordset!TM_VP = Anterior
                Data2.Recordset.Update
            Else
                Data2.Recordset.Edit
                Data2.Recordset!TM_TIR_TRAN = 0
                Data2.Recordset!TM_Pvp_TRAN = 0
                Data2.Recordset!tm_vp_TRAN = 0
                Data2.Recordset!tm_VP_TRAN_MO = 0
                Data2.Recordset.Update
            End If
            
            
    End If
    
    Call BacControlWindows(12)

   'Sumar el total y desplegar.-
        If Columna > nColMoneda Then
            Let TxtTotal.Text = TICKETVENTA_SumarTotal(FormHandle)
           'Let Flt_Result.Caption = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")
            
'            If CDbl(Flt_Result.Caption) < 0 Then
'                Let Flt_Result.ForeColor = &HFF&
'                Let Flt_Result.Caption = Format(Abs(CDbl(Flt_Result.Caption)), "###,###,###,##0.00")
'            Else
'                Let Flt_Result.ForeColor = &H0&
'            End If
        End If
        
        If Columna = nColNominal Then
            SendKeys "{TAB 1}"
        ElseIf Columna = nColTir Then
            SendKeys "{TAB 2}"
        ElseIf Columna = nColVPar Then
            SendKeys "{TAB 1}"
        End If
    
        Let MousePointer = vbDefault
        Let iFlagKeyDown = True
    
        Call VP_llenar_Grilla
    
        Let TEXT1vp.Text = ""
        Let TEXT1vp.Visible = False
        Let table2.Col = Colum
        Let table2.Row = Fila
        Let table2.TopRow = nTopRow

    End If

    Exit Sub
    
ExitEditError:

    Let MousePointer = vbDefault
    Let iFlagKeyDown = True
    Let table2.Row = table2.Rows - 1
    Let table2.TextMatrix(table2.Row, nColNominal) = Format(Monto, "###,###,###,##0.0000")
    Let TEXT1vp.Visible = False
    Exit Sub

End Sub

'---------------------------------------------------------------------------
' Funcion   :   funcNUMEROTICKET
' Objetivo  :   Entrega el numero de operacion para la operaciones Intramesa
' Fecha     :   20/10/2009
'===========================================================================
Private Function funcNUMEROTICKET() As Long
'---------------------------------------------------------------------------
Dim Data()  As Variant

    Let funcNUMEROTICKET = 0
 
    
    If Not Bac_Sql_Execute("EXECUTE DBO.SP_NUMERO_OPERACION_TICKET") Then
        Call MsgBox("Falla en la obtencion del número de operación Ticket Intramesa", vbCritical, "Ticket Intramesa")
        Exit Function
    End If
    
    If Not Bac_SQL_Fetch(Data()) Then
        Call MsgBox("Falla en la obtencion del número de operación Ticket Intramesa", vbCritical, "Ticket Intramesa")
        Exit Function
    End If
    
    Let funcNUMEROTICKET = Data(1)

End Function

Private Function funcVALIDAR(sTipOper As String) As Boolean
Dim sMensajeError   As String
Dim bControl        As Boolean


    Let bControl = False
    Let funcVALIDAR = False

    If sTipOper = "VI" Or sTipOper = "CI" Then
        If CDbl(Me.FltMtoini.Text) = 0 Then
            Let sMensajeError = sMensajeError & " - Monto Inicial debe ser distinto de cero.- " & vbCrLf & vbCrLf
        End If

        If CDbl(Me.FltTasa.Text) = 0 Then
            Let sMensajeError = sMensajeError & " - Tasa de Pacto debe ser distinta de cero.- " & vbCrLf & vbCrLf
        End If
        
        If Me.Intdias.Text = 0 Then
            Let sMensajeError = sMensajeError & " - Plazo debe ser distinto de cero.- " & vbCrLf & vbCrLf
        End If
    End If
    
  ' Actualizo informacion para los fondos mutuos
  ' ------------------------------------------------
    If sTipOper = "CP" Then
        If Trim$(Data1.Recordset("tm_instser")) = "FMUTUO" Then
            Call Data1.Recordset.MoveFirst
            Do While Not Data1.Recordset.EOF
                Call Data1.Recordset.Edit
                Let Data1.Recordset("tm_rutemi") = 97032000
                Let Data1.Recordset("tm_codemi") = 0
                Call Data1.Recordset.Update
                Call Data1.Recordset.MoveNext
            Loop
        End If
    End If
    
    If sTipOper = "CP" Or sTipOper = "VP" Then
        If CDbl(Me.TxtTotal.Text) = 0 Then
            Let sMensajeError = sMensajeError & " - Falta información para continuar con proceso de grabación.- " & vbCrLf & vbCrLf
        End If
    End If
  
  ' ____________________________________________________________________________________
  ' Validación general de las carteras y las mesas
  ' ---------------------------------------< * > ---------------------------------------
    If Me.CmbCarteraOrigen.ListIndex = -1 Then
        Let sMensajeError = sMensajeError & " - Debe seleccionar <Cartera Origen> " & vbCrLf & vbCrLf
    End If
    
    If Me.CmbCarteraDestino.ListIndex = -1 Then
        Let sMensajeError = sMensajeError & " - Debe seleccionar <Cartera Destino>" & vbCrLf & vbCrLf
    End If
    
    If Me.CmbMesaDestino.ListIndex = -1 Then
        Let sMensajeError = sMensajeError & " - Debe seleccionar <Contraparte>" & vbCrLf & vbCrLf
    End If
     
    If (Me.CmbCarteraOrigen.ListIndex <> -1 And Me.CmbCarteraDestino.ListIndex <> -1 And Me.CmbMesaDestino.ListIndex <> -1) Then
    
        If Trim(Right(CmbCarteraOrigen.Text, 10)) = Trim(Right(CmbCarteraDestino.Text, 10)) Then
                Let sMensajeError = sMensajeError & " - Cartera Origen y Destino no pueden ser iguales si las mesas son las mismas.- " & vbCrLf & vbCrLf
                Let bControl = True
        End If
        
        If LTrim(RTrim(Right(CmbMesaOrigen.Text, 10))) = LTrim(RTrim(Right(CmbMesaDestino.Text, 60))) Then
            
                    Let sMensajeError = sMensajeError & " - Mesas Origen y Destino no pueden ser iguales si las carteras son las mismas.- " & vbCrLf & vbCrLf
                    
            
            Let bControl = True
                End If
        
        If Not bControl Then
            If (Trim(Right(CmbMesaOrigen.Text, 10))) = (Trim(Right(CmbMesaDestino.Text, 10))) _
            Or Trim(Right(CmbCarteraOrigen.Text, 10)) = Trim(Right(CmbCarteraDestino.Text, 10)) Then
                Let sMensajeError = sMensajeError & " - Cartera Origen y Destino no pueden ser iguales si las mesas son las mismas.- " & vbCrLf & vbCrLf
    
            End If
        End If

    End If
    
    
    If Len(sMensajeError) > 0 Then
        
        MsgBox sMensajeError, vbExclamation, "Validacion de Datos"
        funcVALIDAR = False
        Exit Function
    End If
    
    funcVALIDAR = True
End Function




Function FUNC_Valida_Papeles_PM_ICP() As Boolean
Dim nMoneda As Integer

    Let FUNC_Valida_Papeles_PM_ICP = False
    
    
    With Data1.Recordset
    
        .MoveFirst
        nMoneda = .Fields("Tm_Monemi")
    
        Do While Not .EOF
        
            If nMoneda = 800 Or nMoneda = 801 Then
                FUNC_Valida_Papeles_PM_ICP = True
                Exit Do
            End If
            .MoveNext
        Loop
        .MoveFirst
    End With
    
    
    
    
End Function


Private Sub subLIMPIAR()
    
    Let frm_Principal.Enabled = True
    Let Frm_Secundario.Enabled = True
    Let Frm_Final.Enabled = True
    
    Let Me.Caption = "TICKET INTRAMESA "
    Let Me.Cmb_TipoOperacion.Enabled = True
    Me.Toolbar1.Buttons(3).Visible = False
    If bCargaCombos = False Then
    
        Call funcLoadObjCombo("EXECUTE dbo.SP_LOADTIPOPERACIONTICKET", Me.Cmb_TipoOperacion, False, True)
        
        'Call funcLoadObjCombo("EXECUTE bacparamsuda.DBO.SP_CARGAMESAS", Me.CmbMesaOrigen, False, False)
        
        Call funcLoadObjCombo("EXECUTE bacparamsuda.DBO.SP_CARGAMESAS", Me.CmbMesaDestino, False, True)
        'Call PROC_LLENA_COMBOS(Me.CmbCarteraDestino, 2, False, Me.Tag, GLB_CARTERA, GLB_ID_SISTEMA)
'        Call PROC_LLENA_COMBOS(Me.CmbMesaOrigen, 10, False, gsBac_User, "", GLB_CATEG)
'        Call PROC_LLENA_COMBOS(Me.CmbMesaDestino, 10, False, gsBac_User, "", GLB_CATEG)
        
        Let bCargaCombos = True
        
    End If
    
    
    Let Me.Cmb_TipoOperacion.ListIndex = -1
    Let Me.cmbTipoPago.ListIndex = -1
    Let Me.CmbCarteraOrigen.ListIndex = -1
    Let Me.CmbCarteraDestino.ListIndex = -1
    Let Me.CmbMesaDestino.ListIndex = -1
    Let Me.CmbMesaOrigen.ListIndex = -1
    
    Let Frm_Final.Enabled = False
    Let Frm_Secundario.Enabled = False
    Let Frm_Pactos.Visible = False
    Let Table1.Visible = False
    Let table2.Visible = False
    Let iFlagKeyDown = True
    
    Let Me.Frm_Final.Top = 2160
    Let Me.Height = 3765
    Let Me.Width = 9570
    
    Let Me.TxtTotal.Text = 0
    Let Me.cmbTipoPago.Enabled = False
    Let frm_Principal.Enabled = True
    
    On Error Resume Next
    If Not Data1.Recordset.RecordCount = 1 Then
        Call Colocardata1
    Else
        Data1.Recordset.MoveFirst
    End If

    Call TICKETCP_Eliminar(Data1)
    On Error GoTo 0
    
  ' _________________________________________
  ' Limpia las data de la compra y venta
  ' -----------------------------------------
    Call TICKETVENTA_IniciarTx(FormHandle, Data2, 0)
'    Call Llena_GrillaTICKET
    
    If table2.Rows > 2 Then
    Call VP_llenar_Grilla
    End If
    
    Call TICKETCP_IniciarTx(FormHandle, Data1)
    'call
  ' -----------------------------------------
  
End Sub





' --------------------------------------------------------------------------------
' Procedimiento :   subGRABA_Pactos
' Objetivo      :   Carga el arreglo con los datos de la transaccion de pacto
'                   para proceder a grabar en las tablas de ticket intramesa
' Parametros    :
'               dNumOperacion       Numero Operación
'               sTipoOperacion      Tipo Operacion
'               dNumOperRelacion    Numero Operacion relacion
' Fecha         :   20/10/2009
' ================================================================================
Private Sub subGRABA_Pactos(dNumOperacion As Long, sTipoOperacion As String, dNumOperRelacion As Long)
' --------------------------------------------------------------------------------
Dim Datos()


    Envia = Array()
    AddParam Envia, dNumOperacion
    AddParam Envia, sTipoOperacion
    AddParam Envia, dNumOperRelacion
    AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")                          '-> Fecha Operacion
    
    AddParam Envia, Trim(Right(CmbCarteraOrigen.Text, 5))                               '-> Código Cartera Origen
    AddParam Envia, Trim(Right(CmbMesaOrigen.Text, 5)) 'CmbMesaOrigen.ItemData(CmbMesaOrigen.ListIndex)         '-> Código Mesa Origen
    AddParam Envia, Trim(Right(CmbCarteraDestino.Text, 5))                              '-> Código Cartera Destino
    AddParam Envia, Trim(Right(CmbMesaDestino.Text, 5)) 'CmbMesaDestino.ItemData(CmbMesaDestino.ListIndex)       '-> Código Mesa Destino

    
    AddParam Envia, CmbMoneda.ItemData(CmbMoneda.ListIndex)                 '-> Código Moneda
    
    AddParam Envia, CDbl(FltMtoini.Text)                                    '-> Monto Inicial
    AddParam Envia, CDbl(FltTasa.Text)                                      '-> Tasa
    AddParam Envia, CDbl(Lbl_Mt_Inicial.Caption)                            '-> Monto Inicial Pesos
    AddParam Envia, CInt(Intdias.Text)                                      '-> Plazo
    AddParam Envia, Format(Dtefecven.Text, "yyyymmdd")                      '-> Fecha Vencimiento
    AddParam Envia, CDbl(Lbl_Mt_Final.Caption)                              '-> Monto Final UM
    AddParam Envia, gsBac_User                                              '-> Usuario
    
    
    If Bac_Sql_Execute("EXECUTE dbo.SP_GRABAOPERACION_TICKETINTRAMESA_PACTOS", Envia) Then
        If Bac_SQL_Fetch(Datos()) Then
        
            If Datos(1) < 0 Then
                Exit Sub
            End If
        
        End If
    
    End If
    
    
    
End Sub


Private Sub CmbCarteraOrigen_LostFocus()
    
    
    If CmbCarteraOrigen.ListIndex <> -1 Then
        If Me.Tag = "CP" Then
            Table1.Enabled = True
            Call Table1.SetFocus
        ElseIf Me.Tag = "VP" Then
                If table2.Enabled = True Then
                    Call table2.SetFocus
                End If
        Else
            If Me.CmbMoneda.Enabled = True Then
                Call Me.CmbMoneda.SetFocus
            End If
        End If
    End If
End Sub

Private Sub cmbTipoPago_KeyPress(KeyAscii As Integer)

    If cmbTipoPago.ListIndex <> -1 Then
    If KeyAscii = vbKeyReturn Then Me.CmbCarteraOrigen.SetFocus 'revisar
    End If
End Sub

Private Sub Form_Activate()

   ' If bCargaCombos Then
     '  Call subSELECTMESA
   ' End If
    
End Sub



Private Sub TEXT2VP_KeyDown(KeyCode As Integer, Shift As Integer)
Dim nFilaValida As Integer
Dim cClaveAnterior  As String
    
    If KeyCode = 27 Then
        Call TEXT2VP_LostFocus
    End If

    If KeyCode = 13 Then
        
        If Not table2.Rows = 1 Then
            Call Colocardata2
        Else
            Call Data2.Recordset.MoveFirst
        End If
        
        Call Data2.Recordset.Edit
        Let Data2.Recordset!tm_clave_dcv = Text2VP.Text
        Call Data2.Recordset.Update
        Let table2.TextMatrix(table2.Row, nColClaveDCV) = Trim(Text2VP.Text)
        Call table2.SetFocus
    End If
    
    
End Sub



Private Sub TEXT1VP_KeyPress(KeyAscii As Integer)

    If Mid(table2.TextMatrix(table2.Row, nColSerie), 1, 6) = "FMUTUO" And (table2.Col = nColTir Or table2.Col = nColTTran) Then
        Let TEXT1vp.Enabled = False
    End If

End Sub

Private Sub TEXT1VP_LostFocus()
    
    On Error Resume Next

   Let TEXT1vp.Visible = False
    Call BacControlWindows(100)
    Call table2.SetFocus

End Sub

Private Sub TEXT2VP_GotFocus()

   ' Call PROC_POSI_TEXTO(table2, Text2VP)
   ' Let Text2VP.SelLength = Len(Text2VP)
   ' Let Text2VP.SelStart = Len(Text2VP)
    
End Sub


Function FUNC_Verifica_Papeles() As Boolean
Dim nMoneda As Long

    FUNC_Verifica_Papeles = False

    With Data2.Recordset

        .MoveFirst
    
        Do While Not .EOF
            If .Fields("Tm_Venta") = "V" Or .Fields("Tm_Venta") = "P" Then
                If nMoneda = 0 Then
                    Let nMoneda = .Fields("Tm_Monemi")
                End If
                If nMoneda <> .Fields("Tm_Monemi") Then
                    Select Case nMoneda
                    
                        Case 999, 998, 997, 995, 994
                        
                            If .Fields("Tm_Monemi") = 999 Or _
                                .Fields("Tm_Monemi") = 998 Or _
                                .Fields("Tm_Monemi") = 997 Or _
                                .Fields("Tm_Monemi") = 995 Or _
                                .Fields("Tm_Monemi") = 994 Then
                                Let FUNC_Verifica_Papeles = False
                            Else
                                Let FUNC_Verifica_Papeles = True
                                Exit Do
                            End If
                            
                        Case Else
                        
                            Let FUNC_Verifica_Papeles = True
                            Exit Do
                    End Select
                End If
            End If
            .MoveNext
        Loop
        .MoveFirst
    End With

End Function

Private Sub TEXT2VP_KeyPress(KeyAscii As Integer)
    Let KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub TEXT2VP_LostFocus()
    Text2VP.Text = ""
    Text2VP.Visible = False
    table2.SetFocus
End Sub

Private Sub Llena_GrillaTICKET()
Dim nContador    As Integer
Dim nTipoCambio  As Double
   
    Let Table1.TextMatrix(Table1.Row, nCol_UM) = Data1.Recordset!TM_NEMMON
      
    Let Table1.TextMatrix(Table1.Row, nCol_NOMINAL) = Format(Data1.Recordset!tm_nominal, "#,###0.0000")
    Let Table1.TextMatrix(Table1.Row, nCol_VPAR) = Format(Data1.Recordset!TM_Pvp, "#,##0.0000")
     
    If Mid(Table1.TextMatrix(Table1.Row, nCol_SERIE), 1, 6) = "FMUTUO" Then
         If Table1.TextMatrix(Table1.Row, nCol_UM) = "CLP" Then
            Let Table1.TextMatrix(Table1.Row, nCol_VPS) = Format(Data1.Recordset!TM_MT, "#,##0")
         Else
            Let Table1.TextMatrix(Table1.Row, nCol_VPS) = Format(Data1.Recordset!TM_MT, "#,##0.0000")
         End If
    Else
      Let Table1.TextMatrix(Table1.Row, nCol_VPS) = Format(Data1.Recordset!TM_MT, "#,###,###,##0" + IIf(Table1.TextMatrix(Table1.Row, nCol_UM) <> "USD", IIf(bFlagDpx, ".0000", ""), ".00"))
    End If
   
    Let Table1.TextMatrix(Table1.Row, nCol_TIR) = Format(Data1.Recordset!TM_TIR, "#,##0.0000")
    
    
End Sub


Private Sub Genera_Grilla()

    Let Table1.ColWidth(nCol_SERIE) = 1400
    Let Table1.ColWidth(nCol_UM) = 600
    Let Table1.ColWidth(nCol_NOMINAL) = 2200
    Let Table1.ColWidth(nCol_TIR) = 1200
    Let Table1.ColWidth(nCol_VPAR) = 1200
    Let Table1.ColWidth(nCol_VPS) = 2400
    Let Table1.ColWidth(nCol_CUST) = 0
    
    Let Table1.TextMatrix(0, nCol_SERIE) = "Serie"
    Let Table1.TextMatrix(0, nCol_UM) = "UM"
    Let Table1.TextMatrix(0, nCol_NOMINAL) = "Nominal"
    Let Table1.TextMatrix(0, nCol_TIR) = "% Tir"
    Let Table1.TextMatrix(0, nCol_VPAR) = "% Var"
    Let Table1.TextMatrix(0, nCol_VPS) = "Valor Presente"
    
    Let Table1.TextMatrix(1, nCol_NOMINAL) = "0.0000"
    Let Table1.TextMatrix(1, nCol_TIR) = "0.0000"
    Let Table1.TextMatrix(1, nCol_VPAR) = "0.0000"
    Let Table1.TextMatrix(1, nCol_VPS) = "0"
    
    Table1.FillStyle = flexFillSingle
    Table1.FocusRect = flexFocusLight
    
    
    
    
End Sub



Private Sub Form_Unload(Cancel As Integer)
    bCargaCombos = False
End Sub


Private Sub Table1_GotFocus()

    Let Table1.CellBackColor = &H808000
    Let Text1.Font.bold = True

End Sub

Private Sub subLIMPIA_Grilla()
  
    Let Table1.TextMatrix(Table1.RowSel, tckCol_NOMINAL) = "0.0000"
    Let Table1.TextMatrix(Table1.RowSel, tckCol_TIR) = "0.0000"
    Let Table1.TextMatrix(Table1.RowSel, tckCol_VPAR) = "0.0000"
    Let Table1.TextMatrix(Table1.RowSel, tckCol_VPS) = "0.0000"
    
End Sub


Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)
Dim aux&
Dim letra1 As String
Dim Indice1 As Integer


On Error GoTo KeyDownError


If iFlagKeyDown = False Then
On Error GoTo 0
  Exit Sub

End If

    If KeyCode = vbKeyInsert Then
    
        aux& = Table1.Row
        
        If Table1.Enabled = True Then: Table1.SetFocus 'probando1
            
        BacControlWindows 60
        Bac_SendKey vbKeyHome
      
        'ACAMODIF
        If Trim$(Table1.TextMatrix(Table1.Row, nCol_SERIE)) = "" Then
            MsgBox "Ingrese serie antes de insertar otra Fila", vbInformation, TITSISTEMA
            If Table1.Enabled = True Then: Table1.SetFocus
            Exit Sub
        End If
        'ACAMODIF

      ' VB+- 09/06/2000  se valida que no se pueda agregar otro registro si no tiene definido custodia
        If Trim$(Table1.TextMatrix(Table1.Row, nCol_CUST)) = "" Then
            MsgBox "Antes de agregar otro instrumento" & vbCrLf & vbCrLf & "debe definir custodia para instrumento", vbExclamation, TITSISTEMA
            If Table1.Enabled = True Then: Table1.SetFocus
            On Error GoTo 0
            Exit Sub
        
        Else
            Data1.Refresh
        
            BacControlWindows 60
        
            If Trim$(Table1.TextMatrix(Table1.Row, nCol_UM) <> "" And Table1.TextMatrix(Table1.Row, nCol_TIR) <> 0 And Val(Table1.TextMatrix(Table1.Row, nCol_VPS))) <> 0 Then
                BacControlWindows 60
                Call TICKETCP_Agregar(Hwnd, Data1)
                TxtTotal.Enabled = False
                Toolbar1.Buttons(2).Enabled = False
                Table1.Col = nCol_SERIE
            Else
                If Trim$(Mid(Table1.TextMatrix(Table1.Row, nCol_SERIE), 1, 6) = "FMUTUO" And Val(Table1.TextMatrix(Table1.Row, nCol_VPS))) <> 0 Then
                    BacControlWindows 60
                    Call TICKETCP_Agregar(Hwnd, Data1)
                    TxtTotal.Enabled = False
                    Toolbar1.Buttons(2).Enabled = False
                    Table1.Col = nCol_SERIE
                Else
                    Table1.Row = aux&
                End If
            End If
        
        End If

        Table1.Rows = Table1.Rows + 1
        Table1.Row = Table1.Rows - 1
        
        Call subLIMPIA_Grilla
        
        Table1.Col = nCol_SERIE
        Table1.ColSel = nCol_SERIE
   
    ElseIf KeyCode = vbKeyUp Then
    
        If Trim$(Table1.TextMatrix(Table1.Row, nCol_SERIE)) = "" Then
         BacControlWindows 60

         If Data1.Recordset.RecordCount > 1 Then
            Call TICKETCP_Eliminar(Data1)
            Data1.Refresh
            TxtTotal.Text = TICKETCP_SumarTotal(FormHandle)

          ' VB+ 02/03/2000 es para habilitar o desabilitar botones
          ' ===========================================================
            If Len(Data1.Recordset("tm_instser")) <> 0 And Toolbar1.Buttons(3).Enabled = False Then
               Toolbar1.Buttons(3).Enabled = True
            End If

            If Data1.Recordset("tm_nominal") <> 0 And Toolbar1.Buttons(4).Enabled = False Then
               Toolbar1.Buttons(4).Enabled = True
            End If

            If Data1.Recordset("tm_mt") <> 0 Then
               TxtTotal.Enabled = True
               Toolbar1.Buttons(2).Enabled = True
            Else
               TxtTotal.Enabled = False
               Toolbar1.Buttons(2).Enabled = False
            End If
          ' ===========================================================
          ' VB- 02/03/2000

         End If

      End If

   ElseIf KeyCode = vbKeyDelete Then
      If Not Data1.Recordset.RecordCount = 1 Then
         Call Colocardata1

      Else
         Data1.Recordset.MoveFirst

      End If

      Call TICKETCP_Eliminar(Data1)

      If Not Table1.Rows = 2 Then
         Table1.RemoveItem Table1.Row
         Table1.Col = nCol_SERIE
         Table1.ColSel = nCol_SERIE

      Else
         Table1.TextMatrix(1, 0) = ""
         Table1.TextMatrix(1, 1) = ""
         Call subLIMPIA_Grilla

      End If

      
      Table1.Refresh
      Data1.Refresh
      TxtTotal.Text = TICKETCP_SumarTotal(FormHandle)

      ' VB+ 02/03/2000 es para habilitar o desabilitar botones
      ' ===========================================================
      If Len(Data1.Recordset("tm_instser")) <> 0 And Toolbar1.Buttons(3).Enabled = False Then
         Toolbar1.Buttons(3).Enabled = True

      End If

      If Data1.Recordset("tm_nominal") <> 0 And Toolbar1.Buttons(4).Enabled = False Then
         Toolbar1.Buttons(4).Enabled = True

      End If

      If Data1.Recordset("tm_mt") <> 0 Then
         TxtTotal.Enabled = True
         Toolbar1.Buttons(2).Enabled = True
      Else
         TxtTotal.Enabled = False
         Toolbar1.Buttons(2).Enabled = False
      End If
      ' ===========================================================
      ' VB- 02/03/2000

   End If

   On Error GoTo 0
   Exit Sub

KeyDownError:
   On Error GoTo 0
   MsgBox "Problemas en tabla de ingreso de datos: " & err.Description, vbExclamation, gsBac_Version
   Data1.Refresh
   Exit Sub

End Sub



Private Function Colocardata1()
   Dim iContador  As Integer
   
   Let Monto = CDbl(Table1.TextMatrix(Table1.RowSel, 3))
   If Not Data1.Recordset.EOF() Then
        Call Data1.Recordset.MoveFirst
    Else
        Call TICKETCP_Agregar(FormHandle, Data1)
    End If
   
   For iContador = 1 To Table1.Row - 1
      Call Data1.Recordset.MoveNext
   Next iContador
End Function

Private Sub Table1_KeyPress(KeyAscii As Integer)
Dim INDICE, Indice1     As Integer
Dim Letra, letra1       As String

      
    If Table1.Col <> 0 And Table1.TextMatrix(Table1.Row, tckCol_SERIE) = "" Then
        MsgBox "Debe Ingresar Número de Serie", vbExclamation + vbOKOnly, "Error"
        Exit Sub
    End If
      
    If Table1.Col = tckCol_SERIE Then
        Call BacControlWindows(100)
        Let Text1.Enabled = True
        Let Text1.Visible = True
    
        If KeyAscii <> vbKeyReturn Then
            Let Text1.Text = UCase(Chr(KeyAscii))
        Else
            Let Text1.Text = Trim(Table1.TextMatrix(Table1.Row, Table1.Col))
        End If
    
        Let Text1.MaxLength = 12
        Call Text1.SetFocus
        Call BacControlWindows(100)
        Exit Sub
        
    End If

   
    Call FUNC_Decimales_de_Moneda(Table1.TextMatrix(Table1.Row, nCol_UM))
    
'.......'
'   *   '   If Table1.Col < nCol_CUST And Table1.Col <> nCol_UM And Table1.Col <> nCol_SERIE Then
'  <|>  '
'   O   '
'  / \  '
' =   = '
'.......'

    If Table1.Col <> tckCol_SERIE And Table1.Col <> tckCol_UM And Table1.Col <> 6 Then

        If Table1.Col = tckCol_TIR And Mid(Table1.TextMatrix(Table1.Row, tckCol_SERIE), 1, 6) = "FMUTUO" Then
            Let TEXT2.Enabled = False
            Let Combo1.ListIndex = 1
            Let Combo1.Enabled = False
            Exit Sub
        Else
            Let TEXT2.Enabled = True
            Let Combo1.Enabled = True
            Let TEXT2.Text = BacCtrlTransMonto(CDbl(Table1.TextMatrix(Table1.Row, Table1.Col)))
          
            If Table1.Col = tckCol_VPS Then
                Let TEXT2.CantidadDecimales = gsMONEDA_Decimales
            Else
                If Mid(Table1.TextMatrix(Table1.Row, tckCol_SERIE), 1, 6) = "FMUTUO" Then
                    If Table1.TextMatrix(Table1.Row, nCol_UM) = "CLP" Then
                        If Table1.Col = tckCol_VPAR Then
                            Let TEXT2.CantidadDecimales = 4
                        Else
                            Let TEXT2.CantidadDecimales = 4
                        End If
                    Else
                        Let TEXT2.CantidadDecimales = 4
                    End If
                Else
                    If bFlagDpx Then
                        Let TEXT2.CantidadDecimales = 2
                    Else
                        Let TEXT2.CantidadDecimales = 4
                    End If
                End If
            End If
            
            Let TEXT2.Visible = True
            
            If KeyAscii > 47 And KeyAscii < 58 Then TEXT2.Text = Chr(KeyAscii)
                Call TEXT2.SetFocus
                Exit Sub
            End If
        End If

        Call BacToUCase(KeyAscii)

    If Table1.Col = nCol_CDCV Then
    If IsNull(Table1.TextMatrix(Table1.Row, nCol_CUST)) Or Trim$(Table1.TextMatrix(Table1.Row, nCol_CUST)) <> "DCV" Then
       KeyAscii = 0
    
    End If
    
    End If

   If Table1.Col = nCol_CUST Then
   
        If Not Data1.Recordset.RecordCount = 1 Then
            Call Colocardata1
        Else
            Call Data1.Recordset.MoveFirst
        End If

        Data1.Recordset.Edit

        Select Case UCase$(Chr(KeyAscii))
            Case "C":
                Data1.Recordset("tm_custodia") = "CLIENTE"
                Data1.Recordset("tm_clave_dcv") = " "
                KeyAscii = vbKeyReturn
        
            Case "D":
                If Not IsNull(Data1.Recordset("tm_custodia")) Then
                    If Trim$(Data1.Recordset("tm_custodia")) <> "DCV" Then
                        Let Data1.Recordset("tm_custodia") = "DCV"
                        Let KeyAscii = vbKeyReturn
                    Else
                        Let KeyAscii = 0
                    End If
                Else
                    Let Data1.Recordset("tm_custodia") = "DCV"
                    Let KeyAscii = vbKeyReturn
                End If
        
            Case "P":
            
                Let Data1.Recordset("tm_custodia") = "PROPIA"
                Let Data1.Recordset("tm_clave_dcv") = " "
                Let KeyAscii = vbKeyReturn
                
            Case Else
            
                Let KeyAscii = 0
                
        End Select

      Data1.Recordset.Update
   End If


    If Table1.Col > nCol_SERIE Then
       If Len(Trim$(Table1.TextMatrix(Table1.Row, nCol_SERIE))) = 0 Then
          KeyAscii = 0
       End If
    End If
   

    If KeyAscii = 27 Then iFlagKeyDown = True

    Select Case Table1.Col
        Case nCol_NOMINAL, nCol_VPS
        
            If KeyAscii <> 27 Then
                If Not iFlagKeyDown Then
                    Let KeyAscii = BacPunto(Table1, KeyAscii, 12, 4)
                End If
                KeyAscii = BACValIngNumGrid(KeyAscii)
            End If

        
        Case nCol_TIR, nCol_VPAR
        
            If KeyAscii <> 27 Then
                If Not iFlagKeyDown Then
                    Let KeyAscii = BacPunto(Table1, KeyAscii, 3, 4)
                End If
                Let KeyAscii = BACValIngNumGrid(KeyAscii)
            End If
    End Select


End Sub




Private Sub Table1_LeaveCell()
   Table1.CellBackColor = &H8000000F
End Sub





Private Sub ChkMoneda(Columna%)
   Dim MonLiq           As Integer
   Dim Mt#
   Dim MtMl#
   Dim TcMl#

Exit Sub

   Mt# = Data1.Recordset("tm_mt")
   MtMl# = Data1.Recordset("tm_mtml")
   TcMl# = Data1.Recordset("tm_tcml")

   If MonLiq = giMonLoc Then
      If Data1.Recordset("tm_monemi") = MonLiq Then
         TcMl# = 1
         MtMl# = Mt#
      Else
         If Columna = nCol_VPS Then
            MtMl# = Mt# * TcMl#
         ElseIf Columna = 8 Then
            MtMl# = Mt# * TcMl#
         ElseIf Columna = 9 Then
            Mt# = MtMl# * TcMl#
         Else
            MtMl# = Mt# * TcMl#
         End If
      End If
   Else
      If Data1.Recordset("tm_monemi") = MonLiq Then
         TcMl# = 1
         MtMl# = Mt#
      Else
         If TcMl# = 0 Then
            MtMl# = 0
         Else
            If Columna = 7 Then
               MtMl# = Mt# / TcMl#
            ElseIf Columna = 8 Then
               MtMl# = Mt# / TcMl#

            ElseIf Columna = 9 Then
               Mt# = MtMl# / TcMl#
            Else
               MtMl# = Mt# / TcMl#
            End If
         End If
      End If
   End If

   Call BacControlWindows(30)

   Call Data1.Recordset.Edit
    Let Data1.Recordset("tm_mt") = Mt#
    Let Data1.Recordset("tm_mtml") = MtMl#
    Let Data1.Recordset("tm_tcml") = TcMl#
   Call Data1.Recordset.Update
End Sub


Public Function funcCHKSerieTICKET(cInstser As String) As Boolean
Dim Sal As BacTypeChkSerie

    funcCHKSerieTICKET = False
       
    If CPCI_ChkSerie(cInstser, Sal) = True Then
        If Sal.nError = 0 Then
            funcCHKSerieTICKET = True
        End If
    End If
    

End Function

Private Function Validar_SerieFM(Serie As String) As Boolean
Dim iRow As Integer
Dim noOk As Boolean

noOk = True

    If Mid(Serie, 1, 6) = "FMUTUO" Then
       For iRow = 1 To Table1.Rows - 2
            If Table1.TextMatrix(iRow, tckCol_SERIE) <> Serie Then
                noOk = False
                Exit Function
            End If
       Next iRow
    Else
       For iRow = 1 To Table1.Rows - 2
            If Mid(Table1.TextMatrix(iRow, tckCol_SERIE), 1, 6) = "FMUTUO" Then
                noOk = False
                Exit Function
            End If
       Next iRow
    End If

Validar_SerieFM = noOk

End Function





Private Sub Cmb_TipoOperacion_Click()
 
    If Cmb_TipoOperacion.ListIndex <> -1 Then
    
        Let Me.Cmb_TipoOperacion.Enabled = False
        Let cmbTipoPago.Enabled = True
        Let Me.Tag = Right(Me.Cmb_TipoOperacion.Text, 2)
    
        'Call PROC_LLENA_COMBOS(Me.CmbCarteraOrigen, 2, False, Me.Tag, GLB_CARTERA, GLB_ID_SISTEMA)
        Call PROC_LLENA_COMBOS(Me.CmbCarteraDestino, 2, False, Me.Tag, GLB_CARTERA, GLB_ID_SISTEMA)
        Call PROC_LLENA_COMBOS(Me.CmbCarteraOrigen, 7, False, Me.Tag, GLB_CARTERA, GLB_ID_SISTEMA, "", gsBac_User)
        'Call PROC_LLENA_COMBOS(Me.CmbCarteraDestino, 7, False, Me.Tag, GLB_CARTERA, GLB_ID_SISTEMA, "", gsBac_User)
        'Call PROC_LLENA_COMBOS(cmbTCart, 7, False, IIf(Mid$(BacFrmIRF.Tag, 1, 2) = "RP", "VI", Mid$(BacFrmIRF.Tag, 1, 2)), GLB_CARTERA, GLB_ID_SISTEMA, "", gsBac_User)
    
        Call PROC_LLENA_COMBOS(Me.CmbMesaOrigen, 10, False, gsBac_User, "", GLB_CATEG)
        'Call PROC_LLENA_COMBOS(Me.CmbMesaDestino, 10, False, gsBac_User, "", GLB_CATEG)
        
        Me.Toolbar1.Buttons(3).Visible = False
        If Me.Tag = "CP" Then
            Call cmbTipoPago.SetFocus
            
            Call TICKETCP_IniciarTx(FormHandle, Data1)
'            Call Data1.Refresh

            Let Table1.cols = 7
            Call Genera_Grilla

            Let Me.Width = 9570
            Let Me.Height = 7305
            
            Let Table1.Top = 2160
            Let Frm_Final.Top = 5760
            
            Let Frm_Pactos.Enabled = False
            Let Frm_Pactos.Visible = False
            
            
            Let Table1.Visible = True
            Let Table1.Rows = 1: Let Table1.Rows = 2
            Let Me.cmbTipoPago.Enabled = True
            
            Let lblTot.Visible = True
            Let TxtTotal.Visible = True
            Let TxtTotal.Enabled = False
            Let Me.CmbCarteraOrigen.Enabled = True
            Let Table1.Enabled = False
            
        End If
        
        
        If Me.Tag = "VP" Then
            Call cmbTipoPago.SetFocus
            Me.Toolbar1.Buttons(3).Visible = True
            Call TICKETVENTA_IniciarTx(FormHandle, Data2, "1")

            Let Me.Width = 9570
            Let Me.Height = 7305
            
            Let table2.Left = 120
            Let table2.Height = 3900
             
            Let table2.Top = 2160
            
            Let Frm_Final.Top = 5760
            
            Let Frm_Pactos.Enabled = False
            Let Frm_Pactos.Visible = False
            
            Let table2.Enabled = False
            Let table2.Visible = True
            Let table2.Rows = 1: Let table2.Rows = 2
            
            Let Me.cmbTipoPago.Enabled = True
            
            Let lblTot.Visible = True
            Let TxtTotal.Visible = True
            Let TxtTotal.Enabled = False
            Let Me.CmbCarteraOrigen.Enabled = True
            
            table2.cols = 24
            Call VP_Nombre_Grilla
            'Call TOOLFILTRAR
            
            Data2.Refresh
        End If
        
        
        If Me.Tag = "VI" Or Me.Tag = "CI" Then
        
            Call subLimpiaPACTOS
            Let Me.Width = 9540
            Let Me.Height = 5550
            
            Let Frm_Pactos.Top = 2160
            
            Let Frm_Final.Top = 3960
            
            Let Frm_Pactos.Enabled = True
            Let Table1.Enabled = False
            Let Table1.Visible = False
            Let Frm_Pactos.Visible = True
            
            Let Me.cmbTipoPago.ListIndex = 0
            Let Me.cmbTipoPago.Enabled = False
            Let Frm_Secundario.Enabled = True
           
            
            Let lblTot.Visible = False
            Let TxtTotal.Visible = False
            Let TxtTotal.Enabled = False
            
          ' CargaMonedas para Pactos
          
            If Not funcFindMoneda(CmbMoneda, "IB") Then
                Exit Sub
            End If
            Let Me.CmbCarteraOrigen.Enabled = True
            Call Me.CmbCarteraOrigen.SetFocus
                
            End If
        End If
        
    If Me.Cmb_TipoOperacion.ListIndex <> -1 Then
      Me.Caption = "TICKET INTRAMESA ( " & Trim(Mid(Me.Cmb_TipoOperacion.Text, 1, Len(Trim(Me.Cmb_TipoOperacion.Text)) - 2)) & ")"
    End If
            
    CmbCarteraDestino.ListIndex = -1
End Sub



Private Sub subSELECTMESA()
Dim J       As Integer
Dim codMesa As Integer

On Error Resume Next
    Envia = Array()
    AddParam Envia, gsBac_User
    
    If Bac_Sql_Execute("dbo.SP_USUARIO_MESA_TICKET_RTAFIJA", Envia) Then
        If Bac_SQL_Fetch(Datos()) Then
            codMesa = Datos(1)
        Else
            codMesa = -1
        End If
        
    End If
     
    
    J = 0
    
'    If CmbMesaOrigen.ListIndex <> -1 Then
        Do While Me.CmbMesaOrigen.ItemData(J) <> codMesa And J < CmbMesaOrigen.ListCount - 1
            J = J + 1
        Loop
        
        If J = CmbMesaOrigen.ListCount - 1 Then
            CmbMesaOrigen.ListIndex = J
        Else
            CmbMesaOrigen.ListIndex = -1
        End If
    
        Let CmbMesaOrigen.Enabled = False
 '   End If
    
End Sub




Private Sub CmbCarteraOrigen_Click()

    If CmbCarteraOrigen.ListIndex <> -1 Then
        Let CmbCarteraOrigen.Enabled = False
    End If
    
    
    
    
End Sub


Private Sub cmbTipoPago_Click()
Dim nCont   As Integer
Dim nSw     As Integer
   
    If cmbTipoPago.ListIndex <> -1 Then
        If Me.Visible = True Then
            Select Case cmbTipoPago.ListIndex
                Case Is = 0
                    Let FechaPago.Text = Format(gsBac_Fecp, "dd/mm/yyyy")
                Case Is = 1
                    Let FechaPago.Text = Format(gsBac_Fecx, "dd/mm/yyyy")
                Case Is = 2
                    Let nSw = 0
                    Let nCont = 1
                    
                    Do While nSw = 0
                        FechaPago.Text = Format$(DateAdd("d", nCont, gsBac_Fecx), "dd/mm/yyyy")
                        If EsFeriado(CDate(FechaPago.Text), "00001") Then
                            nCont = nCont + 1
                        Else
                            nSw = 1
                        End If
                    Loop
                    
                Case Else
                    MsgBox "Problemas con el tipo de pago"
            End Select
        End If
    
        Let Me.frm_Principal.Enabled = False
        Let Me.Frm_Secundario.Enabled = True
        If Me.CmbCarteraOrigen.Enabled Then
            Call Me.CmbCarteraOrigen.SetFocus
        End If
        Let Me.Frm_Final.Enabled = True
    End If
End Sub


Private Sub Form_Load()

    Screen.MousePointer = vbHourglass
        
    Call callSTART
    
    Screen.MousePointer = vbDefault
    
    CmbCarteraDestino.ListIndex = -1
    
End Sub



Private Sub CmbMoneda_Click()
Dim x         As Integer
Dim decimales As Integer


    If bCargaCombos <> True Then
        Exit Sub
    End If

    If CmbMoneda.ListIndex <= -1 Then
        Exit Sub
    End If
    
    Lbl_Titulo_Ini.Caption = "Monto Inicial " + Trim(CmbMoneda.Text)
    Lbl_Titulo_Fin.Caption = "Monto Final " + Trim(CmbMoneda.Text)

    Screen.MousePointer = vbHourglass
        
    Envia = Array(CDbl(CmbMoneda.ItemData(CmbMoneda.ListIndex)), _
            Format(gsBac_Fecp, "yyyymmdd"), _
            CDbl(CmbMoneda.ItemData(CmbMoneda.ListIndex)))
         
    If Not Bac_Sql_Execute("SP_VALBASE_MONEDA", Envia) Then
       Screen.MousePointer = 0
       MsgBox "NO Encuentra Datos de Moneda Seleccionada.", 16
       Exit Sub
    End If
        
    Do While Bac_SQL_Fetch(Datos())
       IntBase.Text = CDbl(Datos(2))
       Pnl_MX.Caption = Mid$(Datos(3), 1, 1)
       decimales = Val(Datos(4))
       If Pnl_MX.Caption = "S" Then
          Lbl_ValMon.Caption = Format(1, "#,##0.0000")
          FltMtoini.CantidadDecimales = decimales
       Else
          Lbl_ValMon.Caption = Format(Datos(1), "#,##0.0000")
          FltMtoini.CantidadDecimales = 0
       End If
    Loop

    If Lbl_ValMon.Caption = "0.0000" Or IntBase.Text = 0 Then
       MsgBox "No se encuentra Base o Valor para moneda seleccionada", vbCritical
       Me.Lbl_Mt_Inicial = 0
       Lbl_Mt_Final = 0
       Screen.MousePointer = 0
       Exit Sub
    End If
    
    If decimales = 0 Then
       Formato_Monto = "#,##0"
    Else
       Formato_Monto = "#,##0." + String(decimales, "0")
    End If
    
    If CmbMoneda.Text = "CLP" Or CmbMoneda.Text = "UF" Then
       Label3.Caption = "Monto Inicial $$"
       Lbl_ValMon.Caption = Format(Lbl_ValMon, "#,##0.0000")
    Else
       Label3.Caption = "Monto Inicial " + Trim(CmbMoneda.Text)
    End If
        
    Call funcFindDatGralMoneda(CDbl(CmbMoneda.ItemData(CmbMoneda.ListIndex)))
    SwMx = BacDatGrMon.mnmx
     
    Screen.MousePointer = 0

    Call CalcInterTICKET(FltMtoini.Text, Lbl_Mt_Final.Caption, FltTasa.Text, Lbl_ValMon.Caption, IntBase.Text, Format(Dtefecven.Text, "dd/mm/yyyy"), Format(gsBac_Fecp, "dd/mm/yyyy"), " 1")
    
    If Me.Frm_Secundario.Enabled = True Then Call Me.FltMtoini.SetFocus
    

End Sub



Private Sub cmbMoneda_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      Call Bac_SendKey(vbKeyTab)

   End If

End Sub

Private Sub Dtefecven_Change()

   Label5.Caption = Mid$(BacDiaSem(Dtefecven.Text), 1, 3)
   'dtefecven_LostFocus
   


End Sub

Private Sub dtefecven_GotFocus()

   Dtefecven.Tag = Dtefecven.Text

End Sub

Private Sub dtefecven_LostFocus()
Dim dFecha

    dFecha = gsBac_Fecp
    

   If Dtefecven.Tag <> Dtefecven.Text Then
      If Dtefecven.Text <> dFecha Then
         If BacEsHabil(Dtefecven.Text) Then
            Intdias.Text = DateDiff("d", dFecha, Dtefecven.Text)
            Intdias.Tag = DateDiff("d", dFecha, Dtefecven.Text)
            Call Bac_SendKey(vbKeyTab)
            Call CalcInterTICKET(FltMtoini.Text, Lbl_Mt_Final.Caption, FltTasa.Text, Lbl_ValMon.Caption, IntBase.Text, Format(Dtefecven.Text, "dd/mm/yyyy"), Format(gsBac_Fecp, "dd/mm/yyyy"), " 1")

         Else
            MsgBox "Fecha de Vcto. no es día Hábil", 16
            Intdias.Text = Intdias.Tag
            Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, dFecha), "dd/mm/yyyy")

         End If

      Else
         MsgBox "Fecha de Vcto. Ingresada igual a la de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
         Intdias.Text = Intdias.Tag
         Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, dFecha), "dd/mm/yyyy")

      End If

   End If
   If Val(Intdias.Text) <> 0 Then
       If Format(Dtefecven.Text, "yyyymmdd") <= Format(gsBac_Fecp, "yyyymmdd") Then
          MsgBox "Fecha de Vcto. debe ser Mayor a Fecha de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
          Intdias.Text = Intdias.Tag
          Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, dFecha), "dd/mm/yyyy")
    
       End If
    End If
End Sub

Private Sub FltMtoini_GotFocus()

   FltMtoini.Tag = FltMtoini.Text

End Sub

Private Sub FltMtoini_KeyPress(KeyAscii As Integer)

'   If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
'      KeyAscii = Asc(gsBac_PtoDec)
'
'   End If
'
   If KeyAscii = 13 Then
      'Call Bac_SendKey(vbKeyTab)
      Me.FltTasa.SetFocus

   End If

End Sub

Private Sub FltMtoini_LostFocus()

    If FltMtoini.Text <> FltMtoini.Tag Then
        Call CalcInterTICKET(FltMtoini.Text, Lbl_Mt_Final.Caption, FltTasa.Text, Lbl_ValMon.Caption, IntBase.Text, Format(Dtefecven.Text, "dd/mm/yyyy"), Format(gsBac_Fecp, "dd/mm/yyyy"), "1")
    End If

End Sub

Private Sub FltTasa_GotFocus()

   FltTasa.Tag = FltTasa.Text

End Sub

Private Sub FltTasa_KeyPress(KeyAscii As Integer)

'   If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
'      KeyAscii = Asc(gsBac_PtoDec)
'   End If

   If KeyAscii = 13 Then
      KeyAscii = 0
      Call Me.Intdias.SetFocus
   End If

End Sub

Private Sub FltTasa_LostFocus()
'    If Not Validar_Tasa("IB", CmbMoneda.ItemData(CmbMoneda.ListIndex), CDbl(FltTasa.Text)) Then
'               FltTasa.Text = 0#
'               FltTasa.SetFocus
'              Exit Sub
'    End If
    
    If CDbl(FltTasa.Tag) <> CDbl(FltTasa.Text) Then
        Call CalcInterTICKET(FltMtoini.Text, Lbl_Mt_Final.Caption, FltTasa.Text, Lbl_ValMon.Caption, IntBase.Text, Format(Dtefecven.Text, "dd/mm/yyyy"), Format(gsBac_Fecp, "dd/mm/yyyy"), " 1")
    End If

End Sub
Private Sub Intdias_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
    
        Let KeyAscii = 0
    
        If Val(Intdias.Text) > 0 Then '--> ingreso Plazo
        
            Let Me.Frm_Final.Enabled = True
            Let Me.CmbCarteraDestino.Enabled = True
            Call Me.CmbCarteraDestino.SetFocus
                
        End If
        
    End If
    
End Sub
Private Sub Intdias_LostFocus()
Dim dFecha
    dFecha = gsBac_Fecp
   
   Dim sfec             As String

   If Intdias.Tag <> Intdias.Text Then
      If Intdias.Text <> 0 Then
         sfec = Format(DateAdd("d", Intdias.Text, dFecha), "dd/mm/yyyy")

         If BacEsHabil(sfec) Then
            Dtefecven.Text = sfec
            Dtefecven.Tag = sfec
           ' Call Bac_SendKey(vbKeyTab)
            Call CalcInterTICKET(FltMtoini.Text, Lbl_Mt_Final.Caption, FltTasa.Text, Lbl_ValMon.Caption, IntBase.Text, Format(Dtefecven.Text, "dd/mm/yyyy"), Format(gsBac_Fecp, "dd/mm/yyyy"), " 1")

         Else
            MsgBox "Fecha de Vcto. no es día Hábil", 16
            Intdias.Text = Intdias.Tag
            Intdias.SetFocus
            Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, dFecha), "dd/mm/yyyy")

         End If

      Else
         MsgBox "Fecha de Vcto. Ingresada igual a la de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
         Intdias.Text = Intdias.Tag
         Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, dFecha), "dd/mm/yyyy")

      End If

   End If

End Sub


Private Sub subLimpiaPACTOS()
Dim nSw%
Dim nCont%

   

  ' Pnl_FecProceso.Caption = Format(gsBac_Fecp, "dd/mm/yyyy")
  ' Label1.Caption = Mid$(BacDiaSem(Pnl_FecProceso.Caption), 1, 3)

   nSw = 0
   nCont = 1

   Do While nSw = 0
      Intdias.Text = nCont
      Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, gsBac_Fecp), "dd/mm/yyyy")

      If EsFeriado(CDate(Dtefecven.Text), "00001") Then
         nCont = nCont + 1
      Else
         nSw = 1

      End If

   Loop

   FltMtoini.Text = 0
   FltTasa.Text = 0
   Lbl_ValMon.Caption = Format(0, "#,##0.0000")
   Lbl_Mt_Inicial.Caption = Format(0, "#,##0.0000")
   Lbl_Mt_Final.Caption = Format(0, "#,##0.0000")

   CmbMoneda.ListIndex = -1

   If CmbMoneda.ListCount > 1 Then
      CmbMoneda.ListIndex = 0

   End If

End Sub


Private Function funcVALIDA_FECHA() As Boolean

Dim dFecha

    dFecha = gsBac_Fecp
    
    If Dtefecven.Text <> gsBac_Fecp Then
        If BacEsHabil(Dtefecven.Text) Then
            Intdias.Text = DateDiff("d", dFecha, Dtefecven.Text)
            Intdias.Tag = DateDiff("d", dFecha, Dtefecven.Text)
            Call Bac_SendKey(vbKeyTab)
            Call CalcInterTICKET(FltMtoini.Text, Lbl_Mt_Final.Caption, FltTasa.Text, Lbl_ValMon.Caption, IntBase.Text, Format(Dtefecven.Text, "dd/mm/yyyy"), Format(dFecha, "dd/mm/yyyy"), " 1")
            funcVALIDA_FECHA = True
        Else
            MsgBox "Fecha de Vcto. no es día Hábil", 16
            Intdias.Text = Intdias.Tag
            Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, dFecha), "dd/mm/yyyy")
            funcVALIDA_FECHA = False
        End If
    
    Else
        MsgBox "Fecha de Vcto. Ingresada igual a la de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
        Intdias.Text = Intdias.Tag
        Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, dFecha), "dd/mm/yyyy")
        funcVALIDA_FECHA = False
    End If
    
    If Format(Dtefecven.Text, "yyyymmdd") <= Format(dFecha, "yyyymmdd") Then
        MsgBox "Fecha de Vcto. debe ser Mayor a Fecha de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
        Intdias.Text = Intdias.Tag
        Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, dFecha), "dd/mm/yyyy")
        funcVALIDA_FECHA = False
    End If
  
End Function


Private Sub CalcInterTICKET(nNominal As String, nMtofin As String, nTasa As String, nValmon As String, nBase As String, dFecven As String, dfecpro As String, nmodal As String)

    If Lbl_ValMon.Caption > 0 Then
       Lbl_Mt_Inicial.Caption = Format(FltMtoini.Text / Lbl_ValMon.Caption, Formato_Monto)
    Else
       Lbl_Mt_Inicial.Caption = Format(0#, Formato_Monto)
    End If

    If nMtofin = "" Then nMtofin = "0"
    
    If CDbl(nTasa) = 0 Then Exit Sub
   
    Envia = Array(CDbl(nNominal), _
            CDbl(nMtofin), _
            CDbl(nTasa), _
            CDbl(nValmon), _
            CDbl(nBase), _
            Format(dFecven, "yyyymmdd"), _
            Format(dfecpro, "yyyymmdd"), _
            CDbl(nmodal), _
            Trim$(CmbMoneda.Text))

    If Not Bac_Sql_Execute("SP_CALCULOINTERBANCARIO", Envia) Then
        MsgBox "Falla en Calculos de Interbancario", 16
        Exit Sub
    End If

    Do While Bac_SQL_Fetch(Datos())
    
        FltMtoini.Text = BacCtrlTransMonto(Datos(1))
        FltTasa.Text = BacCtrlTransMonto(Datos(2))
        
        Lbl_Mt_Final.Caption = Format(CDbl(Datos(3)), Formato_Monto)
        
        FltMtoini.Tag = BacCtrlTransMonto(Datos(1))
        FltTasa.Tag = BacCtrlTransMonto(Datos(2))
        Lbl_Mt_Final.Tag = BacCtrlTransMonto(Datos(3))
   Loop

End Sub




Private Sub Text2_GotFocus()

   Call PROC_POSI_TEXTO(Table1, TEXT2)
      
   If Table1.Col = nCol_VPS Or Table1.Col = nCol_VPTRAN Then
        TEXT2.SelStart = Len(TEXT2.Text) - (TEXT2.CantidadDecimales - 1)
   Else
        If Mid(Table1.TextMatrix(Table1.Row, nCol_SERIE), 1, 6) = "FMUTUO" Then
          If Table1.TextMatrix(Table1.Row, nCol_UM) = "CLP" Then
              If Table1.Col = nCol_VPAR Then
                 TEXT2.SelStart = Len(TEXT2.Text) - 5
              Else
                 TEXT2.SelStart = Len(TEXT2.Text)
              End If
          Else
              TEXT2.SelStart = Len(TEXT2.Text) - 5
          End If
        Else
            If bFlagDpx Then
              TEXT2.SelStart = Len(TEXT2.Text) - 3
            Else
              TEXT2.SelStart = Len(TEXT2.Text) - 5
            End If
          End If
   End If

End Sub

Private Sub Text1_KeyDown(KeyCode As Integer, Shift As Integer)
Dim Cota_SUP         As Double
Dim Cota_INF         As Double
Dim Porcentaje       As Double
Dim Nominal          As Double
Dim Col              As Integer
Dim Value            As String
Dim CorteMin#
Dim iOK%
Dim Columna%
Dim LeeEmi$
Dim nFilaValida      As Integer
Dim cFormato         As String
   
On Error GoTo ExitEditError
   
   
    If KeyCode = vbKeyEscape Then
       Let Text1.Text = ""
       Let Text1.Visible = False
    End If
   
    Let Antes_Flag = True
    Let tipo = "CP"
    
    If Table1.Col = nCol_NOMINAL Then
        Let bufNominal = Table1.TextMatrix(Table1.Row, nCol_VPAR)
    End If
    
    If KeyCode = vbKeyReturn Then
        If Table1.Col = nCol_SERIE Then
            
            If Not Validar_SerieFM(Text1.Text) Then
                Call MsgBox("Serie ingresada no corresponde")
                Exit Sub
            End If
            
            If Not bFlagDpx Then
                Let Table1.ColWidth(3) = 900
                
                If Text1.Text = "FMUTUO" Then
                
                    Let Table1.ColWidth(3) = 1800
                   
                ElseIf Mid$(Text1.Text, 1, 3) = "DPX" Then
                
                    Call MsgBox("PAPEL NO VALIDO", vbExclamation, Me.Caption)
                    Call Text1.SetFocus
                    Exit Sub
                    
                End If
            Else
                If Mid$(Text1.Text, 1, 3) <> "DPX" Then
                
                    Call MsgBox("PAPEL NO VALIDO", vbExclamation, Me.Caption)
                    Call Text1.SetFocus
                    Exit Sub
                    
                End If
            End If
            
        End If

        If Not Data1.Recordset.RecordCount = 1 Then
            Call Colocardata1
        Else
            Data1.Recordset.MoveFirst
        End If

        If Table1.Col <> nCol_CDCV And Table1.Col <> nCol_SERIE Then
            Let Value = CDec(TEXT2.Text)
        End If

        Let Col% = Table1.Col

        If (Col% > nCol_UM And Col% < nCol_CUST) Or (Col% > nCol_CDCV And Col% < nCol_UTIL) Then
        
            If IsNumeric(Value) = False Then
            
                Let iFlagKeyDown = False
                Let Text1.Visible = False
                
                If Table1.Enabled = True Then
                    Call Table1.SetFocus
                End If
                
                Exit Sub
                
            End If
        End If

        Select Case Col%
      
            Case nCol_SERIE:
            
                Let Value = Text1.Text
                Let iOK = TICKETCP_ChkSerie(Value, Data1)
                
                If iOK = False Then
                    Exit Sub
                    Let iFlagKeyDown = False
                Else
                
                    Data1.Recordset.Edit
                    Data1.Recordset!TM_INSTSER = Text1.Text
                    Data1.Recordset!tm_custodia = "DCV"
                    Data1.Recordset!tm_carterasuper = 0
                    Table1.TextMatrix(Table1.Row, nCol_CUST) = "DCV"
                    Data1.Recordset.Update
               
                    Call subLIMPIA_Grilla
               
                    Let Columna = Table1.Col
                    Call Data1.Recordset.Edit
                    Let LeeEmi$ = Data1.Recordset("tm_leeemi")
                    Let SwEmision = True
               
                    If InStr("S", LeeEmi$) Then
                        Let SwEmision = False
                        Call Func_Emision
                    End If
               
                    Let Text1.Text = Value
                    Call subLIMPIA_Grilla
               
                End If

Serie:
                Table1.Col = Col%
                Table1.TextMatrix(Table1.Row, Table1.Col) = Trim(Text1.Text)

            Case nCol_NOMINAL:
        
                If CDbl(Value) < 0 Or Len(Value) > 22 Then
                    Call MsgBox("Nominal ingresado NO es valido.", 16, gsBac_Version)
                    Let Value = 0
                    Exit Sub
                End If
            
                Call Data1.Recordset.Edit
                Let CorteMin# = Data1.Recordset("tm_cortemin")
            
                If Not IsNumeric(Value) Then
                    Let Value = 0
                End If
            
                Let Nominal# = CDbl(Value)
            
                If CO_ChkCortes((Nominal#), CorteMin#) = False Then
                    
                    Let TEXT2.Text = CorteMin#
                    
                    If Table1.Enabled = True Then
                        Call Table1.SetFocus
                    End If
                    
                End If

                Let Table1.TextMatrix(Table1.Row, Table1.Col) = Format(TEXT2.Text, "#,##0." & String(gsMONEDA_Decimales, "0"))
                Let Data1.Recordset("tm_nominal") = TEXT2.Text
            
                If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
                
                    Let Data1.Recordset!TM_MT = Data1.Recordset!TM_TIR * CDbl(TEXT2.Text)
                    Call Data1.Recordset.Update
                    
                Else
                    Call Data1.Recordset.Update
                
                    If Val(Table1.TextMatrix(Table1.Row, nCol_TIR)) <> 0 Then
                        Call CPCI_Valorizar(2, Data1, FechaPago.Text)
                    ElseIf Val(Table1.TextMatrix(Table1.Row, nCol_VPAR)) <> 0 Then
                        Call CPCI_Valorizar(1, Data1, FechaPago.Text)
                    ElseIf Val(Table1.TextMatrix(Table1.Row, nCol_VPS)) <> 0 Then
                        Call CPCI_Valorizar(3, Data1, FechaPago.Text)
                    End If
                
                    If BacFormatoSQL(bufNominal) <> BacFormatoSQL(Table1.TextMatrix(Table1.Row, nCol_NOMINAL)) Then 'Si cambia el nominal Elimino los cortes y valorizo a mercado
                        Call CO_EliminarCortesMDB(FormHandle, 1)
                    End If
                End If

            
            Case nCol_TIR:
                
                Call Data1.Recordset.Edit
                
                If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
                
                    Let Data1.Recordset!TM_TIR = CDbl(TEXT2.Text)
                    
                    If CDbl(TEXT2.Text) <> 0 Then
                        Let Data1.Recordset!tm_nominal = Data1.Recordset!TM_MT / CDbl(TEXT2.Text)
                    End If
                    
                    Call Data1.Recordset.Update
                    
                Else
                
                    Let Data1.Recordset!TM_TIR = TEXT2.Text
                    Call Data1.Recordset.Update
                    
                    Call CPCI_Valorizar(2, Data1, FechaPago.Text)
                End If
            
                '-->  Copia los valores a las columnas de Precio. Trasnferencia
                Data1.Recordset.Edit
                Data1.Recordset!tm_pvpmcd = Data1.Recordset("tm_pvp")
                Data1.Recordset!tm_tirmcd = Data1.Recordset("tm_tir")
                Data1.Recordset!tm_mtmcd = Data1.Recordset("tm_mt")
                Data1.Recordset!tm_VPTRANMO = Data1.Recordset("tm_VPMo")
                Data1.Recordset.Update
                '-->  Copia los valores a las columnas de Precio. Trasnferencia
            
            Case nCol_VPAR
            
                Call Data1.Recordset.Edit
                
                If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
                    Let Data1.Recordset!TM_Pvp = 0
                    Call Data1.Recordset.Update
                Else
                    Let Data1.Recordset!TM_Pvp = TEXT2.Text
                    Call Data1.Recordset.Update
                    Call CPCI_Valorizar(1, Data1, FechaPago.Text)
                    
                    If Not Antes_Flag Then
                        Table1.TextMatrix(Table1.Row, Table1.Col) = Antes
                        Data1.Recordset.Edit
                        Data1.Recordset!TM_Pvp = Antes
                        Data1.Recordset.Update
                    End If
                End If
                
                '-->  Copia los valores a las columnas de Precio. Trasnferencia
                Data1.Recordset.Edit
                Data1.Recordset!tm_pvpmcd = Data1.Recordset("tm_pvp")
                Data1.Recordset!tm_tirmcd = Data1.Recordset("tm_tir")
                Data1.Recordset!tm_mtmcd = Data1.Recordset("tm_mt")
                Data1.Recordset!tm_VPTRANMO = Data1.Recordset("tm_VPMo")
                Data1.Recordset.Update
                '-->  Copia los valores a las columnas de Precio. Trasnferencia
        
            
            Case nCol_VPS:
            
                If CDbl(Value) < 0 Or Len(Value) > 16 Then
                
                    Call MsgBox("Valor presente ingresado NO es valido.", 16, gsBac_Version)
                    Let Value = 0
                    
                    If Table1.Enabled = True Then
                        Call Table1.SetFocus
                    End If
                    
                    Exit Sub
                    
                End If
                
                Call Data1.Recordset.Edit
            
                If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
                
                    Let Data1.Recordset!TM_MT = CDbl(TEXT2.Text)
                    
                    If Data1.Recordset!TM_TIR <> 0 Then
                        Let Data1.Recordset!tm_nominal = CDbl(TEXT2.Text) / Data1.Recordset!TM_TIR
                    End If
                    
                    Call Data1.Recordset.Update
                Else
                    
                    Let Data1.Recordset!TM_MT = TEXT2.Text
                    Call Data1.Recordset.Update
                    
                    Call CPCI_Valorizar(3, Data1, FechaPago.Text)
                
                    If Not Antes_Flag Then
                    
                        Let Table1.TextMatrix(Table1.Row, Table1.Col) = Antes
                        Call Data1.Recordset.Edit
                        Let Data1.Recordset!TM_MT = Antes
                        Call Data1.Recordset.Update
                        
                    End If
                    
                End If
            
                '-->  Copia los valores a las columnas de Precio. Trasnferencia
                Data1.Recordset.Edit
                Data1.Recordset!tm_pvpmcd = Data1.Recordset("tm_pvp")
                Data1.Recordset!tm_tirmcd = Data1.Recordset("tm_tir")
                Data1.Recordset!tm_mtmcd = Data1.Recordset("tm_mt")
                Data1.Recordset!tm_VPTRANMO = Data1.Recordset("tm_VPMo")
                Data1.Recordset.Update
                '-->  Copia los valores a las columnas de Precio. Trasnferencia
            
        End Select
      
        If Table1.Col <> nCol_SERIE And Table1.Col <> nCol_CDCV Then
        
            If Mid(Trim(Data1.Recordset!TM_INSTSER), 1, 6) = "FMUTUO" Then
                Let cFormato = "#,##0." & String(4, "0")
                Let Table1.TextMatrix(Table1.Row, Table1.Col) = Format(TEXT2.Text, cFormato)
            Else
                Let cFormato = "#,##0." & String(gsMONEDA_Decimales, "0")
                Let Table1.TextMatrix(Table1.Row, Table1.Col) = Format(TEXT2.Text, cFormato)
            End If
            
        End If
      
        Let Columna = Table1.Col
        Call BacControlWindows(20)
      
        If Columna > nCol_UM And Columna < nCol_CUST Then
            Call ChkMoneda(Columna%)
            Call BacControlWindows(12)
            Let TxtTotal.Text = BacCtrlTransMonto(TICKETCP_SumarTotal(FormHandle))
        End If

        Let iFlagKeyDown = True

        If Columna = nCol_SERIE Then
        
            Let Table1.Col = Columna + 2
            
        ElseIf Columna = nCol_NOMINAL Then
        
            If Mid(Table1.TextMatrix(Table1.Row, nCol_SERIE), 1, 6) = "FMUTUO" Then
                Let Table1.Col = Columna + 2
            Else
               Let Table1.Col = Columna + 1
            End If

        ElseIf Columna = nCol_TIR Or Columna = nCol_VPAR Or Columna = nCol_VPS Then
        
            Let Table1.Col = nCol_VPS
            
        End If

        If Len(Data1.Recordset("tm_instser")) <> 0 And Toolbar1.Buttons(3).Enabled = False Then
            Let Toolbar1.Buttons(3).Enabled = True
        End If
        
        If Data1.Recordset("tm_nominal") <> 0 And Toolbar1.Buttons(4).Enabled = False Then
            Let Toolbar1.Buttons(4).Enabled = True
        End If
        
        If Data1.Recordset("tm_mt") <> 0 Then
            Let TxtTotal.Enabled = True
            Let Toolbar1.Buttons(2).Enabled = True
        Else
            Let TxtTotal.Enabled = False
            Let Toolbar1.Buttons(2).Enabled = False
        End If

        Let Text1.Text = ""
        Let Text1.Visible = False
        Let TEXT2.Text = 0
        Let TEXT2.Visible = False

        If Table1.Col <> nCol_NOMINAL Then
             Call Llena_GrillaTICKET
             
            If Table1.Col = nCol_TTRAN Or Table1.Col = nCol_PTRAN Or Table1.Col = nCol_VPTRAN Then
            End If
        Else
            Let Table1.TextMatrix(Table1.Row, nCol_UM) = Data1.Recordset!TM_NEMMON
            Call subLIMPIA_Grilla
        End If
        
    End If

    On Error GoTo 0

    Exit Sub

ExitEditError:

    On Error GoTo 0
    Let iFlagKeyDown = True
    Let Table1.Row = Table1.Rows - 1
    Let Table1.TextMatrix(Table1.Row, nCol_TIR) = Format(Monto, "###,###,###,##0.0000")
    Let Text1.Visible = False
    
End Sub




Private Sub Text1_GotFocus()

   Call PROC_POSI_TEXTO(Table1, Text1)
   Text1.SelStart = Len(Text1)

End Sub
Private Sub Func_Emision()

   Dim bufFecVen$
   
   If Trim$(Data1.Recordset("tm_instser")) = "FMUTUO" Then
      Exit Sub
   End If

   If Mid(Text1.Text, 1, 6) = "FMUTUO" Then
'       Call Data1.Recordset.MoveFirst
       If Not Table1.Rows - 1 = 1 Then
           Call Colocardata1
       Else
           Call Data1.Recordset.MoveFirst
       End If
   Else
        If Not Table1.Rows - 1 = 1 Then
           Call Colocardata1
        Else
           Call Data1.Recordset.MoveFirst
        End If
   End If

   If Trim$(Data1.Recordset("tm_instser")) = "" Then
      Exit Sub
   End If

   'Guarda datos en variable global
   Let BacDatEmi.sInstSer = Data1.Recordset("tm_instser")
   Let BacDatEmi.lRutemi = Data1.Recordset("tm_rutemi")
   Let BacDatEmi.lCodemi = Data1.Recordset("tm_codemi")
   Let BacDatEmi.iMonemi = Data1.Recordset("tm_monemi")
   Let BacDatEmi.sFecEmi = Data1.Recordset("tm_fecemi")
   Let BacDatEmi.sFecvct = Data1.Recordset("tm_fecven")
   Let BacDatEmi.dTasEmi = Data1.Recordset("tm_tasemi")
   Let BacDatEmi.iBasemi = Data1.Recordset("tm_basemi")
   Let BacDatEmi.sRefNomi = Data1.Recordset("tm_refnomi")
   Let BacDatEmi.sGeneri = Data1.Recordset("tm_genemi")

   Let bufFecVen = BacDatEmi.sFecvct

   If Tipo_Carga = "MN" Or (Tipo_Carga = "AU" And Mid(Trim(BacDatEmi.sInstSer), 1, 2) = "DP") Then
       Let BacIrfEm.varPsSeriado = Data1.Recordset("tm_mdse")
       Let BacIrfEm.Tag = "CP"
       If Mid(Table1.TextMatrix(Table1.Row, nCol_SERIE), 1, 6) = "FMUTUO" Or Mid(Text1.Text, 1, 6) = "FMUTUO" Then
           
           Let BacIrfEm.Tag = "CP;FMUTUO"
           'Let BacDatEmi.lRutemi = 0
       End If
       Call BacIrfEm.Show(vbModal)
   End If

   If giAceptar% = True Then
      Call Data1.Recordset.Edit
       Let Data1.Recordset("tm_instser") = BacDatEmi.sInstSer
       Let Data1.Recordset("tm_rutemi") = BacDatEmi.lRutemi
       Let Data1.Recordset("tm_codemi") = BacDatEmi.lCodemi
       Let Data1.Recordset("tm_monemi") = BacDatEmi.iMonemi
       Let Data1.Recordset("tm_nemmon") = BacDatEmi.sNemo
       Let Data1.Recordset("tm_fecemi") = BacDatEmi.sFecEmi
       Let Data1.Recordset("tm_fecven") = BacDatEmi.sFecvct
       Let Data1.Recordset("tm_tasemi") = BacDatEmi.dTasEmi
       Let Data1.Recordset("tm_basemi") = BacDatEmi.iBasemi
       Let Data1.Recordset("tm_genemi") = BacDatEmi.sGeneri
      If bufFecVen <> BacDatEmi.sFecvct Then
          Let Data1.Recordset("tm_valmcd") = "N"
      End If
      Call Data1.Recordset.Update
   End If

   Call BacControlWindows(12)
   If Table1.Enabled = True Then
      Call Table1.SetFocus
   End If

End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)

    Let KeyAscii = Asc(UCase(Chr(KeyAscii)))
    
    Let SwEmision = True

End Sub

Private Sub Text1_LostFocus()

    Let Text1.Text = ""
    Let Text1.Visible = False
    
    If SwEmision Then
    
        If Table1.Enabled = True Then
            Call Table1.SetFocus
        End If
        
    End If

End Sub

Private Sub Text2_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyEscape Then
      TEXT2.Text = ""
      TEXT2.Visible = False

   End If

   If KeyCode = vbKeyReturn Then
       Antes = Table1.TextMatrix(Table1.RowSel, Table1.ColSel)
      Table1.TextMatrix(Table1.RowSel, Table1.ColSel) = CDec(TEXT2.Text)
      
      TEXT2.Visible = False
      
      Call Text2_LostFocus
      Call Text1_KeyDown(13, 1)

   End If

End Sub

Private Sub Text2_LostFocus()
   On Error Resume Next
   
   TEXT2.Visible = False
   If Table1.Enabled = True Then: Table1.SetFocus

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Key
        Case Is = "CmdLimpiar":     Call subLIMPIAR
            
        Case Is = "CmdGrabar":      Call subGrabar
          
        Case Is = "CmdFiltrar": Call TOOLFILTRAR
        
        Case Is = "cmdSalir":       Unload Me
    End Select
    
End Sub


' ----------------------------------------------------------------------------------
' Procedimiento :   subGrabar
' Objetivo      :   Realizar el proceso de grabación de las transacciones intramesa
' ==================================================================================
Private Sub subGrabar()
' ----------------------------------------------------------------------------------
Dim sTipOper        As String
Dim dNumoper        As Long
Dim dNumRela        As Long

On Error GoTo errGrabacion

 ' VB+- 21/06/2010 Se agrega validacion
    If Me.cmbTipoPago <> "HOY" Then
        If FUNC_Valida_Papeles_PM_ICP Then
            MsgBox "No se puede realizar operacion PM con papeles en ICP", vbExclamation, TITSISTEMA
            If Table1.Enabled = True Then: Table1.SetFocus
            Exit Sub
        End If
    End If

    If MsgBox("¿Está seguro de grabar operación de Ticket Intramesa?", vbYesNo + vbDefaultButton2 + vbQuestion, "Grabación") = vbYes Then
    
        Let sTipOper = Me.Tag
        
        If Not funcVALIDAR(sTipOper) Then
            Exit Sub
        End If
        
        
        If Not BacBeginTransaction() Then   '-> comienza proceso transaccional, para la grabación
            Exit Sub
        End If
        
        
        Let dNumoper = funcNUMEROTICKET()   '->Obtengo el numero de operación
        
        Let dNumRela = funcNUMEROTICKET()   '->Obtengo el numero de la Operacion Relacionada
        
        
        Select Case sTipOper
        
            Case "VI", "CI" ' VENTAS CON PACTO, COMPRAS CON PACTO
            
                Call subGRABA_Pactos(dNumoper, sTipOper, dNumRela)
                
            Case "CP" 'COMPRA DEFINITIVA
                
                Call TICKETCP_GrabarTx(dNumoper, sTipOper, dNumRela, Frm_TicketIntramesa)
        
            Case "VP" 'VENTA DEFINITIVA
                
                Call TICKETVENTA_GrabarTx(dNumoper, sTipOper, dNumRela, Frm_TicketIntramesa, FormHandle)
        
        End Select
        
        
        
        If Not BacCommitTransaction() Then '-> Finaliza proceso transaccional
            Exit Sub
        End If
        MsgBox "Operacion: " & dNumoper & " ha sido grabada satisfactoriamente", vbInformation, "Grabacion"
        
    End If
    Call subLIMPIAR
    Exit Sub
    
ErrRollBack:
    Call BacRollBackTransaction
    Exit Sub
    
errGrabacion:
    GoTo ErrRollBack
    Call MsgBox("Problemas en la grabación de operaciones Ticket Intramesa", vbExclamation, "Ticket Intramesa")
    Exit Sub

End Sub






Private Sub Table1_Scroll()

    Let Me.Text1.Visible = False
    Let Me.TEXT2.Visible = False
    
End Sub



Private Sub Table1_SelChange()
    
    Let Me.Table1.CellBackColor = &H808000
    Let Me.Text1.Font.bold = True

End Sub








Private Sub desbloquear()

    Data2.RecordSource = "SELECT * FROM ticket_venta WHERE tm_venta = " & "'V'" & " OR tm_venta = " & " 'P'"
    Data2.Refresh
    
    Do While Not Data2.Recordset.EOF
    
        Call TICKETVENTA_DesBloquear(FormHandle, Data2)
        Data2.Recordset.MoveNext
        
    Loop

End Sub


Private Sub subREFRESCA()
Dim I As Integer

    Data2.Refresh
    
    For I = 1 To table2.Rows - 1
    
        table2.Row = I
        Call VP_llenar_Grilla
    
        If Not Data2.Recordset.EOF Then
            Data2.Recordset.MoveNext
        End If
        
    Next I
    
    table2.Refresh
    
End Sub


Private Function VP_colores()
Dim Fila    As Integer
Dim z       As Integer

    table2.Redraw = False
     
    For Fila = 1 To table2.Rows - 1
 
        If table2.TextMatrix(Fila, 0) = "*" Then
    
            Color = &HC0C0C0: colorletra = &HC0&:    bold = False

        End If
    
        If table2.TextMatrix(Fila, 0) = "V" Then

            Color = &HFF0000: colorletra = &HFFFFFF: bold = True

        End If
    
        If table2.TextMatrix(Fila, 0) = "P" Then

            Color = vbCyan:   colorletra = vbBlack:   bold = False

        End If

        If table2.TextMatrix(Fila, 0) = "B" Then
                Color = vbBlack + vbWhite:   colorletra = vbBlack:   bold = False
        End If
    
        If table2.TextMatrix(Fila, 0) = " " Then
            Color = &HC0C0C0: colorletra = &H800000: bold = False
        End If
    
    
        table2.Row = Fila
      
        For z = 2 To table2.cols - 1
            table2.Col = z
            table2.CellBackColor = Color
            table2.CellForeColor = colorletra
            table2.CellFontBold = bold
        Next z
  
    Next Fila
   
    table2.Redraw = True
    table2.Col = nColMoneda

End Function

Public Function Colocardata2()
Dim iContador As Integer
   
    If table2.Rows = 1 Then
        Exit Function
    End If
    
    If table2.TextMatrix(1, nColEstado) = "" Then
        Exit Function
    End If
    
    Let Monto = CDbl(table2.TextMatrix(table2.Row, nColNominal))
    Call Data2.Recordset.MoveFirst
    
    For iContador = 1 To table2.Row - 1
        Call Data2.Recordset.MoveNext
    Next iContador
   
End Function


Private Sub VP_llenar_Grilla()
Dim x            As Integer
Dim nContador    As Integer
Dim nTipoCambio  As Double
Dim oDatos()
   
   
    If Data2.Recordset.RecordCount > 0 Then
        Call Data2.Recordset.MoveFirst
    End If
  
    Let table2.Redraw = False
    Let table2.Rows = 1
   
    Do While Not Data2.Recordset.EOF
        x = table2.Rows
        table2.Rows = table2.Rows + 1
      
        With table2
        
            .TextMatrix(x, nColEstado) = Data2.Recordset!tm_venta
            .TextMatrix(x, nColSerie) = Data2.Recordset!TM_INSTSER
            
             If Trim(Data2.Recordset!TM_INSTSER) = "FMUTUO" Then
               .ColWidth(4) = 1800
             End If
             
            .TextMatrix(x, nColMoneda) = Data2.Recordset!TM_NEMMON
            .TextMatrix(x, nColNominal) = Format(Data2.Recordset!tm_nominal, "#,##0.0000")
            .TextMatrix(x, nColTir) = Format(Data2.Recordset!TM_TIR, "#,##0.0000")
            .TextMatrix(x, nColVPar) = Format(Data2.Recordset!TM_Pvp, "#,##0.0000")
            .TextMatrix(x, nColValorPresente) = Format(Data2.Recordset!TM_VP, "#,##0.0000")
            .TextMatrix(x, nColCustodia) = IIf(IsNull(Data2.Recordset!tm_custodia) = True, " ", Data2.Recordset!tm_custodia)
            .TextMatrix(x, nColClaveDCV) = IIf(IsNull(Data2.Recordset!tm_clave_dcv) = True, " ", Data2.Recordset!tm_clave_dcv)
            .TextMatrix(x, nColTirCompra) = Format(Data2.Recordset!TM_tircomp, "#,##0.0000")
            .TextMatrix(x, nColVParCompra) = Format(Data2.Recordset!TM_pvpcomp, "#,##0.0000")
            .TextMatrix(x, nColValorCompra) = Format(Data2.Recordset!tm_vptirc, "#,##0.0000")
            .TextMatrix(x, nColUtilidad) = Format(CDbl(Data2.Recordset!TM_VP) - CDbl(Data2.Recordset!tm_vptirc), "#,##0")
            .TextMatrix(x, nColDurationMac) = Format(Data2.Recordset!tm_durmacori, FDecimal)
            .TextMatrix(x, nColDurationMod) = Format(Data2.Recordset!tm_durmodori, FDecimal)
            .TextMatrix(x, nColConvex) = Format(Data2.Recordset!tm_convex, FDecimal)
            .TextMatrix(x, nColLibro) = IIf(IsNull(Data2.Recordset!tm_id_libro) = True, "", Trim(Data2.Recordset!tm_id_libro))
            .TextMatrix(x, nColValuta) = Data2.Recordset!tm_modpago
            
            If Trim(.TextMatrix(x, nColEstado)) <> "" Then
               For nContador = 0 To table2.cols - 1
                  table2.Col = nContador
                  .Row = x
                  Call table2_LeaveCell
                  Call table2_RowColChange
               Next nContador
            End If
         
        End With
        
        Data2.Recordset.MoveNext
    Loop
   
   table2.Col = nColMoneda
   table2.Redraw = True
End Sub


Private Sub data2_Error(DataErr As Integer, Response As Integer)

    If DataErr = 3021 Then
        DataErr = 0
        Response = 0
    End If
    
End Sub

Sub VP_Nombre_Grilla()
    table2.TextMatrix(0, nColEstado) = "M"
    table2.TextMatrix(0, nColSerie) = "Serie"
    table2.TextMatrix(0, nColMoneda) = "UM"
    table2.TextMatrix(0, nColNominal) = "Nominal"
    table2.TextMatrix(0, nColTir) = "%Tir"
    table2.TextMatrix(0, nColVPar) = "%Vpar"
    table2.TextMatrix(0, nColValorPresente) = "Valor Presente"
    
        
    table2.ColWidth(nColEstado) = 400
    table2.ColWidth(nColSerie) = 1500
    table2.ColWidth(nColMoneda) = 500
    table2.ColWidth(nColNominal) = 1800
    table2.ColWidth(nColTir) = 900
    table2.ColWidth(nColVPar) = 900
    table2.ColWidth(nColValorPresente) = 2800

  ' Seteo de columnas no visibles
  ' -------------------------------------------------------------------------------------------------------------
    table2.ColWidth(nColCustodia) = 0:          table2.ColWidth(nColClaveDCV) = 0
    table2.ColWidth(nColTirCompra) = 0:         table2.ColWidth(nColVParCompra) = 0
    table2.ColWidth(nColValorCompra) = 0:       table2.ColWidth(nColUtilidad) = 0
    table2.ColWidth(nColTTran) = 0:         table2.ColWidth(nColVTran) = 0
    table2.ColWidth(nColVPTran) = 0:        table2.ColWidth(nColDifTran) = 0
    table2.ColWidth(nColDif_CLP) = 0:           table2.ColWidth(nColCarteraSuper) = 0
    table2.ColWidth(nColDurationMac) = 0:       table2.ColWidth(nColDurationMod) = 0
    table2.ColWidth(nColConvex) = 0:            table2.ColWidth(nColLibro) = 0
    table2.ColWidth(nColValuta) = 0
  ' -------------------------------------------------------------------------------------------------------------

End Sub




Private Sub table2_DblClick()
   
    If table2.Col = nColCustodia And (table2.TextMatrix(table2.Row, nColEstado) = "V" Or table2.TextMatrix(table2.Row, nColEstado) = "P") Then
        Let Combo1.Visible = True
        Call Combo1.SetFocus
    End If
End Sub


Private Sub table2_EnterCell()

    If table2.TextMatrix(table2.Row, nColValuta) = "M" Then
        Let table2.ForeColorSel = vbRed
    Else
        Let table2.BackColorSel = vbHighlight
        Let table2.ForeColorSel = vbHighlightText
    End If
    
End Sub

Private Sub table2_KeyDown(KeyCode As Integer, Shift As Integer)

    Let columnita = table2.Col
     
    If KeyCode = vbKeyReturn And KeyCode <> vbKeyV _
                 And KeyCode <> vbKeyR _
                 And KeyCode <> vbKeyF7 _
                 And KeyCode <> vbKeyF3 _
                 And ((table2.Col > nColMoneda _
                 And table2.Col < nColCustodia) Or (table2.Col >= nColTTran And table2.Col <= nColVPTran)) Then  ' 86 = v / 82 = r / 118 = F7 / 114 = F3
      
        Call BacControlWindows(100)
      
        Let table2.Col = columnita
        Let TEXT1vp.Top = table2.CellTop + table2.Top + 20
        Let TEXT1vp.Left = table2.CellLeft + table2.Left + 20
        Let TEXT1vp.Height = table2.CellHeight
        Let TEXT1vp.Width = table2.CellWidth - 20
        
        Let TEXT1vp.Enabled = True
        Let TEXT1vp.Visible = True
       'Let table2.Enabled = False
        
        
        If KeyCode > vbKey0 And KeyCode <= vbKey9 Then
           Let TEXT1vp.Text = Chr(KeyCode)
        End If
        
        If KeyCode = vbKeyReturn Then
           Let TEXT1vp.Text = CDbl(table2.TextMatrix(table2.Row, table2.Col))
        End If
        
        Call TEXT1vp.SetFocus
        Exit Sub
      
    End If

    On Error GoTo KeyDownError
    
    If iFlagKeyDown = False Then
        Exit Sub
    End If
            
    Exit Sub
    
KeyDownError:
    Call MsgBox(error(err), vbExclamation, "Mensaje")
    Call Data2.Refresh
    Exit Sub

End Sub




Private Sub table2_KeyPress(KeyAscii As Integer)
Dim reg             As Double
Dim fila_table      As Double

Dim I               As Integer
Dim Fila            As Integer
Dim nRowTop         As Integer
Dim nContador       As Integer

Dim Sql             As String
Dim bloq            As String

Dim Datos()



    Let nRowTop = table2.TopRow
    
    Let Columna = table2.Col

    If KeyAscii <> vbKeyV And KeyAscii <> vbKeyR And KeyAscii <> vbKeyF7 And KeyAscii <> vbKeyF3 And ((table2.Col > nColMoneda And table2.Col < nColCustodia)) Then
    
        Call BacControlWindows(100)
        
        Let table2.Col = columnita
        
        Let TEXT1vp.Top = table2.CellTop + table2.Top + 20
        Let TEXT1vp.Left = table2.CellLeft + table2.Left + 20
        Let TEXT1vp.Width = table2.CellWidth - 20
        Let TEXT1vp.Visible = True
        Call BacControlWindows(1)

        If columnita = nColTir Or columnita = nColVPar Then
            Let TEXT1vp.Max = "9999.9999"
        Else
            Let TEXT1vp.Max = "99999999999.9999"
        End If
      
        If table2.Col = nColValorPresente Or table2.Col = nColVPTran Then
            If Trim(table2.TextMatrix(table2.Row, nColMoneda)) = "USD" Then
                Let TEXT1vp.CantidadDecimales = 2
            Else
                Let TEXT1vp.CantidadDecimales = 0
            End If
        Else
            If bFlagDpx Then
                Let TEXT1vp.CantidadDecimales = 2
            Else
                Let TEXT1vp.CantidadDecimales = 4
            End If
        End If

        If KeyAscii >= vbKey0 And KeyAscii <= vbKey9 Then
            Let TEXT1vp.Text = Chr(KeyAscii)
        End If

        If KeyAscii = vbKeyReturn Then
            Let TEXT1vp.Text = CDbl(table2.TextMatrix(table2.Row, table2.Col))
        End If

        Call TEXT1vp.SetFocus
        Exit Sub

    End If

    Let filita = table2.Row
    Let columnita = table2.Col
    Let fila_table = table2.Row - 1

    If Not table2.Row = 1 Then
        Call Colocardata2
    Else
        Call Data2.Recordset.MoveFirst
    End If

    Call BacToUCase(KeyAscii)

    If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
        Let KeyAscii = Asc(gsBac_PtoDec)
    End If

    If KeyAscii = vbKeyEscape Then
        Let iFlagKeyDown = True
        Exit Sub
    End If

    Select Case table2.Col
        Case Ven_NOMINAL:

            If Not iFlagKeyDown Then
                Let KeyAscii = BacPunto(table2, KeyAscii, 12, 4)
            End If

            If Not IsNumeric(Chr(KeyAscii)) And (Chr(KeyAscii) <> "," And Chr(KeyAscii) <> "." And KeyAscii <> vbKeyBack And KeyAscii <> vbKeyR And KeyAscii <> vbKeyV) Then
                Let KeyAscii = 0
            End If

        Case Ven_TIR, Ven_VPAR
        
            If Not iFlagKeyDown Then
                Let KeyAscii = BacPunto(table2, KeyAscii, 3, 4)
            End If

            If Not IsNumeric(Chr(KeyAscii)) And (Chr(KeyAscii) <> "," And Chr(KeyAscii) <> "." And KeyAscii <> vbKeyBack And KeyAscii <> vbKeyR And KeyAscii <> vbKeyV) Then
                Let KeyAscii = 0
            End If

    End Select

    If KeyAscii = vbKeyR Then
    
        Let KeyAscii = 0
        Call TICKETVENTA_VerDispon(FormHandle, Data2)

        If Data2.Recordset("tm_venta") = "V" Or Data2.Recordset("tm_venta") = "P" Then
            If TICKETVENTA_DesBloquear(FormHandle, Data2) Then
                Call Data2.Recordset.Edit
                Let Data2.Recordset("tm_venta") = " "
                Let Data2.Recordset("tm_clave_dcv") = ""
                Call Data2.Recordset.Update
                    
                If table2.Rows - 1 = 1 Then
                   ' Let Toolbar1.Buttons(6).Tag = "Ver Sel."
                   ' Let Data2.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & hWnd & " AND tm_diasdisp >= 1"
                    Call Data2.Refresh
               ' ElseIf Data2.Recordset.RecordCount > 1 Then
                    Let Data2.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
                    Call Data2.Refresh
                End If
            End If

            If Data2.Recordset("tm_venta") = "*" Then
                If TICKETVENTA_VerBloqueo(FormHandle, Data2) Then
                    Call Data2.Recordset.Edit
                    Let Data2.Recordset("tm_venta") = " "
                    Call Data2.Recordset.Update
                End If
            End If

            If Data2.Recordset.RecordCount > 0 Then
                Call TICKETVENTA_Restaurar(Data2)
                Call TICKETVENTA_Valorizar(2, Data2, FechaPago.Text, "TRAN")
            End If

          ' Call CO_EliminarCortesMDB(FormHandle, Data2.Recordset("tm_correlao"))

            Let TxtTotal.Text = TICKETVENTA_SumarTotal(FormHandle)
            
            Call Data2.Recordset.MoveLast
            Let table2.Rows = Data2.Recordset.RecordCount + 1
            Call Data2.Refresh

            Call VP_llenar_Grilla
 
            Let KeyAscii = 0
            Let BacVP.bSelPagoMañana = False
        
            For nContador = 1 To table2.Rows - 1
                If table2.TextMatrix(nContador, 0) = "V" And table2.TextMatrix(nContador, nColValuta) = "M" Then
                    Let BacVP.bSelPagoMañana = True
                    Exit For
                End If
            Next nContador
        
        ElseIf Data2.Recordset("tm_venta") = "B" Then
        
            If TICKETVENTA_DesBloquear(0, Data2) Then
            
                Call Data2.Recordset.Edit
                Let Data2.Recordset("tm_venta") = " "
                Call Data2.Recordset.Update
            
                Call TICKETVENTA_Restaurar(Data2)
            
                Let table2.TextMatrix(table2.Row, nColEstado) = Data2.Recordset("tm_venta")
            
                For I = 0 To table2.cols - 1
                    Let table2.Col = I
                    Call table2_LeaveCell
                Next I
            End If
        End If
    End If

    If KeyAscii = vbKeyV Then
    
        Let Fila = table2.Row
        Let Columna = table2.Col
        Let table2.ScrollBars = flexScrollBarNone

        If TICKETVENTA_VerDispon(FormHandle, Data2) Then
            If Data2.Recordset("tm_venta") = " " Or Data2.Recordset("tm_venta") = "*" Or Data2.Recordset("tm_venta") = "B" Then
                If TICKETVENTA_Bloquear(FormHandle, Data2) Then
                    Call Data2.Recordset.Edit
                    Let Data2.Recordset("tm_venta") = "V"
                    Let Data2.Recordset("tm_clave_dcv") = ""
                    Call Data2.Recordset.Update
                    Let table2.TextMatrix(table2.Row, nColClaveDCV) = Data2.Recordset("tm_clave_dcv")
                    Call funcFindDatGralMoneda(Val(Data2.Recordset("tm_monemi")))
                    Let SwMx = BacDatGrMon.mnmx
                    Call TICKETVENTA_Valorizar(2, Data2, FechaPago.Text, "")
                    
                Else
                    Call Data2.Recordset.Edit
                    Let Data2.Recordset("tm_venta") = "*"
                    Call Data2.Recordset.Update
                End If
            End If
        End If
        
        Call TICKETVENTA_Valorizar(2, Data2, FechaPago.Text)
  
        Let TxtTotal.Text = TICKETVENTA_SumarTotal(FormHandle)
'        Let Flt_Result.Caption = Format(VENTA_SumarDif(FormHandle), "###,###,###,##0.00")
'
'        If CDbl(Flt_Result.Caption) < 0 Then
'            Flt_Result.ForeColor = &HFF&
'            Flt_Result.Caption = Format(Abs(CDbl(Flt_Result.Caption)), "###,###,###,##0.00")
'        Else
'            Flt_Result.ForeColor = &H0&
'        End If

        Let table2.TextMatrix(table2.Row, nColEstado) = Data2.Recordset("tm_venta")

        Let KeyAscii = 0
    
        Call VP_llenar_Grilla
   
        Let table2.Row = Fila
  
        
    
        For nContador = 1 To table2.Rows - 1
            If table2.TextMatrix(nContador, nColEstado) = "V" And table2.TextMatrix(nContador, nColValuta) = "M" Then
               ' Let BacVP.bSelPagoMañana = True
                Exit For
            End If
        Next nContador

        Let KeyAscii = 0
        Call VP_llenar_Grilla
        Let table2.Row = Fila
    End If
    
    If KeyAscii = vbKeyB Then
        If TICKETVENTA_VerDispon(FormHandle, Data2) Then
            If Data2.Recordset("tm_venta") = " " Or Data2.Recordset("tm_venta") = "*" Then
                If VENTA_Bloquear(0, Data2) Then
                    Data2.Recordset.Edit
                    Data2.Recordset("tm_venta") = "B"
                    Data2.Recordset.Update
                Else
                    Data2.Recordset.Edit
                    Data2.Recordset("tm_venta") = "*"
                    Data2.Recordset.Update
                End If
                
                table2.TextMatrix(table2.Row, nColEstado) = Data2.Recordset("tm_venta")
                
                For I = 0 To table2.cols - 1
                    table2.Col = I
                    Call table2_LeaveCell
                Next I
            End If
        End If
    End If

    If filita <= table2.Rows - 1 Then
         Let table2.Row = filita
    Else
         Let table2.Row = table2.Rows - 1
    End If

    Let table2.Col = Columna
    Call table2.SetFocus
    
    Let table2.ScrollBars = flexScrollBarBoth
    Let table2.TopRow = nRowTop

End Sub


Private Sub table2_LeaveCell()
      
    If Mid(table2.TextMatrix(table2.Row, nColSerie), 1, 6) = "FMUTUO" And table2.Col = nColTir Then
        Let Me.TEXT1vp.Enabled = False
        Let Me.Text2VP.Enabled = False
    Else
        Let TEXT1vp.Enabled = True
        Let Me.Text2VP.Enabled = True
    End If
   
    With table2
   
        If .Row <> 0 And .Col > 1 Then
            Let .CellFontBold = True
        
            If .TextMatrix(.Row, nColEstado) = "V" Then
                Let .CellBackColor = &H800000    '--> vbBlue
            
                If .TextMatrix(.Row, nColValuta) = "M" Then
                    Let .CellForeColor = vbRed
                Else
                    Let .CellForeColor = vbWhite
                End If
            ElseIf .TextMatrix(.Row, nColEstado) = "P" Then
                Let .CellBackColor = vbCyan
                Let .CellForeColor = vbBlack
            
            ElseIf .TextMatrix(.Row, nColEstado) = "*" Then
                Let .CellBackColor = vbGreen + vbWhite    'vbBlack
                Let .CellForeColor = vbWhite
            
            ElseIf .TextMatrix(.Row, nColEstado) = "B" Then
                Let .CellBackColor = vbBlack + vbWhite    'vbBlack
                Let .CellForeColor = vbBlack
            
                If .TextMatrix(.Row, nColValuta) = "M" Then
                    Let .CellForeColor = vbRed
                Else
                    Let .CellForeColor = &H800000  '--> vbBlue
                End If
            End If
            .CellFontBold = False
        End If
    End With

End Sub



Private Sub table2_RowColChange()

    With table2
   
        If .Row <> 0 And .Col > nColSerie Then
            Let .CellFontBold = True
            
            If .TextMatrix(.Row, nColEstado) = "V" Then
                Let .CellBackColor = &H800000 '--> vbBlue
                Let .CellForeColor = vbWhite
            
            ElseIf .TextMatrix(.Row, nColEstado) = "P" Then
                Let .CellBackColor = vbCyan
                Let .CellForeColor = vbBlack
            
            ElseIf .TextMatrix(.Row, nColEstado) = "*" Then
                Let .CellBackColor = vbGreen + vbWhite    'vbBlack
                Let .CellForeColor = vbWhite
            
            ElseIf .TextMatrix(.Row, nColEstado) = "B" Then
                Let .CellBackColor = vbBlack + vbWhite    'vbBlack
                Let .CellForeColor = vbBlack
            Else
                Let .CellBackColor = vbBlack
                Let .CellForeColor = vbBlack
            End If
            
            Let .CellFontBold = False

        End If
    End With

End Sub

Private Sub table2_Scroll()
   'TEXT1VP_LostFocus
End Sub

Private Sub TEXT1VP_GotFocus()
 
    If table2.Col = nColValorPresente Then
        Let TEXT1vp.SelStart = Len(TEXT1vp.Text)
    Else
        If Mid(table2.TextMatrix(table2.Row, nColSerie), 1, 6) = "FMUTUO" And table2.Col = nColTir Then ''''4
            Let TEXT1vp.Enabled = False
        Else
            Let TEXT1vp.Enabled = True
            Let TEXT1vp.SelStart = Len(TEXT1vp.Text)
            Let TEXT1vp.MarcaTexto = True
        End If
    
    End If


End Sub

