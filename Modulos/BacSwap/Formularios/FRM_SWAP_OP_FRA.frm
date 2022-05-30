VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_SWAP_OP_FRA 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ingreso de Operaciones FRA."
   ClientHeight    =   6735
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   10965
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6735
   ScaleWidth      =   10965
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   12
      Top             =   0
      Width           =   10965
      _ExtentX        =   19341
      _ExtentY        =   900
      ButtonWidth     =   2355
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      HotImageList    =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Limpiar  "
            Key             =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Flujos  "
            Key             =   "Flujos"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Grabar  "
            Key             =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Cerrar  "
            Key             =   "Cerrar"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   8565
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
               Picture         =   "FRM_SWAP_OP_FRA.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_SWAP_OP_FRA.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_SWAP_OP_FRA.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_SWAP_OP_FRA.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_SWAP_OP_FRA.frx":2FA8
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   13
      Top             =   510
      Width           =   10965
      _Version        =   65536
      _ExtentX        =   19341
      _ExtentY        =   741
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   0
      BevelInner      =   1
      Begin VB.ComboBox cmbTipo 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2190
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   45
         Width           =   2235
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Tomador / Prestamista"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   75
         TabIndex        =   14
         Top             =   90
         Width           =   1980
      End
   End
   Begin VB.Frame Frame1 
      Height          =   2445
      Left            =   -15
      TabIndex        =   15
      Top             =   735
      Width           =   10965
      Begin VB.Frame FrmTProy 
         BorderStyle     =   0  'None
         Enabled         =   0   'False
         Height          =   660
         Left            =   8640
         TabIndex        =   68
         Top             =   1755
         Width           =   2250
         Begin BACControles.TXTNumero vTasaProyectada 
            Height          =   330
            Left            =   75
            TabIndex        =   69
            Top             =   300
            Width           =   1200
            _ExtentX        =   2117
            _ExtentY        =   582
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
            Text            =   "0.00000"
            Text            =   "0.00000"
            CantidadDecimales=   "5"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Tasa Proyectada."
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Index           =   10
            Left            =   75
            TabIndex        =   70
            Top             =   105
            Width           =   1470
         End
      End
      Begin VB.ComboBox Modalidad 
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
         Left            =   5025
         Style           =   2  'Dropdown List
         TabIndex        =   66
         Top             =   2040
         Width           =   2865
      End
      Begin VB.ComboBox MonPago 
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
         Left            =   255
         Style           =   2  'Dropdown List
         TabIndex        =   63
         Top             =   2040
         Width           =   2355
      End
      Begin VB.ComboBox MedioPago 
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
         Left            =   2670
         Style           =   2  'Dropdown List
         TabIndex        =   62
         Top             =   2040
         Width           =   2370
      End
      Begin VB.ComboBox C_Indicador 
         Enabled         =   0   'False
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
         Left            =   6285
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   945
         Width           =   2355
      End
      Begin VB.ComboBox Indicador 
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
         Left            =   2670
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   945
         Width           =   2340
      End
      Begin VB.ComboBox ConteoDias 
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
         Left            =   285
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   1500
         Width           =   2340
      End
      Begin BACControles.TXTNumero Dias 
         Height          =   330
         Left            =   5040
         TabIndex        =   10
         Top             =   1500
         Width           =   1200
         _ExtentX        =   2117
         _ExtentY        =   582
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
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTFecha FechaEfectiva 
         Height          =   330
         Left            =   2670
         TabIndex        =   9
         Top             =   1500
         Width           =   1230
         _ExtentX        =   2170
         _ExtentY        =   582
         Enabled         =   -1  'True
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "02/10/2006"
      End
      Begin VB.ComboBox Moneda 
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
         Left            =   285
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   405
         Width           =   2340
      End
      Begin BACControles.TXTNumero Nocionales 
         Height          =   330
         Left            =   285
         TabIndex        =   3
         Top             =   945
         Width           =   2325
         _ExtentX        =   4101
         _ExtentY        =   582
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTFecha Madurez 
         Height          =   330
         Left            =   6285
         TabIndex        =   11
         Top             =   1500
         Width           =   1620
         _ExtentX        =   2858
         _ExtentY        =   582
         Enabled         =   -1  'True
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "02/10/2006"
      End
      Begin BACControles.TXTNumero Tasa 
         Height          =   330
         Left            =   5055
         TabIndex        =   5
         Top             =   945
         Width           =   1185
         _ExtentX        =   2090
         _ExtentY        =   582
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.00000"
         Text            =   "0.00000"
         CantidadDecimales=   "5"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero C_Tasa 
         Height          =   330
         Left            =   8670
         TabIndex        =   7
         Top             =   945
         Width           =   1650
         _ExtentX        =   2910
         _ExtentY        =   582
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
         Text            =   "0.00000"
         Text            =   "0.00000"
         CantidadDecimales=   "5"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero TXTNumero1 
         Height          =   330
         Left            =   2670
         TabIndex        =   2
         Top             =   405
         Visible         =   0   'False
         Width           =   1185
         _ExtentX        =   2090
         _ExtentY        =   582
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label lblOperador 
         Height          =   255
         Left            =   5400
         TabIndex        =   71
         Top             =   360
         Visible         =   0   'False
         Width           =   1455
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Modalidad de Pago"
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
         Index           =   0
         Left            =   5085
         TabIndex        =   67
         Top             =   1845
         Width           =   1350
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Moneda Pago"
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
         Index           =   24
         Left            =   285
         TabIndex        =   65
         Top             =   1845
         Width           =   975
      End
      Begin VB.Label I_Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Medio de Pago"
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
         Index           =   25
         Left            =   2685
         TabIndex        =   64
         Top             =   1845
         Width           =   1050
      End
      Begin VB.Label DiaFechaMadurez 
         Caption         =   "Miercoles"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   7890
         TabIndex        =   60
         Top             =   1545
         Width           =   1095
      End
      Begin VB.Label DiaFechaEfectiva 
         Caption         =   "Miercoles"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   3915
         TabIndex        =   59
         Top             =   1545
         Width           =   1095
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Valor Moneda"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   11
         Left            =   2670
         TabIndex        =   26
         Top             =   210
         Visible         =   0   'False
         Width           =   1155
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Tasa"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   9
         Left            =   8685
         TabIndex        =   25
         Top             =   750
         Width           =   405
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Indicador"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   8
         Left            =   6345
         TabIndex        =   24
         Top             =   750
         Width           =   810
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Indicador"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   7
         Left            =   2685
         TabIndex        =   23
         Top             =   750
         Width           =   810
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Conteo Dias"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   6
         Left            =   285
         TabIndex        =   22
         Top             =   1305
         Width           =   1005
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Tasa"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   5
         Left            =   5055
         TabIndex        =   21
         Top             =   750
         Width           =   405
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Días"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   4
         Left            =   5070
         TabIndex        =   20
         Top             =   1305
         Width           =   360
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Madurez"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   3
         Left            =   6300
         TabIndex        =   19
         Top             =   1305
         Width           =   1275
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Efectiva"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   2
         Left            =   2685
         TabIndex        =   18
         Top             =   1305
         Width           =   1215
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   285
         TabIndex        =   17
         Top             =   195
         Width           =   675
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Nocionales"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   285
         TabIndex        =   16
         Top             =   735
         Width           =   900
      End
   End
   Begin TabDlg.SSTab SSFlujos 
      Height          =   3555
      Left            =   0
      TabIndex        =   27
      Top             =   3195
      Width           =   10950
      _ExtentX        =   19315
      _ExtentY        =   6271
      _Version        =   393216
      Style           =   1
      Tabs            =   2
      Tab             =   1
      TabsPerRow      =   2
      TabHeight       =   520
      WordWrap        =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "DETALLE PARTE ..."
      TabPicture(0)   =   "FRM_SWAP_OP_FRA.frx":32C2
      Tab(0).ControlEnabled=   0   'False
      Tab(0).Control(0)=   "SSPanel2"
      Tab(0).ControlCount=   1
      TabCaption(1)   =   "DETALLE PARTE ...."
      TabPicture(1)   =   "FRM_SWAP_OP_FRA.frx":32DE
      Tab(1).ControlEnabled=   -1  'True
      Tab(1).Control(0)=   "SSPanel3"
      Tab(1).Control(0).Enabled=   0   'False
      Tab(1).ControlCount=   1
      Begin Threed.SSPanel SSPanel3 
         Height          =   3210
         Left            =   -15
         TabIndex        =   28
         Top             =   315
         Width           =   10875
         _Version        =   65536
         _ExtentX        =   19182
         _ExtentY        =   5662
         _StockProps     =   15
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   0
         BevelInner      =   1
         Begin VB.Frame D_FERIADOS_F 
            Caption         =   "Feriados Fecha Reset"
            Height          =   465
            Left            =   105
            TabIndex        =   55
            Top             =   60
            Width           =   2820
            Begin VB.CheckBox D_FERIADOCHK 
               Caption         =   "CHILE"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   0
               Left            =   45
               TabIndex        =   57
               Top             =   210
               Width           =   750
            End
            Begin VB.CheckBox D_FERIADOCHK 
               Caption         =   "INGLATERRA"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   2
               Left            =   1485
               TabIndex        =   56
               Top             =   210
               Width           =   1305
            End
            Begin VB.CheckBox D_FERIADOCHK 
               Caption         =   "USA"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   1
               Left            =   810
               TabIndex        =   58
               Top             =   210
               Width           =   750
            End
         End
         Begin VB.ComboBox D_Convencion 
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   4080
            Style           =   2  'Dropdown List
            TabIndex        =   33
            Top             =   165
            Width           =   2130
         End
         Begin VB.Frame D_FERIADOS_L 
            Caption         =   "Feriados Fecha Liquidación"
            Height          =   465
            Left            =   7845
            TabIndex        =   29
            Top             =   60
            Width           =   2910
            Begin VB.CheckBox D_FERIADOCHK 
               Caption         =   "INGLATERRA"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   5
               Left            =   1485
               TabIndex        =   31
               Top             =   210
               Width           =   1305
            End
            Begin VB.CheckBox D_FERIADOCHK 
               Caption         =   "CHILE"
               Enabled         =   0   'False
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   3
               Left            =   45
               TabIndex        =   30
               Top             =   210
               Value           =   1  'Checked
               Width           =   750
            End
            Begin VB.CheckBox D_FERIADOCHK 
               Caption         =   "USA"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   4
               Left            =   810
               TabIndex        =   32
               Top             =   210
               Width           =   750
            End
         End
         Begin BACControles.TXTNumero D_Numero 
            Height          =   285
            Left            =   2115
            TabIndex        =   34
            Top             =   1305
            Visible         =   0   'False
            Width           =   870
            _ExtentX        =   1535
            _ExtentY        =   503
            BackColor       =   -2147483646
            ForeColor       =   -2147483639
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Tahoma"
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
         Begin BACControles.TXTFecha D_Fecha 
            Height          =   270
            Left            =   1065
            TabIndex        =   35
            Top             =   1320
            Visible         =   0   'False
            Width           =   1035
            _ExtentX        =   1826
            _ExtentY        =   476
            BackColor       =   -2147483646
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Tahoma"
               Size            =   6.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   -2147483639
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "13/09/2006"
         End
         Begin MSFlexGridLib.MSFlexGrid D_Grid 
            Height          =   2595
            Left            =   90
            TabIndex        =   36
            Top             =   540
            Width           =   10650
            _ExtentX        =   18785
            _ExtentY        =   4577
            _Version        =   393216
            Cols            =   6
            BackColor       =   -2147483633
            BackColorFixed  =   -2147483646
            ForeColorFixed  =   -2147483639
            BackColorBkg    =   -2147483636
            GridColor       =   -2147483633
            GridColorFixed  =   -2147483642
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
            AllowUserResizing=   1
            Appearance      =   0
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
         Begin BACControles.TXTNumero D_DiasReset 
            Height          =   315
            Left            =   7350
            TabIndex        =   37
            Top             =   165
            Width           =   435
            _ExtentX        =   767
            _ExtentY        =   556
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Tahoma"
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
         Begin VB.Label Label6 
            Caption         =   "Días PreviosReset"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   6.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   390
            Left            =   6300
            TabIndex        =   39
            Top             =   135
            Width           =   1140
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Convención."
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   3015
            TabIndex        =   38
            Top             =   210
            Width           =   1020
         End
      End
      Begin Threed.SSPanel SSPanel2 
         Height          =   3210
         Left            =   -75000
         TabIndex        =   40
         Top             =   315
         Width           =   10875
         _Version        =   65536
         _ExtentX        =   19182
         _ExtentY        =   5662
         _StockProps     =   15
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   0
         BevelInner      =   1
         Begin VB.ComboBox I_Convencion 
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   4080
            Style           =   2  'Dropdown List
            TabIndex        =   45
            Top             =   165
            Width           =   2130
         End
         Begin VB.Frame I_FERIADOS_L 
            Caption         =   "Feriados Fecha Liquidación"
            Height          =   465
            Left            =   7845
            TabIndex        =   41
            Top             =   60
            Width           =   2910
            Begin VB.CheckBox I_FERIADOCHK 
               Caption         =   "INGLATERRA"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   5
               Left            =   1485
               TabIndex        =   43
               Top             =   210
               Width           =   1305
            End
            Begin VB.CheckBox I_FERIADOCHK 
               Caption         =   "CHILE"
               Enabled         =   0   'False
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   3
               Left            =   45
               TabIndex        =   42
               Top             =   210
               Value           =   1  'Checked
               Width           =   750
            End
            Begin VB.CheckBox I_FERIADOCHK 
               Caption         =   "USA"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   4
               Left            =   810
               TabIndex        =   44
               Top             =   210
               Width           =   750
            End
         End
         Begin BACControles.TXTNumero I_DiasReset 
            Height          =   315
            Left            =   7350
            TabIndex        =   46
            Top             =   165
            Width           =   435
            _ExtentX        =   767
            _ExtentY        =   556
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Tahoma"
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
         Begin BACControles.TXTNumero I_Numero 
            Height          =   285
            Left            =   2115
            TabIndex        =   47
            Top             =   1320
            Visible         =   0   'False
            Width           =   810
            _ExtentX        =   1429
            _ExtentY        =   503
            BackColor       =   -2147483646
            ForeColor       =   -2147483639
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Tahoma"
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
         Begin BACControles.TXTFecha I_Fecha 
            Height          =   255
            Left            =   1050
            TabIndex        =   48
            Top             =   1335
            Visible         =   0   'False
            Width           =   1035
            _ExtentX        =   1826
            _ExtentY        =   450
            BackColor       =   -2147483646
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Tahoma"
               Size            =   6.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   -2147483639
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "13/09/2006"
         End
         Begin MSFlexGridLib.MSFlexGrid I_Grid 
            Height          =   2595
            Left            =   90
            TabIndex        =   49
            Top             =   540
            Width           =   10650
            _ExtentX        =   18785
            _ExtentY        =   4577
            _Version        =   393216
            Cols            =   6
            BackColor       =   -2147483633
            BackColorFixed  =   -2147483646
            ForeColorFixed  =   -2147483639
            BackColorBkg    =   -2147483636
            GridColor       =   -2147483633
            GridColorFixed  =   -2147483642
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
            AllowUserResizing=   1
            Appearance      =   0
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
         Begin VB.Frame I_FERIADOS_F 
            Caption         =   "Feriados Fecha Reset"
            Height          =   465
            Left            =   105
            TabIndex        =   51
            Top             =   60
            Width           =   2820
            Begin VB.CheckBox I_FERIADOCHK 
               Caption         =   "CHILE"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   0
               Left            =   45
               TabIndex        =   54
               Top             =   210
               Width           =   750
            End
            Begin VB.CheckBox I_FERIADOCHK 
               Caption         =   "INGLATERRA"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   2
               Left            =   1485
               TabIndex        =   52
               Top             =   210
               Width           =   1305
            End
            Begin VB.CheckBox I_FERIADOCHK 
               Caption         =   "USA"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   1
               Left            =   810
               TabIndex        =   53
               Top             =   210
               Width           =   750
            End
         End
         Begin VB.Label Label3 
            Caption         =   "Días PreviosReset"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   6.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   390
            Left            =   6300
            TabIndex        =   61
            Top             =   135
            Width           =   1140
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "Convención."
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   3015
            TabIndex        =   50
            Top             =   210
            Width           =   1020
         End
      End
   End
