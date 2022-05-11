VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form recompras_anticipadas_captaciones 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Recompras Anticipadas de Captaciones"
   ClientHeight    =   7260
   ClientLeft      =   615
   ClientTop       =   1020
   ClientWidth     =   11340
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "Rc_Capta.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   7260
   ScaleWidth      =   11340
   Tag             =   "RI"
   Begin VB.Frame Frame3 
      BackColor       =   &H80000004&
      Caption         =   "Cortes Captación"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000002&
      Height          =   4995
      Left            =   0
      TabIndex        =   6
      Top             =   2280
      Width           =   11295
      Begin VB.TextBox Text2 
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         ForeColor       =   &H00800000&
         Height          =   225
         Left            =   360
         TabIndex        =   29
         Top             =   1680
         Visible         =   0   'False
         Width           =   1400
      End
      Begin VB.ComboBox Combo1 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         ForeColor       =   &H00800000&
         Height          =   315
         ItemData        =   "Rc_Capta.frx":030A
         Left            =   360
         List            =   "Rc_Capta.frx":0314
         Style           =   2  'Dropdown List
         TabIndex        =   28
         Top             =   1320
         Visible         =   0   'False
         Width           =   1400
      End
      Begin BACControles.TXTNumero TxtFung 
         Height          =   225
         Left            =   360
         TabIndex        =   27
         Top             =   1035
         Visible         =   0   'False
         Width           =   1395
         _ExtentX        =   2461
         _ExtentY        =   397
         BackColor       =   12632256
         ForeColor       =   192
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   0
         Text            =   "0.000000"
         Text            =   "0.000000"
         Max             =   "999999999999.99999"
         CantidadDecimales=   "6"
         Separator       =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid gr_cortes 
         Height          =   3555
         Left            =   120
         TabIndex        =   17
         TabStop         =   0   'False
         Top             =   480
         Width           =   11100
         _ExtentX        =   19579
         _ExtentY        =   6271
         _Version        =   393216
         Cols            =   15
         FixedCols       =   2
         BackColor       =   -2147483644
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483632
         GridColorFixed  =   -2147483642
         Redraw          =   -1  'True
         AllowBigSelection=   -1  'True
         GridLines       =   2
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.CommandButton Cmd_DesMarcar 
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   310
         Left            =   580
         TabIndex        =   25
         ToolTipText     =   "Desmarcar Todos"
         Top             =   4095
         Width           =   440
      End
      Begin VB.CommandButton Cmd_Marcar 
         Caption         =   "+"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   310
         Left            =   120
         TabIndex        =   24
         ToolTipText     =   "Seleccionar Todos"
         Top             =   4095
         Width           =   440
      End
      Begin BACControles.TXTNumero TxtCartera 
         Height          =   315
         Left            =   2385
         TabIndex        =   30
         Top             =   4095
         Width           =   2460
         _ExtentX        =   4339
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Max             =   "99999999999999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero TxtCarteraSel 
         Height          =   315
         Left            =   8400
         TabIndex        =   33
         Top             =   4095
         Width           =   2100
         _ExtentX        =   3704
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Max             =   "99999999999999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero TXTN_montoS_UF 
         Height          =   315
         Left            =   2400
         TabIndex        =   38
         Top             =   4440
         Width           =   2445
         _ExtentX        =   4313
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Max             =   "99999999999999"
         Separator       =   -1  'True
      End
      Begin VB.Label LBLSymbol 
         BackColor       =   &H00808000&
         Caption         =   "S"
         BeginProperty Font 
            Name            =   "Symbol"
            Size            =   9
            Charset         =   2
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Left            =   5460
         TabIndex        =   40
         Top             =   4110
         Width           =   210
      End
      Begin VB.Label Lbl_montoS_UF 
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Monto $"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   1080
         TabIndex        =   39
         Top             =   4440
         Width           =   1275
      End
      Begin VB.Label Label 
         BackStyle       =   0  'Transparent
         Caption         =   "R : Restaurar Corte "
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   200
         Index           =   1
         Left            =   9240
         TabIndex        =   35
         Top             =   200
         Width           =   1935
      End
      Begin VB.Label Label 
         BackStyle       =   0  'Transparent
         Caption         =   "V : Vender Corte"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   200
         Index           =   0
         Left            =   6720
         TabIndex        =   34
         Top             =   200
         Width           =   2175
      End
      Begin VB.Label Label3 
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "        Valor Recompra"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   330
         Left            =   5415
         TabIndex        =   32
         Top             =   4095
         Width           =   2955
      End
      Begin VB.Label Label6 
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   " Cartera"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   1095
         TabIndex        =   31
         Top             =   4095
         Width           =   1275
      End
   End
   Begin VB.Frame Frm_fechas 
      Caption         =   "Datos Captación"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000002&
      Height          =   1680
      Left            =   0
      TabIndex        =   5
      Top             =   600
      Width           =   11295
      Begin BACControles.TXTFecha TxtFechaIni 
         Height          =   315
         Left            =   5565
         TabIndex        =   36
         Top             =   555
         Width           =   1350
         _ExtentX        =   2381
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "30/06/2009"
      End
      Begin VB.TextBox IntNumoper 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   180
         MaxLength       =   10
         MouseIcon       =   "Rc_Capta.frx":0325
         MousePointer    =   99  'Custom
         TabIndex        =   26
         ToolTipText     =   "Haga Doble Click para abrir la Ayuda"
         Top             =   550
         Width           =   1215
      End
      Begin VB.CommandButton Ayuda 
         Caption         =   "?"
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
         Left            =   1440
         TabIndex        =   23
         ToolTipText     =   "Ayuda de Operaciones"
         Top             =   550
         Width           =   300
      End
      Begin VB.ComboBox CmbTipo_Emision 
         Height          =   315
         ItemData        =   "Rc_Capta.frx":0477
         Left            =   5640
         List            =   "Rc_Capta.frx":0479
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   1230
         Width           =   3855
      End
      Begin VB.ComboBox CmbCondicion 
         Height          =   315
         ItemData        =   "Rc_Capta.frx":047B
         Left            =   3720
         List            =   "Rc_Capta.frx":047D
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   1230
         Width           =   1890
      End
      Begin VB.ComboBox Cmb_Tipo_Deposito 
         Height          =   315
         ItemData        =   "Rc_Capta.frx":047F
         Left            =   1860
         List            =   "Rc_Capta.frx":0481
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   1230
         Width           =   1830
      End
      Begin VB.ComboBox Cmb_Custodia 
         Height          =   315
         ItemData        =   "Rc_Capta.frx":0483
         Left            =   180
         List            =   "Rc_Capta.frx":0485
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   1230
         Width           =   1635
      End
      Begin VB.ComboBox Cmb_Moneda 
         Height          =   315
         Left            =   1800
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   550
         Width           =   1590
      End
      Begin BACControles.TXTNumero Msk_Tasa 
         Height          =   315
         Left            =   6990
         TabIndex        =   22
         Top             =   540
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.000000"
         Text            =   "0.000000"
         Min             =   "-999"
         Max             =   "999"
         CantidadDecimales=   "6"
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero Txt_Dias 
         Height          =   315
         Left            =   4870
         TabIndex        =   18
         Top             =   550
         Width           =   615
         _ExtentX        =   1085
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Min             =   "1"
         Max             =   "9999"
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTFecha Msk_Fecha_Vcto 
         Height          =   315
         Left            =   3450
         TabIndex        =   19
         Top             =   550
         Width           =   1350
         _ExtentX        =   2381
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "30/06/2009"
      End
      Begin BACControles.TXTNumero Flt_TasaTran 
         Height          =   315
         Left            =   8250
         TabIndex        =   20
         Top             =   555
         Width           =   1260
         _ExtentX        =   2223
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.000000"
         Text            =   "0.000000"
         Min             =   "-999"
         Max             =   "999"
         CantidadDecimales=   "6"
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Fecha_Inicio 
         BackStyle       =   0  'Transparent
         Caption         =   "Fecha Inicio"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   5565
         TabIndex        =   37
         Top             =   330
         Width           =   1215
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Operación "
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   195
         Index           =   10
         Left            =   180
         TabIndex        =   16
         Top             =   330
         Width           =   900
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Tipo de Emisión"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   8
         Left            =   5640
         TabIndex        =   15
         Top             =   1005
         Width           =   1305
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Condición"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   7
         Left            =   3720
         TabIndex        =   14
         Top             =   1005
         Width           =   810
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Tipo Depósito"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   2
         Left            =   1860
         TabIndex        =   13
         Top             =   1005
         Width           =   1155
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Custodia"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   180
         TabIndex        =   12
         Top             =   1005
         Width           =   735
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Tasa Tran."
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   8250
         TabIndex        =   11
         Top             =   330
         Width           =   885
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Vencimiento"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   195
         Index           =   6
         Left            =   3450
         TabIndex        =   10
         Top             =   330
         Width           =   1050
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Moneda"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   195
         Index           =   5
         Left            =   1800
         TabIndex        =   9
         Top             =   330
         Width           =   675
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Plazo "
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   4
         Left            =   4875
         TabIndex        =   8
         Top             =   330
         Width           =   495
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Tasa Emisión"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   3
         Left            =   6975
         TabIndex        =   7
         Top             =   330
         Width           =   1095
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   555
      Left            =   0
      TabIndex        =   21
      Top             =   0
      Width           =   11340
      _ExtentX        =   20003
      _ExtentY        =   979
      ButtonWidth     =   847
      ButtonHeight    =   820
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbgrabar"
            Description     =   "GRABAR"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmblimpiar"
            Description     =   "LIMPIAR"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "salir"
            Description     =   "SALIR"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5880
         Top             =   240
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
               Picture         =   "Rc_Capta.frx":0487
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Rc_Capta.frx":08D9
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Rc_Capta.frx":0BF3
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "recompras_anticipadas_captaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim nDecimales      As String
Dim nDecInteres     As String
Dim varssql         As String
Dim bControl        As Boolean
Dim DiasMin         As Integer
Dim cFormato        As String
Dim objCondicion    As New ClsCodigos
Dim Mon             As Integer
Dim Color           As String
Dim colorletra      As String
Dim nCodcli&
'+++jcamposd
Dim UfCalculoPantalla As Double
'---jcamposd

Private Sub Formatos()
    Dim i           As Integer
    Dim nGlosa      As String

    Select Case Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)
        'Case 998, 999: nGlosa = " " & "$$"
        Case 999: nGlosa = " " & "$$"
        Case Else:     nGlosa = " " & Trim(Mid(Cmb_Moneda.text, 1, 3))
    End Select

     If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 999 Then
            TxtCarteraSel.CantidadDecimales = 0
            TxtCarteraSel.Max = 99999999999#
            TxtCartera.CantidadDecimales = 0
            TxtCartera.Max = 99999999999#
            
        ElseIf Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 998 Then
            TxtCarteraSel.CantidadDecimales = 4
            TxtCarteraSel.Max = 99999999999.9999
            TxtCartera.CantidadDecimales = 4
            TxtCartera.Max = 99999999999.9999
        Else
            TxtCarteraSel.CantidadDecimales = 2
            TxtCarteraSel.Max = 99999999999.99
            TxtCartera.CantidadDecimales = 2
            TxtCartera.Max = 99999999999.99
        End If


    gr_cortes.TextMatrix(0, C_Valor_A_Pagar) = gr_cortes.TextMatrix(0, C_Valor_A_Pagar) & nGlosa
    gr_cortes.TextMatrix(0, C_Valor_A_Pagar_Org) = gr_cortes.TextMatrix(0, C_Valor_A_Pagar_Org) & nGlosa
    gr_cortes.TextMatrix(0, C_Interes_Pagar) = gr_cortes.TextMatrix(0, C_Interes_Pagar) & IIf(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 999, nGlosa, " UM")
    
    TxtCartera.text = 0
    TxtCarteraSel.text = 0
    
    '+++jcamposd
    If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 998 Then
        TXTN_montoS_UF.Visible = True
        Lbl_montoS_UF.Visible = True
    End If
    '---jcamposd
    
    For i = 1 To gr_cortes.Rows - 1
        If gr_cortes.TextMatrix(i, C_Tipo_Custodia) = "DCV" Then
            gr_cortes.TextMatrix(i, C_Clave_Dcv) = FUNC_GENERA_CLAVE_DCV
        End If

        Call Calculo_Interes_Inicial(i)

        TxtCartera.text = CDbl(TxtCartera.text) + CDbl(gr_cortes.TextMatrix(i%, C_Valor_A_Pagar))
        TxtCarteraSel.text = CDbl(TxtCarteraSel.text) + IIf(gr_cortes.TextMatrix(i%, C_Campo_Venta) = "X", CDbl(gr_cortes.TextMatrix(i%, C_Valor_A_Pagar)), 0)
    Next i
    'TxtCartera.text = Round(Format$(CDbl(TxtCartera.text), cFormato), 0) '-->decimales
