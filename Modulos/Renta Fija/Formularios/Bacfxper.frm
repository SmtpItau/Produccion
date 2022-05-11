VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form Perfil_contable 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Perfiles Contables"
   ClientHeight    =   6465
   ClientLeft      =   450
   ClientTop       =   1035
   ClientWidth     =   11415
   Icon            =   "Bacfxper.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6465
   ScaleWidth      =   11415
   Begin VB.Data DataFox 
      Caption         =   "DataFox"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   300
      Left            =   6330
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   ""
      Top             =   90
      Visible         =   0   'False
      Width           =   2265
   End
   Begin Threed.SSFrame Frm_perfil_PV 
      Height          =   3735
      Left            =   4935
      TabIndex        =   19
      Top             =   2190
      Width           =   7560
      _Version        =   65536
      _ExtentX        =   13335
      _ExtentY        =   6588
      _StockProps     =   14
      Caption         =   "Condiciones"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      ShadowStyle     =   1
      Begin VB.TextBox Txt_ingreso_PV 
         BackColor       =   &H00808000&
         BorderStyle     =   0  'None
         ForeColor       =   &H00FFFFFF&
         Height          =   285
         Left            =   1725
         TabIndex        =   41
         Text            =   "Text2"
         Top             =   1635
         Visible         =   0   'False
         Width           =   615
      End
      Begin MSFlexGridLib.MSFlexGrid Gr_perfil_PV 
         Height          =   2160
         Left            =   225
         TabIndex        =   40
         Top             =   825
         Width           =   7110
         _ExtentX        =   12541
         _ExtentY        =   3810
         _Version        =   393216
         FixedCols       =   0
      End
      Begin VB.ComboBox Cmb_Condiciones 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1245
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   300
         Width           =   5175
      End
      Begin Threed.SSCommand Cmd_Agrega_PV 
         Height          =   300
         Left            =   255
         TabIndex        =   28
         Top             =   3090
         Width           =   1395
         _Version        =   65536
         _ExtentX        =   2461
         _ExtentY        =   529
         _StockProps     =   78
         Caption         =   "Agregar Línea"
         ForeColor       =   8388608
      End
      Begin Threed.SSCommand Cmd_Elimina_PV 
         Height          =   300
         Left            =   1635
         TabIndex        =   27
         Top             =   3090
         Width           =   1455
         _Version        =   65536
         _ExtentX        =   2566
         _ExtentY        =   529
         _StockProps     =   78
         Caption         =   "Eliminar Línea"
         ForeColor       =   8388608
      End
      Begin Threed.SSCommand Cmd_aceptar_PV 
         Height          =   360
         Left            =   4875
         TabIndex        =   22
         Top             =   3180
         Width           =   1185
         _Version        =   65536
         _ExtentX        =   2090
         _ExtentY        =   635
         _StockProps     =   78
         Caption         =   "Aceptar"
         ForeColor       =   8388608
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
      Begin Threed.SSCommand Cmd_exit_opciones 
         Height          =   360
         Left            =   6135
         TabIndex        =   21
         Top             =   3180
         Width           =   1185
         _Version        =   65536
         _ExtentX        =   2090
         _ExtentY        =   635
         _StockProps     =   78
         Caption         =   "Cancelar"
         ForeColor       =   8388608
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
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Condición"
         Height          =   195
         Left            =   375
         TabIndex        =   23
         Top             =   345
         Width           =   705
      End
   End
   Begin VB.Frame Frm_Perfil 
      Caption         =   "Perfil Contable"
      ForeColor       =   &H00C00000&
      Height          =   3555
      Left            =   90
      TabIndex        =   8
      Top             =   2700
      Width           =   11205
      Begin VB.TextBox Txt_ingreso_campos 
         BackColor       =   &H00808000&
         BorderStyle     =   0  'None
         ForeColor       =   &H00FFFFFF&
         Height          =   285
         Left            =   270
         TabIndex        =   39
         Text            =   "Text2"
         Top             =   735
         Visible         =   0   'False
         Width           =   615
      End
      Begin MSFlexGridLib.MSFlexGrid Gr_perfil 
         Height          =   2865
         Left            =   105
         TabIndex        =   38
         Top             =   240
         Width           =   10980
         _ExtentX        =   19368
         _ExtentY        =   5054
         _Version        =   393216
         FixedCols       =   0
      End
      Begin Threed.SSCommand Cmd_Perfil 
         Height          =   300
         Left            =   2850
         TabIndex        =   26
         Top             =   3165
         Width           =   1425
         _Version        =   65536
         _ExtentX        =   2514
         _ExtentY        =   529
         _StockProps     =   78
         Caption         =   "Perfil Variable"
         ForeColor       =   8388608
      End
      Begin Threed.SSCommand Cmd_Elimina 
         Height          =   300
         Left            =   1470
         TabIndex        =   25
         Top             =   3165
         Width           =   1395
         _Version        =   65536
         _ExtentX        =   2461
         _ExtentY        =   529
         _StockProps     =   78
         Caption         =   "Eliminar Línea"
         ForeColor       =   8388608
      End
      Begin Threed.SSCommand Cmd_Agrega 
         Height          =   300
         Left            =   150
         TabIndex        =   24
         Top             =   3165
         Width           =   1335
         _Version        =   65536
         _ExtentX        =   2355
         _ExtentY        =   529
         _StockProps     =   78
         Caption         =   "Agregar Línea"
         ForeColor       =   8388608
      End
      Begin VB.Label Lbl_msg 
         BorderStyle     =   1  'Fixed Single
         Height          =   270
         Left            =   4305
         TabIndex        =   15
         Top             =   3180
         Width           =   6720
      End
   End
   Begin VB.Frame Frm_Tipo_movimiento 
      Caption         =   "Tipo Movimiento/Operación"
      ForeColor       =   &H00C00000&
      Height          =   2160
      Left            =   90
      TabIndex        =   7
      Top             =   495
      Width           =   11175
      Begin VB.Frame fraCargaCtas 
         Caption         =   "Cargando..."
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   960
         Left            =   4905
         TabIndex        =   36
         Top             =   480
         Visible         =   0   'False
         Width           =   4995
         Begin Threed.SSPanel Pnl_Porcentaje 
            Height          =   525
            Left            =   165
            TabIndex        =   37
            Top             =   300
            Width           =   4710
            _Version        =   65536
            _ExtentX        =   8308
            _ExtentY        =   926
            _StockProps     =   15
            ForeColor       =   16777215
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
            BevelInner      =   2
            FloodType       =   1
            FloodColor      =   8421504
         End
      End
      Begin VB.ComboBox Cmb_Control_Moneda 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   9075
         Style           =   2  'Dropdown List
         TabIndex        =   34
         Top             =   330
         Visible         =   0   'False
         Width           =   585
      End
      Begin VB.ComboBox Cmb_Control_Instrumento 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   8445
         Style           =   2  'Dropdown List
         TabIndex        =   33
         Top             =   330
         Visible         =   0   'False
         Width           =   585
      End
      Begin VB.ComboBox Cmb_Sistema 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1260
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   390
         Width           =   2175
      End
      Begin VB.CommandButton cmd_ayuda_perfil 
         Caption         =   "?"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   3465
         TabIndex        =   16
         Top             =   390
         Width           =   375
      End
      Begin VB.TextBox Txt_Glosa 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1230
         TabIndex        =   6
         Text            =   "Text1"
         Top             =   1695
         Width           =   9100
      End
      Begin VB.ComboBox Cmb_Tipo_Voucher 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   6360
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   1275
         Width           =   1695
      End
      Begin VB.ComboBox Cmb_Tipo_Moneda 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1275
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   1245
         Width           =   3180
      End
      Begin VB.ComboBox Cmb_Tipo_Instrumento 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   6345
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   810
         Width           =   4560
      End
      Begin VB.ComboBox Cmb_Tipo_operacion 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1245
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   825
         Width           =   3630
      End
      Begin VB.ComboBox Cmb_Tipo_movimiento 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   6345
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   345
         Width           =   2055
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Sistema"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   600
         TabIndex        =   18
         Top             =   450
         Width           =   555
      End
      Begin VB.Label Lbl_existe_perfil 
         AutoSize        =   -1  'True
         Caption         =   "No existe perfil"
         Height          =   195
         Left            =   3930
         TabIndex        =   17
         Top             =   405
         Visible         =   0   'False
         Width           =   1035
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Tipo Voucher"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   5
         Left            =   5310
         TabIndex        =   14
         Top             =   1320
         Width           =   960
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Glosa Voucher"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   4
         Left            =   105
         TabIndex        =   13
         Top             =   1740
         Width           =   1050
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   3
         Left            =   585
         TabIndex        =   12
         Top             =   1275
         Width           =   585
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Instrum./Moneda"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   2
         Left            =   5025
         TabIndex        =   11
         Top             =   870
         Width           =   1215
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Tipo Operación"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   105
         TabIndex        =   10
         Top             =   870
         Width           =   1095
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Tipo Movimiento"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   5085
         TabIndex        =   9
         Top             =   405
         Width           =   1170
      End
   End
   Begin Threed.SSCommand Cmd_Cargar 
      Height          =   450
      Left            =   4905
      TabIndex        =   35
      Top             =   0
      Visible         =   0   'False
      Width           =   1275
      _Version        =   65536
      _ExtentX        =   2249
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "Cargar Ctas."
      ForeColor       =   8388608
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
      RoundedCorners  =   0   'False
   End
   Begin Threed.SSCommand Cmd_Grabar 
      Height          =   450
      Left            =   1200
      TabIndex        =   32
      Top             =   0
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "Grabar"
      ForeColor       =   8388608
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
   Begin Threed.SSCommand Cmd_Buscar 
      Height          =   450
      Left            =   2400
      TabIndex        =   31
      Top             =   0
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "Buscar"
      ForeColor       =   8388608
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
   Begin Threed.SSCommand Cmd_Eliminar 
      Height          =   450
      Left            =   3600
      TabIndex        =   30
      Top             =   0
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "Eliminar"
      ForeColor       =   8388608
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
      RoundedCorners  =   0   'False
   End
   Begin Threed.SSCommand Cmd_Limpiar 
      Height          =   450
      Left            =   0
      TabIndex        =   29
      Top             =   0
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "Limpiar"
      ForeColor       =   8388608
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
Attribute VB_Name = "Perfil_contable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

' Perfil Fijo
Const C_CAMPO = 0
Const C_DESC_CAMPO = 1
Const C_TIPO_MOV = 2
Const C_PERFIL_FIJO = 3
Const C_NCUENTA = 4
Const C_DESC_CUENTA = 5
Const C_CAMPO_VARIABLE = 6

