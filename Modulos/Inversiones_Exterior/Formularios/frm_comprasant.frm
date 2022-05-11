VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form Bac_Compras 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Compras de Inversiones en el Exterior"
   ClientHeight    =   6480
   ClientLeft      =   165
   ClientTop       =   1815
   ClientWidth     =   11295
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6480
   ScaleWidth      =   11295
   Begin VB.Frame frm_nemo 
      Height          =   1140
      Left            =   105
      TabIndex        =   53
      Top             =   510
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
         Left            =   1725
         MaxLength       =   20
         TabIndex        =   3
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
      Begin VB.ComboBox box_nemo 
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
         Left            =   5565
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   180
         Width           =   3585
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
         TabIndex        =   62
         Top             =   675
         Width           =   1335
      End
      Begin VB.Label Label3 
         Alignment       =   1  'Right Justify
         Caption         =   "Serie Bono"
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
         Left            =   4035
         TabIndex        =   56
         Top             =   255
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
         TabIndex        =   55
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
         TabIndex        =   54
         Top             =   675
         Width           =   5280
      End
   End
   Begin VB.Frame frm_datos_op 
      Caption         =   "Datos de la Operación"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000015&
      Height          =   2160
      Left            =   105
      TabIndex        =   39
      Top             =   4260
      Width           =   11055
      Begin BACControles.TXTNumero Txt_Monto_Pag 
         Height          =   300
         Left            =   7920
         TabIndex        =   18
         Top             =   1560
         Width           =   2595
         _ExtentX        =   4577
         _ExtentY        =   529
         BackColor       =   -2147483639
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,00"
         Text            =   "0,00"
         Min             =   "0"
         Max             =   "999999999.99"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txt_pre_por 
         Height          =   300
         Left            =   7920
         TabIndex        =   17
         Top             =   240
         Width           =   1965
         _ExtentX        =   3466
         _ExtentY        =   529
         BackColor       =   -2147483639
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
      Begin BACControles.TXTNumero txt_tasa_vig 
         Height          =   300
         Left            =   2040
         TabIndex        =   14
         Top             =   1080
         Width           =   1965
         _ExtentX        =   3466
         _ExtentY        =   529
         BackColor       =   16777215
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
         Text            =   "0,00000"
         Text            =   "0,00000"
         Min             =   "0"
         Max             =   "999.99999"
         CantidadDecimales=   "5"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txt_nominal 
         Height          =   300
         Left            =   2040
         TabIndex        =   15
         Top             =   1440
         Width           =   2595
         _ExtentX        =   4577
         _ExtentY        =   529
         BackColor       =   16777215
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
      Begin BACControles.TXTNumero txt_tir 
         Height          =   300
         Left            =   2040
         TabIndex        =   16
         Top             =   1800
         Width           =   1965
         _ExtentX        =   3466
         _ExtentY        =   529
         BackColor       =   16777215
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
      Begin BACControles.TXTFecha txt_fec_neg 
         Height          =   285
         Left            =   2040
         TabIndex        =   12
         Top             =   300
         Width           =   1965
         _ExtentX        =   3466
         _ExtentY        =   503
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
         MinDate         =   2
         Text            =   "18/06/2002"
      End
      Begin BACControles.TXTFecha txt_fec_pag 
         Height          =   285
         Left            =   2040
         TabIndex        =   13
         Top             =   675
         Width           =   1965
         _ExtentX        =   3466
         _ExtentY        =   503
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
         MinDate         =   2
         Text            =   "18/06/2002"
      End
      Begin VB.Label Label29 
         Caption         =   "%"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   4200
         TabIndex        =   68
         Top             =   1800
         Width           =   510
      End
      Begin VB.Label Label28 
         Caption         =   "%"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   4200
         TabIndex        =   67
         Top             =   1125
         Width           =   510
      End
      Begin VB.Label Label1 
         Caption         =   "%"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   9960
         TabIndex        =   64
         Top             =   300
         Width           =   330
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
         Left            =   7920
         TabIndex        =   61
         Top             =   720
         Width           =   2595
      End
      Begin VB.Label Label23 
         Caption         =   "Principal a Pagar"
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
         Left            =   5745
         TabIndex        =   60
         Top             =   675
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
         Left            =   7920
         TabIndex        =   58
         Top             =   1125
         Width           =   2595
      End
      Begin VB.Label lbl_int 
         Caption         =   "Interés Dev. a Pagar"
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
         Left            =   5745
         TabIndex        =   57
         Top             =   1140
         Width           =   1680
      End
      Begin VB.Label lbl_spread 
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
         Left            =   2250
         TabIndex        =   50
         Top             =   2310
         Visible         =   0   'False
         Width           =   1500
      End
      Begin VB.Label Label22 
         Caption         =   "Tasa Cupón"
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
         TabIndex        =   47
         Top             =   1095
         Width           =   1695
      End
      Begin VB.Label Label21 
         Caption         =   "Spread"
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
         TabIndex        =   46
         Top             =   2310
         Visible         =   0   'False
         Width           =   1335
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
         Left            =   5745
         TabIndex        =   45
         Top             =   300
         Width           =   1815
      End
      Begin VB.Label Label19 
         Caption         =   "TIR Compra"
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
         TabIndex        =   44
         Top             =   1770
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
         TabIndex        =   43
         Top             =   675
         Width           =   1800
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
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   5745
         TabIndex        =   42
         Top             =   1590
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
         TabIndex        =   41
         Top             =   1455
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
         TabIndex        =   40
         Top             =   300
         Width           =   2055
      End
   End
   Begin VB.Frame frm_descrip 
      Caption         =   "Descripción"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000015&
      Height          =   2580
      Left            =   105
      TabIndex        =   29
      Top             =   1650
      Width           =   11055
      Begin BACControles.TXTNumero txt_cod_emi 
         Height          =   300
         Left            =   4080
         TabIndex        =   71
         Top             =   660
         Width           =   495
         _ExtentX        =   873
         _ExtentY        =   529
         BackColor       =   16777215
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
      End
      Begin VB.ComboBox Box_base 
         Height          =   315
         Left            =   2025
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   1665
         Width           =   1965
      End
      Begin VB.ComboBox box_año 
         Height          =   315
         Left            =   3090
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   2040
         Visible         =   0   'False
         Width           =   870
      End
      Begin VB.ComboBox box_dia 
         Height          =   315
         Left            =   2025
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   2040
         Visible         =   0   'False
         Width           =   870
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
         Left            =   7935
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   2100
         Width           =   2595
      End
      Begin VB.ComboBox box_mon_pag 
         Height          =   315
         Left            =   7935
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   1425
         Width           =   2595
      End
      Begin VB.ComboBox box_mon_emi 
         Height          =   315
         Left            =   7935
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   1050
         Width           =   2595
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
         Height          =   300
         Left            =   2025
         TabIndex        =   19
         Top             =   660
         Width           =   1965
      End
      Begin VB.TextBox txt_rut_emis 
         Height          =   285
         Left            =   9090
         MaxLength       =   8
         TabIndex        =   59
         Top             =   3630
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
         Left            =   6300
         Style           =   2  'Dropdown List
         TabIndex        =   27
         Top             =   2685
         Visible         =   0   'False
         Width           =   1980
      End
      Begin VB.Frame frm_basilea 
         BackColor       =   &H00C0FFFF&
         Enabled         =   0   'False
         Height          =   450
         Left            =   2010
         TabIndex        =   51
         Top             =   2625
         Visible         =   0   'False
         Width           =   1380
         Begin VB.OptionButton Op_Encaje_N 
            Caption         =   "No"
            Height          =   300
            Left            =   735
            TabIndex        =   25
            Top             =   120
            Width           =   510
         End
         Begin VB.OptionButton Op_Encaje_S 
            Caption         =   "Sí"
            Height          =   285
            Left            =   75
            TabIndex        =   24
            Top             =   135
            Width           =   465
         End
      End
      Begin BACControles.TXTFecha txt_fec_vcto 
         Height          =   285
         Left            =   7935
         TabIndex        =   8
         Top             =   690
         Width           =   1965
         _ExtentX        =   3466
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
         Text            =   "26/10/2001"
      End
      Begin BACControles.TXTFecha txt_fec_emi 
         Height          =   285
         Left            =   7935
         TabIndex        =   7
         Top             =   255
         Width           =   1965
         _ExtentX        =   3466
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
         Text            =   "26/10/2001"
      End
      Begin VB.Label Label35 
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   2925
         TabIndex        =   20
         Top             =   2040
         Visible         =   0   'False
         Width           =   150
      End
      Begin VB.Label Label34 
         Caption         =   "Bases De Tasas"
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
         TabIndex        =   21
         Top             =   1710
         Width           =   1455
      End
      Begin VB.Label Label31 
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
         Left            =   5790
         TabIndex        =   22
         Top             =   2100
         Width           =   1590
      End
      Begin VB.Label Label32 
         Caption         =   "Monto Emisión"
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
         TabIndex        =   70
         Top             =   1350
         Width           =   1590
      End
      Begin VB.Label lbl_monto_emi 
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
         Height          =   285
         Left            =   2025
         TabIndex        =   26
         Top             =   1335
         Width           =   1965
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
         TabIndex        =   69
         Top             =   1425
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
         Height          =   270
         Left            =   2025
         TabIndex        =   63
         Top             =   285
         Width           =   615
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
         Height          =   270
         Left            =   2745
         TabIndex        =   52
         Top             =   285
         Width           =   2790
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
         Left            =   2025
         TabIndex        =   49
         Top             =   1005
         Width           =   3465
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
         Left            =   7935
         TabIndex        =   48
         Top             =   1770
         Width           =   1965
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
         TabIndex        =   38
         Top             =   255
         Width           =   1815
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
         TabIndex        =   37
         Top             =   1005
         Width           =   975
      End
      Begin VB.Label Label7 
         Caption         =   "Moneda Emisión"
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
         TabIndex        =   36
         Top             =   1050
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
         TabIndex        =   35
         Top             =   690
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
         Left            =   4380
         TabIndex        =   34
         Top             =   2700
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
         TabIndex        =   33
         Top             =   1770
         Width           =   1215
      End
      Begin VB.Label Label8 
         Caption         =   "Rut Emisor"
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
         TabIndex        =   32
         Top             =   660
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
         TabIndex        =   31
         Top             =   285
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
         Height          =   420
         Left            =   90
         TabIndex        =   30
         Top             =   2595
         Visible         =   0   'False
         Width           =   1695
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11295
      _ExtentX        =   19923
      _ExtentY        =   847
      ButtonWidth     =   714
      ButtonHeight    =   688
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3240
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   20
         ImageHeight     =   20
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   5
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_compras.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_compras.frx":0452
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_compras.frx":08A4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_compras.frx":0BBE
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_compras.frx":0ED8
               Key             =   ""
            EndProperty
         EndProperty
      End
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
      Left            =   2130
      TabIndex        =   23
      Top             =   0
      Visible         =   0   'False
      Width           =   1995
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
      Left            =   0
      TabIndex        =   28
      Top             =   0
      Visible         =   0   'False
      Width           =   1695
   End
   Begin VB.Label Label27 
      Caption         =   "%"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   255
      Left            =   0
      TabIndex        =   66
      Top             =   0
      Width           =   480
   End
   Begin VB.Label Label26 
      Caption         =   "%"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   255
      Left            =   0
      TabIndex        =   65
      Top             =   0
      Width           =   480
   End
