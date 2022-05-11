VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form Bac_Intermediario 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Datos Generales Operación"
   ClientHeight    =   9000
   ClientLeft      =   1410
   ClientTop       =   405
   ClientWidth     =   9390
   Icon            =   "bac_intermediario.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   9000
   ScaleWidth      =   9390
   Begin VB.Frame frmOperador 
      Height          =   675
      Left            =   0
      TabIndex        =   83
      Top             =   8280
      Visible         =   0   'False
      Width           =   9255
      Begin VB.ComboBox cmbOperador 
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
         Left            =   4800
         Style           =   2  'Dropdown List
         TabIndex        =   84
         Top             =   240
         Width           =   4335
      End
      Begin VB.Label lblOperador 
         Caption         =   "Seleccione Operador"
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
         Left            =   2640
         TabIndex        =   85
         Top             =   300
         Visible         =   0   'False
         Width           =   1935
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   30
      Top             =   0
      Width           =   9390
      _ExtentX        =   16563
      _ExtentY        =   847
      ButtonWidth     =   714
      ButtonHeight    =   688
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   2145
         Top             =   45
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
               Picture         =   "bac_intermediario.frx":030A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_intermediario.frx":075C
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_intermediario.frx":0BAE
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_intermediario.frx":0EC8
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_intermediario.frx":11E2
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FrmCombos 
      Height          =   7200
      Left            =   10050
      TabIndex        =   68
      Top             =   525
      Visible         =   0   'False
      Width           =   1950
      Begin VB.Frame Frm_Libro 
         Caption         =   "Libro"
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
         Height          =   675
         Left            =   60
         TabIndex        =   74
         Top             =   2220
         Width           =   3255
      End
      Begin VB.Frame Frm_Cartera_Norm 
         Caption         =   "Cartera Normativa"
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
         ForeColor       =   &H00800000&
         Height          =   675
         Left            =   45
         TabIndex        =   72
         Top             =   1530
         Visible         =   0   'False
         Width           =   3255
         Begin VB.ComboBox Cmb_Cartera_Normativa 
            Height          =   315
            Left            =   45
            Style           =   2  'Dropdown List
            TabIndex        =   73
            Top             =   285
            Width           =   3165
         End
      End
      Begin VB.Frame Frm_Cartera 
         Caption         =   "Cartera Financiera"
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
         ForeColor       =   &H00800000&
         Height          =   675
         Left            =   135
         TabIndex        =   70
         Top             =   4170
         Visible         =   0   'False
         Width           =   3255
         Begin VB.ComboBox Cmb_Cartera 
            Height          =   315
            Left            =   45
            Style           =   2  'Dropdown List
            TabIndex        =   71
            Top             =   285
            Width           =   3165
         End
      End
      Begin VB.Frame FrmAreaResp 
         Caption         =   "Area Responsable"
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
         Height          =   675
         Left            =   60
         TabIndex        =   69
         Top             =   135
         Width           =   3255
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Datos Generales"
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
      Height          =   3615
      Left            =   30
      TabIndex        =   31
      Top             =   4650
      Width           =   9225
      Begin VB.CheckBox ChkControlLinea 
         Alignment       =   1  'Right Justify
         Caption         =   "Control de Línea"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   255
         Left            =   120
         TabIndex        =   88
         Top             =   2880
         Value           =   1  'Checked
         Width           =   2000
      End
      Begin VB.ComboBox cmbMesaOrigen 
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
         Left            =   6225
         Style           =   2  'Dropdown List
         TabIndex        =   86
         Top             =   840
         Width           =   2700
      End
      Begin VB.ComboBox cmbCarteraDestino 
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
         Left            =   6240
         Style           =   2  'Dropdown List
         TabIndex        =   81
         Top             =   1800
         Visible         =   0   'False
         Width           =   2895
      End
      Begin VB.ComboBox cmbMesaDestino 
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
         Left            =   6240
         Style           =   2  'Dropdown List
         TabIndex        =   79
         Top             =   1320
         Visible         =   0   'False
         Width           =   2895
      End
      Begin VB.ComboBox Cmb_Area_Responsable 
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
         ForeColor       =   &H00C00000&
         Height          =   315
         Left            =   1905
         Style           =   2  'Dropdown List
         TabIndex        =   17
         Top             =   1410
         Width           =   2610
      End
      Begin VB.ComboBox Cmb_Libro 
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
         ForeColor       =   &H00C00000&
         Height          =   315
         Left            =   1905
         Style           =   2  'Dropdown List
         TabIndex        =   14
         Top             =   375
         Width           =   2610
      End
      Begin VB.ComboBox box_forma_pago 
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
         Left            =   6075
         Style           =   2  'Dropdown List
         TabIndex        =   66
         Top             =   825
         Width           =   1980
      End
      Begin VB.ComboBox cmbCustodia 
         Height          =   315
         Left            =   5910
         Style           =   2  'Dropdown List
         TabIndex        =   64
         Top             =   400
         Width           =   3255
      End
      Begin VB.ComboBox box_confirma 
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
         Left            =   1905
         Style           =   2  'Dropdown List
         TabIndex        =   22
         Top             =   3195
         Visible         =   0   'False
         Width           =   2445
      End
      Begin VB.TextBox txt_oper_con 
         BackColor       =   &H00C0C0C0&
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
         ForeColor       =   &H00800000&
         Height          =   330
         Left            =   4395
         TabIndex        =   20
         Top             =   3195
         Visible         =   0   'False
         Width           =   3255
      End
      Begin VB.TextBox txt_cod_ofi 
         BackColor       =   &H00C0C0C0&
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
         Left            =   8550
         TabIndex        =   60
         Top             =   195
         Visible         =   0   'False
         Width           =   555
      End
      Begin VB.ComboBox box_oper_con 
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
         ForeColor       =   &H00C00000&
         Height          =   315
         ItemData        =   "bac_intermediario.frx":14FC
         Left            =   1905
         List            =   "bac_intermediario.frx":14FE
         Style           =   2  'Dropdown List
         TabIndex        =   19
         Top             =   2100
         Width           =   2610
      End
      Begin VB.ComboBox CmbParaQuien 
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
         ForeColor       =   &H00C00000&
         Height          =   315
         ItemData        =   "bac_intermediario.frx":1500
         Left            =   1905
         List            =   "bac_intermediario.frx":1502
         Style           =   2  'Dropdown List
         TabIndex        =   18
         Top             =   1755
         Width           =   2610
      End
      Begin VB.ComboBox CmbTipoInv 
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
         ForeColor       =   &H00C00000&
         Height          =   315
         ItemData        =   "bac_intermediario.frx":1504
         Left            =   1905
         List            =   "bac_intermediario.frx":1506
         Style           =   2  'Dropdown List
         TabIndex        =   16
         Top             =   1065
         Width           =   2610
      End
      Begin VB.TextBox Txt_Observ 
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
         Height          =   300
         Left            =   1905
         TabIndex        =   21
         Top             =   2490
         Width           =   6945
      End
      Begin VB.ComboBox cboCarteraSuper 
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
         ForeColor       =   &H00C00000&
         Height          =   315
         ItemData        =   "bac_intermediario.frx":1508
         Left            =   1905
         List            =   "bac_intermediario.frx":150A
         Style           =   2  'Dropdown List
         TabIndex        =   15
         Top             =   720
         Width           =   2610
      End
      Begin VB.TextBox txt_oficina 
         BackColor       =   &H00C0C0C0&
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
         ForeColor       =   &H80000007&
         Height          =   300
         Left            =   4695
         TabIndex        =   59
         Top             =   210
         Visible         =   0   'False
         Width           =   3810
      End
      Begin VB.Frame frm_basilea 
         Height          =   420
         Left            =   7695
         TabIndex        =   54
         Top             =   3105
         Visible         =   0   'False
         Width           =   1140
         Begin VB.CheckBox Check1 
            Caption         =   "Chk_Calce"
            ForeColor       =   &H00800000&
            Height          =   210
            Left            =   765
            TabIndex        =   23
            Top             =   165
            Width           =   210
         End
         Begin VB.Label Label 
            Caption         =   "Calce"
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
            Index           =   1
            Left            =   75
            TabIndex        =   58
            Top             =   165
            Width           =   780
         End
      End
      Begin VB.Label lblNombreMesaOrigen 
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
         Left            =   6240
         TabIndex        =   82
         Top             =   2145
         Visible         =   0   'False
         Width           =   2895
      End
      Begin VB.Label lblCarteraDestino 
         Caption         =   "Cartera Destino"
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
         Left            =   4680
         TabIndex        =   80
         Top             =   1800
         Visible         =   0   'False
         Width           =   1455
      End
      Begin VB.Label lblMesaDestino 
         Caption         =   "Contraparte"
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
         Left            =   4680
         TabIndex        =   78
         Top             =   1320
         Visible         =   0   'False
         Width           =   1455
      End
      Begin VB.Label lblMesaOrigen 
         Caption         =   "Portafolio"
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
         Height          =   375
         Left            =   4680
         TabIndex        =   77
         Top             =   840
         Visible         =   0   'False
         Width           =   1455
      End
      Begin VB.Label Label26 
         AutoSize        =   -1  'True
         Caption         =   "Libro"
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
         Height          =   195
         Left            =   120
         TabIndex        =   76
         Top             =   435
         Width           =   435
      End
      Begin VB.Label Label25 
         AutoSize        =   -1  'True
         Caption         =   "Area Responsable"
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
         Height          =   195
         Left            =   120
         TabIndex        =   75
         Top             =   1455
         Width           =   1560
      End
      Begin VB.Label Label19 
         Caption         =   "Custodia"
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
         Height          =   180
         Left            =   4740
         TabIndex        =   57
         Top             =   405
         Width           =   990
      End
      Begin VB.Label Label24 
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
         Height          =   255
         Left            =   4740
         TabIndex        =   67
         Top             =   840
         Width           =   1245
      End
      Begin VB.Label Label21 
         AutoSize        =   -1  'True
         Caption         =   "Vía Confirm."
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
         Height          =   195
         Left            =   120
         TabIndex        =   62
         Top             =   3225
         Visible         =   0   'False
         Width           =   1065
      End
      Begin VB.Label Label20 
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
         Height          =   285
         Left            =   4335
         TabIndex        =   61
         Top             =   720
         Width           =   3405
      End
      Begin VB.Label Label18 
         AutoSize        =   -1  'True
         Caption         =   "Por Cuenta de "
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
         Height          =   195
         Left            =   105
         TabIndex        =   56
         Top             =   1800
         Width           =   1290
      End
      Begin VB.Label Label16 
         AutoSize        =   -1  'True
         Caption         =   "Cartera Financiera"
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
         Height          =   195
         Left            =   105
         TabIndex        =   55
         Top             =   1110
         Width           =   1575
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         Caption         =   "Observacion"
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
         Height          =   195
         Left            =   105
         TabIndex        =   43
         Top             =   2520
         Width           =   1080
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "Cartera Super"
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
         Height          =   195
         Left            =   90
         TabIndex        =   42
         Top             =   780
         Width           =   1185
      End
      Begin VB.Label Label 
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
         ForeColor       =   &H8000000D&
         Height          =   285
         Index           =   3
         Left            =   8565
         TabIndex        =   41
         Top             =   -15
         Visible         =   0   'False
         Width           =   615
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Oficina"
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
         Height          =   195
         Index           =   12
         Left            =   4635
         TabIndex        =   40
         Top             =   -15
         Visible         =   0   'False
         Width           =   615
      End
      Begin VB.Label Label13 
         AutoSize        =   -1  'True
         Caption         =   "Op.Contraparte"
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
         Height          =   195
         Left            =   105
         TabIndex        =   39
         Top             =   2145
         Width           =   1305
      End
   End
   Begin VB.Frame Frm_destino 
      Caption         =   "Corresponsal Contraparte"
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
      Height          =   1605
      Left            =   15
      TabIndex        =   25
      Top             =   1380
      Width           =   9225
      Begin VB.TextBox txt_CorCli_Ref 
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
         Height          =   300
         Left            =   1935
         TabIndex        =   8
         Top             =   1230
         Width           =   7215
      End
      Begin VB.TextBox txt_CorCli_Swi 
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
         Height          =   300
         Left            =   5820
         TabIndex        =   7
         Top             =   900
         Width           =   3330
      End
      Begin VB.TextBox txt_CorCli_ABA 
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
         Height          =   300
         Left            =   1935
         TabIndex        =   6
         Top             =   900
         Width           =   2445
      End
      Begin VB.TextBox txt_CorCli_Cta 
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
         Height          =   300
         Left            =   1935
         TabIndex        =   5
         Top             =   570
         Width           =   2445
      End
      Begin VB.TextBox txt_CorCli_Pais 
         BackColor       =   &H00C0C0C0&
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
         Height          =   300
         Left            =   5820
         TabIndex        =   24
         Top             =   570
         Width           =   3315
      End
      Begin VB.TextBox txt_CorCli_destino 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   1935
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   4
         Top             =   240
         Width           =   7200
      End
      Begin VB.Label Label1 
         Caption         =   "Referencia"
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
         Height          =   270
         Left            =   150
         TabIndex        =   45
         Top             =   1230
         Width           =   1095
      End
      Begin VB.Label Label9 
         Caption         =   "Código SWIFT"
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
         Height          =   270
         Left            =   4470
         TabIndex        =   44
         Top             =   900
         Width           =   1500
      End
      Begin VB.Label Label10 
         Caption         =   "Código ABA"
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
         Height          =   270
         Left            =   150
         TabIndex        =   29
         Top             =   900
         Width           =   1425
      End
      Begin VB.Label Label6 
         Caption         =   "Número Cta."
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
         Height          =   270
         Left            =   150
         TabIndex        =   28
         Top             =   570
         Width           =   1425
      End
      Begin VB.Label Label5 
         Caption         =   "País"
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
         Height          =   270
         Left            =   4470
         TabIndex        =   27
         Top             =   570
         Width           =   1500
      End
      Begin VB.Label Label4 
         Caption         =   "Banco"
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
         Height          =   270
         Left            =   150
         TabIndex        =   26
         Top             =   255
         Width           =   1095
      End
   End
   Begin VB.Frame frm_cliente 
      Caption         =   "Contraparte"
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
      Height          =   885
      Left            =   0
      TabIndex        =   32
      Top             =   465
      Width           =   9240
      Begin VB.TextBox txt_cusip 
         Height          =   315
         Left            =   1560
         MaxLength       =   12
         TabIndex        =   3
         Top             =   1290
         Visible         =   0   'False
         Width           =   2475
      End
      Begin VB.TextBox txt_cod_contra 
         Height          =   315
         Left            =   1545
         MaxLength       =   30
         TabIndex        =   2
         Top             =   915
         Visible         =   0   'False
         Width           =   4245
      End
      Begin VB.TextBox txtDigCli 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   315
         Left            =   8895
         MaxLength       =   1
         TabIndex        =   38
         Top             =   420
         Visible         =   0   'False
         Width           =   270
      End
      Begin VB.TextBox TxtCodCli 
         Height          =   315
         Left            =   1545
         MaxLength       =   7
         TabIndex        =   1
         Top             =   420
         Width           =   885
      End
      Begin VB.TextBox txtRutCli 
         Alignment       =   1  'Right Justify
         Height          =   315
         Left            =   165
         MaxLength       =   9
         MouseIcon       =   "bac_intermediario.frx":150C
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   0
         Top             =   420
         Width           =   1200
      End
      Begin VB.Label LblEstadoCliente 
         Caption         =   "Cliente No se encuentra Vigente"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   195
         Left            =   3600
         TabIndex        =   87
         Top             =   150
         Width           =   5175
      End
      Begin VB.Label Label23 
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
         Height          =   255
         Left            =   150
         TabIndex        =   65
         Top             =   1320
         Visible         =   0   'False
         Width           =   1455
      End
      Begin VB.Label Label22 
         Caption         =   "FFC_A/C#"
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
         Height          =   225
         Left            =   165
         TabIndex        =   63
         Top             =   975
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.Label Label 
         Caption         =   "Codigo"
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
         Left            =   1605
         TabIndex        =   37
         Top             =   195
         Width           =   765
      End
      Begin VB.Label Label 
         Alignment       =   2  'Center
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   0
         Left            =   1320
         TabIndex        =   36
         Top             =   435
         Visible         =   0   'False
         Width           =   285
      End
      Begin VB.Label Label 
         Caption         =   "RUT"
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
         Index           =   5
         Left            =   165
         TabIndex        =   35
         Top             =   195
         Width           =   825
      End
      Begin VB.Label Label17 
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
         Height          =   225
         Left            =   2490
         TabIndex        =   34
         Top             =   195
         Width           =   675
      End
      Begin VB.Label lbl_nom_cli 
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
         Height          =   315
         Left            =   2490
         TabIndex        =   33
         Top             =   420
         Width           =   6360
      End
   End
   Begin VB.Frame frm_banco 
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
      Height          =   1560
      Left            =   15
      TabIndex        =   46
      Top             =   3045
      Width           =   9225
      Begin VB.TextBox txt_CorBco_Des 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   1875
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   9
         Top             =   195
         Width           =   7275
      End
      Begin VB.TextBox txt_CorBco_Pais 
         BackColor       =   &H00C0C0C0&
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
         Height          =   300
         Left            =   6015
         TabIndex        =   47
         Top             =   525
         Width           =   3120
      End
      Begin VB.TextBox txt_CorBco_Cta 
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
         Height          =   300
         Left            =   1875
         TabIndex        =   10
         Top             =   525
         Width           =   2445
      End
      Begin VB.TextBox txt_CorBco_ABA 
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
         Height          =   300
         Left            =   1875
         TabIndex        =   11
         Top             =   855
         Width           =   2445
      End
      Begin VB.TextBox txt_CorBco_Swi 
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
         Height          =   300
         Left            =   6015
         TabIndex        =   12
         Top             =   855
         Width           =   3135
      End
      Begin VB.TextBox txt_CorBco_Ref 
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
         Height          =   300
         Left            =   1875
         TabIndex        =   13
         Top             =   1185
         Width           =   7275
      End
      Begin VB.Label Label15 
         Caption         =   "Banco"
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
         Height          =   270
         Left            =   150
         TabIndex        =   53
         Top             =   210
         Width           =   1095
      End
      Begin VB.Label Label14 
         Caption         =   "País"
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
         Height          =   270
         Left            =   4650
         TabIndex        =   52
         Top             =   525
         Width           =   1500
      End
      Begin VB.Label Label12 
         Caption         =   "Número Cta."
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
         Height          =   270
         Left            =   150
         TabIndex        =   51
         Top             =   525
         Width           =   1425
      End
      Begin VB.Label Label11 
         Caption         =   "Código ABA"
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
         Height          =   270
         Left            =   150
         TabIndex        =   50
         Top             =   855
         Width           =   1425
      End
      Begin VB.Label Label3 
         Caption         =   "Código SWIFT"
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
         Height          =   270
         Left            =   4650
         TabIndex        =   49
         Top             =   855
         Width           =   1500
      End
      Begin VB.Label Label2 
         Caption         =   "Referencia"
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
         Height          =   270
         Left            =   150
         TabIndex        =   48
         Top             =   1185
         Width           =   1095
      End
   End
