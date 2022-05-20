VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form FRM_ING_GRABACION 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "GRABAR OPERACION"
   ClientHeight    =   5115
   ClientLeft      =   1785
   ClientTop       =   1890
   ClientWidth     =   9855
   ClipControls    =   0   'False
   ControlBox      =   0   'False
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
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5115
   ScaleWidth      =   9855
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.Toolbar TBL_Menu 
      Height          =   450
      Left            =   -15
      TabIndex        =   20
      Top             =   0
      Width           =   9840
      _ExtentX        =   17357
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   5760
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   25
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":0467
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":095D
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":0DF0
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":12D8
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":17EB
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":1D28
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":216A
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":2624
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":2AF7
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":2F3B
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":34A2
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":3971
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":3D90
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":4288
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":4681
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":4B04
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":4FCA
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":54C1
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":5977
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":5D3C
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":6132
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":6529
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":6932
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_GRABACION.frx":6DF0
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSFrame SFRM_Cliente 
      Height          =   1095
      Index           =   3
      Left            =   0
      TabIndex        =   16
      Top             =   495
      Width           =   9840
      _Version        =   65536
      _ExtentX        =   17357
      _ExtentY        =   1931
      _StockProps     =   14
      Caption         =   "Cliente"
      ForeColor       =   -2147483641
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin BACControles.TXTNumero TXTRutcli 
         Height          =   315
         Left            =   975
         TabIndex        =   0
         Top             =   270
         Width           =   1170
         _ExtentX        =   2064
         _ExtentY        =   556
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.TextBox TXT_Digito 
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
         Left            =   2280
         Locked          =   -1  'True
         TabIndex        =   1
         Top             =   270
         Width           =   240
      End
      Begin VB.TextBox TXT_Nombre 
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
         Left            =   975
         Locked          =   -1  'True
         TabIndex        =   3
         Top             =   600
         Width           =   7710
      End
      Begin VB.TextBox TXT_Codigo 
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
         Left            =   7605
         MaxLength       =   7
         TabIndex        =   2
         Top             =   270
         Width           =   1065
      End
      Begin VB.Line Line1 
         X1              =   2190
         X2              =   2250
         Y1              =   405
         Y2              =   405
      End
      Begin VB.Label LBL_Rut 
         Caption         =   "Rut"
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
         Height          =   255
         Index           =   5
         Left            =   120
         TabIndex        =   19
         Top             =   315
         Width           =   825
      End
      Begin VB.Label LBL_Nombre 
         Caption         =   "Nombre"
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
         Height          =   210
         Index           =   7
         Left            =   135
         TabIndex        =   18
         Top             =   645
         Width           =   885
      End
      Begin VB.Label LBL_Codigo 
         Caption         =   "Codigo"
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
         Height          =   210
         Index           =   9
         Left            =   6885
         TabIndex        =   17
         Top             =   300
         Width           =   765
      End
   End
   Begin Threed.SSFrame SFRM_Operacion 
      Height          =   2295
      Index           =   0
      Left            =   0
      TabIndex        =   12
      Top             =   1530
      Width           =   9840
      _Version        =   65536
      _ExtentX        =   17357
      _ExtentY        =   4048
      _StockProps     =   14
      Caption         =   "Operación"
      ForeColor       =   -2147483641
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin VB.ComboBox CMB_Fpago_Ini 
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
         ItemData        =   "FRM_ING_GRABACION.frx":72B1
         Left            =   3345
         List            =   "FRM_ING_GRABACION.frx":72B8
         Style           =   2  'Dropdown List
         TabIndex        =   28
         Top             =   585
         Width           =   3300
      End
      Begin VB.ComboBox Cmb_FPago_Ven 
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
         Left            =   6675
         Style           =   2  'Dropdown List
         TabIndex        =   27
         Top             =   585
         Width           =   3180
      End
      Begin BACControles.TXTFecha TXT_Fecha_Pago 
         Height          =   315
         Left            =   6720
         TabIndex        =   8
         TabStop         =   0   'False
         Top             =   1230
         Width           =   1440
         _ExtentX        =   2540
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
         MaxDate         =   402133
         MinDate         =   18264
         Text            =   "27/11/2002"
      End
      Begin VB.ComboBox CMB_Tipo_Pago 
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
         ItemData        =   "FRM_ING_GRABACION.frx":72CB
         Left            =   120
         List            =   "FRM_ING_GRABACION.frx":72D2
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   1800
         Visible         =   0   'False
         Width           =   3180
      End
      Begin VB.ComboBox CMB_Area 
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
         Left            =   3360
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   1230
         Width           =   3300
      End
      Begin VB.ComboBox CMB_Sucursal 
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
         Left            =   105
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   1230
         Width           =   3195
      End
      Begin VB.ComboBox CMB_Entidad 
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
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   615
         Width           =   3180
      End
      Begin VB.TextBox txtDigCar 
         BackColor       =   &H00FFFFFF&
         Enabled         =   0   'False
         Height          =   285
         Left            =   1485
         MaxLength       =   1
         TabIndex        =   13
         Top             =   5670
         Width           =   255
      End
      Begin VB.TextBox txtNomCar 
         BackColor       =   &H00FFFFFF&
         Enabled         =   0   'False
         Height          =   285
         Left            =   1845
         TabIndex        =   14
         Top             =   5670
         Width           =   3030
      End
      Begin VB.Label LBL_Mercado 
         Caption         =   "Forma de Pago Entrada"
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
         Height          =   255
         Index           =   8
         Left            =   3315
         TabIndex        =   30
         Top             =   360
         Width           =   3075
      End
      Begin VB.Label LBL_Mercado 
         Caption         =   "Forma de Pago Vencimientos"
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
         Height          =   255
         Index           =   0
         Left            =   6675
         TabIndex        =   29
         Top             =   360
         Width           =   3075
      End
      Begin VB.Label LBL_Fecha_Pago 
         Caption         =   "Fecha de Pago"
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
         Height          =   255
         Index           =   14
         Left            =   6720
         TabIndex        =   24
         Top             =   990
         Width           =   1410
      End
      Begin VB.Label LBL_Sucursal 
         Caption         =   "Sucursal"
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
         Height          =   255
         Index           =   12
         Left            =   105
         TabIndex        =   23
         Top             =   990
         Width           =   3075
      End
      Begin VB.Label LBL_Tipo_Pago 
         Caption         =   "Tipo de Pago"
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
         Height          =   255
         Index           =   11
         Left            =   120
         TabIndex        =   22
         Top             =   1560
         Visible         =   0   'False
         Width           =   3090
      End
      Begin VB.Label LBL_Area_Respon 
         Caption         =   "Area Responsable"
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
         Height          =   255
         Index           =   10
         Left            =   3315
         TabIndex        =   21
         Top             =   990
         Width           =   3075
      End
      Begin VB.Label LBL_Entidad 
         Caption         =   "Entidad"
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
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   15
         Top             =   390
         Width           =   3075
      End
      Begin VB.Label LBL_For_Pago_Ini 
         Caption         =   "Forma de Pago Inicial"
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
         Height          =   255
         Index           =   2
         Left            =   3345
         TabIndex        =   31
         Top             =   330
         Width           =   3075
      End
   End
   Begin Threed.SSFrame SFRM_Operaciones 
      Height          =   1260
      Index           =   2
      Left            =   2100
      TabIndex        =   25
      Top             =   3825
      Width           =   7740
      _Version        =   65536
      _ExtentX        =   13652
      _ExtentY        =   2222
      _StockProps     =   14
      Caption         =   "Observaciones"
      ForeColor       =   -2147483641
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin VB.TextBox TXT_Observacion 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   825
         Left            =   75
         MaxLength       =   70
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   11
         Top             =   285
         Width           =   7605
      End
   End
   Begin Threed.SSFrame SFRM_Tipo_Retiro 
      Height          =   1275
      Index           =   1
      Left            =   30
      TabIndex        =   26
      Top             =   3825
      Width           =   2055
      _Version        =   65536
      _ExtentX        =   3625
      _ExtentY        =   2249
      _StockProps     =   14
      Caption         =   "Tipo Retiro"
      ForeColor       =   -2147483641
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin Threed.SSOption CHK_Vamos 
         Height          =   300
         Left            =   120
         TabIndex        =   9
         Top             =   330
         Width           =   1020
         _Version        =   65536
         _ExtentX        =   1799
         _ExtentY        =   529
         _StockProps     =   78
         Caption         =   "Vamos"
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption CHK_Vienen 
         Height          =   300
         Left            =   120
         TabIndex        =   10
         Top             =   630
         Width           =   1035
         _Version        =   65536
         _ExtentX        =   1826
         _ExtentY        =   529
         _StockProps     =   78
         Caption         =   "Vienen"
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_ING_GRABACION"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim vDatos_Retorno()

Dim cVentana_Ingreso As Form
Dim cVentana_Detalle As Form
Dim cVentana_Aux As Form
Dim nMercado As Integer
Dim cProducto As String

Private Sub CHK_Vamos_KeyPress(KeyAscii As Integer)
    PROC_CARACTER_NUMERICO KeyAscii
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub
Private Sub CHK_Vienen_KeyPress(KeyAscii As Integer)
    PROC_CARACTER_NUMERICO KeyAscii
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub
Private Sub CMB_Area_KeyPress(KeyAscii As Integer)
    PROC_CARACTER_NUMERICO KeyAscii
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub
Private Sub CMB_Entidad_KeyPress(KeyAscii As Integer)
    PROC_CARACTER_NUMERICO KeyAscii
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub
Private Sub CMB_Fpago_Ini_KeyPress(KeyAscii As Integer)
    PROC_CARACTER_NUMERICO KeyAscii
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub
Private Sub CMB_Sucursal_KeyPress(KeyAscii As Integer)
    PROC_CARACTER_NUMERICO KeyAscii
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub

Private Sub CMB_Tipo_Pago_Click()
  Select Case CMB_Tipo_Pago.ListIndex
      Case Is = 0
         TXT_Fecha_Pago.Text = Format(GLB_Fecha_Proceso, "dd/mm/yyyy")
        'SE COMENTAREA PARA EFECTOS DE LLAVE PRIMARIA : EB20041022
        '*********************************************************
      'Case Is = 1
      '   TXT_Fecha_Pago.Text = Format(GLB_Fecha_Proxima, "dd/mm/yyyy")
      'Case Else
      '   MsgBox "Problemas con el tipo de pago"
      '***********************************************************
   End Select
End Sub

