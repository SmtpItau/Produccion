VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form Bac_detalle 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Detalle de Instrumentos Financieros"
   ClientHeight    =   6270
   ClientLeft      =   315
   ClientTop       =   1440
   ClientWidth     =   10095
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6270
   ScaleWidth      =   10095
   Begin VB.Frame frm_datos_int 
      Enabled         =   0   'False
      Height          =   4530
      Left            =   60
      TabIndex        =   18
      Top             =   1635
      Width           =   9960
      Begin VB.ComboBox Box_Base 
         Height          =   315
         Left            =   7620
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   225
         Width           =   2055
      End
      Begin VB.ComboBox box_año 
         Height          =   315
         Left            =   6765
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   2055
         Visible         =   0   'False
         Width           =   795
      End
      Begin VB.ComboBox box_dia 
         Height          =   315
         Left            =   5745
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   2055
         Visible         =   0   'False
         Width           =   795
      End
      Begin VB.ComboBox box_perio_cap 
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
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   1800
         Width           =   3105
      End
      Begin VB.ComboBox box_monpag 
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
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   3330
         Width           =   3105
      End
      Begin VB.ComboBox box_monemi 
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
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   2940
         Width           =   3105
      End
      Begin VB.Frame frm_opciones 
         Height          =   945
         Left            =   7500
         TabIndex        =   19
         Top             =   200
         Visible         =   0   'False
         Width           =   1410
         Begin VB.OptionButton Option2 
            Caption         =   "No"
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
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   120
            TabIndex        =   8
            Top             =   570
            Width           =   675
         End
         Begin VB.OptionButton Option1 
            Caption         =   "Si"
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
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   120
            TabIndex        =   7
            Top             =   240
            Width           =   735
         End
      End
      Begin VB.ComboBox box_tip_tasa 
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
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   240
         Width           =   3105
      End
      Begin VB.ComboBox box_basilea 
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
         Left            =   7620
         Style           =   2  'Dropdown List
         TabIndex        =   12
         Top             =   2200
         Visible         =   0   'False
         Width           =   2055
      End
      Begin VB.ComboBox box_periodo 
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
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   2190
         Width           =   3105
      End
      Begin BACControles.TXTFecha txt_fec_emi 
         Height          =   300
         Left            =   2190
         TabIndex        =   38
         Top             =   615
         Width           =   1905
         _ExtentX        =   3360
         _ExtentY        =   529
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
         MaxDate         =   2958101
         MinDate         =   2
         Text            =   "01/01/1900"
      End
      Begin BACControles.TXTNumero txt_cod_cli 
         Height          =   345
         Left            =   3750
         TabIndex        =   39
         Top             =   3735
         Width           =   495
         _ExtentX        =   873
         _ExtentY        =   609
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
      End
      Begin BACControles.TXTNumero txt_rut_emi 
         Height          =   345
         Left            =   2190
         TabIndex        =   40
         Top             =   3735
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   609
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
      End
      Begin BACControles.TXTNumero txt_tasa_emi 
         Height          =   345
         Left            =   2190
         TabIndex        =   41
         Top             =   1380
         Width           =   1155
         _ExtentX        =   2037
         _ExtentY        =   609
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
      Begin BACControles.TXTNumero txt_monto_emi 
         Height          =   315
         Left            =   2220
         TabIndex        =   42
         Top             =   990
         Width           =   3105
         _ExtentX        =   5477
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         Min             =   "0"
         Max             =   "99999999999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txt_nro_cupo 
         Height          =   315
         Left            =   7560
         TabIndex        =   44
         Top             =   1440
         Visible         =   0   'False
         Width           =   2055
         _ExtentX        =   3625
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
      End
      Begin BACControles.TXTNumero txt_dias 
         Height          =   315
         Left            =   7560
         TabIndex        =   45
         Top             =   3000
         Visible         =   0   'False
         Width           =   2055
         _ExtentX        =   3625
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
      End
      Begin BACControles.TXTFecha txt_fec_pago 
         Height          =   315
         Left            =   2190
         TabIndex        =   43
         Top             =   2565
         Width           =   1950
         _ExtentX        =   3440
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
         Text            =   "02/07/2002"
      End
      Begin BACControles.TXTNumero txtspread 
         Height          =   345
         Left            =   4170
         TabIndex        =   46
         Top             =   1380
         Width           =   1155
         _ExtentX        =   2037
         _ExtentY        =   609
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
      Begin VB.Label lblspread 
         AutoSize        =   -1  'True
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
         Height          =   210
         Left            =   3540
         TabIndex        =   47
         Top             =   1440
         Width           =   585
      End
      Begin VB.Label Label7 
         Caption         =   "Cod."
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
         Index           =   1
         Left            =   3390
         TabIndex        =   35
         Top             =   3735
         Width           =   855
      End
      Begin VB.Label Label11 
         Caption         =   "Nº Días Habiles (Valor Moneda)"
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
         Height          =   570
         Left            =   5775
         TabIndex        =   13
         Top             =   3000
         Visible         =   0   'False
         Width           =   1395
      End
      Begin VB.Label Label13 
         Alignment       =   2  'Center
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
         Left            =   6540
         TabIndex        =   14
         Top             =   1875
         Visible         =   0   'False
         Width           =   210
      End
      Begin VB.Label Label19 
         Caption         =   "Período Capital"
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
         Left            =   660
         TabIndex        =   15
         Top             =   1845
         Width           =   1245
      End
      Begin VB.Label Label18 
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
         Left            =   5775
         TabIndex        =   16
         Top             =   225
         Width           =   1455
      End
      Begin VB.Label Label17 
         Caption         =   "Moneda Pago"
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
         Height          =   300
         Left            =   660
         TabIndex        =   17
         Top             =   3375
         Width           =   1395
      End
      Begin VB.Label Label15 
         Caption         =   "Moneda Emisión"
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
         Height          =   300
         Left            =   660
         TabIndex        =   34
         Top             =   3000
         Width           =   1395
      End
      Begin VB.Label Label16 
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
         Left            =   660
         TabIndex        =   33
         Top             =   1035
         Width           =   1350
      End
      Begin VB.Label lbl_nom_cli 
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
         Height          =   345
         Left            =   4365
         TabIndex        =   32
         Top             =   3735
         Width           =   5010
      End
      Begin VB.Label Label3 
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
         Left            =   660
         TabIndex        =   31
         Top             =   270
         Width           =   1455
      End
      Begin VB.Label Label4 
         Caption         =   "Fecha 1º Pago"
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
         Left            =   660
         TabIndex        =   30
         Top             =   2610
         Width           =   1335
      End
      Begin VB.Label Label5 
         Caption         =   "Basilea"
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
         Left            =   5775
         TabIndex        =   29
         Top             =   2200
         Visible         =   0   'False
         Width           =   735
      End
      Begin VB.Label Label6 
         Caption         =   "Deducción a Encaje"
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
         Left            =   5775
         TabIndex        =   28
         Top             =   330
         Visible         =   0   'False
         Width           =   1560
      End
      Begin VB.Label Label7 
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
         Index           =   0
         Left            =   660
         TabIndex        =   27
         Top             =   3750
         Width           =   855
      End
      Begin VB.Label Label8 
         Caption         =   "Tasa de Emisión"
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
         Left            =   660
         TabIndex        =   26
         Top             =   1440
         Width           =   1695
      End
      Begin VB.Label Label9 
         Caption         =   "Período Interés"
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
         Left            =   660
         TabIndex        =   25
         Top             =   2235
         Width           =   1305
      End
      Begin VB.Label Label10 
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
         Left            =   660
         TabIndex        =   24
         Top             =   645
         Width           =   1695
      End
      Begin VB.Label Label12 
         Caption         =   "Nº de Cupones"
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
         Left            =   5775
         TabIndex        =   23
         Top             =   1400
         Visible         =   0   'False
         Width           =   1335
      End
   End
   Begin VB.Frame frm_instr 
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
      ForeColor       =   &H8000000D&
      Height          =   1020
      Left            =   60
      TabIndex        =   20
      Top             =   600
      Width           =   9975
      Begin VB.TextBox txt_descripcion 
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
         Left            =   1905
         MaxLength       =   50
         TabIndex        =   1
         Top             =   615
         Width           =   6855
      End
      Begin VB.TextBox txt_instrum 
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
         Left            =   1900
         MaxLength       =   20
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   0
         Top             =   200
         Width           =   2655
      End
      Begin BACControles.TXTFecha txt_fec_vcto 
         Height          =   285
         Left            =   7200
         TabIndex        =   37
         Top             =   240
         Width           =   1530
         _ExtentX        =   2699
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
         MinDate         =   -328716
         Text            =   "22/11/2001"
      End
      Begin VB.Label Label1 
         Caption         =   "Instrumento"
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
         Left            =   555
         TabIndex        =   22
         Top             =   255
         Width           =   1215
      End
      Begin VB.Label Label2 
         Caption         =   "Fecha Vencimiento"
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
         Left            =   5460
         TabIndex        =   21
         Top             =   255
         Width           =   1695
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   36
      Top             =   0
      Width           =   10095
      _ExtentX        =   17806
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList2"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   1
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
      MouseIcon       =   "frm_detalle.frx":0000
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   4800
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   6
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_detalle.frx":031A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_detalle.frx":076C
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_detalle.frx":087E
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_detalle.frx":0990
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_detalle.frx":0CAA
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_detalle.frx":0FC4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "Bac_detalle"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Dato As String
Dim resrc As String
Dim Sql As String
Dim Base_Tasa As Double
Dim base_flujo As Double
Dim Dias As Double
Dim Limpio
Dim Calculo
Dim Fecha_pagos
   
   