' Perfil Variable
Const C2_VALOR = 0
Const C2_NCUENTA = 1
Const C2_DESC_CUENTA = 2
Const C2_CODIGO_CONDICION = 4
Const C2_CODIGO_VALOR = 5
Const C2_CODIGO = 0

Public Gr_Filas     As Single
Public Filas        As Single
Public varpsSql     As String
Public Folio_Perfil As Long



Function BUSCAR_CUENTA(Cuenta As String) As String
Dim Sql As String
Dim datos()

Sql = "SP_BUSCA_CUENTA_CONTABLE "
Sql = Sql & "'" & Cuenta & "'"
If miSQL.SQL_Execute(Sql) = 1 Then
   MsgBox "Error : La Busqueda No Termino", vbCritical, "Pc-Trader"
   Exit Function
End If

Do While miSQL.SQL_Fetch(datos()) = 0
   BUSCAR_CUENTA = Trim(datos(1))
Loop
    
End Function
Function FUNC_BUSCAR_PERFIL_VARIABLE(Filas As Single)
Dim Sql  As String
Dim X    As Integer
Dim datos()

Sql = "EXECUTE Sp_Buscar_Perfiles_Variables "
Sql = Sql & Filas

If miSQL.SQL_Execute(Sql) <> 0 Then
   MsgBox "Error : en la Cargatura de Perfiles Variables", vbCritical, "Pc-Trader"
   Exit Function
End If

PROC_CREA_GRILLA_PERFIL_PV

X = 0
Do While miSQL.SQL_Fetch(datos()) = 0
    X = X + 1
    Call TextMatrix(Gr_perfil_PV, X, 0, datos(2))
    Call TextMatrix(Gr_perfil_PV, X, 1, datos(3))
    Call TextMatrix(Gr_perfil_PV, X, 2, datos(4))
Loop

End Function
Function FUNC_GRABA_PERFIL_VARIABLE(Sistema As String, Tipo_movimiento As String, Tipo_Operacion As String)
Dim datos()

FUNC_GRABA_PERFIL_VARIABLE = False

'For i% = 1 To Gr_perfil_paso.Rows - 1

'    Gr_perfil_paso.Row = i%
'    Gr_perfil_paso.Col = 0

'    If Val(Gr_perfil_paso.Text) = Gr_perfil.Row Then
    
'       Comando$ = "SP_GRABA_PERFIL_VARIABLE "
       
       ' Sistema
'       Comando$ = Comando$ + "'" + Sistema + "',"
       
       ' Tipo Movimiento
'       Comando$ = Comando$ + "'" + Tipo_movimiento + "',"
       
       ' Tipo Operacion
'       Comando$ = Comando$ + "'" + Tipo_Operacion + "',"
              
       ' Producto
'       Gr_perfil_paso.Col = C2_PRODUCTO + 1
'       Comando$ = Comando$ + "'" + Trim(Gr_perfil_paso.Text) + "',"
       
       ' Cuenta
'       Gr_perfil_paso.Col = C2_NCUENTA + 1
'       Comando$ = Comando$ + "'" + Trim(Gr_perfil_paso.Text) + "',"
       
       ' Correlativo
'       Comando$ = Comando$ + Str(Gr_perfil.Row)
       
'       If misql.SQL_Execute(Comando$) <> 0 Then Exit Function
             
'    End If
    
'Next i%

FUNC_GRABA_PERFIL_VARIABLE = True

End Function

Function FUNC_VALIDA_CAMPO(campo As String) As Integer
Dim datos()

Screen.MousePointer = 11

FUNC_VALIDA_CAMPO = False

Comando$ = "SP_BUSCA_CAMPO_PERFIL "
Comando$ = Comando$ + campo + ","
Comando$ = Comando$ + "'" + Right(Cmb_Sistema.Text, 3) + "',"
Comando$ = Comando$ + "'" + Right(Cmb_Tipo_movimiento.Text, 3) + "',"
Comando$ = Comando$ + "'" + Trim(Right(Cmb_Tipo_operacion.Text, 5)) + "'"

If miSQL.SQL_Execute(Comando$) <> 0 Then
   Screen.MousePointer = 0
   Exit Function
End If

Screen.MousePointer = 0

If miSQL.SQL_Fetch(datos()) = -1 Then
   MsgBox "Campo NO Existe.", vbCritical
   Call TextMatrix(Gr_perfil, Gr_perfil.Row + 1, C_DESC_CAMPO, "")
   Exit Function
End If

Gr_perfil.Col = C_DESC_CAMPO
Gr_perfil.Text = Trim(datos(1))

Gr_perfil.Col = C_CAMPO

FUNC_VALIDA_CAMPO = True

End Function

Function FUNC_VALIDA_INDICADOR(Indicador As String) As Integer
Dim datos()

FUNC_VALIDA_INDICADOR = False

Comando$ = "SP_BUSCA_INDICADOR '" + Indicador + "'"

If miSQL.SQL_Execute(Comando$) <> 0 Then
     MsgBox "Error : Al Cargar datos", vbCritical, "Pc-Trader"
     Exit Function
End If
 If miSQL.SQL_Fetch(datos()) = -1 Then
   MsgBox "Indicador NO Existe.", vbCritical
   Exit Function
End If

If Val(datos(1)) <> 1 Then
   MsgBox "Indicador NO Existe.", vbCritical
   Exit Function
End If

FUNC_VALIDA_INDICADOR = True

End Function

Function FUNC_VALIDA_INGRESO_FIJO() As Integer

FUNC_VALIDA_INGRESO_FIJO = False

If Gr_perfil.Col = C_CAMPO Then

   If Not FUNC_VALIDA_CAMPO(Txt_ingreso_campos.Text) Then
      Exit Function
   Else
      Gr_perfil.Text = Txt_ingreso_campos.Text
   End If
   
   SendKeys "{RIGHT 2}"
End If

If Gr_perfil.Col = C_NCUENTA Then
  
   If Not FUNC_VALIDA_CUENTA(FUNC_FORMATO_CUENTA(Txt_ingreso_campos.Text, "F"), "PF") Then
      Exit Function
   Else
      Gr_perfil.Text = FUNC_FORMATO_CUENTA(Txt_ingreso_campos.Text, "F")
   End If
      
   SendKeys "{DOWN}"
   SendKeys "{HOME}"
End If
   
If Gr_perfil.Col = C_PERFIL_FIJO Then

   If Trim(Txt_ingreso_campos.Text) <> "S" And Trim(Txt_ingreso_campos.Text) <> "N" Then
      Exit Function
   Else
      Gr_perfil.Text = Trim(Txt_ingreso_campos.Text)
      
      Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_NCUENTA, "")
      Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_DESC_CUENTA, "")
       
      If Gr_perfil.Text = "N" Then
         Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_DESC_CUENTA, "Perfil Variable NO Completo")
      Else
         SendKeys "{RIGHT}"
      End If
   End If
   
End If
   
If Gr_perfil.Col = C_TIPO_MOV Then

   If Trim(Txt_ingreso_campos.Text) <> "D" And Trim(Txt_ingreso_campos.Text) <> "H" Then
      Exit Function
   Else
      Gr_perfil.Text = Trim(Txt_ingreso_campos.Text)
   End If
      
   SendKeys "{RIGHT}"
End If

FUNC_VALIDA_INGRESO_FIJO = True

End Function

Function FUNC_VALIDA_INGRESO_PERFIL(grilla_valida As String) As Integer
Dim Con_info    As Integer: Con_info = False
Dim Descripcion As String

FUNC_VALIDA_INGRESO_PERFIL = False

If grilla_valida = "PF" Then

   If Trim(Txt_Glosa.Text) = "" Then Exit Function

   For i% = 1 To Gr_perfil.Rows - 1
   
       If Trim(TextMatrix(Gr_perfil, i%, C_CAMPO, "X")) <> "" Then
       
          If Trim(TextMatrix(Gr_perfil, i%, C_TIPO_MOV, "X")) = "" Or Trim(TextMatrix(Gr_perfil, i%, C_PERFIL_FIJO, "X")) = "" Then Exit Function
          
          If Trim(TextMatrix(Gr_perfil, i%, C_PERFIL_FIJO, "X")) = "N" And (InStr(TextMatrix(Gr_perfil, i%, C_DESC_CUENTA, "X"), "NO") > 0 And Mid(TextMatrix(Gr_perfil, i%, C_DESC_CUENTA, "X"), 1, 3) = "Per") Then Exit Function
          
          If Trim(TextMatrix(Gr_perfil, i%, C_PERFIL_FIJO, "X")) = "S" And Trim(TextMatrix(Gr_perfil, i%, C_NCUENTA, "X")) = "" Then Exit Function
          
          Con_info = True
       End If
       
   Next i%
   
End If

If grilla_valida = "PV" Then

   For i% = 1 To Gr_perfil_PV.Rows - 1
   
       If Trim(TextMatrix(Gr_perfil_PV, i%, C2_CODIGO, "X")) <> "" And Trim(TextMatrix(Gr_perfil_PV, i%, C2_NCUENTA, "X")) = "" Then Exit Function
       
       If Trim(TextMatrix(Gr_perfil_PV, i%, C2_NCUENTA, "X")) <> "" And Trim(TextMatrix(Gr_perfil_PV, i%, C2_CODIGO, "X")) = "" Then Exit Function
       
       If Trim(TextMatrix(Gr_perfil_PV, i%, C2_CODIGO, "X")) <> "" And Trim(TextMatrix(Gr_perfil_PV, i%, C2_NCUENTA, "X")) <> "" Then Con_info = True
       
   Next i%

End If

FUNC_VALIDA_INGRESO_PERFIL = Con_info

End Function

Function FUNC_VALIDA_INGRESO_PV()
Dim datos()

FUNC_VALIDA_INGRESO_PV = False
If Gr_perfil_PV.Col = 1 Then
  
   If Not FUNC_VALIDA_CUENTA(FUNC_FORMATO_CUENTA(Txt_ingreso_PV.Text, "F"), "PV") Then
      Exit Function
   Else
      Gr_perfil_PV.Text = FUNC_FORMATO_CUENTA(Txt_ingreso_PV.Text, "F")
   End If
      
   SendKeys "{RIGHT}"
End If
   
FUNC_VALIDA_INGRESO_PV = True

End Function




Function FUNC_VALIDA_INSTRUMENTO_IRF(familia_instrumento As String)
Dim datos()

FUNC_VALIDA_INSTRUMENTO_IRF = False

Comando$ = "SP_BUSCA_RFI_INSTRUMENTO '" + familia_instrumento + "'"
        
If miSQL.SQL_Execute(Comando$) <> 0 Or miSQL.SQL_Fetch(datos()) = -1 Then
   MsgBox "Instrumento NO Existe.", vbCritical
   Exit Function
