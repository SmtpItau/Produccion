VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form BacMntCl 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención de Cliente"
   ClientHeight    =   6990
   ClientLeft      =   1665
   ClientTop       =   1755
   ClientWidth     =   8220
   Icon            =   "Bacmntcl.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6990
   ScaleWidth      =   8220
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3870
      Top             =   90
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
            Picture         =   "Bacmntcl.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntcl.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntcl.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntcl.frx":0EC8
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntcl.frx":11E2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   30
      TabIndex        =   43
      Top             =   -30
      Width           =   5625
      _ExtentX        =   9922
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
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
            Object.ToolTipText     =   "Relación"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   6405
      Left            =   0
      TabIndex        =   45
      Top             =   540
      Width           =   8115
      _Version        =   65536
      _ExtentX        =   14314
      _ExtentY        =   11298
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox txtgeneric 
         ForeColor       =   &H00800000&
         Height          =   285
         Left            =   4680
         MaxLength       =   5
         TabIndex        =   4
         Top             =   105
         Width           =   1185
      End
      Begin VB.TextBox txtrut 
         Alignment       =   1  'Right Justify
         ForeColor       =   &H00800000&
         Height          =   285
         Left            =   885
         MaxLength       =   9
         MouseIcon       =   "Bacmntcl.frx":14FC
         MousePointer    =   99  'Custom
         MultiLine       =   -1  'True
         TabIndex        =   1
         Top             =   105
         Width           =   1140
      End
      Begin VB.TextBox txtDigito 
         ForeColor       =   &H00800000&
         Height          =   285
         Left            =   2115
         MaxLength       =   1
         TabIndex        =   2
         Top             =   105
         Width           =   255
      End
      Begin VB.TextBox TxtNombre 
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
         Height          =   285
         Left            =   165
         MaxLength       =   40
         TabIndex        =   9
         TabStop         =   0   'False
         Top             =   795
         Visible         =   0   'False
         Width           =   7545
      End
      Begin VB.TextBox Txt1Nombre 
         Enabled         =   0   'False
         Height          =   285
         Left            =   3960
         MaxLength       =   15
         TabIndex        =   7
         Top             =   810
         Width           =   1890
      End
      Begin VB.TextBox Txt2Nombre 
         Enabled         =   0   'False
         Height          =   285
         Left            =   5850
         MaxLength       =   15
         TabIndex        =   8
         Top             =   810
         Width           =   1890
      End
      Begin VB.TextBox TxtCodigo 
         ForeColor       =   &H00800000&
         Height          =   285
         Left            =   3075
         MaxLength       =   3
         TabIndex        =   3
         Top             =   105
         Width           =   645
      End
      Begin VB.ComboBox cmbClasificacion 
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
         Left            =   210
         Style           =   2  'Dropdown List
         TabIndex        =   26
         Top             =   4680
         Width           =   2610
      End
      Begin VB.ComboBox cmbCategoriaDeudor 
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
         Left            =   2865
         Style           =   2  'Dropdown List
         TabIndex        =   21
         Top             =   3510
         Width           =   2490
      End
      Begin VB.ComboBox cmbActividadEconomica 
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
         Left            =   5415
         Style           =   2  'Dropdown List
         TabIndex        =   25
         Top             =   4050
         Width           =   2415
      End
      Begin VB.ComboBox cmbComInstitucional 
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
         Left            =   2865
         Style           =   2  'Dropdown List
         TabIndex        =   24
         Top             =   4080
         Width           =   2490
      End
      Begin VB.ComboBox cmbTipoCliente 
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
         Left            =   210
         Style           =   2  'Dropdown List
         TabIndex        =   14
         Top             =   2385
         Width           =   2625
      End
      Begin VB.ComboBox cmbRelBanco 
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
         Left            =   225
         Style           =   2  'Dropdown List
         TabIndex        =   23
         Top             =   4095
         Width           =   2595
      End
      Begin VB.ComboBox cmbRGBanco 
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
         Left            =   5430
         Style           =   2  'Dropdown List
         TabIndex        =   22
         Top             =   3525
         Width           =   2385
      End
      Begin VB.ComboBox cmbPais 
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
         Left            =   210
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   1815
         Width           =   2640
      End
      Begin VB.TextBox TxtTelefono 
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
         Height          =   285
         Left            =   2880
         MaxLength       =   20
         TabIndex        =   15
         Top             =   2385
         Width           =   2445
      End
      Begin VB.TextBox TxtFax 
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
         Height          =   285
         Left            =   5385
         MaxLength       =   20
         TabIndex        =   16
         Top             =   2385
         Width           =   2400
      End
      Begin VB.TextBox TxtDireccion 
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
         Height          =   285
         Left            =   195
         MaxLength       =   40
         TabIndex        =   10
         Top             =   1305
         Width           =   7560
      End
      Begin VB.ComboBox CmbMercado 
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
         Left            =   210
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   3525
         Width           =   2595
      End
      Begin VB.ComboBox CmbCiudad 
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
         Left            =   2895
         Style           =   2  'Dropdown List
         TabIndex        =   12
         Top             =   1800
         Width           =   2460
      End
      Begin VB.ComboBox CmbComuna 
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
         Left            =   5385
         Style           =   2  'Dropdown List
         TabIndex        =   13
         Top             =   1815
         Width           =   2385
      End
      Begin VB.ComboBox CmbCalidadJuridica 
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
         Left            =   210
         Style           =   2  'Dropdown List
         TabIndex        =   17
         Top             =   2970
         Width           =   2610
      End
      Begin VB.TextBox TxtCtaUSD 
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
         Height          =   285
         Left            =   5400
         MaxLength       =   15
         TabIndex        =   19
         Top             =   3015
         Width           =   2385
      End
      Begin VB.Frame Frame1 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   720
         Left            =   2040
         TabIndex        =   47
         Top             =   5580
         Width           =   3345
         Begin VB.TextBox TxtCod 
            ForeColor       =   &H00000000&
            Height          =   285
            Left            =   2160
            MaxLength       =   11
            TabIndex        =   38
            Top             =   255
            Width           =   1110
         End
         Begin Threed.SSOption OpImplic 
            Height          =   255
            Index           =   2
            Left            =   1470
            TabIndex        =   37
            Top             =   285
            Width           =   735
            _Version        =   65536
            _ExtentX        =   1296
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Swift"
            ForeColor       =   8388608
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
         Begin Threed.SSOption OpImplic 
            Height          =   255
            Index           =   1
            Left            =   765
            TabIndex        =   36
            Top             =   285
            Width           =   660
            _Version        =   65536
            _ExtentX        =   1164
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Chips"
            ForeColor       =   8388608
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
         Begin Threed.SSOption OpImplic 
            Height          =   255
            Index           =   0
            Left            =   90
            TabIndex        =   35
            Top             =   285
            Width           =   660
            _Version        =   65536
            _ExtentX        =   1164
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   " Aba"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Value           =   -1  'True
         End
      End
      Begin VB.CheckBox chkFirma 
         Caption         =   "Firma"
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   7050
         TabIndex        =   42
         Top             =   5820
         Width           =   690
      End
      Begin VB.CheckBox chkPoder 
         Caption         =   "Poder"
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   7050
         TabIndex        =   40
         Top             =   5460
         Width           =   1050
      End
      Begin VB.CheckBox chkArticulo85 
         Caption         =   "Decl. Articulo 85"
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
         Height          =   255
         Left            =   210
         TabIndex        =   32
         Top             =   5085
         Width           =   1755
      End
      Begin VB.CheckBox chkInformeSocial 
         Caption         =   "Informe Social"
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   5505
         TabIndex        =   39
         Top             =   5460
         Width           =   1350
      End
      Begin VB.TextBox txtctacte 
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
         Height          =   285
         Left            =   2865
         MaxLength       =   15
         TabIndex        =   18
         Top             =   3000
         Width           =   2475
      End
      Begin VB.TextBox txtCodigoSuper 
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
         Height          =   285
         Left            =   2880
         MaxLength       =   3
         TabIndex        =   27
         Top             =   4695
         Width           =   675
      End
      Begin VB.TextBox txtCodigoBCCH 
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
         Height          =   285
         Left            =   3675
         MaxLength       =   3
         TabIndex        =   28
         Top             =   4680
         Width           =   720
      End
      Begin VB.CheckBox chkOficinas 
         Caption         =   "Oficinas en Chile"
         Enabled         =   0   'False
         ForeColor       =   &H00800000&
         Height          =   330
         Left            =   5520
         TabIndex        =   41
         Top             =   5820
         Width           =   1530
      End
      Begin VB.TextBox txtCRF 
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
         Height          =   285
         Left            =   4710
         MaxLength       =   10
         TabIndex        =   29
         Top             =   4695
         Width           =   1515
      End
      Begin VB.TextBox txtERF 
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
         Height          =   285
         Left            =   6345
         MaxLength       =   10
         TabIndex        =   30
         Top             =   4695
         Width           =   1470
      End
      Begin VB.TextBox txtCRiesgo 
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
         Height          =   285
         Left            =   6345
         MaxLength       =   10
         TabIndex        =   31
         Top             =   5025
         Width           =   1470
      End
      Begin VB.TextBox Txt1Apellido 
         Enabled         =   0   'False
         Height          =   285
         Left            =   165
         MaxLength       =   15
         TabIndex        =   5
         Top             =   810
         Width           =   1890
      End
      Begin VB.TextBox Txt2Apellido 
         Enabled         =   0   'False
         Height          =   285
         Left            =   2055
         MaxLength       =   15
         TabIndex        =   6
         Top             =   810
         Width           =   1890
      End
      Begin BACControles.TXTFecha TxtvctoLinea 
         Height          =   315
         Left            =   3210
         TabIndex        =   46
         Top             =   5160
         Width           =   1350
         _ExtentX        =   2381
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
         ForeColor       =   8388608
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "09/11/2000"
      End
      Begin Threed.SSFrame frame85 
         Height          =   705
         Left            =   195
         TabIndex        =   48
         Top             =   5580
         Width           =   1785
         _Version        =   65536
         _ExtentX        =   3149
         _ExtentY        =   1244
         _StockProps     =   14
         Caption         =   "Articulo 85"
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
         Begin Threed.SSOption opCliente 
            Height          =   255
            Left            =   135
            TabIndex        =   33
            Top             =   300
            Width           =   810
            _Version        =   65536
            _ExtentX        =   1429
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Cliente"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Enabled         =   0   'False
            Value           =   -1  'True
         End
         Begin Threed.SSOption opBanco 
            Height          =   255
            Left            =   945
            TabIndex        =   34
            Top             =   300
            Width           =   780
            _Version        =   65536
            _ExtentX        =   1376
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Banco"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Enabled         =   0   'False
         End
      End
      Begin Threed.SSOption SSOption1 
         Height          =   195
         Left            =   5940
         TabIndex        =   49
         Top             =   135
         Width           =   915
         _Version        =   65536
         _ExtentX        =   1614
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Natural"
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
         Font3D          =   3
      End
      Begin Threed.SSOption SSOption2 
         Height          =   195
         Left            =   6930
         TabIndex        =   50
         Top             =   135
         Width           =   1005
         _Version        =   65536
         _ExtentX        =   1773
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Juridico"
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
         Font3D          =   3
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Generico"
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
         Index           =   3
         Left            =   3810
         TabIndex        =   81
         Top             =   135
         Width           =   780
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Razón Social"
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
         Index           =   18
         Left            =   150
         TabIndex        =   80
         Top             =   615
         Visible         =   0   'False
         Width           =   1500
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Paterno"
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
         Index           =   2
         Left            =   150
         TabIndex        =   79
         Top             =   615
         Width           =   675
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "R.U.T."
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
         Left            =   225
         TabIndex        =   78
         Top             =   135
         Width           =   585
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
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
         ForeColor       =   &H00000000&
         Height          =   300
         Index           =   1
         Left            =   2010
         TabIndex        =   77
         Top             =   90
         Width           =   105
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Materno"
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
         Left            =   2115
         TabIndex        =   76
         Top             =   630
         Width           =   705
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Nombres"
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
         Left            =   4005
         TabIndex        =   75
         Top             =   615
         Width           =   750
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
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
         Height          =   195
         Index           =   31
         Left            =   2415
         TabIndex        =   74
         Top             =   120
         Width           =   600
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Clasificación Riesgo"
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
         Index           =   34
         Left            =   255
         TabIndex        =   73
         Top             =   4470
         Width           =   1740
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Categoría Deudor"
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
         Index           =   33
         Left            =   3165
         TabIndex        =   72
         Top             =   3300
         Width           =   1530
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Actividad Económica"
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
         Index           =   32
         Left            =   5760
         TabIndex        =   71
         Top             =   3840
         Width           =   1800
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Composición Institucional"
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
         Index           =   28
         Left            =   3165
         TabIndex        =   70
         Top             =   3855
         Width           =   2175
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Clasificación Cliente"
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
         Index           =   27
         Left            =   195
         TabIndex        =   69
         Top             =   2145
         Width           =   1740
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Relación Banco"
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
         Index           =   26
         Left            =   240
         TabIndex        =   68
         Top             =   3885
         Width           =   1365
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Relación Gestión Banco"
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
         Index           =   24
         Left            =   5745
         TabIndex        =   67
         Top             =   3300
         Width           =   2070
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
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
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   9
         Left            =   240
         TabIndex        =   66
         Top             =   1605
         Width           =   405
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Cta Corriente $"
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
         Left            =   3210
         TabIndex        =   65
         Top             =   2745
         Width           =   1290
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Mercado"
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
         Index           =   8
         Left            =   210
         TabIndex        =   64
         Top             =   3300
         Width           =   750
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Teléfono"
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
         Left            =   3210
         TabIndex        =   63
         Top             =   2190
         Width           =   765
      End
      Begin VB.Label Label 
         Caption         =   "Fax"
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
         Height          =   255
         Index           =   16
         Left            =   5730
         TabIndex        =   62
         Top             =   2130
         Width           =   375
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Ciudad"
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
         Left            =   3180
         TabIndex        =   61
         Top             =   1605
         Width           =   600
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Localidad"
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
         Left            =   5685
         TabIndex        =   60
         Top             =   1605
         Width           =   840
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Calidad Jurídica"
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
         Left            =   210
         TabIndex        =   59
         Top             =   2745
         Width           =   1395
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Cta Corriente USD"
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
         Index           =   23
         Left            =   5685
         TabIndex        =   58
         Top             =   2730
         Width           =   1575
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Dirección"
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
         Left            =   240
         TabIndex        =   57
         Top             =   1110
         Width           =   825
      End
      Begin VB.Line Line1 
         X1              =   90
         X2              =   7890
         Y1              =   480
         Y2              =   480
      End
      Begin VB.Line Line2 
         BorderColor     =   &H00FFFFFF&
         X1              =   90
         X2              =   8925
         Y1              =   495
         Y2              =   495
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Cód.Sbif"
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
         Index           =   4
         Left            =   2865
         TabIndex        =   56
         Top             =   4470
         Width           =   735
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Cód.BCCH"
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
         Index           =   6
         Left            =   3675
         TabIndex        =   55
         Top             =   4470
         Width           =   900
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "CRF"
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
         Left            =   4710
         TabIndex        =   54
         Top             =   4470
         Width           =   375
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "ERF"
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
         Left            =   6345
         TabIndex        =   53
         Top             =   4470
         Width           =   375
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Vcto. Línea"
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
         Index           =   14
         Left            =   2085
         TabIndex        =   52
         Top             =   5220
         Width           =   1065
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Clasificador Riesgo"
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
         Left            =   4620
         TabIndex        =   51
         Top             =   5070
         Width           =   1650
      End
   End
   Begin VB.TextBox txtCodContable 
      Enabled         =   0   'False
      ForeColor       =   &H00800000&
      Height          =   285
      Left            =   7440
      MaxLength       =   7
      TabIndex        =   0
      Top             =   120
      Width           =   645
   End
   Begin VB.Label Label 
      AutoSize        =   -1  'True
      Caption         =   "Cód. Contable"
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
      Index           =   22
      Left            =   6120
      TabIndex        =   44
      Top             =   165
      Width           =   1215
   End
