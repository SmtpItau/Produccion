VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacMntMn 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Monedas"
   ClientHeight    =   6345
   ClientLeft      =   3135
   ClientTop       =   1590
   ClientWidth     =   6960
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmntmn.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6345
   ScaleWidth      =   6960
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5760
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
            Picture         =   "Bacmntmn.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntmn.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntmn.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntmn.frx":0EC8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   20
      Top             =   0
      Width           =   6960
      _ExtentX        =   12277
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
      Height          =   5850
      Left            =   15
      TabIndex        =   23
      Top             =   525
      Width           =   6930
      _Version        =   65536
      _ExtentX        =   12224
      _ExtentY        =   10319
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
      Begin VB.TextBox txtCodigo 
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
         Left            =   1650
         MaxLength       =   3
         MouseIcon       =   "Bacmntmn.frx":11E2
         MousePointer    =   99  'Custom
         TabIndex        =   0
         Top             =   180
         Width           =   555
      End
      Begin VB.TextBox txtGlosaMoneda 
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
         Left            =   2220
         MaxLength       =   30
         TabIndex        =   1
         Top             =   180
         Width           =   4575
      End
      Begin Threed.SSFrame SSFrame1 
         Height          =   5250
         Left            =   60
         TabIndex        =   24
         Top             =   570
         Width           =   6825
         _Version        =   65536
         _ExtentX        =   12039
         _ExtentY        =   9260
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
         Begin VB.TextBox TxtCodigoIDD 
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
            Left            =   2235
            MaxLength       =   4
            TabIndex        =   15
            Top             =   2100
            Width           =   1320
         End
         Begin VB.TextBox txtCodSinacofi 
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
            Left            =   2235
            MaxLength       =   5
            TabIndex        =   52
            Top             =   1770
            Width           =   1335
         End
         Begin VB.TextBox CodigoSwift 
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
            Left            =   4035
            MaxLength       =   5
            TabIndex        =   46
            Top             =   120
            Width           =   1065
         End
         Begin BACControles.TXTNumero intPaisBCCH 
            Height          =   315
            Left            =   2235
            TabIndex        =   39
            Top             =   1455
            Width           =   1335
            _ExtentX        =   2355
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
            Text            =   "0"
            Text            =   "0"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero intCsBancos 
            Height          =   315
            Left            =   2235
            TabIndex        =   38
            Top             =   1140
            Width           =   1335
            _ExtentX        =   2355
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
            Text            =   "0"
            Text            =   "0"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero intCodBCCH 
            Height          =   315
            Left            =   5220
            TabIndex        =   37
            Top             =   1140
            Width           =   1515
            _ExtentX        =   2672
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
            Text            =   "0"
            Text            =   "0"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin BACControles.TXTNumero itbRedondeo 
            Height          =   315
            Left            =   6240
            TabIndex        =   36
            Top             =   120
            Width           =   465
            _ExtentX        =   820
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
            Text            =   "0"
            Text            =   "0"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.TextBox txtCODIGOFOX 
            Alignment       =   1  'Right Justify
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
            Left            =   5220
            TabIndex        =   11
            Top             =   1470
            Width           =   1515
         End
         Begin VB.CheckBox Check3 
            Alignment       =   1  'Right Justify
            Caption         =   "Fuerte"
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
            Height          =   195
            Left            =   180
            TabIndex        =   12
            Top             =   2700
            Width           =   1380
         End
         Begin VB.CheckBox Check2 
            Alignment       =   1  'Right Justify
            Caption         =   "Referencial Mercado"
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
            Height          =   195
            Left            =   4200
            TabIndex        =   14
            Top             =   2700
            Width           =   2175
         End
         Begin VB.CheckBox Check1 
            Alignment       =   1  'Right Justify
            Caption         =   "Extranjera"
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
            Height          =   195
            Left            =   2280
            TabIndex        =   13
            Top             =   2700
            Width           =   1275
         End
         Begin VB.TextBox txtNemo 
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
            Left            =   1395
            MaxLength       =   5
            TabIndex        =   2
            Top             =   120
            Width           =   1005
         End
         Begin VB.TextBox txtSimbolo 
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
            Left            =   2235
            MaxLength       =   5
            TabIndex        =   4
            Top             =   480
            Width           =   1335
         End
         Begin VB.ComboBox cmbPeriodo 
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
            Left            =   2235
            Style           =   2  'Dropdown List
            TabIndex        =   6
            Top             =   825
            Width           =   1335
         End
         Begin VB.ComboBox CmbTipoMoneda 
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
            Left            =   5220
            Style           =   2  'Dropdown List
            TabIndex        =   7
            Top             =   810
            Width           =   1515
         End
         Begin VB.ComboBox TXTBASE 
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
            ItemData        =   "Bacmntmn.frx":14EC
            Left            =   5235
            List            =   "Bacmntmn.frx":14F9
            Style           =   2  'Dropdown List
            TabIndex        =   5
            Top             =   480
            Width           =   1515
         End
         Begin Threed.SSFrame SSFrame3 
            Height          =   1335
            Left            =   60
            TabIndex        =   10
            Top             =   2460
            Width           =   6690
            _Version        =   65536
            _ExtentX        =   11800
            _ExtentY        =   2355
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
            ShadowStyle     =   1
            Begin VB.TextBox Canasta 
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
               Left            =   5160
               TabIndex        =   44
               Top             =   525
               Width           =   375
            End
            Begin BACControles.TXTNumero CtaCambios 
               Height          =   300
               Left            =   2160
               TabIndex        =   42
               Top             =   885
               Width           =   1335
               _ExtentX        =   2355
               _ExtentY        =   529
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
               MarcaTexto      =   -1  'True
            End
            Begin BACControles.TXTNumero txtLimite 
               Height          =   315
               Left            =   2160
               TabIndex        =   40
               Top             =   525
               Width           =   1335
               _ExtentX        =   2355
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
               Text            =   "0"
               Text            =   "0"
               Separator       =   -1  'True
               MarcaTexto      =   -1  'True
            End
            Begin VB.Label Label4 
               AutoSize        =   -1  'True
               Caption         =   "Canasta"
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
               Height          =   195
               Left            =   3720
               TabIndex        =   43
               Top             =   570
               Width           =   705
            End
            Begin VB.Label Label3 
               AutoSize        =   -1  'True
               Caption         =   "Cta. Cambios"
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
               Height          =   195
               Left            =   120
               TabIndex        =   41
               Top             =   915
               Width           =   1125
            End
            Begin VB.Label lblLimite 
               AutoSize        =   -1  'True
               Caption         =   "Limite de Posicion"
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
               Height          =   195
               Left            =   120
               TabIndex        =   3
               Top             =   570
               Width           =   1560
            End
         End
         Begin BACControles.TXTNumero TxtDecArbitrajes 
            Height          =   315
            Left            =   5220
            TabIndex        =   50
            Top             =   1800
            Width           =   1515
            _ExtentX        =   2672
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
            Text            =   "0"
            Text            =   "0"
            Min             =   "0"
            Max             =   "20"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin Threed.SSFrame Frame 
            Height          =   1455
            Left            =   60
            TabIndex        =   26
            Top             =   3750
            Visible         =   0   'False
            Width           =   6705
            _Version        =   65536
            _ExtentX        =   11827
            _ExtentY        =   2566
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
            Begin VB.TextBox txtCodBancoComp 
               Alignment       =   1  'Right Justify
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
               Left            =   720
               MaxLength       =   8
               TabIndex        =   8
               Top             =   1020
               Width           =   1515
            End
            Begin VB.TextBox txtCodBancoVent 
               Alignment       =   1  'Right Justify
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
               Left            =   4440
               MaxLength       =   8
               TabIndex        =   25
               Top             =   1005
               Width           =   1515
            End
            Begin VB.TextBox txtCodCorrVent 
               Alignment       =   1  'Right Justify
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
               Left            =   4440
               MaxLength       =   8
               TabIndex        =   9
               Top             =   405
               Width           =   1515
            End
            Begin VB.TextBox txtCodCorrComp 
               Alignment       =   1  'Right Justify
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
               Left            =   720
               MaxLength       =   8
               TabIndex        =   22
               Top             =   420
               Width           =   1515
            End
            Begin VB.Label Label7 
               AutoSize        =   -1  'True
               Caption         =   "Código Banco Compra"
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
               Height          =   195
               Left            =   510
               TabIndex        =   51
               Top             =   780
               Width           =   1890
            End
            Begin VB.Label Label6 
               AutoSize        =   -1  'True
               Caption         =   "Código Banco Venta"
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
               Height          =   195
               Left            =   4260
               TabIndex        =   16
               Top             =   780
               Width           =   1755
            End
            Begin VB.Label Label2 
               AutoSize        =   -1  'True
               Caption         =   "Código Corresponsal Venta"
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
               Height          =   195
               Left            =   3960
               TabIndex        =   27
               Top             =   180
               Width           =   2310
            End
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               Caption         =   "Código Corresponsal Compra"
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
               Height          =   195
               Left            =   210
               TabIndex        =   28
               Top             =   180
               Width           =   2445
            End
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Código IDD"
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
            Height          =   195
            Index           =   12
            Left            =   75
            TabIndex        =   54
            Top             =   2190
            Width           =   975
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Código SINACOFI"
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
            Height          =   195
            Index           =   11
            Left            =   90
            TabIndex        =   17
            Top             =   1875
            Width           =   1500
         End
         Begin VB.Label LblDecArbitrajes 
            AutoSize        =   -1  'True
            Caption         =   "N° Dec Arbitraje"
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
            Height          =   195
            Index           =   11
            Left            =   3750
            TabIndex        =   49
            Top             =   1860
            Width           =   1395
         End
         Begin VB.Label Label5 
            AutoSize        =   -1  'True
            Caption         =   "Codigo Swift"
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
            Height          =   195
            Left            =   2565
            TabIndex        =   45
            Top             =   195
            Width           =   1080
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Código Contable"
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
            Height          =   195
            Index           =   10
            Left            =   3735
            TabIndex        =   34
            Top             =   1530
            Width           =   1410
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Codigo Pais Mon. BCCH "
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
            Height          =   195
            Index           =   9
            Left            =   90
            TabIndex        =   33
            Top             =   1530
            Width           =   2115
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Código  BCCH"
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
            Height          =   195
            Index           =   8
            Left            =   3735
            TabIndex        =   32
            Top             =   1215
            Width           =   1215
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Nemotécnico  "
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
            Height          =   195
            Index           =   1
            Left            =   90
            TabIndex        =   31
            Top             =   195
            Width           =   1245
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "ISO CODES"
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
            Height          =   195
            Index           =   2
            Left            =   90
            TabIndex        =   30
            Top             =   555
            Width           =   1020
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Redondeo"
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
            Height          =   195
            Index           =   4
            Left            =   5220
            TabIndex        =   29
            Top             =   165
            Width           =   885
         End
         Begin VB.Label Label 
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
            ForeColor       =   &H80000007&
            Height          =   195
            Index           =   5
            Left            =   3735
            TabIndex        =   18
            Top             =   555
            Width           =   435
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Periodo"
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
            Height          =   195
            Index           =   3
            Left            =   90
            TabIndex        =   19
            Top             =   855
            Width           =   660
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Tipo Moneda "
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
            Height          =   195
            Index           =   6
            Left            =   3735
            TabIndex        =   47
            Top             =   855
            Width           =   1185
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Código  SUPER"
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
            Height          =   195
            Index           =   7
            Left            =   90
            TabIndex        =   48
            Top             =   1200
            Width           =   1350
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   555
         Left            =   75
         TabIndex        =   35
         Top             =   15
         Width           =   6810
         _Version        =   65536
         _ExtentX        =   12012
         _ExtentY        =   979
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
         ShadowStyle     =   1
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Código Moneda "
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
            Height          =   195
            Index           =   0
            Left            =   105
            TabIndex        =   21
            Top             =   210
            Width           =   1395
         End
      End
   End
   Begin VB.ComboBox cmbBase 
      BackColor       =   &H00FFFFFF&
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
      Left            =   5415
      Style           =   2  'Dropdown List
      TabIndex        =   53
      Top             =   6480
      Visible         =   0   'False
      Width           =   1500
   End