End If

If Val(datos(1)) = 1 Then
   MsgBox "Instrumento NO Existe.", vbCritical
   Exit Function
End If

FUNC_VALIDA_INSTRUMENTO_IRF = True

End Function


Function FUNC_VALIDA_MONEDA(Moneda As String) As Integer
Dim datos()

FUNC_VALIDA_MONEDA = False

Comando$ = "SP_GRABA_BUSCA_MONEDA "
Comando$ = Comando$ + "'B',"
Comando$ = Comando$ + "'" + Moneda + "',"
Comando$ = Comando$ + "''"

If miSQL.SQL_Execute(Comando$) <> 0 Or miSQL.SQL_Fetch(datos()) = -1 Then
   MsgBox "Moneda NO Existe.", vbCritical
   Exit Function
End If

FUNC_VALIDA_MONEDA = True

End Function

Sub PROC_ASIGNA_COMBOS()

For i% = 0 To Cmb_Sistema.ListCount - 1
    Cmb_Sistema.ListIndex = i%
    If Right(Cmb_Sistema.Text, 3) = Mid(Glob_Registro_Ayuda, 1, 3) Then Exit For
Next i%

For i% = 0 To Cmb_Tipo_movimiento.ListCount - 1
    Cmb_Tipo_movimiento.ListIndex = i%
    If Right(Cmb_Tipo_movimiento.Text, 3) = Mid(Glob_Registro_Ayuda, 4, 3) Then Exit For
Next i%

For i% = 0 To Cmb_Tipo_operacion.ListCount - 1
    Cmb_Tipo_operacion.ListIndex = i%
    If Right(Cmb_Tipo_operacion.Text, 3) = Mid(Glob_Registro_Ayuda, 7, 3) Then Exit For
Next i%

End Sub

Sub PROC_BUSCA_PERFIL(Numero As Long)
Dim datos()
Dim Sql As String
Dim X As Integer
Screen.MousePointer = 11

' Sistema = Right(Cmb_sistema.Text, 3)
' Tipo_movimiento = Right(Cmb_tipo_movimiento.Text, 3)
' Tipo_Operacion = Right(Cmb_tipo_operacion.Text, 3)
' comando$ = "SP_BUSCA_PERFIL 'PF'," + "'" + Sistema + "','" + Tipo_movimiento + "','" + Tipo_Operacion + "'"
' SP_BUSCAR_DETALLE_PERFILES 2

    Sql = "EXECUTE sp_buscar_perfiles "
    Sql = Sql & Numero

    If miSQL.SQL_Execute(Sql) <> 0 Then
       Screen.MousePointer = 0
       Exit Sub
    End If

    If miSQL.SQL_Fetch(datos()) = 0 Then
       For X = 0 To Cmb_Sistema.ListCount - 1
            If Trim(Right(Cmb_Sistema.List(X), 7)) = Trim(datos(1)) Then
               Cmb_Sistema.ListIndex = Val(X)
               Exit For
            End If
       Next
       
        For X = 0 To Cmb_Tipo_movimiento.ListCount - 1
            If Trim(Right(Cmb_Tipo_movimiento.List(X), 7)) = Trim(datos(2)) Then
                Cmb_Tipo_movimiento.ListIndex = Val(X)
                Exit For
            End If
        Next
        
        For X = 0 To Cmb_Tipo_operacion.ListCount - 1
            If Trim(Right(Cmb_Tipo_operacion.List(X), 7)) = Trim(datos(3)) Then
                Cmb_Tipo_operacion.ListIndex = Val(X)
                Exit For
            End If
        Next
        
        For X = 0 To Cmb_Tipo_Instrumento.ListCount - 1
            If Trim(Mid(Cmb_Tipo_Instrumento.List(X), 1, 5)) = Trim(datos(5)) Then
                Cmb_Tipo_Instrumento.ListIndex = Val(X)
                Exit For
            End If
        Next
        
        For X = 0 To Cmb_Tipo_Moneda.ListCount - 1
             If Trim(Right(Cmb_Tipo_Moneda.List(X), 7)) = Trim(datos(6)) Then
                Cmb_Tipo_Moneda.ListIndex = Val(X)
                Exit For
             End If
        Next
        
       Txt_Glosa.Text = Trim(datos(8))
       
End If

Sql = "EXECUTE sp_buscar_detalle_perfiles "
Sql = Sql & Numero
If miSQL.SQL_Execute(Sql) <> 0 Then
   Screen.MousePointer = 0
   Exit Sub
End If
  X = 0
    Do While miSQL.SQL_Fetch(datos()) = 0
    
        X = X + 1
        If X > Gr_perfil.Rows - 2 Then
            Gr_perfil.Rows = Gr_perfil.Rows + 1
        End If
        
        Call TextMatrix(Gr_perfil, X, 0, Val(datos(2)))
        Call TextMatrix(Gr_perfil, X, 1, datos(8))
        Call TextMatrix(Gr_perfil, X, 2, datos(3))
        Call TextMatrix(Gr_perfil, X, 3, datos(4))
        Call TextMatrix(Gr_perfil, X, 4, datos(5))
        Call TextMatrix(Gr_perfil, X, 5, IIf(datos(4) <> "N", datos(9), "Perfil Variable Completo"))
        Call TextMatrix(Gr_perfil, X, C_CAMPO_VARIABLE, Format(datos(7), "##0"))
    Loop

'If OK% <> -1 Then
'
'   Select Case Trim(Datos(1))
'          Case "I": Cmb_tipo_voucher.ListIndex = 0
'          Case "E": Cmb_tipo_voucher.ListIndex = 1
'          Case "T": Cmb_tipo_voucher.ListIndex = 2
'   End Select
'
'   Txt_glosa.Text = Trim(Datos(2))
'
'   Lbl_existe_perfil.Caption = "S"
'Else
'
'   Lbl_existe_perfil.Caption = "N"
'End If
'
'Gr_perfil.Row = 0
'Gr_perfil.Redraw = False
'
'Do While OK% <> -1
'
'   Gr_perfil.Row = Gr_perfil.Row + 1
'
'   Gr_perfil.TextMatrix(Gr_perfil.Row, C_CAMPO) = Format(Datos(3), "##0")
'
'   Gr_perfil.TextMatrix(Gr_perfil.Row, C_DESC_CAMPO) = Trim(Datos(4))
'
'   Gr_perfil.TextMatrix(Gr_perfil.Row, C_TIPO_MOV) = Trim(Datos(5))
'
'   Gr_perfil.TextMatrix(Gr_perfil.Row, C_PERFIL_FIJO) = Trim(Datos(6))
'
'   Gr_perfil.TextMatrix(Gr_perfil.Row, C_NCUENTA) = Trim(Datos(7))
'
'   Gr_perfil.TextMatrix(Gr_perfil.Row, C_DESC_CUENTA) = Trim(Datos(8))
'
'   If Trim(Datos(6)) = "N" Then Gr_perfil.TextMatrix(Gr_perfil.Row, C_DESC_CUENTA) = "Perfil Variable Completo"
'
'   OK% = misql.SQL_Fetch(Datos())
'Loop
'
'Gr_perfil.Redraw = True
'
'If Lbl_existe_perfil.Caption = "N" Then
'   Screen.MousePointer = 0
'
'   PROC_HABILITA False
'   Exit Sub
'End If
'
'' BUSCA SI EXISTEN PERFILES VARIABLES
'
'comando$ = "SP_BUSCA_PERFIL 'PV'," + "'" + Sistema + "','" + Tipo_movimiento + "','" + Tipo_Operacion + "'"
'
'If misql.SQL_Execute(comando$) <> 0 Then
'   Screen.MousePointer = 0
'   Exit Sub
'End If
'
'PROC_CREA_GRILLA_PASO
'
'If Gr_perfil_paso.Row = 0 Then
'   Gr_perfil_paso.AddItem ""
'   Gr_perfil_paso.Row = 0
'Else
'   Gr_perfil_paso.Row = Gr_perfil_paso.Rows - 1
'End If
'
'Do While misql.SQL_Fetch(Datos()) <> -1
'
'   If Gr_perfil_paso.Row + 1 > Gr_perfil_paso.Rows - 1 Then Gr_perfil_paso.AddItem ""
'
'   Gr_perfil_paso.Row = Gr_perfil_paso.Row + 1
'
'   Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_CODIGO + 1) = Trim(Datos(1))
'
'   Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_INDICADOR + 1) = Trim(Datos(2))
'
'   Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_NCUENTA + 1) = Trim(Datos(3))
'
'   Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_DESC_CUENTA + 1) = Trim(Datos(4))
'
'   Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, 0) = Val(Datos(5))
'Loop

Screen.MousePointer = 0

PROC_HABILITA False

End Sub

Sub PROC_CARGA_COMBO_MOVIMIENTO()
' ---------------------------------------------------------------------------
'   SubRutina       :   PROC_CARGA_COMBO_MOVIMIENTO
'   Objetivo        :   Realiza la carga del combo de movimientos
' ---------------------------------------------------------------------------
Dim datos()
Dim Sql As String
On Error GoTo CargaData

    
  ' Cargo Tipos de Movimientos relacionados con el tipo de movimiento
  ' ======================================================================================
    Sql = "sp_cnt_leermovimientos " & Right$(Cmb_Sistema.Text, 3)

    If miSQL.SQL_Execute(Sql) = 0 Then
        Cmb_Tipo_movimiento.Clear
        Do While miSQL.SQL_Fetch(datos()) = 0
            Cmb_Tipo_movimiento.AddItem Trim$(datos(2)) & Space(50) & datos(1)
        Loop
        Cmb_Tipo_movimiento.Enabled = True
        If Cmb_Tipo_movimiento.ListCount <> 0 Then Cmb_Tipo_movimiento.ListIndex = 0
    Else
        MsgBox "Problemas en obtención de información del servidor ", vbCritical, Me.Caption
        Exit Sub
    End If
  ' ======================================================================================
        
  
    
    Exit Sub
CargaData:
    MsgBox "Problemas en carga de información de objetos: " & Err.Description & ". Comunique al Administrador.", vbCritical, Me.Caption
    Exit Sub
End Sub

Sub PROC_CARGA_COMBO_TIPO_OPERACION()

' Cmb_tipo_operacion.Clear