End Sub

Private Sub PROC_CREA_GRILLA()
    
    gr_cortes.WordWrap = True
    gr_cortes.cols = 24
    gr_cortes.FixedCols = 3
    gr_cortes.Rows = 1
    gr_cortes.RowHeight(0) = 600
    gr_cortes.TextMatrix(0, C_Bloqueo) = "Marca /  Bloqueo"
    gr_cortes.TextMatrix(0, C_Num_Dcv) = "N° DCV Certificado"
    gr_cortes.TextMatrix(0, C_MONTO_CORTE) = "Capital                  Final UM" 'Inicial UM" +++jcamposd recalculo
    gr_cortes.TextMatrix(0, C_Tasa_Recompra) = "TIR"
    gr_cortes.TextMatrix(0, C_Interes_Pagar) = "Interes a        Pagar"
    gr_cortes.TextMatrix(0, C_Valor_A_Pagar) = "Valor Recompra "
    gr_cortes.TextMatrix(0, C_Tipo_Custodia) = "Tipo Custodia"
    gr_cortes.TextMatrix(0, C_Clave_Dcv) = "Clave          DCV"
    gr_cortes.TextMatrix(0, C_Monto_Corte_Org) = "Capital Inicial UM Recompra"
    gr_cortes.TextMatrix(0, C_Tasa_Compra_Org) = "Tasa Compra Recompra"
    gr_cortes.TextMatrix(0, C_Valor_A_Pagar_Org) = "Valor Devengado"
    gr_cortes.TextMatrix(0, C_Valor_Recompra) = "Valor Devengados"
    gr_cortes.TextMatrix(0, C_Interes_Dev) = "Interes Devengados" 'a Pagar Recompra +++jcamposd
    gr_cortes.TextMatrix(0, C_Reajuste_Dev) = "Reajuste a Pagar Recompra"
    gr_cortes.TextMatrix(0, C_Campo_Venta) = "Marca de Anticipo"
    gr_cortes.TextMatrix(0, C_Correlativo) = "Correlativo"
    gr_cortes.TextMatrix(0, C_Plazo) = "Plazo"
    gr_cortes.TextMatrix(0, C_Check_Interes) = "Interes Excedido"
    gr_cortes.TextMatrix(0, C_Reajuste_Pagar) = "Reajuste a       Pagar $$"
    '+++jcamposd 20151028 recompra
    gr_cortes.TextMatrix(0, C_monto_final_cap) = "monto final"
    gr_cortes.TextMatrix(0, C_resultado_Recompra) = "Resultado Recompra"
    gr_cortes.TextMatrix(0, C_monto_inicial_capta) = "monto inicial"
    gr_cortes.TextMatrix(0, C_capital_Recomprado) = "Capital Recomprado"

    '---jcamposd 20151028 recompra
    

    
    gr_cortes.ColWidth(C_Bloqueo) = 700
    gr_cortes.ColWidth(C_Num_Dcv) = 1200
    gr_cortes.ColWidth(C_MONTO_CORTE) = 1600
    gr_cortes.ColWidth(C_Tasa_Recompra) = 1050
    gr_cortes.ColWidth(C_Interes_Pagar) = 1300
    gr_cortes.ColWidth(C_Valor_A_Pagar) = 1600
    gr_cortes.ColWidth(C_Tipo_Custodia) = 0 '900 -->no se requiere mostrar
    gr_cortes.ColWidth(C_Reajuste_Pagar) = 0
    gr_cortes.ColWidth(C_Clave_Dcv) = 0 ' 900 -->no se requiere mostrar
    gr_cortes.ColWidth(C_Monto_Corte_Org) = 0
    gr_cortes.ColWidth(C_Tasa_Compra_Org) = 0
    gr_cortes.ColWidth(C_Valor_Recompra) = 0 '1600--> valor devengado
    gr_cortes.ColWidth(C_Valor_A_Pagar_Org) = 0
    gr_cortes.ColWidth(C_Interes_Dev) = 1600
    gr_cortes.ColWidth(C_Reajuste_Dev) = 0
    gr_cortes.ColWidth(C_Campo_Venta) = 0
    gr_cortes.ColWidth(C_Correlativo) = 0
    gr_cortes.ColWidth(C_Plazo) = 0
    gr_cortes.ColWidth(C_Check_Interes) = 0
    '+++jcamposd 20151028 recompra
    gr_cortes.ColWidth(C_monto_final_cap) = 0
    gr_cortes.ColWidth(C_resultado_Recompra) = 1300
    gr_cortes.ColWidth(C_monto_inicial_capta) = 0
    gr_cortes.ColWidth(C_capital_Recomprado) = 0
    '---jcamposd 20151028 recompra
    
    gr_cortes.Refresh

End Sub

Private Sub Proc_Limpia_Pantalla()
    Dim i%

    'UfCalculoPantalla = 0
    Msk_Tasa.text = 0 '"" -->jcamposd
    Msk_Tasa.Tag = 0    '"" -->jcamposd

    IntNumoper.text = 0
    IntNumoper.Enabled = True

    Txt_Dias.text = 0
    Txt_Dias.Tag = 0

    Flt_TasaTran.text = 0
    Flt_TasaTran.Tag = 0

    Cmb_Moneda.ListIndex = 0
    For i% = 0 To Cmb_Moneda.ListCount - 1
        If Mid(Cmb_Moneda.List(i%), 1, 1) = "C" Then
            Cmb_Moneda.ListIndex = i%
            Exit For
        End If
    Next i%
    
    TxtCarteraSel.text = 0
    TxtCartera.text = 0
        
    '+++jcamposd
    TXTN_montoS_UF.Visible = False
    TXTN_montoS_UF.text = 0
    Lbl_montoS_UF.Visible = False
    '---jcamposd
        
    Msk_Fecha_Vcto.text = Format(gsBac_Fecp, "dd/mm/yyyy")
    
    Call PROC_CREA_GRILLA
   
End Sub

Private Sub Ayuda_Click()
    BacAyuda.Tag = "MDCAP"
    BacAyuda.Show 1
    
    If giAceptar% = True Then
        IntNumoper.text = gsrut$
        SendKeys "{TAB}"
        Call IntNumoper_KeyPress(13)
    Else
        IntNumoper.SelLength = Len(IntNumoper.text)
        If IntNumoper.Enabled = True Then
            IntNumoper.SetFocus
        End If
    End If
End Sub

Private Sub Cmb_Custodia_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
       Cmb_Tipo_Deposito.SetFocus
    End If
End Sub

Private Sub Cmb_Moneda_Change()
    Mon = Cmb_Moneda.ListIndex
End Sub


Private Sub Cmb_Moneda_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      KeyAscii = 0
      Bac_SendKey vbKeyTab
      Cmb_Moneda.Tag = Cmb_Moneda.text
   End If
End Sub

Private Sub Cmb_Tipo_Deposito_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      KeyAscii = 0
      Bac_SendKey vbKeyTab
   End If
End Sub

Private Sub CmbCondicion_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      KeyAscii = 0
      Bac_SendKey vbKeyTab
   End If
End Sub

Private Sub Cmd_DesMarcar_Click()
    Dim i As Integer

    gr_cortes.Redraw = False
    
    TxtCarteraSel.text = CDbl(0)
    For i = 1 To gr_cortes.Rows - 1
        If gr_cortes.TextMatrix(i, C_Campo_Venta) = "X" Then
            gr_cortes.TextMatrix(i, C_MONTO_CORTE) = gr_cortes.TextMatrix(i, C_Monto_Corte_Org)
            gr_cortes.TextMatrix(i, C_Tasa_Recompra) = gr_cortes.TextMatrix(i, C_Tasa_Compra_Org)
            gr_cortes.TextMatrix(i, C_Valor_A_Pagar) = gr_cortes.TextMatrix(i, C_Valor_A_Pagar_Org)
            gr_cortes.TextMatrix(i, C_Interes_Pagar) = gr_cortes.TextMatrix(i, C_Interes_Dev)
            gr_cortes.TextMatrix(i, C_Reajuste_Pagar) = gr_cortes.TextMatrix(i, C_Reajuste_Dev)
            gr_cortes.TextMatrix(i, C_Bloqueo) = ""
            gr_cortes.TextMatrix(i, C_Campo_Venta) = ""
            gr_cortes.TextMatrix(i, C_Check_Interes) = ""
            Call Colores_Marca(i)
        End If
    Next i
    gr_cortes.Redraw = True
    gr_cortes.SetFocus
    
    gr_cortes.Redraw = False
    'recalcula
    TxtCartera.text = 0
    For i = 1 To gr_cortes.Rows - 1
        TxtCartera.text = CDbl(TxtCartera.text) + CDbl(gr_cortes.TextMatrix(i, C_Valor_A_Pagar))
    Next i
    gr_cortes.Redraw = True
    gr_cortes.SetFocus
    
    
    If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 998 Then
        gr_cortes.Redraw = False
        TXTN_montoS_UF.text = CDbl(0)
        For i = 1 To gr_cortes.Rows - 1
            TXTN_montoS_UF.text = CDbl(TXTN_montoS_UF.text) + IIf(gr_cortes.TextMatrix(i, C_Campo_Venta) = "X", Round((CDbl(gr_cortes.TextMatrix(i, C_Valor_A_Pagar) * UfCalculoPantalla)), 0), 0)
        Next i
        gr_cortes.Redraw = True
        gr_cortes.SetFocus
    End If
    
End Sub

Private Sub Cmd_Marcar_Click()
Dim i As Integer

TxtCartera.text = 0
gr_cortes.Redraw = False
    TxtCarteraSel.text = CDbl(0)
    For i = 1 To gr_cortes.Rows - 1
        gr_cortes.TextMatrix(i, C_MONTO_CORTE) = gr_cortes.TextMatrix(i, C_Monto_Corte_Org)
        gr_cortes.TextMatrix(i, C_Tasa_Recompra) = gr_cortes.TextMatrix(i, C_Tasa_Compra_Org)
        gr_cortes.TextMatrix(i, C_Valor_A_Pagar) = gr_cortes.TextMatrix(i, C_Valor_A_Pagar_Org)
        gr_cortes.TextMatrix(i, C_Interes_Pagar) = gr_cortes.TextMatrix(i, C_Interes_Dev)
        gr_cortes.TextMatrix(i, C_Reajuste_Pagar) = gr_cortes.TextMatrix(i, C_Reajuste_Dev)
        gr_cortes.TextMatrix(i, C_Bloqueo) = "V"
        gr_cortes.TextMatrix(i, C_Campo_Venta) = "X"
        'Call Calculo_Interes(nRow)
        Call Colores_Marca(i)
        
        'recalcula
        TxtCartera.text = CDbl(TxtCartera.text) + CDbl(gr_cortes.TextMatrix(i, C_Valor_A_Pagar))
        
        TxtCarteraSel.text = CDbl(TxtCarteraSel.text) + CDbl(gr_cortes.TextMatrix(i, C_Valor_A_Pagar))
 
        If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 998 Then
            TXTN_montoS_UF.text = CDbl(0)
        'For nRow = 1 To gr_cortes.Rows - 1
            TXTN_montoS_UF.text = CDbl(TXTN_montoS_UF.text) + IIf(gr_cortes.TextMatrix(i, C_Campo_Venta) = "X", Round((CDbl(gr_cortes.TextMatrix(i, C_Valor_A_Pagar) * UfCalculoPantalla)), 0), 0)
        'Next nRow
        End If
        
        
        
    Next i
gr_cortes.Redraw = True
gr_cortes.SetFocus
End Sub

Private Sub Flt_Tasatran_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      KeyAscii = 0
      Bac_SendKey vbKeyTab
   End If
End Sub

Private Sub Form_Activate()

    Numero_RIC = Val(IntNumoper.text)
    Tipo_Operacion = "RI"

    IntNumoper.SelLength = Len(IntNumoper.text)
    If IntNumoper.Enabled = True Then
        IntNumoper.SetFocus
    End If

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub Form_Load()
    bControl = False

    Me.Left = 0:    Me.Top = 0
   'BacIrfGr.proTipoCp = "RIC"  '-> Se utiliza para el combo de Tipo de Pago mañana
   
   'Graba_RIC = True
   'Numero_RIC = 0

