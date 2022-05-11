VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form BacMntSe 
   Appearance      =   0  'Flat
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Series"
   ClientHeight    =   5970
   ClientLeft      =   2115
   ClientTop       =   2040
   ClientWidth     =   8595
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
   Icon            =   "Bacmntse.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5970
   ScaleWidth      =   8595
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5040
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   9
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntse.frx":000C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntse.frx":0EE6
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntse.frx":1DC0
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntse.frx":2C9A
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntse.frx":3B74
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntse.frx":3E8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntse.frx":41A8
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntse.frx":5082
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntse.frx":5F5C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   42
      Top             =   0
      Width           =   8595
      _ExtentX        =   15161
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   9
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Generar"
            Object.ToolTipText     =   "Generar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Imprimir Datos"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Interfaz"
            Object.ToolTipText     =   "Carga Interfaz de Series y Tablas de Desarrollo"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Preliminar"
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   5385
      Left            =   0
      TabIndex        =   31
      Top             =   525
      Width           =   8580
      _Version        =   65536
      _ExtentX        =   15134
      _ExtentY        =   9499
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.CheckBox Chk_TasaVariable 
         Caption         =   "Tasa Variable"
         Height          =   285
         Left            =   3840
         TabIndex        =   27
         Top             =   4965
         Width           =   1680
      End
      Begin Threed.SSFrame SSFrame1 
         Height          =   795
         Left            =   5835
         TabIndex        =   59
         Top             =   4515
         Visible         =   0   'False
         Width           =   2685
         _Version        =   65536
         _ExtentX        =   4736
         _ExtentY        =   1402
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
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
            ItemData        =   "Bacmntse.frx":6E36
            Left            =   1515
            List            =   "Bacmntse.frx":6E40
            Style           =   2  'Dropdown List
            TabIndex        =   30
            Top             =   285
            Width           =   975
         End
         Begin VB.Label Label1 
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
            Height          =   345
            Left            =   120
            TabIndex        =   60
            Top             =   330
            Width           =   1425
         End
      End
      Begin VB.ComboBox cmbTipoLetra 
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
         TabIndex        =   26
         Top             =   4905
         Width           =   3135
      End
      Begin VB.TextBox txtSubSerie 
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
         Left            =   2250
         MaxLength       =   12
         TabIndex        =   24
         Top             =   4200
         Width           =   1575
      End
      Begin VB.ComboBox cmbTipoPeriodo 
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
         Left            =   825
         Style           =   2  'Dropdown List
         TabIndex        =   14
         Top             =   2910
         Width           =   690
      End
      Begin VB.ComboBox cmbTipoAmortizacion 
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
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   23
         Top             =   4200
         Width           =   2055
      End
      Begin VB.CheckBox ChkBonos 
         Caption         =   "BONOS"
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
         Height          =   270
         Left            =   6570
         TabIndex        =   18
         Top             =   2655
         Width           =   1095
      End
      Begin BACControles.TXTNumero itbDia 
         Height          =   315
         Left            =   120
         TabIndex        =   19
         Top             =   3510
         Width           =   495
         _ExtentX        =   873
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
         Max             =   "31"
      End
      Begin BACControles.TXTNumero FltCorte 
         Height          =   315
         Left            =   2805
         TabIndex        =   21
         Top             =   3525
         Width           =   1710
         _ExtentX        =   3016
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
         Max             =   "999999999999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero IntBaseCupones 
         Height          =   315
         Left            =   4545
         TabIndex        =   22
         Top             =   3525
         Width           =   975
         _ExtentX        =   1720
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
         Max             =   "77777"
      End
      Begin BACControles.TXTNumero itbNumDecimales 
         Height          =   315
         Left            =   4545
         TabIndex        =   17
         Top             =   2910
         Width           =   975
         _ExtentX        =   1720
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
         Max             =   "9"
      End
      Begin BACControles.TXTNumero itbNumAmortizacion 
         Height          =   315
         Left            =   2835
         TabIndex        =   16
         Top             =   2910
         Width           =   1695
         _ExtentX        =   2990
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
         Max             =   "999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero itbperiodo 
         Height          =   315
         Left            =   1620
         TabIndex        =   15
         Top             =   2910
         Width           =   975
         _ExtentX        =   1720
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
         Max             =   "99"
      End
      Begin BACControles.TXTNumero itbcupones 
         Height          =   330
         Left            =   90
         TabIndex        =   13
         Top             =   2910
         Width           =   720
         _ExtentX        =   1270
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
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Max             =   "999"
      End
      Begin Threed.SSFrame Frame 
         Height          =   975
         Index           =   0
         Left            =   120
         TabIndex        =   32
         Top             =   15
         Width           =   8400
         _Version        =   65536
         _ExtentX        =   14817
         _ExtentY        =   1720
         _StockProps     =   14
         Caption         =   " Datos Serie "
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
            Left            =   120
            MaxLength       =   8
            MouseIcon       =   "Bacmntse.frx":6E4C
            MousePointer    =   99  'Custom
            TabIndex        =   0
            Top             =   540
            Width           =   1335
         End
         Begin VB.TextBox txtMascara 
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
            Left            =   1485
            MaxLength       =   10
            MouseIcon       =   "Bacmntse.frx":7156
            MousePointer    =   99  'Custom
            TabIndex        =   1
            Top             =   540
            Width           =   1335
         End
         Begin VB.ComboBox Cmb_Base 
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
            Left            =   5880
            Style           =   2  'Dropdown List
            TabIndex        =   4
            Top             =   540
            Width           =   750
         End
         Begin VB.ComboBox Cmb_Moneda 
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
            Left            =   4440
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   540
            Width           =   1170
         End
         Begin BACControles.TXTNumero ftbtera 
            Height          =   315
            Left            =   2850
            TabIndex        =   2
            Top             =   540
            Width           =   1200
            _ExtentX        =   2117
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
            Text            =   "0,0000"
            Text            =   "0,0000"
            Min             =   "-999"
            Max             =   "999"
            CantidadDecimales=   "4"
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            Caption         =   "Tera"
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
            Left            =   3075
            TabIndex        =   37
            Top             =   330
            Width           =   375
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
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
            Index           =   4
            Left            =   6000
            TabIndex        =   36
            Top             =   330
            Width           =   405
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
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
            Index           =   3
            Left            =   4560
            TabIndex        =   35
            Top             =   330
            Width           =   660
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
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
            Left            =   150
            TabIndex        =   34
            Top             =   345
            Width           =   570
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            Caption         =   "Máscara"
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
            Left            =   1500
            TabIndex        =   33
            Top             =   345
            Width           =   690
         End
      End
      Begin Threed.SSFrame Frame 
         Height          =   1665
         Index           =   1
         Left            =   105
         TabIndex        =   38
         Top             =   960
         Width           =   8400
         _Version        =   65536
         _ExtentX        =   14817
         _ExtentY        =   2937
         _StockProps     =   14
         Caption         =   " Datos de Emisión "
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
         Begin VB.TextBox txtRutEmi 
            Alignment       =   1  'Right Justify
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
            Left            =   120
            MaxLength       =   9
            MouseIcon       =   "Bacmntse.frx":7460
            MousePointer    =   99  'Custom
            TabIndex        =   5
            Top             =   540
            Width           =   1095
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
            Left            =   1635
            MaxLength       =   40
            TabIndex        =   7
            Top             =   540
            Width           =   5880
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
            Left            =   1320
            MaxLength       =   1
            TabIndex        =   6
            Top             =   540
            Width           =   285
         End
         Begin BACControles.TXTNumero ftbtotalemitido 
            Height          =   315
            Left            =   5220
            TabIndex        =   12
            Top             =   1170
            Width           =   2295
            _ExtentX        =   4048
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
            Text            =   "0,0000"
            Text            =   "0,0000"
            Min             =   "0"
            Max             =   "999999999999"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero ftbtasaemision 
            Height          =   315
            Left            =   3960
            TabIndex        =   11
            Top             =   1170
            Width           =   1095
            _ExtentX        =   1931
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
            Text            =   "0,0000"
            Text            =   "0,0000"
            Min             =   "-999"
            Max             =   "999"
            CantidadDecimales=   "4"
         End
         Begin BACControles.TXTNumero ftbplazo 
            Height          =   315
            Left            =   2910
            TabIndex        =   10
            Top             =   1170
            Width           =   855
            _ExtentX        =   1508
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
            Text            =   "0,00"
            Text            =   "0,00"
            Min             =   "0"
            Max             =   "9999"
            CantidadDecimales=   "2"
         End
         Begin BACControles.TXTFecha dtbfechavcto 
            Height          =   315
            Left            =   1530
            TabIndex        =   9
            Top             =   1170
            Width           =   1365
            _ExtentX        =   2408
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
            MaxDate         =   402133
            MinDate         =   18264
            Text            =   "09/11/2000"
         End
         Begin BACControles.TXTFecha dtbfechaemision 
            Height          =   315
            Left            =   120
            TabIndex        =   8
            Top             =   1170
            Width           =   1395
            _ExtentX        =   2461
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
            MaxDate         =   402133
            MinDate         =   18264
            Text            =   "09/11/2000"
         End
         Begin VB.Line Line1 
            X1              =   1230
            X2              =   1290
            Y1              =   675
            Y2              =   675
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Plazo (años)"
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
            Left            =   2895
            TabIndex        =   46
            Top             =   930
            Width           =   1005
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Fecha Emisión"
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
            Left            =   120
            TabIndex        =   45
            Top             =   930
            Width           =   1185
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Fecha Vcto."
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
            Left            =   1530
            TabIndex        =   44
            Top             =   930
            Width           =   945
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Tasa Emisión"
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
            Left            =   3960
            TabIndex        =   43
            Top             =   930
            Width           =   1095
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
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
            Index           =   5
            Left            =   135
            TabIndex        =   41
            Top             =   315
            Width           =   900
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
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
            Index           =   6
            Left            =   1665
            TabIndex        =   40
            Top             =   315
            Width           =   660
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Total Emitido"
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
            Left            =   6450
            TabIndex        =   39
            Top             =   930
            Width           =   1065
         End
      End
      Begin Threed.SSFrame Frame 
         Height          =   1500
         Index           =   3
         Left            =   5835
         TabIndex        =   47
         Top             =   3000
         Width           =   2685
         _Version        =   65536
         _ExtentX        =   4736
         _ExtentY        =   2646
         _StockProps     =   14
         Caption         =   "BONOS"
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
         Begin VB.OptionButton bonos_op2 
            Caption         =   "Emisión Variable"
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
            Height          =   450
            Left            =   375
            TabIndex        =   29
            Top             =   885
            Width           =   1770
         End
         Begin VB.OptionButton bonos_op1 
            Caption         =   "Unica Emisión"
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
            Height          =   195
            Left            =   375
            TabIndex        =   28
            Top             =   480
            Width           =   1650
         End
      End
      Begin Threed.SSCheck chFlujosFijos 
         Height          =   255
         Left            =   765
         TabIndex        =   20
         Top             =   3525
         Width           =   1365
         _Version        =   65536
         _ExtentX        =   2408
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "Flujos Fijos"
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
         Enabled         =   0   'False
      End
      Begin BACControles.TXTFecha dtbprimercorte 
         Height          =   315
         Left            =   4080
         TabIndex        =   25
         Top             =   4200
         Width           =   1455
         _ExtentX        =   2566
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
         MaxDate         =   402133
         MinDate         =   18264
         Text            =   "09/11/2000"
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Fecha Primer Corte"
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
         Index           =   23
         Left            =   4080
         TabIndex        =   58
         Top             =   3960
         Width           =   1605
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Tipo de Letra"
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
         Index           =   22
         Left            =   120
         TabIndex        =   57
         Top             =   4680
         Width           =   1095
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Sub Serie"
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
         Left            =   2250
         TabIndex        =   56
         Top             =   3960
         Width           =   795
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Tipo Amortización"
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
         Left            =   120
         TabIndex        =   55
         Top             =   3960
         Width           =   1500
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Corte"
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
         Index           =   21
         Left            =   2865
         TabIndex        =   54
         Top             =   3300
         Width           =   465
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Base Cupones"
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
         Index           =   20
         Left            =   4530
         TabIndex        =   53
         Top             =   3300
         Visible         =   0   'False
         Width           =   1200
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Cupones"
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
         TabIndex        =   52
         Top             =   2670
         Width           =   750
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Día V/C"
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
         TabIndex        =   51
         Top             =   3270
         Width           =   570
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Período V/C"
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
         Left            =   1635
         TabIndex        =   50
         Top             =   2670
         Width           =   975
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Nº Amortizaciones"
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
         Left            =   2895
         TabIndex        =   49
         Top             =   2670
         Width           =   1515
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Nº Decimales"
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
         Left            =   4575
         TabIndex        =   48
         Top             =   2670
         Width           =   1065
      End
   End
