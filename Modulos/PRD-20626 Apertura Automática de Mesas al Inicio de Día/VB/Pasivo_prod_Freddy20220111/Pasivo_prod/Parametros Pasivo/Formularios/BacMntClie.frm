VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Begin VB.Form BacMntClie 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Clientes "
   ClientHeight    =   4425
   ClientLeft      =   2070
   ClientTop       =   3060
   ClientWidth     =   9585
   Icon            =   "BacMntClie.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4425
   ScaleWidth      =   9585
   Begin TabDlg.SSTab TabStrip1 
      Height          =   3780
      Left            =   120
      TabIndex        =   11
      Top             =   600
      Width           =   9375
      _ExtentX        =   16536
      _ExtentY        =   6668
      _Version        =   393216
      Style           =   1
      Tabs            =   4
      Tab             =   2
      TabsPerRow      =   4
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
      TabCaption(0)   =   "Identificacion Cliente"
      TabPicture(0)   =   "BacMntClie.frx":2EFA
      Tab(0).ControlEnabled=   0   'False
      Tab(0).Control(0)=   "ID1"
      Tab(0).ControlCount=   1
      TabCaption(1)   =   "Domicilio"
      TabPicture(1)   =   "BacMntClie.frx":2F16
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "ID2"
      Tab(1).ControlCount=   1
      TabCaption(2)   =   "Datos Generales"
      TabPicture(2)   =   "BacMntClie.frx":2F32
      Tab(2).ControlEnabled=   -1  'True
      Tab(2).Control(0)=   "ID3"
      Tab(2).Control(0).Enabled=   0   'False
      Tab(2).Control(1)=   "Frame3"
      Tab(2).Control(1).Enabled=   0   'False
      Tab(2).ControlCount=   2
      TabCaption(3)   =   "Mesa Empresa"
      TabPicture(3)   =   "BacMntClie.frx":2F4E
      Tab(3).ControlEnabled=   0   'False
      Tab(3).Control(0)=   "ID4"
      Tab(3).ControlCount=   1
      Begin VB.Frame Frame3 
         Height          =   720
         Left            =   240
         TabIndex        =   110
         Top             =   2805
         Width           =   8865
         Begin VB.TextBox txtcodnif 
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
            Left            =   1740
            MaxLength       =   10
            TabIndex        =   111
            Top             =   315
            Width           =   1335
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Código NIF"
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
            Index           =   14
            Left            =   810
            TabIndex        =   112
            Top             =   345
            Width           =   870
         End
      End
      Begin VB.Frame ID2 
         BorderStyle     =   0  'None
         Caption         =   "ID2"
         Height          =   2520
         Left            =   -74880
         TabIndex        =   97
         Top             =   360
         Width           =   9105
         Begin Threed.SSFrame SSFrame6 
            Height          =   750
            Left            =   105
            TabIndex        =   98
            Top             =   180
            Width           =   8865
            _Version        =   65536
            _ExtentX        =   15637
            _ExtentY        =   1323
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
            Begin VB.TextBox TxtDireccion 
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
               Left            =   60
               MaxLength       =   40
               TabIndex        =   12
               Top             =   345
               Width           =   8670
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Dirección"
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
               Index           =   5
               Left            =   90
               TabIndex        =   99
               Top             =   135
               Width           =   765
            End
         End
         Begin Threed.SSFrame SSFrame3 
            Height          =   1575
            Left            =   105
            TabIndex        =   100
            Top             =   915
            Width           =   2985
            _Version        =   65536
            _ExtentX        =   5265
            _ExtentY        =   2778
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
            Begin VB.ComboBox cmbPais 
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
               Left            =   60
               Style           =   2  'Dropdown List
               TabIndex        =   13
               Top             =   405
               Width           =   2850
            End
            Begin VB.TextBox TxtTelefono 
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
               Left            =   60
               MaxLength       =   20
               TabIndex        =   14
               Top             =   1140
               Width           =   2805
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Teléfono"
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
               Index           =   15
               Left            =   75
               TabIndex        =   102
               Top             =   870
               Width           =   735
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
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
               ForeColor       =   &H80000007&
               Height          =   210
               Index           =   9
               Left            =   105
               TabIndex        =   101
               Top             =   195
               Width           =   345
            End
         End
         Begin Threed.SSFrame SSFrame4 
            Height          =   1560
            Left            =   3150
            TabIndex        =   103
            Top             =   930
            Width           =   2910
            _Version        =   65536
            _ExtentX        =   5133
            _ExtentY        =   2752
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
            Begin VB.TextBox TxtFax 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   285
               Left            =   45
               MaxLength       =   20
               TabIndex        =   16
               Top             =   1140
               Width           =   2790
            End
            Begin VB.ComboBox CmbRegion 
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
               Left            =   45
               Style           =   2  'Dropdown List
               TabIndex        =   15
               Top             =   420
               Width           =   2820
            End
            Begin VB.Label Label 
               Caption         =   "Fax"
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
               Index           =   16
               Left            =   120
               TabIndex        =   105
               Top             =   855
               Width           =   375
            End
            Begin VB.Label cod_reg 
               BackStyle       =   0  'Transparent
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
               Height          =   375
               Left            =   90
               TabIndex        =   104
               Top             =   165
               Width           =   1200
            End
         End
         Begin Threed.SSFrame SSFrame5 
            Height          =   1575
            Left            =   6120
            TabIndex        =   106
            Top             =   915
            Width           =   2850
            _Version        =   65536
            _ExtentX        =   5027
            _ExtentY        =   2778
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
            Begin VB.ComboBox CmbComuna 
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
               Left            =   60
               Style           =   2  'Dropdown List
               TabIndex        =   18
               Top             =   1095
               Width           =   2745
            End
            Begin VB.ComboBox CmbCiudad 
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
               Left            =   75
               Style           =   2  'Dropdown List
               TabIndex        =   17
               Top             =   420
               Width           =   2730
            End
            Begin VB.Label Label 
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
               Index           =   11
               Left            =   75
               TabIndex        =   108
               Top             =   165
               Width           =   570
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Comuna"
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
               Index           =   10
               Left            =   75
               TabIndex        =   107
               Top             =   840
               Width           =   690
            End
         End
      End
      Begin VB.Frame ID4 
         BorderStyle     =   0  'None
         Caption         =   "ID4"
         Height          =   2520
         Left            =   -74880
         TabIndex        =   66
         Top             =   360
         Width           =   9105
         Begin VB.Frame Frame1 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   780
            Left            =   1815
            TabIndex        =   68
            Top             =   1725
            Width           =   3330
            Begin VB.TextBox TxtCod 
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
               Left            =   1500
               MaxLength       =   11
               TabIndex        =   46
               Top             =   270
               Width           =   1740
            End
            Begin Threed.SSOption OpImplic 
               Height          =   255
               Index           =   2
               Left            =   1455
               TabIndex        =   45
               Top             =   285
               Visible         =   0   'False
               Width           =   720
               _Version        =   65536
               _ExtentX        =   1270
               _ExtentY        =   450
               _StockProps     =   78
               Caption         =   "Swift"
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
            End
            Begin Threed.SSOption OpImplic 
               Height          =   255
               Index           =   1
               Left            =   705
               TabIndex        =   44
               Top             =   285
               Width           =   720
               _Version        =   65536
               _ExtentX        =   1270
               _ExtentY        =   450
               _StockProps     =   78
               Caption         =   "Chips"
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
            End
            Begin Threed.SSOption OpImplic 
               Height          =   255
               Index           =   0
               Left            =   75
               TabIndex        =   43
               Top             =   285
               Width           =   660
               _Version        =   65536
               _ExtentX        =   1164
               _ExtentY        =   450
               _StockProps     =   78
               Caption         =   " Aba"
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
               Value           =   -1  'True
            End
         End
         Begin VB.Frame Frame2 
            Height          =   915
            Left            =   7935
            TabIndex        =   67
            Top             =   135
            Width           =   1080
            Begin VB.OptionButton SS3 
               Caption         =   "Otros"
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
               Left            =   105
               TabIndex        =   32
               Top             =   615
               Width           =   765
            End
            Begin Threed.SSOption SS1 
               Height          =   195
               Left            =   105
               TabIndex        =   31
               Top             =   390
               Width           =   675
               _Version        =   65536
               _ExtentX        =   1191
               _ExtentY        =   344
               _StockProps     =   78
               Caption         =   "Filial"
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
               Value           =   -1  'True
            End
            Begin Threed.SSOption SS2 
               Height          =   225
               Left            =   105
               TabIndex        =   30
               Top             =   120
               Width           =   780
               _Version        =   65536
               _ExtentX        =   1376
               _ExtentY        =   397
               _StockProps     =   78
               Caption         =   "Matriz"
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
            End
         End
         Begin Threed.SSFrame SSFrame11 
            Height          =   885
            Left            =   75
            TabIndex        =   69
            Top             =   165
            Width           =   3975
            _Version        =   65536
            _ExtentX        =   7011
            _ExtentY        =   1561
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
            Begin VB.ComboBox cmbComInstitucional 
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
               Left            =   60
               Style           =   2  'Dropdown List
               TabIndex        =   28
               Top             =   435
               Width           =   3855
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Sector Económico"
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
               Index           =   28
               Left            =   105
               TabIndex        =   70
               Top             =   180
               Width           =   1485
            End
         End
         Begin Threed.SSFrame SSFrame12 
            Height          =   885
            Left            =   4095
            TabIndex        =   71
            Top             =   165
            Width           =   3765
            _Version        =   65536
            _ExtentX        =   6641
            _ExtentY        =   1561
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
            Begin VB.ComboBox cmbActividadEconomica 
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
               Left            =   75
               Style           =   2  'Dropdown List
               TabIndex        =   29
               Top             =   450
               Width           =   3615
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Grupo Empresa"
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
               Index           =   32
               Left            =   105
               TabIndex        =   72
               Top             =   180
               Width           =   1290
            End
         End
         Begin Threed.SSFrame SSFrame13 
            Height          =   720
            Left            =   75
            TabIndex        =   73
            Top             =   1020
            Width           =   8940
            _Version        =   65536
            _ExtentX        =   15769
            _ExtentY        =   1270
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
            Begin VB.ComboBox cmbPaisMatriz 
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
               Left            =   7230
               Style           =   2  'Dropdown List
               TabIndex        =   40
               Top             =   330
               Width           =   1650
            End
            Begin VB.TextBox lblDv 
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
               Left            =   5850
               TabIndex        =   38
               Top             =   360
               Width           =   345
            End
            Begin VB.TextBox txtCRiesgo 
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
               MaxLength       =   10
               TabIndex        =   35
               Top             =   345
               Width           =   1230
            End
            Begin VB.TextBox txtCodigoSuper 
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
               Left            =   75
               MaxLength       =   3
               TabIndex        =   33
               Text            =   "0"
               Top             =   345
               Width           =   675
            End
            Begin VB.TextBox txtCodigoBCCH 
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
               Left            =   885
               MaxLength       =   3
               TabIndex        =   34
               Text            =   "0"
               Top             =   345
               Width           =   720
            End
            Begin VB.ComboBox CmbLinea 
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
               Height          =   330
               ItemData        =   "BacMntClie.frx":2F6A
               Left            =   6270
               List            =   "BacMntClie.frx":2F74
               Style           =   2  'Dropdown List
               TabIndex        =   39
               Top             =   330
               Width           =   855
            End
            Begin VB.TextBox TxtCodigoOtc 
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
               Left            =   3090
               MaxLength       =   10
               TabIndex        =   36
               Top             =   345
               Width           =   1005
            End
            Begin BACControles.TXTNumero txtRutCasaMatriz 
               Height          =   315
               Left            =   4155
               TabIndex        =   37
               Top             =   360
               Width           =   1575
               _ExtentX        =   2778
               _ExtentY        =   556
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Text            =   "0"
               Text            =   "0"
               Max             =   "999999999"
               Separator       =   -1  'True
            End
            Begin VB.Label Label4 
               Caption         =   "Pais Casa Matriz"
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
               Height          =   180
               Left            =   7320
               TabIndex        =   109
               Top             =   120
               Width           =   1575
            End
            Begin VB.Label Label2 
               Caption         =   "Afecto Lns."
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
               Height          =   180
               Left            =   6255
               TabIndex        =   80
               Top             =   120
               Width           =   1275
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T Casa Matríz"
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
               Index           =   7
               Left            =   4200
               TabIndex        =   79
               Top             =   120
               Width           =   1410
            End
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               Caption         =   "-"
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
               Height          =   195
               Left            =   5730
               TabIndex        =   78
               Top             =   390
               Width           =   75
            End
            Begin VB.Label Label3 
               Caption         =   "Codigo Otc"
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
               Height          =   285
               Left            =   3120
               TabIndex        =   77
               Top             =   120
               Width           =   1080
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Cód.Sbif"
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
               Index           =   4
               Left            =   90
               TabIndex        =   76
               Top             =   120
               Width           =   690
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Cód.BCCH"
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
               Index           =   6
               Left            =   900
               TabIndex        =   75
               Top             =   135
               Width           =   825
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Area"
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
               Index           =   19
               Left            =   1845
               TabIndex        =   74
               Top             =   135
               Width           =   390
            End
         End
         Begin Threed.SSFrame frame85 
            Height          =   780
            Left            =   75
            TabIndex        =   81
            Top             =   1725
            Width           =   1710
            _Version        =   65536
            _ExtentX        =   3016
            _ExtentY        =   1376
            _StockProps     =   14
            Caption         =   "Articulo 85"
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
            Enabled         =   0   'False
            Begin Threed.SSOption opCliente 
               Height          =   255
               Left            =   60
               TabIndex        =   41
               Top             =   300
               Width           =   810
               _Version        =   65536
               _ExtentX        =   1429
               _ExtentY        =   450
               _StockProps     =   78
               Caption         =   "Cliente"
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
               Enabled         =   0   'False
               Value           =   -1  'True
            End
            Begin Threed.SSOption opBanco 
               Height          =   255
               Left            =   915
               TabIndex        =   42
               Top             =   315
               Width           =   750
               _Version        =   65536
               _ExtentX        =   1323
               _ExtentY        =   450
               _StockProps     =   78
               Caption         =   "Banco"
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
               Enabled         =   0   'False
            End
         End
         Begin Threed.SSFrame SSFrame15 
            Height          =   780
            Left            =   7620
            TabIndex        =   82
            Top             =   1710
            Width           =   1380
            _Version        =   65536
            _ExtentX        =   2434
            _ExtentY        =   1376
            _StockProps     =   14
            Caption         =   "Estado"
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
            Begin VB.CheckBox ChkBloqueado 
               Caption         =   "Bloqueado"
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
               Height          =   300
               Left            =   165
               TabIndex        =   51
               Top             =   285
               Width           =   1170
            End
         End
         Begin Threed.SSFrame SSFrame14 
            Height          =   780
            Left            =   5190
            TabIndex        =   83
            Top             =   1725
            Width           =   2400
            _Version        =   65536
            _ExtentX        =   4233
            _ExtentY        =   1376
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
            Begin VB.CheckBox chkFirma 
               Caption         =   "Firma"
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
               Left            =   1575
               TabIndex        =   50
               Top             =   420
               Width           =   780
            End
            Begin VB.CheckBox chkPoder 
               Caption         =   "Poder"
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
               Left            =   1575
               TabIndex        =   49
               Top             =   120
               Width           =   795
            End
            Begin VB.CheckBox chkOficinas 
               Caption         =   "Oficinas en Chile"
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
               ForeColor       =   &H80000007&
               Height          =   345
               Left            =   60
               TabIndex        =   48
               Top             =   375
               Width           =   1425
            End
            Begin VB.CheckBox chkInformeSocial 
               Caption         =   "Informe Social"
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
               Left            =   60
               TabIndex        =   47
               Top             =   120
               Width           =   1500
            End
         End
      End
      Begin VB.Frame ID1 
         BorderStyle     =   0  'None
         Caption         =   "ID1"
         Height          =   2520
         Left            =   -74880
         TabIndex        =   55
         Top             =   360
         Width           =   9120
         Begin Threed.SSFrame SSFrame1 
            Height          =   825
            Left            =   120
            TabIndex        =   56
            Top             =   1575
            Width           =   8940
            _Version        =   65536
            _ExtentX        =   15769
            _ExtentY        =   1455
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
               Left            =   75
               MaxLength       =   40
               TabIndex        =   6
               Top             =   375
               Width           =   7610
            End
            Begin VB.TextBox Txt1Nombre 
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
               Left            =   3840
               MaxLength       =   15
               TabIndex        =   9
               Top             =   375
               Visible         =   0   'False
               Width           =   1890
            End
            Begin VB.TextBox Txt2Nombre 
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
               Left            =   5760
               MaxLength       =   15
               TabIndex        =   10
               Top             =   375
               Visible         =   0   'False
               Width           =   1890
            End
            Begin VB.TextBox Txt1Apellido 
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
               Left            =   75
               MaxLength       =   15
               TabIndex        =   7
               Top             =   375
               Visible         =   0   'False
               Width           =   1890
            End
            Begin VB.TextBox Txt2Apellido 
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
               Left            =   1965
               MaxLength       =   15
               TabIndex        =   8
               Top             =   375
               Visible         =   0   'False
               Width           =   1890
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Paterno"
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
               Index           =   2
               Left            =   120
               TabIndex        =   60
               Top             =   150
               Visible         =   0   'False
               Width           =   645
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Materno"
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
               Index           =   20
               Left            =   2040
               TabIndex        =   59
               Top             =   135
               Visible         =   0   'False
               Width           =   690
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Nombres"
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
               Index           =   21
               Left            =   3930
               TabIndex        =   58
               Top             =   150
               Visible         =   0   'False
               Width           =   765
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Razón Social"
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
               Height          =   240
               Index           =   18
               Left            =   120
               TabIndex        =   57
               Top             =   150
               Width           =   1020
            End
         End
         Begin Threed.SSFrame SSFrame7 
            Height          =   705
            Left            =   120
            TabIndex        =   61
            Top             =   120
            Width           =   8940
            _Version        =   65536
            _ExtentX        =   15769
            _ExtentY        =   1244
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
            Begin VB.TextBox txtgeneric 
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
               Left            =   6480
               MaxLength       =   5
               TabIndex        =   3
               Top             =   240
               Width           =   1185
            End
            Begin VB.TextBox txtrut 
               Alignment       =   1  'Right Justify
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
               Left            =   840
               MaxLength       =   9
               MouseIcon       =   "BacMntClie.frx":2F80
               MousePointer    =   99  'Custom
               MultiLine       =   -1  'True
               TabIndex        =   0
               Top             =   240
               Width           =   1170
            End
            Begin VB.TextBox txtDigito 
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
               Left            =   2145
               MaxLength       =   1
               TabIndex        =   1
               Top             =   240
               Width           =   270
            End
            Begin VB.TextBox TxtCodigo 
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
               Left            =   3690
               MaxLength       =   3
               TabIndex        =   2
               Top             =   240
               Width           =   930
            End
            Begin VB.Line Line1 
               X1              =   2040
               X2              =   2100
               Y1              =   375
               Y2              =   375
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Genérico"
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
               Index           =   3
               Left            =   5370
               TabIndex        =   64
               Top             =   300
               Width           =   750
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "R.U.T."
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
               Index           =   0
               Left            =   210
               TabIndex        =   63
               Top             =   300
               Width           =   450
            End
            Begin VB.Label Label 
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
               Height          =   225
               Index           =   31
               Left            =   2910
               TabIndex        =   62
               Top             =   285
               Width           =   585
            End
         End
         Begin Threed.SSFrame SSFrame2 
            Height          =   810
            Left            =   120
            TabIndex        =   65
            Top             =   765
            Width           =   8940
            _Version        =   65536
            _ExtentX        =   15769
            _ExtentY        =   1429
            _StockProps     =   14
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Begin Threed.SSOption SSOption1 
               Height          =   195
               Left            =   180
               TabIndex        =   4
               Top             =   195
               Width           =   915
               _Version        =   65536
               _ExtentX        =   1614
               _ExtentY        =   344
               _StockProps     =   78
               Caption         =   "Natural"
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
               Enabled         =   0   'False
               Font3D          =   3
            End
            Begin Threed.SSOption SSOption2 
               Height          =   195
               Left            =   180
               TabIndex        =   5
               Top             =   450
               Width           =   990
               _Version        =   65536
               _ExtentX        =   1746
               _ExtentY        =   344
               _StockProps     =   78
               Caption         =   "Juridico"
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
               Enabled         =   0   'False
               Value           =   -1  'True
               Font3D          =   3
            End
         End
      End
      Begin VB.Frame ID3 
         BorderStyle     =   0  'None
         Caption         =   "ID3"
         Height          =   2520
         Left            =   120
         TabIndex        =   84
         Top             =   360
         Width           =   9105
         Begin Threed.SSFrame SSFrame8 
            Height          =   2220
            Left            =   120
            TabIndex        =   85
            Top             =   225
            Width           =   3015
            _Version        =   65536
            _ExtentX        =   5318
            _ExtentY        =   3916
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
            Begin VB.ComboBox cmbRGBanco 
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
               Left            =   45
               Style           =   2  'Dropdown List
               TabIndex        =   20
               Top             =   1110
               Width           =   2925
            End
            Begin VB.ComboBox cmbExige 
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
               Left            =   2265
               Style           =   2  'Dropdown List
               TabIndex        =   21
               Top             =   1560
               Width           =   675
            End
            Begin VB.ComboBox cmbTipoCliente 
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
               Left            =   45
               Style           =   2  'Dropdown List
               TabIndex        =   19
               Top             =   360
               Width           =   2925
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Exige Cuenta"
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
               Index           =   12
               Left            =   1110
               TabIndex        =   88
               Top             =   1635
               Width           =   1065
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Relación Gestión Banco"
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
               Index           =   24
               Left            =   60
               TabIndex        =   87
               Top             =   885
               Width           =   1920
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Clasificación Cliente"
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
               Index           =   27
               Left            =   60
               TabIndex        =   86
               Top             =   150
               Width           =   1665
            End
         End
         Begin Threed.SSFrame SSFrame9 
            Height          =   2205
            Left            =   3165
            TabIndex        =   89
            Top             =   225
            Width           =   3015
            _Version        =   65536
            _ExtentX        =   5318
            _ExtentY        =   3889
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
            Begin VB.ComboBox cmbRelBanco 
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
               Left            =   45
               Style           =   2  'Dropdown List
               TabIndex        =   23
               Top             =   1080
               Width           =   2910
            End
            Begin VB.TextBox txtctacte 
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
               Left            =   60
               MaxLength       =   15
               TabIndex        =   24
               Top             =   1800
               Width           =   2895
            End
            Begin VB.ComboBox CmbCalidadJuridica 
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
               Left            =   45
               Style           =   2  'Dropdown List
               TabIndex        =   22
               Top             =   375
               Width           =   2925
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Relación Banco"
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
               Index           =   26
               Left            =   75
               TabIndex        =   92
               Top             =   870
               Width           =   1230
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   " Número Cta Corriente $"
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
               Index           =   17
               Left            =   30
               TabIndex        =   91
               Top             =   1575
               Width           =   1995
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Calidad Jurídica"
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
               Index           =   13
               Left            =   75
               TabIndex        =   90
               Top             =   165
               Width           =   1290
            End
         End
         Begin Threed.SSFrame SSFrame10 
            Height          =   2190
            Left            =   6240
            TabIndex        =   93
            Top             =   225
            Width           =   2760
            _Version        =   65536
            _ExtentX        =   4868
            _ExtentY        =   3863
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
            Begin VB.TextBox TxtCtaUSD 
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
               Left            =   60
               MaxLength       =   12
               TabIndex        =   27
               Top             =   1785
               Width           =   2640
            End
            Begin VB.ComboBox cmbCategoriaDeudor 
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
               Left            =   75
               Style           =   2  'Dropdown List
               TabIndex        =   26
               Top             =   1080
               Width           =   2655
            End
            Begin VB.ComboBox CmbMercado 
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
               Left            =   60
               Style           =   2  'Dropdown List
               TabIndex        =   25
               Top             =   360
               Width           =   2670
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Categoría Deudor"
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
               Index           =   33
               Left            =   105
               TabIndex        =   96
               Top             =   870
               Width           =   1440
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Mercado"
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
               Index           =   8
               Left            =   105
               TabIndex        =   95
               Top             =   165
               Width           =   720
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   " Número Cta Corriente USD"
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
               Index           =   23
               Left            =   30
               TabIndex        =   94
               Top             =   1575
               Width           =   2220
            End
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   52
      Top             =   0
      Width           =   9585
      _ExtentX        =   16907
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Cód. Contable"
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
         Index           =   1
         Left            =   7095
         TabIndex        =   53
         Top             =   630
         Width           =   1215
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   3900
      Left            =   0
      TabIndex        =   54
      Top             =   510
      Width           =   9585
      _Version        =   65536
      _ExtentX        =   16907
      _ExtentY        =   6879
      _StockProps     =   15
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
   End
   Begin MSComctlLib.ImageList Img_opciones 
      Left            =   8130
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   10
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntClie.frx":328A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntClie.frx":36F1
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntClie.frx":3BE7
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntClie.frx":407A
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntClie.frx":4562
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntClie.frx":4A75
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntClie.frx":4F48
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntClie.frx":540E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntClie.frx":5905
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntClie.frx":5CFE
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacMntClie"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim optSW               As Boolean
Dim nCodigo             As Integer
Dim OptLocal            As String
Dim CodigoFox           As Double
Dim LimpiaYN            As Boolean
Dim Sql                 As String
Dim SW                  As Integer
Dim Norepi              As Integer
Dim VarPais             As Integer
Dim i                   As Integer
Dim swauxiliar          As Integer
Dim Combos(4)           As Integer
Dim Datos()

