VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form BacMntFa 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Familias de Instrumentos"
   ClientHeight    =   7515
   ClientLeft      =   3060
   ClientTop       =   2325
   ClientWidth     =   5310
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmntfa.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form10"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   7515
   ScaleWidth      =   5310
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   27
      Top             =   0
      Width           =   5310
      _ExtentX        =   9366
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   4650
         Top             =   -120
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   10
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntfa.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntfa.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntfa.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntfa.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntfa.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntfa.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntfa.frx":4BB8
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntfa.frx":507E
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntfa.frx":5575
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntfa.frx":596E
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   735
      Left            =   15
      TabIndex        =   28
      Top             =   465
      Width           =   5295
      _Version        =   65536
      _ExtentX        =   9340
      _ExtentY        =   1296
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox txtFamilia 
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
         Left            =   1320
         MaxLength       =   30
         TabIndex        =   1
         Top             =   330
         Width           =   3885
      End
      Begin VB.TextBox txtSerie 
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
         Left            =   105
         MaxLength       =   10
         MouseIcon       =   "Bacmntfa.frx":5D64
         MousePointer    =   99  'Custom
         TabIndex        =   0
         Top             =   330
         Width           =   1095
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
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
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   0
         Left            =   135
         TabIndex        =   30
         Top             =   150
         Width           =   570
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
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
         Index           =   1
         Left            =   1320
         TabIndex        =   29
         Top             =   150
         Width           =   660
      End
   End
   Begin VB.Frame Frame1 
      Height          =   6345
      Left            =   0
      TabIndex        =   31
      Top             =   1170
      Width           =   5295
      Begin VB.ComboBox cmbDispFLI 
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
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   53
         Top             =   5520
         Width           =   1545
      End
      Begin VB.TextBox Txt_Codigo_Producto 
         Alignment       =   1  'Right Justify
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
         Left            =   1800
         MaxLength       =   3
         TabIndex        =   49
         Top             =   4980
         Width           =   1545
      End
      Begin VB.TextBox Txt_Codigo_Inversion 
         Alignment       =   1  'Right Justify
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
         Left            =   90
         MaxLength       =   5
         TabIndex        =   25
         Top             =   4980
         Width           =   1545
      End
      Begin VB.ComboBox cmbTipo 
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
         Left            =   4050
         Style           =   2  'Dropdown List
         TabIndex        =   14
         Top             =   2130
         Width           =   1035
      End
      Begin VB.ComboBox cmbCodificacion 
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
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   23
         Top             =   4410
         Width           =   3165
      End
      Begin VB.ComboBox cmbSecurityType 
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
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   19
         Top             =   3240
         Width           =   2745
      End
      Begin VB.TextBox txtBase 
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
         Left            =   4515
         MaxLength       =   3
         TabIndex        =   11
         Top             =   1515
         Width           =   540
      End
      Begin VB.ComboBox CmbEmision 
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
         Left            =   2895
         Style           =   2  'Dropdown List
         TabIndex        =   22
         Top             =   3825
         Width           =   2265
      End
      Begin VB.ComboBox CmbTipoFecha 
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
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   21
         Top             =   3825
         Width           =   2745
      End
      Begin VB.TextBox txtDesMon 
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
         Left            =   735
         MaxLength       =   30
         TabIndex        =   10
         Top             =   1515
         Width           =   3750
      End
      Begin VB.TextBox txtDesIndTas 
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
         Left            =   735
         MaxLength       =   30
         TabIndex        =   13
         Top             =   2130
         Width           =   3285
      End
      Begin VB.TextBox txtIndTas 
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
         Left            =   90
         MaxLength       =   3
         MouseIcon       =   "Bacmntfa.frx":606E
         MousePointer    =   99  'Custom
         TabIndex        =   12
         Top             =   2130
         Width           =   615
      End
      Begin VB.TextBox txtRutEmi 
         Alignment       =   1  'Right Justify
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
         Left            =   90
         MaxLength       =   10
         MouseIcon       =   "Bacmntfa.frx":6378
         MousePointer    =   99  'Custom
         TabIndex        =   6
         Top             =   945
         Width           =   975
      End
      Begin VB.TextBox txtDigito 
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
         Left            =   1155
         MaxLength       =   1
         TabIndex        =   7
         Top             =   945
         Width           =   240
      End
      Begin VB.TextBox txtCodFam 
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
         Left            =   90
         MaxLength       =   3
         TabIndex        =   2
         Top             =   360
         Width           =   975
      End
      Begin VB.TextBox txtRutina 
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
         Left            =   1230
         MaxLength       =   8
         TabIndex        =   3
         Top             =   360
         Width           =   1065
      End
      Begin VB.TextBox txtMoneda 
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
         Left            =   90
         MaxLength       =   3
         MouseIcon       =   "Bacmntfa.frx":6682
         MousePointer    =   99  'Custom
         TabIndex        =   9
         Top             =   1515
         Width           =   615
      End
      Begin VB.TextBox txtNombreEmisor 
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
         Left            =   1425
         MaxLength       =   30
         TabIndex        =   8
         Top             =   945
         Width           =   3645
      End
      Begin VB.ComboBox CmbLineas 
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
         ItemData        =   "Bacmntfa.frx":698C
         Left            =   3270
         List            =   "Bacmntfa.frx":6996
         Style           =   2  'Dropdown List
         TabIndex        =   24
         Top             =   4410
         Width           =   915
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   450
         Left            =   45
         TabIndex        =   32
         Top             =   5820
         Width           =   5190
         _Version        =   65536
         _ExtentX        =   9155
         _ExtentY        =   794
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin Threed.SSCheck chbEleg 
            Height          =   255
            Left            =   3255
            TabIndex        =   26
            Top             =   120
            Width           =   1260
            _Version        =   65536
            _ExtentX        =   2223
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Elegible"
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
      Begin BACControles.TXTNumero ftbTotalEmitido 
         Height          =   315
         Left            =   2910
         TabIndex        =   20
         Top             =   3240
         Width           =   2190
         _ExtentX        =   3863
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
         Text            =   "0.00"
         Text            =   "0.00"
         Max             =   "9999999999.9999"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
      End
      Begin Threed.SSPanel Panel 
         Height          =   360
         Index           =   3
         Left            =   840
         TabIndex        =   16
         Top             =   2550
         Width           =   4245
         _Version        =   65536
         _ExtentX        =   7488
         _ExtentY        =   635
         _StockProps     =   15
         ForeColor       =   -2147483630
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
         BevelOuter      =   1
         BevelInner      =   2
         Begin Threed.SSOption opbPreDes 
            Height          =   255
            Index           =   1
            Left            =   2100
            TabIndex        =   18
            TabStop         =   0   'False
            Top             =   60
            Width           =   1995
            _Version        =   65536
            _ExtentX        =   3519
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Tabla de Desarrollo"
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
         Begin Threed.SSOption opbPreDes 
            Height          =   255
            Index           =   0
            Left            =   120
            TabIndex        =   17
            Top             =   60
            Width           =   1905
            _Version        =   65536
            _ExtentX        =   3360
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Tabla de Premios"
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
      Begin Threed.SSFrame Frame 
         Height          =   615
         Left            =   2550
         TabIndex        =   33
         Top             =   150
         Width           =   2595
         _Version        =   65536
         _ExtentX        =   4577
         _ExtentY        =   1085
         _StockProps     =   14
         Caption         =   "Nominales"
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
         Begin Threed.SSOption opbNominal 
            Height          =   255
            Index           =   1
            Left            =   1140
            TabIndex        =   5
            Top             =   240
            Width           =   1395
            _Version        =   65536
            _ExtentX        =   2461
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Vencimiento"
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
         Begin Threed.SSOption opbNominal 
            Height          =   255
            Index           =   0
            Left            =   180
            TabIndex        =   4
            Top             =   240
            Width           =   915
            _Version        =   65536
            _ExtentX        =   1614
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Emisión"
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
            Value           =   -1  'True
         End
      End
      Begin Threed.SSCheck chbSerie 
         Height          =   255
         Left            =   90
         TabIndex        =   15
         Top             =   2610
         Width           =   675
         _Version        =   65536
         _ExtentX        =   1191
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "Serie                          "
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
      Begin BACControles.TXTNumero TXTirfEsp 
         Height          =   315
         Left            =   3500
         TabIndex        =   52
         Top             =   4980
         Width           =   1545
         _ExtentX        =   2725
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
         Min             =   "0"
         Max             =   "99"
         Separator       =   -1  'True
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Disponible FLI "
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
         Index           =   19
         Left            =   90
         TabIndex        =   54
         Top             =   5340
         Width           =   1200
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Codigo IRF España"
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
         Index           =   18
         Left            =   3500
         TabIndex        =   51
         Top             =   4770
         Width           =   1500
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Codigo Producto"
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
         Index           =   17
         Left            =   1800
         TabIndex        =   50
         Top             =   4770
         Width           =   1380
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Codigo Inversion"
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
         Index           =   6
         Left            =   90
         TabIndex        =   48
         Top             =   4770
         Width           =   1410
      End
      Begin VB.Line Line1 
         X1              =   1065
         X2              =   1125
         Y1              =   1080
         Y2              =   1080
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Codificación"
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
         Index           =   15
         Left            =   105
         TabIndex        =   47
         Top             =   4185
         Width           =   1005
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Corte Mínimo No Seriado"
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
         Index           =   14
         Left            =   2910
         TabIndex        =   46
         Top             =   2985
         Width           =   2055
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Security Type"
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
         Index           =   13
         Left            =   120
         TabIndex        =   45
         Top             =   2985
         Width           =   1125
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Emisión"
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
         Index           =   12
         Left            =   2895
         TabIndex        =   44
         Top             =   3615
         Width           =   660
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Tipo Fecha"
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
         Index           =   11
         Left            =   90
         TabIndex        =   43
         Top             =   3615
         Width           =   885
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Tipo"
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
         Index           =   10
         Left            =   4035
         TabIndex        =   42
         Top             =   1905
         Width           =   360
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Cód. Familia"
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
         Index           =   4
         Left            =   90
         TabIndex        =   41
         Top             =   120
         Width           =   990
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Rutina"
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
         Index           =   5
         Left            =   1230
         TabIndex        =   40
         Top             =   120
         Width           =   510
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
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
         Index           =   3
         Left            =   1470
         TabIndex        =   39
         Top             =   720
         Width           =   660
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Ind. Tasa Estimada"
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
         Left            =   90
         TabIndex        =   38
         Top             =   1905
         Width           =   1530
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
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
         Left            =   105
         TabIndex        =   37
         Top             =   1290
         Width           =   660
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Base"
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
         Index           =   8
         Left            =   4275
         TabIndex        =   36
         Top             =   1290
         Width           =   405
      End
      Begin VB.Label Label 
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
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   2
         Left            =   105
         TabIndex        =   35
         Top             =   720
         Width           =   900
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Afecto a Lineas"
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
         Index           =   16
         Left            =   3300
         TabIndex        =   34
         Top             =   4185
         Width           =   1275
      End
   End
