VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "crystl32.ocx"
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.MDIForm BACSwapParametros 
   BackColor       =   &H8000000F&
   Caption         =   "BAC-PARAMETROS ( Sql Server )"
   ClientHeight    =   6810
   ClientLeft      =   1560
   ClientTop       =   1950
   ClientWidth     =   12045
   Icon            =   "BACSwapParametros.frx":0000
   LinkTopic       =   "BacTrd"
   Picture         =   "BACSwapParametros.frx":030A
   WindowState     =   2  'Maximized
   Begin MSWinsockLib.Winsock NomObjWinIP 
      Left            =   1320
      Top             =   1800
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   5000
      Left            =   8940
      Top             =   540
   End
   Begin Threed.SSPanel PnlTools 
      Align           =   1  'Align Top
      Height          =   540
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   12045
      _Version        =   65536
      _ExtentX        =   21246
      _ExtentY        =   952
      _StockProps     =   15
      ForeColor       =   16711680
      BackColor       =   -2147483646
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   0
      BevelInner      =   1
      RoundedCorners  =   0   'False
      Outline         =   -1  'True
      Begin Crystal.CrystalReport BACParam 
         Left            =   5490
         Top             =   120
         _ExtentX        =   741
         _ExtentY        =   741
         _Version        =   348160
         PrintFileLinesPerPage=   60
      End
      Begin Threed.SSCommand CmdOPC_21 
         Height          =   435
         Left            =   150
         TabIndex        =   1
         Top             =   45
         Width           =   495
         _Version        =   65536
         _ExtentX        =   873
         _ExtentY        =   767
         _StockProps     =   78
         Caption         =   "CL"
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
      Begin Threed.SSCommand CmdOPC_33 
         Height          =   435
         Left            =   705
         TabIndex        =   2
         Top             =   45
         Width           =   495
         _Version        =   65536
         _ExtentX        =   873
         _ExtentY        =   767
         _StockProps     =   78
         Caption         =   "VM"
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
      Begin Threed.SSCommand CmdOPC_551 
         Height          =   435
         Left            =   1260
         TabIndex        =   3
         Top             =   45
         Width           =   495
         _Version        =   65536
         _ExtentX        =   873
         _ExtentY        =   767
         _StockProps     =   78
         Caption         =   "PC"
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
      Begin Threed.SSCommand CmdOPC_612 
         Height          =   435
         Left            =   2085
         TabIndex        =   4
         Top             =   45
         Width           =   495
         _Version        =   65536
         _ExtentX        =   873
         _ExtentY        =   767
         _StockProps     =   78
         Caption         =   "SE"
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
      Begin Threed.SSCommand CmdOPC_614 
         Height          =   435
         Left            =   2625
         TabIndex        =   5
         Top             =   45
         Width           =   495
         _Version        =   65536
         _ExtentX        =   873
         _ExtentY        =   767
         _StockProps     =   78
         Caption         =   "FE"
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
   End
   Begin Threed.SSPanel PnlInfo 
      Align           =   2  'Align Bottom
      Height          =   420
      Left            =   0
      TabIndex        =   6
      Top             =   6390
      Width           =   12045
      _Version        =   65536
      _ExtentX        =   21246
      _ExtentY        =   741
      _StockProps     =   15
      ForeColor       =   8421504
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      RoundedCorners  =   0   'False
      Outline         =   -1  'True
      Alignment       =   8
      Begin Threed.SSPanel PnlEstado 
         Height          =   285
         Left            =   90
         TabIndex        =   7
         Top             =   75
         Width           =   4770
         _Version        =   65536
         _ExtentX        =   8414
         _ExtentY        =   503
         _StockProps     =   15
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   12.01
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         Alignment       =   1
      End
      Begin Threed.SSPanel Pnl_UF 
         Height          =   330
         Left            =   6945
         TabIndex        =   8
         Top             =   45
         Width           =   1860
         _Version        =   65536
         _ExtentX        =   3281
         _ExtentY        =   572
         _StockProps     =   15
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.11
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
      Begin Threed.SSPanel PnlUsuario 
         Height          =   300
         Left            =   4920
         TabIndex        =   9
         Top             =   60
         Width           =   1980
         _Version        =   65536
         _ExtentX        =   3492
         _ExtentY        =   529
         _StockProps     =   15
         ForeColor       =   16776960
         BackColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
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
      Begin Threed.SSPanel PnlFecha 
         Height          =   330
         Left            =   10620
         TabIndex        =   10
         Top             =   45
         Width           =   1335
         _Version        =   65536
         _ExtentX        =   2350
         _ExtentY        =   572
         _StockProps     =   15
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.11
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
         Left            =   8850
         TabIndex        =   11
         Top             =   45
         Width           =   1740
         _Version        =   65536
         _ExtentX        =   3069
         _ExtentY        =   572
         _StockProps     =   15
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.11
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
   Begin VB.Menu OPC_20 
      Caption         =   "&Clientes  "
      Begin VB.Menu OPC_21 
         Caption         =   "&Clientes                           "
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_22 
         Caption         =   "&Operadores"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_23 
         Caption         =   "&Apoderados"
         HelpContextID   =   1
      End
      Begin VB.Menu opcBloqueoCltes 
         Caption         =   "&Bloqueo de Clientes"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu OPC_30 
      Caption         =   "&Monedas    "
      Begin VB.Menu OPC_31 
         Caption         =   "&Monedas"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_32 
         Caption         =   "&Monedas por Producto         "
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_33 
         Caption         =   "&Valores Monedas"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_901 
         Caption         =   "Valores de Tasas por Moneda"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_902 
         Caption         =   "Mantenedor T/C Contables"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_903 
         Caption         =   "Prioridades de Monedas"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_34 
         Caption         =   "-"
         HelpContextID   =   1
         Visible         =   0   'False
      End
   End
   Begin VB.Menu OPC_40 
      Caption         =   "&Formas de Pago  "
      Begin VB.Menu OPC_41 
         Caption         =   "&Formas de Pago"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_42 
         Caption         =   "&Formas de Pago por Moneda      "
         HelpContextID   =   1
      End
   End
   Begin VB.Menu OPC_550 
      Caption         =   "&Contabilidad"
      Begin VB.Menu OPC_551 
         Caption         =   "Perfiles Contables"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_552 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_553 
         Caption         =   "Valores a Contabilizar"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_554 
         Caption         =   "Plan de Cuentas"
         HelpContextID   =   1
      End
      Begin VB.Menu Lineas 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_DefCurvas 
         Caption         =   "Definición de Curvas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_CurvasProd 
         Caption         =   "Curvas por Producto"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_IngresoCurvas 
         Caption         =   "Ingreso de Curvas"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu OPC_600 
      Caption         =   "&Administracion"
      Begin VB.Menu OPC_610 
         Caption         =   "&Tablas"
         HelpContextID   =   1
         Begin VB.Menu OPC_611 
            Caption         =   "Emisores"
            HelpContextID   =   2
         End
         Begin VB.Menu OPC_612 
            Caption         =   "Series"
            HelpContextID   =   2
         End
         Begin VB.Menu OPC_614 
            Caption         =   "Feriado"
            HelpContextID   =   2
         End
         Begin VB.Menu OPC_615 
            Caption         =   "Familia de Instrumentos"
            HelpContextID   =   2
         End
         Begin VB.Menu OPC_616 
            Caption         =   "Porcentaje de Variacion"
            HelpContextID   =   2
         End
         Begin VB.Menu OPC_619 
            Caption         =   "Categorias"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_00621 
            Caption         =   "Mantenedor de Tablas Generales"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_00620 
            Caption         =   "Mantenedor Tasas por Moneda"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_006221 
            Caption         =   "Instrumentos Subyacentes"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_006222 
            Caption         =   "Ingreso de Factores Articulo 84"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_006223 
            Caption         =   "Series Subyacentes Inversiones"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_006224 
            Caption         =   "Parámetros Riesgo de Crédito Equivalente Normativo"
            HelpContextID   =   2
            Begin VB.Menu Opc_006225 
               Caption         =   "Riesgos Normativos"
               HelpContextID   =   3
            End
            Begin VB.Menu Opc_006226 
               Caption         =   "Riesgo Producto"
               HelpContextID   =   3
            End
            Begin VB.Menu Opc_006227 
               Caption         =   "Matriz de Riesgo Normativo"
               HelpContextID   =   3
            End
         End
         Begin VB.Menu Opc_0630 
            Caption         =   "Referencia Mercado"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_0631 
            Caption         =   "Referencia Mercado por Producto"
            HelpContextID   =   2
         End
         Begin VB.Menu tasa_pais 
            Caption         =   "Tasa País"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_0632 
            Caption         =   "Tablas Sistema Administrador Opciones"
            HelpContextID   =   2
            Begin VB.Menu Opc_0638 
               Caption         =   "Curvas de Smile"
               HelpContextID   =   3
            End
         End
         Begin VB.Menu Opc_0633 
            Caption         =   "Clausulas de Contratos de Derivados"
            HelpContextID   =   2
         End
         Begin VB.Menu mntAplican 
            Caption         =   "Mant. Sistemas-Productos Aplicados en Control"
            HelpContextID   =   2
         End
         Begin VB.Menu mntAplicanClas 
            Caption         =   "Mant. Clasificaciones Clientes Aplicados en Control"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_0639 
            Caption         =   "Parámetros de Control de Precios y Tasas"
            HelpContextID   =   2
         End
         Begin VB.Menu modoOpCPT 
            Caption         =   "Modo de Operación Control de Precios y Tasas"
            HelpContextID   =   2
         End
         Begin VB.Menu opMotBloq 
            Caption         =   "Motivo Bloqueos de Clientes"
            HelpContextID   =   2
         End
         Begin VB.Menu opt_Clasificacion_Riesgo 
            Caption         =   "Clasificación por Agencia"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_1004 
            Caption         =   "Facility "
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_1005 
            Caption         =   "Mantenedor de Familia"
         End
      End
      Begin VB.Menu OPC_650 
         Caption         =   "Tablas para Planillas"
         HelpContextID   =   1
         Begin VB.Menu OPC_651 
            Caption         =   "Codigos OMA"
            HelpContextID   =   2
         End
         Begin VB.Menu OPC_652 
            Caption         =   "Codigos de Comercio y Concepto"
            HelpContextID   =   2
         End
         Begin VB.Menu OPC_653 
            Caption         =   "Codigo de Comercio para Planilla Automaticas"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu OPC_660 
         Caption         =   "Glosa x Clientes Habituales"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_665 
         Caption         =   "Valores por Defecto"
         HelpContextID   =   1
         Begin VB.Menu OPC_670 
            Caption         =   "Valores por Defecto para Spot"
            HelpContextID   =   2
         End
         Begin VB.Menu OPC_675 
            Caption         =   "Vencimientos Arbitrajes Forward a Spot"
            HelpContextID   =   2
         End
         Begin VB.Menu OPC_676 
            Caption         =   "Transacciones Plataformas Externas"
            HelpContextID   =   2
         End
         Begin VB.Menu OPC_Valores_Defecto 
            Caption         =   "Valores por Defecto"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu OPC_680 
         Caption         =   "Cartera"
         HelpContextID   =   1
      End
      Begin VB.Menu VolckerRule 
         Caption         =   "Mantenedor Volcker Rule"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_690 
         Caption         =   "Paridades Monedas"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_700 
         Caption         =   "Generación Automática UF"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_740 
         Caption         =   "Generación Automática IVP"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_710 
         Caption         =   "Periodos"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_720 
         Caption         =   "Tasas Forward"
         HelpContextID   =   1
      End
      Begin VB.Menu Raya8020 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_730 
         Caption         =   "Clientes SINACOFI"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_780 
         Caption         =   "&Mantencion Pais y Plaza "
         HelpContextID   =   1
      End
      Begin VB.Menu opc_750 
         Caption         =   "&Corresponsales Internacionales"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_790 
         Caption         =   "Corresponsales"
         HelpContextID   =   1
      End
      Begin VB.Menu ManNomMet 
         Caption         =   "Mantenedor de Nombres de Metodologías"
         HelpContextID   =   1
      End
      Begin VB.Menu SengComer 
         Caption         =   "Segmentos Comerciales"
         HelpContextID   =   1
      End
      Begin VB.Menu Raya8021 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_791 
         Caption         =   "Limites de Tasas"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_760 
         Caption         =   "Cambio de Password"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_792 
         Caption         =   "Mantenedor UF Proyectada"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_793 
         Caption         =   "Asociación Conceptos OMA "
         HelpContextID   =   1
      End
      Begin VB.Menu opc_794 
         Caption         =   "Relaciones de SubCartera y Area Responsable"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_795 
         Caption         =   "Relacion Producto / Libro"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_796 
         Caption         =   "Relacion Libro / Cartera Super"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_ContDinaDerivado 
         Caption         =   "Asigna Contratos Derivados"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_797 
         Caption         =   "Mantención Usuario / Cartera Financiera"
         HelpContextID   =   1
      End
      Begin VB.Menu Usuario_VR 
         Caption         =   "Mantención Usuario / Cartera Volcker Rule"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_798 
         Caption         =   "Mantención Usuario / Libro CartN y Sub CartN"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_799 
         Caption         =   "Mantención Usuario / Portfolio"
         HelpContextID   =   1
      End
      Begin VB.Menu raya1 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_895 
         Caption         =   "Monitoreo LBTR"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_896 
         Caption         =   "Mantención de Códigos de Envío"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_897 
         Caption         =   "Mantención de Discrepancias"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_IngPondTasa 
         Caption         =   "Promedio Ponderado Tasas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_EnvOpSpot 
         Caption         =   "Envío de Operaciones Spot"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_MantOriOpSpot 
         Caption         =   "Mantención Origen de Operación Spot"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_MantMargenInst 
         Caption         =   "Margen por instrumento (SOMA)"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_MantTasasRefInst 
         Caption         =   "Tasas Referenciales (SOMA)"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_MantHairCutInst 
         Caption         =   "Hair-Cut (SOMA)"
         HelpContextID   =   1
      End
      Begin VB.Menu raya2 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_DerivCred 
         Caption         =   "Marca de Derivados y Créditos"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_MAIL_USR 
         Caption         =   "Ingreso de Email por usuarios"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_CONFIG_MENSAJE 
         Caption         =   "Configuración de Mensajes"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_CONS_DERCRE 
         Caption         =   "Consulta de Derivados Asociados a Créditos"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_CARGA_PREST_IBS 
         Caption         =   "Carga Préstamos IBS"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_Mant_Logos 
         Caption         =   "Mantención de Logos"
         HelpContextID   =   1
      End
      Begin VB.Menu Raya8022 
         Caption         =   "-"
      End
      Begin VB.Menu OPC_CTRL_INTER 
         Caption         =   "Control de Interfaces"
         HelpContextID   =   1
         Begin VB.Menu OPC_MAN_INTER 
            Caption         =   "Mantención Formato Interfaces"
            HelpContextID   =   2
         End
         Begin VB.Menu OPC_VALIDA_INTERFAZ 
            Caption         =   "Validacion Interfaces"
            HelpContextID   =   2
         End
         Begin VB.Menu BacMntGL 
            Caption         =   "Mantenedor de Cuentas GL"
            HelpContextID   =   2
         End
         Begin VB.Menu OPC_Mant_Feriados 
            Caption         =   "Mantencion de Feriados"
            HelpContextID   =   1
         End
      End
   End
   Begin VB.Menu Opc_Garantias 
      Caption         =   "Módulo de &Garantías"
      HelpContextID   =   1
      Begin VB.Menu opc_AsocGtiaOp 
         Caption         =   "&Asociar Garantías a Operaciones"
         HelpContextID   =   1
      End
      Begin VB.Menu op_InterGtiaConst 
         Caption         =   "&Intercambio de Garantías Constituídas"
         HelpContextID   =   1
      End
      Begin VB.Menu op_InterGtiaOtorg 
         Caption         =   "Intercambio de Garantías &Otorgadas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_Garan_Manrt 
         Caption         =   "&Mantenciones"
         HelpContextID   =   1
         Begin VB.Menu Opc_ConfiguracionMails 
            Caption         =   "Configuracion de Emails"
            HelpContextID   =   2
         End
         Begin VB.Menu Mnt_GarantiasOtrogadas 
            Caption         =   "Garantias Otorgadas"
            HelpContextID   =   2
         End
         Begin VB.Menu Mnt_GarantiasConstituidas 
            Caption         =   "Garantias constituidas"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu opAnulaGtias 
         Caption         =   "Anulación de Garantías"
         HelpContextID   =   1
      End
      Begin VB.Menu opcDesvincular 
         Caption         =   "Desvincular Operaciones"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_VenctoGar 
         Caption         =   "Informe de Vencimiento de Garantías"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_inf_gtias 
         Caption         =   "Informes de Garantías"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu OPC_800 
      Caption         =   "&Informes"
      Begin VB.Menu OPC_810 
         Caption         =   "Clientes"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_820 
         Caption         =   "Emisores"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_840 
         Caption         =   "Series"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_850 
         Caption         =   "Valores Monedas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_855 
         Caption         =   "Listado de Monedas"
         Enabled         =   0   'False
         HelpContextID   =   1
         Visible         =   0   'False
      End
      Begin VB.Menu Opc_857 
         Caption         =   "Listado de Monedas por Producto"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_860 
         Caption         =   "Tablas Generales"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_870 
         Caption         =   "Instrumentos"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_880 
         Caption         =   "Log Auditoria"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_890 
         Caption         =   "Forma de Pago"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_891 
         Caption         =   "Forma de Pago por Monedas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_892 
         Caption         =   "Listado de Tabla de Desarrollo"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_893 
         Caption         =   "Listado de Plan de Cuentas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_894 
         Caption         =   "Clientes Nuevos"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_898 
         Caption         =   "Brokers"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_899 
         Caption         =   "Operaciones para liquidación en IBS"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu MNU_DCV001 
      Caption         =   "Contratos Vía DCV"
      Begin VB.Menu OPC_DCV001 
         Caption         =   "Generación Contratos"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_DCV002 
         Caption         =   "Carga de Archivos"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Opc_1000 
      Caption         =   "&Auditoria"
      Begin VB.Menu Opc_1001 
         Caption         =   "Informe Log´s"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_1002 
         Caption         =   "Tipo de Usuario"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_1003 
         Caption         =   "Privilegios de Usuario"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu OPC_Tributarios 
      Caption         =   "Tributarios"
      Begin VB.Menu OPC_MntCriterios 
         Caption         =   "Mantención de Criterios"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_MntPatrimonio 
         Caption         =   "Mantención de Ctas Patrimonio"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_MntTributario 
         Caption         =   "Generación de Informe"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu opc_900 
      Caption         =   "&Salir"
   End
