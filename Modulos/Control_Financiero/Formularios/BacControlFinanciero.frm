VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "crystl32.ocx"
Begin VB.MDIForm BacControlFinanciero 
   BackColor       =   &H8000000F&
   Caption         =   "  Control Financiero"
   ClientHeight    =   8220
   ClientLeft      =   60
   ClientTop       =   630
   ClientWidth     =   12240
   Icon            =   "BacControlFinanciero.frx":0000
   LinkTopic       =   "MDIForm1"
   Picture         =   "BacControlFinanciero.frx":000C
   WindowState     =   2  'Maximized
   Begin MSWinsockLib.Winsock NomObjWinIP 
      Left            =   480
      Top             =   2400
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin VB.Timer TimerFinanciero 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   10380
      Top             =   60
   End
   Begin Threed.SSPanel PnlInfo 
      Align           =   2  'Align Bottom
      Height          =   420
      Left            =   0
      TabIndex        =   0
      Top             =   7800
      Width           =   12240
      _Version        =   65536
      _ExtentX        =   21590
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
         Height          =   315
         Left            =   90
         TabIndex        =   1
         Top             =   60
         Width           =   4110
         _Version        =   65536
         _ExtentX        =   7250
         _ExtentY        =   556
         _StockProps     =   15
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   12
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
         Left            =   6135
         TabIndex        =   2
         Top             =   45
         Width           =   2205
         _Version        =   65536
         _ExtentX        =   3889
         _ExtentY        =   582
         _StockProps     =   15
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
         BorderWidth     =   1
         BevelOuter      =   0
         BevelInner      =   1
         RoundedCorners  =   0   'False
      End
      Begin Threed.SSPanel PnlUsuario 
         Height          =   315
         Left            =   4200
         TabIndex        =   3
         Top             =   60
         Width           =   1950
         _Version        =   65536
         _ExtentX        =   3440
         _ExtentY        =   556
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
         Left            =   10440
         TabIndex        =   4
         Top             =   45
         Width           =   1335
         _Version        =   65536
         _ExtentX        =   2355
         _ExtentY        =   582
         _StockProps     =   15
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
         BorderWidth     =   1
         BevelOuter      =   0
         BevelInner      =   1
         RoundedCorners  =   0   'False
         Autosize        =   3
      End
      Begin Threed.SSPanel Pnl_DO 
         Height          =   330
         Left            =   8340
         TabIndex        =   5
         Top             =   45
         Width           =   2100
         _Version        =   65536
         _ExtentX        =   3704
         _ExtentY        =   582
         _StockProps     =   15
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
         BorderWidth     =   1
         BevelOuter      =   0
         BevelInner      =   1
         RoundedCorners  =   0   'False
      End
      Begin Threed.SSPanel Pnl_TCRC 
         Height          =   330
         Left            =   11775
         TabIndex        =   9
         Top             =   45
         Width           =   2100
         _Version        =   65536
         _ExtentX        =   3704
         _ExtentY        =   582
         _StockProps     =   15
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
         BorderWidth     =   1
         BevelOuter      =   0
         BevelInner      =   1
         RoundedCorners  =   0   'False
         Autosize        =   3
      End
   End
   Begin Threed.SSPanel PnlTools 
      Align           =   1  'Align Top
      Height          =   540
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   12240
      _Version        =   65536
      _ExtentX        =   21590
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
      Begin MSComDlg.CommonDialog Boton_Dialogo 
         Left            =   3300
         Top             =   60
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin Crystal.CrystalReport CryFinanciero 
         Left            =   7200
         Top             =   75
         _ExtentX        =   741
         _ExtentY        =   741
         _Version        =   348160
         PrintFileLinesPerPage=   60
      End
      Begin Threed.SSCommand CmdOpt10002 
         Height          =   435
         Left            =   150
         TabIndex        =   7
         Top             =   45
         Width           =   495
         _Version        =   65536
         _ExtentX        =   873
         _ExtentY        =   767
         _StockProps     =   78
         Caption         =   "LC"
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
      Begin Threed.SSCommand CmdOpt10003 
         Height          =   435
         Left            =   705
         TabIndex        =   8
         Top             =   45
         Width           =   495
         _Version        =   65536
         _ExtentX        =   873
         _ExtentY        =   767
         _StockProps     =   78
         Caption         =   "MA"
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
   Begin VB.Menu Opt10000 
      Caption         =   "&Controles Crediticios"
      Begin VB.Menu Opt10001 
         Caption         =   "Información Básica"
         HelpContextID   =   1
      End
      Begin VB.Menu Op01 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt10002 
         Caption         =   "Líneas de Crédito Generales"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_Cons_LinCredGen 
         Caption         =   "Consulta Líneas de Crédito Generales"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt10005 
         Caption         =   "Bloqueo y desbloqueo de Líneas por Cliente"
         HelpContextID   =   1
      End
      Begin VB.Menu Op02 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt10003 
         Caption         =   "Matriz Atribuciones por Operador"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt10004 
         Caption         =   "Control de tasa de Operaciones"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt70020 
         Caption         =   "Mantencion Productos"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt10006 
         Caption         =   "Mantencion Glosa Grupal"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt10007 
         Caption         =   "Mant. Exposición Máxima Grupal"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt10011 
         Caption         =   "Mant. Detalle Grupal"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt10009 
         Caption         =   "Mantenedor de Tasas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt_TIMC 
         Caption         =   "Tasa Interés Máxima Convencional"
         Begin VB.Menu Opt_MntTasas 
            Caption         =   "Mantención de Tasas"
         End
         Begin VB.Menu Opc_CITMC 
            Caption         =   "Captura de Interfaz Máx. Convencional"
         End
      End
      Begin VB.Menu Opt10010 
         Caption         =   "Endeudamiento Interbancario"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt10015 
         Caption         =   "Mantenedor de Grupos de Productos"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt10008 
         Caption         =   "Aprobaciones"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt10030 
         Caption         =   "Anulacion Aprobaciones"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt10020 
         Caption         =   "Grupos de Clientes"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt30006 
         Caption         =   "Matriz de Control de Precios"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt10016 
         Caption         =   "Mantencion de Plazos"
         Enabled         =   0   'False
         HelpContextID   =   1
         Visible         =   0   'False
      End
      Begin VB.Menu Op03 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt10018 
         Caption         =   "Lista de Riesgos Internos"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt10019 
         Caption         =   "Pares de Moneda"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt10017 
         Caption         =   "Ponderadores de Riesgo Interno"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt10021 
         Caption         =   "Reemplazar Operaciones por Cotizaciones"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt10022 
         Caption         =   "Modificación de Carteras Fin. / Novación"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_MantLimiteEndeu 
         Caption         =   "Mantención Limite de Endeudamiento"
         HelpContextID   =   1
         Begin VB.Menu Opc_ParamLimitesEndeu 
            Caption         =   "Parámetros Limites de Endeudamiento"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_ClienLimEndeu 
            Caption         =   "Clientes Limites de Endeudamiento"
            HelpContextID   =   2
         End
      End
   End
   Begin VB.Menu Opt30000 
      Caption         =   "Mercado &Externo"
      Begin VB.Menu Opt30004 
         Caption         =   "Matriz de Riesgo Forward"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt30005 
         Caption         =   "Matriz de Riesgo Swap-FRA"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Opt70000 
      Caption         =   "&Administración"
      Begin VB.Menu Opt70010 
         Caption         =   "Cambio de Password"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt70030 
         Caption         =   "Carga de Archivo SAFP"
         HelpContextID   =   1
      End
      Begin VB.Menu OPT_70031 
         Caption         =   "Perfiles de Acceso a Líneas"
         HelpContextID   =   1
      End
      Begin VB.Menu OPT_70032 
         Caption         =   "Recalculo Lineas DRV"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Opt40000 
      Caption         =   "&Informes"
      Begin VB.Menu Opt40002 
         Caption         =   "Atribuciones por Operador"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt40003 
         Caption         =   "Control de Exposicion Maxima"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt40004 
         Caption         =   "Lineas de Credito por contraparte y producto"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt40005 
         Caption         =   "Informe de Aprobaciones"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt40006 
         Caption         =   "Informe de Rechazos"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt40007 
         Caption         =   "Informe Errores Carga"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt40008 
         Caption         =   "Informe Error Tasas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt40009 
         Caption         =   "Impresión de Papeletas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt40010 
         Caption         =   "Matriz de Atribuciones"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt40011 
         Caption         =   "Vctos. Líneas por Operación"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt40012 
         Caption         =   "Operaciones Aprobadas Exceso Líneas"
         HelpContextID   =   1
      End
      Begin VB.Menu opc_Inf_Lim_Globales 
         Caption         =   "Informe Diario de Ventas Cartera Permanente"
         HelpContextID   =   1
      End
      Begin VB.Menu Op_Inf_Diferida 
         Caption         =   "Informe de Lineas Ocupadas Derivados"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt40015 
         Caption         =   "Operaciones del Dia"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt40016 
         Caption         =   "Operaciones ThresHold"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt40017 
         Caption         =   "Excepciones de Control de Precios y Tasas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt40018 
         Caption         =   "Informe de Operaciones Modificadas"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Opt50000 
      Caption         =   "Cons&ultas"
      Begin VB.Menu Opt50005 
         Caption         =   "Monitoreo de Operaciones Pendientes"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt50006 
         Caption         =   "Liberación de Lineas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt50010 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt50011 
         Caption         =   "Mantención de Threshold por Operación"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt50013 
         Caption         =   "Mantención de Middled-Office"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt50012 
         Caption         =   "Mantención de Clasificación de Riesgo Cliente"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_MntTblReduccion 
         Caption         =   "Mantención de Tabla de Reducción"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_MNTCTRLThreshold 
         Caption         =   "Mantención Control Threshold"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_MNTEjecutivos 
         Caption         =   "Mantención de Ejecutivos"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt_LimEndeudamiento 
         Caption         =   "Limite Endeudamiento"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt50015 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt50016 
         Caption         =   "Envio Pago nGine"
         HelpContextID   =   1
      End
      Begin VB.Menu Opt50017 
         Caption         =   "Anula Pago nGine"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Mnu_Coberturas 
      Caption         =   "Coberturas"
      HelpContextID   =   1
      Begin VB.Menu Opc_ModCoberturas 
         Caption         =   "Actualización Coberturas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_MntCurvas 
         Caption         =   "Asignación de Curvas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_InfCoberturas 
         Caption         =   "Informe de Coberturas"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu opt_80000 
      Caption         =   "Salir del Sistema"
      Begin VB.Menu opt_80001 
         Caption         =   "Salir"
         HelpContextID   =   1
      End
   End