End
Attribute VB_Name = "BacMntCl"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim CodigoFox As Double
Dim LimpiaYN As Boolean
Dim Sql$, Datos(), Sw%, Norepi%, VarPais%
Dim i%
Dim swauxiliar
Function HabilitarControles(Valor As Boolean)
   
   txtrut.Enabled = Not Valor
   txtDigito.Enabled = Not Valor
   txtCodigo.Enabled = Not Valor
   Txt1Nombre.Enabled = Valor
   Txt2Nombre.Enabled = Valor
   Txt1Apellido.Enabled = Valor
   Txt2Apellido.Enabled = Valor
   TxtCtaUSD.Enabled = Valor
   TxtCod.Enabled = Valor
   
   For i = 0 To 2
    OpImplic(i).Enabled = Valor
   Next i
   
   txtgeneric.Enabled = Valor
   txtCtaCte.Enabled = Valor
   TxtDireccion.Enabled = Valor
  txtnombre.Enabled = Valor
   TxtFax.Enabled = Valor
   TxtTelefono.Enabled = Valor
   txtCRF.Enabled = Valor
   txtERF.Enabled = Valor
   TxtvctoLinea.Enabled = Valor
   txtCRiesgo.Enabled = Valor
   CmbComuna.Enabled = Valor
   CmbCiudad.Enabled = Valor
   CmbCalidadJuridica.Enabled = Valor
   CmbMercado.Enabled = Valor
   cmbPais.Enabled = Valor
   Toolbar1.Buttons(1).Enabled = Valor
   Toolbar1.Buttons(2).Enabled = Valor
   Toolbar1.Buttons(3).Enabled = Valor
   SSOption1.Enabled = Valor
   SSOption2.Enabled = Valor
   
   'Nuevos controles //Marcos Jimenez
   cmbRGBanco.Enabled = Valor
   cmbTipoCliente.Enabled = Valor
   cmbComInstitucional.Enabled = Valor
   cmbRelBanco.Enabled = Valor
   cmbActividadEconomica.Enabled = Valor
   cmbCategoriaDeudor.Enabled = Valor
   cmbClasificacion.Enabled = Valor
   chkInformeSocial.Enabled = Valor
   chkArticulo85.Enabled = Valor
   chkPoder.Enabled = Valor
   chkFirma.Enabled = Valor
   chkOficinas.Enabled = Valor
End Function