Private Function FUNC_HabilitarControles(Valor As Boolean)
Dim OptValor1  As Boolean
Dim OptValor2  As Boolean

   txtRut.Enabled = Not Valor
   txtDigito.Enabled = Not Valor
   txtCodigo.Enabled = Not Valor
   Txt1Nombre.Enabled = Valor
   Txt2Nombre.Enabled = Valor
   Txt1Apellido.Enabled = Valor
   Txt2Apellido.Enabled = Valor
   TxtCtaUSD.Enabled = Valor
   TxtCod.Enabled = Valor

   For i = 0 To 2
      OpImplic(i).Enabled = Valor

   Next i

   txtgeneric.Enabled = Valor
   txtctacte.Enabled = Valor
   TxtDireccion.Enabled = Valor
   TxtNombre.Enabled = Valor
   txtfax.Enabled = Valor
   TxtTelefono.Enabled = Valor
   txtCRiesgo.Enabled = Valor
   CmbComuna.Enabled = Valor
   CmbCiudad.Enabled = Valor
   CmbCalidadJuridica.Enabled = Valor
   Me.txtRutCasaMatriz.Enabled = Valor
   cmbPaisMatriz.Enabled = Valor
   CmbMercado.Enabled = Valor
   cmbPais.Enabled = Valor

   Toolbar1.Buttons(2).Enabled = Valor
   Toolbar1.Buttons(3).Enabled = Valor
   
   OptValor1 = SSOption1.Value
   OptValor2 = SSOption2.Value
   
   SSOption1.Enabled = Valor
   SSOption2.Enabled = Valor
   
   SSOption1.Value = OptValor1
   SSOption2.Value = OptValor2
   
   
   
   txtCodigoSuper.Enabled = Valor
   txtCodigoBCCH.Enabled = Valor

   'Nuevos controles //Marcos Jimenez
   cmbRGBanco.Enabled = Valor
   cmbTipoCliente.Enabled = Valor
   cmbComInstitucional.Enabled = Valor
   cmbRelBanco.Enabled = Valor
   cmbActividadEconomica.Enabled = Valor
   cmbCategoriaDeudor.Enabled = Valor
   chkInformeSocial.Enabled = Valor
   chkPoder.Enabled = Valor
   chkFirma.Enabled = Valor
   chkOficinas.Enabled = Valor
   TxtCodigoOtc.Enabled = Valor
   ChkBloqueado.Enabled = Valor
   CmbRegion.Enabled = Valor
   SS1.Enabled = Valor
   SS2.Enabled = Valor
   SS3.Enabled = Valor
   Me.cmbExige.Enabled = Valor
   
   If Me.cmbExige.ListIndex = 0 Then
      Me.txtctacte.Enabled = False
      Me.TxtCtaUSD.Enabled = False
   Else
      Me.txtctacte.Enabled = True
      Me.TxtCtaUSD.Enabled = True
   End If
   
   Me.TabStrip1.TabEnabled(1) = Valor
   Me.TabStrip1.TabEnabled(2) = Valor
   Me.TabStrip1.TabEnabled(3) = Valor