End
Attribute VB_Name = "BacMntFa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim OptLocal As String
Dim Sql As String
Dim Datos()
Dim xincodigo As Double
Dim xinglosa As String
Dim xinrutemi As Double
Dim xinmonemi As Single
Dim xinbasemi As Single
Dim xinprog As String
Dim xinrefnomi As String
Dim xcodigo_inversion As String
Dim xcodigo_producto As String
Dim xinmdse As String
Dim xinmdpr As String
Dim xinmdtd As String
Dim xintipfec As Single
Dim xintasest As Single
Dim xintipo As String
Dim xinemision As String
Dim xineleg As String
Dim xincontab As String
Dim xSecuritytype As String
Dim xTotalEmitido As Double
Dim emNemo As String
Dim emcodigo As Double
Dim mnCodfox As String
Dim xCodificacion As String
Dim xIrfEsp As String '08/11/2004 Jspp Campo para interfaz a España
Dim xDispFLI As String

Function EliminarFamilia() As Boolean
On Error GoTo ErrEliminar
EliminarFamilia = False

Envia = Array()
AddParam Envia, Val(txtCodFam.Text)

If BAC_SQL_EXECUTE("Sp_Elimina_Familia", Envia) Then
   Do While BAC_SQL_FETCH(Datos())
      If Datos(1) = "NO" Then
         Exit Function
      End If
    Loop
