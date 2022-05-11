VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacModOpe 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Modificación de Operaciones Diarias"
   ClientHeight    =   6975
   ClientLeft      =   465
   ClientTop       =   1425
   ClientWidth     =   10530
   DrawWidth       =   2
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmodop.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6975
   ScaleWidth      =   10530
   Visible         =   0   'False
   Begin VB.Frame Frm_Datos 
      Caption         =   "Datos Operación"
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
      Height          =   5500
      Left            =   90
      TabIndex        =   13
      Top             =   1455
      Width           =   10395
      Begin VB.TextBox TxtCodCli 
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
         Left            =   1350
         MaxLength       =   7
         TabIndex        =   24
         Top             =   3075
         Width           =   515
      End
      Begin VB.TextBox TxtNomCli 
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
         Left            =   2010
         MaxLength       =   50
         TabIndex        =   23
         Top             =   3075
         Width           =   4935
      End
      Begin VB.TextBox txtRutCli 
         Alignment       =   1  'Right Justify
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
         Left            =   105
         MaxLength       =   9
         MouseIcon       =   "Bacmodop.frx":030A
         MousePointer    =   99  'Custom
         TabIndex        =   22
         Top             =   3075
         Width           =   1140
      End
      Begin VB.Frame Frame1 
         Caption         =   "Tipo Retiro"
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
         Height          =   950
         Left            =   7385
         TabIndex        =   17
         Top             =   1435
         Width           =   1335
         Begin Threed.SSOption OptVamos 
            Height          =   255
            Left            =   90
            TabIndex        =   18
            TabStop         =   0   'False
            Top             =   510
            Width           =   1200
            _Version        =   65536
            _ExtentX        =   2117
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Vamos"
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
         End
         Begin Threed.SSOption OptVienen 
            Height          =   255
            Left            =   75
            TabIndex        =   19
            TabStop         =   0   'False
            Top             =   240
            Width           =   1200
            _Version        =   65536
            _ExtentX        =   2117
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Vienen"
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
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Láminas"
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
         Height          =   950
         Left            =   8835
         TabIndex        =   14
         Top             =   1435
         Width           =   870
         Begin Threed.SSOption OptionSi 
            Height          =   255
            Left            =   150
            TabIndex        =   15
            TabStop         =   0   'False
            Top             =   225
            Width           =   495
            _Version        =   65536
            _ExtentX        =   873
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Sí"
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
         End
         Begin Threed.SSOption OptionNo 
            Height          =   255
            Left            =   150
            TabIndex        =   16
            TabStop         =   0   'False
            Top             =   495
            Width           =   495
            _Version        =   65536
            _ExtentX        =   873
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "No"
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
         End
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3240
         Top             =   1995
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
               Picture         =   "Bacmodop.frx":0614
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmodop.frx":092E
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmodop.frx":0C48
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin MSFlexGridLib.MSFlexGrid grdpaso 
         Height          =   1575
         Left            =   120
         TabIndex        =   20
         Top             =   3795
         Width           =   7095
         _ExtentX        =   12515
         _ExtentY        =   2778
         _Version        =   393216
         Cols            =   10
         FixedCols       =   0
         BackColor       =   12632256
         ForeColor       =   12582912
         BackColorFixed  =   8421376
         ForeColorFixed  =   14737632
         BackColorBkg    =   12632256
         GridLines       =   2
      End
      Begin BACControles.TXTNumero FValorOp 
         Height          =   315
         Left            =   5160
         TabIndex        =   21
         Top             =   3420
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
         Text            =   "0,00"
         Text            =   "0,00"
         Max             =   "99999999999999"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
      End
      Begin Threed.SSFrame SSFrame1 
         Height          =   1245
         Left            =   120
         TabIndex        =   25
         Top             =   165
         Width           =   2175
         _Version        =   65536
         _ExtentX        =   3836
         _ExtentY        =   2196
         _StockProps     =   14
         Caption         =   "Inicio"
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
         Enabled         =   0   'False
         Begin BACControles.TXTNumero FInicioUM 
            Height          =   315
            Left            =   480
            TabIndex        =   26
            Top             =   720
            Width           =   1635
            _ExtentX        =   2884
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
            Min             =   "-99999999999999.9999"
            Max             =   "99999999999999.9999"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero FInicioP 
            Height          =   315
            Left            =   480
            TabIndex        =   27
            Top             =   360
            Width           =   1650
            _ExtentX        =   2910
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
            Min             =   "-99999999999999"
            Max             =   "99999999999999"
            Separator       =   -1  'True
         End
         Begin VB.Label Label6 
            Caption         =   "UM"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   225
            Left            =   120
            TabIndex        =   29
            Top             =   795
            Width           =   360
         End
         Begin VB.Label Label5 
            Caption         =   " $"
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
            Left            =   75
            TabIndex        =   28
            Top             =   420
            Width           =   255
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   1230
         Left            =   2400
         TabIndex        =   30
         Top             =   165
         Width           =   2775
         _Version        =   65536
         _ExtentX        =   4895
         _ExtentY        =   2170
         _StockProps     =   14
         Caption         =   "Datos Pacto o Interban."
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
         Enabled         =   0   'False
         Begin BACControles.TXTNumero FPlazPact 
            Height          =   315
            Left            =   1920
            TabIndex        =   31
            Top             =   360
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
            Text            =   "0"
            Text            =   "0"
            Min             =   "-99999999"
            Max             =   "999999999999"
         End
         Begin BACControles.TXTNumero FBasPact 
            Height          =   315
            Left            =   600
            TabIndex        =   32
            Top             =   720
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
            Text            =   "0"
            Text            =   "0"
            Max             =   "999999999999"
         End
         Begin BACControles.TXTNumero FTasPact 
            Height          =   315
            Left            =   585
            TabIndex        =   33
            Top             =   375
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
            Min             =   "-99999999999999.9999"
            Max             =   "99999999999.9999"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
         End
         Begin VB.Label TxtMoneda 
            Alignment       =   1  'Right Justify
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H80000008&
            Height          =   315
            Left            =   1920
            TabIndex        =   38
            Top             =   720
            Width           =   735
         End
         Begin VB.Label Label10 
            Caption         =   "UM"
            Height          =   255
            Left            =   1480
            TabIndex        =   37
            Top             =   795
            Width           =   405
         End
         Begin VB.Label Label9 
            Caption         =   "Plazo"
            Height          =   240
            Left            =   1480
            TabIndex        =   36
            Top             =   405
            Width           =   480
         End
         Begin VB.Label Label8 
            Caption         =   "Base"
            Height          =   210
            Left            =   70
            TabIndex        =   35
            Top             =   795
            Width           =   420
         End
         Begin VB.Label Label7 
            Caption         =   "Tasa"
            Height          =   240
            Left            =   70
            TabIndex        =   34
            Top             =   405
            Width           =   420
         End
      End
      Begin Threed.SSFrame SSFrame3 
         Height          =   1215
         Left            =   5280
         TabIndex        =   39
         Top             =   165
         Width           =   1905
         _Version        =   65536
         _ExtentX        =   3360
         _ExtentY        =   2143
         _StockProps     =   14
         Caption         =   "Vencimiento"
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
         Alignment       =   1
         Font3D          =   3
         Enabled         =   0   'False
         Begin BACControles.TXTNumero FVvencPact 
            Height          =   315
            Left            =   60
            TabIndex        =   40
            Top             =   720
            Width           =   1800
            _ExtentX        =   3175
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
            Min             =   "-99999999999999.9999"
            Max             =   "99999999999999.9999"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTFecha DVctPact 
            Height          =   315
            Left            =   495
            TabIndex        =   41
            Top             =   300
            Width           =   1350
            _ExtentX        =   2381
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
            Text            =   "17/11/2000"
         End
      End
      Begin Threed.SSFrame SSFrame7 
         Height          =   600
         Left            =   7385
         TabIndex        =   42
         Top             =   2390
         Width           =   2205
         _Version        =   65536
         _ExtentX        =   3889
         _ExtentY        =   1058
         _StockProps     =   14
         Caption         =   "Comisiones"
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
         Begin Threed.SSOption optComisionSi 
            Height          =   255
            Left            =   135
            TabIndex        =   43
            TabStop         =   0   'False
            Top             =   240
            Width           =   495
            _Version        =   65536
            _ExtentX        =   873
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Sí"
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
         End
         Begin Threed.SSOption optComisionNo 
            Height          =   255
            Left            =   1155
            TabIndex        =   44
            TabStop         =   0   'False
            Top             =   240
            Width           =   495
            _Version        =   65536
            _ExtentX        =   873
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "No"
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
         End
      End
      Begin Threed.SSFrame SSFrame4 
         Height          =   1365
         Left            =   0
         TabIndex        =   45
         Top             =   1425
         Width           =   3405
         _Version        =   65536
         _ExtentX        =   6006
         _ExtentY        =   2408
         _StockProps     =   14
         Caption         =   "Al Inicial"
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
         Begin VB.ComboBox Cmb_sub_forma_pago 
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
            Left            =   150
            Style           =   2  'Dropdown List
            TabIndex        =   47
            TabStop         =   0   'False
            Top             =   960
            Width           =   2805
         End
         Begin VB.ComboBox cmbFPagoIni 
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
            Left            =   150
            Style           =   2  'Dropdown List
            TabIndex        =   46
            Top             =   405
            Width           =   2805
         End
         Begin VB.Label Label17 
            Caption         =   "Sub Forma de Pago"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000C0&
            Height          =   255
            Left            =   150
            TabIndex        =   49
            Top             =   765
            Width           =   2805
         End
         Begin VB.Label Label12 
            Caption         =   "Forma de Pago"
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
            Left            =   150
            TabIndex        =   48
            Top             =   210
            Width           =   2805
         End
      End
      Begin Threed.SSFrame SSFrame5 
         Height          =   1365
         Left            =   3585
         TabIndex        =   54
         Top             =   1425
         Width           =   3465
         _Version        =   65536
         _ExtentX        =   6112
         _ExtentY        =   2408
         _StockProps     =   14
         Caption         =   "Al Vencimiento"
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
         Begin VB.ComboBox cmbFPagoVct 
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
            Left            =   150
            Style           =   2  'Dropdown List
            TabIndex        =   56
            TabStop         =   0   'False
            Top             =   405
            Width           =   2805
         End
         Begin VB.ComboBox Cmb_sub_forma_pago2 
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
            Left            =   150
            Style           =   2  'Dropdown List
            TabIndex        =   55
            TabStop         =   0   'False
            Top             =   960
            Width           =   2805
         End
         Begin VB.Label Label13 
            Caption         =   "Forma de Pago al Vencimiento"
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
            Left            =   150
            TabIndex        =   58
            Top             =   210
            Width           =   2820
         End
         Begin VB.Label Label20 
            Caption         =   "Sub Forma de Pago"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000C0&
            Height          =   255
            Left            =   150
            TabIndex        =   57
            Top             =   765
            Width           =   2805
         End
      End
      Begin Threed.SSFrame SSFrame6 
         Height          =   1290
         Left            =   7400
         TabIndex        =   60
         Top             =   125
         Width           =   2730
         _Version        =   65536
         _ExtentX        =   4815
         _ExtentY        =   2275
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
         Begin VB.ComboBox cmbEjecutivo 
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
            Left            =   100
            Style           =   2  'Dropdown List
            TabIndex        =   62
            Top             =   320
            Width           =   2550
         End
         Begin VB.ComboBox cmbRentabilidad 
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
            Left            =   100
            Style           =   2  'Dropdown List
            TabIndex        =   61
            Top             =   870
            Width           =   2550
         End
         Begin VB.Label Label14 
            Caption         =   "Ejecutivo"
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
            Left            =   105
            TabIndex        =   64
            Top             =   110
            Width           =   2220
         End
         Begin VB.Label Label11 
            Caption         =   "Tipo Rentabilidad"
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
            Left            =   105
            TabIndex        =   63
            Top             =   680
            Width           =   2220
         End
      End
      Begin VB.Label LblNomOpe 
         Alignment       =   1  'Right Justify
         Caption         =   "Valor Operación :"
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
         Height          =   270
         Left            =   1860
         TabIndex        =   53
         Top             =   3420
         Width           =   3090
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
         Height          =   210
         Index           =   9
         Left            =   1350
         TabIndex        =   52
         Top             =   2895
         Width           =   765
      End
      Begin VB.Label Label 
         Caption         =   "Nombre:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   7
         Left            =   2110
         TabIndex        =   51
         Top             =   2895
         Width           =   1005
      End
      Begin VB.Label Label 
         Caption         =   "Rut:"
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
         Index           =   5
         Left            =   135
         TabIndex        =   50
         Top             =   2895
         Width           =   735
      End
   End
   Begin VB.Frame Frm_Operacion 
      Height          =   855
      Left            =   105
      TabIndex        =   4
      Top             =   585
      Width           =   10380
      Begin VB.TextBox txtDigCli 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
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
         Left            =   1275
         MaxLength       =   1
         TabIndex        =   5
         Top             =   4080
         Width           =   255
      End
      Begin VB.TextBox TxtNomCart 
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
         Left            =   5850
         MaxLength       =   30
         TabIndex        =   3
         Top             =   435
         Width           =   3900
      End
      Begin VB.TextBox TxtRutCart 
         Alignment       =   1  'Right Justify
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
         Left            =   4455
         MaxLength       =   12
         TabIndex        =   2
         Top             =   435
         Width           =   1200
      End
      Begin VB.TextBox TxtTipope 
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
         Left            =   1395
         MaxLength       =   20
         TabIndex        =   1
         Top             =   435
         Width           =   3000
      End
      Begin VB.TextBox TxtNumoper 
         Alignment       =   1  'Right Justify
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
         Left            =   90
         MaxLength       =   10
         TabIndex        =   0
         Top             =   435
         Width           =   1215
      End
      Begin VB.Label Label4 
         Caption         =   "Nombre Cartera"
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
         Left            =   5850
         TabIndex        =   9
         Top             =   225
         Width           =   3900
      End
      Begin VB.Label Label3 
         Caption         =   "Rut Cartera"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   4455
         TabIndex        =   8
         Top             =   225
         Width           =   1185
      End
      Begin VB.Label Label2 
         Caption         =   "Tipo de Operación"
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
         Left            =   1400
         TabIndex        =   7
         Top             =   195
         Width           =   1845
      End
      Begin VB.Label Label1 
         Caption         =   "Nº Operación"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   60
         TabIndex        =   6
         Top             =   210
         Width           =   1305
      End
   End
   Begin Threed.SSCommand CmdLimpiar 
      Height          =   330
      Left            =   8040
      TabIndex        =   10
      Top             =   960
      Width           =   720
      _Version        =   65536
      _ExtentX        =   1270
      _ExtentY        =   582
      _StockProps     =   78
      Caption         =   "Limpiar"
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
   Begin Threed.SSCommand CmdModi 
      Height          =   330
      Left            =   8040
      TabIndex        =   11
      Top             =   600
      Width           =   720
      _Version        =   65536
      _ExtentX        =   1270
      _ExtentY        =   582
      _StockProps     =   78
      Caption         =   "&Modifica"
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
   Begin Threed.SSCommand CmdSalir 
      Height          =   330
      Left            =   8040
      TabIndex        =   12
      Top             =   1320
      Width           =   720
      _Version        =   65536
      _ExtentX        =   1270
      _ExtentY        =   582
      _StockProps     =   78
      Caption         =   "Salir"
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
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   495
      Left            =   0
      TabIndex        =   59
      Top             =   0
      Width           =   10530
      _ExtentX        =   18574
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
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmblimpiar"
            Description     =   "LIMPIAR"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbmodifica"
            Description     =   "MODIFICAR"
            Object.ToolTipText     =   "Modificar"
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
End
Attribute VB_Name = "BacModOpe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Dim Sql As String
Dim DATOS()
Dim ObjCliente  As New clsCliente
Dim objForPag   As New ClsCodigos