End
Attribute VB_Name = "BACSwapParametros"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
 Option Explicit
Dim Sw As Integer
Dim ContSw As Long
Sub DESHABILITA_MENU()
    Dim i%
    ' DESHABILITA TODAS LAS OPCIONES DEL MENU
    For i% = 0 To Me.Controls.Count - 1

        On Error Resume Next

        If TypeOf Me.Controls(i%) Is menu Then
            
            If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" And Me.Controls(i%).Caption <> "&Salir" Then
                
                Me.Controls(i%).Enabled = False
                Me.Controls(i%).Visible = False
            
            End If
       
        End If
    
        If TypeOf Me.Controls(i%) Is CommandButton Then Me.Controls(i%).Enabled = False

    Next i%

End Sub
Sub MENU_TODOHABILITADO()
    
    Dim i%
    ' HABILITA TODAS LAS OPCIONES DEL MENU
    For i% = 0 To Me.Controls.Count - 1
       
        On Error Resume Next
       
        If TypeOf Me.Controls(i%) Is menu Then
            
            If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" And Me.Controls(i%).Caption <> "&Salir" Then
                
                Me.Controls(i%).Enabled = True
                Me.Controls(i%).Visible = True
            
            End If
       
        End If
    
        If TypeOf Me.Controls(i%) Is CommandButton Then Me.Controls(i%).Enabled = True

    Next i%

