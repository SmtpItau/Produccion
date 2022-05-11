VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacCI 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Compras con pacto"
   ClientHeight    =   5580
   ClientLeft      =   2145
   ClientTop       =   1620
   ClientWidth     =   12570
   DrawWidth       =   2
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmdci.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5580
   ScaleWidth      =   12570
   Visible         =   0   'False
   Begin VB.Frame Frame1 
      Caption         =   "Total Operacion"
      ForeColor       =   &H00800000&
      Height          =   675
      Left            =   9840
      TabIndex        =   38
      Top             =   1755
      Width           =   2655
      Begin BACControles.TXTNumero TxtTotal 
         CausesValidation=   0   'False
         Height          =   285
         Left            =   75
         TabIndex        =   39
         Top             =   225
         Width           =   2445
         _ExtentX        =   4313
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
         Min             =   "-999999999999999"
         Max             =   "999999999999999"
         Separator       =   -1  'True
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2940
      Top             =   15
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdci.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdci.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdci.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdci.frx":0D90
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmdci.frx":10AA
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   45
      TabIndex        =   29
      Top             =   0
      Width           =   12480
      _ExtentX        =   22013
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar Operación"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdEmision"
            Description     =   "Emision"
            Object.ToolTipText     =   "Datos de Emisión"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdCortes"
            Description     =   "Cortes"
            Object.ToolTipText     =   "Cortes"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdLimpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar Pantalla"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir de la Ventana"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.ComboBox Combo1 
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
      ItemData        =   "Bacmdci.frx":13C4
      Left            =   3000
      List            =   "Bacmdci.frx":13D1
      Style           =   2  'Dropdown List
      TabIndex        =   28
      Top             =   3255
      Visible         =   0   'False
      Width           =   1215
   End
   Begin BACControles.TXTNumero TEXT2 
      Height          =   315
      Left            =   1560
      TabIndex        =   27
      Top             =   3255
      Visible         =   0   'False
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   556
      BackColor       =   8388608
      ForeColor       =   16777215
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
      Min             =   "-99"
      Max             =   "99999999999999.9999"
      CantidadDecimales=   "4"
      Separator       =   -1  'True
   End
   Begin VB.TextBox Text1 
      BackColor       =   &H00800000&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   285
      TabIndex        =   26
      Top             =   3255
      Visible         =   0   'False
      Width           =   1095
   End
   Begin MSFlexGridLib.MSFlexGrid Table1 
      Height          =   3135
      Left            =   0
      TabIndex        =   10
      Top             =   2430
      Width           =   12525
      _ExtentX        =   22093
      _ExtentY        =   5530
      _Version        =   393216
      Cols            =   12
      FixedCols       =   0
      RowHeightMin    =   315
      BackColor       =   16777215
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      Enabled         =   0   'False
      FocusRect       =   0
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
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   "C:\BTRADER\MDBDEUT\BACTRD.MDB"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   300
      Left            =   2880
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   "MDCI"
      Top             =   6720
      Visible         =   0   'False
      Width           =   2910
   End
   Begin Threed.SSFrame Frame 
      Height          =   1920
      Index           =   1
      Left            =   2955
      TabIndex        =   11
      Top             =   510
      Width           =   3600
      _Version        =   65536
      _ExtentX        =   6350
      _ExtentY        =   3387
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
         Left            =   2415
         TabIndex        =   3
         Top             =   285
         Width           =   1125
         _ExtentX        =   1984
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
         CantidadDecimales=   "04"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero TxtPlazo 
         Height          =   315
         Left            =   2550
         TabIndex        =   5
         Top             =   1050
         Width           =   975
         _ExtentX        =   1720
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
      Begin BACControles.TXTNumero TxtTasa 
         Height          =   315
         Left            =   2520
         TabIndex        =   4
         Top             =   675
         Width           =   990
         _ExtentX        =   1746
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
         MarcaTexto      =   -1  'True
      End
      Begin VB.ComboBox CmbBase 
         BackColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   825
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   2340
         Width           =   795
      End
      Begin VB.ComboBox CmbMon 
         Height          =   315
         Left            =   885
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   285
         Width           =   1140
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         Caption         =   "T/C"
         ForeColor       =   &H8000000D&
         Height          =   195
         Left            =   2040
         TabIndex        =   30
         Top             =   360
         Width           =   315
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   6
         Left            =   135
         TabIndex        =   15
         Top             =   345
         Width           =   690
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Plazo"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   5
         Left            =   135
         TabIndex        =   14
         Top             =   1095
         Width           =   480
      End
      Begin VB.Label Label 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Base"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   4
         Left            =   150
         TabIndex        =   13
         Top             =   2385
         Width           =   435
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Tasa"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   3
         Left            =   135
         TabIndex        =   12
         Top             =   720
         Width           =   465
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1170
      Index           =   2
      Left            =   9840
      TabIndex        =   16
      Top             =   525
      Width           =   2655
      _Version        =   65536
      _ExtentX        =   4683
      _ExtentY        =   2064
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
         Height          =   315
         Left            =   795
         TabIndex        =   9
         Top             =   660
         Width           =   1695
         _ExtentX        =   2990
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
         Max             =   "9999999999999999.9999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTFecha TxtFecVct 
         Height          =   300
         Left            =   1275
         TabIndex        =   8
         Top             =   285
         Width           =   1215
         _ExtentX        =   2143
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
         Text            =   "15/11/2000"
      End
      Begin VB.Label Lbl_Dia 
         Caption         =   "Miercoles"
         ForeColor       =   &H00800000&
         Height          =   210
         Index           =   1
         Left            =   120
         TabIndex        =   22
         Top             =   390
         Width           =   975
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         BackStyle       =   0  'Transparent
         Caption         =   "US$"
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   8
         Left            =   75
         TabIndex        =   17
         Top             =   750
         Width           =   495
      End
   End
   Begin Threed.SSFrame Agosto 
      Height          =   1920
      Index           =   0
      Left            =   45
      TabIndex        =   18
      Top             =   495
      Width           =   2865
      _Version        =   65536
      _ExtentX        =   5054
      _ExtentY        =   3387
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
         Height          =   315
         Left            =   840
         TabIndex        =   25
         Top             =   975
         Width           =   1935
         _ExtentX        =   3413
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
         Max             =   "9999999999999999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txtIniPMP 
         Height          =   315
         Left            =   840
         TabIndex        =   24
         Top             =   615
         Width           =   1935
         _ExtentX        =   3413
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
         Min             =   "-9999999999999999.9999"
         Max             =   "9999999999999999.9999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTFecha TxtFecIni 
         Height          =   300
         Left            =   1440
         TabIndex        =   23
         Top             =   270
         Width           =   1335
         _ExtentX        =   2355
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
         Text            =   "15/11/2000"
      End
      Begin VB.Label Lbl_Dia 
         Caption         =   "Miercoles"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   21
         Top             =   255
         Width           =   975
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "US$"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   60
         TabIndex        =   20
         Top             =   645
         Width           =   495
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "$$"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   2
         Left            =   60
         TabIndex        =   19
         Top             =   1035
         Width           =   495
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
      Height          =   555
      Left            =   45
      TabIndex        =   31
      Top             =   1875
      Width           =   2865
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
         Left            =   555
         TabIndex        =   0
         TabStop         =   0   'False
         Top             =   240
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
         Left            =   1410
         TabIndex        =   1
         TabStop         =   0   'False
         Top             =   240
         Width           =   735
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1905
      Index           =   3
      Left            =   6600
      TabIndex        =   32
      Top             =   525
      Width           =   3225
      _Version        =   65536
      _ExtentX        =   5689
      _ExtentY        =   3360
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
         Height          =   315
         Left            =   1470
         TabIndex        =   33
         Top             =   660
         Width           =   1650
         _ExtentX        =   2910
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "04"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero Txt_TasaTran 
         Height          =   315
         Left            =   2115
         TabIndex        =   6
         Top             =   285
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
         Left            =   1470
         TabIndex        =   37
         Top             =   1035
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
         Left            =   1470
         TabIndex        =   40
         Top             =   1395
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
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   60
         TabIndex        =   41
         Top             =   1440
         Width           =   1275
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Resultado"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   7
         Left            =   60
         TabIndex        =   36
         Top             =   1065
         Width           =   870
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Tasa Trans."
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   11
         Left            =   60
         TabIndex        =   35
         Top             =   315
         Width           =   1035
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Val. Fin. Trans."
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   9
         Left            =   60
         TabIndex        =   34
         Top             =   690
         Width           =   1320
      End
   End
