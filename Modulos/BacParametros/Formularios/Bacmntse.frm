VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacMntSe 
   Appearance      =   0  'Flat
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Series"
   ClientHeight    =   6360
   ClientLeft      =   1815
   ClientTop       =   2145
   ClientWidth     =   8610
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
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6360
   ScaleWidth      =   8610
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5040
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntse.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntse.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntse.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntse.frx":0EC8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   53
      Top             =   0
      Width           =   8610
      _ExtentX        =   15187
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
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   5715
      Left            =   0
      TabIndex        =   0
      Top             =   600
      Width           =   8580
      _Version        =   65536
      _ExtentX        =   15134
      _ExtentY        =   10081
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
      Begin BACControles.TXTNumero ftbTotalEmitido 
         Height          =   255
         Left            =   5760
         TabIndex        =   22
         Top             =   4560
         Width           =   2415
         _ExtentX        =   4260
         _ExtentY        =   450
         ForeColor       =   8388608
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
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTFecha dtbfechavcto 
         Height          =   315
         Left            =   3360
         TabIndex        =   15
         Top             =   3120
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   556
         Enabled         =   -1  'True
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
         ForeColor       =   8388608
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "14-11-01"
      End
      Begin BACControles.TXTFecha dtbfechaemision 
         Height          =   315
         Left            =   1680
         TabIndex        =   14
         Top             =   3120
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   556
         Enabled         =   -1  'True
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
         ForeColor       =   8388608
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "14-11-01"
      End
      Begin BACControles.TXTNumero ftbplazo 
         Height          =   315
         Left            =   120
         TabIndex        =   13
         Top             =   3120
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   556
         ForeColor       =   8388608
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
         Text            =   "0.00"
         Text            =   "0.00"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTFecha dtbprimercorte 
         Height          =   315
         Left            =   3360
         TabIndex        =   21
         Top             =   4560
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   556
         Enabled         =   -1  'True
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
         ForeColor       =   -2147483635
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "08/09/2001"
      End
      Begin BACControles.TXTNumero IntBaseCupones 
         Height          =   315
         Left            =   5760
         TabIndex        =   19
         Top             =   3840
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   556
         ForeColor       =   -2147483635
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero FltCorte 
         Height          =   315
         Left            =   3360
         TabIndex        =   18
         Top             =   3840
         Width           =   615
         _ExtentX        =   1085
         _ExtentY        =   556
         ForeColor       =   -2147483635
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero itbDia 
         Height          =   315
         Left            =   3360
         TabIndex        =   10
         Top             =   2400
         Width           =   495
         _ExtentX        =   873
         _ExtentY        =   556
         ForeColor       =   -2147483635
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero itbNumDecimales 
         Height          =   315
         Left            =   120
         TabIndex        =   16
         Top             =   3840
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   556
         ForeColor       =   -2147483635
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero itbNumAmortizacion 
         Height          =   315
         Left            =   1080
         TabIndex        =   9
         Top             =   2400
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   556
         ForeColor       =   -2147483635
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero itbperiodo 
         Height          =   315
         Left            =   6840
         TabIndex        =   12
         Top             =   2400
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   556
         ForeColor       =   -2147483635
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero itbcupones 
         Height          =   315
         Left            =   120
         TabIndex        =   8
         Top             =   2400
         Width           =   615
         _ExtentX        =   1085
         _ExtentY        =   556
         ForeColor       =   -2147483635
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.ComboBox cmbTipoLetra 
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   23
         Top             =   5280
         Width           =   3135
      End
      Begin VB.TextBox txtSubSerie 
         Enabled         =   0   'False
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   3360
         MaxLength       =   12
         TabIndex        =   24
         Top             =   5280
         Width           =   1575
      End
      Begin VB.ComboBox cmbTipoPeriodo 
         Enabled         =   0   'False
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   5520
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   2400
         Width           =   1290
      End
      Begin VB.ComboBox cmbTipoAmortizacion 
         Enabled         =   0   'False
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   4560
         Width           =   2055
      End
      Begin VB.CheckBox ChkBonos 
         Caption         =   "BONOS"
         ForeColor       =   &H00800000&
         Height          =   270
         Left            =   5040
         TabIndex        =   41
         Top             =   5640
         Visible         =   0   'False
         Width           =   1095
      End
      Begin Threed.SSFrame Frame 
         Height          =   975
         Index           =   0
         Left            =   120
         TabIndex        =   44
         Top             =   0
         Width           =   8460
         _Version        =   65536
         _ExtentX        =   14922
         _ExtentY        =   1720
         _StockProps     =   14
         Caption         =   " Datos Serie "
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
         Begin BACControles.TXTNumero ftbtasaemision 
            Height          =   315
            Left            =   4200
            TabIndex        =   4
            Top             =   555
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   556
            ForeColor       =   8388608
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
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero ftbtera 
            Height          =   315
            Left            =   3000
            TabIndex        =   3
            Top             =   555
            Width           =   1095
            _ExtentX        =   1931
            _ExtentY        =   556
            ForeColor       =   -2147483646
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
            MarcaTexto      =   -1  'True
         End
         Begin VB.TextBox txtFamilia 
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   120
            MaxLength       =   8
            MouseIcon       =   "Bacmntse.frx":11E2
            MousePointer    =   99  'Custom
            TabIndex        =   1
            Top             =   555
            Width           =   1335
         End
         Begin VB.TextBox txtMascara 
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1530
            MaxLength       =   10
            MouseIcon       =   "Bacmntse.frx":14EC
            MousePointer    =   99  'Custom
            TabIndex        =   2
            Top             =   555
            Width           =   1335
         End
         Begin VB.ComboBox Cmb_Base 
            Enabled         =   0   'False
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   7200
            Style           =   2  'Dropdown List
            TabIndex        =   6
            Top             =   555
            Width           =   990
         End
         Begin VB.ComboBox Cmb_Moneda 
            Enabled         =   0   'False
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   6000
            Style           =   2  'Dropdown List
            TabIndex        =   5
            Top             =   555
            Width           =   1170
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Tasa Emisión"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   10
            Left            =   4200
            TabIndex        =   58
            Top             =   330
            Width           =   1140
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Tera"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   2
            Left            =   3000
            TabIndex        =   49
            Top             =   330
            Width           =   405
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Base"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   4
            Left            =   7200
            TabIndex        =   48
            Top             =   330
            Width           =   435
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Moneda"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   3
            Left            =   6000
            TabIndex        =   47
            Top             =   330
            Width           =   690
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Familia"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   0
            Left            =   120
            TabIndex        =   46
            Top             =   330
            Width           =   600
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Máscara"
            ForeColor       =   &H00800000&
            Height          =   315
            Index           =   1
            Left            =   1530
            TabIndex        =   45
            Top             =   330
            Width           =   735
         End
      End
      Begin Threed.SSFrame Frame 
         Height          =   1065
         Index           =   1
         Left            =   120
         TabIndex        =   50
         Top             =   960
         Width           =   7725
         _Version        =   65536
         _ExtentX        =   13626
         _ExtentY        =   1879
         _StockProps     =   14
         Caption         =   " Datos de Emisión "
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
         Begin VB.TextBox txtRutEmi 
            Enabled         =   0   'False
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   120
            MaxLength       =   9
            MouseIcon       =   "Bacmntse.frx":17F6
            MousePointer    =   99  'Custom
            TabIndex        =   7
            Top             =   540
            Width           =   1095
         End
         Begin VB.TextBox txtNombreEmisor 
            Enabled         =   0   'False
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1800
            MaxLength       =   40
            TabIndex        =   28
            Top             =   540
            Width           =   5700
         End
         Begin VB.TextBox txtDigito 
            Enabled         =   0   'False
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1380
            MaxLength       =   1
            TabIndex        =   27
            Top             =   540
            Width           =   225
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "-"
            BeginProperty Font 
               Name            =   "Symbol"
               Size            =   26.25
               Charset         =   2
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   585
            Index           =   17
            Left            =   1230
            TabIndex        =   54
            Top             =   330
            Width           =   105
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Rut Emisor"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   5
            Left            =   120
            TabIndex        =   52
            Top             =   315
            Width           =   930
         End
         Begin VB.Label Label 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Nombre"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   6
            Left            =   1800
            TabIndex        =   51
            Top             =   315
            Width           =   660
         End
      End
      Begin Threed.SSFrame Frame 
         Height          =   1500
         Index           =   3
         Left            =   5760
         TabIndex        =   29
         Top             =   6000
         Visible         =   0   'False
         Width           =   2595
         _Version        =   65536
         _ExtentX        =   4577
         _ExtentY        =   2646
         _StockProps     =   14
         Caption         =   "BONOS"
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
         Begin VB.OptionButton bonos_op2 
            Caption         =   "Emisión Variable"
            ForeColor       =   &H00800000&
            Height          =   450
            Left            =   45
            TabIndex        =   43
            Top             =   885
            Width           =   1770
         End
         Begin VB.OptionButton bonos_op1 
            Caption         =   "Unica Emisión"
            ForeColor       =   &H00800000&
            Height          =   195
            Left            =   45
            TabIndex        =   42
            Top             =   480
            Width           =   1650
         End
      End
      Begin Threed.SSCommand cmdTabDes 
         Height          =   600
         Left            =   7800
         TabIndex        =   26
         Top             =   5040
         Width           =   600
         _Version        =   65536
         _ExtentX        =   1058
         _ExtentY        =   1058
         _StockProps     =   78
         Caption         =   "TD"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Courier New"
            Size            =   15.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
      End
      Begin Threed.SSCommand cmdTabPre 
         Height          =   600
         Left            =   6960
         TabIndex        =   25
         Top             =   5040
         Width           =   600
         _Version        =   65536
         _ExtentX        =   1058
         _ExtentY        =   1058
         _StockProps     =   78
         Caption         =   "TP"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Courier New"
            Size            =   15.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Enabled         =   0   'False
         Font3D          =   3
      End
      Begin Threed.SSCheck chFlujosFijos 
         Height          =   255
         Left            =   1440
         TabIndex        =   17
         Top             =   3840
         Width           =   1095
         _Version        =   65536
         _ExtentX        =   1931
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "Flujos Fijos"
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
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Periodo Mensual /Anual"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   25
         Left            =   4680
         TabIndex        =   61
         Top             =   2160
         Width           =   2055
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Total Emitido"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   19
         Left            =   5760
         TabIndex        =   59
         Top             =   4320
         Width           =   1125
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Fecha Vcto."
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   8
         Left            =   3360
         TabIndex        =   57
         Top             =   2880
         Width           =   1200
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Fecha Emisión"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   7
         Left            =   1560
         TabIndex        =   56
         Top             =   2880
         Width           =   1395
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Plazo (años)"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   24
         Left            =   120
         TabIndex        =   55
         Top             =   2880
         Width           =   1065
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Fecha Primer Corte"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   23
         Left            =   3360
         TabIndex        =   30
         Top             =   4320
         Width           =   1635
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Tipo de Letra"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   22
         Left            =   120
         TabIndex        =   31
         Top             =   5040
         Width           =   1155
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Sub Serie"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   18
         Left            =   3360
         TabIndex        =   32
         Top             =   5040
         Width           =   840
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Tipo Amortización"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   16
         Left            =   120
         TabIndex        =   33
         Top             =   4320
         Width           =   1530
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Corte Minimo"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   21
         Left            =   3360
         TabIndex        =   34
         Top             =   3630
         Width           =   1110
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Base Cupones"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   20
         Left            =   5760
         TabIndex        =   35
         Top             =   3630
         Width           =   1230
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Cupones"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   11
         Left            =   120
         TabIndex        =   36
         Top             =   2190
         Width           =   750
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Día V/C"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   13
         Left            =   3360
         TabIndex        =   37
         Top             =   2190
         Width           =   720
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Período V/C"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   12
         Left            =   6840
         TabIndex        =   38
         Top             =   2190
         Width           =   1080
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Nº Amortizaciones"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   14
         Left            =   1095
         TabIndex        =   39
         Top             =   2190
         Width           =   1560
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Nº Decimales"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   15
         Left            =   120
         TabIndex        =   40
         Top             =   3630
         Width           =   1155
      End
   End
   Begin VB.Label Label 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Día V/C"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   0
      TabIndex        =   60
      Top             =   0
      Width           =   720
   End