' --------------------------------------------------------------------------------------
' NOTA AL PROGRAMADOR:
'
' RIGHT(Cmb_tipo_operacion,3)           = TIPO DE OPERACION O DEVENGO
' MID(RIGHT(Cmb_tipo_operacion,10),1,6) = TIPO DE AYUDA :
'                                         INSTRU = Instrumentos Renta Fija
'                                         INSIND = Instrumentos Renta Fija e Indicador
'                                         MONEDA = Monedas
'                                         ACCION = Acciones
' --------------------------------------------------------------------------------------
Dim datos()
Dim Sql As String

  ' Cargo datos correspondientes al tipo de operación
  ' ======================================================================================
  
    Cmb_Tipo_operacion.Clear
    Cmb_Control_Instrumento.Clear
    Cmb_Control_Moneda.Clear
  
    Sql = "EXECUTE sp_cnt_leeroperaciones '" & Right$(Cmb_Sistema.Text, 3) & "', '" & Right$(Cmb_Tipo_movimiento.Text, 3) & "'"

    If miSQL.SQL_Execute(Sql) = 0 Then
        Do While miSQL.SQL_Fetch(datos()) = 0
           Cmb_Tipo_operacion.AddItem Trim$(datos(2)) & Space(50) & datos(1)
           'Cmb_tipo_operacion.ItemData(Cmb_tipo_operacion.NewIndex) = IIf(Datos(3) = "S", 1, 0)
           Cmb_Control_Instrumento.AddItem Trim$(datos(3))
           Cmb_Control_Moneda.AddItem Trim$(datos(4))
        Loop
        Cmb_Tipo_operacion.Enabled = True
        If Cmb_Tipo_operacion.ListCount <> 0 Then Cmb_Tipo_operacion.ListIndex = 0
    Else
        MsgBox "Problemas en obtención de información del servidor ", vbCritical, Me.Caption
        Exit Sub
    End If


End Sub



Sub PROC_CARGA_COMBO_MONEDA()
Dim datos()
Dim Sql As String
On Error GoTo ErrMon


  ' Cargo datos correspondientes al tipo de operación
  ' ======================================================================================
    Sql = "EXECUTE sp_cnt_listamonedas '" & Right$(Cmb_Sistema.Text, 3) & "'"
    Cmb_Tipo_Moneda.Clear
    
    If miSQL.SQL_Execute(Sql) = 0 Then
        Do While miSQL.SQL_Fetch(datos()) = 0
             If datos(1) <> "NO HAY DATOS" Then
             Cmb_Tipo_Moneda.AddItem Trim$(datos(2)) & Space(50) & datos(1)
             End If
        Loop
        Cmb_Tipo_Moneda.Enabled = True
        If Cmb_Tipo_Moneda.ListCount <> 0 Then Cmb_Tipo_Moneda.ListIndex = 0
    Else
        MsgBox "Problemas en obtención de información del servidor ", vbCritical, Me.Caption
        Exit Sub
    End If
    
    Cmb_Tipo_Moneda.Enabled = IIf(Cmb_Tipo_Moneda.ListCount <= 0, False, True)
    
    Exit Sub
    
ErrMon:
    MsgBox "Problemas en carga de codigos de monedas", vbCritical, Me.Caption
    Exit Sub
End Sub


Sub PROC_CARGA_COMBO_INSTRUMENTOS()
Dim datos()
Dim Cant As Single
Dim Sql As String
On Error GoTo ErrMon

    
    Cmb_Tipo_Instrumento.Clear

  '  If Cmb_tipo_operacion.ItemData(Cmb_tipo_operacion.ListIndex) = 0 Then
  '      Cmb_Tipo_Instrumento.Enabled = False
  '      Exit Sub
   ' End If
    
    ' Cargo datos correspondientes al tipo de operación
    ' ======================================================================================
      Sql = "EXECUTE sp_cnt_listainstrumentos '" & Right$(Cmb_Sistema.Text, 3) & "'"
      
      If miSQL.SQL_Execute(Sql) = 0 Then
          Do While miSQL.SQL_Fetch(datos()) = 0
              If datos(1) <> "NO HAY DATOS" Then
               Cant = (9 - Len(Trim(datos(1))))
               Cmb_Tipo_Instrumento.AddItem Trim$(datos(1)) & Space(Cant) & datos(2)
              End If
          Loop
          If Cmb_Tipo_Instrumento.ListCount <> 0 Then Cmb_Tipo_Instrumento.ListIndex = 0
      Else
          MsgBox "Problemas en obtención de información del servidor ", vbCritical, Me.Caption
          Exit Sub
      End If
      Exit Sub
                
ErrMon:
    MsgBox "Problemas en carga de instrumentos", vbCritical, Me.Caption
    Exit Sub
End Sub



Sub PROC_CREA_GRILLA_PERFIL_PV()

'Gr_perfil_PV.Redraw = False

Gr_perfil_PV.Rows = 1
Gr_perfil_PV.Cols = 1

Gr_perfil_PV.Rows = 21
Gr_perfil_PV.Cols = 3

Gr_perfil_PV.FixedRows = 1
Gr_perfil_PV.FixedCols = 0

Gr_perfil_PV.Row = 0
'VB+- 10/02/2000  Se saco Gr_perfil_PV.Col = C2_CONDICION: Gr_perfil_PV.Text = "Condicion"
Gr_perfil_PV.Col = C2_VALOR: Gr_perfil_PV.Text = "Valor"
Gr_perfil_PV.Col = C2_NCUENTA: Gr_perfil_PV.Text = "Cuenta"
Gr_perfil_PV.Col = C2_DESC_CUENTA: Gr_perfil_PV.Text = "Descripción Cuenta"

' VB+- 10/02/2000 Gr_perfil_PV.ColWidth(C2_CONDICION) = 2000
Gr_perfil_PV.ColWidth(C2_VALOR) = 1500
Gr_perfil_PV.ColWidth(C2_NCUENTA) = 1200
Gr_perfil_PV.ColWidth(C2_DESC_CUENTA) = 4000
' VB+- 10/02/2000 Gr_perfil_PV.ColWidth(C2_CODIGO_CONDICION) = 1
'Gr_perfil_PV.ColWidth(C2_CODIGO_VALOR) = 1

' VB+- 10/02/20000 Gr_perfil_PV.ColAlignment(C2_CONDICION) = flexAlignLeftCenter
Gr_perfil_PV.ColAlignment(C2_VALOR) = flexAlignLeftCenter
Gr_perfil_PV.ColAlignment(C2_NCUENTA) = flexAlignLeftCenter
Gr_perfil_PV.ColAlignment(C2_DESC_CUENTA) = flexAlignLeftCenter

'Gr_perfil_PV.Redraw = True

Gr_perfil_PV.Row = 1
Gr_perfil_PV.Col = 0

End Sub



Sub PROC_ELIMINA_PERFIL(Numero As Long)
Dim datos()
Dim Error            As Integer: Error = False
Dim Sistema          As String '* 3
Dim Tipo_movimiento  As String '* 3
Dim Tipo_Operacion   As String '* 5

Comando$ = "BEGIN TRANSACTION"

If miSQL.SQL_Execute(Comando$) <> 0 Then Exit Sub

Sistema = Right(Cmb_Sistema.Text, 3)
Tipo_movimiento = Right(Cmb_Tipo_movimiento.Text, 3)
Tipo_Operacion = Trim(Right(Cmb_Tipo_operacion.Text, 5))

'Comando$ = "SP_ELIMINA_PERFIL '" & Sistema & "','" & Tipo_movimiento & "','" & Tipo_Operacion & "'"
Comando$ = "SP_ELIMINA_PERFIL " & Numero
If miSQL.SQL_Execute(Comando$) <> 0 Then
   Comando$ = "ROLLBACK"
   Error = True
Else
   Comando$ = "COMMIT"
End If

If miSQL.SQL_Execute(Comando$) <> 0 Then Error = True

If Error Then MsgBox "Perfil NO Eliminado.", vbCritical

PROC_LIMPIA
     
Cmb_Sistema.SetFocus

End Sub

Sub PROC_GRABA_PERFIL()
Dim datos()
Dim Error            As Integer
Dim Sistema          As String * 3
Dim Tipo_movimiento  As String * 3
Dim Tipo_Operacion   As String * 5
Dim crear_perfil     As String * 1

Comando$ = "BEGIN TRANSACTION"

If miSQL.SQL_Execute(Comando$) <> 0 Then Exit Sub

Error = False

Screen.MousePointer = 11

Sistema = Right(Cmb_Sistema.Text, 3)
Tipo_movimiento = Right(Cmb_Tipo_movimiento.Text, 3)
Tipo_Operacion = Trim(Right(Cmb_Tipo_operacion.Text, 5))

Comando$ = "SP_ELIMINA_PERFIL "
Comando$ = Comando$ & Folio_Perfil
If miSQL.SQL_Execute(Comando$) <> 0 Then
   Error = True
   GoTo END_Graba_Perfil:
End If

'Gr_perfil.Redraw = False
crear_perfil = "S"

For i% = 1 To Gr_perfil.Rows - 1

    Gr_perfil.Row = i%
    Gr_perfil.Col = C_CAMPO

    If Val(Gr_perfil.Text) > 0 Then
    
       Comando$ = "SP_GRABA_PERFIL "
       
       ' Crear Encabezado
       Comando$ = Comando$ + "'" + crear_perfil + "',"
       crear_perfil = "N"
      
       ' Folio Perfil
       Comando$ = Comando$ + Str(Folio_Perfil) + ","
     
       ' Sistema
       Comando$ = Comando$ + "'" + Sistema + "',"
       
       ' Tipo Movimiento
       Comando$ = Comando$ + "'" + Tipo_movimiento + "',"
       
       ' Tipo Operacion
       Comando$ = Comando$ + "'" + Trim(Tipo_Operacion) + "',"
       
       'Codigo Instrumento
       If Cmb_Control_Instrumento.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
          Comando$ = Comando$ + "'',"
       Else
          Comando$ = Comando$ + "'" + Trim(Mid(Cmb_Tipo_Instrumento, 1, 5)) + "',"
       End If
       
       ' Codigo Moneda
       If Cmb_Control_Moneda.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
          Comando$ = Comando$ + "'',"
       Else
          Comando$ = Comando$ + "'" & CDbl(Trim(Right(Cmb_Tipo_Moneda.Text, 5))) & "',"
       End If
       
       ' Tipo de Voucher
       Comando$ = Comando$ + "'" + Trim(Mid(Cmb_Tipo_Voucher.Text, 1, 1)) + "',"
       
       ' Glosa
       Comando$ = Comando$ + "'" + Trim(Txt_Glosa.Text) + "',"
       
       ' Codigo Campo
       Comando$ = Comando$ + TextMatrix(Gr_perfil, i%, C_CAMPO, "X") + ","

      ' Tipo Movimiento o Cuenta
       Comando$ = Comando$ + "'" + TextMatrix(Gr_perfil, i%, C_TIPO_MOV, "X") + "',"
                    
       ' Perfil Fijo
       Comando$ = Comando$ + "'" + TextMatrix(Gr_perfil, i%, C_PERFIL_FIJO, "X") + "',"
       
       ' Cuenta
       Gr_perfil.Col = 4
       Comando$ = Comando$ + "'" + TextMatrix(Gr_perfil, i%, C_NCUENTA, "X") + "',"

       ' Correlativo
       Comando$ = Comando$ + Str(Gr_perfil.Row) + ","
       
       ' Codigo Campo Variable
       Comando$ = Comando$ + Str(Val(TextMatrix(Gr_perfil, i%, C_CAMPO_VARIABLE, "X")))
       
       If miSQL.SQL_Execute(Comando$) <> 0 Then
          Error = True
          Exit For
       End If
       
       If Mid(TextMatrix(Gr_perfil, i%, C_PERFIL_FIJO, "X"), 1, 1) = "N" Then
       
          If Not FUNC_GRABA_PERFIL_VARIABLE(Sistema, Tipo_movimiento, Tipo_Operacion) Then
             Error = True
             Exit For
          End If
          
       End If
       
    End If
    