End Function

Private Sub PROC_InicializaPais()

   With Me.cmbPais
      For i = 0 To .ListCount - 1
         If cmbPais.List(i) = UCase("Chile") Then
            Combos(1) = i
            cmbPais.ListIndex = i
            Exit For

         End If

      Next i

   End With

   With Me.cmbPaisMatriz
      For i = 0 To .ListCount - 1
         If cmbPaisMatriz.List(i) = UCase("Chile") Then
            Combos(1) = i
            cmbPaisMatriz.ListIndex = i
            Exit For

         End If

      Next i

   End With

   With Me.CmbRegion
      For i = 0 To .ListCount - 1
         If CmbRegion.List(i) = UCase("Metropolitana") Then
            Combos(2) = i
            CmbRegion.ListIndex = i
            Exit For

         End If

      Next i

   End With

   With Me.CmbCiudad
      For i = 0 To .ListCount - 1
         If CmbCiudad.List(i) = UCase("Santiago") Then
            Combos(3) = i
            CmbCiudad.ListIndex = i
            Exit For

         End If

      Next i

   End With

   With Me.CmbComuna
      For i = 0 To .ListCount - 1
         If CmbComuna.List(i) = UCase("Santiago centro") Then
            Combos(4) = i
            CmbComuna.ListIndex = i
            Exit For

         End If

      Next i

   End With

End Sub

Private Sub PROC_LIMPIAR()

   LimpiaYN = True
   Txt1Nombre.Text = " "
   Txt2Nombre.Text = " "
   Txt1Apellido.Text = " "
   Txt2Apellido.Text = " "

   Txt1Nombre.Tag = " "
   Txt2Nombre.Tag = " "
   Txt1Apellido.Tag = " "
   Txt2Apellido.Tag = " "
   TxtCod.Text = ""
   TxtCtaUSD.Text = " "

   txtRut.Text = ""
   txtDigito.Text = ""
   txtgeneric.Text = ""
   SSOption1.Tag = ""
   TxtDireccion.Text = ""
   txtfax.Text = ""

   TxtNombre.Text = ""
   TxtNombre.Tag = ""

   TxtTelefono.Text = ""
   txtctacte.Text = ""
   TxtCtaUSD.Text = ""
   txtCodigo.Text = ""

   txtCodigoSuper.Text = ""
   txtCodigoBCCH.Text = ""
   txtcodnif.Text = ""

   txtCRiesgo.Text = ""
   If CmbCalidadJuridica.ListCount > 0 Then CmbCalidadJuridica.ListIndex = 0
   CmbComuna.Clear
   CmbCiudad.Clear
   If CmbMercado.ListCount > 0 Then CmbMercado.ListIndex = 0
   If cmbPais.ListCount > 0 Then cmbPais.ListIndex = 0
   If cmbRGBanco.ListCount > 0 Then cmbRGBanco.ListIndex = 0
   If cmbRelBanco.ListCount > 0 Then cmbRelBanco.ListIndex = 0
   If cmbCategoriaDeudor.ListCount > 0 Then cmbCategoriaDeudor.ListIndex = 0
   If cmbTipoCliente.ListCount > 0 Then cmbTipoCliente.ListIndex = 0
   If cmbComInstitucional.ListCount > 0 Then cmbComInstitucional.ListIndex = 0
   If cmbActividadEconomica.ListCount > 0 Then cmbActividadEconomica.ListIndex = 0
   Me.txtRutCasaMatriz.Text = 0 '®
   Me.LblDV.Text = "" '®
   Me.txtRutCasaMatriz.Enabled = False '®
   Me.cmbPais.ListIndex = 0

   chkInformeSocial.Value = 0
   chkPoder.Value = 0
   chkFirma.Value = 0
   chkOficinas.Value = 0
   TxtCodigoOtc.Text = ""
   ChkBloqueado.Value = 0

   LimpiaYN = False
   If CmbLinea.ListCount > 0 Then CmbLinea.ListIndex = 0
   CmbLinea.Enabled = False
   CmbRegion.ListIndex = -1
   cmbPaisMatriz.ListIndex = -1
   SS1.Value = True
   Me.TabStrip1.Tab = 0

