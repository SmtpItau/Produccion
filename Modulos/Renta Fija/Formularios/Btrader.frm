VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "crystl32.ocx"
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.MDIForm BacTrader 
   BackColor       =   &H8000000F&
   Caption         =   "BACTRADER"
   ClientHeight    =   9060
   ClientLeft      =   1560
   ClientTop       =   1950
   ClientWidth     =   16170
   Icon            =   "Btrader.frx":0000
   LinkTopic       =   "BacTrd"
   NegotiateToolbars=   0   'False
   Picture         =   "Btrader.frx":030A
   WhatsThisHelp   =   -1  'True
   WindowState     =   2  'Maximized
   Begin Threed.SSPanel PnlTools 
      Align           =   1  'Align Top
      Height          =   555
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   16170
      _Version        =   65536
      _ExtentX        =   28522
      _ExtentY        =   979
      _StockProps     =   15
      ForeColor       =   65280
      BackColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelWidth      =   2
      BorderWidth     =   0
      BevelInner      =   1
      RoundedCorners  =   0   'False
      Outline         =   -1  'True
      Begin VB.CommandButton BOpc_21810 
         Caption         =   "RIC"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   5520
         TabIndex        =   24
         Tag             =   "Recompra Captaciones"
         ToolTipText     =   "Recompra Captaciones"
         Top             =   90
         Width           =   525
      End
      Begin VB.CommandButton BOpc_21800 
         Caption         =   "CA"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   5040
         TabIndex        =   23
         Tag             =   "Captaciones"
         ToolTipText     =   "Captaciones"
         Top             =   90
         Width           =   405
      End
      Begin VB.Timer Tmrfecha 
         Left            =   10080
         Top             =   120
      End
      Begin VB.CommandButton BOpc_20450 
         Caption         =   "RP"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   4520
         TabIndex        =   22
         Top             =   90
         Width           =   405
      End
      Begin Crystal.CrystalReport bacrpts 
         Left            =   6480
         Top             =   105
         _ExtentX        =   741
         _ExtentY        =   741
         _Version        =   348160
         PrintFileLinesPerPage=   60
      End
      Begin VB.CommandButton BOpc_20750 
         BackColor       =   &H80000004&
         Caption         =   "FLI"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   3480
         TabIndex        =   21
         TabStop         =   0   'False
         Tag             =   "Facilidad de Liquidez Intradía"
         ToolTipText     =   "Facilidad de Liquidez Intradía"
         Top             =   90
         Width           =   465
      End
      Begin Crystal.CrystalReport bacrpt 
         Left            =   6960
         Top             =   120
         _ExtentX        =   741
         _ExtentY        =   741
         _Version        =   348160
         WindowControlBox=   -1  'True
         WindowMaxButton =   -1  'True
         WindowMinButton =   -1  'True
         PrintFileLinesPerPage=   60
      End
      Begin VB.CommandButton BOpc_20700 
         BackColor       =   &H80000004&
         Caption         =   "IB"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   3020
         TabIndex        =   19
         TabStop         =   0   'False
         Tag             =   "Interbancarios"
         ToolTipText     =   "Interbancarios"
         Top             =   90
         Width           =   405
      End
      Begin VB.CommandButton BOpc_21600 
         BackColor       =   &H80000004&
         Caption         =   "VA"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   4000
         TabIndex        =   15
         TabStop         =   0   'False
         Tag             =   "Valorizador"
         ToolTipText     =   "Valorizador"
         Top             =   90
         Width           =   405
      End
      Begin VB.CommandButton BOpc_20600 
         BackColor       =   &H80000004&
         Caption         =   "RV"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   2550
         TabIndex        =   14
         TabStop         =   0   'False
         Tag             =   "Reventa Anticipada"
         ToolTipText     =   "Reventa Anticipada"
         Top             =   90
         Width           =   405
      End
      Begin VB.CommandButton BOpc_20500 
         BackColor       =   &H80000004&
         Caption         =   "RC"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   2085
         TabIndex        =   13
         TabStop         =   0   'False
         Tag             =   "Recompra Anticipada"
         ToolTipText     =   "Recompra Anticipada"
         Top             =   90
         Width           =   405
      End
      Begin VB.CommandButton BOpc_20400 
         BackColor       =   &H80000004&
         Caption         =   "VI"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   1620
         TabIndex        =   12
         TabStop         =   0   'False
         Tag             =   "Venta con Pacto"
         ToolTipText     =   "Venta con Pacto"
         Top             =   90
         Width           =   405
      End
      Begin VB.CommandButton BOpc_20300 
         BackColor       =   &H80000004&
         Caption         =   "CI"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   1140
         TabIndex        =   11
         TabStop         =   0   'False
         Tag             =   "Compra con Pacto"
         ToolTipText     =   "Compra con Pacto"
         Top             =   90
         Width           =   405
      End
      Begin VB.CommandButton BOpc_20200 
         BackColor       =   &H80000004&
         Caption         =   "VP"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   645
         TabIndex        =   10
         TabStop         =   0   'False
         Tag             =   "Venta Definitiva"
         ToolTipText     =   "Venta Definitiva"
         Top             =   90
         Width           =   405
      End
      Begin VB.CommandButton BOpc_20100 
         BackColor       =   &H80000004&
         Caption         =   "CP"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   150
         TabIndex        =   9
         TabStop         =   0   'False
         Tag             =   "Compra Propia"
         ToolTipText     =   "Compra Definitiva"
         Top             =   90
         Width           =   405
      End
      Begin VB.Timer TmrMsg 
         Enabled         =   0   'False
         Left            =   10905
         Top             =   60
      End
      Begin VB.Label Label2 
         BackStyle       =   0  'Transparent
         Height          =   345
         Left            =   8430
         TabIndex        =   20
         Top             =   60
         Width           =   720
      End
   End
   Begin MSWinsockLib.Winsock NomObjWinIP 
      Left            =   960
      Top             =   2160
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin Threed.SSPanel PnlInfo 
      Align           =   2  'Align Bottom
      Height          =   420
      Left            =   0
      TabIndex        =   1
      Top             =   8640
      Width           =   16170
      _Version        =   65536
      _ExtentX        =   28522
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
         Height          =   330
         Left            =   45
         TabIndex        =   8
         Top             =   60
         Width           =   4695
         _Version        =   65536
         _ExtentX        =   8281
         _ExtentY        =   582
         _StockProps     =   15
         ForeColor       =   8388608
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
         BevelOuter      =   0
         BevelInner      =   1
         RoundedCorners  =   0   'False
         Alignment       =   1
         Begin VB.Label Label1 
            Caption         =   "Normal"
            ForeColor       =   &H00000000&
            Height          =   255
            Left            =   2760
            TabIndex        =   18
            Top             =   -15
            Visible         =   0   'False
            Width           =   15
         End
         Begin VB.Label Lbl_Selec 
            Caption         =   "Seleccion"
            ForeColor       =   &H00C00000&
            Height          =   255
            Left            =   2640
            TabIndex        =   17
            Top             =   15
            Visible         =   0   'False
            Width           =   15
         End
      End
      Begin Threed.SSPanel PnlMensaje 
         Height          =   360
         Left            =   4725
         TabIndex        =   4
         Top             =   30
         Width           =   1890
         _Version        =   65536
         _ExtentX        =   3334
         _ExtentY        =   635
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
         BevelOuter      =   0
         BevelInner      =   1
         RoundedCorners  =   0   'False
         Alignment       =   1
         Begin Threed.SSPanel Pnl_Usuario 
            Height          =   270
            Left            =   30
            TabIndex        =   6
            Top             =   45
            Width           =   1830
            _Version        =   65536
            _ExtentX        =   3228
            _ExtentY        =   476
            _StockProps     =   15
            ForeColor       =   16776960
            BackColor       =   0
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
         Height          =   330
         Left            =   6630
         TabIndex        =   3
         Top             =   60
         Width           =   1980
         _Version        =   65536
         _ExtentX        =   3493
         _ExtentY        =   582
         _StockProps     =   15
         ForeColor       =   8388608
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
         BevelOuter      =   0
         BevelInner      =   1
         RoundedCorners  =   0   'False
      End
      Begin Threed.SSPanel Pnl_Fecha 
         Height          =   330
         Left            =   10635
         TabIndex        =   2
         Top             =   60
         Width           =   1305
         _Version        =   65536
         _ExtentX        =   2302
         _ExtentY        =   582
         _StockProps     =   15
         ForeColor       =   8388608
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
         BevelOuter      =   0
         BevelInner      =   1
         RoundedCorners  =   0   'False
         Autosize        =   3
      End
      Begin Threed.SSPanel Pnl_DO 
         Height          =   330
         Left            =   8760
         TabIndex        =   16
         Top             =   60
         Width           =   1980
         _Version        =   65536
         _ExtentX        =   3493
         _ExtentY        =   582
         _StockProps     =   15
         ForeColor       =   8388608
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
         BevelOuter      =   0
         BevelInner      =   1
         RoundedCorners  =   0   'False
      End
   End
   Begin VB.Menu Opc_10000 
      Caption         =   "Inicio de día"
      Begin VB.Menu Opc_10100 
         Caption         =   "Parametros Diarios"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_10400 
         Caption         =   "Estado de Proceso"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_RecalculoDRV 
         Caption         =   "Recalculo Lineas DRV"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Opc_20000 
      Caption         =   "Operaciones"
      Begin VB.Menu Opc_20100 
         Caption         =   "Compras definitivas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20200 
         Caption         =   "Ventas definitivas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20300 
         Caption         =   "Compras con pacto"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20400 
         Caption         =   "Ventas con pacto"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20450 
         Caption         =   "REPOS"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20500 
         Caption         =   "Recompras anticipadas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20600 
         Caption         =   "Reventas anticipadas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20700 
         Caption         =   "Interbancarios"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20760 
         Caption         =   "Sorteo de Letras Hipotecarias"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20750 
         Caption         =   "Facilidad de Liquidez Intradía"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20900 
         Caption         =   "Modificación de operaciones"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_21600 
         Caption         =   "Valorizador"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_21604 
         Caption         =   "Vencimientos Cuotas Fondos Mutuos"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_21800 
         Caption         =   "Ingreso de Captaciones"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_21810 
         Caption         =   "Anticipo de Depósitos"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_21000 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_21100 
         Caption         =   "Anulación de operaciones "
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_21200 
         Caption         =   "Anulación de interbancarios"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_21900 
         Caption         =   "Anulacion Captaciones"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_21820 
         Caption         =   "Anulación Anticipo Recompra Depósitos"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_21300 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_21400 
         Caption         =   "Reimpresión de papeletas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_Volcker 
         Caption         =   "Volcker Rule"
         HelpContextID   =   1
         Begin VB.Menu Opc_Mod_Clas_Rule 
            Caption         =   "Modificar Clasificación"
            HelpContextID   =   2
         End
         Begin VB.Menu opc_Inf_VolckerRule 
            Caption         =   "Informe Volcker Rule"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Opc_21500 
         Caption         =   "Impresión de contratos"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_21502 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_80200 
         Caption         =   "Bloqueo Mesa Dinero"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_21503 
         Caption         =   "Bloqueo Permanente mesa dinero"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_30802 
         Caption         =   "Operaciones Pendientes de Aprobación"
         HelpContextID   =   1
      End
      Begin VB.Menu Separacion099 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_30898 
         Caption         =   "Ticket Intra Mesa"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_30899 
         Caption         =   "Consultas Ticket Intra Mesa"
         HelpContextID   =   1
      End
      Begin VB.Menu Separacion01 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_30803 
         Caption         =   "Reimpresión de Papeletas Históricas"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Opc_30000 
      Caption         =   "Custodia"
      Begin VB.Menu Opc_30100 
         Caption         =   "Actualización de Cortes"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_30200 
         Caption         =   "Actualización de Custodia"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Opc_40000 
      Caption         =   "Contabilidad"
      Begin VB.Menu Opc_40100 
         Caption         =   "Contabilización Automática"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_40103 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_40200 
         Caption         =   "Devengamiento"
         HelpContextID   =   1
      End
      Begin VB.Menu ss 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_40202 
         Caption         =   "Informe Operaciones Contabilizadas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_40205 
         Caption         =   "Informe de Voucher Consolidado"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_40204 
         Caption         =   "Interfaz Contable"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Opc_90000 
      Caption         =   "Interfaz"
      Begin VB.Menu Opc_90004 
         Caption         =   "Interfaz D31"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_9012 
         Caption         =   "Interfaz S.I.I."
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_9013 
         Caption         =   "Nueva Interfaz C08"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_9014 
         Caption         =   "Interfaz cartera"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_9015 
         Caption         =   "Interfaz flujos"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_9023 
         Caption         =   "Interfaz PV01"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_9025 
         Caption         =   "Generación de Sorteos Letras"
         HelpContextID   =   1
      End
      Begin VB.Menu opcD16 
         Caption         =   "Interfaz D16"
         HelpContextID   =   1
      End
      Begin VB.Menu opcD17 
         Caption         =   "Interfaz D17"
         HelpContextID   =   1
      End
      Begin VB.Menu GenArchivoTVM 
         Caption         =   "Generación Archivo TVM (Digital)"
         HelpContextID   =   1
      End
      Begin VB.Menu opcTarifadoMKPZ 
         Caption         =   "Interfaz Tarifado y MKPZ"
         HelpContextID   =   1
      End
      Begin VB.Menu opcCarteraFindur 
         Caption         =   "Interaz Cartera Findur Forward"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_linea9999 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_9026 
         Caption         =   "Envío de Operaciones al DCV"
         HelpContextID   =   1
      End
      Begin VB.Menu InterfazFormularioSIM03 
         Caption         =   "Interfaz Formulario SIM03"
      End
   End
   Begin VB.Menu Opc_50000 
      Caption         =   "Informes "
      Begin VB.Menu Opc_50100 
         Caption         =   "Movimientos"
         HelpContextID   =   1
         Begin VB.Menu Opc_50101 
            Caption         =   "Informes de Movimientos"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_50110 
            Caption         =   "Blotter"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_50120 
            Caption         =   "Circular 477"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_50109 
            Caption         =   "-"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_50111 
            Caption         =   "Vencimientos por Cliente"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_50112 
            Caption         =   "Vencimientos del día"
            HelpContextID   =   2
         End
         Begin VB.Menu Raya101 
            Caption         =   "-"
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu Raya106 
            Caption         =   "-"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_50115 
            Caption         =   "Informe OMA"
            HelpContextID   =   2
         End
         Begin VB.Menu Raya107 
            Caption         =   "-"
            HelpContextID   =   2
            Visible         =   0   'False
         End
      End
      Begin VB.Menu Opc_50200 
         Caption         =   "Carteras"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50250 
         Caption         =   "Cartera de Disponible"
         HelpContextID   =   1
         Begin VB.Menu Opc_900020 
            Caption         =   "Ordenado por plazo residual"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_900021 
            Caption         =   "Ordenado por Serie"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Opc_CartEsp 
         Caption         =   "Carteras Especiales"
         HelpContextID   =   1
         Begin VB.Menu Opc_StockCart 
            Caption         =   "Stock de Cartera"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_CartTirComp 
            Caption         =   "Cartera Tir de Compra"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_CartTot 
            Caption         =   "Cartera Total"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_CartTradCLP 
            Caption         =   "Cartera Trading CLP"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_CartLetraPropEm 
            Caption         =   "Cartera Letras Propia Emisión"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_CartTitHis 
            Caption         =   "Cartera a Tir Histórica"
            HelpContextID   =   2
            Begin VB.Menu Opc_ManTirHis 
               Caption         =   "Mantención de Tir Histórica"
               HelpContextID   =   3
            End
            Begin VB.Menu Opc_CartTitHis2 
               Caption         =   "Cartera a Tir Histórica"
               HelpContextID   =   3
            End
         End
         Begin VB.Menu Opc_CartTradUSD 
            Caption         =   "Cartera Trading USD"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Opc_50300 
         Caption         =   "Informe P17"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_503013 
         Caption         =   "Consulta De Operaciones Historicas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50400 
         Caption         =   "Informes de Vencimientos"
         HelpContextID   =   1
         Begin VB.Menu Opc_50401 
            Caption         =   "Vencimientos de Interbancarios"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_50402 
            Caption         =   "Vencimientos de Pactos"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_50403 
            Caption         =   "Vencimientos de Instrumentos"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Opc_50500 
         Caption         =   "Cartera de Elegibles"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50600 
         Caption         =   "Mensaje Ms 165"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50700 
         Caption         =   "Control Cta. Cte. BCCH"
         HelpContextID   =   1
      End
      Begin VB.Menu Raya108 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50701 
         Caption         =   "Informe de Operaciones a DCV"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50702 
         Caption         =   "Informe de Seguimiento a Op."
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50703 
         Caption         =   "Cartera con Resultados Reconocidos o AVR"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50704 
         Caption         =   "Informe Basilea Derivados"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50715 
         Caption         =   "Límites de Permanencia"
         HelpContextID   =   1
         Index           =   1
      End
      Begin VB.Menu Opc_50716 
         Caption         =   "Gestión de Carteras Trading de IRF"
         HelpContextID   =   1
         Begin VB.Menu Opc_50717 
            Caption         =   "Ventas Definitivas de IRF Cartera de Trading"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_50718 
            Caption         =   "Compras Definitivas de IRF Cartera de Trading"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_50719 
            Caption         =   "Disponibilidad y Holding Period de IRF Cartera Trading"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Opc_50705 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50706 
         Caption         =   "Informes de Ticket Intra Mesa"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50707 
         Caption         =   "Certificados de Pacto"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50708 
         Caption         =   "Visualizar Interfaces ITAU"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_OperExcedCtrlTasas 
         Caption         =   "Operaciones Excedidas Control de Tasas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_EventosCapital 
         Caption         =   "Informe Eventos de Capital"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Opc_60000 
      Caption         =   "Administración"
      Begin VB.Menu Opc_60100 
         Caption         =   "Seguridad"
         HelpContextID   =   1
         Begin VB.Menu Opc_60101 
            Caption         =   "Cambio de password"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_60102 
            Caption         =   "Desbloqueo de documentos"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_60103 
            Caption         =   "Control y Bloqueo de Usuarios"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_60105 
            Caption         =   "Modulo de Bloqueo para Pacto"
            HelpContextID   =   2
            Begin VB.Menu Opc_60106 
               Caption         =   "Generar Excel Cartera "
               HelpContextID   =   3
            End
            Begin VB.Menu Opc_60107 
               Caption         =   "Carga Bloqueo Pactos"
               HelpContextID   =   3
            End
         End
      End
      Begin VB.Menu Opc_60104 
         Caption         =   "Confirmación de Operaciones"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_6123_ 
         Caption         =   "Plazo Permanencia"
         Begin VB.Menu Opc_6123_pre_Per 
            Caption         =   "Pre Aprobacion Plazo de Permanencia"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_6123_apr_Per 
            Caption         =   "Aprobacion Plazo de Permanencia"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Opc_Mitigador 
         Caption         =   "Mantenedor Parametros Mitigacion"
         HelpContextID   =   1
      End
      Begin VB.Menu BloqueoClientes 
         Caption         =   "Bloqueo de Clientes"
      End
      Begin VB.Menu Bloqueo_Operaciones 
         Caption         =   "Bloqueo Operaciones"
      End
   End
   Begin VB.Menu Opc_70000 
      Caption         =   "Tasa de mercado"
      Begin VB.Menu Opc_70100 
         Caption         =   "S.B.I.F."
         HelpContextID   =   1
         Begin VB.Menu Opc_70101 
            Caption         =   "Carga automatica de factores"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_21602 
            Caption         =   "Captura Precio Cuotas Valorización Fondos Mutuos"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_70102 
            Caption         =   "Valorización S.B.I.F"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_70103 
            Caption         =   "Informes de Valorización"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_70104 
            Caption         =   "Mantencion de Curvas"
            HelpContextID   =   2
         End
      End
   End
   Begin VB.Menu Opc_110000 
      Caption         =   "Reserva tecnica"
      Begin VB.Menu Opc_110001 
         Caption         =   "Otras Operaciones a Incluir"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_110002 
         Caption         =   "Información General"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_110003 
         Caption         =   "Selección de Reserva Técnica"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_110004 
         Caption         =   "Informes de Reserva Técnica"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Opc_80000 
      Caption         =   "Fin de día"
      Begin VB.Menu Opc_80100 
         Caption         =   "Proceso de fin de día"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Migrados 
      Caption         =   "Reportes Migrados"
      Begin VB.Menu Mig001 
         Caption         =   "Reporte Dinamico Operaciones Moneda Nacional"
      End
      Begin VB.Menu Mig002 
         Caption         =   "Reporte Dinamico Operaciones Moneda Extranjera"
      End
   End
   Begin VB.Menu Opc_Salir 
      Caption         =   "Salir"
   End
