VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacRcRv 
   Appearance      =   0  'Flat
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   5940
   ClientLeft      =   1290
   ClientTop       =   1140
   ClientWidth     =   9960
   FillStyle       =   0  'Solid
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacrcrv.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5940
   ScaleWidth      =   9960
   Begin VB.Frame Frame1 
      Caption         =   "Valores Transferencia"
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
      Height          =   630
      Left            =   75
      TabIndex        =   27
      Top             =   2025
      Width           =   9825
      Begin BACControles.TXTNumero Txt_TasaTran 
         Height          =   315
         Left            =   630
         TabIndex        =   31
         Top             =   225
         Width           =   945
         _ExtentX        =   1667
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
         Text            =   "0,000000"
         Text            =   "0,000000"
         Min             =   "-999"
         Max             =   "9999999999999.9999"
         CantidadDecimales=   "6"
      End
      Begin BACControles.TXTNumero Txt_VpTran 
         Height          =   315
         Left            =   3465
         TabIndex        =   32
         Top             =   225
         Width           =   2490
         _ExtentX        =   4392
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
         Min             =   "-999999999999999"
         Max             =   "999999999999999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero Txt_DifTran 
         Height          =   315
         Left            =   7275
         TabIndex        =   33
         Top             =   225
         Width           =   2295
         _ExtentX        =   4048
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
         Max             =   "999999999999999"
         Separator       =   -1  'True
      End
      Begin VB.Label Label4 
         Caption         =   "Val. Presente. $"
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
         Left            =   1965
         TabIndex        =   30
         Top             =   270
         Width           =   1425
      End
      Begin VB.Label Label3 
         Caption         =   "Dif. $"
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
         Left            =   6600
         TabIndex        =   29
         Top             =   270
         Width           =   540
      End
      Begin VB.Label Label1 
         Caption         =   "Tasa"
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
         Left            =   120
         TabIndex        =   28
         Top             =   270
         Width           =   510
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   8595
      Top             =   15
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacrcrv.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacrcrv.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacrcrv.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacrcrv.frx":0D90
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   495
      Left            =   0
      TabIndex        =   26
      Top             =   0
      Width           =   9960
      _ExtentX        =   17568
      _ExtentY        =   873
      ButtonWidth     =   847
      ButtonHeight    =   820
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbgrabar"
            Description     =   "GRABAR"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbpacto"
            Description     =   "PACTO"
            Object.ToolTipText     =   "Pacto"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "cmblimpiar"
            Description     =   "L IMPIAR"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbsalir"
            Description     =   "SALIR"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSFlexGridLib.MSFlexGrid GridPaso 
      Height          =   2655
      Left            =   0
      TabIndex        =   22
      Top             =   3210
      Width           =   9855
      _ExtentX        =   17383
      _ExtentY        =   4683
      _Version        =   393216
      Cols            =   9
      FixedCols       =   0
      BackColor       =   12632256
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorBkg    =   12632256
      GridLines       =   2
   End
   Begin BACControles.TXTNumero TxtTotal 
      Height          =   315
      Left            =   7935
      TabIndex        =   21
      Top             =   2760
      Width           =   1935
      _ExtentX        =   3413
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
      Max             =   "999999999999999"
      Separator       =   -1  'True
   End
   Begin VB.TextBox TxtFpagVcto 
      Height          =   375
      Left            =   240
      TabIndex        =   14
      Text            =   "TxtFpagVcto"
      Top             =   6120
      Visible         =   0   'False
      Width           =   1455
   End
   Begin Threed.SSFrame FraPctAnt 
      Height          =   825
      Left            =   60
      TabIndex        =   1
      Top             =   1200
      Width           =   9840
      _Version        =   65536
      _ExtentX        =   17357
      _ExtentY        =   1455
      _StockProps     =   14
      Caption         =   "Datos Anticipo de Pacto"
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
      Begin BACControles.TXTNumero TxtDeltaAnt 
         Height          =   315
         Left            =   7350
         TabIndex        =   20
         Top             =   420
         Width           =   1935
         _ExtentX        =   3413
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
         Min             =   "-99999999999999"
         Max             =   "99999999999999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero TxtValAnt 
         Height          =   315
         Left            =   4920
         TabIndex        =   19
         Top             =   435
         Width           =   1815
         _ExtentX        =   3201
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
         Max             =   "999999999999999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero TxtTasaAnt 
         Height          =   315
         Left            =   2940
         TabIndex        =   18
         Top             =   435
         Width           =   1455
         _ExtentX        =   2566
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
         Text            =   "0,00000"
         Text            =   "0,00000"
         Min             =   "-10"
         Max             =   "9999999999999.9999"
         CantidadDecimales=   "5"
         SelStart        =   1
      End
      Begin BACControles.TXTNumero TxtValact 
         Height          =   315
         Left            =   510
         TabIndex        =   17
         Top             =   435
         Width           =   2295
         _ExtentX        =   4048
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
         Max             =   "999999999999999"
         Separator       =   -1  'True
      End
      Begin VB.Label LblTasa 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Tasa Pacto"
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
         Left            =   3120
         TabIndex        =   8
         Top             =   225
         Width           =   990
      End
      Begin VB.Label lbl4 
         AutoSize        =   -1  'True
         Caption         =   "Valor actual"
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
         Left            =   1350
         TabIndex        =   7
         Top             =   210
         Width           =   1035
      End
      Begin VB.Label lbl6 
         AutoSize        =   -1  'True
         Caption         =   "Diferencia"
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
         Left            =   8160
         TabIndex        =   6
         Top             =   195
         Width           =   945
      End
      Begin VB.Label lbl5 
         AutoSize        =   -1  'True
         Caption         =   "Valor Anticipo"
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
         Left            =   5400
         TabIndex        =   5
         Top             =   195
         Width           =   1200
      End
      Begin VB.Label lbl7 
         AutoSize        =   -1  'True
         Caption         =   "$"
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
         Left            =   4500
         TabIndex        =   4
         Top             =   465
         Width           =   330
      End
      Begin VB.Label lbl8 
         AutoSize        =   -1  'True
         Caption         =   "$"
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
         Left            =   90
         TabIndex        =   3
         Top             =   465
         Width           =   330
      End
      Begin VB.Label lbl9 
         AutoSize        =   -1  'True
         Caption         =   "$"
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
         Left            =   6885
         TabIndex        =   2
         Top             =   450
         Width           =   390
      End
   End
   Begin Threed.SSFrame FraOper 
      Height          =   720
      Left            =   45
      TabIndex        =   9
      Top             =   465
      Width           =   9870
      _Version        =   65536
      _ExtentX        =   17410
      _ExtentY        =   1270
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
      Begin BACControles.TXTNumero TxtNumoper 
         Height          =   315
         Left            =   3480
         TabIndex        =   16
         Top             =   300
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
         Max             =   "99999999"
      End
      Begin VB.TextBox TxtNomcli 
         BackColor       =   &H8000000F&
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
         Height          =   330
         Left            =   4770
         TabIndex        =   15
         Top             =   300
         Width           =   4995
      End
      Begin VB.ComboBox CmbCCart 
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
         Left            =   810
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   300
         Width           =   2610
      End
      Begin VB.Label lbl1 
         AutoSize        =   -1  'True
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
         Height          =   195
         Left            =   90
         TabIndex        =   13
         Top             =   345
         Width           =   660
      End
      Begin VB.Label lbl3 
         AutoSize        =   -1  'True
         Caption         =   "Cliente"
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
         Left            =   4860
         TabIndex        =   11
         Top             =   105
         Width           =   600
      End
      Begin VB.Label lbl2 
         AutoSize        =   -1  'True
         Caption         =   "Número"
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
         TabIndex        =   10
         Top             =   105
         Width           =   660
      End
   End
   Begin Threed.SSCommand CmdGrabar 
      Height          =   360
      Left            =   75
      TabIndex        =   23
      Top             =   2700
      Visible         =   0   'False
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   635
      _StockProps     =   78
      Caption         =   "&Grabar"
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
   Begin Threed.SSCommand CmdPacto 
      Height          =   360
      Left            =   1275
      TabIndex        =   24
      Top             =   2700
      Visible         =   0   'False
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   635
      _StockProps     =   78
      Caption         =   "&Pacto"
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
   Begin Threed.SSCommand CmdLimpiar 
      Height          =   360
      Left            =   2475
      TabIndex        =   25
      Top             =   2700
      Visible         =   0   'False
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   635
      _StockProps     =   78
      Caption         =   "&Limpiar"
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
   Begin VB.Label LblTot 
      AutoSize        =   -1  'True
      Caption         =   "Total Operación"
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
      Left            =   6480
      TabIndex        =   12
      Top             =   2800
      Width           =   1410
   End
