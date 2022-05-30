VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacOpeSwapTasaULT 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Swaps de Tasas"
   ClientHeight    =   7050
   ClientLeft      =   1425
   ClientTop       =   2325
   ClientWidth     =   11640
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   -1  'True
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "bacswaptULT.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   7050
   ScaleWidth      =   11640
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   -15
      TabIndex        =   19
      Top             =   0
      Width           =   11595
      _ExtentX        =   20452
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
      Begin Threed.SSPanel etqNumOper 
         Height          =   330
         Left            =   7470
         TabIndex        =   22
         Top             =   45
         Width           =   3060
         _Version        =   65536
         _ExtentX        =   5397
         _ExtentY        =   582
         _StockProps     =   15
         Caption         =   "Modificación Operación N°:  "
         ForeColor       =   8388736
         BackColor       =   -2147483644
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin VB.Frame frmVendimos 
      Caption         =   "Pagamos..."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000C0&
      Height          =   1950
      Left            =   5820
      TabIndex        =   74
      Top             =   4755
      Width           =   5805
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
         Left            =   3105
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   79
         ToolTipText     =   "Documento con el que Pagaremos"
         Top             =   1410
         Width           =   2385
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
         Left            =   3105
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   78
         ToolTipText     =   "Moneda con equivalente del documento"
         Top             =   1080
         Width           =   2385
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
         Left            =   1200
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   77
         ToolTipText     =   "Base en que se encuentra expresada Tasa (para calculo de intereses)"
         Top             =   1410
         Width           =   1545
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
         Left            =   1200
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   76
         ToolTipText     =   "Tasa de Negocio"
         Top             =   390
         Width           =   1785
      End
      Begin BACControles.TXTNumero txtTasaVenta 
         Height          =   360
         Left            =   1200
         TabIndex        =   75
         Top             =   705
         Width           =   1515
         _ExtentX        =   2672
         _ExtentY        =   635
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
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero txtSpreadVenta 
         Height          =   330
         Left            =   1200
         TabIndex        =   80
         Top             =   1065
         Width           =   1530
         _ExtentX        =   2699
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
         Min             =   "-999.99999"
         Max             =   "999.99999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Pagamos"
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
         Index           =   10
         Left            =   3105
         TabIndex        =   88
         Top             =   870
         Width           =   1275
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Base Tasa"
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
         Left            =   165
         TabIndex        =   87
         Top             =   1455
         Width           =   915
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
         Left            =   2760
         TabIndex        =   86
         Top             =   765
         Width           =   195
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Valor Tasa"
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
         Index           =   13
         Left            =   165
         TabIndex        =   85
         Top             =   765
         Width           =   930
      End
      Begin VB.Label lblSwapTasa 
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
         Index           =   14
         Left            =   165
         TabIndex        =   84
         Top             =   435
         Width           =   435
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
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
         Height          =   195
         Index           =   24
         Left            =   165
         TabIndex        =   83
         Top             =   1110
         Width           =   615
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
         Index           =   26
         Left            =   2745
         TabIndex        =   82
         Top             =   1110
         Width           =   195
      End
      Begin VB.Label lblValorIcpVenta 
         Caption         =   "txtValorICPVenta"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800080&
         Height          =   240
         Left            =   3090
         TabIndex        =   81
         Top             =   420
         Visible         =   0   'False
         Width           =   1665
      End
   End
   Begin VB.Frame frmCompramos 
      Caption         =   "Recibimos..."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   1950
      Left            =   15
      TabIndex        =   59
      Top             =   4755
      Width           =   5805
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
         Left            =   1200
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   65
         ToolTipText     =   "Tasa de Negocio"
         Top             =   390
         Width           =   1785
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
         Left            =   1200
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   64
         ToolTipText     =   "Base en que se encuentra expresada Tasa (para calculo de intereses)"
         Top             =   1410
         Width           =   1560
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
         Left            =   3060
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   63
         ToolTipText     =   "Moneda con equivalente del documento"
         Top             =   1080
         Width           =   2385
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
         Left            =   3060
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   62
         ToolTipText     =   "Documento que Recibiremos"
         Top             =   1410
         Width           =   2385
      End
      Begin BACControles.TXTNumero txtTasaCompra 
         Height          =   315
         Left            =   1200
         TabIndex        =   60
         Top             =   720
         Width           =   1545
         _ExtentX        =   2725
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero txtSpreadCompra 
         Height          =   345
         Left            =   1200
         TabIndex        =   61
         Top             =   1050
         Width           =   1530
         _ExtentX        =   2699
         _ExtentY        =   609
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
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label lblSwapTasa 
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
         Index           =   5
         Left            =   165
         TabIndex        =   73
         Top             =   435
         Width           =   435
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Valor Tasa"
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
         Left            =   165
         TabIndex        =   72
         Top             =   765
         Width           =   930
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
         Left            =   2760
         TabIndex        =   71
         Top             =   795
         Width           =   195
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Base Tasa"
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
         Left            =   165
         TabIndex        =   70
         Top             =   1455
         Width           =   915
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   "Recibimos"
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
         Index           =   9
         Left            =   3060
         TabIndex        =   69
         Top             =   840
         Width           =   1275
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
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
         Height          =   195
         Index           =   23
         Left            =   165
         TabIndex        =   68
         Top             =   1110
         Width           =   615
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
         Index           =   25
         Left            =   2745
         TabIndex        =   67
         Top             =   1125
         Width           =   195
      End
      Begin VB.Label lblValorIcpCompra 
         Caption         =   "txtValorICPCompra"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800080&
         Height          =   240
         Left            =   3060
         TabIndex        =   66
         Top             =   435
         Visible         =   0   'False
         Width           =   1665
      End
   End
   Begin TabDlg.SSTab tabFlujos 
      Height          =   2970
      Left            =   0
      TabIndex        =   7
      Top             =   1800
      Width           =   11610
      _ExtentX        =   20479
      _ExtentY        =   5239
      _Version        =   393216
      TabHeight       =   520
      BackColor       =   12632256
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
      TabCaption(0)   =   "Definiciones"
      TabPicture(0)   =   "bacswaptULT.frx":000C
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Frame2(1)"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "Frame3"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "Frame5"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).ControlCount=   3
      TabCaption(1)   =   "Flujos Recibimos"
      TabPicture(1)   =   "bacswaptULT.frx":0028
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "txtFechaRecib"
      Tab(1).Control(0).Enabled=   0   'False
      Tab(1).Control(1)=   "txtAmortiza"
      Tab(1).Control(1).Enabled=   0   'False
      Tab(1).Control(2)=   "cmbModalidad"
      Tab(1).Control(2).Enabled=   0   'False
      Tab(1).Control(3)=   "txtTasa"
      Tab(1).Control(3).Enabled=   0   'False
      Tab(1).Control(4)=   "grdRecibimos"
      Tab(1).Control(4).Enabled=   0   'False
      Tab(1).ControlCount=   5
      TabCaption(2)   =   "Flujos Pagamos"
      TabPicture(2)   =   "bacswaptULT.frx":0044
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "txtFechaPag"
      Tab(2).Control(0).Enabled=   0   'False
      Tab(2).Control(1)=   "txtTasaPag"
      Tab(2).Control(1).Enabled=   0   'False
      Tab(2).Control(2)=   "txtAmortizaPag"
      Tab(2).Control(2).Enabled=   0   'False
      Tab(2).Control(3)=   "cmbModalidadPag"
      Tab(2).Control(3).Enabled=   0   'False
      Tab(2).Control(4)=   "grdPagamos"
      Tab(2).Control(4).Enabled=   0   'False
      Tab(2).ControlCount=   5
      Begin VB.Frame Frame5 
         Height          =   2505
         Left            =   9315
         TabIndex        =   54
         Top             =   345
         Width           =   2130
         Begin VB.OptionButton optCompensa 
            Caption         =   "&Compensación"
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
            Height          =   315
            Left            =   90
            Style           =   1  'Graphical
            TabIndex        =   57
            ToolTipText     =   "Modalidad de Pago de Contrato y/o Flujos"
            Top             =   450
            Value           =   -1  'True
            Width           =   1725
         End
         Begin VB.OptionButton optEntFisica 
            Caption         =   "&Entrega Física"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000C0&
            Height          =   315
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   56
            ToolTipText     =   "Modalidad de Pago de Contrato y/o Flujos"
            Top             =   840
            Width           =   1725
         End
         Begin VB.Frame Frame2 
            Height          =   60
            Index           =   0
            Left            =   0
            TabIndex        =   55
            Top             =   1320
            Width           =   1980
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   "Modalidad de Pago"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800080&
            Height          =   195
            Index           =   19
            Left            =   135
            TabIndex        =   58
            Top             =   180
            Width           =   1650
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Amortización Pagamos"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800080&
         Height          =   2505
         Left            =   4665
         TabIndex        =   39
         Top             =   345
         Width           =   4635
         Begin VB.ComboBox cmbAmortizaCapitalPagamos 
            BackColor       =   &H00FFFFFF&
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
            Left            =   135
            Sorted          =   -1  'True
            Style           =   2  'Dropdown List
            TabIndex        =   42
            ToolTipText     =   "Período de Amortización de Capital"
            Top             =   2040
            Width           =   1725
         End
         Begin VB.ComboBox cmbAmortizaInteresPagamos 
            BackColor       =   &H00FFFFFF&
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
            Left            =   2175
            Sorted          =   -1  'True
            Style           =   2  'Dropdown List
            TabIndex        =   41
            ToolTipText     =   "Período de Amortización de Intereses"
            Top             =   2040
            Width           =   1725
         End
         Begin VB.ComboBox cmbEspecialPagamos 
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
            Left            =   105
            Style           =   2  'Dropdown List
            TabIndex        =   40
            Top             =   1425
            Width           =   1215
         End
         Begin BACControles.TXTFecha txtFecInicioPagamos 
            Height          =   300
            Left            =   405
            TabIndex        =   43
            Top             =   420
            Width           =   1230
            _ExtentX        =   2170
            _ExtentY        =   529
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
            Text            =   "18/05/2000"
         End
         Begin BACControles.TXTFecha txtFecPrimerVctoPagamos 
            Height          =   315
            Left            =   1305
            TabIndex        =   44
            Top             =   1425
            Visible         =   0   'False
            Width           =   1230
            _ExtentX        =   2170
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
            Text            =   "18/05/2000"
         End
         Begin BACControles.TXTFecha txtFecTerminoPagamos 
            Height          =   300
            Left            =   405
            TabIndex        =   45
            Top             =   900
            Width           =   1230
            _ExtentX        =   2170
            _ExtentY        =   529
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
            Text            =   "18/05/2000"
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   " Capital"
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
            Index           =   28
            Left            =   165
            TabIndex        =   53
            Top             =   1860
            Width           =   660
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   " Interés"
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
            Index           =   29
            Left            =   2205
            TabIndex        =   52
            Top             =   1845
            Width           =   660
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   "Término"
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
            Index           =   18
            Left            =   30
            TabIndex        =   51
            Top             =   720
            Width           =   690
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   "Inicio"
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
            Index           =   27
            Left            =   30
            TabIndex        =   50
            Top             =   240
            Width           =   480
         End
         Begin VB.Label lblFechaInicioPagamos 
            BorderStyle     =   1  'Fixed Single
            Caption         =   "lblFechaInicioPagamos"
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
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   300
            Left            =   1635
            TabIndex        =   49
            Top             =   420
            Width           =   2700
         End
         Begin VB.Label lblFechaPrimerAmortPagamos 
            BorderStyle     =   1  'Fixed Single
            Caption         =   "lblFechaPrimerAmortPagamos"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   2535
            TabIndex        =   48
            Top             =   1425
            Visible         =   0   'False
            Width           =   1980
         End
         Begin VB.Label lblFechaTerminoPagamos 
            BorderStyle     =   1  'Fixed Single
            Caption         =   "lblFechaTerminoPagamos"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   300
            Left            =   1635
            TabIndex        =   47
            Top             =   900
            Width           =   2700
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   "Amortización Especial"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800080&
            Height          =   195
            Index           =   30
            Left            =   120
            TabIndex        =   46
            Top             =   1230
            Width           =   1875
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Amortización Recibimos"
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
         Height          =   2505
         Index           =   1
         Left            =   75
         TabIndex        =   24
         Top             =   345
         Width           =   4560
         Begin VB.ComboBox cmbAmortizaCapitalRecibimos 
            BackColor       =   &H00FFFFFF&
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
            Left            =   90
            Sorted          =   -1  'True
            Style           =   2  'Dropdown List
            TabIndex        =   27
            ToolTipText     =   "Período de Amortización de Capital"
            Top             =   2040
            Width           =   1725
         End
         Begin VB.ComboBox cmbAmortizaInteresRecibimos 
            BackColor       =   &H00FFFFFF&
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
            Left            =   2130
            Sorted          =   -1  'True
            Style           =   2  'Dropdown List
            TabIndex        =   26
            ToolTipText     =   "Período de Amortización de Intereses"
            Top             =   2040
            Width           =   1725
         End
         Begin VB.ComboBox cmbEspecialRecibimos 
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
            Left            =   105
            Style           =   2  'Dropdown List
            TabIndex        =   25
            Top             =   1425
            Width           =   1095
         End
         Begin BACControles.TXTFecha txtFecInicioRecibimos 
            Height          =   300
            Left            =   405
            TabIndex        =   28
            Top             =   420
            Width           =   1230
            _ExtentX        =   2170
            _ExtentY        =   529
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
            Text            =   "18/05/2000"
         End
         Begin BACControles.TXTFecha txtFecPrimerVctoRecibimos 
            Height          =   315
            Left            =   1185
            TabIndex        =   29
            Top             =   1425
            Visible         =   0   'False
            Width           =   1230
            _ExtentX        =   2170
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
            Text            =   "18/05/2000"
         End
         Begin BACControles.TXTFecha txtFecTerminoRecibimos 
            Height          =   300
            Left            =   405
            TabIndex        =   30
            Top             =   900
            Width           =   1230
            _ExtentX        =   2170
            _ExtentY        =   529
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
            Text            =   "18/05/2000"
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   " Capital"
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
            Index           =   16
            Left            =   120
            TabIndex        =   38
            Top             =   1860
            Width           =   660
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   " Interés"
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
            Index           =   17
            Left            =   2160
            TabIndex        =   37
            Top             =   1845
            Width           =   660
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   "Término"
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
            Left            =   30
            TabIndex        =   36
            Top             =   720
            Width           =   690
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   "Inicio"
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
            Index           =   2
            Left            =   30
            TabIndex        =   35
            Top             =   240
            Width           =   480
         End
         Begin VB.Label lblFechaInicioRecibimos 
            BorderStyle     =   1  'Fixed Single
            Caption         =   "lblFechaInicioRecibimos"
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
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   300
            Left            =   1635
            TabIndex        =   34
            Top             =   420
            Width           =   2700
         End
         Begin VB.Label lblFechaPrimerAmortRecibimos 
            BorderStyle     =   1  'Fixed Single
            Caption         =   "lblFechaPrimerAmortRecibimos"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   2415
            TabIndex        =   33
            Top             =   1425
            Visible         =   0   'False
            Width           =   1980
         End
         Begin VB.Label lblFechaTerminoRecibimos 
            BorderStyle     =   1  'Fixed Single
            Caption         =   "lblFechaTerminoRecibimos"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   300
            Left            =   1635
            TabIndex        =   32
            Top             =   900
            Width           =   2700
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   "Amortización Especial"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800080&
            Height          =   195
            Index           =   15
            Left            =   120
            TabIndex        =   31
            Top             =   1230
            Width           =   1875
         End
      End
      Begin BACControles.TXTFecha txtFechaPag 
         Height          =   285
         Left            =   -72765
         TabIndex        =   18
         Top             =   690
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
         Text            =   "08/05/2001"
      End
      Begin BACControles.TXTFecha txtFechaRecib 
         Height          =   285
         Left            =   -72900
         TabIndex        =   17
         Top             =   750
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
         Text            =   "08/05/2001"
      End
      Begin BACControles.TXTNumero txtTasaPag 
         Height          =   285
         Left            =   -69240
         TabIndex        =   15
         ToolTipText     =   "Con tecla Enter acepta modificación"
         Top             =   705
         Width           =   1635
         _ExtentX        =   2884
         _ExtentY        =   503
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
         BorderStyle     =   0
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "-999.99999"
         Max             =   "999.999999"
         CantidadDecimales=   "4"
      End
      Begin BACControles.TXTNumero txtAmortizaPag 
         Height          =   285
         Left            =   -71430
         TabIndex        =   14
         ToolTipText     =   "Con tecla Enter acepta modificación"
         Top             =   705
         Width           =   2130
         _ExtentX        =   3757
         _ExtentY        =   503
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
         BorderStyle     =   0
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "-9999999999.9999"
         Max             =   "9999999999.9999"
         CantidadDecimales=   "4"
      End
      Begin VB.ComboBox cmbModalidadPag 
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
         Left            =   -67545
         Style           =   2  'Dropdown List
         TabIndex        =   13
         ToolTipText     =   "Con tecla Enter acepta modificación"
         Top             =   705
         Visible         =   0   'False
         Width           =   1445
      End
      Begin BACControles.TXTNumero txtAmortiza 
         Height          =   285
         Left            =   -71580
         TabIndex        =   12
         ToolTipText     =   "Con tecla Enter acepta modificación"
         Top             =   765
         Width           =   2130
         _ExtentX        =   3757
         _ExtentY        =   503
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
         BorderStyle     =   0
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "-9999999999.9999"
         Max             =   "9999999999.9999"
         CantidadDecimales=   "4"
      End
      Begin VB.ComboBox cmbModalidad 
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
         Left            =   -67725
         Style           =   2  'Dropdown List
         TabIndex        =   11
         ToolTipText     =   "Con tecla Enter acepta modificación"
         Top             =   765
         Visible         =   0   'False
         Width           =   1445
      End
      Begin BACControles.TXTNumero txtTasa 
         Height          =   285
         Left            =   -69420
         TabIndex        =   10
         ToolTipText     =   "Con tecla Enter acepta modificación"
         Top             =   765
         Visible         =   0   'False
         Width           =   1635
         _ExtentX        =   2884
         _ExtentY        =   503
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
         BorderStyle     =   0
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "-999.999999"
         Max             =   "999.999999"
         CantidadDecimales=   "4"
      End
      Begin MSFlexGridLib.MSFlexGrid grdPagamos 
         Height          =   2385
         Left            =   -74955
         TabIndex        =   9
         Top             =   405
         Width           =   11535
         _ExtentX        =   20346
         _ExtentY        =   4207
         _Version        =   393216
         BackColor       =   12632256
         BackColorFixed  =   8421440
         ForeColorFixed  =   16777215
         GridLines       =   2
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin MSFlexGridLib.MSFlexGrid grdRecibimos 
         Height          =   2385
         Left            =   -74955
         TabIndex        =   8
         Top             =   405
         Width           =   11535
         _ExtentX        =   20346
         _ExtentY        =   4207
         _Version        =   393216
         RowHeightMin    =   275
         BackColor       =   12632256
         BackColorFixed  =   8421440
         ForeColorFixed  =   16777215
         GridLines       =   2
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
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
      Height          =   1275
      Left            =   30
      TabIndex        =   4
      Top             =   495
      Width           =   11475
      Begin BACControles.TXTNumero txtCapital 
         Height          =   330
         Left            =   975
         TabIndex        =   3
         Top             =   585
         Width           =   2730
         _ExtentX        =   4815
         _ExtentY        =   582
         BackColor       =   16777215
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
         Text            =   "0"
         Text            =   "0"
         Min             =   "-999999999999.9999"
         Max             =   "999999999999.9999"
         Separator       =   -1  'True
      End
      Begin VB.OptionButton optCompra 
         Caption         =   "&Recibimos"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   330
         Left            =   4545
         Style           =   1  'Graphical
         TabIndex        =   0
         ToolTipText     =   "Tipo de Operación ... Compra/Venta"
         Top             =   1095
         Value           =   -1  'True
         Visible         =   0   'False
         Width           =   285
      End
      Begin VB.OptionButton optVenta 
         Caption         =   "&Pagamos"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   330
         Left            =   5010
         Style           =   1  'Graphical
         TabIndex        =   1
         ToolTipText     =   "Tipo de Operación ... Compra/Venta"
         Top             =   1155
         Visible         =   0   'False
         Width           =   315
      End
      Begin VB.ComboBox cmbMoneda 
         BackColor       =   &H00FFFFFF&
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
         Left            =   990
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   2
         ToolTipText     =   "Moneda Capital"
         Top             =   240
         Width           =   2745
      End
      Begin VB.Label TxtValorMoneda 
         Caption         =   "TxtValorMoneda"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800080&
         Height          =   240
         Left            =   3855
         TabIndex        =   16
         Top             =   300
         Width           =   1635
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   " Capital"
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
         Height          =   315
         Index           =   1
         Left            =   150
         TabIndex        =   6
         Top             =   630
         Width           =   795
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   " Moneda"
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
         Left            =   150
         TabIndex        =   5
         Top             =   285
         Width           =   750
      End
   End
   Begin VB.Label Lbl_Num_Oper_Oculto 
      BorderStyle     =   1  'Fixed Single
      Height          =   510
      Left            =   210
      TabIndex        =   23
      Top             =   7515
      Width           =   2355
   End
   Begin VB.Label lblSwapTasa 
      AutoSize        =   -1  'True
      Caption         =   "Flujos Vencidos"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   22
      Left            =   435
      TabIndex        =   21
      Top             =   6780
      Width           =   1350
   End
   Begin VB.Label Simbologia 
      BackColor       =   &H00FFFFC0&
      BorderStyle     =   1  'Fixed Single
      Height          =   240
      Left            =   135
      TabIndex        =   20
      Top             =   6765
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
            Picture         =   "bacswaptULT.frx":0060
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacswaptULT.frx":037A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacswaptULT.frx":0694
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacswaptULT.frx":09AE
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacOpeSwapTasaULT"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'**Variables utilizadas en la funcion de Recalculo de Interes
Public RecFecha      As Date
Public RecTasa       As Double
Public RecMontoResto As Double
Public RecMontoAmort As Double
Public RecFecVencAnt As Date

Dim TipoAm           As Double
Dim OperSwap         As String
Dim Operacion        As String
Dim DesgloseAmort    As String
Dim FechaCierre      As Date   'Fecha de cierre operaciones
Dim ValorDolarObs    As Double
Dim DatosPorMoneda()
Dim TotDatPorMon     As Double
Dim CodAscii         As Integer
Dim ValorTasasMon()
Dim TotTasasMon      As Integer
Dim objMoneda        As New ClsMoneda
Dim ValorAnt         As String
Dim ValorUlt         As String
Dim nPaisOrigen      As Integer
Dim Numero_Operacion As Double
Private ObjCliente   As New clsCliente

