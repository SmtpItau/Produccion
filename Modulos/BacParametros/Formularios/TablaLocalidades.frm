VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Begin VB.Form TablaLocalidades 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Localidades"
   ClientHeight    =   2850
   ClientLeft      =   1590
   ClientTop       =   2775
   ClientWidth     =   6105
   Icon            =   "TablaLocalidades.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2850
   ScaleWidth      =   6105
   Begin Threed.SSPanel SSPanel1 
      Height          =   2355
      Left            =   0
      TabIndex        =   0
      Top             =   495
      Width           =   6120
      _Version        =   65536
      _ExtentX        =   10795
      _ExtentY        =   4154
      _StockProps     =   15
      Caption         =   "SSPanel1"
      BackColor       =   -2147483644
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
      Begin TabDlg.SSTab SSTab1 
         Height          =   2160
         Left            =   120
         TabIndex        =   2
         Top             =   120
         Width           =   5925
         _ExtentX        =   10451
         _ExtentY        =   3810
         _Version        =   393216
         MousePointer    =   99
         Tabs            =   5
         TabsPerRow      =   6
         TabHeight       =   520
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         TabCaption(0)   =   "Pais"
         TabPicture(0)   =   "TablaLocalidades.frx":030A
         Tab(0).ControlEnabled=   -1  'True
         Tab(0).Control(0)=   "SSFrame1"
         Tab(0).Control(0).Enabled=   0   'False
         Tab(0).ControlCount=   1
         TabCaption(1)   =   "Region"
         TabPicture(1)   =   "TablaLocalidades.frx":0326
         Tab(1).ControlEnabled=   0   'False
         Tab(1).Control(0)=   "SSFrame2"
         Tab(1).ControlCount=   1
         TabCaption(2)   =   "Ciudad"
         TabPicture(2)   =   "TablaLocalidades.frx":0342
         Tab(2).ControlEnabled=   0   'False
         Tab(2).Control(0)=   "SSFrame3"
         Tab(2).ControlCount=   1
         TabCaption(3)   =   "Comuna"
         TabPicture(3)   =   "TablaLocalidades.frx":035E
         Tab(3).ControlEnabled=   0   'False
         Tab(3).Control(0)=   "SSFrame4"
         Tab(3).Control(1)=   "LblCodCiudad"
         Tab(3).ControlCount=   2
         TabCaption(4)   =   "Plaza"
         TabPicture(4)   =   "TablaLocalidades.frx":037A
         Tab(4).ControlEnabled=   0   'False
         Tab(4).Control(0)=   "SSFrame5"
         Tab(4).ControlCount=   1
         Begin Threed.SSFrame SSFrame5 
            Height          =   1725
            Left            =   -74910
            TabIndex        =   33
            Top             =   345
            Width           =   5745
            _Version        =   65536
            _ExtentX        =   10134
            _ExtentY        =   3043
            _StockProps     =   14
            Caption         =   "Mantención de Plaza"
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
            Font3D          =   1
            Begin VB.TextBox TXTNOMPLA 
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
               Left            =   1605
               MaxLength       =   50
               TabIndex        =   37
               TabStop         =   0   'False
               Top             =   975
               Width           =   4065
            End
            Begin VB.TextBox txtCODPLA 
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
               Left            =   1605
               MaxLength       =   5
               MouseIcon       =   "TablaLocalidades.frx":0396
               MousePointer    =   99  'Custom
               TabIndex        =   36
               TabStop         =   0   'False
               Top             =   315
               Width           =   1545
            End
            Begin VB.TextBox TXTCODPAI 
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
               Left            =   1605
               MaxLength       =   5
               TabIndex        =   35
               TabStop         =   0   'False
               Top             =   1320
               Width           =   1275
            End
            Begin VB.TextBox txtGlo 
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
               Left            =   1605
               MaxLength       =   10
               TabIndex        =   34
               TabStop         =   0   'False
               Top             =   645
               Width           =   2220
            End
            Begin VB.Label LabNOMPAI 
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
               Height          =   300
               Left            =   2895
               TabIndex        =   42
               Top             =   1320
               Width           =   2775
            End
            Begin VB.Label Label3 
               AutoSize        =   -1  'True
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
               Height          =   195
               Left            =   165
               TabIndex        =   41
               Top             =   975
               Width           =   660
            End
            Begin VB.Label Label4 
               AutoSize        =   -1  'True
               Caption         =   "Codigo Pais"
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
               Left            =   165
               TabIndex        =   40
               Top             =   1320
               Width           =   1020
            End
            Begin VB.Label Label5 
               AutoSize        =   -1  'True
               Caption         =   "Código Plaza"
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
               Left            =   165
               TabIndex        =   39
               Top             =   300
               Width           =   1125
            End
            Begin VB.Label Label2 
               AutoSize        =   -1  'True
               Caption         =   "Glosa"
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
               Left            =   150
               TabIndex        =   38
               Top             =   630
               Width           =   495
            End
         End
         Begin Threed.SSFrame SSFrame4 
            Height          =   1725
            Left            =   -74895
            TabIndex        =   25
            Top             =   345
            Width           =   5730
            _Version        =   65536
            _ExtentX        =   10107
            _ExtentY        =   3043
            _StockProps     =   14
            Caption         =   "Mantención de Comunas"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Font3D          =   1
            Begin VB.TextBox TxtCodCiudad1 
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
               Left            =   1605
               MaxLength       =   5
               TabIndex        =   28
               TabStop         =   0   'False
               Top             =   1050
               Width           =   1275
            End
            Begin VB.TextBox TxtCodigoComuna 
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
               Left            =   1605
               MaxLength       =   5
               MouseIcon       =   "TablaLocalidades.frx":06A0
               MousePointer    =   99  'Custom
               TabIndex        =   27
               TabStop         =   0   'False
               Top             =   375
               Width           =   1545
            End
            Begin VB.TextBox TxtNombreComuna 
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
               Left            =   1605
               MaxLength       =   50
               TabIndex        =   26
               TabStop         =   0   'False
               Top             =   720
               Width           =   4065
            End
            Begin VB.Label Label17 
               AutoSize        =   -1  'True
               Caption         =   "Código Comuna"
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
               Left            =   165
               TabIndex        =   32
               Top             =   360
               Width           =   1335
            End
            Begin VB.Label Label16 
               AutoSize        =   -1  'True
               Caption         =   "Ciudad"
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
               Left            =   165
               TabIndex        =   31
               Top             =   1065
               Width           =   600
            End
            Begin VB.Label Label15 
               AutoSize        =   -1  'True
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
               Height          =   195
               Left            =   165
               TabIndex        =   30
               Top             =   720
               Width           =   660
            End
            Begin VB.Label LABCIU 
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
               Height          =   300
               Left            =   2895
               TabIndex        =   29
               Top             =   1050
               Width           =   2775
            End
         End
         Begin Threed.SSFrame SSFrame3 
            Height          =   1725
            Left            =   -74895
            TabIndex        =   17
            Top             =   345
            Width           =   5730
            _Version        =   65536
            _ExtentX        =   10107
            _ExtentY        =   3043
            _StockProps     =   14
            Caption         =   "Mantencion de Ciudades"
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
            Font3D          =   1
            Begin VB.TextBox TxtCodRegion1 
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
               Left            =   1530
               MaxLength       =   5
               TabIndex        =   20
               TabStop         =   0   'False
               Top             =   990
               Width           =   1215
            End
            Begin VB.TextBox TxtNombreCiudad 
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
               Left            =   1530
               MaxLength       =   50
               TabIndex        =   19
               TabStop         =   0   'False
               Top             =   675
               Width           =   3825
            End
            Begin VB.TextBox TxtCodigoCiudad 
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
               Left            =   1530
               MaxLength       =   5
               MouseIcon       =   "TablaLocalidades.frx":09AA
               MousePointer    =   99  'Custom
               TabIndex        =   18
               TabStop         =   0   'False
               Top             =   345
               Width           =   1695
            End
            Begin VB.Label LabCodReg 
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
               Height          =   300
               Left            =   2790
               TabIndex        =   24
               Top             =   990
               Width           =   2565
            End
            Begin VB.Label Label13 
               AutoSize        =   -1  'True
               BackColor       =   &H00C0C0C0&
               BackStyle       =   0  'Transparent
               Caption         =   "Región"
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
               Left            =   150
               TabIndex        =   23
               Top             =   990
               Width           =   615
            End
            Begin VB.Label Label6 
               AutoSize        =   -1  'True
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
               Height          =   195
               Left            =   150
               TabIndex        =   22
               Top             =   675
               Width           =   660
            End
            Begin VB.Label Label7 
               AutoSize        =   -1  'True
               Caption         =   "Código Ciudad"
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
               Left            =   150
               TabIndex        =   21
               Top             =   345
               Width           =   1245
            End
         End
         Begin Threed.SSFrame SSFrame2 
            Height          =   1725
            Left            =   -74895
            TabIndex        =   9
            Top             =   345
            Width           =   5730
            _Version        =   65536
            _ExtentX        =   10107
            _ExtentY        =   3043
            _StockProps     =   14
            Caption         =   "Mantencion de Regiones"
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
            Font3D          =   1
            Begin VB.TextBox TxtCodPais 
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
               Left            =   1515
               MaxLength       =   5
               TabIndex        =   12
               TabStop         =   0   'False
               Top             =   990
               Width           =   1305
            End
            Begin VB.TextBox TxtCodigoRegion 
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
               Left            =   1515
               MaxLength       =   5
               MouseIcon       =   "TablaLocalidades.frx":0CB4
               TabIndex        =   11
               TabStop         =   0   'False
               Top             =   330
               Width           =   1305
            End
            Begin VB.TextBox TxtNombreRegion 
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
               Left            =   1515
               MaxLength       =   50
               TabIndex        =   10
               TabStop         =   0   'False
               Top             =   660
               Width           =   3885
            End
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               BackColor       =   &H00C0C0C0&
               BackStyle       =   0  'Transparent
               Caption         =   "Código País"
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
               Left            =   165
               TabIndex        =   16
               Top             =   990
               Width           =   1050
            End
            Begin VB.Label LabDesPais 
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
               Left            =   2835
               TabIndex        =   15
               Top             =   990
               Width           =   2565
            End
            Begin VB.Label Label9 
               AutoSize        =   -1  'True
               BackColor       =   &H00C0C0C0&
               BackStyle       =   0  'Transparent
               Caption         =   "Código Región"
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
               Left            =   165
               TabIndex        =   14
               Top             =   330
               Width           =   1260
            End
            Begin VB.Label Label8 
               AutoSize        =   -1  'True
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
               Height          =   195
               Left            =   165
               TabIndex        =   13
               Top             =   660
               Width           =   660
            End
         End
         Begin Threed.SSFrame SSFrame1 
            Height          =   1710
            Left            =   90
            TabIndex        =   4
            Top             =   360
            Width           =   5745
            _Version        =   65536
            _ExtentX        =   10134
            _ExtentY        =   3016
            _StockProps     =   14
            Caption         =   "Mantencion de Pais"
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
            Font3D          =   1
            Begin VB.TextBox TxtCodSwift 
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
               Left            =   1730
               MaxLength       =   2
               TabIndex        =   46
               Top             =   1305
               Width           =   510
            End
            Begin VB.TextBox txtnumCodigoBcch 
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
               Left            =   1730
               TabIndex        =   43
               Top             =   975
               Width           =   1575
            End
            Begin VB.TextBox TxtNombre 
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
               Left            =   1730
               MaxLength       =   50
               TabIndex        =   6
               TabStop         =   0   'False
               Top             =   645
               Width           =   3615
            End
            Begin VB.TextBox TxTCodigoPais 
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
               Left            =   1730
               MaxLength       =   5
               MouseIcon       =   "TablaLocalidades.frx":0FBE
               MousePointer    =   99  'Custom
               TabIndex        =   5
               TabStop         =   0   'False
               Top             =   315
               Width           =   1605
            End
            Begin VB.Label Label14 
               Caption         =   "Codigo SWIFT"
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
               Left            =   120
               TabIndex        =   45
               Top             =   1335
               Width           =   1275
            End
            Begin VB.Label Label12 
               Caption         =   "Codigo BCCH"
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
               Left            =   120
               TabIndex        =   44
               Top             =   1035
               Width           =   1215
            End
            Begin VB.Label Label11 
               AutoSize        =   -1  'True
               BackColor       =   &H00C0C0C0&
               BackStyle       =   0  'Transparent
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
               ForeColor       =   &H00800000&
               Height          =   195
               Left            =   135
               TabIndex        =   8
               Top             =   315
               Width           =   600
            End
            Begin VB.Label Label10 
               AutoSize        =   -1  'True
               BackColor       =   &H00C0C0C0&
               BackStyle       =   0  'Transparent
               Caption         =   "Nombre "
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
               Height          =   210
               Left            =   135
               TabIndex        =   7
               Top             =   690
               Width           =   720
            End
         End
         Begin VB.Label LblCodCiudad 
            BorderStyle     =   1  'Fixed Single
            Height          =   555
            Left            =   -68370
            TabIndex        =   3
            Top             =   690
            Visible         =   0   'False
            Width           =   465
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2760
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "TablaLocalidades.frx":12C8
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "TablaLocalidades.frx":171A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "TablaLocalidades.frx":1B6C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "TablaLocalidades.frx":1E86
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   6105
      _ExtentX        =   10769
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Nuevo"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "TablaLocalidades"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub CmdAyudaPais_LostFocus()
Dim Datos()
    
    If Not Bac_Sql_Execute("SP_MOSTRAR_PAIS") Then
        Exit Sub
    End If
    If Trim(TxTCodigoPais.Text) <> "" Then
        Do While Bac_SQL_Fetch(Datos())
            If Me.TxTCodigoPais.Text = Datos(1) Then
                Me.txtNombre.Text = Datos(2)
                Exit Do
            End If
        Loop
    End If