End
Attribute VB_Name = "BacRcRv"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Public fValor_PFE As Double
Public fValor_CCE As Double


Sub AnticipoPactosLlena_Grilla() 'MODIFICADO 17/01/2000
Dim lRutcart    As String
Dim sTipOper    As String
Dim Datos()     As Variant
Dim Cont        As Integer
Dim cFormato    As String
On Error GoTo ErrCargaANT

    If Me.CmbCCart.ItemData(Me.CmbCCart.ListIndex) <> 0 Then
        lRutcart = Me.CmbCCart.ItemData(Me.CmbCCart.ListIndex)
        Rutcart = Me.CmbCCart.ItemData(Me.CmbCCart.ListIndex)
        NomCart = Me.CmbCCart.Text
    End If

    lNumoper = TxtNumoper.Text
    sTipOper = Mid$(Me.Tag, 1, 2)
    
'    Sql = "EXECUTE SP_BUSCADATOSRCRV "
'    Sql = Sql + "'" + sTipOper$ + "' ,"
'    Sql = Sql + lRutcart + ","
'    Sql = Sql + lNumoper

    Envia = Array(sTipOper, _
            CDbl(lRutcart), _
            CDbl(lNumoper))
        
    If Bac_Sql_Execute("SP_BUSCADATOSRCRV", Envia) Then
    
        ventas = 0
        Do While Bac_SQL_Fetch(Datos())
        
            If Datos(14) <> "" Then FecInip = Datos(14)
            
            UmInip = CDbl(IIf(Len(Trim(Datos(15))) <> 0, Datos(15), "0"))
            ValInip = CDbl(IIf(Len(Trim(Datos(16))) <> 0, Datos(16), "0"))
            TasaP = CDbl(IIf(Len(Trim(Datos(17))) <> 0, Datos(17), "0"))
            PlazoP = CDbl(IIf(Len(Trim(Datos(18))) <> 0, Datos(18), "0"))
            BaseP = CDbl(IIf(Len(Trim(Datos(19))) <> 0, Datos(19), "0"))
            
            If Datos(20) <> "" Then MonedaP = Datos(20)
            If Datos(21) <> "" Then FecVenp = Datos(21)
            
            UmVenp = CDbl(IIf(Len(Trim(Datos(22))) <> 0, Datos(22), "0"))
            ValVenp = CDbl(IIf(Len(Trim(Datos(23))) <> 0, Datos(23), "0"))
            RutCli = CDbl(IIf(Len(Trim(Datos(24))) <> 0, Datos(24), "0"))
            
            If Datos(25) <> 0 Then DvCart = Datos(25)
            If Datos(26) <> 0 Then DvCli = Datos(26)
            If Datos(27) <> "" Then GloCart = Datos(27)
            
            ValMon = CDbl(IIf(Len(Trim(Datos(6))) <> 0, Datos(6), "0"))
            
            If Datos(30) <> 0 Then TxtFpagVcto.Text = Datos(30)
            
            CodCli = CDbl(IIf(Len(Trim(Datos(31))) <> 0, Datos(31), "0"))
            
            If Datos(28) > 0 Then
                ventas = Datos(28)
            End If
            
            Me.TxtTasaAnt.Text = CDbl(IIf(Len(Trim(Datos(17))) <> 0, Datos(17), "0"))
            Me.TxtNomCli.Text = Datos(1)
            If MonedaP = "USD" Then
                cFormato = "#,##0.00"
            ElseIf MonedaP = "CLP" Then
                cFormato = "#,##0"
            Else
                cFormato = "#,##0.0000"
            End If
            
