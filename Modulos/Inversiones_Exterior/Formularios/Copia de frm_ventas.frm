VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form Bac_Ventas 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ventas de Inversiones en el Exterior"
   ClientHeight    =   6720
   ClientLeft      =   255
   ClientTop       =   675
   ClientWidth     =   11295
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6720
   ScaleWidth      =   11295
   Begin VB.Frame frm_nemo 
      Height          =   1140
      Left            =   60
      TabIndex        =   36
      Top             =   660
      Width           =   11055
      Begin VB.TextBox Txt_Nemo 
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
         Left            =   1740
         MaxLength       =   20
         TabIndex        =   48
         Top             =   675
         Width           =   3630
      End
      Begin VB.ComboBox box_familia 
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
         Left            =   1740
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   195
         Width           =   2340
      End
      Begin VB.Label Label25 
         Caption         =   "Id. Instrumento"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   150
         TabIndex        =   49
         Top             =   675
         Width           =   1335
      End
      Begin VB.Label Label2 
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
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   165
         TabIndex        =   38
         Top             =   255
         Width           =   975
      End
      Begin VB.Label lbl_descrip 
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
         ForeColor       =   &H8000000D&
         Height          =   315
         Left            =   5550
         TabIndex        =   37
         Top             =   675
         Width           =   5280
      End
   End
   Begin VB.Frame frm_datos_op 
      Caption         =   "Datos de la Operacion"
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
      ForeColor       =   &H8000000D&
      Height          =   2265
      Left            =   75
      TabIndex        =   23
      Top             =   4380
      Width           =   11055
      Begin BACControles.TXTNumero txt_monto_pag 
         Height          =   270
         Left            =   7560
         TabIndex        =   58
         Top             =   1440
         Width           =   2535
         _ExtentX        =   4471
         _ExtentY        =   476
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
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
         Max             =   "999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txt_pre_por 
         Height          =   270
         Left            =   7560
         TabIndex        =   57
         Top             =   360
         Width           =   2535
         _ExtentX        =   4471
         _ExtentY        =   476
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
         Text            =   "0,0000000"
         Text            =   "0,0000000"
         Min             =   "0"
         Max             =   "999999.9999999"
         CantidadDecimales=   "7"
         Separator       =   -1  'True
         SelStart        =   4
      End
      Begin BACControles.TXTNumero txt_tir 
         Height          =   270
         Left            =   2025
         TabIndex        =   56
         Top             =   1800
         Width           =   2055
         _ExtentX        =   3625
         _ExtentY        =   476
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
         Text            =   "0,0000000"
         Text            =   "0,0000000"
         Min             =   "0"
         Max             =   "999999.9999999"
         CantidadDecimales=   "7"
         Separator       =   -1  'True
         SelStart        =   4
      End
      Begin BACControles.TXTNumero txt_nominal 
         Height          =   270
         Left            =   2025
         TabIndex        =   55
         Top             =   1425
         Width           =   2655
         _ExtentX        =   4683
         _ExtentY        =   476
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         Min             =   "0"
         Max             =   "999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txt_tasa_vig 
         Height          =   270
         Left            =   2025
         TabIndex        =   54
         Top             =   1080
         Width           =   2055
         _ExtentX        =   3625
         _ExtentY        =   476
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,00000"
         Text            =   "0,00000"
         Min             =   "0"
         Max             =   "999.99999"
         CantidadDecimales=   "5"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTFecha txt_fec_neg 
         Height          =   285
         Left            =   2025
         TabIndex        =   7
         Top             =   285
         Width           =   1410
         _ExtentX        =   2487
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
         MaxDate         =   2958465
         MinDate         =   2
         Text            =   "18/06/2002"
      End
      Begin BACControles.TXTFecha txt_fec_pag 
         Height          =   330
         Left            =   2025
         TabIndex        =   8
         Top             =   660
         Width           =   1410
         _ExtentX        =   2487
         _ExtentY        =   582
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
         MinDate         =   2
         Text            =   "18/06/2002"
      End
      Begin VB.Label lbl_monto_prin 
         Alignment       =   1  'Right Justify
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
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   7560
         TabIndex        =   45
         Top             =   720
         Width           =   2430
      End
      Begin VB.Label Label23 
         Caption         =   "Principal"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   5700
         TabIndex        =   44
         Top             =   720
         Width           =   1695
      End
      Begin VB.Label lbl_int_dev 
         Alignment       =   1  'Right Justify
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
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   7560
         TabIndex        =   42
         Top             =   1080
         Width           =   2430
      End
      Begin VB.Label lbl_int 
         Caption         =   "Interés Devengado"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   5700
         TabIndex        =   41
         Top             =   1080
         Width           =   1680
      End
      Begin VB.Label Label14 
         Caption         =   "Valor Vencimiento"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   5700
         TabIndex        =   40
         Top             =   1860
         Width           =   1695
      End
      Begin VB.Label lbl_val_venc 
         Alignment       =   1  'Right Justify
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
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   7560
         TabIndex        =   39
         Top             =   1860
         Width           =   2430
      End
      Begin VB.Label Label22 
         Caption         =   "Tasa Vigente"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   135
         TabIndex        =   30
         Top             =   1080
         Width           =   1695
      End
      Begin VB.Label Label20 
         Caption         =   "Precio Porcentual"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   5700
         TabIndex        =   29
         Top             =   300
         Width           =   1815
      End
      Begin VB.Label Label19 
         Caption         =   "TIR"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   135
         TabIndex        =   28
         Top             =   1860
         Width           =   975
      End
      Begin VB.Label Label18 
         Caption         =   "Fecha de pago"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   135
         TabIndex        =   27
         Top             =   720
         Width           =   2055
      End
      Begin VB.Label Label17 
         Caption         =   "Monto a Pagar"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   5700
         TabIndex        =   26
         Top             =   1470
         Width           =   1695
      End
      Begin VB.Label Label16 
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
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   135
         TabIndex        =   25
         Top             =   1470
         Width           =   1455
      End
      Begin VB.Label Label15 
         Caption         =   "Fecha de Negociación"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   135
         TabIndex        =   24
         Top             =   300
         Width           =   2055
      End
   End
   Begin VB.Frame frm_descrip 
      Caption         =   "Descripcion"
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
      ForeColor       =   &H8000000D&
      Height          =   2535
      Left            =   75
      TabIndex        =   12
      Top             =   1845
      Width           =   11055
      Begin BACControles.TXTFecha txt_fec_emi 
         Height          =   285
         Left            =   7950
         TabIndex        =   9
         Top             =   615
         Width           =   1575
         _ExtentX        =   2778
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "27/11/2001"
      End
      Begin BACControles.TXTFecha txt_fec_vcto 
         Height          =   285
         Left            =   7950
         TabIndex        =   10
         Top             =   195
         Width           =   1575
         _ExtentX        =   2778
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "27/11/2001"
      End
      Begin VB.ComboBox box_base 
         Height          =   315
         Left            =   2070
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   1305
         Width           =   1395
      End
      Begin VB.ComboBox box_forma_pago 
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
         Left            =   2070
         TabIndex        =   11
         Text            =   "box_forma_pago"
         Top             =   1725
         Width           =   1980
      End
      Begin VB.ComboBox BOX_MON_PAG 
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
         Left            =   7950
         Style           =   2  'Dropdown List
         TabIndex        =   52
         Top             =   1380
         Width           =   2700
      End
      Begin VB.TextBox Txt_rut_Emi 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000004&
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
         Height          =   285
         Left            =   2070
         TabIndex        =   47
         Top             =   615
         Width           =   1875
      End
      Begin VB.TextBox txt_rut_emis 
         Height          =   285
         Left            =   6735
         MaxLength       =   8
         TabIndex        =   43
         Top             =   3120
         Visible         =   0   'False
         Width           =   1935
      End
      Begin VB.ComboBox box_basilea 
         BackColor       =   &H00C0FFFF&
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
         Left            =   5415
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   2835
         Visible         =   0   'False
         Width           =   1980
      End
      Begin VB.Frame frm_basilea 
         BackColor       =   &H00C0FFFF&
         Enabled         =   0   'False
         Height          =   450
         Left            =   2010
         TabIndex        =   34
         Top             =   2640
         Visible         =   0   'False
         Width           =   1380
         Begin VB.OptionButton Op_Encaje_N 
            Caption         =   "No"
            Height          =   300
            Left            =   735
            TabIndex        =   4
            Top             =   135
            Width           =   510
         End
         Begin VB.OptionButton Op_Encaje_S 
            Caption         =   "Sí"
            Height          =   285
            Left            =   75
            TabIndex        =   3
            Top             =   135
            Width           =   465
         End
      End
      Begin VB.ComboBox box_moneda 
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
         Left            =   7950
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   1020
         Width           =   2700
      End
      Begin VB.Label Label1 
         Caption         =   "Forma de Pago"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   100
         TabIndex        =   53
         Top             =   1710
         Width           =   1245
      End
      Begin VB.Label Label30 
         Caption         =   "Moneda Pago"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   5790
         TabIndex        =   51
         Top             =   1380
         Width           =   1815
      End
      Begin VB.Label Txt_Cod_tasa 
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000006&
         Height          =   255
         Left            =   2070
         TabIndex        =   50
         Top             =   270
         Width           =   615
      End
      Begin VB.Label Label24 
         Caption         =   "Base Tasas"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   100
         TabIndex        =   46
         Top             =   1365
         Width           =   975
      End
      Begin VB.Label lbl_tip_tasa 
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000006&
         Height          =   255
         Left            =   2715
         TabIndex        =   35
         Top             =   270
         Width           =   2880
      End
      Begin VB.Label lbl_ciudad 
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   7950
         TabIndex        =   33
         Top             =   2100
         Width           =   1950
      End
      Begin VB.Label lbl_emisor 
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
         ForeColor       =   &H80000007&
         Height          =   255
         Left            =   2070
         TabIndex        =   32
         Top             =   975
         Width           =   3510
      End
      Begin VB.Label lbl_pais 
         BorderStyle     =   1  'Fixed Single
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
         Height          =   255
         Left            =   7950
         TabIndex        =   31
         Top             =   1770
         Width           =   1935
      End
      Begin VB.Label Label12 
         Caption         =   "Fecha de Emisión"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   5790
         TabIndex        =   22
         Top             =   660
         Width           =   1815
      End
      Begin VB.Label Label11 
         Caption         =   "Ciudad"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   5790
         TabIndex        =   21
         Top             =   2100
         Width           =   855
      End
      Begin VB.Label Label9 
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
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   100
         TabIndex        =   20
         Top             =   1005
         Width           =   975
      End
      Begin VB.Label Label7 
         Caption         =   "Moneda Emisiòn"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   5790
         TabIndex        =   19
         Top             =   1020
         Width           =   1815
      End
      Begin VB.Label Label5 
         Caption         =   "Fecha de Vencimiento"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   5790
         TabIndex        =   18
         Top             =   230
         Width           =   2055
      End
      Begin VB.Label Label13 
         BackColor       =   &H00C0FFFF&
         Caption         =   "Indice de Basilea"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   3510
         TabIndex        =   17
         Top             =   2835
         Visible         =   0   'False
         Width           =   1695
      End
      Begin VB.Label Label10 
         Caption         =   "País"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   5790
         TabIndex        =   16
         Top             =   1770
         Width           =   1215
      End
      Begin VB.Label Label8 
         Caption         =   "Rut Ficticio"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   100
         TabIndex        =   15
         Top             =   615
         Width           =   1335
      End
      Begin VB.Label Label6 
         Caption         =   "Tipo de Tasa"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   100
         TabIndex        =   14
         Top             =   255
         Width           =   1815
      End
      Begin VB.Label Label4 
         BackColor       =   &H00C0FFFF&
         Caption         =   "Deducción de Encaje"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   105
         TabIndex        =   13
         Top             =   2790
         Visible         =   0   'False
         Width           =   1695
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   660
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   11295
      _ExtentX        =   19923
      _ExtentY        =   1164
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Filtrar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Datos Del Papel"
            ImageIndex      =   15
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   12
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3420
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   32
         ImageHeight     =   32
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   18
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_ventas.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_ventas.frx":031A
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_ventas.frx":076C
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_ventas.frx":0BBE
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_ventas.frx":0ED8
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_ventas.frx":11F2
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_ventas.frx":1644
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_ventas.frx":179E
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_ventas.frx":1BF0
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_ventas.frx":2042
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_ventas.frx":235C
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_ventas.frx":2676
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_ventas.frx":27D0
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_ventas.frx":2C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_ventas.frx":3074
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_ventas.frx":338E
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_ventas.frx":36A8
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_ventas.frx":39C2
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "Bac_Ventas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim TR          As Double
Dim TE          As Double
Dim TV          As Double
Dim TT          As Double
Dim BA          As Double
Dim BF          As Double
Dim NOM         As Double
Dim MT          As Double
Dim VV          As Double
Dim VP          As Double
Dim PVP         As Double
Dim VAN         As Double
Dim FP          As Date
Dim FE          As Date
Dim FV          As Date
Dim FU          As Date
Dim FX          As Date
Dim FC          As Date
Dim CI          As Double
Dim CT          As Double
Dim INDEV       As Double
Dim PRINC       As Double
Dim FIP         As Date
Dim INCTR       As Double
Dim CAP         As Double