End
Attribute VB_Name = "BacTrader"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Declare Function GetDeviceCaps Lib "gdi32" (ByVal hdc As Long, ByVal nIndex As Long) As Long
Dim SW As Integer
Dim objCierreMesa As Object
Dim Comando$


Sub DESHABILITA_MENU()
   'Habilita todas los ítemes del menú
   On Error Resume Next
   Dim i%
   For i% = 0 To Me.Controls.Count - 1
      If TypeOf Me.Controls(i%) Is Menu Then
         If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" And Me.Controls(i%).Caption <> "Salir" And Me.Controls(i%).Caption <> "Salir del Sistema" Then
            Me.Controls(i%).Visible = False
         End If
      End If
      If TypeOf Me.Controls(i%) Is CommandButton Then
         Me.Controls(i%).Enabled = False
      End If

    Next i%
End Sub

Sub MENU_TODOHABILITADO()
   'Habilita todas los ítemes del menú
   Dim i%
   On Error Resume Next
   For i% = 0 To Me.Controls.Count - 1
      If TypeOf Me.Controls(i%) Is Menu Then
         If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" And Me.Controls(i%).Caption <> "Salir" And Me.Controls(i%).Caption <> "Salir del Sistema" Then
            Me.Controls(i%).Visible = True
         End If
      End If
      If TypeOf Me.Controls(i%) Is CommandButton Then
         Me.Controls(i%).Enabled = True
      End If

    Next i%
End Sub

Sub PROC_CARGA_PRIVILEGIOS()
    Dim Datos()
    Dim i%
    Dim Comando As String

'If Trim(gsBac_User) = "ADMINISTRA" Then
    Call MENU_TODOHABILITADO
    Exit Sub
'End If

Envia = Array()
AddParam Envia, "T"
AddParam Envia, "BTR"
AddParam Envia, gsBac_Tipo_Usuario

If Not Bac_Sql_Execute("SP_BUSCA_PRIVILEGIOS", Envia) Then
   Exit Sub
End If

' BUSCA LAS OPCIONES POR TIPO DE USUARIO
Do While Bac_SQL_Fetch(Datos)
   On Error Resume Next
   For i% = 0 To Me.Controls.Count - 1
      If TypeOf Me.Controls(i%) Is Menu Then
         If Trim(Me.Controls(i%).Name) = Trim(Datos(1)) Then
            Me.Controls(i%).Visible = True
         End If
       End If
       If TypeOf Me.Controls(i%) Is CommandButton Then
         If Trim(Me.Controls(i%).Name) = "B" + Trim(Datos(1)) Then
            Me.Controls(i%).Enabled = True
         End If
       End If
   Next i%
Loop

' BUSCA LAS OPCIONES POR USUARIO

Envia = Array()
AddParam Envia, "U"
AddParam Envia, "BTR"
AddParam Envia, gsBac_User

If Not Bac_Sql_Execute("SP_BUSCA_PRIVILEGIOS", Envia) Then
   Exit Sub
End If

' BUSCA LAS OPCIONES DEL USUARIO Y LAS HABILITA
Do While Bac_SQL_Fetch(Datos)
   On Error Resume Next
   For i% = 0 To Me.Controls.Count - 1
       If TypeOf Me.Controls(i%) Is Menu Then
          If Trim(Me.Controls(i%).Name) = Trim(Datos(1)) Then
            Me.Controls(i%).Visible = IIf(Mid(Datos(2), 1, 1) = "N", False, True)
         End If
       End If
       If TypeOf Me.Controls(i%) Is CommandButton Then
          If Trim(Me.Controls(i%).Name) = "B" + Trim(Datos(1)) Then
            Me.Controls(i%).Enabled = IIf(Mid(Datos(2), 1, 1) = "N", False, True)
         End If
      End If
   Next i%
Loop
End Sub






Private Sub Imp_Vales_Click()
    ''BacValeVista.Show
End Sub

Private Sub Bloqueo_Operaciones_Click()
BacBloqueo_Operaciones.Show
End Sub

Private Sub BloqueoClientes_Click()
    FRM_BloqueoCLI.Show
End Sub

Private Sub BOpc_20450_Click()
    Opc_20450_Click
End Sub

Private Sub BOpc_20750_Click()
        Opc_20750_Click
End Sub

Private Sub Command1_Click()
  Frm_Vtas_con_Pcto.Show 'Borrar Prd-6006
End Sub

Private Sub GenArchivoTVM_Click()
       frmGenArchivoTVM.Show
End Sub


Private Sub InterfazFormularioSIM03_Click()
  Interfaz.Interfaz = "SIM03"
  Interfaz.Show
End Sub

