VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form BacMntFe 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Tabla de Feriado"
   ClientHeight    =   4020
   ClientLeft      =   645
   ClientTop       =   2190
   ClientWidth     =   5820
   ClipControls    =   0   'False
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmntfe.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4020
   ScaleWidth      =   5820
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4050
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntfe.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntfe.frx":075C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   5820
      _ExtentX        =   10266
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
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
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   3450
      Left            =   0
      TabIndex        =   0
      Top             =   540
      Width           =   5790
      _Version        =   65536
      _ExtentX        =   10213
      _ExtentY        =   6085
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
      Begin Threed.SSPanel Panel 
         Height          =   3270
         Index           =   1
         Left            =   75
         TabIndex        =   1
         Top             =   90
         Width           =   2010
         _Version        =   65536
         _ExtentX        =   3545
         _ExtentY        =   5768
         _StockProps     =   15
         ForeColor       =   -2147483630
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.ComboBox cmbMeses 
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
            Height          =   330
            IntegralHeight  =   0   'False
            Left            =   105
            Style           =   2  'Dropdown List
            TabIndex        =   5
            Top             =   465
            Width           =   1785
         End
         Begin VB.ComboBox cmbPlaza 
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
            Height          =   330
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   4
            Top             =   2160
            Width           =   1800
         End
         Begin VB.HScrollBar HSclano 
            Height          =   375
            LargeChange     =   10
            Left            =   1065
            Max             =   2054
            Min             =   1900
            TabIndex        =   3
            Top             =   1275
            Value           =   1999
            Width           =   480
         End
         Begin VB.TextBox ITBANO 
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
            Height          =   375
            Left            =   975
            TabIndex        =   2
            Text            =   "Txtitbano"
            Top             =   120
            Visible         =   0   'False
            Width           =   855
         End
         Begin Threed.SSFrame SSFrame2 
            Height          =   870
            Left            =   30
            TabIndex        =   57
            Top             =   30
            Width           =   1935
            _Version        =   65536
            _ExtentX        =   3413
            _ExtentY        =   1535
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
            Begin VB.Label Label 
               Caption         =   "Mes"
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
               Height          =   255
               Index           =   2
               Left            =   120
               TabIndex        =   58
               Top             =   180
               Width           =   1335
            End
         End
         Begin Threed.SSFrame SSFrame3 
            Height          =   915
            Left            =   30
            TabIndex        =   59
            Top             =   855
            Width           =   1935
            _Version        =   65536
            _ExtentX        =   3413
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
            Begin VB.Label iblano 
               Alignment       =   2  'Center
               BackColor       =   &H80000009&
               BorderStyle     =   1  'Fixed Single
               Caption         =   "iblano"
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
               Height          =   345
               Left            =   75
               TabIndex        =   61
               ToolTipText     =   "Cambio de Año ->"
               Top             =   435
               Width           =   825
            End
            Begin VB.Label Label 
               Caption         =   "Año"
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
               Height          =   255
               Index           =   0
               Left            =   135
               TabIndex        =   60
               Top             =   180
               Width           =   615
            End
         End
         Begin Threed.SSFrame SSFrame4 
            Height          =   870
            Left            =   30
            TabIndex        =   62
            Top             =   1725
            Width           =   1935
            _Version        =   65536
            _ExtentX        =   3413
            _ExtentY        =   1535
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
            Begin VB.Label Label 
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
               ForeColor       =   &H00800000&
               Height          =   255
               Index           =   1
               Left            =   105
               TabIndex        =   63
               Top             =   195
               Width           =   1335
            End
         End
      End
      Begin Threed.SSFrame SSFrame1 
         Height          =   3360
         Left            =   2130
         TabIndex        =   7
         Top             =   15
         Width           =   3585
         _Version        =   65536
         _ExtentX        =   6324
         _ExtentY        =   5927
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
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   41
            Left            =   2985
            TabIndex        =   56
            Top             =   2760
            Width           =   495
         End
         Begin VB.Label Label 
            Alignment       =   2  'Center
            Caption         =   "LUN"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   3
            Left            =   105
            TabIndex        =   55
            Top             =   135
            Width           =   495
         End
         Begin VB.Label Label 
            Alignment       =   2  'Center
            Caption         =   "MAR"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   4
            Left            =   585
            TabIndex        =   54
            Top             =   135
            Width           =   495
         End
         Begin VB.Label Label 
            Alignment       =   2  'Center
            Caption         =   "MIE"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   5
            Left            =   1065
            TabIndex        =   53
            Top             =   135
            Width           =   495
         End
         Begin VB.Label Label 
            Alignment       =   2  'Center
            Caption         =   "JUE"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   6
            Left            =   1545
            TabIndex        =   52
            Top             =   135
            Width           =   495
         End
         Begin VB.Label Label 
            Alignment       =   2  'Center
            Caption         =   "VIE"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   7
            Left            =   2025
            TabIndex        =   51
            Top             =   135
            Width           =   495
         End
         Begin VB.Label Label 
            Alignment       =   2  'Center
            Caption         =   "SAB"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   8
            Left            =   2505
            TabIndex        =   50
            Top             =   135
            Width           =   495
         End
         Begin VB.Label Label 
            Alignment       =   2  'Center
            Caption         =   "DOM"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   9
            Left            =   2985
            TabIndex        =   49
            Top             =   135
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   40
            Left            =   2505
            TabIndex        =   48
            Top             =   2760
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   39
            Left            =   2025
            TabIndex        =   47
            Top             =   2760
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   38
            Left            =   1545
            TabIndex        =   46
            Top             =   2760
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   37
            Left            =   1065
            TabIndex        =   45
            Top             =   2760
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   36
            Left            =   585
            TabIndex        =   44
            Top             =   2760
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   35
            Left            =   105
            TabIndex        =   43
            Top             =   2760
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   34
            Left            =   2985
            TabIndex        =   42
            Top             =   2280
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   33
            Left            =   2505
            TabIndex        =   41
            Top             =   2280
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   32
            Left            =   2025
            TabIndex        =   40
            Top             =   2280
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   31
            Left            =   1545
            TabIndex        =   39
            Top             =   2280
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   30
            Left            =   1065
            TabIndex        =   38
            Top             =   2280
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   29
            Left            =   585
            TabIndex        =   37
            Top             =   2280
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   28
            Left            =   105
            TabIndex        =   36
            Top             =   2280
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   27
            Left            =   2985
            TabIndex        =   35
            Top             =   1800
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   26
            Left            =   2505
            TabIndex        =   34
            Top             =   1800
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   25
            Left            =   2025
            TabIndex        =   33
            Top             =   1800
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   24
            Left            =   1545
            TabIndex        =   32
            Top             =   1800
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   23
            Left            =   1065
            TabIndex        =   31
            Top             =   1800
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   22
            Left            =   585
            TabIndex        =   30
            Top             =   1800
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   21
            Left            =   105
            TabIndex        =   29
            Top             =   1800
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   20
            Left            =   2985
            TabIndex        =   28
            Top             =   1320
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   19
            Left            =   2505
            TabIndex        =   27
            Top             =   1320
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   18
            Left            =   2025
            TabIndex        =   26
            Top             =   1320
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   17
            Left            =   1545
            TabIndex        =   25
            Top             =   1320
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   16
            Left            =   1065
            TabIndex        =   24
            Top             =   1320
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   15
            Left            =   585
            TabIndex        =   23
            Top             =   1320
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   14
            Left            =   105
            TabIndex        =   22
            Top             =   1320
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   13
            Left            =   2985
            TabIndex        =   21
            Top             =   840
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   12
            Left            =   2505
            TabIndex        =   20
            Top             =   840
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   11
            Left            =   2025
            TabIndex        =   19
            Top             =   840
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   10
            Left            =   1545
            TabIndex        =   18
            Top             =   840
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   9
            Left            =   1065
            TabIndex        =   17
            Top             =   840
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   8
            Left            =   585
            TabIndex        =   16
            Top             =   840
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   7
            Left            =   105
            TabIndex        =   15
            Top             =   840
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   6
            Left            =   2985
            TabIndex        =   14
            Top             =   360
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   5
            Left            =   2505
            TabIndex        =   13
            Top             =   360
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   4
            Left            =   2025
            TabIndex        =   12
            Top             =   360
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   3
            Left            =   1545
            TabIndex        =   11
            Top             =   360
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   2
            Left            =   1065
            TabIndex        =   10
            Top             =   360
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            Height          =   495
            Index           =   1
            Left            =   585
            TabIndex        =   9
            Top             =   360
            Width           =   495
         End
         Begin VB.Label lblMes 
            Alignment       =   1  'Right Justify
            BackColor       =   &H80000005&
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
            ForeColor       =   &H00000000&
            Height          =   495
            Index           =   0
            Left            =   105
            TabIndex        =   8
            Top             =   360
            Width           =   495
         End
      End
   End
