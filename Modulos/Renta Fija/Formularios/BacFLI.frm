VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BACFLI 
   Caption         =   "Facilidad de Liquidez Intradia. FLI.-"
   ClientHeight    =   10890
   ClientLeft      =   420
   ClientTop       =   1950
   ClientWidth     =   11970
   ForeColor       =   &H8000000F&
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   10890
   ScaleWidth      =   11970
   Begin VB.CheckBox CheckFolioSOMAManual 
      Caption         =   "Folio SOMA Manual"
      Height          =   255
      Left            =   9600
      TabIndex        =   34
      Top             =   1080
      Width           =   1815
   End
   Begin BACControles.TXTNumero TxtFolioSoma 
      Height          =   255
      Left            =   9720
      TabIndex        =   35
      Top             =   1440
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   450
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
      MarcaTexto      =   -1  'True
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Mostrar Detalle SOMA"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Left            =   9615
      TabIndex        =   31
      Top             =   525
      Width           =   1920
   End
   Begin VB.Frame frm_Soma 
      Caption         =   "Instrumentos en el SOMA"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3240
      Left            =   75
      TabIndex        =   25
      Top             =   6195
      Width           =   14775
      Begin MSFlexGridLib.MSFlexGrid GridErroresSOMA 
         Height          =   855
         Left            =   0
         TabIndex        =   36
         Top             =   2160
         Width           =   11895
         _ExtentX        =   20981
         _ExtentY        =   1508
         _Version        =   393216
         Rows            =   1
         Cols            =   6
      End
      Begin MSFlexGridLib.MSFlexGrid GridFolioSOMA 
         Height          =   1935
         Left            =   0
         TabIndex        =   33
         Top             =   240
         Width           =   2055
         _ExtentX        =   3625
         _ExtentY        =   3413
         _Version        =   393216
         Rows            =   1
         FixedRows       =   0
      End
      Begin VB.PictureBox PicProgree 
         BorderStyle     =   0  'None
         Height          =   525
         Left            =   11970
         ScaleHeight     =   525
         ScaleWidth      =   2265
         TabIndex        =   28
         Top             =   1485
         Width           =   2265
         Begin ComctlLib.ProgressBar Progreso 
            Height          =   225
            Left            =   225
            TabIndex        =   29
            Top             =   210
            Width           =   2835
            _ExtentX        =   5001
            _ExtentY        =   397
            _Version        =   327682
            Appearance      =   0
         End
         Begin VB.Label LblProgreso 
            Caption         =   "CARGANDO .... "
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   255
            TabIndex        =   30
            Top             =   0
            Width           =   2730
         End
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Generar FLI. "
         Height          =   345
         Left            =   12240
         TabIndex        =   27
         Top             =   225
         Visible         =   0   'False
         Width           =   2070
      End
      Begin MSFlexGridLib.MSFlexGrid GrillaSoma 
         Height          =   2040
         Left            =   2025
         TabIndex        =   26
         TabStop         =   0   'False
         Top             =   150
         Width           =   9825
         _ExtentX        =   17330
         _ExtentY        =   3598
         _Version        =   393216
         Cols            =   9
         FixedCols       =   0
         BackColor       =   12632256
         ForeColor       =   0
         BackColorFixed  =   8388608
         ForeColorFixed  =   16777215
         BackColorSel    =   16744576
         ForeColorSel    =   16777215
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin BACControles.TXTNumero TxtIngreso 
      Height          =   192
      Left            =   3012
      TabIndex        =   24
      Top             =   2256
      Visible         =   0   'False
      Width           =   912
      _ExtentX        =   1614
      _ExtentY        =   344
      BackColor       =   16744576
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
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
      Separator       =   -1  'True
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   12120
      Top             =   600
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   13
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFLI.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFLI.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFLI.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFLI.frx":0A86
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFLI.frx":0ED8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFLI.frx":11F2
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFLI.frx":1644
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFLI.frx":195E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFLI.frx":1C78
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFLI.frx":1F92
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFLI.frx":23E4
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFLI.frx":26FE
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFLI.frx":2A18
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   495
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11970
      _ExtentX        =   21114
      _ExtentY        =   873
      ButtonWidth     =   847
      ButtonHeight    =   820
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   14
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar Operación"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdFiltrar"
            Description     =   "Filtrar"
            Object.ToolTipText     =   "Filtrar Papeles"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdVerMarcados"
            Description     =   "VerMarcados"
            Object.ToolTipText     =   "Modificar o Liberar Papeles"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdVerTodos"
            Description     =   "VerTodos"
            Object.ToolTipText     =   "Ver Todos los papeles"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdVender"
            Description     =   "Vender"
            Object.ToolTipText     =   "Vender Papeles"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdRestaurar"
            Description     =   "Restaurar"
            Object.ToolTipText     =   "Restaurar Papel"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdCapturar"
            Description     =   "CARGA_SOMA_EXCEL"
            Object.ToolTipText     =   "Captura de Operaciones desde Sistema SOMA"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CmdInfCargaSOMA"
            Description     =   "InfCargaSOMA"
            Object.ToolTipText     =   "Informe de CARGASOMA"
            ImageIndex      =   12
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Detalle"
            Description     =   "Detalle"
            Object.ToolTipText     =   "Detalle"
            ImageIndex      =   13
         EndProperty
         BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir de la Ventana"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button14 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Ayuda"
            Description     =   "Ayuda"
            Object.ToolTipText     =   "Ayuda"
            ImageIndex      =   10
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame Frame 
      Height          =   1500
      Index           =   0
      Left            =   30
      TabIndex        =   1
      Top             =   405
      Width           =   2880
      _Version        =   65536
      _ExtentX        =   5080
      _ExtentY        =   2646
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
      Begin BACControles.TXTFecha TxtFecIni 
         Height          =   315
         Left            =   1440
         TabIndex        =   2
         Top             =   390
         Width           =   1335
         _ExtentX        =   2355
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
         Left            =   105
         TabIndex        =   3
         Top             =   390
         Width           =   1095
         _Version        =   65536
         _ExtentX        =   1931
         _ExtentY        =   556
         _StockProps     =   15
         Caption         =   "Miércoles"
         ForeColor       =   8388608
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
         Alignment       =   1
      End
      Begin BACControles.TXTNumero txtIniPMS 
         Height          =   330
         Left            =   825
         TabIndex        =   4
         TabStop         =   0   'False
         Top             =   1080
         Width           =   1935
         _ExtentX        =   3413
         _ExtentY        =   582
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
         Height          =   330
         Left            =   825
         TabIndex        =   5
         TabStop         =   0   'False
         Top             =   720
         Width           =   1935
         _ExtentX        =   3413
         _ExtentY        =   582
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
      Begin VB.Label Label 
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
         Left            =   105
         TabIndex        =   7
         Top             =   1110
         Width           =   345
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
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
         Left            =   105
         TabIndex        =   6
         Top             =   750
         Width           =   255
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1500
      Index           =   1
      Left            =   2925
      TabIndex        =   8
      Top             =   405
      Width           =   3345
      _Version        =   65536
      _ExtentX        =   5900
      _ExtentY        =   2646
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
      Alignment       =   2
      Font3D          =   3
      Begin VB.ComboBox CmbMon 
         Enabled         =   0   'False
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
         Left            =   825
         Style           =   2  'Dropdown List
         TabIndex        =   12
         Top             =   390
         Width           =   1290
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
         ItemData        =   "BacFLI.frx":38F2
         Left            =   840
         List            =   "BacFLI.frx":38FF
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   1800
         Width           =   795
      End
      Begin BACControles.TXTNumero TxtPlazox 
         Height          =   315
         Left            =   810
         TabIndex        =   9
         Top             =   1095
         Visible         =   0   'False
         Width           =   1410
         _ExtentX        =   2487
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
      End
      Begin BACControles.TXTNumero TxtTasaX 
         Height          =   315
         Left            =   825
         TabIndex        =   10
         Top             =   750
         Visible         =   0   'False
         Width           =   1410
         _ExtentX        =   2487
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
         Text            =   "0,000000000000"
         Text            =   "0,000000000000"
         CantidadDecimales=   12
         SelStart        =   9
      End
      Begin BACControles.TXTNumero txtTipoCambio 
         Height          =   285
         Left            =   2160
         TabIndex        =   13
         Top             =   390
         Width           =   1095
         _ExtentX        =   1931
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         CantidadDecimales=   "4"
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
         Left            =   105
         TabIndex        =   17
         Top             =   390
         Width           =   690
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
         Left            =   105
         TabIndex        =   16
         Top             =   1110
         Visible         =   0   'False
         Width           =   660
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
         TabIndex        =   15
         Top             =   1935
         Width           =   435
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
         Left            =   105
         TabIndex        =   14
         Top             =   750
         Visible         =   0   'False
         Width           =   435
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1500
      Index           =   2
      Left            =   6285
      TabIndex        =   18
      Top             =   405
      Width           =   3285
      _Version        =   65536
      _ExtentX        =   5794
      _ExtentY        =   2646
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
      Alignment       =   1
      Font3D          =   3
      Begin BACControles.TXTNumero txtVenPMP 
         Height          =   330
         Left            =   1230
         TabIndex        =   19
         Top             =   420
         Width           =   1950
         _ExtentX        =   3440
         _ExtentY        =   582
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
      Begin BACControles.TXTNumero txtdiferencia 
         Height          =   330
         Left            =   1230
         TabIndex        =   20
         Top             =   810
         Width           =   1950
         _ExtentX        =   3440
         _ExtentY        =   582
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
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Monto Pago"
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
         Left            =   120
         TabIndex        =   22
         Top             =   495
         Width           =   1035
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Monto Saldo"
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
         TabIndex        =   21
         Top             =   840
         Width           =   1140
      End
   End
   Begin MSFlexGridLib.MSFlexGrid Grilla 
      Height          =   6765
      Left            =   0
      TabIndex        =   23
      TabStop         =   0   'False
      Top             =   1920
      Width           =   12090
      _ExtentX        =   21325
      _ExtentY        =   11933
      _Version        =   393216
      Cols            =   27
      FixedCols       =   2
      BackColor       =   12632256
      ForeColor       =   0
      BackColorFixed  =   8388608
      ForeColorFixed  =   16777215
      BackColorSel    =   16744576
      ForeColorSel    =   16777215
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid GrillaGrabarFli 
      Height          =   1305
      Left            =   10485
      TabIndex        =   32
      Top             =   3240
      Visible         =   0   'False
      Width           =   2280
      _ExtentX        =   4022
      _ExtentY        =   2302
      _Version        =   393216
      FixedCols       =   0
   End
End
Attribute VB_Name = "BACFLI"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public iAceptar               As Boolean
Public CarterasFinancieras    As String
Public CarterasNormativas     As String
Public MihWnd                 As Long
Public nMaximoIngreso         As Double
''REQ.6006
Public nMarca                 As String
Public nSerie                 As String
Public sCarteraNorm           As String
Public dTasaRef               As Double
Public dNominal               As Double
Public sCarteraNormCod        As String
Public dRutEmisor             As Double

Public nFolioSOMA             As Long
Public cNombreArchivo         As String
Public bCargaArchivo          As Boolean
Public SwErrorArch            As Boolean
Public MiExcel    As Object
Public MiLibro    As Object
Public bDistribucionManual    As Boolean
Public FLI_Familia           As String ' 20181221.RCH.LCGP

Private Enum bEstado
   [Normal] = 0
   [Tomado] = 1
   [VtaTotal] = 2
   [VtaParcial] = 3
   [BloqueoPacto] = 4   ' PRD-6005
End Enum

Const FDec4Dec = "#,##0.0000"
Const FDec2Dec = "#,##0.00"
Const FDec0Dec = "#,##0"

Const Col_Marca = 0
Const COL_Serie = 1
Const Col_Moneda = 2
Const Col_Nominal = 3
Const Col_Tir = 4
Const Col_VPar = 5
Const Col_MT = 6
Const Col_PlzRes = 7
Const Col_Margen = 8
Const Col_ValInicial = 9

Const Col_Custodia = 11
Const Col_ClaveDcv = 12
Const Col_CarteraSuper = 10


Const Col_Nominal_ORIG = 13
Const Col_Tir_ORIG = 14
Const Col_VPar_ORIG = 15
Const Col_MT_ORIG = 16
Const Col_Margen_ORIG = 17
Const Col_ValInicial_ORIG = 18
Const Col_CodCarteraSuper = 19
Const Col_BloqueoPacto = 20      ' PRD-6005
Const Col_HairCut = 21           ' PRD-6007
Const Col_Emisor = 24            ' PRD-6006
Const Col_ID_SOMA = 22           ' PRD-6010
Const Col_Correla_SOMA = 23      ' PRD-6010
Const Col_Nemo_Emisor = 25       ' PRD-6006

Const CajaSinMarcar = &HE0E0E0
Const CajaBloqeado = vbBlack
Const CajaVtaTotal = &HFF0000
Const CajaVtaParcial = &HFFFF00

Const FnteSinMarcar = &H0&
Const FnteBloqeado = vbWhite
Const FnteVtaTotal = &HFFFFFF
Const FnteVtaParcial = &H0&

Dim nModoCalculo     As Integer
Dim cMascara         As String
Dim nNominal         As Double
Dim nTir             As Double
Dim nPvp             As Double
Dim nMonto           As Double
Dim cFecCal          As String
Dim nFactor          As Double
Dim nValorInicial    As Double
Dim cUsuario         As String
Dim nVentana         As Double
Dim nMontoAnterior   As Double

Dim nNumOperFli      As Long
Dim oPagoParcial     As Boolean
Dim EstaPagando      As Boolean
Dim cSql             As String
Dim ErrAnula         As String
Dim nAlturaFila      As Long

Private Function ChangeColorSetting(ByVal Fila As Long, Estado As bEstado)
   Dim nContador     As Long
   Dim bColorCaja    As Variant
   Dim bColorFont    As Variant
   Dim nColumna      As Long

       If Estado = Normal Then Let bColorCaja = vbBlack:           Let bColorFont = vbBlack
       If Estado = Tomado Then Let bColorCaja = vbGreen + vbWhite: Let bColorFont = vbWhite
     If Estado = VtaTotal Then Let bColorCaja = vbBlue:            Let bColorFont = vbWhite
   If Estado = VtaParcial Then Let bColorCaja = vbCyan:            Let bColorFont = vbBlack
   If Estado = BloqueoPacto Then Let bColorCaja = vbYellow:        Let bColorFont = vbRed   ' PRD-6005

   Let nColumna = Grilla.ColSel
   Let Grilla.Row = IIf(Estado = 4, Fila, Grilla.RowSel)   ' PRD-6005
   Let Grilla.Redraw = False

   For nContador = 3 To Grilla.cols - 1
      Let Grilla.Col = nContador
      Let Grilla.CellBackColor = bColorCaja
      Let Grilla.CellForeColor = bColorFont
   Next nContador

   Let Grilla.Col = nColumna

   Let Grilla.Redraw = True
End Function

Private Sub SettingGridSoma(ByRef xGrilla As MSFlexGrid)
   Let xGrilla.Rows = 2:   Let xGrilla.FixedRows = 1
   Let xGrilla.cols = 10:   Let xGrilla.FixedCols = 0

   Let xGrilla.TextMatrix(0, 0) = "Serie":               Let xGrilla.ColWidth(0) = 1300
   Let xGrilla.TextMatrix(0, 1) = "Nominal":             Let xGrilla.ColWidth(1) = 2000
   Let xGrilla.TextMatrix(0, 2) = "Tasa":                Let xGrilla.ColWidth(2) = 1000
   Let xGrilla.TextMatrix(0, 3) = "Valor Referencial":   Let xGrilla.ColWidth(3) = 2500
   Let xGrilla.TextMatrix(0, 4) = "Plazo":               Let xGrilla.ColWidth(4) = 1000
   Let xGrilla.TextMatrix(0, 5) = "Margen":              Let xGrilla.ColWidth(5) = 1000
   Let xGrilla.TextMatrix(0, 6) = "Valor Inicial":       Let xGrilla.ColWidth(6) = 2500
   Let xGrilla.TextMatrix(0, 7) = "ID":                  Let xGrilla.ColWidth(7) = 1000  'PRD-6010
   Let xGrilla.TextMatrix(0, 8) = "Correlativo":         Let xGrilla.ColWidth(8) = 1000  'PRD-6010
   Let xGrilla.TextMatrix(0, 9) = "RutEmisor":           Let xGrilla.ColWidth(9) = 1500  'PRD-6010
   Let xGrilla.Rows = 1
End Sub

