VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "Mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacAnulaInter 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Anulación de Interbancarios.-"
   ClientHeight    =   7365
   ClientLeft      =   1380
   ClientTop       =   2145
   ClientWidth     =   6195
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacanula.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   7365
   ScaleWidth      =   6195
   Begin Threed.SSFrame SSFrame5 
      Height          =   2655
      Left            =   120
      TabIndex        =   34
      Top             =   4560
      Visible         =   0   'False
      Width           =   5985
      _Version        =   65536
      _ExtentX        =   10557
      _ExtentY        =   4683
      _StockProps     =   14
      Caption         =   "Lista de Errores en ALTAMIRA"
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
      Begin VB.TextBox Text1 
         Height          =   1695
         Left            =   90
         MultiLine       =   -1  'True
         ScrollBars      =   3  'Both
         TabIndex        =   35
         Text            =   "Bacanula.frx":030A
         Top             =   840
         Width           =   5775
      End
      Begin MSComctlLib.Toolbar Toolbar2 
         Height          =   510
         Left            =   120
         TabIndex        =   36
         Top             =   240
         Width           =   5685
         _ExtentX        =   10028
         _ExtentY        =   900
         ButtonWidth     =   767
         ButtonHeight    =   741
         AllowCustomize  =   0   'False
         Appearance      =   1
         ImageList       =   "ImageList1"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   1
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "cmdSalir"
               Description     =   "Salir"
               Object.ToolTipText     =   "Salr de la Ventana"
               ImageIndex      =   3
            EndProperty
         EndProperty
         BorderStyle     =   1
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4800
      Top             =   -15
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacanula.frx":0310
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacanula.frx":062A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacanula.frx":0944
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   0
      TabIndex        =   33
      Top             =   0
      Width           =   6165
      _ExtentX        =   10874
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdAnular"
            Description     =   "Anular"
            Object.ToolTipText     =   "Anular Operación"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdLimpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar Pantalla"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salr de la Ventana"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin BACControles.TXTNumero IntNumoper 
      Height          =   315
      Left            =   2580
      TabIndex        =   24
      Top             =   555
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
      Text            =   "0"
      Text            =   "0"
      MarcaTexto      =   -1  'True
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   1680
      Left            =   100
      TabIndex        =   7
      Top             =   900
      Width           =   1635
      _Version        =   65536
      _ExtentX        =   2884
      _ExtentY        =   2963
      _StockProps     =   14
      Caption         =   " Tipo "
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   2
      Begin Threed.SSCheck ChkCol 
         Height          =   240
         Left            =   180
         TabIndex        =   2
         Top             =   1215
         Width           =   1320
         _Version        =   65536
         _ExtentX        =   2328
         _ExtentY        =   423
         _StockProps     =   78
         Caption         =   "Colocación"
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
      End
      Begin Threed.SSCheck ChkCap 
         Height          =   240
         Left            =   180
         TabIndex        =   1
         Top             =   615
         Width           =   1320
         _Version        =   65536
         _ExtentX        =   2328
         _ExtentY        =   423
         _StockProps     =   78
         Caption         =   "Captación"
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
      End
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   1680
      Left            =   1815
      TabIndex        =   8
      Top             =   900
      Width           =   4245
      _Version        =   65536
      _ExtentX        =   7488
      _ExtentY        =   2963
      _StockProps     =   14
      Caption         =   " Parametros de Cálculo "
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   2
      Begin BACControles.TXTNumero FltValmon 
         Height          =   315
         Left            =   2520
         TabIndex        =   29
         Top             =   1200
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
         Text            =   "0.00"
         Text            =   "0.00"
         Max             =   "999999999999999.9999"
         CantidadDecimales=   "2"
      End
      Begin BACControles.TXTNumero IntBase 
         Height          =   315
         Left            =   1560
         TabIndex        =   28
         Top             =   1200
         Width           =   615
         _ExtentX        =   1085
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
      Begin BACControles.TXTFecha Dtefecven 
         Height          =   315
         Left            =   2640
         TabIndex        =   27
         Top             =   600
         Visible         =   0   'False
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
         Text            =   "14/11/2000"
      End
      Begin BACControles.TXTNumero Intdias 
         Height          =   315
         Left            =   1560
         TabIndex        =   26
         Top             =   600
         Width           =   615
         _ExtentX        =   1085
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
      Begin BACControles.TXTFecha Dtefecpro 
         Height          =   315
         Left            =   120
         TabIndex        =   25
         Top             =   600
         Visible         =   0   'False
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "14/11/2000"
      End
      Begin VB.ComboBox CmbMoneda 
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
         Left            =   135
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   1200
         Width           =   1110
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         Caption         =   "F.Vencimiento"
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
         Left            =   2790
         TabIndex        =   14
         Top             =   375
         Width           =   1215
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         Caption         =   "Días"
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
         Left            =   1725
         TabIndex        =   13
         Top             =   375
         Width           =   420
      End
      Begin VB.Label Label7 
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
         Left            =   135
         TabIndex        =   12
         Top             =   990
         Width           =   690
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "F.Proceso"
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
         Left            =   135
         TabIndex        =   11
         Top             =   375
         Width           =   870
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Valor"
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
         Left            =   3600
         TabIndex        =   10
         Top             =   990
         Width           =   450
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
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
         Left            =   1695
         TabIndex        =   9
         Top             =   990
         Width           =   435
      End
   End
   Begin Threed.SSFrame SSFrame3 
      Height          =   960
      Left            =   105
      TabIndex        =   15
      Top             =   2550
      Width           =   5955
      _Version        =   65536
      _ExtentX        =   10504
      _ExtentY        =   1693
      _StockProps     =   14
      Caption         =   " Operación "
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   2
      Begin BACControles.TXTNumero FltMtofin 
         Height          =   315
         Left            =   3855
         TabIndex        =   32
         Top             =   510
         Width           =   1920
         _ExtentX        =   3387
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
         Max             =   "99999999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero FltTasa 
         Height          =   315
         Left            =   2520
         TabIndex        =   31
         Top             =   510
         Width           =   1095
         _ExtentX        =   1931
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
         Max             =   "9999999999999.9999"
         CantidadDecimales=   "4"
      End
      Begin BACControles.TXTNumero FltMtoini 
         Height          =   315
         Left            =   120
         TabIndex        =   30
         Top             =   510
         Width           =   2175
         _ExtentX        =   3836
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
         Max             =   "99999999999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "Monto Final"
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
         Left            =   4785
         TabIndex        =   18
         Top             =   300
         Width           =   1005
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Tasa Interes"
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
         Left            =   2580
         TabIndex        =   17
         Top             =   300
         Width           =   1080
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Monto Inicial"
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
         Left            =   930
         TabIndex        =   16
         Top             =   300
         Width           =   1110
      End
   End
   Begin Threed.SSFrame SSFrame4 
      Height          =   960
      Left            =   105
      TabIndex        =   19
      Top             =   3525
      Width           =   5985
      _Version        =   65536
      _ExtentX        =   10557
      _ExtentY        =   1693
      _StockProps     =   14
      Caption         =   "Cliente"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   2
      Begin VB.TextBox Textnomcli 
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
         Left            =   2205
         TabIndex        =   6
         Top             =   510
         Width           =   3690
      End
      Begin VB.TextBox Textrutcli 
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
         Left            =   165
         TabIndex        =   4
         Top             =   510
         Width           =   1020
      End
      Begin VB.TextBox Textdvcli 
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
         Left            =   1275
         TabIndex        =   5
         Top             =   510
         Width           =   855
      End
      Begin VB.Label Label11 
         Caption         =   "Nombre"
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
         Height          =   240
         Index           =   0
         Left            =   2220
         TabIndex        =   23
         Top             =   330
         Width           =   675
      End
      Begin VB.Label Label11 
         Caption         =   "Rut Cliente"
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
         Height          =   270
         Index           =   1
         Left            =   180
         TabIndex        =   21
         Top             =   315
         Width           =   1020
      End
      Begin VB.Label Label11 
         Caption         =   "Código"
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
         Height          =   240
         Index           =   2
         Left            =   1470
         TabIndex        =   20
         Top             =   315
         Width           =   630
      End
   End
   Begin VB.Label Lbl_Origen 
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
      Enabled         =   0   'False
      Height          =   315
      Left            =   3690
      TabIndex        =   0
      Top             =   555
      Width           =   2295
   End
   Begin VB.Label Label10 
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Número de Operación "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   315
      Left            =   105
      TabIndex        =   22
      Top             =   555
      Width           =   2445
   End
