VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacValIRF 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Valorizador IRF"
   ClientHeight    =   4785
   ClientLeft      =   1320
   ClientTop       =   1620
   ClientWidth     =   10740
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacval.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   NegotiateMenus  =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4785
   ScaleWidth      =   10740
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   495
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   10740
      _ExtentX        =   18944
      _ExtentY        =   873
      ButtonWidth     =   847
      ButtonHeight    =   820
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "cmbbuscar"
            Description     =   "BUSCAR"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "cmblimpiar"
            Description     =   "LIMPIAR"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbsalir"
            Description     =   "SALIR"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   7560
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacval.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacval.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacval.frx":0A76
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   1095
      Left            =   -75
      TabIndex        =   3
      Top             =   450
      Width           =   10575
      _Version        =   65536
      _ExtentX        =   18653
      _ExtentY        =   1931
      _StockProps     =   14
      Caption         =   " Datos de Entrada "
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
      Begin BACControles.TXTNumero IntBasMon 
         Height          =   315
         Left            =   7560
         TabIndex        =   45
         Top             =   600
         Width           =   1095
         _ExtentX        =   1931
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
      End
      Begin BACControles.TXTNumero FltValMon 
         Height          =   315
         Left            =   4395
         TabIndex        =   5
         TabStop         =   0   'False
         Top             =   600
         Width           =   1815
         _ExtentX        =   3201
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
         Text            =   "0,00"
         Text            =   "0,00"
         Max             =   "999999999999.9999"
         CantidadDecimales=   "2"
      End
      Begin BACControles.TXTFecha DatFecCal 
         Height          =   315
         Left            =   1560
         TabIndex        =   1
         Top             =   600
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   556
         Enabled         =   -1  'True
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "13/11/2000"
      End
      Begin VB.TextBox TxtSerie 
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
         MaxLength       =   10
         TabIndex        =   0
         Top             =   600
         Width           =   1335
      End
      Begin VB.TextBox TxtGenEmi 
         Enabled         =   0   'False
         ForeColor       =   &H00000000&
         Height          =   315
         Left            =   6360
         MaxLength       =   5
         TabIndex        =   14
         Top             =   600
         Width           =   855
      End
      Begin VB.TextBox TxtMonEmi 
         Enabled         =   0   'False
         Height          =   315
         Left            =   3360
         MaxLength       =   5
         TabIndex        =   2
         Top             =   600
         Width           =   735
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Serie"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   240
         TabIndex        =   20
         Top             =   360
         Width           =   450
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Fecha de Cálculo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   1560
         TabIndex        =   19
         Top             =   360
         Width           =   1500
      End
      Begin VB.Label Label11 
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
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   7680
         TabIndex        =   18
         Top             =   360
         Width           =   435
      End
      Begin VB.Label Label10 
         AutoSize        =   -1  'True
         Caption         =   "Valor"
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
         Left            =   4425
         TabIndex        =   17
         Top             =   360
         Width           =   450
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         Caption         =   "Emisor"
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
         Left            =   6360
         TabIndex        =   16
         Top             =   360
         Width           =   570
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
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
         Left            =   3360
         TabIndex        =   15
         Top             =   360
         Width           =   690
      End
   End
   Begin Threed.SSFrame SSFrame3 
      Height          =   2175
      Left            =   60
      TabIndex        =   21
      Top             =   1590
      Width           =   7455
      _Version        =   65536
      _ExtentX        =   13150
      _ExtentY        =   3836
      _StockProps     =   14
      Caption         =   " Datos y Cálculo "
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
      Begin BACControles.TXTNumero FltVpreUm 
         Height          =   315
         Left            =   3480
         TabIndex        =   12
         Top             =   1440
         Width           =   2055
         _ExtentX        =   3625
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         Max             =   "999999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero FltValPar 
         Height          =   315
         Left            =   120
         TabIndex        =   11
         Top             =   1440
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
         Text            =   "0,00000000"
         Text            =   "0,00000000"
         Max             =   "999999999999.9999999"
         CantidadDecimales=   "8"
         Separator       =   -1  'True
         SelStart        =   5
      End
      Begin BACControles.TXTNumero IntVPresen 
         Height          =   315
         Left            =   5640
         TabIndex        =   9
         Top             =   600
         Width           =   1695
         _ExtentX        =   2990
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
         Text            =   "0,00"
         Text            =   "0,00"
         Max             =   "999999999999.9999"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero FltPvp 
         Height          =   315
         Left            =   4440
         TabIndex        =   10
         Top             =   600
         Width           =   1095
         _ExtentX        =   1931
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         Max             =   "999999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero FltTir 
         Height          =   315
         Left            =   3600
         TabIndex        =   8
         Top             =   600
         Width           =   735
         _ExtentX        =   1296
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         Max             =   "999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero FltValNom 
         Height          =   315
         Left            =   1320
         TabIndex        =   7
         Top             =   600
         Width           =   2175
         _ExtentX        =   3836
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         Max             =   "999999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero FltTasEst 
         Height          =   315
         Left            =   120
         TabIndex        =   6
         Top             =   600
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         Max             =   "999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin Threed.SSCommand SSCGoVal 
         Height          =   450
         Left            =   6000
         TabIndex        =   13
         Top             =   1320
         Width           =   1200
         _Version        =   65536
         _ExtentX        =   2117
         _ExtentY        =   794
         _StockProps     =   78
         Caption         =   "&Valorizar"
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
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Tir"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   3600
         TabIndex        =   28
         Top             =   360
         Width           =   240
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Nominal"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   1320
         TabIndex        =   27
         Top             =   360
         Width           =   690
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "% V. Par"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   4440
         TabIndex        =   26
         Top             =   360
         Width           =   735
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "M.Transado ($)"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   5640
         TabIndex        =   25
         Top             =   360
         Width           =   1305
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "T.Estimada"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   120
         TabIndex        =   24
         Top             =   360
         Width           =   975
      End
      Begin VB.Label Label12 
         AutoSize        =   -1  'True
         Caption         =   "Valor Par"
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
         Left            =   120
         TabIndex        =   23
         Top             =   1200
         Width           =   795
      End
      Begin VB.Label Label13 
         AutoSize        =   -1  'True
         Caption         =   "Monto Transado UM"
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
         Left            =   3480
         TabIndex        =   22
         Top             =   1200
         Width           =   1740
      End
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   1260
      Left            =   7560
      TabIndex        =   29
      Top             =   1590
      Width           =   2895
      _Version        =   65536
      _ExtentX        =   5106
      _ExtentY        =   2222
      _StockProps     =   14
      Caption         =   " Modo de Cálculo "
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
      Begin Threed.SSOption SSO_TirMt 
         Height          =   255
         Left            =   195
         TabIndex        =   32
         Top             =   330
         Width           =   2175
         _Version        =   65536
         _ExtentX        =   3836
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "TIR + Monto Transado"
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
         Enabled         =   0   'False
      End
      Begin Threed.SSOption SSO_PvpMt 
         Height          =   255
         Left            =   195
         TabIndex        =   31
         Top             =   630
         Width           =   2520
         _Version        =   65536
         _ExtentX        =   4445
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "%Valor Par + Monto Trans."
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
         Enabled         =   0   'False
      End
      Begin Threed.SSOption SSO_PvpTir 
         Height          =   255
         Left            =   195
         TabIndex        =   30
         Top             =   945
         Width           =   2295
         _Version        =   65536
         _ExtentX        =   4048
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "%Valor Par + TIR"
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
         Enabled         =   0   'False
      End
   End
   Begin Threed.SSFrame SSFrame4 
      Height          =   930
      Left            =   7560
      TabIndex        =   33
      Top             =   2835
      Width           =   2895
      _Version        =   65536
      _ExtentX        =   5106
      _ExtentY        =   1640
      _StockProps     =   14
      Caption         =   "Datos Serie"
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
      Begin BACControles.TXTFecha DateCupon 
         Height          =   345
         Left            =   120
         TabIndex        =   48
         Top             =   450
         Visible         =   0   'False
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   609
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "13/11/2000"
      End
      Begin Threed.SSPanel SSPanel12 
         Height          =   330
         Left            =   120
         TabIndex        =   34
         Top             =   450
         Width           =   1215
         _Version        =   65536
         _ExtentX        =   2143
         _ExtentY        =   582
         _StockProps     =   15
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         RoundedCorners  =   0   'False
         Autosize        =   3
      End
      Begin Threed.SSPanel SSPanel13 
         Height          =   345
         Left            =   1440
         TabIndex        =   35
         Top             =   450
         Width           =   1305
         _Version        =   65536
         _ExtentX        =   2302
         _ExtentY        =   609
         _StockProps     =   15
         Caption         =   "SSPanel13"
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.26
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         RoundedCorners  =   0   'False
         Autosize        =   3
         Begin BACControles.TXTFecha DateVcto 
            Height          =   315
            Left            =   15
            TabIndex        =   50
            Top             =   15
            Visible         =   0   'False
            Width           =   1275
            _ExtentX        =   2249
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
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "13/11/2000"
         End
      End
      Begin VB.Label Label14 
         AutoSize        =   -1  'True
         Caption         =   "F.Pago Cupón"
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
         Left            =   120
         TabIndex        =   37
         Top             =   240
         Width           =   1215
      End
      Begin VB.Label Label15 
         AutoSize        =   -1  'True
         Caption         =   "F.Vencimiento"
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
         Left            =   1440
         TabIndex        =   36
         Top             =   240
         Width           =   1215
      End
   End
   Begin Threed.SSFrame SSFrame5 
      Height          =   735
      Left            =   45
      TabIndex        =   38
      Top             =   3765
      Width           =   8895
      _Version        =   65536
      _ExtentX        =   15690
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
      Begin BACControles.TXTNumero FltConve 
         Height          =   285
         Left            =   6600
         TabIndex        =   49
         Top             =   360
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   503
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,00"
         Text            =   "0,00"
         Max             =   "999999999999.9999"
         CantidadDecimales=   "2"
      End
      Begin BACControles.TXTNumero FltDurMod 
         Height          =   285
         Left            =   3360
         TabIndex        =   47
         Top             =   360
         Width           =   2055
         _ExtentX        =   3625
         _ExtentY        =   503
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,00"
         Text            =   "0,00"
         Max             =   "999999999999.9999"
         CantidadDecimales=   "2"
      End
      Begin BACControles.TXTNumero FltDurat 
         Height          =   285
         Left            =   360
         TabIndex        =   46
         Top             =   360
         Width           =   2055
         _ExtentX        =   3625
         _ExtentY        =   503
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,00"
         Text            =   "0,00"
         Max             =   "999999999999.9999"
         CantidadDecimales=   "2"
      End
      Begin VB.Label Label16 
         AutoSize        =   -1  'True
         Caption         =   "Duration (Macaulay)"
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
         Left            =   380
         TabIndex        =   41
         Top             =   120
         Width           =   1725
      End
      Begin VB.Label Label17 
         AutoSize        =   -1  'True
         Caption         =   "Duration Modificada"
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
         Left            =   3360
         TabIndex        =   40
         Top             =   120
         Width           =   1725
      End
      Begin VB.Label Label18 
         AutoSize        =   -1  'True
         Caption         =   "Convexidad"
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
         Left            =   7320
         TabIndex        =   39
         Top             =   120
         Width           =   1005
      End
   End
   Begin Threed.SSCommand SSCLimpiar 
      Height          =   330
      Left            =   2445
      TabIndex        =   44
      Top             =   5640
      Width           =   960
      _Version        =   65536
      _ExtentX        =   1693
      _ExtentY        =   582
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
   Begin Threed.SSCommand SSCBuscar 
      Default         =   -1  'True
      Height          =   330
      Left            =   1245
      TabIndex        =   43
      Top             =   5640
      Width           =   960
      _Version        =   65536
      _ExtentX        =   1693
      _ExtentY        =   582
      _StockProps     =   78
      Caption         =   "&Buscar"
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
   Begin Threed.SSCommand SSCSalir 
      Height          =   330
      Left            =   3645
      TabIndex        =   42
      Top             =   5640
      Width           =   960
      _Version        =   65536
      _ExtentX        =   1693
      _ExtentY        =   582
      _StockProps     =   78
      Caption         =   "&Salir"
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
   End