Private Sub SettingGridVisible(ByRef xGrilla As MSFlexGrid)
   Dim nContador  As Long

   Let xGrilla.WordWrap = True

   Let xGrilla.Rows = 2:      Let xGrilla.cols = 26 ' VB+- 25/01/2010 Se agregan 2 columas para el tema de la carteras  ' PRD-6005 - PRD-6007
   Let xGrilla.Row = 1:       Let xGrilla.Col = 1
   Let xGrilla.FixedRows = 1: Let xGrilla.FixedCols = 3
   
   Let xGrilla.RowHeight(0) = 500
   Let xGrilla.TextMatrix(0, Col_Marca) = "M":                              Let xGrilla.ColWidth(Col_Marca) = 500:          Let xGrilla.TextMatrix(1, Col_Marca) = ""
   Let xGrilla.TextMatrix(0, COL_Serie) = "Serie":                          Let xGrilla.ColWidth(COL_Serie) = 1300:         Let xGrilla.TextMatrix(1, COL_Serie) = ""
   Let xGrilla.TextMatrix(0, Col_Moneda) = "UM":                            Let xGrilla.ColWidth(Col_Moneda) = 500:         Let xGrilla.TextMatrix(1, Col_Moneda) = ""
   Let xGrilla.TextMatrix(0, Col_Nominal) = "Nominal":                      Let xGrilla.ColWidth(Col_Nominal) = 2000:       Let xGrilla.TextMatrix(1, Col_Nominal) = Format(0#, FDec4Dec)
   Let xGrilla.TextMatrix(0, Col_Tir) = "Tasa Referencial":                 Let xGrilla.ColWidth(Col_Tir) = 1000:           Let xGrilla.TextMatrix(1, Col_Tir) = Format(0#, FDec4Dec)
   Let xGrilla.TextMatrix(0, Col_VPar) = "%Vpar":                           Let xGrilla.ColWidth(Col_VPar) = 900:           Let xGrilla.TextMatrix(1, Col_VPar) = Format(0#, FDec4Dec)
   Let xGrilla.TextMatrix(0, Col_MT) = "Valor Referencial":                 Let xGrilla.ColWidth(Col_MT) = 2500:            Let xGrilla.TextMatrix(1, Col_MT) = Format(0#, FDec0Dec)
   Let xGrilla.TextMatrix(0, Col_PlzRes) = "Plazo Residual":                Let xGrilla.ColWidth(Col_PlzRes) = 1000:        Let xGrilla.TextMatrix(1, Col_PlzRes) = Format(0#, FDec0Dec)
   Let xGrilla.TextMatrix(0, Col_Margen) = "Margen":                        Let xGrilla.ColWidth(Col_Margen) = 1000:        Let xGrilla.TextMatrix(1, Col_Margen) = Format(0#, FDec4Dec)
   Let xGrilla.TextMatrix(0, Col_ValInicial) = "Valor Inicial":             Let xGrilla.ColWidth(Col_ValInicial) = 2500:    Let xGrilla.TextMatrix(1, Col_ValInicial) = Format(0#, FDec0Dec)
   Let xGrilla.TextMatrix(0, Col_Custodia) = "Custodia":                    Let xGrilla.ColWidth(Col_Custodia) = 1500:      Let xGrilla.TextMatrix(1, Col_Custodia) = ""
   Let xGrilla.TextMatrix(0, Col_ClaveDcv) = "Clave DCV":                   Let xGrilla.ColWidth(Col_ClaveDcv) = 0:         Let xGrilla.TextMatrix(1, Col_ClaveDcv) = ""
   Let xGrilla.TextMatrix(0, Col_CarteraSuper) = "Cartera Super":           Let xGrilla.ColWidth(Col_CarteraSuper) = 3000:  Let xGrilla.TextMatrix(1, Col_CarteraSuper) = ""   'VB+-25/01/2010

   Let xGrilla.TextMatrix(0, Col_Nominal_ORIG) = "Nom. Original":           Let xGrilla.ColWidth(Col_Nominal_ORIG) = 0:     Let xGrilla.TextMatrix(1, Col_Nominal_ORIG) = Format(0#, FDec4Dec)
   Let xGrilla.TextMatrix(0, Col_Tir_ORIG) = "Tasa Original":               Let xGrilla.ColWidth(Col_Tir_ORIG) = 0:         Let xGrilla.TextMatrix(1, Col_Tir_ORIG) = Format(0#, FDec4Dec)
   Let xGrilla.TextMatrix(0, Col_VPar_ORIG) = "vPar Original":              Let xGrilla.ColWidth(Col_VPar_ORIG) = 0:        Let xGrilla.TextMatrix(1, Col_VPar_ORIG) = Format(0#, FDec4Dec)
   Let xGrilla.TextMatrix(0, Col_MT_ORIG) = "Valor Ref. Original":          Let xGrilla.ColWidth(Col_MT_ORIG) = 0:          Let xGrilla.TextMatrix(1, Col_MT_ORIG) = Format(0#, FDec4Dec)
   Let xGrilla.TextMatrix(0, Col_Margen_ORIG) = "Margen Original":          Let xGrilla.ColWidth(Col_Margen_ORIG) = 0:      Let xGrilla.TextMatrix(1, Col_Margen_ORIG) = Format(0#, FDec0Dec)
   Let xGrilla.TextMatrix(0, Col_ValInicial_ORIG) = "vInicial Original":    Let xGrilla.ColWidth(Col_ValInicial_ORIG) = 0:  Let xGrilla.TextMatrix(1, Col_ValInicial_ORIG) = Format(0#, FDec0Dec)
   Let xGrilla.TextMatrix(0, Col_CodCarteraSuper) = "Cód. Cartera Super":   Let xGrilla.ColWidth(Col_CodCarteraSuper) = 0:  Let xGrilla.TextMatrix(1, Col_CodCarteraSuper) = ""  'VB+-25/01/2010
   Let xGrilla.TextMatrix(0, Col_BloqueoPacto) = "Bloqueo Pacto":           Let xGrilla.ColWidth(Col_BloqueoPacto) = 2000:  Let xGrilla.TextMatrix(1, Col_BloqueoPacto) = Format(0#, FDec4Dec)  ' PRD-6005
   Let xGrilla.TextMatrix(0, Col_HairCut) = "HairCut(%)":                   Let xGrilla.ColWidth(Col_HairCut) = 1000:       Let xGrilla.TextMatrix(1, Col_HairCut) = Format(0#, FDec4Dec)       ' PRD-6007
   Let xGrilla.TextMatrix(0, Col_ID_SOMA) = "ID SOMA(%)":                   Let xGrilla.ColWidth(Col_ID_SOMA) = 1000:       Let xGrilla.TextMatrix(1, Col_ID_SOMA) = Format(0#, FDec0Dec)       ' PRD-6010
   Let xGrilla.TextMatrix(0, Col_Correla_SOMA) = "Correla_SOMA(%)":         Let xGrilla.ColWidth(Col_Correla_SOMA) = 1100:  Let xGrilla.TextMatrix(1, Col_Correla_SOMA) = Format(0#, FDec0Dec)  ' PRD-6010

   Let xGrilla.TextMatrix(0, Col_Emisor) = "Emisor":                        Let xGrilla.ColWidth(Col_Emisor) = 1000:        Let xGrilla.TextMatrix(1, Col_Emisor) = Format(0#, FDec0Dec)        ' PRD-6006
   Let xGrilla.TextMatrix(0, Col_Nemo_Emisor) = "Nemo Emisor":              Let xGrilla.ColWidth(Col_Nemo_Emisor) = 1000:   Let xGrilla.TextMatrix(1, Col_Nemo_Emisor) = ""                     ' PRD-6006
   
End Sub

Private Sub Check1_Click()
   If Check1.Value = 1 Then
      If GrillaSoma.Rows <> GrillaSoma.FixedRows Then
         If Not (Me.WindowState = vbMaximized) Then
            Let Me.Height = 9300
         End If
         'PRD-6010
         
         frm_Soma.Visible = True
         frm_Soma.Enabled = True
         frm_Soma.Top = 5190 '6195
      End If
   Else
      If Not (Me.WindowState = vbMaximized) Then
        Let Me.Height = 6950
      End If
      'PRD-6010
      frm_Soma.Visible = False
      frm_Soma.Enabled = False
   End If
End Sub
Private Sub CheckFolioSOMAManual_Click()

   If CheckFolioSOMAManual.Value = 1 Then
      TxtFolioSoma.Enabled = True
   Else
      TxtFolioSoma.Enabled = False
   End If
   
End Sub

Private Sub CmbMon_Click()
   Let Label(1).Caption = CmbMon.text
   txtTipoCambio.text = Format(CDbl(funcBuscaTipcambio(CmbMon.ItemData(CmbMon.ListIndex), TxtFecIni.text)), "#,##0.0000")
End Sub

Private Sub Command1_Click()
   Call Realizar_Fli_Soma
End Sub

Private Sub Form_Load()

   Let bDistribucionManual = False
   Let Screen.MousePointer = vbHourglass
   
   Let Me.frm_Soma.Visible = False
   Let Me.Icon = BacTrader.Icon
   Let Me.Top = 0:               Let Me.Left = 0:              Let Me.Height = 6950
   
   Let Me.Caption = "Facilidad de Liquidez Intradia - FLI"
   Let Tipo_Operacion = "FLI"
   Let MihWnd = CDbl(Me.hWnd)
   Let nNumOperFli = 0
   Let EstaPagando = False
   Let oPagoParcial = False
   Let EstaPagando = False
   Let nMaximoIngreso = 0
   'PRD-6010
   Let nFolioSOMA = 0
   Let TxtFolioSoma.Enabled = False

   
   '--> Deshabilita Botones del Fli, hasta que no se ejecute el Filtro
   Let Toolbar1.Buttons(10).Enabled = False
   Let Toolbar1.Buttons(11).Enabled = False
   '--> Deshabilita Botones del Fli, hasta que no se ejecute el Filtro
   
   Let TxtFecIni.text = Format(gsBac_Fecp, "dd/mm/yyyy")
   Call funcFindMonVal(Me.CmbMon, CmbBase, "VI")
   If CmbMon.ListCount > -1 Then
      CmbMon.ListIndex = 0
   End If

   Call SettingGridVisible(Grilla)
   Call SettingGridSoma(GrillaSoma)

   ''REQ.6006
   Me.Toolbar1.Buttons(12).Enabled = False
   Toolbar1.Buttons(12).Enabled = True 'PROD 6006 Evaluar dejar para siempre
   
    'PRD-6010
   Toolbar1.Buttons(5).Enabled = False
   Toolbar1.Buttons(5).Tag = "Ver Sel."
   Toolbar1.Buttons(5).ToolTipText = "Ver Selección"
   'PRD-6010
   
   Let Screen.MousePointer = vbDefault
End Sub

Private Sub Form_Resize()
On Error GoTo BacErrHnd

Dim lScaleWidth&, lScaleHeight&, lPosIni&

    ' Cuando la ventana es minimizada, se ignora la rutina.-
    If Me.WindowState = 1 Then
        ' Pinta borde del icono.-
        Dim X!, y!, j%

        X = Me.Width
        y = Me.Height
        For j% = 1 To 15
            Line (0, 0)-(X, 0), QBColor(Int(Rnd * 15))
            Line (X, 0)-(X, y), QBColor(Int(Rnd * 15))
            Line (X, y)-(0, y), QBColor(Int(Rnd * 15))
            Line (0, y)-(0, 0), QBColor(Int(Rnd * 15))
            DoEvents
        Next
        Exit Sub

    End If

  ' Escalas de medida de la ventana.-
    lScaleWidth& = Me.ScaleWidth
    lScaleHeight& = Me.ScaleHeight

  ' Resize la ventana customizado.-
    If Me.WindowState <> 1 And Me.Width > 400 And Me.Height > 2100 Then
        Grilla.Width = Me.Width - 300
        Grilla.Height = Me.Height - 3000
    End If

      Exit Sub

BacErrHnd:

    On Error GoTo 0
    Resume Next

End Sub


Private Sub Form_Unload(Cancel As Integer)
   Call SoltarTodos
End Sub

Private Function SoltarTodos()

   Envia = Array()
   AddParam Envia, CDbl(3) '--> Limpia tabla
   AddParam Envia, Trim(Grilla.TextMatrix(Grilla.RowSel, COL_Serie))
   AddParam Envia, Trim(gsBac_User)
   AddParam Envia, CDbl(Me.hWnd)
   AddParam Envia, CDbl(0)
   
   If Not Bac_Sql_Execute("DBO.SP_LEE_BLOQUEO_FLI", Envia) Then
      Let Me.MousePointer = vbDefault
      Call MsgBox("Se ha producido un error al tratar de tomar el registro.", vbExclamation, App.Title)
      Exit Function
   End If
   
End Function






Private Sub TxtFolioSoma_GotFocus()
'PRD-6010
   Let nFolioSOMA = TxtFolioSoma.text
End Sub

Private Sub TxtIngreso_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim cFormato         As Variant
   
   If KeyCode = vbKeyEscape Then
      Let Grilla.Enabled = True
      Let Toolbar1.Enabled = True
      Let TxtIngreso.Visible = False
      Call Grilla.SetFocus
   End If

   If KeyCode = vbKeyReturn Then
   
      If bDistribucionManual Then
         If MsgBox("Se perderá asignación Manual, Continua?", vbOKCancel) = vbCancel Then
            Call TxtIngreso.SetFocus
            Exit Sub
         End If
      End If
      If TxtIngreso.text = 0 Then
         Call MsgBox("Valor ingresado no es valido...", vbExclamation, App.Title)
         Call TxtIngreso.SetFocus
         Exit Sub
      End If
      
      
      Let cFormato = IIf(TxtIngreso.CantidadDecimales = 0, FDec0Dec, FDec4Dec)

      'PRD-6005
      If Grilla.ColSel = Col_Tir Then
            If CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)) = 0 Then
                Call MsgBox("No existe Nominal disponible.", vbExclamation, App.Title)
                Let TxtIngreso.text = CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG))
                Call TxtIngreso.SetFocus
                Exit Sub
            End If
      End If
      'PRD-6005

      If Grilla.ColSel = Col_MT Then
      
            If (oPagoParcial Or EstaPagando) And CDbl(TxtIngreso.text) > CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_MT_ORIG)) Then
                MsgBox "Monto ingresado no puede ser mayor o igual valor del papel", vbExclamation
                Let TxtIngreso.text = CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_MT))
                Call TxtIngreso.SetFocus
                Exit Sub
            Else
                Let nMontoAnterior = CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_MT))
            End If
            
            If (oPagoParcial Or EstaPagando) And CDbl(TxtIngreso.text) >= CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_MT_ORIG)) And Grilla.TextMatrix(Grilla.RowSel, 0) = "P" Then
                MsgBox "Monto ingresado no puede ser mayor o igual valor del papel", vbExclamation
                Let TxtIngreso.text = CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_MT))
                Call TxtIngreso.SetFocus
                Exit Sub
            Else
                Let nMontoAnterior = CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_MT))
            End If
            
            'PRD-6005
            If CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)) = 0 Then
                Call MsgBox("No existe Nominal disponible.", vbExclamation, App.Title)
                Let TxtIngreso.text = CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG))
                Call TxtIngreso.SetFocus
                Exit Sub
            End If
            'PRD-6005
      End If
      
      If Grilla.ColSel = Col_ValInicial Then
            If (oPagoParcial Or EstaPagando) And CDbl(TxtIngreso.text) > CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_ValInicial_ORIG)) Then
                MsgBox "Monto ingresado no puede ser mayor o igual valor del papel", vbExclamation
                Let TxtIngreso.text = CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_ValInicial))
                Call TxtIngreso.SetFocus
                Exit Sub
            Else
                Let nMontoAnterior = CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_ValInicial))
            End If
            'PRD-6005
            If CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)) = 0 Then
                Call MsgBox("No existe Nominal disponible.", vbExclamation, App.Title)
                Let TxtIngreso.text = CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG))
                Call TxtIngreso.SetFocus
                Exit Sub
            End If
            'PRD-6005
             
      End If

      If Grilla.ColSel = Col_Nominal Then
         If CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)) < CDbl(TxtIngreso.text) Then
            Call MsgBox("Nominal disponible es menor al ingresado.", vbExclamation, App.Title)
            Let TxtIngreso.text = CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG))
            Call TxtIngreso.SetFocus
            Exit Sub
         End If
      End If
      
      
      Let Grilla.Enabled = True
      Let Toolbar1.Enabled = True
      
     
      Let Grilla.TextMatrix(Grilla.RowSel, Grilla.ColSel) = Format(TxtIngreso.text, cFormato)
      
      Let TxtIngreso.Visible = False
      Call Grilla.SetFocus
      
      
      If TomarPapel Then
        Call Valorizacion_Fli(vbKeyReturn)
      End If
      
   End If
End Sub

Private Function SoltarPapel() As Boolean
   Dim Datos()
   
   Let SoltarPapel = True
   
   If Grilla.TextMatrix(Grilla.RowSel, Col_Marca) = "V" Or Grilla.TextMatrix(Grilla.RowSel, Col_Marca) = "P" Then
      Call BacBeginTransaction

      Envia = Array()
      AddParam Envia, CDbl(2) '--> Indica Desblequero o Resauracion
      AddParam Envia, Trim(Grilla.TextMatrix(Grilla.RowSel, COL_Serie))
      AddParam Envia, Trim(gsBac_User)
      AddParam Envia, CDbl(Me.hWnd)
      AddParam Envia, CDbl(0)
      AddParam Envia, Trim(Grilla.TextMatrix(Grilla.RowSel, Col_CodCarteraSuper))
      AddParam Envia, CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Emisor))
      If Not Bac_Sql_Execute("DBO.SP_LEE_BLOQUEO_FLI", Envia) Then
         Call BacRollBackTransaction
         Let Me.MousePointer = vbDefault
         Call MsgBox("Se ha producido un error al tratar de tomar el registro.", vbExclamation, App.Title)
         Let SoltarPapel = False
         Exit Function
      End If
      If Bac_SQL_Fetch(Datos()) Then
         Call BacCommitTransaction
         Let Grilla.TextMatrix(Grilla.RowSel, Col_Marca) = ""
         Call ChangeColorSetting(Grilla.RowSel, Normal)
        'PRD-6005
        If Grilla.TextMatrix(Grilla.RowSel, Col_BloqueoPacto) <> 0 Then
          Call ChangeColorSetting(Grilla.RowSel, BloqueoPacto)
        End If
      End If
   Else
      If Grilla.TextMatrix(Grilla.RowSel, Col_Marca) <> "" Then
         Call MsgBox("El registro no se puede desbloquear... por que lo tiene tomado otro usuario.", vbExclamation, App.Title)
         Call Grilla.SetFocus
         Let SoltarPapel = False
      End If
   End If
   
   Call ActualizaMontoOperacion
   
End Function

Private Function TomarPapel() As Boolean
   Dim Datos()
   Dim nMarca     As String
   Dim nMoninal   As Double
   
   Let TomarPapel = True
   
   If Grilla.TextMatrix(Grilla.RowSel, Col_Marca) = "*" Then
      Let Me.MousePointer = vbDefault
      Call MsgBox("Documento se encuentra tomado por otro usuario.", vbExclamation, App.Title)
      Call Grilla.SetFocus
      Let TomarPapel = False
      Exit Function
   End If

   Let nMoninal = CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Nominal))

   Envia = Array()
   AddParam Envia, CDbl(1) '--> Indica Blequero
   AddParam Envia, Trim(Grilla.TextMatrix(Grilla.RowSel, COL_Serie))
   AddParam Envia, Trim(gsBac_User)
   AddParam Envia, CDbl(Me.hWnd)
   AddParam Envia, nMoninal
   AddParam Envia, Grilla.TextMatrix(Grilla.RowSel, Col_CodCarteraSuper)
   AddParam Envia, CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Emisor))
   If Not Bac_Sql_Execute("DBO.SP_LEE_BLOQUEO_FLI", Envia) Then
      Let Me.MousePointer = vbDefault
      Call MsgBox("Se ha producido un error al tratar de tomar el registro.", vbExclamation, App.Title)
      Let TomarPapel = False
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) < 0 Then
         Call MsgBox(Datos(2), vbExclamation, App.Title)
          Let Grilla.TextMatrix(Grilla.RowSel, Col_Marca) = "*"
         Call ChangeColorSetting(Grilla.RowSel, Tomado)
         Let TomarPapel = False
      Else
         ' RevisaColores
         Call subCOLOREA_Registro
      End If
   End If

   Call ActualizaMontoOperacion
   If Val(txtdiferencia.text) < 0 Then
        Call SoltarPapel
      Let TomarPapel = False
      Exit Function
        
    End If
   
   ''REQ.6006
   If Grilla.TextMatrix(Grilla.RowSel, Col_Marca) = "P" Then
      Toolbar1.Buttons(12).Enabled = True
   End If
   
End Function

Private Sub subCOLOREA_Registro()

    If CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)) <> CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Nominal)) Then
       Let Grilla.TextMatrix(Grilla.RowSel, Col_Marca) = "P"
       Let Grilla.TextMatrix(Grilla.RowSel, Col_ClaveDcv) = FUNC_GENERA_CLAVE_DCV
       Call ChangeColorSetting(Grilla.RowSel, VtaParcial)
    Else
       Let Grilla.TextMatrix(Grilla.RowSel, Col_Marca) = "V"
       Let Grilla.TextMatrix(Grilla.RowSel, Col_ClaveDcv) = FUNC_GENERA_CLAVE_DCV
       Call ChangeColorSetting(Grilla.RowSel, VtaTotal)
    End If
    
End Sub

'
'
Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)
Dim Datos()
Dim nColumna         As Long
Dim bPermiteEscribir As Boolean
Dim nMoninal         As Double

    
    If Grilla.TextMatrix(Grilla.RowSel, COL_Serie) = "" Then
        Exit Sub
    End If

    Let Me.MousePointer = vbHourglass
    Let nColumna = Grilla.ColSel

    If KeyCode = vbKeyReturn Then  '->> Genera el ingreso de datos sobre la grilla, haciendo visible un texto sobre la celda seleccionada <<-'
  
        Let bPermiteEscribir = False
    
        If Grilla.ColSel = Col_Nominal Then:      Let TxtIngreso.CantidadDecimales = 4: Let bPermiteEscribir = True
        If Grilla.ColSel = Col_Tir Then:          Let TxtIngreso.CantidadDecimales = 4: Let bPermiteEscribir = True
        If Grilla.ColSel = Col_MT Then:           Let TxtIngreso.CantidadDecimales = 0: Let bPermiteEscribir = True
        If Grilla.ColSel = Col_ValInicial Then:   Let TxtIngreso.CantidadDecimales = 0: Let bPermiteEscribir = True
        
        If KeyCode = vbKeyV Or KeyCode = vbKeyR Then
            bPermiteEscribir = False
        End If
        
        If ((oPagoParcial Or EstaPagando) And Grilla.ColSel = Col_Tir) Then
            bPermiteEscribir = False
        End If
        
        If Grilla.TextMatrix(Grilla.RowSel, COL_Serie) = "" Then
            bPermiteEscribir = False
        End If

        
        If bPermiteEscribir = True Then
            Call PROC_POSI_TEXTO(Grilla, TxtIngreso)
          ' If KeyCode = vbKeyReturn Then
            TxtIngreso.text = CDbl(Grilla.TextMatrix(Grilla.RowSel, Grilla.ColSel))
            TxtIngreso.SelLength = Len(TxtIngreso.text)
        
            Let TxtIngreso.Visible = True
            Let TxtIngreso.text = Grilla.TextMatrix(Grilla.RowSel, Grilla.ColSel)
            Let Grilla.Enabled = False
            Let Toolbar1.Enabled = False
            Call TxtIngreso.SetFocus
        End If
    End If
        
        
    If KeyCode = vbKeyV Then '->> Genera venta del Documento Seleccionado <<-'
    ' PRD-6005
      Toolbar1.Buttons(5).Enabled = True     'PRD-6010
      If Grilla.RowSel Then
        If CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)) = 0 Then
           Call MsgBox("No existe nominal disponible.", vbExclamation, App.Title)
           Let Me.MousePointer = vbDefault
           Exit Sub
           
        Else
        
           If TomarPapel Then
               Call Valorizacion_Fli(vbKeyV)
           End If
        End If
      
        
      End If
      ' PRD-6005
    End If
        
        
    If KeyCode = vbKeyR Then   '->> Genera la Restauración del Documento Seleccionado <<-'
        Let GrillaSoma.Rows = 1
        If GrillaSoma.Rows > GrillaSoma.FixedRows Then
            Let GrillaSoma.Rows = 1
            GridFolioSOMA.Clear
            Let GridFolioSOMA.Rows = 1
          ' Let grilla.Rows = 1
          ' PRD-6010
          ' Call SoltarTodos
          ' Let grilla.Col = nColumna
            Let Me.MousePointer = vbDefault
            Exit Sub
        End If
        
        Call SoltarPapel
        
        Let Grilla.TextMatrix(Grilla.RowSel, Col_Nominal) = Format(CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)), FDec4Dec)
        Let Grilla.TextMatrix(Grilla.RowSel, Col_Tir) = Format(CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Tir_ORIG)), FDec4Dec)
        Let Grilla.TextMatrix(Grilla.RowSel, Col_VPar) = Format(CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_VPar_ORIG)), FDec4Dec)
        Let Grilla.TextMatrix(Grilla.RowSel, Col_MT) = Format(CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_MT_ORIG)), FDec0Dec)
        Let Grilla.TextMatrix(Grilla.RowSel, Col_Margen) = Format(CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Margen_ORIG)), FDec4Dec)
        Let Grilla.TextMatrix(Grilla.RowSel, Col_ValInicial) = Format(CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_ValInicial_ORIG)), FDec0Dec)
    End If
        
    Let Grilla.Col = nColumna
    Let Me.MousePointer = vbDefault
    
