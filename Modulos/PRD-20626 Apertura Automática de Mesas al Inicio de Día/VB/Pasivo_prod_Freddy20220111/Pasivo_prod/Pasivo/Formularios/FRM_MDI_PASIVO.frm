VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "crystl32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Begin VB.MDIForm FRM_MDI_PASIVO 
   BackColor       =   &H8000000F&
   Caption         =   "PASIVO"
   ClientHeight    =   6870
   ClientLeft      =   1830
   ClientTop       =   2625
   ClientWidth     =   11400
   Icon            =   "FRM_MDI_PASIVO.frx":0000
   LinkTopic       =   "BacTrd"
   NegotiateToolbars=   0   'False
   Picture         =   "FRM_MDI_PASIVO.frx":2EFA
   WhatsThisHelp   =   -1  'True
   WindowState     =   2  'Maximized
   Begin Crystal.CrystalReport Pasivo_Rpt 
      Left            =   9960
      Top             =   1080
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
      WindowState     =   2
      PrintFileLinesPerPage=   60
   End
   Begin Threed.SSPanel PnlInfo 
      Align           =   2  'Align Bottom
      Height          =   420
      Left            =   0
      TabIndex        =   1
      Top             =   6450
      Width           =   11400
      _Version        =   65536
      _ExtentX        =   20108
      _ExtentY        =   741
      _StockProps     =   15
      ForeColor       =   8421504
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      RoundedCorners  =   0   'False
      Outline         =   -1  'True
      Alignment       =   8
      Begin Threed.SSPanel Pnl_Entidad 
         Height          =   315
         Left            =   65
         TabIndex        =   8
         Top             =   60
         Width           =   4000
         _Version        =   65536
         _ExtentX        =   7056
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         RoundedCorners  =   0   'False
         Alignment       =   1
         Begin VB.Label Label1 
            Caption         =   "Normal"
            ForeColor       =   &H00000000&
            Height          =   255
            Left            =   2760
            TabIndex        =   11
            Top             =   -15
            Visible         =   0   'False
            Width           =   15
         End
         Begin VB.Label Lbl_Selec 
            Caption         =   "Seleccion"
            ForeColor       =   &H00C00000&
            Height          =   255
            Left            =   2640
            TabIndex        =   10
            Top             =   15
            Visible         =   0   'False
            Width           =   15
         End
      End
      Begin Threed.SSPanel PnlMensaje 
         Height          =   315
         Left            =   4065
         TabIndex        =   4
         Top             =   60
         Width           =   2685
         _Version        =   65536
         _ExtentX        =   4736
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   8421504
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
         BevelOuter      =   1
         RoundedCorners  =   0   'False
         Alignment       =   1
         Begin Threed.SSPanel Pnl_Usuario 
            Height          =   285
            Left            =   15
            TabIndex        =   6
            Top             =   15
            Width           =   2655
            _Version        =   65536
            _ExtentX        =   4683
            _ExtentY        =   503
            _StockProps     =   15
            ForeColor       =   -2147483639
            BackColor       =   -2147483646
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   0
            RoundedCorners  =   0   'False
            Outline         =   -1  'True
            Autosize        =   3
            Begin VB.Label LblMsg 
               Appearance      =   0  'Flat
               BackColor       =   &H00000000&
               BackStyle       =   0  'Transparent
               Caption         =   "V PRC 6,8%"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00FFFF00&
               Height          =   255
               Index           =   1
               Left            =   3870
               TabIndex        =   5
               Top             =   0
               Width           =   3825
            End
            Begin VB.Label LblMsg 
               Appearance      =   0  'Flat
               BackColor       =   &H00000000&
               BackStyle       =   0  'Transparent
               Caption         =   "C PRC 6,5%"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00FFFF00&
               Height          =   255
               Index           =   0
               Left            =   3870
               TabIndex        =   7
               Top             =   0
               Width           =   3150
            End
         End
      End
      Begin Threed.SSPanel Pnl_UF 
         Height          =   315
         Left            =   6765
         TabIndex        =   3
         Top             =   60
         Width           =   1980
         _Version        =   65536
         _ExtentX        =   3492
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         RoundedCorners  =   0   'False
      End
      Begin Threed.SSPanel Pnl_Fecha 
         Height          =   315
         Left            =   10635
         TabIndex        =   2
         Top             =   60
         Width           =   1470
         _Version        =   65536
         _ExtentX        =   2593
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         RoundedCorners  =   0   'False
         Autosize        =   3
      End
      Begin Threed.SSPanel Pnl_DO 
         Height          =   315
         Left            =   8760
         TabIndex        =   9
         Top             =   60
         Width           =   1860
         _Version        =   65536
         _ExtentX        =   3281
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         RoundedCorners  =   0   'False
      End
   End
   Begin Threed.SSPanel PnlTools 
      Align           =   1  'Align Top
      Height          =   60
      Left            =   0
      TabIndex        =   0
      Top             =   1350
      Visible         =   0   'False
      Width           =   11400
      _Version        =   65536
      _ExtentX        =   20108
      _ExtentY        =   106
      _StockProps     =   15
      ForeColor       =   65280
      BackColor       =   -2147483646
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   1.51
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   0
      BevelInner      =   1
      RoundedCorners  =   0   'False
      Outline         =   -1  'True
      Begin VB.Timer Tmr_Mensaje 
         Enabled         =   0   'False
         Interval        =   10000
         Left            =   9360
         Top             =   360
      End
      Begin Threed.SSCommand BOpcion_Menu_6 
         Height          =   375
         Left            =   2715
         TabIndex        =   14
         Top             =   120
         Width           =   420
         _Version        =   65536
         _ExtentX        =   741
         _ExtentY        =   661
         _StockProps     =   78
         Caption         =   "PP"
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
         RoundedCorners  =   0   'False
         Outline         =   0   'False
      End
      Begin Threed.SSCommand BOpcion_Menu_2 
         Height          =   375
         Left            =   600
         TabIndex        =   13
         Top             =   120
         Width           =   420
         _Version        =   65536
         _ExtentX        =   741
         _ExtentY        =   661
         _StockProps     =   78
         Caption         =   "LC"
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
         RoundedCorners  =   0   'False
         Outline         =   0   'False
      End
      Begin Threed.SSCommand BOpcion_Menu_1 
         Height          =   375
         Left            =   90
         TabIndex        =   12
         Top             =   120
         Width           =   420
         _Version        =   65536
         _ExtentX        =   741
         _ExtentY        =   661
         _StockProps     =   78
         Caption         =   "CB"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         RoundedCorners  =   0   'False
         Outline         =   0   'False
         Picture         =   "FRM_MDI_PASIVO.frx":9084
      End
      Begin Threed.SSCommand BOpcion_Menu_7 
         Height          =   375
         Left            =   3225
         TabIndex        =   15
         Top             =   120
         Width           =   420
         _Version        =   65536
         _ExtentX        =   741
         _ExtentY        =   661
         _StockProps     =   78
         Caption         =   "CO"
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
         RoundedCorners  =   0   'False
         Outline         =   0   'False
      End
      Begin Threed.SSCommand BOpcion_Menu_3 
         Height          =   375
         Left            =   1125
         TabIndex        =   17
         Top             =   120
         Width           =   420
         _Version        =   65536
         _ExtentX        =   741
         _ExtentY        =   661
         _StockProps     =   78
         Caption         =   "BL"
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
         RoundedCorners  =   0   'False
         Outline         =   0   'False
      End
      Begin Threed.SSCommand BOpcion_Menu_4 
         Height          =   375
         Left            =   1650
         TabIndex        =   18
         Top             =   120
         Visible         =   0   'False
         Width           =   420
         _Version        =   65536
         _ExtentX        =   741
         _ExtentY        =   661
         _StockProps     =   78
         Caption         =   "BE"
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
         RoundedCorners  =   0   'False
         Outline         =   0   'False
      End
      Begin Threed.SSCommand BOpcion_Menu_5 
         Height          =   375
         Left            =   2190
         TabIndex        =   19
         Top             =   120
         Width           =   420
         _Version        =   65536
         _ExtentX        =   741
         _ExtentY        =   661
         _StockProps     =   78
         Caption         =   "RE"
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
         RoundedCorners  =   0   'False
         Outline         =   0   'False
      End
      Begin VB.Label Label2 
         BackStyle       =   0  'Transparent
         Height          =   345
         Left            =   8430
         TabIndex        =   16
         Top             =   60
         Width           =   720
      End
   End
   Begin MSComctlLib.ImageList ILST_ImagenesMDI 
      Left            =   4920
      Top             =   960
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MDI_PASIVO.frx":90A0
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MDI_PASIVO.frx":F23A
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   7320
      Top             =   1080
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   13
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MDI_PASIVO.frx":153D4
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MDI_PASIVO.frx":15911
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MDI_PASIVO.frx":15E26
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MDI_PASIVO.frx":16262
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MDI_PASIVO.frx":16713
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MDI_PASIVO.frx":16C0F
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MDI_PASIVO.frx":1708F
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MDI_PASIVO.frx":17548
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MDI_PASIVO.frx":17A34
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MDI_PASIVO.frx":17F63
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MDI_PASIVO.frx":18485
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MDI_PASIVO.frx":189C9
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MDI_PASIVO.frx":18CA5
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   1350
      Left            =   0
      TabIndex        =   20
      Top             =   0
      Width           =   11400
      _ExtentX        =   20108
      _ExtentY        =   2381
      ButtonWidth     =   3175
      ButtonHeight    =   794
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   13
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Compra Bonos  "
            Object.ToolTipText     =   "Tipo Usuarios"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Ingreso Corfos "
            Object.ToolTipText     =   "Usuarios"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Ingreso Local  "
            Object.ToolTipText     =   "Bloqueo de Usuarios"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Ingreso Extras  "
            Object.Tag             =   "Privilegios de Usuario"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Renovaciones   "
            Object.ToolTipText     =   "Cambiar Clave Administrador"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Prepagos          "
            ImageIndex      =   12
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Consulta Op."
            ImageIndex      =   13
         EndProperty
      EndProperty
   End
   Begin VB.Menu Opcion_Menu_1000 
      Caption         =   "Inicio de Dia"
      Begin VB.Menu Opcion_Menu_3600 
         Caption         =   "Inicio de Dia"
         HelpContextID   =   1
      End
      Begin VB.Menu Opcion_Menu_3700 
         Caption         =   "Reprocesos"
         HelpContextID   =   1
      End
      Begin VB.Menu Opcion_Menu_3800 
         Caption         =   "Bloqueo / Desbloqueo de mesa"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Opcion_Menu_3000 
      Caption         =   "Operaciones"
      Begin VB.Menu Opcion_Menu_3100 
         Caption         =   "Colocación Bonos Propia Emisión"
         HelpContextID   =   1
      End
      Begin VB.Menu Opcion_Menu_3200 
         Caption         =   "Créditos"
         HelpContextID   =   1
         Begin VB.Menu Opcion_Menu_3201 
            Caption         =   "Ingreso Credito Corfo"
            HelpContextID   =   2
         End
         Begin VB.Menu Opcion_Menu_3202 
            Caption         =   "Ingreso Créditos de Bancos Locales"
            HelpContextID   =   2
         End
         Begin VB.Menu Opcion_Menu_3203 
            Caption         =   "Ingreso Créditos de Bancos Extra"
            HelpContextID   =   2
         End
         Begin VB.Menu Opcion_Menu_3204 
            Caption         =   "Renovación de Créditos"
            HelpContextID   =   2
         End
         Begin VB.Menu Opcion_Menu_3205 
            Caption         =   "Pre-Pagos de Créditos"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Opcion_Menu_3300 
         Caption         =   "Consulta Operaciones"
         HelpContextID   =   1
      End
      Begin VB.Menu Opcion_Menu_3400 
         Caption         =   "Valorizador de Instrumentos Pasivos"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Opcion_Menu_4000 
      Caption         =   "Reportes"
      Begin VB.Menu Opcion_Menu_4100 
         Caption         =   "Carteras"
         HelpContextID   =   1
      End
      Begin VB.Menu Opcion_Menu_4200 
         Caption         =   "Movimientos Diarios"
         HelpContextID   =   1
      End
      Begin VB.Menu Opcion_Menu_4300 
         Caption         =   "Vencimientos"
         HelpContextID   =   1
         Begin VB.Menu Opcion_Menu_4301 
            Caption         =   "Vencimientos del Día"
            HelpContextID   =   2
         End
         Begin VB.Menu Opcion_Menu_4302 
            Caption         =   "Vencimientos Proyectados"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Opcion_Menu_4350 
         Caption         =   "Informes Contables"
         HelpContextID   =   1
         Begin VB.Menu Opcion_Menu_4351 
            Caption         =   "Contabilidad diaria"
            HelpContextID   =   2
         End
         Begin VB.Menu Opcion_Menu_4352 
            Caption         =   "Contabilidad diaria por Movimiento"
            HelpContextID   =   2
         End
         Begin VB.Menu Opcion_Menu_4353 
            Caption         =   "Contabilidad diaria por Cuenta"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Opcion_Menu_4400 
         Caption         =   "Reimpresión de Papeletas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opcion_Menu_4500 
         Caption         =   "Capitales Computables"
         HelpContextID   =   1
      End
      Begin VB.Menu Opcion_Menu_4600 
         Caption         =   "Informe de Tasas Promedio"
         HelpContextID   =   1
      End
      Begin VB.Menu Opcion_Menu_4700 
         Caption         =   "Informe de Flujo de Cajas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opcion_Menu_6602 
         Caption         =   "Diferencias Carteras"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Opcion_Menu_2000 
      Caption         =   "Administración"
      Begin VB.Menu Opcion_Menu_2100 
         Caption         =   "Archivos Maestros"
         HelpContextID   =   1
         Begin VB.Menu Opcion_Menu_2103 
            Caption         =   "Instrumentos"
            HelpContextID   =   2
         End
         Begin VB.Menu Opcion_Menu_2101 
            Caption         =   "Series"
            HelpContextID   =   2
         End
         Begin VB.Menu Opcion_Menu_2104 
            Caption         =   "Formulas"
            HelpContextID   =   2
         End
         Begin VB.Menu Opcion_Menu_2102 
            Caption         =   "Porcentaje Computable"
            HelpContextID   =   2
         End
         Begin VB.Menu Opcion_Menu_2105 
            Caption         =   "Tabla de Desarrollo"
            HelpContextID   =   2
         End
         Begin VB.Menu Opcion_Menu_2106 
            Caption         =   "Flujo de Caja"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Opcion_Menu_2200 
         Caption         =   "Seguridad"
         HelpContextID   =   1
         Begin VB.Menu Opcion_Menu_2201 
            Caption         =   "Cambio de Password"
            HelpContextID   =   2
         End
      End
   End
   Begin VB.Menu Opcion_Menu_6000 
      Caption         =   "Cierre de Día"
      Begin VB.Menu Opcion_Menu_6400 
         Caption         =   "Contabilidad"
         HelpContextID   =   1
         Begin VB.Menu Opcion_Menu_6500 
            Caption         =   "Contabilidad Automatica"
            HelpContextID   =   2
         End
         Begin VB.Menu Opcion_Menu_6300 
            Caption         =   "Devengamiento"
            HelpContextID   =   2
         End
         Begin VB.Menu Opcion_Menu_6600 
            Caption         =   "Fin de Dia"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Opcion_Menu_6601 
         Caption         =   "Interfaz para C08 (descalce)"
         HelpContextID   =   1
      End
      Begin VB.Menu Opcion_Menus_6601 
         Caption         =   "Interfaz P36"
         HelpContextID   =   1
      End
      Begin VB.Menu Opcion_Menus_6700 
         Caption         =   "Interfaces Sigir"
         HelpContextID   =   1
      End
      Begin VB.Menu Opcion_Menus_6800 
         Caption         =   "Interfaz C40"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Opcion_Menu_7000 
      Caption         =   "Salir"
   End