End
Attribute VB_Name = "Bac_Compras"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim TR          As Double
Dim TE          As Double
Dim TV          As Double
Dim TT          As Double
Dim BA          As Double
Dim BF           As Double
Dim NOM       As Double
Dim MT          As Double
Dim VV           As Double
Dim VP           As Double
Dim PVP         As Double
Dim VAN        As Double
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
Dim FIP          As Date
Dim INCTR       As Double
Dim CAP         As Double


Dim Valoriza As Integer
Dim ModCal


Function busca_datos(rut, Cod_emi)
    busca_datos = 0
    If rut = "" Or Not IsNumeric(rut) Then
        Exit Function
    End If
    
    Dim datos()
    envia = Array()
    AddParam envia, CDbl(rut)
    AddParam envia, CDbl(Cod_emi)
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

Function buscar_datos(cod, nemo, vcto)

    If box_familia.ListIndex = -1 Then
        MsgBox "No ha Selecccionado Familia", vbExclamation, gsBac_Version
        Exit Function
    End If


    If box_familia.ListIndex = 0 Then
    
        If box_nemo.ListIndex = -1 Then
            MsgBox "No ha Selecccionado Instrumento", vbExclamation, gsBac_Version
            Exit Function
        End If
    End If
    
    Dim datos()
    envia = Array()
    AddParam envia, nemo
    AddParam envia, vcto
    If Bac_Sql_Execute("Svc_Ayd_ser_ins", envia) Then
        Do While Bac_SQL_Fetch(datos)
            lbl_descrip.Caption = datos(3)
            Txt_rut_Emi.Text = CDbl(datos(4))
            lbl_emisor.Caption = datos(20)
            box_basilea.ListIndex = (Val(datos(6)) - 1)
            txt_fec_emi.Text = Format(datos(9), "DD/MM/YYYY")
            txt_fec_vcto.Text = Format(datos(10), "DD/MM/YYYY")
            If datos(11) = "S" Then
                Op_Encaje_S.Value = True
            Else
                Op_Encaje_N.Value = True
            End If
            Limpio = True
            txt_tasa_vig.Text = CDbl(datos(14))
            BA = datos(17)
            For I = 0 To box_mon_emi.ListCount - 1
                box_mon_emi.ListIndex = I
                If box_mon_emi.ItemData(box_mon_emi.ListIndex) = datos(21) Then
                    box_mon_emi.Enabled = False
                    Exit For
                End If
                box_mon_emi.ListIndex = -1
            Next
            For I = 0 To box_mon_pag.ListCount - 1
                box_mon_pag.ListIndex = I
                If box_mon_pag.ItemData(box_mon_pag.ListIndex) = datos(22) Then
                    box_mon_pag.Enabled = False
                    Exit For
                End If
                box_mon_pag.ListIndex = -1
            Next
            lbl_monto_emi.Caption = Format(datos(19), "0,0.0000")
        Loop
        
    End If
    Call busca_tip_tasa(datos(5))
    If Trim(UCase(lbl_tip_tasa.Caption)) = "FIJA" Or Trim(UCase(lbl_tip_tasa.Caption)) = "FIXED" Then
        txt_tasa_vig.Enabled = False
    Else
        txt_tasa_vig.Enabled = True
    End If
    For I = 0 To box_año.ListCount - 1
        box_año.ListIndex = I
        If box_año.Text = datos(13) Then
            Exit For
        End If
        box_año.ListIndex = -1
    Next
    Box_base.ListIndex = box_año.ListIndex

    If datos(16) = "T" Then
        For I = 0 To box_dia.ListCount - 1
            box_dia.ListIndex = I
            If box_dia.Text = "Real" Then
                Exit For
            End If
            box_dia.ListIndex = -1
        Next
    ElseIf datos(16) = "F" Then
        For I = 0 To box_dia.ListCount - 1
            box_dia.ListIndex = I
            If box_dia.Text = "30" Then
                Exit For
            End If
            box_dia.ListIndex = -1
        Next
    End If
    txt_fec_vcto.Enabled = False
    txt_fec_emi.Enabled = False
    
    frm_datos_op.Enabled = True
    frm_descrip.Enabled = True
    frm_nemo.Enabled = False
    Toolbar1.Buttons(1).Enabled = True
    Toolbar1.Buttons(2).Enabled = True
    I = 0
    For I = 0 To box_año.ListCount - 1
            box_año.ListIndex = I
            If box_año.Text = BA Then
                Exit For
            End If
            box_año.ListIndex = -1
    Next
    Box_base.ListIndex = box_año.ListIndex

    box_dia.Enabled = False
    box_año.Enabled = False
    Box_base.Enabled = False
    box_nemo.Enabled = False
    Cod_emi = CDbl(datos(25))
    txt_cod_emi.Text = CDbl(datos(25))
   If box_familia.ListIndex > 0 Then
       lbl_monto_emi.Caption = " "
    End If
    Call buscar_pais(CDbl(datos(4)), CDbl(datos(25)))