Dim Valoriza As Integer
Dim ModCal

Dim Numdocu     As Double
Dim RutCart     As Double

Function llena_combo_forma_pago()
    Dim datos()
    box_forma_pago.Clear
    If Bac_Sql_Execute("Svc_Ope_fma_pag") Then
        Do While Bac_SQL_Fetch(datos)
            box_forma_pago.AddItem datos(2)
            box_forma_pago.ItemData(box_forma_pago.NewIndex) = Val(datos(1))
        Loop
    End If
    
End Function

Function busca_datos(rut, Cod_cli)

    busca_datos = 0
    If rut = "" Or Not IsNumeric(rut) Then
        Exit Function
    End If
    Dim datos()
    envia = Array()
    AddParam envia, CDbl(rut)
    AddParam envia, CDbl(Cod_cli)
    If Bac_Sql_Execute("Svc_Ope_dat_emi", envia) Then
        Do While Bac_SQL_Fetch(datos)
            If datos(1) <> 0 Then
                lbl_emisor.Caption = datos(1)
            End If
        Loop
    End If
    If datos(1) = 0 Then
        MsgBox "Rut Inexsistente", vbExclamation, gsBac_Version
        lbl_emisor.Caption = ""
        Txt_rut_Emi = ""
        Txt_rut_Emi.SetFocus
        Exit Function
    End If
    busca_datos = datos(1)