End
Attribute VB_Name = "FRM_MDI_PASIVO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim cEstado          As Integer
Dim nTemporal        As Integer
Dim objCierreMesa    As Object
Dim cOptLocal        As String
Private Declare Function GetDeviceCaps Lib "gdi32" (ByVal hdc As Long, ByVal nIndex As Long) As Long
Dim clsWall As New CLS_Wallpaper

Sub PROC_DESHABILITA_MENU()

   On Error Resume Next
   
   Dim nContador As Integer
   
   For nContador = 0 To Me.Controls.Count - 1
      
      If TypeOf Me.Controls(nContador) Is Menu Then
      
         If Me.Controls(nContador).Caption <> "-" And Me.Controls(nContador).Caption <> "?" And Me.Controls(nContador).Caption <> "Salir" And Me.Controls(nContador).Caption <> "Salir del Sistema" Then
            
            Me.Controls(nContador).Visible = False
         
         End If
      
      End If
      
      If TypeOf Me.Controls(nContador) Is SSCommand Then
         
         Me.Controls(nContador).Enabled = False
      
      End If

    Next nContador

End Sub

Sub PROC_HABILITA_MENU()
   
   On Error Resume Next
   
   Dim nContador As Integer
   
   For nContador = 0 To Me.Controls.Count - 1
   
      If TypeOf Me.Controls(nContador) Is Menu Then
      
         If Me.Controls(nContador).Caption <> "-" And Me.Controls(nContador).Caption <> "?" And Me.Controls(nContador).Caption <> "Salir" And Me.Controls(nContador).Caption <> "Salir del Sistema" Then
         
            Me.Controls(nContador).Visible = True
         
         End If
      
      End If
      If TypeOf Me.Controls(nContador) Is SSCommand Then
         
         Me.Controls(nContador).Enabled = True
      
      End If

    Next nContador
    