Private Sub CMB_Tipo_Pago_KeyPress(KeyAscii As Integer)
    PROC_CARACTER_NUMERICO KeyAscii
   
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim nOpcion As Integer

    If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

        Select Case KeyCode
            Case vbKeyGrabar 'Grabar
                nOpcion = 1
            Case vbKeySalir 'Salir
                nOpcion = 2
        End Select
        
        If nOpcion > 0 Then
            If TBL_MENU.Buttons(nOpcion).Enabled Then
                KeyCode = 0
                TBL_Menu_ButtonClick TBL_MENU.Buttons(nOpcion)
            End If
        End If
    
    End If

End Sub


Private Sub Form_Load()
Dim I%
Dim aGrabar()
ReDim aGrabar(15)
Dim vDatos_Retorno()
Dim cMoneda As String
Dim nContador As Integer

GLB_cOptLocal = cOpt
    
    If GLB_Formulario = "FRM_ING_CORFO" Or GLB_Formulario = "FRM_ING_RENOVACIONES" Then
        Me.TXTRutcli.Enabled = False
        Me.TXT_Digito.Enabled = False
        Me.TXT_Nombre.Enabled = False
        Me.TXT_Codigo.Enabled = False
                
        GLB_Envia = Array()
        
        PROC_AGREGA_PARAMETRO GLB_Envia, 60706000
        PROC_AGREGA_PARAMETRO GLB_Envia, 1
        PROC_AGREGA_PARAMETRO GLB_Envia, 1
        
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_CLIENTE_POR_RUT", GLB_Envia) Then
            Exit Sub
        End If
        
        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
            TXTRutcli.Text = 60706000
            TXT_Codigo.Text = vDatos_Retorno(3)
            TXT_Digito.Text = vDatos_Retorno(2)
            TXT_Nombre.Text = vDatos_Retorno(4)
        End If
        
        SFRM_Tipo_Retiro.Item(1).Visible = False
        SFRM_Operaciones.Item(2).left = 15
    End If
    
   
    PROC_CENTRAR_PANTALLA Me
    
    
    
    If GLB_Formulario = "FRM_ING_BONOS" Then
        Set cVentana_Aux = FRM_ING_BONOS
        Call FUNC_CON_FORMA_DE_PAGO(CMB_Fpago_Ini, 0, "UF")
        Call FUNC_CON_FORMA_DE_PAGO(Cmb_FPago_Ven, 0, "UF")
        nMercado = 1
    ElseIf GLB_Formulario = "FRM_ING_CORFO" Then
        Set cVentana_Aux = FRM_ING_CORFO
        cMoneda = cVentana_Aux.CMB_Moneda.Text
        Call FUNC_CON_FORMA_DE_PAGO(CMB_Fpago_Ini, 0, cMoneda)
        Call FUNC_CON_FORMA_DE_PAGO(Cmb_FPago_Ven, 0, cMoneda)
        nMercado = 1
    ElseIf GLB_Formulario = "FRM_ING_BANCO_LOCAL" Then
        Set cVentana_Aux = FRM_ING_BANCO_LOCAL
        cMoneda = cVentana_Aux.CMB_Moneda.Text
        Call FUNC_CON_FORMA_DE_PAGO(CMB_Fpago_Ini, 0, cMoneda)
        Call FUNC_CON_FORMA_DE_PAGO(Cmb_FPago_Ven, 0, cMoneda)
        nMercado = 1
    ElseIf GLB_Formulario = "FRM_ING_BANCO_EXT" Then
        Set cVentana_Aux = FRM_ING_BANCO_EXT
        cMoneda = cVentana_Aux.CMB_Moneda.Text
        Call FUNC_CON_FORMA_DE_PAGO(CMB_Fpago_Ini, 0, cMoneda)
        Call FUNC_CON_FORMA_DE_PAGO(Cmb_FPago_Ven, 0, cMoneda)
        nMercado = 2
    ElseIf GLB_Formulario = "FRM_ING_RENOVACIONES" Then
        Set cVentana_Aux = FRM_ING_RENOVACIONES
        cMoneda = cVentana_Aux.CMB_Moneda.Text
        Call FUNC_CON_FORMA_DE_PAGO(CMB_Fpago_Ini, 0, cMoneda)
        Call FUNC_CON_FORMA_DE_PAGO(Cmb_FPago_Ven, 0, cMoneda)
        nMercado = 1
    ElseIf GLB_Formulario = "FRM_ING_PRE_PAGO" Then
        Set cVentana_Aux = FRM_ING_PRE_PAGO
        cMoneda = cVentana_Aux.CMB_Moneda.Text
        Call FUNC_CON_FORMA_DE_PAGO(CMB_Fpago_Ini, 0, cMoneda)
        Call FUNC_CON_FORMA_DE_PAGO(Cmb_FPago_Ven, 0, cMoneda)
        nMercado = 1
    ElseIf GLB_Formulario = "FRM_ING_RENOVACIONES_B" Then
        Set cVentana_Aux = FRM_ING_RENOVACIONES
        cMoneda = cVentana_Aux.CMB_Moneda.Text
        Call FUNC_CON_FORMA_DE_PAGO(CMB_Fpago_Ini, 0, cMoneda)
        Call FUNC_CON_FORMA_DE_PAGO(Cmb_FPago_Ven, 0, cMoneda)
        nMercado = 1
    ElseIf GLB_Formulario = "FRM_ING_RENOVACIONES_E" Then
        Set cVentana_Aux = FRM_ING_RENOVACIONES
        cMoneda = cVentana_Aux.CMB_Moneda.Text
        Call FUNC_CON_FORMA_DE_PAGO(CMB_Fpago_Ini, 0, cMoneda)
        Call FUNC_CON_FORMA_DE_PAGO(Cmb_FPago_Ven, 0, cMoneda)
        nMercado = 1
    End If
    
    Call FUNC_CON_CARTERAS("", CMB_Entidad)
    Call FUNC_CON_SUCURSAL(CMB_Sucursal, 0)
    Call FUNC_CON_AREARESP(CMB_Area)
    
    CHK_Vienen.Value = True
    CMB_Tipo_Pago.ListIndex = 0
       
     
    Call PROC_VALORES_DEFECTO
   
    If GLB_Formulario = "FRM_ING_RENOVACIONES_B" Or GLB_Formulario = "FRM_ING_RENOVACIONES" Or GLB_Formulario = "FRM_ING_RENOVACIONES_E" Or GLB_Formulario = "FRM_ING_PRE_PAGO" Then
         
         Me.TXTRutcli.Enabled = False
         Me.TXT_Digito.Enabled = False
         Me.TXT_Nombre.Enabled = False
         Me.TXT_Codigo.Enabled = False
         
'         If GLB_Formulario = "FRM_ING_PRE_PAGO" Then
'            SFRM_Operacion(0).Enabled = False
'            SFRM_Tipo_Retiro(1).Enabled = False
'            SFRM_Operaciones(2).Enabled = False
'         End If
                
          GLB_Envia = Array()
          PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(cVentana_Aux.txt_Numero_Operacion.Text)
          
          If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_RENOVACION_OPERACION", GLB_Envia) Then
          
             MsgBox "No fue posible leer información", vbOKOnly + vbCritical
             Exit Sub
             
          Else
          
            
             Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
             
               TXTRutcli.Text = vDatos_Retorno(20)
               TXT_Codigo.Text = vDatos_Retorno(21)
               TXT_Digito.Text = vDatos_Retorno(22)
               TXT_Nombre.Text = vDatos_Retorno(23)
                   
                For nContador = 0 To CMB_Entidad.ListCount - 1
                
                   CMB_Entidad.ListIndex = nContador
                   
                   If CDbl(CMB_Entidad.ItemData(CMB_Entidad.ListIndex)) = CDbl(vDatos_Retorno(24)) Then
                      
                      Exit For
                   
                   End If
                      
                Next
               
                   
                For nContador = 0 To CMB_Fpago_Ini.ListCount - 1
                
                   CMB_Fpago_Ini.ListIndex = nContador
                   
                   If CDbl(CMB_Fpago_Ini.ItemData(CMB_Fpago_Ini.ListIndex)) = CDbl(vDatos_Retorno(26)) Then
                      
                      Exit For
                   
                   End If
                      
                Next
                
                For nContador = 0 To CMB_Tipo_Pago.ListCount - 1
                
                   CMB_Tipo_Pago.ListIndex = nContador
                   
                   If CDbl(CMB_Tipo_Pago.ItemData(CMB_Tipo_Pago.ListIndex)) = CDbl(vDatos_Retorno(27)) Then
                      
                      Exit For
                   
                   End If
                      
                Next
                   
                For nContador = 0 To CMB_Area.ListCount - 1
                
                   CMB_Area.ListIndex = nContador
                   
                   If CDbl(CMB_Area.ItemData(CMB_Area.ListIndex)) = CDbl(vDatos_Retorno(28)) Then
                      
                      Exit For
                   
                   End If
                      
                Next
                   
                For nContador = 0 To CMB_Sucursal.ListCount - 1
                
                   CMB_Sucursal.ListIndex = nContador
                   
                   If CDbl(CMB_Sucursal.ItemData(CMB_Sucursal.ListIndex)) = CDbl(vDatos_Retorno(29)) Then
                      
                      Exit For
                   
                   End If
                      
                Next
                                  
               TXT_Fecha_Pago.Text = vDatos_Retorno(30)
               
               If CDbl(vDatos_Retorno(31)) = 0 Then
                  CHK_Vamos.Value = True
                  CHK_Vienen.Value = False
               Else
                  CHK_Vamos.Value = False
                  CHK_Vienen.Value = True
               End If
                   
               TXT_Observacion.Text = Trim(vDatos_Retorno(32))
               
             Loop
            
         End If
         
      End If
      
   
   Call PROC_LOG_AUDITORIA("07", GLB_cOptLocal, Me.Caption, "", "")

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call PROC_LOG_AUDITORIA("08", GLB_cOptLocal, Me.Caption, "", "")

End Sub

Private Sub TBL_Menu_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Trim(UCase(Button.Key))

    Case "GRABAR"
        
'         If (objCentralizacion.Chequeo_Estado(GLB_Sistema, "bloqueo", False) And objCentralizacion.Error = 0) Then
'
'             MsgBox objCentralizacion.Mensaje, vbExclamation
'             Exit Sub
'
'         End If
'
        CMB_Tipo_Pago.Text = "HOY"
        GLB_Aceptar = False

        If FUNC_DATOS_RETORNO Then

            If GLB_Formulario = "FRM_ING_CORFO" Then

                Call FUNC_GRABAR_CORFO

            ElseIf GLB_Formulario = "FRM_ING_RENOVACIONES" Or GLB_Formulario = "FRM_ING_RENOVACIONES_B" Or GLB_Formulario = "FRM_ING_RENOVACIONES_E" Then

                Call FUNC_GRABAR_RENOVACION

            ElseIf GLB_Formulario = "FRM_ING_PRE_PAGO" Then

                Call FUNC_GRABAR_PRE_PAGO

            ElseIf GLB_Formulario = "FRM_ING_BANCO_LOCAL" Then

                Call FUNC_GRABAR_LOCAL

            ElseIf GLB_Formulario = "FRM_ING_BANCO_EXT" Then

                Call FUNC_GRABAR_EXTRANJERO

            Else

                Call PROC_GRABAR_BONOS

            End If

        End If
    
    Case "SALIR"
    
      GLB_Aceptar = False
      Unload Me
        
   End Select