End Sub

Function RevisarMensajes()

   Dim SQL           As String
   Dim nForms        As Integer
   Dim Datos()

   'Sql = "EXECUTE sp_mdmsgcontarpendientes '" & gsBAC_User & "'"

   'If MISQL.SQL_EXECUTE(SQL) <> 0 Then
   '   Exit Function
   'End If

   'Do While MISQL.SQL_FETCH(Datos()) = 0
   '   If CDBL(Datos(1)) > 0 Then
   '      'MsgBox "Existen Mensajes Nuevos", vbExclamation, "MENSAJES"
   '      BACSwap.Tag = PnlMensaje.Caption
   '      PnlMensaje.Caption = "Tiene Mensajes Nuevos"
   '      PnlMensaje.Tag = "MSG"
   '      PnlMensaje.Refresh

   '      For nForms = 1 To Forms.Count - 1
   '         If Forms(nForms).Tag = "RECIBIR" Then
   '            Call BacRecibir.RecibirLeerTodos
   '            Exit For

   '         End If

    '     Next nForms

      'End If

   'Loop

   'If PnlMensaje.Tag = "MSG" Then
   '   If PnlMensaje.BackColor = &HC0C0C0 Then
  '       PnlMensaje.BackColor = vbWhite
   '
    '  Else
    '     PnlMensaje.BackColor = &HC0C0C0
         
   '   End If
      
 '  End If

End Function


Private Sub clie_Click()
'BacMntCl.Show vbNormal
End Sub


Private Sub ForPag_Click()
   BacMntFormaPago.Show vbNormal
End Sub



Private Sub BacMntGL_Click()
    ' LD1-COR-035-Configuración BAC Corpbanca – Tarea: Generación de Interfaz TVM Digital
      BacMntCuentasGL.Show
    
End Sub

Private Sub CmdOPC_21_Click()
   
   opc_21_Click
   
End Sub

Private Sub CmdOPC_33_Click()

   opc_33_Click

End Sub

Private Sub CmdOPC_551_Click()

   opc_551_Click

End Sub

Private Sub CmdOPC_612_Click()

   opc_612_Click

End Sub

Private Sub CmdOPC_614_Click()

   opc_614_Click

End Sub

Private Sub ManNomMet_Click()
    FRM_MNT_NOM_METODOLOGIAS.Show
End Sub

Private Sub MantUsuarioVolckerRule_Click()
    Frm_Mant_Usu_Cart_VolckerRule.Show
    
End Sub

Private Sub MDIForm_Activate()

   Dim A As Integer
   Dim SQL As String
   Dim cPict As String
   Dim Datos()
    
   Sw = 1
   ContSw = 0
   Screen.MousePointer = 0
   
   'Activa el Login a BacTrader.-
   If Not gbBac_Login Then
      If Not Proc_Carga_Parametros Then
         MsgBox "Error al cargar parámetros", vbCritical, TITSISTEMA
         End
         Exit Sub
      End If
      
      Call DESHABILITA_MENU
    '+++cvegasan 2017.06.05 HOM Ex-Itau funciones de ventana de login
    If giSQL_ConnectionMode <> 3 Then
    '---cvegasan 2017.06.05 HOM Ex-Itau funciones de ventana de login
      Acceso_Usuario.Show 1
    '+++cvegasan 2017.06.05 HOM Ex-Itau funciones de ventana de login
        Else
            If Func_Valida_Login(gsBAC_User) = False Then End
        End If
    '---cvegasan 2017.06.05 HOM Ex-Itau funciones de ventana de login
      If gsBAC_Login Then
      
         Screen.MousePointer = 11
         
         PROC_BUSCA_PRIVILEGIOS_USUARIO BACSwapParametros, "PCA"
        
         If Trim(gsBAC_User$) = "" Then
            
            Unload Me
            Exit Sub
         
         End If
         
         gbBac_Login = True
         Timer1.Enabled = True
         BACSwapParametros.Caption = "BacParametros (" & gsSQL_Server & ")"
      Else
         
         Unload Me
         Exit Sub
                  
      End If
        '+++cvegasan 2017.06.05 HOM Ex-Itau
        Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "BCC" _
                          , "" _
                          , "05" _
                          , "Ingreso al Sistema" _
                          , " " _
                          , " " _
                          , " ")
        '---cvegasan 2017.06.05 HOM Ex-Itau
   End If
             
   CmdOPC_21.Enabled = OPC_21.Enabled
   CmdOPC_33.Enabled = OPC_33.Enabled
   CmdOPC_551.Enabled = OPC_551.Enabled
   CmdOPC_612.Enabled = OPC_612.Enabled
   CmdOPC_614.Enabled = OPC_614.Enabled
   
   Me.PnlEstado.FontSize = 10
   Me.PnlFecha.FontSize = 10
   Me.Pnl_UF.FontSize = 10
   Me.Pnl_DO.FontSize = 10
   Me.PnlUsuario.FontSize = 10

   Me.PnlEstado.Caption = Space(1) + gsBAC_Clien
   Me.PnlFecha.Caption = Format(gsbac_fecp, gsc_FechaDMA)
   Me.Pnl_UF.Caption = "U.F. : " & Format(gsBAC_ValmonUF, FDecimal)
   Me.Pnl_DO.Caption = "D.O. : " & Format(gsBAC_DolarObs, FDecimal)
   Me.PnlUsuario.Caption = gsBAC_User
   FechaSistema = Format(gsbac_fecp, gsc_FechaDMA)
          
             
   Screen.MousePointer = 0
   
   
End Sub