End Function

Function Clear_Objetos()
    Limpio = False
    Me.lbl_tip_tasa.Caption = " "
'   txt_monto_emi.Text = " "
'   txt_monto_emi.Enabled = False
    txt_cod_emi.Visible = False
    txt_cod_emi.Text = " "
    box_dia.ListIndex = -1
    box_año.ListIndex = -1
    Box_base.ListIndex = -1
    frm_nemo.Enabled = True
    box_nemo.Enabled = True
    box_nemo.ListIndex = -1
    box_familia.Enabled = True
    box_familia.ListIndex = -1
    box_basilea.ListIndex = -1
    box_familia.Enabled = True
    box_nemo.Enabled = False
    Txt_rut_Emi.Enabled = False
    Txt_rut_Emi.BackColor = &H80000004
    Op_Encaje_S.Value = False
    Op_Encaje_N.Value = False
    lbl_monto_emi.Caption = " "
    
    box_forma_pago.ListIndex = -1
    lbl_descrip.Caption = ""
    lbl_tip_tasa.Caption = ""
    Txt_rut_Emi = ""
    lbl_pais.Caption = ""
    lbl_emisor.Caption = ""
    
    txt_fec_emi.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_tasa_vig.Text = 0
    txt_fec_neg.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_fec_pag.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_nominal.Text = ""
    txt_tir.Text = ""
    txt_pre_por.Text = ""
    Txt_Monto_Pag.Text = ""
    lbl_int_dev.Caption = ""
    lbl_monto_prin.Caption = ""
    lbl_val_venc.Caption = ""
    box_mon_emi.ListIndex = -1
    box_mon_pag.ListIndex = -1
    frm_datos_op.Enabled = False
    frm_descrip.Enabled = False
    frm_basilea.Enabled = False
    
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    
    Txt_Nemo.Enabled = False
    Txt_Nemo.Text = ""

    
    
    
    
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