End Sub


Private Sub CmdAyudaPais1_LostFocus()
Dim Datos()
    
    If Not Bac_Sql_Execute("SP_MOSTRAR_PAIS") Then
        Exit Sub
    End If
    If Trim(txtcodpais.Text) <> "" Then
        Do While Bac_SQL_Fetch(Datos())
            If Me.txtcodpais.Text = Datos(2) Then
                Exit Do
            End If
        Loop
    End If
End Sub


Private Sub CmdAyudaRegion_LostFocus()
Dim Datos()
    
    If Not Bac_Sql_Execute("SP_MOSTRAR_REGION") Then
        Exit Sub
    End If
    If Trim(TxtCodigoRegion.Text) <> "" Then
        Do While Bac_SQL_Fetch(Datos())
            If Me.TxtCodigoRegion.Text = Datos(1) Then
               Me.txtcodpais.Text = Datos(2)
               Me.TxtNombreRegion.Text = Datos(3)
               Exit Do
            End If
        Loop
    End If
End Sub



Private Sub CmdAyudaRuta_Click()
    BacAyuda.Tag = "Ruta"
    BacAyuda.Show
End Sub


Private Sub CmdAyudaSector_Click()
    BacAyuda.Tag = "Sector"
    BacAyuda.Show
End Sub