End Sub

Function FUNC_ValidarDatos() As Boolean

   Dim sCadena          As String

   FUNC_ValidarDatos = False

   sCadena = ""

   If IsNumeric(TxtDireccion.Text) Then
      sCadena = "- Dirección ingresada no es valida" & vbCrLf
   
   End If

   If Trim$(txtCodigo) = "" Then
      sCadena = "- Debe especificar el Código del Cliente" & vbCrLf

   End If

   If SSOption1.Value = True Then
      If Trim$(Txt1Nombre) = "" Or Trim$(Txt1Apellido) = "" Or Trim$(Txt2Apellido) = "" Then
         sCadena = sCadena & "- Debe especificar el Nombre del Cliente" & vbCrLf

      End If

   End If

   If SSOption2.Value = True Then
      If Trim$(TxtNombre) = "" Then
         sCadena = sCadena & "- Debe especificar la Razón Social" & vbCrLf

      End If

   End If

   If Trim$(txtgeneric) = "" And SSOption1.Value = False Then
      sCadena = sCadena & "- Debe especificar el genérico" & vbCrLf

   End If

   If Me.SS1.Value = True And (Me.LblDV.Text = "" Or Me.txtRutCasaMatriz.Text = 0) Then
      sCadena = sCadena & "- Si ha seleccionado filial debe ingresar el rut de la casa matríz" & vbCrLf

   End If

   If Me.SS1.Value = True And cmbPaisMatriz.ListIndex = -1 Then
      sCadena = sCadena & "- Si ha seleccionado filial debe ingresar pais de la casa matríz" & vbCrLf

   End If

   If Me.cmbPaisMatriz.ListIndex = -1 Then
      sCadena = sCadena & "- No ha Ingresado Pais de Casa Matríz" & vbCrLf
   End If
   
   If Me.cmbTipoCliente.ListIndex < 0 Then
      sCadena = sCadena & "- Debe Ingresar el Tipo de Cliente " & vbCrLf
      Exit Function

   End If

   Screen.MousePointer = 0

   If sCadena <> "" Then
      sCadena = "Falta ingresar los siguientes datos" & vbCrLf & vbCrLf & sCadena

      MsgBox sCadena, vbExclamation, Me.Caption

   Else
      FUNC_ValidarDatos = True

   End If

End Function

Private Sub ChkBloqueado_KeyPress(KeyAscii As Integer)

   Bac_SendKey (vbKeyTab)

End Sub

Private Sub chkFirma_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub chkInformeSocial_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub chkOficinas_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub chkPoder_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub cmbActividadEconomica_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub CmbCalidadJuridica_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      If cmbRelBanco.Enabled = True Then
         cmbRelBanco.SetFocus

      Else
         Bac_SendKey (vbKeyTab)

      End If

   End If

End Sub

Private Sub cmbCategoriaDeudor_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub CmbCiudad_Click()

   If CmbCiudad.ListIndex > -1 Then
      nCodigo = CmbCiudad.ItemData(CmbCiudad.ListIndex)
      Call FUNC_LlenarLocalidades(CmbComuna, COMUNA, nCodigo)

   End If

End Sub

Private Sub CmbCiudad_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub cmbComInstitucional_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub cmbComuna_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub cmbExige_Click()

   If Me.cmbExige.ListIndex = 0 Then
      Me.txtctacte.Enabled = False
      Me.TxtCtaUSD.Enabled = False

   Else
      Me.txtctacte.Enabled = True
      Me.TxtCtaUSD.Enabled = True
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub cmbExige_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub CmbLinea_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub CmbMercado_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub CmbPais_Click()

   If cmbPais.ListIndex > -1 Then
      nCodigo = cmbPais.ItemData(cmbPais.ListIndex)
      Call FUNC_LlenarLocalidades(CmbRegion, REGION, nCodigo)
      CmbCiudad.Clear
      CmbComuna.Clear

   End If

End Sub

Private Sub CmbPais_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub cmbPaisMatriz_Change()
   If cmbPaisMatriz.ListIndex > -1 Then
      nCodigo = cmbPaisMatriz.ItemData(cmbPaisMatriz.ListIndex)
   End If

End Sub

Private Sub cmbPaisMatriz_Click()
   If cmbPaisMatriz.ListIndex > -1 Then
      nCodigo = cmbPaisMatriz.ItemData(cmbPaisMatriz.ListIndex)
   End If
End Sub

Private Sub CmbRegion_Click()

   If CmbRegion.ListIndex > -1 Then
      nCodigo = CmbRegion.ItemData(CmbRegion.ListIndex)
      Call FUNC_LlenarLocalidades(CmbCiudad, Ciudad, nCodigo)
      CmbCiudad.ListIndex = -1
      CmbComuna.Clear

   End If

End Sub

Private Sub CmbRegion_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub cmbRelBanco_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub cmbRGBanco_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub cmbTipoCliente_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      If cmbRGBanco.Enabled = True Then
         Bac_SendKey (vbKeyTab)

      Else
         Bac_SendKey (vbKeyTab)

      End If

   End If

End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

   On Error GoTo Errores

   Dim opcion        As Integer

   opcion = 0

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
      Select Case KeyCode
      Case vbKeyLimpiar:
         opcion = 1

      Case vbKeyGrabar:
         opcion = 2

      Case vbKeyEliminar:
         opcion = 3

      Case vbKeyBuscar:
         opcion = 4

      Case vbKeySalir:
         opcion = 5

      End Select

      If opcion <> 0 Then
         If Toolbar1.Buttons(opcion).Enabled Then
            Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))

         End If

         KeyCode = 0

      End If

   End If

   On Error GoTo 0

   Exit Sub

Errores:
   Resume Next
   On Error GoTo 0

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   Norepi = 0
   CodigoFox = 0

   Me.Icon = BAC_Parametros.Icon

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub Form_Load()

   OptLocal = Opt

   On Error GoTo Errores

   Me.top = 0
   Me.left = 0
   LimpiaYN = False
   Me.top = 1
   Me.left = 15
   swauxiliar = 0

   Call PROC_Carga
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")

   OpImplic(2).Value = True

   Call FUNC_HabilitarControles(False)
   TxtNombre.Enabled = False

   Call PROC_LIMPIAR
   txtCodigo.Text = ""
   Call FUNC_HabilitarControles(False)
   Toolbar1.Buttons(3).Enabled = False

   TabStrip1.Tab = 0
   txtCodigo.Text = ""

   Call FUNC_LlenarLocalidades(cmbPais, PAISES, 0)
   Call FUNC_LlenarLocalidades(cmbPaisMatriz, PAISES, 0)

   cmbExige.AddItem "NO"
   cmbExige.AddItem "SI"
   cmbExige.ListIndex = 0
   Me.txtctacte.Enabled = False
   Me.TxtCtaUSD.Enabled = False

   ID1.Enabled = True
   ID2.Enabled = False
   ID3.Enabled = False
   ID4.Enabled = False

   On Error GoTo 0

   Exit Sub

Errores:
   MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
   On Error GoTo 0
   Unload Me
   Exit Sub

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")

End Sub

Private Sub opBanco_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub opCliente_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub OpImplic_Click(Index As Integer, Value As Integer)
   If Index = 0 Then
      TxtCod.MaxLength = 9
   ElseIf Index = 1 Then
      TxtCod.MaxLength = 6
   ElseIf Index = 2 Then
      TxtCod.MaxLength = 11
   End If
End Sub

Private Sub OpImplic_KeyPress(Index As Integer, KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)
   End If

End Sub

Private Sub SS1_Click(Value As Integer) '®

   Me.txtRutCasaMatriz.TabStop = True
   Me.txtRutCasaMatriz.Enabled = True
  ' Me.cmbPaisMatriz.TabStop = True
 '  Me.cmbPaisMatriz.Enabled = True
   
End Sub

Private Sub SS1_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub SS2_Click(Value As Integer) '®

   Me.txtRutCasaMatriz.Text = 0
   Me.cmbPaisMatriz.ListIndex = -1
   Me.LblDV.Text = ""
   Me.txtRutCasaMatriz.TabStop = False
   Me.txtRutCasaMatriz.Enabled = False
  ' Me.cmbPaisMatriz.TabStop = False
   'Me.cmbPaisMatriz.Enabled = False
   
End Sub

Private Sub SS2_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub SS3_Click() '®

   Me.txtRutCasaMatriz.Text = 0
   Me.cmbPaisMatriz.ListIndex = -1
   Me.LblDV.Text = ""
   Me.txtRutCasaMatriz.TabStop = False
   Me.txtRutCasaMatriz.Enabled = False
  ' Me.cmbPaisMatriz.TabStop = False
  ' Me.cmbPaisMatriz.Enabled = False
   
End Sub

Private Sub SS3_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub SSFrame1_Click()

   Bac_SendKey (vbKeyTab)

End Sub

Private Sub SSFrame2_Click()

   Bac_SendKey (vbKeyTab)

End Sub

Private Sub SSFrame7_Click()

   Bac_SendKey (vbKeyTab)

End Sub

Private Sub SSOption1_Click(Value As Integer)

   PROC_TipoNombre True
   SSOption1.Tag = txtgeneric.Text
   txtgeneric.Text = ""
   txtgeneric.Enabled = False
   Txt1Nombre.Text = Txt1Nombre.Tag: Txt2Nombre.Text = Txt2Nombre.Tag
   Txt1Apellido.Text = Txt1Apellido.Tag: Txt2Apellido.Text = Txt2Apellido.Tag

   Txt1Nombre.Enabled = True: Txt2Nombre.Enabled = True
   Txt1Apellido.Enabled = True: Txt2Apellido.Enabled = True

   TxtNombre.Tag = TxtNombre.Text
   TxtNombre = ""
   TxtNombre.Enabled = False

   cmbRGBanco.Enabled = False
   cmbRelBanco.Enabled = True

