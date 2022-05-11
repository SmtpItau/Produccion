VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacRP 
   BorderStyle     =   1  'Fixed Single
   Caption         =   " REPOS"
   ClientHeight    =   6705
   ClientLeft      =   540
   ClientTop       =   4260
   ClientWidth     =   10020
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmdrp.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   NegotiateMenus  =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6705
   ScaleWidth      =   10020
   Visible         =   0   'False
   Begin MSFlexGridLib.MSFlexGrid Table_CargaSOMA 
      Height          =   495
      Left            =   6600
      TabIndex        =   45
      Top             =   6240
      Visible         =   0   'False
      Width           =   2655
      _ExtentX        =   4683
      _ExtentY        =   873
      _Version        =   393216
      Cols            =   9
      FixedCols       =   0
   End
   Begin MSComctlLib.ProgressBar Progress_SOMA 
      Height          =   255
      Left            =   120
      TabIndex        =   44
      Top             =   6480
      Visible         =   0   'False
      Width           =   3855
      _ExtentX        =   6800
      _ExtentY        =   450
      _Version        =   393216
      Appearance      =   1
   End
   Begin VB.Frame Cuadrodvp 
      Caption         =   "DVP"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   570
      Left            =   4995
      TabIndex        =   40
      Top             =   2040
      Width           =   1740
      Begin VB.OptionButton OptDvp 
         Caption         =   "&No"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   180
         TabIndex        =   42
         TabStop         =   0   'False
         Top             =   255
         Width           =   705
      End
      Begin VB.OptionButton OptDvp 
         Caption         =   "&Si"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   915
         TabIndex        =   41
         TabStop         =   0   'False
         Top             =   255
         Width           =   735
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   555
      Left            =   0
      TabIndex        =   38
      Top             =   0
      Width           =   10020
      _ExtentX        =   17674
      _ExtentY        =   979
      ButtonWidth     =   847
      ButtonHeight    =   820
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   11
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbgrabar"
            Description     =   "GRABAR"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbvende"
            Description     =   "VENDE"
            Object.ToolTipText     =   "Vende"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbrestaura"
            Description     =   "RESTAURA"
            Object.ToolTipText     =   "Restaura"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdfiltra"
            Description     =   "filtra"
            Object.ToolTipText     =   "Filtrar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdTipoFiltro"
            Description     =   "Ver Sel."
            Object.ToolTipText     =   "Ver Selección"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdemision"
            Description     =   "emisor"
            Object.ToolTipText     =   "Emisor del Papel"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdcortes"
            Description     =   "cortes"
            Object.ToolTipText     =   "Cortes"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdcaptura"
            Description     =   "CARGA_SOMA_EXCEL"
            Object.ToolTipText     =   "Captura de Operaciones desde Sistema SOMA"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdInfCargaSOMA"
            Description     =   "InfCargaSOMA"
            Object.ToolTipText     =   "Informe de CARGASOMA"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdsalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   10
         EndProperty
      EndProperty
      BorderStyle     =   1
      Enabled         =   0   'False
   End
   Begin VB.TextBox Text2 
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   0  'None
      ForeColor       =   &H00800000&
      Height          =   195
      Left            =   420
      TabIndex        =   37
      Top             =   2865
      Visible         =   0   'False
      Width           =   690
   End
   Begin VB.ComboBox Combo1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H00800000&
      Height          =   315
      ItemData        =   "Bacmdrp.frx":030A
      Left            =   3285
      List            =   "Bacmdrp.frx":0317
      Style           =   2  'Dropdown List
      TabIndex        =   36
      Top             =   3270
      Visible         =   0   'False
      Width           =   1455
   End
   Begin BACControles.TXTNumero text1 
      Height          =   195
      Left            =   1215
      TabIndex        =   35
      Top             =   2865
      Visible         =   0   'False
      Width           =   765
      _ExtentX        =   1349
      _ExtentY        =   344
      BackColor       =   12632256
      ForeColor       =   192
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
      Text            =   "0"
      Text            =   "0"
      Min             =   "-99"
      Max             =   "999999999999.9999"
      Separator       =   -1  'True
   End
   Begin MSFlexGridLib.MSFlexGrid Table1 
      Height          =   3090
      Left            =   45
      TabIndex        =   34
      TabStop         =   0   'False
      Top             =   2625
      Width           =   9930
      _ExtentX        =   17515
      _ExtentY        =   5450
      _Version        =   393216
      Cols            =   18
      FixedCols       =   2
      BackColor       =   12632256
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
   End
   Begin BACControles.TXTNumero TxtTotal 
      Height          =   330
      Left            =   1680
      TabIndex        =   29
      Top             =   2205
      Width           =   1920
      _ExtentX        =   3387
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
      Min             =   "-99999999999999"
      Max             =   "999999999999999"
      Separator       =   -1  'True
   End
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   "C:\BTRADER\Mdb\BACTRD.mdb"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   300
      Left            =   3360
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   "MDDI"
      Top             =   6720
      Visible         =   0   'False
      Width           =   2910
   End
   Begin Threed.SSFrame Frame 
      Height          =   1515
      Index           =   0
      Left            =   75
      TabIndex        =   5
      Top             =   525
      Width           =   2835
      _Version        =   65536
      _ExtentX        =   5001
      _ExtentY        =   2672
      _StockProps     =   14
      Caption         =   "Inicio"
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
      Begin BACControles.TXTNumero txtIniPMS 
         Height          =   285
         Left            =   720
         TabIndex        =   27
         TabStop         =   0   'False
         Top             =   1065
         Width           =   1935
         _ExtentX        =   3413
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
         Max             =   "999999999999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txtIniPMP 
         Height          =   285
         Left            =   720
         TabIndex        =   26
         TabStop         =   0   'False
         Top             =   705
         Width           =   1935
         _ExtentX        =   3413
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
         Separator       =   -1  'True
      End
      Begin BACControles.TXTFecha TxtFecIni 
         Height          =   315
         Left            =   1440
         TabIndex        =   25
         TabStop         =   0   'False
         Top             =   360
         Width           =   1230
         _ExtentX        =   2170
         _ExtentY        =   556
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
         Text            =   "16/11/2000"
      End
      Begin Threed.SSPanel PnlDiaIni 
         Height          =   315
         Left            =   120
         TabIndex        =   15
         Top             =   300
         Width           =   1095
         _Version        =   65536
         _ExtentX        =   1931
         _ExtentY        =   556
         _StockProps     =   15
         Caption         =   "Miércoles"
         ForeColor       =   16711680
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   0
         Font3D          =   3
         Alignment       =   5
      End
      Begin VB.Label Label 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "UF"
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
         Index           =   1
         Left            =   90
         TabIndex        =   7
         Top             =   750
         Width           =   435
      End
      Begin VB.Label Label 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "$$"
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
         Index           =   2
         Left            =   120
         TabIndex        =   6
         Top             =   1095
         Width           =   375
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1515
      Index           =   1
      Left            =   3000
      TabIndex        =   8
      Top             =   525
      Width           =   3735
      _Version        =   65536
      _ExtentX        =   6588
      _ExtentY        =   2672
      _StockProps     =   14
      Caption         =   "Pacto"
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
      Alignment       =   2
      Font3D          =   3
      Begin BACControles.TXTNumero TxtTipoCambio 
         Height          =   315
         Left            =   2550
         TabIndex        =   2
         Top             =   420
         Visible         =   0   'False
         Width           =   1065
         _ExtentX        =   1879
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
      End
      Begin BACControles.TXTNumero txtplazo 
         Height          =   285
         Left            =   2745
         TabIndex        =   3
         Top             =   960
         Width           =   855
         _ExtentX        =   1508
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
         Text            =   "0"
         Text            =   "0"
         Max             =   "99999"
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero TxtTasa 
         Height          =   300
         Left            =   900
         TabIndex        =   1
         Top             =   960
         Width           =   975
         _ExtentX        =   1720
         _ExtentY        =   529
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
         MarcaTexto      =   -1  'True
      End
      Begin VB.ComboBox CmbBase 
         BackColor       =   &H00FFFFFF&
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
         ItemData        =   "Bacmdrp.frx":0331
         Left            =   840
         List            =   "Bacmdrp.frx":033E
         Style           =   2  'Dropdown List
         TabIndex        =   23
         Top             =   1800
         Width           =   795
      End
      Begin VB.ComboBox CmbMon 
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
         Left            =   915
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   435
         Visible         =   0   'False
         Width           =   1155
      End
      Begin VB.Label Label1 
         Caption         =   "T/C"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000002&
         Height          =   285
         Left            =   2130
         TabIndex        =   39
         Top             =   480
         Visible         =   0   'False
         Width           =   345
      End
      Begin VB.Label Label 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
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
         Index           =   3
         Left            =   330
         TabIndex        =   12
         Top             =   960
         Width           =   435
      End
      Begin VB.Label Label 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Base"
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
         Index           =   4
         Left            =   150
         TabIndex        =   11
         Top             =   1935
         Width           =   435
      End
      Begin VB.Label Label 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Plazo"
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
         Left            =   2205
         TabIndex        =   10
         Top             =   990
         Width           =   480
      End
      Begin VB.Label Label 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
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
         Left            =   120
         TabIndex        =   9
         Top             =   480
         Visible         =   0   'False
         Width           =   690
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1515
      Index           =   2
      Left            =   6840
      TabIndex        =   13
      Top             =   525
      Width           =   3015
      _Version        =   65536
      _ExtentX        =   5318
      _ExtentY        =   2672
      _StockProps     =   14
      Caption         =   "Vencimiento"
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
      Alignment       =   1
      Font3D          =   3
      Begin BACControles.TXTNumero txtVenPMP 
         Height          =   285
         Left            =   825
         TabIndex        =   28
         Top             =   705
         Width           =   2055
         _ExtentX        =   3625
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
         Max             =   "999999999999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTFecha TxtFecVct 
         Height          =   315
         Left            =   1560
         TabIndex        =   4
         Top             =   360
         Width           =   1335
         _ExtentX        =   2355
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
         Text            =   "16/11/2000"
      End
      Begin Threed.SSPanel PnlDiaFin 
         Height          =   315
         Left            =   90
         TabIndex        =   16
         Top             =   300
         Width           =   1140
         _Version        =   65536
         _ExtentX        =   2011
         _ExtentY        =   556
         _StockProps     =   15
         Caption         =   "Miércoles"
         ForeColor       =   16711680
         BackColor       =   -2147483644
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   0
         Font3D          =   3
         Alignment       =   5
      End
      Begin VB.Label Label 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "UF "
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
         Left            =   180
         TabIndex        =   14
         Top             =   750
         Width           =   345
      End
   End
   Begin Threed.SSCommand CmdTipoFiltro 
      Height          =   450
      Left            =   4050
      TabIndex        =   24
      TabStop         =   0   'False
      Top             =   2745
      Visible         =   0   'False
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
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
      Enabled         =   0   'False
      Font3D          =   3
      RoundedCorners  =   0   'False
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3765
      Top             =   45
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   10
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdrp.frx":0350
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdrp.frx":07A2
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdrp.frx":0ABC
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdrp.frx":0F0E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdrp.frx":389C8
            Key             =   "S"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdrp.frx":38E1A
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdrp.frx":39134
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdrp.frx":3944E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdrp.frx":39768
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdrp.frx":39A82
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame FrmMontos 
      Height          =   600
      Left            =   15
      TabIndex        =   17
      Top             =   5640
      Width           =   9990
      Begin BACControles.TXTNumero TXTSALDO 
         Height          =   315
         Left            =   8565
         TabIndex        =   33
         TabStop         =   0   'False
         Top             =   195
         Width           =   1305
         _ExtentX        =   2302
         _ExtentY        =   556
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
         Min             =   "-9999999999999999"
         Max             =   "99999999999999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero TxtSel 
         Height          =   315
         Left            =   5835
         TabIndex        =   32
         TabStop         =   0   'False
         Top             =   195
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   556
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
         Min             =   "-9999999999999999"
         Max             =   "99999999999999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero TxtInv 
         Height          =   315
         Left            =   3315
         TabIndex        =   31
         TabStop         =   0   'False
         Top             =   195
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   556
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
         Min             =   "-9999999999999999"
         Max             =   "99999999999999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero TxtCartera 
         Height          =   315
         Left            =   885
         TabIndex        =   30
         TabStop         =   0   'False
         Top             =   195
         Width           =   1365
         _ExtentX        =   2408
         _ExtentY        =   556
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
         Max             =   "99999999999999"
         Separator       =   -1  'True
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   " Saldo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   7770
         TabIndex        =   21
         Top             =   195
         Width           =   795
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Selec."
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   5040
         TabIndex        =   20
         Top             =   195
         Width           =   795
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Inversión"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   2460
         TabIndex        =   19
         Top             =   195
         Width           =   855
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   " Cartera"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   90
         TabIndex        =   18
         Top             =   195
         Width           =   795
      End
   End
   Begin VB.Label Label_SOMA 
      Caption         =   "Cargando SOMA....."
      Height          =   255
      Left            =   120
      TabIndex        =   43
      Top             =   6240
      Visible         =   0   'False
      Width           =   2175
   End
   Begin VB.Label Label 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Total Operación "
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
      Left            =   120
      TabIndex        =   22
      Top             =   2265
      Width           =   1440
   End
End
Attribute VB_Name = "BacRP"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim sInstrumento(1 To 25)     As String
Dim x                         As Integer
Dim des                       As String
Dim dnom                      As Double
Dim dNominal(1 To 25)         As Double
Dim dTir(1 To 25)             As Double
Dim sCustodia(1 To 25)        As String
Dim fCupon(1 To 25)           As Date
Dim iTotCartera               As Integer
Dim iCorrelOpera              As Integer

Dim celda1                    As String
Dim celda2                    As String
Dim celda3                    As String
Dim celda4                    As Variant
Dim celda5                    As String
Dim celda6                    As String
Dim celda7                    As String
Dim celda8                    As String
Dim celda9                    As String
Dim celda10                   As String
Dim celda11                   As String
Dim celda12                   As String
Dim celda13                   As String
Dim celda14                   As String
Dim icol                      As Integer
Dim irow                      As Integer
Dim I                         As Integer
Dim var_cantoper              As Integer
Dim OperExcel()               As Variant
Dim u                         As Integer
Dim Monto                     As Double
Dim Tecla                     As String
Dim FormHandle                As Long
Dim iFlagKeyDown              As Integer
Dim bufNominal                As Double
Dim bufRutCart                As Long
Dim sFecPro                   As String
Dim sFiltro                   As String
Dim nRutCartV                 As String
Dim cDvCartV                  As String
Dim cNomCartV                 As String
Dim dTipcam#
Dim dMonMx                    As String
Dim Color                     As String
Dim colorletra                As String
Dim z                         As Integer
Dim filita                    As Integer
Dim bold                      As String
Dim columnita                 As Integer
Dim k                         As Integer
Dim Param_sp                  As String
Public nDolarOb               As Double
Public nUf                    As Double
Public FiltraVentaAutomatico  As Boolean
Public glBacCpDvpVi           As DvpCp
Public cCodCartFin            As String
Public cCodLibro              As String