End If

EliminarFamilia = True
Exit Function

ErrEliminar:
   
   MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
   Exit Function
   
End Function

Function GrabarFamilia() As Boolean
GrabarFamilia = False

On Error GoTo ErrGrabar
    Envia = Array()
    AddParam Envia, txtSerie.Text
    AddParam Envia, txtFamilia.Text
    AddParam Envia, txtCodFam.Text
    AddParam Envia, txtRutina.Text
    AddParam Envia, IIf(opbNominal(0).Value, "E", "V")
    AddParam Envia, Val(txtRutEmi.Text)
    AddParam Envia, Val(txtMoneda.Text)
    AddParam Envia, Val(TXTBASE.Text)
    AddParam Envia, Val(txtIndTas.Text)
    AddParam Envia, Trim(right(cmbTipo.Text, Len(cmbTipo.Text) - 5))
    AddParam Envia, IIf(chbSerie.Value, "S", "N")
    AddParam Envia, IIf(opbPreDes(0).Value, "S", "N")
    AddParam Envia, IIf(opbPreDes(1).Value, "S", "N")
    AddParam Envia, right(CmbTipoFecha.Text, 5)
    AddParam Envia, IIf(CmbEmision.Text <> "", Trim(right(CmbEmision.Text, Len(CmbEmision.Text) - 5)), "3")
    AddParam Envia, IIf(chbEleg.Value, "S", "N")
    AddParam Envia, left(CmbLineas.Text, 1)
    AddParam Envia, CDbl(ftbTotalEmitido.Text)
    AddParam Envia, Trim(left(cmbSecurityType.Text, 2))
    AddParam Envia, Trim(left(cmbCodificacion.Text, 3))
    AddParam Envia, Trim(Txt_Codigo_Inversion.Text)
    AddParam Envia, Trim(Txt_Codigo_Producto.Text)
    AddParam Envia, Trim(TXTirfEsp.Text) '08/11/2004 jspp interfaz contabilidad España
    AddParam Envia, Mid$((cmbDispFLI), 1, 1)
     Aux = 100
    If BAC_SQL_EXECUTE("Sp_Graba_Familia", Envia) Then
     Do While BAC_SQL_FETCH(Datos())
         Aux = 500
        If Datos(1) = "NO" Then
          Exit Function
        End If
        If Datos(1) = "CR" Then  '08/11/2004 Jspp Campo para interfaz a España
            MsgBox "No se completo la Grabación de Familia, Codigo IRF ya se encuentra asignado ", vbOKOnly + vbExclamation
            Exit Function
        End If
        
     Loop
    End If

GrabarFamilia = True

Exit Function

ErrGrabar:

    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Function

End Function

Function LeerFamilia(xFamilia As String) As Boolean
LeerFamilia = False
Dim Cont As Single
Cont = 0
Envia = Array()
AddParam Envia, xFamilia
If BAC_SQL_EXECUTE("Sp_Trae_Instrumentos", Envia) Then
  Do While BAC_SQL_FETCH(Datos())
   Cont = Cont + 1
    xincodigo = Datos(3)
    xinglosa = Datos(2)
    xinrutemi = Datos(6)
    xinmonemi = Datos(7)
    xinbasemi = Datos(8)
    xinprog = Datos(4)
    xinrefnomi = Datos(5)
    xinmdse = Datos(11)
    xinmdpr = Datos(12)
    xinmdtd = Datos(13)
    xintipfec = Datos(14)
    xintasest = Datos(9)
    xintipo = Datos(10)
    xinemision = Datos(15)
    xineleg = Datos(16)
    xincontab = Datos(17)
    xSecuritytype = Datos(18)
    xTotalEmitido = Datos(19)
    xCodificacion = Datos(21)
    CmbLineas.Text = IIf(xincontab = "S", "SI", "NO")
    CmbLineas.Enabled = True
    xcodigo_inversion = Datos(23)
    xcodigo_producto = Datos(24)
    xIrfEsp = Datos(25) '08/11/2004 Jspp Campo para interfaz a España
    xDispFLI = IIf(Datos(26) = "S", "SI", "NO")
  Loop
Else
  Exit Function
End If

Envia = Array()
AddParam Envia, xinrutemi
If BAC_SQL_EXECUTE("Sp_Trae_Emisor", Envia) Then
  If BAC_SQL_FETCH(Datos()) Then
     emcodigo = CDbl(Datos(1))
     emNemo = Datos(5)
  End If
Else
  Exit Function
End If

Envia = Array()
AddParam Envia, xinmonemi
If BAC_SQL_EXECUTE("SP_FAMILIA_INS", Envia) Then
  If BAC_SQL_FETCH(Datos()) Then
    mnCodfox = Datos(1)
  End If
Else
  Exit Function
End If

If Cont = 0 Then
  Exit Function
End If
LeerFamilia = True
End Function

