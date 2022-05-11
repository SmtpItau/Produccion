VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form BacInfBas 
   BackColor       =   &H8000000C&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Información Basica"
   ClientHeight    =   4920
   ClientLeft      =   570
   ClientTop       =   1665
   ClientWidth     =   5685
   Icon            =   "BacInfBas.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4920
   ScaleWidth      =   5685
   Begin MSFlexGridLib.MSFlexGrid Oculta 
      Height          =   2445
      Left            =   30
      TabIndex        =   43
      Top             =   5280
      Width           =   2100
      _ExtentX        =   3704
      _ExtentY        =   4313
      _Version        =   393216
      FixedRows       =   0
      FixedCols       =   0
   End
   Begin TabDlg.SSTab Tab1 
      Height          =   4305
      Left            =   75
      TabIndex        =   8
      Top             =   540
      Width           =   5535
      _ExtentX        =   9763
      _ExtentY        =   7594
      _Version        =   393216
      Style           =   1
      Tabs            =   2
      TabHeight       =   617
      WordWrap        =   0   'False
      ShowFocusRect   =   0   'False
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
      TabCaption(0)   =   "      Capitales            "
      TabPicture(0)   =   "BacInfBas.frx":030A
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Label20"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "Marco1"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "SSFrame1"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "SSPanel2"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).ControlCount=   4
      TabCaption(1)   =   "   Información        "
      TabPicture(1)   =   "BacInfBas.frx":0326
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "SSPanel4"
      Tab(1).Control(1)=   "SSFrame2"
      Tab(1).Control(2)=   "Label21"
      Tab(1).ControlCount=   3
      Begin Threed.SSPanel SSPanel2 
         Height          =   675
         Left            =   180
         TabIndex        =   32
         Top             =   540
         Width           =   5280
         _Version        =   65536
         _ExtentX        =   9313
         _ExtentY        =   1191
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
         BevelOuter      =   0
         Begin BACControles.TXTNumero txtCapRes 
            Height          =   315
            Left            =   2505
            TabIndex        =   1
            TabStop         =   0   'False
            Top             =   0
            Width           =   2715
            _ExtentX        =   4789
            _ExtentY        =   556
            ForeColor       =   8388608
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
            Min             =   "0"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero txtCapBas 
            Height          =   315
            Left            =   2505
            TabIndex        =   2
            TabStop         =   0   'False
            Top             =   330
            Width           =   2715
            _ExtentX        =   4789
            _ExtentY        =   556
            ForeColor       =   8388608
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
            Min             =   "0"
            Max             =   "999999999999999.9999"
            Separator       =   -1  'True
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Patrimonio Efectivo"
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
            Left            =   0
            TabIndex        =   48
            Top             =   330
            Width           =   1665
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Capital Basico"
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
            Left            =   0
            TabIndex        =   47
            Top             =   0
            Width           =   1230
         End
      End
      Begin Threed.SSPanel SSPanel4 
         Height          =   3240
         Left            =   -74595
         TabIndex        =   33
         Top             =   600
         Width           =   4830
         _Version        =   65536
         _ExtentX        =   8520
         _ExtentY        =   5715
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
         BevelOuter      =   0
         Begin BACControles.TXTNumero txtPriTra 
            Height          =   315
            Left            =   2040
            TabIndex        =   9
            TabStop         =   0   'False
            Top             =   210
            Width           =   2715
            _ExtentX        =   4789
            _ExtentY        =   556
            ForeColor       =   8388608
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
            Max             =   "999999999999999.9999"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero txtSegTra 
            Height          =   315
            Left            =   2040
            TabIndex        =   10
            TabStop         =   0   'False
            Top             =   525
            Width           =   2715
            _ExtentX        =   4789
            _ExtentY        =   556
            ForeColor       =   8388608
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
            Max             =   "999999999999999.9999"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero txtTerTra 
            Height          =   315
            Left            =   2040
            TabIndex        =   11
            TabStop         =   0   'False
            Top             =   840
            Width           =   2715
            _ExtentX        =   4789
            _ExtentY        =   556
            ForeColor       =   8388608
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
            Max             =   "999999999999999.9999"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero txtMarIns 
            Height          =   315
            Left            =   2040
            TabIndex        =   12
            TabStop         =   0   'False
            Top             =   1155
            Width           =   2715
            _ExtentX        =   4789
            _ExtentY        =   556
            ForeColor       =   8388608
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
            Max             =   "999999999999999.9999"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero txtTotCarLCHR 
            Height          =   315
            Left            =   2040
            TabIndex        =   13
            TabStop         =   0   'False
            Top             =   1470
            Width           =   2715
            _ExtentX        =   4789
            _ExtentY        =   556
            ForeColor       =   8388608
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
            Max             =   "999999999999999.9999"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero txtTotPorFol 
            Height          =   315
            Left            =   2040
            TabIndex        =   14
            TabStop         =   0   'False
            Top             =   1785
            Width           =   2715
            _ExtentX        =   4789
            _ExtentY        =   556
            ForeColor       =   8388608
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
            Max             =   "999999999999999.9999"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero txtCajPes 
            Height          =   315
            Left            =   2040
            TabIndex        =   15
            TabStop         =   0   'False
            Top             =   2100
            Width           =   2715
            _ExtentX        =   4789
            _ExtentY        =   556
            ForeColor       =   8388608
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
            Max             =   "999999999999999.9999"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero txtCajBCCH 
            Height          =   315
            Left            =   2040
            TabIndex        =   16
            TabStop         =   0   'False
            Top             =   2415
            Width           =   2715
            _ExtentX        =   4789
            _ExtentY        =   556
            ForeColor       =   8388608
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
            Max             =   "999999999999999.9999"
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero txtTotInv 
            Height          =   315
            Left            =   2040
            TabIndex        =   17
            TabStop         =   0   'False
            Top             =   2730
            Width           =   2715
            _ExtentX        =   4789
            _ExtentY        =   556
            ForeColor       =   8388608
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
            Max             =   "999999999999999.9999"
            Separator       =   -1  'True
         End
         Begin VB.Label Label11 
            AutoSize        =   -1  'True
            Caption         =   "Primer Tramo"
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
            Left            =   90
            TabIndex        =   42
            Top             =   210
            Width           =   1125
         End
         Begin VB.Label Label12 
            AutoSize        =   -1  'True
            Caption         =   "Segundo Tramo"
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
            Left            =   90
            TabIndex        =   41
            Top             =   525
            Width           =   1350
         End
         Begin VB.Label Label13 
            AutoSize        =   -1  'True
            Caption         =   "Tercer Tramo"
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
            Left            =   90
            TabIndex        =   40
            Top             =   840
            Width           =   1155
         End
         Begin VB.Label Label14 
            AutoSize        =   -1  'True
            Caption         =   "Margen Institucional"
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
            Left            =   90
            TabIndex        =   39
            Top             =   1155
            Width           =   1740
         End
         Begin VB.Label Label15 
            AutoSize        =   -1  'True
            Caption         =   "Total Cartera LCHR"
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
            Left            =   90
            TabIndex        =   38
            Top             =   1470
            Width           =   1680
         End
         Begin VB.Label Label16 
            AutoSize        =   -1  'True
            Caption         =   "Total Por Folio"
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
            Left            =   90
            TabIndex        =   37
            Top             =   1785
            Width           =   1260
         End
         Begin VB.Label Label17 
            AutoSize        =   -1  'True
            Caption         =   "Caja Pesos"
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
            Left            =   90
            TabIndex        =   36
            Top             =   2100
            Width           =   960
         End
         Begin VB.Label Label18 
            AutoSize        =   -1  'True
            Caption         =   "Caja BCCH"
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
            Left            =   90
            TabIndex        =   35
            Top             =   2415
            Width           =   945
         End
         Begin VB.Label Label19 
            AutoSize        =   -1  'True
            Caption         =   "Total Inversiones"
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
            Left            =   90
            TabIndex        =   34
            Top             =   2730
            Width           =   1485
         End
      End
      Begin Threed.SSFrame SSFrame1 
         Height          =   915
         Left            =   30
         TabIndex        =   46
         Top             =   360
         Width           =   5460
         _Version        =   65536
         _ExtentX        =   9631
         _ExtentY        =   1614
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
         ShadowStyle     =   1
      End
      Begin VB.Frame Marco1 
         Caption         =   "Controles"
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
         Height          =   2985
         Left            =   30
         TabIndex        =   19
         Top             =   1275
         Width           =   5460
         Begin Threed.SSPanel SSPanel3 
            Height          =   2580
            Left            =   90
            TabIndex        =   20
            Top             =   285
            Width           =   5310
            _Version        =   65536
            _ExtentX        =   9366
            _ExtentY        =   4551
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
            BevelOuter      =   0
            Begin VB.ComboBox CmbMonCon 
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
               Left            =   2580
               Style           =   2  'Dropdown List
               TabIndex        =   3
               TabStop         =   0   'False
               Top             =   15
               Width           =   2715
            End
            Begin BACControles.TXTNumero txtValMon 
               Height          =   315
               Left            =   2580
               TabIndex        =   4
               TabStop         =   0   'False
               Top             =   360
               Width           =   2715
               _ExtentX        =   4789
               _ExtentY        =   556
               ForeColor       =   8388608
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
               Max             =   "999999.9999"
               CantidadDecimales=   "4"
               Separator       =   -1  'True
            End
            Begin BACControles.TXTNumero txtPorConRie 
               Height          =   315
               Left            =   2580
               TabIndex        =   5
               TabStop         =   0   'False
               Top             =   675
               Width           =   2715
               _ExtentX        =   4789
               _ExtentY        =   556
               ForeColor       =   8388608
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
               Min             =   "0"
               Max             =   "100"
               Separator       =   -1  'True
            End
            Begin BACControles.TXTNumero txtPorSinRie 
               Height          =   315
               Left            =   2580
               TabIndex        =   6
               TabStop         =   0   'False
               Top             =   990
               Width           =   2715
               _ExtentX        =   4789
               _ExtentY        =   556
               ForeColor       =   8388608
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
               Min             =   "0"
               Max             =   "100"
               Separator       =   -1  'True
            End
            Begin BACControles.TXTNumero txtPorInvExt 
               Height          =   315
               Left            =   2580
               TabIndex        =   7
               TabStop         =   0   'False
               Top             =   1305
               Width           =   2715
               _ExtentX        =   4789
               _ExtentY        =   556
               ForeColor       =   8388608
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
               Min             =   "0"
               Max             =   "100"
               Separator       =   -1  'True
            End
            Begin VB.Label Label10 
               AutoSize        =   -1  'True
               Caption         =   "Inversión Total"
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
               Left            =   60
               TabIndex        =   31
               Top             =   2250
               Width           =   1290
            End
            Begin VB.Label Label9 
               AutoSize        =   -1  'True
               Caption         =   "Monto Sin Riesgo"
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
               Left            =   60
               TabIndex        =   30
               Top             =   1935
               Width           =   1515
            End
            Begin VB.Label Label8 
               AutoSize        =   -1  'True
               Caption         =   "Monto Con Riesgo"
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
               Left            =   60
               TabIndex        =   29
               Top             =   1620
               Width           =   1575
            End
            Begin VB.Label Label7 
               AutoSize        =   -1  'True
               Caption         =   "Porcentaje Inversión Exterior"
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
               Left            =   60
               TabIndex        =   28
               Top             =   1305
               Width           =   2475
            End
            Begin VB.Label Label6 
               AutoSize        =   -1  'True
               Caption         =   "Porcentaje Sin Riesgo"
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
               Left            =   60
               TabIndex        =   27
               Top             =   990
               Width           =   1905
            End
            Begin VB.Label Label5 
               AutoSize        =   -1  'True
               Caption         =   "Porcentaje Con Riesgo"
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
               Left            =   60
               TabIndex        =   26
               Top             =   675
               Width           =   1965
            End
            Begin VB.Label Label4 
               AutoSize        =   -1  'True
               Caption         =   "Valor Moneda"
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
               Left            =   60
               TabIndex        =   25
               Top             =   360
               Width           =   1185
            End
            Begin VB.Label Label3 
               AutoSize        =   -1  'True
               Caption         =   "Moneda Control"
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
               Left            =   60
               TabIndex        =   24
               Top             =   45
               Width           =   1350
            End
            Begin VB.Label LabInvTot 
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
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   2580
               TabIndex        =   23
               Top             =   2250
               Width           =   2715
            End
            Begin VB.Label LabMonSinRie 
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
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   2580
               TabIndex        =   22
               Top             =   1935
               Width           =   2715
            End
            Begin VB.Label LabMonConRie 
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
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   2580
               TabIndex        =   21
               Top             =   1620
               Width           =   2715
            End
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   3900
         Left            =   -74970
         TabIndex        =   49
         Top             =   360
         Width           =   5460
         _Version        =   65536
         _ExtentX        =   9631
         _ExtentY        =   6879
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
      End
      Begin VB.Label Label21 
         Caption         =   "     Información"
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
         Left            =   -73200
         TabIndex        =   45
         Top             =   120
         Width           =   1695
      End
      Begin VB.Label Label20 
         Caption         =   "     Capitales"
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
         TabIndex        =   44
         Top             =   120
         Width           =   1575
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   4440
      Left            =   0
      TabIndex        =   18
      Top             =   480
      Width           =   5685
      _Version        =   65536
      _ExtentX        =   10028
      _ExtentY        =   7832
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
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4080
      Top             =   -105
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacInfBas.frx":0342
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacInfBas.frx":0794
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacInfBas.frx":0AAE
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5685
      _ExtentX        =   10028
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacInfBas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim ValAnt  As String
Dim ValNue  As String