'   Bac_SendKey (vbKeyTab)

End Sub

Private Sub SSOption2_Click(Value As Integer)

   PROC_TipoNombre False

   If SSOption1.Tag <> "" Then
      txtgeneric.Text = SSOption1.Tag

   End If

   txtgeneric.Enabled = True

   Txt1Nombre.Tag = Txt1Nombre.Text: Txt2Nombre.Tag = Txt2Nombre.Text
   Txt1Apellido.Tag = Txt1Apellido.Text: Txt2Apellido.Tag = Txt2Apellido.Text

   Txt1Nombre = ""
   Txt2Nombre = ""
   Txt1Apellido = ""
   Txt2Apellido = ""

   Txt1Nombre.Enabled = False
   Txt2Nombre.Enabled = False
   Txt1Apellido.Enabled = False
   Txt2Apellido.Enabled = False

   cmbRGBanco.Enabled = True
   cmbRelBanco.Enabled = False

   TxtNombre.Text = TxtNombre.Tag
   TxtNombre.Enabled = True

   'cmbRelBanco.ListIndex = 0
   'cmbRelBanco.Enabled = False

'   Bac_SendKey (vbKeyTab) 'habilitado

End Sub

Private Sub TabStrip1_Click(PreviousTab As Integer)

   ID1.Visible = False
   ID2.Visible = False
   ID3.Visible = False
   ID4.Visible = False

   With TabStrip1
      If .Caption = "Identificacion Cliente" Then
         ID1.Enabled = True
         ID2.Enabled = False
         ID3.Enabled = False
         ID4.Enabled = False
         ID1.Visible = True

      ElseIf .Caption = "Domicilio" Then
         ID1.Enabled = False
         ID2.Enabled = True
         ID3.Enabled = False
         ID4.Enabled = False
         ID2.Visible = True

      ElseIf .Caption = "Datos Generales" Then
         ID1.Enabled = False
         ID2.Enabled = False
         ID3.Enabled = True
         ID4.Enabled = False
         ID3.Visible = True

      ElseIf .Caption = "Mesa Empresa" Then
         ID1.Enabled = False
         ID2.Enabled = False
         ID3.Enabled = False
         ID4.Enabled = True
         ID4.Visible = True

      End If

   End With

End Sub

Private Sub TabStrip1_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Dim CODI             As Variant
   Dim codigo           As Integer
   Dim Nombre           As String * 40
   Dim Implic           As String
   Dim opcion           As String
   Dim Aba              As String
   Dim Chips            As String
   Dim Swift            As String
   Dim tipocliente      As String
   Dim InformeSocial    As String
   Dim Articulo85       As String
   Dim FechaArt85       As Date
   Dim DecArticulo85    As String
   Dim Poder            As String
   Dim Firma            As String
   Dim fecingr          As Date
   Dim Oficina          As String
   Dim Rut_Grupo        As Double
   Dim Sql              As String
   Dim valor_nuevo      As String

   On Error GoTo Errores

   Select Case Button.Index
   Case 1
      
      
      SSOption2_Click 1
      Call PROC_LIMPIAR
      txtCodigo.Text = ""
      Call FUNC_HabilitarControles(False)
      Toolbar1.Buttons(3).Enabled = False
      Toolbar1.Buttons(4).Enabled = True
      Me.TabStrip1.Tab = 0
      txtRut.Enabled = True
      txtRut.SetFocus
      Exit Sub

   Case 2
      
      If Not FUNC_RUT_CASA_MATRIZ Then
         Exit Sub
         
      End If
      
      SW = 0
      fecingr = Date
      Me.MousePointer = 0

      If Not FUNC_ValidarDatos() Then   'Validación de los datos del cliente.
         Me.MousePointer = 0
         Exit Sub

      End If

      If SSOption2.Value = False Then
         OPTI = "N"
         Nombre = Trim(Txt1Nombre.Text) & " " & Trim(Txt2Nombre.Text) & " " & Trim(Txt1Apellido.Text) & " " & Trim(Txt2Apellido.Text)

      Else
         OPTI = "J"
         Nombre = Trim(TxtNombre.Text)

      End If

      tipocliente = FUNC_ENTREGA_TIPO_CLIENTE(cmbTipoCliente)

      If chkInformeSocial.Value = 0 Then
         InformeSocial = "N"

      Else
         InformeSocial = "S"

      End If

      If chkOficinas.Value = 0 Then
         Oficina = "N"

      Else
         Oficina = "S"

      End If

      If chkPoder.Value = 0 Then
         Poder = "N"

      Else
         Poder = "S"

      End If

      If chkFirma.Value = 0 Then
         Firma = "N"

      Else
         Firma = "S"

      End If

      If OpImplic(0).Value = True Then
         Implic = "A"
         Aba = TxtCod.Text

      ElseIf OpImplic(1).Value = True Then
         Implic = "C"
         Chips = TxtCod.Text

      Else
         Implic = "S"
         Swift = TxtCod.Text

      End If

      If SSOption1.Value = True Then
         opcion = "N"

      Else
         opcion = "J"

      End If

      '------------------------------------------------------------------------
      valor_nuevo = ""
      valor_nuevo = valor_nuevo & " Rut Cliente: " & txtRut.Text
      valor_nuevo = valor_nuevo & " Cod Cliente: " & txtCodigo.Text
      valor_nuevo = valor_nuevo & " Generico: " & txtgeneric.Text
      valor_nuevo = valor_nuevo & " Tipo Cliente " & cmbTipoCliente.Text

      Envia = Array()
      AddParam Envia, CDbl(Trim(txtRut.Text))                          'Rut
      AddParam Envia, Trim(txtDigito.Text)                             'Dig. Verificador
      AddParam Envia, CDbl(Trim(txtCodigo.Text))                       'Código
      AddParam Envia, Trim(Nombre)                                     'Nombre
      AddParam Envia, Trim(txtgeneric.Text)                            'Generico
      AddParam Envia, Trim(TxtDireccion.Text)                          'Dirección

      If CmbComuna.ListIndex = -1 Then
         AddParam Envia, 0

      Else
         AddParam Envia, CDbl(CmbComuna.ItemData(CmbComuna.ListIndex)) 'Comuna

      End If

      AddParam Envia, CDbl(0)                                          'Región
      AddParam Envia, CDbl(right(cmbTipoCliente.Text, 2))                                'Tipo Cliente

      If Len(Trim$(fecingr)) < 8 Then
         AddParam Envia, Format(gsbac_fecp, "yyyymmdd")               'Fecha Ingreso

      Else
         AddParam Envia, Format(gsbac_fecp, "yyyymmdd")

      End If

      AddParam Envia, Trim(txtctacte.Text)                             'Cuenta Corriente
      AddParam Envia, Trim(TxtTelefono.Text)                           'Telefóno
      AddParam Envia, Trim(txtfax.Text)                                'Fax
      AddParam Envia, Trim(Txt1Apellido.Text)                          'Primer Apellido
      AddParam Envia, Trim(Txt2Apellido.Text)                          'Segundo Apellido
      AddParam Envia, Trim(Txt1Nombre.Text)                            'Primer Nombre
      AddParam Envia, Trim(Txt2Nombre.Text)                            'Segundo nombre

      If CmbCiudad.ListIndex = -1 Then
         AddParam Envia, 0

      Else
         AddParam Envia, CDbl(CmbCiudad.ItemData(CmbCiudad.ListIndex))               'Ciudad

      End If

      AddParam Envia, CDbl(IIf(Trim(right(CmbMercado.Text, 6)) = "", 0, Trim(right(CmbMercado.Text, 6))))        'Mercado
      AddParam Envia, CDbl(cmbPais.ItemData(cmbPais.ListIndex))                'pais
      AddParam Envia, CDbl(IIf(Trim(right(CmbCalidadJuridica.Text, 6)) = "", 0, Trim(right(CmbCalidadJuridica.Text, 6)))) 'Calidad Juridica
      AddParam Envia, IIf(OpImplic(1).Value = True, Trim(TxtCod.Text), "")                                        'Código Chips
      AddParam Envia, IIf(OpImplic(0).Value = True, Trim(TxtCod.Text), "")                                       'Código Aba
      If cmbPaisMatriz.ListIndex = -1 And SS1.Value = True Then
         AddParam Envia, "0"
      Else