Private Function ValidaDatos() As Boolean
Dim Mensaje    As String
Dim nMensaje   As Integer
    
    Mensaje = ""
    nMensaje = 0
    ValidaDatos = True
    
    If Trim(txtFamilia.Text) = "" Then
      If InStr(1, Mensaje, "Debe ingresar") = 0 Then
         Mensaje = "Debe ingresar : " & Mensaje
      End If
            
      Mensaje = Mensaje & Chr(10) & "     - Nombre de familia"
      nMensaje = IIf(nMensaje = 0, 1, nMensaje)
      ValidaDatos = False
    End If
    
    If Val(txtCodFam.Text) = 0 Then
      If InStr(1, Mensaje, "Debe ingresar") = 0 Then
         Mensaje = "Debe ingresar : " & Mensaje
      End If
      
      Mensaje = Mensaje & Chr(10) & "     - Código familia"
      nMensaje = IIf(nMensaje = 0, 2, nMensaje)
      ValidaDatos = False
    End If
    
    If Trim(txtRutina.Text) = "" Then
      If InStr(1, Mensaje, "Debe ingresar") = 0 Then
         Mensaje = "Debe ingresar : " & Mensaje
      End If
      
      Mensaje = Mensaje & Chr(10) & "     - Rutina de valorización"
      nMensaje = IIf(nMensaje = 0, 3, nMensaje)
      ValidaDatos = False
    End If
    
    If Val(TXTBASE.Text) = 0 Then
      If InStr(1, Mensaje, "Debe ingresar") = 0 Then
         Mensaje = "Debe ingresar : " & Mensaje
      End If
      
      Mensaje = Mensaje & Chr(10) & "     - Base de cálculo"
      nMensaje = IIf(nMensaje = 0, 4, nMensaje)
      ValidaDatos = False
    End If
      
    If Trim(cmbTipo.Text) = "" Then
      If InStr(1, Mensaje, "Debe seleccionar") = 0 Then
         Mensaje = Mensaje & Chr(10) & "Debe seleccionar : "
      End If
      
      Mensaje = Mensaje & Chr(10) & "     - Tipo de emisión"
      nMensaje = IIf(nMensaje = 0, 5, nMensaje)
      ValidaDatos = False
    End If
    
    If Trim(CmbTipoFecha) = "" Then
      If InStr(1, Mensaje, "Debe seleccionar") = 0 Then
         Mensaje = Mensaje & Chr(10) & "Debe seleccionar : "
      End If
      
      Mensaje = Mensaje & Chr(10) & "     - Tipo fecha"
      nMensaje = IIf(nMensaje = 0, 6, nMensaje)
      ValidaDatos = False
    End If
    
    If CmbEmision.Text = "" Then
      If InStr(1, Mensaje, "Debe seleccionar") = 0 Then
         Mensaje = Mensaje & Chr(10) & "Debe seleccionar : "
      End If
      
      Mensaje = Mensaje & Chr(10) & "     - Emisión"
      nMensaje = IIf(nMensaje = 0, 7, nMensaje)
      ValidaDatos = False
    End If

    
    If CmbLineas.Text = "" Then
      If InStr(1, Mensaje, "Debe seleccionar") = 0 Then
         Mensaje = Mensaje & Chr(10) & "Debe seleccionar : "
      End If
      
      Mensaje = Mensaje & Chr(10) & "     - Si esta Afecto a Líneas"
      nMensaje = IIf(nMensaje = 0, 8, nMensaje)
      ValidaDatos = False
    End If
    
    If cmbDispFLI.Text = "" Then
      If InStr(1, Mensaje, "Debe seleccionar") = 0 Then
         Mensaje = Mensaje & Chr(10) & "Debe seleccionar : "
      End If
      
      Mensaje = Mensaje & Chr(10) & "     - Si es disponible FLI"
      nMensaje = IIf(nMensaje = 0, 8, nMensaje)
      ValidaDatos = False
    End If
  
    If Not ValidaDatos Then
       MsgBox "Se detectaron los siguientes problemas para la Grabación de la Familia :" & Chr(10) & Chr(10) & Mensaje, vbExclamation
  
       Select Case nMensaje
       
            Case 1: If txtFamilia.Enabled Then txtFamilia.SetFocus
            Case 2: If txtCodFam.Enabled Then txtCodFam.SetFocus
            Case 3: If txtRutina.Enabled Then txtRutina.SetFocus
            Case 4: If TXTBASE.Enabled Then TXTBASE.SetFocus
            Case 5: If cmbTipo.Enabled Then cmbTipo.SetFocus
            Case 6: If CmbTipoFecha.Enabled Then CmbTipoFecha.SetFocus
            Case 7: If CmbEmision.Enabled Then CmbEmision.SetFocus
            Case 8: If CmbLineas.Enabled Then CmbLineas.SetFocus
       
       End Select
  
    End If
  
  
End Function

Private Sub LimpiaControles()

On Error GoTo Label1
     
     PROC_HABILITA_CONTROLES False

     Toolbar1.Buttons(3).Enabled = False
     Toolbar1.Buttons(4).Enabled = True
     
     Screen.MousePointer = 0
     txtSerie.Enabled = True
     txtSerie.Text = ""
     txtFamilia.Text = ""
     txtRutEmi.Text = ""
     txtDigito.Text = ""
     txtNombreEmisor.Text = ""
     txtCodFam.Text = ""
     txtRutina.Text = ""
     opbNominal(0).Value = True
     txtMoneda.Text = ""
     txtDesMon.Text = ""
     TXTBASE.Text = ""
     txtIndTas.Text = ""
     txtDesIndTas.Text = ""
     ftbTotalEmitido.Text = ""
     chbSerie.Value = False
     opbPreDes(0).Value = False
     opbPreDes(1).Value = False
     cmbTipo.ListIndex = -1
     CmbTipoFecha.ListIndex = -1
     CmbEmision.ListIndex = -1
     cmbSecurityType.ListIndex = -1
     chbEleg.Value = False
     CmbLineas.ListIndex = -1
     CmbLineas.Text = "SI"
     cmbDispFLI.ListIndex = -1
     Txt_Codigo_Inversion.Text = ""
     Txt_Codigo_Producto.Text = ""
     TXTirfEsp.Text = "" '08/11/2004 jspp interfaz contabilidad de España
     Me.txtSerie.SetFocus