End
Attribute VB_Name = "BacMntSe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim sql As String
Dim datos()
Public xincodigo As Double
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
Dim xseplazo     As Single
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


Function EliminarSerie() As Boolean
On Error GoTo ErrEliminar
EliminarSerie = False

Envia = Array()
AddParam Envia, txtMascara.Text

If Bac_Sql_Execute("SP_ELIMINA_SERIE", Envia) Then
 Do While Bac_SQL_Fetch(Datos())
   If Datos(1) = "NO" Then
     Exit Function
   End If
 Loop
End If
Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_612 " _
                                    , "03" _
                                    , "Elimina Serie" _
                                    , "SERIE " _
                                    , " " _
                                    , "Eliminar Serie" & " " & Trim(txtFamilia.Text) & " " & Trim(txtMascara.Text) & " " & Trim(Cmb_Moneda.Text))
EliminarSerie = True
Exit Function
ErrEliminar:
Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_612 " _
                                    , "03" _
                                    , "Error Eliminar Serie" _
                                    , "SERIE " _
                                    , " " _
                                    , Trim(txtFamilia.Text) & " " & Trim(txtMascara.Text) & " " & Trim(Cmb_Moneda.Text))
                                    
MsgBox "Error " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
Exit Function
End Function

Function GrabarSerie() As Boolean
Dim aux As String
aux = cmbTipoAmortizacion.Text
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
   AddParam Envia, cmbTipoPeriodo.Text