Private Sub MDIForm_Activate()
   SW = 1
   Screen.MousePointer = vbDefault
   BacTrader.Caption = "Bac Trader 7.2 ( Sql Server ) " + UCase(gsSQL_Server) '+ "/" + UCase(gsSQL_Database)

   If Not gbBac_Login Then
      If Not Proc_Carga_Parametros Then
         MsgBox "Error en la recuperación de datos de parámetros.", vbCritical, TITSISTEMA & " - Parámetros"
         End
      End If
      
      Call DESHABILITA_MENU
    '+++cvegasan 2017.06.05 HOM Ex-Itau funciones de ventana de login
    If giSQL_ConnectionMode <> 3 Then
    '---cvegasan 2017.06.05 HOM Ex-Itau funciones de ventana de login
        Acceso_Usuario.Show vbModal
    '+++cvegasan 2017.06.05 HOM Ex-Itau funciones de ventana de login
        Else
            If Func_Valida_Login(gsBac_User) = False Then End
        End If
    '---cvegasan 2017.06.05 HOM Ex-Itau funciones de ventana de login
      If gbBac_Login Then
         Screen.MousePointer = vbHourglass
         PROC_CARGA_PRIVILEGIOS
         TmrMsg.Enabled = True
      Else
         Unload Me
         Exit Sub
      End If
      
       '+++cvegasan 2017.06.05 HOM Ex-Itau
        Call GRABA_LOG_AUDITORIA("1", _
                                    Format(gsBac_Fecp, "YYYYMMDD"), _
                                    gsBac_IP, _
                                    gsBac_User, _
                                    "BTR", _
                                    "", _
                                    "05", _
                                    "Ingreso al Sistema", _
                                    "", _
                                    "", _
                                    "")
        '---cvegasan 2017.06.05 HOM Ex-Itau
      Pnl_Usuario.Caption = gsBac_User$
   End If
        
   Pnl_Entidad.Caption = Mid$(gsBac_Clien, 1, 30)
   gsBac_Tcamara = 0
   Screen.MousePointer = vbDefault
   
   
End Sub

Sub PROC_GENERA_MENU(Entidad As String)
    Dim indice          As Integer: indice = 1
    Dim Primera_Vez     As String: Primera_Vez = "S"
    Dim i%

   For i% = 0 To Me.Controls.Count - 1
        If TypeOf Me.Controls(i%) Is Menu Then
            If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" And Me.Controls(i%).Visible And Me.Controls(i%).Caption <> "Salir" Then
                
                Envia = Array(Primera_Vez, _
                              Entidad, _
                              CDbl(indice), _
                              Me.Controls(i%).Caption, _
                              Me.Controls(i%).Name, _
                              Format(Me.Controls(i%).HelpContextID, "0"))
                
                indice = indice + 1
                If Not Bac_Sql_Execute("SP_CARGA_GEN_MENU", Envia) Then
                    Exit Sub
                End If
                Primera_Vez = "N"
                
            End If
        End If
    Next i%

End Sub


Private Function BAC_Login(sUser$, sPWD$) As Boolean
   
'      BAC_Login = False
'
'      If giSQL_ConnectionMode = 1 Then
'         SQL_Setup gsSQL_Server$, gsSQL_Login$, gsSQL_Password$, gsSQL_Database, gsBac_User, gsBac_Term, giSQL_LoginTimeOut, giSQL_QueryTimeOut
'      Else
'         SQL_Setup gsSQL_Server$, sUser$, sPWD$, gsSQL_Database, gsBac_User, gsBac_Term, giSQL_LoginTimeOut, giSQL_QueryTimeOut
'      End If
'
'      If miSQL.SQL_Coneccion() = False Then
'         Exit Function
'      End If
'
'      BAC_Login = True

   BAC_Login = False
'+++cvegasan 2017.06.05 HOM Ex-Itau
   If giSQL_ConnectionMode = 3 Then
        gsBac_User = UCase(Trim(Environ("username")))
        gsBac_Term = Trim(Environ("userdomain"))
        miSQL.Login = gsBac_User
   End If
'---cvegasan 2017.06.05 HOM Ex-Itau
 
   miSQL.ServerName = gsSQL_Server$
   miSQL.Hostname = gsBac_Term
   miSQL.Application = "RENTA FIJA"
   miSQL.ConnectionMode = giSQL_ConnectionMode
   miSQL.DatabaseName = gsSQL_Database
   gsBac_IP = BacTrader.NomObjWinIP.LocalIP
 
   If giSQL_ConnectionMode = 1 Then
      miSQL.Login = gsSQL_Login$
      miSQL.Password = gsSQL_Password$
        gsBac_User = UCase(Trim(Environ("username")))
        gsBac_Term = Trim(Environ("ComputerName"))
   ElseIf giSQL_ConnectionMode = 2 Then
      miSQL.Login = sUser$
      miSQL.Password = sPWD$
 
   End If
 
'   If giSQL_ConnectionMode = 1 Then
'      miSQL.Login = gsSQL_Login$
'      miSQL.Password = gsSQL_Password$
'
'   ElseIf giSQL_ConnectionMode = 2 Then
'      miSQL.Login = sUser$
'      miSQL.Password = sPWD$
'
'   End If
 

   miSQL.LoginTimeout = giSQL_LoginTimeOut
   miSQL.QueryTimeout = giSQL_QueryTimeOut
 
   If miSQL.SQL_Coneccion() = False Then
       BAC_Login = False
       Exit Function

   End If

    BAC_Login = True
 

End Function


Private Sub MDIForm_Load()

   Dim hModule As Integer
   Dim numcargas As Integer
 
   Screen.MousePointer = vbHourglass
   
   'Call DetectarResolucion(Me, Form1)
   
   If App.PrevInstance Then
      Screen.MousePointer = vbDefault
      MsgBox "Sistema está cargado en memoria.", vbExclamation, TITSISTEMA
      End
   End If
   
   If Not Valida_Configuracion_Regional() Then
      Screen.MousePointer = vbDefault
      MsgBox "Debe cambiar el formato de fecha como dd/mm/aaaa antes de ejecutar el sistema.", vbCritical, TITSISTEMA
      End
   End If

   If Not BacInit Then ' Parametros de Inicio.-
      Screen.MousePointer = vbDefault
      End
   End If
    
   Tmrfecha.Enabled = True
   Tmrfecha.Interval = gsBac_Timer
       
'    App.Path & "\Bac-Sistemas.INI"
gsSQL_Login = Func_Read_INI("usuario", "usuario", App.Path & "\Bac-Sistemas.INI")
gsSQL_Password = Func_Read_INI("usuario", "password", App.Path & "\Bac-Sistemas.INI")
CONECCION = "DSN=SQL_BACTRADER;UID="
CONECCION = CONECCION & gsSQL_Login
CONECCION = CONECCION & ";PWD="
CONECCION = CONECCION & gsSQL_Password
CONECCION = CONECCION & ";DSQ=BACTRADERsuda"
   
   If Not BAC_Login(gsSQL_Login, gsSQL_Password) Then
      Screen.MousePointer = vbDefault
      MsgBox "Problemas de Comunicación con el Servidor SQL", vbCritical, TITSISTEMA
      End
   End If
   
   Screen.MousePointer = vbDefault
   
   If Mid(Command, 1, 11) = "GENERA_MENU" Then
      PROC_GENERA_MENU "BTR"
      Call miSQL.SQL_Close
      Screen.MousePointer = vbDefault
      End
   End If
   
   
    If Dir("C:\EJECUCION.TXT") <> "" Then
        Kill "C:\EJECUCION.TXT"
    End If


   Screen.MousePointer = vbDefault

End Sub


Function Valida_Configuracion_Regional() As Boolean
    Valida_Configuracion_Regional = False
    If CStr(Format(CDate("31/12/2000"), feFECHA)) <> Format("31/12/2000", feFECHA) Then
       Exit Function
    End If
    Valida_Configuracion_Regional = True
End Function


Private Sub MDIForm_MouseDown(Button As Integer, Shift As Integer, X As Single, y As Single)

   If Button = 2 Then
   
      PopupMenu Opc_20000
   
   End If

End Sub

Private Sub MDIForm_Unload(Cancel As Integer)

    If MsgBox("¿Esta seguro que desea salir de BacTrader?", vbYesNo + vbQuestion) = vbNo Then
        Cancel = 1
        Exit Sub
    End If

    Salida_Usuario

    If Bloquea_Usuario(False, gsBac_User$) Then
        Dim xLogCs As Integer
        miSQL.SQL_Close
        End
    End If

End Sub

 

Private Sub Mig001_Click()
    Call FRMRepDinamicos.Show
End Sub

Private Sub Mig002_Click()
    Call FRMReporteDinamicoMX.Show

End Sub