End
Attribute VB_Name = "BacControlFinanciero"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim A%
Dim SQL$
Dim Datos()
Dim SW As String

Private Sub MDIForm_Load()

gs_Pusd = False
 
   Me.Icon = BacFiltraFechas.Icon
   Call Unload(BacFiltraFechas)

 
Screen.MousePointer = 11
Call DetectarResolucion(Me, Form1)

If App.PrevInstance Then
    Screen.MousePointer = 0
    MsgBox "Sistema Esta Cargado en Memoria.", vbExclamation, TITSISTEMA
    End
End If

If Not Valida_Configuracion_Regional() Then
    MsgBox "Debe cambiar el formato de fecha como dd/mm/aaaa antes de ejecutar el sistema.", vbCritical, TITSISTEMA
    Screen.MousePointer = 0
    End
End If

If Not BacInit Then
    Screen.MousePointer = 0
    End
End If

gsSQL_Login = Func_Read_INI("usuario", "usuario", App.Path & "\Bac-Sistemas.INI")
gsSQL_Password = Func_Read_INI("usuario", "password", App.Path & "\Bac-Sistemas.INI")
swConeccion = "DSN=SQL_LINEAS;UID="
swConeccion = swConeccion & gsSQL_Login
swConeccion = swConeccion & ";PWD="
swConeccion = swConeccion & gsSQL_Password
swConeccion = swConeccion & ";DSQ=BACLineas"
    
If Not BAC_Login(gsSQL_Login, gsSQL_Password) Then
    Screen.MousePointer = 0
    MsgBox "Problemas de Comunicación con el Servidor SQL", vbCritical, TITSISTEMA
    End
End If

Screen.MousePointer = 0

If Mid(Command, 1, 11) = "GENERA_MENU" Then
    PROC_GENERA_MENU Mid(Command, 13, 3)
    PROC_GENERA_MENU "SCF"
    Call miSQL.SQL_Close
    Screen.MousePointer = 0
    End
End If

Screen.MousePointer = 0

End Sub

Private Sub MDIForm_Activate()


    SW = 1
    gsBAC_SNActiva = "N"

    montosimula = 0

    Screen.MousePointer = 0

    If Not gsBAC_Login Then
        
        If gsc_Parametros.DatosGenerales() Then
            gsBAC_Ingreso = True
            Call ActuaIni(0, "0")
        Else
            MsgBox "Error al Cargar Parametros Generales", vbCritical, TITSISTEMA
            Unload Me
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
            PROC_CARGA_PRIVILEGIOS
        Else
            Unload Me
            Exit Sub
        End If
        '+++cvegasan 2017.06.05 HOM Ex-Itau
        Call GRABA_LOG_AUDITORIA(1 _
                          , CStr(Format(gsBAC_Fecp, "yyyyMMdd")) _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "SCF" _
                          , "" _
                          , "05" _
                          , "Ingreso al Sistema" _
                          , " " _
                          , " " _
                          , " ")
        '---cvegasan 2017.06.05 HOM Ex-Itau
    End If

   CmdOpt10002.Enabled = Opt10002.Enabled
   CmdOpt10003.Enabled = Opt10003.Enabled

   Me.PnlEstado.FontSize = 8
   Me.PnlFecha.FontSize = 8
   Me.Pnl_UF.FontSize = 8
   Me.Pnl_DO.FontSize = 8
   Me.PnlUsuario.FontSize = 8
   Me.Pnl_TCRC.FontSize = 8

   Me.PnlEstado.Caption = Space(1) + gsBAC_Clien
   Me.PnlFecha.Caption = Format(gsBAC_Fecp, gsc_FechaDMA)
   Me.Pnl_UF.Caption = "U.F. : " & Format(gsBAC_ValmonUF, "#,##0.00")
   Me.Pnl_DO.Caption = "D.O. : " & Format(gsBAC_DolarOBs, "#,##0.00")
   
   Me.Pnl_TCRC.Caption = "TCRC : " & Format(giBAC_TCRC, "#,##0.0000")
   
   'PRD-5157, 20-01-2010
   Me.PnlUsuario.Caption = gsBAC_User
   
   FechaSistema = Format(gsBAC_Fecp, gsc_FechaDMA)

   Screen.MousePointer = 0

End Sub

Private Sub MDIForm_QueryUnload(Cancel As Integer, UnloadMode As Integer)
 Dim salir As Integer
 
 If gsBAC_Login Then
   salir = MsgBox("Seguro que desea Salir", vbQuestion + vbYesNo, TITSISTEMA)
   
   If salir = 6 Then
      Call Salida_Usuario
   End If

   If salir <> 6 Then
       Cancel = True
    Else
        End
   End If
   
 End If
End Sub

Private Sub MDIForm_Unload(Cancel As Integer)

Dim sale

sale = MsgBox("¿Seguro de Salir?", vbYesNo + vbQuestion, TITSISTEMA)

If sale = 6 Then
    Call Salida_Usuario
    
    If gsBAC_Login Then
        If A <> 1 Then
            If Bloquea_Usuario(False, gsBAC_User) Then

            End If
      End If
     
   End If
   
   Call GRABA_LOG_AUDITORIA(1, _
                            Format(gsBAC_Fecp, "yyyymmdd"), _
                            gsBac_IP, _
                            gsBAC_User, _
                            "SCF", _
                            "", _
                            "06", _
                            "Salida del Sistema", _
                            "", _
                            "", _
                            "")
   miSQL.SQL_Close
   End
Else
    Cancel = True
End If

End Sub
Private Sub Op_Inf_Utilidad_Diferida_Click()
    
    Rpt_Utilidad_Diferida.Show vbNormal

End Sub

Private Sub Op_Inf_Diferida_Click()
    
    Rpt_Utilidad_Diferida.Show vbNormal

End Sub

Private Sub Opc_CITMC_Click()
    BacCapturaMaxConvencional.Show
End Sub

Private Sub Opc_ClienLimEndeu_Click()
    BacLimEndeuClien.Show
End Sub

Private Sub Opc_Cons_LinCredGen_Click()
    BacLinCreGen3Consult.Show  'PROD-10967
End Sub

Private Sub opc_Inf_Lim_Globales_Click()
    FRM_GEN_INF_LimitesGlobales.Show
End Sub

Private Sub Opc_InfCoberturas_Click()
   FRM_INFORMES_COBERTURA.Show
End Sub

Private Sub Opc_MntCurvas_Click()
   FRM_MNT_CURVAS_IBS.Show
End Sub

Private Sub OPC_MNTEjecutivos_Click()
   FRM_MNT_EJECUTIVOS.Show
End Sub

Private Sub OPC_MntTblReduccion_Click()
   FRM_MNT_REDTHRESHOLD.Show
End Sub

Private Sub Opc_ModCoberturas_Click()
   
   FRM_ProcCoberturas.Show 1
End Sub

Private Sub Opc_ParamLimitesEndeu_Click()
    BacEndeudamiento.Show
End Sub

Private Sub OPT_70031_Click()
   FRM_MNT_PERFILUSUARIO.Show
End Sub

Private Sub OPT_70032_Click()
     FRM_RECALCULO_LINEAS.Show 'PROD-10967
End Sub

Private Sub Opt_CapIntMaxConv_Click()
    'BacCapturaMaxConvencional.Show
End Sub

Private Sub Opt_MntTasas_Click()
    BacTasConv.Show
End Sub

