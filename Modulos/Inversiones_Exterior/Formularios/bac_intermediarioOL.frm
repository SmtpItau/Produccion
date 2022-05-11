VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Bac_Intermediario 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Datos Generales Operación"
   ClientHeight    =   8460
   ClientLeft      =   1410
   ClientTop       =   405
   ClientWidth     =   9195
   Icon            =   "bac_intermediario.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8460
   ScaleWidth      =   9195
   Begin VB.Frame Frame1 
      Caption         =   "Datos Generales"
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
      Height          =   2640
      Left            =   45
      TabIndex        =   29
      Top             =   5760
      Width           =   9105
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
         Left            =   5775
         Style           =   2  'Dropdown List
         TabIndex        =   64
         Top             =   825
         Width           =   1980
      End
      Begin VB.ComboBox cmbCustodia 
         Height          =   315
         Left            =   5760
         Style           =   2  'Dropdown List
         TabIndex        =   62
         Top             =   400
         Width           =   3255
      End
      Begin VB.ComboBox box_confirma 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   315
         Left            =   1740
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   2220
         Visible         =   0   'False
         Width           =   2445
      End
      Begin VB.TextBox txt_oper_con 
         BackColor       =   &H00C0C0C0&
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
         Height          =   330
         Left            =   4350
         TabIndex        =   18
         Top             =   2220
         Visible         =   0   'False
         Width           =   3255
      End
      Begin VB.TextBox txt_cod_ofi 
         BackColor       =   &H00C0C0C0&
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
         Left            =   8310
         TabIndex        =   58
         Top             =   195
         Visible         =   0   'False
         Width           =   600
      End
      Begin VB.TextBox txt_oficina 
         BackColor       =   &H00C0C0C0&
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
         ForeColor       =   &H80000007&
         Height          =   300
         Left            =   4395
         TabIndex        =   57
         Top             =   210
         Visible         =   0   'False
         Width           =   3810
      End
      Begin VB.ComboBox box_oper_con 
         BackColor       =   &H00FFFFFF&
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
         ItemData        =   "bac_intermediario.frx":030A
         Left            =   1740
         List            =   "bac_intermediario.frx":030C
         TabIndex        =   17
         Top             =   1470
         Width           =   2445
      End
      Begin VB.ComboBox CmbParaQuien 
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   315
         ItemData        =   "bac_intermediario.frx":030E
         Left            =   1740
         List            =   "bac_intermediario.frx":0310
         Style           =   2  'Dropdown List
         TabIndex        =   16
         Top             =   1125
         Width           =   2445
      End
      Begin VB.ComboBox CmbTipoInv 
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   315
         ItemData        =   "bac_intermediario.frx":0312
         Left            =   1740
         List            =   "bac_intermediario.frx":0314
         Style           =   2  'Dropdown List
         TabIndex        =   15
         Top             =   765
         Width           =   2445
      End
      Begin VB.Frame frm_basilea 
         Height          =   450
         Left            =   7695
         TabIndex        =   52
         Top             =   2145
         Visible         =   0   'False
         Width           =   1335
         Begin VB.CheckBox Check1 
            Caption         =   "Chk_Calce"
            ForeColor       =   &H00800000&
            Height          =   210
            Left            =   765
            TabIndex        =   21
            Top             =   165
            Width           =   210
         End
         Begin VB.Label Label 
            Caption         =   "Calce"
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
            Index           =   1
            Left            =   75
            TabIndex        =   56
            Top             =   165
            Width           =   780
         End
      End
      Begin VB.TextBox Txt_Observ 
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
         Left            =   1740
         TabIndex        =   19
         Top             =   1860
         Width           =   7305
      End
      Begin VB.ComboBox cboCarteraSuper 
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   315
         ItemData        =   "bac_intermediario.frx":0316
         Left            =   1740
         List            =   "bac_intermediario.frx":0318
         Style           =   2  'Dropdown List
         TabIndex        =   14
         Top             =   400
         Width           =   2445
      End
      Begin VB.Label Label24 
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
         Left            =   4440
         TabIndex        =   65
         Top             =   840
         Width           =   1245
      End
      Begin VB.Label Label21 
         Caption         =   "Vía Confirmación"
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
         Height          =   285
         Left            =   120
         TabIndex        =   60
         Top             =   2205
         Visible         =   0   'False
         Width           =   1485
      End
      Begin VB.Label Label20 
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
         Height          =   285
         Left            =   4335
         TabIndex        =   59
         Top             =   720
         Width           =   3405
      End
      Begin VB.Label Label19 
         Caption         =   "Custodia"
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
         Height          =   180
         Left            =   4440
         TabIndex        =   55
         Top             =   400
         Width           =   990
      End
      Begin VB.Label Label18 
         Caption         =   "Por Cuenta de "
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
         Height          =   285
         Left            =   105
         TabIndex        =   54
         Top             =   1125
         Width           =   2040
      End
      Begin VB.Label Label16 
         Caption         =   "Tipo Inversion"
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
         Left            =   105
         TabIndex        =   53
         Top             =   765
         Width           =   2040
      End
      Begin VB.Label Label8 
         Caption         =   "Observacion"
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
         Height          =   285
         Left            =   105
         TabIndex        =   41
         Top             =   1860
         Width           =   2040
      End
      Begin VB.Label Label7 
         Caption         =   "Tipo Cartera SBIF"
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
         Height          =   285
         Left            =   105
         TabIndex        =   40
         Top             =   400
         Width           =   2040
      End
      Begin VB.Label Label 
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
         ForeColor       =   &H8000000D&
         Height          =   285
         Index           =   3
         Left            =   8310
         TabIndex        =   39
         Top             =   -15
         Visible         =   0   'False
         Width           =   750
      End
      Begin VB.Label Label 
         Caption         =   "Oficina"
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
         Height          =   285
         Index           =   12
         Left            =   4335
         TabIndex        =   38
         Top             =   -15
         Visible         =   0   'False
         Width           =   2475
      End
      Begin VB.Label Label13 
         Caption         =   "Op.Contraparte"
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
         Height          =   285
         Left            =   105
         TabIndex        =   37
         Top             =   1470
         Width           =   2040
      End
   End
   Begin VB.Frame frm_banco 
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
      Height          =   1815
      Left            =   60
      TabIndex        =   44
      Top             =   3915
      Width           =   9090
      Begin VB.TextBox txt_CorBco_Des 
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
         Left            =   1575
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   9
         Top             =   315
         Width           =   7275
      End
      Begin VB.TextBox txt_CorBco_Pais 
         BackColor       =   &H00C0C0C0&
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
         Left            =   5715
         TabIndex        =   45
         Top             =   660
         Width           =   3135
      End
      Begin VB.TextBox txt_CorBco_Cta 
         BackColor       =   &H00FFFFFF&
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
         Left            =   1575
         TabIndex        =   10
         Top             =   660
         Width           =   2445
      End
      Begin VB.TextBox txt_CorBco_ABA 
         BackColor       =   &H00FFFFFF&
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
         Left            =   1575
         TabIndex        =   11
         Top             =   1020
         Width           =   2445
      End
      Begin VB.TextBox txt_CorBco_Swi 
         BackColor       =   &H00FFFFFF&
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
         Left            =   5715
         TabIndex        =   12
         Top             =   1020
         Width           =   3135
      End
      Begin VB.TextBox txt_CorBco_Ref 
         BackColor       =   &H00FFFFFF&
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
         Left            =   1575
         TabIndex        =   13
         Top             =   1365
         Width           =   7290
      End
      Begin VB.Label Label15 
         Caption         =   "Banco"
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
         Height          =   270
         Left            =   150
         TabIndex        =   51
         Top             =   330
         Width           =   1095
      End
      Begin VB.Label Label14 
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
         ForeColor       =   &H8000000D&
         Height          =   270
         Left            =   4350
         TabIndex        =   50
         Top             =   660
         Width           =   1500
      End
      Begin VB.Label Label12 
         Caption         =   "Número Cuenta"
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
         Height          =   270
         Left            =   150
         TabIndex        =   49
         Top             =   660
         Width           =   1425
      End
      Begin VB.Label Label11 
         Caption         =   "Código ABA"
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
         Height          =   270
         Left            =   150
         TabIndex        =   48
         Top             =   1020
         Width           =   1425
      End
      Begin VB.Label Label3 
         Caption         =   "Código SWIFT"
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
         Height          =   270
         Left            =   4350
         TabIndex        =   47
         Top             =   1020
         Width           =   1500
      End
      Begin VB.Label Label2 
         Caption         =   "Referencia"
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
         Height          =   270
         Left            =   150
         TabIndex        =   46
         Top             =   1365
         Width           =   1095
      End
   End
   Begin VB.Frame frm_cliente 
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
      Height          =   1545
      Left            =   60
      TabIndex        =   30
      Top             =   525
      Width           =   9090
      Begin VB.TextBox txt_cusip 
         Height          =   315
         Left            =   1560
         MaxLength       =   12
         TabIndex        =   3
         Top             =   1170
         Width           =   2475
      End
      Begin VB.TextBox txt_cod_contra 
         Height          =   315
         Left            =   1545
         MaxLength       =   30
         TabIndex        =   2
         Top             =   795
         Width           =   4245
      End
      Begin VB.TextBox txtDigCli 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         Height          =   285
         Left            =   8610
         MaxLength       =   1
         TabIndex        =   36
         Top             =   420
         Visible         =   0   'False
         Width           =   240
      End
      Begin VB.TextBox TxtCodCli 
         Height          =   315
         Left            =   1545
         MaxLength       =   7
         TabIndex        =   1
         Top             =   420
         Width           =   1035
      End
      Begin VB.TextBox txtRutCli 
         Alignment       =   1  'Right Justify
         Height          =   315
         Left            =   165
         MaxLength       =   9
         MouseIcon       =   "bac_intermediario.frx":031A
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   0
         Top             =   420
         Width           =   1200
      End
      Begin VB.Label Label23 
         Caption         =   "Cusip"
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
         TabIndex        =   63
         Top             =   1200
         Width           =   1455
      End
      Begin VB.Label Label22 
         Caption         =   "FFC_A/C#"
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
         Height          =   225
         Left            =   165
         TabIndex        =   61
         Top             =   855
         Width           =   1275
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
         Height          =   195
         Index           =   9
         Left            =   1605
         TabIndex        =   35
         Top             =   195
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
         Height          =   315
         Index           =   0
         Left            =   1320
         TabIndex        =   34
         Top             =   435
         Visible         =   0   'False
         Width           =   285
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
         Height          =   240
         Index           =   5
         Left            =   165
         TabIndex        =   33
         Top             =   195
         Width           =   825
      End
      Begin VB.Label Label17 
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
         Height          =   225
         Left            =   2775
         TabIndex        =   32
         Top             =   195
         Width           =   675
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
         Height          =   315
         Left            =   2685
         TabIndex        =   31
         Top             =   420
         Width           =   5715
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   28
      Top             =   0
      Width           =   9195
      _ExtentX        =   16219
      _ExtentY        =   847
      ButtonWidth     =   714
      ButtonHeight    =   688
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   2145
         Top             =   45
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
               Picture         =   "bac_intermediario.frx":0624
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_intermediario.frx":0A76
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_intermediario.frx":0EC8
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_intermediario.frx":11E2
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "bac_intermediario.frx":14FC
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frm_destino 
      Caption         =   "Corresponsal Contraparte"
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
      Height          =   1800
      Left            =   60
      TabIndex        =   23
      Top             =   2100
      Width           =   9090
      Begin VB.TextBox txt_CorCli_Ref 
         BackColor       =   &H00FFFFFF&
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
         Left            =   1575
         TabIndex        =   8
         Top             =   1365
         Width           =   7290
      End
      Begin VB.TextBox txt_CorCli_Swi 
         BackColor       =   &H00FFFFFF&
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
         Left            =   5715
         TabIndex        =   7
         Top             =   1020
         Width           =   3150
      End
      Begin VB.TextBox txt_CorCli_ABA 
         BackColor       =   &H00FFFFFF&
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
         Left            =   1575
         TabIndex        =   6
         Top             =   1020
         Width           =   2445
      End
      Begin VB.TextBox txt_CorCli_Cta 
         BackColor       =   &H00FFFFFF&
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
         Left            =   1575
         TabIndex        =   5
         Top             =   660
         Width           =   2445
      End
      Begin VB.TextBox txt_CorCli_Pais 
         BackColor       =   &H00C0C0C0&
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
         Left            =   5715
         TabIndex        =   22
         Top             =   660
         Width           =   3150
      End
      Begin VB.TextBox txt_CorCli_destino 
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
         Left            =   1575
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   4
         Top             =   315
         Width           =   7290
      End
      Begin VB.Label Label1 
         Caption         =   "Referencia"
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
         Height          =   270
         Left            =   150
         TabIndex        =   43
         Top             =   1365
         Width           =   1095
      End
      Begin VB.Label Label9 
         Caption         =   "Código SWIFT"
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
         Height          =   270
         Left            =   4365
         TabIndex        =   42
         Top             =   1020
         Width           =   1500
      End
      Begin VB.Label Label10 
         Caption         =   "Código ABA"
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
         Height          =   270
         Left            =   150
         TabIndex        =   27
         Top             =   1020
         Width           =   1425
      End
      Begin VB.Label Label6 
         Caption         =   "Número Cuenta"
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
         Height          =   270
         Left            =   150
         TabIndex        =   26
         Top             =   660
         Width           =   1425
      End
      Begin VB.Label Label5 
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
         ForeColor       =   &H8000000D&
         Height          =   270
         Left            =   4365
         TabIndex        =   25
         Top             =   660
         Width           =   1500
      End
      Begin VB.Label Label4 
         Caption         =   "Banco"
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
         Height          =   270
         Left            =   150
         TabIndex        =   24
         Top             =   330
         Width           =   1095
      End
   End