End
Attribute VB_Name = "BacMntMn"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Categoria       As Integer
Dim Codigo          As String
Dim CodigoFox       As String
Dim CodigoCor       As Double
Dim ValorFox        As Integer
Dim sql             As String
Dim Tasa            As Double
Dim Sw              As Integer
Dim Datos()

Private Sub Habilitacontroles(Valor As Integer)
    On Error GoTo ErrroHabilitacion
    
    txtCodigo.Enabled = Not Valor
    txtNemo.Enabled = Valor
    txtSimbolo.Enabled = Valor
    txtGlosaMoneda.Enabled = Valor
    itbRedondeo.Enabled = Valor
    cmbBase.Enabled = Valor
    TXTBASE.Enabled = Valor
    CmbTipoMoneda.Enabled = Valor
    cmbPeriodo.Enabled = Valor
    intCsBancos.Enabled = Valor
    intCodBCCH.Enabled = Valor
    intPaisBCCH.Enabled = Valor
    txtCODIGOFOX.Enabled = Valor
    Toolbar1.Buttons(1).Enabled = Valor
    Toolbar1.Buttons(2).Enabled = Valor
    Toolbar1.Buttons(3).Enabled = Valor
    Check1.Enabled = Valor
    Check2.Enabled = Valor
    Check3.Enabled = Valor
    CtaCambios.Enabled = Valor
    Canasta.Enabled = Valor
    txtLimite.Enabled = Valor
    CodigoSwift.Enabled = Valor
    
    txtCodCorrComp.Enabled = Valor
    txtCodCorrVent.Enabled = Valor
        
    txtCodBancoComp.Enabled = Valor
    txtCodBancoVent.Enabled = Valor
    
    TxtDecArbitrajes.Enabled = Valor    '--> PRD-16772
    If Valor = True And (txtCodigo.Text = 13 Or txtCodigo.Text = 994 Or txtCodigo.Text = 995 Or txtCodigo.Text = 998 Or txtCodigo.Text = 999) Then
        TxtDecArbitrajes.Enabled = Not Valor    '--> PRD-16772
    End If
    If Valor = True And Trim(Right(CmbTipoMoneda.Text, 5)) <> 2 Then
        TxtDecArbitrajes.Text = "0"
        TxtDecArbitrajes.Enabled = Not Valor    '--> PRD-16772
    End If
    
    '-> LD1_035_IDD
    txtCodSinacofi.Enabled = Valor
    TxtCodigoIDD.Enabled = Valor
    '-> LD1_035_IDD
        