End
Attribute VB_Name = "BacMntSe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public xincodigo As Double
Dim Datos()
Dim Sql          As String
Dim xinrutemi    As Double
Dim xinmonemi    As Double
Dim xinbasemi    As Single
Dim xemdv        As String
Dim xemnombre    As String
Dim xinmdtd      As String
Dim xinmdpr      As String
Dim xintipfec    As Single
Dim xsefecemi    As Date
Dim xsefecven    As Date
Dim xsetasemi    As Double
Dim xsetera      As Double
Dim xsecupones   As Single
Dim xsediavcup   As Single
Dim xsepervcup   As Single
Dim xsetipvcup   As String
Dim xseplazo     As Variant
Dim xsetipamor   As Single
Dim xsenumamor   As Single
Dim xseffijos    As String
Dim xsemonemi    As String
Dim xsebascup    As Single
Dim xsedecs      As Single
Dim xseserie     As Single
Dim xsecorte     As Double
Dim xserutemi    As Double
Dim xinserie     As String
Dim xsebasemi    As Integer
Dim xsetotale    As Double
Dim xrefnomi     As String
Dim xtipoletra   As String
Dim xfecprivcto  As Date
Dim CSpreadTasa  As String
Dim cControlAmortiza As String
Dim OptLocal     As String
Dim Antes As String
Dim Despues As String

