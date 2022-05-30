VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form bacOpeFRA 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Operaciones Forward Rate Agreements - FRA"
   ClientHeight    =   6420
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   9105
   Icon            =   "bacFRA.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6420
   ScaleWidth      =   9105
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   53
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
         NumButtons      =   3
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Grabar"
            Object.Tag             =   ""
            ImageIndex      =   3
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Lipiar"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   ""
            ImageIndex      =   4
         EndProperty
      EndProperty
      Begin Threed.SSPanel etqNumero 
         Height          =   300
         Left            =   5775
         TabIndex        =   54
         Top             =   75
         Width           =   3060
         _Version        =   65536
         _ExtentX        =   5397
         _ExtentY        =   529
         _StockProps     =   15
         Caption         =   "Modificación Operación N°:  "
         ForeColor       =   8388736
         BackColor       =   12632256
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
   Begin VB.Frame frame3 
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00008000&
      Height          =   3570
      Left            =   45
      TabIndex        =   25
      Top             =   2745
      Width           =   9050
      Begin BACControles.TXTNumero txtDiferencial1 
         Height          =   315
         Left            =   6510
         TabIndex        =   21
         Top             =   3120
         Width           =   2175
         _ExtentX        =   3836
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txtDiferencial 
         Height          =   315
         Left            =   6510
         TabIndex        =   20
         Top             =   2760
         Width           =   2190
         _ExtentX        =   3863
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
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txtTasa 
         Height          =   315
         Left            =   6510
         TabIndex        =   17
         Top             =   1440
         Width           =   1095
         _ExtentX        =   1931
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
         Min             =   "-9999.9999"
         Max             =   "9999.9999"
         CantidadDecimales=   "4"
      End
      Begin BACControles.TXTNumero txtTasaHoy 
         Height          =   315
         Left            =   6510
         TabIndex        =   14
         Top             =   240
         Width           =   1095
         _ExtentX        =   1931
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
         Min             =   "-9999.9999"
         Max             =   "9999.9999"
         CantidadDecimales=   "4"
      End
      Begin BACControles.TXTFecha fecLiquidacion 
         Height          =   315
         Left            =   1320
         TabIndex        =   52
         Top             =   1950
         Width           =   1215
         _ExtentX        =   2143
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
         MaxDate         =   73415
         MinDate         =   18264
         Text            =   "13/06/2001"
      End
      Begin BACControles.TXTNumero txtPlazo 
         Height          =   330
         Left            =   1695
         TabIndex        =   13
         Top             =   1500
         Width           =   840
         _ExtentX        =   1482
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
      End
      Begin BACControles.TXTFecha FecVencimiento 
         Height          =   315
         Left            =   1320
         TabIndex        =   12
         Top             =   1110
         Width           =   1215
         _ExtentX        =   2143
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
         MaxDate         =   73396
         MinDate         =   18628
         Text            =   "13/06/2001"
      End
      Begin BACControles.TXTFecha FecFijacion 
         Height          =   315
         Left            =   1320
         TabIndex        =   11
         Top             =   750
         Width           =   1215
         _ExtentX        =   2143
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
         MaxDate         =   73396
         MinDate         =   18264
         Text            =   "13/06/2001"
      End
      Begin BACControles.TXTFecha fecContrato 
         Height          =   315
         Left            =   1320
         TabIndex        =   10
         Top             =   240
         Width           =   1215
         _ExtentX        =   2143
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
         MaxDate         =   73396
         MinDate         =   18264
         Text            =   "13/06/2001"
      End
      Begin VB.ComboBox cmbMonedaPago 
         Height          =   315
         Left            =   6525
         Style           =   2  'Dropdown List
         TabIndex        =   18
         Top             =   1950
         Width           =   2175
      End
      Begin VB.ComboBox cmbFPago 
         Height          =   315
         Left            =   6510
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   19
         Top             =   2310
         Width           =   2175
      End
      Begin VB.ComboBox cmbPlazo 
         Height          =   315
         Left            =   6510
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   16
         Top             =   1110
         Width           =   2175
      End
      Begin VB.ComboBox cmbTasa 
         Height          =   315
         Left            =   6525
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   15
         Top             =   750
         Width           =   2175
      End
      Begin VB.Label lblFRAg 
         AutoSize        =   -1  'True
         Caption         =   "Moneda de Pago "
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
         Index           =   21
         Left            =   5040
         TabIndex        =   51
         Top             =   2025
         Width           =   1515
      End
      Begin VB.Label lblFRAg 
         AutoSize        =   -1  'True
         Caption         =   " Período Forward                         Días"
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
         Index           =   19
         Left            =   135
         TabIndex        =   49
         Top             =   1530
         Width           =   3390
      End
      Begin VB.Label lblFRAg 
         Caption         =   " Diferencial $$"
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
         Height          =   225
         Index           =   18
         Left            =   4980
         TabIndex        =   48
         Tag             =   "Diferencial a ..."
         Top             =   3195
         Width           =   1290
      End
      Begin VB.Label lblFRAg 
         Caption         =   "Diferencial "
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
         Height          =   225
         Index           =   16
         Left            =   5040
         TabIndex        =   41
         Tag             =   "Diferencial a ..."
         Top             =   2850
         Width           =   1290
      End
      Begin VB.Label lblFRAg 
         AutoSize        =   -1  'True
         Caption         =   "Tasa Hoy "
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
         Index           =   12
         Left            =   5040
         TabIndex        =   40
         Top             =   285
         Width           =   885
      End
      Begin VB.Label lblFRAg 
         Alignment       =   2  'Center
         Caption         =   "%"
         Enabled         =   0   'False
         Height          =   255
         Index           =   14
         Left            =   7710
         TabIndex        =   39
         Top             =   285
         Width           =   315
      End
      Begin VB.Label lblFRAg 
         AutoSize        =   -1  'True
         Caption         =   "Forma de Pago "
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
         Left            =   5040
         TabIndex        =   38
         Top             =   2355
         Width           =   1350
      End
      Begin VB.Label lblFRAg 
         AutoSize        =   -1  'True
         Caption         =   " Período "
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
         Left            =   4995
         TabIndex        =   35
         Top             =   1155
         Width           =   810
      End
      Begin VB.Label lblFRAg 
         Caption         =   " Contrato "
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
         Index           =   8
         Left            =   120
         TabIndex        =   26
         Top             =   285
         Width           =   1245
      End
      Begin VB.Label lblFecha 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "ddd, dd mmm yyyy"
         Enabled         =   0   'False
         Height          =   315
         Index           =   3
         Left            =   2600
         TabIndex        =   30
         Top             =   240
         Width           =   1800
      End
      Begin VB.Label lblFRAg 
         AutoSize        =   -1  'True
         Caption         =   "Tasa Contrato "
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
         Left            =   5040
         TabIndex        =   36
         Top             =   1515
         Width           =   1275
      End
      Begin VB.Label lblFRAg 
         Alignment       =   2  'Center
         Caption         =   "%"
         Enabled         =   0   'False
         Height          =   255
         Index           =   6
         Left            =   7710
         TabIndex        =   37
         Top             =   1515
         Width           =   315
      End
      Begin VB.Label lblFRAg 
         AutoSize        =   -1  'True
         Caption         =   "Tasa "
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
         Left            =   5040
         TabIndex        =   34
         Top             =   795
         Width           =   495
      End
      Begin VB.Label lblFecha 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "ddd, dd mmm yyyy"
         Enabled         =   0   'False
         Height          =   315
         Index           =   2
         Left            =   2595
         TabIndex        =   32
         Top             =   1110
         Width           =   1800
      End
      Begin VB.Label lblFecha 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "ddd, dd mmm yyyy"
         Enabled         =   0   'False
         Height          =   315
         Index           =   1
         Left            =   2595
         TabIndex        =   33
         Top             =   1950
         Width           =   1800
      End
      Begin VB.Label lblFecha 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "ddd, dd mmm yyyy"
         Enabled         =   0   'False
         Height          =   315
         Index           =   0
         Left            =   2610
         TabIndex        =   31
         Top             =   750
         Width           =   1800
      End
      Begin VB.Label lblFRAg 
         Caption         =   " Vencimiento "
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
         Index           =   4
         Left            =   120
         TabIndex        =   29
         Top             =   1155
         Width           =   1245
      End
      Begin VB.Label lblFRAg 
         Caption         =   " Liquidación "
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
         Index           =   3
         Left            =   120
         TabIndex        =   28
         Top             =   1995
         Width           =   1245
      End
      Begin VB.Label lblFRAg 
         Caption         =   " Fijación"
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
         Index           =   2
         Left            =   120
         TabIndex        =   27
         Top             =   795
         Width           =   1245
      End
   End
   Begin VB.Frame fraMoneda 
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2220
      Left            =   45
      TabIndex        =   1
      Top             =   495
      Width           =   3825
      Begin BACControles.TXTNumero txtCapital 
         Height          =   315
         Left            =   1080
         TabIndex        =   5
         Top             =   1770
         Width           =   2535
         _ExtentX        =   4471
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txtValor 
         Height          =   315
         Left            =   1080
         TabIndex        =   4
         Top             =   1380
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
         Min             =   "0"
         Max             =   "9999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin VB.ComboBox cmbMoneda 
         Height          =   315
         Left            =   1080
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   1005
         Width           =   2535
      End
      Begin VB.OptionButton optVenta 
         Caption         =   "&Venta"
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
         Left            =   2040
         Style           =   1  'Graphical
         TabIndex        =   2
         Top             =   225
         Width           =   1440
      End
      Begin VB.OptionButton optCompra 
         Caption         =   "&Compra"
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
         Left            =   360
         Style           =   1  'Graphical
         TabIndex        =   0
         Top             =   225
         Value           =   -1  'True
         Width           =   1395
      End
      Begin VB.Label lblFRAg 
         AutoSize        =   -1  'True
         Caption         =   " &Monto "
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
         Left            =   135
         TabIndex        =   24
         Top             =   1860
         Width           =   660
      End
      Begin VB.Label lblFRAg 
         AutoSize        =   -1  'True
         Caption         =   "Valor "
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
         Left            =   180
         TabIndex        =   23
         Top             =   1455
         UseMnemonic     =   0   'False
         Width           =   510
      End
      Begin VB.Label lblFRAg 
         AutoSize        =   -1  'True
         Caption         =   "&Moneda "
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
         Left            =   180
         TabIndex        =   22
         Top             =   1050
         Width           =   750
      End
   End
   Begin VB.Frame fraCliente 
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2220
      Left            =   3870
      TabIndex        =   42
      Top             =   495
      Width           =   5190
      Begin BACControles.TXTNumero txtRut 
         Height          =   315
         Left            =   1680
         TabIndex        =   6
         Top             =   240
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
         Text            =   "0"
         Text            =   "0"
      End
      Begin VB.ComboBox cmbOperador 
         Height          =   315
         Left            =   1665
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   945
         Width           =   3390
      End
      Begin VB.TextBox txtObser 
         Height          =   390
         Left            =   1650
         MultiLine       =   -1  'True
         TabIndex        =   9
         Top             =   1725
         Width           =   3375
      End
      Begin VB.ComboBox cmbCartera 
         Height          =   315
         Left            =   1650
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   1350
         Width           =   2535
      End
      Begin VB.TextBox txtDV 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   3195
         TabIndex        =   45
         Top             =   240
         Width           =   255
      End
      Begin VB.Label lblFRAg 
         AutoSize        =   -1  'True
         Caption         =   " Operador"
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
         Index           =   20
         Left            =   135
         TabIndex        =   50
         Top             =   990
         Width           =   855
      End
      Begin VB.Label lblFRAg 
         AutoSize        =   -1  'True
         Caption         =   " Observaciones ..."
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
         Left            =   120
         TabIndex        =   47
         Top             =   1815
         Width           =   1575
      End
      Begin VB.Label lblFRAg 
         AutoSize        =   -1  'True
         Caption         =   " Cartera "
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
         Index           =   15
         Left            =   120
         TabIndex        =   46
         Top             =   1395
         Width           =   750
      End
      Begin VB.Label lblCliente 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Nombre de Cliente"
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
         Left            =   120
         TabIndex        =   44
         Top             =   600
         Width           =   4905
      End
      Begin VB.Label lblFRAg 
         AutoSize        =   -1  'True
         Caption         =   " &Cliente "
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
         Left            =   120
         TabIndex        =   43
         Top             =   285
         Width           =   720
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   0
      Top             =   0
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
            Picture         =   "bacFRA.frx":0442
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacFRA.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacFRA.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacFRA.frx":0D90
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "bacOpeFRA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim SQL$, Datos(), i&
Dim Asoc(), iAsoc%
Public giFRA%