Exit Sub
ErrroHabilitacion:
     
End Sub

Private Function ValidaDatos() As Integer
    On Error GoTo ErrorValidacion
    Dim oMensaje    As String
    
    ValidaDatos = False
    oMensaje = ""
    
    If Val(txtCodigo.Text) = 0 Then
        oMensaje = oMensaje & "- Código de la moneda no es valido." & vbCrLf
    End If
    If Trim(txtGlosaMoneda.Text) = "" Then
        oMensaje = oMensaje & "- Descripción se encuentra en blanco" & vbCrLf
    End If
    If Trim(txtNemo.Text) = "" Then
       oMensaje = oMensaje & "- Nemotecnico se encuentra en blanco." & vbCrLf
    End If
    If Trim(txtSimbolo.Text) = "" Then
        oMensaje = oMensaje & "- Simbolo en blanco." & vbCrLf
    End If
    If Trim(txtCODIGOFOX.Text) = "" Then
        oMensaje = oMensaje & "- Código contable en blanco." & vbCrLf
    End If
'    If Trim(txtCodSinacofi.Text) = "" Then
'        oMensaje = oMensaje & "- Código Sinacofi en blanco." & vbCrLf
'    End If
    
    If Check1.Value = 1 Then
        If Trim(txtCodCorrComp.Text) = "" Then
            oMensaje = oMensaje & "- Código corresponsal de compra en blanco." & vbCrLf
        ElseIf Val(txtCodCorrComp.Text) = 0 Then
            oMensaje = oMensaje & "- Código corresponsal de compra en Cero." & vbCrLf
        End If
    End If
    
    If Check1.Value = 1 Then
        If Trim(txtCodCorrVent.Text) = "" Then
            oMensaje = oMensaje & "- Código corresponsal de venta en blanco." & vbCrLf
        ElseIf Val(txtCodCorrVent.Text) = 0 Then
            oMensaje = oMensaje & "- Código corresponsal de venta en Cero." & vbCrLf
        End If
    End If
    
    If Check1.Value = 1 Then
        If Trim(txtCodBancoComp.Text) = "" Then
            oMensaje = oMensaje & "- Código banco de compra en blanco." & vbCrLf
        ElseIf Val(txtCodBancoComp.Text) = 0 Then
            oMensaje = oMensaje & "- Código banco de compra en cero." & vbCrLf
        End If
    End If
    
    If Check1.Value = 1 Then
        If Trim(txtCodBancoVent.Text) = "" Then
            oMensaje = oMensaje & "- Código banco de venta en blanco." & vbCrLf
        ElseIf Val(txtCodBancoVent.Text) = 0 Then
            oMensaje = oMensaje & "- Código banco de venta en cero." & vbCrLf
        End If
    End If
    
    If Check1.Value = 0 Then
       txtCodCorrComp.Text = 0
       txtCodCorrVent.Text = 0
       txtCodBancoComp.Text = 0
       txtCodBancoVent.Text = 0
    End If
    
    '-> LD1_035_IDD
    If Len(TxtCodigoIDD.Text) = 0 Then
        oMensaje = oMensaje & "- Código IDD, no debe estar en Blanco." & vbCrLf
    End If
    '-> LD1_035_IDD
    
    If Trim(oMensaje) = "" Then
        ValidaDatos = True
    Else
        MsgBox "Se han encontrado las sgts. anomalias :" & vbCrLf & vbCrLf & oMensaje, vbExclamation, TITSISTEMA
    End If
    
