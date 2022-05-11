VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form Frm_CierreDia 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Cierre Automático del Día"
   ClientHeight    =   6795
   ClientLeft      =   1920
   ClientTop       =   1380
   ClientWidth     =   7455
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacciere.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   MousePointer    =   1  'Arrow
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6795
   ScaleWidth      =   7455
   Begin VB.Frame Frame1 
      Height          =   6735
      Left            =   60
      TabIndex        =   0
      Top             =   30
      Width           =   7335
      Begin VB.Frame Frame6 
         Enabled         =   0   'False
         ForeColor       =   &H00000000&
         Height          =   615
         Left            =   120
         TabIndex        =   44
         Top             =   4680
         Width           =   7095
         Begin VB.CheckBox Chk_TaSi 
            Caption         =   " SI"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   6100
            TabIndex        =   47
            Top             =   240
            Width           =   615
         End
         Begin VB.CheckBox Chk_TaNo 
            BackColor       =   &H00C0C0C0&
            Caption         =   " NO"
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
            Height          =   255
            Left            =   5260
            TabIndex        =   46
            Top             =   240
            Value           =   1  'Checked
            Width           =   870
         End
         Begin VB.Label Label2 
            BorderStyle     =   1  'Fixed Single
            Caption         =   "  ..............................."
            Height          =   255
            Index           =   8
            Left            =   3480
            TabIndex        =   48
            Top             =   240
            Width           =   1575
         End
         Begin VB.Label Label2 
            BackColor       =   &H00808000&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "5.- Proceso de Cierre Sistema AS400"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FFFFFF&
            Height          =   255
            Index           =   10
            Left            =   120
            TabIndex        =   45
            Top             =   240
            Width           =   3255
         End
      End
      Begin VB.Frame Frame10 
         Height          =   495
         Left            =   5400
         TabIndex        =   40
         Top             =   120
         Width           =   1815
      End
      Begin VB.Frame Frame9 
         Height          =   495
         Left            =   120
         TabIndex        =   39
         Top             =   120
         Width           =   1815
      End
      Begin VB.Frame Frame3 
         Enabled         =   0   'False
         Height          =   615
         Left            =   120
         TabIndex        =   38
         Top             =   2760
         Width           =   7095
         Begin VB.CheckBox Chk_FsSi 
            Caption         =   " SI"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   6100
            TabIndex        =   43
            Top             =   240
            Width           =   615
         End
         Begin VB.CheckBox Chk_FsNo 
            Caption         =   " NO"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   5260
            TabIndex        =   42
            Top             =   240
            Width           =   870
         End
         Begin VB.Label Label2 
            BackColor       =   &H00808000&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "3.- Valorización, Contabilidad Factores SBIF y P17"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FFFFFF&
            Height          =   255
            Index           =   13
            Left            =   120
            TabIndex        =   41
            Top             =   240
            Width           =   4455
         End
      End
      Begin VB.Frame Frame8 
         BackColor       =   &H00C0C0C0&
         Enabled         =   0   'False
         ForeColor       =   &H00000000&
         Height          =   615
         Left            =   120
         TabIndex        =   33
         Top             =   600
         Width           =   7095
         Begin VB.CheckBox Chk_CMSi 
            BackColor       =   &H00C0C0C0&
            Caption         =   " SI"
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
            Height          =   255
            Left            =   6100
            TabIndex        =   36
            Top             =   240
            Width           =   615
         End
         Begin VB.CheckBox Chk_CMNo 
            BackColor       =   &H00C0C0C0&
            Caption         =   " NO"
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
            Height          =   255
            Left            =   5260
            TabIndex        =   35
            Top             =   240
            Value           =   1  'Checked
            Width           =   870
         End
         Begin VB.Label Label2 
            BackColor       =   &H00808000&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "1.- Carga de Monedas desde BAE"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FFFFFF&
            Height          =   255
            Index           =   12
            Left            =   120
            TabIndex        =   34
            Top             =   240
            Width           =   3015
         End
      End
      Begin VB.Frame Frame7 
         Height          =   735
         Left            =   120
         TabIndex        =   30
         Top             =   5880
         Width           =   7095
         Begin Threed.SSCommand Com_Pro 
            Height          =   375
            Left            =   4680
            TabIndex        =   50
            Top             =   240
            Width           =   1095
            _Version        =   65536
            _ExtentX        =   1931
            _ExtentY        =   661
            _StockProps     =   78
            Caption         =   "&Procesar"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            Font3D          =   4
         End
         Begin Threed.SSCommand Com_Sal 
            Height          =   375
            Left            =   5880
            TabIndex        =   49
            Top             =   240
            Width           =   1095
            _Version        =   65536
            _ExtentX        =   1931
            _ExtentY        =   661
            _StockProps     =   78
            Caption         =   "&Salir"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            Font3D          =   4
         End
         Begin VB.Label Lbl_Info 
            BorderStyle     =   1  'Fixed Single
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   375
            Left            =   120
            TabIndex        =   32
            Top             =   240
            Width           =   4455
         End
      End
      Begin VB.Frame Frame5 
         Enabled         =   0   'False
         Height          =   615
         Left            =   120
         TabIndex        =   26
         Top             =   5280
         Width           =   7095
         Begin VB.CheckBox Chk_FdSi 
            Caption         =   " SI"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   6100
            TabIndex        =   29
            Top             =   240
            Width           =   615
         End
         Begin VB.CheckBox Chk_FdNo 
            BackColor       =   &H00C0C0C0&
            Caption         =   " NO"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   5260
            TabIndex        =   28
            Top             =   240
            Value           =   1  'Checked
            Width           =   870
         End
         Begin VB.Label Label2 
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Respaldo Diario de Información  ......................"
            ForeColor       =   &H00800000&
            Height          =   255
            Index           =   11
            Left            =   1680
            TabIndex        =   31
            Top             =   240
            Width           =   3375
         End
         Begin VB.Label Label2 
            BackColor       =   &H00808000&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "6.- Fin de Día"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FFFFFF&
            Height          =   255
            Index           =   9
            Left            =   120
            TabIndex        =   27
            Top             =   240
            Width           =   1455
         End
      End
      Begin VB.Frame Frame4 
         Enabled         =   0   'False
         Height          =   1335
         Left            =   120
         TabIndex        =   15
         Top             =   3360
         Width           =   7095
         Begin VB.CheckBox Chk_Arc3Si 
            Caption         =   " SI"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   6100
            TabIndex        =   25
            Top             =   990
            Width           =   615
         End
         Begin VB.CheckBox Chk_Arc2Si 
            Caption         =   " SI"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   6100
            TabIndex        =   24
            Top             =   720
            Width           =   615
         End
         Begin VB.CheckBox Chk_Arc1Si 
            Caption         =   " SI"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   6100
            TabIndex        =   23
            Top             =   450
            Width           =   615
         End
         Begin VB.CheckBox Chk_Arc3No 
            Caption         =   " NO"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   5260
            TabIndex        =   22
            Top             =   990
            Value           =   1  'Checked
            Width           =   870
         End
         Begin VB.CheckBox Chk_Arc2No 
            Caption         =   " NO"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   5260
            TabIndex        =   21
            Top             =   720
            Value           =   1  'Checked
            Width           =   870
         End
         Begin VB.CheckBox Chk_Arc1No 
            BackColor       =   &H00C0C0C0&
            Caption         =   " NO"
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
            Height          =   255
            Left            =   5260
            TabIndex        =   20
            Top             =   450
            Value           =   1  'Checked
            Width           =   870
         End
         Begin VB.Label Label2 
            BorderStyle     =   1  'Fixed Single
            Caption         =   "3º ARCHIVO DE GARANTIAS BTWGARA ................................"
            ForeColor       =   &H00800000&
            Height          =   255
            Index           =   4
            Left            =   480
            TabIndex        =   19
            Top             =   960
            Width           =   4575
         End
         Begin VB.Label Label2 
            BorderStyle     =   1  'Fixed Single
            Caption         =   "2º ARCHIVO CONTABLE TRDMOVA         ................................"
            ForeColor       =   &H00800000&
            Height          =   255
            Index           =   3
            Left            =   480
            TabIndex        =   18
            Top             =   720
            Width           =   4575
         End
         Begin VB.Label Label2 
            BorderStyle     =   1  'Fixed Single
            Caption         =   "1º ARCHIVO INVERSIONES PTWDOCU   ................................"
            ForeColor       =   &H00800000&
            Height          =   255
            Index           =   2
            Left            =   480
            TabIndex        =   17
            Top             =   480
            Width           =   4575
         End
         Begin VB.Label Label2 
            BackColor       =   &H00808000&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "4.- Interfaces"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FFFFFF&
            Height          =   255
            Index           =   1
            Left            =   120
            TabIndex        =   16
            Top             =   195
            Width           =   1335
         End
      End
      Begin VB.Frame Frame2 
         Enabled         =   0   'False
         Height          =   1575
         Left            =   120
         TabIndex        =   1
         Top             =   1200
         Width           =   7095
         Begin VB.CheckBox Chk_Dev3Si 
            Caption         =   " SI"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   6100
            TabIndex        =   11
            Top             =   1180
            Width           =   615
         End
         Begin VB.CheckBox Chk_Dev3No 
            Caption         =   " NO"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   5260
            TabIndex        =   10
            Top             =   1180
            Width           =   870
         End
         Begin VB.CheckBox Chk_Dev2Si 
            Caption         =   " SI"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   6100
            TabIndex        =   9
            Top             =   820
            Width           =   615
         End
         Begin VB.CheckBox Chk_Dev2No 
            Caption         =   " NO"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   5260
            TabIndex        =   8
            Top             =   820
            Width           =   870
         End
         Begin VB.CheckBox Chk_Dev1Si 
            Caption         =   " SI"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   6120
            TabIndex        =   7
            Top             =   465
            Width           =   615
         End
         Begin VB.CheckBox Chk_Dev1No 
            Caption         =   " NO"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   5260
            TabIndex        =   6
            Top             =   460
            Value           =   1  'Checked
            Width           =   870
         End
         Begin VB.Label LblDev3 
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   1680
            TabIndex        =   14
            Top             =   1185
            Width           =   3375
         End
         Begin VB.Label LblDev2 
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   1680
            TabIndex        =   13
            Top             =   825
            Width           =   3375
         End
         Begin VB.Label LblDev1 
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   1680
            TabIndex        =   12
            Top             =   465
            Width           =   3375
         End
         Begin VB.Label Label2 
            BorderStyle     =   1  'Fixed Single
            Caption         =   "3º Devengo :"
            ForeColor       =   &H00800000&
            Height          =   255
            Index           =   7
            Left            =   480
            TabIndex        =   5
            Top             =   1180
            Width           =   1195
         End
         Begin VB.Label Label2 
            BorderStyle     =   1  'Fixed Single
            Caption         =   "2º Devengo :"
            ForeColor       =   &H00800000&
            Height          =   255
            Index           =   6
            Left            =   480
            TabIndex        =   4
            Top             =   820
            Width           =   1195
         End
         Begin VB.Label Label2 
            BorderStyle     =   1  'Fixed Single
            Caption         =   "1º Devengo :"
            ForeColor       =   &H00800000&
            Height          =   255
            Index           =   0
            Left            =   480
            TabIndex        =   3
            Top             =   460
            Width           =   1195
         End
         Begin VB.Label Label2 
            BackColor       =   &H00808000&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "2.- Devengamientos"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FFFFFF&
            Height          =   255
            Index           =   5
            Left            =   120
            TabIndex        =   2
            Top             =   150
            Width           =   1935
         End
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Proceso de Cierre Diario"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   420
         Index           =   1
         Left            =   2040
         TabIndex        =   37
         Top             =   195
         Width           =   3255
      End
   End