End Function

Function busca_tip_tasa(dat)
    Dim datos()
    envia = Array()
    AddParam envia, dat
    If Bac_Sql_Execute(" Svc_Gen_tip_tas", envia) Then
        Do While Bac_SQL_Fetch(datos)
            Txt_Cod_tasa.Caption = datos(1)
            lbl_tip_tasa.Caption = datos(2)
        Loop
    End If
End Function

Function buscar_datos(RutCart As Double, Numdocu As Double)

    Dim datos()
    
    envia = Array()
    AddParam envia, RutCart
    AddParam envia, Numdocu
    
    If Bac_Sql_Execute("Svc_Vnt_dat_ins", envia) Then
    
        Do While Bac_SQL_Fetch(datos)
        
            Txt_Nemo.Text = datos(5)

            BA = CDbl(datos(6))
            txt_tasa_vig.Text = CDbl(datos(7))
            txt_nominal.Text = CDbl(datos(8))
            txt_nominal.Tag = CDbl(datos(8))
            txt_nominal.Max = CDbl(datos(8))
            lbl_val_venc.Caption = Format(CDbl(datos(9)), "###,###,###,###,##0.0000")
            txt_pre_por.Text = CDbl(datos(10))
            txt_tir.Text = CDbl(datos(11))
            Txt_Monto_Pag.Text = CDbl(datos(12))
            txt_fec_emi.Text = Format(datos(16), "DD/MM/YYYY")
            txt_fec_vcto.Text = Format(datos(17), "DD/MM/YYYY")
            Txt_rut_Emi.Text = CDbl(datos(18))
            Call busca_datos(CDbl(datos(18)), CDbl(datos(32)))
            Cod_emi = CDbl(datos(32))
            monemi = Val(datos(19))
            Basilea = Val(datos(20))
            Call busca_tip_tasa(datos(21))
            Cod_emi = CDbl(datos(29))
            If datos(22) = "S" Then
                Op_Encaje_S.Value = True
            Else
                Op_Encaje_N.Value = True
            End If
            lbl_tip_tasa.Caption = lbl_tip_tasa.Caption & " ( " & datos(33) & " )"
            cod_familia = CDbl(datos(28))
            cusip = datos(34)
            For I = 0 To box_mon_pag.ListCount - 1
                box_mon_pag.ListIndex = I
                If box_mon_pag.ItemData(box_mon_pag.ListIndex) = datos(29) Then
                    box_mon_pag.Enabled = False
                    Exit For
                End If
                box_mon_pag.ListIndex = -1
            Next
            
        Loop
    Else
        Exit Function
    End If
    
    txt_fec_vcto.Enabled = False
    txt_fec_emi.Enabled = False
    
    frm_datos_op.Enabled = True
    frm_descrip.Enabled = True
    frm_nemo.Enabled = False
    Toolbar1.Buttons(1).Enabled = True
    Toolbar1.Buttons(3).Enabled = False
    Toolbar1.Buttons(5).Enabled = True
    
    I = 0
    
    For I = 0 To Box_base.ListCount - 1
            Box_base.ListIndex = I
            If Box_base.ItemData(Box_base.ListIndex) = BA Then
                Exit For
            End If
            Box_base.ListIndex = -1
    Next
    
    For I = 0 To box_mon_pag.ListCount - 1
            box_mon_pag.ListIndex = I
            If box_mon_pag.ItemData(box_mon_pag.ListIndex) = datos(29) Then
                Exit For
            End If
            box_mon_pag.ListIndex = -1
    Next

    I = 0
    For I = 0 To box_moneda.ListCount - 1
            box_moneda.ListIndex = I
            If box_moneda.ItemData(box_moneda.ListIndex) = monemi Then
                Exit For
            End If
            box_moneda.ListIndex = -1
    Next

    I = 0
    For I = 0 To box_basilea.ListCount - 1
            box_basilea.ListIndex = I
            If box_basilea.ItemData(box_basilea.ListIndex) = Basilea Then
                Exit For
            End If
            box_basilea.ListIndex = -1
    Next
    
    I = 0
    For I = 0 To box_familia.ListCount - 1
            box_familia.ListIndex = I
            If box_familia.ItemData(box_familia.ListIndex) = cod_familia Then
                Exit For
            End If
            box_familia.ListIndex = -1
    Next
    For I = 0 To Box_base.ListCount - 1
                Box_base.ListIndex = I
                If Box_base.ItemData(Box_base.ListIndex) = CDbl(datos(6)) Then
                    Box_base.Enabled = False
                    Exit For
                End If
                Box_base.ListIndex = -1
    Next
    For I = 0 To box_forma_pago.ListCount - 1
                box_forma_pago.ListIndex = I
                If box_forma_pago.ItemData(box_forma_pago.ListIndex) = CDbl(datos(31)) Then
                    box_forma_pago.Enabled = False
                    Exit For
                End If
                box_forma_pago.ListIndex = -1
    Next
    box_familia.Enabled = False
    Box_base.Enabled = False
    box_basilea.Enabled = False
    box_moneda.Enabled = False
    Txt_rut_Emi.Enabled = False
    txt_tasa_vig.Enabled = False
    TR = CDbl(txt_tir.Text)
    TE = CDbl(txt_tasa_vig.Text)
    TV = CDbl(txt_tasa_vig.Text)
    TT = 0
    BF = 0
    NOM = CDbl(txt_nominal.Text)
    MT = CDbl(Txt_Monto_Pag.Text)
    VV = 0
    PVP = CDbl(txt_pre_por.Text)
    VAN = 0
    FP = CDate(txt_fec_pag.Text)
    FE = CDate(txt_fec_emi.Text)
    FV = CDate(txt_fec_vcto.Text)
    FU = CDate(txt_fec_vcto.Text)
    FX = CDate(txt_fec_vcto.Text)
    FC = CDate(txt_fec_pag.Text)
    CI = 0
    CT = 0
    INDEV = 0
    PRINC = 0
    FIP = CDate(txt_fec_pag.Text)
    INCTR = 0
    CAP = 0
    
    
    box_forma_pago.Enabled = True
