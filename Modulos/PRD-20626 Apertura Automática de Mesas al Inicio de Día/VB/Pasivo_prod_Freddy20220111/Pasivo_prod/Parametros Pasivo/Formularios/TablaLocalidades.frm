VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Begin VB.Form TablaLocalidades 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Localidades"
   ClientHeight    =   2670
   ClientLeft      =   4380
   ClientTop       =   6600
   ClientWidth     =   5955
   Icon            =   "TablaLocalidades.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2670
   ScaleWidth      =   5955
   Begin TabDlg.SSTab SSTab1 
      Height          =   2100
      Left            =   45
      TabIndex        =   23
      Top             =   525
      Width           =   5865
      _ExtentX        =   10345
      _ExtentY        =   3704
      _Version        =   393216
      Style           =   1
      Tabs            =   6
      TabsPerRow      =   6
      TabHeight       =   520
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "&1.-País"
      TabPicture(0)   =   "TablaLocalidades.frx":2EFA
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Frm_Pais"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).ControlCount=   1
      TabCaption(1)   =   "&2.-Región"
      TabPicture(1)   =   "TablaLocalidades.frx":2F16
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "Frm_Region"
      Tab(1).ControlCount=   1
      TabCaption(2)   =   "&3.-Ciudad"
      TabPicture(2)   =   "TablaLocalidades.frx":2F32
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "Frm_Ciudad"
      Tab(2).ControlCount=   1
      TabCaption(3)   =   "&4.-Comuna"
      TabPicture(3)   =   "TablaLocalidades.frx":2F4E
      Tab(3).ControlEnabled=   0   'False
      Tab(3).Control(0)=   "Frm_Comuna"
      Tab(3).ControlCount=   1
      TabCaption(4)   =   "&5.-Plaza"
      TabPicture(4)   =   "TablaLocalidades.frx":2F6A
      Tab(4).ControlEnabled=   0   'False
      Tab(4).Control(0)=   "Frm_Plaza"
      Tab(4).ControlCount=   1
      TabCaption(5)   =   "&6.-Sucursal"
      TabPicture(5)   =   "TablaLocalidades.frx":2F86
      Tab(5).ControlEnabled=   0   'False
      Tab(5).Control(0)=   "Frm_Sucursal"
      Tab(5).ControlCount=   1
      Begin Threed.SSFrame Frm_Pais 
         Height          =   1680
         Left            =   90
         TabIndex        =   24
         Top             =   330
         Width           =   5730
         _Version        =   65536
         _ExtentX        =   10107
         _ExtentY        =   2963
         _StockProps     =   14
         Caption         =   "Mantencion de Pais"
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
         Font3D          =   1
         Begin VB.TextBox TxTCodigoPaisEsp 
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
            Left            =   1800
            MaxLength       =   4
            TabIndex        =   49
            Top             =   1305
            Width           =   1335
         End
         Begin VB.TextBox TxTCodigoPaisSuper 
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
            Left            =   1795
            MaxLength       =   5
            TabIndex        =   2
            Top             =   975
            Width           =   1335
         End
         Begin VB.TextBox TxTCodigoPais 
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
            Left            =   1795
            MaxLength       =   5
            MouseIcon       =   "TablaLocalidades.frx":2FA2
            MousePointer    =   99  'Custom
            TabIndex        =   0
            Top             =   315
            Width           =   1335
         End
         Begin VB.TextBox TxtNombre 
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
            Left            =   1795
            MaxLength       =   50
            TabIndex        =   1
            Top             =   645
            Width           =   3875
         End
         Begin VB.Label Label19 
            AutoSize        =   -1  'True
            Caption         =   "Código País BBVA"
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
            TabIndex        =   48
            Top             =   1320
            Width           =   1470
         End
         Begin VB.Label Label18 
            AutoSize        =   -1  'True
            Caption         =   "Código Super"
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
            Left            =   135
            TabIndex        =   47
            Top             =   990
            Width           =   1125
         End
         Begin VB.Label Label10 
            AutoSize        =   -1  'True
            Caption         =   "Nombre "
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
            Left            =   135
            TabIndex        =   26
            Top             =   660
            Width           =   705
         End
         Begin VB.Label Label11 
            AutoSize        =   -1  'True
            Caption         =   "Código"
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
            TabIndex        =   25
            Top             =   330
            Width           =   585
         End
      End
      Begin Threed.SSFrame Frm_Region 
         Height          =   1680
         Left            =   -74910
         TabIndex        =   27
         Top             =   330
         Width           =   5730
         _Version        =   65536
         _ExtentX        =   10107
         _ExtentY        =   2963
         _StockProps     =   14
         Caption         =   "Mantencion de Regiones"
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
         Font3D          =   1
         Begin VB.TextBox TxtNombreRegion 
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
            Left            =   1515
            MaxLength       =   50
            TabIndex        =   4
            Top             =   645
            Width           =   3885
         End
         Begin VB.TextBox TxtCodigoRegion 
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
            Left            =   1515
            MaxLength       =   5
            MouseIcon       =   "TablaLocalidades.frx":32AC
            MousePointer    =   99  'Custom
            TabIndex        =   3
            Top             =   315
            Width           =   1305
         End
         Begin VB.TextBox TxtCodPais 
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
            Left            =   1515
            MaxLength       =   5
            TabIndex        =   5
            Top             =   975
            Width           =   1305
         End
         Begin VB.TextBox LabDesPais 
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
            Left            =   2835
            Locked          =   -1  'True
            TabIndex        =   6
            Top             =   975
            Width           =   2565
         End
         Begin VB.Label Label8 
            AutoSize        =   -1  'True
            Caption         =   "Nombre"
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
            Left            =   165
            TabIndex        =   30
            Top             =   660
            Width           =   660
         End
         Begin VB.Label Label9 
            AutoSize        =   -1  'True
            Caption         =   "Código Región"
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
            Left            =   165
            TabIndex        =   29
            Top             =   330
            Width           =   1200
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Código País"
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
            Left            =   165
            TabIndex        =   28
            Top             =   990
            Width           =   975
         End
      End
      Begin Threed.SSFrame Frm_Ciudad 
         Height          =   1680
         Left            =   -74910
         TabIndex        =   31
         Top             =   330
         Width           =   5730
         _Version        =   65536
         _ExtentX        =   10107
         _ExtentY        =   2963
         _StockProps     =   14
         Caption         =   "Mantencion de Ciudades"
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
         Font3D          =   1
         Begin VB.TextBox TxtCodigoCiudad 
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
            Left            =   1530
            MaxLength       =   5
            MouseIcon       =   "TablaLocalidades.frx":35B6
            MousePointer    =   99  'Custom
            TabIndex        =   7
            Top             =   315
            Width           =   1695
         End
         Begin VB.TextBox TxtNombreCiudad 
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
            Left            =   1530
            MaxLength       =   50
            TabIndex        =   8
            Top             =   645
            Width           =   3825
         End
         Begin VB.TextBox TxtCodRegion1 
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
            Left            =   1530
            MaxLength       =   5
            TabIndex        =   9
            Top             =   975
            Width           =   1215
         End
         Begin VB.TextBox LabCodReg 
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
            Left            =   2760
            Locked          =   -1  'True
            TabIndex        =   10
            Top             =   975
            Width           =   2595
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "Código Ciudad"
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
            TabIndex        =   34
            Top             =   330
            Width           =   1200
         End
         Begin VB.Label Label6 
            AutoSize        =   -1  'True
            Caption         =   "Nombre"
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
            TabIndex        =   33
            Top             =   660
            Width           =   660
         End
         Begin VB.Label Label13 
            AutoSize        =   -1  'True
            Caption         =   "Región"
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
            TabIndex        =   32
            Top             =   990
            Width           =   570
         End
      End
      Begin Threed.SSFrame Frm_Comuna 
         Height          =   1680
         Left            =   -74910
         TabIndex        =   35
         Top             =   330
         Width           =   5730
         _Version        =   65536
         _ExtentX        =   10107
         _ExtentY        =   2963
         _StockProps     =   14
         Caption         =   "Mantención de Comunas"
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
         Font3D          =   1
         Begin VB.TextBox TxtNombreComuna 
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
            Left            =   1605
            MaxLength       =   50
            TabIndex        =   12
            Top             =   645
            Width           =   3840
         End
         Begin VB.TextBox TxtCodigoComuna 
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
            Left            =   1605
            MaxLength       =   5
            MouseIcon       =   "TablaLocalidades.frx":38C0
            MousePointer    =   99  'Custom
            TabIndex        =   11
            Top             =   315
            Width           =   1545
         End
         Begin VB.TextBox TxtCodCiudad1 
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
            Left            =   1605
            MaxLength       =   5
            TabIndex        =   13
            Top             =   975
            Width           =   1260
         End
         Begin VB.TextBox LABCIU 
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
            Left            =   2895
            Locked          =   -1  'True
            TabIndex        =   14
            Top             =   975
            Width           =   2550
         End
         Begin VB.Label Label15 
            AutoSize        =   -1  'True
            Caption         =   "Nombre"
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
            Left            =   165
            TabIndex        =   38
            Top             =   660
            Width           =   660
         End
         Begin VB.Label Label16 
            AutoSize        =   -1  'True
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
            ForeColor       =   &H80000007&
            Height          =   210
            Left            =   165
            TabIndex        =   37
            Top             =   990
            Width           =   570
         End
         Begin VB.Label Label17 
            AutoSize        =   -1  'True
            Caption         =   "Código Comuna"
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
            Left            =   165
            TabIndex        =   36
            Top             =   330
            Width           =   1320
         End
      End
      Begin Threed.SSFrame Frm_Plaza 
         Height          =   1680
         Left            =   -74910
         TabIndex        =   39
         Top             =   330
         Width           =   5730
         _Version        =   65536
         _ExtentX        =   10107
         _ExtentY        =   2963
         _StockProps     =   14
         Caption         =   "Mantención de Plaza"
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
         Font3D          =   1
         Begin VB.TextBox txtGlo 
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
            Left            =   1380
            MaxLength       =   10
            TabIndex        =   16
            Top             =   645
            Width           =   2220
         End
         Begin VB.TextBox TXTCODPAI 
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
            Left            =   1380
            MaxLength       =   5
            TabIndex        =   18
            Top             =   1305
            Width           =   1275
         End
         Begin VB.TextBox txtCODPLA 
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
            Left            =   1380
            MaxLength       =   5
            MouseIcon       =   "TablaLocalidades.frx":3BCA
            MousePointer    =   99  'Custom
            TabIndex        =   15
            Top             =   315
            Width           =   1545
         End
         Begin VB.TextBox TXTNOMPLA 
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
            Left            =   1380
            MaxLength       =   50
            TabIndex        =   17
            Top             =   975
            Width           =   4050
         End
         Begin VB.TextBox LabNOMPAI 
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
            Left            =   2670
            Locked          =   -1  'True
            TabIndex        =   19
            Top             =   1305
            Width           =   2760
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Glosa"
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
            TabIndex        =   43
            Top             =   660
            Width           =   465
         End
         Begin VB.Label Label5 
            AutoSize        =   -1  'True
            Caption         =   "Código Plaza"
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
            Left            =   165
            TabIndex        =   42
            Top             =   330
            Width           =   1050
         End
         Begin VB.Label Label4 
            AutoSize        =   -1  'True
            Caption         =   "Codigo Pais"
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
            Left            =   165
            TabIndex        =   41
            Top             =   1365
            Width           =   975
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Nombre"
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
            Left            =   165
            TabIndex        =   40
            Top             =   990
            Width           =   660
         End
      End
      Begin Threed.SSFrame Frm_Sucursal 
         Height          =   1680
         Left            =   -74910
         TabIndex        =   44
         Top             =   330
         Width           =   5730
         _Version        =   65536
         _ExtentX        =   10107
         _ExtentY        =   2963
         _StockProps     =   14
         Caption         =   "Mantención de Sucursales"
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
         Font3D          =   1
         Begin VB.TextBox TxtCodigoSuc 
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
            Left            =   1320
            MaxLength       =   5
            MouseIcon       =   "TablaLocalidades.frx":3ED4
            MousePointer    =   99  'Custom
            TabIndex        =   20
            Top             =   315
            Width           =   1695
         End
         Begin VB.TextBox TxtNombreSuc 
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
            Left            =   1320
            MaxLength       =   50
            TabIndex        =   21
            Top             =   645
            Width           =   3135
         End
         Begin VB.Label Label12 
            Caption         =   "Codigo"
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
            Height          =   315
            Left            =   120
            TabIndex        =   46
            Top             =   330
            Width           =   1215
         End
         Begin VB.Label Label14 
            Caption         =   "Nombre"
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
            Height          =   315
            Left            =   120
            TabIndex        =   45
            Top             =   660
            Width           =   1215
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   22
      Top             =   0
      Width           =   5955
      _ExtentX        =   10504
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
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   5040
         Top             =   -120
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   16
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "TablaLocalidades.frx":41DE
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "TablaLocalidades.frx":4645
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "TablaLocalidades.frx":4B3B
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "TablaLocalidades.frx":4FCE
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "TablaLocalidades.frx":54B6
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "TablaLocalidades.frx":59C9
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "TablaLocalidades.frx":5E9C
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "TablaLocalidades.frx":6362
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "TablaLocalidades.frx":6859
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "TablaLocalidades.frx":6C52
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "TablaLocalidades.frx":7048
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "TablaLocalidades.frx":7585
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "TablaLocalidades.frx":7A46
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "TablaLocalidades.frx":7EFC
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "TablaLocalidades.frx":8340
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "TablaLocalidades.frx":8782
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "TablaLocalidades"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim OptLocal As String