''Private Sub Opc_100003_Click()
'''BacTm_Informes.Show
''End Sub




''Private Sub Opc_100004_Click()
''BacTm_mntrangos.Show
''End Sub

''Private Sub Opc_100005_Click()
''BacTm_mnttasas.Show
''End Sub

''Private Sub Opc_100006_Click()
''BacTm_Traspaso.Show
''End Sub

''Private Sub Opc_100007_Click()
''BacTm_TraspasoVtaAut.Show
''End Sub

Private Sub Opc_10100_Click()
' ============================================= '
' Opción de Inicio de dia Parametros diarios
' ============================================= '
        BacIniDia.Show vbNormal
End Sub


Private Sub Opc_10200_Click()
' ============================================= '
' Opción de Inicio de dia Recompras / Reventas
' ============================================= '
    If Chequea_ControlProcesos("RC") Then
        BacReproceso.Show vbNormal
    End If
    
End Sub


Private Sub Opc_10300_Click()
' ============================================= '
' Opción de Inicio de dia Vencimiento de Captaciones
' ============================================= '
'       Pago_captaciones.Show vbNormal

End Sub

Private Sub Opc_10400_Click()
    'BacReproceso.Show
    EstadoProceso.Show
End Sub

 

Private Sub Opc_110001_Click()
rtecnica_mextranjera.Show
End Sub

Private Sub Opc_110002_Click()
    rtecnica_parametros.Show
End Sub

Private Sub Opc_110003_Click()
    rtecnica_seleccion.Show
End Sub

Private Sub Opc_110004_Click()
  RTecnica_Informes.Show
End Sub

Private Sub Opc_20100_Click()
' ============================================= '
' Opción de Operaciones Compras Propias
' ============================================= '
Tipo_Operacion = "CP"
    If Chequea_ControlProcesos("OP") Then
        BacIrfNueVentana "CP"
    End If
End Sub


Private Sub Opc_20200_Click()
' ============================================= '
' Opción de Operaciones Ventas definitivas
' ============================================= '
Tipo_Operacion = "VP"
    If Chequea_ControlProcesos("OP") Then
        BacIrfNueVentana "VP"
    End If
    
End Sub


Private Sub Opc_20300_Click()
' ============================================= '
' Opción de Operaciones Compras con Pacto
' ============================================= '
Tipo_Operacion = "CI"
    If Chequea_ControlProcesos("OP") Then
        BacIrfNueVentana "CI"
    End If
    
End Sub


Private Sub Opc_20400_Click()
' ============================================= '
' Opción de Operaciones Ventas con pacto
' ============================================= '
Tipo_Operacion = "VI"
    If Chequea_ControlProcesos("OP") Then
        BacIrfNueVentana "VI"
    End If
    
End Sub


Private Sub Opc_20450_Click()
    ' ============================================= '
    ' Opción de Operaciones REPOS
    ' ============================================= '
    Tipo_Operacion = "REP"
    If Chequea_ControlProcesos("OP") Then
        BacIrfNueVentana "REP"
    End If

End Sub

Private Sub Opc_20500_Click()
' ============================================= '
' Opción de Operaciones Recompras anticipadas
' ============================================= '

    If Chequea_ControlProcesos("OP") Then
        BacIrfNueVentana "RC"
    End If
    
End Sub


Private Sub Opc_20600_Click()
' ============================================= '
' Opción de Operaciones Reventas anticipadas
' ============================================= '
    If Chequea_ControlProcesos("OP") Then
        BacIrfNueVentana "RV"
    End If
    
End Sub


Private Sub Opc_20700_Click()
' ============================================= '
' Opción de Operaciones Interbancarios
' ============================================= '
    If Chequea_ControlProcesos("OP") Then
        BacInter.Show vbNormal
    End If

End Sub


Private Sub Opc_20800_Click()
' ============================================= '
' Opción de Operaciones Sorteo de Letras
' ============================================= '
Tipo_Operacion = "ST"
    If Chequear_MesaIng() Then
        BacIrfNueVentana "ST"
    End If

End Sub


Private Sub Opc_20750_Click()
    ' ============================================= '
    ' Opción de Operaciones FLI
    ' ============================================= '
    Tipo_Operacion = "FLI"
    If Chequea_ControlProcesos("OP") Then
        BacIrfNueVentana "FLI"
    End If

End Sub

Private Sub Opc_20760_Click()
   ' ============================================= '
   ' Opción de Operaciones Sorteo de Letras Hipotecarias
   ' ============================================= '
    Tipo_Operacion = "ST"
    If Chequea_ControlProcesos("OP") Then
        BacIrfNueVentana "ST"
    End If

End Sub

Private Sub Opc_20900_Click()
' ============================================= '
' Opción de Operaciones Modificación de operaciones
' ============================================= '
    If Chequea_ControlProcesos("OP") Then
        BacModOpe.Show
    End If

End Sub


Private Sub Opc_21100_Click()
' ============================================= '
' Opción de Operaciones Anulacion de operaciones
' ============================================= '
    If Chequea_ControlProcesos("OP") Then
        BacIrfAn.Show vbNormal
    End If

End Sub


Private Sub Opc_21200_Click()
' ============================================= '
' Opción de Operaciones Anulacion de Interbancarios
' ============================================= '
    If Chequea_ControlProcesos("OP") Then
        BacAnulaInter.pareTipOper = "INT"
        BacAnulaInter.Show vbNormal
    End If

End Sub


Private Sub Opc_21400_Click()
' ============================================= '
' Opción de Operaciones Reimpresión de papeletas
' ============================================= '
    If Chequea_ControlProcesos("OP") Then
        BacPapeleta.proTipo = "DIA"
        BacPapeleta.Show vbNormal
    End If

End Sub


Private Sub Opc_21500_Click()
' ============================================= '
' Opción de Operaciones Reimpresión de Contratos
' ============================================= '
    If Chequea_ControlProcesos("OP") Then
        BacContrato.Show 0 'vbNormal%
    End If

End Sub



Private Sub Opc_21504_Click()

    If Chequea_ControlProcesos("OP") Then
        BacIrfNueVentana "CU"
    End If

End Sub

Private Sub Opc_21520_Click()
    Dim TitRpt As String
    
    frmCerVp.Show vbModal
      
    Call Limpiar_Cristal
    TitRpt = "CERTIFICADO DE VENTA DEFINITIVA DE VALORES "
    BacTrader.bacrpt.Destination = 0
    BacTrader.bacrpt.ReportFileName = RptList_Path & "Certvp.rpt"
    BacTrader.bacrpt.StoredProcParam(0) = xCodigo
    BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Action = 1
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
 
End Sub


Private Sub Opc_21503_Click()
Dim Lee_Mesa As Boolean
Dim CieMesa As String
Dim cgv As Long
'Revisar si hay Garantías Constituídas Vencidas - PRD-5521
cgv = CantidadGtiasVencidas("C")
If cgv = -1 Then
    MsgBox "Error, no es posible leer la cantidad de garantías vencidas!", vbExclamation, TITSISTEMA
    Exit Sub
End If
If cgv > 0 Then
    MsgBox "No es posible cerrar la mesa, hay " & Trim(CStr(cgv)) & " garantías vencidas que no han sido eliminadas!", vbExclamation, TITSISTEMA
    Exit Sub
End If

Lee_Mesa = Bac_Sql_Execute("SP_CONTROLCIERREMESA")
   Dim Datos()
      If Lee_Mesa Then
      
         If Bac_SQL_Fetch(Datos()) Then
         
            CieMesa = Left(Datos(1), 1)
            If CieMesa = "1" Then
               MsgBox "no puede desbloquear la mesa", vbDefaultButton1
               
               Exit Sub
            
            End If
         End If

End If
If Chequea_ControlProcesos("CM") Then

FrmBloqueaMesa.Show

End If
End Sub

Private Sub Opc_21600_Click()

    BacValIRF.Show vbNormal

End Sub

Private Sub Opc_21700_Click()
    'BACFLUCAJ.Show 0
End Sub

Private Sub Opc_21810_Click()
    ' ============================================= '
    ' Opción de Anticipos de Captaciones DAP
    ' ============================================= '
    If Chequea_ControlProcesos("OP") Then
       recompras_anticipadas_captaciones.Show vbNormal
    End If
End Sub

Private Sub Opc_21820_Click()
    ' ============================================= '
    ' Opción de Anulación Anticipos de Captaciones DAP
    ' ============================================= '
    If Chequea_ControlProcesos("OP") Then
       recompras_anticipadas_captaciones_Anulacion.Show vbNormal
    End If
End Sub


Private Sub Opc_21800_Click()
' ============================================= '
' Opción de Operaciones Captaciones
' ============================================= '
    If Chequea_ControlProcesos("OP") Then
       Ingreso_captaciones.Show vbNormal
    End If
End Sub


Private Sub Opc_21900_Click()
' ============================================= '
' Opción de Operaciones Anulacion de Captaciones
' ============================================= '
    If Chequea_ControlProcesos("OP") Then
        BacAnulaInter.pareTipOper = "CAP"
        BacAnulaInter.Show vbNormal
    End If
    
End Sub

Private Sub Opc_22000_Click()
'    Anticipo_Captaciones.Show
End Sub


Private Sub Opc_24000_Click()
' ================================================= '
' Opción de Custodía Time Deposit e Interbancarios
' ================================================= '
    If Chequea_ControlProcesos("OP") Then
'        BacTimeDeposit.Show
    End If
End Sub

Private Sub Opc_24001_Click()

' ============================================= '
' Opción de Operaciones Compras Propias (DPX)
' ============================================= '
    If Chequea_ControlProcesos("OP") Then
        BacIrfNueVentana "CU"
    End If

End Sub


Private Sub Opc_24002_Click()

' ============================================= '
' Opción de Operaciones Ventas definitivas (DPX)
' ============================================= '
    If Chequea_ControlProcesos("OP") Then
        BacIrfNueVentana "VU"
    End If

End Sub

Private Sub Opc_21602_Click()

     FMUT_Arch_Cuo.Show vbNormal

End Sub

Private Sub Opc_21604_Click()
     FMUT_Venc_Cuo.Show vbNormal
End Sub

Private Sub Opc_30100_Click()
' ============================================= '
' Opción de Custodía Mantenedor de cortes
' ============================================= '
    If Chequea_ControlProcesos("OP") Then
        BacMntco.Show vbNormal
    End If
End Sub

Private Sub Opc_30200_Click()
' ============================================= '
' Opción de Custodía Mantencón de papeles en DCV
' ============================================= '
    If Chequea_ControlProcesos("OP") Then
        BacDCV.Show vbNormal
    End If
End Sub


Private Sub Opc_30300_Click()
'    If Chequea_ControlProcesos("OP") Then
'        Custodia.Show
'    End If
End Sub

Private Sub Opc_30400_Click()
    'Consulta_Custodia.Show
End Sub


Private Sub Opc_30500_Click()

   'FrmLetrasHipotecarias.Show

End Sub

Private Sub Opc_30600_Click()

'   FlujoInterbancarios.Show

End Sub

Private Sub Opc_30700_Click()
   
   'FlujoContableInstrumento.Show

End Sub

Private Sub opc_30800_Click()
    
    'BacManPVenc.Show
    
End Sub

Private Sub Opc_40099_Click()
   Analisis_voucher.Show
End Sub

'''agreagar a menu cuando sea solicitado con
''' caption = Ingreso de paivos
''' name = opc_30801
''Private Sub opc_30801_Click()
''BacCPP.Show
''End Sub

Private Sub opc_30802_Click()
BacEstOp.Show
End Sub

Private Sub opc_30803_Click()
    FRM_PAPELTAS_HISTORICAS.Show
End Sub

Private Sub opc_30898_Click()
    Frm_TicketIntramesa.Show
End Sub

Private Sub opc_30899_Click()
    BacConsOpIM.Show
End Sub

Private Sub Opc_40100_Click()
    If Chequear_MesaBLQ() Then
        If Chequear_OpePenLineas() Then
           Contabilizacion_Automatica.Show vbNormal
        End If
    End If
End Sub
Private Sub Opc_40101_Click()
' ============================================= '
' Opción de Contabilidad, Generación Interfaz
' ============================================= '
    If Chequear_MesaBLQ() Then
       Traspaso_Contab.Show vbNormal
    End If
End Sub
Private Sub Opc_40104_Click()
'    Screen.MousePointer = vbHourglass
'    Perfil_contable.Show vbNormal
End Sub
Private Sub Opc_40105_Click()
    If Chequear_MesaBLQ() Then
        Traspaso_SBIF.parTipoOpcion = "ORI"
        Traspaso_SBIF.Show vbNormal
    End If
End Sub
Private Sub Opc_40200_Click()
' ============================================= '
' Opción de Contabilidad Devengamiento
' ============================================= '
    If Chequea_ControlProcesos("DV") Then
        Bac_Te.Show vbNormal
    End If
End Sub
Private Sub Opc_40202_Click()
infvoucher.Show
End Sub

'''Private Sub Opc_40203_Click()
'''    If Chequea_ControlProcesos("RENT") Then
'''        gsRUN_Proceso = "RENT"
'''        BacProc.Show vbNormal
'''    End If
'''End Sub




Private Sub Opc_40204_Click()

  Interfaz.Interfaz = "CONTABLE"
  Interfaz.Show
End Sub
Private Sub Opc_40205_Click()
   Dim TitRpt As String
   Screen.MousePointer = vbHourglass
    Call Limpiar_Cristal
   'TitRpt = "INFORME OPERACIONES CONTABILIZADAS"
   BacTrader.bacrpt.Destination = 0
   BacTrader.bacrpt.Connect = CONECCION
   BacTrader.bacrpt.ReportFileName = RptList_Path & "INFCUENTAS.RPT"
   'BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
   BacTrader.bacrpt.Action = 1

   Screen.MousePointer = vbDefault

End Sub

Private Sub Opc_40206_Click()
informe_perfiles.Show
End Sub

'Private Sub Opc_50100_Click()
'' ============================================= '
'' Opción de Contabilidad Devengamiento
'' ============================================= '
'
'End Sub

Private Sub Opc_50101_Click()
    Cartera = True
    'BacInformeMov.Lbl_index.Caption = 5100
    BacInformeMov.Show
End Sub


Private Sub Opc_50103_Click()
' ============================================= '
' Opción de informes de movimientos de compras con pacto
' ============================================= '
    Cartera = False
    Impresion_Entidades ("CI")
    
End Sub


Private Sub Opc_50104_Click()
' ============================================= '
' Opción de informes de movimientos de ventas con pacto
' ============================================= '
    Cartera = False
    Impresion_Entidades ("VI")
    
End Sub


Private Sub Opc_50105_Click()
' ============================================= '
' Opción de informes de movimientos de recompras
' ============================================= '
    Cartera = False
    Impresion_Entidades ("RC")
    
End Sub


Private Sub Opc_50106_Click()
' ============================================= '
' Opción de informes de movimientos de reventas
' ============================================= '
    Cartera = False
    Impresion_Entidades ("RV")
End Sub


Private Sub Opc_50107_Click()
' ============================================= '
' Opción de informes de movimientos de interbancarios
' ============================================= '
    Cartera = False
    Impresion_Entidades ("IB")
    
End Sub


Private Sub Opc_50108_Click()
' ============================================= '
' Opción de informes de movimientos de anulaciones
' ============================================= '
    Cartera = True
    Impresion_Entidades ("AN")
    
End Sub


Private Sub Opc_50109_Click()
' ============================================= '
' Opción de Contabilidad Devengamiento
' ============================================= '

End Sub


Private Sub Opc_50110_Click()
' ============================================= '
' Opción de informes de movimientos de Captaciones
' ============================================= '
    'Cartera = False
    'Impresion_Entidades ("ICD")
     Dim TitRpt As String
   Screen.MousePointer = vbHourglass
   Call Limpiar_Cristal
   'TitRpt = "INFORME OPERACIONES CONTABILIZADAS"
   BacTrader.bacrpt.Destination = 0
   BacTrader.bacrpt.Connect = CONECCION
   BacTrader.bacrpt.ReportFileName = RptList_Path & "INFOPER.RPT"
   'BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
   BacTrader.bacrpt.Action = 1

   Screen.MousePointer = vbDefault
End Sub


Private Sub Opc_50111_Click()
' ============================================= '
' Opción de informes de movimientos de reventas por clientes
' ============================================= '
'   Impresion_Entidades ("RVC")
    
    Call Limpiar_Cristal

    
    BacTrader.bacrpt.Destination = 0
    BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTRCRV.RPT"
    BacTrader.bacrpt.StoredProcParam(0) = "RC"
    BacTrader.bacrpt.StoredProcParam(1) = 0
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Action = 1
    
    BacTrader.bacrpt.Destination = 0
    BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTRCRV.RPT"
    BacTrader.bacrpt.StoredProcParam(0) = "RV"
    BacTrader.bacrpt.StoredProcParam(1) = 0
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Action = 1
    
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión de informe de reporte de reventas por cliente")

    
End Sub