End Function

Function Clear_Objetos()
    Txt_Cod_tasa.Caption = " "
    frm_nemo.Enabled = True
    box_familia.Enabled = True
    box_familia.ListIndex = -1
    box_basilea.ListIndex = -1
    box_familia.Enabled = True
    box_mon_pag.ListIndex = -1
    Op_Encaje_S.Value = False
    Op_Encaje_N.Value = False
        
    box_forma_pago.ListIndex = -1
    
    lbl_descrip.Caption = ""
    lbl_tip_tasa.Caption = ""
    Txt_rut_Emi = ""
    lbl_pais.Caption = ""
    lbl_emisor.Caption = ""
    lbl_ciudad.Caption = ""
    
    txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_fec_emi.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_tasa_vig.Text = ""
    txt_fec_neg.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_fec_pag.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_nominal.Text = ""
    txt_tir.Text = ""
    txt_pre_por.Text = ""
    Txt_Monto_Pag.Text = ""
    lbl_int_dev.Caption = ""
    lbl_monto_prin.Caption = ""
    lbl_val_venc.Caption = ""
    box_moneda.ListIndex = -1
    Box_base.Enabled = False
    frm_datos_op.Enabled = False
    frm_descrip.Enabled = False
    frm_basilea.Enabled = False
    
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = True
    
    box_familia.Enabled = False
    Txt_Nemo.Enabled = False
    Toolbar1.Buttons(5).Enabled = False
    Txt_Nemo.Text = ""
    
    Box_base.ListIndex = -1
End Function