End
Attribute VB_Name = "BacAnulaInter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public recupera         As Object
Public Moneda           As Object
Dim Frm_Monto_Pesos     As Double
Dim Frm_Rut_Cliente     As Long
Dim cOperInter          As String
Dim nCodForPago         As Integer

Public pareTipOper      As String   'Vb+- Se agrega campo para discrimir la anulación

Public VALIDA_ALTAMIRA As String
Private Sub Func_Limpiar_Pantalla()

   IntBase.text = ""
   FltValMon.text = 0
   FltMtoini.text = 0
   FltTasa.text = 0
   FltMtofin.text = 0
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Textrutcli.text = ""
   Textdvcli.text = ""
   Textnomcli.text = ""
   nCodForPago = 0
   IntNumoper.text = " "
   Lbl_Origen = ""
   IntNumoper.SetFocus

End Sub

Private Sub Func_Anular()

   Dim SQL              As String
   Dim i                As Integer
   Dim xtipoper         As String

   On Error GoTo ErrAnula

   xtipoper = Mid$(recupera.TipOper, 1, 3)

'FMO 20180711 cambio de order primero anular ALTAMIRA y luego en BAC
   If pareTipOper = "CAP" Then
        '+++jcamposd 20160505
        If Me.VALIDA_ALTAMIRA = "SI" Then
            If Not Anula_Dep_Altamira(IntNumoper.text) Then
                    MsgBox "Problemas al anular en ALTAMIRA, NO SE PUEDE CONTINUAR ", vbCritical, TITSISTEMA
                    Exit Sub
            End If
        End If
        '---jcamposd 20160505
   End If
