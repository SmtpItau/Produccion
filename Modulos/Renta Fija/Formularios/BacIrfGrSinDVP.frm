VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACControles.ocx"
Begin VB.Form BacIrfGrSinDVP 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "GRABAR OPERACION"
   ClientHeight    =   8205
   ClientLeft      =   7320
   ClientTop       =   4065
   ClientWidth     =   9960
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8205
   ScaleWidth      =   9960
   ShowInTaskbar   =   0   'False
   Begin VB.Frame FrmContraparte 
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
      Height          =   975
      Left            =   60
      TabIndex        =   71
      Top             =   7080
      Visible         =   0   'False
      Width           =   9825
      Begin VB.TextBox TxtNombreContra 
         Height          =   315
         Left            =   2940
         TabIndex        =   74
         Top             =   480
         Width           =   6705
      End
      Begin VB.TextBox TxtRutContraparte 
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
         Left            =   120
         MaxLength       =   9
         MouseIcon       =   "BacIrfGrSinDVP.frx":0000
         TabIndex        =   73
         Top             =   480
         Width           =   1200
      End
      Begin VB.TextBox TxtContraCod 
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
         Left            =   1560
         MaxLength       =   7
         TabIndex        =   72
         Text            =   "1"
         Top             =   480
         Width           =   1035
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
         Height          =   255
         Index           =   23
         Left            =   120
         TabIndex        =   78
         Top             =   240
         Width           =   825
      End
      Begin VB.Label Label 
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
         Height          =   210
         Index           =   22
         Left            =   2940
         TabIndex        =   77
         Top             =   255
         Width           =   885
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
         Height          =   225
         Index           =   21
         Left            =   1320
         TabIndex        =   76
         Top             =   480
         Visible         =   0   'False
         Width           =   270
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
         Height          =   210
         Index           =   20
         Left            =   1560
         TabIndex        =   75
         Top             =   255
         Width           =   765
      End
   End
   Begin VB.Frame Frame2 
      Height          =   1065
      Left            =   5640
      TabIndex        =   63
      Top             =   11040
      Width           =   2985
      Begin MSFlexGridLib.MSFlexGrid mfgTemporal 
         Height          =   915
         Left            =   60
         TabIndex        =   64
         Top             =   360
         Width           =   2865
         _ExtentX        =   5054
         _ExtentY        =   1614
         _Version        =   393216
      End
   End
   Begin VB.TextBox txtRutCar 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      Height          =   285
      Left            =   375
      MaxLength       =   9
      MouseIcon       =   "BacIrfGrSinDVP.frx":030A
      MousePointer    =   99  'Custom
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   7110
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.TextBox txtDigCli 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   1605
      MaxLength       =   1
      TabIndex        =   0
      Top             =   7095
      Visible         =   0   'False
      Width           =   240
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6075
      Top             =   45
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacIrfGrSinDVP.frx":0614
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacIrfGrSinDVP.frx":0A66
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   9960
      _ExtentX        =   17568
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbgrabar"
            Description     =   "GRABAR"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbcancelar"
            Description     =   "CANCELAR"
            Object.ToolTipText     =   "Cancelar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSCommand cmdAceptar 
      Height          =   450
      Left            =   -30
      TabIndex        =   3
      Top             =   11820
      Visible         =   0   'False
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Grabar"
      ForeColor       =   8388608
      Font3D          =   3
   End
   Begin Threed.SSCommand cmdCancelar 
      Height          =   450
      Left            =   1200
      TabIndex        =   4
      Top             =   11835
      Visible         =   0   'False
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Cancelar"
      ForeColor       =   8388608
      Font3D          =   3
   End
   Begin Threed.SSCheck ChkCustod 
      Height          =   285
      Left            =   2355
      TabIndex        =   5
      Top             =   7080
      Visible         =   0   'False
      Width           =   1425
      _Version        =   65536
      _ExtentX        =   2514
      _ExtentY        =   503
      _StockProps     =   78
      Caption         =   "Con Láminas"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSFrame Marco 
      Height          =   960
      Index           =   3
      Left            =   60
      TabIndex        =   6
      Top             =   465
      Width           =   9825
      _Version        =   65536
      _ExtentX        =   17330
      _ExtentY        =   1693
      _StockProps     =   14
      Caption         =   "Cliente"
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
      Begin VB.TextBox TxtCodCli 
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
         Left            =   1560
         MaxLength       =   7
         TabIndex        =   9
         Text            =   "1"
         Top             =   510
         Width           =   1035
      End
      Begin VB.TextBox txtRutCli 
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
         Left            =   120
         MaxLength       =   9
         MouseIcon       =   "BacIrfGrSinDVP.frx":0EB8
         MousePointer    =   99  'Custom
         TabIndex        =   8
         Top             =   510
         Width           =   1200
      End
      Begin VB.TextBox TxtNomCli 
         Height          =   315
         Left            =   2940
         TabIndex        =   7
         Top             =   510
         Width           =   6705
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
         Height          =   210
         Index           =   9
         Left            =   1560
         TabIndex        =   14
         Top             =   285
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
         Height          =   225
         Index           =   0
         Left            =   1320
         TabIndex        =   13
         Top             =   510
         Visible         =   0   'False
         Width           =   270
      End
      Begin VB.Label Label 
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
         Height          =   210
         Index           =   7
         Left            =   2940
         TabIndex        =   12
         Top             =   285
         Width           =   885
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
         Height          =   255
         Index           =   5
         Left            =   120
         TabIndex        =   11
         Top             =   270
         Width           =   825
      End
      Begin VB.Label LblEstadoCliente 
         Alignment       =   2  'Center
         ForeColor       =   &H000000FF&
         Height          =   195
         Left            =   4200
         TabIndex        =   10
         Top             =   210
         Width           =   4845
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   4845
      Index           =   0
      Left            =   60
      TabIndex        =   15
      Top             =   1440
      Width           =   9825
      _Version        =   65536
      _ExtentX        =   17330
      _ExtentY        =   8546
      _StockProps     =   14
      Caption         =   "Operación"
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
         Left            =   6720
         TabIndex        =   79
         Top             =   2880
         Value           =   1  'Checked
         Visible         =   0   'False
         Width           =   1935
      End
      Begin VB.ComboBox cmbEjecutivo 
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
         TabIndex        =   69
         Top             =   2175
         Width           =   3225
      End
      Begin VB.ComboBox cmbRentabilidad 
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
         Left            =   3360
         Style           =   2  'Dropdown List
         TabIndex        =   67
         Top             =   2160
         Visible         =   0   'False
         Width           =   3210
      End
      Begin VB.ComboBox CmbVolckerRule 
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
         Left            =   6600
         TabIndex        =   65
         Text            =   "CmbCVolckerRule"
         Top             =   2160
         Visible         =   0   'False
         Width           =   3150
      End
      Begin VB.TextBox txtNomCar 
         BackColor       =   &H00FFFFFF&
         Enabled         =   0   'False
         Height          =   285
         Left            =   1845
         TabIndex        =   43
         Top             =   5670
         Width           =   3030
      End
      Begin VB.TextBox txtDigCar 
         BackColor       =   &H00FFFFFF&
         Enabled         =   0   'False
         Height          =   285
         Left            =   1485
         MaxLength       =   1
         TabIndex        =   42
         Top             =   5670
         Width           =   255
      End
      Begin VB.ComboBox cmbTCart 
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
         ItemData        =   "BacIrfGrSinDVP.frx":11C2
         Left            =   4950
         List            =   "BacIrfGrSinDVP.frx":11C4
         Style           =   2  'Dropdown List
         TabIndex        =   41
         Top             =   465
         Width           =   2370
      End
      Begin VB.ComboBox cmbFPagoIni 
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
         ItemData        =   "BacIrfGrSinDVP.frx":11C6
         Left            =   105
         List            =   "BacIrfGrSinDVP.frx":11C8
         Style           =   2  'Dropdown List
         TabIndex        =   40
         Top             =   1605
         Width           =   3225
      End
      Begin VB.ComboBox cmbFPagoVct 
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
         ItemData        =   "BacIrfGrSinDVP.frx":11CA
         Left            =   3360
         List            =   "BacIrfGrSinDVP.frx":11CC
         Style           =   2  'Dropdown List
         TabIndex        =   39
         Top             =   1590
         Width           =   3210
      End
      Begin VB.ComboBox cmbEntidad 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   38
         Top             =   465
         Width           =   2370
      End
      Begin VB.ComboBox cmbMercado 
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
         ItemData        =   "BacIrfGrSinDVP.frx":11CE
         Left            =   7380
         List            =   "BacIrfGrSinDVP.frx":11DB
         Style           =   2  'Dropdown List
         TabIndex        =   37
         Top             =   465
         Width           =   2370
      End
      Begin VB.ComboBox cmbSucursal 
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
         ItemData        =   "BacIrfGrSinDVP.frx":11FC
         Left            =   6600
         List            =   "BacIrfGrSinDVP.frx":120C
         Style           =   2  'Dropdown List
         TabIndex        =   36
         Top             =   1590
         Visible         =   0   'False
         Width           =   3150
      End
      Begin VB.ComboBox cmbArea 
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
         ItemData        =   "BacIrfGrSinDVP.frx":1246
         Left            =   105
         List            =   "BacIrfGrSinDVP.frx":1248
         Style           =   2  'Dropdown List
         TabIndex        =   35
         Top             =   1050
         Width           =   3225
      End
      Begin VB.ComboBox cmbTipoPago 
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
         ItemData        =   "BacIrfGrSinDVP.frx":124A
         Left            =   120
         List            =   "BacIrfGrSinDVP.frx":1257
         Style           =   2  'Dropdown List
         TabIndex        =   34
         Top             =   3450
         Width           =   2370
      End
      Begin VB.ComboBox cmbTipoInversion 
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
         ItemData        =   "BacIrfGrSinDVP.frx":126D
         Left            =   3345
         List            =   "BacIrfGrSinDVP.frx":1277
         Style           =   2  'Dropdown List
         TabIndex        =   29
         Top             =   1035
         Visible         =   0   'False
         Width           =   3210
      End
      Begin VB.Frame Frame1 
         Caption         =   "Cuenta Corriente"
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
         Height          =   1455
         Left            =   4425
         TabIndex        =   20
         Top             =   3240
         Width           =   5340
         Begin VB.ComboBox cmbSucInicio 
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
            ItemData        =   "BacIrfGrSinDVP.frx":1288
            Left            =   60
            List            =   "BacIrfGrSinDVP.frx":128F
            Style           =   2  'Dropdown List
            TabIndex        =   24
            Top             =   435
            Width           =   2970
         End
         Begin VB.TextBox txtCtaCteInicio 
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
            Left            =   3105
            MaxLength       =   9
            MouseIcon       =   "BacIrfGrSinDVP.frx":12A3
            MousePointer    =   99  'Custom
            TabIndex        =   23
            Top             =   435
            Width           =   2145
         End
         Begin VB.TextBox txtCtaCteFinal 
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
            Left            =   3105
            MaxLength       =   9
            MouseIcon       =   "BacIrfGrSinDVP.frx":15AD
            MousePointer    =   99  'Custom
            TabIndex        =   22
            Top             =   1035
            Width           =   2145
         End
         Begin VB.ComboBox cmbSucFinal 
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
            ItemData        =   "BacIrfGrSinDVP.frx":18B7
            Left            =   60
            List            =   "BacIrfGrSinDVP.frx":18BE
            Style           =   2  'Dropdown List
            TabIndex        =   21
            Top             =   1035
            Width           =   2955
         End
         Begin VB.Label Label 
            Caption         =   "Sucursal Final"
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
            Height          =   165
            Index           =   19
            Left            =   75
            TabIndex        =   28
            Top             =   825
            Width           =   1365
         End
         Begin VB.Label Label 
            Caption         =   "Sucursal Inicio"
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
            Index           =   18
            Left            =   75
            TabIndex        =   27
            Top             =   240
            Width           =   1335
         End
         Begin VB.Label Label 
            Caption         =   "Cuenta Corriente Inicio"
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
            Index           =   15
            Left            =   3090
            TabIndex        =   26
            Top             =   240
            Width           =   2160
         End
         Begin VB.Label Label 
            Caption         =   "Cuenta Corriente Final"
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
            Left            =   3090
            TabIndex        =   25
            Top             =   825
            Width           =   2175
         End
      End
      Begin VB.ComboBox CmdCorresponsal 
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
         ItemData        =   "BacIrfGrSinDVP.frx":18D2
         Left            =   120
         List            =   "BacIrfGrSinDVP.frx":18DC
         Style           =   2  'Dropdown List
         TabIndex        =   19
         Top             =   2850
         Width           =   6255
      End
      Begin VB.ComboBox CmbCodCorresponsal 
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
         ItemData        =   "BacIrfGrSinDVP.frx":18ED
         Left            =   5880
         List            =   "BacIrfGrSinDVP.frx":18F7
         Style           =   2  'Dropdown List
         TabIndex        =   18
         Top             =   2850
         Visible         =   0   'False
         Width           =   615
      End
      Begin VB.ComboBox CmbLibro 
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
         Left            =   2520
         Style           =   2  'Dropdown List
         TabIndex        =   17
         Top             =   465
         Width           =   2370
      End
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
         Left            =   6600
         Style           =   2  'Dropdown List
         TabIndex        =   16
         Top             =   1035
         Visible         =   0   'False
         Width           =   3150
      End
      Begin Threed.SSFrame Marco 
         Height          =   585
         Index           =   1
         Left            =   135
         TabIndex        =   30
         Top             =   4080
         Width           =   2370
         _Version        =   65536
         _ExtentX        =   4180
         _ExtentY        =   1032
         _StockProps     =   14
         Caption         =   "Tipo Retiro"
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
         Begin Threed.SSOption ChkVamos 
            Height          =   195
            Left            =   120
            TabIndex        =   31
            Top             =   285
            Width           =   915
            _Version        =   65536
            _ExtentX        =   1614
            _ExtentY        =   344
            _StockProps     =   78
            Caption         =   "Vamos"
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
         End
         Begin Threed.SSOption ChkVienen 
            Height          =   180
            Left            =   1275
            TabIndex        =   32
            Top             =   285
            Width           =   930
            _Version        =   65536
            _ExtentX        =   1640
            _ExtentY        =   317
            _StockProps     =   78
            Caption         =   "Vienen"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.24
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
      End
      Begin BACControles.TXTFecha txtFechaPago 
         Height          =   315
         Left            =   2505
         TabIndex        =   33
         Top             =   3450
         Width           =   1815
         _ExtentX        =   3201
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
         MaxDate         =   2958465
         MinDate         =   2
         Text            =   "01/01/1900"
      End
      Begin Threed.SSFrame Marco 
         Height          =   570
         Index           =   4
         Left            =   2520
         TabIndex        =   44
         Top             =   4080
         Width           =   1680
         _Version        =   65536
         _ExtentX        =   2963
         _ExtentY        =   1005
         _StockProps     =   14
         Caption         =   "¿Láminas?"
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
         Begin Threed.SSOption optSi 
            Height          =   300
            Left            =   120
            TabIndex        =   45
            Top             =   240
            Width           =   645
            _Version        =   65536
            _ExtentX        =   1138
            _ExtentY        =   529
            _StockProps     =   78
            Caption         =   "Si"
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
         End
         Begin Threed.SSOption optNo 
            Height          =   300
            Left            =   885
            TabIndex        =   46
            Top             =   240
            Width           =   615
            _Version        =   65536
            _ExtentX        =   1085
            _ExtentY        =   529
            _StockProps     =   78
            Caption         =   "No"
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
         End
      End
      Begin VB.Label lblEjecutivo 
         Alignment       =   1  'Right Justify
         AutoSize        =   -1  'True
         Caption         =   "Ejecutivo"
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
         TabIndex        =   70
         Top             =   1965
         Width           =   810
      End
      Begin VB.Label lblTtipoRent 
         AutoSize        =   -1  'True
         Caption         =   "Tipo Rentabilidad"
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
         Left            =   3345
         TabIndex        =   68
         Top             =   1920
         Visible         =   0   'False
         Width           =   1515
      End
      Begin VB.Label Label1 
         Caption         =   "Volcker Rule"
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
         Left            =   6600
         TabIndex        =   66
         Top             =   1920
         Visible         =   0   'False
         Width           =   1575
      End
      Begin VB.Label Label 
         Caption         =   "Entidad"
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
         Height          =   180
         Index           =   1
         Left            =   120
         TabIndex        =   59
         Top             =   270
         Width           =   690
      End
      Begin VB.Label Label 
         Caption         =   "Forma de Pago Vencimiento"
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
         Index           =   4
         Left            =   3345
         TabIndex        =   58
         Top             =   1395
         Width           =   3075
      End
      Begin VB.Label Label 
         Caption         =   "Forma de Pago Inicial"
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
         Index           =   2
         Left            =   120
         TabIndex        =   57
         Top             =   1395
         Width           =   3075
      End
      Begin VB.Label Label 
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
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   6
         Left            =   4950
         TabIndex        =   56
         Top             =   270
         Width           =   1575
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
         Left            =   7365
         TabIndex        =   55
         Top             =   270
         Width           =   750
      End
      Begin VB.Label Label 
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
         Height          =   255
         Index           =   10
         Left            =   120
         TabIndex        =   54
         Top             =   840
         Width           =   3075
      End
      Begin VB.Label Label 
         Caption         =   "Modalidad de Pago"
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
         Left            =   120
         TabIndex        =   53
         Top             =   3240
         Width           =   1770
      End
      Begin VB.Label Label 
         Caption         =   "Sucursal"
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
         Index           =   12
         Left            =   6600
         TabIndex        =   52
         Top             =   1395
         Visible         =   0   'False
         Width           =   3075
      End
      Begin VB.Label Label 
         Caption         =   "Fecha de Pago"
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
         Index           =   14
         Left            =   2520
         TabIndex        =   51
         Top             =   3255
         Width           =   1485
      End
      Begin VB.Label Label 
         Caption         =   "Tipo de Inversión"
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
         Left            =   3345
         TabIndex        =   50
         Top             =   825
         Visible         =   0   'False
         Width           =   1695
      End
      Begin VB.Label Label 
         Caption         =   "Corresponsal"
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
         Index           =   3
         Left            =   120
         TabIndex        =   49
         Top             =   2640
         Width           =   3075
      End
      Begin VB.Label lbllibro 
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
         Height          =   165
         Left            =   2535
         TabIndex        =   48
         Top             =   270
         Width           =   570
      End
      Begin VB.Label lblOperador 
         Caption         =   "Operador"
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
         Left            =   6600
         TabIndex        =   47
         Top             =   840
         Visible         =   0   'False
         Width           =   1695
      End
   End
   Begin Threed.SSFrame Marco 
      Height          =   705
      Index           =   2
      Left            =   60
      TabIndex        =   60
      Top             =   6360
      Width           =   9825
      _Version        =   65536
      _ExtentX        =   17330
      _ExtentY        =   1244
      _StockProps     =   14
      Caption         =   "Observaciones"
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
      Begin VB.TextBox TxtObserv 
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
         MaxLength       =   70
         ScrollBars      =   2  'Vertical
         TabIndex        =   61
         Top             =   300
         Width           =   9480
      End
   End
   Begin VB.Label Label 
      Caption         =   "Tipo de Inversión"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   13
      Left            =   15
      TabIndex        =   62
      Top             =   30
      Visible         =   0   'False
      Width           =   1695
   End