'            Call funcFindDatGralMoneda(Val(Datos(36)))
            SwMx = BacDatGrMon.mnmx
            
            Me.TxtValact.Text = CDbl(IIf(Len(Trim(Datos(2))) <> 0, Datos(2), "0"))
            Me.TxtValAnt.Text = CDbl(IIf(Len(Trim(Datos(4))) <> 0, Datos(4), "0"))
            Me.TxtDeltaAnt.Text = CDbl(IIf(Len(Trim(Datos(5))) <> 0, Datos(5), "0"))
            Me.TxtTotal.Text = CDbl(IIf(Len(Trim(Datos(16))) <> 0, Datos(16), "0"))
            Me.GridPaso.Col = 0: Me.GridPaso.Text = Datos(7)
            Me.GridPaso.Col = 1: Me.GridPaso.Text = Datos(8)
            Me.GridPaso.Col = 2: Me.GridPaso.Text = Datos(9)
            Me.GridPaso.Col = 3: Me.GridPaso.Text = Format(CDbl(IIf(Len(Trim(Datos(10))) <> 0, Datos(10), "0")), "#,##0.0000")
            Me.GridPaso.Col = 4: Me.GridPaso.Text = Format(CDbl(IIf(Len(Trim(Datos(11))) <> 0, Datos(11), "0")), "#,##0.0000")
            Me.GridPaso.Col = 5: Me.GridPaso.Text = Format(CDbl(IIf(Len(Trim(Datos(12))) <> 0, Datos(12), "0")), "#,##0.0000")
            Me.GridPaso.Col = 6: Me.GridPaso.Text = Format(CDbl(IIf(Len(Trim(Datos(13))) <> 0, Datos(13), "0")), cFormato)
            Me.GridPaso.Col = 7: Me.GridPaso.Text = Format(CDbl(IIf(Len(Trim(Datos(32))) <> 0, Datos(32), "0")), "#,##0.0000")
            Me.GridPaso.Col = 8: Me.GridPaso.Text = Format(CDbl(IIf(Len(Trim(Datos(33))) <> 0, Datos(33), "0")), "#,##0")
            Cont% = Cont% + 1
            NomCli = Me.TxtNomCli.Text
            If Datos(34) <> 0 Then fValor_PFE = Datos(34)
            If Datos(35) <> 0 Then fValor_CCE = Datos(35)
            Me.GridPaso.Rows = GridPaso.Rows + 1
            Me.GridPaso.Row = GridPaso.Rows - 1
            
        Loop
        
        Me.GridPaso.Rows = Me.GridPaso.Rows - 1
            
        If GridPaso.Rows > 1 Then
            Me.FraPctAnt.Enabled = True
            Me.TxtTasaAnt.SetFocus
                
            If FecInip = gsBac_Fecp Then
                Me.FraPctAnt.Enabled = False
                Me.TxtNumoper.SetFocus
                MsgBox "Operación del mismo día, Debe Anular", vbExclamation, gsBac_Version
                Call Limpiar
                TxtNumoper.Text = ""
            Else
                If ventas > 0 Then
                    Me.FraPctAnt.Enabled = False
                    Me.TxtNumoper.SetFocus
                    MsgBox "Instrumentos vendidos en Op. Nº " & CStr(ventas) & ", Imposible Anticipar", vbExclamation, gsBac_Version
                    Call Limpiar
                End If
            End If

        Else
            Me.FraPctAnt.Enabled = False
            Me.TxtNumoper.SetFocus
            MsgBox "Numero de operación ingresada no existe", vbExclamation, gsBac_Version
            Call Limpiar
        End If
                       
        'Me.Table1.Rows = 0
        'Me.Table1.Rows = GridPaso.Rows - 1
        GridPaso.Highlight = False
        
    End If
    'Para Control de Precios y Tasas
    Ctrlpt_Moneda = MonedaP
    Ctrlpt_Plazo = PlazoP
    Exit Sub
    
