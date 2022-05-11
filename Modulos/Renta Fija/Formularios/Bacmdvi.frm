VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacVI 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Venta con Pacto"
   ClientHeight    =   6255
   ClientLeft      =   540
   ClientTop       =   4260
   ClientWidth     =   12855
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmdvi.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   NegotiateMenus  =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6255
   ScaleWidth      =   12855
   Begin VB.Frame Frame1 
      Caption         =   "Total Operacion"
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
      Height          =   720
      Left            =   9840
      TabIndex        =   50
      Top             =   1575
      Width           =   3000
      Begin BACControles.TXTNumero TxtTotal 
         Height          =   330
         Left            =   105
         TabIndex        =   51
         Top             =   240
         Width           =   2730
         _ExtentX        =   4815
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
      Height          =   480
      Left            =   75
      TabIndex        =   40
      Top             =   1830
      Width           =   2820
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
         Left            =   615
         TabIndex        =   0
         TabStop         =   0   'False
         Top             =   195
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
         Left            =   1425
         TabIndex        =   1
         TabStop         =   0   'False
         Top             =   195
         Width           =   735
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   555
      Left            =   0
      TabIndex        =   38
      Top             =   0
      Width           =   12855
      _ExtentX        =   22675
      _ExtentY        =   979
      ButtonWidth     =   847
      ButtonHeight    =   820
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   8
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
      ItemData        =   "Bacmdvi.frx":030A
      Left            =   150
      List            =   "Bacmdvi.frx":0317
      Style           =   2  'Dropdown List
      TabIndex        =   36
      Top             =   3300
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
      Height          =   3390
      Left            =   45
      TabIndex        =   34
      TabStop         =   0   'False
      Top             =   2310
      Width           =   12795
      _ExtentX        =   22569
      _ExtentY        =   5980
      _Version        =   393216
      Cols            =   15
      FixedCols       =   2
      RowHeightMin    =   315
      BackColor       =   16777215
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorSel    =   8388608
      FocusRect       =   0
      GridLines       =   2
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
      Height          =   1305
      Index           =   0
      Left            =   75
      TabIndex        =   7
      Top             =   525
      Width           =   2835
      _Version        =   65536
      _ExtentX        =   5001
      _ExtentY        =   2302
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
         TabIndex        =   28
         TabStop         =   0   'False
         Top             =   960
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
         TabIndex        =   27
         TabStop         =   0   'False
         Top             =   645
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
         TabIndex        =   26
         TabStop         =   0   'False
         Top             =   300
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
         TabIndex        =   17
         Top             =   240
         Width           =   1095
         _Version        =   65536
         _ExtentX        =   1931
         _ExtentY        =   556
         _StockProps     =   15
         Caption         =   "Miércoles"
         ForeColor       =   16711680
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
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
         TabIndex        =   9
         Top             =   690
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
         TabIndex        =   8
         Top             =   990
         Width           =   375
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1785
      Index           =   1
      Left            =   2925
      TabIndex        =   10
      Top             =   525
      Width           =   3735
      _Version        =   65536
      _ExtentX        =   6588
      _ExtentY        =   3149
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
         TabIndex        =   3
         Top             =   300
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
         TabIndex        =   5
         Top             =   1065
         Width           =   870
         _ExtentX        =   1535
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
         Max             =   "9999999999.9999"
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero TxtTasa 
         Height          =   300
         Left            =   2745
         TabIndex        =   4
         Top             =   690
         Width           =   870
         _ExtentX        =   1535
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
         ItemData        =   "Bacmdvi.frx":0331
         Left            =   840
         List            =   "Bacmdvi.frx":033E
         Style           =   2  'Dropdown List
         TabIndex        =   24
         Top             =   2325
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
         TabIndex        =   2
         Top             =   300
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
         Height          =   195
         Left            =   2130
         TabIndex        =   39
         Top             =   360
         Width           =   345
      End
      Begin VB.Label Label 
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
         Left            =   120
         TabIndex        =   14
         Top             =   750
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
         TabIndex        =   13
         Top             =   2460
         Width           =   435
      End
      Begin VB.Label Label 
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
         Left            =   120
         TabIndex        =   12
         Top             =   1095
         Width           =   540
      End
      Begin VB.Label Label 
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
         TabIndex        =   11
         Top             =   345
         Width           =   690
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1050
      Index           =   2
      Left            =   9810
      TabIndex        =   15
      Top             =   525
      Width           =   3015
      _Version        =   65536
      _ExtentX        =   5318
      _ExtentY        =   1852
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
         Left            =   495
         TabIndex        =   29
         Top             =   675
         Width           =   2370
         _ExtentX        =   4180
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
         TabIndex        =   6
         Top             =   300
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
         Height          =   240
         Left            =   255
         TabIndex        =   18
         Top             =   315
         Width           =   1140
         _Version        =   65536
         _ExtentX        =   2011
         _ExtentY        =   423
         _StockProps     =   15
         Caption         =   "Miércoles"
         ForeColor       =   16711680
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.24
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
         Left            =   90
         TabIndex        =   16
         Top             =   720
         Width           =   345
      End
   End
   Begin Threed.SSCommand CmdTipoFiltro 
      Height          =   450
      Left            =   4050
      TabIndex        =   25
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
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvi.frx":0350
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvi.frx":07A2
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvi.frx":0ABC
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvi.frx":0F0E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvi.frx":389C8
            Key             =   "S"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvi.frx":38E1A
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdvi.frx":39134
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame FrmMontos 
      Height          =   600
      Left            =   15
      TabIndex        =   19
      Top             =   5640
      Width           =   12810
      Begin BACControles.TXTNumero TXTSALDO 
         Height          =   315
         Left            =   10830
         TabIndex        =   33
         TabStop         =   0   'False
         Top             =   195
         Width           =   1950
         _ExtentX        =   3440
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
         Left            =   7440
         TabIndex        =   32
         TabStop         =   0   'False
         Top             =   195
         Width           =   1950
         _ExtentX        =   3440
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
         Left            =   4080
         TabIndex        =   31
         TabStop         =   0   'False
         Top             =   195
         Width           =   1950
         _ExtentX        =   3440
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
         Width           =   1950
         _ExtentX        =   3440
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
         Left            =   10035
         TabIndex        =   23
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
         Left            =   6645
         TabIndex        =   22
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
         Left            =   3225
         TabIndex        =   21
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
         TabIndex        =   20
         Top             =   195
         Width           =   795
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1770
      Index           =   3
      Left            =   6675
      TabIndex        =   41
      Top             =   525
      Width           =   3105
      _Version        =   65536
      _ExtentX        =   5477
      _ExtentY        =   3122
      _StockProps     =   14
      Caption         =   "Transferencia"
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
      Begin BACControles.TXTNumero Txt_VFTran 
         Height          =   300
         Left            =   1395
         TabIndex        =   42
         Top             =   660
         Width           =   1650
         _ExtentX        =   2910
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "04"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero Txt_TasaTran 
         Height          =   315
         Left            =   2025
         TabIndex        =   43
         Top             =   300
         Width           =   1005
         _ExtentX        =   1773
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
      End
      Begin BACControles.TXTNumero Txt_DifTran 
         Height          =   300
         Left            =   1395
         TabIndex        =   44
         Top             =   1020
         Width           =   1650
         _ExtentX        =   2910
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "04"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero Txt_Dif_CLP 
         Height          =   300
         Left            =   1395
         TabIndex        =   48
         Top             =   1380
         Width           =   1650
         _ExtentX        =   2910
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
         Min             =   "-9999999999999999"
         Separator       =   -1  'True
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Resultado CLP"
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
         Index           =   10
         Left            =   60
         TabIndex        =   49
         Top             =   1425
         Width           =   1275
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Val. Fin. Trans."
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
         Index           =   9
         Left            =   60
         TabIndex        =   47
         Top             =   690
         Width           =   1320
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Tasa Trans."
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
         Left            =   60
         TabIndex        =   46
         Top             =   330
         Width           =   1035
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Resultado"
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
         Index           =   7
         Left            =   60
         TabIndex        =   45
         Top             =   1050
         Width           =   870
      End
   End