Sub Inicializa_Pais()
Dim i%

For i% = 0 To cmbPais.ListCount - 1
     If UCase(Mid(cmbPais.List(i%), 1, 5)) = "CHILE" Then
        cmbPais.ListIndex = i%
        Exit For
     End If
Next i%

For i% = 0 To CmbCiudad.ListCount - 1
     If UCase(Mid(CmbCiudad.List(i%), 1, 8)) = "SANTIAGO" Or UCase(Mid(CmbCiudad.List(i%), 1, 4)) = "STGO" Then
        CmbCiudad.ListIndex = i%
        Exit For
     End If
Next i%

For i% = 0 To CmbComuna.ListCount - 1
     If UCase(Mid(CmbComuna.List(i%), 1, 8)) = "SANTIAGO" Or UCase(Mid(CmbComuna.List(i%), 1, 4)) = "STGO" Then
        CmbComuna.ListIndex = i%
        Exit For
     End If
Next i%

End Sub

'Limpiar Pantalla
Sub Limpiar()
    LimpiaYN = True
   Txt1Nombre.Text = " "
   Txt2Nombre.Text = " "
   Txt1Apellido.Text = " "
   Txt2Apellido.Text = " "
   
   Txt1Nombre.Tag = " "
   Txt2Nombre.Tag = " "
   Txt1Apellido.Tag = " "
   Txt2Apellido.Tag = " "
   TxtCod.Text = ""
   TxtCtaUSD.Text = " "
   
   txtrut.Text = ""
   txtDigito.Text = ""
   txtgeneric.Text = ""
   TxtDireccion.Text = ""
   TxtFax.Text = ""
   
   txtCodContable.Text = ""
   txtnombre.Text = ""
   txtnombre.Tag = ""
   
   TxtTelefono.Text = ""
   txtCtaCte.Text = ""
   TxtCtaUSD.Text = ""
   txtCodigo.Text = ""
      
   txtCRF.Text = ""
   txtERF.Text = ""
   TxtvctoLinea.Text = Date
   txtCRiesgo.Text = ""
   
   CmbCalidadJuridica.ListIndex = -1
   CmbComuna.Clear
   CmbCiudad.Clear
   CmbMercado.ListIndex = -1
   cmbPais.ListIndex = -1
   cmbRGBanco.ListIndex = -1
   cmbRelBanco.ListIndex = -1
   cmbCategoriaDeudor.ListIndex = -1
   cmbTipoCliente.ListIndex = -1
   cmbComInstitucional.ListIndex = -1
   cmbActividadEconomica.ListIndex = -1
   cmbClasificacion.ListIndex = -1
   
   chkInformeSocial.Value = 0
   chkArticulo85.Value = 0
   chkPoder.Value = 0
   chkFirma.Value = 0
   chkOficinas.Value = 0
   TxtvctoLinea.Text = "01/01/1900"
   LimpiaYN = False
 End Sub

Sub Revisa()
   
   txtCtaCte.Tag = txtCtaCte.Text
   TxtDireccion.Tag = TxtDireccion.Text
   txtnombre.Tag = txtnombre.Text
   txtgeneric.Tag = txtgeneric.Text
   TxtFax.Tag = TxtFax.Text
   TxtTelefono.Tag = TxtTelefono.Text
   CmbComuna.Tag = CmbComuna.ListIndex
   'cmbregion.Tag = cmbregion.ListIndex
   cmbTipoCliente.Tag = cmbTipoCliente.ListIndex
   CmbCalidadJuridica.Tag = CmbCalidadJuridica.ListIndex
   CmbCiudad.Tag = CmbCiudad.ListIndex
   CmbMercado.Tag = CmbMercado.ListIndex
   'CmbGrupo.Tag = CmbGrupo.ListIndex
   'CmbEntidad.Tag = CmbEntidad.ListIndex
   cmbPais.Tag = cmbPais.ListIndex

End Sub

Function ValidarDatos() As Boolean

   ValidarDatos = True
   If Trim$(txtCodigo) = "" Then
      MsgBox "ERROR : Código asociado al Rut en Blanco", 16, TITSISTEMA
      'Txt1Nombre.SetFocus
      ValidarDatos = False
   End If
 
If SSOption1.Value = True Then
   If Trim$(Txt1Nombre) = "" Or Trim$(Txt1Apellido) = "" Or Trim$(Txt2Apellido) = "" Then
      MsgBox "ERROR : Nombre vacio", 16, TITSISTEMA
      Txt1Nombre.SetFocus
      ValidarDatos = False
   End If
   
Else
   If Trim$(txtnombre) = "" Then
      MsgBox "ERROR : Razón Social vacia", 16, TITSISTEMA
      txtnombre.SetFocus
      ValidarDatos = False
    End If
End If
 
   If Trim$(txtgeneric) = "" Then
      MsgBox "ERROR : Codigo Generico  vacio", 16, TITSISTEMA
      txtgeneric.SetFocus
      ValidarDatos = False
   End If
   
   If CmbCiudad.Enabled <> False And CmbCiudad.ListIndex = -1 Then
      MsgBox "ERROR : Debe ingresar ciudad", 16, TITSISTEMA
      Call Carga
      ValidarDatos = False
    End If
   
'   If cmbcomuna.Enabled <> False And cmbcomuna.ListIndex = -1 Then
'      MsgBox "ERROR : Debe ingresar comuna", 16, "Bac-Trader"
'      cmbcomuna.SetFocus
'     ValidarDatos = False
'  End If
   
End Function


Private Sub Check1_Click()

End Sub

Private Sub chkarticulo85_Click()
    If chkArticulo85.Value = 0 Then
        frame85.Enabled = False
        opBanco.Enabled = False
        opCliente.Enabled = False
   Else
        frame85.Enabled = True
        opBanco.Enabled = True
        opCliente.Enabled = True
  End If
End Sub


Private Sub cmbActividadEconomica_KeyPress(KeyAscii As Integer)
If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
End If
End Sub

Private Sub CmbCalidadJuridica_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then SendKeys "{TAB}"
End Sub


Private Sub cmbCategoriaDeudor_KeyPress(KeyAscii As Integer)
If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
End If
End Sub

Private Sub CmbCiudad_Click()
Dim Sql As String
Dim Hay As Boolean
Dim Datos()

Hay = False
If Not LimpiaYN Then
'''''''''''''''''''''''''''''''''''''Sql = ""
'''''''''''''''''''''''''''''''''''''Sql = "execute sp_leercom "
'''''''''''''''''''''''''''''''''''''Sql = Sql & Trim(Right(cmbPais.Text, 6)) & "," & Trim(Right(cmbCiudad.Text, 6))

Envia = Array()

AddParam Envia, CDbl(Trim(Right(cmbPais.Text, 6)))
AddParam Envia, CDbl(Trim(Right(CmbCiudad.Text, 6)))

   If Not Bac_Sql_Execute("sp_leercom ", Envia) Then Exit Sub
   
   CmbComuna.Clear
   
   Do While Bac_SQL_Fetch(Datos())
      
      Hay = True
      CmbComuna.AddItem Trim(Datos(2)) & Space(30 + (30 - Len(Datos(1)))) & Val(Datos(1))
      
   Loop
   
   If Hay Then
       
       CmbComuna.ListIndex = 0
   
   End If

End If

End Sub

Private Sub CmbCiudad_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then SendKeys "{TAB}"

End Sub

Private Sub cmbclasificacion_KeyPress(KeyAscii As Integer)
If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
End If
End Sub

Private Sub cmbComInstitucional_KeyPress(KeyAscii As Integer)
If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
End If
End Sub

Private Sub cmbComuna_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then SendKeys "{TAB}"
End Sub
Private Sub CmbMercado_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then SendKeys "{TAB}"
End Sub

Private Sub cmbPais_Click()
Dim Sql As String
Dim Hay As Boolean
'LLena combo con ciudad
Hay = False
If Not LimpiaYN Then
If cmbPais.Text <> "" Then
    Dim largo
    Dim entero
    Dim aux
    largo = Len(cmbPais.Text)
    entero = Mid(cmbPais.Text, (largo - 14), largo)
    aux = Val(Mid(entero, 1, 4))
    
'''''''''''''''''''''''''''''''''''''''    Sql = ""
'''''''''''''''''''''''''''''''''''''''    Sql = "execute SP_leerciuAUX "
'''''''''''''''''''''''''''''''''''''''    Sql = Sql & aux & ", "
'''''''''''''''''''''''''''''''''''''''    Sql = Sql & Trim(Right(cmbPais.Text, 6)) & ", 0"
    
    Envia = Array()
    
    AddParam Envia, CDbl(aux)
    AddParam Envia, CDbl(Trim(Right(cmbPais.Text, 6)))
    AddParam Envia, CDbl(0)
    
    If Not Bac_Sql_Execute("SP_leerciuAUX ", Envia) Then
        
        Exit Sub
    
    End If
    
    CmbCiudad.Clear
    
    Do While Bac_SQL_Fetch(Datos())
        
        Hay = True
        CmbCiudad.AddItem Trim(Datos(1)) & Space(30 + (30 - Len(Datos(1)))) & Val(Datos(2))
        
    Loop
    
    If Hay Then
        
        CmbCiudad.ListIndex = 0
    
    End If
End If
End If

End Sub

Private Sub cmbPais_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then SendKeys "{TAB}"
End Sub