Const blanco = &H80000005
Const Azul = &H800000
Const Negro = &H0&
Const Gris = &HC0C0C0


Sub Carga()

   Dim datos()
   Dim I%

   If Not Bac_Sql_Execute("SP_BACINFORMACIONBASICA_LEEMONEDAS") Then
      MsgBox "No se puede Mostrar", vbCritical, TITSISTEMA
      Exit Sub
   End If
   CmbMonCon.Clear
   Do While Bac_SQL_Fetch(datos())
      CmbMonCon.AddItem (datos(3) & Space(100) & datos(1))
   Loop
   If Not Bac_Sql_Execute("SP_BACINFORMACIONBASICA_LEE") Then
      MsgBox "No se puede Mostrar", vbCritical, TITSISTEMA
      Exit Sub
   End If
   
   If Bac_SQL_Fetch(datos) Then
      txtCapRes.Text = IIf(datos(1) = "SIN DATOS", 0, BacCtrlTransMonto(datos(1)))
      txtCapBas.Text = BacCtrlTransMonto(datos(2))
      If CStr(datos(1)) <> "SIN DATOS" Then
         For I% = 0 To CmbMonCon.ListCount - 1
            CmbMonCon.ListIndex = I%
            If Trim(Right(CmbMonCon, 5)) = Right(datos(3), 5) Then
               Exit For
            End If
         Next I%
      End If
      txtValMon.Text = BacCtrlTransMonto(datos(4))
      txtPorConRie.Text = BacCtrlTransMonto(datos(5))
      txtPorSinRie.Text = BacCtrlTransMonto(datos(6))
      txtPorInvExt.Text = BacCtrlTransMonto(datos(7))
      LabMonConRie.Caption = Format(datos(8), FDecimal)
      LabMonSinRie.Caption = Format(datos(9), FDecimal)
      LabInvTot.Caption = Format(datos(10), FDecimal)
      txtPriTra.Text = BacCtrlTransMonto(datos(11))
      txtSegTra.Text = BacCtrlTransMonto(datos(12))
      txtTerTra.Text = BacCtrlTransMonto(datos(13))
      txtMarIns.Text = BacCtrlTransMonto(datos(14))
      txtTotCarLCHR.Text = BacCtrlTransMonto(datos(15))
      txtTotPorFol.Text = BacCtrlTransMonto(datos(16))
      txtCajPes.Text = BacCtrlTransMonto(datos(17))
      txtCajBCCH.Text = BacCtrlTransMonto(datos(18))
      txtTotInv.Text = BacCtrlTransMonto(datos(19))
      
   End If
   Tab1.Tab = 0
   With Oculta
      .Rows = 20
      
      .TextMatrix(1, 0) = Label1
      .TextMatrix(2, 0) = Label2
      .TextMatrix(3, 0) = Label3
      .TextMatrix(4, 0) = Label4
      .TextMatrix(5, 0) = Label5
      .TextMatrix(6, 0) = Label6
      .TextMatrix(7, 0) = Label7
      .TextMatrix(8, 0) = Label8
      .TextMatrix(9, 0) = Label9
      .TextMatrix(10, 0) = Label10
      .TextMatrix(11, 0) = Label11
      .TextMatrix(12, 0) = Label12
      .TextMatrix(13, 0) = Label13
      .TextMatrix(14, 0) = Label14
      .TextMatrix(15, 0) = Label15
      .TextMatrix(16, 0) = Label16
      .TextMatrix(17, 0) = Label17
      .TextMatrix(18, 0) = Label18
      .TextMatrix(19, 0) = Label19
      
      .TextMatrix(1, 1) = txtCapRes.Text
      .TextMatrix(2, 1) = txtCapBas.Text
      .TextMatrix(3, 1) = CmbMonCon.Text
      .TextMatrix(4, 1) = txtValMon.Text
      .TextMatrix(5, 1) = txtPorConRie.Text
      .TextMatrix(6, 1) = txtPorSinRie.Text
      .TextMatrix(7, 1) = txtPorInvExt.Text
      .TextMatrix(8, 1) = LabMonConRie
      .TextMatrix(9, 1) = LabMonSinRie
      .TextMatrix(10, 1) = LabInvTot
      .TextMatrix(11, 1) = txtPriTra.Text
      .TextMatrix(12, 1) = txtSegTra.Text
      .TextMatrix(13, 1) = txtTerTra.Text
      .TextMatrix(14, 1) = txtMarIns.Text
      .TextMatrix(15, 1) = txtTotCarLCHR.Text
      .TextMatrix(16, 1) = txtTotPorFol.Text
      .TextMatrix(17, 1) = txtCajPes.Text
      .TextMatrix(18, 1) = txtCajBCCH.Text
      .TextMatrix(19, 1) = txtTotInv.Text
   End With
   