End
Attribute VB_Name = "BacValIRF"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

'Enteros
Dim nCodigo  As Integer
Dim nRutemi  As Integer
Dim nMonemi  As Integer
Dim nBasemi  As Integer
Dim nCupones As Integer
Dim nCortes  As Double
Dim nPervcup As Integer
Dim nPlazo   As Integer
Dim nTipfec  As Integer
Dim nModCal  As Integer

'Reales
Dim nTera    As Double
Dim nTasemi  As Double
Dim nValmon  As Double
Dim nValte   As Double

'String's Definidos
Dim cRefnomi As String * 1
Dim cMdse    As String * 1
Dim cMdpr    As String * 1
Dim cMdtd    As String * 1
Dim cIndte   As String * 1
Dim cNemo    As String * 5
Dim cProg    As String * 8
Dim cMascara As String * 10
Dim cGenemi  As String * 10

'Fechas
Dim dFecemi  As Date
Dim dFecven  As Date


Function Buscar_serie()

Dim Datos()

'    Sql = "SP_CHKINSTSER '" & Mid$(txtSerie.Text, 1, 10) & "'"

    Envia = Array(Mid$(TxtSerie.text, 1, 10))

    If Not Bac_Sql_Execute("SP_CHKINSTSER", Envia) Then
        MsgBox "Serie No Pudo Ser Validada", vbExclamation, "Series"
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then
        If Val(Datos(1)) = 0 Then
            cNemo = Datos(13)
            nValmon = 0
            cGenemi = Datos(12)
            nBasemi = Val(Datos(8))
            nCodigo = Val(Datos(3))
            nMonemi = Val(Datos(6))
            nTasemi = Val(Datos(7))
            cRefnomi = Datos(11)
            cMdse = Datos(15)
            nCortes = Val(Datos(14))
            cIndte = "S"
            nValte = 0
            cMascara = Datos(2)
            dFecemi = Format(Datos(9), "dd/mm/yyyy")
            dFecven = Format(Datos(10), "dd/mm/yyyy")

            TxtMonEmi.text = cNemo
            FltValMon.text = nValmon
            TxtGenEmi.text = cGenemi
            IntBasMon.text = nBasemi
            DateCupon.Visible = False
           ' DateCupon.Text = ""
            DateVcto.Visible = True
            DateVcto.text = Format(Datos(10), "dd/mm/yyyy")

            If cIndte = "S" Then
                FltTasEst.text = nValte
            Else
                FltTasEst.text = 0
            End If

            ' Habilitar y Deshabilitar según corresponda

            FltTasEst.Enabled = True
            FltValNom.Enabled = True
            FltTir.Enabled = True
            FltPvp.Enabled = True
            IntVPresen.Enabled = True
            FltValPar.Enabled = True
            FltVpreUm.Enabled = True
            TxtSerie.Enabled = False

            'DatFecCal.Enabled = False

            'SSCLimpiar.Enabled = True
            Toolbar1.Buttons(3).Enabled = True
            SSCGoVal.Enabled = True

            SSO_TirMt.Enabled = True
            SSO_PvpMt.Enabled = True
            SSO_PvpTir.Enabled = True
            SSO_PvpMt.Value = True

            nModCal = 2
            FltValNom.Enabled = True
            FltTir.Enabled = True
            FltPvp.Enabled = False
            IntVPresen.Enabled = False

            If cIndte = "S" Then
                FltTasEst.Enabled = True
                FltTasEst.SetFocus
            Else
                FltTasEst.Enabled = False
                FltValNom.SetFocus
            End If

            If nBasemi = 0 Then
                IntBasMon.Enabled = True
                IntBasMon.SetFocus
            End If

            SSCGoVal.Default = True

        Else
            MsgBox "Serie no ha sido encontrada", vbExclamation, "Series"
            Exit Function
        End If

    End If

    If nCodigo = 7 Or nCodigo = 6 Or nCodigo = 9 Or nCodigo = 11 Or nCodigo = 12 Then