'FMO 20180711 cambio de order primero anular ALTAMIRA y luego en BAC
   
   If recupera.AnulaInter(IntNumoper.text, pareTipOper, recupera.TipOper) <> 0 Then
      MsgBox "Operación Número " + IntNumoper.text + " No Pudo ser Anulada", vbExclamation, gsBac_Version
   Else

'      If gsBac_QUEDEF <> gsBac_IMPWIN Then
'         I = ActArcIni(gsBac_QUEDEF)
'         If pareTipOper <> "CAP" Then
'            Sql = ImprimeAnulacionPapeleta(Str(gsBac_CartRUT), IntNumoper.Text, "IB")
'
'         End If
'        I = ActArcIni(gsBac_IMPWIN)
'
'      End If

        ' reviso si el Flag de encendido del proceso
        If blnProcesoArt84Activo("BTR") Then
            If Not blnAnulaControlMargenes(Val(IntNumoper.text), "BTR", Textrutcli.text, Textdvcli.text) Then
              MsgBox "Problemas al Anular control de márgenes (Art84), para la siguiente operación :" + IntNumoper.text, vbCritical, gsBac_Version
            End If
         End If
        
      If gsBac_QUEDEF <> gsBac_IMPWIN Then
         i = ActArcIni(gsBac_QUEDEF)

         If pareTipOper = "CAP" Then
             SQL = ImprimeAnulacionPapeleta(Str(gsBac_CartRUT), IntNumoper.text, "IC")
         Else
             SQL = ImprimeAnulacionPapeleta(Str(gsBac_CartRUT), IntNumoper.text, "IB")

         End If
         
         i = ActArcIni(gsBac_IMPWIN)

      End If



      MsgBox " Operación Número " & IntNumoper.text & ". Anulada Correctamente", vbExclamation, gsBac_Version


 
      Valor_antiguo = " "
      Valor_antiguo = "Numero Documento=" & IntNumoper.text & ";Tipo Operacion=" & pareTipOper & ";Rut Cliente=" & Textrutcli.text & ";Digito Cliente=" & Textdvcli.text
      Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, _
      "BTR", "Opc_21100", "04", "Anulación de Operaciones", "mdmo", Valor_antiguo, " ")

     
      If SQL = "NO" Then
          MsgBox "No se Puedo Imprimir Papeleta(s) de Operación", vbCritical, "Papeletas de Operaciones"
      End If

      Call LLenaDatos

      IntNumoper.text = ""

      Toolbar1.Buttons(2).Enabled = False
      Toolbar1.Buttons(3).Enabled = False

   End If

   On Error GoTo 0

   Exit Sub