Function EliminarSerie() As Boolean
On Error GoTo ErrEliminar
EliminarSerie = False

Envia = Array()
AddParam Envia, txtMascara.Text

If BAC_SQL_EXECUTE("Sp_Elimina_Serie", Envia) Then
 Do While BAC_SQL_FETCH(Datos())
   If Datos(1) = "NO" Then
     Exit Function
   End If
 Loop
End If

EliminarSerie = True
Exit Function
ErrEliminar:
MsgBox "Error " & err.Description, vbOKOnly + vbCritical
Exit Function
End Function

Function GrabarSerie() As Boolean
Dim Aux As String
Aux = cmbTipoAmortizacion.Text
GrabarSerie = False

On Error GoTo ErrGrabar

Envia = Array()
AddParam Envia, xincodigo
AddParam Envia, txtMascara.Text
AddParam Envia, txtMascara.Text
AddParam Envia, CDbl(ftbtera.Text)
AddParam Envia, Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)
AddParam Envia, CDbl(Cmb_Base.Text)
AddParam Envia, CDbl(txtRutEmi.Text)
AddParam Envia, Format(dtbfechaemision.Text, "yyyymmdd")
AddParam Envia, Format(dtbfechavcto.Text, "yyyymmdd")
AddParam Envia, CDbl(ftbplazo.Text)
AddParam Envia, CDbl(ftbtasaemision.Text)
AddParam Envia, CDbl(itbcupones.Text)
If cmbTipoPeriodo.Text = "" Then
   AddParam Envia, cmbTipoPeriodo.Text
Else
   AddParam Envia, Trim(left(cmbTipoPeriodo.Text, Len(cmbTipoPeriodo.Text) - 5))
End If
AddParam Envia, CDbl(itbperiodo.Text)
AddParam Envia, CDbl(itbNumAmortizacion.Text)
AddParam Envia, CDbl(itbNumDecimales.Text)
AddParam Envia, CDbl(itbDia.Text)
AddParam Envia, IIf(chFlujosFijos.Value, "S", "N")
AddParam Envia, CDbl(IntBaseCupones.Text)
AddParam Envia, CDbl(FltCorte.Text)
AddParam Envia, IIf(Me.cmbTipoAmortizacion.ListIndex = -1, 1, Val(Trim(right(Me.cmbTipoAmortizacion.Text, 3)))) 'aqui se debe arreglar
AddParam Envia, CDbl(ftbtotalemitido.Text)
If UCase$(Trim$(txtFamilia.Text)) = "LCHR" Then
    If cmbTipoLetra.ListIndex = 0 Then
       AddParam Envia, "F"
    Else
       AddParam Envia, "V"
    End If
Else
       AddParam Envia, " "
End If
AddParam Envia, Format(dtbprimercorte.Text, "yyyymmdd")
AddParam Envia, IIf(Chk_TasaVariable.Value = 1, "S", "N")
AddParam Envia, "N"

Despues = "Serie: " & txtMascara.Text & " Rut Emisor: " & Str(txtRutEmi.Text) & " Monemi: " & Str(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex))
Despues = Despues & " " & " Fecha Emision: " & dtbfechaemision.Text & " Fecha Vcto: " & dtbfechavcto.Text
Despues = Despues & " " & " Tasa Emision: " & Str(CDbl(ftbtasaemision.Text)) & " Periodo:" & Str(xsepervcup) & " N° Amort:" & Str(xsenumamor)
Despues = Despues & " " & " Corte Minimo: " & xsecorte
If BAC_SQL_EXECUTE("Sp_Graba_Serie ", Envia) Then
  Do While BAC_SQL_FETCH(Datos())
    If Datos(1) = "NO" Then
      MsgBox Datos(2), vbInformation
      Exit Function
    End If
   GrabarSerie = True
  Loop
End If

   If UCase$(xinmdtd) = "S" Then
      Toolbar1.Buttons(5).Enabled = True
      Toolbar1.Buttons(5).Key = "TD"
      Toolbar1.Buttons(5).ToolTipText = "Generar Tabla de Desarrollo"
   End If

   If UCase$(xinmdpr) = "S" Then
      Toolbar1.Buttons(5).Enabled = True
      Toolbar1.Buttons(5).Key = "TP"
      Toolbar1.Buttons(5).ToolTipText = "Generar Tabla de Premios"
   End If



Exit Function
ErrGrabar:
  MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
  Exit Function
End Function

Function LeerFamilia(xFamilia As String) As Boolean
Dim Cont As Single

    LeerFamilia = False
    Cont = 0
    Envia = Array()
    AddParam Envia, xFamilia
    
    If BAC_SQL_EXECUTE("Sp_Trae_Instrumentos", Envia) Then
        Do While BAC_SQL_FETCH(Datos())
            Cont = Cont + 1
            xinserie = Datos(1)
            xincodigo = Datos(3)
            xinrutemi = Datos(6)
            xinmonemi = Datos(7)
            xinbasemi = Datos(8)
            xintipfec = Datos(14)
            xinmdpr = Datos(12)
            xinmdtd = Datos(13)
            xrefnomi = Datos(5)

           If UCase$(xinmdtd) = "S" Then
              Toolbar1.Buttons(5).Enabled = True
              Toolbar1.Buttons(5).Key = "TD"
              Toolbar1.Buttons(5).ToolTipText = "Generar Tabla de Desarrollo"
           Else
              Toolbar1.Buttons(5).Enabled = False
           End If
   
           If UCase$(xinmdpr) = "S" Then
              Toolbar1.Buttons(5).Enabled = True
              Toolbar1.Buttons(5).Key = "TP"
              Toolbar1.Buttons(5).ToolTipText = "Generar Tabla de Premios"
           Else
              Toolbar1.Buttons(5).Enabled = False
           End If


            CmbLineas.Text = Datos(22)
        
        
        Loop
    Else
        Exit Function
    End If
    
    If Cont = 0 Then
        Exit Function
    End If
    
    LeerFamilia = True

End Function