Function busca_datos()
    Dim Sql As String, num
    Dim pl
    Dim Datos()
    Dim i As Double
'    If txt_instrum.Text = "" Then
'        MsgBox "Debe Ingresar Un Instrumento", vbInformation, gsBac_Version
'        txt_instrum.SetFocus
'        Exit Function
'    ElseIf DateDiff("d", gsBac_Fecp, txt_fec_vcto.Text) < 1 Then
'        MsgBox "Fecha de Vencimiento No debe ser Menor o Igual A La De Operación", vbExclamation, gsBac_Version
'        txt_fec_vcto.SetFocus
'        Exit Function
'    End If
    
    envia = Array()
       
    AddParam envia, Nom_inst
    AddParam envia, Fechadet
    If Bac_Sql_Execute("SVC_AYD_SER_INS", envia) Then
        Do While Bac_SQL_Fetch(DATOS)
            If DATOS(1) = "0" Then
                Exit Do
            End If
            pl = 1
            txt_instrum.Text = Nom_inst
            txt_fec_vcto.Text = Format(Datos(10), "dd/mm/yyyy")
            txt_tasa_emi.Text = CDbl(Datos(12))
            txtspread.Text = CDbl(Datos(27))
            txt_fec_emi.Text = Format(Datos(9), "dd/mm/yyyy")

            txt_descripcion = Datos(3)
            For i = 0 To box_tip_tasa.ListCount - 1
                box_tip_tasa.ListIndex = i
                If box_tip_tasa.ItemData(box_tip_tasa.ListIndex) = Val(Datos(5)) Then
                    Exit For
                End If
                box_tip_tasa.ListIndex = -1
            Next
            For i = 0 To box_basilea.ListCount - 1
                box_basilea.ListIndex = i
                If box_basilea.ItemData(box_basilea.ListIndex) = Val(Datos(6)) Then
                    Exit For
                End If
                box_basilea.ListIndex = -1
            Next
            For i = 0 To box_periodo.ListCount - 1
                box_periodo.ListIndex = i
                If box_periodo.ItemData(box_periodo.ListIndex) = Val(Datos(7)) Then
                    Exit For
                End If
                box_periodo.ListIndex = -1
            Next
            For i = 0 To box_perio_cap.ListCount - 1
                box_perio_cap.ListIndex = i
                If box_perio_cap.ItemData(box_perio_cap.ListIndex) = Val(Datos(24)) Then
                    Exit For
                End If
                box_perio_cap.ListIndex = -1
            Next
            txt_fec_pago.Text = Format(Datos(15), "dd/mm/yyyy")
            
            
            
            For i = 0 To box_año.ListCount - 1
                box_año.ListIndex = i
                If box_año.Text = Datos(13) Then
                    Exit For
                End If
                box_año.ListIndex = -1
            Next
            box_base.ListIndex = box_año.ListIndex

            txt_nro_cupo.Text = Val(Datos(8))
            If Datos(11) = "S" Then
                Option1.Value = True
            ElseIf Datos(11) = "N" Then
                Option2.Value = True
            Else
                Option1.Value = False
                Option2.Value = False
            End If
            txt_fec_pago.Text = Format(Datos(15), "dd/mm/yyyy")
            If Datos(16) = "T" Then
                For i = 0 To box_dia.ListCount - 1
                    box_dia.ListIndex = i
                    If box_dia.Text = "Real" Then
                        Exit For
                    End If
                    box_dia.ListIndex = -1
                Next
            ElseIf Datos(16) = "F" Then
                For i = 0 To box_dia.ListCount - 1
                    box_dia.ListIndex = i
                    If box_dia.Text = "30" Then
                        Exit For
                    End If
                    box_dia.ListIndex = -1
                Next
            End If
            ltasfija = Datos(18)
            txt_rut_emi.Text = Datos(4)
            txt_monto_emi.Text = Format(Datos(19), "0.0000")
            
            lbl_nom_cli.Caption = Datos(20)
            txt_fec_pago.Text = Format(Datos(15), "dd/mm/yyyy")
            For i = 0 To box_monemi.ListCount - 1
                box_monemi.ListIndex = i
                If box_monemi.ItemData(box_monemi.ListIndex) = Val(Datos(21)) Then
                    Exit For
                End If
                box_monemi.ListIndex = -1
            Next
            For i = 0 To box_monpag.ListCount - 1
                box_monpag.ListIndex = i
                If box_monpag.ItemData(box_monpag.ListIndex) = Val(Datos(22)) Then
                    Exit For
                End If
                box_monpag.ListIndex = -1
            Next
            