Exit Function
ErrorValidacion:
    MsgBox "Ha habido un Error en la validación de la información.", vbExclamation, TITSISTEMA
    Resume
End Function

Private Sub cmdEliminar()
    On Error GoTo ErrorEliminacion
    
    Dim texto As String
        
    If MsgBox("¿ Esta seguro que desea eliminar permanente mente los datos expuestos de la moneda ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
       Exit Sub
    End If
    
    Envia = Array()
    AddParam Envia, CDbl(txtCodigo.Text)
    If Not Bac_Sql_Execute("SP_BACMNTMN_ELIMINAR", Envia) Then
        MsgBox "Error Al Ejecutar Procedimiento", vbCritical, TITSISTEMA
        Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_31 ", "09", "Error Al Ejecutar Procedimiento", " ", " ", " ")
        Exit Sub
    End If
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) = "OK" Then
            MsgBox "La Moneda ha sido Eliminada", vbInformation, TITSISTEMA
            texto = "La Moneda ha sido Eliminada"
        End If
    Else
        MsgBox "La Moneda no se ha podido Eliminar", vbCritical, TITSISTEMA
        texto = "La Moneda no se ha podido Eliminar"
    End If
    
    Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_31 ", "03", texto, " ", " ", " ")
    Call Limpiar
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    txtCodigo.SetFocus

Exit Sub
ErrorEliminacion:
    MsgBox "Se ha producido un error en la Eliminación de la información", vbExclamation, TITSISTEMA
End Sub