Next i%

'Gr_perfil.Redraw = True

END_Graba_Perfil:

If Error Then
   Comando$ = "ROLLBACK"
Else
   Comando$ = "COMMIT"
End If

If miSQL.SQL_Execute(Comando$) <> 0 Then Error = False
   
Screen.MousePointer = 0

If Not Error Then
   MsgBox "Perfil Grabado sin Problemas.", 64
Else
   MsgBox "Información NO Grabada.", 16
End If

End Sub

Sub PROC_HABILITA(modo As Boolean)

Cmb_Sistema.Enabled = modo
Cmb_Tipo_movimiento.Enabled = modo
Cmb_Tipo_operacion.Enabled = modo
cmd_ayuda_perfil.Enabled = modo
Cmb_Tipo_Moneda.Enabled = modo
Cmb_Tipo_Instrumento.Enabled = modo
'Txt_glosa.Enabled = modo
'Cmb_tipo_voucher.Enabled = modo

End Sub
Sub PROC_HABILITA_PV(modo As Integer)

Cmd_Grabar.Enabled = modo   ' Grabar
Cmd_Buscar.Enabled = modo   ' Buscar
Cmd_Eliminar.Enabled = modo ' Anular

Frm_Tipo_movimiento.Enabled = modo
Frm_Perfil.Enabled = modo

End Sub


Sub PROC_LIMPIA()

    Folio_Perfil = 0

    Cmb_Sistema.Enabled = True
    Cmb_Tipo_movimiento.Enabled = True
    Cmb_Tipo_operacion.Enabled = True
    
    PROC_HABILITA_PV True

    PROC_HABILITA True

    Frm_perfil_PV.Visible = False

    PROC_CREA_GRILLA_PERFIL

    PROC_CREA_GRILLA_PASO

    Txt_Glosa.Text = ""
    Lbl_Msg.Caption = ""
    Lbl_existe_perfil.Caption = "N"
    
    Frm_Perfil.Enabled = False
    Cmd_Buscar.Enabled = True
    Cmd_Grabar.Enabled = False
    Cmd_Eliminar.Enabled = False

    Cmb_Sistema.ListIndex = 0

    Cmb_Tipo_Voucher.ListIndex = 0
    
    Gr_perfil_PV.Refresh
    'Gr_perfil_paso.Refresh
    Gr_perfil.Refresh
    
End Sub



Sub PROC_CARGA_COMBO_SISTEMA()
'   ----------------------------------------------------------------------------------
'   SubRutina   :   Proc_Carga_Combo_sistema - VB
'   Objetivo    :   Realiza la carga de información en los objetos tipo Combos
'   ----------------------------------------------------------------------------------


Dim datos()
Dim Sql As String
On Error GoTo ErrCarga

 '  Cargo Combo de sistemas
 '  ============================================================================
    Sql = "SP_BUSCAR_SISTEMAS"
    If miSQL.SQL_Execute(Sql) = 0 Then
        Do While miSQL.SQL_Fetch(datos()) = 0
            Cmb_Sistema.AddItem Mid$(datos(2), 1, 15) & Space(50) & datos(1)
        Loop
    Else
        MsgBox "No se pudo obtener información del servidor", vbCritical, Me.Caption
        Exit Sub
    End If
  ' ============================================================================
  
  
  ' Cargo combo de Tipos de Voucher
  ' ============================================================================
    Cmb_Tipo_Voucher.AddItem "INGRESO"
    Cmb_Tipo_Voucher.AddItem "EGRESO"
    Cmb_Tipo_Voucher.AddItem "TRASPASO"
  ' ============================================================================
  
  ' Cargo combo de Tipos de Voucher
  ' ============================================================================
    Cmb_Tipo_movimiento.AddItem "MOVIMIENTO"
    Cmb_Tipo_movimiento.AddItem "DEVENGAMIENTO"
  ' ============================================================================
    Cmb_Tipo_movimiento.ListIndex = -1
    Cmb_Tipo_Instrumento.ListIndex = -1
    Exit Sub
    
ErrCarga:
    MsgBox "Se detectó problemas en carga de información: " & Err.Description & ". Comunique al Administrador.", vbCritical, Me.Caption
    Exit Sub
End Sub

Function TextMatrix(Grilla As Control, Fila As Integer, Columna As Integer, Dato As Variant) As Variant
    
fil_g% = Grilla.Row
col_g% = Grilla.Col

Grilla.Row = Fila
Grilla.Col = Columna

If Dato = "X" Then
   TextMatrix = Grilla.Text
Else
   Grilla.Text = Dato
End If

Grilla.Row = fil_g%
Grilla.Col = col_g%

End Function

Private Sub Cmb_Condiciones_Click()
Dim Sql As String
Dim datos()
Dim X As Integer

    For X = 1 To Gr_perfil.Rows - 1
       Call TextMatrix(Gr_perfil_PV, X, C2_VALOR, "")
       Call TextMatrix(Gr_perfil_PV, X, C2_NCUENTA, "")
       Call TextMatrix(Gr_perfil_PV, X, C2_DESC_CUENTA, "")
    Next X
    
    PROC_CREA_GRILLA_PERFIL_PV
    
    Sql = "EXECUTE sp_buscar_periles_variables "
    Sql = Sql & Folio_Perfil & ","
    Sql = Sql & Gr_Filas & ","
    Sql = Sql & Val(Right(Cmb_Condiciones.Text, 7))
    If miSQL.SQL_Execute(Sql) <> 0 Then
       MsgBox "Error : Busqueda de Perfiles Variables", vbCritical, gsBac_Version
       Exit Sub
    End If
    X = 0
    Do While miSQL.SQL_Fetch(datos()) = 0
       X = X + 1
       Call TextMatrix(Gr_perfil_PV, X, C2_VALOR, datos(1))
       Call TextMatrix(Gr_perfil_PV, X, C2_NCUENTA, datos(2))
       Call TextMatrix(Gr_perfil_PV, X, C2_DESC_CUENTA, datos(3))
    Loop
    
End Sub

Private Sub Cmb_sistema_Click()

     PROC_CARGA_COMBO_MOVIMIENTO
     
End Sub

Private Sub Cmb_sistema_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then Cmb_Tipo_movimiento.SetFocus

End Sub


Private Sub Cmb_Tipo_Movimiento_Click()

PROC_CARGA_COMBO_TIPO_OPERACION     ' Carga Combo de tipos de operación
 
PROC_CARGA_COMBO_MONEDA             ' Carga Combo de monedas

If Cmb_Control_Moneda.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
   Cmb_Tipo_Moneda.ListIndex = -1
End If

PROC_CARGA_COMBO_INSTRUMENTOS       ' Carga Combo de instrumentos

If Cmb_Control_Instrumento.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
   Cmb_Tipo_Instrumento.ListIndex = -1
End If

End Sub

Private Sub Cmb_Tipo_Movimiento_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then Cmb_Tipo_operacion.SetFocus

End Sub


Private Sub Cmb_tipo_operacion_Click()

If Cmb_Control_Instrumento.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
   Cmb_Tipo_Instrumento.ListIndex = -1
   Cmb_Tipo_Instrumento.Enabled = False
Else
   Cmb_Tipo_Instrumento.Enabled = True
End If

If Cmb_Control_Moneda.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
   Cmb_Tipo_Moneda.ListIndex = -1
   Cmb_Tipo_Moneda.Enabled = False
Else
   Cmb_Tipo_Moneda.Enabled = True
End If
    
End Sub

Private Sub Cmb_Tipo_Operacion_KeyPress(KeyAscii As Integer)

If Cmb_Tipo_Instrumento.Enabled Then
   Cmb_Tipo_Instrumento.SetFocus
ElseIf Cmb_Tipo_Moneda.Enabled Then
       Cmb_Tipo_Moneda.SetFocus
Else
   Cmb_Tipo_Voucher.SetFocus
End If

End Sub



Private Sub Cmb_tipo_voucher_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then Txt_Glosa.Enabled = True: Txt_Glosa.SetFocus

End Sub


Private Sub Cmd_aceptar_PV_Click()
Dim Sql As String
Dim datos()
Dim X As Integer

Screen.MousePointer = 11

If Not FUNC_VALIDA_INGRESO_PERFIL("PV") Then
   Screen.MousePointer = 0
   MsgBox "Falta Información del Perfil Variable.", vbCritical
   Exit Sub
End If

Sql = "SP_BORRA_PERFIL_VARIABLE "
Sql = Sql & Gr_Filas
If miSQL.SQL_Execute(Sql) <> 0 Then
   Screen.MousePointer = 0
   Exit Sub
End If

For X = 1 To Gr_perfil_PV.Rows - 1
    If Trim(TextMatrix(Gr_perfil_PV, X, 1, "X")) <> "" Then
        Sql = "SP_GRABA_PERFIL_VARIABLE "
        Sql = Sql & Gr_Filas & ",'"
        Sql = Sql & TextMatrix(Gr_perfil_PV, X, 0, "X") & "','"
        Sql = Sql & TextMatrix(Gr_perfil_PV, X, 1, "X") & "','"
        Sql = Sql & TextMatrix(Gr_perfil_PV, X, 2, "X") & "',"
        Sql = Sql & Val(Right(Cmb_Condiciones, 7))
        If miSQL.SQL_Execute(Sql) <> 0 Then
           Screen.MousePointer = 0
           Exit Sub
        End If
    End If
Next

Screen.MousePointer = 0

Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_DESC_CUENTA, "Perfil Variable Completo")
Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_CAMPO_VARIABLE, Trim(Right(Cmb_Condiciones.Text, 3)))

Cmd_exit_opciones_Click

End Sub
Sub PROC_CREA_GRILLA_PASO()