Exit Sub

Label1:
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Sub
    
End Sub


Private Sub chbSerie_Click(Value As Integer)

    If Value = False Then
        'Deshabilita el panel porque no puede elegir tablas si no marca la serie
        opbPreDes(0).Value = False
        opbPreDes(1).Value = False
        Panel(3).Enabled = False
    Else
        Panel(3).Enabled = True
    End If
        
End Sub

Private Sub cmdEliminar_Click()

On Error GoTo Label1
Screen.MousePointer = 11
If EliminarFamilia Then
   MsgBox "Se eliminó la Familia correctamente", vbOKOnly + vbInformation
   LimpiaControles
Else
   MsgBox "No se completo la eliminación de Familia", vbOKOnly + vbExclamation
End If
Screen.MousePointer = 0
Exit Sub

Label1:
    Screen.MousePointer = 11
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Sub

End Sub

Private Sub cmdGrabar_Click()

On Error GoTo Label1

    If Not ValidaDatos Then
       Exit Sub
    End If
    
   Screen.MousePointer = vbHourglass
   
    If GrabarFamilia Then
      MsgBox "La grabación de Familia fue exitosa", vbOKOnly + vbInformation
      Call LimpiaControles
    Else
      MsgBox "No se completo la grabación de Familia", vbOKOnly + vbExclamation
    End If
    
     Screen.MousePointer = 0
    Exit Sub


Label1:
     Screen.MousePointer = 0
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical

End Sub

Private Sub cmdlimpiar_Click()
Call LimpiaControles
End Sub

Private Sub cmdSalir_Click()

    Unload Me
        
End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer
If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

opcion = 0
   Select Case KeyCode

         Case vbKeyLimpiar
               opcion = 1

         Case vbKeyGrabar
               opcion = 2
         
         Case vbKeyEliminar
               opcion = 3

         Case vbKeyBuscar
               opcion = 4
         
         Case vbKeySalir
               opcion = 5
   End Select

   If opcion <> 0 Then
      If Toolbar1.Buttons(opcion).Enabled Then
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
      End If

   End If

End If

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
   Bac_SendKey vbKeyTab
End If
End Sub

Private Sub Form_Load()
OptLocal = Opt
Me.top = 0
Me.left = 0
On Error GoTo Label1


    Me.Icon = BAC_Parametros.Icon

    'Cargar Tipo
    '----------------------------------
    If Not Llenar_Combos(cmbTipo, MDIN_TIPO) Then  '219
       MsgBox "No existen datos para categoria de 'Tipo de Instrumento'", vbOKOnly + vbExclamation
       Unload Me
       Exit Sub
    End If
    cmbTipo.ListIndex = 0
    'Cargar tipo de fecha
    '----------------------------------
    If Not Llenar_Combos(CmbTipoFecha, MDIN_TIPOFECHA) Then   '220
       MsgBox "No existen datos para categoria de 'Tipos de Fecha'", vbOKOnly + vbExclamation
       Unload Me
       Exit Sub
    End If
    CmbTipoFecha.ListIndex = 0
    'Cargar emision
    '----------------------------------
    If Not Llenar_Combos(CmbEmision, MDIN_EMISION) Then  '221
       MsgBox "No existen datos para categoria de 'Emision'", vbOKOnly + vbExclamation
       Unload Me
       Exit Sub
    End If
    CmbEmision.ListIndex = 0
   'Carga Combo Security Type  +MJ
   '----------------------------------
   cmbSecurityType.AddItem "GO   Papeles BCCH  BR"
   cmbSecurityType.AddItem "MM  DPF,DPR,DPD,Fmutuos "
   cmbSecurityType.AddItem "MO   Letras Hipotecarias"
   cmbSecurityType.AddItem "CO   Bonos de Empresas y Bancarios"
  '-------------------------------------------------------------------------------
   cmbSecurityType.ListIndex = 0
  
    cmbCodificacion.AddItem "FI   " & Space(5) & "FIXED INCOME"
    cmbCodificacion.AddItem "MM " & Space(5) & "MONEY MARKET"
    cmbCodificacion.AddItem "STD" & Space(5) & "SHORT TERM DEBT"
    cmbCodificacion.ListIndex = 0
    
    txtSerie.Enabled = True
    CmbLineas.Enabled = True
    CmbLineas.Text = "SI"
    
    cmbDispFLI.AddItem "SI"
    cmbDispFLI.AddItem "NO"
    cmbDispFLI.ListIndex = 0
    
    PROC_HABILITA_CONTROLES False

    Toolbar1.Buttons(3).Enabled = False
    Panel(3).Enabled = False
    Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
           
    Exit Sub