Function Feriados_inter(Fecha, pais)

    Dim datos()
    Dim Feriados As String
    Dim Ano As Double
    Dim Mes As Double
    Dim Dia As Double
    Dim dia_1 As Integer
    Dim I As Double
    Dia = Format(Mid(Fecha, 1, 2), "00")
    Mes = Format(Mid(Fecha, 4, 2), "00")
    Ano = Format(Mid(Fecha, 7, 4), "0000")
    envia = Array()
    AddParam envia, Ano
    AddParam envia, pais
    AddParam envia, Mes
    If Bac_Sql_Execute("Svc_Ope_lee_frd ", envia) Then
        Do While Bac_SQL_Fetch(datos)
            If datos(1) = 1 Then
                Feriados_inter = True
                Exit Function
            Else
                Feriados = datos(3)
            End If
        Loop
    End If
    Feriados = Trim(Feriados)
    If Feriados = "" Then
        Feriados_inter = True
        Exit Function
    End If
    For I = 1 To 100
        If (Mid(Feriados, I, 1)) = "," Then
            I = I + 1
        End If
        If Mid(Feriados, I, 2) = "" Then
            Feriados_inter = True
            Exit Function
        End If
        dia_1 = CDbl(Mid(Feriados, I, 2))
        I = I + 1
        If Dia = dia_1 Then
            Feriados_inter = False
            Exit Function
        End If
    Next I
    Feriados_inter = True
End Function