Private Sub Limpiar()
    txtCodigo.Text = ""
    txtGlosaMoneda.Text = ""
    txtNemo.Text = ""
    txtSimbolo.Text = ""
    cmbPeriodo.ListIndex = -1
    intCsBancos.Text = ""
    intCodBCCH.Text = ""
    itbRedondeo.Text = ""
    intPaisBCCH.Text = ""
    CmbTipoMoneda.ListIndex = -1
    txtCODIGOFOX.Text = ""
    Check1.Value = 0
    Check2.Value = 0
    Check3.Value = 0
    CtaCambios.Text = ""
    txtLimite.Text = ""
    Canasta = ""
    CodigoSwift.Text = ""
    txtCodBancoVent.Text = ""
    txtCodBancoComp.Text = ""
    txtCodSinacofi.Text = ""
    
    TxtDecArbitrajes.Text = 0   '--> PRD-16772
    
    '-> LD1_035_IDD
    txtCodSinacofi.Text = ""
    TxtCodigoIDD.Text = ""
    '-> LD1_035_IDD
    
    Call Habilitacontroles(False)
End Sub

Private Sub cmdGrabar()
    On Error GoTo ErrorGrabacion
    
    Dim sql     As String
    Dim IdNum   As Long
    Dim Datos()
    Dim mone
    Dim ref
    Dim refusd
    
    If ValidaDatos() = False Then
        Screen.MousePointer = 0
        Me.MousePointer = 0
        Exit Sub
    End If
    If Check1.Value = 1 Then
        mone = 1
    Else
        mone = 0
    End If
    If Check2.Value = 1 Then
        ref = 1
    Else
        ref = 0
    End If
    If Check3.Value = 1 Then
        refusd = 1
    Else
        refusd = 0
    End If
        
    Screen.MousePointer = 11
    If CodigoCor = 0 Then
        Call Genera_Codigo_Cor
    End If
    
    Envia = Array()
    AddParam Envia, CDbl(txtCodigo.Text)
    AddParam Envia, Trim(txtNemo.Text)
    AddParam Envia, Trim(txtSimbolo.Text)
    AddParam Envia, Trim(txtGlosaMoneda.Text)
    AddParam Envia, CDbl(itbRedondeo.Text)
    AddParam Envia, CDbl(TXTBASE.Text)
    AddParam Envia, Trim(Right(CmbTipoMoneda.Text, 5))
    AddParam Envia, CDbl(Trim(Right(cmbPeriodo, 5)))
    AddParam Envia, CDbl(intCsBancos.Text)
    AddParam Envia, Trim(txtCODIGOFOX.Text)
    AddParam Envia, CDbl(CodigoCor)
    AddParam Envia, CDbl(intCodBCCH.Text)
    AddParam Envia, CDbl(intPaisBCCH.Text)
    AddParam Envia, mone
    AddParam Envia, ref
    AddParam Envia, refusd
    AddParam Envia, CDbl(txtLimite.Text)
    AddParam Envia, CDbl(txtCodCorrVent.Text)
    AddParam Envia, CDbl(txtCodCorrComp.Text)
    AddParam Envia, Mid(CtaCambios.Text, 1, 10)
    AddParam Envia, Mid(Canasta.Text, 1, 2)
    AddParam Envia, Mid(CodigoSwift.Text, 1, 5)
    AddParam Envia, CDbl(txtCodBancoVent.Text)
    AddParam Envia, CDbl(txtCodBancoComp.Text)
    AddParam Envia, CDbl(0)                         '--> @MnCodDcv
    AddParam Envia, CDbl(TxtDecArbitrajes.Text)     '--> PRD-16772
    '============================================================================
    ' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Interfaz TCRC917-TCRC915
    ' INICIO
    '============================================================================
    AddParam Envia, txtCodSinacofi.Text
    '============================================================================
    ' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Interfaz TCRC917-TCRC915
    ' FIN
    '============================================================================
    
    '-> LD1_035_IDD
    AddParam Envia, UCase(TxtCodigoIDD.Text)
    '-> LD1_035_IDD
    
    
    If Not Bac_Sql_Execute("SP_MNGRABAR ", Envia) Then
        Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_31 ", "03", "Error Grabación Monedas SQL (SP_MNGRABAR) ", " ", " ", " ")
        Call MsgBox("Error en la Grabación", vbOKOnly + vbExclamation, TITSISTEMA)
        Let Screen.MousePointer = vbDefault
        Exit Sub
    End If

    If Bac_SQL_Fetch(Datos()) Then
        Let Screen.MousePointer = vbDefault
        Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_31 ", "01", "Grabacion De Monedas Correcta ", " ", " ", " ")
        Call MsgBox("Operación se realizó con exito ", vbInformation, TITSISTEMA)

        Call Limpiar

        txtCodigo.SetFocus
        Exit Sub
    Else
        Let Screen.MousePointer = vbDefault
        Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_31 ", "03", "Error en Grabacion De Monedas ", " ", " ", " ")
        Call MsgBox("Error en la Grabación", vbOKOnly + vbExclamation, TITSISTEMA)

        Call Habilitacontroles(False)
        txtCodigo.SetFocus
    End If

Exit Sub
ErrorGrabacion:
    Let Screen.MousePointer = vbDefault
    Call Limpiar
    Call Habilitacontroles(False)
    Call txtCodigo.SetFocus
End Sub

