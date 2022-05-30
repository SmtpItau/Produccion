VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{7A91A839-9639-11D5-B8E0-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form BacOpeSwapTasa 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Swap de Tasas"
   ClientHeight    =   6690
   ClientLeft      =   1425
   ClientTop       =   2325
   ClientWidth     =   10935
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   -1  'True
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "bacswapt.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6690
   ScaleWidth      =   10935
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   76
      Top             =   0
      Width           =   10875
      _ExtentX        =   19182
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
            Object.ToolTipText     =   "Calcular Flujo"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.ToolTipText     =   "Grabar"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.ToolTipText     =   "Limpiar"
            Object.Tag             =   ""
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   ""
            ImageIndex      =   4
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame3 
      Height          =   750
      Left            =   45
      TabIndex        =   48
      Top             =   5895
      Width           =   10890
      Begin VB.CommandButton btnSalir 
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
         Left            =   9540
         Picture         =   "bacswapt.frx":030A
         Style           =   1  'Graphical
         TabIndex        =   54
         Top             =   1830
         Visible         =   0   'False
         Width           =   1300
      End
      Begin VB.CommandButton btnNuevo 
         Caption         =   "&Limpiar"
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
         Left            =   8190
         Picture         =   "bacswapt.frx":0614
         Style           =   1  'Graphical
         TabIndex        =   53
         Top             =   1830
         Visible         =   0   'False
         Width           =   1300
      End
      Begin VB.CommandButton btnGrabar 
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
         Left            =   6840
         Picture         =   "bacswapt.frx":091E
         Style           =   1  'Graphical
         TabIndex        =   52
         Top             =   1830
         Visible         =   0   'False
         Width           =   1300
      End
      Begin VB.Frame framBarra 
         Height          =   510
         Left            =   135
         TabIndex        =   50
         Top             =   135
         Visible         =   0   'False
         Width           =   5190
         Begin ComctlLib.ProgressBar Barra 
            Height          =   240
            Left            =   90
            TabIndex        =   51
            Top             =   180
            Width           =   5010
            _ExtentX        =   8837
            _ExtentY        =   423
            _Version        =   327682
            Appearance      =   1
         End
      End
      Begin VB.CommandButton btnCalcular 
         Caption         =   "&Calcular Flujo"
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
         Left            =   5520
         Picture         =   "bacswapt.frx":0D60
         Style           =   1  'Graphical
         TabIndex        =   49
         Top             =   1830
         Visible         =   0   'False
         Width           =   1300
      End
      Begin VB.Label EtqMensaje 
         Caption         =   "Label1"
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
         Left            =   585
         TabIndex        =   57
         Top             =   315
         Width           =   3885
      End
      Begin VB.Label Simbologia 
         BackColor       =   &H00FFFFC0&
         BorderStyle     =   1  'Fixed Single
         Height          =   240
         Left            =   7155
         TabIndex        =   56
         Top             =   315
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
         Index           =   22
         Left            =   7560
         TabIndex        =   55
         Top             =   360
         Width           =   1305
      End
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
      Height          =   1530
      Left            =   5490
      TabIndex        =   36
      Top             =   495
      Width           =   5430
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
         Left            =   1440
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   4
         ToolTipText     =   "Operador de Cliente (si no hay opciones, defina Cliente)"
         Top             =   1080
         Width           =   3840
      End
      Begin VB.TextBox txtCliente 
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
         Left            =   1440
         MaxLength       =   50
         MouseIcon       =   "bacswapt.frx":106A
         MousePointer    =   99  'Custom
         TabIndex        =   3
         Text            =   "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
         ToolTipText     =   "Nombre de Cliente (Doble Click invoca ayuda)"
         Top             =   720
         Width           =   3840
      End
      Begin VB.TextBox txtRut 
         Alignment       =   1  'Right Justify
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
         Left            =   180
         MaxLength       =   13
         MouseIcon       =   "bacswapt.frx":1374
         MousePointer    =   99  'Custom
         TabIndex        =   2
         Text            =   "999.999.999-K"
         ToolTipText     =   "Rut de Cliente (Doble Click invoca ayuda)"
         Top             =   720
         Width           =   1245
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Cliente"
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
         Index           =   21
         Left            =   225
         TabIndex        =   38
         Top             =   405
         Width           =   600
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
         Left            =   210
         TabIndex        =   37
         Top             =   1125
         Width           =   780
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
      Height          =   1455
      Left            =   5520
      TabIndex        =   25
      Top             =   1980
      Width           =   5445
      Begin BACControles.TXTNumero txtTasaVenta 
         Height          =   300
         Left            =   1320
         TabIndex        =   68
         Top             =   690
         Width           =   975
         _ExtentX        =   1720
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
         Max             =   "999.999999"
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
         TabIndex        =   9
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
         Left            =   1305
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   10
         ToolTipText     =   "Base en que se encuentra expresada Tasa (para calculo de intereses)"
         Top             =   1005
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
         TabIndex        =   11
         ToolTipText     =   "Moneda con equivalente del documento"
         Top             =   690
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
         TabIndex        =   12
         ToolTipText     =   "Documento con el que Pagaremos"
         Top             =   1005
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
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   14
         Left            =   165
         TabIndex        =   30
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
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   13
         Left            =   165
         TabIndex        =   29
         Top             =   690
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
         TabIndex        =   28
         Top             =   690
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
         Left            =   165
         TabIndex        =   27
         Top             =   1005
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
         TabIndex        =   26
         Top             =   450
         Width           =   1275
      End
   End
   Begin TabDlg.SSTab tabFlujos 
      Height          =   2385
      Left            =   45
      TabIndex        =   31
      Top             =   3510
      Width           =   10935
      _ExtentX        =   19288
      _ExtentY        =   4207
      _Version        =   393216
      TabHeight       =   520
      BackColor       =   12632256
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
      TabPicture(0)   =   "bacswapt.frx":167E
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
      Tab(0).Control(5)=   "lblFechaInicio"
      Tab(0).Control(5).Enabled=   0   'False
      Tab(0).Control(6)=   "lblFechaPrimerAmort"
      Tab(0).Control(6).Enabled=   0   'False
      Tab(0).Control(7)=   "lblFechaTermino"
      Tab(0).Control(7).Enabled=   0   'False
      Tab(0).Control(8)=   "optEntFisica"
      Tab(0).Control(8).Enabled=   0   'False
      Tab(0).Control(9)=   "optCompensa"
      Tab(0).Control(9).Enabled=   0   'False
      Tab(0).Control(10)=   "cmbCarteraInversion"
      Tab(0).Control(10).Enabled=   0   'False
      Tab(0).Control(11)=   "Frame2(1)"
      Tab(0).Control(11).Enabled=   0   'False
      Tab(0).Control(12)=   "Frame4"
      Tab(0).Control(12).Enabled=   0   'False
      Tab(0).Control(13)=   "txtFecInicio"
      Tab(0).Control(13).Enabled=   0   'False
      Tab(0).Control(14)=   "txtFecPrimerVcto"
      Tab(0).Control(14).Enabled=   0   'False
      Tab(0).Control(15)=   "txtFectermino"
      Tab(0).Control(15).Enabled=   0   'False
      Tab(0).ControlCount=   16
      TabCaption(1)   =   "Flujos Recibimos"
      TabPicture(1)   =   "bacswapt.frx":169A
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "grdRecibimos"
      Tab(1).Control(1)=   "cmbModalidad"
      Tab(1).Control(2)=   "txtTasa"
      Tab(1).Control(3)=   "txtAmortiza"
      Tab(1).ControlCount=   4
      TabCaption(2)   =   "Flujos Pagamos"
      TabPicture(2)   =   "bacswapt.frx":16B6
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "txtTasapag"
      Tab(2).Control(1)=   "txtAmortizaPag"
      Tab(2).Control(2)=   "cmbModalidadPag"
      Tab(2).Control(3)=   "grdPagamos"
      Tab(2).ControlCount=   4
      Begin BACControles.TXTNumero txtTasapag 
         Height          =   255
         Left            =   -70815
         TabIndex        =   75
         Top             =   840
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
         Max             =   "999.999999"
      End
      Begin BACControles.TXTNumero txtAmortizaPag 
         Height          =   255
         Left            =   -68880
         TabIndex        =   74
         Top             =   600
         Visible         =   0   'False
         Width           =   1575
         _ExtentX        =   2778
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
         Max             =   "999.999999"
      End
      Begin BACControles.TXTNumero txtAmortiza 
         Height          =   255
         Left            =   -71400
         TabIndex        =   73
         Top             =   600
         Visible         =   0   'False
         Width           =   1575
         _ExtentX        =   2778
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
      Begin BACControles.TXTNumero txtTasa 
         Height          =   255
         Left            =   -73800
         TabIndex        =   72
         Top             =   480
         Visible         =   0   'False
         Width           =   1815
         _ExtentX        =   3201
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
         Max             =   "999.999999"
      End
      Begin BACControles.TXTFecha txtFectermino 
         Height          =   300
         Left            =   2280
         TabIndex        =   71
         Top             =   1920
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
         TabIndex        =   70
         Top             =   1560
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
         TabIndex        =   69
         Top             =   1200
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
      Begin VB.Frame Frame4 
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
         Left            =   225
         TabIndex        =   58
         Top             =   360
         Width           =   6135
         Begin VB.ComboBox cmbAmortizaCapital 
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
            Left            =   885
            Sorted          =   -1  'True
            Style           =   2  'Dropdown List
            TabIndex        =   60
            ToolTipText     =   "Período de Amortización de Capital"
            Top             =   285
            Width           =   2000
         End
         Begin VB.ComboBox cmbAmortizaInteres 
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
            Left            =   3945
            Sorted          =   -1  'True
            Style           =   2  'Dropdown List
            TabIndex        =   59
            ToolTipText     =   "Período de Amortización de Intereses"
            Top             =   270
            Width           =   2000
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   " Capital"
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
            Left            =   90
            TabIndex        =   62
            Top             =   330
            Width           =   630
         End
         Begin VB.Label lblSwapTasa 
            AutoSize        =   -1  'True
            Caption         =   " Interés"
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
            TabIndex        =   61
            Top             =   330
            Width           =   630
         End
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
         Left            =   -66495
         Style           =   2  'Dropdown List
         TabIndex        =   46
         ToolTipText     =   "Con tecla Enter acepta modificación"
         Top             =   765
         Visible         =   0   'False
         Width           =   1445
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
         Left            =   -65820
         Style           =   2  'Dropdown List
         TabIndex        =   45
         ToolTipText     =   "Con tecla Enter acepta modificación"
         Top             =   855
         Visible         =   0   'False
         Width           =   1445
      End
      Begin MSFlexGridLib.MSFlexGrid grdPagamos 
         Height          =   1680
         Left            =   -74955
         TabIndex        =   44
         Top             =   360
         Width           =   10815
         _ExtentX        =   19076
         _ExtentY        =   2963
         _Version        =   393216
         BackColor       =   12632256
         BackColorFixed  =   8421440
         ForeColorFixed  =   16777215
         GridLines       =   2
         ScrollBars      =   2
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
         Height          =   1680
         Left            =   -74955
         TabIndex        =   43
         Top             =   360
         Width           =   10815
         _ExtentX        =   19076
         _ExtentY        =   2963
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
      Begin VB.Frame Frame2 
         Height          =   1815
         Index           =   1
         Left            =   6660
         TabIndex        =   42
         Top             =   360
         Width           =   15
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
         Left            =   8850
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   16
         ToolTipText     =   "Cartera de Inversión"
         Top             =   1695
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
         Height          =   405
         Left            =   8820
         Style           =   1  'Graphical
         TabIndex        =   13
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
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   435
         Left            =   8820
         Style           =   1  'Graphical
         TabIndex        =   14
         ToolTipText     =   "Modalidad de Pago de Contrato y/o Flujos"
         Top             =   975
         Width           =   1905
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
         TabIndex        =   65
         Top             =   1935
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
         TabIndex        =   64
         Top             =   1575
         Width           =   2580
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
         TabIndex        =   63
         Top             =   1215
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
         Left            =   6870
         TabIndex        =   39
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
         Left            =   6915
         TabIndex        =   35
         Top             =   915
         Width           =   1500
      End
      Begin VB.Label lblSwapTasa 
         AutoSize        =   -1  'True
         Caption         =   "Prim. Amort. Capital "
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
         TabIndex        =   34
         Top             =   1620
         Width           =   1755
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
         TabIndex        =   33
         Top             =   1275
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
         TabIndex        =   32
         Top             =   1965
         Width           =   1230
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
      Height          =   1515
      Left            =   30
      TabIndex        =   15
      Top             =   510
      Width           =   5445
      Begin Threed.SSPanel etqNumOper 
         Height          =   375
         Left            =   240
         TabIndex        =   77
         Top             =   240
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   661
         _StockProps     =   15
         Caption         =   "SSPanel1"
         ForeColor       =   8421376
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.24
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin BACControles.TXTNumero txtCapital 
         Height          =   300
         Left            =   960
         TabIndex        =   66
         Top             =   1110
         Width           =   2535
         _ExtentX        =   4471
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
         Min             =   "-999999999999.9999"
         Max             =   "999999999999.9999"
      End
      Begin VB.Frame Frame2 
         Height          =   60
         Index           =   0
         Left            =   120
         TabIndex        =   41
         Top             =   600
         Width           =   5100
      End
      Begin VB.OptionButton optCompra 
         Caption         =   "&Recibimos"
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
         Height          =   390
         Left            =   465
         Style           =   1  'Graphical
         TabIndex        =   40
         ToolTipText     =   "Tipo de Operación ... Compra/Venta"
         Top             =   180
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
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   420
         Left            =   3105
         Style           =   1  'Graphical
         TabIndex        =   0
         ToolTipText     =   "Tipo de Operación ... Compra/Venta"
         Top             =   165
         Width           =   1575
      End
      Begin VB.ComboBox cmbMoneda 
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
         Left            =   960
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   1
         ToolTipText     =   "Moneda Capital"
         Top             =   765
         Width           =   2500
      End
      Begin VB.Label TxtValorMoneda 
         Caption         =   "TxtValorMoneda"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00008000&
         Height          =   240
         Left            =   3600
         TabIndex        =   47
         Top             =   765
         Width           =   1635
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   " Capital"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   1
         Left            =   150
         TabIndex        =   18
         Top             =   1140
         Width           =   795
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   " Moneda"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   0
         Left            =   150
         TabIndex        =   17
         Top             =   825
         Width           =   825
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
      Height          =   1455
      Left            =   75
      TabIndex        =   19
      Top             =   1980
      Width           =   5445
      Begin BACControles.TXTNumero txtTasaCompra 
         Height          =   300
         Left            =   1320
         TabIndex        =   67
         Top             =   705
         Width           =   975
         _ExtentX        =   1720
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
         Max             =   "999.999999"
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
         Left            =   2835
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   8
         ToolTipText     =   "Documento que Recibiremos"
         Top             =   1020
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
         Left            =   2835
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   7
         ToolTipText     =   "Moneda con equivalente del documento"
         Top             =   690
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
         Left            =   1320
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   6
         ToolTipText     =   "Base en que se encuentra expresada Tasa (para calculo de intereses)"
         Top             =   1020
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
         TabIndex        =   5
         ToolTipText     =   "Tasa de Negocio"
         Top             =   360
         Width           =   1785
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   " Base Tasa"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   8
         Left            =   120
         TabIndex        =   23
         Top             =   1065
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
         TabIndex        =   22
         Top             =   705
         Width           =   195
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   " Valor Tasa"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   6
         Left            =   120
         TabIndex        =   21
         Top             =   720
         Width           =   1035
      End
      Begin VB.Label lblSwapTasa 
         Caption         =   " Tasa"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   5
         Left            =   120
         TabIndex        =   20
         Top             =   405
         Width           =   555
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
         TabIndex        =   24
         Top             =   450
         Width           =   1275
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   2010
      Top             =   60
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
            Picture         =   "bacswapt.frx":16D2
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacswapt.frx":19EC
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacswapt.frx":1D06
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacswapt.frx":2020
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacOpeSwapTasa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim PasoTexto As String

'**Variables utilizadas en la funcion de Recalculo de Interes
Public RecFecha As Date
Public RecTasa As Double
Public RecMontoResto As Double
Public RecMontoAmort As Double
Public RecFecVencAnt As Date

Dim TipoAm As Integer
Dim OperSwap As String
Dim Operacion As String

Dim FechaCierre As Date   'Fecha de cierre operaciones
Dim ValorDolarObs As Double
Dim DatosPorMoneda()
Dim TotDatPorMon As Double
Dim CodAscii As Integer
Dim ValorTasasMon()

Dim objMoneda   As New clsMoneda
Dim objTasa     As New ClsTasas
Dim objCliente  As New clsCliente
Dim objFPago    As New clsForPago
Dim objCodigo   As New clsCodigo
Dim ValorAnt As String
Dim ValorUlt As String

Function Deshabilitar()

    Frame1.Enabled = False
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
    
    cmbAmortizaCapital.Enabled = False
    cmbAmortizaInteres.Enabled = False
    txtFecInicio.Enabled = False
    txtFecPrimerVcto.Enabled = False
    optCompensa.Enabled = False
    optEntFisica.Enabled = False
    cmbCarteraInversion.Enabled = False
    
End Function

Function BuscaCliente(RutCli&)
Dim Cliente As New clsCliente

    If Cliente.LeerxRut(RutCli, 0) Then
        txtRut.MaxLength = 13
        txtRut = Format(Cliente.clrut, "###,###,###") & "-" & Cliente.cldv
        txtCliente = Cliente.clnombre
        txtCliente.Tag = Cliente.clcodigo
    Else
        MsgBox "RUT No ha sido encontrado en datos de Cliente", vbInformation, Msj
        txtRut.SetFocus
    End If
    
    Set Cliente = Nothing

End Function

Function LimpiarDatos()
    
    'limpia textos
    txtCapital.Text = 0
    txtRut = ""
    txtCliente = ""
    txtCliente.Tag = 0
    txtFecInicio.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
    txtFecPrimerVcto.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
    txtFecTermino.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
    TxtValorMoneda.Caption = 0
    txtTasaCompra.Text = 0
    txtTasaVenta.Text = 0
    etqNumOper.Caption = 0
    txtTasa.Text = 0
    txtAmortiza.Text = 0
    EtqMensaje.Caption = ""
    lblFechaInicio = BacFechaStr(txtFecInicio.Text)
    lblFechaPrimerAmort = BacFechaStr(txtFecPrimerVcto.Text)
    lblFechaTermino = BacFechaStr(txtFecTermino.Text)
    
    'limpia combos
    cmbModalidad.ListIndex = -1
    cmbModalidadPag.ListIndex = -1
    cmbMoneda.ListIndex = -1
    cmbOperador.ListIndex = -1
    cmbTasaCompra.Clear '.ListIndex = -1
    cmbBaseCompra.ListIndex = -1
    cmbMonedaRecibimos.ListIndex = -1
    cmbDocumentoRecibimos.Clear '.ListIndex = -1
    cmbTasaVenta.Clear '.ListIndex = -1
    cmbBaseVenta.ListIndex = -1
    cmbMonedaPagamos.ListIndex = -1
    cmbDocumentoPagamos.Clear '.ListIndex = -1
    cmbAmortizaCapital.ListIndex = -1
    cmbAmortizaInteres.ListIndex = -1
    cmbCarteraInversion.ListIndex = -1
    
    optCompra.Value = True
    optCompensa.Value = True
    Operacion = "C"
    
    tabFlujos.Tab = 0
    tabFlujos.TabEnabled(1) = False
    tabFlujos.TabEnabled(2) = False
    
    lblSwapTasa(22).Visible = False
    Simbologia.Visible = False
    
    Call bacBuscarCombo(cmbTasaCompra, 1)
    
    Call BacLimpiaGrilla(grdPagamos)
    Call BacLimpiaGrilla(grdRecibimos)
    
    bacBuscarCombo cmbMoneda, 994
    
End Function

Function ValidaFechasIngreso(Cual, Evento) As Boolean

    ValidaFechasIngreso = False
    
    Select Case Cual
    Case 1
        If txtFecInicio.Text <> "" Then
            If IsDate(txtFecInicio.Text) Then
                'txtFecInicio.Text = Format(txtFecInicio.Text, gsc_FechaDMA)
                txtFecInicio.Text = Format(ValidaFecha(txtFecInicio.Text), gsc_FechaDMA)
                
                lblFechaInicio = BacFechaStr(txtFecInicio.Text)
                
                Call SugerirFechaPrimVecto
                If txtFecPrimerVcto.Text <> "" And txtFecTermino.Text = "" Then txtFecTermino.Text = txtFecPrimerVcto.Text
            Else
                MsgBox "Fecha de Inicio no es válida", vbInformation, Msj
                txtFecInicio.SetFocus
            End If
        End If

    Case 2
           If txtFecPrimerVcto.Text <> "" Then
                If IsDate(txtFecPrimerVcto.Text) Then
                    If CDate(txtFecPrimerVcto.Text) <= CDate(txtFecInicio.Text) Then
                        MsgBox "Fecha de Primer Vencimiento no puede ser menor o igual a Fecha de Inicio", vbInformation, Msj
                        Call SugerirFechaPrimVecto
                        txtFecPrimerVcto.SetFocus
                        Exit Function
                    ElseIf Format(txtFecPrimerVcto.Text, "yyyymmdd") <= Format(gsBAC_Fecp, "yyyymmdd") Then
                        MsgBox "Fecha Primer Vencimiento de Amortización de Capital no puede ser menor o igual a Fecha de Proceso", vbInformation, Msj
                        txtFecPrimerVcto.SetFocus
                        Exit Function
                        
                    ElseIf Not BacEsHabil(txtFecPrimerVcto.Text) Then
                        MsgBox "Fecha Primer Vencimiento de Amortización de Capital no es día hábil", vbInformation, Msj
                        txtFecPrimerVcto.SetFocus
                            Exit Function
                    End If
                    
                    txtFecPrimerVcto.Text = Format(txtFecPrimerVcto.Text, gsc_FechaDMA)
                    lblFechaPrimerAmort = BacFechaStr(txtFecPrimerVcto.Text)
                    If CodAscii = 13 Then
                    
                    
                    End If
                Else
                    MsgBox "Fecha de Primer Vencimiento no es válida", vbInformation, Msj
                    txtFecPrimerVcto.SetFocus
                End If
        End If
            
    Case 3
         If txtFecTermino.Text <> "" Then
            If IsDate(txtFecTermino.Text) Then
                lblFechaTermino = BacFechaStr(txtFecTermino.Text)
                If CDate(txtFecTermino.Text) < CDate(txtFecPrimerVcto.Text) Then
                    MsgBox "Fecha Termino de Operación no puede ser menor a Fecha de primer Vencimiento de Amortización de Capital", vbInformation, Msj
                    'txtFecTermino.SetFocus
                        Exit Function
                ElseIf Not BacEsHabil(txtFecTermino.Text) Then
                    MsgBox "Fecha de Término no es día hábil", vbInformation, Msj
                   ' txtFecTermino.SetFocus
                    Exit Function
                End If
                
                If Not FechaEnRango Then
                    MsgBox "Fechas Definidas No concuerdan con períodos de Amortización seleccionados ", vbInformation, Msj
                   ' txtFecTermino.SetFocus
                    Exit Function
                End If
            Else
                MsgBox "Fecha Termino de Vencimientos no es válida", vbInformation, Msj
                txtFecTermino.SetFocus
            End If
        End If
    End Select

    ValidaFechasIngreso = True

End Function

Private Sub btnCalcular_Click()

Dim i As Integer

If ValidaDatos Then
    'Inicializacion de Barra
    Me.MousePointer = 11
    Barra.Value = Barra.Min
    
    '****
     Call CalculoInteres
    '****
    'Despues del los procesos habilita paneles del tab
    Barra.Value = Barra.Max
    tabFlujos.TabEnabled(1) = True
    tabFlujos.TabEnabled(2) = True
    'Invisibilizar barra
    framBarra.Visible = False
    Barra.Value = Barra.Min
    btnGrabar.Enabled = True
    Me.MousePointer = 0
Else
    btnGrabar.Enabled = False
End If

End Sub

Private Sub btnGrabar_Click()
    Dim m
    
    'Validacion de datos faltantes para grabar datos
    Me.MousePointer = 11
    
    If Not ValidaDatosIngreso Then
        Me.MousePointer = 0
        Exit Sub
    End If
    '*** Proceso de Almacenamiento de datos
    If GrabarDatos Then
        '*** Envío de Papeleta a impresora
        If ImprimePapeleta(etqNumOper.Caption, _
                                    IIf(OperSwap = "Modificacion" Or OperSwap = "Ingreso", 1, 3), _
                                    IIf(OperSwap = "Ingreso", gsBAC_Fecp, FechaCierre), _
                                    1) Then
        
            EtqMensaje.Caption = "Informe enviado a Impresora!"
            For m = 1 To 100000
                DoEvents
            Next
            EtqMensaje.Caption = ""
        End If
        '***
        Call LimpiarDatos
        btnGrabar.Enabled = False
        If OperSwap = "Modificacion" Then btnCalcular.Enabled = False
        
    End If
    
    Me.MousePointer = 0
    
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
    
   ' If cmbTasaCompra.ItemData(cmbTasaCompra.ListIndex) = 1 And cmbTasaVenta.ItemData(cmbTasaVenta.ListIndex) = 1 Then
   '     MsgBox "Elección de tipo de Tasas debe ser distinto a Fija - Fija", vbInformation, Msj
   '     cmbTasaCompra.SetFocus
   '     Exit Function
   ' End If

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
    
    If Not FechaEnRango Then
        MsgBox "Fechas definidas NO Concuerdan con períodos de Amortización Seleccionado", vbInformation, Msj
        txtFecTermino.SetFocus
        Exit Function
    End If
    
    ValidaDatos = True
    
End Function
Function ValidaDatosIngreso() As Boolean

    ValidaDatosIngreso = False
    
    If cmbMoneda.ListIndex = -1 Then
        MsgBox "Debe Seleccionar Moneda de la Operacion", vbInformation, Msj
        cmbMoneda.SetFocus
        Exit Function
    End If
    If txtCliente = "" Then
        MsgBox "Debe Ingresar Cliente", vbInformation, Msj
        txtCliente.SetFocus
        Exit Function
    End If
    If txtCliente.Tag = "" Then
        MsgBox "Debe Ingresar Cliente", vbInformation, Msj
        txtCliente.SetFocus
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
    
    If cmbCarteraInversion.ListIndex = -1 Then
        MsgBox "Debe seleccionar Cartera de Inversión ", vbInformation, Msj
        tabFlujos.Tab = 0
        cmbCarteraInversion.SetFocus
        Exit Function
    End If
  
    If (grdPagamos.TextMatrix(1, 1) = "" Or grdRecibimos.TextMatrix(1, 1) = "") Or tabFlujos.TabEnabled(1) = False Then
    

        MsgBox "Debe realizar Calculo de flujos!", vbCritical, Msj
        Exit Function
    End If
    ValidaDatosIngreso = True

End Function


Function Destaca(ByRef Texto As TextBox)

    Texto.SelStart = 0
    Texto.SelLength = Len(Texto)   ' se establece la longitud para seleccionar.

End Function

Function grabardatosANT() As Boolean

Dim objGrabaSwap As New ClsMovimSwaps
Dim Sql As String
Dim i, Actualiza As Integer
Dim Datos()
Dim fecInteres As String
Dim Hasta As Long
Dim GrillaCompra As Object
Dim GrillaVenta As Object
'********************************************************************
'* Rutina que graba los datos de operaciones nuevas y Operaciones Modificadas *
'********************************************************************
grabardatosANT = False

With objGrabaSwap
'hacer begin transaction

    Sql = "BEGIN TRANSACTION"
    
    If MISQL.SQL_Execute(Sql) Then
        Exit Function
    End If
    
    If OperSwap = "Ingreso" Then
    
        'Saca numero de ultima operacion
        Sql = " Exec sp_UltimaOperacion " _
              & "'" & Sistema & "', '" & Entidad & "' "
        
        Envia = Array()
        AddParam Envia, Sistema
        AddParam Envia, Entidad
        
'        If MISQL.SQL_Execute(Sql) <> 0 Then
        If Not Bac_Sql_Execute("Sp_UltimaOperacion", Envia) Then
            MsgBox "Problemas para crear número de Operación!", vbCritical, Msj
            Exit Function
        Else
'            If MISQL.SQL_Fetch(DATOS()) = 0 Then
            If Bac_SQL_Fetch(Datos()) Then
                .swNumOperacion = Val(Datos(1))            'Numero de la Operacion
            Else
                .swNumOperacion = 1                              'Primera Operacion creada
            End If
        End If
        etqNumOper.Caption = .swNumOperacion
        FechaCierre = gsBAC_Fecp
        Actualiza = 1
        
    ElseIf OperSwap = "Modificacion" Or OperSwap = "ModificacionCartera" Then
        'modificaciones del diario o de vigentes
        Sql = " Exec sp_modificaswaps " _
              & etqNumOper.Caption & ", '" & Format(gsBAC_Fecp, "yyyymmdd") & "' "
        
        Envia = Array()
        AddParam Envia, CDbl(etqNumOper.Caption)
        AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
        
'        If MISQL.SQL_Execute(Sql) <> 0 Then
        If Not Bac_Sql_Execute("Sp_ModificaSwaps", Envia) Then
            MsgBox "Problemas al verificar Operación a modificar!", vbCritical, Msj
            Exit Function
        End If
        .swNumOperacion = etqNumOper.Caption
        Actualiza = IIf(OperSwap = "Modificacion", 1, 2)   'Si actualizara la tabla de MovDiario
        ' La fecha de cierre se recupero en funcion BuscarDatos, variable FechaCierre
    End If
    
    .swActualizar = Actualiza
    .swTipoSwap = 1                                                                                     'Tipo de Swap (Tasa - Monedas)
    .swCarteraInversion = SacaCodigo(cmbCarteraInversion)                         'Codigo de Cartera de Inversion
    .swTipoOperacion = IIf(optCompra.Value = True, "C", "V")                       'Tipo de Operacion (Compra-Venta)
    .swCodCliente = IIf(txtCliente.Tag = "", 0, txtCliente.Tag)                           'Codigo cliente
    .swCMoneda = SacaCodigo(cmbMonedaRecibimos)                                 'Moneda de Compra
    .swCCapital = .FormatNum(txtCapital.Text)                                               'Monto Capital
    .swFechaCierre = FechaCierre                                                                 'Fecha del dia en que se realiza operacion
    .swFechaInicio = txtFecInicio.Text                                                           'Fecha Primer Vencimiento
    .swFechaTermino = txtFecTermino.Text                                                    'Fecha Termino amortizacion
    .swCCodAmoCapital = Val(Trim(Right(cmbAmortizaCapital, 10)))              'Codigo tipo amortizacion de capital
    .swCMesAmoCapital = Int(SacaCodigo(cmbAmortizaCapital) / 30)            'Valor de meses
    .swCCodAmoInteres = Val(Trim(Right(cmbAmortizaInteres, 10)))              'Codigo tipo amortizacion de interes
    .swCMesAmoInteres = Int(SacaCodigo(cmbAmortizaInteres) / 30)            'Valor de meses
    .swVMoneda = SacaCodigo(cmbMonedaPagamos)                                   'Codigo Moneda de Venta
    .swVCapital = .FormatNum(txtCapital.Text)                                              'Monto capital Venta
    .swVCodAmoCapital = Val(Trim(Right(cmbAmortizaCapital, 10)))             'Codigo tipo de amortizacion Tasa
    .swVMesAmoCapital = Int(SacaCodigo(cmbAmortizaCapital) / 30)           'Valor de meses
    .swVCodAmoInteres = Val(Trim(Right(cmbAmortizaInteres, 10)))             'Codigo tipo amortizacion de interes
    .swVMesAmoInteres = Int(SacaCodigo(cmbAmortizaInteres) / 30)           'Valor de meses
    .swOperador = Left(gsBAC_User$, 10)                                                    'ingresa nombre usuario con max. de 10 caract.
    .swOperadorCliente = SacaCodigo(cmbOperador)                                   'Codigo del Operador
    .swCMontoCLP = 0                                                                                'Monto compra en Pesos
    .swCMontoUSD = 0                                                                                'Monto Compra en moneda pactada
    .swVMontoCLP = 0                                                                                'Monto Venta en Pesos
    .swVMontoUSD = 0                                                                                'Monto Venta en moneda pactada
    .swObservaciones = "obs"
    .swFechaModifica = gsBAC_Fecp
    
    
    'If swTipoOperacion = "C" Then
        Set GrillaCompra = grdRecibimos
        Set GrillaVenta = grdPagamos
    
        .swCBase = cmbBaseCompra                                                                   'Monto base Compra
        .swVBase = cmbBaseVenta                                                                     'Monto Base Venta
        
        .swCValorTasaHoy = txtTasaCompra.Tag                                             'Valor Tasa del dia
        .swCCodigoTasa = SacaCodigo(cmbTasaCompra)                                 'Codigo de tasa compra
        .swVCodigoTasa = SacaCodigo(cmbTasaVenta)                                     'Codigo de tasa Venta
        .swVValorTasaHoy = txtTasaVenta.Tag                                                 'Valor Tasa del dia
        .swPagMoneda = SacaCodigo(cmbMonedaPagamos)                               'Codigo Moneda Pagamos
        .swPagDocumento = SacaCodigo(cmbDocumentoPagamos)                     'Codigo documento Pagamos
        .swRecMoneda = SacaCodigo(cmbMonedaRecibimos)                             'Codigo Moneda Recibimos
        .swRecDocumento = SacaCodigo(cmbDocumentoRecibimos)                   'Codigo Documento Recibimos
    '
    fecInteres = grdRecibimos.TextMatrix(1, 1)
    
    '***   CH = Cartera Historica
    
For i = 1 To grdRecibimos.Rows - 1
    If grdRecibimos.TextMatrix(i, 13) <> "CH" Then
    
        .swNumFlujo = grdRecibimos.TextMatrix(i, 0)                                               'Correlativo de la Operacion
        .swFechaInicioFlujo = grdRecibimos.TextMatrix(i, 9) 'fecInteres
        .swFechaVenceFlujo = grdRecibimos.TextMatrix(i, 1)
        .swCAmortiza = .FormatNum(grdRecibimos.TextMatrix(i, 2))                    'Monto amortizado en Compra
        .swCSaldo = .FormatNum(grdRecibimos.TextMatrix(i, 8))                         'Monto no amortizado (Saldo) en compra
        .swCInteres = .FormatNum(grdRecibimos.TextMatrix(i, 4))                       'Monto Interes de Compra
        .swCSpread = 0
        .swCValorTasa = .FormatNum(grdRecibimos.TextMatrix(i, 3))                'Valor Tasa
        .swPagMonto = (grdRecibimos.TextMatrix(i, 10))
        .swPagMontoUSD = (grdRecibimos.TextMatrix(i, 11))
        .swPagMontoCLP = (grdRecibimos.TextMatrix(i, 12))
    
    
        .swVAmortiza = .FormatNum(grdPagamos.TextMatrix(i, 2))                     'Monto Amortizado en Venta
        .swVSaldo = .FormatNum(grdPagamos.TextMatrix(i, 8))                           'Monto no amortizado (Saldo) en Venta
        .swVInteres = .FormatNum(grdPagamos.TextMatrix(i, 4))                          'Monto Interes de Compra
        .swVSpread = 0
        .swVValorTasa = .FormatNum(grdPagamos.TextMatrix(i, 3))                    'Valor Tasa Venta
        .swRecMonto = .FormatNum(grdPagamos.TextMatrix(i, 10))
        .swRecMontoUSD = .FormatNum(grdPagamos.TextMatrix(i, 11))
        .swRecMontoCLP = .FormatNum(grdPagamos.TextMatrix(i, 12))
        
        .swEstadoFlujo = 1
        .swModalidadPago = Right(grdPagamos.TextMatrix(i, 6), 1)
        fecInteres = grdPagamos.TextMatrix(i, 1)
    
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

End With
            
Sql = "COMMIT TRANSACTION"
If MISQL.SQL_Execute(Sql) <> 0 Then
    MsgBox "Problemas al grabar datos", vbCritical, Msj
    Exit Function
End If

Set objGrabaSwap = Nothing

grabardatosANT = True

End Function
Function GrabarDatos() As Boolean

Dim objGrabaSwap As New ClsMovimSwaps
Dim Sql As String
Dim i, Actualiza As Integer
Dim Datos()
Dim fecInteres As String
Dim Hasta As Long
'********************************************************************
'* Rutina que graba los datos de operaciones nuevas y Operaciones Modificadas *
'********************************************************************
GrabarDatos = False

Call SacarValoresSWTasa(ValorUlt)

With objGrabaSwap
'hacer begin transaction

    Sql = "BEGIN TRANSACTION"
    
    If MISQL.SQL_Execute(Sql) Then
        Exit Function
    End If
    
    If OperSwap = "Ingreso" Then
        
        'Saca numero de ultima operacion
        Envia = Array()
        AddParam Envia, Sistema
        AddParam Envia, Entidad
        
        If Not Bac_Sql_Execute("Sp_UltimaOperacion", Envia) Then
            MsgBox "Problemas para crear número de Operación!", vbCritical, Msj
            Exit Function
        Else
            If Bac_SQL_Fetch(Datos()) Then
                .swNumOperacion = Val(Datos(1))            'Numero de la Operacion
            Else
                .swNumOperacion = 1                              'Primera Operacion creada
            End If
        End If
        etqNumOper.Caption = .swNumOperacion
        FechaCierre = gsBAC_Fecp
        Actualiza = 1
        
    ElseIf OperSwap = "Modificacion" Or OperSwap = "ModificacionCartera" Then
        'modificaciones del diario o de vigentes
        Sql = " Exec sp_modificaswaps " _
              & etqNumOper.Caption & ", '" & Format(gsBAC_Fecp, "yyyymmdd") & "' "
        
        Envia = Array()
        AddParam Envia, CDbl(etqNumOper.Caption)
        AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
        
'        If MISQL.SQL_Execute(Sql) <> 0 Then
        If Not Bac_Sql_Execute("Sp_ModificaSwaps", Envia) Then
            MsgBox "Problemas al verificar Operación a modificar!", vbCritical, Msj
            Exit Function
        End If
        .swNumOperacion = etqNumOper.Caption
        Actualiza = IIf(OperSwap = "Modificacion", 1, 2)   'Si actualizara la tabla de MovDiario
        ' La fecha de cierre se recupero en funcion BuscarDatos, variable FechaCierre
    End If
   Dim Largo As Integer
     
    .swActualizar = Actualiza
    .swTipoSwap = 1                                               'Tipo de Swap (Tasa - Monedas)
    .swCarteraInversion = SacaCodigo(cmbCarteraInversion)         'Codigo de Cartera de Inversion
    .swTipoOperacion = IIf(optCompra.Value = True, "C", "V")      'Tipo de Operacion (Compra-Venta)
    .swCodCliente = IIf(txtCliente.Tag = "", 0, txtCliente.Tag)   'Codigo cliente
    txtRut.Tag = BacStrTran(txtRut.Text, ".", "")
    .swRutCliente = IIf(txtRut.Tag = "", 0, CDbl(Mid(txtRut.Tag, 1, Len(txtRut.Tag) - 2))) 'Rut sin Dv de cliente
    
    .swCMoneda = SacaCodigo(cmbMoneda)                            'Moneda de Compra
    .swCCapital = .FormatNum(txtCapital.Text)                     'Monto Capital
    .swFechaCierre = FechaCierre                                  'Fecha del dia en que se realiza operacion
    .swFechaInicio = txtFecInicio.Text                            'Fecha Primer Vencimiento
    .swFechaTermino = txtFecTermino.Text                          'Fecha Termino amortizacion
    .swCCodAmoCapital = Val(Trim(Right(cmbAmortizaCapital, 10)))  'Codigo tipo amortizacion de capital
    .swCMesAmoCapital = (SacaCodigo(cmbAmortizaCapital))          'Valor de meses
    .swCCodAmoInteres = Val(Trim(Right(cmbAmortizaInteres, 10)))  'Codigo tipo amortizacion de interes
    .swCMesAmoInteres = (SacaCodigo(cmbAmortizaInteres))          'Valor de meses
    .swCBase = cmbBaseCompra                                      'Monto base Compra
    .swVMoneda = SacaCodigo(cmbMoneda)                            'Codigo Moneda de Venta
    .swVCapital = .FormatNum(txtCapital.Text)                     'Monto capital Venta
    .swVCodAmoCapital = Val(Trim(Right(cmbAmortizaCapital, 10)))  'Codigo tipo de amortizacion Tasa
    .swVMesAmoCapital = (SacaCodigo(cmbAmortizaCapital))          'Valor de meses
    .swVCodAmoInteres = Val(Trim(Right(cmbAmortizaInteres, 10)))  'Codigo tipo amortizacion de interes
    .swVMesAmoInteres = (SacaCodigo(cmbAmortizaInteres))          'Valor de meses
    .swVBase = cmbBaseVenta                                       'Monto Base Venta
    .swOperador = Left(gsBAC_User$, 10)                           'Ingresa nombre usuario con max. de 10 caract.
    .swOperadorCliente = SacaCodigo(cmbOperador)                  'Codigo del Operador
    .swCMontoCLP = 0                                              'Monto compra en Pesos
    .swCMontoUSD = 0                                              'Monto Compra en moneda pactada
    .swVMontoCLP = 0                                              'Monto Venta en Pesos
    .swVMontoUSD = 0                                              'Monto Venta en moneda pactada
    
    .swCValorTasaHoy = txtTasaCompra.Tag                          'Valor Tasa del dia
    .swCCodigoTasa = SacaCodigo(cmbTasaCompra)                    'Codigo de tasa compra
    .swVCodigoTasa = SacaCodigo(cmbTasaVenta)                     'Codigo de tasa Venta
    .swVValorTasaHoy = txtTasaVenta.Tag                           'Valor Tasa del dia
    .swPagMoneda = SacaCodigo(cmbMonedaPagamos)                   'Codigo Moneda Pagamos
    .swPagDocumento = SacaCodigo(cmbDocumentoPagamos)             'Codigo documento Pagamos
    .swRecMoneda = SacaCodigo(cmbMonedaRecibimos)                 'Codigo Moneda Recibimos
    .swRecDocumento = SacaCodigo(cmbDocumentoRecibimos)           'Codigo Documento Recibimos
    .swObservaciones = "obs"
    .swFechaModifica = gsBAC_Fecp
    
    fecInteres = grdRecibimos.TextMatrix(1, 1)
    
    '***   CH = Cartera Historica
    
For i = 1 To grdRecibimos.Rows - 1
    If grdRecibimos.TextMatrix(i, 13) <> "CH" Then
    
        .swNumFlujo = grdRecibimos.TextMatrix(i, 0)                'Correlativo de la Operacion
        .swFechaInicioFlujo = grdRecibimos.TextMatrix(i, 9)        'fecInteres
        .swFechaVenceFlujo = grdRecibimos.TextMatrix(i, 1)
        .swCAmortiza = .FormatNum(grdRecibimos.TextMatrix(i, 2))   'Monto amortizado en Compra
        .swCSaldo = .FormatNum(grdRecibimos.TextMatrix(i, 8))      'Monto no amortizado (Saldo) en compra
        .swCInteres = .FormatNum(grdRecibimos.TextMatrix(i, 4))    'Monto Interes de Compra
        .swCSpread = 0
        .swCValorTasa = .FormatNum(grdRecibimos.TextMatrix(i, 3))  'Valor Tasa
        .swPagMonto = .FormatNum(grdRecibimos.TextMatrix(i, 10))
        .swPagMontoUSD = .FormatNum(grdRecibimos.TextMatrix(i, 11))
        .swPagMontoCLP = .FormatNum(grdRecibimos.TextMatrix(i, 12))
    
    
        .swVAmortiza = .FormatNum(grdPagamos.TextMatrix(i, 2))     'Monto Amortizado en Venta
        .swVSaldo = .FormatNum(grdPagamos.TextMatrix(i, 8))        'Monto no amortizado (Saldo) en Venta
        .swVInteres = .FormatNum(grdPagamos.TextMatrix(i, 4))      'Monto Interes de Compra
        .swVSpread = 0
        .swVValorTasa = .FormatNum(grdPagamos.TextMatrix(i, 3))    'Valor Tasa Venta
        .swRecMonto = .FormatNum(grdPagamos.TextMatrix(i, 10))
        .swRecMontoUSD = .FormatNum(grdPagamos.TextMatrix(i, 11))
        .swRecMontoCLP = .FormatNum(grdPagamos.TextMatrix(i, 12))
        
        .swEstadoFlujo = 1
        .swModalidadPago = Right(grdPagamos.TextMatrix(i, 6), 1)
        fecInteres = grdPagamos.TextMatrix(i, 1)
    
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

Call GRABALOG(OperSwap, "Opc_20100", .swNumOperacion, .swTipoSwap, ValorAnt, ValorUlt)
            
Sql = "COMMIT TRANSACTION"
If MISQL.SQL_Execute(Sql) <> 0 Then
    MsgBox "Problemas al grabar datos", vbCritical, Msj
    Exit Function
End If

  End With

Set objGrabaSwap = Nothing

GrabarDatos = True

End Function

Function LLenafgrdFlujos()

Dim i As Integer
Dim Grilla As Object

    
    If tabFlujos.Tag = "Pagamos" Then
        Set Grilla = grdPagamos
    ElseIf tabFlujos.Tag = "Recibimos" Then
        Set Grilla = grdRecibimos
    End If
    
    With Grilla
    .Cols = 14

    'columnas visibles
    .TextMatrix(0, 0) = "Nro."
    .TextMatrix(0, 1) = "Vencimiento"
    .TextMatrix(0, 2) = "Amortización " & Trim(cmbAmortizaCapital)
    .TextMatrix(0, 3) = "Tasa"
    .TextMatrix(0, 4) = "Interés " & Trim(cmbAmortizaInteres)
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
    
    .ColWidth(0) = TextWidth(" 99 ")
    .ColWidth(1) = 1080
    .ColWidth(2) = TextWidth(" 999,999,999,999.9999 ")
    .ColWidth(3) = TextWidth(" 999.999999 ")
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
    For i = 0 To .Cols - 1
        .Col = i
        .CellAlignment = flexAlignCenterCenter
    Next
    .RowHeightMin = 300
    
    Set Grilla = Nothing
    
    End With

    tabFlujos.TabIndex = 2

End Function

Private Sub btnSalir_Click()

    Unload Me

End Sub

Private Sub btnSalir_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)

    Unload Me