Private Sub cmbRelBanco_KeyPress(KeyAscii As Integer)
If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
End If
End Sub


Private Sub cmbRGBanco_KeyPress(KeyAscii As Integer)
If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
End If
End Sub

Private Sub cmbTipoCliente_Click()
If Right(cmbTipoCliente.Text, 2) = "BC" Or Right(cmbTipoCliente.Text, 2) = "FI" Then
    txtCodigoSuper.Enabled = True
    txtCodigoBCCH.Enabled = True
Else
     txtCodigoSuper.Enabled = False
     txtCodigoBCCH.Enabled = False
     txtCodigoSuper.Text = ""
     txtCodigoBCCH.Text = ""
End If
End Sub

Private Sub cmbTipoCliente_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then SendKeys "{TAB}"
End Sub



Private Sub cmdGrabar_Click()

   Dim CODI      As Variant
   Dim codigo    As Integer
   Dim nombre   As String * 40
   Dim Implic As String
   Dim opcion As String
   Dim Aba As String
   Dim Chips As String
   Dim Swift As String
   Dim tipocliente As String
   Dim InformeSocial As String
   Dim Articulo85 As String
   Dim FechaArt85 As Date
   Dim DecArticulo85 As String
   Dim Poder As String
   Dim Firma As String
   Dim fecingr As Date
   Dim Oficina As String
   Dim Rut_Grupo As Double
   
   Sw = 0
  fecingr = Date
   Me.MousePointer = 11

   If Not ValidarDatos() Then   'Valdiaci˘n de los datos del cliente.
      Me.MousePointer = 0
      Exit Sub
   End If
   
   If SSOption2.Value = False Then
      OPTI = "N"
      nombre = Trim(Txt1Nombre.Text) & " " & Trim(Txt2Nombre.Text) & " " & Trim(Txt1Apellido.Text) & " " & Trim(Txt2Apellido.Text)
   Else
      OPTI = "J"
      nombre = Trim(txtnombre.Text)
   End If
   
   tipocliente = FUNC_ENTREGA_TIPO_CLIENTE(cmbTipoCliente)
   
If chkInformeSocial.Value = 0 Then
   InformeSocial = "N"
Else
    InformeSocial = "S"
End If

If chkOficinas.Value = 0 Then
   Oficina = "N"
Else
   Oficina = "S"
End If


If chkArticulo85.Value = 0 Then
   Articulo85 = "N"
Else
   Articulo85 = "S"
   FechaArt85 = Str(Date)
   If opBanco.Value = True Then
     DecArticulo85 = "B"
   Else
    DecArticulo85 = "C"
   End If
End If

If chkPoder.Value = 0 Then
   Poder = "N"
Else
   Poder = "S"
End If

If chkFirma.Value = 0 Then
   Firma = "N"
Else
   Firma = "S"
End If
If OpImplic(0).Value = True Then
        Implic = "A"
        Aba = TxtCod.Text
ElseIf OpImplic(1).Value = True Then
        Implic = "C"
        Chips = TxtCod.Text
Else
        Implic = "S"
        Swift = TxtCod.Text
End If
If SSOption1.Value = True Then
        opcion = "N"
Else
        opcion = "J"
End If
    
'------------------------------------------------------------------------
 Dim Sql As String
     
    Envia = Array()
   
    AddParam Envia, CDbl(Trim(txtrut.Text))                          'Rut
    AddParam Envia, Trim(txtDigito.Text)                             'Dig. Verificador
    AddParam Envia, CDbl(Trim(txtCodigo.Text))                       'Código
    AddParam Envia, Trim(nombre)                                     'Nombre
    AddParam Envia, Trim(txtgeneric.Text)                            'Generico
    AddParam Envia, Trim(TxtDireccion.Text)                          'Dirección
    AddParam Envia, CDbl(Trim(Right(CmbComuna.Text, 6)))             'Comuna
    AddParam Envia, CDbl(0)                                          'Región
    AddParam Envia, CDbl(tipocliente)                                'Tipo Cliente
    
    If Len(Trim$(fecingr)) < 8 Then
        
        AddParam Envia, Format(gsbac_fecp, "yyyymmdd")               'Fecha Ingreso
    
    Else
        
        AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
    
    End If
    
    AddParam Envia, Trim(txtCtaCte.Text)                             'Cuenta Corriente
    AddParam Envia, Trim(TxtTelefono.Text)                           'Telefóno
    AddParam Envia, Trim(TxtFax.Text)                                'Fax
    AddParam Envia, Trim(Txt1Apellido.Text)                          'Primer Apellido
    AddParam Envia, Trim(Txt2Apellido.Text)                          'Segundo Apellido
    AddParam Envia, Trim(Txt1Nombre.Text)                            'Primer Nombre
    AddParam Envia, Trim(Txt2Nombre.Text)                            'Segundo nombre
    AddParam Envia, ""                                               ' Apoderado
    AddParam Envia, Trim(Right(CmbCiudad.Text, 6))                   'Ciudad
    AddParam Envia, Trim(Right(CmbMercado.Text, 6))                  'Mercado
    AddParam Envia, 0                                                'Grupo
    AddParam Envia, Trim(Right(cmbPais.Text, 6))                     'pais
    AddParam Envia, Trim(Right(CmbCalidadJuridica.Text, 6))          'Calidad Juridica
    AddParam Envia, 0                                                'tipo ml
    AddParam Envia, 0                                                'tipo mx
    AddParam Envia, 0                                                'Banca
    AddParam Envia, ""                                               'Relación
    AddParam Envia, 0                                                'Número
    AddParam Envia, ""                                               'Comex
    AddParam Envia, Trim(Chips)                                      'Código Chips
    AddParam Envia, Trim(Aba)                                        'Código Aba
    AddParam Envia, Trim(Swift)                                      'Código Swift
    AddParam Envia, 0                                                'nfm
    AddParam Envia, ""                                               'Fondo Mutuo
    AddParam Envia, "20001231"                                       'Fecha Ultimo
    AddParam Envia, ""                                               'Ejecutivo
    AddParam Envia, 0                                                'Entidad"
    AddParam Envia, ""                                               'graba
    AddParam Envia, 0                                                'Campint
    AddParam Envia, ""                                               'calle
    AddParam Envia, TxtCtaUSD.Text                                   'Cuenta USD
    AddParam Envia, ""                                               'Calidad Juridica
    AddParam Envia, ""                                               'nemo
    AddParam Envia, Trim(Implic)                                     'Implic
    AddParam Envia, Trim(opcion)                                     'Opción
    
    AddParam Envia, CDbl(Trim(Right(cmbRGBanco.Text, 6)))            'Relación Gestión Banco
    AddParam Envia, CDbl(Trim(Right(cmbCategoriaDeudor.Text, 6)))    'Categoría Deudor
    AddParam Envia, CDbl(Trim(Right(cmbComInstitucional.Text, 6)))   'Composición Institucional(Sector)
    AddParam Envia, Trim(Left(cmbClasificacion.Text, 6))             'Clasificación
    AddParam Envia, CDbl(Trim(Right(cmbActividadEconomica.Text, 6))) 'Actividad económica
    AddParam Envia, tipocliente                                      'Tipo Empresa
    AddParam Envia, CDbl(Trim(Right(cmbRelBanco.Text, 6)))           'Relación Banco
    AddParam Envia, Trim(Poder)                                      'Poder
    AddParam Envia, Trim(Firma)                                      'Firma
    AddParam Envia, Format(CDate(FechaArt85), "yyyymmdd")            'Fecha Articulo 85
    AddParam Envia, 0                                                'Relación compańia
    AddParam Envia, 0                                                'Relación corredora
    AddParam Envia, Trim(InformeSocial)                              'Informe Social
    AddParam Envia, Trim(Articulo85)                                 'Articulo 85
    AddParam Envia, Trim(DecArticulo85)                              'Decl. Art.85
    AddParam Envia, CDbl(Rut_Grupo)                                  'Rut grupo Economico
    AddParam Envia, CDbl(txtCodContable.Text)                        'Código Contable
    AddParam Envia, CDbl(txtCodigoSuper.Text)                        ' Codigo Super
    AddParam Envia, CDbl(txtCodigoBCCH.Text)                         ' Codigo BCCH
    
    AddParam Envia, Trim(txtCRF.Text)                                'CRF
    AddParam Envia, Trim(txtERF.Text)                                'ERF
    AddParam Envia, Format(CDate(TxtvctoLinea.Text), "yyyymmdd")
    AddParam Envia, Trim(Oficina)                                    'Oficina S/N
    AddParam Envia, Trim(txtCRiesgo.Text)                            'Clasificación de riesgo
   
   If Not Bac_Sql_Execute("SP_CLGRABAR1 ", Envia) Then
       MsgBox "FALLA SQL ", vbCritical, TITSISTEMA
       Exit Sub
    End If
   
    MsgBox "Grabación se realizó correctamente", vbInformation, TITSISTEMA

Me.MousePointer = 0
 Call Limpiar
 HabilitarControles False
 
End Sub





Private Sub cmdlimpiar_Click()
   Call Limpiar
   txtCodigo.Text = ""
   Call HabilitarControles(False)
   
   txtrut.SetFocus
End Sub


Private Sub CmdRelacion_Click()
On Error Resume Next
    BacRelacionCliente.Show 1
