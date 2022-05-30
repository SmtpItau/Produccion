VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Anticipo_Operaciones 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Anticipo de Operaciones Swap"
   ClientHeight    =   9810
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   12795
   Icon            =   "Anticipo_Operaciones.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   9810
   ScaleWidth      =   12795
   Begin VB.Frame Frame2 
      Height          =   825
      Left            =   7200
      TabIndex        =   151
      Top             =   570
      Width           =   5505
      Begin VB.CheckBox ChkAnticipoTotal 
         Caption         =   "Anticipo Total"
         Height          =   240
         Left            =   180
         TabIndex        =   1
         Top             =   360
         Value           =   1  'Checked
         Width           =   2970
      End
   End
   Begin VB.Frame FrmLiquidacion 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   825
      Left            =   4590
      TabIndex        =   25
      Top             =   570
      Width           =   2580
      Begin VB.ComboBox CmbModalidadPago 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Left            =   100
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   375
         Width           =   2400
      End
      Begin VB.Label Lbl_Forma_Liquida 
         Alignment       =   2  'Center
         Caption         =   "Modalidad de Pago"
         Height          =   195
         Left            =   100
         TabIndex        =   26
         Top             =   200
         Width           =   2400
      End
   End
   Begin VB.Frame FrmDatos 
      Height          =   825
      Left            =   45
      TabIndex        =   22
      Top             =   570
      Width           =   4545
      Begin VB.Label LblFechaAnticipacion 
         BackColor       =   &H80000018&
         BorderStyle     =   1  'Fixed Single
         Height          =   345
         Left            =   100
         TabIndex        =   29
         Top             =   375
         Width           =   1500
      End
      Begin VB.Label LblNumeroOperacion 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000018&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   345
         Left            =   2955
         TabIndex        =   27
         Top             =   375
         Width           =   1500
      End
      Begin VB.Label LblFechaMadurez 
         BackColor       =   &H80000018&
         BorderStyle     =   1  'Fixed Single
         Height          =   345
         Left            =   1620
         TabIndex        =   23
         Top             =   375
         Width           =   1305
      End
      Begin VB.Label LblTitulo 
         Alignment       =   2  'Center
         Caption         =   "Fecha Anticipacion"
         Height          =   195
         Index           =   0
         Left            =   100
         TabIndex        =   30
         Top             =   200
         Width           =   1500
      End
      Begin VB.Label LblTitulo 
         Alignment       =   2  'Center
         Caption         =   "Número operación"
         Height          =   195
         Index           =   2
         Left            =   2955
         TabIndex        =   28
         Top             =   195
         Width           =   1500
      End
      Begin VB.Label LblTitulo 
         Alignment       =   2  'Center
         Caption         =   "Fecha Madurez"
         Height          =   195
         Index           =   1
         Left            =   1620
         TabIndex        =   24
         Top             =   195
         Width           =   1305
      End
   End
   Begin MSComctlLib.Toolbar Tool_Menu 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   21
      Top             =   0
      Width           =   12795
      _ExtentX        =   22569
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "Img_Imagenes"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "Imprimir"
            Object.ToolTipText     =   "Informe por pantalla"
            ImageIndex      =   1
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList Img_Imagenes 
      Left            =   10080
      Top             =   0
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
            Picture         =   "Anticipo_Operaciones.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Anticipo_Operaciones.frx":11E4
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin TabDlg.SSTab TabOperaciones 
      Height          =   8190
      Left            =   30
      TabIndex        =   31
      Top             =   1485
      Width           =   12660
      _ExtentX        =   22331
      _ExtentY        =   14446
      _Version        =   393216
      Style           =   1
      Tabs            =   2
      TabsPerRow      =   2
      TabHeight       =   520
      TabCaption(0)   =   "Operaciones"
      TabPicture(0)   =   "Anticipo_Operaciones.frx":14FE
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "FrmEntregamos"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "FrmRecibimos"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "Frame1"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).ControlCount=   3
      TabCaption(1)   =   "Flujos Vigentes"
      TabPicture(1)   =   "Anticipo_Operaciones.frx":151A
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "Frm_Recibimos"
      Tab(1).Control(1)=   "Frm_Pagamos"
      Tab(1).ControlCount=   2
      Begin VB.Frame Frame1 
         Caption         =   "Liquidacion"
         Height          =   4875
         Left            =   90
         TabIndex        =   106
         Top             =   3090
         Width           =   12435
         Begin VB.Frame FrmCompensacion 
            Caption         =   "Liquidación x Compensación"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   2115
            Left            =   6225
            TabIndex        =   143
            Top             =   2685
            Width           =   6135
            Begin VB.ComboBox CmbMonedaLiquidacion 
               Enabled         =   0   'False
               BeginProperty Font 
                  Name            =   "Courier New"
                  Size            =   9
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   345
               Left            =   60
               Style           =   2  'Dropdown List
               TabIndex        =   18
               Top             =   450
               Width           =   3705
            End
            Begin VB.ComboBox CmbFormaPagoMonedaLiquidacion 
               BeginProperty Font 
                  Name            =   "Courier New"
                  Size            =   9
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   345
               Left            =   60
               Style           =   2  'Dropdown List
               TabIndex        =   20
               Top             =   1035
               Width           =   3705
            End
            Begin BACControles.TXTNumero TxtMontoLiquidar 
               Height          =   345
               Left            =   3810
               TabIndex        =   19
               Top             =   450
               Width           =   1995
               _ExtentX        =   3519
               _ExtentY        =   609
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
               Text            =   "0.0000"
               Text            =   "0.0000"
               CantidadDecimales=   "4"
               Separator       =   -1  'True
               MarcaTexto      =   -1  'True
            End
            Begin VB.Label Label17 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "Forma de Pago Moneda"
               Height          =   195
               Left            =   60
               TabIndex        =   146
               Top             =   840
               Width           =   3700
            End
            Begin VB.Label Label18 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "Monto Liquidar Moneda"
               Height          =   195
               Left            =   3810
               TabIndex        =   145
               Top             =   255
               Width           =   1680
            End
            Begin VB.Label Label20 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "Moneda Liquidacion"
               Height          =   195
               Left            =   60
               TabIndex        =   144
               Top             =   250
               Width           =   3700
            End
         End
         Begin VB.Frame FrmEntregaFisica 
            Caption         =   "Liquidación x Entrega Física"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   2115
            Left            =   60
            TabIndex        =   132
            Top             =   2685
            Width           =   6135
            Begin VB.ComboBox CmbFormaPagoMonedaConversion 
               BeginProperty Font 
                  Name            =   "Courier New"
                  Size            =   9
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   345
               Left            =   2355
               Style           =   2  'Dropdown List
               TabIndex        =   17
               Top             =   1635
               Width           =   3705
            End
            Begin VB.ComboBox CmbFormaPagoMonedaTransada 
               BeginProperty Font 
                  Name            =   "Courier New"
                  Size            =   9
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   345
               Left            =   2355
               Style           =   2  'Dropdown List
               TabIndex        =   15
               Top             =   1035
               Width           =   3705
            End
            Begin BACControles.TXTNumero TxtMontoMonedaTransada 
               Height          =   345
               Left            =   645
               TabIndex        =   14
               Top             =   1035
               Width           =   1695
               _ExtentX        =   2990
               _ExtentY        =   609
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
               Text            =   "0.0000"
               Text            =   "0.0000"
               CantidadDecimales=   "4"
               Separator       =   -1  'True
               MarcaTexto      =   -1  'True
            End
            Begin BACControles.TXTNumero TxtMontoMonedaConversion 
               Height          =   345
               Left            =   645
               TabIndex        =   16
               Top             =   1635
               Width           =   1695
               _ExtentX        =   2990
               _ExtentY        =   609
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
               Separator       =   -1  'True
               MarcaTexto      =   -1  'True
            End
            Begin VB.Label LblMonedaConversion 
               Alignment       =   2  'Center
               BackColor       =   &H80000018&
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   345
               Left            =   60
               TabIndex        =   142
               Top             =   1635
               Width           =   570
            End
            Begin VB.Label LblTipoOperacion 
               BackColor       =   &H80000018&
               BorderStyle     =   1  'Fixed Single
               Height          =   345
               Left            =   60
               TabIndex        =   141
               Top             =   450
               Width           =   2280
            End
            Begin VB.Label Label12 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "Precio Operación Cambio"
               Height          =   195
               Left            =   2350
               TabIndex        =   140
               Top             =   250
               Width           =   1995
            End
            Begin VB.Label Label11 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "Forma de Pago Moneda Conversión"
               Height          =   195
               Left            =   2355
               TabIndex        =   139
               Top             =   1440
               Width           =   3705
            End
            Begin VB.Label Label10 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "Monto Liquidar"
               Height          =   195
               Left            =   60
               TabIndex        =   138
               Top             =   1440
               Width           =   2280
            End
            Begin VB.Label Label8 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "Forma de Pago Moneda Transada"
               Height          =   345
               Left            =   2355
               TabIndex        =   137
               Top             =   840
               Width           =   3705
            End
            Begin VB.Label Label7 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "Tipo de Operacion"
               Height          =   195
               Left            =   60
               TabIndex        =   136
               Top             =   250
               Width           =   2280
            End
            Begin VB.Label Label6 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "Monto"
               Height          =   195
               Left            =   60
               TabIndex        =   135
               Top             =   840
               Width           =   2280
            End
            Begin VB.Label LblPrecioOperacionCambio 
               BackColor       =   &H80000018&
               BorderStyle     =   1  'Fixed Single
               Height          =   345
               Left            =   2350
               TabIndex        =   134
               Top             =   450
               Width           =   1995
            End
            Begin VB.Label LblMonedaTransada 
               Alignment       =   2  'Center
               BackColor       =   &H80000018&
               BorderStyle     =   1  'Fixed Single
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   345
               Left            =   60
               TabIndex        =   133
               Top             =   1035
               Width           =   570
            End
         End
         Begin VB.Frame FraMargen 
            Height          =   840
            Left            =   60
            TabIndex        =   120
            Top             =   1800
            Width           =   12300
            Begin BACControles.TXTNumero TxtPorcentajeMargen 
               Height          =   345
               Left            =   6200
               TabIndex        =   13
               Top             =   375
               Width           =   1995
               _ExtentX        =   3519
               _ExtentY        =   609
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
               Text            =   "0.0000"
               Text            =   "0.0000"
               CantidadDecimales=   "4"
               Separator       =   -1  'True
            End
            Begin VB.Label LblLiquidacion 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "Margen"
               Height          =   195
               Index           =   7
               Left            =   8220
               TabIndex        =   131
               Top             =   200
               Width           =   1995
            End
            Begin VB.Label LblLiquidacion 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "Principal ( C - F )"
               Height          =   195
               Index           =   3
               Left            =   45
               TabIndex        =   130
               Top             =   200
               Width           =   1995
            End
            Begin VB.Label LblLiquidacion 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "Devengo ( B - E )"
               Height          =   195
               Index           =   4
               Left            =   2070
               TabIndex        =   129
               Top             =   200
               Width           =   1995
            End
            Begin VB.Label LblLiquidacion 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "Valor Mercado ( A - D )"
               Height          =   195
               Index           =   5
               Left            =   4095
               TabIndex        =   128
               Top             =   200
               Width           =   1995
            End
            Begin VB.Label LblMargenUM 
               Alignment       =   1  'Right Justify
               BackColor       =   &H80000018&
               BorderStyle     =   1  'Fixed Single
               Height          =   345
               Left            =   8220
               TabIndex        =   127
               Top             =   375
               Width           =   1995
            End
            Begin VB.Label LblMargenCLP 
               Alignment       =   1  'Right Justify
               BackColor       =   &H80000018&
               BorderStyle     =   1  'Fixed Single
               Height          =   345
               Left            =   10230
               TabIndex        =   126
               Top             =   375
               Width           =   1995
            End
            Begin VB.Label LblLiquidacion 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "Margen CLP"
               Height          =   195
               Index           =   8
               Left            =   10230
               TabIndex        =   125
               Top             =   200
               Width           =   1995
            End
            Begin VB.Label LblLiquidacion 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "% Margen"
               Height          =   195
               Index           =   6
               Left            =   6200
               TabIndex        =   124
               Top             =   200
               Width           =   1995
            End
            Begin VB.Label LblValorMercado 
               Alignment       =   1  'Right Justify
               BackColor       =   &H80000018&
               BorderStyle     =   1  'Fixed Single
               Height          =   345
               Left            =   4095
               TabIndex        =   123
               Top             =   375
               Width           =   1995
            End
            Begin VB.Label LblInteresDevangado 
               Alignment       =   1  'Right Justify
               BackColor       =   &H80000018&
               BorderStyle     =   1  'Fixed Single
               Height          =   345
               Left            =   2070
               TabIndex        =   122
               Top             =   375
               Width           =   1995
            End
            Begin VB.Label LblPrincipal 
               Alignment       =   1  'Right Justify
               BackColor       =   &H80000018&
               BorderStyle     =   1  'Fixed Single
               Height          =   345
               Left            =   45
               TabIndex        =   121
               Top             =   375
               Width           =   1995
            End
         End
         Begin VB.Frame FraEntLiquidacion 
            Caption         =   "Entregamos"
            Height          =   900
            Left            =   6225
            TabIndex        =   114
            Top             =   870
            Width           =   6135
            Begin BACControles.TXTNumero TxtValorMercadoPasivo 
               Height          =   345
               Left            =   45
               TabIndex        =   12
               Top             =   450
               Width           =   1995
               _ExtentX        =   3519
               _ExtentY        =   609
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
               Text            =   "0.0000"
               Text            =   "0.0000"
               CantidadDecimales=   "4"
               Separator       =   -1  'True
            End
            Begin VB.Label Label35 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "(E) Interes Devengo"
               Height          =   345
               Left            =   2040
               TabIndex        =   119
               Top             =   270
               Width           =   1995
            End
            Begin VB.Label Label33 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "(F) D - E"
               Height          =   345
               Left            =   4050
               TabIndex        =   118
               Top             =   270
               Width           =   1995
            End
            Begin VB.Label Label16 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "(D) Valor Mercado Pasivo"
               Height          =   345
               Left            =   45
               TabIndex        =   117
               Top             =   270
               Width           =   1995
            End
            Begin VB.Label LblEntInteresDevengado 
               Alignment       =   1  'Right Justify
               BackColor       =   &H80000018&
               BorderStyle     =   1  'Fixed Single
               Height          =   345
               Left            =   2040
               TabIndex        =   116
               Top             =   450
               Width           =   1995
            End
            Begin VB.Label LblEntResultado 
               Alignment       =   1  'Right Justify
               BackColor       =   &H80000018&
               BorderStyle     =   1  'Fixed Single
               Height          =   345
               Left            =   4050
               TabIndex        =   115
               Top             =   450
               Width           =   1995
            End
         End
         Begin VB.Frame FraRecLiquidacion 
            Caption         =   "Recibimos"
            Height          =   900
            Left            =   60
            TabIndex        =   108
            Top             =   870
            Width           =   6135
            Begin BACControles.TXTNumero TxtValorMercadoActivo 
               Height          =   345
               Left            =   45
               TabIndex        =   11
               Top             =   450
               Width           =   1995
               _ExtentX        =   3519
               _ExtentY        =   609
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
               Text            =   "0.0000"
               Text            =   "0.0000"
               CantidadDecimales=   "4"
               Separator       =   -1  'True
            End
            Begin VB.Label Label27 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "(C) A - B"
               Height          =   345
               Left            =   4050
               TabIndex        =   113
               Top             =   270
               Width           =   1995
            End
            Begin VB.Label Label28 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "(B) Interes Devengo"
               Height          =   345
               Left            =   2040
               TabIndex        =   112
               Top             =   270
               Width           =   1995
            End
            Begin VB.Label LblRecResultado 
               Alignment       =   1  'Right Justify
               BackColor       =   &H80000018&
               BorderStyle     =   1  'Fixed Single
               Height          =   345
               Left            =   4050
               TabIndex        =   111
               Top             =   450
               Width           =   1995
            End
            Begin VB.Label LblRecInteresDevengado 
               Alignment       =   1  'Right Justify
               BackColor       =   &H80000018&
               BorderStyle     =   1  'Fixed Single
               Height          =   345
               Left            =   2040
               TabIndex        =   110
               Top             =   450
               Width           =   1995
            End
            Begin VB.Label Label29 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "(A) Valor Mercado Activo"
               Height          =   345
               Left            =   45
               TabIndex        =   109
               Top             =   270
               Width           =   1995
            End
         End
         Begin VB.Frame I_FERIADOS_F 
            Caption         =   "Feriados"
            Height          =   510
            Left            =   1995
            TabIndex        =   107
            Top             =   270
            Width           =   3105
            Begin VB.CheckBox I_FERIADOCHK 
               Caption         =   "CHILE"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   0
               Left            =   45
               TabIndex        =   7
               Top             =   210
               Width           =   750
            End
            Begin VB.CheckBox I_FERIADOCHK 
               Caption         =   "USA"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   1
               Left            =   810
               TabIndex        =   8
               Top             =   210
               Width           =   750
            End
            Begin VB.CheckBox I_FERIADOCHK 
               Caption         =   "INGLATERRA"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   210
               Index           =   2
               Left            =   1575
               TabIndex        =   9
               Top             =   210
               Width           =   1275
            End
         End
         Begin VB.ComboBox CmbMonedaValorizacion 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   5205
            Style           =   2  'Dropdown List
            TabIndex        =   10
            Top             =   420
            Width           =   2835
         End
         Begin BACControles.TXTFecha TxtFechaValorizacion 
            Height          =   345
            Left            =   150
            TabIndex        =   6
            Top             =   465
            Width           =   1785
            _ExtentX        =   3149
            _ExtentY        =   609
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
            Text            =   "10/09/2007"
         End
         Begin VB.Label LblLiquidacion 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Fecha Valorizacion"
            Height          =   195
            Index           =   0
            Left            =   150
            TabIndex        =   150
            Top             =   240
            Width           =   1350
         End
         Begin VB.Label LblLiquidacion 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Moneda Valorizacion"
            Height          =   195
            Index           =   1
            Left            =   5235
            TabIndex        =   149
            Top             =   225
            Width           =   1485
         End
         Begin VB.Label LblLiquidacion 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Valor Moneda Valorizacion"
            Height          =   345
            Index           =   2
            Left            =   8085
            TabIndex        =   148
            Top             =   210
            Width           =   1995
         End
         Begin VB.Label LblValorMonedaLiquidacion 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            Height          =   345
            Left            =   8085
            TabIndex        =   147
            Top             =   390
            Width           =   1995
         End
      End
      Begin VB.Frame FrmRecibimos 
         Caption         =   "Recibimos"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2670
         Left            =   105
         TabIndex        =   84
         Top             =   375
         Width           =   6195
         Begin BACControles.TXTNumero TxtRecAmortizacion 
            Height          =   345
            Left            =   105
            TabIndex        =   2
            Top             =   2130
            Width           =   1800
            _ExtentX        =   3175
            _ExtentY        =   609
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
            Text            =   "0.0000"
            Text            =   "0.0000"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero TxtRecTasaAnticipo 
            Height          =   345
            Left            =   1995
            TabIndex        =   3
            Top             =   2130
            Width           =   1800
            _ExtentX        =   3175
            _ExtentY        =   609
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
            Text            =   "0.0000"
            Text            =   "0.0000"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label LblTitulosRecibimos 
            Alignment       =   2  'Center
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Tasa Anticipo"
            Height          =   195
            Index           =   10
            Left            =   1995
            TabIndex        =   105
            Top             =   1950
            Width           =   1800
         End
         Begin VB.Label LblTitulosRecibimos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Amortiza"
            Height          =   195
            Index           =   9
            Left            =   105
            TabIndex        =   104
            Top             =   1950
            Width           =   1800
         End
         Begin VB.Label LblTitulosRecibimos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Tipo Tasa"
            Height          =   195
            Index           =   6
            Left            =   100
            TabIndex        =   103
            Top             =   1350
            Width           =   2910
         End
         Begin VB.Label LblTitulosRecibimos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Tasa"
            Height          =   195
            Index           =   7
            Left            =   3045
            TabIndex        =   102
            Top             =   1350
            Width           =   1500
         End
         Begin VB.Label LblTitulosRecibimos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Conteo Días"
            Height          =   195
            Index           =   8
            Left            =   4590
            TabIndex        =   101
            Top             =   1350
            Width           =   1500
         End
         Begin VB.Label LblTitulosRecibimos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Fecha ultimo Vcto."
            Height          =   195
            Index           =   3
            Left            =   120
            TabIndex        =   100
            Top             =   780
            Width           =   2000
         End
         Begin VB.Label LblTitulosRecibimos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Fecha próximo Vcto."
            Height          =   195
            Index           =   4
            Left            =   2130
            TabIndex        =   99
            Top             =   780
            Width           =   1995
         End
         Begin VB.Label LblTitulosRecibimos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Interes Recibe"
            Height          =   195
            Index           =   1
            Left            =   2520
            TabIndex        =   98
            Top             =   200
            Width           =   1800
         End
         Begin VB.Label LblTitulosRecibimos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Interes Devengado"
            Height          =   195
            Index           =   2
            Left            =   4335
            TabIndex        =   97
            Top             =   200
            Width           =   1800
         End
         Begin VB.Label LblTitulosRecibimos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Valor Moneda"
            Height          =   195
            Index           =   5
            Left            =   4140
            TabIndex        =   96
            Top             =   780
            Width           =   1995
         End
         Begin VB.Label LblTitulosRecibimos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Saldo"
            Height          =   255
            Index           =   0
            Left            =   105
            TabIndex        =   95
            Top             =   195
            Width           =   2400
         End
         Begin VB.Label LblRecMoneda 
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   100
            TabIndex        =   94
            Top             =   375
            Width           =   570
         End
         Begin VB.Label LblRecValorMoneda 
            Alignment       =   2  'Center
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   4155
            TabIndex        =   93
            Top             =   960
            Width           =   1995
         End
         Begin VB.Label LblRecSaldo 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   705
            TabIndex        =   92
            Top             =   375
            Width           =   1800
         End
         Begin VB.Label LblRecTasa 
            Alignment       =   2  'Center
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   3045
            TabIndex        =   91
            Top             =   1560
            Width           =   1500
         End
         Begin VB.Label LblRecTipoTasa 
            Alignment       =   2  'Center
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   100
            TabIndex        =   90
            Top             =   1560
            Width           =   2910
         End
         Begin VB.Label LblRecConteoDias 
            Alignment       =   2  'Center
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   4590
            TabIndex        =   89
            Top             =   1560
            Width           =   1500
         End
         Begin VB.Label LblRecFechaUltimoVencimiento 
            Alignment       =   2  'Center
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   100
            TabIndex        =   88
            Top             =   960
            Width           =   2000
         End
         Begin VB.Label LblRecFechaProximoVencimiento 
            Alignment       =   2  'Center
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   2130
            TabIndex        =   87
            Top             =   960
            Width           =   1995
         End
         Begin VB.Label LblRecInteres 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   2520
            TabIndex        =   86
            Top             =   375
            Width           =   1800
         End
         Begin VB.Label LblRecInteresAcumulado 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   4335
            TabIndex        =   85
            Top             =   375
            Width           =   1800
         End
      End
      Begin VB.Frame Frm_Pagamos 
         Caption         =   "PAGAMOS"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   4650
         Left            =   -68955
         TabIndex        =   69
         Top             =   330
         Width           =   5565
         Begin VB.Label Lbl_Numero_Flujo_Pagamos 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "1"
            Height          =   345
            Left            =   2340
            TabIndex        =   83
            Top             =   810
            Width           =   1500
         End
         Begin VB.Label Label42 
            AutoSize        =   -1  'True
            Caption         =   "Número Flujo"
            Height          =   195
            Left            =   1230
            TabIndex        =   82
            Top             =   885
            Width           =   930
         End
         Begin VB.Label Lbl_Fecha_Fijacion_Tasa_Pagamos 
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            Height          =   345
            Left            =   2340
            TabIndex        =   81
            Top             =   1275
            Width           =   1500
         End
         Begin VB.Label Label44 
            AutoSize        =   -1  'True
            Caption         =   "Fecha Fijación Tasa"
            Height          =   195
            Left            =   720
            TabIndex        =   80
            Top             =   1305
            Width           =   1440
         End
         Begin VB.Label Lbl_Fecha_Vencimiento_Pagamos 
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            Height          =   345
            Left            =   2340
            TabIndex        =   79
            Top             =   1710
            Width           =   1500
         End
         Begin VB.Label Label46 
            AutoSize        =   -1  'True
            Caption         =   "Fecha Vencimiento"
            Height          =   195
            Left            =   825
            TabIndex        =   78
            Top             =   1770
            Width           =   1365
         End
         Begin VB.Label Lbl_Fecha_Liquidacion_Pagamos 
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            Height          =   345
            Left            =   2340
            TabIndex        =   77
            Top             =   2130
            Width           =   1500
         End
         Begin VB.Label Label48 
            AutoSize        =   -1  'True
            Caption         =   "Fecha Liquidación"
            Height          =   195
            Left            =   885
            TabIndex        =   76
            Top             =   2220
            Width           =   1305
         End
         Begin VB.Label Lbl_Monto_Interes_Pagamos 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            Height          =   345
            Left            =   2340
            TabIndex        =   75
            Top             =   2595
            Width           =   1500
         End
         Begin VB.Label Label50 
            AutoSize        =   -1  'True
            Caption         =   "Monto Interes"
            Height          =   195
            Left            =   1185
            TabIndex        =   74
            Top             =   2715
            Width           =   975
         End
         Begin VB.Label Lbl_Monto_Amortizacion_Pagamos 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            Height          =   345
            Left            =   2340
            TabIndex        =   73
            Top             =   3060
            Width           =   1500
         End
         Begin VB.Label Label52 
            AutoSize        =   -1  'True
            Caption         =   "Monto Amortización"
            Height          =   195
            Left            =   810
            TabIndex        =   72
            Top             =   3165
            Width           =   1395
         End
         Begin VB.Label Lbl_Saldo_Pagamos 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            Height          =   345
            Left            =   2340
            TabIndex        =   71
            Top             =   3660
            Width           =   1500
         End
         Begin VB.Label Label54 
            AutoSize        =   -1  'True
            Caption         =   "Saldo"
            Height          =   195
            Left            =   1785
            TabIndex        =   70
            Top             =   3660
            Width           =   405
         End
      End
      Begin VB.Frame Frm_Recibimos 
         Caption         =   "RECIBIMOS"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   4650
         Left            =   -74715
         TabIndex        =   54
         Top             =   330
         Width           =   5565
         Begin VB.Label Lbl_Numero_Flujo_Recibimos 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "1"
            Height          =   345
            Left            =   2355
            TabIndex        =   68
            Top             =   810
            Width           =   1500
         End
         Begin VB.Label Label14 
            AutoSize        =   -1  'True
            Caption         =   "Número Flujo"
            Height          =   195
            Left            =   1260
            TabIndex        =   67
            Top             =   885
            Width           =   930
         End
         Begin VB.Label Lbl_Fecha_Fijacion_tasa_Recibimos 
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            Height          =   345
            Left            =   2355
            TabIndex        =   66
            Top             =   1275
            Width           =   1500
         End
         Begin VB.Label Label15 
            AutoSize        =   -1  'True
            Caption         =   "Fecha Fijación Tasa"
            Height          =   195
            Left            =   735
            TabIndex        =   65
            Top             =   1350
            Width           =   1440
         End
         Begin VB.Label Lbl_Fecha_Vencimiento_Recibimos 
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            Height          =   345
            Left            =   2355
            TabIndex        =   64
            Top             =   1755
            Width           =   1500
         End
         Begin VB.Label Label32 
            AutoSize        =   -1  'True
            Caption         =   "Fecha Vencimiento"
            Height          =   195
            Left            =   780
            TabIndex        =   63
            Top             =   1860
            Width           =   1365
         End
         Begin VB.Label Lbl_Fecha_Liquidacion_Recibimos 
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            Height          =   345
            Left            =   2355
            TabIndex        =   62
            Top             =   2235
            Width           =   1500
         End
         Begin VB.Label Label34 
            AutoSize        =   -1  'True
            Caption         =   "Fecha Liquidación"
            Height          =   195
            Left            =   795
            TabIndex        =   61
            Top             =   2340
            Width           =   1305
         End
         Begin VB.Label Lbl_Monto_Interes_Recibimos 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            Height          =   345
            Left            =   2355
            TabIndex        =   60
            Top             =   2685
            Width           =   1500
         End
         Begin VB.Label Label36 
            AutoSize        =   -1  'True
            Caption         =   "Monto Interes"
            Height          =   195
            Left            =   1140
            TabIndex        =   59
            Top             =   2790
            Width           =   975
         End
         Begin VB.Label Lbl_Monto_Amortizacion_Recibimos 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            Height          =   345
            Left            =   2355
            TabIndex        =   58
            Top             =   3135
            Width           =   1500
         End
         Begin VB.Label Label38 
            AutoSize        =   -1  'True
            Caption         =   "Monto Amortización"
            Height          =   195
            Left            =   735
            TabIndex        =   57
            Top             =   3255
            Width           =   1395
         End
         Begin VB.Label Lbl_Saldo_Recibimos 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            Height          =   345
            Left            =   2355
            TabIndex        =   56
            Top             =   3660
            Width           =   1500
         End
         Begin VB.Label Label40 
            AutoSize        =   -1  'True
            Caption         =   "Saldo"
            Height          =   195
            Left            =   1710
            TabIndex        =   55
            Top             =   3795
            Width           =   405
         End
      End
      Begin VB.Frame FrmEntregamos 
         Caption         =   "Entregamos"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2670
         Left            =   6330
         TabIndex        =   32
         Top             =   375
         Width           =   6195
         Begin BACControles.TXTNumero TxtEntAmortizacion 
            Height          =   345
            Left            =   90
            TabIndex        =   4
            Top             =   2130
            Width           =   1935
            _ExtentX        =   3413
            _ExtentY        =   609
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
            Text            =   "0.0000"
            Text            =   "0.0000"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero TxtEntTasaAnticipo 
            Height          =   345
            Left            =   2085
            TabIndex        =   5
            Top             =   2130
            Width           =   1815
            _ExtentX        =   3201
            _ExtentY        =   609
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
            Text            =   "0.0000"
            Text            =   "0.0000"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label LblEntMoneda 
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   100
            TabIndex        =   53
            Top             =   375
            Width           =   570
         End
         Begin VB.Label LblEntValorMoneda 
            Alignment       =   2  'Center
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   4155
            TabIndex        =   52
            Top             =   960
            Width           =   1995
         End
         Begin VB.Label LblEntSaldo 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   705
            TabIndex        =   51
            Top             =   375
            Width           =   1800
         End
         Begin VB.Label LblEntTasa 
            Alignment       =   2  'Center
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   3045
            TabIndex        =   50
            Top             =   1560
            Width           =   1500
         End
         Begin VB.Label LblEntTipoTasa 
            Alignment       =   2  'Center
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   100
            TabIndex        =   49
            Top             =   1560
            Width           =   2910
         End
         Begin VB.Label LblEntConteoDias 
            Alignment       =   2  'Center
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   4590
            TabIndex        =   48
            Top             =   1560
            Width           =   1500
         End
         Begin VB.Label LblEntFechaUltimoVencimiento 
            Alignment       =   2  'Center
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   100
            TabIndex        =   47
            Top             =   960
            Width           =   2000
         End
         Begin VB.Label LblEntFechaProximoVencimiento 
            Alignment       =   2  'Center
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   2130
            TabIndex        =   46
            Top             =   960
            Width           =   1995
         End
         Begin VB.Label LblEntInteres 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   2520
            TabIndex        =   45
            Top             =   375
            Width           =   1800
         End
         Begin VB.Label LblEntInteresAcumulado 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000018&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   345
            Left            =   4335
            TabIndex        =   44
            Top             =   375
            Width           =   1800
         End
         Begin VB.Label LblTitulosEntregamos 
            Alignment       =   2  'Center
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Tasa Anticipo"
            Height          =   195
            Index           =   10
            Left            =   2085
            TabIndex        =   43
            Top             =   1950
            Width           =   1800
         End
         Begin VB.Label LblTitulosEntregamos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Amortiza"
            Height          =   195
            Index           =   9
            Left            =   135
            TabIndex        =   42
            Top             =   1950
            Width           =   1800
         End
         Begin VB.Label LblTitulosEntregamos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Tipo Tasa"
            Height          =   195
            Index           =   6
            Left            =   100
            TabIndex        =   41
            Top             =   1350
            Width           =   2910
         End
         Begin VB.Label LblTitulosEntregamos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Tasa"
            Height          =   195
            Index           =   7
            Left            =   3045
            TabIndex        =   40
            Top             =   1350
            Width           =   1500
         End
         Begin VB.Label LblTitulosEntregamos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Conteo Días"
            Height          =   195
            Index           =   8
            Left            =   4590
            TabIndex        =   39
            Top             =   1350
            Width           =   1500
         End
         Begin VB.Label LblTitulosEntregamos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Fecha ultimo Vcto."
            Height          =   195
            Index           =   3
            Left            =   120
            TabIndex        =   38
            Top             =   780
            Width           =   2000
         End
         Begin VB.Label LblTitulosEntregamos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Fecha próximo Vcto."
            Height          =   195
            Index           =   4
            Left            =   2130
            TabIndex        =   37
            Top             =   780
            Width           =   1995
         End
         Begin VB.Label LblTitulosEntregamos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Interes Recibe"
            Height          =   195
            Index           =   1
            Left            =   2520
            TabIndex        =   36
            Top             =   200
            Width           =   1800
         End
         Begin VB.Label LblTitulosEntregamos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Interes Devengado"
            Height          =   195
            Index           =   2
            Left            =   4335
            TabIndex        =   35
            Top             =   200
            Width           =   1800
         End
         Begin VB.Label LblTitulosEntregamos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Valor Moneda"
            Height          =   195
            Index           =   5
            Left            =   4140
            TabIndex        =   34
            Top             =   780
            Width           =   1995
         End
         Begin VB.Label LblTitulosEntregamos 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Saldo"
            Height          =   255
            Index           =   0
            Left            =   105
            TabIndex        =   33
            Top             =   200
            Width           =   2400
         End
      End
   End