'  AddParam Envia, Trim(Left(cmbTipoPeriodo.Text, Len(cmbTipoPeriodo.Text) - 5))
End If
AddParam Envia, CDbl(itbperiodo.Text)
AddParam Envia, CDbl(itbNumAmortizacion.Text)
AddParam Envia, CDbl(itbNumDecimales.Text)
AddParam Envia, CDbl(itbDia.Text)
AddParam Envia, IIf(chFlujosFijos.Value, "S", "N")
AddParam Envia, CDbl(IntBaseCupones.Text)
AddParam Envia, CDbl(FltCorte.Text)
AddParam Envia, CDbl(Trim(Right(aux, 3))) 'aqui se debe arreglar
AddParam Envia, CDbl(ftbTotalEmitido.Text)
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

If Bac_Sql_Execute("SP_GRABA_SERIE ", Envia) Then
  Do While Bac_SQL_Fetch(Datos())
    If Datos(1) = "NO" Then
      Exit Function
    End If
  Loop
End If
 Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_612 " _
                                    , "01" _
                                    , "Grabar Serie" _
                                    , "SERIE " _
                                    , " " _
                                    , "Grabar Serie" & " " & Trim(txtFamilia.Text) & " " & Trim(txtMascara.Text) & " " & Trim(Cmb_Moneda.Text))