End
Attribute VB_Name = "BacVI"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim u                           As Integer
Dim Monto                       As Double
Dim Tecla                       As String
Dim FormHandle                  As Long
Dim iFlagKeyDown                As Integer
Dim bufNominal                  As Double
Dim bufRutCart                  As Long
Dim sFecPro                     As String
Dim sFiltro                     As String
Dim nRutCartV                   As String
Dim cDvCartV                    As String
Dim cNomCartV                   As String
Dim dTipcam#
Dim dMonMx                      As String
Dim Color                       As String
Dim colorletra                  As String
Dim z                           As Integer
Dim filita                      As Integer
Dim bold                        As String
Dim columnita                   As Integer
Dim k                           As Integer

Public nDolarOb                 As Double
Public nUf                      As Double
Public FiltraVentaAutomatico    As Boolean

Public glBacCpDvpVi             As DvpCp


'constantes de posicion de datos en arreglo de consulta para
'procedimiento SP_FILTRARCART_VI
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

Private Sub Command1_Click()
    FRM_FILTRO_VCPACTO.Show
End Sub

Private Sub OptDvp_Click(Index As Integer)
   Select Case Index
      Case 0
         glBacCpDvpVi = No
      Case 1
         glBacCpDvpVi = Si
   End Select
   Toolbar1.Enabled = True
   'Cuadrodvp.Enabled = False 'cass
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
       Table1.TextMatrix(Table1.Row, 8) = Trim(Text2.Text)
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

If KeyCode = 13 Then
      
      If Not Table1.Rows = 1 Then
        Call Colocardata1
      Else
         Data1.Recordset.MoveFirst
      End If
    
        If Table1.Col = 7 Then
            Data1.Recordset.Edit
            Select Case Combo1.ListIndex 'UCase$(Left(Combo1.Text, 1)) 'Chr(KeyCode))
                 Case 0:
                     Data1.Recordset("tm_custodia") = "CLIENTE"
                     Data1.Recordset("tm_clave_dcv") = " "
                     Table1.TextMatrix(Table1.Row, 7) = "CLIENTE"
                     Table1.TextMatrix(Table1.Row, 8) = ""
                     KeyCode = 13
                 Case "1":
                     Data1.Recordset("tm_custodia") = "DCV"
                     Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
                     Table1.TextMatrix(Table1.Row, 7) = "DCV"
                     Table1.TextMatrix(Table1.Row, 8) = Data1.Recordset("tm_clave_dcv")
                     KeyCode = 13
                 Case "2":
                     Data1.Recordset("tm_custodia") = "PROPIA"
                     Data1.Recordset("tm_clave_dcv") = " "
                     Table1.TextMatrix(Table1.Row, 7) = "PROPIA"
                     Table1.TextMatrix(Table1.Row, 8) = ""
                     
                     KeyCode = 13
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
Dim Fila As Integer

For Fila = 1 To Table1.Rows - 1
    If Table1.TextMatrix(Fila, 0) = "*" Then
        Color = &HC0C0C0
        colorletra = &HC0&
        bold = False
    End If
    If Table1.TextMatrix(Fila, 0) = "V" Then
        Color = &HFF0000
        colorletra = &HFFFFFF
        bold = True
    End If
    If Table1.TextMatrix(Fila, 0) = "P" Then
        Color = vbCyan
        colorletra = vbBlack
    End If
    If Table1.TextMatrix(Fila, 0) = "B" Then
       Color = vbBlack + vbWhite    'vbBlack
       colorletra = vbBlack
       bold = False
    End If
    If Table1.TextMatrix(Fila, 0) = " " Then
        Color = &HC0C0C0
        colorletra = &H800000
        bold = False
    End If
    
    Dim z%
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
      With Table1
         
         .TextMatrix(x, 0) = Data1.Recordset!tm_venta
         .TextMatrix(x, 1) = Data1.Recordset!TM_INSTSER
         If Trim(Data1.Recordset!TM_INSTSER) = "FMUTUO" Then
             .ColWidth(4) = 1800
         End If
         .TextMatrix(x, 2) = Data1.Recordset!TM_NEMMON
         .TextMatrix(x, 3) = Format(Data1.Recordset!tm_nominal, "#,##0.0000")
         .TextMatrix(x, 4) = Format(Data1.Recordset!TM_TIR, "#,##0.0000")
         .TextMatrix(x, 5) = Format(Data1.Recordset!TM_Pvp, "#,##0.0000")
         .TextMatrix(x, 6) = Format(Data1.Recordset!TM_VP, "#,##0.0000")
         .TextMatrix(x, 7) = IIf(IsNull(Data1.Recordset!tm_custodia) = True, " ", Data1.Recordset!tm_custodia)
         .TextMatrix(x, 8) = IIf(IsNull(Data1.Recordset!tm_clave_dcv) = True, " ", Data1.Recordset!tm_clave_dcv)
         .TextMatrix(x, 9) = Format(Data1.Recordset!TM_tircomp, "#,##0.0000")
         .TextMatrix(x, 10) = Format(Data1.Recordset!TM_pvpcomp, "#,##0.0000")
         .TextMatrix(x, 11) = Format(Data1.Recordset!tm_vptirc, "#,##0.0000")
         .TextMatrix(x, 12) = Format(CDbl(Data1.Recordset!TM_VP) - CDbl(Data1.Recordset!tm_vptirc), "#,###,###,##0")
         
         Envia = Array()
         AddParam Envia, 1
         AddParam Envia, GLB_CARTERA_NORMATIVA
         AddParam Envia, GLB_ID_SISTEMA
         AddParam Envia, Trim(Data1.Recordset!tm_carterasuper)
                
         If Bac_Sql_Execute("SP_CON_INFO_COMBO", Envia) Then
           
             Do While Bac_SQL_Fetch(oDatos())
                 .TextMatrix(x, 13) = Trim(oDatos(6))
             Loop
         Else
             .TextMatrix(x, 13) = "NO ESPECIFICADO"
         End If
         
         .TextMatrix(x, 14) = IIf(IsNull(Data1.Recordset!tm_id_libro) = True, "", Trim(Data1.Recordset!tm_id_libro))
         
      End With
      'table1.Refresh
      Data1.Recordset.MoveNext
   
   Loop
   
   Call colores
   
   Table1.Col = 2
   Table1.Redraw = True