End
Attribute VB_Name = "FRM_SWAP_OP_FRA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim MiObjSwapFra           As New Swap_OP

Const Chile = 6
Const EstadosUnidos = 225
Const Inglaterra = 510

Public CarteraFinanciera   As Variant
Public AreaResponsable     As Variant
Public LibroNegociacion    As Variant
Public CarteraNormativa    As Variant
Public SubCarteraNormativa As Variant
Public Observaciones       As Variant
Public RutCliente          As Variant
Public CodCliente          As Variant
Public iAceptar            As Boolean
Public SwapModificacion    As Long

Public cCarteraFinanciera  As Variant
Public cAreaResponsable    As Variant
Public cLibroNegociacion   As Variant
Public cCarteraNormativa   As Variant
Public cSubCartera         As Variant
Public iRut                As String
Public cNombre             As String


Private Enum Lados
   [Izquierdo] = 1
   [Derecho] = 2
End Enum

'PROD-10967
Public Fra_Threshold_LCR        As Double
Public Fra_Metodologia_LCR      As Integer
Public Fra_Cliente_LCR          As String
Public Fra_EtiquetaUsuario      As String
Public CmbTipoFra As Integer
'PROD-10967

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
   objCarga.ListIndex = 0
End Sub

Private Sub LeeMonedasPago(MiCombo As ComboBox, MiMonedas As Integer)
   On Error GoTo ErroCargaMonedasPago
   Dim Datos()

   Envia = Array()
   AddParam Envia, "PCS"
   AddParam Envia, MiMonedas
   If Not Bac_Sql_Execute("SP_RETORNA_MONEDA_PAGO", Envia) Then
      Exit Sub
   End If
   MiCombo.Clear
   Do While Bac_SQL_Fetch(Datos())
      MiCombo.AddItem UCase(Datos(2)) & Space(100) & UCase(Trim(Datos(3)))
      MiCombo.ItemData(MiCombo.NewIndex) = Val(Datos(1))
   Loop
   MiCombo.ListIndex = 0

   On Error GoTo 0