End Sub


Private Function GrabarFli()
Dim nNumOperacion               As Long
Dim nContador                   As Long
Dim objdatosoperacion           As New colOperaciones
Dim Datos()
   
    Let Me.MousePointer = vbHourglass
    
    Call Func_Limpiar_Estr_Grabar
    
    Set BacFrmIRF = BacTrader.ActiveForm
    Let BacFrmIRF.Tag = "FLI"
    Let BacGrabar.TipOper = "FLI"
    
    Let nFolioSOMA = TxtFolioSoma.text   'PRD-6010
    
    Call BacIrfGr.Show(vbModal)
    
    If giAceptar Then
        objdatosoperacion.Rutcart = BacGrabar.Rutcart
        objdatosoperacion.DigCart = BacGrabar.DigCart
        objdatosoperacion.TipCart = BacGrabar.TipCart
        objdatosoperacion.ForPagoIni = BacGrabar.ForPagoIni
        objdatosoperacion.ForPagoVcto = BacGrabar.ForPagoVcto
        objdatosoperacion.VamosVienen = BacGrabar.VamosVienen
        objdatosoperacion.RutCliente = BacGrabar.RutCliente
        objdatosoperacion.NomCliente = BacGrabar.NomCliente
        objdatosoperacion.CodCliente = BacGrabar.CodCliente
        objdatosoperacion.Observ = BacGrabar.Observ
        objdatosoperacion.Mercado = BacGrabar.Mercado
        objdatosoperacion.Sucursal = BacGrabar.Sucursal
        objdatosoperacion.AreaResponsable = BacGrabar.AreaResponsable
        objdatosoperacion.Fecha_PagoMañana = BacGrabar.Fecha_PagoMañana
        objdatosoperacion.Laminas = BacGrabar.Laminas
        objdatosoperacion.Tipo_Inversion = BacGrabar.Tipo_Inversion
        objdatosoperacion.CtaCteInicio = BacGrabar.CtaCteInicio
        objdatosoperacion.SucInicio = BacGrabar.SucInicio
        objdatosoperacion.CtaCteFinal = BacGrabar.CtaCteFinal
        objdatosoperacion.SucFinal = BacGrabar.SucFinal
        objdatosoperacion.costoFondoOperacionesOr = BacGrabar.costoFondoOrigen
        objdatosoperacion.costoFondoOperacionesFi = BacGrabar.costoFondoFinal
        objdatosoperacion.CodOrigen = BacGrabar.CodOrigen
        objdatosoperacion.CodDestino = BacGrabar.CodDestino
        objdatosoperacion.CodEjecutivo = BacGrabar.CodEjecutivo
        objdatosoperacion.Observ = BacGrabar.Observ
        objdatosoperacion.custodia = BacGrabar.custodia
   
   
        If Not BacBeginTransaction Then
            Let Me.MousePointer = vbDefault
            Exit Function
        End If
      
        If Not Bac_Sql_Execute("SP_OPMDAC") Then
            Let Me.MousePointer = vbDefault
            Call MsgBox("Se ha generado un error al intentar leer el correlativo de operación.", vbExclamation, App.Title)
            Exit Function
        End If
      
        If Bac_SQL_Fetch(Datos()) Then
            nNumOperacion = Val(Datos(1))
        End If
      
        For nContador = 1 To Me.GrillaGrabarFli.Rows - 1
         
        ' Envia = Array()
        ' AddParam Envia, nNumOperacion
        ' AddParam Envia, objdatosoperacion.Rutcart
        ' AddParam Envia, Val(objdatosoperacion.TipCart)
'
        ' AddParam Envia, Str(GrillaGrabarFli.TextMatrix(nContador, 0))    '--> oColVentas(iCorrela).NumeroDocumento
        ' AddParam Envia, Str(GrillaGrabarFli.TextMatrix(nContador, 1))    '--> oColVentas(iCorrela).Correlativo
        ' AddParam Envia, Str(GrillaGrabarFli.TextMatrix(nContador, 2))    '--> oColVentas(iCorrela).NominalVenta
'         AddParam Envia, Str(GrillaGrabarFli.TextMatrix(nContador, 3))    '--> oColVentas(iCorrela).TirVenta
'         AddParam Envia, Str(GrillaGrabarFli.TextMatrix(nContador, 4))    '--> oColVentas(iCorrela).PVPVenta
'         AddParam Envia, Str(GrillaGrabarFli.TextMatrix(nContador, 5))    '--> oColVentas(iCorrela).ValorVenta
'         AddParam Envia, 0                                                 '--> oColVentas(iCorrela).ValorVenta100
'         AddParam Envia, Str(GrillaGrabarFli.TextMatrix(nContador, 7))    '--> oColVentas(iCorrela).TasaEstimada
'         AddParam Envia, Str(GrillaGrabarFli.TextMatrix(nContador, 8))    '--> oColVentas(iCorrela).VParVenta
'         AddParam Envia, Str(GrillaGrabarFli.TextMatrix(nContador, 9))    '--> oColVentas(iCorrela).NumUltCup
'
        ' AddParam Envia, objdatosoperacion.RutCliente
        ' AddParam Envia, objdatosoperacion.CodCliente
        ' AddParam Envia, objdatosoperacion.custodia
        ' AddParam Envia, objdatosoperacion.ForPagoIni
        ' AddParam Envia, objdatosoperacion.ForPagoVcto
        ' AddParam Envia, objdatosoperacion.VamosVienen
        ' AddParam Envia, gsBac_User
        ' AddParam Envia, gsBac_Term
'
'         'Datos del Pacto
        ' AddParam Envia, Format(TxtFecIni.Text, "yyyymmdd")
        ' AddParam Envia, 999
        ' AddParam Envia, 0
        ' AddParam Envia, 0
'
'       ' ------------------- VB +- 09/07/2009
        ' AddParam Envia, Str(GrillaGrabarFli.TextMatrix(nContador, 24)) ' VB+-09/072009 Se cambia el monto inicial Total que se enviaba
        ' AddParam Envia, Str(GrillaGrabarFli.TextMatrix(nContador, 24)) ' VB+-09/072009 por el correspondiente al del registro
'       ' AddParam Envia, CDbl(txtIniPMP.Text)
'         '----------------------------------------------                ' VB +- 09/07/2009
        ' AddParam Envia, GrillaGrabarFli.TextMatrix(nContador, 10)      '--> oColVentas(iCorrela).InstSer
        ' AddParam Envia, GrillaGrabarFli.TextMatrix(nContador, 11)      '--> oColVentas(iCorrela).RutEmisor
        ' AddParam Envia, GrillaGrabarFli.TextMatrix(nContador, 12)      '--> oColVentas(iCorrela).MonedaEmision
'         AddParam Envia, GrillaGrabarFli.TextMatrix(nContador, 13)      '--> Format(oColVentas(iCorrela).FechaEmision, "YYYYMMDD")
'         AddParam Envia, GrillaGrabarFli.TextMatrix(nContador, 14)      '--> Format(oColVentas(iCorrela).FechaVencimiento, "YYYYMMDD")
        ' AddParam Envia, nContador
'         AddParam Envia, GrillaGrabarFli.TextMatrix(nContador, 15)      '--> Format(oColVentas(iCorrela).FecProxCupon, "YYYYMMDD")
'
'         AddParam Envia, Str(GrillaGrabarFli.TextMatrix(nContador, 16)) '--> oColVentas(iCorrela).Convexidad
'         AddParam Envia, Str(GrillaGrabarFli.TextMatrix(nContador, 17)) '--> oColVentas(iCorrela).DurationModificado
'         AddParam Envia, Str(GrillaGrabarFli.TextMatrix(nContador, 18)) '--> oColVentas(iCorrela).DurationMacaulay
'
'         AddParam Envia, GrillaGrabarFli.TextMatrix(nContador, 19)      '--> oColVentas(iCorrela).custodia
'         AddParam Envia, GrillaGrabarFli.TextMatrix(nContador, 20)      '--> oColVentas(iCorrela).ClaveDCV
'         AddParam Envia, Str(GrillaGrabarFli.TextMatrix(nContador, 23)) '--> vb +-07/10/2009   para manejar el Margen
'         AddParam Envia, Str(GrillaGrabarFli.TextMatrix(nContador, 24)) '--> vb + 13/10/2009   Para manejar el Valor inicial del FLI
'         AddParam Envia, GrillaGrabarFli.TextMatrix(nContador, 21)      '--> oColVentas(iCorrela).CarteraSuper
        ' AddParam Envia, objdatosoperacion.TipCart
        ' AddParam Envia, objdatosoperacion.Mercado
        ' AddParam Envia, objdatosoperacion.Sucursal
        ' AddParam Envia, objdatosoperacion.AreaResponsable
        ' AddParam Envia, objdatosoperacion.Fecha_PagoMañana
        ' AddParam Envia, objdatosoperacion.Laminas
        ' AddParam Envia, objdatosoperacion.Tipo_Inversion
        ' AddParam Envia, objdatosoperacion.CtaCteInicio
        ' AddParam Envia, objdatosoperacion.SucInicio
        ' AddParam Envia, objdatosoperacion.CtaCteFinal
        ' AddParam Envia, objdatosoperacion.SucFinal
        ' AddParam Envia, objdatosoperacion.Observ
        ' AddParam Envia, GrillaGrabarFli.TextMatrix(nContador, 22)      '--> oColVentas(iCorrela).DiasDisponibles
'         AddParam Envia, Str(GrillaGrabarFli.TextMatrix(nContador, 23)) '--> oColVentas(iCorrela).Margen
'         AddParam Envia, Str(GrillaGrabarFli.TextMatrix(nContador, 24)) '--> oColVentas(iCorrela).ValorInicial
'
'
'
'         If GrillaSoma.Rows > GrillaSoma.FixedRows Then
'            Dim nNumeroSOMA   As Long
'            Let nNumeroSOMA = LeeCorrelativoSOMA
'            AddParam Envia, nNumeroSOMA                                 '--> oColVentas(iCorrela).Corr_SOMA
'            AddParam Envia, nNumeroSOMA                                 '--> oColVentas(iCorrela).NumOper_SOMA
'        Else
'            AddParam Envia, 0                                           '--> oColVentas(iCorrela).Corr_SOMA
'            AddParam Envia, 0                                           '--> oColVentas(iCorrela).NumOper_SOMA
'
'         End If
'
'
'         If Not Bac_Sql_Execute("SP_GRABARFLI", Envia) Then
'            Let Me.MousePointer = vbDefault
'            Call BacRollBackTransaction
'            Call MsgBox("Se ha producido un error en la Grabacion de la Operación.", vbCritical, App.Title)
'            Exit Function
'         End If
        
        
            cSql = "EXECUTE dbo.SP_GRABARFLI  "
            cSql = cSql & nNumOperacion & ","                                           '--> 01
            cSql = cSql & objdatosoperacion.Rutcart & ","                               '--> 02
            cSql = cSql & Val(objdatosoperacion.TipCart) & ","                          '--> 03
            cSql = cSql & GrillaGrabarFli.TextMatrix(nContador, 0) & ","                '--> 04
            cSql = cSql & GrillaGrabarFli.TextMatrix(nContador, 1) & ","                '--> 05
            cSql = cSql & BacMontoFli(GrillaGrabarFli.TextMatrix(nContador, 2)) & ","   '--> 06
            cSql = cSql & BacMontoFli(GrillaGrabarFli.TextMatrix(nContador, 3)) & ","   '--> 07
            cSql = cSql & BacMontoFli(GrillaGrabarFli.TextMatrix(nContador, 4)) & ","   '--> 08
            cSql = cSql & BacMontoFli(GrillaGrabarFli.TextMatrix(nContador, 5)) & ","   '--> 09
            cSql = cSql & 0 & ","                                                       '--> 10
            cSql = cSql & BacMontoFli(GrillaGrabarFli.TextMatrix(nContador, 7)) & ","   '--> 11
            cSql = cSql & BacMontoFli(GrillaGrabarFli.TextMatrix(nContador, 8)) & ","   '--> 12
            cSql = cSql & GrillaGrabarFli.TextMatrix(nContador, 9) & ","                '--> 13
            cSql = cSql & objdatosoperacion.RutCliente & ","                            '--> 14
            cSql = cSql & objdatosoperacion.CodCliente & ","                            '--> 15
            cSql = cSql & "'" & objdatosoperacion.custodia & "',"                       '--> 16 Custodia
            cSql = cSql & objdatosoperacion.ForPagoIni & ","                            '--> 17
            cSql = cSql & objdatosoperacion.ForPagoVcto & ","                           '--> 18
            cSql = cSql & "'" & objdatosoperacion.VamosVienen & "',"                    '--> 19
            cSql = cSql & "'" & gsBac_User & "',"                                       '--> 20
            cSql = cSql & "'" & gsBac_Term & "',"                                       '--> 21
            cSql = cSql & "'" & Format(TxtFecIni.text, "yyyymmdd") & "',"               '--> 22
            cSql = cSql & 999 & ","                                                     '--> 23
            cSql = cSql & 0 & ","                                                       '--> 24
            cSql = cSql & 0 & ","                                                       '--> 25
            cSql = cSql & BacMontoFli(GrillaGrabarFli.TextMatrix(nContador, 24)) & ","  '--> 26
            cSql = cSql & BacMontoFli(GrillaGrabarFli.TextMatrix(nContador, 24)) & ","  '--> 27
            cSql = cSql & "'" & GrillaGrabarFli.TextMatrix(nContador, 10) & "',"        '--> 28
            cSql = cSql & GrillaGrabarFli.TextMatrix(nContador, 11) & ","               '--> 29
            cSql = cSql & GrillaGrabarFli.TextMatrix(nContador, 12) & ","               '--> 30
            cSql = cSql & "'" & GrillaGrabarFli.TextMatrix(nContador, 13) & "',"        '--> 31
            cSql = cSql & "'" & GrillaGrabarFli.TextMatrix(nContador, 14) & "',"        '--> 32
            cSql = cSql & nContador & ","                                               '--> 33
            cSql = cSql & "'" & GrillaGrabarFli.TextMatrix(nContador, 15) & "',"        '--> 34
            cSql = cSql & BacMontoFli(GrillaGrabarFli.TextMatrix(nContador, 16)) & ","  '--> 35
            cSql = cSql & BacMontoFli(GrillaGrabarFli.TextMatrix(nContador, 17)) & ","  '--> 36
            cSql = cSql & BacMontoFli(GrillaGrabarFli.TextMatrix(nContador, 18)) & ","  '--> 37
            cSql = cSql & "'" & GrillaGrabarFli.TextMatrix(nContador, 19) & "',"        '--> 38
            cSql = cSql & "'" & GrillaGrabarFli.TextMatrix(nContador, 20) & "',"        '--> 39
            cSql = cSql & BacMontoFli(GrillaGrabarFli.TextMatrix(nContador, 23)) & ","  '--> 40
            cSql = cSql & BacMontoFli(GrillaGrabarFli.TextMatrix(nContador, 24)) & ","  '--> 41
            cSql = cSql & "'" & GrillaGrabarFli.TextMatrix(nContador, 21) & "',"        '--> 42
            cSql = cSql & "'" & objdatosoperacion.TipCart & "',"                        '--> 43
            cSql = cSql & "'" & objdatosoperacion.Mercado & "',"                        '--> 44
            cSql = cSql & "'" & objdatosoperacion.Sucursal & "',"                       '--> 45
            cSql = cSql & "'" & objdatosoperacion.AreaResponsable & "',"                '--> 46
            cSql = cSql & "'" & Format(objdatosoperacion.Fecha_PagoMañana, feFECHA) & "'," '--> 47
            cSql = cSql & "'" & objdatosoperacion.Laminas & "',"                        '--> 48
            cSql = cSql & "'" & objdatosoperacion.Tipo_Inversion & "',"                 '--> 49
            cSql = cSql & "'" & objdatosoperacion.CtaCteInicio & "',"                   '--> 50
            cSql = cSql & "'" & objdatosoperacion.SucInicio & "',"                      '--> 51
            cSql = cSql & "'" & objdatosoperacion.CtaCteFinal & "',"                    '--> 52
            cSql = cSql & "'" & objdatosoperacion.SucFinal & "',"                       '--> 53
            cSql = cSql & "'" & objdatosoperacion.Observ & "',"                         '--> 54
            cSql = cSql & GrillaGrabarFli.TextMatrix(nContador, 22) & ","               '--> 55
            cSql = cSql & BacMontoFli(GrillaGrabarFli.TextMatrix(nContador, 23)) & ","  '--> 56
            cSql = cSql & BacMontoFli(GrillaGrabarFli.TextMatrix(nContador, 24)) & ","  '--> 57

        
            If GrillaSoma.Rows > GrillaSoma.FixedRows Then
                Dim nNumeroSOMA   As Long
                Let nNumeroSOMA = LeeCorrelativoSOMA
                
                cSql = cSql & nNumeroSOMA & ","                                         '--> 58
                cSql = cSql & nNumeroSOMA & ","                                         '--> 59
                

            Else
                cSql = cSql & 0 & ","                                                   '--> 58
                cSql = cSql & 0 & ","                                                   '--> 59
            End If
             cSql = cSql & BacMontoFli(GrillaGrabarFli.TextMatrix(nContador, 26)) & "," '--> 60  PRD-6007
             cSql = cSql & "'" & "FLI" & "',"                 '--> 61  PRD-6007
             If CheckFolioSOMAManual.Value = 1 Then
                cSql = cSql & nFolioSOMA & ","                '--> 62  PRD-6010
                cSql = cSql & TraeCorrelativoBCCH(nFolioSOMA) '--> 63  PRD-6010
             Else
                cSql = cSql & GrillaGrabarFli.TextMatrix(nContador, 27) & "," '--> 62  PRD-6010
                cSql = cSql & GrillaGrabarFli.TextMatrix(nContador, 28) & "," '--> 63  PRD-6010
             End If
                cSql = cSql & CheckFolioSOMAManual.Value & ","                '-->     PRD-6010
                cSql = cSql & "'" & cNombreArchivo & "'"                      '-->     PRD-6010
                 

         
            If miSQL.SQL_Execute(cSql) <> 0 Then
                Let Me.MousePointer = vbDefault
                Call BacRollBackTransaction
                Call MsgBox("Se ha producido un error en la Grabacion de la Operación.", vbCritical, App.Title)
                Exit Function
            End If
         
         
         Envia = Array()
         AddParam Envia, objdatosoperacion.Rutcart
         AddParam Envia, CDbl(GrillaGrabarFli.TextMatrix(nContador, 0))    '--> Documento
         AddParam Envia, CDbl(GrillaGrabarFli.TextMatrix(nContador, 1))    '--> Correlativo
         AddParam Envia, MihWnd                                            '--> Ventana
         AddParam Envia, gsBac_User                                        '--> Usuario
         AddParam Envia, nNumOperacion
         If Not Bac_Sql_Execute("SP_GRABACORTES_FLI", Envia) Then
            Let Me.MousePointer = vbDefault
            Call BacRollBackTransaction
            Call MsgBox("Se ha producido un error en la Grabacion de los cortes.", vbCritical, App.Title)
            Exit Function
         End If
      
         If gsBac_Lineas = "S" Then
            Envia = Array()
            AddParam Envia, nNumOperacion
            AddParam Envia, CDbl(GrillaGrabarFli.TextMatrix(nContador, 0))
            AddParam Envia, CDbl(GrillaGrabarFli.TextMatrix(nContador, 1))
            AddParam Envia, nContador
            AddParam Envia, objdatosoperacion.RutCliente
            AddParam Envia, objdatosoperacion.CodCliente
            AddParam Envia, gsBac_User
            AddParam Envia, gsBac_Fecp
            AddParam Envia, Format(TxtFecIni.text, "yyyymmdd")
            AddParam Envia, CDbl(GrillaGrabarFli.TextMatrix(nContador, 5))
            If Not Bac_Sql_Execute("SP_LINEAS_FLI", Envia) Then
               Let Me.MousePointer = vbDefault
               Call BacRollBackTransaction
               Call MsgBox("Se ha producido un error en la Grabacion de Líneas para el FLI.", vbCritical, App.Title)
               Exit Function
            End If
         End If
      
      Next nContador
      
