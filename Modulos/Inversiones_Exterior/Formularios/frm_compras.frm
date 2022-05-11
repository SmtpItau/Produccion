VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Bac_Compras 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Compras de Inversiones en el Exterior"
   ClientHeight    =   6915
   ClientLeft      =   -240
   ClientTop       =   1800
   ClientWidth     =   11055
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6915
   ScaleWidth      =   11055
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11055
      _ExtentX        =   19500
      _ExtentY        =   847
      ButtonWidth     =   714
      ButtonHeight    =   688
      ToolTips        =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3240
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   20
         ImageHeight     =   20
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   5
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_compras.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_compras.frx":0452
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_compras.frx":08A4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_compras.frx":0BBE
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_compras.frx":0ED8
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame frm_nemo 
      Height          =   855
      Left            =   15
      TabIndex        =   53
      Top             =   405
      Width           =   11025
      Begin VB.OptionButton optOpeIntramesa 
         Caption         =   "Intramesa"
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
         Left            =   4665
         TabIndex        =   92
         Top             =   200
         Width           =   1200
      End
      Begin VB.OptionButton optOpeNormal 
         Caption         =   "Normal"
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
         Left            =   3555
         TabIndex        =   91
         Top             =   200
         Width           =   1000
      End
      Begin VB.TextBox Txt_Nemo 
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
         Left            =   1500
         MaxLength       =   20
         TabIndex        =   3
         Top             =   480
         Width           =   3495
      End
      Begin VB.ComboBox box_familia 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   840
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   120
         Width           =   2340
      End
      Begin VB.ComboBox box_nemo 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   7130
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   135
         Width           =   3705
      End
      Begin VB.Label Label25 
         Caption         =   "Id. Instrumento"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   150
         TabIndex        =   62
         Top             =   570
         Width           =   1335
      End
      Begin VB.Label Label3 
         Alignment       =   1  'Right Justify
         Caption         =   "Serie Bono"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Index           =   1
         Left            =   6075
         TabIndex        =   56
         Top             =   195
         Width           =   975
      End
      Begin VB.Label Label2 
         Caption         =   "Familia"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   165
         TabIndex        =   55
         Top             =   195
         Width           =   975
      End
      Begin VB.Label lbl_descrip 
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   315
         Left            =   5190
         TabIndex        =   54
         Top             =   480
         Width           =   5640
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Identificación"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000002&
      Height          =   870
      Left            =   15
      TabIndex        =   73
      Top             =   5340
      Width           =   11025
      Begin VB.ComboBox txt_mercado 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   5235
         Style           =   2  'Dropdown List
         TabIndex        =   83
         Top             =   480
         Width           =   2265
      End
      Begin VB.ComboBox txt_bbnumber 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   8610
         Style           =   2  'Dropdown List
         TabIndex        =   82
         Top             =   150
         Width           =   2265
      End
      Begin VB.ComboBox txt_cusip 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   5235
         Style           =   2  'Dropdown List
         TabIndex        =   81
         Top             =   150
         Width           =   2265
      End
      Begin VB.ComboBox txt_isin 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   2040
         Style           =   2  'Dropdown List
         TabIndex        =   80
         Top             =   150
         Width           =   2265
      End
      Begin VB.ComboBox cbx_serie 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   2040
         Style           =   2  'Dropdown List
         TabIndex        =   77
         Top             =   480
         Width           =   2265
      End
      Begin VB.Label Label24 
         AutoSize        =   -1  'True
         Caption         =   "Serie"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   1545
         TabIndex        =   79
         Top             =   525
         Width           =   435
      End
      Begin VB.Label Label11 
         AutoSize        =   -1  'True
         Caption         =   "Mercado"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   4485
         TabIndex        =   78
         Top             =   540
         Width           =   720
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "ISIN"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Index           =   2
         Left            =   1620
         TabIndex        =   76
         Top             =   225
         Width           =   300
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "Cusip"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Index           =   3
         Left            =   4485
         TabIndex        =   75
         Top             =   210
         Width           =   480
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "BB Number"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Index           =   4
         Left            =   7635
         TabIndex        =   74
         Top             =   195
         Width           =   915
      End
   End
   Begin VB.Frame frm_datos_op 
      Caption         =   "Datos de la Operación"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000002&
      Height          =   1875
      Left            =   15
      TabIndex        =   39
      Top             =   3465
      Width           =   11025
      Begin VB.ComboBox Cmb_impuesto 
         Height          =   315
         Left            =   6480
         TabIndex        =   94
         Text            =   "-"
         Top             =   1530
         Width           =   615
      End
      Begin BACControles.TXTNumero Txt_Monto_Pag 
         Height          =   315
         Left            =   7890
         TabIndex        =   18
         Top             =   1170
         Width           =   2295
         _ExtentX        =   4048
         _ExtentY        =   556
         BackColor       =   16777215
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.00"
         Text            =   "0.00"
         Min             =   "0"
         Max             =   "9999999999.99"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txt_pre_por 
         Height          =   315
         Left            =   7890
         TabIndex        =   17
         Top             =   195
         Width           =   1995
         _ExtentX        =   3519
         _ExtentY        =   556
         BackColor       =   16777215
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000000"
         Text            =   "0.0000000"
         Min             =   "0"
         Max             =   "999999.9999999"
         CantidadDecimales=   "7"
         Separator       =   -1  'True
         SelStart        =   4
      End
      Begin BACControles.TXTNumero txt_tasa_vig 
         Height          =   315
         Left            =   2010
         TabIndex        =   14
         Top             =   840
         Width           =   2580
         _ExtentX        =   4551
         _ExtentY        =   556
         BackColor       =   16777215
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.00000"
         Text            =   "0.00000"
         Min             =   "0"
         Max             =   "999.99999"
         CantidadDecimales=   "5"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txt_nominal 
         Height          =   315
         Left            =   2010
         TabIndex        =   15
         Top             =   1170
         Width           =   2595
         _ExtentX        =   4577
         _ExtentY        =   556
         BackColor       =   16777215
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "0"
         Max             =   "9999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txt_tir 
         Height          =   315
         Left            =   2010
         TabIndex        =   16
         Top             =   1500
         Width           =   2580
         _ExtentX        =   4551
         _ExtentY        =   556
         BackColor       =   16777215
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000000"
         Text            =   "0.0000000"
         Min             =   "0"
         Max             =   "999999.9999999"
         CantidadDecimales=   "7"
         Separator       =   -1  'True
         SelStart        =   4
      End
      Begin BACControles.TXTFecha txt_fec_neg 
         Height          =   315
         Left            =   3345
         TabIndex        =   12
         Top             =   180
         Width           =   1260
         _ExtentX        =   2223
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   2
         Text            =   "18/06/2002"
      End
      Begin BACControles.TXTFecha txt_fec_pag 
         Height          =   315
         Left            =   3345
         TabIndex        =   13
         Top             =   510
         Width           =   1260
         _ExtentX        =   2223
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   2
         Text            =   "18/06/2002"
      End
      Begin BACControles.TXTNumero TXT_impuesto 
         Height          =   315
         Left            =   7890
         TabIndex        =   95
         Top             =   1530
         Width           =   2295
         _ExtentX        =   4048
         _ExtentY        =   556
         BackColor       =   16777215
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.00"
         Text            =   "0.00"
         Min             =   "0"
         Max             =   "9999999999.99"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
      End
      Begin VB.Label Lbl_porImpuesto 
         AutoSize        =   -1  'True
         Caption         =   "%"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   7080
         TabIndex        =   96
         Top             =   1560
         Width           =   135
      End
      Begin VB.Label Lbl_impuesto 
         AutoSize        =   -1  'True
         Caption         =   "Impuesto"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   5520
         TabIndex        =   93
         Top             =   1560
         Width           =   795
      End
      Begin VB.Label lblFactor 
         Caption         =   "lblFactor"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   255
         Left            =   6930
         TabIndex        =   72
         Top             =   570
         Width           =   1665
      End
      Begin VB.Label Label29 
         AutoSize        =   -1  'True
         Caption         =   "%"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   240
         Left            =   4650
         TabIndex        =   68
         Top             =   1530
         Width           =   150
      End
      Begin VB.Label Label28 
         AutoSize        =   -1  'True
         Caption         =   "%"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   240
         Left            =   4635
         TabIndex        =   67
         Top             =   870
         Width           =   150
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "%"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   240
         Left            =   9990
         TabIndex        =   64
         Top             =   240
         Width           =   720
      End
      Begin VB.Label lbl_monto_prin 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   315
         Left            =   7890
         TabIndex        =   61
         Top             =   540
         Width           =   2295
      End
      Begin VB.Label Label23 
         AutoSize        =   -1  'True
         Caption         =   "Principal a Pagar"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   5520
         TabIndex        =   60
         Top             =   555
         Width           =   1350
      End
      Begin VB.Label lbl_int_dev 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Caption         =   "0"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   315
         Left            =   7890
         TabIndex        =   58
         Top             =   855
         Width           =   2295
      End
      Begin VB.Label lbl_int 
         AutoSize        =   -1  'True
         Caption         =   "Interés Dev. a Pagar"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   5550
         TabIndex        =   57
         Top             =   885
         Width           =   1635
      End
      Begin VB.Label lbl_spread 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   2250
         TabIndex        =   50
         Top             =   2310
         Visible         =   0   'False
         Width           =   1500
      End
      Begin VB.Label Label22 
         AutoSize        =   -1  'True
         Caption         =   "Tasa Cupón"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   105
         TabIndex        =   47
         Top             =   870
         Width           =   975
      End
      Begin VB.Label Label21 
         Caption         =   "Spread"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   135
         TabIndex        =   46
         Top             =   2310
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.Label Label20 
         AutoSize        =   -1  'True
         Caption         =   "Precio Porcentual"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   5550
         TabIndex        =   45
         Top             =   225
         Width           =   1455
      End
      Begin VB.Label Label19 
         AutoSize        =   -1  'True
         Caption         =   "TIR Compra"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   105
         TabIndex        =   44
         Top             =   1530
         Width           =   960
      End
      Begin VB.Label Label18 
         AutoSize        =   -1  'True
         Caption         =   "Fecha de pago"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   105
         TabIndex        =   43
         Top             =   540
         Width           =   1185
      End
      Begin VB.Label Label17 
         AutoSize        =   -1  'True
         Caption         =   "Monto a Pagar"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   210
         Left            =   5550
         TabIndex        =   42
         Top             =   1215
         Width           =   1170
      End
      Begin VB.Label Label16 
         AutoSize        =   -1  'True
         Caption         =   "Nominal"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   105
         TabIndex        =   41
         Top             =   1200
         Width           =   660
      End
      Begin VB.Label Label15 
         AutoSize        =   -1  'True
         Caption         =   "Fecha de Negociación"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   105
         TabIndex        =   40
         Top             =   210
         Width           =   1770
      End
   End
   Begin VB.Frame frm_descrip 
      Caption         =   "Descripción"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000002&
      Height          =   2190
      Left            =   15
      TabIndex        =   29
      Top             =   1260
      Width           =   11025
      Begin BACControles.TXTNumero txt_cod_emi 
         Height          =   315
         Left            =   4065
         TabIndex        =   71
         Top             =   480
         Width           =   495
         _ExtentX        =   873
         _ExtentY        =   556
         BackColor       =   16777215
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
      End
      Begin VB.ComboBox Box_base 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   2025
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   1470
         Width           =   1965
      End
      Begin VB.ComboBox box_año 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   3090
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   1800
         Visible         =   0   'False
         Width           =   870
      End
      Begin VB.ComboBox box_dia 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   2010
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   1800
         Visible         =   0   'False
         Width           =   870
      End
      Begin VB.ComboBox box_forma_pago 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         ItemData        =   "frm_compras.frx":11F2
         Left            =   8085
         List            =   "frm_compras.frx":11F4
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   1800
         Width           =   2850
      End
      Begin VB.ComboBox box_mon_pag 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   8085
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   1140
         Width           =   2850
      End
      Begin VB.ComboBox box_mon_emi 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   8085
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   810
         Width           =   2850
      End
      Begin VB.TextBox Txt_rut_Emi 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2025
         TabIndex        =   19
         Top             =   480
         Width           =   1965
      End
      Begin VB.TextBox txt_rut_emis 
         Height          =   285
         Left            =   9090
         MaxLength       =   8
         TabIndex        =   59
         Top             =   3630
         Visible         =   0   'False
         Width           =   1935
      End
      Begin VB.ComboBox box_basilea 
         BackColor       =   &H00C0FFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   6300
         Style           =   2  'Dropdown List
         TabIndex        =   27
         Top             =   2685
         Visible         =   0   'False
         Width           =   1980
      End
      Begin VB.Frame frm_basilea 
         BackColor       =   &H00C0FFFF&
         Enabled         =   0   'False
         Height          =   450
         Left            =   2010
         TabIndex        =   51
         Top             =   2625
         Visible         =   0   'False
         Width           =   1380
         Begin VB.OptionButton Op_Encaje_N 
            Caption         =   "No"
            Height          =   300
            Left            =   735
            TabIndex        =   25
            Top             =   120
            Width           =   510
         End
         Begin VB.OptionButton Op_Encaje_S 
            Caption         =   "Sí"
            Height          =   285
            Left            =   75
            TabIndex        =   24
            Top             =   135
            Width           =   465
         End
      End
      Begin BACControles.TXTFecha txt_fec_vcto 
         Height          =   315
         Left            =   9675
         TabIndex        =   8
         Top             =   480
         Width           =   1260
         _ExtentX        =   2223
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "26/10/2001"
      End
      Begin BACControles.TXTFecha txt_fec_emi 
         Height          =   315
         Left            =   9675
         TabIndex        =   7
         Top             =   150
         Width           =   1260
         _ExtentX        =   2223
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "26/10/2001"
      End
      Begin VB.Label Label35 
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   2925
         TabIndex        =   20
         Top             =   1830
         Visible         =   0   'False
         Width           =   150
      End
      Begin VB.Label Label34 
         AutoSize        =   -1  'True
         Caption         =   "Bases De Tasas"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   105
         TabIndex        =   21
         Top             =   1515
         Width           =   1305
      End
      Begin VB.Label Label31 
         AutoSize        =   -1  'True
         Caption         =   "Forma de Pago"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   5550
         TabIndex        =   22
         Top             =   1845
         Width           =   1230
      End
      Begin VB.Label Label32 
         AutoSize        =   -1  'True
         Caption         =   "Monto Emisión"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   105
         TabIndex        =   70
         Top             =   1185
         Width           =   1230
      End
      Begin VB.Label lbl_monto_emi 
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   315
         Left            =   2025
         TabIndex        =   26
         Top             =   1140
         Width           =   1965
      End
      Begin VB.Label Label30 
         AutoSize        =   -1  'True
         Caption         =   "Moneda Pago"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   5550
         TabIndex        =   69
         Top             =   1185
         Width           =   1110
      End
      Begin VB.Label Txt_Cod_tasa 
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000006&
         Height          =   315
         Left            =   2025
         TabIndex        =   63
         Top             =   150
         Width           =   615
      End
      Begin VB.Label lbl_tip_tasa 
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000006&
         Height          =   315
         Left            =   2700
         TabIndex        =   52
         Top             =   150
         Width           =   2580
      End
      Begin VB.Label lbl_emisor 
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   315
         Left            =   2025
         TabIndex        =   49
         Top             =   810
         Width           =   3255
      End
      Begin VB.Label lbl_pais 
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   315
         Left            =   8085
         TabIndex        =   48
         Top             =   1470
         Width           =   2850
      End
      Begin VB.Label Label12 
         AutoSize        =   -1  'True
         Caption         =   "Fecha de Emisión"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   5550
         TabIndex        =   38
         Top             =   195
         Width           =   1440
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         Caption         =   "Emisor"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   105
         TabIndex        =   37
         Top             =   855
         Width           =   585
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "Moneda Emisión"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Index           =   0
         Left            =   5550
         TabIndex        =   36
         Top             =   855
         Width           =   1365
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "Fecha de Vencimiento"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   5550
         TabIndex        =   35
         Top             =   525
         Width           =   1830
      End
      Begin VB.Label Label13 
         BackColor       =   &H00C0FFFF&
         Caption         =   "Indice de Basilea"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   4380
         TabIndex        =   34
         Top             =   2700
         Visible         =   0   'False
         Width           =   1695
      End
      Begin VB.Label Label10 
         AutoSize        =   -1  'True
         Caption         =   "País"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   5550
         TabIndex        =   33
         Top             =   1515
         Width           =   345
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         Caption         =   "Rut Emisor"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   105
         TabIndex        =   32
         Top             =   525
         Width           =   900
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "Tipo de Tasa"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   105
         TabIndex        =   31
         Top             =   195
         Width           =   1050
      End
      Begin VB.Label Label4 
         BackColor       =   &H00C0FFFF&
         Caption         =   "Deducción de Encaje"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   420
         Left            =   90
         TabIndex        =   30
         Top             =   2595
         Visible         =   0   'False
         Width           =   1695
      End
   End
   Begin VB.Frame Frm_Dur 
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   720
      Left            =   15
      TabIndex        =   84
      Top             =   6180
      Width           =   11025
      Begin BACControles.TXTNumero txtDur_Mac 
         Height          =   330
         Left            =   1425
         TabIndex        =   85
         Top             =   330
         Width           =   2205
         _ExtentX        =   3889
         _ExtentY        =   582
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000000"
         Text            =   "0.0000000"
         Min             =   "0"
         Max             =   "9999999999.9999"
         CantidadDecimales=   "7"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
         SelStart        =   4
      End
      Begin BACControles.TXTNumero txtDur_Mod 
         Height          =   330
         Left            =   4380
         TabIndex        =   86
         Top             =   330
         Width           =   2205
         _ExtentX        =   3889
         _ExtentY        =   582
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000000"
         Text            =   "0.0000000"
         Min             =   "0"
         Max             =   "9999999999.9999"
         CantidadDecimales=   "7"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
         SelStart        =   4
      End
      Begin BACControles.TXTNumero txtConvexi 
         Height          =   330
         Left            =   7425
         TabIndex        =   87
         Top             =   330
         Width           =   2205
         _ExtentX        =   3889
         _ExtentY        =   582
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000000"
         Text            =   "0.0000000"
         Min             =   "0"
         Max             =   "9999999999.9999"
         CantidadDecimales=   "7"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
         SelStart        =   4
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Convexidad"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Index           =   3
         Left            =   7425
         TabIndex        =   90
         Top             =   120
         Width           =   960
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Duración Modificada"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Index           =   2
         Left            =   4395
         TabIndex        =   89
         Top             =   120
         Width           =   1650
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Duración Macaulay"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Index           =   0
         Left            =   1440
         TabIndex        =   88
         Top             =   120
         Width           =   1515
      End
   End
   Begin VB.Label lbl_val_venc 
      Alignment       =   1  'Right Justify
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   255
      Left            =   2130
      TabIndex        =   23
      Top             =   0
      Visible         =   0   'False
      Width           =   1995
   End
   Begin VB.Label Label14 
      Caption         =   "Valor Vencimiento"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   255
      Left            =   0
      TabIndex        =   28
      Top             =   0
      Visible         =   0   'False
      Width           =   1695
   End
   Begin VB.Label Label27 
      Caption         =   "%"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   255
      Left            =   0
      TabIndex        =   66
      Top             =   0
      Width           =   480
   End
   Begin VB.Label Label26 
      Caption         =   "%"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   255
      Left            =   0
      TabIndex        =   65
      Top             =   0
      Width           =   480
   End