On Error GoTo 0
End Sub

Private Sub cmdSalir_Click()

   Unload Me

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

Top = 1
Left = 15
Norepi = 0
CodigoFox = 0

If KeyAscii = 13 Then SendKeys "{TAB}"

End Sub


Private Sub Form_Load()

On Error GoTo ErrMDB

   Me.Top = 0
   Me.Left = 0
   LimpiaYN = False
  
   swauxiliar = 0
       
   Call Carga
       
   Call Grabar_Log_AUDITORIA(gsEntidad _
                                 , gsbac_fecp _
                                 , gsBac_IP _
                                 , gsUsuario _
                                 , "PCA" _
                                 , "opc_21" _
                                 , " " _
                                 , "Usuario entra en Mantención de Cliente" _
                                 , " " _
                                 , " " _
                                 , " ")
   
   
   OpImplic(2).Value = True
   
   Call HabilitarControles(False)
   txtnombre.Enabled = False
   

Exit Sub

ErrMDB:

   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
   
   Unload Me
   
   Exit Sub
   
End Sub



Private Sub cmdEliminar_Click()
Dim Sql As String
    
'''''''''''''''''''''''''''''''''''''    Sql = "EXECUTE sp_mdclleerrut "
'''''''''''''''''''''''''''''''''''''    Sql = Sql & Val(TXTRUT.Text)
'''''''''''''''''''''''''''''''''''''    Sql = Sql & ",'" & Trim(Txtdigito) & "'"
'''''''''''''''''''''''''''''''''''''    Sql = Sql & "," & Val(txtCODIGO.Text)
          
    Envia = Array()
    
    AddParam Envia, CDbl(txtrut.Text)
    AddParam Envia, Trim(txtDigito)
    AddParam Envia, CDbl(txtCodigo.Text)
          
    If Not Bac_Sql_Execute("sp_mdclleerrut") Then
        
        MsgBox "Consulta en Bactrader Ha Fallado. Servidor SQL No Responde", vbCritical, TITSISTEMA
        Exit Sub
    
    End If
       
        
 If Bac_SQL_Fetch(Datos()) Then
     
     If MsgBox("Esta Seguro de Eliminar el Cliente", 36, TITSISTEMA) = 6 Then
  
            'Sql = "SP_CLELIMINAR1 " & TXTRUT.Text & "," & txtCODIGO.Text
     
            Envia = Array()
            
            AddParam Envia, CDbl(txtrut.Text)
            AddParam Envia, CDbl(txtCodigo.Text)
     
            If Not Bac_Sql_Execute("SP_CLELIMINAR1 ", Envia) Then
                    
                    MsgBox "Error : No eliminó el Cliente ", 16, TITSISTEMA
                    Exit Sub
            
            End If
                
            MsgBox "Eliminación se realizó correctamente", vbInformation, TITSISTEMA
            Call Limpiar
            Call HabilitarControles(False)
            txtrut.SetFocus
    
    End If
Else
        MsgBox "Los datos no han sido grabados", vbCritical, TITSISTEMA
        txtgeneric.SetFocus
End If

End Sub


Private Sub SSCommand1_Click()

End Sub

Private Sub Form_Unload(Cancel As Integer)
   
   Call Grabar_Log_AUDITORIA(gsEntidad _
                                 , gsbac_fecp _
                                 , gsBac_IP _
                                 , gsUsuario _
                                 , "PCA" _
                                 , "opc_21" _
                                 , " " _
                                 , "Usuario Cierra Mantención de Cliente" _
                                 , " " _
                                 , " " _
                                 , " ")

End Sub




Private Sub SSOption1_Click(Value As Integer)
' TipoNombre True
'
' Txt1Nombre.Text = Txt1Nombre.Tag: Txt2Nombre.Text = Txt2Nombre.Tag
' Txt1Apellido.Text = Txt1Apellido.Tag: Txt2Apellido.Text = Txt2Apellido.Tag
'
' Txt1Nombre.Enabled = True: Txt2Nombre.Enabled = True
' Txt1Apellido.Enabled = True: Txt2Apellido.Enabled = True
'
' TxtNombre.Tag = TxtNombre.Text
' TxtNombre = ""
' TxtNombre.Enabled = False
'
' Txt1Apellido.SetFocus
End Sub



Private Sub SSOption2_Click(Value As Integer)
 TipoNombre False
 
 Txt1Nombre.Tag = Txt1Nombre.Text: Txt2Nombre.Tag = Txt2Nombre.Text
 Txt1Apellido.Tag = Txt1Apellido.Text: Txt2Apellido.Tag = Txt2Apellido.Text
 
 Txt1Nombre = "": Txt2Nombre = ""
 Txt1Apellido = "": Txt2Apellido = ""
 
 Txt1Nombre.Enabled = False: Txt2Nombre.Enabled = False
 Txt1Apellido.Enabled = False: Txt2Apellido.Enabled = False
 
 txtnombre.Text = txtnombre.Tag
 txtnombre.Enabled = True
 'TxtNombre.SetFocus 'habilitado

End Sub






Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim CODI      As Variant
   Dim codigo    As Integer
   Dim nombre   As String * 40
   Dim Implic As String
   Dim opcion As String
   Dim Aba As String
   Dim Chips As String
   Dim Swift As String
   Dim tipocliente As String
   Dim InformeSocial As String
   Dim Articulo85 As String
   Dim FechaArt85 As Date
   Dim DecArticulo85 As String
   Dim Poder As String
   Dim Firma As String
   Dim fecingr As Date
   Dim Oficina As String
   Dim Rut_Grupo As Double
   Dim Sql As String
   
   Select Case Button.Index
      Case 1
      
         Sw = 0
         fecingr = Date
         Me.MousePointer = 11
   
         If Not ValidarDatos() Then   'Valdiaci˘n de los datos del cliente.
            Me.MousePointer = 0
            Exit Sub
         End If
      
         If SSOption2.Value = False Then
            OPTI = "N"
            nombre = Trim(Txt1Nombre.Text) & " " & Trim(Txt2Nombre.Text) & " " & Trim(Txt1Apellido.Text) & " " & Trim(Txt2Apellido.Text)
         Else
            OPTI = "J"
            nombre = Trim(txtnombre.Text)
         End If
   
         If cmbTipoCliente.ListIndex > 0 Then
            tipocliente = cmbTipoCliente.ItemData(cmbTipoCliente.ListIndex) 'FUNC_ENTREGA_TIPO_CLIENTE(cmbTipoCliente)
         Else
            tipocliente = 0
         End If
   
         If chkInformeSocial.Value = 0 Then
            InformeSocial = "N"
         Else
             InformeSocial = "S"
         End If

         If chkOficinas.Value = 0 Then
            Oficina = "N"
         Else
            Oficina = "S"
         End If
         
         
         If chkArticulo85.Value = 0 Then
            Articulo85 = "N"
         Else
            Articulo85 = "S"
            FechaArt85 = Str(Date)
            If opBanco.Value = True Then
              DecArticulo85 = "B"
            Else
             DecArticulo85 = "C"
            End If
         End If

         If chkPoder.Value = 0 Then
            Poder = "N"
         Else
            Poder = "S"
         End If
         
         If chkFirma.Value = 0 Then
            Firma = "N"
         Else
            Firma = "S"
         End If
         If OpImplic(0).Value = True Then
                 Implic = "A"
                 Aba = TxtCod.Text
         ElseIf OpImplic(1).Value = True Then
                 Implic = "C"
                 Chips = TxtCod.Text
         Else
                 Implic = "S"
                 Swift = TxtCod.Text
         End If
         If SSOption1.Value = True Then
                 opcion = "N"
         Else
                 opcion = "J"
         End If
    
      '------------------------------------------------------------------------
          
   
    Envia = Array()
   
    AddParam Envia, CDbl(Trim(txtrut.Text))                          'Rut
    AddParam Envia, Trim(txtDigito.Text)                             'Dig. Verificador
    AddParam Envia, CDbl(Trim(txtCodigo.Text))                       'Código
    AddParam Envia, Trim(nombre)                                     'Nombre
    AddParam Envia, Trim(txtgeneric.Text)                            'Generico
    AddParam Envia, Trim(TxtDireccion.Text)                          'Dirección
    AddParam Envia, Val(Trim(Right(CmbComuna.Text, 6)))                    'Comun
    AddParam Envia, CDbl(0)                                          'Región
    AddParam Envia, CDbl(tipocliente)                                'Tipo Cliente
    
    If Len(Trim$(fecingr)) < 8 Then
        
        AddParam Envia, Format(gsbac_fecp, "yyyymmdd")               'Fecha Ingreso
    
    Else
        
        AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
    
    End If
    
    AddParam Envia, Trim(txtCtaCte.Text)                             'Cuenta Corriente
    AddParam Envia, Trim(TxtTelefono.Text)                           'Telefóno
    AddParam Envia, Trim(TxtFax.Text)                                'Fax
    AddParam Envia, Trim(Txt1Apellido.Text)                          'Primer Apellido
    AddParam Envia, Trim(Txt2Apellido.Text)                          'Segundo Apellido
    AddParam Envia, Trim(Txt1Nombre.Text)                            'Primer Nombre
    AddParam Envia, Trim(Txt2Nombre.Text)                            'Segundo nombre
    AddParam Envia, ""                                               ' Apoderado
    AddParam Envia, CDbl(Trim(Right(CmbCiudad.Text, 6)))             'Ciudad
    AddParam Envia, CDbl(Trim(Right(CmbMercado.Text, 6)))            'Mercado
    AddParam Envia, 0                                                'Grupo
    AddParam Envia, CDbl(Trim(Right(cmbPais.Text, 6)))               'pais
    AddParam Envia, CDbl(Trim(Right(CmbCalidadJuridica.Text, 6)))    'Calidad Juridica
    AddParam Envia, 0                                                'tipo ml
    AddParam Envia, 0                                                'tipo mx
    AddParam Envia, 0                                                'Banca
    AddParam Envia, ""                                               'Relación
    AddParam Envia, 0                                                'Número
    AddParam Envia, ""                                               'Comex
    AddParam Envia, Trim(Chips)                                      'Código Chips
    AddParam Envia, Trim(Aba)                                        'Código Aba
    AddParam Envia, Trim(Swift)                                      'Código Swift
    AddParam Envia, 0                                                'nfm
    AddParam Envia, ""                                               'Fondo Mutuo
    AddParam Envia, "20001231"                                       'Fecha Ultimo
    AddParam Envia, ""                                               'Ejecutivo
    AddParam Envia, 0                                                'Entidad"
    AddParam Envia, ""                                               'graba
    AddParam Envia, 0                                                'Campint
    AddParam Envia, ""                                               'calle
    AddParam Envia, TxtCtaUSD.Text                                   'Cuenta USD
    AddParam Envia, ""                                               'Calidad Juridica
    AddParam Envia, ""                                               'nemo
    AddParam Envia, Trim(Implic)                                     'Implic
    AddParam Envia, Trim(opcion)                                     'Opción
    
    AddParam Envia, CDbl(Trim(Right(cmbRGBanco.Text, 6)))            'Relación Gestión Banco
    AddParam Envia, CDbl(Trim(Right(cmbCategoriaDeudor.Text, 6)))    'Categoría Deudor
    
    AddParam Envia, TraeValor(Trim(Right(cmbComInstitucional.Text, 6))) 'Composición Institucional(Sector)
    AddParam Envia, Trim(Left(cmbClasificacion.Text, 6))             'Clasificación
     
    AddParam Envia, TraeValor(Trim(Right(cmbActividadEconomica.Text, 6))) 'Actividad económica
    
    AddParam Envia, tipocliente                                      'Tipo Empresa
    AddParam Envia, CDbl(Trim(Right(cmbRelBanco.Text, 6)))           'Relación Banco
    AddParam Envia, Trim(Poder)                                      'Poder
    AddParam Envia, Trim(Firma)                                      'Firma
    AddParam Envia, Format(CDate(FechaArt85), "yyyymmdd")            'Fecha Articulo 85
    AddParam Envia, 0                                                'Relación compańia
    AddParam Envia, 0                                                'Relación corredora
    AddParam Envia, Trim(InformeSocial)                              'Informe Social
    AddParam Envia, Trim(Articulo85)                                 'Articulo 85
    AddParam Envia, Trim(DecArticulo85)                              'Decl. Art.85
    AddParam Envia, CDbl(Rut_Grupo)                                  'Rut grupo Economico
    AddParam Envia, CDbl(txtCodContable.Text)                        'Código Contable
    AddParam Envia, TraeValor(txtCodigoSuper.Text)                        ' Codigo Super
    AddParam Envia, TraeValor(txtCodigoBCCH.Text)                         ' Codigo BCCH
    
    AddParam Envia, Trim(txtCRF.Text)                                'CRF
    AddParam Envia, Trim(txtERF.Text)                                'ERF
    AddParam Envia, Format(CDate(TxtvctoLinea.Text), "yyyymmdd")
    AddParam Envia, Trim(Oficina)                                    'Oficina S/N
    AddParam Envia, Trim(txtCRiesgo.Text)                            'Clasificación de riesgo
   
   
         If Not Bac_Sql_Execute("SP_CLGRABAR1", Envia) Then
            
            MsgBox "Error al Grabar el Cliente", vbCritical, TITSISTEMA
            Me.MousePointer = Default
            Exit Sub
         
         End If
         
         MsgBox "Grabación se realizó correctamente", vbInformation, TITSISTEMA
      
         Me.MousePointer = 0
         Call Limpiar
         HabilitarControles False
 
      Case 2
          