Sub Genera_Codigo_Num()
    Dim intCodPas   As String
    Dim sql         As String
    Dim Genera      As Boolean
    Dim Datos()

    intCodPas = CDbl(txtCodigo.Text)
    Genera = True
    
    Do While Genera
        Envia = Array()
        AddParam Envia, CDbl(intCodPas)
        If Not Bac_Sql_Execute("SP_GENERA_CODIGO", Envia) Then
            Exit Sub
        End If
        If Bac_SQL_Fetch(Datos()) Then
            intCodPas = CDbl(txtCodigo.Text) + 1    '--> Si esta
        Else
            Genera = False                          '--> No esta
            ValorFox = intCodPas
        End If
    Loop
    
End Sub

Sub Genera_Codigo_Cor()
    Dim sql As String
    Dim Datos()
     
    If Not Bac_Sql_Execute("SP_GENERA_COD") Then
        Exit Sub
    End If
    If Bac_SQL_Fetch(Datos()) Then
        CodigoCor = CDbl(Datos(1)) + 1
    End If
End Sub


Private Sub Check1_Click()
    If Check1.Value = 1 Then
        Check2.Value = 0
        Frame.Visible = True
    Else
        Check2.Value = 1
        Frame.Visible = False
    End If
End Sub

Private Sub Check1_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        Check2.SetFocus
    End If
End Sub
Private Sub Check2_Click()
    If Check2.Value = 1 Then
         Check1.Value = 0
    End If
End Sub

Private Sub Check2_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        txtGlosaMoneda.SetFocus
    End If
End Sub

Private Sub Check3_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        Check1.SetFocus
    End If
End Sub

Private Sub cmbPeriodo_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        CmbTipoMoneda.SetFocus
    End If
End Sub

Private Sub CmbTipoMoneda_Click()
    
    '--> PRD-16772
    If CmbTipoMoneda.ListIndex < 0 Then
        Exit Sub
    End If

    '   Tipo de Moneda      --> OBJ : CmbTipoMoned;  TYP : ComboBox;    LOAD : Llenar_Combos --> MDMN_TIPOMONEDA = 217
    '                       --> BD  : (Select tbcodigo1, tbglosa From BacParamSuda.dbo.Tabla_General_Detalle Where TbCateg = 217) -> By Sid
    '   1  -->  Tasa
    '   2  -->  Divisa
    '   3  -->  Precio
    
    Let TxtDecArbitrajes.Text = 0
    Let TxtDecArbitrajes.Enabled = False

    If Trim(Right(CmbTipoMoneda.List(CmbTipoMoneda.ListIndex), 4)) = 2 Then
        '-> Definicion de Decimales para el Arbitraje Forward (N° Decimales)
        Let TxtDecArbitrajes.Text = IIf(TxtDecArbitrajes.Text = 0, 1, TxtDecArbitrajes.Text)
        Let TxtDecArbitrajes.Enabled = True
    End If
    '--> PRD-16772

End Sub

Private Sub CmbTipoMoneda_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        intCsBancos.SetFocus
    End If
End Sub

Private Sub CodigoSwift_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
         itbRedondeo.SetFocus
    End If
End Sub

Private Sub Canasta_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
Private Sub CodigoSwift_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub Form_Load()
    Me.Top = 0: Me.Left = 0
    Sw = 0
    
    Call Grabar_Log_AUDITORIA(gsEntidad, gsbac_fecp, gsBac_IP, gsUsuario, "PCA", "opc_31", "07", "Usuario entra en Mantenedor de monedas", " ", " ", " ")
    
    On Error GoTo ErrroInicializacion
    
    Call Habilitacontroles(False)
    
    If Not Llenar_Combos(cmbPeriodo, MDMN_PERIODO) Then       'Código 216
        MsgBox "Combo se encuentra vacio ", vbCritical, TITSISTEMA
        CODI = 10000
        Unload Me
        Exit Sub
    End If
    cmbPeriodo.ListIndex = 0
    If Not Llenar_Combos(CmbTipoMoneda, MDMN_TIPOMONEDA) Then       'Código 216
        MsgBox "Combo se encuentra vacio ", vbCritical, TITSISTEMA
        Unload Me
        Exit Sub
    End If
    CmbTipoMoneda.ListIndex = 0
    
Exit Sub
ErrroInicializacion:
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
    Unload Me
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call Grabar_Log_AUDITORIA(gsEntidad, gsbac_fecp, gsBac_IP, gsUsuario, "PCA", "opc_31", "08", "Usuario Cierra Mantenedor de monedas", " ", " ", " ")
End Sub

Private Sub intCodBCCH_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        intPaisBCCH.SetFocus
    End If
End Sub

Private Sub intCsBancos_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        intCodBCCH.SetFocus
    End If
End Sub

Private Sub intPaisBCCH_DblClick()
    BacAyuda.Tag = "PAIS"
    BacAyuda.Show 1
    If giAceptar% = True Then
        intPaisBCCH.Text = gsCodigo$
        'Call Habilitacontroles(True)
        Screen.MousePointer = 0
        Me.MousePointer = 0
    End If