Screen.MousePointer = vbHourglass

    gr_cortes.ColWidth(0) = 0

    If Not funcFindMoneda(Cmb_Moneda, "IC") Then
        Exit Sub
    End If

    Cmb_Tipo_Deposito.Clear
    Cmb_Tipo_Deposito.AddItem "RENOVABLE":  Cmb_Tipo_Deposito.ItemData(Cmb_Tipo_Deposito.NewIndex) = 0
    Cmb_Tipo_Deposito.AddItem "FIJO":       Cmb_Tipo_Deposito.ItemData(Cmb_Tipo_Deposito.NewIndex) = 1
    If Cmb_Tipo_Deposito.ListCount > 0 Then
        Cmb_Tipo_Deposito.ListIndex = 0
    End If

    Cmb_Custodia.Clear
    Cmb_Custodia.AddItem "PROPIA":          Let Cmb_Custodia.ItemData(Cmb_Custodia.NewIndex) = 1
    Cmb_Custodia.AddItem "CLIENTE":         Let Cmb_Custodia.ItemData(Cmb_Custodia.NewIndex) = 2
    Cmb_Custodia.AddItem "DCV":             Let Cmb_Custodia.ItemData(Cmb_Custodia.NewIndex) = 2
    If Cmb_Custodia.ListCount > 0 Then
        Cmb_Custodia.ListIndex = 0
    End If

    Call Fx_Load_Data("CONDICION", Me.CmbCondicion)
       'Call objCondicion.CargaSucursal("CONDICION")
       'Call objCondicion.Coleccion2Control(CmbCondicion)
    If CmbCondicion.ListCount > 0 Then
        CmbCondicion.ListIndex = 0
    End If

    Call Fx_Load_Data("DEPOSITO", Me.CmbTipo_Emision)
       'Call objCondicion.CargaSucursal("DEPOSITO")
       'Call objCondicion.Coleccion2Control(CmbTipo_Emision)
    If CmbTipo_Emision.ListCount > 0 Then
        CmbTipo_Emision.ListIndex = 0
    End If

Screen.MousePointer = vbDefault

    bControl = True

    Cmb_Moneda.Tag = Cmb_Moneda.text
    Txt_Dias.Tag = Txt_Dias.text

    Msk_Tasa.Tag = Msk_Tasa.text
    Msk_Tasa.Enabled = True

    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = False

    TXTN_montoS_UF.Visible = False
    Lbl_montoS_UF.Visible = False
    
    Call bloquea_controles
    Call Proc_Limpia_Pantalla
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Graba_RIC = False
    Numero_RIC = 0
End Sub

Private Sub Gr_Cortes_DblClick()
Dim X   As Integer

    If gr_cortes.Row > gr_cortes.FixedRows - 1 Then
        If gr_cortes.Col = C_Tipo_Custodia Then
            For X = 0 To Combo1.ListCount - 1
                Combo1.ListIndex = X
                If Combo1 = gr_cortes.TextMatrix(gr_cortes.RowSel, gr_cortes.ColSel) Then
                    Exit For
                End If
            Next
            Combo1.Visible = True
            Combo1.SetFocus
        End If
    End If
End Sub

Private Sub Gr_Cortes_KeyPress(KeyAscii As Integer)
Dim nRow  As Integer
Dim nCol  As Integer

nRow = gr_cortes.Row
nCol = gr_cortes.Col
        
If nRow > gr_cortes.FixedRows - 1 And UCase(Chr(KeyAscii)) <> "*" Then
    If nCol = C_Tipo_Custodia And (UCase(Chr(KeyAscii)) = "F" Or UCase(Chr(KeyAscii)) = "D" Or KeyAscii = 13) Then
         Call PROC_POSI_TEXTO(gr_cortes, Combo1)
         Combo1.Visible = True
         Combo1.SetFocus
    End If
    
    If nCol = C_Clave_Dcv Then
        If gr_cortes.TextMatrix(nRow, C_Tipo_Custodia) = "DCV" Then
           Text2.text = gr_cortes.TextMatrix(nRow, C_Clave_Dcv)
           Text2.Visible = True
           Text2.MaxLength = 9
           
           If KeyAscii <> 13 Then
              Text2.text = UCase(Chr(KeyAscii))
           Else
              Text2.text = gr_cortes.TextMatrix(nRow, C_Clave_Dcv)
           End If
           Text2.SetFocus
        End If
    End If
      
    If UCase(Chr(KeyAscii)) = "R" Then 'RESTAURAR
        If gr_cortes.TextMatrix(nRow, C_Campo_Venta) = "X" Then
            gr_cortes.TextMatrix(nRow, C_MONTO_CORTE) = gr_cortes.TextMatrix(nRow, C_Monto_Corte_Org)
            gr_cortes.TextMatrix(nRow, C_Tasa_Recompra) = gr_cortes.TextMatrix(nRow, C_Tasa_Compra_Org)
            gr_cortes.TextMatrix(nRow, C_Valor_A_Pagar) = gr_cortes.TextMatrix(nRow, C_Valor_A_Pagar_Org)
            gr_cortes.TextMatrix(nRow, C_Valor_Recompra) = gr_cortes.TextMatrix(nRow, C_Valor_A_Pagar_Org)
            gr_cortes.TextMatrix(nRow, C_Interes_Pagar) = gr_cortes.TextMatrix(nRow, C_Interes_Dev)
            gr_cortes.TextMatrix(nRow, C_Reajuste_Pagar) = gr_cortes.TextMatrix(nRow, C_Reajuste_Dev)
            gr_cortes.TextMatrix(nRow, C_Bloqueo) = ""
            gr_cortes.TextMatrix(nRow, C_Campo_Venta) = ""
            gr_cortes.TextMatrix(nRow, C_Check_Interes) = ""

            Call Colores_Marca(nRow)
        End If
        gr_cortes.Row = nRow
        gr_cortes.Col = nCol
        gr_cortes.SetFocus
    End If
    
    If UCase(Chr(KeyAscii)) = "V" Then 'VENDER COMPLETOS, CHURRASCOS
        nRow = gr_cortes.Row
        gr_cortes.TextMatrix(nRow, C_Bloqueo) = "V"
        gr_cortes.TextMatrix(nRow, C_Campo_Venta) = "X"
        Call Calculo_Interes(nRow)
        gr_cortes.Row = nRow
        gr_cortes.Col = nCol
        gr_cortes.SetFocus
    End If
    
     If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 999 Then
            TxtCarteraSel.CantidadDecimales = 0
            TxtCarteraSel.Max = 99999999999#
            TxtCartera.CantidadDecimales = 0
            TxtCartera.Max = 99999999999#
            
        ElseIf Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 998 Then
            TxtCarteraSel.CantidadDecimales = 4
            TxtCarteraSel.Max = 99999999999.9999
            TxtCartera.CantidadDecimales = 4
            TxtCartera.Max = 99999999999.9999
        Else
            TxtCarteraSel.CantidadDecimales = 2
            TxtCarteraSel.Max = 99999999999.99
            TxtCartera.CantidadDecimales = 2
            TxtCartera.Max = 99999999999.99
        End If
        
    
    
    
    If IsNumeric(Chr(KeyAscii)) Or KeyAscii = 13 Then
    
        If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 999 Then
            TxtFung.CantidadDecimales = 0
            TxtFung.Max = 99999999999#
        ElseIf Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 998 Then
            TxtFung.CantidadDecimales = 4
            TxtFung.Max = 99999999999.9999
        Else
            TxtFung.CantidadDecimales = 2
            TxtFung.Max = 99999999999.99
        End If
    
        
        Select Case nCol
        Case C_MONTO_CORTE
            If KeyAscii = 13 Then TxtFung.text = CDbl(gr_cortes.TextMatrix(nRow, nCol))
            Call PROC_POSI_TEXTO(gr_cortes, TxtFung)
            TxtFung.text = Chr(KeyAscii) 'CDbl(gr_cortes.text)
            TxtFung.Visible = True
            TxtFung.SetFocus
            SendKeys "{RIGHT}"
                     
        Case C_Tasa_Recompra
            TxtFung.CantidadDecimales = 6
            TxtFung.Max = 999999999.999999
            If KeyAscii = 13 Then TxtFung.text = CDbl(gr_cortes.TextMatrix(nRow, nCol))
            Call PROC_POSI_TEXTO(gr_cortes, TxtFung)
            TxtFung.text = Chr(KeyAscii)
            TxtFung.Visible = True
            TxtFung.SetFocus
            SendKeys "{RIGHT}"
            
        Case C_Interes_Pagar
            If KeyAscii = 13 Then
                If gr_cortes.TextMatrix(nRow, nCol) = "" Then
                    TxtFung.text = 1
                Else
                    TxtFung.text = CDbl(gr_cortes.TextMatrix(nRow, nCol))
                End If
            End If
            Call PROC_POSI_TEXTO(gr_cortes, TxtFung)
            TxtFung.text = Chr(KeyAscii)
            TxtFung.Visible = True
            TxtFung.SetFocus
            SendKeys "{RIGHT}"
            
        Case C_Reajuste_Pagar
            TxtFung.CantidadDecimales = 0
            TxtFung.Max = 99999999999#
            TxtFung.Min = -99999999999#
            If KeyAscii = 13 Then
                If gr_cortes.TextMatrix(nRow, nCol) = "" Then
                    TxtFung.text = 1
                Else
                    TxtFung.text = CDbl(gr_cortes.TextMatrix(nRow, nCol))
                End If
            End If
            Call PROC_POSI_TEXTO(gr_cortes, TxtFung)
            TxtFung.text = Chr(KeyAscii)
            TxtFung.Visible = True
            TxtFung.SetFocus
            SendKeys "{RIGHT}"
            
        Case C_Valor_A_Pagar
        
            TxtFung.CantidadDecimales = 0
            TxtFung.Max = 99999999999#
            
            If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 998 Then
                TxtFung.CantidadDecimales = 4
                TxtFung.Max = 999999999.9999
            
            ElseIf Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) <> 999 And Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) <> 998 Then
                TxtFung.CantidadDecimales = 2
                TxtFung.Max = 99999999999.99
            End If

            If KeyAscii = 13 Then
                If CDbl(gr_cortes.TextMatrix(nRow, nCol)) Then
                    TxtFung.text = 1
                Else
                    TxtFung.text = CDbl(gr_cortes.TextMatrix(nRow, nCol))
                End If
            End If
            Call PROC_POSI_TEXTO(gr_cortes, TxtFung)
            TxtFung.text = Chr(KeyAscii)
            TxtFung.Visible = True
            TxtFung.SetFocus
            SendKeys "{RIGHT}"
        End Select
    Else
        KeyAscii = 0
    End If
Else
    KeyAscii = 0
End If
'SendKeys "{END}"
    TxtCartera.text = 0
    For nRow = 1 To gr_cortes.Rows - 1
        TxtCartera.text = CDbl(TxtCartera.text) + CDbl(gr_cortes.TextMatrix(nRow, C_Valor_A_Pagar))
    Next nRow
    
    TxtCarteraSel.text = CDbl(0)
    For nRow = 1 To gr_cortes.Rows - 1
        TxtCarteraSel.text = CDbl(TxtCarteraSel.text) + IIf(gr_cortes.TextMatrix(nRow, C_Campo_Venta) = "X", CDbl(gr_cortes.TextMatrix(nRow, C_Valor_A_Pagar)), 0)
    Next nRow
    
    If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 998 Then
        TXTN_montoS_UF.text = CDbl(0)
        For nRow = 1 To gr_cortes.Rows - 1
            TXTN_montoS_UF.text = CDbl(TXTN_montoS_UF.text) + IIf(gr_cortes.TextMatrix(nRow, C_Campo_Venta) = "X", Round((CDbl(gr_cortes.TextMatrix(nRow, C_Valor_A_Pagar) * UfCalculoPantalla)), 0), 0)
        Next nRow
    End If
    
End Sub