Private Sub Form_Activate()
    If giAceptar = True Then
        
        If Indica_Tag = "Pais" Then Me.TxTCodigoPais = RETORNOAYUDA: Call TxTCodigoPais_LostFocus
        If Indica_Tag = "Region" Then Me.TxtCodigoRegion = RETORNOAYUDA: Call TxtCodigoRegion_LostFocus
        If Indica_Tag = "Ciudad" Then Me.TxtCodigoCiudad = RETORNOAYUDA: Call TxtCodigoCiudad_LostFocus
        If Indica_Tag = "Comuna" Then Me.TxtCodigoComuna = RETORNOAYUDA: Call TxtCodigoComuna_LostFocus
        'If Indica_Tag = "Sector" Then Me.TxtCodigoSector = RetornoAyuda: Call CmdAyudaSector_LostFocus
        'If Indica_Tag = "Ruta" Then Me.TxtCodigoRuta = RetornoAyuda: Call CmdAyudaRuta_LostFocus
        If Indica_Tag = "Ciudad1" Then Me.TxtCodCiudad1 = RETORNOAYUDA: Call TxtCodCiudad1_LostFocus
        If Indica_Tag = "Pais1" Then Me.txtcodpais = RETORNOAYUDA: Call txtcodpais_LostFocus
        If Indica_Tag = "Region1" Then Me.TxtCodRegion1 = RETORNOAYUDA: Call TxtCodRegion1_LostFocus
        
    End If
End Sub

Private Sub Form_Load()
    Me.Top = 1
    Me.Left = 15
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_780" _
                          , "07" _
                          , "INGRESO A OPCION DE MENU" _
                          , " " _
                          , " " _
                          , " ")
    
    SSTab1.Tab = 0
    SSTab1.TabEnabled(0) = True
    SSTab1.TabEnabled(1) = False
    SSTab1.TabEnabled(2) = False
    SSTab1.TabEnabled(3) = False
    SSTab1.TabEnabled(4) = False
    
End Sub


'******************CARGA COMBOS****************
Private Sub SSTab1_Click(PreviousTab As Integer)
   ' Limpiar
End Sub

Private Sub SSTab1_KeyDown(KeyCode As Integer, Shift As Integer)
    
    If KeyCode = 13 Then
        If SSTab1.Tab = 0 Then
            TxTCodigoPais.SetFocus
        ElseIf SSTab1.Tab = 1 Then
            TxtCodigoRegion.SetFocus
        ElseIf SSTab1.Tab = 2 Then
            TxtCodigoCiudad.SetFocus
        ElseIf SSTab1.Tab = 3 Then
            TxtCodigoComuna.SetFocus
        ElseIf SSTab1.Tab = 4 Then
            txtCODPLA.SetFocus
        End If
    End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Key
        Case Is = "Salir"
            Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_780" _
                          , "08" _
                          , "SALIR OPCION DE MENU" _
                          , " " _
                          , " " _
                          , " ")
            Unload Me
        Case Is = "Grabar"
            If Me.SSTab1.Caption = "Pais" Then
                If TxTCodigoPais.Text = "" Or txtNombre.Text = "" Then Exit Sub
                If Not FUNC_GRABA_PAIS() Then Exit Sub
            End If
            
            If Me.SSTab1.Caption = "Region" Then
                If TxtCodigoRegion.Text = "" Or TxtNombreRegion.Text = "" Then Exit Sub
                If Not FUNC_VALIDA_PAIS() Then Exit Sub
            End If
            If Me.SSTab1.Caption = "Ciudad" Then
                If TxtCodigoCiudad.Text = "" Or TxtNombreCiudad.Text = "" Then Exit Sub
                If Not FUNC_VALIDA_REGION() Then Exit Sub
            End If
            If Me.SSTab1.Caption = "Comuna" Then
                If TxtCodigoComuna.Text = "" Or TxtNombreComuna.Text = "" Then Exit Sub
                If Not FUNC_VALIDA_CIUDAD() Then Exit Sub
            End If
            If Me.SSTab1.Caption = "Plaza" Then
                If txtCODPLA.Text = "" Or TXTNOMPLA.Text = "" Then Exit Sub
                If Not FUNC_VALIDA_PAIS1() Then Exit Sub
            End If
            'If Me.SSTab1.Caption = "Ruta" Then
            '    If TxtCodigoRuta.Text = "" Or TxtNombreRuta.Text = "" Then Exit Sub
            '    If Not FUNC_GRABA_RUTA() Then Exit Sub
            'End If
             Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_780" _
                          , "01" _
                          , "GRABAR" _
                          , Me.SSTab1.Caption _
                          , " " _
                          , " ")
                          
        Case Is = "Nuevo"
            
            TxTCodigoPais.Text = ""
            TxtCodigoRegion.Text = ""
            TxtCodigoCiudad.Text = ""
            TxtCodigoComuna.Text = ""
            txtnumCodigoBcch.Text = ""
            txtCodSwift.Text = ""
            txtCODPLA.Text = ""
            If SSTab1.Tab = 0 Then
                TxTCodigoPais.SetFocus
            ElseIf SSTab1.Tab = 1 Then
                TxtCodigoRegion.SetFocus
            ElseIf SSTab1.Tab = 2 Then
                TxtCodigoCiudad.SetFocus
            ElseIf SSTab1.Tab = 3 Then
                TxtCodigoComuna.SetFocus
            ElseIf SSTab1.Tab = 4 Then
                txtCODPLA.SetFocus
            End If
            
            SSTab1.Tab = 0
            SSTab1.TabEnabled(0) = True
            SSTab1.TabEnabled(1) = False
            SSTab1.TabEnabled(2) = False
            SSTab1.TabEnabled(3) = False
            SSTab1.TabEnabled(4) = False

                
        Case Is = "Eliminar"
            If Me.SSTab1.Caption = "Pais" Then
                If TxTCodigoPais.Text = "" Or txtNombre.Text = "" Then Exit Sub
                If Not FUNC_ELIMINA_PAIS() Then Exit Sub
            End If
            If Me.SSTab1.Caption = "Region" Then
                If TxtCodigoRegion.Text = "" Or TxtNombreRegion.Text = "" Then Exit Sub
                If Not FUNC_ELIMINA_REGION() Then Exit Sub
            End If
            If Me.SSTab1.Caption = "Ciudad" Then
                If TxtCodigoCiudad.Text = "" Or TxtNombreCiudad.Text = "" Then Exit Sub
                If Not FUNC_ELIMINA_CIUDAD() Then Exit Sub
            End If
            If Me.SSTab1.Caption = "Comuna" Then
                If TxtCodigoComuna.Text = "" Or TxtNombreComuna.Text = "" Then Exit Sub
                If Not FUNC_ELIMINA_COMUNA() Then Exit Sub
            End If
            If Me.SSTab1.Caption = "Plaza" Then
                If txtCODPLA.Text = "" Or TXTNOMPLA.Text = "" Then Exit Sub
                If Not FUNC_ELIMINA_PLAZA() Then Exit Sub
            End If
            Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_780" _
                          , "03" _
                          , "ELIMINA" _
                          , Me.SSTab1.Caption _
                          , " " _
                          , " ")
    End Select