Function datos_vacios()

    datos_vacios = True
    
    If txt_fec_emi.Text = "  /  /    " Then
        MsgBox "Falta Ingresar Fecha De Emisión", vbExclamation, gsBac_Version
        txt_fec_emi.SetFocus
        datos_vacios = False
    ElseIf txt_fec_vcto.Text = "  /  /    " Then
        MsgBox "Falta Ingresar fecha De vencimiento", vbExclamation, gsBac_Version
        txt_fec_vcto.SetFocus
        datos_vacios = False
    ElseIf Txt_rut_Emi.Text = "" Then
        MsgBox "Falta Ingresar Rut Emisor Fictisio", vbExclamation, gsBac_Version
        Txt_rut_Emi.SetFocus
        datos_vacios = False
    ElseIf txt_fec_pag.Text = "  /  /    " Then
        MsgBox "Falta INgresar fecha De Pago", vbExclamation, gsBac_Version
        txt_fec_pag.SetFocus
        datos_vacios = False
    ElseIf txt_fec_neg.Text = "  /  /    " Then
        MsgBox "Falta Ingresar Fecha De Negociación", vbExclamation, gsBac_Version
        txt_fec_neg.SetFocus
        datos_vacios = False
    ElseIf CDbl(txt_tasa_vig.Text) = 0 Then
        MsgBox "Falta Ingresar Tasa Vigente", vbExclamation, gsBac_Version
        txt_tasa_vig.SetFocus
        datos_vacios = False
    ElseIf CDbl(txt_nominal) = 0 Then
        MsgBox "Falta Ingresar Nominal", vbExclamation, gsBac_Version
        txt_nominal.SetFocus
        datos_vacios = False
    ElseIf CDbl(txt_tir) = 0 Then
        MsgBox "Falta Ingresar La TIR", vbExclamation, gsBac_Version
        txt_tir.SetFocus
        datos_vacios = False
    ElseIf CDbl(txt_pre_por.Text) = 0 Then
        MsgBox "Falta Ingresar Precio Porcentual", vbExclamation, gsBac_Version
        txt_pre_por.SetFocus
        datos_vacios = False
    ElseIf CDbl(Txt_Monto_Pag.Text) = 0 Then
        MsgBox "Falta Ingrsar Monto A Pagar", vbExclamation, gsBac_Version
        Txt_Monto_Pag.SetFocus
        datos_vacios = False
    ElseIf box_moneda.ListIndex = -1 Then
        MsgBox "Falta Ingrsar Moneda", vbExclamation, gsBac_Version
        box_moneda.SetFocus
        datos_vacios = False
    ElseIf box_basilea.ListIndex = -1 Then
        MsgBox "Falta Ingrsar Basilea", vbExclamation, gsBac_Version
        box_basilea.SetFocus
        datos_vacios = False
    
    End If
    
End Function


Function Grabar_Venta()

    Dim datos()
    Dim Numoper As Double

    gsmoneda = Str(box_moneda.ItemData(box_moneda.ListIndex))
    Tipo_op = "V"
    Bac_Intermediario.Show vbModal
  
    If giAceptar = True Then
    
        envia = Array()
        
        AddParam envia, gsBac_Fecp
        AddParam envia, RutCart
        AddParam envia, Numdocu
        AddParam envia, box_familia.ItemData(box_familia.ListIndex)
        
        If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
            AddParam envia, Txt_Nemo.Text
        Else
            AddParam envia, box_familia.Text
        End If
        
        AddParam envia, Txt_Nemo.Text
        AddParam envia, CDbl(rut_cli)
        AddParam envia, Cod_cli
        AddParam envia, CDate(txt_fec_pag.Text)
        AddParam envia, NOM
        AddParam envia, MT
        AddParam envia, TR
        AddParam envia, PVP
        AddParam envia, VP
        AddParam envia, INDEV
        AddParam envia, PRINC
        AddParam envia, gsBac_User
        AddParam envia, ""
        AddParam envia, obseravcion
        AddParam envia, corr_cli_bco
        AddParam envia, corr_cli_Cta
        AddParam envia, corr_cli_ABA
        AddParam envia, corr_cli_pais
        AddParam envia, 0
        AddParam envia, corr_cli_swi
        AddParam envia, corr_cli_ref
        AddParam envia, corr_bco_bco
        AddParam envia, corr_bco_Cta
        AddParam envia, corr_bco_ABA
        AddParam envia, corr_bco_pais
        AddParam envia, 0
        AddParam envia, corr_bco_swi
        AddParam envia, corr_bco_ref
        AddParam envia, Oper_Con
        AddParam envia, Oper_bech
        AddParam envia, box_mon_pag.ItemData(box_mon_pag.ListIndex)
        AddParam envia, Confirmacion
        AddParam envia, box_forma_pago.ItemData(box_forma_pago.ListIndex)
        AddParam envia, Cod_emi
        AddParam envia, txt_fec_neg.Text
        If Bac_Sql_Execute("Sva_Vnt_grb_ope", envia) Then
            Do While Bac_SQL_Fetch(datos)
                If datos(1) = "SI" Then
                    Numoper = CDbl(datos(2))
                End If
            Loop
            
            If Numoper <> 0 Then
                MsgBox "Operación Grabada Con el Numero " & Numoper, vbInformation, gsBac_Version
                MousePointer = 11
                Call Imprimir_Papeletas("VP", Numoper, gsBac_Papeleta)
                
                If giAceptar And Confirmacion = "1" Then
                    Call imp_fax(Numoper, "VP")
                End If
                
                MousePointer = 1
                Call Clear_Objetos
            End If
            
        End If
        
    End If

End Function

Function llena_combo_base()
    Box_base.Clear
    Box_base.AddItem "30"
    Box_base.ItemData(Box_base.NewIndex) = 30
    Box_base.AddItem "360"
    Box_base.ItemData(Box_base.NewIndex) = 360
    Box_base.AddItem "365"
    Box_base.ItemData(Box_base.NewIndex) = 365
End Function

Function Llena_Combo_basilea()
    Dim datos()
    box_basilea.Clear
    If Bac_Sql_Execute("Svc_Gen_ind_bas") Then
        Do While Bac_SQL_Fetch(datos)
            box_basilea.AddItem datos(2)
            box_basilea.ItemData(box_basilea.NewIndex) = Val(datos(1))
        Loop
    End If
End Function

Function llena_combo_monedas()
    Dim datos()
    box_moneda.Clear
    box_mon_pag.Clear
    If Bac_Sql_Execute("Svc_Ope_cod_mon") Then
        Do While Bac_SQL_Fetch(datos)

            box_moneda.AddItem datos(2)
            box_moneda.ItemData(box_moneda.NewIndex) = Val(datos(1))

            box_mon_pag.AddItem datos(2)
            box_mon_pag.ItemData(box_moneda.NewIndex) = Val(datos(1))
        Loop
            
    End If