Private Function Proc_Carga_Parametros() As Boolean
   
   Dim Datos()
   
   Proc_Carga_Parametros = False
   
   If Not Bac_Sql_Execute("sp_bacswapparametros_cargaparametros") Then
        
      Exit Function
      
   End If
     
   If Bac_SQL_Fetch(Datos()) Then
   
      gsbac_fecp = Datos(1)
      gsBAC_Clien = Datos(2)
      gsbac_fecAnt = Datos(9)  'PRD-10449
   
   End If
     
   If Not Bac_Sql_Execute("sp_bacswapparametros_traecartera") Then
   
      Exit Function
      
   End If
   
   
   If Not gsc_Parametros.DatosGenerales() Then
   
      Exit Function
      
   End If
      
   Proc_Carga_Parametros = True

End Function

Sub PROC_CARGA_PRIVILEGIOS()

'***************leo************

Dim Datos()
Dim i%
Dim Comando As String


If Trim(gsBAC_User) = "ADMINISTRADOR" Then Exit Sub

' DESHABILITA TODAS LAS OPCIONES DEL MENU

For i% = 0 To Me.Controls.Count - 1

    On Error Resume Next

    If TypeOf Me.Controls(i%) Is menu Then

       If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" Then
          
          Me.Controls(i%).Enabled = True
          Me.Controls(i%).Visible = True
       
       End If

    End If

Next i%

Envia = Array()
AddParam Envia, "T"
AddParam Envia, "PCA"
AddParam Envia, gsBac_Tipo_Usuario

If Not Bac_Sql_Execute("sp_busca_privilegios ", Envia) Then Exit Sub

' BUSCA LAS OPCIONES POR TIPO DE USUARIO

Do While Bac_SQL_Fetch(Datos())

   For i% = 0 To Me.Controls.Count - 1

       On Error Resume Next

       If TypeOf Me.Controls(i%) Is menu Then
       
          If UCase(Trim(Me.Controls(i%).Name)) = UCase(Trim(Datos(1))) Then
             
             Me.Controls(i%).Enabled = True
             Me.Controls(i%).Visible = True
          
          End If
       
       End If

   Next i%

Loop

' BUSCA LAS OPCIONES POR USUARIO

Envia = Array()
AddParam Envia, "U"
AddParam Envia, "PCA"
AddParam Envia, gsBac_Tipo_Usuario

If Not Bac_Sql_Execute("SP_BUSCA_PRIVILEGIOS ", Envia) Then Exit Sub

' BUSCA LAS OPCIONES DEL USUARIO Y LAS HABILITA

Do While Bac_SQL_Fetch(Datos())

   For i% = 0 To Me.Controls.Count - 1

   On Error Resume Next

       If TypeOf Me.Controls(i%) Is menu Then
       
          If UCase(Trim(Me.Controls(i%).Name)) = UCase(Trim(Datos(1))) Then
             
             Me.Controls(i%).Enabled = True
             Me.Controls(i%).Visible = True
          
          End If
       
       End If

   Next i%

Loop

   For i% = 0 To Me.Controls.Count - 1

   On Error Resume Next

       If TypeOf Me.Controls(i%) Is menu Then
       
          If Me.Controls(i%).Enabled = False Then
             
             Me.Controls(i%).Visible = False
          
          End If
       
       End If

   Next i%

End Sub



Private Sub MDIForm_Load()

   Screen.MousePointer = 11
   Call DetectarResolucion(Me, Form1)
   If App.PrevInstance Then
      Screen.MousePointer = 0
      MsgBox "Sistema está cargado en memoria.", vbExclamation, TITSISTEMA
      End
   End If
   
   If Not Valida_Configuracion_Regional() Then
      Screen.MousePointer = 0
      MsgBox "Debe cambiar el formato de fecha como dd/mm/aaaa antes de ejecutar el sistema.", vbCritical, TITSISTEMA
      End
   
   End If
   
   If Not BacInit Then ' Parametros de Inicio.-
      Screen.MousePointer = 0
      End
   End If

gsSQL_Login = Func_Read_INI("usuario", "usuario", App.Path & "\Bac-Sistemas.INI")
gsSQL_Password = Func_Read_INI("usuario", "password", App.Path & "\Bac-Sistemas.INI")
SwConeccion = "DSN=SQL_BACPARAM;UID="
SwConeccion = SwConeccion & gsSQL_Login
SwConeccion = SwConeccion & ";PWD="
SwConeccion = SwConeccion & gsSQL_Password
SwConeccion = SwConeccion & ";DSQ=BACPARAMsuda"
   
   If Not BAC_Login(gsSQL_Login, gsSQL_Password) Then
      Screen.MousePointer = 0
      MsgBox "Problemas de Comunicación con el Servidor SQL", vbCritical, TITSISTEMA
      End
   End If
   
   If Trim$(Mid$(Command, 1, 11)) = "GENERA_MENU" Then
      PROC_GENERA_MENU Mid(Command, 13, 3)
      Call MISQL.SQL_Close
      Screen.MousePointer = 0
      End
   End If

   BACSwapParametros.WindowState = 2
   Screen.MousePointer = 0

End Sub

Sub PROC_BUSCA_PRIVILEGIOS_USUARIO(forma_menu As Form, Entidad As String)
Dim i%
Dim Datos()

If Trim(gsBAC_User) = "ADMINISTRA" Then
   
   Call MENU_TODOHABILITADO
   Exit Sub

End If


' BUSCA LAS OPCIONES DEL USUARIO Y LAS HABILITA

Envia = Array()
AddParam Envia, "T"
AddParam Envia, Entidad
AddParam Envia, gsBac_Tipo_Usuario

If Not Bac_Sql_Execute("SP_BUSCA_PRIVILEGIOS ", Envia) Then Exit Sub

Do While Bac_SQL_Fetch(Datos())

   For i% = 0 To forma_menu.Controls.Count - 1

   On Error Resume Next

       If TypeOf forma_menu.Controls(i%) Is menu Then
       
          If UCase(Trim(forma_menu.Controls(i%).Name)) = UCase(Trim(Datos(1))) Then
             
             forma_menu.Controls(i%).Enabled = True
             forma_menu.Controls(i%).Visible = True
          
          End If
       
       End If

   Next i%
Loop

Envia = Array()
AddParam Envia, "U"
AddParam Envia, Entidad
AddParam Envia, gsUsuario

If Not Bac_Sql_Execute("SP_BUSCA_PRIVILEGIOS ", Envia) Then Exit Sub

Do While Bac_SQL_Fetch(Datos())
      
   For i% = 0 To forma_menu.Controls.Count - 1
   
       On Error Resume Next
       
       If TypeOf forma_menu.Controls(i%) Is menu Then
                             
          If UCase(Trim(forma_menu.Controls(i%).Name)) = UCase(Trim(Datos(1))) Then
             
             If Trim(Datos(2)) = "N" Then
                
                forma_menu.Controls(i%).Enabled = False
                forma_menu.Controls(i%).Visible = False
             
             Else
                
                forma_menu.Controls(i%).Enabled = True
                forma_menu.Controls(i%).Visible = True
             
             End If
          
          End If
       
       End If

   Next i%
Loop

'Call Proc_Busca_privilegios_Especiales

End Sub

'Sub PROC_GENERA_MENU(forma_menu As Form, nombre_archivo As String)
'Dim i%
'Open nombre_archivo For Output As #1
'
'For i% = 0 To forma_menu.Controls.Count - 1
'
'    On Error Resume Next
'
'    If TypeOf forma_menu.Controls(i%) Is Menu Then
'
'       If forma_menu.Controls(i%).Caption <> "-" And forma_menu.Controls(i%).Caption <> "?" Then
'
'          Print #1, RELLENA_STRING(Format(forma_menu.Controls(i%).HelpContextID, "0") + forma_menu.Controls(i%).Caption, "D", 70) + RELLENA_STRING(forma_menu.Controls(i%).Name, "D", 20)
'
'       End If
'
'    End If
'
'Next i%
'
'Close #1
'
'End Sub

Sub PROC_GENERA_MENU(Entidad As String)
   
   Dim SQL         As String
   Dim indice      As Integer: indice = 1
   Dim Primera_Vez As String: Primera_Vez = "S"
   Dim i%

   For i% = 0 To Me.Controls.Count - 1
   
       If TypeOf Me.Controls(i%) Is menu Then
          
         If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" And Me.Controls(i%).Visible And Me.Controls(i%).Caption <> "Salir" Then
            
            Envia = Array( _
                           Primera_Vez, _
                           "PCA", _
                           Str(indice), _
                           Me.Controls(i%).Caption, _
                           Me.Controls(i%).Name, _
                           Me.Controls(i%).HelpContextID _
                         )
            
            indice = indice + 1
             
            Debug.Print Me.Controls(i%).Caption
            If Not Bac_Sql_Execute("SP_CARGA_GEN_MENU", Envia) Then
            
               Exit Sub
            
            End If
             
            Primera_Vez = "N"
         
         End If
          
       End If
   
   Next i%