Function LeerSeries(xSerie As String) As Boolean
Dim Cont As Single
LeerSeries = False
Cont = 0
Envia = Array()
AddParam Envia, txtMascara

   If BAC_SQL_EXECUTE("Sp_Trae_Serie", Envia) Then
   Do While BAC_SQL_FETCH(Datos())
    Cont = Cont + 1
        xsebasemi = Val(Datos(6))
        xserutemi = Datos(7)
        xsemonemi = Datos(5)
        xsefecemi = IIf(IsDate(Datos(8)), Datos(8), "01/01/1900")
        xsefecven = IIf(IsDate(Datos(9)), Datos(9), "01/01/1900")
        xsetasemi = Datos(11)
        xsetera = Datos(4)
        xsecupones = Val(Datos(12))
        xsediavcup = Val(Datos(17))
        xsepervcup = Val(Datos(14))
        xsetipvcup = Datos(13)
        xseplazo = CDbl(Datos(10))
        xsetipamor = Val(Datos(21))
        xsenumamor = Val(Datos(15))
        xseffijos = Datos(18)
        xsebascup = Val(Datos(19))
        xsedecs = Val(Datos(16))
        xsecorte = Val(Datos(20))
        xsetotale = Datos(22)
        xtipoletra = Datos(23)
        xfecprivcto = IIf(IsDate(Datos(24)), Datos(24), "01/01/1900")
        CSpreadTasa = Datos(25)
        cControlAmortiza = IIf(Datos(26) = "S", 1, 0)
        Toolbar1.Buttons(3).Enabled = True
        Antes = " Serie: " & txtMascara & " Rut Emisor: " & xserutemi & " Monemi: " & xsemonemi
        Antes = Antes & " " & " Fecha Emision: " & xsefecemi & " Fecha Vcto: " & xsefecven
        Antes = Antes & " " & " Tasa Emision: " & xsetasemi & " Periodo:" & Str(xsepervcup) & " N° Amort:" & Str(xsenumamor)
        Antes = Antes & " " & " Corte Minimo: " & xsecorte
        
     Loop
End If
If Cont = 0 Then
  Exit Function
End If
LeerSeries = True
End Function

Private Sub Limpiar()
On Error GoTo Label1

    txtFamilia.Tag = "FAMILIA"
    Call LimpiarControles
    Antes = ""
    Despues = ""
    ftbtera.TabStop = False
    txtFamilia.Enabled = True
    txtMascara.Enabled = True
    txtFamilia.Tag = ""
    Toolbar1.Buttons(1).Enabled = True
    Toolbar1.Buttons(3).Enabled = False
    Toolbar1.Buttons(4).Enabled = True

    Toolbar1.Buttons(5).Enabled = False

    Toolbar1.Buttons(1).Enabled = False
    CmbLineas.Enabled = False
    CmbLineas.ListIndex = -1
   
    ftbtotalemitido.Text = 0
   
    ChkBonos.Value = 0
    ChkBonos.Enabled = False
    Frame(3).Enabled = False
    bonos_op1.Enabled = False
    bonos_op2.Enabled = False
    txtFamilia.SetFocus
    Chk_TasaVariable.Value = 0
    
    PROC_HABILITA_CONTROLES False
    
    Exit Sub

Label1:
    MousePointer = 0
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Sub

End Sub

Private Sub LimpiarControles()

On Error GoTo Label1

    txtFamilia.Text = ""
    txtMascara.Text = ""
    ftbtera.Text = ""
    Cmb_Moneda.ListIndex = 0
   
    txtRutEmi.Text = ""
    txtDigito.Text = ""
    txtNombreEmisor.Text = ""
    dtbfechaemision.Text = Date
    dtbfechavcto.Text = Date
    ftbplazo.Text = ""
    ftbtasaemision.Text = ""
    
    itbcupones.Text = ""
    itbperiodo.Text = ""
    cmbTipoPeriodo.ListIndex = -1
    itbDia.Text = ""
    cmbTipoAmortizacion.ListIndex = -1
    cmbTipoLetra.ListIndex = -1
    itbNumAmortizacion.Text = ""
    chFlujosFijos.Value = False
    IntBaseCupones.Text = 0
    itbNumDecimales.Text = ""
    txtSubSerie.Text = ""
    FltCorte.Text = 0
    bonos_op1.Value = False
    bonos_op2.Value = False
    dtbprimercorte.Text = Date
        
Exit Sub

Label1:

End Sub


Private Function ValidaDatos() As Integer

On Error GoTo Label1

    ValidaDatos = False
    
        
    ValidaDatos = True

    Exit Function

Label1:
    

End Function




Private Sub ChkBonos_Click()

   If ChkBonos.Value = 1 Then
      Frame(3).Enabled = True
      bonos_op1.Enabled = True
      bonos_op2.Enabled = True
   Else
      Frame(3).Enabled = False
      bonos_op1.Value = False
      bonos_op1.Enabled = False
      bonos_op2.Value = False
      bonos_op2.Enabled = False
   End If
  
End Sub

Private Sub Cmb_Moneda_Click()

Select Case funcBaseMoneda(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex))
       Case 30:   Cmb_Base.ListIndex = 0
       Case 360:  Cmb_Base.ListIndex = 1
       Case Else: Cmb_Base.ListIndex = 2
End Select

End Sub

Private Sub cmdlimpiar_Click()
    Call Limpiar
   ActivaControles False
End Sub

Private Sub cmbTipoPeriodo_Change()
cmbTipoPeriodo.Text = xsetipvcup
End Sub

Sub cmdTabDes()
mascaraux = txtMascara.Text
On Error GoTo Label1
Dim Frase As String
   
    If ValidaDatos() = False Then
       Exit Sub
    End If
     
    Me.Tag = "TD"
       
    'Parámetros para el form de Desarrollo, para no usar una variable global
    Frase = ""
    Frase = Frase + Trim$(CStr(txtSubSerie.Text)) + "@"         'Subserie antes era(Máscara)
    Frase = Frase + Trim$(CStr(CDbl(ftbtera.Text))) + "@"        'interes
    Frase = Frase + Trim$(CStr(itbcupones.Text)) + "@"          'cupones
    Frase = Frase + Trim$(CStr(itbNumAmortizacion.Text)) + "@"  'Amortización
    Frase = Frase + Trim$(CStr(itbperiodo.Text)) + "@"          'periodo
    Frase = Frase + Trim$(CStr(itbNumDecimales.Text)) + "@"     'Num Decimales
    
    If UCase$(Trim$(txtFamilia.Text)) = "BONOS" Then
        If bonos_op1.Value = True Then
            Frase = Frase + Format(Trim$(dtbfechaemision.Text), "dd/mm/yyyy")            'Fecha Emisión
        End If
    Else
        If xintipfec = 1 Then
            Frase = Frase + Format(Trim$(dtbfechaemision.Text), "dd/mm/yyyy")            'Fecha Emisión
        End If
    End If
    
    If Me.Chk_TasaVariable.Value = 1 Then
      BacMnSe1.cTasaVariable = "S"
    Else
      BacMnSe1.cTasaVariable = "N"
    End If
    
    BacMnSe1.proOrigense = "SE"
    BacMnSe1.Tag = Frase
    BacMnSe1.Show 1
    Exit Sub

Label1:
   If err.Number <> 364 Then
    MsgBox "Error : " & err.Description, vbOKOnly + vbExclamation
   End If
    Exit Sub

End Sub