End Sub




Sub PROC_DEFECTO_COMBO(xCombo As ComboBox, Valor As String)
Dim I As Integer
        For I = 0 To xCombo.ListCount - 1
      
            If Trim(xCombo.List(I)) = Trim(Valor) Then
               xCombo.ListIndex = I
               Exit For
            End If
      
        Next I

End Sub

Sub PROC_VALORES_DEFECTO()
Dim I As Integer
   
   Dim Valor_Defecto As Integer 'Valores_Defecto
   
'    If GLB_Formulario = "FRM_ING_CORFO" Then
'        Call GLB_objControl.PROC_VALORES_DEFECTO("CORFO", Valor_Defecto)
'    ElseIf GLB_Formulario = "FRM_ING_BANCO_LOCAL" Then
'        Call GLB_objControl.PROC_VALORES_DEFECTO("LOCAL", Valor_Defecto)
'    ElseIf GLB_Formulario = "FRM_ING_BANCO_EXT" Then
'        Call GLB_objControl.PROC_VALORES_DEFECTO("EXTRA", Valor_Defecto)
'    Else
'        Call GLB_objControl.PROC_VALORES_DEFECTO("BONOS", Valor_Defecto)
'    End If
'
'   With Valor_Defecto
'
'      PROC_ESTABLECE_DEFECTO CMB_Fpago_Ini, .nValor_forma_pago_entre
'      PROC_ESTABLECE_DEFECTO CMB_Area, .cValor_codigo_area
'      PROC_ESTABLECE_DEFECTO CMB_Tipo_Pago, .cValor_tipo_pago
'      PROC_ESTABLECE_DEFECTO CHK_Vamos, .cValor_tipo_retiro
'
'      CHK_Vienen.Value = Not CHK_Vamos
'
'   End With

End Sub

Private Sub TXT_Codigo_KeyPress(KeyAscii As Integer)
    PROC_CARACTER_NUMERICO KeyAscii
   
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
    

End Sub


Private Sub TXT_Codigo_LostFocus()
Dim vDatos_Retorno()

If CDbl(Me.TXTRutcli.Text) = 0 Then Exit Sub
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(TXTRutcli.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, Val(TXT_Codigo.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, nMercado
         
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_CLIENTE_POR_RUT", GLB_Envia) Then
        MsgBox "Error al buscar Cliente", vbInformation
        Exit Sub
    End If

    If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
        TXT_Nombre.Text = vDatos_Retorno(4)
        TXT_Digito.Text = vDatos_Retorno(2)
    Else
        MsgBox ("Cliente no existe"), vbOKOnly + vbInformation
        TXTRutcli.Text = ""
        TXT_Codigo.Text = ""
        TXT_Nombre.Text = ""
        TXTRutcli.SetFocus
    End If

End Sub

Private Sub TXT_Observacion_KeyPress(KeyAscii As Integer)
       
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)

End Sub

Private Sub txtRutCli_Change()

    TXT_Nombre.Text = ""
    TXT_Digito.Text = ""
    TXT_Codigo.Text = ""

End Sub

Private Sub txtRutCli_DblClick()
Call PROC_CON_CLIENTE

End Sub

Sub PROC_CON_CLIENTE()
On Error GoTo Error_Cliente
    'Ayuda para Clientes
    '----------------------------------
    cMiTag = "MDCL"
    If GLB_Formulario = "FRM_ING_BANCO_EXT" Then
        cMiTag = "MDEX"
    End If


    FRM_AYUDA.Show 1
    If GLB_Aceptar% = True Then
        TXTRutcli.Text = GLB_rut$
        TXT_Digito.Text = GLB_Digito$
        TXT_Nombre.Text = GLB_Descripcion$
        TXT_Codigo.Text = GLB_codigo$
        
    End If
    Exit Sub
    
Error_Cliente:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
    Exit Sub
    
End Sub

Private Sub txtRutCli_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call PROC_CON_CLIENTE
   
End Sub

Private Sub txtRutCli_KeyPress(KeyAscii As Integer)
    PROC_CARACTER_NUMERICO KeyAscii
   
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
    
    
End Sub

Private Sub PROC_GRABAR_BONOS()

Dim rstOperacion_Cabecera     As New ADODB.Recordset
Dim rstOperacion_Detalle      As New ADODB.Recordset
Dim rstMensaje                As New ADODB.Recordset
Dim nContador                 As Integer
Dim RetRate                   As Double
Dim nValor_Moneda             As Double
Dim nNumero_Ope               As Integer
Dim nCant_Registros           As Integer
Dim nCont_Registros           As Integer
Dim vDatos_Retorno()

nCont_Registros = 0
GLB_Aceptar% = False
If FUNC_EXECUTA_COMANDO_SQL("SP_CON_NUMERO_OPERACION") Then
    If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
        nNumero_Ope = Val(vDatos_Retorno(1))
    End If
End If
 
 GLB_Envia = Array()
 PROC_AGREGA_PARAMETRO GLB_Envia, Mid(FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(1, 0), 1, 15)
 PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(1, 1))

If FUNC_EXECUTA_COMANDO_SQL("SP_DATOS_TIR", GLB_Envia) Then
     If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
        nCant_Registros = Val(vDatos_Retorno(1))
     End If
End If

If Val(FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(1, 8)) = 994 Then
    nValor_Moneda = GLB_DO
ElseIf Val(FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(1, 8)) <> 994 And Val(FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(1, 8)) <> 998 Then
    nValor_Moneda = 1
ElseIf Val(FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(1, 8)) = 998 Then
    nValor_Moneda = GLB_UF
End If


ReDim Values(nCant_Registros) As Double    ' Set up array.
Dim Guess   As Double
Guess = 0.1                                 ' Guess starts at 10 percent.
Values(0) = ((CDbl(FRM_ING_BONOS.FTB_VALOR_ESTIMADO1.Text) _
            + CDbl(FRM_ING_BONOS.FTB_VALOR_ESTIMADO2.Text) _
            + CDbl(FRM_ING_BONOS.FTB_VALOR_ESTIMADO3.Text) _
            + CDbl(FRM_ING_BONOS.FTB_VALOR_ESTIMADO4.Text))) _
            - CDbl(FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(1, 1))   ' Business start-up costs.

If FUNC_EXECUTA_COMANDO_SQL("SP_DATOS_TIR", GLB_Envia) Then
    nCont_Registros = nCont_Registros + 1
    Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
        Values(nCont_Registros) = CDbl(vDatos_Retorno(2))
        nCont_Registros = nCont_Registros + 1
    Loop
End If
 
' Calculate internal rate.
  
 '   RetRate = IRR(Values, Guess) * 2

Set rstOperacion_Cabecera = FUNC_RETORNA_RECORDSET_CABECERA
Set rstOperacion_Detalle = FUNC_RETORNA_RECORDSET_DETALLE

With rstOperacion_Cabecera
For nContador = 1 To FRM_ING_BONOS.Grd_Compra_Bonos.Rows - 1

        .AddNew "inumero_operacion", nNumero_Ope
        .Update "centidad_cartera", CMB_Entidad.ItemData(CMB_Entidad.ListIndex)
        .Update "icodigo_instrumento", CDbl(FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(nContador, 6))
        .Update "inumero_operacion", nNumero_Ope
        .Update "inumero_correlativo", nContador
        .Update "inumero_acuerdo", 0
        .Update "cnombre_serie", Mid(FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(nContador, 0), 1, 15)
'******************************
'        .Update "dfecha_emision", " "
'        .Update "dfecha_vencimiento", " "
        .Update "dfecha_proximo_cupon", GLB_FecpCupon
        .Update "dfecha_anterior_cupon", GLB_FecuCupon
'******************************
        .Update "dfecha_colocacion", CDate(FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(nContador, 9))
        .Update "irut_emisor", 0
        .Update "cgenerico_emisor", ""
        .Update "irut_cliente", CDbl(TXTRutcli.Text)
        .Update "ccodigo_cliente", Val(TXT_Codigo.Text)
        .Update "inumero_cuotas", 0
        .Update "iperido_amortizacion", 0
        .Update "imoneda_emision", Val(FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(nContador, 8))
        .Update "nnominal", CDbl(FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(nContador, 1))
        .Update "nnominal_pesos", 0
        .Update "ntasa_emision", 0
        .Update "ibase_emision", 0
        .Update "nvalor_emision_pesos", 0
        .Update "nvalor_emision_um", 0
        .Update "nvalorvtocuptasemi", 0
        .Update "nreajuste_emision", 0
        .Update "ninteres_emision", 0
        .Update "nvalor_presente_emi", 0
        .Update "nvalor_proxpre_emi", 0
        .Update "nvalor_par_emi", 0
        .Update "ntasa_colocacion", CDbl(FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(nContador, 2))
        .Update "ibase_colocacion", FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(nContador, 3)
        .Update "nvalor_colocacion_pesos", FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(nContador, 5)
        .Update "nvalor_colocacion_um", 0
        .Update "nreajuste_colocacion", 0
        .Update "ninteres_colocacion", 0
        .Update "nvalor_presente_colocacion", FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(nContador, 5)
        .Update "nvalor_proxpre_colocacion", 0 'cVentana_Ingreso.SCHK_Capitaliza.Value NO ES NECESARIO
        .Update "nvalor_par_colocacion", CDbl(FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(nContador, 4))
        .Update "iforma_pago", CDbl(CMB_Fpago_Ini.ItemData(CMB_Fpago_Ini.ListIndex))
        .Update "itipo_tasa", 0
        .Update "ntasa_spread", 0
        .Update "iretiro_documento", IIf(Me.CHK_Vamos.Value = True, 1, 0)
        .Update "irut_acreedor", 0
        .Update "cdigito_acreedor", ""
        .Update "cnombre_acreedor", ""
        .Update "ccodigo_area", CMB_Area.ItemData(CMB_Area.ListIndex)
        .Update "csucursal", CMB_Sucursal.ItemData(CMB_Sucursal.ListIndex)
        .Update "coperador", GLB_Usuario
        .Update "cterminal", ""
        .Update "chora", ""
        .Update "ctipo_mercado", 0
        .Update "cimpreso", ""
        .Update "cpago_hoy_man", IIf(CMB_Tipo_Pago.Text = "HOY", "0", "1")
        .Update "cobservacion", TXT_Observacion.Text
        .Update "cnumero_pu", ""
        .Update "nkeyid_deskmanager", 0
        .Update "ilibro_deskmanager", 0
        .Update "inumero_anterior", 0
        .Update "cproducto", FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(nContador, 7)
        .Update "iforma_pago_ven", CDbl(Cmb_FPago_Ven.ItemData(Cmb_FPago_Ven.ListIndex))
        .Update "cValorEstimado1", FRM_ING_BONOS.FTB_VALOR_ESTIMADO1.Text
        .Update "cValorEstimado2", FRM_ING_BONOS.FTB_VALOR_ESTIMADO2.Text
        .Update "cValorEstimado3", FRM_ING_BONOS.FTB_VALOR_ESTIMADO3.Text
        .Update "cValorEstimado4", FRM_ING_BONOS.FTB_VALOR_ESTIMADO4.Text
        .Update "cTasa_Efectiva", CDbl(0)