Private Sub CmdAyudaPais_LostFocus()
Dim Datos()
    
    If Not BAC_SQL_EXECUTE("SP_MOSTRAR_PAIS") Then
        Exit Sub
    End If
    If Trim(TxTCodigoPais.Text) <> "" Then
        Do While BAC_SQL_FETCH(Datos())
            If Me.TxTCodigoPais.Text = Datos(1) Then
                Me.TxtNombre.Text = Datos(2)
                Me.TxTCodigoPaisSuper.Text = Datos(3)
                Me.TxTCodigoPaisEsp.Text = Datos(4)
                Exit Do
            End If
        Loop
    End If
    
End Sub

Private Sub CmdAyudaPais1_LostFocus()
Dim Datos()
    
    If Not BAC_SQL_EXECUTE("SP_MOSTRAR_PAIS") Then
        Exit Sub
    End If
    If Trim(TxtCodPais.Text) <> "" Then
        Do While BAC_SQL_FETCH(Datos())
            If Me.TxtCodPais.Text = Datos(2) Then
                Exit Do
            End If
        Loop
    End If
    
End Sub

Private Sub CmdAyudaRegion_LostFocus()
Dim Datos()
    
    If Not BAC_SQL_EXECUTE("SP_MOSTRAR_REGION") Then
        Exit Sub
    End If
    If Trim(TxtCodigoRegion.Text) <> "" Then
        Do While BAC_SQL_FETCH(Datos())
            If Me.TxtCodigoRegion.Text = Datos(1) Then
               Me.TxtCodPais.Text = Datos(2)
               Me.TxtNombreRegion.Text = Datos(3)
               Exit Do
            End If
        Loop
    End If

End Sub

Private Sub CmdAyudaRuta_Click()
    MiTag = "Ruta"
    BacAyuda.Show
End Sub

Private Sub CmdAyudaSector_Click()
    MiTag = "Sector"
    BacAyuda.Show
End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
    If giAceptar = True Then
        
        If Indica_Tag = "Pais" Then Me.TxTCodigoPais = RETORNOAYUDA: Call TxTCodigoPais_LostFocus
        If Indica_Tag = "Region" Then Me.TxtCodigoRegion = RETORNOAYUDA: Call TxtCodigoRegion_LostFocus
        If Indica_Tag = "Ciudad" Then Me.TxtCodigoCiudad = RETORNOAYUDA: Call TxtCodigoCiudad_LostFocus
        If Indica_Tag = "Comuna" Then Me.TxtCodigoComuna = RETORNOAYUDA: Call TxtCodigoComuna_LostFocus
        If Indica_Tag = "Ciudad1" Then Me.TxtCodCiudad1 = RETORNOAYUDA: Call TxtCodCiudad1_LostFocus
        If Indica_Tag = "Pais1" Then Me.TxtCodPais = RETORNOAYUDA: Call txtcodpais_LostFocus
        If Indica_Tag = "Region1" Then Me.TxtCodRegion1 = RETORNOAYUDA: Call TxtCodRegion1_LostFocus
        
    End If
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer
If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