'LD1-COR-035

'Dim objCustodia     As New ClsCodigos
Dim objTipCar       As New ClsCodigos
Dim objSucursal     As New ClsCodigos
Dim objEjecutivo    As New ClsCodigos
Dim objRentabilidad As New ClsCodigos
Dim dfecinip As String
Dim cSaltoLinea As String

'LD1-COR-035


Private objMensajesCL   As Object
Dim nValmon#, nMonpact%, nTipcli%
Dim cSerie As String
Dim dRutOriginal As Double
Dim iPagoOriginal As Integer
Dim iDiasValorFpago As Integer
Dim iDiasValor      As Integer

'LD1-COR-035
Dim bValTasaPact    As Boolean
'LD1-COR-035


Dim fMonto_PFE  As Double
Dim fMonto_CCE  As Double

Function funcCarga_FPagos(objControl As Object)
Dim cSql As String
Dim DATOS()

    cSql = "EXECUTE SP_LEEFORPAGOS  "
                
    If miSQL.SQL_Execute(cSql) <> 0 Then Exit Function
    
    Do While Bac_SQL_Fetch(DATOS())
    
        If DATOS(3) = "N" Then
            objControl.AddItem DATOS(2)
            objControl.ItemData(objControl.NewIndex) = DATOS(1)
        End If
    Loop
  