Function Grabar_compra()

    Dim datos()
    Dim Numoper As Double
    gsmoneda = Str(box_mon_pag.ItemData(box_mon_pag.ListIndex))
    
    Tipo_op = "C"
    
    Bac_Intermediario.Show vbModal
    
    
    If giAceptar = True Then
    
    
        Screen.MousePointer = 11
    
        
        Dim Op
        If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
             Op = Feriados_inter(txt_fec_pag.Text, Pais_invers)
         Else
             Op = Feriados_inter(txt_fec_pag.Text, Pais_invers)
         End If
         
         If Op = False Then
             MsgBox "Fecha De Pago en el Pais De origen Es Feriado", vbInformation, gsBac_Version
            Screen.MousePointer = 0
             txt_fec_pag.SetFocus
             Exit Function
         End If
        envia = Array()
        AddParam envia, gsBac_Fecp
        AddParam envia, CDbl(gsBac_RutC)
        AddParam envia, box_familia.ItemData(box_familia.ListIndex)
        
        If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
            AddParam envia, Trim(Txt_Nemo.Text)
        Else
            AddParam envia, box_familia.Text
        End If
        
        AddParam envia, Txt_Nemo.Text
        AddParam envia, CDbl(rut_cli)
        AddParam envia, Cod_cli
        AddParam envia, FE
        AddParam envia, FV
        AddParam envia, box_mon_emi.ItemData(box_mon_emi.ListIndex)
        AddParam envia, box_mon_pag.ItemData(box_mon_pag.ListIndex)
        AddParam envia, TE
        AddParam envia, BA
        AddParam envia, CDbl(Txt_rut_Emi.Text)
        AddParam envia, CDate(txt_fec_pag.Text)
        AddParam envia, CDbl(NOM)
        AddParam envia, CDbl(MT)
        AddParam envia, CDbl(VV)
        AddParam envia, CDbl(TR)
        AddParam envia, CDbl(PVP)
        AddParam envia, CDbl(VP)
        AddParam envia, CDbl(INDEV)
        AddParam envia, PRINC
        AddParam envia, CDbl(CI - 1)
        AddParam envia, CI
        AddParam envia, FU
        AddParam envia, FX
        AddParam envia, gsBac_User
        AddParam envia, ""
        AddParam envia, obseravcion
        AddParam envia, box_basilea.ItemData(box_basilea.ListIndex)
        If box_familia.ListIndex > 0 Then
            AddParam envia, 100
        Else
            AddParam envia, Val(Txt_Cod_tasa.Caption)
        End If
        
        If Op_Encaje_S.Value = True Then
            AddParam envia, "S"
        Else
            AddParam envia, "N"
        End If
        
        AddParam envia, 0
        AddParam envia, codigo_cartera_super
        AddParam envia, ""
        AddParam envia, Sucursal
        AddParam envia, corr_cli_bco
        AddParam envia, corr_cli_Cta
        AddParam envia, (corr_cli_ABA)
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
        If calce = 1 Then
            AddParam envia, "S"
        Else
            AddParam envia, "N"
        End If
        AddParam envia, tipo_inversion
        AddParam envia, para_quien
        AddParam envia, ""
        AddParam envia, ""
        AddParam envia, ""
        AddParam envia, custodia
        If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
            AddParam envia, CDbl(lbl_monto_emi.Caption)
        Else
            AddParam envia, 0
        End If

        AddParam envia, CDbl(Confirmacion)
        AddParam envia, box_forma_pago.ItemData(box_forma_pago.ListIndex)
        AddParam envia, box_dia.Text & " - " & box_año.Text
        AddParam envia, CDbl(Cod_emi)
        AddParam envia, txt_fec_neg.Text
        AddParam envia, cusip
        If Bac_Sql_Execute("Sva_Cmp_grb_ope", envia) Then
            Do While Bac_SQL_Fetch(datos)
                If datos(1) = "SI" Then
                    Numoper = CDbl(datos(2))
                End If
            Loop

            If Numoper <> 0 Then
                MsgBox "Operación Grabada Con el Numero " & Numoper, vbInformation, gsBac_Version
                
                Call Imprimir_Papeletas("CP", Numoper, gsBac_Papeleta)

                If giAceptar And Confirmacion = "1" Then
                    Call imp_fax(Numoper, "CP")
                End If
                
                Call Clear_Objetos
            End If
            
        End If
        
        Screen.MousePointer = 0
        
    End If

End Function

Function llena_combo_base()
    
End Function

Function llena_combo_bases_tasas()
    Dim datos()
    box_dia.Clear
    box_año.Clear
    Box_base.Clear
    If Bac_Sql_Execute("Svc_Ope_lee_tas") Then
        Do While Bac_SQL_Fetch(datos)
            box_dia.AddItem datos(1)
            box_año.AddItem datos(2)
            Box_base.AddItem datos(3)
        Loop
    End If
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