GrabarSerie = True
Exit Function
ErrGrabar:
  MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
  Exit Function
End Function

Function LeerFamilia(xFamilia As String) As Boolean
Dim Cont As Single

    LeerFamilia = False
    Cont = 0
    Envia = Array()
    AddParam Envia, xFamilia
    
    If Bac_Sql_Execute("SP_TRAE_INSTRUMENTOS", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            Cont = Cont + 1
            xinserie = datos(1)
            xincodigo = datos(3)
            xinrutemi = datos(6)
            xinmonemi = datos(7)
            xinbasemi = datos(8)
            xintipfec = datos(14)
            xinmdpr = datos(12)
            xinmdtd = datos(13)
            xrefnomi = datos(5)
            cmdTabDes.Enabled = IIf(xinmdtd = "S", True, False)
            cmdTabPre.Enabled = IIf(xinmdpr = "S", True, False)
        
        
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

If Bac_Sql_Execute("SP_TRAE_SERIE", Envia) Then
   Do While Bac_SQL_Fetch(Datos())
    Cont = Cont + 1
        xsebasemi = Val(datos(6))
        xserutemi = datos(7)
        xsemonemi = datos(5)
        xsefecemi = IIf(IsDate(datos(8)), datos(8), "01/01/1900")
        xsefecven = IIf(IsDate(datos(9)), datos(9), "01/01/1900")
        xsetasemi = CDbl(datos(11))
        xsetera = CDbl(datos(4))
        xsecupones = Val(datos(12))
        xsediavcup = Val(datos(17))
        xsepervcup = Val(datos(14))
        xsetipvcup = datos(13)
        xseplazo = Val(datos(10))
        xsetipamor = Val(datos(21))
        xsenumamor = Val(datos(15))
        xseffijos = datos(18)
        xsebascup = Val(datos(19))
        xsedecs = Val(datos(16))
        xsecorte = Val(datos(20))
        xsetotale = datos(22)
        xtipoletra = datos(23)
        xfecprivcto = IIf(IsDate(datos(24)), datos(24), "01/01/1900")
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
    
    
    txtFamilia.Enabled = True
    txtMascara.Enabled = True
    txtFamilia.Tag = ""
    Toolbar1.Buttons(1).Enabled = True
    Toolbar1.Buttons(2).Enabled = True
    cmdTabDes.Enabled = False
    cmdTabPre.Enabled = False
    cmdTabDes.Enabled = False
    cmdTabPre.Enabled = False
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False

        
    ChkBonos.Value = 0
    ChkBonos.Enabled = False
    Frame(3).Enabled = False
    bonos_op1.Enabled = False
    bonos_op2.Enabled = False
    txtFamilia.SetFocus
    
    
    Exit Sub

Label1:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
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




Private Sub Check1_Click()

End Sub

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

Private Sub cmdTabDes_Click()
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
      
    BacMnSe1.proOrigense = "SE"
    BacMnSe1.Tag = Frase
    BacMnSe1.Show 1
    Exit Sub

Label1:
   If Err.Number <> 364 Then
    MsgBox "Error : " & Err.Description, vbOKOnly + vbExclamation, TITSISTEMA
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
    ftbTotalEmitido.Enabled = Valor
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
    Toolbar1.Buttons(1).Enabled = True
    Toolbar1.Buttons(2).Enabled = True
    dtbprimercorte.Enabled = Valor
End Sub




Private Sub CalculaFechas()

On Error GoTo Label1

Dim sString        As String
Dim CantidadAnn    As Long
Dim FechaEmision   As String
Dim FechaVen       As String
    
'   If CDbl(itbperiodo.Text) = 0 Or CDbl(itbDia.Text) = 0 Then
    If CDbl(ftbplazo.Text) = 0 Then
       CantidadAnn = 0
       Exit Sub
    Else
    
'      If ftbplazo.Tag = "TRUE" Then
          CantidadAnn = CDbl(ftbplazo.Text)
          ftbplazo.Tag = ""
'      Else
'         CantidadAnn = CDbl(itbcupones.Text) / (Int(12 / CDbl(itbperiodo.Text)))
'      End If

    End If
     
         
    If Trim$(dtbfechaemision.Text) <> "" Then
        dtbfechavcto.Text = Format(DateAdd("yyyy", CantidadAnn, dtbfechaemision.Text), "DD/MM/YYYY")
        dtbprimercorte.Text = Format$(DateAdd("m", Int(itbperiodo.Text), dtbfechaemision.Text), "dd/mm/yyyy")
    End If
    
    If Trim$(dtbfechaemision.Text) = "" And Trim$(dtbfechavcto.Text) <> "" Then
        dtbfechaemision.Text = Format$(DatePart("d", dtbfechavcto.Text), "00") + "/" + Format$(DatePart("m", dtbfechavcto.Text), "00") + "/" + Format$(DatePart("yyyy", dtbfechavcto.Text) - CDbl(ftbplazo.Text), "0000")
'       FechaVen = DateAdd("yyyy", CantidadAnn, FechaEmision)
    End If
    
'   ftbplazo.Text = CantidadAnn
'   dtbfechaemision.Text = FechaEmision
'   dtbfechavcto.Text = FechaVen

    Exit Sub

Label1:
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
    Exit Sub
    
    
End Sub


Private Sub cmdTabPre_Click()
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


Private Sub dtbfechaemision_LostFocus()
    If UCase$(Trim$(txtFamilia.Text)) = "PRC" Then
        itbDia.Text = 1
        dtbfechaemision.Text = CDate("01/" + Mid$(Trim$(txtMascara.Text), 7, 2) + "/" + Mid$(Trim$(txtMascara.Text), 9, 2))
    End If
End Sub

Private Sub dtbFechaVcto_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
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



Private Sub dtbfechavcto_LostFocus()

    If CDate(dtbfechavcto.Text) <= CDate(dtbfechaemision.Text) Then
        MsgBox "Fecha de Vcto no puede ser menor o igual a Fecha de Emisión"
'       dtbfechavcto.SetFocus
        Exit Sub
    End If
End Sub

Private Sub FltCorte_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        KeyAscii = 0
    End If


    If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
        KeyAscii = Asc(gsc_PuntoDecim)
    End If

End Sub


Private Sub FltCorte_LostFocus()
    If UCase$(Trim$(txtFamilia.Text)) = "PRC" Then
        Select Case Mid$(Trim$(txtMascara.Text), 6, 1)
                Case "A": FltCorte.Text = 500
                Case "B": FltCorte.Text = 1000
                Case "C": FltCorte.Text = 5000
                Case "D": FltCorte.Text = 10000
        End Select
    End If
End Sub

Private Sub ftbPlazo_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        KeyAscii = 0

        ftbplazo.Tag = "TRUE"
        Call CalculaFechas
    End If

End Sub


Private Sub ftbplazo_LostFocus()
    If UCase$(Trim$(txtFamilia.Text)) = "PRC" And dtbfechavcto.Text >= dtbfechaemision.Text Then
        itbDia.Text = 1
        If ftbplazo.Text = 0 Then
            ftbplazo.Text = DateDiff("YYYY", dtbfechaemision.Text, dtbfechavcto.Text)
        End If
        If ftbplazo.Text > 0 Then
            dtbfechavcto.Text = DateAdd("YYYY", CDbl(ftbplazo.Text), CDate(dtbfechaemision.Text))
        End If
    End If
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


Private Sub ftbTotalEmitido_KeyPress(KeyAscii As Integer)


    If KeyAscii = 13 Then
        KeyAscii = 0
    End If
End Sub


Private Sub IntBaseCupones_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        KeyAscii = 0
    End If
End Sub


Private Sub itbCupones_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        KeyAscii = 0

'       Call CalculaFechas
    End If

End Sub


Private Sub itbDia_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        KeyAscii = 0

'       Call CalculaFechas
    End If

End Sub


Private Sub itbNumAmortizacion_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        KeyAscii = 0
    End If
End Sub


Private Sub itbNumDecimales_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        KeyAscii = 0
    End If

End Sub


Private Sub itbPeriodo_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        KeyAscii = 0
'       Call CalculaFechas
        If CDbl(itbperiodo.Text) > 0 Then
            ftbplazo.Text = CDbl(itbcupones.Text) / (Int(12 / CDbl(itbperiodo.Text)))
        End If
    End If
    
End Sub



Private Sub cmdEliminar_Click()
On Error GoTo Label1

Dim nFlag As Integer
Screen.MousePointer = 11
If EliminarSerie Then
   MsgBox "La eliminación se realizó con exito", vbOKOnly + vbInformation, TITSISTEMA
   Call Limpiar
Else
   MsgBox "No se completo la elimininación", vbOKOnly + vbExclamation, TITSISTEMA
End If
Screen.MousePointer = 0
Exit Sub

Label1:
  Screen.MousePointer = 11
  MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
  Exit Sub
End Sub


Private Sub cmdGrabar_Click()

On Error GoTo Label1

     If ValidaDatos() = False Then
        Exit Sub
     End If
     
     Screen.MousePointer = 11
     
     If GrabarSerie Then
        MsgBox "Serie Grabada Correctamente.", vbOKOnly + vbInformation, TITSISTEMA
        Call Limpiar
     Else
        MsgBox "No se completo la grabación de Serie.", vbOKOnly + vbExclamation, TITSISTEMA
     End If
     
   Screen.MousePointer = 0
     
    Exit Sub

Label1:
      MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
      Exit Sub
      
End Sub


Private Sub cmdSalir_Click()
        Unload Me
End Sub


Private Sub Form_KeyPress(KeyAscii As Integer)
        
    If KeyAscii = 13 Then
       SendKeys "{tab}"
    End If
        
End Sub

Private Sub Form_Load()
Me.Top = 0
Me.Left = 0

Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_690 " _
                          , "07" _
                          , "Ingreso a Opción de Series" _
                          , " " _
                          , " " _
                          , " ")



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
       MsgBox "No existen tipos de amortización", vbOKOnly + vbExclamation, TITSISTEMA
       Unload Me
    End If
      
    If Not Llenar_Combos(cmbTipoPeriodo, MDSE_TIPOPERIODO) Then    ' 216
       MsgBox "No existen tipos de periodo", vbOKOnly + vbCritical, TITSISTEMA
       Unload Me
       Exit Sub
    End If
    
    If funcFindMonVal(Cmb_Moneda, Cmb_Base, "") Then
       Cmb_Moneda.ListIndex = 0
    End If

    txtFamilia.Enabled = True
    txtMascara.Enabled = True
    Toolbar1.Buttons(1).Enabled = True
    Toolbar1.Buttons(2).Enabled = True
    cmdTabDes.Enabled = False
    cmdTabPre.Enabled = False
    
    Toolbar1.Buttons(2).Enabled = False