Private objFRA      As New clsFRA
Private ObjCliente  As New clsCliente
Private objMoneda   As New ClsMoneda
Private objFPago  As New clsForPago

Dim nNumoper   As Integer
Dim cOperSwap  As String

Dim lLoadForm  As Boolean
Dim ValorAnt As String
Dim ValorUlt As String
Dim nPaisOrigen As Integer

Private Sub SacarValoresFRA(cadena As String)
   
    cadena = 1 & "; " & "Cartera: " & (cmbCartera) & ";" _
    & "Tipo Op: " & IIf(optCompra.Value = True, "C", "V") & ";" _
    & "Cod Cliente: " & Val(TxtDv.Tag) & ";" & "Rut Cli: " & TxtRut.Text & ";" _
    & "Moneda: " & Trim(CMBMoneda) & ";" _
    & "Capital: " & txtCapital.Text & ";" _
    & "Fecha Contrato: " & fecContrato.Text & ";" & "Fecha Inicio: " & FecFijacion.Text & ";" & "FechaTermino: " & FecVencimiento.Text & ";" _
    & "Fecha liquidacion: " & fecLiquidacion.Text & ";" _
    & "Periodo:" & Trim(Left(cmbPlazo, 30)) & ";" _
    & "Tasa:" & Trim(Left(cmbTasa.Text, 50)) & ";" _
    & "Operador :" & Left(gsBAC_User$, 10) & ";" & "Cod Oper :" & SacaCodigo(CmbOperador) & ";" _
    & "Tasa Contrato :" & txtTasa.Text & ";" _
    & "Tasa Hoy :" & txtTasaHoy.Tag & ";" _
    & "PagMoneda :" & Trim(cmbMonedaPago) & ";" & "PagDocumento :" & Trim(CMBFPago) & ";" _

    
End Sub


Private Function Define_Termino(Optional lDefinir)

    '---- Periodo Forward
    If Not IsMissing(lDefinir) Then
        objFRA.PlazoFwd = objFRA.dPeriodo
    
    ElseIf (objFRA.PlazoFwd < 0 Or txtPlazo.Text < 0) And Not lLoadForm Then
        If MsgBox("Desea que el Plazo Forward sea generado automáticamente según Tasa", vbYesNo, "Definición de Período...") = vbYes Then
            objFRA.PlazoFwd = objFRA.dPeriodo
        Else
            objFRA.PlazoFwd = 0
        End If
    End If
    
    '---- Fecha Termino
    objFRA.fecTermino = DateAdd("d", objFRA.PlazoFwd, objFRA.fecInicio)
    If Not BacEsHabil(objFRA.fecTermino) Then
        objFRA.fecTermino = BacProxHabil(objFRA.fecTermino)
    End If
    
    objFRA.PlazoFwd = DateDiff("d", objFRA.fecInicio, objFRA.fecTermino)
    
End Function