End
Attribute VB_Name = "Frm_CierreDia"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim t_pcdUS As Double
Dim t_pcdUF As Double
Dim t_ptf   As Double
  




Function ErrorFinDia()
    Com_Pro.Enabled = True
    Com_Sal.Enabled = True
    Com_Sal.SetFocus
End Function

Function LimpiaFdia()

    Chk_CMNo.BackColor = &HC0C0C0
    Chk_CMNo.ForeColor = &H0&
    Chk_CMSi.BackColor = &HC0C0C0
    Chk_CMSi.ForeColor = &H0&
    Chk_CMNo.Value = 1
    Chk_CMSi.Value = 0
    Chk_Dev1No.BackColor = &HC0C0C0
    Chk_Dev1No.ForeColor = &H0&
    Chk_Dev1Si.BackColor = &HC0C0C0
    Chk_Dev1Si.ForeColor = &H0&
    Chk_Dev1No.Value = 1
    Chk_Dev1Si.Value = 0
    Chk_Dev2No.BackColor = &HC0C0C0
    Chk_Dev2No.ForeColor = &H0&
    Chk_Dev2Si.BackColor = &HC0C0C0
    Chk_Dev2Si.ForeColor = &H0&
    Chk_Dev2No.Value = 1
    Chk_Dev2Si.Value = 0
    Chk_Dev2No.Enabled = True
    Chk_Dev2Si.Enabled = True
    Chk_Dev3No.BackColor = &HC0C0C0
    Chk_Dev3No.ForeColor = &H0&
    Chk_Dev3Si.BackColor = &HC0C0C0
    Chk_Dev3Si.ForeColor = &H0&
    Chk_Dev3No.Value = 1
    Chk_Dev3Si.Value = 0
    Chk_Dev3No.Enabled = True
    Chk_Dev3Si.Enabled = True
    Chk_FsNo.BackColor = &HC0C0C0
    Chk_FsNo.ForeColor = &H0&
    Chk_FsSi.BackColor = &HC0C0C0
    Chk_FsSi.ForeColor = &H0&
    Chk_FsNo.Value = 1
    Chk_FsSi.Value = 0
    Chk_Arc1No.BackColor = &HC0C0C0
    Chk_Arc1No.ForeColor = &H0&
    Chk_Arc1Si.BackColor = &HC0C0C0
    Chk_Arc1Si.ForeColor = &H0&
    Chk_Arc1No.Value = 1
    Chk_Arc1Si.Value = 0
    Chk_Arc2No.BackColor = &HC0C0C0
    Chk_Arc2No.ForeColor = &H0&
    Chk_Arc2Si.BackColor = &HC0C0C0
    Chk_Arc2Si.ForeColor = &H0&
    Chk_Arc2No.Value = 1
    Chk_Arc2Si.Value = 0
    Chk_Arc3No.BackColor = &HC0C0C0
    Chk_Arc3No.ForeColor = &H0&
    Chk_Arc3Si.BackColor = &HC0C0C0
    Chk_Arc3Si.ForeColor = &H0&
    Chk_Arc3No.Value = 1
    Chk_Arc3Si.Value = 0
    Chk_TaNo.BackColor = &HC0C0C0
    Chk_TaNo.ForeColor = &H0&
    Chk_TaSi.BackColor = &HC0C0C0
    Chk_TaSi.ForeColor = &H0&
    Chk_TaNo.Value = 1
    Chk_TaSi.Value = 0
    Chk_FdNo.BackColor = &HC0C0C0
    Chk_FdNo.ForeColor = &H0&
    Chk_FdSi.BackColor = &HC0C0C0
    Chk_FdSi.ForeColor = &H0&
    Chk_FdNo.Value = 1
    Chk_FdSi.Value = 0
    Lbl_Info.Caption = "                                        "
    
    Lbl_Info.Refresh
    Chk_CMNo.Refresh
    Chk_CMSi.Refresh
    Chk_Dev1No.Refresh
    Chk_Dev1Si.Refresh
    Chk_Dev2No.Refresh
    Chk_Dev2Si.Refresh
    Chk_Dev3No.Refresh
    Chk_Dev3Si.Refresh
    Chk_FsNo.Refresh
    Chk_FsSi.Refresh
    Chk_Arc1No.Refresh
    Chk_Arc1Si.Refresh
    Chk_Arc2No.Refresh
    Chk_Arc2Si.Refresh
    Chk_Arc3No.Refresh
    Chk_Arc3Si.Refresh
    Chk_TaNo.Refresh
    Chk_TaSi.Refresh
    Chk_FdNo.Refresh
    Chk_FdSi.Refresh

End Function