End
Attribute VB_Name = "Bac_Compras"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim TR          As Double
Dim TE          As Double
Dim TV          As Double
Dim TT          As Double
Dim BA          As Double
Dim BF          As Double
Dim NOM         As Double
Dim MT          As Double
Dim VV          As Double
Dim VP          As Double
Dim PVP         As Double
Dim VAN         As Double
Dim FP          As Date
Dim FE          As Date
Dim FV          As Date
Dim FU          As Date
Dim FX          As Date
Dim FC          As Date
Dim CI          As Double
Dim CT          As Double
Dim INDEV       As Double
Dim PRINC       As Double
Dim FIP         As Date
Dim INCTR       As Double
Dim CAP         As Double
Dim SPREAD      As Double

Dim seriadoSN As String          'MAP 20160803
Dim idInternacionalSN As String  'MAP 20160803
Dim tipoPrecioPrcSN As String    'MAP 20160803
Dim NombreFamilia As String      'MAP 20160803
Dim BaseFamilia As String        'MAP 20160803
Dim UsaBaseFamiliaSN As String   'MAP 20160803
Dim ConvBaseFamilia  As String   'MAP 20160804
Dim ModificarMdaSN As String     'MAP 20160804
Dim ModificarMdaPagSN As String  'MAP 20160804

Dim Valoriza As Integer
Dim ModCal


Const BtnGrabar = 1
Const BtnEliminar = 2
Const BtnBuscar = 3
Const BtnLimpiar = 4
Const BtnSalir = 5

Public nImpuesto        As Integer
Public nValorImpuesto   As Double
Public nPorcentajeImpuesto   As Integer
'+++jcamposd COP
Dim codMonedaSel As Integer
Dim ValorMonedaCOP As Double
'---jcamposd COP

Sub Busca_Identificadores(nemo As String)
    Dim Sql As String
    Dim datos()

    Txt_isin.Clear
    txt_cusip.Clear
    txt_bbnumber.Clear
    txt_mercado.Clear

    envia = Array()
    AddParam envia, Trim(nemo)
    If Bac_Sql_Execute("SVC_BUS_IDENT", envia) Then
        Do While Bac_SQL_Fetch(datos)
            If datos(1) = "0" Then
                Exit Do
            End If
            If datos(2) <> "" Then
                Txt_isin.AddItem datos(2)
                Txt_isin.ItemData(Txt_isin.NewIndex) = Val(datos(1))
            End If
            If datos(3) <> "" Then
                txt_cusip.AddItem (datos(3))
                txt_cusip.ItemData(txt_cusip.NewIndex) = Val(datos(1))
            End If
            If datos(4) <> "" Then
                txt_bbnumber.AddItem (datos(4))
                txt_bbnumber.ItemData(txt_bbnumber.NewIndex) = Val(datos(1))
            End If
            If datos(5) <> "" Then
                txt_mercado.AddItem (datos(5))
                txt_mercado.ItemData(txt_mercado.NewIndex) = Val(datos(1))
            End If
            If datos(6) <> "" Then
                cbx_serie.AddItem (datos(6))
                cbx_serie.ItemData(cbx_serie.NewIndex) = Val(datos(1))
            End If
            
        Loop
    End If
End Sub
Function busca_Series()
    Dim Sql As String
    Dim datos()

    If Bac_Sql_Execute("svc_bus_serie") Then
        Do While Bac_SQL_Fetch(datos)
            If datos(1) = "0" Then
                Exit Do
            End If
            cbx_serie.AddItem (datos(1))
        Loop
    End If
End Function
Function busca_datos(rut, Cod_emi)
    busca_datos = 0
    If rut = "" Or Not IsNumeric(rut) Then
        Exit Function
    End If
    
    Dim datos()
    envia = Array()
    AddParam envia, CDbl(rut)
    AddParam envia, CDbl(Cod_emi)
    If Bac_Sql_Execute("SVC_OPE_DAT_EMI", envia) Then
        Do While Bac_SQL_Fetch(datos)
            If datos(1) <> 0 Then
                lbl_emisor.Caption = datos(1)
            End If
        Loop
    End If
    If datos(1) = 0 Then
        MsgBox "Rut Inexsistente", vbExclamation, gsBac_Version
        lbl_emisor.Caption = ""
        Txt_rut_Emi = ""
        Txt_rut_Emi.SetFocus
        Exit Function
    End If
    busca_datos = datos(1)
End Function

Function busca_tip_tasa(dat)
    Dim datos()
    envia = Array()
    AddParam envia, dat
    If Bac_Sql_Execute("SVC_GEN_TIP_TAS", envia) Then
        Do While Bac_SQL_Fetch(datos)
            Txt_Cod_tasa.Caption = datos(1)
            lbl_tip_tasa.Caption = datos(2)
        Loop
    End If
End Function

Function buscar_datos(cod, nemo, vcto)

    If box_familia.ListIndex = -1 Then
        MsgBox "No ha Selecccionado Familia", vbExclamation, gsBac_Version
        Exit Function
    End If


    If box_familia.ListIndex = 0 Then
    
        If box_nemo.ListIndex = -1 Then
            MsgBox "No ha Selecccionado Instrumento", vbExclamation, gsBac_Version
            Exit Function
        End If
    End If
    
    Dim datos()
    envia = Array()
    AddParam envia, nemo
    AddParam envia, vcto
    If Bac_Sql_Execute("SVC_AYD_SER_INS", envia) Then
        Do While Bac_SQL_Fetch(datos)
            lbl_descrip.Caption = datos(3)
            Txt_rut_Emi.Text = CDbl(datos(4))
            lbl_emisor.Caption = datos(20)
            
            box_basilea.ListIndex = (Val(datos(6)) - 1)
            txt_fec_emi.Text = Format(datos(9), "DD/MM/YYYY")
            txt_fec_vcto.Text = Format(datos(10), "DD/MM/YYYY")
            If datos(11) = "S" Then
                Op_Encaje_S.Value = True
            Else
                Op_Encaje_N.Value = True
            End If
            Limpio = True
            txt_tasa_vig.Text = CDbl(datos(14)) + CDbl(datos(27))
            SPREAD = CDbl(datos(27))
            BA = datos(17)
            For i = 0 To box_mon_emi.ListCount - 1
                box_mon_emi.ListIndex = i
                If box_mon_emi.ItemData(box_mon_emi.ListIndex) = datos(21) Then
                    '+++COLTES, jcamposd
                        codMonedaSel = datos(21)
                    '---COLTES, jcamposd
                    box_mon_emi.Enabled = False
                    Exit For
                End If
                box_mon_emi.ListIndex = -1
            Next
            For i = 0 To BOX_MON_PAG.ListCount - 1
                BOX_MON_PAG.ListIndex = i
                If BOX_MON_PAG.ItemData(BOX_MON_PAG.ListIndex) = datos(22) Then
                    BOX_MON_PAG.Enabled = False
                    Exit For
                End If
                BOX_MON_PAG.ListIndex = -1
            Next
            lbl_monto_emi.Caption = Format(datos(19), "0,0.0000")
            
            tipo_cartera = datos(29)
            
        Loop
        
    End If
    'Pega aki
    Call busca_tip_tasa(datos(5))
    If Trim(UCase(lbl_tip_tasa.Caption)) = "FIJA" Or Trim(UCase(lbl_tip_tasa.Caption)) = "FIXED" Then
        txt_tasa_vig.Enabled = False
    Else
        txt_tasa_vig.Enabled = False 'True
    End If
    For i = 0 To box_año.ListCount - 1
        box_año.ListIndex = i
        If box_año.Text = datos(13) Then
            Exit For
        End If
        box_año.ListIndex = -1
    Next
    box_base.ListIndex = box_año.ListIndex

    If datos(16) = "T" Then
        For i = 0 To box_dia.ListCount - 1
            box_dia.ListIndex = i
            If box_dia.Text = "Real" Then
                Exit For
            End If
            box_dia.ListIndex = -1
        Next
    ElseIf datos(16) = "F" Then
        For i = 0 To box_dia.ListCount - 1
            box_dia.ListIndex = i
            If box_dia.Text = "30" Then
                Exit For
            End If
            box_dia.ListIndex = -1
        Next
    End If
    txt_fec_vcto.Enabled = False
    txt_fec_emi.Enabled = False
    
    frm_datos_op.Enabled = True
    frm_descrip.Enabled = True
    frm_nemo.Enabled = False
    Toolbar1.Buttons(1).Enabled = True
    Toolbar1.Buttons(2).Enabled = True
    i = 0
    For i = 0 To box_año.ListCount - 1
            box_año.ListIndex = i
            If box_año.Text = BA Then
                Exit For
            End If
            box_año.ListIndex = -1
    Next
    box_base.ListIndex = box_año.ListIndex

    box_dia.Enabled = False
    box_año.Enabled = False
    box_base.Enabled = False
    box_nemo.Enabled = False
    Cod_emi = CDbl(datos(25))
    txt_cod_emi.Text = CDbl(datos(25))
    If box_familia.ListIndex > 0 Then
       lbl_monto_emi.Caption = " "
    End If
    
    '**Consulta Incluir campos Identificacion y mercados
    Call Busca_Identificadores(Trim(nemo))
    Txt_isin.Enabled = True
    '**fin
    
    Call buscar_pais(CDbl(datos(4)), CDbl(datos(25)))
    Call llena_combo_forma_pago(box_mon_emi.ItemData(box_mon_emi.ListIndex), BOX_MON_PAG.ItemData(BOX_MON_PAG.ListIndex), box_forma_pago)

