VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form Bac_Mnt_Control 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Tabla de Control"
   ClientHeight    =   6555
   ClientLeft      =   1815
   ClientTop       =   2460
   ClientWidth     =   7725
   Icon            =   "Bac_Mnt_Control.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6555
   ScaleWidth      =   7725
   Begin Threed.SSPanel PnlDatos_B 
      Height          =   6090
      Left            =   0
      TabIndex        =   19
      Top             =   495
      Width           =   7725
      _Version        =   65536
      _ExtentX        =   13626
      _ExtentY        =   10742
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
      Begin VB.ComboBox CmbValidaLinea 
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
         ItemData        =   "Bac_Mnt_Control.frx":2EFA
         Left            =   5280
         List            =   "Bac_Mnt_Control.frx":2F04
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   1920
         Width           =   735
      End
      Begin VB.TextBox txtfax 
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
         ForeColor       =   &H00800000&
         Height          =   330
         Left            =   1380
         TabIndex        =   8
         Top             =   1920
         Width           =   2700
      End
      Begin VB.TextBox TxtTelefono 
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
         ForeColor       =   &H00800000&
         Height          =   330
         Left            =   1380
         TabIndex        =   6
         Top             =   1530
         Width           =   2700
      End
      Begin BACControles.TXTNumero TXTPapeleta 
         Height          =   300
         Left            =   6330
         TabIndex        =   12
         Top             =   2790
         Width           =   870
         _ExtentX        =   1535
         _ExtentY        =   529
         ForeColor       =   8388608
         Enabled         =   -1  'True
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
         Min             =   "1"
         Max             =   "999"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero TxtTiempo 
         Height          =   315
         Left            =   6330
         TabIndex        =   10
         Top             =   2415
         Width           =   870
         _ExtentX        =   1535
         _ExtentY        =   556
         ForeColor       =   8388608
         Enabled         =   -1  'True
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
         Max             =   "999"
         Separator       =   -1  'True
      End
      Begin Threed.SSPanel SSPanel1 
         Height          =   2775
         Left            =   210
         TabIndex        =   26
         Top             =   3195
         Width           =   7200
         _Version        =   65536
         _ExtentX        =   12700
         _ExtentY        =   4895
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
         BorderWidth     =   1
         Enabled         =   0   'False
         Begin BACControles.TXTNumero TxtNumero_Oper_BTR 
            Height          =   285
            Left            =   2475
            TabIndex        =   13
            Top             =   1815
            Width           =   2055
            _ExtentX        =   3625
            _ExtentY        =   503
            ForeColor       =   8388608
            Enabled         =   -1  'True
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
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero TxtNumero_Oper_BFW 
            Height          =   285
            Left            =   4935
            TabIndex        =   14
            Top             =   1815
            Width           =   2070
            _ExtentX        =   3651
            _ExtentY        =   503
            ForeColor       =   8388608
            Enabled         =   -1  'True
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
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero TxtNumero_Oper_BCC 
            Height          =   285
            Left            =   45
            TabIndex        =   11
            Top             =   1770
            Width           =   2070
            _ExtentX        =   3651
            _ExtentY        =   503
            ForeColor       =   8388608
            Enabled         =   -1  'True
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
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero TXTNumero_Oper_SWP 
            Height          =   285
            Left            =   45
            TabIndex        =   15
            Top             =   2400
            Width           =   2070
            _ExtentX        =   3651
            _ExtentY        =   503
            ForeColor       =   8388608
            Enabled         =   -1  'True
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
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero TXTNumero_Oper_INV 
            Height          =   285
            Left            =   2475
            TabIndex        =   16
            Top             =   2415
            Width           =   2055
            _ExtentX        =   3625
            _ExtentY        =   503
            ForeColor       =   8388608
            Enabled         =   -1  'True
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
            Separator       =   -1  'True
         End
         Begin BACControles.TXTNumero TXTNumero_Oper_PAS 
            Height          =   285
            Left            =   4935
            TabIndex        =   17
            Top             =   2415
            Width           =   2055
            _ExtentX        =   3625
            _ExtentY        =   503
            ForeColor       =   8388608
            Enabled         =   -1  'True
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
            Separator       =   -1  'True
         End
         Begin Threed.SSFrame SSFrame1 
            Height          =   975
            Left            =   2115
            TabIndex        =   37
            Top             =   75
            Width           =   1380
            _Version        =   65536
            _ExtentX        =   2434
            _ExtentY        =   1720
            _StockProps     =   14
            Caption         =   "Anterior"
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
            Font3D          =   3
            ShadowStyle     =   1
            Begin BACControles.TXTFecha TxtFecha_ant 
               Height          =   270
               Left            =   90
               TabIndex        =   38
               Top             =   270
               Width           =   1200
               _ExtentX        =   2117
               _ExtentY        =   476
               Enabled         =   -1  'True
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   8388608
               MaxDate         =   2958465
               MinDate         =   -328716
               Text            =   "22/08/2001"
            End
            Begin VB.Label LblFecha_Ant 
               Alignment       =   2  'Center
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
               Height          =   315
               Left            =   105
               TabIndex        =   39
               Top             =   570
               Width           =   1200
            End
         End
         Begin Threed.SSFrame SSFrame2 
            Height          =   975
            Left            =   3825
            TabIndex        =   40
            Top             =   75
            Width           =   1395
            _Version        =   65536
            _ExtentX        =   2461
            _ExtentY        =   1720
            _StockProps     =   14
            Caption         =   "Proceso"
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
            Alignment       =   2
            Font3D          =   3
            ShadowStyle     =   1
            Begin BACControles.TXTFecha TxtFecha_Proc 
               Height          =   285
               Left            =   105
               TabIndex        =   41
               Top             =   270
               Width           =   1200
               _ExtentX        =   2117
               _ExtentY        =   503
               Enabled         =   -1  'True
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   8388608
               MaxDate         =   2958465
               MinDate         =   -328716
               Text            =   "22/08/2001"
            End
            Begin VB.Label LblFecha_Proc 
               Alignment       =   2  'Center
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
               Height          =   315
               Left            =   105
               TabIndex        =   42
               Top             =   570
               Width           =   1200
            End
         End
         Begin Threed.SSFrame SSFrame3 
            Height          =   960
            Left            =   5580
            TabIndex        =   43
            Top             =   75
            Width           =   1410
            _Version        =   65536
            _ExtentX        =   2487
            _ExtentY        =   1693
            _StockProps     =   14
            Caption         =   "Proximo"
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
            Alignment       =   1
            Font3D          =   3
            ShadowStyle     =   1
            Begin BACControles.TXTFecha TxtFecha_Prox 
               Height          =   285
               Left            =   90
               TabIndex        =   44
               Top             =   255
               Width           =   1200
               _ExtentX        =   2117
               _ExtentY        =   503
               Enabled         =   -1  'True
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   8388608
               MaxDate         =   2958465
               MinDate         =   -328716
               Text            =   "22/08/2001"
            End
            Begin VB.Label LblFechaProx 
               Alignment       =   2  'Center
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
               Height          =   315
               Left            =   105
               TabIndex        =   45
               Top             =   555
               Width           =   1200
            End
         End
         Begin VB.Label LblEtiquetas 
            Caption         =   "Fechas Proceso"
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
            Height          =   450
            Index           =   10
            Left            =   135
            TabIndex        =   46
            Top             =   165
            Width           =   990
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "PASIVO"
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
            Left            =   4950
            TabIndex        =   35
            Top             =   2205
            Width           =   615
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "INVERSION AL EXTERIOR"
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
            Left            =   2475
            TabIndex        =   34
            Top             =   2175
            Width           =   1920
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "SWAP"
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
            Left            =   105
            TabIndex        =   33
            Top             =   2160
            Width           =   480
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "FORWARD"
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
            Left            =   4935
            TabIndex        =   30
            Top             =   1575
            Width           =   795
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "TRADER"
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
            Index           =   1
            Left            =   2475
            TabIndex        =   29
            Top             =   1575
            Width           =   630
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "CAMBIO"
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
            Left            =   75
            TabIndex        =   28
            Top             =   1545
            Width           =   660
         End
         Begin VB.Label LblEtiquetas 
            Alignment       =   2  'Center
            AutoSize        =   -1  'True
            Caption         =   "Números de  Operación"
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
            Left            =   60
            TabIndex        =   27
            Top             =   1200
            Width           =   1950
         End
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
         ForeColor       =   &H00800000&
         Height          =   330
         Left            =   1380
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   1155
         Width           =   2715
      End
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
         ForeColor       =   &H00800000&
         Height          =   330
         Left            =   5310
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   1170
         Width           =   2220
      End
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
         ForeColor       =   &H00800000&
         Height          =   330
         Left            =   1380
         TabIndex        =   3
         Top             =   810
         Width           =   6140
      End
      Begin VB.TextBox TxtEntidad 
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
         Left            =   1380
         TabIndex        =   2
         Top             =   450
         Width           =   6135
      End
      Begin BACControles.TXTNumero TXTPuerto 
         Height          =   315
         Left            =   5280
         TabIndex        =   7
         Top             =   1560
         Width           =   870
         _ExtentX        =   1535
         _ExtentY        =   556
         ForeColor       =   8388608
         Enabled         =   -1  'True
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
         Min             =   "0"
         Max             =   "65535"
      End
      Begin VB.Label LblEtiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Puerto UDP"
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
         Left            =   4200
         TabIndex        =   48
         Top             =   1620
         Width           =   915
      End
      Begin VB.Label LblEtiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Valida Línea"
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
         Left            =   4200
         TabIndex        =   47
         Top             =   1980
         Width           =   990
      End
      Begin VB.Line Line1 
         X1              =   2865
         X2              =   2925
         Y1              =   240
         Y2              =   240
      End
      Begin VB.Label LblEtiquetas 
         AutoSize        =   -1  'True
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
         Height          =   210
         Index           =   8
         Left            =   285
         TabIndex        =   36
         Top             =   2040
         Width           =   270
      End
      Begin VB.Label LblRut 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "0"
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
         Left            =   1380
         TabIndex        =   0
         Top             =   105
         Width           =   1440
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Número de Copias Papeletas de Operaciones"
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
         Left            =   225
         TabIndex        =   32
         Top             =   2805
         Width           =   3735
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Tiempo asignado para la lectura de interfaces Datatec y OTC(segundos) "
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
         Left            =   195
         TabIndex        =   31
         Top             =   2415
         Width           =   5940
      End
      Begin VB.Label LblEtiquetas 
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
         Index           =   7
         Left            =   255
         TabIndex        =   25
         Top             =   1620
         Width           =   735
      End
      Begin VB.Label LblEtiquetas 
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
         Index           =   6
         Left            =   240
         TabIndex        =   24
         Top             =   1230
         Width           =   570
      End
      Begin VB.Label LblEtiquetas 
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
         Index           =   5
         Left            =   4185
         TabIndex        =   23
         Top             =   1275
         Width           =   690
      End
      Begin VB.Label LblEtiquetas 
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
         Index           =   4
         Left            =   255
         TabIndex        =   22
         Top             =   885
         Width           =   765
      End
      Begin VB.Label LblDV 
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
         Height          =   330
         Left            =   2970
         TabIndex        =   1
         Top             =   105
         Width           =   285
      End
      Begin VB.Label LblEtiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Rut"
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
         Index           =   1
         Left            =   255
         TabIndex        =   21
         Top             =   150
         Width           =   270
      End
      Begin VB.Label LblEtiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Entidad"
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
         Left            =   255
         TabIndex        =   20
         Top             =   525
         Width           =   600
      End
   End
   Begin MSComctlLib.Toolbar Tool_Frm 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   18
      Top             =   0
      Width           =   7725
      _ExtentX        =   13626
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar Datos"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Guardar"
            Object.ToolTipText     =   "Grabar Datos"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList Img_opciones 
      Left            =   6510
      Top             =   -30
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Mnt_Control.frx":2F0E
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Mnt_Control.frx":3375
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Mnt_Control.frx":386B
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Mnt_Control.frx":3CFE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bac_Mnt_Control.frx":41E6
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Bac_Mnt_Control"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim OptLocal As String
Dim glo_Sistema, Sig_Sistema As String