Label1:
 
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Unload Me
    Exit Sub
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim ak As Integer
Select Case Trim(UCase(Button.Key))
   Case "LIMPIAR"
         Call LimpiaControles

   Case "GRABAR"
      On Error GoTo Label1

    If Not ValidaDatos Then
       Exit Sub
    End If
    
   Screen.MousePointer = vbHourglass
      
    If GrabarFamilia Then
      If Aux = 500 Then
        MsgBox "La grabación de Familia fue exitosa", vbOKOnly + vbInformation
        
         If opbNominal(0).Value = True Then
            ak = 0
         Else
            ak = 1
         End If
         
        Call LogAuditoria("01", OptLocal, Me.Caption, "", "Familia: " & txtSerie.Text & " Código Familia: " & txtCodFam.Text & " Nominales: " & opbNominal(ak).Caption & " Rut Emisor: " & txtRutEmi.Text & " Moneda: " & txtMoneda.Text & " Ind. tasa: " & txtIndTas.Text)
        Call LimpiaControles
      Else
        MsgBox "  No se completo la grabación de Familia..." & Chr(13) & Chr(13) & "- Posiblemente el nombre que le dio a la familia no exista," & Chr(13) & "  pero ya existe una familia con el código ingresado", vbOKOnly + vbExclamation
        Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Familia: " & txtSerie.Text & " Código Familia: " & txtCodFam.Text & " Nominales: " & opbNominal(ak).Caption & " Rut Emisor: " & txtRutEmi.Text & " Moneda: " & txtMoneda.Text & " Ind. tasa: " & txtIndTas.Text, "", "")
      End If
      Else
        MsgBox "  No se completo la grabación de Familia..." & Chr(13) & Chr(13) & "- Posiblemente el nombre que le dio a la familia no exista," & Chr(13) & "  pero ya existe una familia con el código ingresado", vbOKOnly + vbExclamation
        Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Familia: " & txtSerie.Text & " Código Familia: " & txtCodFam.Text & " Nominales: " & opbNominal(ak).Caption & " Rut Emisor: " & txtRutEmi.Text & " Moneda: " & txtMoneda.Text & " Ind. tasa: " & txtIndTas.Text, "", "")
        txtCodFam.SetFocus
      End If
      Screen.MousePointer = 0
    Exit Sub

Label1:
     Screen.MousePointer = 0
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Familia: " & txtSerie.Text & " Código Familia: " & txtCodFam.Text & " Nominales: " & opbNominal(ak).Caption & " Rut Emisor: " & txtRutEmi.Text & " Moneda: " & txtMoneda.Text & " Ind. tasa: " & txtIndTas.Text, "", "")
   
   Case "ELIMINAR"
   
         If opbNominal(0).Value = True Then
            ak = 0
         Else
            ak = 1
         End If

 Dim cc
cc = MsgBox("¿ Seguro de Eliminar Familia " & txtFamilia.Text & " ?", vbQuestion + vbYesNo)

If cc = 6 Then
      On Error GoTo Label11
     Screen.MousePointer = 11
     If EliminarFamilia Then
        MsgBox "Se eliminó la Familia correctamente", vbOKOnly + vbInformation
        Call LogAuditoria("03", OptLocal, Me.Caption, "Familia: " & txtSerie.Text & " Código Familia: " & txtCodFam.Text & " Nominales: " & opbNominal(ak).Caption & " Rut Emisor: " & txtRutEmi.Text & " Moneda: " & txtMoneda.Text & " Ind. tasa: " & txtIndTas.Text, "")
        LimpiaControles
     Else
        MsgBox "No es posible eliminar existen datos relacionados", vbOKOnly + vbExclamation
        Call LogAuditoria("03", OptLocal, Me.Caption & " Error al eliminar- Familia: " & txtSerie.Text & " Código Familia: " & txtCodFam.Text & " Nominales: " & opbNominal(ak).Caption & " Rut Emisor: " & txtRutEmi.Text & " Moneda: " & txtMoneda.Text & " Ind. tasa: " & txtIndTas.Text, "", "")
     End If
     Screen.MousePointer = 0
     On Error GoTo 0
     Exit Sub
     
Label11:
         Screen.MousePointer = 11
         MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
         Call LogAuditoria("03", OptLocal, Me.Caption & " Error al eliminar- Familia: " & txtSerie.Text & " Código Familia: " & txtCodFam.Text & " Nominales: " & opbNominal(ak).Caption & " Rut Emisor: " & txtRutEmi.Text & " Moneda: " & txtMoneda.Text & " Ind. tasa: " & txtIndTas.Text, "", "")
         On Error GoTo 0
         Exit Sub
End If

   Case "BUSCAR"

      txtSerie_LostFocus
         
   Case "SALIR"
         Unload Me
End Select
End Sub

Private Sub txtBase_KeyPress(KeyAscii As Integer)
    
    BacCaracterNumerico KeyAscii
    
End Sub

Private Sub txtCodFam_KeyPress(KeyAscii As Integer)

    BacCaracterNumerico KeyAscii
    
End Sub


Private Sub txtDesIndTas_KeyPress(KeyAscii As Integer)

    BacCaracterNumerico KeyAscii
    
End Sub

Private Sub txtFamilia_KeyPress(KeyAscii As Integer)

    BacToUCase KeyAscii
    
End Sub

Private Sub txtIndTas_Change()

'    txtDesIndTas.Text = ""
    
End Sub

Sub Ind_Tas()
On Error GoTo Label1
   'Ayuda para Monedas
   '===================
   MiTag = "MDMN"
   BacAyuda.Show 1
   
   If giAceptar% = True Then
      txtIndTas.Text = gsCodigo$
      txtDesIndTas.Text = gsDescripcion$
      'txtIndTas.SetFocus
      SendKeys "{TAB}"
   End If
   
   Exit Sub
Label1:
   MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
   Exit Sub
End Sub
Private Sub txtIndTas_DblClick()
   Call Ind_Tas
End Sub
Private Sub txtIndTas_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call Ind_Tas
End Sub

Private Sub txtIndTas_KeyPress(KeyAscii As Integer)

    BacCaracterNumerico KeyAscii
    
End Sub

Private Sub txtIndTas_LostFocus()
If Val(txtIndTas.Text) = 0 Then Exit Sub
Dim Cont As Single
Cont = 0
Envia = Array()
AddParam Envia, CDbl(txtIndTas.Text)