Next nContador

        If Not Grabar_Operacion(rstMensaje, rstOperacion_Cabecera, rstOperacion_Detalle, CDate(GLB_Fecha_Proceso)) Then
            MsgBox FUNC_RETORNA_MENSAJE(rstMensaje), vbCritical
            Call PROC_LOG_AUDITORIA("01", "", Me.Caption & Space(2) & "(error al grabar Operacion BONOS)" & Space(1) & nNumero_Ope & Space(2) & "Fecha :" & GLB_Fecha_Proceso, "", "")

            Exit Sub

        End If

        End With
        rstOperacion_Cabecera.Close

      MsgBox "Operación Número " & nNumero_Ope & " Grabada Exitosamente", vbOKOnly + vbInformation
      Call PROC_LOG_AUDITORIA("01", "", Me.Caption & Space(2) & "(Grabado exito Operacion BONOS)" & Space(1) & nNumero_Ope & Space(2) & "Fecha :" & GLB_Fecha_Proceso, "", "")
      GLB_Aceptar% = True
'
Unload Me

End Sub

Function FUNC_DATOS_RETORNO()

FUNC_DATOS_RETORNO = False


    If Me.TXTRutcli.Text = "" Then
        MsgBox ("Debe ingresar Rut del Cliente"), vbOKOnly + vbInformation
        Exit Function
    ElseIf Me.TXT_Codigo.Text = "" Then
        MsgBox ("Debe ingresar Código del Cliente"), vbOKOnly + vbInformation
        Exit Function
    ElseIf Me.TXT_Nombre.Text = "" Then
        MsgBox ("Debe ingresar nombre del Cliente"), vbOKOnly + vbInformation
        Exit Function
    ElseIf Me.CMB_Area.Text = "" Then
        MsgBox ("Debe ingresar Area"), vbOKOnly + vbInformation
        Exit Function
    ElseIf Me.CMB_Entidad.Text = "" Then
        MsgBox ("Debe ingresar Entidad"), vbOKOnly + vbInformation
        Exit Function
    ElseIf Me.CMB_Fpago_Ini.Text = "" Then
        MsgBox ("Debe ingresar Forma de Pago"), vbOKOnly + vbInformation
        Exit Function
   
    ElseIf Me.CMB_Sucursal.Text = "" Then
        MsgBox ("Debe ingresar Sucursal"), vbOKOnly + vbInformation
        Exit Function
    ElseIf Me.CMB_Tipo_Pago.Text = "" Then
        MsgBox ("Debe ingresar Tipo de Pago"), vbOKOnly + vbInformation
        Exit Function
    End If
    
FUNC_DATOS_RETORNO = True
End Function

Private Function FUNC_GRABAR_CORFO()
On Error GoTo MAL

Dim rstOperacion_Cabecera     As New ADODB.Recordset
Dim rstOperacion_Detalle      As New ADODB.Recordset
Dim rstMensaje                As New ADODB.Recordset
Dim nContador                 As Integer
Dim nNumero_Ope               As Integer
Dim vDatos_Retorno()
Dim nCant_Registros As Integer
Dim RetRate As Double
Dim nValor_Moneda As Double


Set cVentana_Ingreso = FRM_ING_CORFO
Set cVentana_Detalle = FRM_MAN_FLUJOS

FUNC_GRABAR_CORFO = False
GLB_Aceptar% = False

If FUNC_EXECUTA_COMANDO_SQL("SP_CON_NUMERO_OPERACION") Then
    If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
        nNumero_Ope = Val(vDatos_Retorno(1))
    End If
End If

 GLB_Envia = Array()
 PROC_AGREGA_PARAMETRO GLB_Envia, nNumero_Ope
 

If FUNC_EXECUTA_COMANDO_SQL("SP_DATOS_TIR_CORFO", GLB_Envia) Then
     If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
        nCant_Registros = Val(vDatos_Retorno(1))
     End If
End If

If Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) = 994 Then
    nValor_Moneda = GLB_DO
ElseIf Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) <> 994 And Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) <> 998 Then
    nValor_Moneda = 1
ElseIf Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) = 998 Then
    nValor_Moneda = GLB_UF
End If

ReDim Values(cVentana_Detalle.GRD_Flujos.Rows - 1) As Double    ' Set up array.
Dim Guess   As Double
Guess = 0.1                                 ' Guess starts at 10 percent.
Values(0) = ((CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO1.Text) _
            + CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO2.Text) _
            + CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO3.Text) _
            + CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO4.Text)) / nValor_Moneda) _
            - CDbl(cVentana_Ingreso.FTB_Monto.Text)   ' Business start-up costs.

  For nContador = 2 To cVentana_Detalle.GRD_Flujos.Rows - 1
    Values(nContador - 1) = CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 5))
  Next nContador
 
' Calculate internal rate.
  
    RetRate = IRR(Values, Guess) * 2


GLB_Envia = Array()
        
        Set rstOperacion_Cabecera = FUNC_RETORNA_RECORDSET_CABECERA
        Set rstOperacion_Detalle = FUNC_RETORNA_RECORDSET_DETALLE

        With rstOperacion_Cabecera

        .AddNew "inumero_operacion", nNumero_Ope
        .Update "centidad_cartera", CMB_Entidad.ItemData(CMB_Entidad.ListIndex)
        .Update "icodigo_instrumento", CDbl(cVentana_Ingreso.TXT_Familia.Text)
        .Update "inumero_operacion", nNumero_Ope
        .Update "inumero_correlativo", 1
        .Update "inumero_acuerdo", CDbl(cVentana_Ingreso.FTB_Acuerdo.Text)
        .Update "cnombre_serie", cVentana_Ingreso.TXT_Instrumento.Text
        .Update "dfecha_emision", cVentana_Ingreso.TXT_Fecha_Otor.Text
        .Update "dfecha_vencimiento", cVentana_Ingreso.TXT_Fecha_Ven.Text
        .Update "dfecha_proximo_cupon", cVentana_Ingreso.TXT_Fecha_Cuota.Text
        .Update "dfecha_anterior_cupon", cVentana_Ingreso.TXT_Fecha_Otor.Text
        .Update "dfecha_colocacion", cVentana_Ingreso.TXT_Fecha_Capitaliza.Text
        .Update "irut_emisor", 0
        .Update "cgenerico_emisor", ""
        .Update "irut_cliente", CDbl(Me.TXTRutcli.Text)
        .Update "ccodigo_cliente", Val(TXT_Codigo.Text)
        .Update "inumero_cuotas", CDbl(cVentana_Ingreso.FTB_Cuotas.Text)
        .Update "iperido_amortizacion", CDbl(cVentana_Ingreso.CMB_Periodo.ItemData(cVentana_Ingreso.CMB_Periodo.ListIndex))
        .Update "imoneda_emision", CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))
        .Update "nnominal", CDbl(cVentana_Ingreso.FTB_Monto.Text)
        .Update "nnominal_pesos", 0
        .Update "ntasa_emision", CDbl(cVentana_Ingreso.FTB_Tasa.Text)
        .Update "ibase_emision", CDbl(cVentana_Ingreso.CMB_Base.ItemData(cVentana_Ingreso.CMB_Base.ListIndex))
        .Update "nvalor_emision_pesos", 0
        .Update "nvalor_emision_um", CDbl(cVentana_Ingreso.FTB_Monto.Text)
        .Update "nvalorvtocuptasemi", 0
        .Update "nreajuste_emision", 0
        .Update "ninteres_emision", 0
        .Update "nvalor_presente_emi", 0
        .Update "nvalor_proxpre_emi", 0
        .Update "nvalor_par_emi", 0
        .Update "ntasa_colocacion", 0
        .Update "ibase_colocacion", 0
        .Update "nvalor_colocacion_pesos", 0
        .Update "nvalor_colocacion_um", 0
        .Update "nreajuste_colocacion", 0
        .Update "ninteres_colocacion", 0
        .Update "nvalor_presente_colocacion", 0
        .Update "nvalor_proxpre_colocacion", cVentana_Ingreso.SCHK_Capitaliza.Value
        .Update "nvalor_par_colocacion", 0
        .Update "iforma_pago", CDbl(CMB_Fpago_Ini.ItemData(CMB_Fpago_Ini.ListIndex))
        .Update "itipo_tasa", CDbl(cVentana_Ingreso.CMB_Tipo_Tasa.ItemData(cVentana_Ingreso.CMB_Tipo_Tasa.ListIndex))
        .Update "ntasa_spread", CDbl(cVentana_Ingreso.FTB_Spread.Text)
        .Update "iretiro_documento", 0
        .Update "irut_acreedor", cVentana_Ingreso.FTB_Rut.Text
        .Update "cdigito_acreedor", cVentana_Ingreso.TXT_Digito.Text
        .Update "cnombre_acreedor", cVentana_Ingreso.TXT_Nombre.Text
        .Update "ccodigo_area", CMB_Area.ItemData(CMB_Area.ListIndex)
        .Update "csucursal", CMB_Sucursal.ItemData(CMB_Sucursal.ListIndex)
        .Update "coperador", GLB_Usuario
        .Update "cterminal", Mid(GLB_Terminal_Bac, 1, 10)
        .Update "chora", ""
        .Update "ctipo_mercado", 0
        .Update "cimpreso", ""
        .Update "cpago_hoy_man", IIf(CMB_Tipo_Pago.Text = "HOY", "0", "1") 'CMB_Tipo_Pago.ItemData(CMB_Tipo_Pago.ListIndex)
        .Update "cobservacion", TXT_Observacion.Text
        .Update "cnumero_pu", ""
        .Update "nkeyid_deskmanager", 0
        .Update "ilibro_deskmanager", 0
        .Update "inumero_anterior", 0
        .Update "cproducto", "CORFO"
        .Update "iforma_pago_ven", CDbl(Cmb_FPago_Ven.ItemData(Cmb_FPago_Ven.ListIndex))
        .Update "ndecimales", CDbl(cVentana_Ingreso.FTB_Decimales.Text)
        .Update "nperiodo_Gracia", CDbl(cVentana_Ingreso.FTB_Gracia.Text)
        .Update "cValorEstimado1", CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO1.Text)
        .Update "cValorEstimado2", CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO2.Text)
        .Update "cValorEstimado3", CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO3.Text)
        .Update "cValorEstimado4", CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO4.Text)
        .Update "cTasa_Efectiva", RetRate

        With rstOperacion_Detalle

            For nContador = 2 To cVentana_Detalle.GRD_Flujos.Rows - 1

                .AddNew "inumero_operacion", nNumero_Ope
                .Update "centidad_cartera", CMB_Entidad.ItemData(CMB_Entidad.ListIndex)
                .Update "icodigo_instrumento", CDbl(cVentana_Ingreso.TXT_Familia.Text)
                .Update "inumero_operacion", nNumero_Ope
                .Update "inumero_correlativo", 1
                .Update "dfecha_movimiento", TXT_Fecha_Pago.Text
                .Update "dfecha_vencimientos", cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 2)
                .Update "ncuota_correlativo", nContador - 1
                .Update "ncuota_capital", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 3))
                .Update "ncuota_interes", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 4))
                .Update "ncuota_flujo", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 5))
                .Update "ncuota_saldo", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 6))
                .Update "ctipo_cuota", " "

            Next nContador

        End With


        If Not Grabar_Operacion(rstMensaje, rstOperacion_Cabecera, rstOperacion_Detalle, CDate(GLB_Fecha_Proceso)) Then
            MsgBox FUNC_RETORNA_MENSAJE(rstMensaje), vbCritical
            Call PROC_LOG_AUDITORIA("01", "", Me.Caption & Space(2) & "(error al grabar Operacion CORFO)" & Space(1) & nNumero_Ope & Space(2) & "Fecha :" & GLB_Fecha_Proceso, "", "")
            
            
            
            Exit Function
        Else
            MsgBox "Operación Número " & nNumero_Ope & " Grabada Exitosamente", vbOKOnly + vbInformation
            Call PROC_LOG_AUDITORIA("01", "", Me.Caption & Space(2) & "(Grabado Exito CORFO)" & Space(1) & nNumero_Ope & Space(2) & "Fecha :" & GLB_Fecha_Proceso, "", "")
            GLB_Aceptar = True
        End If

        End With

        rstOperacion_Cabecera.Close
        rstOperacion_Detalle.Close
    
