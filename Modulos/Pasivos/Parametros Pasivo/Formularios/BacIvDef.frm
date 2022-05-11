VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form BacIniValDef 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Valores por Defecto"
   ClientHeight    =   5850
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9390
   Icon            =   "BacIvDef.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5850
   ScaleWidth      =   9390
   ShowInTaskbar   =   0   'False
   Begin Threed.SSPanel SSPanel1 
      Height          =   5370
      Left            =   0
      TabIndex        =   0
      Top             =   480
      Width           =   9420
      _Version        =   65536
      _ExtentX        =   16616
      _ExtentY        =   9472
      _StockProps     =   15
      ForeColor       =   192
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
      Begin Threed.SSFrame SSFrame4 
         Height          =   570
         Left            =   60
         TabIndex        =   1
         Top             =   15
         Width           =   9315
         _Version        =   65536
         _ExtentX        =   16431
         _ExtentY        =   1005
         _StockProps     =   14
         ForeColor       =   192
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
         Begin VB.ComboBox CmbProducto 
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
            Left            =   1005
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   165
            Width           =   3870
         End
         Begin VB.ComboBox CmbResponsable 
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
            Left            =   6330
            Style           =   2  'Dropdown List
            TabIndex        =   2
            Top             =   165
            Width           =   2925
         End
         Begin VB.Label Label16 
            Caption         =   "Producto"
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
            TabIndex        =   5
            Top             =   210
            Width           =   1095
         End
         Begin VB.Label Label13 
            Caption         =   "Responsable"
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
            Left            =   5115
            TabIndex        =   4
            Top             =   210
            Width           =   1530
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   1935
         Index           =   2
         Left            =   60
         TabIndex        =   6
         Top             =   525
         Width           =   9315
         _Version        =   65536
         _ExtentX        =   16431
         _ExtentY        =   3413
         _StockProps     =   14
         Caption         =   "Compras"
         ForeColor       =   16576
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
         Begin VB.ComboBox FpEntCom 
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
            ItemData        =   "BacIvDef.frx":2EFA
            Left            =   1845
            List            =   "BacIvDef.frx":2EFC
            Style           =   2  'Dropdown List
            TabIndex        =   12
            Top             =   1245
            Width           =   3000
         End
         Begin VB.ComboBox FpRecCom 
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
            Left            =   1830
            Style           =   2  'Dropdown List
            TabIndex        =   11
            Top             =   1575
            Width           =   3015
         End
         Begin VB.TextBox TxtComercioC 
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
            Left            =   1845
            Locked          =   -1  'True
            MouseIcon       =   "BacIvDef.frx":2EFE
            MousePointer    =   99  'Custom
            TabIndex        =   10
            Top             =   615
            Width           =   3000
         End
         Begin VB.TextBox TxtOmaC 
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
            Left            =   1845
            MouseIcon       =   "BacIvDef.frx":3208
            TabIndex        =   9
            Top             =   285
            Width           =   3000
         End
         Begin VB.TextBox LblGlosaOmaC 
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
            Left            =   4875
            Locked          =   -1  'True
            TabIndex        =   8
            Top             =   285
            Width           =   4395
         End
         Begin VB.TextBox LblGlosaC 
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
            Left            =   4875
            Locked          =   -1  'True
            TabIndex        =   7
            Top             =   615
            Width           =   4395
         End
         Begin BACControles.TXTFecha TxtFechCompra 
            Height          =   315
            Left            =   4950
            TabIndex        =   13
            Top             =   1560
            Width           =   1365
            _ExtentX        =   2408
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
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/10/2000"
         End
         Begin BACControles.TXTFecha DateText1 
            Height          =   315
            Left            =   4950
            TabIndex        =   14
            Top             =   1230
            Width           =   1365
            _ExtentX        =   2408
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
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/10/2000"
         End
         Begin Threed.SSFrame SSFrame1 
            Height          =   990
            Left            =   4875
            TabIndex        =   15
            Top             =   945
            Width           =   4410
            _Version        =   65536
            _ExtentX        =   7779
            _ExtentY        =   1746
            _StockProps     =   14
            Caption         =   "Fechas Valutas"
            ForeColor       =   192
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
            Begin VB.TextBox Label15 
               BackColor       =   &H8000000F&
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
               Height          =   315
               Left            =   1455
               Locked          =   -1  'True
               TabIndex        =   17
               Top             =   285
               Width           =   2895
            End
            Begin VB.TextBox LabelFechaR 
               BackColor       =   &H8000000F&
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
               Height          =   315
               Left            =   1455
               Locked          =   -1  'True
               TabIndex        =   16
               Top             =   615
               Width           =   2895
            End
         End
         Begin VB.Label Label2 
            Caption         =   "Código OMA"
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
            Left            =   105
            TabIndex        =   21
            Top             =   330
            Width           =   1695
         End
         Begin VB.Label Label4 
            Caption         =   "F. P. Entregamos"
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
            Left            =   90
            TabIndex        =   20
            Top             =   1260
            Width           =   1695
         End
         Begin VB.Label Label10 
            Caption         =   "F. P. Recibimos"
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
            Left            =   75
            TabIndex        =   19
            Top             =   1605
            Width           =   1695
         End
         Begin VB.Label Label18 
            Caption         =   "Código Comercio"
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
            Left            =   105
            TabIndex        =   18
            Top             =   645
            Width           =   1470
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   2070
         Index           =   0
         Left            =   60
         TabIndex        =   22
         Top             =   2415
         Width           =   9315
         _Version        =   65536
         _ExtentX        =   16431
         _ExtentY        =   3651
         _StockProps     =   14
         Caption         =   "Ventas"
         ForeColor       =   8421376
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
         Begin VB.ComboBox FpRecVen 
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
            Left            =   1830
            Style           =   2  'Dropdown List
            TabIndex        =   28
            Top             =   1620
            Width           =   2985
         End
         Begin VB.ComboBox FpEntVen 
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
            Left            =   1830
            Style           =   2  'Dropdown List
            TabIndex        =   27
            Top             =   1290
            Width           =   2985
         End
         Begin VB.TextBox TxtComercioV 
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
            Left            =   1830
            Locked          =   -1  'True
            MouseIcon       =   "BacIvDef.frx":3512
            MousePointer    =   99  'Custom
            TabIndex        =   26
            Top             =   615
            Width           =   2985
         End
         Begin VB.TextBox TxtOmaV 
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
            Left            =   1830
            MouseIcon       =   "BacIvDef.frx":381C
            TabIndex        =   25
            Top             =   285
            Width           =   2985
         End
         Begin VB.TextBox LblGlosaOmaV 
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
            Left            =   4845
            Locked          =   -1  'True
            TabIndex        =   24
            Top             =   285
            Width           =   4425
         End
         Begin VB.TextBox LblGlosaV 
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
            Left            =   4845
            Locked          =   -1  'True
            TabIndex        =   23
            Top             =   615
            Width           =   4425
         End
         Begin BACControles.TXTFecha DateText2 
            Height          =   315
            Left            =   4965
            TabIndex        =   29
            Top             =   1620
            Width           =   1350
            _ExtentX        =   2381
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
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/10/2000"
         End
         Begin BACControles.TXTFecha TxtFechVenta 
            Height          =   315
            Left            =   4965
            TabIndex        =   30
            Top             =   1290
            Width           =   1350
            _ExtentX        =   2381
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
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/10/2000"
         End
         Begin Threed.SSFrame SSFrame3 
            Height          =   1005
            Left            =   4845
            TabIndex        =   31
            Top             =   1005
            Width           =   4425
            _Version        =   65536
            _ExtentX        =   7805
            _ExtentY        =   1773
            _StockProps     =   14
            Caption         =   "Fechas Valutas"
            ForeColor       =   192
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
            Begin VB.TextBox LabelFechaE 
               BackColor       =   &H8000000F&
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
               Left            =   1485
               Locked          =   -1  'True
               TabIndex        =   33
               Top             =   285
               Width           =   2880
            End
            Begin VB.TextBox Label1 
               BackColor       =   &H8000000F&
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
               Left            =   1485
               Locked          =   -1  'True
               TabIndex        =   32
               Top             =   615
               Width           =   2880
            End
         End
         Begin VB.Label Label11 
            Caption         =   "Código OMA"
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
            Left            =   90
            TabIndex        =   37
            Top             =   330
            Width           =   1695
         End
         Begin VB.Label Label7 
            Caption         =   "F. P. Recibimos"
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
            Left            =   75
            TabIndex        =   36
            Top             =   1650
            Width           =   1695
         End
         Begin VB.Label Label5 
            Caption         =   "F. P. Entregamos"
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
            Left            =   90
            TabIndex        =   35
            Top             =   1335
            Width           =   1695
         End
         Begin VB.Label Label17 
            Caption         =   "Código Comercio"
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
            TabIndex        =   34
            Top             =   660
            Width           =   1500
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   930
         Index           =   1
         Left            =   60
         TabIndex        =   38
         Top             =   4395
         Width           =   9315
         _Version        =   65536
         _ExtentX        =   16431
         _ExtentY        =   1640
         _StockProps     =   14
         ForeColor       =   16576
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
         Begin VB.ComboBox CmbMoneda 
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
            Left            =   6300
            Style           =   2  'Dropdown List
            TabIndex        =   41
            Top             =   180
            Width           =   2925
         End
         Begin VB.ComboBox CmbContabiliza 
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
            ItemData        =   "BacIvDef.frx":3B26
            Left            =   1830
            List            =   "BacIvDef.frx":3B30
            Style           =   2  'Dropdown List
            TabIndex        =   40
            Top             =   510
            Width           =   1260
         End
         Begin VB.OptionButton Option1 
            Caption         =   "Option1"
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
            Height          =   270
            Left            =   3930
            TabIndex        =   39
            Top             =   570
            Value           =   -1  'True
            Visible         =   0   'False
            Width           =   1590
         End
         Begin BACControles.TXTNumero TxtMonto 
            Height          =   300
            Left            =   1830
            TabIndex        =   42
            Top             =   180
            Width           =   1920
            _ExtentX        =   3387
            _ExtentY        =   529
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
         Begin VB.Label Label3 
            Caption         =   " Monto  Operación"
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
            Left            =   75
            TabIndex        =   45
            Top             =   195
            Width           =   1695
         End
         Begin VB.Label Label14 
            Caption         =   "Contabiliza"
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
            Left            =   765
            TabIndex        =   44
            Top             =   570
            Width           =   1440
         End
         Begin VB.Label Label19 
            Caption         =   "Moneda"
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
            Left            =   5220
            TabIndex        =   43
            Top             =   195
            Width           =   1020
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   46
      Top             =   0
      Width           =   9390
      _ExtentX        =   16563
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList Img_opciones 
      Left            =   6330
      Top             =   90
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   8
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacIvDef.frx":3B3C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacIvDef.frx":3FA3
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacIvDef.frx":4499
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacIvDef.frx":492C
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacIvDef.frx":4E14
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacIvDef.frx":5327
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacIvDef.frx":57FA
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacIvDef.frx":5CC0
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacIniValDef"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim OptLocal As String
Dim Sql$, Datos(), Var$, Datost(), omaV%, omaC%, i%