Function llena_combo_nemo()
    Dim datos()
    box_nemo.Clear
    If Bac_Sql_Execute("Svc_Gen_lee_ser") Then
        Do While Bac_SQL_Fetch(datos)
            box_nemo.AddItem datos(2) & Space(20 - Len(datos(2))) & " (" & Format(datos(3), "DD/MM/YYYY") & ") "
            box_nemo.ItemData(box_nemo.NewIndex) = Val(datos(1))
        Loop
    End If
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
'    If txt_monto_emi.Visible = True Then
'        If CDbl(txt_monto_emi.Text) = 0 Then
'            MsgBox "Falta Ingresar Monto de Emisión", vbExclamation, Me.Caption
'            txt_monto_emi.SetFocus
'            Valida_datos = False
'            Exit Function
'        End If
'    End If
    If DateDiff("D", CDate(txt_fec_pag.Text), CDate(txt_fec_vcto.Text)) < 1 Then
        MsgBox "Instrumento esta Vencido", vbExclamation, gsBac_Version
        valida_datos = False
        Exit Function
    



    ElseIf Not IsDate(txt_fec_emi.Text) Then
        MsgBox "Falta Ingresar Fecha De Emisión", vbExclamation, gsBac_Version
        txt_fec_emi.SetFocus
        valida_datos = False
    ElseIf Not IsDate(txt_fec_vcto.Text) Then
        MsgBox "Falta Ingresar fecha De vencimiento", vbExclamation, gsBac_Version
        txt_fec_vcto.SetFocus
        valida_datos = False
    ElseIf Op_Encaje_S.Value = False And Op_Encaje_N.Value = False Then
'        frm_encaje.
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
    
    ElseIf box_basilea.ListIndex = -1 Then
        MsgBox "Falta Ingrsar Basilea", vbExclamation, gsBac_Version
        box_basilea.SetFocus
        valida_datos = False
    
    End If
    
    If txt_cod_emi.Text = " " Then
        MsgBox "Ingrese Código de Emisor", vbInformation, gsBac_Version
        valida_datos = False
        txt_cod_emi.SetFocus
        Exit Function
    End If
    
    
End Function



Function Valorizar(ModCal)
Dim datos()
Dim Op
Op = DateDiff("D", txt_fec_emi.Text, txt_fec_vcto.Text)
    If Op < 0 And Me.frm_descrip.Enabled = True Then
        MsgBox "Fecha de Vencimiento Menor A Fecha De Emisión", vbCritical, gsBac_Version
        txt_fec_emi.SetFocus
    End If
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
    
    
    If DateDiff("D", CDate(txt_fec_pag.Text), CDate(txt_fec_vcto.Text)) < 1 Then
        MsgBox "Instrumento esta Vencido", vbExclamation, gsBac_Version
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
    INCTR = 0
    CAP = 0
    BA = CDbl(box_año.Text)
    
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
    AddParam envia, box_mon_emi.ItemData(box_mon_emi.ListIndex)
    Dim Num
    
    If Bac_Sql_Execute("Svc_Prc_val_ins", envia) Then
        Do While Bac_SQL_Fetch(datos)
        
            txt_tir.Text = CDbl(datos(1))
            txt_tasa_vig.Text = CDbl(datos(2))
            txt_tasa_vig.Text = CDbl(datos(3))
            txt_nominal.Text = CDbl(datos(7))
            Txt_Monto_Pag.Text = CDbl(datos(8))
            lbl_val_venc.Caption = Format(CDbl(datos(9)), "###,###,###,##0.0000")
            txt_pre_por.Text = CDbl(datos(11))
'           txt_fec_neg.Text = Format(datos(13), "DD/MM/YYYY")
            txt_fec_emi.Text = Format(datos(14), "DD/MM/YYYY")
            txt_fec_vcto.Text = Format(datos(15), "DD/MM/YYYY")
            txt_fec_pag.Text = Format(datos(18), "dd/mm/yyyy")
            lbl_int_dev.Caption = Format(CDbl(datos(21)), "###,###,###,###0.0000")
            lbl_monto_prin.Caption = Format(CDbl(datos(22)), "###,###,###,###0.0000")
            
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

Private Sub box_base_Click()
    box_dia.ListIndex = Box_base.ListIndex
    box_año.ListIndex = Box_base.ListIndex
End Sub


Private Sub box_base_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
        SendKeys "{TAB}"
End If
End Sub


Private Sub box_año_Click()

        SendKeys "{TAB}"

End Sub


Private Sub box_año_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub


Private Sub box_basilea_GotFocus()
    box_basilea.ListIndex = 0
End Sub


Private Sub box_basilea_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub



Private Sub box_dia_Click()
    SendKeys "{TAB}"
End Sub


Private Sub box_dia_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub


Private Sub box_familia_Click()

    If box_familia.ListIndex = -1 Then
        Exit Sub
    End If

    box_familia.Enabled = False
        
    If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
        box_nemo.Enabled = True
        box_año.Enabled = True
        box_dia.Enabled = True
        Box_base.Enabled = True
        Exit Sub
    Else
        Limpio = True
        txt_cod_emi.Visible = True
        Txt_rut_Emi.MousePointer = 14