End Function


Function Clear_Objetos()
    Limpio = False
    Me.lbl_tip_tasa.Caption = " "
    txt_tasa_vig.Enabled = True
    txt_tasa_vig.Text = 0
'   txt_monto_emi.Text = " "
'   txt_monto_emi.Enabled = False
    txt_cod_emi.Visible = False
    txt_cod_emi.Text = " "
    box_dia.ListIndex = -1
    box_año.ListIndex = -1
    box_base.ListIndex = -1
    frm_nemo.Enabled = True
    box_nemo.Enabled = True
    box_nemo.ListIndex = -1
    box_familia.Enabled = True
    box_familia.ListIndex = -1
    box_basilea.ListIndex = -1
    box_familia.Enabled = True
    box_nemo.Enabled = False
    Txt_rut_Emi.Enabled = False
    Txt_rut_Emi.BackColor = &H80000004
    Op_Encaje_S.Value = False
    Op_Encaje_N.Value = False
    lbl_monto_emi.Caption = " "
    
    box_forma_pago.ListIndex = -1
    lbl_descrip.Caption = ""
    lbl_tip_tasa.Caption = ""
    Txt_rut_Emi = ""
    lbl_pais.Caption = ""
    lbl_emisor.Caption = ""
    
    txt_fec_emi.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_fec_vcto.Text = Format(gsBac_Fecx, "DD/MM/YYYY") '--jcamposd COP gsBac_Fecp
    txt_tasa_vig.Text = 0
    txt_fec_neg.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_fec_pag.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_nominal.Text = ""
    txt_tir.Text = ""
    txt_pre_por.Text = 0 'jcamposd debe ser numero
    txt_monto_pag.Text = 0 'jcamposd debe ser numero
    lbl_int_dev.Caption = 0
    lbl_monto_prin.Caption = ""
    lbl_val_venc.Caption = ""
    box_mon_emi.ListIndex = -1
    BOX_MON_PAG.ListIndex = -1
    frm_datos_op.Enabled = False
    frm_descrip.Enabled = False
    frm_basilea.Enabled = False
    
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    
    Txt_Nemo.Enabled = False
    Txt_Nemo.Text = ""
    
    Txt_isin.Clear
    txt_cusip.Clear
    txt_bbnumber.Clear
    cbx_serie.Clear
    txt_mercado.Clear
    
    Txt_isin.Enabled = False
    txt_cusip.Enabled = False
    txt_bbnumber.Enabled = False
    cbx_serie.Enabled = False
    txt_mercado.Enabled = False
    
    
    Me.lblFactor.Caption = ""
    
   txtDur_Mac.Text = CDbl(0)
   txtDur_Mod.Text = CDbl(0)
   txtConvexi.Text = CDbl(0)

    'JBH, 04-12-2009
    optOpeNormal.Value = False
    optOpeIntramesa.Value = False
    'fin JBH, 04-12-2009
    
    '+++jcamposd 20160905 era considerado si era familia CD
    'txt_pre_por.Tag = txt_pre_por.Text
    'txt_monto_pag.Tag = txt_monto_pag.Text
    'txt_nominal.Tag = txt_nominal.Text
    'txt_tir.Tag = txt_tir.Text
    '---jcamposd 20160905
    
    '+++jcamposd depositos colombianos
    Lbl_impuesto.Visible = False
    Cmb_impuesto.Visible = False
    TXT_impuesto.Visible = False
    Lbl_porImpuesto.Visible = False
    ModCal = 0
    txt_pre_por.Tag = 0#
    '+++jcamposd depositos colombianos
    
    
End Function

Function datos_vacios()

    datos_vacios = True
    
    If txt_fec_emi.Text = "  /  /    " Then
        MsgBox "Falta Ingresar Fecha De Emisión", vbExclamation, gsBac_Version
        txt_fec_emi.SetFocus
        datos_vacios = False
    ElseIf txt_fec_vcto.Text = "  /  /    " Then
        MsgBox "Falta Ingresar fecha De vencimiento", vbExclamation, gsBac_Version
        txt_fec_vcto.SetFocus
        datos_vacios = False
    ElseIf Txt_rut_Emi.Text = "" Then
        MsgBox "Falta Ingresar Rut Emisor Fictisio", vbExclamation, gsBac_Version
        Txt_rut_Emi.SetFocus
        datos_vacios = False
    ElseIf txt_fec_pag.Text = "  /  /    " Then
        MsgBox "Falta INgresar fecha De Pago", vbExclamation, gsBac_Version
        txt_fec_pag.SetFocus
        datos_vacios = False
    ElseIf txt_fec_neg.Text = "  /  /    " Then
        MsgBox "Falta Ingresar Fecha De Negociación", vbExclamation, gsBac_Version
        txt_fec_neg.SetFocus
        datos_vacios = False
    ElseIf CDbl(txt_tasa_vig.Text) = 0 Then ' And box_mon_emi.ItemData(box_mon_emi.ListIndex) <> 129 And box_familia.ItemData(box_familia.ListIndex) = 2001 Then '+++jcamposd para CD en moneda colombia no considerar tasa <> 0
        MsgBox "Falta Ingresar Tasa Vigente", vbExclamation, gsBac_Version
        txt_tasa_vig.SetFocus
        datos_vacios = False
    ElseIf CDbl(txt_nominal) = 0 Then
        MsgBox "Falta Ingresar Nominal", vbExclamation, gsBac_Version
        txt_nominal.SetFocus
        datos_vacios = False
    ElseIf CDbl(txt_tir) = 0 Then
        MsgBox "Falta Ingresar La TIR", vbExclamation, gsBac_Version
        txt_tir.SetFocus
        datos_vacios = False
    ElseIf CDbl(txt_pre_por.Text) = 0 Then
        MsgBox "Falta Ingresar Precio Porcentual", vbExclamation, gsBac_Version
        txt_pre_por.SetFocus
        datos_vacios = False
    ElseIf CDbl(txt_monto_pag.Text) = 0 Then
        MsgBox "Falta Ingrsar Monto A Pagar", vbExclamation, gsBac_Version
        txt_monto_pag.SetFocus
        datos_vacios = False
    ElseIf box_moneda.ListIndex = -1 Then
        MsgBox "Falta Ingrsar Moneda", vbExclamation, gsBac_Version
        box_moneda.SetFocus
        datos_vacios = False
    ElseIf box_basilea.ListIndex = -1 Then
        MsgBox "Falta Ingrsar Basilea", vbExclamation, gsBac_Version
        box_basilea.SetFocus
        datos_vacios = False
    
    End If
    
End Function

Function Feriados_inter(Fecha, pais)

    Dim datos()
    Dim Feriados As String
    Dim Ano As Double
    Dim Mes As Double
    Dim Dia As Double
    Dim dia_1 As Integer
    Dim i As Double
    Dia = Format(Mid(Fecha, 1, 2), "00")
    Mes = Format(Mid(Fecha, 4, 2), "00")
    Ano = Format(Mid(Fecha, 7, 4), "0000")
    envia = Array()
    AddParam envia, Ano
    AddParam envia, pais
    AddParam envia, Mes
    If Bac_Sql_Execute("SVC_OPE_LEE_FRD ", envia) Then
        Do While Bac_SQL_Fetch(datos)
            If datos(1) = 1 Then
                Feriados_inter = True
                Exit Function
            Else
                Feriados = datos(3)
            End If
        Loop
    End If
    Feriados = Trim(Feriados)
    If Feriados = "" Then
        Feriados_inter = True
        Exit Function
    End If
    For i = 1 To 100
        If (Mid(Feriados, i, 1)) = "," Then
            i = i + 1
        End If
        If Mid(Feriados, i, 2) = "" Then
            Feriados_inter = True
            Exit Function
        End If
        dia_1 = CDbl(Mid(Feriados, i, 2))
        i = i + 1
        If Dia = dia_1 Then
            Feriados_inter = False
            Exit Function
        End If
    Next i
    Feriados_inter = True
End Function

Function Grabar_compra()
On Error GoTo fallagrabar

    'JBH, 22-12-2009
    Dim numeroOp As Double
    'fin JBH, 22-12-2009

    Dim datos()
    Dim Numoper As Double
    
    If box_forma_pago.ListIndex = -1 Then
      MsgBox "Debe Ingresar Forma de Pago", vbInformation, gsBac_Version
      box_forma_pago.SetFocus
      Exit Function
    End If
    
    gsmoneda = Str(BOX_MON_PAG.ItemData(BOX_MON_PAG.ListIndex))
    
    Tipo_op = "C"
    'JBH, 04-12-2009
    'Ver si se trata de Tickets Intramesa o no
    If optOpeIntramesa.Value = True Then
        ope_intramesa = True
    Else
        ope_intramesa = False
    End If
    
    '*********************************************************
    ' LIMPIO VARIABLES ASOCIADAS AL CONTROL DE MARGENES ART84
    '*********************************************************
    gstrFormOrigen = ""
    Set frmTemporal = Nothing
    
    gstrFormOrigen = Me.Name
    Set frmTemporal = Me
    
    
    'JBH, 04-12-2009
    Bac_Intermediario.cCodCarteraFin = ""
    Bac_Intermediario.cCodLibro = ""
    Bac_Intermediario.cCodCarteraSuper = ""
    Bac_Intermediario.Show vbModal
    
    Set frmTemporal = Nothing
    gstrFormOrigen = ""
    
    
    If giAceptar = True Then
        Screen.MousePointer = vbHourglass
        
        'JBH, 19-10-2009.  Si el rut es de CorpBanca, llamar a CP_GrabarCompra
        If Trim(rut_cli) = gsBac_RutC Then  '"97023000"
            Call CP_GrabarCompra
        Else
            'JBH, 22-12-2009
        numeroOp = CP_GrabarTx()
        If numeroOp > 0 Then
            
            '*************************************************
            ' CONFIRMACION DE PROCESO CONTROL MARGENES (ART84)
            ' ************************************************
            ' reviso si el Flag de encendido del proceso
            If blnProcesoArt84Activo("BEX") Then
                If glngNroTicket > 0 Then
                    If gblnAnalizaMargen Then
                        Call GeneraConfirmacionProceso(glngNroTicket, CLng(numeroOp), "BEX", gstrNrosOperacionesIBS)
                    Else
                        Call GeneraConfirmacionProceso("11111", CLng(numeroOp), "BEX", gstrNrosOperacionesIBS)
                    End If
                End If
            End If
        
        
            gsBac_User = auxUser
            gsUsuario = auxUser
            If Not ActualizaDigitador(numeroOp) Then
                MsgBox "No se pudo actualizar el Digitador en el movto. N° " & numeroOp, vbCritical
            End If
        End If
            'fin JBH, 22-12-2009
        End If
        Screen.MousePointer = vbDefault
    End If
    Exit Function
fallagrabar:
    MsgBox "Se ha producido el siguiente error:" & err.Description, vbCritical, gsBac_Version
End Function

Function CP_GrabarCompra()
'Esto implica grabar además, la Venta como contrapartida. JBH, 19-10-2009
'
'Primero, grabar la compra en MOV_ticketbonext
'
'-------------------------------------------------------------------------------
'( nRutcart ,     -- rut del due¤o de cartera.-
'  cTipcart ,     -- código tipo de cartera.-
'  nForpagi ,     -- código de forma de inicio
'  cTipcust ,     -- con l mina o sin lámina.- S/N
'  cRetiro  ,     -- tipo de retiro.-          V/I
'  cPagohoy ,     -- pago hoy o ma¤ana         H/M
'  cObserva ,     -- Observaciones
'  nRutcli  ,     -- Rut del cliente
'  fCPForm  )     -- Formulario de la compra.-
'-------------------------------------------------------------------------------
        
    On Error GoTo CP_GrabarCompraError
        
    Dim datos()
    Dim dNumdocu    As Double
    'JBH, 20-10-2009
    Dim dNumDocCompra As Double
    Dim dNumDocVenta As Double
    Dim valOperacionRelacionada As Double
    'fin JBH, 20-10-2009
    
    Dim iCorrela%
    Dim sMascara$, sInstSer$, sGenEmi$, sNemMon$, dNominal#, dTir#, sFecpcup$
    Dim dPvp#, dVPar#, dMt#, dMt100#, iNumUCup%, dTasEst#, sFecEmi$
    Dim sFecVen$, sMdse$, lCodigo&, sSerie$, iMonemi%, lRutemi&
    Dim dTasEmi#, iBasemi%
    Dim dTirMcd#, dPvpMcd#, dMtMcd#, dMtMcd100#
    Dim sFecPro$
    Dim FlagTx       As Boolean
    Dim Resultado%
    Dim Correlativo&
    Dim CorteMin#
    Dim cCustodiaDCV As String
    Dim cClaveDCV    As String
    Dim cCarteraSuper As String