End Sub



Private Function BAC_Login(sUser$, sPWD$) As Boolean
  

   BAC_Login = False
    '+++cvegasan 2017.06.05 HOM Ex-Itau
    If giSQL_ConnectionMode = 3 Then
      gsBAC_User = UCase(Trim(Environ("username")))
      gsBAC_Term = Trim(Environ("userdomain"))
      MISQL.Login = gsBAC_User
      MISQL.Password = ""
    End If
    '---cvegasan 2017.06.05 HOM Ex-Itau
   MISQL.ServerName = gsSQL_Server$
   MISQL.HostName = gsBAC_Term
   MISQL.Application = "PARAMETROS"
   MISQL.ConnectionMode = giSQL_ConnectionMode
   MISQL.DatabaseName = gsSQL_Database
   gsBac_IP = BACSwapParametros.NomObjWinIP.LocalIP
 

   If giSQL_ConnectionMode = 1 Then
      MISQL.Login = gsSQL_Login$
      MISQL.Password = gsSQL_Password$
        gsBAC_User = UCase(Trim(Environ("username")))
        gsBAC_Term = Trim(Environ("ComputerName"))
   ElseIf giSQL_ConnectionMode = 2 Then
      MISQL.Login = sUser$
      MISQL.Password = sPWD$
 
   End If
 
   MISQL.LoginTimeout = giSQL_LoginTimeOut
   MISQL.QueryTimeout = giSQL_QueryTimeOut
 
   If MISQL.SQL_Coneccion() = False Then
       BAC_Login = False
       Exit Function
 
   End If

   BAC_Login = True

End Function