End Function

Function LimpiaMod()

    Toolbar1.Buttons(3).Enabled = False
    
    Frm_Operacion.Enabled = True
    Frm_Datos.Enabled = False

    Toolbar1.Buttons(2).Enabled = False

    FTasPact.Enabled = True
    FPlazPact.Enabled = True
    DVctPact.Enabled = True
    cmbFPagoVct.Enabled = True
    
    'LD1-COR-035
    OptVienen.Caption = "Vienen"
    OptVamos.Caption = "Vamos"
    'LD1-COR-035
    
    LblNomOpe.Caption = "VALOR"
    FValorOp.text = ""
    TxtTipope.text = ""
    TxtRutCart.text = ""
    TxtNomCart.text = ""
    txtRutCli.text = ""
    TxtCodCli.text = ""
    TxtNomCli.text = ""
    txtDigCli.text = ""
    TxtNomCli.text = ""
    FInicioP.text = ""
    FInicioUM.text = ""
    FTasPact.text = ""
    FBasPact.text = ""
    FPlazPact.text = ""
    TxtMoneda.Caption = ""
    FVvencPact.text = ""
    TxtMoneda.Caption = ""
    'DVctPact.Text = ""
    cmbFPagoIni.ListIndex = -1
    cmbFPagoVct.ListIndex = -1
    
    'LD1-COR-035
    cmbRentabilidad.ListIndex = -1
   ' cmbCustodia.ListIndex = -1
    cmbEjecutivo.ListIndex = -1
    'cmbTipoCartera.ListIndex = -1
   ' cmbSucursal.ListIndex = -1
    FBasPact.Enabled = False
    'LD1-COR-035
    
    
    TxtNumoper.text = ""
          
    grdpaso.Rows = 1
    grdpaso.Row = 0
    grdpaso.Highlight = False
    
End Function

Private Function ChkDatMod() As Boolean
Dim i%, cInstser$, cTipoperO$
Dim dFecpcup As Date
Dim nRows%

    ChkDatMod = False
    
    If Val(TxtNumoper.text) = 0 Then
        TxtNumoper.SetFocus
        Exit Function
    End If
    
    
    If RTrim(TxtNomCli.text) = "" Then
        MsgBox "NOMBRE DE CLIENTE OBLIGATORIO", vbExclamation, "Modificación de Operaciones"
        TxtNomCli.SetFocus
        Exit Function
    End If
    
    If Val(txtRutCli.text) = 0 Then
        MsgBox "RUT DE CLIENTE OBLIGATORIO", vbExclamation, "Modificación de Operaciones"
        txtRutCli.SetFocus
        Exit Function
    ElseIf Val(txtRutCli.text) > 0 And Val(txtRutCli.text) < 50000000 And TxtTipope.Tag = "VI" Then
            If Val(FPlazPact.text) < 4 Then
                MsgBox "NO SE PUEDE HACER OPERACION POR MENOS 4 DIAS CON ESTE CLIENTE", vbExclamation, "Modificación de Operaciones"
                txtRutCli.SetFocus
                Exit Function
            End If
    End If
    
    
    If TxtTipope.Tag = "VI" Or TxtTipope.Tag = "CI" Then
    
        nRows = grdpaso.Rows - 1

        For i = 1 To nRows
    
            grdpaso.Row = i
        
            grdpaso.Col = 2: cInstser = grdpaso.text
            grdpaso.Col = 8: dFecpcup = grdpaso.text
            grdpaso.Col = 9: cTipoperO = grdpaso.text
            
            If dFecpcup < CDate(DVctPact.text) And cTipoperO = "CP" And Mid(cInstser, 1, 3) <> "PCD" Then
                MsgBox RTrim(cInstser) + " con Vencimiento de Cupón Durante el Pacto", vbCritical, "Modificación de Operaciones"
                FPlazPact.SetFocus
                Exit Function
            End If
            
            If dFecpcup < CDate(DVctPact.text) And cTipoperO = "CI" Then
                MsgBox RTrim(cInstser) + " Comprado con Pacto, vencimiento el " + Format$(dFecpcup, "mm/dd/yyyy"), vbCritical, "Modificación de Operaciones"
                FPlazPact.SetFocus
                Exit Function
            End If
            
        Next i
        'LD1-COR-035
     '    If cmbSucursal.ListIndex = -1 And cmbSucursal.Enabled Then
      '     MsgBox "Sucursal obligatoria", vbExclamation, gsBac_Version
       '    cmbSucursal.SetFocus
        '   Exit Function
        If cmbEjecutivo.ListIndex = -1 And cmbEjecutivo.Enabled Then
           MsgBox "Ejecutivo es obligatorio", vbExclamation, gsBac_Version
           cmbEjecutivo.SetFocus
           Exit Function
        'ElseIf cmbCustodia.ListIndex = -1 And cmbCustodia.Enabled Then
         '  MsgBox "Tipo custodia obligatoria", vbExclamation, gsBac_Version
         '  cmbCustodia.SetFocus
         '  Exit Function
        End If

    
    ElseIf TxtTipope.Tag = "VP" Or TxtTipope.Tag = "CP" Then
    
       '  If cmbSucursal.ListIndex = -1 And cmbSucursal.Enabled Then
          ''  MsgBox "Sucursal obligatoria", vbExclamation, gsBac_Version
          '  cmbSucursal.SetFocus
         '   Exit Function
         
         If cmbRentabilidad.ListIndex = -1 And cmbRentabilidad.Enabled Then
            MsgBox "Tipo rentabilidad obligatoria", vbExclamation, gsBac_Version
            cmbRentabilidad.SetFocus
            Exit Function
         ElseIf cmbEjecutivo.ListIndex = -1 And cmbEjecutivo.Enabled Then
            MsgBox "Ejecutivo es obligatorio", vbExclamation, gsBac_Version
            cmbEjecutivo.SetFocus
            Exit Function

      '   ElseIf cmbCustodia.ListIndex = -1 And cmbCustodia.Enabled Then
           ' MsgBox "Tipo custodia obligatoria", vbExclamation, gsBac_Version
          '  cmbCustodia.SetFocus
          '  Exit Function
        ' ElseIf cmbTipoCartera.ListIndex = -1 And cmbTipoCartera.Enabled Then
         '   MsgBox "Modalidad de inversión obligatoria", vbExclamation, gsBac_Version
          '  cmbTipoCartera.SetFocus
          '  Exit Function
         End If
    ElseIf TxtTipope.Tag = "IB" Then
       '  If cmbSucursal.ListIndex = -1 And cmbSucursal.Enabled Then
           ' MsgBox "Sucursal obligatoria", vbExclamation, gsBac_Version
           ' cmbSucursal.SetFocus
         '   Exit Function
         
        If cmbRentabilidad.ListIndex = -1 And cmbRentabilidad.Enabled Then
            MsgBox "Tipo rentabilidad obligatoria", vbExclamation, gsBac_Version
            cmbRentabilidad.SetFocus
            Exit Function
         ElseIf cmbEjecutivo.ListIndex = -1 And cmbEjecutivo.Enabled Then
            MsgBox "Ejecutivo es obligatorio", vbExclamation, gsBac_Version
            cmbEjecutivo.SetFocus
            Exit Function
         End If
         'LD1-COR-035
    End If
    
    ChkDatMod = True
   
