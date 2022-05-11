VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "mscomctl.ocx"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form FRM_VALORIZAR 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Valorizador de Bonos "
   ClientHeight    =   2955
   ClientLeft      =   2100
   ClientTop       =   3660
   ClientWidth     =   10365
   ForeColor       =   &H00C0C0C0&
   Icon            =   "FRM_VALORIZADOR.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   NegotiateMenus  =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2955
   ScaleWidth      =   10365
   Begin MSComctlLib.Toolbar Tlb_Valorizacion 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   17
      Top             =   0
      Width           =   10365
      _ExtentX        =   18283
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
            Object.Visible         =   0   'False
            Style           =   3
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Description     =   "LIMPIAR"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Buscar"
            Description     =   "BUSCAR"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Valorizar"
            Object.ToolTipText     =   "Valorizar"
            ImageIndex      =   24
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "SALIR"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   8040
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
               Picture         =   "FRM_VALORIZADOR.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":4C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":5064
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":551E
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":59F1
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":5E35
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":639C
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":686B
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":6C8A
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":7182
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":757B
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":79FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":7EC4
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":83BB
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":8871
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":8C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":902C
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":9423
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":982C
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_VALORIZADOR.frx":9CEA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   960
      Left            =   -90
      TabIndex        =   16
      Top             =   510
      Width           =   7515
      _Version        =   65536
      _ExtentX        =   13256
      _ExtentY        =   1693
      _StockProps     =   14
      Caption         =   " Datos de Entrada "
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
      Begin BACControles.TXTNumero IntBasMon 
         Height          =   315
         Left            =   6420
         TabIndex        =   5
         Top             =   525
         Width           =   705
         _ExtentX        =   1244
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
         Text            =   "0"
         Text            =   "0"
      End
      Begin BACControles.TXTNumero FltValMon 
         Height          =   315
         Left            =   3690
         TabIndex        =   3
         Top             =   525
         Width           =   1815
         _ExtentX        =   3201
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         Max             =   "999999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTFecha DatFecCal 
         Height          =   315
         Left            =   1515
         TabIndex        =   1
         Top             =   525
         Width           =   1215
         _ExtentX        =   2143
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
         Text            =   "13/11/2000"
      End
      Begin VB.TextBox TxtSerie 
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
         MaxLength       =   12
         TabIndex        =   0
         Top             =   525
         Width           =   1335
      End
      Begin VB.TextBox TxtGenEmi 
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
         Left            =   5535
         MaxLength       =   5
         TabIndex        =   4
         Top             =   525
         Width           =   855
      End
      Begin VB.TextBox TxtMonEmi 
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
         Left            =   2865
         MaxLength       =   5
         TabIndex        =   2
         Top             =   525
         Width           =   735
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Serie"
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
         Left            =   150
         TabIndex        =   23
         Top             =   300
         Width           =   435
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Fec. de Cálculo"
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
         Left            =   1545
         TabIndex        =   22
         Top             =   300
         Width           =   1230
      End
      Begin VB.Label Label11 
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
         Left            =   6435
         TabIndex        =   21
         Top             =   300
         Width           =   405
      End
      Begin VB.Label Label10 
         AutoSize        =   -1  'True
         Caption         =   "Valor"
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
         Left            =   3705
         TabIndex        =   20
         Top             =   300
         Width           =   435
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         Caption         =   "Emisor"
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
         Left            =   5535
         TabIndex        =   19
         Top             =   300
         Width           =   585
      End
      Begin VB.Label Label8 
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
         Left            =   2865
         TabIndex        =   18
         Top             =   300
         Width           =   660
      End
   End
   Begin Threed.SSFrame SSFrame3 
      Height          =   1515
      Left            =   0
      TabIndex        =   24
      Top             =   1425
      Width           =   7455
      _Version        =   65536
      _ExtentX        =   13150
      _ExtentY        =   2672
      _StockProps     =   14
      Caption         =   " Datos y Cálculo "
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
      Begin BACControles.TXTNumero FltVpreUm 
         Height          =   315
         Left            =   4515
         TabIndex        =   12
         Top             =   1140
         Width           =   2055
         _ExtentX        =   3625
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
         Max             =   "999999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero FltValPar 
         Height          =   315
         Left            =   120
         TabIndex        =   11
         Top             =   1095
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
         Max             =   "999999999999.9999999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero IntVPresen 
         Height          =   315
         Left            =   5610
         TabIndex        =   10
         Top             =   495
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
         Max             =   "999999999999.9999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero FltPvp 
         Height          =   315
         Left            =   4410
         TabIndex        =   9
         Top             =   495
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
         Min             =   "-999.9999"
         Max             =   "999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero FltTir 
         Height          =   315
         Left            =   3570
         TabIndex        =   8
         Top             =   495
         Width           =   735
         _ExtentX        =   1296
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
         Min             =   "-100.0000"
         Max             =   "100.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero FltValNom 
         Height          =   315
         Left            =   1650
         TabIndex        =   7
         Top             =   495
         Width           =   1815
         _ExtentX        =   3201
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
         Max             =   "999999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero FltTasEst 
         Height          =   315
         Left            =   90
         TabIndex        =   6
         Top             =   495
         Width           =   1455
         _ExtentX        =   2566
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
         Min             =   "-100.0000"
         Max             =   "100.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero Txt_Duration 
         Height          =   315
         Left            =   2985
         TabIndex        =   43
         Top             =   1095
         Width           =   735
         _ExtentX        =   1296
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
         Min             =   "-100.0000"
         Max             =   "100.0000"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
      End
      Begin VB.Label Label16 
         AutoSize        =   -1  'True
         Caption         =   "Duration"
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
         Left            =   2985
         TabIndex        =   44
         Top             =   900
         Width           =   690
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Tir"
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
         Left            =   3600
         TabIndex        =   31
         Top             =   270
         Width           =   225
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Nominal"
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
         Left            =   1680
         TabIndex        =   30
         Top             =   270
         Width           =   660
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "% V. Par"
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
         Left            =   4440
         TabIndex        =   29
         Top             =   270
         Width           =   660
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "M.Transado ($)"
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
         Left            =   5640
         TabIndex        =   28
         Top             =   270
         Width           =   1230
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "T.Estimada"
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
         Left            =   120
         TabIndex        =   27
         Top             =   270
         Width           =   900
      End
      Begin VB.Label Label12 
         AutoSize        =   -1  'True
         Caption         =   "Valor Par"
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
         Left            =   120
         TabIndex        =   26
         Top             =   885
         Width           =   750
      End
      Begin VB.Label Label13 
         AutoSize        =   -1  'True
         Caption         =   "Monto Transado UM"
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
         Left            =   4530
         TabIndex        =   25
         Top             =   930
         Width           =   1650
      End
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   1260
      Left            =   7500
      TabIndex        =   32
      Top             =   540
      Width           =   2850
      _Version        =   65536
      _ExtentX        =   5027
      _ExtentY        =   2222
      _StockProps     =   14
      Caption         =   " Modo de Cálculo "
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
      Begin Threed.SSOption SSO_TirMt 
         Height          =   255
         Left            =   195
         TabIndex        =   13
         Top             =   330
         Width           =   2175
         _Version        =   65536
         _ExtentX        =   3836
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "TIR + Monto Transado"
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
      Begin Threed.SSOption SSO_PvpMt 
         Height          =   255
         Left            =   195
         TabIndex        =   14
         Top             =   630
         Width           =   2520
         _Version        =   65536
         _ExtentX        =   4445
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "%Valor Par + Monto Trans."
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
      Begin Threed.SSOption SSO_PvpTir 
         Height          =   255
         Left            =   195
         TabIndex        =   15
         Top             =   945
         Width           =   2295
         _Version        =   65536
         _ExtentX        =   4048
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "%Valor Par + TIR"
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
   End
   Begin Threed.SSFrame SSFrame4 
      Height          =   1140
      Left            =   7515
      TabIndex        =   33
      Top             =   1785
      Width           =   2850
      _Version        =   65536
      _ExtentX        =   5027
      _ExtentY        =   2011
      _StockProps     =   14
      Caption         =   "Datos Serie"
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
      Begin Threed.SSPanel SSPanel12 
         Height          =   330
         Left            =   120
         TabIndex        =   34
         Top             =   555
         Width           =   1215
         _Version        =   65536
         _ExtentX        =   2143
         _ExtentY        =   582
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
         BevelOuter      =   1
         RoundedCorners  =   0   'False
         Autosize        =   3
         Begin BACControles.TXTFecha DateCupon 
            Height          =   300
            Left            =   15
            TabIndex        =   42
            TabStop         =   0   'False
            Top             =   15
            Visible         =   0   'False
            Width           =   1185
            _ExtentX        =   2090
            _ExtentY        =   529
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
            Text            =   "13/11/2000"
         End
      End
      Begin Threed.SSPanel SSPanel13 
         Height          =   345
         Left            =   1440
         TabIndex        =   35
         Top             =   555
         Width           =   1305
         _Version        =   65536
         _ExtentX        =   2302
         _ExtentY        =   609
         _StockProps     =   15
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.26
            Charset         =   0
            Weight          =   700
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
            TabIndex        =   41
            TabStop         =   0   'False
            Top             =   15
            Visible         =   0   'False
            Width           =   1275
            _ExtentX        =   2249
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
            Text            =   "13/11/2000"
         End
      End
      Begin VB.Label Label14 
         AutoSize        =   -1  'True
         Caption         =   "F.Pago Cupón"
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
         Left            =   120
         TabIndex        =   37
         Top             =   315
         Width           =   1125
      End
      Begin VB.Label Label15 
         AutoSize        =   -1  'True
         Caption         =   "F.Vencimiento"
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
         Left            =   1440
         TabIndex        =   36
         Top             =   315
         Width           =   1185
      End
   End
   Begin Threed.SSCommand SSCLimpiar 
      Height          =   330
      Left            =   2445
      TabIndex        =   40
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
      TabIndex        =   39
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
      TabIndex        =   38
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
Attribute VB_Name = "FRM_VALORIZAR"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cOptLocal As String