'''''''''''''''''''''''''         Sql = "EXECUTE sp_mdclleerrut "
'''''''''''''''''''''''''         Sql = Sql & Val(TXTRUT.Text)
'''''''''''''''''''''''''         Sql = Sql & ",'" & Trim(Txtdigito) & "'"
'''''''''''''''''''''''''         Sql = Sql & "," & Val(txtCODIGO.Text)
               
         Envia = Array()
         
         AddParam Envia, CDbl(txtrut.Text)
         AddParam Envia, Trim(txtDigito)
         AddParam Envia, CDbl(txtCodigo.Text)
               
         If Not Bac_Sql_Execute("sp_mdclleerrut", Envia) Then
             
             MsgBox "Consulta en Bactrader Ha Fallado. Servidor SQL No Responde", vbCritical, TITSISTEMA
             Exit Sub
         
         End If
       
        
         If Bac_SQL_Fetch(Datos()) Then
            
            If MsgBox("Esta Seguro de Eliminar el Cliente", 36, TITSISTEMA) = 6 Then
            
               'Sql = "SP_CLELIMINAR1 " & TXTRUT.Text & "," & txtCODIGO.Text
               
               Envia = Array()
               
               AddParam Envia, CDbl(txtrut.Text)
               AddParam Envia, CDbl(txtCodigo.Text)
               
               If Not Bac_Sql_Execute("SP_CLELIMINAR1", Envia) Then
                  
                  MsgBox "Error : No eliminó el Cliente ", 16, TITSISTEMA
                  Exit Sub
               
               End If
               
               MsgBox "Eliminación se realizó correctamente", vbInformation, TITSISTEMA
               Call Limpiar
               Call HabilitarControles(False)
               txtrut.SetFocus
            
            End If
         Else
            
            MsgBox "Los datos no han sido grabados", vbCritical, TITSISTEMA
            txtgeneric.SetFocus
         
         End If

      Case 3
         
         Call Limpiar
         txtCodigo.Text = ""
         Call HabilitarControles(False)
         
         txtrut.SetFocus
      Case 4
         
         On Error Resume Next
             
             BacRelacionCliente.Show 1
         
         On Error GoTo 0
      
      Case 5
         
         Unload Me
   
   End Select

End Sub

Private Sub Txt1Apellido_KeyPress(KeyAscii As Integer)

 Txt1Apellido.MaxLength = 15

 BacToUCase KeyAscii
 If KeyAscii = 13 Then
  SendKeys "{tab}"
 End If
End Sub

Private Sub Txt1Nombre_KeyPress(KeyAscii As Integer)

Txt1Nombre.MaxLength = 15

  BacToUCase KeyAscii
  If KeyAscii = 13 Then
   Txt2Nombre.SetFocus
 End If
End Sub


Private Sub Txt2Apellido_KeyPress(KeyAscii As Integer)

Txt2Apellido.MaxLength = 15

 BacToUCase KeyAscii
 If KeyAscii = 13 Then
  Txt1Nombre.SetFocus
 End If
End Sub

Private Sub Txt2Nombre_KeyPress(KeyAscii As Integer)

Txt2Nombre.MaxLength = 15

 BacToUCase KeyAscii
 If KeyAscii = 13 Then
  SendKeys "{tab}"
 End If
End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys "{TAB}"

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
      BacCaracterNumerico KeyAscii
   End If
     
   
End Sub



Private Sub TxtCodigo_LostFocus()
   Dim idRut     As Long
   Dim IdDig     As String
   Dim IdCod     As Long
   Dim Bandera   As Integer
   Dim i As Long
   
   If Val(txtrut.Text) = 0 Or Trim(txtDigito.Text) = "" Then Exit Sub
   
  Bandera = True
  
  If Trim(txtCodigo) = "" Or Trim(txtrut) = "" Then
      
      If Val(txtCodigo) = 0 Then
         MsgBox "Error : El código no puede ser 0 ", 16, TITSISTEMA
      Else
         MsgBox "Error : Datos en Blanco ", 16, TITSISTEMA
      End If
      
      Call Limpiar
      Call HabilitarControles(False)
      txtrut.SetFocus
      
      Exit Sub
 End If
 
 idRut = txtrut.Text
 IdDig = txtDigito.Text
 IdCod = txtCodigo

 Inicializa_Pais

 Call Busca_Cliente(idRut, IdDig, IdCod)
 
 txtgeneric.SetFocus

End Sub

Function Busca_Cliente(nRut As Long, nDigito As String, nCodigo As Long) As Boolean
Dim Sql As String
Dim Datos()
Dim datosSTR As String

Screen.MousePointer = 11

    
    Busca_Cliente = False
    