End Sub

Public Function Colocardata1()
  Dim I As Integer
  Monto = CDbl(Table1.TextMatrix(Table1.Row, 3))
  
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
            Txt_VFTran.CantidadDecimales = 0
            Txt_DifTran.CantidadDecimales = 0
        Else
            txtIniPMP.CantidadDecimales = BacDatGrMon.mndecimal
            txtVenPMP.CantidadDecimales = BacDatGrMon.mndecimal
            Txt_VFTran.CantidadDecimales = BacDatGrMon.mndecimal
            Txt_DifTran.CantidadDecimales = BacDatGrMon.mndecimal
        End If
        
        If giMonLoc <> CmbMon.ItemData(CmbMon.ListIndex) Then
            sFecPro = Str(gsBac_Fecp)
            dTipcam# = funcBuscaTipcambio(CmbMon.ItemData(CmbMon.ListIndex), sFecPro)
            
            If dTipcam# = 0 And CmbMon.ItemData(CmbMon.ListIndex) <> 13 Then
                nResp = MsgBox("Tipo de cambio para : " & NemMon & " con fecha " & gsBac_Fecp & Chr(10) & Chr(13) & " NO ha sido ingresado." & Chr(10) & Chr(13) & " Desea Ingresarlo ? ", vbExclamation + vbYesNo, TITSISTEMA)
                                
                If nResp = 6 Then
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

If Table1.Row = 0 Then Exit Sub 'insertado05/02/2001
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

   Nominal# = CDbl(Table1.TextMatrix(Table1.Row, Ven_NOMINAL))
   bufNominal = Val(Data1.Recordset("tm_nominalo"))
  
   If Nominal = 0 Then
      Exit Sub
   End If
    
   If VENTA_VerDispon(FormHandle, Data1) = False Then
      Exit Sub
   End If

   Set BacFrmIRF = Me
    
   BacControlWindows 30
   BacIrfCo.Show 1
   BacControlWindows 30
    
   If Not Table1.Row = 1 Then
      Call Colocardata1
   Else
      Data1.Recordset.MoveFirst
   End If
    
'   Data1.Recordset.Edit saque
'   Data1.Recordset!tm_nominal = TABLE1.TextMatrix(TABLE1.Row, Ven_NOMINAL) saque
'   text1.CantidadDecimales = 4 'wms saque
'   TEXT1.Text = CDbl(TABLE1.TextMatrix(TABLE1.Row, Ven_NOMINAL)) saque
'   Data1.Recordset.Update saque

   If Table1.TextMatrix(Table1.Row, 0) <> "N" Then
      Data1.Recordset.Edit 'puse
      Data1.Recordset!tm_nominal = Table1.TextMatrix(Table1.Row, Ven_NOMINAL) 'puse
      Text1.CantidadDecimales = 4 'wms puse
      Text1.Text = CDbl(Table1.TextMatrix(Table1.Row, Ven_NOMINAL)) 'puse
      Data1.Recordset.Update 'puse

    If Nominal# <> CDbl(Table1.TextMatrix(Table1.Row, Ven_NOMINAL)) Or Table1.TextMatrix(Table1.Row, 0) = "V" Then
       If Data1.Recordset!tm_venta <> "*" And Data1.Recordset!tm_venta <> " " Then Call VENTA_DesBloquear(FormHandle, Data1)
         If VENTA_Bloquear(FormHandle, Data1) Then
            Data1.Recordset.Edit
               If CDbl(Table1.TextMatrix(Table1.Row, Ven_NOMINAL)) < Nominal# Then
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

   Else 'puse
      Table1.TextMatrix(Table1.Row, 0) = " " 'wms puse
   End If
'   If TABLE1.TextMatrix(TABLE1.Row, 0) = "N" Then TABLE1.TextMatrix(TABLE1.Row, 0) = " " 'wms saque
'   Call Llenar_Grilla 'wms saque
'   TABLE1.Row = Fila 'wms saque
   Table1.Col = 3
'   Call Text1_KeyDown(13, 0) 'wms saque
'   TABLE1.SetFocus 'wms saque

End Sub


Sub Emite()
If Table1.Row = 0 Then Exit Sub 'insertado05/02/2001
    BacControlWindows 100
    If Data1.Recordset.RecordCount = 0 Then
        Exit Sub
    End If
   ' If Data1.Recordset.EOF = True Then
   '     Exit Sub
   ' End If
    
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
     BacControlWindows 50
    'Guarda datos en variable global
    With BacDatEmi
         BacControlWindows 100
        .sInstSer = Data1.Recordset("tm_instser")
        .lRutemi = Data1.Recordset("tm_rutemi")
        .iMonemi = Data1.Recordset("tm_monemi")
        .sFecEmi = Data1.Recordset("tm_fecemi")
        .sFecvct = Data1.Recordset("tm_fecven")
        .dTasEmi = Data1.Recordset("tm_tasemi")
        .iBasemi = Data1.Recordset("tm_basemi")
        
        .sFecpcup = Data1.Recordset("tm_fecpcup")
        .dNumoper = Data1.Recordset("tm_numdocu")
        .sTipOper = Data1.Recordset("tm_tipoper")
        .sFecvtop = Data1.Recordset("tm_fecsal")
        .iDiasdis = DateDiff("d", gsBac_Fecp, CDate(Data1.Recordset("tm_fecsal")))
        BacControlWindows 200
    End With
    
    BacIrfDg.varPsSeriado = Data1.Recordset("tm_mdse")
    
    BacIrfDg.Tag = "VI"
    BacIrfDg.Show 1
    
    BacControlWindows 12
    Table1.SetFocus

End Sub

Sub Filtrar()
Dim Datos()
Dim Envia1 As Variant
Dim oContador  As Long
oContador = 1
    If Not FiltraVentaAutomatico Then
        BacIrfSl.ProTipOper = "VI"