'         If SS2.Value Then
'            If cmbPais.ListIndex = -1 Then
'               AddParam Envia, "0"
'            Else
'               AddParam Envia, Trim(CStr(CDbl(cmbPais.ItemData(cmbPais.ListIndex))))                                   'Código Swift
'            End If
'         Else
            AddParam Envia, CDbl(cmbPaisMatriz.ItemData(cmbPaisMatriz.ListIndex))                                   'Código Swift
         End If
      
      AddParam Envia, TxtCtaUSD.Text                                   'Cuenta USD
      AddParam Envia, Trim(Implic)                                     'Implic
      AddParam Envia, Trim(opcion)                                     'Opción

      AddParam Envia, CDbl(IIf(Trim(right(cmbRGBanco.Text, 6)) <> "", Trim(right(cmbRGBanco.Text, 6)), 0))        'Relación Gestión Banco
      AddParam Envia, CDbl(IIf(Trim(right(cmbCategoriaDeudor.Text, 6)) = "", 0, Trim(right(cmbCategoriaDeudor.Text, 6)))) 'Categoría Deudor
      AddParam Envia, FUNC_TraeValor(Trim(right(cmbComInstitucional.Text, 6))) 'Composición Institucional(Sector)

      If SS1.Value Then
         AddParam Envia, "F"

      End If

      If SS2.Value Then
         AddParam Envia, "M"

      End If

      If SS3.Value Then
         AddParam Envia, "O"

      End If

      AddParam Envia, FUNC_TraeValor(Trim(right(cmbActividadEconomica.Text, 6))) 'Actividad económica
      AddParam Envia, CDbl(IIf(Trim(right(cmbTipoCliente.Text, 5)) = "", 0, Trim(right(cmbTipoCliente.Text, 5))))  'tipocliente                                      'Tipo Empresa
      AddParam Envia, CDbl(IIf(Trim(right(cmbRelBanco.Text, 6)) <> "", Trim(right(cmbRelBanco.Text, 6)), 0))       'Relación Banco
      AddParam Envia, Trim(Poder)                                       'Poder
      AddParam Envia, Trim(Firma)                                       'Firma
      AddParam Envia, Trim(InformeSocial)                               'Informe Social
      AddParam Envia, Trim(DecArticulo85)                               'Decl. Art.85
      AddParam Envia, CDbl(txtRutCasaMatriz.Text) '®                    'Rut_Grupo

      If CmbRegion.ListIndex = -1 Then
         AddParam Envia, 0

      Else
         AddParam Envia, CDbl(CmbRegion.ItemData(CmbRegion.ListIndex))                         ' EN LUGAR DEL CODIGO FOX GRABA CODIGO DE REGION

      End If

      AddParam Envia, FUNC_TraeValor(txtCodigoSuper.Text)                        ' Codigo Super
      AddParam Envia, FUNC_TraeValor(txtCodigoBCCH.Text)                         ' Codigo BCCH
      AddParam Envia, Trim(Oficina)                                    'Oficina S/N
      AddParam Envia, Trim(txtCRiesgo.Text)                            'Clasificación de riesgo

      '''''''''''''' Datos Agregados
      AddParam Envia, TxtCodigoOtc.Text
      AddParam Envia, IIf(ChkBloqueado.Value, "S", "N")
      AddParam Envia, left(CmbLinea.Text, 1)
      AddParam Envia, IIf(cmbExige.Text = "SI", "S", "N")

      AddParam Envia, txtcodnif.Text
      If Not BAC_SQL_EXECUTE("SP_CLGRABAR1", Envia) Then
         MsgBox "Error al Grabar el Cliente", vbExclamation
         Call LogAuditoria("01", OptLocal, Me.Caption + " Error al grabar Cliente ", "", valor_nuevo)
         Me.MousePointer = Default
         On Error GoTo 0
         Exit Sub

      End If

      If BAC_SQL_FETCH(Datos()) Then
         If Datos(1) = "OK" Then
      MsgBox "Grabación se realizó correctamente", vbInformation

      Call LogAuditoria("01", OptLocal, Me.Caption + " Grabación Exitosa ", "", valor_nuevo)
         Else
            MsgBox "Registro no fue actualizado, Codigo NIF ya estaba asignado a otra Entidad Emisora", vbInformation
         End If
      End If

      Me.MousePointer = 0
      Call PROC_LIMPIAR
      FUNC_HabilitarControles False
      Toolbar1.Buttons(3).Enabled = False
      Me.txtRut.SetFocus

   Case 3
      Envia = Array()

      AddParam Envia, CDbl(txtRut.Text)
      AddParam Envia, Trim(txtDigito)
      AddParam Envia, CDbl(txtCodigo.Text)

      If Not BAC_SQL_EXECUTE("sp_mdclleerrut", Envia) Then
         MsgBox "Consulta en Bactrader Ha Fallado. Servidor SQL No Responde", vbCritical
         Exit Sub

      End If

      If BAC_SQL_FETCH(Datos()) Then
         If MsgBox("Esta Seguro de Eliminar el Cliente", 36) = 6 Then
            Envia = Array()

            AddParam Envia, CDbl(txtRut.Text)
            AddParam Envia, CDbl(txtCodigo.Text)

            If Not BAC_SQL_EXECUTE("SP_CLELIMINAR1", Envia) Then
               MsgBox "Error: No eliminó el Cliente ", 16
               Call LogAuditoria("03", OptLocal, Me.Caption + " Error al Eliminar- Rut: " & txtRut.Text + "-" + txtDigito.Text, "", "")
               On Error GoTo 0
               Exit Sub

            End If

            If BAC_SQL_FETCH(Datos()) = True Then
               If Datos(1) = 2 Then
                  MsgBox Datos(2), vbInformation

               End If

            Else
               MsgBox "Eliminación se realizó correctamente", vbInformation
               Call LogAuditoria("03", OptLocal, Me.Caption, "Rut: " & txtRut.Text & "-" & txtDigito.Text & " Codigo: " & Me.txtCodigo.Text, "")

            End If

            Call FUNC_HabilitarControles(False)
            Call PROC_LIMPIAR
            Toolbar1.Buttons(3).Enabled = True
            txtRut.SetFocus

         End If

      Else
         MsgBox "Los datos no han sido eliminados", vbCritical
         Call LogAuditoria("03", OptLocal, Me.Caption + " Error al eliminar - Rut: " + txtRut.Text + "-" + txtDigito.Text & " Codigo: " & Me.txtCodigo.Text, "", "")
         txtgeneric.SetFocus

      End If

   Case 4
      If Val(Trim(txtRut.Text)) = 0 Or Trim(txtDigito.Text) = "" Or Val(Trim(txtCodigo.Text)) = 0 Then
         MsgBox "Falta Informacion Para La Busqueda", vbInformation

      Else
         Call FUNC_BuscaCliente(Val(txtRut.Text), Trim(txtDigito.Text), Val(txtCodigo.Text))

      End If

   Case 5
      Me.MousePointer = 0
      Unload Me
      On Error GoTo 0
      Exit Sub

   End Select

Errores:
   On Error GoTo 0

End Sub

Private Sub Txt1Apellido_KeyPress(KeyAscii As Integer)

   Txt1Apellido.MaxLength = 15
   KeyAscii = Caracter_Nombre(KeyAscii)
   BacToUCase KeyAscii

   If IsNumeric(Chr(KeyAscii)) Then
      KeyAscii = 0
   
   End If

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub Txt1Nombre_KeyPress(KeyAscii As Integer)

   KeyAscii = Caracter_Nombre(KeyAscii)
   Txt1Nombre.MaxLength = 15

   BacToUCase KeyAscii

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub


Private Sub Txt2Apellido_KeyPress(KeyAscii As Integer)
   KeyAscii = Caracter_Nombre(KeyAscii)
   Txt2Apellido.MaxLength = 15

   BacToUCase KeyAscii

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub Txt2Nombre_KeyPress(KeyAscii As Integer)

   KeyAscii = Caracter_Nombre(KeyAscii)
   Txt2Nombre.MaxLength = 15

   BacToUCase KeyAscii

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub TxtCod_KeyPress(KeyAscii As Integer)

   KeyAscii = Caracter(KeyAscii)
   BacToUCase KeyAscii

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub txtCodigo_DblClick()

   Call txtRut_DblClick

End Sub

Private Sub TxtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)

   Dim idRut         As Long
   Dim IdDig         As String
   Dim IdCod         As Long
   Dim Bandera       As Integer

   If KeyCode = vbKeyF3 Then
      Call txtRut_DblClick
   End If

   If KeyCode = vbKeyReturn Then
      If Val(Trim(txtRut.Text)) = 0 Or Trim(txtDigito.Text) = "" Then
         Exit Sub

      End If

      Bandera = True

      If Val(Trim(txtCodigo.Text)) = 0 Or Val(Trim(txtRut.Text)) = 0 Then
         If Val(txtCodigo.Text) = 0 Then
            MsgBox "Error : El código no puede ser 0 ", 16

         Else
            MsgBox "Error : Datos en Blanco ", 16

         End If

         Call PROC_LIMPIAR
         Call FUNC_HabilitarControles(False)
         txtRut.SetFocus
         Exit Sub

      End If

'      idRut = txtRut.Text
'      IdDig = txtDigito.Text
'      IdCod = txtCodigo

      Call PROC_InicializaPais

      CmbLinea.Enabled = True
      CmbLinea.Text = "SI"

      Call FUNC_BuscaCliente(idRut, IdDig, IdCod)

'      If SSOption1.Value = True Then
'         Call SSOption1_Click(1)
'
'      Else
'         Call SSOption2_Click(1)
'
'      End If

      If txtgeneric.Enabled = True Then
         txtgeneric.SetFocus

      End If

   End If

End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      Bac_SendKey (vbKeyTab)

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
      BacCaracterNumerico KeyAscii

   End If

End Sub