Private Sub CmdGrabar1_Click()
 Call grabar
End Sub

Private Sub CmdGrabar2_Click()
    Call grabar
End Sub

Private Sub CmbMoneda_Click()

   FpEntCom_Click
   FpRecCom_Click
   FpEntVen_Click
   FpRecVen_Click

End Sub

Private Sub cmbProducto_Click()

   If CmbResponsable.Text <> "" And cmbProducto.Text <> "" Then
      
      cmbProducto.Enabled = False
      CmbMoneda.Enabled = True
      CmbResponsable.Enabled = False
      TxtOmaC.Enabled = True
      TxtComercioC.Enabled = True
      FpEntCom.Enabled = True
      FpRecCom.Enabled = True
      TxtOmaV.Enabled = True
      TxtComercioV.Enabled = True
      FpEntVen.Enabled = True
      FpRecVen.Enabled = True
      TxtMonto.Enabled = True
      CmbContabiliza.Enabled = True
      CmbMoneda.Enabled = True
      CmbContabiliza.Text = "SI"
      
      Call Busca_Valores

   End If

End Sub

Private Sub CmbResponsable_Click()
   
   If cmbProducto.Text <> "" And CmbResponsable.Text <> "" Then
      
      cmbProducto.Enabled = False
      CmbMoneda.Enabled = True
      CmbResponsable.Enabled = False
      TxtOmaC.Enabled = True
      TxtComercioC.Enabled = True
      FpEntCom.Enabled = True
      FpRecCom.Enabled = True
      TxtOmaV.Enabled = True
      TxtComercioV.Enabled = True
      FpEntVen.Enabled = True
      FpRecVen.Enabled = True
      TxtMonto.Enabled = True
      CmbContabiliza.Enabled = True
      CmbMoneda.Enabled = True
      CmbContabiliza.Text = "SI"
      
      Call Busca_Valores
      
   End If