'VB+- 27/06/2000 se crean estas variables para grabar en las compras propias estos datos
    Dim dConvexidad  As Double
    Dim dDuratMac    As Double
    Dim dDuratMod    As Double
    Dim iCodExeLIM   As Integer
    Dim dMtoExcLIM   As Double
    Dim iPlazo       As Integer
    Dim dMontoOriginal As Double
   
    Dim bExisteDPX      As Boolean
    Dim PagarPeso As Double
    Dim PendienteLinea  As String
   
    PendienteLinea = "P"
    bExisteDPX = False
    sFecPro = Format(gsBac_Fecp, feFECHA)
    ' Pone en falso indicando que todavia no se realiz un Begin Transaction
    FlagTx = False
    'mmp
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        GoTo CP_GrabarCompraError
    End If

    ' Indica inicio de Begin Transaction y se puede hacer el RollBack
    FlagTx = True
    
    ' Consulto el número de documento de tabla mdac (Mesa Dinero Archivo Control)
    ' Primera llamada, para generar el correlativo de la Compra
    If Not Bac_Sql_Execute("SP_OPMDAC_BONEXT") Then
        GoTo CP_GrabarCompraError
    End If
        
  ' Recupero el Numero de Documento
    If Bac_SQL_Fetch(datos()) Then
       dNumdocu = Val(datos(1)) + 1
       dNumDocCompra = dNumdocu
    End If
    
'********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then
        Dim Mensaje     As String
        Dim SwResp      As Integer
        Dim TCambio     As Double
        Mensaje = ""
        iCorrela% = 0
        If Trim$(Txt_Nemo.Text) <> "" Then
                If Mid(Trim$(Txt_Nemo.Text), 1, 3) = "DPX" Then
                    TCambio = 0
                Else
                    TCambio = gsBac_TCambio
                End If
        End If
    End If
    
    '********** Fin


    If Trim$(Txt_Nemo.Text) <> "" Then
                  
        ' Recupera datos del Data Control del Form enviado
                    
        Dim Op
        If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
            Op = Feriados_inter(txt_fec_pag.Text, Pais_invers)
        Else
            Op = Feriados_inter(txt_fec_pag.Text, Pais_invers)
        End If
        
        If Op = False Then
            MsgBox "Fecha De Pago en el Pais De origen Es Feriado", vbInformation, gsBac_Version
            Screen.MousePointer = 0
            txt_fec_pag.SetFocus
            Exit Function
        End If
        PagarPeso = Monto_a_Peso("CP", box_mon_emi.ItemData(box_mon_emi.ListIndex), CDbl(MT))
                 
        envia = Array()
        AddParam envia, gsBac_Fecp
        AddParam envia, CDbl(gsBac_RutC)
                
        AddParam envia, box_familia.ItemData(box_familia.ListIndex)
        
        If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
            AddParam envia, Trim(Txt_Nemo.Text)
        Else
            AddParam envia, box_familia.Text
        End If
        
        AddParam envia, Txt_Nemo.Text
        AddParam envia, CDbl(rut_cli)
        AddParam envia, Cod_cli
        AddParam envia, FE
        AddParam envia, FV
        AddParam envia, box_mon_emi.ItemData(box_mon_emi.ListIndex)
        AddParam envia, BOX_MON_PAG.ItemData(BOX_MON_PAG.ListIndex)
        AddParam envia, TE
        AddParam envia, BA
        AddParam envia, CDbl(Txt_rut_Emi.Text)
        AddParam envia, CDate(txt_fec_pag.Text)
        AddParam envia, CDbl(NOM)
        AddParam envia, CDbl(MT)
        AddParam envia, CDbl(VV)
        AddParam envia, CDbl(TR)
        AddParam envia, CDbl(PVP)
        AddParam envia, CDbl(VP)
        AddParam envia, CDbl(INDEV)
        AddParam envia, PRINC
        AddParam envia, CDbl(CI - 1)
        AddParam envia, CI
        AddParam envia, FU
        AddParam envia, FX
        AddParam envia, gsBac_User
        AddParam envia, ""
        AddParam envia, obseravcion
        AddParam envia, box_basilea.ItemData(box_basilea.ListIndex)
                
        If box_familia.ListIndex > 0 Then
            AddParam envia, 100
        Else
            AddParam envia, Val(Txt_Cod_tasa.Caption)
        End If

        If Op_Encaje_S.Value = True Then
            AddParam envia, "S"
        Else
            AddParam envia, "N"
        End If

        AddParam envia, 0
        AddParam envia, codigo_cartera_super
        AddParam envia, Tipo_Inversion
        AddParam envia, 0
        AddParam envia, 0
        AddParam envia, Tipo_Inversion
        AddParam envia, ""
        AddParam envia, ""
        AddParam envia, ""
                
        If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
            AddParam envia, CDbl(lbl_monto_emi.Caption)
        Else
            AddParam envia, 0
        End If
                
        If box_familia.ItemData(box_familia.ListIndex) = 2001 Then
            cusip = 2001
        Else
            If txt_cusip.ListIndex = -1 Then
                cusip = 0
            Else
                cusip = txt_cusip.ItemData(txt_cusip.ListIndex)
            End If
        End If
        
        AddParam envia, box_forma_pago.ItemData(box_forma_pago.ListIndex)
        AddParam envia, box_dia.Text & " - " & box_año.Text
        AddParam envia, CDbl(Cod_emi)
        AddParam envia, txt_fec_neg.Text
        AddParam envia, Trim(cusip)
        AddParam envia, dNumDocCompra
        AddParam envia, PendienteLinea
        AddParam envia, PagarPeso
                
        AddParam envia, CDbl(txtDur_Mac.Text)
        AddParam envia, CDbl(txtDur_Mod.Text)
        AddParam envia, CDbl(txtConvexi.Text)
                
        AddParam envia, Area_Responsable
        AddParam envia, libro
        'Nuevos parametros
        AddParam envia, cod_mesa_origen
        AddParam envia, cod_mesa_destino
        AddParam envia, cod_cartera_destino
                
        If Not Bac_Sql_Execute("SVA_CMP_GRB_OPE_BONEXT", envia) Then
            If FlagTx = True Then
                If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                    MsgBox "No se pudo grabar el registro de la Compra", vbCritical, gsBac_Version
                End If
            End If
            
            
            MsgBox "Operación de Compra " & dNumDocCompra & " no pudo ser grabada", vbCritical, gsBac_Version
            Exit Function
        Else
            'leer los resultados
            If Bac_SQL_Fetch(datos()) Then
                dNumDocCompra = Val(datos(2))
                dNumDocVenta = Val(datos(3))
            End If
            If dNumDocCompra <> 0 Then
                MsgBox "Operación Entre Tickets Grabada Con el Par " & dNumDocCompra & "/" & dNumDocVenta, vbInformation, gsBac_Version
                If giAceptar And Confirmacion = "1" Then
                    Call imp_fax(dNumdocu, "CPX")
                End If
        
                Call Clear_Objetos
            End If
            
        End If
    End If
                   
    
    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        GoTo CP_GrabarCompraError
    End If
    
    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Operación de Compra número: " & dNumDocCompra & " - " & dNumDocVenta & ", grabada con éxito.")
   
    CP_GrabarCompra = dNumdocu
   
    Exit Function


CP_GrabarCompraError:

    MsgBox "Se ha producido un problema en la grabación de la operación de compra: " & err.Description & ". Comunique al Administrador. ", vbCritical, gsBac_Version
           
    If FlagTx = True Then
        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
            MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
        End If
    End If
    CP_GrabarCompra = 0
    Exit Function
End Function
Function CP_GrabarTx()

'-------------------------------------------------------------------------------
'( nRutcart ,     -- rut del due¤o de cartera.-
'  cTipcart ,     -- código tipo de cartera.-
'  nForpagi ,     -- código de forma de inicio
'  cTipcust ,     -- con l mina o sin lámina.- S/N
'  cRetiro  ,     -- tipo de retiro.-          V/I
'  cPagohoy ,     -- pago hoy o ma¤ana         H/M
'  cObserva ,     -- Observaciones
'  nRutcli  ,     -- Rut del cliente
'  fCPForm  )     -- Formulario de la compra.-
'-------------------------------------------------------------------------------

On Error GoTo CP_GrabarTxError

Dim datos()
Dim dNumdocu    As Double
Dim iCorrela%
Dim sMascara$, sInstSer$, sGenEmi$, sNemMon$, dNominal#, dTir#, sFecpcup$
Dim dPvp#, dVPar#, dMt#, dMt100#, iNumUCup%, dTasEst#, sFecEmi$
Dim sFecVen$, sMdse$, lCodigo&, sSerie$, iMonemi%, lRutemi&
Dim dTasEmi#, iBasemi%
Dim dTirMcd#, dPvpMcd#, dMtMcd#, dMtMcd100#
Dim sFecPro$
Dim FlagTx       As Boolean
Dim Resultado%
Dim Correlativo&
Dim CorteMin#
Dim cCustodiaDCV As String
Dim cClaveDCV    As String
Dim cCarteraSuper As String
'VB+- 27/06/2000 se crean estas variables para grabar en las compras propias estos datos
Dim dConvexidad  As Double
Dim dDuratMac    As Double
Dim dDuratMod    As Double
Dim iCodExeLIM   As Integer
Dim dMtoExcLIM   As Double
Dim iPlazo       As Integer
Dim dMontoOriginal As Double
Dim dTipoCambio988 As Double
Dim bExisteDPX      As Boolean
Dim PagarPeso As Double
Dim PendienteLinea  As String
Dim Mensaje_Lin  As String
Dim Mensaje_Lim  As String
Dim Mens_Lim_Graba As String
Dim Mens_Lin_Graba As String
    
Dim ptInstr As String
Dim ptPlazo As Integer
Dim ptTasa As Double
Dim resControlPT As String  'PRD-3860, modo silencioso
Dim Mensaje_CPT As String
    