'        Sql = "SP_BUSCA_MONEDA_EMI " & nMonemi
        Envia = Array(CDbl(nMonemi))
        
        If Not Bac_Sql_Execute("SP_BUSCA_MONEDA_EMI", Envia) Then
           Exit Function
        End If

        If Bac_SQL_Fetch(Datos()) Then
            nBasemi = Val(Datos(1))
        End If

        IntBasMon.text = nBasemi

    End If

    ' Datos Adicionales

'    Sql = "SP_DATOS_ADICIONALES "
'    Sql = Sql & nMonemi
'    Sql = Sql & ",'" & Format(DatFecCal.Text, "YYYYMMDD") & "'"

    Envia = Array(CDbl(nMonemi), Format(DatFecCal.text, "YYYYMMDD"))

    If Not Bac_Sql_Execute("SP_DATOS_ADICIONALES", Envia) Then
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then
        FltValMon.text = Val(Datos(1))
    End If

'    Sql = "SP_BUSCA_CODI"

    If Not Bac_Sql_Execute("SP_BUSCA_CODI") Then
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then

        If Datos(1) <> 0 Then

'            Sql = "SP_BUSCA_VALOR "
'            Sql = Sql + Datos(1)
'            Sql = Sql + ",'" & Format$(DatFecCal.Text, "YYYYMMDD") & "'"

            Envia = Array(Datos(1), Format(DatFecCal.text, "YYYYMMDD"))

            If Not Bac_Sql_Execute("SP_BUSCA_VALOR", Envia) Then
                Exit Function
            End If

            If Bac_SQL_Fetch(Datos()) Then
                FltTasEst.text = Val(Datos(1))
            End If

        End If

    End If

    If Val(FltTasEst.text) > 0 Then
        FltTasEst.Enabled = True
        FltTasEst.SetFocus
    Else
        FltTasEst.Enabled = False
        FltValNom.SetFocus
    End If