Exit Sub
ErroCargaMonedasPago:
   On Error GoTo 0
End Sub


Private Sub DiaSemanal(MiObjeto As Label, Fecha As Date)
   Select Case Weekday(Fecha)
      Case 1: MiObjeto.Caption = "Domingo"
      Case 2: MiObjeto.Caption = "Lunes"
      Case 3: MiObjeto.Caption = "Martes"
      Case 4: MiObjeto.Caption = "Miercoles"
      Case 5: MiObjeto.Caption = "Jueves"
      Case 6: MiObjeto.Caption = "Viernes"
      Case 7: MiObjeto.Caption = "Sabado"
   End Select
   If BacEsHabil(Str(Fecha)) = False Then
      MiObjeto.ForeColor = vbRed
   Else
      MiObjeto.ForeColor = vbBlack
   End If
End Sub


Private Sub DefineTitulos()
   I_Grid.Rows = 1
   D_Grid.Rows = 1

   I_Grid.Cols = 17
   D_Grid.Cols = 17

   I_Grid.TextMatrix(0, 0) = "Nro.":                           I_Grid.ColWidth(0) = 500
   I_Grid.TextMatrix(0, 1) = "VENCIMIENTO":                    I_Grid.ColWidth(1) = 1200
   I_Grid.TextMatrix(0, 2) = "AMORTIZACION":                   I_Grid.ColWidth(2) = 1500
   I_Grid.TextMatrix(0, 3) = "TASA + SPREAD":                  I_Grid.ColWidth(3) = 1500
   I_Grid.TextMatrix(0, 4) = "INTERES":                        I_Grid.ColWidth(4) = 1500
   I_Grid.TextMatrix(0, 5) = "TOTAL":                          I_Grid.ColWidth(5) = 1500
   I_Grid.TextMatrix(0, 6) = "MODALIDAD":                      I_Grid.ColWidth(6) = 0
   I_Grid.TextMatrix(0, 7) = "Documento Pago":                 I_Grid.ColWidth(7) = 0
   I_Grid.TextMatrix(0, 8) = "Saldo amortizar":                I_Grid.ColWidth(8) = 0
   I_Grid.TextMatrix(0, 9) = "Fecha Vcto. Anterior":           I_Grid.ColWidth(9) = 0
   I_Grid.TextMatrix(0, 10) = "Monto en moneda seleccionada":  I_Grid.ColWidth(10) = 0
   I_Grid.TextMatrix(0, 11) = "Monto en USD que paga./recib.": I_Grid.ColWidth(11) = 0
   I_Grid.TextMatrix(0, 12) = "Monto en $ que paga./recib.":   I_Grid.ColWidth(12) = 0
   I_Grid.TextMatrix(0, 13) = "Ubicacion del Dato ":           I_Grid.ColWidth(13) = 0
   I_Grid.TextMatrix(0, 14) = "LIQUIDACION":                   I_Grid.ColWidth(14) = 1200
   I_Grid.TextMatrix(0, 15) = "Fecha Flujo Real":              I_Grid.ColWidth(15) = 0
   I_Grid.TextMatrix(0, 16) = "Fecha Reset":                   I_Grid.ColWidth(16) = 1000

   D_Grid.TextMatrix(0, 0) = "Nro.":                           D_Grid.ColWidth(0) = 500
   D_Grid.TextMatrix(0, 1) = "VENCIMIENTO":                    D_Grid.ColWidth(1) = 1200
   D_Grid.TextMatrix(0, 2) = "AMORTIZACION":                   D_Grid.ColWidth(2) = 1500
   D_Grid.TextMatrix(0, 3) = "TASA + SPREAD":                  D_Grid.ColWidth(3) = 1500
   D_Grid.TextMatrix(0, 4) = "INTERES":                        D_Grid.ColWidth(4) = 1500
   D_Grid.TextMatrix(0, 5) = "TOTAL":                          D_Grid.ColWidth(5) = 1500
   D_Grid.TextMatrix(0, 6) = "MODALIDAD":                      D_Grid.ColWidth(6) = 0
   D_Grid.TextMatrix(0, 7) = "Documento Pago":                 D_Grid.ColWidth(7) = 0
   D_Grid.TextMatrix(0, 8) = "Saldo amortizar":                D_Grid.ColWidth(8) = 0
   D_Grid.TextMatrix(0, 9) = "Fecha Vcto. Anterior":           D_Grid.ColWidth(9) = 0
   D_Grid.TextMatrix(0, 10) = "Monto en moneda seleccionada":  D_Grid.ColWidth(10) = 0
   D_Grid.TextMatrix(0, 11) = "Monto en USD que paga./recib.": D_Grid.ColWidth(11) = 0
   D_Grid.TextMatrix(0, 12) = "Monto en $ que paga./recib.":   D_Grid.ColWidth(12) = 0
   D_Grid.TextMatrix(0, 13) = "Ubicacion del Dato ":           D_Grid.ColWidth(13) = 0
   D_Grid.TextMatrix(0, 14) = "LIQUIDACION":                   D_Grid.ColWidth(14) = 1200
   D_Grid.TextMatrix(0, 15) = "Fecha Flujo Real":              D_Grid.ColWidth(15) = 0
   D_Grid.TextMatrix(0, 16) = "Fecha Reset":                   D_Grid.ColWidth(16) = 1000
End Sub

Private Sub CalculoDiasMadurez(digito As String)
   Dim iDias      As Long
   Dim dEfectiva  As Date
   Dim dMadurez   As Date
   
   iDias = Dias.Text
   dEfectiva = FechaEfectiva.Text
   dMadurez = Madurez.Text
   
   If digito = "FechaEfectiva" Then
      Madurez.Text = DateAdd("D", iDias, dEfectiva)
   End If
   If digito = "Dias" Then
      Madurez.Text = DateAdd("D", iDias, dEfectiva)
   End If
   If digito = "Madurez" Then
      Dias.Text = Abs(DateDiff("d", dEfectiva, dMadurez))
   End If
   
End Sub

Private Function LeerUltimoIndice(MiMoneda As Integer, MiIndice As Integer) As Double
   Dim Datos()

   Envia = Array()
   AddParam Envia, CDbl(MiMoneda)
   AddParam Envia, CDbl(MiIndice)
   AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
   If Not Bac_Sql_Execute("SP_LEE_VALOR_TASA", Envia) Then
      Exit Function
   End If
   LeerUltimoIndice = 0#
   If Bac_SQL_Fetch(Datos()) Then
      LeerUltimoIndice = CDbl(Datos(1))
   End If
End Function

Private Function CargaBases(Objesto As Object, Optional iProducto As Integer) As Boolean
   Dim Datos()

   Envia = Array()
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(Val(iProducto))
   If Not Bac_Sql_Execute("SP_LEEBASES", Envia) Then
      Exit Function
   End If
   Objesto.Clear
   Do While Bac_SQL_Fetch(Datos())
      Objesto.AddItem Datos(5)
      Objesto.ItemData(Objesto.NewIndex) = Val(Datos(1))
   Loop
End Function

Private Sub LeeTasasMoneda(MiMoneda As Integer, MiObjeto As ComboBox, Optional cMonedas As Boolean)
   On Error GoTo ErroProcLectura
   Dim Datos()

   Envia = Array()
   AddParam Envia, MiMoneda
   If Not Bac_Sql_Execute("LEE_TASAS_MONEDA", Envia) Then
      GoTo ErroProcLectura
   End If
   MiObjeto.Clear
   Do While Bac_SQL_Fetch(Datos())
      If cMonedas = True Then
         If Val(Datos(3)) = 0 Then
            MiObjeto.AddItem UCase(Datos(4)) & Space(100) & UCase(Trim(Datos(3)))
            MiObjeto.ItemData(MiObjeto.NewIndex) = Val(Datos(3))
         End If
      Else
         MiObjeto.AddItem UCase(Datos(4)) & Space(100) & UCase(Trim(Datos(3)))
         MiObjeto.ItemData(MiObjeto.NewIndex) = Val(Datos(3))
      End If
   Loop

   If cMonedas = True And MiObjeto.ListCount >= 1 Then
      MiObjeto.ListIndex = 0
   End If

Exit Sub
ErroProcLectura:
   MsgBox "Error Lectura. " & vbCrLf & vbCrLf & "Se ha Producido un Error al Leer Tasas por Monedas.", vbExclamation, TITSISTEMA
End Sub