' GRILLA PERFIL VARIABLE
'Gr_perfil_paso.Rows = 1
'Gr_perfil_paso.Cols = 3

End Sub


Private Sub Cmd_Agrega_Click()

Gr_perfil.AddItem ""
Gr_perfil.SetFocus

End Sub

Private Sub Cmd_Agrega_PV_Click()

Gr_perfil_PV.AddItem ""
Gr_perfil_PV.SetFocus

End Sub

Private Sub Cmd_ayuda_perfil_Click()

    BacAyuda.Tag = "PERFIL"
    BacAyuda.parAyuda = "BAC_CNT_PERFIL"
    BacAyuda.Show 1

    If Trim(gscodigo$) <> "" Then
    
       Folio_Perfil = Val(gscodigo$)
    
       PROC_BUSCA_PERFIL Folio_Perfil
       
       Frm_Perfil.Enabled = True
       Cmd_Buscar.Enabled = False
       Cmd_Grabar.Enabled = True
       Cmd_Eliminar.Enabled = True
    
       Gr_perfil.Row = 1
       Gr_perfil.Col = C_CAMPO
       Gr_perfil.SetFocus
       SendKeys "^{HOME}"

    Else
       Cmb_Sistema.SetFocus
    End If

End Sub



Private Sub Cmd_Buscar_Click()
Dim varsSist    As String
Dim varsMov     As String
Dim varsOper    As String
Dim varsInstr   As String
Dim varsMone    As String
Dim cSql        As String
Dim varNumeros  As Integer
Dim varData()

varsSist = Right(Cmb_Sistema.Text, 3)
varsMov = Right(Cmb_Tipo_movimiento.Text, 3)
varsOper = Trim$(Right(Cmb_Tipo_operacion.Text, 5))

If Cmb_Control_Instrumento.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
   varsInstr = ""
Else
   varsInstr = Left(Cmb_Tipo_Instrumento.Text, 6)
End If

If Cmb_Control_Moneda.List(Cmb_Tipo_operacion.ListIndex) = "N" Then
   varsMone = ""
Else
   varsMone = Val(Right(Cmb_Tipo_Moneda.Text, 6))
End If

cSql = "EXECUTE sp_leer_perfil_Busca "
cSql = cSql & "'" & varsSist & "',"
cSql = cSql & "'" & varsMov & "',"
cSql = cSql & "'" & varsOper & "',"
cSql = cSql & "'" & varsInstr & "',"
cSql = cSql & "'" & varsMone & "'"

If miSQL.SQL_Execute(cSql) = 0 Then
   Do While miSQL.SQL_Fetch(varData()) = 0
      varNumeros = varData(1)
      Folio_Perfil = varNumeros
   Loop
End If

PROC_BUSCA_PERFIL (varNumeros)
    
Frm_Perfil.Enabled = True
Cmd_Buscar.Enabled = False
Cmd_Grabar.Enabled = True
Cmd_Eliminar.Enabled = True
    
Gr_perfil.Row = 1
Gr_perfil.Col = C_CAMPO
Gr_perfil.SetFocus
SendKeys "^{HOME}"
   
End Sub

Private Sub Cmd_Cargar_Click()
Dim Sql     As String
Dim Cuenta As String
Dim Descri As String
Dim Porc As Double
Dim DivNum As Double
Dim Tot As Double
Dim NumReg As Double

If MsgBox("Seguro de Cargar ?", 36) <> 6 Then Exit Sub

Me.MousePointer = 11

DataFox.Recordset.MoveLast

Tot = DataFox.Recordset.RecordCount

fraCargaCtas.Visible = True
fraCargaCtas.Refresh

Sql = ""
'Sql = "DELETE FROM CON_PLAN_CUENTAS"
Sql = "SP_ELIMINA_CONPLANCUENTAS "
If miSQL.SQL_Execute(Sql) <> 0 Then
        Me.MousePointer = 0
        Exit Sub
End If

Pnl_Porcentaje.FloodPercent = 0

NumReg = 1

DataFox.Recordset.MoveFirst

Do While Not DataFox.Recordset.EOF

    Pnl_Porcentaje.FloodPercent = (NumReg * 100) / Tot

    NumReg = NumReg + 1

    Cuenta = Trim(DataFox.Recordset("Entidad") & DataFox.Recordset("Moneda") & DataFox.Recordset("Cuenta"))
    Descri = Trim(DataFox.Recordset("Glosal"))

    Sql = ""
    Sql = "EXECUTE sp_grabar_Cuenta "
    Sql = Sql & "'" & Cuenta & "',"
    Sql = Sql & "'" & Descri & "',"
    Sql = Sql & "'" & DataFox.Recordset("TipoCta") & "'"
  
      
    If miSQL.SQL_Execute(Sql) <> 0 Then
        MsgBox "Operación no se realizó con exito" & Sql, vbCritical, gsBac_Version
        Me.MousePointer = 0
        Exit Sub
    End If
    
    DataFox.Recordset.MoveNext
Loop

fraCargaCtas.Visible = False

Me.MousePointer = 0

End Sub

Private Sub Cmd_Elimina_Click()

Gr_perfil.RemoveItem Gr_perfil.Row
Gr_perfil.AddItem ""
Gr_perfil.SetFocus

End Sub

Private Sub Cmd_Elimina_PV_Click()

Gr_perfil_PV.RemoveItem Gr_perfil_PV.Row
Gr_perfil_PV.AddItem ""
Gr_perfil_PV.SetFocus

End Sub

Private Sub Cmd_Eliminar_Click()
   
If MsgBox("Seguro de Eliminar Perfil ?", 36) = 6 Then
   PROC_ELIMINA_PERFIL Folio_Perfil
End If

End Sub

Private Sub Cmd_exit_opciones_Click()

PROC_HABILITA_PV True

Frm_perfil_PV.Visible = False

PROC_MARCA_FILA_GRILLA Gr_perfil, G_COLOR_BLANCO, G_COLOR_NEGRO, Gr_perfil.Row, 0

Gr_perfil.SetFocus

End Sub
Sub PROC_MARCA_FILA_GRILLA(Objeto_grid As Control, Color1, Color2, Fila, Columna)

fila_actual% = Objeto_grid.Row
'fila_rango% = Objeto_grid.RowSel
columna_actual% = Objeto_grid.Col
'columna_rango% = Objeto_grid.ColSel
estilo_fila% = Objeto_grid.FillStyle

Objeto_grid.Row = Fila
'Objeto_grid.RowSel = Fila
Objeto_grid.Col = Columna
'Objeto_grid.ColSel = Objeto_grid.Cols - 1
Objeto_grid.FillStyle = flexFillRepeat
'Objeto_grid.CellBackColor = Color1
'Objeto_grid.CellForeColor = Color2

Objeto_grid.Row = fila_actual%
'Objeto_grid.RowSel = fila_rango%
Objeto_grid.Col = columna_actual%
'Objeto_grid.ColSel = columna_rango%
Objeto_grid.FillStyle = estilo_fila%

End Sub

Function FUNC_FMT_NUMERO_TXT(Numero As Double, n_enteros, n_decimales As Integer) As String
Dim fmt_numero    As String
Dim fmt_enteros   As String
Dim fmt_decimales As String

If Numero < 0 Then Numero = Numero * -1

fmt_enteros = String(n_enteros, "0")
fmt_decimales = String(n_decimales, "0")

fmt_numero = Format(Numero, fmt_enteros + "." + fmt_decimales)

FUNC_FMT_NUMERO_TXT = Mid(fmt_numero, 1, n_enteros) + Mid(fmt_numero, n_enteros + 2, n_decimales)

End Function
Private Sub Cmb_Tipo_Moneda_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
   Cmb_Tipo_Voucher.Enabled = True
   Cmb_Tipo_Voucher.SetFocus
End If

End Sub

Private Sub Cmb_Tipo_Instrumento_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then

   If Cmb_Tipo_Moneda.Enabled Then
      Cmb_Tipo_Moneda.SetFocus
   Else
      Cmb_Tipo_Voucher.SetFocus
   End If
   
End If

End Sub

Private Sub Cmd_Grabar_Click()

   If Not FUNC_VALIDA_INGRESO_PERFIL("PF") Then
      MsgBox "Falta Información para Grabar.", vbCritical
      Exit Sub
   End If

   If MsgBox("Seguro de Grabar Perfil ?", 36) <> 6 Then Exit Sub
   
   Screen.MousePointer = 11
   
   PROC_GRABA_PERFIL
   
   Screen.MousePointer = 0
     
   PROC_LIMPIA
     
   Cmb_Sistema.SetFocus

End Sub

Private Sub Cmd_Limpiar_Click()
If MsgBox("Desea Limpiar ? ", 36, "Perfiles Contables") = 6 Then
     PROC_LIMPIA
     
     Cmb_Sistema.SetFocus

End If
End Sub


Private Sub Cmd_Perfil_Click()

Gr_perfil.Col = C_PERFIL_FIJO
Gr_perfil_DblClick

End Sub

Private Sub Form_Activate()

    Screen.MousePointer = vbNormal
    
End Sub

Private Sub Form_Load()
On Error GoTo ErrCarg
Me.Top = 0
Me.Left = 0
    Frm_perfil_PV.Top = 1680
    Frm_perfil_PV.Left = 300

    PROC_CARGA_COMBO_SISTEMA    '  Carga Combos iniciales
    Txt_Glosa.Enabled = True
    
    PROC_LIMPIA
    
    DataFox.Connect = "FoxPro 2.6"
    DataFox.DatabaseName = gsFox_Contabco   'Dirección en donde se entcuetra DBF conmaect
    DataFox.RecordSource = "conmaect.dbf"
    DataFox.Refresh
    Exit Sub
    
ErrCarg:
   If Err.Number = 3051 Then
    MsgBox "No se puede conectar a tabla plan de cuentas ", vbOKOnly + vbExclamation
  Else
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
  End If
  Unload Me
  Exit Sub
End Sub
Function FUNC_FORMATO_CUENTA(Texto As String, Formato As String) As String

If Trim(Texto) = "" Then
   FUNC_FORMATO_CUENTA = ""
   Exit Function
End If
 FUNC_FORMATO_CUENTA = Texto
'If Formato = "F" Then
'   FUNC_FORMATO_CUENTA = Mid(Texto, 1, 2) + "." + Mid(Texto, 3, 2) + "." + Mid(Texto, 5, 2) + "." + Mid(Texto, 7, 3)
'Else
'   FUNC_FORMATO_CUENTA = Mid(Texto, 1, 2) + Mid(Texto, 4, 2) + Mid(Texto, 7, 2) + Mid(Texto, 10, 3)
'End If

End Function


Function FUNC_VALIDA_CUENTA(Cuenta As String, tipo_perfil As String) As Integer
Dim datos()