Sub Cargar_Ciudad()
   If Not BAC_SQL_EXECUTE("SP_MOSTRAR_CIUDAD") Then
      Exit Sub
   End If
   Do While BAC_SQL_FETCH(Datos())
      CmbCiudad.AddItem UCase(Datos(3))
      CmbCiudad.ItemData(CmbCiudad.NewIndex) = Val(Datos(1))
   Loop
   For X = 0 To CmbCiudad.ListCount
      If UCase(Trim(CmbCiudad.List(X))) Like "*SANTIAGO*" Then
         CmbCiudad.ListIndex = X
         Exit For
      End If
   
   Next X
End Sub

Sub Cargar_Comuna(Ciudad As Integer)
   
   If Not BAC_SQL_EXECUTE("SP_MOSTRAR_COMUNA " & Ciudad) Then
      Exit Sub
   End If
   CmbComuna.Clear
   Do While BAC_SQL_FETCH(Datos())
      CmbComuna.AddItem UCase(Datos(3))
      CmbComuna.ItemData(CmbComuna.NewIndex) = Val(Datos(1))
   Loop
End Sub

Function Buscar_Datos_Sistema() As Boolean
   Dim Datos()
   
   If Not BAC_SQL_EXECUTE("Sp_Cargar_Datos_Control") Then
      MsgBox "Problemas En Cargar Datos de la Tabla de Control de" & Sistema, vbExclamation
      Buscar_Datos_Sistema = False
      Exit Function
   End If
  
   If BAC_SQL_FETCH(Datos()) Then
      
      Me.TxtEntidad.Text = Datos(1)
      Me.LblRut.Caption = Format(Datos(3), FEntero)
      Me.LblDV.Caption = Datos(2)
      Me.TxtDireccion.Text = Datos(4)
      'If CmbComuna.ListCount > 0 Then CmbComuna.Text = Trim(Datos(5))
      'If CmbCiudad.ListCount > 0 Then CmbCiudad.Text = Trim(Datos(6))
      Me.txtfax.Text = Datos(16)
            
      
      If CmbCiudad.ListCount > 0 Then Call bacBuscarCombo(CDbl(Datos(6)), 1)
      Call CmbCiudad_Click
      If CmbComuna.ListCount > 0 Then Call bacBuscarCombo(CDbl(Datos(5)), 2)
      
      Me.TxtTelefono.Text = Datos(7)
      Me.TxtNumero_Oper_BCC.Text = Datos(9)
      Me.TxtTiempo.Text = Datos(8)
      Me.TxtNumero_Oper_BFW.Text = Datos(10)
      Me.TxtNumero_Oper_BTR.Text = Datos(11)
      TXTPapeleta.Text = Datos(12)
      Me.TXTNumero_Oper_SWP.Text = Datos(13)
      Me.TXTNumero_Oper_INV.Text = Datos(14)
      Me.TXTNumero_Oper_PAS.Text = Datos(15)
      Me.CmbValidaLinea.Text = Datos(17)
      Me.TXTPuerto.Text = Datos(18)
      
   End If
   
   Buscar_Datos_Sistema = True