Private Sub Opc_50112_Click()
' ============================================= '
' Opción de informes de movimientos Vencimientos del día
' ============================================= '
    Cartera = False
    BacFechas.Tag = "VCTODIA"
    BacFechas.Caption = "Seleccione vencimiento a Imprimir"
    BacFechas.Show

End Sub


Private Sub Opc_50114_Click()
    Dim TitRpt As String
    
    EstadoCuenta.proOrigen = "ESTCTA"
    EstadoCuenta.Show 1

    If giAceptar% = True Then
         Call Limpiar_Cristal
         TitRpt = "INFORME DE ESTADOS DE CUENTA DE CLIENTES "
         BacTrader.bacrpt.Destination = 0
         BacTrader.bacrpt.ReportFileName = RptList_Path & "ECUENTA.rpt"
         BacTrader.bacrpt.StoredProcParam(0) = "'" & xRut & "'"
         BacTrader.bacrpt.StoredProcParam(1) = xCodigo
         BacTrader.bacrpt.Formulas(0) = "Tit='" & TitRpt & "'"
         BacTrader.bacrpt.Connect = CONECCION
         BacTrader.bacrpt.Action = 1
         Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
         giAceptar% = False
    End If
End Sub
Private Sub Opc_50115_Click()
   Cartera = False
   BacInfOma.Show
End Sub

Private Sub Opc_50116_Click()
On Error GoTo err
    Cartera = False
    Call Limpiar_Cristal
            
    BacTrader.bacrpt.Destination = 0
    BacTrader.bacrpt.ReportFileName = RptList_Path & "OPESIS.RPT"
    BacTrader.bacrpt.StoredProcParam(0) = Format(gsBac_Fecp, "yyyymmdd")
    BacTrader.bacrpt.StoredProcParam(1) = "BLOTTER  DEL ( " & CStr(gsBac_Fecp) & "  RENTA  FIJA )"
    BacTrader.bacrpt.WindowTitle = "BLOTTER  DEL (" & CStr(gsBac_Fecp) & "  RENTA  FIJA)"
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Action = 1
Exit Sub
err:
    MsgBox err.Description, vbCritical
End Sub

Private Sub Opc_50201_Click()
    Cartera = True
    BacInfCarteras.Lbl_index.Caption = 5100
    BacInfCarteras.Show
End Sub

Private Sub Opc_50202_Click()
    Cartera = True
    BacInfCarteras.Lbl_index.Caption = 5101
    BacInfCarteras.Show
End Sub

Private Sub Opc_50203_Click()
    Cartera = False
    BacInfCarteras.Lbl_index.Caption = 5102
    BacInfCarteras.Show
End Sub

Private Sub Opc_50204_Click()
    Cartera = False
    BacInfCarteras.Lbl_index.Caption = 5103
    BacInfCarteras.Show
    
End Sub

Private Sub Opc_50205_Click()
    Cartera = True
    Impresion_Entidades ("5104")
End Sub

Private Sub Opc_50206_Click()
    Cartera = False
    Impresion_Entidades ("5107")
End Sub

Private Sub Opc_50207_Click()
    Cartera = False
    Impresion_Entidades ("5108")
End Sub

Private Sub Opc_50209_Click()
    Cartera = False
    Impresion_Entidades ("CIC")
End Sub

Private Sub Opc_50120_Click()
    infCirc477.Show
End Sub

Private Sub Opc_50200_Click()
    Cartera = True
    BacInfCarteras.Lbl_index.Caption = 5100
    BacInfCarteras.Show
End Sub

Private Sub Opc_50210_Click()
    Impresion_Entidades ("ICDF")
End Sub
'
'Private Sub Opc_50250_Click()
''On Error GoTo errores
''            Call Limpiar_Cristal
''
''            BacTrader.bacrpt.ReportFileName = RptList_Path & "CarDisp.RPT"    'Hasta aqui voy
''            BacTrader.bacrpt.Connect = CONECCION
''           BacTrader.bacrpt.Action = 1
''            Exit Sub
''errores:
''    MsgBox err.Description, vbCritical
'
'End Sub

Private Sub Opc_50251_Click()

End Sub

Private Sub Opc_50252_Click()

End Sub

'''Private Sub Opc_50301_Click()
'''On Error GoTo errores
'''    Call Limpiar_Cristal
'''    BacTrader.bacrpt.ReportFileName = RptList_Path & "infp17ii.RPT"
'''    BacTrader.bacrpt.Connect = CONECCION
'''    BacTrader.bacrpt.Action = 1
'''Exit Sub
'''errores:
'''    MsgBox err.Description, vbCritical
' ============================================= '
' Opción de informes de Custodia, Nomina de documentos
' ============================================= '
'    Cartera = False  ' cheque si debe llevar cartera o no
'    Impresion_Entidades ("ND")

''End Sub

Private Sub Opc_50302_Click()
' ============================================= '
' Opción de informes de Custodia, cartera DVC
' ============================================= '
    Cartera = False
    Impresion_Entidades ("CD")

End Sub

Private Sub Opc_50303_Click()
' ============================================= '
' Opción de informes de Custodia, Mov. diarios de Ventas DCV
' ============================================= '
    Cartera = False
    Impresion_Entidades ("MD")


End Sub

Private Sub Opc_50304_Click()
    Dim TitRpt
    
    Cartera = False
    EstadoCuenta.proOrigen = "LISCAP"
    EstadoCuenta.Show 1
    
If giAceptar% = True Then
    Call Limpiar_Cristal
    Screen.MousePointer = vbHourglass
    If Informe_Custodia("INFORME DE CUSTODIA POR CLIENTE", xRut, xCodigo) Then
        TitRpt = "INFORME DE CUSTODIA POR CLIENTE"
        BacTrader.bacrpt.Destination = 0
        BacTrader.bacrpt.ReportFileName = RptList_Path & "CUSCLI.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = xRut
        BacTrader.bacrpt.StoredProcParam(1) = xCodigo
        BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión INFORME DE CUSTODIA POR CLIENTE")
    Else
        MsgBox "No existe informacion para imprimir", vbOKOnly + vbExclamation
        Screen.MousePointer = vbDefault
        Exit Sub
    End If
End If
    
    Screen.MousePointer = vbDefault
    
End Sub




Private Sub Opc_50305_Click()
    Dim TitRpt
    
    Cartera = False
    EstadoCuenta.proOrigen = "LISCAP"
    EstadoCuenta.Show 1

If giAceptar% = True Then
    Screen.MousePointer = vbHourglass
    Call Limpiar_Cristal
    If Informe_Custodia("INFORME DE CUSTODIA POR CLIENTE Y CUSTODIA", xRut, xCodigo) Then
        TitRpt = "INFORME DE CUSTODIA POR CLIENTE Y CUSTODIA"
        BacTrader.bacrpt.Destination = 0
        BacTrader.bacrpt.ReportFileName = RptList_Path & "INFCUSCL.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = xRut
        BacTrader.bacrpt.StoredProcParam(1) = xCodigo
        BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión INFORME DE CUSTODIA POR CLIENTE Y CUSTODIA")
    Else
        MsgBox "No existe informacion para imprimir", vbOKOnly + vbExclamation
        Screen.MousePointer = vbDefault
        Exit Sub
    End If
End If
    Screen.MousePointer = vbDefault

End Sub


Private Sub Opc_50306_Click()
   Dim TitRpt
   Cartera = False

If Inf_Recepcionar(1) Then
    Call Limpiar_Cristal
    TitRpt = "INFORME DE INSTRUMENTOS A RECEPCIONAR POR DCV"
    BacTrader.bacrpt.Destination = 0
    BacTrader.bacrpt.ReportFileName = RptList_Path & "INFINFI.rpt"
    BacTrader.bacrpt.StoredProcParam(0) = 1
    BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Action = 1
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión INFORME DE INSTRUMENTOS A RECEPCIONAR POR DCV")
End If
End Sub
Private Sub Opc_50307_Click()
Dim TitRpt

Cartera = False

If Inf_Recepcionar(2) Then
    Call Limpiar_Cristal
    TitRpt = "INFORME DE INSTRUMENTOS A RECEPCIONAR FISICAMENTE"
    BacTrader.bacrpt.Destination = 0
    BacTrader.bacrpt.ReportFileName = RptList_Path & "INFINFI.rpt"
    BacTrader.bacrpt.StoredProcParam(0) = 2
    BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Action = 1
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión INFORME DE INSTRUMENTOS A RECEPCIONAR FISICAMENTE")
End If

End Sub


 
 

''Private Sub Opc_503014_Click()
''
'' Dim cLine As String
'' Dim cNomArchivo As String
'' Dim cDia As String
'' Dim cruta As String
'' Dim datos
'' Dim Punto As String
'' On Error GoTo Herror1
'' Punto = "."
'' cDia = Mid(Format(gsBac_Fecp, "ddmmyyyy"), 1, 4)
'' cNomArchivo = gsBac_DIRIN & "D31_" & cDia & ".TXT"
''
'' Sql = "SP_OPERACIONES '" & Format(gsBac_Fecp, "yyyymmdd") & "'"
''
'' If Not Bac_Sql_Execute(Sql) Then
''    MsgBox "Problemas al leer operaciones", vbCritical, "MENSAJE"
''   ' Call GRABA_LOG_AUDITORIA("Opc_60913", "09", "Problemas Procedimiento", "", "", "")
''    Exit Sub
'' End If
''
'' cLine = ""
''Do While Bac_SQL_Fetch(datos)
''
''   cLine = cLine & Format(datos(1), "000000000") & datos(2) & Format(datos(3), "00000000000000000000")
''   cLine = cLine & datos(4) & datos(5) & datos(6) & Format(datos(7), "000000000000000") & Format(datos(8), "yyyymmdd")
''   cLine = cLine & Format(datos(9), "yyyymmdd") & datos(10)
''
''   cLine = cLine & Format(TransMonto2(datos(11), 4), "0000000") & datos(12)
''   cLine = cLine & Format(TransMonto2(datos(13), 0), "0000")
''   cLine = cLine & datos(14) & datos(15) & datos(16) & datos(17)
''
''   cLine = cLine + Chr(13) + Chr(10)
''
''Loop
''
''
''   If Dir(cNomArchivo) <> "" Then
''        Kill cNomArchivo
''   End If
''
''    Open cNomArchivo For Binary Access Write As #1
''    Put #1, , cLine
''    Close #1
''
''    MsgBox "Interfaz Generada" & " " & cNomArchivo, vbOKOnly, "MENSAJE"
''
''      If Not Enviar_por_ftp(gsBac_DIRIN, cNomArchivo) Then
''         MsgBox "interfaz " & cNomArchivo & "  via FTP no fue traspasada ", vbCritical
''    End If
''
''   Exit Sub
''
''Herror1:
''   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
''   'Call GRABA_LOG_AUDITORIA("Opc_60912", "09", "Interfaz Error", "", "", cNomArchivo & " " & err.Description)
''
''End Sub
''
'Private Sub Opc_50401_Click()
'
'
'End Sub

Private Sub Opc_50401_Click()

    Cartera = False
    BacFechas.Tag = "VCTOIB"
    BacFechas.Caption = "Ingreso de fechas para vencimientos de papeles"
    BacFechas.Show

End Sub

Private Sub Opc_50402_Click()
    Cartera = False
    BacFechas.Tag = "VCTOPACT"
    BacFechas.Caption = "Ingreso de fechas para vencimientos de papeles"
    BacFechas.Show

End Sub

Private Sub Opc_50403_Click()

    Cartera = False

    BacFechas.Tag = "VCTOPAP"
    BacFechas.Caption = "Ingreso de fechas para vencimientos de papeles"
    BacFechas.Show

End Sub

Private Sub Opc_50405_Click()
' ============================================= '
' Opción de informes de Vencimientos , Compras Con Pactos
' ============================================= '
    Cartera = False
    BacFechas.Tag = "VCTOPACT"
    BacFechas.Caption = "Ingreso de fechas para vencimientos de pactos"
    BacFechas.Show

End Sub

Private Sub Opc_50406_Click()
' ============================================= '
' Opción de informes de Vencimientos , Ventas Con Pactos

' ============================================= '
     BacFechas.Tag = "VCTOPACT"
     BacFechas.Show
End Sub

Private Sub Opc_50407_Click()
Cartera = False
    If LlenarVencimientocaptacion Then
        Call Limpiar_Cristal
        BacTrader.bacrpt.Destination = 0
        BacTrader.bacrpt.ReportFileName = RptList_Path & "VCTOCAP.RPT"
        BacTrader.bacrpt.Action = 1
    End If
End Sub

Private Sub Opc_50501_Click()
' ============================================= '
' Opción de informes de Gestion, Pactos (Recompras / Reventas)
' ============================================= '

    Impresion_Entidades ("GP")

End Sub

Private Sub Opc_50502_Click()
' ============================================= '
' Opción de informes de Gestion, Compras y ventas definitivas
' ============================================= '

    Impresion_Entidades ("GCV")

End Sub

Private Sub Opc_50601_Click()
' ============================================= '
' Opción de informes de historicos, Papeletas
' ============================================= '
    BacFechas.Tag = "PAPELHIS"
    BacFechas.Show
End Sub

Private Sub Opc_50602_Click()
' ============================================= '
' Opción de informes de historicos, Contratos y pagares
' ============================================= '

 BacHisContr.Show

End Sub


Private Sub Opc_50300_Click()
On Error GoTo Errores
    Call Limpiar_Cristal
    BacTrader.bacrpt.ReportFileName = RptList_Path & "infp17.RPT"
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Action = 1
Exit Sub
Errores:
    MsgBox err.Description, vbCritical
   
End Sub

'''Private Sub Opc_503011_Click()
'''    BacRentabilidad.Show
'''End Sub