End Sub

Private Sub cmbAmortizaCapital_Click()

     '***Para cancelar que modifiquen columna
    If cmbAmortizaCapital.ListIndex <> -1 Then
        TipoAm = cmbAmortizaCapital.ItemData(cmbAmortizaCapital.ListIndex)
    End If

End Sub

Private Sub cmbAmortizaCapital_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbAmortizaInteres.SetFocus

End Sub

Private Sub cmbAmortizaCapital_LostFocus()

    'If btnGrabar.Enabled = True Then
    '    btnCalcular_Click
    'End If

End Sub

Private Sub cmbAmortizaInteres_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then txtFecInicio.SetFocus

End Sub

Private Sub cmbAmortizaInteres_LostFocus()

   ' If btnGrabar.Enabled = True Then btnCalcular_Click
    
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

Private Sub cmbCarteraInversion_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
      ' If btnCalcular.Enabled = True Then
'           btnCalcular.SetFocus
       'End If
    End If
    
   
End Sub

Private Sub cmbDocumentoPagamos_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
          If cmbAmortizaCapital.Enabled = True Then
             cmbAmortizaCapital.SetFocus
          End If
    End If

End Sub

Private Sub cmbDocumentoRecibimos_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbTasaVenta.SetFocus

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
Dim CodMon As Integer
    
    If cmbMoneda.ListIndex = -1 Then Exit Sub
    
    cmbMoneda.Tag = cmbMoneda.ItemData(cmbMoneda.ListIndex)
    
    objMoneda.LeerxCodigo Val(cmbMoneda.Tag)
    
    TxtValorMoneda = Format(objMoneda.vmValor, "#,##0.00")
    
    If Not optCompra.Value Then
        If objMoneda.CargaTasas(objMoneda.mncodigo, cmbTasaCompra) Then
           If cmbTasaCompra.ListCount > 0 Then
            cmbTasaCompra.ListIndex = 0
            End If
        End If
        cmbTasaVenta.Clear
        cmbTasaVenta.AddItem "FIJA": cmbTasaVenta.ItemData(cmbTasaVenta.NewIndex) = 0
        cmbTasaVenta.ListIndex = 0
    Else
        If objMoneda.CargaTasas(objMoneda.mncodigo, cmbTasaVenta) Then
           If cmbTasaVenta.ListCount > 0 Then
            cmbTasaVenta.ListIndex = 0
           End If
        End If
        
        cmbTasaCompra.Clear
        cmbTasaCompra.AddItem "FIJA": cmbTasaCompra.ItemData(cmbTasaCompra.NewIndex) = 0
        cmbTasaCompra.ListIndex = 0
    End If
    
    objMoneda.CargaBases cmbBaseCompra
    objMoneda.CargaBases cmbBaseVenta
    
    
    objFPago.CargaxMoneda Val(cmbMoneda.Tag), 0, cmbMonedaRecibimos
    objFPago.CargaxMoneda Val(cmbMoneda.Tag), 0, cmbMonedaPagamos
    cmbDocumentoRecibimos.Clear
    cmbDocumentoPagamos.Clear
    'objMoneda.CargaObjectos cmbMonedaRecibimos, "PAGADORA"
    'objMoneda.CargaObjectos cmbMonedaPagamos, "PAGADORA"
    