'            Call enable_false
            txt_cod_cli.Text = CDbl(Datos(25))
            Toolbar1.Buttons(1).Enabled = True
            'Toolbar1.Buttons(2).Enabled = False
            'Toolbar1.Buttons(3).Enabled = False
            frm_datos_int.Enabled = False
            frm_instr.Enabled = False
            txt_dias.Text = CDbl(Datos(26))
            If Datos(11) = "S" Then
                Option1.Value = True
            ElseIf Datos(11) = "N" Then
                Option2.Value = True
            Else
                Option1.Value = False
                Option2.Value = False
            End If
            txt_fec_pago.Text = Format(Datos(15), "dd/mm/yyyy")
            
            If Val(Datos(5)) = 1 Or Val(Datos(5)) = 0 Then
                txtspread.Visible = False
                lblspread.Visible = False
            End If
            
            Exit Function
        Loop
            resrc = MsgBox("Instrumento No Existe, ¿ Desea Ingresarlo ? ", vbQuestion + vbYesNo + vbDefaultButton1, gsBac_Version)
            
             If resrc = vbYes Then
                Limpio = False
                txt_instrum.Enabled = False
                txt_fec_vcto.Enabled = False
                txt_descripcion.Enabled = False
                frm_datos_int.Enabled = False
                
                Dim OpC
                OpC = txt_instrum.Text
                Call Clear_Objetos("S")
                Toolbar1.Buttons(1).Enabled = False
                'Toolbar1.Buttons(2).Enabled = False    'JBH, 04-12-2009
                'txt_fec_vcto.Text = Format(paso, "dd/mm/yyyy")
                'Toolbar1.Buttons(3).Enabled = False    'JBH, 04-12-2009
                txt_instrum.Text = OpC
                txt_descripcion.Enabled = False
                txt_descripcion.SetFocus
            Else
                Call Clear_Objetos(" ")
                Me.txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
            End If
    End If
End Function



Function busca_emisor(rut, Cod_cli)
    busca_emisor = 0
    If rut = "0" Or Not IsNumeric(rut) Then
        Exit Function
    End If
    Dim Datos()
    envia = Array()
    AddParam envia, CDbl(rut)
    AddParam envia, CDbl(Cod_cli)
    If Bac_Sql_Execute("SVC_OPE_DAT_EMI", envia) Then
        Do While Bac_SQL_Fetch(DATOS)
            If DATOS(1) <> 0 Then
                lbl_nom_cli.Caption = DATOS(1)
            End If
        Loop
    End If
    If Datos(1) = 0 Then
        MsgBox "Rut Inexsistente", vbExclamation, gsBac_Version
        lbl_nom_cli.Caption = " "
        txt_rut_emi.Text = ""
'        txt_rut_emi.SetFocus
        Exit Function
    End If
    busca_emisor = Datos(1)
End Function

Function buscar_datos_ayuda()
    Dim Sql As String
    Dim Datos()
    Dim reg As Integer
    If Bac_Sql_Execute("SVC_INS_VER_DAT") Then
       Do While Bac_SQL_Fetch(DATOS)
            reg = DATOS(1)
       Loop
    Else
        MsgBox "Problemas En SQL", vbCritical, gsBac_Version
    End If
    If reg = 0 Then
        MsgBox "No Exixten Elementos De Ayuda ", vbExclamation, gsBac_Version
    Else
        BacAyuda.Tag = "INSTRU"
        BacAyuda.Show 1
        If giAceptar% = True Then
            txt_instrum.Text = gsBac_VarString
            txt_fec_vcto.Text = gsBac_VarString2
            Call busca_datos
            
            frm_instr.Enabled = False
            Limpio = False

        Else
            SendKeys "{TAB 2}"
        End If
        
    End If
'    If Trim(Fecha_pagos) <> "" Then
'        txt_fec_pago.Text = Fecha_pagos
'    End If
End Function