'       txt_monto_emi.Enabled = True
'       lbl_monto_emi.Visible = False
'       txt_monto_emi.Visible = True
'       txt_monto_emi.Left = lbl_monto_emi.Left
'       txt_monto_emi.Top = lbl_monto_emi.Top
        Txt_Nemo.Enabled = True
        Txt_Nemo.Text = box_familia.Text
        box_nemo.Enabled = False
        frm_descrip.Enabled = True
        frm_datos_op.Enabled = True
        txt_fec_vcto.Enabled = True
        txt_fec_emi.Enabled = True
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = True
        frm_basilea.Enabled = True
        Txt_rut_Emi.Enabled = True
        Txt_rut_Emi.BackColor = vbWhite
        box_mon_emi.Enabled = True
        box_mon_pag.Enabled = True
        lbl_tip_tasa.Caption = "Fija"
        Txt_Cod_tasa.Caption = "100"
        I = 0

        box_forma_pago.ListIndex = 0
        box_basilea.ListIndex = 1
        box_dia.ListIndex = 0
        box_año.ListIndex = 0
        Op_Encaje_N.Value = True
        

        For I = 0 To box_mon_emi.ListCount - 1
                box_mon_emi.ListIndex = I
                If box_mon_emi.ItemData(box_mon_emi.ListIndex) = 13 Then
                    Exit For
                End If
                box_mon_emi.ListIndex = -1
        Next
        For I = 0 To box_mon_pag.ListCount - 1
                box_mon_pag.ListIndex = I
                If box_mon_pag.ItemData(box_mon_pag.ListIndex) = 13 Then
                    Exit For
                End If
                box_mon_pag.ListIndex = -1
        Next
        box_dia.Enabled = True
        box_año.Enabled = True
        Box_base.Enabled = True
        box_dia.ListIndex = 0
        box_año.ListIndex = 0
        If box_familia.ListIndex = 1 Then
            frm_basilea.Enabled = True
        End If
        Exit Sub
    End If
    
End Sub

Private Sub box_forma_pago_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub box_mon_emi_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub box_mon_pag_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub box_nemo_Click()

    Dim I As Integer


    If box_nemo.ListIndex = -1 Then
        Exit Sub
    End If

    I = 0
    
    Call buscar_datos(2000, Mid(box_nemo.Text, 1, 20), Mid(box_nemo.Text, 23, 10))
    txt_nominal.Max = lbl_monto_emi.Caption
    txt_nominal.Min = 0
    box_forma_pago.ListIndex = 0
    
    Txt_Nemo = Mid$(box_nemo.Text, 1, 20)

End Sub

Private Sub Form_Load()
    Limpio = False
    Move 0, 0
    box_nemo.Enabled = False
    Toolbar1.Buttons(2).Visible = False
    Toolbar1.Buttons(3).Visible = False
    Call Clear_Objetos
    Call llena_combo_familia
    Call llena_combo_nemo
    Call Llena_Combo_basilea
    Call llena_combo_base
    Call Llena_Combo_monedas_pag
    Call Llena_Combo_modedas_emi
    'Call llena_combo_confirmacion
    Call llena_combo_forma_pago
    Call llena_combo_bases_tasas
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
            Call Grabar_compra
        End If
        
    Case 3

        If box_familia.ListIndex = -1 Then
            Exit Sub
        End If


        If box_familia.ItemData(box_familia.ListIndex) > 2000 Then
        
            lbl_tip_tasa.Caption = "Fija"
            lbl_cod_tasa.Caption = 100
            I = 0
            
            For I = 0 To Box_base.ListCount - 1
                    Box_base.ListIndex = I
                    If Box_base.ItemData(Box_base.ListIndex) = 360 Then
                        Exit For
                    End If
                    Box_base.ListIndex = -1
            Next
            
            Box_base.Enabled = True
            If box_familia.ListIndex = 1 Then
                frm_basilea.Enabled = True
                Option1.Value = True
            End If
            Exit Sub
            
        End If
        I = 0
        
        Call buscar_datos(2000, Mid(box_nemo.Text, 1, 20), Mid(box_nemo.Text, 23, 10))
        
        For I = 0 To box_moneda.ListCount - 1
            box_moneda.ListIndex = I
            If box_moneda.ItemData(box_moneda.ListIndex) = 13 Then
                Exit For
            End If
            box_moneda.ListIndex = -1
        Next
        
    Case 4
        Call Clear_Objetos
        box_familia.SetFocus
    Case 5
        Unload Me
End Select
End Sub

Function Llena_Combo_modedas_emi()
    Dim datos()
    box_mon_emi.Clear
    If Bac_Sql_Execute("Svc_Ope_cod_mon") Then
        Do While Bac_SQL_Fetch(datos)
            box_mon_emi.AddItem datos(2)
            box_mon_emi.ItemData(box_mon_emi.NewIndex) = Val(datos(1))
        Loop
            
    End If
End Function

Function Llena_Combo_monedas_pag()
    Dim datos()
    box_mon_pag.Clear
    If Bac_Sql_Execute("Svc_Ope_cod_mon") Then
        Do While Bac_SQL_Fetch(datos)
            box_mon_pag.AddItem datos(2)
            box_mon_pag.ItemData(box_mon_pag.NewIndex) = Val(datos(1))
        Loop
            
    End If
End Function

Private Sub txt_cod_emi_LostFocus()
    Call busca_datos(Txt_rut_Emi.Text, txt_cod_emi.Text)
End Sub

Private Sub txt_fec_emi_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Valoriza = True
        SendKeys "{TAB}"
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
        SendKeys "{TAB}"
        Valoriza = True
    End If