Private Sub gr_cortes_LeaveCell()

   If gr_cortes.Row <> 0 And gr_cortes.Col > 1 Then
       If gr_cortes.TextMatrix(gr_cortes.Row, C_Bloqueo) = "V" Then
            gr_cortes.CellBackColor = vbBlue
            gr_cortes.CellForeColor = vbWhite
        ElseIf gr_cortes.TextMatrix(gr_cortes.Row, C_Bloqueo) = "P" Then
            gr_cortes.CellBackColor = vbCyan
            gr_cortes.CellForeColor = vbBlack
        ElseIf gr_cortes.TextMatrix(gr_cortes.Row, C_Bloqueo) = "*" Then
            gr_cortes.CellBackColor = vbGreen + vbWhite    'vbBlack
            gr_cortes.CellForeColor = vbWhite
        Else
            gr_cortes.CellBackColor = &H80000004
            gr_cortes.CellForeColor = &H800000
        End If
    End If

End Sub

Private Sub Gr_Cortes_RowColChange()
    gr_cortes.CellBackColor = &H808000
    gr_cortes.CellForeColor = vbWhite
End Sub

Private Sub IntNumoper_DblClick()
    Call Ayuda_Click
End Sub

Private Sub bloquea_controles()

    Msk_Tasa.Enabled = False
    Cmb_Moneda.Enabled = True
    Txt_Dias.Enabled = False
    Msk_Fecha_Vcto.Enabled = True
    Flt_TasaTran.Enabled = False
    Cmb_Custodia.Enabled = False
    Cmb_Tipo_Deposito.Enabled = False
    CmbCondicion.Enabled = False
    CmbTipo_Emision.Enabled = False

End Sub

Private Function Verifica_Nro_DCV() As Boolean
Dim nRow As Integer

    Verifica_Nro_DCV = False
    For nRow = 2 To gr_cortes.Rows - 1
        If gr_cortes.TextMatrix(nRow, C_Campo_Venta) = "X" Then
            If Val(gr_cortes.TextMatrix(nRow, C_Num_Dcv)) = 0 Then
                MsgBox "Numero certificado DCV no ha sido cargado para esta operación ", vbExclamation, gsBac_Version
                Exit Function
            End If
        End If
    Next nRow
    Verifica_Nro_DCV = True
    
End Function

Private Sub IntNumoper_KeyPress(KeyAscii As Integer)
   
    If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 13 And KeyAscii <> 8 Then
        KeyAscii = 0
        Exit Sub
    End If

    Select Case KeyAscii
        Case 27
            gr_cortes.SetFocus
        
        Case 13
            SendKeys "{TAB}"
            
            If Val(IntNumoper.text) <> 0 Then
                MousePointer = 11

                If IntNumoper.text = 0 Or IntNumoper.text = "" Then
                    MsgBox "Debe ingresar número de operación.", vbExclamation, Me.Caption
                Else
                    If BuscaDatos_Rc(IntNumoper.text) Then
                        IntNumoper.Enabled = False
                        Cmb_Moneda.Enabled = False
                        Msk_Fecha_Vcto.Enabled = False
                        Toolbar1.Buttons(2).Enabled = True
                        Toolbar1.Buttons(3).Enabled = True
                        MousePointer = 0
                    Else
                        MousePointer = 0
                        Exit Sub
                    End If
                End If
            End If
    End Select

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case UCase(Button.Description)
        Case "GRABAR"
            
            Call TOOLGRABAR
            
            Msk_Tasa.Tag = 0 '""-->jcamposd
            Cmb_Moneda.Tag = Cmb_Moneda.text
            Txt_Dias.Tag = Txt_Dias.text

        Case "LIMPIAR"
            
            Call TOOLLIMPIAR
        
        Case "SALIR"
            Unload Me
    
    End Select
End Sub

Private Function TOOLLIMPIAR()
    Proc_Limpia_Pantalla
    Call bloquea_controles
    IntNumoper.SelLength = Len(IntNumoper.text)
    IntNumoper.SetFocus
End Function