Function Clear_Objetos(Op)
    Limpio = True
    If Op = " " Then
        txt_dias.Text = ""

        txt_instrum.Enabled = True
        box_perio_cap.ListIndex = -1
        txt_instrum.Text = ""
        txt_descripcion.Text = ""
        box_tip_tasa.ListIndex = -1
        box_periodo.ListIndex = -1
        box_basilea.ListIndex = -1
        Option1.Value = False
        Option2.Value = False
        box_año.ListIndex = -1
        box_dia.ListIndex = -1
        box_base.ListIndex = -1
        txt_tasa_emi.Text = ""
        txt_fec_emi.Text = "01/01/1900"

        txt_nro_cupo.Text = ""
        
        txt_fec_pago.Text = "01/01/1900"
        txt_rut_emi.Text = 0
        txt_monto_emi.Text = 0
        lbl_nom_cli.Caption = " "
        Toolbar1.Buttons(1).Enabled = False
        'Toolbar1.Buttons(2).Enabled = False    'JBH, 04-12-2009
        frm_instr.Enabled = True
        txt_descripcion.Enabled = False
        'Toolbar1.Buttons(3).Enabled = True     'JBH, 04-12-2009
        frm_datos_int.Enabled = False
        txt_instrum.Enabled = True
        txt_fec_vcto.Enabled = True
        box_monemi.ListIndex = -1
        box_monpag.ListIndex = -1
        box_monemi.Enabled = False
        box_monpag.Enabled = False

        Call enable_false
    Else
        txt_dias.Text = ""

        box_perio_cap.ListIndex = -1
        box_monemi.ListIndex = -1
        box_monpag.ListIndex = -1
        box_monemi.Enabled = False
        box_monpag.Enabled = False
        txt_instrum.Text = ""
        txt_descripcion.Text = ""
        box_tip_tasa.ListIndex = -1
        box_periodo.ListIndex = -1
        box_basilea.ListIndex = -1
        Option1.Value = False
        Option2.Value = False
'       Option3.Value = False
'       Option4.Value = False
        txt_tasa_emi.Text = ""
        txt_fec_emi.Text = "01/01/1900"
'       txt_base_tasa.Text = "   "
        txt_nro_cupo.Text = ""
        
        
        txt_fec_pago.Text = "01/01/1900"
        txt_rut_emi.Text = 0
        txt_monto_emi.Text = 0
        lbl_nom_cli.Caption = " "
        Toolbar1.Buttons(1).Enabled = False
        'Toolbar1.Buttons(2).Enabled = False    'JBH, 04-12-2009
        frm_instr.Enabled = True
        txt_descripcion.Enabled = False
        'Toolbar1.Buttons(3).Enabled = True     'JBH, 04-12-2009
        frm_datos_int.Enabled = False

        Call enable_false
    End If
End Function

Function diferencia_fechas()
    If txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY") Or txt_fec_pago.Text = Format(gsBac_Fecp, "DD/MM/YYYY") Or box_periodo.ListIndex = -1 Then
        Exit Function
    End If
    Dim sw
    Dim total
    total = Round(DateDiff("m", txt_fec_emi.Text, Me.txt_fec_vcto.Text) / (box_periodo.ItemData(box_periodo.ListIndex)), 0)
    If CDbl(Val(total)) > 0 Then
        txt_nro_cupo.Text = (Val(total))
    Else
        txt_nro_cupo.Text = 1
    End If
End Function

Function eliminar_de_la_tabla_instrumentos()
    Dim Sql As String
    Dim Datos()
    envia = Array()
    AddParam envia, 2000
    AddParam envia, txt_instrum.Text
    AddParam envia, txt_fec_vcto.Text
    If Bac_Sql_Execute("SVA_INS_ELI_REG", envia) Then
        Do While Bac_SQL_Fetch(DATOS)
            If DATOS(1) = "NO" Then
                MsgBox DATOS(2), vbExclamation, gsBac_Version
                Exit Function
            End If

        Loop

        Call Clear_Objetos("S")
        Call Clear_Objetos(" ")
        Call enable_false
        txt_instrum.Text = ""
        txt_fec_vcto.Text = "01/01/1900"
        txt_instrum.SetFocus
    Else
        MsgBox "Error al Eliminar Instrumentos", vbExclamation, gsBac_Version
    End If

End Function
Function enable_false()
    txt_fec_pago.Enabled = False
    box_perio_cap.Enabled = False
    box_tip_tasa.Enabled = False
    box_basilea.Enabled = False
    Option1.Enabled = False
    Option2.Enabled = False
    txt_tasa_emi.Enabled = False
    box_periodo.Enabled = False
    txt_fec_emi.Enabled = False
    box_año.Enabled = False
    box_dia.Enabled = False
    box_base.Enabled = False
    frm_datos_int.Enabled = False
    box_perio_cap.Enabled = False
    txt_rut_emi.Enabled = False
    txt_monto_emi.Enabled = False
    txt_cod_cli.Enabled = False
    box_monpag.Enabled = False
    box_monemi.Enabled = False
End Function

Function enable_true()
    txt_fec_pago.Enabled = True
        
    box_perio_cap.Enabled = True
    box_tip_tasa.Enabled = True
    box_basilea.Enabled = True
    Option1.Enabled = True
    Option2.Enabled = True
    txt_tasa_emi.Enabled = True
    box_periodo.Enabled = True
    txt_fec_emi.Enabled = True
    box_dia.Enabled = True
    box_año.Enabled = True
    box_base.Enabled = True
    frm_datos_int.Enabled = True
    box_perio_cap.Enabled = True
    txt_rut_emi.Enabled = True
    txt_monto_emi.Enabled = True
    txt_cod_cli.Enabled = True
    box_monpag.Enabled = True
    box_monemi.Enabled = True
End Function

Function Fecha_de_pago()
'If Calculo = True Then
'    If box_periodo.ListIndex <> -1 Then
'        If txt_fec_emi.Text <> Format(gsBac_Fecp, "DD/MM/YYYY") Then
'            Dim Periodo As Double
'            Periodo = box_periodo.ItemData(box_periodo.ListIndex)
'            txt_fec_pago.Text = Format(DateAdd("M", Periodo, txt_fec_emi.Text), "DD/MM/YYYY")
'            Calculo = False
'        End If
'    End If
'End If
End Function