End Sub

Private Sub intPaisBCCH_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode
        Case vbKeyF1
            BacAyuda.Tag = "PAIS"
            BacAyuda.Show 1
            If giAceptar% = True Then
                intPaisBCCH.Text = gsCodigo$
                Screen.MousePointer = 0
                Me.MousePointer = 0
            End If
        Case vbKeyReturn
            txtCODIGOFOX.SetFocus
    End Select
End Sub

Private Sub itbRedondeo_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        txtSimbolo.SetFocus
    End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Dim texto As String

    Select Case Button.Index
        Case 1
            Call cmdGrabar
        Case 2
            Call cmdEliminar
        Case 3
            Call Limpiar
            txtCodigo.SetFocus
        Case 4
            Unload Me
    End Select
End Sub

Private Sub TXTBASE_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        cmbPeriodo.SetFocus
    End If
End Sub

Private Sub txtCodBancoComp_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 And txtCodBancoComp.Text <> "" Then
       txtCodBancoVent.SetFocus
    ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
        KeyAscii = 0
    End If
End Sub

Private Sub txtCodBancoVent_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 And txtCodBancoVent.Text <> "" Then
       txtCodBancoVent.SetFocus
    ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
        KeyAscii = 0
    End If
End Sub

Private Sub txtCodCorrComp_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 And txtCodCorrComp.Text <> "" Then
       txtCodCorrVent.SetFocus
    ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
        KeyAscii = 0
    End If
End Sub

Private Sub txtCodCorrVent_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 And txtCodCorrVent.Text <> "" Then
       txtCodBancoComp.SetFocus
    ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
        KeyAscii = 0
    End If
End Sub

Private Sub txtCodigo_DblClick()
    auxilio = 100
    Call CodigoMo
    If txtCodigo.Enabled = True Then
        txtCodigo.SetFocus
    End If
End Sub

Sub CodigoMo()
    On Error GoTo ErrorCodigoMoneda
    MousePointer = 11
    Call Limpiar
    
    BacAyuda.Tag = "MDMN"
    BacAyuda.Show 1
    
    If giAceptar% = True Then
        txtCodigo.Text = gsCodigo$
        Call Habilitacontroles(True)
        TxtCodigo_LostFocus
    End If
    
    MousePointer = 0
   'txtGlosaMoneda.SetFocus
Exit Sub
ErrorCodigoMoneda:
    MsgBox Err.Description, vbExclamation, TITSISTEMA
End Sub

Private Sub txtcodigo_GotFocus()
    Sw = 1
End Sub

Private Sub txtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF3 Then
        Call CodigoMo
        txtCodigo.SetFocus
        Exit Sub
    End If
    If KeyCode = vbKeyReturn Then
        KeyCode = 0
        Call TxtCodigo_LostFocus
    
        If txtGlosaMoneda.Enabled = True Then
            txtGlosaMoneda.SetFocus
        End If
    End If
End Sub


Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
    If KeyAscii = 8 Or KeyAscii = 13 Then
    
    Else
        If Not IsNumeric(Chr(KeyAscii)) Then
            KeyAscii = 0
        End If
    End If
End Sub

Private Sub TxtCodigo_LostFocus()
    On Error GoTo ErrorCodigoMn
    Dim IDCodigo As Long
    
    MousePointer = 11
    If txtCodigo.Text = "" Then
        MousePointer = 0
        Exit Sub
    End If
    If CDbl(txtCodigo.Text) = 0 Then
        MousePointer = 0
        Exit Sub
    End If
    IDCodigo = txtCodigo.Text
    Call LeerPorCodigo(IDCodigo)
    Habilitacontroles True
    MousePointer = 0
Exit Sub
ErrorCodigoMn:
    If swa <> 1000 Then
        MousePointer = 0
        txtNemo.Enabled = True
        txtSimbolo.Enabled = True
        txtCodigo.Enabled = False
        txtGlosaMoneda.Enabled = False
        itbRedondeo.Enabled = True
        TXTBASE.Enabled = True
        CmbTipoMoneda.Enabled = True
        cmbPeriodo.Enabled = True
        intCsBancos.Enabled = True
        txtCODIGOFOX.Enabled = True
        intCodBCCH.Enabled = True
        intPaisBCCH.Enabled = True
        
        TxtDecArbitrajes.Enabled = True   '--> PRD-16772
        
        '-> LD1_035_IDD
        txtCodSinacofi.Enabled = True
        TxtCodigoIDD.Enabled = True
        '-> LD1_035_IDD
        
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = True
        Toolbar1.Buttons(3).Enabled = True
    Else
        MousePointer = 0
        txtGlosaMoneda.Enabled = True
        txtNemo.Enabled = True
        txtSimbolo.Enabled = True
        txtCodigo.Enabled = True
        txtGlosaMoneda.Enabled = True
        itbRedondeo.Enabled = True
        TXTBASE.Enabled = True
        CmbTipoMoneda.Enabled = True
        cmbPeriodo.Enabled = True
        intCsBancos.Enabled = True
        txtCODIGOFOX.Enabled = True
        intCodBCCH.Enabled = True
        intPaisBCCH.Enabled = True
        
        TxtDecArbitrajes.Enabled = True   '--> PRD-16772
        
        '-> LD1_035_IDD
        txtCodSinacofi.Enabled = True
        TxtCodigoIDD.Enabled = True
        '-> LD1_035_IDD
        
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = True
        Toolbar1.Buttons(3).Enabled = True
    End If
    Sw = 0