'        If OptPesos.Value Then
'            BacIrfSl.cFiltroDolar = "P"
'        Else
'            BacIrfSl.cFiltroDolar = "D"
'        End If
        BacIrfSl.oFiltroDVP = glBacCpDvpVi
'        BacIrfSl.Show vbModal 'cass
       FRM_FILTRO_VCPACTO.Show vbModal
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
        
        BacVI.cCodCartFin = Trim(Right(Envia(Pos_CartFin), 10))
        BacVI.cCodLibro = Trim(Right(Envia(Pos_Libro), 10))
        
        AddParam Envia, glBacCpDvpVi
        
        Data1.Refresh
      
        Screen.MousePointer = vbKeyReturn
  
'         If Bac_Sql_Execute("SP_FILTRARCART_VI", Envia) Then
         If Bac_Sql_Execute("SP_FILTRARCARTERA_VI", Envia) Then 'cass
            sFiltro = gSQL
            Table1.Rows = 2
            Do While Bac_SQL_Fetch(Datos())
               If Datos(12) <> "" Then
                  Call VENTA_Agregar(Data1, Datos(), Hwnd, "VI")
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

Private Sub cmdlimpiar_Click()

End Sub

Sub Restaura()
On Error Resume Next

If Table1.Row = 0 Then
    Exit Sub 'insertado05/02/2001
End If

If Trim(Table1.TextMatrix(Table1.Row, 0)) = "" Then
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
        Call VENTA_Restaurar(Data1)
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
            'CmdTipoFiltro.Caption = "Ver Sel."
        Data1.RecordSource = "SELECT * FROM mdventa WHERE tm_hwnd = " & Hwnd & " AND tm_diasdisp >= " & txtplazo.Text
        Data1.Refresh
    Else
        filita = Table1.Row
        If TxtTotal.Text > 0 Then
         Toolbar1.Buttons(6).Tag = "Ver Todos"
         Toolbar1.Buttons(6).ToolTipText = "Ver Todos"
            'CmdTipoFiltro.Caption = "Ver Todos"
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
    'Table1.SetFocus
 
End Sub

Sub Vende()
'Dim z As Integer
If Table1.Row = 0 Then
      Exit Sub 'insertado 05/02/2001
End If

If Trim(Table1.TextMatrix(Table1.Row, 0)) <> "" Then
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
                        Table1.TextMatrix(Table1.Row, 8) = Data1.Recordset("tm_clave_dcv")
                    Else
                        Data1.Recordset.Edit
                        Data1.Recordset("tm_venta") = "*"
                        Data1.Recordset.Update
                    End If
                End If
            End If
        End If
      
        TxtTotal.Text = VENTA_SumarTotal(FormHandle)
        Table1.TextMatrix(Table1.Row, 0) = Data1.Recordset!tm_venta
        Call colores
    '    KeyAscii = 0
   If filita <= Table1.Rows - 1 Then
    Table1.Row = filita
   Else
    Table1.Row = Table1.Rows - 1
   End If

    Table1.Col = 2
    Table1.SetFocus

End Sub

Private Sub data1_Error(DataErr As Integer, Response As Integer)

    'No Current Record
    If DataErr = 3021 Then
        DataErr = 0
        Response = 0
    End If
    
End Sub

Private Sub Form_Activate()
    Me.Tag = "VI"
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
'    OptPesos.Enabled = True
'    OptPesos.Enabled = True

'    BacCentrarPantalla Me
    
    Exit Sub

BacErrHnd:
    
    Screen.MousePointer = vbDefault
    On Error GoTo 0
    Exit Sub
    
End Sub
Private Sub Form_KeyPress(KeyAscii As Integer)

    If KeyAscii = vbKeyReturn Then
        KeyAscii = 0
        'txtplazo.SetFocus
        SendKeys "{TAB}"
    End If
    
End Sub
Sub Nombres_Grilla()
  ' Configurar las columnas de la grid.-
    Table1.TextMatrix(0, 0) = "M"
    Table1.TextMatrix(0, 1) = "Serie"
    Table1.TextMatrix(0, 2) = "UM"
    Table1.TextMatrix(0, 3) = "Nominal"
    Table1.TextMatrix(0, 4) = "%Tir"
    Table1.TextMatrix(0, 5) = "%Vpar"
    Table1.TextMatrix(0, 6) = "Valor Presente"
    Table1.TextMatrix(0, 7) = "Custodia"
    Table1.TextMatrix(0, 8) = "Clave DCV"
    Table1.TextMatrix(0, 9) = "%Tir C."
    Table1.TextMatrix(0, 10) = "%Vpar C."
    Table1.TextMatrix(0, 11) = "Valor de Compra"
    Table1.TextMatrix(0, 12) = "Utilidad"
    Table1.TextMatrix(0, 13) = "Categoria Cartera Super"
    Table1.TextMatrix(0, 14) = "Codigo Libro"
    Table1.ColWidth(0) = 400
    Table1.ColWidth(1) = 1500
    Table1.ColWidth(2) = 500
    Table1.ColWidth(3) = 1800
    Table1.ColWidth(4) = 900
    Table1.ColWidth(5) = 900
    Table1.ColWidth(6) = 2800 'antes 1800
    Table1.ColWidth(7) = 1200
    Table1.ColWidth(8) = 1200
    Table1.ColWidth(9) = 900
    Table1.ColWidth(10) = 900
    Table1.ColWidth(11) = 1800
    Table1.ColWidth(12) = 0 '2500
    Table1.ColWidth(13) = 0 '2500
    Table1.ColWidth(14) = 0

End Sub