Function grabar_datos()
    Dim Sql As String
    Dim Datos()
    Dim p As Integer
    Dim num As Double
    Dim rut As Double
    Dim res
    Dim res1
    num = 2000
    rut = CDbl(txt_rut_emi.Text)
    envia = Array()
    AddParam envia, num                                             '1
    AddParam envia, txt_instrum.Text                                '2
    AddParam envia, txt_descripcion.Text                            '3
    AddParam envia, rut                                             '4
    AddParam envia, box_tip_tasa.ItemData(box_tip_tasa.ListIndex)   '5
    AddParam envia, box_basilea.ItemData(box_basilea.ListIndex)     '6
    AddParam envia, box_periodo.ItemData(box_periodo.ListIndex)     '7
    AddParam envia, Val(txt_nro_cupo.Text)                          '8
    AddParam envia, txt_fec_emi.Text                                '9
    AddParam envia, txt_fec_vcto.Text                                '10
    If Option1.Value = True Then
        res = "S"
    ElseIf Option2.Value = True Then
        res = "N"
    End If
    AddParam envia, res                                             '11
    AddParam envia, CDbl(txt_tasa_emi.Text)                         '12
    AddParam envia, CDbl(box_año.Text)
    AddParam envia, CDbl(txt_tasa_emi.Text)                         '14
    AddParam envia, txt_fec_pago.Text                               '15
    If box_dia.ListIndex = 0 Then
        res1 = "F"
    ElseIf box_dia.ListIndex = 1 Then
        res1 = "T"
    End If
    AddParam envia, res1                                            '16
    AddParam envia, CDbl(box_año.Text)                              '17
    
    Dim numo
    numo = Mid(box_tip_tasa.ItemData(box_tip_tasa.ListIndex), 1, 1)
    If Val(numo) = 1 Then
        ltasfija = "T"
    Else
        ltasfija = "F"
    End If
    AddParam envia, ltasfija                                        '18
    AddParam envia, CDbl(txt_monto_emi.Text)                              '19
    AddParam envia, box_monemi.ItemData(box_monemi.ListIndex)
    AddParam envia, box_monpag.ItemData(box_monpag.ListIndex)
    AddParam envia, 0
    AddParam envia, box_perio_cap.ItemData(box_perio_cap.ListIndex)
    AddParam envia, CDbl(txt_cod_cli.Text)
    AddParam envia, txt_dias.Text
    If Bac_Sql_Execute("SVA_INS_GRB_DAT", envia) Then
        Do While Bac_SQL_Fetch(DATOS)
        Loop
        MsgBox "Datos Grabados Con Exito", vbInformation, gsBac_Version
        Clear_Objetos (" ")
        txt_fec_vcto.Text = "01/01/1900"
        Exit Function
    Else
        MsgBox "Problemas Con SQL", vbCritical, gsBac_Version
        Exit Function
    End If
End Function


Function llena_all_combos_basilea()
 Dim Sql As String
    Dim Datos()
    Dim num
        
    If Bac_Sql_Execute("SVC_INS_LEE_DAT") Then
    
        
        Do While Bac_SQL_Fetch(Datos)
            box_basilea.ListIndex = 0
            num = 0
            num = Val(Datos(6))
            box_basilea.ItemData(box_basilea.ListIndex) = num
        Loop
    End If
        
End Function












Function Llena_Combo_modedas_emi()
    Dim Datos()
    box_monemi.Clear
    If Bac_Sql_Execute("SVC_OPE_COD_MON") Then
        Do While Bac_SQL_Fetch(DATOS)
            box_monemi.AddItem DATOS(2)
            box_monemi.ItemData(box_monemi.NewIndex) = Val(DATOS(1))
        Loop
            
    End If
End Function
Function Llena_Combo_monedas_pag()
    Dim Datos()
    box_monpag.Clear
    If Bac_Sql_Execute("SVC_OPE_COD_MON") Then
        Do While Bac_SQL_Fetch(DATOS)
            box_monpag.AddItem DATOS(2)
            box_monpag.ItemData(box_monpag.NewIndex) = Val(DATOS(1))
        Loop
            
    End If
End Function


Function LLENA_COMBO_TASA_BASE()
    Dim Datos()
    box_dia.Clear
    box_año.Clear
    box_base.Clear
    If Bac_Sql_Execute("SVC_OPE_LEE_TAS") Then
        Do While Bac_SQL_Fetch(DATOS)
            box_dia.AddItem DATOS(1)
            box_año.AddItem DATOS(2)
            box_base.AddItem DATOS(3)
        Loop
    End If
End Function

Function valida_datos()
    If txt_cod_cli.Text = " " Then
        MsgBox "Ingrese Código de Emisor", vbExclamation, gsBac_Version
        txt_cod_cli.SetFocus
    ElseIf txt_fec_emi.Text = Format(gsBac_Fecp, "DD/MM/YYYY") Then
        MsgBox "Ingrese Fecha De Emisión", vbExclamation, Caption
        txt_fec_emi.SetFocus
    ElseIf box_basilea.Text = "" Then
        MsgBox "Ingrese Indice Basilea", vbExclamation, gsBac_Version
        box_basilea.SetFocus
    ElseIf box_tip_tasa.Text = "" Then
        MsgBox "Ingrese Tipo De Tasa", vbExclamation, gsBac_Version
        box_tip_tasa.SetFocus
    ElseIf box_periodo.Text = "" Then
        MsgBox "Ingrese Período de Interes", vbExclamation, gsBac_Version
        box_periodo.SetFocus
    ElseIf (Option1.Value = False And Option2.Value = False) Then
        MsgBox "Seleccione Deducción de Encaje", vbExclamation, gsBac_Version
        Option1.SetFocus
    ElseIf box_dia.ListIndex = -1 Then
        MsgBox "Seleccione Días ", vbExclamation, gsBac_Version
        box_dia.SetFocus
    ElseIf box_año.ListIndex = -1 Then
        MsgBox "Seleccione Base", vbExclamation, gsBac_Version
        box_base.SetFocus
    
    ElseIf txt_tasa_emi.Text = "" Then
        MsgBox "Ingrese Tasa De Emisión", vbExclamation, gsBac_Version
        txt_tasa_emi.SetFocus
    ElseIf txt_rut_emi.Text = " " Then
        MsgBox "Ingrese Rut Emisor", vbExclamation, gsBac_Version
        txt_rut_emi.SetFocus
    ElseIf CDbl(txt_monto_emi.Text) = 0 Then
        MsgBox "Ingrese Monto de Emisión", vbExclamation, gsBac_Version
        txt_monto_emi.SetFocus
    ElseIf box_perio_cap.ListIndex = -1 Then
         MsgBox "Ingrese Periódo Capital", vbExclamation, gsBac_Version
         box_perio_cap.SetFocus
    
   ElseIf DateDiff("D", txt_fec_emi.Text, txt_fec_vcto.Text) < 0 Then
        MsgBox "Fecha de emisión no Puede ser mayor que la de Vencimiento", vbExclamation, gsBac_Version
   ElseIf DateDiff("d", txt_fec_pago.Text, txt_fec_vcto.Text) < 0 Then
        MsgBox "Fecha de Pago No Puede Ser Mayor que La de Vencimiento", vbExclamation, gsBac_Version
        txt_fec_pago.SetFocus
    ElseIf DateDiff("d", txt_fec_emi.Text, txt_fec_pago.Text) < 0 Then
        MsgBox "Fecha de Pago No Puede Ser Menor que La de Emisión", vbExclamation, gsBac_Version
        txt_fec_pago.SetFocus
    ElseIf DateDiff("D", txt_fec_emi.Text, txt_fec_vcto.Text) < 0 Then
        MsgBox "Fecha de Emisión No Puede Ser Mayor que La de Vencimiento", vbExclamation, gsBac_Version
        txt_fec_emi.SetFocus
    ElseIf box_monemi.ListIndex = -1 Then
        MsgBox "Seleccione Moneda De Emisión", vbExclamation, gsBac_Version
        box_monemi.SetFocus
    ElseIf box_monpag.ListIndex = -1 Then
        MsgBox "Seleccione Moneda De Pago", vbExclamation, gsBac_Version
        box_monpag.SetFocus
    
    Else
        Toolbar1.Buttons(1).Enabled = True
        Call grabar_datos
   End If