ErrAnula:
   On Error GoTo 0

   MsgBox "Problemas al Anular Interbancario: " & err.Description & ". Verifique.", vbCritical, "BAC Trader"

   Exit Sub

End Sub

Private Sub LLenaDatos()

   Lbl_Origen.Caption = ""

   If recupera.TipOper = "ICOL" Then
      Me.ChkCol.Value = True
      Me.ChkCap.Value = False
      Lbl_Origen.Caption = "COLOCACION"

   ElseIf recupera.TipOper = "ICAP" Then
      Me.ChkCap.Value = True
      Me.ChkCol.Value = False
      Lbl_Origen.Caption = "CAPTACION"

   ElseIf recupera.TipOper = "CAP" Then
      Me.ChkCol.Value = False
      Me.ChkCap.Value = False
      SSFrame1.Enabled = False
      Lbl_Origen.Caption = "CAPTACION"

   End If

   cOperInter = recupera.TipOper

   If recupera.Fecini = "" Then
      Me.Dtefecpro.Visible = False

   Else
      Me.Dtefecpro.Visible = True
      Me.Dtefecpro.text = recupera.Fecini

   End If

   Me.Intdias.text = recupera.Plazo

   If recupera.FecVen = "" Then
      Me.Dtefecven.Visible = False

   Else
      Me.Dtefecven.Visible = True
      Me.Dtefecven.text = recupera.FecVen

   End If

   Me.CmbMoneda.ListIndex = BacBuscaComboGlosa(Me.CmbMoneda, recupera.Moneda)
   Me.IntBase.text = recupera.Base
   Me.FltValMon.text = recupera.valor
   Me.FltMtoini.text = recupera.MtoInicial
   Me.FltTasa.text = recupera.Interes
   Me.FltMtofin.text = recupera.MtoFinal
   Toolbar1.Buttons(2).Enabled = True
   Toolbar1.Buttons(3).Enabled = True
   Me.Textrutcli.text = recupera.RutCli
   Me.Textdvcli.text = recupera.CodCli
   Me.Textnomcli.text = recupera.NomCli
   nCodForPago = Val(recupera.Forpai)

End Sub

Private Sub Form_Activate()


   '  Me.cmdAnular.Enabled = False
   Me.Caption = IIf(pareTipOper = "CAP", "Anulación de Captaciones ", "Anulación de Interbancarios")
   Me.SSFrame1.Visible = False

End Sub