Public MiTipoSwap    As SwapTasasAs
Dim PasoTexto As String


Private Function CambiaColorCeldas(Grd As Object)
Dim I, j

    With Grd
        For I = 1 To .Rows - 1
            If .TextMatrix(I, .Cols - 2) = "CH" Then
                .Row = I
                For j = 1 To .Cols - 1
                    .Col = j
                    .CellForeColor = &HFFFFC0
                Next
            End If
        Next
    End With
    
End Function

Private Sub CambioAmortizacion(Operacion As String)

   Dim I             As Integer
   Dim SumAmort      As Double
   Dim Grilla        As Object
   Dim oGrilla       As Object
   Dim Base          As String
   Dim obase         As String
   Dim TipOper       As String
   Dim otipOper      As String
   Dim MontoAmortiza As Double
   Dim SumaPaso      As Double
    
    If Operacion = "C" Then
        Set Grilla = grdRecibimos
        Set oGrilla = grdPagamos
        DesgloseAmortST = SacaTipoPeriodo(cmbBaseCompra)
        
        If cmbAmortizaCapitalRecibimos.ListIndex <> -1 Then
            TipoAm = ValorAmort(cmbAmortizaCapitalRecibimos, DesgloseAmortST)
        End If
        
        TipOper = "C"
        otipOper = "V"
        MontoAmortiza = txtAmortiza.Text
        
    Else
        Set Grilla = grdPagamos
        Set oGrilla = grdRecibimos
        DesgloseAmortST = SacaTipoPeriodo(cmbBaseVenta)
        
        If cmbAmortizaCapitalPagamos.ListIndex <> -1 Then
            TipoAm = ValorAmort(cmbAmortizaCapitalPagamos, DesgloseAmortST)
        End If
        
        TipOper = "V"
        otipOper = "C"
        MontoAmortiza = txtAmortizaPag.Text
        
    End If
    
   If Grilla.Col <> 3 Then Exit Sub
   
   If MontoAmortiza <> CDbl(Grilla.TextMatrix(Grilla.Row, 3)) Then
        SumAmort = 0
        If Grilla.TextMatrix(I, 3) = "" Then Exit Sub
        
        If TipoAm = -1 Then
        
            If Not ValidaModificaciones(Grilla) Then
                'Amortizacion de capital BONOS
                
                    Grilla.TextMatrix(Grilla.Row, 3) = Format(MontoAmortiza, "###,###,###,##0,###0")
                                                 
                    For I = 1 To Grilla.Rows - 2
                        SumAmort = SumAmort + CDbl(Grilla.TextMatrix(I, 3))
                    Next
                    
                    SumaPaso = CDbl(txtCapital.Text) - SumAmort
                    
                    If SumaPaso < 0 Then
                        MsgBox "Montos Amortización Excede monto Capital!. Se realizará ajuste de Capital", vbInformation, Msj
                        txtCapital.Text = SumAmort
                        SumaPaso = CDbl(txtCapital.Text) - SumAmort
                        
                    End If
                    
                    Grilla.TextMatrix(Grilla.Rows - 1, 3) = Format(SumaPaso, "###,###,###,##0.###0")
                
                    Call CalculoInteresBonos(TipOper)
                    
                    If cmbAmortizaInteresRecibimos.ListIndex = cmbAmortizaInteresPagamos.ListIndex Then
                    
                        For I = 1 To oGrilla.Rows - 1
                        
                            If CDate(oGrilla.TextMatrix(I, 1)) = CDate(Grilla.TextMatrix(Grilla.Row, 1)) Then
                                oGrilla.TextMatrix(I, 3) = MontoAmortiza
                                oGrilla.TextMatrix(oGrilla.Rows - 1, 3) = Format(SumaPaso)
                                Call CalculoInteresBonos(otipOper)
                                Exit For
                                
                            End If
                            
                        Next
                        
                    End If
                    
            End If
            
        End If
        
    End If
    
    cmbAmortizaInteresRecibimos_LostFocus
    cmbAmortizaInteresPagamos_LostFocus
    
    Grilla.SetFocus
    Set Grilla = Nothing
    Set oGrilla = Nothing
        
End Sub


Function Deshabilitar()

   'Frame1.Enabled = False
    fraOperacion.Enabled = False
    
    If cmbTasaCompra.ItemData(cmbTasaCompra.ListIndex) = 1 Then
        'si es tasa fija
        frmVendimos.Enabled = False
        cmbTasaCompra.Enabled = False
        cmbBaseCompra.Enabled = False
        cmbMonedaRecibimos.Enabled = False
        cmbDocumentoRecibimos.Enabled = False
    Else
        frmCompramos.Enabled = False
        cmbTasaVenta.Enabled = False
        cmbBaseVenta.Enabled = False
        cmbMonedaPagamos.Enabled = False
        cmbDocumentoPagamos.Enabled = False
    End If
    
    cmbAmortizaCapitalRecibimos.Enabled = False
    cmbAmortizaInteresRecibimos.Enabled = False
    cmbAmortizaCapitalPagamos.Enabled = False
    cmbAmortizaInteresPagamos.Enabled = False

    txtFecInicioRecibimos.Enabled = False
    txtFecInicioPagamos.Enabled = False
    
    txtFecPrimerVctoRecibimos.Enabled = False
    txtFecPrimerVctoPagamos.Enabled = False
    
    optCompensa.Enabled = False
    optEntFisica.Enabled = False
    'cmbCarteraInversion.Enabled = False
    
End Function

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

Screen.MousePointer = 11
 
If Tecla = 13 Or Tecla = 27 Then
            
    If TipOpcion = "C" Then
        Set mGrilla = grdRecibimos
        mbase = cmbBaseCompra
        mTipOp = "C"
        
        Set oGrilla = grdPagamos
        obase = cmbBaseVenta
        oTipOp = "V"
        FechaInicio = txtFecInicioRecibimos.Text
        fechaTermino = txtFecTerminoRecibimos.Text
    
    Else
        Set mGrilla = grdPagamos
        mbase = cmbBaseVenta
        mTipOp = "V"
        Set oGrilla = grdRecibimos
        obase = cmbBaseCompra
        oTipOp = "C"
        
        FechaInicio = txtFecInicioPagamos.Text
        fechaTermino = txtFecTerminoPagamos.Text
    
    End If
                
    With mGrilla
                
    If .Col = 1 Then
    
        If Tecla = 27 Then
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
         
        '-- valida fecha
    ElseIf .Col = 14 Then
            .TextMatrix(.Row, .Col) = Fecha.Text
            Exit Function
    Else
        Exit Function
    End If
        
        total = CDbl(txtCapital.Text)
        iDec = 5
        sFormat = "#,##0" + IIf(iDec = 0, "", "." + String(iDec, "0"))
        
        If Not ValidaDatosCambio Then
                  GoTo Fin
        End If
    
        If Not BacEsHabil(Fecha.Text) Then
            MsgBox "Fecha corresponde a un día no hábil, se define próximo hábil", vbCritical, "Control de Vencimientos"
            Fecha.Text = BacProxHabil(Fecha.Text)
            SendKeys "{HOME}{LEFT}"
            Exit Function
        End If
        
        OldFecha = .TextMatrix(.Row, .Col)
        NewFecha = Fecha.Text
            
        If CDate(NewFecha) = CDate(OldFecha) Then
            GoTo Fin
        End If
        
        '---- Modifica Vencimiento de Flujo
        .TextMatrix(.Row, .Col) = NewFecha
        If .Row + 1 = .Rows Then
        
            'Si es el ultimo flujo cambia fecha termino de la operacion
            If mTipOp = "C" Then
                txtFecTerminoRecibimos.Text = NewFecha
                If OldFecha = CDate(txtFecTerminoRecibimos.Text) Then
                    txtFecTerminoRecibimos.Text = NewFecha
                End If
                
            Else
            
                txtFecTerminoPagamos.Text = NewFecha
                If CDate(txtFecTerminoPagamos.Text) = OldFecha Then
                    txtFecTerminoPagamos.Text = NewFecha
                End If
            
            End If
            
        End If
        
        If .Row + 1 < .Rows Then
            .TextMatrix(.Row + 1, 9) = NewFecha                 '---- Modifica Inicio de Flujo Posterior
        End If

        Call CalculoInteresBonos(mTipOp)
        
        If cmbAmortizaInteresRecibimos.ListIndex = cmbAmortizaInteresPagamos.ListIndex Then
        
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
       
    Screen.MousePointer = 0
    Exit Function
    
Fin:
        Screen.MousePointer = 0
        Set oGrilla = Nothing
        Set mGrilla = Nothing
        Fecha.Visible = False
        Exit Function
        
Error:
        Screen.MousePointer = 0
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
    If txtCapital.Text = "" Then
        MsgBox "Debe ingresar Monto Capital", vbInformation, Msj
        txtCapital.SetFocus
        Exit Function
    ElseIf Not IsNumeric(Val(txtCapital.Text)) Then
        MsgBox "Monto Capital Incorrecto!", vbInformation, Msj
        txtCapital.SetFocus
        Exit Function
    End If
    If Val(txtCapital.Text) <= 0 Then
        MsgBox "Monto Capital debe ser Mayor a CERO", vbInformation, Msj
        txtCapital.SetFocus
        Exit Function
    End If
        
    If cmbTasaCompra.ListIndex = -1 Then
        MsgBox "Debe seleccionar el tipo de Tasa en Recibimos", vbInformation, Msj
        cmbTasaCompra.SetFocus
        Exit Function
    End If
   If Not IsNumeric(txtTasaCompra.Text) Then
        MsgBox "Monto de Tasa está Incorrecto!", vbInformation, Msj
        txtTasaCompra.SetFocus
        Exit Function
    End If
    
    If cmbBaseCompra.ListIndex = -1 Then
        MsgBox "Debe seleccionar Base Tasa en Compras", vbInformation, Msj
        cmbBaseCompra.SetFocus
        Exit Function
    End If
    
    If cmbAmortizaCapitalRecibimos.ListIndex = -1 Then
        MsgBox "Debe seleccionar Opción de Amortización de Capital Recibimos", vbInformation, Msj
        cmbAmortizaCapitalRecibimos.SetFocus
        Exit Function
    End If
    
    
    'Venta
    If cmbTasaVenta.ListIndex = -1 Then
        MsgBox "Debe seleccionar el tipo de Tasa en Pagamos", vbInformation, Msj
        cmbTasaVenta.SetFocus
        Exit Function
    End If
    
    If Not IsNumeric(txtTasaVenta.Text) Then
        MsgBox "Monto de Tasa Venta está Incorrecto!", vbInformation, Msj
        txtTasaVenta.SetFocus
        Exit Function
    End If
    
    If cmbBaseVenta.ListIndex = -1 Then
        MsgBox "Debe seleccionar Base Tasa en Venta", vbInformation, Msj
        cmbBaseVenta.SetFocus
        Exit Function
    End If
    
    If cmbAmortizaInteresRecibimos.ListIndex = -1 Then
        MsgBox "Debe seleccionar Opción de Amortización de Interés Recibimos", vbInformation, Msj
        cmbAmortizaInteresRecibimos.SetFocus
        Exit Function
    End If
    
    If cmbAmortizaInteresPagamos.ListIndex = -1 Then
        MsgBox "Debe seleccionar Opción de Amortización de Interés Pagamos", vbInformation, Msj
        cmbAmortizaInteresPagamos.SetFocus
        Exit Function
    End If
    
    
    If cmbAmortizaCapitalPagamos.ListIndex = -1 Then
        MsgBox "Debe seleccionar Opción de Amortización de Capital Pagamos", vbInformation, Msj
        cmbAmortizaCapitalPagamos.SetFocus
        Exit Function
    End If

    If txtFecInicioRecibimos.Text = "" Then
        MsgBox "Debe ingresar Fecha Inicio Recibimos de Contrato", vbInformation, Msj
        txtFecInicioRecibimos.SetFocus
        Exit Function
        
    ElseIf Not IsDate(txtFecInicioRecibimos.Text) Then
        MsgBox "Fecha Inicio Recibimos de Contrato está Incorrecta!", vbInformation, Msj
        txtFecInicioRecibimos.SetFocus
        Exit Function
        
    ElseIf Not BacEsHabil(txtFecInicioRecibimos.Text) Then
            MsgBox "Fecha de Inicio Recibimos no es día hábil", vbInformation, Msj
            txtFecInicioRecibimos.SetFocus
            Exit Function
            
    End If
    
    If txtFecInicioPagamos.Text = "" Then
        MsgBox "Debe ingresar Fecha Inicio Pagamos de Contrato", vbInformation, Msj
        txtFecInicioPagamos.SetFocus
        Exit Function
        
    ElseIf Not IsDate(txtFecInicioPagamos.Text) Then
        MsgBox "Fecha Inicio Pagamos de Contrato está Incorrecta!", vbInformation, Msj
        txtFecInicioPagamos.SetFocus
        Exit Function
        
    ElseIf Not BacEsHabil(txtFecInicioPagamos.Text) Then
            MsgBox "Fecha de Inicio Pagamos no es día hábil", vbInformation, Msj
            txtFecInicioPagamos.SetFocus
            Exit Function
            
    End If
    
    If txtFecTerminoRecibimos.Text = "" Then
        MsgBox "Debe ingresar Fecha Termino Recibimos de Contrato", vbInformation, Msj
        txtFecTerminoRecibimos.SetFocus
        Exit Function
        
    ElseIf Not IsDate(txtFecTerminoRecibimos.Text) Then
        MsgBox "Fecha Termino Recibimos de Contrato está Incorrecta!", vbInformation, Msj
        txtFecTerminoRecibimos.SetFocus
        Exit Function
        
    ElseIf Not BacEsHabil(txtFecTerminoRecibimos.Text) Then
        MsgBox "Fecha de Término Recibimos no es día hábil", vbInformation, Msj
        txtFecTerminoRecibimos.SetFocus
        Exit Function
        
    End If
    
    If txtFecTerminoPagamos.Text = "" Then
        MsgBox "Debe ingresar Fecha Termino Pagamos de Contrato", vbInformation, Msj
        txtFecTerminoPagamos.SetFocus
        Exit Function
        
    ElseIf Not IsDate(txtFecTerminoPagamos.Text) Then
        MsgBox "Fecha Termino Pagamos de Contrato está Incorrecta!", vbInformation, Msj
        txtFecTerminoPagamos.SetFocus
        Exit Function
        
    ElseIf Not BacEsHabil(txtFecTerminoPagamos.Text) Then
        MsgBox "Fecha de Término Pagamos no es día hábil", vbInformation, Msj
        txtFecTerminoPagamos.SetFocus
        Exit Function
        
    End If
    
    ValidaDatosCambio = True
    
Exit Function
Error:
           ValidaDatosCambio = False
           MsgBox "ERROR : " & err.Description, vbOKOnly + vbCritical
           Exit Function
    
End Function

Function LimpiarDatos()
    
    'limpia textos
    txtCapital.Text = 0
    txtFecInicioRecibimos.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
    txtFecInicioPagamos.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
        
    txtFecTerminoRecibimos.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
    txtFecTerminoPagamos.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
    TxtValorMoneda.Caption = 0
    txtTasaCompra.Text = 0
    txtTasaVenta.Text = 0
    txtSpreadCompra.Text = 0
    txtSpreadVenta.Text = 0
    nPaisOrigenST = 0
    txtTasa.Text = 0
    txtAmortiza.Text = 0
    lblFechaInicioRecibimos = BacFechaStr(txtFecInicioRecibimos.Text)
    lblFechaInicioPagamos = BacFechaStr(txtFecInicioPagamos.Text)
    
    lblFechaTerminoRecibimos = BacFechaStr(txtFecTerminoRecibimos.Text)
    lblFechaTerminoPagamos = BacFechaStr(txtFecTerminoPagamos.Text)

    cmbModalidad.ListIndex = -1
    cmbModalidadPag.ListIndex = -1
    cmbMoneda.ListIndex = -1
    'CmbOperador.ListIndex = -1
    cmbTasaCompra.Clear
    cmbBaseCompra.ListIndex = -1
    cmbMonedaRecibimos.Clear
    cmbDocumentoRecibimos.Clear
    cmbTasaVenta.Clear
    cmbBaseVenta.ListIndex = -1
    cmbMonedaPagamos.Clear
    cmbDocumentoPagamos.Clear
    cmbAmortizaCapitalRecibimos.ListIndex = -1
    'cmbAmortizaInteresRecibimos.ListIndex = -1
    cmbAmortizaCapitalPagamos.ListIndex = -1
    'cmbAmortizaInteresPagamos.ListIndex = -1
    'cmbCarteraInversion.ListIndex = -1
    
    cmbAmortizaInteresRecibimos.Tag = 0
    cmbAmortizaInteresPagamos.Tag = 0

    optCompensa.Value = True
    OperacionST = "C"
    
    tabFlujos.Tab = 0
    tabFlujos.TabEnabled(1) = False
    tabFlujos.TabEnabled(2) = False
    
    lblSwapTasa(22).Visible = False
    Simbologia.Visible = False
    
    Call bacBuscarCombo(cmbTasaCompra, 1)
    
    Call BuscaCmbAmortiza(cmbAmortizaCapitalRecibimos, 6)
    Call BuscaCmbAmortiza(cmbAmortizaInteresRecibimos, 3)

    Call BuscaCmbAmortiza(cmbAmortizaCapitalPagamos, 6)
    Call BuscaCmbAmortiza(cmbAmortizaInteresPagamos, 3)
    
    Call BacLimpiaGrilla(grdPagamos)
    Call BacLimpiaGrilla(grdRecibimos)
    
    cmbEspecialRecibimos.ListIndex = 0
    cmbEspecialPagamos.ListIndex = 0
    txtFecPrimerVctoRecibimos.Visible = False
    txtFecPrimerVctoPagamos.Visible = False
    txtFecPrimerVctoRecibimos.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
    txtFecPrimerVctoPagamos.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
    lblFechaPrimerAmortRecibimos = BacFechaStr(txtFecPrimerVctoRecibimos.Text)
    lblFechaPrimerAmortPagamos = BacFechaStr(txtFecPrimerVctoPagamos.Text)
    
    Toolbar1.Buttons(2).Enabled = False
    
End Function

Function ValidaFechasIngreso(Cual, Evento As String) As Boolean
    
    ValidaFechasIngreso = False
    
    If Evento = "R" Then 'Recibimos
    
        Select Case Cual
            Case 1 'Fecha Inicio
            
                If txtFecInicioRecibimos.Text <> "" Then
                
                    If IsDate(txtFecInicioRecibimos.Text) Then
                        txtFecInicioRecibimos.Text = Format(txtFecInicioRecibimos.Text, gsc_FechaDMA)
                        txtFecInicioRecibimos.Text = ValidaFecha(txtFecInicioRecibimos.Text)
                        lblFechaInicioRecibimos = BacFechaStr(txtFecInicioRecibimos.Text)
                                           
                        Call SugerirFechaPrimVecto(Evento)
                        
                        If CDate(txtFecTerminoRecibimos.Text) < CDate(txtFecPrimerVctoRecibimos.Text) Then txtFecTerminoRecibimos.Text = txtFecPrimerVctoRecibimos.Text
                        
                    Else
                            MsgBox "Fecha de Inicio no es válida", vbInformation, Msj
                            txtFecInicioRecibimos.SetFocus
                    End If
                                        
                End If
                
            Case 2 'Fecha Primer Vencimiento
            
                If txtFecPrimerVctoRecibimos.Text <> "" And lblFechaTerminoRecibimos.ForeColor <> vbRed And lblFechaInicioRecibimos.ForeColor <> vbRed Then
                
                    If IsDate(txtFecPrimerVctoRecibimos.Text) Then
                    
                        If CDate(txtFecPrimerVctoRecibimos.Text) <= CDate(txtFecInicioRecibimos.Text) Then
                            MsgBox "Fecha de Primer Vencimiento no puede ser menor o igual a Fecha de Inicio", vbInformation, Msj
                            Call SugerirFechaPrimVecto(Evento)
                            txtFecPrimerVctoRecibimos.SetFocus
                            Exit Function
                            
                        ElseIf Format(txtFecPrimerVctoRecibimos.Text, "yyyymmdd") <= Format(gsBAC_Fecp, "yyyymmdd") Then
                            MsgBox "Fecha Primer Vencimiento de Amortización de Capital no puede ser menor o igual a Fecha de Proceso", vbInformation, Msj
                            txtFecPrimerVctoRecibimos.SetFocus
                            Exit Function
                        
                        ElseIf Not BacEsHabil(txtFecPrimerVctoRecibimos.Text) Then
                            MsgBox "Fecha Primer Vencimiento de Amortización de Capital no es día hábil", vbInformation, Msj
                            txtFecPrimerVctoRecibimos.SetFocus
                            Exit Function
                        
                        End If
                        
                        txtFecPrimerVctoRecibimos.Text = Format(txtFecPrimerVctoRecibimos.Text, gsc_FechaDMA)
                        lblFechaPrimerAmortRecibimos = BacFechaStr(txtFecPrimerVctoRecibimos.Text)
                        
                    Else
                        MsgBox "Fecha de Primer Vencimiento no es válida", vbInformation, Msj
                        txtFecPrimerVctoRecibimos.SetFocus
                        
                    End If
                
                End If
                 
            Case 3 'Fecha Termino
            
                If txtFecTerminoRecibimos.Text <> "" And lblFechaPrimerAmortRecibimos.ForeColor <> vbRed And lblFechaInicioRecibimos.ForeColor <> vbRed Then
                
                    If IsDate(txtFecTerminoRecibimos.Text) Then
                        txtFecTerminoRecibimos.Text = Format(txtFecTerminoRecibimos.Text, gsc_FechaDMA)
                        lblFechaTerminoRecibimos = BacFechaStr(txtFecTerminoRecibimos.Text)
                    
                        If CDate(txtFecTerminoRecibimos.Text) < CDate(txtFecPrimerVctoRecibimos.Text) Then
                            MsgBox "Fecha Termino de Operación no puede ser menor a Fecha de primer Vencimiento de Amortización de Capital", vbInformation, Msj