'''''''''''''''''''''''''''''''''''''    Sql = "EXECUTE sp_mdclleerrut "
'''''''''''''''''''''''''''''''''''''    Sql = Sql & nRut
'''''''''''''''''''''''''''''''''''''    Sql = Sql & ",'" & nDigito & "'"
'''''''''''''''''''''''''''''''''''''    Sql = Sql & "," & nCodigo
          
    Envia = Array()
    
    AddParam Envia, CDbl(nRut)
    AddParam Envia, nDigito
    AddParam Envia, CDbl(nCodigo)
    
          
    If Not Bac_Sql_Execute("sp_mdclleerrut", Envia) Then
        
        MsgBox "Consulta en BacParametros Ha Fallado. Servidor SQL No Responde", vbCritical, TITSISTEMA
        Exit Function
    
    End If
       
        
    If Bac_SQL_Fetch(Datos()) Then
    
    'TEXTOS
      txtrut.Text = Val(Datos(1))
      txtDigito.Text = Datos(2)
      txtCodigo.Text = Val(Datos(3))
      txtnombre.Text = Datos(4)
      txtnombre.Tag = txtnombre.Text
      
      txtgeneric.Text = Datos(5)
      TxtDireccion.Text = Datos(6)
      txtCtaCte.Text = Datos(11)
      TxtTelefono.Text = Datos(12)
       TxtFax.Text = Datos(13)
      Txt1Nombre.Text = Datos(22)
      Txt1Nombre.Tag = Txt1Nombre.Text
      Txt2Nombre.Text = Datos(23)
      Txt2Nombre.Tag = Txt2Nombre.Text
      Txt1Apellido.Text = Datos(24)
     Txt1Apellido.Tag = Txt1Apellido.Text
      Txt2Apellido.Text = Datos(25)
      Txt2Apellido.Tag = Txt2Apellido.Text
      TxtCtaUSD.Text = Datos(27)
      txtCodigoSuper.Text = Val(Datos(49))
      txtCodigoBCCH.Text = Val(Datos(50))
      
      txtCRF.Text = Trim(Datos(51))
      txtERF.Text = Trim(Datos(52))
      TxtvctoLinea.Text = Format(Datos(53), "dd/MM/YYYY")
      ''TxtvctoLinea.Text = Format(Datos(53), "DD/MM/YYYY")
      'txtCRiesgo.Text = Datos(55)'INQABILITADO
'COMBOS
      If cmbPais.ListCount > 0 Then
      cmbPais.ListIndex = Busca_Codigo_Combo(cmbPais, Str(Datos(21))) '    CDbl(Val(datos(21)))
      End If
      If CmbCiudad.ListCount > 0 Then
      CmbCiudad.ListIndex = Busca_Codigo_Combo(CmbCiudad, Str(Datos(16)))
      End If
      If CmbComuna.ListCount > 0 Then
      CmbComuna.ListIndex = Busca_Codigo_Combo(CmbComuna, Str(Datos(7)))
      End If
      If CmbCalidadJuridica.ListCount > 0 Then
      CmbCalidadJuridica.ListIndex = Busca_Codigo_Combo(CmbCalidadJuridica, Str(Datos(15)))
      End If
      If CmbMercado.ListCount > 0 Then
      CmbMercado.ListIndex = Busca_Codigo_Combo(CmbMercado, Str(Datos(18)))
      End If
      If cmbRGBanco.ListCount > 0 Then
      cmbRGBanco.ListIndex = Busca_Codigo_Combo(cmbRGBanco, Str(Datos(33)))
      End If
      If cmbCategoriaDeudor.ListCount > 0 Then
      cmbCategoriaDeudor.ListIndex = Busca_Codigo_Combo(cmbCategoriaDeudor, Str(Datos(34)))
      End If
      If cmbComInstitucional.ListCount > 0 Then
      cmbComInstitucional.ListIndex = Busca_Codigo_Combo(cmbComInstitucional, Str(Datos(35)))
      End If
      If cmbClasificacion.ListCount > 0 Then
      datosSTR = Datos(36)
      cmbClasificacion.ListIndex = Busca_Codigo_Combo(cmbClasificacion, datosSTR)
      End If
      If cmbActividadEconomica.ListCount > 0 Then
      cmbActividadEconomica.ListIndex = Busca_Codigo_Combo(cmbActividadEconomica, Str(Datos(37)))
      End If
      If cmbTipoCliente.ListCount > 0 Then
          Dim Texto1
          Dim DA
          Dim x
      For x = 0 To cmbTipoCliente.ListCount - 1
              Texto1 = FUNC_ENTREGA_CODIGO_CLIENTE(Str(Datos(14)))
              cmbTipoCliente.ListIndex = x
              DA = Trim(Mid(cmbTipoCliente.Text, 1, (Val(Len(cmbTipoCliente.Text) - 5))))
              If DA = Texto1 Then
                      Exit For
              End If
       Next x
      End If
      If cmbRelBanco.ListCount > 0 Then
      cmbRelBanco.ListIndex = Busca_Codigo_Combo(cmbRelBanco, Str(Datos(39)))
      End If
      
'CHECK Y OPTIONS
      If Datos(28) = "A" Then
            OpImplic(0).Value = True                           'Si es código ABA
            TxtCod.Text = Datos(29)
      ElseIf Datos(28) = "C" Then
            OpImplic(1).Value = True                           'Si es código CHIPS
            TxtCod.Text = Datos(30)
      Else
            OpImplic(2).Value = True                          'Si es código SWIFF
            TxtCod.Text = Datos(31)
      End If
    
      If Datos(32) = "J" Then
            SSOption2.Value = True
      Else
            SSOption1.Value = True
      End If
      
      chkPoder.Value = IIf(Datos(40) = "N", 0, 1)                     'Check Poder: Toma valores 1 ó 0
      chkFirma.Value = IIf(Datos(41) = "N", 0, 1)                      'Check Firma: Toma valores 1 ó 0
      chkInformeSocial.Value = IIf(Datos(44) = "N", 0, 1)         'Check Inf.Social: Toma valores 1 ó 0
      chkOficinas.Value = IIf(Datos(54) = "N", 0, 1)
      If Datos(45) = "N" Then                                                  'check Art. 85 :Toma valores 1 ó 0
           chkArticulo85.Value = 0
      Else
           chkArticulo85.Value = 1                                                'Si el valor tomado por check es 1
           If Datos(46) = "C" Then                                               'Si la dec 85 es cliente o banco
                opCliente.Value = True
           Else
                opBanco.Value = True
           End If
      End If
      
      txtCodContable.Text = Val(Datos(48))
      
    Else
    
      'TEXTOS
      txtnombre.Text = ""
      txtnombre.Tag = ""
      txtgeneric.Text = ""
      TxtDireccion.Text = ""
      txtCtaCte.Text = ""
      TxtTelefono.Text = ""
       TxtFax.Text = ""
      Txt1Nombre.Text = ""
      Txt1Nombre.Tag = ""
      Txt2Nombre.Text = ""
      Txt2Nombre.Tag = ""
      Txt1Apellido.Text = ""
     Txt1Apellido.Tag = ""
      Txt2Apellido.Text = ""
      Txt2Apellido.Tag = ""
      TxtCtaUSD.Text = ""
      txtCRiesgo.Text = ""
'COMBOS
      cmbPais.ListIndex = BuscaEnCombo(cmbPais, "CHILE", "G")
      
'      CmbCalidadJuridica.ListIndex = 0
'      CmbMercado.ListIndex = 0
'      cmbRGBanco.ListIndex = 0
'      cmbCategoriaDeudor.ListIndex = 0
'      cmbComInstitucional.ListIndex = 0
'      cmbClasificacion.ListIndex = 0
'      cmbActividadEconomica.ListIndex = 0
'      cmbTipoCliente.ListIndex = 0
'      cmbRelBanco.ListIndex = 0
      
'CHECK Y OPTIONS
      
       OpImplic(0).Value = True                           'Si es código ABA
      TxtCod.Text = ""
       SSOption2.Value = True
      
      
      chkPoder.Value = 0
      chkFirma.Value = 0
      chkInformeSocial.Value = 0
      chkArticulo85.Value = 0
      opCliente.Value = True
      Generar_Codigo_Fox
      
      
      End If
      
    HabilitarControles True


    
     Screen.MousePointer = 0
     
End Function

Function Generar_Codigo_Fox()
Dim Sql As String
Dim Datos()
Sql = "SELECT ISNULL(MAX(clcodfox),1) FROM Cliente"
    If MISQL.SQL_Execute(Sql) <> 0 Then
        MsgBox "Consulta en Bactrader Ha Fallado. Servidor SQL No Responde", vbCritical, TITSISTEMA
        Exit Function
    End If
            
    If MISQL.SQL_Fetch(Datos()) = 0 Then
         txtCodContable.Text = Val(Datos(1)) + 1
    End If
End Function

Private Sub txtCodigoBancoCentral_Change()

End Sub


Private Sub txtCodigoBCCH_KeyPress(KeyAscii As Integer)
txtCodigoBCCH.MaxLength = 3
If KeyAscii = 13 Then
    SendKeys "{TAB}"
    Exit Sub
End If
If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 13 And KeyAscii <> 8 Then KeyAscii = 0
End Sub

Private Sub txtCodigoSuper_KeyPress(KeyAscii As Integer)

txtCodigoSuper.MaxLength = 3
If KeyAscii = 13 Then
    SendKeys "{TAB}"
    Exit Sub
End If
If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 13 And KeyAscii <> 8 Then KeyAscii = 0

End Sub

Private Sub txtCRF_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    SendKeys "{TAB}"
    Exit Sub
End If
 BacToUCase KeyAscii
End Sub