Private Sub Com_Pro_Click()
Dim dFecproc As Date
Dim Datos()
Dim cReg As String
Dim cFechoy$, cFecprox$
Dim nSw%, nNumDev%, nDev1%
Dim cSw_Dv1$, cSw_Dv2$, cSw_Dv3$, cSw_Tm$, cSw_Fd$, cSw_Fd1$, cSw_Ptw$, cSw_Trd$, cSw_Btw$
Dim dFecha1 As Date, dFecha2 As Date
Dim nRespsh%
Dim nDias As Integer

    MousePointer = 11

    Com_Pro.Enabled = False
    Com_Sal.Enabled = False
    
    nSw% = 0
    nDev1% = 0
    nNumDev% = 2
    nRespsh% = 0
    
    Call LimpiaFdia
    
    If t_ptf = 0 Then
        MsgBox "Tasa Estimada PTF Debe ser Ingresada", 16
        Call ErrorFinDia
        MousePointer = 0
        Exit Sub
    End If
      
    If t_pcdUS = 0 Then
        MsgBox "Tasa Estimada PCD Dólar Debe ser Ingresada", 16
        Call ErrorFinDia
        MousePointer = 0
        Exit Sub
   End If

    If t_pcdUF = 0 Then
        MsgBox "Tasa Estimada PCD UF Debe ser Ingresada", 16
        Call ErrorFinDia
        MousePointer = 0
        Exit Sub
    End If
    
    Close #1, #2
    
    If Dir(gsBac_DIRIN + "BTWFPRO.TXT") <> "" Then
        Kill gsBac_DIRIN + "BTWFPRO.TXT"
    End If
    
    If Dir(gsBac_DIRIN + "BTWFPRO.CTR") <> "" Then
        Kill gsBac_DIRIN + "BTWFPRO.CTR"
    End If
    
    Open gsBac_DIRIN + "BTWFPRO.TXT" For Binary Access Write As #1
    Open gsBac_DIRIN + "BTWFPRO.CTR" For Binary Access Write As #2
       
    cReg = ""
    cReg = cReg + Format(gsBac_Fecp, "yyyymmdd")      'Fecha Anterior
    cReg = cReg + Format(gsBac_Fecp, "yyyymmdd")      'Fecha de Proceso
    cReg = cReg + Format(gsBac_Fecx, "yyyymmdd")      'Fecha Próximo Proceso
    cReg = cReg + Chr(13) + Chr(10)
              
    Put #1, , cReg
               
    cReg = ""
    cReg = cReg + "BTWFPRO   "                      'Nombre Archivo
    cReg = cReg + AlinearCampo(1, 5, 0, "N")        'Largo Registro
    cReg = cReg + AlinearCampo(24, 5, 0, "N")       'Largo del Bloque
    cReg = cReg + AlinearCampo(1, 6, 0, "N")        'Número de Registros
    cReg = cReg + Format(gsBac_Fecp, "ddmmyy")      'Fecha de Proceso
    cReg = cReg + Chr(13) + Chr(10)
              
    Put #2, , cReg
    
    Close #1, #2
        
    If SQL_Execute("SELECT finsw_dv1,finsw_dv2,finsw_dv3,finsw_tm,finsw_ptw,finsw_trd,finsw_btw,finsw_fd,acsw_fd FROM MdFin,MdAc") = 0 Then
        Do While SQL_Fetch(Datos()) = 0
            cSw_Dv1$ = Datos(1)
            cSw_Dv2$ = Datos(2)
            cSw_Dv3$ = Datos(3)
            cSw_Tm$ = Datos(4)
            cSw_Ptw$ = Datos(5)
            cSw_Trd$ = Datos(6)
            cSw_Btw$ = Datos(7)
            cSw_Fd$ = Datos(8)
            cSw_Fd1$ = Datos(9)
        Loop
    Else
        MsgBox "Sql-Server No Responde", 16, "Chequeo MDFIN"
        Call ErrorFinDia
        MousePointer = 0
        Exit Sub
    End If
        
    If cSw_Fd$ = "S" Or cSw_Fd1$ = "1" Then
        MsgBox "El Proceso de Cierre de Día fue Ejecutado", 16
        Call ErrorFinDia
        MousePointer = 0
        Exit Sub
    End If
    
    If cSw_Dv2$ = "S" Or cSw_Dv3$ = "S" Or cSw_Dv2$ = "E" Or cSw_Dv3$ = "E" Then
        If SQL_Execute("SP_SWFMESP 'RC','S'," + Str(nNumDev%)) <> 0 Then
            Lbl_Info.Caption = "Recuperación Reproceso Ha Fallado"
            MsgBox "Recuperación de Datos para Reproceso Ha Fallado", 16
            Lbl_Info.Refresh
            Call ErrorFinDia
            MousePointer = 0
            Exit Sub
        End If
    End If
    
    If Chk_CuadCart() = False Then
        Call ErrorFinDia
        MousePointer = 0
        Exit Sub
    End If
    
    If Inf_Tasas(0) Then
    End If
    
    nDias = DateDiff("d", gsBac_Fecp, gsBac_Fecx)
    Select Case nDias
        Case 1
            If Month(gsBac_Fecp) = Month(gsBac_Fecx) Then
                Chk_Dev2No.Value = 0
                Chk_Dev3No.Value = 0
                Chk_FsNo.Value = 0
                Chk_Dev2No.Enabled = False
                Chk_Dev2Si.Enabled = False
                Chk_Dev3No.Enabled = False
                Chk_Dev3Si.Enabled = False
                Chk_FsNo.Enabled = False
                Chk_FsSi.Enabled = False
            Else
                Chk_FsNo.Value = 1
            End If
        
        Case 2 And Month(gsBac_Fecp) <> Month(gsBac_Fecx)
            Chk_Dev3No.Enabled = False
            Chk_Dev3Si.Enabled = False
            Chk_Dev2No.Value = 1
            Chk_FsNo.Value = 1
            
        Case 3 And Month(gsBac_Fecp) <> Month(gsBac_Fecx)
            Chk_Dev2No.Value = 1
            Chk_Dev3No.Value = 1
            Chk_FsNo.Value = 1
        
        Case nDias <= 0
            MsgBox "ERROR: en Ingreso de Fechas", 16
            Call ErrorFinDia
            Exit Sub
        
        Case nDias > 4 And Month(gsBac_Fecp) <> Month(gsBac_Fecx)
            MsgBox "ERROR: en Ingreso de Fechas", 16
            Call ErrorFinDia
            MousePointer = 0
            Exit Sub
            
        Case Else
         '   MsgBox "ERROR: en Ingreso de Fechas", 16
         '   Exit Sub
        
    End Select
        
    Lbl_Info.Caption = "Cargando Monedas desde BAE         "
    Chk_CMNo.BackColor = &H808000
    Chk_CMSi.BackColor = &H808000
    
    Lbl_Info.Refresh
    Chk_CMNo.Refresh
    Chk_CMSi.Refresh
    
    If Car_Monedas() = True Then
        
        Chk_CMNo.Value = 0
        Chk_CMSi.Value = 1
            
        Chk_CMNo.BackColor = &HC0C0C0
        Chk_CMSi.BackColor = &HC0C0C0
        Chk_CMNo.Refresh
        Chk_CMSi.Refresh

        If DateDiff("d", gsBac_Fecp, gsBac_Fecx) > 1 And Month(gsBac_Fecp) <> Month(gsBac_Fecx) Then
    
'********************************************************************************************'
'***************                                                               **************'
'***************            D E V E N G A M I E N T O   E S P E C I A L        **************'
'***************                                                               **************'
'********************************************************************************************'

'           Repetir Dólar Fin de Mes
'            If SQL_Execute("SP_SWFMESP 'MN','S'," + Str(nNumDev%)) <> 0 Then
'                MsgBox "Repetición de Dólar para días no hábiles Ha Fallado" + Chr(10) + "Repita Dólar Observado por Mantenedor de Monedas", 16
'                Exit Sub
'            End If
                    
            dFecproc = gsBac_Fecp
            Chk_Dev1No.BackColor = &H808000
            Chk_Dev1Si.BackColor = &H808000
            Chk_Dev1No.Refresh
            Chk_Dev1Si.Refresh
        
            dFecha2 = CDate("01/" + Str(Month(gsBac_Fecx)) + "/" + Str(Year(gsBac_Fecx)))
            dFecha1 = DateAdd("d", -1, dFecha2)
            cFechoy$ = Trim(Str(Month(dFecproc))) + "/" + Trim(Str(Day(dFecproc))) + "/" + Trim(Str(Year(dFecproc)))
            
            If SQL_Execute("SP_RESPALDO '" + cFechoy$ + "','DEV'") <> 0 Then
                nSw% = 1
                Lbl_Info.Caption = "Respaldo Antes de Devengo Ha Fallado "
                Lbl_Info.Refresh
            End If
            
            If dFecha1 <> dFecproc And nSw% = 0 Then