End Function

Function llena_combo_nemo()
    Dim datos()
End Function

Function Retorna_num_ope()
    Retorna_num_ope = 0
    Dim datos()
    If Bac_Sql_Execute("Sva_Ope_stg_num") Then
        Do While Bac_SQL_Fetch(datos)
            If Not IsNull(datos(1)) Then
                Retorna_num_ope = datos(1) + 1
            End If
        Loop
    End If
End Function


Function valida_datos()

    valida_datos = True
    
    If Not IsDate(txt_fec_emi.Text) Then
        MsgBox "Falta Ingresar Fecha De Emisión", vbExclamation, gsBac_Version
        txt_fec_emi.SetFocus
        valida_datos = False
    ElseIf Not IsDate(txt_fec_vcto.Text) Then
        MsgBox "Falta Ingresar fecha De vencimiento", vbExclamation, gsBac_Version
        txt_fec_vcto.SetFocus
        valida_datos = False
    ElseIf Op_Encaje_S.Value = False And Op_Encaje_N.Value = False Then
        MsgBox "Falta Ingresar Tipo de Encaje", vbExclamation, gsBac_Version
        valida_datos = False
    ElseIf Txt_rut_Emi.Text = "" Then
        MsgBox "Falta Ingresar Rut Emisor Fictisio", vbExclamation, gsBac_Version
        Txt_rut_Emi.SetFocus
        valida_datos = False

    ElseIf Trim(Txt_Nemo.Text) = "" Then
        MsgBox "Falta Ingresar Id.Instruemmnto", vbExclamation, gsBac_Version
        Txt_Nemo.SetFocus
        valida_datos = False
    ElseIf Not IsDate(txt_fec_pag.Text) Then
        MsgBox "Falta INgresar fecha De Pago", vbExclamation, gsBac_Version
        txt_fec_pag.SetFocus
        valida_datos = False
    ElseIf Not IsDate(txt_fec_neg.Text) Then
        MsgBox "Falta Ingresar Fecha De Negociación", vbExclamation, gsBac_Version
        txt_fec_neg.SetFocus
        valida_datos = False
'    ElseIf CDbl(txt_tasa_vig.Text) = 0 Then
'        MsgBox "Falta Ingresar Tasa Vigente", vbExclamation, Me.Caption
'        txt_tasa_vig.SetFocus
'        valida_datos = False
    ElseIf CDbl(txt_nominal.Text) = 0 Then
        MsgBox "Falta Ingresar Nominal", vbExclamation, gsBac_Version
        txt_nominal.SetFocus
        valida_datos = False
'    ElseIf CDbl(txt_tir) = 0 Then
'        MsgBox "Falta Ingresar La TIR", vbExclamation, Me.Caption
'        txt_tir.SetFocus
'        valida_datos = False
'    ElseIf CDbl(Txt_Pre_Por.Text) = 0 Then
'        MsgBox "Falta Ingresar Precio Porcentual", vbExclamation, Me.Caption
'        Txt_Pre_Por.SetFocus
'        valida_datos = False
    ElseIf CDbl(Txt_Monto_Pag.Text) = 0 Then
        MsgBox "Falta Ingrsar Monto A Pagar", vbExclamation, gsBac_Version
        Txt_Monto_Pag.SetFocus
        valida_datos = False
    ElseIf box_moneda.ListIndex = -1 Then
        MsgBox "Falta Ingrsar Moneda", vbExclamation, gsBac_Version
        box_moneda.SetFocus
        valida_datos = False
    ElseIf box_basilea.ListIndex = -1 Then
        MsgBox "Falta Ingrsar Basilea", vbExclamation, gsBac_Version
        box_basilea.SetFocus
        valida_datos = False
    
    End If
   
End Function