Private Sub LeerMonedasSistemas(MiObjeto As ComboBox)
   On Error GoTo ErroProcLectura
   Dim Datos()

   Envia = Array()
   AddParam Envia, "PCS"
   If Not Bac_Sql_Execute("SP_LEER_MONEDAS_SISTEMA", Envia) Then
      GoTo ErroProcLectura
   End If
   Do While Bac_SQL_Fetch(Datos())
      If Datos(1) = "13" Then
         InicioMoneda = UCase(Datos(2)) & Space(100) & UCase(Trim(Datos(3)))
      End If
      MiObjeto.AddItem UCase(Datos(2)) & Space(100) & UCase(Trim(Datos(3)))
      MiObjeto.ItemData(MiObjeto.NewIndex) = Val(Datos(1))
   Loop
Exit Sub
ErroProcLectura:
   MsgBox "Error Lectura. " & vbCrLf & vbCrLf & "Se ha Producido un Error al Leer Monedas por Sistema.", vbExclamation, TITSISTEMA
End Sub

Private Sub C_Indicador_Change()
   Toolbar1.Buttons(3).Enabled = False
End Sub

Private Sub C_Tasa_Change()
   Toolbar1.Buttons(3).Enabled = False
End Sub

Private Sub C_Tasa_LostFocus()
   Call TasaProyectada
End Sub

Private Sub cmbTipo_Click()
   Toolbar1.Buttons(3).Enabled = False
   If cmbTipo.ItemData(cmbTipo.ListIndex) = 0 Then
      SSFlujos.TabCaption(0) = "DETALLE  RECIBO VARIABLE"
      SSFlujos.TabCaption(1) = "DETALLE ENTREGO FIJO"
   Else
      SSFlujos.TabCaption(0) = "DETALLE ENTREGO VARIABLE"
      SSFlujos.TabCaption(1) = "DETALLE  RECIBO FIJA"
   End If
  'PROD-10967
  CmbTipoFra = cmbTipo.ItemData(cmbTipo.ListIndex)
  
End Sub

Private Sub ConteoDias_Change()
   Toolbar1.Buttons(3).Enabled = False
End Sub

Private Sub D_Convencion_Click()
   Toolbar1.Buttons(3).Enabled = False
   If D_Grid.Rows > 1 Then
      Call AplicarValidacionFeriados("D", D_Grid)
      Call CalculoInteresBonos("D", D_Grid)
   End If
End Sub

Private Sub D_DiasReset_Change()
   Toolbar1.Buttons(3).Enabled = False
   D_DiasReset.Text = Val(D_DiasReset.Text)
End Sub

Private Sub D_DiasReset_KeyDown(KeyCode As Integer, Shift As Integer)
   If D_Grid.Rows > 1 And KeyCode = vbKeyReturn Then
      Call AplicarValidacionFeriados("D", D_Grid)
      Call CalculoInteresBonos("D", D_Grid)
   End If
End Sub

Private Sub D_Fecha_Change()
   Toolbar1.Buttons(3).Enabled = False
End Sub

Private Sub D_FERIADOCHK_Click(Index As Integer)
   Toolbar1.Buttons(3).Enabled = False
   If D_Grid.Rows > 1 Then
      Call AplicarValidacionFeriados("D", D_Grid)
      Call CalculoInteresBonos("D", D_Grid)
   End If
End Sub

Private Sub DiaFechaEfectiva_Click()
   Toolbar1.Buttons(3).Enabled = False
End Sub

Private Sub DiaFechaMadurez_Click()
   Toolbar1.Buttons(3).Enabled = False
End Sub

Private Sub Dias_Change()
   Toolbar1.Buttons(3).Enabled = False
   If Val(Dias.Text) <= 0 Then
      If Val(Dias.Text) = 0 Then
         Dias.Text = Abs(1)
      Else
         Dias.Text = Abs(Dias.Text)
      End If
   End If
End Sub

Private Sub Dias_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call CalculoDiasMadurez("Dias")
   End If
End Sub

Private Sub Dias_LostFocus()
   Call CalculoDiasMadurez("Dias")
End Sub

Private Sub FechaEfectiva_Change()
   Call DiaSemanal(DiaFechaEfectiva, FechaEfectiva.Text)
   Toolbar1.Buttons(3).Enabled = False
End Sub

Private Sub FechaEfectiva_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call CalculoDiasMadurez("FechaEfectiva")
   End If
End Sub

Private Sub FechaEfectiva_LostFocus()
   If CDate(FechaEfectiva.Text) <= gsBAC_Fecp Then
      MsgBox "Fecha Efectiva debe ser a lo menos un día posterior a la fecha de proceso.", vbExclamation, TITSISTEMA
      FechaEfectiva.Text = DateAdd("D", 1, gsBAC_Fecp)
   End If
   Call CalculoDiasMadurez("FechaEfectiva")
   Call TasaProyectada
End Sub

Private Sub Form_Activate()
   
   Me.tag = ""
   If SwapModificacion <> 0 Then
      Me.tag = SwapModificacion
      Call CargarCampos(SwapModificacion)
   End If
End Sub


Private Sub CargaItemCombo(Objeto As ComboBox, iValor As Variant)
   Dim iContador As Integer
   
   If Not IsNumeric(iValor) Then
      For iContador = 0 To Objeto.ListCount - 1
         If Trim(Right(Objeto.List(iContador), 5)) = iValor Then
            Objeto.ListIndex = iContador
            Exit For
         End If
      Next iContador
   Else
      For iContador = 0 To Objeto.ListCount - 1
         If Objeto.ItemData(iContador) = Val(iValor) Then
            Objeto.ListIndex = iContador
            Exit For
         End If
      Next iContador
   End If
   
End Sub

Private Sub CargarCampos(Minumero As Long)
   Dim iContador     As Integer
   Dim MiFormato     As String
   Dim iMontoAmort   As Double
   Dim rdaTos()
   Dim cNemoMoneda   As String

   Envia = Array()
   AddParam Envia, CDbl(Minumero)
   If Not Bac_Sql_Execute("SP_LEE_OPERACIONES_FRA", Envia) Then
      Exit Sub
   End If
   If Not Bac_SQL_Fetch(rdaTos()) Then
      Exit Sub
   End If

   cmbTipo.Text = rdaTos(1)
   Call CargaItemCombo(Moneda, rdaTos(2))
   Nocionales.Text = CDbl(rdaTos(3))
   Call CargaItemCombo(Indicador, rdaTos(4))
   Tasa.Text = rdaTos(5)
   Call CargaItemCombo(C_Indicador, rdaTos(6))
   C_Tasa.Text = rdaTos(7)
   
   Call TasaProyectada
   
   Call CargaItemCombo(ConteoDias, rdaTos(8))
   FechaEfectiva.Text = Format(rdaTos(9), "dd/mm/yyyy")
   Dias.Text = CDbl(rdaTos(10))
   Madurez.Text = Format(rdaTos(11), "dd/mm/yyyy")
   Call CargaItemCombo(MonPago, rdaTos(12))
   Call CargaItemCombo(MedioPago, rdaTos(13))
   Modalidad.Text = rdaTos(14)
   
   cNemoMoneda = IIf(rdaTos(2) = 999, "CLP", "USD")

   D_FERIADOCHK(0).Value = rdaTos(25)
   D_FERIADOCHK(1).Value = rdaTos(26)
   D_FERIADOCHK(2).Value = rdaTos(27)
   D_FERIADOCHK(3).Value = rdaTos(28)
   D_FERIADOCHK(4).Value = rdaTos(29)
   D_FERIADOCHK(5).Value = rdaTos(30)
   D_Convencion.Text = rdaTos(31)
   D_DiasReset.Text = rdaTos(32)

   I_FERIADOCHK(0).Value = rdaTos(43)
   I_FERIADOCHK(1).Value = rdaTos(44)
   I_FERIADOCHK(2).Value = rdaTos(45)
   I_FERIADOCHK(3).Value = rdaTos(46)
   I_FERIADOCHK(4).Value = rdaTos(47)
   I_FERIADOCHK(5).Value = rdaTos(48)
   I_Convencion.Text = rdaTos(49)
   I_DiasReset.Text = rdaTos(50)


   I_Grid.Rows = 1
   I_Grid.Rows = I_Grid.Rows + 1
   I_Grid.TextMatrix(I_Grid.Rows - 1, 0) = "01"
   I_Grid.TextMatrix(I_Grid.Rows - 1, 1) = Format(rdaTos(15), "dd/mm/yyyy")
   I_Grid.TextMatrix(I_Grid.Rows - 1, 2) = Format(rdaTos(16), TipoFormato(cNemoMoneda))
   I_Grid.TextMatrix(I_Grid.Rows - 1, 3) = Format(rdaTos(17), TipoFormato("USD"))
   I_Grid.TextMatrix(I_Grid.Rows - 1, 4) = Format(rdaTos(18), TipoFormato("USD"))
   I_Grid.TextMatrix(I_Grid.Rows - 1, 5) = Format(rdaTos(19), TipoFormato("USD"))
   I_Grid.TextMatrix(I_Grid.Rows - 1, 6) = ""
   I_Grid.TextMatrix(I_Grid.Rows - 1, 7) = 0
   I_Grid.TextMatrix(I_Grid.Rows - 1, 8) = 0
   I_Grid.TextMatrix(I_Grid.Rows - 1, 9) = 0
   I_Grid.TextMatrix(I_Grid.Rows - 1, 10) = rdaTos(22)
   I_Grid.TextMatrix(I_Grid.Rows - 1, 11) = rdaTos(23)
   I_Grid.TextMatrix(I_Grid.Rows - 1, 12) = rdaTos(24)
   I_Grid.TextMatrix(I_Grid.Rows - 1, 13) = Format(rdaTos(21), "dd/mm/yyyy")
   I_Grid.TextMatrix(I_Grid.Rows - 1, 14) = Format(rdaTos(51), "dd/mm/yyyy")
   I_Grid.TextMatrix(I_Grid.Rows - 1, 15) = Format(rdaTos(51), "dd/mm/yyyy")
   I_Grid.TextMatrix(I_Grid.Rows - 1, 16) = Format(rdaTos(21), "dd/mm/yyyy")
   
   D_Grid.Rows = 1
   D_Grid.Rows = D_Grid.Rows + 1
   D_Grid.TextMatrix(D_Grid.Rows - 1, 0) = "01"
   D_Grid.TextMatrix(D_Grid.Rows - 1, 1) = Format(rdaTos(33), "dd/mm/yyyy")
   D_Grid.TextMatrix(D_Grid.Rows - 1, 2) = Format(rdaTos(34), TipoFormato(cNemoMoneda))
   D_Grid.TextMatrix(D_Grid.Rows - 1, 3) = Format(rdaTos(35), TipoFormato("USD"))
   D_Grid.TextMatrix(D_Grid.Rows - 1, 4) = Format(rdaTos(36), TipoFormato("USD"))
   D_Grid.TextMatrix(D_Grid.Rows - 1, 5) = Format(rdaTos(37), TipoFormato("USD"))
   D_Grid.TextMatrix(D_Grid.Rows - 1, 6) = ""
   D_Grid.TextMatrix(D_Grid.Rows - 1, 7) = 0
   D_Grid.TextMatrix(D_Grid.Rows - 1, 8) = 0
   D_Grid.TextMatrix(D_Grid.Rows - 1, 9) = 0
   D_Grid.TextMatrix(D_Grid.Rows - 1, 10) = rdaTos(41)
   D_Grid.TextMatrix(D_Grid.Rows - 1, 11) = rdaTos(42)
   D_Grid.TextMatrix(D_Grid.Rows - 1, 12) = rdaTos(43)
   D_Grid.TextMatrix(D_Grid.Rows - 1, 13) = Format(rdaTos(39), "dd/mm/yyyy")
   D_Grid.TextMatrix(D_Grid.Rows - 1, 14) = Format(rdaTos(52), "dd/mm/yyyy")
   D_Grid.TextMatrix(D_Grid.Rows - 1, 15) = Format(rdaTos(52), "dd/mm/yyyy")
   D_Grid.TextMatrix(D_Grid.Rows - 1, 16) = Format(rdaTos(39), "dd/mm/yyyy")
   
   iRut = rdaTos(52)
   cNombre = rdaTos(53)
   cCarteraFinanciera = rdaTos(54)
   cAreaResponsable = rdaTos(55)
   cLibroNegociacion = rdaTos(56)
   cCarteraNormativa = rdaTos(57)
   cSubCartera = rdaTos(58)
   
   Toolbar1.Buttons(3).Enabled = True
   
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      SendKeys "{TAB}"
   End If