End Sub

Private Sub DateText1_Change()
 Label15.Text = Format(DateText1.Text, "dddd d, mmmm") + " de " + Str(Year(DateText1.Text))
End Sub

Private Sub DateText2_Change()
 Label1.Text = Format(DateText2.Text, "dddd d, mmmm") + " de " + Str(Year(DateText2.Text))
End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
   BAC_Parametros.MousePointer = 0
End Sub

Private Sub Form_Load()
   OptLocal = Opt
    Me.top = 0
    Me.left = 0

 top = 1
 left = 15
 ' recupera fecha de proceso
  'TxtFechCompra.Separator = Asc(gsc_FechaSeparador)
  'TxtFechVenta.Separator = Asc(gsc_FechaSeparador)
  'DateText1.Separator = Asc(gsc_FechaSeparador)
  DateText1.Text = Format(gsbac_fecp, gsc_FechaDMA)
 ' DateText2.Separator = Asc(gsc_FechaSeparador)
  DateText2.Text = Format(gsbac_fecp, gsc_FechaDMA)
 
 ' recupera datos implicitos
 ' Sql = "sp_cargaparametroscambio " & "'ME'"
   
   
 '  Envia = Array("ME")
   
 '  If Not BAC_SQL_EXECUTE("sp_cargaparametroscambio ", Envia) Then
 '   Exit Sub
 '  End If
 '  Call BAC_SQL_FETCH(Datos())

 'Sql = "sp_Bacfp"
 
 If Not BAC_SQL_EXECUTE("sp_Bacfp") Then
       
       Exit Sub
 
 End If
      
      FpRecCom.Clear 'inabilitado
      FpEntVen.Clear
      FpRecVen.Clear
      FpEntCom.Clear
   
    ' CmbOma.Clear

      CmbMoneda.Clear
      TxtMonto.Text = ""  'leo
 
 Do While BAC_SQL_FETCH(Datos())
                       