Private Sub MDIForm_QueryUnload(Cancel As Integer, UnloadMode As Integer)
   If gsBAC_Login Then
      If MsgBox("¿ Seguro que desea Salir ?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
         Call Salida_Usuario
         Unload Me
         End
      Else
         Cancel = True
      End If
   Else
      End
   End If
End Sub

Private Sub Vbsql1_Error(SqlConn As Integer, Severity As Integer, ErrorNum As Integer, ErrorStr As String, RetCode As Integer)

  BacLogFile "VBSQL = " & SqlConn & "-" & Severity & "-" & ErrorNum & "-" & ErrorStr & "-" & RetCode

End Sub

Private Sub VBSQL1_Message(SqlConn As Integer, Message As Long, State As Integer, Severity As Integer, MsgStr As String)
'MsgBox MsgStr
End Sub


Private Sub moneda_Click()
'BacMntMn.Show vbNormal
End Sub

Private Sub moned_Click()

'    Screen.MousePointer = 11
'    Centra_Form BacMntMn
'    BacMntMn.Show vbNormal
'    Screen.MousePointer = 0
End Sub


Private Sub MDIForm_Unload(Cancel As Integer)
        Unload Me
End Sub

Private Sub MnuConsultaOp_Click()

End Sub

Private Sub Mnt_GarantiasConstituidas_Click()

    Call FRM_MNT_GARANTIA.Show
End Sub

Private Sub Mnt_GarantiasOtrogadas_Click()

    FRM_MNT_GARANTIAS_OTORGADAS.Show
    
End Sub

Private Sub mntAplican_Click()
    FRM_MNT_RELAC_SISPROD.Show
End Sub

Private Sub mntAplicanClas_Click()
    FRM_MNT_RELAC_CLASCTE.Show
End Sub

Private Sub op_InterGtiaConst_Click()
    FRM_INTERCAMBIA_GTIASC.Show
End Sub

Private Sub op_InterGtiaOtorg_Click()
    FRM_INTERCAMBIA_GTIASO.Show
End Sub

Private Sub modoOpCPT_Click()
    frmModoOpCPT.Show
End Sub

Private Sub opAnulaGtias_Click()
    FRM_ANULA_GARANTIA.Show
End Sub

Private Sub Opc_00620_Click()
  'Mantenedor de Tasas por Moneda'
   FRM_MNT_TASAS_MONEDA.Show
End Sub

Private Sub Opc_00621_Click()
   BacMntTb.Show
  ' BacMntTablasGenerales.Show
End Sub

Private Sub Opc_00622_Click()
   
   FRM_MNT_SERSUB.Show
   
End Sub

Private Sub Opc_006221_Click()
   FRM_MNT_SERSUB.Show
End Sub

Private Sub Opc_006222_Click()
   FRM_MNT_FACTORVCTORES.Show
End Sub

Private Sub Opc_006223_Click()
   FRM_MNT_SERIES_SUB_INV.Show
End Sub


Private Sub Opc_006225_Click()
   Call RIESGOS_NORMATIVOS.Show
End Sub
Private Sub Opc_006226_Click()
   Call RIESGOS_PRODUCTO.Show
End Sub
Private Sub Opc_006227_Click()
   Call MATRIZ_RIESGO_NORMATIVO.Show
End Sub


Private Sub Opc_0630_Click()
   '--> 24-02-2009. --Referencias de Mercado
   FRM_MNT_REFTC.Show
End Sub
Private Sub Opc_0631_Click()
   '--> 24-02-2009. --Referencias de Mercado por Producto
   'FRM_MNT_REFTC_PRODUCTO.Show
   FRM_MNT_REFTC_SISTEMA_PRODUCTO.Show
End Sub


Private Sub Opc_0638_Click()
  FRM_MNT_CURVAS_OPCIONES.Show
End Sub

Private Sub Opc_0633_Click()
    FRM_MANTCLAUSULAS.Show
End Sub

Private Sub Opc_0639_Click()
   BacParametros.Show
End Sub

Private Sub Opc_1001_Click()
 FrmAuditoria.Show
End Sub

Private Sub Opc_1002_Click()
    BacTipoUsuario.Show
End Sub

Private Sub Opc_1003_Click()
    BacPrivilegioUsuarios.Show
End Sub

Private Sub Opc_1004_Click()
    BacControlWindows 100
    
    Screen.MousePointer = 11
    Centra_Form FRM_Facility
    FRM_Facility.Show
    Screen.MousePointer = 0

End Sub

Private Sub Opc_1005_Click()

 BacControlWindows 100
    
    Screen.MousePointer = 11
    Centra_Form FRM_Familia
    FRM_Familia.Show
    Screen.MousePointer = 0



End Sub

Private Sub opc_21_Click()
'BacMntCl.Show vbNormal
 '- Cliente-'
 
    Screen.MousePointer = 11
    Centra_Form BacMntClie
    BacMntClie.Show vbNormal '------------- nuevo
    
    'BacMntCl.Show vbNormal '-----------antiguo
    Screen.MousePointer = 0
   
End Sub

Private Sub opc_22_Click()

'- Operadores -'

     BacControlWindows 100
    
     Screen.MousePointer = 11
     Centra_Form BacMntOperador
     BacMntOperador.Show vbNormal
     Screen.MousePointer = 0
    
End Sub

Private Sub opc_23_Click()

'- Apoderados -'
   
    BacControlWindows 100
    
    Screen.MousePointer = 11
    Centra_Form BacMntApoderado
    BacMntApoderado.Show vbNormal
    Screen.MousePointer = 0
    
End Sub

Private Sub OPC_24_Click()

   Mant_TipoUsuario.Show

End Sub

Private Sub opc_31_Click()

    Screen.MousePointer = 11
    Centra_Form BacMntMn
    BacMntMn.Show vbNormal
    Screen.MousePointer = 0
     
End Sub

Private Sub opc_32_Click()

'- Monedas Por Producto -'

     BacControlWindows 100

     Screen.MousePointer = 11
     Centra_Form BacMntMP
     BacMntMP.Show vbNormal
     Screen.MousePointer = 0
     
End Sub

Private Sub opc_33_Click()
    On Error Resume Next
    BacMntVm.Show
    On Error GoTo 0
End Sub

Private Sub opc_34_Click()
 
 ' Guion '

End Sub

Private Sub opc_35_Click()

  '- Paridades y Libor -'
  
     'BacMntParLib.Show vbNormal
     
End Sub

Private Sub opc_41_Click()

 '- Formas de Pago -'
  
      BacControlWindows 100

      Screen.MousePointer = 11
      Centra_Form BacMntFormaPago
      BacMntFormaPago.Show vbNormal
      Screen.MousePointer = 0
    
End Sub

Private Sub opc_42_Click()

'- Forma de Pago por Moneda -'

    BacControlWindows 100
    mon = 1000
    Screen.MousePointer = 11
    Centra_Form BacMntMF
    BacMntMF.Show vbNormal
    
End Sub
Private Sub opc_551_Click()

    BacControlWindows 100
       
    Screen.MousePointer = 11
    Centra_Form Perfil_contable
    Perfil_contable.Show
    Screen.MousePointer = 0
    
    
End Sub

Private Sub opc_553_Click()
    
    BacControlWindows 100
    
    Screen.MousePointer = 11
    Centra_Form bacMntCampos
    bacMntCampos.Show
    Screen.MousePointer = 0


End Sub
Private Sub opc_554_Click()
    
    BacControlWindows 100
    
    
    Screen.MousePointer = 11
    Centra_Form Plan_Cuentas
    Plan_Cuentas.Show
    Screen.MousePointer = 0
    
End Sub
Private Sub opc_61_Click()

'- Feriados -'
 
     BacControlWindows 100
    
     Screen.MousePointer = 11
     Centra_Form BacMntFe
     BacMntFe.Show vbNormal
     Screen.MousePointer = 0
   
End Sub


Private Sub opc_80_Click()
 
        '- Salir -'
 
            Unload Me
End Sub

Private Sub opc_611_Click()
     BacMntEm.Show vbNormal
End Sub

Private Sub opc_612_Click()
    BacControlWindows 100
    Screen.MousePointer = 11
    BacMntSe.Show vbNormal
    Screen.MousePointer = 0
    
End Sub

Private Sub opc_614_Click()
    BacMntFe.Show
    
End Sub

Private Sub opc_615_Click()
    BacMntFa.Show
    
End Sub

Private Sub opc_616_Click()
    Frm_Porc_Variacion.Show
    
End Sub

Private Sub opc_617_Click()
mntmanciu.Show
End Sub

Private Sub opc_618_Click()
On Error Resume Next
ManCom.Show
On Error GoTo 0
End Sub

Private Sub opc_619_Click()
    BacMntCateg.Show
    
End Sub

Private Sub opc_620_Click()
'BacInfSe.Show
End Sub

Private Sub opc_651_Click()
    BacMntOma.Show
    
End Sub

Private Sub opc_652_Click()
    BacMntComercioConcepto.Show
    
End Sub

Private Sub opc_653_Click()
    bacMntPlanillaOperacion.Show
    
End Sub

Private Sub opc_660_Click()
    BacMntGlosa.Show
    
End Sub

Private Sub opc_670_Click()
    BacControlWindows 100
    Screen.MousePointer = 11
    BacIniValDef.Show
    Screen.MousePointer = 0
    
End Sub

Private Sub OPC_675_Click()
    Frm_Arb_Vct_Fwd.Show
End Sub

Private Sub OPC_676_Click()
   BacMntCargOpExt.Show
End Sub

Private Sub opc_680_Click()
    BacMntCr.Show
    
End Sub

Private Sub opc_690_Click()
    BacMntVe.Show
    
End Sub

Private Sub opc_700_Click()
   BacGenUF.Show

End Sub

Private Sub opc_710_Click()
   BacMntPe.Show

End Sub

Private Sub opc_720_Click()
   BacTasasMTM.Show

End Sub

Private Sub opc_730_Click()

   BacMntClientesSinacofi.Show

End Sub

Private Sub opc_740_Click()
   BacGenIV.Show

End Sub

Private Sub opc_750_Click()
   Baccorrespon.Show

End Sub




Private Sub opc_760_Click()

    giAceptar = False
   Cambio_Password.Tag = "C"
    
   If Trim(gsBAC_User) = "ADMINISTRA" Then
      MsgBox "Clave de Administrador no puede ser cambiada desde el sistema", vbOKOnly + vbExclamation
     Exit Sub
   Else
      oBligacion = False
      Call Cambio_Password.Show(vbModal)
       'Centra_Form Cambio_Clave
       'Cambio_Clave.Show 1
   End If
End Sub

Private Sub opc_780_Click()
    TablaLocalidades.Show
    
End Sub

Private Sub opc_790_Click()
    Baccorrespon2.Show
'   Control_Bloq_Usuarios.Show

End Sub

Private Sub opc_791_Click()
    Limites_tasas.Show
    
End Sub

Private Sub opc_792_Click()
        BacMntIp.Show
        
End Sub

Private Sub opc_793_Click()
        BacOmadelSuda.Show
        
End Sub

Private Sub opc_794_Click()
    Frm_Mnt_Relaciones.Show
End Sub

Private Sub opc_795_Click()
    
    Frm_Relacion_Producto_Libro.Show
    
End Sub


Private Sub opc_796_Click()

    Frm_Relacion_Libro_Cartera.Show

End Sub

'''RQ3162
Private Sub opc_797_Click()
    Frm_Mant_Usu_Cart_Financiera.Show 'Cartera Financiera
End Sub

Private Sub opc_798_Click()
    Frm_Mant_Usu_Lib_CartN_SubcartN.Show ' subCartera normativa
End Sub

Private Sub opc_799_Click()
    Frm_Mant_Usu_Porfolio.Show ' mantencion de Portafolio
End Sub

'''RQ3162


Private Sub OPC_810_Click()
' ============================================= '
' Opción de informe , Cliente
' ============================================= '
   
On Error GoTo Control:

   Call limpiar_cristal
   Screen.MousePointer = vbHourglass
   BACSwapParametros.BACParam.Destination = crptToWindow
   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacClientes.rpt"
   BACSwapParametros.BACParam.WindowTitle = "INFORME DE CLIENTES"
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.WindowState = crptMaximized
   BACSwapParametros.BACParam.Action = 1
   Screen.MousePointer = vbDefault

Exit Sub

Control:

    MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
    Screen.MousePointer = 0

End Sub

Private Sub OPC_820_Click()
' ============================================= '
' Opción de informe , Emisores
' ============================================= '
On Error GoTo Control:

   Call limpiar_cristal
   Screen.MousePointer = vbHourglass
   BACSwapParametros.BACParam.Destination = crptToWindow
   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacEmisores.rpt "
   BACSwapParametros.BACParam.WindowTitle = "INFORME DE EMISORES"
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.WindowState = crptMaximized
   BACSwapParametros.BACParam.Action = 1
   Screen.MousePointer = vbDefault
    
Exit Sub

Control:

    MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
    Screen.MousePointer = 0
    
    
End Sub

Private Sub OPC_830_Click()
' ============================================= '
' Opción de informe , Carteras
' ============================================= '
'    On Error GoTo Control:
'
'       Call limpiar_cristal
'       Screen.MousePointer = vbHourglass
'       BACSwapParametros.BACParam.Destination = crptToWindow
'       BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "CARTERAS.RPT"
'       BACSwapParametros.BACParam.WindowTitle = "INFORME DE ENTIDADES"
'       BACSwapParametros.BACParam.Connect = SwConeccion
'       BACSwapParametros.BACParam.WindowState = crptMaximized
'       BACSwapParametros.BACParam.Action = 1
'       Screen.MousePointer = vbDefault
'
'    Exit Sub
'
'Control:
'
'        MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
'        Screen.MousePointer = 0

End Sub

Private Sub OPC_840_Click()

On Error GoTo Control:

Call limpiar_cristal
   Screen.MousePointer = vbHourglass
   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacSeries.RPT"
   BACSwapParametros.BACParam.WindowTitle = "LISTADO DE SERIES"
   BACSwapParametros.BACParam.Destination = 0
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.WindowState = crptMaximized
   BACSwapParametros.BACParam.Action = 1
   Screen.MousePointer = vbDefault

Exit Sub

Control:

    MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
    Screen.MousePointer = 0

End Sub

Private Sub OPC_850_Click()
    BacFechas.Tag = "VALMON"
    BacFechas.Caption = "Ingreso de fechas para valores de moneda"
    BacFechas.Show
    
End Sub

Private Sub Opc_855_Click()

Dim TitRpt As String

On Error GoTo Control:

   Call limpiar_cristal
   Screen.MousePointer = vbHourglass
   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacMonedas.RPT"
   BACSwapParametros.BACParam.WindowTitle = "LISTADO DE MONEDAS"
   BACSwapParametros.BACParam.Destination = 0
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.WindowState = crptMaximized
   BACSwapParametros.BACParam.Action = 1
   Screen.MousePointer = vbDefault

Exit Sub

Control:

    MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
    Screen.MousePointer = 0

End Sub

Private Sub Opc_857_Click()

   Call limpiar_cristal
   
   On Error GoTo Control:
   
   Screen.MousePointer = vbHourglass
   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacMonedaXProducto.rpt"
   BACSwapParametros.BACParam.WindowTitle = "LISTADO DE MONEDAS POR PRODUCTOS"
   BACSwapParametros.BACParam.Destination = 0
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.WindowState = crptMaximized
   BACSwapParametros.BACParam.Action = 1
   Screen.MousePointer = vbDefault

Exit Sub

Control:

    MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
    Screen.MousePointer = 0

End Sub

Private Sub OPC_860_Click()
   Dim TitRpt As String
   
   On Error GoTo Control:
   
   Call limpiar_cristal
   Screen.MousePointer = vbHourglass
   TitRpt = "LISTADO DE TABLAS GENERALES"
   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacTablasGenerales.RPT"
   BACSwapParametros.BACParam.WindowTitle = "LISTADO DE TABLAS GENERALES"
   BACSwapParametros.BACParam.Destination = 0
   'BACSwapParametros.BACParam.Formulas(0) = "tit='" & TitRpt & "'"
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.WindowState = crptMaximized
   BACSwapParametros.BACParam.Action = 1
   Screen.MousePointer = vbDefault
    
   Exit Sub

Control:

    MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
    Screen.MousePointer = 0
 
End Sub

Private Sub OPC_870_Click()
   Dim TitRpt As String
   
   On Error GoTo Control:
   
   Call limpiar_cristal
   Screen.MousePointer = vbHourglass
   TitRpt = "INFORME DE FAMILIAS"
   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacInstrumentos.rpt"
   BACSwapParametros.BACParam.Destination = 0
   BACSwapParametros.BACParam.Formulas(0) = "tit='" & TitRpt & "'"
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.WindowState = crptMaximized
   BACSwapParametros.BACParam.Action = 1
   Screen.MousePointer = vbDefault
   
   Exit Sub

Control:

    MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
    Screen.MousePointer = 0

End Sub

Private Sub OPC_880_Click()
    frmLogAuditoria.Show
End Sub

Private Sub Opc_890_Click()

' ============================================= '
' Opción de informe , Forma de Pago
' ============================================= '
   
   Call limpiar_cristal
   
   On Error GoTo Control:
   
   Screen.MousePointer = vbHourglass
   BACSwapParametros.BACParam.Destination = crptToWindow
   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacFormasdePago.rpt"
   BACSwapParametros.BACParam.WindowTitle = "LISTADO DE FORMA DE PAGO"
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.WindowState = crptMaximized
   BACSwapParametros.BACParam.Action = 1
   Screen.MousePointer = vbDefault


Exit Sub

Control:

    MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
    Screen.MousePointer = 0

End Sub

Private Sub Opc_891_Click()

    On Error GoTo Control:
    
   Call limpiar_cristal
   Screen.MousePointer = vbHourglass
   BACSwapParametros.BACParam.Destination = crptToWindow
   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacFormasdePagoXMoneda.rpt"
   BACSwapParametros.BACParam.WindowTitle = "LISTADO DE FORMA DE PAGO POR MONEDAS"
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.WindowState = crptMaximized
   BACSwapParametros.BACParam.Action = 1
   Screen.MousePointer = vbDefault

Exit Sub

Control:

    MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
    Screen.MousePointer = 0

End Sub

Private Sub Opc_892_Click()
        Bac_Tabla_Desarrollo.Show
End Sub

Private Sub Opc_893_Click()

    On Error GoTo Control:
    
   Call limpiar_cristal
   Screen.MousePointer = vbHourglass
   BACSwapParametros.BACParam.Destination = crptToWindow
   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacCuentasContables.rpt"
   BACSwapParametros.BACParam.WindowTitle = "LISTADO DE PLAN DE CUENTAS"
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.WindowState = crptMaximized
   BACSwapParametros.BACParam.Action = 1
   Screen.MousePointer = vbDefault

Exit Sub

Control:

    MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
    Screen.MousePointer = 0


End Sub

Private Sub Opc_894_Click()
On Error GoTo Control:

    Call limpiar_cristal
    Screen.MousePointer = vbHourglass
    BACSwapParametros.BACParam.Destination = crptToWindow
    BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacClientes_del_Dia.rpt"
    BACSwapParametros.BACParam.WindowTitle = "INFORME DE CLIENTES NUEVOS"
    BACSwapParametros.BACParam.Connect = SwConeccion
    BACSwapParametros.BACParam.WindowState = crptMaximized
    BACSwapParametros.BACParam.Action = 1
    Screen.MousePointer = vbDefault

Exit Sub

Control:

    MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
    Screen.MousePointer = 0

End Sub

Private Sub opc_895_Click()
   BacGenMensaje.Show
End Sub

Private Sub opc_896_Click()
   FRM_MNT_CANAL_FPAGO.Show
End Sub

Private Sub Opc_898_Click()
' ============================================= '
' Opción de informe , Brokers
' ============================================= '
   
On Error GoTo Control:

   Call limpiar_cristal
   Screen.MousePointer = vbHourglass
   BACSwapParametros.BACParam.Destination = crptToWindow
   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacInformeBrokers.rpt"
   BACSwapParametros.BACParam.WindowTitle = "INFORME DE BROKERS"
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.WindowState = crptMaximized
   BACSwapParametros.BACParam.Action = 1
   Screen.MousePointer = vbDefault

Exit Sub

Control:

    MsgBox "Problemas al generar Listado. " & Err.Description & ", " & Err.Number, vbCritical, "BACPARAMETROS"
    Screen.MousePointer = 0

End Sub

Private Sub Opc_899_Click()
   On Error GoTo errorimpresion

   ' Informe de Operaciones para liberacion de pagos automáticos en IBS (Motor de Pagos as400).-
   
   Call limpiar_cristal
   Screen.MousePointer = vbHourglass
   
   BACSwapParametros.BACParam.WindowState = crptMaximized
   BACSwapParametros.BACParam.Destination = crptToWindow
   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "Informe_Liquidaciones_DVPLBTR.rpt"
                              ' --> Store Procedure : dbo.SP_INFORME_MOTOR_PAGOS
   BACSwapParametros.BACParam.WindowTitle = "Informe de Operaciones para IBS."
   BACSwapParametros.BACParam.StoredProcParam(0) = gsBAC_User & " "
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.Action = 1
   
   Screen.MousePointer = vbDefault

Exit Sub
errorimpresion:
   Screen.MousePointer = 0
   MsgBox "Problemas al generar informe. " & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
End Sub

Private Sub opc_897_Click()
  'Mantenedor de Descrepancias
  'Agregado el día : Miercoles 25 de Mayo del 2005 a las 13:03 Hras.
  'Programador     : Referencia: [Req. N° G1.20 (Control Discrepancias)]
   FRM_MNT_Discrepancias.Show
   
End Sub

Private Sub opc_900_Click()
   Unload Me
  
'  If gsBAC_Login Then
'     salir = " "
'     salir = MsgBox("Seguro que desea Salir", vbQuestion + vbYesNo, TITSISTEMA)
'
'    If salir = 6 Then
'       Call Salida_Usuario
'       End
'    End If
'
' End If
    
End Sub

Sub Salida_Usuario()
Dim Datos()
Dim Terminales(10)
Dim Usuarios(10)
Dim Sistemas(10)
Dim TMP, TMP2, Terminal, m As String
Dim i1, j As Integer
On Error GoTo ErrorF:

    Envia = Array()
    AddParam Envia, gsUsuario
    AddParam Envia, gsTerminal
    AddParam Envia, gsSistema

    i1 = 1

    If Bac_Sql_Execute("SP_CONTROL_BLOQ_USUARIOS_SALIR ", Envia) Then

        Do While Bac_SQL_Fetch(Datos())

            If Datos(1) <> "ERROR" Then
                
            End If

        Loop

    End If


ErrorF:
    m = Bloquea_Usuario(False, gsUsuario)

End Sub

'Private Sub Timer1_Timer()
'
'    Call Estado_Usuario
'
'End Sub


Sub Estado_Usuario()
Dim Datos()
Dim Estado As String
Dim m As String
On Error GoTo fin:

          
    Envia = Array()
    AddParam Envia, gsUsuarioReal
    AddParam Envia, gsSistema
    AddParam Envia, gsTerminal
  
    If Bac_Sql_Execute("SP_CONTROL_BLOQ_USUARIOS_VERIFICAR_TERMINAL ", Envia) Then
        
        Do While Bac_SQL_Fetch(Datos())
        
           ' If datos(2) <> gsTerminal Then gsTerminal = datos(2)
         
        Loop
        
    End If
    Envia = Array()
    AddParam Envia, gsUsuario
    AddParam Envia, gsSistema
    
  
    If Bac_Sql_Execute("SP_CONTROL_BLOQ_USUARIOS_ESTADO_USUARIO ", Envia) Then
        
        Do While Bac_SQL_Fetch(Datos())
        
            Estado = Datos(1)
        
        Loop
        
    End If

    If Estado = "S" And Sw = 1 Then
    
        Call DESHABILITA_MENU
        Call Salida_Usuario
        MsgBox "Usuario Bloqueado", vbExclamation + vbOKOnly, TITSISTEMA
        m = Bloquea_Usuario(False, gsUsuario)
        Sw = 0
        'Unload Me
        End
    
    End If

'    If SW = 0 And ContSw < 35 Then
'
'        SendKeys "^{F4}"
'        ContSw = ContSw + 1
'
'
'    End If
'
    If Estado = "N" And Sw = 0 Then
    
        
        MsgBox "Usuario Desbloqueado", vbExclamation + vbOKOnly, TITSISTEMA
        
        PROC_BUSCA_PRIVILEGIOS_USUARIO BACSwapParametros, "PCA"
'        Call MENU_TODOHABILITADO
        Sw = 1
        
    End If

fin:
End Sub


Sub Proc_Busca_privilegios_Especiales()
Dim Datos()
Dim i As Integer
Dim Sw As Integer

    Envia = Array()
    AddParam Envia, gsUsuario
    AddParam Envia, "PCA"
    Sw = 0
    
    If Bac_Sql_Execute("Sp_BacSwapParametros_Busca_Priv_Especiales ", Envia) Then
    
        
        
        Do While Bac_SQL_Fetch(Datos())
        
           If Datos(1) = "NO EXISTE" Then Exit Sub
                           
              If Sw = 0 Then
                
                 'DESHABILITA_MENU
                 Sw = 1
                
              End If
           
           For i% = 0 To BACSwapParametros.Controls.Count - 1
        
               On Error Resume Next
        
               If TypeOf BACSwapParametros.Controls(i%) Is menu Then
               
                  If UCase(Trim(BACSwapParametros.Controls(i%).Name)) = UCase(Trim(Datos(1))) Then
                     
                     BACSwapParametros.Controls(i%).Enabled = True
                     BACSwapParametros.Controls(i%).Visible = True
                  
                  End If
               
               End If
        
           Next i%
        
        Loop
        
    End If


End Sub

Private Sub OPC_901_Click()
    BacMntTasasMonedas.Show
End Sub

Private Sub OPC_902_Click()
 'FRM_MNT_TIPOS_CAMBIO_CONTABLE.Show
  FRM_MNT_TC_CONTABLE.Show
End Sub

Private Sub opc_AsocGtiaOp_Click()
    FRM_ASOCIA_GTIAS_OPER.Show
End Sub

Private Sub OPC_CARGA_PREST_IBS_Click()
     FRM_CARGA_PRESTAMOS_IBS.Show
End Sub

Private Sub Opc_ConfiguracionMails_Click()

   FRM_MNT_EMAILS.Show

End Sub

Private Sub OPC_903_Click()
    FRM_MNT_PRIORIDAD_MONEDAS.Show
End Sub

Private Sub Opc_ContDinaDerivado_Click()

   Frm_Contratos_Dinamicos_Derivados.Show

End Sub

Private Sub Opc_CurvasProd_Click()
   FRM_CURVAS_PROD.Show
End Sub

Private Sub OPC_DCV001_Click()
   'Generacion de Contratos vía DCV
   Call FRM_MNT_ENVIO_DCV.Show
End Sub

Private Sub OPC_DCV002_Click()
   'Carga de Archivos vía DCV
   Call FRM_MNT_DCV_NOTIFICACION.Show
End Sub

Private Sub Opc_DefCurvas_Click()
   FRM_MNT_CURVAS.Show
End Sub

Private Sub Opc_EnvOpSpot_Click()
   FRM_CONSULTA_MERCADO.Show
End Sub

Private Sub opc_inf_gtias_Click()
    FRM_INF_GARANTIAS.Show
End Sub

Private Sub Opc_IngPondTasa_Click()
   FRM_ING_TASASPOND.Show
End Sub

Private Sub Opc_IngresoCurvas_Click()
   FRM_MNT_VALORES_CURVAS.Show
End Sub

Private Sub OPC_MAN_INTER_Click()
    FRM_MNT_FORMATO_INTERFACES.Show
End Sub

Private Sub OPC_Mant_Feriados_Click()
    BacMntFeriados.Show
End Sub

Private Sub OPC_Mant_Logos_Click()
  frm_Mnt_Contratos_Reportes.Show
 
End Sub

Private Sub Opc_MantHairCutInst_Click()
    FRM_MNT_HAIRCUT.Show
End Sub

'Private Sub Opc_Mant_Usu_Porfolio_Click()
'    Frm_Mant_Usu_Porfolio.Show
'End Sub

Private Sub Opc_MantMargenInst_Click()
    FRM_MNT_MARGEN_INST.Show
End Sub

Private Sub OPC_DerivCred_Click()
   '--> Se agrego opción para poder asociar un credito a un derivado.
   Call FRM_MNT_IBS_BAC.Show
End Sub

Private Sub OPC_MAIL_USR_Click()
   '--> Se agrego opción para Ingreso de Roles.
   Call FRM_MNT_ROLES.Show
End Sub

Private Sub OPC_CONFIG_MENSAJE_Click()
   '--> Se agrego opción para Parametrizar Mensajes a un grupo de usuarios.
   Call FRM_MNT_CONFIG_MENSAJES.Show
End Sub

Private Sub OPC_CONS_DERCRE_Click()
   '--> Se agrego opción para Consultar Derivados asocuiados a créditos.
   Call FRM_CON_DERCRE.Show
End Sub

Private Sub Opc_MantOriOpSpot_Click()
'--- Homologado el 05-09-2008 ---
    FRM_MNT_OriOpeSpot.Show
'--- Homologado el 05-09-2008 ---
End Sub

Private Sub opt_999_Click()
    FRM_MANTCLAUSULAS.Show
End Sub

Private Sub Opc_MantTasasRefInst_Click()
    FRM_MNT_TASA_REFERENCIAL.Show
End Sub

Private Sub OPC_VALIDA_INTERFAZ_Click()
    FRM_MNT_VALIDA_INTERFAZ.Show
End Sub

Private Sub OPC_Valores_Defecto_Click()
    BacValoresPorDefecto.Show
End Sub

Private Sub opc_VenctoGar_Click()
    Inf_Vencimiento_Garantias.Show
End Sub

Private Sub opcBloqueoCltes_Click()
   FRM_MNT_BLOQUEOCLIENTES.Show
End Sub

Private Sub opcDesvincular_Click()
    FRM_DESVINCULA_OPER.Show
End Sub

Private Sub opMotBloq_Click()
    FRM_MNT_MOTIVOBLOQUEOS.Show
End Sub

Private Sub opt_Clasificacion_Riesgo_Click()
    FRM_CLASIFICACION_AGENCIAS.Show
End Sub

Private Sub SengComer_Click()
    FRM_MNT_SEGMENTOS_COM.Show
End Sub

Private Sub tasa_pais_Click()
    FRM_MNT_TASA_PAIS.Show
End Sub

Private Sub Timer1_Timer()

    Call Estado_Usuario
    Call Ver_Estado_Usuario
    
End Sub

Sub Ver_Estado_Usuario()
Dim Datos()
Dim m As String
   
    
    If Bac_Sql_Execute("SP_CONTROL_BLOQ_USUARIOS_LEE_ACTIVOS ") Then
    
        Do While Bac_SQL_Fetch(Datos())
                    
            If Datos(1) = gsUsuario And Left(Datos(3), 1) = "N" And Right(Datos(3), 1) = Right(gsTerminal, 1) Then  '
        
                Call DESHABILITA_MENU
                Salida_Usuario
                MsgBox "Usuario Bloqueado", vbExclamation + vbOKOnly, TITSISTEMA
                m = Bloquea_Usuario(False, gsUsuario)
                gsTerminal = Datos(3)
                End
        
            End If
        
        Loop
        
    End If

End Sub


Private Sub OPC_MntCriterios_Click()
    Call FRM_Mnt_Criterios.Show
End Sub
Private Sub OPC_MntPatrimonio_Click()
    Call Frm_Mnt_Patrimonio.Show
End Sub
Private Sub OPC_MntTributario_Click()
   Call Frm_Mnt_Consulta.Show
End Sub

Private Sub Usuario_VR_Click()
   Call Frm_Mant_Usu_Cart_VolckerRule.Show
End Sub

Private Sub VolckerRule_Click()
    BacMntCrVRule.Show
End Sub