End Sub


Private Sub Form_Load()
   Icon = BACSwap.Icon
   Me.Top = 0: Me.Left = 0

   Toolbar1.Buttons(3).Enabled = False

   Call DefineTitulos
   Call LeerMonedasSistemas(Moneda)
   Call CargaBases(ConteoDias)

   Dias.Text = 1#
   I_DiasReset.Text = 2#
   D_DiasReset.Text = 2#

   FechaEfectiva.Text = DateAdd("D", 1, gsBAC_Fecp)
   Madurez.Text = DateAdd("d", Dias.Text, FechaEfectiva.Text)

   Modalidad.Clear
   Modalidad.AddItem "ENTREGA FISICA"
   Modalidad.AddItem "COMPENSACION"
   Modalidad.Text = "ENTREGA FISICA"

   cmbTipo.AddItem "TOMADOR":                   cmbTipo.ItemData(cmbTipo.NewIndex) = 0
   cmbTipo.AddItem "PRESTAMISTA":               cmbTipo.ItemData(cmbTipo.NewIndex) = 1
   cmbTipo.ListIndex = 0

   I_Convencion.AddItem "Siguiente":            I_Convencion.ItemData(I_Convencion.NewIndex) = 1
   I_Convencion.AddItem "Anterior":             I_Convencion.ItemData(I_Convencion.NewIndex) = -1
   I_Convencion.AddItem "Siguiente Modificado": I_Convencion.ItemData(I_Convencion.NewIndex) = 2
   I_Convencion.AddItem "Anterior  Modificado": I_Convencion.ItemData(I_Convencion.NewIndex) = -2
   I_Convencion.ListIndex = 0

   D_Convencion.AddItem "Siguiente":            D_Convencion.ItemData(D_Convencion.NewIndex) = 1
   D_Convencion.AddItem "Anterior":             D_Convencion.ItemData(D_Convencion.NewIndex) = -1
   D_Convencion.AddItem "Siguiente Modificado": D_Convencion.ItemData(D_Convencion.NewIndex) = 2
   D_Convencion.AddItem "Anterior  Modificado": D_Convencion.ItemData(D_Convencion.NewIndex) = -2
   D_Convencion.ListIndex = 0


End Sub


Private Sub Form_Unload(Cancel As Integer)
   Set MiObjSwapFra = Nothing
End Sub

Private Sub I_Convencion_Click()
   Toolbar1.Buttons(3).Enabled = False
   If I_Grid.Rows > 1 Then
      Call AplicarValidacionFeriados("I", I_Grid)
      Call CalculoInteresBonos("I", I_Grid)
   End If
End Sub

Private Sub I_DiasReset_Change()
   Toolbar1.Buttons(3).Enabled = False
   I_DiasReset.Text = Val(I_DiasReset.Text)
End Sub

Private Sub I_DiasReset_KeyDown(KeyCode As Integer, Shift As Integer)
   If I_Grid.Rows > 1 And KeyCode = vbKeyReturn Then
      Call AplicarValidacionFeriados("I", I_Grid)
      Call CalculoInteresBonos("I", I_Grid)
   End If
End Sub

Private Sub I_FERIADOCHK_Click(Index As Integer)
   Toolbar1.Buttons(3).Enabled = False
   If I_Grid.Rows > 1 Then
      Call AplicarValidacionFeriados("I", I_Grid)
      Call CalculoInteresBonos("I", I_Grid)
   End If
End Sub

Private Sub Indicador_Click()
   Toolbar1.Buttons(3).Enabled = False
   If cmbTipo.ItemData(cmbTipo.ListIndex) = 0 Then
      SSFlujos.TabCaption(0) = "DETALLE  RECIBO VARIABLE"
      SSFlujos.TabCaption(1) = "DETALLE ENTREGO FIJO"
   Else
      SSFlujos.TabCaption(0) = "DETALLE ENTREGO VARIABLE"
      SSFlujos.TabCaption(1) = "DETALLE  RECIBO FIJA"
   End If
   
   If Indicador.ListIndex >= 0 And Moneda.ListIndex >= 0 Then
      Tasa.Enabled = False
      If Indicador.ItemData(Indicador.ListIndex) = 0 And Indicador.List(Indicador.ListIndex) Like "FIJA*" Then
         Tasa.Text = 0
         Tasa.Enabled = True
      Else
         Tasa.Text = LeerUltimoIndice(Moneda.ItemData(Moneda.ListIndex), Indicador.ItemData(Indicador.ListIndex))
      End If
   End If
End Sub

Private Sub Madurez_Change()
   Toolbar1.Buttons(3).Enabled = False
   Call DiaSemanal(DiaFechaMadurez, Madurez.Text)
End Sub

Private Sub Madurez_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call CalculoDiasMadurez("Madurez")
   End If
End Sub

Private Sub Madurez_LostFocus()
   Call CalculoDiasMadurez("Madurez")
End Sub

Private Sub Moneda_Click()
   Toolbar1.Buttons(3).Enabled = False
   If Moneda.ListIndex >= 0 Then
      Call LeeTasasMoneda(Moneda.ItemData(Moneda.ListIndex), Indicador, False)
      MonPago.Clear
      MedioPago.Clear
      Call LeeMonedasPago(MonPago, Moneda.ItemData(Moneda.ListIndex))
   End If
   If Moneda.ListIndex >= 0 Then
      Call LeeTasasMoneda(Moneda.ItemData(Moneda.ListIndex), C_Indicador, True)
   End If
   
   
   
   If Indicador.ListIndex >= 0 And Moneda.ListIndex >= 0 Then
      Tasa.Text = LeerUltimoIndice(Moneda.ItemData(Moneda.ListIndex), Indicador.ItemData(Indicador.ListIndex))
   End If
End Sub