'  If Datos(3) = "S" Then  'recupera formas de pago para compras/recibimos Y Ventas/entregamos

         FpRecCom.AddItem Str(CDbl(Val(Datos(1)))) + " " + Trim(Datos(2)) + Space(100) + Datos(4)
         'FpRecCom.AddItem Datos(2) + Space(50) + Datos(1)   ' Maverick
         FpRecCom.ItemData(FpRecCom.ListCount - 1) = CDbl(Val(Datos(1)))
                              
         FpEntVen.AddItem Str(CDbl(Val(Datos(1)))) + " " + Trim(Datos(2)) + Space(100) + Datos(4)
         'FpEntVen.AddItem Datos(2) + Space(50) + Datos(1) ' Maverick
         FpEntVen.ItemData(FpEntVen.ListCount - 1) = CDbl(Val(Datos(1)))
  
'  Else ' N  recupera formas de pago para ventas/recibimos y compras/entregamos
                    
         FpRecVen.AddItem Str(CDbl(Val(Datos(1)))) + " " + Trim(Datos(2)) + Space(100) + Datos(4)
         'FpRecVen.AddItem Datos(2) + Space(50) + Datos(1) ' Maverick
         FpRecVen.ItemData(FpRecVen.ListCount - 1) = CDbl(Val(Datos(1)))
         
         FpEntCom.AddItem Str(CDbl(Val(Datos(1)))) + " " + Trim(Datos(2)) + Space(100) + Datos(4)
         'FpEntCom.AddItem Datos(2) + Space(50) + Datos(1)    ' Maverick
         FpEntCom.ItemData(FpEntCom.ListCount - 1) = CDbl(Val(Datos(1)))
  
  'End If

 Loop
  

Call bacLeerMonedas