End
Attribute VB_Name = "BacIrfGrSinDVP"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim ObjCliente      As New clsCliente
Dim ObjEmisor      As New clsEmisor

Dim objDCartera     As New clsDCarteras
Dim objForPag       As New ClsCodigos
Dim objTipCar       As New ClsCodigos
Dim nMtoCom         As Double
Dim VolckerRule    As Boolean



Public MiTipoPago   As Integer
Public proMtoOper   As Double    ' Monto de Operación
Public proHwnd      As Long      ' Handler
Public proMoneda    As String    ' Moneda Relacionada

'-------CÓDIGO-----------------------------------------
Public proCodMoneda As Integer   ' Moneda Relacionada
Dim objRentabilidad As New ClsCodigos
Dim objEjecutivo As New ClsCodigos
'-------CÓDIGO-----------------------------------------

Public ProDpx       As String
Public cCodCartFin  As String   'codigo cartera financiera
Public cCodLibro    As String   'codigo libro

Public dTotLim_PFE        As Double
Public dTotLim_CCE        As Double

Public cCtaCte              As String

Public oValorDVP            As Variant
Public oDVP                 As Variant
Public FechaSorteoLetras    As Variant
Public FechaReal           As String
Public proTIPINST          As String    ' Tipo de Instrumento (FMUTUO)
Public grabaOperador        As Boolean
Public actDigitador         As Boolean

''PRD-6006 CASS 09-12-2010
Const Col_Marca = 0
Const Col_Tir = 4
Dim Datos()


'******************************* 20181227.RCH.LCGP *******************************
Public oCliente As Variant

Public Static Property Get LCGP_Cliente() As Variant
    LCGP_Cliente = oCliente
End Property

Public Static Property Let LCGP_Cliente(ByVal vNewValue As Variant)
    oCliente = vNewValue
End Property
    
'******************************* 20181227.RCH.LCGP *******************************


Private Function GrabarAC() As Double
'===========================================================================================
'   Function    :   GrabarAC
'   Objetivo    :   Realiza la grabación de las operaciones de anticipo de captacion
'   Fecha       :   20 de Julio de 2000
'   Autor       :   Miguel Gajardo Pulgar
'===========================================================================================
Dim iRutCar$, iTipCar$, iForPagI$, sTipCus$, iForpaV$, sTipDep$
Dim sRetiro$, sPagMan$, sObserv$, iRutCli$
Dim nSw%, nCont%
Dim nCodcli&

    GrabarAC = 0
    
    iRutCar$ = txtRutCar.text
    iTipCar$ = 1
    iForPagI$ = cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex)

    iForpaV$ = 0
    
    If ChkVamos.Value = True Then
        sRetiro$ = "V"
    Else
        sRetiro$ = "I"
    End If
    
    sPagMan$ = ""
    
    sObserv$ = TxtObserv.text
    iRutCli$ = txtRutCli.text
    nCodcli& = TxtCodCli.text
    
    GrabarAC = AC_GrabarTx(iRutCar$, iTipCar$, iForPagI$, iForpaV$, sRetiro$, sPagMan$, sObserv$, iRutCli$, nCodcli&, BacTrader.ActiveForm)
    
End Function
'
Private Sub Ayuda(Index As Integer)

    If Index = 0 Then
        'Dueños de Cartera
        BacAyuda.Tag = "MDCD"
    ElseIf Index = 1 Or Index = 3 Then
        'Clientes
        
        If Mid(BacIrfGrSinDVP.Tag, 1, 2) = "IB" Then
          'BacAyuda.Tag = "MDCL_BCO"
           BacAyudaCliente.Tag = "MDCL_BCO"
        Else
          'BacAyuda.Tag = "MDCL"
           BacAyudaCliente.Tag = "MDCL"
        End If
    End If
    
   'BacAyuda.Show 1
    BacAyudaCliente.Show 1
    BacControlWindows 12
    If giAceptar% = True Then
        If Index = 0 Then
            txtRutCar.text = gsrut$
            txtDigCar.text = gsDigito$
            txtNomCar.text = gsDescripcion$
            
        ElseIf Index = 1 Then
            txtRutCli.text = Val(gsrut$)
            txtDigCli.text = gsDigito$
            TxtNomCli.text = gsDescripcion$
            TxtCodCli.text = gsvalor$
           ' CmbTCart.SetFocus
        '+++jcamposd 20160616 DAP
        ElseIf Index = 3 Then
            TxtRutContraparte.text = Val(gsrut$)
            TxtNombreContra.text = gsDescripcion$
            TxtContraCod.text = gsvalor$
        End If
        '---jcamposd 20160616 DAP
    End If

End Sub
Private Function GrabarRC() As Double

    GrabarRC = 0
    GrabarRC = RC_GrabarTx(Rutcart, _
                           lNumoper, _
                           BacTrader.ActiveForm.TxtTasaAnt.text, _
                           BacTrader.ActiveForm.TxtValAnt.text, _
                           Me.cmbFPagoVct.ItemData(Me.cmbFPagoVct.ListIndex), _
                           BacTrader.ActiveForm.TxtValact.text, _
                           BacTrader.ActiveForm.Txt_TasaTran.text, _
                           BacTrader.ActiveForm.Txt_VpTran.text, _
                           BacTrader.ActiveForm.Txt_DifTran.text)
    
End Function

Private Function GrabarIB() As Double
On Error Resume Next
Dim iRutCar$, iTipCar$, iForPagI$, sTipCus$, iForpaV$
Dim sRetiro$, sPagMan$, sObserv$, iRutCli$, iFechaValuta$
Dim nSw%, nCont%
Dim nCodcli&, Codigo_Libro$, Codigo_AreaResp$

'--**
Dim Sucursal$, Ejecutivo$, Rentabilidad$
Dim sTipo_Interfaz$, nmtoini_um$, Garantia$, correla$, Ind1446$
'--**

    GrabarIB = 0
    
    iRutCar$ = txtRutCar.text


    iForPagI$ = IIf(cmbFPagoIni.ListIndex > -1, cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex), 0)
    iForpaV$ = IIf(cmbFPagoVct.ListIndex > -1, cmbFPagoVct.ItemData(cmbFPagoVct.ListIndex), 0)
    iFechaValuta$ = txtFechaPago.text
    
    Codigo_Libro$ = Trim(Right(CmbLibro.text, 10))
    Codigo_AreaResp$ = Trim(Right(cmbArea.text, 10))
    iTipCar$ = Trim(Right(cmbTCart.text, 10)) 'CmbTCart.ItemData(CmbTCart.ListIndex)
    iTipCar$ = "1" 'No se Ingresa tipo de cartera
    
    If ChkVamos.Value = True Then
        sRetiro$ = "V"
    Else
        sRetiro$ = "I"
    End If
    
    sPagMan$ = "H"
    
    sObserv$ = TxtObserv.text
    iRutCli$ = txtRutCli.text
    nCodcli& = TxtCodCli.text
    
'--**
    
    sTipo_Interfaz = 0
    'If opt_Cap_134.Value = True Then
    '    sTipo_Interfaz = "134"
    'ElseIf opt_Cap_125.Value = True Then
    '    sTipo_Interfaz = "125"
   ' ElseIf opt_Col_136.Value = True = True Then
    '    sTipo_Interfaz = "136"
    'End If
    nmtoini_um = 0
    Garantia = 0
    correla = 0
    Ind1446 = ""
    
    
    Sucursal$ = cmbSucursal.ItemData(cmbSucursal.ListIndex)   ' Mid(cmbSucursal.Text, 1, 5)
    Ejecutivo$ = cmbEjecutivo.ItemData(cmbEjecutivo.ListIndex)
    Select Case cmbRentabilidad.ItemData(cmbRentabilidad.ListIndex)
    Case 1
        Rentabilidad$ = " "
    Case 2
        Rentabilidad$ = "H"
    Case 3
        Rentabilidad$ = "I"
    End Select
    '--**

    'GrabarIB = IB_GrabarTx(iRutCar$, iTipCar$, iForPagI$, iForpaV$, sRetiro$, sPagMan$, sObserv$, iRutCli$, nCodcli&, BacTrader.ActiveForm, iFechaValuta$, Codigo_Libro$, Codigo_AreaResp$)
    
     GrabarIB = IB_GrabarTx(iRutCar$, iTipCar$, iForPagI$, iForpaV$, sRetiro$, sPagMan$, sObserv$, iRutCli$, nCodcli&, BacTrader.ActiveForm, iFechaValuta$, Codigo_Libro$, Codigo_AreaResp$, _
                           Ejecutivo$, Sucursal$, Rentabilidad, nmtoini_um, sTipo_Interfaz, Garantia, correla, Ind1446)
    
    If GrabarIB > 0 Then
    
        BacInter.FltMtoini.text = 0
        BacInter.FltTasa.text = 0
        BacInter.Lbl_Mt_Final.Caption = 0
        BacInter.Pnl_FecProceso.Caption = gsBac_Fecp
        nSw = 0
        nCont = 1
        
        Do While nSw = 0
        
            BacInter.Intdias.text = nCont
            BacInter.Dtefecven.text = Format$(DateAdd("d", BacInter.Intdias.text, BacInter.Pnl_FecProceso.Caption), "dd/mm/yyyy")
    
            If EsFeriado(CDate(BacInter.Dtefecven.text), "00001") Then
                nCont = nCont + 1
            Else
                nSw = 1
            End If
           
        Loop
    
    End If
    
End Function

Private Function Grabar_RI() As Double
    '===========================================================================================
    '   Function    :   GrabarRI
    '   Objetivo    :   Realiza la grabación de las operaciones de captacion
    '   Fecha       :   05 de abril de 2000
    '   Autor       :   Victor Barra Fuentes
    '===========================================================================================
    Dim iRutCar$, iTipCar$, iForPagI$, sTipCus$, iForpaV$, sTipDep$
    Dim sRetiro$, sPagMan$, sObserv$, iRutCli$
    Dim nSw%, nCont%
    Dim nCodcli&
    '+++jcamposd 20160616 DAP
    Dim iRutContra$
    Dim iCodCliContra$
    '---jcamposd 20160616 DAP
    
    '+++jcamposd 20160616 DAP
    iRutContra = TxtRutContraparte.text
    iCodCliContra = TxtContraCod.text
    '----jcamposd 20160616 DAP

    Grabar_RI = 0
    
    iRutCar$ = txtRutCar.text
    iTipCar$ = 1
    iForPagI$ = cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex)
    sTipCus$ = Mid$(BacTrader.ActiveForm.Cmb_Custodia.text, 1, 1)
    sTipDep$ = Mid$(BacTrader.ActiveForm.Cmb_Tipo_Deposito.text, 1, 1)

    iForpaV$ = 0
    
    
    If ChkVamos.Value = True Then
        sRetiro$ = "V"
    Else
        sRetiro$ = "I"
    End If
    
    sPagMan$ = ""
    
    sObserv$ = TxtObserv.text
    iRutCli$ = txtRutCli.text
    nCodcli& = TxtCodCli.text
     
    Grabar_RI = IC_GrabarTx_RC(iRutCar$, iTipCar$, iForPagI$, iForpaV$, sRetiro$, sPagMan$, sObserv$, iRutCli$, nCodcli&, BacTrader.ActiveForm, sTipCus$, sTipDep$, iRutContra, iCodCliContra)

End Function

Private Function GrabarIC() As Double
'===========================================================================================
'   Function    :   GrabarIC
'   Objetivo    :   Realiza la grabación de las operaciones de captacion
'   Fecha       :   05 de abril de 2000
'   Autor       :   Victor Barra Fuentes
'===========================================================================================
Dim iRutCar$, iTipCar$, iForPagI$, sTipCus$, iForpaV$, sTipDep$
Dim sRetiro$, sPagMan$, sObserv$, iRutCli$
Dim nSw%, nCont%
Dim nCodcli&

    GrabarIC = 0
    
    iRutCar$ = txtRutCar.text
    iTipCar$ = 1
    iForPagI$ = cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex)
    sTipCus$ = Mid$(BacTrader.ActiveForm.Cmb_Custodia.text, 1, 1)
    sTipDep$ = Mid$(BacTrader.ActiveForm.Cmb_Tipo_Deposito.text, 1, 1)
    
    iForpaV$ = 0
    
    
    If ChkVamos.Value = True Then
        sRetiro$ = "V"
    Else
        sRetiro$ = "I"
    End If
    
    sPagMan$ = ""
    
    sObserv$ = TxtObserv.text
    iRutCli$ = txtRutCli.text
    nCodcli& = TxtCodCli.text
    
    
    GrabarIC = IC_GrabarTx(iRutCar$, iTipCar$, iForPagI$, iForpaV$, sRetiro$, sPagMan$, sObserv$, iRutCli$, nCodcli&, BacTrader.ActiveForm, sTipCus$, sTipDep$)
    
End Function

Function AC_GrabarTx(RutCar$, TipCar$, Forpai$, Forpav$, Retiro$, Pagom$, Observ$, RutCli$, CodCli&, BacFrm As Form)
    
End Function

Function Llena_Corresponsales()
   Dim Datos()


   CmdCorresponsal.Clear
   CmbCodCorresponsal.Clear

   CmdCorresponsal.Enabled = True
   CmbCodCorresponsal.Enabled = True


   Envia = Array()
   AddParam Envia, gsBac_RutC
   AddParam Envia, BacIrfGrSinDVP.proMoneda

   If Bac_Sql_Execute("SP_CORRESPONSAL_DPX", Envia) Then
      Do While Bac_SQL_Fetch(Datos())

         CmbCodCorresponsal.AddItem Datos(1)
         CmdCorresponsal.AddItem Datos(2)

      Loop

   End If

End Function

Private Sub SeteaDatosCli()
                   
    Me.txtRutCar = BacTrader.ActiveForm.recupera.RutCar
    Me.txtDigCar = BacTrader.ActiveForm.recupera.DigVeri
    Me.txtNomCar = BacTrader.ActiveForm.recupera.NomCar
    Me.cmbTCart.ListIndex = BacBuscaComboGlosa(Me.cmbTCart, BacTrader.ActiveForm.recupera.TipCar)
    Me.cmbFPagoIni.ListIndex = BacBuscaComboGlosa(Me.cmbFPagoIni, BacTrader.ActiveForm.recupera.Forpai)
    Me.cmbFPagoVct.ListIndex = BacBuscaComboGlosa(Me.cmbFPagoVct, BacTrader.ActiveForm.recupera.Forpav)
    Me.ChkVamos.Value = IIf(BacTrader.ActiveForm.recupera.Tipret = "V", True, False)
    Me.txtRutCli = BacTrader.ActiveForm.recupera.RutCli
    Me.txtDigCli = BacTrader.ActiveForm.recupera.DigCli
    Me.TxtNomCli = BacTrader.ActiveForm.recupera.NomCli
                     
End Sub



Private Function ChkDatos() As Boolean

    Dim dFecvtop