'********************************************************************************************'
'*************** Devengo último día del mes dFecha1                            **************'
'***************                    D E V E N G O   Nº 1                       **************'
'***************                                                               **************'
'********************************************************************************************'
                nDev1% = 1
                nNumDev% = 3
                LblDev1.Caption = " del " + Format(dFecproc, "dd/mm/yyyy") + " al " + Format(dFecha1, "dd/mm/yyyy") + "          "
                Lbl_Info.Caption = " del " + Format(dFecproc, "dd/mm/yyyy") + " al " + Format(dFecha1, "dd/mm/yyyy") + "          "
                LblDev1.Refresh
                Lbl_Info.Refresh

                cFecprox$ = Trim(Str(Month(dFecha1))) + "/" + Trim(Str(Day(dFecha1))) + "/" + Trim(Str(Year(dFecha1)))
                
                If SQL_Execute("SP_DEVENGO '" + cFechoy$ + "','" + cFecprox$ + "'," + BacFormatoSQL(t_pcdUS) + "," + BacFormatoSQL(t_pcdUF) + "," + BacFormatoSQL(t_ptf)) = 0 Then

                    Do While SQL_Fetch(Datos()) = 0
                        If UBound(Datos()) = 2 Then
                            If Datos(1) <> "SI" Then
                                nSw% = 1
                                MsgBox CStr(Datos(2)), 64
                            End If
                        End If
                    Loop

                    If nSw% = 1 Then
                        Lbl_Info.Caption = "El Devengo ha Fallado               "
                        Chk_Dev1No.Value = 2
                        Chk_Dev1Si.Value = 2
                        Chk_Dev1No.BackColor = &HFF&
                        Chk_Dev1Si.BackColor = &HFF&
                        Lbl_Info.Refresh
                        Chk_Dev1No.Refresh
                        Chk_Dev1Si.Refresh
                        If SQL_Execute("SP_SWFMESP 'D1','E'," + Str(nNumDev%)) <> 0 Then
                            nSw% = 1
                            Lbl_Info.Caption = "Actual-SW DEV Nº1 Ha Fallado        "
                            Lbl_Info.Refresh
                        End If
                    Else
                        Chk_Dev1No.Value = 0
                        Chk_Dev1Si.Value = 1
                        Chk_Dev1No.BackColor = &HC0C0C0
                        Chk_Dev1Si.BackColor = &HC0C0C0
                        Chk_Dev1No.Refresh
                        Chk_Dev1Si.Refresh
                                                
                        If SQL_Execute("SP_SWFMESP 'D1','S'," + Str(nNumDev%)) <> 0 Then
                            nSw% = 1
                            Lbl_Info.Caption = "Actual-SW DEV Nº1 Ha Fallado        "
                            Lbl_Info.Refresh
                        End If
                    End If
                Else
                    Lbl_Info.Caption = "El Devengo ha Fallado              "
                    Chk_Dev1No.Value = 2
                    Chk_Dev1Si.Value = 2
                    Chk_Dev1No.BackColor = &HFF&
                    Chk_Dev1Si.BackColor = &HFF&
                    Lbl_Info.Refresh
                    Chk_Dev1No.Refresh
                    Chk_Dev1Si.Refresh
                    nSw% = 1
                    
                    If SQL_Execute("SP_SWFMESP 'D1','E'," + Str(nNumDev%)) <> 0 Then
                        nSw% = 1
                        Lbl_Info.Caption = "Actual-SW ERROR-DEV Nº1 Ha Fallado  "
                        Lbl_Info.Refresh
                    End If
                End If
            End If
            
            If nSw = 0 Then
            
                Lbl_Info.Caption = "Respaldo de Cartera Histórica   "
                If SQL_Execute("SP_VALHIST_RESPCART") <> 0 Then
                    Lbl_Info.Caption = "Respaldo Cartera Histórica ha Fallado"
                    Lbl_Info.Refresh
                End If
                
            End If
                        
            If nSw% = 0 Then