'''Private Sub Opc_503012_Click()
'''
'''    On Error GoTo errores
'''
'''    Call Limpiar_Cristal
'''
'''    If MsgBox("Desea Generar Informe BNS", vbQuestion + vbYesNo, gsBac_Version) = vbYes Then
'''      Screen.mousepointer = vbhourglass
'''      If Bac_Sql_Execute("SP_FORMATOBNS_LLENAR") Then
'''
'''         Screen.mousepointer = vbdefault
'''         BacTrader.bacrpt.ReportFileName = RptList_Path & "formatobns.RPT"
'''         BacTrader.bacrpt.Connect = CONECCION
'''         BacTrader.bacrpt.Action = 1
'''      Else
'''         Screen.mousepointer = vbdefault
'''         MsgBox "Error al Generar Informe BNS", vbCritical, gsBac_Version
'''      End If
'''   End If
'''
'''Exit Sub
'''errores:
'''    MsgBox err.Description, vbCritical
'''
'''End Sub

Private Sub Opc_503013_Click()
consulta_operaciones.Show
End Sub

Private Sub Opc_50500_Click()

On Error GoTo Errores

    Call Limpiar_Cristal
    BacTrader.bacrpt.ReportFileName = RptList_Path & "elegib.RPT"
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Action = 1
    
Exit Sub
Errores:
    MsgBox err.Description, vbCritical
   


End Sub

Private Sub Opc_50600_Click()
    Screen.MousePointer = vbHourglass
    Call Limpiar_Cristal
    BacTrader.bacrpt.Destination = 0
    BacTrader.bacrpt.ReportFileName = RptList_Path & "mensaje_ms165.rpt"
    BacTrader.bacrpt.WindowTitle = "POSICION DIARIA DE DOCUMENTOS EMITIDOS POR EL BCCH EN US$"
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Action = 1
    Screen.MousePointer = vbDefault
End Sub

Private Sub Opc_50700_Click()
    BacFiltraFechas.Tag = "CtaCteBCCH"
    BacFiltraFechas.Show vbNormal
End Sub

Private Sub Opc_50701_Click()
   FRM_GEN_INFORME_DCV.Show
End Sub

Private Sub Opc_50702_Click()
   FRM_GEN_INF_SEG_DCV.Show
End Sub

Private Sub Opc_50703_Click()
    BacInfCarterasAVR.Show
End Sub

Private Sub Opc_50704_Click()
    Call FRM_INFORME_BASILEA.Show
End Sub

Private Sub Opc_50706_Click()
    Bac_Informes_Intramesas.Show
End Sub

Private Sub Opc_50707_Click()
    FrmMnt_CertificadoPacto.Show
End Sub

Private Sub Opc_50708_Click()

FRM_Informe_RcoOmg.Show vbNormal

End Sub

Private Sub Opc_50715_Click(Index As Integer)
' LD1-COR-035-Configuración BAC Corpbanca – Tarea: Incorporación de procesos y reportes de limites de permanecia
Dim Datos()
Dim Fecha_Proceso_Dev      As String         'Fecha Proceso del devengo
Dim Fecha_Proximo_Dev      As String         'Fecha Proximo Proceso del devengo
Dim Fecha_Cierre_Mes       As String         'Cierre de Mes
Dim Fecha_Proceso          As String         'Fecha Proceso
Dim Fecha_Proximo_Proceso  As String         'Fecha Proximo Proceso
Dim iSwDev As Integer
On Error GoTo Err_RptT
    If Bac_Sql_Execute("SP_CHKFECHASDEVENGAMIENTO") Then
        Do While Bac_SQL_Fetch(Datos())
            Fecha_Proceso = Datos(1)
            Fecha_Proximo_Proceso = Datos(2)
            Fecha_Cierre_Mes = Datos(3)
        Loop
    End If
    Fecha_Proceso_Dev = Fecha_Proceso
    Fecha_Proximo_Dev = Fecha_Cierre_Mes
    iSwDev = 0
    If Fecha_Proceso_Dev = Fecha_Proximo_Dev Then
      iSwDev = 1
    End If
    Call Limpiar_Cristal
    BacTrader.bacrpt.Destination = crptToWindow
    BacTrader.bacrpt.ReportFileName = RptList_Path & "Limite_permanecia.rpt"
    BacTrader.bacrpt.WindowTitle = "LIMITES DE PERMANENCIA PARA BONOS"
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.WindowState = crptMaximized
    BacTrader.bacrpt.Action = 1
      Screen.MousePointer = vbDefault
Exit Sub
Err_RptT:
    MsgBox err.Description, vbCritical, TITSISTEMA
    Exit Sub



End Sub



Private Sub Opc_50717_Click()
' LD1-COR-035-Configuración BAC Corpbanca – Tarea: Incorporación de procesos y reportes de limites de permanecia

' Ventas Definitivas de IRF :
    Cartera = False
    BacFechas.Tag = "VIRF"
    BacFechas.Caption = "Ventas Definitivas de IRF"
    BacFechas.Show


End Sub

Private Sub Opc_50718_Click()
' LD1-COR-035-Configuración BAC Corpbanca – Tarea: Incorporación de procesos y reportes de limites de permanecia

' Compras Definitivas de IRF :
    Cartera = False
    BacFechas.Tag = "CIRF"
    BacFechas.Caption = "Compras Definitivas de IRF"
    BacFechas.Show

End Sub

Private Sub Opc_50719_Click()
' LD1-COR-035-Configuración BAC Corpbanca – Tarea: Incorporación de procesos y reportes de limites de permanecia

'Disponibilidad de Holding de IRF
    Cartera = False
    BacFechas.Tag = "CHOLD"
    BacFechas.Caption = "Disponibilidad de Holding de IRF"
    BacFechas.Show


End Sub

Private Sub Opc_60101_Click()
' ============================================= '
' Opción de Cambio de Password
' ============================================= '
On Error Resume Next
    Cambio_Password.Show vbNormal
End Sub

Private Sub Opc_60102_Click()
' ============================================= '
' Opción de Desbloqueo de Usurio
' ============================================= '

    Frm_BloqUs.Show vbNormal

End Sub


Private Sub Opc_60202_Click()
' ============================================= '
' Opción de Emisores
' ============================================= '
'On Error Resume Next
'    BacMntEm.Show vbNormal
'On Error GoTo 0
End Sub

Private Sub Opc_60203_Click()
' ============================================= '
'' Opción de Comunas
'' ============================================= '
'On Error Resume Next
'    BacMNTComuna.Show
'On Error GoTo 0
End Sub

Private Sub Opc_60204_Click()
' ============================================= '
' Opción de series
'' ============================================= '
'On Error Resume Next
'    BacMntSe.Show vbNormal
'On Error GoTo 0
End Sub

Private Sub Opc_60205_Click()
' ============================================= '
' Opción de Monedas
'' ============================================= '
'On Error Resume Next
'    BacMntMn.Show vbNormal
'    On Error GoTo 0
End Sub

Private Sub Opc_60206_Click()
' ============================================= '
' Opción de Valores De Monedas
' ============================================= '
'   On Error Resume Next
'     Screen.MousePointer = vbHourglass
'     BacMntVm.Show vbNormal
'     Screen.MousePointer = vbDefault
'    On Error GoTo 0
End Sub

Private Sub Opc_60207_Click()
' ============================================= '
' Opción de Tablas Generales
' ============================================= '
'On Error Resume Next
'    BacMntTb.Show vbNormal
End Sub

Private Sub Opc_60208_Click()
' ============================================= '
' Opción de feriados
' ============================================= '

'    BacMntFe.Show vbNormal

End Sub

Private Sub Opc_60209_Click()
' ============================================= '
' Opción de Familias de Instrumentos
' ============================================= '
'On Error Resume Next
'    BacMntFa.Show vbNormal
'On Error GoTo 0
End Sub


Private Sub Opc_60211_Click()
' ============================================= '
' Opción de Porcentaje de Variacion
' ============================================= '

'  Frm_Porc_Variacion.Show vbNormal

End Sub


Private Sub Opc_60213_Click()
' ============================================= '
' Opción de Ciudades
' ============================================= '
'On Error Resume Next
'    BacMntCiu.Show vbNormal
'On Error GoTo 0
End Sub

Private Sub Opc_60214_Click()
' ============================================= '
' Opción de Formas de Pagos
' ============================================= '
'On Error Resume Next
'    BacMntFormaPago.Show vbNormal
'On Error GoTo 0
End Sub

Private Sub Opc_60215_Click()
    'BacMntCorresponsales.Show vbNormal
End Sub

Private Sub Opc_60216_Click()
'=============================================='
'Opción de Categorías
'=============================================='
'On Error Resume Next
'    BacMntCateg.Show vbNormal
'On Error GoTo 0
End Sub

Private Sub Opc_60217_Click()
'
'    BacInfSe.proOrigen = "MNT"
'    BacInfSe.Show
'
End Sub

Private Sub Opc_60301_Click()
' ============================================= '
' Opción de Generación de U.F.
' ============================================= '

'    BacGenUF.Show vbNormal

End Sub

Private Sub Opc_60302_Click()
' ============================================= '
' Opción de generación de I.V.P.
' ============================================= '

'    BacGenIV.Show

End Sub

Private Sub Opc_60103_Click()

    Control_Bloq_Usuarios.Show

End Sub

Private Sub Opc_60200_Click()
    
    Cargatura.Show
    
End Sub

Private Sub Opc_60401_Click()
' ============================================= '
' Opción de informe , Cliente
' ============================================= '
    Screen.MousePointer = vbHourglass
    Call Limpiar_Cristal
    BacTrader.bacrpt.Destination = 0
    BacTrader.bacrpt.ReportFileName = RptList_Path & "clientes.rpt"
    BacTrader.bacrpt.WindowTitle = "INFORME DE CLIENTES"
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Action = 1
    Screen.MousePointer = vbDefault
    
End Sub

Private Sub Opc_60402_Click()
' ============================================= '
' Opción de informe , Emisores
' ============================================= '
    Screen.MousePointer = vbHourglass
            
    BacTrader.bacrpt.Destination = 0
    BacTrader.bacrpt.ReportFileName = RptList_Path & "emisores.rpt"
    BacTrader.bacrpt.WindowTitle = "INFORME DE EMISORES"
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Action = 1
    Screen.MousePointer = vbDefault

End Sub

Private Sub Opc_60403_Click()

    Screen.MousePointer = vbHourglass
    
    BacTrader.bacrpt.Destination = 0
    BacTrader.bacrpt.ReportFileName = RptList_Path & "CARTERAS.RPT"
    BacTrader.bacrpt.WindowTitle = "INFORME DE CARTERAS"
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Action = 1
    
    Screen.MousePointer = vbDefault

End Sub

Private Sub Opc_60404_Click()

'    BacInfSe.proOrigen = "PRN"
'    BacInfSe.Show
'
End Sub

Private Sub Opc_60405_Click()
    BacFechas.Tag = "VALMON"
    BacFechas.Caption = "Ingreso de fechas para valores de moneda"
    BacFechas.Show
 
End Sub

Private Sub Opc_60406_Click()

   Dim TitRpt As String
   Screen.MousePointer = vbHourglass
   
   TitRpt = "LISTADO DE TABLAS GENERALES"
   BacTrader.bacrpt.ReportFileName = RptList_Path & "LISTTABG.RPT"
   BacTrader.bacrpt.Destination = 0
   BacTrader.bacrpt.StoredProcParam(0) = ""
   BacTrader.bacrpt.StoredProcParam(1) = ""
   BacTrader.bacrpt.StoredProcParam(2) = ""
   BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
   BacTrader.bacrpt.Formulas(1) = ""
   BacTrader.bacrpt.Formulas(2) = ""
   BacTrader.bacrpt.Connect = CONECCION
   BacTrader.bacrpt.Action = 1
   
   Screen.MousePointer = vbDefault
    
End Sub

Private Sub Opc_60407_Click()
   Dim TitRpt As String
   Screen.MousePointer = vbHourglass
   
   TitRpt = "INFORME DE FAMILIAS"
   BacTrader.bacrpt.ReportFileName = RptList_Path & "MANTFAM.RPT"
   BacTrader.bacrpt.Destination = 0
   BacTrader.bacrpt.StoredProcParam(0) = ""
   BacTrader.bacrpt.StoredProcParam(1) = ""
   BacTrader.bacrpt.StoredProcParam(2) = ""
   BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
   BacTrader.bacrpt.Formulas(1) = ""
   BacTrader.bacrpt.Formulas(2) = ""
   BacTrader.bacrpt.Connect = CONECCION
   BacTrader.bacrpt.Action = 1
   
   Screen.MousePointer = vbDefault

End Sub

Private Sub Opc_60410_Click()
 
    'BacConHisVi.Show vbNormal

End Sub

Private Sub Opc_60500_Click()
Interfaz.Interfaz = "C8"
Interfaz.Show
End Sub

Private Sub Opc_60104_Click()
     FRM_MNT_Confirmacion.Show
End Sub

Private Sub Opc_60106_Click()
    FRM_BLOQUEO_PACTO.Toolbar1.Buttons(2).Enabled = False
    FRM_BLOQUEO_PACTO.Show
End Sub

Private Sub Opc_60107_Click()
    FRM_BLOQUEO_PACTO.Show
End Sub


Private Sub OPC_6123_pre_Per_Click()
Mantenedor_Plazo.Tag = "PRE"
Mantenedor_Plazo.Show 0
End Sub


Private Sub OPC_6123_apr_Per_Click()
Mantenedor_Plazo.Tag = "APR"
Mantenedor_Plazo.Show 0
End Sub


Private Sub Opc_70101_Click()
' ============================================= '
' Opción de Tasa de Marcado, Carga automatica de Factores
' ============================================= '

    gsRUN_Proceso = "SB"
    BacProc.Show 'vbNormal

End Sub

Private Sub Opc_70102_Click()
' ============================================= '
' Opción de Tasa de Marcado, Valorización SBIF
' ============================================= '

BacMntSb.Show 'vbNormal%

End Sub



Private Sub Opc_70105_Click()
   ' ============================================= '
   ' Opción de Tasa de Marcado, Infrome de T. Mercado
   ' ============================================= '
   
   On Error GoTo Err_Print
   Dim TitRpt As String
   
   Call Limpiar_Cristal

   TitRpt = "INFORME DE FACTORES SBIF "
   BacTrader.bacrpt.Destination = 0
   BacTrader.bacrpt.ReportFileName = RptList_Path & "TASAMER.RPT"
   BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
   BacTrader.bacrpt.Connect = CONECCION
   BacTrader.bacrpt.Action = 1
   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)

   Exit Sub

Err_Print:
   
   If err.Number = 20526 Then
      
      MsgBox "No hay Impresora seleccionada", vbInformation + vbOKOnly, "Tradent"
   
   Else
      
      MsgBox err.Description, , err.Number
   
   End If

End Sub


Private Sub Opc_70106_Click()
   Dim dFech2, dFech1, cFecCal$, TitRpt As String
   On Error GoTo Err_Print

' ============================================= '
' Opción de Tasa de Marcado, Infrome de Valorización
' ============================================= '
      
      If Month(gsBac_Fecp) <> Month(gsBac_Fecx) Then
         
         dFech2 = CDate("01/" + Str(Month(gsBac_Fecx)) + "/" + Str(Year(gsBac_Fecx)))
         dFech1 = DateAdd("d", -1, dFech2)
         cFecCal$ = Trim(Str(Month(dFech1))) + "/" + Trim(Str(Day(dFech1))) + "/" + Trim(Str(Year(dFech1)))
      
      Else
         
         cFecCal$ = Trim(Str(Month(gsBac_Fecp))) + "/" + Trim(Str(Day(gsBac_Fecp))) + "/" + Trim(Str(Year(gsBac_Fecp)))
      
      End If
         Call Limpiar_Cristal
         TitRpt = "VALORIZACION A FACTORES SBIF "
         BacTrader.bacrpt.Destination = 0
         BacTrader.bacrpt.ReportFileName = RptList_Path & "VALORIZA.RPT"
         BacTrader.bacrpt.StoredProcParam(0) = xentidad
         BacTrader.bacrpt.Formulas(0) = Format(cFecCal$, "yyyy-mm-dd ") + "00:00:00.000"
         'BacTrader.bacrpt.Formulas(1) = "Fecha='" & Format(cFeccal$, "dd/mm/yyyy") + "'"
         BacTrader.bacrpt.Connect = CONECCION
         BacTrader.bacrpt.Action = 1
         Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
    
Exit Sub
Err_Print:
If err.Number = 20526 Then
   MsgBox "No hay Impresora seleccionada", vbInformation + vbOKOnly, "Tradent"
Else
   MsgBox err.Description, , err.Number
End If
End Sub


Private Sub Opc_70200_Click()
' ============================================= '
' Opción de Tasa de Marcado, Valorización Mark to Market
' ============================================= '
                
    BacMnRG3.Show

End Sub

Private Sub Opc_70300_Click()

  '  BacTmRen.Show

End Sub

Private Sub Opc_70103_Click()
   'BacInfMercado.Lbl_index.Caption = 5100
    BacInfMercado.Show
End Sub

Private Sub Opc_70104_Click()
   FRM_MNT_CURVAS_IBS.Show
End Sub

Private Sub Opc_80100_Click()
' ============================================= '
' Opción de Fin de día, Proceso de fin de día
' ============================================= '
    If Chequea_ControlProcesos("FD") Then
        gsRUN_Proceso = "FD"
        FRM_PROC_FDIA.Show vbNormal
'        BacProc.Show vbNormal
    End If
End Sub


Private Sub Opc_80200_Click()
' ============================================= '
' Opción de Fin de Dia , Bloqueo de Mesa de dinero
' ============================================= '
Dim cgv As Long
'Revisar si hay Garantías Constituídas Vencidas - PRD-5521
cgv = CantidadGtiasVencidas("C")
If cgv = -1 Then
    MsgBox "Error, no es posible leer la cantidad de garantías vencidas!", vbExclamation, TITSISTEMA
    Exit Sub
End If

If cgv > 0 Then
    MsgBox "No es posible cerrar la mesa, hay " & Trim(CStr(cgv)) & " garantías vencidas que no han sido eliminadas!", vbExclamation, TITSISTEMA
    Exit Sub
End If

    If Chequea_ControlProcesos("CM") Then
        
        Frm_Cierra_Mesa.Show              'vbNormal%
    
    End If

End Sub



Private Sub Opc_90100_Click()

'Interfaces.Caption = "Interfaz TSAR"
'Interfaces.Lbl_Interfaz.Caption = "TSAR"
'Interfaces.Show

End Sub

Private Sub Opc_90200_Click()

'Interfaces.Caption = "Interfaz PRAMS"
'Interfaces.Lbl_Interfaz.Caption = "PRAMS"
'Interfaces.Show

End Sub

Private Sub Opc_90300_Click()

    InterPV01.Show vbNormal
    
End Sub

Private Sub Opc_90001_Click()

    If Chequea_ControlProcesos("INT_C8") Then
        Interfaz.Interfaz = "C8"
        Interfaz.Show
    End If

End Sub

Private Sub Opc_90002_Click()

    If Chequea_ControlProcesos("INT_CTACTE") Then
        Interfaz.Interfaz = "CTACTE"
        Interfaz.Show
    End If

End Sub

Private Sub Opc_90003_Click()

Interfaz.Interfaz = "P17"
Interfaz.Show
End Sub

Private Sub Opc_900020_Click()
   Call PrintCarteraDisponible("Res")
End Sub

Private Sub Opc_900021_Click()
   Call PrintCarteraDisponible(" ")
End Sub

Private Sub Opc_90004_Click()
    'If Chequea_ControlProcesos("INT_D3") Then
    If Chequea_Parametros(ACSW_CO, "Proceso de contabilidad no ha sido realizado", 0) Then
        Interfaz.Interfaz = "D31"
        Interfaz.Show
    End If
End Sub

Private Sub Opc_90005_Click()
    If Chequea_ControlProcesos("INT_CLI") Then
        Interfaz.Interfaz = "CLIENTE"
        Interfaz.Show
    End If

End Sub

Private Sub Opc_9006_Click()
    If Chequea_ControlProcesos("INT_C14") Then
        Interfaz.Interfaz = "C14"
        Interfaz.Show
    End If
End Sub


Private Sub Opc_9007_Click()
    If Chequea_ControlProcesos("INT_ICOL") Then
        Interfaz.Interfaz = "COLOCACIONES"
        Interfaz.Show
    End If

End Sub

Private Sub Opc_9008_Click()
    If Chequea_ControlProcesos("INT_RCC") Then
        Interfaz.Interfaz = "RCC"
        Interfaz.Show
    End If

End Sub


Private Sub Opc_9009_Click()
Interfaz.Interfaz = "VENCIMIENTOS"
Interfaz.Show
End Sub

Private Sub Opc_9010_Click()
    If Chequea_ControlProcesos("INT_CTACTEII") Then
        Interfaz.Interfaz = "CTACTEII"
        Interfaz.Show
    End If
End Sub


Private Sub Opc_9011_Click()
    If Chequea_ControlProcesos("INT_GES") Then
        Interfaz.Interfaz = "GESTION"
        Interfaz.Show
    End If
End Sub

Private Sub Opc_9012_Click()
        'Interfaz.Interfaz = "ART57"
       ' Interfaz.Show
       FrmInterfazSii.Show
End Sub


Private Sub Opc_9013_Click()
Interfaz.Interfaz = "N_C8"
Interfaz.Show

End Sub

Private Sub Opc_9014_Click()
 Interfaz.Interfaz = "CARTERA"
 Interfaz.Show
End Sub

Private Sub Opc_9015_Click()
Interfaz.Interfaz = "FLUJOS"
Interfaz.Show
End Sub

Private Sub Opc_9016_Click()
Interfaz.Interfaz = "CLIENTES"
Interfaz.Show
End Sub

Private Sub Opc_9017_Click()
Interfaz.Interfaz = "OPERACIONES"
Interfaz.Show
End Sub

Private Sub Opc_9018_Click()
Interfaz.Interfaz = "DIRECCIONES"
Interfaz.Show
End Sub

Private Sub Opc_9019_Click()
Interfaz.Interfaz = "BALANCE"
Interfaz.Show
End Sub


Private Sub Opc_9020_Click()
Interfaz.Interfaz = "FLUJOSMUTUOS"
Interfaz.Show
End Sub


Private Sub Opc_9021_Click()
Interfaz.Interfaz = "POSICION"
Interfaz.Show
End Sub

Private Sub Opc_9022_Click()
Interfaz.Interfaz = "DEUDORES"
Interfaz.Show
End Sub

Private Sub Opc_9023_Click()
BacIntPV01.Show
End Sub

Private Sub Opc_9024_Click()
Interfaz.Interfaz = "ART84"
Interfaz.Show
End Sub

Private Sub Opc_9025_Click()
   BAC_FRM_GEN_SORTEO.Show
End Sub

Private Sub Opc_9026_Click()
   FRM_BAC_ENVIO_DCV.Show
End Sub

Private Sub Opc_9027_Click()
 Interfaz.Interfaz = "SIGUIR"
 Interfaz.Show
End Sub

Private Sub Opc_New_20400_Click()
    Tipo_Operacion = "VI"
    If Chequea_ControlProcesos("OP") Then
        BacIrfNueVentana "VI"
    End If
End Sub
'=====================================================
' LD1_COR_035 , Tema: Informe Evento de Capital
' INICIO
'=====================================================
Private Sub Opc_EventosCapital_Click()
    BacRecTasaCont.Show
End Sub
'=====================================================
' LD1_COR_035 , Tema: Informe Evento de Capital
' FIN
'=====================================================

Private Sub Opc_Mitigador_Click()
    Mantenedor_Mitigador.Show
End Sub

'==================================================================================
' LD1-COR-035-Configuración BAC Corpbanca, Tema: OP. Excedidas control de Tasas
' INICIO
'==================================================================================
Private Sub Opc_OperExcedCtrlTasas_Click()
    
    On Error GoTo ERROR_Imprime_RPT_Tasa
    Call Limpiar_Cristal
    
    BacTrader.bacrpt.WindowTitle = "INFORME DE EXCEPCION CONTROL DE TASAS"
    BacTrader.bacrpt.ReportFileName = RptList_Path & "BacInfTasas.rpt"
    BacTrader.bacrpt.Connect = CONECCION
    'BacTrader.Cristal.PrintFileType = crptCrystal
    BacTrader.bacrpt.Destination = crptToWindow
    BacTrader.bacrpt.WindowState = crptMaximized
    BacTrader.bacrpt.Action = 1
    
    Exit Sub
    
ERROR_Imprime_RPT_Tasa:
    MsgBox err.Description, vbCritical ', TITSISTEMA
    
    
End Sub
'==================================================================================
' LD1-COR-035-Configuración BAC Corpbanca, Tema: OP. Excedidas control de Tasas
' FIN
'==================================================================================

'=====================================================
' LD1_COR_035 , Tema: Mantenedor Plazo Permanencia
' INICIO
'=====================================================
Private Sub Opc_PlazoPermanencia_Click()
    Mantenedor_Plazo.Tag = "PRE"
    Mantenedor_Plazo.Show 0
End Sub
'=====================================================
' LD1_COR_035 , Tema: Mantenedor Plazo Permanencia
' FIN
'=====================================================

Private Sub Opc_CartLetraPropEm_Click()
    BacStockCaLetras.Show
End Sub

Private Sub Opc_CartTirComp_Click()
    BacStockCarteraTirc.Show
End Sub

Private Sub Opc_CartTitHis2_Click()
   BacRepTirHist.Show
End Sub

Private Sub Opc_CartTot_Click()
   BacTradTirHist.Tag = "CTRTotal"
   BacTradTirHist.Show
End Sub

Private Sub Opc_CartTradCLP_Click()
   BacTradTirHist.Tag = "CTRTrading"
   BacTradTirHist.Show
End Sub

Private Sub Opc_CartTradUSD_Click()
    BacTradingUSD.Show
End Sub

Private Sub Opc_ManTirHis_Click()
' ============================================= '
' Mantencion TIR Historica
' ============================================= '
        
    BacMntTirHistorica.Show
End Sub

'''nuevo para prd25609
Private Sub Opc_RecalculoDRV_Click()
 FRM_RecalculoDRV.Show
 