Private Function FUNC_BuscaCliente(nRut As Long, nDigito As String, nCodigo As Long) As Boolean
   Dim Pais As String
   Dim PaisMatriz As String
   Dim COMUNA As String
   Dim Ciudad As String
   Dim REGION As String
   
   Screen.MousePointer = 11

   FUNC_BuscaCliente = False

   Envia = Array()

   AddParam Envia, nRut
   AddParam Envia, nDigito
   AddParam Envia, nCodigo

   If Not BAC_SQL_EXECUTE("sp_mdclleerrut", Envia) Then
      MsgBox "Consulta en BacParametros Ha Fallado. Servidor SQL No Responde", vbCritical
      Exit Function

   End If

   If BAC_SQL_FETCH(Datos()) Then
      txtRut.Text = Val(Datos(1))
      txtDigito.Text = Datos(2)
      txtCodigo.Text = Val(Datos(3))
      TxtNombre.Text = Datos(4)
      TxtNombre.Tag = TxtNombre.Text
      txtgeneric.Text = Datos(5)
      TxtDireccion.Text = Datos(6)
      txtctacte.Text = Datos(10)
      TxtTelefono.Text = Datos(11)
      txtfax.Text = Datos(12)
      Txt1Nombre.Text = Datos(18)
      Txt1Nombre.Tag = Txt1Nombre.Text
      Txt2Nombre.Text = Datos(19)
      Txt2Nombre.Tag = Txt2Nombre.Text
      Txt1Apellido.Text = Datos(20)
      Txt1Apellido.Tag = Txt1Apellido.Text
      Txt2Apellido.Text = Datos(21)
      Txt2Apellido.Tag = Txt2Apellido.Text
      TxtCtaUSD.Text = Datos(22)
      txtCodigoSuper.Text = Val(Datos(42))
      txtCodigoBCCH.Text = Val(Datos(43))
      txtCRiesgo.Text = Datos(45)
      txtRutCasaMatriz.Text = Datos(40)
      Me.LblDV.Text = FUNC_DevuelveDig(txtRutCasaMatriz.Text)
      txtRutCasaMatriz.Text = Datos(49)
      txtcodnif.Text = Datos(50)
      TxtCod.Text = Datos(24)
      cmbExige.ListIndex = IIf(Datos(39) = "S", 1, 0)
      Pais = CDbl(Datos(17))
      COMUNA = CDbl(Datos(7))
      Ciudad = CDbl(Datos(15))
      REGION = CDbl(Datos(41))
      
      
      If CmbCalidadJuridica.ListCount > 0 Then
         CmbCalidadJuridica.ListIndex = FUNC_BuscaCodigoCombo(CmbCalidadJuridica, Str(Datos(14)))

      End If

      If CmbMercado.ListCount > 0 Then
         CmbMercado.ListIndex = FUNC_BuscaCodigoCombo(CmbMercado, Str(Datos(16)))

      End If

      If cmbRGBanco.ListCount > 0 Then
         cmbRGBanco.ListIndex = FUNC_BuscaCodigoCombo(cmbRGBanco, Str(Datos(28)))

      End If

      If cmbCategoriaDeudor.ListCount > 0 Then
         cmbCategoriaDeudor.ListIndex = FUNC_BuscaCodigoCombo(cmbCategoriaDeudor, Str(Datos(29)))

      End If

      If cmbComInstitucional.ListCount > 0 Then
         cmbComInstitucional.ListIndex = FUNC_BuscaCodigoCombo(cmbComInstitucional, Str(Datos(30)))

      End If

      If cmbTipoCliente.ListCount > 0 Then
         cmbTipoCliente.ListIndex = FUNC_BuscaCodigoCombo(cmbTipoCliente, Str(Datos(13)))

      End If

      If Datos(31) = "F" Then
         SS1.Value = True

      End If

      If Datos(31) = "M" Then
         SS2.Value = True

      End If

      If Datos(31) = "O" Then
         SS3.Value = True

      End If

      If cmbActividadEconomica.ListCount > 0 Then
         cmbActividadEconomica.ListIndex = FUNC_BuscaCodigoCombo(cmbActividadEconomica, Str(Datos(32)))

      End If

      If cmbRelBanco.ListCount > 0 Then
         cmbRelBanco.ListIndex = FUNC_BuscaCodigoCombo(cmbRelBanco, Str(Datos(34)))

      End If

      'CHECK Y OPTIONS
      If Datos(24) <> "" Then
         OpImplic(0).Value = True                           'Si es código ABA
         TxtCod.Text = Datos(24)

      ElseIf Datos(25) <> "" Then
         OpImplic(1).Value = True                           'Si es código CHIPS
         TxtCod.Text = Datos(25)

      End If

      If Trim(Datos(26)) = "" Then
         PaisMatriz = CDbl(0)
      Else
         PaisMatriz = CDbl(Datos(26))
      End If



      TxtCodigoOtc.Text = Datos(46)
      ChkBloqueado.Value = IIf(Datos(47) = "S", 1, 0)

      chkPoder.Value = IIf(Datos(35) = "N", 0, 1)                     'Check Poder: Toma valores 1 ó 0
      chkFirma.Value = IIf(Datos(36) = "N", 0, 1)                      'Check Firma: Toma valores 1 ó 0
      chkInformeSocial.Value = IIf(Datos(37) = "N", 0, 1)         'Check Inf.Social: Toma valores 1 ó 0
      chkOficinas.Value = IIf(Datos(44) = "N", 0, 1)

      If Datos(45) = "N" Then                                                  'check Art. 85 :Toma valores 1 ó 0
      Else
         If Datos(46) = "C" Then                                               'Si la dec 85 es cliente o banco
            opCliente.Value = True

         Else
            opBanco.Value = True

         End If


      End If

      CmbLinea.Enabled = True
      CmbLinea.Text = Datos(48)
      
      
      If Datos(27) = "J" Then
         SSOption1.Value = False
         SSOption2.Value = True
         Call SSOption2_Click(1)
      Else
         SSOption1.Value = True
         SSOption2.Value = False
         Call SSOption1_Click(1)
      End If
      
      
      cmbPais.ListIndex = FUNC_BuscaCodigoCombo(cmbPais, CDbl(Pais))
      cmbPaisMatriz.ListIndex = FUNC_BuscaCodigoCombo(cmbPaisMatriz, CDbl(PaisMatriz))
      CmbRegion.ListIndex = FUNC_BuscaCodigoCombo(CmbRegion, CDbl(REGION))
      CmbCiudad.ListIndex = FUNC_BuscaCodigoCombo(CmbCiudad, CDbl(Ciudad))
      CmbComuna.ListIndex = FUNC_BuscaCodigoCombo(CmbComuna, CDbl(COMUNA))
   

   Else
      TxtNombre.Text = ""
      TxtNombre.Tag = ""
      txtgeneric.Text = ""
      TxtDireccion.Text = ""
      txtctacte.Text = ""
      TxtTelefono.Text = ""
      txtfax.Text = ""
      Txt1Nombre.Text = ""
      Txt1Nombre.Tag = ""
      Txt2Nombre.Text = ""
      Txt2Nombre.Tag = ""
      Txt1Apellido.Text = ""
      Txt1Apellido.Tag = ""
      Txt2Apellido.Text = ""
      Txt2Apellido.Tag = ""
      TxtCtaUSD.Text = ""
      txtCRiesgo.Text = ""

      'CHECK Y OPTIONS
      OpImplic(0).Value = True                           'Si es código ABA
      TxtCod.Text = ""
      chkPoder.Value = 0
      chkFirma.Value = 0
      chkInformeSocial.Value = 0
      opCliente.Value = True

   End If

   Call FUNC_HabilitarControles(True)
   Toolbar1.Buttons(4).Enabled = False
   
   If txtRut.Text = "" Then
      Screen.MousePointer = 0
      DoEvents
      
      SSOption2_Click 1
      Call PROC_LIMPIAR
      txtCodigo.Text = ""
      Call FUNC_HabilitarControles(False)
      Toolbar1.Buttons(3).Enabled = False
      Toolbar1.Buttons(4).Enabled = True
      Me.TabStrip1.Tab = 0
      txtRut.Enabled = True
      txtRut.SetFocus

      Exit Function
   End If
   
   Screen.MousePointer = 0

   DoEvents

End Function

Private Sub TxtCodigo_LostFocus()
Call FUNC_BuscaCliente(Val(txtRut.Text), txtDigito.Text, Val(txtCodigo.Text))
     
End Sub

Private Sub txtCodigoBCCH_KeyPress(KeyAscii As Integer)

   txtCodigoBCCH.MaxLength = 3


   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)
      Exit Sub

   End If

   If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 13 And KeyAscii <> 8 Then
      KeyAscii = 0

   End If

End Sub

Private Sub TxtCodigoOtc_KeyPress(KeyAscii As Integer)

   KeyAscii = Caracter(KeyAscii)
   BacToUCase KeyAscii

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)


   End If

End Sub

Private Sub txtCodigoSuper_KeyPress(KeyAscii As Integer)

   txtCodigoSuper.MaxLength = 3

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)
      Exit Sub

   End If

   If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 13 And KeyAscii <> 8 Then
      KeyAscii = 0

   End If

End Sub

Private Sub txtcodnif_KeyPress(KeyAscii As Integer)
   KeyAscii = Caracter(KeyAscii)
   BacToUCase KeyAscii

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub txtCRiesgo_KeyPress(KeyAscii As Integer)

   KeyAscii = Caracter(KeyAscii)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)
      Exit Sub

   End If

   BacToUCase KeyAscii

End Sub

Private Sub txtctacte_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii

   If KeyAscii = 39 Or KeyAscii = 34 Then
      KeyAscii = 0

   ElseIf KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub TxtCtaUSD_KeyPress(KeyAscii As Integer)

   KeyAscii = Caracter(KeyAscii)
   BacToUCase KeyAscii

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub txtDigito_GotFocus()

   If Me.txtRut.Text = "" Then
      txtRut.Enabled = True
      txtRut.SetFocus
   End If

End Sub

Private Sub txtDigito_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      Bac_SendKey (vbKeyTab)

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 75 Or KeyAscii = 107 Or KeyAscii = 8) Then
      KeyAscii = 0

   End If

   BacToUCase KeyAscii

End Sub

Private Sub txtDigito_LostFocus()

   On Error GoTo Errores

   If Val(Trim(txtRut.Text)) <> 0 Then
      If Val(txtCodigo.Text) = 0 Then
         txtCodigo.Text = 1

      End If

      If Not Controla_RUT(txtRut, txtDigito) Then
         MsgBox "Digito No corresponde al RUT.", vbOKOnly + vbExclamation
         txtDigito.Text = ""
         txtRut.SetFocus

      End If

   End If

   On Error GoTo 0

   Exit Sub

Errores:

   On Error GoTo 0

End Sub

Private Sub TxtDireccion_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii

   If KeyAscii = 39 Or KeyAscii = 34 Then
      KeyAscii = 0

   ElseIf KeyAscii = vbKeyReturn Or KeyAscii = vbKeyTab Then
      KeyAscii = 0
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub txtfax_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii

   If KeyAscii = 39 Or KeyAscii = 34 Then
      KeyAscii = 0

   ElseIf KeyAscii = vbKeyReturn Or KeyAscii = vbKeyTab Then
      KeyAscii = 0
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub txtgeneric_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii

   If KeyAscii = 39 Or KeyAscii = 34 Then
      KeyAscii = 0

   ElseIf KeyAscii = vbKeyReturn Then
      KeyAscii = 0

      If SSOption1.Value = True Then
         Bac_SendKey (vbKeyTab)

      Else
         Bac_SendKey (vbKeyTab)

      End If

   End If

End Sub

Private Sub txtgeneric_LostFocus()

   Me.MousePointer = Default

End Sub

Private Sub TxtNombre_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)

   KeyAscii = Caracter(KeyAscii)
   BacToUCase KeyAscii

End Sub

Private Sub txtRutCasaMatriz_DblClick()

   BacControlWindows 100
   MiTag = "MATRIZ"
   BacAyuda.Show 1

   If giAceptar% = True Then
      Me.txtRutCasaMatriz.Text = Val(gsCodigo)
      Me.LblDV.Text = gsDigito$
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub txtRutCasaMatriz_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyF3 Then
      Call txtRutCasaMatriz_DblClick

   End If

End Sub

Private Sub txtRutCasaMatriz_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Function FUNC_RUT_CASA_MATRIZ() As Boolean

   FUNC_RUT_CASA_MATRIZ = False

   If Len(txtRutCasaMatriz.Text) > 5 Then
      Me.LblDV.Text = FUNC_DevuelveDig(CDbl(Me.txtRutCasaMatriz.Text))
      Envia = Array()

      AddParam Envia, Replace(txtRutCasaMatriz.Text, gsc_SeparadorMiles, "")
      AddParam Envia, LblDV
      AddParam Envia, 1

      If Not BAC_SQL_EXECUTE("sp_mdclleerrut", Envia) Then
         MsgBox "Consulta en BacParametros Ha Fallado. Servidor SQL No Responde", vbCritical
         Exit Function

      End If

      If Not BAC_SQL_FETCH(Datos()) Then
         MsgBox "Rut de Casa Matriz no Existe", vbInformation
         Me.txtRutCasaMatriz.Text = ""
         Me.LblDV.Text = ""
         Me.TabStrip1.Tab = 3
         Me.txtRutCasaMatriz.SetFocus
         Exit Function
      End If

   End If

   FUNC_RUT_CASA_MATRIZ = True

End Function