End Sub

Private Sub txt_fec_neg_LostFocus()
'Dim op
'op = CDbl(DateDiff("D", txt_fec_emi.Text, txt_fec_neg.Text))
'    If op < 0 Then
'        MsgBox "Fecha de Negociación no Puede ser Menor que la de Emisión", vbExclamation, Me.Caption
'        Exit Sub
'    End If
    If Valoriza = True Then
        Call Valorizar(ModCal)
        Valoriza = False
    End If
    
End Sub


Private Sub txt_fec_pag_KeyPress(KeyAscii As Integer)
        
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
        Valoriza = True
    End If
End Sub


Private Sub txt_fec_pag_LostFocus()


    If Valoriza = True Then
        Call Valorizar(ModCal)
        Valoriza = False
        Exit Sub
    End If
    
Dim Op
Dim op2

    If box_familia.ListIndex = -1 Then
        Exit Sub
    End If



    Op = CDbl(DateDiff("D", txt_fec_emi.Text, txt_fec_pag.Text))
    op2 = CDbl(DateDiff("D", txt_fec_pag.Text, txt_fec_vcto.Text))

    If Op < 0 Then
        MsgBox "Fecha de Pago No Debe Ser Menor Que La de Emisión", vbExclamation, gsBac_Version
        Exit Sub
    ElseIf op2 <= 0 Then
        MsgBox "Fecha de Pago No Debe Ser Mayor Que La de Vencimiento", vbExclamation, gsBac_Version
        Exit Sub
    End If
    
End Sub


Private Sub txt_fec_vcto_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Valoriza = True
        SendKeys "{TAB}"
    End If
End Sub


Private Sub lbl_int_dev_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        txt_nominal.SetFocus
    End If
End Sub


Private Sub txt_fec_vcto_LostFocus()
    Valoriza = True
    If Valoriza = True Then
        Call Valorizar(ModCal)
        Valoriza = False
    End If

End Sub

Private Sub txt_monto_emi_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
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
        Valoriza = False
    End If

End Sub

Private Sub Txt_Nemo_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub Txt_Nominal_GotFocus()

    txt_nominal.Tag = txt_nominal.Text

End Sub

Private Sub txt_nominal_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        KeyAscii = 0
        txt_tir.SetFocus
        Valoriza = True
    End If
End Sub


Private Sub Txt_Nominal_LostFocus()
'   If Valoriza = True Then
    If txt_nominal.Tag <> txt_nominal.Text Then
        Call Valorizar(ModCal)
        Valoriza = False
    End If
End Sub


Private Sub Txt_Pre_Por_GotFocus()

    txt_pre_por.Tag = txt_pre_por.Text

End Sub

Private Sub txt_pre_por_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        KeyAscii = 0
        Txt_Monto_Pag.SetFocus
    End If

End Sub


Private Sub txt_pre_por_LostFocus()

    If txt_pre_por.Tag <> txt_pre_por.Text Then
        ModCal = 1
        Call Valorizar(ModCal)
        Valoriza = False
    End If

End Sub


Private Sub txt_rut_emi_Change()
    lbl_emisor.Caption = " "
     txt_cod_emi.Text = " "
    
End Sub

Private Sub txt_rut_emi_DblClick()
    BacAyuda.Tag = "EMISOR"
    BacAyuda.Show 1
    
    If giAceptar% = True Then
        Txt_rut_Emi.Text = CDbl(Trim(Mid(gsrut$, 44, 9)))
        lbl_emisor.Caption = Trim(Mid(gsrut$, 1, 40))
        Cod_emi = CDbl(Trim(Mid(gsrut$, 58, 1)))
        txt_cod_emi.Text = CDbl(Trim(Mid(gsrut$, 58, 1)))
        Call buscar_pais(Txt_rut_Emi.Text, Cod_emi)
        
    Else
        SendKeys "{TAB}"
    End If

End Sub

Function buscar_pais(rut, Cod_cli)
    Dim datos()
    envia = Array()
    AddParam envia, CDbl(rut)
    AddParam envia, CDbl(Cod_cli)
    If Bac_Sql_Execute("Svc_Cmp_pai_cli", envia) Then
        Do While Bac_SQL_Fetch(datos)
            If datos(1) = "SI" Then
                lbl_pais.Caption = datos(2)
            Else
                lbl_pais.Caption = datos(2)
            End If
        Loop
    End If
End Function


Private Sub txt_rut_emi_KeyPress(KeyAscii As Integer)

    BacCaracterNumerico KeyAscii
    
    If KeyAscii = 13 Then SendKeys "{TAB}"
    
End Sub


Private Sub txt_tasa_vig_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
        SendKeys "{TAB}"
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
        Valoriza = True
    End If
End Sub


Private Sub txt_tir_LostFocus()

    If txt_tir.Tag <> txt_tir.Text Then
        ModCal = 2
        Call Valorizar(ModCal)
        Valoriza = False
    End If
End Sub

Private Sub txtNumero1_NumeroInvalido()

End Sub

Private Sub txtNumero3_NumeroInvalido()

End Sub