'Enteros
Dim nCodigo_Instrumento    As Integer
Dim nRut_Emisor            As Double
Dim nMoneda_Emision        As Integer
Dim nBase_Emision          As Integer
Dim nNumero_Cupones        As Integer
Dim nNumero_Cortes         As Double
Dim nPervcup As Integer
Dim nPlazo   As Integer
Dim nTipfec  As Integer
Dim nModo_Calculo          As Integer

'Reales
Dim nTera                  As Double
Dim ntasa_emision          As Double
Dim nValor_Moneda          As Double
Dim nValte   As Double

'String's Definidos
Dim cRefnomi As String * 1
Dim cMdse    As String * 1
Dim cMdpr    As String * 1
Dim cMdtd    As String * 1
Dim cIndte   As String * 1
Dim cNemo    As String * 5
Dim cProg    As String * 8
Dim cMascara As String * 12
Dim cGenemi  As String * 10

'Fechas
Dim dfecha_emision         As Date
Dim dFecha_Vcto            As Date

Function FUNC_BUSCA_SERIE()

Dim vDatos_Retorno()

   If Trim(TxtSerie.Text) = "" Then Exit Function

    GLB_Envia = Array()

    PROC_AGREGA_PARAMETRO GLB_Envia, 0
    PROC_AGREGA_PARAMETRO GLB_Envia, Mid(TxtSerie.Text, 1, 12)


    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_SERIES", GLB_Envia) Then
        MsgBox "Serie No Pudo Ser Validada", vbExclamation
        Exit Function
    End If

    If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
        If Val(vDatos_Retorno(1)) <> 0 Then
            cNemo = vDatos_Retorno(20)
            nValor_Moneda = 0
            cGenemi = vDatos_Retorno(19)
            nBase_Emision = Val(vDatos_Retorno(5))
            nCodigo_Instrumento = Val(vDatos_Retorno(1))
            nMoneda_Emision = Val(vDatos_Retorno(6))
            ntasa_emision = Val(vDatos_Retorno(4))
            nNumero_Cortes = Val(vDatos_Retorno(9))
            cIndte = "S"
            nValte = 0
            cMascara = vDatos_Retorno(2)
            dfecha_emision = Format(vDatos_Retorno(14), "dd/mm/yyyy")
            dFecha_Vcto = Format(vDatos_Retorno(13), "dd/mm/yyyy")

            TxtMonEmi.Text = cNemo
            FltValMon.Text = FUNC_CONTROLA_MONTO(nValor_Moneda)
            TxtGenEmi.Text = cGenemi
            IntBasMon.Text = nBase_Emision
            DateCupon.Visible = False
           ' DateCupon.Text = ""
            DateVcto.Visible = True
            DateVcto.Text = Format(vDatos_Retorno(13), "dd/mm/yyyy")

            If cIndte = "S" Then
                FltTasEst.Text = FUNC_CONTROLA_MONTO(nValte)
            Else
                FltTasEst.Text = 0
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

            Tlb_Valorizacion.Buttons(4).Enabled = True

            SSO_TirMt.Enabled = True
            SSO_PvpMt.Enabled = True
            SSO_PvpTir.Enabled = True
            SSO_PvpMt.Value = True

            nModo_Calculo = 2
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

            If nBase_Emision = 0 Then
                IntBasMon.Enabled = True
                IntBasMon.SetFocus
            End If

        Else
            MsgBox "Serie no ha sido encontrada", vbExclamation
            
            Exit Function
        End If
   Else
   
      MsgBox "Serie no ha sido encontrada", vbExclamation
            
      If TxtSerie.Enabled = True Then
         DoEvents
         TxtSerie.SetFocus
      End If
      
      Exit Function

   End If