FUNC_GRABAR_CORFO = True

Unload Me

MAL:

End Function

Private Function FUNC_GRABAR_LOCAL()
On Error GoTo MAL

Dim rstOperacion_Cabecera     As New ADODB.Recordset
Dim rstOperacion_Detalle      As New ADODB.Recordset
Dim rstMensaje                As New ADODB.Recordset
Dim nContador                 As Integer
Dim nNumero_Ope               As Integer
Dim vDatos_Retorno()
Dim nCant_Registros As Integer
Dim RetRate As Double
Dim nValor_Moneda As Double

Set cVentana_Ingreso = FRM_ING_BANCO_LOCAL
Set cVentana_Detalle = FRM_MAN_FLUJOS

FUNC_GRABAR_LOCAL = False
GLB_Aceptar% = False

If FUNC_EXECUTA_COMANDO_SQL("SP_CON_NUMERO_OPERACION") Then
    If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
        nNumero_Ope = Val(vDatos_Retorno(1))
    End If
End If
           
GLB_Envia = Array()
PROC_AGREGA_PARAMETRO GLB_Envia, nNumero_Ope
 

If FUNC_EXECUTA_COMANDO_SQL("SP_DATOS_TIR_CORFO", GLB_Envia) Then
     If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
        nCant_Registros = Val(vDatos_Retorno(1))
     End If
End If

If Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) = 994 Then
    nValor_Moneda = GLB_DO
ElseIf Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) <> 994 And Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) <> 998 Then
    nValor_Moneda = 1
ElseIf Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) = 998 Then
    nValor_Moneda = GLB_UF
End If


ReDim Values(cVentana_Detalle.GRD_Flujos.Rows - 1) As Double    ' Set up array.

Dim Guess   As Double

Guess = 0.1                                 ' Guess starts at 10 percent.

Values(0) = ((CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO1.Text) _
            + CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO2.Text) _
            + CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO3.Text) _
            + CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO4.Text)) / nValor_Moneda) _
            - CDbl(cVentana_Ingreso.FTB_Monto.Text)   ' Business start-up costs.

  For nContador = 2 To cVentana_Detalle.GRD_Flujos.Rows - 1
    Values(nContador - 1) = CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 5))
  Next nContador
 
' Calculate internal rate.

   RetRate = IRR(Values, Guess) * 2
   
        Set rstOperacion_Cabecera = FUNC_RETORNA_RECORDSET_CABECERA
        Set rstOperacion_Detalle = FUNC_RETORNA_RECORDSET_DETALLE


        With rstOperacion_Cabecera
        .AddNew "inumero_operacion", nNumero_Ope
        .Update "centidad_cartera", CMB_Entidad.ItemData(CMB_Entidad.ListIndex)
        .Update "icodigo_instrumento", CDbl(cVentana_Ingreso.TXT_Familia.Text)
        .Update "inumero_operacion", nNumero_Ope
        .Update "inumero_correlativo", 1
        .Update "cnombre_serie", cVentana_Ingreso.TXT_Instrumento.Text
        .Update "dfecha_emision", cVentana_Ingreso.TXT_Fecha_Otor.Text
        .Update "dfecha_vencimiento", cVentana_Ingreso.TXT_Fecha_Ven.Text
        .Update "dfecha_proximo_cupon", cVentana_Ingreso.TXT_Fecha_Cuota.Text
        .Update "dfecha_anterior_cupon", cVentana_Ingreso.TXT_Fecha_Otor.Text
        .Update "dfecha_colocacion", cVentana_Ingreso.TXT_Fecha_Capitaliza.Text
        .Update "irut_emisor", 0
        .Update "cgenerico_emisor", ""
        .Update "irut_cliente", CDbl(Me.TXTRutcli.Text)
        .Update "ccodigo_cliente", Val(TXT_Codigo.Text)
        .Update "inumero_cuotas", CDbl(cVentana_Ingreso.FTB_Cuotas.Text)
        .Update "iperido_amortizacion", CDbl(cVentana_Ingreso.CMB_Periodo.ItemData(cVentana_Ingreso.CMB_Periodo.ListIndex))
        .Update "imoneda_emision", CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))
        .Update "nnominal", CDbl(cVentana_Ingreso.FTB_Monto.Text)
        .Update "nnominal_pesos", 0
        .Update "ntasa_emision", CDbl(cVentana_Ingreso.FTB_Tasa.Text)
        .Update "ibase_emision", CDbl(cVentana_Ingreso.CMB_Base.ItemData(cVentana_Ingreso.CMB_Base.ListIndex))
        .Update "nvalor_emision_pesos", 0
        .Update "nvalor_emision_um", CDbl(cVentana_Ingreso.FTB_Monto.Text)
        .Update "nvalorvtocuptasemi", 0
        .Update "nreajuste_emision", 0
        .Update "ninteres_emision", 0
        .Update "nvalor_presente_emi", 0
        .Update "nvalor_proxpre_emi", 0
        .Update "nvalor_par_emi", 0
        .Update "ntasa_colocacion", 0
        .Update "ibase_colocacion", 0
        .Update "nvalor_colocacion_pesos", 0
        .Update "nvalor_colocacion_um", 0
        .Update "nreajuste_colocacion", 0
        .Update "ninteres_colocacion", 0
        .Update "nvalor_presente_colocacion", 0
        .Update "nvalor_proxpre_colocacion", cVentana_Ingreso.SCHK_Capitaliza.Value
        .Update "nvalor_par_colocacion", 0
        .Update "iforma_pago", CDbl(CMB_Fpago_Ini.ItemData(CMB_Fpago_Ini.ListIndex))
        .Update "itipo_tasa", CDbl(cVentana_Ingreso.CMB_Tipo_Tasa.ItemData(cVentana_Ingreso.CMB_Tipo_Tasa.ListIndex))
        .Update "ntasa_spread", CDbl(cVentana_Ingreso.FTB_Spread.Text)
        .Update "iretiro_documento", 0
        .Update "ccodigo_area", CMB_Area.ItemData(CMB_Area.ListIndex)
        .Update "csucursal", CMB_Sucursal.ItemData(CMB_Sucursal.ListIndex)
        .Update "coperador", GLB_Usuario
        .Update "cterminal", Mid(GLB_Terminal_Bac, 1, 10)
        .Update "chora", ""
        .Update "ctipo_mercado", 0
        .Update "cimpreso", ""
        .Update "cpago_hoy_man", IIf(CMB_Tipo_Pago.Text = "HOY", "0", "1")  ' CMB_Tipo_Pago.ItemData(CMB_Tipo_Pago.ListIndex)
        .Update "cobservacion", TXT_Observacion.Text
        .Update "cnumero_pu", ""
        .Update "nkeyid_deskmanager", 0
        .Update "ilibro_deskmanager", 0
        .Update "inumero_anterior", 0
        .Update "cproducto", "LOCAL"
        .Update "iforma_pago_ven", CDbl(Cmb_FPago_Ven.ItemData(Cmb_FPago_Ven.ListIndex))
        .Update "ndecimales", CDbl(cVentana_Ingreso.FTB_Decimales.Text)
        .Update "nperiodo_Gracia", CDbl(cVentana_Ingreso.FTB_Gracia.Text)
        .Update "cValorEstimado1", cVentana_Ingreso.FTB_VALOR_ESTIMADO1.Text
        .Update "cValorEstimado2", cVentana_Ingreso.FTB_VALOR_ESTIMADO2.Text
        .Update "cValorEstimado3", cVentana_Ingreso.FTB_VALOR_ESTIMADO3.Text
        .Update "cValorEstimado4", cVentana_Ingreso.FTB_VALOR_ESTIMADO4.Text
        .Update "cTasa_Efectiva", RetRate
        
        With rstOperacion_Detalle

            For nContador = 2 To cVentana_Detalle.GRD_Flujos.Rows - 1

                .AddNew "inumero_operacion", nNumero_Ope
                .Update "centidad_cartera", CMB_Entidad.ItemData(CMB_Entidad.ListIndex)
                .Update "icodigo_instrumento", CDbl(cVentana_Ingreso.TXT_Familia.Text)
                .Update "inumero_operacion", nNumero_Ope
                .Update "inumero_correlativo", 1
                .Update "dfecha_movimiento", TXT_Fecha_Pago.Text
                .Update "dfecha_vencimientos", cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 2)
                .Update "ncuota_correlativo", nContador - 1
                .Update "ncuota_capital", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 3))
                .Update "ncuota_interes", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 4))
                .Update "ncuota_flujo", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 5))
                .Update "ncuota_saldo", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 6))
                .Update "ctipo_cuota", " "

            Next nContador

        End With


        If Not Grabar_Operacion(rstMensaje, rstOperacion_Cabecera, rstOperacion_Detalle, CDate(GLB_Fecha_Proceso)) Then
            MsgBox FUNC_RETORNA_MENSAJE(rstMensaje), vbCritical
            Call PROC_LOG_AUDITORIA("01", "", Me.Caption & Space(2) & "(error al grabar Operacion LOCAL)" & Space(1) & nNumero_Ope & Space(2) & "Fecha :" & GLB_Fecha_Proceso, "", "")
            Exit Function
        Else
            MsgBox "Operación Número " & nNumero_Ope & " Grabada Exitosamente", vbOKOnly + vbInformation
            Call PROC_LOG_AUDITORIA("01", "", Me.Caption & Space(2) & "(Grabado exito Operacion LOCAL)" & Space(1) & nNumero_Ope & Space(2) & "Fecha :" & GLB_Fecha_Proceso, "", "")
            GLB_Aceptar = True
        End If

        End With

        rstOperacion_Cabecera.Close
        rstOperacion_Detalle.Close
    