ErrCargaANT:
    MsgBox "No se pudo carga datos de pacto : " & err.Description & ". Comunique al Administrador.", vbExclamation, gsBac_Version
    Exit Sub
End Sub

Sub Limpiar()
           
    TxtNomCli.Text = ""
    TxtValact.Text = 0
    TxtTasaAnt.Text = 0
    TxtValAnt.Text = 0
    TxtDeltaAnt.Text = 0
    TxtTotal.Text = 0
    TxtFpagVcto.Text = ""
    TxtNumoper.Text = 0
    Txt_TasaTran.Text = 0
    Txt_VpTran.Text = 0
    Txt_DifTran.Text = 0
    
    GridPaso.Rows = 2
    GridPaso.Row = 1
    
    GridPaso.Rows = 1
    GridPaso.Refresh
    GridPaso.Rows = 2
    'Table1.Rows = GridPaso.Rows - 1
    GridPaso.HighLight = False
        
    FecInip = ""
    UmInip = 0
    ValInip = 0
    TasaP = 0
    PlazoP = 0
    BaseP = 0
    MonedaP = ""
    FecVenp = ""
    UmVenp = 0
    ValVenp = 0
    Rutcart = ""
    DvCart = ""
    NomCart = ""
    RutCli = ""
    CodCli = 0
    DvCli = ""
    NomCli = ""
    GloCart = ""
    ValMon = 0
   TxtNumoper.SetFocus 'VERCOMOFUNCIONA