Screen.MousePointer = 11

FUNC_VALIDA_CUENTA = False

Comando$ = "EXECUTE sp_busca_cuenta_contable "
Comando$ = Comando$ + "'" + Cuenta + "'"

If miSQL.SQL_Execute(Comando$) <> 0 Then
   Screen.MousePointer = 0
   Exit Function
End If

Screen.MousePointer = 0

If miSQL.SQL_Fetch(datos()) = -1 Then
   MsgBox "Cuenta NO Existe.", vbCritical
   Exit Function
End If

If Trim(datos(5)) <> "S" Then  ' Cuenta SVS
   MsgBox "Cuenta NO Imputable.", vbCritical
   Exit Function
End If

Select Case tipo_perfil
       Case "PF":  Call TextMatrix(Gr_perfil, Gr_perfil.Row, C_DESC_CUENTA, Trim(datos(1)))
       Case "PV":  Call TextMatrix(Gr_perfil_PV, Gr_perfil_PV.Row, C2_DESC_CUENTA, Trim(datos(1)))
'       Case "PV2": Call TextMatrix(Gr_perfil_PV2, Gr_perfil_PV2.Row, C3_DESC_CUENTA, Trim(datos(1)))
End Select

FUNC_VALIDA_CUENTA = True

End Function

Sub PROC_CREA_GRILLA_PERFIL()

Gr_perfil.Rows = 2
Gr_perfil.Cols = 7

Gr_perfil.Row = 0
Gr_perfil.Col = C_CAMPO: Gr_perfil.Text = "Campo"
Gr_perfil.Col = C_DESC_CAMPO: Gr_perfil.Text = "Descripción Campo"
Gr_perfil.Col = C_PERFIL_FIJO: Gr_perfil.Text = "P/F"
Gr_perfil.Col = C_TIPO_MOV: Gr_perfil.Text = "T/M"
Gr_perfil.Col = C_NCUENTA: Gr_perfil = "Cuenta"
Gr_perfil.Col = C_DESC_CUENTA: Gr_perfil.Text = "Descripción Cuenta"

Gr_perfil.ColWidth(C_CAMPO) = 600
Gr_perfil.ColWidth(C_DESC_CAMPO) = 3500
Gr_perfil.ColWidth(C_PERFIL_FIJO) = 400
Gr_perfil.ColWidth(C_TIPO_MOV) = 400
Gr_perfil.ColWidth(C_NCUENTA) = 1100
Gr_perfil.ColWidth(C_DESC_CUENTA) = 4500
Gr_perfil.ColWidth(C_CAMPO_VARIABLE) = 1

Gr_perfil.ColAlignment(C_CAMPO) = flexAlignRightCenter
Gr_perfil.ColAlignment(C_DESC_CAMPO) = flexAlignLeftCenter
Gr_perfil.ColAlignment(C_PERFIL_FIJO) = flexAlignLeftCenter
Gr_perfil.ColAlignment(C_TIPO_MOV) = flexAlignLeftCenter
Gr_perfil.ColAlignment(C_NCUENTA) = flexAlignLeftCenter
Gr_perfil.ColAlignment(C_DESC_CUENTA) = flexAlignLeftCenter
Gr_perfil.ColAlignment(C_CAMPO_VARIABLE) = flexAlignLeftCenter

Gr_perfil.Rows = 21
Gr_perfil.FixedRows = 1
Gr_perfil.FixedCols = 0
Gr_perfil.Row = 1
Gr_perfil.Col = 0

End Sub

Private Sub Form_Unload(Cancel As Integer)
'If Not MsgBox("Está seguro de salir ? ", 36, "Perfiles Contables") = 6 Then
        ' Cancel = True
'End If
    
End Sub

Private Sub Gr_perfil_DblClick()
Dim Sql            As String
Dim campo_variable As Integer
Dim datos()

Gr_Filas = Gr_perfil.Row

If Gr_perfil.Col = C_PERFIL_FIJO Then

   If Trim(Gr_perfil.Text) = "S" Or Trim(Gr_perfil.Text) = "" Then Exit Sub
   
   Screen.MousePointer = 11
   
   PROC_HABILITA_PV False

   PROC_PASA_GRILLA_PV
   
   PROC_MARCA_FILA_GRILLA Gr_perfil, G_COLOR_CLARO, G_COLOR_NEGRO, Gr_perfil.Row, 0
   
   'VicBarra
   Sql = "EXECUTE sp_leer_campos "
   Sql = Sql & "'" & Trim(Right(Cmb_Sistema, 3)) & "',"
   Sql = Sql & "'" & Trim(Right(Cmb_Tipo_movimiento, 3)) & "',"
   Sql = Sql & "'" & Trim(Right(Cmb_Tipo_operacion, 5)) & "'"
   If miSQL.SQL_Execute(Sql) <> 0 Then
      Screen.MousePointer = 0
      MsgBox "Problemas en la Lectura de Campos.", vbCritical, "Pc-Trader"
      Exit Sub
   End If
   
   Cmb_Condiciones.Clear
   
   Do While miSQL.SQL_Fetch(datos()) = 0
      Cmb_Condiciones.AddItem datos(5) + Space(80) + Format(datos(4), "#0")
   Loop
   
   If Cmb_Condiciones.ListCount <> 0 Then
   
      campo_variable = Val(TextMatrix(Gr_perfil, (Gr_perfil.Row), C_CAMPO_VARIABLE, "X"))
   
      If campo_variable > 0 Then
         For i% = 0 To Cmb_Condiciones.ListCount - 1
             Cmb_Condiciones.ListIndex = i%
             If campo_variable = Val(Right(Cmb_Condiciones.Text, 3)) Then Exit For
         Next i%
      Else
         Cmb_Condiciones.ListIndex = 0
      End If
      
   End If
      
   FUNC_BUSCAR_PERFIL_VARIABLE (Gr_Filas)
   
   Screen.MousePointer = 0
   
   If Cmb_Condiciones.ListCount > 0 Then
      Frm_perfil_PV.Visible = True
      Gr_perfil_PV.SetFocus
        
      SendKeys "^{HOME}"
    Else
      MsgBox "No existen condiciones lógicas para este tipo de operación", vbInformation, gsBac_Version
      PROC_HABILITA_PV True
   End If
   
End If

If Gr_perfil.Col = C_CAMPO Then
   BacAyuda.Tag = "CAMPOS"
   BacAyuda.parFiltro = Right(Cmb_Sistema.Text, 3) + Right(Cmb_Tipo_movimiento.Text, 3) + Trim(Right(Cmb_Tipo_operacion.Text, 5))
   BacAyuda.parAyuda = "CON_CAMPOS_PERFIL"

   BacAyuda.Show 1

   If Trim(gscodigo$) <> "" Then
      Txt_ingreso_campos.MaxLength = 5
      Txt_ingreso_campos.Text = Trim(gscodigo$)
      Txt_Ingreso_Campos_KeyPress 13
   End If
   
End If

If Gr_perfil.Col = C_NCUENTA Then
 
   If Trim(TextMatrix(Gr_perfil, Gr_perfil.Row, C_PERFIL_FIJO, "X")) <> "S" Then Exit Sub
    BacAyuda.parAyuda = "CON_PLAN_CUENTAS"
    BacAyuda.Tag = "CUENTAS"
    BacAyuda.Show 1
    
    If giAceptar = True Then
        If Trim(gscodigo$) <> "" Then
            Txt_ingreso_campos.MaxLength = 12
            Txt_ingreso_campos.Text = FUNC_FORMATO_CUENTA(Trim(gscodigo$), "D")
            Txt_Ingreso_Campos_KeyPress 13
        End If
    End If
End If

End Sub

Private Sub Gr_perfil_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
   SendKeys "{RIGHT}"
   Exit Sub
End If

KeyAscii = Asc(UCase(Chr(KeyAscii)))

If KeyAscii = 27 Or Gr_perfil.Col = C_DESC_CAMPO Or Gr_perfil.Col = C_DESC_CUENTA Then Exit Sub

If Not FUNC_VALIDA_LINEA() Then Exit Sub

'If Gr_perfil.Col <> C_CAMPO And Trim(TextMatrix(Gr_perfil, Gr_perfil.Row, C_CAMPO, "X")) = "" Then Exit Sub

'If Gr_perfil.Col = C_NCUENTA Then

'   If Mid(TextMatrix(Gr_perfil, Gr_perfil.Row, C_PERFIL_FIJO, "X"), 1, 1) <> "S" Then Exit Sub
   
'End If

'If Gr_perfil.Col = C_CAMPO Then
'   BacCaracterNumerico KeyAscii

'   If KeyAscii = 0 Then Exit Sub
'Else
'   BacToUCase KeyAscii
'End If

PROC_POSICIONA_TEXTO Gr_perfil, Txt_ingreso_campos

If KeyAscii = 8 Then

   If Gr_perfil.Col = C_NCUENTA Then
      Txt_ingreso_campos.Text = FUNC_FORMATO_CUENTA(Gr_perfil.Text, "D")
   Else
      Txt_ingreso_campos.Text = Trim(Gr_perfil.Text)
   End If
   
Else
   Txt_ingreso_campos.Text = Chr(KeyAscii)
End If

Txt_ingreso_campos.Visible = True
Txt_ingreso_campos.SetFocus
SendKeys "{END}"

End Sub


Function FUNC_VALIDA_LINEA() As Integer

FUNC_VALIDA_LINEA = False

If Gr_perfil.Row > 1 Then
    
   For i% = C_CAMPO To C_PERFIL_FIJO
       If Trim(TextMatrix(Gr_perfil, Gr_perfil.Row - 1, i%, "X")) = "" Then Exit For
   Next i%
   
   If i% <= C_PERFIL_FIJO Then Exit Function
   
End If

FUNC_VALIDA_LINEA = True

End Function


Private Sub Gr_perfil_PV_DblClick()

If Gr_perfil_PV.Row > 1 Then
   If TextMatrix(Gr_perfil_PV, Gr_perfil_PV.Row - 1, C2_CODIGO, "X") = "" Then Exit Sub
End If

If Gr_perfil_PV.Col = C2_NCUENTA Or Gr_perfil_PV.Col = 1 Then

    BacAyuda.parAyuda = "CON_PLAN_CUENTAS"
    BacAyuda.Tag = "CUENTAS"
    BacAyuda.Show 1

    If Trim(gscodigo$) <> "" Then
       Call TextMatrix(Gr_perfil_PV, Gr_perfil_PV.Row, C2_NCUENTA, FUNC_FORMATO_CUENTA(Trim(gscodigo$), "D"))
       Call TextMatrix(Gr_perfil_PV, Gr_perfil_PV.Row, C2_DESC_CUENTA, BUSCAR_CUENTA(Trim(gscodigo$)))
    End If
   