End
Attribute VB_Name = "BacCI"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Monto As Double
Dim tblTabla            As Recordset
Dim FormHandle          As Long
Dim sFecPro             As String
Dim bufNominal          As Double
Dim Tecla               As String
Dim dTipcam#
Dim nCont%
Dim iFlagKeyDown
Dim bufFecVen           As String
Dim u As Integer
Dim k As Integer
Dim q As Integer
Dim Antes As Double
Public nDolarOb              As Double
Public nUf                   As Double

Public glBacCpDvpCi       As DvpCp

Private Sub Func_Emision()

   If Not Table1.Rows - 1 = 1 Then
      Call Colocardata1

   Else
      Data1.Recordset.MoveFirst

   End If

   If Trim$(Data1.Recordset("tm_instser")) = "" Then
      Beep
      Exit Sub

   End If

   'Guarda datos en variable global
   With BacDatEmi
      .sInstSer = Data1.Recordset("tm_instser")
      .lRutemi = Data1.Recordset("tm_rutemi")
      .iMonemi = Data1.Recordset("tm_monemi")
      .sFecEmi = Data1.Recordset("tm_fecemi")
      .sFecvct = Data1.Recordset("tm_fecven")
      .dTasEmi = Data1.Recordset("tm_tasemi")
      .iBasemi = Data1.Recordset("tm_basemi")
      .sRefNomi = Data1.Recordset("tm_refnomi")
      .sGeneri = Data1.Recordset("tm_genemi")

   End With

   bufFecVen = BacDatEmi.sFecvct
   BacIrfEm.varPsSeriado = Data1.Recordset("tm_mdse")

   BacIrfEm.Tag = "CI"

   'Pantalla de Datos de Emision
   BacIrfEm.Show 1

   If giAceptar% = True Then
      With BacDatEmi
         Data1.Recordset.Edit
         Data1.Recordset("tm_instser") = .sInstSer
         Data1.Recordset("tm_rutemi") = .lRutemi
         Data1.Recordset("tm_monemi") = .iMonemi
         Data1.Recordset("tm_fecemi") = .sFecEmi
         Data1.Recordset("tm_fecven") = .sFecvct
         Data1.Recordset("tm_tasemi") = .dTasEmi
         Data1.Recordset("tm_basemi") = .iBasemi
         Data1.Recordset("tm_genemi") = .sGeneri

         If bufFecVen <> BacDatEmi.sFecvct Then
            Data1.Recordset("tm_valmcd") = "N"

         End If

         Data1.Recordset.Update

      End With

   End If

   BacControlWindows 12
   If Table1.Enabled = True Then: Table1.SetFocus

End Sub

Private Sub Func_Limpiar_Pantalla()

   Dim nSw              As Integer
   Dim nCont            As Integer

   Data1.Refresh

   TxtTotal.Enabled = False
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(4).Enabled = False

   nSw = 0
   nCont = 1

   TxtFecVct.Text = Format$(DateAdd("d", 1, TxtFecIni.Text), "dd/mm/yyyy")

   Do While nSw = 0
      If EsFeriado(CDate(TxtFecVct.Text), "00001") Then
         nCont = nCont + 1
         TxtFecVct.Text = Format$(DateAdd("d", 1, TxtFecVct.Text), "dd/mm/yyyy")

      Else
         nSw = 1

      End If

   Loop

   txtplazo.Text = DateDiff("D", TxtFecIni.Text, TxtFecVct.Text)
  
   If Data1.Recordset.RecordCount < 1 Then Exit Sub
      With Data1.Recordset
         .MoveFirst
         Do While Not .EOF
            .Delete
            .MoveNext

         Loop

      End With

      Data1.Refresh
      Call Limpia_Pantalla

      Call CI_Agregar(hWnd, Data1)

   Table1.Refresh

   TxtTotal.Text = 0
   TxtTasa.Text = 0
   
   Txt_TasaTran.Text = 0
   Txt_VFTran.Text = 0
   Txt_DifTran.Text = 0
   Txt_Dif_CLP.Text = 0
'   OptPesos.Enabled = True
'   OptDolar.Enabled = True
'   OptPesos.Value = True
'   OptDolar.Value = False
End Sub
Private Sub Limpia_Pantalla()
   
      Dim x
      Dim I
         Combo1.ListIndex = 0
         x = Table1.Rows
      For I = 2 To Table1.Rows - 1
        Table1.RemoveItem (I)
      Next

    Table1.Rows = 2

      If Table1.Rows > 2 Then
         Table1.RemoveItem Table1.Row
      Else
         Table1.TextMatrix(Table1.Row, 2) = "0.0000"
         Table1.TextMatrix(Table1.Row, 3) = "0.0000"
         Table1.TextMatrix(Table1.Row, 4) = "0.0000"
         Table1.TextMatrix(Table1.Row, 5) = "0.0000"
         Table1.TextMatrix(Table1.Row, 6) = "" 'ACAMODIFIC""
         Table1.TextMatrix(Table1.Row, 7) = ""
         Table1.TextMatrix(Table1.Row, 8) = "0.0000"
         Table1.TextMatrix(Table1.Row, 9) = "0"
         Table1.TextMatrix(Table1.Row, 10) = "0"
         Table1.TextMatrix(Table1.Row, 11) = "0"
         Table1.Col = 0

      End If

End Sub

Private Function Colocardata1()
   
Dim I As Integer
  Monto = CDbl(Table1.TextMatrix(Table1.Row, 3))
  
  Data1.Recordset.MoveFirst
  For I = 1 To Table1.Row - 1
        Data1.Recordset.MoveNext
  Next I
End Function

Private Sub Limpia_grilla()

   Combo1.ListIndex = 0

   Table1.TextMatrix(Table1.Row, 2) = "0.0000"
   Table1.TextMatrix(Table1.Row, 3) = "0.0000"
   Table1.TextMatrix(Table1.Row, 4) = "0.0000"
   Table1.TextMatrix(Table1.Row, 5) = "0.0000"
   Table1.TextMatrix(Table1.Row, 6) = "" 'ACAMODIFIC""
   Table1.TextMatrix(Table1.Row, 7) = ""
   Table1.TextMatrix(Table1.Row, 8) = "0.0000"
   Table1.TextMatrix(Table1.Row, 9) = "0"
   Table1.TextMatrix(Table1.Row, 10) = "0"
   Table1.TextMatrix(Table1.Row, 11) = "0"
   Table1.Col = 0

End Sub

Private Sub Llena_Grilla()

   Table1.TextMatrix(Table1.Row, 1) = Data1.Recordset!TM_NEMMON
   Table1.TextMatrix(Table1.Row, 2) = Format(Data1.Recordset!tm_nominal, "#,##0.0000")
   Table1.TextMatrix(Table1.Row, 3) = Format(Data1.Recordset!TM_TIR, "#,##0.0000")
   Table1.TextMatrix(Table1.Row, 4) = Format(Data1.Recordset!TM_Pvp, "#,##0.0000")
   Table1.TextMatrix(Table1.Row, 5) = Format(Data1.Recordset!TM_MT, IIf(Data1.Recordset!TM_NEMMON = "USD", "#,###,###,##0.00", "#,###,###,##0"))
   'Arm
   'Table1.TextMatrix(Table1.Row, 6) = IIf(IsNull(Data1.Recordset!tm_custodia) = True, " ", Data1.Recordset!tm_custodia)
   'Table1.TextMatrix(Table1.Row, 7) = IIf(IsNull(Data1.Recordset!tm_clave_dcv) = True, " ", Data1.Recordset!tm_clave_dcv)
   Table1.TextMatrix(Table1.Row, 8) = Format(Data1.Recordset!tm_tirmcd, "#,##0.0000")
   Table1.TextMatrix(Table1.Row, 9) = Format(Data1.Recordset!tm_pvpmcd, "#,##0.0000")
   Table1.TextMatrix(Table1.Row, 10) = Format(Data1.Recordset!tm_mtmcd, IIf(Data1.Recordset!TM_NEMMON = "USD", "#,###,###,##0.00", "#,###,###,##0"))
   Table1.TextMatrix(Table1.Row, 11) = Format(CDbl(Data1.Recordset!TM_MT) - CDbl(Data1.Recordset!tm_mtmcd), IIf(Data1.Recordset!TM_NEMMON = "USD", "#,###,###,##0.00", "#,###,###,##0"))


   
   
End Sub