End Function

Function bacBuscarCombo(nValor As Variant, Combo As Integer) As Integer
Dim iLin    As Integer
On Error GoTo ErrorCombo:

If Combo = 1 Then
   For iLin = 0 To CmbCiudad.ListCount - 1
        If CmbCiudad.ItemData(iLin) = nValor Then
           CmbCiudad.ListIndex = iLin
           Exit Function
        End If
   Next iLin

Else
   CmbComuna.ListIndex = 0
   If CmbComuna.ListCount > 0 And CmbComuna.Text <> "" Then
      For iLin = 0 To CmbComuna.ListCount - 1
        If CmbComuna.ItemData(iLin) = nValor Then
           CmbComuna.ListIndex = iLin
           Exit Function
        End If
      Next iLin
   End If

End If

Exit Function
ErrorCombo:
   MsgBox err.Description, vbExclamation

End Function



Private Sub cmbSistema_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      If Buscar_Datos_Sistema = True Then
         'Me.Pnl_Fechas.Enabled = False
         Me.PnlDatos_B.Enabled = True
         
         Me.TxtEntidad.SetFocus
      End If
   End If
End Sub


Private Sub CmbCiudad_Click()

   If CmbCiudad.ListIndex >= 0 Then

   Call Cargar_Comuna(CmbCiudad.ItemData(CmbCiudad.ListIndex))

   End If