FUNC_GRABAR_LOCAL = True

Unload Me

MAL:

End Function

Private Function FUNC_GRABAR_RENOVACION()
On Error GoTo MAL

Dim rstOperacion_Cabecera     As New ADODB.Recordset
Dim rstOperacion_Detalle      As New ADODB.Recordset
Dim rstMensaje                As New ADODB.Recordset
Dim nContador                 As Integer
Dim nNumero_Ope               As Integer
Dim vDatos_Retorno()
Dim nCant_Registros As Integer
Dim RetRate As Double
Dim nValor_Moneda As Double

Set cVentana_Ingreso = FRM_ING_RENOVACIONES
Set cVentana_Detalle = FRM_MAN_FLUJOS_RENOVACION

FUNC_GRABAR_RENOVACION = False
GLB_Aceptar% = False

If FUNC_EXECUTA_COMANDO_SQL("SP_CON_NUMERO_OPERACION") Then
    If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
        nNumero_Ope = Val(vDatos_Retorno(1))
    End If
End If

GLB_Envia = Array()
PROC_AGREGA_PARAMETRO GLB_Envia, nNumero_Ope
 

If FUNC_EXECUTA_COMANDO_SQL("SP_DATOS_TIR_CORFO", GLB_Envia) Then
     If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
        nCant_Registros = Val(vDatos_Retorno(1))
     End If
End If

If Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) = 994 Then
    nValor_Moneda = GLB_DO
ElseIf Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) <> 994 And Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) <> 998 Then
    nValor_Moneda = 1
ElseIf Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) = 998 Then
    nValor_Moneda = GLB_UF
End If

ReDim Values(cVentana_Detalle.GRD_Flujos.Rows - 1) As Double    ' Set up array.

Dim Guess   As Double

Guess = 0.1                                 ' Guess starts at 10 percent.

Values(0) = ((CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO1.Text) _
            + CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO2.Text) _
            + CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO3.Text) _
            + CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO4.Text)) / nValor_Moneda) _
            - CDbl(cVentana_Ingreso.FTB_Monto.Text)   ' Business start-up costs.

  For nContador = 2 To cVentana_Detalle.GRD_Flujos.Rows - 1
    Values(nContador - 1) = CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 5))
  Next nContador
 
' Calculate internal rate.
  
   RetRate = IRR(Values, Guess) * 2
   
        Set rstOperacion_Cabecera = FUNC_RETORNA_RECORDSET_CABECERA
        Set rstOperacion_Detalle = FUNC_RETORNA_RECORDSET_DETALLE


        With rstOperacion_Cabecera

        .AddNew "inumero_operacion", nNumero_Ope
        .Update "centidad_cartera", CMB_Entidad.ItemData(CMB_Entidad.ListIndex)
        .Update "icodigo_instrumento", CDbl(cVentana_Ingreso.TXT_Familia.Text)
        .Update "inumero_operacion", nNumero_Ope
        .Update "inumero_correlativo", 1
        .Update "inumero_acuerdo", CDbl(cVentana_Ingreso.FTB_Acuerdo.Text)
        .Update "cnombre_serie", cVentana_Ingreso.TXT_Instrumento.Text
        .Update "dfecha_emision", cVentana_Ingreso.TXT_Fecha_Otor.Text
        .Update "dfecha_vencimiento", cVentana_Ingreso.TXT_Fecha_Ven.Text
        .Update "dfecha_proximo_cupon", cVentana_Ingreso.TXT_Fecha_Cuota.Text
        .Update "dfecha_anterior_cupon", cVentana_Ingreso.TXT_Fecha_Otor.Text
        .Update "dfecha_colocacion", GLB_Fecha_Proceso
        .Update "irut_emisor", 0
        .Update "cgenerico_emisor", ""
        .Update "irut_cliente", CDbl(Me.TXTRutcli.Text)
        .Update "ccodigo_cliente", Val(TXT_Codigo.Text)
        .Update "inumero_cuotas", CDbl(cVentana_Ingreso.FTB_Cuotas.Text)
        .Update "iperido_amortizacion", CDbl(cVentana_Ingreso.CMB_Periodo.ItemData(cVentana_Ingreso.CMB_Periodo.ListIndex))
        .Update "imoneda_emision", CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))
        .Update "nnominal", CDbl(cVentana_Ingreso.FTB_Monto.Text)
        .Update "nnominal_pesos", 0
        .Update "ntasa_emision", CDbl(cVentana_Ingreso.FTB_Tasa.Text)
        .Update "ibase_emision", CDbl(cVentana_Ingreso.CMB_Base.ItemData(cVentana_Ingreso.CMB_Base.ListIndex))
        .Update "nvalor_emision_pesos", 0
        .Update "nvalor_emision_um", CDbl(cVentana_Ingreso.FTB_Monto.Text)
        .Update "nvalorvtocuptasemi", 0
        .Update "nreajuste_emision", 0
        .Update "ninteres_emision", 0
        .Update "nvalor_presente_emi", 0
        .Update "nvalor_proxpre_emi", 0
        .Update "nvalor_par_emi", 0
        .Update "ntasa_colocacion", 0
        .Update "ibase_colocacion", 0
        .Update "nvalor_colocacion_pesos", 0
        .Update "nvalor_colocacion_um", 0
        .Update "nreajuste_colocacion", 0
        .Update "ninteres_colocacion", 0
        .Update "nvalor_presente_colocacion", 0
        .Update "nvalor_proxpre_colocacion", cVentana_Ingreso.SCHK_Capitaliza.Value
        .Update "nvalor_par_colocacion", 0
        .Update "iforma_pago", CDbl(CMB_Fpago_Ini.ItemData(CMB_Fpago_Ini.ListIndex))
        .Update "itipo_tasa", CDbl(cVentana_Ingreso.CMB_Tipo_Tasa.ItemData(cVentana_Ingreso.CMB_Tipo_Tasa.ListIndex))
        .Update "ntasa_spread", CDbl(cVentana_Ingreso.FTB_Spread.Text)
        .Update "iretiro_documento", 0
        .Update "irut_acreedor", cVentana_Ingreso.FTB_Rut.Text
        .Update "cdigito_acreedor", cVentana_Ingreso.TXT_Digito.Text
        .Update "cnombre_acreedor", cVentana_Ingreso.TXT_Nombre.Text
        .Update "ccodigo_area", CMB_Area.ItemData(CMB_Area.ListIndex)
        .Update "csucursal", CMB_Sucursal.ItemData(CMB_Sucursal.ListIndex)
        .Update "coperador", GLB_Usuario
        .Update "cterminal", Mid(GLB_Terminal_Bac, 1, 10)
        .Update "chora", ""
        .Update "ctipo_mercado", 0
        .Update "cimpreso", ""
        .Update "cpago_hoy_man", IIf(CMB_Tipo_Pago.Text = "HOY", "0", "1") ' CMB_Tipo_Pago.ItemData(CMB_Tipo_Pago.ListIndex)
        .Update "cobservacion", TXT_Observacion.Text
        .Update "cnumero_pu", ""
        .Update "nkeyid_deskmanager", 0
        .Update "ilibro_deskmanager", 0
        .Update "inumero_anterior", CDbl(cVentana_Ingreso.txt_Numero_Operacion.Text)
        .Update "cpantalla", "RENOVACION"
        .Update "iforma_pago_ven", CDbl(Cmb_FPago_Ven.ItemData(Cmb_FPago_Ven.ListIndex))
        .Update "ndecimales", CDbl(cVentana_Ingreso.FTB_Decimales.Text)
        .Update "nperiodo_Gracia", CDbl(cVentana_Ingreso.FTB_Gracia.Text)
        .Update "cValorEstimado1", cVentana_Ingreso.FTB_VALOR_ESTIMADO1.Text
        .Update "cValorEstimado2", cVentana_Ingreso.FTB_VALOR_ESTIMADO2.Text
        .Update "cValorEstimado3", cVentana_Ingreso.FTB_VALOR_ESTIMADO3.Text
        .Update "cValorEstimado4", cVentana_Ingreso.FTB_VALOR_ESTIMADO4.Text
        .Update "cTasa_Efectiva", RetRate
       
        With rstOperacion_Detalle

            For nContador = 2 To cVentana_Detalle.GRD_Flujos.Rows - 1

                .AddNew "inumero_operacion", nNumero_Ope
                .Update "centidad_cartera", CMB_Entidad.ItemData(CMB_Entidad.ListIndex)
                .Update "icodigo_instrumento", CDbl(cVentana_Ingreso.TXT_Familia.Text)
                .Update "inumero_operacion", nNumero_Ope
                .Update "inumero_correlativo", 1
                .Update "dfecha_movimiento", TXT_Fecha_Pago.Text
                .Update "dfecha_vencimientos", cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 2)
                .Update "ncuota_correlativo", nContador - 1
                .Update "ncuota_capital", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 3))
                .Update "ncuota_interes", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 4))
                .Update "ncuota_flujo", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 5))
                .Update "ncuota_saldo", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 6))
                .Update "ctipo_cuota", " "

            Next nContador

        End With


        If Not Grabar_Operacion(rstMensaje, rstOperacion_Cabecera, rstOperacion_Detalle, CDate(GLB_Fecha_Proceso)) Then
            MsgBox FUNC_RETORNA_MENSAJE(rstMensaje), vbCritical
            Call PROC_LOG_AUDITORIA("01", "", Me.Caption & Space(2) & "(error al grabar Operacion RENOVACION)" & Space(1) & nNumero_Ope & Space(2) & "Fecha :" & GLB_Fecha_Proceso, "", "")
            Exit Function
        Else
            MsgBox "Operación Número " & nNumero_Ope & " Grabada Exitosamente", vbOKOnly + vbInformation
            Call PROC_LOG_AUDITORIA("01", "", Me.Caption & Space(2) & "(Grabado exito Operacion RENOVACION)" & Space(1) & nNumero_Ope & Space(2) & "Fecha :" & GLB_Fecha_Proceso, "", "")
            GLB_Aceptar = True
        End If

        End With

        rstOperacion_Cabecera.Close
        rstOperacion_Detalle.Close
    