Private Sub ActivaControles(Valor As Boolean)
    txtFamilia.Enabled = Not Valor
    txtMascara.Enabled = Not Valor
    ftbtera.Enabled = Valor
    Cmb_Moneda.Enabled = Valor
    Cmb_Base.Enabled = Valor
    txtRutEmi.Enabled = Valor
    dtbfechaemision.Enabled = Valor
    dtbfechavcto.Enabled = Valor
    ftbplazo.Enabled = Valor
    ftbtasaemision.Enabled = Valor
    ftbtotalemitido.Enabled = Valor
    itbcupones.Enabled = Valor
    cmbTipoPeriodo.Enabled = Valor
    itbperiodo.Enabled = Valor
    itbNumAmortizacion.Enabled = Valor
    itbNumDecimales.Enabled = Valor
    itbDia.Enabled = Valor
    chFlujosFijos.Enabled = Valor
    FltCorte.Enabled = Valor
    IntBaseCupones.Enabled = Valor
    cmbTipoAmortizacion.Enabled = Valor
    cmbTipoLetra.Enabled = Valor
    txtSubSerie.Enabled = Valor
    dtbprimercorte.Enabled = Valor
      
    PROC_HABILITA_CONTROLES Valor


End Sub




Private Sub CalculaFechas()

On Error GoTo Label1

Dim sString        As String
Dim CantidadAnn    As Variant
Dim FechaEmision   As String
Dim FechaVen       As String

Dim CantidadMeses As Integer
Dim Coeficiente As Variant
    
    
    On Error GoTo Label1
    
    If CDbl(itbperiodo.Text) = 0 Or CDbl(itbDia.Text) = 0 Then
       CantidadAnn = 0
       Exit Sub
    Else
       If ftbplazo.Tag = "TRUE" Then
          CantidadAnn = CDbl(ftbplazo.Text)
          ftbplazo.Tag = ""
       Else
         
          If (Int(12 / CDbl(itbperiodo.Text))) = 0 Then
          
            Exit Sub
          
          End If
          
         
          CantidadAnn = CDbl(itbcupones.Text) / (Int(12 / CDbl(itbperiodo.Text)))
       End If
    End If
     
         
    If Trim$(dtbfechaemision.Text) <> "" Then
        FechaEmision = Format(Format(CDbl(itbDia.Text), "00") + "/" + Format(DatePart("m", dtbfechaemision.Text), "00") + "/" + Format(DatePart("yyyy", dtbfechaemision.Text), "0000"), gsc_FechaDMA)
        FechaVen = DateAdd("yyyy", CantidadAnn, FechaEmision)
        Coeficiente = CantidadAnn - Int(CantidadAnn)
        'EB-20041001
        If Coeficiente > 0 Then
            FechaVen = DateAdd("m", (12 * Coeficiente), CDate(FechaVen))
        End If
    End If
    
    If Trim$(dtbfechaemision.Text) = "" And Trim$(dtbfechavcto.Text) <> "" Then
        FechaEmision = Format(Format$(DatePart("d", dtbfechavcto.Text), "00") + "/" + Format$(DatePart("m", dtbfechavcto.Text), "00") + "/" + Format$(DatePart("yyyy", dtbfechavcto.Text) - CDbl(ftbplazo.Text), "0000"), gsc_FechaDMA)
        FechaVen = DateAdd("yyyy", CantidadAnn, FechaEmision)
        'EB-20041001
        Coeficiente = CantidadAnn - Int(CantidadAnn)
        If Coeficiente > 0 Then
            FechaVen = DateAdd("m", (12 * Coeficiente), CDate(FechaVen))
        End If
    End If
    
    ftbplazo.Text = CantidadAnn
    dtbfechaemision.Text = FechaEmision
    dtbfechavcto.Text = FechaVen

    Exit Sub

Label1:
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Sub
    
    
End Sub

Sub cmdTabPre()
mascarita = txtMascara.Text
On Error GoTo Label1

Dim Frase As String
    
    Me.Tag = "TP"
    
    'Parámetros para el form de Premios, para no usar una variable global
    Frase = ""
    Frase = Frase + Trim$(CStr(xincodigo)) + "@"      'codigo
    Frase = Frase + Trim$(CStr(txtSubSerie.Text)) + "@"         'SubSerie antes era(mascara)
    Frase = Frase + Trim$(CStr(itbcupones.Text)) + "@"          'cupones
    Frase = Frase + Trim$(CStr(itbNumDecimales.Text)) + "@"     'Num Decimales
    Frase = Frase + Trim$(CStr(txtMascara.Text))                'Mascara

    BacMnSe2.Tag = Frase

    BacMnSe2.Show 1

    BacControlWindows 60

    Exit Sub

Label1:
    

End Sub

Private Sub dtbFechaEmision_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        If CDate(dtbfechavcto.Text) > CDate(dtbfechaemision.Text) Then
            ftbplazo.Text = (CLng(CDate(dtbfechavcto.Text)) - CLng(CDate(dtbfechaemision.Text))) / 365
        End If
        Call CalculaFechas
        If UCase$(Trim$(txtFamilia.Text)) = "BONOS" Then
            If dtbfechaemision.Text = "" Then
                bonos_op1.Value = False
                bonos_op2.Value = True
            Else
                bonos_op1.Value = True
                bonos_op2.Value = False
            End If
        End If
    End If

End Sub


Private Sub dtbFechaVcto_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        If CDate(dtbfechavcto.Text) > CDate(dtbfechaemision.Text) Then
            ftbplazo.Text = (CLng(CDate(dtbfechavcto.Text)) - CLng(CDate(dtbfechaemision.Text))) / 365
        End If
        Call CalculaFechas
        If UCase$(Trim$(txtFamilia.Text)) = "BONOS" Then
           If dtbfechavcto.Text = "" Then
                bonos_op1.Value = False
                bonos_op2.Value = True
            Else
                bonos_op1.Value = True
                bonos_op2.Value = False
            End If
        End If
    End If

End Sub



Private Sub FltCorte_KeyPress(KeyAscii As Integer)

    If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
        KeyAscii = Asc(gsc_PuntoDecim)
    End If

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
         
         Case vbKeyCalcular
               opcion = 5
               
         Case vbKeyImprimir
               opcion = 6
               
         Case vbKeyVistaPrevia
               opcion = 7

         Case vbKeySalir
               opcion = 8
               
   End Select

   If opcion <> 0 Then
      If Toolbar1.Buttons(opcion).Enabled Then
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
      End If
   End If

End If

End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub ftbPlazo_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        ftbplazo.Tag = "TRUE"
        Call CalculaFechas
    End If

End Sub


Private Sub ftbplazo_LostFocus()

    ftbPlazo_KeyPress 13

End Sub

Private Sub ftbTasaEmision_KeyPress(KeyAscii As Integer)

    If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
        KeyAscii = Asc(gsc_PuntoDecim)
    End If

    If KeyAscii = 13 Then
        Call CalculaFechas
    End If

End Sub