End Sub

Sub Graba()
   Dim datos()
   Dim Evento As String
   Dim Datos1
   Dim Nombre
''''''''''   Envia = Array(CDbl(txtCapRes.Text), _
''''''''''                 CDbl(txtCapBas.Text), _
''''''''''                 CDbl(Trim(Right(CmbMonCon, 5))), _
''''''''''                 CDbl(txtValMon.Text), _
''''''''''                 CDbl(txtPorConRie.Text), _
''''''''''                 CDbl(txtPorSinRie.Text), _
''''''''''                 CDbl(txtPorInvExt.Text), _
''''''''''                 CDbl(LabMonConRie.Caption), _
''''''''''                 CDbl(LabMonSinRie.Caption), _
''''''''''                 CDbl(LabInvTot.Caption), _
''''''''''                 CDbl(txtPriTra.Text), _
''''''''''                 CDbl(txtSegTra.Text), _
''''''''''                 CDbl(txtTerTra.Text), _
''''''''''                 CDbl(txtMarIns.Text), _
''''''''''                 CDbl(txtTotCarLCHR.Text), _
''''''''''                 CDbl(txtTotPorFol.Text), _
''''''''''                 CDbl(txtCajPes.Text), _
''''''''''                 CDbl(txtCajBCCH.Text), _
''''''''''                 CDbl(txtTotInv.Text))
                    
   Envia = Array()
   
   AddParam Envia, CDbl(txtCapRes.Text)
   AddParam Envia, CDbl(txtCapBas.Text)
   AddParam Envia, CDbl(Trim(Right(CmbMonCon, 5)))
   AddParam Envia, CDbl(txtValMon.Text)
   AddParam Envia, CDbl(txtPorConRie.Text)
   AddParam Envia, CDbl(txtPorSinRie.Text)
   AddParam Envia, CDbl(txtPorInvExt.Text)
   AddParam Envia, CDbl(LabMonConRie.Caption)
   AddParam Envia, CDbl(LabMonSinRie.Caption)
   AddParam Envia, CDbl(LabInvTot.Caption)
   AddParam Envia, CDbl(txtPriTra.Text)
   AddParam Envia, CDbl(txtSegTra.Text)
   AddParam Envia, CDbl(txtTerTra.Text)
   AddParam Envia, CDbl(txtMarIns.Text)
   AddParam Envia, CDbl(txtTotCarLCHR.Text)
   AddParam Envia, CDbl(txtTotPorFol.Text)
   AddParam Envia, CDbl(txtCajPes.Text)
   AddParam Envia, CDbl(txtCajBCCH.Text)
   AddParam Envia, CDbl(txtTotInv.Text)
                       
   Call BUSCAVALORESMODIFICADOS
   
   If Not Bac_Sql_Execute("SP_BACINFORMACIONBASICA_GRABA", Envia) Then
      MsgBox "No se puede Grabar", vbCritical, TITSISTEMA
      Exit Sub
   End If
   If Bac_SQL_Fetch(datos()) Then
      If Mid(datos(1), 1, 1) = "M" Then
         Evento = "Modificacion"
   
      Else
         Evento = "Grabacion"
         
      End If
      
      MsgBox Evento & " realizada con éxito", vbInformation, TITSISTEMA
   End If
   
   If Evento = "Modificacion" Then
         Call GRABA_LOG_AUDITORIA(1, (gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt10001", "02", "MODIFICACION DE LA OPERACION", "CONTROL_FINANCIERO", ValAnt, ValNue)
   ElseIf Evento = "Grabacion" Then
         Call GRABA_LOG_AUDITORIA(1, (gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt10001", "01", "GRABA OPERACION ", "CONTROL_FINANCIERO", "", ValNue)
   End If
   
   Call Carga
   txtCapRes.SetFocus
   
End Sub
Sub BUSCAVALORESMODIFICADOS()
   With Oculta
   ValAnt = "":   ValNue = ""
    
     ValAnt = ValAnt & .TextMatrix(1, 1) & ";": ValNue = ValNue & txtCapRes.Text & ";"
     ValAnt = ValAnt & .TextMatrix(2, 1) & ";": ValNue = ValNue & txtCapBas.Text & ";"
     ValAnt = ValAnt & .TextMatrix(3, 1) & ";": ValNue = ValNue & CmbMonCon.Text & ";"
     ValAnt = ValAnt & .TextMatrix(4, 1) & ";": ValNue = ValNue & txtValMon.Text & ";"
     ValAnt = ValAnt & .TextMatrix(5, 1) & ";": ValNue = ValNue & txtPorConRie.Text & ";"
     ValAnt = ValAnt & .TextMatrix(6, 1) & ";": ValNue = ValNue & txtPorSinRie.Text & ";"
     ValAnt = ValAnt & .TextMatrix(7, 1) & ";": ValNue = ValNue & txtPorInvExt.Text & ";"
     ValAnt = ValAnt & .TextMatrix(8, 1) & ";": ValNue = ValNue & LabMonConRie & ";"
     ValAnt = ValAnt & .TextMatrix(9, 1) & ";": ValNue = ValNue & LabMonSinRie & ";"
     ValAnt = ValAnt & .TextMatrix(1, 1) & ";": ValNue = ValNue & LabInvTot & ";"
     ValAnt = ValAnt & .TextMatrix(11, 1) & ";": ValNue = ValNue & txtPriTra.Text & ";"
     ValAnt = ValAnt & .TextMatrix(12, 1) & ";": ValNue = ValNue & txtSegTra.Text & ";"
     ValAnt = ValAnt & .TextMatrix(13, 1) & ";": ValNue = ValNue & txtTerTra.Text & ";"
     ValAnt = ValAnt & .TextMatrix(14, 1) & ";": ValNue = ValNue & txtMarIns.Text & ";"
     ValAnt = ValAnt & .TextMatrix(15, 1) & ";": ValNue = ValNue & txtTotCarLCHR.Text & ";"
     ValAnt = ValAnt & .TextMatrix(16, 1) & ";": ValNue = ValNue & txtTotPorFol.Text & ";"
     ValAnt = ValAnt & .TextMatrix(17, 1) & ";": ValNue = ValNue & txtCajPes.Text & ";"
     ValAnt = ValAnt & .TextMatrix(18, 1) & ";": ValNue = ValNue & txtCajBCCH.Text & ";"
     ValAnt = ValAnt & .TextMatrix(19, 1) & ";": ValNue = ValNue & txtTotInv.Text & ";"
   End With
End Sub


Sub CalculodePorcentaje(CapitalyReserva As Control, Porcen As Control, Monto As Control)
 
   Monto.Caption = Format(CapitalyReserva.Text * Porcen.Text, FDecimal)
   Monto.Caption = Format(CDbl(Monto.Caption) / 100, FDecimal)
      
End Sub


Private Sub CmbMonCon_GotFocus()

   CmbMonCon.Tag = CmbMonCon.ListIndex
   
End Sub

Private Sub CmbMonCon_KeyDown(KEYCODE As Integer, Shift As Integer)

   If KEYCODE = 27 Then
      If CmbMonCon.ListIndex = CmbMonCon.Tag Then
         Unload Me
         Exit Sub
      End If
      CmbMonCon.ListIndex = CmbMonCon.Tag
   End If
   If KEYCODE = 13 Then
      txtValMon.SetFocus
   End If

End Sub

Private Sub Form_Load()
   Me.Top = 0
   Me.Left = 0
   
   Call Carga
   Call GRABA_LOG_AUDITORIA(1, (gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt10001", "07", "INGRESO A OPCION DE MENU", "", "", "")
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call GRABA_LOG_AUDITORIA(1, (gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt10001", "08", "SALIO DE LA OPCION DE MENU", "", "", "")
End Sub



Private Sub Labtab02_Click()
    Tab1.SetFocus
    Tab1.Tab = 1
End Sub

Private Sub Labtab11_Click()
    Tab1.Tab = 0
    Tab1.SetFocus
End Sub

Private Sub Tab1_Click(PreviousTab As Integer)
    
    If Tab1.Tab = 0 Then
    Tab1.Font.Bold = True
    End If
  
End Sub

Private Sub Tab1_GotFocus()

    If Tab1.Tab = 0 Then
    End If
    If Tab1.Tab = 1 Then
    End If
End Sub

Private Sub Tab1_KeyDown(KEYCODE As Integer, Shift As Integer)
    If KEYCODE = 27 Then
        Unload Me
    End If
    If KEYCODE = 13 Then
        If Tab1.Tab = 0 Then
            txtCapRes.SetFocus
        End If
        If Tab1.Tab = 1 Then
            txtPriTra.SetFocus
        End If
    End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index
      Case 1
         Call Graba
      Case 2
         Call Carga
         txtCapRes.SetFocus
      Case 3
         Unload Me
   End Select
End Sub

Private Sub txtCajBCCH_GotFocus()

   txtCajBCCH.Tag = txtCajBCCH.Text
   Call CambioColor(txtCajBCCH, True)

End Sub

Private Sub txtCajBCCH_KeyDown(KEYCODE As Integer, Shift As Integer)

   If KEYCODE = 27 Then
      If txtCajBCCH.Text = txtCajBCCH.Tag Then
         Unload Me
         Exit Sub
      End If
      txtCajBCCH.Text = txtCajBCCH.Tag
   End If
   
   If KEYCODE = 13 Then
      txtTotInv.SetFocus
   End If

End Sub

Private Sub txtCajBCCH_LostFocus()

   Call CambioColor(txtCajBCCH, False)

End Sub

Private Sub txtCajPes_GotFocus()

   txtCajPes.Tag = txtCajPes.Text
   Call CambioColor(txtCajPes, True)

End Sub

Private Sub txtCajPes_KeyDown(KEYCODE As Integer, Shift As Integer)

   If KEYCODE = 27 Then
      If txtCajPes.Text = txtCajPes.Tag Then
         Unload Me
         Exit Sub
      End If
      txtCajPes.Text = txtCajPes.Tag
   End If
   
   If KEYCODE = 13 Then
      txtCajBCCH.SetFocus
   End If

End Sub

Private Sub txtCajPes_LostFocus()

   Call CambioColor(txtCajPes, False)

End Sub

Private Sub txtCapBas_GotFocus()
   txtCapBas.Tag = txtCapBas.Text
   Call CambioColor(txtCapBas, True)

End Sub

Private Sub txtCapBas_KeyDown(KEYCODE As Integer, Shift As Integer)

   If KEYCODE = 27 Then
      If txtCapBas.Text = txtCapBas.Tag Then
         Unload Me
         Exit Sub
      End If
      txtCapBas.Text = CDbl(txtCapBas.Tag)
   End If
   If KEYCODE = 13 Then
      CmbMonCon.SetFocus
   End If

End Sub

Private Sub txtCapBas_LostFocus()
    
   Call CambioColor(txtCapBas, False)

End Sub

Private Sub txtCapRes_Change()

  ' Call CalculodePorcentaje(txtCapRes, txtPorConRie, LabMonConRie)
  ' Call CalculodePorcentaje(txtCapRes, txtPorSinRie, LabMonSinRie)
  ' Call CalculodePorcentaje(txtCapRes, txtPorInvExt, LabInvTot)
      
End Sub

Private Sub txtCapRes_GotFocus()
   
   txtCapRes.Tag = txtCapRes.Text
   Call CambioColor(txtCapRes, True)

End Sub

Private Sub txtCapRes_KeyDown(KEYCODE As Integer, Shift As Integer)

   If KEYCODE = 27 Then
      If txtCapRes.Text = txtCapRes.Tag Then
         Unload Me
         Exit Sub
      End If
      txtCapRes.Text = txtCapRes.Tag
   End If
   If KEYCODE = 13 Then
      txtCapBas.SetFocus
   End If

End Sub

Private Sub txtCapRes_LostFocus()
   Call CalculodePorcentaje(txtCapRes, txtPorConRie, LabMonConRie)
   Call CalculodePorcentaje(txtCapRes, txtPorSinRie, LabMonSinRie)
   Call CalculodePorcentaje(txtCapRes, txtPorInvExt, LabInvTot)
   Call CambioColor(txtCapRes, False)

End Sub

Private Sub txtMarIns_GotFocus()
   
   txtMarIns.Tag = txtMarIns.Text
   Call CambioColor(txtMarIns, True)
   
End Sub

Private Sub txtMarIns_KeyDown(KEYCODE As Integer, Shift As Integer)

   If KEYCODE = 27 Then
      If txtMarIns.Text = txtMarIns.Tag Then
         Unload Me
         Exit Sub
      End If
      txtMarIns.Text = txtMarIns.Tag
   End If
   
   If KEYCODE = 13 Then
      txtTotCarLCHR.SetFocus
   End If

End Sub

Private Sub txtMarIns_LostFocus()

   Call CambioColor(txtMarIns, False)

End Sub

Private Sub txtPorConRie_Change()
   
   Call CalculodePorcentaje(txtCapRes, txtPorConRie, LabMonConRie)

End Sub


Private Sub txtPorConRie_GotFocus()
   
   txtPorConRie.Tag = txtPorConRie.Text
   Call CambioColor(txtPorConRie, True)

End Sub

Private Sub txtPorConRie_KeyDown(KEYCODE As Integer, Shift As Integer)

   If KEYCODE = 27 Then
      If txtPorConRie.Text = txtPorConRie.Tag Then
         Unload Me
         Exit Sub
      End If
      txtPorConRie.Text = txtPorConRie.Tag
   End If
   
   If KEYCODE = 13 Then
      txtPorSinRie.SetFocus
   End If

End Sub

Private Sub txtPorConRie_LostFocus()

   Call CambioColor(txtPorConRie, False)
   
End Sub

Private Sub txtPorInvExt_Change()

   Call CalculodePorcentaje(txtCapRes, txtPorInvExt, LabInvTot)

End Sub

Private Sub txtPorInvExt_GotFocus()
   
   txtPorInvExt.Tag = txtPorInvExt.Text
   Call CambioColor(txtPorInvExt, True)

End Sub

Private Sub txtPorInvExt_KeyDown(KEYCODE As Integer, Shift As Integer)

   If KEYCODE = 27 Then
      If txtPorInvExt.Text = txtPorInvExt.Tag Then
         Unload Me
         Exit Sub
      End If
      txtPorInvExt.Text = txtPorInvExt.Tag
   End If
   
   If KEYCODE = 13 Then
      Tab1.Tab = 0
   End If

End Sub

Private Sub txtPorInvExt_LostFocus()

   Call CambioColor(txtPorInvExt, False)
   Tab1.SetFocus

End Sub

Private Sub txtPorSinRie_Change()
   
   Call CalculodePorcentaje(txtCapRes, txtPorSinRie, LabMonSinRie)
   
End Sub

Private Sub txtPorSinRie_GotFocus()

   txtPorSinRie.Tag = txtPorSinRie.Text
   Call CambioColor(txtPorSinRie, True)

End Sub

Private Sub txtPorSinRie_KeyDown(KEYCODE As Integer, Shift As Integer)

   If KEYCODE = 27 Then
      If txtPorSinRie.Text = txtPorSinRie.Tag Then
         Unload Me
         Exit Sub
      End If
      txtPorSinRie.Text = txtPorSinRie.Tag
   End If
   
   If KEYCODE = 13 Then
      txtPorInvExt.SetFocus
   End If

End Sub

Private Sub txtPorSinRie_LostFocus()

   Call CambioColor(txtPorSinRie, False)

End Sub

Private Sub txtPriTra_GotFocus()

   txtPriTra.Tag = txtPriTra.Text
   Call CambioColor(txtPriTra, True)

End Sub

Private Sub txtPriTra_KeyDown(KEYCODE As Integer, Shift As Integer)

   If KEYCODE = 27 Then
      If txtPriTra.Text = txtPriTra.Tag Then
         Unload Me
         Exit Sub
      End If
      txtPriTra.Text = txtPriTra.Tag
   End If
   
   If KEYCODE = 13 Then
      txtSegTra.SetFocus
   End If

End Sub

Private Sub txtPriTra_LostFocus()

   Call CambioColor(txtPriTra, False)
    
    
End Sub

Private Sub txtSegTra_GotFocus()

   txtSegTra.Tag = txtSegTra.Text
   Call CambioColor(txtSegTra, True)

End Sub

Private Sub txtSegTra_KeyDown(KEYCODE As Integer, Shift As Integer)

   If KEYCODE = 27 Then
      If txtSegTra.Text = txtSegTra.Tag Then
         Unload Me
         Exit Sub
      End If
      txtSegTra.Text = txtSegTra.Tag
   End If
   
   If KEYCODE = 13 Then
      txtTerTra.SetFocus
   End If

End Sub

Private Sub txtSegTra_LostFocus()

   Call CambioColor(txtSegTra, False)

End Sub

Private Sub txtTerTra_GotFocus()
   
   txtTerTra.Tag = txtTerTra.Text
   Call CambioColor(txtTerTra, True)

End Sub

Private Sub txtTerTra_KeyDown(KEYCODE As Integer, Shift As Integer)

   If KEYCODE = 27 Then
      If txtTerTra.Text = txtTerTra.Tag Then
         Unload Me
         Exit Sub
      End If
      txtTerTra.Text = txtTerTra.Tag
   End If
   
   If KEYCODE = 13 Then
      txtMarIns.SetFocus
   End If

End Sub

Private Sub txtTerTra_LostFocus()

   Call CambioColor(txtTerTra, False)

End Sub

Private Sub txtTotCarLCHR_GotFocus()

   txtTotCarLCHR.Tag = txtTotCarLCHR.Text
   Call CambioColor(txtTotCarLCHR, True)
   
End Sub

Private Sub txtTotCarLCHR_KeyDown(KEYCODE As Integer, Shift As Integer)

   If KEYCODE = 27 Then
      If txtTotCarLCHR.Text = txtTotCarLCHR.Tag Then
         Unload Me
         Exit Sub
      End If
      txtTotCarLCHR.Text = txtTotCarLCHR.Tag
   End If
   
   If KEYCODE = 13 Then
      txtTotPorFol.SetFocus
   End If

End Sub

Private Sub txtTotCarLCHR_LostFocus()

   Call CambioColor(txtTotCarLCHR, False)

End Sub

Private Sub txtTotInv_GotFocus()
   
   txtTotInv.Tag = txtTotInv.Text
   Call CambioColor(txtTotInv, True)

End Sub

Private Sub txtTotInv_KeyDown(KEYCODE As Integer, Shift As Integer)

   If KEYCODE = 27 Then
      If txtTotInv.Text = txtTotInv.Tag Then
         Unload Me
         Exit Sub
      End If
      txtTotInv.Text = txtTotInv.Tag
   End If
   
   If KEYCODE = 13 Then
      Tab1.SetFocus
   End If

End Sub

Private Sub txtTotInv_LostFocus()

   Call CambioColor(txtTotInv, False)
   
End Sub

Private Sub txtTotPorFol_GotFocus()

   txtTotPorFol.Tag = txtTotPorFol.Text
   Call CambioColor(txtTotPorFol, True)

End Sub

Private Sub txtTotPorFol_KeyDown(KEYCODE As Integer, Shift As Integer)

   If KEYCODE = 27 Then
      If txtTotPorFol.Text = txtTotPorFol.Tag Then
         Unload Me
         Exit Sub
      End If
      txtTotPorFol.Text = txtTotPorFol.Tag
   End If
   
   If KEYCODE = 13 Then
      txtCajPes.SetFocus
   End If

End Sub

Private Sub txtTotPorFol_LostFocus()

   Call CambioColor(txtTotPorFol, False)

End Sub

Private Sub txtValMon_GotFocus()

   txtValMon.Tag = txtValMon.Text
   Call CambioColor(txtValMon, True)

End Sub

Private Sub txtValMon_KeyDown(KEYCODE As Integer, Shift As Integer)

   If KEYCODE = 27 Then
      If txtValMon.Text = txtValMon.Tag Then
         Unload Me
         Exit Sub
      End If
      txtValMon.Text = txtValMon.Tag
   End If
   
   If KEYCODE = 13 Then
      txtPorConRie.SetFocus
   End If

End Sub

Private Sub txtValMon_LostFocus()

   Call CambioColor(txtValMon, False)

End Sub