'********************************************************************************************'
'*************** Devengo del último día del mes al día 1 del próximo mes       **************'
'***************                    D E V E N G O   Nº 2                       **************'
'***************                                                               **************'
'********************************************************************************************'
            
                If nDev1% = 1 Then
                    Chk_Dev2No.BackColor = &H808000
                    Chk_Dev2Si.BackColor = &H808000
                    Chk_Dev2No.Refresh
                    Chk_Dev2Si.Refresh
                    dFecproc = dFecha1
                End If
                
                If nDev1% = 1 Then
                     If SQL_Execute("SP_SWFMESP 'B2','S'," + Str(nNumDev%)) <> 0 Then
                        nSw% = 1
                        Lbl_Info.Caption = "ERROR: MDFM de Respaldo"
                        Lbl_Info.Refresh
                    End If
                End If

                If nDev1% = 0 Then
                    LblDev1.Caption = " del " + Format(dFecproc, "dd/mm/yyyy") + " al " + Format(dFecha2, "dd/mm/yyyy") + "          "
                    Lbl_Info.Caption = " del " + Format(dFecproc, "dd/mm/yyyy") + " al " + Format(dFecha2, "dd/mm/yyyy") + "          "
                    LblDev1.Refresh
                    Lbl_Info.Refresh
                Else
                    LblDev2.Caption = " del " + Format(dFecproc, "dd/mm/yyyy") + " al " + Format(dFecha2, "dd/mm/yyyy") + "          "
                    Lbl_Info.Caption = " del " + Format(dFecproc, "dd/mm/yyyy") + " al " + Format(dFecha2, "dd/mm/yyyy") + "          "
                    LblDev2.Refresh
                    Lbl_Info.Refresh
                End If
                
                cFechoy$ = Trim(Str(Month(dFecproc))) + "/" + Trim(Str(Day(dFecproc))) + "/" + Trim(Str(Year(dFecproc)))
                cFecprox$ = Trim(Str(Month(dFecha2))) + "/" + Trim(Str(Day(dFecha2))) + "/" + Trim(Str(Year(dFecha2)))
            
                If nDev1% = 1 Then
                    If SQL_Execute("SP_RESPALDO '" + cFechoy$ + "','DEV'") <> 0 Then
                        nSw% = 1
                        Lbl_Info.Caption = "Respaldo Antes de Devengo Ha Fallado"
                        Lbl_Info.Refresh
                    End If
                End If
                
                If nSw = 0 Then
                    If SQL_Execute("SP_DEVENGO '" + cFechoy$ + "','" + cFecprox$ + "'," + BacFormatoSQL(t_pcdUS) + "," + BacFormatoSQL(t_pcdUF) + "," + BacFormatoSQL(t_ptf)) = 0 Then
                        Do While SQL_Fetch(Datos()) = 0
                            If UBound(Datos()) = 2 Then
                                If Datos(1) <> "SI" Then
                                    nSw% = 1
                                    MsgBox CStr(Datos(2)), 64
                                End If
                            End If
                        Loop
                
                        If nSw% = 1 Then
                            Lbl_Info.Caption = "El Devengo ha Fallado               "
                            Lbl_Info.Refresh
                            If nDev1% = 0 Then
                                Chk_Dev1No.Value = 2
                                Chk_Dev1Si.Value = 2
                                If SQL_Execute("SP_SWFMESP 'D2','E'," + Str(nNumDev%)) <> 0 Then
                                    nSw% = 1
                                    Lbl_Info.Caption = "Actual-SW DEV Nº1 Ha Fallado        "
                                    Lbl_Info.Refresh
                                End If
                            Else
                                Chk_Dev2No.Value = 2
                                Chk_Dev2Si.Value = 2
                                If SQL_Execute("SP_SWFMESP 'D2','E'," + Str(nNumDev%)) <> 0 Then
                                    nSw% = 1
                                    Lbl_Info.Caption = "Actual-SW DEV Nº2 Ha Fallado        "
                                    Lbl_Info.Refresh
                                End If
                            End If
                        Else
                            If nDev1% = 0 Then
                                Chk_Dev1No.Value = 0
                                Chk_Dev1Si.Value = 1
                                Chk_Dev1No.BackColor = &HC0C0C0
                                Chk_Dev1Si.BackColor = &HC0C0C0
                                Chk_Dev1No.Refresh
                                Chk_Dev1Si.Refresh
                            Else
                                Chk_Dev2No.Value = 0
                                Chk_Dev2Si.Value = 1
                                Chk_Dev2No.BackColor = &HC0C0C0
                                Chk_Dev2Si.BackColor = &HC0C0C0
                                Chk_Dev2No.Refresh
                                Chk_Dev2Si.Refresh
                            End If
                        
                            If SQL_Execute("SP_SWFMESP 'D2','S'," + Str(nNumDev%)) <> 0 Then
                                nSw% = 1
                                Lbl_Info.Caption = "Actual-SW DEV Nº2 Ha Fallado        "
                                Lbl_Info.Refresh
                            End If
                        End If
                    Else
                        If nSw% = 0 Then
                            Lbl_Info.Caption = "El Devengo ha Fallado               "
                            Lbl_Info.Refresh
                            If nDev1% = 0 Then
                                Chk_Dev1No.Value = 2
                                Chk_Dev1Si.Value = 2
                                Chk_Dev1No.BackColor = &HFF&
                                Chk_Dev1Si.BackColor = &HFF&
                                Chk_Dev1No.Refresh
                                Chk_Dev1Si.Refresh
                            
                                If SQL_Execute("SP_SWFMESP 'D2','E'," + Str(nNumDev%)) <> 0 Then
                                    nSw% = 1
                                    Lbl_Info.Caption = "Actual-SW DEV Nº1 Ha Fallado        "
                                    Lbl_Info.Refresh
                                End If
                            Else
                                Chk_Dev2No.Value = 2
                                Chk_Dev2Si.Value = 2
                                Chk_Dev2No.BackColor = &HFF&
                                Chk_Dev2Si.BackColor = &HFF&
                                Chk_Dev2No.Refresh
                                Chk_Dev2Si.Refresh
                            
                                If SQL_Execute("SP_SWFMESP 'D2','E'," + Str(nNumDev%)) <> 0 Then
                                    nSw% = 1
                                    Lbl_Info.Caption = "Actual-SW DEV Nº2 Ha Fallado        "
                                    Lbl_Info.Refresh
                                End If
                            End If
                            nSw% = 1
                        End If
                    End If
                End If
            End If
            
            If nSw = 0 Then
                If Chk_CuadCart() = False Then
                End If
            End If
            
            If nSw% = 0 Then '*** Generación PTWDOCU ***
            
                Lbl_Info.Caption = "Generando Archivo PTWDOCU           "
                Chk_Arc1No.BackColor = &H808000
                Chk_Arc1Si.BackColor = &H808000
                Lbl_Info.Refresh
                Chk_Arc1No.Refresh
                Chk_Arc1Si.Refresh
            
                If PtwDocu(0) = True Then
                
                    Chk_Arc1No.Value = 0
                    Chk_Arc1Si.Value = 1
                        
                    Chk_Arc1No.BackColor = &HC0C0C0
                    Chk_Arc1No.ForeColor = &H0&
                    Chk_Arc1Si.BackColor = &HC0C0C0
                    Chk_Arc1Si.ForeColor = &H0&
                    Chk_Arc1No.Refresh
                    Chk_Arc1Si.Refresh
                                        
                    If SQL_Execute("SP_SWFMESP 'PT','S'," + Str(nNumDev%)) <> 0 Then
                        nSw% = 1
                        Lbl_Info.Caption = "Actual-SW PT Ha Fallado             "
                        Lbl_Info.Refresh
                    End If
                    
                Else
                    Lbl_Info.Caption = "Generación PTWDOCU ha Fallado    "
                    Chk_Arc1No.Value = 2
                    Chk_Arc1Si.Value = 2
                    Chk_Arc1No.BackColor = &HFF&
                    Chk_Arc1Si.BackColor = &HFF&
                    Lbl_Info.Refresh
                    Chk_Arc1No.Refresh
                    Chk_Arc1Si.Refresh
                    nSw% = 1
                    If SQL_Execute("SP_SWFMESP 'PT','E'," + Str(nNumDev%)) <> 0 Then
                        Lbl_Info.Caption = "Actual-SW PT Ha Fallado             "
                        Lbl_Info.Refresh
                    End If
                End If
            End If
                                                                                                    
            If nSw% = 0 Then '*** Valorización Tasa de Mercado
            
                Lbl_Info.Caption = "Valorización a Factores SBIF"
                Chk_FsNo.Value = 1
                Chk_FsSi.Value = 0
                Chk_FsNo.Enabled = True
                Chk_FsSi.Enabled = True
                Chk_FsNo.BackColor = &H808000
                Chk_FsSi.BackColor = &H808000
                Chk_FsNo.Refresh
                Chk_FsSi.Refresh
                Lbl_Info.Refresh

                If SQL_Execute("SP_SBIF_VALORIZA '" + cFechoy$ + "'") <> 0 Then
                    nSw% = 1
                    Lbl_Info.Caption = "Valorizacion SBIF Ha Fallado        "
                    Lbl_Info.Refresh
                End If
                
            End If
            
            If nSw% = 0 Then '*** Contabilización Tasa de Mercado ***
            
                Lbl_Info.Caption = "Generando Contabilidad Factores SBIF"
                Lbl_Info.Refresh
                
                If SQL_Execute("SP_CONTTM '" + gsBac_User + "','" + gsBac_Term + "'") <> 0 Then
                    nSw% = 1
                    Lbl_Info.Caption = "Contabilidad SBIF Ha Fallado        "
                    Lbl_Info.Refresh
                    Chk_FsNo.Value = 2
                    Chk_FsSi.Value = 2
                    If SQL_Execute("SP_SWFMESP 'TM','E'," + Str(nNumDev%)) <> 0 Then
                        Lbl_Info.Caption = "Actual-SW Reproceso TM Ha Fallado   "
                        Lbl_Info.Refresh
                    End If
                Else
                    If LlenarValoriza Then
                    End If
                    
                    If P17(1) Then
                    End If
                                        
                    Chk_FsNo.Value = 0
                    Chk_FsSi.Value = 1
                    Chk_FsNo.BackColor = &HC0C0C0
                    Chk_FsSi.BackColor = &HC0C0C0
                    Chk_FsNo.Refresh
                    Chk_FsSi.Refresh
                    
                    If SQL_Execute("SP_SWFMESP 'TM','S'," + Str(nNumDev%)) <> 0 Then
                        nSw% = 1
                        Lbl_Info.Caption = "Actual-SW Reproceso TM Ha Fallado   "
                        Lbl_Info.Refresh
                    End If
                    
                End If
                        
            End If
                                                                                                
            If nSw% = 0 Then '*** Generación TRDMOVA ***
            
                Chk_Arc2No.BackColor = &H808000
                Chk_Arc2Si.BackColor = &H808000
                Lbl_Info.Caption = "Generando Archivo TRDMOVA       "
                Chk_Arc2No.Refresh
                Chk_Arc2Si.Refresh
                Lbl_Info.Refresh
                        
                If TrdMova(0) = True Then
                
                    Chk_Arc2No.Value = 0
                    Chk_Arc2Si.Value = 1
                            
                    Chk_Arc2No.BackColor = &HC0C0C0
                    Chk_Arc2Si.BackColor = &HC0C0C0
                    Chk_Arc3No.BackColor = &H808000
                    Chk_Arc3Si.BackColor = &H808000
                            
                    Chk_Arc2No.Refresh
                    Chk_Arc2Si.Refresh
                    Chk_Arc3No.Refresh
                    Chk_Arc3Si.Refresh
                    
                    If SQL_Execute("SP_SWFMESP 'TR','S'," + Str(nNumDev%)) <> 0 Then
                        nSw% = 1
                        Lbl_Info.Caption = "Actual-SW TR Ha Fallado             "
                        Lbl_Info.Refresh
                    End If
                    Lbl_Info.Caption = "Generando Archivo BTWGARA           "
                    Lbl_Info.Refresh
                Else
                    Lbl_Info.Caption = "Generación TRDMOVA ha Fallado       "
                    Chk_Arc2No.Value = 2
                    Chk_Arc2Si.Value = 2
                    Chk_Arc2No.BackColor = &HFF&
                    Chk_Arc2Si.BackColor = &HFF&
                    Lbl_Info.Refresh
                    Chk_Arc2No.Refresh
                    Chk_Arc2Si.Refresh
                    nSw% = 1
                    If SQL_Execute("SP_SWFMESP 'TR','E'," + Str(nNumDev%)) <> 0 Then
                        Lbl_Info.Caption = "Actual-SW TR Ha Fallado             "
                        Lbl_Info.Refresh
                    End If
                    
                End If
            
            End If
            
            If nSw% = 0 Then '*** Generación BTWGARA ***
            
                If BtwGara(0) = True Then
                            
                    Chk_Arc3No.Value = 0
                    Chk_Arc3Si.Value = 1
                                
                    Chk_Arc3No.BackColor = &HC0C0C0
                    Chk_Arc3Si.BackColor = &HC0C0C0
                    Chk_TaNo.BackColor = &H808000
                    Chk_TaSi.BackColor = &H808000
                                
                    Chk_Arc3No.Refresh
                    Chk_Arc3Si.Refresh
                    Chk_TaNo.Refresh
                    Chk_TaSi.Refresh
                    
                    If SQL_Execute("SP_SWFMESP 'BT','S'," + Str(nNumDev%)) <> 0 Then
                        nSw% = 1
                        Lbl_Info.Caption = "Actual-SW BT Ha Fallado             "
                        Lbl_Info.Refresh
                    End If
                    Lbl_Info.Caption = "Proceso de Cierre a Sistema AS400   "
                    Lbl_Info.Refresh
                Else
                    Lbl_Info.Caption = "Generación BTWGARA ha Fallado       "
                    Chk_Arc3No.Value = 2
                    Chk_Arc3Si.Value = 2
                    Chk_Arc3No.BackColor = &HFF&
                    Chk_Arc3Si.BackColor = &HFF&
                    Lbl_Info.Refresh
                    Chk_Arc3No.Refresh
                    Chk_Arc3Si.Refresh
                    nSw% = 1
                    If SQL_Execute("SP_SWFMESP 'BT','E'," + Str(nNumDev%)) <> 0 Then
                        Lbl_Info.Caption = "Actual-SW BT Ha Fallado             "
                        Lbl_Info.Refresh
                    End If
                End If
            End If
                        
            If nSw% = 0 Then 'Ok a Sistema AS400
                               
                Call Agrupa_Ctr
                
                nRespsh% = Shell(gsBac_DIRIN + "CIERREAS.PIF", 0)
                
                Chk_TaNo.Value = 0
                Chk_TaSi.Value = 1
                Chk_TaNo.BackColor = &HC0C0C0
                Chk_TaSi.BackColor = &HC0C0C0
                                                        
                Chk_TaNo.Refresh
                Chk_TaSi.Refresh
                
                dFecproc = dFecha2
                                    
                If nDev1% = 1 Then
                    If dFecproc < gsBac_Fecx Then
                        Chk_Dev3No.BackColor = &H808000
                        Chk_Dev3Si.BackColor = &H808000
                        Chk_Dev3No.Value = 1
                        Chk_Dev3Si.Value = 0
                        Chk_Dev3No.Refresh
                        Chk_Dev3Si.Refresh
                    End If
                Else
                    If dFecproc < gsBac_Fecx Then
                        Chk_Dev2No.BackColor = &H808000
                        Chk_Dev2Si.BackColor = &H808000
                        Chk_Dev2No.Value = 1
                        Chk_Dev2Si.Value = 0
                        Chk_Dev2No.Refresh
                        Chk_Dev2Si.Refresh
                    End If
                End If

            End If
            
            If nSw% = 0 And (dFecproc < gsBac_Fecx) Then
            