'                            txtFecTerminoRecibimos.SetFocus
                        Exit Function
                        
                        ElseIf Not BacEsHabil(txtFecTerminoRecibimos.Text) Then
                            MsgBox "Fecha de Término no es día hábil", vbInformation, Msj
                            txtFecTerminoRecibimos.SetFocus
                            Exit Function
                        
                        End If
                    
                    '                If Not FechaEnRango Then
                    '                    MsgBox "Fechas Definidas No concuerdan con períodos de Amortización seleccionados ", vbInformation, Msj
                    '                    txtFecTerminoRecibimos.SetFocus
                    '                    Exit Function
                    '
                    '                End If
                    
                    Else
                        MsgBox "Fecha Termino de Vencimientos no es válida", vbInformation, Msj
                        txtFecTerminoRecibimos.SetFocus
                    
                    End If
                
                End If
        
        End Select
        
    Else
    
        Select Case Cual 'Pagamos
            Case 1 'Fecha Inicio
            
                If txtFecInicioPagamos.Text <> "" Then
                
                    If IsDate(txtFecInicioPagamos.Text) Then
                        txtFecInicioPagamos.Text = Format(txtFecInicioPagamos.Text, gsc_FechaDMA)
                        txtFecInicioPagamos.Text = ValidaFecha(txtFecInicioPagamos.Text)
                        lblFechaInicioPagamos = BacFechaStr(txtFecInicioPagamos.Text)
                                           
                        Call SugerirFechaPrimVecto(Evento)
                        
                        If CDate(txtFecTerminoPagamos.Text) < CDate(txtFecPrimerVctoPagamos.Text) Then txtFecTerminoPagamos.Text = txtFecPrimerVctoPagamos.Text
                            
                    Else
                            MsgBox "Fecha de Inicio no es válida", vbInformation, Msj
                            txtFecInicioPagamos.SetFocus
                                           
                    End If
                    
                End If
                
            Case 2 'Fecha Primer Vencimiento
            
                If txtFecPrimerVctoPagamos.Text <> "" And lblFechaTerminoPagamos.ForeColor <> vbRed And lblFechaInicioPagamos.ForeColor <> vbRed Then
                
                    If IsDate(txtFecPrimerVctoPagamos.Text) Then
                    
                        If CDate(txtFecPrimerVctoPagamos.Text) <= CDate(txtFecInicioPagamos.Text) Then
                            MsgBox "Fecha de Primer Vencimiento no puede ser menor o igual a Fecha de Inicio", vbInformation, Msj
                            Call SugerirFechaPrimVecto(Evento)
                            txtFecPrimerVctoPagamos.SetFocus
                            Exit Function
'
                        ElseIf Format(txtFecPrimerVctoPagamos.Text, "yyyymmdd") <= Format(gsBAC_Fecp, "yyyymmdd") Then
                            MsgBox "Fecha Primer Vencimiento de Amortización de Capital no puede ser menor o igual a Fecha de Proceso", vbInformation, Msj
                            txtFecPrimerVctoPagamos.SetFocus
                            Exit Function
                        
                        ElseIf Not BacEsHabil(txtFecPrimerVctoPagamos.Text) Then
                            MsgBox "Fecha Primer Vencimiento de Amortización de Capital no es día hábil", vbInformation, Msj
                            txtFecPrimerVctoPagamos.SetFocus
                            Exit Function
                        
                        End If
                        
                        txtFecPrimerVctoPagamos.Text = Format(txtFecPrimerVctoPagamos.Text, gsc_FechaDMA)
                        lblFechaPrimerAmortPagamos = BacFechaStr(txtFecPrimerVctoPagamos.Text)
                        
                    Else
                        MsgBox "Fecha de Primer Vencimiento no es válida", vbInformation, Msj
                        txtFecPrimerVctoPagamos.SetFocus
                        
                    End If
                
                End If
                 
            Case 3 'Fecha Termino
            
                If txtFecTerminoPagamos.Text <> "" And lblFechaPrimerAmortPagamos.ForeColor <> vbRed And lblFechaInicioPagamos.ForeColor <> vbRed Then
                
                    If IsDate(txtFecTerminoPagamos.Text) Then
                        txtFecTerminoPagamos.Text = Format(txtFecTerminoPagamos.Text, gsc_FechaDMA)
                        lblFechaTerminoPagamos = BacFechaStr(txtFecTerminoPagamos.Text)
                    
                        If CDate(txtFecTerminoPagamos.Text) < CDate(txtFecPrimerVctoPagamos.Text) Then
                            MsgBox "Fecha Termino de Operación no puede ser menor a Fecha de primer Vencimiento de Amortización de Capital", vbInformation, Msj
'                            txtFecTerminoPagamos.SetFocus
                            Exit Function
                        
                        ElseIf Not BacEsHabil(txtFecTerminoPagamos.Text) Then
                            MsgBox "Fecha de Término no es día hábil", vbInformation, Msj
                            txtFecTerminoPagamos.SetFocus
                            Exit Function
                        
                        End If
                    
                    '                If Not FechaEnRango Then
                    '                    MsgBox "Fechas Definidas No concuerdan con períodos de Amortización seleccionados ", vbInformation, Msj
                    '                    txtFecTerminoRecibimos.SetFocus
                    '                    Exit Function
                    '
                    '                End If
                    
                    Else
                        MsgBox "Fecha Termino de Vencimientos no es válida", vbInformation, Msj
                        txtFecTerminoPagamos.SetFocus
                    
                    End If
                
                End If
        
        End Select
        
    End If
    ValidaFechasIngreso = True

End Function

Private Sub btnCalcular_Click()

    Dim I As Integer
    
    If ValidaDatos Then
        
        Me.MousePointer = vbHourglass
        
        Call CalculoInteresModificado("C")
        Call CalculoInteresModificado("V")
               
        tabFlujos.TabEnabled(1) = True
        tabFlujos.TabEnabled(2) = True
        Toolbar1.Buttons(2).Enabled = True
        
        Me.MousePointer = vbDefault
    Else
        Toolbar1.Buttons(2).Enabled = False
    End If

End Sub

Private Sub btnGrabar_Click()
    Dim m
    
    'Validacion de datos faltantes para grabar datos
    Me.MousePointer = vbHourglass
    
    If Not ValidaDatosIngreso Then
        Me.MousePointer = vbDefault
        Exit Sub
    End If
    
    '*** Proceso de Almacenamiento de datos
    'GrabarDatos
    BacGrabar.MiTipoSwap = MiTipoSwap
    BacGrabar.Show vbModal
    
    Me.MousePointer = vbDefault
    
    If GLB_bCancelar = False And cOperSwapST = "Ingreso" Then
       Call LimpiarDatos
    ElseIf GLB_bCancelar = False And cOperSwapST = "Modificacion" Then
       Unload Me
    End If
        
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
    
    If Val(txtCapital.Text) <= 0 Then
        MsgBox "Monto Capital debe ser Mayor a CERO", vbInformation, Msj
        txtCapital.SetFocus
        Exit Function
        
    End If
        
    If cmbTasaCompra.ListIndex = -1 Then
        MsgBox "Debe seleccionar el tipo de Tasa en Recibimos", vbInformation, Msj
        cmbTasaCompra.SetFocus
        Exit Function
        
    End If
    
'    If CDbl(txtTasaCompra.Text) = 0 Then
'        MsgBox "Debe ingresar Monto Tasa Compra", vbInformation, Msj
'        txtTasaCompra.SetFocus
'        Exit Function
'
    If Not IsNumeric(txtTasaCompra.Text) Then
        MsgBox "Monto de Tasa está Incorrecto!", vbInformation, Msj
        txtTasaCompra.SetFocus
        Exit Function
        
    End If
    
    If cmbBaseCompra.ListIndex = -1 Then
        MsgBox "Debe seleccionar Base Tasa en Compras", vbInformation, Msj
        cmbBaseCompra.SetFocus
        Exit Function
        
    End If
    
    If cmbAmortizaCapitalRecibimos.ListIndex = -1 Then
        MsgBox "Debe seleccionar Opción de Amortización de Capital Recibimos", vbInformation, Msj
        cmbAmortizaCapitalRecibimos.SetFocus
        Exit Function
        
    End If
    
    If cmbAmortizaCapitalPagamos.ListIndex = -1 Then
        MsgBox "Debe seleccionar Opción de Amortización de Capital Pagamos", vbInformation, Msj
        cmbAmortizaCapitalPagamos.SetFocus
        Exit Function
        
    End If
    
    'Venta
    If cmbTasaVenta.ListIndex = -1 Then
        MsgBox "Debe seleccionar el tipo de Tasa en Pagamos", vbInformation, Msj
        cmbTasaVenta.SetFocus
        Exit Function
        
    End If
    
'    If CDbl(txtTasaVenta.Text) = 0 Then
'        MsgBox "Debe ingresar Monto Tasa Venta", vbInformation, Msj
'        txtTasaVenta.SetFocus
'        Exit Function
'
    If Not IsNumeric(txtTasaVenta.Text) Then
        MsgBox "Monto de Tasa Venta está Incorrecto!", vbInformation, Msj
        txtTasaVenta.SetFocus
        Exit Function
        
    End If
    
    If cmbBaseVenta.ListIndex = -1 Then
        MsgBox "Debe seleccionar Base Tasa en Venta", vbInformation, Msj
        cmbBaseVenta.SetFocus
        Exit Function
        
    End If
    
    If cmbAmortizaInteresRecibimos.ListIndex = -1 Then
        MsgBox "Debe seleccionar Opción de Amortización de Interés Recibimos", vbInformation, Msj
        cmbAmortizaInteresRecibimos.SetFocus
        Exit Function
        
    End If
    
    If cmbAmortizaInteresPagamos.ListIndex = -1 Then
        MsgBox "Debe seleccionar Opción de Amortización de Interés Pagamos", vbInformation, Msj
        cmbAmortizaInteresPagamos.SetFocus
        Exit Function
        
    End If
        
    If txtFecInicioRecibimos.Text = "" Then
        MsgBox "Debe ingresar Fecha Inicio Recibimos de Contrato", vbInformation, Msj
        txtFecInicioRecibimos.SetFocus
        Exit Function
        
    ElseIf Not IsDate(txtFecInicioRecibimos.Text) Then
        MsgBox "Fecha Inicio Recibimos de Contrato está Incorrecta!", vbInformation, Msj
        txtFecInicioRecibimos.SetFocus
        Exit Function
        
    ElseIf Not BacEsHabil(txtFecInicioRecibimos.Text) Then
        MsgBox "Fecha de Inicio Recibimos no es día hábil", vbInformation, Msj
        txtFecInicioRecibimos.SetFocus
        Exit Function
        
    End If
    
    
    If txtFecInicioPagamos.Text = "" Then
        MsgBox "Debe ingresar Fecha Inicio Pagamos de Contrato", vbInformation, Msj
        txtFecInicioPagamos.SetFocus
        Exit Function
        
    ElseIf Not IsDate(txtFecInicioPagamos.Text) Then
        MsgBox "Fecha Inicio Pagamos de Contrato está Incorrecta!", vbInformation, Msj
        txtFecInicioPagamos.SetFocus
        Exit Function
        
    ElseIf Not BacEsHabil(txtFecInicioPagamos.Text) Then
        MsgBox "Fecha de Inicio Pagamos no es día hábil", vbInformation, Msj
        txtFecInicioPagamos.SetFocus
        Exit Function
        
    End If
    
    If txtFecTerminoRecibimos.Text = "" Then
        MsgBox "Debe ingresar Fecha Recibimos Termino de Contrato", vbInformation, Msj
        txtFecTerminoRecibimos.SetFocus
        Exit Function
        
    ElseIf Not IsDate(txtFecTerminoRecibimos.Text) Then
        MsgBox "Fecha Termino Recibimos de Contrato está Incorrecta!", vbInformation, Msj
        txtFecTerminoRecibimos.SetFocus
        Exit Function
        
    ElseIf Not BacEsHabil(txtFecTerminoRecibimos.Text) Then
        MsgBox "Fecha de Término Recibimos no es día hábil", vbInformation, Msj
        txtFecTerminoRecibimos.SetFocus
        Exit Function
        
    End If
    
    If txtFecTerminoPagamos.Text = "" Then
        MsgBox "Debe ingresar Fecha Pagamos Termino de Contrato", vbInformation, Msj
        txtFecTerminoPagamos.SetFocus
        Exit Function
        
    ElseIf Not IsDate(txtFecTerminoPagamos.Text) Then
        MsgBox "Fecha Termino Pagamos de Contrato está Incorrecta!", vbInformation, Msj
        txtFecTerminoPagamos.SetFocus
        Exit Function
        
    ElseIf Not BacEsHabil(txtFecTerminoPagamos.Text) Then
        MsgBox "Fecha de Término Pagamos no es día hábil", vbInformation, Msj
        txtFecTerminoPagamos.SetFocus
        Exit Function
        
    End If
        
    If txtFecTerminoRecibimos.Text = txtFecInicioRecibimos.Text Then
        MsgBox "Fecha de Inicio  y Fecha de término no pueden ser iguales en Recibimos", vbInformation, Msj
        txtFecTerminoRecibimos.SetFocus
        Exit Function
        
    End If
    
     If txtFecTerminoPagamos.Text = txtFecInicioPagamos.Text Then
        MsgBox "Fecha de Inicio  y Fecha de término no pueden ser iguales en Pagamos", vbInformation, Msj
        txtFecTerminoPagamos.SetFocus
        Exit Function
        
    End If
    
'    If Not FechaEnRango Then
'        MsgBox "Fechas definidas NO Concuerdan con períodos de Amortización Seleccionado", vbInformation, Msj
'        txtFecTerminoRecibimos.SetFocus
'        Exit Function
'        End If
    
    ValidaDatos = True
    
End Function

Function ValidaDatosIngreso() As Boolean

    ValidaDatosIngreso = False
    
    If Not ChequeaCierreMesa() Then
      MsgBox "No se puede Grabar Operacion, Mesa de Dinero está Cerrada!!!", vbExclamation, Msj
      Exit Function
    End If
   
    If cmbMoneda.ListIndex = -1 Then
        MsgBox "Debe Seleccionar Moneda de la Operacion", vbInformation, Msj
        cmbMoneda.SetFocus
        Exit Function
    End If
    
    If cmbMonedaRecibimos.ListIndex = -1 Then
        MsgBox "Debe seleccionar Moneda Recibimos ", vbInformation, Msj
        cmbMonedaRecibimos.SetFocus
        Exit Function
    End If
    
    If cmbDocumentoRecibimos.ListIndex = -1 Then
        MsgBox "Debe seleccionar Documento Pagamos ", vbInformation, Msj
        cmbDocumentoRecibimos.SetFocus
        Exit Function
    End If
        
    If cmbMonedaPagamos.ListIndex = -1 Then
        MsgBox "Debe seleccionar Moneda Pagamos ", vbInformation, Msj
        cmbMonedaPagamos.SetFocus
        Exit Function
    End If
    
    If cmbDocumentoPagamos.ListIndex = -1 Then
        MsgBox "Debe seleccionar Documento Pagamos ", vbInformation, Msj
        cmbDocumentoPagamos.SetFocus
        Exit Function
    End If
 
    If Me.tabFlujos.TabEnabled(1) = False Then
        MsgBox "Debe realizar Calculo de Flujos!", vbCritical, Msj
        Exit Function
    End If
  
    ValidaDatosIngreso = True

End Function

Function Destaca(ByRef Texto As TextBox)
    Texto.SelStart = 0
    Texto.SelLength = Len(Texto)   ' se establece la longitud para seleccionar.

End Function


Function LLenafgrdFlujos()
Dim I As Integer
Dim Grilla As Object
Dim Cmbcapital As Object
Dim cmbinteres As Object

    If tabFlujos.Tag = "Pagamos" Then
        Set Grilla = grdPagamos
        Set Cmbcapital = cmbAmortizaCapitalRecibimos
        Set cmbinteres = cmbAmortizaInteresRecibimos

    ElseIf tabFlujos.Tag = "Recibimos" Then
        Set Grilla = grdRecibimos
        Set Cmbcapital = cmbAmortizaCapitalPagamos
        Set cmbinteres = cmbAmortizaInteresPagamos
        
    End If
    
    With Grilla
        .Cols = 15
        'columnas visibles
        .TextMatrix(0, 0) = "Nro."
        .TextMatrix(0, 1) = "Vencimiento"
        .TextMatrix(0, 2) = Trim("Amortización " & Trim(Mid(Cmbcapital, 1, 50)))
        .TextMatrix(0, 3) = "Tasa+Spread"
        .TextMatrix(0, 4) = Trim("Interés " & Trim(Mid(cmbinteres, 1, 50)))
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
        .TextMatrix(0, 14) = "Ingreso Tasa"
        
        .ColWidth(0) = TextWidth(" 99 ")
        .ColWidth(1) = 1280
        .ColWidth(2) = TextWidth("999,999,999,999.9999")
        .ColWidth(3) = TextWidth("   999.9999")
        .ColWidth(4) = 2000
        .ColWidth(5) = TextWidth("999,999,999,999.9999")
        .ColWidth(6) = 1440
        'acaca
        .ColWidth(7) = 0
        .ColWidth(8) = 0
        .ColWidth(9) = 0
        .ColWidth(10) = 0
        .ColWidth(11) = 0
        .ColWidth(12) = 0
        .ColWidth(13) = 0
        .ColWidth(14) = 1280
        
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



Private Sub cmbAmortizaCapitalrecibimos_Click()

    '***Para cancelar que modifiquen columna
    If cmbAmortizaCapitalRecibimos.ListIndex <> -1 Then
        TipoAm = ValorAmort(cmbAmortizaCapitalRecibimos, DesgloseAmortST)
    End If

End Sub

Private Sub cmbAmortizaCapitalrecibimos_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then cmbAmortizaInteresRecibimos.SetFocus

End Sub

Private Sub cmbAmortizaInteresPagamos_Click()
   Call CargaTasaMoneda(cmbTasaVenta, SacaCodigo(cmbMoneda), 0, Val(Right(cmbAmortizaInteresPagamos.Text, 5)))
End Sub

Private Sub cmbAmortizaInteresPagamos_LostFocus()
        Dim Valor As Double

         If cmbAmortizaInteresPagamos.ListIndex <> -1 Then
         
            If CDbl(cmbAmortizaInteresPagamos.Tag) = SacaCodigo(cmbAmortizaInteresPagamos) Then Exit Sub
        
'para cambios de tasas
           Call CargaTasaMoneda(cmbTasaVenta, SacaCodigo(cmbMoneda), 0, Val(Right(cmbAmortizaInteresPagamos.Text, 5)))
           
          ' Call LlenaComboTasas(2, _
          '              SacaCodigo(cmbMoneda), _
          '             1042, _
          '             IIf(OperSwap = "ModificacionCartera", Format(FechaCierre, "yyyymmdd"), Format(gsBAC_Fecp, "yyyymmdd")), _
          '             Val(Trim(Right(cmbAmortizaInteresPagamos, 10))))
                       
            Valor = ValorTasaPeriodo(ValorTasasMon(), _
                                    SacaCodigo(cmbTasaVenta), _
                                      Val(Trim(Right(cmbAmortizaInteresPagamos, 10))), _
                                      TotTasasMon)
                                      
            If CDbl(txtTasaVenta.Text) <> Valor And cOperSwapST = "Ingreso" Then
               txtTasaVenta.Text = Valor
               txtTasaVenta.Tag = Valor
            End If
   
            cmbAmortizaInteresPagamos.Tag = SacaCodigo(cmbAmortizaInteresPagamos)
            
        Else
        
            If CDbl(txtTasaVenta.Text) <> 0 Then
                txtTasaVenta.Tag = 0
                txtTasaVenta.Text = 0
            End If
        
        End If
    

End Sub

Private Sub cmbAmortizaInteresRecibimos_Click()
   Call CargaTasaMoneda(cmbTasaCompra, SacaCodigo(cmbMoneda), 0, Val(Right(cmbAmortizaInteresRecibimos.Text, 5)))
End Sub

Private Sub cmbAmortizaInteresRecibimos_GotFocus()
   cmbAmortizaInteresRecibimos.Tag = SacaCodigo(cmbAmortizaInteresRecibimos)

End Sub

Private Sub cmbAmortizaInteresRecibimos_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then txtFecInicioRecibimos.SetFocus

End Sub

Private Sub cmbAmortizaInteresRecibimos_LostFocus()
Dim Valor As Double

         If cmbAmortizaInteresRecibimos.ListIndex <> -1 Then
         
            If CDbl(cmbAmortizaInteresRecibimos.Tag) = SacaCodigo(cmbAmortizaInteresRecibimos) Then Exit Sub
            
'para cargar de acuerdo al plazo
            Call CargaTasaMoneda(cmbTasaCompra, SacaCodigo(cmbMoneda), 0, Val(Right(cmbAmortizaInteresRecibimos.Text, 5)))
           
           'Call LlenaComboTasas(1, _
           '             SacaCodigo(cmbMoneda), _
           '            1042, _
           '            IIf(OperSwap = "ModificacionCartera", Format(FechaCierre, "yyyymmdd"), Format(gsBAC_Fecp, "yyyymmdd")), _
           '            Val(Trim(Right(cmbAmortizaInteresRecibimos, 10))))
           
            Valor = ValorTasaPeriodo(ValorTasasMon(), _
                                    SacaCodigo(cmbTasaCompra), _
                                    Val(Trim(Right(cmbAmortizaInteresRecibimos, 10))), _
                                    TotTasasMon)
   
            If CDbl(txtTasaCompra.Text) <> Valor And cOperSwapST = "Ingreso" Then
                txtTasaCompra.Tag = Valor
                txtTasaCompra.Text = Valor
            End If
            
   
            cmbAmortizaInteresRecibimos.Tag = SacaCodigo(cmbAmortizaInteresRecibimos)
            
        Else
            
            If CDbl(txtTasaCompra.Text) <> 0 Then
                txtTasaCompra.Tag = 0
                txtTasaCompra.Text = 0
            End If
        
        End If
    
End Sub

Private Sub cmbBaseCompra_Click()
    'Posiciona base ventas de acuerdo a base compras
    Call bacBuscarCombo(cmbBaseVenta, SacaCodigo(cmbBaseCompra))
    
End Sub

Private Sub cmbBaseCompra_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then cmbMonedaRecibimos.SetFocus

End Sub

Private Sub cmbBaseVenta_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then cmbMonedaPagamos.SetFocus

End Sub

Private Sub cmbDocumentoPagamos_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then cmbAmortizaCapitalRecibimos.SetFocus

End Sub

Private Sub cmbDocumentoRecibimos_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then cmbTasaVenta.SetFocus

End Sub

Private Sub cmbEspecialRecibimos_Click()

    If cmbEspecialRecibimos.ListIndex < 0 Then
        cmbEspecialRecibimos.ListIndex = 0
    End If
    
    If Not txtFecPrimerVctoRecibimos.Visible Then
        txtFecPrimerVctoRecibimos.Text = txtFecInicioRecibimos.Text
    End If
    
    txtFecPrimerVctoRecibimos.Enabled = (cmbEspecialRecibimos.ItemData(cmbEspecialRecibimos.ListIndex) > 0)
    txtFecPrimerVctoRecibimos.Visible = txtFecPrimerVctoRecibimos.Enabled
    lblFechaPrimerAmortRecibimos.Visible = txtFecPrimerVctoRecibimos.Enabled
    