End Sub


Private Sub Proc_Grabar()

    If TxtNumoper.Text = 0 Then
      Exit Sub
    End If

    If Not Proc_Valida_Tasa_Transferencia(CDbl(Me.TxtTasaAnt.Text), CDbl(Txt_TasaTran.Text)) Then
        Txt_TasaTran.SetFocus
        Exit Sub
    End If

    Call BacGrabarTX

End Sub

Sub Setea_Grilla()

End Sub


Private Sub cmdgrabar_Click()
    Call BacGrabarTX
End Sub

Private Sub CmdPacto_Click()
            
'        Screen.MousePointer = vbHourglass
'
'      ' Muestra los datos del pacto.-
'        If Val(TxtNumoper.Text) = 0 Then
'            Screen.MousePointer = vbDefault
'            Exit Sub
'        End If
'        'BacFrmCentrar BacIrfPac
'
'      ' Llena objetos.-
'        BacIrfPac.TxtFecIni.Text = FecInip
'        BacIrfPac.TxtFecVto.Text = FecVenp
'        BacIrfPac.TxtPlazop.Text = Val(PlazoP)
'        BacIrfPac.TxtTasPac.Text = CDbl(TasaP)
'        BacIrfPac.txtbaspac.Text = Val(BaseP)
'        BacIrfPac.TxtMonPac.Text = MonedaP
'        BacIrfPac.TxtValiniMp.Text = Val(UmInip)
'        BacIrfPac.TxtValiniPs.Text = CDbl(ValInip)
'        BacIrfPac.TxtValvtoMp.Text = CDbl(UmVenp)
'        BacIrfPac.TxtValvtoPs.Text = CDbl(ValVenp)
'
'        BacIrfPac.LblFecIni.Caption = BacDiaSem(FecInip)
'        BacIrfPac.LblFecVto.Caption = BacDiaSem(FecVenp)
'        BacIrfPac.LblMonIni.Caption = MonedaP
'        BacIrfPac.LblMonVto.Caption = MonedaP
'
'        Screen.MousePointer = vbDefault
'
'        BacIrfPac.Show vbModal
'
End Sub
Private Sub Form_Activate()


    Tipo_Operacion = Left(Me.Tag, 2)
    
    Call Proc_Consulta_Porcentaje_Transacciones(Left(Me.Tag, 2))
    
    Screen.MousePointer = 0
    Me.TxtNumoper.SetFocus
  
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

    If KeyAscii = vbKeyReturn Then
        SendKeys "{TAB}"
            KeyAscii = 0
    End If
        
End Sub