End Function
'LD1-COR-035
Sub Habilita_Controles()
       
       'ld1-cor-035 --> Se quita de modificacion custodia
       ' tipo custodia
    '   Call objCustodia.LeerCodigos(203)
     '  Call objCustodia.Coleccion2Control(cmbCustodia)
       'ld1-cor-035
       
       ' Sucursal
      ' Call objSucursal.CargaSucursal("SUCURSAL")
       'Call objSucursal.Coleccion2Control(cmbSucursal)
       ' Ejecutivo
       Call objEjecutivo.CargaSucursal("EJECUTIVO")
       Call objEjecutivo.Coleccion2Control(cmbEjecutivo)
       ' Tipo Rentabilidad
       Call objRentabilidad.CargaSucursal("RENTABILIDAD")
       Call objRentabilidad.Coleccion2Control(cmbRentabilidad)
       ' Modalidad de Inversion
     
      'Call objTipCar.LeerCodigos(204)
       
     '  Call objTipCar.Coleccion2Control(cmbTipoCartera)
     
       
End Sub
'LD1-COR-035
'LD1-COR-035
Sub Deshabilita_Controles()

   Cmb_sub_forma_pago.Enabled = False
   Cmb_sub_forma_pago2.Enabled = False
   SSFrame7.Enabled = False
    
    If TxtTipope.Tag = "CP" Or TxtTipope.Tag = "VP" Then
     '   Me.cmbCustodia.Enabled = True
        Me.cmbEjecutivo.Enabled = True
        Me.cmbFPagoIni.Enabled = True
        cmbFPagoVct.Enabled = False
        Me.cmbRentabilidad.Enabled = True
       ' Me.cmbSucursal.Enabled = True
       ' Me.cmbTipoCartera.Enabled = True
        SSFrame7.Enabled = True
       ' cmbTipoCartera.Enabled = False
'nuevo
'        optComisionNo.TabStop = True
'        optComisionSi.TabStop = True
        Me.cmbFPagoVct.TabStop = False
        Me.FTasPact.TabStop = False
        Me.Cmb_sub_forma_pago.TabStop = False
        Me.cmbFPagoIni.TabIndex = 1
        Me.cmbFPagoVct.TabIndex = 2
        Me.txtRutCli.TabIndex = 3
        Me.TxtCodCli.TabIndex = 4
        Me.cmbEjecutivo.TabIndex = 5
      '  Me.cmbCustodia.TabIndex = 6
        Me.cmbRentabilidad.TabIndex = 7
   '     Me.cmbSucursal.TabIndex = 8
      
         
    ElseIf TxtTipope.Tag = "CI" Or TxtTipope.Tag = "VI" Then
       ' tipo custodia
      ' cmbTipoCartera.Enabled = False
       cmbRentabilidad.Enabled = False
       FTasPact.Enabled = True
       FPlazPact.Enabled = False
       DVctPact.Enabled = True
       SSFrame2.Enabled = True
'nuevo
       optComisionNo.TabStop = False
       optComisionSi.TabStop = False
       cmbFPagoVct.TabStop = True
       FTasPact.TabStop = True
       Cmb_sub_forma_pago.TabStop = False
       cmbRentabilidad.TabStop = False
       FTasPact.TabIndex = 1
        Me.cmbFPagoIni.TabIndex = 2
        Me.cmbFPagoVct.TabIndex = 3
        Me.txtRutCli.TabIndex = 4
        Me.TxtCodCli.TabIndex = 5
        Me.cmbEjecutivo.TabIndex = 6
       ' Me.cmbCustodia.TabIndex = 7
      '  Me.cmbSucursal.TabIndex = 8
        
        
    ElseIf TxtTipope.Tag = "VP" Then
    ElseIf TxtTipope.Tag = "IC" Then
       '  cmbCustodia.Enabled = False
         cmbRentabilidad.Enabled = False
         'Me.cmbTipoCartera.Enabled = False


    ElseIf TxtTipope.Tag = "IB" Then
      ' cmbTipoCartera.Enabled = True
       cmbRentabilidad.Enabled = True
       'cmbTipoCartera.Enabled = False
     '  cmbCustodia.Enabled = False
       FTasPact.Enabled = True
       FPlazPact.Enabled = True
       DVctPact.Enabled = True

    
    End If
    If TxtTipope.Tag = "VP" Then
       Me.cmbRentabilidad.Enabled = False
    End If
End Sub
'LD1-COR-035

Sub Llena_Grilla()
Dim DATOS()
Dim i       As Integer
'LD1-COR-035
Dim sTipOper   As String
Dim iMoneda    As Integer

Call Habilita_Controles

Frame1.Enabled = True
Frame2.Enabled = True
'LD1-COR-035

'    Sql = "SP_CONSMODOPER "
'    Sql = Sql + TxtNumoper.Text

    Envia = Array(CDbl(TxtNumoper.text))
    
    If Bac_Sql_Execute("SP_CONSMODOPER", Envia) Then
    
        grdpaso.Rows = 1
        
        
        Do While Bac_SQL_Fetch(DATOS())
        
            grdpaso.Rows = grdpaso.Rows + 1
            grdpaso.Row = grdpaso.Rows - 1
            
            If DATOS(1) = "NO" Then
                MsgBox DATOS(2), vbExclamation, gsBac_Version
                TxtNumoper.text = 0
                TxtNumoper.SetFocus
                Exit Do
            Else
            
                Frm_Operacion.Enabled = True
                Frm_Datos.Enabled = True
                
                Toolbar1.Buttons(2).Enabled = False
                         
                TxtTipope.Tag = DATOS(4)
                TxtTipope.text = DATOS(5)
                cSerie = IIf(DATOS(4) = "IB" And DATOS(5) = "CAPTACION", "ICAP", IIf(DATOS(4) = "IB" And DATOS(5) = "COLOCACION", "ICOL", ""))
                TxtRutCart.text = DATOS(6)
                TxtNomCart.text = DATOS(7)
                FInicioP.text = Val(DATOS(8))
                 'LD1-COR-035
                 Call Deshabilita_Controles
                ' LD1-COR-035
                FInicioUM.text = CDbl(DATOS(9))
                FTasPact.text = CDbl(DATOS(10))
                FBasPact.text = Val(DATOS(11))
                FPlazPact.text = DATOS(12)
                FPlazPact.Tag = DATOS(12)
                TxtMoneda.Caption = DATOS(13)
                nMonpact = Val(DATOS(14))
                DVctPact.text = DATOS(15)
                DVctPact.Tag = DATOS(15)
                FVvencPact.text = CDbl(DATOS(16))
                
                BacControlWindows 30
                
                If DATOS(4) = "CP" Or DATOS(4) = "VP" Or DATOS(4) = "ST" Then
                    FTasPact.Enabled = False
                    FPlazPact.Enabled = False
                    DVctPact.Enabled = False
                End If
                
                'LD1-COR-035
                      ' Sucursal
               ' For i% = 0 To cmbSucursal.ListCount - 1
                 '   cmbSucursal.ListIndex = i%
                   ' If cmbSucursal.ItemData(i%) = Val(DATOS(37)) Then Exit For
               ' Next i%
                i% = 0
                ' Ejecutivo
                For i% = 0 To cmbEjecutivo.ListCount - 1
                    cmbEjecutivo.ListIndex = i%
                    If cmbEjecutivo.ItemData(i%) = Val(DATOS(37)) Then Exit For
                Next i%
                i% = 0
                ' Custodia
              '  For i% = 0 To cmbCustodia.ListCount - 1
                  '  cmbCustodia.ListIndex = i%
                 '   If cmbCustodia.ItemData(i%) = Val(IIf(IsNull(DATOS(41)), 0, DATOS(41))) Then Exit For
              '  Next i%
                 ' Modalidad de Inversión
                'If TxtTipope.Tag = "CP" Then 'Or TxtTipope.Tag = "VP" Then
                  ' iMoneda = 999
                  ' If DATOS(39) = "1" Then
                   '  cmbTipoCartera.ListIndex = 0
                  ' ElseIf DATOS(39) = "2" Then
                  '   cmbTipoCartera.ListIndex = 1
                 '  ElseIf DATOS(39) = "3" Then
                   '  cmbTipoCartera.ListIndex = 2
                  ' ElseIf DATOS(39) = "4" Then
                   '  cmbTipoCartera.ListIndex = 3
                  ' End If
              '  ElseIf TxtTipope.Tag = "IB" Then
                   ' Rentabilidad