Do While BAC_SQL_FETCH(Datos())
       CmbMoneda.AddItem Datos(1) + Space(80) + (Datos(4))
 

Loop
 
 Call LlenaConbP(Muestra)
  Sql = "1"
  Label1.Text = Format(DateText1.Text, "dddd d, mmmm") + " de " + Str(Year(DateText1.Text))
  Label15.Text = Format(DateText2.Text, "dddd d, mmmm") + " de " + Str(Year(DateText2.Text))

 Call CargaProducto
 Call CargaResponsable

 Call Limpiar
 
 Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
 
End Sub

Private Sub grabar() 'pendiente
'***************
If cmbProducto.Text = "" Or CmbResponsable.Text = "" Or FpEntCom.Text = "" Or FpRecCom.Text = "" _
   Or TxtOmaC.Text = "" Or TxtComercioC.Text = "" Or FpEntVen.Text = "" Or FpRecVen.Text = "" Or _
   TxtOmaV.Text = "" Or TxtComercioV.Text = "" Or CmbContabiliza.Text = "" Or TxtMonto.Text = "" Or _
   CmbMoneda.Text = "" Then

    MsgBox "Debe Ingresar Todos Los Datos", vbExclamation

    Else

      Envia = Array()
      AddParam Envia, "BCC"
      AddParam Envia, Trim(right(cmbProducto.Text, 5))
      AddParam Envia, Trim(right(CmbResponsable.Text, 5))
      AddParam Envia, CDbl(FpEntCom.ItemData(FpEntCom.ListIndex))
      AddParam Envia, CDbl(FpRecCom.ItemData(FpRecCom.ListIndex))
      AddParam Envia, CDbl(TxtOmaC.Text)
      AddParam Envia, left(TxtComercioC.Text, 6)
      'AddParam Envia, Right(TxtComercioC.Text, 3)
      AddParam Envia, CDbl(FpEntVen.ItemData(FpEntVen.ListIndex))
      AddParam Envia, CDbl(FpRecVen.ItemData(FpRecVen.ListIndex))
      AddParam Envia, CDbl(TxtOmaV.Text)
      AddParam Envia, left(TxtComercioV.Text, 6)
      'AddParam Envia, Right(TxtComercioV.Text, 3)
      AddParam Envia, left(CmbContabiliza.Text, 1)
      AddParam Envia, CDbl(TxtMonto.Text)
      AddParam Envia, CDbl(right(CmbMoneda.Text, 5))
      
      If Not BAC_SQL_EXECUTE("Sp_BacIniValDef_Graba", Envia) Then
      
         MsgBox "Problemas al Grabar Datos por Defecto", vbExclamation
         Call LogAuditoria("01", OptLocal, Me.Caption & " Error al Grabar- Compra OMA: " & TxtOmaC.Text & " Compra Comercio: " & TxtComercioC.Text & " Venta OMA: " & TxtOmaV.Text & " Venta Comercio: " & TxtComercioV.Text, "", "")
         Exit Sub
      
      End If
      
      MsgBox "Datos Guardados sin Problema", vbInformation
      Call LogAuditoria("01", OptLocal, Me.Caption, "", "Compra OMA: " & TxtOmaC.Text & " Compra Comercio: " & TxtComercioC.Text & " Venta OMA: " & TxtOmaV.Text & " Venta Comercio: " & TxtComercioV.Text)
      Call Limpiar
      
End If

End Sub

Private Sub cmdSalir_Click()
 Unload Me
End Sub


Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub FpEntCom_Click()

'   DateText1.Text = Format(gsbac_fecp, gsc_FechaDMA)
'   Call CalFeriado(Trim(Right(FpEntCom, 5)), DateText1, 3, "CLP")
'   Label15.Text = Format(DateText1.Text, "dddd d, mmmm") + " de " + Str(Year(DateText1.Text))

End Sub

Private Sub FpEntVen_Click()
 
'   TxtFechVenta.Text = Format(gsbac_fecp, gsc_FechaDMA)
'   Call CalFeriado(Trim(Right(FpEntVen, 5)), TxtFechVenta, 3, Trim(Right(CmbMoneda.Text, 5)))
'   LabelFechaE.Text = Format(TxtFechVenta.Text, "dddd d, mmmm") + " de " + Str(Year(TxtFechVenta.Text))
'
End Sub