End Sub


Private Sub cmbMoneda_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then txtCapital.SetFocus

End Sub

Private Sub cmbMonedaPagamos_Click()

    If optEntFisica.Value = True Then
        'SI ES ENTREGA FISICA SE RECIBE Y SE PAGA EN LA MISMA MONEDA
        cmbMonedaRecibimos.ListIndex = cmbMonedaPagamos.ListIndex
    End If
    
    If cmbMonedaPagamos.ListIndex >= 0 Then
        objFPago.CargaxMoneda Val(cmbMoneda.Tag), cmbMonedaPagamos.ItemData(cmbMonedaPagamos.ListIndex), cmbDocumentoPagamos
    Else
        cmbMonedaPagamos.Clear
    End If
            
    If False Then
    Call LlenaMonDocPago(cmbDocumentoPagamos, DatosPorMoneda(), _
                                           cmbMonedaPagamos.Tag, _
                                           SacaCodigo(cmbMonedaPagamos), TotDatPorMon, 2)
    End If
End Sub

Private Sub cmbMonedaPagamos_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbDocumentoPagamos.SetFocus

End Sub

Private Sub cmbMonedaRecibimos_Click()

    If optEntFisica.Value = True Then
        'SI ES ENTREGA FISICA SE RECIBE Y SE PAGA EN LA MISMA MONEDA
        cmbMonedaPagamos.ListIndex = cmbMonedaRecibimos.ListIndex
    End If
    
    If cmbMonedaRecibimos.ListIndex >= 0 Then
        objFPago.CargaxMoneda Val(cmbMoneda.Tag), cmbMonedaRecibimos.ItemData(cmbMonedaRecibimos.ListIndex), cmbDocumentoRecibimos
    Else
        cmbDocumentoRecibimos.Clear
    End If

    If False Then
     Call LlenaMonDocPago(cmbDocumentoRecibimos, DatosPorMoneda(), _
                                           cmbMonedaRecibimos.Tag, _
                                           SacaCodigo(cmbMonedaRecibimos), TotDatPorMon, 2)
    End If