End Sub

Sub PROC_CARGA_PRIVILEGIOS()
    
   On Error Resume Next
    
    Dim vDatos_Retorno()
    Dim nContador

   If Trim(GLB_Usuario_Bac) = "ADMINISTRA" Then
      
      Call PROC_HABILITA_MENU
      Exit Sub
   
   End If

   GLB_Envia = Array()
   PROC_AGREGA_PARAMETRO GLB_Envia, "T"
   PROC_AGREGA_PARAMETRO GLB_Envia, "PSV"
   PROC_AGREGA_PARAMETRO GLB_Envia, GLB_Tipo_Usuario_Bac

   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_PRIVILEGIOS", GLB_Envia) Then
   
      Exit Sub
   
   End If


   Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno)
      
      On Error Resume Next
      
      For nContador = 0 To Me.Controls.Count - 1
         
         If TypeOf Me.Controls(nContador) Is Menu Then
            
            If Trim(Me.Controls(nContador).Name) = Trim(vDatos_Retorno(1)) Then
               
               Me.Controls(nContador).Visible = True
            
            End If
         
         End If
         
         If TypeOf Me.Controls(nContador) Is SSCommand Then
            
            If Trim(Me.Controls(nContador).Name) = "B" + Trim(vDatos_Retorno(1)) Then
               
               Me.Controls(nContador).Enabled = True
            
            End If
         
         End If
      
      Next nContador
   
   Loop


   GLB_Envia = Array()
   PROC_AGREGA_PARAMETRO GLB_Envia, "U"
   PROC_AGREGA_PARAMETRO GLB_Envia, "PSV"
   PROC_AGREGA_PARAMETRO GLB_Envia, GLB_Usuario_Bac

   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_PRIVILEGIOS", GLB_Envia) Then
      
      Exit Sub
   
   End If

   Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno)
      
      On Error Resume Next
      
      For nContador = 0 To Me.Controls.Count - 1
         
         If TypeOf Me.Controls(nContador) Is Menu Then
            
            If Trim(Me.Controls(nContador).Name) = Trim(vDatos_Retorno(1)) Then
               
               Me.Controls(nContador).Visible = IIf(Mid(vDatos_Retorno(2), 1, 1) = "N", False, True)
            
            End If
         
         End If
         
         If TypeOf Me.Controls(nContador) Is SSCommand Then
            
            If Trim(Me.Controls(nContador).Name) = "B" + Trim(vDatos_Retorno(1)) Then
               
               Me.Controls(nContador).Enabled = IIf(Mid(vDatos_Retorno(2), 1, 1) = "N", False, True)
            
            End If
         
         End If
      
      Next nContador
   
   Loop
   