End
Attribute VB_Name = "Anticipo_Operaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const ConsFormatoMN = "#,##0"
Const ConsFormatoME = "#,##0.0000"

Dim FechaProceso                As String
Dim ValorDO                     As Double

' VARIABLES DE LA PIERNA RECIBIMOS
Dim RecNumeroCupon              As Integer
Dim RecCodMoneda                As Integer
Dim RecCodigoBase               As Integer
Dim RecCodValMoneda             As Integer
Dim RecSaldo                    As Double
Dim RecCodigoTasa               As Integer
Dim RecTasa                     As Double
Dim RecFecInicioFlujo           As String
Dim RecFecVctoFlujo             As String
Dim RecInteres                  As Double
Dim RecInteresAcum              As Double
Dim RecInteresDevengado         As Double
Dim RecDevengo                  As Double
Dim RecResultado                As Double
Dim RecFijacionTasa             As String
Dim RecFechaLiquid              As String
Dim RecAmortizacion             As Double
Dim RecSaldoFlujo               As Double
Dim RecModalidadPago            As String
Dim RecNemoMda                  As String
Dim RecDecimales                As Integer
Dim RecValMoneda                As Double
Dim RecTipoTasa                 As String
Dim RecDias                     As String
Dim ValorMercadoActivo          As Double