End Sub

Private Sub cmbModalidad_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        With grdRecibimos
        If .Col = 6 Then
            .TextMatrix(.Row, 6) = cmbModalidad
            grdPagamos.TextMatrix(.Row, 6) = cmbModalidad
        End If
        cmbModalidad.Visible = False
        .SetFocus
        End With
    End If

End Sub

Private Sub cmbModalidadPag_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        With grdPagamos
        If .Col = 6 Then
            .TextMatrix(.Row, 6) = cmbModalidadPag
            grdRecibimos.TextMatrix(.Row, 6) = cmbModalidadPag
        End If
        cmbModalidadPag.Visible = False
        .SetFocus
        End With
    End If
    
End Sub

Private Sub cmbMoneda_Click()
   Dim CodMon        As Integer
   Dim PeriRecibimos As Integer
   Dim PeriPagamos   As Integer

   If cmbMoneda.ListIndex = -1 Then
      Exit Sub
   End If
   CodMon = SacaCodigo(cmbMoneda)
    
   If CodMon = 999 Then
      txtCapital.CantidadDecimales = 0
   Else
      txtCapital.CantidadDecimales = 4
   End If
   TxtValorMoneda = Format(ValorMoneda(CodMon, gsBAC_Fecp), "###,###,##0.###0")
   PeriRecibimos = 0
   PeriPagamos = 0
    
   If cmbAmortizaInteresRecibimos.ListIndex <> -1 Then
      PeriRecibimos = Val(Trim(Right(cmbAmortizaInteresRecibimos, 10)))
   End If
   If cmbAmortizaInteresPagamos.ListIndex <> -1 Then
      PeriPagamos = Val(Trim(Right(cmbAmortizaInteresPagamos, 10)))
   End If
    
   Call LlenaComboTasas(1, CodMon, 1042, IIf(OperSwap = "ModificacionCartera", Format(FechaCierre, "yyyymmdd"), Format(gsBAC_Fecp, "yyyymmdd")), PeriRecibimos)
   Call LlenaComboTasas(2, CodMon, 1042, IIf(OperSwap = "ModificacionCartera", Format(FechaCierre, "yyyymmdd"), Format(gsBAC_Fecp, "yyyymmdd")), PeriPagamos)
    
        
   Call CargaMonedaPago(cmbMonedaRecibimos, CodMon)
   Call CargaMonedaPago(cmbMonedaPagamos, CodMon)
        
   'Call LlenaMonDocPago(cmbMonedaRecibimos, DatosPorMoneda(), 1, CodMon, TotDatPorMon, 1)
   'Call LlenaMonDocPago(cmbMonedaPagamos, DatosPorMoneda(), 1, CodMon, TotDatPorMon, 1)
                    
   cmbDocumentoPagamos.Clear
   cmbDocumentoRecibimos.Clear
    
   If MiTipoSwap = [Swap Promedio Camara] Then
      Call CargaTasaMoneda(cmbTasaVenta, SacaCodigo(cmbMoneda), 0, Val(Right(cmbAmortizaInteresPagamos.Text, 5)))
      Call CargaTasaMoneda(cmbTasaCompra, SacaCodigo(cmbMoneda), 0, Val(Right(cmbAmortizaInteresRecibimos.Text, 5)))
      If cmbTasaCompra.ListIndex <> -1 Then cmbTasaCompra.Text = "ICP"
      If cmbTasaVenta.ListIndex <> -1 Then cmbTasaVenta.Text = "FIJA"
   End If
End Sub

Private Sub CargaMonedaPago(objCarga As ComboBox, iMoneda As Integer)
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, "PCS"
   AddParam Envia, iMoneda
   If Not Bac_Sql_Execute("SP_CARGA_MONEDA_PAGO", Envia) Then
      Exit Sub
   End If
   objCarga.Clear
   Do While Bac_SQL_Fetch(Datos())
      objCarga.AddItem Datos(2)
      objCarga.ItemData(objCarga.NewIndex) = Val(Datos(1))
   Loop
End Sub
Private Sub CargaFPagoxMoneda(objCarga As ComboBox, iMoneda As Integer)
   Envia = Array()
   AddParam Envia, "PCS"
   AddParam Envia, iMoneda
   AddParam Envia, CDbl(2)
   If Not Bac_Sql_Execute("SP_MONEDA_DOC_PAGO", Envia) Then
      Exit Sub
   End If
   objCarga.Clear
   Do While Bac_SQL_Fetch(Datos())
      objCarga.AddItem Datos(2)
      objCarga.ItemData(objCarga.NewIndex) = Val(Datos(1))
   Loop
End Sub
Private Sub cmbMoneda_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then txtCapital.SetFocus

End Sub

Private Sub cmbMonedaPagamos_Click()

    If optEntFisica.Value = True Then
        'SI ES ENTREGA FISICA SE RECIBE Y SE PAGA EN LA MISMA MONEDA
        cmbMonedaRecibimos.ListIndex = cmbMonedaPagamos.ListIndex
    End If
    
    'Call LlenaMonDocPago(cmbDocumentoPagamos, DatosPorMoneda(), _
                                           cmbMonedaPagamos.Tag, _
                                           SacaCodigo(cmbMonedaPagamos), TotDatPorMon, 2)
    Call CargaFPagoxMoneda(cmbDocumentoPagamos, SacaCodigo(cmbMonedaPagamos))
                                           
End Sub

Private Sub cmbMonedaPagamos_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then cmbDocumentoPagamos.SetFocus

End Sub

Private Sub cmbMonedaRecibimos_Click()

    If optEntFisica.Value = True Then
        'SI ES ENTREGA FISICA SE RECIBE Y SE PAGA EN LA MISMA MONEDA
        cmbMonedaPagamos.ListIndex = cmbMonedaRecibimos.ListIndex
    End If
    
     'Call LlenaMonDocPago(cmbDocumentoRecibimos, DatosPorMoneda(), _
                                           cmbMonedaRecibimos.Tag, _
                                           SacaCodigo(cmbMonedaRecibimos), TotDatPorMon, 2)
    Call CargaFPagoxMoneda(cmbDocumentoRecibimos, SacaCodigo(cmbMonedaRecibimos))
    
End Sub

Private Sub cmbMonedaRecibimos_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then cmbDocumentoRecibimos.SetFocus
    
End Sub

Private Sub cmbTasaCompra_Click()
Dim ValTasa As Double

   lblValorIcpCompra.Visible = False
   If cmbAmortizaInteresRecibimos.ListIndex <> -1 Then
      If cmbTasaCompra.ListIndex <> -1 Then
         ValTasa = ValorTasaPeriodo(ValorTasasMon(), cmbTasaCompra.ItemData(cmbTasaCompra.ListIndex), Val(Trim(Right(cmbAmortizaInteresRecibimos, 10))), TotTasasMon)
      Else
         ValTasa = 0#
         txtTasaCompra.Text = ValTasa
      End If
      If CDbl(txtTasaCompra.Text) = 0 Then
         txtTasaCompra.Tag = ValTasa
         txtTasaCompra.Text = txtTasaCompra.Tag
      End If
      If cmbTasaCompra.Text = "FIJA" Then
         Operacion = "C"
      Else
         Operacion = "V"
      End If
   Else
      txtTasaCompra.Tag = 0
      txtTasaCompra.Text = 0
   End If
    
    txtTasaCompra.Enabled = True

   If MiTipoSwap = [Swap Promedio Camara] Then
      If cmbTasaCompra.Text = "ICP" Then
         If cmbTasaVenta.Text = "ICP" Then
           On Error Resume Next
           cmbTasaVenta.Text = "FIJA"
           txtTasaVenta.Text = 0#
           Call objMoneda.CargaBases(cmbBaseVenta)
           On Error GoTo 0
         End If
         If cmbMoneda.ListIndex > -1 Then
            lblValorIcpCompra.Caption = iValorIndiceCamaraPromedio
            txtTasaCompra.Text = iValorTasaCamaraPromedio(cmbMoneda.ItemData(cmbMoneda.ListIndex))
            txtTasaCompra.Enabled = False
            lblValorIcpCompra.Visible = True
         End If
      End If
      If Me.cmbTasaCompra.Text = "ICP" Then
         Call objMoneda.CargaBases(cmbBaseCompra, OP_SWAP_PROMCAM)
      Else
         Call objMoneda.CargaBases(cmbBaseCompra)
      End If
   End If

End Sub

Private Sub cmbTasaCompra_LostFocus()
   On Error Resume Next
   Me.Refresh
   If MiTipoSwap = [Swap Promedio Camara] Then
      If cmbTasaCompra.Text <> "ICP" And cmbTasaVenta.Text <> "ICP" Then
         cmbTasaCompra.Text = "ICP"
      End If
   End If
   On Error GoTo 0
End Sub

Private Sub cmbTasaCompra_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then txtTasaCompra.SetFocus

End Sub

Private Sub cmbTasaVenta_Click()
Dim ValTasa As Double
    
   lblValorIcpVenta.Visible = False
   
   If cmbAmortizaInteresRecibimos.ListIndex <> -1 Then
      If cmbTasaVenta.ListIndex <> -1 Then
         If cmbTasaVenta.ListIndex <> -1 Then
            ValTasa = ValorTasaPeriodo(ValorTasasMon(), cmbTasaVenta.ItemData(cmbTasaVenta.ListIndex), Val(Trim(Right(cmbAmortizaInteresRecibimos, 10))), TotTasasMon)
         Else
            ValTasa = 0#
            txtTasaVenta.Text = ValTasa
         End If
         If CDbl(txtTasaVenta.Text) = 0 Then '<> CDbl(ValTasa) Then  ' And OperSwap = "Ingreso" Then
            txtTasaVenta.Tag = ValTasa
            txtTasaVenta.Text = ValTasa
         End If
         If cmbTasaVenta.Text = "FIJA" Then
            Operacion = "V"
         Else
            Operacion = "C"
         End If
      Else
         txtTasaVenta.Tag = 0
         txtTasaVenta.Text = txtTasaVenta.Tag
      End If
   Else
      txtTasaVenta.Tag = 0
      txtTasaVenta.Text = 0
   End If
   txtTasaVenta.Enabled = True
    

   If MiTipoSwap = [Swap Promedio Camara] Then
      If cmbTasaVenta.Text = "ICP" Then
         If cmbTasaCompra.Text = "ICP" Then
            On Error Resume Next
            cmbTasaCompra.Text = "FIJA"
            txtTasaCompra.Text = 0#
            Call objMoneda.CargaBases(cmbBaseCompra)
            On Error GoTo 0
         End If
         If cmbMoneda.ListIndex > -1 Then
            lblValorIcpVenta.Caption = iValorIndiceCamaraPromedio
            txtTasaVenta.Text = iValorTasaCamaraPromedio(cmbMoneda.ItemData(cmbMoneda.ListIndex))
            txtTasaVenta.Enabled = False
            lblValorIcpVenta.Visible = True
         End If
      End If
      If Me.cmbTasaVenta.Text = "ICP" Then
         Call objMoneda.CargaBases(cmbBaseVenta, OP_SWAP_PROMCAM)
      Else
         Call objMoneda.CargaBases(cmbBaseVenta)
      End If
   End If

    
End Sub

Private Sub cmbTasaVenta_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then txtTasaVenta.SetFocus

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
Sub SacarValoresSWTasa(cadena As String)
   
'''''    cadena = 1 & "; " & "Cartera: " & (SacaCodigo(cmbCarteraInversion)) & ";" _
'''''    & "Tipo Op: " & Operacion & ";" _
'''''    & "Cod Cliente: " & IIf(TxtCliente.Tag = "", 0, TxtCliente.Tag) & ";" & "Rut Cli: " & TxtRut.Text & ";" _
'''''    & "CMoneda: " & Trim(cmbMoneda) & ";" _
'''''    & "CCapital: " & txtCapital.Text & ";" _
'''''    & "Fecha Cierre: " & FechaCierre & ";" & "Fecha Inicio: " & txtFecInicioRecibimos.Text & ";" & "FechaTermino: " & txtFecTerminoRecibimos.Text & ";" _
'''''    & "CAmoCapital:" & Trim(Left(cmbAmortizaCapitalRecibimos, 30)) & ";" _
'''''    & "CAmoInteres:" & Trim(Left(cmbAmortizaInteresRecibimos, 30)) & ";" _
'''''    & "CBase:" & cmbBaseCompra & ";" _
'''''    & "VMoneda:" & Trim(cmbMoneda) & ";" _
'''''    & "VCapital:" & txtCapital.Text & ";" _
'''''    & "VAmoCapital:" & Trim(Left(cmbAmortizaCapitalPagamos, 30)) & ";" _
'''''    & "VAmoInteres:" & Trim(Left(cmbAmortizaInteresPagamos, 30)) & ";" _
'''''    & "VBase :" & cmbBaseVenta & ";" _
'''''    & "Operador :" & Left(gsBAC_User$, 10) & ";" & "Cod Oper :" & SacaCodigo(CmbOperador) & ";" _
'''''     & "CValorTasa :" & txtTasaCompra.Text & ";" _
'''''    & "VValorTasa :" & txtTasaVenta.Text & ";" _
'''''    & "PagMoneda :" & Trim(cmbMonedaPagamos) & ";" & "PagDocumento :" & Trim(cmbDocumentoPagamos) & ";" _
'''''    & "RecMoneda :" & Trim(cmbMonedaRecibimos) & ";" & "RecDocumento :" & Trim(cmbDocumentoRecibimos) & ";" _
'''''    & "FechaModifica :" & gsBAC_Fecp
    
    'IIf(optCompra.Value = True, "C", "V")
End Sub

Private Sub Form_Activate()
   If MiTipoSwap = [Swap Promedio Camara] Then
       Tipo_Producto = "SP"
   Else
       Tipo_Producto = "ST"
   End If
   
   Set oFormulario = Me
    
End Sub
Private Sub Form_Load()
On Error GoTo Control:

Dim Frase As String
Dim Cont As Integer

   MiTipoSwap = MiTipoSwapTasa
   If MiTipoSwap = [Swap Promedio Camara] Then
       Tipo_Producto = "SP"
   Else
       Tipo_Producto = "ST"
   End If

    Cont = 0
    cOperSwapST = swOperSwap
    nNumoperST = swModNumOpe
    Lbl_Num_Oper_Oculto.Caption = swModNumOpe
    swOperSwap = ""
    'Tipo_Producto = "ST"
    '------------- Monedas
    Cont = Cont + 1
    If MiTipoSwap = [Swap de Tasas] Then
      Call objMoneda.CargaxProducto(OP_SWAP_TASAS, cmbMoneda)
    Else
      Call objMoneda.CargaxProducto(OP_SWAP_PROMCAM, cmbMoneda)
    End If

    
    objMoneda.CargaBases cmbBaseCompra
    objMoneda.CargaBases cmbBaseVenta
    
    '------------- Tasas
    Cont = Cont + 1
    Call LlenaComboCodGeneral(cmbTasaVenta, 1042, Sistema, 1)
    
    '------------- Bases
    Cont = Cont + 1
    Call MonYDocxMoneda(DatosPorMoneda(), TotDatPorMon)
    
    '------------ Tipos de Amortizacion
    Cont = Cont + 1
    Call LlenaComboAmortiza(cmbAmortizaInteresRecibimos, 1044, Sistema)
    Call LlenaComboAmortiza(cmbAmortizaInteresPagamos, 1044, Sistema)
    Cont = Cont + 1
    Call LlenaComboAmortiza(cmbAmortizaCapitalRecibimos, 1043, Sistema)
    Call LlenaComboAmortiza(cmbAmortizaCapitalPagamos, 1043, Sistema)
    
    '------------ Tipos de Amortizacion
    Cont = Cont + 1
    'Call LlenaComboCodGeneral(cmbCarteraInversion, 1004, Sistema, 1)
        
    cmbModalidad.AddItem "Compensación" & Space(50) & "C"
    cmbModalidad.AddItem "Ent. Física " & Space(50) & "E"
    cmbModalidadPag.AddItem "Compensación" & Space(50) & "C"
    cmbModalidadPag.AddItem "Ent. Física " & Space(50) & "E"
    
     '------------ Amortización Especial Recibimos
    cmbEspecialRecibimos.Clear
    cmbEspecialRecibimos.AddItem "Normal ": cmbEspecialRecibimos.ItemData(cmbEspecialRecibimos.NewIndex) = 0
    cmbEspecialRecibimos.AddItem "Capital": cmbEspecialRecibimos.ItemData(cmbEspecialRecibimos.NewIndex) = 1
    cmbEspecialRecibimos.AddItem "Interes": cmbEspecialRecibimos.ItemData(cmbEspecialRecibimos.NewIndex) = 2
    cmbEspecialRecibimos.ListIndex = 0
    
     '------------ Amortización Especial Pagamos
    cmbEspecialPagamos.Clear
    cmbEspecialPagamos.AddItem "Normal ": cmbEspecialPagamos.ItemData(cmbEspecialPagamos.NewIndex) = 0
    cmbEspecialPagamos.AddItem "Capital": cmbEspecialPagamos.ItemData(cmbEspecialPagamos.NewIndex) = 1
    cmbEspecialPagamos.AddItem "Interes": cmbEspecialPagamos.ItemData(cmbEspecialPagamos.NewIndex) = 2
    cmbEspecialPagamos.ListIndex = 0
       
    Call LimpiarDatos
    
    lblSwapTasa(22).Visible = False
    Simbologia.Visible = False
    
    Me.Top = 60
    Me.Left = 100
       
    txtTasa.Width = TextWidth(" 999.999999 ")
    txtTasaPag.Width = TextWidth(" 999.999999 ")
    
    If cOperSwapST = "Ingreso" Then
        tabFlujos.Tag = "Recibimos"
        Call LLenafgrdFlujos
        tabFlujos.Tag = "Pagamos"
        Call LLenafgrdFlujos
        etqNumOper.Visible = False
        Toolbar1.Buttons(2).Enabled = False
        Call BuscaCmbAmortiza(cmbAmortizaCapitalRecibimos, 6)
        Call BuscaCmbAmortiza(cmbAmortizaInteresRecibimos, 3)
        Call BuscaCmbAmortiza(cmbAmortizaCapitalPagamos, 6)
        Call BuscaCmbAmortiza(cmbAmortizaInteresPagamos, 3)

        ValorDolarObs = gsBAC_DolarObs
    Else
        'Modificaciones
        etqNumOper.Visible = True
        Call BuscarDatos
        Call SacarValoresSWTasa(ValorAnt)
        tabFlujos.TabEnabled(1) = True
        tabFlujos.TabEnabled(2) = True

        Dim ValMonedas As New ClsMoneda
    
        With ValMonedas
        If .ValorMoneda(994, CStr(FechaCierre)) Then
            ValorDolarObs = .vmValor    'valor dolar obs. para convertir monto
        End If
        End With
        
        Set ValMonedas = Nothing
    
        If cOperSwapST = "ModificacionCartera" Then
            Call Deshabilitar
        End If
    
         If Not ChequeaCierreMesa() Then
            Toolbar1.Buttons(1).Enabled = False
            Toolbar1.Buttons(2).Enabled = False
            Toolbar1.Buttons(3).Enabled = False
            MsgBox "Operacion no puede ser Modificada. Mesa ha cerrado!! "
         End If

    End If
     
Exit Sub

Control:

    If err = 380 Then
        Frase = "No se pudo asignar datos en "
        Select Case Cont
            
            Case 1
                Frase = Frase & "Monedas Producto"
            Case 2
                Frase = Frase & "Tasas"
            Case 3
                Frase = Frase & "Base Compra"
            Case 4
                Frase = Frase & "Base Venta"
            Case 5
                Frase = Frase & "Monedas y Doc. de Pago"
            Case 6
                Frase = Frase & "Amortización de Interés"
            Case 7
                Frase = Frase & "Amortización de Capital"
            Case 8
                Frase = Frase & "Cartera de Inversión"
        End Select
        
        MsgBox Frase, vbInformation, Msj
        Resume Next
        
    End If
     
End Sub



Private Sub cmbTasaVenta_LostFocus()
   On Error Resume Next
   Me.Refresh
   If MiTipoSwap = [Swap Promedio Camara] Then
      If cmbTasaCompra.Text <> "ICP" And cmbTasaVenta.Text <> "ICP" Then
         cmbTasaVenta.Text = "ICP"
      End If
   End If
   On Error GoTo 0
End Sub

Function LlenaComboTasas(Cual As Integer, CodMon As Integer, CodSist As Integer, sFecha As String, Periodo As Integer)
   Dim SQL     As String
   Dim Datos()
   Dim I       As Integer
   Dim combo   As Object
   Dim Combo1  As Object
   Dim Ctasa   As Integer
   Dim OK      As Boolean

   If Cual = 1 Then
      Set combo = cmbTasaCompra 'compra
   Else
      Set combo = cmbTasaVenta  'venta
   End If

   combo.Clear
   SQL = "EXEC SP_LEER_TASASMONEDAS "
   SQL = SQL & CodMon & ", 0 "
   SQL = SQL & ", " & Periodo & ","
   SQL = SQL & "'" & sFecha & "' "
   If MISQL.SQL_Execute(SQL) <> 0 Then
      MsgBox "No se encontraron Tasas asociadas a ésta Moneda!", vbInformation, Msj
      Exit Function
   End If
   Ctasa = 0
   I = 1
   Do While MISQL.SQL_Fetch(Datos()) = 0
      If Ctasa <> Val(Datos(3)) Then
         If Val(Datos(3)) <> 0 Then
            'si es fija
            combo.AddItem Datos(4) & Space(100) & Datos(8)
            combo.ItemData(combo.NewIndex) = Val(Datos(3))
         End If
      End If
      Ctasa = Val(Datos(3))
      ReDim Preserve ValorTasasMon(5, I)
      ValorTasasMon(1, I) = Val(Datos(3))   'Codigo Tasa
      ValorTasasMon(2, I) = Val(Datos(5))   'Codigo Periodo
      ValorTasasMon(3, I) = BacStrTran((Datos(8)), ".", gsc_PuntoDecim)         'Valor tasa periodo
      I = I + 1
   Loop
   TotTasasMon = I - 1
   combo.AddItem "FIJA" & Space(100) & "0"
   combo.ItemData(combo.NewIndex) = 0
   combo.ListIndex = 0

End Function