Private Sub Form_Load()

    Dim I%
    
    Screen.MousePointer = vbHourglass
      
    Me.Top = 0
    Me.Left = 0
        
    Set objTipCar = New clsDCarteras
    
    Call objTipCar.LeerDCarteras("")
    Call objTipCar.Coleccion2Control(Me.CmbCCart)
    
    Me.CmbCCart.ListIndex = 0
    Me.FraPctAnt.Enabled = False
   
  
  ' Setear mouse pointer por defecto.-
    GridPaso.ColWidth(0) = 1350
    GridPaso.ColWidth(1) = 1550
    GridPaso.ColWidth(2) = 600
    GridPaso.ColWidth(3) = 2000
    GridPaso.ColWidth(4) = 1200
    GridPaso.ColWidth(5) = 1500
    GridPaso.ColWidth(6) = 1500
    GridPaso.ColWidth(7) = 0
    GridPaso.ColWidth(8) = 0
    GridPaso.TextMatrix(0, 0) = "Serie"
    GridPaso.TextMatrix(0, 1) = "Emisor"
    GridPaso.TextMatrix(0, 2) = "Um"
    GridPaso.TextMatrix(0, 3) = "Nominal"
    GridPaso.TextMatrix(0, 4) = "%Tir"
    GridPaso.TextMatrix(0, 5) = "Precio %"
    GridPaso.TextMatrix(0, 6) = "Valor Presente"
    
    Call LeeModoControlPT   'PRD-3860, modo silencioso
    
    Screen.MousePointer = vbDefault
    
End Sub



Private Sub Table1_Fetch(Row As Long, Col As Integer, Value As String)
        GridPaso.Row = Row
        GridPaso.Col = Col
        Table1.Text = GridPaso.Text
End Sub



Private Sub Table1_FetchAttributes(Status As Integer, Split As Integer, Row As Long, Col As Integer, FgColor As Long, BgColor As Long, FontStyle As Integer)

    If Row = Table1.RowIndex Then
        FgColor = BacToolTip.Color_Dest.ForeColor
        BgColor = BacToolTip.Color_Dest.BackColor
    Else
        FgColor = BacToolTip.Color_Normal.ForeColor
        BgColor = BacToolTip.Color_Normal.BackColor
    End If
    
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Description)
    Case "GRABAR"
        Call Proc_Grabar
    Case "PACTO"
        Call TOOLPACTO
    Case "LIMPIAR"
    Case "SALIR"    'JBH, 19-11-2009
        Unload Me
End Select
End Sub


Function TOOLPACTO()
      Screen.MousePointer = vbHourglass
        
      ' Muestra los datos del pacto.-
        If Val(TxtNumoper.Text) = 0 Then
            Screen.MousePointer = vbDefault
            Exit Function
        End If
        'BacFrmCentrar BacIrfPac
        
      ' Llena objetos.-
        BacIrfPac.TxtFecIni.Text = IIf(Len(Trim(FecInip)) <> 0, FecInip, Date)
        BacIrfPac.TxtFecVto.Text = IIf(Len(Trim(FecVenp)) <> 0, FecVenp, Date)
        BacIrfPac.TxtPlazop.Text = CDbl(PlazoP)
        BacIrfPac.TxtTasPac.Text = CDbl(TasaP)
        BacIrfPac.txtbaspac.Text = Val(BaseP)
        BacIrfPac.TxtMonPac.Text = MonedaP
        BacIrfPac.TxtValiniMp.Text = Val(UmInip)
    
        BacIrfPac.TxtValiniPs.Enabled = False 'era true
       'aqui locked 'BacIrfPac.TxtValiniPs.Locked = True
        BacIrfPac.TxtValiniPs.Visible = True
        
        BacIrfPac.TxtValiniPs.Text = CDbl(ValInip)
        BacIrfPac.TxtValvtoMp.Enabled = True
        BacIrfPac.TxtValvtoMp.Text = CDbl(UmVenp)
        BacIrfPac.TxtValvtoPs.Enabled = True
        BacIrfPac.TxtValvtoPs.Text = CDbl(ValVenp)
        
        BacIrfPac.TxtValvtoMp.Enabled = False
        BacIrfPac.TxtValvtoPs.Enabled = False
        BacIrfPac.TxtValiniPs.Enabled = False
        
        BacIrfPac.LblFecIni.Caption = BacDiaSem(FecInip)
        BacIrfPac.LblFecVto.Caption = BacDiaSem(FecVenp)
        BacIrfPac.LblMonIni.Caption = MonedaP
        BacIrfPac.LblMonVto.Caption = MonedaP

        Screen.MousePointer = vbDefault
        
        BacIrfPac.Show vbModal
            
End Function

Private Sub Txt_TasaTran_KeyPress(KeyAscii As Integer)

    If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
        KeyAscii = Asc(gsBac_PtoDec)
    End If
    
    If KeyAscii = vbKeyReturn Then
        SendKeys "{TAB}"
    End If