End Sub
Private Sub MDIForm_Activate()

   PROC_CARGA_AYUDA Me
   
   cEstado = 1
   
   Screen.MousePointer = 0
   
   Me.Caption = App.Title & " ( Sql Server ) " & GLB_SQL_Server & "/" & GLB_SQL_Database

   If Not GLB_Login_Bac Then
   
      If Not FUNC_CARGA_PARAMETROS Then
      
         MsgBox "Error en la recuperación de datos de parámetros.", vbCritical
         End
         
      End If
      
      Call PROC_DESHABILITA_MENU
      
      FRM_ACCESO_USUARIO.Show vbModal
      
      If GLB_Login_Bac Then
      
         Screen.MousePointer = 11
         PROC_CARGA_PRIVILEGIOS
         Tmr_Mensaje.Enabled = True
         
            Toolbar1.Buttons(1).Enabled = Opcion_Menu_3100.Enabled
            Toolbar1.Buttons(3).Enabled = Opcion_Menu_3201.Enabled
            Toolbar1.Buttons(5).Enabled = Opcion_Menu_3202.Enabled
            Toolbar1.Buttons(7).Enabled = Opcion_Menu_3203.Enabled
            Toolbar1.Buttons(9).Enabled = Opcion_Menu_3204.Enabled
            Toolbar1.Buttons(11).Enabled = Opcion_Menu_3205.Enabled
            Toolbar1.Buttons(13).Enabled = Opcion_Menu_3300.Enabled
      Else
      
         Unload Me
         Exit Sub
         
      End If
      
      PROC_GUARDAR_REGISTRO "SISTEMAS BAC", "NET", "USER_NAME", GLB_Usuario_Bac
      
      Pnl_Usuario.Caption = GLB_Usuario_Bac
      
   End If
        
   Pnl_Entidad.Caption = Mid$(GLB_Cliente_Bac, 1, 30)
   GLB_Tasa_Camara = 0
   Screen.MousePointer = 0
   
   
End Sub

Public Function FUNC_CARGA_PARAMETROS() As Boolean


      FUNC_CARGA_PARAMETROS = Carga_Parametros()



     FRM_MDI_PASIVO.Pnl_UF.Caption = "U.F. : " + Format(GLB_UF, GLB_Formato_Decimal)
     FRM_MDI_PASIVO.Pnl_DO.Caption = "D.O. : " + Format(GLB_DO, GLB_Formato_Decimal)
     FRM_MDI_PASIVO.Pnl_DO.Refresh
     FRM_MDI_PASIVO.Pnl_UF.Refresh
     FRM_MDI_PASIVO.Pnl_Fecha.Caption = GLB_Fecha_Proceso


End Function


Sub PROC_GENERA_MENU(cEntidad As String)

    Dim nIndice         As Integer: nIndice = 1
    Dim cPrimera_Vez    As String:  cPrimera_Vez = "S"
    Dim nContador       As Integer
    Dim nInterfaz       As Integer

   For nContador = 0 To Me.Controls.Count - 1
   
        If TypeOf Me.Controls(nContador) Is Menu Then
        
            If Me.Controls(nContador).Caption <> "-" And Me.Controls(nContador).Caption <> "?" And Me.Controls(nContador).Visible And Me.Controls(nContador).Caption <> "Salir" Then
            
                nInterfaz = 0
                GLB_Envia = Array(cPrimera_Vez, cEntidad, CDbl(nIndice), Me.Controls(nContador).Caption, Me.Controls(nContador).Name, Format(Me.Controls(nContador).HelpContextID, "0"))
                              
               On Error Resume Next
               
               nInterfaz = Me.Controls(nContador).Index
                     
                          
                PROC_AGREGA_PARAMETRO GLB_Envia, nInterfaz
                nIndice = nIndice + 1
                
                If Not FUNC_EXECUTA_COMANDO_SQL("SP_PRO_GENERA_MENU", GLB_Envia) Then
                
                    Exit Sub
                
                End If
                
                cPrimera_Vez = "N"
                
            End If
            
        End If
        
    Next nContador