'-- >   GRABACION GENERAL DEL FLI
' -------------------------------------- < --
    Call GrabaGeneral_Fli(nNumOperacion, "FLI", Str(Me.txtVenPMP.text), 0)
'-- >
   'PRD-6010
    Envia = Array()
    AddParam Envia, 1    'Evento Graba Tipo de Archivo SOMA
    AddParam Envia, CDbl(FRM_Archivo_SOMA.TipoArchivoSOMA)
    If Not Bac_Sql_Execute("dbo.SP_TRAE_GRABA_TIPO_ARCH_SOMA_ULT_CARGA", Envia) Then
       Let Me.MousePointer = vbDefault
       Call BacRollBackTransaction
       Call MsgBox("Se ha producido un error en la Grabacion de tipo de archivo SOMA.", vbCritical, App.Title)
       Exit Function
    End If
    'PRD-6010
    
      
      If Not BacCommitTransaction Then
         Let Me.MousePointer = vbDefault
         Call MsgBox("Se ha producido un error al confirmar la operación FLI.", vbCritical, App.Title)
      End If

      Let Me.MousePointer = vbDefault
      Call MsgBox("Operación fue grabada con éxito " & vbCrLf & vbCrLf & "Número de Operación: " & nNumOperacion, vbInformation, App.Title)
      
      Call Resumen_Folios_SOMA_Cargados(cNombreArchivo)     'PRD-6010
      
      Call LimpiarPantalla
      
   End If
    Me.MousePointer = 0
End Function

Private Function LimpiarPantalla()
   bDistribucionManual = False
   Call SoltarTodos
   Let Grilla.Rows = 1
   Let GrillaGrabarFli.Rows = 1
   Let GrillaSoma.Rows = 1
   Call ActualizaMontoOperacion
   
   Call SettingGridVisible(Grilla)
   
   Let Toolbar1.Buttons(1).Enabled = False
   Let Toolbar1.Buttons(3).Enabled = True
   Let Toolbar1.Buttons(10).Enabled = False
   Let Toolbar1.Buttons(11).Enabled = False
   
   Let Toolbar1.Buttons(5).Tag = "Ver Sel."
   Let Toolbar1.Buttons(5).ToolTipText = "Ver Selección"
   Let Toolbar1.Buttons(5).Enabled = True
   
End Function

Private Function LeeCorrelativoSOMA() As Long
   Dim Datos()
   
   Let LeeCorrelativoSOMA = 1

   If Not Bac_Sql_Execute("SP_ENTREGA_CORREL_SOMA") Then
      Exit Function
   End If
   Do While Bac_SQL_Fetch(Datos())
      LeeCorrelativoSOMA = IIf(Datos(1) = 0, 1, Datos(1))
   Loop
End Function

Private Sub CargaGrillaGrabar()
   Dim Datos()
   
   Let GrillaGrabarFli.Rows = 2: Let GrillaGrabarFli.cols = 29   'PRD-6007
    
   Let GrillaGrabarFli.TextMatrix(0, 0) = "Documento"
   Let GrillaGrabarFli.TextMatrix(0, 1) = "Correlativo"
   Let GrillaGrabarFli.TextMatrix(0, 2) = "NominalVenta"
   Let GrillaGrabarFli.TextMatrix(0, 3) = "TirVenta"
   Let GrillaGrabarFli.TextMatrix(0, 4) = "PvpVenta"
   Let GrillaGrabarFli.TextMatrix(0, 5) = "ValorVenta"
   Let GrillaGrabarFli.TextMatrix(0, 7) = "TasaEstimada"
   Let GrillaGrabarFli.TextMatrix(0, 8) = "VParVenta"
   Let GrillaGrabarFli.TextMatrix(0, 9) = "NumUltCup"
   Let GrillaGrabarFli.TextMatrix(0, 10) = "InstSer"
   Let GrillaGrabarFli.TextMatrix(0, 11) = "RutEmisor"
   Let GrillaGrabarFli.TextMatrix(0, 12) = "MonedaEmision"
   Let GrillaGrabarFli.TextMatrix(0, 13) = "FechaEmision"
   Let GrillaGrabarFli.TextMatrix(0, 14) = "FechaVencimiento"
   Let GrillaGrabarFli.TextMatrix(0, 15) = "FecProxCupon"
   Let GrillaGrabarFli.TextMatrix(0, 16) = "Convexidad"
   Let GrillaGrabarFli.TextMatrix(0, 17) = "DurationModificado"
   Let GrillaGrabarFli.TextMatrix(0, 18) = "DurationMacaulay"
   Let GrillaGrabarFli.TextMatrix(0, 19) = "custodia"
   Let GrillaGrabarFli.TextMatrix(0, 20) = "ClaveDCV"
   Let GrillaGrabarFli.TextMatrix(0, 21) = "CarteraSuper"
   Let GrillaGrabarFli.TextMatrix(0, 22) = "DiasDisponibles"
   Let GrillaGrabarFli.TextMatrix(0, 23) = "Margen"
   Let GrillaGrabarFli.TextMatrix(0, 24) = "ValorInicial"
    Let GrillaGrabarFli.TextMatrix(0, 25) = "CarteraSuper"
   Let GrillaGrabarFli.TextMatrix(0, 26) = "HairCut"      'PRD-6007
   Let GrillaGrabarFli.TextMatrix(0, 27) = "IDSoma"       'PRD-6010
   Let GrillaGrabarFli.TextMatrix(0, 28) = "CorrelaSoma"  'PRD-6010
   
   
   
   Envia = Array()
   AddParam Envia, gsBac_User
   AddParam Envia, MihWnd
   If Not Bac_Sql_Execute("DBO.SP_PREGRABADO_FLI", Envia) Then
      Exit Sub
   End If
   Let GrillaGrabarFli.Rows = 1
   
   Do While Bac_SQL_Fetch(Datos())
      Let GrillaGrabarFli.Rows = GrillaGrabarFli.Rows + 1
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 0) = Datos(1)                       '--> "Documento"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 1) = Datos(2)                       '--> "Correlativo"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 2) = Datos(3)                       '--> "NominalVenta"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 3) = Datos(4)                       '--> "TirVenta"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 4) = Datos(5)                       '--> "PvpVenta"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 5) = Datos(6)                       '--> "ValorVenta"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 7) = Datos(7)                       '--> "TasaEstimada"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 8) = Datos(8)                       '--> "VParVenta"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 9) = Datos(9)                       '--> "NumUltCup"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 10) = Datos(10)                     '--> "InstSer"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 11) = Datos(11)                     '--> "RutEmisor"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 12) = Datos(12)                     '--> "MonedaEmision"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 13) = Format(Datos(13), "YYYYMMDD") '--> "FechaEmision"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 14) = Format(Datos(14), "YYYYMMDD") '--> "FechaVencimiento"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 15) = Format(Datos(15), "YYYYMMDD") '--> "FecProxCupon"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 16) = Datos(16)                     '--> "Convexidad"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 17) = Datos(17)                     '--> "DurationModificado"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 18) = Datos(18)                     '--> "DurationMacaulay"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 19) = Datos(19)                     '--> "custodia"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 20) = "" '--> FUNC_GENERA_CLAVE_DCV         '->>> DATOS(20) '--> "ClaveDCV"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 21) = Datos(21)                     '--> "CarteraSuper"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 22) = Datos(22)                     '--> "DiasDisponibles"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 23) = Datos(23)                     '--> "Margen"
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 24) = Datos(24)                     '--> "ValorInicial"
        Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 25) = Datos(25)                     '--> "CarteraSuper" VB+- 25/01/2010
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 26) = Datos(26)  'PRD-6007                   '--> 'PRD-6007
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 27) = Datos(27)  'PRD-6010                   '--> 'PRD-6010
      Let GrillaGrabarFli.TextMatrix(GrillaGrabarFli.Rows - 1, 28) = Datos(28)  'PRD-6010                   '--> 'PRD-6010
      
   Loop

End Sub


' -------------------------------------------------------------------------------------------
Private Sub GrabaGeneral_Fli(nNumOperacion As Long, sTipoOperacion As String, dTotalOperacion As Double, iPago As Integer)
' -------------------------------------------------------------------------------------------
'
'
'
' ===========================================================================================
Dim irows As Long


    Envia = Array()
    AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")                    '--> Fecha Operacion
    AddParam Envia, nNumOperacion                                     '--> Documento
    AddParam Envia, sTipoOperacion                                    '--> Tipo Operacion
    AddParam Envia, dTotalOperacion                                   '--> Total Operacion
    AddParam Envia, iPago                                             '--> Pago
    AddParam Envia, gsBac_User                                        '--> Usuario
         
    If Not Bac_Sql_Execute("DBO.SP_GRABA_FLI_GENERAL", Envia) Then
       Let Me.MousePointer = vbDefault
       Call BacRollBackTransaction
       Call MsgBox("Se ha producido un error en la Grabacion general del FLI.", vbCritical, App.Title)
       Exit Sub
    End If
    
    
    For irows = 1 To Grilla.Rows - 1
        If Grilla.TextMatrix(irows, Col_Marca) <> "" Then
            cSql = "EXECUTE DBO.SP_GRABA_PAPELETAFLI  "
            cSql = cSql & "'" & Format(gsBac_Fecp, "yyyymmdd") & "',"
            cSql = cSql & nNumOperacion & ",0,"
            cSql = cSql & "'" & Grilla.TextMatrix(irows, COL_Serie) & "',"
            cSql = cSql & Str(Grilla.TextMatrix(irows, Col_Nominal)) & ","
            cSql = cSql & Str(Grilla.TextMatrix(irows, Col_Tir)) & ","
            cSql = cSql & Str(Grilla.TextMatrix(irows, Col_MT)) & ","
            cSql = cSql & Str(Grilla.TextMatrix(irows, Col_Margen)) & ","
            cSql = cSql & Str(Grilla.TextMatrix(irows, Col_ValInicial)) & ","
            cSql = cSql & "'" & Grilla.TextMatrix(irows, Col_CodCarteraSuper) & "'" ' VB+-25/01/2010
            
'            Envia = Array()
'            AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")                    '--> Fecha Operacion
'            AddParam Envia, nNumOperacion                                     '--> Documento
'            AddParam Envia, 0
'            AddParam Envia, Grilla.TextMatrix(irows, COL_Serie)
'            AddParam Envia, Str(Grilla.TextMatrix(irows, Col_Nominal))
'            AddParam Envia, Str(Grilla.TextMatrix(irows, Col_Tir))
'            AddParam Envia, Str(Grilla.TextMatrix(irows, Col_MT))
'            AddParam Envia, Str(Grilla.TextMatrix(irows, Col_Margen))
'            AddParam Envia, Str(Grilla.TextMatrix(irows, Col_ValInicial))
'            AddParam Envia, Grilla.TextMatrix(irows, Col_CodCarteraSuper) ' VB+-25/01/2010
'            If Not Bac_Sql_Execute("DBO.SP_GRABA_PAPELETAFLI", Envia) Then
             If miSQL.SQL_Execute(cSql) <> 0 Then
               Let Me.MousePointer = vbDefault
               Call BacRollBackTransaction
               Call MsgBox("Se ha producido un error en la Grabacion general del FLI.", vbCritical, App.Title)
               Exit Sub
            End If
            
        End If
        
    Next irows


End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim dNumdocu    As Long
Dim Datos()

    Select Case Button.Index
        Case 1
            If EstaPagando = False Then
                If Not Chequea_Parametros(ACSW_PD, varGsMsgPD, 0) Then
                    Exit Sub
                End If
                
                If ValidaPapelesaGrabar = False Then
                    Exit Sub
                End If
   
                Call CargaGrillaGrabar
                Call GrabarFli
            End If
         
          ' _________________________________________________
          ' se realiza el pago del FLI
          ' =================================================
            If EstaPagando = True Then
            
                If MsgBox("¿Esta seguro de grabar la transaccion de pago Parcial?", vbQuestion + vbYesNo + vbDefaultButton2, "Pago Parcial Fli") = vbNo Then
                    Exit Sub
                End If
                BacControlWindows 100
                If oPagoParcial = True Then

                    If CDbl(IIf(Me.txtdiferencia.text = "", 0, Me.txtdiferencia.text)) < 0 Then
                        Call MsgBox("la transaccion presenta saldo negativo, favor revisar datos ingresados", vbExclamation, App.Title)
                        Exit Sub
                    End If
                    
                    If Not ValidaPapelesaGrabarPAGOS Then
                        Exit Sub
                    End If
                    If Me.txtdiferencia.text = 0 Then
                        Call MsgBox("la transaccion no presenta pagos favor revisar datos ingresados", vbExclamation, App.Title)
                        Exit Sub
                    End If
                
                    If Not validaTOTALSaldoPendiente() Then
                        Call MsgBox("la transaccion presenta diferencias al pagar contra el saldo, favor revisar datos ingresados", vbExclamation, App.Title)
                        Exit Sub
                    End If
            
                    If Not BacBeginTransaction Then
                       Call MsgBox("Se ha producido un error en la transaccion para generar los pagos.", vbExclamation, App.Title)
                       Exit Sub
                    End If
               
                    Envia = Array()
                    AddParam Envia, CDbl(nNumOperFli)
                            
                    If Not Bac_Sql_Execute("SP_BUSCA_NUM_OPER_PAGOS", Envia) Then
                       Call BacRollBackTransaction
                       Call MsgBox("Se ha producido un error en la generación de los pagos.", vbExclamation, App.Title)
                       Exit Sub
                    End If
                    
                    If Bac_SQL_Fetch(Datos()) Then
                       dNumdocu = Val(Datos(1))
                    End If
                    
                    
                    Envia = Array()
                    AddParam Envia, nNumOperFli
                    AddParam Envia, gsBac_User
                    AddParam Envia, gsBac_Term
                    AddParam Envia, MihWnd
                    AddParam Envia, dNumdocu  ' --> Numero de pago
                    
                    If Not Bac_Sql_Execute("DBO.SP_PAGO_TOTAL_PARCIAL_FLI", Envia) Then
                        Call BacRollBackTransaction
                        Call MsgBox("Se ha producido un error en la generación de los pagos.", vbExclamation, App.Title)
                        Exit Sub
                    End If
                    
                    Envia = Array()
                    AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")                       '--> Fecha Operacion
                    AddParam Envia, nNumOperFli                                          '--> Documento
                    AddParam Envia, "FLIP"                                               '--> Tipo Operacion
                    AddParam Envia, Str(Me.txtdiferencia.text)                           '--> Total Operacion
                    AddParam Envia, dNumdocu                                             '--> Pago
                    AddParam Envia, gsBac_User                                           '--> Usuario
                    
                    If Not Bac_Sql_Execute("DBO.SP_GRABA_FLI_GENERAL", Envia) Then
                        Let Me.MousePointer = vbDefault
                        Call BacRollBackTransaction
                        Call MsgBox("Se ha producido un error en la Grabacion general del FLI.", vbCritical, App.Title)
                        Exit Sub
                    End If
                    
                    Dim irows As Long
                    
                    For irows = 1 To Grilla.Rows - 1
                    
                        If Grilla.TextMatrix(irows, Col_Marca) <> "V" Then
                            cSql = ""
                            cSql = cSql & "EXECUTE DBO.SP_GRABA_PAPELETAFLI "
                            cSql = cSql & "'" & Format(gsBac_Fecp, "yyyymmdd") & "',"
                            cSql = cSql & nNumOperFli & ","
                            cSql = cSql & dNumdocu & ","
                            cSql = cSql & "'" & Grilla.TextMatrix(irows, COL_Serie) & "',"
                        
                          '  Envia = Array()
                          '  AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")                    '--> Fecha Operacion
                          '  AddParam Envia, nNumOperFli                                     '--> Documento
                          '  AddParam Envia, dNumdocu
                          '  AddParam Envia, grilla.TextMatrix(irows, COL_Serie)
                            If Grilla.TextMatrix(irows, Col_Marca) = "P" Then
                              '  AddParam Envia, Str(grilla.TextMatrix(irows, Col_Nominal_ORIG) - grilla.TextMatrix(irows, Col_Nominal))
                                cSql = cSql & Str(Grilla.TextMatrix(irows, Col_Nominal_ORIG) - Grilla.TextMatrix(irows, Col_Nominal)) & ","
                            Else
                            '  AddParam Envia, Str(grilla.TextMatrix(irows, Col_Nominal_ORIG))
                                cSql = cSql & Str(Grilla.TextMatrix(irows, Col_Nominal_ORIG)) & ","
                            End If
                            
                          ' AddParam Envia, Str(grilla.TextMatrix(irows, Col_Tir))
                            cSql = cSql & Str(Grilla.TextMatrix(irows, Col_Tir)) & ","
                            
                            If Grilla.TextMatrix(irows, Col_Marca) = "P" Then
                              ' AddParam Envia, Str(grilla.TextMatrix(irows, Col_MT_ORIG) - grilla.TextMatrix(irows, Col_MT))
                                cSql = cSql & Str(Grilla.TextMatrix(irows, Col_MT_ORIG) - Grilla.TextMatrix(irows, Col_MT)) & ","
                            Else
                              ' AddParam Envia, Str(grilla.TextMatrix(irows, Col_MT_ORIG))
                                cSql = cSql & Str(Grilla.TextMatrix(irows, Col_MT_ORIG)) & ","
                            End If
                            
                          ' AddParam Envia, Str(grilla.TextMatrix(irows, Col_Margen))
                            cSql = cSql & Str(Grilla.TextMatrix(irows, Col_Margen)) & ","
                            
                            If Grilla.TextMatrix(irows, Col_Marca) = "P" Then
                              ' AddParam Envia, Str(grilla.TextMatrix(irows, Col_ValInicial_ORIG) - grilla.TextMatrix(irows, Col_ValInicial))
                                cSql = cSql & Str(Grilla.TextMatrix(irows, Col_ValInicial_ORIG) - Grilla.TextMatrix(irows, Col_ValInicial)) & ","
                            Else
                               ' AddParam Envia, Str(grilla.TextMatrix(irows, Col_ValInicial_ORIG))
                                cSql = cSql & Str(Grilla.TextMatrix(irows, Col_ValInicial_ORIG)) & ","
                            End If
                            
                          ' AddParam Envia, grilla.TextMatrix(irows, Col_CodCarteraSuper)
                            cSql = cSql & "'" & Grilla.TextMatrix(irows, Col_CodCarteraSuper) & "'"
                            If miSQL.SQL_Execute(cSql) <> 0 Then
                           ' If Not Bac_Sql_Execute("DBO.SP_GRABA_PAPELETAFLI", Envia) Then
                               Let Me.MousePointer = vbDefault
                               Call BacRollBackTransaction
                               Call MsgBox("Se ha producido un error en la Grabacion general del FLI.", vbCritical, App.Title)
                               Exit Sub
                            End If
                        End If
                    Next irows
                    
                    If Not BacCommitTransaction Then
                        Call MsgBox("Se ha producido un error en la confirmación de los pagos.", vbExclamation, App.Title)
                        Exit Sub
                    End If
            
                    Call MsgBox("Se ha generado correctamente el pago de la Operacion: " & gsNmoper_Fli, vbInformation, App.Title)
   
                    Let EstaPagando = False
                    Call LimpiarPantalla
                End If
            End If
            
        Case 3
            Call LimpiarPantalla  'PRD-6010
            Call Filtrar
            Call LimpiaGrillaErroresSOMA  'PRD-6010
            
            Me.Label(8).Caption = "Monto Pago"
            Me.Label(0).Caption = "Monto Saldo"
            Let nNumOperFli = 0
            Let EstaPagando = False
            Let oPagoParcial = False
            Let Toolbar1.Buttons(1).Enabled = True
            

        Case 4
        
            Me.Label(0).Caption = "Monto Pago"
            Me.Label(8).Caption = "Monto Saldo"

            Call Modificacion_Pago_Fli
            
            Let Toolbar1.Buttons(1).Enabled = True
            
            If Grilla.Rows > 2 Then
            
                If Grilla.TextMatrix(1, 2) <> "" Then
                    Let Toolbar1.Buttons(3).Enabled = True
                Else
                    Let Toolbar1.Buttons(3).Enabled = True
                End If
            End If
            