PendienteLinea = "P"

    ptInstr = box_familia.ItemData(box_familia.ListIndex)
    ptPlazo = DateDiff("D", gsBac_Fecp, CDate(txt_fec_vcto.Text))
    ptTasa = CDbl(txt_tir.Text)

    bExisteDPX = False
   ' dTipoCambio988 = FUNC_BUSCA_VALOR_MONEDA(998, Format(gsBac_Fecp, "DD/MM/YYYY"))

    sFecPro = Format(gsBac_Fecp, feFECHA)
                
  ' Pone en falso indicando que todavia no se realiz un Begin Transaction
    FlagTx = False
        
     'mmp
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        GoTo CP_GrabarTxError
    End If
        
  ' Indica inicio de Begin Transaction y se puede hacer el RollBack
    FlagTx = True
    
  ' Consulto el número de documento de tabla mdac (Mesa Dinero Archivo Control)
    If Not Bac_Sql_Execute("SP_OPMDAC") Then
        GoTo CP_GrabarTxError
    End If
        
  ' Recupero el Numero de Documento
   If Bac_SQL_Fetch(datos()) Then
       dNumdocu = Val(datos(1)) + 1
   End If
    
    '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then

        Dim Mensaje     As String
        Dim SwResp      As Integer
        Dim TCambio     As Double

        Mensaje = ""
        iCorrela% = 0
        If Trim$(Txt_Nemo.Text) <> "" Then
            
                If Mid(Trim$(Txt_Nemo.Text), 1, 3) = "DPX" Then
                    TCambio = 0
                Else
                    '+++jcamposd 20180517 se busca tambien para los coltes
                    If gsmoneda = 129 Then
                       TCambio = FUNC_BUSCA_VALOR_MONEDA_CONTABLE(129, Format(gsBac_Feca, "DD/MM/YYYY"))
                    '---jcamposd 20180517 se busca tambien para los coltes
                    Else
                        TCambio = gsBac_TCambio
                    End If
                End If
                
                                         
                If Not Lineas_ChequearGrabar("BEX", "CPX", dNumdocu, dNumdocu, 1, Txt_rut_Emi.Text, txt_cod_emi.Text, txt_monto_pag.Text, TCambio, gsBac_Fecp, Txt_rut_Emi.Text, box_mon_emi.ItemData(box_mon_emi.ListIndex), txt_fec_vcto.Text, box_familia.ItemData(box_familia.ListIndex), "S", box_mon_emi.ItemData(box_mon_emi.ListIndex), "C", 0, "N", 0, gsBac_Fecp, 0, box_forma_pago.ItemData(box_forma_pago.ListIndex), CDbl(TR), 0, box_familia.Text) Then 'txt_cod_emi.Text
                'If Not Lineas_ChequearGrabar("BEX", "CP", dNumdocu, dNumdocu, 1, Txt_rut_Emi.Text, txt_cod_emi.Text, Txt_Monto_Pag.Text, TCambio, gsBac_Fecp, Txt_rut_Emi.Text, box_mon_emi.ItemData(box_mon_emi.ListIndex), txt_fec_vcto.Text, box_familia.ItemData(box_familia.ListIndex), "S", 0, "C", 0, "N", 0, gsBac_Fecp, 0, txt_cod_emi.Text) Then 'estaba
                    GoTo CP_GrabarTxError
                End If
                
        End If
        
        Mensaje = Mensaje & Lineas_Chequear("BEX", "CP", dNumdocu, " ", " ", " ")
        
        If Mensaje <> "" Then
        
            MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical
            
            If FlagTx = True Then
                If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                    MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
                End If
            End If

            CP_GrabarTx = 0
            
            Exit Function
            
        End If
    
    End If
    
    '********** Fin


        If Trim$(Txt_Nemo.Text) <> "" Then
                  
          ' Recupera datos del Data Control del Form enviado
                    
                Dim Op
                If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
                     Op = Feriados_inter(txt_fec_pag.Text, Pais_invers)
                Else
                     Op = Feriados_inter(txt_fec_pag.Text, Pais_invers)
                End If
        
                 If Op = False Then
                     MsgBox "Fecha De Pago en el Pais De origen Es Feriado", vbInformation, gsBac_Version
                    Screen.MousePointer = 0
                     txt_fec_pag.SetFocus
                     Exit Function
                 End If
                 If box_familia.ItemData(box_familia.ListIndex) = 2004 Or box_familia.ItemData(box_familia.ListIndex) = 2005 Then   'VMM.Bonos_Brasileños
                    PagarPeso = CDbl(MT)                                                                                            'VMM.Bonos_Brasileños
                 Else                                                                                                               'VMM.Bonos_Brasileños
                    PagarPeso = Monto_a_Peso("CP", box_mon_emi.ItemData(box_mon_emi.ListIndex), CDbl(MT))
                 End If                                                                                                               'VMM.Bonos_Brasileños
                 
                envia = Array()
                AddParam envia, gsBac_Fecp
                AddParam envia, CDbl(gsBac_RutC)
                AddParam envia, box_familia.ItemData(box_familia.ListIndex)
        
                If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
                    AddParam envia, Trim(Txt_Nemo.Text)
                Else
                    AddParam envia, box_familia.Text
                End If
        
                AddParam envia, Txt_Nemo.Text
                AddParam envia, CDbl(rut_cli)
                AddParam envia, Cod_cli
                AddParam envia, FE
                AddParam envia, FV
                AddParam envia, box_mon_emi.ItemData(box_mon_emi.ListIndex)
                AddParam envia, BOX_MON_PAG.ItemData(BOX_MON_PAG.ListIndex)
                AddParam envia, TE
                AddParam envia, BA
                AddParam envia, CDbl(Txt_rut_Emi.Text)
                AddParam envia, CDate(txt_fec_pag.Text)
                AddParam envia, CDbl(NOM)
                AddParam envia, CDbl(MT)
                AddParam envia, CDbl(VV)
                AddParam envia, CDbl(TR)
                AddParam envia, CDbl(PVP)
                AddParam envia, CDbl(VP)
                AddParam envia, CDbl(INDEV)
                AddParam envia, PRINC
                AddParam envia, CDbl(CI - 1)
                AddParam envia, CI
                AddParam envia, FU
                AddParam envia, FX
                AddParam envia, gsBac_User
                AddParam envia, ""
                AddParam envia, obseravcion
                AddParam envia, box_basilea.ItemData(box_basilea.ListIndex)
                
                If box_familia.ListIndex > 0 Then
                    AddParam envia, 100
                Else
                    AddParam envia, Val(Txt_Cod_tasa.Caption)
                End If
        
                If Op_Encaje_S.Value = True Then
                    AddParam envia, "S"
                Else
                    AddParam envia, "N"
                End If
        
                AddParam envia, 0
                AddParam envia, codigo_cartera_super
                AddParam envia, Tipo_Inversion
                AddParam envia, Sucursal
                AddParam envia, corr_bco_bco
                AddParam envia, corr_bco_Cta
                AddParam envia, corr_bco_ABA
                AddParam envia, corr_bco_pais
                AddParam envia, 0
                AddParam envia, corr_bco_swi
                AddParam envia, corr_bco_ref
                AddParam envia, corr_cli_bco
                AddParam envia, corr_cli_Cta
                AddParam envia, (corr_cli_ABA)
                AddParam envia, corr_cli_pais
                AddParam envia, 0
                AddParam envia, corr_cli_swi
                AddParam envia, corr_cli_ref
                AddParam envia, Oper_Con
                AddParam envia, Oper_bech
                If calce = 1 Then
                    AddParam envia, "S"
                Else
                    AddParam envia, "N"
                End If
                AddParam envia, Tipo_Inversion
                AddParam envia, para_quien
                AddParam envia, ""
                AddParam envia, ""
                AddParam envia, ""
                AddParam envia, custodia
                
                If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
                    AddParam envia, CDbl(lbl_monto_emi.Caption)
                Else
                    AddParam envia, 0
                End If
                
                If box_familia.ItemData(box_familia.ListIndex) = 2001 Then
                    cusip = 2001
                Else
                    If txt_cusip.ListIndex = -1 Then
                       cusip = 0
                    Else
                       cusip = txt_cusip.ItemData(txt_cusip.ListIndex)
                    End If
                End If
        
                AddParam envia, CDbl(Confirmacion)
                AddParam envia, box_forma_pago.ItemData(box_forma_pago.ListIndex)
                AddParam envia, box_dia.Text & " - " & box_año.Text
                AddParam envia, CDbl(Cod_emi)
                AddParam envia, txt_fec_neg.Text
                AddParam envia, Trim(cusip)
                AddParam envia, dNumdocu
                AddParam envia, PendienteLinea
                AddParam envia, PagarPeso
                
                AddParam envia, CDbl(txtDur_Mac.Text)
                AddParam envia, CDbl(txtDur_Mod.Text)
                AddParam envia, CDbl(txtConvexi.Text)
                
                AddParam envia, Area_Responsable
                AddParam envia, libro
                
                If nPorcentajeImpuesto > 0 Then
                    '+++jcamposd deposito colombiano
                    AddParam envia, nPorcentajeImpuesto
                    AddParam envia, nValorImpuesto
                    '---jcamposd deposito colombiano
                Else
                    AddParam envia, 0
                    AddParam envia, 0
                End If
                
                If Not Bac_Sql_Execute("SVA_CMP_GRB_OPE", envia) Then
                    If FlagTx = True Then
                        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                            MsgBox "No se pudo grabar", vbCritical, gsBac_Version
                        End If
                    End If

                        MsgBox "Operación " & dNumdocu & " no pudo ser grabada", vbCritical, gsBac_Version
                        Exit Function
                Else
                    If dNumdocu <> 0 Then
                        If Ctrlpt_ModoOperacion = "S" Then
                            Mensaje_CPT = ""
                        Else
                            Mensaje_CPT = Ctrlpt_Mensaje
                            If Trim(Mensaje_CPT) <> "" Then
                                Mensaje_CPT = vbCrLf & vbCrLf & Mensaje_CPT
                            End If
                        End If
                    
                        MsgBox "Operación Grabada Con el Número " & dNumdocu & Mensaje_CPT, vbInformation, gsBac_Version
        
                        'Call Imprimir_Papeletas("CP", dNumdocu, gsBac_Papeleta, Trim(Mensaje_Con))
        
                        If giAceptar And Confirmacion = "1" Then
                            Call imp_fax(dNumdocu, "CPX")
                        End If
                        '+++CONTROL IDD, jcamposd rescatamos monto ART84
                        If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
                            Dim dblMontoarticulo84 As Double
                            Dim dblMontoaCalculo  As Double
                            Dim dblTipoCambioArt84 As Double
                            
                            dblMontoarticulo84 = CDbl(Bac_Compras.lbl_monto_prin.Caption)
                            If Bac_Compras.BOX_MON_PAG.ItemData(Bac_Compras.BOX_MON_PAG.ListIndex) = 999 Then
                                dblMontoaCalculo = dblMontoarticulo84
                            Else
                                dblTipoCambioArt84 = dblTraeTipoCambio(CLng(Bac_Compras.BOX_MON_PAG.ItemData(Bac_Compras.BOX_MON_PAG.ListIndex)))
                                dblMontoaCalculo = (dblMontoarticulo84 * dblTipoCambioArt84)
                            End If
                            dblMontoarticulo84 = Round(dblMontoaCalculo, 0)
                        Else
                            dblMontoarticulo84 = 0
                        End If
                        '---CONTROL IDD, jcamposd rescatamos monto ART84
                        Call Clear_Objetos
                    End If
        
                End If
        End If
                
        '********** Linea -- Mkilo
        If gsBac_Lineas = "S" Then
        
            If Not Lineas_GrbOperacion("BEX", "CP", dNumdocu, dNumdocu, " ", " ", " ") Then
                GoTo CP_GrabarTxError
            Else
            
                If MarcaAplicaLinea = 1 Then '--CONTROL IDD, jcampos si aplica ir al servicio
                
                    '+++CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
                    Dim oParametrosLinea As New clsControlLineaIDD
        
                    With oParametrosLinea
                        .Modulo = "BEX"
                        .Producto = "CP"
                        .Operacion = dNumdocu
                        .Documento = dNumdocu
                        .Correlativo = 1
                        .Accion = "Y"
        
                        .RecuperaDatosLineaIDD
                        
                        .MontoArticulo84 = dblMontoarticulo84
                        .EjecutaProcesoWsLineaIDD
                    End With
                    Set oParametrosLinea = Nothing
                    On Error GoTo sigueGrabacion ' Debe seguir proceso de grabación
                    '---CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
                End If
            
            End If
            
sigueGrabacion:
            Mensaje_Lin = ""
            Mensaje_Lim = ""
            Mens_Lin_Graba = ""
            Mens_Lim_Graba = ""
            If gsBac_Lineas = "S" Then
               Mensaje_Lin = Lineas_Error("BEX", CDbl(dNumdocu))
               Mensaje_Lim = Limites_Error("BEX", CDbl(dNumdocu))
               
             
                Mens_Lin_Graba = Mensaje_Lin
                Mens_Lim_Graba = Mensaje_Lim
             
                Mens_Lin_Graba = Replace(Mens_Lin_Graba, vbCrLf, "")
                Mens_Lin_Graba = Replace(Mens_Lin_Graba, Chr(10), "")
                Mens_Lin_Graba = Replace(Mens_Lin_Graba, "Problemas Lineas: ", "")
                
                Mens_Lim_Graba = Replace(Mens_Lim_Graba, vbCrLf, "")
                Mens_Lim_Graba = Replace(Mens_Lim_Graba, Chr(10), "")
                Mens_Lim_Graba = Replace(Mens_Lim_Graba, "Problemas Limites ", "")
               
                If Mens_Lim_Graba <> "" Or Mens_Lin_Graba <> "" Then
                    MsgBox (Mens_Lin_Graba + Mens_Lim_Graba), vbExclamation + vbOKOnly, "Inversion Exterior"
                End If
                
            End If
        End If
        '********** Fin
                   
 '   Call Imprimir_Papeletas("CP", dNumdocu, gsBac_Papeleta, Trim(Mensaje_Con))
                   
        If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
            GoTo CP_GrabarTxError
        End If
    
        'Grabar el Control de Precios y Tasas
        resControlPT = ControlPreciosTasas("CPX", ptInstr, ptPlazo, ptTasa, False)
        
        If Ctrlpt_AplicarControl Then
        
            If Ctrlpt_ModoOperacion = "S" Then
                    'Modo silencioso
                    Ctrlpt_codProducto = "CPX"
                    Ctrlpt_NumOp = dNumdocu
                    Ctrlpt_NumDocu = ""
                    Ctrlpt_TipoOp = "C"
                    Ctrlpt_Correlativo = 1
                    Call GrabaModoSilencioso
            Else
                    'grabar el instrumento ssi EnviarCF = "S"
                    If EnviarCF = "S" Then
                Ctrlpt_codProducto = "CPX"
                Ctrlpt_NumOp = dNumdocu
                Ctrlpt_NumDocu = ""
                Ctrlpt_TipoOp = "C"
                Ctrlpt_Correlativo = 1
                Call GrabaLineaPendPrecios
                Call GrabaModoSilencioso    'PRD-10494 Incidencia 1
            End If
        End If
    End If

    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Operación de Compra  número: " & dNumdocu & ", grabada con éxito.")
   
    CP_GrabarTx = dNumdocu
   
    Exit Function
        
        
CP_GrabarTxError:

    MsgBox "Se ha producido un problema en la grabación de la operación de compra: " & err.Description & ". Comunique al Administrador. ", vbCritical, gsBac_Version
           
    If FlagTx = True Then
        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
            MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
        End If
    End If
   
    CP_GrabarTx = 0
    Exit Function
    
End Function


Function llena_combo_base()
    
End Function

Function llena_combo_bases_tasas()
    Dim datos()
    box_dia.Clear
    box_año.Clear
    box_base.Clear
    If Bac_Sql_Execute("SVC_OPE_LEE_TAS") Then
        Do While Bac_SQL_Fetch(datos)
            box_dia.AddItem datos(1)
            box_año.AddItem datos(2)
            box_base.AddItem datos(3)
            box_base.ItemData(box_base.NewIndex) = Val(datos(2))
        Loop
    End If
End Function

Function Llena_Combo_basilea()
    Dim datos()
    box_basilea.Clear
    If Bac_Sql_Execute("SVC_GEN_IND_BAS") Then
        Do While Bac_SQL_Fetch(datos)
            box_basilea.AddItem datos(2)
            box_basilea.ItemData(box_basilea.NewIndex) = Val(datos(1))
        Loop
    End If
End Function

Function llena_combo_nemo()
    Dim datos()
    box_nemo.Clear
    If Bac_Sql_Execute("SVC_GEN_LEE_SER") Then
        Do While Bac_SQL_Fetch(datos)
            box_nemo.AddItem datos(2) & Space(20 - Len(datos(2))) & " (" & Format(datos(3), "DD/MM/YYYY") & ") "
            box_nemo.ItemData(box_nemo.NewIndex) = Val(datos(1))
        Loop
    End If
End Function

Function Retorna_num_ope()
    Retorna_num_ope = 0
    Dim datos()
    If Bac_Sql_Execute("SVA_OPE_STG_NUM") Then
        Do While Bac_SQL_Fetch(datos)
            If Not IsNull(datos(1)) Then
                Retorna_num_ope = datos(1) + 1
            End If
        Loop
    End If
End Function