End Sub

Private Sub cmbMonedaRecibimos_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbDocumentoRecibimos.SetFocus
    
End Sub

Private Sub cmbOperador_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then txtTasaCompra.SetFocus

End Sub

Private Sub cmbTasaCompra_Click()

    If cmbTasaCompra = "" Then Exit Sub
    
    If objTasa.CodTasa <> 0 Then
        txtTasaCompra.Tag = objTasa.ValorTasa(objMoneda.mncodigo, objTasa.CodTasa, Val(cmbAmortizaInteres.Tag), gsBAC_Fecp)
    End If
    If Format(txtTasaCompra.Text, "#0.0000") = Format(0, "#0.0000") And OperSwap = "Ingreso" Then
        txtTasaCompra.Text = txtTasaCompra.Tag
    End If

End Sub

Private Sub cmbTasaCompra_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then txtTasaCompra.SetFocus

End Sub

Private Sub cmbTasaVenta_Click()

    If cmbTasaVenta = "" Then Exit Sub
    If IsNumeric(Trim(Right(cmbTasaVenta, 15))) Then
        txtTasaVenta.Tag = CDbl(Trim(Right(cmbTasaVenta, 15)))
        If txtTasaVenta.Text = "0.0000" And OperSwap = "Ingreso" Then
            txtTasaVenta.Text = CDbl(Trim(Right(cmbTasaVenta, 15)))
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

Private Sub cmbTasaVenta_LostFocus()
        
  '  If cmbTasaCompra.ListIndex > -1 And cmbTasaVenta.ListIndex > -1 Then
  '      If cmbTasaCompra.ItemData(cmbTasaCompra.ListIndex) = 1 And cmbTasaVenta.ItemData(cmbTasaVenta.ListIndex) = 1 Then
  '          MsgBox "Elección de tipo de Tasas debe ser distinto a Fija - Fija", vbInformation, Msj
  '          cmbTasaVenta.SetFocus
  '      End If
  '  End If
           
End Sub

Private Sub Form_Load()
On Error GoTo Control:
Me.Icon = BACSwap.Icon
Dim Frase As String
Dim Cont As Integer

    Cont = 0
    
    OperSwap = swOperSwap
    swOperSwap = ""
    
    '------------- Monedas
    objMoneda.CargaxProducto OP_SWAP_TASAS, cmbMoneda
    
    '---- Aqui se llena Tasas y Formas de Pago
    bacBuscarCombo cmbMoneda, 994
    
    '------------ Tipos de Amortizacion
    'objTasa.CargaPeriodos objMoneda.mncodigo, objTasa.CodTasa, cmbAmortizaInteres
    Call LlenaComboAmortiza(cmbAmortizaCapital, 1043, Sistema)
    Call LlenaComboAmortiza(cmbAmortizaInteres, 1044, Sistema)
    
    '------------ Tipos de Amortizacion
    Call LlenaComboCodGeneral(cmbCarteraInversion, 1004, Sistema, 1)
        
    cmbModalidad.AddItem "Compensación" & Space(50) & "C"
    cmbModalidad.AddItem "Ent. Física " & Space(50) & "E"
    cmbModalidadPag.AddItem "Compensación" & Space(50) & "C"
    cmbModalidadPag.AddItem "Ent. Física " & Space(50) & "E"
    
    Call LimpiarDatos
    
    lblSwapTasa(22).Visible = False
    Simbologia.Visible = False
    
    Me.Top = 60
    Me.Left = 100
    
    optCompra.Top = 200
    optVenta.Top = 200
    etqNumOper.Top = 200
    
    txtTasa.Width = TextWidth(" 999.999999 ")
    txtTasaPag.Width = TextWidth(" 999.999999 ")
    
    If OperSwap = "Ingreso" Then
        
        tabFlujos.Tag = "Recibimos"
        Call LLenafgrdFlujos
        tabFlujos.Tag = "Pagamos"
        Call LLenafgrdFlujos
        optCompra.Left = 525
        optVenta.Left = 2850
        etqNumOper.Visible = False
        btnGrabar.Enabled = False
        
        ValorDolarObs = gsBAC_DolarObs
    Else
        'Modificaciones
        optCompra.Left = 1740
        optVenta.Left = 3345
        etqNumOper.Left = 180
        etqNumOper.Visible = True
        
        Call BuscarDatos
        Call SacarValoresSWTasa(ValorAnt)
    
        tabFlujos.TabEnabled(1) = True
        tabFlujos.TabEnabled(2) = True
    
        Dim ValMonedas As New clsMoneda
        ValorDolarObs = ValMonedas.ValorMoneda(994, CStr(FechaCierre))    'valor dolar obs. para convertir monto
            
        If OperSwap = "ModificacionCartera" Then
            Call Deshabilitar
        End If
    
    End If
     
Exit Sub

Control:

    If Err = 380 Then
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