Private Function CalculaDiferencial() As Double
Dim nCapital#, nPlazo%, nDifInt#
Dim nTasaFija#, nBaseFija%, nIntFija#
Dim nTasaVar#, nBaseVar%, nIntVar#
Dim sFormat$

    nCapital = CDbl(txtCapital.Tag)
    nPlazo = Val(txtPlazo.Text)
    
       nTasaFija = CDbl(txtTasa.Tag)
    nBaseFija = 360      '---- PENDIENTE cambiar por solicitud a Usuario por Pantalla
    nIntFija = nCapital * BacDiv(nTasaFija, nBaseFija * 100#) * nPlazo
    nIntFija = BacDiv(nIntFija, 1 + BacDiv(nTasaFija, nBaseFija * 100#) * nPlazo)
    
    nTasaVar = CDbl(txtTasaHoy.Tag)
    nBaseVar = 360      '---- PENDIENTE cambiar por solicitud a Usuario por Pantalla
    nIntVar = nCapital * BacDiv(nTasaVar, nBaseVar * 100#) * nPlazo
    nIntVar = BacDiv(nIntVar, 1 + BacDiv(nTasaVar, nBaseVar * 100#) * nPlazo)
        
    sFormat = "#,##0"
    If txtTasa.CantidadDecimales > 0 Then
        sFormat = sFormat & "." & String(txtTasa.CantidadDecimales, "0")
    End If
    
    '---- Diferencial de Intereses por Tasas
    txtDiferencial.Tag = (nIntVar - nIntFija) * IIf(optCompra.Value, 1, -1)
        
    '---- Diferencial en Pesos
    txtDiferencial1.Tag = Round(CDbl(txtDiferencial.Tag) * CDbl(txtValor.Tag), 0)

   If CDbl(txtDiferencial1.Tag) < 0 Then
        txtDiferencial1.ForeColor = vbRed
        txtDiferencial.ForeColor = vbRed
     Else
        txtDiferencial1.ForeColor = vbBlack
        txtDiferencial.ForeColor = vbBlack
    End If
   
    txtDiferencial1.Text = Abs(txtDiferencial1.Tag) 'Format(Abs(txtDiferencial1.Tag), "#,##0.0000")  ' sFormat)
    txtDiferencial.Text = Abs(txtDiferencial.Tag) ' Format(Abs(txtDiferencial.Tag), "#,##0.0000")
        
    lblFRAg(16).Caption = lblFRAg(16).Tag
    
End Function
'-----------------------------
' Carga combos exclusivamente para FRA
Private Function CargaCombosFRA(oCombo As Object, sTabla$, sCondicion$)

    oCombo.Clear
    oCombo.Enabled = True
    
    Select Case UCase(Trim(sTabla))
    Case "MONEDA", "MONEDAS"
    '    Call CargaCombos(oCombo, OP_FRA, "PCS", "sp_LeerMonedasProducto", 0, 2, 1)
        objMoneda.CargaxProducto OP_FRA, oCombo
    
        
    Case "TASA", "TASAS"
        If Val(sCondicion) <= 0 Then
            sCondicion = "13"
        End If
        '------------ Tasas por Moneda
        objMoneda.CargaTasas Val(sCondicion), oCombo
        
        '------------ Quitar FIJA
        oCombo.ListIndex = -1
        Call bacBuscarCombo(oCombo, 0)
        If oCombo.ListIndex >= 0 Then
            oCombo.RemoveItem oCombo.ListIndex
        End If
    
    Case "PERIODO", "PERIODOS"
        Call LlenaComboAmortiza(oCombo, 1044, Sistema)
       

    Case "FPAGO", "FPAGOS"
        If Val(sCondicion) <= 0 Then
            sCondicion = "13"
            
        ElseIf IsMonedaNacional(Val(sCondicion)) Then
            sCondicion = "999"
            
        End If
        '------------ Documentos de Pago
      '  Call LlenaMonDocPago(oCombo, Asoc, 1, Val(sCondicion), iAsoc, 2)
        objFPago.CargaxMoneda Val(sCondicion), 0, oCombo
      
        
    Case "CARTERA", "CARTERAS", "CARTERASINVERSION", "CARTERAINVERSION"
        Call LlenaComboCodGeneral(oCombo, 1004, Sistema, 1)
       
    Case Else
        oCombo.AddItem "<< No Table >>"
        oCombo.Enabled = False
        
    End Select
    If oCombo.ListCount - 1 >= 0 Then
        oCombo.ListIndex = 0
    End If
    
End Function
'-----------------------------
' Retorna valor de Moneda segun fecha solicitada (yyyymmdd)
Private Function ValorMoneda(iMoneda%, sFecha$) As Double

    ValorMoneda = 0#
    
    If iMoneda = 999 Then
        ValorMoneda = 1
        Exit Function
    End If
    
    'Sql = "EXECUTE " & giSQL_DatabaseCommon & "..sp_ValoresMonedas "
    'Sql = Sql & "'" & sFecha & "', " & iMoneda
    
    objMoneda.LeerxCodigo iMoneda
    
    ValorMoneda = Format(objMoneda.vmValor, "#,##0.00")
    
    
'    If MISQL.SQL_Execute(Sql) <> 0 Then
'        'MsgBox "Valor de Moneda " & iMoneda & " No pudo ser leida", vbExclamation + vbOKOnly
'    Else
'        If MISQL.SQL_Fetch(DATOS) = 0 Then
'            ValorMoneda = Val(DATOS(2))
'        Else
'            ValorMoneda = 1#
'        End If
'    End If

End Function
'-----------------------------
' Retorna valor de Tasa segun fecha solicitada (yyyymmdd) y periodo
Private Function ValorTasa(iMoneda%, iTasa%, iPlazo%, sFecha$) As Double

    ValorTasa = 0#
    
    Select Case iPlazo
    Case 30
        iPlazo = 4
    Case 90
        iPlazo = 3
    Case 180
        iPlazo = 2
    Case 365
        iPlazo = 1
    End Select
    
    SQL = "EXECUTE " & giSQL_DatabaseCommon & "..view_moneda_tasa "
    SQL = "SELECT tasa FROM view_moneda_tasa "
    SQL = SQL & " WHERE fecha = '" & sFecha & "'"
    SQL = SQL & "   AND codmon = " & iMoneda
    SQL = SQL & "   AND codtasa = " & iTasa
    SQL = SQL & "   AND periodo = " & iPlazo
    If MISQL.SQL_Execute(SQL) = 0 Then
        If MISQL.SQL_Fetch(Datos) = 0 Then
            ValorTasa = Val(Datos(1))
        End If
    End If

End Function

Private Sub btnGrabar_Click()

      If Not ChequeaCierreMesa() Then
          
        MsgBox "No se puede Grabar Operacion, Mesa de Dinero está Cerrada!!!", vbExclamation, Msj
        Exit Sub
      End If

    
        SQL = ""
        If CMBMoneda.Tag = "" Then
            SQL = SQL & vbCrLf & "- Moneda"
        ElseIf CDbl(txtValor.Tag) = 0 Then
            SQL = SQL & vbCrLf & "- Valor de Moneda esta en CERO"
        End If
        
        If CDbl(txtCapital.Tag) = 0 Then
            SQL = SQL & vbCrLf & "- Monto Capital"
        End If
        
        If CMBMoneda.Tag = "" Then
            SQL = SQL & vbCrLf & "- Moneda"
        End If
        
        If cmbTasa.Tag = "" Then
            SQL = SQL & vbCrLf & "- Tasa Contrato"
        ElseIf CDbl(txtTasa.Tag) = 0 And SQL = "" Then
            If MsgBox("Valor Tasa Contrato esta en CERO" & vbCrLf & "¿ Continua ?", vbQuestion + vbYesNo) <> vbYes Then
                Exit Sub
            End If
        End If
        
        If cmbPlazo.Tag = "" Then
            SQL = SQL & vbCrLf & "- Plazo"
        End If
        
        If CMBFPago.Tag = "" Then
            SQL = SQL & vbCrLf & "- Documento de Pago"
        End If

        If cmbCartera.Tag = "" Then
            SQL = SQL & vbCrLf & "- Cartera de Inversiones"
        End If

        '---- Cliente
        If Val(TxtRut.Tag) <= 0 Then
            SQL = SQL & vbCrLf & "- Cliente"
        End If
        
        '---- Control de Fechas
        If Not BacEsHabil(fecContrato.Text) Then
            SQL = SQL & "- Fecha Cierre del Contrato, no es un día hábil"
        End If
        If Not BacEsHabil(FecFijacion.Text) Then
            SQL = SQL & "- Fecha de Fijación, no es un día hábil"
        End If
        If Not BacEsHabil(fecLiquidacion.Text) Then
            SQL = SQL & "- Fecha de Liquidación, no es un día hábil"
        End If
        If Not BacEsHabil(FecVencimiento.Text) Then
            SQL = SQL & "- Fecha de Vencimiento, no es un día hábil"
        End If
        
        If Len(SQL) > 0 Then
            MsgBox "Falta la siguiente información ..." & vbCrLf & SQL, vbOKOnly, "Control de Datos"
            Exit Sub
        End If
        
        If MsgBox("¿ Seguro de Grabar ?", vbQuestion + vbYesNo) = vbYes Then
        
            Call SacarValoresFRA(ValorUlt)
        
            objFRA.Limpiar
            objFRA.Numero_Operacion = IIf(cOperSwap = "Ingreso", Val(Me.Tag), etqNumero.Tag)
            objFRA.Tipo_Operacion = IIf(optCompra.Value, "C", "V")
            
            objFRA.iCartera = cmbCartera.Tag
            objFRA.sCartera = Trim(Left(cmbCartera.Text, 50))
            
            objFRA.iMoneda = CMBMoneda.Tag
            objFRA.sMoneda = Trim(Left(CMBMoneda.Text, 50))
            objFRA.dMoneda = txtValor.Tag
            
            objFRA.Capital = txtCapital.Tag
            objFRA.CapitalUSD = txtCapital.Tag
            objFRA.CapitalCLP = txtCapital.Tag
            
            objFRA.fecContrato = fecContrato.Text
            objFRA.fecLiquida = fecLiquidacion.Text
            objFRA.fecInicio = FecFijacion.Text
            objFRA.fecTermino = FecVencimiento.Text
            
            objFRA.iTasa = cmbTasa.Tag
            objFRA.sTasa = Trim(Left(cmbTasa.Text, 50))
            objFRA.dTasa = txtTasaHoy.Tag
            
            objFRA.iPeriodo = Val(Trim(Right(cmbPlazo, 10)))  'Right(cmbPlazo.ItemData(cmbPlazo.ListIndex), 3)
            objFRA.sPeriodo = Trim(Left(cmbPlazo.Text, 50))
            objFRA.mPeriodo = cmbPlazo.Tag
            
            objFRA.TasaContrato = txtTasa.Tag
            
            '-- Moneda de Pago
            objFRA.iMPago = Val(cmbMonedaPago.Tag)
'            If IsMonedaNacional(objFRA.iMPago) Then
'                objFRA.iMPago = 999
'            End If
            objFRA.sMPago = Glosas("MONEDA", objFRA.iMPago)
            
            '-- Forma de Pago
            objFRA.iFPago = CMBFPago.Tag
            objFRA.sFPago = Trim(Left(CMBFPago.Text, 50))
            
            objFRA.iEstado = IIf(objFRA.Numero_Operacion = 0, 0, 1)
            objFRA.sEstado = Glosas("GRABAR", objFRA.iEstado)
            
            '-- Cliente
            objFRA.Rut = Val(TxtRut.Tag)   '--- Codigo de Cliente
            objFRA.CodCliente = Val(TxtDv.Tag)

            objFRA.OperadorCliente = SacaCodigo(CmbOperador)                                   'Codigo del Operador


            SQL = "BEGIN TRANSACTION"
    
            If MISQL.SQL_Execute(SQL) <> 0 Then
                Exit Sub
            End If

            If cOperSwap = "Modificacion" Then
               Call Lineas_Anular(Sistema, CDbl(objFRA.Numero_Operacion))  'Primero Anula Monto Anterior
                
                'jcamposd IMPORTANTE : Se implementa función pero este frm no es utilizado
                '+++CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
                
                Dim oParametrosLineaAnulaFra As New clsControlLineaIDD
                
                With oParametrosLineaAnulaFra
                        .Modulo = Sistema
                        .Producto = 3 '--TipoOperacion
                        .Operacion = CDbl(objFRA.Numero_Operacion)
                        .Documento = CDbl(objFRA.Numero_Operacion)
                        .Correlativo = 0
                        .Accion = "R"
                
                        .RecuperaDatosLineaIDD
                        If .numeroiddAnula <> 0 Then
                            .EjecutaProcesoWsLineaIDD
                        End If
                End With
                Set oParametrosLineaAnulaFra = Nothing
                On Error GoTo seguirProcesoAnulaFra
                '---CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
            End If
            
seguirProcesoAnulaFra:

            If gsBac_Lineas = "S" Then

                 Dim Mensaje     As String
                 Dim cCheque     As String
                 Dim nRutCheque  As Double
                 Dim Mensaje_Con As String
                 Dim SwResp      As Integer
                 Dim CodMonOp1    As Double
                 Dim MercadoLc   As String
               
                 Dim Mensaje_Lin As String
                 Dim Mensaje_Lim As String
                 Dim MontoCapDolar As Double
                 Dim CodMonOp    As Integer
         
                 'MontoCap = CDbl(txtCapital.Text)
                 CodMonOp = SacaCodigo(CMBMoneda)
                  
                 MontoCapDolar = ValorMontoADolar(CDbl(txtCapital.Text), CodMonOp, gsBAC_Fecp)
         
                 cCheque = "N"
                 nRutCheque = 0
         
                 Mensaje = ""
                     
                 If Not Lineas_ChequearGrabar(Sistema, 3, CDbl(objFRA.Numero_Operacion), 0, 0, _
                                              CDbl(objFRA.Rut), CDbl(objFRA.CodCliente), MontoCapDolar, 0, _
                                              CDate(FecVencimiento.Text), 0, 0, CDate(gsBAC_Fecp), 0, "N", _
                                              CDbl(CodMonOp), "C", 0, cCheque, nRutCheque, _
                                              CDate(gsBAC_Fecp), 0, CMBFPago.Tag, 0, 0) Then 'PROD-10967
                 
                     SQL = "ROLLBACK TRANSACTION"
                     If MISQL.SQL_Execute(SQL) <> 0 Then
                         MsgBox "Problemas en Procedimientos de Lineas", vbCritical, Msj
                         Exit Sub
                     End If
                    Exit Sub
                 End If
                         
                 If nPaisOrigen = 6 Then
                    MercadoLc = "S"
                 Else
                    MercadoLc = "N"
                 End If
                    
                 'Prechequeo de los Límites
                 Mensaje_Con = Lineas_ConsultaOperacion(Sistema, 3, objFRA.Numero_Operacion, " ", cCheque, MercadoLc)
                                    
                 If Trim(Mensaje_Con) <> "" Then
''                    SwResp = MsgBox("ATENCION" & vbCrLf & "LA OPERACION GENERARA LOS SIGUIENTES ERRORES" & Mensaje_Con & vbCrLf & vbCrLf & "¿Desea Grabar la Operación ?", vbYesNo + vbExclamation, TITSISTEMA)
                    
''                    If SwResp <> vbYes Then
                      If Not UsuarioConfirma(0, 0, _
                                               "Confirmar Grabación", _
                                               "ATENCION" & vbCrLf & "LA OPERACION GENERARA LOS SIGUIENTES ERRORES" & Mensaje_Con & vbCrLf & vbCrLf & "¿Desea Grabar la Operación ?", _
                                               0.5) Then
                       Call Lineas_BorraConsultaOperacion(Sistema, objFRA.Numero_Operacion)
                       
                        SQL = "ROLLBACK TRANSACTION"
                        If MISQL.SQL_Execute(SQL) <> 0 Then
                            MsgBox "Problemas en Procedimientos de Lineas", vbCritical, Msj
                            Exit Sub
                        End If
                        Exit Sub
                    End If
         
                 End If
                    
                 'Si Acepta y Tiene Errores Sigue Normal
                 Mensaje = Mensaje & Lineas_Chequear(Sistema, 3, objFRA.Numero_Operacion, " ", cCheque, MercadoLc)
                         
                 If Mensaje <> "" Then
                     MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical, Msj
                     SQL = "ROLLBACK TRANSACTION"
                     If MISQL.SQL_Execute(SQL) <> 0 Then
                         Exit Sub
                     End If
                  
                 End If
             
             End If
         
            
            If Not objFRA.Grabar Then
                SQL = "ROLLBACK TRANSACTION"
                If MISQL.SQL_Execute(SQL) <> 0 Then
                    MsgBox "Problemas al deshacer la operación", vbCritical, Msj
                    Exit Sub
                End If
                MsgBox "No terminó proceso de ingreso de datos", vbCritical, Msj
                Exit Sub
                
            End If
            
            If Not Lineas_GrbOperacion(Sistema, 3, objFRA.Numero_Operacion, objFRA.Numero_Operacion, " ", cCheque, MercadoLc) Then
               SQL = "ROLLBACK TRANSACTION"
               If MISQL.SQL_Execute(SQL) <> 0 Then
                  MsgBox "Problemas en Procedimientos al Grabar Lineas Operacion ", vbCritical, Msj
                   Exit Sub
               End If
            Else
                'jcamposd IMPORTANTE : Se implementa función pero este frm no es utilizado
                If MarcaAplicaLinea = 1 Then
                    '+++CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
                    Dim oParametrosLineaFra As New clsControlLineaIDD
                    
                    With oParametrosLineaFra
                        .Modulo = Sistema
                        .Producto = 3
                        .Operacion = objFRA.Numero_Operacion
                        .Documento = objFRA.Numero_Operacion
                        .Correlativo = 0
                        .Accion = "Y"
                    
                        .RecuperaDatosLineaIDD
                        .EjecutaProcesoWsLineaIDD
                    End With
                    Set oParametrosLineaFra = Nothing
                    On Error GoTo seguirprocesoGbrFra
                    '---CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
                End If
            End If
            
seguirprocesoGbrFra:
              
            '********** Linea -- Mkilo
            Mensaje_Lin = ""
            Mensaje_Lim = ""
               
            If gsBac_Lineas = "S" Then
              
                Mensaje_Lin = Lineas_Error(Sistema, objFRA.Numero_Operacion)
                Mensaje_Lim = Limites_Error(Sistema, objFRA.Numero_Operacion)
                
            End If
            
            Envia = Array()
            AddParam Envia, objFRA.Numero_Operacion
            AddParam Envia, Trim(Mensaje_Lin)
            AddParam Envia, Trim(Mensaje_Lim)
            
            If Not Bac_Sql_Execute("SP_GRABAOBSERVACIONLINEAS", Envia) Then
                  MsgBox "Problemas al Grabar Observacion Lineas", vbCritical, Msj
                  SQL = "ROLLBACK TRANSACTION"
                  If MISQL.SQL_Execute(SQL) <> 0 Then
                      MsgBox "Problemas al deshacer la operación", vbCritical, Msj
                      
                      Exit Sub
                  End If
                              
            End If

            SQL = "COMMIT TRANSACTION"
            If MISQL.SQL_Execute(SQL) <> 0 Then
                MsgBox "Problemas al grabar datos", vbCritical, Msj
                Exit Sub
            End If
            
            Call GRABALOG(cOperSwap, "Opc_20300", objFRA.Numero_Operacion, 3, ValorAnt, ValorUlt)
            
'''''            Call ImprimePapeleta(objFRA.Numero_Operacion, 1, "Impresora", OP_FRA)
            Call btnNuevo_Click
        End If

End Sub


Private Sub btnNuevo_Click()
    swOperSwap = "Ingreso"
    Form_Load
End Sub


Private Sub btnSalir_Click()

    Unload Me

End Sub


Private Sub cmbCartera_LostFocus()

    If cmbCartera.ListIndex >= 0 Then
        cmbCartera.Tag = cmbCartera.ItemData(cmbCartera.ListIndex)
    Else
        cmbCartera.Tag = ""
    End If

End Sub

Private Sub cmbFPago_Click()

'Call LlenaMonDocPago(cmbFPago, Asoc(), _
'                                           cmbMonedaPago.Tag, _
'                                           SacaCodigo(cmbMonedaPago), iAsoc, 2)

End Sub

Private Sub cmbFPago_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 Then
'        fecLiquidacion.SetFocus
    ElseIf KeyAscii = 27 Then
        bacBuscarCombo CMBFPago, CMBFPago.Tag
    End If

End Sub

Private Sub cmbFPago_LostFocus()
    
    CMBFPago.Tag = ""
    If CMBFPago.ListIndex >= 0 Then
        CMBFPago.Tag = CMBFPago.ItemData(CMBFPago.ListIndex)
    End If

End Sub

Private Sub cmbMoneda_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        txtCapital.SetFocus
    ElseIf KeyAscii = 27 Then
        bacBuscarCombo CMBMoneda, CMBMoneda.Tag
    End If
End Sub

Private Sub cmbMoneda_LostFocus()
Dim iMouse%

    iMouse = Me.MousePointer
    Me.MousePointer = 11

    If CMBMoneda.ListIndex >= 0 Then
        If Val(CMBMoneda.Tag) <> CMBMoneda.ItemData(CMBMoneda.ListIndex) Then
            CMBMoneda.Tag = CMBMoneda.ItemData(CMBMoneda.ListIndex)
        End If
    Else
        CMBMoneda.Tag = ""
    End If
    
    '---- Trae Valor de Moneda
    txtValor.Tag = ValorMoneda(Val(CMBMoneda.Tag), FechaYMD(gsBAC_Fecp))
    txtValor.Text = Format(txtValor.Tag, "###,###,##0.00")
    txtValor.Enabled = (Val(txtValor.Tag) = 0)
    
    '---- Decimales de Capital
    Select Case Val(CMBMoneda.Tag)
    Case 999
        txtCapital.CantidadDecimales = 0
    Case 998
        txtCapital.CantidadDecimales = 4
    Case Else
        txtCapital.CantidadDecimales = 2
    End Select
    
    txtCapital.Text = Val(txtCapital.Tag)
    
    '---- Tasas para Moneda
    CargaCombosFRA cmbTasa, "TASAS", Val(CMBMoneda.Tag)
    bacBuscarCombo cmbTasa, Val(cmbTasa.Tag)
    cmbTasa_LostFocus
    
    '---- Periodo
    CargaCombosFRA cmbPlazo, "PERIODOS", Val(cmbTasa.Tag)
    bacBuscarCombo cmbPlazo, Val(cmbPlazo.Tag)
    cmbPlazo_LostFocus
    
    '---- Documentos de Pago
  '  CargaCombosFRA cmbFPago, "FPAGOS", Val(cmbMoneda.Tag)
  '  bacBuscarCombo cmbFPago, Val(cmbFPago.Tag)
  '  cmbFPago_LostFocus
  Call LlenaMonDocPago(cmbMonedaPago, Asoc(), 1, _
                    CMBMoneda.Tag, iAsoc, 1)
                    
    '---- Indica en Frame que tipo de FRA es y Calcula Diferencial
    If optCompra.Value Then
        optCompra_LostFocus
    Else
        optVenta_LostFocus
    End If
    
    Me.MousePointer = iMouse
    
End Sub

Private Sub cmbMonedaPago_Click()

Call LlenaMonDocPago(CMBFPago, Asoc(), _
                                           Val(cmbMonedaPago.Tag), _
                                           SacaCodigo(cmbMonedaPago), iAsoc, 2)
    
End Sub


Private Sub cmbMonedaPago_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        CMBFPago.SetFocus
    End If


End Sub

Private Sub cmbMonedaPago_LostFocus()
    
    cmbMonedaPago.Tag = 0
    If cmbMonedaPago.ListIndex >= 0 Then
        cmbMonedaPago.Tag = cmbMonedaPago.ItemData(cmbMonedaPago.ListIndex)
    End If
    
End Sub

Private Sub cmbPlazo_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        cmbMonedaPago.SetFocus
    End If
End Sub

Private Sub cmbPlazo_LostFocus()
    cmbPlazo.Tag = ""
    If cmbPlazo.ListIndex >= 0 Then
        cmbPlazo.Tag = Val(Right(cmbPlazo.ItemData(cmbPlazo.ListIndex), 3)) ' cmbPlazo.ItemData(cmbPlazo.ListIndex)
    End If
    txtTasaHoy.Tag = 3.85 'ValorTasa(Val(cmbMoneda.Tag), Val(cmbTasa.Tag), Val(cmbPlazo.Tag), Format(fecContrato.Text, "yyyymmdd"))
    txtTasaHoy.Text = txtTasaHoy.Tag
    '----- Definiendo Plazo
    If Val(txtPlazo.Tag) = 0 Then
        FecVencimiento.Text = Format(DateAdd("d", cmbPlazo.Tag, FecFijacion.Text), "dd/mm/yyyy")
    End If
    fecFijacion_LostFocus
    Call CalculaDiferencial
End Sub

Private Sub cmbTasa_Change()
    cmbTasa_LostFocus
End Sub

Private Sub cmbTasa_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        cmbPlazo.SetFocus
    ElseIf KeyAscii = 27 Then
        bacBuscarCombo cmbTasa, cmbTasa.Tag
    End If
End Sub

Private Sub cmbTasa_LostFocus()
    cmbTasa.Tag = 0
    If cmbTasa.ListIndex >= 0 Then
        cmbTasa.Tag = cmbTasa.ItemData(cmbTasa.ListIndex)
    End If
    'iMoneda%, iTasa%, iPlazo%, sFecha$
    If Len(Trim(txtTasa.Tag)) = 0 Then
        txtTasa.Tag = ValorTasa(Val(CMBMoneda.Tag), Val(cmbTasa.Tag), Val(cmbPlazo.Tag), Format(gsBAC_Fecp, "yyyymmdd"))
        txtTasa.Text = txtTasa.Tag
    End If
    Call CalculaDiferencial
End Sub

Private Sub etqNumOper_Change()

End Sub

Private Sub fecContrato_Change()
lblFecha(3).Caption = Format(fecContrato.Text, "ddd, dd mmm yyyy")
End Sub

Private Sub fecContrato_LostFocus()
'    lblFecha(3).Caption = Format(fecContrato.Text, "ddd, dd mmm yyyy")
End Sub

Private Sub fecContrato_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        FecFijacion.SetFocus
    End If
End Sub

Private Sub fecFijacion_Change()
'If CDate(FecFijacion.Text) < CDate(fecContrato.Text) And Not lLoadForm Then
'        MsgBox "La fecha de Fijación debe ser posterior a la de Contrato ...", vbInformation
'        FecFijacion.Text = fecContrato.Text
'
'    Else
'        If Not BacEsHabil(FecFijacion.Text) Then
'            If Not lLoadForm Then
'                MsgBox "Fecha No es un dia Hábil, se define próximo día hábil ...", vbExclamation + vbOKOnly
'            End If
'            FecFijacion.Text = BacProxHabil(FecFijacion.Text)
'        End If
'        objFRA.fecInicio = FecFijacion.Text
'
'        '---- Vencimiento
'        Call Define_Termino
'
'        fecLiquidacion.Text = FecFijacion.Text
'
'    End If
    
    lblFecha(0).Caption = Format(FecFijacion.Text, "ddd, dd mmm yyyy")
End Sub

Private Sub fecFijacion_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    ElseIf KeyAscii = 27 Then
        FecFijacion.Text = objFRA.fecInicio
    End If



Exit Sub

    With FecFijacion
        If KeyAscii = 13 Then
            If Val(cmbPlazo.Tag) > 0 And Val(txtPlazo.Tag) <= 0 Then
                txtPlazo.Tag = Val(cmbPlazo.Tag)
            End If
            txtPlazo.Text = txtPlazo.Tag
            FecVencimiento.Text = DateAdd("d", Val(txtPlazo.Tag), FecFijacion.Text)
            FecVencimiento.SetFocus
        ElseIf KeyAscii = 27 Then
            .Text = .Tag
        End If
    End With
End Sub

Private Sub fecFijacion_LostFocus()
If CDate(FecFijacion.Text) < CDate(fecContrato.Text) And Not lLoadForm Then
        MsgBox "La fecha de Fijación debe ser posterior a la de Contrato ...", vbInformation
        FecFijacion.Text = fecContrato.Text

    Else
        If Not BacEsHabil(FecFijacion.Text) Then
            If Not lLoadForm Then
                MsgBox "Fecha No es un dia Hábil, se define próximo día hábil ...", vbExclamation + vbOKOnly
            End If
            FecFijacion.Text = BacProxHabil(FecFijacion.Text)
        End If
        objFRA.fecInicio = FecFijacion.Text

        '---- Vencimiento
        Call Define_Termino

        fecLiquidacion.Text = FecFijacion.Text

    End If
    


    With FecFijacion
        lblFecha(0).Caption = Format(.Text, "ddd, dd mmm yyyy")
        If Not BacEsHabil(.Text) Then
            MsgBox "Fecha No es un dia Hábil", vbExclamation + vbOKOnly
            .Text = BacProxHabil(.Text)
        End If
        .Tag = .Text
        fecLiquidacion.Text = .Text
        fecLiquidacion.Tag = .Tag
        txtPlazo.Tag = DateDiff("d", FecFijacion.Text, FecVencimiento.Text)
        If Val(txtPlazo.Tag) < 0 Then
            lblFecha(0).Caption = Format(.Text, "ddd, dd mmm yyyy")
            FecVencimiento.Text = .Text
            txtPlazo.Tag = 0
        End If
        txtPlazo.Text = txtPlazo.Tag
        fecVencimiento_LostFocus
        '-------------------------------- Liquidación
        fecLiquidacion.MaxDate = Format(FecVencimiento.Text, "dd/mm/yyyy")
        fecLiquidacion.MinDate = .Text
        fecLiquidacion.Text = .Text
        fecLiquidacion.Tag = .Text
        fecLiquidacion_LostFocus
    End With
End Sub

Private Sub fecLiquidacion_Change()

 If Not BacEsHabil(fecLiquidacion.Text) Then
        If Not lLoadForm Then
            MsgBox "Fecha No es hábil, se define próximo día Hábil de Liquidación", vbExclamation + vbOKOnly
        End If
        fecLiquidacion.Text = BacProxHabil(fecLiquidacion.Text)
    End If
    objFRA.fecLiquida = fecLiquidacion.Text
    
    lblFecha(1).Caption = Format(fecLiquidacion.Text, "ddd, dd mmm yyyy")


End Sub

Private Sub fecLiquidacion_KeyPress(KeyAscii As Integer)
    
If KeyAscii = 13 Then
        SendKeys "{TAB}"
    ElseIf KeyAscii = 27 Then
        fecLiquidacion.Text = objFRA.fecLiquida
    End If
    
Exit Sub

    With fecLiquidacion
        If KeyAscii = 13 Then
            txtCapital.SetFocus
        ElseIf KeyAscii = 27 Then
            .Text = .Tag
        End If
    End With
End Sub

Private Sub fecLiquidacion_LostFocus()
    With fecLiquidacion
        lblFecha(1).Caption = Format(.Text, "ddd, dd mmm yyyy")
        If Not BacEsHabil(.Text) Then
            MsgBox "Fecha pertenece a un día No hábil", vbExclamation + vbOKOnly
            .Text = .Tag
        End If
        If DateDiff("d", FecFijacion.Text, .Text) < 0 Then
            MsgBox "Período Forward no corresponde", vbExclamation + vbOKOnly
            .Text = .Tag
        End If
        .Tag = .Text
        lblFecha(1).Caption = Format(.Text, "ddd, dd mmm yyyy")
    End With
End Sub

Private Sub fecVencimiento_Change()

    If CDate(FecVencimiento.Text) < CDate(FecFijacion.Text) And Not lLoadForm Then
        MsgBox "La fecha de Vencimiento debe ser posterior a la de Fijación ...", vbInformation
        FecVencimiento.Text = FecFijacion.Text
        
    Else
        
        If Not BacEsHabil(FecVencimiento.Text) Then
            If Not lLoadForm Then
                MsgBox "Fecha No es un día Hábil, se define próximo día hábil ...", vbInformation, "FRA"
            End If
            FecVencimiento.Text = BacProxHabil(FecVencimiento.Text)
        End If
        
        objFRA.fecTermino = FecVencimiento.Text
        objFRA.PlazoFwd = DateDiff("d", objFRA.fecInicio, objFRA.fecTermino)
        
        txtPlazo.Text = objFRA.PlazoFwd

    End If
    
    lblFecha(2).Caption = Format(FecVencimiento.Text, "ddd, dd mmm yyyy")
    
End Sub

Private Sub fecVencimiento_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    ElseIf KeyAscii = 27 Then
        FecVencimiento.Text = objFRA.fecTermino
    End If

Exit Sub
    
    With FecVencimiento
        If KeyAscii = 13 Then
            cmbTasa.SetFocus
        ElseIf KeyAscii = 27 Then
            .Text = .Tag
        End If
    End With
End Sub

Private Sub fecVencimiento_LostFocus()

Exit Sub

    With FecVencimiento
        '---- Periodo Forward
        If DateDiff("d", FecFijacion.Text, FecVencimiento.Text) < 0 Then
            MsgBox "Período Forward no corresponde", vbCritical, "FRA"
        End If
        txtPlazo.Text = txtPlazo.Tag
        FecVencimiento.Text = DateAdd("d", txtPlazo.Tag, FecFijacion.Text)
        '---- Fecha Vencimiento
        lblFecha(2).Caption = Format(.Text, "ddd, dd mmm yyyy")
        If Not BacEsHabil(.Text) Then
            'MsgBox "Fecha pertenece a Fin de Semana", vbExclamation + vbOKOnly
            .Text = BacProxHabil(.Text)
            '.Text = .Tag
        End If
        .Tag = .Text
        lblFecha(2).Caption = Format(.Text, "ddd, dd mmm yyyy")
        txtPlazo.Text = DateDiff("d", FecFijacion.Text, FecVencimiento.Text)
        txtPlazo.Tag = txtPlazo.Text
    End With
End Sub

Private Sub Form_Activate()
Tipo_Producto = "FR"
End Sub

Private Sub Form_Load()

    Me.MousePointer = 11
Tipo_Producto = "FR"
    cOperSwap = swOperSwap
    nNumoper = swModNumOpe
    swOperSwap = ""

    '---- PENDIENTE cambiar a codigo 3 (too table)
    giFRA = OP_FRA
    lLoadForm = True

    If WindowState = 0 Then
        Top = 1
        Left = 15
    End If
    
    '---- Formulario
    optCompra.Value = True
    TxtRut.Tag = 0
    TxtRut.Text = 0
    TxtDv.Text = ""
    TxtDv.Tag = 0
    txtCapital.Tag = 0
    txtTasaHoy.Tag = 0
    cmbPlazo.Tag = 0
    txtPlazo.Tag = 0
    txtPlazo.Text = 0
    nPaisOrigen = 0

    CargaCombosFRA CMBMoneda, "Monedas", ""
    
    Call MonYDocxMoneda(Asoc(), iAsoc)
    
    cmbMoneda_LostFocus
    
    '---- Carteras de Inversion
    CargaCombosFRA cmbCartera, "Carteras", ""
    cmbCartera_LostFocus
    
    If cOperSwap = "Ingreso" Then
        Me.Tag = 0
        etqNumero.Visible = False
        etqNumero.Tag = "0"
        fecContrato.Text = gsBAC_Fecp
    
        FecFijacion.Text = gsBAC_Fecp
        fecFijacion_LostFocus
        
        fecLiquidacion.Text = gsBAC_Fecp
        fecLiquidacion_LostFocus
        
        FecVencimiento.Text = gsBAC_Fecp
        fecVencimiento_LostFocus
        
        txtTasa.Text = 0
        Call CalculaDiferencial
    Else
        etqNumero.Visible = True
        etqNumero.Tag = nNumoper
        etqNumero.Caption = "Modificación Operación N°: " & nNumoper
        
        If objFRA.Leer(Str(nNumoper), 2) Then
        
            Me.Tag = objFRA.Numero_Operacion
            optCompra.Value = IIf(objFRA.Tipo_Operacion = "C", True, False)
            
            cmbCartera.Tag = objFRA.iCartera
            Call bacBuscarCombo(cmbCartera, objFRA.iCartera)
            
            fecContrato.Text = Format(objFRA.fecContrato, "dd/mm/yyyy")
            fecContrato_LostFocus
            fecLiquidacion.Text = Format(objFRA.fecLiquida, "dd/mm/yyyy")
            lblFecha(1).Caption = Format(fecLiquidacion.Text, "ddd, dd mmm yyyy")
            FecFijacion.Text = Format(objFRA.fecInicio, "dd/mm/yyyy")
            lblFecha(0).Caption = Format(FecFijacion.Text, "ddd, dd mmm yyyy")
            FecVencimiento.Text = Format(objFRA.fecTermino, "dd/mm/yyyy")
            lblFecha(2).Caption = Format(FecVencimiento.Text, "ddd, dd mmm yyyy")
            txtPlazo.Tag = DateDiff("d", FecFijacion.Text, FecVencimiento.Text)
            txtPlazo.Text = txtPlazo.Tag

            Call bacBuscarCombo(CMBMoneda, objFRA.iMoneda)
            cmbMoneda_LostFocus
            
            txtCapital.Tag = objFRA.Capital
            txtCapital.Text = objFRA.Capital
            
            
            cmbTasa.Tag = objFRA.iTasa
            Call bacBuscarCombo(cmbTasa, objFRA.iTasa)
            
            '----- Asignando Plazo
            cmbPlazo.Tag = objFRA.iPeriodo
            Call BuscaCmbAmortiza(cmbPlazo, objFRA.iPeriodo)
     
            
            txtTasa.Tag = objFRA.TasaContrato
            txtTasa.Text = objFRA.TasaContrato
                   
            '-- Forma de Pago
                        
            CMBMoneda.Tag = objFRA.iMoneda
            
            txtTasaHoy.Tag = ValorTasa(Val(CMBMoneda.Tag), Val(cmbTasa.Tag), Val(cmbPlazo.Tag), Format(gsBAC_Fecp, "yyyymmdd"))
            txtTasaHoy.Text = txtTasaHoy.Tag
            
            '-- Cliente
            TxtRut.Text = objFRA.Rut '--- Codigo de Cliente
            TxtDv.Text = objFRA.Dv
            TxtRut.Tag = objFRA.Rut
            TxtDv.Tag = objFRA.CodCliente
            
     
            Call bacBuscarCombo(cmbMonedaPago, objFRA.iMPago)
            cmbMonedaPago_Click
     
            Call bacBuscarCombo(CMBFPago, Val(objFRA.iFPago))
            Call CalculaDiferencial

            Call SacarValoresFRA(ValorAnt)

            Dim Cli As New clsCliente
            If Cli.LeerxRut(objFRA.Rut, objFRA.CodCliente) Then
                lblCliente.Caption = Cli.clnombre
                nPaisOrigen = Cli.clPais
            End If
            Set Cli = Nothing

            If objFRA.OperadorCliente <> 0 Then
                Call Operadores(CmbOperador, objFRA.Rut, objFRA.CodCliente)
                Call bacBuscarCombo(CmbOperador, objFRA.OperadorCliente)
            End If

            If Not ChequeaCierreMesa() Then
               Toolbar1.Buttons(1).Enabled = False
               Toolbar1.Buttons(2).Enabled = False
               MsgBox "Operacion no puede ser Modificada. Mesa ha cerrado!! "
            End If

        End If
        
    End If
    lLoadForm = False
    
    Me.MousePointer = 0
    
End Sub
Private Sub Form_Unload(Cancel As Integer)

    Set objFRA = Nothing
    Set objMoneda = Nothing
    Set ObjCliente = Nothing
    
    If cOperSwap = "ModificacionCartera" Or cOperSwap = "Modificacion" Then
        BacConsultaOper.Show
    End If

End Sub

Private Sub optCompra_Click()
    CMBMoneda.SetFocus
End Sub

Private Sub optCompra_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub optCompra_LostFocus()
    fraMoneda.Caption = "Compra de " & Trim(CMBMoneda)
    fraMoneda.ForeColor = optCompra.ForeColor
    Call CalculaDiferencial
End Sub

Private Sub optVenta_Click()
    CMBMoneda.SetFocus
End Sub

Private Sub optVenta_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub optVenta_LostFocus()
    fraMoneda.Caption = "Venta de " & Trim(CMBMoneda)
    fraMoneda.ForeColor = optVenta.ForeColor
    Call CalculaDiferencial
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)

Select Case Button.Index
   
   Case 1
      Call btnGrabar_Click
   Case 2
      Call btnNuevo_Click
   Case 3
      Unload Me
      
End Select

End Sub

Private Sub txtCapital_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        FecFijacion.SetFocus
    ElseIf KeyAscii = 27 Then
        txtCapital.Text = txtCapital.Tag
        End If
End Sub

Private Sub txtCapital_LostFocus()
    txtCapital.Tag = Format(txtCapital.Text, "0.#")
    Call CalculaDiferencial
End Sub

Private Sub txtPlazo_Change()
Exit Sub


    If txtPlazo.Text < 0 Then
        MsgBox "Período Forward no corresponde", vbInformation, "FRA"
        txtPlazo.Text = txtPlazo.Tag
    End If
End Sub

Private Sub txtPlazo_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 Then
        cmbTasa.SetFocus
    ElseIf KeyAscii = 27 Then
        txtPlazo.Text = objFRA.PlazoFwd
    End If
    
Exit Sub

    If KeyAscii = 13 Then
        cmbTasa.SetFocus
    End If
End Sub

Private Sub txtPlazo_LostFocus()

    If CDbl(txtPlazo.Text) <= 0 Then
        objFRA.PlazoFwd = -1
        Call Define_Termino
        txtPlazo.Text = objFRA.PlazoFwd
    End If
    
    objFRA.PlazoFwd = txtPlazo.Text
    If objFRA.PlazoFwd = 0 Then
        FecVencimiento.Text = objFRA.fecInicio
    Else
        objFRA.fecTermino = DateAdd("d", objFRA.PlazoFwd, objFRA.fecInicio)
        FecVencimiento.Text = Format(objFRA.fecTermino, "dd/mm/yyyy")
    End If


Exit Sub


Dim PlazoPaso As Integer

    txtPlazo.Tag = txtPlazo.Text
    FecVencimiento.Text = DateAdd("d", Val(txtPlazo.Tag), FecFijacion.Text)
    FecVencimiento.Tag = FecVencimiento.Text
    
    lblFecha(2).Caption = Format(FecVencimiento.Text, "ddd, dd mmm yyyy")
    If Not BacEsHabil(FecVencimiento.Text) Then
        'MsgBox "Fecha pertenece a Fin de Semana", vbExclamation + vbOKOnly
        FecVencimiento.Text = BacProxHabil(FecVencimiento.Text)
        FecVencimiento.Tag = FecVencimiento.Text
        lblFecha(2).Caption = Format(FecVencimiento.Text, "ddd, dd mmm yyyy")
        
        PlazoPaso = DateDiff("d", FecFijacion.Text, FecVencimiento.Text)
        If PlazoPaso < 0 Then
            MsgBox "Período Forward no corresponde", vbCritical, "FRA"
            txtPlazo.Tag = 0
        Else
            txtPlazo.Tag = PlazoPaso
        End If
        txtPlazo.Text = txtPlazo.Tag
    End If
    
    Call CalculaDiferencial
End Sub

Private Sub txtRut_DblClick()

    BacControlWindows 100
    
'    If objCliente.leepornombre("") Then
'        BacAyudaSwap.Tag = "Cliente"
'        BacAyudaSwap.Show 1
'    Else
'        MsgBox "No Existen Datos para ayuda solicitada", vbExclamation, Msj
'        Exit Sub
'    End If
'
'    If giAceptar Then
'        txtRut.Tag = gsCodigo
'        txtRut.Text = gsCodigo
'        txtDV.Text = gsDigito
'        txtDV.Tag = gsCodCli
'        lblCliente.Caption = gsNombre
'        txtRut_KeyPress 13
'    End If
'
    Dim Cliente As New clsCliente
    
''    Dim digito
''
''
''
''
''    If (Val(txtRut.Text)) <> 0 Then
''        If Cliente.LeerxRut((Val(txtRut.Text)), 1) = False Then
''
''            If Val(txtRut.Text) > 0 Then
''                digito = ENTREGA_DIGITO_RUT(Val(txtRut.Text))
''            Else
''                digito = ""
''            End If
''
''            Call CargaClientesAs400(CDbl(txtRut.Text), Trim(digito))
''
''
''        End If
''    End If


    If Not Cliente.Ayuda("") Then
        MsgBox "No Existen Datos para ayuda solicitada", vbExclamation, Msj
        Exit Sub
    End If
    
    BacAyudaSwap.Tag = "Cliente"
    
    BacAyudaSwap.Show 1
    
    If giAceptar Then
        If Cliente.LeerxRut(Val(TxtRut.Text), 1) Then
            TxtRut.Text = Format(Cliente.clrut, "###,###,###") '& "-" & Cliente.cldv
            TxtRut.Tag = Cliente.clrut
            lblCliente.Caption = Cliente.clnombre
            TxtDv.Text = Cliente.cldv
            TxtDv.Tag = Cliente.clcodigo
            nPaisOrigen = Cliente.clPais
           
           
        End If
    End If

    Set Cliente = Nothing
    
    
End Sub

Private Sub txtRut_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        If IsNumeric(TxtRut.Text) Then
                Call BuscaCliente(TxtRut.Text)
        Else
                SendKeys ("{Tab}")
        End If
        
        Call Operadores(CmbOperador, TxtRut.Tag, TxtDv.Tag)

    End If
End Sub


Private Sub txtTasa_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    ElseIf KeyAscii = 27 Then
        txtTasa.Text = txtTasa.Tag
    End If
End Sub

Private Sub txtTasa_LostFocus()
    txtTasa.Tag = txtTasa.Text 'BacStrTran(Format(txtTasa.Text, "#0.0"), gsc_PuntoDecim, ".")
    Call CalculaDiferencial
End Sub

Private Sub txtValor_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
        txtCapital.SetFocus
    
    End If
End Sub


Private Sub txtValor_LostFocus()
   txtValor.Tag = txtValor.Text
End Sub

Function BuscaCliente(RutCli As Long)

Dim Cliente As New clsCliente
 Dim digito

 
    
    
'    If (Val(RutCli)) <> 0 Then
'        If Cliente.LeerxRut((Val(RutCli)), 1) = False Then
'
'            If Val(RutCli) > 0 Then
'                digito = ENTREGA_DIGITO_RUT(Val(RutCli))
'            Else
'                digito = ""
'            End If
'
'            Call CargaClientesAs400(CDbl(RutCli), Trim(digito))
'
'
'        End If
'    End If

   

 If Not Cliente.Ayuda("") Then
        MsgBox "No Existen Datos para ayuda solicitada", vbExclamation, Msj
        Exit Function
    End If
    
    BacAyudaSwap.Tag = "Cliente"
     
    BacAyudaSwap.Show 1
    
    If giAceptar Then
    
        If Cliente.LeerxRut(Val(RutCli), 1) Then
            TxtRut.Text = Format(Cliente.clrut, "###,###,###") '& "-" & Cliente.cldv
            TxtRut.Tag = Cliente.clrut
            lblCliente.Caption = Cliente.clnombre
            TxtDv.Text = Cliente.cldv
            TxtDv.Tag = Cliente.clcodigo
            nPaisOrigen = Cliente.clPais
            'txtRut_KeyPress 13
        End If
        SendKeys ("{Tab}")
        
    End If

    Set Cliente = Nothing

End Function