End Function

Private Sub DatFecCal_LostFocus()
     Call Buscar_serie
End Sub


Private Sub Form_Activate()
    If TxtSerie.Enabled Then
        TxtSerie.SetFocus
    End If
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
    If KeyAscii% = Asc(".") Then
        KeyAscii = Asc(".")
    End If
End Sub


Private Sub Form_Load()
    
    Me.Top = 0
    Me.Left = 0
    
    DatFecCal.text = Format$(gsBac_Fecp, "dd/mm/yyyy")
    DatFecCal.text = gsBac_Fecp
    DateCupon.Visible = False
  '  DateCupon.Text = ""
    DateVcto.Visible = False
  '  DateVcto.Text = ""
    Screen.MousePointer = 0
End Sub



Private Sub IntBasMon_LostFocus()
    nBasemi = IntBasMon.text
End Sub

Private Sub SSCGoVal_Click()
Dim Datos()

    SQL = "SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=" & nMonemi & " AND vmfecha='" & Format(DatFecCal.text, "yyyymmdd") & "'"
    
    If Not Bac_Sql_Execute(SQL) Then
        Exit Sub
    End If

    If Bac_SQL_Fetch(Datos()) Then
        'FltValMon.Text = Format(Datos(1), "##,##0.0000")
        FltValMon.text = BacCtrlTransMonto(Datos(1))
    End If

    Screen.MousePointer = 11
    
    If cMdse = "N" Then
        dFecemi = DatFecCal.text
    End If

    Envia = Array(nModCal, _
            Format(DatFecCal.text, "yyyymmdd"), _
            nCodigo, _
            cMascara, _
            nMonemi, _
            Format(dFecemi, "yyyymmdd"), _
            Format(dFecven, "yyyymmdd"), _
            CDbl(nTasemi), _
            CDbl(nBasemi), _
            CDbl(FltTasEst.text), _
            CDbl(FltValNom.text), _
            CDbl(FltTir.text), _
            CDbl(FltPvp.text), _
            CDbl(IntVPresen.text))

    If Not Bac_Sql_Execute("SP_VALORIZAR_CLIENT", Envia) Then
        Screen.MousePointer = 0
        MsgBox "No se pudo accesar Rutina de Valorización", vbCritical, "Valorizador"
        Exit Sub
    End If

    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) <> "NO" Then
            FltValNom.text = BacCtrlTransMonto(Datos(2))
            FltTir.text = BacCtrlTransMonto(Datos(3))
            FltPvp.text = BacCtrlTransMonto(Datos(4))
            
            If Trim(TxtMonEmi.text) = "USD" Then
               IntVPresen.CantidadDecimales = 2
            Else
               IntVPresen.CantidadDecimales = 0
            End If
            IntVPresen.text = BacCtrlTransMonto(Datos(5))
            
            FltVpreUm.text = BacCtrlTransMonto(Datos(6))
            FltValPar.text = BacCtrlTransMonto(Datos(9))
            DateCupon.Visible = True
            DateCupon.text = Format(Datos(16), "dd/mm/yyyy")
            FltDurat.text = Format(Datos(20), "##,##0.0000")
            FltConve.text = Format(Datos(21), "##,##0.0000")
            FltDurMod.text = Format(Datos(22), "##,##0.0000")
        Else
            Screen.MousePointer = 0
            MsgBox Datos(2), vbExclamation, "Valorizador"
            Exit Sub
        End If
    End If

    Screen.MousePointer = 0