End Sub


Private Sub MDIForm_Load()
   nTemporal = 0
   
   Dim hModule As Integer
   Dim numcargas As Integer
   Dim vDatos_Retorno()
   
   PROC_ImagenFondo Me
   PROC_Wallpaper
   
   Screen.MousePointer = 11
   
   FRM_MDI_PASIVO.Pasivo_Rpt.WindowParentHandle = FRM_MDI_PASIVO.hwnd
   
   Call PROC_DETECTAR_RESOLUCION(Me, FRM_FONDO_MDI)
      
   If App.PrevInstance Then
   
      Screen.MousePointer = 0
      MsgBox "Sistema está cargado en memoria.", vbExclamation
      End
      
   End If
   
   If Not FUNC_VALIDA_CONFIGURACION_REGIONAL() Then
   
      Screen.MousePointer = 0
      MsgBox "Debe cambiar el formato de fecha como dd/mm/aaaa antes de ejecutar el sistema.", vbCritical
      End
      
   End If


'   If Not FUNC_INICIO_SISTEMA Then ' Parametros de Inicio.-
'      Screen.MousePointer = 0
'      End
'   End If
   
   If Not BacInit Then ' Parametros de Inicio.-
      Screen.MousePointer = 0
      End
   End If
  
 
  
   If Not FUNC_BAC_LOGIN(GLB_SQL_Login, GLB_SQL_Password) Then
   
      Screen.MousePointer = 0
      MsgBox "Problemas de Comunicación con el Servidor SQL", vbCritical
      End
      
   End If
      
   Screen.MousePointer = 0
   
   
   If Mid(Command, 1, 11) = "GENERA_MENU" Then
   
      PROC_GENERA_MENU "PSV"
      Call FUNC_DESCONECTAR_SQL
      Screen.MousePointer = 0
      End
   
   End If

  
   PROC_TITULO_MODULO "PSV", GLB_Version_Sistema
    
   Screen.MousePointer = 0

End Sub

Private Sub MDIForm_Resize()

    Dim strError As String
    Call clsWall.CreateFormPicture(Me, 4, strError)

End Sub


Private Sub MDIForm_Unload(nCancel As Integer)

Dim cSalir As String

   If GLB_Login_Bac Then
      
      nCancel = MsgBox("¿Seguro que desea Salir?", vbQuestion + vbYesNo) = vbNo
   
      Call PROC_LOG_AUDITORIA("06", "Pasivo", Me.Caption, "", "")
   
      If nCancel Then
       
         Exit Sub
       
      End If
         
   
      If FUNC_BLOQUEA_USUARIO(False, GLB_Usuario_Bac) Then
          
          Dim nLogCs As Integer
          
      
      End If
   
   End If

   Call FUNC_DESCONECTAR_SQL

   End

End Sub

Private Sub Opcion_Menu_2101_Click()

   cOpt = "Opcion_Menu_2101"
   PROC_CONTROLVENTA 100
   Screen.MousePointer = 11
   On Error GoTo SALIR
   FRM_MAN_SERIE.Show vbNormal
  
   Screen.MousePointer = 0

SALIR:
   If Err.Number = 364 Then Err.Number = 0
   Screen.MousePointer = 0
End Sub

Private Sub Opcion_Menu_2102_Click()

   GLB_Opcion_Menu = "Opcion_Menu_2102"
   
   FRM_PORCENTAJE_COMPUTABLE.Show

End Sub

Private Sub Opcion_Menu_2103_Click()

   GLB_Opcion_Menu = "Opcion_Menu_2103"
   
   FRM_MANTENEDOR_INSTRUMENTOS.Show
   
End Sub

Private Sub Opcion_Menu_2104_Click()

   GLB_Opcion_Menu = "Opcion_Menu_2104"
   
   FRM_FORMULAS.Show
   
End Sub

Private Sub Opcion_Menu_2105_Click()
 GLB_Opcion_Menu = "Opcion_Menu_4150"
   
   FRM_MAN_TABLA_DESARROLLO.Show

End Sub

Private Sub Opcion_Menu_2106_Click()
    Frm_FlujoCaja.Show
End Sub

Private Sub Opcion_Menu_2201_Click()

   GLB_Opcion_Menu = "Opcion_Menu_2201"
   
   If Trim(GLB_Usuario_Bac) = "ADMINISTRA" Then
      MsgBox "Clave de Administrador no puede ser cambiada desde el sistema.", vbExclamation
      Exit Sub
   End If
   
   FRM_CAMBIO_PASSWORD.Show vbModal
   
End Sub

Private Sub Opcion_Menu_3100_Click()
Dim Datos()
GLB_Envia = Array("PSV")
   
     If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
     
        Do While FUNC_LEE_RETORNO_SQL(Datos())
    
            If Datos(5) = 1 And Datos(6) = "MESA" Then

               MsgBox "Mesa esta bloqueada", vbExclamation
               Exit Sub
    
           End If
        Loop
        
        cOpt = "Opcion_Menu_3100"
    
        Screen.MousePointer = 11
        On Error GoTo SALIR
        GLB_Tipo_llamado = "G"
        FRM_ING_BONOS.Show
        Screen.MousePointer = 0
        
    End If
    
    Exit Sub
    
SALIR:
   
   If Err.Number = 364 Then Err.Number = 0
   Screen.MousePointer = 0
    
End Sub

Private Sub Opcion_Menu_3201_Click()
    GLB_Opcion_Menu = "Opcion_Menu_3201"
    Dim Datos()
    GLB_Envia = Array("PSV")
    
     If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(Datos())
            If Datos(5) = 0 And Datos(6) = "MESA" Then
                    GLB_Opcion_Menu = "Opcion_Menu_3201"
                    FRM_ING_CORFO.Show
                    Exit Sub
            End If
        Loop
        
        MsgBox "Mesa esta bloqueada", vbExclamation
        Exit Sub
        
    End If
    Exit Sub