Function Valorizar(ModCal)
Dim datos()

    If Not IsDate(txt_fec_pag.Text) Then
        Exit Function
    End If
    
    If CDbl(txt_nominal.Text) = 0 Then
        Exit Function
    End If
    
    If ModCal = 1 And CDbl(txt_pre_por.Text) = 0 Then
        Exit Function
    End If
    
    If ModCal = 2 And CDbl(txt_tir.Text) = 0 Then
        Exit Function
    End If
    
    
    If ModCal = 3 And CDbl(Txt_Monto_Pag.Text) = 0 Then
        Exit Function
    End If
    
    
    If Not IsDate(txt_fec_emi.Text) Then
        Exit Function
    End If
    
    If Not IsDate(txt_fec_vcto.Text) Then
        Exit Function
    End If
    
    If Not IsDate(txt_fec_neg.Text) Then
        Exit Function
    End If

    If CDbl(txt_tasa_vig.Text) = 0 Then
        Exit Function
    End If
    
    Screen.MousePointer = 11

    
    TR = CDbl(txt_tir.Text)
    TE = CDbl(txt_tasa_vig.Text)
    TV = CDbl(txt_tasa_vig.Text)
    TT = 0
    BF = 0
    NOM = CDbl(txt_nominal.Text)
    MT = CDbl(Txt_Monto_Pag.Text)
    VV = 0
    PVP = CDbl(txt_pre_por.Text)
    VAN = 0
    FP = CDate(txt_fec_pag.Text)
    FE = CDate(txt_fec_emi.Text)
    FV = CDate(txt_fec_vcto.Text)
    FU = CDate(txt_fec_vcto.Text)
    FX = CDate(txt_fec_vcto.Text)
    FC = CDate(txt_fec_pag.Text)
    CI = 0
    CT = 0
    INDEV = 0
    PRINC = 0
    FIP = CDate(txt_fec_pag.Text)
    INCTR = 0
    CAP = 0
    
    envia = Array()
    AddParam envia, CDate(txt_fec_pag.Text)
    AddParam envia, " "
    AddParam envia, ModCal
    AddParam envia, box_familia.ItemData(box_familia.ListIndex)
    
    If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
        AddParam envia, Txt_Nemo.Text
    Else
        AddParam envia, box_familia.Text
    End If
    
    AddParam envia, txt_fec_vcto.Text
    AddParam envia, TR
    AddParam envia, TE
    AddParam envia, TV
    AddParam envia, TT
    AddParam envia, Val(BA)
    AddParam envia, BF
    AddParam envia, NOM
    AddParam envia, MT
    AddParam envia, VV
    AddParam envia, VP
    AddParam envia, PVP
    AddParam envia, VAN
    AddParam envia, FP
    AddParam envia, FE
    AddParam envia, FV
    AddParam envia, FU
    AddParam envia, FX
    AddParam envia, FC
    AddParam envia, CI
    AddParam envia, CT
    AddParam envia, INDEV
    AddParam envia, PRINC
    AddParam envia, FIP
    AddParam envia, INCTR
    AddParam envia, CAP
    AddParam envia, "S"
    AddParam envia, box_moneda.ItemData(box_moneda.ListIndex)
    Dim Num
    
    If Bac_Sql_Execute("Svc_Prc_val_ins", envia) Then
        Do While Bac_SQL_Fetch(datos)
        
            txt_tir.Text = CDbl(datos(1))
            txt_tasa_vig.Text = CDbl(datos(2))
            txt_tasa_vig.Text = CDbl(datos(3))
            txt_nominal.Text = CDbl(datos(7))
            Txt_Monto_Pag.Text = Format(CDbl(datos(8)), "###,###,###,##0.00") 'CDbl(datos(8))
            lbl_val_venc.Caption = Format(CDbl(datos(9)), "###,###,###,##0.00")
            txt_pre_por.Text = CDbl(datos(11))
            txt_fec_neg.Text = Format(datos(13), "DD/MM/YYYY")
            txt_fec_emi.Text = Format(datos(14), "DD/MM/YYYY")
            txt_fec_vcto.Text = Format(datos(15), "DD/MM/YYYY")
            txt_fec_pag.Text = Format(datos(18), "dd/mm/yyyy")
            lbl_int_dev.Caption = Format(CDbl(datos(21)), "###,###,###,###0.00")
            lbl_monto_prin.Caption = Format(CDbl(datos(22)), "###,###,###,###0.00")
            
            TR = CDbl(datos(1))
            TV = CDbl(datos(3))
            MT = CDbl(datos(8))
            VV = CDbl(datos(9))
            VP = CDbl(datos(10))
            PVP = CDbl(datos(11))
            VAN = CDbl(datos(12))
            FU = CDate(Format(datos(16), "dd/mm/yyyy"))
            FX = CDate(Format(datos(17), "dd/mm/yyyy"))
            CI = CDbl((datos(19)))
            CT = CDbl((datos(20)))
            INDEV = CDbl(datos(21))
            PRINC = CDbl(datos(22))
            
        Loop
   End If
            
    Screen.MousePointer = 0
            
End Function

Private Sub box_base_Change()
    If Box_base.ListIndex <> -1 Then
        BA = Box_base.ItemData(Box_base.ListIndex)
    End If
End Sub

Private Sub box_familia_Click()

'    If box_familia.ListIndex = -1 Then
'        Exit Sub
'    End If
'
'    box_familia.Enabled = False
'
'
'    If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
'        box_nemo.Enabled = True
'        Exit Sub
'    Else
'
'        Txt_Nemo.Enabled = True
'        Txt_Nemo.Text = box_familia.Text
'        box_nemo.Enabled = False
'        frm_descrip.Enabled = True
'        frm_datos_op.Enabled = True
'        txt_fec_vcto.Enabled = True
'        txt_fec_emi.Enabled = True
'        Toolbar1.Buttons(1).Enabled = True
'        Toolbar1.Buttons(2).Enabled = True
'
'
'        lbl_tip_tasa.Caption = "Fija"
'        i = 0
'
'        For i = 0 To box_base.ListCount - 1
'                box_base.ListIndex = i
'                If box_base.ItemData(box_base.ListIndex) = 360 Then
'                    Exit For
'                End If
'                box_base.ListIndex = -1
'        Next
'
'        box_base.Enabled = True
'        If box_familia.ListIndex = 1 Then
'            frm_basilea.Enabled = True
'        End If
'        Exit Sub
'    End If
    
End Sub


Private Sub box_moneda_Click()
    If frm_datos_op.Enabled = True Then
        txt_fec_pag.SetFocus
    End If
End Sub


Private Sub box_moneda_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        txt_fec_pag.SetFocus
    End If
End Sub

Private Sub Form_Load()
    Move 0, 0
    
    Toolbar1.Buttons(2).Visible = False
    
    Call Clear_Objetos

    Call llena_combo_familia
    Call llena_combo_nemo
    Call Llena_Combo_basilea
    Call llena_combo_monedas
    Call llena_combo_base
    Call llena_combo_forma_pago
    TR = 0
    TE = 0
    TV = 0
    TT = 0
    BA = 0
    BF = 0
    NOM = 0
    MT = 0
    VV = 0
    VP = 0
    PVP = 0
    VAN = 0
    CI = 0
    CT = 0
    INDEV = 0
    INCTR = 0
    CAP = 0
    Valoriza = False
    ModCal = 2
    frm_datos_op.Enabled = False
    frm_descrip.Enabled = False
    
End Sub
Function llena_combo_familia()
    Dim datos()
    box_familia.Clear
    If Bac_Sql_Execute("Svc_Gen_fam_ins") Then
        Do While Bac_SQL_Fetch(datos)
            box_familia.AddItem datos(2)
            box_familia.ItemData(box_familia.NewIndex) = Val(datos(1))
        Loop
    End If
End Function