End
Attribute VB_Name = "Bac_Intermediario"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim ObjEmisor      As New clsEmisor
Dim ObjCliente      As New clsCliente
Dim ObjTipoInv      As New clsCodigos
Dim ObjParaQuien    As New clsCodigos
Dim Moneda          As Integer


Public cCodCarteraSuper As String
Public cCodLibro        As String
Public cCodCarteraFin   As String

Function busca_rut(rut)
    Dim Datos()
    busca_rut = 0
    envia = Array()
    AddParam envia, CDbl(rut)
    If Bac_Sql_Execute("SVC_OPE_DAT_EMI", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            'If datos(1) <> 0 Then
            '    lbl_nom_cli.Caption = datos(1)
            'End If
        Loop
    End If
    If Datos(1) = 0 Then
        MsgBox "Rut Inexistente", vbExclamation, gsBac_Version
        'txt_rut_cli.SetFocus
        Exit Function
    End If
    busca_rut = Datos(1)
End Function


Function buscar_codigo_contraparte(rut, Codigo)
    Dim Datos()
    envia = Array()
    AddParam envia, rut
    AddParam envia, Codigo
    If Bac_Sql_Execute("SVC_INT_BUS_COR", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            txt_cod_contra.Text = Datos(1)
        Loop
    End If
    
End Function

Function buscar_datos(rut, OpC)
    Dim Datos()
    envia = Array()
    AddParam envia, CDbl(rut)
    If Bac_Sql_Execute("SVC_OPE_DAT_EMI", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            If Datos(1) <> 0 Then
                If OpC = 1 Then
                    'L1.Caption = datos(1)
                ElseIf OpC = 2 Then
                    'L2.Caption = datos(1)
                ElseIf OpC = 3 Then
                    'l3.Caption = datos(1)
                End If
            End If
        Loop
    End If
    If Datos(1) = 0 Then
        MsgBox "Rut Inexsistente", vbExclamation, gsBac_Version
    End If
End Function

Function buscar_oficina(Oficina)
    Dim Datos()
    envia = Array()
    AddParam envia, Oficina
    If Bac_Sql_Execute("SVC_INT_OFI_OPE", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            buscar_oficina = Datos(1)
        Loop
    End If
    
End Function
Function activa_combos_mesa_cartera(rut) As Boolean
'------------------------------------------------------------------------------------
'JBH, 25-11-2009  ----IMPORTANTE----
'Si opcion_filtrado = "N" es porque el usuario seleccionó Operaciones Normales
'por lotanto el rut seleccionado no puede ser CorpBanca (97023000) gsBac_RutC
'De ser así se debe mostrar un mensaje de error y no dejar seguir porque de lo
'contrario tendríamos un proceso intramesa sobre una selección de operación normal
'------------------------------------------------------------------------------------
'Agregado por JBH, 16-10-2009
If rut = 0 Or Trim(rut) = "" Then
    'JBH, 25-11-2009
    'MsgBox "No ha seleccionado El rut de la Contraparte", vbExclamation
    activa_combos_mesa_cartera = True
    'fin JBH, 25-11-2009
    Exit Function
End If
If Tipo_op = "C" Or Tipo_op = "V" Then
    If Trim(rut) = gsBac_RutC Then   '"97023000"
        'JBH, 25-11-2009
        If opcion_filtrado <> "I" And Tipo_op = "V" Then    'Para las compras debe dejarlo pasar porque se trata de una compra intramesa JBH, 25-11-2009
            MsgBox "El usuario seleccionó Operaciones Normales por lo que la Contraparte no puede ser Corpbanca", vbCritical
            activa_combos_mesa_cartera = False
            Exit Function
        End If
        'Para el caso de Tipo_op = "V"... JBH, 23-10-2009
        box_forma_pago.Visible = False
        Label24.Visible = False
        If Tipo_op = "V" Then
            Cmb_Area_Responsable.Enabled = True
        End If
        
        lblMesaOrigen.Visible = True
        lblMesaDestino.Visible = True
        lblCarteraDestino.Visible = True
        lblNombreMesaOrigen.Visible = True
        Me.cmbMesaOrigen.Visible = True
        lblNombreMesaOrigen.Tag = ""
        cmbMesaDestino.Visible = True
        cmbCarteraDestino.Visible = True
        'Cargar las mesas para la mesa de origen (según usuario) y mesa de destino
        'Bloquear frames y cambiar posición de frame Frame1
        frm_banco.Visible = False
        Frm_destino.Visible = False
        
        Label19.Visible = False
        cmbCustodia.Visible = False
    
        Frame1.Left = 15
        Frame1.Top = 1380
        'Me.Height = Me.Height - frm_banco.Height - Frm_destino.Height
        Me.Height = 5000
        'Call carga_mesa_origen(gsUsuario)
        Call PROC_LLENA_COMBOS(cmbMesaOrigen, 10, False, gsBac_User, "", GLB_CATEG)
'        If Not carga_mesa_origen(gsUsuario) Then    'JBH, 18-11-2009
'            MsgBox "No fué posible cargar la mesa asociada al usuario", vbCritical, gsBac_Version
'            activa_combos_mesa_cartera = False  'JBH, 25-11-2009
'            Exit Function
'        End If
        Call carga_mesa_destino
        Call carga_cartera_destino
    Else
        'rut no es Corpbanca, tiene que venir de Operaciones Normales
        If opcion_filtrado = "I" Then   'JBH, 25-11-2009 Si viene de Intramesas error porque rut no es corpbanca
            MsgBox "No puede seleccionar otra contraparte que no sea Corpbanca, pues viene de Operaciones Intramesas", vbCritical
            activa_combos_mesa_cartera = False  'JBH, 25-11-2009
            Exit Function
        End If
    
        frm_banco.Visible = True
        Frm_destino.Visible = True

        Label19.Visible = True
        cmbCustodia.Visible = True
    
        Frame1.Left = 30
        Frame1.Top = 4650
        'Me.Height = 8295   JBH, 22-12-2009
        
        If ControlAtribuciones() = True Then
            Me.Height = 9090
        Else
            Me.Height = 8295
        End If
        
        lblMesaOrigen.Visible = False
        lblMesaDestino.Visible = False
        lblCarteraDestino.Visible = False
        lblNombreMesaOrigen.Visible = False
        Me.cmbMesaOrigen.Visible = False
        lblNombreMesaOrigen.Tag = ""
        cmbMesaDestino.Visible = False
        cmbCarteraDestino.Visible = False
    End If
Else
    frm_banco.Visible = True
    Frm_destino.Visible = True
    
    Label19.Visible = True
    cmbCustodia.Visible = True
    
    Frame1.Left = 30
    Frame1.Top = 4650

    If ControlAtribuciones() = True Then
        Me.Height = 9090
    Else
        Me.Height = 8295
    End If
    
    lblMesaOrigen.Visible = False
    lblMesaDestino.Visible = False
    lblCarteraDestino.Visible = False
    lblNombreMesaOrigen.Visible = False
    Me.cmbMesaOrigen.Visible = False
    lblNombreMesaOrigen.Tag = ""
    cmbMesaDestino.Visible = False
    cmbCarteraDestino.Visible = False
End If
activa_combos_mesa_cartera = True
End Function
Function carga_mesa_origen(codUsuario) As Boolean
'JBH, 16-10-2009
'Llena lblNombreMesaOrigen con el nombre de la mesa de origen predefinida
'para el usuario y en lblNombreMesaOrigen.Tag deja el código de la mesa
On err GoTo falla
If Trim(codUsuario) = "" Then
    Exit Function
End If
Dim Datos()
envia = Array()
AddParam envia, codUsuario
lblNombreMesaOrigen.Caption = ""    'Nombre de la Mesa
lblNombreMesaOrigen.Tag = ""        'Código de la Mesa
If Bac_Sql_Execute("bacparamsuda.dbo.sp_datos_mesa_usuario", envia) Then
    Do While Bac_SQL_Fetch(Datos)
        lblNombreMesaOrigen.Caption = Datos(2)
        lblNombreMesaOrigen.Tag = Datos(1)
    Loop
End If
'JBH, 18-11-2009 Validar si salio Ok del sp
If Trim(lblNombreMesaOrigen.Caption) <> "" Then
    carga_mesa_origen = True
Else
    carga_mesa_origen = False
End If
Exit Function
falla:
carga_mesa_origen = False
End Function
Function carga_mesa_destino()
'JBH, 16-10-2009
'Llena cmbMesaDestino
Dim Datos()
envia = Array()
cmbMesaDestino.Clear
If Bac_Sql_Execute("bacparamsuda.dbo.sp_cargamesas") Then
    Do While Bac_SQL_Fetch(Datos)
        'JBH, 25-11-2009
        'cmbMesaDestino.AddItem (datos(2))
        'cmbMesaDestino.ItemData(cmbMesaDestino.NewIndex) = Val(datos(1))
        'fin JBH, 25-11-2009
        cmbMesaDestino.AddItem Datos(2) & Space(110) & Datos(1) 'JBH, 25-11-2009
    Loop
End If
cmbMesaDestino.ListIndex = -1
End Function
Function carga_cartera_destino()

cmbCarteraDestino.Clear
Call PROC_LLENA_COMBOS(cmbCarteraDestino, 2, False, cTipo_Oper, GLB_CARTERA, GLB_ID_SISTEMA, Me.cCodCarteraFin)
cmbCarteraDestino.ListIndex = -1
End Function
Function carga_combo_operadores(rut)
    If rut = 0 Or rut = "" Then
        Exit Function
    End If
    
    Dim Datos()
    envia = Array()
    AddParam envia, rut
    box_oper_con.Clear
    
    If Bac_Sql_Execute("SVC_INT_BUS_OPE", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            box_oper_con.AddItem Datos(2)
        Loop
    End If
    box_oper_con.ListIndex = -1
End Function



Function Sva_Int_grb_ffc(rut, Codigo, ide)

    Dim Datos()
    envia = Array()
    AddParam envia, rut
    AddParam envia, Codigo
    AddParam envia, ide
    
    If Bac_Sql_Execute("SVA_INT_GRB_FFC", envia) Then
        Do While Bac_SQL_Fetch(Datos)
        Loop
        Sva_Int_grb_ffc = True
    End If
    
End Function

'Function graba_datos()
'
'
'
'    Call llena_variables_grabar
'    Dim datos()
'    envia = Array()
'    AddParam envia, Fec_pro
'    AddParam envia, Rut_cartera
'    AddParam envia, Num_Docu
'    AddParam envia, num_ope
'    AddParam envia, Tipo_Ope
'    AddParam envia, cod_nemo
'    AddParam envia, cod_familia
'    AddParam envia, rut_cli
'    AddParam envia, cod_cli
'    AddParam envia, fec_emi
'    AddParam envia, Fec_vcto
'    AddParam envia, mone_emi
'    AddParam envia, tasa_emi
'    AddParam envia, base_emi
'    AddParam envia, (rut_emi)
'    AddParam envia, fec_pag
'    AddParam envia, Nominal
'    AddParam envia, (val_pre)
'    AddParam envia, (val_pro_venc)
'    AddParam envia, (valor_pag_pes)
'    AddParam envia, (valor_pag_UM)
'    AddParam envia, (tir)
'    AddParam envia, (por_valor_compra)
'    AddParam envia, (valor_par)
'    AddParam envia, (interes_compra)
'    AddParam envia, (principal)
'    AddParam envia, (valor_compra_pes)
'    AddParam envia, (valor_compra_UM)
'    AddParam envia, (numero_ult_cupon)
'    AddParam envia, (numero_pro_cupon)
'    AddParam envia, (usuario_ope)
'    AddParam envia, (terminal)
'    AddParam envia, obseravcion
'    AddParam envia, codigo_cartera_super
'    AddParam envia, Sucursal
'    AddParam envia, nom_corres
'    AddParam envia, Cta_corres
'    AddParam envia, pais_corres
'    AddParam envia, ABA_corres
'    AddParam envia, ciu_corres
'    AddParam envia, banco_fon
'    AddParam envia, cta_fon
'    AddParam envia, pais_fon
'    AddParam envia, ciu_fon
'    AddParam envia, Oper_Con
'    If Bac_Sql_Execute("sp_invex_compra_o_venta", envia) Then
'        Do While Bac_SQL_Fetch(datos)
'        Loop
'        MsgBox "Datos Grabados Con Exito", vbInformation, Me.Caption
'    End If
'
'
'End Function
'
Sub Llena_Categoria_Super()

    Dim Datos()

    If Not Bac_Sql_Execute("SVC_GEN_CAR_SUP") Then
      Exit Sub
    End If
    
    cboCarteraSuper.Clear
    
    Do While Bac_SQL_Fetch(Datos())
        cboCarteraSuper.AddItem Datos(1)
    Loop
    
End Sub
Function llena_variables_grabar_bonext()
'JBH, 19-10-2009.  Preparación de datos para grabar

    rut_cli = txtRutCli.Text
    Cod_cli = CDbl(TxtCodCli.Text)
    obseravcion = Txt_Observ.Text
    Confirmacion = 0 'Se invisibilizo combo, por lo  que asume que siempre sera swift
    cusip = txt_cusip.Text
    
    'JBH, 23-10-2009
'    If Tipo_op = "V" Then
'        gsFormaPago = box_forma_pago.ItemData(box_forma_pago.ListIndex)
'    Else
'        gsFormaPago = 0
'    End If
    'fin JBH, 23-10-2009

    If Tipo_op = "C" Or Tipo_op = "V" Then
        cod_mesa_origen = Trim(Right(cmbMesaOrigen.Text, 10)) 'Val(lblNombreMesaOrigen.Tag)
        'JBH, 25-11-2009 'cod_mesa_destino = cmbMesaDestino.ItemData(cmbMesaDestino.ListIndex)
        cod_mesa_destino = Trim(Right(cmbMesaDestino.Text, 10)) 'JBH, 25-11-2009
        'cod_cartera_destino = cmbCarteraDestino.ItemData(cmbCarteraDestino.ListIndex)
        cod_cartera_destino = Trim(Right(cmbCarteraDestino.Text, 10))
        codigo_cartera_super = Trim(Right(cboCarteraSuper.Text, 10))
        Tipo_Inversion = Trim(Right(CmbTipoInv.Text, 10))
        Area_Responsable = Trim(Right(Cmb_Area_Responsable.Text, 10))
        libro = Trim(Right(Cmb_Libro.Text, 10))
    End If
End Function
Function llena_variables_grabar()

    rut_cli = txtRutCli.Text
    Cod_cli = CDbl(TxtCodCli.Text)
    obseravcion = Txt_Observ.Text
    Sucursal = txt_cod_ofi.Text
    Oper_Con = box_oper_con.Text
    Oper_bech = txt_oper_con.Text
    corr_cli_bco = txt_CorCli_destino.Text
    corr_cli_Cta = txt_CorCli_Cta.Text
    corr_cli_pais = txt_CorCli_Pais.Text
    corr_cli_ABA = txt_CorCli_ABA.Text
    corr_cli_swi = txt_CorCli_Swi.Text
    corr_cli_ref = txt_CorCli_Ref.Text
    
    corr_bco_bco = txt_CorBco_Des.Text
    corr_bco_Cta = txt_CorBco_Cta.Text
    corr_bco_pais = txt_CorBco_Pais.Text
    corr_bco_ABA = txt_CorBco_ABA.Text
    corr_bco_swi = txt_CorBco_Swi.Text
    corr_bco_ref = txt_CorBco_Ref.Text
    Confirmacion = 0 'Se invisibilizo combo, por lo  que asume que siempre sera swift
    cusip = txt_cusip.Text
    
    If Tipo_op = "V" Then
        gsFormaPago = box_forma_pago.ItemData(box_forma_pago.ListIndex)
    Else
        gsFormaPago = 0
    End If
    
    If Tipo_op = "C" Then
        calce = Check1.Value
'''''        codigo_cartera_super = Mid$(cboCarteraSuper.Text, 1, 1)
'''''        Tipo_Inversion = CmbTipoInv.ItemData(CmbTipoInv.ListIndex)
        codigo_cartera_super = Trim(Right(cboCarteraSuper.Text, 10))
        Tipo_Inversion = Trim(Right(CmbTipoInv.Text, 10))

        Area_Responsable = Trim(Right(Cmb_Area_Responsable.Text, 10))
        libro = Trim(Right(Cmb_Libro.Text, 10))
        para_quien = CmbParaQuien.ItemData(CmbParaQuien.ListIndex)
        If cmbCustodia.ListIndex > -1 Then
            custodia = cmbCustodia.ItemData(cmbCustodia.ListIndex)
        Else
            custodia = 0
        End If
        '+++CONTROL IDD, jcamposd marca de control linea IDD
        MarcaAplicaLinea = ChkControlLinea.Value
        '---CONTROL IDD, jcamposd marca de control linea IDD
        
    ElseIf Tipo_op = "V" Then
        para_quien = CmbParaQuien.ItemData(CmbParaQuien.ListIndex)
    End If
    
End Function

Function valida_datos()
'---------------------------------------------------
'Primero, validar los campos del frame frm_cliente
'---------------------------------------------------
    valida_datos = True
    If Trim(txtRutCli.Text) = "" Then
        MsgBox "Falta Ingresar Rut Contraparte", vbExclamation, gsBac_Version
        valida_datos = False
        txtRutCli.SetFocus
        Exit Function
    End If
    If Trim(TxtCodCli.Text) = "" Then
        MsgBox "Falta Ingresar Código Contraparte", vbExclamation, gsBac_Version
        valida_datos = False
        TxtCodCli.SetFocus
        Exit Function
    End If

'Validar ssi el rut no es CorpBanca y no es Compra, JBH, 19-10-2009
'solo en ese caso validar los campos de los frame Frm_destino y frm_banco
'porque en otro caso, esos frames estarán deshabilitados y no se usarán los campos
'---------------------------------------------------
'Segundo, validar los campos del frame Frm_destino
'---------------------------------------------------
    If Not ((Tipo_op = "C" Or Tipo_op = "V") And txtRutCli.Text = gsBac_RutC) Then  '"97023000" JBH, 04-12-2009
        If ObjCliente.clvigente = "N" Then
            MsgBox "Cliente no se encuentra Vigente", vbCritical, gsBac_Version
            lbl_nom_cli.Caption = ""
            valida_datos = False
            txtRutCli.SetFocus
            Exit Function
        End If

'        If Trim(Right(cmbMesaOrigen.Text, 10)) = "" Then 'Trim(lblNombreMesaOrigen.Caption) = "" Then
'            MsgBox "Falta el nombre de la mesa asociada al usuario", vbCritical, gsBac_Version
'        valida_datos = False
'            Exit Function
'        End If

        If Me.txt_CorCli_destino.Text = "" Then
            MsgBox "Falta Ingresar Corresponsal", vbExclamation, gsBac_Version
        valida_datos = False
            txt_CorCli_destino.SetFocus
            Exit Function
        End If
        If Me.txt_CorCli_Cta.Text = "" Then
        MsgBox "Falta Ingresar Cuenta", vbExclamation, gsBac_Version
        valida_datos = False
            txt_CorCli_Cta.SetFocus
            Exit Function
        End If
        If Me.txt_CorCli_ABA.Text = "" Then
            MsgBox "Falta Ingresar Código Abba", vbExclamation, gsBac_Version
        valida_datos = False
            txt_CorCli_ABA.SetFocus
            Exit Function
        End If
        If Me.txt_CorCli_Swi.Text = "" Then
        MsgBox "Falta Ingresar Código Swif", vbExclamation, gsBac_Version
        valida_datos = False
            txt_CorCli_Swi.SetFocus
            Exit Function
        End If
    End If
'------------------------------------------------
'Tercero, validar los campos del frame frm_banco
'------------------------------------------------
    If Not ((Tipo_op = "C" Or Tipo_op = "V") And txtRutCli.Text = gsBac_RutC) Then  'JBH, 04-12-2009 "97023000"
        If Me.txt_CorBco_Des.Text = "" Then
        MsgBox "Falta Ingresar Corresponsal", vbExclamation, gsBac_Version
        valida_datos = False
        txt_CorBco_Des.SetFocus
            Exit Function
        End If
        If Me.txt_CorBco_Cta.Text = "" Then
        MsgBox "Falta Ingresar Cuenta", vbExclamation, gsBac_Version
            valida_datos = False
            txt_CorBco_Cta.SetFocus
            Exit Function
        End If
        If Me.txt_CorBco_ABA.Text = "" Then
            MsgBox "Falta Ingresar Código Abba", vbExclamation, gsBac_Version
        valida_datos = False
            txt_CorBco_ABA.SetFocus
            Exit Function
        End If
        If Me.txt_CorBco_Swi.Text = "" Then
            MsgBox "Falta Ingresar Código Swif", vbExclamation, gsBac_Version
        valida_datos = False
            txt_CorBco_Swi.SetFocus
            Exit Function
        End If
    End If
'--------------------------------------
    If txt_oper_con.Text = " " Then
        MsgBox "Falta Ingresar el Operador ", vbExclamation, gsBac_Version
        valida_datos = False
        txt_oper_con.SetFocus
    
    ElseIf txt_cod_contra.Text = "" Then
        MsgBox "Falta Ingresar Identificación de Contraparte", vbExclamation, gsBac_Version
        valida_datos = False
        txt_cod_contra.SetFocus
    
    ElseIf cboCarteraSuper.ListIndex = -1 And (Tipo_op = "C" Or Tipo_op = "V") Then
        MsgBox "Falta Selecionar Cartera Super", vbExclamation, gsBac_Version
        valida_datos = False
        cboCarteraSuper.SetFocus
   
    ElseIf CmbTipoInv.ListIndex = -1 And (Tipo_op = "C" Or Tipo_op = "V") Then
        MsgBox "Falta Selecionar Tipo Inversion", vbExclamation, gsBac_Version
        valida_datos = False
        CmbTipoInv.SetFocus
    
    ElseIf Cmb_Area_Responsable.ListIndex = -1 And (Tipo_op = "C" Or Tipo_op = "V") Then
        'Verificar si el combo está Enabled
        If Cmb_Area_Responsable.Enabled = True Then 'JBH, 28-10-2009
        Screen.MousePointer = vbDefault
        MsgBox "Debe Seleccionar una Area Responsable", vbExclamation
        valida_datos = False
        Cmb_Area_Responsable.SetFocus
        Exit Function
        End If
        
    ElseIf Cmb_Libro.ListIndex = -1 And (Tipo_op = "C" Or Tipo_op = "V") Then
        Screen.MousePointer = vbDefault
        MsgBox "Debe Seleccionar un Libro", vbExclamation
        valida_datos = False
        Cmb_Libro.SetFocus
    
    ElseIf CmbParaQuien.ListIndex = -1 And (Tipo_op = "C" Or Tipo_op = "V") Then
        MsgBox "Falta Seleccionar por Cuenta de Quién", vbExclamation, gsBac_Version
        valida_datos = False
        CmbParaQuien.SetFocus
   
    ElseIf box_forma_pago.Visible = True And box_forma_pago.ListIndex = -1 Then
        MsgBox "Falta Ingresar Forma de Pago", vbExclamation, gsBac_Version
        valida_datos = False
         box_forma_pago.SetFocus
    End If
    '******************************************
    ' Inicio Cambio Art84
    ' MOD  : PRD21669 Art 84 Inv Exterior     '
    ' 2000 = BONOEX                           '
    '******************************************
    
    'inicializo nro ticket
    glngNroTicket = 0
    Dim strMsgError As String
    strMsgError = ""
    gstrMensajesError = ""
    gstrMontosEnviados = ""
    
        
    ' reviso si el Flag de encendido del proceso
    If blnProcesoArt84Activo("BEX") Then
        If frmActivo("Bac_Compras") = True Then
            If gstrFormOrigen = "Bac_Compras" Then
                ' solo analizo procesos BONOEX
                If frmTemporal.box_familia.ItemData(frmTemporal.box_familia.ListIndex) = 2000 Then ' 2000 = BONOEX
                    ' solo imputan Bonos normales
                    If frmTemporal.optOpeNormal.Value = True Then
                        ' realizo el control de márgenes
                        If Not blnValidaNormaArt84() Then
                           strMsgError = gstrMensajesError '& vbNewLine & "Detalle de Valores Imputados : " & vbNewLine & gstrMontosEnviados  ' mensaje obtenido en el proceso WS
                           'MsgBox "La Operación no se puede realizar" & vbCrLf & vbCrLf & "El registro no cumple con la Norma Art84, detalle del problema: " & strMsgError, vbInformation, gsBac_Version
                           
                             MsgBox "La Operación no se puede realizar" & vbCrLf & vbCrLf & "El registro no cumple con la Norma Art84, detalle del problema: " & _
                                vbNewLine & "N° de Ticket de la operación : " & glngNroTicket & vbNewLine & vbNewLine & _
                                strMsgGeneral, vbCritical, gsBac_Version
                           
                           
                           
                           
                           Screen.MousePointer = vbDefault
                           valida_datos = False
                         ' asocio nro ticket a una operación no válida
                           If glngNroTicket > 0 Then
                              Call GeneraConfirmacionProceso(glngNroTicket, 0, "BEX", gstrNrosOperacionesIBS)
                           End If
                           Exit Function
                        End If
                    End If
                End If
            End If
        End If
    End If
    
    
'    'temporal
'    If Len(gstrMontosEnviados) > 0 Then
'        MsgBox "Detalle de montos Imputados : " & vbNewLine & gstrMontosEnviados
'    End If
    
    'JBH, 16-10-2009
    'Ssi Tipo_op = "C" And txtRutCli.Text = "97023000"
    If (Tipo_op = "C" Or Tipo_op = "V") And Trim(txtRutCli.Text) = gsBac_RutC Then  '"97023000"
        If cmbMesaDestino.ListIndex = -1 Then
            MsgBox "Falta seleccionar la Contraparte", vbExclamation, gsBac_Version
            valida_datos = False
            cmbMesaDestino.SetFocus
            Exit Function
        End If
        If cmbCarteraDestino.ListIndex = -1 Then
            MsgBox "Falta seleccionar la Cartera de Destino", vbExclamation, gsBac_Version
            valida_datos = False
            cmbCarteraDestino.SetFocus
            Exit Function
        End If
        
        If cmbMesaOrigen.ListIndex = -1 Then
            MsgBox "Falta seleccionar Portfolio", vbExclamation, gsBac_Version
            valida_datos = False
            cmbMesaDestino.SetFocus
            Exit Function
        End If

        cod_mesa_destino = Trim(Right(cmbMesaDestino.Text, 10)) 'JBH, 25-11-2009
        'If CmbTipoInv.ListIndex = cmbCarteraDestino.ListIndex Then 'JBH, 25-11-2009
        
        Tipo_Inversion = Trim(Right(CmbTipoInv.Text, 10))   'JBH, 25-11-2009
        cod_cartera_destino = Trim(Right(cmbCarteraDestino.Text, 10))   'JBH, 25-11-2009
                
        If Val(Tipo_Inversion) = Val(cod_cartera_destino) Then   'JBH, 25-11-2009
            'Cartera Origen = Cartera Destino
            'Validar que las mesas sean distintas
            'If Val(lblNombreMesaOrigen.Tag) = cmbMesaDestino.ListIndex Then    'JBH, 25-11-2009
            If Trim(Right(cmbMesaOrigen.Text, 10)) = Val(cod_mesa_destino) Then    'JBH, 25-11-2009
                'Las mesas no pueden ser iguales
                MsgBox "Portafolio no puede ser igual a la Contraparte", vbExclamation, gsBac_Version
                valida_datos = False
                cmbMesaDestino.SetFocus
                Exit Function
            End If
        End If
        'If Val(lblNombreMesaOrigen.Tag) = cmbMesaDestino.ListIndex Then    'JBH, 25-11-2009
        If Trim(Right(cmbMesaOrigen.Text, 10)) = Val(cod_mesa_destino) Then    'JBh, 25-11-2009
        'Validar que las carteras de origen y destino sean distintas
            'If CmbTipoInv.ListIndex = cmbCarteraDestino.ListIndex Then 'JBH, 25-11-2009, No usar los ListIndex pra comparar sino los códigos reales
            If Val(Tipo_Inversion) = Val(cod_cartera_destino) Then  'JBH, 25-11-2009
               'Las carteras no pueden ser iguales
                MsgBox "La Cartera de Origen no puede ser igual a la Cartera de Destino", vbExclamation, gsBac_Version
                valida_datos = False
                cmbCarteraDestino.SetFocus
            End If
        End If
        If Trim(Right(Me.CmbTipoInv.Text, 10)) = Trim(Right(cmbCarteraDestino.Text, 10)) Then
            MsgBox "La Cartera de Origen no puede ser igual a la Cartera de Destino", vbExclamation, gsBac_Version
            valida_datos = False
            cmbCarteraDestino.SetFocus
        End If
        If Trim(Right(Me.cmbMesaOrigen.Text, 10)) = Trim(Right(cmbMesaDestino.Text, 10)) Then
            MsgBox "La Mesa de Origen no puede ser igual a la Mesa de Destino", vbExclamation, gsBac_Version
            valida_datos = False
            cmbCarteraDestino.SetFocus
        End If
  End If
End Function
Function frmActivo(strName As String) As Boolean
Dim formulario As Form
For Each formulario In Forms
    If (UCase(formulario.Name) = UCase(strName)) Then
        frmActivo = True
        Exit For
    End If
Next
End Function
Function strTraeGenericoByRut(strRut As String) As String
strTraeGenericoByRut = ""
If ObjEmisor.LeerPorRut(CLng(strRut), "O") Then
    strTraeGenericoByRut = ObjEmisor.emgeneric
End If

End Function
Function strTraeClienteGenericoByRut(strRutCte As String) As String
strTraeClienteGenericoByRut = ""
If ObjCliente.LeerPorRut1(CLng(Trim(strRutCte)), CLng(Trim(TxtCodCli))) Then
    strTraeClienteGenericoByRut = ObjCliente.clgeneric
End If
End Function
Function blnValidaNormaArt84() As Boolean
Dim blnResult As Boolean
    blnResult = blnRevisaNormaInvExt()
    blnValidaNormaArt84 = blnResult
    
End Function
Function blnRevisaNormaInvExt() As Boolean
Dim strGenerico As String
Dim blnOutput As Boolean
blnOutput = False
Call GeneraArchivoInterfazGrillaInvExt(Me, lbl_nom_cli.Caption)

' capturo variable global que indica si los margenes fueron aceptados
blnOutput = gblnProcesoExitoso


blnRevisaNormaInvExt = blnOutput
End Function
Private Sub box_confirma_Click()
    Confirmacion = 0 'box_confirma.ItemData(box_confirma.ListIndex)
    If box_confirma.Text = "FAX" Then
        Bac_Fax.Show 1
        giSW = True
    End If
End Sub
Private Sub box_confirma_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub
Private Sub box_oper_con_Click()
    SendKeys "{TAB}"
End Sub
Private Sub box_oper_con_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
Function busca_Corresponsal_Banco()
   Dim sw As Integer
   Dim Datos()
        envia = Array()
        sw = 0
        AddParam envia, gsBac_RutC
        AddParam envia, 1
        AddParam envia, Moneda
        AddParam envia, "WACHOVIA BANK. N.A."
        If Bac_Sql_Execute("Svc_Ayd_dat_cor", envia) Then
            Do While Bac_SQL_Fetch(Datos())
                txt_CorBco_Des.Text = Datos(1)
                txt_CorBco_Cta.Text = Datos(3)
                txt_CorBco_ABA.Text = Datos(7)
                txt_CorBco_Swi.Text = Datos(5)
                txt_CorBco_Pais.Text = Datos(8)
                sw = 1
            Loop
            
            If sw = 0 Then
                MsgBox "Banco no tiene corresponsales asociados a la moneda", vbExclamation, gsBac_Version
                txt_CorBco_Cta.Text = ""
                txt_CorBco_Pais.Text = ""
                txt_CorBco_ABA.Text = ""
                txt_CorBco_Swi.Text = ""
                txt_CorBco_Ref.Text = ""
            End If
        End If
End Function
Function busca_Corresponsal_Cliente()
   Dim sw As Integer
   Dim Datos()
   
        envia = Array()
        AddParam envia, Val(txtRutCli.Text)
        AddParam envia, Val(TxtCodCli.Text)
        AddParam envia, Moneda
        AddParam envia, ""
            
        sw = 0
        If Bac_Sql_Execute("SVC_AYD_DAT_COR", envia) Then
            Do While Bac_SQL_Fetch(Datos())
                If sw = 1 Then
                    Exit Do
                End If
                txt_CorCli_destino.Text = Datos(1)
                txt_CorCli_Cta.Text = Datos(3)
                txt_CorCli_ABA.Text = Datos(7)
                txt_CorCli_Swi.Text = Datos(5)
                txt_CorCli_Pais.Text = Datos(9)
                
                sw = 1
            Loop
            
            If sw = 0 Then
            
                MsgBox "Cliente no tiene corresponsales asociados", vbExclamation, gsBac_Version
                txt_CorCli_Cta.Text = ""
                txt_CorCli_Pais.Text = ""
                txt_CorCli_ABA.Text = ""
                txt_CorCli_Swi.Text = ""
                txt_CorCli_Ref.Text = ""
                txt_CorCli_destino.SetFocus
            
            End If
            
        End If

End Function
Private Sub Cmb_Libro_Click()

    'Call PROC_LLENA_COMBOS(cboCarteraSuper, 6, False, GLB_ID_SISTEMA, cTipo_Oper, Trim(Right(Cmb_Libro.Text, 10)), GLB_CARTERA_NORMATIVA, Me.cCodCarteraSuper)
    Call PROC_LLENA_COMBOS(cboCarteraSuper, 9, False, GLB_ID_SISTEMA, cTipo_Oper, Trim(Right(Cmb_Libro.Text, 10)), GLB_CARTERA_NORMATIVA, Me.cCodCarteraSuper, gsBac_User)

    If Me.cboCarteraSuper.ListCount = 0 And Me.Visible = True Then
        MsgBox "El Libro " & Trim(Left(Cmb_Libro.Text, 50)) & " No Tiene Asociada Ninguna Cartera Super", vbExclamation, Me.Caption
    End If


End Sub




Private Sub cmbOperador_Change()
    gsBac_User = Trim(Mid$(cmbOperador.Text, 111))
    gsUsuario = gsBac_User
End Sub

Private Sub Form_Activate()
    Dim i As Integer
      
    If Cmb_Libro.ListCount = 0 Then
        MsgBox "No Existen Libros Asociados A Este Producto", vbExclamation, Me.Caption
        Unload Me
        Exit Sub
    End If
   
    If Me.cboCarteraSuper.ListCount = 0 Then
        MsgBox "El Libro " & Trim(Left(Cmb_Libro.Text, 50)) & " No Tiene Asociada Ninguna Cartera Super", vbExclamation, Me.Caption
    End If

End Sub

Private Sub Form_Load()

    Dim objSucursales As clsSucursales
    
    giAceptar = False
    
    LblEstadoCliente.Caption = ""
    txt_oper_con.Text = Bac_Usr_nom
    txt_cod_ofi.Text = Bac_Usr_ofi
    txt_oficina.Text = buscar_oficina(Bac_Usr_ofi)
    
    If Tipo_op = "C" Then
        Me.Caption = Me.Caption & " (Compra)"
    ElseIf Tipo_op = "V" Then
        Me.Caption = Me.Caption & " (Venta)"
    End If
    
    Me.frm_banco.Caption = "Corresponsal " & gsBac_CartNOM
   ' Label20.Caption = "Operador " & gsBac_CartNOM
         
    Moneda = Val(gsmoneda)
    
'''''    Call Llena_Categoria_Super
'''''    Call ObjTipoInv.LeerCodigos(204)
'''''    Call ObjTipoInv.Coleccion2Control(CmbTipoInv)
    Call llena_combo_confirmacion
    Call ObjParaQuien.LeerCodigos(1105)
    Call ObjParaQuien.Coleccion2Control(CmbParaQuien)
    
    Call ObjParaQuien.LeerCodigos(1110)
    Call ObjParaQuien.Coleccion2Control(cmbCustodia)
    cmbCustodia.AddItem "  ": cmbCustodia.ItemData(cmbCustodia.NewIndex) = 0
  
    Call busca_Corresponsal_Banco
 
    Call PROC_LLENA_COMBOS(Cmb_Area_Responsable, 1, False, GLB_AREA_RESPONSABLE, GLB_ID_SISTEMA)
    'Call PROC_LLENA_COMBOS(CmbTipoInv, 2, False, cTipo_Oper, GLB_CARTERA, GLB_ID_SISTEMA, Me.cCodCarteraFin)
    'Call PROC_LLENA_COMBOS(Cmb_Libro, 5, False, GLB_ID_SISTEMA, cTipo_Oper, GLB_LIBRO, Me.cCodLibro)
    
    Call PROC_LLENA_COMBOS(Cmb_Libro, 8, False, GLB_ID_SISTEMA, cTipo_Oper, GLB_LIBRO, Me.cCodLibro, gsBac_User)
    Call PROC_LLENA_COMBOS(CmbTipoInv, 7, False, cTipo_Oper, GLB_CARTERA, GLB_ID_SISTEMA, Me.cCodCarteraFin, gsBac_User)
  
    If Tipo_op = "V" Then
               
        box_forma_pago.Visible = True
        Call llena_combo_forma_pago(13, 13, box_forma_pago)
        cboCarteraSuper.Enabled = False
        'CmbParaQuien.Enabled = False
        CmbParaQuien.ListIndex = 0
        CmbTipoInv.Enabled = False
        Cmb_Cartera.Enabled = False
        Check1.Enabled = False
        cmbCustodia.Enabled = False
        txt_cusip.Text = cusip
        'CmbTipoInv.Clear
        'CmbTipoInv.ListIndex = -1
        'cboCarteraSuper.ListIndex = -1
        Cmb_Area_Responsable.ListIndex = -1
        Cmb_Area_Responsable.Enabled = False
        'Cmb_Libro.ListIndex = -1
        Cmb_Libro.Enabled = False
        Me.cmbMesaOrigen.Visible = False
        '+++CONTROL IDD, jcamposd aplica si afecta IDD
        ChkControlLinea.Visible = False
        '---CONTROL IDD, jcamposd aplica si afecta IDD
        
    End If
    
     If Tipo_op = "C" Then
        box_forma_pago.Visible = False
        Label24.Visible = False
        CmbTipoInv.ListIndex = IIf(CmbTipoInv.ListCount > 0, 0, -1)
        cboCarteraSuper.ListIndex = IIf(cboCarteraSuper.ListCount > 0, 0, -1)
        'JBH, 28-10-2009
        Cmb_Area_Responsable.ListIndex = -1
        Cmb_Area_Responsable.Enabled = True
        'fin JBH, 28-10-2009
        CmbParaQuien.ListIndex = 0
        txt_oper_con.Visible = False
        Me.cmbMesaOrigen.Visible = False
        
        '+++CONTROL IDD, jcamposd aplica si afecta IDD
        ChkControlLinea.Visible = True
        '---CONTROL IDD, jcamposd aplica si afecta IDD
    End If
        
    If ControlAtribuciones() = True Then
        Me.Height = 9090    '8970
        frmOperador.Enabled = True
        frmOperador.Visible = True
        cmbOperador.Enabled = True
        lblOperador.Visible = True
        Call LlenaComboOperadores(cmbOperador)
        '+++jcamposd COLTES 20180411 controla visibilidad de frmoperador
        Me.Height = 9500
        '---jcamposd COLTES 20180411 controla visibilidad de frmoperador
    Else
        cmbOperador.Enabled = False
        frmOperador.Visible = False
        frmOperador.Enabled = False
        lblOperador.Visible = False
        Me.Height = 8295
    End If
        
        
 'JBH, 04-12-2009
    If ope_intramesa = True Then
        txtRutCli.Text = gsBac_RutC
        TxtCodCli.Text = gsBac_DigC
        lbl_nom_cli.Caption = gsBac_Clien   'JBH, 11-12-2009
        Call carga_combo_operadores(txtRutCli.Text)
        If Not activa_combos_mesa_cartera(txtRutCli.Text) Then
            giAceptar = False
            Unload Me
            Exit Sub
        End If
        'Bloquear el frame de selección del cliente, JBH, 11-12-2009
        frm_cliente.Enabled = False
        SendKeys ("{TAB}{TAB}")
    Else    'JBH, 11-12-2009
        frm_cliente.Enabled = True
    End If
 'fin JBH, 04-12-2009
    
End Sub
Function llena_combo_confirmacion()
    Dim Datos()
    box_confirma.Clear
    If Bac_Sql_Execute("SVC_INT_BUS_CFM") Then
        Do While Bac_SQL_Fetch(Datos)
            box_confirma.AddItem Datos(2)
            box_confirma.ItemData(box_confirma.NewIndex) = Val(Datos(1))
        Loop
    End If
    
End Function

Private Sub Form_Unload(Cancel As Integer)
    Set ObjCliente = Nothing
End Sub

Private Sub frm_operador_DragDrop(Source As Control, X As Single, Y As Single)

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            If valida_datos Then
                auxUser = gsBac_User
                If txtRutCli.Text <> gsBac_RutC Then
                If cmbOperador.Enabled And cmbOperador.ListIndex = -1 Then
                    Screen.MousePointer = vbDefault
                    MsgBox "Debe seleccionar al Operador de la Transacción", vbExclamation
                    cmbOperador.SetFocus
                    Exit Sub
                End If
                End If
                
                If cmbOperador.Enabled Then
                    gsBac_User = Trim(Mid$(cmbOperador.Text, 111))
                    gsUsuario = gsBac_User
                End If

                Ctrlpt_RutCliente = txtRutCli.Text
                Ctrlpt_CodCliente = TxtCodCli.Text

                If (Tipo_op = "C" Or Tipo_op = "V") And txtRutCli.Text = gsBac_RutC Then    'JBH, 04-12-2009 "97023000"
                    llena_variables_grabar_bonext
                Else
                
                llena_variables_grabar
                End If
                
                If (Tipo_op = "C" Or Tipo_op = "V") And txtRutCli.Text = gsBac_RutC Then    'JBH, 04-12-2009
                        ''Ojo!, la llamada a la funcion debajo, Sva_Int_grb_ffc NO HACE NADA!, JBH, 19-1-2009
                        giAceptar = True
                Else
                If Sva_Int_grb_ffc(txtRutCli.Text, Me.TxtCodCli.Text, txt_cod_contra.Text) Then
                    giAceptar = True
                Else
                    Exit Sub
                End If
                End If
                
                'gsBac_User = auxUser
                Unload Me
            End If
            
        Case 2
            giAceptar = False
            Unload Me
    End Select
End Sub

Private Sub txt_rut_cli_DblClick()

    Ayuda
    If Not giAceptar% = False Then SendKeys "{TAB 2}"

End Sub

Private Sub Ayuda()

    BacAyuda.Tag = "MDCL"
    BacAyuda.Show 1
'   BacControlWindows 12
    
    If giAceptar% = True Then
        txtRutCli.Text = Val(gsrut$)
        txtDigCli.Text = gsDigito$
        lbl_nom_cli.Caption = gsDescripcion$
        TxtCodCli.Text = gsvalor$
    End If

End Sub

Private Sub txt_cod_cor_bech_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_cod_cor_con_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_CorBco_ABA_KeyPress(KeyAscii As Integer)

If KeyAscii = 39 Then
    KeyAscii = 0
End If
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txt_CorBco_Cta_KeyPress(KeyAscii As Integer)
If KeyAscii = 39 Then
    KeyAscii = 0
End If
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txt_CorBco_Des_DblClick()

    gsrut = gsBac_RutC
    gsvalor = 1
    gsmoneda = Str(Moneda)
    
    BacAyuda.Tag = "CORR"
    BacAyuda.Show 1
    
    If giAceptar% = True Then
        txt_CorBco_Des.Text = gsDescripcion$
        Call txt_CorBco_Des_LostFocus
        
    Else
       SendKeys "{TAB}"
    End If

End Sub

Private Sub txt_CorBco_Des_KeyPress(KeyAscii As Integer)
If KeyAscii = 39 Then
    KeyAscii = 0
End If
If KeyAscii <> 8 Then
    KeyAscii = 0
End If

End Sub

Private Sub txt_CorBco_Des_LostFocus()
    Dim Datos()
    Dim sw As Integer

    If Trim(txt_CorBco_Des.Text) <> "" Then
        sw = 0
        envia = Array()
        AddParam envia, gsBac_RutC
        AddParam envia, 1
        AddParam envia, Moneda
        AddParam envia, txt_CorBco_Des.Text
    
        If Bac_Sql_Execute("Svc_Ayd_dat_cor", envia) Then
            Do While Bac_SQL_Fetch(Datos())
                txt_CorBco_Cta.Text = Datos(3)
                'txt_CorBco_Pais.Text = datos(2)
                txt_CorBco_ABA.Text = Datos(7)
                txt_CorBco_Swi.Text = Datos(5)
                txt_CorBco_Pais.Text = Datos(8)
                sw = 1
            Loop
            
            If sw = 0 Then
                MsgBox "Corresponsal No Existe", vbExclamation, gsBac_Version
                txt_CorBco_Cta.Text = ""
                txt_CorBco_Pais.Text = ""
                txt_CorBco_ABA.Text = ""
                txt_CorBco_Swi.Text = ""
                txt_CorBco_Ref.Text = ""
            End If
        End If
    End If

End Sub

Private Sub txt_CorBco_Ref_Change()
    With Me.txt_CorBco_Ref
            .Text = UCase(.Text)
            .SelStart = Len(Me.txt_CorBco_Ref.Text) + 1
End With
End Sub

Private Sub txt_CorBco_Ref_KeyPress(KeyAscii As Integer)
If KeyAscii = 39 Then
    KeyAscii = 0
End If

End Sub

Private Sub txt_CorBco_Swi_KeyPress(KeyAscii As Integer)
If KeyAscii = 39 Then
    KeyAscii = 0
End If
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub txt_CorCli_ABA_KeyPress(KeyAscii As Integer)
If KeyAscii = 39 Then
    KeyAscii = 0
End If
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub txt_CorCli_Cta_KeyPress(KeyAscii As Integer)
If KeyAscii = 39 Then
    KeyAscii = 0
End If
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub txt_CorCli_destino_DblClick()

    gsrut = txtRutCli.Text
    gsvalor = TxtCodCli.Text
    gsmoneda = Str(Moneda)
    
    BacAyuda.Tag = "CORR"
    BacAyuda.Show 1
    
    If giAceptar% = True Then
        txt_CorCli_destino.Text = gsDescripcion$
        Call txt_CorCli_destino_LostFocus
        
    Else
       SendKeys "{TAB 2}"
    End If

End Sub

Private Sub txt_CorCli_destino_KeyPress(KeyAscii As Integer)
    If KeyAscii = 39 Then
        KeyAscii = 0
    End If
    If KeyAscii <> 8 Then
        KeyAscii = 0
    End If
End Sub

Private Sub txt_CorCli_destino_LostFocus()

    Dim Datos()
    Dim sw As Integer

    If Trim(txt_CorCli_destino.Text) <> "" Then
    
        sw = 0
        envia = Array()
        AddParam envia, Val(txtRutCli.Text)
        AddParam envia, Val(TxtCodCli.Text)
        AddParam envia, Moneda
        AddParam envia, txt_CorCli_destino.Text
    
        If Bac_Sql_Execute("SVC_AYD_DAT_COR", envia) Then
            Do While Bac_SQL_Fetch(Datos())
                txt_CorCli_Cta.Text = Datos(3)
                'txt_CorCli_Pais.Text = datos(2)
                txt_CorCli_ABA.Text = Datos(7)
                txt_CorCli_Swi.Text = Datos(5)
                txt_CorCli_Pais.Text = Datos(9)
                
                sw = 1
            Loop
            
            If sw = 0 Then
            
                MsgBox "Corresponsal No Existe", vbExclamation, gsBac_Version
                txt_CorCli_Cta.Text = ""
                txt_CorCli_Pais.Text = ""
                txt_CorCli_ABA.Text = ""
                txt_CorCli_Swi.Text = ""
                txt_CorCli_Ref.Text = ""
                txt_CorCli_destino.SetFocus
            
            End If
            
        End If

    End If

End Sub

Private Sub txt_CorCli_Ref_KeyPress(KeyAscii As Integer)
If KeyAscii = 39 Then
    KeyAscii = 0
End If
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txt_CorCli_Swi_KeyPress(KeyAscii As Integer)
If KeyAscii = 39 Then
    KeyAscii = 0
End If
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txt_cusip_KeyPress(KeyAscii As Integer)

If KeyAscii = 39 Then
    KeyAscii = 0
End If

End Sub

Private Sub Txt_Observ_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txt_oper_con_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub TxtCodCli_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then SendKeys "{TAB}"
    
    KeyAscii = BACValIngNumGrid(KeyAscii)
    
    If Chr(KeyAscii) = "-" Or Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
       KeyAscii = 0
    End If

End Sub

Private Sub TxtCodCli_LostFocus()

    If Len(Trim$(TxtCodCli.Text)) = 0 Then Exit Sub
    
    If Val(txtRutCli.Text) <> 0 Then
        LblEstadoCliente.Caption = ""
    
        Call ObjCliente.LeerPorRut(txtRutCli.Text, txtDigCli.Text, 0, TxtCodCli.Text)
        
        If ObjCliente.clvigente = "N" Then
            LblEstadoCliente.Caption = "Cliente no se encuentra Vigente"
            Toolbar1.Buttons(1).Enabled = False
            Exit Sub
        End If
        
        If ObjCliente.clrut = 0 Then
            txtRutCli.Text = ""
            txtDigCli.Text = ""
            TxtCodCli.Text = ""
            MsgBox "Cliente no existente, verifique datos.", vbExclamation, gsBac_Version
            Toolbar1.Buttons(2).Enabled = True
            txtRutCli.SetFocus
        Else
            txtDigCli.Text = ObjCliente.cldv
            lbl_nom_cli.Caption = ObjCliente.clnombre
            TxtCodCli.Text = ObjCliente.clcodigo
            Call buscar_codigo_contraparte(txtRutCli.Text, TxtCodCli.Text)
            Toolbar1.Buttons(1).Enabled = True
        End If
        
    End If
    
    Exit Sub

End Sub


Private Sub TxtCustodia_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txtRutCli_Change()
    LblEstadoCliente.Caption = ""
    lbl_nom_cli.Caption = ""
    txtDigCli.Text = ""
    txt_cod_contra.Text = " "
    Toolbar1.Buttons(1).Enabled = True
    TxtCodCli.Text = ""
    
    txt_CorCli_destino.Text = ""
    txt_CorCli_Cta.Text = ""
    txt_CorCli_Pais.Text = ""
    txt_CorCli_ABA.Text = ""
    txt_CorCli_Swi.Text = ""
    txt_CorCli_Ref.Text = ""
    'JBH, 16-10-2009
    lblMesaOrigen.Visible = False
    lblMesaDestino.Visible = False
    lblCarteraDestino.Visible = False
    lblNombreMesaOrigen.Visible = False
    Me.cmbMesaOrigen.Visible = False
    lblNombreMesaOrigen.Tag = ""
    cmbMesaDestino.Visible = False
    cmbCarteraDestino.Visible = False
    frm_banco.Visible = True
    Frm_destino.Visible = True
    
    Label19.Visible = True
    cmbCustodia.Visible = True
    
    Frame1.Left = 30
    Frame1.Top = 4650
    'Me.Height = 8295   'JBH, 22-12-2009
    'fin JBH, 16-10-2009
    
    
    If ControlAtribuciones() = True Then
        Me.Height = 9090
    Else
        Me.Height = 8295
    End If

End Sub

Private Sub txtRutCli_DblClick()

    BacAyuda.Tag = "MDCL"
    BacAyuda.Show 1
    
    If giAceptar% = True Then
        txtRutCli.Text = Val(gsrut$)
        txtDigCli.Text = gsDigito$
        lbl_nom_cli.Caption = gsDescripcion$
        TxtCodCli.Text = gsvalor$
        
        'Validar que si es operación normal no haya seleccionado a CorpBanca pues sería
        'una operacion Intramesa (JBH, 11-12-2009)
        If Trim(txtRutCli.Text) <> "" Then
            If ope_intramesa = False Then   'JBH, 11-12-2009 Operación Normal
                If txtRutCli.Text = gsBac_RutC Then 'JBH, 11-12-2009 Seleccionó Corpbanca...
                    MsgBox "Atención!  La operación no es Intramesa por lo que no puede seleccionar a CorpBanca", vbCritical, gsBac_Version
                    txtRutCli.Text = ""
                    txtDigCli.Text = ""
                    lbl_nom_cli.Caption = ""
                    txtRutCli.SetFocus
                    Exit Sub
                End If
            End If
        End If
        
        Call buscar_pais_contra(txtRutCli.Text, TxtCodCli)
        Call buscar_codigo_contraparte(txtRutCli.Text, TxtCodCli)
        
        Call busca_Corresponsal_Cliente
        'Agregado por JBH, 16-10-2009
        'Call activa_combos_mesa_cartera(txtRutCli.Text)
        'fin JBH, 16-10-2009
        
        'JBH, 25-11-2009
        If Not activa_combos_mesa_cartera(txtRutCli.Text) Then
            giAceptar = False
            Unload Me
        End If

        'fin JBH, 25-11-2009
        
    Else
        SendKeys "{TAB 2}"
    End If

End Sub
Function buscar_pais_contra(rut, Codigo)
    Dim Datos()
    envia = Array()
    AddParam envia, rut
    AddParam envia, Codigo
    If Bac_Sql_Execute("SVC_INT_PAI_CLI", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            Pais_invers = Datos(1)
        Loop
    End If
End Function

Private Sub txtRutCli_KeyPress(KeyAscii As Integer)

    BacCaracterNumerico KeyAscii
    
    If KeyAscii = 13 Then SendKeys "{TAB}"

End Sub

Private Sub txtRutCli_LostFocus()
On Error GoTo falla

    'Validar que si es operación normal no haya seleccionado a CorpBanca pues sería
    'una operacion Intramesa (JBH, 11-12-2009)
    If Trim(txtRutCli.Text) <> "" Then
        If ope_intramesa = False Then   'JBH, 11-12-2009 Operación Normal
            If txtRutCli.Text = gsBac_RutC Then 'JBH, 11-12-2009 Seleccionó Corpbanca...
                MsgBox "Atención!  La operación no es Intramesa por lo que no puede seleccionar a CorpBanca", vbCritical, gsBac_Version
                txtRutCli.Text = ""
                txtDigCli.Text = ""
                lbl_nom_cli.Caption = ""
                txtRutCli.SetFocus

                Exit Sub
            End If
        End If
    End If
    
    Call carga_combo_operadores(txtRutCli.Text)
    'JBH, 16-10-2009
    'Call activa_combos_mesa_cartera(txtRutCli.Text)
    'fin JBH, 16-10-2009
    'JBH, 25-11-2009
    If Not activa_combos_mesa_cartera(txtRutCli.Text) Then
        giAceptar = False
        Unload Me
        Exit Sub
    End If
    
    'fin JBH, 25-11-2009
    Exit Sub
falla:
    MsgBox "Se ha producido el siguiente error: " & err.Description, vbCritical, gsBac_Version
End Sub