Private Sub ftbTera_KeyPress(KeyAscii As Integer)
    If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
        KeyAscii = Asc(gsc_PuntoDecim)
    End If
End Sub


Private Sub ftbtera_LostFocus()
  'ftbtera.TabStop = True
End Sub


Private Sub itbCupones_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        Call CalculaFechas
    End If

End Sub


Private Sub itbDia_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        Call CalculaFechas
    End If

End Sub


Private Sub itbPeriodo_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        Call CalculaFechas
        dtbprimercorte.Text = Format$(DateAdd("m", Int(itbperiodo.Text), dtbfechaemision.Text), "dd/mm/yyyy")
    End If
    
End Sub



Private Sub cmdEliminar_Click()
On Error GoTo Label1

Dim nFlag As Integer
Screen.MousePointer = 11
If EliminarSerie Then
   MsgBox "La eliminación se realizó con exito", vbOKOnly + vbInformation
   Call Limpiar
Else
   MsgBox "No se completo la elimininación", vbOKOnly + vbExclamation
End If
Screen.MousePointer = 0
Exit Sub

Label1:
  Screen.MousePointer = 11
  MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
  Exit Sub
End Sub


Private Sub CmdGrabar_Click()

On Error GoTo Label1

     If ValidaDatos() = False Then
        Exit Sub
     End If
     
     Screen.MousePointer = 11
     
     If GrabarSerie Then
        MsgBox "Serie Grabada Correctamente.", vbOKOnly + vbInformation
        Call Limpiar
     Else
        MsgBox "No se completo la grabación de Serie.", vbOKOnly + vbExclamation
     End If
     
   Screen.MousePointer = 0
     
    Exit Sub

Label1:
      MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
      Exit Sub
      
End Sub


Private Sub cmdSalir_Click()
        Unload Me
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

Me.Icon = BAC_Parametros.Icon

Cmb_Base.AddItem "30"
Cmb_Base.AddItem "360"
Cmb_Base.AddItem "365"

cmbTipoLetra.AddItem "LETRAS DE FINES GENERALES"
cmbTipoLetra.AddItem "LETRAS PARA LA VIVIENDA"

ChkBonos.Enabled = False
If ChkBonos.Value = 0 Then
    Frame(3).Enabled = False
    bonos_op1.Enabled = False
    bonos_op2.Enabled = False
End If
On Error GoTo Label1
ActivaControles False
    'Cargar Tipo Amortización
    '-------------------------------------------
    If Not Llenar_Combos(cmbTipoAmortizacion, MDSE_TIPOAMORTIZACION) Then  '212
       MsgBox "No existen tipos de amortización", vbOKOnly + vbExclamation
       Unload Me
    End If
      
    If Not Llenar_Combos(cmbTipoPeriodo, MDSE_TIPOPERIODO) Then    ' 216
       MsgBox "No existen tipos de periodo", vbOKOnly + vbCritical
       Unload Me
       Exit Sub
    End If
    
    If funcFindMonSerie(Cmb_Moneda, Cmb_Base, "") Then
       Cmb_Moneda.ListIndex = 0
    End If


    txtFamilia.Enabled = True
    txtMascara.Enabled = True
    Toolbar1.Buttons(1).Enabled = True

    Toolbar1.Buttons(5).Enabled = False
    Toolbar1.Buttons(3).Enabled = False

    Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
       
Exit Sub

Label1:
       MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
       Unload Me
       Exit Sub
End Sub


Private Sub itbperiodo_LostFocus()
dtbprimercorte.Text = Format$(DateAdd("m", Int(itbperiodo.Text), dtbfechaemision.Text), "dd/mm/yyyy")
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Trim(UCase(Button.Key))
Case "INTERFAZ"
    InterfacesTd.Show vbModal

Case "LIMPIAR"
   Call Limpiar
   ActivaControles False

Case "GRABAR"
      On Error GoTo Label30

     If ValidaDatos() = False Then
        Exit Sub
     End If
     
     Screen.MousePointer = 11
     
     If GrabarSerie Then
        MsgBox "Serie Grabada Correctamente.", vbOKOnly + vbInformation
        LogAuditoria "01", OptLocal, Me.Caption, Antes, Despues
     Else
     '   MsgBox "No se completo la grabación de Serie.", vbOKOnly + vbExclamation
        LogAuditoria "01", OptLocal, Me.Caption & " No se pudo completar la grabación", "", ""
     End If
     
   Screen.MousePointer = 0
   Call Limpiar
   ActivaControles False
  
    Exit Sub

Label30:
      MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
      LogAuditoria "01", OptLocal, Me.Caption & " Error al grabar- " & "Familia: " & txtFamilia.Text & " Mascara: " & txtMascara.Text & " Tera: " & ftbtera.Text & " Moneda: " & Cmb_Moneda.Text & " RUT: " & txtRutEmi.Text & "-" & txtDigito.Text & " Emision: " & dtbfechaemision.Text & " Vencimiento: " & dtbfechavcto.Text & " Plazo: " & ftbplazo.Text & " Amortización: " & cmbTipoAmortizacion.Text & " Primer Corte: " & dtbprimercorte.Text, "", ""
      Exit Sub

Case "ELIMINAR"
        Dim mm
        mm = MsgBox("¿Seguro de Eliminar?", vbQuestion + vbYesNo)
        If mm = 6 Then
           On Error GoTo Label31
        
        Dim nFlag As Integer
        Screen.MousePointer = 11
        If EliminarSerie Then
           MsgBox "La eliminación se realizó con exito", vbOKOnly + vbInformation
           LogAuditoria "03", OptLocal, Me.Caption, "Familia: " & txtFamilia.Text & " Mascara: " & txtMascara.Text & " Tera: " & ftbtera.Text & " Moneda: " & Cmb_Moneda.Text & " RUT: " & txtRutEmi.Text & "-" & txtDigito.Text & " Emision: " & dtbfechaemision.Text & " Vencimiento: " & dtbfechavcto.Text & " Plazo: " & ftbplazo.Text & " Amortización: " & cmbTipoAmortizacion.Text & " Primer Corte: " & dtbprimercorte.Text, ""
           Call Limpiar
        Else
           MsgBox "No es posible Eliminar Existen Datos Relacionados", vbOKOnly + vbExclamation
           LogAuditoria "03", OptLocal, Me.Caption & " Error al eliminar- Familia: " & txtFamilia.Text & " Mascara: " & txtMascara.Text & " Tera: " & ftbtera.Text & " Moneda: " & Cmb_Moneda.Text & " RUT: " & txtRutEmi.Text & "-" & txtDigito.Text & " Emision: " & dtbfechaemision.Text & " Vencimiento: " & dtbfechavcto.Text & " Plazo: " & ftbplazo.Text & " Amortización: " & cmbTipoAmortizacion.Text & " Primer Corte: " & dtbprimercorte.Text, "", ""
        End If
        Screen.MousePointer = 0
        Exit Sub
        