End If

If Gr_perfil_PV.Col = C2_CODIGO Then

    BacAyuda.parAyuda = "GEN_TABLAS1"
    BacAyuda.parFiltro = Right(Cmb_Sistema.Text, 3) + Right(Cmb_Tipo_movimiento.Text, 3) + RELLENA_STRING(Trim(Right(Cmb_Tipo_operacion.Text, 4)), "D", 4) + "  " + Trim(Right(Cmb_Condiciones.Text, 5))
    BacAyuda.Tag = "CONDICIONES"

    BacAyuda.Show 1

   If Trim(gscodigo$) <> "" Then
      Txt_ingreso_PV.MaxLength = 3
      Gr_perfil_PV.Text = Trim(gscodigo$)
      Txt_ingreso_PV.Text = Trim(gscodigo$)
      Txt_ingreso_PV_KeyPress 13
   End If
   
End If

End Sub


Private Sub Gr_perfil_PV_KeyPress(KeyAscii As Integer)

If Gr_perfil_PV.Col = 0 Or Gr_perfil_PV.Col = 2 Then
   KeyAscii = 0
   Exit Sub
End If
If KeyAscii = 13 Then
   SendKeys "{RIGHT}"
   Exit Sub
End If

If KeyAscii = 27 Or Gr_perfil_PV.Col = C2_DESC_CUENTA Then Exit Sub

If Gr_perfil_PV.Row > 1 Then
   If TextMatrix(Gr_perfil_PV, Gr_perfil_PV.Row - 1, C2_CODIGO, "X") = "" Then Exit Sub
End If

If Gr_perfil_PV.Col = C2_INDICADOR And Mid(Right(Cmb_Tipo_operacion.Text, 10), 1, 6) <> "INSIND" Then Exit Sub

BacToUCase KeyAscii

PROC_POSICIONA_TEXTO Gr_perfil_PV, Txt_ingreso_PV

If KeyAscii = 8 Then

   If Gr_perfil_PV.Col = C2_NCUENTA Then
      Txt_ingreso_PV.Text = FUNC_FORMATO_CUENTA(Gr_perfil_PV.Text, "D")
   Else
      Txt_ingreso_PV.Text = Trim(Gr_perfil_PV.Text)
   End If
   
Else
   Txt_ingreso_PV.Text = Chr(KeyAscii)
End If

Txt_ingreso_PV.Visible = True
Txt_ingreso_PV.SetFocus
SendKeys "{END}"

End Sub


Private Sub Gr_perfil_SelChange()

Select Case Gr_perfil.Col
       Case C_CAMPO:       Lbl_Msg.Caption = " Nombre Campo a Contabilizar"
       Case C_DESC_CAMPO:  Lbl_Msg.Caption = " Descripción Campo"
       Case C_PERFIL_FIJO: Lbl_Msg.Caption = " Perfil Fijo (S=Si / N=No), No=Condiciona Campo por Variables, Si=Ingresar Cuenta"
       Case C_TIPO_MOV:    Lbl_Msg.Caption = " Tipo Movimiento (D=Debe / H=Haber)"
       Case C_NCUENTA:     Lbl_Msg.Caption = " Número de Cuenta Contable"
       Case C_DESC_CUENTA: Lbl_Msg.Caption = " Descripción Cuenta"
End Select

End Sub





Sub PROC_PASA_GRILLA_PASO()

If Gr_perfil_paso.Row = 0 Then
   Gr_perfil_paso.AddItem ""
   Gr_perfil_paso.Row = 0
Else
   Gr_perfil_paso.Row = Gr_perfil_paso.Rows - 1
End If

For i% = 1 To Gr_perfil_PV.Rows - 1

    Gr_perfil_PV.Row = i%
    Gr_perfil_PV.Col = C2_CODIGO
    
    If Trim(Gr_perfil_PV.Text) = "" Then Exit For
       
    If Gr_perfil_paso.Row + 1 > Gr_perfil_paso.Rows - 1 Then Gr_perfil_paso.AddItem ""
    
    Gr_perfil_paso.Row = Gr_perfil_paso.Row + 1
    
    Gr_perfil_paso.Col = 0
    Gr_perfil_paso.Text = Str(Gr_perfil.Row)
    
    Gr_perfil_paso.Col = C2_CODIGO + 1
    Gr_perfil_PV.Col = C2_CODIGO
    Gr_perfil_paso.Text = Gr_perfil_PV.Text
    
    Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_INDICADOR + 1) = Gr_perfil_PV.TextMatrix(i%, C2_INDICADOR)
    
    Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_NCUENTA + 1) = Gr_perfil_PV.TextMatrix(i%, C2_NCUENTA)
    
    Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_DESC_CUENTA + 1) = Gr_perfil_PV.TextMatrix(i%, C2_DESC_CUENTA)
    
Next i%

End Sub


Sub PROC_PASA_GRILLA_PV()

PROC_CREA_GRILLA_PERFIL_PV

'Gr_perfil_PV.Redraw = False

'Gr_perfil_PV.Row = 0

'For i% = 1 To Gr_perfil_paso.Rows - 1

'    Gr_perfil_paso.Row = i%
'    Gr_perfil_paso.Col = 0
    
'    If Val(Gr_perfil_paso.Text) = Gr_perfil.Row Then
    
'       If Gr_perfil_PV.Row + 1 > Gr_perfil_PV.Rows - 1 Then Gr_perfil_PV.AddItem ""
       
'       Gr_perfil_PV.Row = Gr_perfil_PV.Row + 1
       
'       Gr_perfil_PV.TextMatrix(Gr_perfil_PV.Row, c2_codigo) = Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, c2_codigo + 1)
       
'       Gr_perfil_PV.TextMatrix(Gr_perfil_PV.Row, C2_INDICADOR) = Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_INDICADOR + 1)
       
'       Gr_perfil_PV.TextMatrix(Gr_perfil_PV.Row, C2_NCUENTA) = Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_NCUENTA + 1)
       
'       Gr_perfil_PV.TextMatrix(Gr_perfil_PV.Row, C2_DESC_CUENTA) = Gr_perfil_paso.TextMatrix(Gr_perfil_paso.Row, C2_DESC_CUENTA + 1)
                     
'    End If
    
'Next i%

'Gr_perfil_PV.Redraw = True

End Sub

















Private Sub SSCommand1_Click()

End Sub

Private Sub Label5_Click()

End Sub

Private Sub Txt_glosa_KeyPress(KeyAscii As Integer)

Txt_Glosa.MaxLength = 70
BacToUCase KeyAscii

' VB+- Se desabilita el paso a la grilla despues de la glosa del perfil

'If KeyAscii = 13 And Trim(Txt_glosa.Text) <> "" Then
'
'   Gr_perfil.Row = 1
'   Gr_perfil.Col = C_CAMPO
'   Gr_perfil.Enabled = True
'   Gr_perfil.SetFocus
'   SendKeys "{RIGHT}"
'   SendKeys "{LEFT}"
'
'End If

End Sub


Private Sub Txt_Ingreso_Campos_KeyPress(KeyAscii As Integer)

If KeyAscii = 27 Then
   Gr_perfil.SetFocus
   Exit Sub
End If


Select Case Gr_perfil.Col
       Case C_CAMPO:
            Txt_ingreso_campos.MaxLength = 3
            PROC_FMT_NUMERICO Txt_ingreso_campos, 3, 0, KeyAscii, "+"
       Case C_PERFIL_FIJO:
            Txt_ingreso_campos.MaxLength = 1
            BacToUCase KeyAscii
       Case C_TIPO_MOV:
            Txt_ingreso_campos.MaxLength = 1
            BacToUCase KeyAscii
       Case C_NCUENTA:
            Txt_ingreso_campos.MaxLength = 11
            BacToUCase KeyAscii
End Select

If KeyAscii = 13 And Trim(Txt_ingreso_campos.Text) <> "" Then

   If Not FUNC_VALIDA_INGRESO_FIJO() Then
      Txt_ingreso_campos.Text = ""
      Exit Sub
   End If
   
   Gr_perfil.SetFocus
   
End If

End Sub

Sub PROC_FMT_NUMERICO(Texto As Control, NEnteros, NDecs As Integer, ByRef Tecla, Signo As String)

If Tecla = 13 Or Tecla = 27 Then Exit Sub

If Tecla = 45 And Signo = "+" Then Tecla = 0

If Tecla <> 8 And (Tecla < 48 Or Tecla > 57) Then
   If NDecs = 0 Then
      Tecla = 0
   ElseIf Tecla <> 46 And Tecla <> 45 Then
          Tecla = 0
   End If
End If

If Tecla = 45 And Signo = "-" Then  ' Signo negativo
   If InStr(Texto.Text, "-") > 0 Then
      Tecla = 0
   ElseIf Texto.SelStart > 0 Then
          If Mid(Texto.Text, Texto.SelStart, 1) <> "" Then
             Tecla = 0
          End If
   End If
End If

PosPto% = InStr(Texto.Text, ".")
If PosPto% > 0 And Tecla = 46 Then
   Tecla = 0
   Exit Sub
End If

If NDecs > 0 And PosPto% > 0 And PosPto% <= Texto.SelStart Then
   PosPto% = PosPto% + 1
   If Len(Mid(Texto.Text, PosPto%, NDecs)) = NDecs And Tecla <> 8 Then
      Tecla = 0
   Else
      Exit Sub
   End If
End If

If PosPto% > 0 And Texto.SelStart < PosPto% And Tecla <> 8 Then
   If Len(Mid(Texto.Text, 1, PosPto% - 1)) >= NEnteros Then Tecla = 0
ElseIf PosPto% = 0 And Tecla <> 8 And Chr(Tecla) <> "." Then
       If Len(Texto.Text) >= NEnteros Then Tecla = 0
End If

End Sub



Private Sub Txt_Ingreso_Campos_LostFocus()

    Txt_ingreso_campos.Visible = False

End Sub
Private Sub Txt_ingreso_PV_KeyPress(KeyAscii As Integer)
    If KeyAscii = 27 Then
       Gr_perfil_PV.SetFocus
       Exit Sub
    End If
    Txt_ingreso_PV.MaxLength = 11
   
    BacToUCase KeyAscii
    
    If KeyAscii = 13 And Trim(Txt_ingreso_PV.Text) <> "" Then
    
       If Not FUNC_VALIDA_INGRESO_PV() Then
          Txt_ingreso_PV.Text = ""
          Exit Sub
       End If
    
       Gr_perfil_PV.SetFocus
       
    End If

End Sub


Private Sub Txt_ingreso_PV_LostFocus()
Txt_ingreso_PV.Visible = False
End Sub