End
Attribute VB_Name = "BacMntFe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Dim TemDB As Database
Dim TemWS As Workspace
Dim sql As String
Dim Categoria As Integer
Dim Fecha_Feriado As String
Dim fene As String
Dim ffeb As String
Dim fmar As String
Dim fabr As String
Dim fmay As String
Dim fjun As String
Dim fjul As String
Dim fago As String
Dim fsep As String
Dim foct As String
Dim fnov As String
Dim fdic As String
Dim sdfin As String


Private Sub FechaDefault()
Dim f As Long

On Error GoTo Label1

    cmbMeses.Tag = "MESES"
    ITBANO.Tag = "AÑO"
    cmbPlaza.Tag = "PLAZA"
    
    'Mostramos el año por default del sistema operativo
    '--------------------------------------------------
    ITBANO.Text = Year(gsbac_fecp)
   
    'Mostramos el mes por default del sistema operativo
    '--------------------------------------------------
    For f = 0 To cmbMeses.ListCount - 1
        If cmbMeses.ItemData(f) = Month(gsbac_fecp) Then
           cmbMeses.ListIndex = f
           Exit For
        End If
    Next f

    cmbMeses.Tag = ""
    ITBANO.Tag = ""
    cmbPlaza.Tag = ""
    
    Exit Sub