Function BuscarDatos()
    Dim Mantencion As New clsMantencionSwap
    Dim RutPaso As String
    Dim total As Double
    Dim I, Hasta, desde, j As Integer
    Dim lPrimero As Boolean
    Dim EspecialRecibimos As Integer
    Dim Especialpagamos   As Integer
    
    tabFlujos.Tag = "Pagamos"
    Call LLenafgrdFlujos
    tabFlujos.Tag = "Recibimos"
    Call LLenafgrdFlujos
    
    grdRecibimos.Rows = 1
    grdPagamos.Rows = 1
    desde = 1
    j = 1
    
    With Mantencion
        
        If cOperSwapST = "ModificacionCartera" Then
            
            'Busca datos en cartera  historica - movimientos vencidos
            .NumOperacion = nNumoperST
            .TipoOperacion = 4
            If Not .LeerDatos Then
                Set Mantencion = Nothing
            
            ElseIf .coleccion.Count > 0 Then
            
                Hasta = .coleccion.Count
'                grdRecibimos.Rows = Hasta + 1
'                grdPagamos.Rows = Hasta + 1
                For I = desde To Hasta
                                       
                    If .coleccion(I).swTipoFlujo = 1 Then
                        grdRecibimos.Rows = grdRecibimos.Rows + 1
                        j = grdRecibimos.Rows - 1
                        
                        grdRecibimos.TextMatrix(j, 0) = Val(.coleccion(I).swNumFlujo & "  ")
                        grdRecibimos.TextMatrix(j, 1) = Format(.coleccion(I).swFechaVenceFlujo, "dd/mm/yyyy")
                        grdRecibimos.TextMatrix(j, 2) = Format(BacStrTran((.coleccion(I).swCAmortiza), ".", gsc_PuntoDecim), "###,###,###,##0.###0")
                        grdRecibimos.TextMatrix(j, 3) = Format(CDbl(BacStrTran((.coleccion(I).swCValorTasa), ".", gsc_PuntoDecim)) + CDbl(BacStrTran((.coleccion(I).swCSpread), ".", gsc_PuntoDecim)), "###0.###0")
                        grdRecibimos.TextMatrix(j, 4) = Format(BacStrTran((.coleccion(I).swCInteres), ".", gsc_PuntoDecim), "###,###,###,##0.###0")
                        total = CDbl(BacStrTran((.coleccion(I).swCInteres), ".", gsc_PuntoDecim))
                        grdRecibimos.TextMatrix(j, 5) = Format(total, "###,###,###,##0.###0")
                        grdRecibimos.TextMatrix(j, 6) = IIf(.coleccion(I).swModalidadPago = "C", "Compensación" & Space(50) & "C" _
                                                            , "Ent. Fisica" & Space(50) & "F")
                        grdRecibimos.TextMatrix(j, 8) = BacStrTran((.coleccion(I).swCSaldo), ".", gsc_PuntoDecim)
                        grdRecibimos.TextMatrix(j, 9) = Format(.coleccion(I).swFechaInicioFlujo, "dd/mm/yyyy")
                        grdRecibimos.TextMatrix(j, 10) = BacStrTran((.coleccion(I).swRecMonto), ".", gsc_PuntoDecim)
                        grdRecibimos.TextMatrix(j, 11) = BacStrTran((.coleccion(I).swRecMontoUSD), ".", gsc_PuntoDecim)
                        grdRecibimos.TextMatrix(j, 12) = BacStrTran((.coleccion(I).swRecMontoCLP), ".", gsc_PuntoDecim)
                        grdRecibimos.TextMatrix(j, 13) = "CH"
                        grdRecibimos.TextMatrix(j, 14) = Format(.coleccion(I).swFechaFijacionTasa, "dd/mm/yyyy")
                        
                    End If
                    
                Next
                
                For I = desde To Hasta
                
                    If .coleccion(I).swTipoFlujo = 2 Then
                        grdPagamos.Rows = grdPagamos.Rows + 1
                        j = grdPagamos.Rows - 1
                        
                        grdPagamos.TextMatrix(j, 0) = Val(.coleccion(I).swNumFlujo) & "  "
                        grdPagamos.TextMatrix(j, 1) = Format(.coleccion(I).swFechaVenceFlujo, "dd/mm/yyyy")
                        grdPagamos.TextMatrix(j, 2) = Format(BacStrTran((.coleccion(I).swVAmortiza), ".", gsc_PuntoDecim), "###,###,###,##0.###0")
                        grdPagamos.TextMatrix(j, 3) = Format(CDbl(BacStrTran((.coleccion(I).swVValorTasa), ".", gsc_PuntoDecim)) + CDbl(BacStrTran((.coleccion(I).swVSpread), ".", gsc_PuntoDecim)), "###0.###0")
                        grdPagamos.TextMatrix(j, 4) = Format(BacStrTran((.coleccion(I).swVInteres), ".", gsc_PuntoDecim), "###,###,###,##0.###0")
                        total = CDbl(BacStrTran((.coleccion(I).swVInteres), ".", gsc_PuntoDecim))
                        grdPagamos.TextMatrix(j, 5) = Format(total, "###,###,###,##0.###0")
                        grdPagamos.TextMatrix(j, 6) = IIf(.coleccion(I).swModalidadPago = "C", "Compensación" & Space(50) & "C" _
                                                            , "Ent. Fisica" & Space(50) & "E")
                        grdPagamos.TextMatrix(j, 8) = BacStrTran((.coleccion(I).swVSaldo), ".", gsc_PuntoDecim)
                        grdPagamos.TextMatrix(j, 9) = Format(.coleccion(I).swFechaInicioFlujo, "dd/mm/yyyy")
                        grdPagamos.TextMatrix(j, 10) = BacStrTran((.coleccion(I).swPagMonto), ".", gsc_PuntoDecim)
                        grdPagamos.TextMatrix(j, 11) = BacStrTran((.coleccion(I).swPagMontoUSD), ".", gsc_PuntoDecim)
                        grdPagamos.TextMatrix(j, 12) = BacStrTran((.coleccion(I).swPagMontoCLP), ".", gsc_PuntoDecim)
                        grdPagamos.TextMatrix(j, 13) = "CH"
                        grdPagamos.TextMatrix(j, 14) = Format(.coleccion(I).swFechaFijacionTasa, "dd/mm/yyyy")
                        total = 0
                        
                    End If
                    
                Next I
                
                j = grdRecibimos.Rows
                lblSwapTasa(22).Visible = True
                Simbologia.Visible = True
            
            End If
            'Limpiar
            Set .coleccion = Nothing
                    
        End If
                  
        .NumOperacion = nNumoperST
        .TipoOperacion = swModTipoOpe
        
        If Not .LeerDatos Then
            Set Mantencion = Nothing
            MsgBox "Operación no ha sido encontrada", vbCritical, Msj
            Exit Function
        End If
        
        'Ubica datos en la pantalla
        I = 1
        Hasta = .coleccion.Count
        etqNumOper.Caption = etqNumOper.Caption & swModNumOpe
        
        If .coleccion(I).swTipoOperacion = "C" Then
            OperacionST = "C"
            
        Else
            OperacionST = "V"
            
        End If
        
        If .coleccion(1).swModalidadPago = "C" Then
            optCompensa.Value = True
        Else
            optEntFisica.Value = True
        End If
        
        FechaCierre = Format(.coleccion(I).swFechaCierre, "dd/mm/yyyy")
        Call bacBuscarCombo(cmbMoneda, .coleccion(I).swCMoneda)
        txtCapital.Text = BacStrTran((.coleccion(I).swCCapital), ".", gsc_PuntoDecim)
        'Call bacBuscarCombo(cmbCarteraInversion, .coleccion(I).swCarteraInversion)
  
        'Llenar arreglos con datos
        lPrimero = True
        
        For I = 1 To Hasta
            
            If .coleccion(I).swTipoFlujo = 1 Then
                '---------------------------------------------------------------------
                If lPrimero Then
                                        
                    Call BuscaCmbAmortiza(cmbAmortizaCapitalRecibimos, Val(.coleccion(I).swCCodAmoCapital))
                    Call BuscaCmbAmortiza(cmbAmortizaInteresRecibimos, Val(.coleccion(I).swCCodAmoInteres))
                    cmbAmortizaInteresRecibimos.Tag = Val(.coleccion(I).swCCodAmoInteres)
                    txtTasaCompra.Text = .coleccion(I).swCValorTasa
                    txtTasaCompra.Tag = (.coleccion(I).swCValorTasaHoy)
                    txtSpreadCompra.Text = .coleccion(I).swCSpread
                                   
                    Call bacBuscarCombo(cmbMonedaRecibimos, .coleccion(I).swRecMoneda)
                    Call bacBuscarCombo(cmbDocumentoRecibimos, .coleccion(I).swRecDocumento)
                    txtFecInicioRecibimos.Text = Format(.coleccion(I).swFechaInicio, "dd/mm/yyyy")   'Fecha Primer Vencimiento
                    txtFecTerminoRecibimos.Text = Format(.coleccion(I).swFechaTermino, "dd/mm/yyyy") 'Fecha Termino amortizacion
                    
                    Call bacBuscarCombo(cmbBaseCompra, .coleccion(I).swCBase)
                    Call bacBuscarCombo(cmbTasaCompra, .coleccion(I).swCCodigoTasa)
                    EspecialRecibimos = .coleccion(I).swEspecial
                    lPrimero = False
                    
                End If
                '-----------------------------------------------------------------------
                grdRecibimos.Rows = grdRecibimos.Rows + 1
                j = grdRecibimos.Rows - 1
            
                grdRecibimos.TextMatrix(j, 0) = (.coleccion(I).swNumFlujo) & "  "
                grdRecibimos.TextMatrix(j, 1) = Format(.coleccion(I).swFechaVenceFlujo, "dd/mm/yyyy")
                grdRecibimos.TextMatrix(j, 2) = Format(BacStrTran((.coleccion(I).swCAmortiza), ".", gsc_PuntoDecim), "###,###,###,##0.###0")
                grdRecibimos.TextMatrix(j, 3) = Format(CDbl(BacStrTran((.coleccion(I).swCValorTasa), ".", gsc_PuntoDecim)) + CDbl(BacStrTran((.coleccion(I).swCSpread), ".", gsc_PuntoDecim)), "###,###,###,##0.###0")
                grdRecibimos.TextMatrix(j, 4) = Format(BacStrTran((.coleccion(I).swCInteres), ".", gsc_PuntoDecim), "###,###,###,##0.###0")
                total = CDbl(BacStrTran((.coleccion(I).swCInteres), ".", gsc_PuntoDecim))
                grdRecibimos.TextMatrix(j, 5) = Format(total, "###,###,###,##0.###0")
                grdRecibimos.TextMatrix(j, 6) = IIf(.coleccion(I).swModalidadPago = "C", "Compensación" & Space(50) & "C" _
                                                    , "Ent. Fisica" & Space(50) & "F")
                grdRecibimos.TextMatrix(j, 8) = BacStrTran((.coleccion(I).swCSaldo), ".", gsc_PuntoDecim)
                grdRecibimos.TextMatrix(j, 9) = Format(.coleccion(I).swFechaInicioFlujo, "dd/mm/yyyy")
                grdRecibimos.TextMatrix(j, 10) = BacStrTran((.coleccion(I).swRecMonto), ".", gsc_PuntoDecim)
                grdRecibimos.TextMatrix(j, 11) = BacStrTran((.coleccion(I).swRecMontoUSD), ".", gsc_PuntoDecim)
                grdRecibimos.TextMatrix(j, 12) = BacStrTran((.coleccion(I).swRecMontoCLP), ".", gsc_PuntoDecim)
                grdRecibimos.TextMatrix(j, 13) = "C"
                grdRecibimos.TextMatrix(j, 14) = Format(.coleccion(I).swFechaFijacionTasa, "dd/mm/yyyy")
                total = 0
                
            End If
            
        Next
      
        lPrimero = True
        For I = 1 To Hasta
      
            If .coleccion(I).swTipoFlujo = 2 Then
            
                '---------------------------------------------------------------------
                If lPrimero Then
                                       
                    Call BuscaCmbAmortiza(cmbAmortizaCapitalPagamos, Val(.coleccion(I).swVCodAmoCapital))
                    Call BuscaCmbAmortiza(cmbAmortizaInteresPagamos, Val(.coleccion(I).swVCodAmoInteres))
                    cmbAmortizaInteresPagamos.Tag = Val(.coleccion(I).swVCodAmoInteres)
                    
                    txtTasaVenta.Text = .coleccion(I).swVValorTasa
                    txtTasaVenta.Tag = (.coleccion(I).swVValorTasaHoy)
                    txtSpreadVenta.Text = .coleccion(I).swVSpread
                    
                    Call bacBuscarCombo(cmbMonedaPagamos, .coleccion(I).swPagMoneda)
                    Call bacBuscarCombo(cmbDocumentoPagamos, .coleccion(I).swPagDocumento)
                    txtFecInicioPagamos.Text = Format(.coleccion(I).swFechaInicio, "dd/mm/yyyy")   'Fecha Primer Vencimiento
                    txtFecTerminoPagamos.Text = Format(.coleccion(I).swFechaTermino, "dd/mm/yyyy") 'Fecha Termino amortizacion
                    
                    Call bacBuscarCombo(cmbBaseVenta, .coleccion(I).swVBase)
                    Call bacBuscarCombo(cmbTasaVenta, .coleccion(I).swVCodigoTasa)
                    Especialpagamos = .coleccion(I).swEspecial
                    
                    lPrimero = False
                    
                End If
                '-----------------------------------------------------------------------
                grdPagamos.Rows = grdPagamos.Rows + 1
                j = grdPagamos.Rows - 1

                grdPagamos.TextMatrix(j, 0) = .coleccion(I).swNumFlujo & "  "
                grdPagamos.TextMatrix(j, 1) = Format(.coleccion(I).swFechaVenceFlujo, "dd/mm/yyyy")
                grdPagamos.TextMatrix(j, 2) = Format(BacStrTran(.coleccion(I).swVAmortiza, ".", gsc_PuntoDecim), "###,###,###,##0.###0")
                grdPagamos.TextMatrix(j, 3) = Format(CDbl(BacStrTran(.coleccion(I).swVValorTasa, ".", gsc_PuntoDecim)) + CDbl(BacStrTran(.coleccion(I).swVSpread, ".", gsc_PuntoDecim)), "###0.###0")
                grdPagamos.TextMatrix(j, 4) = Format(BacStrTran(.coleccion(I).swVInteres, ".", gsc_PuntoDecim), "###,###,###,##0.###0")
                total = CDbl(BacStrTran((.coleccion(I).swVInteres), ".", gsc_PuntoDecim))
                grdPagamos.TextMatrix(j, 5) = Format(total, "###,###,###,##0.###0")
                grdPagamos.TextMatrix(j, 6) = IIf(.coleccion(I).swModalidadPago = "C", "Compensación" & Space(50) & "C" _
                                                    , "Ent. Fisica" & Space(50) & "F")
                grdPagamos.TextMatrix(j, 8) = BacStrTran((.coleccion(I).swVSaldo), ".", gsc_PuntoDecim)
                grdPagamos.TextMatrix(j, 9) = Format(.coleccion(I).swFechaInicioFlujo, "dd/mm/yyyy")
                grdPagamos.TextMatrix(j, 10) = BacStrTran((.coleccion(I).swPagMonto), ".", gsc_PuntoDecim)
                grdPagamos.TextMatrix(j, 11) = BacStrTran((.coleccion(I).swPagMontoUSD), ".", gsc_PuntoDecim)
                grdPagamos.TextMatrix(j, 12) = BacStrTran((.coleccion(I).swPagMontoCLP), ".", gsc_PuntoDecim)
                grdPagamos.TextMatrix(j, 13) = "C"
                grdPagamos.TextMatrix(j, 14) = Format(.coleccion(I).swFechaFijacionTasa, "dd/mm/yyyy")
                total = 0
                
            End If
            
        Next I
        
        Set .coleccion = Nothing

    End With
    
    Call bacBuscarCombo(cmbEspecialRecibimos, EspecialRecibimos)
        
    If EspecialRecibimos > 0 Then
        txtFecPrimerVctoRecibimos.Text = grdRecibimos.TextMatrix(1, 1)
    Else
        txtFecPrimerVctoRecibimos.Text = grdRecibimos.TextMatrix(2, 1)
    End If
    
    Call bacBuscarCombo(cmbEspecialPagamos, Especialpagamos)
    If Especialpagamos > 0 Then
        txtFecPrimerVctoPagamos.Text = grdPagamos.TextMatrix(1, 1)
    Else
        txtFecPrimerVctoPagamos.Text = grdPagamos.TextMatrix(2, 1)
    End If
    
    lblFechaInicioRecibimos = BacFechaStr(txtFecInicioRecibimos.Text)
    lblFechaInicioPagamos = BacFechaStr(txtFecInicioPagamos.Text)
    
    lblFechaPrimerAmortRecibimos = BacFechaStr(txtFecPrimerVctoRecibimos.Text)
    lblFechaPrimerAmortPagamos = BacFechaStr(txtFecPrimerVctoPagamos.Text)
    
    lblFechaTerminoRecibimos = BacFechaStr(txtFecTerminoRecibimos.Text)
    lblFechaTerminoPagamos = BacFechaStr(txtFecTerminoPagamos.Text)
    
    Call CambiaColorCeldas(grdPagamos)
    Call CambiaColorCeldas(grdRecibimos)
    
    Set Mantencion = Nothing
    
End Function