Private Sub Text1_Change()

End Sub

Private Sub Option1_Click()

End Sub

Private Sub Option2_Click()

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim I
Select Case Button.Index
    Case 1 'grabar y mostrar cuadro de informacion adicional
        If valida_datos Then
            Call Grabar_Venta
        End If
        
    Case 3

        Bac_Ventas_Filtro.Show vbModal
        
        If giAceptar% = True Then
        
            RutCart = gsBac_VarDouble
            Numdocu = gsBac_VarDouble2
            
            Call buscar_datos(RutCart, Numdocu)
            
        End If
        
    Case 4
        Call Clear_Objetos
    Case 5
        
        Num_Docu = gsBac_VarDouble2
        Rut_Cart = tgsBac_VarDouble
        Bac_Ventas_DetalleInst.Show vbModal
    Case 6
        Unload Me
End Select
End Sub

Private Sub txt_fec_emi_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        If Not IsDate(txt_fec_emi) Then
            txt_fec_emi.Text = "  /  /    "
            txt_fec_emi.SetFocus
        Else
            box_moneda.SetFocus
        End If
    Else
        Valoriza = True
    End If
End Sub


Private Sub txt_fec_emi_LostFocus()

    If Valoriza = True Then
        Call Valorizar(ModCal)
        Valoriza = False
    End If


End Sub

Private Sub txt_fec_neg_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        If Not IsDate(txt_fec_neg.Text) Then
            txt_fec_neg.Text = "  /  /    "
            If frm_datos_op.Enabled = True Then
                txt_fec_neg.SetFocus
            End If
            Exit Sub
        End If
        SendKeys "(TAB)"
    Else
            Valoriza = True
    End If
End Sub

Private Sub txt_fec_neg_LostFocus()
    If Valoriza = True Then
        Call Valorizar(ModCal)
        Valoriza = False
    End If
    
End Sub


Private Sub txt_fec_pag_KeyPress(KeyAscii As Integer)
        
    If KeyAscii = 13 Then
        txt_nominal.SetFocus
    Else
        Valoriza = True
    End If
End Sub


Private Sub txt_fec_pag_LostFocus()
    If Valoriza = True Then
        Call Valorizar(ModCal)
        Valoriza = False
    End If
    If Not IsDate(txt_fec_pag.Text) Then
            txt_fec_pag.Text = "  /  /    "
    End If
End Sub


Private Sub txt_fec_vcto_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        If Not IsDate(txt_fec_vcto) Then
            txt_fec_vcto.Text = "  /  /    "
            txt_fec_vcto.SetFocus
        Else
            txt_fec_emi.SetFocus
        End If
    Else
        Valoriza = True
    End If
End Sub


Private Sub lbl_int_dev_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        txt_nominal.SetFocus
    End If
End Sub


Private Sub txt_fec_vcto_LostFocus()

    If Valoriza = True Then
        Call Valorizar(ModCal)
        Valoriza = False
    End If

End Sub

Private Sub Txt_Monto_Pag_GotFocus()

    Txt_Monto_Pag.Tag = Txt_Monto_Pag.Text

End Sub

Private Sub txt_monto_pag_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        KeyAscii = 0
        txt_nominal.SetFocus
    End If

End Sub


Private Sub txt_monto_pag_LostFocus()

    If Txt_Monto_Pag.Tag <> Txt_Monto_Pag.Text Then
        ModCal = 3
        Call Valorizar(ModCal)
    End If

End Sub



Private Sub Txt_Nominal_GotFocus()
    txt_nominal.Tag = txt_nominal.Text
End Sub

Private Sub txt_nominal_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        KeyAscii = 0
        txt_tir.SetFocus
    End If
End Sub


Private Sub Txt_Nominal_LostFocus()
    If txt_nominal.Tag <> txt_nominal.Text Then
        Call Valorizar(ModCal)
    End If
End Sub


Private Sub Txt_Pre_Por_GotFocus()
    Txt_Monto_Pag.Tag = Txt_Monto_Pag.Text
End Sub

Private Sub txt_pre_por_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        KeyAscii = 0
        Txt_Monto_Pag.SetFocus
    End If

End Sub


Private Sub txt_pre_por_LostFocus()

    If Txt_Monto_Pag.Tag <> Txt_Monto_Pag.Text Then
        ModCal = 1
        Call Valorizar(ModCal)
    End If

End Sub



Private Sub txt_rut_emi_DblClick()
    BacAyuda.Tag = "MDCL"
    BacAyuda.Show 1
    
    If giAceptar% = True Then
        Txt_rut_Emi.Text = Val(gsrut$)
        lbl_emisor.Caption = gsDescripcion$
        Cod_emi = CDbl(gsvalor$)
    Else
        SendKeys "{TAB}"
    End If

End Sub

Private Sub txt_rut_emi_KeyPress(KeyAscii As Integer)

    BacCaracterNumerico KeyAscii
    
    If KeyAscii = 13 Then SendKeys "{TAB}"
    
End Sub


Private Sub txt_rut_emi_LostFocus()
    'Call busca_datos(Txt_rut_Emi.Text)
End Sub


Private Sub txt_tasa_vig_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        txt_nominal.SetFocus
    Else
        Valoriza = True
    End If
End Sub


Private Sub txt_tasa_vig_LostFocus()
    If Valoriza = True Then
        Call Valorizar(ModCal)
        Valoriza = False
    End If
End Sub


Private Sub txt_tir_GotFocus()

    txt_tir.Tag = txt_tir.Text

End Sub

Private Sub txt_tir_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        KeyAscii = 0
        txt_pre_por.SetFocus
    End If

End Sub


Private Sub txt_tir_LostFocus()
    If txt_tir.Tag <> txt_tir.Text Then
        ModCal = 2
        Call Valorizar(ModCal)
    End If
End Sub


Private Sub TxtNominal_NumeroInvalido()

End Sub