End Sub

Private Sub CmbCiudad_LostFocus()
'    TxtTelefono.SetFocus
End Sub

Private Sub CmbValidaLinea_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        KeyAscii = 0
    End If
End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer
If KeyCode = vbKeyReturn Then
   KeyCode = 0
   Bac_SendKey vbKeyTab
   Exit Sub
End If

If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

opcion = 0
   Select Case KeyCode

        ' Case vbKeyLimpiar
        '       opcion = 1

         Case vbKeyGrabar
               opcion = 2
         
        ' Case vbKeyBuscar
        '       opcion = 3
         
         Case vbKeySalir
               opcion = 4
   End Select

   If opcion <> 0 Then
      If Tool_Frm.Buttons(opcion).Enabled Then
         Call Tool_Frm_ButtonClick(Tool_Frm.Buttons(opcion))
      End If

   End If

End If

End Sub

Private Sub Form_Load()
   OptLocal = Opt
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")

   Me.Icon = BAC_Parametros.Icon
   Me.top = 0
   Me.left = 0
   
   Me.Tool_Frm.Buttons(1).Enabled = False ' limpiar
   Me.Tool_Frm.Buttons(2).Enabled = False ' guardar
'   Me.Tool_Frm.Buttons(4).Enabled = True  ' buscar
      
   Call Cargar_Ciudad
   
   Call Cargar_Comuna(0)
   Call Limpiar
   
   Me.Tool_Frm.Buttons(1).Enabled = True 'limpiar
   Me.Tool_Frm.Buttons(2).Enabled = True  ' guardar