' VARIABLES DE LA PIERNA ENTREGAMOS
Dim EntNumeroCupon              As Integer
Dim EntCodMoneda                As Integer
Dim EntCodigoBase               As Integer
Dim EntCodValMoneda             As Integer
Dim EntSaldo                    As Double
Dim EntCodigoTasa               As Integer
Dim EntTasa                     As Double
Dim EntFecInicioFlujo           As String
Dim EntFecVctoFlujo             As String
Dim EntInteres                  As Double
Dim EntInteresAcum              As Double
Dim EntInteresDevengado         As Double
Dim EntDevengo                  As Double
Dim EntResultado                As Double
Dim EntFijacionTasa             As String
Dim EntFechaLiquid              As String
Dim EntAmortizacion             As Double
Dim EntSaldoFlujo               As Double
Dim EntModalidadPago            As String
Dim EntNemoMda                  As String
Dim EntDecimales                As Integer
Dim EntValMoneda                As Double
Dim EntTipoTasa                 As String
Dim EntDias                     As String
Dim Madurez                     As String
Dim ValorMercadoPasivo          As Double

' VARIABLES DE LA LIQUIDACION
Dim MdaLiquidacion              As Integer
Dim MdaValorizacion             As Integer
Dim ValMonedaLiq                As Double
Dim LiqDecimales                As Integer
Dim Principal                   As Double
Dim InteresDevangado            As Double
Dim ValorMercado                As Double
Dim PorcentajeMargen            As Double
Dim MargenUM                    As Double
Dim MargenCLP                   As Double
Dim MontoLiquidar               As Double
Dim CodFPagoLiquidar            As Integer