End Sub
Private Sub Opcion_Menu_3202_Click()
   Dim Datos()
   GLB_Envia = Array("PSV")
   
    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(Datos())
           If Datos(5) = 0 And Datos(6) = "MESA" Then
                GLB_Opcion_Menu = "Opcion_Menu_3202"
                FRM_ING_BANCO_LOCAL.Show
   
               Exit Sub
      
           End If

        Loop
        
        MsgBox "Mesa esta bloqueada", vbExclamation
        Exit Sub
        
    End If
        Exit Sub
End Sub
Private Sub Opcion_Menu_3203_Click()
  
   Call Chequeo_Estado(GLB_Sistema, "MESA", False)
      
   Dim Datos()
   GLB_Envia = Array("PSV")
    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(Datos())
           If Datos(5) = 0 And Datos(6) = "MESA" Then
                GLB_Opcion_Menu = "Opcion_Menu_3203"
                FRM_ING_BANCO_EXT.Show
   
                Exit Sub
          End If
        Loop
        
        MsgBox "Mesa esta bloqueada", vbExclamation
    End If
    
End Sub
Private Sub Opcion_Menu_3204_Click()
  
   Dim Datos()
   GLB_Envia = Array("PSV")
    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(Datos())
           If Datos(5) = 0 And Datos(6) = "MESA" Then
                GLB_Opcion_Menu = "Opcion_Menu_3204"
                FRM_RENOVACIONES.Show
               Exit Sub
          End If
        Loop
        MsgBox "Mesa esta bloqueada", vbExclamation
    End If
End Sub
Private Sub Opcion_Menu_3205_Click()
   Dim Datos()
   GLB_Envia = Array("PSV")

    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(Datos())
           If Datos(5) = 0 And Datos(6) = "MESA" Then
                GLB_Opcion_Menu = "Opcion_Menu_3205"
                FRM_PRE_PAGOS.Show
                Exit Sub
          End If
        Loop
        MsgBox "Mesa esta bloqueada", vbExclamation
    End If
End Sub
Private Sub Opcion_Menu_3300_Click()
    Dim Datos()
    GLB_Envia = Array("PSV")

    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(Datos())
           If Datos(5) = 0 And Datos(6) = "MESA" Then
                GLB_Opcion_Menu = "Opcion_Menu_3300"
                FRM_CONSULTA_OPERACIONES.Show
                Exit Sub
                Exit Sub
          End If
        Loop
        MsgBox "Mesa esta bloqueada", vbExclamation
    End If
End Sub
Private Sub Opcion_Menu_3400_Click()
   
   GLB_Opcion_Menu = "Opcion_Menu_3400"
   FRM_VALORIZAR.Show
   
End Sub
Private Sub Opcion_Menu_3500_Click()

   Dim sMensaje            As String
   
    Call Chequeo_Estado("PSV", "INICIO", False, sMensaje)

   GLB_Opcion_Menu = "Opcion_Menu_3500"
   
   FRM_BLOQUEO_MESA.Show

End Sub
Private Sub Opcion_Menu_3600_Click()
   
   GLB_Opcion_Menu = "Opcion_Menu_3600"
   
   FRM_INICIODIA.Show
   
End Sub
Private Sub Opcion_Menu_3700_Click()
   GLB_Opcion_Menu = "Opcion_Menu_3700"
   
   FRM_REPROCESO_PASIVOS.Show
End Sub
Private Sub Opcion_Menu_3800_Click()

   GLB_Opcion_Menu = "Opcion_Menu_3800"
   
   FRM_BLOQUEO_MESA.Show

End Sub
Private Sub Opcion_Menu_4100_Click()
   
   GLB_Opcion_Menu = "Opcion_Menu_4100"
   
   FRM_RPT_CARTERA.Show
   
End Sub
Private Sub Opcion_Menu_4200_Click()
   
   GLB_Opcion_Menu = "Opcion_Menu_4200"
   
   FRM_RPT_MOVIMIENTOS.Show

End Sub
Private Sub Opcion_Menu_4301_Click()

   Dim Frm_vencimiento_1 As Form

   GLB_Opcion_Menu = "Opcion_Menu_4301"
   
   Set Frm_vencimiento_1 = New FRM_RPT_VENCIMIENTOS
   
   Frm_vencimiento_1.Show

End Sub
Private Sub Opcion_Menu_4302_Click()

   Dim Frm_vencimiento_2 As Form
   
   GLB_Opcion_Menu = "Opcion_Menu_4302"
   
   Set Frm_vencimiento_2 = New FRM_RPT_VENCIMIENTOS
   
   Frm_vencimiento_2.Show
   
End Sub

Private Sub Opcion_Menu_4351_Click()
   GLB_Opcion_Menu = "Opcion_Menu_4351"
   FRM_RPT_REPORTES.Show
End Sub

Private Sub Opcion_Menu_4352_Click()
   GLB_Opcion_Menu = "Opcion_Menu_4352"
   FRM_RPT_REPORTES.Show
End Sub

Private Sub Opcion_Menu_4353_Click()
   GLB_Opcion_Menu = "Opcion_Menu_4353"
   FRM_RPT_REPORTES.Show
End Sub

Private Sub Opcion_Menu_4400_Click()

   GLB_Opcion_Menu = "Opcion_Menu_4400"

   FRM_RPT_PAPELETA.Show

End Sub
Private Sub Opcion_Menu_4500_Click()

   GLB_Opcion_Menu = "Opcion_Menu_4500"

   FRM_RPT_COMPUTABLE.Show
   
End Sub
Private Sub Opcion_Menu_4600_Click()
   GLB_Opcion_Menu = "Opcion_Menu_4600"
   FRM_RPT_REPORTES.Show
End Sub
Private Sub Opcion_Menu_4700_Click()

Dim cFecha_mes  As Integer
Dim cFecha_Ano   As Integer

    Call PROC_LIMPIAR_CRISTAL
    
    cFecha_mes = Month(GLB_Fecha_Proceso) '- 1
    cFecha_Ano = Year(GLB_Fecha_Proceso) '
                  
    FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "INFORME_DE_FLUJO_DE_CAJA_PARAMETRICO.RPT"
    PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
    FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_mes
    FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Ano
    FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
    FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1