End Sub
Private Sub Opc_Salir_Click()
   Unload Me
   'End
End Sub
Private Sub BOpc_20100_Click()
    Opc_20100_Click
End Sub

Private Sub BOpc_20200_Click()
    Opc_20200_Click
End Sub

Private Sub BOpc_20300_Click()
    Opc_20300_Click
End Sub

Private Sub BOpc_20400_Click()
    Opc_20400_Click
End Sub

Private Sub BOpc_20500_Click()
    Opc_20500_Click
End Sub

Private Sub BOpc_20600_Click()
    Opc_20600_Click
End Sub

Private Sub BOpc_20700_Click()
    Opc_20700_Click
End Sub

Private Sub BOpc_21600_Click()
    Opc_21600_Click
End Sub

Private Sub BOpc_21700_Click()
    Opc_21700_Click
End Sub

Private Sub BOpc_21800_Click()
  Opc_21800_Click
End Sub
Private Sub BOpc_21810_Click()
  Opc_21810_Click
End Sub
Private Sub Label2_Click()
'Form1.Show
End Sub

'===============================================================================
' LD1-COR-035-Configuración BAC Corpbanca - Tema: Carga Cartera Findur
' INICIO
'===============================================================================
Private Sub opcCarteraFindur_Click()
    CargaCarteraFindur.Show