Sub SacarValoresSWTasa(cadena As String)
   
    cadena = 1 & "; " & "Cartera: " & (SacaCodigo(cmbCarteraInversion)) & ";" _
    & "Tipo Op: " & IIf(optCompra.Value = True, "C", "V") & ";" _
    & "Cod Cliente: " & IIf(txtCliente.Tag = "", 0, txtCliente.Tag) & ";" & "Rut Cli: " & txtRut.Text & ";" _
    & "CMoneda: " & Trim(cmbMoneda) & ";" _
    & "CCapital: " & txtCapital.Text & ";" _
    & "Fecha Cierre: " & FechaCierre & ";" & "Fecha Inicio: " & txtFecInicio.Text & ";" & "FechaTermino: " & txtFecTermino.Text & ";" _
    & "CAmoCapital:" & Trim(Left(cmbAmortizaCapital, 30)) & ";" _
    & "CAmoInteres:" & Trim(Left(cmbAmortizaInteres, 30)) & ";" _
    & "CBase:" & cmbBaseCompra & ";" _
    & "VMoneda:" & Trim(cmbMoneda) & ";" _
    & "VCapital:" & txtCapital.Text & ";" _
    & "VAmoCapital:" & Trim(Left(cmbAmortizaCapital, 30)) & ";" _
    & "VAmoInteres:" & Trim(Left(cmbAmortizaInteres, 30)) & ";" _
    & "VBase :" & cmbBaseVenta & ";" _
    & "Operador :" & Left(gsBAC_User$, 10) & ";" & "Cod Oper :" & SacaCodigo(cmbOperador) & ";" _
     & "CValorTasa :" & txtTasaCompra.Text & ";" _
    & "VValorTasa :" & txtTasaVenta.Text & ";" _
    & "PagMoneda :" & Trim(cmbMonedaPagamos) & ";" & "PagDocumento :" & Trim(cmbDocumentoPagamos) & ";" _
    & "RecMoneda :" & Trim(cmbMonedaRecibimos) & ";" & "RecDocumento :" & Trim(cmbDocumentoRecibimos) & ";" _
    & "FechaModifica :" & gsBAC_Fecp
   
    
End Sub

Function LlenaComboTasas(Cual As Integer, CodMon As Integer, CodSist As Integer, sFecha As String)

'Saca datos tabla mdtc y llena combo
Dim Sql   As String
Dim Datos()
Dim i As Integer
Dim combo As Object
Dim combo1 As Object

    If Cual = 1 Then
        'compra
        Set combo = cmbTasaCompra
        Set combo1 = cmbTasaVenta
    Else
        'venta
        Set combo1 = cmbTasaCompra
        Set combo = cmbTasaVenta
    End If

    combo.Clear
    combo1.Clear

    Sql = "EXEC " & giSQL_DatabaseCommon & "..sp_leerTasasMoneda "
    Sql = Sql & "'" & Sistema & "', "
    Sql = Sql & CodMon & ", "
    Sql = Sql & CodSist & ", "
    Sql = Sql & "'" & sFecha & "' "
    
    Envia = Array()
    AddParam Envia, Sistema
    AddParam Envia, CDbl(CodMon)
    AddParam Envia, CodSist
    AddParam Envia, sFecha
    
'    If MISQL.SQL_Execute(Sql) <> 0 Then
    If Not Bac_Sql_Execute("Sp_LeerTasasMoneda", Envia) Then
        MsgBox "No se encontraron Tasas asociadas a ésta Moneda!", vbInformation, Msj
        Exit Function
    End If
     
    Do While Bac_SQL_Fetch(Datos())
'    Do While MISQL.SQL_Fetch(DATOS()) = 0
        If Val(Datos(2)) = 0 Then
            'si es fija
            combo.AddItem Datos(1) & Space(100) & Datos(3)
            combo.ItemData(combo.NewIndex) = Val(Datos(2))
        Else
            combo1.AddItem Datos(1) & Space(100) & Datos(3)
            combo1.ItemData(combo1.NewIndex) = Val(Datos(2))
        End If
    Loop
    
    If combo.ListCount = 0 Then
        combo.AddItem "FIJA" & Space(100) & "0"
        combo.ItemData(combo.NewIndex) = 0
    End If
    
    combo.ListIndex = 0
           
End Function
Function BuscarDatos()
Dim Mantencion          As New clsMantencionSwap
Dim RutPaso             As String
Dim total               As Double
Dim desde, Hasta, i, j  As Integer
    
    tabFlujos.Tag = "Pagamos"
    Call LLenafgrdFlujos
    
    tabFlujos.Tag = "Recibimos"
    Call LLenafgrdFlujos
    
    grdRecibimos.Rows = 1
    grdPagamos.Rows = 1
    desde = 1
    j = 1
    
With Mantencion
        
    If OperSwap = "ModificacionCartera" Then
        
        'Busca datos en cartera  historica - movimientos vencidos
        .NumOperacion = swModNumOpe
        .TipoOperacion = 4
        If Not .LeerDatos Then
            Set Mantencion = Nothing
        
        ElseIf .coleccion.Count > 0 Then
        
            Hasta = .coleccion.Count
            grdRecibimos.Rows = Hasta + 1
            grdPagamos.Rows = Hasta + 1
            For i = desde To Hasta
                        
                grdRecibimos.TextMatrix(i, 0) = .coleccion(i).swNumFlujo & "  "
                grdRecibimos.TextMatrix(i, 1) = .coleccion(i).swFechaVenceFlujo
                grdRecibimos.TextMatrix(i, 2) = Format(.coleccion(i).swCAmortiza, "###,###,###,##0.###0")
                grdRecibimos.TextMatrix(i, 3) = Format(.coleccion(i).swCValorTasa, "###0.###0")
                grdRecibimos.TextMatrix(i, 4) = Format(.coleccion(i).swCInteres, "###,###,###,##0.###0")
                total = Val(.coleccion(i).swCInteres) + Val(.coleccion(i).swCAmortiza)
                grdRecibimos.TextMatrix(i, 5) = Format(total, "###,###,###,##0.###0")
                grdRecibimos.TextMatrix(i, 6) = IIf(.coleccion(i).swModalidadPago = "C", "Compensación" & Space(50) & "C" _
                                                    , "Ent. Fisica" & Space(50) & "F")
                grdRecibimos.TextMatrix(i, 8) = .coleccion(i).swCSaldo
                grdRecibimos.TextMatrix(i, 9) = .coleccion(i).swFechaInicioFlujo
                grdRecibimos.TextMatrix(i, 10) = .coleccion(i).swPagMonto
                grdRecibimos.TextMatrix(i, 11) = .coleccion(i).swPagMontoUSD
                grdRecibimos.TextMatrix(i, 12) = .coleccion(i).swPagMontoCLP
                grdRecibimos.TextMatrix(i, 13) = "CH"
                total = 0
                
                grdPagamos.TextMatrix(i, 0) = .coleccion(i).swNumFlujo & "  "
                grdPagamos.TextMatrix(i, 1) = .coleccion(i).swFechaVenceFlujo
                grdPagamos.TextMatrix(i, 2) = Format(.coleccion(i).swVAmortiza, "###,###,###,##0.###0")
                grdPagamos.TextMatrix(i, 3) = Format(.coleccion(i).swVValorTasa, "###0.###0")
                grdPagamos.TextMatrix(i, 4) = Format(.coleccion(i).swVInteres, "###,###,###,##0.###0")
                total = Val(.coleccion(i).swVInteres) + Val(.coleccion(i).swVAmortiza)
                grdPagamos.TextMatrix(i, 5) = Format(total, "###,###,###,##0.###0")
                grdPagamos.TextMatrix(i, 6) = IIf(.coleccion(i).swModalidadPago = "C", "Compensación" & Space(50) & "C" _
                                                    , "Ent. Fisica" & Space(50) & "E")
                grdPagamos.TextMatrix(i, 8) = .coleccion(i).swVSaldo
                grdPagamos.TextMatrix(i, 9) = .coleccion(i).swFechaInicioFlujo
                grdPagamos.TextMatrix(i, 10) = .coleccion(i).swPagMonto
                grdPagamos.TextMatrix(i, 11) = .coleccion(i).swPagMontoUSD
                grdPagamos.TextMatrix(i, 12) = .coleccion(i).swPagMontoCLP
                grdPagamos.TextMatrix(i, 13) = "CH"
                total = 0
                
            Next i
            
            j = grdRecibimos.Rows
            lblSwapTasa(22).Visible = True
            Simbologia.Visible = True
        
        End If
        'Limpiar
        Set .coleccion = Nothing
                
    End If
              
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
    etqNumOper.Tag = swModNumOpe
    etqNumOper.Caption = swModNumOpe
    txtCapital.Text = .coleccion(i).swCCapital
    txtCapital.Tag = .coleccion(i).swCCapital
    
    If .coleccion(i).swTipoOperacion = "C" Then
        optCompra.Value = True
        Operacion = "C"
    Else
        optVenta.Value = True
        Operacion = "V"
    End If
    If .coleccion(1).swModalidadPago = "C" Then
        optCompensa.Value = True
    Else
        optEntFisica.Value = True
    End If
    
    FechaCierre = .coleccion(i).swFechaCierre
    txtFecTermino.Text = Format(.coleccion(i).swFechaTermino, "dd/mm/yyyy") 'swFechaCierre
    txtFecInicio.Text = Format(.coleccion(i).swFechaInicio, "dd/mm/yyyy")
    
    txtTasaCompra.Text = .coleccion(i).swCValorTasa
    txtTasaVenta.Text = .coleccion(i).swVValorTasa
    txtTasaCompra.Tag = Val(.coleccion(i).swCValorTasaHoy)
    txtTasaVenta.Tag = Val(.coleccion(i).swVValorTasaHoy)
    
    Call bacBuscarCombo(cmbMoneda, .coleccion(i).swCMoneda)
    Call bacBuscarCombo(cmbCarteraInversion, .coleccion(i).swCarteraInversion)
    
    Call BuscaCmbAmortiza(cmbAmortizaCapital, .coleccion(i).swCCodAmoCapital)
    Call BuscaCmbAmortiza(cmbAmortizaInteres, .coleccion(i).swCCodAmoInteres)
    
    Call BuscaCmbAmortiza(cmbBaseCompra, .coleccion(i).swCBase)
    Call BuscaCmbAmortiza(cmbBaseVenta, .coleccion(i).swVBase)
    
    Call bacBuscarCombo(cmbTasaCompra, .coleccion(i).swCCodigoTasa)
    
    Call bacBuscarCombo(cmbTasaVenta, .coleccion(i).swVCodigoTasa)
    
    'CALL MonYDocxMoneda(
    'Call MonYDocxMoneda(DatosPorMoneda(), TotDatPorMon)
    
    
    Call bacBuscarCombo(cmbMonedaPagamos, .coleccion(i).swPagMoneda)
    Call bacBuscarCombo(cmbMonedaRecibimos, .coleccion(i).swRecMoneda)
    
    'Call LlenaComboPagRec(cmbDocumentoPagamos, .coleccion(i).swCMoneda)
    
    'Call LlenaComboPagRec(cmbDocumentoRecibimos, .coleccion(i).swCMoneda)
    'Call LlenaComboPagRec(cmbDocumentoPagamos, .coleccion(i).swPagMoneda)
    'Call LlenaComboPagRec(cmbDocumentoRecibimos, .coleccion(i).swRecMoneda)
    Call bacBuscarCombo(cmbDocumentoPagamos, .coleccion(i).swPagDocumento)
    Call bacBuscarCombo(cmbDocumentoRecibimos, .coleccion(i).swRecDocumento)
    
    txtCliente.Tag = .coleccion(i).swCodCliente
    txtCliente.Text = .coleccion(i).swNomCliente
    If (.coleccion(i).swRutCliente) <> "" Then
        txtRut.Text = BacFormatoRut(.coleccion(i).swRutCliente)  'Rutpaso
    End If
    
    If .coleccion(i).swOperadorCliente <> 0 Then
'        Call Operadores(cmbOperador, .coleccion(i).swRutCliente, .coleccion(i).swCodCliente)
        Call Operadores(cmbOperador, Mid(.coleccion(i).swRutCliente, 1, 9), .coleccion(i).swCodCliente)
        Call bacBuscarCombo(cmbOperador, .coleccion(i).swOperadorCliente)
    End If
    
   
    'Llenar arreglos con datos
    
    grdRecibimos.Rows = grdRecibimos.Rows + (Hasta)
    grdPagamos.Rows = grdPagamos.Rows + (Hasta)
    For i = 1 To Hasta
        
        grdRecibimos.TextMatrix(j, 0) = .coleccion(i).swNumFlujo & "  "
        grdRecibimos.TextMatrix(j, 1) = Format(.coleccion(i).swFechaVenceFlujo, "dd/mm/yyyy")
        grdRecibimos.TextMatrix(j, 2) = Format(.coleccion(i).swCAmortiza, "###,###,###,##0.###0")
        grdRecibimos.TextMatrix(j, 3) = Format(.coleccion(i).swCValorTasa, "###0.###0")
        grdRecibimos.TextMatrix(j, 4) = Format(.coleccion(i).swCInteres, "###,###,###,##0.###0")
        total = Val(.coleccion(i).swCInteres)
        grdRecibimos.TextMatrix(j, 5) = Format(total, "###,###,###,##0.###0")
        grdRecibimos.TextMatrix(j, 6) = IIf(.coleccion(i).swModalidadPago = "C", "Compensación" & Space(50) & "C" _
                                            , "Ent. Fisica" & Space(50) & "F")
        grdRecibimos.TextMatrix(j, 8) = .coleccion(i).swCSaldo
        grdRecibimos.TextMatrix(j, 9) = Format(.coleccion(i).swFechaInicioFlujo, "dd/mm/yyyy")
        grdRecibimos.TextMatrix(j, 10) = .coleccion(i).swPagMonto
        grdRecibimos.TextMatrix(j, 11) = .coleccion(i).swPagMontoUSD
        grdRecibimos.TextMatrix(j, 12) = .coleccion(i).swPagMontoCLP
        grdRecibimos.TextMatrix(j, 13) = "C"
        
        total = 0
        grdPagamos.TextMatrix(j, 0) = .coleccion(i).swNumFlujo & "  "
        grdPagamos.TextMatrix(j, 1) = Format(.coleccion(i).swFechaVenceFlujo, "dd/mm/yyyy")
        grdPagamos.TextMatrix(j, 2) = Format(.coleccion(i).swVAmortiza, "###,###,###,##0.###0")
        grdPagamos.TextMatrix(j, 3) = Format(.coleccion(i).swVValorTasa, "###0.###0")
        grdPagamos.TextMatrix(j, 4) = Format(.coleccion(i).swVInteres, "###,###,###,##0.###0")
        total = Val(.coleccion(i).swVInteres)
        grdPagamos.TextMatrix(j, 5) = Format(total, "###,###,###,##0.###0")
        grdPagamos.TextMatrix(j, 6) = IIf(.coleccion(i).swModalidadPago = "C", "Compensación" & Space(50) & "C" _
                                            , "Ent. Fisica" & Space(50) & "F")
        grdPagamos.TextMatrix(j, 8) = .coleccion(i).swVSaldo
        grdPagamos.TextMatrix(j, 9) = Format(.coleccion(i).swFechaInicioFlujo, "dd/mm/yyyy")
        grdPagamos.TextMatrix(j, 10) = .coleccion(i).swPagMonto
        grdPagamos.TextMatrix(j, 11) = .coleccion(i).swPagMontoUSD
        grdPagamos.TextMatrix(j, 12) = .coleccion(i).swPagMontoCLP
        grdPagamos.TextMatrix(j, 13) = "C"
        
        total = 0
        j = j + 1
    Next i
    
    Set .coleccion = Nothing
    
    If CDbl(grdRecibimos.TextMatrix(1, 2)) > 0 Then
        txtFecPrimerVcto.Text = Format(grdRecibimos.TextMatrix(1, 1), "dd/mm/yyyy")
    Else
        txtFecPrimerVcto.Text = Format(grdRecibimos.TextMatrix(2, 1), "dd/mm/yyyy")
    End If
    
    End With
    lblFechaInicio = BacFechaStr(txtFecInicio.Text)
    lblFechaPrimerAmort = BacFechaStr(txtFecPrimerVcto.Text)
    lblFechaTermino = BacFechaStr(txtFecTermino.Text)
    
    Call CambiaColorCeldas(grdPagamos)
    Call CambiaColorCeldas(grdRecibimos)
    
    Set Mantencion = Nothing
    