End
Attribute VB_Name = "Bac_Intermediario"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim ObjCliente      As New clsCliente
Dim ObjTipoInv      As New clsCodigos
Dim ObjParaQuien    As New clsCodigos
Dim Moneda          As Integer


Function busca_rut(rut)
    Dim Datos()
    busca_rut = 0
    envia = Array()
    AddParam envia, CDbl(rut)
    If Bac_Sql_Execute("Svc_Ope_dat_emi", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            'If datos(1) <> 0 Then
            '    lbl_nom_cli.Caption = datos(1)
            'End If
        Loop
    End If
    If Datos(1) = 0 Then
        MsgBox "Rut Inexistente", vbExclamation, gsBac_Version
        'txt_rut_cli.SetFocus
        Exit Function
    End If
    busca_rut = Datos(1)
End Function


Function buscar_codigo_contraparte(rut, Codigo)
    Dim Datos()
    envia = Array()
    AddParam envia, rut
    AddParam envia, Codigo
    If Bac_Sql_Execute("Svc_Int_bus_cor", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            txt_cod_contra.Text = Datos(1)
        Loop
    End If
    
End Function

Function buscar_datos(rut, OpC)
    Dim Datos()
    envia = Array()
    AddParam envia, CDbl(rut)
    If Bac_Sql_Execute("Svc_Ope_dat_emi", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            If Datos(1) <> 0 Then
                If OpC = 1 Then
                    'L1.Caption = datos(1)
                ElseIf OpC = 2 Then
                    'L2.Caption = datos(1)
                ElseIf OpC = 3 Then
                    'l3.Caption = datos(1)
                End If
            End If
        Loop
    End If
    If Datos(1) = 0 Then
        MsgBox "Rut Inexsistente", vbExclamation, gsBac_Version
    End If
End Function



















Function buscar_oficina(Oficina)
    Dim Datos()
    envia = Array()
    AddParam envia, Oficina
    If Bac_Sql_Execute("Svc_Int_ofi_ope", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            buscar_oficina = Datos(1)
        Loop
    End If
    
End Function

Function carga_combo_operadores(rut)
    If rut = 0 Or rut = "" Then
        Exit Function
    End If
    
    Dim Datos()
    envia = Array()
    AddParam envia, rut
    box_oper_con.Clear
    
    
    If Bac_Sql_Execute(" Svc_Int_bus_ope", envia) Then
    
        Do While Bac_SQL_Fetch(Datos)
        
            box_oper_con.AddItem Datos(2)
        Loop
    
    End If
    box_oper_con.ListIndex = -1
End Function

Function Sva_Int_grb_ffc(rut, Codigo, ide)

    Dim Datos()
    envia = Array()
    AddParam envia, rut
    AddParam envia, Codigo
    AddParam envia, ide
    
    If Bac_Sql_Execute("Sva_Int_grb_ffc", envia) Then
        Do While Bac_SQL_Fetch(Datos)
        Loop
        Sva_Int_grb_ffc = True
    End If
    
End Function

'Function graba_datos()
'
'
'
'    Call llena_variables_grabar
'    Dim datos()
'    envia = Array()
'    AddParam envia, Fec_pro
'    AddParam envia, Rut_cartera
'    AddParam envia, Num_Docu
'    AddParam envia, num_ope
'    AddParam envia, Tipo_Ope
'    AddParam envia, cod_nemo
'    AddParam envia, cod_familia
'    AddParam envia, rut_cli
'    AddParam envia, cod_cli
'    AddParam envia, fec_emi
'    AddParam envia, Fec_vcto
'    AddParam envia, mone_emi
'    AddParam envia, tasa_emi
'    AddParam envia, base_emi
'    AddParam envia, (rut_emi)
'    AddParam envia, fec_pag
'    AddParam envia, Nominal
'    AddParam envia, (val_pre)
'    AddParam envia, (val_pro_venc)
'    AddParam envia, (valor_pag_pes)
'    AddParam envia, (valor_pag_UM)
'    AddParam envia, (tir)
'    AddParam envia, (por_valor_compra)
'    AddParam envia, (valor_par)
'    AddParam envia, (interes_compra)
'    AddParam envia, (principal)
'    AddParam envia, (valor_compra_pes)
'    AddParam envia, (valor_compra_UM)
'    AddParam envia, (numero_ult_cupon)
'    AddParam envia, (numero_pro_cupon)
'    AddParam envia, (usuario_ope)
'    AddParam envia, (terminal)
'    AddParam envia, obseravcion
'    AddParam envia, codigo_cartera_super
'    AddParam envia, Sucursal
'    AddParam envia, nom_corres
'    AddParam envia, Cta_corres
'    AddParam envia, pais_corres
'    AddParam envia, ABA_corres
'    AddParam envia, ciu_corres
'    AddParam envia, banco_fon
'    AddParam envia, cta_fon
'    AddParam envia, pais_fon
'    AddParam envia, ciu_fon
'    AddParam envia, Oper_Con
'    If Bac_Sql_Execute("sp_invex_compra_o_venta", envia) Then
'        Do While Bac_SQL_Fetch(datos)
'        Loop
'        MsgBox "Datos Grabados Con Exito", vbInformation, Me.Caption
'    End If
'
'
'End Function
'
Sub Llena_Categoria_Super()

    Dim Datos()

    If Not Bac_Sql_Execute("Svc_Gen_car_sup") Then
      Exit Sub
    End If
    
    cboCarteraSuper.Clear
    
    Do While Bac_SQL_Fetch(Datos())
        cboCarteraSuper.AddItem Datos(1)
    Loop
    
End Sub

Function llena_variables_grabar()

    rut_cli = txtRutCli.Text
    Cod_cli = CDbl(TxtCodCli.Text)
    obseravcion = Txt_Observ.Text
    Sucursal = txt_cod_ofi.Text
    Oper_Con = box_oper_con.Text
    Oper_bech = txt_oper_con.Text
    corr_cli_bco = txt_CorCli_destino.Text
    corr_cli_Cta = txt_CorCli_Cta.Text
    corr_cli_pais = txt_CorCli_Pais.Text
    corr_cli_ABA = txt_CorCli_ABA.Text
    corr_cli_swi = txt_CorCli_Swi.Text
    corr_cli_ref = txt_CorCli_Ref.Text
    
    corr_bco_bco = txt_CorBco_Des.Text
    corr_bco_Cta = txt_CorBco_Cta.Text
    corr_bco_pais = txt_CorBco_Pais.Text
    corr_bco_ABA = txt_CorBco_ABA.Text
    corr_bco_swi = txt_CorBco_Swi.Text
    corr_bco_ref = txt_CorBco_Ref.Text
    Confirmacion = 0 'Se invisibilizo combo, por lo  que asume que siempre sera swift
    cusip = txt_cusip.Text
    
    If Tipo_op = "V" Then
        gsFormaPago = box_forma_pago.ItemData(box_forma_pago.ListIndex)
    Else
        gsFormaPago = 0
    End If
    
    If Tipo_op = "C" Then
        calce = Check1.Value
        codigo_cartera_super = Mid$(cboCarteraSuper.Text, 1, 1)
        Tipo_Inversion = CmbTipoInv.ItemData(CmbTipoInv.ListIndex)
        para_quien = CmbParaQuien.ItemData(CmbParaQuien.ListIndex)
        If cmbCustodia.ListIndex > -1 Then
            custodia = cmbCustodia.ItemData(cmbCustodia.ListIndex)
        Else
            custodia = 0
        End If
    End If
    
End Function

Function valida_datos()
    valida_datos = True
    If Me.txt_CorBco_ABA.Text = "" Then
        MsgBox "Falta Ingresar Código Abba", vbExclamation, gsBac_Version
        valida_datos = False
        txt_CorBco_ABA.SetFocus
    ElseIf TxtCodCli.Text = "" Then
        MsgBox "Falta Ingresar Código Contraparte", vbExclamation, gsBac_Version
        valida_datos = False
        TxtCodCli.SetFocus
        valida_datos = False
    ElseIf Me.txt_CorBco_Cta.Text = "" Then
        MsgBox "Falta Ingresar Cuenta", vbExclamation, gsBac_Version
        valida_datos = False
        txt_CorBco_Cta.SetFocus
        valida_datos = False

    ElseIf Me.txt_CorBco_Swi.Text = "" Then
        MsgBox "Falta Ingresar Código Swif", vbExclamation, gsBac_Version
        valida_datos = False
        txt_CorBco_Swi.SetFocus
        

    ElseIf Me.txt_CorBco_Des.Text = "" Then
        MsgBox "Falta Ingresar Corresponsal", vbExclamation, gsBac_Version
        valida_datos = False
        txt_CorBco_Des.SetFocus
    
'--------------------------------------
    ElseIf Me.txt_CorCli_ABA.Text = "" Then
        MsgBox "Falta Ingresar Código Abba", vbExclamation, gsBac_Version
        valida_datos = False
        txt_CorCli_ABA.SetFocus
    
    ElseIf Me.txt_CorCli_Cta.Text = "" Then
        MsgBox "Falta Ingresar Cuenta", vbExclamation, gsBac_Version
        txt_CorCli_Cta.SetFocus
        valida_datos = False

    ElseIf Me.txt_CorCli_Swi.Text = "" Then
        MsgBox "Falta Ingresar Código Swif", vbExclamation, gsBac_Version
        valida_datos = False
        txt_CorCli_Swi.SetFocus
        valida_datos = True

    ElseIf Me.txt_CorCli_destino.Text = "" Then
        MsgBox "Falta Ingresar Corresponsal", vbExclamation, gsBac_Version
        valida_datos = False
        txt_CorCli_destino.SetFocus
        valida_datos = True

'--------------------------------------

    ElseIf txt_oper_con.Text = " " Then
        MsgBox "Falta Ingresar el Operador ", vbExclamation, gsBac_Version
        valida_datos = False
        txt_oper_con.SetFocus
'    ElseIf box_confirma.Text = "" Then
'        MsgBox "Falta Ingresar La Vía de Confirmación", vbExclamation, gsBac_Version
'        valida_datos = False
'        box_confirma.SetFocus

    ElseIf txt_cod_contra.Text = "" Then
        MsgBox "Falta Ingresar Identificación de Contraparte", vbExclamation, gsBac_Version
        valida_datos = False
        txt_cod_contra.SetFocus

'    ElseIf box_oper_con.Text = "" Then
'        MsgBox "Falta Ingresar el Operador Contraparte", vbExclamation, gsBac_Version
'        valida_datos = False
'        box_oper_con.SetFocus
    ElseIf txtRutCli.Text = "" Then
        MsgBox "Falta Ingresar el Rut", vbExclamation, gsBac_Version
        valida_datos = False
        txtRutCli.SetFocus
    ElseIf TxtCodCli.Text = "" Then
        MsgBox "Falta Ingresar el Còdigo de Cliente", vbExclamation, gsBac_Version
        valida_datos = False
        TxtCodCli.SetFocus
    ElseIf txt_CorCli_destino.Text = "" Then
        MsgBox "Falta Corresponsal Contraparte", vbExclamation, gsBac_Version
        valida_datos = False
        txt_CorCli_destino.SetFocus
    ElseIf txt_CorBco_Des.Text = "" Then
        MsgBox "Falta Corresponsal Banco", vbExclamation, gsBac_Version
        valida_datos = False
        txt_CorBco_Des.SetFocus
'    ElseIf txt_num_cta_des.Text = "" Then
'        MsgBox "Falta Ingresar el Númro de Cuenta Destino", vbExclamation, gsBac_Version
'        Valida_datos = False
'        txt_num_cta_des.SetFocus
'    ElseIf txt_pais_des.Text = "" Then
'        MsgBox "Falta Ingresar el País Destino", vbExclamation, gsBac_Version
'        Valida_datos = False
'        txt_pais_des.SetFocus
'    ElseIf txt_cod_aba.Text = "" Then
'        MsgBox "Falta Ingresar el Código ABA", vbExclamation, gsBac_Version
'        Valida_datos = False
'        txt_cod_aba.SetFocus
    ElseIf cboCarteraSuper.ListIndex = -1 And Tipo_op = "C" Then
        MsgBox "Falta Selecionar Cartera Super", vbExclamation, gsBac_Version
        valida_datos = False
        cboCarteraSuper.SetFocus
    
    ElseIf CmbTipoInv.ListIndex = -1 And Tipo_op = "C" Then
        MsgBox "Falta Selecionar Tipo Inversion", vbExclamation, gsBac_Version
        valida_datos = False
        CmbTipoInv.SetFocus
    ElseIf CmbParaQuien.ListIndex = -1 And Tipo_op = "C" Then
        MsgBox "Falta Selecionar por Cuenta de Quién", vbExclamation, gsBac_Version
        valida_datos = False
        CmbParaQuien.SetFocus
'    ElseIf txt_oper_con.Text = "" Then
'        MsgBox "Falta Ingresar Operador Contraparte", vbExclamation, gsBac_Version
'        Valida_datos = False
    'ElseIf TxtCustodia.Text = "" And Tipo_op = "C" Then
    '    MsgBox "Falta Ingresar Custodia Instrumento", vbExclamation, gsBac_Version
    '    valida_datos = False
    '    TxtCustodia.SetFocus
    ElseIf box_forma_pago.Visible = True And box_forma_pago.ListIndex = -1 Then
        MsgBox "Falta Ingresar Forma de Pago", vbExclamation, gsBac_Version
        valida_datos = False
         box_forma_pago.SetFocus
    End If
    
  
End Function

Private Sub box_confirma_Click()
    Confirmacion = 0 'box_confirma.ItemData(box_confirma.ListIndex)
    If box_confirma.Text = "FAX" Then
        Bac_Fax.Show 1
        giSW = True
    End If

End Sub


Private Sub box_confirma_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub


Private Sub box_oper_con_Click()
    SendKeys "{TAB}"
End Sub

Private Sub box_oper_con_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub Form_Load()

    Dim objSucursales As clsSucursales

    giAceptar = False
    txt_oper_con.Text = Bac_Usr_nom
    txt_cod_ofi.Text = Bac_Usr_ofi
    txt_oficina.Text = buscar_oficina(Bac_Usr_ofi)
    
    If Tipo_op = "C" Then
        Me.Caption = Me.Caption & " (Compra)"
    ElseIf Tipo_op = "V" Then
        Me.Caption = Me.Caption & " (Venta)"
    End If
    
    Me.frm_banco.Caption = "Corresponsal " & gsBac_CartNOM
   ' Label20.Caption = "Operador " & gsBac_CartNOM
         
    Moneda = Val(gsmoneda)
    
    Call Llena_Categoria_Super
    'Call ObjTipoInv.LeerCodigos(1104)
    Call ObjTipoInv.LeerCodigos(204)
    Call ObjTipoInv.Coleccion2Control(CmbTipoInv)
    Call llena_combo_confirmacion
    Call ObjParaQuien.LeerCodigos(1105)
    Call ObjParaQuien.Coleccion2Control(CmbParaQuien)
    
    Call ObjParaQuien.LeerCodigos(1110)
    Call ObjParaQuien.Coleccion2Control(cmbCustodia)
    cmbCustodia.AddItem "  ": cmbCustodia.ItemData(cmbCustodia.NewIndex) = 0
  
    If Tipo_op = "V" Then
        box_forma_pago.Visible = True
        Call llena_combo_forma_pago(13, 13, box_forma_pago)
        cboCarteraSuper.Enabled = False
        CmbParaQuien.Enabled = False
        CmbTipoInv.Enabled = False
        Check1.Enabled = False
        cmbCustodia.Enabled = False
        txt_cusip.Text = cusip
    End If
    
     If Tipo_op = "C" Then
        box_forma_pago.Visible = False
        Label24.Visible = False
        CmbTipoInv.ListIndex = 0
        cboCarteraSuper.ListIndex = 0
        CmbParaQuien.ListIndex = 0
        txt_oper_con.Visible = False
    End If
        
    
End Sub
Function llena_combo_confirmacion()
    Dim Datos()
    box_confirma.Clear
    If Bac_Sql_Execute("Svc_Int_bus_cfm") Then
        Do While Bac_SQL_Fetch(Datos)
            box_confirma.AddItem Datos(2)
            box_confirma.ItemData(box_confirma.NewIndex) = Val(Datos(1))
        Loop
    End If
    
End Function


Private Sub Form_Unload(Cancel As Integer)
    Set ObjCliente = Nothing
End Sub

Private Sub frm_operador_DragDrop(Source As Control, X As Single, Y As Single)

End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            If valida_datos Then
                llena_variables_grabar
                If Sva_Int_grb_ffc(txtRutCli.Text, Me.TxtCodCli.Text, txt_cod_contra.Text) Then
                    giAceptar = True
                Else
                    Exit Sub
                End If
                Unload Me
            End If
            
        Case 2
            giAceptar = False
            Unload Me
    End Select
End Sub



Private Sub txt_rut_cli_DblClick()

    Ayuda
    If Not giAceptar% = False Then SendKeys "{TAB 2}"

End Sub

Private Sub Ayuda()

    BacAyuda.Tag = "MDCL"
    BacAyuda.Show 1
'   BacControlWindows 12
    
    If giAceptar% = True Then
        txtRutCli.Text = Val(gsrut$)
        txtDigCli.Text = gsDigito$
        lbl_nom_cli.Caption = gsDescripcion$
        TxtCodCli.Text = gsvalor$
    End If

End Sub

Private Sub txt_cod_cor_bech_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_cod_cor_con_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub


Private Sub txt_CorBco_ABA_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txt_CorBco_Cta_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txt_CorBco_Des_DblClick()

    gsrut = gsBac_RutC
    gsvalor = 1
    gsmoneda = Str(Moneda)
    
    BacAyuda.Tag = "CORR"
    BacAyuda.Show 1
    
    If giAceptar% = True Then
        txt_CorBco_Des.Text = gsDescripcion$
        Call txt_CorBco_Des_LostFocus
        
    Else
       SendKeys "{TAB}"
    End If

End Sub

Private Sub txt_CorBco_Des_KeyPress(KeyAscii As Integer)
    If KeyAscii <> 8 Then
        KeyAscii = 0
    End If

End Sub


Private Sub txt_CorBco_Des_LostFocus()

    Dim Datos()
    Dim sw As Integer

    If Trim(txt_CorBco_Des.Text) <> "" Then
    
        sw = 0
        envia = Array()
        AddParam envia, gsBac_RutC
        AddParam envia, 1
        AddParam envia, Moneda
        AddParam envia, txt_CorBco_Des.Text
    
        If Bac_Sql_Execute("Svc_Ayd_dat_cor", envia) Then
            Do While Bac_SQL_Fetch(Datos())
                txt_CorBco_Cta.Text = Datos(3)
                'txt_CorBco_Pais.Text = datos(2)
                txt_CorBco_ABA.Text = Datos(7)
                txt_CorBco_Swi.Text = Datos(5)
                txt_CorBco_Pais.Text = Datos(8)
                sw = 1
            Loop
            
            If sw = 0 Then
            
                MsgBox "Corresponsal No Existe", vbExclamation, gsBac_Version
                txt_CorBco_Cta.Text = ""
                txt_CorBco_Pais.Text = ""
                txt_CorBco_ABA.Text = ""
                txt_CorBco_Swi.Text = ""
                txt_CorBco_Ref.Text = ""
'               txt_CorBco_Des.SetFocus
            
            End If
            
        End If
        
        
        

    End If
    


End Sub

Private Sub txt_CorBco_Ref_Change()
    With Me.txt_CorBco_Ref
            .Text = UCase(.Text)
            .SelStart = Len(Me.txt_CorBco_Ref.Text) + 1
End With
End Sub

Private Sub txt_CorBco_Swi_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub txt_CorCli_ABA_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub txt_CorCli_Cta_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub txt_CorCli_destino_DblClick()

    gsrut = txtRutCli.Text
    gsvalor = TxtCodCli.Text
    gsmoneda = Str(Moneda)
    
    BacAyuda.Tag = "CORR"
    BacAyuda.Show 1
'   BacControlWindows 12
    
    If giAceptar% = True Then
        txt_CorCli_destino.Text = gsDescripcion$
        Call txt_CorCli_destino_LostFocus
        
    Else
       SendKeys "{TAB 2}"
    End If
    

End Sub

Private Sub txt_CorCli_destino_KeyPress(KeyAscii As Integer)
    If KeyAscii <> 8 Then
        KeyAscii = 0
    End If
End Sub


Private Sub txt_CorCli_destino_LostFocus()

    Dim Datos()
    Dim sw As Integer

    If Trim(txt_CorCli_destino.Text) <> "" Then
    
        sw = 0
        envia = Array()
        AddParam envia, Val(txtRutCli.Text)
        AddParam envia, Val(TxtCodCli.Text)
        AddParam envia, Moneda
        AddParam envia, txt_CorCli_destino.Text
    
        If Bac_Sql_Execute("Svc_Ayd_dat_cor", envia) Then
            Do While Bac_SQL_Fetch(Datos())
                txt_CorCli_Cta.Text = Datos(3)
                'txt_CorCli_Pais.Text = datos(2)
                txt_CorCli_ABA.Text = Datos(7)
                txt_CorCli_Swi.Text = Datos(5)
                txt_CorCli_Pais.Text = Datos(9)
                
                sw = 1
            Loop
            
            If sw = 0 Then
            
                MsgBox "Corresponsal No Existe", vbExclamation, gsBac_Version
                txt_CorCli_Cta.Text = ""
                txt_CorCli_Pais.Text = ""
                txt_CorCli_ABA.Text = ""
                txt_CorCli_Swi.Text = ""
                txt_CorCli_Ref.Text = ""
                txt_CorCli_destino.SetFocus
            
            End If
            
        End If

    End If

End Sub

Private Sub txt_CorCli_Ref_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txt_CorCli_Swi_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub Txt_Observ_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txt_oper_con_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub TxtCodCli_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then SendKeys "{TAB}"
    
    KeyAscii = BACValIngNumGrid(KeyAscii)
    
    If Chr(KeyAscii) = "-" Or Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
       KeyAscii = 0
    End If

End Sub

Private Sub TxtCodCli_LostFocus()

    If Len(Trim$(TxtCodCli.Text)) = 0 Then Exit Sub
    
    If Val(txtRutCli.Text) <> 0 Then
    
        Call ObjCliente.LeerPorRut(txtRutCli.Text, txtDigCli.Text, 0, TxtCodCli.Text)
        
        If ObjCliente.clrut = 0 Then
            txtRutCli.Text = ""
            txtDigCli.Text = ""
            TxtCodCli.Text = ""
            MsgBox "Cliente no existente, verifique datos.", vbExclamation, gsBac_Version
            Toolbar1.Buttons(2).Enabled = True
            txtRutCli.SetFocus
        Else
            txtDigCli.Text = ObjCliente.cldv
            lbl_nom_cli.Caption = ObjCliente.clnombre
            TxtCodCli.Text = ObjCliente.clcodigo
            Call buscar_codigo_contraparte(txtRutCli.Text, TxtCodCli.Text)
            Toolbar1.Buttons(1).Enabled = True
        End If
        
    End If
    
    Exit Sub
    

End Sub


Private Sub TxtCustodia_KeyPress(KeyAscii As Integer)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txtRutCli_Change()

    lbl_nom_cli.Caption = ""
    txtDigCli.Text = ""
    txt_cod_contra.Text = " "
    Toolbar1.Buttons(1).Enabled = True
    TxtCodCli.Text = ""
    
    
    txt_CorCli_destino.Text = ""
    txt_CorCli_Cta.Text = ""
    txt_CorCli_Pais.Text = ""
    txt_CorCli_ABA.Text = ""
    txt_CorCli_Swi.Text = ""
    txt_CorCli_Ref.Text = ""

    

End Sub


Private Sub txtRutCli_DblClick()

    BacAyuda.Tag = "MDCL"
    BacAyuda.Show 1
'   BacControlWindows 12
    
    If giAceptar% = True Then
        txtRutCli.Text = Val(gsrut$)
        txtDigCli.Text = gsDigito$
        lbl_nom_cli.Caption = gsDescripcion$
        TxtCodCli.Text = gsvalor$
        Call buscar_pais_contra(txtRutCli.Text, TxtCodCli)
        Call buscar_codigo_contraparte(txtRutCli.Text, TxtCodCli)
    Else
        SendKeys "{TAB 2}"
    End If

End Sub
Function buscar_pais_contra(rut, Codigo)
    Dim Datos()
    envia = Array()
    AddParam envia, rut
    AddParam envia, Codigo
    If Bac_Sql_Execute("Svc_Int_pai_cli", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            Pais_invers = Datos(1)
        Loop
    End If
End Function

Private Sub txtRutCli_KeyPress(KeyAscii As Integer)

    BacCaracterNumerico KeyAscii
    
    If KeyAscii = 13 Then SendKeys "{TAB}"

End Sub

Private Sub txtRutCli_LostFocus()
    Call carga_combo_operadores(txtRutCli.Text)
End Sub