'********************************************************************************************'
'*************** Devengo hasta el Próximo Día Hábil                            **************'
'***************                    D E V E N G O   Nº 2 ó 3                   **************'
'***************                                                               **************'
'********************************************************************************************'
                        
                If SQL_Execute("SP_SWFMESP 'B3','S'," + Str(nNumDev%)) <> 0 Then
                    nSw% = 1
                    Lbl_Info.Caption = "ERROR: MDFM de Respaldo"
                    Lbl_Info.Refresh
                End If
                
                If nDev1% = 0 Then
                    LblDev2.Caption = " del " + Format(dFecproc, "dd/mm/yyyy") + " al " + Format(gsBac_Fecx, "dd/mm/yyyy") + "          "
                    Lbl_Info.Caption = " del " + Format(dFecproc, "dd/mm/yyyy") + " al " + Format(gsBac_Fecx, "dd/mm/yyyy") + "          "
                    LblDev2.Refresh
                    Lbl_Info.Refresh
                Else
                    LblDev3.Caption = " del " + Format(dFecproc, "dd/mm/yyyy") + " al " + Format(gsBac_Fecx, "dd/mm/yyyy") + "          "
                    Lbl_Info.Caption = " del " + Format(dFecproc, "dd/mm/yyyy") + " al " + Format(gsBac_Fecx, "dd/mm/yyyy") + "          "
                    LblDev2.Refresh
                    Lbl_Info.Refresh
                End If
                
                cFechoy$ = Trim(Str(Month(dFecproc))) + "/" + Trim(Str(Day(dFecproc))) + "/" + Trim(Str(Year(dFecproc)))
                cFecprox$ = Trim(Str(Month(gsBac_Fecx))) + "/" + Trim(Str(Day(gsBac_Fecx))) + "/" + Trim(Str(Year(gsBac_Fecx)))
                
                If SQL_Execute("SP_RESPALDO '" + cFechoy$ + "','DEV'") <> 0 Then
                    nSw% = 1
                    Lbl_Info.Caption = "Respaldo Antes de Ultimo Devengo Ha Fallado"
                    Lbl_Info.Refresh
                    Call ErrorFinDia
                    MousePointer = 0
                    Exit Sub
                End If
                              
                If nSw = 0 Then
                    If SQL_Execute("SP_DEVENGO '" + cFechoy$ + "','" + cFecprox$ + "'," + BacFormatoSQL(t_pcdUS) + "," + BacFormatoSQL(t_pcdUF) + "," + BacFormatoSQL(t_ptf)) = 0 Then
  
                        Do While SQL_Fetch(Datos()) = 0
                            If UBound(Datos()) = 2 Then
                                If Datos(1) <> "SI" Then
                                    nSw% = 1
                                    MsgBox CStr(Datos(2)), 64
                                End If
                            End If
                        Loop
                
                        If nSw% = 1 Then
                            Lbl_Info.Caption = "El Devengo ha Fallado               "
                            Lbl_Info.Refresh
                            If nDev1% = 0 Then
                                Chk_Dev2No.Value = 2
                                Chk_Dev2Si.Value = 2
                            Else
                                Chk_Dev3No.Value = 2
                                Chk_Dev3Si.Value = 2
                            End If
                        
                            If SQL_Execute("SP_SWFMESP 'D3','E'," + Str(nNumDev%)) <> 0 Then
                                nSw% = 1
                                Lbl_Info.Caption = "Actual-SW D3 Ha Fallado          "
                                Lbl_Info.Refresh
                            End If
                        Else
                            If nDev1% = 0 Then
                                Chk_Dev2No.Value = 0
                                Chk_Dev2Si.Value = 1
                                Chk_Dev2No.BackColor = &HC0C0C0
                                Chk_Dev2Si.BackColor = &HC0C0C0
                                Chk_Dev2No.Refresh
                                Chk_Dev2Si.Refresh
                            Else
                                Chk_Dev3No.Value = 0
                                Chk_Dev3Si.Value = 1
                                Chk_Dev3No.BackColor = &HC0C0C0
                                Chk_Dev3Si.BackColor = &HC0C0C0
                                Chk_Dev3No.Refresh
                                Chk_Dev3Si.Refresh
                            End If
                        
                            Chk_FdNo.BackColor = &H808000
                            Chk_FdSi.BackColor = &H808000
                            Chk_FdNo.Refresh
                            Chk_FdSi.Refresh
                    
                            If SQL_Execute("SP_SWFMESP 'D3','S'," + Str(nNumDev%)) <> 0 Then
                                nSw% = 1
                                Lbl_Info.Caption = "Actual-SW FD Ha Fallado         "
                                Lbl_Info.Refresh
                            End If
                                               
                            Lbl_Info.Caption = "Fin de Día                      "
                            Lbl_Info.Refresh
                        
                        End If
                    Else
                        If nSw% = 0 Then
                            Lbl_Info.Caption = "El Devengo ha Fallado           "
                            Lbl_Info.Refresh
                            If nDev1% = 0 Then
                                Chk_Dev2No.Value = 2
                                Chk_Dev2Si.Value = 2
                                Chk_Dev2No.BackColor = &HFF&
                                Chk_Dev2Si.BackColor = &HFF&
                                Chk_Dev2No.Refresh
                                Chk_Dev2Si.Refresh
                            Else
                                Chk_Dev3No.Value = 2
                                Chk_Dev3Si.Value = 2
                                Chk_Dev3No.BackColor = &HFF&
                                Chk_Dev3Si.BackColor = &HFF&
                                Chk_Dev3No.Refresh
                                Chk_Dev3Si.Refresh
                            
                                If SQL_Execute("SP_SWFMESP 'D3','E'," + Str(nNumDev%)) <> 0 Then
                                    nSw% = 1
                                    Lbl_Info.Caption = "Actual-SW D3 Ha Fallado           "
                                    Lbl_Info.Refresh
                                End If
                            End If
                            nSw% = 1
                        End If
                    End If
                End If
            Else
                If nSw% = 0 Then
                    If SQL_Execute("UPDATE MDAC SET ACSW_FINMES='0'") <> 0 Then
                        nSw% = 1
                        Lbl_Info.Caption = "ERROR: MODIFICACION SW_FINMES"
                        Lbl_Info.Refresh
                    End If
                End If
            End If
            
            If nSw = 0 Then
                If Chk_CuadCart() = False Then
                End If
            End If
                
            If nSw% = 0 Then
                If SQL_Execute("SP_RESPALDO '" + cFechoy$ + "','FIN'") <> 0 Then
                    nSw% = 1
                    Lbl_Info.Caption = "Respaldos Fin de Día Ha Fallado     "
                    Lbl_Info.Refresh
                End If
            End If
                
            If nSw = 0 Then 'Fin de Día
            
                Chk_FdNo.BackColor = &H808000
                Chk_FdSi.BackColor = &H808000
                Chk_FdNo.Refresh
                Chk_FdSi.Refresh
                
                Lbl_Info.Caption = "Respaldo Información Rentabilidad      "
                If SQL_Execute("SP_GENDATOSRENTAB") <> 0 Then
                    Lbl_Info.Caption = "Respaldo Rentabilidad ha Fallado"
                    Lbl_Info.Refresh
                End If
                                    
                If SQL_Execute("SP_FDIA") = 0 Then
                    Chk_FdNo.Value = 0
                    Chk_FdSi.Value = 1
                    Chk_FdNo.BackColor = &HC0C0C0
                    Chk_FdSi.BackColor = &HC0C0C0
                    Chk_FdNo.Refresh
                    Chk_FdSi.Refresh
                    
                    If SQL_Execute("SP_SWFMESP 'FD','S'," + Str(nNumDev%)) <> 0 Then
                        nSw% = 1
                        Lbl_Info.Caption = "Actualización FD Ha Fallado         "
                        Lbl_Info.Refresh
                    End If
                    
                    If SQL_Execute("SP_ACTMDDI") <> 0 Then
                                                                        
                    End If
                                                                       
                 Else
                    If nSw% = 0 Then
                        Lbl_Info.Caption = "Fin de Día Ha Fallado               "
                        Chk_FdNo.Value = 2
                        Chk_FdSi.Value = 2
                        Chk_FdNo.BackColor = &HFF&
                        Chk_FdSi.BackColor = &HFF&
                        Lbl_Info.Refresh
                        Chk_FdNo.Refresh
                        Chk_FdSi.Refresh
                        
                        If SQL_Execute("SP_SWFMESP 'FD','E'," + Str(nNumDev%)) <> 0 Then
                            nSw% = 1
                            Lbl_Info.Caption = "Actual-SW FD Ha Fallado       "
                            Lbl_Info.Refresh
                        End If
                        
                    End If
                End If
                
            End If

        Else
    