'   Me.Tool_Frm.Buttons(4).Enabled = False ' buscar
   
   If Buscar_Datos_Sistema = True Then
      'Me.Pnl_Fechas.Enabled = False
      Me.PnlDatos_B.Enabled = True
   End If
  
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Text1_Change()

End Sub

Private Sub Tool_Frm_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Key)
   Case UCase("Limpiar")
      Me.Tool_Frm.Buttons(1).Enabled = False 'limpiar
      Me.Tool_Frm.Buttons(2).Enabled = False ' guardar
      Me.Tool_Frm.Buttons(3).Enabled = True ' buscar
      Call Limpiar
   Case UCase("Guardar")
      Me.Tool_Frm.Buttons(1).Enabled = True 'limpiar
      'Me.Tool_Frm.Buttons(2).Enabled = False  ' guardar
      Me.Tool_Frm.Buttons(3).Enabled = False ' buscar
      Call grabar
      Me.Tool_Frm.Buttons(1).Enabled = False 'limpiar
      'Me.Tool_Frm.Buttons(2).Enabled = False ' guardar
      Me.Tool_Frm.Buttons(3).Enabled = True ' buscar
      'Call Limpiar
   Case UCase("Buscar")
      Me.Tool_Frm.Buttons(1).Enabled = True 'limpiar
      Me.Tool_Frm.Buttons(2).Enabled = True  ' guardar
      Me.Tool_Frm.Buttons(3).Enabled = False ' buscar
      If Buscar_Datos_Sistema = True Then
         'Me.Pnl_Fechas.Enabled = False
         Me.PnlDatos_B.Enabled = True
         Me.TxtEntidad.SetFocus
      End If
   Case UCase("Salir")
         Unload Me
End Select
End Sub

Sub grabar()

   If CmbValidaLinea.Text = "" Then
        MsgBox "Especifique Valida Línea", vbExclamation
        CmbValidaLinea.SetFocus
        Exit Sub
   End If
   
   Envia = Array()
   AddParam Envia, Trim(Mid(Me.TxtEntidad.Text, 1, 50))
   AddParam Envia, Trim(Mid(Me.TxtDireccion.Text, 1, 40))
   If CmbComuna.ListCount > 0 And CmbComuna.ListIndex <> -1 Then
      AddParam Envia, CDbl(Mid(Me.CmbComuna.ItemData(CmbComuna.ListIndex), 1, 15))
   Else
      AddParam Envia, 0
   End If
   If CmbCiudad.ListCount > 0 And CmbCiudad.ListIndex <> -1 Then
    AddParam Envia, CDbl(Mid(Me.CmbCiudad.ItemData(CmbCiudad.ListIndex), 1, 15))
   Else
    AddParam Envia, 0
   End If
   AddParam Envia, Trim(Mid(Me.TxtTelefono.Text, 1, 10))
   AddParam Envia, CDbl(Mid(Me.TxtTiempo.Text, 1, 15))
   AddParam Envia, CDbl(TXTPapeleta.Text)
   AddParam Envia, Trim(Mid(Me.txtfax, 1, 10))
   AddParam Envia, CmbValidaLinea.Text
   AddParam Envia, TXTPuerto.Text
      
   If Not BAC_SQL_EXECUTE("Sp_Grabar_Datos_Control", Envia) Then
      MsgBox "Problemas en la Grabación", vbExclamation
      Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Rut: " & LblRut.Caption & "-" & LblDV.Caption & " Cambio: " & TxtNumero_Oper_BCC.Text & " Foward: " & TxtNumero_Oper_BFW.Text & " Trader: " & TxtNumero_Oper_BTR.Text & " Anterior: " & TxtFecha_ant.Text & " Proceso: " & TxtFecha_Proc.Text & " Proximo: " & TxtFecha_Prox.Text, "", "")
      Exit Sub
   End If
   If BAC_SQL_FETCH(Datos()) Then
      If Datos(1) < 0 Then
         MsgBox Datos(2), vbExclamation
      Else
         MsgBox Datos(2), vbInformation
      End If
   End If
   
   Call LogAuditoria("01", OptLocal, Me.Caption, "", "Rut: " & LblRut.Caption & "-" & LblDV.Caption & " Cambio: " & TxtNumero_Oper_BCC.Text & " Foward: " & TxtNumero_Oper_BFW.Text & " Trader: " & TxtNumero_Oper_BTR.Text & " Anterior: " & TxtFecha_ant.Text & " Proceso: " & TxtFecha_Proc.Text & " Proximo: " & TxtFecha_Prox.Text)
  ' Call Limpiar