End Function

Private Sub DatFecCal_LostFocus()
     
     Call FUNC_BUSCA_SERIE

End Sub

Private Sub Form_Activate()
   
   PROC_CARGA_AYUDA Me
    
    If TxtSerie.Enabled Then
        
        TxtSerie.SetFocus
    
    End If

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

Dim nOpcion As Integer

    If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

        Select Case KeyCode
        
            Case vbKeyLimpiar    'Nuevo
            
                 nOpcion = 2
                 
            Case vbKeyBuscar     'Grabar
            
                nOpcion = 3
                
            Case vbKeyValorizar  'Valorizar
            
                nOpcion = 4
                
            Case vbKeySalir      'Salir
            
                nOpcion = 5
                
        End Select
        
        If nOpcion > 0 Then
        
            If Tlb_Valorizacion.Buttons(nOpcion).Enabled Then
            
                Tlb_Valorizacion_ButtonClick Tlb_Valorizacion.Buttons(nOpcion)
                KeyCode = 0
                
            End If
            
        End If
    
    End If

End Sub


Private Sub Form_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      
      FUNC_ENVIA_TECLA (vbKeyTab)
   
   End If
   
End Sub

Private Sub Form_Load()
    
    Me.top = 0
    Me.left = 0

    Me.Icon = FRM_MDI_PASIVO.Icon
    
    DatFecCal.Text = Format$(GLB_Fecha_Proceso, "dd/mm/yyyy")
    DatFecCal.Text = GLB_Fecha_Proceso
    DateCupon.Visible = False
    DateVcto.Visible = False
    Screen.MousePointer = 0
    
    cOptLocal = GLB_Opcion_Menu

    Call PROC_LOG_AUDITORIA("07", cOptLocal, Me.Caption, "", "")
    
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call PROC_LOG_AUDITORIA("08", cOptLocal, Me.Caption, "", "")
   