End Sub
'===============================================================================
' LD1-COR-035-Configuración BAC Corpbanca - Tema: Carga Cartera Findur
' FIN
'===============================================================================


Private Sub Opc_StockCart_Click()
    BacStockCartera.Show
End Sub

Private Sub opcD16_Click()
    codInterfaz1617 = "16"
    FRM_InterfazD16_17.Show
End Sub

Private Sub opcD17_Click()
    codInterfaz1617 = "17"
    FRM_InterfazD16_17.Show
End Sub

'===============================================================================
' LD1-COR-035-Configuración BAC Corpbanca - Tema: INTERFACES Tarifado y MKPZ
' INICIO
'===============================================================================
Private Sub opcTarifadoMKPZ_Click()
    CargaTasasPrecio.Show
End Sub
'===============================================================================
' LD1-COR-035-Configuración BAC Corpbanca - Tema: INTERFACES Tarifado y MKPZ
' FIN
'===============================================================================

Private Sub Pnl_Usuario_Click()
   FRM_MNT_CURVAS_IBS.Show
  'FRM_MTM_IBS.Show
End Sub




Private Sub Tmrfecha_Timer()
Static Intervalo As Long
Intervalo = Intervalo + Tmrfecha.Interval
    If Intervalo > gsBac_Timer_Adicional Then
    Intervalo = 0
          If Not Proc_Valida_Fecha Then
           End
          End If
    End If
End Sub

Private Sub TmrMsg_Timer()
'    Call Estado_Usuario
'    Call Ver_Estado_Usuario
'
'    If BacIsFormLoaded("Frm_Cierra_Mesa") = True Then
'
'      Set objCierreMesa = New clsCierraMesa
'      Call RefrescarMesa
'      Set objCierreMesa = Nothing
'
'    End If
'    If BacIsFormLoaded("BacValeVista") = True Then
        
'        Call BacValeVista.Refresca_Datos
'    End If
    
End Sub

Private Sub trasp_intru_Click()
    BacTraspasoInstru.Show
End Sub

Sub Ver_Estado_Usuario()
    Dim Datos()
    Dim m As String
    
    If Bac_Sql_Execute("SP_CONTROL_BLOQ_USUARIOS_LEE_ACTIVOS") Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = gsUsuario And Left(Datos(3), 1) = "N" And Right(Datos(3), 1) = Right(gsTerminal, 1) Then
                Call DESHABILITA_MENU
                MsgBox "Usuario Bloqueado", vbExclamation + vbOKOnly
                m = Bloquea_Usuario(False, gsUsuario)
                gsTerminal = Datos(3)
                Salida_Usuario
                End
            End If
        Loop
    End If

End Sub

Sub Estado_Usuario()
    Dim Datos()
    Dim Estado  As String
    Dim m       As String
    On Error GoTo Fin:


    If Estado = "S" And SW = 1 Then
        Call DESHABILITA_MENU
        MsgBox "Usuario Bloqueado", vbExclamation + vbOKOnly
        m = Bloquea_Usuario(False, gsUsuario)
        SW = 0
        Unload Me
    End If

    If Estado = "N" And SW = 0 Then
        MsgBox "Usuario Desbloqueado", vbExclamation + vbOKOnly
        PROC_BUSCA_PRIVILEGIOS_USUARIO BacTrader, "BTR"
        SW = 1
    End If

Fin:
End Sub


Sub Proc_Busca_privilegios_Especiales()
    Dim Datos()
    Dim i       As Integer
    Dim SW      As Integer

    SW = 0
    
    Envia = Array(gsUsuario, "BTR")
    
    If Bac_Sql_Execute("SP_BACSWAPPARAMETROS_BUSCA_PRIV_ESPECIALES", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = "NO EXISTE" Then
                Exit Sub
            End If
         
            If SW = 0 Then
                DESHABILITA_MENU
                SW = 1
            End If
        
            For i% = 0 To BacTrader.Controls.Count - 1
                If TypeOf BacTrader.Controls(i%) Is Menu Then
                    If Trim(BacTrader.Controls(i%).Name) = Trim(Datos(1)) Then
                        BacTrader.Controls(i%).Enabled = True
                    End If
                End If
            Next i%
        Loop
    End If
    
End Sub

Sub PROC_BUSCA_PRIVILEGIOS_USUARIO(forma_menu As Form, Entidad As String)
    Dim i%
    Dim Datos()

If Trim(gsBac_User) = "ADMINISTRA" Then
   Call MENU_TODOHABILITADO
   Exit Sub
End If

Comando$ = "SP_BUSCA_PRIVILEGIOS "
Comando$ = Comando$ + "'T',"
Comando$ = Comando$ + "'" + Entidad + "',"
Comando$ = Comando$ + "'" + gsBac_Tipo_Usuario + "'"

If miSQL.SQL_Execute(Comando$) <> 0 Then
    Exit Sub
End If

Do While Bac_SQL_Fetch(Datos())
   For i% = 0 To forma_menu.Controls.Count - 1
       If TypeOf forma_menu.Controls(i%) Is Menu Then
          If Trim(forma_menu.Controls(i%).Name) = Trim(Datos(1)) Then
             forma_menu.Controls(i%).Enabled = True
          End If
       End If
   Next i%
Loop

Comando$ = "SP_BUSCA_PRIVILEGIOS "
Comando$ = Comando$ + "'U',"
Comando$ = Comando$ + "'" + Entidad + "',"
Comando$ = Comando$ + "'" + gsUsuario + "'"

If miSQL.SQL_Execute(Comando$) <> 0 Then
    Exit Sub
End If

Do While Bac_SQL_Fetch(Datos())
   For i% = 0 To forma_menu.Controls.Count - 1
       If TypeOf forma_menu.Controls(i%) Is Menu Then
          If Trim(forma_menu.Controls(i%).Name) = Trim(Datos(1)) Then
             If Datos(2) = "N" Then
                forma_menu.Controls(i%).Enabled = False
             Else
                forma_menu.Controls(i%).Enabled = True
             End If
          End If
       End If
   Next i%
Loop

'Call Proc_Busca_privilegios_Especiales

End Sub

Sub Salida_Usuario()

   Dim Datos()
   Dim Terminales(10)
   Dim Usuarios(10)
   Dim Sistemas(10)
   Dim TMP, TMP2, Terminal, m As String
   Dim i, j As Integer

    i = 1
    
    Envia = Array(gsUsuario, gsTerminal, gsSistema)

    If Bac_Sql_Execute("SP_CONTROL_BLOQ_USUARIOS_SALIR", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
        Loop
    End If
    
    Envia = Array(gsUsuario)

    If Bac_Sql_Execute("SP_CONTROL_BLOQ_USUARIOS_ACTUALIZAR_TERMINAL", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
        Loop
    End If


    m = Bloquea_Usuario(False, gsUsuario)

End Sub

'Sub RefrescarMesa()
'
'   With objCierreMesa
'
'      If Not .Lee_Mesa Then MsgBox "Problemas al Realizar Cierre de Mesa", vbCritical, TITSISTEMA
'
'      If .CieMesa = "0" Then
'
'         Frm_Cierra_Mesa.Image1(0).Picture = Frm_Cierra_Mesa.Image1(2).Picture
'         Frm_Cierra_Mesa.Toolbar1.Buttons(1).Image = "Rojo"
'         Frm_Cierra_Mesa.Toolbar1.Buttons(1).ToolTipText = "Bloquear Mesa"
'         Frm_Cierra_Mesa.PanelActivo.Caption = "Activa"
'         Opc_80200.Checked = False
'
'      Else
'
'         Frm_Cierra_Mesa.Image1(0).Picture = Frm_Cierra_Mesa.Image1(1).Picture
'         Frm_Cierra_Mesa.Toolbar1.Buttons(1).Image = "Verde"
'         Frm_Cierra_Mesa.Toolbar1.Buttons(1).ToolTipText = "Desbloquear Mesa"
'         Frm_Cierra_Mesa.PanelActivo.Caption = "Bloqueada"
'         Opc_80200.Checked = True
'
'      End If
'
'   End With
'
'End Sub

Private Sub Vale_CtaCte_Click()
'    BacInfValeVista.Show
End Sub

Public Sub PrintCarteraDisponible(ordenRep As String)

On Error GoTo Errores
            Call Limpiar_Cristal

            BacTrader.bacrpt.ReportFileName = RptList_Path & "CarDisp.RPT"    'Hasta aqui voy
            BacTrader.bacrpt.StoredProcParam(0) = ordenRep
            BacTrader.bacrpt.StoredProcParam(1) = GLB_LIBRO
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
            Exit Sub
Errores:
    MsgBox err.Description, vbCritical
            

End Sub

'LD1-COR-035 FUSION: Informe  Volcker Rule
Private Sub opc_Inf_VolckerRule_Click()
    Dim TitRpt As String
   Screen.MousePointer = vbHourglass
  
   
    Call Limpiar_Cristal
    TitRpt = "INFORME OPERACIONES VOLCKER RULE"
    BacTrader.bacrpt.Destination = 0
    BacTrader.bacrpt.ReportFileName = RptList_Path & "bacstockcartera_volckerrule.RPT"
    BacTrader.bacrpt.StoredProcParam(0) = Format(gsBac_Fecp, "yyyymmdd")

    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Action = 1
    Screen.MousePointer = vbDefault
  '  Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)

   
End Sub


'LD1-COR-035 FUSION: Modificar Clasificacion Volcker
Private Sub Opc_Mod_Clas_Rule_Click()
' ============================================= '
' Opción de Operaciones Anulacion de operaciones
' ============================================= '

    If Chequea_ControlProcesos("OP") Then
        bacOperVolckerRule.Show vbNormal
    End If

End Sub