End Sub
Private Sub SSO_PvpMt_Click(Value As Integer)
  nModCal = 2
  FltValNom.Enabled = True
  FltTir.Enabled = True
  FltPvp.Enabled = False
  IntVPresen.Enabled = False
  FltValNom.SetFocus
End Sub

Private Sub SSO_PvpTir_Click(Value As Integer)
  nModCal = 3
  FltValNom.Enabled = True
  FltTir.Enabled = False
  FltPvp.Enabled = False
  IntVPresen.Enabled = True
  FltValNom.SetFocus
End Sub


Private Sub SSO_TirMt_Click(Value As Integer)
  nModCal = 1
  FltValNom.Enabled = True
  FltTir.Enabled = False
  FltPvp.Enabled = True
  IntVPresen.Enabled = False
  FltValNom.SetFocus
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Description)
    Case "BUSCAR"
        Call TOOLBUSCAR
    Case "LIMPIAR"
        Call TOOLLIMPIAR
    Case "SALIR"
        Unload Me
End Select
End Sub
Function TOOLLIMPIAR()
  TxtSerie.text = ""
  DatFecCal.text = Format$(gsBac_Fecp, "dd/mm/yyyy")
  TxtMonEmi.text = ""
  FltValMon.text = 0
  TxtGenEmi.text = ""
  IntBasMon.text = 0
  FltTasEst.text = 0
  FltValNom.text = 0
  FltTir.text = 0
  FltPvp.text = 0
  IntVPresen.text = 0
  FltValPar.text = 0
  FltVpreUm.text = 0
 ' DateCupon.Text = ""
  DateCupon.Visible = False
  DateVcto.Visible = False
  'DateVcto.Text = ""
  FltDurat.text = 0
  FltDurMod.text = 0
  FltConve.text = 0
  
  FltTasEst.Enabled = False
  FltValNom.Enabled = False
  FltTir.Enabled = False
  FltPvp.Enabled = False
  IntVPresen.Enabled = False
  FltValPar.Enabled = False
  FltVpreUm.Enabled = False
    
  TxtSerie.Enabled = True
  DatFecCal.Enabled = True
      
  'SSCBuscar.Enabled = False
  Toolbar1.Buttons(2).Enabled = False
  'SSCLimpiar.Enabled = False
  Toolbar1.Buttons(3).Enabled = False
  SSCGoVal.Enabled = False
  
  SSO_TirMt.Enabled = False
  SSO_PvpMt.Enabled = False
  SSO_PvpTir.Enabled = False
  IntBasMon.Enabled = False
  'DESACTIVADO EL DEFAULT DEBIDO A QUE E TOLLBAR NO TIENE LA PROPIEDAD
  'SSCBuscar.Default = True
  
  TxtSerie.SetFocus
  