Private Sub Form_Load()


   Me.Top = 0
   Me.Left = 0
   Me.Tag = "AN"
   Set Moneda = New Clstipmonedas
   Set recupera = New ClsRecupInter
   Call Moneda.Llama
   Call Moneda.LlenaCombo(Me.CmbMoneda)

   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, IIf(pareTipOper = "CAP", "Ingreso a pantalla de anulación de captaciones ", "Ingreso a pantalla de anulación de Interbancarios"))

   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Set Moneda = Nothing
   Set recupera = Nothing

End Sub

Private Sub IntNumoper_GotFocus()

   IntNumoper.Tag = IntNumoper.text

End Sub
Private Sub IntNumoper_KeyPress(KeyAscii As Integer)

   Dim ok               As String

   If KeyAscii = 13 Then
      If IntNumoper.Tag <> IntNumoper.text Then
         MousePointer = 11

         ok = recupera.BuscaDatos(IntNumoper.text, pareTipOper)
         VALIDA_ALTAMIRA = recupera.VAL_ALTAMIRA
         
         Call LLenaDatos

         If ok <> 0 Then
            Toolbar1.Buttons(2).Enabled = False
            Toolbar1.Buttons(3).Enabled = False
            MousePointer = 0
            Exit Sub

         End If

         Toolbar1.Buttons(2).Enabled = True
         Toolbar1.Buttons(3).Enabled = True
         MousePointer = 0

      End If

   Else
      Toolbar1.Buttons(2).Enabled = False
      Toolbar1.Buttons(3).Enabled = False

   End If

End Sub

Private Sub IntNumoper_LostFocus()

'   Dim ok               As String
'
'   If IntNumoper.Tag <> IntNumoper.Text Then
'      MousePointer = 11
'
'      ok = recupera.BuscaDatos(IntNumoper.Text, pareTipOper)
'
'      Call LLenaDatos
'
'      If ok <> 0 Then
'         Me.CmdAnular.Enabled = False
'         MousePointer = 0
'         Exit Sub
'
'      End If
'
'      Me.CmdAnular.Enabled = True
'      MousePointer = 0
'
'   End If
'
End Sub

Sub BuscaDatos_IB(sNumoper As String)
Dim Datos()

'   Sql = "SP_BUSCAINTERBANCARIO " + sNumoper
    Envia = Array(CDbl(sNumoper))

    If Not Bac_Sql_Execute("SP_BUSCAINTERBANCARIO", Envia) Then
        Exit Sub
    End If

    Do While Bac_SQL_Fetch(Datos())
        Frm_Monto_Pesos# = CDbl(Datos(8))
        Frm_Rut_Cliente& = CLng(Datos(19))
    Loop

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Description)
   Case "ANULAR"
      Call Func_Anular

   Case "LIMPIAR"
      Call Func_Limpiar_Pantalla

   Case "SALIR"
      Unload Me

   End Select

End Sub

'+++jcamposd 20160505 se debe implementar la acción de altamira eredada desde itau al nuevo banco

Function Anula_Dep_Altamira(nNumoper) As Boolean
Dim swnext          As Boolean
Dim StrEnvio        As String
Dim strXMLParam     As String
'Dim NroOperacion    As String
Screen.MousePointer = vbHourglass
Dim DataWS          As Object
Dim DataXML         As Object
Dim CodeXML         As String
Dim lngColumnas     As Long
Dim lngFilas        As Long
Dim strParseo() As String
Dim vResultado()
Dim i               As Integer
Dim sMsg            As String
Dim p               As Integer
Dim strError        As String
Dim blnEstado       As Boolean
'strParseo = Array()
On Error GoTo ERR_Elimina_Deposito