FUNC_GRABAR_RENOVACION = True

Unload Me

MAL:

End Function

Private Sub TXTRutcli_LostFocus()
If Me.TXTRutcli.Text <> "" Then
    Me.TXT_Digito.Text = FUNC_DEVUELVEDIG(TXTRutcli.Text)
End If
End Sub


Private Function FUNC_GRABAR_EXTRANJERO()
On Error GoTo MAL

Dim rstOperacion_Cabecera     As New ADODB.Recordset
Dim rstOperacion_Detalle      As New ADODB.Recordset
Dim rstMensaje                As New ADODB.Recordset
Dim nContador                 As Integer
Dim nNumero_Ope               As Integer
Dim vDatos_Retorno()
Dim nCant_Registros As Integer
Dim RetRate As Double
Dim nValor_Moneda As Double

Set cVentana_Ingreso = FRM_ING_BANCO_EXT
Set cVentana_Detalle = FRM_MAN_FLUJOS

FUNC_GRABAR_EXTRANJERO = False
GLB_Aceptar% = False

If FUNC_EXECUTA_COMANDO_SQL("SP_CON_NUMERO_OPERACION") Then
    If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
        nNumero_Ope = Val(vDatos_Retorno(1))
    End If
End If

GLB_Envia = Array()
PROC_AGREGA_PARAMETRO GLB_Envia, nNumero_Ope
 

If FUNC_EXECUTA_COMANDO_SQL("SP_DATOS_TIR_CORFO", GLB_Envia) Then
     If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
        nCant_Registros = Val(vDatos_Retorno(1))
     End If
End If

If Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) = 994 Then
    nValor_Moneda = GLB_DO
ElseIf Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) <> 994 And Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) <> 998 Then
    nValor_Moneda = 1
ElseIf Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) = 998 Then
    nValor_Moneda = GLB_UF
End If


ReDim Values(cVentana_Detalle.GRD_Flujos.Rows - 1) As Double    ' Set up array.

Dim Guess   As Double

Guess = 0.1                                 ' Guess starts at 10 percent.

Values(0) = ((CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO1.Text) _
            + CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO2.Text) _
            + CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO3.Text) _
            + CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO4.Text)) / nValor_Moneda) _
            - CDbl(cVentana_Ingreso.FTB_Monto.Text)   ' Business start-up costs.

  For nContador = 2 To cVentana_Detalle.GRD_Flujos.Rows - 1
    Values(nContador - 1) = CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 5))
  Next nContador
 
' Calculate internal rate.
  
   RetRate = IRR(Values, Guess) * 2
   
           
        Set rstOperacion_Cabecera = FUNC_RETORNA_RECORDSET_CABECERA
        Set rstOperacion_Detalle = FUNC_RETORNA_RECORDSET_DETALLE


        With rstOperacion_Cabecera
        .AddNew "inumero_operacion", nNumero_Ope
        .Update "centidad_cartera", CMB_Entidad.ItemData(CMB_Entidad.ListIndex)
        .Update "icodigo_instrumento", CDbl(cVentana_Ingreso.TXT_Familia.Text)
        .Update "inumero_operacion", nNumero_Ope
        .Update "inumero_correlativo", 1
        .Update "cnombre_serie", cVentana_Ingreso.TXT_Instrumento.Text
        .Update "dfecha_emision", cVentana_Ingreso.TXT_Fecha_Otor.Text
        .Update "dfecha_vencimiento", cVentana_Ingreso.TXT_Fecha_Ven.Text
        .Update "dfecha_proximo_cupon", cVentana_Ingreso.TXT_Fecha_Cuota.Text
        .Update "dfecha_anterior_cupon", cVentana_Ingreso.TXT_Fecha_Otor.Text
        .Update "dfecha_colocacion", cVentana_Ingreso.TXT_Fecha_Capitaliza.Text
        .Update "irut_emisor", 0
        .Update "cgenerico_emisor", ""
        .Update "irut_cliente", CDbl(Me.TXTRutcli.Text)
        .Update "ccodigo_cliente", Val(TXT_Codigo.Text)
        .Update "inumero_cuotas", CDbl(cVentana_Ingreso.FTB_Cuotas.Text)
        .Update "iperido_amortizacion", CDbl(cVentana_Ingreso.CMB_Periodo.ItemData(cVentana_Ingreso.CMB_Periodo.ListIndex))
        .Update "imoneda_emision", CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))
        .Update "nnominal", CDbl(cVentana_Ingreso.FTB_Monto.Text)
        .Update "nnominal_pesos", 0
        .Update "ntasa_emision", CDbl(cVentana_Ingreso.FTB_Tasa.Text)
        .Update "ibase_emision", CDbl(cVentana_Ingreso.CMB_Base.ItemData(cVentana_Ingreso.CMB_Base.ListIndex))
        .Update "nvalor_emision_pesos", 0
        .Update "nvalor_emision_um", CDbl(cVentana_Ingreso.FTB_Monto.Text)
        .Update "nvalorvtocuptasemi", 0
        .Update "nreajuste_emision", 0
        .Update "ninteres_emision", 0
        .Update "nvalor_presente_emi", 0
        .Update "nvalor_proxpre_emi", 0
        .Update "nvalor_par_emi", 0
        .Update "ntasa_colocacion", 0
        .Update "ibase_colocacion", 0
        .Update "nvalor_colocacion_pesos", 0
        .Update "nvalor_colocacion_um", 0
        .Update "nreajuste_colocacion", 0
        .Update "ninteres_colocacion", 0
        .Update "nvalor_presente_colocacion", 0
        .Update "nvalor_proxpre_colocacion", cVentana_Ingreso.SCHK_Capitaliza.Value
        .Update "nvalor_par_colocacion", 0
        .Update "iforma_pago", CDbl(CMB_Fpago_Ini.ItemData(CMB_Fpago_Ini.ListIndex))
        .Update "itipo_tasa", CDbl(cVentana_Ingreso.CMB_Tipo_Tasa.ItemData(cVentana_Ingreso.CMB_Tipo_Tasa.ListIndex))
        .Update "ntasa_spread", CDbl(cVentana_Ingreso.FTB_Spread.Text)
        .Update "iretiro_documento", 0
        .Update "ccodigo_area", CMB_Area.ItemData(CMB_Area.ListIndex)
        .Update "csucursal", CMB_Sucursal.ItemData(CMB_Sucursal.ListIndex)
        .Update "coperador", GLB_Usuario
        .Update "cterminal", Mid(GLB_Terminal_Bac, 1, 10)
        .Update "chora", ""
        .Update "ctipo_mercado", 0
        .Update "cimpreso", ""
        .Update "cpago_hoy_man", IIf(CMB_Tipo_Pago.Text = "HOY", "0", "1")  'CMB_Tipo_Pago.ItemData(CMB_Tipo_Pago.ListIndex)
        .Update "cobservacion", TXT_Observacion.Text
        .Update "cnumero_pu", ""
        .Update "nkeyid_deskmanager", 0
        .Update "ilibro_deskmanager", 0
        .Update "inumero_anterior", 0
        .Update "cproducto", "EXTRA"
        .Update "iforma_pago_ven", CDbl(Cmb_FPago_Ven.ItemData(Cmb_FPago_Ven.ListIndex))
        .Update "ndecimales", CDbl(cVentana_Ingreso.FTB_Decimales.Text)
        .Update "nperiodo_Gracia", CDbl(cVentana_Ingreso.FTB_Gracia.Text)
        .Update "cValorEstimado1", FRM_ING_BANCO_EXT.FTB_VALOR_ESTIMADO1.Text
        .Update "cValorEstimado2", FRM_ING_BANCO_EXT.FTB_VALOR_ESTIMADO2.Text
        .Update "cValorEstimado3", FRM_ING_BANCO_EXT.FTB_VALOR_ESTIMADO3.Text
        .Update "cValorEstimado4", FRM_ING_BANCO_EXT.FTB_VALOR_ESTIMADO4.Text
        .Update "cTasa_Efectiva", RetRate
        
        With rstOperacion_Detalle

            For nContador = 2 To cVentana_Detalle.GRD_Flujos.Rows - 1

                .AddNew "inumero_operacion", nNumero_Ope
                .Update "centidad_cartera", CMB_Entidad.ItemData(CMB_Entidad.ListIndex)
                .Update "icodigo_instrumento", CDbl(cVentana_Ingreso.TXT_Familia.Text)
                .Update "inumero_operacion", nNumero_Ope
                .Update "inumero_correlativo", 1
                .Update "dfecha_movimiento", TXT_Fecha_Pago.Text
                .Update "dfecha_vencimientos", cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 2)
                .Update "ncuota_correlativo", nContador - 1
                .Update "ncuota_capital", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 3))
                .Update "ncuota_interes", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 4))
                .Update "ncuota_flujo", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 5))
                .Update "ncuota_saldo", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 6))
                .Update "ctipo_cuota", " "

            Next nContador

        End With


        If Not Grabar_Operacion(rstMensaje, rstOperacion_Cabecera, rstOperacion_Detalle, CDate(GLB_Fecha_Proceso)) Then
            MsgBox FUNC_RETORNA_MENSAJE(rstMensaje), vbCritical
            Call PROC_LOG_AUDITORIA("01", "", Me.Caption & Space(2) & "(error al grabar Operacion EXTRANJERO)" & Space(1) & nNumero_Ope & Space(2) & "Fecha :" & GLB_Fecha_Proceso, "", "")
            Exit Function
        Else
            MsgBox "Operación Número " & nNumero_Ope & " Grabada Exitosamente", vbOKOnly + vbInformation
            Call PROC_LOG_AUDITORIA("01", "", Me.Caption & Space(2) & "(Grabado exito operacion EXTRANJERO)" & Space(1) & nNumero_Ope & Space(2) & "Fecha :" & GLB_Fecha_Proceso, "", "")
            GLB_Aceptar = True
        End If

        End With

        rstOperacion_Cabecera.Close
        rstOperacion_Detalle.Close
    