Dim Datos()
    
    ChkDatos = False
    
    If cmbOperador.Enabled = True And cmbOperador.ListIndex = -1 Then
        Screen.MousePointer = vbDefault
        MsgBox "Debe Seleccionar al Operador de la Transacción", vbExclamation
        cmbOperador.SetFocus
        Exit Function
    End If
    
    If ObjCliente.clvigente = "N" Then
        Screen.MousePointer = vbDefault
        txtRutCli.text = ""
        TxtCodCli.text = ""
        TxtNomCli.text = ""
        LblEstadoCliente.Caption = ""
        ObjCliente.clvigente = ""
        
        MsgBox "Cliente no se encuentra vigente", vbExclamation
        Exit Function
    End If
    
    If cmbArea.Enabled = True And cmbArea.ListIndex = -1 Then
        Screen.MousePointer = vbDefault
        MsgBox "Debe Seleccionar un Area Responsable", vbExclamation
        cmbArea.SetFocus
        Exit Function
    End If
    
    If CmbLibro.Enabled = True And CmbLibro.ListIndex = -1 And CmbLibro.Visible = True Then
        Screen.MousePointer = vbDefault
        MsgBox "Debe Seleccionar un Libro", vbExclamation
        CmbLibro.SetFocus
        Exit Function
    End If
    
    If cmbTCart.Enabled = True And cmbTCart.ListIndex = -1 And cmbTCart.Visible = True Then
        Screen.MousePointer = vbDefault
        MsgBox "Debe Seleccionar un Tipo de Cartera Financiera", vbExclamation
        cmbTCart.SetFocus
        Exit Function
    End If
    
    If Val(txtRutCar.text) = 0 Then
        MsgBox "RUT DE CARTERA OBLIGATORIO", vbExclamation, gsBac_Version
        txtRutCar.SetFocus
        Exit Function
    '''REQ.6004
    ElseIf gsBac_RutBCCH = txtRutCli.text And cmbFPagoIni.ListIndex = -1 Then
        MsgBox "No Esta Habilitada la Forma de Pago para el Banco Central", vbExclamation, gsBac_Version
'+++fmo 20190213 problemas validacion
'        txtRutCli.SetFocus
        cmbFPagoIni.SetFocus
'---fmo 20190213 problemas validacion
        Exit Function
    ElseIf cmbFPagoIni.ListIndex = -1 And cmbFPagoIni.Enabled = True Then
        MsgBox "FORMA DE PAGO INICIAL OBLIGATORIA", vbExclamation, gsBac_Version
        cmbFPagoIni.SetFocus
        Exit Function
    ElseIf cmbFPagoVct.ListIndex = -1 And cmbFPagoVct.Enabled = True Then
        MsgBox "FORMA DE PAGO DE VENCIMIENTO OBLIGATORIA", vbExclamation, gsBac_Version
        cmbFPagoVct.SetFocus
        Exit Function
    ElseIf Val(txtRutCli.text) = 0 Then
        MsgBox "RUT DE CLIENTE OBLIGATORIO", vbExclamation, gsBac_Version
        txtRutCli.SetFocus
        Exit Function
    ElseIf Mid$(BacFrmIRF.Tag, 1, 2) = "VI" Or Mid$(BacFrmIRF.Tag, 1, 2) = "RV" Then   ' Or Mid$(BacFrmIRF.Tag, 1, 2) = "RC"
        If Mid$(BacFrmIRF.Tag, 1, 2) = "RC" Or Mid$(BacFrmIRF.Tag, 1, 2) = "RV" Then
            Envia = Array(txtRutCli.text, _
                    Format(FecInip, "yyyymmdd"), _
                    Format(gsBac_Fecp, "yyyymmdd"))
        Else
            Envia = Array(txtRutCli.text, _
                    Format(gsBac_Fecp, "yyyymmdd"), _
                    Format(BacFrmIRF.TxtFecVct.text, "yyyymmdd"))
        End If
      
        If Bac_Sql_Execute("SP_TOTDIASHABILES", Envia) Then
            If Bac_SQL_Fetch(Datos()) Then
                If UBound(Datos()) = 2 Then
                    MsgBox CStr(Datos(2)) & Chr$(10) & Chr$(13) & "los dias habiles corresponden a " + Str(Datos(1)), vbExclamation, gsBac_Version
                    Exit Function
                End If
            End If
        End If
        Dim l As Integer
        If (Mid$(BacFrmIRF.Tag, 1, 2) = "VI" Or Mid$(BacFrmIRF.Tag, 1, 2) = "RP") Then
             'If txtRutCli.Text <> 97029000 Then
             If txtRutCli.text <> gsBac_RutBCCH Then ''REQ.6004
               ''PRD-6006 CASS 09-12-2010
               'For l = 1 To BacFrmIRF.Table1.Rows - 1
                'BacFrmIRF.Table1.Row = l
                 'If BacFrmIRF.Table1.TextMatrix(l, 0) = "P" Or BacFrmIRF.Table1.TextMatrix(l, 0) = "V" Then
               For l = 1 To BacFrmIRF.GRILLA.Rows - 1
                    BacFrmIRF.GRILLA.Row = l
                    If BacFrmIRF.GRILLA.TextMatrix(l, Col_Marca) = "P" Or BacFrmIRF.GRILLA.TextMatrix(l, Col_Marca) = "V" Then
                      ''PRD-6006 CASS 09-12-2010
                      ' If BacFrmIRF.Table1.TextMatrix(l, 4) = 0 Then
                       If BacFrmIRF.GRILLA.TextMatrix(l, Col_Tir) = 0 Then
                            ChkDatos = False
                            MsgBox "Registros Con Tir de Compra en Cero", vbCritical
                            Exit Function
                        End If
                    End If
               Next l
             End If
        End If
        
    End If

    If BacIrfGrSinDVP.ProDpx = "S" And CmdCorresponsal.ListIndex = -1 Then
         ChkDatos = False
         MsgBox "No ha Ingresado Corresponsal", vbCritical
         Exit Function
    End If
    
    ChkDatos = True
   
End Function
Private Function GrabarCI() As Double


   Dim iRutCar&, iTipCar%, iForPagI&, iForPagV&, sTipCus$
   Dim sRetiro$, sPagMan$, sObserv$, iRutCli&, sDCV$
   Dim TCart$, Mercado$, Sucursal$, AreaResponsable$
   Dim Fecha_PagoMañana$, Laminas$, Tipo_Inversion$
   Dim CtaCteInicio$, SucInicio$, CtaCteFinal$, SucFinal$
   Dim Codigo_Libro$
   Dim Ejecutivo$, Rentabilidad$, iforpagSub&, iforpagSub2&
   
   GrabarCI = 0
      
   iRutCar& = Val(txtRutCar.text)
   iForPagI& = IIf(cmbFPagoIni.ListIndex > -1, cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex), 0)
   
   If cmbFPagoVct.ListIndex > -1 Then
      iForPagV& = cmbFPagoVct.ItemData(cmbFPagoVct.ListIndex)
   Else
      iForPagV& = 0
   End If
 
   If ChkCustod.Value = True Then
      sTipCus$ = "S"
   Else
      sTipCus$ = "N"
   End If
    
   If ChkVamos.Value = True Then
      sRetiro$ = "V"
   Else
      sRetiro$ = "I"
   End If
    
   sPagMan$ = Mid(cmbTipoPago.text, 1, 1)

   sObserv$ = TxtObserv.text
   iRutCli& = Val(txtRutCli.text)
   
   'Campos Nuevos

   Mercado$ = Mid(CmbMercado.text, 1, 1)
   Sucursal$ = Mid(cmbSucursal.text, 1, 5)
   Fecha_PagoMañana$ = txtFechaPago.text
   Laminas$ = IIf(optSi.Value, "S", "N")
   Tipo_Inversion$ = Mid(Me.cmbTipoInversion, 1, 1)
   CtaCteInicio$ = txtCtaCteInicio
   SucInicio$ = IIf(cmbSucInicio.ListIndex > -1, cmbSucInicio.ListIndex, "")
   CtaCteFinal$ = txtCtaCteFinal
   SucFinal$ = IIf(cmbSucFinal.ListIndex > -1, cmbSucFinal.ListIndex, "")
   
   Codigo_Libro$ = Trim(Right(CmbLibro.text, 10))
   TCart$ = Trim(Right(cmbTCart.text, 10)) 'Mid(CmbTCart.Text, 1, 1)
   iTipCar% = Trim(Right(cmbTCart.text, 10)) 'IIf(CmbTCart.ListIndex > -1, CmbTCart.ItemData(CmbTCart.ListIndex), 0)
   AreaResponsable$ = Trim(Right(cmbArea.text, 10))
   
   GrabarCI = CI_GrabarTx(iRutCar&, _
                        iTipCar%, _
                        iForPagI&, _
                        iForPagV&, _
                        sTipCus$, _
                        sRetiro$, _
                        sPagMan$, _
                        sObserv$, _
                        iRutCli&, _
                        TxtCodCli, _
                        BacFrmIRF, _
                        dTotLim_PFE, _
                        dTotLim_CCE, _
                        TCart$, _
                        Mercado$, _
                        Sucursal$, _
                        AreaResponsable$, _
                        Fecha_PagoMañana$, _
                        Laminas$, _
                        Tipo_Inversion$, _
                        CtaCteInicio$, _
                        SucInicio$, _
                        CtaCteFinal$, _
                        SucFinal$, _
                        Codigo_Libro$, Ejecutivo$, Rentabilidad$, iforpagSub&, iforpagSub2&)
                        
End Function

Private Function GrabarVI(Optional ByVal Repos As String)
   
   Dim iRutCar&, iTipCar%, iForPagI&, iForPagV&, sTipCus$
   Dim sRetiro$, sPagMan$, sObserv$, iRutCli&, sDCV$
   Dim TCart$, Mercado$, Sucursal$, AreaResponsable$
   Dim Fecha_PagoMañana$, Laminas$, Tipo_Inversion$
   Dim CtaCteInicio$, SucInicio$, CtaCteFinal$, SucFinal$
   
    '++GRC Req007
   If IsMissing(Repos) Then
      Repos = ""
   End If
    '--GRC Req007
   GrabarVI = 0
   
   iRutCar& = Val(txtRutCar.text)
   iTipCar% = IIf(cmbTCart.ListIndex > -1, cmbTCart.ItemData(cmbTCart.ListIndex), 0)
   
   
   iForPagI& = IIf(cmbFPagoIni.ListIndex > -1, cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex), 0)
    
   If cmbFPagoVct.ListIndex > -1 Then
      iForPagV& = cmbFPagoVct.ItemData(cmbFPagoVct.ListIndex)
   Else
      iForPagV& = 0
   End If
 
   If ChkCustod.Value = True Then
      sTipCus$ = "S"
   Else
      sTipCus$ = "N"
   End If
    
   If ChkVamos.Value = True Then
      sRetiro$ = "V"
   Else
      sRetiro$ = "I"
   End If
    
   sPagMan$ = Mid(cmbTipoPago.text, 1, 1)
   
   sObserv$ = TxtObserv.text
   iRutCli& = Val(txtRutCli.text)
   
   'Campos Nuevos

   Mercado$ = Mid(CmbMercado.text, 1, 1)
   Sucursal$ = Mid(cmbSucursal.text, 1, 5)
   Fecha_PagoMañana$ = txtFechaPago.text
   Laminas$ = IIf(optSi.Value, "S", "N")
   Tipo_Inversion$ = Mid(Me.cmbTipoInversion, 1, 1)
   CtaCteInicio$ = txtCtaCteInicio
   SucInicio$ = IIf(cmbSucInicio.ListIndex > -1, cmbSucInicio.ListIndex, "")
   CtaCteFinal$ = txtCtaCteFinal
   SucFinal$ = IIf(cmbSucFinal.ListIndex > -1, cmbSucFinal.ListIndex, "")
   
   AreaResponsable$ = Trim(Right(cmbArea.text, 10))
   TCart$ = Trim(Right(cmbTCart.text, 10)) 'Mid(CmbTCart.Text, 1, 1)
   
   
   '------20190104.RCH.LCGP
   
   If Me.oCliente = gsBac_RutBCCH Then
        Repos = "LCGP"
   End If
   
   '------20190104.RCH.LCGP
   'VI_GrabarTx
   GrabarVI = VI_GrabarTx_NuevoForm(iRutCar&, _
                           iTipCar%, _
                           iForPagI&, _
                           iForPagV&, _
                           sTipCus$, _
                           sRetiro$, _
                           sPagMan$, _
                           sObserv$, _
                           iRutCli&, _
                           TxtCodCli, _
                           BacFrmIRF, _
                           dTotLim_PFE, _
                           dTotLim_CCE, _
                           TCart$, _
                           Mercado$, _
                           Sucursal$, _
                           AreaResponsable$, _
                           Fecha_PagoMañana$, _
                           Laminas$, _
                           Tipo_Inversion$, _
                           CtaCteInicio$, _
                           SucInicio$, _
                           CtaCteFinal$, _
                           SucFinal$, _
                           Repos)
End Function


Private Function GrabarCP() As Double

   Dim iRutCar&, iTipCar%, iForPagI&, sTipCus$
   Dim sRetiro$, sPagMan$, sObserv$, iRutCli&, sDCV$
   Dim TCart$, Mercado$, Sucursal$, AreaResponsable$
   Dim Fecha_PagoMañana$, Laminas$, Tipo_Inversion$
   Dim CodCorr$, Libro$
       'LD1-COR-035 FUSION: AGREGAR CARTERA VOLCKER RULE
   Dim Cartera_VolckerRule$
   Dim Ejecutivo$, Rentabilidad$ '''', cTipCus$, Fecha_PagoMañana$, iForPagI&
   Dim Scomi As String
   Dim dFechaCustHasta As String

    
   GrabarCP = 0
   
   iRutCar& = Val(txtRutCar.text)
   
   iForPagI& = cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex)
   CodCorr$ = CmbCodCorresponsal.List(CmdCorresponsal.ListIndex)
    
   If ChkCustod.Value = True Then
      sTipCus$ = "S"
   Else
      sTipCus$ = "N"
   End If
    
   If ChkVamos.Value = True Then
      sRetiro$ = "V"
   Else
      sRetiro$ = "I"
   End If
       
   sPagMan$ = sPagMan$ = Mid(cmbTipoPago.text, 1, 1)
   
   sObserv$ = TxtObserv.text
   iRutCli& = Val(txtRutCli.text)
   
   'Campos Nuevos
   Mercado$ = Mid(CmbMercado.text, 1, 1)
   Sucursal$ = Mid(cmbSucursal.text, 1, 5)
   
   Fecha_PagoMañana$ = txtFechaPago.text
   Laminas$ = IIf(optSi.Value, "S", "N")
   Tipo_Inversion$ = Mid(Me.cmbTipoInversion, 1, 1)
   
   AreaResponsable$ = Trim(Right(cmbArea.text, 10))
   TCart$ = Trim(Right(cmbTCart.text, 10))
   iTipCar% = Trim(Right(cmbTCart.text, 10)) 'CmbTCart.ItemData(CmbTCart.ListIndex)
   Libro$ = Trim(Right(CmbLibro.text, 10))

    'LD1-COR-035 FUSION: AGREGAR CARTERA VOLCKER RULE
    If (CmbVolckerRule.Enabled = True) & (CmbVolckerRule.Visible = True) Then
        Cartera_VolckerRule$ = CmbVolckerRule.ItemData(CmbVolckerRule.ListIndex)
    Else
        Cartera_VolckerRule$ = 0
        
    End If
    
'-------CÓDIGO FUSIÓN ITAÚ

   Rentabilidad$ = IIf(cmbRentabilidad.ItemData(cmbRentabilidad.ListIndex) = 1, " ", IIf(cmbRentabilidad.ItemData(cmbRentabilidad.ListIndex) = 2, "H", "I"))
   dFechaCustHasta = "19000101"
   Scomi = "N"
'-------CÓDIGO FUSIÓN ITAÚ
   
   GrabarCP = CP_GrabarTx(iRutCar&, _
                           iTipCar%, _
                           iForPagI&, _
                           sTipCus$, _
                           sRetiro$, _
                           sPagMan$, _
                           sObserv$, _
                           iRutCli&, _
                           TxtCodCli, _
                           BacFrmIRF, _
                           TCart$, _
                           Mercado$, _
                           Sucursal$, _
                           AreaResponsable$, _
                           Fecha_PagoMañana$, _
                           Laminas$, _
                           Tipo_Inversion$, _
                           CodCorr$, _
                           Libro$, _
                           Cartera_VolckerRule$, _
                           Rentabilidad$, _
                           Ejecutivo$, _
                           dFechaCustHasta, _
                           Scomi)
End Function


Private Function GrabarVP()

   Dim iRutCar&, iTipCar%, iForPagI&, sTipCus$
   Dim sRetiro$, sPagMan$, sObserv$, iRutCli&, sDCV$
   Dim TCart$, Mercado$, Sucursal$, AreaResponsable$
   Dim Fecha_PagoMañana$, Laminas$, Tipo_Inversion$
   Dim CodLibro$

   GrabarVP = 0
   
   iRutCar& = Val(txtRutCar.text)
   iForPagI& = cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex)
   
   If ChkCustod.Value = True Then
      sTipCus$ = "S"
   Else
      sTipCus$ = "N" 'N
   End If
    
   If ChkVamos.Value = True Then
      sRetiro$ = "V" 'V
   Else
      sRetiro$ = "I"
   End If
    
   sPagMan$ = Mid(cmbTipoPago.text, 1, 1) 'H
    
   sObserv$ = TxtObserv.text
   iRutCli& = Val(txtRutCli.text) '96665450 corpbanca sa
      
   'Campos Nuevos
   TCart$ = Trim(Right(cmbTCart.text, 10)) 'Mid(CmbTCart.Text, 1, 1) '1
   iTipCar% = Trim(Right(cmbTCart.text, 10)) 'CmbTCart.ItemData(CmbTCart.ListIndex) '1
   Mercado$ = Mid(CmbMercado.text, 1, 1) 'S
   Sucursal$ = Mid(cmbSucursal.text, 1, 5) 'VICUÑ
   AreaResponsable$ = Trim(Right(cmbArea.text, 10)) '6
   Fecha_PagoMañana$ = txtFechaPago.text '14-03-2011
   Laminas$ = IIf(optSi.Value, "S", "N") 'N
   Tipo_Inversion$ = Mid(Me.cmbTipoInversion, 1, 1) '""

   'CodLibro$ = Trim(Right(CmbLibro.Text, 10))
    
   GrabarVP = VPVI_GrabarTx(iRutCar&, _
                           TCart$, _
                           iForPagI&, _
                           sTipCus$, _
                           sRetiro$, _
                           sPagMan$, _
                           sObserv$, _
                           iRutCli&, _
                           TxtCodCli, _
                           BacFrmIRF, _
                           TCart$, _
                           Mercado$, _
                           Sucursal$, _
                           AreaResponsable$, _
                           Fecha_PagoMañana$, _
                           Laminas$, _
                           Tipo_Inversion$)
    