Private Function TOOLGRABAR()
    Dim cString                 As String
    Dim i                       As Integer
    Dim VecAux()
    Dim cSaltoLinea, cMsgErr    As String

    cSaltoLinea = Chr(13) + Chr(10)

    '''''    If Not Verifica_Nro_DCV() Then Exit Function
    '+++jcamposd 20161013 a solicitud de VGonzalez no debe validar
    'If Not Verifica_Venta_Corte() Then Exit Function
    'If Not Verifica_Exceso_Venta() Then Exit Function
    '---jcamposd 20161013 a solicitud de VGonzalez no debe validar

    BacIrfGr.proMtoOper = CDbl(TxtCarteraSel.text)
    BacIrfGr.proHwnd = hWnd
    BacIrfGr.proMoneda = Trim$(Mid$(Cmb_Moneda.text, 1, 3))
    BacIrfGr.proCodMoneda = Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)

    '''''    Autorizacion_Grabacion = False
    '''''    Autorizado_Operacion = False
    '''''    Datos_Error = Array()
    '''''
    '''''    If Not Valida_Limites_Trader(gsSistema, "IC", Txt_Dias.Text, gsUsuario, (CDbl(TxtCarteraSel.Text) / IIf(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 13, 1, USD_DIA)), 0) Then
    '''''    '   Exit Function
    '''''    ElseIf Not Autorizado Then
    '''''    '   Exit Function
    '''''    End If
    '''''
    '''''    cString = ""
    '''''
    '''''    For I = 0 To UBound(Datos_Error())
    '''''        VecAux = Array()
    '''''        VecAux = Datos_Error(I)
    '''''        cString = cString & Trim(VecAux(0)) + Space(10 - Len(Trim(VecAux(0)))) & "    "
    '''''        cString = cString & RELLENA_STRING(Format(VecAux(1), "#,##0.00"), "I", 19) & "  "
    '''''        cString = cString & RELLENA_STRING(Format(VecAux(2), "#,##0.00"), "I", 19) & "  "
    '''''        cString = cString & RELLENA_STRING(Format(VecAux(3), "#,##0"), "I", 6) & cSaltoLinea
    '''''    Next I
    '''''
    '''''    If cString <> "" Then
    '''''        If Not Usuario_limite Then
    '''''            cMsgErr = "El Usuario " & gsUsuario & " NO tiene Monto de Linea disponible " & cSaltoLinea & cSaltoLinea & cSaltoLinea
    '''''        Else
    '''''            cMsgErr = "El Usuario " & gsUsuario & " esta excedido en los siguientes Límites " & cSaltoLinea & cSaltoLinea & cSaltoLinea
    '''''        End If
    '''''        BacErrores.Text1.Text = cMsgErr & _
    '''''                                "Instrumento  Límite US$           Monto US$            Plazo  " & cSaltoLinea & _
    '''''                                "===========  ==================== ==================== =======" & cSaltoLinea & _
    '''''                       cString
    '''''        BacErrores.Show vbModal
    '''''        If Not Autorizado Then
    '''''            Exit Function
    '''''        End If
    '''''    End If

    Call BacGrabarTX

    If Grabacion_Operacion = True Then
      Call Proc_Limpia_Pantalla
    End If

End Function

Private Function RELLENA_STRING(Dato As String, Pos As String, Largo As Integer) As String
'rellena con blancos y completa el largo requerido

If Trim(Pos$) = "" Then Pos$ = "I"

If Largo < Len(Trim(Dato)) Then
   RELLENA_STRING = Mid(Trim(Dato), 1, Largo)
   Exit Function
End If

If Mid(Pos$, 1, 1) = "I" Then 'IZQUIERDA
   RELLENA_STRING = String(Largo - Len(Trim(Dato)), " ") + Trim(Dato)
Else                          'DERECHA
   RELLENA_STRING = Trim(Dato) + String(Largo - Len(Trim(Dato)), " ")
End If

RELLENA_STRING = Mid(RELLENA_STRING, 1, Largo)

End Function

Private Sub Calculo_Interes_Inicial(Row As Integer)
Dim nBase       As Double
Dim nValmon     As Double
Dim nValorUFI   As Double
Dim nDias       As Integer
Dim nInteres    As Double
Dim nMtoCorte   As Double
Dim nTasa       As Double
Dim nReajuste   As Double
'+++jcamposd recalculo
Dim valorRecompra As Double
Dim capitalRecomprado As Double
Dim nInteresDevengado As Double
'---jcamposd recalculo
    
    nBase = BaseCalculo()
    If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 999 Then
        nBase = 30
    End If
    nValmon = FUNC_BUSCA_VALOR_MONEDA(IIf(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 13, 999, Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)), Format(gsBac_Fecp, "DD/MM/YYYY"))
    nValorUFI = FUNC_BUSCA_VALOR_MONEDA(IIf(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 13, 999, Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)), TxtFechaIni.text)
    
    
    UfCalculoPantalla = gsValor_UF
    
    nDias = Val(Txt_Dias.text) - Val(DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text))
    nMtoCorte = CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE))
    nTasa = CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra))
    
    '+++jcamposd recalculo dap valor nominal es el monto del corte
    'nMtoCorte = (CDbl(gr_cortes.TextMatrix(Row, C_monto_final_cap)) / ((1 + CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) * (Val(DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text)) / (nBase * 100)))))
    
    valorRecompra = Round((CDbl(gr_cortes.TextMatrix(Row, C_monto_final_cap)) / ((1 + CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) * (Val(DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text)) / (nBase * 100))))), 4)
    'prueba reemplazo
    'valorRecompra = ((CDbl(gr_cortes.TextMatrix(Row, C_monto_final_cap)) / (1 + ((Val(DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text)) / 30) * (CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) / 100)))))
    
    
    '+++jcamposd 20161020 no se debe recalcular al inicio, según solicitud usuario
    'capitalRecomprado = (CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE)) / ((1 + CDbl(Msk_Tasa.text) * (Val(Txt_Dias.text) / (nBase * 100)))))
    capitalRecomprado = CDbl(gr_cortes.TextMatrix(Row, C_monto_inicial_capta))
    '---jcamposd 20161020 no se debe recalcular al inicio
    
    'prueba reemplazo
    'capitalRecomprado = ((CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE))) / (1 + ((CDbl(Msk_Tasa.text) / 100) * (Val(Txt_Dias.text) / 30))))
    
    gr_cortes.TextMatrix(Row, C_capital_Recomprado) = Format(CDbl(capitalRecomprado), nDecInteres)
    '---jcamposd recalculo dap
    
    
    
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ' Reajuste Recompra
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    nReajuste = Round((nValmon - nValorUFI) * nMtoCorte, 0) ' / CDbl(Txt_Dias.text) * nDias
    gr_cortes.TextMatrix(Row, C_Reajuste_Pagar) = Format$(nReajuste, cFormato) '-->nDecimales
    
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ' Interes Recompra
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    '+++jcamposd recalculo
    'nInteres = Round(nMtoCorte * ((nTasa / (nBase * 100)) * nDias + 1#), 4)
    'gr_cortes.TextMatrix(Row, C_Interes_Pagar) = Format(nInteres - nMtoCorte, nDecInteres)
    'nInteres = Round(CDbl(gr_cortes.TextMatrix(Row, C_monto_inicial_capta)) * ((nTasa / (nBase * 100)) * Val(DateDiff("d", TxtFechaIni.text, Msk_Fecha_Vcto.text)) + 1#), 4)
    gr_cortes.TextMatrix(Row, C_Interes_Pagar) = Format(valorRecompra - capitalRecomprado, cFormato) '-->nDecimales
    '---jcamposd recalculo
    
    
    
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ' Valores Recompra Captacion
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 998 Then
        nInteres = Round((nInteres - nMtoCorte) * nValmon, 0) 'Llevar a CLP
        nMtoCorte = Round(nMtoCorte * nValorUFI, 0)           'Llevar a CLP
        nMtoCorte = nMtoCorte + nInteres + nReajuste
    Else
        nMtoCorte = nInteres * nValorUFI            'Llevar a CLP
        nMtoCorte = nMtoCorte + nReajuste
    End If
    
    '+++jcamposd recalculo
    'gr_cortes.TextMatrix(Row, C_Valor_A_Pagar) = Format(nMtoCorte, nDecimales)
    'gr_cortes.TextMatrix(Row, C_Valor_A_Pagar_Org) = Format(nMtoCorte, nDecimales)'-->nDecimales
    gr_cortes.TextMatrix(Row, C_Valor_A_Pagar) = Format(valorRecompra, cFormato)
    gr_cortes.TextMatrix(Row, C_Valor_A_Pagar_Org) = Format(valorRecompra, cFormato) '-->nDecimales
    'gr_cortes.TextMatrix(Row, C_Valor_Recompra) = Format(nMtoCorte, nDecimales) --> no aplica
    '---jcamposd recalculo
    
    '+++jcamposd recalculo
    'gr_cortes.TextMatrix(Row, C_Interes_Dev) = gr_cortes.TextMatrix(Row, C_Interes_Pagar)
    
    
    nInteresDevengado = Round(CDbl(capitalRecomprado) * ((CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) * Val(nDias)) / (nBase * 100)), 4)
    'prueba reemplazo
    'nInteresDevengado = Round(CDbl(capitalRecomprado) * ((CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) * Val(nDias)) / 3000), 4)
    
    'gr_cortes.TextMatrix(Row, C_Interes_Dev) = gr_cortes.TextMatrix(Row, C_Interes_Pagar)
    gr_cortes.TextMatrix(Row, C_Interes_Dev) = Format(nInteresDevengado, cFormato) '-->nDecimales
    gr_cortes.TextMatrix(Row, C_resultado_Recompra) = Format(nInteresDevengado - gr_cortes.TextMatrix(Row, C_Interes_Pagar), cFormato) '-->nDecimales
    '---jcamposd recalculo
    gr_cortes.TextMatrix(Row, C_Reajuste_Dev) = gr_cortes.TextMatrix(Row, C_Reajuste_Pagar)
    
    
    '+++jcamposd 20140109, no las debe marcar al inicio
    'gr_cortes.TextMatrix(Row, C_Bloqueo) = "V"
        If gr_cortes.TextMatrix(Row, C_Campo_Venta) = "X" Then
            gr_cortes.TextMatrix(Row, C_MONTO_CORTE) = gr_cortes.TextMatrix(Row, C_Monto_Corte_Org)
            gr_cortes.TextMatrix(Row, C_Tasa_Recompra) = gr_cortes.TextMatrix(Row, C_Tasa_Compra_Org)
            gr_cortes.TextMatrix(Row, C_Valor_A_Pagar) = gr_cortes.TextMatrix(Row, C_Valor_A_Pagar_Org)
            gr_cortes.TextMatrix(Row, C_Valor_Recompra) = gr_cortes.TextMatrix(Row, C_Valor_A_Pagar_Org)
            gr_cortes.TextMatrix(Row, C_Interes_Pagar) = gr_cortes.TextMatrix(Row, C_Interes_Dev)
            gr_cortes.TextMatrix(Row, C_Reajuste_Pagar) = gr_cortes.TextMatrix(Row, C_Reajuste_Dev)
            gr_cortes.TextMatrix(Row, C_Bloqueo) = ""
            gr_cortes.TextMatrix(Row, C_Campo_Venta) = ""
            gr_cortes.TextMatrix(Row, C_Check_Interes) = ""

            'gr_cortes.TextMatrix(Row, C_Campo_Venta) = "X"
            Call Colores_Marca(Row)
            TxtCarteraSel.text = 0
            TXTN_montoS_UF.text = 0
        End If
    '---jcamposd 20140109, no las debe marcar al inicio
    
End Sub
Private Sub Calculo_Interes_Reajustes(Row As Integer)
Dim nBase       As Double
Dim nValmon     As Double
Dim nValorUFI   As Double
Dim nDias       As Integer
Dim nInteres    As Double
Dim nMtoCorte   As Double
Dim nTasa       As Double
Dim nReajuste   As Double
'+++jcamposd recalculo
Dim valorRecompra As Double
Dim capitalRecomprado As Double
Dim nInteresDevengado As Double
'---jcamposd recalculo

    nBase = BaseCalculo()
    If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 999 Then
        nBase = 30
    End If
    
    nValmon = FUNC_BUSCA_VALOR_MONEDA(IIf(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 13, 999, Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)), Format(gsBac_Fecp, "DD/MM/YYYY"))
    nValorUFI = FUNC_BUSCA_VALOR_MONEDA(IIf(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 13, 999, Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)), TxtFechaIni.text)
    
    nDias = Val(gr_cortes.TextMatrix(Row, C_Plazo))
    nMtoCorte = CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE))
    '+++jcamposd recalculo dap valor nominal es el monto del corte
    If CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE)) = CDbl(gr_cortes.TextMatrix(Row, C_Monto_Corte_Org)) Then
        valorRecompra = (CDbl(gr_cortes.TextMatrix(Row, C_monto_final_cap)) / ((1 + CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) * (Val(DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text)) / (nBase * 100)))))
        'prueba reemplazo
        'valorRecompra = ((CDbl(gr_cortes.TextMatrix(Row, C_monto_final_cap)) / (1 + ((Val(DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text)) / 30) * (CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) / 100)))))

    Else
        valorRecompra = (CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE)) / ((1 + CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) * (Val(DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text)) / (nBase * 100)))))
        'prueba reemplazo
        'valorRecompra = ((CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE)) / (1 + ((Val(DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text)) / 30) * (CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) / 100)))))

    End If
    
    '+++jcamposd 20161020 no se debe recalcular al inicio, según solicitud usuario
    If CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE)) = CDbl(gr_cortes.TextMatrix(Row, C_Monto_Corte_Org)) Then
        capitalRecomprado = CDbl(gr_cortes.TextMatrix(Row, C_monto_inicial_capta))
    Else
        capitalRecomprado = (CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE)) / ((1 + CDbl(Msk_Tasa.text) * (Val(Txt_Dias.text) / (nBase * 100)))))
    End If
    '---jcamposd 20161020 no se debe recalcular al inicio, según solicitud usuario
    
    'prueba reemplazo
    'capitalRecomprado = ((CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE))) / (1 + ((CDbl(Msk_Tasa.text) / 100) * (Val(Txt_Dias.text) / 30))))

    
    gr_cortes.TextMatrix(Row, C_capital_Recomprado) = Format(CDbl(capitalRecomprado), nDecInteres)
    '---jcamposd recalculo dap
    
    
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ' Reajuste Recompra
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    nReajuste = CDbl(gr_cortes.TextMatrix(Row, C_Reajuste_Pagar))
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ' Interes Recompra
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    nTasa = CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra))
    '+++jcamposd recalculo
    'nInteres = Round(nMtoCorte * ((nTasa / (nBase * 100)) * nDias + 1#), 4)
    'gr_cortes.TextMatrix(Row, C_Interes_Pagar) = Format((nInteres - nMtoCorte), nDecInteres)
    gr_cortes.TextMatrix(Row, C_Interes_Pagar) = Format(valorRecompra - capitalRecomprado, nDecInteres)
    '---jcamposd recalculo
    If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 998 Then
        nInteres = Round((nInteres - nMtoCorte) * nValmon, 0) 'Llevar a CLP
        nMtoCorte = Round(nMtoCorte * nValorUFI, 0)           'Llevar a CLP
        nMtoCorte = nMtoCorte + nInteres + nReajuste
    Else
        nMtoCorte = nInteres * nValorUFI
        nMtoCorte = nMtoCorte + nReajuste
    End If
    '+++jcamposd recalculo
    ''gr_cortes.TextMatrix(Row, C_Valor_A_Pagar) = Format(nMtoCorte, nDecimales)
    gr_cortes.TextMatrix(Row, C_Valor_A_Pagar) = Format(valorRecompra, cFormato) '-->nDecimales
    
    '---jcamposd recalculo
    
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ' Interes Devengado
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    nTasa = CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Compra_Org))
    nMtoCorte = CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE))
    nInteres = Round(nMtoCorte * ((nTasa / (nBase * 100)) * nDias + 1#), 4)
    If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 998 Then
        nInteres = Round((nInteres - nMtoCorte) * nValmon, 0) 'Llevar a CLP
        nMtoCorte = Round(nMtoCorte * nValorUFI, 0)           'Llevar a CLP
        nMtoCorte = nMtoCorte + nInteres + nReajuste
    Else
        nMtoCorte = nInteres * nValorUFI
        nMtoCorte = nMtoCorte + nReajuste
    End If
    '+++jcamposd recalculo
    
    nInteresDevengado = Round(CDbl(capitalRecomprado) * ((CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) * Val(nDias)) / (nBase * 100)), 4)
    'Prueba reemplazo
    'nInteresDevengado = Round(CDbl(capitalRecomprado) * ((CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) * Val(nDias)) / 3000), 4)
    
    'gr_cortes.TextMatrix(Row, C_Interes_Dev) = gr_cortes.TextMatrix(Row, C_Interes_Pagar)
    gr_cortes.TextMatrix(Row, C_Interes_Dev) = Format(nInteresDevengado, cFormato)
    gr_cortes.TextMatrix(Row, C_resultado_Recompra) = Format(nInteresDevengado - gr_cortes.TextMatrix(Row, C_Interes_Pagar), nDecimales)
    '---jcamposd recalculo
    gr_cortes.TextMatrix(Row, C_Valor_Recompra) = Format(Round(nMtoCorte, 0), cFormato) '-->nDecimales
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        nMtoCorte = CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE))
        If nMtoCorte <> CDbl(gr_cortes.TextMatrix(Row, C_Monto_Corte_Org)) Then
            gr_cortes.TextMatrix(Row, C_Bloqueo) = "P"
            gr_cortes.TextMatrix(Row, C_Campo_Venta) = "X"
        ElseIf nTasa <> CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Compra_Org)) And nMtoCorte = CDbl(gr_cortes.TextMatrix(Row, C_Monto_Corte_Org)) Then
            gr_cortes.TextMatrix(Row, C_Bloqueo) = "V"
            gr_cortes.TextMatrix(Row, C_Campo_Venta) = "X"
        ElseIf nTasa = CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Compra_Org)) And nMtoCorte = CDbl(gr_cortes.TextMatrix(Row, C_Monto_Corte_Org)) Then
            gr_cortes.TextMatrix(Row, C_Bloqueo) = "V"
            gr_cortes.TextMatrix(Row, C_Campo_Venta) = "X"
        End If
        Call Colores_Marca(Row)
End Sub
Private Sub Calculo_Interes(Row As Integer)
Dim nBase       As Double
Dim nValmon     As Double
Dim nValorUFI   As Double
Dim nDias       As Integer
Dim nInteres    As Double
Dim nMtoCorte   As Double
Dim nTasa       As Double
Dim nReajuste   As Double
'+++jcamposd recalculo
Dim valorRecompra As Double
Dim capitalRecomprado As Double
Dim nInteresDevengado As Double
'---jcamposd recalculo

    nBase = BaseCalculo()
    If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 999 Then
        nBase = 30
    End If
    nValmon = FUNC_BUSCA_VALOR_MONEDA(IIf(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 13, 999, Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)), Format(gsBac_Fecp, "DD/MM/YYYY"))
    nValorUFI = FUNC_BUSCA_VALOR_MONEDA(IIf(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 13, 999, Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)), TxtFechaIni.text)
    
    nDias = Val(gr_cortes.TextMatrix(Row, C_Plazo))
    nMtoCorte = CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE))
    '+++jcamposd recalculo dap valor nominal es el monto del corte
    If CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE)) = CDbl(gr_cortes.TextMatrix(Row, C_Monto_Corte_Org)) Then
        valorRecompra = (CDbl(gr_cortes.TextMatrix(Row, C_monto_final_cap)) / ((1 + CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) * (Val(DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text)) / (nBase * 100)))))
        'prueba reemplazo
        'valorRecompra = ((CDbl(gr_cortes.TextMatrix(Row, C_monto_final_cap)) / (1 + ((Val(DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text)) / 30) * (CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) / 100)))))
    Else
        valorRecompra = (CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE)) / ((1 + CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) * (Val(DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text)) / (nBase * 100)))))
        'prueba reemplazo
        'valorRecompra = ((CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE)) / (1 + ((Val(DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text)) / 30) * (CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) / 100)))))
    End If
    '+++jcamposd 20161020 no se debe recalcular al inicio, según solicitud usuario
    If CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE)) = CDbl(gr_cortes.TextMatrix(Row, C_Monto_Corte_Org)) Then
        capitalRecomprado = CDbl(gr_cortes.TextMatrix(Row, C_monto_inicial_capta))
    Else
        capitalRecomprado = (CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE)) / ((1 + CDbl(Msk_Tasa.text) * (Val(Txt_Dias.text) / (nBase * 100)))))
    End If
    '---jcamposd 20161020 no se debe recalcular al inicio, según solicitud usuario
    
    'prueba reemplazo
    'capitalRecomprado = ((CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE))) / (1 + ((CDbl(Msk_Tasa.text) / 100) * (Val(Txt_Dias.text) / 30))))

    
    gr_cortes.TextMatrix(Row, C_capital_Recomprado) = Format(CDbl(capitalRecomprado), cFormato) '-->nDecimales
    '---jcamposd recalculo dap
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ' Reajuste Recompra
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    nReajuste = Round((nValmon - nValorUFI) * nMtoCorte, 0) ' / CDbl(Txt_Dias.text) * nDias
    gr_cortes.TextMatrix(Row, C_Reajuste_Pagar) = Format$(nReajuste, nDecimales)
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ' Interes Recompra
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    '+++jcamposd recalculo
    'nTasa = CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra))
    'nInteres = Round(nMtoCorte * ((nTasa / (nBase * 100)) * nDias + 1#), 4)
    'gr_cortes.TextMatrix(Row, C_Interes_Pagar) = Format(nInteres - nMtoCorte, nDecInteres)
    gr_cortes.TextMatrix(Row, C_Interes_Pagar) = Format(valorRecompra - capitalRecomprado, cFormato) '-->nDecimales
    '---jcamposd recalculo
    If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 998 Then
        nInteres = Round((nInteres - nMtoCorte) * nValmon, 0) 'Llevar a CLP
        nMtoCorte = Round(nMtoCorte * nValorUFI, 0)           'Llevar a CLP
        nMtoCorte = nMtoCorte + nInteres + nReajuste
    Else
        nMtoCorte = nInteres * nValorUFI
        nInteres = (nInteres - nMtoCorte) * nValmon
        nMtoCorte = nMtoCorte + nReajuste
    End If
    '+++jcamposd recalculo
    ''gr_cortes.TextMatrix(Row, C_Valor_A_Pagar) = Format(nMtoCorte, nDecimales)
    gr_cortes.TextMatrix(Row, C_Valor_A_Pagar) = Format(valorRecompra, cFormato) '-->nDecimales
    '---jcamposd recalculo
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ' Interes Devengado
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    nMtoCorte = CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE))
    nTasa = CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Compra_Org))
    nInteres = Round(nMtoCorte * ((nTasa / (nBase * 100)) * nDias + 1#), 4)
    If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 998 Then
        nInteres = Round((nInteres - nMtoCorte) * nValmon, 0) 'Llevar a CLP
        nMtoCorte = Round(nMtoCorte * nValorUFI, 0)           'Llevar a CLP
        nMtoCorte = nMtoCorte + nInteres + nReajuste
    Else
        nMtoCorte = nInteres * nValorUFI
        nInteres = (nInteres - nMtoCorte) * nValmon
        nMtoCorte = nMtoCorte + nReajuste
    End If
    '+++jcamposd recalculo
    'gr_cortes.TextMatrix(Row, C_Valor_Recompra) = Format(nMtoCorte, nDecimales)
    nInteresDevengado = Round(CDbl(capitalRecomprado) * ((CDbl(Msk_Tasa.text) * Val(nDias)) / (nBase * 100)), 4)
    'Prueba reemplazo
    'nInteresDevengado = Round(CDbl(capitalRecomprado) * ((CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) * Val(nDias)) / 3000), 4)

    
    'gr_cortes.TextMatrix(Row, C_Interes_Dev) = gr_cortes.TextMatrix(Row, C_Interes_Pagar)
    gr_cortes.TextMatrix(Row, C_Interes_Dev) = Format(nInteresDevengado, cFormato)
    gr_cortes.TextMatrix(Row, C_resultado_Recompra) = Format(nInteresDevengado - gr_cortes.TextMatrix(Row, C_Interes_Pagar), cFormato) '-->nDecimales
    '---jcamposd recalculo
    '------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        nMtoCorte = CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE))
        If nMtoCorte <> CDbl(gr_cortes.TextMatrix(Row, C_Monto_Corte_Org)) Then
            gr_cortes.TextMatrix(Row, C_Bloqueo) = "P"
            gr_cortes.TextMatrix(Row, C_Campo_Venta) = "X"
        ElseIf nTasa <> CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Compra_Org)) And nMtoCorte = CDbl(gr_cortes.TextMatrix(Row, C_Monto_Corte_Org)) Then
            gr_cortes.TextMatrix(Row, C_Bloqueo) = "V"
            gr_cortes.TextMatrix(Row, C_Campo_Venta) = "X"
        ElseIf nTasa = CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Compra_Org)) And nMtoCorte = CDbl(gr_cortes.TextMatrix(Row, C_Monto_Corte_Org)) Then
            gr_cortes.TextMatrix(Row, C_Bloqueo) = "V"
            gr_cortes.TextMatrix(Row, C_Campo_Venta) = "X"
        End If
        Call Colores_Marca(Row)
End Sub

Private Sub Calculo_Tasa_Interes(Row As Integer)
Dim nBase       As Double
Dim nValmon     As Double
Dim nValorUFI   As Double
Dim nDias       As Integer
Dim nInteres    As Double
Dim nMtoCorte   As Double
Dim nTasa       As Double
Dim nTotalP     As Double
Dim nReajuste   As Double
Dim i           As Integer
'+++jcamposd
Dim valorRecompra As Double
Dim nInteresDevengado As Double
Dim capitalRecomprado As Double
'---jcamposd

    nBase = BaseCalculo()
    If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 999 Then
        nBase = 30
    End If
    
    If gr_cortes.TextMatrix(Row, C_Valor_A_Pagar) = 0 Then
        Exit Sub
   End If
    
    '+++jcamposd prueba reemplazo
    'SELECT @ftir = ROUND(((((@fnominal/@fmt)-1.0)*100.0)/(DATEDIFF(DAY,@dfeccal,@dfecven)))*@fbasemi,4)
    nTasa = Round(((((CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE)) / (gr_cortes.TextMatrix(Row, C_Valor_A_Pagar))) - 1#) * 100#) / (DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text))) * nBase, 4)
    gr_cortes.TextMatrix(Row, C_Tasa_Recompra) = nTasa
    
    
    nValmon = FUNC_BUSCA_VALOR_MONEDA(IIf(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 13, 999, Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)), Format(gsBac_Fecp, "DD/MM/YYYY"))
    nValorUFI = FUNC_BUSCA_VALOR_MONEDA(IIf(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 13, 999, Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)), TxtFechaIni.text)
    nDias = Val(gr_cortes.TextMatrix(Row, C_Plazo))
    nMtoCorte = CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE))
    
'+++jcamposd valor recompra es ingresado manual no se calcula
'''''    '+++jcamposd recalculo dap valor nominal es el monto del corte
'''''    If CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE)) = CDbl(gr_cortes.TextMatrix(Row, C_Monto_Corte_Org)) Then
'''''        ''nMtoCorte = (CDbl(gr_cortes.TextMatrix(Row, C_monto_final_cap)) / ((1 + CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) * (Val(DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text)) / (nBase * 100)))))
'''''        valorRecompra = (CDbl(gr_cortes.TextMatrix(Row, C_monto_final_cap)) / ((1 + CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) * (Val(DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text)) / (nBase * 100)))))
'''''        'prueba reemplazo
'''''        'valorRecompra = ((CDbl(gr_cortes.TextMatrix(Row, C_monto_final_cap)) / (1 + ((Val(DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text)) / 30) * (CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) / 100)))))
'''''
'''''    Else
'''''        ''nMtoCorte = (CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE)) / ((1 + CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) * (Val(DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text)) / (nBase * 100)))))
'''''        valorRecompra = (CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE)) / ((1 + CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) * (Val(DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text)) / (nBase * 100)))))
'''''        'prueba reemplazo
'''''        'valorRecompra = ((CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE)) / (1 + ((Val(DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text)) / 30) * (CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) / 100)))))
'''''
'''''    End If

    valorRecompra = (gr_cortes.TextMatrix(Row, C_Valor_A_Pagar))

'---jcamposd valor recompra es ingresado manual no se calcula
    
    '+++jcamposd 20161020 no se debe recalcular al inicio, según solicitud usuario
    If CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE)) = CDbl(gr_cortes.TextMatrix(Row, C_Monto_Corte_Org)) Then
        capitalRecomprado = CDbl(gr_cortes.TextMatrix(Row, C_monto_inicial_capta))
    Else
        capitalRecomprado = (CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE)) / ((1 + CDbl(Msk_Tasa.text) * (Val(Txt_Dias.text) / (nBase * 100)))))
    End If
    '---jcamposd 20161020 no se debe recalcular al inicio, según solicitud usuario
  
    'prueba reemplazo
    'capitalRecomprado = ((CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE))) / (1 + ((CDbl(Msk_Tasa.text) / 100) * (Val(Txt_Dias.text) / 30))))

    
    gr_cortes.TextMatrix(Row, C_capital_Recomprado) = Format(CDbl(capitalRecomprado), cFormato) '-->nDecimales
    '---jcamposd recalculo dap
    nReajuste = CDbl(gr_cortes.TextMatrix(Row, C_Reajuste_Pagar))
    
    
    If gr_cortes.Col = C_Interes_Pagar Then
        nInteres = gr_cortes.TextMatrix(Row, C_Interes_Pagar)
        nTotalP = (nInteres * nValmon) + (nMtoCorte * nValorUFI)
        nTotalP = nTotalP + nReajuste
        gr_cortes.TextMatrix(Row, C_Valor_A_Pagar) = Format(nTotalP, cFormato) '-->nDecimales
    ElseIf gr_cortes.Col = C_Valor_A_Pagar Then
        nTotalP = gr_cortes.TextMatrix(Row, C_Valor_A_Pagar)
        nTotalP = nTotalP - nReajuste
        nTotalP = (nTotalP - (nMtoCorte * nValorUFI)) / nValmon
        gr_cortes.TextMatrix(Row, C_Interes_Pagar) = Format(nTotalP, cFormato) '-->nDecimales
        nInteres = gr_cortes.TextMatrix(Row, C_Interes_Pagar)
    End If
    
    
    'posicion original del calculo tasa
    'nTasa = (nBase * 100) * (((nInteres + nMtoCorte) * (1 / nMtoCorte) - 1) / IIf(nDias = 0, 1, nDias))
    
    'prueba reemplazo por recalculo tasa
    gr_cortes.TextMatrix(Row, C_Valor_A_Pagar) = Format(valorRecompra, cFormato) '-->nDecimales
    gr_cortes.TextMatrix(Row, C_Interes_Pagar) = Format(valorRecompra - capitalRecomprado, cFormato) '-->nDecimales
    '+++jcamposd recalculo
    'gr_cortes.TextMatrix(Row, C_Valor_Recompra) = Format(nMtoCorte, nDecimales)
    nInteresDevengado = Round(CDbl(capitalRecomprado) * ((CDbl(Msk_Tasa.text) * Val(nDias)) / (nBase * 100)), 4)
    'Prueba reemplazo
    'nInteresDevengado = Round(CDbl(capitalRecomprado) * ((CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Recompra)) * Val(nDias)) / 3000), 4)

    
    'gr_cortes.TextMatrix(Row, C_Interes_Dev) = gr_cortes.TextMatrix(Row, C_Interes_Pagar) '-->nDecimales
    gr_cortes.TextMatrix(Row, C_Interes_Dev) = Format(nInteresDevengado, cFormato)
    gr_cortes.TextMatrix(Row, C_resultado_Recompra) = Format(nInteresDevengado - gr_cortes.TextMatrix(Row, C_Interes_Pagar), cFormato) '-->nDecimales
    '---jcamposd recalculo
    'prueba reemplazo por recalculo tasa
    
    gr_cortes.TextMatrix(Row, C_Tasa_Recompra) = Format(Round(nTasa, 6), "###,##0.#####0")

    nMtoCorte = CDbl(gr_cortes.TextMatrix(Row, C_MONTO_CORTE))
    If nMtoCorte <> CDbl(gr_cortes.TextMatrix(Row, C_Monto_Corte_Org)) Then
        gr_cortes.TextMatrix(Row, C_Bloqueo) = "P"
        gr_cortes.TextMatrix(Row, C_Campo_Venta) = "X"
    ElseIf nTasa <> CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Compra_Org)) And nMtoCorte = CDbl(gr_cortes.TextMatrix(Row, C_Monto_Corte_Org)) Then
        gr_cortes.TextMatrix(Row, C_Bloqueo) = "V"
        gr_cortes.TextMatrix(Row, C_Campo_Venta) = "X"
    ElseIf nTasa = CDbl(gr_cortes.TextMatrix(Row, C_Tasa_Compra_Org)) And nMtoCorte = CDbl(gr_cortes.TextMatrix(Row, C_Monto_Corte_Org)) Then
        gr_cortes.TextMatrix(Row, C_Bloqueo) = "V"
        gr_cortes.TextMatrix(Row, C_Campo_Venta) = "X"
    End If
    Call Colores_Marca(Row)

    TxtCartera.text = 0
    For i = 1 To gr_cortes.Rows - 1
        'recalcula
        TxtCartera.text = CDbl(TxtCartera.text) + CDbl(gr_cortes.TextMatrix(i, C_Valor_A_Pagar))
    Next i
    
    
    TxtCarteraSel.text = CDbl(0)
    For i = 1 To gr_cortes.Rows - 1
        TxtCarteraSel.text = CDbl(TxtCarteraSel.text) + IIf(gr_cortes.TextMatrix(i, C_Campo_Venta) = "X", CDbl(gr_cortes.TextMatrix(i, C_Valor_A_Pagar)), 0)
    Next i
    
    If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 998 Then
        TXTN_montoS_UF.text = CDbl(0)
        For i = 1 To gr_cortes.Rows - 1
            TXTN_montoS_UF.text = CDbl(TXTN_montoS_UF.text) + IIf(gr_cortes.TextMatrix(i, C_Campo_Venta) = "X", Round((CDbl(gr_cortes.TextMatrix(i, C_Valor_A_Pagar) * UfCalculoPantalla)), 0), 0)
        Next i
    End If
    
End Sub

Private Function CO_ChkInteresDAP(Nominal#, nFil) As Boolean
Dim nMtoNominal    As Double
Dim nMontoCorte    As Double
Dim nInteres       As Double
Dim nDecimal       As Integer

    CO_ChkInteresDAP = False
   
    nMtoNominal = CDbl(gr_cortes.TextMatrix(nFil, C_Monto_Corte_Org)) 'Nominal Original
    nMontoCorte = CDbl(gr_cortes.TextMatrix(nFil, C_MONTO_CORTE)) 'Nominal Original
    nInteres = CDbl(gr_cortes.TextMatrix(nFil, C_Interes_Dev)) 'Interes Real a Pagar
    '-------------------------------------
    'Proporcion Interes al Corte
    '-------------------------------------
    nInteres = (nInteres / nMtoNominal) * nMontoCorte 'Proporcion Interes al Corte
    
    nDecimal = IIf(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 999, 0, IIf(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 998, 4, 2))
    
    If Round(CDbl(Nominal#), nDecimal) > Round(CDbl(nInteres), nDecimal) Then
        MsgBox "Interés Excéde al Interés Máximo a Pagar por el Capital :" & vbCrLf & vbCrLf & _
                "Interes Máximo a Pagar por el Capital:  $ " & Format(nInteres, nDecInteres), vbExclamation, gsBac_Version
        gr_cortes.TextMatrix(nFil, C_Check_Interes) = "X"
        CO_ChkInteresDAP = True
        Exit Function
    ElseIf Round(CDbl(Nominal#), nDecimal) < 0 Then
        MsgBox "Monto Interés debe ser mayor o igual a Cero(0)", vbExclamation, gsBac_Version
        Exit Function
    End If
    gr_cortes.TextMatrix(nFil, C_Check_Interes) = ""
    CO_ChkInteresDAP = True
    Exit Function
End Function

Private Function CO_ChkInteresTotDAP(Nominal#, nFil As Integer) As Boolean
Dim nMtoRecompra   As Double
Dim nValmon        As Double
Dim nValorUFI      As Double

    nValmon = FUNC_BUSCA_VALOR_MONEDA(IIf(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 13, 999, Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)), Format(gsBac_Fecp, "DD/MM/YYYY"))
    nValorUFI = FUNC_BUSCA_VALOR_MONEDA(IIf(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 13, 999, Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)), TxtFechaIni.text)
    
    '+++jcamposd recalculo
    'nMtoRecompra = CDbl(gr_cortes.TextMatrix(nFil, C_Valor_Recompra))
    nMtoRecompra = CDbl(gr_cortes.TextMatrix(nFil, C_Valor_A_Pagar))
    '---jcamposd recalculo
    CO_ChkInteresTotDAP = False
        
'    If CDbl(Nominal#) > CDbl(nMtoRecompra) Then
'        MsgBox "Monto Recompra debe ser menor o Igual al Valor Presente Actual :" & vbCrLf & vbCrLf & _
'               "Valor Presente Devengado $: " & Format(nMtoRecompra, cFormato$), vbExclamation, gsBac_Version
'        gr_cortes.TextMatrix(nFil, C_Check_Interes) = "X"
'        CO_ChkInteresTotDAP = True
'        Exit Function
'    Else
    If CDbl(Nominal#) < 0 Then
        MsgBox "Monto Recompra debe ser mayor a Cero(0)", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    gr_cortes.TextMatrix(nFil, C_Check_Interes) = ""
    CO_ChkInteresTotDAP = True
    Exit Function
End Function

Private Function BaseCalculo() As Integer
Dim varssql         As String
Dim varDatos()

On Error GoTo ErrFind
    
    BaseCalculo = 1
    If IsNull(Cmb_Moneda.text) = True Or Cmb_Moneda.text = "" Then Exit Function
    
    varssql = "EXECUTE sp_trae_moneda " & Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)
    
    If miSQL.SQL_Execute(varssql) = 0 Then
        Do While miSQL.SQL_Fetch(varDatos()) = 0
            BaseCalculo = varDatos(3)
            DiasMin = varDatos(4)
            Exit Function
        Loop
    End If
    
    Exit Function
    
ErrFind:
    BaseCalculo = 1
    MsgBox "Problemas en busqueda de bases de calculo: " & err.Description & ".Comunique al Administrador. ", vbCritical, gsBac_Version
    Exit Function
End Function

Private Function BuscaDatos_Rc(sNumoper As String) As Integer
Dim DatosC()
Dim iTipEmiDep$, iRutCli$, nCodcli&, TasaTran$, sTipCus$, sTipDep$, TasaCorte$
Dim iRutCar$, iTipCar$, iForPagI$, iForpaV$, sRetiro$, cCondicion$
Dim DiasCorte            As Integer
Dim FechaVctoCorte       As Date
Dim MonedaCorte          As String
'Dim TasaCorte            As Double
Dim custodia             As String
Dim Tipo_Deposito        As String
Dim Condicion_Captacion  As String
Dim nRow                 As Integer
Dim bRetornaDatos        As Boolean

    Let bRetornaDatos = False

    gr_cortes.Redraw = False
    
    Call PROC_CREA_GRILLA

    BuscaDatos_Rc = 1
    
    Numero_RIC = IntNumoper.text
  
    Envia = Array(CDbl(sNumoper), gsBac_User)
    If Bac_Sql_Execute("Execute SP_BUSCACAPTACION_RC", Envia) Then
        Do While Bac_SQL_Fetch(DatosC())
            If DatosC(1) = "NO" Then
                MsgBox DatosC(2), vbExclamation, gsBac_Version
                IntNumoper.text = 0
                IntNumoper.Enabled = True
                IntNumoper.SelLength = Len(IntNumoper.text)
                If IntNumoper.Enabled = True Then
                    IntNumoper.SetFocus
                End If
                BuscaDatos_Rc = 0
                gr_cortes.Redraw = True
                Exit Function
            End If
            
            bRetornaDatos = True
            
            TxtFechaIni.text = Format(DatosC(2), "DD/MM/YYYY")
            DiasCorte = DatosC(3)
            FechaVctoCorte = DatosC(4)
            MonedaCorte = DatosC(5)
            TasaCorte = DatosC(6)
            iRutCar$ = DatosC(7)
            iTipCar$ = DatosC(8)
            iForPagI$ = DatosC(9)
            iForpaV$ = DatosC(10)
            sRetiro$ = DatosC(11)
            iRutCli$ = DatosC(12)
            nCodcli& = DatosC(13)
    
            With gr_cortes
                .Rows = .Rows + 1
                nRow = .Rows - 1
                Select Case MonedaCorte
                Case "CLP": cFormato$ = "###,###,###,###,##0"
                            nDecimales = "###,###,###,###,##0"
                Case "UF":  cFormato$ = "###,###,###,###,##0.###0"
                            nDecimales = "###,###,###,###,##0"
                            gr_cortes.ColWidth(C_Reajuste_Pagar) = 0 '1300 --jcamposd recalculo
                Case Else:  cFormato$ = "###,###,###,###,##0.#0"
                            nDecimales = "###,###,###,###,##0.#0"
                End Select
                nDecInteres = cFormato$

                .TextMatrix(nRow, C_Correlativo) = DatosC(14)
                '+++jcamposd recalculo, ahora debe traer el monto final
                '.TextMatrix(nRow, C_MONTO_CORTE) = Format$(DatosC(16), cFormato)
                '.TextMatrix(nRow, C_Monto_Corte_Org) = Format$(DatosC(16), cFormato)
                .TextMatrix(nRow, C_monto_inicial_capta) = Format$(DatosC(16), cFormato)
                .TextMatrix(nRow, C_MONTO_CORTE) = Format$(DatosC(25), cFormato)
                .TextMatrix(nRow, C_Monto_Corte_Org) = Format$(DatosC(25), cFormato)
                '---jcamposd recalculo, ahora debe traer el monto final
                .TextMatrix(nRow, C_Tasa_Compra_Org) = Format$(DatosC(6), "0.#####0")
                .TextMatrix(nRow, C_Tasa_Recompra) = Format$(DatosC(6), "0.#####0")
                .TextMatrix(nRow, C_Valor_A_Pagar) = Format$(0#, cFormato) '--> nDecimales
                .TextMatrix(nRow, C_Valor_A_Pagar_Org) = Format$(0#, cFormato) '--> nDecimales
                '+++jcamposd 20151028 recompra dap
                .TextMatrix(nRow, C_monto_final_cap) = Format$(DatosC(25), cFormato)
                '------.TextMatrix(nRow, C_resultado_Recompra) = Format$(0#, nDecimales)
                '------.TextMatrix(nRow, C_monto_inicial_capta) = Format$(0#, nDecimales)
                '------.TextMatrix(nRow, C_capital_Recomprado) = Format$(0#, nDecimales)
                .TextMatrix(nRow, C_resultado_Recompra) = Format$(0, cFormato)
                '+++jcamposd 20161020 no se inicializara variable, si es total se utilizara esta
                '.TextMatrix(nRow, C_monto_inicial_capta) = Format$(0, cFormato)
                '---jcamposd 20161020 no se inicializara variable, si es total se utilizara esta
                .TextMatrix(nRow, C_capital_Recomprado) = Format$(0, cFormato)
                
                '---jcamposd 20151028 recompra dap
                TasaTran = DatosC(17)
                sTipCus$ = DatosC(18)
                custodia = DatosC(18)
                Tipo_Deposito = DatosC(19)
                sTipDep$ = DatosC(19)
                cCondicion$ = DatosC(20)
                Condicion_Captacion = DatosC(20)
                iTipEmiDep = DatosC(21)
            
                .TextMatrix(nRow, C_Num_Dcv) = DatosC(22)
           
                If iTipEmiDep = 1 Then
                    .TextMatrix(nRow, C_Tipo_Custodia) = "FISICA"
                Else
                    .TextMatrix(nRow, C_Tipo_Custodia) = "DCV"
                End If
                .TextMatrix(nRow, C_Plazo) = DatosC(24)
            End With
        Loop
        
        If bRetornaDatos = False Then
            BuscaDatos_Rc = 0
            gr_cortes.Redraw = True
            Exit Function
        End If
        
        Txt_Dias.text = DiasCorte
        Cmb_Moneda.text = MonedaCorte
        
        nDecInteres = cFormato$
        
        'Msk_Tasa.text = Format(TasaCorte, "##0.#####0")
        'Flt_TasaTran.text = Format(TasaTran, "##0.#####0")
        Msk_Tasa.text = Format$(TasaCorte, "0.#####0")
        Flt_TasaTran.text = Format$(TasaTran, "0.#####0")
        Msk_Fecha_Vcto.text = Format(FechaVctoCorte, "dd/mm/yyyy")
        
        ''''''''''''Custodia
        If custodia = "P" Then Cmb_Custodia.ListIndex = 0 Else Cmb_Custodia.ListIndex = 1
        ''''''''''''Tipo_Deposito
        If Tipo_Deposito = "R" Then Cmb_Tipo_Deposito.ListIndex = 0 Else Cmb_Tipo_Deposito.ListIndex = 1
        ''''''''''''Condicion_Captacion
        If Condicion_Captacion = "E" Then CmbCondicion.ListIndex = 0 Else CmbCondicion.ListIndex = 1
        ''''''''''''Condicion_Captacion
        If iTipEmiDep = 1 Then CmbTipo_Emision.ListIndex = 0 Else CmbTipo_Emision.ListIndex = 1
    End If
    Call Formatos
    gr_cortes.Redraw = True
End Function

Private Function Verifica_Venta_Corte() As Boolean
Dim Fila As Integer

Verifica_Venta_Corte = False

For Fila = 1 To gr_cortes.Rows - 1
    If gr_cortes.TextMatrix(Fila, C_Campo_Venta) = "X" Then
        Verifica_Venta_Corte = True
        Exit Function
    End If
Next Fila

MsgBox "No Existen Cortes Marcados para Anticipar.", vbExclamation
End Function

Private Function Verifica_Exceso_Venta() As Boolean
    Dim Fila        As Integer
    Dim nInteresI   As Double
    Dim nInteresF   As Double
    Dim nMtoCorte   As Double
    Dim nCertDCV    As String
    Dim vIns()
    Dim cMensaje    As String
    Dim xMensaje    As String
    Dim C%

    Verifica_Exceso_Venta = False

    vIns() = Array()
    aTasasE() = Array()
    cMensaje = "Los Siguientes Cortes están Excedidos en el Límite de Interes a Pagar, ¿ Desea que otro Usuario Autorize.? " & vbCrLf & vbCrLf
    cMensaje = cMensaje + "N° Certificado DCV         Interes Límite              Interes a Pagar" & vbCrLf
    cMensaje = cMensaje + "----------------------          ------------------------   --------------------------" & vbCrLf
    xMensaje = ""

    For Fila = 1 To gr_cortes.Rows - 1

        If gr_cortes.TextMatrix(Fila, C_Check_Interes) = "X" Then

            nInteresI = 0
            nInteresF = 0
            nMtoCorte = 0
            nCertDCV = CDbl(gr_cortes.TextMatrix(Fila, C_Num_Dcv))
            nInteresI = CDbl(gr_cortes.TextMatrix(Fila, C_Interes_Pagar))
            nMtoCorte = CDbl(gr_cortes.TextMatrix(Fila, C_MONTO_CORTE))
            nInteresF = CDbl(gr_cortes.TextMatrix(Fila, C_Valor_A_Pagar_Org)) / CDbl(gr_cortes.TextMatrix(Fila, C_Monto_Corte_Org))
            nInteresF = Round((nMtoCorte * nInteresF) - nMtoCorte, 0)

            C = UBound(vIns) + 1
            ReDim Preserve vIns(C)

            xMensaje = xMensaje & nCertDCV & String(10 - Len(nCertDCV), "0") & String(20, " ") & _
                       Format$(nInteresF, nDecInteres) & String(30 - Len(Trim(Format$(nInteresF, nDecInteres))), " ") & _
                       Format$(nInteresI, nDecInteres) & String(30 - Len(Trim(Format$(nInteresI, nDecInteres))), " ") & vbCrLf

''''''      xMensaje = xMensaje & nCertDCV & Replicate("0", 10 - Len(nCertDCV)) & Replicate(" ", 20) & _
''''''                 Format$(nInteresF, nDecInteres) & Replicate(" ", 30 - Len(Trim(Format$(nInteresF, nDecInteres)))) & _
''''''                 Format$(nInteresI, nDecInteres) & Replicate(" ", 30 - Len(Trim(Format$(nInteresI, nDecInteres)))) & vbCrLf

            C = UBound(aTasasE) + 1

            ReDim Preserve aTasasE(C)

            aTasasE(C) = Array("TP", "", nInteresI, nInteresF, Txt_Dias.text, nMtoCorte, 1)

        End If

    Next Fila

    If xMensaje <> "" Then
        If MsgBox(cMensaje & xMensaje, vbYesNo + vbCritical) = vbYes Then
            If Aprobacion_Pantalla(6, 1) Then
                Verifica_Exceso_Venta = True
                Exit Function
            End If
        End If
    Else
        Verifica_Exceso_Venta = True
        Exit Function
    End If
    

End Function

Private Sub TxtFung_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 27 Then
        TxtFung.text = 0  '""
        TxtFung.Visible = False
        gr_cortes.SetFocus
        Exit Sub
    ElseIf KeyAscii = 13 Then
    
        Call Validar_Ingresos
        TxtFung.Visible = False
        gr_cortes.SetFocus
    End If
End Sub

Private Sub TxtFung_LostFocus()
    TxtFung.text = 0
    TxtFung.Visible = False
    gr_cortes.SetFocus
End Sub

Private Function Validar_Ingresos()
Dim nCol As Integer
Dim nFil As Integer
Dim i       As Integer

    nCol = gr_cortes.Col
    nFil = gr_cortes.Row
    If nCol = C_Tasa_Recompra Then
        gr_cortes.TextMatrix(nFil, nCol) = Format$(CDbl(TxtFung.text), "0.#####0")
        Call Calculo_Interes(nFil)
        gr_cortes.Col = nCol
    End If
    
  
    If nCol = C_Valor_A_Pagar Then
        If CO_ChkInteresTotDAP(CDbl(TxtFung.text), nFil) = True Then
            gr_cortes.TextMatrix(nFil, nCol) = Format$(CDbl(TxtFung.text), cFormato) '-->nDecimales'"###,###,###,###,###")
            Call Calculo_Tasa_Interes(nFil)
            gr_cortes.Col = nCol
        Else
            gr_cortes.Col = nCol
            Call TxtFung_LostFocus
            Exit Function
        End If
    End If
    
    If nCol = C_Interes_Pagar Then
        If CO_ChkInteresDAP(CDbl(TxtFung.text), nFil) = True Then
            gr_cortes.TextMatrix(nFil, nCol) = Format$(CDbl(TxtFung.text), nDecInteres)
            Call Calculo_Tasa_Interes(nFil)
            'Call Calculo_Interes(gr_cortes.row)
            gr_cortes.Col = nCol
        Else
          gr_cortes.Col = nCol
          Call TxtFung_LostFocus
          Exit Function
        End If
    End If
    
    If nCol = C_Reajuste_Pagar Then
        'If CO_ChkInteresDAP(CDbl(TxtFung.text), nFil) = True Then
            gr_cortes.TextMatrix(nFil, nCol) = Format$(CDbl(TxtFung.text), nDecimales)
            Call Calculo_Interes_Reajustes(nFil)
            'Call Calculo_Interes(gr_cortes.row)
            gr_cortes.Col = nCol
        'Else
        '  gr_cortes.Col = nCol
        '  Call TxtFung_LostFocus
        '  Exit Function
        'End If
    End If
    
    If nCol = C_MONTO_CORTE Then
        If CO_ChkCortesDAP(CDbl(TxtFung.text), CDbl(gr_cortes.TextMatrix(nFil, C_Monto_Corte_Org)), Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)) Then
            gr_cortes.TextMatrix(nFil, nCol) = Format$(CDbl(TxtFung.text), cFormato)
            Call Calculo_Interes(nFil)
        Else
            gr_cortes.Col = nCol
            Call TxtFung_LostFocus
            Exit Function
        End If
    End If
    TxtCartera.text = 0
    For i = 1 To gr_cortes.Rows - 1
        'recalcula
        TxtCartera.text = CDbl(TxtCartera.text) + CDbl(gr_cortes.TextMatrix(i, C_Valor_A_Pagar))
    Next i
    
    
    TxtCarteraSel.text = CDbl(0)
    For i = 1 To gr_cortes.Rows - 1
        TxtCarteraSel.text = CDbl(TxtCarteraSel.text) + IIf(gr_cortes.TextMatrix(i, C_Campo_Venta) = "X", CDbl(gr_cortes.TextMatrix(i, C_Valor_A_Pagar)), 0)
    Next i
    
    If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 998 Then
        TXTN_montoS_UF.text = CDbl(0)
        For i = 1 To gr_cortes.Rows - 1
            TXTN_montoS_UF.text = CDbl(TXTN_montoS_UF.text) + IIf(gr_cortes.TextMatrix(i, C_Campo_Venta) = "X", Round((CDbl(gr_cortes.TextMatrix(i, C_Valor_A_Pagar) * UfCalculoPantalla)), 0), 0)
        Next i
    End If
    
    gr_cortes.Col = nCol

End Function

Private Sub Combo1_GotFocus()
   Call PROC_POSI_TEXTO(gr_cortes, Combo1)
End Sub

Private Sub Combo1_KeyDown(KeyCode As Integer, Shift As Integer)
   
If KeyCode = 27 Then
    Combo1_LostFocus
End If

If KeyCode = 13 Then
        If gr_cortes.Col = C_Tipo_Custodia Then
            Select Case Combo1.ListIndex
            Case 0:
                gr_cortes.TextMatrix(gr_cortes.Row, C_Tipo_Custodia) = "FISICA"
                gr_cortes.TextMatrix(gr_cortes.Row, C_Clave_Dcv) = ""
            Case "1":
                gr_cortes.TextMatrix(gr_cortes.Row, C_Tipo_Custodia) = "DCV"
                gr_cortes.TextMatrix(gr_cortes.Row, C_Clave_Dcv) = FUNC_GENERA_CLAVE_DCV
            End Select
            Combo1.Visible = False
            gr_cortes.SetFocus
        End If
End If
End Sub

Private Sub Combo1_LostFocus()
    Combo1.Visible = False
    gr_cortes.SetFocus

    If gr_cortes.Col + 1 < gr_cortes.cols Then
        gr_cortes.Col = gr_cortes.Col + 1
    End If

End Sub

Private Function Colores_Marca(nRow As Integer)
    If gr_cortes.TextMatrix(nRow, C_Bloqueo) = "*" Then
        Color = vbGreen + vbWhite
        colorletra = vbWhite
    ElseIf gr_cortes.TextMatrix(nRow, C_Bloqueo) = "V" Then
        Color = vbBlue
        colorletra = vbWhite
    ElseIf gr_cortes.TextMatrix(nRow, C_Bloqueo) = "P" Then
        Color = vbCyan
        colorletra = vbBlack
    Else
        Color = &H80000004
        colorletra = &H800000
    End If
    
    Dim z%
    gr_cortes.Row = nRow
    For z = 3 To gr_cortes.cols - 1
         If gr_cortes.ColWidth(z) <> 0 Then
            gr_cortes.Col = z
            gr_cortes.CellBackColor = Color
            gr_cortes.CellForeColor = colorletra
         End If
    Next z
End Function

Private Sub Text2_GotFocus()
    Call PROC_POSI_TEXTO(gr_cortes, Text2)
    Text2.SelLength = Len(Text2)
    Text2.SelStart = Len(Text2)
End Sub

Private Sub Text2_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 27 Then
        Text2_LostFocus
    End If
    If KeyCode = 13 Then
       gr_cortes.TextMatrix(gr_cortes.Row, 8) = Trim(Text2.text)
       gr_cortes.SetFocus
    End If
End Sub

Private Sub Text2_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub Text2_LostFocus()
    Text2.text = ""
    Text2.Visible = False
    gr_cortes.SetFocus
End Sub


Private Function Fx_Load_Data(ByVal nCategoria As String, ByRef oCombo As ComboBox) As Boolean
    On Error GoTo errLoadData
    Dim SqlString   As String
    Dim SqlDatos()
    
    Let Fx_Load_Data = False
    
    If nCategoria = "CONDICION" Then
        Let SqlString = "SP_LEECONDICION "
    End If
    If nCategoria = "DEPOSITO" Then
        Let SqlString = "SP_TCLEECODIGOS1 10"
    End If
    
    Call oCombo.Clear

    If Not Bac_Sql_Execute(SqlString) Then
        Exit Function
    End If
    Do While Bac_SQL_Fetch(SqlDatos())
        Call oCombo.AddItem(SqlDatos(2))
         Let oCombo.ItemData(oCombo.NewIndex) = SqlDatos(1)
    Loop
    
    Let Fx_Load_Data = True
    
    If oCombo.ListCount > 0 Then
        Let oCombo.ListIndex = 0
    End If
    
    On Error GoTo 0
Exit Function
errLoadData:

    Call MsgBox("Error en la carga de informacion para " & nCategoria & vbCrLf & err.Description, vbExclamation, App.Title)

    On Error GoTo 0
End Function