'********************************************************************************************'
'***************                                                               **************'
'***************           D E V E N G A M I E N T O   N O R M A L             **************'
'***************                                                               **************'
'********************************************************************************************'

            Lbl_Info.Caption = "Respaldo de Cartera Histórica          "

            If SQL_Execute("SP_VALHIST_RESPCART") <> 0 Then
                Lbl_Info.Caption = "Respaldo Cartera Histórica ha Fallado"
                Lbl_Info.Refresh
            End If
                        
            Chk_Dev1No.BackColor = &H808000
            Chk_Dev1Si.BackColor = &H808000
            Chk_Dev1No.Refresh
            Chk_Dev1Si.Refresh
                                   
            LblDev1.Caption = " del " + Format(gsBac_Fecp, "dd/mm/yyyy") + " al " + Format(gsBac_Fecx, "dd/mm/yyyy") + "          "
            Lbl_Info.Caption = " del " + Format(gsBac_Fecp, "dd/mm/yyyy") + " al " + Format(gsBac_Fecx, "dd/mm/yyyy") + "          "
            LblDev1.Refresh
            Lbl_Info.Refresh
            
            cFechoy$ = Trim(Str(Month(gsBac_Fecp))) + "/" + Trim(Str(Day(gsBac_Fecp))) + "/" + Trim(Str(Year(gsBac_Fecp)))
            cFecprox$ = Trim(Str(Month(gsBac_Fecx))) + "/" + Trim(Str(Day(gsBac_Fecx))) + "/" + Trim(Str(Year(gsBac_Fecx)))
            
            If SQL_Execute("SP_RESPALDO '" + cFechoy$ + "','DEV'") <> 0 Then
                nSw% = 1
                Lbl_Info.Caption = "Respaldo Antes de Devengo Ha Fallado"
                Lbl_Info.Refresh
            End If

            If nSw% = 1 Then
                Call ErrorFinDia
                MousePointer = 0
                Exit Sub
            End If
                
            If SQL_Execute("SP_DEVENGO '" + cFechoy$ + "','" + cFecprox$ + "'," + BacFormatoSQL(t_pcdUS) + "," + BacFormatoSQL(t_pcdUF) + "," + BacFormatoSQL(t_ptf)) = 0 Then
                Do While SQL_Fetch(Datos()) = 0
                    If UBound(Datos()) = 2 Then
                        If Datos(1) <> "SI" Then
                            nSw% = 1
                            MsgBox CStr(Datos(2)), 64
                        End If
                    End If
                Loop
                
                If nSw% = 1 Then
                    Lbl_Info.Caption = "El Devengo ha Fallado               "
                    Lbl_Info.Refresh
                    Chk_Dev1No.Value = 2
                    Chk_Dev1Si.Value = 2
                Else
                    Chk_Dev1No.Value = 0
                    Chk_Dev1Si.Value = 1
                    
                    If Chk_CuadCart() = False Then