End Sub

'*********************Inicio validaciones************************************
'Valida selección de País en módulo de Región
Function FUNC_VALIDA_PAIS1()
Dim Datos()
FUNC_VALIDA_PAIS1 = False

Envia = Array()
AddParam Envia, TXTCODPAI

'Comando$ = Comando$ + "'" + TxtCodigoRegion + "'"

If Not Bac_Sql_Execute("SP_TABLALOCALIDADES_VALIDA_PAIS", Envia) Then Exit Function
Do While Bac_SQL_Fetch(Datos())
   If Datos(1) = "NO EXISTE" Then MsgBox "Codigo País No Existe", vbCritical, TITSISTEMA
      txtcodpais.SetFocus
      Exit Function
Loop
FUNC_VALIDA_PAIS1 = True
If Not FUNC_GRABA_Plaza() Then Exit Function
End Function

'Valida selección de País en módulo de Región
Function FUNC_VALIDA_PAIS()
Dim Datos()
FUNC_VALIDA_PAIS = False

Envia = Array()
AddParam Envia, txtcodpais
'Comando$ = Comando$ + "'" + TxtCodigoRegion + "'"

If Not Bac_Sql_Execute("SP_TABLALOCALIDADES_VALIDA_PAIS", Envia) Then Exit Function
Do While Bac_SQL_Fetch(Datos())
   If Datos(1) = "NO EXISTE" Then MsgBox "Codigo País No Existe", vbCritical, TITSISTEMA
      txtcodpais.SetFocus
      Exit Function
Loop
FUNC_VALIDA_PAIS = True
If Not FUNC_GRABA_REGION() Then Exit Function
End Function

'Valida seleccion de Region en módulo de ciudad
Function FUNC_VALIDA_REGION()
Dim Datos()
FUNC_VALIDA_REGION = False

Envia = Array()
AddParam Envia, TxtCodRegion1
               

If Not Bac_Sql_Execute("SP_TABLALOCALIDADES_VALIDA_REGION", Envia) Then Exit Function
Do While Bac_SQL_Fetch(Datos())
   If Datos(1) = "NO EXISTE" Then MsgBox ("Codigo Región No Existe"), vbCritical, TITSISTEMA
      TxtCodRegion1.SetFocus
      Exit Function
Loop
FUNC_VALIDA_REGION = True
If Not FUNC_GRABA_CIUDAD() Then Exit Function
End Function
'Valida la seleccion de ciudad en módulo de comuna
Function FUNC_VALIDA_CIUDAD()
Dim Datos()
FUNC_VALIDA_CIUDAD = False

Envia = Array()
AddParam Envia, TxtCodCiudad1

If Not Bac_Sql_Execute("SP_TABLALOCALIDADES_VALIDA_CIUDAD", Envia) Then Exit Function
Do While Bac_SQL_Fetch(Datos())
   If Datos(1) = "NO EXISTE" Then MsgBox "Codigo Ciudad No Existe", vbCritical, TITSISTEMA
      TxtCodCiudad1.SetFocus
      Exit Function
Loop
FUNC_VALIDA_CIUDAD = True
If Not FUNC_GRABA_COMUNA() Then Exit Function
End Function
'*********************Fin Validaciones******************************************

'*************************************************************************
'*******************SECCION DE FUNCIONES DE GRABADO***********************
'*************************************************************************

'Función que graba paises y llama a refrescar combo
Function FUNC_GRABA_PAIS() As Boolean
Dim Datos()
FUNC_GRABA_PAIS = False

Envia = Array()

AddParam Envia, TxTCodigoPais
AddParam Envia, txtNombre
AddParam Envia, txtnumCodigoBcch.Text
AddParam Envia, txtCodSwift.Text
         

If Not Bac_Sql_Execute("SP_TABLALOCALIDADES_AGREGAR_PAIS ", Envia) Then Exit Function
  Do While Bac_SQL_Fetch(Datos())
    Select Case Datos(1)
        Case Is = "ERROR"
               Case Is = "EXISTE"
               MsgBox "Ciudad Ya Existe", vbCritical, TITSISTEMA
               Limpiar
               TxtCodigoCiudad.SetFocus
               Exit Function
        End Select
    Loop
Beep
MsgBox " Información Grabada...", vbInformation, TITSISTEMA
Limpiar
End Function
'Función que graba Plaza y llama a refrescar combo
Function FUNC_GRABA_Plaza() As Boolean
Dim Datos()
FUNC_GRABA_Plaza = False

Envia = Array()

AddParam Envia, txtCODPLA
AddParam Envia, txtGlo
AddParam Envia, TXTNOMPLA
AddParam Envia, TXTCODPAI
             