Label1:

End Sub

Private Sub GeneraMes()

On Error GoTo Label1
Dim IdPlaza As String

Dim I        As Integer
Dim iDia     As Integer
Dim iUltDia  As Integer
Dim iDiaMes  As Integer
Dim D        As Integer

Dim sDate    As String
Dim sMes     As String
Dim sAno     As String
Dim sString  As String
Dim sFeriado As String
    
Dim fAno As Integer
Dim fPlaza As Integer
    Screen.MousePointer = 11
    
    sMes = Format(cmbMeses.ListIndex + 1, "00") + "/"
    sAno = Format(ITBANO.Text, "0000")
    sDate = "01/" + sMes + sAno
    
    If Not IsDate(sDate) Then
       Screen.MousePointer = 0
       Exit Sub
    End If
    
    If cmbPlaza.ListIndex = -1 Then
       MsgBox "No ha seleccionado plaza", vbCritical, TITSISTEMA
       Screen.MousePointer = 0
       Exit Sub
    End If
    iDia = Weekday(sDate)
    iDia = IIf(iDia = 1, 7, iDia - 1)
    
    If UCase(Trim(Left(cmbPlaza, 20))) Like "*CHILE*" Then
         Categoria = 151
    ElseIf UCase(Trim(Left(cmbPlaza, 20))) Like "*ESTADOS UNIDOS*" Or UCase(Trim(Left(cmbPlaza, 20))) Like "*USA*" Then
         Categoria = 188
    Else
        Categoria = 0
    End If
    
    IdPlaza = Trim(Right(cmbPlaza.Text, 6))
    Envia = Array()
    AddParam Envia, ITBANO.Text
    AddParam Envia, IdPlaza
     
    If Not Bac_Sql_Execute("SP_FELEER ", Envia) Then
        Exit Sub
    End If
    
  '  Call Limpiar
    
    ReDim Datos(14)
        

        iUltDia = DiasDelMes(Val(sMes), CDbl(sAno))
        sFeriado = ""
    If Bac_SQL_Fetch(Datos()) Then
        fAno = Datos(1)
        fPlaza = Datos(2)
         Select Case Trim(Left(sMes, 2))
           Case 1: sFeriado = Datos(3)
           Case 2: sFeriado = Datos(4)
           Case 3: sFeriado = Datos(5)
           Case 4: sFeriado = Datos(6)
           Case 5: sFeriado = Datos(7)
           Case 6: sFeriado = Datos(8)
           Case 7: sFeriado = Datos(9)
           Case 8: sFeriado = Datos(10)
           Case 9: sFeriado = Datos(11)
           Case 10: sFeriado = Datos(12)
           Case 11: sFeriado = Datos(13)
           Case 12: sFeriado = Datos(14)
           
        End Select
        Dim fene As String
    fene = Datos(3)
    ffeb = Datos(4)
    fmar = Datos(5)
    fabr = Datos(6)
    fmay = Datos(7)
    fjun = Datos(8)
    fjul = Datos(9)
    fago = Datos(10)
    fsep = Datos(11)
    foct = Datos(12)
    fnov = Datos(13)
    fdic = Datos(14)

    End If
       iDiaMes = 1
       D = iDia
        For I = 1 To 42
           lblMes(I - 1).Tag = "0"
           lblMes(I - 1).ForeColor = &H0&
           lblMes(I - 1).Caption = ""
           If iDia <= I Then
              If iDiaMes <= iUltDia Then
                 lblMes(I - 1).Caption = Format(iDiaMes, "00")
                 If D > 5 Or InStr(1, sFeriado, Format(iDiaMes, "00")) > 0 Then
                    lblMes(I - 1).Tag = "1"
                    lblMes(I - 1).ForeColor = &HFF&
                 End If
                 D = IIf(D = 7, 1, D + 1)
               End If
               iDiaMes = iDiaMes + 1
           End If
        Next I
   
       
    Screen.MousePointer = 0
    Exit Sub
 
    