'   Toolbar1.Buttons(2).Enabled = True
   

Exit Sub

Label1:
       MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
       Unload Me
       Exit Sub
End Sub


Private Sub itbperiodo_LostFocus()
dtbprimercorte.Text = Format$(DateAdd("m", Int(itbperiodo.Text), dtbfechaemision.Text), "dd/mm/yyyy")
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
   Case 1
      On Error GoTo Label30

     If ValidaDatos() = False Then
        Exit Sub
     End If
     
     Screen.MousePointer = 11
     
     If GrabarSerie Then
        MsgBox "Serie Grabada Correctamente.", vbOKOnly + vbInformation, TITSISTEMA
'       Call Limpiar
        Toolbar1.Buttons(2).Enabled = True
        
        If UCase$(xinmdtd) = "S" Then
           cmdTabDes.Enabled = True
        Else
           cmdTabDes.Enabled = False
        End If

     Else
        MsgBox "No se completo la grabación de Serie.", vbOKOnly + vbExclamation, TITSISTEMA
     End If
     
   Screen.MousePointer = 0
     
    Exit Sub

Label30:
      MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
      Exit Sub
Case 2
Dim mm
mm = MsgBox("¿Seguro de Eliminar?", vbQuestion + vbYesNo, TITSISTEMA)
If mm = 6 Then
   On Error GoTo Label31