End Function
Function TOOLBUSCAR()
Dim Datos()

'    Sql = "SP_CHKINSTSER '" & Mid$(txtSerie.Text, 1, 10) & "'"

    Envia = Array(Mid$(TxtSerie.text, 1, 10))

    If Not Bac_Sql_Execute("SP_CHKINSTSER", Envia) Then
        MsgBox "Serie No Pudo Ser Validada", vbExclamation, "Series"
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then
        If Val(Datos(1)) = 0 Then
            cNemo = Datos(13)
            nValmon = 0
            cGenemi = Datos(12)
            nBasemi = Val(Datos(8))
            nCodigo = Val(Datos(3))
            nMonemi = Val(Datos(6))
            nTasemi = Val(Datos(7))
            cRefnomi = Datos(11)
            cMdse = Datos(15)
            nCortes = Val(Datos(14))
            cIndte = "S"
            nValte = 0
            cMascara = Datos(2)
            dFecemi = Format(IIf(Datos(15) = "N", DatFecCal.text, Datos(9)), "dd/mm/yyyy")
            dFecven = Format(Datos(10), "dd/mm/yyyy")

            TxtMonEmi.text = cNemo
            FltValMon.text = nValmon
            TxtGenEmi.text = cGenemi
            IntBasMon.text = nBasemi
            DateCupon.Visible = False
           ' DateCupon.Text = ""
            DateVcto.Visible = True
            DateVcto.text = Format(Datos(10), "dd/mm/yyyy")

            If cIndte = "S" Then
                FltTasEst.text = nValte
            Else
                FltTasEst.text = 0
            End If

            ' Habilitar y Deshabilitar según corresponda

            FltTasEst.Enabled = True
            FltValNom.Enabled = True
            FltTir.Enabled = True
            FltPvp.Enabled = True
            IntVPresen.Enabled = True
            FltValPar.Enabled = True
            FltVpreUm.Enabled = True
            TxtSerie.Enabled = False

            'DatFecCal.Enabled = False

            'SSCLimpiar.Enabled = True
            Toolbar1.Buttons(3).Enabled = True
            SSCGoVal.Enabled = True

            SSO_TirMt.Enabled = True
            SSO_PvpMt.Enabled = True
            SSO_PvpTir.Enabled = True
            SSO_PvpMt.Value = True

            nModCal = 2
            FltValNom.Enabled = True
            FltTir.Enabled = True
            FltPvp.Enabled = False
            IntVPresen.Enabled = False

            If cIndte = "S" Then
                FltTasEst.Enabled = True
                FltTasEst.SetFocus
            Else
                FltTasEst.Enabled = False
                FltValNom.SetFocus
            End If

            If nBasemi = 0 Then
                IntBasMon.Enabled = True
                IntBasMon.SetFocus
            End If

            SSCGoVal.Default = True

        Else
            MsgBox "Serie no ha sido encontrada", vbExclamation, "Series"
            Exit Function
        End If

    End If

    If nCodigo = 7 Or nCodigo = 6 Or nCodigo = 9 Or nCodigo = 11 Or nCodigo = 12 Then