'PRD-6010
        Case 5
            Call SeleccionVentas
'PRD-6010
            
        Case 10
            Let Toolbar1.Buttons(10).Enabled = False
            Let Command1.Enabled = False
            Let PicProgree.Visible = True
            Let Progreso.Max = 50
            Let Progreso.Value = 0
            Let LblProgreso.Caption = "Cargando Archivo...  " & Trim(Progreso.Value) & " %"
            
            Call BacControlWindows(10)
            Call Me.Refresh
            ''Call LoadFile_Soma
            Call LimpiaGrillaErroresSOMA
            FRM_Archivo_SOMA.Show (vbModal)
            If bCargaArchivo Then
                SeleccionVentas
            End If
        Case 11
            Call Imprimir_Informe_Errores_SOMA

        Case 12 ''REQ.6006
            If EstaPagando Then
               MsgBox "Pago FLI no aplica ver detalle"
               Exit Sub
            End If
            If Grilla.TextMatrix(Grilla.RowSel, Col_Marca) <> "P" Then
               MsgBox "Advertencia: Solo Venta Parcial permite redistribuir cortes."
               'Exit Sub  'MAP 6006 Intervención bajo prueba interna
            End If
            
           If Grilla.Rows > 1 Then
           
                nMarca = Grilla.TextMatrix(Grilla.RowSel, 0)
                nSerie = Grilla.TextMatrix(Grilla.RowSel, 1)
                dTasaRef = Grilla.TextMatrix(Grilla.RowSel, 4)
                sCarteraNorm = Grilla.TextMatrix(Grilla.RowSel, 10)
                dNominal = Grilla.TextMatrix(Grilla.RowSel, 3)
                sCarteraNormCod = Grilla.TextMatrix(Grilla.RowSel, 19)
                dRutEmisor = Grilla.TextMatrix(Grilla.RowSel, Col_Emisor)
                Call BacFLIDet.Show(vbModal)
            Else
                nMarca = ""
                nSerie = ""
                dTasaRef = 0#
                sCarteraNorm = ""
                dNominal = 0#
                sCarteraNormCod = ""
                dRutEmisor = 0
                Call BacFLIDet.Show(vbModal)

            End If
            
        Case 13
            Call Unload(Me)

    End Select
    
End Sub

Private Function ControlOperativo(ByVal xTipo As String, ByVal nOperacion As Long) As Boolean
   Dim Datos()
   
   Let ControlOperativo = False
   
   Envia = Array()
   AddParam Envia, nOperacion
   AddParam Envia, xTipo
   If Not Bac_Sql_Execute("DBO.SP_CONTROL_FLI", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      Let ControlOperativo = IIf(Datos(1) < 0, False, True)
   End If
   
   If ControlOperativo = False Then
      Call MsgBox(Datos(2), vbExclamation, App.Title)
   End If
   
End Function

Private Function Modificacion_Pago_Fli()
   Dim Datos()
   
    If gsNmoper_Fli <> 0 Then
        Call SoltarTodos
    End If
   
   Let gsNmoper_Fli = 0
   Let oPagoParcial = False
   Let Tipo_Pago_total = False
   
   Let BacMod.SSOption1.Visible = False
   Call BacMod.Show(vbModal)

   Let oPagoParcial = Tipo_Pago_parcial
   
   

   If oPagoParcial = False And Tipo_Pago_total = False Then
      Let EstaPagando = False
   Else
      Let EstaPagando = True
   End If

   If Tipo_Pago_total = True Then
      Let nNumOperFli = gsNmoper_Fli
      Let EstaPagando = True
      
      If Not ControlOperativo("T", nNumOperFli) Then
         Exit Function
      End If
      
      Envia = Array()
      AddParam Envia, CDbl(nNumOperFli)
      AddParam Envia, "T"
      If Not Bac_Sql_Execute("SVC_CMP_NUM_OPR", Envia) Then
         Exit Function
      End If
      If Bac_SQL_Fetch(Datos()) Then
         If Datos(1) <> 0 Then
            Exit Function
         End If
      End If
      
      If Not BacBeginTransaction Then
         Call MsgBox("Se ha producido un error en la transaccion para generar los pagos.", vbExclamation, App.Title)
         Exit Function
      End If
      
      Envia = Array()
      AddParam Envia, nNumOperFli
      AddParam Envia, gsBac_User
      AddParam Envia, gsBac_Term
      AddParam Envia, MihWnd
      
      If Not Bac_Sql_Execute("DBO.SP_PAGO_TOTAL_FLI", Envia) Then
         Call BacRollBackTransaction
         Call MsgBox("Se ha producido un error en la generación de los pagos.", vbExclamation, App.Title)
         Exit Function
      End If
      
      If Not BacCommitTransaction Then
         Call MsgBox("Se ha producido un error en la confirmación de los pagos.", vbExclamation, App.Title)
         Exit Function
      End If
   
      Call MsgBox("Se ha generado correctamente el pago de la Operacion: " & gsNmoper_Fli, vbInformation, App.Title)
      Call LimpiarPantalla
   End If
   
   If EstaPagando = False Then
      Exit Function
   End If
   
   If Tipo_Pago_parcial = True Then
      Let nNumOperFli = gsNmoper_Fli
      Let oPagoParcial = True
      Let EstaPagando = True
      
      Envia = Array()
      AddParam Envia, nNumOperFli
      AddParam Envia, gsBac_User
      AddParam Envia, MihWnd
      
      If Not Bac_Sql_Execute("DBO.SP_FILTRO_FLI_PPARCIAL", Envia) Then
         Let Screen.MousePointer = vbDefault
         Call MsgBox("Se ha originado un error en la lectura de operaciones." & vbCrLf & vbCrLf & VerSql, vbExclamation, App.Title)
         Exit Function
      End If
      
      Let Grilla.Rows = 1
      
      Do While Bac_SQL_Fetch(Datos())
         Let Grilla.Rows = Grilla.Rows + 1
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Marca) = ""
         Let Grilla.TextMatrix(Grilla.Rows - 1, COL_Serie) = Datos(1)
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Moneda) = Datos(2)
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Nominal) = Format(Datos(3), FDec4Dec)
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Tir) = Format(Datos(4), FDec4Dec)
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_VPar) = Format(Datos(5), FDec4Dec)
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_MT) = Format(Datos(6), FDec0Dec)
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_PlzRes) = Format(Datos(7), FDec0Dec)
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Margen) = Format(Datos(8), FDec4Dec)
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_ValInicial) = Format(Datos(9), FDec0Dec)
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Custodia) = "DCV"
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_ClaveDcv) = ""
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_CarteraSuper) = Datos(10)
   
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Nominal_ORIG) = Format(Datos(3), FDec4Dec)
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Tir_ORIG) = Format(Datos(4), FDec4Dec)
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_VPar_ORIG) = Format(Datos(5), FDec4Dec)
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_MT_ORIG) = Format(Datos(6), FDec4Dec)
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Margen_ORIG) = Format(Datos(8), FDec4Dec)
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_ValInicial_ORIG) = Format(Datos(9), FDec0Dec)
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_CodCarteraSuper) = Datos(11)
         
      
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_BloqueoPacto) = 0 'Format(DATOS(12), FDec4Dec)  ' PRD-6005
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_HairCut) = 0      'Format(DATOS(13), FDec4Dec)       ' PRD-6007
         'Call ChangeColorSetting(grilla.Rows - 1, Normal)
         ' PRD-6005
         'If CDbl(GRILLA.TextMatrix(GRILLA.Rows - 1, Col_BloqueoPacto)) <> 0 Then
         '  Call ChangeColorSetting(GRILLA.Rows - 1, BloqueoPacto)
         'End If
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_ID_SOMA) = 0  ' PRD-6010
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Correla_SOMA) = 0  ' PRD-6010
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Emisor) = 0       'Format(DATOS(14), FDec0Dec)       ' PRD-6006
         Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Nemo_Emisor) = "" 'Trim(DATOS(15))      ' PRD-6006
         
         
         
      Loop
   
      Let Me.MousePointer = vbDefault
      Call ActualizaMontoPAGO
      
      
   End If
   
End Function


Private Function Valorizacion_Fli(ByVal xTecla As KeyCodeConstants)
Dim nMargen As Double
Dim Datos()
Dim sCalculoVInicial As String * 1
Dim dMontoNominalOriginal As Double
Dim dMontoPresenteOriginal As Double
Dim dRespaldoNominal    As Double

    If xTecla = vbKeyV Then
        Let nModoCalculo = 3
        Let nFactor = 0
    Else
        If Grilla.ColSel = Col_Marca Then: Let nModoCalculo = 2
        If Grilla.ColSel = Col_Nominal Then: Let nModoCalculo = 2
        If Grilla.ColSel = Col_Tir Then: Let nModoCalculo = 2
        If Grilla.ColSel = Col_MT Then: Let nModoCalculo = 3
        If Grilla.ColSel = Col_ValInicial Then: Let nModoCalculo = 4
   
        If nModoCalculo = 3 Then
            If nMontoAnterior = 0 Then
                Let nFactor = 1
            Else
                Let nFactor = (CDbl(TxtIngreso.text) / nMontoAnterior)
            End If
        End If
      
        If nModoCalculo = 4 Then
            If nMontoAnterior = 0 Then
                Let nFactor = 1
            Else
                Let nFactor = Round((TxtIngreso.text / Grilla.TextMatrix(Grilla.RowSel, Col_Margen)), 0)
                Let Grilla.TextMatrix(Grilla.RowSel, Col_MT) = nFactor
                Let nFactor = nFactor / nMontoAnterior
            End If
        End If
        
    End If

   dRespaldoNominal = Grilla.TextMatrix(Grilla.RowSel, Col_Nominal)
   
    If nModoCalculo = 3 Then
        If Grilla.ColSel = Col_MT Then
            Let nMonto = Grilla.TextMatrix(Grilla.RowSel, Col_MT)
        End If
        
        If Grilla.ColSel = Col_ValInicial Then
            If CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Margen)) = 0 Then
                Let nMonto = Grilla.TextMatrix(Grilla.RowSel, Col_ValInicial) / 1
            Else
                Let nMonto = Round(Grilla.TextMatrix(Grilla.RowSel, Col_ValInicial) / Grilla.TextMatrix(Grilla.RowSel, Col_Margen), 0)
            ' Let nMonto = Grilla.TextMatrix(Grilla.RowSel, Col_ValInicial) / Grilla.TextMatrix(Grilla.RowSel, Col_Margen)
            End If
            
        End If
         
    End If
   
    sCalculoVInicial = "N"
    
    If nModoCalculo = 4 Then
        sCalculoVInicial = "S"
        Let nModoCalculo = 3
    End If
   
    If (oPagoParcial And EstaPagando) Then  '--> Es para asignar todo los papales como calculados
        If xTecla = vbKeyV Then
            sCalculoVInicial = "T"
        ElseIf Grilla.TextMatrix(Grilla.RowSel, Col_Nominal) = Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG) And Grilla.ColSel = Col_Nominal Then
            sCalculoVInicial = "T"
        ElseIf Grilla.TextMatrix(Grilla.RowSel, Col_MT) = Grilla.TextMatrix(Grilla.RowSel, Col_MT_ORIG) And Grilla.ColSel = Col_MT Then
            sCalculoVInicial = "T"
        ElseIf Grilla.TextMatrix(Grilla.RowSel, Col_ValInicial) = Grilla.TextMatrix(Grilla.RowSel, Col_ValInicial_ORIG) And Grilla.ColSel = Col_ValInicial Then
            sCalculoVInicial = "T"
        End If
    End If
  
    If sCalculoVInicial <> "T" Then
        If (oPagoParcial And EstaPagando) Then  '--> Es para asignar todo los papales como calculados
        
            If Grilla.ColSel = Col_MT Or Grilla.ColSel = Col_ValInicial Then
                Let Grilla.TextMatrix(Grilla.RowSel, Col_Nominal) = dRespaldoNominal
                'Let Grilla.TextMatrix(Grilla.RowSel, Col_Nominal) = Round(((Grilla.TextMatrix(Grilla.RowSel, Col_MT) * Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)) / Grilla.TextMatrix(Grilla.RowSel, Col_MT_ORIG)), 0)
                ' Let Grilla.TextMatrix(Grilla.RowSel, Col_Nominal) = ((Grilla.TextMatrix(Grilla.RowSel, Col_MT) * Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)) / Grilla.TextMatrix(Grilla.RowSel, Col_MT_ORIG))
                
            End If
        
        End If
    End If
    
    Let cMascara = Grilla.TextMatrix(Grilla.RowSel, COL_Serie)
    Let nNominal = Grilla.TextMatrix(Grilla.RowSel, Col_Nominal)
    Let nTir = Grilla.TextMatrix(Grilla.RowSel, Col_Tir)
    Let nPvp = Grilla.TextMatrix(Grilla.RowSel, Col_VPar)
    Let nMonto = Grilla.TextMatrix(Grilla.RowSel, Col_MT)
    Let nMargen = Grilla.TextMatrix(Grilla.RowSel, Col_Margen)
    Let dMontoNominalOriginal = Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)
    Let dMontoPresenteOriginal = Grilla.TextMatrix(Grilla.RowSel, Col_MT_ORIG)
    
    
    Let cFecCal = Format(gsBac_Fecp, "yyyymmdd")
    Let nValorInicial = Grilla.TextMatrix(Grilla.RowSel, Col_ValInicial)
    Let cUsuario = gsBac_User
    Let nVentana = MihWnd

    Envia = Array()
    AddParam Envia, nModoCalculo
    AddParam Envia, cMascara
    AddParam Envia, nNominal
    AddParam Envia, nTir
    AddParam Envia, nPvp
    AddParam Envia, nMonto
    AddParam Envia, cFecCal
    AddParam Envia, nFactor
    AddParam Envia, nValorInicial
    AddParam Envia, cUsuario
    AddParam Envia, nVentana
    
   
    If Grilla.ColSel = Col_Nominal And CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)) <> CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Nominal)) And xTecla <> vbKeyV Then
        AddParam Envia, "N"
    Else
        AddParam Envia, IIf(oPagoParcial, "S", "N") '--> Este es nuevo para control de valorizacion
    End If
    
    AddParam Envia, sCalculoVInicial
    
    If oPagoParcial And EstaPagando And Grilla.ColSel = Col_Nominal Then
        AddParam Envia, "N"
    Else
        AddParam Envia, IIf(oPagoParcial And EstaPagando, "S", "N") '--> Este es el ultimo control para la valorizacion del pago
    End If
    
    AddParam Envia, CDbl(dMontoNominalOriginal)
    AddParam Envia, CDbl(dMontoPresenteOriginal)
    AddParam Envia, Grilla.TextMatrix(Grilla.RowSel, Col_CodCarteraSuper)
    AddParam Envia, CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_HairCut))   'PRD-6007 - 6010
    AddParam Envia, CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_ID_SOMA)) 'PRD-6010
    AddParam Envia, CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Correla_SOMA))  'PRD-6010
    AddParam Envia, CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Emisor))


    
    If Not Bac_Sql_Execute("dbo.SP_VALORIZADETALLEFLI", Envia) Then
        Call MsgBox("Se ha producido un error en la Valorizacion del instrumento.", vbExclamation, App.Title)
        Call SoltarPapel
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then
    
        If Datos(1) < 0 Then
        
            Call MsgBox(Datos(2), vbExclamation, App.Title)
            Call SoltarPapel
            
            Let Grilla.TextMatrix(Grilla.RowSel, Col_Nominal) = Format(CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Nominal_ORIG)), FDec4Dec)
            Let Grilla.TextMatrix(Grilla.RowSel, Col_Tir) = Format(CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Tir_ORIG)), FDec4Dec)
            Let Grilla.TextMatrix(Grilla.RowSel, Col_VPar) = Format(CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_VPar_ORIG)), FDec4Dec)
            Let Grilla.TextMatrix(Grilla.RowSel, Col_MT) = Format(CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_MT_ORIG)), FDec0Dec)
            Let Grilla.TextMatrix(Grilla.RowSel, Col_Margen) = Format(CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Margen_ORIG)), FDec4Dec)
            Let Grilla.TextMatrix(Grilla.RowSel, Col_ValInicial) = Format(CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_ValInicial_ORIG)), FDec0Dec)
            
            On Error Resume Next
            Call Grilla.SetFocus
            On Error GoTo 0
            
        Else
        
            Let Grilla.TextMatrix(Grilla.RowSel, Col_Nominal) = Format(Datos(2), FDec4Dec)
            Let Grilla.TextMatrix(Grilla.RowSel, Col_Tir) = Format(Datos(3), FDec4Dec)
            Let Grilla.TextMatrix(Grilla.RowSel, Col_VPar) = Format(Datos(4), FDec4Dec)
            Let Grilla.TextMatrix(Grilla.RowSel, Col_MT) = Format(Datos(5), FDec0Dec)
            Let Grilla.TextMatrix(Grilla.RowSel, Col_ValInicial) = Format(Datos(6), FDec0Dec)
            
            If Grilla.ColSel = Col_MT Or Grilla.ColSel = Col_Tir Then
                If Format(CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_MT)) * CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Margen)), FDec0Dec) <> Format(CDbl(Datos(6)), FDec0Dec) Then
                    Let Grilla.TextMatrix(Grilla.RowSel, Col_ValInicial) = Format(CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_MT)) * CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Margen)), FDec0Dec)
                End If
            End If
            If Grilla.ColSel = Col_ValInicial Then
                If Format(CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_ValInicial)) / CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Margen)), FDec0Dec) <> Format(CDbl(Datos(5)), FDec0Dec) Then
                    Let Grilla.TextMatrix(Grilla.RowSel, Col_MT) = Format(CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_ValInicial)) / CDbl(Grilla.TextMatrix(Grilla.RowSel, Col_Margen)), FDec0Dec)
                End If
            End If
            
            
        End If
        
    End If
    
    Call subCOLOREA_Registro
    Call ActualizaMontoOperacion
   
End Function

Private Function ValidaSeriesTomadas()
   Dim nContador  As Long

   For nContador = 1 To Grilla.Rows - 1
      If Grilla.TextMatrix(nContador, Col_Marca) <> "" And Grilla.TextMatrix(nContador, Col_Marca) <> "*" Then
         Let Grilla.Row = nContador
         Call SoltarPapel
      End If
   Next nContador

End Function

Private Sub Filtrar()
   Dim Datos()

   bDistribucionManual = False
   
   Call ValidaSeriesTomadas

   Let Me.CarterasFinancieras = ""
   Let Me.CarterasNormativas = ""
   Let Me.FLI_Familia = Me.FLI_Familia           ' 20190118.RCH.FLI
   Call FRM_FILTRO_FLI.Show(vbModal)

    If BACFLI.iAceptar = False Then Exit Sub
   'Let Screen.MousePointer = vbHourglass    ' PRD-6005
   
   Envia = Array()
   AddParam Envia, gsBac_User
   AddParam Envia, CarterasFinancieras
   AddParam Envia, CarterasNormativas
   AddParam Envia, MihWnd
   AddParam Envia, "FLI"  ' PRD-6005
   AddParam Envia, FLI_Familia         '20190118.RCH.FLI
   
   If Not Bac_Sql_Execute("SP_FILTRO_FLI", Envia) Then