Private Sub Genera_Grilla()

   Table1.cols = 13
   Table1.ColWidth(0) = 1400
   Table1.ColWidth(1) = 500
   Table1.ColWidth(2) = 1800
   Table1.ColWidth(3) = 900
   Table1.ColWidth(4) = 900
   Table1.ColWidth(5) = 1800
   Table1.ColWidth(6) = 1500
   Table1.ColWidth(7) = 1500
   Table1.ColWidth(8) = 900
   Table1.ColWidth(9) = 900
   Table1.ColWidth(10) = 2000
   Table1.ColWidth(11) = 0
   Table1.ColWidth(12) = 0

   Table1.TextMatrix(0, 0) = "Serie"
   Table1.TextMatrix(0, 1) = "UM"
   Table1.TextMatrix(0, 2) = "Nominal"
   Table1.TextMatrix(0, 3) = "% Tir"
   Table1.TextMatrix(0, 4) = "% Vpar"
   Table1.TextMatrix(0, 5) = "Valor Presente"
   Table1.TextMatrix(0, 6) = "Custodia"
   Table1.TextMatrix(0, 7) = "Clave DCV"
   Table1.TextMatrix(0, 8) = "Tir Mer."
   Table1.TextMatrix(0, 9) = "%Vpar M."
   Table1.TextMatrix(0, 10) = "Valor Tasa Presente"
   Table1.TextMatrix(0, 11) = "Utilidad"
   Table1.TextMatrix(1, 2) = "0.0000"
   Table1.TextMatrix(1, 3) = "0.0000"
   Table1.TextMatrix(1, 4) = "0.0000"
   Table1.TextMatrix(1, 5) = "0"
   Table1.TextMatrix(1, 8) = "0.0000"
   Table1.TextMatrix(1, 9) = "0.0000"
   Table1.TextMatrix(1, 10) = "0"
   Table1.TextMatrix(1, 11) = "0"
   Table1.TextMatrix(1, 12) = "rutEmi"

End Sub