End Function


Function CalculoInteresBonos(BaseStr As String, ByRef Grd As Object)
    Dim Spread, Base, Tasa As Double
    Dim FechaAmortiza As Date
    Dim FechaVencAnt, FecVAnt As Date
    Dim DiasDif As Integer
    Dim cuenta As Integer
    Dim MontoAmortiza, MontoCapital, MontoGrd As Double
    Dim Interes, Plazo  As Double
    Dim RestoCapital As Double
    Dim TotalVenc As Double
    
    Spread = 0
    
    'Barra.Value = Barra.Value + 1                               'Incremento Barra (avanza)
   
    MontoCapital = (txtCapital.Text)                             'Monto Capital
    
    Base = BaseStr    'Base asignada para calculo
    DiasDif = DateDiff("d", CDate(txtFecInicio.Text), CDate(grdRecibimos.TextMatrix(1, 1)))
    FechaVencAnt = CDate(txtFecInicio.Text)
    MontoAmortiza = CDbl((txtCapital.Text))
    
    With Grd
    For cuenta = 1 To .Rows - 1
    
        FechaAmortiza = .TextMatrix(cuenta, 1)
        MontoGrd = .TextMatrix(cuenta, 2)
        RestoCapital = CDbl(.TextMatrix(cuenta, 2)) 'MontoAmortCap
        Tasa = CDbl(.TextMatrix(cuenta, 3))
        DiasDif = DateDiff("d", CDate(FechaVencAnt), CDate(FechaAmortiza))
        FecVAnt = FechaVencAnt
        FechaVencAnt = .TextMatrix(cuenta, 1)
        
        'If Val(Base) = 30 Then
        '    Plazo = ((DiasDif / 30) * 30) / 360
        'Else
            Plazo = DiasDif / Val(Base)
        'End If
        Interes = Round(MontoAmortiza * ((Tasa / 100) + (Spread / 100)) * (Plazo), 4)
        
        '***
        TotalVenc = MontoGrd + Interes
        
        '***Traspaso de Datos a Arreglo
        .TextMatrix(cuenta, 0) = cuenta ' + 1
        .TextMatrix(cuenta, 1) = Format(FechaAmortiza, gsc_FechaDMA)
        .TextMatrix(cuenta, 2) = Format(MontoGrd, "###,###,###,##0.###0")
        .TextMatrix(cuenta, 3) = Format(Tasa, "####0.###0")
        .TextMatrix(cuenta, 4) = Format(Interes, "###,###,###,##0.###0")
        .TextMatrix(cuenta, 5) = Format(TotalVenc, "###,###,###,##0.###0")
        .TextMatrix(cuenta, 8) = MontoAmortiza
        .TextMatrix(cuenta, 9) = FecVAnt
        .TextMatrix(cuenta, 10) = MontoAmortiza
        MontoAmortiza = MontoAmortiza - RestoCapital
        '***
    Next
    End With
    
End Function

Function CalculoInteres()
    Dim SpreadC, BaseC, TasaC, PlazoC, InteresC As Double
    Dim SpreadV, BaseV, TasaV, PlazoV, InteresV As Double
    Dim FechaAmortiza, FechaAmortizaCap, FechaAmortizaInt As Date
    Dim FechaIniAmortCap, FechaIniAmort As Date
    Dim FechaFin, FechaVencAnt, FechaDePaso As Date
    Dim DiasAmortCap, DiasAmortInt, DiaAmort As Integer
    Dim DiasDif, FactorDiv As Integer
    Dim cuenta As Integer
    Dim MontoAmortiza, MontoCapital, MontoGrd As Double
    Dim RestoCapital As Double
    Dim MontoAmortCap  As Double
    Dim dias%
    Dim CuentaAmCap As Integer
    Dim FactorUSDc, FactorCLP, MontoUSDc, MontoCLPc As Double
    Dim FactorUSDv, MontoUSDv, MontoCLPv As Double
    Dim MonFuerteC, MonFuerteV As Integer
    Dim FechaProceso As String
    Dim CodMonC As Integer
    Dim CodMonV As Integer
    Dim SaldoCapital As Double
    Dim i As Integer
    Dim lEspecial  As Boolean
    Dim PlazoMin As Integer
    Dim PlazoMax  As Integer
    Dim Grd As Object
    Dim objTemp As Object
    '*************************************
    '* Primer Calculo Amortizacion de Interes  *
    '*************************************
  
  '*****
    FechaProceso = IIf(OperSwap = "Ingreso", gsBAC_Fecp, FechaCierre)
    
    'Busca valor moneda de acuerdo a lo seleccionado
    If cmbMonedaPagamos.ListIndex <> -1 Then
        CodMonV = cmbMonedaPagamos.ItemData(cmbMonedaPagamos.ListIndex)
    Else
        CodMonV = 994 'dolar  observado
    End If
    
    If cmbMonedaRecibimos.ListIndex <> -1 Then
        CodMonC = cmbMonedaRecibimos.ItemData(cmbMonedaRecibimos.ListIndex)
    Else
        CodMonC = 994 'dolar  observado
    End If
    
    FactorUSDc = 0:     FactorUSDv = 0
    FactorCLP = 0
    
'If False Then
    Dim ValMonedas As New clsMoneda
    
    If ValMonedas.LeerxCodigo(CodMonV) Then
        FactorUSDv = ValMonedas.vmValor     'equivalencia a 1 dolar
        MonFuerteV = ValMonedas.mnrefusd    'Caracteristica moneda ( fuerte o no)
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
    '*****

    MontoCapital = CDbl(txtCapital.Tag)                                   'Monto Capital
    DiasAmortCap = cmbAmortizaCapital.ItemData(cmbAmortizaCapital.ListIndex)    'Total de dias real para Amortizacion Capital
    DiasAmortInt = cmbAmortizaInteres.ItemData(cmbAmortizaInteres.ListIndex)    'Total de dias real para Amortizacion del Interes
        
    
    '***Inicializaciones de Fecha
    
    If DiasAmortCap > DiasAmortInt Then
        PlazoMin = DiasAmortInt
        PlazoMax = DiasAmortCap
    Else
       PlazoMin = IIf(DiasAmortCap > 0, DiasAmortCap, DiasAmortInt)
       PlazoMax = DiasAmortInt
    End If
    
    Dim m
    m = DateDiff("m", CDate(txtFecInicio.Text), CDate(txtFecTermino.Text))
    m = IIf(m > 0, m, PlazoMin)
    Barra.Max = (m / PlazoMin) * 2
    
    framBarra.Visible = True
    
    'Barra.Value = Barra.Value + 1                               'Incremento Barra (avanza)

    '---- Define fechas para generar Flujos
    FechaFin = CDate(txtFecTermino.Text)
    FechaVencAnt = CDate(txtFecInicio.Text)
    
     '---- Es Especial
    If DiasAmortCap > 0 Then
        FechaIniAmortCap = CreaFechaProx(txtFecInicio.Text, DiasAmortCap, Day(txtFecInicio.Text))
    Else
        FechaIniAmortCap = CreaFechaProx(txtFecInicio.Text, DiasAmortInt, Day(txtFecInicio.Text))
    End If
    lEspecial = (CDate(txtFecPrimerVcto.Text) <> CDate(FechaIniAmortCap))

    '---- Primer Vencimiento
    If lEspecial Then
        FechaIniAmortCap = CDate(txtFecPrimerVcto.Text)
        FechaIniAmort = txtFecPrimerVcto.Text
        FechaAmortizaCap = CDate(txtFecPrimerVcto.Text)
        FechaAmortizaInt = CDate(txtFecPrimerVcto.Text)
        FechaAmortiza = CDate(txtFecPrimerVcto.Text)
    Else
        FechaIniAmort = CreaFechaProx(txtFecInicio.Text, PlazoMin, Day(txtFecInicio.Text))
        FechaAmortizaCap = CreaFechaProx(txtFecInicio.Text, DiasAmortCap, Day(txtFecInicio.Text))
        FechaAmortizaInt = CreaFechaProx(txtFecInicio.Text, DiasAmortInt, Day(txtFecInicio.Text))
        FechaAmortiza = FechaIniAmort
        If Abs(DateDiff("d", CDate(FechaFin), CDate(FechaAmortizaCap))) <= 10 Then
            FechaAmortizaCap = FechaFin
        End If
    End If
   
    '***
    FactorDiv = 0
    DiaAmort = Day(txtFecPrimerVcto.Text)
    
    If OperSwap <> "ModificacionCartera" Then 'Operaciones del dia
        If DiasAmortCap <= 0 Then
            If Not lEspecial Then
                'Para los casos que el período es BULLET ó BONO Amortizacion de monto en fecha final
                FechaAmortizaCap = CDate(txtFecTermino.Text)
                FactorDiv = 1
            Else
                FechaAmortizaCap = CDate(txtFecPrimerVcto.Text)
                FactorDiv = 2
            End If
        Else   '***Veces en que se Dividira Capital para amortizar
            FactorDiv = DateDiff("m", FechaIniAmortCap, CDate(FechaFin)) / DiasAmortCap
            'Sera cero cuando las fechas son iguales