'                   Frame1.Enabled = False
                  ' Frame2.Enabled = False
                'End If
                
                 ' Rentabilidad
               If TxtTipope.Tag = "CP" Or TxtTipope.Tag = "IB" Then
                  Select Case DATOS(38)
                  Case ""
                      cmbRentabilidad.ListIndex = 0

                  Case "H"
                      cmbRentabilidad.ListIndex = 1

                  Case "I"
                      cmbRentabilidad.ListIndex = 2

                  End Select
               End If
               
                 If TxtTipope.Tag = "IC" Then
                  OptVienen.Caption = "Retener"
                  OptVamos.Caption = "Entregar"
                  OptVienen.Value = IIf(DATOS(40) = "R", True, False)
                  OptVamos.Value = IIf(DATOS(40) = "E", True, False)
               Else
                  OptVienen.Value = IIf(DATOS(40) = "I", True, False)
                  OptVamos.Value = IIf(DATOS(40) = "V", True, False)
               End If
                OptionSi.Value = IIf(DATOS(39) = "S", True, False)
                OptionNo.Value = IIf(DATOS(39) = "S", False, True)
                'LD1-COR-035

                For i% = 0 To cmbFPagoIni.ListCount - 1
                    cmbFPagoIni.ListIndex = i%
                    If cmbFPagoIni.ItemData(i%) = Val(DATOS(17)) Then Exit For
                Next i%
                
                For i% = 0 To cmbFPagoVct.ListCount - 1
                    cmbFPagoVct.ListIndex = i%
                    If cmbFPagoVct.ItemData(i%) = Val(DATOS(18)) Then Exit For
                Next i%
             
                
              ' VB+- 04/07/2000 Saco días valor de formas de pago
              ' ----------------------------------------------------------
                iDiasValorFpago = Val(Right$(cmbFPagoIni.text, 3))
              ' ----------------------------------------------------------
                
                If DATOS(4) = "VI" Or DATOS(4) = "CI" Or DATOS(4) = "IB" Then
                    For i% = 0 To cmbFPagoVct.ListCount - 1
                        cmbFPagoVct.ListIndex = i%
                        If cmbFPagoVct.ItemData(i%) = Val(DATOS(18)) Then Exit For
                    Next i%
                Else
                    If DATOS(4) = "RC" Or DATOS(4) = "RV" Then
                           'NADA
                    Else
                      cmbFPagoVct.ListIndex = -1
                      cmbFPagoVct.Enabled = False
                      SSFrame1.Enabled = False
                      SSFrame2.Enabled = False
                      SSFrame3.Enabled = False
                    End If
                End If
                
                'LD1-COR-035
                  If DATOS(4) = "VI" Or DATOS(4) = "CI" Then
                   If Val(DATOS(17)) = 3 Then
                      Cmb_sub_forma_pago.Enabled = True
                      Cmb_sub_forma_pago.ListIndex = BacBuscaComboIndice(Cmb_sub_forma_pago, CLng(DATOS(42)))
                   End If
                   If Val(DATOS(18)) = 3 Then
                      Cmb_sub_forma_pago2.Enabled = True
                      Cmb_sub_forma_pago2.ListIndex = BacBuscaComboIndice(Cmb_sub_forma_pago2, CLng(DATOS(42)))
                   End If

                End If
                
                'LD1-COR-035
                
                txtRutCli.text = DATOS(19)
                txtDigCli.text = DATOS(20)
                TxtNomCli.text = DATOS(21)
                TxtCodCli.text = Val(DATOS(33))
                nValmon = CDbl(DATOS(28))
                
              ' VB+ 22/06/2000 Estos campos se usan para rebajar los limites originales
              ' ========================================================================
                dRutOriginal = DATOS(19)
                iPagoOriginal = DATOS(18)
              ' ========================================================================
              ' VB-
                ValorA = " "
                ValorA = "Operacion:" & Me.TxtNumoper.text & ";" & Me.TxtTipope.Tag & ";" & "Rut Cliente:" & Me.txtRutCli & ";Codigo Cliente:" & Me.TxtCodCli & ";Forma de Pago Inicio:" & Val(DATOS(17)) & ";Forma de Pago Venc:" & Val(DATOS(18)) & ";Tasa Pacto:" & Me.FTasPact.text
                
                If nMonpact = 999 Then
                    nValmon = 1
                End If
                
                LblNomOpe.Caption = RTrim(DATOS(5)) + " VALOR"
                FValorOp.text = Val(DATOS(29))
                
                grdpaso.Col = 0: grdpaso.text = DATOS(2)
                grdpaso.Col = 1: grdpaso.text = DATOS(3)
                grdpaso.Col = 2: grdpaso.text = DATOS(22)
                'ld1-cor-035
                  If DATOS(44) = "N" Then
                   optComisionNo.Value = True
                Else
                   optComisionSi.Value = True
                End If
                'ld1-cor-035
                
                If Trim(DATOS(22)) = "FMUTUO" Then
                  grdpaso.ColWidth(6) = 1800
                End If
                grdpaso.Col = 3: grdpaso.text = DATOS(23)
                grdpaso.Col = 4: grdpaso.text = DATOS(24)
                grdpaso.Col = 5: grdpaso.text = Format(CDbl(DATOS(25)), "#,##0.0000")
                grdpaso.Col = 6: grdpaso.text = Format(CDbl(DATOS(26)), "#,##0.0000")
                grdpaso.Col = 7: grdpaso.text = Format(CDbl(DATOS(27)), "#,##0.00")
                grdpaso.Col = 8: grdpaso.text = DATOS(31)
                grdpaso.Col = 9: grdpaso.text = DATOS(32)
              ' Montos PFE y PFE
                fMonto_PFE = Val(DATOS(34))
                fMonto_CCE = Val(DATOS(35))
              
                nTipcli = Val(Trim(DATOS(30)))
                Toolbar1.Buttons(3).Enabled = True
            
            End If
       Loop
        
       grdpaso.Highlight = False
    Else
        MsgBox "Servidor SQL No Responde", 16
    End If
       
    If TxtTipope.Tag = "RC" Or TxtTipope.Tag = "RV" Then
        cmbFPagoIni.Enabled = False
        txtRutCli.Enabled = False
        TxtCodCli.Enabled = False
        TxtNomCli.Enabled = False
        grdpaso.Enabled = False
        cmbFPagoVct.Enabled = True
    End If
        
    If TxtTipope.Tag = "" Then
        MsgBox "Esta Operación no se puede modificar", vbInformation, gsBac_Version
        Call LimpiaMod
        TxtNumoper.SetFocus
    End If
       