Const Ven_RP_MARCA = 0
Const Ven_RP_SERIE = 1
Const Ven_RP_UM = 2
Const Ven_RP_NOMINAL = 3
Const Ven_RP_TIR = 4
Const Ven_RP_VPAR = 5
Const Ven_RP_VPS = 6
Const Ven_RP_PlzRes = 7
Const Ven_RP_Margen = 8
Const Ven_RP_ValIni = 9
Const Ven_RP_CUST = 10 '7
Const Ven_RP_CDCV = 11 '8
Const Ven_RP_TIRM = 12 '9
Const Ven_RP_VPARM = 13 '10
Const Ven_RP_VCOMP = 14 '11
Const Ven_RP_UTIL = 15 '12
Const Ven_RP_CatCartSuper = 16 '13
Const Ven_RP_CodLib = 17 '14
Const Pos_RutCartera = 0
Const Pos_CartFin = 1
Const Pos_CadenaFamilia = 2
Const Pos_CadenaEmisor = 3
Const Pos_CadenaMoneda = 4
Const Pos_CadenaSerie = 5
Const Pos_CartSuper = 6
Const Pos_Usuario = 7
Const Pos_Libro = 8
Const Col_SOMA_Corr = 0
Const Col_SOMA_Serie = 1
Const Col_SOMA_Nominal = 2
Const Col_SOMA_Tir = 3
Const Col_SOMA_PlzRes = 4
Const Col_SOMA_ValInicial = 5
Const Col_SOMA_NumOpe = 6
Const Col_SOMA_Mensaje = 7
Const Col_SOMA_TipoCorte = 8

Private Sub OptDvp_Click(Index As Integer)
   Select Case Index
      Case 0:  glBacCpDvpVi = No
      Case 1:  glBacCpDvpVi = Si
   End Select
   Toolbar1.Enabled = True
   Cuadrodvp.Enabled = False
End Sub

Private Sub Text2_GotFocus()
   Call PROC_POSI_TEXTO(Table1, Text2)
   Text2.SelLength = Len(Text2)
   Text2.SelStart = Len(Text2)
End Sub

Private Sub Text2_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = 27 Then
      Text2_LostFocus
   End If

   If KeyCode = 13 Then
      If Not Table1.Rows = 1 Then
         Call Colocardata1
      Else
         Data1.Recordset.MoveFirst
      End If
      Data1.Recordset.Edit
      Data1.Recordset!tm_clave_dcv = Text2.Text
      Data1.Recordset.Update
      Table1.TextMatrix(Table1.Row, Ven_RP_Margen) = Trim(Text2.Text)
      BacControlWindows 100
      Table1.SetFocus
   End If
End Sub

Private Sub Text2_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub Text2_LostFocus()
   Text2.Text = ""
   Text2.Visible = False
   Table1.SetFocus
End Sub

Private Sub Combo1_GotFocus()
   Call PROC_POSI_TEXTO(Table1, Combo1)
End Sub

Private Sub Combo1_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = 27 Then
      Combo1_LostFocus
   End If

   If KeyCode = vbKeyReturn Then
      If Not Table1.Rows = 1 Then
         Call Colocardata1
      Else
         Data1.Recordset.MoveFirst
      End If
    
      If Table1.Col = 7 Then
         Data1.Recordset.Edit
         Select Case Combo1.ListIndex 'UCase$(Left(Combo1.Text, 1)) 'Chr(KeyCode))
            Case 0
               Data1.Recordset("tm_custodia") = "CLIENTE"
               Data1.Recordset("tm_clave_dcv") = " "
               Table1.TextMatrix(Table1.Row, Ven_RP_CUST) = "CLIENTE"
               Table1.TextMatrix(Table1.Row, Ven_RP_CDCV) = ""
               KeyCode = vbKeyReturn
            Case "1"
               Data1.Recordset("tm_custodia") = "DCV"
               Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
               Table1.TextMatrix(Table1.Row, Ven_RP_CUST) = "DCV"
               Table1.TextMatrix(Table1.Row, Ven_RP_CDCV) = Data1.Recordset("tm_clave_dcv")
               KeyCode = vbKeyReturn
            Case "2"
               Data1.Recordset("tm_custodia") = "PROPIA"
               Data1.Recordset("tm_clave_dcv") = " "
               Table1.TextMatrix(Table1.Row, Ven_RP_CUST) = "PROPIA"
               Table1.TextMatrix(Table1.Row, Ven_RP_CDCV) = ""
               KeyCode = vbKeyReturn
            Case Else
               KeyCode = 0
         End Select
         Data1.Recordset.Update
         Combo1.Visible = False
      End If
   End If

End Sub

Private Sub Combo1_LostFocus()
   Combo1.Visible = False
   If Table1.Col + 1 < Table1.Cols Then
      Table1.Col = Table1.Col + 1
   End If
   BacControlWindows 100
   Table1.SetFocus
End Sub

Private Sub refresca()
   Dim I As Integer
    
   Call Llenar_Grilla
   Table1.Refresh
End Sub

Private Function colores()
   Dim Fila    As Long
   Dim z       As Long
   
   For Fila = 1 To Table1.Rows - 1
      If Table1.TextMatrix(Fila, Ven_RP_MARCA) = "*" Then
         Color = &HC0C0C0
         colorletra = &HC0&
         bold = False
      End If
      If Table1.TextMatrix(Fila, Ven_RP_MARCA) = "V" Then
         Color = &HFF0000
         colorletra = &HFFFFFF
         bold = True
      End If
      If Table1.TextMatrix(Fila, Ven_RP_MARCA) = "P" Then
         Color = vbCyan
         colorletra = vbBlack
      End If
      If Table1.TextMatrix(Fila, Ven_RP_MARCA) = "B" Then
         Color = vbBlack + vbWhite    'vbBlack
         colorletra = vbBlack
         bold = False
      End If
      If Table1.TextMatrix(Fila, Ven_RP_MARCA) = " " Then
         Color = &HC0C0C0
         colorletra = &H800000
         bold = False
      End If
    
      Table1.Row = Fila
      For z = 2 To Table1.Cols - 1
         Table1.Col = z
         Table1.CellBackColor = Color
         Table1.CellForeColor = colorletra
         Table1.CellFontBold = bold
      Next z
   Next Fila
   Table1.Col = 2

End Function

Private Sub Llenar_Grilla()
   Dim x As Integer
   Dim oDatos()
   
   If Data1.Recordset.RecordCount > 0 Then
      Data1.Recordset.MoveFirst
   End If
   
   Table1.Redraw = False
   Table1.Rows = 1

   Do While Not Data1.Recordset.EOF
      x = Table1.Rows
      Table1.Rows = Table1.Rows + 1
         
      Table1.TextMatrix(x, Ven_RP_MARCA) = Data1.Recordset!tm_venta
      Table1.TextMatrix(x, Ven_RP_SERIE) = Data1.Recordset!TM_INSTSER
      If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
         Table1.ColWidth(Ven_RP_TIR) = 1800
      End If
      Table1.TextMatrix(x, Ven_RP_UM) = Data1.Recordset!TM_NEMMON
      Table1.TextMatrix(x, Ven_RP_NOMINAL) = Format(Data1.Recordset!tm_nominal, "#,##0.0000")
      Table1.TextMatrix(x, Ven_RP_TIR) = Format(Data1.Recordset!TM_TIR, "#,##0.0000")
      Table1.TextMatrix(x, Ven_RP_VPAR) = Format(Data1.Recordset!TM_Pvp, "#,##0.0000")
      Table1.TextMatrix(x, Ven_RP_VPS) = Format(Data1.Recordset!TM_VP, "#,##0.0000")
      Table1.TextMatrix(x, Ven_RP_CUST) = IIf(IsNull(Data1.Recordset!tm_custodia) = True, " ", Data1.Recordset!tm_custodia)
      Table1.TextMatrix(x, Ven_RP_CDCV) = IIf(IsNull(Data1.Recordset!tm_clave_dcv) = True, " ", Data1.Recordset!tm_clave_dcv)
      Table1.TextMatrix(x, Ven_RP_TIRM) = Format(Data1.Recordset!TM_tircomp, "#,##0.0000")
      Table1.TextMatrix(x, Ven_RP_VPARM) = Format(Data1.Recordset!TM_pvpcomp, "#,##0.0000")
      Table1.TextMatrix(x, Ven_RP_VCOMP) = Format(Data1.Recordset!tm_vptirc, "#,##0.0000")
      Table1.TextMatrix(x, Ven_RP_UTIL) = Format(CDbl(Data1.Recordset!TM_VP) - CDbl(Data1.Recordset!tm_vptirc), "#,###,###,##0")
      Table1.TextMatrix(x, Ven_RP_PlzRes) = Format(Data1.Recordset!tm_diasdisp, "##,##0")
    '  Table1.TextMatrix(x, Ven_RP_Margen) = Format(Data1.Recordset!TM_MARGEN, "#,##0.0000")
    '  Table1.TextMatrix(x, Ven_RP_ValIni) = Format(Data1.Recordset!TM_VALINICIAL, "#,##0.0000")
      
      Envia = Array()
      AddParam Envia, 1
      AddParam Envia, GLB_CARTERA_NORMATIVA
      AddParam Envia, GLB_ID_SISTEMA
      AddParam Envia, Trim(Data1.Recordset!tm_carterasuper)
      If Bac_Sql_Execute("SP_CON_INFO_COMBO", Envia) Then
         Do While Bac_SQL_Fetch(oDatos())
            Table1.TextMatrix(x, Ven_RP_CatCartSuper) = Trim(oDatos(6))
         Loop
      Else
         Table1.TextMatrix(x, Ven_RP_CatCartSuper) = "NO ESPECIFICADO"
      End If
      Table1.TextMatrix(x, Ven_RP_CodLib) = IIf(IsNull(Data1.Recordset!tm_id_libro) = True, "", Trim(Data1.Recordset!tm_id_libro))
      
      Data1.Recordset.MoveNext
   Loop
   
   Call colores
   Table1.Col = 2
   Table1.Redraw = True

End Sub

Public Function Colocardata1()
   Dim I  As Integer
   
   Monto = CDbl(Table1.TextMatrix(Table1.Row, Ven_RP_NOMINAL))
   Data1.Recordset.MoveFirst
   For I = 1 To Table1.Row - 1
      Data1.Recordset.MoveNext
   Next I
End Function

Private Sub cmbBase_LostFocus()
   Call CalcularValorFinal
End Sub