If Not Bac_Sql_Execute("SP_TABLALOCALIDADES_AGREGAR_PLAZA ", Envia) Then Exit Function
Do While Bac_SQL_Fetch(Datos())
    Select Case Datos(1)
        Case Is = "ERROR"
               Case Is = "EXISTE"
               MsgBox "Plaza Ya Existe", vbCritical, TITSISTEMA
               Limpiar
               txtCODPLA.SetFocus
               Exit Function
        End Select
    Loop
Beep
MsgBox " Información Grabada...", vbInformation, TITSISTEMA
Limpiar
FUNC_GRABA_Plaza = True
End Function


'Función que graba regiones y llama a refrescar combo
Function FUNC_GRABA_REGION() As Boolean
Dim Datos()
FUNC_GRABA_REGION = False

Envia = Array()
AddParam Envia, TxtCodigoRegion
AddParam Envia, txtcodpais
AddParam Envia, TxtNombreRegion
             

If Not Bac_Sql_Execute("SP_TABLALOCALIDADES_AGREGAR_REGION ", Envia) Then Exit Function
Do While Bac_SQL_Fetch(Datos())
    Select Case Datos(1)
        Case Is = "ERROR"
               Case Is = "EXISTE"
               MsgBox "Región Ya Existe", vbCritical, TITSISTEMA
               Limpiar
               TxtCodigoRegion.SetFocus
               Exit Function
        End Select
    Loop
    
If Not Bac_Sql_Execute("SP_MNTPAIS_ACTUALIZA_CIUDAD_COMUNAS") Then Exit Function
    
Beep
MsgBox " Información Grabada...", vbInformation, TITSISTEMA
Limpiar
FUNC_GRABA_REGION = True
End Function

'Función que graba ciudades y llama a refrescar combo
Function FUNC_GRABA_CIUDAD() As Boolean
Dim Datos()
FUNC_GRABA_CIUDAD = False

Envia = Array()
AddParam Envia, TxtCodigoCiudad
AddParam Envia, TxtCodRegion1
AddParam Envia, TxtNombreCiudad


If Not Bac_Sql_Execute("SP_TABLALOCALIDADES_AGREGAR_CIUDAD", Envia) Then Exit Function
Do While Bac_SQL_Fetch(Datos())
    Select Case Datos(1)
        Case Is = "ERROR"
               Case Is = "EXISTE"
               MsgBox "Ciudad Ya Existe", vbCritical, TITSISTEMA
               Limpiar
               TxtCodigoCiudad.SetFocus
               Exit Function
        End Select
    Loop
    
If Not Bac_Sql_Execute("SP_MNTPAIS_ACTUALIZA_CIUDAD_COMUNAS") Then Exit Function
    
Beep
MsgBox " Información Grabada...", vbInformation, TITSISTEMA
Limpiar
FUNC_GRABA_CIUDAD = True
End Function

'Función que graba comuna y llama a refrescar combo
Function FUNC_GRABA_COMUNA() As Boolean
Dim Datos()
FUNC_GRABA_COMUNA = False

Envia = Array()
AddParam Envia, TxtCodigoComuna
AddParam Envia, TxtCodCiudad1
AddParam Envia, TxtNombreComuna

If Not Bac_Sql_Execute("SP_TABLALOCALIDADES_AGREGAR_COMUNA", Envia) Then Exit Function
Do While Bac_SQL_Fetch(Datos())
    Select Case Datos(1)
        Case Is = "ERROR"
               Case Is = "EXISTE"
               MsgBox "Comuna Ya Existe", vbCritical, TITSISTEMA
               Limpiar
               TxtCodigoComuna.SetFocus
               Exit Function
        End Select
    Loop
    
    
If Not Bac_Sql_Execute("SP_MNTPAIS_ACTUALIZA_CIUDAD_COMUNAS") Then Exit Function
    
Beep
MsgBox " Información Grabada...", vbInformation, TITSISTEMA
Limpiar
FUNC_GRABA_COMUNA = True





End Function

'Función que graba sector y llama a refrescar combo
Function FUNC_GRABA_SECTOR() As Boolean
Dim Datos()
FUNC_GRABA_SECTOR = False

Envia = Array()
AddParam Envia, TxtCodigoSector
AddParam Envia, TxtNombreSector

If Not Bac_Sql_Execute("SP_TABLALOCALIDADES_AGREGAR_SECTOR", Envia) Then Exit Function
Do While Bac_SQL_Fetch(Datos())
    Select Case Datos(1)
        Case Is = "ERROR"
               Case Is = "EXISTE"
               MsgBox "Sector Ya Existe", vbCritical, TITSISTEMA
               Limpiar
               TxtCodigoSector.SetFocus
               Exit Function
        End Select
    Loop
Beep
MsgBox " Información Grabada...", vbInformation, TITSISTEMA
Limpiar
FUNC_GRABA_SECTOR = True
End Function


'Función que graba ruta y llama a refrescar combo
Function FUNC_GRABA_RUTA() As Boolean
Dim Datos()
FUNC_GRABA_RUTA = False

Envia = Array()
AddParam Envia, TxtCodigoRuta
AddParam Envia, TxtNombreRuta

If Not Bac_Sql_Execute("SP_TABLALOCALIDADES_AGREGAR_RUTA", Envia) Then Exit Function
Do While Bac_SQL_Fetch(Datos())
    Select Case Datos(1)
        Case Is = "ERROR"
               Case Is = "EXISTE"
               MsgBox "Ruta Ya Existe", vbCritical, TITSISTEMA
               Limpiar
               TxtCodigoRuta.SetFocus
               Exit Function
        End Select
    Loop
Beep
MsgBox "Información Grabada...", vbInformation, TITSISTEMA
Limpiar
FUNC_GRABA_RUTA = True
End Function
'****************************************************************************
'**************************ELIMINA DATOS DE TABLA****************************
'****************************************************************************

Function FUNC_ELIMINA_PAIS() As Boolean
Dim Datos()
FUNC_ELIMINA_PAIS = False

Envia = Array()
AddParam Envia, TxTCodigoPais
AddParam Envia, txtNombre

If Not Bac_Sql_Execute("SP_TABLALOCALIDADES_ELIMINAR_PAIS ", Envia) Then Exit Function
Do While Bac_SQL_Fetch(Datos())
   If Datos(1) = "RELACIONADA" Then MsgBox "No se Puede Eliminar El País, Esta Relacionado", vbCritical, TITSISTEMA
   If Datos(1) = "NO EXISTE" Then MsgBox "País No Existe", vbCritical, TITSISTEMA
      Limpiar
      TxTCodigoPais.SetFocus
      Exit Function
Loop
MsgBox "Información Eliminada...", vbInformation, TITSISTEMA
Limpiar
FUNC_ELIMINA_PAIS = True
End Function

Function FUNC_ELIMINA_REGION() As Boolean
Dim Datos()
FUNC_ELIMINA_REGION = False