Function valida_datos()

    valida_datos = True
    
    '>--+++jcamposd  20170407 control por fecha al perder foco solo debe aplicar si familia es 2004/2005
    If box_familia.ItemData(box_familia.ListIndex) = 2004 Or box_familia.ItemData(box_familia.ListIndex) = 2005 Then
        'MAP 20160804 Validar el ingreso de ISIN, CSIP, Etc.
        If txt_cusip.ListIndex = -1 And idInternacionalSN = "S" Then
            MsgBox "Asignar Identificador Internacional, listas en blanco requiere solicitar ingreso a Operaciones", vbExclamation, gsBac_Version
            valida_datos = False
            Exit Function
        End If
    End If
    '-----jcamposd 20170407
    
    If DateDiff("D", CDate(txt_fec_pag.Text), CDate(txt_fec_vcto.Text)) < 1 Then
        MsgBox "Instrumento esta Vencido", vbExclamation, gsBac_Version
        valida_datos = False
        Exit Function
    
    ElseIf Not IsDate(txt_fec_emi.Text) Then
        MsgBox "Falta Ingresar Fecha De Emisión", vbExclamation, gsBac_Version
        txt_fec_emi.SetFocus
        valida_datos = False
    ElseIf Not IsDate(txt_fec_vcto.Text) Then
        MsgBox "Falta Ingresar fecha De vencimiento", vbExclamation, gsBac_Version
        txt_fec_vcto.SetFocus
        valida_datos = False
    ElseIf Op_Encaje_S.Value = False And Op_Encaje_N.Value = False Then
'        frm_encaje.
        MsgBox "Falta Ingresar Tipo de Encaje", vbExclamation, gsBac_Version
        valida_datos = False
    ElseIf Txt_rut_Emi.Text = "" Or Txt_rut_Emi.Text = 0 Then
        MsgBox "Falta Ingresar Rut Emisor Fictisio", vbExclamation, gsBac_Version
        Txt_rut_Emi.SetFocus
        valida_datos = False

    ElseIf Trim(Txt_Nemo.Text) = "" Then
        MsgBox "Falta Ingresar Id.Instrumento", vbExclamation, gsBac_Version
        Txt_Nemo.SetFocus
        valida_datos = False
    ElseIf Not IsDate(txt_fec_pag.Text) Then
        MsgBox "Falta INgresar fecha De Pago", vbExclamation, gsBac_Version
        txt_fec_pag.SetFocus
        valida_datos = False
    ElseIf Not IsDate(txt_fec_neg.Text) Then
        MsgBox "Falta Ingresar Fecha De Negociación", vbExclamation, gsBac_Version
        txt_fec_neg.SetFocus
        valida_datos = False
    ElseIf CDbl(txt_nominal.Text) = 0 Then
        MsgBox "Falta Ingresar Nominal", vbExclamation, gsBac_Version
        txt_nominal.SetFocus
        valida_datos = False
    ElseIf CDbl(txt_monto_pag.Text) = 0 Then
        MsgBox "Falta Ingrsar Monto A Pagar", vbExclamation, gsBac_Version
        txt_monto_pag.SetFocus
        valida_datos = False
    
    ElseIf box_basilea.ListIndex = -1 Then
        MsgBox "Falta Ingrsar Basilea", vbExclamation, gsBac_Version
        box_basilea.SetFocus
        valida_datos = False
    
    End If
    
    If txt_cod_emi.Text = " " Then
        MsgBox "Ingrese Código de Emisor", vbInformation, gsBac_Version
        valida_datos = False
        txt_cod_emi.SetFocus
        Exit Function
    End If
    
    '+++jcamposd COP
    If codMonedaSel = 129 Then
        MontoEnPesos = (txt_nominal.Text * ValorMonedaCOP)
        
        If Len(MontoEnPesos) > 14 Then
            MsgBox "Por modelo de de negocios de la aplicación y salida de interfaces, el monto de la Inversión en moneda pesos Colombianos transformada a pesos Chilenos no puede superar los 14 dígitos de largo.", vbInformation, gsBac_Version
        End If
    
    End If
    '---jcamposd COP
    
End Function

Function Valorizar(ModCal)
Dim datos()
Dim Op
Op = DateDiff("D", txt_fec_emi.Text, txt_fec_vcto.Text)
    If Op < 0 And Me.frm_descrip.Enabled = True Then
        MsgBox "Fecha de Vencimiento Menor A Fecha De Emisión", vbCritical, gsBac_Version
        txt_fec_emi.SetFocus
    End If
    If Not IsDate(txt_fec_pag.Text) Then
        Exit Function
    End If
    
    If CDbl(txt_nominal.Text) = 0 Then
        Exit Function
    End If
    
    If ModCal = 1 And CDbl(txt_pre_por.Text) = 0 Then
        Exit Function
    End If
    
    If ModCal = 2 And CDbl(txt_tir.Text) = 0 Then
        Exit Function
    End If
    
    
    If ModCal = 3 And CDbl(txt_monto_pag.Text) = 0 Then
        Exit Function
    End If
    
    
    If Not IsDate(txt_fec_emi.Text) Then
        Exit Function
    End If
    
    
    If Not IsDate(txt_fec_vcto.Text) Then
        Exit Function
    End If
    
    If Not IsDate(txt_fec_neg.Text) Then
        Exit Function
    End If

    'If CDbl(txt_tasa_vig.Text) = 0 And box_mon_emi.ItemData(box_mon_emi.ListIndex) <> 129 And box_familia.ItemData(box_familia.ListIndex) = 2001 Then '+++jcamposd para CD en moneda colombia no considerar tasa <> 0
    If CDbl(txt_tasa_vig.Text) = 0 And (box_mon_emi.ItemData(box_mon_emi.ListIndex) = 129 Or box_familia.ItemData(box_familia.ListIndex) = 2001) Then '+++jcamposd para CD en moneda colombia no considerar tasa <> 0
        MsgBox "Debe ingresar tasa cupón", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    
    If DateDiff("D", CDate(txt_fec_pag.Text), CDate(txt_fec_vcto.Text)) < 1 Then
        MsgBox "Instrumento esta Vencido", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    
    Screen.MousePointer = 11

    
    TR = CDbl(txt_tir.Text)
    TE = CDbl(txt_tasa_vig.Text) - SPREAD
    TV = CDbl(txt_tasa_vig.Text) - SPREAD
    TT = 0
    BF = 0
    NOM = CDbl(txt_nominal.Text)
    MT = CDbl(txt_monto_pag.Text)
    VV = 0
    PVP = CDbl(txt_pre_por.Text)
    VAN = 0
    FP = CDate(txt_fec_pag.Text)
    FE = CDate(txt_fec_emi.Text)
    FV = CDate(txt_fec_vcto.Text)
    FU = CDate(txt_fec_vcto.Text)
    FX = CDate(txt_fec_vcto.Text)
    FC = CDate(txt_fec_pag.Text)
    CI = 0
    CT = 0
    INDEV = 0
    PRINC = 0
    INCTR = 0
    CAP = 0
    If box_familia.ItemData(box_familia.ListIndex) = 2006 Then
        BA = 360
    Else
        BA = CDbl(box_año.Text)
    End If
       
    envia = Array()
    AddParam envia, CDate(txt_fec_pag.Text)
    AddParam envia, " "
    AddParam envia, ModCal
    AddParam envia, box_familia.ItemData(box_familia.ListIndex)
    
    If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
        AddParam envia, Txt_Nemo.Text
    Else
        AddParam envia, box_familia.Text
    End If
    
    AddParam envia, txt_fec_vcto.Text
    AddParam envia, TR
    AddParam envia, TE
    AddParam envia, TV
    AddParam envia, TT
    AddParam envia, Val(BA)
    AddParam envia, BF
    AddParam envia, NOM
    AddParam envia, MT
    AddParam envia, VV
    AddParam envia, VP
    AddParam envia, PVP
    AddParam envia, VAN
    AddParam envia, FP
    AddParam envia, FE
    AddParam envia, FV
    AddParam envia, FU
    AddParam envia, FX
    AddParam envia, FC
    AddParam envia, CI
    AddParam envia, CT
    AddParam envia, INDEV
    AddParam envia, PRINC
    AddParam envia, FIP
    AddParam envia, CAP
    AddParam envia, INCTR
    AddParam envia, SPREAD
    
    AddParam envia, "S"
    AddParam envia, box_mon_emi.ItemData(box_mon_emi.ListIndex)
    Dim num
    
    If Bac_Sql_Execute("SVC_PRC_VAL_INS", envia) Then
        Do While Bac_SQL_Fetch(datos)
        
            txt_tir.Text = CDbl(datos(1))
            txt_tasa_vig.Text = CDbl(datos(2))
           
            txt_tasa_vig.Text = CDbl(datos(3)) + CDbl(datos(26))
            txt_nominal.Text = CDbl(datos(7))
            '+++jcamposd 20170117 para los CDTCOP debe mostrar el monto final, pero almacena valor presente
            If box_familia.ItemData(box_familia.ListIndex) = 2006 Then
                txt_monto_pag.Text = Format(CDbl(datos(9)), "###,###,###,##0.0000")
            Else
                txt_monto_pag.Text = CDbl(datos(8))
            End If
            '---jcamposd 20170117 para los CDTCOP debe mostrar el monto final, pero almacena valor presente
            lbl_val_venc.Caption = Format(CDbl(datos(9)), "###,###,###,##0.0000")
            txt_pre_por.Text = CDbl(datos(11))