opcion = 0
   Select Case KeyCode

         Case vbKeyLimpiar
               opcion = 1

         Case vbKeyGrabar
               opcion = 2
         
         Case vbKeyEliminar
               opcion = 3

         Case vbKeyBuscar
               opcion = 4
         
         Case vbKeySalir
               opcion = 5
   End Select

   If opcion <> 0 Then
      If Toolbar1.Buttons(opcion).Enabled Then
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
      End If

   End If

End If

End Sub


Private Sub Form_Load()
    Me.top = 1
    Me.left = 15
    OptLocal = Opt

    Me.Icon = BAC_Parametros.Icon

    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = False
    
    Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
    
End Sub
Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub


Private Sub TabStrip1_KeyDown(KeyCode As Integer, Shift As Integer)
With TabStrip1
    If KeyCode = 13 Then
        If .SelectedItem = "Pais" Then
            TxTCodigoPais.SetFocus
        ElseIf .SelectedItem = "Region" Then
            TxtCodigoRegion.SetFocus
        ElseIf .SelectedItem = "Ciudad" Then
            TxtCodigoCiudad.SetFocus
        ElseIf .SelectedItem = "Comuna" Then
            TxtCodigoComuna.SetFocus
        ElseIf .SelectedItem = "Plaza" Then
            txtCODPLA.SetFocus
        End If
    End If
End With
End Sub

Private Sub SSTab1_Click(PreviousTab As Integer)

Dim nAleta As Integer

Select Case SSTab1.Tab
    Case 0 'Pais
        Toolbar1.Buttons(2).Enabled = Not (TxTCodigoPais.Text = "")
        Toolbar1.Buttons(3).Enabled = Not (TxTCodigoPais.Text = "")
        Toolbar1.Buttons(2).Enabled = Not (TxTCodigoPaisEsp.Text = "")
        Toolbar1.Buttons(3).Enabled = Not (TxTCodigoPaisEsp.Text = "")
        Toolbar1.Buttons(4).Enabled = (TxTCodigoPais.Text = "")
        Toolbar1.Buttons(4).Enabled = (TxTCodigoPaisEsp.Text = "")
         
    Case 1 'Region
        Toolbar1.Buttons(2).Enabled = Not (TxtCodigoRegion.Text = "")
        Toolbar1.Buttons(3).Enabled = Not (TxtCodigoRegion.Text = "")
        Toolbar1.Buttons(4).Enabled = (TxtCodigoRegion.Text = "")
       
    Case 2 'Ciudad
        Toolbar1.Buttons(2).Enabled = Not (TxtCodigoCiudad.Text = "")
        Toolbar1.Buttons(3).Enabled = Not (TxtCodigoCiudad.Text = "")
        Toolbar1.Buttons(4).Enabled = (TxtCodigoCiudad.Text = "")
       
    Case 3 'Comuna
        Toolbar1.Buttons(2).Enabled = Not (TxtCodigoComuna.Text = "")
        Toolbar1.Buttons(3).Enabled = Not (TxtCodigoComuna.Text = "")
        Toolbar1.Buttons(4).Enabled = (TxtCodigoComuna.Text = "")
       
    Case 4 'Plaza
        Toolbar1.Buttons(2).Enabled = Not (txtCODPLA.Text = "")
        Toolbar1.Buttons(3).Enabled = Not (txtCODPLA.Text = "")
        Toolbar1.Buttons(4).Enabled = (txtCODPLA.Text = "")
       
    Case 5 'Sucursal
        Toolbar1.Buttons(2).Enabled = Not (TxtCodigoSuc.Text = "")
        Toolbar1.Buttons(3).Enabled = Not (TxtCodigoSuc.Text = "")
        Toolbar1.Buttons(4).Enabled = (TxtCodigoSuc.Text = "")
       
End Select

  
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Trim(UCase(Button.Key))
        Case Is = "SALIR"
            Unload Me
        Case Is = "BUSCAR"
            If Trim(UCase(SSTab1.Tab)) = 0 Then
               TxTCodigoPais_LostFocus
            End If
            If Trim(UCase(SSTab1.Tab)) = 1 Then
               TxtCodigoRegion_LostFocus
            End If
            If Trim(UCase(SSTab1.Tab)) = 2 Then
               TxtCodigoCiudad_LostFocus
            End If
            If Trim(UCase(SSTab1.Tab)) = 3 Then
               TxtCodigoComuna_LostFocus
            End If
            If Trim(UCase(SSTab1.Tab)) = 4 Then
               txtCODPLA_LostFocus
            End If
            If Trim(UCase(SSTab1.Tab)) = 5 Then
               TxtCodigoSuc_LostFocus
            End If
            
        Case Is = "GRABAR"
            If Trim(UCase(SSTab1.Tab)) = 0 Then
                If TxTCodigoPais.Text = "" Or Val(TxTCodigoPais.Text) = 0 Then
                    MsgBox "El Codigo del Pais esta en 0", vbExclamation
                    Exit Sub
                End If
                
                If Trim(TxtNombre.Text) = "" Then
                    MsgBox "El Nombre del Pais esta Blanco", vbExclamation
                    Exit Sub
                End If
                
                If TxTCodigoPaisEsp.Text = "" Then
                   TxTCodigoPaisEsp.Text = 0
                End If
                
                If Not FUNC_GRABA_PAIS() Then Exit Sub
            End If
            
            If Trim(UCase(SSTab1.Tab)) = 1 Then
            
                If TxtCodigoRegion.Text = "" Or Val(TxtCodigoRegion.Text) = 0 Then
                    MsgBox "El Codigo de Region esta en 0", vbExclamation
                    Exit Sub
                End If
                
                If Trim(TxtNombreRegion.Text) = "" Then
                    MsgBox "El Nombre de Región esta en Blanco", vbExclamation
                    Exit Sub
                End If
                If Not FUNC_VALIDA_PAIS() Then Exit Sub
            End If
            
            If Trim(UCase(SSTab1.Tab)) = 2 Then
            
                If TxtCodigoCiudad.Text = "" Or Val(TxtCodigoCiudad.Text) = 0 Then
                    MsgBox "El Codigo de Ciudad esta en 0", vbExclamation
                    Exit Sub
                End If
                
                If Trim(TxtNombreCiudad.Text) = "" Then
                    MsgBox "El Nombre de Ciudad esta en Blanco", vbExclamation
                    Exit Sub
                End If
                
                If Not FUNC_VALIDA_REGION() Then Exit Sub
            End If
            If Trim(UCase(SSTab1.Tab)) = 3 Then
            
                If TxtCodigoComuna.Text = "" Or Val(TxtCodigoComuna.Text) = 0 Then
                    MsgBox "El Codigo de Comuna esta en 0", vbExclamation
                    Exit Sub
                End If
                
                If Trim(TxtNombreComuna.Text) = "" Then
                    MsgBox "El Nombre de Comuna esta en Blanco", vbExclamation
                    Exit Sub
                End If
                
                
                If Not FUNC_VALIDA_CIUDAD() Then Exit Sub
            End If
            
            If Trim(UCase(SSTab1.Tab)) = 4 Then
                If txtCODPLA.Text = "" Or Val(txtCODPLA.Text) = 0 Then
                    MsgBox "El Codigo de Plaza esta en 0", vbExclamation
                    Exit Sub
                End If
                
                If Trim(TXTNOMPLA.Text) = "" Then
                    MsgBox "El Nombre de Plaza esta en Blanco", vbExclamation
                    Exit Sub
                End If
                
                
                
                If Not FUNC_VALIDA_PAIS1() Then Exit Sub
            End If
            If Trim(UCase(SSTab1.Tab)) = 5 Then
            
                If TxtCodigoSuc.Text = "" Or Val(TxtCodigoSuc.Text) = 0 Then
                    MsgBox "El Codigo de Sucursal esta en 0", vbExclamation
                    Exit Sub
                End If
                
                If Trim(TxtNombreSuc.Text) = "" Then
                    MsgBox "El Nombre de Plaza esta en Blanco", vbExclamation
                    Exit Sub
                End If
                    
                If Not FUNC_GRABA_SUCURSAL() Then Exit Sub
            End If
            
        Case Is = "LIMPIAR"
            If Trim(UCase(SSTab1.Tab)) = 0 Then
                TxTCodigoPais.Enabled = True
                'TxTCodigoPaisEsp.Enabled = True
                TxTCodigoPais.Text = ""
                'TxTCodigoPaisEsp.Text = ""
                TxTCodigoPais.SetFocus
            ElseIf Trim(UCase(SSTab1.Tab)) = 1 Then
                TxtCodigoRegion.Enabled = True
                TxtCodigoRegion.Text = ""
                TxtCodigoRegion.SetFocus
            ElseIf Trim(UCase(SSTab1.Tab)) = 2 Then
                TxtCodigoCiudad.Enabled = True
                TxtCodigoCiudad.Text = ""
                TxtCodigoCiudad.SetFocus
            ElseIf Trim(UCase(SSTab1.Tab)) = 3 Then
                TxtCodigoComuna.Enabled = True
                TxtCodigoComuna.Text = ""
                TxtCodigoComuna.SetFocus
            ElseIf Trim(UCase(SSTab1.Tab)) = 4 Then
                txtCODPLA.Enabled = True
                txtCODPLA.Text = ""
                txtCODPLA.SetFocus
            ElseIf Trim(UCase(SSTab1.Tab)) = 5 Then
                TxtCodigoSuc.Enabled = True
                TxtCodigoSuc.Text = ""
                TxtCodigoSuc.SetFocus
            End If
            Toolbar1.Buttons(2).Enabled = False
            Toolbar1.Buttons(3).Enabled = False
            Toolbar1.Buttons(4).Enabled = True
               
        Case Is = "ELIMINAR"
            If MsgBox("Seguro de Eliminar...", vbQuestion + vbYesNo) = vbYes Then
                If Trim(UCase(SSTab1.Tab)) = 0 Then
                    If TxTCodigoPais.Text = "" Or TxtNombre.Text = "" Then Exit Sub
                    If Not FUNC_ELIMINA_PAIS() Then Exit Sub
                End If
                If Trim(UCase(SSTab1.Tab)) = 1 Then
                    If TxtCodigoRegion.Text = "" Or TxtNombreRegion.Text = "" Then Exit Sub
                    If Not FUNC_ELIMINA_REGION() Then Exit Sub
                End If
                If Trim(UCase(SSTab1.Tab)) = 2 Then
                    If TxtCodigoCiudad.Text = "" Or TxtNombreCiudad.Text = "" Then Exit Sub
                    If Not FUNC_ELIMINA_CIUDAD() Then Exit Sub
                End If
                If Trim(UCase(SSTab1.Tab)) = 3 Then
                    If TxtCodigoComuna.Text = "" Or TxtNombreComuna.Text = "" Then Exit Sub
                    If Not FUNC_ELIMINA_COMUNA() Then Exit Sub
                End If
                If Trim(UCase(SSTab1.Tab)) = 4 Then
                    If txtCODPLA.Text = "" Or TXTNOMPLA.Text = "" Then Exit Sub
                    If Not FUNC_ELIMINA_PLAZA() Then Exit Sub
                End If
                If Trim(UCase(SSTab1.Tab)) = 5 Then
                    If TxtCodigoSuc.Text = "" Or TxtNombreSuc.Text = "" Then Exit Sub
                    If Not FUNC_ELIMINA_SUCURSAL() Then Exit Sub
                End If
            End If
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