'        Sql = "SP_BUSCA_MONEDA_EMI " & nMonemi
        Envia = Array(CDbl(nMonemi))
        
        If Not Bac_Sql_Execute("SP_BUSCA_MONEDA_EMI", Envia) Then
           Exit Function
        End If

        If Bac_SQL_Fetch(Datos()) Then
            nBasemi = Val(Datos(1))
        End If

        IntBasMon.text = nBasemi

    End If

    ' Datos Adicionales

'    Sql = "SP_DATOS_ADICIONALES "
'    Sql = Sql & nMonemi
'    Sql = Sql & ",'" & Format(DatFecCal.Text, "YYYYMMDD") & "'"

    Envia = Array(CDbl(nMonemi), Format(DatFecCal.text, "YYYYMMDD"))

    If Not Bac_Sql_Execute("SP_DATOS_ADICIONALES", Envia) Then
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then
        FltValMon.text = Val(Datos(1))
    End If

'    Sql = "SP_BUSCA_CODI"

    If Not Bac_Sql_Execute("SP_BUSCA_CODI") Then
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then

        If Datos(1) <> 0 Then

'            Sql = "SP_BUSCA_VALOR "
'            Sql = Sql + Datos(1)
'            Sql = Sql + ",'" & Format$(DatFecCal.Text, "YYYYMMDD") & "'"

            Envia = Array(Datos(1), Format(DatFecCal.text, "YYYYMMDD"))

            If Not Bac_Sql_Execute("SP_BUSCA_VALOR", Envia) Then
                Exit Function
            End If

            If Bac_SQL_Fetch(Datos()) Then
                FltTasEst.text = Val(Datos(1))
            End If

        End If

    End If

    If Val(FltTasEst.text) > 0 Then
        FltTasEst.Enabled = True
        FltTasEst.SetFocus
    Else
        FltTasEst.Enabled = False
        FltValNom.SetFocus
    End If

End Function

Private Sub TxtSerie_Change()
   ' SSCBuscar.Enabled = True
    Toolbar1.Buttons(2).Enabled = True
End Sub


Private Sub TxtSerie_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
   
End Sub