Dim IntCargaMoneda              As Integer
Dim StrModalidadPago            As String
Dim IntMonedaBuscar             As Integer

'****************************************************************************
'* Busca Operacion SWAP                                                     *
'****************************************************************************
Private Function BuscaOperacion(LngNumeroOperacion As Long)

    On Error GoTo ErrorHandler

    Let IntCargaMoneda = 1

    Dim Datos()                 As Variant
    Dim IntMoneda               As Integer
    Dim StrMoneda               As String
    Dim IntDiasTrans            As Integer
    Dim IntDiasTotal            As Integer
    Dim DblFactor               As Double
    Dim StrBuscaMoneda          As String
    Dim iVuelta                 As Integer

    Let Envia = Array()

    Call AddParam(Envia, LngNumeroOperacion)

    If Not Bac_Sql_Execute("SP_CONSULTA_OPERACION_DATOS", Envia) Then
        Exit Function

    End If

    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) = -1 Then
            Call MsgBox("No se encontro la operación Nro. " & LngNumeroOperacion & vbCrLf & Datos(2), vbExclamation, TITSISTEMA)

        Else
            Let FechaProceso = Datos(1)
            Let ValorDO = Datos(2)
            Let RecNumeroCupon = Datos(3)
            Let RecCodMoneda = Datos(4)
            Let RecCodigoBase = Datos(5)
            Let RecCodValMoneda = Datos(6)
            Let RecSaldo = Datos(7)
            Let RecCodigoTasa = Datos(8)
            Let RecTasa = Datos(9)
            Let RecFecInicioFlujo = Datos(10)
            Let RecFecVctoFlujo = Datos(11)
            Let RecInteres = Datos(12)
            Let RecFijacionTasa = Datos(13)
            Let RecFechaLiquid = Datos(14)
            Let RecAmortizacion = Datos(15)
            Let RecSaldoFlujo = Datos(16)
            Let RecModalidadPago = Datos(17)
            Let RecNemoMda = Datos(18)
            Let RecDecimales = Datos(19)
            Let RecValMoneda = Datos(20)
            Let RecTipoTasa = Datos(21)
            Let RecDias = Datos(22)
            Let EntNumeroCupon = Datos(23)
            Let EntCodMoneda = Datos(24)
            Let EntCodigoBase = Datos(25)
            Let EntCodValMoneda = Datos(26)
            Let EntSaldo = Datos(27)
            Let EntCodigoTasa = Datos(28)
            Let EntTasa = Datos(29)
            Let EntFecInicioFlujo = Datos(30)
            Let EntFecVctoFlujo = Datos(31)
            Let EntInteres = Datos(32)
            Let EntFijacionTasa = Datos(33)
            Let EntFechaLiquid = Datos(34)
            Let EntAmortizacion = Datos(35)
            Let EntSaldoFlujo = Datos(36)
            Let EntModalidadPago = Datos(37)
            Let EntNemoMda = Datos(38)
            Let EntDecimales = Datos(39)
            Let EntValMoneda = Datos(40)
            Let EntTipoTasa = Datos(41)
            Let EntDias = Datos(42)
            Let Madurez = Datos(43)
            Let MdaLiquidacion = Datos(44)
            Let MdaValorizacion = Datos(45)

            Let LblRecMoneda.Caption = RecNemoMda
            Let LblRecValorMoneda.Caption = Format(RecValMoneda, Decimales(RecDecimales))
            Let LblRecSaldo.Caption = Format(RecSaldo, Decimales(RecDecimales))
            Let LblRecTasa.Caption = Format(RecTasa, "##0.###0")
            Let LblRecTipoTasa.Caption = RecTipoTasa
            Let LblRecConteoDias.Caption = RecDias
            Let LblRecFechaUltimoVencimiento.Caption = RecFecInicioFlujo
            Let LblRecFechaProximoVencimiento.Caption = RecFecVctoFlujo
            Let LblRecInteres.Caption = Format(RecInteres, Decimales(RecDecimales))

            Let LblEntMoneda.Caption = EntNemoMda
            Let LblEntValorMoneda.Caption = Format(EntValMoneda, Decimales(EntDecimales))
            Let LblEntSaldo.Caption = Format(EntSaldo, Decimales(EntDecimales))
            Let LblEntTasa.Caption = Format(EntTasa, "##0.###0")
            Let LblEntTipoTasa.Caption = EntTipoTasa
            Let LblEntConteoDias.Caption = EntDias
            Let LblEntFechaUltimoVencimiento.Caption = EntFecInicioFlujo
            Let LblEntFechaProximoVencimiento.Caption = EntFecVctoFlujo
            Let LblEntInteres.Caption = Format(EntInteres, Decimales(EntDecimales))

            Let LblFechaMadurez.Caption = Madurez

            'Let Lbl_Fecha_Fijacion_tasa_Recibimos.Caption = Datos(21)
            'Let Lbl_Fecha_Vencimiento_Recibimos.Caption = Datos(22)
            'Let Lbl_Fecha_Liquidacion_Recibimos.Caption = Datos(23)
            'Let Lbl_Monto_Interes_Recibimos.Caption = Format(Datos(9), "#,##0.###0")
            'Let Lbl_Monto_Amortizacion_Recibimos.Caption = Format(Datos(24), "#,##0.###0")
            'Let Lbl_Saldo_Recibimos.Caption = Format(Datos(25), "#,##0.###0")
            'Let Lbl_Fecha_Fijacion_Tasa_Pagamos.Caption = Datos(26)
            'Let Lbl_Fecha_Vencimiento_Pagamos.Caption = Datos(27)
            'Let Lbl_Fecha_Liquidacion_Pagamos.Caption = Datos(28)
            'Let Lbl_Monto_Interes_Pagamos.Caption = Format(Datos(18), "#,##0.###0")
            'Let Lbl_Monto_Amortizacion_Pagamos.Caption = Format(Datos(29), "#,##0.###0")

            Call BuscarMoneda(CmbMonedaValorizacion, MdaLiquidacion)

            Call SetLiquidacion

            Let ValMonedaLiq = BuscaValorMoneda()
            Let LblValorMonedaLiquidacion.Caption = Format(ValMonedaLiq, "#,##0.#0") 'rev

            Let CmbMonedaLiquidacion.ListIndex = CmbMonedaValorizacion.ListIndex

            Let LblRecInteresAcumulado.Caption = 0

            Call CargaFPagoxMoneda(CmbFormaPagoMonedaLiquidacion, MdaLiquidacion) 'CmbFormaPagoMonedaConversion

            Let iVuelta = 0
            Let TxtFechaValorizacion.Text = gsBAC_Fecp

            '************************************************************************
            '* Dudas:                                                               *
            '*======================================================================*
            '* ¿Para que hace este calculo?.                                        *
            '************************************************************************
            Do While 1 = 1
                If MiDiaHabil(TxtFechaValorizacion.Text, 6) = True Then
                    Let iVuelta = iVuelta + 1

                    If iVuelta = 3 Then
                        Exit Do

                    End If

                    Let TxtFechaValorizacion.Text = DateAdd("D", 1, TxtFechaValorizacion.Text)

                Else
                    Let TxtFechaValorizacion.Text = DateAdd("D", 1, TxtFechaValorizacion.Text)

                End If

            Loop

            Let LblValorMercado.Caption = 0

            '************************************************************************
            '* Dudas:                                                               *
            '*======================================================================*
            '* ¿Para que hace este calculo?.                                        *
            '************************************************************************

            Let IntCargaMoneda = 0

            Call CalcularAnticipo

        End If

    End If

    GoTo Fin