End Sub

'LD1-COR-035
Private Sub cmbFPagoIni_LostFocus()

   If cmbFPagoIni.ListIndex < 0 Then
      Cmb_sub_forma_pago.Enabled = False
      Cmb_sub_forma_pago.TabStop = False
      Cmb_sub_forma_pago.ListIndex = -1
      Exit Sub
   End If

   If TxtTipope.Tag = "VI" Or TxtTipope.Tag = "CI" Then
      If cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex) = 3 Then
         Cmb_sub_forma_pago.Enabled = True
         Cmb_sub_forma_pago.TabStop = True
      Else
         Cmb_sub_forma_pago.Enabled = False
         Cmb_sub_forma_pago.TabStop = False
         Cmb_sub_forma_pago.ListIndex = -1
      End If
   End If

End Sub

Private Sub cmbFPagoVct_LostFocus()

   If cmbFPagoVct.ListIndex < 0 Then
      Cmb_sub_forma_pago2.Enabled = False
      Cmb_sub_forma_pago2.TabStop = False
      Cmb_sub_forma_pago2.ListIndex = -1
      Exit Sub
   End If

   If TxtTipope.Tag = "VI" Or TxtTipope.Tag = "CI" Then
      If cmbFPagoVct.ItemData(cmbFPagoVct.ListIndex) = 3 Then
         Cmb_sub_forma_pago2.Enabled = True
         Cmb_sub_forma_pago2.TabStop = True
      Else
         Cmb_sub_forma_pago2.TabStop = False
         Cmb_sub_forma_pago2.Enabled = False
         Cmb_sub_forma_pago2.ListIndex = -1
      End If
   End If

End Sub

'Private Sub cmbSucursal_LostFocus()
'If Me.OptVamos.Value = True Then
'  Me.OptVamos.TabIndex = 9
'Else
   'Me.OptVienen.TabIndex = 9
'End If
'End Sub

Private Sub Form_Activate()
'Call LimpiaMod
TxtNumoper.SetFocus
End Sub


'LD1-COR-035

Private Sub DVctPact_LostFocus()
If DVctPact.Enabled Then
    FPlazPact.text = DateDiff("d", gsBac_Fecp, DVctPact.text)

    If EsFeriado(CDate(DVctPact.text), "00001") Then
        MsgBox "La Fecha de Vcto. ingresada retorna un día No Hábil; Por favor reingrese", vbCritical, "FERIADOS"
        FPlazPact.text = FPlazPact.Tag
        DVctPact.text = Format$(DateAdd("d", FPlazPact.text, gsBac_Fecp), "dd/mm/yyyy")
        Exit Sub
    End If
    
    If FPlazPact.text = 0 Then
        MsgBox "Fecha de Vcto. Ingresada igual a la de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
        FPlazPact.text = FPlazPact.Tag
        DVctPact.text = Format$(DateAdd("d", FPlazPact.text, gsBac_Fecp), "dd/mm/yyyy")
      Exit Sub
    End If
    
    FVvencPact.text = VI_ValorFinal(Val(FInicioUM.text), Val(FTasPact.text), Val(FPlazPact.text), Val(FBasPact.text))
End If
End Sub


Private Sub FInicioP_KeyPress(KeyAscii As Integer)
    If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
        KeyAscii = Asc(gsBac_PtoDec)
    End If
End Sub

Private Sub FInicioUM_KeyPress(KeyAscii As Integer)
    If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
        KeyAscii = Asc(gsBac_PtoDec)
    End If
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        SendKeys "{TAB}"
        KeyAscii = 0
    End If

End Sub

Private Sub Form_Load()


    Me.Top = 0
    Me.Left = 0
   
    Screen.MousePointer = 11
    
    Set ObjCliente = New clsCliente
                
    Call funcCarga_FPagos(cmbFPagoIni)
    
    Call funcCarga_FPagos(cmbFPagoVct)
    
    'LD1-COR-035
    Call funcCarga_FPagos(Cmb_sub_forma_pago)
    Call funcCarga_FPagos(Cmb_sub_forma_pago2)
    'LD1-COR-035
    
    Me.grdpaso.Rows = 1
    Me.grdpaso.Row = 0
    Me.grdpaso.ColWidth(0) = 0
    Me.grdpaso.ColWidth(1) = 0
    Me.grdpaso.ColWidth(2) = 1200
    Me.grdpaso.ColWidth(3) = 1200
    Me.grdpaso.ColWidth(4) = 0
    Me.grdpaso.ColWidth(5) = 1800
    Me.grdpaso.ColWidth(6) = 1000
    Me.grdpaso.ColWidth(7) = 1800
    Me.grdpaso.ColWidth(8) = 0
    Me.grdpaso.ColWidth(9) = 0
    Me.grdpaso.TextMatrix(0, 2) = "Serie"
    Me.grdpaso.TextMatrix(0, 3) = "Emisor"
    Me.grdpaso.TextMatrix(0, 5) = "Nominal"
    Me.grdpaso.TextMatrix(0, 6) = "% Tir"
    Me.grdpaso.TextMatrix(0, 7) = "Valor Presente"
    
    LimpiaMod
    
    Toolbar1.Buttons(3).Enabled = False
    
    Screen.MousePointer = 0
    
End Sub


Private Sub FPlazPact_LostFocus()
If FPlazPact.Enabled Then
    DVctPact.text = Format$(DateAdd("d", FPlazPact.text, gsBac_Fecp), "dd/mm/yyyy")
    
    If EsFeriado(CDate(DVctPact.text), "00001") Then
        MsgBox "La Fecha de Vcto. ingresada retorna un día No Hábil; Por favor reingrese", vbCritical, "FERIADOS"
        FPlazPact.text = FPlazPact.Tag
        DVctPact.text = Format$(DateAdd("d", FPlazPact.text, gsBac_Fecp), "dd/mm/yyyy")
        Exit Sub
    End If
    
    If FPlazPact.text = 0 Then
        MsgBox "Fecha de Vcto. Ingresada igual a la de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
        DVctPact.text = Format$(DateAdd("d", FPlazPact.text, gsBac_Fecp), "dd/mm/yyyy")
      Exit Sub
    End If
    
    FVvencPact.text = VI_ValorFinal(Val(FInicioUM.text), Val(FTasPact.text), Val(FPlazPact.text), Val(FBasPact.text))
End If
End Sub


Private Sub FTasPact_KeyPress(KeyAscii As Integer)
    If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
        KeyAscii = Asc(gsBac_PtoDec)
    End If
End Sub

Private Sub FTasPact_LostFocus()
    If BacModOpe.TxtTipope.text = "" Then FVvencPact.text = VI_ValorFinal(Val(FInicioUM.text), Val(FTasPact.text), Val(FPlazPact.text), Val(FBasPact.text))
End Sub

'LD1-COR-035
Private Sub OptionNo_LostFocus()
If optComisionSi.Value = True Then
   optComisionSi.TabIndex = 11

Else
     optComisionNo.TabIndex = 11

End If
End Sub

Private Sub OptionSi_LostFocus()
If optComisionSi.Value = True Then
   optComisionSi.TabIndex = 11
Else
     optComisionNo.TabIndex = 11
End If
End Sub

Private Sub OptVamos_LostFocus()
If OptionSi.Value = True Then
   OptionSi.TabIndex = 10