FUNC_GRABAR_EXTRANJERO = True

Unload Me

MAL:

End Function

Private Function FUNC_GRABAR_PRE_PAGO()
On Error GoTo MAL

Dim rstOperacion_Cabecera     As New ADODB.Recordset
Dim rstOperacion_Detalle      As New ADODB.Recordset
Dim rstMensaje                As New ADODB.Recordset
Dim nContador                 As Integer
Dim nNumero_Ope               As Integer
Dim vDatos_Retorno()
Dim nCant_Registros As Integer
Dim RetRate As Double
Dim nValor_Moneda As Double

Set cVentana_Ingreso = FRM_ING_PRE_PAGO
Set cVentana_Detalle = FRM_MAN_FLUJOS_RENOVACION

FUNC_GRABAR_PRE_PAGO = False
GLB_Aceptar% = False

        nNumero_Ope = CDbl(cVentana_Ingreso.txt_Numero_Operacion.Text)
           
        GLB_Envia = Array()
        PROC_AGREGA_PARAMETRO GLB_Envia, nNumero_Ope
 
        If FUNC_EXECUTA_COMANDO_SQL("SP_DATOS_TIR_CORFO", GLB_Envia) Then
            If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
                nCant_Registros = Val(vDatos_Retorno(1))
            End If
        End If

If Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) = 994 Then
    nValor_Moneda = GLB_DO
ElseIf Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) <> 994 And Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) <> 998 Then
    nValor_Moneda = 1
ElseIf Val(CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))) = 998 Then
    nValor_Moneda = GLB_UF
End If

        ReDim Values(cVentana_Detalle.GRD_Flujos.Rows - 1) As Double    ' Set up array.
        Dim Guess   As Double
    
        Guess = 0.1                                 ' Guess starts at 10 percent.

        Values(0) = ((CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO1.Text) _
                    + CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO2.Text) _
                    + CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO3.Text) _
                    + CDbl(cVentana_Ingreso.FTB_VALOR_ESTIMADO4.Text)) / nValor_Moneda) _
                    - CDbl(cVentana_Ingreso.FTB_Monto.Text)   ' Business start-up costs.

        For nContador = 2 To cVentana_Detalle.GRD_Flujos.Rows - 1
            Values(nContador - 1) = CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 5))
        Next nContador
 
        ' Calculate internal rate.
        RetRate = IRR(Values, Guess) * 2
           
        Set rstOperacion_Cabecera = FUNC_RETORNA_RECORDSET_CABECERA
        Set rstOperacion_Detalle = FUNC_RETORNA_RECORDSET_DETALLE


        With rstOperacion_Cabecera

        .AddNew "inumero_operacion", nNumero_Ope
        .Update "centidad_cartera", CMB_Entidad.ItemData(CMB_Entidad.ListIndex)
        .Update "icodigo_instrumento", CDbl(cVentana_Ingreso.TXT_Familia.Text)
        .Update "inumero_operacion", nNumero_Ope
        .Update "inumero_correlativo", 1
        .Update "inumero_acuerdo", CDbl(cVentana_Ingreso.FTB_Acuerdo.Text)
        .Update "cnombre_serie", cVentana_Ingreso.TXT_Instrumento.Text
        .Update "dfecha_emision", cVentana_Ingreso.TXT_Fecha_Otor.Text
        .Update "dfecha_vencimiento", cVentana_Ingreso.TXT_Fecha_Ven.Text
        .Update "dfecha_proximo_cupon", cVentana_Ingreso.TXT_Fecha_Cuota.Text
        .Update "dfecha_anterior_cupon", cVentana_Ingreso.TXT_Fecha_Otor.Text
        .Update "dfecha_colocacion", GLB_Fecha_Proceso
        .Update "irut_emisor", 0
        .Update "cgenerico_emisor", ""
        .Update "irut_cliente", CDbl(Me.TXTRutcli.Text)
        .Update "ccodigo_cliente", Val(TXT_Codigo.Text)
        .Update "inumero_cuotas", CDbl(cVentana_Ingreso.FTB_Cuotas.Text)
        .Update "iperido_amortizacion", CDbl(cVentana_Ingreso.CMB_Periodo.ItemData(cVentana_Ingreso.CMB_Periodo.ListIndex))
        .Update "imoneda_emision", CDbl(cVentana_Ingreso.CMB_Moneda.ItemData(cVentana_Ingreso.CMB_Moneda.ListIndex))
        .Update "nnominal", CDbl(cVentana_Ingreso.FTB_Monto.Text)
        .Update "nnominal_pesos", 0
        .Update "ntasa_emision", CDbl(cVentana_Ingreso.FTB_Tasa.Text)
        .Update "ibase_emision", CDbl(cVentana_Ingreso.CMB_Base.ItemData(cVentana_Ingreso.CMB_Base.ListIndex))
        .Update "nvalor_emision_pesos", 0
        .Update "nvalor_emision_um", CDbl(cVentana_Ingreso.FTB_Monto.Text)
        .Update "nvalorvtocuptasemi", 0
        .Update "nreajuste_emision", 0
        .Update "ninteres_emision", 0
        .Update "nvalor_presente_emi", 0
        .Update "nvalor_proxpre_emi", 0
        .Update "nvalor_par_emi", 0
        .Update "ntasa_colocacion", 0
        .Update "ibase_colocacion", 0
        .Update "nvalor_colocacion_pesos", 0
        .Update "nvalor_colocacion_um", 0
        .Update "nreajuste_colocacion", 0
        .Update "ninteres_colocacion", 0
        .Update "nvalor_presente_colocacion", 0
        .Update "nvalor_proxpre_colocacion", cVentana_Ingreso.SCHK_Capitaliza.Value
        .Update "nvalor_par_colocacion", 0
        .Update "iforma_pago", CDbl(CMB_Fpago_Ini.ItemData(CMB_Fpago_Ini.ListIndex))
        .Update "itipo_tasa", CDbl(cVentana_Ingreso.CMB_Tipo_Tasa.ItemData(cVentana_Ingreso.CMB_Tipo_Tasa.ListIndex))
        .Update "ntasa_spread", CDbl(cVentana_Ingreso.FTB_Spread.Text)
        .Update "iretiro_documento", 0
        .Update "irut_acreedor", cVentana_Ingreso.FTB_Rut.Text
        .Update "cdigito_acreedor", cVentana_Ingreso.TXT_Digito.Text
        .Update "cnombre_acreedor", cVentana_Ingreso.TXT_Nombre.Text
        .Update "ccodigo_area", CMB_Area.ItemData(CMB_Area.ListIndex)
        .Update "csucursal", CMB_Sucursal.ItemData(CMB_Sucursal.ListIndex)
        .Update "coperador", GLB_Usuario
        .Update "cterminal", Mid(GLB_Terminal_Bac, 1, 10)
        .Update "chora", ""
        .Update "ctipo_mercado", 0
        .Update "cimpreso", ""
        .Update "cpago_hoy_man", IIf(CMB_Tipo_Pago.Text = "HOY", "0", "1")  ' CMB_Tipo_Pago.ItemData(CMB_Tipo_Pago.ListIndex)
        .Update "cobservacion", TXT_Observacion.Text
        .Update "cnumero_pu", ""
        .Update "nkeyid_deskmanager", 0
        .Update "ilibro_deskmanager", 0
        .Update "inumero_anterior", CDbl(cVentana_Ingreso.txt_Numero_Operacion.Text)
        .Update "iforma_pago_ven", CDbl(Cmb_FPago_Ven.ItemData(Cmb_FPago_Ven.ListIndex))
        .Update "ndecimales", CDbl(cVentana_Ingreso.FTB_Decimales.Text)
        .Update "nperiodo_Gracia", CDbl(cVentana_Ingreso.FTB_Gracia.Text)
        .Update "cValorEstimado1", cVentana_Ingreso.FTB_VALOR_ESTIMADO1.Text
        .Update "cValorEstimado2", cVentana_Ingreso.FTB_VALOR_ESTIMADO2.Text
        .Update "cValorEstimado3", cVentana_Ingreso.FTB_VALOR_ESTIMADO3.Text
        .Update "cValorEstimado4", cVentana_Ingreso.FTB_VALOR_ESTIMADO4.Text
        .Update "cTasa_Efectiva", RetRate
        With rstOperacion_Detalle

            For nContador = 2 To cVentana_Detalle.GRD_Flujos.Rows - 1

                .AddNew "inumero_operacion", nNumero_Ope
                .Update "centidad_cartera", CMB_Entidad.ItemData(CMB_Entidad.ListIndex)
                .Update "icodigo_instrumento", CDbl(cVentana_Ingreso.TXT_Familia.Text)
                .Update "inumero_operacion", nNumero_Ope
                .Update "inumero_correlativo", 1
                .Update "dfecha_movimiento", TXT_Fecha_Pago.Text
                .Update "dfecha_vencimientos", cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 2)
                .Update "ncuota_correlativo", nContador - 1
                .Update "ncuota_capital", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 3))
                .Update "ncuota_interes", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 4))
                .Update "ncuota_flujo", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 5))
                .Update "ncuota_saldo", CDbl(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 6))
                .Update "ctipo_cuota", Trim(cVentana_Detalle.GRD_Flujos.TextMatrix(nContador, 7))

            Next nContador

        End With


        If Not Grabar_Operacion(rstMensaje, rstOperacion_Cabecera, rstOperacion_Detalle, CDate(GLB_Fecha_Proceso)) Then
            MsgBox FUNC_RETORNA_MENSAJE(rstMensaje), vbCritical
            Call PROC_LOG_AUDITORIA("01", "", Me.Caption & Space(2) & "(error al grabar Operacion PRE-PAGO)" & Space(1) & nNumero_Ope & Space(2) & "Fecha :" & GLB_Fecha_Proceso, "", "")
            Exit Function
        Else
            MsgBox "Operación Número " & nNumero_Ope & " Grabada Exitosamente", vbOKOnly + vbInformation
            Call PROC_LOG_AUDITORIA("01", "", Me.Caption & Space(2) & "(Grabado exito Operacion PRE-PAGO)" & Space(1) & nNumero_Ope & Space(2) & "Fecha :" & GLB_Fecha_Proceso, "", "")
            GLB_Aceptar = True
        End If

        End With

        rstOperacion_Cabecera.Close
        rstOperacion_Detalle.Close
    
FUNC_GRABAR_PRE_PAGO = True

Unload Me

MAL:

End Function