Dim nFlag As Integer
Screen.MousePointer = 11
If EliminarSerie Then
   MsgBox "La eliminación se realizó con exito", vbOKOnly + vbInformation, TITSISTEMA
   Call Limpiar
Else
   MsgBox "No se completo la elimininación", vbOKOnly + vbExclamation, TITSISTEMA
End If
Screen.MousePointer = 0
Exit Sub

Label31:
  Screen.MousePointer = 11
  MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
  Exit Sub
End If
Case 3
       Call Limpiar
   ActivaControles False
Case 4
       Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_612 " _
                                    , "08" _
                                    , "Salir Opcion De Series" _
                                    , " " _
                                    , " " _
                                    , " ")
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
End Sub

Private Sub txtFamilia_DblClick()
   Call Familia
End Sub
Sub Familia()

   On Error GoTo Label1
    BacAyuda.Tag = "MDIN"
    BacAyuda.Show 1
   If giAceptar% = True Then
      txtFamilia.Enabled = True
      txtFamilia.Text = gsSerie$
      txtFamilia.SetFocus
      SendKeys "{ENTER}"
   End If
   Exit Sub
Label1:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
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
    If txtFamilia.Text <> "lchr" Or txtFamilia.Text <> "LCHR" Then
       cmbTipoLetra.Enabled = False
    End If
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
        MsgBox "Familia no existe", vbOKOnly + vbExclamation, TITSISTEMA
        txtFamilia.Text = ""
        txtFamilia.SetFocus
        Exit Sub
    End If
    
    
    