Private Sub FpRecCom_Click()
 
'   TxtFechCompra.Text = Format(gsbac_fecp, gsc_FechaDMA)
'   Call CalFeriado(Trim(Right(FpRecCom, 5)), TxtFechCompra, 3, Trim(Right(CmbMoneda.Text, 5)))
'   LabelFechaR.Text = Format(TxtFechCompra.Text, "dddd d, mmmm") + " de " + Str(Year(TxtFechCompra.Text))
 
End Sub

Private Sub FpRecVen_Click()

'   DateText2.Text = Format(gsbac_fecp, gsc_FechaDMA)
'   Call CalFeriado(Trim(Right(FpRecVen, 5)), DateText2, 3, "CLP")
'   Label1.Text = Format(DateText2.Text, "dddd d, mmmm") + " de " + Str(Year(DateText2.Text))

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1
        Call Limpiar
    Case 2
        Call grabar
    Case 3
       Unload Me
End Select
End Sub

Private Sub TxtComercioC_DblClick()

    MiTag = "COMERCIO"
    BacAyuda.Show 1
    
    If giAceptar% = True Then
        
        TxtComercioC.Text = gsCodigo$
        LblGlosaC.Text = gsGlosa$
        TxtComercioC.Tag = right(gsCodigo$, 3)

   End If

If Me.TxtComercioC.Text <> "" Then
   
   Envia = Array()
   
   AddParam Envia, Me.TxtComercioC.Text
   
   If Not BAC_SQL_EXECUTE("Sp_Busca_Tbcodigo_Oma", Envia) Then
    
    Exit Sub
   
   End If
 
 
   If BAC_SQL_FETCH(Datost()) Then
    
    Me.TxtOmaC.Text = CDbl(Val(Datost(1)))
    Me.LblGlosaOmaC.Text = Datost(2)
  
   End If

End If

End Sub

Private Sub TxtComercioV_DblClick()

    MiTag = "COMERCIO"
    BacAyuda.Show 1
    
    If giAceptar% = True Then
        
        TxtComercioV.Text = gsCodigo$
        LblGlosaV.Text = gsGlosa$
        TxtComercioV.Tag = right(gsCodigo$, 3)

   End If

If Me.TxtComercioV.Text <> "" Then
   
   Envia = Array()
   
   AddParam Envia, Me.TxtComercioV.Text
   
   If Not BAC_SQL_EXECUTE("Sp_Busca_Tbcodigo_Oma", Envia) Then
    
    Exit Sub
   
   End If
 
 
   If BAC_SQL_FETCH(Datost()) Then
    
    Me.TxtOmaV.Text = CDbl(Val(Datost(1)))
    Me.LblGlosaOmaV.Text = Datost(2)
  
   End If

End If

End Sub

Private Sub txtMonto_KeyPress(KeyAscii As Integer)
 Call bacKeyPress(KeyAscii)
 'If KeyAscii = 13 And Trim(TxtMonto.Text) <> "0.0000" Then
 ' SendKeys "{tab}"
 'Else
 ' If (KeyAscii <= 47 Or KeyAscii >= 58) And KeyAscii <> 8 Then KeyAscii = 0
 'End If
End Sub

Public Function LlenaConbP(Muestra As String)
 ' recupera datos implicitos
   
   Sql = "sp_cargaparametros " & "'ME'"
   
   Envia = Array()
   
   AddParam Envia, "ME"
   
   If Not BAC_SQL_EXECUTE("sp_cargaparametros ", Envia) Then
    
    Exit Function
   
   End If
 
  'Call SQL_Fetch(Datos())
  
   Do While BAC_SQL_FETCH(Datost())
    
    TxtMonto.Text = CDbl(Val(Datost(13)))
  
   Loop
  
  For i = 0 To FpRecCom.ListCount - 1
   
   FpRecCom.ListIndex = i
   Sql = Trim(Str(CDbl(Val(IIf(Muestra = "PTAS", Datost(14), Datost(18))))))
   
   If CDbl(Val(IIf(Muestra = "PTAS", Datost(14), Datost(18)))) = FpRecCom.ItemData(i) Then Exit For
  
  Next i
  
  For i = 0 To FpEntCom.ListCount - 1
   
   FpEntCom.ListIndex = i
   
   If CDbl(Val(IIf(Muestra = "PTAS", Datost(15), Datost(19)))) = FpEntCom.ItemData(i) Then Exit For
  
  Next i
 
 For i = 0 To FpRecVen.ListCount - 1
   
   FpRecVen.ListIndex = i
   
   If CDbl(Val(IIf(Muestra = "PTAS", Datost(16), Datost(20)))) = FpRecVen.ItemData(i) Then Exit For
 
 Next i
 
 For i = 0 To FpEntVen.ListCount - 1
   
   FpEntVen.ListIndex = i
   
   If CDbl(Val(IIf(Muestra = "PTAS", Datost(17), Datost(21)))) = FpEntVen.ItemData(i) Then Exit For
 
 Next i
 
 ' Codigos OMAC