If Not BAC_SQL_EXECUTE("SP_TABLALOCALIDADES_VALIDA_PAIS", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
   If Datos(1) = "NO EXISTE" Then MsgBox "Codigo País No Existe", vbExclamation
'      TxtCodPais.SetFocus
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
AddParam Envia, TxtCodPais
'Comando$ = Comando$ + "'" + TxtCodigoRegion + "'"

If Not BAC_SQL_EXECUTE("SP_TABLALOCALIDADES_VALIDA_PAIS", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
   If Datos(1) = "NO EXISTE" Then MsgBox "Codigo País No Existe", vbExclamation
      TxtCodPais.SetFocus
      
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
               

If Not BAC_SQL_EXECUTE("SP_TABLALOCALIDADES_VALIDA_REGION", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
   If Datos(1) = "NO EXISTE" Then MsgBox ("Codigo Región No Existe"), vbExclamation
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

If Not BAC_SQL_EXECUTE("SP_TABLALOCALIDADES_VALIDA_CIUDAD", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
   If Datos(1) = "NO EXISTE" Then MsgBox "Codigo Ciudad No Existe", vbExclamation
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
AddParam Envia, TxtNombre
AddParam Envia, TxTCodigoPaisSuper
AddParam Envia, TxTCodigoPaisEsp '15/11/2004 jspp interfaz contabilidad españa

If Not BAC_SQL_EXECUTE("SP_TABLALOCALIDADES_AGREGAR_PAIS ", Envia) Then Exit Function
  Do While BAC_SQL_FETCH(Datos())
    Select Case Datos(1)
        Case Is = "ERROR"
               Case Is = "EXISTE"
               MsgBox "Ciudad Ya Existe", vbCritical
               Limpiar
               TxtCodigoCiudad.SetFocus
               Exit Function
        End Select
    Loop
Beep

MsgBox "Grabación realizada con éxito", vbInformation
Call LogAuditoria("01", OptLocal, Me.Caption, "", "Pais: " & TxTCodigoPais.Text)

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
             
If Not BAC_SQL_EXECUTE("SP_TABLALOCALIDADES_AGREGAR_PLAZA ", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
    Select Case Datos(1)
        Case Is = "ERROR"
               Case Is = "EXISTE"
               MsgBox "Plaza Ya Existe", vbCritical
               Limpiar
               txtCODPLA.SetFocus
               Exit Function
        End Select
    Loop
Beep
MsgBox " Información Grabada...", vbInformation
Call LogAuditoria("01", OptLocal, Me.Caption, "", "Pais: " & TxTCodigoPais.Text & " Region: " & TxtCodigoRegion.Text & " Ciudad: " & TxtCodigoCiudad.Text & " Comuna: " & TxtCodigoComuna.Text & " Plaza: " & txtCODPLA.Text)
Limpiar
FUNC_GRABA_Plaza = True
End Function


'Función que graba regiones y llama a refrescar combo
Function FUNC_GRABA_REGION() As Boolean
Dim Datos()
FUNC_GRABA_REGION = False

Envia = Array()
AddParam Envia, TxtCodigoRegion
AddParam Envia, TxtCodPais
AddParam Envia, TxtNombreRegion
             

If Not BAC_SQL_EXECUTE("SP_TABLALOCALIDADES_AGREGAR_REGION ", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
    Select Case Datos(1)
        Case Is = "ERROR"
               Case Is = "EXISTE"
               MsgBox "Región Ya Existe", vbCritical
               Limpiar
               TxtCodigoRegion.SetFocus
               Exit Function
        End Select
    Loop
Beep
MsgBox " Información Grabada...", vbInformation
Call LogAuditoria("01", OptLocal, Me.Caption, "", "Pais: " & TxTCodigoPais.Text & " Región: " & TxtCodigoRegion.Text)
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


If Not BAC_SQL_EXECUTE("SP_TABLALOCALIDADES_AGREGAR_CIUDAD", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
    Select Case Datos(1)
        Case Is = "ERROR"
               Case Is = "EXISTE"
               MsgBox "Ciudad Ya Existe", vbCritical
               Limpiar
               TxtCodigoCiudad.SetFocus
               Exit Function
        End Select
    Loop
Beep

MsgBox " Información Grabada...", vbInformation
Call LogAuditoria("01", OptLocal, Me.Caption, "", "Pais: " & TxTCodigoPais.Text & " Region: " & TxtCodigoRegion.Text & " Ciudad: " & TxtCodigoCiudad.Text)
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

If Not BAC_SQL_EXECUTE("SP_TABLALOCALIDADES_AGREGAR_COMUNA", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
    Select Case Datos(1)
        Case Is = "ERROR"
               Case Is = "EXISTE"
               MsgBox "Comuna Ya Existe", vbCritical
               Limpiar
               TxtCodigoComuna.SetFocus
               Exit Function
        End Select
    Loop
Beep
MsgBox " Información Grabada...", vbInformation
Call LogAuditoria("01", OptLocal, Me.Caption, "", "Pais: " & TxTCodigoPais.Text & " Region: " & TxtCodigoRegion.Text & " Ciudad: " & TxtCodigoCiudad.Text & " Comuna: " & TxtCodigoComuna.Text)
Limpiar
FUNC_GRABA_COMUNA = True
End Function
'****************************************************************************
'**************************ELIMINA DATOS DE TABLA****************************
'****************************************************************************

Function FUNC_ELIMINA_PAIS() As Boolean
Dim Datos()
FUNC_ELIMINA_PAIS = False

Envia = Array()
AddParam Envia, TxTCodigoPais
AddParam Envia, TxtNombre

If Not BAC_SQL_EXECUTE("SP_TABLALOCALIDADES_ELIMINAR_PAIS ", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
   If Datos(1) = "RELACIONADA" Then MsgBox "No se Puede Eliminar El País, Esta Relacionado", vbCritical
   If Datos(1) = "NO EXISTE" Then MsgBox "País No Existe", vbCritical
      Limpiar
      TxTCodigoPais.SetFocus
      Exit Function
Loop
MsgBox "Información Eliminada...", vbInformation
Call LogAuditoria("03", OptLocal, Me.Caption, "Pais: " & TxTCodigoPais.Text, "")
Limpiar
FUNC_ELIMINA_PAIS = True
End Function

Function FUNC_ELIMINA_REGION() As Boolean
Dim Datos()
FUNC_ELIMINA_REGION = False

Envia = Array()
AddParam Envia, TxtCodigoRegion
AddParam Envia, TxtNombreRegion


If Not BAC_SQL_EXECUTE("SP_TABLALOCALIDADES_ELIMINAR_REGION ", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
   If Datos(1) = "RELACIONADA" Then MsgBox "No se Puede Eliminar Región, Está Relacionada", vbCritical
   If Datos(1) = "NO EXISTE" Then MsgBox "Región No Existe", vbCritical
      Limpiar
      TxtCodigoRegion.SetFocus
      Exit Function
Loop
MsgBox "Información Eliminada...", vbInformation
Call LogAuditoria("03", OptLocal, Me.Caption, "Pais: " & TxTCodigoPais.Text & " Region: " & TxtCodigoRegion.Text, "")
Limpiar
FUNC_ELIMINA_REGION = True

End Function

Function FUNC_ELIMINA_PLAZA() As Boolean
Dim Datos()
FUNC_ELIMINA_PLAZA = False

Envia = Array()
AddParam Envia, txtCODPLA
'Comando$ = Comando$ + "'" + TxtNombreCiudad + "'"

If Not BAC_SQL_EXECUTE("SP_TABLALOCALIDADES_ELIMINAR_PLAZA ", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
   If Datos(1) = "RELACIONADA" Then MsgBox "No se Puede Eliminar Plaza, Está Relacionada", vbCritical
      Limpiar
      txtCODPLA.SetFocus
      Exit Function
Loop
MsgBox "Información Eliminada...", vbInformation
Call LogAuditoria("03", OptLocal, Me.Caption, "Pais: " & TxTCodigoPais.Text & " Region: " & TxtCodigoRegion.Text & " Ciudad: " & TxtCodigoCiudad.Text & " Comuna: " & TxtCodigoComuna.Text & " Plaza: " & txtCODPLA.Text, "")
Limpiar
FUNC_ELIMINA_PLAZA = True
End Function


Function FUNC_ELIMINA_CIUDAD() As Boolean
Dim Datos()
FUNC_ELIMINA_CIUDAD = False

Envia = Array()
AddParam Envia, TxtCodigoCiudad
AddParam Envia, TxtNombreCiudad

If Not BAC_SQL_EXECUTE("SP_TABLALOCALIDADES_ELIMINAR_CIUDAD ", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
   If Datos(1) = "RELACIONADA" Then MsgBox "No se Puede Eliminar Ciudad, Está Relacionada", vbCritical
      Limpiar
      TxtCodigoCiudad.SetFocus
      Exit Function
Loop
MsgBox "Información Eliminada...", vbInformation
Call LogAuditoria("03", OptLocal, Me.Caption, "Pais: " & TxTCodigoPais.Text & " Region: " & TxtCodigoRegion.Text & " Ciudad: " & TxtCodigoCiudad.Text, "")
Limpiar
FUNC_ELIMINA_CIUDAD = True
End Function

Function FUNC_ELIMINA_COMUNA() As Boolean
Dim Datos()
FUNC_ELIMINA_COMUNA = False

Envia = Array()
AddParam Envia, TxtCodigoComuna
AddParam Envia, TxtNombreComuna

If Not BAC_SQL_EXECUTE("SP_TABLALOCALIDADES_ELIMINAR_COMUNA", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
   If Datos(1) = "RELACIONADA" Then MsgBox "No se Puede Eliminar Comuna, Está Relacionada", vbCritical
   If Datos(1) = "NO EXISTE" Then MsgBox "Comuna No Existe", vbCritical
      Limpiar
      TxtCodigoComuna.SetFocus
      Exit Function
Loop
MsgBox "Información Eliminada...", vbInformation
Call LogAuditoria("03", OptLocal, Me.Caption, "Pais: " & TxTCodigoPais.Text & " Region: " & TxtCodigoRegion.Text & " Ciudad: " & TxtCodigoCiudad.Text & " Comuna: " & TxtCodigoComuna.Text, "")
Limpiar
FUNC_ELIMINA_COMUNA = True
End Function

Private Sub TxtCodCiudad1_Change()
    LABCIU.Text = ""
End Sub

Private Sub TxtCodCiudad1_DblClick()
    
    MiTag = "CiudadMntLocalidades"
    BacAyuda.Show 1
    If giAceptar% = True Then
        TxtCodCiudad1.Text = RETORNOAYUDA
        Call TxtCodCiudad1_LostFocus
    End If
    
End Sub

Private Sub TxtCodCiudad1_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF3 Then TxtCodCiudad1_DblClick
 If KeyCode = 13 Then TxtCodCiudad1_LostFocus
End Sub

Private Sub TxtCodCiudad1_KeyPress(KeyAscii As Integer)
If Not IsNumeric(Chr(KeyAscii)) And Not (KeyAscii = 8 Or KeyAscii = vbKeyReturn Or KeyAscii = vbKeyEscape) Then
      KeyAscii = 0
 End If
'    If KeyAscii = 13 Then Me.TxtCodigoComuna.SetFocus
End Sub

Private Sub TxtCodCiudad1_LostFocus()
    Dim Datos()
    
    If Not BAC_SQL_EXECUTE("SP_MOSTRAR_CIUDAD") Then
        Exit Sub
    End If
    If Trim(TxtCodCiudad1.Text) <> "" Then
        Do While BAC_SQL_FETCH(Datos())
            If Me.TxtCodCiudad1.Text = Datos(1) Then
                LABCIU.Text = Datos(3)
                Exit Do
            End If
        Loop
    End If
End Sub

Private Sub TxtCodigoCiudad_Change()

    If Len(TxtCodigoCiudad.Text) = 0 Then
        LabCodReg.Text = ""
        TxtNombreCiudad.Text = ""
        TxtCodRegion1.Text = ""
        LabCodReg.Enabled = False
        TxtNombreCiudad.Enabled = False
        TxtCodRegion1.Enabled = False
    Else
        LabCodReg.Enabled = True
        TxtNombreCiudad.Enabled = True
        TxtCodRegion1.Enabled = True
    End If
    
End Sub


Private Sub TxtCodigoCiudad_DblClick()
'    If Trim(LabCodReg.Caption) <> "" Then
'        PARAMETRO1 = TxtCodRegion1.Text
'        MiTag = "CiudadMntLocalidades1"
        MiTag = "CiudadMntLocalidades"
        BacAyuda.Show 1
        If giAceptar% = True Then
            TxtCodigoCiudad.Text = RETORNOAYUDA
            Call TxtCodigoCiudad_LostFocus
        End If
'    End If
End Sub

Private Sub TxtCodigoCiudad_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF3 Then TxtCodigoCiudad_DblClick
End Sub

Private Sub TxtCodigoCiudad_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 Then
       If TxtNombreCiudad.Enabled Then
        TxtNombreCiudad.SetFocus
        Exit Sub
       End If
    Else
        If Not IsNumeric(Chr(KeyAscii)) And Not (KeyAscii = 8 Or KeyAscii = vbKeyReturn Or KeyAscii = vbKeyEscape) Then
            KeyAscii = 0
        End If
    End If
    
End Sub

Private Sub TxtCodigoCiudad_LostFocus()
    Dim Datos()
    
    If Not BAC_SQL_EXECUTE("SP_MOSTRAR_CIUDAD") Then
        Exit Sub
    End If
    If Trim(TxtCodigoCiudad.Text) <> "" Then
        Do While BAC_SQL_FETCH(Datos())
            If Me.TxtCodigoCiudad.Text = Datos(1) Then
                Me.TxtCodRegion1.Text = Datos(2)
                Me.TxtNombreCiudad.Text = Datos(3)
                Call TxtCodRegion1_LostFocus
                Toolbar1.Buttons(2).Enabled = True
                Toolbar1.Buttons(3).Enabled = True
                Toolbar1.Buttons(4).Enabled = False
                TxtCodigoCiudad.Enabled = False
                Exit Do
            End If
                TxtCodigoCiudad.Enabled = False
                Toolbar1.Buttons(2).Enabled = True
                Toolbar1.Buttons(4).Enabled = False
        Loop
    End If
End Sub

Private Sub TxtCodigoComuna_Change()

    If Len(TxtCodigoComuna.Text) = 0 Then
        LABCIU.Text = ""
        TxtCodCiudad1.Text = ""
        TxtNombreComuna.Text = ""
        LABCIU.Enabled = False
        TxtCodCiudad1.Enabled = False
        TxtNombreComuna.Enabled = False
    Else
        LABCIU.Enabled = True
        TxtCodCiudad1.Enabled = True
        TxtNombreComuna.Enabled = True
    End If
    
End Sub


Private Sub TxtCodigoComuna_DblClick()
'    If LABCIU.Caption <> "" Then
'        PARAMETRO1 = TxtCodCiudad1.Text
'       MiTag = "ComunaMntLocalidades1"
        MiTag = "ComunaMntLocalidades"
        BacAyuda.Show 1
        If giAceptar% = True Then
            TxtCodigoComuna.Text = RETORNOAYUDA
            Call TxtCodigoComuna_LostFocus
        End If
'    End If

End Sub

Private Sub TxtCodigoComuna_KeyDown(KeyCode As Integer, Shift As Integer)
  If KeyCode = vbKeyF3 Then TxtCodigoComuna_DblClick
End Sub

Private Sub TxtCodigoComuna_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 Then
       If TxtNombreComuna.Enabled Then
        TxtNombreComuna.SetFocus
       End If
    Else
       If Not IsNumeric(Chr(KeyAscii)) And Not (KeyAscii = 8 Or KeyAscii = vbKeyReturn Or KeyAscii = vbKeyEscape) Then
            KeyAscii = 0
       End If
    End If
    
End Sub


Private Sub TxtCodigoComuna_LostFocus()
    Dim Datos()
    
    If Not BAC_SQL_EXECUTE("SP_MOSTRAR_COMUNA") Then
        Exit Sub
    End If
    If Trim(TxtCodigoComuna.Text) <> "" Then
        Do While BAC_SQL_FETCH(Datos())
            If Me.TxtCodigoComuna.Text = Datos(1) Then
                Me.TxtCodCiudad1.Text = Datos(2)
                Me.TxtNombreComuna.Text = Datos(3)
                Call TxtCodCiudad1_LostFocus
                Toolbar1.Buttons(2).Enabled = True
                Toolbar1.Buttons(3).Enabled = True
                Toolbar1.Buttons(4).Enabled = False
                Exit Do
            End If
        Loop
            TxtCodigoComuna.Enabled = False
            Toolbar1.Buttons(2).Enabled = True
            Toolbar1.Buttons(4).Enabled = False
    End If
End Sub

Private Sub TxTCodigoPais_Change()

    If Len(TxTCodigoPais.Text) = 0 Then
        TxtNombre.Text = ""
        TxtNombre.Enabled = False
        TxTCodigoPaisSuper.Text = 0
        TxTCodigoPaisSuper.Enabled = False
        TxTCodigoPaisEsp.Text = 0
        TxTCodigoPaisEsp.Enabled = False
    Else
        TxtNombre.Enabled = True
        TxTCodigoPaisSuper.Enabled = True
        TxTCodigoPaisEsp.Enabled = True
    End If
    
End Sub

Private Sub TxTCodigoPais_DblClick()
    MiTag = "PaisMntLocalidades"
    BacAyuda.Show 1
    If giAceptar% = True Then
        TxTCodigoPais.Text = RETORNOAYUDA
        Call TxTCodigoPais_LostFocus
    End If
End Sub

Private Sub TxTCodigoPais_KeyDown(KeyCode As Integer, Shift As Integer)
  If KeyCode = vbKeyF3 Then TxTCodigoPais_DblClick
End Sub


Private Sub TxTCodigoPais_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
      If TxtNombre.Enabled Then
        TxtNombre.SetFocus
       End If
    Else
        If Not IsNumeric(Chr(KeyAscii)) And Not (KeyAscii = 8 Or KeyAscii = vbKeyReturn Or KeyAscii = vbKeyEscape) Then
            KeyAscii = 0
        End If
        
    End If
    
End Sub

Private Sub TxTCodigoPais_LostFocus()
    Dim Datos()
    
    If Not BAC_SQL_EXECUTE("SP_MOSTRAR_PAIS") Then
        Exit Sub
    End If
    If Trim(TxTCodigoPais.Text) <> "" Then
        Do While BAC_SQL_FETCH(Datos())
            If Me.TxTCodigoPais.Text = Datos(1) Then
                Me.TxtNombre.Text = Datos(2)
                Me.TxTCodigoPaisSuper.Text = Datos(3)
                Me.TxTCodigoPaisEsp.Text = Datos(4)
                Toolbar1.Buttons(2).Enabled = True
                Toolbar1.Buttons(3).Enabled = True
                Toolbar1.Buttons(4).Enabled = False
                Exit Do
            End If
        Loop
         TxTCodigoPais.Enabled = False
         Toolbar1.Buttons(2).Enabled = True
         Toolbar1.Buttons(4).Enabled = False
    End If

End Sub

Private Sub TxTCodigoPaisEsp_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
      If TxTCodigoPaisEsp.Enabled Then
        TxTCodigoPaisEsp.SetFocus
       End If
    Else
        If Not IsNumeric(Chr(KeyAscii)) And Not (KeyAscii = 8 Or KeyAscii = vbKeyReturn Or KeyAscii = vbKeyEscape) Then
            KeyAscii = 0
        End If
        
    End If

End Sub

Private Sub TxTCodigoPaisSuper_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
      If TxTCodigoPais.Enabled Then
        TxTCodigoPais.SetFocus
       End If
    Else
        If Not IsNumeric(Chr(KeyAscii)) And Not (KeyAscii = 8 Or KeyAscii = vbKeyReturn Or KeyAscii = vbKeyEscape) Then
            KeyAscii = 0
        End If
        
    End If
End Sub

Private Sub TxtCodigoRegion_Change()
    
    If Len(TxtCodigoRegion.Text) = 0 Then
        TxtNombreRegion.Text = ""
        TxtCodPais.Text = ""
        LabDesPais.Text = ""
        TxtNombreRegion.Enabled = False
        TxtCodPais.Enabled = False
        LabDesPais.Enabled = False
    Else
        TxtNombreRegion.Enabled = True
        TxtCodPais.Enabled = True
        LabDesPais.Enabled = True
    End If

End Sub

Private Sub TxtCodigoRegion_DblClick()

    'If Trim(LabDesPais.Caption) <> "" Then
    '    PARAMETRO1 = ""
    '    If LabDesPais.Caption = "" Then
            MiTag = "RegionMntLocalidades"
    '    Else
    '        PARAMETRO1 = TxtCodPais
    '        MiTag = "RegionMntLocalidades1"
    '    End If
        BacAyuda.Show 1
        If giAceptar% = True Then
            TxtCodigoRegion.Text = RETORNOAYUDA
            Call TxtCodigoRegion_LostFocus
        End If
    'End If
    
End Sub


Private Sub TxtCodigoRegion_KeyDown(KeyCode As Integer, Shift As Integer)
  If KeyCode = vbKeyF3 Then TxtCodigoRegion_DblClick
End Sub


Private Sub TxtCodigoRegion_KeyPress(KeyAscii As Integer)
      
     If KeyAscii = 13 Then
       If TxtNombreRegion.Enabled Then
        TxtNombreRegion.SetFocus
        Exit Sub
       End If
     Else
        If Not IsNumeric(Chr(KeyAscii)) And Not (KeyAscii = 8 Or KeyAscii = vbKeyReturn Or KeyAscii = vbKeyEscape) Then
            KeyAscii = 0
        End If
     End If
     
End Sub

Private Sub txtCodigoRuta_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then TxtNombreRuta.SetFocus
End Sub

Private Sub TxtCodigoSector_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then TxtNombreSector.SetFocus
End Sub

Sub Limpiar()

   Toolbar1_ButtonClick Toolbar1.Buttons(1)

'    txtGlo = ""
'    LabNOMPAI = ""
'    LabCodReg = ""
'    LabDesPais = ""
'    LABCIU = ""
'    Me.txtCODPLA = ""
'    Me.TXTNOMPLA = ""
'    Me.TXTCODPAI = ""
'    Me.TxtCodCiudad1 = ""
'    Me.TxtCodPais = ""
'    Me.TxtCodRegion1 = ""
'    Me.TxTCodigoPais = ""
'    Me.TxtNombre = ""
'    Me.TxtCodigoRegion = ""
'    Me.TxtNombreRegion = ""
'    Me.TxtCodigoCiudad = ""
'    Me.TxtNombreCiudad = ""
'    Me.TxtCodigoComuna = ""
'    Me.TxtNombreComuna = ""
'    'Me.TxtCodigoSector = ""
'    'Me.TxtNombreSector = ""
'    'Me.TxtCodigoRuta = ""
'    'Me.TxtNombreRuta = ""
'    Me.TxTCodigoPais = ""
'    Me.TxtCodigoRegion = ""
'    Me.TxtNombreRegion = ""
End Sub

Private Sub TxtCodigoRegion_LostFocus()
    Dim Datos()
    
    If Not BAC_SQL_EXECUTE("SP_MOSTRAR_REGION") Then
        Exit Sub
    End If
    If Trim(TxtCodigoRegion.Text) <> "" Then
        Do While BAC_SQL_FETCH(Datos())
            If Me.TxtCodigoRegion.Text = Datos(1) Then
               Me.TxtCodPais.Text = Datos(2)
               Me.TxtNombreRegion.Text = Datos(3)
               Call txtcodpais_LostFocus
               Toolbar1.Buttons(2).Enabled = True
               Toolbar1.Buttons(3).Enabled = True
               Toolbar1.Buttons(4).Enabled = False
               Exit Do
            End If
        Loop
      TxtCodigoRegion.Enabled = False
      Toolbar1.Buttons(2).Enabled = True
      Toolbar1.Buttons(4).Enabled = False
    End If
End Sub

Private Sub TxtCodigoSuc_Change()

    If Len(TxtCodigoSuc.Text) = 0 Then
        TxtNombreSuc.Text = ""
        TxtNombreSuc.Enabled = False
    Else
        TxtNombreSuc.Enabled = True
    End If
    
End Sub

Private Sub TxtCodigoSuc_DblClick()
    MiTag = "Sucursales"
    BacAyuda.Show 1
    If giAceptar% = True Then
        TxtCodigoSuc.Text = RETORNOAYUDA
        Call TxtCodigoSuc_LostFocus
    End If
End Sub

Private Sub TxtCodigoSuc_KeyDown(KeyCode As Integer, Shift As Integer)
  If KeyCode = vbKeyF3 Then TxtCodigoSuc_DblClick
   If KeyCode = 13 Then
    If TxtNombreSuc.Enabled Then
     Me.TxtNombreSuc.SetFocus
    End If
   End If
End Sub

Private Sub TxtCodigoSuc_KeyPress(KeyAscii As Integer)
If Not IsNumeric(Chr(KeyAscii)) And Not (KeyAscii = 8 Or KeyAscii = vbKeyReturn Or KeyAscii = vbKeyEscape) Then
      KeyAscii = 0
End If
End Sub


Private Sub TxtCodigoSuc_LostFocus()
   Dim Datos()
  
    If Not BAC_SQL_EXECUTE("Sp_Mostrar_Sucursal") Then
        Exit Sub
    End If
     If Trim(Me.TxtCodigoSuc.Text) <> "" Then
        Do While BAC_SQL_FETCH(Datos())
            If Me.TxtCodigoSuc.Text = Datos(1) Then
                TxtNombreSuc.Text = Datos(2)
                Toolbar1.Buttons(2).Enabled = True
                Toolbar1.Buttons(3).Enabled = True
                Toolbar1.Buttons(4).Enabled = False
                Exit Do
            End If
        Loop
       TxtCodigoSuc.Enabled = False
       Toolbar1.Buttons(2).Enabled = True
       Toolbar1.Buttons(4).Enabled = False
    End If
   
End Sub

Private Sub TXTCODPAI_Change()
    LabNOMPAI.Text = ""
End Sub

Private Sub TXTCODPAI_DblClick()
    MiTag = "PaisMntLocalidades"
    BacAyuda.Show 1
    If giAceptar% = True Then
        TXTCODPAI.Text = RETORNOAYUDA
        Call TXTCODPAI_LostFocus
    End If
End Sub

Private Sub TXTCODPAI_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF3 Then TXTCODPAI_DblClick
    If KeyCode = 13 Then
        'txtCODPLA.SetFocus
        If Val(TXTCODPAI.Text) <> 0 Then
            Call TXTCODPAI_LostFocus
    End If
 End If
End Sub

Private Sub TXTCODPAI_KeyPress(KeyAscii As Integer)
If Not IsNumeric(Chr(KeyAscii)) And Not (KeyAscii = 8 Or KeyAscii = vbKeyReturn Or KeyAscii = vbKeyEscape) Then
      KeyAscii = 0
 End If

End Sub

Private Sub TXTCODPAI_LostFocus()
    Dim Datos()
    
    If Not BAC_SQL_EXECUTE("SP_MOSTRAR_PAIS") Then
        Exit Sub
    End If
    If Trim(Me.TXTCODPAI.Text) <> "" Then
        Do While BAC_SQL_FETCH(Datos())
            If Me.TXTCODPAI.Text = Datos(1) Then
                LabNOMPAI.Text = Datos(2)
                Exit Do
            End If
        Loop
    End If
End Sub

Private Sub TxtCodPais_Change()
    
    'TxtCodPais.Text = ""
    LabDesPais.Text = ""
    
    'TxtCodigoRegion.Text = ""
    'TxtNombreRegion.Text = ""

End Sub

Private Sub txtcodpais_DblClick()
    MiTag = "PaisMntLocalidades"
    BacAyuda.Show 1
    If giAceptar% = True Then
        TxtCodPais.Text = RETORNOAYUDA
        Call txtcodpais_LostFocus
    End If
End Sub

Private Sub TxtCodPais_KeyDown(KeyCode As Integer, Shift As Integer)
  If KeyCode = vbKeyF3 Then txtcodpais_DblClick
  If KeyCode = 13 Then txtcodpais_LostFocus
End Sub

Private Sub txtcodpais_KeyPress(KeyAscii As Integer)

 If Not IsNumeric(Chr(KeyAscii)) And Not (KeyAscii = 8 Or KeyAscii = vbKeyReturn Or KeyAscii = vbKeyEscape) Then
      KeyAscii = 0
 End If

'    If KeyAscii = 13 Then TxtCodigoRegion.SetFocus
End Sub

Private Sub txtcodpais_LostFocus()
    Dim Datos()
    
    If Not BAC_SQL_EXECUTE("SP_MOSTRAR_PAIS") Then
        Exit Sub
    End If
    If Trim(TxtCodPais.Text) <> "" Then
        Do While BAC_SQL_FETCH(Datos())
            If Me.TxtCodPais.Text = Datos(1) Then
                LabDesPais.Text = Datos(2)
                Exit Do
            End If
        Loop
    End If
End Sub

Private Sub txtCODPLA_Change()

    If Len(txtCODPLA.Text) = 0 Then
        TXTNOMPLA.Text = ""
        txtGlo.Text = ""
        TXTCODPAI.Text = ""
        LabNOMPAI.Text = ""
        TXTNOMPLA.Enabled = False
        txtGlo.Enabled = False
        TXTCODPAI.Enabled = False
        LabNOMPAI.Enabled = False
    Else
        TXTNOMPLA.Enabled = True
        txtGlo.Enabled = True
        TXTCODPAI.Enabled = True
        LabNOMPAI.Enabled = True
    End If
    
End Sub


Private Sub txtCODPLA_DblClick()
    MiTag = "PlazaMntLocalidades"
    BacAyuda.Show 1
    If giAceptar% = True Then
        txtCODPLA.Text = RETORNOAYUDA
        Call txtCODPLA_LostFocus
        
    End If
End Sub

Private Sub txtCODPLA_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF3 Then txtCODPLA_DblClick
    If KeyCode = 13 Then
       If txtGlo.Enabled Then
        txtGlo.SetFocus
       End If
    End If
End Sub

Private Sub txtCODPLA_KeyPress(KeyAscii As Integer)
    
    If KeyAscii = 13 Then
       If txtGlo.Enabled Then
        txtGlo.SetFocus
       End If
    Else
        If Not IsNumeric(Chr(KeyAscii)) And Not (KeyAscii = 8 Or KeyAscii = vbKeyReturn Or KeyAscii = vbKeyEscape) Then
            KeyAscii = 0
        End If
    End If
    
End Sub

Private Sub txtCODPLA_LostFocus()
    Dim Datos()
    
    If Not BAC_SQL_EXECUTE("SP_MOSTRAR_PLAZA") Then
        Exit Sub
    End If
    If Trim(txtCODPLA.Text) <> "" Then
        Do While BAC_SQL_FETCH(Datos())
            If Me.txtCODPLA.Text = Datos(1) Then
                Me.TXTCODPAI.Text = Datos(2)
                Me.TXTNOMPLA.Text = Datos(3)
                Me.txtGlo = Datos(4)
                Call TXTCODPAI_LostFocus
                Toolbar1.Buttons(2).Enabled = True
                Toolbar1.Buttons(3).Enabled = True
                Toolbar1.Buttons(4).Enabled = False
                Exit Do
            End If
        Loop
      txtCODPLA.Enabled = False
      Toolbar1.Buttons(2).Enabled = True
      Toolbar1.Buttons(4).Enabled = False
    End If
End Sub

Private Sub TxtCodRegion1_Change()
    'TxtCodRegion1.Text = ""
    LabCodReg.Text = ""
    'TxtCodigoCiudad.Text = ""
    'TxtNombreCiudad.Text = ""
End Sub

Private Sub TxtCodRegion1_DblClick()
    
    MiTag = "RegionMntLocalidades"
    BacAyuda.Show 1
    If giAceptar% = True Then
        TxtCodRegion1.Text = RETORNOAYUDA
        Call TxtCodRegion1_LostFocus
    End If
    
End Sub

Private Sub TxtCodRegion1_KeyDown(KeyCode As Integer, Shift As Integer)
  If KeyCode = vbKeyF3 Then TxtCodRegion1_DblClick
  If KeyCode = 13 Then TxtCodRegion1_LostFocus
End Sub

Private Sub TxtCodRegion1_KeyPress(KeyAscii As Integer)
 If Not IsNumeric(Chr(KeyAscii)) And Not (KeyAscii = 8 Or KeyAscii = vbKeyReturn Or KeyAscii = vbKeyEscape) Then
      KeyAscii = 0
 End If
 '   If KeyAscii = 13 Then Me.TxtCodigoCiudad.SetFocus
End Sub

Private Sub TxtNombreRuta_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub TxtNombreSector_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub TxtCodRegion1_LostFocus()
    Dim Datos()
    
    If Not BAC_SQL_EXECUTE("SP_MOSTRAR_REGION") Then
        Exit Sub
    End If
    If Trim(TxtCodRegion1.Text) <> "" Then
        Do While BAC_SQL_FETCH(Datos())
            If Me.TxtCodRegion1.Text = Datos(1) Then
                Me.LabCodReg = Datos(3)
                Exit Do
            End If
        Loop
    End If
End Sub

Private Sub txtGlo_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 Then
        TXTNOMPLA.SetFocus
    End If
End Sub

Private Sub txtGlo_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
    KeyAscii = Caracter(KeyAscii)
End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then TxTCodigoPaisSuper.SetFocus
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
    KeyAscii = Caracter(KeyAscii)
End Sub

Private Sub TxtNombreCiudad_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        TxtCodRegion1.SetFocus
    End If
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
    KeyAscii = Caracter(KeyAscii)
End Sub

Private Sub TxtNombreComuna_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then TxtCodCiudad1.SetFocus
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
    KeyAscii = Caracter(KeyAscii)
End Sub

Private Sub TxtNombreRegion_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
   If KeyAscii = 13 Then TxtCodPais.SetFocus
   KeyAscii = Caracter(KeyAscii)
End Sub

Private Sub TxtNombreSuc_KeyPress(KeyAscii As Integer)
    
   KeyAscii = Caracter(KeyAscii)
   Call BacToUCase(KeyAscii)
End Sub

Private Sub TXTNOMPLA_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 Then
        TXTCODPAI.SetFocus
    End If
End Sub

Private Sub TXTNOMPLA_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
    KeyAscii = Caracter(KeyAscii)
End Sub

Function FUNC_GRABA_SUCURSAL() As Boolean
Dim Datos()
FUNC_GRABA_SUCURSAL = False

Envia = Array()

AddParam Envia, TxtCodigoSuc
AddParam Envia, TxtNombreSuc
         

If Not BAC_SQL_EXECUTE("Sp_TablaLocalidades_Agregar_Sucursal ", Envia) Then Exit Function
  Do While BAC_SQL_FETCH(Datos())
    Select Case Datos(1)
        Case Is = "ERROR"
               Case Is = "EXISTE"
               MsgBox "Sucursal Ya Existe", vbCritical
               Limpiar
               TxtCodigoSuc.SetFocus
               Exit Function
        End Select
    Loop
Beep
MsgBox "Sucursal Grabada...", vbInformation
Call LogAuditoria("01", OptLocal, Me.Caption, "", "Pais: " & TxTCodigoPais.Text & " Region: " & TxtCodigoRegion.Text & " Ciudad: " & TxtCodigoCiudad.Text & " Comuna: " & TxtCodigoComuna.Text & " Plaza: " & txtCODPLA.Text & " Sucursal: " & TxtCodigoSuc.Text)
TxtCodigoSuc.Text = ""
TxtNombreSuc.Text = ""
'TxtCodigoSuc.SetFocus
Limpiar
End Function

Function FUNC_ELIMINA_SUCURSAL() As Boolean
Dim Datos()
FUNC_ELIMINA_SUCURSAL = False

Envia = Array()
AddParam Envia, TxtCodigoSuc
'Comando$ = Comando$ + "'" + TxtNombreCiudad + "'"

If Not BAC_SQL_EXECUTE("Sp_TablaLocalidades_Eliminar_Sucursal ", Envia) Then Exit Function
Do While BAC_SQL_FETCH(Datos())
   If Datos(1) = "RELACIONADA" Then MsgBox "No se Puede Eliminar Sucursal, Está Relacionada", vbCritical
   If Datos(1) = "NO EXISTE" Then MsgBox "Sucursal No Existe", vbCritical
      Limpiar
      TxtCodigoSuc.SetFocus
      Exit Function
Loop
MsgBox "Sucursal Eliminada...", vbInformation
Call LogAuditoria("03", OptLocal, Me.Caption, "Pais: " & TxTCodigoPais.Text & " Region: " & TxtCodigoRegion.Text & " Ciudad: " & TxtCodigoCiudad.Text & " Comuna: " & TxtCodigoComuna.Text & " Plaza: " & txtCODPLA.Text & " Sucursal: " & TxtCodigoSuc.Text, "")
TxtCodigoSuc.Text = ""
TxtNombreSuc.Text = ""
'TxtCodigoSuc.SetFocus

Limpiar
FUNC_ELIMINA_SUCURSAL = True
End Function