'            FactorDiv = IIf(FactorDiv = 0, 1, FactorDiv)
            FactorDiv = FactorDiv + 1
        End If
        
        DiasDif = DateDiff("d", txtFecInicio.Text, FechaAmortiza)
         '***
        MontoAmortiza = (MontoCapital)
         '***Monto a amortizar en los vctos.
        MontoAmortCap = Round(MontoCapital / FactorDiv, 4)
        cuenta = 1
        grdPagamos.Rows = 1
        grdRecibimos.Rows = 1
    Else
        'Flujos de Operaciones vigentes
        Set Grd = grdPagamos
        For i = 1 To Grd.Rows - 1
            If Grd.TextMatrix(i, 13) = "CH" Then
                If i = Grd.Rows - 1 Then
                    SaldoCapital = CDbl(Grd.TextMatrix(i, 8))
                Else
                    SaldoCapital = CDbl(Grd.TextMatrix(i + 1, 8))
                End If
                FechaAmortiza = Grd.TextMatrix(i, 1)
                FechaVencAnt = Grd.TextMatrix(i, 9)
                cuenta = i
                If CDbl(Grd.TextMatrix(i, 2)) <> 0 Then
                'hubo amortizacion de capital
                    FechaDePaso = CDate(Grd.TextMatrix(i, 1))
                End If
            Else
                Exit For
            End If
        Next
        
        ' factor division de monto restante para amortizacion del capital
        FechaAmortizaCap = CreaFechaProx(FechaDePaso, DiasAmortCap, DiaAmort)
        FactorDiv = 0
        While FechaAmortizaCap <= FechaFin
            FactorDiv = FactorDiv + 1
            FechaAmortizaCap = CreaFechaProx(FechaAmortizaCap, DiasAmortCap, DiaAmort)
            If FechaAmortizaCap > FechaFin And _
                 Abs(DateDiff("d", CDate(FechaAmortizaCap), CDate(FechaFin))) <= 10 Then
                     FechaAmortizaCap = FechaFin
            End If
        Wend
        
        FechaVencAnt = FechaAmortiza
        FechaAmortiza = CreaFechaProx(FechaAmortiza, PlazoMin, DiaAmort)
        If FechaAmortiza > FechaFin And _
             Abs(DateDiff("d", CDate(FechaAmortiza), CDate(FechaFin))) <= 10 Then
                 FechaAmortiza = FechaFin
        End If

        '***Próxima Fecha Vcto. Amort. Capital
        FechaAmortizaCap = CreaFechaProx(FechaDePaso, DiasAmortCap, DiaAmort)
        If FechaAmortizaCap > FechaFin And _
             Abs(DateDiff("d", CDate(FechaAmortizaCap), CDate(FechaFin))) <= 10 Then
                 FechaAmortizaCap = FechaFin
        End If
    
        '***
        DiasDif = DateDiff("d", CDate(FechaVencAnt), CDate(FechaAmortiza))
        FactorDiv = IIf(FactorDiv = 0, 1, FactorDiv)
        MontoAmortiza = SaldoCapital
        MontoAmortCap = Round((SaldoCapital / FactorDiv), 4)
        cuenta = cuenta + 1
        Grd.Rows = cuenta
        
    End If
    
    SpreadC = 0:        BaseC = cmbBaseCompra:      TasaC = txtTasaCompra.Text
    SpreadV = 0:        BaseV = cmbBaseVenta:         TasaV = txtTasaVenta.Text
    
    While CDate(FechaAmortiza) <= CDate(FechaFin)
        'Barra.Value = Barra.Value + 1                                                'Incremento de barra
        '***
        MontoUSDc = 0:        MontoCLPc = 0:        MontoGrd = 0:        RestoCapital = 0
        MontoUSDv = 0:        MontoCLPv = 0:
        
        grdPagamos.Rows = grdPagamos.Rows + 1 'Agregar fila a la grilla
        grdRecibimos.Rows = grdRecibimos.Rows + 1
        
        If FechaAmortizaCap = FechaAmortiza Then 'Si corresponde Amortizacion de Capital
            MontoGrd = MontoAmortCap
            RestoCapital = MontoAmortCap
            '***Próxima Fecha Vcto. Amort. Capital
            If DiasAmortCap <= 0 Then
                'Para los casos que el período es BULLET ó BONO Amortizacion de monto en fecha final
                FechaAmortizaCap = CDate(txtFecTermino.Text)
            Else   '***Veces en que se Dividira Capital para amortizar
                FechaAmortizaCap = CreaFechaProx(FechaAmortizaCap, DiasAmortCap, DiaAmort)
            End If
            If FechaAmortizaCap > FechaFin Then
                 If Abs(DateDiff("d", CDate(FechaAmortizaCap), CDate(FechaFin))) <= 10 Then
                     FechaAmortizaCap = FechaFin
                 End If
            Else
                 If Abs(DateDiff("d", CDate(FechaFin), CDate(FechaAmortizaCap))) <= 10 Then
                     FechaAmortizaCap = FechaFin
                End If
            End If
        End If
        
        '*** Calculo de Compra
        'If Val(BaseC) = 30 Then
        '    PlazoC = ((DiasDif / 30) * 30) / 360
        'Else
            PlazoC = DiasDif / Val(BaseC)
        'End If
        InteresC = Round(MontoAmortiza * ((TasaC / 100) + (SpreadC / 100)) * (PlazoC), 4)
        
        '*** Calculo de Venta
        'If Val(BaseV) = 30 Then
        '    PlazoV = ((DiasDif / 30) * 30) / 360
        'Else
            PlazoV = DiasDif / Val(BaseV)
        'End If
        InteresV = Round(MontoAmortiza * ((TasaV / 100) + (SpreadV / 100)) * (PlazoV), 4)
        
        'Monto en dolares
        MontoUSDc = IIf(Val(MonFuerteC) = 1, (InteresC * FactorUSDc), (BacDiv(InteresC, CDbl(FactorUSDc))))
        MontoUSDc = Round(MontoUSDc, 3)
        ' A Pesos
        MontoCLPc = (MontoUSDc * FactorCLP)
        'Monto en dolares
        MontoUSDv = IIf(Val(MonFuerteV) = 1, (InteresV * FactorUSDv), (BacDiv(InteresV, CDbl(FactorUSDv))))
        MontoUSDv = Round(MontoUSDv, 3)
        ' A Pesos
        MontoCLPv = MontoUSDv * FactorCLP
        
       ' MontoAmortiza = MontoAmortiza - RestoCapital
            
        '***Traspaso de Datos a Grilla
        grdPagamos.TextMatrix(cuenta, 0) = cuenta & "  "
        grdPagamos.TextMatrix(cuenta, 1) = Format(FechaAmortiza, gsc_FechaDMA)
        grdPagamos.TextMatrix(cuenta, 2) = Format(MontoGrd, "###,###,###,##0.###0")
        grdPagamos.TextMatrix(cuenta, 6) = IIf(optCompensa.Value = True, "Compensación" & Space(50) & "C" _
                                            , "Ent. Fisica" & Space(50) & "E")
        grdPagamos.TextMatrix(cuenta, 8) = MontoAmortiza - MontoGrd
        grdPagamos.TextMatrix(cuenta, 9) = FechaVencAnt
        grdPagamos.TextMatrix(cuenta, 10) = MontoAmortiza
        grdPagamos.TextMatrix(cuenta, 11) = MontoUSDv
        grdPagamos.TextMatrix(cuenta, 12) = MontoCLPv
        
        grdRecibimos.TextMatrix(cuenta, 0) = cuenta & "  "
        grdRecibimos.TextMatrix(cuenta, 1) = Format(FechaAmortiza, gsc_FechaDMA)
        grdRecibimos.TextMatrix(cuenta, 2) = Format(MontoGrd, "###,###,###,##0.###0")
        grdRecibimos.TextMatrix(cuenta, 6) = IIf(optCompensa.Value = True, "Compensación" & Space(50) & "C" _
                                            , "Ent. Fisica" & Space(50) & "E")
        grdRecibimos.TextMatrix(cuenta, 8) = MontoAmortiza - MontoGrd
        grdRecibimos.TextMatrix(cuenta, 9) = FechaVencAnt
        grdRecibimos.TextMatrix(cuenta, 10) = MontoAmortiza
        grdRecibimos.TextMatrix(cuenta, 11) = MontoUSDc
        grdRecibimos.TextMatrix(cuenta, 12) = MontoCLPc
        
        grdPagamos.TextMatrix(cuenta, 3) = Format(TasaV, "####0.###0")
        grdPagamos.TextMatrix(cuenta, 4) = Format(InteresV, "###,###,###,##0.###0")
        grdPagamos.TextMatrix(cuenta, 5) = Format(InteresV, "###,###,###,##0.###0")
        grdRecibimos.TextMatrix(cuenta, 3) = Format(TasaC, "####0.###0")
        grdRecibimos.TextMatrix(cuenta, 4) = Format(InteresC, "###,###,###,##0.###0")
        grdRecibimos.TextMatrix(cuenta, 5) = Format(InteresC, "###,###,###,##0.###0")
        
        '***Actualizacion de datos para Prox. amortizacion
        MontoAmortiza = MontoAmortiza - RestoCapital
        FechaVencAnt = FechaAmortiza
        FechaAmortiza = CreaFechaProx(FechaAmortiza, PlazoMin, DiaAmort)
            
        If FechaAmortiza > FechaFin And _
            Abs(DateDiff("d", CDate(FechaAmortiza), CDate(FechaFin))) <= 10 Then
                     FechaAmortiza = FechaFin
        Else
            If Abs(DateDiff("d", CDate(FechaFin), CDate(FechaAmortiza))) <= 10 Then
                     FechaAmortiza = FechaFin
            End If
        End If
        DiasDif = DateDiff("d", FechaVencAnt, FechaAmortiza)
        
        '***
        cuenta = cuenta + 1
    Wend
        
    Barra.Value = Barra.Max
        
End Function
Function SugerirFechaPrimVecto()
Dim DiasCap, DiasInt, DiasASumar As Integer
Dim FechaResultado As Date

'Sugiere fecha Primer y Ultimo vencimiento

    If cmbAmortizaCapital.ListIndex = -1 Or cmbAmortizaInteres.ListIndex = -1 Then
        txtFecPrimerVcto.Text = CreaFechaProx(txtFecInicio.Text, 1, Day(txtFecInicio.Text))
    Else
        
        If False Then        '--- En dias
            DiasCap = cmbAmortizaCapital.ItemData(cmbAmortizaCapital.ListIndex)
            DiasInt = Val(Right(cmbAmortizaInteres, 5))
        Else                '--- En meses
            DiasCap = cmbAmortizaCapital.ItemData(cmbAmortizaCapital.ListIndex) ' ???
            DiasInt = Val(Left(Right(cmbAmortizaInteres, 10), 5))
        End If
        DiasCap = IIf(DiasCap <= 0, DiasInt, DiasCap)
        
        'Primer Vencimiento
        txtFecPrimerVcto.Text = CreaFechaProx(txtFecInicio.Text, DiasCap, Day(txtFecInicio.Text)) ' FechaResultado
        lblFechaPrimerAmort = BacFechaStr(txtFecPrimerVcto.Text)
        'Primer Ultimo Vencimiento
        txtFecTermino.Text = txtFecPrimerVcto.Text 'FechaResultado
        lblFechaTermino = BacFechaStr(txtFecTermino.Text)
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
    
    Spread = 0
  
    If tabFlujos.Tag = "Recibimos" Then
      Set ObjetoGrid = grdRecibimos
    Else
      Set ObjetoGrid = grdPagamos
    End If
    
  With ObjetoGrid
 
    MontoCapital = CDbl(txtCapital.Text)   'Monto Capital
    Tasa = RecTasa                                   'Tasa
    MontoAmortiza = RecMontoResto        'Monto Amortizado en el Calculo de interes
    MontoAmortCap = RecMontoAmort     'Monto que vence ("amortizado")
    
    FechaAmortiza = RecFecha                  'Fecha de Vencimiento o Amortizacion
    FechaVencAnt = RecFecVencAnt        'Fecha Vcto. anterior
    If filGrd = 0 Then                                  'Primera fila
        DiasDif = DateDiff("d", CDate(txtFecInicio.Text), CDate(FechaAmortiza))     'Dias distancia
    Else
       DiasDif = DateDiff("d", CDate(FechaVencAnt), CDate(FechaAmortiza))      'Dias distancia
    End If

    '*** Calculo
    'If Val(Base) = 30 Then
    '    Plazo = ((DiasDif / 30) * 30) / 360
    'Else
        Plazo = DiasDif / Val(Base)
    'End If
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

    If OperSwap = "ModificacionCartera" Or OperSwap = "Modificacion" Then
        BacConsultaOper.Show
    End If

End Sub

Private Sub grdPagamos_EnterCell()

With grdPagamos

    If .TextMatrix(.Row, 13) = "CH" Then Exit Sub ' Si es modificacion de cartera los flujos de cartera

    txtTasaPag.Visible = False
    txtAmortizaPag.Visible = False
    cmbModalidadPag.Visible = False
    txtTasaPag.Text = 0
    txtAmortizaPag.Text = 0
    
    If .Row = 0 Then Exit Sub
    If Operacion <> "V" Then Exit Sub
    
    Select Case .Col
    Case 2
        If TipoAm = -1 Then
            'cambio en monto amortizacion
            txtAmortizaPag.Left = .CellLeft + 50
            txtAmortizaPag.Top = .CellTop + 410
            txtAmortizaPag.Text = .TextMatrix(.Row, 2)
            txtAmortizaPag.Tag = .Row
            txtAmortizaPag.Visible = True
            txtAmortizaPag.SetFocus
        End If
    Case 3
        txtTasaPag.Left = .CellLeft + 50
        txtTasaPag.Top = .CellTop + 410
        txtTasaPag.Text = .TextMatrix(.Row, 3)
        txtTasaPag.Tag = .Row
        txtTasaPag.Visible = True
        txtTasaPag.SetFocus
    Case 6
        cmbModalidadPag.Left = .CellLeft + 30
        cmbModalidadPag.Top = .CellTop + 410
        cmbModalidadPag.ListIndex = IIf(Right(.TextMatrix(.Row, 6), 1) = "C", 0, 1)
        cmbModalidadPag.Tag = .Row
        cmbModalidadPag.Visible = True
        cmbModalidadPag.SetFocus
    End Select
    
End With

End Sub

Private Sub grdPagamos_LostFocus()

Dim i As Integer
Dim SumAmort As Double
Dim Res

    SumAmort = 0
    If grdRecibimos.TextMatrix(i, 2) = "" Then Exit Sub
    
    If TipoAm = -1 And Operacion = "V" Then
        'Amortizacion de capital BONOS
        For i = 1 To grdPagamos.Rows - 1
            SumAmort = SumAmort + CDbl(grdPagamos.TextMatrix(i, 2))
        Next
        If SumAmort <> CDbl(txtCapital.Text) Then
            Res = MsgBox("Amortización acumulada no corresponde. ¿Recalcular Montos con Cambio?", vbQuestion + vbYesNo, Msj)
            If Res = vbYes Then
                txtCapital.Text = SumAmort
                Call CalculoInteresBonos(cmbBaseCompra, grdRecibimos)
                Call CalculoInteresBonos(cmbBaseVenta, grdPagamos)
            End If
        End If
    End If

End Sub

Private Sub grdPagamos_Scroll()
    
    cmbModalidadPag.Visible = False
    txtTasaPag.Visible = False
    txtAmortizaPag.Visible = False

End Sub

Private Sub grdRecibimos_EnterCell()

With grdRecibimos

    If .TextMatrix(.Row, 13) = "CH" Then Exit Sub ' Si es modificacion de cartera los flujos de cartera

    txtTasa.Visible = False
    txtAmortiza.Visible = False
    cmbModalidad.Visible = False
    txtTasa.Text = 0
    txtAmortiza.Text = 0
    
    If .Row = 0 Then Exit Sub
    If Operacion <> "C" Then Exit Sub
    
    Select Case .Col
    Case 2
        If TipoAm = -1 Then
            'cambio en monto amortizacion
            txtAmortiza.Left = .CellLeft + 50
            txtAmortiza.Top = .CellTop + 410
            txtAmortiza.Text = .TextMatrix(.Row, 2)
            txtAmortiza.Tag = .Row
            txtAmortiza.Visible = True
            txtAmortiza.SetFocus
        End If
    Case 3
        txtTasa.Left = .CellLeft + 50
        txtTasa.Top = .CellTop + 410
        txtTasa.Text = .TextMatrix(.Row, 3)
        txtTasa.Tag = .Row
        txtTasa.Visible = True
        txtTasa.SetFocus
    Case 6
        cmbModalidad.Left = .CellLeft + 30
        cmbModalidad.Top = .CellTop + 410
        cmbModalidad.ListIndex = IIf(Right(.TextMatrix(.Row, 6), 1) = "C", 0, 1)
        cmbModalidad.Tag = .Row
        cmbModalidad.Visible = True
        cmbModalidad.SetFocus
    End Select
    
End With

End Sub

Private Sub grdRecibimos_LostFocus()

Dim i As Integer
Dim SumAmort As Double
Dim Res

    SumAmort = 0
    If grdRecibimos.TextMatrix(i, 2) = "" Then Exit Sub
    
    If TipoAm = -1 And Operacion = "C" Then

        'Amortizacion de capital BONOS
        For i = 1 To grdRecibimos.Rows - 1
            SumAmort = SumAmort + CDbl(grdRecibimos.TextMatrix(i, 2))
        Next
        
        If SumAmort <> CDbl(txtCapital.Text) Then
            Res = MsgBox("Amortización acumulada no corresponde. ¿Recalcular Montos con Cambio?", vbQuestion + vbYesNo, Msj)
            If Res = vbYes Then
                txtCapital.Text = SumAmort
                Call CalculoInteresBonos(cmbBaseCompra, grdRecibimos)
                Call CalculoInteresBonos(cmbBaseVenta, grdPagamos)
            End If
        End If
    End If

End Sub

Private Sub grdRecibimos_Scroll()

    cmbModalidad.Visible = False
    txtTasa.Visible = False
    txtAmortiza.Visible = False

End Sub

Private Sub optCompensa_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbCarteraInversion.SetFocus

End Sub

Private Sub optCompra_Click()

    Operacion = "C"
    Call TraspasaDatos

End Sub