End Sub

Private Function LeerPorCodigo(CodMon As Long) As Boolean
    Dim sql     As String
    Dim Datos()
    
    LeerPorCodigo = False
    
    Envia = Array()
    AddParam Envia, CodMon
    If Not Bac_Sql_Execute("SP_MNLEER ", Envia) Then
       MsgBox "no se ejecuto la consulta", vbCritical
       Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        txtNemo.Text = Datos(2)
        txtSimbolo.Text = Datos(3)
        txtGlosaMoneda.Text = Datos(4)
        itbRedondeo.Text = Datos(5)
        TXTBASE.Enabled = True
      
        txtLimite.Text = Datos(17) 'Arreglado
        TXTBASE.Text = Val(Datos(6))
        If Datos(7) <> "" Then
            CmbTipoMoneda.ListIndex = IIf(BuscaEnCombo(CmbTipoMoneda, Str(CDbl(Datos(7))), "C") = -1, 0, BuscaEnCombo(CmbTipoMoneda, Str(Datos(7)), "C")) ''''''' ARREGLAR
        End If
      
        cmbPeriodo.ListIndex = IIf(BuscaEnCombo(cmbPeriodo, Str(CDbl(Datos(9))), "C") = -1, 0, BuscaEnCombo(cmbPeriodo, Str(CDbl(Datos(9))), "C"))
        intCsBancos.Text = Datos(10)
        txtCODIGOFOX.Text = Datos(11)
        CodigoCor = Datos(13)
        intCodBCCH.Text = Datos(8)
        intPaisBCCH.Text = Datos(12)
        
        txtCodCorrComp.Text = "0" & Datos(18)
        txtCodCorrVent.Text = "0" & Datos(19)
        txtCodBancoComp.Text = "0" & Datos(23)
        txtCodBancoVent.Text = "0" & Datos(24)
     
        CtaCambios.Text = Datos(20)
        
        Canasta.Text = Datos(21)
        CodigoSwift.Text = Datos(22)
      
        If Datos(14) = 1 Then
            Check1.Value = 1
        Else
            Check1.Value = 0
        End If
        If Datos(15) = 1 Then
            Check2.Value = 1
        Else
            Check2.Value = 0
        End If
        If Datos(16) = 1 Then
            Check3.Value = 1
        Else
            Check3.Value = 0
        End If
        
        TxtDecArbitrajes.Text = Datos(26)
        '============================================================================
        ' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Interfaz TCRC917-TCRC915
        ' INICIO
        '============================================================================
        txtCodSinacofi.Text = Datos(27)
         '============================================================================
        ' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Interfaz TCRC917-TCRC915
        ' FIN
        '============================================================================
        
        '-> LD1_035_IDD
        TxtCodigoIDD.Text = Datos(28)
        '-> LD1_035_IDD
        
    Else
        swa = 1000
        txtNemo.Text = " "
        txtGlosaMoneda.Text = ""
        txtSimbolo.Text = ""
        itbRedondeo.Text = 0
        TXTBASE.ListIndex = -1
        CmbTipoMoneda.ListIndex = 0
        cmbPeriodo.ListIndex = 0
        intCsBancos.Text = 0
        txtCODIGOFOX.Text = ""
        'txtGlosaMoneda.SetFocus
        CtaCambios.Text = ""
        Canasta.Text = ""
        
        TxtDecArbitrajes.Text = 0   '--> PRD-16772
        
        '============================================================================
        ' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Interfaz TCRC917-TCRC915
        ' INICIO
        '============================================================================
        txtCodSinacofi.Text = ""
        '============================================================================
        ' LD1-COR-035-Configuración BAC Corpbanca  , Tema: Interfaz TCRC917-TCRC915
        ' FIN
        '============================================================================
        
        '-> LD1_035_IDD
        TxtCodigoIDD.Text = ""
        '-> LD1_035_IDD
    End If
       
    If Check1.Value = 1 Then
        Frame.Visible = True
    Else
        Frame.Visible = False
    End If
    
    LeerPorCodigo = True
    
End Function

Private Sub txtCODIGOFOX_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn And Check3.Enabled = True Then
        Check3.SetFocus
    End If
End Sub


Private Sub txtGlosaMoneda_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        txtNemo.SetFocus
    End If
End Sub

Private Sub txtGlosaMoneda_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txtNemo_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        CodigoSwift.SetFocus
    End If
End Sub

Private Sub txtNemo_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txtSimbolo_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        TXTBASE.SetFocus
    End If
End Sub

Private Sub txtSimbolo_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

'-> LD1_035_IDD
Private Sub TxtCodigoIDD_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
'-> LD1_035_IDD