'LD1-COR-035
'Reportes - Consulta - Endeudamiento
Private Sub Opt_LimEndeudamiento_Click()
  BacLimEndeuInter.Show

End Sub

Private Sub Opt10001_Click()
    BacInfBas.Show
End Sub

Private Sub Opt10002_Click()
    BacLinCreGen3.Show
End Sub

Private Sub Opt10003_Click()
    BacMatrizAtri.Show
End Sub

Private Sub Opt10004_Click()
    BacConOper.Show
End Sub

Private Sub Opt10005_Click()
    BacFrmCLin.Show
End Sub

Private Sub Opt10006_Click()
    FrmGlosaPosicion.Show
End Sub

Private Sub Opt10007_Click()
    FrmPosicionGrupo.Show
End Sub

Private Sub Opt10008_Click()
   FrmManAprobaciones.Show
End Sub

Private Sub Opt10009_Click()
   FrmMantenedorTasa.Show
End Sub

Private Sub Opt10010_Click()
        BacMntArt84.Show
End Sub

Private Sub Opt10011_Click()
    BacDetalleGrupo.Show
End Sub

Private Sub Opt10015_Click()
    BacGrupoProd.Show

End Sub

Private Sub Opt10016_Click()
    
    Frm_Mnt_Plazos.Show

    

End Sub

Private Sub Opt10017_Click()
   FRM_MATRIZ_RIESGO.Show
End Sub
Private Sub Opt10018_Click()
   FRM_MNT_RIESGOINTERNO.Show
End Sub
Private Sub Opt10019_Click()
   FRM_PAR_MONEDAS.Show
End Sub

Private Sub Opt10020_Click()
    BacGrupoCliente.Show
End Sub

Private Sub Opt10021_Click()
   BacOperacionesPorCotizaciones.Show
End Sub

Private Sub Opt10022_Click()
   BacModificacionCarterasFinancieras.Show
End Sub

Private Sub Opt10030_Click()
Call Frm_Anula_Aprobacion.Show
End Sub

Private Sub Opt30004_Click()
    BacMatRieFwd.Show
End Sub

Private Sub Opt30005_Click()
   BacMatRiesgoSwap.Show
End Sub

Private Sub Opt30006_Click()
   FRM_MNT_MATRIZ_CONTROL.Show
End Sub

Private Sub Opt40005_Click()
FrmAprobar.Show
End Sub

Private Sub Opt40006_Click()
FrmRechazo.Show
End Sub


Private Sub Opt40007_Click()
Reporte_Error = "CARGA"
FRM_Informes.Show
End Sub

Private Sub Opt40008_Click()
Reporte_Error = "TASAS"
FRM_Informes.Show
End Sub

Private Sub Opt40009_Click()
    BacImpresiones.Show
End Sub

Private Sub Opt40010_Click()
        MatAtriOpe.Show
End Sub

Private Sub Opt40011_Click()
    BacFiltraFechas.tag = "VctoLinOper"
    BacFiltraFechas.Show vbNormal
    BacFiltraFechas.DateText2.Enabled = False
End Sub

Private Sub Opt40012_Click()
    BacFiltraFechas.tag = "OperAprobLineas"
    BacFiltraFechas.Show vbNormal
End Sub

Private Sub Opt40015_Click()
   Call Proc_Genera_Excel_Oper_Dia
End Sub

Private Sub Opt40016_Click()
   FRM_CON_THRESHOLD.Show
  'BacConsultaThresHold.Show
End Sub

Private Sub Opt40017_Click()
    BacRepExcepciones.Show
End Sub
Private Sub Opt40018_Click()
    FRM_INF_OP_MODIFICADAS.Show
End Sub

Private Sub Opt50006_Click()
   FRM_GEN_Libera_Lineas.Show
End Sub

Private Sub Opt50011_Click()
    FRM_MNT_THRESHOLD.Show
End Sub

Private Sub Opt50012_Click()
    FRM_MNT_DatosClientes.Show
End Sub

Private Sub Opt50013_Click()
    BacMiddled_Office.Show 'PROD-10967
End Sub

'-->2021.06.04 cvegasan Integracion Bac-nGine
Private Sub Opt50016_Click()
     FRM_Envio_Pago_nGine.Show
End Sub

Private Sub Opt50017_Click()
     FRM_Anula_Pago_nGine.Show
End Sub

'--<2021.06.04 cvegasan Integracion Bac-nGine
Private Sub Opt70010_Click()

   If Trim(gsBAC_User) = "ADMINISTRA" Then
     MsgBox "Clave de Administrador no puede ser cambiada desde el sistema", vbOKOnly + vbExclamation, TITSISTEMA
     Exit Sub
   End If

   oBligacion = False
   Cambio_Password.tag = "Z"
   Cambio_Password.Show vbModal

End Sub

Private Sub Opt70020_Click()
    FrmMantenedorProducto.Show
End Sub

Private Sub Opt70030_Click()
    FrmCargaArchivo.Show
End Sub

Private Sub Opt40001_Click()
   FrmImprimir.Show
End Sub

Private Sub Opt40002_Click()
   Frm_Rpt_Usuarios.Show
End Sub

Private Sub Opt40003_Click()
    Call Limpiar_Cristal
    BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "rptcontmax.rpt"
    BacControlFinanciero.CryFinanciero.StoredProcParam(0) = gsBAC_User
    BacControlFinanciero.CryFinanciero.Connect = swConeccion
    BacControlFinanciero.CryFinanciero.Action = 1
End Sub

Private Sub Opt40004_Click()
     FRM_INF_LINCRAPRO.Show
End Sub

Private Sub Opt50005_Click()
   BacMonitorOperPend.Show
End Sub

Private Sub opt_80001_Click()
    Unload Me
End Sub

Private Sub CmdOpt10002_Click()
   Opt10002_Click
End Sub

Private Sub CmdOpt10003_Click()
   Opt10003_Click
End Sub

'LD1-COR-035
'Reportes - Consulta - Endeudamiento
Private Sub Opt_0202020000_Click()

 
End Sub

Private Function BAC_Login(sUser$, sPWD$) As Boolean

   BAC_Login = False
'+++cvegasan 2017.06.05 HOM Ex-Itau
   If giSQL_ConnectionMode = 3 Then
        gsBAC_User = UCase(Trim(Environ("username")))
        gsBAC_Term = Trim(Environ("userdomain"))
        miSQL.Login = gsBAC_User
        miSQL.Password = ""
   End If
'---cvegasan 2017.06.05 HOM Ex-Itau
   miSQL.ServerName = gsSQL_Server$
   miSQL.HostName = gsBAC_Term
   miSQL.Application = "CONTROL FINANCIERO"
   miSQL.ConnectionMode = giSQL_ConnectionMode
   miSQL.DatabaseName = gsSQL_Database
   gsBac_IP = BacControlFinanciero.NomObjWinIP.LocalIP
 
   If giSQL_ConnectionMode = 1 Then
      miSQL.Login = gsSQL_Login$
      miSQL.Password = gsSQL_Password$
        gsBAC_User = UCase(Trim(Environ("username")))
        gsBAC_Term = Trim(Environ("ComputerName"))
   ElseIf giSQL_ConnectionMode = 2 Then
      miSQL.Login = sUser$
      miSQL.Password = sPWD$
   End If
 
'   If giSQL_ConnectionMode = 1 Then
'      miSQL.Login = gsSQL_Login$
'      miSQL.Password = gsSQL_Password$
'   ElseIf giSQL_ConnectionMode = 2 Then
'      miSQL.Login = sUser$
'      miSQL.Password = sPWD$
'   End If
 
   miSQL.LoginTimeout = giSQL_LoginTimeOut
   miSQL.QueryTimeout = giSQL_QueryTimeOut
 
   If miSQL.SQL_Coneccion() = False Then
       BAC_Login = False
       Exit Function
   End If
 
   BAC_Login = True

End Function

Private Function PROC_GENERA_MENU(entidad As String)
   
   Dim SQL         As String
   Dim indice      As Integer: indice = 1
   Dim Primera_Vez As String: Primera_Vez = "S"
   Dim i%

   For i% = 0 To Me.Controls.Count - 1
   
      If TypeOf Me.Controls(i%) Is Menu Then
          
         If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" And Me.Controls(i%).Visible And Me.Controls(i%).Caption <> "Salir" Then
            
            Envia = Array(Primera_Vez, _
                          entidad, _
                          Str(indice), _
                          Me.Controls(i%).Caption, _
                          Me.Controls(i%).Name, _
                          Val(Me.Controls(i%).HelpContextID))
            indice = indice + 1

            If Not Bac_Sql_Execute("SP_CARGA_GEN_MENU", Envia) Then
               
               
               Exit Function
            
            End If
            Debug.Print VerSql
            
            Primera_Vez = "N"
       
       End If
       
    End If

Next i%

End Function