ErrorHandler:

Fin:

End Function

'****************************************************************************
'* Graba Anticipo del SWAP                                                  *
'****************************************************************************
Private Function GrabaAnticipoCompensacion()    'FUNC_GRABA_OPERACION_ANTICIPO

    On Error GoTo ErrorHandler

    Dim oMensajeria   As New GEN_MENSAJE
    Dim nNumDerivado  As Long
    Dim xEvento       As Long
   
    Let nNumDerivado = CDbl(LblNumeroOperacion.Caption)
    Let xEvento = IIf(ChkAnticipoTotal.Value = 1, 4, 3)

    GrabaAnticipoCompensacion = False

    Let Envia = Array()

    '************************************************************************
    '* Dudas:                                                               *
    '*======================================================================*
    '* ¿Como sabe que formas de pago utilizar?.                             *
    '* ¿Donde se graban las tasas?.                                         *
    '* ¿Por que no se graban los campos de margenes?.                       *
    '* ¿Se valida si la operación fue anticipada por otro usuario?.         *
    '* ..............                                                       *
    '************************************************************************

    Call AddParam(Envia, CDbl(LblNumeroOperacion.Caption))
    Call AddParam(Envia, LblFechaAnticipacion.Caption)
    Call AddParam(Envia, CDbl(RecAmortizacion))
    Call AddParam(Envia, CDbl(EntAmortizacion))
    Call AddParam(Envia, Format(TxtFechaValorizacion.Text, FEFecha))
    Call AddParam(Envia, CDbl(RecInteresAcum))
    Call AddParam(Envia, CDbl(EntInteresAcum))
    Call AddParam(Envia, MdaValorizacion)
    Call AddParam(Envia, ValorMercadoActivo)
    Call AddParam(Envia, RecInteresDevengado)
    Call AddParam(Envia, ValorMercadoPasivo)
    Call AddParam(Envia, EntInteresDevengado)
    Call AddParam(Envia, Principal)
    Call AddParam(Envia, InteresDevangado)
    Call AddParam(Envia, ValorMercado)
    Call AddParam(Envia, PorcentajeMargen)
    Call AddParam(Envia, MargenUM)
    Call AddParam(Envia, MargenCLP)
    Call AddParam(Envia, MontoLiquidar)
    Call AddParam(Envia, CodFPagoLiquidar)

    If Not Bac_Sql_Execute("SP_GRABA_ANTICIPO_OPERACION_COMP", Envia) Then
        Call MsgBox("No se puede grabar el anticipo de esta operación", vbExclamation, Me.Caption)
        Exit Function
    End If
       
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) <> 0 Then
            GrabaAnticipoCompensacion = True
            Call MsgBox("Anticipo de SWAP fue generado exitosamente", vbInformation)
            
            On Error Resume Next

            Call oMensajeria.VerificaRelacion("PCS", nNumDerivado, xEvento)

            Set oMensajeria = Nothing

            On Error GoTo 0

            Unload Me
        Else
            GoTo ErrorHandler
        End If

    End If

    GoTo Fin