End Function









Private Sub Box_Base_DblClick()
    box_dia.ListIndex = box_base.ListIndex
    box_año.ListIndex = box_base.ListIndex
End Sub


Private Sub box_base_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub box_basilea_Click()
'    SendKeys "{TAB 1}"
End Sub

Private Sub box_basilea_KeyPress(KeyAscii As Integer)
Select Case KeyAscii
Case 13
    
    SendKeys "{TAB 1}"

End Select
End Sub


Private Sub box_monemi_Click()
    box_monemi.Enabled = True
    If box_monemi.ListIndex > -1 Then
        If box_monemi.ItemData(box_monemi.ListIndex) = 998 Then
            txt_dias.Text = ""
            Label11.Enabled = True
            txt_dias.Enabled = True
        Else
            txt_dias.Text = ""
            Label11.Enabled = False
            txt_dias.Enabled = False
        End If
    End If
'   SendKeys "{TAB}"
End Sub


Private Sub box_monemi_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub


Private Sub box_monpag_Click()
'SendKeys "{TAB}"
End Sub


Private Sub box_monpag_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub


Private Sub box_perio_cap_Click()
'    SendKeys "{TAB}"
End Sub


Private Sub box_perio_cap_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub


Private Sub box_periodo_Click()
        If box_periodo.ListIndex <> -1 Then
            If box_periodo.ItemData(box_periodo.ListIndex) = 99 Then
                txt_nro_cupo.Enabled = False
                txt_nro_cupo.Text = "1"
                Call Fecha_de_pago
            Else
                Call diferencia_fechas
'                Calculo = True
'                Call Fecha_de_pago
                
            End If
        End If
End Sub

Private Sub box_periodo_LostFocus()
    Calculo = False
    Call Fecha_de_pago
End Sub

Private Sub box_tip_tasa_LostFocus()
Dim numo
    If box_tip_tasa.ListIndex <> -1 Then
        numo = Mid(box_tip_tasa.ItemData(box_tip_tasa.ListIndex), 1, 1)
        If Val(numo) = 1 Then
            ltasfija = "T"
        Else
            ltasfija = "F"
        End If
    End If
End Sub