Private Function Ver_Estado_Usuario()
   Dim Datos()
   Dim m As String

   If Bac_Sql_Execute("SP_CONTROL_BLOQ_USUARIOS_LEE_ACTIVOS") Then
    
        Do While Bac_SQL_Fetch(Datos())
                    
            If Datos(1) = gsUsuario And Left(Datos(3), 1) = "N" And Right(Datos(3), 1) = Right(gsTerminal, 1) Then  '

        
                Call DESHABILITA_MENU
                MsgBox "Usuario Bloqueado", vbExclamation + vbOKOnly, TITSISTEMA
                m = Bloquea_Usuario(False, gsUsuario)
                gsTerminal = Datos(3)
                Salida_Usuario
                End
        
            End If
        
        Loop
        
    End If

End Function

Private Function Proc_Busca_privilegios_Especiales()
   Dim Datos()
   Dim i As Integer
   
   SW = 0
   
   Envia = Array(gsUsuario, _
                 "SCF")

   If Bac_Sql_Execute("SP_BACSWAPPARAMETROS_BUSCA_PRIV_ESPECIALES", Envia) Then
        
      Do While Bac_SQL_Fetch(Datos())
      
         If Datos(1) = "NO EXISTE" Then Exit Function
                         
         If SW = 0 Then
              
              DESHABILITA_MENU
              SW = 1
              
         End If
         
         For i% = 0 To BacControlFinanciero.Controls.Count - 1
        
             On Error Resume Next
            
             If TypeOf BacControlFinanciero.Controls(i%) Is Menu Then
             
                If Trim(BacControlFinanciero.Controls(i%).Name) = Trim(Datos(1)) Then
                   
                   BacControlFinanciero.Controls(i%).Enabled = True
                   BacControlFinanciero.Controls(i%).Visible = True
                   
                End If
             
             End If
      
         Next i%
      
      Loop
        
   End If
End Function

Private Function Estado_Usuario()
Dim Datos()
Dim Estado As String
Dim m As String
On Error GoTo fin:

          
   Envia = Array(gsUsuario, _
                 gsSistema, _
                 gsTerminal)

   If Bac_Sql_Execute("SP_CONTROL_BLOQ_USUARIOS_VERIFICAR_TERMINAL", Envia) Then
              
        Do While Bac_SQL_Fetch(Datos())
        
            If Datos(2) <> gsTerminal Then gsTerminal = Datos(2)
         
        Loop
        
    End If
  
   Envia = Array(gsUsuario, _
                 gsSistema)

   If Bac_Sql_Execute("SP_CONTROL_BLOQ_USUARIOS_ESTADO_USUARIO", Envia) Then
            
        Do While Bac_SQL_Fetch(Datos())
        
            Estado = Datos(1)
        
        Loop
        
    End If

    If Estado = "S" And SW = 1 Then
    
        Call DESHABILITA_MENU
        MsgBox "Usuario Bloqueado", vbExclamation + vbOKOnly, TITSISTEMA
        m = Bloquea_Usuario(False, gsUsuario)
        SW = 0
        Unload Me
    
    End If

    If Estado = "N" And SW = 0 Then
        
        MsgBox "Usuario Desbloqueado", vbExclamation + vbOKOnly, TITSISTEMA
        PROC_BUSCA_PRIVILEGIOS_USUARIO BacControlFinanciero, "SCF"
        SW = 1
        
    End If

fin:

End Function


Private Function Salida_Usuario()
   
   Dim Datos()
   Dim Terminales(10)
   Dim Usuarios(10)
   Dim Sistemas(10)
   Dim Tmp, TMP2, Terminal, m As String
   Dim i, j As Integer

   i = 1

   Envia = Array(gsUsuario, _
                 gsTerminal, _
                 gsSistema)

   If Bac_Sql_Execute("SP_CONTROL_BLOQ_USUARIOS_SALIR", Envia) Then
        m = Bloquea_Usuario(False, gsUsuario)
   End If

    m = Bloquea_Usuario(False, gsUsuario)

End Function

Private Function PROC_BUSCA_PRIVILEGIOS_USUARIO(forma_menu As Form, entidad As String)
   Dim i%, Comando$
   Dim Datos()
   
   If Trim(gsBAC_User) = "ADMINISTRA" Then
      Call MENU_TODOHABILITADO
      Exit Function
   End If
   
   Envia = Array("T", _
                 entidad, _
                 gsBac_Tipo_Usuario)

   If Not Bac_Sql_Execute("SP_BUSCA_PRIVILEGIOS", Envia) Then
      
      Exit Function
   
   End If
   
   Do While Bac_SQL_Fetch(Datos())
   
      For i% = 0 To forma_menu.Controls.Count - 1
   
          On Error Resume Next
   
          If TypeOf forma_menu.Controls(i%) Is Menu Then
          
             If Trim(forma_menu.Controls(i%).Name) = Trim(Datos(1)) Then
                
                forma_menu.Controls(i%).Enabled = True
                forma_menu.Controls(i%).Visible = True
             
             End If
          
          End If
   
      Next i%
   Loop
    
   Envia = Array("U", _
                 entidad, _
                 gsUsuario)

   If Not Bac_Sql_Execute("SP_BUSCA_PRIVILEGIOS", Envia) Then
   
      Exit Function
      
   End If
   
   Do While Bac_SQL_Fetch(Datos())
   
      For i% = 0 To forma_menu.Controls.Count - 1
   
          On Error Resume Next
   
          If TypeOf forma_menu.Controls(i%) Is Menu Then
             
             If Trim(forma_menu.Controls(i%).Name) = Trim(Datos(1)) Then
                
                If Datos(2) = "N" Then
                   
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

End Function

Private Function MENU_TODOHABILITADO()
    Dim i%
    
    ' HABILITA TODAS LAS OPCIONES DEL MENU
    
    For i% = 0 To Me.Controls.Count - 1

        On Error Resume Next

        If TypeOf Me.Controls(i%) Is Menu Then
            
            If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" And Me.Controls(i%).Caption <> "Salir" And Me.Controls(i%).Caption <> "Salir del Sistema" Then
                
                Me.Controls(i%).Enabled = True
                Me.Controls(i%).Visible = True
            
            End If
       
        End If
    
        If TypeOf Me.Controls(i%) Is CommandButton Then Me.Controls(i%).Enabled = True

    Next i%

End Function

Private Function DESHABILITA_MENU()
    Dim i%
    
    ' DESHABILITA TODAS LAS OPCIONES DEL MENU
    
    For i% = 0 To Me.Controls.Count - 1
         
        On Error Resume Next
      
        If TypeOf Me.Controls(i%) Is Menu Then
            
            If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" And Me.Controls(i%).Caption <> "Salir" And Me.Controls(i%).Caption <> "Salir del Sistema" Then
                
                Me.Controls(i%).Enabled = False
                Me.Controls(i%).Visible = False
            
            End If
       
        End If
    
        If TypeOf Me.Controls(i%) Is CommandButton Then Me.Controls(i%).Enabled = False

    Next i%

End Function

Private Function PROC_CARGA_PRIVILEGIOS()
    
    Dim Datos()
    Dim i%
    Dim Comando As String

  If Trim(gsBAC_User) = "ADMINISTRA" Then
    MENU_TODOHABILITADO
    Exit Function
  End If

Envia = Array("T", _
              "SCF", _
              gsBac_Tipo_Usuario)

If Not Bac_Sql_Execute("SP_BUSCA_PRIVILEGIOS", Envia) Then
   Exit Function
End If

Do While Bac_SQL_Fetch(Datos())

   For i% = 0 To Me.Controls.Count - 1
       On Error Resume Next
       
       If TypeOf Me.Controls(i%) Is Menu Then
       
          If Trim(Me.Controls(i%).Name) = Trim(Datos(1)) Then
            
            Me.Controls(i%).Enabled = True
            Me.Controls(i%).Visible = True
            
          End If
       
       End If
       
       If TypeOf Me.Controls(i%) Is CommandButton Then
          If Trim(Me.Controls(i%).Name) = "B" + Trim(Datos(1)) Then Me.Controls(i%).Enabled = True
       End If

   Next i%

Loop


Envia = Array("U", _
              "SCF", _
              gsBAC_User)

If Not Bac_Sql_Execute("SP_BUSCA_PRIVILEGIOS", Envia) Then
   Exit Function
End If

Do While Bac_SQL_Fetch(Datos())
   On Error Resume Next
   For i% = 0 To Me.Controls.Count - 1
       If TypeOf Me.Controls(i%) Is Menu Then
          If Trim(Me.Controls(i%).Name) = Trim(Datos(1)) Then
            Me.Controls(i%).Enabled = IIf(Mid(Datos(2), 1, 1) = "N", False, True)
            Me.Controls(i%).Visible = IIf(Mid(Datos(2), 1, 1) = "N", False, True)
          End If
       End If
       If TypeOf Me.Controls(i%) Is CommandButton Then
          If Trim(Me.Controls(i%).Name) = "B" + Trim(Datos(1)) Then Me.Controls(i%).Enabled = IIf(Mid(Datos(2), 1, 1) = "N", False, True)
       End If

   Next i%

Loop

End Function