End Function

Private Function GrabarST()

   Dim iRutCar&, iTipCar%, iForPagI&, sTipCus$
   Dim sRetiro$, sPagMan$, sObserv$, iRutCli&, sDCV$
   Dim TCart$, Mercado$, Sucursal$, AreaResponsable$
   Dim Fecha_PagoMañana$, Laminas$, Tipo_Inversion$

   GrabarST = 0
   
   iRutCar& = Val(txtRutCar.text)
   iTipCar% = 0 ''''CmbTCart.ItemData(CmbTCart.ListIndex)
   
  
   iForPagI& = cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex)
   
   If ChkCustod.Value = True Then
      sTipCus$ = "S"
   Else
      sTipCus$ = "N"
   End If
    
   If ChkVamos.Value = True Then
      sRetiro$ = "V"
   Else
      sRetiro$ = "I"
   End If
    
   sPagMan$ = Mid(cmbTipoPago.text, 1, 1)
    
   sObserv$ = TxtObserv.text
   iRutCli& = Val(txtRutCli.text)

      
   'Campos Nuevos
   Mercado$ = Mid(CmbMercado.text, 1, 1)
   Sucursal$ = Mid(cmbSucursal.text, 1, 5)
   Fecha_PagoMañana$ = txtFechaPago.text
   Laminas$ = IIf(optSi.Value, "S", "N")
   Tipo_Inversion$ = Mid(Me.cmbTipoInversion, 1, 1)
   
   AreaResponsable$ = Trim(Right(cmbArea.text, 10))
   TCart$ = Trim(Right(cmbTCart.text, 10)) 'Mid(CmbTCart.Text, 1, 1)
      
   GrabarST = VPVI_GrabarTx(iRutCar&, _
                           TCart$, _
                           iForPagI&, _
                           sTipCus$, _
                           sRetiro$, _
                           sPagMan$, _
                           sObserv$, _
                           iRutCli&, _
                           TxtCodCli, _
                           BacFrmIRF, _
                           TCart$, _
                           Mercado$, _
                           Sucursal$, _
                           AreaResponsable$, _
                           Fecha_PagoMañana$, _
                           Laminas$, _
                           Tipo_Inversion$, FechaSorteoLetras, FechaReal)
End Function
Sub subCargaClientesSimilares()

    BacAyuda.Tag = "MDCLN"
    BacAyuda.parFiltro = RTrim(TxtNomCli.text)
    BacAyuda.Show 1
    
    BacControlWindows 12
    
    If giAceptar% = True Then
        txtRutCli.text = Val(gsrut$)
        TxtCodCli.text = gsvalor$
        Call TxtCodCli_LostFocus
    End If
End Sub

Function funcGeneralValidacion_LIMITES(cTipOper As String)
'========================================================================================
'   Función     :    funcGeneraValidacion_LIMITES
'   Objetivo   :    Realiza la validación para todas las operaciones
'------------------------------------------------------------------------------------------
'            Operacion  Limite                    Acción
'------------------------------------------------------------------------------------------
'               CP      ART 84                      +
'                       Emisor/Instrumento/Plazo    +
'                       Settlement                  +
'
'               CI      Art 84                      +
'                       PFE/CCE                     +
'
'               VP      Settlement                  +
'                       Emisor/Instrumento/Plazo    -
'                       ART 84                      -
'
'               VI      PFE/CCE                     +
'
'               RCA     PFE/CCE                     -
'
'               RVA     PFE/CCE                     -
'                       Art 84                      -
'
'        IB     COL     Art 84                      +
'        IB             Emisor/Inst/Plazo           +
'
' ========================================================================================
Dim bPregunta       As Boolean
Dim iTotError       As Integer
Dim Msg             As String
Dim bExisteDPX      As Boolean
Dim Valor_moneda    As Double
Dim dMontoValor     As Double

    ReDim Preserve aVarLimites(0)
    bPregunta = False
    iContArrayLim = 0
    funcGeneralValidacion_LIMITES = False
    
    Valor_moneda = FUNC_BUSCA_VALOR_MONEDA(988, Format(gsBac_Fecp, "DD/MM/YYYY"))

    Select Case cTipOper
    
        Case "CP"
          
            If Not funcValidacionART84CP(proHwnd, "Q", bExisteDPX) Then
                Screen.MousePointer = vbDefault
                Exit Function
            End If
            
            If Not funcValidaEmisorInstPlazoCP(proHwnd, "Q", bExisteDPX) Then
                bPregunta = True
            End If
            
    
        Case "CI"
              ' Se realiza consulta de Limites ARTICULO 84
              ' =================================================
                If Not funcValidacionLimites_CI(txtRutCli.text, proMtoOper, "Q") Then
                    Screen.MousePointer = vbDefault
                    Exit Function
                End If
              ' =================================================
              
              ' Se realiza consulta de Limites PFE y CCE
              ' =================================================
                If Not funcValidacionLimites_PFE_CCE_CI(txtRutCli.text, TxtCodCli.text, proMtoOper, "Q", dTotLim_PFE, dTotLim_CCE, iCodExcesoPFEcce, dMtoExcesoPFEcce, iCodExcesopfeCCE_1, dMtoExcesopfeCCE_1) Then
                    bPregunta = True
                End If
              ' =================================================
              
        Case "VI"
                If Not funcValidacionLimites_PFE_CCE_VI(txtRutCli.text, TxtCodCli.text, proMtoOper, "Q", dTotLim_PFE, dTotLim_CCE, iCodExcesoPFEcce, dMtoExcesoPFEcce, iCodExcesopfeCCE_1, dMtoExcesopfeCCE_1) Then
                    bPregunta = True
                End If

        Case "IB"
               If BacFrmIRF.ChkCol.Value = True And Me.proMoneda <> gsBac_Dolar Then
                  ' Se realiza consulta de Limites ARTICULO 84
                  ' =================================================
                        If Not funcValidacionLimites_IB(txtRutCli.text, proMtoOper, "Q", BacFrmIRF.Dtefecven.text, IIf(BacFrmIRF.ChkCol.Value = True, "ICOL", "ICAP"), iCodexcesoIB, dMtoExcesoIB) Then
                            If iCodexcesoIB = -1 Then
                                Screen.MousePointer = vbDefault
                                Exit Function
                            End If
                            bPregunta = True
                        End If
                End If
              ' =================================================
        
'        Case "RCA"
       
        
'        Case "RVA"
        
    End Select
    
  ' VB+ La validación del limite SETTLEMENT es para todas las operaciones que se efectuen
  ' por cuya razon se coloca la validación fuera de las condiciones
  ' VB+- 6/07/2000 Se valida que para las operaciones de Interbancarios y para las Captaciones no se debe Validar SETTLEMENT
  ' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    dMontoValor = proMtoOper
    If bExisteDPX Then
        dMontoValor = Format$(proMtoOper * Valor_moneda, "########0")
    End If
    
  ' VB+- 28/07/2000 Solamente las operaciones de compras y ventas definitivas son afectas de limites SETTLEMENT
    If cTipOper <> "IB" And cTipOper <> "IC" And cTipOper <> "CI" And cTipOper <> "VI" And cTipOper <> "RC" And cTipOper <> "RV" Then
        If Not funcValidaLimites_SETTLEMENT(txtRutCli.text, TxtCodCli.text, cTipOper, 0, 0, cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex), dMontoValor, "Q", iCodExcesoSETTLE, dMtoExcesoSETTLE, iPlazoSETLLEMENT) Then
            bPregunta = True
        End If
    End If
    
    If bPregunta Then
        Msg = ""
        For iTotError = 1 To iContArrayLim
            Msg = Msg & aVarLimites(iTotError) & vbCrLf & vbCrLf
        Next iTotError
        

        If MsgBox(Msg & vbCrLf & vbCrLf & "                             ¿ Desea continuar con grabación ?", vbQuestion + vbYesNo + vbDefaultButton2, "Validación de Limites ") = vbNo Then
            Screen.MousePointer = vbDefault
            Exit Function
        End If
    End If

    Screen.MousePointer = vbDefault
    funcGeneralValidacion_LIMITES = True

End Function


Private Sub cmbFPagoIni_Click()
   On Error Resume Next

   If cmbFPagoVct.Enabled = True Then
      cmbFPagoVct.ListIndex = cmbFPagoIni.ListIndex
   End If
   If cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex) = 6 Or cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex) = 7 Or (cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex) > 36 And cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex) < 98) Then
      txtCtaCteFinal.text = cCtaCte
      txtCtaCteInicio.text = cCtaCte
   Else
      txtCtaCteFinal.text = ""
      txtCtaCteInicio.text = ""
   End If

Exit Sub 'Agregado
   
   Select Case cmbFPagoIni.ListIndex
      Case Is = 9: cmbTipoPago.ListIndex = 1
     'Case Is = 10: cmbTipoPago.ListIndex = 2
      Case Else: cmbTipoPago.ListIndex = 0
   End Select

End Sub


Private Sub cmbTipoPago_Click()
   Dim nCont   As Integer
   Dim nSw     As Integer
If Me.Visible = True Then
   Select Case cmbTipoPago.ListIndex
      Case Is = 0
         txtFechaPago.text = Format(gsBac_Fecp, "dd/mm/yyyy")
      Case Is = 1
         txtFechaPago.text = Format(gsBac_Fecx, "dd/mm/yyyy")
      Case Is = 2
         nSw = 0
         nCont = 1
         Do While nSw = 0
            txtFechaPago.text = Format$(DateAdd("d", nCont, gsBac_Fecx), "dd/mm/yyyy")
            If EsFeriado(CDate(txtFechaPago.text), "00001") Then
               nCont = nCont + 1
            Else
               nSw = 1
            End If
         Loop
      Case Else
         MsgBox "Problemas con el tipo de pago"
   End Select
End If
End Sub


Private Sub CmdCorresponsal_Click()
   CmbCodCorresponsal.ListIndex = CmdCorresponsal.ListIndex
End Sub


Private Sub Form_Activate()
   Let Screen.MousePointer = vbDefault
   Let Toolbar1.Buttons(2).Enabled = False

   Call BacControlWindows(12)

   If BacTrader.ActiveForm.Tag = "VP" Then Me.ChkVienen.Value = True 'Ventas Definitivas
   If BacTrader.ActiveForm.Tag = "CP" Then Me.ChkVamos.Value = True  'Compras Definitivas
   
   'If (BacTrader.ActiveForm.Tag = "VI" Or BacTrader.ActiveForm.Tag = "RP") Then cmbMercado.Enabled = False
   
   If (BacTrader.ActiveForm.Tag = "VI") Then CmbMercado.Enabled = False
   
   'If (BacTrader.ActiveForm.Tag = "VI" Or BacTrader.ActiveForm.Tag = "RP") Then Me.ChkVienen.Value = True  'Ventas con Pacto
   
   If (BacTrader.ActiveForm.Tag = "VI") Then Me.ChkVienen.Value = True  'Ventas con Pacto
   If BacTrader.ActiveForm.Tag = "CI" Then Me.ChkVamos.Value = True   'Compras con Pacto
   
   'If BacTrader.ActiveForm.Tag = "FLI" Then Me.ChkVienen.Value = True  'Ventas con Pacto
   
   If (BacTrader.ActiveForm.Tag = "FLI" Or BacTrader.ActiveForm.Tag = "RP") Then Me.ChkVienen.Value = True  'Ventas con Pacto
   If BacTrader.ActiveForm.Tag = "CI" Then optNo.Value = True
   If BacTrader.ActiveForm.Tag = "CP" Then optNo.Value = True

   Let cmbEntidad.Enabled = False


    '+++CONTROL IDD, jcamposd solo se activa para las CP y CI
    If BacTrader.ActiveForm.Tag = "CI" Or BacTrader.ActiveForm.Tag = "CP" Then
        ChkControlLinea.Visible = True
    End If
    '---CONTROL IDD, jcamposd solo se activa para las CP y CI

   If BacTrader.ActiveForm.Tag = "IB" Then   'Interbancarios
      If BacInter.ChkCap.Value = True Then
         Me.ChkVamos.Value = True   'captaciones
      End If
      If BacInter.ChkCol.Value = True Then
         Me.ChkVienen.Value = True  'colocaciones
        '+++CONTROL IDD, jcamposd solo se activa para las Colocaciones
        ChkControlLinea.Visible = True
        '---CONTROL IDD, jcamposd solo se activa para las Colocaciones
      End If
   End If

   If BacTrader.ActiveForm.Tag = "AN" Then
      Let Marco(0).Enabled = False
      Let txtRutCar.Enabled = False
      Let Toolbar1.Buttons(2).Enabled = True
   ElseIf Mid$(BacTrader.ActiveForm.Tag, 1, 2) = "RC" Or Mid$(BacTrader.ActiveForm.Tag, 1, 2) = "RV" Then
      Let Marco(3).Enabled = True
      Let Toolbar1.Buttons(2).Enabled = True
   Else
    If VolckerRule = False Then
        Let Toolbar1.Buttons(2).Enabled = False
      Else
        Let Toolbar1.Buttons(2).Enabled = True
      End If
      
   End If

   Let CmbMercado.ListIndex = 2
   Let cmbEntidad.ListIndex = 0
   
   

   If Mid(BacTrader.ActiveForm.Tag, 1, 2) = "CP" Or Mid(BacTrader.ActiveForm.Tag, 1, 2) = "VP" Then
      cmbTipoPago.ListIndex = MiTipoPago
      cmbTipoPago.Enabled = False
   Else
        'If Mid(BacTrader.ActiveForm.Tag, 1, 3) <> "FLI" Then
        If Mid(BacTrader.ActiveForm.Tag, 1, 3) <> "FLI" Or Mid(BacTrader.ActiveForm.Tag, 1, 2) = "RP" Then
            cmbTipoPago.Enabled = True
        End If
   End If
   
 ' ------------------------------------------------------------------------------------
 ' +++ VB 09/07/2018 desarrollo t+2 se envia fecha de pago para carga de papelees
 ' ------------------------------------------------------------------------------------

   If cmbTipoPago.List(cmbTipoPago.ListIndex) = "HOY" Then
      txtFechaPago.text = Format(gsBac_Fecp, "dd/mm/yyyy")
   ElseIf cmbTipoPago.List(cmbTipoPago.ListIndex) = "MAÑANA" Then
   
      txtFechaPago.text = Format(gsBac_Fecx, "dd/mm/yyyy")  ' VB+- 23/06/2009
   ElseIf cmbTipoPago.List(cmbTipoPago.ListIndex) = "T+2" Then
   Dim nSw, nCont As Integer
         nSw = 0
         nCont = 1
         Do While nSw = 0
            txtFechaPago.text = Format$(DateAdd("d", nCont, gsBac_Fecx), "dd/mm/yyyy")
            If EsFeriado(CDate(txtFechaPago.text), "00001") Then
               nCont = nCont + 1
            Else
               nSw = 1
            End If
         Loop
    End If
 ' ------------------------------------------------------------------------------------
 ' --- VB 09/07/2018 desarrollo t+2 se envia fecha de pago para carga de papelees
 ' ------------------------------------------------------------------------------------
   

   '21-10-2010 CASS
   
   
   '20181227.RCH.lcgp
       If Me.oCliente <> gsBac_RutBCCH Then
          If Mid(BacTrader.ActiveForm.Tag, 1, 3) <> "FLI" _
                 And Mid(BacTrader.ActiveForm.Tag, 1, 2) <> "RP" _
                 And Mid(BacTrader.ActiveForm.Tag, 1, 2) <> "RC" _
                 And Mid(BacTrader.ActiveForm.Tag, 1, 2) <> "RV" Then
        
                 If CmbLibro.ListCount = 0 Then
                       Screen.MousePointer = vbDefault
                       MsgBox "No se ha definido un libro por defecto.", vbExclamation
                       Unload Me
                       Exit Sub
                 End If
           End If
       End If
    
    '+++jcamposd 20160616 DAP
    If BacTrader.ActiveForm.Tag = "RI" Then FrmContraparte.Visible = True
    '---jcamposd 20160616 DAP
    
   If BacTrader.ActiveForm.Tag = "ST" Then cmbFPagoVct.Enabled = False
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
        
    If KeyAscii = vbKeyReturn Then
        KeyAscii = 0
        SendKeys "{TAB}"
    End If
        
End Sub


Sub ActivarControles(aGrab As Variant)
   
   'CREADOR: CRISTIAN LABARCA - 09/feb/2001
   cmbFPagoIni.Enabled = IIf(aGrab(0) = 1, True, False)
   cmbFPagoVct.Enabled = IIf(aGrab(1) = 1, True, False)
   Marco(1).Enabled = IIf(aGrab(2) = 1, True, False)
   CmbMercado.Enabled = IIf(aGrab(3) = 1, True, False)
   cmbSucursal.Enabled = IIf(aGrab(4) = 1, True, False)
   cmbArea.Enabled = IIf(aGrab(6) = 1, True, False)
   optSi.Enabled = IIf(aGrab(8) = 1, True, False)
   optNo.Enabled = IIf(aGrab(8) = 1, True, False)
   ''**********************************************************************************
   cmbTipoPago.Enabled = IIf(aGrab(7) = 1, True, False)
   ''**********************************************************************************
   txtFechaPago.Enabled = False 'IIf(aGrab(8) = 1, True, False)
   txtCtaCteInicio.Enabled = IIf(aGrab(9) = 1, True, False)
   txtCtaCteFinal.Enabled = IIf(aGrab(10) = 1, True, False)
   cmbSucInicio.Enabled = IIf(aGrab(11) = 1, True, False)
   cmbSucFinal.Enabled = IIf(aGrab(12) = 1, True, False)
   cmbTCart.Enabled = IIf(aGrab(13) = 1, True, False)
   cmbTipoInversion.Enabled = IIf(aGrab(14) = 1, True, False)
      
   cmbSucursal.ListIndex = IIf(cmbSucursal.Enabled, 0, -1)
   cmbSucInicio.ListIndex = IIf(cmbSucInicio.Enabled, 0, -1)
   cmbSucFinal.ListIndex = IIf(cmbSucFinal.Enabled, 0, -1)
   optSi.Value = IIf(optSi.Enabled, True, False)

   CmbMercado.ListIndex = IIf(CmbMercado.Enabled, 0, -1)
   ''**********************************************************************************
   cmbTipoPago.ListIndex = IIf(cmbTipoPago.Enabled, 0, -1)
   ''**********************************************************************************
   cmbTipoInversion.ListIndex = IIf(cmbTipoInversion.Enabled, 0, -1)
    
    ' VB+-28/05/2009 Dejo Fecha establecida
    txtFechaPago.text = Format(gsBac_Fecp, "dd/mm/yyyy")
    
    ' VB+-28/05/2009 se dejan Comentariadas las 4 lineas del IF
'   If cmbTipoPago.List(cmbTipoPago.ListIndex) = "HOY" Then
'      txtFechaPago.Text = Format(gsBac_Fecp, "dd/mm/yyyy")
'   Else
'      txtFechaPago.Text = Format(gsBac_Fecp + 1, "dd/mm/yyyy")
'   End If

End Sub


Private Sub Form_Load()
    
Dim i%
Dim aGrabar()
ReDim aGrabar(15)
    
Dim li_pos_aresp    As Integer
Dim iContador       As Integer
Dim cLibro          As String
Dim Datos()
Dim Tipo_Oper       As String
Dim nContador  As Integer

    Grabacion_Operacion = False
    'INICIO - LD1-COR-035 MIGRACION VOLCKER RULE
    Let VolckerRule = True
    'FIN - LD1-COR-035 MIGRACION VOLCKER RULE
    
    BacCentrarPantalla Me
   
    Set objDCartera = New clsDCarteras
    Call objDCartera.LeerDCarteras("")
    Call objDCartera.Coleccion2Control(Me.cmbEntidad)
    
    '--**
    Call objEjecutivo.CargaSucursal("EJECUTIVO")
    Call objEjecutivo.Coleccion2Control(cmbEjecutivo, 1)
    cmbEjecutivo.ListIndex = 0
    '--**

    cmbTipoPago.Enabled = False
    cmbTipoPago.ListIndex = 0
    
    If Trim(BacFrmIRF.Tag) = "IB" Then
        If BacInter.ChkCap.Value = True Then
            Tipo_Oper = "ICAP"
        Else
            Tipo_Oper = "ICOL"
        End If
    Else
        
        If Trim(BacFrmIRF.Tag) = "IC" Then        '-> LD1_035_DAP
            Tipo_Oper = "IC" '-> "CAPTA"                                        '-> LD1_035_DAP
        '+++jcamposd cuando es recompra dap
        ElseIf Trim(BacFrmIRF.Tag) = "RI" Then
            Tipo_Oper = "RIC"
        Else                                                                    '-> LD1_035_DAP
            Tipo_Oper = Trim(BacFrmIRF.Tag)                                     '-> LD1_035_DAP
        End If                                                                  '-> LD1_035_DAP
    End If
    
    
    If ControlAtribuciones() = True Then
        'Si viene desde Reventa Anticipada o Recompra Anticipada NO se grabará ni al operador
        'ni al digitador pues los datos ya están grabados en el primer registro del movimiento
        If Mid$(BacFrmIRF.Tag, 1, 2) = "RV" Or Mid$(BacFrmIRF.Tag, 1, 2) = "RC" Then
            Tipo_Oper = Mid$(BacFrmIRF.Tag, 1, 2) & "A" '--> Se corrige la carga de los libros para las Recompras, Rentas Anticipadas
            lblOperador.Visible = False
            cmbOperador.Enabled = False
            cmbOperador.Visible = False
        Else
            'Seleccionar Operador desde la combo
            'Como no es Operador, llenar combo de Operadores y mostrarla para poder grabar
            lblOperador.Visible = True
            cmbOperador.Visible = True
            cmbOperador.Enabled = True
            'Llena combo con Operadores
            Call LlenaComboOperadores(cmbOperador)
            'Si viene desde Reventa Anticipada o Recompra anticipada, en su formulario
            'ya se seleccionó el Operador por lo que solo debe mostrarlo ahora y dejarlo no Enabled
        End If
    Else
        If Mid$(BacFrmIRF.Tag, 1, 2) = "RV" Or Mid$(BacFrmIRF.Tag, 1, 2) = "RC" Then
            Tipo_Oper = Mid$(BacFrmIRF.Tag, 1, 2) & "A" '--> Se corrige la carga de los libros para las Recompras, Rentas Anticipadas
        End If
        'Operador = digitador
        lblOperador.Visible = False
        cmbOperador.Enabled = False
        cmbOperador.Visible = False
    End If
    
    Call PROC_LLENA_COMBOS(CmbLibro, 8, False, GLB_ID_SISTEMA, Tipo_Oper, GLB_LIBRO, "", gsBac_User)
    Call PROC_LLENA_COMBOS(cmbArea, 1, False, GLB_AREA_RESPONSABLE, GLB_ID_SISTEMA)
    '------------------------------------------------------------------------
       
    Me.cmbEntidad.Enabled = False
    Me.CmbLibro.Enabled = True
    Me.CmbLibro.Visible = True
      
    If Mid$(BacFrmIRF.Tag, 1, 2) = "RC" Or Mid$(BacFrmIRF.Tag, 1, 2) = "RV" Or Mid$(BacFrmIRF.Tag, 1, 2) = "AC" Then
        Me.Tag = IIf(Mid$(BacTrader.ActiveForm.Tag, 1, 2) = "RC", "RC", IIf(Mid$(BacTrader.ActiveForm.Tag, 1, 2) = "RV", "RV", "AC"))
        Me.txtRutCar.Enabled = False
        Me.txtRutCar.text = Rutcart$
        Me.txtDigCar.Enabled = False
        BacIrfGrSinDVP.txtDigCar.text = DvCart$
        Me.txtNomCar.Enabled = False
        Me.txtNomCar.text = NomCart
      
        '++GRC Req007
        ''Call PROC_LLENA_COMBOS(cmbTCart, 2, False, Mid$(BacFrmIRF.Tag, 1, 2), GLB_CARTERA, GLB_ID_SISTEMA)
        Call PROC_LLENA_COMBOS(cmbTCart, 7, False, IIf(Mid$(BacFrmIRF.Tag, 1, 2) = "RP", "VI", Mid$(BacFrmIRF.Tag, 1, 2)), GLB_CARTERA, GLB_ID_SISTEMA, "", gsBac_User)
        '--GRC Req007
                
        Me.cmbTCart.ListIndex = BuscaGlosa(objTipCar, GloCart)
        Me.cmbTCart.Enabled = False
        Me.cmbFPagoIni.Enabled = False
        Me.ChkCustod.Enabled = False
        Me.ChkVamos.Enabled = False
        Me.ChkVienen.Enabled = False

'-------CÓDIGO FUSIÓN
        
        Me.cmbRentabilidad.Enabled = False
        Me.cmbRentabilidad.Visible = False
        Me.lblTtipoRent.Visible = False
       'Corregido para ld1-cor-035
        'Me.cmbEjecutivo.ListIndex = BacBuscaComboIndice(cmbEjecutivo, BacTrader.ActiveForm.nEjecutivo)

'-------CÓDIGO FUSIÓN

        Me.cmbFPagoVct.Enabled = True
        Call objForPag.LeerCodigos(79)
        Call objForPag.Coleccion2Control(cmbFPagoVct)
        Me.cmbFPagoVct.ListIndex = IIf((Val(BacFrmIRF.TxtFpagVcto.text) - 1) > (Me.cmbFPagoVct.ListCount - 1), Me.cmbFPagoVct.ListCount - 1, Val(BacFrmIRF.TxtFpagVcto.text) - 1)
        Me.cmbFPagoVct.Enabled = True
        Me.TxtObserv.Enabled = False
        Me.txtRutCli.text = RutCli
        Me.txtDigCli.text = DvCli
        Me.TxtNomCli.text = NomCli
        Me.TxtCodCli.text = CodCli
        Me.txtRutCli.Enabled = False
        Me.TxtCodCli.Enabled = False
   
    'INTERBANCARIOS
    ElseIf BacFrmIRF.Tag = "IB" Then
   
        cmbFPagoVct.Enabled = True
        ChkCustod.Enabled = False
        cmbTCart.Enabled = True
      
        Me.Tag = "IB"
      
        Call objForPag.LeerCodigos(79)
        Call objForPag.Coleccion2Control(cmbFPagoIni)
     
        
        Call PROC_LLENA_COMBOS(cmbTCart, 7, False, IIf(BacFrmIRF.ChkCol.Value = True, "ICOL", "ICAP"), GLB_CARTERA, GLB_ID_SISTEMA, "", gsBac_User)
        
        '--GRC Req007
     
        Call objForPag.Coleccion2Control(cmbFPagoVct)
        Call objForPag.Coleccion2Control(cmbFPagoVct)
     
      aGrabar = Array(1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0)
      
        Call ActivarControles(aGrabar())
        cmbTCart.Enabled = True
 

'-------CÓDIGO FUSIÓN
        'Call objRentabilidad.CargaSucursal("RENTABILIDAD")
        'Call objRentabilidad.Coleccion2Control(cmbRentabilidad)

        Me.cmbRentabilidad.Enabled = False
        Me.cmbRentabilidad.Visible = False
        Me.lblTtipoRent.Visible = False
        cmbRentabilidad.Enabled = False
        Me.lblEjecutivo.Visible = True
        Me.cmbEjecutivo.Visible = True
        Me.lblEjecutivo.Enabled = True
        Me.cmbEjecutivo.Enabled = True
        'Me.cmbEjecutivo.ListIndex = BacBuscaComboIndice(cmbEjecutivo, BacTrader.ActiveForm.nEjecutivo)
'-------CÓDIGO FUSIÓN
     
  
       
       
       
    ElseIf BacTrader.ActiveForm.Tag = "AN" Then
   
        Call objForPag.LeerCodigos(79)
        Call objForPag.Coleccion2Control(cmbFPagoIni)
        ChkCustod.Enabled = False
        cmbFPagoVct.Enabled = True
        
        '++GRC Req007
        ''Call PROC_LLENA_COMBOS(cmbTCart, 2, False, Mid$(BacFrmIRF.Tag, 1, 2), GLB_CARTERA, GLB_ID_SISTEMA)
       'Call PROC_LLENA_COMBOS(cmbTCart, 2, False, IIf(Mid$(BacFrmIRF.Tag, 1, 2) = "RP", "VI", Mid$(BacFrmIRF.Tag, 1, 2)), GLB_CARTERA, GLB_ID_SISTEMA)
        Call PROC_LLENA_COMBOS(cmbTCart, 7, False, IIf(Mid$(BacFrmIRF.Tag, 1, 2) = "RP", "VI", Mid$(BacFrmIRF.Tag, 1, 2)), GLB_CARTERA, GLB_ID_SISTEMA, "", gsBac_User)

        '--GRC Req007
        
        
        cmbFPagoVct.Enabled = True
        cmbTCart.Enabled = True
        cmbFPagoVct.Enabled = True
        Call objForPag.Coleccion2Control(cmbFPagoVct)
        cmbFPagoVct.Enabled = True
        Call objForPag.Coleccion2Control(cmbFPagoVct)
        cmbTCart.Enabled = True
        Call SeteaDatosCli
          
        Exit Sub
            
    End If

    Call objForPag.LeerCodigos(79)
    Call objForPag.Coleccion2Control(cmbFPagoIni)
   
    ' CAPTACIONES
    If BacFrmIRF.Tag = "IC" Then
      
        Me.Tag = "IC"
        Call objForPag.LeerCodigos(79)
        Call objForPag.Coleccion2Control(cmbFPagoIni)
        Call objForPag.Coleccion2Control(cmbFPagoVct)
        
        ChkCustod.Enabled = False
        cmbFPagoVct.Enabled = True
        
        '++GRC Req007
        ''Call PROC_LLENA_COMBOS(cmbTCart, 2, False, Mid$(BacFrmIRF.Tag, 1, 2), GLB_CARTERA, GLB_ID_SISTEMA)
       'Call PROC_LLENA_COMBOS(cmbTCart, 2, False, IIf(Mid$(BacFrmIRF.Tag, 1, 2) = "RP", "VI", Mid$(BacFrmIRF.Tag, 1, 2)), GLB_CARTERA, GLB_ID_SISTEMA)
        Call PROC_LLENA_COMBOS(cmbTCart, 7, False, IIf(Mid$(BacFrmIRF.Tag, 1, 2) = "RP", "VI", Mid$(BacFrmIRF.Tag, 1, 2)), GLB_CARTERA, GLB_ID_SISTEMA, "", gsBac_User)

        '--GRC Req007
        
        '-> LD1_035_DAP
        Call PROC_LLENA_COMBOS(cmbTCart, 7, False, Tipo_Oper, GLB_CARTERA, GLB_ID_SISTEMA, "", gsBac_User)
        '-> LD1_035_DAP
        
        cmbFPagoVct.Enabled = True
        cmbTCart.Enabled = False
        cmbFPagoVct.Enabled = False
        
        Call objForPag.Coleccion2Control(cmbFPagoVct)
        
        cmbFPagoVct.Enabled = False
        Call objForPag.Coleccion2Control(cmbFPagoVct)
        cmbTCart.Enabled = False
   
'-------CÓDIGO FUSIÓN ITAÚ
        cmbRentabilidad.Enabled = False
'-------CÓDIGO FUSIÓN ITAÚ
   
        '-> LD1_035_DAP
        cmbTCart.Enabled = True '-> cmbTCart.Enabled = True
        '-> LD1_035_DAP
    End If
   
    If BacFrmIRF.Tag = "AC" Then
        cmbFPagoIni.Enabled = True
    End If
   
    ' CAPTACIONES
    If BacFrmIRF.Tag = "RI" Then
        Me.Tag = "RI"

        Call objForPag.LeerCodigos(79)
        Call objForPag.Coleccion2Control(cmbFPagoIni)
        Call objForPag.Coleccion2Control(cmbFPagoVct)
                
        ChkCustod.Enabled = False
        cmbFPagoIni.Enabled = True
        cmbFPagoVct.Enabled = True
        
        Call LLENA_DATOS_RIC(Numero_RIC)
            
        '-> LD1_035_DAP
        Call PROC_LLENA_COMBOS(cmbTCart, 7, False, Tipo_Oper, GLB_CARTERA, GLB_ID_SISTEMA, "", gsBac_User)
        '-> LD1_035_DAP
        
        cmbTCart.Enabled = False
        
        '-> LD1_035_DAP
        cmbTCart.Enabled = True '-> cmbTCart.Enabled = True
        '-> LD1_035_DAP
        
        '-> LD1_035_DAP
        cmbRentabilidad.Enabled = False:
        cmbRentabilidad.Visible = False:
        lblTtipoRent.Visible = False
        '-> LD1_035_DAP
    End If

    If BacFrmIRF.Tag = "AC" Then
        cmbFPagoIni.Enabled = True
    End If

    'COMPRAS PROPIAS
    If Mid$(BacFrmIRF.Tag, 1, 2) = "CP" Then
      
        aGrabar = Array(1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1)
        Call ActivarControles(aGrabar())
        
'-------CÓDIGO FUSIÓN ITAÚ
        lblTtipoRent.Visible = True
        cmbRentabilidad.Enabled = True
        cmbRentabilidad.Visible = True
        
        Call objRentabilidad.CargaSucursal("RENTABILIDAD")
        Call objRentabilidad.Coleccion2Control(cmbRentabilidad)
'-------CÓDIGO FUSIÓN ITAÚ
        
        '++GRC Req007
        ''Call PROC_LLENA_COMBOS(cmbTCart, 2, False, Mid$(BacFrmIRF.Tag, 1, 2), GLB_CARTERA, GLB_ID_SISTEMA)
       'Call PROC_LLENA_COMBOS(cmbTCart, 2, False, IIf(Mid$(BacFrmIRF.Tag, 1, 2) = "RP", "VI", Mid$(BacFrmIRF.Tag, 1, 2)), GLB_CARTERA, GLB_ID_SISTEMA)
        Call PROC_LLENA_COMBOS(cmbTCart, 7, False, IIf(Mid$(BacFrmIRF.Tag, 1, 2) = "RP", "VI", Mid$(BacFrmIRF.Tag, 1, 2)), GLB_CARTERA, GLB_ID_SISTEMA, "", gsBac_User)

        '--GRC Req007
        '----> Proyecto Fusion LD1-COR-035
        '--->  Habilitar combo de Cartera Volcker Rule ITAU
        CmbVolckerRule.Visible = True
        Label1.Visible = True

        '----> se envia opcion 11 para cargar cartera Volcker Rule
        Call PROC_LLENA_COMBOS(CmbVolckerRule, 11, False, IIf(Mid$(BacFrmIRF.Tag, 1, 2) = "RP", "VI", Mid$(BacFrmIRF.Tag, 1, 2)), GBL_CARTERA_VOLCKER_RULE, GLB_ID_SISTEMA, "", gsBac_User)
        
''' deshabilita volcker rule para LD1
'''        If (CmbVolckerRule.ListCount < 1) Then
'''            ' LD1-COR-035 FUSION CORPBANCA - ITAU
'''            ' Esta opcion es Volcker Rule
'''            MsgBox "Este usuario no tiene definido Volcker Rule. No se puede realizar la grabación", vbCritical
'''            CmbVolckerRule.Enabled = False
'''
'''        End If
      
        
        If CmbVolckerRule.Enabled = False Then
            Let VolckerRule = False
            
        End If
        
        '--GRC Req007
         
        Call Proc_Buscar_Valor_Combo(CmbLibro, cCodLibro) 'cCodLibro es una variable publica del formulario
        CmbLibro.Enabled = False
         
        If BacIrfGrSinDVP.ProDpx = "S" Or BacIrfGrSinDVP.proMoneda = "USD" Then
            Call Llena_Corresponsales
        End If
    
    'VENTAS PROPIAS
    ElseIf Mid$(BacFrmIRF.Tag, 1, 2) = "VP" Or Mid$(BacFrmIRF.Tag, 1, 2) = "ST" Then
            
        aGrabar = Array(1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0)
        Call ActivarControles(aGrabar())
                  
        txtRutCar.Enabled = False
        txtDigCar.Enabled = False
        txtNomCar.Enabled = False
        
'-------CÓDIGO FUSIÓN ITAÚ
        cmbRentabilidad.Enabled = False
        cmbRentabilidad.Visible = False
        Me.lblTtipoRent.Visible = False
        
'-------CÓDIGO FUSIÓN ITAÚ

        '++GRC Req007
        ''Call PROC_LLENA_COMBOS(cmbTCart, 2, False, Mid$(BacFrmIRF.Tag, 1, 2), GLB_CARTERA, GLB_ID_SISTEMA)
       'Call PROC_LLENA_COMBOS(cmbTCart, 2, False, IIf(Mid$(BacFrmIRF.Tag, 1, 2) = "RP", "VI", Mid$(BacFrmIRF.Tag, 1, 2)), GLB_CARTERA, GLB_ID_SISTEMA)
        Call PROC_LLENA_COMBOS(cmbTCart, 7, False, IIf(Mid$(BacFrmIRF.Tag, 1, 2) = "RP", "VI", Mid$(BacFrmIRF.Tag, 1, 2)), GLB_CARTERA, GLB_ID_SISTEMA, "", gsBac_User)

        '--GRC Req007
        
        Call Proc_Buscar_Valor_Combo(cmbTCart, Trim(CStr(BacIrfGrSinDVP.cCodCartFin)))
        cmbTCart.Enabled = False
      If BacVP.TipoPago.ListIndex = 2 Then
        cmbTipoPago.ListIndex = 2
        cmbTipoPago.Enabled = False
         
         Dim nCont As Integer
         Dim nSw As Integer
         nSw = 0
         nCont = 1
         Do While nSw = 0
            txtFechaPago.text = Format$(DateAdd("d", nCont, gsBac_Fecx), "dd/mm/yyyy")
            If EsFeriado(CDate(txtFechaPago.text), "00001") Then
               nCont = nCont + 1
            Else
               nSw = 1
            End If
         Loop
    End If

     
        If Mid$(BacFrmIRF.Tag, 1, 2) = "ST" Then
            Call Proc_Buscar_Valor_Combo(CmbLibro, BacIrfGrSinDVP.cCodLibro)
            CmbLibro.Enabled = False
            txtRutCli.text = Val(gsBac_RutC)
            txtDigCli.text = gsBac_DigC
            TxtNomCli.text = gsBac_Clien
        End If
        
        If BacIrfGrSinDVP.ProDpx = "S" Or BacIrfGrSinDVP.proMoneda = "USD" Then
            Call Llena_Corresponsales
        End If
        
            
    'COMPRA CON PACTO
    ElseIf Mid$(BacFrmIRF.Tag, 1, 2) = "CI" Then
            
        Call objForPag.Coleccion2Control(cmbFPagoVct)
        '++GRC Req007
        ''Call PROC_LLENA_COMBOS(cmbTCart, 2, False, Mid$(BacFrmIRF.Tag, 1, 2), GLB_CARTERA, GLB_ID_SISTEMA)
'        Call PROC_LLENA_COMBOS(cmbTCart, 2, False, IIf(Mid$(BacFrmIRF.Tag, 1, 2) = "RP", "VI", Mid$(BacFrmIRF.Tag, 1, 2)), GLB_CARTERA, GLB_ID_SISTEMA)
         Call PROC_LLENA_COMBOS(cmbTCart, 7, False, IIf(Mid$(BacFrmIRF.Tag, 1, 2) = "RP", "VI", Mid$(BacFrmIRF.Tag, 1, 2)), GLB_CARTERA, GLB_ID_SISTEMA, "", gsBac_User)
       
        '--GRC Req007
        
        cmbTCart.ListIndex = IIf(cmbTCart.ListCount > 0, 0, -1)
        
        '***********************************************************************
         
'        If CmbLibro.ListCount = 0 Then
'            Screen.MousePointer = vbDefault
'            MsgBox "No se ha definido un libro por defecto para las compras con pacto.", vbExclamation
'            Exit Sub
'        End If
                        
        '***********************************************************************
        
'-------CÓDIGO FUSIÓN ITAÚ
        cmbRentabilidad.Enabled = False
        cmbRentabilidad.Visible = False
'-------CÓDIGO FUSIÓN ITAÚ
            
        aGrabar = Array(1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0)
        Call ActivarControles(aGrabar())
        cmbFPagoVct.Enabled = True
      
    'VENTA CON PACTO
    'ElseIf (Mid$(BacFrmIRF.Tag, 1, 2) = "VI" Or Mid$(BacFrmIRF.Tag, 1, 2) = "RP") Then
    ElseIf (Mid$(BacFrmIRF.Tag, 1, 2) = "VI") Then
      
        aGrabar = Array(1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0)
        Call ActivarControles(aGrabar())
      
        txtRutCar.Enabled = False
        txtDigCar.Enabled = False
        txtNomCar.Enabled = False

        Call objForPag.Coleccion2Control(cmbFPagoVct)
        
        cmbRentabilidad.Enabled = False
        cmbRentabilidad.Visible = False
        
        '++GRC Req007
        ''Call PROC_LLENA_COMBOS(cmbTCart, 2, False, Mid$(BacFrmIRF.Tag, 1, 2), GLB_CARTERA, GLB_ID_SISTEMA)
       Call PROC_LLENA_COMBOS(cmbTCart, 2, False, IIf(Mid$(BacFrmIRF.Tag, 1, 2) = "RP", "VI", Mid$(BacFrmIRF.Tag, 1, 2)), GLB_CARTERA, GLB_ID_SISTEMA)
       ' Call PROC_LLENA_COMBOS(CmbTCart, 7, False, IIf(Mid$(BacFrmIRF.Tag, 1, 2) = "RP", "VI", Mid$(BacFrmIRF.Tag, 1, 2)), GLB_CARTERA, GLB_ID_SISTEMA, "", gsBac_User)

        '--GRC Req007
        Call Proc_Buscar_Valor_Combo(cmbTCart, Trim(CStr(BacIrfGrSinDVP.cCodCartFin)))
        'cmbTCart.ListIndex = IIf(cmbTCart.ListCount > 0, 0, -1)
       cmbTCart.Enabled = True
       'ElseIf Mid$(BacFrmIRF.Tag, 1, 3) = "FLI" Or Mid$(BacFrmIRF.Tag, 1, 4) = "FLIP" Then
       
        '***************20171227.RCH.LCGP**************************
        If Me.oCliente = gsBac_RutBCCH Then
          '  Me.CmbLibro.Visible = False
          '  Me.lbllibro.Visible = False
           ' Me.cmbTCart.Visible = False
           ' Me.Label(6).Visible = False
            Me.txtRutCli.text = gsBac_RutBCCH '"97029000" REQ.6004
            Me.TxtCodCli.text = 1
            Me.TxtNomCli.text = "BANCO CENTRAL DE CHILE"
            Me.txtRutCli.Enabled = False
            Me.TxtCodCli.Enabled = False
            Me.TxtNomCli.Enabled = False
            Me.cmbTipoPago.Enabled = False
             Call txtRutCli_LostFocus
             cmbFPagoIni.Enabled = True
        cmbFPagoVct.Enabled = True
        
        End If
        '***************20171227.RCH.LCGP**************************
'        cmbFPagoIni.Enabled = True
'        cmbFPagoVct.Enabled = True
'        Call objForPag.Coleccion2Control(cmbFPagoIni)
'        Call objForPag.Coleccion2Control(cmbFPagoVct)
       
       ElseIf Mid$(BacFrmIRF.Tag, 1, 3) = "FLI" Or Mid$(BacFrmIRF.Tag, 1, 4) = "FLIP" Or Mid$(BacFrmIRF.Tag, 1, 2) = "RP" Then
        aGrabar = Array(1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0)
        Call ActivarControles(aGrabar())
        
        Me.Tag = Mid$(BacFrmIRF.Tag, 1, 3)
        txtRutCar.Enabled = False
        txtDigCar.Enabled = False
        txtNomCar.Enabled = False
        cmbFPagoIni.Enabled = False
        cmbFPagoVct.Enabled = False
        Me.CmbMercado.Enabled = False
        Me.cmbTipoPago.Enabled = False
        
        Call objForPag.Coleccion2Control(cmbFPagoIni)
        Call objForPag.Coleccion2Control(cmbFPagoVct)
        
        '++GRC Req007
        ''Call PROC_LLENA_COMBOS(cmbTCart, 2, False, Mid$(BacFrmIRF.Tag, 1, 2), GLB_CARTERA, GLB_ID_SISTEMA)
       'Call PROC_LLENA_COMBOS(cmbTCart, 2, False, IIf(Mid$(BacFrmIRF.Tag, 1, 2) = "RP", "VI", Mid$(BacFrmIRF.Tag, 1, 2)), GLB_CARTERA, GLB_ID_SISTEMA)
        Call PROC_LLENA_COMBOS(cmbTCart, 7, False, IIf(Mid$(BacFrmIRF.Tag, 1, 2) = "RP", "VI", Mid$(BacFrmIRF.Tag, 1, 2)), GLB_CARTERA, GLB_ID_SISTEMA, "", gsBac_User)

        '--GRC Req007
        
        cmbTCart.ListIndex = IIf(cmbTCart.ListCount > 0, 0, -1)
       

     
       
    'VENTA CON PACTO
    ElseIf Mid$(BacFrmIRF.Tag, 1, 2) = "RC" Or Mid$(BacFrmIRF.Tag, 1, 2) = "RV" Then

        CmbLibro.Visible = False
        lbllibro.Visible = False
      
        txtRutCar.Enabled = False
        txtDigCar.Enabled = False
        txtNomCar.Enabled = False
        
        cmbTipoPago.Enabled = False
        txtFechaPago.Enabled = False
        txtCtaCteInicio.Enabled = False
        txtCtaCteFinal.Enabled = False
        cmbSucInicio.Enabled = False
        cmbSucFinal.Enabled = False
        cmbTipoInversion.Enabled = False
        CmbMercado.Enabled = False
        cmbArea.Enabled = False
   
    End If
  
    If cmbFPagoIni.Enabled = True Then
        cmbFPagoIni.ListIndex = IIf(cmbFPagoIni.ListCount >= 0, -1, -1)
    End If
   
    If cmbFPagoVct.Enabled = True Then
        cmbFPagoVct.ListIndex = -1
    End If
    
    If Mid$(BacFrmIRF.Tag, 1, 2) = "IB" Then
        If cmbFPagoIni.ListCount > 0 Then cmbFPagoIni.ListIndex = -1
        If cmbFPagoVct.ListCount > 0 Then cmbFPagoVct.ListIndex = -1
    End If
    
    ''REQ.6008 INTERBANCARIO - COLOCACION
    If Mid$(BacFrmIRF.Tag, 1, 2) = "IB" Or Mid$(BacFrmIRF.Tag, 1, 2) = "IC" Then
        If Mid$(BacFrmIRF.Tag, 1, 2) = "IB" Then            '-> LD1_035_DAP
            If BacInter.ChkContraBCCH.Value = 1 Then
                txtRutCli.text = gsBac_RutBCCH
                TxtNomCli.text = gsBac_NomBCCH
                Call txtRutCli_LostFocus
                TxtNomCli.Enabled = False
                TxtCodCli.Enabled = False
                txtRutCli.Enabled = False
            Else
                TxtNomCli.Enabled = True
                TxtCodCli.Enabled = True
                txtRutCli.Enabled = True
            End If
        Else                                                '-> LD1_035_DAP
            TxtNomCli.Enabled = True                        '-> LD1_035_DAP
            TxtCodCli.Enabled = True                        '-> LD1_035_DAP
            txtRutCli.Enabled = True                        '-> LD1_035_DAP
        End If                                              '-> LD1_035_DAP
    End If
    
    'If Mid$(BacFrmIRF.Tag, 1, 3) = "FLI" Or Mid$(BacFrmIRF.Tag, 1, 4) = "FLIP" Then
    If Mid$(BacFrmIRF.Tag, 1, 3) = "FLI" Or Mid$(BacFrmIRF.Tag, 1, 4) = "FLIP" Or Mid$(BacFrmIRF.Tag, 1, 2) = "RP" Then
         For i% = 0 To cmbFPagoIni.ListCount - 1
             If Trim(Mid(cmbFPagoIni.List(i%), 1, 25)) = gsBac_NomFPagoBCCH Then
                 cmbFPagoIni.ListIndex = i%
                 Exit For
             End If
         Next i%
    End If
        
    'If Mid$(BacFrmIRF.Tag, 1, 3) = "FLI" Or Mid$(BacFrmIRF.Tag, 1, 4) = "FLIP" Then
    If Mid$(BacFrmIRF.Tag, 1, 3) = "FLI" Or Mid$(BacFrmIRF.Tag, 1, 4) = "FLIP" Or Mid$(BacFrmIRF.Tag, 1, 2) = "RP" Then
        For i% = 0 To cmbFPagoVct.ListCount - 1
            If Trim(Mid(cmbFPagoVct.List(i%), 1, 25)) = gsBac_NomFPagoBCCH Then
                cmbFPagoVct.ListIndex = i%
                Exit For
            End If
        Next i%
    End If
    
    txtRutCar.text = gsBac_CartRUT
    txtDigCar.text = gsBac_CartDV
    txtNomCar.text = gsBac_CartNOM
    
    If Mid$(BacFrmIRF.Tag, 1, 2) = "AC" Then
        Me.txtRutCli.Enabled = True
        Me.TxtCodCli.Enabled = True
    End If
    
    If Mid$(BacFrmIRF.Tag, 1, 2) = "VP" Or Mid$(BacFrmIRF.Tag, 1, 2) = "VI" Then
        cmbTCart.Enabled = True
        Call Proc_Buscar_Valor_Combo(CmbLibro, BacIrfGrSinDVP.cCodLibro) 'cCodLibro es una variable publica del formulario
                       
        cmbTCart.Refresh
       ' CmbTCart.Enabled = False ' VB+-23/09/2010
       ' CmbLibro.Enabled = False
                               
        If Mid$(BacFrmIRF.Tag, 1, 2) = "VI" Then 'CASS
            cmbTCart.Refresh
            'CmbTCart.Enabled = False '+-VB23/09/2010
            CmbLibro.Enabled = False
        End If

    End If
  
    'If Mid$(BacFrmIRF.Tag, 1, 3) = "FLI" Then
    If Mid$(BacFrmIRF.Tag, 1, 3) = "FLI" Or Mid$(BacFrmIRF.Tag, 1, 2) = "RP" Then
        Me.CmbLibro.Visible = False
        Me.lbllibro.Visible = False
        Me.cmbTCart.Visible = False
        Me.Label(6).Visible = False
        Me.txtRutCli.text = gsBac_RutBCCH '"97029000" REQ.6004
        Me.TxtCodCli.text = 1
        Me.TxtNomCli.text = "BANCO CENTRAL DE CHILE"
        Me.txtRutCli.Enabled = False
        Me.TxtCodCli.Enabled = False
        Me.TxtNomCli.Enabled = False
        Me.cmbTipoPago.Enabled = False
    End If
    
   Dim oContador  As Long

   
    If Mid$(BacFrmIRF.Tag, 1, 3) = "CP" Then
        If oDVP = 1 Then
            Call objForPag.LeerCodigos(79)
            Call objForPag.ColeccionDVPSi(cmbFPagoIni)
            Call objForPag.ColeccionDVPSi(cmbFPagoVct)
        End If
        If oDVP = 0 Then
            Call objForPag.LeerCodigos(79)
            Call objForPag.ColeccionDVPNo(Me.cmbFPagoIni)
            Call objForPag.ColeccionDVPNo(cmbFPagoVct)
        End If
    End If
   
   If Mid$(BacFrmIRF.Tag, 1, 3) = "CI" Then
      If oDVP = 1 Then
        Call objForPag.LeerCodigos(79)
        Call objForPag.ColeccionDVPSi(cmbFPagoIni)
        Call objForPag.ColeccionDVPSi(cmbFPagoVct)
      End If
      If oDVP = 0 Then
        Call objForPag.LeerCodigos(79)
        Call objForPag.ColeccionDVPNo(cmbFPagoIni)
        Call objForPag.ColeccionDVPNo(cmbFPagoVct)
      End If
   End If
    
   If (Mid$(BacFrmIRF.Tag, 1, 3) = "VI" Or Mid$(BacFrmIRF.Tag, 1, 3) = "RP") Then
      CmbLibro.Visible = True
      lbllibro.Visible = True
      CmbLibro.Enabled = False
      
      If Mid$(BacFrmIRF.Tag, 1, 3) = "VI" Then 'cass
        CmbLibro.Enabled = False
      End If
      
      'If CmbLibro.ListCount > 0 Then CmbLibro.ListIndex = -1
      
      If oDVP = 1 Then
        Call objForPag.LeerCodigos(79)
        Call objForPag.ColeccionDVPSi(cmbFPagoIni)
        Call objForPag.ColeccionDVPSi(cmbFPagoVct)
      End If
      
      If oDVP = 0 Then
        Call objForPag.LeerCodigos(79)
        Call objForPag.ColeccionDVPNo(cmbFPagoIni)
        Call objForPag.ColeccionDVPNo(cmbFPagoVct)
      End If
   End If
   
   
   If Mid$(BacFrmIRF.Tag, 1, 3) = "VP" Then
      CmbLibro.Visible = True
      CmbLibro.Enabled = False
      lbllibro.Visible = True
      
      ''**********************************************************************************
      For nContador = 1 To BacVP.Table1.Rows - 1
          If (BacVP.Table1.TextMatrix(nContador, 0) = "V" Or BacVP.Table1.TextMatrix(nContador, 0) = "P") And BacVP.Table1.TextMatrix(nContador, 18) = "M" Then
              BacVP.bSelPagoMañana = True
              Exit For
          End If
      Next nContador
        
      If BacVP.bSelPagoMañana = True Then
            cmbTipoPago.ListIndex = 1
            cmbTipoPago.Enabled = False
            txtFechaPago.text = Format(gsBac_Fecx, "dd/mm/yyyy")
      End If
      ''**********************************************************************************
      
      If oDVP = 1 Then
        Call objForPag.LeerCodigos(79)
        Call objForPag.ColeccionDVPSi(cmbFPagoIni)
        Call objForPag.ColeccionDVPSi(cmbFPagoVct)
      End If
      
      If oDVP = 0 Then
        Call objForPag.LeerCodigos(79)
        Call objForPag.ColeccionDVPNo(cmbFPagoIni)
        Call objForPag.ColeccionDVPNo(cmbFPagoVct)
      End If
   End If
''**********************************************************************************
    If Mid$(BacFrmIRF.Tag, 1, 3) <> "VP" And Mid$(BacFrmIRF.Tag, 1, 3) <> "CP" Then
            cmbTipoPago.ListIndex = 0
            cmbTipoPago.Enabled = False
    End If
''**********************************************************************************
    
End Sub

Private Function LLENA_DATOS_RIC(numero_Ope As String) As Boolean
    Dim Datos()
    
    LLENA_DATOS_RIC = False
        
    Envia = Array(CDbl(numero_Ope))
    If Not Bac_Sql_Execute("Sp_llena_datos_RIC ", Envia) Then
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then
        txtRutCli.text = Datos(7)
        TxtCodCli.text = Datos(8)
        TxtNomCli.text = Datos(9)
        cmbFPagoIni.ListIndex = BacBuscaComboIndice(cmbFPagoIni, CLng(Datos(4)))
        
        If Datos(5) <> "" Then
            cmbFPagoVct.ListIndex = BacBuscaComboIndice(cmbFPagoIni, CLng(Datos(4)))
        Else
            cmbFPagoVct.ListIndex = -1
        End If

       ' cmbSucursal.ListIndex = BacBuscaComboIndice(cmbSucursal, CLng(datos(12)))
       ' cmbEjecutivo.ListIndex = BacBuscaComboIndice(cmbEjecutivo, CLng(datos(11)))

        If Datos(6) = "R" Then
            ChkVamos.Value = True
            ChkVienen.Value = False
        Else
            ChkVienen.Value = True
            ChkVamos.Value = False
        End If
        TxtObserv.text = Datos(14)
    End If
    
    Call ObjCliente.LeerPorRut(txtRutCli.text, txtDigCli.text, 0, TxtCodCli.text)
    
    txtDigCli.text = Val(ObjCliente.cldv)
'    TIPCLI = Val(ObjCliente.cltipcli)
    Toolbar1.Buttons(2).Enabled = True
    Toolbar1.Buttons(3).Enabled = True
    LLENA_DATOS_RIC = True
    
    
End Function


Private Sub Form_Unload(Cancel As Integer)

    Set ObjCliente = Nothing
    Set objDCartera = Nothing
    Set objForPag = Nothing
    Set objTipCar = Nothing

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case UCase(Button.Description)
        
        Case Is = "GRABAR"
            Call TOOLGRABAR
        
        Case Is = "CANCELAR"
            Call TOOLCANCELAR
            
    End Select
End Sub
Private Sub TOOLCANCELAR()

    Grabacion_Operacion = False


    On Error GoTo BacErrHnd
    Me.MousePointer = 0
        
    '-> LD1_035
    If Chequea_ControlProcesos("OP") = False Then
        If Me.Tag = "VP" Then
            Call oLimPermanencia_vp.Fx_EliminaRegistroLimite(oLimPermanencia_vp.RelacionId)
        End If
        Exit Sub
    End If
    '-> LD1_035

     giAceptar = False
    Unload BacIrfGrSinDVP
    
    Exit Sub
    
BacErrHnd:
    On Error GoTo 0
    Resume
End Sub

Private Function GrabarFli()

If cmbFPagoIni.Enabled Then
   BacGrabar.ForPagoIni = cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex)
ElseIf BacGrabar.TipOper = "FLI" Or BacGrabar.TipOper = "FLIP" Then
   BacGrabar.ForPagoIni = cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex)
Else
   BacGrabar.ForPagoIni = 0
End If


If cmbFPagoVct.Enabled Then
   BacGrabar.ForPagoVcto = cmbFPagoVct.ItemData(cmbFPagoVct.ListIndex)
ElseIf BacGrabar.TipOper = "FLI" Or BacGrabar.TipOper = "FLIP" Then
   BacGrabar.ForPagoVcto = cmbFPagoVct.ItemData(cmbFPagoVct.ListIndex)
Else
   BacGrabar.ForPagoVcto = 0
End If

 BacGrabar.VamosVienen = IIf(ChkVamos.Value, "V", "I")
 BacGrabar.RutCliente = txtRutCli.text
 BacGrabar.DigCliente = txtDigCli.text
 BacGrabar.NomCliente = TxtNomCli.text
 BacGrabar.CodCliente = TxtCodCli.text
 BacGrabar.TipoCliente = ObjCliente.cltipcli
 BacGrabar.Observ = Trim(TxtObserv.text)
 BacGrabar.CtaCteIni = Trim(txtCtaCteInicio.text)
 BacGrabar.CtaCtevcto = Trim(txtCtaCteFinal.text)
 BacGrabar.Mercado = Mid(CmbMercado.text, 1, 1)
 BacGrabar.Sucursal = Trim(cmbSucursal.text)
 BacGrabar.Fecha_PagoMañana = txtFechaPago.text
 BacGrabar.Laminas = IIf(optSi.Value, "S", "N")
 BacGrabar.Tipo_Inversion = Mid(Me.cmbTipoInversion, 1, 1)
 BacGrabar.SucInicio = IIf(cmbSucInicio.ListIndex > -1, cmbSucInicio.ListIndex, "")
 BacGrabar.SucFinal = IIf(cmbSucFinal.ListIndex > -1, cmbSucFinal.ListIndex, "")
 BacGrabar.custodia = IIf(ChkCustod.Value = True, "S", "N")
 BacGrabar.AreaResponsable = Trim(Right(cmbArea.text, 10))
 giAceptar = True
 Unload Me

End Function

Private Sub TOOLGRABAR()

    Dim dNumdocu#, i%
    Dim nOpc As Integer
    Dim SQL As String
    Dim dNumVVista#, dNumVVCom#
    Dim Datos()
    Dim cSecEco As String
    Dim FecPaso$
    Dim nVista%, sObser1$, sObser2$, nI%, sObserv$
    Dim nTope%
    Dim auxUser As String

    Dim Mensaje_CPT As String

    If Chequea_ControlProcesos("OP") = False Then
        Exit Sub
    End If
    
    TxtCodCli_LostFocus
    
   '->   Control de Firma de las condiciones generales para los pactos. PRD-6056 - solicitado por Roberto Fuentes; Cristian Vidal
   If Me.Tag = "CI" Or Me.Tag = "VI" Then
      If ValidarDatos.CondicionesPactoFirmada(Val(txtRutCli.text), Val(TxtCodCli.text)) = False Then
         Exit Sub
      End If
   End If
   '->   Control de Firma de las condiciones generales para los pactos. PRD-6056 - solicitado por Roberto Fuentes; Cristian Vidal

    If ChkDatos() = False Then
        Exit Sub
    End If

    If miSQL.SQL_Execute("SP_PARAMETROS_SISTEMA") = 0 Then
        If Bac_SQL_Fetch(Datos()) Then
            FecPaso$ = Datos(1)
        End If
    End If

    If Format(gsBac_Fecp, "dd/mm/yyyy") <> Format(FecPaso$, "dd/mm/yyyy") Then
        MsgBox "Ud. Se encuentra trabajando  con la siguiente fecha " + FecPaso$ & Chr(10) & _
               "que no corresponde a la  fecha  de  proceso  actual " + Format(gsBac_Fecp, "dd/mm/yyyy") & Chr(10) & _
               "Cierre Bac-Trader e ingrese nuevamente para actualizar los datos.", 16
        Unload BacIrfGrSinDVP
        Exit Sub
    End If
    
    Screen.MousePointer = vbHourglass

    dNumdocu# = 0
    dNumVVista# = 0
    dNumVVCom# = 0
    nVista = 0
   
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = False
    
    'SOLO SI la operación NO ES FLI o ST, en cuyo caso no se hace el cambio
    auxUser = gsBac_User    'Salvar el contenido del usuario actual (Digitador)
    
    If Me.Tag = "RV" Or Me.Tag = "RC" Then
        grabaOperador = False
        actDigitador = False
    Else
        grabaOperador = True
        actDigitador = True
    End If
    
    If cmbOperador.Enabled Then
        If Not (Me.Tag = "FLI" Or Me.Tag = "ST") Then
            If grabaOperador Then
                gsBac_User = Trim(Mid$(cmbOperador.text, 111))
                gsUsuario = gsBac_User
            End If
        End If
    End If
    'Ahora el Operador se grabará como usuario.  Al final se reestablecerá el contenido de auxUser
    
    'Para el Control de Precios y Tasas
    Ctrlpt_RutCliente = txtRutCli.text
    Ctrlpt_CodCliente = TxtCodCli.text
      
    Dim strMsgError As String
    strMsgError = ""
    gstrMensajesError = ""
    
    'inicializo nro ticket
    glngNroTicket = 0
    
    ' variable global que indica si hubo control de margenes , para el retorno de Nro. Operacion hacia la Semilla
    gblnAnalizaMargen = False
    
    ' reviso si el Flag de encendido del proceso
    If blnProcesoArt84Activo("BTR") Then
        'realizo control de márgenes
        If Not blnValidaNormaArt84(Me.Tag) Then
            strMsgError = gstrMensajesError
            MsgBox "La Operación no se puede realizar" & vbCrLf & vbCrLf & "El registro no cumple con la Norma Art84, detalle del problema: " & _
                vbNewLine & "N° de Ticket de la operación : " & glngNroTicket & vbNewLine & vbNewLine & _
                strMsgGeneral, vbCritical, gsBac_Version
            
            ' asocio nro ticket a una operación no válida
            If glngNroTicket > 0 Then
                Call GeneraConfirmacionProceso(glngNroTicket, 0, "BTR", gstrNrosOperacionesIBS)
            End If


            '*******************************************
            Toolbar1.Buttons(2).Enabled = True
            Toolbar1.Buttons(3).Enabled = True
            Screen.MousePointer = vbDefault
            Exit Sub
        End If
    End If
    
    '+++CONTROL IDD, jcamposd asigna marca cuando corresponde control de línea
    If Me.Tag = "IB" And Me.ChkVienen.Value = True Then
        MarcaAplicaLinea = ChkControlLinea.Value
    End If
    '---CONTROL IDD, jcamposd asigna marca cuando corresponde control de línea
    
    
    
    Select Case Me.Tag
        Case "IB": dNumdocu# = GrabarIB()
        Case "CP": dNumdocu# = GrabarCP()
        Case "VP": dNumdocu# = GrabarVP()
        Case "CI": dNumdocu# = GrabarCI()
        Case "VI": dNumdocu# = GrabarVI()
        Case "RP": dNumdocu# = GrabarVI("RP") 'REPOS
        Case "RC": dNumdocu# = GrabarRC()
        Case "RV": dNumdocu# = GrabarRC()
        Case "ST": dNumdocu# = GrabarST()
        Case "FLI": dNumdocu# = GrabarFli()
        Case "IC": dNumdocu# = GrabarIC()
        Case "RI": dNumdocu# = Grabar_RI()
    End Select
    ' reviso si el Flag de encendido del proceso
    If blnProcesoArt84Activo("BTR") Then
        If glngNroTicket > 0 Then
            If gblnAnalizaMargen Then
                Call GeneraConfirmacionProceso(glngNroTicket, CLng(dNumdocu#), "BTR", gstrNrosOperacionesIBS)
            Else
                Call GeneraConfirmacionProceso("0", CLng(dNumdocu#), "BTR", gstrNrosOperacionesIBS)
            End If
        End If
    End If
    
'    'Temporal
'    If Len(gstrMontosEnviados) > 0 Then
'        MsgBox "Detalle Montos Imputados : " & vbNewLine & gstrMontosEnviados
'    End If
      
    If dNumdocu <> 0 Then
        '********** Linea -- Mkilo
        Dim Mensaje_Lin     As String
        Dim Mensaje_Lim     As String
        
        Mensaje_Lin = ""
        Mensaje_Lim = ""
         
        If gsBac_Lineas = "S" Then
        
            Mensaje_Lin = Lineas_Error("BTR", dNumdocu)
            Mensaje_Lim = Limites_Error("BTR", dNumdocu)
             
        End If
        '********** Fin
    
        'PRD-3860
        If Ctrlpt_ModoOperacion = "S" Then
            Mensaje_CPT = ""
        Else
            Mensaje_CPT = Ctrlpt_Mensaje
        End If
        If Trim(Mensaje_Lin) <> "" Then
            Mensaje_CPT = ""
        ElseIf Trim(Mensaje_CPT) <> "" Then
            Mensaje_CPT = vbCrLf & vbCrLf & Mensaje_CPT
        End If
        'fin PRD-3860
        
        sObserv$ = IIf(Len(TxtObserv.text) > 0, TxtObserv.text, " ")
        nI = Len(sObserv$)
        nTope = IIf(nI > 70, 70, nI)
        
        If Mid(RTrim(sObserv$), nTope, 1) <> " " And nI > nTope Then
            Do While Mid(RTrim(sObserv$), nTope, 1) <> " "
                nTope = nTope - 1
            Loop
            nTope = nTope - 1
        End If
                
        sObser1$ = RTrim(Mid(RTrim(sObserv$), 1, nTope))
        sObser2$ = RTrim(Mid(RTrim(sObserv$), nTope + 2, Len(sObserv$) - nTope))
        
        '********** Linea -- Mkilo
        MsgBox "Operación fue grabada con exito " & vbCrLf & vbCrLf & "Número de Operación: " & dNumdocu & Mensaje_Lin & Mensaje_Lim & Mensaje_CPT, vbInformation, gsBac_Version

        gsBac_User = auxUser
        gsUsuario = auxUser
        'Actualizar el digitador, ahora en gsBac_User y gsUsuario, SSI No es FLI ni ST
        If Not (Me.Tag = "FLI" Or Me.Tag = "ST") Then
            If actDigitador Then
                If Not ActualizaDigitador(dNumdocu) Then
                    MsgBox "No se pudo actualizar el Digitador en el movimiento N° " & dNumdocu, vbCritical, gsBac_Version
                End If
            End If
        End If
        nOpc = 1

                Toolbar1.Buttons(2).Enabled = False
                MousePointer = vbHourglass
        
        
                If gsBac_QUEDEF <> gsBac_IMPWIN Then
                    i% = ActArcIni(gsBac_QUEDEF)
                End If
                
'''''                Select Case Me.Tag
'''''                    Case "CP": Sql = ImprimePapeleta(txtRutCar.Text, Str(dNumdocu#), "CP", "N")
'''''                    Case "VP": Sql = ImprimePapeleta(txtRutCar.Text, Str(dNumdocu#), "VP", "N")
'''''                    Case "CI": Sql = ImprimePapeleta(txtRutCar.Text, Str(dNumdocu#), "CI", "N")
'''''                    Case "VI": Sql = ImprimePapeleta(txtRutCar.Text, Str(dNumdocu#), "VI", "N", txtRutCli.Text)
'''''                    Case "IB": Sql = ImprimePapeleta(txtRutCar.Text, Str(dNumdocu#), "IB", "N")
'''''                    Case "ST": Sql = ImprimePapeleta(txtRutCar.Text, Str(dNumdocu#), "ST", "N")
'''''                    Case "RC": Sql = ImprimePapeleta(txtRutCar.Text, Str(dNumdocu#), "RCA", "N")
'''''                    Case "RV": Sql = ImprimePapeleta(txtRutCar.Text, Str(dNumdocu#), "RVA", "N")
'''''                    Case "IC": Sql = ImprimePapeleta(txtRutCar.Text, Str(dNumdocu#), "IC", "N")
'''''                    Case "AC": Sql = ImprimePapeleta(txtRutCar.Text, Str(dNumdocu#), "AC", "N")
'''''                    Case "CPP": Sql = ImprimePapeleta(txtRutCar.Text, Str(dNumdocu#), "AC", "N")
'''''
'''''                End Select


                If gsBac_QUEDEF <> gsBac_IMPWIN Then
                    i% = ActArcIni(gsBac_IMPWIN)
                End If
                
                If SQL = "NO" Then
                    MsgBox "No se pudo imprimir Papeleta(s) de Operación", vbCritical, "Papeletas de Operaciones"
                End If
                
        MousePointer = 0
        
        If Me.Tag <> "IB" Then
           
           Unload BacTrader.ActiveForm
           
        End If
         
        Unload BacIrfGrSinDVP
        
        Grabacion_Operacion = True
        
   Else
        '********** Linea -- Mkilo
        Screen.MousePointer = vbDefault
        Toolbar1.Buttons(3).Enabled = True
        '********** Fin
   End If
End Sub
Private Function blnValidaNormaArt84(strTag As String) As Boolean
Dim blnResult As Boolean
blnResult = True

Select Case strTag
    Case "IB"   ' Interbancario
        If BacInter.ChkCol.Value = True Then
            blnResult = blnRevisaNormaIB()
        End If
    Case "VI"   ' Venta con Pacto
        blnResult = blnRevisaNormaVI()
End Select
blnValidaNormaArt84 = blnResult
End Function
Function blnRevisaNormaVI() As Boolean
Dim blnOutput As Boolean
blnOutput = False

glngNroTicket = 0
Call GeneraArchivoInterfazGrillaVI(BacFrmIRF, txtRutCli, TxtCodCli)
' capturo variable global que indica si los margenes fueron aceptados
blnOutput = gblnProcesoExitoso
blnRevisaNormaVI = blnOutput
End Function
Private Function strTraeEmisorSerie(strSerie As String, Optional strCampo As String) As String
Dim strError As String
strTraeEmisorSerie = ""

    Envia = Array(strSerie)
    If Not Bac_Sql_Execute("SP_CHKINSTSER", Envia) Then
        MsgBox "Serie no pudo ser validada", vbExclamation, gsBac_Version
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        strError = Val(Datos(1))
        If strError = 0 Then
            If Format(Datos(10), "yyyymmdd") <= Format(gsBac_Fecp, "yyyymmdd") Then
                MsgBox "Serie ingresada esta vencida ", vbInformation, gsBac_Version
             '   CPCI_ChkSerie = False
                Exit Function
            End If
            
            If strCampo = "R" Then
                ' RUT
                strTraeEmisorSerie = Trim(Datos(5))
            Else
                strTraeEmisorSerie = Trim(Datos(12))
            End If
        End If
    Else
        MsgBox "No se pudo chequear la serie", vbExclamation, gsBac_Version
    End If
End Function

Function strTraeRutEmisor(strGenerico As String) As String
    strTraeRutEmisor = ""
    ObjEmisor.LeerPorGenerico (strGenerico)
    strTraeRutEmisor = ObjEmisor.emrut
End Function
Private Sub AgrupaValorPresentePorEmisorVI(Frm As Form)
Dim irows As Integer
Dim iRowPaso As Integer
Dim blnExisteEmisor As Boolean
Dim strInfoEmisor As String
Dim strRutEmisor As String

mfgTemporal.Clear
mfgTemporal.Rows = 0
mfgTemporal.cols = 3

For irows = 1 To Frm.GRILLA.Rows - 1
    ' selecciono solo registros que tengan el indicador "V"
    If Trim(Frm.GRILLA.TextMatrix(irows, 0)) = "V" Then
        ' obtengo informacion del emisor a partir de la serie del documento
        strInfoEmisor = strTraeEmisorSerie(Trim(Frm.GRILLA.TextMatrix(irows, 1)))
        strRutEmisor = strTraeEmisorSerie(Trim(Frm.GRILLA.TextMatrix(irows, 1)), "R")
        If strInfoEmisor = "" Or strInfoEmisor = "?????" Then
            strRutEmisor = strTraeRutEmisor(strInfoEmisor)
        End If
        
        If Not blnEmisorNoImputa(strInfoEmisor) Then
            If mfgTemporal.Rows = 0 Then
                ' Agrego nueva fila
                mfgTemporal.AddItem ""
                mfgTemporal.Row = mfgTemporal.Rows - 1
                ' emisor
                mfgTemporal.Col = 0
                mfgTemporal.text = strInfoEmisor
                'monto
                mfgTemporal.Col = 1
                mfgTemporal.text = Frm.GRILLA.TextMatrix(irows, 6)
                'Rut Emisor
                mfgTemporal.Col = 2
                mfgTemporal.text = Trim(strRutEmisor)
            Else
                blnExisteEmisor = False
                'comparo emisores
                For iRowPaso = 0 To mfgTemporal.Rows - 1
                    If Trim(mfgTemporal.TextMatrix(iRowPaso, 0)) = Trim(strInfoEmisor) Then
                        mfgTemporal.Row = iRowPaso
                        mfgTemporal.text = CDbl(mfgTemporal.TextMatrix(iRowPaso, 1)) + CDbl(Frm.GRILLA.TextMatrix(irows, 6))
                        blnExisteEmisor = True
                        Exit For
                    End If
                Next iRowPaso
                If blnExisteEmisor = False Then
                    'Agrego nueva fila
                    mfgTemporal.AddItem ""
                    mfgTemporal.Row = mfgTemporal.Rows - 1
                    ' emisor
                    mfgTemporal.Col = 0
                    mfgTemporal.text = strInfoEmisor
                    'monto
                    mfgTemporal.Col = 1
                    mfgTemporal.text = Frm.GRILLA.TextMatrix(irows, 6)
                    'Rut Emisor
                    mfgTemporal.Col = 2
                    mfgTemporal.text = Trim(strRutEmisor)
                End If
            End If
        End If
    End If
Next irows
End Sub

Function blnExistenEmisoresImputablesVI(Frm As Form) As Boolean
Dim blnResult As Boolean
Dim iRow As Integer
Dim strSerieDoc As String
Dim strEmisor As String
strSerieDoc = ""
    blnExistenEmisoresImputablesVI = False
    For iRow = 1 To Frm.GRILLA.Rows - 1
        ' solo registros que serán vendidos
        If Trim(Frm.GRILLA.TextMatrix(iRow, 0)) = "V" Then
            strSerieDoc = Trim(Frm.GRILLA.TextMatrix(iRow, 1))
            strEmisor = strTraeEmisorSerie(strSerieDoc)
            If blnEmisorNoImputa(strEmisor) = False Then
                  blnExistenEmisoresImputablesVI = True
                  Exit Function
            End If
        End If
    Next iRow
End Function
Function blnRevisaNormaIB() As Boolean
Dim blnOutput As Boolean
blnOutput = False

glngNroTicket = 0

'If Not blnEmisorNoImputa(strTraeGenericoByRut(txtRutCli)) Then
    Call GeneraArchivoInterfazGrillaIB(Me)
'End If

' capturo variable global que indica si los margenes fueron aceptados
blnOutput = gblnProcesoExitoso


blnRevisaNormaIB = blnOutput
End Function


Function strTraeGenericoByRutEmisor(strRut As String) As String
    strTraeGenericoByRutEmisor = ""
    Call ObjEmisor.LeerPorRut(CLng(strRut), "O")
    strTraeGenericoByRutEmisor = ObjEmisor.emgeneric
End Function
Private Sub TxtCodCli_Change()
    'cmdAceptar.Enabled = False
    Toolbar1.Buttons(2).Enabled = True 'aquicap
End Sub
Private Sub TxtCodCli_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then SendKeys "{TAB}"
        KeyAscii = BACValIngNumGrid(KeyAscii)
    
    If Chr(KeyAscii) = "-" Or Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
       KeyAscii = 0
    End If
End Sub
Private Sub TxtCodCli_LostFocus()
On Error GoTo ErrConsulta
    If Len(Trim$(TxtCodCli.text)) = 0 Then Exit Sub
    gsBac_OkComi = 0#
    nMtoCom = 0
    LblEstadoCliente.Caption = ""

    If Val(txtRutCli.text) <> 0 Then
        Call ObjCliente.LeerPorRut(txtRutCli.text, txtDigCli.text, 0, TxtCodCli.text)
        If ObjCliente.clvigente = "N" Then
             Toolbar1.Buttons(2).Enabled = False
             TxtNomCli.text = ""
             LblEstadoCliente.Caption = "Cliente No Se Encuentra Vigente"
             Exit Sub
        End If
        
        If Mid(BacIrfGrSinDVP.Tag, 1, 2) = "IB" Then
           If Val(ObjCliente.cltipcli) > 2 Then
              txtRutCli.text = ""
              txtDigCli.text = ""
              TxtCodCli.text = ""
              MsgBox "Cliente NO es Banco.", 48
              Exit Sub
           End If
        End If
        
        If ObjCliente.clrut = 0 Then
            baccliente.TXTnumrut.text = txtRutCli.text
            baccliente.txtDigito.text = txtDigCli.text
            baccliente.TxtCodigo.text = TxtCodCli.text
            
            txtRutCli.text = ""
            txtDigCli.text = ""
            TxtCodCli.text = ""
            MsgBox "Cliente no existente.", vbExclamation, "BAC Trader"
           'LD1-COR-035 COMENTADO PARA INHABILITAR CREAR CLIENTE
           ' baccliente.Show vbModal
            Toolbar1.Buttons(2).Enabled = True
            txtRutCli.SetFocus
        Else
            txtDigCli.text = ObjCliente.cldv
            TxtNomCli.text = ObjCliente.clnombre
            TxtCodCli.text = ObjCliente.clcodigo
            cCtaCte = ObjCliente.clctacte
            txtCtaCteFinal.text = ObjCliente.clctacte
            txtCtaCteInicio.text = ObjCliente.clctacte
            Toolbar1.Buttons(2).Enabled = True
        End If
        
    End If
    
    Exit Sub
    
ErrConsulta:
    MsgBox "Problemas en verificación de datos: " & err.Description & ". Verifique.", vbExclamation, "BAC Trader"
    Exit Sub
    
End Sub
Private Sub txtDigCli_KeyPress(KeyAscii As Integer)
    If (KeyAscii < Asc("0") And KeyAscii > Asc("9")) Then
        If KeyAscii <> Asc("k") Or KeyAscii <> Asc("K") Then
            KeyAscii = 0
        End If
    End If
    BacToUCase KeyAscii
End Sub
Private Sub TxtNomCli_KeyPress(KeyAscii As Integer)
'    BacToUCase KeyAscii
'
    If KeyAscii = 13 Then
        If cmbFPagoIni.Enabled = True Then 'REQ.6004
         cmbFPagoIni.SetFocus
        End If
    End If
End Sub
Private Sub txtRutCli_Change()
    TxtNomCli.text = ""
    txtDigCli.text = ""
    LblEstadoCliente.Caption = ""
    
    Toolbar1.Buttons(2).Enabled = True
    TxtCodCli.text = "1"
    
    If txtRutCli.text = "" Then
        CmbMercado.ListIndex = 2
        cmbFPagoIni.ListIndex = -1
        txtCtaCteInicio.text = ""
        txtCtaCteFinal.text = ""
        optNo.Value = True
    End If
End Sub
Private Sub txtRutCli_GotFocus()
    If Mid$(BacFrmIRF.Tag, 1, 2) <> "ST" Then
        txtDigCli.text = ""
    End If
End Sub
Private Sub txtRutCli_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then
        Ayuda 1
        Screen.MousePointer = 0
        If Not giAceptar% = False Then SendKeys "{TAB 2}"
    End If
End Sub
Private Sub txtRutCli_KeyPress(KeyAscii As Integer)
    BacCaracterNumerico KeyAscii
    If KeyAscii = 13 Then SendKeys "{TAB}"
End Sub
Private Sub TxtObserv_KeyPress(KeyAscii As Integer)
    BacToUCase KeyAscii
End Sub
Private Sub txtRutCar_Change()
    txtNomCar.text = ""
End Sub
Private Sub txtRutCar_DblClick()
    Ayuda 0
    'txtRutCar_LostFocus
    
End Sub
Private Sub txtRutCar_KeyPress(KeyAscii As Integer)
    BacCaracterNumerico KeyAscii
End Sub
Private Sub txtRutCli_DblClick()
    Ayuda 1
    LblEstadoCliente.Caption = ""
    If Not giAceptar% = False Then SendKeys "{TAB 2}"
End Sub
Private Sub txtRutCli_LostFocus()
    If txtRutCli.text = gsBac_RutBCCH Then 'REQ.6004
        CmbMercado.ListIndex = 1
    Else
        CmbMercado.ListIndex = 2
    End If
        
    If txtRutCli.text = gsBac_RutBCCH And BacTrader.ActiveForm.Tag = "CP" Then ''REQ.6004
        optSi.Value = True
    Else
        optNo.Value = True
    End If
    
    If BacTrader.ActiveForm.Tag = "CI" Then
        optNo.Value = True
    End If
    
    ''REQ.6004
    If gsBac_RutBCCH = txtRutCli.text Then
    
         ''REQ.6008
         If Mid$(BacFrmIRF.Tag, 1, 2) = "IB" Or Mid$(BacFrmIRF.Tag, 1, 2) = "IC" Then
            If BacInter.ChkContraBCCH.Value = 0 Then
               MsgBox "No se puede elegir este Cliente, debe marcar BCCH.", vbInformation, App.Title
               txtRutCli.text = ""
               Exit Sub
            End If
         End If
         
         ''Seleccionar Forma de Pago Banco Central
         cmbFPagoIni.ListIndex = BacBuscaComboIndice(cmbFPagoIni, gsBac_FPagoBCCH)
         cmbFPagoIni.Enabled = False
         cmbFPagoVct.Enabled = False
    Else  'MAP Revisión interna 6004 en todas las pantallas
         cmbFPagoIni.ListIndex = -1
         cmbFPagoVct.ListIndex = -1
         cmbFPagoIni.Enabled = True
         cmbFPagoVct.Enabled = True
         If Mid$(BacFrmIRF.Tag, 1, 2) = "CP" _
            Or Mid$(BacFrmIRF.Tag, 1, 2) = "VP" Then
            cmbFPagoVct.Enabled = False
         End If
    End If
        
    If Mid$(BacFrmIRF.Tag, 1, 2) = "ST" Then cmbFPagoVct.Enabled = False

End Sub

Private Sub TxtRutContraparte_DblClick()
    TxtRutContraparte.text = 0
    TxtNombreContra.text = ""
    TxtContraCod.text = "1"
    gsrut$ = 0
    gsDigito$ = 0
    gsDescripcion$ = ""
    gsvalor$ = 0
    
    Ayuda 3
    If Not giAceptar% = False Then SendKeys "{TAB}"
End Sub

Private Sub TxtRutContraparte_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then
        Ayuda 3
        Screen.MousePointer = 0
        If Not giAceptar% = False Then SendKeys "{TAB 2}"
    End If
End Sub

Private Sub TxtRutContraparte_KeyPress(KeyAscii As Integer)
    BacCaracterNumerico KeyAscii
    If KeyAscii = 13 Then SendKeys "{TAB}"
End Sub

Private Sub TxtRutContraparte_LostFocus()
On Error GoTo ErrConsulta
    If Len(Trim$(TxtCodCli.text)) = 0 Then Exit Sub

    If Val(TxtRutContraparte.text) <> 0 Then
        Call ObjCliente.LeerPorRut(TxtRutContraparte.text, txtDigCli.text, 0, TxtContraCod.text)
        If ObjCliente.clvigente = "N" Then
             Toolbar1.Buttons(2).Enabled = False
             TxtNombreContra.text = ""
             LblEstadoCliente.Caption = "Contraparte No Se Encuentra Vigente"
             Exit Sub
        End If
        
        If ObjCliente.clrut = 0 Then
            
            TxtRutContraparte.text = ""
            TxtContraCod.text = ""
            TxtNombreContra.text = ""
            
            MsgBox "Contraparte no existente.", vbExclamation, "BAC Trader"
            TxtRutContraparte.SetFocus
        Else
            TxtNombreContra.text = ObjCliente.clnombre
            TxtContraCod.text = ObjCliente.clcodigo
        End If
        
    End If
    
    Exit Sub
    
ErrConsulta:
    MsgBox "Problemas en verificación de datos: " & err.Description & ". Verifique.", vbExclamation, "BAC Trader"
    Exit Sub
    
End Sub