Function llena_datos_inst()

    Dim Sql As String, num
    Dim Datos()
    Dim i As Double
    instru = txt_instrum.Text
    envia = Array()
    AddParam envia, instru
    If Bac_Sql_Execute("Svc_Gen_ayd_ser2", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            txt_fec_vcto.Text = Format(Datos(10), "dd/mm/yyyy")
            txt_fec_emi = Format(Datos(9), "dd/mm/yyyy")
            txt_descripcion = Datos(3)

            For i = 0 To box_tip_tasa.ListCount - 1
                box_tip_tasa.ListIndex = i
                If box_tip_tasa.ItemData(box_tip_tasa.ListIndex) = Val(Datos(5)) Then
                    Exit For
                End If
                box_tip_tasa.ListIndex = -1
            Next
            For i = 0 To box_basilea.ListCount - 1
                box_basilea.ListIndex = i
                If box_basilea.ItemData(box_basilea.ListIndex) = Val(Datos(6)) Then
                    Exit For
                End If
                box_basilea.ListIndex = -1
            Next
            For i = 0 To box_periodo.ListCount - 1
                box_periodo.ListIndex = i
                If box_periodo.ItemData(box_periodo.ListIndex) = Val(Datos(7)) Then
                    Exit For
                End If
                box_periodo.ListIndex = -1
            Next
            txt_fec_pago.Text = Format(Datos(15), "dd/mm/yyyy")
            txt_tasa_emi.Text = CDbl(Datos(12))
            txt_fec_emi.Text = Format(Datos(9), "dd/mm/yyyy")
            txt_base_tasa.Text = Val(Datos(13))
            txt_nro_cupo.Text = Val(Datos(8))
            txt_base_flujo.Text = Val(Datos(17))
            ltasfija = Datos(18)
            If Datos(11) = "S" Then
                Option1.Value = True
            ElseIf Datos(11) = "N" Then
                Option2.Value = True
            Else
                Option1.Value = False
                Option2.Value = False
            End If
            If Datos(16) = "T" Then
                Option3.Value = True
            ElseIf Datos(16) = "F" Then
                Option4.Value = True
            Else
                Option3.Value = False
                Option4.Value = False
            End If
            box_tip_tasa.Enabled = True
            box_basilea.Enabled = True
            'txt_fec_pago.Enabled = True
            Option1.Enabled = True
            Option2.Enabled = True
            txt_tasa_emi.Enabled = True
            box_periodo.Enabled = True
            txt_fec_emi.Enabled = True
            txt_base_flujo.Enabled = True
            Option3.Enabled = True
            Option4.Enabled = True
            txt_fec_vcto.Enabled = True
            txt_base_tasa.Enabled = True
            txt_rut_emi.Enabled = True
            frm_datos_int.Enabled = True
            box_tip_tasa.SetFocus

            
        Loop
        Toolbar1.Buttons(1).Enabled = True
        'Toolbar1.Buttons(2).Enabled = True 'JBH, 04-12-2009
        frm_instr.Enabled = False
        'Toolbar1.Buttons(3).Enabled = False    'JBH, 04-12-2009
    End If
    
End Function




Private Sub Option3_Click()
    SendKeys "{TAB}"
End Sub

Private Sub Option3_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If

End Sub

Private Sub Option4_Click()
    SendKeys "{TAB}"
    
End Sub


Private Sub Label14_Click()

End Sub

Private Sub txt_cod_cli_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If

End Sub

Private Sub txt_cod_cli_LostFocus()
    lbl_nom_cli.Caption = busca_emisor(txt_rut_emi.Text, txt_cod_cli.Text)
End Sub

Private Sub txt_descripcion_KeyPress(KeyAscii As Integer)
Select Case KeyAscii
    Case 13
    Call enable_true
    txt_descripcion.Text = UCase(txt_descripcion.Text)
    Toolbar1.Buttons(1).Enabled = True
    SendKeys "{TAB}"
    frm_instr.Enabled = False
    
    box_basilea.ListIndex = 0
    box_perio_cap.ListIndex = 0
    box_periodo.ListIndex = 0
    box_tip_tasa.ListIndex = 0
    box_dia.ListIndex = 0
    box_año.ListIndex = 0
    box_base.ListIndex = 0
    For i = 0 To box_monemi.ListCount - 1
                box_monemi.ListIndex = i
                If box_monemi.ItemData(box_monemi.ListIndex) = 13 Then
                    Exit For
                End If
                box_monemi.ListIndex = -1
    Next
    For i = 0 To box_monpag.ListCount - 1
                box_monpag.ListIndex = i
                If box_monpag.ItemData(box_monpag.ListIndex) = 13 Then
                    Exit For
                End If
                box_monpag.ListIndex = -1
    Next
    Option2 = True
    Option3 = True
    Exit Sub
End Select
KeyAscii = Asc(UCase(Chr(KeyAscii)))

End Sub

Private Sub txt_dias_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_fec_emi_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
    Case 13
        If IsDate(txt_fec_emi.Text) Then
            SendKeys "{TAB}"
            Calculo = True
            Call Fecha_de_pago
        Else
            txt_fec_emi.Text = "01/01/1900"
        End If
    End Select
End Sub


Private Sub txt_fec_emi_LostFocus()
    Calculo = True
    Call diferencia_fechas
    Call Fecha_de_pago
End Sub

Private Sub txt_fec_vcto_KeyPress(KeyAscii As Integer)
Dim paso

Select Case KeyAscii
    Case 13

        Dim Op
        Dim Fecha
        If txt_instrum.Text <> "" Then
            Fecha = Format(gsBac_Fecp, "DD/MM/YYYY")
            Op = CDbl(DateDiff("D", Fecha, txt_fec_vcto.Text))
            If Op <= 0 Then
                    MsgBox "La Fecha De Vencimiento No Debe Ser  Igual o Menor Que La De Proceso", vbExclamation, gsBac_Version
                    txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
                    Exit Sub
            End If
            SendKeys "{TAB}"
            paso = txt_fec_vcto.Text
            busca_datos
        End If

End Select
End Sub

Function llena_all_periodo()
    Dim Sql As String
    Dim Datos()
    Dim num
        
    If Bac_Sql_Execute("SVC_INS_LEE_DAT") Then
    
        
        Do While Bac_SQL_Fetch(Datos)
            box_periodo.ListIndex = 0
            num = 0
            num = Val(Datos(7))
            box_periodo.ItemData(box_periodo.ListIndex) = num
        Loop
        
    End If
    
End Function
Function llena_all_combos_tip_tas()


    Dim Sql As String
    Dim Datos()
    Dim num
        
    If Bac_Sql_Execute("SVC_INS_LEE_DAT") Then
    
        
        Do While Bac_SQL_Fetch(Datos)
            box_tip_tasa.ListIndex = 0
            num = 0
            num = Val(Datos(5))
            box_tip_tasa.ItemData(box_tip_tasa.ListIndex) = num
            
        Loop
    End If
End Function

Private Sub box_periodo_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
        Case 13
           SendKeys "{TAB}"
            If box_periodo.ListIndex <> -1 Then
            If box_periodo.ItemData(box_periodo.ListIndex) = 99 Then
                txt_nro_cupo.Enabled = False
                txt_nro_cupo.Text = "1"
                txt_fec_pago.Text = txt_fec_vcto.Text
                Call Fecha_de_pago
            Else
                Call diferencia_fechas
                Calculo = True
                Call Fecha_de_pago
            End If
        End If
    End Select
End Sub

Private Sub box_tip_tasa_KeyPress(KeyAscii As Integer)
Select Case KeyAscii
Case 13
    Dim numo
    numo = Mid(box_tip_tasa.ItemData(box_tip_tasa.ListIndex), 1, 1)
    If Val(numo) = 1 Then
        ltasfija = "T"
    Else
        ltasfija = "F"
    End If
    SendKeys "{TAB}"
    End Select
End Sub

Private Sub Form_Load()
    Move 0, 0
    Calculo = False
    Icon = BAC_INVERSIONES.Icon
    Call Llena_Combo_periodos
    Call Llena_Combo_tasas
    Call Llena_Combo_basilea
    Call Llena_Combo_monedas_pag
    Call Llena_Combo_modedas_emi
    LLENA_COMBO_TASA_BASE
    'enable_false
    txt_fec_emi.Text = "01/01/1900"
    txt_fec_pago.Text = "01/01/1900"
    txt_fec_pago.Text = "01/01/1900"
    Limpio = True
    Me.txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
         
    Call busca_datos
    
    frm_datos_int.Enabled = False
    frm_instr.Enabled = False
    
End Sub

Function Llena_Combo_basilea()

    Dim Sql As String
    Dim Datos()
    
    box_basilea.Clear
    
    
    If Bac_Sql_Execute("SVC_GEN_IND_BAS") Then
    
        Do While Bac_SQL_Fetch(Datos)
        
            box_basilea.AddItem Datos(2)
            box_basilea.ItemData(box_basilea.NewIndex) = Val(Datos(1))
            
        
        Loop
    
    End If
End Function

Function Llena_Combo_periodos()

    Dim Sql As String
    Dim Datos()
    
    box_periodo.Clear
    box_perio_cap.Clear
    
    If Bac_Sql_Execute("SVC_INS_LEE_PER") Then
    
        Do While Bac_SQL_Fetch(Datos)
        
            box_perio_cap.AddItem Datos(2)
            box_perio_cap.ItemData(box_perio_cap.NewIndex) = Val(Datos(1))

            box_periodo.AddItem Datos(2)
            box_periodo.ItemData(box_periodo.NewIndex) = Val(Datos(1))
        
        
        Loop
    
    End If


End Function


    

Function Llena_Combo_tasas()

    Dim Sql As String
    Dim Datos()
    
    box_tip_tasa.Clear
    
    box_tip_tasa.AddItem "FIJA"
    box_tip_tasa.ItemData(box_tip_tasa.NewIndex) = 1
    
     envia = Array()
    AddParam envia, 0                                        '1
    AddParam envia, 0                            '2
    AddParam envia, 0 '3
    AddParam envia, gsBac_Fecp   '4
    
    If Bac_Sql_Execute("SVC_INS_LEE_TAS") Then
    
        Do While Bac_SQL_Fetch(Datos)
        
            box_tip_tasa.AddItem Datos(4)
            box_tip_tasa.ItemData(box_tip_tasa.NewIndex) = Val(Datos(3))
        
        
        Loop
    
    End If
End Function


Private Sub Option1_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 And Option1.Value = True Then

    SendKeys "{TAB}"

End If

End Sub

Private Sub Option2_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 And Option2.Value = True Then
    
    SendKeys "{TAB}"

End If

End Sub



Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
        'grabar datos a la tabla
        Unload Me
'    Case 2
'        resrc = MsgBox("¿Está seguro de eliminar este registro?", vbQuestion + vbOKCancel, gsBac_Version)
'        If resrc = vbOK Then
'
'            Call eliminar_de_la_tabla_instrumentos
'        End If
'    Case 3
'           'Call buscar_datos_ayuda
'            Call busca_datos
'    Case 4
'        txt_instrum.Text = ""
'        txt_fec_vcto.Text = "01/01/1900"
'        Call Clear_Objetos(" ")
'        Call enable_false
'        txt_instrum.SetFocus
'
'
'    Case 5
'
'        If Toolbar1.Buttons(1).Value = tbrUnpressed Then
'                Unload Me
'        End If

End Select
End Sub



Private Sub txt_base_tasa_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
    Case 13
            SendKeys "{TAB}"
    End Select
End Sub


Private Sub txt_fec_vcto_LostFocus()
'        Dim Op
'        Dim Fecha
'        If txt_instrum.Text <> "" Then
'            Fecha = Format(gsBac_Fecp, "DD/MM/YYYY")
'            Op = CDbl(DateDiff("D", Fecha, txt_fec_vcto.Text))
'            If Op <= 0 Then
'                    MsgBox "La Fecha De Vencimiento No Debe Ser  Igual o Menor Que La De Proceso", vbExclamation, gsBac_Version
'                    txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
'                    Exit Sub
'            End If
'            SendKeys "{TAB}"
'            paso = txt_fec_vcto.Text
'            busca_datos
'        End If
End Sub

Private Sub txt_fec_pago_KeyPress(KeyAscii As Integer)
Select Case KeyAscii
Case 13
      If IsDate(txt_fec_pago.Text) Then
          SendKeys "{TAB}"
      Else
          txt_fec_pago.Text = "01/01/1900"
          txt_fec_pago.SetFocus
      End If
End Select
End Sub



Private Sub txt_instrum_DblClick()
    Call buscar_datos_ayuda
End Sub

Private Sub txt_instrum_KeyPress(KeyAscii As Integer)
Select Case KeyAscii
    Case 13
        SendKeys "{TAB}"
        Exit Sub
End Select
KeyAscii = Asc(UCase(Chr(KeyAscii)))

End Sub


Private Sub txt_monto_emi_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Me.frm_instr.Enabled = True
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_nro_cupo_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    If txt_nro_cupo.Text = "" Then
        MsgBox ("Debe ingresar el Dato Requerido ..."), vbExclamation, gsBac_Version
        txt_nro_cupo.SetFocus
    ElseIf Val(txt_nro_cupo.Text) > 0 Then
        SendKeys "{TAB}"
    Else
        MsgBox ("Debe ingresar Solo Números ..."), vbExclamation, gsBac_Version
        txt_nro_cupo.Text = Empty
        txt_nro_cupo.SetFocus
    End If
    
End If

End Sub

Private Sub txt_rut_emi_Change()
    txt_cod_cli.Text = " "
    lbl_nom_cli.Caption = " "
End Sub

Private Sub txt_rut_emi_DblClick()
    giAceptar% = False
    BacAyuda.Tag = "EMISOR"
    BacAyuda.Show vbModal
    If giAceptar% = True Then
        txt_rut_emi.Text = CDbl(Trim(Mid(gsrut$, 44, 9)))
        lbl_nom_cli.Caption = Trim(Mid(gsrut$, 1, 40))
        txt_cod_cli.Text = CDbl(Trim(Mid(gsrut$, 58, 1)))

'        txt_rut_emi.Text = Val(gsrut$)
'        lbl_nom_cli.Caption = gsDescripcion$
'        txt_cod_cli.Text = CDbl(gsvalor$)
    Else
        SendKeys "{TAB}"
    End If

End Sub

Private Sub txt_rut_emi_KeyPress(KeyAscii As Integer)
    BacCaracterNumerico KeyAscii
    
    If KeyAscii = 13 Then SendKeys "{TAB}"

End Sub


Private Sub txt_tasa_emi_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    If IsNumeric(txt_tasa_emi.Text) Then
        SendKeys "{TAB}"
    End If
End If

End Sub