'
                    End If
                    
                    Lbl_Info.Caption = "Generando Archivo PTWDOCU           "
                    Chk_Dev1No.BackColor = &HC0C0C0
                    Chk_Dev1Si.BackColor = &HC0C0C0
                    Chk_Arc1No.BackColor = &H808000
                    Chk_Arc1Si.BackColor = &H808000
                    Lbl_Info.Refresh
                    Chk_Dev1No.Refresh
                    Chk_Dev1Si.Refresh
                    Chk_Arc1No.Refresh
                    Chk_Arc1Si.Refresh
                    
                    If PtwDocu(0) = True Then
                    
                        Chk_Arc1No.Value = 0
                        Chk_Arc1Si.Value = 1
                        Chk_Arc1No.BackColor = &HC0C0C0
                        Chk_Arc1No.ForeColor = &H0&
                        Chk_Arc1Si.BackColor = &HC0C0C0
                        Chk_Arc1Si.ForeColor = &H0&
                        Chk_Arc1No.Refresh
                        Chk_Arc1Si.Refresh
            
                        If Month(gsBac_Fecp) <> Month(gsBac_Fecx) Then
                    
                            '*** Valorización Tasa de Mercado
            
                            Lbl_Info.Caption = "Valorización a Factores SBIF"
                            Lbl_Info.Refresh
                            Chk_FsNo.Value = 1
                            Chk_FsSi.Value = 0
                            Chk_FsNo.Enabled = True
                            Chk_FsSi.Enabled = True
                            Chk_Dev1No.BackColor = &HC0C0C0
                            Chk_Dev1Si.BackColor = &HC0C0C0
                            Chk_FsNo.BackColor = &H808000
                            Chk_FsSi.BackColor = &H808000
                            Chk_Dev1No.Refresh
                            Chk_Dev1Si.Refresh
                            Chk_FsNo.Refresh
                            Chk_FsSi.Refresh
    
                            If SQL_Execute("SP_SBIF_VALORIZA '" + cFechoy$ + "'") <> 0 Then
                                nSw% = 1
                                Lbl_Info.Caption = "Valorizacion SBIF Ha Fallado        "
                                Lbl_Info.Refresh
                            Else
                                Lbl_Info.Caption = "Generando Contabilidad Factores SBIF"
                                Lbl_Info.Refresh
                        
                                If SQL_Execute("SP_CONTTM '" + gsBac_User + "','" + gsBac_Term + "'") <> 0 Then
                                    nSw% = 1
                                    Lbl_Info.Caption = "Contabilidad SBIF Ha Fallado       "
                                    Lbl_Info.Refresh
                                    Chk_FsNo.Value = 2
                                    Chk_FsSi.Value = 2
                                Else
                                    Lbl_Info.Caption = "Generando Informe de Valorización SBIF"
                                    Lbl_Info.Refresh

                                    If LlenarValoriza Then
                                    End If
                    
                                    Lbl_Info.Caption = "Generando Informe P17"
                                    Lbl_Info.Refresh
                    
                                    If P17(1) Then
                                    End If
                        
                                    Chk_FsNo.Value = 0
                                    Chk_FsSi.Value = 1
                                    Chk_FsNo.BackColor = &HC0C0C0
                                    Chk_FsSi.BackColor = &HC0C0C0
                                    Chk_FsNo.Refresh
                                    Chk_FsSi.Refresh
                                End If
                                
                            End If
                        
                        End If
            
                        If nSw = 0 Then
                            Chk_Arc2No.BackColor = &H808000
                            Chk_Arc2Si.BackColor = &H808000
                            Lbl_Info.Caption = "Generando Archivo TRDMOVA           "
                            Lbl_Info.Refresh
                            Chk_Arc2No.Refresh
                            Chk_Arc2Si.Refresh
                        End If
                        
                        If TrdMova(0) = True Then
                        
                            Chk_Arc2No.Value = 0
                            Chk_Arc2Si.Value = 1
                            Chk_Arc2No.BackColor = &HC0C0C0
                            Chk_Arc2Si.BackColor = &HC0C0C0
                            Chk_Arc3No.BackColor = &H808000
                            Chk_Arc3Si.BackColor = &H808000
                            Lbl_Info.Caption = "Generando Archivo BTWGARA           "
                            Chk_Arc2No.Refresh
                            Chk_Arc2Si.Refresh
                            Chk_Arc3No.Refresh
                            Chk_Arc3Si.Refresh
                            Lbl_Info.Refresh
                            
                            If BtwGara(0) = True Then

                                Call Agrupa_Ctr

                                Chk_Arc3No.Value = 0
                                Chk_Arc3Si.Value = 1
                                Chk_Arc3No.BackColor = &HC0C0C0
                                Chk_Arc3Si.BackColor = &HC0C0C0
                                Chk_TaNo.BackColor = &H808000
                                Chk_TaSi.BackColor = &H808000
                                Lbl_Info.Caption = "Proceso de Cierre Sistema AS400     "
                                Chk_Arc3No.Refresh
                                Chk_Arc3Si.Refresh
                                Chk_TaNo.Refresh
                                Chk_TaSi.Refresh
                                Lbl_Info.Refresh
                                    
                                nRespsh% = Shell(gsBac_DIRIN + "CIERREAS.PIF", 0)
                                
                                Chk_TaNo.Value = 0
                                Chk_TaSi.Value = 1
                                Chk_TaNo.BackColor = &HC0C0C0
                                Chk_TaSi.BackColor = &HC0C0C0
                                Chk_FdNo.BackColor = &H808000
                                Chk_FdSi.BackColor = &H808000
                                Lbl_Info.Caption = " Fin de Día                    "
                                Chk_TaNo.Refresh
                                Chk_TaSi.Refresh
                                Chk_FdNo.Refresh
                                Chk_FdSi.Refresh
                                Lbl_Info.Refresh
                                    
                                If SQL_Execute("SP_RESPALDO '" + cFechoy$ + "','FIN'") <> 0 Then
                                    nSw% = 1
                                    Lbl_Info.Caption = "Respaldo Fin de Día Ha Fallado      "
                                    Lbl_Info.Refresh
                                End If
                                
                                If nSw% = 1 Then
                                    MsgBox "Respaldo Fin de Día Ha Fallado", 16, "Cierre Automático"
                                    Call ErrorFinDia
                                    MousePointer = 0
                                    Exit Sub
                                End If
                                
                                Lbl_Info.Caption = "Respaldo Información Rentabilidad      "
                                If SQL_Execute("SP_GENDATOSRENTAB") <> 0 Then
                                    Lbl_Info.Caption = "Respaldo Rentabilidad ha Fallado"
                                    Lbl_Info.Refresh
                                End If
                                                                      
                                If SQL_Execute("SP_FDIA") = 0 Then
                                    
                                    Chk_FdNo.Value = 0
                                    Chk_FdSi.Value = 1
                                    Chk_FdNo.BackColor = &HC0C0C0
                                    Chk_FdSi.BackColor = &HC0C0C0
                                    Chk_FdNo.Refresh
                                    Chk_FdSi.Refresh
                                    
                                    If SQL_Execute("SP_ACTMDDI") <> 0 Then
                                                                        
                                    End If
                                                                        
                                Else
                                    If nSw% = 0 Then
                                        nSw% = 1
                                        Lbl_Info.Caption = "Fin de Día Ha Fallado               "
                                        Chk_FdNo.Value = 2
                                        Chk_FdSi.Value = 2
                                        Chk_FdNo.BackColor = &HFF&
                                        Chk_FdSi.BackColor = &HFF&
                                        Lbl_Info.Refresh
                                        Chk_FdNo.Refresh
                                        Chk_FdSi.Refresh
                                    End If
                                End If
                            Else
                                nSw% = 1
                                Lbl_Info.Caption = "Generación BTWGARA ha Fallado       "
                                Chk_Arc3No.Value = 2
                                Chk_Arc3Si.Value = 2
                                Chk_Arc3No.BackColor = &HFF&
                                Chk_Arc3Si.BackColor = &HFF&
                                Lbl_Info.Refresh
                                Chk_Arc3No.Refresh
                                Chk_Arc3Si.Refresh
                            End If
                        Else
                            nSw% = 1
                            Lbl_Info.Caption = "Generación TRDMOVA ha Fallado       "
                            Chk_Arc2No.Value = 2
                            Chk_Arc2Si.Value = 2
                            Chk_Arc2No.BackColor = &HFF&
                            Chk_Arc2Si.BackColor = &HFF&
                            Lbl_Info.Refresh
                            Chk_Arc2No.Refresh
                            Chk_Arc2Si.Refresh
                        End If
                    Else
                        If nSw% = 0 Then
                            nSw% = 1
                            Lbl_Info.Caption = "Generación PTWDOCU ha Fallado       "
                            Chk_Arc1No.Value = 2
                            Chk_Arc1Si.Value = 2
                            Chk_Arc1No.BackColor = &HFF&
                            Chk_Arc1Si.BackColor = &HFF&
                            Lbl_Info.Refresh
                            Chk_Arc1No.Refresh
                            Chk_Arc1Si.Refresh
                        End If
                    End If
                End If
            Else
                If nSw% = 0 Then
                    nSw% = 1
                    Lbl_Info.Caption = "El Devengo ha Fallado               "
                    Chk_Dev1No.Value = 2
                    Chk_Dev1Si.Value = 2
                    Chk_Dev1No.BackColor = &HFF&
                    Chk_Dev1Si.BackColor = &HFF&
                    Lbl_Info.Refresh
                    Chk_Dev1No.Refresh
                    Chk_Dev1Si.Refresh
                End If
            End If
        End If
    Else
        nSw% = 1
        Lbl_Info.Caption = "Carga Monedas desde BAE ha Fallado  "
        Chk_CMNo.Value = 2
        Chk_CMSi.Value = 2
        Chk_CMNo.BackColor = &HFF&
        Chk_CMSi.BackColor = &HFF&
        Lbl_Info.Refresh
        Chk_CMNo.Refresh
        Chk_CMSi.Refresh
    End If
    
    Call ErrorFinDia
    
    Lbl_Info.Caption = "Respaldo Información Rentabilidad   "
    Lbl_Info.Refresh
                                    
    If nSw = 0 Then
        If SQL_Execute("SP_GENDATOSRENTAB") <> 0 Then
            nSw% = 1
            Lbl_Info.Caption = "Respaldo Fin de Día Ha Fallado      "
            Lbl_Info.Refresh
        End If
    End If
    
    MousePointer = 0
        
    If nSw = 0 Then
        Lbl_Info.Caption = " Fin de Día Terminado Correctamente "
        Lbl_Info.Refresh
        MsgBox "Fin de Día Terminado Correctamente", 64, "Cierre Automático"
        Unload Me
    End If

End Sub

Private Sub Com_Sal_Click()
  Unload Frm_CierreDia
End Sub

Private Sub Form_Load()
Dim dFec_aux As String
Dim Datos()

    cFec_aux = Format$(gsBac_Fecp, "mm/dd/yyyy")
   
    If SQL_Execute("SELECT ISNULL(a.vmvalor,0),ISNULL(b.vmvalor,0),ISNULL(c.vmvalor,0) FROM MdVm a,MdVm b,MdVm c WHERE (a.vmfecha='" + cFec_aux + "' AND b.vmfecha='" + cFec_aux + "' AND c.vmfecha='" + cFec_aux + "') AND (a.vmcodigo=300 AND b.vmcodigo=301 AND c.vmcodigo=302)") = 0 Then
        Do While SQL_Fetch(Datos()) = 0
            t_ptf = Val(Datos(1))
            t_pcdUF = Val(Datos(2))
            t_pcdUS = Val(Datos(3))
        Loop
    End If
    
End Sub