Sub Proc_Genera_Excel_Oper_Dia()
   Dim Linea      As String
   Dim Fila       As Integer
   Dim Envia      As Variant
   Dim j          As Double
   Dim i          As Double
   Dim s          As Integer
   Dim ruta       As String
   Dim cInfo      As String
   '**** Variables de Excel****
   Dim Crea_xls   As Boolean
   Dim Exc
   Dim Libro
   Dim Hoja
   Dim Sheet
   Dim Sheet2
   Dim Sheet3
   Dim Sheet4
   Dim Sheet5

Const Filas_Buffer = 2500 '150

On Error GoTo CONTROL_ERROR

'AGREGAR OPCION DE PODER SELECCIONAR DIRECTORIO EN UNA UNIDAD
    Boton_Dialogo.CancelError = True
    ' Establecer los filtros
    Boton_Dialogo.Filter = "Todos los archivos (*.*)|*.*|Archivos de Excel (*.Xls)|*.Xls"
    ' Especificar el filtro predeterminado
    Boton_Dialogo.FilterIndex = 2
    ' Presentar el cuadro de diálogo Abrir
    Boton_Dialogo.DialogTitle = "Generacion de archivo de Blotters Diarios"
    Boton_Dialogo.InitDir = "c:\"
    Boton_Dialogo.FileName = "Blotter_" + Format(Date, "yyyymmdd")
    Boton_Dialogo.Flags = cdlOFNOverwritePrompt
    Boton_Dialogo.ShowSave
    
    ruta = Boton_Dialogo.FileName

    'ruta = "C:\"
    'ruta = ruta & "PRUEBA.xls" ' NOMBRE 'ruta del .XLS

    Screen.MousePointer = vbHourglass

    DoEvents

    'BLOTER SPOT
    Envia = Array()
    AddParam Envia, Glb_Sistema_Spot
     
    If Not Bac_Sql_Execute("SP_INF_DETALLE_BLOTTER_DIARIO", Envia) Then
        MsgBox "ERROR AL EJECUTAR CONSULTA SQL", vbCritical, "CONTROL FINANCIERO"
        Screen.MousePointer = vbDefault
        Exit Sub
    End If

    Set Exc = CreateObject("Excel.Application")
    Set Libro = Exc.Application.Workbooks.Add
  
    Set Hoja = Libro.Sheets.Add
    Set Sheet = Exc.ActiveSheet
    
    '************************************* SPOT ****************************************
    
    Sheet.Name = "SPOT"
      
    Linea = "NUM. OPER." & vbTab
    Linea = Linea & "CLIENTE" & vbTab
    Linea = Linea & "TIPO OPER." & vbTab
    Linea = Linea & "MERCADO" & vbTab
    Linea = Linea & "ORIGEN" & vbTab
    Linea = Linea & "MONTO MX" & vbTab
    Linea = Linea & "MONTO USD" & vbTab
    Linea = Linea & "MONTO PESOS" & vbTab
    Linea = Linea & "PARIDAD" & vbTab
    Linea = Linea & "T/C" & vbTab
    Linea = Linea & "FORMA DE PAGO ENTREGAMOS" & vbTab
    Linea = Linea & "FECHA VALUTA ENTREGAMOS" & vbTab
    Linea = Linea & "FORMA DE PAGO RECIBIMOS" & vbTab
    Linea = Linea & "FECHA VALUTA RECIBIMOS" & vbTab
    Linea = Linea & "ESTADO" & vbTab
    Linea = Linea & "FIRMA 1" & vbTab
    Linea = Linea & "FIRMA 2" & vbTab
    Linea = Linea & "CONFIRMADA" & vbTab
    Linea = Linea & "HORA CONFIRMACION" & vbTab
    Linea = Linea & "DISCREPANCIAS" & vbTab
    Linea = Linea & "DENTO/FUERA DE HORARIO" & vbTab
    
    Clipboard.Clear
    Clipboard.SetText Linea
    Sheet.Range("A1").Select
    Sheet.Paste
    Clipboard.Clear
   
    Fila = 2
    Linea = ""
    
    Sheet.Cells.NumberFormat = "@"

    Do While Bac_SQL_Fetch(Datos())
        
        Hoja.Cells(Fila, 1) = Datos(1)
        Hoja.Cells(Fila, 2) = Datos(2)
        Hoja.Cells(Fila, 3) = Datos(3)
        Hoja.Cells(Fila, 4) = Datos(4)
        Hoja.Cells(Fila, 5) = Datos(5)
        Hoja.Cells(Fila, 6) = Datos(6)
        Hoja.Cells(Fila, 7) = Datos(7)
        Hoja.Cells(Fila, 8) = Datos(8)
        Hoja.Cells(Fila, 9) = Datos(9)
        Hoja.Cells(Fila, 10) = Datos(10)
        Hoja.Cells(Fila, 11) = Datos(11)
        Hoja.Cells(Fila, 12) = Datos(12)
        Hoja.Cells(Fila, 13) = Datos(13)
        Hoja.Cells(Fila, 14) = Datos(14)
        Hoja.Cells(Fila, 15) = Datos(15)
        Hoja.Cells(Fila, 16) = Datos(16)
        Hoja.Cells(Fila, 17) = Datos(17)
        Hoja.Cells(Fila, 18) = Datos(18)
        Hoja.Cells(Fila, 19) = Datos(19)
        Hoja.Cells(Fila, 20) = Datos(20)
        Hoja.Cells(Fila, 21) = Datos(21)
        
        Fila = Fila + 1
        Crea_xls = True

    Loop
    
    Sheet.Columns("A:A").NumberFormat = "@"
    Sheet.Columns("B:B").NumberFormat = "@"
    Sheet.Columns("C:C").NumberFormat = "@"
    Sheet.Columns("D:D").NumberFormat = "@"
    Sheet.Columns("E:E").NumberFormat = "@"
    Sheet.Columns("F:F").NumberFormat = "#,##0.0000"
    Sheet.Columns("F:F").HorizontalAlignment = vbAlignRight
    Sheet.Columns("G:G").NumberFormat = "#,##0.0000"
    Sheet.Columns("G:G").HorizontalAlignment = vbAlignRight
    Sheet.Columns("H:H").NumberFormat = "#,##0"
    Sheet.Columns("H:H").HorizontalAlignment = vbAlignRight
    Sheet.Columns("I:I").NumberFormat = "#,##0.0000"
    Sheet.Columns("I:I").HorizontalAlignment = vbAlignRight
    Sheet.Columns("J:J").NumberFormat = "#,##0.0000"
    Sheet.Columns("J:J").HorizontalAlignment = vbAlignRight
    Sheet.Columns("K:K").NumberFormat = "@"
    Sheet.Columns("L:L").NumberFormat = "@"
    Sheet.Columns("M:M").NumberFormat = "@"
    Sheet.Columns("N:N").NumberFormat = "@"
    Sheet.Columns("O:O").NumberFormat = "@"
    Sheet.Columns("P:P").NumberFormat = "@"
    Sheet.Columns("Q:Q").NumberFormat = "@"
    Sheet.Columns("R:R").NumberFormat = "@"
    Sheet.Columns("S:S").NumberFormat = "h:mm"
    Sheet.Columns("S:S").HorizontalAlignment = vbCenter
    Sheet.Columns("T:T").NumberFormat = "@"
    Sheet.Columns("U:U").NumberFormat = "@"
    
    Sheet.Cells.EntireColumn.AutoFit
    
    Sheet.Range(Sheet.Cells(1, 1), Sheet.Cells(1, 21)).Font.ColorIndex = 2
    Sheet.Range(Sheet.Cells(1, 1), Sheet.Cells(1, 21)).Interior.ColorIndex = 1
    
    Sheet.Range("A1").Select

    Hoja.Application.DisplayAlerts = False
    
    For i = 2 To Hoja.Application.Sheets.Count
        Hoja.Application.Sheets(2).Delete
    Next i
    
    '******************************************* TRADER *************************************************************
   
    Set Hoja = Exc.Worksheets.Add
    Set Sheet2 = Exc.ActiveSheet
    
    Sheet2.Name = "TRADER"
    Sheet2.Move After:=Exc.Sheets(Exc.Sheets.Count)
        
    Linea = "NUM. OPER." & vbTab
    Linea = Linea & "CLIENTE" & vbTab
    Linea = Linea & "TIPO OPER." & vbTab
    Linea = Linea & "EMISOR" & vbTab
    Linea = Linea & "MONEDA TRANSACCION" & vbTab
    Linea = Linea & "SERIE" & vbTab
    Linea = Linea & "MONEDA EMISION" & vbTab
    Linea = Linea & "NOMINAL" & vbTab
    Linea = Linea & "MONTO INICIO" & vbTab
    Linea = Linea & "% V. PAR." & vbTab
    Linea = Linea & "TIR / TASA PACTO" & vbTab
    Linea = Linea & "VALOR FINAL" & vbTab
    Linea = Linea & "FECHA VCTO" & vbTab
    Linea = Linea & "FORMA DE PAGO ENTREGAMOS" & vbTab
    Linea = Linea & "FECHA VALUTA ENTREGAMOS" & vbTab
    Linea = Linea & "FORMA DE PAGO RECIBIMOS" & vbTab
    Linea = Linea & "FECHA VALUTA RECIBIMOS" & vbTab
    Linea = Linea & "ESTADO" & vbTab
    Linea = Linea & "FIRMA 1" & vbTab
    Linea = Linea & "FIRMA 2" & vbTab
    Linea = Linea & "CONFIRMADA" & vbTab
    Linea = Linea & "HORA CONFIRMACION" & vbTab
    Linea = Linea & "DISCREPANCIAS" & vbTab
    Linea = Linea & "DENTO/FUERA DE HORARIO" & vbTab

    Clipboard.Clear
    Clipboard.SetText Linea
    Sheet2.Range("A1").Select
    Sheet2.Paste
    Clipboard.Clear

    Envia = Array()
    AddParam Envia, Glb_Sistema_Trader
    
    If Not Bac_Sql_Execute("SP_INF_DETALLE_BLOTTER_DIARIO", Envia) Then
        MsgBox "ERROR AL EJECUTAR CONSULTA SQL", vbCritical, "CONTROL FINANCIERO"
        Screen.MousePointer = vbDefault
        Exit Sub
    End If
    
    Fila = 2
    Linea = ""
    
    Sheet2.Cells.NumberFormat = "@"
    
    Do While Bac_SQL_Fetch(Datos())
    
        Hoja.Cells(Fila, 1) = Datos(1)
        Hoja.Cells(Fila, 2) = Datos(2)
        Hoja.Cells(Fila, 3) = Datos(3)
        Hoja.Cells(Fila, 4) = Datos(4)
        Hoja.Cells(Fila, 5) = Datos(5)
        Hoja.Cells(Fila, 6) = Datos(6)
        Hoja.Cells(Fila, 7) = Datos(7)
        Hoja.Cells(Fila, 8) = Datos(8)
        Hoja.Cells(Fila, 9) = Datos(9)
        Hoja.Cells(Fila, 10) = Datos(10)
        Hoja.Cells(Fila, 11) = Datos(11)
        Hoja.Cells(Fila, 12) = Datos(12)
        Hoja.Cells(Fila, 13) = Datos(13)
        Hoja.Cells(Fila, 14) = Datos(14)
        Hoja.Cells(Fila, 15) = Datos(15)
        Hoja.Cells(Fila, 16) = Datos(16)
        Hoja.Cells(Fila, 17) = Datos(17)
        Hoja.Cells(Fila, 18) = Datos(18)
        Hoja.Cells(Fila, 19) = Datos(19)
        Hoja.Cells(Fila, 20) = Datos(20)
        Hoja.Cells(Fila, 21) = Datos(21)
        Hoja.Cells(Fila, 22) = Datos(22)
        Hoja.Cells(Fila, 23) = Datos(23)
        Hoja.Cells(Fila, 24) = Datos(24)
        
        Fila = Fila + 1
        Crea_xls = True
        
    Loop
    
    Sheet2.Columns("A:A").NumberFormat = "@"
    Sheet2.Columns("B:B").NumberFormat = "@"
    Sheet2.Columns("C:C").NumberFormat = "@"
    Sheet2.Columns("D:D").NumberFormat = "@"
    Sheet2.Columns("E:E").NumberFormat = "@"
    Sheet2.Columns("F:F").NumberFormat = "@"
    Sheet2.Columns("G:G").NumberFormat = "@"
    Sheet2.Columns("H:H").NumberFormat = "#,##0.0000"
    Sheet2.Columns("H:H").HorizontalAlignment = vbAlignRight
    Sheet2.Columns("I:I").NumberFormat = "#,##0.0000"
    Sheet2.Columns("I:I").HorizontalAlignment = vbAlignRight
    Sheet2.Columns("J:J").NumberFormat = "#,##0.0000"
    Sheet2.Columns("J:J").HorizontalAlignment = vbAlignRight
    Sheet2.Columns("K:K").NumberFormat = "#,##0.0000"
    Sheet2.Columns("K:K").HorizontalAlignment = vbAlignRight
    Sheet2.Columns("L:L").NumberFormat = "#,##0.0000"
    Sheet2.Columns("L:L").HorizontalAlignment = vbAlignRight
    Sheet2.Columns("M:M").NumberFormat = "@"
    Sheet2.Columns("N:N").NumberFormat = "@"
    Sheet2.Columns("O:O").NumberFormat = "@"
    Sheet2.Columns("P:P").NumberFormat = "@"
    Sheet2.Columns("Q:Q").NumberFormat = "@"
    Sheet2.Columns("R:R").NumberFormat = "@"
    Sheet2.Columns("S:S").NumberFormat = "@"
    Sheet2.Columns("T:T").NumberFormat = "@"
    Sheet2.Columns("U:U").NumberFormat = "@"
    Sheet2.Columns("V:V").HorizontalAlignment = vbCenter
    Sheet2.Columns("V:V").NumberFormat = "h:mm"
    Sheet2.Columns("W:W").NumberFormat = "@"
    Sheet2.Columns("X:X").NumberFormat = "@"

    Sheet2.Cells.EntireColumn.AutoFit
    
    Sheet2.Range(Sheet2.Cells(1, 1), Sheet2.Cells(1, 24)).Font.ColorIndex = 2
    Sheet2.Range(Sheet2.Cells(1, 1), Sheet2.Cells(1, 24)).Interior.ColorIndex = 1
    
    Sheet2.Range("A1").Select

    Hoja.Application.DisplayAlerts = False
    
    '*********************************************** BONOS EXTERIOR ***************************************************
    Set Hoja = Exc.Worksheets.Add
    Set Sheet3 = Exc.ActiveSheet
   
    Sheet3.Name = "BONOS EXT"
    Sheet3.Move After:=Exc.Sheets(Exc.Sheets.Count)
    
    Linea = "NUM. OPER." & vbTab
    Linea = Linea & "CLIENTE" & vbTab
    Linea = Linea & "TIPO OPER." & vbTab
    Linea = Linea & "SERIE" & vbTab
    Linea = Linea & "EMISOR" & vbTab
    Linea = Linea & "MONEDA" & vbTab
    Linea = Linea & "NOMINAL" & vbTab
    Linea = Linea & "PRINCIPAL" & vbTab
    Linea = Linea & "INTERES CORRIDO" & vbTab
    Linea = Linea & "MONTO" & vbTab
    Linea = Linea & "PRECIO" & vbTab
    Linea = Linea & "TIR" & vbTab
    Linea = Linea & "FORMA DE PAGO" & vbTab
    Linea = Linea & "SETTLEMENT DATE" & vbTab
    Linea = Linea & "ESTADO" & vbTab
    Linea = Linea & "FIRMA 1" & vbTab
    Linea = Linea & "FIRMA 2" & vbTab
    Linea = Linea & "CONFIRMADA" & vbTab
    Linea = Linea & "HORA CONFIRMACION" & vbTab
    Linea = Linea & "DISCREPANCIAS" & vbTab
    Linea = Linea & "DENTO/FUERA DE HORARIO" & vbTab

    Clipboard.Clear
    Clipboard.SetText Linea
    Sheet3.Range("A1").Select
    Sheet3.Paste
    Clipboard.Clear

    Envia = Array()
    AddParam Envia, Glb_Sistema_Bonos
   
    If Not Bac_Sql_Execute("SP_INF_DETALLE_BLOTTER_DIARIO", Envia) Then
        MsgBox "ERROR AL EJECUTAR CONSULTA SQL", vbCritical, "CONTROL FINANCIERO"
        Screen.MousePointer = vbDefault
        Exit Sub
    End If
    
    Fila = 2
    Linea = ""
    
    Sheet3.Cells.NumberFormat = "@"
    
    Do While Bac_SQL_Fetch(Datos())
    
        Hoja.Cells(Fila, 1) = Datos(1)
        Hoja.Cells(Fila, 2) = Datos(2)
        Hoja.Cells(Fila, 3) = Datos(3)
        Hoja.Cells(Fila, 4) = Datos(4)
        Hoja.Cells(Fila, 5) = Datos(5)
        Hoja.Cells(Fila, 6) = Datos(6)
        Hoja.Cells(Fila, 7) = Datos(7)
        Hoja.Cells(Fila, 8) = Datos(8)
        Hoja.Cells(Fila, 9) = Datos(9)
        Hoja.Cells(Fila, 10) = Datos(10)
        Hoja.Cells(Fila, 11) = Datos(11)
        Hoja.Cells(Fila, 12) = Datos(12)
        Hoja.Cells(Fila, 13) = Datos(13)
        Hoja.Cells(Fila, 14) = Datos(14)
        Hoja.Cells(Fila, 15) = Datos(15)
        Hoja.Cells(Fila, 16) = Datos(16)
        Hoja.Cells(Fila, 17) = Datos(17)
        Hoja.Cells(Fila, 18) = Datos(18)
        Hoja.Cells(Fila, 19) = Datos(19)
        Hoja.Cells(Fila, 20) = Datos(20)
        Hoja.Cells(Fila, 21) = Datos(21)
        
        Fila = Fila + 1
        Crea_xls = True
        
    Loop
    
    Sheet3.Columns("A:A").NumberFormat = "@"
    Sheet3.Columns("B:B").NumberFormat = "@"
    Sheet3.Columns("C:C").NumberFormat = "@"
    Sheet3.Columns("D:D").NumberFormat = "@"
    Sheet3.Columns("E:E").NumberFormat = "@"
    Sheet3.Columns("F:F").NumberFormat = "@"
    Sheet3.Columns("G:G").NumberFormat = "#,##0.0000"
    Sheet3.Columns("G:G").HorizontalAlignment = vbAlignRight
    Sheet3.Columns("H:H").NumberFormat = "#,##0.0000"
    Sheet3.Columns("H:H").HorizontalAlignment = vbAlignRight
    Sheet3.Columns("I:I").NumberFormat = "#,##0.0000"
    Sheet3.Columns("I:I").HorizontalAlignment = vbAlignRight
    Sheet3.Columns("J:J").NumberFormat = "#,##0.0000"
    Sheet3.Columns("J:J").HorizontalAlignment = vbAlignRight
    Sheet3.Columns("K:K").NumberFormat = "#,##0.0000"
    Sheet3.Columns("K:K").HorizontalAlignment = vbAlignRight
    Sheet3.Columns("L:L").NumberFormat = "#,##0.0000"
    Sheet3.Columns("L:L").HorizontalAlignment = vbAlignRight
    Sheet3.Columns("M:M").NumberFormat = "@"
    Sheet3.Columns("N:N").NumberFormat = "@"
    Sheet3.Columns("O:O").NumberFormat = "@"
    Sheet3.Columns("P:P").NumberFormat = "@"
    Sheet3.Columns("Q:Q").NumberFormat = "@"
    Sheet3.Columns("R:R").NumberFormat = "@"
    Sheet3.Columns("S:S").HorizontalAlignment = vbCenter
    Sheet3.Columns("S:S").NumberFormat = "h:mm"
    Sheet3.Columns("T:T").NumberFormat = "@"
    Sheet3.Columns("U:U").NumberFormat = "@"

    Sheet3.Cells.EntireColumn.AutoFit

    Sheet3.Range(Sheet3.Cells(1, 1), Sheet3.Cells(1, 21)).Font.ColorIndex = 2
    Sheet3.Range(Sheet3.Cells(1, 1), Sheet3.Cells(1, 21)).Interior.ColorIndex = 1
    
    Sheet3.Range("A1").Select

    Hoja.Application.DisplayAlerts = False
    

    '********************************************* SWAP **********************************************************
    

    Set Hoja = Exc.Worksheets.Add
    Set Sheet4 = Exc.ActiveSheet
   
    Sheet4.Name = "SWAP"
    Sheet4.Move After:=Exc.Sheets(Exc.Sheets.Count)
    
    Linea = "NUM. OPER." & vbTab
    Linea = Linea & "CLIENTE" & vbTab
    Linea = Linea & "TIPO OPER." & vbTab
    Linea = Linea & "MODALIDAD" & vbTab
    Linea = Linea & "MONEDA ENTREGAMOS" & vbTab
    Linea = Linea & "MONEDA RECIBIMOS" & vbTab
    Linea = Linea & "FECHA INICIO" & vbTab
    Linea = Linea & "MONTO CONTRATO RECIBIMOS" & vbTab
    Linea = Linea & "MONTO CONTRATO ENTREGAMOS" & vbTab
    Linea = Linea & "MONTO PAGAMOS PRIMER FLUJO" & vbTab
    Linea = Linea & "MONTO RECIBIMOS PRIMER FLUJO" & vbTab
    Linea = Linea & "TASA PAGAMOS" & vbTab
    Linea = Linea & "TIPO TASA PAGAMOS" & vbTab
    Linea = Linea & "BASE INTERES PAGAMOS" & vbTab
    Linea = Linea & "TASA RECIBIMOS" & vbTab
    Linea = Linea & "TIPO TASA RECIBIMOS" & vbTab
    Linea = Linea & "BASE INTERES RECIBIMOS" & vbTab
    Linea = Linea & "FECHA VENC. PRIMER FLUJO" & vbTab
    Linea = Linea & "FECHA VENC." & vbTab
    Linea = Linea & "ESTADO" & vbTab
    Linea = Linea & "FIRMA 1" & vbTab
    Linea = Linea & "FIRMA 2" & vbTab
    Linea = Linea & "CONFIRMADA" & vbTab
    Linea = Linea & "HORA CONFIRMACION" & vbTab
    Linea = Linea & "DISCREPANCIAS" & vbTab
    Linea = Linea & "DENTO/FUERA DE HORARIO" & vbTab
    
    Clipboard.Clear
    Clipboard.SetText Linea
    Sheet4.Range("A1").Select
    Sheet4.Paste
    Clipboard.Clear
 
 '   Sheet4.Application.Selection
    
 '   Sheet4.Columns("K:K").Select
 '   Sheet4.Application.Selection.NumberFormat = "0000.0000"

    Envia = Array()
    AddParam Envia, Glb_Sistema_Swap
   
    If Not Bac_Sql_Execute("SP_INF_DETALLE_BLOTTER_DIARIO", Envia) Then
        MsgBox "ERROR AL EJECUTAR CONSULTA SQL", vbCritical, "CONTROL FINANCIERO"
        Screen.MousePointer = vbDefault
        Exit Sub
    End If
    
    Fila = 2
    Linea = ""
    
    Sheet4.Cells.NumberFormat = "@"
    
    Do While Bac_SQL_Fetch(Datos())
       
        Hoja.Cells(Fila, 1) = Datos(1)
        Hoja.Cells(Fila, 2) = Datos(2)
        Hoja.Cells(Fila, 3) = Datos(3)
        Hoja.Cells(Fila, 4) = Datos(4)
        Hoja.Cells(Fila, 5) = Datos(5)
        Hoja.Cells(Fila, 6) = Datos(6)
        Hoja.Cells(Fila, 7) = Datos(7)
        Hoja.Cells(Fila, 8) = Datos(8)
        Hoja.Cells(Fila, 9) = Datos(9)
        Hoja.Cells(Fila, 10) = Datos(10)
        Hoja.Cells(Fila, 11) = Datos(11)
        Hoja.Cells(Fila, 12) = Datos(12)
        Hoja.Cells(Fila, 13) = Datos(13)
        Hoja.Cells(Fila, 14) = Datos(14)
        Hoja.Cells(Fila, 15) = Datos(15)
        Hoja.Cells(Fila, 16) = Datos(16)
        Hoja.Cells(Fila, 17) = Datos(17)
        Hoja.Cells(Fila, 18) = Datos(18)
        Hoja.Cells(Fila, 19) = Datos(19)
        Hoja.Cells(Fila, 20) = Datos(20)
        Hoja.Cells(Fila, 21) = Datos(21)
        Hoja.Cells(Fila, 22) = Datos(22)
        Hoja.Cells(Fila, 23) = Datos(23)
        Hoja.Cells(Fila, 24) = Datos(24)
        Hoja.Cells(Fila, 25) = Datos(25)
        Hoja.Cells(Fila, 26) = Datos(26)

        Fila = Fila + 1
        Crea_xls = True

    Loop
    
    Sheet4.Columns("A:A").NumberFormat = "@"
    Sheet4.Columns("B:B").NumberFormat = "@"
    Sheet4.Columns("C:C").NumberFormat = "@"
    Sheet4.Columns("D:D").NumberFormat = "@"
    Sheet4.Columns("E:E").NumberFormat = "@"
    Sheet4.Columns("F:F").NumberFormat = "@"
    Sheet4.Columns("G:G").NumberFormat = "@"
    Sheet4.Columns("H:H").NumberFormat = "#,##0.0000"
    Sheet4.Columns("H:H").HorizontalAlignment = vbAlignRight
    Sheet4.Columns("I:I").NumberFormat = "#,##0.0000"
    Sheet4.Columns("I:I").HorizontalAlignment = vbAlignRight
    Sheet4.Columns("J:J").NumberFormat = "#,##0.0000"
    Sheet4.Columns("J:J").HorizontalAlignment = vbAlignRight
    Sheet4.Columns("K:K").NumberFormat = "#,##0.0000"
    Sheet4.Columns("K:K").HorizontalAlignment = vbAlignRight
    Sheet4.Columns("L:L").NumberFormat = "#,##0.00"
    Sheet4.Columns("L:L").HorizontalAlignment = vbAlignRight
    Sheet4.Columns("M:M").NumberFormat = "@"
    Sheet4.Columns("N:N").NumberFormat = "@"
    Sheet4.Columns("O:O").NumberFormat = "@"
    Sheet4.Columns("O:O").NumberFormat = "#,##0.00"
    Sheet4.Columns("O:O").HorizontalAlignment = vbAlignRight
    Sheet4.Columns("P:P").NumberFormat = "@"
    Sheet4.Columns("Q:Q").NumberFormat = "@"
    Sheet4.Columns("R:R").NumberFormat = "@"
    Sheet4.Columns("S:S").NumberFormat = "@"
    Sheet4.Columns("T:T").NumberFormat = "@"
    Sheet4.Columns("U:U").NumberFormat = "@"
    Sheet4.Columns("V:V").NumberFormat = "@"
    Sheet4.Columns("W:W").NumberFormat = "@"
    Sheet4.Columns("X:X").HorizontalAlignment = vbCenter
    Sheet4.Columns("X:X").NumberFormat = "h:mm"
    Sheet4.Columns("Y:Y").NumberFormat = "@"
    Sheet4.Columns("Z:Z").NumberFormat = "@"

    Sheet4.Cells.EntireColumn.AutoFit

    Sheet4.Range(Sheet4.Cells(1, 1), Sheet4.Cells(1, 26)).Font.ColorIndex = 2
    Sheet4.Range(Sheet4.Cells(1, 1), Sheet4.Cells(1, 26)).Interior.ColorIndex = 1
    
    Sheet4.Range("A1").Select

    Hoja.Application.DisplayAlerts = False

    '*******************************************************************************************************
    
    Set Hoja = Exc.Worksheets.Add
    Set Sheet5 = Exc.ActiveSheet
   
    Sheet5.Name = "FORWARD"
    Sheet5.Move After:=Exc.Sheets(Exc.Sheets.Count)
    
    Linea = "NUM. OPER." & vbTab
    Linea = Linea & "CLIENTE / CONTRAPARTE" & vbTab
    Linea = Linea & "TIPO OPER." & vbTab
    Linea = Linea & "MONEDA TRANS." & vbTab
    Linea = Linea & "CONTRA MONEDA" & vbTab
    Linea = Linea & "NOMINAL" & vbTab
    Linea = Linea & "MONTO MX" & vbTab
    Linea = Linea & "MONTO FINAL" & vbTab
    Linea = Linea & "MONTO PESOS" & vbTab
    Linea = Linea & "T/C" & vbTab
    Linea = Linea & "PRECIO" & vbTab
    Linea = Linea & "FECHA VCTO." & vbTab
    Linea = Linea & "FORMA DE PAGO ENTREGAMOS" & vbTab
    Linea = Linea & "FECHA VALUTA" & vbTab
    Linea = Linea & "FORMA DE PAGO RECIBIMOS" & vbTab
    Linea = Linea & "FECHA VALUTA" & vbTab
    Linea = Linea & "ESTADO" & vbTab
    Linea = Linea & "FIRMA 1" & vbTab
    Linea = Linea & "FIRMA 2" & vbTab
    Linea = Linea & "CONFIRMADA" & vbTab
    Linea = Linea & "HORA CONFIRMACION" & vbTab
    Linea = Linea & "DISCREPANCIAS" & vbTab
    Linea = Linea & "DENTO/FUERA DE HORARIO" & vbTab

    Clipboard.Clear
    Clipboard.SetText Linea
    Sheet5.Range("A1").Select
    Sheet5.Paste
    Clipboard.Clear

    Envia = Array()
    AddParam Envia, Glb_Sistema_Forward
    
    If Not Bac_Sql_Execute("SP_INF_DETALLE_BLOTTER_DIARIO", Envia) Then
        MsgBox "ERROR AL EJECUTAR CONSULTA SQL", vbCritical, "CONTROL FINANCIERO"
        Screen.MousePointer = vbDefault
        Exit Sub
    End If
    
    Linea = ""
    Fila = 2
    
    Sheet5.Cells.NumberFormat = "@"
    
    Do While Bac_SQL_Fetch(Datos())

            Hoja.Cells(Fila, 1) = Datos(1)
            Hoja.Cells(Fila, 2) = Datos(2)
            Hoja.Cells(Fila, 3) = Datos(3)
            Hoja.Cells(Fila, 4) = Datos(4)
            Hoja.Cells(Fila, 5) = Datos(5)
            Hoja.Cells(Fila, 6) = Datos(6)
            Hoja.Cells(Fila, 7) = Datos(7)
            Hoja.Cells(Fila, 8) = Datos(8)
            Hoja.Cells(Fila, 9) = Datos(9)
            Hoja.Cells(Fila, 10) = Datos(10)
            Hoja.Cells(Fila, 11) = Datos(11)
            Hoja.Cells(Fila, 12) = Datos(12)
            Hoja.Cells(Fila, 13) = Datos(13)
            Hoja.Cells(Fila, 14) = Datos(14)
            Hoja.Cells(Fila, 15) = Datos(15)
            Hoja.Cells(Fila, 16) = Datos(16)
            Hoja.Cells(Fila, 17) = Datos(17)
            Hoja.Cells(Fila, 18) = Datos(18)
            Hoja.Cells(Fila, 19) = Datos(19)
            Hoja.Cells(Fila, 20) = Datos(20)
            Hoja.Cells(Fila, 21) = Datos(21)
            Hoja.Cells(Fila, 22) = Datos(22)
            Hoja.Cells(Fila, 23) = Datos(23)
            
            Fila = Fila + 1
            Crea_xls = True
    Loop
    
    Sheet5.Columns("A:A").NumberFormat = "@"
    Sheet5.Columns("B:B").NumberFormat = "@"
    Sheet5.Columns("C:C").NumberFormat = "@"
    Sheet5.Columns("D:D").NumberFormat = "@"
    Sheet5.Columns("E:E").NumberFormat = "@"
    Sheet5.Columns("F:F").NumberFormat = "#,##0.0000"
    Sheet5.Columns("F:F").HorizontalAlignment = vbAlignRight
    Sheet5.Columns("G:G").NumberFormat = "#,##0.0000"
    Sheet5.Columns("G:G").HorizontalAlignment = vbAlignRight
    Sheet5.Columns("H:H").NumberFormat = "#,##0.0000"
    Sheet5.Columns("H:H").HorizontalAlignment = vbAlignRight
    Sheet5.Columns("I:I").NumberFormat = "#,##0"
    Sheet5.Columns("I:I").HorizontalAlignment = vbAlignRight
    Sheet5.Columns("J:J").NumberFormat = "#,##0.0000"
    Sheet5.Columns("J:J").HorizontalAlignment = vbAlignRight
    Sheet5.Columns("K:K").NumberFormat = "#,##0.0000"
    Sheet5.Columns("K:K").HorizontalAlignment = vbAlignRight
    Sheet5.Columns("L:L").NumberFormat = "@"
    Sheet5.Columns("M:M").NumberFormat = "@"
    Sheet5.Columns("N:N").NumberFormat = "@"
    Sheet5.Columns("O:O").NumberFormat = "@"
    Sheet5.Columns("P:P").NumberFormat = "@"
    Sheet5.Columns("Q:Q").NumberFormat = "@"
    Sheet5.Columns("R:R").NumberFormat = "@"
    Sheet5.Columns("S:S").NumberFormat = "@"
    Sheet5.Columns("T:T").NumberFormat = "@"
    Sheet5.Columns("U:U").NumberFormat = "h:mm"
    Sheet5.Columns("U:U").HorizontalAlignment = vbCenter
    Sheet5.Columns("V:V").NumberFormat = "@"
    Sheet5.Columns("W:W").NumberFormat = "@"

    Sheet5.Cells.EntireColumn.AutoFit

    Sheet5.Range(Sheet5.Cells(1, 1), Sheet5.Cells(1, 23)).Font.ColorIndex = 2
    Sheet5.Range(Sheet5.Cells(1, 1), Sheet5.Cells(1, 23)).Interior.ColorIndex = 1
    
    Sheet5.Range("A1").Select

    Hoja.Application.DisplayAlerts = False
    
    '*******************************************************************************************************
    
    If Crea_xls Then
        Hoja.SaveAs (ruta)
    Else
        MsgBox "No se encontró Información para generar el Excel", vbExclamation, gsBac_Version
        Hoja.Application.Workbooks.Close
        Screen.MousePointer = vbDefault
        Exit Sub
    End If

    Hoja.Application.Workbooks.Close
    Screen.MousePointer = vbDefault

    Set Hoja = Nothing
    Set Libro = Nothing
    Set Exc = Nothing
    Set Sheet = Nothing
    Set Sheet2 = Nothing
    Set Sheet3 = Nothing
    Set Sheet4 = Nothing
    Set Sheet5 = Nothing

    Shell (gsBac_Office & "EXCEL.EXE  " & ruta)
    
    Call Limpiar_Cristal
    BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "RESUMEN_BLOTTER_DIARIO.rpt"
    BacControlFinanciero.CryFinanciero.Connect = swConeccion
    BacControlFinanciero.CryFinanciero.Action = 1

    
    
Exit Sub

CONTROL_ERROR:
If Err.Number = 32755 Then
    Exit Sub
Else
    MsgBox "Ha ocurrido un error al intentar generar el archivo de BLOTTER DIARIOS", vbCritical, "CONTROL FINANCIERO"
    Screen.MousePointer = vbDefault
End If
End Sub

Private Sub OPC_MNTCTRLThreshold_Click()
   FRM_MNT_CONTROL_TRHESHOLD.Show
End Sub