'   If Not Bac_Sql_Execute("SP_FILTRO_FLI_6005_6007_MAP", Envia) Then

      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha originado un error en la lectura de operaciones." & vbCrLf & vbCrLf & VerSql, vbExclamation, App.Title)
      Exit Sub
   End If
   Let Grilla.Rows = 1
   Do While Bac_SQL_Fetch(Datos())
      Let Grilla.Rows = Grilla.Rows + 1
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Marca) = ""
      Let Grilla.TextMatrix(Grilla.Rows - 1, COL_Serie) = Datos(1)
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Moneda) = Datos(2)
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Nominal) = Format(Datos(3), FDec4Dec)
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Tir) = Format(Datos(4), FDec4Dec)
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_VPar) = Format(Datos(5), FDec4Dec)
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_MT) = Format(Datos(6), FDec0Dec)
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_PlzRes) = Format(Datos(7), FDec0Dec)
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Margen) = Format(Datos(8), FDec4Dec)
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_ValInicial) = Format(Datos(9), FDec0Dec)
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Custodia) = "DCV"
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_ClaveDcv) = ""
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_CarteraSuper) = Datos(10)

      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Nominal_ORIG) = Format(Datos(3), FDec4Dec)
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Tir_ORIG) = Format(Datos(4), FDec4Dec)
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_VPar_ORIG) = Format(Datos(5), FDec4Dec)
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_MT_ORIG) = Format(Datos(6), FDec4Dec)
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Margen_ORIG) = Format(Datos(8), FDec4Dec)
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_ValInicial_ORIG) = Format(Datos(9), FDec0Dec)
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_CodCarteraSuper) = Datos(11)
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_BloqueoPacto) = Format(Datos(12), FDec4Dec)  ' PRD-6005
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_HairCut) = Format(Datos(13), FDec4Dec)       ' PRD-6007
     'Call ChangeColorSetting(Grilla.Rows - 1, Normal)
      ' PRD-6005
      If CDbl(Grilla.TextMatrix(Grilla.Rows - 1, Col_BloqueoPacto)) <> 0 Then
        Call ChangeColorSetting(Grilla.Rows - 1, BloqueoPacto)
      End If
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_ID_SOMA) = 0  ' PRD-6010
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Correla_SOMA) = 0  ' PRD-6010
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Emisor) = Format(Datos(14), FDec0Dec)       ' PRD-6006
      Let Grilla.TextMatrix(Grilla.Rows - 1, Col_Nemo_Emisor) = Trim(Datos(15))       ' PRD-6006
       
      
      
       ' Agregar Campo glosa emisor

   Loop

      
   Let Me.MousePointer = vbDefault
   
   
   Grilla.AllowUserResizing = flexResizeColumns 'MAP 6005 Solo para Certificar
   Call ActualizaMontoOperacion

End Sub

Private Function LoadFile_Soma() As Boolean
   Dim oFile      As String
   Dim oPath      As String
   Dim MiExcel    As Object
   Dim MiLibro    As Object
   Dim MiHoja     As Object
   Dim nFilas     As Long
   Dim nContador  As Long
   Dim nSwith     As Boolean
   
   If Right(gsBac_DIRSOMA, 1) <> "\" Then
      Let gsBac_DIRSOMA = gsBac_DIRSOMA & "\"
   End If
   
   Let oFile = "CargaSOMA" & Format(gsBac_Fecp, "MM") & Format(gsBac_Fecp, "DD") & ".XlS"
   Let oPath = gsBac_DIRSOMA & oFile

   If Dir(oPath) = "" Then
      Call MsgBox("El archivo requerido para la carga. [" & oFile & "]. no se encuentra... Favor Revisar.", vbExclamation, App.Title)
      Exit Function
   End If

   Let Screen.MousePointer = vbHourglass
   Let nFilas = 50

   Set MiExcel = CreateObject("Excel.Application")
   Set MiLibro = MiExcel.Workbooks.Open(oPath)

   Set MiHoja = Nothing
   Set MiHoja = MiLibro.Worksheets("FLI")

   Let GrillaSoma.Rows = 2
   Let GrillaSoma.Redraw = False

   For nContador = 2 To nFilas

      Let Progreso.Value = nContador
      Let LblProgreso.Caption = "Cargando Archivo...  " & Trim(Progreso.Value) & " %"

      If (UCase(MiHoja.Cells(nContador - 1, "C")) = UCase("Mnemotécnico")) Then
         Let nSwith = True
      End If

      If nSwith = True Then
         If UCase(Trim(MiHoja.Cells(nContador, "B"))) = UCase(Trim("VALOR INICIAL PACTO: ")) Then
            Let Progreso.Value = 50
            Let LblProgreso.Caption = "Carga Finalizada. 100 %"
            Exit For
         End If

         If Trim(MiHoja.Cells(nContador, "C")) <> "" Then
            Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 0) = MiHoja.Cells(nContador, "C")
            Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 1) = Format(CDbl(MiHoja.Cells(nContador, "D")), FDec4Dec)
            Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 2) = Format(CDbl(MiHoja.Cells(nContador, "F")), FDec4Dec)
            Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 3) = Format(CDbl(MiHoja.Cells(nContador, "G")), FDec0Dec)
            Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 4) = Format(CDbl(MiHoja.Cells(nContador, "E")), FDec0Dec)
            Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 5) = Format(CDbl(MiHoja.Cells(nContador, "I")), FDec4Dec)
            Let GrillaSoma.TextMatrix(GrillaSoma.Rows - 1, 6) = Format(CDbl(MiHoja.Cells(nContador, "J")), FDec0Dec)
            Let GrillaSoma.Rows = GrillaSoma.Rows + 1
         End If
      End If

   Next nContador
   
   Let GrillaSoma.Rows = GrillaSoma.Rows - 1
   
   Set MiHoja = Nothing
   Call MiLibro.Close
   Set MiExcel = Nothing
   
   Let GrillaSoma.Redraw = True
   Let Progreso.Value = 0
   Let LblProgreso.Caption = "Lectura de Archivo SOMA"
   Let Screen.MousePointer = vbDefault
End Function

Public Function CargaArchivo_Soma(ByRef xGrilla As MSFlexGrid) As Boolean
'PRD-6010
   Dim oPath      As String
   Dim SQL$, Datos(), xLine$
   Dim nContador  As Long
   Dim nEstado    As Long
   Dim Arreglo()  As String
   Dim X As Long
   Dim ContLinea  As Long
   Dim nNumoper   As Long
   Dim nCorrela   As Long
   Dim nValida    As Long
   Dim nFilas     As Long
   Dim nFilFolio  As Long
   Dim Error      As String
   Dim Msg        As String
   Dim sSerie     As String
   Dim nRutEmisor As Double
   
   Dim nResul     As Long
   Dim CantFolioSOMA  As Long
   
   Let Error = ""
   Let Msg = ""
  
   Let SwErrorArch = False

   ContLinea = 0
   nContador = 0
   
   If Right(gsBac_DIRSOMA, 1) <> "\" Then
      Let gsBac_DIRSOMA = gsBac_DIRSOMA & "\"
   End If
   
   Let cNombreArchivo = "Fli" & Format(gsBac_Fecp, "YY") & Format(gsBac_Fecp, "MM") & Format(gsBac_Fecp, "DD") & ".txt"
   Let oPath = gsBac_DIRSOMA & cNombreArchivo

   If Dir(oPath) = "" Then
      Call MsgBox("El archivo requerido para la carga. [" & cNombreArchivo & "]. no se encuentra... Favor Revisar.", vbExclamation, App.Title)
      Exit Function
   End If
   
   xGrilla.Clear
   Call SettingGridSoma(xGrilla)
   Let xGrilla.Rows = 2
   Let CantFolioSOMA = 0
   
   Call LimpiaGrillaErroresSOMA
   Call CargaFoliosSOMABac(GridFolioSOMA)
   Call BuscaFolioAnulado(oPath, cNombreArchivo, GridFolioSOMA)
      
      '-- carga operaciones
    On Error GoTo errOpen
    Open oPath For Input Access Read Shared As #1
    
    On Error GoTo errRead
        
    Do While Not EOF(1)
    
               
        Line Input #1, xLine
       
       
         Arreglo = Split(xLine, vbTab)
         nEstado = 0
         
         If EOF(1) Then
            If xLine = "" Then
               Exit Do
            End If
         End If
         
            
         If Arreglo(0) = "ID" Then
             ContLinea = 0
         End If
               
         
         ContLinea = ContLinea + 1
        
        If ContLinea = 1 Then
        
                For X = 0 To UBound(Arreglo)
         
                  Select Case nEstado
                    Case 0
                        If Arreglo(X) = "ID" Then
                            nEstado = 1
                        Else
                            GoTo errRead
                        End If
                    Case 1
                        If Arreglo(X) = "Fecha" Then
                            nEstado = 2
                        Else
                            GoTo errRead
                        End If
                    Case 2
                        If Arreglo(X) = "Institucion" Then
                            nEstado = 3
                        Else
                            GoTo errRead
                        End If
                    Case 3
                        If Arreglo(X) = "Monto Nominal" Then
                            Exit For
                        Else
                            GoTo errRead
                        End If
                  End Select
        
                Next X
        
        End If
        
        If ContLinea = 2 Then
             nNumoper = Arreglo(0)

        End If
        
        
        If ContLinea = 3 Then
       
        
                For X = 0 To UBound(Arreglo)
         
                  Select Case nEstado
                    Case 0
                        If Arreglo(X) = "Correlativo" Then
                            nEstado = 1
                            
                        Else
                            GoTo errRead
                        End If
                    Case 1
                        If Arreglo(X) = "Mnemotecnico" Then
                            nEstado = 2
                        Else
                            GoTo errRead
                        End If
                    Case 2
                        If Arreglo(X) = "Monto Nominal" Then
                            nEstado = 3
                        Else
                            GoTo errRead
                        End If
                    Case 3
                        If Arreglo(X) = "Valor Inicial" Then
                            Exit For
                        Else
                            GoTo errRead
                        End If
                  End Select
                  
                  
        
                Next X
        
        
        End If
        
        If ContLinea >= 4 Then
        
            
        
             Envia = Array()
             AddParam Envia, CDbl(nNumoper)
             AddParam Envia, Arreglo(1)
             AddParam Envia, gsBac_User
             AddParam Envia, CarterasFinancieras
             AddParam Envia, CarterasNormativas
             AddParam Envia, MihWnd
             AddParam Envia, "FLI"
                            
             If Not Bac_Sql_Execute("SP_VALIDAARCHIVO_BCCH", Envia) Then
                Call BacRollBackTransaction
                Call MsgBox("Se ha producido un error en la busqueda.", vbExclamation, App.Title)
                Exit Function
             End If
                    
             If Bac_SQL_Fetch(Datos()) Then
                nValida = Val(Datos(1))
                sSerie = Datos(2)
                nRutEmisor = Datos(3)
             End If


           If Arreglo(0) <> "" And nValida = 0 Then
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 0) = sSerie
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 1) = Format(CDbl(Arreglo(2)), FDec4Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 2) = 0#
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 3) = 0#
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 4) = 0
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 5) = 0#
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 6) = Format(CDbl(Arreglo(3)), FDec4Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 7) = Format(CDbl(nNumoper), FDec0Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 8) = Format(CDbl(Arreglo(0)), FDec0Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 9) = nRutEmisor
              
              Let xGrilla.Rows = xGrilla.Rows + 1
              
           Else
                 
              nFilas = xGrilla.Rows - 1
              If Arreglo(0) <> "" Then
                 Call EliminaFolioSomaGrilla(nFilas, CDbl(nNumoper))
                 
                 If nValida = 2 And CantFolioSOMA < 1 Then
                    Let Error = Error & "  Serie instrumento [" & Arreglo(1) & "] no esta disponible en cartera BAC, la cual corresponde al siguiente Folio  SOMA: [" & nNumoper & "]" & vbCrLf
                    Let Msg = "Serie Instrumento no está disponible"
                    Call Llena_GrillaErroresSOMA(Format(CDbl(nNumoper), FDec0Dec), Format(CDbl(Arreglo(0))), Arreglo(1), Msg, Format(CDbl(Arreglo(3)), FDec4Dec), 0)
                    
                 Else
                    If ContLinea = 4 Then
                        Let Error = Error & "  Folio SOMA   [" & nNumoper & "] ya se encuentra cargado en BAC." & vbCrLf
                        Let Msg = "Folio SOMA, ya se encuentra cargado"
                        Call Llena_GrillaErroresSOMA(Format(CDbl(nNumoper), FDec0Dec), Format(CDbl(Arreglo(0))), Arreglo(1), Msg, Format(CDbl(Arreglo(3)), FDec4Dec), 0)
                        CantFolioSOMA = CantFolioSOMA + 1
                        
                    End If
                    
                 End If
              End If
           
           End If
        
        
        End If

          
        
        nContador = nContador + 1
          
        Let Progreso.Value = nContador
       

    Loop
    
    
  If Len(Error) > 0 Or Len(ErrAnula) > 0 Then
      Call MsgBox("Se han encontrado las siguientes Observaciones:" & vbCrLf & vbCrLf & Error & vbCrLf & ErrAnula & vbCrLf, vbExclamation, App.Title)
  End If
           
    Close #1

    Exit Function
    
   
errOpen:
    Exit Function
    
errRead:
    MsgBox "No se pudo continuar la lectura del archivo. Favor Revisar." & oPath & vbCrLf & err.Description, vbCritical
    Let SwErrorArch = True
''    GoTo fin  'Se elimina 6010
  

    
'PRD-6010
End Function
Private Sub EliminaFolioSomaGrilla(Filas As Long, nOper As Long)
'PRD-6010
Dim nCont   As Long

For nCont = 1 To Filas - 1
  If GrillaSoma.TextMatrix(nCont, 7) = nOper Then   '' And GrillaSoma.TextMatrix(nCont, 7) = ""
    GrillaSoma.RemoveItem nCont
  End If
Next nCont
'PRD-6010
End Sub

Public Sub CargaFoliosSOMABac(ByRef xGrilla As MSFlexGrid)
'PRD-6010
Dim Datos()

xGrilla.Clear

   Let xGrilla.TextMatrix(0, 0) = "Folio SOMA"
   Let xGrilla.TextMatrix(0, 1) = "Oper BAC"


Let xGrilla.Rows = 1
   Envia = Array()
   AddParam Envia, Format(gsBac_Fecp, "yyyymmdd")
   AddParam Envia, "FLI"
   If Not Bac_Sql_Execute("dbo.SP_TRAEFOLIOSSOMA", Envia) Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Se ha originado un error en la lectura de operaciones." & vbCrLf & vbCrLf & VerSql, vbExclamation, App.Title)
      Exit Sub
   End If
   
   Do While Bac_SQL_Fetch(Datos())
      Let xGrilla.Rows = xGrilla.Rows + 1
      Let xGrilla.TextMatrix(xGrilla.Rows - 1, 0) = Datos(1)
      Let xGrilla.TextMatrix(xGrilla.Rows - 1, 1) = Datos(2)
      
   Loop
     
'PRD-6010
End Sub

Public Sub BuscaFolioAnulado(Ruta As String, NombreArchivo As String, ByRef xGrilla As MSFlexGrid)
'PRD-6010
Dim xLine
Dim nFilFolio As Long
Dim nResul    As Long
Dim oFile     As String
Dim Msg       As String

Let ErrAnula = ""
Let Msg = ""
           
               For nFilFolio = 1 To xGrilla.Rows - 1
                              
                  Open Ruta For Input Access Read Shared As #1
                   Do While Not EOF(1)
    
               
                    Line Input #1, xLine
          
                     If xGrilla.TextMatrix(nFilFolio, 0) <> 0 Then
          
                    If InStr(xLine, xGrilla.TextMatrix(nFilFolio, 0)) = 0 Then
                        Let nResul = nResul + 1
                    Else
                        Let nResul = 0
                        Exit Do
                    End If
                     End If
                    
                   Loop
                   
                   
                    If nResul > 1 Then
                       Let ErrAnula = ErrAnula & " Falta anular operación FLI en BAC con número [" & CDbl(xGrilla.TextMatrix(nFilFolio, 1)) & "], que referencia a folio SOMA[" & CDbl(xGrilla.TextMatrix(nFilFolio, 0)) & "], que ya no existe en archivo [" & NombreArchivo & "]" & vbCrLf
                       Let Msg = "Debe Anular Oparación FLI en BAC [" & CDbl(xGrilla.TextMatrix(nFilFolio, 1)) & "], ya que no existe Folio SOMA en Archivo"
                       Call Llena_GrillaErroresSOMA(Format(CDbl(xGrilla.TextMatrix(nFilFolio, 0)), FDec0Dec), 0, "", Msg, 0, 0)
                       nResul = 0
                    End If
                    
                           Close #1
         
               Next nFilFolio
                   
'PRD-6010
End Sub

Function SacarDatos(sCadena$, sCaracter$, sRetornar$, Optional bRetornaResto) As Variant
    Dim sDecMil As String
    
    SacarDatos = ""
    If InStr(sCadena, sCaracter) > 0 Then
        SacarDatos = Left(sCadena, InStr(sCadena, sCaracter) - 1)
        sCadena = Mid(sCadena, InStr(sCadena, sCaracter) + Len(sCaracter))
    ElseIf Not IsMissing(bRetornaResto) Then
        If bRetornaResto Then
            SacarDatos = sCadena
            sCadena = ""
        End If
    End If
    
    SacarDatos = BacStrTran((SacarDatos), vbCrLf, "")
    
    '---- convierte para retornar
    Select Case UCase(sRetornar)
    Case "ID"
        If SacarDatos = "" Then
            SacarDatos = "0"
        End If
        
        'Primero se reemplaza el separador que es punto
        SacarDatos = BacStrTran((SacarDatos), ".", "")
        'segundo se reemplaza el decimal que es coma por punto para sql
        ''****************************
        '' VGS 14/04/2005
        ''****************************
        If InStr(1, SacarDatos, ",") > 0 Then
            If gsc_PuntoDecim = "," Then
                SacarDatos = SacarDatos
            Else
                SacarDatos = BacStrTran((SacarDatos), ",", ".")
            End If
        End If
        ''****************************
    Case "D", "F", "FECHA"
        If Trim(SacarDatos) <> "" Then
            SacarDatos = CDate(SacarDatos)
        End If
        
    End Select

End Function
Private Function Carga_Oper_Soma_Grilla_FLI()
Dim nCont As Long

For nCont = 1 To GrillaSoma.Rows - 1
    Call Grilla_KeyDown(vbKeyReturn, 0)
Next nCont


End Function