Exit Sub
Label1:
    MsgBox "Error cargando días feriados: " & Err.Description, vbCritical, TITSISTEMA
    Screen.MousePointer = 0
    
End Sub


Private Function DiasDelMes(Mes As Integer, Ann As Integer) As Integer

Dim Dias    As String
Dim Residuo As Currency

On Error GoTo Label1

    Dias = "312831303130313130313031"
    
    If Mes = 2 Then
        Residuo = Ann Mod 4
        If Residuo = 0 Then
            DiasDelMes = 29
        Else
            DiasDelMes = 28
        End If
    Else
        DiasDelMes = CDbl(Mid$(Dias, ((Mes * 2) - 1), 2))
    End If
    Exit Function

Label1:
   ' Call objMensajesFE.BacMsgError

End Function



Private Function ValidaDatos() As Integer

On Error GoTo Label1

    ValidaDatos = False
    
    If Trim$(cmbMeses.Text) = "" Then
        Me.MousePointer = 0
       MsgBox "No ha seleccionado mes", vbCritical, TITSISTEMA
       Exit Function
    End If
    
    If Trim$(cmbPlaza.Text) = "" Then
        Me.MousePointer = 0
       MsgBox "No ha seleccionado plaza", vbCritical, TITSISTEMA
       Exit Function
    End If
     
    If CDbl(ITBANO.Text) = 0 Then
       Me.MousePointer = 0
       MsgBox "No ha ingresado año", vbCritical, TITSISTEMA
       Exit Function
    End If
    
    ValidaDatos = True
   
Exit Function

Label1:
    MsgBox "Error de sistema ", vbCritical, TITSISTEMA

End Function


Private Sub cmbMeses_Click()
        
    If Trim$(cmbMeses.Tag) = "" Then
         If cmbMeses.ListIndex <> -1 And cmbPlaza.ListIndex <> -1 Then
               Call GeneraMes
         End If
    End If
    
End Sub


Private Sub cmbMeses_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    KeyAscii = 0
    SendKeys "{Tab}"
End If
End Sub

Private Sub cmbPlaza_Click()

    If Trim$(cmbPlaza.Tag) = "" Then
       If cmbPlaza.ListIndex <> -1 And cmbMeses.ListIndex <> -1 Then
                Call GeneraMes
       End If
    End If
    
End Sub



Private Sub cmbPlaza_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    KeyAscii = 0
    SendKeys "{Tab}"
End If
End Sub



    
    



Private Sub cmdGrabar_Click()

On Error GoTo Label1
Dim sFecha As String
Dim sString As String
Dim I       As Integer
Dim iDia    As Integer
Dim sMes    As Integer