'Function CalculoInteresBonos(BaseStr As String, ByRef Grd As Object)
'    Dim Spread, Base, Tasa As Double
'    Dim FechaAmortiza As Date
'    Dim FechaVencAnt, FecVAnt As Date
'    Dim DiasDif As Integer
'    Dim cuenta As Integer
'    Dim MontoAmortiza, MontoCapital, MontoGrd As Double
'    Dim Interes As Double
'    Dim Plazo   As Double
'    Dim RestoCapital As Double
'    Dim TotalVenc As Double
'    Dim CodMoneda As Integer
'    Dim FactorUSD As Double
'    Dim MontoCLP As Double
'    Dim FactorCLP As Double
'    Dim MontoUSD As Double
'    Dim MonFuerteC  As Double
'    Dim Decimales    As Integer
'
'    Spread = 0
'    MontoCapital = (txtCapital.Text)                             'Monto Capital
'    FactorCLP = ValorDolarObs
'    Decimales = txtCapital.CantidadDecimales
'
'
'    Base = BaseStr    'Base asignada para calculo
'    DiasDif = DateDiff("d", CDate(txtFecInicioRecibimos.Text), CDate(Grd.TextMatrix(1, 1)))
'    FechaVencAnt = CDate(txtFecInicioRecibimos.Text)
'    MontoAmortiza = CDbl((txtCapital.Text))
'
'    If cmbMoneda.ListIndex <> -1 Then
'        CodMoneda = cmbMoneda.ItemData(cmbMoneda.ListIndex)
'    Else
'        CodMoneda = 994 'dolar  observado'
'    End If
'
'    Dim ValMonedas As New clsMoneda
'    With ValMonedas
'    If .LeerxCodigo(CodMoneda) Then
'        FactorUSD = .vmValor    'equivalencia a 1 dolar
'        MonFuerteC = .mnrefusd       'Caracteristica moneda ( fuerte o no)
'    End If
'    .Limpiar
'    End With
'    Set ValMonedas = Nothing
'
'    With Grd
'    For cuenta = 1 To .Rows - 1
'
'        FechaAmortiza = .TextMatrix(cuenta, 1)
'        MontoGrd = .TextMatrix(cuenta, 2)
'        RestoCapital = CDbl(.TextMatrix(cuenta, 2)) 'MontoAmortCap
'        Tasa = CDbl(.TextMatrix(cuenta, 3))
'        DiasDif = DateDiff("d", CDate(FechaVencAnt), CDate(FechaAmortiza))
'        FecVAnt = FechaVencAnt
'        FechaVencAnt = .TextMatrix(cuenta, 1)
'
'        Plazo = DiasDif / Val(Base)
'        Interes = Round(MontoAmortiza * ((Tasa / 100) + (Spread / 100)) * (Plazo), Decimales)
'
'        If CodMoneda = 999 Or CodMoneda = 998 Then
'            If CodMoneda = 998 Then
'                ' A Pesos
'                MontoCLP = Round((Interes * FactorUSD), 0)
'            Else
'                ' A Pesos
'                'Interes = Round(
'                MontoCLP = Interes
'            End If
'            'Monto en dolares
'            MontoUSD = Round((BacDiv(MontoCLP, CDbl(FactorCLP))), 3)
'        Else
'            'Monto en dolares
'            MontoUSD = IIf(Val(MonFuerteC) = 1, (Interes * FactorUSD), (BacDiv(Interes, CDbl(FactorUSD))))
'            MontoUSD = Round(MontoUSD, 3)
'            ' A Pesos
'            MontoCLP = (MontoUSD * FactorCLP)
'        End If
'
'        '***
'        TotalVenc = MontoGrd + Interes
'
'        '***Traspaso de Datos a Arreglo
'        .TextMatrix(cuenta, 0) = cuenta ' + 1
'        .TextMatrix(cuenta, 1) = Format(FechaAmortiza, gsc_FechaDMA)
'        .TextMatrix(cuenta, 2) = Format(MontoGrd, "###,###,###,##0.###0")
'        .TextMatrix(cuenta, 3) = Format(Tasa, "####0.###0")
'        .TextMatrix(cuenta, 4) = Format(Interes, "###,###,###,##0.###0")
'        .TextMatrix(cuenta, 5) = Format(TotalVenc, "###,###,###,##0.###0")
'        .TextMatrix(cuenta, 8) = MontoAmortiza - RestoCapital
'        .TextMatrix(cuenta, 9) = FecVAnt
'        .TextMatrix(cuenta, 10) = MontoAmortiza
'        .TextMatrix(cuenta, 11) = MontoUSD
'        .TextMatrix(cuenta, 12) = MontoCLP
'
'        MontoAmortiza = MontoAmortiza - RestoCapital
'        '***
'    Next
'    End With
'
'End Function

Function CalculoInteresBonos(TipOpcion As String)
    Dim Base, Tasa, Spread As Double
    Dim FechaAmortiza   As Date
    Dim FechaVencAnt, FecVAnt As Date
    Dim DiasDif         As Integer
    Dim cuenta          As Integer
    Dim MontoAmortiza, MontoCapital, MontoGrd As Double
    Dim Interes         As Double
    Dim Plazo           As Double
    Dim RestoCapital    As Double
    Dim TotalVenc       As Double
    Dim CodMoneda       As Integer
    Dim FactorUSD       As Double
    Dim MontoCLP        As Double
    Dim FactorCLP       As Double
    Dim MontoUSD        As Double
    Dim MonFuerteC      As Double
    Dim Referencial     As Integer
    Dim PeriDias        As String
    Dim PeriBase        As String
    Dim Paso            As String
    Dim BaseStr         As String
    Dim Grd             As MSFlexGrid
    Dim fecInicio       As Date
    Dim PlazoDias       As Double
    
   Dim Lineal As Boolean
    
    If TipOpcion = "C" Then
        Set Grd = grdRecibimos
        PlazoDias = ValorAmort(cmbAmortizaInteresRecibimos, "D")
        BaseStr = cmbBaseCompra
        fecInicio = txtFecInicioRecibimos.Text
        
    Else
        Set Grd = grdPagamos
        PlazoDias = ValorAmort(cmbAmortizaInteresPagamos, "D")
        BaseStr = cmbBaseVenta
        fecInicio = txtFecInicioPagamos.Text
        
    End If
    
    Spread = 0
    MontoCapital = (txtCapital.Text)                             'Monto Capital
    FactorCLP = ValorDolarObs
    
    Paso = Right(BaseStr, 10)
    
    PeriDias = Trim(Left(Paso, 5))
    PeriBase = Trim(Right(Paso, 5))
    
    If PeriBase = "A" Then  ' De Actual
        Base = 365
    Else
        Base = PeriBase     'Base asignada para calculo
    End If
    
    DiasDif = DateDiff("d", fecInicio, CDate(Grd.TextMatrix(1, 1)))
    
    FechaVencAnt = fecInicio
    MontoAmortiza = CDbl((txtCapital.Text))
    
    If cmbMoneda.ListIndex <> -1 Then
        CodMoneda = cmbMoneda.ItemData(cmbMoneda.ListIndex)
    Else
        CodMoneda = 994 'dolar  observado'
    End If
    
    Dim ValMonedas As New ClsMoneda
    With ValMonedas
        If .LeerxCodigo(CodMoneda) Then
            FactorUSD = .vmValor        'equivalencia a 1 dolar
            MonFuerteC = .mnrefusd      'Caracteristica moneda ( fuerte o no)
            Referencial = .mnrefmerc    'Referencial Mercado
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
            
            'Lineal = False
            Plazo = DiasDif / Val(Base)
            'If Lineal Then
                
                Interes = MontoAmortiza * (Tasa / 100) * (Plazo)
            'Else
                
            '    Interes = MontoAmortiza * ((Tasa / 100) ^ Plazo)
            'End If
                Interes = Round(Interes, 4)
                
             'Interes = MontoAmortiza * ((Tasa / 100) + (Spread / 100)) * (Plazo)
            If CodMoneda = 999 Or CodMoneda = 998 Then
                ' A Pesos
                MontoCLP = Round((Interes * FactorUSD), 0)
                'Monto en dolares
                MontoUSD = Round((BacDiv(MontoCLP, CDbl(FactorCLP))), 3)
            ElseIf CodMoneda = 13 Or Referencial = 1 Then
                'Monto en dolares
                MontoUSD = Interes
                MontoUSD = Round(MontoUSD, 4)
                ' A Pesos
                MontoCLP = Round((MontoUSD * FactorCLP), 0)
            Else
                'Monto en dolares
                MontoUSD = IIf(Val(MonFuerteC) = 1, (Interes * FactorUSD), (BacDiv(Interes, CDbl(FactorUSD))))
                MontoUSD = Round(MontoUSD, 3)
                ' A Pesos
                MontoCLP = (MontoUSD * FactorCLP)
            End If
            
            '***
            TotalVenc = MontoGrd + Interes
            
            '***Traspaso de Datos a Arreglo
            .TextMatrix(cuenta, 0) = cuenta ' + 1
            .TextMatrix(cuenta, 1) = Format(FechaAmortiza, gsc_FechaDMA)
            .TextMatrix(cuenta, 2) = Format(MontoGrd, "###,###,###,##0.###0")
            .TextMatrix(cuenta, 3) = Format(Tasa, "####0.####0")
            .TextMatrix(cuenta, 4) = Format(Interes, "###,###,###,##0.###0")
            .TextMatrix(cuenta, 5) = Format(TotalVenc, "###,###,###,##0.###0")
            .TextMatrix(cuenta, 8) = MontoAmortiza - RestoCapital
            .TextMatrix(cuenta, 9) = FecVAnt
            .TextMatrix(cuenta, 10) = MontoAmortiza
            .TextMatrix(cuenta, 11) = MontoUSD
            .TextMatrix(cuenta, 12) = MontoCLP
            
            MontoAmortiza = MontoAmortiza - RestoCapital
            '***
        Next
        
    End With
    
End Function

'Function CalculoInteres()
'    Dim SpreadC, BaseC, TasaC, PlazoC, InteresC As Double
'    Dim SpreadV, BaseV, TasaV, PlazoV, InteresV As Double
'    Dim FechaAmortiza, FechaAmortizaCap, FechaAmortizaInt As Date
'    Dim FechaIniAmortCap, FechaIniAmort As Date
'    Dim FechaFin, FechaVencAnt, FechaDePaso As Date
'    Dim DiasAmortCap, DiasAmortInt, DiaAmort As Integer
'    Dim DiasDif, FactorDiv As Integer
'    Dim cuenta As Integer
'    Dim MontoAmortiza, MontoCapital, MontoGrd As Double
'    Dim RestoCapital As Double
'    Dim MontoAmortCap  As Double
'    Dim dias%
'    Dim CuentaAmCap As Integer
'    Dim FactorUSDc, FactorCLP, MontoUSDc, MontoCLPc As Double
'    Dim FactorUSDv, MontoUSDv, MontoCLPv As Double
'    Dim MonFuerteC, MonFuerteV As Integer
'    Dim FechaProceso As String
'    Dim CodMoneda As Integer
'    Dim SaldoCapital As Double
'    Dim i As Integer
'    Dim lEspecial  As Boolean
'    Dim PlazoMin As Integer
'    Dim PlazoMax  As Integer
'    Dim Grd As Object
'    Dim DivCap As Integer
'    Dim DivInt As Integer
'    Dim Cuadratura As Double
'
'    '*************************************
'    '* Primer Calculo Amortizacion de Interes  *
'    '*************************************
'  'cmbEspecialRecibimos.ItemData(cmbEspecialRecibimos.NewIndex) = 0
'  '*****
'    FechaProceso = IIf(OperSwap = "Ingreso", gsBAC_Fecp, FechaCierre)
'
'    If cmbMoneda.ListIndex <> -1 Then
'        CodMoneda = cmbMoneda.ItemData(cmbMoneda.ListIndex)
'    Else
'        CodMoneda = 994 'dolar  observado'
'    End If
'
'
'    FactorUSDc = 0:     FactorUSDv = 0
'    FactorCLP = 0
'
'    Dim ValMonedas As New clsMoneda
'
'    With ValMonedas
'        .Limpiar
'
'        FactorUSDc = FactorUSDv
'        MonFuerteC = MonFuerteV
'
'    End With
'
'    Set ValMonedas = Nothing
'
'    FactorCLP = ValorDolarObs
'    '*****
'
'    MontoCapital = CDbl(txtCapital.Text)                             'Monto Capital
'
'    DiasAmortCap = ValorAmort(cmbAmortizaCapitalRecibimos, DesgloseAmort) 'Total de dias o meses real para Amortizacion Capital
'    DiasAmortInt = ValorAmort(cmbAmortizaInteresRecibimos, DesgloseAmort)     'Total de dias o meses para Amortizacion del Interes
'
'     '***Inicializaciones de Fecha
'
'    If DiasAmortCap > DiasAmortInt Then
'        PlazoMin = DiasAmortInt
'        PlazoMax = DiasAmortCap
'    Else
'       PlazoMin = IIf(DiasAmortCap > 0, DiasAmortCap, DiasAmortInt)
'       PlazoMax = DiasAmortInt
'    End If
'
'    Dim m
'    m = DateDiff("m", CDate(txtFecInicioRecibimos.Text), CDate(txtFecTerminoRecibimos.Text))
'    m = IIf(m > 0, m, PlazoMin)
'
'    '---- Define fechas para generar Flujos
'    FechaFin = CDate(txtFecTerminoRecibimos.Text)
'    FechaVencAnt = CDate(txtFecInicioRecibimos.Text)
'
'    If DiasAmortCap > 0 Then
'        FechaIniAmortCap = CreaFechaProx(txtFecInicioRecibimos.Text, DiasAmortCap, Day(txtFecInicioRecibimos.Text), DesgloseAmort)
'    Else
'        FechaIniAmortCap = CreaFechaProx(txtFecInicioRecibimos.Text, DiasAmortInt, Day(txtFecInicioRecibimos.Text), DesgloseAmort)
'    End If
'
'
'    lEspecial = (CDate(txtFecPrimerVctoRecibimos.Text) <> FechaIniAmortCap)
'    '---- Primer Vencimiento
'    If lEspecial Then
'        FechaIniAmortCap = CDate(txtFecPrimerVctoRecibimos.Text)
'        FechaIniAmort = txtFecPrimerVctoRecibimos.Text
'        FechaAmortizaCap = CDate(txtFecPrimerVctoRecibimos.Text)
'        FechaAmortizaInt = CDate(txtFecPrimerVctoRecibimos.Text)
'        FechaAmortiza = CDate(txtFecPrimerVctoRecibimos.Text)
'    Else
'        FechaIniAmort = CreaFechaProx(txtFecInicioRecibimos.Text, PlazoMin, Day(txtFecInicioRecibimos.Text), DesgloseAmort)
'        FechaAmortizaCap = CreaFechaProx(txtFecInicioRecibimos.Text, DiasAmortCap, Day(txtFecInicioRecibimos.Text), DesgloseAmort)
'        FechaAmortizaInt = CreaFechaProx(txtFecInicioRecibimos.Text, DiasAmortInt, Day(txtFecInicioRecibimos.Text), DesgloseAmort)
'        FechaAmortiza = FechaIniAmort
'        If Abs(DateDiff("d", CDate(FechaFin), CDate(FechaAmortizaCap))) <= 10 Then
'            FechaAmortizaCap = FechaFin
'        End If
'    End If
'
'    '***
'    FactorDiv = 0
'
'    'DiaAmort = Day(txtFecPrimerVctoRecibimos.Text)
'    'ACAAAAAAAAAaaa
'    DiaAmort = Day(txtFecInicioRecibimos.Text)
'    If OperSwap <> "ModificacionCartera" Then 'Operaciones del dia
'        If DiasAmortCap <= 0 Then
'            If Not lEspecial Then
'                'Para los casos que el período es BULLET ó BONO Amortizacion de monto en fecha final
'                FechaAmortizaCap = CDate(txtFecTerminoRecibimos.Text)
'                FactorDiv = 1
'            Else
'                DiasAmortCap = DiasAmortInt
'                FechaAmortizaCap = CDate(txtFecPrimerVctoRecibimos.Text)
'                DivInt = ValorAmort(cmbAmortizaInteresRecibimos, "M")
'                FactorDiv = DateDiff("m", FechaIniAmortCap, CDate(FechaFin)) / DivInt
'                'Sera cero cuando las fechas son iguales
'                FactorDiv = FactorDiv + 1
'            End If
'
'        Else   '***Veces en que se Dividira Capital para amortizar
'            DivCap = ValorAmort(cmbAmortizaCapitalRecibimos, "M")
'            FactorDiv = DateDiff("m", FechaIniAmortCap, CDate(FechaFin)) / DivCap
'            'Sera cero cuando las fechas son iguales
'            FactorDiv = FactorDiv + 1
'        End If
'
'        DiasDif = DateDiff("d", txtFecInicioRecibimos.Text, FechaAmortiza)
'         '***
'        MontoAmortiza = (MontoCapital)
'         '***Monto a amortizar en los vctos.
'        MontoAmortCap = Round(CDbl(MontoCapital) / FactorDiv, 4)
'
'        'Para que la sumatoria de montos amortizados cuadre con Capital
'        Cuadratura = MontoAmortiza - (MontoAmortCap * FactorDiv)
'
'        cuenta = 1
'        grdPagamos.Rows = 1
'        grdRecibimos.Rows = 1
'    Else
'        'Flujos de Operaciones vigentes
'        Set Grd = grdPagamos
'        For i = 1 To Grd.Rows - 1
'            If Grd.TextMatrix(i, 13) = "CH" Then
'                If i = Grd.Rows - 1 Then
'                    SaldoCapital = CDbl(Grd.TextMatrix(i, 8))
'                Else
'                    SaldoCapital = CDbl(Grd.TextMatrix(i + 1, 8))
'                End If
'                FechaAmortiza = Grd.TextMatrix(i, 1)
'                FechaVencAnt = Grd.TextMatrix(i, 9)
'                cuenta = i
'                If CDbl(Grd.TextMatrix(i, 2)) <> 0 Then
'                'hubo amortizacion de capital
'                    FechaDePaso = CDate(Grd.TextMatrix(i, 1))
'                End If
'            Else
'                Exit For
'            End If
'        Next
'
'        ' factor division de monto restante para amortizacion del capital
'        FechaAmortizaCap = CreaFechaProx(FechaDePaso, DiasAmortCap, DiaAmort, DesgloseAmort)
'        FactorDiv = 0
'        While FechaAmortizaCap <= FechaFin
'            FactorDiv = FactorDiv + 1
'            FechaAmortizaCap = CreaFechaProx(FechaAmortizaCap, DiasAmortCap, DiaAmort, DesgloseAmort)
'            If FechaAmortizaCap > FechaFin And _
'                 Abs(DateDiff("d", CDate(FechaAmortizaCap), CDate(FechaFin))) <= 10 Then
'                     FechaAmortizaCap = FechaFin
'            End If
'        Wend
'
'        FechaVencAnt = FechaAmortiza
'        FechaAmortiza = CreaFechaProx(FechaAmortiza, PlazoMin, DiaAmort, DesgloseAmort)
'        If FechaAmortiza > FechaFin And _
'             Abs(DateDiff("d", CDate(FechaAmortiza), CDate(FechaFin))) <= 10 Then
'                 FechaAmortiza = FechaFin
'        End If
'
'        '***Próxima Fecha Vcto. Amort. Capital
'        FechaAmortizaCap = CreaFechaProx(FechaDePaso, DiasAmortCap, DiaAmort, DesgloseAmort)
'        If FechaAmortizaCap > FechaFin And _
'             Abs(DateDiff("d", CDate(FechaAmortizaCap), CDate(FechaFin))) <= 10 Then
'                 FechaAmortizaCap = FechaFin
'        End If
'
'        '***
'        DiasDif = DateDiff("d", CDate(FechaVencAnt), CDate(FechaAmortiza))
'        FactorDiv = IIf(FactorDiv = 0, 1, FactorDiv)
'        MontoAmortiza = SaldoCapital
'        MontoAmortCap = Round((SaldoCapital / FactorDiv), 4)
'        cuenta = cuenta + 1
'        Grd.Rows = cuenta
'
'    End If
'
'    SpreadC = 0:        BaseC = cmbBaseCompra:      TasaC = txtTasaCompra.Text
'    SpreadV = 0:        BaseV = cmbBaseVenta:         TasaV = txtTasaVenta.Text
'
'    While FechaAmortiza <= FechaFin
'       ' Barra.Value = Barra.Value + 1                                                'Incremento de barra
'        '***
'        MontoUSDc = 0:        MontoCLPc = 0:        MontoGrd = 0:        RestoCapital = 0
'        MontoUSDv = 0:        MontoCLPv = 0:
'
'        grdPagamos.Rows = grdPagamos.Rows + 1 'Agregar fila a la grilla
'        grdRecibimos.Rows = grdRecibimos.Rows + 1
'
'        If FechaAmortizaCap = FechaAmortiza Then 'Si corresponde Amortizacion de Capital
'            If FechaAmortizaCap = FechaFin Then 'Suma diferencia al ultimo vencimiento de Capital
'                MontoAmortCap = MontoAmortCap + Cuadratura
'            End If
'            MontoGrd = MontoAmortCap
'            RestoCapital = MontoAmortCap
'
'            '***Próxima Fecha Vcto. Amort. Capital
'            FechaAmortizaCap = CreaFechaProx(FechaAmortizaCap, DiasAmortCap, DiaAmort, DesgloseAmort)
'            If FechaAmortizaCap > FechaFin Then
'                 If Abs(DateDiff("d", CDate(FechaAmortizaCap), CDate(FechaFin))) <= 10 Then
'                     FechaAmortizaCap = FechaFin
'                 End If
'            Else
'                 If Abs(DateDiff("d", CDate(FechaFin), CDate(FechaAmortizaCap))) <= 10 Then
'                     FechaAmortizaCap = FechaFin
'                End If
'            End If
'
'        End If
'
'        '*** Calculo de Compra
'        'If Val(BaseC) = 30 Then
'        '    PlazoC = ((DiasDif / 30) * 30) / 360
'        'Else
'            PlazoC = DiasDif / Val(BaseC)
'        'End If
'        InteresC = Round(MontoAmortiza * ((TasaC / 100) + (SpreadC / 100)) * (PlazoC), 4)
'
'        '*** Calculo de Venta
'        'If Val(BaseV) = 30 Then
'        '    PlazoV = ((DiasDif / 30) * 30) / 360
'        'Else
'            PlazoV = DiasDif / Val(BaseV)
'        ''End If
'        InteresV = Round(MontoAmortiza * ((TasaV / 100) + (SpreadV / 100)) * (PlazoV), 4)
'
'        If CodMoneda = 999 Or CodMoneda = 998 Then
'            ' A Pesos
'            MontoCLPc = (InteresC * FactorUSDc)
'            MontoCLPv = InteresV * FactorUSDc
'            MontoCLPc = Round(MontoCLPc, 0)
'            MontoCLPv = Round(MontoCLPv, 0)
'
'            'Monto en dolares
'            MontoUSDc = (BacDiv(MontoCLPc, CDbl(FactorCLP)))
'            MontoUSDc = Round(MontoUSDc, 3)
'
'            MontoUSDv = (BacDiv(MontoCLPv, CDbl(FactorCLP)))
'            MontoUSDv = Round(MontoUSDv, 3)
'
'        Else
'
'            'Monto en dolares
'            MontoUSDc = IIf(Val(MonFuerteC) = 1, (InteresC * FactorUSDc), (BacDiv(InteresC, CDbl(FactorUSDc))))
'            MontoUSDc = Round(MontoUSDc, 3)
'            ' A Pesos
'            MontoCLPc = (MontoUSDc * FactorCLP)
'            'Monto en dolares
'            MontoUSDv = IIf(Val(MonFuerteC) = 1, (InteresV * FactorUSDc), (BacDiv(InteresV, CDbl(FactorUSDc))))
'            MontoUSDv = Round(MontoUSDv, 3)
'            ' A Pesos
'            MontoCLPv = MontoUSDv * FactorCLP
'        End If
'       ' MontoAmortiza = MontoAmortiza - RestoCapital
'
'        '***Traspaso de Datos a Grilla
'        grdPagamos.TextMatrix(cuenta, 0) = cuenta & "  "
'        grdPagamos.TextMatrix(cuenta, 1) = Format(FechaAmortiza, gsc_FechaDMA)
'        grdPagamos.TextMatrix(cuenta, 2) = Format(MontoGrd, "###,###,###,##0.###0")
'        grdPagamos.TextMatrix(cuenta, 6) = IIf(optCompensa.Value = True, "Compensación" & Space(50) & "C" _
'                                            , "Ent. Fisica" & Space(50) & "E")
'        grdPagamos.TextMatrix(cuenta, 8) = MontoAmortiza - RestoCapital
'        grdPagamos.TextMatrix(cuenta, 9) = FechaVencAnt
'        grdPagamos.TextMatrix(cuenta, 10) = MontoAmortiza
'        grdPagamos.TextMatrix(cuenta, 11) = MontoUSDv
'        grdPagamos.TextMatrix(cuenta, 12) = MontoCLPv
'
'        grdRecibimos.TextMatrix(cuenta, 0) = cuenta & "  "
'        grdRecibimos.TextMatrix(cuenta, 1) = Format(FechaAmortiza, gsc_FechaDMA)
'        grdRecibimos.TextMatrix(cuenta, 2) = Format(MontoGrd, "###,###,###,##0.###0")
'        grdRecibimos.TextMatrix(cuenta, 6) = IIf(optCompensa.Value = True, "Compensación" & Space(50) & "C" _
'                                            , "Ent. Fisica" & Space(50) & "E")
'        grdRecibimos.TextMatrix(cuenta, 8) = MontoAmortiza - RestoCapital 'MontoAmortiza
'        grdRecibimos.TextMatrix(cuenta, 9) = FechaVencAnt
'        grdRecibimos.TextMatrix(cuenta, 10) = MontoAmortiza
'        grdRecibimos.TextMatrix(cuenta, 11) = MontoUSDc
'        grdRecibimos.TextMatrix(cuenta, 12) = MontoCLPc
'
'        grdPagamos.TextMatrix(cuenta, 3) = Format(TasaV, "####0.###0")
'        grdPagamos.TextMatrix(cuenta, 4) = Format(InteresV, "###,###,###,##0.###0")
'        grdPagamos.TextMatrix(cuenta, 5) = Format((InteresV), "###,###,###,##0.###0")
'        grdRecibimos.TextMatrix(cuenta, 3) = Format(TasaC, "####0.###0")
'        grdRecibimos.TextMatrix(cuenta, 4) = Format(InteresC, "###,###,###,##0.###0")
'        grdRecibimos.TextMatrix(cuenta, 5) = Format((InteresC), "###,###,###,##0.###0")
'
'        '***Actualizacion de datos para Prox. amortizacion
'        MontoAmortiza = MontoAmortiza - RestoCapital
'        FechaVencAnt = FechaAmortiza
'        FechaAmortiza = CreaFechaProx(FechaAmortiza, PlazoMin, DiaAmort, DesgloseAmort)
'
'        If FechaAmortiza > FechaFin And _
'            Abs(DateDiff("d", CDate(FechaAmortiza), CDate(FechaFin))) <= 10 Then
'                     FechaAmortiza = FechaFin
'        Else
'            If Abs(DateDiff("d", CDate(FechaFin), CDate(FechaAmortiza))) <= 10 Then
'                     FechaAmortiza = FechaFin
'                     FechaAmortizaCap = FechaFin
'            End If
'        End If
'        DiasDif = DateDiff("d", FechaVencAnt, FechaAmortiza)
'
'        '***
'        cuenta = cuenta + 1
'    Wend
'
'    'Barra.Value = Barra.Max
'
'End Function
'Function CalculoInteresModificado()
'
'    Dim FechaAmortiza, FechaAmortizaCap, FechaAmortizaInt As Date
'    Dim FechaFin, FechaVencAnt As Date
'    Dim DiasAmortCap, DiasAmortInt, DiaAmort As Integer
'    Dim FactorDiv As Integer
'    Dim cuenta As Integer
'    Dim MontoCapital   As Double
'    Dim RestoCapital As Double
'    Dim MontoGrd As Double
'    Dim MontoAmortCap  As Double
'    Dim FechaProceso As String
'    Dim DivCap As Integer
'    Dim Cuadratura As Double
'    Dim PlazoMin As Long
'    Dim ValotTasaCompra As Double
'    Dim ValotTasaVenta As Double
'
'    grdPagamos.Rows = 1
'    grdRecibimos.Rows = 1
'    cuenta = 1
'    FactorDiv = 1
'
'    FechaProceso = IIf(OperSwap = "Ingreso", gsBAC_Fecp, FechaCierre)
'    MontoCapital = CDbl(txtCapital.Text)                             'Monto Capital
'
'    DiasAmortCap = ValorAmort(cmbAmortizaCapitalRecibimos, DesgloseAmort) 'Total de dias o meses real para Amortizacion Capital
'    DiasAmortInt = ValorAmort(cmbAmortizaInteresRecibimos, DesgloseAmort)     'Total de dias o meses para Amortizacion del Interes
'
'    If DiasAmortCap > DiasAmortInt Then
'        PlazoMin = DiasAmortInt
'
'    Else
'       PlazoMin = IIf(DiasAmortCap > 0, DiasAmortCap, DiasAmortInt)
'
'    End If
'
'    '---- Define fechas para generar Flujos
'    FechaFin = CDate(txtFecTerminoRecibimos.Text)
'    FechaVencAnt = CDate(txtFecInicioRecibimos.Text)
'
'    Select Case cmbEspecialRecibimos.ItemData(cmbEspecialRecibimos.ListIndex)
'    Case 0      'NORMAL
'            'Para los casos que el período es BULLET ó BONO Amortizacion de monto en fecha final
'        DiaAmort = Day(txtFecInicioRecibimos.Text)
'        FechaAmortizaCap = IIf(DiasAmortCap > 0, CreaFechaProx(txtFecInicioRecibimos.Text, DiasAmortCap, DiaAmort, DesgloseAmort), CDate(txtFecTerminoRecibimos.Text))
'        FechaAmortizaInt = CreaFechaProx(txtFecInicioRecibimos.Text, DiasAmortInt, Day(txtFecInicioRecibimos.Text), DesgloseAmort)
'        FechaAmortiza = FechaAmortizaInt ' FechaIniAmort
'    Case 1      'CAPITAL
'        FechaAmortizaCap = CDate(txtFecPrimerVctoRecibimos.Text)
'        FechaAmortizaInt = CDate(txtFecPrimerVctoRecibimos.Text)
'        FechaAmortiza = CDate(txtFecPrimerVctoRecibimos.Text)
'        DiaAmort = Day(txtFecPrimerVctoRecibimos.Text)
'
'    Case 2      'INTERES
'        DiaAmort = Day(txtFecPrimerVctoRecibimos.Text)
'        FechaAmortizaCap = IIf(DiasAmortCap > 0, CreaFechaProx(txtFecPrimerVctoRecibimos.Text, DiasAmortCap, DiaAmort, DesgloseAmort), CDate(txtFecTerminoRecibimos.Text))
'        FechaAmortizaInt = CDate(txtFecPrimerVctoRecibimos.Text)
'        FechaAmortiza = CDate(txtFecPrimerVctoRecibimos.Text)
'
'    End Select
'   If DiasAmortCap > 0 Then
'        DivCap = ValorAmort(cmbAmortizaCapitalRecibimos, "M")
'        FactorDiv = DateDiff("m", FechaAmortizaCap, CDate(FechaFin)) / DivCap
'        'Sera cero cuando las fechas son iguales
'        FactorDiv = FactorDiv + 1
'   End If
'
'    If FactorDiv = 0 Then
'        MsgBox "Fechas Ingresadas no concuerdan com períodos de amortización seleccionados", vbCritical, Msj
'        txtFecTerminoRecibimos.SetFocus
'        Exit Function
'
'    End If
'
'     '***Monto a amortizar en los vctos.
'    MontoAmortCap = Round((CDbl(MontoCapital) / FactorDiv), 4)
'    'Para que la sumatoria de montos amortizados cuadre con Capital
'    Cuadratura = MontoCapital - (MontoAmortCap * FactorDiv)
'
'    ValotTasaCompra = CDbl(txtTasaCompra.Text) + CDbl(txtSpreadCompra.Text)
'    ValotTasaVenta = CDbl(txtTasaVenta.Text) + CDbl(txtSpreadVenta.Text)
'
'    While FechaAmortiza <= FechaFin
'
'        MontoGrd = 0
'        If FechaAmortizaCap = FechaAmortiza Then 'Si corresponde Amortizacion de Capital
'            If FechaAmortizaCap = FechaFin Then 'Suma diferencia al ultimo vencimiento de Capital
'                MontoAmortCap = MontoAmortCap + Cuadratura
'            End If
'            MontoGrd = MontoAmortCap
'            '***Próxima Fecha Vcto. Amort. Capital
'            FechaAmortizaCap = CreaFechaProx(FechaAmortizaCap, DiasAmortCap, DiaAmort, DesgloseAmort)
'        End If
'        grdPagamos.Rows = grdPagamos.Rows + 1
'        grdPagamos.TextMatrix(cuenta, 0) = cuenta & "  "
'        grdPagamos.TextMatrix(cuenta, 1) = Format(FechaAmortiza, gsc_FechaDMA)
'        grdPagamos.TextMatrix(cuenta, 2) = Format(MontoGrd, "###,###,###,##0.###0")
'        grdPagamos.TextMatrix(cuenta, 3) = Format(ValotTasaVenta, "##0.###0")
'        grdPagamos.TextMatrix(cuenta, 6) = IIf(optCompensa.Value = True, "Compensación" & Space(50) & "C" _
'                                            , "Ent. Fisica" & Space(50) & "E")
'
'        grdRecibimos.Rows = grdRecibimos.Rows + 1
'        grdRecibimos.TextMatrix(cuenta, 0) = cuenta & "  "
'        grdRecibimos.TextMatrix(cuenta, 1) = Format(FechaAmortiza, gsc_FechaDMA)
'        grdRecibimos.TextMatrix(cuenta, 2) = Format(MontoGrd, "###,###,###,##0.###0")
'        grdRecibimos.TextMatrix(cuenta, 3) = Format(ValotTasaCompra, "##0.###0")
'        grdRecibimos.TextMatrix(cuenta, 6) = IIf(optCompensa.Value = True, "Compensación" & Space(50) & "C" _
'                                            , "Ent. Fisica" & Space(50) & "E")
'
'        FechaVencAnt = FechaAmortiza
'        FechaAmortiza = CreaFechaProx(FechaAmortiza, PlazoMin, DiaAmort, DesgloseAmort)
'
'        If FechaAmortiza > FechaFin And _
'            Abs(DateDiff("d", CDate(FechaAmortiza), CDate(FechaFin))) <= 10 Then
'                     FechaAmortiza = FechaFin
'                     FechaAmortizaCap = FechaFin
'        Else
'            If Abs(DateDiff("d", CDate(FechaFin), CDate(FechaAmortiza))) <= 10 Then
'                     FechaAmortiza = FechaFin
'                     FechaAmortizaCap = FechaFin
'            End If
'        End If
'
'        '***
'        cuenta = cuenta + 1
'
'       Wend
'
'    Call CalculoInteresBonos("C") '??!!
'    Call CalculoInteresBonos("V") '??!!
'
'End Function

Function CalculoInteresModificado(TipOpcion As String)

    Dim FechaAmortiza, FechaAmortizaCap, FechaAmortizaInt As Date
    Dim FechaFin            As Date
    Dim FechaVencAnt        As Date
    Dim FTermino            As Date
    Dim FInicio             As Date
    Dim FPrimerVcto         As Date
    Dim FPagoInteres        As Date
    Dim DiasAmortCap        As Integer
    Dim DiasAmortInt        As Integer
    Dim DiaAmort            As Integer
    Dim FactorDiv           As Integer
    Dim cuenta              As Integer
    Dim MontoCapital        As Double
    Dim RestoCapital        As Double
    Dim MontoGrd            As Double
    Dim MontoAmortCap       As Double
    Dim FechaProceso        As String
    Dim DivCap              As Integer
    Dim Cuadratura          As Double
    Dim PlazoMin            As Long
    
    Dim Grilla              As Object
    Dim Cmbcapital          As Object
    Dim cmbinteres          As Object
    Dim Base                As String
    Dim Tasa                As Double
    Dim PlazoDias           As Integer
    Dim CodigoAmortizaEsp   As Integer
    Dim ValorSpread         As Double
    Dim ValorTasa           As Double

  If TipOpcion = "C" Then
        Set Grilla = grdRecibimos
        Set Cmbcapital = cmbAmortizaCapitalRecibimos
        Set cmbinteres = cmbAmortizaInteresRecibimos
        
        Base = cmbBaseCompra
        DesgloseAmortST = "M" ' SacaTipoPeriodo(cmbBaseCompra)
        Tasa = CDbl(txtTasaCompra.Text) + CDbl(txtSpreadCompra.Text)
        DiasAmortCap = ValorAmort(cmbAmortizaCapitalRecibimos, DesgloseAmortST) 'Total de dias o meses real para Amortizacion Capital
        DiasAmortInt = ValorAmort(cmbAmortizaInteresRecibimos, DesgloseAmortST)     'Total de dias o meses para Amortizacion del Interes
        PlazoDias = ValorAmort(cmbAmortizaInteresRecibimos, DesgloseAmortST)    'Total de dias o meses para Amortizacion del Interes
        FInicio = CDate(txtFecInicioRecibimos.Text)
        FTermino = CDate(txtFecTerminoRecibimos.Text)
        FPrimerVcto = CDate(txtFecPrimerVctoRecibimos.Text)
        CodigoAmortizaEsp = cmbEspecialRecibimos.ItemData(cmbEspecialRecibimos.ListIndex)
        ValorSpread = txtSpreadCompra.Text
        ValorTasa = txtTasaCompra.Text
        
  Else
        Set Grilla = grdPagamos
        Set Cmbcapital = cmbAmortizaCapitalPagamos
        Set cmbinteres = cmbAmortizaInteresPagamos
        
        Base = cmbBaseVenta
        DesgloseAmortST = "M" 'SacaTipoPeriodo(cmbBaseVenta)
        Tasa = CDbl(txtTasaVenta.Text) + CDbl(txtSpreadVenta.Text)
        DiasAmortCap = ValorAmort(cmbAmortizaCapitalPagamos, DesgloseAmortST) 'Total de dias o meses real para Amortizacion Capital
        DiasAmortInt = ValorAmort(cmbAmortizaInteresPagamos, DesgloseAmortST)     'Total de dias o meses para Amortizacion del Interes
        PlazoDias = ValorAmort(cmbAmortizaInteresPagamos, DesgloseAmortST)
        FInicio = CDate(txtFecInicioPagamos.Text)
        FTermino = CDate(txtFecTerminoPagamos.Text)
        FPrimerVcto = CDate(txtFecPrimerVctoPagamos.Text)
        CodigoAmortizaEsp = cmbEspecialPagamos.ItemData(cmbEspecialPagamos.ListIndex)
        ValorSpread = txtSpreadVenta.Text
        ValorTasa = txtTasaVenta.Text
        
  End If
  
  Grilla.TextMatrix(0, 2) = Trim("Amortización " & Trim(Mid(Cmbcapital, 1, 50)))
  Grilla.TextMatrix(0, 4) = Trim("Interés " & Trim(Mid(cmbinteres, 1, 50)))
  
  Grilla.Rows = 1
                    
    
    cuenta = 1
    FactorDiv = 1
    MontoCapital = CDbl(txtCapital.Text)                             'Monto Capital
    '---- Define fechas para generar Flujos
    FechaProceso = IIf(cOperSwapST = "Ingreso", gsBAC_Fecp, FechaCierre)
    FechaFin = FTermino
    FechaVencAnt = FInicio
    
    If DiasAmortCap > DiasAmortInt Then
        PlazoMin = DiasAmortInt
    
    Else
       PlazoMin = IIf(DiasAmortCap > 0, DiasAmortCap, DiasAmortInt)
    
    End If
    
    Select Case CodigoAmortizaEsp
        Case 0      'NORMAL
            'Para los casos que el período es BULLET ó BONO Amortizacion de monto en fecha final
            DiaAmort = Day(FInicio)
            FechaAmortizaCap = IIf(DiasAmortCap > 0, CreaFechaProx(FInicio, DiasAmortCap, DiaAmort, DesgloseAmortST), FTermino)
            FechaAmortizaInt = CreaFechaProx(FInicio, DiasAmortInt, Day(FInicio), DesgloseAmortST)
            FechaAmortiza = FechaAmortizaInt ' FechaIniAmort
            
        Case 1      'CAPITAL
            FechaAmortizaCap = FPrimerVcto
            FechaAmortizaInt = FPrimerVcto
            FechaAmortiza = FPrimerVcto
            DiaAmort = Day(FPrimerVcto)
           
        Case 2      'INTERES
            DiaAmort = Day(FPrimerVcto)
            FechaAmortizaCap = IIf(DiasAmortCap > 0, CreaFechaProx(FPrimerVcto, DiasAmortCap, DiaAmort, DesgloseAmortST), FTermino)
            FechaAmortizaInt = FPrimerVcto
            FechaAmortiza = FPrimerVcto
    
    End Select
    
    If DiasAmortCap > 0 Then 'meb
         DivCap = DiasAmortCap 'ValorAmort(cmbAmortizaCapitalRecibimos, "M")
         FactorDiv = DateDiff("m", FechaAmortizaCap, CDate(FechaFin)) / DivCap
         'Sera cero cuando las fechas son iguales
         FactorDiv = FactorDiv + 1
    End If

    If FactorDiv = 0 Then
        MsgBox "Fechas Ingresadas no concuerdan con períodos de Amortización seleccionado", vbCritical, Msj
'        txtFecTerminoRecibimos.SetFocus
        Exit Function
    End If
 
     '***Monto a amortizar en los vctos.
    MontoAmortCap = Round((CDbl(MontoCapital) / FactorDiv), 4)
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
            FechaAmortizaCap = CreaFechaProx(FechaAmortizaCap, DiasAmortCap, DiaAmort, DesgloseAmortST)
            
        End If
        
        FPagoInteres = Format(FechaAmortiza - 2, gsc_FechaDMA)
        If Not BacEsHabil(Format(FPagoInteres, gsc_FechaDMA)) Then
            FPagoInteres = BacPrevHabil(Format(FPagoInteres, gsc_FechaDMA))
        End If
        
        Grilla.Rows = Grilla.Rows + 1
        Grilla.TextMatrix(cuenta, 0) = cuenta & "  "
        Grilla.TextMatrix(cuenta, 1) = Format(FechaAmortiza, gsc_FechaDMA)
        Grilla.TextMatrix(cuenta, 2) = Format(MontoGrd, "###,###,###,##0.###0")
        Grilla.TextMatrix(cuenta, 3) = Format(Tasa, "##0.####0")
        Grilla.TextMatrix(cuenta, 6) = IIf(optCompensa.Value = True, "Compensación" & Space(50) & "C" _
                                            , "Ent. Fisica" & Space(50) & "E")
        Grilla.TextMatrix(cuenta, 14) = Format(FPagoInteres, gsc_FechaDMA)
        
        FechaVencAnt = FechaAmortiza
        FechaAmortiza = CreaFechaProx(FechaAmortiza, PlazoMin, DiaAmort, DesgloseAmortST)
        
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
        '***
        cuenta = cuenta + 1
        
    Wend

Dim I As Integer
I = PlazoMin
    
    If Grilla.Rows = 1 Then
        MsgBox "Fechas Definidas no cubren Período Mínimo", vbCritical, Msj
        Toolbar1.Buttons(2).Enabled = False
        If TipOpcion = "C" Then txtFecTerminoRecibimos.SetFocus Else txtFecTerminoPagamos.SetFocus
        Exit Function
        
    End If
    
    Call CalculoInteresBonos(TipOpcion)
        
End Function

Function SugerirFechaPrimVecto(Operacion As String)
Dim DiasCap, DiasInt As Integer

    'Sugiere fecha Primer y Ultimo vencimiento
    DesgloseAmortST = "M" 'SacaTipoPeriodo(cmbBaseVenta)
    
    If Operacion = "R" Then
    
        If cmbAmortizaCapitalRecibimos.ListIndex = -1 Or cmbAmortizaInteresRecibimos.ListIndex = -1 Then
            txtFecPrimerVctoRecibimos.Text = CreaFechaProx(txtFecInicioRecibimos.Text, 1, Day(txtFecInicioRecibimos.Text), DesgloseAmortST)
        Else
            DiasCap = ValorAmort(cmbAmortizaCapitalRecibimos, DesgloseAmortST)
            DiasInt = ValorAmort(cmbAmortizaInteresRecibimos, DesgloseAmortST)
            
            DiasCap = IIf(DiasCap <= 0, DiasInt, DiasCap)
            
            'Primer Vencimiento
            txtFecPrimerVctoRecibimos.Text = CreaFechaProx(txtFecInicioRecibimos.Text, DiasCap, Day(txtFecInicioRecibimos.Text), DesgloseAmortST)
            lblFechaPrimerAmortRecibimos = BacFechaStr(txtFecPrimerVctoRecibimos.Text)
            'Primer Ultimo Vencimiento
            txtFecTerminoRecibimos.Text = txtFecPrimerVctoRecibimos.Text
            lblFechaTerminoRecibimos = BacFechaStr(txtFecTerminoRecibimos.Text)
        End If
        
    Else
    
        If cmbAmortizaCapitalPagamos.ListIndex = -1 Or cmbAmortizaInteresPagamos.ListIndex = -1 Then
            txtFecPrimerVctoPagamos.Text = CreaFechaProx(txtFecInicioPagamos.Text, 1, Day(txtFecInicioPagamos.Text), DesgloseAmortST)
        Else
            DiasCap = ValorAmort(cmbAmortizaCapitalPagamos, DesgloseAmortST)
            DiasInt = ValorAmort(cmbAmortizaInteresPagamos, DesgloseAmortST)
            
            DiasCap = IIf(DiasCap <= 0, DiasInt, DiasCap)
            
            'Primer Vencimiento
            txtFecPrimerVctoPagamos.Text = CreaFechaProx(txtFecInicioPagamos.Text, DiasCap, Day(txtFecInicioPagamos.Text), DesgloseAmortST)
            lblFechaPrimerAmortPagamos = BacFechaStr(txtFecPrimerVctoPagamos.Text)
            'Primer Ultimo Vencimiento
            txtFecTerminoPagamos.Text = txtFecPrimerVctoPagamos.Text
            lblFechaTerminoPagamos = BacFechaStr(txtFecTerminoPagamos.Text)
            
        End If
    
    End If
    
End Function

Function RecalcularInteres(Base, filGrd As Integer, ByRef Grd As Object)
    Dim Tasa As Double
    Dim Spread As Double
    Dim FechaAmortiza, FechaVencAnt As Date
    Dim DiasDif, cuenta As Integer
    Dim MontoAmortiza, MontoCapital As Double
    Dim Interes, Plazo, MontoCalcAmort, MontoAmortCap As Double
    Dim ObjetoGrid As Object
    Dim TotalVenc As Double
    Dim FInicio As Date
    
    Spread = 0
  
    If tabFlujos.Tag = "Recibimos" Then
      Set ObjetoGrid = grdRecibimos
      FInicio = CDate(txtFecInicioRecibimos.Text)
      
    Else
      Set ObjetoGrid = grdPagamos
      FInicio = CDate(txtFecInicioPagamos.Text)
      
    End If
    
  With ObjetoGrid
 
    MontoCapital = CDbl(txtCapital.Text)   'Monto Capital
    Tasa = RecTasa                                   'Tasa
    MontoAmortiza = RecMontoResto        'Monto Amortizado en el Calculo de interes
    MontoAmortCap = RecMontoAmort     'Monto que vence ("amortizado")
    
    FechaAmortiza = RecFecha                  'Fecha de Vencimiento o Amortizacion
    FechaVencAnt = RecFecVencAnt        'Fecha Vcto. anterior
    
    If filGrd = 0 Then                                  'Primera fila
        DiasDif = DateDiff("d", FInicio, CDate(FechaAmortiza))     'Dias distancia
    Else
       DiasDif = DateDiff("d", CDate(FechaVencAnt), CDate(FechaAmortiza))      'Dias distancia
    End If

    '*** Calculo
    Plazo = DiasDif / Val(Base)
    Interes = Round(MontoAmortiza * ((Tasa / 100) + (Spread / 100)) * (Plazo), 4)
    
    '***
    TotalVenc = MontoAmortCap + Interes
    cuenta = filGrd                                      'Posicion del registro en el arreglo
    
    '***Traspaso de datos a Arreglo
    Grd.TextMatrix(cuenta, 0) = cuenta & "  "
    Grd.TextMatrix(cuenta, 1) = FechaAmortiza
    Grd.TextMatrix(cuenta, 2) = Format(MontoAmortCap, "###,###,###,##0.###0") '
    Grd.TextMatrix(cuenta, 4) = Format(Interes, "###,###,###,##0.###0") ' Interes
    Grd.TextMatrix(cuenta, 3) = Format(Tasa, "###0.###0")
    Grd.TextMatrix(cuenta, 5) = Format(TotalVenc, "###,###,###,##0.###0") ' total vencimiento
    '***
    
    End With

End Function


Private Sub Form_Unload(Cancel As Integer)

    Set objMoneda = Nothing
    If cOperSwapST = "ModificacionCartera" Or cOperSwapST = "Modificacion" Then
        BacConsultaOper.Show
    End If

End Sub

Private Sub grdPagamos_EnterCell()

With grdPagamos

    If .TextMatrix(.Row, 13) = "CH" Then Exit Sub ' Si es modificacion de cartera los flujos de cartera

    txtTasaPag.Visible = False
    txtAmortizaPag.Visible = False
    cmbModalidadPag.Visible = False
    txtFechaPag.Visible = False
    txtTasaPag.Text = 0
    txtAmortizaPag.Text = 0
    
    If .Row = 0 Then Exit Sub 'Or Operacion <> "V" Then Exit Sub
    
    Select Case .Col
        Case 1
        txtFechaPag.Left = .CellLeft + 50
        txtFechaPag.Top = .CellTop + 410
        txtFechaPag.Text = .TextMatrix(.Row, 1)
        txtFechaPag.Width = .CellWidth
        txtFechaPag.Enabled = True
        txtFechaPag.Tag = .Row
        txtFechaPag.Visible = True
        txtFechaPag.SetFocus
    
    Case 2
        If TipoAm = -1 Then
            'cambio en monto amortizacion
            txtAmortizaPag.Left = .CellLeft + 50
            txtAmortizaPag.Top = .CellTop + 410
            txtAmortizaPag.Text = .TextMatrix(.Row, 2)
            txtAmortizaPag.Tag = .Row
            txtAmortizaPag.Enabled = True
            txtAmortizaPag.Visible = True
            txtAmortizaPag.SetFocus
        End If

    Case 6
        cmbModalidadPag.Left = .CellLeft + 30
        cmbModalidadPag.Top = .CellTop + 410
        cmbModalidadPag.ListIndex = IIf(Right(.TextMatrix(.Row, 6), 1) = "C", 0, 1)
        cmbModalidadPag.Tag = .Row
        cmbModalidadPag.Visible = True
        cmbModalidadPag.SetFocus
        
    Case 14
        txtFechaPag.Left = .CellLeft + 50
        txtFechaPag.Top = .CellTop + 410
        txtFechaPag.Text = .TextMatrix(.Row, .Col)
        txtFechaPag.Width = .CellWidth
        txtFechaPag.Enabled = True
        txtFechaPag.Tag = .Row
        txtFechaPag.Visible = True
        txtFechaPag.SetFocus
        
    End Select

End With

End Sub

Private Sub grdPagamos_LostFocus()

Dim I As Integer
Dim SumAmort As Double
Dim Res

'    SumAmort = 0
'    If grdRecibimos.TextMatrix(i, 2) = "" Then Exit Sub
'
'    If TipoAm = -1 And Operacion = "V" Then
'        'Amortizacion de capital BONOS
'        For i = 1 To grdPagamos.Rows - 1
'            SumAmort = SumAmort + CDbl(grdPagamos.TextMatrix(i, 2))
'        Next
'        If SumAmort <> CDbl(txtCapital.Text) Then
'            Res = MsgBox("Amortización acumulada no corresponde. ¿Recalcular Montos con Cambio?", vbQuestion + vbYesNo, Msj)
'            If Res = vbYes Then
'                txtCapital.Text = SumAmort
'                Call CalculoInteresBonos(cmbBaseCompra, grdRecibimos)
'                Call CalculoInteresBonos(cmbBaseVenta, grdPagamos)
'            End If
'        End If
'    End If

End Sub

Private Sub grdPagamos_Scroll()
    cmbModalidadPag.Visible = False
    txtTasaPag.Visible = False
    txtAmortizaPag.Visible = False

End Sub

Private Sub grdRecibimos_EnterCell()
With grdRecibimos
   If .TextMatrix(.Row, 13) = "CH" Then
      Exit Sub ' Si es modificacion de cartera los flujos de cartera
   End If
   txtTasa.Visible = False
   txtAmortiza.Visible = False
   cmbModalidad.Visible = False
   txtFechaRecib.Visible = False
   txtTasa.Text = 0
   txtAmortiza.Text = 0
   
   If .Row = 0 Then
      Exit Sub
   End If
   
   Select Case .Col
      Case 1 '--> Fecha
         txtFechaRecib.Left = .CellLeft + 50
         txtFechaRecib.Top = .CellTop + 410
         txtFechaRecib.Text = .TextMatrix(.Row, 1)
         txtFechaRecib.Width = .CellWidth
         txtFechaRecib.Tag = .Row
         txtFechaRecib.Enabled = True
         txtFechaRecib.Visible = True
         txtFechaRecib.SetFocus
      Case 2 '--> Cambio Monto Amortizacion
         If TipoAm = -1 Then
            'cambio en monto amortizacion
            txtAmortiza.Left = .CellLeft + 50
            txtAmortiza.Top = .CellTop + 410
            txtAmortiza.Text = .TextMatrix(.Row, 2)
            txtAmortiza.Tag = .Row
            txtAmortiza.Enabled = True
            txtAmortiza.Visible = True
            txtAmortiza.SetFocus
        End If
      Case 6 '--> Tasa + Spread
         cmbModalidad.Left = .CellLeft + 30
         cmbModalidad.Top = .CellTop + 410
         cmbModalidad.ListIndex = IIf(Right(.TextMatrix(.Row, 6), 1) = "C", 0, 1)
         cmbModalidad.Tag = .Row
         cmbModalidad.Visible = True
         cmbModalidad.SetFocus
      Case 14
         txtFechaRecib.Left = .CellLeft + 50
         txtFechaRecib.Top = .CellTop + 410
         txtFechaRecib.Text = .TextMatrix(.Row, .Col)
         txtFechaRecib.Width = .CellWidth
         txtFechaRecib.Tag = .Row
         txtFechaRecib.Enabled = True
         txtFechaRecib.Visible = True
         txtFechaRecib.SetFocus
   End Select
End With
End Sub

Private Sub grdRecibimos_Scroll()
    cmbModalidad.Visible = False
    txtTasa.Visible = False
    txtAmortiza.Visible = False
    txtFechaRecib.Visible = False

End Sub






Private Sub tabFlujos_Click(PreviousTab As Integer)

Select Case PreviousTab
    Case 1
        cmbModalidad.Visible = False
        txtTasa.Visible = False
        txtAmortiza.Visible = False
    Case 2
        cmbModalidadPag.Visible = False
        txtTasaPag.Visible = False
        txtAmortizaPag.Visible = False
End Select

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
   On Error GoTo err
    Select Case Button.Index
        Case 1
            btnCalcular_Click
        Case 2
            If ValidaAmortizaciones = True Then
               Call btnGrabar_Click
            End If
        Case 3
            Call LimpiarDatos
            Lbl_Num_Oper_Oculto = 0
            cOperSwapST = "Ingreso"
            etqNumOper.Visible = False

        Case 4
            Unload Me
        
    End Select
Exit Sub

err:
If err.Number = 365 Then
    Exit Sub
End If

End Sub

Private Function ValidaAmortizaciones() As Boolean
   Dim iContador        As Long
   Dim iSumaPagamos     As Double
   Dim iSumaRecibimos   As Double
   
   ValidaAmortizaciones = True
   
   iSumaPagamos = 0#
   For iContador = 1 To grdPagamos.Rows - 1
      iSumaPagamos = iSumaPagamos + grdPagamos.TextMatrix(iContador, 2)
   Next iContador
   
   iSumaRecibimos = 0#
   For iContador = 1 To grdRecibimos.Rows - 1
      iSumaRecibimos = iSumaRecibimos + grdRecibimos.TextMatrix(iContador, 2)
   Next iContador
   
   If iSumaPagamos = iSumaRecibimos Then
      ValidaAmortizaciones = True
   End If
   
End Function

Private Sub txtAmortiza_KeyPress(KeyAscii As Integer)
   Dim I          As Integer
   Dim SumAmort   As Double

   If KeyAscii = vbKeyEscape Then
      grdRecibimos.SetFocus
      txtAmortiza.Visible = False
      Exit Sub
   End If
   If KeyAscii <> 13 Then
      Exit Sub
   End If
    
   If grdRecibimos.Col <> 2 Then
      Exit Sub
   End If
   
   If txtAmortiza.Text <> grdRecibimos.TextMatrix(grdRecibimos.Row, 2) Then
      SumAmort = 0
      If grdRecibimos.TextMatrix(I, 2) = "" Then
         Exit Sub
      End If
      If TipoAm = -1 And OperacionST = "C" Then
         If Not ValidaModificaciones(grdRecibimos) Then
            'Amortizacion de capital BONOS
            For I = 1 To grdRecibimos.Rows - 1
               If I = Val(grdRecibimos.Row) Then
                  SumAmort = SumAmort + CDbl(txtAmortiza.Text)
               Else
                  SumAmort = SumAmort + CDbl(grdRecibimos.TextMatrix(I, 2))
               End If
            Next I
            
            grdRecibimos.TextMatrix(grdRecibimos.Row, 2) = txtAmortiza.Text
            
           ' If SumAmort <> CDbl(txtCapital.Text) Then
           '    If MsgBox("Amortización acumulada no corresponde. ¿Recalcular Montos con Cambio?", vbQuestion + vbYesNo, Msj) = vbYes Then
           '       grdRecibimos.TextMatrix(grdRecibimos.Row, 2) = txtAmortiza.Text
                 ' txtCapital.Text = SumAmort
                 Call CalculoInteresBonos("C")
                 Call CalculoInteresBonos("V")
           '    End If
           ' End If
         
         End If
      End If
   End If
   txtAmortiza.Visible = False
   txtAmortiza.Text = 0
   grdRecibimos.SetFocus
End Sub

Private Sub txtAmortizaPag_KeyPress(KeyAscii As Integer)
   Dim I          As Integer
   Dim SumAmort   As Double

   If KeyAscii = vbKeyEscape Then
      grdPagamos.SetFocus
      txtAmortizaPag.Visible = False
      Exit Sub
   End If
   
   If KeyAscii <> 13 Then
      Exit Sub
   End If
    
   If grdPagamos.Col <> 2 Then
      Exit Sub
   End If
   
   If txtAmortizaPag.Text <> grdPagamos.TextMatrix(grdPagamos.Row, 2) Then
      SumAmort = 0
      If grdPagamos.TextMatrix(I, 2) = "" Then
         Exit Sub
      End If
      If TipoAm = -1 And OperacionST = "C" Then
     'If TipoAm = -1 And OperacionST = "V" Then
         If Not ValidaModificaciones(grdPagamos) Then
            'Amortizacion de capital BONOS
            For I = 1 To grdPagamos.Rows - 1
               If I = Val(grdPagamos.Row) Then
                  SumAmort = SumAmort + CDbl(txtAmortizaPag.Text)
               Else
                  SumAmort = SumAmort + CDbl(grdPagamos.TextMatrix(I, 2))
               End If
            Next I
            
            grdPagamos.TextMatrix(grdPagamos.Row, 2) = txtAmortizaPag.Text
           ' If SumAmort <> CDbl(txtCapital.Text) Then
           '    If MsgBox("Amortización acumulada no corresponde. ¿Recalcular Montos con Cambio?", vbQuestion + vbYesNo, Msj) = vbYes Then
                  'grdRecibimos.TextMatrix(grdPagamos.Row, 2) = txtAmortizaPag.Text
           '       grdPagamos.TextMatrix(grdPagamos.Row, 2) = txtAmortizaPag.Text
                 ' txtCapital.Text = SumAmort
                 Call CalculoInteresBonos("C")
                 Call CalculoInteresBonos("V")
           '    End If
           ' End If
         End If
      End If
   End If
   
   txtAmortizaPag.Visible = False
   txtAmortizaPag.Text = 0
   grdPagamos.SetFocus
End Sub



Private Sub txtFechaPag_KeyPress(KeyAscii As Integer)
    Call FechaVenceFlujo(txtFechaPag, KeyAscii, "V")

End Sub

Private Sub txtFechaPag_KeyUp(KeyCode As Integer, Shift As Integer)

With grdPagamos
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

Private Sub txtFechaRecib_KeyPress(KeyAscii As Integer)
   Call FechaVenceFlujo(txtFechaRecib, KeyAscii, "C")

End Sub

Private Sub txtFechaRecib_KeyUp(KeyCode As Integer, Shift As Integer)

    With grdRecibimos
    
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

Private Sub txtFecInicioRecibimos_Change()

    txtFecInicioRecibimos.Text = Format(txtFecInicioRecibimos.Text, gsc_FechaDMA)
    lblFechaInicioRecibimos.Caption = BacFechaStr(txtFecInicioRecibimos.Text)
    
    If Not BacEsHabil(txtFecInicioRecibimos.Text) Then
        lblFechaInicioRecibimos.ForeColor = vbRed
    Else
        lblFechaInicioRecibimos.ForeColor = vbBlue
    End If
    
End Sub

Private Sub txtFecInicioRecibimos_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        If ValidaFechasIngreso(1, "R") Then
            txtFecTerminoRecibimos.SetFocus
        End If
    End If

End Sub

Private Sub txtFecInicioRecibimos_LostFocus()

    Call txtFecInicioRecibimos_Change
   
    If ValidaFechasIngreso(1, "R") Then
        
    End If

End Sub

Private Sub txtFecPrimerVctoRecibimos_Change()

    txtFecPrimerVctoRecibimos.Text = Format(txtFecPrimerVctoRecibimos.Text, gsc_FechaDMA)
    lblFechaPrimerAmortRecibimos.Caption = BacFechaStr(txtFecPrimerVctoRecibimos.Text)
    
    If Not BacEsHabil(txtFecPrimerVctoRecibimos.Text) Then
        lblFechaPrimerAmortRecibimos.ForeColor = vbRed
    Else
        lblFechaPrimerAmortRecibimos.ForeColor = vbBlue
    End If

End Sub

Private Sub txtFecPrimerVctoRecibimos_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        If ValidaFechasIngreso(2, "R") Then
            txtFecPrimerVctoRecibimos.SetFocus
        End If
    End If
    
End Sub

Private Sub txtFecPrimerVctoRecibimos_LostFocus()
    Call txtFecPrimerVctoRecibimos_Change
    Call ValidaFechasIngreso(2, "R")

End Sub

Private Sub txtFecTerminoRecibimos_Change()

    txtFecTerminoRecibimos.Text = Format(txtFecTerminoRecibimos.Text, gsc_FechaDMA)
    lblFechaTerminoRecibimos.Caption = BacFechaStr(txtFecTerminoRecibimos.Text)
    
    If Not BacEsHabil(txtFecTerminoRecibimos.Text) Then
        lblFechaTerminoRecibimos.ForeColor = vbRed
    Else
        lblFechaTerminoRecibimos.ForeColor = vbBlue
    End If
    
End Sub

Private Sub txtFecTerminoRecibimos_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
    
        If ValidaFechasIngreso(3, "R") Then
        
            If optCompensa.Value = True Then
                optCompensa.SetFocus
            Else
                optEntFisica.SetFocus
            End If
            
        End If
        
    End If
    
End Sub

Private Sub txtFecTerminoRecibimos_LostFocus()
    Call ValidaFechasIngreso(3, "R")

End Sub


Private Sub txtSpreadCompra_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        If cmbBaseCompra.Enabled Then
            cmbBaseCompra.SetFocus
        End If
    End If

End Sub

Private Sub txtSpreadVenta_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        If cmbBaseVenta.Enabled Then
            cmbBaseVenta.SetFocus
        End If
    End If

End Sub

Private Sub txtTasa_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
    
        With grdRecibimos
            
            If .Col = 3 Then
            
                 If txtTasa.Text <> .TextMatrix(.Row, 3) Then
                     .TextMatrix(.Row, 3) = txtTasa.Text
                     
                     If Not ValidaModificaciones(grdRecibimos) Then
                        tabFlujos.Tag = "Recibimos"
                        RecFecha = .TextMatrix(.Row, 1)                   'Fecha Amortizacion
                        RecTasa = .TextMatrix(.Row, 3)                     'Valor Tasa
                        RecMontoResto = .TextMatrix(.Row, 8)          'Monto Restante del Capital no amortizado
                        RecMontoAmort = .TextMatrix(.Row, 2)         'Monto amortizado
                        RecFecVencAnt = .TextMatrix(.Row, 9)         'Fecha de Vencimiento Anterior
                        Call CalculoInteresBonos("C")
                        'Call RecalcularInteres(cmbBaseCompra, .Row, grdRecibimos)
                    End If
                    
                End If
                
            End If
            txtTasa.Visible = False
            txtTasa.Text = 0
            .SetFocus
            
        End With
        
    End If

End Sub

Private Sub txtTasa_KeyUp(KeyCode As Integer, Shift As Integer)

    With grdRecibimos
    
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

Private Sub txtTasaCompra_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then txtSpreadCompra.SetFocus

End Sub

Private Sub txtTasaCompra_LostFocus()

    'If txtTasaCompra.Text <> "" Then
        If Not IsNumeric(txtTasaCompra.Text) Then
            MsgBox "Monto de Tasa de Compra está incorrecto", vbInformation, Msj
            txtTasaCompra.SetFocus
        End If
    'End If

End Sub

Private Sub txtTasaPag_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
    
        With grdPagamos
        
            If .Col = 3 Then
            
                 If txtTasaPag.Text <> .TextMatrix(.Row, 3) Then
                     .TextMatrix(.Row, 3) = txtTasaPag.Text
                     
                     If Not ValidaModificaciones(grdPagamos) Then
                        tabFlujos.Tag = "Pagamos"
                        RecFecha = .TextMatrix(.Row, 1)                   'Fecha Amortizacion
                        RecTasa = .TextMatrix(.Row, 3)                     'Valor Tasa
                        RecMontoResto = .TextMatrix(.Row, 8)          'Monto Restante del Capital no amortizado
                        RecMontoAmort = .TextMatrix(.Row, 2)         'Monto amortizado
                        RecFecVencAnt = .TextMatrix(.Row, 9)         'Fecha de Vencimiento Anterior
                        
                        Call RecalcularInteres(cmbBaseVenta, .Row, grdPagamos)
                    End If
                    
                End If
                
            End If
            txtTasaPag.Visible = False
            txtTasaPag.Text = 0
            .SetFocus
            
        End With
        
    End If

End Sub

Private Sub txtTasaPag_KeyUp(KeyCode As Integer, Shift As Integer)
    
    With grdPagamos
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

Private Sub txtTasaVenta_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then txtSpreadVenta.SetFocus

End Sub

Private Sub txtTasaVenta_LostFocus()

    If txtTasaVenta.Text <> "" Then
    
        If Not IsNumeric(txtTasaVenta.Text) Then
            MsgBox "Monto en Tasa de Venta está incorrecto", vbInformation, Msj
            txtTasaVenta.SetFocus
        End If
        
    End If

End Sub

Private Sub txtFecIniciopagamos_Change()

    txtFecInicioPagamos.Text = Format(txtFecInicioPagamos.Text, gsc_FechaDMA)
    lblFechaInicioPagamos.Caption = BacFechaStr(txtFecInicioPagamos.Text)
    
    If Not BacEsHabil(txtFecInicioPagamos.Text) Then
        lblFechaInicioPagamos.ForeColor = vbRed
    Else
        lblFechaInicioPagamos.ForeColor = vbBlue
    End If
    
End Sub

Private Sub txtFecIniciopagamos_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        If ValidaFechasIngreso(1, "P") Then
            txtFecTerminoPagamos.SetFocus
        End If
    End If

End Sub

Private Sub txtFecIniciopagamos_LostFocus()

    Call txtFecIniciopagamos_Change

    If ValidaFechasIngreso(1, "P") Then
        
    End If

End Sub

Private Sub txtFecPrimerVctoPagamos_Change()

    txtFecPrimerVctoPagamos.Text = Format(txtFecPrimerVctoPagamos.Text, gsc_FechaDMA)
    lblFechaPrimerAmortPagamos.Caption = BacFechaStr(txtFecPrimerVctoPagamos.Text)
    
    If Not BacEsHabil(txtFecPrimerVctoPagamos.Text) Then
        lblFechaPrimerAmortPagamos.ForeColor = vbRed
    Else
        lblFechaPrimerAmortPagamos.ForeColor = vbBlue
    End If

End Sub

Private Sub txtFecPrimerVctoPagamos_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        If ValidaFechasIngreso(2, "P") Then
            txtFecPrimerVctoPagamos.SetFocus
        End If
    End If
    
End Sub

Private Sub txtFecPrimerVctoPagamos_LostFocus()

    Call txtFecPrimerVctoPagamos_Change
    Call ValidaFechasIngreso(2, "P")

End Sub

Private Sub txtFecTerminoPagamos_Change()

    txtFecTerminoPagamos.Text = Format(txtFecTerminoPagamos.Text, gsc_FechaDMA)
    lblFechaTerminoPagamos.Caption = BacFechaStr(txtFecTerminoPagamos.Text)
    
    If Not BacEsHabil(txtFecTerminoPagamos.Text) Then
        lblFechaTerminoPagamos.ForeColor = vbRed
    Else
        lblFechaTerminoPagamos.ForeColor = vbBlue
    End If
    
End Sub

Private Sub txtFecTerminoPagamos_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
    
        If ValidaFechasIngreso(3, "P") Then
        
            If optCompensa.Value = True Then
                optCompensa.SetFocus
            Else
                optEntFisica.SetFocus
            End If
            
        End If
        
    End If
    
End Sub

Private Sub txtFecTerminoPagamos_LostFocus()
    
    Call txtFecTerminoPagamos_Change
    Call ValidaFechasIngreso(3, "P")

End Sub

Private Sub cmbEspecialpagamos_Click()

    If cmbEspecialPagamos.ListIndex < 0 Then
        cmbEspecialPagamos.ListIndex = 0
    End If
    
    If Not txtFecPrimerVctoPagamos.Visible Then
        txtFecPrimerVctoPagamos.Text = txtFecInicioPagamos.Text
    End If
    
    txtFecPrimerVctoPagamos.Enabled = (cmbEspecialPagamos.ItemData(cmbEspecialPagamos.ListIndex) > 0)
    txtFecPrimerVctoPagamos.Visible = txtFecPrimerVctoPagamos.Enabled
    lblFechaPrimerAmortPagamos.Visible = txtFecPrimerVctoPagamos.Enabled
    
End Sub

Private Sub CargaTasaMoneda(ByRef objCarga As ComboBox, ByVal CodMoneda As Integer, ByVal CodTasa As Integer, ByVal CodPeriodo As Integer)
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(CodMoneda)
   AddParam Envia, CDbl(CodTasa)
   AddParam Envia, CDbl(CodPeriodo)
   
   If MiTipoSwap = [Swap de Tasas] Then
      AddParam Envia, CDbl(OP_SWAP_TASAS)
   End If
   If MiTipoSwap = [Swap Promedio Camara] Then
      AddParam Envia, CDbl(OP_SWAP_PROMCAM)
   End If
   
   If Not Bac_Sql_Execute("SP_RETORNA_TASAMONEDA", Envia) Then
      Exit Sub
   End If
   
   Call BacControlWindows(10)
   objCarga.Clear
   Do While Bac_SQL_Fetch(Datos())
      If Not IsNull(Datos(2)) Then
         objCarga.AddItem Datos(2)
         objCarga.ItemData(objCarga.NewIndex) = CDbl(Datos(1))
      End If
   Loop
   
End Sub


Private Sub BuscarTasaAsiganada(ByVal MiTasa As String, ByRef MiObjesto As ComboBox)
   Dim iContador  As Integer
   
   For iContador = 0 To MiObjesto.ListCount - 1
      If MiObjesto.List(MiObjesto) = MiTasa Then
         MiObjesto.ListIndex = iContador
         Exit For
      End If
   Next iContador
   
End Sub