Envia = Array()
AddParam Envia, TxtCodigoRegion
AddParam Envia, TxtNombreRegion


If Not Bac_Sql_Execute("SP_TABLALOCALIDADES_ELIMINAR_REGION ", Envia) Then Exit Function
Do While Bac_SQL_Fetch(Datos())
   If Datos(1) = "RELACIONADA" Then MsgBox "No se Puede Eliminar Región, Está Relacionada", vbCritical, TITSISTEMA
   If Datos(1) = "NO EXISTE" Then MsgBox "Región No Existe", vbCritical, TITSISTEMA
      Limpiar
      TxtCodigoRegion.SetFocus
      Exit Function
Loop
MsgBox "Información Eliminada...", vbInformation, TITSISTEMA
Limpiar
FUNC_ELIMINA_REGION = True

End Function
Function FUNC_ELIMINA_PLAZA() As Boolean
Dim Datos()
FUNC_ELIMINA_PLAZA = False

Envia = Array()
AddParam Envia, txtCODPLA
'Comando$ = Comando$ + "'" + TxtNombreCiudad + "'"

If Not Bac_Sql_Execute("SP_TABLALOCALIDADES_ELIMINAR_PLAZA ", Envia) Then Exit Function
Do While Bac_SQL_Fetch(Datos())
   If Datos(1) = "RELACIONADA" Then MsgBox "No se Puede Eliminar Ciudad, Está Relacionada", vbCritical, TITSISTEMA
   If Datos(1) = "NO EXISTE" Then MsgBox "Región No Existe", vbCritical, TITSISTEMA
      Limpiar
      txtCODPLA.SetFocus
      Exit Function
Loop
MsgBox "Información Eliminada...", vbInformation, TITSISTEMA
Limpiar
FUNC_ELIMINA_PLAZA = True
End Function


Function FUNC_ELIMINA_CIUDAD() As Boolean
Dim Datos()
FUNC_ELIMINA_CIUDAD = False

Envia = Array()
AddParam Envia, TxtCodigoCiudad
AddParam Envia, TxtNombreCiudad

If Not Bac_Sql_Execute("SP_TABLALOCALIDADES_ELIMINAR_CIUDAD ", Envia) Then Exit Function
Do While Bac_SQL_Fetch(Datos())
   If Datos(1) = "RELACIONADA" Then MsgBox "No se Puede Eliminar Ciudad, Está Relacionada", vbCritical, TITSISTEMA
   If Datos(1) = "NO EXISTE" Then MsgBox "Región No Existe", vbCritical, TITSISTEMA
      Limpiar
      TxtCodigoCiudad.SetFocus
      Exit Function
Loop
MsgBox "Información Eliminada...", vbInformation, TITSISTEMA
Limpiar
FUNC_ELIMINA_CIUDAD = True
End Function

Function FUNC_ELIMINA_COMUNA() As Boolean
Dim Datos()
FUNC_ELIMINA_COMUNA = False

Envia = Array()
AddParam Envia, TxtCodigoComuna
AddParam Envia, TxtNombreComuna

If Not Bac_Sql_Execute("SP_TABLALOCALIDADES_ELIMINAR_COMUNA", Envia) Then Exit Function
Do While Bac_SQL_Fetch(Datos())
   If Datos(1) = "RELACIONADA" Then MsgBox "No se Puede Eliminar Comuna, Está Relacionada", vbCritical, TITSISTEMA
   If Datos(1) = "NO EXISTE" Then MsgBox "Comuna No Existe", vbCritical, TITSISTEMA
      Limpiar
      TxtCodigoComuna.SetFocus
      Exit Function
Loop
MsgBox "Información Eliminada...", vbInformation, TITSISTEMA
Limpiar
FUNC_ELIMINA_COMUNA = True
End Function

Function FUNC_ELIMINA_SECTOR() As Boolean
Dim Datos()
FUNC_ELIMINA_SECTOR = False

Envia = Array()
AddParam Envia, TxtCodigoSector
AddParam Envia, TxtNombreSector
            
If Not Bac_Sql_Execute("SP_TABLALOCALIDADES_ELIMINAR_SECTOR ", Envia) Then Exit Function
Do While Bac_SQL_Fetch(Datos())
   If Datos(1) = "RELACIONADA" Then MsgBox "No se Puede Eliminar Sector, Está Relacionada", vbCritical, TITSISTEMA
   If Datos(1) = "NO EXISTE" Then MsgBox "Sector No Existe", vbCritical, TITSISTEMA
      Limpiar
      TxtCodigoSector.SetFocus
      Exit Function
Loop
MsgBox "Información Eliminada...", vbInformation, TITSISTEMA
Limpiar
FUNC_ELIMINA_SECTOR = True
End Function

Function FUNC_ELIMINA_RUTA() As Boolean
Dim Datos()
FUNC_ELIMINA_RUTA = False

Envia = Array()
AddParam Envia, TxtCodigoRuta
AddParam Envia, TxtNombreRuta
             
             
If Not Bac_Sql_Execute("SP_TABLALOCALIDADES_ELIMINAR_RUTA ", Envia) Then Exit Function
Do While Bac_SQL_Fetch(Datos())
   If Datos(1) = "RELACIONADA" Then MsgBox "No se Puede Eliminar Ruta, Está Relacionada", vbCritical, TITSISTEMA
   If Datos(1) = "NO EXISTE" Then MsgBox "Ruta No Existe", vbCritical, TITSISTEMA
      Limpiar
      TxtCodigoRuta.SetFocus
      Exit Function
Loop
MsgBox "Información Eliminada...", vbInformation, TITSISTEMA
Limpiar
FUNC_ELIMINA_RUTA = True
End Function

'Control de errores
Sub ShowError()
  Dim sTmp As String
  Screen.MousePointer = vbDefault
  sTmp = "Ocurrió el siguiente error:" & vbCrLf & vbCrLf
  sTmp = sTmp & Err.Description & vbCrLf
  sTmp = sTmp & Msg1 & Err
  Beep
  MsgBox sTmp
End Sub



Private Sub TxtCodCiudad1_Change()
    LABCIU.Caption = ""
'    TxtCodigoComuna.Text = ""
'    TxtNombreComuna.Text = ""
End Sub

Private Sub TxtCodCiudad1_DblClick()
    
    BacAyuda.Tag = "CiudadMntLocalidades"
    BacAyuda.Show 1
    If giAceptar% = True Then
        TxtCodCiudad1.Text = RETORNOAYUDA
        Call TxtCodCiudad1_LostFocus
    End If
    
End Sub

Private Sub TxtCodCiudad1_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
    If KeyAscii = 13 Then Me.TxtCodigoComuna.SetFocus
End Sub