ErrorHandler:
    Call MsgBox("Existe un problema en la grabación del anticipo", vbExclamation, Me.Caption)

Fin:

End Function

'****************************************************************************
'****************************************************************************
Private Sub SetAnticipoTotal()

    If ChkAnticipoTotal.Value Then
        Let TxtRecAmortizacion.Enabled = False
        Let TxtEntAmortizacion.Enabled = False
        Let TxtRecAmortizacion.Text = RecSaldo
        Let TxtEntAmortizacion.Text = EntSaldo

    Else
        Let TxtRecAmortizacion.Enabled = True
        Let TxtEntAmortizacion.Enabled = True
        Let TxtRecAmortizacion.Text = 0
        Let TxtEntAmortizacion.Text = 0

    End If

    Call CalcularAnticipo

End Sub

'****************************************************************************
'****************************************************************************
Private Sub SetLiquidacion()

    Dim DblMontoActivo          As Double
    Dim DblMontoPasivo          As Double
    Dim DblMontoLiquidar        As Double

    Let MdaLiquidacion = CmbMonedaValorizacion.ItemData(CmbMonedaValorizacion.ListIndex)
    Let LiqDecimales = IIf(MdaLiquidacion = 999, 0, 4)

    Let DblMontoActivo = TxtValorMercadoActivo.Text
    Let DblMontoPasivo = TxtValorMercadoPasivo.Text
    Let DblMontoLiquidar = TxtMontoLiquidar.Text

    Let TxtValorMercadoActivo.CantidadDecimales = LiqDecimales
    Let TxtValorMercadoPasivo.CantidadDecimales = LiqDecimales
    Let TxtMontoLiquidar.CantidadDecimales = LiqDecimales

    Let TxtValorMercadoActivo.Text = DblMontoActivo
    Let TxtValorMercadoPasivo.Text = DblMontoPasivo
    Let TxtMontoLiquidar.Text = DblMontoLiquidar

End Sub

'****************************************************************************
'****************************************************************************
Private Function SetMonto(ByVal StrMonto As String) As Double

    If StrMonto = "" Then
        Let StrMonto = "0"
    End If

    If StrMonto = "-" Then
        Let StrMonto = "0"
    End If


    Let SetMonto = Replace(Replace(StrMonto, Chr(13), ""), Chr(10), "")

End Function

'****************************************************************************
'****************************************************************************
Private Function Decimales(ByVal IntDecimales As Integer) As String

    Decimales = "#,##0" + IIf(IntDecimales > 0, Left(".0000", IntDecimales + 1), "")

End Function

Private Sub BuscarMoneda(objMoneda As Object, ByVal IntMonedaBuscar As Integer)

    Dim IntMoneda               As Integer

    With objMoneda
        Let .ListIndex = 0
        For IntMoneda = 0 To CmbMonedaValorizacion.ListCount - 1
            If .ItemData(IntMoneda) = IntMonedaBuscar Then
                Let .ListIndex = IntMoneda
                Exit For

            End If

        Next IntMoneda

    End With

End Sub