End Sub

Private Sub IntBasMon_LostFocus()
    nBase_Emision = IntBasMon.Text
End Sub

Sub PROC_VALORIZAR()

Dim vDatos_Retorno()
Dim cCadena_Ejecutable As String


   If CDbl(FltValNom.Text) = 0 Then Exit Sub

      
   DoEvents
   
   cCadena_Ejecutable = "SP_CON_VALOR_MONEDA " & nMoneda_Emision & ",'" & Format(DatFecCal.Text, "yyyymmdd") & "'"

    If Not FUNC_EXECUTA_COMANDO_SQL(cCadena_Ejecutable) Then
        
        Exit Sub
    
    End If

    If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
      
        FltValMon.Text = FUNC_CONTROLA_MONTO(vDatos_Retorno(1))
        
    End If

    Screen.MousePointer = 11

  
      GLB_Envia = Array()
    
      PROC_AGREGA_PARAMETRO GLB_Envia, nModo_Calculo
      PROC_AGREGA_PARAMETRO GLB_Envia, Format(DatFecCal.Text, "dd/mm/yyyy")
      PROC_AGREGA_PARAMETRO GLB_Envia, nCodigo_Instrumento
      PROC_AGREGA_PARAMETRO GLB_Envia, cMascara
      PROC_AGREGA_PARAMETRO GLB_Envia, nMoneda_Emision
      PROC_AGREGA_PARAMETRO GLB_Envia, Format(dfecha_emision, "dd/mm/yyyy")
      PROC_AGREGA_PARAMETRO GLB_Envia, Format(dFecha_Vcto, "dd/mm/yyyy")
      PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(ntasa_emision)
      PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(nBase_Emision)
      PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(FltTasEst.Text)
      PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(FltValNom.Text)
      PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(FltTir.Text)
      PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(FltPvp.Text)
      PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(IntVPresen.Text)


    If Not FUNC_EXECUTA_COMANDO_SQL("SP_PRO_VALORIZA_USUARIO", GLB_Envia) Then
        
        Screen.MousePointer = 0
        Exit Sub
    
    End If

    If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
        
        If vDatos_Retorno(1) <> "NO" Then
            
            FltValNom.Text = FUNC_CONTROLA_MONTO(vDatos_Retorno(2))
            FltTir.Text = FUNC_CONTROLA_MONTO(vDatos_Retorno(3))
            FltPvp.Text = FUNC_CONTROLA_MONTO(vDatos_Retorno(4))
            IntVPresen.Text = FUNC_CONTROLA_MONTO(vDatos_Retorno(5))
            FltVpreUm.Text = FUNC_CONTROLA_MONTO(vDatos_Retorno(6))
            FltValPar.Text = FUNC_CONTROLA_MONTO(vDatos_Retorno(9))
            DateCupon.Visible = True
            DateCupon.Text = Format(vDatos_Retorno(16), "dd/mm/yyyy")
            Txt_Duration.Text = Round(FUNC_CONTROLA_MONTO(vDatos_Retorno(20)), 2)
        Else
            
            Screen.MousePointer = 0
            MsgBox vDatos_Retorno(2), vbExclamation
            Exit Sub
        
        End If
    
    End If

    Screen.MousePointer = 0