Private Function GeneraTablaFlujos(Lado As Lados) As Boolean
   Dim Interes             As ComboBox
   Dim Capital             As ComboBox
   Dim grilla              As MSFlexGrid
   Dim Direcion            As Integer
   Dim iDiasInteres        As Integer
   Dim iDiasCapital        As Integer
   Dim iPlazo              As Integer
   Dim dInicio             As Date
   Dim dPrimerPago         As Date
   Dim dPenultimoPago      As Date
   Dim dMadurez            As Date
   Dim FechaFin            As Date
   Dim FechaVencAnt        As Date
   Dim DiaAmort            As Integer
   Dim AmortizacionCapital As Date
   Dim AmortizacionIntres  As Date
   Dim FechaAmortizacion   As Date
   Dim nRedondeo           As Integer

   Dim DivCap              As Integer
   Dim FactorDiv           As Integer
   Dim vAmortizacion       As Double
   Dim vCuadratura         As Double
   Dim vMontoCapital       As Double
   Dim vMontoGrid          As Double
   Dim vTasa               As Double
   Dim iFilas              As Integer

   GeneraTablaFlujos = False

   dInicio = FechaEfectiva.Text
   dMadurez = Madurez.Text
   vMontoCapital = Nocionales.Text
   nRedondeo = IIf(Moneda.Text Like "PESOS*", 0, 4)

   If Lado = Izquierdo Then
      Set grilla = I_Grid
      vTasa = CDbl(Tasa.Text)
   Else
      Set grilla = D_Grid
      vTasa = CDbl(C_Tasa.Text)
   End If

   iDiasInteres = Dias.Text
   If iDiasInteres < 90 Then
      iDiasInteres = 1
   ElseIf iDiasInteres >= 90 And iDiasInteres < 180 Then
      iDiasInteres = 3
   ElseIf iDiasInteres >= 180 And iDiasInteres < 365 Then
      iDiasInteres = 6
   ElseIf iDiasInteres >= 365 Then
      iDiasInteres = 12
   End If
   
   iDiasCapital = 0
   If iDiasCapital > iDiasInteres Then
      PlazoMin = iDiasInteres
   Else
      PlazoMin = IIf(iDiasCapital > 0, iDiasCapital, iDiasInteres)
   End If

   FechaFin = CDate(dMadurez)
   FechaVencAnt = dInicio
   DiaAmort = Day(dInicio)

   If iDiasCapital = 0 Then
      AmortizacionCapital = FechaFin
   Else
      AmortizacionCapital = DateAdd("M", iDiasCapital, CDate(dInicio))
   End If
   If CDate(dInicio) = CDate(dMadurez) Then
      AmortizacionIntres = DateAdd("M", iDiasInteres, CDate(dInicio))
   Else
      AmortizacionIntres = CDate(dMadurez)
   End If
   FechaAmortizacion = AmortizacionIntres

   If FechaAmortizacion > FechaFin Then
      FechaAmortizacion = FechaFin
   End If

   FactorDiv = 1
   If iDiasCapital > 0 Then
      DivCap = iDiasCapital
      FactorDiv = BacDiv(DateDiff("M", AmortizacionCapital, CDate(FechaFin)), CDbl(DivCap))
      FactorDiv = FactorDiv + 1
   End If
   If FactorDiv = 0 Then
      MsgBox "Fechas Ingresadas no concuerdan com períodos de Amortización seleccionados", vbExclamation, TITSISTEMA
      Exit Function
   End If

   vAmortizacion = Round((CDbl(vMontoCapital) / FactorDiv), nRedondeo)
   vCuadratura = vMontoCapital - (vAmortizacion * FactorDiv)

   iFilas = 1
   grilla.Rows = 1
   Do While CDate(FechaAmortizacion) <= CDate(FechaFin)
      vMontoGrid = 0
      If FechaAmortizacion = AmortizacionCapital Then
         If AmortizacionCapital = FechaFin Then
            vAmortizacion = CDbl(vAmortizacion) + CDbl(vCuadratura)
         End If
         vMontoGrid = vAmortizacion
         AmortizacionCapital = DateAdd("M", iDiasCapital, FechaAmortizacion)
      End If

      grilla.Rows = grilla.Rows + 1
      grilla.TextMatrix(iFilas, 0) = Format(iFilas, "##00")
      grilla.TextMatrix(iFilas, 1) = Format(FechaAmortizacion, "dd/mm/yyyy")
      grilla.TextMatrix(iFilas, 2) = Format(vMontoGrid, TipoFormato("USD"))
      grilla.TextMatrix(iFilas, 3) = Format(vTasa, TipoFormato("USD"))
     grilla.TextMatrix(iFilas, 14) = Format(FechaAmortizacion, "dd/mm/yyyy")
     grilla.TextMatrix(iFilas, 15) = Format(FechaAmortizacion, "dd/mm/yyyy")
     grilla.TextMatrix(iFilas, 16) = Format(FechaAmortizacion, "dd/mm/yyyy")

      FechaVencAnt = FechaAmortizacion
      FechaAmortizacion = DateAdd("M", PlazoMin, FechaAmortizacion)

      If FechaAmortizacion > FechaFin And Abs(DateDiff("d", CDate(FechaAmortizacion), CDate(FechaFin))) <= 10 Then
         FechaAmortizacion = FechaFin
         AmortizacionCapital = FechaFin
      Else
         If FechaAmortizacion > FechaFin And CDate(grilla.TextMatrix(iFilas, 1)) < FechaFin Then
            FechaAmortizacion = FechaFin
            AmortizacionCapital = FechaFin
         ElseIf Abs(DateDiff("d", CDate(FechaFin), CDate(FechaAmortizacion))) <= 10 Then
            FechaAmortizacion = FechaFin
            AmortizacionCapital = FechaFin
         End If
      End If
      iFilas = iFilas + 1
   Loop

   If Lado = Derecho Then
     Call AplicarValidacionFeriados("D", grilla)
     Call CalculoInteresBonos("D", grilla)
   Else
     Call AplicarValidacionFeriados("I", grilla)
     Call CalculoInteresBonos("I", grilla)
   End If

   GeneraTablaFlujos = True
End Function

Private Sub Limpiar()
   Moneda.ListIndex = -1
   Nocionales.Text = 0#
   Indicador.ListIndex = -1
   Tasa.Text = 0
   C_Indicador.ListIndex = -1
   C_Tasa.Text = 0#
   ConteoDias.ListIndex = -1
   
   FechaEfectiva.Text = DateAdd("D", 1, gsBAC_Fecp)
   Madurez.Text = DateAdd("d", Dias.Text, FechaEfectiva.Text)
   Dias.Text = DateDiff("d", FechaEfectiva.Text, Madurez.Text)
   I_Grid.Rows = 1
   D_Grid.Rows = 1
   I_DiasReset.Text = 0
   D_DiasReset.Text = 0
   
   MonPago.ListIndex = -1
   MedioPago.ListIndex = -1
   Modalidad.Text = "ENTREGA FISICA"
   
End Sub

Private Function ValidacionPreGeneracio() As Boolean
   Dim cCadena As String
   
   ValidacionPreGeneracio = False
   
   cCadena = ""
   If Moneda.ListIndex < 0 Then cCadena = cCadena & "- La moneda, no se ha seleccionado." & vbCrLf
   If Nocionales.Text = 0# Then cCadena = cCadena & "- Los nominales, no han sido ingresados." & vbCrLf
   If Indicador.ListIndex < 0 Then cCadena = cCadena & "- El indicador, no ha sido seleccionado." & vbCrLf
   If Tasa.Text = 0# Then cCadena = cCadena & "- La tasa del indicador, no tiene valor para el día de hoy." & vbCrLf
   If C_Indicador.ListIndex < 0 Then cCadena = cCadena & "- El indicador de parte fija, no se encuentra asignado." & vbCrLf
   If C_Tasa.Text = 0# Then cCadena = cCadena & "- El valor para el indicador de la parte fija, no se ha ingresado." & vbCrLf
   If ConteoDias.ListIndex = -1 Then cCadena = cCadena & "- El indicador del conteo de días, no se ha seleccionado." & vbCrLf
   If CDate(FechaEfectiva.Text) <= CDate(gsBAC_Fecp) Then cCadena = cCadena & "- La fecha efectiva, debe ser superior a la fecha de hoy." & vbCrLf
   If CDate(Madurez.Text) <= CDate(FechaEfectiva.Text) Then cCadena = cCadena & "- La fecha madurez, debe ser mayor a la fecha efectiva." & vbCrLf
   If MonPago.ListIndex < 0 Then cCadena = cCadena & "- Moneda de Pago, no se ha especificado." & vbCrLf
   If MedioPago.ListIndex < 0 Then cCadena = cCadena & "- Medio de Pago, no se ha especificado." & vbCrLf
   
   If cCadena = "" Then
      ValidacionPreGeneracio = True
   Else
      MsgBox "Validación pre generación de totales" & vbCrLf & "Se ha encontrado que :" & vbCrLf & vbCrLf & cCadena, vbExclamation, TITSISTEMA
   End If
End Function