'           txt_fec_neg.Text = Format(datos(13), "DD/MM/YYYY")
            txt_fec_emi.Text = Format(datos(14), "DD/MM/YYYY")
            txt_fec_vcto.Text = Format(datos(15), "DD/MM/YYYY")
            txt_fec_pag.Text = Format(datos(18), "dd/mm/yyyy")
            lbl_int_dev.Caption = Format(CDbl(datos(21)), "###,###,###,##0.0000")
            lbl_monto_prin.Caption = Format(CDbl(datos(22)), "###,###,###,##0.0000")
            
            TR = CDbl(datos(1))
            TV = CDbl(datos(3)) '+ CDbl(datos(26))
            MT = CDbl(datos(8))
            VV = CDbl(datos(9))
            VP = CDbl(datos(10))
            PVP = CDbl(datos(11))
            VAN = CDbl(datos(12))
            FU = CDate(Format(datos(16), "dd/mm/yyyy"))
            FX = CDate(Format(datos(17), "dd/mm/yyyy"))
            CI = CDbl((datos(19)))
            CT = CDbl((datos(20)))
            INDEV = CDbl(datos(21))
            PRINC = CDbl(datos(22))
            If CDbl(datos(44)) <> 1 Then
                lblFactor.Caption = "(Factor " & Format(CDbl(datos(44)), "#0.000000000") & ")"
            End If
            txtDur_Mac.Text = CDbl(datos(45))
            txtDur_Mod.Text = CDbl(datos(46))
            txtConvexi.Text = Format((datos(47) / 100#), "#,####,###,###,##0.0000") 'COLTES, jcampos CDbl(Datos(47))
            
        Loop
   End If
            
    Screen.MousePointer = 0
            
End Function

Private Sub box_base_Change()
    If box_base.ListIndex <> -1 Then
        BA = box_base.ItemData(box_base.ListIndex)
    End If
End Sub

Private Sub box_base_Click()
    box_dia.ListIndex = box_base.ListIndex
    box_año.ListIndex = box_base.ListIndex
End Sub


Private Sub box_base_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
        SendKeys "{TAB}"
End If
End Sub


Private Sub box_año_Click()

        SendKeys "{TAB}"

End Sub


Private Sub box_año_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub


Private Sub box_basilea_GotFocus()
    box_basilea.ListIndex = 0
End Sub


Private Sub box_basilea_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub



Private Sub box_dia_Click()
    SendKeys "{TAB}"
End Sub


Private Sub box_dia_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub


Private Sub box_familia_Click()


    If box_familia.ListIndex = -1 Then
        Exit Sub
    End If

    box_familia.Enabled = False
        
    If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
        box_nemo.Enabled = True
        box_año.Enabled = True
        box_dia.Enabled = True
        box_base.Enabled = True
'        Exit Sub
    Else
        Limpio = True
        txt_cod_emi.Visible = True
        Txt_rut_Emi.MousePointer = 14
        Txt_Nemo.Enabled = True
        Txt_Nemo.Text = box_familia.Text
        box_nemo.Enabled = False
        frm_descrip.Enabled = True
        frm_datos_op.Enabled = True
        txt_fec_vcto.Enabled = True
        txt_fec_emi.Enabled = True
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = True
        frm_basilea.Enabled = True
        Txt_rut_Emi.Enabled = True
        Txt_rut_Emi.BackColor = vbWhite
        box_mon_emi.Enabled = True
        BOX_MON_PAG.Enabled = True
        lbl_tip_tasa.Caption = "Fija"
        Txt_Cod_tasa.Caption = "0"
        i = 0

       ' box_forma_pago.ListIndex = 0
        box_basilea.ListIndex = 1
        box_dia.ListIndex = 0
        box_año.ListIndex = 0
        Op_Encaje_N.Value = True
        
        '--+++jcamposd para selecionar monedas (COP)
        If box_familia.ItemData(box_familia.ListIndex) = 2006 Then
            codMonedaSel = 129
            'ValorMonedaCOP = FUNC_BUSCA_VALOR_MONEDA_CONTABLE(129, Format(gsBac_Feca, "DD/MM/YYYY"))
            ModCal = 2
        Else
            codMonedaSel = 13
        End If
        '-----jcamposd para selecionar monedas (COP)
        
        For i = 0 To box_mon_emi.ListCount - 1
                box_mon_emi.ListIndex = i
                If box_mon_emi.ItemData(box_mon_emi.ListIndex) = codMonedaSel Then '--+++13 Then
                    Exit For
                End If
                box_mon_emi.ListIndex = -1
        Next
        For i = 0 To BOX_MON_PAG.ListCount - 1
                BOX_MON_PAG.ListIndex = i
                If BOX_MON_PAG.ItemData(BOX_MON_PAG.ListIndex) = codMonedaSel Then '--+++13 Then
                    Exit For
                End If
                BOX_MON_PAG.ListIndex = -1
        Next
        
        '+++jcamposd 20170407
        Call llena_combo_forma_pago(box_mon_emi.ItemData(box_mon_emi.ListIndex), BOX_MON_PAG.ItemData(BOX_MON_PAG.ListIndex), box_forma_pago)
        '---jcamposd 20170407
        
        box_dia.Enabled = True
        box_año.Enabled = True
        box_base.Enabled = True
        
        '--+++jcamposd debe aplicar impuesto en deposito colombiano(COP)
        If box_familia.ItemData(box_familia.ListIndex) = 2006 And box_mon_emi.ItemData(box_mon_emi.ListIndex) = 129 Then
            Lbl_impuesto.Visible = True
            Cmb_impuesto.Visible = True
            Cmb_impuesto.Enabled = False '--+++jcamposd 20161122 usuario pide que no sea utilizado
            TXT_impuesto.Visible = True
            Lbl_porImpuesto.Visible = True
            TXT_impuesto.Text = 0
            TXT_impuesto.Enabled = False
            box_base.ListIndex = 1
        End If
        '--+++jcamposd (COP)
        

        If box_familia.ListIndex = 1 Then
            frm_basilea.Enabled = True
        End If
        txtDur_Mac.Text = CDbl(0)
        txtDur_Mod.Text = CDbl(0)
        txtConvexi.Text = CDbl(0)
        
    End If
    'jcamposd se comenta control por familia
    'If box_familia.ItemData(box_familia.ListIndex) = 2004 Or box_familia.ItemData(box_familia.ListIndex) = 2005 Or box_familia.ItemData(box_familia.ListIndex) = 2000 Then
        'MAP 20160802 Ejecuta según parametrización
        Call Definicion_Familia(box_familia.ItemData(box_familia.ListIndex))
    'End If
    optOpeNormal.Value = True
    optOpeIntramesa.Value = False
    
End Sub
Function Definicion_Familia(Codigo_Familia As Integer)
    Dim datos()
    envia = Array()
    AddParam envia, Codigo_Familia
    If Bac_Sql_Execute("BacParamSuda.dbo.SP_CONSULTA_DATOS_FAMILIA_BONOS_EXT", envia) Then
        Do While Bac_SQL_Fetch(datos)
        
           Txt_rut_Emi.Text = datos(9)
           txt_cod_emi.Text = datos(10)
           Cod_emi = datos(10) 'MAP 20160810
           If datos(9) <> "0" Then
               Txt_rut_Emi.Enabled = False
               txt_cod_emi.Enabled = False
           End If
 
           
           lbl_emisor.Caption = datos(11)
           lbl_pais.Caption = datos(12)
           Call BuscaIDCombo(box_mon_emi, CStr(datos(5)))

           Call BuscaIDCombo(BOX_MON_PAG, CStr(datos(7)))
           Call box_mon_pag_LostFocus   ' MAP 20160802 Para evaluar el combo de monedas
           Let seriadoSN = datos(13)         'MAP 20160803
           Let idInternacionalSN = datos(14) 'MAP 20160803
           Let tipoPrecioPrcSN = datos(15)     'MAP 20160803
           Let NombreFamilia = datos(2)     'MAP 20160803
           Let BaseFamilia = datos(4)
           Let ConvBaseFamilia = datos(20) + " - " + datos(4)
           Let UsaBaseFamiliaSN = datos(19)

           Let ModificarMdaSN = datos(21)
           Let ModificarMdaPagSN = datos(22)
           
        Loop
    End If
    
    '+++jcamposd cdtcop debe ingresarse tasa cupon
    If Codigo_Familia <> 2006 Then
        txt_tasa_vig.Text = "1"  '' MAP 20160802 La idea es que no se requiera el valor
                                   '' Poner algo mas piolita
    End If
    
    Call Valorizar(ModCal)
    
   
    Label20.Caption = IIf(tipoPrecioPrcSN = "S", "Precio Porcentual", "Precio")
    Label1.Caption = IIf(tipoPrecioPrcSN = "S", "%", "x Tit.")
    Label1.FontSize = 8#

    'Call llena_combo_base
    Call llena_combo_bases_tasas
    Call BuscaIDCombo(box_base, BaseFamilia)
    
    If UsaBaseFamiliaSN = "N" Then
        box_base.Enabled = True
    Else
        box_base.Enabled = False
    End If
    
    If ModificarMdaSN = "N" Then
       box_mon_emi.Enabled = False
    Else
       box_mon_emi.Enabled = True
    End If
 
     If ModificarMdaPagSN = "N" Then
       BOX_MON_PAG.Enabled = False
    Else
       BOX_MON_PAG.Enabled = True
    End If
 
    
End Function

Private Sub BuscaIDCombo(COMBO As ComboBox, Valor As String)

    Dim Contador As Integer
    Contador = 0

    
    Do While Contador <= COMBO.ListCount - 1
        
       COMBO.ListIndex = Contador
       
       If COMBO.ItemData(COMBO.ListIndex) = Valor Then
           Exit Do
       End If
              
       Contador = Contador + 1
       
    Loop
    
    If Contador = COMBO.ListCount Then
       COMBO.ListIndex = 0
    End If


End Sub

Private Sub box_forma_pago_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub box_mon_emi_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        '+++jcamposd 20160905
        'Call manejaComboTasaCumpon
        '---jcamposd 20160905
        '+++jcamposd depositos colombianos
        If box_familia.ItemData(box_familia.ListIndex) = 2006 And box_mon_emi.ItemData(box_mon_emi.ListIndex) = 129 Then
            Lbl_impuesto.Visible = True
            Cmb_impuesto.Visible = True
            Cmb_impuesto.Enabled = False '--+++jcamposd 20161122 usuario pide que no sea utilizado
            TXT_impuesto.Visible = True
            Lbl_porImpuesto.Visible = True
            TXT_impuesto.Text = 0
            TXT_impuesto.Enabled = False
        End If
        '+++jcamposd depositos colombianos
        SendKeys "{TAB}"
    End If
End Sub

Private Sub box_mon_emi_LostFocus()
        '+++jcamposd depositos colombianos
        If box_familia.ItemData(box_familia.ListIndex) = 2006 And box_mon_emi.ItemData(box_mon_emi.ListIndex) = 129 Then
            Lbl_impuesto.Visible = True
            Cmb_impuesto.Visible = True
            Cmb_impuesto.Enabled = False '--+++jcamposd 20161122 usuario pide que no sea utilizado
            TXT_impuesto.Visible = True
            Lbl_porImpuesto.Visible = True
            TXT_impuesto.Text = 0
            TXT_impuesto.Enabled = False
        End If
        '+++jcamposd depositos colombianos
        SendKeys "{TAB}"
End Sub

Private Sub box_mon_pag_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        '+++jcamposd 20160905
        'Call manejaComboTasaCumpon
        '---jcamposd 20160905
        SendKeys "{TAB}"
    End If
End Sub

Private Sub box_mon_pag_LostFocus()

    '+++jcamposd 20160905
    'Call manejaComboTasaCumpon
    '---jcamposd 20160905
        
   If box_mon_emi.ListIndex <> -1 And box_mon_emi.ListIndex <> -1 Then
   Call llena_combo_forma_pago(box_mon_emi.ItemData(box_mon_emi.ListIndex), BOX_MON_PAG.ItemData(BOX_MON_PAG.ListIndex), box_forma_pago)
   End If
End Sub

Private Sub box_nemo_Click()

    Dim i As Integer


    If box_nemo.ListIndex = -1 Then
        Exit Sub
    End If
    'JBH, 04-12-2009
    If optOpeNormal.Value = False And optOpeIntramesa.Value = False Then
        MsgBox "No ha seleccionado el Tipo de la Operación (Normal/Intramesa)", vbExclamation, gsBac_Version
        box_nemo.ListIndex = -1
        Exit Sub
    End If
    'fin JBH, 04-12-2009
    i = 0
    If seriadoSN = "S" Then
      Call buscar_datos(2000, Mid(box_nemo.Text, 1, 20), Mid(box_nemo.Text, 23, 10))
    End If
    
    txt_nominal.Max = IIf(lbl_monto_emi.Caption = " ", "10000000000", lbl_monto_emi.Caption)
    txt_nominal.Min = 0  'Sale propiedad no valida...
    
    Txt_Nemo = IIf(seriadoSN = "S", Mid$(box_nemo.Text, 1, 20), Txt_Nemo)

End Sub

'+++jcamposd depositos colombianos
Private Sub Cmb_impuesto_click()
    If Cmb_impuesto.ListIndex = 0 Then
        Let nValorImpuesto = 0#
        Let nPorcentajeImpuesto = 0
    Else
        If lbl_int_dev.Caption <> "" Or lbl_int_dev.Caption <> 0 Then
            'TXT_impuesto.Text = CDbl(Cmb_impuesto.Text) * CDbl(lbl_int_dev.Caption)
            nPorcentajeImpuesto = Cmb_impuesto.List(Cmb_impuesto.ListIndex)
            TXT_impuesto.Text = Round((nPorcentajeImpuesto * CDbl(lbl_int_dev.Caption)) / 100, 0)
            Let nValorImpuesto = TXT_impuesto.Text
           
        End If
    End If
End Sub
'---jcamposd depositos colombianos

Private Sub Form_Activate()
    cTipo_Oper = "CPX"
End Sub

Private Sub Form_Load()
    Limpio = False
    Move 0, 0
    box_nemo.Enabled = False
    Toolbar1.Buttons(2).Visible = False
    Toolbar1.Buttons(3).Visible = False
    Call Clear_Objetos
    Call llena_combo_familia
    Call llena_combo_nemo
    Call Llena_Combo_basilea
    Call llena_combo_base
    Call Llena_Combo_monedas_pag
    Call Llena_Combo_modedas_emi
    'Call llena_combo_confirmacion
    '+++jcamposd depositos colombianos
    Call Llena_Combo_impuesto
    Lbl_impuesto.Visible = False
    Cmb_impuesto.Visible = False
    TXT_impuesto.Visible = False
    '+++jcamposd depositos colombianos
    Call llena_combo_bases_tasas
    TR = 0
    TE = 0
    TV = 0
    TT = 0
    BA = 0
    BF = 0
    NOM = 0
    MT = 0
    VV = 0
    VP = 0
    PVP = 0
    VAN = 0
    CI = 0
    CT = 0
    INDEV = 0
    Valoriza = False
    ModCal = 2
    frm_datos_op.Enabled = False
    frm_descrip.Enabled = False
    
    '+++jcamposd 20180518 COLTES
        ValorMonedaCOP = FUNC_BUSCA_VALOR_MONEDA_CONTABLE(129, Format(gsBac_Feca, "DD/MM/YYYY"))
    '---jcamposd 20180518 COLTES
    
    Call LeeModoControlPT   'PRD-3860, modo silencioso
    
    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Ingreso a Pantalla de Compras")
    
End Sub

Function llena_combo_familia()
    Dim datos()
    box_familia.Clear
    If Bac_Sql_Execute("SVC_GEN_FAM_INS") Then
        Do While Bac_SQL_Fetch(datos)
            box_familia.AddItem datos(2)
            box_familia.ItemData(box_familia.NewIndex) = Val(datos(1))
        Loop
    End If
End Function

Private Sub Text1_Change()

End Sub

Private Sub Option1_Click()

End Sub

Private Sub Option2_Click()

End Sub

Private Sub Form_Unload(Cancel As Integer)

    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Salida de Pantalla de Compras")

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim i
Select Case Button.Index
    
    Case BtnGrabar 'grabar y mostrar cuadro de informacion adicional
    'JBH, 04-12-2009
        If optOpeNormal.Value = False And optOpeIntramesa.Value = False Then
            MsgBox "No ha seleccionado el Tipo de la Operación (Normal/Intramesa)", vbExclamation, gsBac_Version
            Exit Sub
        End If
    'fin JBH, 04-12-2009
        If valida_datos Then
            Call Grabar_compra
        End If
        
    Case BtnBuscar
        If box_familia.ListIndex = -1 Then
            Exit Sub
        End If

        If box_familia.ItemData(box_familia.ListIndex) > 2000 Then
            lbl_tip_tasa.Caption = "Fija"
            lbl_cod_tasa.Caption = 1
            i = 0
            
            For i = 0 To box_base.ListCount - 1
                box_base.ListIndex = i
                If box_base.ItemData(box_base.ListIndex) = 360 Then
                    Exit For
                End If
                box_base.ListIndex = -1
            Next
            
            box_base.Enabled = True
            
            If box_familia.ListIndex = 1 Then
                frm_basilea.Enabled = True
                Option1.Value = True
            End If
            
            Exit Sub
        End If
        i = 0
        
        Call buscar_datos(2000, Mid(box_nemo.Text, 1, 20), Mid(box_nemo.Text, 23, 10))
        
        For i = 0 To box_moneda.ListCount - 1
            box_moneda.ListIndex = i
            If box_moneda.ItemData(box_moneda.ListIndex) = 13 Then
                Exit For
            End If
            box_moneda.ListIndex = -1
        Next
        
    Case BtnLimpiar
        Call Clear_Objetos
        box_familia.SetFocus
        
    Case BtnSalir
        Unload Me
End Select
End Sub

Function Llena_Combo_modedas_emi()
    Dim datos()
    box_mon_emi.Clear
    If Bac_Sql_Execute("SVC_OPE_COD_MON") Then
        Do While Bac_SQL_Fetch(datos)
            box_mon_emi.AddItem datos(2)
            box_mon_emi.ItemData(box_mon_emi.NewIndex) = Val(datos(1))
        Loop
            
    End If
End Function
Function Llena_Combo_monedas_pag()
    Dim datos()
    BOX_MON_PAG.Clear
    If Bac_Sql_Execute("SVC_OPE_COD_MON") Then
        Do While Bac_SQL_Fetch(datos)
            BOX_MON_PAG.AddItem datos(2)
            BOX_MON_PAG.ItemData(BOX_MON_PAG.NewIndex) = Val(datos(1))
        Loop
    End If
End Function
Private Sub txt_cod_emi_LostFocus()
    Call busca_datos(Txt_rut_Emi.Text, txt_cod_emi.Text)
End Sub
Private Sub txt_fec_emi_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Valoriza = True
        SendKeys "{TAB}"
    End If
End Sub
Private Sub txt_fec_emi_LostFocus()
    If Valoriza = True Then
        Call Valorizar(ModCal)
        Valoriza = False
    End If
End Sub
Private Sub txt_fec_neg_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
        Valoriza = True
    End If
End Sub

Private Sub txt_fec_neg_LostFocus()
    If Valoriza = True Then
        Call Valorizar(ModCal)
        Valoriza = False
    End If
    
End Sub


Private Sub txt_fec_pag_KeyPress(KeyAscii As Integer)
        
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
        Valoriza = True
    End If
End Sub
Private Sub txt_fec_pag_LostFocus()
Dim Op
Dim op2

    If CDate(txt_fec_pag.Text) < CDate(txt_fec_neg.Text) Then
        MsgBox "Fecha de Pago no puede ser menor a fecha de negociación ", vbInformation, gsBac_Version
        txt_fec_pag.SetFocus
        Exit Sub
    End If

    If box_familia.ListIndex > 0 Then
    
        If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
             Op = Feriados_inter(txt_fec_pag.Text, Pais_invers)
         Else
             Op = Feriados_inter(txt_fec_pag.Text, Pais_invers)
         End If
    
         If Op = False Then
             MsgBox "Fecha de pago en el Pais de origen es feriado", vbInformation, gsBac_Version
            Screen.MousePointer = 0
             txt_fec_pag.SetFocus
             Exit Sub
         End If
    End If
    
    If Valoriza = True Then
        Call Valorizar(ModCal)
        Valoriza = False
        Exit Sub
    End If
    

    If box_familia.ListIndex = -1 Then
        Exit Sub
    End If

    Op = CDbl(DateDiff("D", txt_fec_emi.Text, txt_fec_pag.Text))
    op2 = CDbl(DateDiff("D", txt_fec_pag.Text, txt_fec_vcto.Text))

    If Op < 0 Then
        MsgBox "Fecha de Pago No Debe Ser Menor Que La de Emisión", vbExclamation, gsBac_Version
        Exit Sub
    ElseIf op2 <= 0 Then
        MsgBox "Fecha de Pago No Debe Ser Mayor Que La de Vencimiento", vbExclamation, gsBac_Version
        Exit Sub
    End If
    
End Sub


Private Sub txt_fec_vcto_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Valoriza = True
        SendKeys "{TAB}"
    End If
End Sub


Private Sub lbl_int_dev_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        txt_nominal.SetFocus
    End If
End Sub


Private Sub txt_fec_vcto_LostFocus()
    Dim NemoArtificial As String
    '  if box_familia.ItemData(box_familia.ListIndex)
    '>--+++jcamposd  20170407 control por fecha al perder foco solo debe aplicar si familia es 2004/2005
    If box_familia.ListIndex <> -1 Then
        If box_familia.ItemData(box_familia.ListIndex) = 2004 Or box_familia.ItemData(box_familia.ListIndex) = 2005 Then
           If seriadoSN = "N" And idInternacionalSN = "S" Then
              Let NemoArtificial = "BRLTF20160907"
              Let NemoArtificial = NombreFamilia + Format(txt_fec_vcto.Text, "yyyymmdd")
              'Let box_nemo.Text = IIf(seriadoSN = "S", box_nemo.Text, NemoArtificial)
              box_nemo.AddItem NemoArtificial
              box_nemo.ItemData(box_nemo.NewIndex) = 99
              box_nemo.ListIndex = box_nemo.ListCount - 1
           End If
           If idInternacionalSN = "S" Then
              Call Busca_Identificadores(Trim(NemoArtificial))
              Txt_isin.Enabled = True
           End If
        End If
    End If '----->jcamposd 20170407
        
    Valoriza = True
    If Valoriza = True Then
        Call Valorizar(ModCal)
        Valoriza = False
    End If

End Sub

Private Sub txt_monto_emi_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_isin_Click()
   Dim iContador As Integer
  
        For iContador = 0 To txt_cusip.ListCount - 1
           If Txt_isin.ListIndex = -1 Then Exit Sub
            If txt_cusip.ItemData(iContador) = Txt_isin.ItemData(Txt_isin.ListIndex) Then
               txt_cusip.ListIndex = iContador
               Exit For
            Else
               txt_cusip.ListIndex = -1
            End If
        Next iContador
        For iContador = 0 To txt_bbnumber.ListCount - 1
            If txt_bbnumber.ItemData(iContador) = Txt_isin.ItemData(Txt_isin.ListIndex) Then
               txt_bbnumber.ListIndex = iContador
               Exit For
            Else
              txt_bbnumber.ListIndex = -1
            End If
        Next iContador
        For iContador = 0 To txt_mercado.ListCount - 1
            If txt_mercado.ItemData(iContador) = Txt_isin.ItemData(Txt_isin.ListIndex) Then
               txt_mercado.ListIndex = iContador
               Exit For
            Else
               txt_mercado.ListIndex = -1
            End If
        Next iContador
        
        For iContador = 0 To cbx_serie.ListCount - 1
            If cbx_serie.ItemData(iContador) = Txt_isin.ItemData(Txt_isin.ListIndex) Then
               cbx_serie.ListIndex = iContador
               Exit For
            Else
               cbx_serie.ListIndex = -1
            End If
        Next iContador
End Sub


Private Sub Txt_Monto_Pag_GotFocus()

    txt_monto_pag.Tag = txt_monto_pag.Text

End Sub

Private Sub txt_monto_pag_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        KeyAscii = 0
        txt_nominal.SetFocus
    End If

End Sub


Private Sub txt_monto_pag_LostFocus()
    'JBH, 11-12-2009
    If txt_monto_pag.Text < 0 Then
        MsgBox "Valor inválido en el Monto a Pagar!", vbExclamation, gsBac_Version
        txt_monto_pag.SetFocus
        Exit Sub
    End If
    'fin JBH, 11-12-2009

    If txt_monto_pag.Tag <> txt_monto_pag.Text Then
        ModCal = 3
        Call Valorizar(ModCal)
        Valoriza = False
    End If

End Sub

Private Sub Txt_Nemo_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub Txt_Nominal_GotFocus()

    txt_nominal.Tag = txt_nominal.Text

End Sub

Private Sub txt_nominal_KeyPress(KeyAscii As Integer)
    
    Dim MontoEnPesos As String

    If KeyAscii = 13 Then
        
        '+++jcamposd COP
        If codMonedaSel = 129 Then
            '+++jcamposd 20180517 se busca tambien para los coltes
            'ValorMonedaCOP = FUNC_BUSCA_VALOR_MONEDA_CONTABLE(129, Format(gsBac_Fecp, "DD/MM/YYYY"))
            '---jcamposd 20180517 se busca tambien para los coltes
            MontoEnPesos = (txt_nominal.Text * ValorMonedaCOP)
            
            If Len(MontoEnPesos) > 14 Then
                MsgBox "Por modelo de de negocios de la aplicación y salida de interfaces, el monto de la Inversión en moneda pesos Colombianos transformada a pesos Chilenos no puede superar los 14 dígitos de largo.", vbInformation, gsBac_Version
            End If
        
        End If
        '---jcamposd COP
        
        KeyAscii = 0
        txt_tir.SetFocus
        Valoriza = True
    End If
End Sub

Private Sub Txt_Nominal_LostFocus()
    If txt_nominal.Tag <> txt_nominal.Text Then
        Call Valorizar(ModCal)
        Valoriza = False
    End If
End Sub

Private Sub Txt_Pre_Por_GotFocus()
    txt_pre_por.Tag = txt_pre_por.Text
End Sub

Private Sub txt_pre_por_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        KeyAscii = 0
        txt_monto_pag.SetFocus
    End If

End Sub

Private Sub txt_pre_por_LostFocus()

    If txt_pre_por.Tag <> txt_pre_por.Text Then
        ModCal = 1
        Call Valorizar(ModCal)
        Valoriza = False
    End If

End Sub


Private Sub txt_rut_emi_Change()
    lbl_emisor.Caption = " "
     txt_cod_emi.Text = " "
End Sub

Private Sub txt_rut_emi_DblClick()
    BacAyuda.Tag = "EMISOR"
    BacAyuda.Show 1
    
    If giAceptar% = True Then
        Txt_rut_Emi.Text = CDbl(Trim(Mid(gsrut$, 44, 9)))
        lbl_emisor.Caption = Trim(Mid(gsrut$, 1, 40))
        Cod_emi = CDbl(Trim(Mid(gsrut$, 58, 1)))
        txt_cod_emi.Text = CDbl(Trim(Mid(gsrut$, 58, 1)))
        Call buscar_pais(Txt_rut_Emi.Text, Cod_emi)
        
    Else
        SendKeys "{TAB}"
    End If

End Sub

Function buscar_pais(rut, Cod_cli)
    Dim datos()
    envia = Array()
    AddParam envia, CDbl(rut)
    AddParam envia, CDbl(Cod_cli)
    If Bac_Sql_Execute("SVC_CMP_PAI_CLI", envia) Then
        Do While Bac_SQL_Fetch(datos)
            If datos(1) = "SI" Then
                lbl_pais.Caption = datos(2)
            Else
                lbl_pais.Caption = datos(2)
            End If
        Loop
    End If
End Function

Private Sub txt_rut_emi_KeyPress(KeyAscii As Integer)

    BacCaracterNumerico KeyAscii
    
    If KeyAscii = 13 Then SendKeys "{TAB}"
    
End Sub

Private Sub txt_tasa_vig_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
        SendKeys "{TAB}"
        Valoriza = True
    End If
End Sub

Private Sub txt_tasa_vig_LostFocus()
    If Valoriza = True Then
        Call Valorizar(ModCal)
        Valoriza = False
    End If
End Sub

Private Sub txt_tir_GotFocus()
    txt_tir.Tag = txt_tir.Text
End Sub

Private Sub txt_tir_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        KeyAscii = 0
        txt_pre_por.SetFocus
        Valoriza = True
    End If
End Sub

Private Sub txt_tir_LostFocus()
Dim codProducto As String
Dim Plazo As Integer
Dim Instrumento As String
Dim Tasa As Double

    If txt_tir.Tag <> txt_tir.Text Then
        ModCal = 2
        Call Valorizar(ModCal)
        Valoriza = False
    End If
    'Llamar al Control de Precios y Tasas
    codProducto = "CPX"
    If box_familia.ListIndex <> -1 Then
    Instrumento = box_familia.ItemData(box_familia.ListIndex)
    End If
    Plazo = DateDiff("D", gsBac_Fecp, CDate(txt_fec_vcto.Text))
    Tasa = txt_tir.Text
    If ControlPreciosTasas(codProducto, Instrumento, Plazo, Tasa) = "S" Then
        If Ctrlpt_ModoOperacion <> "S" Then 'PRD-3860, modo silencioso
        MsgBox Ctrlpt_Mensaje, vbExclamation, TITSISTEMA
    End If
    End If
    
End Sub

Private Sub txtNumero1_NumeroInvalido()

End Sub

Private Sub txtNumero3_NumeroInvalido()

End Sub
Function Fecha_Es_Habil_Nueva(Fecha, pais) As Boolean

    Dim datos()
    Dim Feriados As String
    Dim Ano As Double
    Dim Mes As Double
    Dim Dia As Double
    Dim dia_1 As Integer
    Dim i As Double
    envia = Array()
    AddParam envia, Fecha
    AddParam envia, pais
    AddParam envia, 0
    If Bac_Sql_Execute("BacParamSuda.dbo.SP_MUESTRAFECHAVALIDA ", envia) Then
        Do While Bac_SQL_Fetch(datos)
            If datos(1) = Fecha Then
                Fecha_Es_Habil_Nueva = True
                Exit Function
            Else
                Proximo_Habil_Nueva = False
            End If
        Loop
    End If
End Function

Function Fecha_Prox_Habil_Nueva(Fecha, pais) As Date
    Dim fechaAux As Date
    fecaux = DateAdd("d", 1, Fecha)
    Do While Not Fecha_Es_Habil_Nueva(fecaux, pais)
       fecaux = DateAdd("d", 1, Fecha)
    Loop
    Fecha_Prox_Habil_Nueva = fecaux
End Function

'+++jcamposd 20160905
Private Sub manejaComboTasaCumpon()

        If box_mon_emi.ItemData(box_mon_emi.ListIndex) = 129 And box_familia.ItemData(box_familia.ListIndex) = 2001 Then
            txt_tasa_vig.Enabled = False
        Else
            txt_tasa_vig.Enabled = True
        End If
 End Sub
'---jcamposd 20160905

Function Llena_Combo_impuesto()
    Cmb_impuesto.Clear
    Cmb_impuesto.AddItem "-":   Cmb_impuesto.ItemData(Cmb_impuesto.NewIndex) = 0
    Cmb_impuesto.AddItem "4":   Cmb_impuesto.ItemData(Cmb_impuesto.NewIndex) = 1
    Cmb_impuesto.AddItem "5":   Cmb_impuesto.ItemData(Cmb_impuesto.NewIndex) = 2
    Let Cmb_impuesto.ListIndex = 0
    
End Function