End Sub

Private Sub Txt_TasaTran_LostFocus()

    If Txt_TasaTran.Text = 0 Then
         Txt_VpTran.Text = 0
         Txt_DifTran.Text = 0
         
         Exit Sub
    End If

    Txt_VpTran.Text = Round((UmVenp / (((CDbl(Txt_TasaTran.Text) / (BaseP * 100)) * DateDiff("d", gsBac_Fecp, FecVenp)) + 1)) * ValMon, 0)
    Txt_DifTran.Text = TxtValAnt.Text - Txt_VpTran.Text
    
    If Txt_VpTran.Text <> 0 And Txt_TasaTran.Text <> 0 Then
        If Not Proc_Valida_Tasa_Transferencia(CDbl(TxtTasaAnt.Text), CDbl(Txt_TasaTran.Text)) Then
            'se omite enviar desde aqui mensaje ya que lo envia la funcion de validacion
        End If
    End If
    

End Sub


Private Sub TxtNumoper_GotFocus()

    TxtNumoper.Tag = TxtNumoper.Text
    
End Sub

Private Sub TxtNumoper_LostFocus()
    
    If TxtNumoper.Text <> TxtNumoper.Tag Then
        
        Screen.MousePointer = 11
        
        'Call Limpiar
        Call AnticipoPactosLlena_Grilla
        'Call Setea_Grilla
        
        TxtNumoper.Tag = TxtNumoper.Text
        Screen.MousePointer = 0
        
        If TxtNumoper.Text = 0 Then
           Call TxtNumoper.SetFocus
        End If
        
        Call TxtTasaAnt_LostFocus
        
        Txt_TasaTran.Text = TxtTasaAnt.Text
        Call Txt_TasaTran_LostFocus
    Else
      On Error Resume Next
      Call TxtNumoper.SetFocus
      On Error GoTo 0
    End If
        
End Sub

Private Sub TxtTasaAnt_GotFocus()
    
'    TxtTasaAnt.Tag = TxtTasaAnt.Text

End Sub

Private Sub TxtTasaAnt_KeyPress(KeyAscii As Integer)

    If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
        KeyAscii = Asc(gsBac_PtoDec)
    End If

End Sub


Private Sub TxtTasaAnt_LostFocus()
    
    If TxtNumoper.Text = 0 Then
      Exit Sub
    End If
    
    
    Screen.MousePointer = vbHourglass

  ' Vb+- 08/09/2000 Se cambia calculo de anticipo el cual debe ser a rendimiento
    
    ''''If gsBac_PtoDec = "." Then
        TxtValAnt.Text = Round((UmVenp / (((CDbl(TxtTasaAnt.Text) / (BaseP * 100)) * DateDiff("d", gsBac_Fecp, FecVenp)) + 1)) * ValMon, 0)
    ''''Else
    ''''    TxtValAnt.Text = Round((UmVenp / (((CDbl(TxtTasaAnt.Text) / (BaseP * 100)) * DateDiff("d", gsBac_Fecp, FecVenp)) + 1)) * ValMon, 0)
    ''''End If
    
    TxtDeltaAnt.Text = CDbl(Me.TxtValAnt.Text) - CDbl(Me.TxtValact.Text)
    
   If Txt_TasaTran.Text <> TxtTasaAnt.Text Then
      On Error Resume Next
      Let Txt_TasaTran.Text = TxtTasaAnt.Text
      Call Txt_TasaTran_LostFocus
      On Error GoTo 0
   End If
    
    Screen.MousePointer = vbDefault
  
    'Como aun no conozco al cliente...
    Ctrlpt_RutCliente = "0"
    Ctrlpt_CodCliente = "0"

   If ControlPreciosTasas(Mid$(Me.Tag, 1, 2), Ctrlpt_Moneda, Ctrlpt_Plazo, CDbl(TxtTasaAnt.Text)) = "S" Then
    If Ctrlpt_ModoOperacion <> "S" Then 'PRD-3860, modo silencioso
        MsgBox Ctrlpt_Mensaje, vbExclamation, TITSITEMA
   End If
   End If
    
End Sub