Screen.MousePointer = 11
    If ValidaDatos() = False Then
       Exit Sub
    End If
    
    sString = ""
    
    iDia = 1
    
    For I = 1 To 42
        If lblMes(I - 1).Tag = "1" Then
            If iDia <= 5 Then
                sString = sString + lblMes(I - 1).Caption + ","
                sFecha = sFecha & lblMes(I - 1).Caption + "/" & Format(cmbMeses.ListIndex + 1, "00") & "/" & ITBANO.Text

            Else
                sString = sString + lblMes(I - 1).Caption + ","
                sFecha = sFecha & lblMes(I - 1).Caption + "/" & Format(cmbMeses.ListIndex + 1, "00") & "/" & ITBANO.Text

            End If
        End If
        iDia = IIf(iDia = 7, 1, iDia + 1)
    Next I
                    
    For I = Len(Trim$(sString)) To 11
        sString = sString + "00,"
    Next I
    
    
    sMes = Format(cmbMeses.ListIndex + 1, "00")
    
    Select Case sMes
        Case 1: fene = sString
        Case 2: ffeb = sString
        Case 3: fmar = sString
        Case 4: fabr = sString
        Case 5: fmay = sString
        Case 6: fjun = sString
        Case 7: fjul = sString
        Case 8: fago = sString
        Case 9: fsep = sString
        Case 10: foct = sString
        Case 11: fnov = sString
        Case 12: fdic = sString
    End Select
    
    
    Envia = Array()
    AddParam Envia, ITBANO.Text
    AddParam Envia, Trim(Right(cmbPlaza.Text, 6))
    AddParam Envia, fene
    AddParam Envia, ffeb
    AddParam Envia, fmar
    AddParam Envia, fabr
    AddParam Envia, fmay
    AddParam Envia, fjun
    AddParam Envia, fjul
    AddParam Envia, fago
    AddParam Envia, fsep
    AddParam Envia, foct
    AddParam Envia, fnov
    AddParam Envia, fdic
    
    If Not Bac_Sql_Execute("SP_FEGRABAR ", Envia) Then
       MsgBox "La Grabación no se realizó correctamente", vbCritical, TITSISTEMA
       Exit Sub
    End If
               
        
       MsgBox "La Grabación  se realizó correctamente", vbInformation, TITSISTEMA
       Screen.MousePointer = 0
       Exit Sub

Label1:
    MsgBox "Error en la Grabación :" & Err.Description, vbCritical, TITSISTEMA
    
End Sub


Private Sub cmdSalir_Click()

    Unload Me
        
End Sub




Private Sub DataFox_Error(DataErr As Integer, Response As Integer)
Select Case DataErr
           Case 3051
                   MsgBox "                mbtablas no fue abierta :     " & DataErr & Chr(10) & _
                               " posiblemente se esta utilizando de modo exclusivo ", vbCritical, TITSISTEMA
                   Unload Me
End Select
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
        
    If KeyAscii = 13 Then
       SendKeys "{TAB}"
    End If
        
End Sub

Private Sub Form_Load()
Me.Top = 0
Me.Left = 0
Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_614 " _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")


On Error GoTo Label1

    iblano.Caption = CDbl(Year(gsbac_fecp))
    Call BacLLenaComboMes(cmbMeses)
    
   
   If Bac_Sql_Execute("SP_SELECCIONA_PAIS") Then
      
      Do While Bac_SQL_Fetch(Datos())
      
         cmbPlaza.AddItem (Datos(2)) + Space(40 + Len(Datos(2))) + Str(Datos(1))
      
      Loop
      
   End If
    
   ' If Not Llenar_Combos(cmbPlaza, 180) Then 'Categoría 180
   '     Unload Me
   '     Exit Sub
   ' End If
    
    
    cmbPlaza.ListIndex = -1
    
    
    Call FechaDefault
    Exit Sub

Label1:
    
    MsgBox "Error cargando formulario", vbCritical, TITSISTEMA
    Unload Me
    Exit Sub
    
End Sub

Private Sub itbAno_Change()

       If Trim$(ITBANO.Tag) = "" Then
          Call GeneraMes
       End If
       
End Sub

Private Sub itbAno_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    KeyAscii = 0
    SendKeys "{Tab}"
End If

End Sub