Private Sub txtCRiesgo_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    SendKeys "{TAB}"
    Exit Sub
End If
   BacToUCase KeyAscii
End Sub

Private Sub txtctacte_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii
  If KeyAscii% = 39 Or KeyAscii% = 34 Then
      KeyAscii% = 0
   Else
    If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
    End If
   End If

End Sub

Private Sub TxtCtaUSD_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then SendKeys "{tab}"
End Sub


Private Sub txtDigito_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 75 Or KeyAscii = 107 Or KeyAscii = 8) Then
      KeyAscii = 0

   End If

   BacToUCase KeyAscii

End Sub


Private Sub txtDigito_LostFocus()

If Not Controla_RUT(txtrut, txtDigito) Then
    MsgBox "Digito No corresponde al RUT.", vbOKOnly + vbExclamation, TITSISTEMA
    txtDigito.Text = ""
    'Txtrut.Enabled = True
    txtrut.SetFocus
End If

End Sub

Private Sub TxtDireccion_KeyPress(KeyAscii As Integer)
   BacToUCase KeyAscii
   If KeyAscii% = 39 Or KeyAscii% = 34 Then
      KeyAscii% = 0
   Else
    If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
    End If
   End If
End Sub


Private Sub txtERF_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    SendKeys "{TAB}"
    Exit Sub
End If
   BacToUCase KeyAscii
End Sub

Private Sub txtFax_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii

   If KeyAscii% = 39 Or KeyAscii% = 34 Then
      KeyAscii% = 0
   Else
      If KeyAscii% = vbKeyReturn Then
         KeyAscii% = 0
         SendKeys$ "{TAB}"
      End If
   End If

End Sub


Private Sub txtgeneric_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii

    If KeyAscii% = 39 Or KeyAscii% = 34 Then
      KeyAscii% = 0
   Else
    If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      If SSOption1.Value = True Then
          SendKeys "{Tab}"
      Else
          txtnombre.SetFocus
      End If
     
     
    End If
   End If

End Sub

Private Sub txtgeneric_LostFocus()
         
    If Not SSOption1.Value Then
    If txtnombre.Visible = True Then
            txtnombre.Enabled = True
          txtnombre.SetFocus
      End If
     End If
     Me.MousePointer = Default
End Sub

Private Sub TxtNombre_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
  SendKeys "{tab}"
End If
End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)
   txtnombre.MaxLength = 40
End Sub

Private Sub txtRut_DblClick()
BacControlWindows 100
BacAyuda.Tag = "MDCL"
BacAyuda.Show 1

If giAceptar% = True Then
      
    txtrut.Text = Val(gsrut$)
    txtDigito.Text = gsDigito$
    txtCodigo = gsValor$
    txtDigito.SetFocus
    
    Call HabilitarControles(True)
    SendKeys "{TAB}"

End If
       

End Sub


Private Sub txtRut_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF3 Then Call txtRut_DblClick
End Sub

Private Sub txtrut_KeyPress(KeyAscii As Integer)

   
   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
     
   End If
     
   BacCaracterNumerico KeyAscii
   
End Sub

   


Private Sub TxtTelefono_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii

  If KeyAscii% = 39 Or KeyAscii% = 34 Then
      KeyAscii% = 0
   Else
    If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"
    End If
   End If

End Sub

Private Sub TipoNombre(Valor As Boolean)
              Txt1Nombre.Visible = Valor
              Txt2Nombre.Visible = Valor
              Txt1Apellido.Visible = Valor
              Txt2Apellido.Visible = Valor
              Label(2).Visible = Valor
              Label(20).Visible = Valor
              Label(21).Visible = Valor
              
              Label(18).Visible = Not Valor
              txtnombre.Visible = Not Valor
              
End Sub


Function FUNC_ENTREGA_TIPO_CLIENTE(Combo As Control) As Integer
Dim Sql As String
Dim Datos()

FUNC_ENTREGA_TIPO_CLIENTE = 1

'Sql = "SELECT TBGLOSA FROM TABLA_GENERAL_DETALLE  WHERE Codigo = '" + Trim(Str(MDTC_TIPOCLIENTE)) + Trim(Right(Combo.Text, 4)) + "'"
Sql = "SELECT CTCATEG FROM TABLA_GENERAL_GLOBAL  WHERE CTCATEG =" + Trim(Right(Combo.Text, 4)) + ""


If MISQL.SQL_Execute(Sql) <> 0 Then Exit Function

If MISQL.SQL_Fetch(Datos()) = 0 Then FUNC_ENTREGA_TIPO_CLIENTE = Val(Datos(1))

End Function
Function FUNC_ENTREGA_CODIGO_CLIENTE(ftipocliente As Integer) As String
Dim Sql As String
Dim Datos()

FUNC_ENTREGA_CODIGO_CLIENTE = 1

Sql = "SELECT CTDESCRIP FROM TABLA_GENERAL_GLOBAL WHERE CTCATEG = " & ftipocliente

If MISQL.SQL_Execute(Sql) <> 0 Then Exit Function

If MISQL.SQL_Fetch(Datos()) = 0 Then FUNC_ENTREGA_CODIGO_CLIENTE = Datos(1)

End Function


Sub FUNC_BUSCA_CODIGOS_MDTC(Codigo_Mdtc As Long, Combo As Control)
Dim Sql As String

If swauxiliar = 0 Then
     
     'Sql = "sp_leercodigos " & Codigo_Mdtc
     
     Envia = Array()
     
     AddParam Envia, Codigo_Mdtc
     
     If Not Bac_Sql_Execute("sp_leercodigos", Envia) Then Exit Sub
     
     Do While Bac_SQL_Fetch(Datos())
         
         If Codigo_Mdtc = MDTC_CLASIFICACION Then
             
             Combo.AddItem Trim(Datos(1)) & Space((10 - Len(Datos(1)))) & Trim(Datos(2))
             Combo.ItemData(Combo.NewIndex) = Datos(2)
         
         Else
             
             Combo.AddItem Trim(Datos(6)) & Space(60) & Trim(Datos(1)) & Space(10) & Trim(Datos(2))
         
         End If
     
     Loop

Else
      Sql = "sp_traecategoria"
      
      If Not Bac_Sql_Execute("sp_traecategoria") Then Exit Sub
          
          Do While Bac_SQL_Fetch(Datos()) = 0
               
               Combo.AddItem Trim(Datos(2)) & Space(50) & Trim(Datos(1))
          
          Loop
      
      End If
End Sub

Function Busca_Codigo_Combo(Combo2 As Control, codigo As String) As Integer
Dim i As Integer

If Combo2.ListCount > 0 Then
    
    For i = 0 To Combo2.ListCount - 1
           
           If Trim(Right(Combo2.List(i%), 10)) = Trim(codigo) Then
                
                Busca_Codigo_Combo = i
                Exit For
           
           End If
    
    Next i
    
    If i > Combo2.ListCount - 1 Then i = 1

Else
    
    MsgBox "El combo " & Combo2 & " se encuentra vacio ", vbCritical, TITSISTEMA

End If

'If Combo2.ListCount > 0 Then
'    For i = 0 To Combo2.ListCount - 1
'               text = Str(Val(Len(Combo2.List) - 5))
'               If text = codigo Then
'                    Busca_Codigo_Combo = i
'                    Exit For
'               End If
'    Next i
'    If i > Combo2.ListCount - 1 Then i = 1
'Else
'    MsgBox "El combo " & Combo2 & " se encuentra vacio ", vbCritical, "Bac_Trader"
'End If

End Function

Private Sub txtVctoLinea_KeyPress(KeyAscii As Integer)

            If KeyAscii = 13 Then SendKeys "{TAB}"

End Sub

Private Function TraeValor(xValor As Variant) As Double

   If xValor = "" Then
   
      TraeValor = 0
      
   Else
      
      TraeValor = xValor

   End If

End Function

Sub Carga()
   
   FUNC_BUSCA_CODIGOS_MDTC MDTC_Pais, cmbPais
   FUNC_BUSCA_CODIGOS_MDTC MDTC_MERCADO, CmbMercado
   FUNC_BUSCA_CODIGOS_MDTC MDTC_CALIDADJURIDICA, CmbCalidadJuridica
   FUNC_BUSCA_CODIGOS_MDTC MDTC_RGBANCO, cmbRGBanco
   FUNC_BUSCA_CODIGOS_MDTC MDTC_RELACION, cmbRelBanco
   FUNC_BUSCA_CODIGOS_MDTC MDTC_CATEGORIADEUDOR, cmbCategoriaDeudor
   swauxiliar = 100
   FUNC_BUSCA_CODIGOS_MDTC MDTC_TIPOCLIENTE, cmbTipoCliente
   swauxiliar = 0
   FUNC_BUSCA_CODIGOS_MDTC MDTC_COMINSTITUCIONAL, cmbComInstitucional
   FUNC_BUSCA_CODIGOS_MDTC MDTC_ACTIVIDADECONOMICA, cmbActividadEconomica
   FUNC_BUSCA_CODIGOS_MDTC MDTC_CLASIFICACION, cmbClasificacion
   FUNC_BUSCA_CODIGOS_MDTC MDTC_CIUDAD, CmbCiudad
   'FUNC_BUSCA_CODIGOS_MDTC MDTC_GRUPOS, CmbGrupos
   'swauxiliar = 0
End Sub