If BAC_SQL_EXECUTE("Sp_Trae_Moneda ", Envia) Then
  Do While BAC_SQL_FETCH(Datos())
    Cont = Cont + 1
    txtDesIndTas.Text = Datos(1)
  Loop
End If
If Cont = 0 Then
  MsgBox "No existe Moneda", vbOKOnly + vbExclamation
  txtIndTas.Text = ""
  txtDesIndTas.Text = ""
  txtIndTas.SetFocus
End If

End Sub

Sub mone()
On Error GoTo Label1
   'Ayuda para Monedas
   '====================
   MiTag = "MDMN"
   BacAyuda.Show 1
   
   If giAceptar% = True Then
      txtMoneda.Text = gsCodigo$
      txtDesMon.Text = gsDescripcion$
      'txtMoneda.SetFocus
      SendKeys "{TAB}"
   End If
   
   Exit Sub
Label1:
   MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
   Exit Sub
End Sub



Private Sub TxtMoneda_DblClick()
    auxilio = 100
   Call mone
End Sub
Private Sub txtMoneda_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call mone
End Sub

Private Sub txtMoneda_KeyPress(KeyAscii As Integer)

    BacCaracterNumerico KeyAscii
    
End Sub

Private Sub txtMoneda_LostFocus()
If txtMoneda.Text = "" Then txtMoneda.Text = 0

   If CDbl(txtMoneda.Text) = 0 Then
      txtDesMon.Text = ""
      TXTBASE.Text = ""
      Exit Sub
   End If


Dim Cont As Single
Cont = 0
Envia = Array()
AddParam Envia, CDbl(txtMoneda.Text)

If BAC_SQL_EXECUTE("Sp_Trae_Moneda ", Envia) Then
  Do While BAC_SQL_FETCH(Datos())
    Cont = Cont + 1
    txtDesMon.Text = Datos(1)
    TXTBASE.Text = IIf(xinbasemi = 0, CDbl(Datos(3)), xinbasemi)
  Loop
End If
If Datos(1) = "0" Then
  MsgBox "No existe Moneda", vbOKOnly + vbExclamation
  txtMoneda.Text = ""
  txtDesMon.Text = ""
'  txtMoneda.SetFocus
End If
End Sub

Private Sub txtRutEmi_Change()

    txtDigito.Text = ""
    txtNombreEmisor.Text = ""
   
End Sub
Sub Rut_Emi()
On Error GoTo Label1
   'Ayuda para Emisores
   '====================
   MiTag = "MDEM"
   BacAyuda.Show 1
   
   If giAceptar% = True Then
      txtRutEmi.Text = gsCodigo$
      txtDigito.Text = gsDigito$
      txtNombreEmisor.Text = gsDescripcion$
         If CDbl(txtRutEmi.Text) = 0 Or Trim$(txtDigito.Text) = "" Then
            Exit Sub
         End If
         SendKeys "{TAB}"
   End If
   
   Exit Sub
Label1:
   MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
   Exit Sub
End Sub

Private Sub txtRutEmi_DblClick()
   txtRutEmi.Tag = txtRutEmi.Text
   txtRutEmi.Text = 0
   Call Rut_Emi
   If txtRutEmi.Text = 0 Then
      txtRutEmi.Text = txtRutEmi.Tag
   End If
End Sub
Private Sub txtRutEmi_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call Rut_Emi
End Sub

Private Sub txtRutEmi_KeyPress(KeyAscii As Integer)

    BacCaracterNumerico KeyAscii
    
End Sub

Private Sub txtRutEmi_LostFocus()
If txtRutEmi.Text = "" Then txtRutEmi.Text = 0
If CDbl(txtRutEmi.Text) = 0 Then Exit Sub
Dim Cont As Single
On Error GoTo Label1
Cont = 0
    Sql = "Sp_Trae_Emisor " & CDbl(txtRutEmi.Text)
    If BAC_SQL_EXECUTE(Sql) Then
      Do While BAC_SQL_FETCH(Datos())
         
        Cont = Cont + 1
        If Datos(1) = "EXISTE" Then
            Cont = 0
            Exit Do
        End If
        txtDigito.Text = Datos(3)
        txtNombreEmisor.Text = Datos(4) 'modificado antes datos(2)
      Loop
    End If
    If Cont = 0 Then
       MsgBox "El Emisor no existe", vbOKOnly + vbExclamation
       txtRutEmi.Text = ""
       txtDigito.Text = ""
       txtNombreEmisor.Text = ""
       If txtRutEmi.Enabled Then
         txtRutEmi.SetFocus
       End If
    End If


    Exit Sub

Label1:
   MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
   Exit Sub

End Sub






Private Sub txtRutina_KeyPress(KeyAscii As Integer)

    BacToUCase KeyAscii
    
End Sub


Sub TSerie()
On Error GoTo Label1
   'Ayuda para Familias
   '===================
   Call LimpiaControles
   MiTag = "MDIN"
   BacAyuda.Show 1
   
   If giAceptar% = True Then
      txtSerie.Text = gsSerie$
      txtCodFam.Text = gsCodigo$
      'txtSerie.SetFocus
      SendKeys "{TAB}"
   End If
   
   If opbNominal(0).Value = True Then
      opbNominal(0).TabStop = True
      opbNominal(1).TabStop = False
   Else
      opbNominal(0).TabStop = False
      opbNominal(1).TabStop = True
   End If
   If opbPreDes(0).Value = True Then
      opbPreDes(0).TabStop = True
      opbPreDes(1).TabStop = False
   Else
      opbPreDes(0).TabStop = False
      opbPreDes(1).TabStop = True
   End If
   Exit Sub
Label1:
   MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
   Exit Sub
End Sub
Private Sub txtSerie_DblClick()
   Call TSerie
End Sub

Private Sub txtSerie_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call TSerie
End Sub

Private Sub txtSerie_KeyPress(KeyAscii As Integer)

    BacToUCase KeyAscii
    