Public Function Realizar_Fli_Soma()
   Dim nNumCargas As Long
   Dim nFilasSoma As Long
   Dim nFilas     As Long
   
   Dim xSerie     As String
   Dim xNominal   As Double
   Dim xTasa      As Double
   Dim xValor     As Double
   
   Dim xPlazo     As Long
   Dim xMargen    As Double
   Dim xVInicial  As Double
   Dim xIdSOMA    As Long
   Dim xCorrelaSOMA As Long
   Dim xRutEmisor As Double
   
   
   
   Dim err      As String
   Dim Error      As String
   Dim nFil     As Long
   Dim Msg        As String
   Dim nCont     As Long
   Dim Conta     As Long
   Dim Mensaje   As String
   Dim SumNominal As Double
   Dim DifNominal As Double
   Dim nFactorSoma As Double
   Dim nNominalArchSOMA As Double
   Dim SW         As Boolean
   Dim DescFLI    As Double
   
   Let err = ""
   Let Error = ""
   Let Msg = ""
   Let Conta = 0
   Let Mensaje = ""
   Let SumNominal = 0
   Let nNominalArchSOMA = 0
   
   Let Grilla.Redraw = False
   Let nNumCargas = 0
   Let DescFLI = 0
   
   Call LimpiaFolioSOMA_GRILLA   'PRD-6010
   
   On Error GoTo ErrStock
   
   '->> Lee Filas de la Grilla SOMA
   For nFilasSoma = 1 To GrillaSoma.Rows - 2
      
      Let DifNominal = 0
      Let SumNominal = 0
      Let Conta = 0
      Let DescFLI = 0
      Let SW = False
      '->> Asigna variables SOMA
      If Trim(GrillaSoma.TextMatrix(nFilasSoma, 0)) = "" Then
        Exit Function
      End If
      
      Let xSerie = Trim(GrillaSoma.TextMatrix(nFilasSoma, 0))
      Let xNominal = GrillaSoma.TextMatrix(nFilasSoma, 1)
      Let xTasa = GrillaSoma.TextMatrix(nFilasSoma, 2)
      Let xValor = GrillaSoma.TextMatrix(nFilasSoma, 6)        'PRD-6010
      Let xPlazo = GrillaSoma.TextMatrix(nFilasSoma, 4)
      Let xMargen = GrillaSoma.TextMatrix(nFilasSoma, 5)
      Let xVInicial = GrillaSoma.TextMatrix(nFilasSoma, 6)
      Let xIdSOMA = GrillaSoma.TextMatrix(nFilasSoma, 7)       'PRD-6010
      Let xCorrelaSOMA = GrillaSoma.TextMatrix(nFilasSoma, 8)  'PRD-6010
      Let xRutEmisor = GrillaSoma.TextMatrix(nFilasSoma, 9)    'PRD-6010
      
      Let nNominalArchSOMA = xNominal
      Let DescFLI = GrillaSoma.TextMatrix(nFilasSoma, 1)
      
      Let err = ""
     Let bCargaArchivo = False
      
      
        For nCont = 1 To Grilla.Rows - 1
          If Grilla.TextMatrix(nCont, COL_Serie) = xSerie And CDbl(Grilla.TextMatrix(nCont, Col_Emisor)) = CDbl(xRutEmisor) Then
            Let SumNominal = SumNominal + Grilla.TextMatrix(nCont, Col_Nominal)
            Let SW = False
            If xNominal <= CDbl(Grilla.TextMatrix(nCont, Col_Nominal)) Then
               If xNominal = CDbl(Grilla.TextMatrix(nCont, Col_Nominal)) Then
                   Let SW = True
               End If
               Exit For
            End If
             Let Conta = Conta + 1
             Let Mensaje = Mensaje + " " + Grilla.TextMatrix(nCont, COL_Serie) + " " + Grilla.TextMatrix(nCont, Col_Nominal)
          End If
        Next nCont
              
      '->> Lee Filas de la Grilla de Operaciones
      For nFilas = 1 To Grilla.Rows - 1

         '->> Valida que corresponda a la Serie
         If Grilla.TextMatrix(nFilas, COL_Serie) = xSerie Then

            If CDbl(SumNominal) < xNominal And CDbl(Grilla.TextMatrix(nFilas, Col_Emisor)) = CDbl(xRutEmisor) Then
               If VerificaSerieSOMA(xSerie, xIdSOMA, xCorrelaSOMA) = True Then
                  Exit For
               End If
               If VerificaSerieSOMA_Errores(xSerie, xIdSOMA, xCorrelaSOMA) = True Then
                  Let err = err & "Serie Instrumento [" & xSerie & "] No será cargado, por problemas en otros registros correspondiente Folio Soma [" & xIdSOMA & "]" & vbCrLf
                  Let Msg = "Serie Instrumento no será cargada por problemas en otros registros correspondientes al mismo folio"
                  Call Llena_GrillaErroresSOMA(Format(CDbl(xIdSOMA), FDec0Dec), Format(CDbl(xCorrelaSOMA)), xSerie, Msg, xNominal, Grilla.TextMatrix(nFilas, Col_Nominal))
                  Exit For
               End If

               Let err = err & "Falta Stock o disponibilidad de Nominal para la serie: [" & xSerie & "], la cual corresponde a Folio SOMA: [" & xIdSOMA & "]" & vbCrLf     'PRD-6010
               Let Msg = "Falta Stock o disponibilidad de Nominal"
               Call Llena_GrillaErroresSOMA(Format(CDbl(xIdSOMA), FDec0Dec), Format(CDbl(xCorrelaSOMA)), xSerie, Msg, xNominal, Grilla.TextMatrix(nFilas, Col_Nominal))
               Exit For
               
            Else
               
           'PRD-6010
              If CDbl(Grilla.TextMatrix(nFilas, Col_Emisor)) = CDbl(xRutEmisor) And Conta <= 1 Then
                If VerificaSerieSOMA(xSerie, xIdSOMA, xCorrelaSOMA) = True Then
                  Let err = err & "Serie Instrumento [" & xSerie & "] ya tiene asignado un Folio SOMA. Debe cargar nuevamente el siguiente Folio Soma [" & xIdSOMA & "]" & vbCrLf
                  Let Msg = "Serie Instrumento ya tiene asignado un Folio SOMA"
                  Call Llena_GrillaErroresSOMA(Format(CDbl(xIdSOMA), FDec0Dec), Format(CDbl(xCorrelaSOMA)), xSerie, Msg, xNominal, Grilla.TextMatrix(nFilas, Col_Nominal))
                  Exit For
                End If
              Else
                  If xNominal = 0 Then
                     Exit For
                  End If
              End If
              
              If VerificaSerieSOMA_Errores(xSerie, xIdSOMA, xCorrelaSOMA) = True Then
                  Let err = err & "Serie Instrumento [" & xSerie & "] No será cargado, por problemas en otros registros correspondiente Folio Soma [" & xIdSOMA & "]" & vbCrLf
                  Let Msg = "Serie Instrumento no será cargada por problemas en otros registros correspondientes al mismo folio"
                  Call Llena_GrillaErroresSOMA(Format(CDbl(xIdSOMA), FDec0Dec), Format(CDbl(xCorrelaSOMA)), xSerie, Msg, xNominal, Grilla.TextMatrix(nFilas, Col_Nominal))
                 Exit For
              End If
           'PRD-6010
               

               If Len(err) = 0 And CDbl(Grilla.TextMatrix(nFilas, Col_Emisor)) = CDbl(xRutEmisor) And DescFLI <> 0 Then
                  Let DifNominal = CDbl(xNominal) - Grilla.TextMatrix(nFilas, Col_Nominal)
                  Let nFactorSoma = CDbl(xVInicial / nNominalArchSOMA)
                  If Grilla.TextMatrix(nFilas, Col_Nominal) = CDbl(xNominal) And SW = True Then
                        
                     Let nNumCargas = nNumCargas + 1
                     Let Grilla.TextMatrix(nFilas, Col_Nominal) = Grilla.TextMatrix(nFilas, Col_Nominal) ''Format(xNominal, FDec4Dec)
                     Let Grilla.TextMatrix(nFilas, Col_Tir) = Format(xTasa, FDec4Dec)
                     Let Grilla.TextMatrix(nFilas, Col_MT) = CDbl(Grilla.TextMatrix(nFilas, Col_Nominal) * nFactorSoma) / IIf(Grilla.TextMatrix(nFilas, Col_Margen) = 0, 1, Grilla.TextMatrix(nFilas, Col_Margen)) 'PRD-6010
                     Let Grilla.TextMatrix(nFilas, Col_ValInicial) = CDbl(Grilla.TextMatrix(nFilas, Col_Nominal) * nFactorSoma) '' Format(xVInicial, FDec0Dec)
                     Let Grilla.TextMatrix(nFilas, Col_ID_SOMA) = Format(xIdSOMA, FDec0Dec)      'PRD-6010
                     Let Grilla.TextMatrix(nFilas, Col_Correla_SOMA) = Format(xCorrelaSOMA, FDec0Dec) 'PRD-6010

                        Let Grilla.Row = nFilas:   Let Grilla.Col = Col_Tir

                        If TomarPapel Then
                                Toolbar1.Buttons(5).Enabled = True
                                Let TxtIngreso.text = Grilla.TextMatrix(nFilas, Col_Nominal)
                                Call Valorizacion_Fli(vbKeyV)
                                Let bCargaArchivo = True
    
                        End If
                        Let xNominal = DifNominal
                        Exit For
                  End If
                    If SW = False Then
                     If Grilla.TextMatrix(nFilas, Col_Nominal) < CDbl(xNominal) Then
                        
                        Let nNumCargas = nNumCargas + 1
                        Let Grilla.TextMatrix(nFilas, Col_Nominal) = Grilla.TextMatrix(nFilas, Col_Nominal) ''Format(xNominal, FDec4Dec)
                        Let Grilla.TextMatrix(nFilas, Col_Tir) = Format(xTasa, FDec4Dec)
                        Let Grilla.TextMatrix(nFilas, Col_MT) = CDbl(Grilla.TextMatrix(nFilas, Col_Nominal) * nFactorSoma) / IIf(Grilla.TextMatrix(nFilas, Col_Margen) = 0, 1, Grilla.TextMatrix(nFilas, Col_Margen)) 'PRD-6010
                        Let Grilla.TextMatrix(nFilas, Col_ValInicial) = CDbl(Grilla.TextMatrix(nFilas, Col_Nominal) * nFactorSoma) '' Format(xVInicial, FDec0Dec)
                        Let Grilla.TextMatrix(nFilas, Col_ID_SOMA) = Format(xIdSOMA, FDec0Dec)      'PRD-6010
                        Let Grilla.TextMatrix(nFilas, Col_Correla_SOMA) = Format(xCorrelaSOMA, FDec0Dec) 'PRD-6010

                        Let Grilla.Row = nFilas:   Let Grilla.Col = Col_Tir

                        If TomarPapel Then
                                Toolbar1.Buttons(5).Enabled = True
                                Let TxtIngreso.text = Grilla.TextMatrix(nFilas, Col_Nominal)
                                Call Valorizacion_Fli(vbKeyV)
                                Let bCargaArchivo = True
    
                        End If
                        Let xNominal = DifNominal
                    Else
                        Let DifNominal = CDbl(xNominal)
                        Let nNumCargas = nNumCargas + 1
                        Let Grilla.TextMatrix(nFilas, Col_Nominal) = CDbl(DifNominal) ''Format(xNominal, FDec4Dec)
                        Let Grilla.TextMatrix(nFilas, Col_Tir) = Format(xTasa, FDec4Dec)
                        Let Grilla.TextMatrix(nFilas, Col_MT) = CDbl(DifNominal * nFactorSoma) / IIf(Grilla.TextMatrix(nFilas, Col_Margen) = 0, 1, Grilla.TextMatrix(nFilas, Col_Margen)) 'PRD-6010
                        Let Grilla.TextMatrix(nFilas, Col_ValInicial) = CDbl(DifNominal * nFactorSoma)
                        Let Grilla.TextMatrix(nFilas, Col_ID_SOMA) = Format(xIdSOMA, FDec0Dec)      'PRD-6010
                        Let Grilla.TextMatrix(nFilas, Col_Correla_SOMA) = Format(xCorrelaSOMA, FDec0Dec) 'PRD-6010

                        Let Grilla.Row = nFilas:   Let Grilla.Col = Col_Tir

                        If TomarPapel Then
                            Toolbar1.Buttons(5).Enabled = True
                            Let TxtIngreso.text = Grilla.TextMatrix(nFilas, Col_Nominal)
                            Call Valorizacion_Fli(vbKeyV)
                            Let bCargaArchivo = True
                        End If
                        
                        If Conta = 0 Then
                           Exit For
                        End If
                  
                        
                    End If
                  End If
                  
                   Let DescFLI = DescFLI - Grilla.TextMatrix(nFilas, Col_Nominal)
                End If
               
            End If
         End If
      Next nFilas
      
        Let Error = Error + err
        
        'PRD-6010
        If Len(err) <> 0 Then
        
           For nFil = 1 To Grilla.Rows - 1
              If xIdSOMA = Grilla.TextMatrix(nFil, Col_ID_SOMA) Then
                  Let Grilla.TextMatrix(nFil, Col_ID_SOMA) = Format(0, FDec0Dec)
                  Let Grilla.TextMatrix(nFil, Col_Correla_SOMA) = Format(0, FDec0Dec)
                  Call SoltarPapel
                  Let Grilla.TextMatrix(nFil, Col_Nominal) = Format(CDbl(Grilla.TextMatrix(nFil, Col_Nominal_ORIG)), FDec4Dec)
                  Let Grilla.TextMatrix(nFil, Col_Tir) = Format(CDbl(Grilla.TextMatrix(nFil, Col_Tir_ORIG)), FDec4Dec)
                  Let Grilla.TextMatrix(nFil, Col_VPar) = Format(CDbl(Grilla.TextMatrix(nFil, Col_VPar_ORIG)), FDec4Dec)
                  Let Grilla.TextMatrix(nFil, Col_MT) = Format(CDbl(Grilla.TextMatrix(nFil, Col_MT_ORIG)), FDec0Dec)
                  Let Grilla.TextMatrix(nFil, Col_Margen) = Format(CDbl(Grilla.TextMatrix(nFil, Col_Margen_ORIG)), FDec4Dec)
                  Let Grilla.TextMatrix(nFil, Col_ValInicial) = Format(CDbl(Grilla.TextMatrix(nFil, Col_ValInicial_ORIG)), FDec0Dec)
                  
              End If
           Next nFil
        
        End If
        'PRD-6010
        
        
   Next nFilasSoma

   Let Grilla.Redraw = True
'''   Call GRILLA.SetFocus
   
   If nNumCargas < GrillaSoma.Rows - 2 Then
   'PRD-6010
'''
'''      Call MsgBox("Existen Series sin Disponibilidad para cargar el SOMA.", vbExclamation, App.Title)
'''      Call SoltarTodos
'''      Let grilla.Rows = 1
'''      Let GrillaSoma.Rows = 1
'''
'''      Let Toolbar1.Buttons(2).Enabled = False
'''      Let Toolbar1.Buttons(3).Enabled = True
'''      Let Toolbar1.Buttons(10).Enabled = False
'''      Let Toolbar1.Buttons(11).Enabled = False
   'PRD-6010
   End If
   
    If nNumCargas = GrillaSoma.Rows - 2 And nNumCargas <> 0 Then
      Call MsgBox("Todos lo Folios SOMA han sido cargados.", vbExclamation, App.Title)
'''      Let Toolbar1.Buttons(10).Enabled = False
    End If
   
ErrStock:
   If Len(Error) > 0 Then
      Call MsgBox("Se han encontrado Observaciones en la carga del Fli SOMA :" & vbCrLf & vbCrLf & Error, vbExclamation, App.Title)
      Let Toolbar1.Buttons(10).Enabled = False
      Let Toolbar1.Buttons(11).Enabled = False
   End If
   Exit Function
   
End Function

Private Function VerificaSerieSOMA(SerieSoma As String, FolioSOMA As Long, CorrelaSOMA As Long) As Boolean
'PRD-6010
Dim nContador  As Long
Dim nCant      As Long

    Let VerificaSerieSOMA = False
    Let nCant = 0
    
    For nContador = 1 To Grilla.Rows - 1

      If (Grilla.TextMatrix(nContador, COL_Serie) = SerieSoma) And (Grilla.TextMatrix(nContador, Col_ID_SOMA) <> FolioSOMA And (Grilla.TextMatrix(nContador, Col_Correla_SOMA) = CorrelaSOMA)) Then   '' (grilla.TextMatrix(nContador, Col_Correla_SOMA) <> 0)
           
               Let VerificaSerieSOMA = True
               Exit Function
      End If
        
    Next nContador
    
    
    If VerificaSerieSOMA = False Then
        VerificaSerieSOMA = False
        Exit Function
    End If

   VerificaSerieSOMA = True
   
'PRD-6010
End Function


Private Function ValidaPapelesaGrabar() As Boolean
Dim nContador  As Long
Dim bControl    As Boolean


    Let ValidaPapelesaGrabar = False
    Let bControl = False
    
    For nContador = 1 To Grilla.Rows - 1
        If Grilla.TextMatrix(nContador, Col_Marca) = "P" Or Grilla.TextMatrix(nContador, Col_Marca) = "V" Then
            Let ValidaPapelesaGrabar = True
            Exit Function
        End If
        
    Next nContador
    
    If ValidaPapelesaGrabar = False Then
        Call MsgBox("No se han seleccioando papeles para la venta", vbInformation, App.Title)
        ValidaPapelesaGrabar = False
        Exit Function
    End If
    
   ValidaPapelesaGrabar = True
   
End Function


Private Function ValidaPapelesaGrabarPAGOS() As Boolean
   Dim nContador  As Long
   
   Let ValidaPapelesaGrabarPAGOS = False
   
   For nContador = 1 To Grilla.Rows - 1
   
            If Grilla.TextMatrix(nContador, Col_Marca) = "V" And CDbl(Round(Grilla.TextMatrix(nContador, Col_MT), 0)) <> CDbl(Round(Grilla.TextMatrix(nContador, Col_MT_ORIG), 0)) Then
                MsgBox "si esta pagando por el total del nominal debe realizarlo por el monto original", vbExclamation
                Exit Function
            End If
            If Grilla.TextMatrix(nContador, Col_Marca) = "P" And CDbl(Grilla.TextMatrix(nContador, Col_MT)) = CDbl(Grilla.TextMatrix(nContador, Col_MT_ORIG)) Then
                MsgBox "si esta pagando parcial no puede pagar el monto total del papel", vbExclamation
                Exit Function
            End If
            
   Next nContador
   
   Let ValidaPapelesaGrabarPAGOS = True
   
End Function


Private Sub ActualizaMontoOperacion()
   Dim nMonto     As Double
   Dim nContador  As Long
   Dim fTotal     As Double
   
   Let nMonto = 0
   Let fTotal = 0
   For nContador = 1 To Grilla.Rows - 1
   
        Let fTotal = fTotal + IIf(Modificacion, Grilla.TextMatrix(nContador, Col_ValInicial_ORIG), 0)
        
        If Grilla.TextMatrix(nContador, Col_Marca) = "P" Or Grilla.TextMatrix(nContador, Col_Marca) = "V" Then
         Let nMonto = nMonto + Grilla.TextMatrix(nContador, Col_ValInicial)
        End If
   Next nContador

   If nMonto = 0 And Grilla.Rows > Grilla.FixedRows Then
      '--> Deshabilita Botones del Fli, hasta que no se ejecute el Filtro
      Let Toolbar1.Buttons(10).Enabled = True
      Let Toolbar1.Buttons(11).Enabled = True
      '--> Deshabilita Botones del Fli, hasta que no se ejecute el Filtro
   End If
   
   
   If oPagoParcial Then
        Let txtIniPMP.text = 0
        Let txtIniPMS.text = 0
        Let txtVenPMP.text = nMonto
        Let txtdiferencia.text = (fTotal - nMonto)
        If (fTotal - nMonto) < 0 Then
            MsgBox "Debe verificar Monto a cancelar dado que saldo no puede ser negativo", vbExclamation, "Validación Pagos"
            
        End If
    Else
        Let txtIniPMP.text = nMonto
        Let txtIniPMS.text = nMonto
        Let txtVenPMP.text = nMonto
        Let txtdiferencia.text = 0
    End If
End Sub

Private Function validaTOTALSaldoPendiente() As Boolean
Dim nMonto          As Double
Dim nContador       As Long
Dim fTotal          As Double
Dim bExistePend     As Boolean
   
    Let nMonto = 0
    Let fTotal = 0
    Let bExistePend = False
    Let validaTOTALSaldoPendiente = False
   
    
    For nContador = 1 To Grilla.Rows - 1
        Let fTotal = fTotal + IIf(Modificacion, Grilla.TextMatrix(nContador, Col_ValInicial_ORIG), 0)
        If Grilla.TextMatrix(nContador, Col_Marca) <> "V" Then
            bExistePend = True
            Exit For
        End If
    Next nContador

   Let validaTOTALSaldoPendiente = IIf(Not bExistePend And CDbl(Me.txtdiferencia.text) <> 0, False, True)
   
End Function




Private Sub ActualizaMontoPAGO()
   Dim nMonto     As Double
   Dim nContador  As Long
   
   Let nMonto = 0
   
   For nContador = 1 To Grilla.Rows - 1
         Let nMonto = nMonto + Grilla.TextMatrix(nContador, Col_ValInicial)
   Next nContador
   
   Let txtIniPMP.text = 0
   Let txtIniPMS.text = 0
   Let txtVenPMP.text = 0
   Let txtdiferencia.text = nMonto
End Sub



Private Sub Imprimir_Informe_Errores_SOMA()
   On Error GoTo ErrPrinter

   BacTrader.bacrpt.WindowState = crptMaximized
   BacTrader.bacrpt.ReportFileName = RptList_Path & "ObsCargaSoma.RPT"
   Call PROC_ESTABLECE_UBICACION(BacTrader.bacrpt.RetrieveDataFiles, BacTrader.bacrpt)
   BacTrader.bacrpt.StoredProcParam(0) = Format$(gsBac_Fecp, "yyyymmdd")
   BacTrader.bacrpt.StoredProcParam(1) = "FLI"
   BacTrader.bacrpt.Connect = CONECCION
   BacTrader.bacrpt.Action = 1
   BacTrader.bacrpt.Destination = 0

   On Error GoTo 0
Exit Sub
ErrPrinter:
   MsgBox "Problemas en Impresión de Informe de Errores SOMA: " & err.Description, vbExclamation, gsBac_Version
   On Error GoTo 0
End Sub

Private Function TraeCorrelativoBCCH(nFolioBCCH As Long) As Long
'PRD-6010
   Dim Datos()
   
   Let TraeCorrelativoBCCH = 1
   Envia = Array()
   AddParam Envia, nFolioBCCH
   If Not Bac_Sql_Execute("SP_TRAE_CORRELA_BCCH") Then
      Exit Function
   End If
   Do While Bac_SQL_Fetch(Datos())
      TraeCorrelativoBCCH = Datos(1)
   Loop