'****************************************************************************
'****************************************************************************
Private Sub CalcularAnticipo()

    Dim IntDiasTrans            As Integer
    Dim IntDiasTotal            As Integer
    Dim DblFactor               As Double

    If IntCargaMoneda <> 0 Then
        Exit Sub

    End If

    On Error Resume Next

    Let IntCargaMoneda = 2

    Dim StrCodigoMoneda         As String

    Let MdaLiquidacion = CmbMonedaValorizacion.ItemData(CmbMonedaValorizacion.ListIndex)

    Let MdaValorizacion = MdaLiquidacion

    If MdaLiquidacion = 998 Then
        Let MdaValorizacion = 999
        Let LblMonedaTransada.Caption = "CLP"

    Else
        Let LblMonedaTransada.Caption = Trim(Right(CmbMonedaValorizacion.List(CmbMonedaValorizacion.ListIndex), 12))

    End If

    Let LiqDecimales = IIf(MdaLiquidacion = 999, 0, 4)


    Let ValMonedaLiq = BuscaValorMoneda()

    If ValMonedaLiq = 0 Then
        'Call MsgBox("No se encontro el valor de la moneda " & StrCodigoMoneda & " para el " & TxtFechaValorizacion.Text, vbExclamation, Me.Caption)

        Let RecInteresDevengado = 0
        Let RecDevengo = 0
        Let RecResultado = 0

        ' Calculo de la Proporcion al Monto Armotización del Interes Devengado Entregamos
        Let ValorMercadoPasivo = 0
        Let EntAmortizacion = 0
        Let EntInteresDevengado = 0
        Let EntDevengo = 0
        Let EntResultado = 0

        ' Calculo del Valor Principal, Interes Devengado y Mercado
        Let Principal = 0
        Let InteresDevangado = 0
        Let ValorMercado = 0

        'Recibimos
        '-----------------------------------
        Let RecInteresAcum = 0

        ' Pagamos
        '----------------
        Let EntInteresAcum = 0

    Else
        'Recibimos
        '-----------------------------------
        Let IntDiasTrans = DateDiff("d", RecFecInicioFlujo, TxtFechaValorizacion.Text)
        Let IntDiasTotal = DateDiff("d", RecFecInicioFlujo, RecFecVctoFlujo)
        Let DblFactor = IntDiasTrans / IntDiasTotal
        Let RecInteresAcum = Round(RecInteres * DblFactor, RecDecimales)

        ' Pagamos
        '----------------
        Let IntDiasTrans = DateDiff("d", EntFecInicioFlujo, TxtFechaValorizacion.Text)
        Let IntDiasTotal = DateDiff("d", EntFecInicioFlujo, EntFecVctoFlujo)
        Let DblFactor = IntDiasTrans / IntDiasTotal
        Let EntInteresAcum = Round(EntInteres * DblFactor, EntDecimales)

        ' Calculo de la Proporcion al Monto Armotización del Interes Devengado Recibimos
        Let ValorMercadoActivo = TxtValorMercadoActivo.Text
        Let RecAmortizacion = TxtRecAmortizacion.Text
        Let RecInteresDevengado = RecInteresAcum * BacDiv(RecAmortizacion, RecSaldo)
        Let RecInteresDevengado = Round(RecInteresAcum * BacDiv(RecAmortizacion, RecSaldo), LiqDecimales)
        Let RecDevengo = Round(RecInteresDevengado * BacDiv(RecValMoneda, ValMonedaLiq), LiqDecimales)
        Let RecResultado = ValorMercadoActivo - RecDevengo

        ' Calculo de la Proporcion al Monto Armotización del Interes Devengado Entregamos
        Let ValorMercadoPasivo = TxtValorMercadoPasivo.Text
        Let EntAmortizacion = TxtEntAmortizacion.Text
        Let EntInteresDevengado = EntInteresAcum * BacDiv(EntAmortizacion, EntSaldo)
        Let EntInteresDevengado = Round(EntInteresAcum * BacDiv(EntAmortizacion, EntSaldo), LiqDecimales)
        Let EntDevengo = Round(EntInteresDevengado * BacDiv(EntValMoneda, ValMonedaLiq), LiqDecimales)
        Let EntResultado = ValorMercadoPasivo - EntDevengo

        ' Calculo del Valor Principal, Interes Devengado y Mercado
        Let Principal = RecResultado - EntResultado
        Let InteresDevangado = RecInteresDevengado - EntInteresDevengado
        Let ValorMercado = ValorMercadoActivo - ValorMercadoPasivo

        Let MontoLiquidar = ValorMercado

    End If

    Let LblValorMonedaLiquidacion.Caption = Format(ValMonedaLiq, Decimales(LiqDecimales))

    Call CargaFPagoxMoneda(CmbFormaPagoMonedaTransada, CmbMonedaValorizacion.ItemData(CmbMonedaValorizacion.ListIndex))

    Let LblRecInteresAcumulado.Caption = Format(RecInteresAcum, Decimales(RecDecimales))
    Let LblRecInteresDevengado.Caption = Format(RecDevengo, Decimales(LiqDecimales))
    Let LblRecResultado.Caption = Format(RecResultado, Decimales(LiqDecimales))

    Let LblEntInteresAcumulado.Caption = Format(EntInteresAcum, Decimales(EntDecimales))
    Let LblEntInteresDevengado.Caption = Format(EntDevengo, Decimales(LiqDecimales))
    Let LblEntResultado.Caption = Format(EntResultado, Decimales(LiqDecimales))

    Let LblPrincipal.Caption = Format(Principal, Decimales(LiqDecimales))
    Let LblInteresDevangado.Caption = Format(InteresDevangado, Decimales(LiqDecimales))
    Let LblValorMercado.Caption = Format(ValorMercado, Decimales(LiqDecimales))

    Let LblTipoOperacion.Caption = IIf(Str(LblValorMercado.Caption) > 0, "COMPRA", "VENTA")
    Let TxtMontoMonedaTransada.Text = ValorMercado
    Let TxtMontoLiquidar.Text = MontoLiquidar

    If IntCargaMoneda = 2 Then
        Let IntCargaMoneda = 0

    End If

    On Error GoTo 0

End Sub

Private Sub CalcularMargen()

    ' Calculo del Margen
    Let PorcentajeMargen = TxtPorcentajeMargen.Text
    Let MargenUM = Round(MontoLiquidar * PorcentajeMargen / 100, LiqDecimales)
    Let MargenCLP = Round(MargenUM * ValMonedaLiq, 0)

    Let LblMargenUM.Caption = Format(MargenUM, Decimales(LiqDecimales))
    Let LblMargenCLP.Caption = Format(MargenCLP, Decimales(0))

End Sub

'****************************************************************************
'* Calculo de los Valores a Amortizar                                       *
'****************************************************************************
Private Sub CalcularAmortizacion(ByVal IntOpcion As Integer)

    Select Case IntOpcion
    Case 1  ' Calcular Monto Entregamos
        If RecSaldo <> 0 Then
            RecAmortizacion = SetMonto(TxtRecAmortizacion.Text)
            EntAmortizacion = Round(EntSaldo * BacDiv(RecAmortizacion, RecSaldo), EntDecimales)
            Let TxtEntAmortizacion.Text = EntAmortizacion
        End If

    Case 2  ' Calcular Monto Recibimos
        If EntSaldo <> 0 Then
            EntAmortizacion = SetMonto(TxtEntAmortizacion.Text)
            RecAmortizacion = Round(RecSaldo * BacDiv(EntAmortizacion, EntSaldo), RecDecimales)
            Let TxtRecAmortizacion.Text = RecAmortizacion

        End If

    End Select

    Call CalcularAnticipo

End Sub

'****************************************************************************
'* Carga Combo de Monedas                                                   *
'****************************************************************************
Private Sub CargarMonedas(objMoneda As ComboBox)

    On Error GoTo ErrorHandler

    Dim Datos()                 As Variant

    Let Envia = Array()

    Call AddParam(Envia, "PCS")

    If Not Bac_Sql_Execute("SP_LEER_MONEDAS_SISTEMA", Envia) Then
        GoTo ErrorHandler

    End If

    objMoneda.Clear

    Do While Bac_SQL_Fetch(Datos())
        Call objMoneda.AddItem(UCase(Datos(2)) & Space(100) & UCase(Trim(Datos(3))))
        Let objMoneda.ItemData(objMoneda.NewIndex) = Val(Datos(1))

    Loop

    Let objMoneda.ListIndex = 0

    GoTo Fin

ErrorHandler:
    Call MsgBox("Error Lectura. " & vbCrLf & vbCrLf & "Se ha Producido un Error al Leer Monedas por Sistema.", vbExclamation, TITSISTEMA)

Fin:

End Sub

'****************************************************************************
'* Carga Formas de Pago                                                     *
'****************************************************************************
Private Sub CargaFPagoxMoneda(objCarga As ComboBox, iMoneda As Integer)

    On Error GoTo ErrorHandler

    Let Envia = Array()

    Call AddParam(Envia, "PCS")
    Call AddParam(Envia, iMoneda)
    Call AddParam(Envia, CDbl(2))

    If Not Bac_Sql_Execute("SP_MONEDA_DOC_PAGO", Envia) Then
        GoTo Fin

    End If

    Call objCarga.Clear

    Do While Bac_SQL_Fetch(Datos())
        Call objCarga.AddItem(Datos(2))
        Let objCarga.ItemData(objCarga.NewIndex) = Val(Datos(1))

    Loop

    If objCarga.ListIndex = -1 Then
        Let objCarga.ListIndex = 0

    End If

    GoTo Fin

ErrorHandler:
    Call MsgBox("No se puede cargar los datos de la Moneda " & iMoneda, vbExclamation, Me.Caption)

Fin:

End Sub

'****************************************************************************
'* Busca el Valor de la Moneda a una Fecha                                  *
'****************************************************************************
Private Function BuscaValorMoneda() As Double

    On Error GoTo ErrorHandler

    Dim IntCodigoMoneda         As Integer
    Dim StrFecha                As String

    Let StrFecha = LblFechaAnticipacion.Caption 'TxtFechaValorizacion.Text
    Let IntCodigoMoneda = CmbMonedaValorizacion.ItemData(CmbMonedaValorizacion.ListIndex)

    If IntCodigoMoneda = 999 Then
        Let BuscaValorMoneda = 1#
        Exit Function

    End If

    Let BuscaValorMoneda = 0

    If IntCodigoMoneda = 13 Then
        Let IntCodigoMoneda = 994

    End If

    Let Envia = Array()
    Call AddParam(Envia, Format(StrFecha, FEFecha))
    Call AddParam(Envia, IntCodigoMoneda)

    If Not Bac_Sql_Execute("SP_BUSCA_VALORES_VALORIZA", Envia) Then
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then
        Let BuscaValorMoneda = Datos(1)

    End If


    GoTo Fin

ErrorHandler:
    Call MsgBox("No se puede cargar el valor de la Moneda " & IntCodigoMoneda & " a la fecha " & StrFecha, vbExclamation, Me.Caption)