Private Sub MonPago_Click()
   If MonPago.ListIndex >= 0 Then
      Call CargaFPagoxMoneda(MedioPago, MonPago.ItemData(MonPago.ListIndex))
   End If
End Sub

Private Sub Nocionales_Change()
   Toolbar1.Buttons(3).Enabled = False
End Sub

Private Sub Tasa_Change()
   Toolbar1.Buttons(3).Enabled = False
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call Limpiar
      Case 2
         If ValidacionPreGeneracio = True Then
            If GeneraTablaFlujos(Derecho) = True Then
               Call GeneraTablaFlujos(Izquierdo)
               Toolbar1.Buttons(3).Enabled = True
            End If
         End If
      Case 3

         If ValidacionPreGeneracio = True Then
            'PRD-4858, jbh, info. para el Threshold
            Thr_dPlazoOperacion = CInt(Dias.Text)
            Thr_CodProducto = 3

            If Grabacion = True Then
               Call Limpiar
            Else
               'PRD-4858, jbh.  Validar si llegó aquí porque decidió anular operación en formulario de Threshold
               '¡Falló la grabación o el usuario la canceló por Threshold?
               If Thr_AplicaThreshold = True Then  '1° ver si aplica Threshold
                  If Thr_GrabaThreshold = False Then   'Si aplica, ver si no grabó
                     MsgBox "El usuario anuló la Operación!", vbExclamation, TITSISTEMA
                  Else
                     MsgBox "Error en la Grabación." & vbcrlfd & "No se ha podido completar la grabación.", vbExclamation, TITSISTEMA    'PRD-4858, jbh, 15-02-2010
                  End If
               Else    'no depende del Threshold
                  MsgBox "Error en la Grabación." & vbcrlfd & "No se ha podido completar la grabación.", vbExclamation, TITSISTEMA    'PRD-4858, jbh, 15-02-2010
               End If
               'MsgBox "Error en la Grabación." & vbcrlfd & "No se ha podido completar la grabación.", vbExclamation, TITSISTEMA
            End If
         End If
      Case 4
         Unload Me
   End Select
   
End Sub

Private Function Grabacion() As Boolean
   Dim TipoSwap   As Integer

   Grabacion = False

   If I_Grid.Rows = 1 Then
      MsgBox "Debe generar el flujo de intereses.", vbExclamation, TITSISTEMA
   End If

   iAceptar = False
   TipoSwap = 3         '-->>> FRA : Forward Rate Agreegement 'EntregaTipoSwap
   Tipo_Producto = "FR" '-->>> IIf(TipoSwap = 1, "ST", IIf(TipoSwap = 2, "SM", "SP"))

   BacGrabar.MiFormulario = "Nuevo Fra"
   BacGrabar.MiTipoSwap = TipoSwap
   If Me.tag <> "" Then
      BacGrabar.iModificacion = True
      BacGrabar.TxtRut.Text = iRut
      BacGrabar.txtCliente.Text = cNombre
      Call CargaItemCombo(BacGrabar.cmbCartera, cCarteraFinanciera)
      Call CargaItemCombo(BacGrabar.CmbArea, cAreaResponsable)
      Call CargaItemCombo(BacGrabar.CmbLibro, cLibroNegociacion)
      Call CargaItemCombo(BacGrabar.CmbCartNorm, cCarteraNormativa)
      Call CargaItemCombo(BacGrabar.CmbSubCartera, cSubCartera)
   End If
   
   
   BacGrabar.Show vbModal
   
   If FRM_SWAP_OP_FRA.iAceptar = True Then   'If iAceptar = True Then
      Grabacion = MiObjSwapFra.PreGrabadoFRA(Me)
   Else
      MsgBox "La Grabación Ha Sido Cancelada Manualmente. ", vbExclamation, TITSISTEMA
      Call Limpiar
   End If
End Function


Private Sub AplicarValidacionFeriados(Lado As String, grillas As MSFlexGrid)
   Dim iContador     As Integer
   Dim dFechaFlujo   As Date

   For iContador = 1 To grillas.Rows - 1
      SSFlujos.Tab = IIf(Lado = "D", 1, 0)

     'Amortizacion
      dFechaFlujo = Madurez.Text 'grillas.TextMatrix(iContador, 15)
      dFechaFlujo = ReHaceFechas(Lado, dFechaFlujo, False, False, True)
      grillas.TextMatrix(iContador, 1) = Format(dFechaFlujo, "dd/mm/yyyy")
     
     ' Liquidez
      dFechaFlujo = FechaEfectiva.Text ' grillas.TextMatrix(iContador, 15)
      dFechaFlujo = ReHaceFechas(Lado, dFechaFlujo, False, False, True) ' ReHaceFlujoHabil(Lado, dFechaFlujo, False, False, True)
      grillas.TextMatrix(iContador, 14) = Format(dFechaFlujo, "dd/mm/yyyy")

     ' Fecha Reset
      dFechaFlujo = FechaEfectiva.Text ' grillas.TextMatrix(iContador, 1)
      dFechaFlujo = ReHaceFechas(Lado, dFechaFlujo, True, True, False)  'ReHaceFlujoHabil(Lado, dFechaFlujo, True, True, False)
      grillas.TextMatrix(iContador, 16) = Format(dFechaFlujo, "dd/mm/yyyy")
   Next iContador

End Sub

Private Function ReHaceFechas(MiLado As String, Fecha As Date, FechaReset As Boolean, DiasReset As Boolean, Convencion As Boolean) As Date
   Dim CHI              As Boolean
   Dim Sw_Chile         As Boolean
   Dim USA              As Boolean
   Dim Sw_EEUU          As Boolean
   Dim ENG              As Boolean
   Dim Sw_Engl          As Boolean
   Dim dFechaAux        As Date
   Dim iCantDiasHabiles As Long
   Dim iIntervalo       As Integer
   Dim Modificado       As Boolean
   Dim iContador        As Integer
   
   dFechaAux = Fecha
   
   If FechaReset = True Then
      'Fecha Reset
      CHI = IIf(MiLado = "I", I_FERIADOCHK(0).Value, D_FERIADOCHK(0).Value)
      USA = IIf(MiLado = "I", I_FERIADOCHK(1).Value, D_FERIADOCHK(1).Value)
      ENG = IIf(MiLado = "I", I_FERIADOCHK(2).Value, D_FERIADOCHK(2).Value)
   End If
   If FechaReset = False Then
      'Fecha Liquidacion
      CHI = IIf(MiLado = "I", I_FERIADOCHK(3).Value, D_FERIADOCHK(3).Value)
      USA = IIf(MiLado = "I", I_FERIADOCHK(4).Value, D_FERIADOCHK(4).Value)
      ENG = IIf(MiLado = "I", I_FERIADOCHK(5).Value, D_FERIADOCHK(5).Value)
   End If
   
   iCantDiasHabiles = 0
   If DiasReset = True Then
      iCantDiasHabiles = IIf(MiLado = "I", I_DiasReset.Text, D_DiasReset.Text) * -1
   End If
   
   iIntervalo = 1
   Modificado = False
   If Convencion = True Then
      If MiLado = "D" Then iIntervalo = D_Convencion.ItemData(D_Convencion.ListIndex)
      If MiLado = "I" Then iIntervalo = I_Convencion.ItemData(I_Convencion.ListIndex)
      If iIntervalo = 2 Then iIntervalo = 1: Modificado = True
      If iIntervalo = -2 Then iIntervalo = -1: Modificado = True
   End If
   
   If DiasReset = True And Convencion = False Then
      iIntervalo = iIntervalo * -1
   End If
   
   Sw_Chile = Not CHI
   Sw_EEUU = Not USA
   Sw_Engl = Not ENG

   If Not (CHI = True Or USA = True Or ENG = True) Then
      If DiasReset = True Then
         dFechaAux = DateAdd("D", (iCantDiasHabiles * iIntervalo) * -1, dFechaAux)
      End If
   End If

   iContador = 0
   Do While (CHI = True Or USA = True Or ENG = True)
      If CHI = True Then Sw_Chile = MiDiaHabil(Str(dFechaAux), Chile)
      If USA = True Then Sw_EEUU = MiDiaHabil(Str(dFechaAux), EstadosUnidos)
      If ENG = True Then Sw_Engl = MiDiaHabil(Str(dFechaAux), Inglaterra)

      If (Sw_Chile = True) And (Sw_EEUU = True) And (Sw_Engl = True) Then
         iContador = iContador + 1
         
         If Modificado = True Then
            If Month(dFechaAux) <> Month(DateAdd("D", iIntervalo, dFechaAux)) Then
               iIntervalo = iIntervalo * -1
               dFechaAux = Fecha
               Modificado = False
               iContador = 1
            End If
         End If
         
         If Abs(iCantDiasHabiles) < iContador Then
            Exit Do
         End If
         dFechaAux = DateAdd("D", iIntervalo, dFechaAux)
         
      Else
         dFechaAux = DateAdd("D", iIntervalo, dFechaAux)
      End If
   Loop
   ReHaceFechas = dFechaAux
End Function