Set DataWS = CreateObject("ENVXMLWS.ClassXML")
Set DataXML = CreateObject("DllXML.clsXML")
Anula_Dep_Altamira = True

   
    CodeXML = vbNullString
    'Arma estructura XML de la Transacción a Ejecutar
        strXMLParam = "TxnName,7002 Eliminar Depositos"
        strXMLParam = strXMLParam & ",NroOperacion," & nNumoper
        strXMLParam = strXMLParam & ",ChannelInd," & gsALT_Canal '2 --+++jcamposd 20150508
        If gsALT_User = "" Then
            strXMLParam = strXMLParam & ",ALT_User," & Mid(gsBac_User, 1, 7)
        Else
            strXMLParam = strXMLParam & ",ALT_User," & Mid(gsALT_User, 1, 7)
        End If
    CodeXML = DataXML.CreateXML(strXMLParam)
    'Usa Web service Enviando XML Formado
    'CodeXML = DataWS.SndProcReqImp(CodeXML, 2, gsBac_User, gscWorkstation, 0, 0)
    ' vb CodeXML = DataWS.SndProcReqImp(CodeXML, 2, gsBac_User, gsBac_Term, gsALT_Tipo, True)
    CodeXML = DataWS.SndProcReqImp(CodeXML, 2, gsALT_User, Trim(Environ("ComputerName")), gsALT_Tipo, True)

    Call XML_Elimina(CodeXML, strError, blnEstado)
    
    sMsg = ""
    Text1.text = strError
    SSFrame5.Visible = True
    Me.Height = 7875
    
    MsgBox strError, vbOKOnly, "Anulación Altamira"
    
    Anula_Dep_Altamira = blnEstado
    
' etiqueta de total de registros
Screen.MousePointer = vbDefault

Set DataWS = Nothing
Set DataXML = Nothing


Exit Function
ERR_Elimina_Deposito:
    Set DataWS = Nothing
    Set DataXML = Nothing
    Screen.MousePointer = vbDefault
    
    If err.Number = 429 Then
        MsgBox "Problemas en la Componente ENVXMLWS y DllXML, genere reporte al 0-500 Mesa de Ayuda" + Chr(10) + Chr(13) + "Error: (" & CStr(err.Number) & "): " + err.Description, vbCritical, TITSISTEMA
    Else
        MsgBox "ERROR (" & CStr(err.Number) & "): " & err.Description, vbExclamation, App.Title
    End If
    
    Anula_Dep_Altamira = False
End Function
Public Sub XML_Elimina(XMLOutput As String, ByRef strError As String, blnEstado As Boolean)

'recibe un xml y lo pasa a la función que lo dejará en una grilla
'aquí se filtra el documento XML para enviarle sólamente los nodos que
'realmente interesan.

Dim xmlDoc As MSXML2.DOMDocument40
Dim XMLDoc2 As MSXML2.DOMDocument40
Dim XMLDocNodos As MSXML2.IXMLDOMNodeList

Dim CountFil As Long
Dim msgString, msgNro As String
    Set xmlDoc = New MSXML2.DOMDocument40
    Set XMLDoc2 = New MSXML2.DOMDocument40
    On Error Resume Next
    ' carga el string xml a documento xml
    xmlDoc.loadXML (XMLOutput)

    blnEstado = False
        'Se Valida la respuesta rechazada, enviando el codigo y respuesta
        blnEstado = Trim(xmlDoc.SelectSingleNode("//webResponse/status").text) = "Accepted"
        
        'If Not blnEstado Then
            XMLDoc2.loadXML (Trim(xmlDoc.SelectSingleNode("//webResponse/hubData/IFD/record").XML))
            strError = XMLDoc2.SelectSingleNode("//field[@name='Mensaje2']").text
            If blnEstado Then
                strError = "Anulación correcta, " & strError
            Else
                strError = "Anulación incorrecta, " & strError
            End If
            'Exit Sub
        'End If

    Set xmlDoc = Nothing
End Sub

''''<webResponse>
''''  <status>Rejected</status>
''''  <clientData>
''''        <field name="ALT_User" type="alphanumeric">ITAUTRAN</field>

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Index)
   Case 1
        SSFrame5.Visible = False
        Me.Height = 4905
   End Select
End Sub