Fin:

End Function

'****************************************************************************
'****************************************************************************
Private Function MiDiaHabil(cFecha As String, Plaza As Integer) As Boolean

    Dim objFeriado              As New clsFeriado
    Dim iAno                    As Integer
    Dim iMes                    As Integer
    Dim sDia                    As String
    Dim gcPlaza                 As String
    Dim n                       As Integer

    Let gcPlaza = String(5 - Len(Trim(Plaza)), "0") & Trim(Str(Trim(Plaza)))

    If Weekday(cFecha) = 1 Or Weekday(cFecha) = 7 Then
        MiDiaHabil = False
        Exit Function

    End If

    Let iAno = DatePart("yyyy", cFecha)
    Let iMes = DatePart("m", cFecha)
    Let sDia = Format(DatePart("d", cFecha), "00")

    Call objFeriado.Leer(iAno, gcPlaza)

    Select Case iMes
    Case 1
        Let n = InStr(objFeriado.feene, sDia)
    Case 2
        Let n = InStr(objFeriado.fefeb, sDia)
    Case 3
        Let n = InStr(objFeriado.femar, sDia)
    Case 4
        Let n = InStr(objFeriado.feabr, sDia)
    Case 5
        Let n = InStr(objFeriado.femay, sDia)
    Case 6
        Let n = InStr(objFeriado.fejun, sDia)
    Case 7
        Let n = InStr(objFeriado.fejul, sDia)
    Case 8
        Let n = InStr(objFeriado.feago, sDia)
    Case 9
        Let n = InStr(objFeriado.fesep, sDia)
    Case 10
        Let n = InStr(objFeriado.feoct, sDia)
    Case 11
        Let n = InStr(objFeriado.fenov, sDia)
    Case 12
        Let n = InStr(objFeriado.fedic, sDia)
    End Select

    Set objFeriado = Nothing

    Let MiDiaHabil = IIf(n > 0, False, True)

End Function

'****************************************************************************
'****************************************************************************
Private Sub ChkAnticipoTotal_Click()

    Call SetAnticipoTotal
    Call CalcularAnticipo

End Sub

Private Sub CmbFormaPagoMonedaLiquidacion_Click()

    With CmbFormaPagoMonedaLiquidacion
        If .ListIndex > -1 Then
            Let CodFPagoLiquidar = .ItemData(.ListIndex)

        Else
            Let CodFPagoLiquidar = 0

        End If

    End With

End Sub

'****************************************************************************
'****************************************************************************
Private Sub CmbModalidadPago_Click()

    Let FrmEntregaFisica.Enabled = False
    Let FrmCompensacion.Enabled = False

    If CmbModalidadPago.ListIndex = 0 Then
        Let FrmEntregaFisica.Enabled = True
    Else
        Let FrmCompensacion.Enabled = True
    End If

End Sub

'****************************************************************************
'****************************************************************************
Private Sub CmbMonedaLiquidacion_Click()

    If IntCargaMoneda = 0 Then
        If CmbMonedaLiquidacion.ListIndex >= 0 Then
            Call CargaFPagoxMoneda(CmbFormaPagoMonedaLiquidacion, CmbMonedaLiquidacion.ItemData(CmbMonedaLiquidacion.ListIndex))

        End If
    End If

End Sub

'****************************************************************************
'****************************************************************************
Private Sub CmbMonedaValorizacion_Click()

    Let CmbMonedaLiquidacion.ListIndex = CmbMonedaValorizacion.ListIndex

    If IntCargaMoneda = 0 Then
        Call SetLiquidacion
        Call CalcularAnticipo

    End If

End Sub

'****************************************************************************
'****************************************************************************
Private Sub Form_Load()

    Let IntCargaMoneda = 1

    Let LblFechaAnticipacion.Caption = gsBAC_Fecp
    Let TxtFechaValorizacion.Text = gsBAC_Fecp

    Call CargarMonedas(CmbMonedaLiquidacion)
    Call CargarMonedas(CmbMonedaValorizacion)

    Let LblNumeroOperacion.Caption = GlbNumeroAnticipo

    Call BuscaOperacion(GlbNumeroAnticipo)

    Let ChkAnticipoTotal.Value = 1
    Call SetAnticipoTotal
    Call CalcularAnticipo

    With CmbModalidadPago
        Call .Clear
        Call .AddItem("ENTREGA FISICA")
        Call .AddItem("COMPENSACION")

        Let .ListIndex = 1

        Let .Enabled = False

    End With

    Let TabOperaciones.Tab = 0

End Sub

'****************************************************************************
'****************************************************************************
Private Sub Tool_menu_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
    Case 1
    
     If Not Valida_Datos() Then
     
         Screen.MousePointer = vbDefault
       
     Else
        If Me.CmbModalidadPago.ListIndex = 1 Then
            If GrabaAnticipoCompensacion() Then
                FiltrarConsulta_Anticipo.Filtrar
                Unload Me

            End If

        Else
            'Entrega Física todavía no esta desarrollada

        End If
     End If

    Case 2
        Unload Me

    End Select

End Sub

'****************************************************************************
'****************************************************************************
Private Sub TxtEntAmortizacion__Change()

    Call CalcularAmortizacion(2)

End Sub

Private Sub TxtEntAmortizacion_GotFocus()

    Let TxtEntAmortizacion.Tag = TxtEntAmortizacion.Text

End Sub

Private Sub TxtEntAmortizacion_LostFocus()

    If TxtEntAmortizacion.Tag <> TxtEntAmortizacion.Text Then
        If CDbl(TxtEntAmortizacion.Text) > CDbl(LblEntSaldo.Caption) Then
            Call MsgBox("La amortización ingresada no debe ser mayor al Saldo Entregamos", vbCritical)
            Exit Sub

        End If

        Call CalcularAmortizacion(2)
        Let TxtEntAmortizacion.Tag = ""

    End If

End Sub

'****************************************************************************
'****************************************************************************
Private Sub TxtFechaValorizacion_Change()

    Call CalcularAnticipo

End Sub

Private Sub TxtMontoLiquidar_Change()

    Let MontoLiquidar = SetMonto(TxtMontoLiquidar.Text)
    Call CalcularMargen

End Sub

'****************************************************************************
'****************************************************************************
Private Sub TxtPorcentajeMargen_Change()

    Call CalcularMargen

End Sub

'****************************************************************************
'****************************************************************************
Private Sub TxtRecAmortizacion_Change()

    Call CalcularAmortizacion(1)

End Sub

Private Sub TxtRecAmortizacion_GotFocus()

    Let TxtRecAmortizacion.Tag = TxtRecAmortizacion.Text

End Sub

Private Sub TxtRecAmortizacion_LostFocus()

    If TxtRecAmortizacion.Tag <> TxtRecAmortizacion.Text Then
        If CDbl(TxtRecAmortizacion.Text) > CDbl(LblRecSaldo.Caption) Then
            Call MsgBox("La amortización ingresada no debe ser mayor al Saldo Recibimos", vbCritical)
            Exit Sub

        End If

        Call CalcularAmortizacion(1)
        Let TxtRecAmortizacion.Tag = ""

    End If

End Sub

'****************************************************************************
'****************************************************************************
Private Sub TxtValorMercadoActivo_Change()

    Call CalcularAnticipo

End Sub

Private Sub TxtValorMercadoActivo_GotFocus()

    Let TxtValorMercadoActivo.Tag = TxtValorMercadoActivo.Text

End Sub

Private Sub TxtValorMercadoActivo_LostFocus()

    If TxtValorMercadoActivo.Tag <> TxtValorMercadoActivo.Text Then
        Call CalcularAnticipo

    End If

End Sub

'****************************************************************************
'****************************************************************************
Private Sub TxtValorMercadoPasivo_GotFocus()

    Let TxtValorMercadoPasivo.Tag = TxtValorMercadoPasivo.Text

End Sub

'****************************************************************************
'****************************************************************************
Private Sub TxtValorMercadoPasivo_Change()

    Call CalcularAnticipo

End Sub

Private Sub TxtValorMercadoPasivo_LostFocus()

    If TxtValorMercadoPasivo.Tag <> TxtValorMercadoPasivo.Text Then
        Call CalcularAnticipo

    End If

End Sub

Function Valida_Datos() As Boolean
   Valida_Datos = True
   If (TxtRecAmortizacion.Text = 0) Or (TxtEntAmortizacion.Text = 0) Then
      MsgBox "Debe ingresar Amortización.", vbCritical, TITSISTEMA
      Valida_Datos = False
   End If
   
   If TxtMontoLiquidar.Text = 0 And Valida_Datos = True Then
     If (MsgBox("Advertencia: Monto a Liquidar se grabará en Cero. " & Chr(10) & "¿ Desea Seguir con la Grabación ?", vbYesNo + vbQuestion)) = vbYes Then
       Valida_Datos = True
     Else
       Valida_Datos = False
       Exit Function
     End If
   End If
End Function