End Sub

Private Sub SSO_PvpMt_Click(Value As Integer)
  
  nModo_Calculo = 2
  FltValNom.Enabled = True
  FltTir.Enabled = True
  FltPvp.Enabled = False
  IntVPresen.Enabled = False
  FltValNom.SetFocus

End Sub

Private Sub SSO_PvpTir_Click(Value As Integer)
  
  nModo_Calculo = 3
  FltValNom.Enabled = True
  FltTir.Enabled = False
  FltPvp.Enabled = False
  IntVPresen.Enabled = True
  FltValNom.SetFocus

End Sub

Private Sub SSO_TirMt_Click(Value As Integer)
  
  nModo_Calculo = 1
  FltValNom.Enabled = True
  FltTir.Enabled = False
  FltPvp.Enabled = True
  IntVPresen.Enabled = False
  FltValNom.SetFocus

End Sub

Private Sub Tlb_Valorizacion_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Trim(UCase(Button.Key))

    Case "BUSCAR"
    
        Call FUNC_BUSCAR
        
    Case "LIMPIAR"
    
        Call FUNC_LIMPIAR
        
    Case "VALORIZAR"
    
        PROC_VALORIZAR
        
    Case "SALIR"
    
        Unload Me
        
End Select

End Sub
Function FUNC_LIMPIAR()

  TxtSerie.Text = ""
  DatFecCal.Text = Format$(gsBac_Fecp, "dd/mm/yyyy")
  TxtMonEmi.Text = ""
  FltValMon.Text = 0
  TxtGenEmi.Text = ""
  IntBasMon.Text = 0
  FltTasEst.Text = 0
  FltValNom.Text = 0
  FltTir.Text = 0
  FltPvp.Text = 0
  IntVPresen.Text = 0
  FltValPar.Text = 0
  FltVpreUm.Text = 0
  Txt_Duration.Text = 0
  DateCupon.Visible = False
  DateVcto.Visible = False
  Txt_Duration.Enabled = False
  
  FltTasEst.Enabled = False
  FltValNom.Enabled = False
  FltTir.Enabled = False
  FltPvp.Enabled = False
  IntVPresen.Enabled = False
  FltValPar.Enabled = False
  FltVpreUm.Enabled = False
    
  TxtSerie.Enabled = True
  DatFecCal.Enabled = True
      
  Tlb_Valorizacion.Buttons(3).Enabled = False
  Tlb_Valorizacion.Buttons(4).Enabled = False
  
  SSO_TirMt.Enabled = False
  SSO_PvpMt.Enabled = False
  SSO_PvpTir.Enabled = False
  IntBasMon.Enabled = False
  
  TxtSerie.SetFocus
  