Else
   OptionNo.TabIndex = 10
End If

End Sub

Private Sub OptVienen_LostFocus()
If OptionSi.Value = True Then
   OptionSi.TabIndex = 10
Else
   OptionNo.TabIndex = 10
End If

End Sub
'LD1-COR-035

Private Sub SSCommand2_Click()

End Sub

Private Sub SSCommand1_Click()

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Description)
    Case "LIMPIAR"
        Call LimpiaMod
    Case "MODIFICAR"
        Call TOOLMODIFICAR
    Case "SALIR"
         Unload Me
End Select
End Sub
Function TOOLMODIFICAR()
Dim DATOS()
Dim nRows%, i%
Dim dFecvenp As Date
Dim nValvenp#, nValinip#, nNumdocu#, nNumoper#, nCorrela%, iForPagI%, iForPagV%
Dim cFecvenp$, nTaspact#, nBaspact%, cTipOper$, nRutcli#, nCodcli%, nSw%, cNomclie$


'LD1-COR-035
Dim sucursal$, Ejecutivo$, Rentabilidad$, ModInver$, cTipCus$, cRetiro$, cLaminas$

'LD1-COR-035

Dim FlagTx As Boolean
Dim Rutcart As String
Dim cResult As String

'LD1-COR-035
Dim iSubFPago    As Integer
Dim iSubFPago2    As Integer
Dim sComision     As String
Dim cMensaje As String
Dim VecAux()
Dim C As Integer
cSaltoLinea = Chr(13) + Chr(10)
'LD1-COR-035
'On Error GoTo errModi

    Screen.MousePointer = 11
    
    nValvenp = 0
    nValinip = 0
    nNumdocu = 0
    nNumoper = 0
    nCorrela = 0
    iForPagI = 0
    iForPagV = 0
    nSw = 0
    Rutcart = Mid(TxtRutCart.text, 1, Val(InStr(1, TxtRutCart.text, "-")) - 1)
    nBaspact = Val(FBasPact.text)
    nTaspact = CDbl(FTasPact.text)
    nRutcli = Val(txtRutCli.text)
    nCodcli = Val(TxtCodCli.text)
    cTipOper = Trim(TxtTipope.Tag)
    nNumoper = Val(TxtNumoper.text)
    cNomclie = TxtNomCli.text
        
    'LD1-COR-035
     ' sucursal$ = cmbSucursal.ItemData(cmbSucursal.ListIndex)   ' Mid(cmbSucursal.Text, 1, 5)
    Ejecutivo$ = cmbEjecutivo.ItemData(cmbEjecutivo.ListIndex)
    
    If TxtTipope.Tag = "CP" Then
       Rentabilidad$ = IIf(cmbRentabilidad.ItemData(cmbRentabilidad.ListIndex) = 1, "H", "I")
    '   If cmbTipoCartera.ListIndex = 0 Then
       '   ModInver$ = "T"
     '  ElseIf cmbTipoCartera.ListIndex = 1 Then
         ' ModInver$ = "A"
     '  ElseIf cmbTipoCartera.ListIndex = 2 Then
       '   ModInver$ = "P"
      ' ElseIf cmbTipoCartera.ListIndex = 3 Then
         'ModInver$ = "H"
       'End If
    ElseIf TxtTipope.Tag = "IB" Then
       Select Case cmbRentabilidad.ItemData(cmbRentabilidad.ListIndex)
       Case 1
          Rentabilidad$ = " "
       Case 2
          Rentabilidad$ = "H"
       Case 3
          Rentabilidad$ = "I"
       End Select
    End If
       
  '  If TxtTipope.Tag <> "IB" And TxtTipope.Tag <> "IC" Then
    '   cTipCus$ = cmbCustodia.ItemData(cmbCustodia.ListIndex)
  '  End If
   
    If TxtTipope.Tag = "IC" Then
      cRetiro$ = IIf(OptVienen.Value, "R", "E")
    Else
       cRetiro$ = IIf(OptVienen.Value, "I", "V")
    End If
    cLaminas$ = IIf(OptionSi, "S", "N")
    sComision = IIf(SSFrame7.Enabled, IIf(optComisionSi.Value, "S", "N"), "N")

    'LD1-COR-035
        
    If ChkDatMod() = False Then
        Screen.MousePointer = 0
        Exit Function
    End If
    
    If MsgBox("¿Confirma Modificación de Operación Nº " + TxtNumoper.text + "?", 36, "Modificación de Operaciones") = 7 Then
        Screen.MousePointer = 0
        Exit Function
    End If
    
    iForPagI = cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex)
  ' VB+- 17/06/2000 Saco dias valor de la forma de pago
  ' --------------------------------------------------------
    iDiasValor = Val(Right$(cmbFPagoIni.text, 3))
  ' --------------------------------------------------------

    cFecvenp = Format(gsBac_Fecp, "yyyymmdd")
    dFecvenp = gsBac_Fecp
       
    If cTipOper <> "VP" And cTipOper <> "CP" And cTipOper <> "ST" Then
        If cTipOper <> "IC" Then
           iForPagV = cmbFPagoVct.ItemData(cmbFPagoVct.ListIndex)
        Else
           iForPagV = iForPagI
        End If
        cFecvenp = Format$(CDate(DVctPact.text), "yyyymmdd")
        dFecvenp = CDate(DVctPact.text)
    End If
    
    'LD1-COR-035
       If cTipOper = "CI" Or cTipOper = "VI" Then
      If Cmb_sub_forma_pago.Enabled = True Then
         iSubFPago = Cmb_sub_forma_pago.ItemData(Cmb_sub_forma_pago.ListIndex)
      End If
      If Cmb_sub_forma_pago2.Enabled = True Then
         iSubFPago2 = Cmb_sub_forma_pago2.ItemData(Cmb_sub_forma_pago2.ListIndex)
      End If
      Else
        iSubFPago = 0
        iSubFPago2 = 0
      End If
    'LD1-COR-035
    
    
    FlagTx = False
    cResult = "OK"
    
  ' Excluyo operaciones OverNight de calculo de limites
  ' ----------------------------------------------------
'    If Not (TxtMoneda.Caption = gsBac_Dolar And cSerie = "ICOL") Then
    
'    End If
  