Label31:
          Screen.MousePointer = 11
          MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
          LogAuditoria "03", OptLocal, Me.Caption & " Error al eliminar- Familia: " & txtFamilia.Text & " Mascara: " & txtMascara.Text & " Tera: " & ftbtera.Text & " Moneda: " & Cmb_Moneda.Text & " RUT: " & txtRutEmi.Text & "-" & txtDigito.Text & " Emision: " & dtbfechaemision.Text & " Vencimiento: " & dtbfechavcto.Text & " Plazo: " & ftbplazo.Text & " Amortización: " & cmbTipoAmortizacion.Text & " Primer Corte: " & dtbprimercorte.Text, "", ""
          Exit Sub
        End If

Case "BUSCAR"
      txtMascara_LostFocus
Case "TD"
      
      If CDbl(itbcupones.Text) = 0 Then
         MsgBox "Para generar la Tabla de Desarrollo es debe ingresar La cantidad de Cupones", vbExclamation
         itbcupones.SetFocus
         Exit Sub
      ElseIf CDbl(ftbtera.Text) = 0 Then
         MsgBox "Para generar la Tabla de Desarrollo es debe ingresar la Tera", vbExclamation
         ftbtera.SetFocus
         Exit Sub
      ElseIf CDbl(ftbtasaemision.Text) = 0 Then
         MsgBox "Para generar la Tabla de Desarrollo es debe ingresar la Tasa de Emisión", vbExclamation
         ftbtasaemision.SetFocus
         Exit Sub
      ElseIf CDbl(itbNumAmortizacion.Text) = 0 Then
         MsgBox "Para generar la Tabla de Desarrollo es debe ingresar el numero de amortizaciones", vbExclamation
         itbNumAmortizacion.SetFocus
         Exit Sub
      ElseIf CDbl(itbperiodo.Text) = 0 Then
         MsgBox "Para generar la Tabla de Desarrollo es debe ingresar el periodo", vbExclamation
         itbperiodo.SetFocus
         Exit Sub
      End If
      
      cmdTabDes

Case "TP"
      cmdTabPre
      
Case "IMPRIMIR", "PRELIMINAR"
       If Trim(txtMascara.Text) <> "" Then
        Call limpiar_cristal
        Screen.MousePointer = vbHourglass
        BAC_Parametros.BacParam.Destination = crptToWindow
        BAC_Parametros.BacParam.ReportFileName = gsRPT_Path & "tbdes.rpt"
        Call PROC_ESTABLECE_UBICACION(BAC_Parametros.BacParam.RetrieveDataFiles, BAC_Parametros.BacParam)
        BAC_Parametros.BacParam.WindowTitle = "Tabla Desarrollo"
        BAC_Parametros.BacParam.StoredProcParam(0) = txtMascara.Text
        BAC_Parametros.BacParam.Formulas(0) = "usuario='" & gsUsuario & "'"
        BAC_Parametros.BacParam.Connect = SwConeccion
        
        If Trim(UCase(Button.Key)) = "PRELIMINAR" Then
            BAC_Parametros.BacParam.Destination = 0
        Else
            BAC_Parametros.BacParam.Destination = 1
        End If
        
        BAC_Parametros.BacParam.Action = 1
        Screen.MousePointer = vbDefault

        Call LogAuditoria("10", OptLocal, Me.Caption, "", "")
      Else
        MsgBox "Debe Ingresar Mascara", vbInformation
      End If

Case "SALIR"
   Unload Me
End Select
End Sub

Private Sub txtFamilia_Change()
    If UCase$(Trim$(txtFamilia.Text)) = "BONOS" Then
       Frame(3).Enabled = True
    Else
       bonos_op1.Value = False
       bonos_op1.Value = False
       Frame(3).Enabled = False
    End If
    If UCase$(Trim$(txtFamilia.Text)) = "LCHR" Then
        txtMascara.MaxLength = 6
    Else
        txtMascara.MaxLength = 10
    End If
End Sub

Private Sub txtFamilia_DblClick()
   Call Familia
End Sub
Sub Familia()

   On Error GoTo Label1
    MiTag = "MDIN"
    BacAyuda.Show 1
   If giAceptar% = True Then
      txtFamilia.Enabled = True
      txtFamilia.Text = gsSerie$
      txtFamilia.SetFocus
      Bac_SendKey vbKeyReturn
   End If
   Exit Sub
Label1:
    MousePointer = 0
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Sub

End Sub
Private Sub txtFamilia_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call Familia
End Sub

Private Sub txtFamilia_KeyPress(KeyAscii As Integer)

    BacToUCase KeyAscii
    
End Sub


Private Sub txtFamilia_LostFocus()
On Error GoTo Label1

    If Trim(txtFamilia.Text) = "" Then Exit Sub
    
    If LeerFamilia(txtFamilia.Text) Then
        If xincodigo <> 0 Then
            txtRutEmi.Text = xinrutemi
            Call txtRutEmi_LostFocus
            txtFamilia.Enabled = False
        Else
            txtFamilia.Text = ""
        End If
    Else
        MsgBox "Familia no existe", vbOKOnly + vbExclamation
        txtFamilia.Text = ""
        txtFamilia.SetFocus
        Exit Sub
    End If

    
Exit Sub

Label1:
    MousePointer = 0
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Sub
    
End Sub

Private Sub txtMascara_DblClick()
   Call Mascara
End Sub
Sub Mascara()
On Error GoTo Label2
      If txtFamilia.Text = "" Then Exit Sub
         MiTag = "MDSE"
         BacAyuda.Show 1
      If giAceptar% = True Then
         txtMascara.Enabled = True
         txtMascara.Text = BacAyuda.Mascara 'PENDIENTE
         ftbtera.Enabled = True
         txtMascara.Enabled = False
      End If
      Exit Sub
Label2:
      MousePointer = 0
      MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
      Exit Sub
End Sub
Private Sub txtMascara_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call Mascara
End Sub

Private Sub txtMascara_KeyPress(KeyAscii As Integer)

    BacToUCase KeyAscii
    If KeyAscii = 39 Then
      KeyAscii = 0
    
    End If
    
End Sub

Private Sub txtMoneda_Change()

  
End Sub

Private Sub txtRutEmi_Change()

    txtDigito.Text = ""
    txtNombreEmisor.Text = ""
           
End Sub

Private Sub txtMascara_LostFocus()
Dim IdFamilia As String
Dim IdMascara As String
Dim IdMoneda  As Integer
Dim idRut     As Long
Dim i%