''  For I = 0 To CmbOma.ListCount - 1
''
''   CmbOma.ListIndex = I
''
''   If CDbl(Val(IIf(Muestra = "PTAS", Datost(28), Datost(24)))) = CmbOma.ItemData(I) Then Exit For
''
''  Next I
''
 ' Codigos OMAv
  
'''  For I = 0 To CmbOmaV.ListCount - 1
'''
'''   CmbOmaV.ListIndex = I
'''
'''   If CDbl(Val(IIf(Muestra = "PTAS", Datost(29), Datost(27)))) = CmbOmaV.ItemData(I) Then Exit For
'''
'''  Next I
'''
 'rentabilidad
'''''''  For I = 0 To cmbRentabilidad.ListCount - 1
'''''''
'''''''   cmbRentabilidad.ListIndex = I
'''''''   Sql = CDbl(Val(IIf(Muestra = "PTAS", Datost(30), Datost(25))))
'''''''
'''''''   If CDbl(Val(IIf(Muestra = "PTAS", Datost(30), Datost(25)))) = cmbRentabilidad.ItemData(I) Then Exit For
'''''''
'''''''  Next I
 'moneda
 
 If Muestra = "PTAS" Then
  
  For i = 0 To CmbMoneda.ListCount - 1
   
   CmbMoneda.ListIndex = i
   
   If "USD" = Mid(CmbMoneda, 1, 3) Then
    
    Exit For
   
   End If
  
  Next i
  
  CmbMoneda.Enabled = False
 
 Else
  
  For i = 0 To CmbMoneda.ListCount - 1
   
   CmbMoneda.ListIndex = i
   
   If Datost(26) = Mid(CmbMoneda, 1, 3) Then
    
    Exit For
   
   End If
  
  Next i
 
 CmbMoneda.Enabled = True
 
 End If

End Function

Private Sub TXTCOMPRA_Click()

End Sub

Sub CargaProducto()

   With cmbProducto
   
      .Clear
      
      Envia = Array()
      AddParam Envia, "BCC"
      
      If Not BAC_SQL_EXECUTE("Sp_Productos_X_Sistema", Envia) Then
      
         MsgBox "No se Encontraron Productos Para Cambio", vbExclamation
      
      End If

      While BAC_SQL_FETCH(Datos())
      
         .AddItem Datos(2) + Space(80) + Datos(1)
      
      Wend
   
   End With

End Sub

Sub CargaResponsable()

   With CmbResponsable
   
      .Clear
      
      If Not BAC_SQL_EXECUTE("Sp_BacIniValDef_DevuelveArea") Then
         
         MsgBox "Problemas al Cargar Areas", vbExclamation

      End If

      While BAC_SQL_FETCH(Datos())
      
         .AddItem Datos(2) + Space(80) + Datos(1)
      
      Wend

   End With
   
End Sub

Sub Limpiar()
On Error Resume Next

 Muestra = "EMPR"
 
   cmbProducto.ListIndex = -1: cmbProducto.Enabled = True
   CmbResponsable.ListIndex = -1: CmbResponsable.Enabled = True
   CmbMoneda.ListIndex = -1: CmbMoneda.Enabled = False
   TxtOmaC.Text = "":   TxtOmaC.Enabled = False
   TxtComercioC.Text = "": TxtComercioC.Enabled = False
   FpEntCom.ListIndex = -1: FpEntCom.Enabled = False
   FpRecCom.ListIndex = -1: FpRecCom.Enabled = False
   TxtOmaV.Text = "": TxtOmaV.Enabled = False
   TxtComercioV.Text = "": TxtComercioV.Enabled = False
   FpEntVen.ListIndex = -1: FpEntVen.Enabled = False
   FpRecVen.ListIndex = -1: FpRecVen.Enabled = False
   TxtMonto.Text = 0: TxtMonto.Enabled = False
   CmbContabiliza.ListIndex = -1: CmbContabiliza.Enabled = False
   CmbMoneda.ListIndex = -1: CmbMoneda.Enabled = False