Private Sub CmbMon_Change()
   Dim MonPac As Integer
   Dim nRedon   As Integer
    
   If CmbMon.ListIndex = -1 Then
      Exit Sub
   End If
   CmbBase.ListIndex = CmbMon.ListIndex
   MonPac = CmbMon.ItemData(CmbMon.ListIndex)
    
   If CmbMon.ItemData(CmbMon.ListIndex) = 999 Then
      txtIniPMP.CantidadDecimales = 0
      nRedon = 0
   Else
      txtIniPMP.CantidadDecimales = BacDatGrMon.mndecimal
      nRedon = BacDatGrMon.mndecimal
   End If

   If CDbl(CmbMon.Tag) <> MonPac Then
      If dTipcam = 0 Then
         txtIniPMP.Text = 0
      Else
         txtIniPMP.Text = Round(TxtTotal.Text / dTipcam#, nRedon)
      End If
   End If
   BacControlWindows 12
End Sub

Private Sub CmbMon_Click()
   Dim NemMon      As String
   Dim I           As Integer
   Dim nRedon      As Integer
   Dim nResp       As Integer
   
   dTipcam# = 0
   k = 0
    
   If CmbMon.ListIndex <> -1 Then
      NemMon = Trim$(CmbMon.List(CmbMon.ListIndex))
      Label(1).Caption = NemMon
      Label(8).Caption = NemMon

      Call funcFindDatGralMoneda(CmbMon.ItemData(CmbMon.ListIndex))
      SwMx = BacDatGrMon.mnmx

      If CmbMon.Text = UCase("clp") Then
         txtIniPMP.CantidadDecimales = 0
         txtVenPMP.CantidadDecimales = 0
      Else
         txtIniPMP.CantidadDecimales = BacDatGrMon.mndecimal
         txtVenPMP.CantidadDecimales = BacDatGrMon.mndecimal
      End If

      If giMonLoc <> CmbMon.ItemData(CmbMon.ListIndex) Then
         sFecPro = Str(gsBac_Fecp)
         dTipcam# = funcBuscaTipcambio(CmbMon.ItemData(CmbMon.ListIndex), sFecPro)
         If dTipcam# = 0 And CmbMon.ItemData(CmbMon.ListIndex) <> 13 Then
            
            nResp = MsgBox("Tipo de cambio para : " & NemMon & " con fecha " & gsBac_Fecp & Chr(10) & Chr(13) & " NO ha sido ingresado." & Chr(10) & Chr(13) & " Desea Ingresarlo ? ", vbExclamation + vbYesNo, TITSISTEMA)
            
            If nResp = vbYes Then
               TxtTipoCambio.Enabled = IIf(SwMx = "C", True, False)
               TxtTipoCambio.Text = dTipcam#
               TxtTipoCambio.SetFocus
            Else
               For I% = 0 To CmbMon.ListCount - 1
                  If Mid(CmbMon.List(I%), 1, 3) = "CLP" Then 'waldo
                     CmbMon.ListIndex = I%
                     Exit For
                  End If
               Next I%
            End If
         ElseIf dTipcam# = 0 And CmbMon.ItemData(CmbMon.ListIndex) = 13 Then
            dTipcam# = funcBuscaTipcambio(994, sFecPro)
         End If
      Else
         dTipcam# = IIf(CmbMon.ItemData(CmbMon.ListIndex) = 13, nDolarOb, 1)
      End If

      TxtTipoCambio.Text = dTipcam#
      TxtTipoCambio.Enabled = IIf(SwMx = "C", True, False)
      If CmbMon.ItemData(CmbMon.ListIndex) = 999 Then
         nRedon = 0
      Else
         nRedon = BacDatGrMon.mndecimal
      End If

      If dTipcam# = 0 Then
         txtIniPMP.Text = 0
      Else
         txtIniPMP.Text = Round(CDbl(TxtTotal.Text / dTipcam#), nRedon)
      End If
      Call CalcularValorFinal
   End If

End Sub

Private Sub cmbMon_GotFocus()
   If CmbMon.ListIndex <> -1 Then
      CmbMon.Tag = CmbMon.ItemData(CmbMon.ListIndex)
   Else
      CmbMon.Tag = "0"
   End If
End Sub

Sub Corta()
   Dim Nominal#
   Dim Fila       As Long

   If Table1.Row = 0 Then
      Exit Sub
   End If
   
   Fila = Table1.RowSel

   If Data1.Recordset.RecordCount = 0 Then
      Exit Sub
   End If

   Table1.Row = Fila

   If Not Table1.Row = 1 Then
      Call Colocardata1
   Else
      Data1.Recordset.MoveFirst
   End If

   Nominal# = CDbl(Table1.TextMatrix(Table1.Row, Ven_RP_NOMINAL))
   bufNominal = Val(Data1.Recordset("tm_nominalo"))

   If Nominal = 0 Then
      Exit Sub
   End If

   If VENTA_VerDispon(FormHandle, Data1) = False Then
      Exit Sub
   End If
   
   Set BacFrmIRF = Me
   
   Call BacControlWindows(10)
   BacIrfCo.Show 1
   Call BacControlWindows(10)
   
   If Not Table1.Row = 1 Then
      Call Colocardata1
   Else
      Data1.Recordset.MoveFirst
   End If

   If Table1.TextMatrix(Table1.Row, 0) <> "N" Then
      Data1.Recordset.Edit 'puse
      Data1.Recordset!tm_nominal = Table1.TextMatrix(Table1.Row, Ven_RP_NOMINAL) 'puse
      Text1.CantidadDecimales = 4 'wms puse
      Text1.Text = CDbl(Table1.TextMatrix(Table1.Row, Ven_RP_NOMINAL)) 'puse
      Data1.Recordset.Update 'puse
         
      If Nominal# <> CDbl(Table1.TextMatrix(Table1.Row, Ven_RP_NOMINAL)) Or Table1.TextMatrix(Table1.Row, Ven_RP_MARCA) = "V" Then
         If Data1.Recordset!tm_venta <> "*" And Data1.Recordset!tm_venta <> " " Then
            Call VENTA_DesBloquear(FormHandle, Data1)
         End If
            
         If VENTA_Bloquear(FormHandle, Data1) Then
            Data1.Recordset.Edit
            If CDbl(Table1.TextMatrix(Table1.Row, Ven_RP_NOMINAL)) < Nominal# Then
               Data1.Recordset!tm_venta = "P"
            Else
               Data1.Recordset!tm_venta = "V"
            End If
            Data1.Recordset.Update
         End If
      Else
         Data1.Recordset.Edit
         Data1.Recordset.Update
      End If

      Call Llenar_Grilla 'wms puse
      Table1.Row = Fila 'wms puse
      Table1.Col = 3 ' wms puse
      Call Text1_KeyDown(13, 0) 'wms puse
   Else
      
      Table1.TextMatrix(Table1.Row, Ven_RP_MARCA) = " " 'wms puse
   End If

   Table1.Col = 3

End Sub

Sub Emite()
   
   If Table1.Row = 0 Then
      Exit Sub
   End If
   Call BacControlWindows(10)
   
   If Data1.Recordset.RecordCount = 0 Then
      Exit Sub
   End If
    
   BacControlWindows 100
   If Not Table1.Row = 1 Then
      BacControlWindows 50
      Call Colocardata1
      BacControlWindows 50
   Else
      Data1.Recordset.MoveFirst
   End If
    
   If Trim$(Data1.Recordset("tm_instser")) = "" Then
      Exit Sub
   End If
   Call BacControlWindows(10)

   
   Call BacControlWindows(10)
   BacDatEmi.sInstSer = Data1.Recordset("tm_instser")
   BacDatEmi.lRutemi = Data1.Recordset("tm_rutemi")
   BacDatEmi.iMonemi = Data1.Recordset("tm_monemi")
   BacDatEmi.sFecEmi = Data1.Recordset("tm_fecemi")
   BacDatEmi.sFecvct = Data1.Recordset("tm_fecven")
   BacDatEmi.dTasEmi = Data1.Recordset("tm_tasemi")
   BacDatEmi.iBasemi = Data1.Recordset("tm_basemi")
     
   BacDatEmi.sFecpcup = Data1.Recordset("tm_fecpcup")
   BacDatEmi.dNumoper = Data1.Recordset("tm_numdocu")
   BacDatEmi.sTipOper = Data1.Recordset("tm_tipoper")
   BacDatEmi.sFecvtop = Data1.Recordset("tm_fecsal")
   BacDatEmi.iDiasdis = DateDiff("d", gsBac_Fecp, CDate(Data1.Recordset("tm_fecsal")))
   Call BacControlWindows(10)
    
   BacIrfDg.varPsSeriado = Data1.Recordset("tm_mdse")
   BacIrfDg.Tag = "VI"
   BacIrfDg.Show 1
   BacControlWindows 12
   Table1.SetFocus

End Sub

Sub Filtrar()
   Dim Envia1     As Variant
   Dim oContador  As Long
   Dim w_i        As Integer
   Dim Mc
   Dim Conta      As Integer
   Dim Datos()
   
   oContador = 1
   
   If Not FiltraVentaAutomatico Then
      BacIrfSl.ProTipOper = "VI"
      BacIrfSl.oFiltroDVP = glBacCpDvpVi
      BacIrfSl.Show vbModal
   End If
    
   If giAceptar% = True Then
      nRutCartV = RutCartV
      cDvCartV = DvCartV
      cNomCartV = NomCartV
        
      Envia1 = Envia
      Call VENTA_EliminarBloqueados(Data1, FormHandle)
      Call VENTA_BorrarTx(FormHandle)
        
      Envia = Envia1
      Envia(Pos_Libro) = Trim(Right(Envia(Pos_Libro), 10))
      BacRP.cCodCartFin = Trim(Right(Envia(Pos_CartFin), 10))
      BacRP.cCodLibro = Trim(Right(Envia(Pos_Libro), 10))

      AddParam Envia, glBacCpDvpVi
      Data1.Refresh
      
      Screen.MousePointer = vbKeyReturn
        
      Param_sp = "SP_FILTRARCART_RP"
      If IsMissing(Envia) Then
         Conta = -1
      Else
         Conta = UBound(Envia)
      End If

      For w_i = 0 To UBound(Envia)
         If TypeName(Envia(w_i)) = "String" Then
            If IsDate(Envia(w_i)) Then
               Param_sp = Param_sp & " '" & Format(Envia(w_i), feFECHA) & "',"
            Else
               Param_sp = Param_sp & " '" & Envia(w_i) & "',"
            End If
         ElseIf TypeName(Envia(w_i)) = "Date" Then
            Param_sp = Param_sp & " '" & Format(Envia(w_i), feFECHA) & "',"
         Else
            If gsBac_PtoDec = "," Then
               Mc = InStr(1, Envia(w_i), ",")
               If Mc > 0 Then
                  Envia(w_i) = Mid(Envia(w_i), 1, Mc - 1) & "." & Mid(Envia(w_i), Mc + 1)
               End If
            End If
            Param_sp = Param_sp & " " & Envia(w_i) & ","
         End If
      Next w_i

      If Conta > -1 Then
         Param_sp = Mid(Param_sp, 1, Len(Param_sp) - 1)
      End If

      If Bac_Sql_Execute("SP_FILTRARCART_RP", Envia) Then
         sFiltro = gSQL
         Table1.Rows = 2
         Do While Bac_SQL_Fetch(Datos())
            If Datos(12) <> "" Then
               Call VENTA_Agregar(Data1, Datos(), Hwnd, "VI", "RP")
            End If
            If glBacCpDvpVi = Si Then
               If oContador = 10 Then
                  '  Exit Do
               Else
                  oContador = oContador + 1
               End If
            End If
         Loop
            
         Data1.Refresh
         Call Llenar_Grilla
         Toolbar1.Buttons(6).Tag = "Ver Sel."
         Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= " & txtplazo.Text
         Data1.Refresh
         TxtTotal.Text = VENTA_SumarTotal(FormHandle)
         TxtCartera.Text = VENTA_SumarCartera(FormHandle, txtplazo.Text, Toolbar1)
         Table1.Enabled = True
         Table1.SetFocus
            
         If Data1.Recordset.RecordCount > 0 Then
            Toolbar1.Buttons(6).Enabled = True
            Toolbar1.Buttons(7).Enabled = True
            Toolbar1.Buttons(2).Enabled = True
            Toolbar1.Buttons(3).Enabled = True
            Toolbar1.Buttons(4).Enabled = True
            Toolbar1.Buttons(5).Enabled = True
            Toolbar1.Buttons(8).Enabled = True
            TxtTotal.Enabled = True
         End If
      Else
         Table1.Rows = 1
         MsgBox "Servidor SQL no Responde", vbExclamation, gsBac_Version
      End If

      Screen.MousePointer = vbDefault
   End If
    
   If Table1.Rows < 2 Then

   Else

   End If
   
   On Error Resume Next
   If Table1.Rows <> 1 And Table1.Rows > 0 Then
      Table1.Row = 1: Table1.SetFocus
   End If
   On Error GoTo 0

End Sub

Sub Restaura()
   On Error Resume Next

   If Table1.Row = 0 Then
      Exit Sub 'insertado05/02/2001
   End If
   If Trim(Table1.TextMatrix(Table1.Row, Ven_RP_MARCA)) = "" Then
      Table1.SetFocus
      Exit Sub
   End If

   filita = Table1.Row

   If Data1.Recordset.RecordCount = 0 Then
      Exit Sub
   End If

   Call VENTA_VerDispon(FormHandle, Data1)

   If Not Table1.Row = 1 Then
      Call Colocardata1
   Else
      Data1.Recordset.MoveFirst
   End If

   If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
      If VENTA_DesBloquear(FormHandle, Data1) Then
         Data1.Recordset.Edit
         Data1.Recordset("tm_venta") = " "
         Data1.Recordset.Update
      End If
   End If

   If Data1.Recordset("tm_venta") = "*" Then
      If VENTA_VerBloqueo(FormHandle, Data1) Then
         Data1.Recordset.Edit
         Data1.Recordset("tm_venta") = " "
         Data1.Recordset.Update
      End If
   End If

   If Data1.Recordset.RecordCount > 0 Then
      Call VENTA_Restaurar(Data1, "RP")
   End If

   Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlao"))

   TxtTotal.Text = VENTA_SumarTotal(FormHandle)

   If CDbl(txtIniPMP.Text) > 0 Then
      Call CalcularValorFinal
   Else
      txtVenPMP.Text = 0
   End If

   Data1.Recordset.MoveLast
   Table1.Rows = Data1.Recordset.RecordCount + 1
   Data1.Refresh

   Call refresca

   Data1.Refresh
   Table1.Refresh
   Table1.Col = 2

   If filita <= Table1.Rows - 1 Then
      Table1.Row = filita
   Else
      Table1.Row = Table1.Rows - 1
   End If

   Table1.SetFocus
End Sub

Sub TipoFiltro()

   If Toolbar1.Buttons(6).Tag = "Ver Todos" Then
      Toolbar1.Buttons(6).Tag = "Ver Sel."
      Toolbar1.Buttons(6).ToolTipText = "Ver Selección"
      Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= " & txtplazo.Text
      Data1.Refresh
   Else
      filita = Table1.Row
      If TxtTotal.Text > 0 Then
         Toolbar1.Buttons(6).Tag = "Ver Todos"
         Toolbar1.Buttons(6).ToolTipText = "Ver Todos"
         Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= " & txtplazo.Text & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
         Data1.Refresh
      End If
   End If
    
   TxtCartera.Text = VENTA_SumarCartera(FormHandle, txtplazo.Text, Toolbar1)
   Table1.Rows = 1
   Table1.Row = 0
    
   Do While Not Data1.Recordset.EOF
      Table1.Rows = Table1.Rows + 1
      Table1.Row = Table1.Rows - 1
      Call Llenar_Grilla
      If Not Data1.Recordset.EOF Then
         Data1.Recordset.MoveNext
      End If
   Loop

   If filita <= Table1.Rows - 1 Then
      Table1.Row = filita
   End If
End Sub

Sub Vende()

   If Table1.Row = 0 Then
      Exit Sub 'insertado 05/02/2001
   End If
   If Trim(Table1.TextMatrix(Table1.Row, Ven_RP_MARCA)) <> "" Then
      Table1.SetFocus
      Exit Sub
   End If

   filita = Table1.Row

   If Data1.Recordset.RecordCount = 0 Then
      Exit Sub
   End If

   If Not Table1.Rows = 1 Then
      Call Colocardata1
   Else
      Data1.Recordset.MoveFirst
   End If

   If VENTA_VerDispon(FormHandle, Data1) Then
      If Data1.Recordset("tm_venta") = "V" Then
         If VENTA_DesBloquear(FormHandle, Data1) Then
            Data1.Recordset.Edit
            Data1.Recordset("tm_venta") = " "
            Data1.Recordset.Update
         End If
      Else
         If Data1.Recordset("tm_venta") = " " Or Data1.Recordset("tm_venta") = "*" Then
            If VENTA_Bloquear(FormHandle, Data1) Then
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = "V"
               If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
                  Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
               Else
                  Data1.Recordset("tm_clave_dcv") = ""
               End If
               Data1.Recordset.Update
               Table1.TextMatrix(Table1.Row, Ven_RP_CDCV) = Data1.Recordset("tm_clave_dcv")
            Else
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = "*"
               Data1.Recordset.Update
            End If
         End If
      End If
   End If

   TxtTotal.Text = VENTA_SumarTotal(FormHandle)
   Table1.TextMatrix(Table1.Row, Ven_RP_MARCA) = Data1.Recordset!tm_venta
   Call colores
   
   If filita <= Table1.Rows - 1 Then
      Table1.Row = filita
   Else
      Table1.Row = Table1.Rows - 1
   End If

   Table1.Col = 2
   Table1.SetFocus
End Sub

Private Sub data1_Error(DataErr As Integer, Response As Integer)
   If DataErr = 3021 Then
      DataErr = 0
      Response = 0
   End If
End Sub

Private Sub Form_Activate()
   Me.Tag = "RP"
   Tipo_Operacion = "VI"
   BacControlWindows 30
   Data1.Refresh
   iFlagKeyDown = True

   Screen.MousePointer = vbDefault
    
   RutCartV = nRutCartV
   DvCartV = cDvCartV
   NomCartV = cNomCartV
   FiltraVentaAutomatico = False
   nDolarOb = funcBuscaTipcambio(994, sFecPro)
   nUf = funcBuscaTipcambio(998, sFecPro)

Exit Sub
BacErrHnd:
   Screen.MousePointer = vbDefault
   On Error GoTo 0
   Exit Sub
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      KeyAscii = 0
      SendKeys "{TAB}"
   End If
End Sub

Sub Nombres_Grilla()
   Table1.TextMatrix(0, Ven_RP_MARCA) = "M":                                     Table1.ColWidth(Ven_RP_MARCA) = 400
   Table1.TextMatrix(0, Ven_RP_SERIE) = "Serie":                                 Table1.ColWidth(Ven_RP_SERIE) = 1500
   Table1.TextMatrix(0, Ven_RP_UM) = "UM":                                       Table1.ColWidth(Ven_RP_UM) = 500
   Table1.TextMatrix(0, Ven_RP_NOMINAL) = "Nominal":                             Table1.ColWidth(Ven_RP_NOMINAL) = 1800
   Table1.TextMatrix(0, Ven_RP_TIR) = "Tasa Referencial":                        Table1.ColWidth(Ven_RP_TIR) = 1300 '900
   Table1.TextMatrix(0, Ven_RP_VPAR) = "%Vpar":                                  Table1.ColWidth(Ven_RP_VPAR) = 900
   Table1.TextMatrix(0, Ven_RP_VPS) = "Valor Referencial":                       Table1.ColWidth(Ven_RP_VPS) = 1800 'antes 1800
   Table1.TextMatrix(0, Ven_RP_PlzRes) = "Plazo Residual":                       Table1.ColWidth(Ven_RP_PlzRes) = 1500 'antes 1800
   Table1.TextMatrix(0, Ven_RP_Margen) = "Margen":                               Table1.ColWidth(Ven_RP_Margen) = 1500
   Table1.TextMatrix(0, Ven_RP_ValIni) = "Valor Inicial":                        Table1.ColWidth(Ven_RP_ValIni) = 1800
   Table1.TextMatrix(0, Ven_RP_CUST) = "Custodia":                               Table1.ColWidth(Ven_RP_CUST) = 1200
   Table1.TextMatrix(0, Ven_RP_CDCV) = "Clave DCV":                              Table1.ColWidth(Ven_RP_CDCV) = 1200
   Table1.TextMatrix(0, Ven_RP_TIRM) = "%Tir C.":                                Table1.ColWidth(Ven_RP_TIRM) = 900
   Table1.TextMatrix(0, Ven_RP_VPARM) = "%Vpar C.":                              Table1.ColWidth(Ven_RP_VPARM) = 900
   Table1.TextMatrix(0, Ven_RP_VCOMP) = "Valor de Compra":                       Table1.ColWidth(Ven_RP_VCOMP) = 1800
   Table1.TextMatrix(0, Ven_RP_UTIL) = "Utilidad":                               Table1.ColWidth(Ven_RP_UTIL) = 0
   Table1.TextMatrix(0, Ven_RP_CatCartSuper) = "Categoria Cartera Super":        Table1.ColWidth(Ven_RP_CatCartSuper) = 2500
   Table1.TextMatrix(0, Ven_RP_CodLib) = "Codigo Libro":                         Table1.ColWidth(Ven_RP_CodLib) = 0
End Sub

Private Sub Form_Load()
   Dim nSw%
   Dim nCont%

   Screen.MousePointer = vbKeyReturn
   Me.Icon = BacTrader.Icon
   Me.Top = 0: Me.Left = 0
   
   Tipo_Operacion = "VI"
   FormHandle = Me.Hwnd
   iFlagKeyDown = True
  
   Toolbar1.Buttons(1).Enabled = True    'Separador
   Toolbar1.Buttons(2).Enabled = False   'Grabar
   Toolbar1.Buttons(3).Enabled = False   'Vende
   Toolbar1.Buttons(4).Enabled = False   'Restaura
   Toolbar1.Buttons(5).Enabled = True    'Filtro
   Toolbar1.Buttons(6).Enabled = False   'tipoFiltro
   Toolbar1.Buttons(7).Enabled = False   'Emision
   Toolbar1.Buttons(8).Enabled = False   'Cortes
   Toolbar1.Buttons(10).Enabled = False 'Informe de Captura
   Toolbar1.Buttons(9).Enabled = False 'Capturar de Operaciones en Sistema Soma

   TxtTotal.Enabled = False
   Call funcFindMonVal(CmbMon, CmbBase, "VI")

   If CmbMon.ListCount > -1 Then
      CmbMon.ListIndex = 0
   End If

   TxtFecIni.Text = Format$(gsBac_Fecp, "dd/mm/yyyy")

   nSw = 0: nCont = 1
   Do While nSw = 0
      txtplazo.Text = nCont
      TxtFecVct.Text = Format$(DateAdd("d", txtplazo.Text, TxtFecIni.Text), "dd/mm/yyyy")
      If EsFeriado(CDate(TxtFecVct.Text), "00001") Then
         nCont = nCont + 1
      Else
         nSw = 1
      End If
   Loop

   txtplazo.Text = DateDiff("D", TxtFecIni.Text, TxtFecVct.Text)
   PnlDiaIni.Caption = BacDiaSem(TxtFecIni.Text)
   PnlDiaFin.Caption = BacDiaSem(TxtFecVct.Text)

   Call VENTA_IniciarTx(FormHandle, Data1, txtplazo.Text)

   If CmbMon.ListIndex > -1 Then
      CmbMon.ListIndex = 0
      sFecPro = Str(gsBac_Fecp)
      dTipcam# = funcBuscaTipcambio(CmbMon.ItemData(CmbMon.ListIndex), sFecPro)
   End If

   Call Nombres_Grilla
    
   Toolbar1.Buttons(6).Tag = "Ver Sel."
   Toolbar1.Buttons(6).Enabled = False
   Table1.Enabled = False
   TxtInv.Enabled = True
   Toolbar1.Buttons(10).Enabled = False
   Screen.MousePointer = vbDefault
End Sub

Private Sub Form_Resize()
'On Error GoTo BacErrHnd
'Dim lScaleWidth&, lScaleHeight&, lPosIni&
'  ' Cuando la ventana es minimizada, se ignora la rutina.-
'
'    If Me.WindowState = 1 Then
'        ' Pinta borde del icono.-
'        Dim x!, Y!, J%
'        x = Me.Width
'        Y = Me.Height
'
'        For J% = 1 To 15
'            Line (0, 0)-(x, 0), QBColor(Int(Rnd * 15))
'            Line (x, 0)-(x, Y), QBColor(Int(Rnd * 15))
'            Line (x, Y)-(0, Y), QBColor(Int(Rnd * 15))
'            Line (0, Y)-(0, 0), QBColor(Int(Rnd * 15))
'            DoEvents
'        Next
'        Exit Sub
'
'    End If
'
'    lScaleWidth& = Me.ScaleWidth
'    lScaleHeight& = Me.ScaleHeight
'    If Me.WindowState <> 1 And Me.Width > 400 And Me.Height > 3600 Then
'        Table1.Width = Me.Width - 260
'        Table1.Height = Me.Height - 3590
'        FrmMontos.Top = Me.Height - 1050
'    End If
'
'    Exit Sub
'
'BacErrHnd:
'
'    On Error GoTo 0
'    Resume Next
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Call VENTA_EliminarBloqueados(Data1, FormHandle)
   Call VENTA_BorrarTx(FormHandle)
End Sub

Private Sub CalcularValorFinal()
   Dim base%, Tasa#, ValIni#, Plazo&

   base = funcBaseMoneda(CmbMon.ItemData(CmbMon.ListIndex))
   Plazo = CDbl(txtplazo.Text)

   If Plazo = 0 Then
      Exit Sub
   End If

   ValIni = CDbl(txtIniPMP.Text)
   If ValIni = 0 Then
      Exit Sub
   End If

   Tasa = CDbl(TxtTasa.Text)
   If Tasa = 0 Then
      Exit Sub
   End If

   If CmbMon.ItemData(CmbMon.ListIndex) = 999 Then
      txtVenPMP.CantidadDecimales = 0
   Else
      txtVenPMP.CantidadDecimales = BacDatGrMon.mndecimal
   End If

   If dTipcam# = 1 Then
      txtVenPMP.Text = BacCtrlTransMonto(Int(VI_ValorFinal(ValIni#, Tasa#, Plazo&, base%)))
   Else
      txtVenPMP.Text = BacCtrlTransMonto(VI_ValorFinal(ValIni#, Tasa#, Plazo&, base%))
   End If
End Sub

Sub Graba()
   
   BacIrfGr.proMoneda = Trim$(Mid$(CmbMon.Text, 1, 3))
   BacIrfGr.proMtoOper = TxtTotal.Text
   BacIrfGr.proHwnd = Hwnd
   BacIrfGr.cCodLibro = BacRP.cCodLibro
   BacIrfGr.cCodCartFin = BacRP.cCodCartFin

   TxtFecVct_LostFocus

   BacIrfGr.oValorDVP = "glBacCpDvpVi"
   BacIrfGr.oDVP = glBacCpDvpVi
   Call BacGrabarTX

   BacControlWindows 100

   If Grabacion_Operacion Then
      FiltraVentaAutomatico = True
      giAceptar = True
      Call TipoFiltro
      Me.Tag = "RP"
   End If
End Sub

Private Sub Table1_ColumnChange()
   iFlagKeyDown = True
End Sub

Private Sub Table1_EnterEdit()
    iFlagKeyDown = False
    If Table1.Col = Ven_RP_NOMINAL Then
      bufNominal = Val(Data1.Recordset("tm_nominalo"))
   End If
End Sub

Private Sub ChkMoneda(Columna%)
   Dim MonLiq As Integer
   Dim Mt#, MtMl#, TcMl#

   If CmbMon.ListIndex = -1 Then
      Exit Sub
   End If
    
   Mt# = Data1.Recordset("tm_vp")
   MtMl# = Data1.Recordset("tm_mtml")
   TcMl# = Data1.Recordset("tm_tcml")
   If TcMl# = 0 Then
      TcMl# = dTipcam#
   End If

   MonLiq = CmbMon.ItemData(CmbMon.ListIndex)
   If MonLiq = giMonLoc Then
      If Data1.Recordset("tm_monemi") = MonLiq Then
         TcMl# = 1
         MtMl# = Mt#
      Else
         If Columna = 7 Then
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
            Exit Sub
         End If
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

   BacControlWindows 30

   Data1.Recordset.Edit
   Data1.Recordset("tm_vp") = Mt#
   Data1.Recordset("tm_mtml") = MtMl#
   Data1.Recordset("tm_tcml") = TcMl#
   Data1.Recordset.Update

End Sub

Private Sub Table1_ExitEdit()
   iFlagKeyDown = True
End Sub

Private Sub Table1_DblClick()
'   If Table1.Col = 7 And (Table1.TextMatrix(Table1.Row, Ven_RP_MARCA) = "V" Or Table1.TextMatrix(Table1.Row, Ven_RP_MARCA) = "P") Then
'      Combo1.Visible = True
'      Combo1.SetFocus
'   End If
End Sub

Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)
   columnita = Table1.Col

   If KeyCode = vbKeyReturn And KeyCode <> vbKeyV And KeyCode <> vbKeyR And KeyCode <> vbKeyF7 And KeyCode <> vbKeyF3 And ((Table1.Col > 2 And Table1.Col < 7) Or Table1.Col = 9) Then
      Table1.Col = columnita
      If KeyCode > 47 And KeyCode < 58 Then
         Text1.Text = Chr(KeyCode)
         Text1.SelStart = 1
      End If
      If KeyCode = vbKeyReturn Then
         Text1.Text = CDbl(Table1.TextMatrix(Table1.Row, Table1.Col))
      End If
      Text1.Visible = True
      Text1.SetFocus
      
      FrmMontos.Enabled = False
      Frame.Item(1).Enabled = False
      Frame.Item(2).Enabled = False
      
      Exit Sub
   End If
   
   If KeyCode = vbKeyReturn Then
      'call BacControlWindows (1)
      Table1.Col = columnita
      Table1.SetFocus
   End If

Exit Sub
KeyDownError:
   MsgBox error(err), vbExclamation, "Mensaje"
   Data1.Refresh
   Exit Sub
End Sub

Private Sub Table1_KeyPress(KeyAscii As Integer)
   Dim I          As Integer
   Dim OldReg     As Double
   Dim INDICE     As Integer
   Dim oContador  As Long
   Dim oFilas     As Long

   filita = Table1.Row

   If Table1.Col = 8 And Trim(Table1.TextMatrix(Table1.Row, Ven_RP_CUST)) = "DCV" And (Trim(Table1.TextMatrix(Table1.Row, Ven_RP_MARCA)) = "V" Or Trim(Table1.TextMatrix(Table1.Row, Ven_RP_MARCA)) = "P") Then
      Text2.Text = Table1.TextMatrix(Table1.Row, Table1.Col)
      Text2.Visible = True
      Text2.MaxLength = 9
      If KeyAscii <> vbKeyReturn Then
         Text2.Text = UCase(Chr(KeyAscii))
      Else
         Text2.Text = Table1.TextMatrix(Table1.Row, Table1.Col)
      End If
      Text2.SetFocus
      Exit Sub
   End If

   If KeyAscii <> vbKeyV And KeyAscii <> vbKeyR And KeyAscii <> vbKeyF7 And KeyAscii <> vbKeyF3 And Table1.Col = 7 And (Table1.TextMatrix(Table1.Row, Ven_RP_MARCA) = "V" Or Table1.TextMatrix(Table1.Row, Ven_RP_MARCA) = "P") Then
      If KeyAscii = vbKeyP Or KeyAscii = vbKeyF1 Then
         Combo1.ListIndex = 2
      ElseIf KeyAscii = vbKeyD Or KeyAscii = vbKeyNumpad4 Then
         Combo1.ListIndex = 1
      ElseIf KeyAscii = vbKeyC Or KeyAscii = vbKeyNumpad3 Then
         Combo1.ListIndex = 0
      End If
      Combo1.Visible = True
      Combo1.SetFocus
      Exit Sub
   End If

   columnita = Table1.Col
   BacToUCase KeyAscii

   If KeyAscii <> vbKeyV And KeyAscii <> vbKeyR And ((Table1.Col > 2 And Table1.Col < 7) Or Table1.Col = 9) Then
      If TipoCarga_RP = "A" Then
         Exit Sub
      End If
      If Table1.Col = Ven_RP_NOMINAL Or Table1.Col = Ven_RP_TIR Or Table1.Col = Ven_RP_VPAR Then
         Text1.CantidadDecimales = 4
      ElseIf Table1.Col = Ven_RP_VPS Then
         Text1.CantidadDecimales = 2
      ElseIf Table1.Col = Ven_RP_ValIni Then
         Text1.CantidadDecimales = 2
      Else
         Text1.CantidadDecimales = 0
      End If
      Table1.Col = columnita
      Text1.Visible = True
      If KeyAscii > 47 And KeyAscii < 58 Then
         Text1.Text = Chr(KeyAscii)
         Text1.SelStart = 1
      End If
      If KeyAscii = vbKeyReturn Then
         Text1.Text = Table1.TextMatrix(Table1.Row, Table1.Col)
      End If
      Text1.SetFocus
      Exit Sub
   End If

   filita = Table1.Row

   If Not Table1.Row = 1 Then
      Call Colocardata1
   Else
      If Data1.Recordset.BOF = True Then
      Else
         Data1.Recordset.MoveFirst
      End If
   End If

   OldReg = Data1.Recordset.AbsolutePosition

   If UCase$(Table1.TextMatrix(Table1.Row, Table1.Col)) = "CLAVE DCV" Then
      If Trim$(Data1.Recordset("tm_custodia")) <> "DCV" Or (Trim$(Data1.Recordset("tm_venta")) = "" Or Trim$(Data1.Recordset("tm_venta")) = "*") Then
         KeyAscii = 0
         Exit Sub
      End If
   End If

   If KeyAscii = vbKeyEscape Then
      iFlagKeyDown = True
      Exit Sub
   End If

   If KeyAscii <> vbKeyR And KeyAscii <> vbKeyV Then
      Select Case Table1.Col
         Case Ven_RP_NOMINAL, Ven_RP_VPS
            If Not iFlagKeyDown Then
               KeyAscii = BacPunto(Table1, KeyAscii, 12, 4)
            End If
            KeyAscii = BACValIngNumGrid(KeyAscii)

         Case Ven_RP_TIR, Ven_RP_VPAR
            If Not iFlagKeyDown Then
               KeyAscii = BacPunto(Table1, KeyAscii, 3, 4)
            End If
            KeyAscii = BACValIngNumGrid(KeyAscii)
      End Select
   End If

   If KeyAscii = vbKeyR Then
      KeyAscii = 0
      Call VENTA_VerDispon(FormHandle, Data1)

      If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
         If VENTA_DesBloquear(FormHandle, Data1) Then
            Data1.Recordset.Edit
            Data1.Recordset("tm_venta") = " "
            Data1.Recordset("tm_clave_dcv") = ""
            Data1.Recordset.Update
         End If
         If Data1.Recordset("tm_venta") = "*" Then
            If VENTA_VerBloqueo(FormHandle, Data1) Then
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = " "
               Data1.Recordset.Update
            End If
         End If
         Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlao"))
         If Data1.Recordset.RecordCount > 0 Then
            Call Restaura
         End If
         TxtTotal.Text = VENTA_SumarTotal(FormHandle)
         If Toolbar1.Buttons(6).Tag = "Ver Todos" And Data1.Recordset.RecordCount = 1 Then
            Toolbar1.Buttons(6).Tag = "Ver Sel."
            Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= 1"
            Data1.Refresh
            Data1.Recordset.AbsolutePosition = OldReg
         ElseIf Toolbar1.Buttons(6).Tag = "Ver Todos" And Data1.Recordset.RecordCount > 1 Then
            Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= 1" & " AND ( tm_venta = " & Chr(34) & "V" & Chr(34) & " OR tm_venta = " & Chr(34) & "P" & Chr(34) & " )"
            Data1.Refresh
            Data1.Recordset.AbsolutePosition = OldReg
         End If

         Data1.Recordset.MoveLast
         Table1.Rows = Data1.Recordset.RecordCount + 1
         Data1.Refresh
         Call Llenar_Grilla

         For INDICE = Table1.FixedRows To Table1.Rows - 1
            If Table1.TextMatrix(INDICE, Ven_RP_MARCA) <> "*" Then
               If Table1.TextMatrix(INDICE, Ven_RP_MARCA) = "V" Or Table1.TextMatrix(INDICE, Ven_RP_MARCA) = "P" Then
                  Toolbar1.Buttons(9).Enabled = False
                  Exit For
               End If
               Toolbar1.Buttons(9).Enabled = True
            End If
         Next INDICE

         KeyAscii = 0
      ElseIf Data1.Recordset("tm_venta") = "B" Then
         If VENTA_DesBloquear(0, Data1) Then
            Data1.Recordset.Edit
            Data1.Recordset("tm_venta") = " "
            Data1.Recordset.Update
            Call VENTA_Restaurar(Data1, "RP")
            Table1.TextMatrix(Table1.Row, Ven_RP_MARCA) = Data1.Recordset("tm_venta")

            For I = 0 To Table1.Cols - 1
               Table1.Col = I
               Call Table1_LeaveCell
            Next I
         End If

      End If
   End If

   If KeyAscii = vbKeyV Then
      Table1.ScrollBars = flexScrollBarNone

      If glBacCpDvpVi = Si Then
         For oFilas = 1 To Table1.Rows - 1
            If Table1.TextMatrix(oFilas, Ven_RP_MARCA) = "V" Then
               oContador = oContador + 1
            End If
         Next oFilas

         If oContador = 10 Then
            MsgBox "No se permite seleccionar mas de 10 documentos por operación.", vbExclamation, TITSISTEMA
            Table1.ScrollBars = flexScrollBarBoth
            If Table1.Enabled = True Then
               ValVenta_RP = False
               Exit Sub
            End If
         End If
      End If
      
      If VENTA_VerDispon(FormHandle, Data1) Then
         If Data1.Recordset("tm_venta") = " " Or Data1.Recordset("tm_venta") = "*" Or Data1.Recordset("tm_venta") = "B" Then
            If VENTA_Bloquear(FormHandle, Data1) Then
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = "V"
               Toolbar1.Buttons(9).Enabled = False 'Capturar de Operaciones en Sistema Soma
               If TipoCarga_RP = "A" Then
                  Data1.Recordset("tm_Corr_SOMA") = Val(Correlativo_SOMA_RP)
                  Data1.Recordset("tm_NumOper_SOMA") = Val(NumOper_SOMA_RP)
               End If
               If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
                  Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
               Else
                  Data1.Recordset("tm_clave_dcv") = ""
               End If
               Data1.Recordset.Update
               Table1.TextMatrix(Table1.Row, Ven_RP_CDCV) = Data1.Recordset("tm_clave_dcv")
            Else
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = "*"
               Data1.Recordset.Update
            End If
         End If
      End If

      TxtTotal.Text = VENTA_SumarTotal(FormHandle)

      If Data1.Recordset.BOF = True Then
      Else
         Table1.TextMatrix(Table1.Row, Ven_RP_MARCA) = Data1.Recordset("tm_venta")
      End If
      KeyAscii = 0
      Call Llenar_Grilla
      CmbMon_Click
   End If

   If KeyAscii = 66 Then
      If VENTA_VerDispon(FormHandle, Data1) Then
         If Data1.Recordset("tm_venta") = " " Or Data1.Recordset("tm_venta") = "*" Then
            If VENTA_Bloquear(0, Data1) Then
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = "B"
               Data1.Recordset.Update
            Else
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = "*"
               Data1.Recordset.Update
            End If
            Table1.TextMatrix(Table1.Row, Ven_RP_MARCA) = Data1.Recordset("tm_venta")
            For I = 0 To Table1.Cols - 1
               Table1.Col = I
               Call Table1_LeaveCell
            Next I
         End If
      End If
   End If

   If filita <= Table1.Rows - 1 Then
      Table1.Row = filita
   Else
      Table1.Row = Table1.Rows - 1
   End If
   Table1.Col = columnita
   Table1.SetFocus
   Table1.ScrollBars = flexScrollBarBoth
End Sub

Private Sub Table1_Update(Row As Long, Col As Integer, Value As String)
   On Error GoTo ExitEditError
   Dim Columna%

   MousePointer = 11
   Columna = Table1.Col
   If Data1.Recordset.RecordCount = 0 Then
      MousePointer = 0
      Exit Sub
   End If
   Data1.Recordset.Edit
   Data1.Recordset.Update
   BacControlWindows 60

   If Columna = Ven_RP_NOMINAL Then
      If VENTA_VerDispon(FormHandle, Data1) Then
         If CDbl(Table1.TextMatrix(Table1.Row, Ven_RP_NOMINAL)) <> Data1.Recordset("tm_nominalo") Then
            If CDbl(Table1.TextMatrix(Table1.Row, Ven_RP_NOMINAL)) > bufNominal Then
               MsgBox "NOMINAL INGRESADO MAYOR AL DISPONIBLE, " & NL & NL & "SE RESTAURARA EL NOMINAL INICIAL", vbExclamation, "Mensaje"
               Data1.Recordset.Edit
               Data1.Recordset("tm_nominal") = Data1.Recordset("tm_nominalo")
               Data1.Recordset.Update
               BacControlWindows 30
               If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
                  If VENTA_DesBloquear(FormHandle, Data1) Then
                     Data1.Recordset.Edit
                     Data1.Recordset("tm_venta") = " "
                     Data1.Recordset.Update
                  End If
               End If

               Call VENTA_Restaurar(Data1, "RP")
               Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlao"))
            Else
               If VPVI_LeerCortes(Data1, FormHandle) Then
                  If Trim(Data1.Recordset("tm_venta")) = "" And Data1.Recordset("tm_nominal") <> Data1.Recordset("tm_nominalo") Then
                     If VENTA_Bloquear(FormHandle, Data1) Then
                        Data1.Recordset.Edit
                        Data1.Recordset("tm_venta") = "P"
                        Data1.Recordset.Update
                     Else
                        Data1.Recordset.Edit
                        Data1.Recordset("tm_venta") = "*"
                        Data1.Recordset.Update
                     End If
                  Else
                     If Data1.Recordset("tm_venta") = "V" Then
                        Data1.Recordset.Edit
                        Data1.Recordset("tm_venta") = "P"
                        Data1.Recordset.Update
                     End If
                  End If
               Else
                  If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
                     If VENTA_DesBloquear(FormHandle, Data1) Then
                        Data1.Recordset.Edit
                        Data1.Recordset("tm_venta") = " "
                        Data1.Recordset.Update
                     End If
                  End If
                  ValVenta_RP = False
                  Call VENTA_Restaurar(Data1, "RP")
                  Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlao"))
               End If
            End If
         Else
            If Data1.Recordset("tm_venta") = "P" Then
               Data1.Recordset.Edit
               Data1.Recordset("tm_venta") = "V"
               Data1.Recordset.Update
            ElseIf Data1.Recordset("tm_venta") = " " Then
               If VENTA_Bloquear(FormHandle, Data1) Then
                  Data1.Recordset.Edit
                  Data1.Recordset("tm_venta") = "V"
                  Data1.Recordset.Update
               Else
                  Data1.Recordset.Edit
                  Data1.Recordset("tm_venta") = "*"
                  Data1.Recordset.Update
               End If
            End If
         End If
      End If

      If CDbl(Table1.TextMatrix(Table1.Row, Ven_RP_TIR)) <> 0 Then
         Call VENTA_Valorizar(2, Data1)
      ElseIf CDbl(Table1.TextMatrix(Table1.Row, Ven_RP_VPAR)) <> 0 Then
         Call VENTA_Valorizar(1, Data1)
      ElseIf CDbl(Table1.TextMatrix(Table1.Row, Ven_RP_VPS)) <> 0 Then
         Call VENTA_Valorizar(3, Data1)
      End If

   ElseIf Columna = Ven_RP_TIR Then
      Call VENTA_Valorizar(2, Data1)
   ElseIf Columna = Ven_RP_VPAR Then
      Call VENTA_Valorizar(1, Data1)
   ElseIf Columna = Ven_RP_VPS Then
      Call VENTA_Valorizar(3, Data1)
   End If

   BacControlWindows 12
   Call ChkMoneda(Columna%)
   BacControlWindows 12

   If Columna > 3 And Columna < 13 Then
      Call ChkMoneda(Columna%)
      BacControlWindows 12
      TxtTotal.Text = VENTA_SumarTotal(FormHandle)
      If dTipcam = 0 Then
         txtIniPMP.Text = 0
      Else
         txtIniPMP.Text = Round(TxtTotal.Text / dTipcam#, IIf(Trim(CmbMon.Text) = "CLP", 0, BacDatGrMon.mndecimal))
      End If
   End If

   If Columna = Ven_RP_NOMINAL Then
      SendKeys "{TAB 1}"
   ElseIf Columna = Ven_RP_TIR Then
      SendKeys "{TAB 2}"
   ElseIf Columna = Ven_RP_VPS Then
      SendKeys "{TAB 1}"
   End If

   MousePointer = 0
   iFlagKeyDown = True
Exit Sub
ExitEditError:
   MousePointer = 0
   MsgBox error(err), vbExclamation, "Mensaje"
   Data1.Refresh
   iFlagKeyDown = True
   Exit Sub
End Sub

Private Sub Table1_LeaveCell()
   If Table1.Row <> 0 And Table1.Col > 1 Then
      Table1.CellFontBold = True
      If Table1.TextMatrix(Table1.Row, Ven_RP_MARCA) = "V" Then
         Table1.CellBackColor = vbBlue
         Table1.CellForeColor = vbWhite
      ElseIf Table1.TextMatrix(Table1.Row, Ven_RP_MARCA) = "P" Then
         Table1.CellBackColor = vbCyan
         Table1.CellForeColor = vbBlack
      ElseIf Table1.TextMatrix(Table1.Row, Ven_RP_MARCA) = "*" Then
         Table1.CellBackColor = vbGreen + vbWhite
         Table1.CellForeColor = vbWhite
      ElseIf Table1.TextMatrix(Table1.Row, Ven_RP_MARCA) = "B" Then
         Table1.CellBackColor = vbBlack + vbWhite
         Table1.CellForeColor = vbBlack
      Else
         Table1.CellBackColor = vbBlack
         Table1.CellForeColor = vbBlack
      End If
      Table1.CellFontBold = False
   End If
End Sub

Private Sub Table1_Scroll()
   Text1_LostFocus
End Sub

Private Sub Text1_GotFocus()
   Call PROC_POSI_TEXTO(Table1, Text1)
End Sub

Private Sub Text1_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim Fila       As Integer
   Dim Value      As String
   Dim Colum      As Integer
   Dim Anterior   As Double
   Dim Columna%

   If KeyCode = vbKeyEscape Then
      FrmMontos.Enabled = True
      Frame.Item(1).Enabled = True
      Frame.Item(2).Enabled = True

      Text1_LostFocus
   End If

   Fila = Table1.Row

   If KeyCode = vbKeyReturn Then
      FrmMontos.Enabled = True
      Frame.Item(1).Enabled = True
      Frame.Item(2).Enabled = True
      
      Antes_Flag = True
      TipO = "VI"
      Anterior = Table1.TextMatrix(Table1.Row, Table1.Col)
      Colum = Table1.Col
      Call BacControlWindows(10)

      If Not Table1.Row = 1 Then
         Call Colocardata1
      Else
         Data1.Recordset.MoveFirst
      End If

      Call BacControlWindows(10)
      iFlagKeyDown = False

      If Table1.Col = Ven_RP_NOMINAL Then
         bufNominal = CDbl(Data1.Recordset("tm_nominalo"))
      End If
      On Error GoTo ExitEditError

      Me.MousePointer = vbHourglass
      Columna = Table1.Col

      If Data1.Recordset.RecordCount = 0 Then
         Me.MousePointer = vbDefault
         Exit Sub
      End If


      Dim nValorNuevo   As Double
      If Columna = Ven_RP_ValIni Then
         nValorNuevo = Round(CDbl((Text1.Text) / Table1.TextMatrix(Table1.Row, Ven_RP_ValIni - 1)), 0)
         Text1.Text = nValorNuevo
         Columna = Ven_RP_VPS
      End If

      Data1.Recordset.Edit
      Call BacControlWindows(10)
      Table1.TextMatrix(Table1.Row, Table1.Col) = Text1.Text
      Call BacControlWindows(10)

      If Columna = Ven_RP_NOMINAL Then
         Data1.Recordset!tm_nominal = Text1.Text
         Data1.Recordset.Update
         If VENTA_VerDispon(FormHandle, Data1) Then
            If CDbl(Table1.TextMatrix(Table1.Row, Ven_RP_NOMINAL)) <> Data1.Recordset("tm_nominalo") Then
               If CDbl(Table1.TextMatrix(Table1.Row, Ven_RP_NOMINAL)) > bufNominal Then
                  MsgBox "Nominal Ingresado Mayor Al Disponible, " & NL & NL & "Se Restaurara El Nominal Inicial", vbExclamation, "Mensaje"
                  Data1.Recordset.Edit
                  Data1.Recordset("tm_nominal") = Data1.Recordset("tm_nominalo")
                  Data1.Recordset.Update
                  BacControlWindows 30

                  If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
                     If VENTA_DesBloquear(FormHandle, Data1) Then
                        Data1.Recordset.Edit
                        Data1.Recordset("tm_venta") = " "
                        Data1.Recordset!tm_clave_dcv = ""
                        Data1.Recordset.Update
                     End If
                  End If
                  Call VENTA_Restaurar(Data1, "RP")
                  Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlao"))
               Else
                  If VPVI_LeerCortes(Data1, FormHandle) Then
                     If Trim(Data1.Recordset("tm_venta")) = "" And Data1.Recordset("tm_nominal") <> Data1.Recordset("tm_nominalo") Then
                        If VENTA_Bloquear(FormHandle, Data1) Then
                           Data1.Recordset.Edit
                           Data1.Recordset("tm_venta") = "P"
                           Data1.Recordset.Update
                        Else
                           Data1.Recordset.Edit
                           Data1.Recordset("tm_venta") = "*"
                           Data1.Recordset.Update
                        End If
                     Else
                        If Data1.Recordset("tm_venta") = "V" Then
                           Data1.Recordset.Edit
                           Data1.Recordset("tm_venta") = "P"
                           Data1.Recordset.Update
                        End If
                     End If
                  Else
                     If Data1.Recordset("tm_venta") = "V" Or Data1.Recordset("tm_venta") = "P" Then
                        If VENTA_DesBloquear(FormHandle, Data1) Then
                           Data1.Recordset.Edit
                           Data1.Recordset("tm_venta") = " "
                           Data1.Recordset.Update
                        End If
                     End If

                     ValVenta_RP = False
                     Call VENTA_Restaurar(Data1, "RP")
                     Call VENTA_DesBloquear(FormHandle, Data1)
                     Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlao"))
                  End If
               End If
            Else
               If Data1.Recordset("tm_venta") = "P" Then
                  Data1.Recordset.Edit
                  Data1.Recordset("tm_venta") = "V"
                  Data1.Recordset.Update
               ElseIf Data1.Recordset("tm_venta") = " " Then
                  If VENTA_Bloquear(FormHandle, Data1) Then
                     Data1.Recordset.Edit
                     Data1.Recordset("tm_venta") = "V"
                     Data1.Recordset.Update
                  Else
                     Data1.Recordset.Edit
                     Data1.Recordset("tm_venta") = "*"
                     Data1.Recordset.Update
                  End If
               End If
            End If

            If Trim(Table1.TextMatrix(Table1.Row, Ven_RP_CUST)) = "DCV" And (Data1.Recordset!tm_venta = "V" Or Data1.Recordset!tm_venta = "P") Then
               Data1.Recordset.Edit
               Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
               Data1.Recordset.Update
               Table1.TextMatrix(Table1.Row, Ven_RP_CDCV) = Data1.Recordset("tm_clave_dcv")
            End If
         End If

         If CDbl(Table1.TextMatrix(Table1.Row, Ven_RP_TIR)) <> 0 Then
            Call VENTA_Valorizar(2, Data1)
         ElseIf CDbl(Table1.TextMatrix(Table1.Row, Ven_RP_VPAR)) <> 0 Then
            Call VENTA_Valorizar(1, Data1)
         ElseIf CDbl(Table1.TextMatrix(Table1.Row, Ven_RP_VPS)) <> 0 Then
            Call VENTA_Valorizar(3, Data1)
         End If

         BacControlWindows 100
      ElseIf Columna = Ven_RP_TIR Then
         Data1.Recordset!TM_TIR = Text1.Text
         Data1.Recordset.Update
         Call VENTA_Valorizar(2, Data1)
         Table1.SetFocus
      ElseIf Columna = Ven_RP_VPAR Then
         Data1.Recordset!TM_Pvp = Text1.Text
         Data1.Recordset.Update
         Call VENTA_Valorizar(1, Data1)
         If Not Antes_Flag Then
            Table1.TextMatrix(Table1.Row, Table1.Col) = Anterior
            Data1.Recordset.Edit
            Data1.Recordset!TM_Pvp = Anterior
            Data1.Recordset.Update
         End If
      ElseIf Columna = Ven_RP_VPS Then
         Data1.Recordset!TM_VP = Text1.Text
         Data1.Recordset.Update
         Call VENTA_Valorizar(3, Data1)
         If Not Antes_Flag Then
            Table1.TextMatrix(Table1.Row, Table1.Col) = Anterior
            Data1.Recordset.Edit
            Data1.Recordset!TM_VP = Anterior
            Data1.Recordset!TM_VALINICIAL = Data1.Recordset!TM_MARGEN * Data1.Recordset!TM_VP
            Data1.Recordset.Update
         End If
      End If

      BacControlWindows 100
      Call ChkMoneda(Columna%)
      BacControlWindows 100

      If Columna > 2 And Columna < 12 Then
         Call ChkMoneda(Columna%)
         BacControlWindows 100
         TxtTotal.Text = VENTA_SumarTotal(FormHandle)
         If dTipcam = 0 Then
            txtIniPMP.Text = 0
         Else
            txtIniPMP.Text = Round(TxtTotal.Text / dTipcam#, IIf(Trim(CmbMon.Text) = "CLP", 0, BacDatGrMon.mndecimal))
         End If
      End If

      If Columna = Ven_RP_NOMINAL Then
         SendKeys "{TAB 1}"
      ElseIf Columna = Ven_RP_TIR Then
         SendKeys "{TAB 2}"
      ElseIf Columna = Ven_RP_VPS Then
         SendKeys "{TAB 1}"
      End If

      MousePointer = 0
      iFlagKeyDown = True
      BacControlWindows 100
      Llenar_Grilla
      BacControlWindows 100
      Text1_LostFocus
      Table1.Col = Colum
      Table1.Row = Fila
   End If

Exit Sub
ExitEditError:
   MousePointer = vbDefault
   iFlagKeyDown = True
   Table1.Row = Table1.Rows - 1
   Table1.TextMatrix(Table1.Row, Ven_RP_NOMINAL) = Format(Monto, "###,###,###,##0.0000")
   Text1.Visible = False
End Sub

Private Sub Text1_LostFocus()
   On Error GoTo error
   Text1.Visible = False
  'Call BacControlWindows(1)
   Table1.SetFocus
error:
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim ResultSOMA    As Boolean

   If u = 1 Then
      MsgBox "Revise Fecha de Vencimiento ", vbCritical
      Exit Sub
   End If
   If k = 1 Then
      MsgBox "Revise Tasa de Pacto ", vbCritical
      Exit Sub
   End If

   Select Case Button.Key
      Case Is = "cmbgrabar"
         Call Graba
            Toolbar1.Buttons(9).Enabled = False

      Case Is = "cmbvende"
         Table1_KeyPress (118)

      Case Is = "cmbrestaura"
         Table1_KeyPress (114)

      Case Is = "cmdfiltra"
         Call Func_Setear_GrillaSOMA
         TipoCarga_RP = "M" 'Manual
         Call Filtrar
         If Table1.Rows > 1 Then
            Toolbar1.Buttons(9).Enabled = True
         Else
            Toolbar1.Buttons(9).Enabled = False
         End If

      Case Is = "cmdemision"
         Call Emite

      Case Is = "cmdcortes"
         Call Corta

      Case Is = "CmdTipoFiltro"
         Call TipoFiltro

      Case Is = "cmdcaptura"
         Toolbar1.Buttons(10).Enabled = False
         TipoCarga_RP = "A"
         Call Carga_Soma_Excel(ResultSOMA)
         If ResultSOMA Then
            Label_SOMA.Visible = False
            Call Validar_DatosSOMA
            Label_SOMA.Visible = False
            Progress_SOMA.Visible = False
         End If

      Case "cmdInfCargaSOMA"
         Imprimir_Informe_Errores_SOMA
      Case Is = "cmdsalir"
         Unload Me
   End Select

End Sub

Private Sub TxtFecVct_Change()
   txtplazo.Text = DateDiff("D", TxtFecIni.Text, TxtFecVct.Text)
End Sub

Private Sub TxtFecVct_LostFocus()

   u = 0
   If Format(TxtFecVct.Text, "yyyymmdd") < Format(TxtFecIni.Text, "yyyymmdd") Then
      MsgBox "La Fecha de Vencimiento debe ser Mayor a Fecha de Inicio.", 16
      TxtFecVct.Text = Format$(DateAdd("d", txtplazo.Text, TxtFecIni.Text), "dd/mm/yyyy")
      u = 1
   End If
   txtplazo.Tag = txtplazo.Text
   txtplazo.Text = DateDiff("d", TxtFecIni.Text, TxtFecVct.Text)
   PnlDiaFin.Caption = BacDiaSem(TxtFecVct.Text)
   If EsFeriado(CDate(TxtFecVct.Text), "00001") Then
      MsgBox "La Fecha de Vcto. ingresada retorna un día No Hábil; Por favor reingrese", vbCritical, "FERIADOS"
      txtplazo.Text = txtplazo.Tag
      TxtFecVct.Text = Format$(DateAdd("d", txtplazo.Text, TxtFecIni.Text), "dd/mm/yyyy")
      PnlDiaFin.Caption = BacDiaSem(TxtFecVct.Text)
      u = 1
   End If
   If txtplazo.Text = 0 Then
      MsgBox "Fecha de Vcto. Ingresada igual a la de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
      txtplazo.Text = txtplazo.Tag
      TxtFecVct.Text = Format$(DateAdd("d", txtplazo.Text, TxtFecIni.Text), "dd/mm/yyyy")
      u = 1
   End If
   Call CalcularValorFinal
End Sub

Private Sub txtIniPMP_Change()
   Call CalcularValorFinal
   If CmbMon.Text = "CLP" Then
      txtIniPMS.Text = CDbl(TxtTotal.Text)
   Else
      txtIniPMS.Text = CDbl(TxtTotal.Text)
   End If
End Sub

Private Sub TxtInv_Change()
   If TxtInv.Text = "" Then
      TxtInv.Text = 0
   End If
   If CDbl(TxtInv.Text) > 0 Then
      TxtSaldo.Text = TxtSel.Text - TxtInv.Text
   Else
      TxtSaldo.Text = 0
   End If
End Sub

Private Sub TxtInv_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      KeyAscii = 0
   End If
End Sub

Private Sub TxtPlazo_GotFocus()
   txtplazo.Tag = txtplazo.Text
End Sub

Private Sub TxtPlazo_LostFocus()
   Dim rs      As Recordset
   Dim Sql     As String

   If txtplazo.Text <> txtplazo.Tag Then
      Sql = "SELECT SUM(tm_vp) As Total FROM mdventa WHERE ( tm_venta = 'V' OR tm_venta = 'P' ) AND tm_hwnd = " & Hwnd & " AND tm_diasdisp < " & txtplazo.Text
      Set rs = db.OpenRecordset(Sql, dbOpenSnapshot)

      If rs.RecordCount > 0 Then
         If Not IsNull(rs.Fields("Total")) Then
            If rs.Fields("Total") > 0 Then
               MsgBox "Existen Inst. Seleccionados con menor disponibilidad al Plazo ingresado, Debe Desmarcar", vbCritical, "Días Pacto"
               txtplazo.Text = txtplazo.Tag
               txtplazo.SetFocus
               TxtFecVct.Text = Format$(DateAdd("d", txtplazo.Text, TxtFecIni.Text), "dd/mm/yyyy")
               Exit Sub
            End If
         End If
      End If

      TxtFecVct.Text = Format$(DateAdd("d", txtplazo.Text, TxtFecIni.Text), "dd/mm/yyyy")
      PnlDiaFin.Caption = BacDiaSem(TxtFecVct.Text)

      If EsFeriado(CDate(TxtFecVct.Text), "00001") Then
         MsgBox "La Fecha de Vcto. ingresada retorna un día No Hábil; Por favor reingrese", vbCritical, "Feriados"
         txtplazo.Text = txtplazo.Tag
         TxtFecVct.Text = Format$(DateAdd("d", txtplazo.Text, TxtFecIni.Text), "dd/mm/yyyy")
         PnlDiaFin.Caption = BacDiaSem(TxtFecVct.Text)
         Exit Sub
      End If
      If txtplazo.Text = 0 Then
         MsgBox "Fecha de Vcto. Ingresada igual a la de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
         txtplazo.Text = txtplazo.Tag
         txtplazo.SetFocus
         TxtFecVct.Text = Format$(DateAdd("d", txtplazo.Text, TxtFecIni.Text), "dd/mm/yyyy")
         Exit Sub
      End If
      Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= " & txtplazo.Text
      Toolbar1.Buttons(6).Tag = "Ver Sel."
      Data1.Refresh
      TxtCartera.Text = VENTA_SumarCartera(FormHandle, txtplazo.Text, Toolbar1)
      Call CalcularValorFinal
   End If
End Sub

Private Sub TxtSel_Change()
   If TxtInv.Text > 0 Then
      TxtSaldo.Text = TxtSel.Text - TxtInv.Text
   Else
      TxtSaldo.Text = 0
   End If
End Sub

Private Sub TxtTasa_LostFocus()
   k = 0
   Call CalcularValorFinal
End Sub

Private Sub txtTipoCambio_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Call txtTipoCambio_LostFocus
   End If
End Sub

Private Sub txtTipoCambio_LostFocus()
   dTipcam# = TxtTipoCambio.Text
   Call TxtTotal_Change
   Call CalcularValorFinal
End Sub

Private Sub TxtTotal_Change()
   Dim nRedon        As Integer
   Dim AuxdTipCam    As Double

   txtIniPMS.Text = TxtTotal.Text
   TxtTotal.Text = IIf(TxtTotal.Text = "", "0", TxtTotal.Text)
   If SwMx = "C" And CmbMon.ItemData(CmbMon.ListIndex) <> 999 Then
      nRedon = BacDatGrMon.mndecimal
   ElseIf SwMx = " " And CmbMon.ItemData(CmbMon.ListIndex) = 999 Then
      nRedon = 0
   Else
      nRedon = BacDatGrMon.mndecimal
   End If

   If dTipcam = 0 Then
      txtIniPMP.Text = 0
   Else
      txtIniPMP.Text = Round(TxtTotal.Text / dTipcam, nRedon)
   End If

   TxtSel.Text = TxtTotal.Text

   If Toolbar1.Buttons(6).Tag = "Ver Sel." And CDbl(TxtTotal.Text) = 0 Then
      Toolbar1.Buttons(6).Enabled = False
   Else
      Toolbar1.Buttons(6).Enabled = True
   End If
End Sub

Private Sub TxtTotal_GotFocus()
   TxtTotal.Tag = TxtTotal.Text
End Sub

Private Sub TxtTotal_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = 13 Then
      Tecla = "13"
   Else
      Tecla = ""
   End If
End Sub

Private Sub TxtTotal_KeyPress(KeyAscii As Integer)
   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
   End If
End Sub

Private Sub TxtTotal_LostFocus()
   On Error GoTo error
   Dim dTotalNuevo#, dTotalActual#
   Dim I As Integer

   If Table1.TextMatrix(1, Ven_RP_MARCA) = "" Then
      Exit Sub
   End If
   If Not Table1.Row = 1 Then
      Call Colocardata1
   Else
      Data1.Recordset.MoveFirst
   End If

   If TxtTotal.Tag <> TxtTotal.Text Then
      dTotalActual# = TxtTotal.Tag
      dTotalNuevo# = TxtTotal.Text
      Call VENTA_ValorizarTotal(Data1, dTotalNuevo#, dTotalActual#)
      Data1.Refresh
      Data1.Recordset.MoveFirst
      Table1.Row = I
      Call Llenar_Grilla
      Table1.Refresh
   End If

error:
   Screen.MousePointer = vbDefault
   Exit Sub
End Sub

Public Function Calcula_Monto_Mx(Monto As Double, Monemis As Integer, MonPacto As Integer) As Double
   Dim Monto_Peso    As Double
   Dim nFactor       As Double
   Dim nRedon        As Integer
   Dim nparidad      As Double

   If Monemis = 13 Then
      Monto_Peso = Round(Monto * nDolarOb, 0)
   Else
      Monto_Peso = Monto
   End If
   If MonPacto = 998 Then
      nFactor = nUf
      nRedon = 4
   ElseIf MonPacto = 999 Then
      nFactor = 1
      nRedon = 0
   ElseIf MonPacto = 13 Then
      nFactor = CDbl(TxtTipoCambio.Text) ''nDolarOb
      nRedon = 2
   Else
      nFactor = CDbl(TxtTipoCambio.Text) '''funcBuscaTipcambio(MonPacto, sFecPro)
      nRedon = 4
   End If
   Calcula_Monto_Mx = Round(Monto_Peso / nFactor, nRedon)
End Function

Private Sub Carga_Soma_Excel(ByRef ResultSOMA As Boolean)  'mgc-cargasoma
   On Error GoTo ErrorExcell
   Dim T_Row_Excel         As Integer
   Dim ObjExcel            As Object
   Dim ObjLibro            As Object
   Dim T_Int_Celda         As Integer
   Dim J                   As Integer
   Dim ireg                As Integer
   Dim ireg0               As Integer
   Dim T_Str_Dir_Archivo   As String
   Dim MaqDEC, MaqMIL, ExcDEC, ExcMIL, SQLDEC As String * 1
   Dim CambioOper          As Boolean
   Dim TipoCorte           As String * 1
   Dim icont               As Integer
   Dim Valor_Const         As Double
   Dim gsBac_CORR_SOMA     As String
   Dim mensaje             As String
   Dim strHora             As String
   Dim strMonto            As String
   Dim dblMonto            As Double
   Dim dblTir              As Double
   Dim strReferencial      As String
   Dim dblReferencial      As Double
   Dim strInicial          As String
   Dim dblInicial          As Double
   Dim strCtaLbtr          As String
   Dim dblCtaLbtr          As Double
   Dim icorrel             As Integer
   Dim strCorrel           As String
   Dim h                   As Integer
   Dim strCtaDcv           As String
   Dim dblCtaDcv           As Double

   ResultSOMA = True
   T_Str_Dir_Archivo = gsBac_DIRSOMA & "\CargaSOMA" & Mid(CDate(gsBac_Fecp), 4, 2) & Mid(CDate(gsBac_Fecp), 1, 2) & ".xls"

   Erase OperExcel

   If Dir(T_Str_Dir_Archivo) = "" Then
      MsgBox "No Existe archivo: " & T_Str_Dir_Archivo, 64, Me.Caption
      ResultSOMA = False
      Exit Sub
   Else
      If UCase(Mid(T_Str_Dir_Archivo, (Len(T_Str_Dir_Archivo) - 3), 4)) <> ".XLS" Then
         MsgBox "El Archivo Seleccionado no corresponde a un Archivo Excel", 64, Me.Caption
         ResultSOMA = False
         Exit Sub
      Else
         On Error GoTo ErrorExcel
         Screen.MousePointer = vbHourglass

         Label_SOMA.Visible = True
         Progress_SOMA.Visible = True
         Label_SOMA.Caption = "Cargando Archivo SOMA..."
         Valor_Const = (100 / (T_Row_Excel + 5000))

         Set ObjExcel = CreateObject("Excel.Application")
         Set ObjLibro = ObjExcel.Workbooks.Open(T_Str_Dir_Archivo)

         If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
            GoTo BacErrorHandler
         End If

         gsBac_CORR_SOMA = "B"
         If gsBac_CORR_SOMA = "B" Then
            icol = 2
         End If

         Call Carga_Cartera_Consolidada
         Call Busca_Correlativo_Operacion

         var_cantoper = 0

         For T_Int_Celda = 2 To T_Row_Excel + 5000
            Progress_SOMA.Value = Round(Valor_Const * T_Int_Celda, 0)
            celda1 = ObjLibro.Worksheets(1).Cells(T_Int_Celda, icol)

            If celda1 = "Correlativo" Then
               iCorrelOpera = iCorrelOpera + 1 'nro rescatado para asignar correlativo
               var_cantoper = var_cantoper + 1
               CambioOper = True

               For I = 1 To 50 'lineas de operaciones

                  celda1 = ObjLibro.Worksheets(1).Cells(T_Int_Celda, icol)

                  If celda1 = "Valor Inicial Pacto: " Then
                     Exit For
                  End If

                  If Val(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 2)) >= 1 Then
                     icont = icont + 1
                     celda2 = ObjLibro.Worksheets(1).Cells(T_Int_Celda, 2) 'correlativo

                     celda1 = ObjLibro.Worksheets(1).Cells(T_Int_Celda - 1, icol)
                     If celda1 = "Correlativo" And celda2 = 1 Then
                        iCorrelOpera = iCorrelOpera + 1
                     End If

                     celda3 = ObjLibro.Worksheets(1).Cells(T_Int_Celda, 3) 'Mnemotecnico
                     celda4 = IIf(Trim(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 4) = ""), 0, (ObjLibro.Worksheets(1).Cells(T_Int_Celda, 4))) 'Monto Nominal
                     celda5 = IIf(Trim(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 5) = ""), 0, (ObjLibro.Worksheets(1).Cells(T_Int_Celda, 5))) 'Plazo Residual
                     celda6 = IIf(Trim(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 6) = ""), 0, (ObjLibro.Worksheets(1).Cells(T_Int_Celda, 6))) 'Tasa Referencial
                     celda7 = IIf(Trim(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 7) = ""), 0, (ObjLibro.Worksheets(1).Cells(T_Int_Celda, 7))) 'Valor Referencial
                     celda8 = ObjLibro.Worksheets(1).Cells(T_Int_Celda, 8) 'Haircut
                     celda9 = IIf(Trim(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 9) = ""), 0, (ObjLibro.Worksheets(1).Cells(T_Int_Celda, 9))) 'Margen
                     celda10 = IIf(Trim(ObjLibro.Worksheets(1).Cells(T_Int_Celda, 10) = ""), 0, (ObjLibro.Worksheets(1).Cells(T_Int_Celda, 10))) 'Valor Inicial
                     celda11 = ObjLibro.Worksheets(1).Cells(T_Int_Celda, 11) 'Cta Destino
                     celda12 = ObjLibro.Worksheets(1).Cells(T_Int_Celda, 12) 'Cta LBTR
                     celda13 = ObjLibro.Worksheets(1).Cells(T_Int_Celda, 13) 'Cta DCV
                     celda14 = ObjLibro.Worksheets(1).Cells(T_Int_Celda, 14) 'Estado DCV

                     Call RescataSeparadores(celda10, MaqMIL, MaqDEC, ExcMIL, ExcDEC, SQLDEC)

                     Envia = Array()
                     AddParam Envia, Format(sFecPro, "yyyymmdd")              '1@Fecha_Proceso      DATETIME
                     AddParam Envia, CStr(Format(Now, "yyyymmdd hh:mm:ss"))   '2@Hora_Ingreso       DATETIME
                     AddParam Envia, 0                                        '3@Numdocu        NUMERIC(5,0)
                     AddParam Envia, 0                                        '4@Numoper        NUMERIC(5,0)
                     AddParam Envia, icont                                    '5@Correlativo    NUMERIC(5,0)
                     AddParam Envia, CStr(celda3)                             '6@Instserie      CHAR(12)
                     AddParam Envia, "VI"                                     '7@Tipo_Operacion CHAR(3)

                     strMonto = FmtNumero(celda4, ExcMIL, ExcDEC, SQLDEC)
                     dblMonto = CDbl(Replace(Trim(strMonto), SQLDEC, MaqDEC))

                     AddParam Envia, IIf(InStr(1, strMonto, ".") = 0, dblMonto, Trim(strMonto)) '8@Nominal        NUMERIC(19,4)

                     If InStr(1, FmtNumero(celda5, ExcMIL, ExcDEC, SQLDEC), ".") = 0 Then
                        AddParam Envia, FmtNumero(celda5, ExcMIL, ExcDEC, SQLDEC)               '9@Plazo_residual     NUMERIC(6,0)
                     Else
                        AddParam Envia, CDbl(Replace(FmtNumero(celda5, ExcMIL, ExcDEC, SQLDEC), SQLDEC, MaqDEC)) '9@Plazo_residual     NUMERIC(6,0)
                     End If

                     If InStr(1, FmtNumero(celda6, ExcMIL, ExcDEC, SQLDEC), ".") = 0 Then
                        AddParam Envia, FmtNumero(celda6, ExcMIL, ExcDEC, SQLDEC) '10@Tasa_referencial   NUMERIC(19,4)
                     Else
                        dblTir = CDbl(Replace(FmtNumero(celda6, ExcMIL, ExcDEC, SQLDEC), SQLDEC, MaqDEC))
                        AddParam Envia, CDbl(Replace(FmtNumero(celda6, ExcMIL, ExcDEC, SQLDEC), SQLDEC, MaqDEC)) '10@Tasa_referencial   NUMERIC(19,4)
                     End If

                     strReferencial = FmtNumero(celda7, ExcMIL, ExcDEC, SQLDEC)
                     dblReferencial = CDbl(Replace(Trim(strReferencial), SQLDEC, MaqDEC))

                     If InStr(1, strReferencial, ".") = 0 Then
                        AddParam Envia, dblReferencial             '11@Valor_referencial  NUMERIC(19,4)
                     Else
                        AddParam Envia, Trim(strReferencial)             '11@Valor_referencial  NUMERIC(19,4)
                     End If

                     AddParam Envia, FmtNumero(celda9, ExcMIL, ExcDEC, SQLDEC) '12@Margen         FLOAT

                     strInicial = FmtNumero(celda10, ExcMIL, ExcDEC, SQLDEC)
                     strInicial = Trim(BacStrTran((celda10), ",", ""))
                     dblInicial = CDbl(Replace(Trim(strInicial), SQLDEC, MaqDEC))

                     If InStr(1, strInicial, ".") = 0 Then
                        AddParam Envia, dblInicial                 '13@Valor_Inicial    NUMERIC(19,4)
                     Else
                        AddParam Envia, strInicial                 '13@Valor_Inicial    NUMERIC(19,4)
                     End If

                     AddParam Envia, 0                          '14@Valor_Final      NUMERIC(19,4)
                     AddParam Envia, IIf((celda11) = "-", 0, 1) '15@Cta_destino      NUMERIC(11,0)

                     strCtaLbtr = Trim(FmtNumero(celda12, ExcMIL, ExcDEC, SQLDEC))
                     dblCtaLbtr = CDbl(Replace(Trim(strCtaLbtr), SQLDEC, MaqDEC))
                     If InStr(1, strCtaLbtr, ".") = 0 Then
                        AddParam Envia, dblCtaLbtr              '16@Cta_Lbtr         NUMERIC(11,0)
                     Else
                        AddParam Envia, strCtaLbtr              '16@Cta_Lbtr         NUMERIC(11,0)
                     End If

                     strCtaDcv = Trim(FmtNumero(celda13, ExcMIL, ExcDEC, SQLDEC))
                     dblCtaDcv = CDbl(Trim(Mid(strCtaDcv, 1, 7)))

                     AddParam Envia, dblCtaDcv               '17@Cta_Dcv           NUMERIC(7,0)
                     AddParam Envia, CStr(celda14)           '18@Estado_Dcv        CHAR(20)

                     strCorrel = CInt(celda2)
                     icorrel = CInt(strCorrel)

                     AddParam Envia, icorrel                 '19@Correlativo_SOMA  NUMERIC(3,0)

                     mensaje = ""

                     If Not Len(celda3) > 1 Or Not Len(celda4) > 1 Or Not Len(Trim(celda5)) > 0 Or Not Len(celda6) > 1 Or Not Len(celda7) > 1 Or Not Len(Trim(celda9)) > 0 Or Not Len(celda10) > 1 Then
                        mensaje = "Datos Incompletos"
                     Else
                        TipoCorte = ""
                        For h = 1 To iTotCartera
                           If Len(sInstrumento(h)) = 0 Then
                              Exit For
                           End If
                           If Trim(sInstrumento(h)) = Trim(celda3) Then
                              mensaje = ""
                              If dNominal(h) < dblMonto Then
                                 mensaje = "Falta Stock o disponibilidad de Nominal"
                              ElseIf dTir(h) <> dblTir Then
                                 mensaje = "Las Tasas de Referencia son Distintas"
                              ElseIf sCustodia(h) <> "D" Then
                                 mensaje = "Instrumento No Pertenece a la Custodia DCV"
                              ElseIf Not fCupon(h) > Format$(DateAdd("d", 3, sFecPro), "dd/mm/yyyy") Then
                                 mensaje = "Instrumento tiene vencimiento de cupon dentro de los proximos 3 dias habiles"
                              End If
                              If mensaje = "" Then
                                 If dNominal(h) = dblMonto Then
                                    TipoCorte = "T" 'Total
                                    Exit For
                                 Else
                                    TipoCorte = "P" 'Parcial
                                 End If
                              End If
                           Else
                              mensaje = "No Existe Instrumento"
                           End If
                        Next h

                        If TipoCorte = "P" Then
                           mensaje = ""
                        End If
                     End If

                     AddParam Envia, mensaje                 '20@Observacion       CHAR(70)
                     AddParam Envia, 0                       '21@Diferencia        NUMERIC(19,4)
                     AddParam Envia, iCorrelOpera            '22@CorrelOpera       NUMERIC
                     If Not Bac_Sql_Execute("SP_EXCEL_CARGASOMA", Envia) Then
                        MsgBox "Problemas al tratar de cargar Archivo Excel Tabla CARGASOMA", 64, Me.Caption
                        ResultSOMA = False
                        Exit Sub
                     End If

                     Call Llenar_Grilla_SOMA(celda3, FmtNumero(celda4, ExcMIL, ExcDEC, MaqDEC, MaqMIL), FmtNumero(celda6, ExcMIL, ExcDEC, MaqDEC, MaqMIL), FmtNumero(celda5, ExcMIL, ExcDEC, MaqDEC, MaqMIL), FmtNumero(celda10, ExcMIL, ExcDEC, MaqDEC, MaqMIL), iCorrelOpera, mensaje, CambioOper, TipoCorte)
                     CambioOper = False
                  End If

                  T_Int_Celda = T_Int_Celda + 1
               Next I
            End If
            ireg = ireg + 1
            J = J + 1
         Next

         If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
            GoTo BacErrorHandler
         End If

         ObjLibro.Close
         ObjExcel.Quit
         Set ObjExcel = Nothing
      End If
   End If

   Screen.MousePointer = Default

Exit Sub
ErrorExcel:

   Resume Next
   MsgBox "Problemas con el Archivo Excel. Verifique que el Archivo sea correcto, tenga 1 Hoja llamada 'Creditos' y que la Información sea Correcta y luego vuelva a Intentar", 64
   ObjLibro.Close
   ObjExcel.Quit
   Set ObjExcel = Nothing
   Screen.MousePointer = Default
   ResultSOMA = False
Exit Sub
Sale:

   Screen.MousePointer = Default
   ObjLibro.Close
   ObjExcel.Quit
   Set ObjExcel = Nothing
Exit Sub
BacErrorHandler:

   If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
      MsgBox " NO SE PUDO REALIZAR ROLLBACK", vbExclamation, gsBac_Version
   End If
   ObjLibro.Close
   ObjExcel.Quit
   Set ObjExcel = Nothing
   Screen.MousePointer = Default
   ResultSOMA = False
Exit Sub
ErrorExcell:

   Let Me.MousePointer = vbDefault
   Let Screen.MousePointer = vbDefault
   Let Toolbar1.Enabled = True

   If err.Number = 32755 Then
      ResultSOMA = False
      Exit Sub
   End If
End Sub

Private Sub Carga_Cartera_Consolidada() 'mgc-cargasoma
   Dim Datos()

   If miSQL.SQL_Execute(Param_sp) <> 0 Then
      MsgBox "Problemas al Buscar Instrumnetos", 64, Me.Caption
      Exit Sub
   End If
   x = 1
   Do While Bac_SQL_Fetch(Datos())
      If Trim(Datos(42)) = "" Then 'que este disponible
         sInstrumento(x) = CStr(Datos(12))
         dNominal(x) = CStr(Datos(15))
         dTir(x) = CStr(Datos(16))
         sCustodia(x) = CStr(Datos(44))
         fCupon(x) = CStr(Datos(41))
         x = x + 1
      End If
   Loop
   iTotCartera = x
End Sub

Private Sub Busca_Correlativo_Operacion() 'mgc-cargasoma
   Dim Datos()

   If Not Bac_Sql_Execute("SP_ENTREGA_CORREL_SOMA") Then
      Exit Sub
   End If
   Do While Bac_SQL_Fetch(Datos())
      iCorrelOpera = Datos(1)
   Loop
End Sub

Private Sub Func_Setear_GrillaSOMA()
   Dim icol          As Integer

   With Table_CargaSOMA
      .WordWrap = True
      .Rows = 1
      .Row = 0
      .RowHeight(0) = 500
      .TextMatrix(0, Col_SOMA_Corr) = "Correlativo"
      .TextMatrix(0, Col_SOMA_Serie) = "Serie"
      .TextMatrix(0, Col_SOMA_Nominal) = "Nominal"
      .TextMatrix(0, Col_SOMA_Tir) = "Tasa Referencial"
      .TextMatrix(0, Col_SOMA_PlzRes) = "Plazo Residual"
      .TextMatrix(0, Col_SOMA_ValInicial) = "Valor Inicial"
      .TextMatrix(0, Col_SOMA_NumOpe) = "Num. Operaciòn"
      .TextMatrix(0, Col_SOMA_Mensaje) = "Mensaje"
      .ColWidth(Col_SOMA_Corr) = 500
      .ColWidth(Col_SOMA_Serie) = 1500
      .ColWidth(Col_SOMA_Nominal) = 2000
      .ColWidth(Col_SOMA_Tir) = 1300
      .ColWidth(Col_SOMA_PlzRes) = 1300
      .ColWidth(Col_SOMA_ValInicial) = 2000
      .ColWidth(Col_SOMA_NumOpe) = 1500
      .ColWidth(Col_SOMA_Mensaje) = 3000
   End With
End Sub

Sub Llenar_Grilla_SOMA(ByVal p_Serie As String, ByVal p_Nominal, ByVal p_Tir As String, _
                       ByVal p_PlzRes As String, ByVal p_ValInicial As String, _
                       ByVal p_NumOpe As String, ByVal mensaje As String, ByVal CambioOper As Boolean, _
                       ByVal TipoCorte As String)
   
   On Error GoTo errorcuenta:
   Dim newRow  As Integer
   Dim cuenta  As Integer
   Dim AuxArr() As String

   With Table_CargaSOMA
      .Rows = .Rows + 1
      newRow = .Rows - 1
      .Row = newRow
      .TextMatrix(newRow, Col_SOMA_Corr) = newRow
      .TextMatrix(newRow, Col_SOMA_Serie) = p_Serie
      .TextMatrix(newRow, Col_SOMA_Nominal) = p_Nominal
      .TextMatrix(newRow, Col_SOMA_Tir) = p_Tir
      .TextMatrix(newRow, Col_SOMA_PlzRes) = p_PlzRes 'Format(datos(43), "##,##0")
      .TextMatrix(newRow, Col_SOMA_ValInicial) = p_ValInicial 'Format(datos(15), "#,##0.0000")
      .TextMatrix(newRow, Col_SOMA_NumOpe) = p_NumOpe 'Format(datos(16), "#,##0.0000")
      .TextMatrix(newRow, Col_SOMA_Mensaje) = mensaje
      .TextMatrix(newRow, Col_SOMA_TipoCorte) = TipoCorte
      
      If CambioOper = True Then
         cuenta = UBound(OperExcel) + 1
         ReDim Preserve OperExcel(cuenta)
         OperExcel(cuenta) = newRow & ";" & mensaje & ";" & p_NumOpe
      Else
         If mensaje <> "" Then
            AuxArr = Split(OperExcel(var_cantoper), ";")
            OperExcel(var_cantoper) = AuxArr(0) & ";" & mensaje & ";" & p_NumOpe
         End If
      End If
   End With

Exit Sub
errorcuenta:
   cuenta = 1
   Resume Next
End Sub

Sub RescataSeparadores(ByVal ValInicial, ByRef MaqMIL, ByRef MaqDEC, ByRef ExcMIL, ByRef ExcDEC, ByRef SQLDEC)

   MaqDEC = Mid(Format(0#, "0.0"), 2, 1)
   MaqMIL = IIf(MaqDEC = ",", ".", ",")
   If InStr(1, ValInicial, MaqDEC) > 0 Then
      ExcMIL = ","
      ExcDEC = IIf(ExcMIL = ",", ".", ",")
   End If
   SQLDEC = "."

End Sub

Private Function FmtNumero(ByVal ValNum, ByVal ExcMIL, ByVal ExcDEC, ByVal SQLDEC, Optional ByVal MaqMIL As Variant) As String

   ValNum = Replace(ValNum, ExcMIL, "")
   ValNum = Replace(ValNum, ExcDEC, SQLDEC)
   If Not IsMissing(MaqMIL) Then
      ValNum = Format(ValNum, "#,##0.0000")
   End If
   FmtNumero = ValNum

End Function

Private Function Validar_DatosSOMA() As Boolean
   Dim w_cont, w_contSOMA, w_contGrilla2, w_PosGrilla    As Integer
   Dim Resp                                              As Integer
   Dim AuxArr()                                          As String
   Dim AuxVenta()                                        As String
   Dim AuxNumOpe                                         As Integer
   Dim SOMA_Serie                                        As String
   Dim SOMA_Nominales                                    As String
   Dim SOMA_Tir                                          As String
   Dim SOMA_PlzRes                                       As String
   Dim SalidaOper, ValCuenta                             As Boolean
   Dim w_cuenta, w_i                                     As Integer
   Dim cont_Oper, cont_GrilSOMA, cont_GrilFLI            As Double
   Dim TipoCorte                                         As String

   Label_SOMA.Visible = True
   Progress_SOMA.Visible = True
   Label_SOMA.Caption = "Generar Pareo SOMA..."
   cont_Oper = (100 / var_cantoper)

   For w_cont = 1 To var_cantoper ' Operaciones
      Progress_SOMA.Value = Round(cont_Oper * w_cont, 0)
      AuxArr = Split(OperExcel(w_cont), ";")

      If AuxArr(1) = "" Then
         w_PosGrilla = Val(AuxArr(0)) 'Posicion de Grilla Donde Esta Operacion
         AuxNumOpe = AuxArr(2)
         SalidaOper = False
         Label_SOMA.Visible = True
         Progress_SOMA.Visible = True
         Label_SOMA.Caption = "Comparando Datos REPOS con Planilla Excel..."
         cont_GrilSOMA = (100 / (Table_CargaSOMA.Rows - 1))
         ValCuenta = True
         w_cuenta = 0

         For w_contSOMA = w_PosGrilla To Table_CargaSOMA.Rows - 1 ' Grilla SOMA

            Progress_SOMA.Value = Round(cont_GrilSOMA * w_contSOMA, 0)
            If (Trim(AuxNumOpe) <> Trim(Table_CargaSOMA.TextMatrix(w_contSOMA, Col_SOMA_NumOpe))) Then
               Exit For
            End If

            SOMA_Serie = Trim(Table_CargaSOMA.TextMatrix(w_contSOMA, Col_SOMA_Serie))
            SOMA_Nominales = Trim(Table_CargaSOMA.TextMatrix(w_contSOMA, Col_SOMA_Nominal))
            SOMA_Tir = Trim(Table_CargaSOMA.TextMatrix(w_contSOMA, Col_SOMA_Tir))
            SOMA_PlzRes = Trim(Table_CargaSOMA.TextMatrix(w_contSOMA, Col_SOMA_PlzRes))
            Correlativo_SOMA_RP = Trim(Table_CargaSOMA.TextMatrix(w_contSOMA, Col_SOMA_Corr))
            NumOper_SOMA_RP = Trim(Table_CargaSOMA.TextMatrix(w_contSOMA, Col_SOMA_NumOpe))
            TipoCorte = Trim(Table_CargaSOMA.TextMatrix(w_contSOMA, Col_SOMA_TipoCorte))
            
            With Table1
               Label_SOMA.Visible = True
               Progress_SOMA.Visible = True
               Label_SOMA.Caption = "Comparando Datos SOMA con REPOS..."
               cont_GrilFLI = (100 / (.Rows - 1))

               For w_contGrilla2 = 1 To .Rows - 1 ' Grilla Fli
                  If Trim(.TextMatrix(w_contGrilla2, Ven_RP_MARCA)) = "" Then
                     Progress_SOMA.Value = Round(cont_GrilFLI * w_contGrilla2, 0)
                     If ComparaMonto(SOMA_Serie, Trim(.TextMatrix(w_contGrilla2, Ven_RP_SERIE)), 2) Then
                        If ComparaMonto(SOMA_Nominales, Trim(.TextMatrix(w_contGrilla2, Ven_RP_NOMINAL)), 1, TipoCorte) Then
                           If ComparaMonto(SOMA_Tir, Trim(.TextMatrix(w_contGrilla2, Ven_RP_TIR)), 0) Then
                              If ComparaMonto(SOMA_PlzRes, Trim(.TextMatrix(w_contGrilla2, Ven_RP_PlzRes)), 0) Then
                                 ValVenta_RP = True
                                 .Row = w_contGrilla2
                                 .Col = Ven_RP_NOMINAL
                                 If ComparaMonto(SOMA_Nominales, Trim(.TextMatrix(w_contGrilla2, Ven_RP_NOMINAL)), 3) Then
                                    Text1.Text = SOMA_Nominales
                                    Call Text1_KeyDown(13, 0)
                                 Else
                                    Table1_KeyPress (86) 'Presiona V
                                 End If
                                 If ValVenta_RP Then
                                    If ValCuenta Then
                                       Erase AuxVenta
                                       w_cuenta = 1
                                       ValCuenta = False
                                       ReDim Preserve AuxVenta(w_cuenta)
                                    Else
                                       w_cuenta = UBound(AuxVenta) + 1
                                       ReDim Preserve AuxVenta(w_cuenta)
                                    End If
                                    AuxVenta(w_cuenta) = w_contGrilla2
                                 Else
                                    If w_cuenta > 0 Then
                                       For w_i = 1 To UBound(AuxVenta)
                                          .Row = AuxVenta(w_i)
                                          Table1_KeyPress (82) 'Presiona R
                                       Next w_i
                                    End If
                                    SalidaOper = True
                                 End If
                                 Exit For
                              End If
                           End If
                        End If
                     End If
                  End If
               Next w_contGrilla2
            End With

            If SalidaOper Then
               Exit For
            End If
         Next w_contSOMA

      Else

         Toolbar1.Buttons(10).Enabled = True 'Informe de Captura
         If w_cont < var_cantoper Then
            Resp = MsgBox("Esta Operación Presenta Errores, se da termino a la Carga" & Chr(13) & "Existen Otras Operaciones Disponibles ¿Desea Continuar?", vbYesNo, gsBac_Version)
            If Resp = 7 Then
                Exit For
            End If
         Else
            MsgBox "Esta Operación Presenta Errores, se da termino a la Carga", vbInformation, gsBac_Version
         End If

      End If
   
   Next w_cont

End Function

Private Function ComparaMonto(ByVal var_monto1 As String, ByVal var_monto2 As String, Cond As Integer, Optional TipoCorte As String) As Boolean
   Dim MaqDEC, MaqMIL As String * 1

   If IsMissing(TipoCorte) Then
      TipoCorte = ""
   End If

   MaqDEC = Mid(Format(0#, "0.0"), 2, 1)
   MaqMIL = IIf(MaqDEC = ",", ".", ",")
   var_monto1 = Replace(var_monto1, MaqMIL, "")
   var_monto2 = Replace(var_monto2, MaqMIL, "")
    
   If Cond = 0 Then
      If CDbl(var_monto1) = CDbl(var_monto2) Then
         ComparaMonto = True
      Else
         ComparaMonto = False
      End If
   Else
      If Cond = 1 Then
         If TipoCorte = "T" Then
            If CDbl(var_monto1) = CDbl(var_monto2) Then
               ComparaMonto = True
            Else
               ComparaMonto = False
            End If
         Else
            If CDbl(var_monto1) <= CDbl(var_monto2) Then
               ComparaMonto = True
            Else
               ComparaMonto = False
            End If
         End If
      Else
         If Cond = 2 Then
            If var_monto1 = var_monto2 Then
               ComparaMonto = True
            Else
               ComparaMonto = False
            End If
         Else
            If CDbl(var_monto1) < CDbl(var_monto2) Then
               ComparaMonto = True
            Else
               ComparaMonto = False
            End If
         End If
      End If
   End If

End Function

Sub Imprimir_Informe_Errores_SOMA()
   On Error GoTo ErrPrinter

   BacTrader.bacrpt.WindowState = crptMaximized
   BacTrader.bacrpt.ReportFileName = RptList_Path & "ObsCargaSoma.RPT"
   Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
   BacTrader.bacrpt.StoredProcParam(0) = Format$(gsBac_Fecp, "yyyymmdd")
   BacTrader.bacrpt.StoredProcParam(1) = "VI"
   BacTrader.bacrpt.Connect = CONECCION
   BacTrader.bacrpt.Action = 1
   BacTrader.bacrpt.Destination = 0

Exit Sub
ErrPrinter:
   MsgBox "Problemas en Impresión de Informe de Errores SOMA: " & err.Description, vbExclamation, gsBac_Version
End Sub