Private Sub HSclano_Change()
  
  iblano.Caption = Str$(HSclano.Value)
  ITBANO.Text = CDbl(HSclano.Value) ' Text1 es numerico
  
   If Trim$(ITBANO.Tag) = "" And cmbPlaza.Text <> "" Then
          
          Call GeneraMes
   
   End If

End Sub

Private Sub lblMes_Click(Index As Integer)

On Error GoTo Label1
Dim f As Integer

    For f = 5 To 41 Step 7
        If Index = f Then
           Exit Sub
        End If
    Next f
    
    For f = 6 To 42 Step 7
        If Index = f Then
           Exit Sub
        End If
    Next f
    
    If lblMes(Index).Tag = "0" Then
        lblMes(Index).ForeColor = &HFF&
        lblMes(Index).Tag = "1"
    Else
        lblMes(Index).ForeColor = &H0&
        lblMes(Index).Tag = "0"
    End If
    
      
    Exit Sub
    
Label1:
   MsgBox "Error seleccionando mes", vbCritical, TITSISTEMA

End Sub



Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
   Case 1
         On Error GoTo Label11
Dim sFecha As String
Dim sString As String
Dim I       As Integer
Dim iDia    As Integer
Dim sMes    As Integer

Screen.MousePointer = 11
    If ValidaDatos() = False Then
       Exit Sub
    End If
    
    sString = ""
    
    iDia = 1
    
    For I = 1 To 42
        If lblMes(I - 1).Tag = "1" Then
            If iDia <= 5 Then
                sString = sString + lblMes(I - 1).Caption + ","
                sFecha = sFecha & lblMes(I - 1).Caption + "/" & Format(cmbMeses.ListIndex + 1, "00") & "/" & ITBANO.Text

            Else
                sString = sString + lblMes(I - 1).Caption + ","
                sFecha = sFecha & lblMes(I - 1).Caption + "/" & Format(cmbMeses.ListIndex + 1, "00") & "/" & ITBANO.Text

            End If
        End If
        iDia = IIf(iDia = 7, 1, iDia + 1)
    Next I
                    
    For I = Len(Trim$(sString)) To 11
        sString = sString + "00,"
    Next I
    
    
    sMes = Format(cmbMeses.ListIndex + 1, "00")
    
    Select Case sMes
        Case 1: fene = sString
        Case 2: ffeb = sString
        Case 3: fmar = sString
        Case 4: fabr = sString
        Case 5: fmay = sString
        Case 6: fjun = sString
        Case 7: fjul = sString
        Case 8: fago = sString
        Case 9: fsep = sString
        Case 10: foct = sString
        Case 11: fnov = sString
        Case 12: fdic = sString
    End Select
    
    Envia = Array()
    AddParam Envia, ITBANO.Text
    AddParam Envia, Trim(Right(cmbPlaza.Text, 6))
    AddParam Envia, fene
    AddParam Envia, ffeb
    AddParam Envia, fmar
    AddParam Envia, fabr
    AddParam Envia, fmay
    AddParam Envia, fjun
    AddParam Envia, fjul
    AddParam Envia, fago
    AddParam Envia, fsep
    AddParam Envia, foct
    AddParam Envia, fnov
    AddParam Envia, fdic
    
    
    If Not Bac_Sql_Execute("SP_FEGRABAR ", Envia) Then
       MsgBox "La Grabación no se realizó correctamente", vbCritical, TITSISTEMA
       Exit Sub
    End If
     Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_614 " _
                                    , "01" _
                                    , "Grabar Feriado " _
                                    , "FERIADO " _
                                    , " " _
                                    , "Grabar Feriado del mes .:" & " " & cmbMeses.Text)
        
       MsgBox "La Grabación  se realizó correctamente", vbInformation, TITSISTEMA
       Screen.MousePointer = 0
       Exit Sub

Label11:
    MsgBox "Error en la Grabación :" & Err.Description, vbCritical, TITSISTEMA
   Case 2
        Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                    , gsbac_fecp _
                                    , gsBac_IP _
                                    , gsBAC_User _
                                    , "PCA" _
                                    , "OPC_614 " _
                                    , "08" _
                                    , "Salir Opcion De Menu" _
                                    , " " _
                                    , " " _
                                    , " ")
      Unload Me
End Select
End Sub