On Error GoTo Label1

    If Trim$(txtFamilia.Text) = "" Then
       Exit Sub
    End If
    
    If Trim$(txtMascara.Text) = "" Then
       Exit Sub
    End If

    Screen.MousePointer = 11
     
    Toolbar1.Buttons(4).Enabled = False
    Toolbar1.Buttons(5).Enabled = False
 
    If LeerSeries(Trim$(txtMascara.Text)) = True Then
           
            ActivaControles True
               
            If UCase$(xinmdtd) = "S" Then
               Toolbar1.Buttons(5).Enabled = True
               Toolbar1.Buttons(5).Key = "TD"
               Toolbar1.Buttons(5).ToolTipText = "Generar Tabla de Desarrollo"
            End If
    
            If UCase$(xinmdpr) = "S" Then
               Toolbar1.Buttons(5).Enabled = True
               Toolbar1.Buttons(5).Key = "TP"
               Toolbar1.Buttons(5).ToolTipText = "Generar Tabla de Premios"
            End If
            
            For i% = 0 To Cmb_Moneda.ListCount - 1
                If xsemonemi = Cmb_Moneda.ItemData(i%) Then
                   Cmb_Moneda.ListIndex = i%
                   Exit For
                End If
            Next i%

            Select Case xsebasemi
                   Case 30:  Cmb_Base.ListIndex = 0
                   Case 360: Cmb_Base.ListIndex = 1
                   Case 365: Cmb_Base.ListIndex = 2
            End Select
            
            dtbfechaemision.Text = xsefecemi
            dtbfechavcto.Text = xsefecven
            ftbtasaemision.Text = BacCtrlTransMonto(xsetasemi)
            '----------------------------------------------
            txtRutEmi.Text = xserutemi
            txtRutEmi_LostFocus
            
            If CSpreadTasa = "S" Then
                Me.Chk_TasaVariable.Value = 1
            Else
                Me.Chk_TasaVariable.Value = 0
            End If
            ftbtera.Text = BacCtrlTransMonto(xsetera)
            itbcupones.Text = xsecupones
            itbDia.Text = xsediavcup
            itbperiodo.Text = xsepervcup
            ftbplazo.Text = xseplazo
            cmbTipoAmortizacion.ListIndex = BuscaEnCombo(cmbTipoAmortizacion, Str(xsetipamor), "C")
            itbNumAmortizacion.Text = xsenumamor
            If xseffijos = "S" Then
               chFlujosFijos.Value = True
            Else
               chFlujosFijos.Value = False
            End If
            ftbtotalemitido.Text = xsetotale
            IntBaseCupones.Text = Val(xsebascup)
            itbNumDecimales.Text = Val(xsedecs)
            txtSubSerie.Text = xseserie
            FltCorte.Text = xsecorte
            Toolbar1.Buttons(1).Enabled = True
            
            If UCase$(Trim$(txtFamilia.Text)) = "LCHR" Then
               cmbTipoLetra.Enabled = True
            Else
               cmbTipoLetra.Enabled = False
            End If
            
            If xtipoletra = "F" Then
                cmbTipoLetra.ListIndex = 0
            ElseIf xtipoletra = "V" Then
                cmbTipoLetra.ListIndex = 1
            Else
                cmbTipoLetra.ListIndex = -1
                cmbTipoLetra.Enabled = False
            End If
            
            If UCase$(Trim$(txtFamilia.Text)) = "BONOS" Then
                ChkBonos.Enabled = True
                If dtbfechaemision.Text = "" Then
                   bonos_op1.Value = False
                   bonos_op2.Value = True
                Else
                   bonos_op1.Value = True
                   bonos_op2.Value = False
                End If
            Else
               ChkBonos.Enabled = False
            End If
            dtbprimercorte.Text = xfecprivcto
            If UCase$(Trim$(txtFamilia.Text)) = "LCHR" Then
               dtbprimercorte.Enabled = False
            Else
                dtbprimercorte.Enabled = True
            End If
             
             cmbTipoPeriodo.ListIndex = 1
             
             For i = 0 To cmbTipoPeriodo.ListCount
             
                If left(cmbTipoPeriodo.List(i), 1) = xsetipvcup Then
                   If cmbTipoPeriodo.ListCount <= i Then
                     Exit For
                   
                   End If
                     
                   cmbTipoPeriodo.ListIndex = i
                   Exit For
                End If
             
             Next i
             
             
            
    Else
        ActivaControles True

         If UCase$(Trim$(txtFamilia.Text)) = "LCHR" Then
            dtbprimercorte.Enabled = False
         Else
            dtbprimercorte.Enabled = True
         End If
            
       Screen.MousePointer = 0

       ftbtera.SetFocus
         Exit Sub
    End If

    txtSubSerie = txtMascara.Text


    ftbtera.SetFocus

    Screen.MousePointer = 0
    
    Exit Sub

Label1:
    Screen.MousePointer = 0
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Sub

End Sub


Sub RutEmi()
On Error GoTo Label1
    'Ayuda para Emisores
    '----------------------------------
    MiTag = "MDEM"
    BacAyuda.Show 1
    If giAceptar% = True Then
        txtRutEmi.Text = gsCodigo$
        txtDigito.Text = gsDigito$
        txtNombreEmisor.Text = gsDescripcion$
        dtbfechaemision.SetFocus
    End If
    Exit Sub
Label1:
    MousePointer = 0
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Sub
End Sub
Private Sub txtRutEmi_DblClick()
Call RutEmi
End Sub

Private Sub txtRutEmi_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call RutEmi
End Sub

Private Sub txtRutEmi_KeyPress(KeyAscii As Integer)
    
    If Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
       KeyAscii = 0
    End If

End Sub

Private Sub txtRutEmi_LostFocus()
If Val(txtRutEmi.Text) = 0 Then Exit Sub
Dim Cont As Single
On Error GoTo Label1
Cont = 0
   Envia = Array()
   AddParam Envia, Val(txtRutEmi.Text)
   
    If BAC_SQL_EXECUTE("Sp_Trae_Emisor ", Envia) Then
      Do While BAC_SQL_FETCH(Datos())
       If Datos(1) = "EXISTE" Then
           Cont = 0
           Exit Do
       End If
        Cont = Cont + 1
        txtDigito.Text = Datos(3)
        txtNombreEmisor.Text = Datos(4) 'modificado antes datos(2)
      Loop
    End If
    If Cont = 0 Then
       MsgBox "El Emisor no Existe", vbOKOnly + vbExclamation
       txtRutEmi.Text = ""
       txtDigito.Text = ""
       txtNombreEmisor.Text = ""
    End If
    
    
    Exit Sub
    
Label1:
   MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
   Exit Sub

End Sub

Private Sub txtSubSerie_KeyPress(KeyAscii As Integer)
       BacToUCase KeyAscii
End Sub

Function BuscaMonedaFox(Moneda As Integer) As Integer
'*************NO SE UTILIZA****************
Dim Sql As String
Dim Datos()
    BuscaMonedaFox = 0
    
    Envia = Array()
    AddParam Envia, Moneda
    
    
    If BAC_SQL_EXECUTE("sp_codigobanco", Envia) Then
        If BAC_SQL_FETCH(Datos()) Then
            BuscaMonedaFox = Datos(1)
        End If
    End If
'******************************************
End Function

Sub PROC_HABILITA_CONTROLES(nEstado As Boolean)

   Toolbar1.Buttons(1).Enabled = True
   Toolbar1.Buttons(2).Enabled = nEstado
   
   
End Sub