End Sub
Private Sub Opcion_Menu_6300_Click()
     Dim Datos()
     GLB_Envia = Array("PSV")
     If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(Datos())
           If (Datos(5) = 0 And Datos(6) = "MESA") Then
               MsgBox "Mesa esta desbloqueada", vbExclamation
               Exit Sub
           End If
           If mvarFinMesEspecial = False Then
               If Datos(5) = 0 And Datos(6) = "CONTABILIDAD" Then
                   MsgBox "Proceso contable no se ha realizado", vbExclamation
                   Exit Sub
               End If
           End If
           If Datos(5) = 1 And Datos(6) = "FIN" Then
               MsgBox "Fin de dìa realizado", vbExclamation
               Exit Sub
           End If
           
           If Datos(5) = 0 And Datos(6) = "UF" Then
                MsgBox "Falta valor de la UF para el proxima fecha de proceso", vbInformation
                Exit Sub
           End If
        
        Loop
        FRM_PRO_DEVENGO.Show vbNormal
        Exit Sub
     End If
     
     Exit Sub
     
End Sub
'**********************************JuanLizama***********************************

Private Sub Opcion_Menu_6500_Click()

    Dim nCancel As Integer
    Dim Datos()
    GLB_Envia = Array(GLB_Sistema)
    Dim flag As Boolean
    flag = 0
    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(Datos())
            If Datos(5) = 0 And Datos(6) = "MESA" Then
                MsgBox "Para realizar la contabilidad automatica debe realizar primero el Cierre de Mesa", vbInformation
                flag = 1
                Exit Sub
            End If

            If mvarFinMesEspecial = False Then
'                If Datos(5) = 1 And Datos(6) = "DEVENGAMIENTO" Then
'                    MsgBox "Devengamiento realizado", vbInformation
'                    flag = 1
'                    Exit Sub
'                End If
            End If
            
            
            If Datos(5) = 1 And Datos(6) = "FIN" Then
                MsgBox "Fin de dia realizado", vbInformation
                flag = 1
                Exit Sub
            End If
            
            If Datos(5) = 0 And Datos(6) = "UF" Then
                MsgBox "Falta valor de la UF para el proxima fecha de proceso", vbInformation
                flag = 1
                Exit Sub
            End If
            
        Loop
    End If
    
    If flag = 0 Then
        Contabilizacion_Automatica.Show vbNormal
    End If

End Sub

 Private Sub Opcion_Menu_6600_Click()

 GLB_Opcion_Menu = "Opcion_Menu_6600"
 Call PROC_LOG_AUDITORIA("07", GLB_Opcion_Menu, "Fin de Día" & " Fecha Proceso: " & GLB_Fecha_Proceso, "", "")
   Dim nCancel As Integer
   Dim Datos()
   GLB_Envia = Array("PSV")

     If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(Datos())
            If (Datos(5) = 0 And Datos(6) = "DEVENGAMIENTO") And (Datos(5) = 0 And Datos(6) = "CONTABILIDAD") And (Datos(5) = 0 And Datos(6) = "MESA") Then
                MsgBox "Debe realizar Devengamiento, Contabilidad y Cierre de Mesa", vbInformation
                Exit Sub
            ElseIf Datos(5) = 0 And Datos(6) = "DEVENGAMIENTO" Then
                MsgBox "Para realizar fin de dia debe realizar primero el Devengamiento", vbInformation
                Exit Sub
            ElseIf Datos(5) = 0 And Datos(6) = "CONTABILIDAD" Then
                MsgBox "Para realizar fin de dia debe realizar primero el Contabilidad", vbInformation
                Exit Sub
            ElseIf Datos(5) = 0 And Datos(6) = "MESA" Then
                MsgBox "Para realizar fin de dia debe realizar primero el Cierre de Mesa", vbInformation
                Exit Sub
            ElseIf Datos(5) = 1 And Datos(6) = "FIN" Then
                MsgBox "Fin de día ya se ha realizado ", vbInformation
                Exit Sub
            End If
        Loop
        
        nCancel = MsgBox("¿Desea Realizar Fin de Dia?", vbQuestion + vbYesNo) = vbNo

        If nCancel Then
           Exit Sub
           Call PROC_LOG_AUDITORIA("19", GLB_Opcion_Menu, "Fin de Día" & " (Proceso No Ralizado) Fecha Proceso: " & GLB_Fecha_Proceso, "", "")
        Else
           Call Grabar_Estado("PSV", "FIN", 1, True)
           Call Grabar_Estado("PSV", "INICIO", 0, True)
           MsgBox "Fin de dia realizado", vbInformation
           Call PROC_LOG_AUDITORIA("19", GLB_Opcion_Menu, "Fin de Día" & " (Proceso Ralizado) Fecha Proceso: " & GLB_Fecha_Proceso, "", "")
           Exit Sub
        End If

        Exit Sub
    End If
    Call PROC_LOG_AUDITORIA("08", GLB_Opcion_Menu, "Fin de Día" & " Fecha Proceso: " & GLB_Fecha_Proceso, "", "")
End Sub

Private Sub Opcion_Menu_6601_Click()
GLB_Opcion_Menu = "Opcion_Menu_6601"
    FRM_Interfaz_Descalce.Show
End Sub

Private Sub Opcion_Menu_6602_Click()
   GLB_Opcion_Menu = "Opcion_Menu_6602"
   
   FRM_RPT_DIFERENCIA_CARTERA.Show
End Sub

'*******************************************************************************

Private Sub Opcion_Menu_7000_Click()

Dim cSalir As String
Dim Rta

   If GLB_Login_Bac Then
      
      Rta = MsgBox("¿Seguro que desea Salir?", vbQuestion + vbYesNo)
   
      Call PROC_LOG_AUDITORIA("06", "Pasivo", Me.Caption, "", "")
   
      If Rta = vbNo Then
       
         Exit Sub
       
      End If
         
   
      If FUNC_BLOQUEA_USUARIO(False, GLB_Usuario_Bac) Then
          
          Dim nLogCs As Integer
          
      
      End If
   
   End If

   Call FUNC_DESCONECTAR_SQL

   End
   