Function TraspasaDatos()


    If Not optCompra.Value Then
        '---- Combo Tasa
        If cmbMoneda.ListIndex >= 0 Then
            objMoneda.CargaTasas cmbMoneda.ItemData(cmbMoneda.ListIndex), cmbTasaCompra
        End If
        If cmbTasaVenta.ListIndex >= 0 Then
            bacBuscarCombo cmbTasaCompra, cmbTasaVenta.ItemData(cmbTasaVenta.ListIndex)
        End If
        
        cmbTasaVenta.Clear
        cmbTasaVenta.AddItem "FIJA"
        cmbTasaVenta.ItemData(cmbTasaVenta.NewIndex) = 0
        cmbTasaVenta.ListIndex = 0
                
    Else
        '---- Combo Tasa
        If cmbMoneda.ListIndex >= 0 Then
            objMoneda.CargaTasas cmbMoneda.ItemData(cmbMoneda.ListIndex), cmbTasaVenta
        End If
        If cmbTasaCompra.ListIndex >= 0 Then
            bacBuscarCombo cmbTasaVenta, cmbTasaCompra.ItemData(cmbTasaCompra.ListIndex)
        End If
        
        cmbTasaCompra.Clear
        cmbTasaCompra.AddItem "FIJA"
        cmbTasaCompra.ItemData(cmbTasaCompra.NewIndex) = 0
        cmbTasaCompra.ListIndex = 0
        
        
    End If
    
    '---- Valor Tasa
    objTasa.Valor = Val(txtTasaVenta.Tag)
    txtTasaVenta.Tag = Val(txtTasaCompra.Tag)
    txtTasaCompra.Tag = objTasa.Valor
    txtTasaCompra.Text = txtTasaCompra.Tag
    txtTasaVenta.Text = txtTasaVenta.Tag
    
    '---- Bases
    objMoneda.mnbase = cmbBaseCompra.ListIndex
    cmbBaseCompra.ListIndex = cmbBaseVenta.ListIndex
    cmbBaseVenta.ListIndex = objMoneda.mnbase
    
    '---- Moneda de Pago
    objMoneda.mncodigo = cmbMonedaRecibimos.ListIndex
    cmbMonedaRecibimos.ListIndex = cmbMonedaRecibimos.ListIndex
    cmbMonedaRecibimos.ListIndex = objMoneda.mncodigo
    
    '---- Documento de Pago
    objFPago.Codigo = cmbDocumentoRecibimos.ListIndex
    cmbDocumentoRecibimos.ListIndex = cmbDocumentoPagamos.ListIndex
    
     If cmbDocumentoPagamos.ListCount <> 0 Then
         cmbDocumentoPagamos.ListIndex = objFPago.Codigo
     Else
         cmbDocumentoPagamos.ListIndex = -1
     End If
    
       
    If tabFlujos.TabEnabled(1) Then
        btnCalcular_Click
    End If
    
End Function
Function TraspasaDatosANT()
Dim CodPaso As Integer
Dim CodPaso1 As Integer
Dim Valor As Double
Dim Nom As String

CodPaso = 0
'rescata el codigo de la tasa variable
    If Operacion = "C" Then
        ' es compra pero este es el valor antes del traspaso
        If cmbTasaCompra.ListIndex <> -1 Then
            CodPaso = cmbTasaCompra.ItemData(cmbTasaCompra.ListIndex)
        End If
    Else
        If cmbTasaVenta.ListIndex <> -1 Then
            CodPaso = cmbTasaVenta.ItemData(cmbTasaVenta.ListIndex)
        End If
    End If

'da vuelta las tasas
    Call LlenaComboTasas(IIf(optCompra.Value = True, 1, 2), _
                    SacaCodigo(cmbMoneda), _
                    42, _
                    IIf(OperSwap = "ModificacionCartera", Format(FechaCierre, "yyyymmdd"), Format(gsBAC_Fecp, "yyyymmdd")))
    
'posiciona tasa variable si estaba seleccionada

    If Operacion = "C" Then
        Call bacBuscarCombo(cmbTasaVenta, CodPaso)
    Else
        Call bacBuscarCombo(cmbTasaCompra, CodPaso)
    End If
                        
    '*** Traspaso  valor tasa
    Valor = CDbl(txtTasaCompra.Text)
    txtTasaCompra.Text = txtTasaVenta.Text
    txtTasaVenta.Text = Valor
    
    '*** Traspaso de bases
    Nom = cmbBaseCompra
    Call BuscaCmbAmortiza(cmbBaseCompra, Trim(cmbBaseVenta))
    Call BuscaCmbAmortiza(cmbBaseVenta, Nom)
    
    '*** Traspaso  de monedas
    CodPaso = 0
    CodPaso1 = 0
    If cmbMonedaPagamos.ListIndex > -1 Then
        CodPaso = cmbMonedaPagamos.ItemData(cmbMonedaPagamos.ListIndex)
    End If
    If cmbMonedaRecibimos.ListIndex > -1 Then
        CodPaso1 = cmbMonedaRecibimos.ItemData(cmbMonedaRecibimos.ListIndex)
    End If
        
    Call bacBuscarCombo(cmbMonedaPagamos, CodPaso1)
    Call bacBuscarCombo(cmbMonedaRecibimos, CodPaso)
    
    '*** Traspaso  de documentos
    CodPaso = 0
    CodPaso1 = 0
    
    If cmbDocumentoPagamos.ListIndex > -1 Then
        CodPaso = cmbDocumentoPagamos.ItemData(cmbDocumentoPagamos.ListIndex)
    End If
    If cmbDocumentoRecibimos.ListIndex > -1 Then
        CodPaso1 = cmbDocumentoRecibimos.ItemData(cmbDocumentoRecibimos.ListIndex)
    End If
    
    'Call LlenaComboPagRec(cmbDocumentoRecibimos, SacaCodigo(cmbMonedaCompra), Sistema)
    'Call LlenaComboPagRec(cmbDocumentoPagamos, SacaCodigo(cmbMonedaVenta), Sistema)

    Call bacBuscarCombo(cmbDocumentoPagamos, CodPaso1)
    Call bacBuscarCombo(cmbDocumentoRecibimos, CodPaso)
    
    If tabFlujos.TabEnabled(1) = True Then btnCalcular_Click
    
    
    
End Function

Private Sub optEntFisica_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then cmbCarteraInversion.SetFocus

End Sub

Private Sub optVenta_Click()

    Operacion = "V"
    Call TraspasaDatos

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
Select Case Button.Index
   Case 1
      Call btnCalcular_Click
   Case 2
      Call btnGrabar_Click
   Case 3
      Call btnNuevo_Click
   Case 4
      Unload Me
End Select
End Sub

Private Sub txtAmortiza_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        With grdRecibimos
        
        If .Col = 2 Then
            If txtAmortiza.Text <> .TextMatrix(.Row, 3) Then
                 .TextMatrix(.Row, 2) = txtAmortiza.Text
                 grdPagamos.TextMatrix(.Row, 2) = txtAmortiza.Text
                 If Not ValidaModificaciones(grdRecibimos) Then
                    Call CalculoInteresBonos(cmbBaseCompra, grdRecibimos)
                    Call CalculoInteresBonos(cmbBaseVenta, grdPagamos)
                End If
            End If
        End If
        txtAmortiza.Visible = False
        txtAmortiza.Text = 0
        .SetFocus
        
        End With
    End If

End Sub

Private Sub txtAmortizaPag_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        With grdPagamos
        
        If .Col = 2 Then
            If CDbl(txtAmortizaPag.Text) <> CDbl(.TextMatrix(.Row, 2)) Then
                 .TextMatrix(.Row, 2) = Format(txtAmortizaPag.Text, "###,###,###,##0.###0")
                 grdRecibimos.TextMatrix(.Row, 2) = Format(txtAmortizaPag.Text, "###,###,###,##0.###0") 'txtAmortiza.Text
                 If Not ValidaModificaciones(grdPagamos) Then
                    Call CalculoInteresBonos(cmbBaseCompra, grdRecibimos)
                    Call CalculoInteresBonos(cmbBaseVenta, grdPagamos)
                End If
            End If
        End If
        txtAmortizaPag.Visible = False
        txtAmortizaPag.Text = 0
        .SetFocus
        
        End With
    End If

End Sub

Private Sub txtCapital_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 Then txtRut.SetFocus

End Sub

Private Sub txtCapital_LostFocus()

    txtCapital.Tag = CDbl(txtCapital.Text)
    If btnGrabar.Enabled = True Then
        'btnCalcular_Click
    End If

End Sub

Private Sub txtCliente_DblClick()
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
            Call Cliente.CargaOperador(cmbOperador, Cliente.clrut, Cliente.clcodigo)
        End If
    End If

    Set Cliente = Nothing
    
End Sub
Private Sub txtFecInicio_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
    'Call ValidaFechasIngreso(1, 13)
        If ValidaFechasIngreso(1, 0) Then
            txtFecPrimerVcto.SetFocus
        End If
    End If
End Sub

Private Sub txtFecInicio_LostFocus()

    If ValidaFechasIngreso(1, 0) Then
        If btnGrabar.Enabled = True Then
            btnCalcular_Click
        End If
    End If
End Sub

Private Sub txtFecPrimerVcto_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
'Call ValidaFechasIngreso(txtFecPrimerVcto, 13)
        If ValidaFechasIngreso(2, 0) Then
            txtFecTermino.SetFocus
        End If
    End If
    
End Sub

Private Sub txtFecPrimerVcto_LostFocus()

Call ValidaFechasIngreso(2, 0)

If DateDiff("d", txtFecTermino.Text, txtFecPrimerVcto.Text) > 0 Then
    txtFecTermino.Text = txtFecPrimerVcto.Text
End If
 
End Sub

Private Sub txtFecTermino_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        If ValidaFechasIngreso(3, 0) Then
            If optCompensa.Value = True Then
                optCompensa.SetFocus
            Else
                optEntFisica.SetFocus
            End If
        End If
    End If
    
End Sub

Private Sub txtFecTermino_LostFocus()

    Call ValidaFechasIngreso(3, 0)

End Sub

Function FechaEnRango() As Boolean
    Dim DiasAmortCap As Integer
    Dim DiasAmortInt As Integer
    Dim FechaAmortiza  As Date
    Dim UltimoVcto As Date
    Dim dias As Integer
    Dim eldia As Integer
    Dim nPlazoMax As Integer
    Dim dFechaVencimiento As Date
    
    
    
    FechaEnRango = True
    If cmbAmortizaCapital.ListIndex = -1 Or cmbAmortizaInteres.ListIndex = -1 Then Exit Function
        
    DiasAmortCap = cmbAmortizaCapital.ItemData(cmbAmortizaCapital.ListIndex)    'Total de dias real para Amortizacion Capital
    DiasAmortInt = cmbAmortizaInteres.ItemData(cmbAmortizaInteres.ListIndex)      'Total de dias real para Amortizacion del Interes
    
    '***
    FechaEnRango = False
    FechaAmortiza = CDate(txtFecPrimerVcto.Text)
    eldia = Day(CDate(txtFecPrimerVcto.Text))
    
    If DiasAmortCap <= 0 Then
        'Para los casos que el período es BULLET ó BONO
        dias = DiasAmortInt
    Else
        dias = DiasAmortCap
    End If
    
    nPlazoMax = IIf(DiasAmortCap > DiasAmortInt, DiasAmortCap, DiasAmortInt)
    
    dFechaVencimiento = CreaFechaProx(txtFecInicio.Text, dias, Day(txtFecInicio.Text)) 'DateAdd("m", DiasAmortCap, txtFecInicio.Text)
    If dFechaVencimiento = txtFecPrimerVcto.Text Then
        dFechaVencimiento = CreaFechaProx(txtFecInicio.Text, nPlazoMax, Day(txtFecInicio.Text))
    Else
        dFechaVencimiento = txtFecPrimerVcto.Text
    End If
    
    'Amortizacion de monto en fecha final
    Do While dFechaVencimiento <= CDate(txtFecTermino.Text)
        FechaAmortiza = dFechaVencimiento
        dFechaVencimiento = CreaFechaProx(dFechaVencimiento, nPlazoMax, eldia)
    Loop
    If CDate(FechaAmortiza) <> CDate(txtFecTermino.Text) Then
       ' dias = DateDiff("d", CDate(FechaAmortiza), CDate(txtFecTermino.Text))
    
        If Abs(DateDiff("d", CDate(FechaAmortiza), CDate(txtFecTermino.Text))) > 10 Then
            Me.MousePointer = 0

            Exit Function
        End If
    End If
    

    FechaEnRango = True

    Me.MousePointer = 0
    btnCalcular.Enabled = True

End Function

Private Sub txtRut_DblClick()
    
    txtCliente_DblClick
    
End Sub

Private Sub txtRut_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        If txtRut <> "" Then
            If IsNumeric(txtRut) Then
                Call BuscaCliente(txtRut)
            Else
                txtCliente.SetFocus
            End If
        Else
            txtCliente.SetFocus
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
                    
                    Call RecalcularInteres(cmbBaseCompra, .Row, grdRecibimos)
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

    If KeyAscii = 13 Then cmbBaseCompra.SetFocus

End Sub

Private Sub txtTasaCompra_LostFocus()

    If txtTasaCompra.Text <> "" Then
        If Not IsNumeric(txtTasaCompra.Text) Then
            MsgBox "Monto de Tasa de Compra está incorrecto", vbInformation, Msj
            txtTasaCompra.SetFocus
        End If
        txtTasaCompra.Tag = CDbl(txtTasaCompra.Text)
    Else
        txtTasaCompra.Tag = CDbl(0)
    End If

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

    If KeyAscii = 13 Then cmbBaseVenta.SetFocus

End Sub

Private Sub txtTasaVenta_LostFocus()

    If txtTasaVenta.Text <> "" Then
        If Not IsNumeric(txtTasaVenta.Text) Then
            MsgBox "Monto en Tasa de Venta está incorrecto", vbInformation, Msj
            txtTasaVenta.SetFocus
        End If
        txtTasaVenta.Tag = CDbl(txtTasaVenta.Text)
    Else
        txtTasaVenta.Tag = CDbl(0)
    End If

End Sub

Private Sub txtCliente_KeyPress(KeyAscii As Integer)
Dim Cliente As New clsCliente
    
    If KeyAscii = 13 Then
        
        If (Len(Trim(txtCliente)) <= 5 And Len(Trim(txtCliente)) > 0) And txtRut = "" Then
    
            
            If Not Cliente.LeerxNombre(Trim(txtCliente)) Then
                MsgBox "No Existe Cliente con Nombre similar!", vbExclamation, Msj
                Exit Sub
            End If
            
            txtRut = Format(Cliente.clrut, "###,###,###") & "-" & Cliente.cldv
            txtCliente = Cliente.clnombre
            txtCliente.Tag = Cliente.clcodigo
            
            Call Cliente.CargaOperador(cmbOperador, Cliente.clrut, Cliente.clcodigo)
                    
        Else
            cmbOperador.SetFocus
        End If
    
    End If

    Set Cliente = Nothing
        
End Sub