Private Sub TxtCodCiudad1_LostFocus()
    Dim Datos()
    
    If Not Bac_Sql_Execute("SP_MOSTRAR_CIUDAD") Then
        Exit Sub
    End If
    If Trim(TxtCodCiudad1.Text) <> "" Then
        Do While Bac_SQL_Fetch(Datos())
            If Me.TxtCodCiudad1.Text = Datos(1) Then
                LABCIU.Caption = Datos(3)
                Exit Do
            End If
        Loop
    End If
End Sub

Private Sub TxtCodigoCiudad_Change()
    'TxtCodigoCiudad.Text = ""
    LabCodReg.Caption = ""
    'TxtCodigoCiudad.Text = ""
    TxtNombreCiudad.Text = ""
    TxtCodRegion1.Text = ""
End Sub

Private Sub TxtCodigoCiudad_DblClick()
'    If Trim(LabCodReg.Caption) <> "" Then
'        PARAMETRO1 = TxtCodRegion1.Text
'        BacAyuda.Tag = "CiudadMntLocalidades1"
        BacAyuda.Tag = "CiudadMntLocalidades"
        BacAyuda.Show 1
        If giAceptar% = True Then
            TxtCodigoCiudad.Text = RETORNOAYUDA
            Call TxtCodigoCiudad_LostFocus
        End If
'    End If
End Sub

Private Sub TxtCodigoCiudad_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then TxtNombreCiudad.SetFocus: Exit Sub
'    If LabCodReg.Caption = "" Then
'        KeyAscii = 0
'    End If
End Sub

Private Sub TxtCodigoCiudad_LostFocus()
    Dim Datos()
    
    If Not Bac_Sql_Execute("SP_MOSTRAR_CIUDAD") Then
        Exit Sub
    End If
    If Trim(TxtCodigoCiudad.Text) <> "" Then
        Do While Bac_SQL_Fetch(Datos())
            If Me.TxtCodigoCiudad.Text = Datos(1) Then
                Me.TxtCodRegion1.Text = Datos(2)
                Me.TxtNombreCiudad.Text = Datos(3)
                Call TxtCodRegion1_LostFocus
                Exit Do
            End If
        Loop
    End If
End Sub

Private Sub TxtCodigoComuna_Change()
    LABCIU.Caption = ""
    'TxtCodigoComuna.Text = ""
    TxtCodCiudad1.Text = ""
    TxtNombreComuna.Text = ""
End Sub

Private Sub TxtCodigoComuna_DblClick()
'    If LABCIU.Caption <> "" Then
'        PARAMETRO1 = TxtCodCiudad1.Text
'       BacAyuda.Tag = "ComunaMntLocalidades1"
        BacAyuda.Tag = "ComunaMntLocalidades"
        BacAyuda.Show 1
        If giAceptar% = True Then
            TxtCodigoComuna.Text = RETORNOAYUDA
            Call TxtCodigoComuna_LostFocus
        End If
'    End If

End Sub

Private Sub TxtCodigoComuna_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then TxtNombreComuna.SetFocus
End Sub


Private Sub TxtCodigoComuna_LostFocus()
    Dim Datos()
    
    If Not Bac_Sql_Execute("SP_MOSTRAR_COMUNA") Then
        Exit Sub
    End If
    If Trim(TxtCodigoComuna.Text) <> "" Then
        Do While Bac_SQL_Fetch(Datos())
            If Me.TxtCodigoComuna.Text = Datos(1) Then
                Me.TxtCodCiudad1.Text = Datos(2)
                Me.TxtNombreComuna.Text = Datos(3)
                Call TxtCodCiudad1_LostFocus
                Exit Do
            End If
        Loop
    End If
End Sub

Private Sub TxTCodigoPais_Change()
    txtNombre.Text = ""
End Sub

Private Sub TxTCodigoPais_DblClick()
    BacAyuda.Tag = "PaisMntLocalidades"
    BacAyuda.Show 1
    If giAceptar% = True Then
        TxTCodigoPais.Text = RETORNOAYUDA
        Call TxTCodigoPais_LostFocus
    End If
End Sub

Private Sub TxTCodigoPais_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then txtNombre.SetFocus
End Sub

Private Sub TxTCodigoPais_LostFocus()
    Dim Datos()
    
    If Not Bac_Sql_Execute("SP_MOSTRAR_PAIS") Then
        Exit Sub
    End If
    If Trim(TxTCodigoPais.Text) <> "" Then
        Do While Bac_SQL_Fetch(Datos())
            If Me.TxTCodigoPais.Text = Datos(1) Then
                Me.txtNombre.Text = Datos(2)
                txtnumCodigoBcch.Text = Datos(3)
                txtCodSwift.Text = Datos(4)
                Exit Do
            End If
        Loop
        
        If Trim(Me.txtNombre.Text) = "CHILE" Then
            SSTab1.TabEnabled(1) = True
            SSTab1.TabEnabled(2) = True
            SSTab1.TabEnabled(3) = True
            SSTab1.TabEnabled(4) = False
        Else
            SSTab1.TabEnabled(1) = False
            SSTab1.TabEnabled(2) = False
            SSTab1.TabEnabled(3) = False
            SSTab1.TabEnabled(4) = True
        End If
        
    End If
End Sub

Private Sub TxtCodigoRegion_Change()
    TxtNombreRegion.Text = ""
    txtcodpais.Text = ""
    LabDesPais.Caption = ""
End Sub

Private Sub TxtCodigoRegion_DblClick()

    'If Trim(LabDesPais.Caption) <> "" Then
    '    PARAMETRO1 = ""
    '    If LabDesPais.Caption = "" Then
            BacAyuda.Tag = "RegionMntLocalidades"
    '    Else
    '        PARAMETRO1 = TxtCodPais
    '        BacAyuda.Tag = "RegionMntLocalidades1"
    '    End If
        BacAyuda.Show 1
        If giAceptar% = True Then
            TxtCodigoRegion.Text = RETORNOAYUDA
            Call TxtCodigoRegion_LostFocus
        End If
    'End If
    
End Sub


Private Sub TxtCodigoRegion_KeyPress(KeyAscii As Integer)
      
     If KeyAscii = 13 Then TxtNombreRegion.SetFocus: Exit Sub
'     If Trim(LabDesPais.Caption) = "" Then
'        KeyAscii = 0
'     End If
End Sub

Private Sub txtCodigoRuta_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then TxtNombreRuta.SetFocus
End Sub

Private Sub TxtCodigoSector_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then TxtNombreSector.SetFocus
End Sub