End Sub

Private Sub txtSerie_LostFocus()
Dim Idserie As String
Dim iContador As Integer
On Error GoTo Label1

    Screen.MousePointer = vbHourglass
    
    If txtSerie.Tag = "SERIE" Then
       Screen.MousePointer = 0
       Exit Sub
    End If
    
    If Trim(txtSerie.Text) = "" Then
        Screen.MousePointer = 0
        Exit Sub
    End If
    
    Toolbar1.Buttons(1).Enabled = True
    txtSerie.Enabled = False
    
    If LeerFamilia(txtSerie.Text) Then
        txtCodFam.Text = xincodigo
        txtFamilia.Text = xinglosa
        txtRutEmi.Text = xinrutemi
        Call txtRutEmi_LostFocus
        txtMoneda.Text = xinmonemi
        Call txtMoneda_LostFocus
        Txt_Codigo_Inversion.Text = xcodigo_inversion
        Txt_Codigo_Producto.Text = xcodigo_producto
        TXTirfEsp.Text = xIrfEsp '08/11/2004 jspp interfaz contabilidad españa
        'Base emisión 30, 360, 365
        '--------------------------------------------
        TXTBASE.Text = xinbasemi
        txtRutina.Text = xinprog
        ftbTotalEmitido.Text = xTotalEmitido
        
        'Referencia Nominal E ó V
        '--------------------------------------------
        If xinrefnomi = "E" Then
            opbNominal(0).Value = True
        Else
            opbNominal(1).Value = True
        End If
        chbSerie.Value = IIf(xinmdse = "S", True, False)
        Panel(3).Enabled = IIf(xinmdse = "S", True, False)
        opbPreDes(0).Value = IIf(xinmdpr = "S", True, False)
        opbPreDes(1).Value = IIf(xinmdtd = "S", True, False)
        
        'Tipo de Fecha (Obtiene de MDSE, Obtinene de MDIN)
        '-------------------------------------------------
        CmbTipoFecha.ListIndex = BuscaEnCombo(CmbTipoFecha, Str(xintipfec), "C")
        
        'Tasa Estimada
        '-------------------------------------------------
        txtIndTas.Text = xintasest
        Call txtIndTas_LostFocus
        
        'Tipo IRF ó IRV
        '-------------------------------------------------
        
        For iContador = 0 To cmbTipo.ListCount - 1
            If Trim(right(cmbTipo.List(iContador), 5)) = xintipo Then
               cmbTipo.ListIndex = iContador
                
            End If
        
        Next
        
        cmbDispFLI = xDispFLI
        'cmbTipo.ListIndex = BuscaEnCombo(cmbTipo, xintipo, "G")
        
        'Emisión MAT ó INM
        '-------------------------------------------------
        
        For iContador = 0 To CmbEmision.ListCount - 1
            If Trim(right(CmbEmision.List(iContador), 5)) = xinemision Then
               CmbEmision.ListIndex = iContador
                
            End If
        
        Next
        
        
      ' Carga combo secuity type
      ' ---------------------------------------------------
      ' cmbSecurityType.ListIndex = BuscaEnCombo(cmbSecurityType, xSecuritytype, "G")
        For iContador = 0 To cmbSecurityType.ListCount - 1
            
            If Mid$(cmbSecurityType.List(iContador), 1, 2) = Trim$(xSecuritytype) Then
                cmbSecurityType.ListIndex = iContador
                Exit For
            End If
        Next iContador
        
       'Carga combo Codificación
      ' ---------------------------------------------------
        For iContador = 0 To cmbCodificacion.ListCount - 1
            
            If Trim(Mid$(cmbCodificacion.List(iContador), 1, 3)) = Trim$(xCodificacion) Then
                cmbCodificacion.ListIndex = iContador
                Exit For
            End If
        Next iContador
         
      ' Elegible
      ' -------------------------------------------------
        If xineleg = "S" Then
           chbEleg.Value = True
        Else
           chbEleg.Value = False
        End If
      ' --------------------------------------------------
        Toolbar1.Buttons(2).Enabled = True
        Toolbar1.Buttons(3).Enabled = True
        Toolbar1.Buttons(4).Enabled = False
    Else
        Toolbar1.Buttons(3).Enabled = False
    End If
    Screen.MousePointer = 0
    
    PROC_HABILITA_CONTROLES True
    txtFamilia.SetFocus
    
Exit Sub

Label1:
    MousePointer = 0
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Screen.MousePointer = 0
    Exit Sub

End Sub

Sub PROC_HABILITA_CONTROLES(nEstado As Boolean)

   With Toolbar1
      .Buttons(1).Enabled = True
      .Buttons(2).Enabled = nEstado
   
   End With

   txtSerie.Enabled = Not nEstado
   txtFamilia.Enabled = nEstado
   txtCodFam.Enabled = nEstado
   txtRutina.Enabled = nEstado
   Frame.Enabled = nEstado
   txtRutEmi.Enabled = nEstado
   txtMoneda.Enabled = nEstado
   TXTBASE.Enabled = nEstado
   txtIndTas.Enabled = nEstado
   chbSerie.Enabled = nEstado
   'Panel(3).Enabled = nEstado
   cmbSecurityType.Enabled = nEstado
   ftbTotalEmitido.Enabled = nEstado
   CmbTipoFecha.Enabled = nEstado
   CmbEmision.Enabled = nEstado
   cmbCodificacion.Enabled = nEstado
   CmbLineas.Enabled = nEstado
   chbEleg.Enabled = nEstado
   cmbTipo.Enabled = nEstado
   Txt_Codigo_Inversion.Enabled = nEstado
   Txt_Codigo_Producto.Enabled = nEstado
   TXTirfEsp.Enabled = nEstado '08/11/2004 Jspp Campo para interfaz a España
   
End Sub