Exit Sub

Label1:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
    Exit Sub
    
End Sub

Private Sub txtMascara_DblClick()
   Call Mascara
End Sub
Sub Mascara()
On Error GoTo Label2
      If txtFamilia.Text = "" Then Exit Sub
         BacAyuda.Tag = "MDSE"
         BacAyuda.Show 1
      If giAceptar% = True Then
         txtMascara.Enabled = True
         txtMascara.Text = BacAyuda.Mascara 'PENDIENTE
         ftbtera.Enabled = True
         ftbtera.SetFocus
         txtMascara.Enabled = False
         'txtMascara.SetFocus
         'SendKeys "{ENTER}"
      End If
      Exit Sub
Label2:
      MousePointer = 0
      MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
      Exit Sub
End Sub
Private Sub txtMascara_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then
        txtMascara.Text = ""
        Call Mascara
   End If
End Sub

Private Sub txtMascara_KeyPress(KeyAscii As Integer)

    BacToUCase KeyAscii
    
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
Dim I%
Dim lCortes As Long
Dim sLet As String

On Error GoTo Label1

    If Trim$(txtFamilia.Text) = "" Then
       Exit Sub
    End If
    
    If Trim$(txtMascara.Text) = "" Then
       'Call Limpiar
       Exit Sub
    End If

    Screen.MousePointer = 11
    
    cmdTabDes.Enabled = False
    cmdTabPre.Enabled = False
              
    If LeerSeries(Trim$(txtMascara.Text)) = True Then
           
            ActivaControles True
           
            If UCase$(xinmdtd) = "S" Then
               cmdTabDes.Enabled = True
            Else
               cmdTabDes.Enabled = False
            End If
    
            'Para botón tabla de premios
            '------------------------------
            If UCase$(xinmdpr) = "S" Then
               cmdTabPre.Enabled = True
            Else
               cmdTabPre.Enabled = False
            End If
            
            For I% = 0 To Cmb_Moneda.ListCount - 1
                If xsemonemi = Cmb_Moneda.ItemData(I%) Then
                   Cmb_Moneda.ListIndex = I%
                   Exit For
                End If
            Next I%

            Select Case xsebasemi
                   Case 30:  Cmb_Base.ListIndex = 0
                   Case 360: Cmb_Base.ListIndex = 1
                   Case 365: Cmb_Base.ListIndex = 2
            End Select
            
            dtbfechaemision.Text = Format(xsefecemi, "DD/MM/YYYY")
            dtbfechavcto.Text = Format(xsefecven, "DD/MM/YYYY")
            ftbtasaemision.Text = xsetasemi
            '----------------------------------------------
            txtRutEmi.Text = xserutemi
            txtRutEmi_LostFocus
            
            ftbtera.Text = xsetera
            itbcupones.Text = xsecupones
            itbDia.Text = xsediavcup
            itbperiodo.Text = xsepervcup
            'cmbTipoPeriodo.ListIndex = xsetipvcup
            ftbplazo.Text = xseplazo
            cmbTipoAmortizacion.ListIndex = BuscaEnCombo(cmbTipoAmortizacion, Str(xsetipamor), "C")
            itbNumAmortizacion.Text = xsenumamor
            If xseffijos = "S" Then
               chFlujosFijos.Value = True
            Else
               chFlujosFijos.Value = False
            End If
            ftbTotalEmitido.Text = xsetotale
            IntBaseCupones.Text = Val(xsebascup)
            itbNumDecimales.Text = Val(xsedecs)
            txtSubSerie.Text = xseserie
            FltCorte.Text = xsecorte
            Toolbar1.Buttons(1).Enabled = True
            Toolbar1.Buttons(2).Enabled = True
            
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
            
            Toolbar1.Buttons(2).Enabled = True
            
    Else
    
         ActivaControles True