Private Sub CalcularValorFinal()

   Dim base%, Tasa#, Plazo&, TasaTran#
   Dim ValIni As Double
   Dim A As Integer
   
   If CmbMon.ListCount = 0 Then
      MsgBox "Problemas con monedas"
      Exit Sub
   End If
     
   base% = funcBaseMoneda(CmbMon.ItemData(CmbMon.ListIndex))
   Plazo = CDbl(txtplazo.Text)

   ValIni = CDbl(txtIniPMP.Text)
   Tasa = CDbl(TxtTasa.Text)
   TasaTran = CDbl(Txt_TasaTran.Text)
   
   If Plazo = 0 Then Exit Sub
   If Tasa = 0 Then Exit Sub
      
   If SwMx = "C" And CmbMon.ItemData(CmbMon.ListIndex) <> 999 Then
      txtVenPMP.CantidadDecimales = BacDatGrMon.mndecimal
   ElseIf SwMx = "" And CmbMon.ItemData(CmbMon.ListIndex) = 999 Then
      txtVenPMP.CantidadDecimales = 0
   Else
      txtVenPMP.CantidadDecimales = BacDatGrMon.mndecimal
   End If
   
   If dTipcam# = 1 Then
      txtIniPMP.Text = ValIni
      txtVenPMP.Text = BacCtrlTransMonto(Int(CI_ValorFinal(ValIni#, Tasa#, Plazo&, base%)))
      Txt_VFTran.Text = BacCtrlTransMonto(Int(CI_ValorFinal(ValIni#, TasaTran#, Plazo&, base%)))
   Else
      txtVenPMP.Text = BacCtrlTransMonto(CI_ValorFinal(ValIni#, Tasa#, Plazo&, base%))
      Txt_VFTran.Text = Round(BacCtrlTransMonto(CI_ValorFinal(ValIni#, TasaTran#, Plazo&, base%)), Txt_VFTran.CantidadDecimales)
   End If
   
   Txt_DifTran.Text = (txtVenPMP.Text - Txt_VFTran.Text) / (1 + TasaTran / 100 * Plazo / 360)
        
   If dTipcam# = 1 Then
      Txt_Dif_CLP.Text = Round(Txt_DifTran.Text, Txt_Dif_CLP.CantidadDecimales)
   Else
      Txt_Dif_CLP.Text = Round(Txt_DifTran.Text * dTipcam#, Txt_Dif_CLP.CantidadDecimales)
   End If

End Sub

Private Function ValidaDatosCI() As Boolean
Dim bExiste As Boolean
Dim iRow As Long

    bExiste = False
    ValidaDatosCI = False
    
    
    
    Data1.Recordset.MoveFirst
    Do While Not Data1.Recordset.EOF()
    
    
        If Format(Data1.Recordset("tm_fecven"), "YYYYMMDD") <= Format(CDate(TxtFecVct.Text), "YYYYMMDD") Then
            bExiste = True
             Exit Do
        End If
        
        Data1.Recordset.MoveNext
        
    Loop
    If bExiste Then
        MsgBox "Existen instrumentos con vencimientos menor a la fecha de vcto del pacto", vbExclamation, TITSISTEMA
        Exit Function
    End If
    
    ValidaDatosCI = True

End Function

Private Sub ChkMoneda(Columna%)

   Dim MonLiq           As Integer
   Dim Mt#, MtMl#, TcMl#

   If CmbMon.ListIndex = -1 Then
      Exit Sub

   End If

   Mt# = Data1.Recordset("tm_mt")
   MtMl# = Data1.Recordset("tm_mtml")
   TcMl# = Data1.Recordset("tm_tcml")

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

   BacControlWindows 30

   Data1.Recordset.Edit
   Data1.Recordset("tm_mt") = Mt#
   Data1.Recordset("tm_mtml") = MtMl#
   Data1.Recordset("tm_tcml") = TcMl#
   Data1.Recordset.Update

End Sub

Sub Proc_Grabar()

    If Not Proc_Valida_Tasa_Transferencia(CDbl(TxtTasa.Text), CDbl(Txt_TasaTran.Text)) Then
        Txt_TasaTran.SetFocus
        Exit Sub
    End If
    
    BacIrfGr.proMoneda = Trim$(Mid$(CmbMon.Text, 1, 3))
    BacIrfGr.proMtoOper = TxtTotal.Text
    BacIrfGr.proHwnd = hWnd


    If Not ValidaDatosCI() Then
        Exit Sub
    End If

    If Not valida_custodia() Then
       Screen.MousePointer = vbDefault
       If Table1.Enabled = True Then: Table1.SetFocus
       On Error GoTo 0
       Exit Sub
    End If
    
    BacIrfGr.oValorDVP = "glBacCpDvpCi"
    BacIrfGr.oDVP = glBacCpDvpCi
    BacIrfGr.cCodLibro = ""
    
    Call BacGrabarTX

    BacControlWindows 100

    If Not Grabacion_Operacion Then
       Data1.Refresh
    Else
      Call Func_Limpiar_Pantalla
      Call Limpia_grilla
       Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_20300", "01", "Graba Compras Con Pacto", "", "", " ")
    End If


End Sub

Private Sub cmbBase_Click()

   Call CalcularValorFinal

End Sub

Private Sub CmbMon_Change()

   Dim MonLiq           As Integer
   Dim nRedon           As Integer

   If CmbMon.ListIndex = -1 Then
      Exit Sub

   End If

   MonLiq = CmbMon.ItemData(CmbMon.ListIndex)
   
   If Val(CmbMon.Tag) <> MonLiq Then
   
'       If OptDolar Then
'           TxtTotal.Text = Calcula_Monto_Mx(CDbl(BacCtrlTransMonto(CI_SumarTotal(FormHandle))), Data1.Recordset!TM_monemi, 999) ' Siempre es Peso
'       Else
          TxtTotal.Text = BacCtrlTransMonto(CI_SumarTotal(FormHandle))
'       End If
   
        If SwMx = "C" And CmbMon.ItemData(CmbMon.ListIndex) <> 999 Then
          txtIniPMP.CantidadDecimales = BacDatGrMon.mndecimal
          nRedon = BacDatGrMon.mndecimal
        ElseIf SwMx = "" And CmbMon.ItemData(CmbMon.ListIndex) = 999 Then
          txtIniPMP.CantidadDecimales = 0
          nRedon = 0
        Else
          txtIniPMP.CantidadDecimales = BacDatGrMon.mndecimal
          nRedon = BacDatGrMon.mndecimal
        End If
       
        txtIniPMP.Text = BacCtrlTransMonto(IIf(dTipcam# = 0, 0, Round(TxtTotal.Text / dTipcam#, nRedon)))

   End If
      
   BacControlWindows 12

End Sub

Private Sub CmbMon_Click()

   Dim NemMon$
   Dim I%
   Dim nRedon   As Integer
   Dim nResp    As Integer
   
   
   If CmbMon.ListIndex <> -1 Then
      NemMon = Trim$(CmbMon.List(CmbMon.ListIndex))
      Label(1).Caption = NemMon
      Label(8).Caption = NemMon

      Call funcFindDatGralMoneda(CmbMon.ItemData(CmbMon.ListIndex))
      
      SwMx = BacDatGrMon.mnmx
      
      If giMonLoc <> CmbMon.ItemData(CmbMon.ListIndex) Then
         sFecPro = Str(gsBac_Fecp)
         dTipcam# = funcBuscaTipcambio(CmbMon.ItemData(CmbMon.ListIndex), sFecPro)

         If dTipcam# = 0 And CmbMon.ItemData(CmbMon.ListIndex) <> 13 Then
            nResp = MsgBox("Tipo de cambio para : " & NemMon & " con fecha " & gsBac_Fecp & Chr(10) & Chr(13) & " NO ha sido ingresado." & Chr(10) & Chr(13) & " Desea Ingresarlo ? ", vbExclamation + vbYesNo, TITSISTEMA)
            If nResp = 6 Then
                txtTipoCambio.Enabled = IIf(SwMx = "C", True, False)
                txtTipoCambio.Text = dTipcam#
                If txtTipoCambio.Enabled = True Then
                    txtTipoCambio.SetFocus
                Else
                    Me.TxtTasa.SetFocus
                End If
            Else
                For I% = 0 To CmbMon.ListCount - 1
                   If Mid(CmbMon.List(I%), 1, 3) = "CLP" Then
                      CmbMon.ListIndex = I%
                      Exit For
    
                   End If
    
                Next I%
            End If
          ElseIf dTipcam# = 0 And CmbMon.ItemData(CmbMon.ListIndex) = 13 Then
               dTipcam# = funcBuscaTipcambio(994, sFecPro)


         End If
         txtTipoCambio.Text = dTipcam#
      Else
         'Si es igual a la moneda local
         dTipcam# = IIf(CmbMon.ItemData(CmbMon.ListIndex) = 13, nDolarOb, 1)
         txtTipoCambio.Text = dTipcam#
      End If
      
      txtTipoCambio.Enabled = IIf(SwMx = "C", True, False)
      
      If SwMx = "C" And CmbMon.ItemData(CmbMon.ListIndex) <> 999 Then
         txtIniPMP.CantidadDecimales = BacDatGrMon.mndecimal
         nRedon = BacDatGrMon.mndecimal
         Txt_DifTran.CantidadDecimales = BacDatGrMon.mndecimal
         Txt_VFTran.CantidadDecimales = BacDatGrMon.mndecimal
      ElseIf SwMx = "" And CmbMon.ItemData(CmbMon.ListIndex) = 999 Then
            txtIniPMP.CantidadDecimales = 0
            nRedon = 0
            Txt_DifTran.CantidadDecimales = 0
            Txt_VFTran.CantidadDecimales = 0
      Else
        txtIniPMP.CantidadDecimales = BacDatGrMon.mndecimal
        nRedon = BacDatGrMon.mndecimal
        Txt_DifTran.CantidadDecimales = BacDatGrMon.mndecimal
        Txt_VFTran.CantidadDecimales = BacDatGrMon.mndecimal
      End If
      
      If dTipcam# = 0 Then
         txtIniPMP.Text = 0
      Else
         txtIniPMP.Text = Round(IIf(dTipcam# = 0, 0, TxtTotal.Text / dTipcam#), nRedon)
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

Private Sub CmbMon_LostFocus()
  k = 0

End Sub

Private Sub Combo1_Click()

Table1.Col = 6
Table1.Text = Combo1.Text
   If Table1.Col = com_CUST Then
      If Mid(Table1.TextMatrix(Table1.Row, com_CUST), 1, 3) = "DCV" Then
         Table1.TextMatrix(Table1.Row, com_CDCV) = FUNC_GENERA_CLAVE_DCV
         Table1.Col = com_CDCV
      Else
         Table1.TextMatrix(Table1.Row, com_CDCV) = " "
      End If
   End If
   If Me.Visible = True Then
      If Combo1.Visible = True Then
         If Table1.Enabled = True Then: Table1.SetFocus
      End If
   End If
End Sub

Private Sub Combo1_GotFocus()

   Call PROC_POSI_TEXTO(Table1, Combo1)

End Sub

Private Sub Combo1_KeyDown(KeyCode As Integer, Shift As Integer)

  If KeyCode = 27 Then
   Combo1.Visible = False
   If Table1.Enabled = True Then: Table1.SetFocus
   Exit Sub
  End If
   If KeyCode = 13 Then
      If Not Data1.Recordset.RecordCount = 1 Then
         Call Colocardata1

      Else
         Data1.Recordset.MoveFirst

      End If

      Table1.TextMatrix(Table1.Row, com_CUST) = Combo1.Text

      If Table1.Col = com_CUST Then
         If Mid(Table1.TextMatrix(Table1.Row, com_CUST), 1, 3) = "DCV" Then
            Table1.TextMatrix(Table1.Row, com_CDCV) = FUNC_GENERA_CLAVE_DCV
            Table1.Col = com_CDCV

         Else
            Table1.TextMatrix(Table1.Row, com_CDCV) = " "

         End If

      End If

      Data1.Recordset.Edit
      Data1.Recordset!tm_custodia = Combo1.Text
      Data1.Recordset!tm_clave_dcv = Table1.TextMatrix(Table1.Row, com_CDCV)
      Data1.Recordset.Update

      Combo1.Visible = False

      Table1.Col = com_CDCV
      If Table1.Enabled = True Then: Table1.SetFocus

   End If

End Sub

Private Sub Combo1_LostFocus()
   On Error Resume Next

  'Call Combo1_KeyDown(vbKeyReturn, 0)

   Combo1.Visible = False
  'Table1.TextMatrix(Table1.Row, 6) = Combo1.Text
   If Table1.Enabled = True Then: Table1.SetFocus

End Sub

Private Sub data1_Error(DataErr As Integer, Response As Integer)
   MsgBox "Error por data Control: " & DataErr, vbExclamation, gsBac_Version
End Sub

Function valida_custodia() As Boolean
Dim t                As Integer

   valida_custodia = True

   For t = 1 To Table1.Rows - 1
      If Trim(Table1.TextMatrix(t, 6)) = "" Then
         MsgBox "Debe Definir Custodia en Registro " & t, vbExclamation, gsBac_Version
         valida_custodia = False
         Exit Function
      Else
         If Trim(Table1.TextMatrix(t, 6)) = "DCV" And Trim(Table1.TextMatrix(t, 7)) = "" Then
            MsgBox "Debe Definir Clave DCV en Registro " & t
            valida_custodia = False
            Exit Function
         End If
      End If
   Next t

End Function

Private Sub Form_Activate()
q = 1

   Me.Tag = "CI"
   BacControlWindows 30
   Tipo_Operacion = "CI"
   Screen.MousePointer = vbHourglass
   Lbl_Dia(0).Caption = DiaSem(TxtFecIni.Text, Lbl_Dia(0))
   Screen.MousePointer = vbDefault
   nDolarOb = funcBuscaTipcambio(994, sFecPro)
   nUf = funcBuscaTipcambio(998, sFecPro)

End Sub

Private Sub Form_Deactivate()

   Screen.MousePointer = vbDefault

   Exit Sub

End Sub

Private Sub Form_Load()
   Dim nSw%, I%
   Dim gsDate           As Date
   q = 0
   On Error GoTo BacErrHnd

   Me.Left = 0
   Me.Top = 0
   Me.Height = 6000
   
   Tipo_Operacion = "CI"
   
   Screen.MousePointer = vbHourglass
   FormHandle = Me.hWnd

   Call CI_IniciarTx(FormHandle, Data1)

   sFecPro = Format$(gsBac_Fecp, "dd/mm/yyyy")
   iFlagKeyDown = True

   ' VB+ Inicio de Cambio
   ' ==============================================
   If funcFindMonVal(CmbMon, CmbBase, "CI") Then
      If CmbMon.ListCount > 1 Then
         CmbMon.ListIndex = 1

      End If

   End If
   ' ==============================================
   ' Vb- Fin del cambio de moneda y base

   TxtFecIni.Text = Format$(gsBac_Fecp, "dd/mm/yyyy")
   Lbl_Dia(0).Caption = DiaSem(TxtFecIni.Text, Lbl_Dia(0))
   TxtFecVct.Text = gsBac_Fecx
   nSw = 0
   nCont = 1

   Do While nSw = 0
      If EsFeriado(CDate(TxtFecVct.Text), "00001") Then
         nCont = nCont + 1
         TxtFecVct.Text = Format$(DateAdd("d", 1, TxtFecVct.Text), "dd/mm/yyyy")
      Else
         nSw = 1
      End If
   Loop

   txtplazo.Text = DateDiff("D", TxtFecIni.Text, TxtFecVct.Text)

   Screen.MousePointer = vbDefault

   For I% = 0 To CmbMon.ListCount - 1
      If Mid(CmbMon.List(I%), 1, 3) = "CLP" Then
         CmbMon.ListIndex = I%
         Exit For

      End If

   Next I%

   Call Func_Limpiar_Pantalla

   Data1.Refresh

   Call Genera_Grilla
   Call Limpia_grilla
   
   Call Proc_Consulta_Porcentaje_Transacciones("CI")
   Call OptDvp_Click(1)

    Call LeeModoControlPT   'PRD-3860, modo silencioso

   On Error GoTo 0

   Exit Sub

BacErrHnd:

   On Error GoTo 0
   Resume

End Sub

Private Sub Form_Resize()

   Dim x!, Y!, J%

   On Error GoTo BacErrHnd

   Dim lScaleWidth&, lScaleHeight&, lPosIni&

   ' Cuando la ventana es minimizada, se ignora la rutina.-
   If Me.WindowState = 1 Then
      ' Pinta borde del icono.-
      x = Me.Width
      Y = Me.Height

      For J% = 1 To 15
         Line (0, 0)-(x, 0), QBColor(Int(Rnd * 15))
         Line (x, 0)-(x, Y), QBColor(Int(Rnd * 15))
         Line (x, Y)-(0, Y), QBColor(Int(Rnd * 15))
         Line (0, Y)-(0, 0), QBColor(Int(Rnd * 15))
         DoEvents

      Next

      On Error GoTo 0
      Exit Sub

   End If

   ' Escalas de medida de la ventana.-
   lScaleWidth& = Me.ScaleWidth
   lScaleHeight& = Me.ScaleHeight

   ' Resize la ventana customizado.-
   If Me.WindowState <> 1 And Me.Width > 400 And Me.Height > 3000 Then
      Table1.Width = Me.Width - 200
      Table1.Height = Me.Height - 2900

   End If

   On Error GoTo 0
   Exit Sub

BacErrHnd:

   On Error GoTo 0
   Resume

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call CI_BorrarTx(Me.hWnd)

End Sub

Private Sub Table1_ColumnChange()

   iFlagKeyDown = True

End Sub

Private Sub Table1_EnterEdit()

   iFlagKeyDown = False

   If Table1.Col = com_NOMINAL Then
      bufNominal = Val(Table1.TextMatrix(Table1.Row, com_NOMINAL))
   End If

End Sub

Private Sub OptDvp_Click(Index As Integer)
   Select Case Index
      Case 1
         glBacCpDvpCi = No
         Combo1.Clear
         Combo1.AddItem "CLIENTE"
         Combo1.AddItem "PROPIA"
         Combo1.AddItem "DCV"
         Combo1.ListIndex = 1
      Case 0
         glBacCpDvpCi = Si
         Combo1.Clear
         Combo1.AddItem "DCV"
         Combo1.ListIndex = 0
   End Select
   Cuadrodvp.Enabled = False
   Table1.Enabled = True
End Sub

Private Sub Table1_DblClick()

   If Table1.Col = 6 Then
      BacControlWindows 100
      Combo1.Visible = True
      Combo1.SetFocus
      BacControlWindows 100
      Exit Sub

   End If

End Sub

Private Sub Table1_GotFocus()

   Table1.CellBackColor = &H808000
   Text1.Font.bold = True

End Sub

Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)

   Dim aux&

   On Error GoTo KeyDownError

   If KeyCode = 13 Then
      Table1_KeyPress (13)
      Exit Sub

   End If

   If iFlagKeyDown = False Then
      Exit Sub

   End If

   If KeyCode = vbKeyInsert Then
      If Trim(Table1.TextMatrix(Table1.RowSel, 6)) = "DCV" And Trim(Table1.TextMatrix(Table1.RowSel, 7)) = "" Then
         MsgBox "¡ Al seleccionar custodia DCV, debe ingresar una clave. !", vbExclamation, TITSISTEMA
         If Table1.Enabled = True Then: Table1.SetFocus
         Exit Sub
      End If
      If glBacCpDvpCi = Si Then
         If Table1.Rows > 10 Then
            MsgBox "¡ No es posible agregar más de 10 documentos al utilizar pago DVP Combanc. !", vbExclamation, TITSISTEMA
            If Table1.Enabled = True Then: Table1.SetFocus
            Exit Sub
         End If
      End If
      
      aux& = Table1.Row
      If Table1.Enabled = True Then: Table1.SetFocus 'probando1
      BacControlWindows 60
      Table1.Row = Table1.Rows - 1
      Bac_SendKey vbKeyHome
      
      'ACAMODIF
      If Trim$(Table1.TextMatrix(Table1.Row, 0)) = "" Then
         MsgBox "Ingrese serie antes de insertar otra Fila", vbInformation
         If Table1.Enabled = True Then: Table1.SetFocus
         Exit Sub
      End If
      'FINACA
      
      ' VB+- 09/06/2000  se valida que no se pueda agregar otro registro si no tiene definido custodia
      If Trim$(Table1.TextMatrix(Table1.Row, com_CUST)) = "" Then
         MsgBox "Debe definir antes custodia para instrumento ", vbExclamation, gsBac_Version
         If Table1.Enabled = True Then: Table1.SetFocus
         Exit Sub
      Else
         If Trim$(Table1.TextMatrix(Table1.Row, com_SERIE)) <> "" And CDbl(Table1.TextMatrix(Table1.Row, com_TIR)) <> 0 And CDbl(Table1.TextMatrix(Table1.Row, com_VPS)) <> 0 Then
            BacControlWindows 60
            Call CI_Agregar(hWnd, Data1)
            Table1.Col = com_SERIE
         Else
            Table1.Row = aux&
         End If
      End If

      Table1.Rows = Table1.Rows + 1
      Table1.Row = Table1.Rows - 1
      Call Limpia_grilla

   ElseIf KeyCode = vbKeyUp Then
      If Trim$(Table1.TextMatrix(Table1.Row, com_SERIE)) = "" Then
         BacControlWindows 60

         If Data1.Recordset.RecordCount > 1 Then
            Call CI_Eliminar(Data1)
         End If

      End If

   ElseIf KeyCode = vbKeyDelete Then
      If Not Data1.Recordset.RecordCount = 1 Then
         Call Colocardata1
      Else
         Data1.Recordset.MoveFirst
      End If

      Call CI_Eliminar(Data1)
      Data1.Refresh

      If Not Table1.Rows = 2 Then
         Table1.RemoveItem Table1.Row

      Else
         Table1.TextMatrix(1, 0) = ""
         Table1.TextMatrix(1, 1) = ""
         Limpia_grilla
'         OptDolar.Enabled = True
'         OptPesos.Enabled = True

      End If

      Table1.Refresh

      TxtTotal.Text = BacCtrlTransMonto(CI_SumarTotal(FormHandle))
'      If OptDolar Then
'          TxtTotal.Text = Calcula_Monto_Mx(CDbl(BacCtrlTransMonto(CI_SumarTotal(FormHandle))), Data1.Recordset!TM_monemi, 999)
'      Else
'          TxtTotal.Text = BacCtrlTransMonto(CI_SumarTotal(FormHandle))
'      End If

      Call CalcularValorFinal

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
   MsgBox error(err), vbExclamation, gsBac_Version
   If Table1.Enabled = True Then: Table1.SetFocus
   Data1.Refresh

   Exit Sub

End Sub

Private Sub Table1_KeyPress(KeyAscii As Integer)

   If Table1.Col = 0 Then
      BacControlWindows 100
      Text1.Visible = True

      If KeyAscii <> 13 Then
         Text1.Text = UCase(Chr(KeyAscii))

      Else
         Text1.Text = Table1.TextMatrix(Table1.Row, Table1.Col)

      End If
      
      Text1.MaxLength = 12
      Text1.SetFocus
      BacControlWindows 100

      Exit Sub

   End If

   If Table1.Col = 7 And Trim(Table1.TextMatrix(Table1.Row, 6)) = "DCV" Then
      BacControlWindows 100
      Text1.Visible = True

      If KeyAscii <> 13 Then
         Text1.Text = UCase(Chr(KeyAscii))

      Else
         Text1.Text = Table1.TextMatrix(Table1.Row, Table1.Col)

      End If

      Text1.MaxLength = 9
      Text1.SetFocus
      BacControlWindows 100

      Exit Sub

   End If

   If Table1.Col = 6 Then
      If glBacCpDvpCi = No Then
         If KeyAscii = 80 Or KeyAscii = 112 Then
            Combo1.Text = "PROPIA"
         ElseIf KeyAscii = 68 Or KeyAscii = 100 Then
            Combo1.Text = "DCV"
         ElseIf KeyAscii = 67 Or KeyAscii = 99 Then
            Combo1.Text = "CLIENTE"
         End If
      Else
         Combo1.Text = "DCV"
      End If
      
      BacControlWindows 100
      If UCase(Chr(KeyAscii)) = "C" Or UCase(Chr(KeyAscii)) = "D" Or UCase(Chr(KeyAscii)) = "P" Or KeyAscii = vbKeyReturn Then
         Table1.Col = 6
         Call PROC_POSI_TEXTO(Table1, Combo1)
         Combo1.Visible = True
         Combo1.SetFocus
      End If
      
      BacControlWindows 100

      Exit Sub

   End If

   Call FUNC_Decimales_de_Moneda(Table1.TextMatrix(Table1.Row, 1))

   If Table1.Col < 6 And Table1.Col <> 1 And Table1.Col <> 0 Then
      BacControlWindows 100
      TEXT2.Text = BacCtrlTransMonto(CDbl(Table1.TextMatrix(Table1.Row, Table1.Col)))
      If Table1.Col = 5 Then
            TEXT2.CantidadDecimales = gsMONEDA_Decimales
      Else
            TEXT2.CantidadDecimales = 4
      End If

      TEXT2.Visible = True


      If KeyAscii > 47 And KeyAscii < 58 Then
         TEXT2.Text = Chr(KeyAscii)

      End If
      
      TEXT2.SetFocus
      BacControlWindows 100

   End If

   BacToUCase KeyAscii

   If Table1.Col > com_SERIE Then
      If Len(Trim(Table1.TextMatrix(Table1.Row, com_SERIE))) = 0 Then
         KeyAscii = 0

      End If

   End If

   If Table1.Col = com_CDCV Then
      If IsNull(Table1.TextMatrix(Table1.Row, com_CUST)) Or Trim$(Table1.TextMatrix(Table1.Row, com_CUST)) <> "DCV" Then
         KeyAscii = 0

      End If

   End If

   If Table1.Col = com_CUST Then
      If Not Data1.Recordset.RecordCount = 1 Then
         Call Colocardata1

      Else
         Data1.Recordset.MoveFirst

      End If

      Data1.Recordset.Edit

      Select Case UCase$(Chr(KeyAscii))
      Case "C"
         Data1.Recordset("tm_custodia") = "CLIENTE"
         Data1.Recordset("tm_clave_dcv") = " "
         KeyAscii = vbKeyReturn

      Case "D"
         If Not IsNull(Data1.Recordset("tm_custodia")) Then
            If Trim$(Data1.Recordset("tm_custodia")) <> "DCV" Then
               Data1.Recordset("tm_custodia") = "DCV"
               Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
               KeyAscii = vbKeyReturn

            Else
               KeyAscii = 0

            End If

         Else
            Data1.Recordset("tm_custodia") = "DCV"
            Data1.Recordset("tm_clave_dcv") = FUNC_GENERA_CLAVE_DCV
            KeyAscii = vbKeyReturn

         End If

      Case "P"
         Data1.Recordset("tm_custodia") = "PROPIA"
         Data1.Recordset("tm_clave_dcv") = " "
         KeyAscii = vbKeyReturn

      Case Else
         KeyAscii = 0

      End Select

      Data1.Recordset.Update

   End If

   If Not Data1.Recordset.RecordCount = 1 Then
      Call Colocardata1
   Else
      Data1.Recordset.MoveFirst
   End If

   If Data1.Recordset("tm_mdse") = "N" And Table1.Col = com_VPAR Then
      KeyAscii = 0
      Exit Sub
   End If

   If KeyAscii = 27 Then iFlagKeyDown = True

   Select Case Table1.Col
   Case com_NOMINAL, com_VPS
      If KeyAscii <> 27 Then
         If Not iFlagKeyDown Then
            KeyAscii = BacPunto(Table1, KeyAscii, 12, 4)
         End If

         KeyAscii = BACValIngNumGrid(KeyAscii)

      End If

   Case com_TIR, com_VPAR
      If KeyAscii <> 27 Then
         If Not iFlagKeyDown Then
            KeyAscii = BacPunto(Table1, KeyAscii, 3, 4)

         End If

         KeyAscii = BACValIngNumGrid(KeyAscii)

      End If

   End Select

End Sub

Private Sub Table1_LeaveCell()

   Table1.CellBackColor = &HC0C0C0

End Sub

Private Sub Table1_Scroll()

   Text1_LostFocus
   TEXT2_LostFocus
   Combo1_LostFocus

End Sub

Private Sub Table1_SelChange()

   Table1.CellBackColor = &H808000: Text1.Font.bold = True

End Sub

Private Sub Text1_GotFocus()

   Call PROC_POSI_TEXTO(Table1, Text1)
   Text1.SelStart = Len(Text1)

End Sub

Private Sub Text1_KeyDown(KeyCode As Integer, Shift As Integer)

   Dim Columna%
   Dim LeeEmi$
   Dim Nominal#
   Dim CorteMin#
   Dim iOK%
   Dim Value            As String
   Dim Col              As Integer
   Dim Cota_SUP         As Double
   Dim Cota_INF         As Double
   Dim Porcentaje       As Double
   Dim nRedon           As Integer
   
   On Error GoTo ExitEditError

   If KeyCode = 27 Then
      Text1_LostFocus
   End If

   If KeyCode = 13 Then
      Antes_Flag = True
      TipO = "CI"
      If Not Data1.Recordset.RecordCount = 1 Then
         Call Colocardata1
      Else
         Data1.Recordset.MoveFirst
      End If
      
      If CmbMon.ItemData(CmbMon.ListIndex) = 13 Then
         nRedon = 2
      ElseIf CmbMon.ItemData(CmbMon.ListIndex) = 999 Then
         nRedon = 0
      Else
         nRedon = 4
      End If

      If Table1.Col = 7 Then
         Data1.Recordset.Edit
         Data1.Recordset!tm_clave_dcv = Text1.Text
         Data1.Recordset.Update

      End If

      Col% = Table1.Col

      If Table1.Col = 7 Or Table1.Col = 0 Then
         Value = Text1.Text
      Else
         Value = CDec(TEXT2.Text)
      End If

      If (Col% > com_UM And Col < com_CUST) And (Col > com_CDCV And Col <= com_UTIL) Then
         If IsNumeric(Value) = False Then
            Exit Sub

         End If

      End If

      If Col% = com_SERIE Then
         iOK = CI_ChkSerie(Value, Data1)

         If iOK = False Then
            If Table1.Enabled = True Then: Table1.SetFocus
            Exit Sub

            iFlagKeyDown = False
         
'         ElseIf OptPesos = True And Data1.Recordset("tm_monemi") = 13 Then
'            MsgBox "No puede ingesar papeles en Dolares, Debe activar el Swich Dolar...", vbCritical, gsBac_Version
'            If Table1.Enabled = True Then: Table1.SetFocus
'            Exit Sub
'
'         ElseIf OptDolar = True And Data1.Recordset("tm_monemi") <> 13 Then
'            MsgBox "No puede ingesar papeles en Pesos, Debe activar el Swich Pesos...", vbCritical, gsBac_Version
'            If Table1.Enabled = True Then: Table1.SetFocus
'            Exit Sub

         Else
            Data1.Recordset.Edit
            Data1.Recordset!TM_INSTSER = Text1.Text
            'Data1.Recordset!tm_carterasuper = IIf(me.cmb.ListCount = 0, 0, Trim(Right(cboCarteraSuper.Text, 10)))
            Data1.Recordset.Update
            'ARM - desactiva llamada a funcion que limpia grilla
              ' Limpia_grilla
            'ARM
'            OptDolar.Enabled = False
'            OptPesos.Enabled = False
         End If

      ElseIf Col% = com_NOMINAL Then
         If CDbl(Value) < 0 Or Len(Value) > 19 Then
            MsgBox "Valor nominal ingresado NO es valido.", vbExclamation, gsBac_Version
            Value = 0
            Exit Sub

         End If

         CorteMin# = Data1.Recordset("tm_cortemin")

         If Not IsNumeric(Value) Then Value = 0
            Nominal# = CDbl(Value)

            If CO_ChkCortes(Nominal#, CorteMin#) = False Then
               Value = Nominal#
               TEXT2.Text = CorteMin#

            End If

         ElseIf Col% = com_VPS Then
            If CDbl(Value) < 0 Or Len(Value) > 16 Then
               MsgBox "Valor presente ingresado NO es valido.", vbExclamation, gsBac_Version
               Value = 0
               Exit Sub

            End If

         End If

         If Table1.Col = 0 Or Table1.Col = 7 Then
            Table1.TextMatrix(Table1.Row, Table1.Col) = Text1.Text

         Else
            Antes = Table1.TextMatrix(Table1.Row, Table1.Col)
            Table1.TextMatrix(Table1.Row, Table1.Col) = TEXT2.Text

         End If

         If Me.Enabled And Not iFlagKeyDown Then
            Me.SetFocus
            Bac_SendKey 27

         End If

         Columna = Table1.Col

         Data1.Recordset.Edit
         
         If Columna = com_SERIE Then
            LeeEmi$ = Data1.Recordset("tm_leeemi")
         
            If InStr("S", LeeEmi$) Then
               Call Func_Emision
         
            End If
         
            Table1.Col = com_NOMINAL
            TxtTotal.Text = BacCtrlTransMonto(CI_SumarTotal(FormHandle))
'            If OptDolar Then
'                TxtTotal.Text = Calcula_Monto_Mx(CDbl(BacCtrlTransMonto(CI_SumarTotal(FormHandle))), Data1.Recordset!TM_monemi, 999)
'            Else
'                TxtTotal.Text = BacCtrlTransMonto(CI_SumarTotal(FormHandle))
'            End If
            
            txtIniPMP.Text = BacCtrlTransMonto(IIf(dTipcam# = 0, 0, Round(TxtTotal.Text / dTipcam#, nRedon)))
         ElseIf Columna = com_NOMINAL Then
            Data1.Recordset!tm_nominal = TEXT2.Text
            Data1.Recordset.Update
             
            Table1.Col = com_NOMINAL
            TxtTotal.Text = BacCtrlTransMonto(CI_SumarTotal(FormHandle))
'            If OptDolar Then
'                TxtTotal.Text = Calcula_Monto_Mx(CDbl(BacCtrlTransMonto(CI_SumarTotal(FormHandle))), Data1.Recordset!TM_monemi, 999)
'            Else
'                TxtTotal.Text = BacCtrlTransMonto(CI_SumarTotal(FormHandle))
'            End If
            txtIniPMP.Text = BacCtrlTransMonto(IIf(dTipcam# = 0, 0, Round(TxtTotal.Text / dTipcam#, nRedon)))
            
            If CDbl(Table1.TextMatrix(Table1.Row, com_TIR)) <> 0 Then
               Call CPCI_Valorizar(2, Data1, gsBac_Fecp)
         
            ElseIf CDbl(Table1.TextMatrix(Table1.Row, com_VPAR)) <> 0 Then
               Call CPCI_Valorizar(1, Data1, gsBac_Fecp)
         
            ElseIf CDbl(Table1.TextMatrix(Table1.Row, com_VPS)) <> 0 Then
               Call CPCI_Valorizar(3, Data1, gsBac_Fecp)
         
            End If
         
            If BacFormatoSQL(bufNominal) <> BacFormatoSQL(Table1.TextMatrix(Table1.Row, com_NOMINAL)) Then
               Call CO_EliminarCortesMDB(FormHandle, Data1.Recordset("tm_correlativo"))
         
            End If

      ElseIf Columna = com_TIR Then
       ' se quita esta funcion ya que ahora es por Control Financiero
       ' If Not Validar_Tasa("CI", Data1.Recordset("tm_monemi"), CDbl(Text2.Text)) Then
       '        Table1.TextMatrix(Table1.Row, Table1.Col) = 0
       '        If Table1.Enabled = True Then: Table1.SetFocus
       '       Exit Sub
       '  End If
      
         Data1.Recordset!TM_TIR = TEXT2.Text
         Data1.Recordset.Update

         Call CPCI_Valorizar(2, Data1, gsBac_Fecp)

      ElseIf Columna = com_VPAR Then
         Data1.Recordset!TM_Pvp = TEXT2.Text
         Data1.Recordset.Update

         Call CPCI_Valorizar(1, Data1, gsBac_Fecp)
            If Not Antes_Flag Then
                Table1.TextMatrix(Table1.Row, Table1.Col) = Antes
                Data1.Recordset.Edit
                Data1.Recordset!TM_Pvp = Antes
                Data1.Recordset.Update
            End If

      ElseIf Columna = com_VPS Then
         Data1.Recordset!TM_MT = TEXT2.Text
         Data1.Recordset.Update

         Call CPCI_Valorizar(3, Data1, gsBac_Fecp)
         If Not Antes_Flag Then
                Table1.TextMatrix(Table1.Row, Table1.Col) = Antes
                Data1.Recordset.Edit
                Data1.Recordset!TM_MT = Antes
                Data1.Recordset.Update
         End If


      End If

      BacControlWindows 20

      If Columna >= com_NOMINAL And Columna < com_CUST Then
         Call ChkMoneda(Columna%)
         BacControlWindows 12
         
         TxtTotal.Text = BacCtrlTransMonto(CI_SumarTotal(FormHandle))
'         If OptDolar Then
'               TxtTotal.Text = Calcula_Monto_Mx(CDbl(BacCtrlTransMonto(CI_SumarTotal(FormHandle))), Data1.Recordset!TM_monemi, 999)
'         Else
'             TxtTotal.Text = BacCtrlTransMonto(CI_SumarTotal(FormHandle))
'         End If

         txtIniPMP.Text = BacCtrlTransMonto(IIf(dTipcam# = 0, 0, Round(TxtTotal.Text / dTipcam#, nRedon)))

         Call CalcularValorFinal
      End If

      iFlagKeyDown = True

      If Columna = com_NOMINAL Then
         Table1.Col = com_TIR
      ElseIf Columna = com_TIR Or Columna = com_VPAR Or Columna = com_VPS Then
         Table1.Col = com_CUST
      ElseIf Columna = 0 Then
         Table1.Col = 2
      End If

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

      Text1.Text = ""
      Text1.Visible = False
      TEXT2.Text = 0
      TEXT2.Visible = False

      If Table1.Col <> 2 Then
         Llena_Grilla
      Else
         Table1.TextMatrix(Table1.Row, 1) = Data1.Recordset!TM_NEMMON
         Table1.TextMatrix(Table1.Row, 12) = Data1.Recordset!tm_rutemi
         'ARM - desactiva llamada a funcion que limpia grilla
            'Limpia_grilla
         'ARM -
         If Columna = 0 Then
            Table1.Col = 2
         End If
      End If

      If Table1.Enabled = True Then: Table1.SetFocus
   End If

   On Error GoTo 0
   Exit Sub
ExitEditError:
   On Error GoTo 0
   iFlagKeyDown = True
    Table1.Row = Table1.Rows - 1
    Table1.TextMatrix(Table1.Row, 3) = Format(Monto, "###,###,###,##0.0000")
    Text1.Visible = False
   Exit Sub
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)

   Call BacToUCase(KeyAscii)

End Sub

Private Sub Text1_LostFocus()

   Text1.Text = ""
   Text1.Visible = False

End Sub

Private Sub TEXT2_GotFocus()

   Call PROC_POSI_TEXTO(Table1, TEXT2)
   
   If Table1.Col = 5 Then
        TEXT2.SelStart = Len(TEXT2.Text)
   Else
        TEXT2.SelStart = Len(TEXT2.Text) - 5
   End If

End Sub

Private Sub Text2_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = 27 Then
      TEXT2.Text = ""
      TEXT2.Visible = False
   End If

   If KeyCode = 13 Then
      Call Text1_KeyDown(13, 1)
   End If

End Sub

Private Sub TEXT2_LostFocus()

   TEXT2.Text = 0
   TEXT2.Visible = False

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   
   '--**
    'Cbg. Maxima de Convencional
    MontoCI = txtIniPMP.text
    TasaCI = txtTipoCambio.text  'TxtTasa.text
    PlazoCI = TxtPlazo.text
    MonedaCI = CmbMon.text
   '--**
   
   
   If u = 1 Then
      MsgBox "Revise Fecha de Vencimiento", vbCritical
      Exit Sub
   End If

   If k = 1 Then
      MsgBox "Revise Tasa de Pacto", vbCritical
      Exit Sub
   End If
   
   Dim Nominal#

   On Error GoTo ErrButton

   Select Case UCase(Button.Description)
   Case "GRABAR"
        Call Proc_Grabar

   Case "EMISION"
      Call Func_Emision

   Case "CORTES"
      If CDbl(CDbl(Table1.TextMatrix(Table1.Row, com_NOMINAL))) = 0 Then
         On Error GoTo 0
         Exit Sub

      End If

      Nominal# = CDbl(Table1.TextMatrix(Table1.Row, com_NOMINAL))

      If Not Table1.Rows = 1 Then
         Call Colocardata1

      Else
         Data1.Recordset.MoveFirst

      End If

      Set BacFrmIRF = Me

      BacControlWindows 30
      BacIrfCo.Show 1
      BacControlWindows 30

      If Nominal# <> CDbl(Table1.TextMatrix(Table1.Row, com_NOMINAL)) Then
      Else
         Data1.Recordset.Edit
         Data1.Recordset.Update

      End If

      If Table1.Enabled = True Then: Table1.SetFocus

   Case "LIMPIAR"
      Call Func_Limpiar_Pantalla
      Call Limpia_grilla

      If Table1.Rows > 2 Then
         Table1.RemoveItem Table1.Row
      Else
         Table1.TextMatrix(1, 0) = ""
         Table1.TextMatrix(1, 1) = ""
      End If
         Text1.Visible = False
         TEXT2.Visible = False

         Cuadrodvp.Enabled = True
         Table1.Enabled = False
         OptDvp.Item(0).Value = False
         OptDvp.Item(1).Value = False
          'ARM
          Call OptDvp_Click(1)

   Case "SALIR"
      On Error GoTo 0
      Unload Me
      Exit Sub

   End Select

   On Error GoTo 0
   Exit Sub

ErrButton:
   Select Case UCase(Button.Description)
   Case "LIMPIAR"
      MsgBox "No se pudo realizar limpieza de pantalla de compras con pacto ", vbExclamation, gsBac_Version
      Exit Sub
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

   Lbl_Dia(1).Caption = DiaSem(TxtFecVct.Text, Lbl_Dia(1))
   
   If EsFeriado(TxtFecVct.Text, "00001") Then

   End If
   
   txtplazo.Text = DateDiff("D", TxtFecIni.Text, TxtFecVct.Text)
   
End Sub

Private Sub TxtFecVct_Click()

 Lbl_Dia(1).Caption = DiaSem(TxtFecVct.Text, Lbl_Dia(1))
   
   If Lbl_Dia(1).Caption = "Sabado" Or Lbl_Dia(1).Caption = "Domingo" Then
      MsgBox "Dia " & Lbl_Dia(1).Caption & " No es un dia Habil", vbExclamation, "BacTrader Full"
      Toolbar1.Buttons(1).Enabled = False
      Exit Sub
   Else
      Toolbar1.Buttons(1).Enabled = False
   End If
End Sub

Private Sub TxtFecVct_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey vbKeyTab

   End If

End Sub

Private Sub TxtFecVct_LostFocus()
u = 0
   If Format(TxtFecVct.Text, "yyyymmdd") < Format(TxtFecIni.Text, "yyyymmdd") Then
      MsgBox "La Fecha de Vencimiento debe ser Mayor a Fecha de Inicio.", 16
      Screen.MousePointer = 0
      TxtFecVct.Text = Format$(DateAdd("d", txtplazo.Text, TxtFecIni.Text), "dd/mm/yyyy")
      u = 1
   End If

   txtplazo.Tag = txtplazo.Text
   txtplazo.Text = DateDiff("d", TxtFecIni.Text, TxtFecVct.Text)

   'Validar que Fecha de Vcto. NO sea Feriado
   If EsFeriado(CDate(TxtFecVct.Text), "00001") Then
      MsgBox "La Fecha de Vcto. ingresada retorna un día No Hábil; Por favor reingrese", vbCritical, "Feriados"
      txtplazo.Text = txtplazo.Tag
      TxtFecVct.Text = Format$(DateAdd("d", txtplazo.Text, TxtFecIni.Text), "dd/mm/yyyy")
      u = 1
   End If

   If txtplazo.Text = 0 Then
      MsgBox "Fecha de Vcto. Ingresada igual a la de Proceso; Por favor reingrese", vbCritical, "Días del Pacto"
      txtplazo.SetFocus
      txtplazo.Text = txtplazo.Tag
      TxtFecVct.Text = Format$(DateAdd("d", txtplazo.Text, TxtFecIni.Text), "dd/mm/yyyy")
      u = 1
   End If

   Call CalcularValorFinal
   If u = 1 Then
    TxtFecVct.SetFocus
   End If
End Sub

Private Sub txtIniPMP_Change()
   txtIniPMS.Text = BacCtrlTransMonto(TxtTotal.Text)
End Sub

Private Sub TxtPlazo_GotFocus()

   txtplazo.Tag = txtplazo.Text

End Sub

Private Sub TxtPlazo_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      Bac_SendKey vbKeyTab

   End If

End Sub

Private Sub TxtPlazo_LostFocus()

   If txtplazo.Text <> txtplazo.Tag Then
      TxtFecVct.Text = Format$(DateAdd("d", txtplazo.Text, TxtFecIni.Text), "dd/mm/yyyy")

      If EsFeriado(CDate(TxtFecVct.Text), "00001") Then
         MsgBox "La Fecha de Vcto. ingresada retorna un día No Hábil; Por favor reingrese", vbCritical, "Feriados"
         txtplazo.Text = txtplazo.Tag
         txtplazo.SetFocus
         TxtFecVct.Text = Format$(DateAdd("d", txtplazo.Text, TxtFecIni.Text), "dd/mm/yyyy")
         Exit Sub

      End If

      If txtplazo.Text = 0 Then
         MsgBox "Fecha de Vcto. ingresada igual a la de proceso; Por favor reingrese", vbExclamation, gsBac_Version
         txtplazo.Text = txtplazo.Tag
         txtplazo.SetFocus
         TxtFecVct.Text = Format$(DateAdd("d", txtplazo.Text, TxtFecIni.Text), "dd/mm/yyyy")
         Exit Sub

      End If

      Call CalcularValorFinal

   End If

End Sub

Private Sub TxtTasa_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey vbKeyTab
   End If

End Sub

Private Sub TxtTasa_LostFocus()
   
   ' If Txt_TasaTran.Text = 0 And TxtTasa.Text <> 0 Then
          Txt_TasaTran.Text = TxtTasa.Text
   ' End If
   
    Call CalcularValorFinal
    'Aqui aplicar el control de precios y tasas
    
    'Como aun no conozco al cliente...
    Ctrlpt_RutCliente = "0"
    Ctrlpt_CodCliente = "0"

    If CmbMon.ListIndex <> -1 And txtplazo.Text > 0 And TxtTasa.Text > 0 Then
        If ControlPreciosTasas("CI", CmbMon.ItemData(CmbMon.ListIndex), txtplazo.Text, TxtTasa.Text) = "S" Then
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
    
    If txtTipoCambio.Enabled = True Then
    
        dTipcam# = txtTipoCambio.Text
        
        Call TxtTotal_Change
        Call CalcularValorFinal
        
        Bac_SendKey vbKeyTab
    End If
    
End Sub

Private Sub TxtTotal_Change()
   Dim nRedon As Integer
   
   TxtTotal.Text = Replace(TxtTotal.Text, Chr(13) + Chr(10), "")
   
   If Val(TxtTotal.Text) = 0 Then Exit Sub
   
   txtIniPMS.Text = BacCtrlTransMonto(TxtTotal.Text)
   
   Call funcFindDatGralMoneda(CmbMon.ItemData(CmbMon.ListIndex))
   
   If SwMx = "C" And CmbMon.ItemData(CmbMon.ListIndex) <> 999 Then
        nRedon = BacDatGrMon.mndecimal
   ElseIf SwMx = "" And CmbMon.ItemData(CmbMon.ListIndex) = 999 Then
        nRedon = 0
   Else
        nRedon = BacDatGrMon.mndecimal
   End If
   
   If dTipcam = 0 Then
      txtIniPMP.Text = 0
   Else
      txtIniPMP.Text = BacCtrlTransMonto(Round(TxtTotal.Text / dTipcam#, nRedon))
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
   If KeyAscii = vbKeyReturn Then
      TxtTotal_LostFocus
   End If

   If KeyAscii = 27 Then
      TxtTotal.Text = BacCtrlTransMonto(TxtTotal.Tag)
      KeyAscii = vbKeyReturn
   End If

End Sub

Private Sub TxtTotal_LostFocus()

   Dim I                As Integer
   Dim dTotalNuevo#
   Dim dTotalActual#

   If TxtTotal.Tag <> TxtTotal.Text And TxtTotal.Tag <> "" Then
      dTotalActual# = CDbl(TxtTotal.Tag)
      dTotalNuevo# = CDbl(TxtTotal.Text)

      Call CPCI_ValorizarTotal(Data1, dTotalNuevo#, dTotalActual#)

      Call CalcularValorFinal

      Data1.Refresh

      For I = 1 To Table1.Rows - 1
         Table1.Row = I

         Call Llena_Grilla

         If Not Data1.Recordset.EOF Then
            Data1.Recordset.MoveNext

         End If

      Next I

      Table1.Refresh

   End If

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
    nFactor = CDbl(txtTipoCambio.Text) ''nDolarOb
    nRedon = 2
Else
'    nparidad = funcBuscaTipcambio(MonPacto, sFecPro)
    nFactor = CDbl(txtTipoCambio.Text) '''funcBuscaTipcambio(MonPacto, sFecPro) ''nDolarOb / nparidad
    nRedon = 4
End If

Calcula_Monto_Mx = Round(Monto_Peso / nFactor, nRedon)

End Function