Sub Limpiar()
    txtGlo = ""
    LabNOMPAI = ""
    LabCodReg = ""
    LabDesPais = ""
    LABCIU = ""
    Me.txtCODPLA = ""
    Me.TXTNOMPLA = ""
    Me.TXTCODPAI = ""
    Me.TxtCodCiudad1 = ""
    Me.txtcodpais = ""
    txtnumCodigoBcch.Text = ""
    Me.TxtCodRegion1 = ""
    Me.TxTCodigoPais = ""
    Me.txtNombre = ""
    Me.TxtCodigoRegion = ""
    Me.TxtNombreRegion = ""
    Me.TxtCodigoCiudad = ""
    Me.TxtNombreCiudad = ""
    Me.TxtCodigoComuna = ""
    Me.TxtNombreComuna = ""
    'Me.TxtCodigoSector = ""
    'Me.TxtNombreSector = ""
    'Me.TxtCodigoRuta = ""
    'Me.TxtNombreRuta = ""
    Me.TxTCodigoPais = ""
    Me.TxtCodigoRegion = ""
    Me.TxtNombreRegion = ""
    txtCodSwift.Text = ""
End Sub

Private Sub TxtCodigoRegion_LostFocus()
    Dim Datos()
    
    If Not Bac_Sql_Execute("SP_MOSTRAR_REGION") Then
        Exit Sub
    End If
    If Trim(TxtCodigoRegion.Text) <> "" Then
        Do While Bac_SQL_Fetch(Datos())
            If Me.TxtCodigoRegion.Text = Datos(1) Then
               Me.txtcodpais.Text = Datos(2)
               Me.TxtNombreRegion.Text = Datos(3)
               Call txtcodpais_LostFocus
               Exit Do
            End If
        Loop
    End If
End Sub

Private Sub TXTCODPAI_Change()
    LabNOMPAI.Caption = ""
End Sub

Private Sub TXTCODPAI_DblClick()
    BacAyuda.Tag = "PaisMntLocalidades"
    BacAyuda.Show 1
    If giAceptar% = True Then
        TXTCODPAI.Text = RETORNOAYUDA
        Call TXTCODPAI_LostFocus
    End If
End Sub

Private Sub TXTCODPAI_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 Then
        txtCODPLA.SetFocus
    End If
End Sub

Private Sub TXTCODPAI_LostFocus()
    Dim Datos()
    
    If Not Bac_Sql_Execute("SP_MOSTRAR_PAIS") Then
        Exit Sub
    End If
    If Trim(Me.TXTCODPAI.Text) <> "" Then
        Do While Bac_SQL_Fetch(Datos())
            If Me.TXTCODPAI.Text = Datos(1) Then
                LabNOMPAI.Caption = Datos(2)
                Exit Do
            End If
        Loop
    End If
End Sub

Private Sub TxtCodPais_Change()
    
    'TxtCodPais.Text = ""
    LabDesPais.Caption = ""
    
    'TxtCodigoRegion.Text = ""
    'TxtNombreRegion.Text = ""

End Sub

Private Sub txtcodpais_DblClick()
    BacAyuda.Tag = "PaisMntLocalidades"
    BacAyuda.Show 1
    If giAceptar% = True Then
        txtcodpais.Text = RETORNOAYUDA
        Call txtcodpais_LostFocus
    End If
End Sub

Private Sub txtcodpais_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
    If KeyAscii = 13 Then TxtCodigoRegion.SetFocus
End Sub

Private Sub txtcodpais_LostFocus()
    Dim Datos()
    
    If Not Bac_Sql_Execute("SP_MOSTRAR_PAIS") Then
        Exit Sub
    End If
    If Trim(txtcodpais.Text) <> "" Then
        Do While Bac_SQL_Fetch(Datos())
            If Me.txtcodpais.Text = Datos(1) Then
                LabDesPais.Caption = Datos(2)
                Exit Do
            End If
        Loop
    End If
End Sub

Private Sub txtCODPLA_Change()
    TXTNOMPLA.Text = ""
    txtGlo.Text = ""
    TXTCODPAI.Text = ""
    LabNOMPAI.Caption = ""
End Sub

Private Sub txtCODPLA_DblClick()
    BacAyuda.Tag = "PlazaMntLocalidades"
    BacAyuda.Show 1
    If giAceptar% = True Then
        txtCODPLA.Text = RETORNOAYUDA
        Call txtCODPLA_LostFocus
        
    End If
End Sub

Private Sub txtCODPLA_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 Then
        txtGlo.SetFocus
    End If
End Sub

Private Sub txtCODPLA_LostFocus()
    Dim Datos()
    
    If Not Bac_Sql_Execute("SP_MOSTRAR_PLAZA") Then
        Exit Sub
    End If
    If Trim(txtCODPLA.Text) <> "" Then
        Do While Bac_SQL_Fetch(Datos())
            If Me.txtCODPLA.Text = Datos(1) Then
                Me.TXTCODPAI.Text = Datos(2)
                Me.TXTNOMPLA.Text = Datos(3)
                Me.txtGlo = Datos(4)
                Call TXTCODPAI_LostFocus
                Exit Do
            End If
        Loop
    End If
End Sub

Private Sub TxtCodRegion1_Change()
    'TxtCodRegion1.Text = ""
    LabCodReg.Caption = ""
    'TxtCodigoCiudad.Text = ""
    'TxtNombreCiudad.Text = ""
End Sub

Private Sub TxtCodRegion1_DblClick()
    
    BacAyuda.Tag = "RegionMntLocalidades"
    BacAyuda.Show 1
    If giAceptar% = True Then
        TxtCodRegion1.Text = RETORNOAYUDA
        Call TxtCodRegion1_LostFocus
    End If
    
End Sub

Private Sub TxtCodRegion1_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
    If KeyAscii = 13 Then Me.TxtCodigoCiudad.SetFocus
End Sub

Private Sub TxtNombreRuta_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub TxtNombreSector_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub TxtCodRegion1_LostFocus()
    Dim Datos()
    
    If Not Bac_Sql_Execute("SP_MOSTRAR_REGION") Then
        Exit Sub
    End If
    If Trim(TxtCodRegion1.Text) <> "" Then
        Do While Bac_SQL_Fetch(Datos())
            If Me.TxtCodRegion1.Text = Datos(1) Then
                Me.LabCodReg = Datos(3)
                Exit Do
            End If
        Loop
    End If
End Sub

Private Sub txtCodSwift_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then TxTCodigoPais.SetFocus
     KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txtGlo_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 Then
        TXTNOMPLA.SetFocus
    End If
End Sub

Private Sub txtGlo_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then txtnumCodigoBcch.SetFocus
     KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub TxtNombreCiudad_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        TxtCodRegion1.SetFocus
    End If
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub TxtNombreComuna_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then TxtCodCiudad1.SetFocus
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub TxtNombreRegion_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
   If KeyAscii = 13 Then txtcodpais.SetFocus
End Sub

Private Sub TXTNOMPLA_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 Then
        TXTCODPAI.SetFocus
    End If
End Sub

Private Sub TXTNOMPLA_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub txtnumCodigoBcch_KeyPress(KeyAscii As Integer)
     If KeyAscii = 13 Then txtCodSwift.SetFocus
     KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