Private Sub txtRutCasaMatriz_LostFocus() '®

   If Len(txtRutCasaMatriz.Text) > 5 Then
      Me.LblDV.Text = FUNC_DevuelveDig(CDbl(Me.txtRutCasaMatriz.Text))
      Envia = Array()

      AddParam Envia, Replace(txtRutCasaMatriz.Text, gsc_SeparadorMiles, "")
      AddParam Envia, LblDV
      AddParam Envia, 1

      If Not BAC_SQL_EXECUTE("sp_mdclleerrut", Envia) Then
         MsgBox "Consulta en BacParametros Ha Fallado. Servidor SQL No Responde", vbCritical, TITSISTEMA
         Exit Sub

      End If

      If Not BAC_SQL_FETCH(Datos()) Then
         MsgBox "Rut de Casa Matriz no Existe", vbInformation
         Me.txtRutCasaMatriz.Text = ""
         Me.LblDV.Text = ""
         Me.TabStrip1.Tab = 3
         'Me.txtRutCasaMatriz.SetFocus

      End If

   End If

End Sub

Private Sub txtRut_DblClick()

   MiTag = "MDCL"
   
   BacAyuda.Show 1

   If giAceptar% = True Then
      txtRut.Text = Val(gsrut$)
      txtDigito.Text = gsDigito$
      txtCodigo.Text = gsValor$

      Call FUNC_BuscaCliente(Val(gsrut$), gsDigito$, Val(gsValor$))
      Call FUNC_HabilitarControles(True)
      Bac_SendKey (vbKeyTab)

      Call txtRut_LostFocus

   End If

End Sub

Private Sub txtRut_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyF3 Then
      Call txtRut_DblClick

   End If

End Sub

Private Sub txtRut_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      If Val(Trim(txtRut.Text)) > 0 Then
         txtDigito.Text = FUNC_DevuelveDig(txtRut.Text)

      End If

      Bac_SendKey (vbKeyTab)

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0

   End If

   BacCaracterNumerico KeyAscii

End Sub

Private Sub txtRut_LostFocus()

   If Len(txtRut.Text) > 5 Then
      If Val(Trim(txtRut.Text)) > 0 Then
         txtDigito.Text = FUNC_DevuelveDig(txtRut.Text)
         txtDigito.Enabled = False

      End If

      txtCodigo.Text = IIf(txtCodigo.Text = "", 1, txtCodigo.Text)

   End If

End Sub

Private Sub TxtTelefono_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii

   If KeyAscii = 39 Or KeyAscii = 34 Then
      KeyAscii = 0

   ElseIf KeyAscii = vbKeyReturn Or KeyAscii = vbKeyTab Then
      KeyAscii = 0
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub PROC_TipoNombre(Valor As Boolean)

   Txt1Nombre.Visible = Valor
   Txt2Nombre.Visible = Valor
   Txt1Apellido.Visible = Valor
   Txt2Apellido.Visible = Valor
   Label(2).Visible = Valor
   Label(20).Visible = Valor
   Label(21).Visible = Valor
   Label(18).Visible = Not Valor
   TxtNombre.Visible = Not Valor

End Sub


Private Function FUNC_ENTREGA_TIPO_CLIENTE(Combo As Control) As Integer

   FUNC_ENTREGA_TIPO_CLIENTE = 1

   'Sql = "SELECT Codigo_Tipo_Cliente FROM TIPO_CLIENTE WHERE Codigo_Tipo_Cliente =" + Trim(Right(Combo.Text, 4)) + ""
   Sql = "SP_CON_TIPO_CLIENTE " & Trim(right(Combo.Text, 4))

   If Not BAC_SQL_EXECUTE(Sql) Then
      Exit Function

   End If

   If BAC_SQL_FETCH(Datos()) Then
      FUNC_ENTREGA_TIPO_CLIENTE = Val(Datos(1))

   End If

End Function

Private Function FUNC_ENTREGA_CODIGO_CLIENTE(ftipocliente As Integer) As String

   FUNC_ENTREGA_CODIGO_CLIENTE = 1

   For i = 0 To cmbTipoCliente.ListCount - 1
      cmbTipoCliente.ListIndex = i

      If Trim(right(cmbTipoCliente.Text, 5)) = Trim(Str(ftipocliente)) Then
         cmbTipoCliente.ListIndex = i
         Exit Function

      End If

   Next i

End Function

Private Sub FUNC_BUSCA_CODIGOS_MDTC(Codigo_Mdtc As String, Combo As Control)

   If swauxiliar = 0 Then
      Envia = Array()

      AddParam Envia, Codigo_Mdtc

      If Not BAC_SQL_EXECUTE("sp_leercodigos2", Envia) Then
         Exit Sub

      End If

      Do While BAC_SQL_FETCH(Datos())
         If Codigo_Mdtc = MDTC_CLASIFICACION Then
            Combo.AddItem Trim(Datos(1)) & Space((10 - Len(Datos(1)))) & Trim(Datos(2))
            Combo.ItemData(Combo.NewIndex) = Trim(Datos(2))
         Else
            Combo.AddItem Trim(Datos(3)) & Space(60) & Trim(Datos(1)) & Space(10) & Trim(Datos(2))
            Combo.ItemData(Combo.NewIndex) = Trim(Datos(2))
         End If

      Loop

   Else
      Sql = "sp_traecategoria2"

      If Not BAC_SQL_EXECUTE("sp_traecategoria2") Then
         Exit Sub

      End If

      Do While BAC_SQL_FETCH(Datos())
         Combo.AddItem Trim(Datos(2)) & Space(50) & Trim(Datos(1))
         Combo.ItemData(Combo.NewIndex) = Trim(Datos(1))
      Loop

   End If

End Sub

Private Function FUNC_TraeValor(xValor As Variant) As Double

   If xValor = "" Then
      FUNC_TraeValor = 0

   Else
      FUNC_TraeValor = xValor

   End If

End Function

Private Sub PROC_Carga()

   Call PROC_BUSCAPAIS
   Call PROC_BUSCACIUDAD

   Call FUNC_BUSCA_CODIGOS_MDTC(MDTC_MERCADO, CmbMercado)
   Call FUNC_BUSCA_CODIGOS_MDTC(MDTC_CALIDADJURIDICA, CmbCalidadJuridica)
   Call FUNC_BUSCA_CODIGOS_MDTC(MDTC_RGBANCO, cmbRGBanco)
   Call FUNC_BUSCA_CODIGOS_MDTC(MDTC_RELACION, cmbRelBanco)
   Call FUNC_BUSCA_CODIGOS_MDTC(MDTC_CATEGORIADEUDOR, cmbCategoriaDeudor)
   Call FUNC_BUSCA_CODIGOS_MDTC(MDTC_TIPOCLIENTE, cmbTipoCliente)
   swauxiliar = 0
   Call FUNC_BUSCA_CODIGOS_MDTC(MDTC_COMINSTITUCIONAL, cmbComInstitucional)
   Call FUNC_BUSCA_CODIGOS_MDTC(MDTC_ACTIVIDADECONOMICA, cmbActividadEconomica)

End Sub

Private Function FUNC_DevuelveDig(Rut As String) As String

   Dim i          As Integer
   Dim D          As Integer
   Dim Divi       As Long
   Dim Suma       As Long
   Dim Digito     As String
   Dim Multi      As Double

   FUNC_DevuelveDig = ""

   Rut = Format(Rut, Mid$("00000000000", 1, Len(Rut)))

   D = 2

   For i = Len(Rut) To 1 Step -1
      Multi = Val(Mid$(Rut, i, 1)) * D
      Suma = Suma + Multi
      D = D + 1

      If D = 8 Then
         D = 2

      End If

   Next i

   Divi = (Suma \ 11)
   Multi = Divi * 11
   Digito = Trim$(Str$(11 - (Suma - Multi)))

   If Digito = "10" Then
      Digito = "K"

   End If

   If Digito = "11" Then
      Digito = "0"

   End If

   FUNC_DevuelveDig = UCase(Digito)

End Function

Private Sub PROC_BUSCAPAIS()

   If Not BAC_SQL_EXECUTE("SP_MOSTRAR_PAIS") Then
      Unload Me
      Exit Sub

   End If

   Do While BAC_SQL_FETCH(Datos())
      cmbPais.AddItem UCase(Datos(2)) & Space(100) & Datos(1)

   Loop

   If cmbPais.ListCount > 0 Then
      cmbPais.ListIndex = 0

   End If

End Sub

Private Sub PROC_BUSCACIUDAD()

   If Not BAC_SQL_EXECUTE("SP_MOSTRAR_CIUDAD") Then
      Unload Me
      Exit Sub

   End If

   Do While BAC_SQL_FETCH(Datos())
      Me.CmbCiudad.AddItem UCase(Datos(3)) & Space(100) & Datos(1)

   Loop

End Sub

Private Function FUNC_LlenarLocalidades(oCombo As Object, nCategoria As Integer, nCodigo As Integer) As Integer

   FUNC_LlenarLocalidades = True

   Envia = Array()
   AddParam Envia, nCategoria
   AddParam Envia, nCodigo

   If Not BAC_SQL_EXECUTE("Sp_LeerLocalidades", Envia) Then
      MsgBox "Problemas al PROC_Cargar localidades.", vbCritical
      FUNC_LlenarLocalidades = False
      Exit Function

   End If

   oCombo.Clear

   Do While BAC_SQL_FETCH(Datos())
      oCombo.AddItem Datos(2)
      oCombo.ItemData(oCombo.NewIndex) = Datos(1)

   Loop

   oCombo.ListIndex = -1

End Function
Private Function FUNC_LlenarLocalidades2(oCombo As Object, nCategoria As Integer, nCodigo As Integer) As Integer

   FUNC_LlenarLocalidades2 = True

   Envia = Array()
   AddParam Envia, nCategoria
   AddParam Envia, nCodigo

   If Not BAC_SQL_EXECUTE("Sp_LeerLocalidades", Envia) Then
      MsgBox "Problemas al PROC_Cargar localidades.", vbCritical
      FUNC_LlenarLocalidades2 = False
      Exit Function

   End If

   oCombo.Clear

   Do While BAC_SQL_FETCH(Datos())
      oCombo.AddItem Datos(2)
      oCombo.ItemData(oCombo.NewIndex) = Datos(3)

   Loop

   oCombo.ListIndex = -1

End Function
Private Function FUNC_BuscaCodigoCombo(oCombo As ComboBox, nCodigo As Long) As Double

   For i = 0 To oCombo.ListCount - 1
      If oCombo.ItemData(i) = nCodigo Then
         FUNC_BuscaCodigoCombo = i
         Exit Function

      End If

   Next i

   FUNC_BuscaCodigoCombo = -1

End Function

Function Caracter_Nombre(KeyAscii As Integer) As Integer

    Caracter_Nombre = KeyAscii
    
    If InStr(1, "?¿¡ªº{}¨Ç/*+:_;´`@~#~€¬!^*·$%&/()=1234567890" & Chr(34), Chr(KeyAscii)) <> 0 Then
       Caracter_Nombre = 0
    End If

End Function