'    If cResult <> "OK" Then
'        If MsgBox("Existen sobregiros en limites " & vbCrLf & vbCrLf & "¿ Desea continuar con grabación ?", vbQuestion + vbYesNo + vbDefaultButton2, gsBac_Version) = vbNo Then
'            Screen.MousePointer = vbDefault
'            Exit Function
'        End If
'    End If
    
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
       GoTo BacErrorModi
    End If
    
    FlagTx = True
        
    nRows = grdpaso.Rows - 1

    For i = 1 To nRows
    
        grdpaso.Row = i
        
        grdpaso.Col = 0: nNumdocu = Val(grdpaso.text)
        grdpaso.Col = 1: nCorrela = Val(grdpaso.text)
        grdpaso.Col = 7: nValinip = BacFormatoSQL(grdpaso.text)
        
                                                'LD1-COR-035 SE AGREGAN CAPTACIONES
        If cTipOper = "VI" Or cTipOper = "CI" Or cTipOper = "IC" Or cTipOper = "IB" Then
            If nMonpact = 999 Then
                nValvenp = CVar(Format(nValinip * (((nTaspact / (nBaspact * 100#)) * DateDiff("d", gsBac_Fecp, dFecvenp)) + 1), "##,###,###,###,##0"))
            Else
                nValvenp = CVar(nValinip / nValmon * (((nTaspact / (nBaspact * 100#)) * DateDiff("d", gsBac_Fecp, dFecvenp)) + 1))
            End If
        End If
        
'        Sql = "SP_MODIFICAOPER " & Chr$(10)
'        Sql = Sql & nNumdocu & "," & Chr$(10)
'        Sql = Sql & nNumoper & "," & Chr$(10)
'        Sql = Sql & ncorrela & "," & Chr$(10)
'        Sql = Sql & "'" & cTipOper & "'," & Chr$(10)
'        Sql = Sql & nRutcli & "," & Chr$(10)
'        Sql = Sql & iForPagI & "," & Chr$(10)
'        Sql = Sql & iForPagV & "," & Chr$(10)
'        Sql = Sql & BacFormatoSQL(nTaspact) & "," & Chr$(10)
'        Sql = Sql & "'" & Format(cFecvenp, "dd/mm/yyyy") & "'," & Chr$(10)
'        Sql = Sql & BacFormatoSQL(nValvenp) & "," & Chr$(10)
'        Sql = Sql & "'" & cNomclie & "',"
'        Sql = Sql & nCodcli
        
        
        'LD1-COR-035
        Envia = Array(nNumdocu, _
                nNumoper, _
                CDbl(nCorrela), _
                cTipOper, _
                nRutcli, _
                CDbl(iForPagI), _
                CDbl(iForPagV), _
                CDbl(nTaspact), _
                cFecvenp, _
                CDbl(nValvenp), _
                cNomclie, _
                CDbl(nCodcli), _
                Ejecutivo$, _
                Rentabilidad$, _
                cRetiro$, _
                cLaminas$, _
                iSubFPago, _
                iSubFPago2, _
                sComision)
    
        If Bac_Sql_Execute("SP_MODIFICAOPER", Envia) Then
            Do While Bac_SQL_Fetch(DATOS())
                If DATOS(1) = "NO" Then
                    MsgBox DATOS(2), 32
                    nSw = 1
                End If
            Loop
        Else
            GoTo BacErrorModi
        End If
        
    Next i
    
    If nSw = 0 Then
        MsgBox "Operación número " + Trim(TxtNumoper.text) + " modificada correctamente", 64
        'Actualizar el digitador
        'PRD-5149, 08-01-2010
        If Not ActualizaDigitador(nNumoper) Then
            MsgBox "No se pudo actualizar el digitador en la operación N° " + CStr(nNumoper), vbCritical, gsBac_Version
        End If
        'fin PRD-5149, 08-01-2010
        
    End If
    
    
    ValorN = " "
    ValorN = "Operacion:" & nNumoper & ";" & cTipOper & ";" & "Rut Cliente:" & nRutcli & ";Codigo Cliente:" & nCodcli & ";Forma de Pago Inicio:" & iForPagI & ";Forma de Pago Venc:" & iForPagV & ";Tasa Pacto:" & nTaspact
    Call COMPARA_VALORES(ValorA, ValorN)
'COLOCAR EL VALOR NUEVO
     
    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, _
     "BTR", "Opc_20900", "02", "Modificación.", "mdmo", ValorA, ValorN)
    
    
'    If Not funcModificaTesoreria(cTipOper, nNumdocu, nRutcli, Val(TxtCodCli.Text), BacFormatoSQL(Val(FValorOp.Text)), "$$", "", cmbFPagoIni.ItemData(cmbFPagoIni.ListIndex), "", Val(Rutcart)) Then
'        GoTo BacErrorModi
'    End If
    
  ' Excluyo operaciones OverNight de calculo de limites
    
    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        GoTo BacErrorModi
    End If
    
    If ImprimeModificacionPapeleta(Rutcart, CStr(nNumoper), cTipOper) = "NO" Then
        MsgBox "Problemas en impresión de papeleta de modificación", vbExclamation, gsBac_Version
    End If

    Call LimpiaMod
    Screen.MousePointer = 0
    
    Exit Function
    
    
BacErrorModi:
    MsgBox "No se pudo completar modificación de operaciones satisfactoriamente: " & err.Description & ". Comunique al Administrador.", vbCritical, gsBac_Version
    If FlagTx = True Then
        If miSQL.SQL_Execute("ROLLBACK TRANSACTION") <> 0 Then
             MsgBox "NO SE PUDO REALIZAR ROLLBACK", vbExclamation, gsBac_Version
        End If
    End If
    Exit Function
   
ErrModi:
    MsgBox "Problemas en modificación de operación: " & err.Description & ". Verifique.", vbCritical, gsBac_Version
    Exit Function
    
End Function
Private Sub TxtCodCli_KeyPress(KeyAscii As Integer)
    
    BacCaracterNumerico KeyAscii


End Sub

Private Sub TxtCodCli_LostFocus()
   
   If Val(txtRutCli.text) <> 0 Then
        Call ObjCliente.LeerPorRut(txtRutCli.text, txtDigCli.text, 0, Val(TxtCodCli.text))
            If ObjCliente.clrut = 0 Then
                MsgBox "Cliente no existe, verifique información", vbExclamation, gsBac_Version
                txtRutCli.text = ""
                txtDigCli.text = ""
                TxtCodCli.text = ""
                txtRutCli.SetFocus
            Else
                txtDigCli.text = ObjCliente.cldv
                TxtNomCli.text = ObjCliente.clnombre
                TxtCodCli.text = ObjCliente.clcodigo
            End If
    End If
    
End Sub


Private Sub txtDigCli_KeyPress(KeyAscii As Integer)

    If (KeyAscii < Asc("0") And KeyAscii > Asc("9")) Then
        If KeyAscii <> Asc("k") Or KeyAscii <> Asc("K") Then
            KeyAscii = 0
        End If
    End If
    BacToUCase KeyAscii

End Sub


Private Sub TxtNomCli_KeyPress(KeyAscii As Integer)
Dim cMensaje As String
    BacToUCase KeyAscii
    
    If KeyAscii = 13 Then
        cMensaje = TxtNomCli.text
        If Len(Trim$(TxtNomCli.text)) = 0 Then Exit Sub
        txtRutCli.text = ""
        TxtCodCli.text = ""
        TxtNomCli.text = cMensaje

    End If

End Sub


Private Sub TxtNumoper_GotFocus()
    Call LimpiaMod
End Sub

Private Sub TxtNumoper_KeyPress(KeyAscii As Integer)
     BacToUCase KeyAscii
     If KeyAscii = 13 Then
        TxtNomCli.SetFocus
     End If

     If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 8 Then
        KeyAscii = 0
     End If
     
End Sub


Private Sub TxtNumoper_LostFocus()

    If Val(TxtNumoper.text) <> 0 Then
        Screen.MousePointer = 11
        BacControlWindows 12
        Call Llena_Grilla
        
        Screen.MousePointer = 0
    End If

End Sub


Private Sub txtRutCli_Change()
    
    TxtNomCli.text = ""
    txtDigCli.text = ""
    TxtCodCli.text = ""

End Sub



Private Sub txtRutCli_DblClick()
On Error GoTo Label1

    Me.MousePointer = 11
    BacAyuda.Tag = "MDCL"
    BacAyuda.Show 1
   
    If giAceptar% = True Then
        txtRutCli.text = Val(gsrut$)
        txtDigCli.text = gsDigito$
        TxtCodCli.text = gsvalor$
        SendKeys "{ENTER}"

    End If
    Me.MousePointer = 0
    
    Exit Sub

Label1:
    Call objMensajesCL.BacMsgError

End Sub


Private Sub txtRutCli_KeyPress(KeyAscii As Integer)
    BacCaracterNumerico KeyAscii
End Sub


Private Sub txtRutCli_LostFocus()

    If Val(txtRutCli.text) > 0 And txtDigCli.text <> "" Then
        Call ObjCliente.LeerPorRut(txtRutCli.text, txtDigCli.text, 0, TxtCodCli.text)
        If ObjCliente.clrut = 0 Then
            txtRutCli.text = ""
            txtDigCli.text = ""
        Else
            txtDigCli.text = ObjCliente.cldv
            TxtNomCli.text = ObjCliente.clnombre
        End If
    End If

End Sub