Private Function MiDiaHabil(cFecha As String, Plaza As Integer) As Boolean
   Dim objFeriado As New clsFeriado
   Dim iAno       As Integer
   Dim iMes       As Integer
   Dim sDia       As String
   Dim gcPlaza    As String
   Dim n          As Integer

   gcPlaza = String(5 - Len(Trim(Plaza)), "0") & Trim(Str(Trim(Plaza)))

   If Weekday(cFecha) = 1 Or Weekday(cFecha) = 7 Then
      MiDiaHabil = False
      Exit Function
   End If

   iAno = DatePart("yyyy", cFecha)
   iMes = DatePart("m", cFecha)
   sDia = Format(DatePart("d", cFecha), "00")

   Call objFeriado.Leer(iAno, gcPlaza)
   Select Case iMes
      Case 1:  n = InStr(objFeriado.feene, sDia)
      Case 2:  n = InStr(objFeriado.fefeb, sDia)
      Case 3:  n = InStr(objFeriado.femar, sDia)
      Case 4:  n = InStr(objFeriado.feabr, sDia)
      Case 5:  n = InStr(objFeriado.femay, sDia)
      Case 6:  n = InStr(objFeriado.fejun, sDia)
      Case 7:  n = InStr(objFeriado.fejul, sDia)
      Case 8:  n = InStr(objFeriado.feago, sDia)
      Case 9:  n = InStr(objFeriado.fesep, sDia)
      Case 10: n = InStr(objFeriado.feoct, sDia)
      Case 11: n = InStr(objFeriado.fenov, sDia)
      Case 12: n = InStr(objFeriado.fedic, sDia)
   End Select
   Set objFeriado = Nothing

   MiDiaHabil = IIf(n > 0, False, True)
End Function



Function CalculoInteresBonos(MiLado As String, Grd As MSFlexGrid)
   Dim Spread, Base, Tasa As Double
   Dim FechaAmortiza      As Date
   Dim FechaVencAnt       As Date
   Dim FecVAnt            As Date
   Dim DiasDif            As Integer
   Dim cuenta             As Integer
   Dim MontoAmortiza      As Double
   Dim MontoGrd           As Double
   Dim Interes            As Double
   Dim Plazo              As Double
   Dim RestoCapital       As Double
   Dim TotalVenc          As Double
   Dim CodMoneda          As Integer
   Dim FactorUSD          As Double
   Dim MontoCLP           As Double
   Dim FactorCLP          As Double
   Dim MontoUSD           As Double
   Dim MonFuerteC         As Double
   Dim Referencial        As Integer
   Dim PeriDias           As String
   Dim PeriBase           As String
   Dim fecInicio          As Date
   Dim MontoCapital       As Double
   Dim CodigoMoneda       As Integer
   Dim BaseStr            As String
   Dim PlazoDias          As Double
   Dim nRedondeo          As Integer
   Dim nParidad#
   Dim Pasito

   Spread = 0
   FactorCLP = ValorDolarObs

   PlazoDias = Dias.Text
   If PlazoDias < 90 Then
      PlazoDias = 1
   ElseIf PlazoDias >= 90 And PlazoDias < 180 Then
      PlazoDias = 3
   ElseIf PlazoDias >= 180 And PlazoDias < 365 Then
      PlazoDias = 6
   ElseIf PlazoDias >= 365 Then
      PlazoDias = 12
   End If

   BaseStr = ConteoDias.Text
   fecInicio = FechaEfectiva.Text
   MontoCapital = Nocionales.Text
   CodMoneda = Moneda.ItemData(Moneda.ListIndex)

   FactorCLP = ValorDolarObs
   Pasito = Right(BaseStr, 10)
   PeriDias = Trim(Left(Pasito, 5))
   PeriBase = Trim(Right(Pasito, 5))
   Base = IIf(PeriBase = "A", 365, PeriBase)

   DiasDif = DateDiff("d", CDate(fecInicio), CDate(Grd.TextMatrix(1, 1)))

   FechaVencAnt = CDate(fecInicio)
   MontoAmortiza = MontoCapital
   CodMoneda = IIf(CodMoneda = 0, 994, CodMoneda)

   Dim ValMonedas As New ClsMoneda
   If ValMonedas.LeerxCodigo(CodMoneda) Then
      FactorUSD = ValMonedas.vmValor
      MonFuerteC = ValMonedas.mnrefusd
      Referencial = ValMonedas.mnrefmerc
   End If
   ValMonedas.Limpiar

   Set ValMonedas = Nothing

   For cuenta = 1 To Grd.Rows - 1
      FechaAmortiza = Grd.TextMatrix(cuenta, 1)
      If Grd.TextMatrix(cuenta, 2) = "" Then
         MontoGrd = 0#
         RestoCapital = 0
      Else
         MontoGrd = Grd.TextMatrix(cuenta, 2)
         RestoCapital = CDbl(Grd.TextMatrix(cuenta, 2))
      End If

      Tasa = CDbl(Grd.TextMatrix(cuenta, 3))

      DiasDif = IIf(PeriDias = "A", DateDiff("d", CDate(FechaVencAnt), CDate(FechaAmortiza)), BacDifDias30(CDate(FechaVencAnt), CDate(FechaAmortiza)))

      FecVAnt = FechaVencAnt
      FechaVencAnt = Grd.TextMatrix(cuenta, 1)
      Plazo = BacDiv(CDbl(DiasDif), CDbl(Val(Base)))
      nRedondeo = IIf(CodMoneda = 999, 0, CantDecimales) '4)
      Interes = Round(MontoAmortiza * (Tasa / 100) * (Plazo), nRedondeo)

      If CodMoneda = 999 Or CodMoneda = 998 Then
         MontoCLP = Round((Interes * FactorUSD), 0)
         MontoUSD = Round((BacDiv(MontoCLP, CDbl(FactorCLP))), 3)
      ElseIf CodMoneda = 13 Or Referencial = 1 Then
         MontoUSD = Interes
         MontoUSD = Round(MontoUSD, CantDecimales) '4)
         MontoCLP = Round((MontoUSD * FactorCLP), 0)
      Else

         If MiLado = "D" Then 'If TipOpcion = "V" Then
            If cSwMxV = "C" And CodMoneda <> 13 Then
               nParidad# = I_ValorMoneda.Text
               MontoUSD = IIf(cRrdaV = "M", (Interes * nParidad#), (BacDiv(Interes, nParidad#)))
            Else
               MontoUSD = IIf(Val(MonFuerteC) = 1, (Interes * FactorUSD), (BacDiv(Interes, CDbl(FactorUSD))))
            End If
         Else
            If cSwMxC = "C" And CodMoneda <> 13 Then
               nParidad# = D_ValorMoneda.Text
               MontoUSD = IIf(cRrdaV = "M", (Interes * nParidad#), (BacDiv(Interes, nParidad#)))
            Else
               MontoUSD = IIf(Val(MonFuerteC) = 1, (Interes * FactorUSD), (BacDiv(Interes, CDbl(FactorUSD))))
            End If
         End If
         MontoUSD = Round(MontoUSD, CantDecimales) '3)
         MontoCLP = Round((MontoUSD * FactorCLP), 0)
      End If

      TotalVenc = MontoGrd + Interes
      Grd.TextMatrix(cuenta, 4) = Format(Interes, TipoFormato(IIf(CodMoneda = 999, "CLP", "USD")))
      Grd.TextMatrix(cuenta, 5) = Format(TotalVenc, TipoFormato(IIf(CodMoneda = 999, "CLP", "USD")))
      Grd.TextMatrix(cuenta, 8) = CDbl(MontoAmortiza - RestoCapital)
      Grd.TextMatrix(cuenta, 9) = FecVAnt
      Grd.TextMatrix(cuenta, 10) = MontoAmortiza
      Grd.TextMatrix(cuenta, 11) = MontoUSD
      Grd.TextMatrix(cuenta, 12) = MontoCLP
      MontoAmortiza = MontoAmortiza - RestoCapital
   Next
   Set Grd = Nothing
End Function


Private Sub TasaProyectada()
   Dim Datos()
   Dim iMoneda          As Integer
   Dim iPlazoHolding    As Integer
   Dim iTasaPlazoHold   As Double
   Dim iIndiceSpot      As Double
   
   If Moneda.ListIndex <> -1 Then 'PROD-10967
   iMoneda = Moneda.ItemData(Moneda.ListIndex)
   End If 'PROD-10967
   iPlazoHolding = DateDiff("D", CDate(gsBAC_Fecp), CDate(FechaEfectiva.Text))
   iIndiceSpot = Tasa.Text
   iTasaPlazoHold = C_Tasa.Text
   
   Envia = Array()
   AddParam Envia, CDbl(iMoneda)
   AddParam Envia, CDbl(iPlazoHolding)
   If Not Bac_Sql_Execute("BacFwdSuda..SP_RETORNATASAMONEDA", Envia) Then
      Exit Sub
   End If
   If Bac_SQL_Fetch(Datos()) Then
      iTasaPlazoHold = CDbl(Datos(1))
   End If
   
   vTasaProyectada.Text = BacDiv(iIndiceSpot, (1# + iTasaPlazoHold / 360# * iPlazoHolding))
End Sub