'PRD-6010
End Function


Private Sub LimpiaFolioSOMA_GRILLA()
'PRD-6010
   Dim nFila As Long
   
   For nFila = 1 To Grilla.Rows - 1
      Let Grilla.TextMatrix(nFila, Col_ID_SOMA) = Format(0, FDec0Dec)      'PRD-6010
      Let Grilla.TextMatrix(nFila, Col_Correla_SOMA) = Format(0, FDec0Dec) 'PRD-6010
   Next nFila
'PRD-6010
End Sub


Private Sub Resumen_Folios_SOMA_Cargados(nNomArch As String)
'PRD-6010
Dim nFila As Long
Dim SOMACargados  As String
Dim SOMANoCargados  As String
   
   For nFila = 1 To Grilla.Rows - 1
        If Grilla.TextMatrix(nFila, Col_ID_SOMA) <> 0 Then
            Let SOMACargados = SOMACargados & Grilla.TextMatrix(nFila, Col_ID_SOMA) & " - " & Grilla.TextMatrix(nFila, Col_Correla_SOMA) & ". Serie : " & Grilla.TextMatrix(nFila, COL_Serie) & vbCrLf
            Call Grabar_Log_Carga_SOMA("FLI", Grilla.TextMatrix(nFila, Col_ID_SOMA), Grilla.TextMatrix(nFila, Col_Correla_SOMA), Grilla.TextMatrix(nFila, COL_Serie), nNomArch, Grilla.TextMatrix(nFila, Col_ID_SOMA) & " - " & Grilla.TextMatrix(nFila, Col_Correla_SOMA) & ". Serie : " & Grilla.TextMatrix(nFila, COL_Serie) & ". Cargada correctamente.", CDbl(Grilla.TextMatrix(nFila, Col_Nominal)), 0)
        End If
   Next nFila
   
   
   For nFila = 1 To GridErroresSOMA.Rows - 1
        If GridErroresSOMA.TextMatrix(nFila, 0) <> 0 Then
            Let SOMANoCargados = SOMANoCargados & GridErroresSOMA.TextMatrix(nFila, 0) & " - " & GridErroresSOMA.TextMatrix(nFila, 3) & " Serie : " & GridErroresSOMA.TextMatrix(nFila, 2) & vbCrLf
            Call Grabar_Log_Carga_SOMA("FLI", GridErroresSOMA.TextMatrix(nFila, 0), GridErroresSOMA.TextMatrix(nFila, 1), GridErroresSOMA.TextMatrix(nFila, 2), nNomArch, GridErroresSOMA.TextMatrix(nFila, 0) & " - " & GridErroresSOMA.TextMatrix(nFila, 3), CDbl(GridErroresSOMA.TextMatrix(nFila, 4)), CDbl(GridErroresSOMA.TextMatrix(nFila, 5)))
        End If
   Next nFila
   
     
   If SOMACargados <> "" Or SOMANoCargados <> "" Then
       MsgBox "Los siguiente Folios SOMA fueron cargados correctamente : " & vbCrLf & SOMACargados & vbCrLf _
            & "Los siguientes Folios SOMA  No fueron cargados : " & vbCrLf & SOMANoCargados & vbCrLf
    End If
    
  
'PRD-6010
End Sub


Private Sub Llena_GrillaErroresSOMA(Numoper As Long, correla As Long, Serie As String, Mensaje As String, NominalSoma As Double, NominalBac As Double)
'PRD-6010
   Let GridErroresSOMA.Rows = GridErroresSOMA.Rows + 1
   Let GridErroresSOMA.TextMatrix(GridErroresSOMA.Rows - 1, 0) = Numoper
   Let GridErroresSOMA.TextMatrix(GridErroresSOMA.Rows - 1, 1) = correla
   Let GridErroresSOMA.TextMatrix(GridErroresSOMA.Rows - 1, 2) = Serie
   Let GridErroresSOMA.TextMatrix(GridErroresSOMA.Rows - 1, 3) = Mensaje
   Let GridErroresSOMA.TextMatrix(GridErroresSOMA.Rows - 1, 4) = NominalSoma
   Let GridErroresSOMA.TextMatrix(GridErroresSOMA.Rows - 1, 5) = NominalBac

'PRD-6010
End Sub


Private Sub LimpiaGrillaErroresSOMA()
'PRD-6010
 Dim nFila As Long
   GridErroresSOMA.Clear
   Let GridErroresSOMA.Rows = 1:   Let GridErroresSOMA.FixedRows = 0
   Let GridErroresSOMA.cols = 6:   Let GridErroresSOMA.FixedCols = 0

   Let GridErroresSOMA.TextMatrix(0, 0) = "Folio SOMA":  Let GridErroresSOMA.ColWidth(0) = 700
   Let GridErroresSOMA.TextMatrix(0, 1) = "Corre SOMA":  Let GridErroresSOMA.ColWidth(1) = 500
   Let GridErroresSOMA.TextMatrix(0, 2) = "Serie SOMA":  Let GridErroresSOMA.ColWidth(2) = 1500
   Let GridErroresSOMA.TextMatrix(0, 3) = "Error SOMA":  Let GridErroresSOMA.ColWidth(3) = 3000
   Let GridErroresSOMA.TextMatrix(0, 4) = "Nominal SOMA":  Let GridErroresSOMA.ColWidth(4) = 2000
   Let GridErroresSOMA.TextMatrix(0, 5) = "Nominal BAC":   Let GridErroresSOMA.ColWidth(5) = 2000
   
 

   For nFila = 1 To GridErroresSOMA.Rows - 1
      Let GridErroresSOMA.TextMatrix(nFila, 0) = Format(0, FDec0Dec)
      Let GridErroresSOMA.TextMatrix(nFila, 1) = Format(0, FDec0Dec)
      Let GridErroresSOMA.TextMatrix(nFila, 2) = ""
      Let GridErroresSOMA.TextMatrix(nFila, 3) = ""
      Let GridErroresSOMA.TextMatrix(nFila, 4) = 0#
      Let GridErroresSOMA.TextMatrix(nFila, 5) = 0#

   Next nFila
'PRD-6010
End Sub

Public Sub Grabar_Log_Carga_SOMA(TipoOper As String, FolioSOMA As Long, CorrelaSOMA As Long, Serie As String, NombreArch As String, Observ As String, NominalSoma As Double, NominalBac As Double)
'PRC-6010
 Envia = Array()
 AddParam Envia, gsBac_Fecp
 AddParam Envia, gsBac_Term
 AddParam Envia, gsBac_User
 AddParam Envia, GLB_ID_SISTEMA
 AddParam Envia, TipoOper
 AddParam Envia, FolioSOMA
 AddParam Envia, CorrelaSOMA
 AddParam Envia, Serie
 AddParam Envia, CDbl(NominalSoma)
 AddParam Envia, CDbl(NominalBac)
 AddParam Envia, NombreArch
 AddParam Envia, Observ
 If Not Bac_Sql_Execute("SP_GRABA_LOG_CARGA_ARCHIVO_SOMA", Envia) Then
     MsgBox "Problemas al Grabar Log de carga archivo SOMA : " & NombreArch, vbCritical
 End If
 
'PRC-6010
End Sub

Sub SeleccionVentas()
'PRD-6010
Dim nFila As Long

 If Toolbar1.Buttons(5).Tag = "Ver Todos" Then
        Toolbar1.Buttons(5).Tag = "Ver Sel."
        Toolbar1.Buttons(5).ToolTipText = "Ver Selección"
       
        For nFila = 1 To Grilla.Rows - 1
           If Grilla.TextMatrix(nFila, Col_Marca) <> "V" And Grilla.TextMatrix(nFila, Col_Marca) <> "P" Then
              Grilla.RowHeight(nFila) = nAlturaFila
           End If
        Next nFila

        
 Else
        Toolbar1.Buttons(5).Tag = "Ver Todos"
        Toolbar1.Buttons(5).ToolTipText = "Ver Todos"
        For nFila = 1 To Grilla.Rows - 1
           If Grilla.TextMatrix(nFila, Col_Marca) <> "V" And Grilla.TextMatrix(nFila, Col_Marca) <> "P" Then
              Let nAlturaFila = Grilla.RowHeight(nFila)
              Grilla.RowHeight(nFila) = 0
           End If
        Next nFila

        
 End If
   
'PRD-6010
End Sub

Private Function VerificaSerieSOMA_Errores(SerieSoma As String, FolioSOMA As Long, CorrelaSOMA As Long) As Boolean
'PRD-6010
Dim nContador  As Long

    Let VerificaSerieSOMA_Errores = False
    
    For nContador = 1 To GridErroresSOMA.Rows - 1

      If (CDbl(GridErroresSOMA.TextMatrix(nContador, 0)) = FolioSOMA) Then
           
               Let VerificaSerieSOMA_Errores = True
               Exit Function
      End If
        
    Next nContador
    
    If VerificaSerieSOMA_Errores = False Then
        VerificaSerieSOMA_Errores = False
        Exit Function
    End If

   VerificaSerieSOMA_Errores = True
   
'PRD-6010
End Function


Public Function CargaArchivo_Soma_Excel(ByRef xGrilla As MSFlexGrid) As Boolean
   Dim oFile      As String
   Dim oPath      As String
   Dim MiExcel    As Object
   Dim MiLibro    As Object
   Dim MiHoja     As Object
   Dim nFilas     As Long
   Dim nContador  As Long
   Dim nSwith     As Boolean
      
   Dim CantFolioSOMA As Long
   Dim ContLinea     As Long
   Dim X             As Long
   Dim nEstado       As Long
   Dim Datos()
   Dim Msg           As String
   Dim Error         As String
   Dim nNumoper      As Long
   Dim nValida       As Long
   Dim sSerie        As String
   Dim nRutEmisor    As Double
   
   If Right(gsBac_DIRSOMA, 1) <> "\" Then
      Let gsBac_DIRSOMA = gsBac_DIRSOMA & "\"
   End If
   
   Let SwErrorArch = False
   Let cNombreArchivo = "Fli" & Format(gsBac_Fecp, "YY") & Format(gsBac_Fecp, "MM") & Format(gsBac_Fecp, "DD") & ".xlsx"
   Let oPath = gsBac_DIRSOMA & cNombreArchivo

   If Dir(oPath) = "" Then
      Call MsgBox("El archivo requerido para la carga. [" & cNombreArchivo & "]. no se encuentra... Favor Revisar.", vbExclamation, App.Title)
      Exit Function
   End If
    
   Let Error = ""
   Let Msg = ""
  

   ContLinea = 0
   nContador = 0
   
   xGrilla.Clear
   Call SettingGridSoma(xGrilla)
   Let xGrilla.Rows = 2
   Let xGrilla.Redraw = False

   Let CantFolioSOMA = 0
   
   Call LimpiaGrillaErroresSOMA
   Call CargaFoliosSOMABac(GridFolioSOMA)
   Call BuscaFolioAnuladoExcel(oPath, cNombreArchivo, GridFolioSOMA)

   Let Screen.MousePointer = vbHourglass
   Let nFilas = 50

   Set MiExcel = CreateObject("Excel.Application")
   Set MiLibro = MiExcel.Workbooks.Open(oPath)

   Set MiHoja = Nothing
   Set MiHoja = MiLibro.Worksheets(1)

   
   On Error GoTo errRead

   For nContador = 2 To nFilas

      Let Progreso.Value = nContador
      Let LblProgreso.Caption = "Cargando Archivo...  " & Trim(Progreso.Value) & " %"
      Let nEstado = 0
      
      
      If (UCase(MiHoja.Cells(nContador - 1, "A")) <> UCase("")) Then ' if para celda ""
      
         If (UCase(MiHoja.Cells(nContador - 1, "A")) = UCase("ID")) Then
             ContLinea = 0
         End If
               
         
         ContLinea = ContLinea + 1
        
        If ContLinea = 1 Then

                For X = 0 To 3

                  Select Case nEstado
                    Case 0
                        If (UCase(MiHoja.Cells(nContador - 1, "A")) = UCase("ID")) Then
                            nEstado = 1
                        Else
                            GoTo errRead
                        End If
                    Case 1
                        If (UCase(MiHoja.Cells(nContador - 1, "B")) = UCase("Fecha")) Then
                            nEstado = 2
                        Else
                            GoTo errRead
                        End If
                    Case 2
                        If (UCase(MiHoja.Cells(nContador - 1, "C")) = UCase("Institucion")) Then
                            nEstado = 3
                        Else
                            GoTo errRead
                        End If
                    Case 3
                        If (UCase(MiHoja.Cells(nContador - 1, "D")) = UCase("Monto Nominal")) Then
                            Exit For
                        Else
                            GoTo errRead
                        End If
                  End Select

                Next X

        End If
        
        
        If ContLinea = 2 Then
             nNumoper = UCase(MiHoja.Cells(nContador - 1, "A"))

        End If
        
        
        If ContLinea = 3 Then


                For X = 0 To 3

                  Select Case nEstado
                    Case 0
                        If (UCase(MiHoja.Cells(nContador - 1, "A")) = UCase("Correlativo")) Then
                            nEstado = 1

                        Else
                            GoTo errRead
                        End If
                    Case 1
                        If (UCase(MiHoja.Cells(nContador - 1, "B")) = UCase("Mnemotecnico")) Then
                            nEstado = 2
                        Else
                            GoTo errRead
                        End If
                    Case 2
                        If (UCase(MiHoja.Cells(nContador - 1, "C")) = UCase("Monto Nominal")) Then
                            nEstado = 3
                        Else
                            GoTo errRead
                        End If
                    Case 3
                        If (UCase(MiHoja.Cells(nContador - 1, "D")) = UCase("Valor Inicial")) Then
                            Exit For
                        Else
                            GoTo errRead
                        End If
                  End Select



                Next X


        End If
        

        If ContLinea >= 4 Then

             Envia = Array()
             AddParam Envia, CDbl(nNumoper)
             AddParam Envia, UCase(MiHoja.Cells(nContador - 1, "B"))
             AddParam Envia, gsBac_User
             AddParam Envia, CarterasFinancieras
             AddParam Envia, CarterasNormativas
             AddParam Envia, MihWnd
             AddParam Envia, "FLI"

             If Not Bac_Sql_Execute("SP_VALIDAARCHIVO_BCCH", Envia) Then
                Call BacRollBackTransaction
                Call MsgBox("Se ha producido un error en la busqueda.", vbExclamation, App.Title)
                Exit Function
             End If

             If Bac_SQL_Fetch(Datos()) Then
                nValida = Val(Datos(1))
                sSerie = Datos(2)
                nRutEmisor = Datos(3)
             End If


           If UCase(MiHoja.Cells(nContador - 1, "A")) <> "" And nValida = 0 Then
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 0) = sSerie
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 1) = Format(CDbl(UCase(MiHoja.Cells(nContador - 1, "C"))), FDec4Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 2) = 0#
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 3) = 0#
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 4) = 0
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 5) = 0#
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 6) = Format(CDbl(UCase(MiHoja.Cells(nContador - 1, "D"))), FDec4Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 7) = Format(CDbl(nNumoper), FDec0Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 8) = Format(CDbl(UCase(MiHoja.Cells(nContador - 1, "A"))), FDec0Dec)
              Let xGrilla.TextMatrix(xGrilla.Rows - 1, 9) = nRutEmisor

              Let xGrilla.Rows = xGrilla.Rows + 1

           Else

              nFilas = xGrilla.Rows - 1
              If UCase(MiHoja.Cells(nContador - 1, "A")) <> "" Then
                 Call EliminaFolioSomaGrilla(nFilas, CDbl(nNumoper))

                 If nValida = 2 And CantFolioSOMA < 1 Then
                    Let Error = Error & "  Serie instrumento [" & UCase(MiHoja.Cells(nContador - 1, "B")) & "] no esta disponible en cartera BAC, la cual corresponde al siguiente Folio  SOMA: [" & nNumoper & "]" & vbCrLf
                    Let Msg = "Serie Instrumento no está disponible"
                    Call Llena_GrillaErroresSOMA(Format(CDbl(nNumoper), FDec0Dec), Format(CDbl(UCase(MiHoja.Cells(nContador - 1, "A")))), UCase(MiHoja.Cells(nContador - 1, "B")), Msg, Format(CDbl(UCase(MiHoja.Cells(nContador - 1, "D"))), FDec4Dec), 0)

                 Else
                    If ContLinea = 4 Then
                        Let Error = Error & "  Folio SOMA   [" & nNumoper & "] ya se encuentra cargado en BAC." & vbCrLf
                        Let Msg = "Folio SOMA, ya se encuentra cargado"
                        Call Llena_GrillaErroresSOMA(Format(CDbl(nNumoper), FDec0Dec), Format(CDbl(UCase(MiHoja.Cells(nContador - 1, "A")))), UCase(MiHoja.Cells(nContador - 1, "B")), Msg, Format(CDbl(UCase(MiHoja.Cells(nContador - 1, "D"))), FDec4Dec), 0)
                        CantFolioSOMA = CantFolioSOMA + 1

                    End If

                 End If
              End If

           End If


        End If

        

        
    End If   ' if para celda ""
              
        Let Progreso.Value = nContador

   Next nContador
   
   If Len(Error) > 0 Or Len(ErrAnula) > 0 Then
      Call MsgBox("Se han encontrado las siguientes Observaciones:" & vbCrLf & vbCrLf & Error & vbCrLf & ErrAnula & vbCrLf, vbExclamation, App.Title)
   End If
   
   
   Set MiHoja = Nothing
   Call MiLibro.Close
   Set MiExcel = Nothing
   
   Let xGrilla.Redraw = True
   Let Progreso.Value = 0
   Let LblProgreso.Caption = "Lectura de Archivo SOMA"
   Let Screen.MousePointer = vbDefault
   
   Exit Function
   
errRead:
    MsgBox "No se pudo continuar la lectura del archivo. Favor Revisar." & oPath & vbCrLf & err.Description, vbCritical
    Let SwErrorArch = True
   
End Function

Public Sub BuscaFolioAnuladoExcel(Ruta As String, NombreArchivo As String, ByRef xGrilla As MSFlexGrid)
'PRD-6010
Dim xLine
Dim nFilFolio As Long
Dim nResul    As Long
Dim oFile     As String
Dim Msg       As String
Dim oPath     As String
Dim MiHoja    As Object
Dim nContador As Long
Dim nFilas    As Long
Dim ContLinea As Long
Dim X         As Long
Dim nEstado   As Long
Dim nNumoper  As Long
Let ErrAnula = ""
Let Msg = ""


   If Dir(Ruta) = "" Then
      Call MsgBox("El archivo requerido para la carga. [" & NombreArchivo & "]. no se encuentra... Favor Revisar.", vbExclamation, App.Title)
      Exit Sub
   End If

   Let nFilas = 50
   
   Set MiExcel = CreateObject("Excel.Application")
   Set MiLibro = MiExcel.Workbooks.Open(Ruta)

   Set MiHoja = Nothing
   Set MiHoja = MiLibro.Worksheets(1)

   

       For nFilFolio = 1 To xGrilla.Rows - 1
           
              For nContador = 2 To nFilas
              
               If UCase(MiHoja.Cells(nContador - 1, "A")) <> UCase("") Then
                                          
                  If xGrilla.TextMatrix(nFilFolio, 0) <> 0 Then
                    If InStr(UCase(MiHoja.Cells(nContador - 1, "A")), xGrilla.TextMatrix(nFilFolio, 0)) = 0 Then
                        Let nResul = nResul + 1
                    Else
                        Let nResul = 0
                        Exit For
                    End If
               End If
               End If
              
              Next nContador
              
                    If nResul > 1 Then
                       Let ErrAnula = ErrAnula & " Falta anular operación FLI en BAC con número [" & CDbl(xGrilla.TextMatrix(nFilFolio, 1)) & "], que referencia a folio SOMA[" & CDbl(xGrilla.TextMatrix(nFilFolio, 0)) & "], que ya no existe en archivo [" & NombreArchivo & "]" & vbCrLf
                       Let Msg = "Debe Anular Oparación FLI en BAC [" & CDbl(xGrilla.TextMatrix(nFilFolio, 1)) & "], ya que no existe Folio SOMA en Archivo"

                       nResul = 0
                    End If

      Next nFilFolio
      
      Set MiHoja = Nothing
      Call MiLibro.Close
      Set MiExcel = Nothing


'PRD-6010
End Sub