End Sub

Sub Limpiar()
   'Me.Pnl_Fechas.Enabled = False
   Me.PnlDatos_B.Enabled = False
   
   Me.TxtEntidad.Text = ""
   Me.LblRut.Caption = 0
   Me.LblDV.Caption = ""
   Me.TxtDireccion.Text = ""
   For X = 0 To CmbCiudad.ListCount
      If UCase(Trim(CmbCiudad.List(X))) Like "*SANTIAGO*" Then
         CmbCiudad.ListIndex = X
         Exit For
   End If
   
   Next X
   Me.CmbComuna.ListIndex = -1
   
   Me.TxtTelefono.Text = ""
  
   Me.TxtNumero_Oper_BCC.Text = 0
   Me.TxtNumero_Oper_BFW.Text = 0
   Me.TxtNumero_Oper_BTR.Text = 0
   Me.TXTNumero_Oper_SWP.Text = 0
   Me.TXTNumero_Oper_INV.Text = 0
   Me.TXTNumero_Oper_PAS.Text = 0
   TXTPapeleta.Text = 0
   Me.txtfax.Text = ""
   Me.TxtTiempo.Text = 0
      
   glo_Sistema = ""
   Sig_Sistema = ""
   
   Me.TxtFecha_ant.Text = Format(gsBac_FecAn, "dd/mm/yyyy")
   Me.TxtFecha_Proc.Text = Format(gsbac_fecp, "dd/mm/yyyy")
   Me.TxtFecha_Prox.Text = Format(gsBAC_Fecpx, "dd/mm/yyyy")
End Sub



Private Sub TxtDireccion_KeyPress(KeyAscii As Integer)
KeyAscii = Caracter(KeyAscii)
KeyAscii = Asc(UCase(Chr(KeyAscii)))

End Sub


Private Sub TxtEntidad_KeyPress(KeyAscii As Integer)

KeyAscii = Caracter(KeyAscii)
KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub txtfax_KeyPress(KeyAscii As Integer)
   If Not IsNumeric(Chr(KeyAscii)) And Not (KeyAscii = 8 Or KeyAscii = vbKeyReturn Or KeyAscii = vbKeyEscape) Then
      KeyAscii = 0: SendKeys "{TAB}"
   End If
End Sub

Private Sub TxtFecha_ant_Change()
   Me.LblFecha_Ant = Format(TxtFecha_ant.Text, "dddd dd mmmm yyyy")
End Sub

Private Sub TxtFecha_Proc_Change()
   Me.LblFecha_Proc = Format(TxtFecha_Proc.Text, "dddd dd mmmm yyyy")
End Sub

Private Sub TxtFecha_Prox_Change()
   Me.LblFechaProx = Format(TxtFecha_Prox.Text, "dddd dd mmmm yyyy")
End Sub

Private Sub TXTPapeleta_LostFocus()
    TxtEntidad.SetFocus
End Sub

Private Sub TxtTelefono_KeyPress(KeyAscii As Integer)
   If Not IsNumeric(Chr(KeyAscii)) And Not (KeyAscii = 8 Or KeyAscii = vbKeyReturn Or KeyAscii = vbKeyEscape) Then
      KeyAscii = 0
   End If
End Sub