End Sub

Private Sub TxtOmaC_DblClick()

'    MiTag = "tbCodigosOMA"
'    BacAyuda.Show 1
'
'    If giAceptar% = True Then
'
'        TxtOmaC.Text = gsCodigo$
'        LblGlosaOmaC.Text = gsGlosa$
'
'   End If

End Sub

Private Sub TxtOmaV_DblClick()
    
'    MiTag = "tbCodigosOMA"
'    BacAyuda.Show 1
'
'    If giAceptar% = True Then
'
'        TxtOmaV.Text = gsCodigo$
'        LblGlosaOmaV.Text = gsGlosa$
'
'   End If

End Sub


Sub Busca_Valores()

   Envia = Array()
   AddParam Envia, Trim(right(cmbProducto.Text, 5))
   AddParam Envia, Trim(right(CmbResponsable.Text, 5))

   If Not BAC_SQL_EXECUTE("Sp_BacIniValDef_xProducto", Envia) Then
   
      Exit Sub
      
   End If

   If BAC_SQL_FETCH(Datos()) Then

      TxtOmaC.Text = Datos(6)
      LblGlosaOmaC.Text = Datos(7)
      TxtComercioC.Text = Datos(8)
      LblGlosaC.Text = Datos(9)

      TxtOmaV.Text = Datos(12)
      LblGlosaOmaV.Text = Datos(13)
      TxtComercioV.Text = Datos(14)
      LblGlosaV.Text = Datos(15)
      
      TxtMonto.Text = BacCtrlTransMonto(Datos(17))
      CmbContabiliza.Text = IIf(Datos(16) = "S", "SI", "NO")

      For i = 0 To FpEntCom.ListCount - 1

         If FpEntCom.ItemData(i) = Datos(4) Then
            
            FpEntCom.ListIndex = i
            Exit For
            
         End If

      Next i

      For i = 0 To FpRecCom.ListCount - 1

         If FpRecCom.ItemData(i) = Datos(5) Then
            
            FpRecCom.ListIndex = i
            Exit For
            
         End If

      Next i
      
      Envia = Array()
      AddParam Envia, Trim(right(cmbProducto.Text, 5))
      AddParam Envia, Trim(right(CmbResponsable.Text, 5))
   
      If Not BAC_SQL_EXECUTE("Sp_BacIniValDef_xProducto", Envia) Then
      
         Exit Sub
         
      End If
      
      If BAC_SQL_FETCH(Datos()) Then
      
         For i = 0 To FpEntVen.ListCount - 1
   
            If FpEntVen.ItemData(i) = Datos(10) Then
               
               FpEntVen.ListIndex = i
               Exit For
               
            End If
   
         Next i
         
         Envia = Array()
         AddParam Envia, Trim(right(cmbProducto.Text, 5))
         AddParam Envia, Trim(right(CmbResponsable.Text, 5))
      
         If Not BAC_SQL_EXECUTE("Sp_BacIniValDef_xProducto", Envia) Then
         
            Exit Sub
            
         End If
         
         If BAC_SQL_FETCH(Datos()) Then
         
            For i = 0 To FpRecVen.ListCount - 1
      
               If FpRecVen.ItemData(i) = Datos(11) Then
                  
                  FpRecVen.ListIndex = i
                  Exit For
                  
               End If
      
            Next i
            
         End If
   
         For i = 0 To CmbMoneda.ListCount - 1
   
            
   
            If Trim(right(CmbMoneda.List(i), 5)) = Datos(18) Then
               
               CmbMoneda.ListIndex = i
               Exit For
               
            End If
   
         Next i
   
      End If

   End If

   TxtOmaC.SetFocus

End Sub