End Function
Function FUNC_BUSCAR()
Dim vDatos_Retorno()


    GLB_Envia = Array()

    PROC_AGREGA_PARAMETRO GLB_Envia, 0
    PROC_AGREGA_PARAMETRO GLB_Envia, Mid$(TxtSerie.Text, 1, 10)


    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_SERIES", GLB_Envia) Then
        MsgBox "Serie No Pudo Ser Validada", vbExclamation
        Exit Function
    End If

    If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
        If Val(vDatos_Retorno(1)) <> 0 Then
            cNemo = vDatos_Retorno(20)
            nValor_Moneda = 0
            cGenemi = vDatos_Retorno(19)
            nBase_Emision = Val(vDatos_Retorno(5))
            nCodigo_Instrumento = Val(vDatos_Retorno(1))
            nMoneda_Emision = Val(vDatos_Retorno(6))
            ntasa_emision = Val(vDatos_Retorno(4))
            nNumero_Cortes = Val(vDatos_Retorno(9))
            cIndte = "S"
            nValte = 0
            cMascara = vDatos_Retorno(2)
            dfecha_emision = Format(vDatos_Retorno(14), "dd/mm/yyyy")
            dFecha_Vcto = Format(vDatos_Retorno(13), "dd/mm/yyyy")

            TxtMonEmi.Text = cNemo
            FltValMon.Text = FUNC_CONTROLA_MONTO(nValor_Moneda)
            TxtGenEmi.Text = cGenemi
            IntBasMon.Text = nBase_Emision
            DateCupon.Visible = False
           ' DateCupon.Text = ""
            DateVcto.Visible = True
            DateVcto.Text = Format(vDatos_Retorno(13), "dd/mm/yyyy")

            If cIndte = "S" Then
                FltTasEst.Text = FUNC_CONTROLA_MONTO(nValte)
            Else
                FltTasEst.Text = 0
            End If

            ' Habilitar y Deshabilitar según corresponda

            FltTasEst.Enabled = True
            FltValNom.Enabled = True
            FltTir.Enabled = True
            FltPvp.Enabled = True
            IntVPresen.Enabled = True
            FltValPar.Enabled = True
            FltVpreUm.Enabled = True
            Txt_Duration.Enabled = True
            TxtSerie.Enabled = False

            Tlb_Valorizacion.Buttons(4).Enabled = True

            SSO_TirMt.Enabled = True
            SSO_PvpMt.Enabled = True
            SSO_PvpTir.Enabled = True
            SSO_PvpMt.Value = True

            nModo_Calculo = 2
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

            If nBase_Emision = 0 Then
                IntBasMon.Enabled = True
                IntBasMon.SetFocus
            End If

        Else
            MsgBox "Serie no ha sido encontrada", vbExclamation
            
            Exit Function
        End If
   Else
   
      MsgBox "Serie no ha sido encontrada", vbExclamation
      
      If TxtSerie.Enabled = True Then
         DoEvents
         TxtSerie.SetFocus
      End If
      
      Exit Function

   End If


    If CDbl(FltTasEst.Text) > 0 Then
        FltTasEst.Enabled = True
        FltTasEst.SetFocus
    Else
        FltTasEst.Enabled = False
        FltValNom.SetFocus
    End If

    Tlb_Valorizacion.Buttons(3).Enabled = False

End Function

Private Sub TxtSerie_Change()

    Tlb_Valorizacion.Buttons(3).Enabled = (Trim(TxtSerie.Text) <> "")
    
End Sub

Private Sub TxtSerie_DblClick()
Call PROC_CON_SERIES
End Sub


Sub PROC_CON_SERIES()
On Error GoTo Error_series

      
        Pbl_cCodigo_Serie = "BONOS"
        cMiTag = "MDSE"
        FRM_AYUDA.Show 1
        If GLB_Aceptar% = True Then
          
          TxtSerie.Text = GLB_codigo$
          
'         Call PROC_BUSCAR_SERIES
        End If

Exit Sub
Error_series:
      MousePointer = 0
      MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
      Exit Sub
      
End Sub

Private Sub TxtSerie_KeyPress(KeyAscii As Integer)

   KeyAscii = Asc(UCase(Chr(KeyAscii)))
   
End Sub