'        If UCase$(xinmdtd) = "S" Then
'            cmdTabDes.Enabled = True
'        Else
'            cmdTabDes.Enabled = False
'        End If
'
'        'Para botón tabla de premios
'        '------------------------------
'        If UCase$(xinmdpr) = "S" Then
'            cmdTabPre.Enabled = True
'        Else
'            cmdTabPre.Enabled = False
'        End If
            
        cmdTabDes.Enabled = False
        cmdTabPre.Enabled = False
        
        dtbfechaemision.Text = Format(Date, "DD/MM/YYYY")
        dtbfechavcto.Text = Format(Date, "DD/MM/YYYY")
            
        If UCase$(Trim$(txtFamilia.Text)) = "PRC" Then
            sLet = Mid$(Trim$(txtMascara.Text), 6, 1)
            Select Case sLet
                    Case "A": lCortes = 500
                    Case "B": lCortes = 1000
                    Case "C": lCortes = 5000
                    Case "D": lCortes = 10000
            End Select
            itbDia.Text = 1
            FltCorte.Text = lCortes
            dtbfechaemision.Text = Format(CDate("01/" + Mid$(Trim$(txtMascara.Text), 7, 2) + "/" + Mid$(Trim$(txtMascara.Text), 9, 2)), "DD/MM/YYYY")
        End If
            
        If UCase$(Trim$(txtFamilia.Text)) = "PRD" Then
            itbDia.Text = 1
            dtbfechaemision.Text = Format(CDate("01/" + Mid$(Trim$(txtMascara.Text), 7, 2) + "/" + Mid$(Trim$(txtMascara.Text), 9, 2)), "DD/MM/YYYY")
        End If
            
            
        If UCase$(Trim$(txtFamilia.Text)) = "LCHR" Then
           cmbTipoLetra.Enabled = True
        Else
           cmbTipoLetra.Enabled = False
        End If
            
            
        Toolbar1.Buttons(2).Enabled = False
        
        If UCase$(Trim$(txtFamilia.Text)) = "PRD" Or UCase$(Trim$(txtFamilia.Text)) = "PRC" Or UCase$(Trim$(txtFamilia.Text)) = "LCHR" Or UCase$(Trim$(txtFamilia.Text)) = "BONOS" Then
           txtSubSerie.Text = txtMascara.Text
           txtSubSerie.Enabled = False
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
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
    Exit Sub

End Sub


Sub RutEmi()
On Error GoTo Label1
    'Ayuda para Emisores
    '----------------------------------
    BacAyuda.Tag = "MDEM"
    BacAyuda.Show 1
    If giAceptar% = True Then
        txtRutEmi.Text = gsCodigo$
        txtDigito.Text = gsDigito$
        txtNombreEmisor.Text = gsDescripcion$
        itbcupones.SetFocus
        'dtbfechaemision.SetFocus
'        txtRutEmi.SetFocus
'        SendKeys "{ENTER}"
    End If
    Exit Sub
Label1:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
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
   
    If Bac_Sql_Execute("SP_TRAE_EMISOR ", Envia) Then
      Do While Bac_SQL_Fetch(Datos())
        Cont = Cont + 1
        txtDigito.Text = datos(3)
        txtNombreEmisor.Text = datos(4) 'modificado antes datos(2)
      Loop
    End If
    If Cont = 0 Then
       MsgBox "El emisor no existe", vbOKOnly + vbExclamation, TITSISTEMA
       txtRutEmi.Text = ""
       txtDigito.Text = ""
       txtNombreEmisor.Text = ""
    End If
    
    
    Exit Sub
    
Label1:
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
   Exit Sub

End Sub

Private Sub txtSubSerie_KeyPress(KeyAscii As Integer)
       BacToUCase KeyAscii
End Sub

Function BuscaMonedaFox(Moneda As Integer) As Integer
'*************NO SE UTILIZA****************
Dim sql As String
Dim datos()
    BuscaMonedaFox = 0
    
    Envia = Array()
    AddParam Envia, Moneda
    
    
    If Bac_Sql_Execute("SP_CODIGOBANCO", Envia) Then
        If Bac_SQL_Fetch(Datos()) Then
            BuscaMonedaFox = Datos(1)
        End If
    End If
'******************************************
End Function