End Sub
Private Sub Opcion_Menus_6601_Click()
Dim Respuesta
Dim Meses(12) As String

Meses(1) = "Enero"
Meses(2) = "Febrero"
Meses(3) = "Marzo"
Meses(4) = "Abril"
Meses(5) = "Mayo"
Meses(6) = "Junio"
Meses(7) = "Julio"
Meses(8) = "Agosto"
Meses(9) = "Septiembre"
Meses(10) = "Octubre"
Meses(11) = "Noviembre"
Meses(12) = "Diciembre"

If Month(GLB_Fecha_Proceso) - 1 = 0 Then
    Meses(Month(GLB_Fecha_Proceso) - 1) = "Diciembre"
End If

Respuesta = MsgBox("¿Desea generar interfaz P36, correspondiente al mes de " & Meses(Month(GLB_Fecha_Proceso) - 1) & "?", vbQuestion + vbYesNo)

If Respuesta = vbYes Then

     Call Interfaz_P36
Else
    Exit Sub
    
End If

End Sub

Private Sub Opcion_Menus_6700_Click()
    FRM_INTERFACES_SIGIR.Show
End Sub

Private Sub Opcion_Menus_6800_Click()
Dim Respuesta

    Respuesta = MsgBox("¿Desea generar interfaz C40?", vbQuestion + vbYesNo)
    
    If Respuesta = vbYes Then
         Call Interfaz_C40
    Else
        Exit Sub
    End If
    
End Sub


Private Sub Tmr_Mensaje_Timer()

    If Not FUNC_CARGA_PARAMETROS Then
       
       MsgBox "Error en la recuperación de datos de parámetros.", vbCritical
       End
    
    End If
    
    Call PROC_FORMATO_NUMERO_INF_BASICA
    
End Sub

Sub PROC_BUSCA_PRIVILEGIOS_USUARIO(forma_menu As Form, cEntidad As String)
    Dim nContador
    Dim vDatos_Retorno()

   If Trim(GLB_Usuario_Bac) = "ADMINISTRA" Then
      Call PROC_HABILITA_MENU
      Exit Sub
   End If

  GLB_Envia = Array()
  PROC_AGREGA_PARAMETRO GLB_Envia, "T"
  PROC_AGREGA_PARAMETRO GLB_Envia, cEntidad
  PROC_AGREGA_PARAMETRO GLB_Envia, GLB_Tipo_Usuario_Bac

   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_PRIVILEGIOS ", GLB_Envia) Then
   
       Exit Sub
   
   End If
   
   Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
   
      For nContador = 0 To forma_menu.Controls.Count - 1
      
          If TypeOf forma_menu.Controls(nContador) Is Menu Then
          
             If Trim(forma_menu.Controls(nContador).Name) = Trim(vDatos_Retorno(1)) Then
             
                forma_menu.Controls(nContador).Enabled = True
                
             End If
             
          End If
          
      Next nContador
   Loop

  GLB_Envia = Array()
  PROC_AGREGA_PARAMETRO GLB_Envia, "U"
  PROC_AGREGA_PARAMETRO GLB_Envia, cEntidad
  PROC_AGREGA_PARAMETRO GLB_Envia, GLB_Usuario_Bac

   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_PRIVILEGIOS ", GLB_Envia) Then
   
       Exit Sub
       
   End If
   
   Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
   
      For nContador = 0 To forma_menu.Controls.Count - 1
      
          If TypeOf forma_menu.Controls(nContador) Is Menu Then
          
             If Trim(forma_menu.Controls(nContador).Name) = Trim(vDatos_Retorno(1)) Then
             
                If vDatos_Retorno(2) = "N" Then
                
                   forma_menu.Controls(nContador).Enabled = False
                   
                Else
                
                   forma_menu.Controls(nContador).Enabled = True
                   
                End If
                
             End If
          End If
      Next nContador
   Loop


End Sub

Sub PROC_GUARDAR_REGISTRO(cNombre_APP As String, cSeccion As String, cLlave As String, vValor As String)
    'MODIFICADO POR ERBAQ :: 20041018
    '********************************
    Call PROC_SaveString(HKEY_CURRENT_USER, RUTA_REGISTRO + cSeccion, cLlave, vValor)
End Sub
Public Sub PROC_SaveString(Hkey As Long, sPath As String, sValue As String, sData As String)
    Dim lkeyhand As Long
    Dim lReturn  As Long
    'MODIFICADO POR ERBAQ :: 20041018
    '********************************
    lReturn = RegCreateKey(Hkey, sPath, lkeyhand)
    lReturn = RegSetValueEx(lkeyhand, sValue, 0, REG_SZ, ByVal sData, Len(sData))
    lReturn = RegCloseKey(lkeyhand)
End Sub
Private Sub PROC_Wallpaper()
Dim strError As String
    'AGREGADO POR ERBAQ :: 20041025
    '******************************
    With clsWall
        .TransparentColor = vbGreen
        .ExeName = App.Path & "\" & App.ExeName & ".exe"
        .RunningInIDE = PROC_RunningInIde
        .MDIForm = Me
        Call .CreateFormPicture(Me, 4, strError)
    End With
    
End Sub

Private Function PROC_RunningInIde() As Boolean
Dim sClassName As String
Dim nStrLen    As Long
    'AGREGADO POR ERBAQ :: 20041025
    '******************************
    sClassName = String$(260, vbNullChar)
    nStrLen = GetClassName(Me.hwnd, sClassName, Len(sClassName))
    If nStrLen Then sClassName = left$(sClassName, nStrLen)
    
    PROC_RunningInIde = (sClassName = "ThunderMDIForm")
  
End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            Call Opcion_Menu_3100_Click
        Case 3
            Call Opcion_Menu_3201_Click
        Case 5
            Call Opcion_Menu_3202_Click
        Case 7
            Call Opcion_Menu_3203_Click
        Case 9
            Call Opcion_Menu_3204_Click
        Case 11
            Call Opcion_Menu_3205_Click
        Case 13
            Call Opcion_Menu_3300_Click
    End Select
End Sub