Private Sub Form_Load()
Dim nSw%
Dim nCont%

    Screen.MousePointer = vbKeyReturn
    Me.Top = 0
    Me.Left = 0
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
   
    TxtTotal.Enabled = False
    
    Call funcFindMonVal(CmbMon, CmbBase, "VI")
    
    If CmbMon.ListCount > -1 Then
      CmbMon.ListIndex = 0
    End If
    
    TxtFecIni.Text = Format$(gsBac_Fecp, "dd/mm/yyyy")
    
    nSw = 0
    nCont = 1
    
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
    Call Proc_Consulta_Porcentaje_Transacciones("VI")
    
    Toolbar1.Buttons(6).Tag = "Ver Sel."
    Toolbar1.Buttons(6).Enabled = False
    Table1.Enabled = False
    TxtInv.Enabled = True
       
    Call LeeModoControlPT   'PRD-3860, modo silencioso
       
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

    Dim base%, Tasa#, ValIni#, Plazo&, TasaTran#

    base = funcBaseMoneda(CmbMon.ItemData(CmbMon.ListIndex))

    Plazo = CDbl(txtplazo.Text)
    If Plazo = 0 Then Exit Sub
       
    ValIni = CDbl(txtIniPMP.Text)
    If ValIni = 0 Then Exit Sub
        
    Tasa = CDbl(TxtTasa.Text)
    TasaTran = CDbl(Txt_TasaTran.Text)
    
    If Tasa = 0 Then Exit Sub
   
    If CmbMon.ItemData(CmbMon.ListIndex) = 999 Then
        txtVenPMP.CantidadDecimales = 0
    Else
        txtVenPMP.CantidadDecimales = BacDatGrMon.mndecimal
    End If

    If dTipcam# = 1 Then
      txtVenPMP.Text = BacCtrlTransMonto(Int(VI_ValorFinal(ValIni#, Tasa#, Plazo&, base%)))
      Txt_VFTran.Text = BacCtrlTransMonto(Int(VI_ValorFinal(ValIni#, TasaTran#, Plazo&, base%)))
    Else
      txtVenPMP.Text = BacCtrlTransMonto(VI_ValorFinal(ValIni#, Tasa#, Plazo&, base%))
      Txt_VFTran.Text = BacCtrlTransMonto(VI_ValorFinal(ValIni#, TasaTran#, Plazo&, base%))
    End If
   
    Txt_DifTran.Text = (txtVenPMP.Text - Txt_VFTran.Text) / (1 + TasaTran / 100 * Plazo / 360)
        
   If dTipcam# = 1 Then
      Txt_Dif_CLP.Text = Txt_DifTran.Text
   Else
      Txt_Dif_CLP.Text = Txt_DifTran.Text * dTipcam#
   End If

    
 
End Sub


 Sub Graba()

    If Not Proc_Valida_Tasa_Transferencia(CDbl(TxtTasa.Text), CDbl(Txt_TasaTran.Text)) Then
        Txt_TasaTran.SetFocus
        Exit Sub
    End If
    
    BacIrfGr.proMoneda = Trim$(Mid$(CmbMon.Text, 1, 3))
    BacIrfGr.proMtoOper = TxtTotal.Text
    BacIrfGr.proHwnd = Hwnd
    BacIrfGr.cCodLibro = BacVI.cCodLibro
    BacIrfGr.cCodCartFin = BacVI.cCodCartFin
   
    TxtFecVct_LostFocus
    
    BacIrfGr.oValorDVP = "glBacCpDvpVi"
    BacIrfGr.oDVP = glBacCpDvpVi
    Call BacGrabarTX
     
    BacControlWindows 100
     
    If Grabacion_Operacion Then
        FiltraVentaAutomatico = True
        giAceptar = True
        Call TipoFiltro
        Me.Tag = "VI"
        Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_20400", "01", "Graba Ventas Con Pacto", "", "", " ")
    End If
     
End Sub



Private Sub Table1_ColumnChange()
    iFlagKeyDown = True
End Sub

Private Sub Table1_EnterEdit()

    iFlagKeyDown = False
    
    If Table1.Col = Ven_NOMINAL Then
        bufNominal = Val(Data1.Recordset("tm_nominalo"))
    End If
        
End Sub


Private Sub ChkMoneda(Columna%)
Dim MonLiq As Integer
Dim Mt#, MtMl#, TcMl#

    'Recupera Moneda de Liquidación
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
        'Divido por el tipo de cambio
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

Private Sub Table1_FetchAttributes(Status As Integer, Split As Integer, Row As Long, Col As Integer, FgColor As Long, BgColor As Long, FontStyle As Integer)

'    If Col = TABLE1.Col And Row = TABLE1.Row Then
'        FgColor = BacToolTip.Color_Dest.ForeColor
'        BgColor = BacToolTip.Color_Dest.BackColor
'    Else
'
'        If Data1.Recordset.RecordCount > 0 Then
'            If TABLE1.TextMatrix(TABLE1.Row, Ven_MARCA) = "V" Then
'                FgColor = BacToolTip.Color_VentaNormal.ForeColor
'                BgColor = BacToolTip.Color_VentaNormal.BackColor
'            ElseIf TABLE1.TextMatrix(TABLE1.Row, Ven_MARCA) = "P" Then
'                    FgColor = BacToolTip.Color_ParcialED.ForeColor
'                    BgColor = BacToolTip.Color_ParcialED.BackColor
'            ElseIf TABLE1.TextMatrix(TABLE1.Row, Ven_MARCA) = "*" Then
'                    FgColor = BacToolTip.Color_Bloqueado.ForeColor
'                    BgColor = BacToolTip.Color_Bloqueado.BackColor
'            ElseIf (Col > 0 And Col < 4) Or Col > 7 Then
'                FgColor = BacToolTip.Color_No_Edit.ForeColor
'                BgColor = BacToolTip.Color_No_Edit.BackColor
'            Else
'                FgColor = BacToolTip.Color_Normal.ForeColor
'            End If
'
'        End If
'
'    End If

End Sub

Private Sub Table1_DblClick()

If Table1.Col = 7 And (Table1.TextMatrix(Table1.Row, 0) = "V" Or Table1.TextMatrix(Table1.Row, 0) = "P") Then
    Combo1.Visible = True
    Combo1.SetFocus
End If

End Sub

Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)
 columnita = Table1.Col

 If KeyCode = vbKeyReturn And KeyCode <> vbKeyV And KeyCode <> vbKeyR _
                 And KeyCode <> vbKeyF7 And KeyCode <> vbKeyF3 _
                 And Table1.Col > 2 And Table1.Col < 7 Then

    Table1.Col = columnita
        
'''''    Call PROC_POSI_TEXTO(Table1, text1)

    Text1.Visible = True

    If KeyCode > 47 And KeyCode < 58 Then
        Text1.Text = Chr(KeyCode)
        Text1.SelStart = 1
    End If
    
    If KeyCode = vbKeyReturn Then
        Text1.Text = CDbl(Table1.TextMatrix(Table1.Row, Table1.Col))
    End If
    
    Text1.SetFocus
    Exit Sub
 End If
 
 If KeyCode = vbKeyReturn Then
    BacControlWindows 100
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
   
Dim I       As Integer
Dim OldReg As Double
filita = Table1.Row

If Table1.Col = 8 And Trim(Table1.TextMatrix(Table1.Row, 7)) = "DCV" And (Trim(Table1.TextMatrix(Table1.Row, 0)) = "V" Or Trim(Table1.TextMatrix(Table1.Row, 0)) = "P") Then
     
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

If KeyAscii <> vbKeyV And KeyAscii <> vbKeyR And KeyAscii <> vbKeyF7 _
                  And KeyAscii <> vbKeyF3 And Table1.Col = 7 _
                  And (Table1.TextMatrix(Table1.Row, 0) = "V" _
                  Or Table1.TextMatrix(Table1.Row, 0) = "P") Then
                  
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
    
    If KeyAscii <> vbKeyV And KeyAscii <> vbKeyR And Table1.Col > 2 _
                      And Table1.Col < 7 Then
                      
            If Table1.Col = Ven_NOMINAL Or Table1.Col = Ven_TIR Or Table1.Col = Ven_VPAR Then
                Text1.CantidadDecimales = 4
            ElseIf Table1.Col = Ven_VPS Then
                   Text1.CantidadDecimales = 2
            Else
                Text1.CantidadDecimales = 0
            End If
            
            Table1.Col = columnita
'''''            Call PROC_POSI_TEXTO(Table1, text1)
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
       If Data1.Recordset.BOF <> True Then           

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
     
    
    
    If KeyAscii = 27 Then
       iFlagKeyDown = True
       Exit Sub
    End If
    
    If KeyAscii <> 82 And KeyAscii <> 86 Then
       Select Case Table1.Col
            Case Ven_NOMINAL, Ven_VPS
              If Not iFlagKeyDown Then
                 KeyAscii = BacPunto(Table1, KeyAscii, 12, 4)
              End If
              KeyAscii = BACValIngNumGrid(KeyAscii)
            
            Case Ven_TIR, Ven_VPAR
            
              If Not iFlagKeyDown Then
                 KeyAscii = BacPunto(Table1, KeyAscii, 3, 4)
              End If
              KeyAscii = BACValIngNumGrid(KeyAscii)
       End Select
    End If
                 
        
' Tecla "R" - Restaura
If KeyAscii = 82 Then
   
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
''VGS    TxtTotal.Text = Calcula_Monto_Mx(CDbl(VENTA_SumarTotal(FormHandle)), Data1.Recordset!TM_monemi, 999)
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
    KeyAscii = 0
    
 'End If

ElseIf Data1.Recordset("tm_venta") = "B" Then
   If VENTA_DesBloquear(0, Data1) Then
      Data1.Recordset.Edit
      Data1.Recordset("tm_venta") = " "
      Data1.Recordset.Update

      Call VENTA_Restaurar(Data1)

      Table1.TextMatrix(Table1.Row, 0) = Data1.Recordset("tm_venta")

      For I = 0 To Table1.Cols - 1
         Table1.Col = I
         Call Table1_LeaveCell

      Next I

   End If

 End If
End If
    
    ' Tecla "V" - Venta
If KeyAscii = 86 Then
   Table1.ScrollBars = flexScrollBarNone
      
   If glBacCpDvpVi = Si Then
      Dim oContador  As Long
      Dim oFilas     As Long
      For oFilas = 1 To Table1.Rows - 1
         If Table1.TextMatrix(oFilas, 0) = "V" Then
            oContador = oContador + 1
         End If
      Next oFilas
      
   End If 'cass
   
   If VENTA_VerDispon(FormHandle, Data1) Then
      If Data1.Recordset("tm_venta") = " " Or Data1.Recordset("tm_venta") = "*" Or Data1.Recordset("tm_venta") = "B" Then
         If VENTA_Bloquear(FormHandle, Data1) Then
            Data1.Recordset.Edit
            Data1.Recordset("tm_venta") = "V"
            If Mid(Data1.Recordset("tm_custodia"), 1, 1) = "D" Then
               Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
            Else
               Data1.Recordset("tm_clave_dcv") = ""
            End If
                        
            Data1.Recordset.Update
            Table1.TextMatrix(Table1.Row, 8) = Data1.Recordset("tm_clave_dcv")

         Else
            Data1.Recordset.Edit
            Data1.Recordset("tm_venta") = "*"
            Data1.Recordset.Update
         End If
      End If
   End If
   
   TxtTotal.Text = VENTA_SumarTotal(FormHandle)
''VGS   TxtTotal.Text = Calcula_Monto_Mx(CDbl(VENTA_SumarTotal(FormHandle)), Data1.Recordset!TM_monemi, 999)
   If Data1.Recordset.BOF = True Then
     Else
     Table1.TextMatrix(Table1.Row, 0) = Data1.Recordset("tm_venta")
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

            Table1.TextMatrix(Table1.Row, 0) = Data1.Recordset("tm_venta")

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
    
    'Para que el datos aparezca en la grid
    BacControlWindows 60
    
    If Columna = Ven_NOMINAL Then
        If VENTA_VerDispon(FormHandle, Data1) Then
            If CDbl(Table1.TextMatrix(Table1.Row, Ven_NOMINAL)) <> Data1.Recordset("tm_nominalo") Then
                If CDbl(Table1.TextMatrix(Table1.Row, Ven_NOMINAL)) > bufNominal Then
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
                    
                    Call VENTA_Restaurar(Data1)
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
        
                        Call VENTA_Restaurar(Data1)
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
        
        If CDbl(Table1.TextMatrix(Table1.Row, Ven_TIR)) <> 0 Then
            Call VENTA_Valorizar(2, Data1)
        ElseIf CDbl(Table1.TextMatrix(Table1.Row, Ven_VPAR)) <> 0 Then
            Call VENTA_Valorizar(1, Data1)
        ElseIf CDbl(Table1.TextMatrix(Table1.Row, Ven_VPS)) <> 0 Then
            Call VENTA_Valorizar(3, Data1)
        End If
   
    ElseIf Columna = Ven_TIR Then
            Call VENTA_Valorizar(2, Data1)
    ElseIf Columna = Ven_VPAR Then
            Call VENTA_Valorizar(1, Data1)
    ElseIf Columna = Ven_VPS Then
            Call VENTA_Valorizar(3, Data1)
    End If
    
    BacControlWindows 12
    Call ChkMoneda(Columna%)
    BacControlWindows 12

    If Columna > 3 And Columna < 13 Then
    
       'Chequea contra la moneda de liquidación
        Call ChkMoneda(Columna%)
        BacControlWindows 12
        
       'Sumar el total y desplegar.-
        TxtTotal.Text = VENTA_SumarTotal(FormHandle)
''VGS        TxtTotal.Text = Calcula_Monto_Mx(CDbl(VENTA_SumarTotal(FormHandle)), Data1.Recordset!TM_monemi, 999)
        
        If dTipcam = 0 Then
          txtIniPMP.Text = 0
        Else
          txtIniPMP.Text = Round(TxtTotal.Text / dTipcam#, IIf(Trim(CmbMon.Text) = "CLP", 0, BacDatGrMon.mndecimal))
        End If

    End If
    
    If Columna = Ven_NOMINAL Then
        SendKeys "{TAB 1}"
    ElseIf Columna = Ven_TIR Then
        SendKeys "{TAB 2}"
    ElseIf Columna = Ven_VPS Then
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
        If Table1.TextMatrix(Table1.Row, 0) = "V" Then
            Table1.CellBackColor = vbBlue
            Table1.CellForeColor = vbWhite
        ElseIf Table1.TextMatrix(Table1.Row, 0) = "P" Then
            Table1.CellBackColor = vbCyan
            Table1.CellForeColor = vbBlack
        ElseIf Table1.TextMatrix(Table1.Row, 0) = "*" Then
            Table1.CellBackColor = vbGreen + vbWhite    'vbBlack
            Table1.CellForeColor = vbWhite
        ElseIf Table1.TextMatrix(Table1.Row, 0) = "B" Then
            Table1.CellBackColor = vbBlack + vbWhite    'vbBlack
            Table1.CellForeColor = vbBlack
        Else
            Table1.CellBackColor = vbBlack
            Table1.CellForeColor = vbBlack

        End If
        Table1.CellFontBold = False

    End If

End Sub

Private Sub Table1_RowColChange()

'    Table1.CellBackColor = &H808000
'    Table1.CellForeColor = vbWhite

End Sub

Private Sub Table1_Scroll()
   Text1_LostFocus
End Sub

Private Sub Table1_SelChange()

'    If Table1.Row <> 0 Then
'        'TABLE1.CellBackColor = &H808000:
'        Table1.CellFontBold = True
'        If Table1.TextMatrix(Table1.Row, 0) = "V" Then
'            Table1.CellBackColor = vbBlue
'            Table1.CellForeColor = vbWhite
'        ElseIf Table1.TextMatrix(Table1.Row, 0) = "P" Then
'            Table1.CellBackColor = vbCyan
'            Table1.CellForeColor = vbBlack
'        ElseIf Table1.TextMatrix(Table1.Row, 0) = "*" Then
'            Table1.CellBackColor = vbGreen + vbWhite    'vbBlack
'            Table1.CellForeColor = vbWhite
'        Else
'            Table1.CellBackColor = vbBlack
'            Table1.CellForeColor = vbBlack
'
'        End If
'        Table1.CellFontBold = False
'
'    End If

End Sub

Private Sub Text1_GotFocus()
    
    Call PROC_POSI_TEXTO(Table1, Text1)

End Sub

Private Sub Text1_KeyDown(KeyCode As Integer, Shift As Integer)

If KeyCode = vbKeyEscape Then
    Text1_LostFocus
End If

Dim Fila As Integer
Dim Value As String
Dim Colum As Integer
Dim Anterior As Double
Fila = Table1.Row

If KeyCode = vbKeyReturn Then
    Antes_Flag = True
    TipO = "VI"
    Anterior = Table1.TextMatrix(Table1.Row, Table1.Col)
    Colum = Table1.Col
    BacControlWindows 100
    
    If Not Table1.Row = 1 Then
            Call Colocardata1
    Else
            Data1.Recordset.MoveFirst
    End If
    
        'enteredit
    BacControlWindows 100
    iFlagKeyDown = False
    
    If Table1.Col = Ven_NOMINAL Then
        bufNominal = CDbl(Data1.Recordset("tm_nominalo"))
    End If
    
    On Error GoTo ExitEditError

Dim Columna%

    Me.MousePointer = vbHourglass
    
    Columna = Table1.Col
    
    If Data1.Recordset.RecordCount = 0 Then
        Me.MousePointer = vbDefault
        Exit Sub
    End If

    Data1.Recordset.Edit
    BacControlWindows 100
    Table1.TextMatrix(Table1.Row, Table1.Col) = Text1.Text
    BacControlWindows 100
    
    
    If Columna = Ven_NOMINAL Then
        Data1.Recordset!tm_nominal = Text1.Text
        Data1.Recordset.Update
        
        If VENTA_VerDispon(FormHandle, Data1) Then
            If CDbl(Table1.TextMatrix(Table1.Row, Ven_NOMINAL)) <> Data1.Recordset("tm_nominalo") Then
                If CDbl(Table1.TextMatrix(Table1.Row, Ven_NOMINAL)) > bufNominal Then
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
                    
                    Call VENTA_Restaurar(Data1)
                    
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
                                'Data1.Recordset!tm_custodia = ""
                                Data1.Recordset.Update
                            End If
                        End If
        
                        Call VENTA_Restaurar(Data1)
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
            If Trim(Table1.TextMatrix(Table1.Row, 7)) = "DCV" And (Data1.Recordset!tm_venta = "V" Or Data1.Recordset!tm_venta = "P") Then
                 Data1.Recordset.Edit
                 Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
                 Data1.Recordset.Update
                 Table1.TextMatrix(Table1.Row, 8) = Data1.Recordset("tm_clave_dcv")
            End If
        End If
        
        If CDbl(Table1.TextMatrix(Table1.Row, Ven_TIR)) <> 0 Then
            Call VENTA_Valorizar(2, Data1)
        ElseIf CDbl(Table1.TextMatrix(Table1.Row, Ven_VPAR)) <> 0 Then
            Call VENTA_Valorizar(1, Data1)
        ElseIf CDbl(Table1.TextMatrix(Table1.Row, Ven_VPS)) <> 0 Then
            Call VENTA_Valorizar(3, Data1)
        End If
        BacControlWindows 100
    
    ElseIf Columna = Ven_TIR Then
            Data1.Recordset!TM_TIR = Text1.Text
            Data1.Recordset.Update
            Call VENTA_Valorizar(2, Data1)
            Table1.SetFocus
            
    ElseIf Columna = Ven_VPAR Then
            Data1.Recordset!TM_Pvp = Text1.Text
            Data1.Recordset.Update
            Call VENTA_Valorizar(1, Data1)
            If Not Antes_Flag Then
                Table1.TextMatrix(Table1.Row, Table1.Col) = Anterior
                Data1.Recordset.Edit
                Data1.Recordset!TM_Pvp = Anterior
                Data1.Recordset.Update
            
            End If
            
    ElseIf Columna = Ven_VPS Then
            Data1.Recordset!TM_VP = Text1.Text
            Data1.Recordset.Update
            
            Call VENTA_Valorizar(3, Data1)
            If Not Antes_Flag Then
                Table1.TextMatrix(Table1.Row, Table1.Col) = Anterior
                Data1.Recordset.Edit
                Data1.Recordset!TM_VP = Anterior
                Data1.Recordset.Update
            
            End If
            
    End If
    
    BacControlWindows 100
    Call ChkMoneda(Columna%)
    BacControlWindows 100

    If Columna > 2 And Columna < 12 Then '2(3) 12(13)
    
       'Chequea contra la moneda de liquidación
        Call ChkMoneda(Columna%)
        BacControlWindows 100
        
       'Sumar el total y desplegar.-
        TxtTotal.Text = VENTA_SumarTotal(FormHandle)
'        TxtTotal.Text = Calcula_Monto_Mx(CDbl(VENTA_SumarTotal(FormHandle)), Data1.Recordset!TM_monemi, 999)
        If dTipcam = 0 Then
          txtIniPMP.Text = 0
        Else
          txtIniPMP.Text = Round(TxtTotal.Text / dTipcam#, IIf(Trim(CmbMon.Text) = "CLP", 0, BacDatGrMon.mndecimal))
        End If

    End If
    
    If Columna = Ven_NOMINAL Then
        SendKeys "{TAB 1}"
    ElseIf Columna = Ven_TIR Then
        SendKeys "{TAB 2}"
    ElseIf Columna = Ven_VPS Then
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
    Table1.TextMatrix(Table1.Row, 3) = Format(Monto, "###,###,###,##0.0000")
    Text1.Visible = False
    Exit Sub
End Sub

Private Sub Text1_LostFocus()
On Error GoTo error
    Text1.Visible = False
    BacControlWindows 100
    Table1.SetFocus
error:
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
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
         
      Case Is = "cmbvende"
         Table1_KeyPress (118)
        'Call Vende
        
      Case Is = "cmbrestaura"
         Table1_KeyPress (114)
        'Call Restaura
        
      Case Is = "cmdfiltra"
         Call Filtrar
         
      Case Is = "cmdemision"
         Call Emite
         
      Case Is = "cmdcortes"
         Call Corta
         
      Case Is = "CmdTipoFiltro"
         Call TipoFiltro
         
   End Select
   
End Sub

Private Sub Txt_TasaTran_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey vbKeyTab
   End If


End Sub


Private Sub Txt_TasaTran_LostFocus()
    
    CalcularValorFinal
    
    If Txt_VFTran.Text > 0 And Txt_TasaTran.Text <> 0 Then '--> Ctrl con Tasa Negativa
        If Not Proc_Valida_Tasa_Transferencia(CDbl(TxtTasa.Text), CDbl(Txt_TasaTran.Text)) Then
            'se omite enviar desde aqui mensaje ya que lo envia la funcion de validacion
        End If
    End If

End Sub


Private Sub TxtFecVct_Change()
   txtplazo.Text = DateDiff("D", TxtFecIni.Text, TxtFecVct.Text)
  'TxtFecVct_LostFocus
End Sub

Private Sub TxtFecVct_LostFocus()

u = 0
    If Format(TxtFecVct.Text, "yyyymmdd") < Format(TxtFecIni.Text, "yyyymmdd") Then
       MsgBox "La Fecha de Vencimiento debe ser Mayor a Fecha de Inicio.", 16
       TxtFecVct.Text = Format$(DateAdd("d", txtplazo.Text, TxtFecIni.Text), "dd/mm/yyyy")
       u = 1
     '  Exit Sub
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
        'Exit Sub
    End If
    
    If txtplazo.Text = 0 Then
        MsgBox "Fecha de Vcto. Ingresada igual a la de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
        txtplazo.Text = txtplazo.Tag
        TxtFecVct.Text = Format$(DateAdd("d", txtplazo.Text, TxtFecIni.Text), "dd/mm/yyyy")
        u = 1
        'Exit Sub
    End If
    
    Call CalcularValorFinal
    If u = 1 Then
        'TxtFecVct.SetFocus
    End If
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

   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
   End If


End Sub

Private Sub TxtPlazo_GotFocus()

  txtplazo.Tag = txtplazo.Text

End Sub

Private Sub TxtPlazo_LostFocus()
Dim rs As Recordset
Dim Sql As String

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
        
   ' If Txt_TasaTran.Text = 0 And TxtTasa.Text <> 0 Then
          Txt_TasaTran.Text = TxtTasa.Text
   ' End If
    
    Call CalcularValorFinal

    'Aplicar Control de Precios y Tasas
    If CDbl(TxtTasa.Text) > 0 Then
        If ControlPreciosTasas("VI", CmbMon.ItemData(CmbMon.ListIndex), txtplazo.Text, TxtTasa.Text) = "S" Then
            If Ctrlpt_ModoOperacion <> "S" Then 'PRD-3860, modo silencioso
            MsgBox Ctrlpt_Mensaje, vbExclamation, TITSISTEMA
        End If
    End If
    End If

End Sub
Private Sub txtTipoCambio_KeyPress(KeyAscii As Integer)
    If KeyAscii = vbKeyReturn Then
        Call txtTipoCambio_LostFocus
    End If
End Sub
Private Sub txtTipoCambio_LostFocus()
        dTipcam# = TxtTipoCambio.Text
        Call TxtTotal_Change
        Call CalcularValorFinal
'        Bac_SendKey vbKeyTab
End Sub
Private Sub TxtTotal_Change()
Dim nRedon As Integer
Dim AuxdTipCam    As Double
    
    txtIniPMS.Text = TxtTotal.Text
    TxtTotal.Text = IIf(TxtTotal.Text = "", "0", TxtTotal.Text)
'    Call funcFindDatGralMoneda(CmbMon.ItemData(CmbMon.ListIndex))
    If SwMx = "C" And CmbMon.ItemData(CmbMon.ListIndex) <> 999 Then
        nRedon = BacDatGrMon.mndecimal
    ElseIf SwMx = " " And CmbMon.ItemData(CmbMon.ListIndex) = 999 Then
        nRedon = 0
    Else
        nRedon = BacDatGrMon.mndecimal
    End If
    
'    If CmbMon.ItemData(CmbMon.ListIndex) = 13 Then
'        nRedon = 2
'    ElseIf CmbMon.ItemData(CmbMon.ListIndex) = 999 Then
'        nRedon = 0
'    Else
'        nRedon = 4
'    End If
    
    If dTipcam = 0 Then
        txtIniPMP.Text = 0
    Else
'      AuxdTipCam = CDbl(Mid(BacTrader.Pnl_UF.Caption, 7))
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
Dim dTotalNuevo#, dTotalActual#

'''' se revisar tiene problemas graves
Dim I As Integer
On Error GoTo error

If Table1.TextMatrix(1, 0) = "" Then
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
'        For I = 1 To Table1.Rows - 1
          Table1.Row = I
          Call Llenar_Grilla
'          If Not Data1.Recordset.EOF Then
'            Data1.Recordset.MoveNext
'          End If
'        Next I
        Table1.Refresh
    End If
error:

Screen.MousePointer = vbDefault

'MsgBox Error(err), vbCritical, gsBac_Version

Exit Sub
End Sub

Public Function Calcula_Monto_Mx(Monto As Double, Monemis As Integer, MonPacto As Integer) As Double
Dim Monto_Peso As Double
Dim nFactor As Double
Dim nRedon  As Integer
Dim nparidad As Double
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
'    nparidad = funcBuscaTipcambio(MonPacto, sFecPro)
    nFactor = CDbl(TxtTipoCambio.Text) '''funcBuscaTipcambio(MonPacto, sFecPro)
    nRedon = 4
End If

Calcula_Monto_Mx = Round(Monto_Peso / nFactor, nRedon)

End Function


