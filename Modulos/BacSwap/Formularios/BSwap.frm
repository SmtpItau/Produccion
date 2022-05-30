VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "crystl32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.MDIForm BACSwap 
   BackColor       =   &H00C0C0C0&
   Caption         =   "BAC-SWAPS ( Sql Server )"
   ClientHeight    =   8310
   ClientLeft      =   585
   ClientTop       =   1110
   ClientWidth     =   12000
   Icon            =   "BSwap.frx":0000
   LinkTopic       =   "BacTrd"
   LockControls    =   -1  'True
   Picture         =   "BSwap.frx":030A
   WindowState     =   2  'Maximized
   Begin VB.Timer Tmrfecha 
      Left            =   8640
      Top             =   600
   End
   Begin MSWinsockLib.Winsock NomObjWinIP 
      Left            =   360
      Top             =   3120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin Threed.SSPanel SSPanel1 
      Align           =   2  'Align Bottom
      Height          =   420
      Left            =   0
      TabIndex        =   2
      Top             =   7890
      Width           =   12000
      _Version        =   65536
      _ExtentX        =   21167
      _ExtentY        =   741
      _StockProps     =   15
      BackColor       =   -2147483633
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
      Begin Threed.SSPanel PnlEstado 
         Height          =   285
         Left            =   75
         TabIndex        =   3
         Top             =   75
         Width           =   4770
         _Version        =   65536
         _ExtentX        =   8414
         _ExtentY        =   503
         _StockProps     =   15
         ForeColor       =   8388608
         BackColor       =   -2147483633
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         Alignment       =   1
      End
      Begin Threed.SSPanel PnlUsuario 
         Height          =   300
         Left            =   4890
         TabIndex        =   4
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
      Begin Threed.SSPanel Pnl_UF 
         Height          =   330
         Left            =   6900
         TabIndex        =   5
         Top             =   45
         Width           =   1860
         _Version        =   65536
         _ExtentX        =   3281
         _ExtentY        =   572
         _StockProps     =   15
         ForeColor       =   8388608
         BackColor       =   -2147483633
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
      Begin Threed.SSPanel Pnl_DO 
         Height          =   330
         Left            =   8775
         TabIndex        =   6
         Top             =   45
         Width           =   1755
         _Version        =   65536
         _ExtentX        =   3096
         _ExtentY        =   582
         _StockProps     =   15
         ForeColor       =   8388608
         BackColor       =   -2147483633
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
      Begin Threed.SSPanel PnlFecha 
         Height          =   330
         Left            =   10545
         TabIndex        =   7
         Top             =   45
         Width           =   1350
         _Version        =   65536
         _ExtentX        =   2381
         _ExtentY        =   582
         _StockProps     =   15
         ForeColor       =   8388608
         BackColor       =   -2147483633
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
      TabIndex        =   0
      Top             =   0
      Width           =   12000
      _Version        =   65536
      _ExtentX        =   21167
      _ExtentY        =   952
      _StockProps     =   15
      ForeColor       =   16711680
      BackColor       =   -2147483646
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   0
      BevelInner      =   1
      Outline         =   -1  'True
      Begin Threed.SSCommand CmdOpc_20400 
         Height          =   420
         Left            =   2370
         TabIndex        =   1
         ToolTipText     =   "Mantención de Operaciones"
         Top             =   60
         Width           =   495
         _Version        =   65536
         _ExtentX        =   873
         _ExtentY        =   741
         _StockProps     =   78
         Caption         =   "MO"
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
      End
      Begin Threed.SSCommand CmdOpc_20300 
         Height          =   420
         Left            =   1725
         TabIndex        =   8
         ToolTipText     =   "Forward Rate Agregements"
         Top             =   60
         Width           =   495
         _Version        =   65536
         _ExtentX        =   873
         _ExtentY        =   741
         _StockProps     =   78
         Caption         =   "FRA"
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
      End
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   10065
      Top             =   525
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin Crystal.CrystalReport Crystal 
      Left            =   9615
      Top             =   555
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
      PrintFileLinesPerPage=   60
   End
   Begin VB.Menu mnu_10000 
      Caption         =   "Inicio de Día"
      Begin VB.Menu Opc_10100 
         Caption         =   "Parametros Diarios"
         HelpContextID   =   1
      End
      Begin VB.Menu OPC_RecalcLineas 
         Caption         =   "Recalculo de Líneas de Crédito"
         Enabled         =   0   'False
         HelpContextID   =   1
         Visible         =   0   'False
      End
      Begin VB.Menu Opc_10200 
         Caption         =   "-"
         HelpContextID   =   1
         Visible         =   0   'False
      End
   End
   Begin VB.Menu Mnu_20000 
      Caption         =   "Operaciones"
      Begin VB.Menu Opc_20300 
         Caption         =   "FRA"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20302 
         Caption         =   "Ingreso Operaciones Swap"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20500 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20400 
         Caption         =   "Mantención de Operaciones"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20600 
         Caption         =   "-"
         HelpContextID   =   1
         Visible         =   0   'False
      End
      Begin VB.Menu Opc_20700 
         Caption         =   "Cierre / Apertura de Mesa"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20701 
         Caption         =   "Bloqueo de Mesa"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_20800 
         Caption         =   "-"
         HelpContextID   =   1
         Visible         =   0   'False
      End
      Begin VB.Menu Opc_20801 
         Caption         =   "Anulación de Ticket Intra Mesa"
      End
   End
   Begin VB.Menu Mnu_30000 
      Caption         =   "Anticipos"
      Begin VB.Menu Opc_30100 
         Caption         =   "Anticipar Operacion"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_30200 
         Caption         =   "Documentacion Anticipos (informes)"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_30300 
         Caption         =   "Anulación Anticipos"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_30400 
         Caption         =   "Modificar Formas de Pago"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_30401 
         Caption         =   "Consulta y Anticipo Ticket Intra Mesa"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Mnu_40000 
      Caption         =   "Informes"
      Begin VB.Menu Opc_40100 
         Caption         =   "al Cliente y BCCH"
         HelpContextID   =   1
         Begin VB.Menu Opc_40101 
            Caption         =   "Condiciones Generales"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40102 
            Caption         =   "Contratos con Empresas"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40103 
            Caption         =   "Contratos Interbancarios"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40111 
            Caption         =   "Reimpresion de Contratos Nuevos"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40106 
            Caption         =   "FAX de Confirmación"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40105 
            Caption         =   "-"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40107 
            Caption         =   "Avisos de Liquidación"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_70201 
            Caption         =   "Informe Sinacofi"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40109 
            Caption         =   "Informe Capitulo IX Anexo 3"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40110 
            Caption         =   "Informe Coberturas"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40112 
            Caption         =   "Interfaz Capítulo IX Anexo 3"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40113 
            Caption         =   "Interfaz Capítulo IX Anexo 3(Cartera Vigente)"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Opc_40200 
         Caption         =   "Movimientos"
         HelpContextID   =   1
         Begin VB.Menu Opc_40201 
            Caption         =   "Swaps de Tasas"
            Enabled         =   0   'False
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu Opc_40202 
            Caption         =   "Swaps de Monedas"
            Enabled         =   0   'False
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu Opc_40203 
            Caption         =   "FRA"
            Enabled         =   0   'False
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu Opc_40203A 
            Caption         =   "Swap Promedio Camara"
            Enabled         =   0   'False
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu Opc_40203B 
            Caption         =   "Operaciones del Día"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40204 
            Caption         =   "-"
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu Opc_40205 
            Caption         =   "Vencimientos del Día"
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu Opc_40206 
            Caption         =   "-"
            HelpContextID   =   2
            Visible         =   0   'False
         End
         Begin VB.Menu Opc_40207 
            Caption         =   "Pagos del Día"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40208 
            Caption         =   "Fijación Tasa"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Opc_40300 
         Caption         =   "Carteras"
         HelpContextID   =   1
         Begin VB.Menu Opc_40301 
            Caption         =   "Swaps de Tasas"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40302 
            Caption         =   "Swaps de Monedas"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40303 
            Caption         =   "FRA"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40303A 
            Caption         =   "Swap Promedio Camara"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40304 
            Caption         =   "Informe Cartera Valor Razonable"
            HelpContextID   =   2
         End
         Begin VB.Menu SwapColateral 
            Caption         =   "Swap y Forward con Colateral"
         End
      End
      Begin VB.Menu Opc_40305 
         Caption         =   "Valorización"
         HelpContextID   =   1
         Begin VB.Menu Opc_40306 
            Caption         =   "Valorización por Flujo"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40307 
            Caption         =   "Valorización por Operación"
            HelpContextID   =   2
         End
      End
      Begin VB.Menu Opc_40500 
         Caption         =   "Informes Contables"
         HelpContextID   =   1
         Begin VB.Menu Opc_40501 
            Caption         =   "Informe Voucher"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40502 
            Caption         =   "Informe Voucher Consolidado"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40503 
            Caption         =   "Informe Resumen de Cuentas"
            HelpContextID   =   2
         End
         Begin VB.Menu Opc_40600 
            Caption         =   "Informe Basilea Swap"
            Enabled         =   0   'False
            HelpContextID   =   2
            Visible         =   0   'False
         End
      End
      Begin VB.Menu Opc_40625 
         Caption         =   "Cartera con Resultados Reconocidos o AVR"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_40626 
         Caption         =   "Ticket IntraMesa"
         Begin VB.Menu Opc_40627 
            Caption         =   "Movimientos"
         End
         Begin VB.Menu Opc_40628 
            Caption         =   "Cartera"
         End
      End
   End
   Begin VB.Menu Mnu_50000 
      Caption         =   "Procesos"
      Begin VB.Menu Opc_50500 
         Caption         =   "Ingreso de Tasas para Flujos"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50600 
         Caption         =   "Ingreso TC/Paridad para Vcto. de Flujos"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50700 
         Caption         =   "Cálculo Liquidación"
      End
      Begin VB.Menu Opc_50100 
         Caption         =   "Devengamiento"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50200 
         Caption         =   "Valorización"
         Enabled         =   0   'False
         HelpContextID   =   1
         Visible         =   0   'False
      End
      Begin VB.Menu Opc_50300 
         Caption         =   "Contabilidad Automática"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50400 
         Caption         =   "-"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50311 
         Caption         =   "Asignación de Monedas de Pago"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50312 
         Caption         =   "Periodicidad de Tasas"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50313 
         Caption         =   "Convenio de Ajuste de Interes"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_50314 
         Caption         =   "-"
      End
      Begin VB.Menu Opc_50316 
         Caption         =   "Devengamiento de Ticket Intra Mesa"
      End
      Begin VB.Menu Opc_50317 
         Caption         =   "Envío Flujos Vencidos a Spot"
      End
      Begin VB.Menu Opc_50318 
         Caption         =   "Modificar Fecha Fijación"
      End
      Begin VB.Menu Opc_50319 
         Caption         =   "Modificar Fecha Liquidación"
      End
      Begin VB.Menu MarcarOpeColateral 
         Caption         =   "Marcar Operaciones Colateral"
      End
   End
   Begin VB.Menu Mnu_60000 
      Caption         =   "Interfaces"
      Begin VB.Menu Opc_60120 
         Caption         =   "Interfaz xFil"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_60130 
         Caption         =   "Interfaz xFlu"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Mnu_80000 
      Caption         =   "Administración"
      Begin VB.Menu OPC_CambioPassword 
         Caption         =   "Cambio de Clave"
         HelpContextID   =   1
      End
   End
   Begin VB.Menu Mnu_70000 
      Caption         =   "Fin de Día"
      Begin VB.Menu Opc_70100 
         Caption         =   "Proceso de Cierre"
         HelpContextID   =   1
      End
      Begin VB.Menu Opc_70200 
         Caption         =   "-"
         HelpContextID   =   1
         Visible         =   0   'False
      End
   End
   Begin VB.Menu Salida 
      Caption         =   "Salir"
   End
End
Attribute VB_Name = "BACSwap"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public FechaSistema As String
Dim gsLogin         As Boolean
Const nFechaProc = 1
Const nDevengo = 2

Function RevisarMensajes()
   Dim SQL           As String
   Dim nForms        As Integer
   Dim Datos()

   SQL = "EXECUTE SP_MDMSGCONTARPENDIENTES '" & gsBAC_User & "'"

   Envia = Array()
   AddParam Envia, gsBAC_User
   If Not Bac_Sql_Execute("SP_MDMSGCONTARPENDIENTES", Envia) Then
      Exit Function
   End If
   Do While Bac_SQL_Fetch(Datos())
      If Val(Datos(1)) > 0 Then
         BACSwap.Tag = " "
         For nForms = 1 To Forms.Count - 1
            If Forms(nForms).Tag = "RECIBIR" Then
               Exit For
            End If
         Next nForms
      End If
    Loop
End Function

Private Sub cmd_Click(Index As Integer)
   On Error GoTo ErrLevel:
   Select Case Index
      Case 0:
         If gsc_Parametros.cierreMesa = "0" Then
            With ActiveForm
               If .ValidarDatos() Then
                  If .clsOperacion.nNumoper = 0 Then
                  Else
                  End If
                  Call ActiveForm.GrabarOperac
               End If
            End With
         Else
            MsgBox "Esta operación no se puede grabar porque ya se realizo el cierre de mesa", vbExclamation, TITSISTEMA
         End If
      Case 1:
         Select Case UCase(ActiveForm.Name)
            Case "BACCONMOVIMIENTO"
               ActiveForm.AnularOperacion
         End Select
      Case 2:     Call BacIrfNueVentana("SCAMA")
      Case 3:     Call BacIrfNueVentana("ARBRA")
      Case 4:     Call BacIrfNueVentana("SEINA")
      Case 5:     Call BacIrfNueVentana("SINTA")
      Case 6:     Call BacIrfNueVentana("1446A")
      Case 8:     'BacConsultar.Show vbNormal
      Case 16:    'Posición Banco
      Case 17:    'BACSend.Show vbNormal
      Case 18:    'BacRecibir.Show vbNormal
      Case Else:
   End Select

   On Error GoTo 0
Exit Sub
ErrLevel:

End Sub

Private Sub Command1_Click()

End Sub
Private Sub CmdOpc_20100_Click()
   Call Opc_20100_Click
End Sub

Private Sub CmdOpc_20200_Click()
   Call Opc_20200_Click
End Sub

Private Sub CmdOpc_20300_Click()
   Call Opc_20300_Click
End Sub

Private Sub CmdOpc_20301_Click()
   Call Opc_20301_Click
End Sub

Private Sub CmdOpc_20400_Click()
   Call Opc_20400_Click
End Sub

Private Sub MarcarOpeColateral_Click()
    BacOpeColateral.Show
End Sub

Private Sub MDIForm_Activate()
   Dim A       As Integer
   Dim SQL     As String
   Dim cPict   As String

   Screen.MousePointer = vbDefault
        
   If Not gsBAC_Login Then
      If gsc_Parametros.DatosGenerales() Then
         Call AsignaValoresParametros
      Else
         MsgBox "Error en la recuperación de la tabla de parámetros.", vbCritical, TITSISTEMA & " - Parámetros"
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
         Screen.MousePointer = vbHourglass
         Call PROC_CARGA_PRIVILEGIOS
      Else
         Unload Me
         Exit Sub
      End If
   End If
        
    ' Activacion Temporal
   Opc_50600.Enabled = True
   'Opc_50700.Enabled = True
   
   'faltan los Botones de Accesso Directo a las operaciones
   PnlEstado.FontSize = 8
   PnlFecha.FontSize = 8
   Pnl_UF.FontSize = 8
   Pnl_DO.FontSize = 8
   PnlUsuario.FontSize = 8

   Me.PnlEstado.Caption = Space(1) + gsBAC_Clien
   Me.PnlFecha.Caption = Format(gsBAC_Fecp, gsc_FechaDMA)
   Me.Pnl_UF.Caption = "U.F. : " & Format(gsBAC_ValmonUF, "###,##0.###0")
   Me.Pnl_DO.Caption = "D.O. : " & Format(gsBAC_DolarObs, "###,##0.###0")
   Me.PnlUsuario.Caption = gsBAC_User
   FechaSistema = Format(gsBAC_Fecp, gsc_FechaDMA)
    
   Screen.MousePointer = vbDefault
End Sub

Sub PROC_CARGA_PARAMETROS()
   Dim Datos()

   If MISQL.SQL_Execute("SELECT CONVERT(CHAR(10),fechaproc,103), nombre,CONVERT(CHAR(10),fechaprox,103),rut FROM View_SwapGeneral") = 0 Then
      Do While MISQL.SQL_Fetch(Datos()) = 0
         gsBAC_Fecp = CDate(Datos(1))
         gsBAC_Clien = Datos(2)
         'gsBac_Fecx = CDate(Datos(3))
         'gsBac_RutC = Datos(4)
         'gsBac_DigC = Datos(5)
         'gsBac_RutComi = Val(Datos(6))
         'gsBac_PrComi = Val(Datos (7))
         'gsBac_Iva = Val(Datos(8))
      Loop
   End If
   If MISQL.SQL_Execute("SET ROWCOUNT 1") <> 0 Then
      Exit Sub
   End If

   If MISQL.SQL_Execute("SELECT rcrut,rcdv,rcnombre FROM MdRc") = 0 Then
      Do While MISQL.SQL_Fetch(Datos()) = 0
         'gsBac_CartRUT = Val(Datos(1))
         'gsBac_CartDV = Datos(2)
         'gsBac_CartNOM = Datos(3)
      Loop
   End If
   If MISQL.SQL_Execute("SET ROWCOUNT 0") <> 0 Then
      Exit Sub
   End If
End Sub

Sub PROC_CARGA_PRIVILEGIOS()
   Dim Datos()
   Dim i%
   Dim Comando As String

   If Trim(gsBAC_User) = "ADMINISTRA" Or Trim(gsBAC_User) = "BAC" Then
      Call MENU_TODOHABILITADO
      Exit Sub
   End If

   Envia = Array()
   AddParam Envia, "T"
   AddParam Envia, Sistema
   AddParam Envia, gsBac_Tipo_Usuario
   If Not Bac_Sql_Execute("SP_BUSCA_PRIVILEGIOS", Envia) Then
      Exit Sub
   End If

   ' BUSCA LAS OPCIONES POR TIPO DE USUARIO
   Do While Bac_SQL_Fetch(Datos)
      For i% = 0 To Me.Controls.Count - 1
         If TypeOf Me.Controls(i%) Is MENU Then
            If Trim(Me.Controls(i%).Name) = Trim(Datos(1)) Then
               Me.Controls(i%).Enabled = True
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
   AddParam Envia, Sistema
   AddParam Envia, gsBAC_User
   If Not Bac_Sql_Execute("SP_BUSCA_PRIVILEGIOS", Envia) Then
      Exit Sub
   End If
   ' BUSCA LAS OPCIONES DEL USUARIO Y LAS HABILITA
   Do While Bac_SQL_Fetch(Datos)
      For i% = 0 To Me.Controls.Count - 1
         If TypeOf Me.Controls(i%) Is MENU Then
            If Trim(Me.Controls(i%).Name) = Trim(Datos(1)) Then
               Me.Controls(i%).Enabled = IIf(Mid(Datos(2), 1, 1) = "N", False, True)
            End If
         End If
         If TypeOf Me.Controls(i%) Is CommandButton Then
            If Trim(Me.Controls(i%).Name) = "B" + Trim(Datos(1)) Then
               Me.Controls(i%).Enabled = IIf(Mid(Datos(2), 1, 1) = "N", False, True)
            End If
         End If
      Next i%
   Loop

      CmdOpc_20300.Enabled = Opc_20300.Enabled
   CmdOpc_20400.Enabled = Opc_20400.Enabled
End Sub

Private Sub MDIForm_Load()
   Dim Pantalla_Activa$
   Dim xx

   Call DetectarResolucion(Me, Form1)

   Msj = "Bac-Swaps"
   Entidad = "01"
   Sistema = "PCS"

   Screen.MousePointer = vbHourglass
   If App.PrevInstance Then
      Screen.MousePointer = vbDefault
      MsgBox "Sistema Esta Cargado en Memoria.", vbExclamation, TITSISTEMA
      End
   End If
   If Not Valida_Configuracion_Regional() Then
      Screen.MousePointer = vbDefault
      MsgBox "Debe cambiar el formato de fecha como dd/mm/aaaa antes de ejecutar el sistema.", vbCritical, TITSISTEMA
      End
   End If
   If Not BacInit Then
      Screen.MousePointer = vbDefault
      MsgBox "Problemas en Conección Inicial del Sistema", vbCritical, TITSISTEMA
      End
   End If
   
   Tmrfecha.Enabled = True
   Tmrfecha.Interval = gsBac_Timer
   
gsSQL_Login = ReadINI("usuario", "usuario", App.Path & "\Bac-Sistemas.INI")
gsSQL_Password = ReadINI("usuario", "password", App.Path & "\Bac-Sistemas.INI")
swConeccion = "DSN=SQL_BACSWAP;UID="
swConeccion = swConeccion & gsSQL_Login
swConeccion = swConeccion & ";PWD="
swConeccion = swConeccion & gsSQL_Password
swConeccion = swConeccion & ";DSQ=BACSWAPsuda"

   If Not BAC_Login(gsSQL_Login, gsSQL_Password) Then
      MsgBox "Problemas de Comunicación con el Servidor SQL", vbCritical, TITSISTEMA
      End
   End If
   Caption = "BacSwap  Srv: [" & gsSQL_Server & "]"
   
   If Mid(Command, 1, 11) = "GENERA_MENU" Then
      Call PROC_GENERA_MENU("PCS")
      Call MISQL.SQL_Close
      End
   End If
End Sub


Sub PROC_BUSCA_PRIVILEGIOS_USUARIO(forma_menu As Form, Entidad As String)
   Dim i%
   Dim Datos()

   If Trim(Login_Usuario) = "ADMINISTRADOR" Then
      End
   End If
   If Trim(Login_Usuario) = "BAC" Then
      Exit Sub
   End If
   
   ' DESHABILITA TODAS LAS OPCIONES DEL MENU
   For i% = 0 To forma_menu.Controls.Count - 1
      If TypeOf forma_menu.Controls(i%) Is MENU Then
         If forma_menu.Controls(i%).Caption <> "-" And forma_menu.Controls(i%).Caption <> "?" And forma_menu.Controls(i%).Caption <> "Salir" Then
            forma_menu.Controls(i%).Enabled = False
         End If
      End If
   Next i%
   
   ' BUSCA LAS OPCIONES DEL USUARIO Y LAS HABILITA
   Envia = Array()
   AddParam Envia, "T"
   AddParam Envia, Entidad
   AddParam Envia, gsBac_Tipo_Usuario
   If Not Bac_Sql_Execute("SP_BUSCA_PRIVILEGIOS", Envia) Then
      Exit Sub
   End If
   Do While Bac_SQL_Fetch(Datos())
      For i% = 0 To forma_menu.Controls.Count - 1
         If TypeOf forma_menu.Controls(i%) Is MENU Then
            If Trim(forma_menu.Controls(i%).Name) = Trim(Datos(1)) Then
               forma_menu.Controls(i%).Enabled = True
            End If
         End If
      Next i%
   Loop

   Envia = Array()
   AddParam Envia, "U"
   AddParam Envia, Entidad
   AddParam Envia, Login_Usuario
   If Bac_Sql_Execute("SP_BUSCA_PRIVILEGIOS", Envia) Then
      Exit Sub
   End If
   Do While Bac_SQL_Fetch(Datos())
      For i% = 0 To forma_menu.Controls.Count - 1
         If TypeOf forma_menu.Controls(i%) Is MENU Then
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
End Sub



Sub PROC_GENERA_MENUANT(forma_menu As Form, nombre_archivo As String)
   Dim i%
   Open nombre_archivo For Output As #1

   For i% = 0 To forma_menu.Controls.Count - 1
      If TypeOf forma_menu.Controls(i%) Is MENU Then
         If forma_menu.Controls(i%).Caption <> "-" And forma_menu.Controls(i%).Caption <> "?" Then
            Print #1, RELLENA_STRING(Format(forma_menu.Controls(i%).HelpContextID, "0") + forma_menu.Controls(i%).Caption, "D", 70) + RELLENA_STRING(forma_menu.Controls(i%).Name, "D", 20)
         End If
      End If
   Next i%
   
   Close #1
End Sub

Sub PROC_GENERA_MENU(Entidad As String)
   Dim SQL         As String
   Dim indice      As Integer: indice = 1
   Dim Primera_Vez As String: Primera_Vez = "S"
   Dim i%

   Entidad = "PCS"

   For i% = 0 To Me.Controls.Count - 1
      If TypeOf Me.Controls(i%) Is MENU Then
         If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" And Me.Controls(i%).Visible And Me.Controls(i%).Caption <> "Salir" Then
            SQL = "SP_CARGA_GEN_MENU "
            SQL = SQL + "'" + Primera_Vez + "',"
            SQL = SQL + "'" + Entidad + "',"
            SQL = SQL + Str(indice) + ","
            SQL = SQL + "'" + Me.Controls(i%).Caption + "',"
            SQL = SQL + "'" + Me.Controls(i%).Name + "',"
            SQL = SQL + Format(Me.Controls(i%).HelpContextID, "0")
            If MISQL.SQL_Execute(SQL) <> 0 Then
               Exit Sub
            End If
            Debug.Print SQL
            indice = indice + 1
            Primera_Vez = "N"
         End If
      End If
   Next i%
End Sub


Private Sub MDIForm_Unload(Cancel As Integer)
   If Not Bac_Sql_Execute("BACPARAMSUDA..SP_VAL_MENSAJES_PCS") Then
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intentar validar los datos SWAP", vbCritical
      Exit Sub
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(nFechaProc) <> "OK" Then
         Screen.MousePointer = vbDefault
         'MsgBox "No se puede verificar la existencia de pagos para la generacion de mensajes del motor de pago para SWAP, debido a que las fechas de proceso de Swap y Parametros son distintas", vbExclamation, "MOTOR DE PAGOS"
      Else
         If Datos(nDevengo) <> "OK" Then
            Screen.MousePointer = vbDefault
            MsgBox "No se puede verificar la existencia de pagos para la generacion de mensajes del motor de pago para Swap debido a que el proceso de DEVENGAMIENTO no se ha realizado", vbExclamation, "MOTOR DE PAGOS"
         End If
      End If
   End If
    
   If MsgBox("¿Esta seguro que desea salir de BacSwap?", vbQuestion + vbYesNo, "BacSwap") = vbNo Then
      Cancel = 1
      Exit Sub
   End If
   If Bloquea_Usuario(False, gsBAC_User) Then
      Call MISQL.SQL_Close
      End
   End If
   
End Sub

Private Sub Opc_10100_Click()
   If gsc_Parametros.findia = 1 Then
      BacInicioDia.Show
   Else
      MsgBox "No Ha Realizado Fin de Día!!", vbExclamation, "Inicio de Día"
   End If
End Sub

Private Sub Opc_20100_Click()
   If ChequeaCierreMesa() Then
      swOperSwap = "Ingreso"
      BacIrfNueVentana "SWTAA"
   Else
      MsgBox "No se pueden Agregar Operaciones debido a que se ha Cerrado la Mesa", vbInformation, Msj
   End If
End Sub

Private Sub Opc_20200_Click()
   If ChequeaCierreMesa() Then
      cOperSwap = "Ingreso"
      Tipo_Producto = "SM"
      BacOpeSwapMonedaULT.Show
   Else
      MsgBox "Se ha realizado Cierre de Mesa", vbInformation, Msj
   End If
End Sub

Private Sub Opc_20300_Click()
   If ChequeaCierreMesa() Then
        Call FRM_SWAP_OP_FRA.Show  '         'PROD-10967
   Else
      MsgBox "Se ha realizado Cierre de Mesa", vbInformation, Msj
   End If
'  PROD-10967
'   If ChequeaCierreMesa() Then
'      swOperSwap = "Ingreso"
'      BacIrfNueVentana "FRANA"
'   Else
'      MsgBox "Se ha realizado Cierre de Mesa", vbInformation, Msj
'   End If
End Sub

Private Sub Opc_20301_Click()
   If ChequeaCierreMesa() Then
      If ChequeaICPdelDia = True Then
         swOperSwap = "Ingreso"
         BacIrfNueVentana "SPCAA"
      Else
         MsgBox "No se ha ingresado el Indice Camara Promedio." & vbCrLf & "... No puede ocupar esta opción", vbExclamation, TITSISTEMA
      End If
   Else
      MsgBox "No se pueden Agregar Operaciones debido a que se ha Cerrado la Mesa", vbInformation, TITSISTEMA
   End If
End Sub

Private Sub Opc_20302_Click()
   If ChequeaCierreMesa() Then
      FRM_SWAP_OP.Show
   Else
      MsgBox "Se Ha Realizado Cierre de Mesa.", vbInformation, TITSISTEMA
   End If
End Sub

Private Sub Opc_20400_Click()
   BacConsultaOper.Show
End Sub

Private Sub Opc_20700_Click()
   BacCierreMesa.Show
End Sub

Private Sub Opc_20701_Click()
   Call gsc_Parametros.DatosGenerales
   
   If Not gsc_Parametros.cierreMesa Then
      BacCierreMesa.Tag = "N"
      BacCierreMesa.Show
   Else
      MsgBox "Sólo se Puede Bloquear la Mesa", vbOKOnly, TITSISTEMA
   End If
End Sub

Private Sub Opc_20801_Click()
    FRM_ANULA_TICKET.Show
End Sub

Private Sub Opc_30100_Click()
Call gsc_Parametros.DatosGenerales

If gsc_Parametros.cierreMesa = "1" Then MsgBox "Ya se realizo cierre de mesa", vbCritical: Exit Sub
    Consulta_Anticipos.Show

End Sub

Private Sub Opc_30200_Click()

   Informe_Anticipo_SWAP.Show

End Sub

Private Sub Opc_30300_Click()
Call gsc_Parametros.DatosGenerales

If gsc_Parametros.cierreMesa = "1" Then MsgBox "Ya se realizo cierre de mesa", vbCritical: Exit Sub
   Anulacion_Anticipo.Show

End Sub

Private Sub Opc_30401_Click()
   FRM_ANULA_TICKET.Anticipo = True
   FRM_ANULA_TICKET.Show
End Sub

Private Sub Opc_40101_Click()
   
   Dim nContador  As Integer
   
   For nContador = 0 To Forms.Count - 1
      If Forms(nContador).Name = "BacContratoSwap" Then
         MsgBox "Para utilizar la impresion de contratos de condiciones generales debe cerrar la aplicacion de los contratos especificos", vbExclamation + vbOKOnly
         Unload BacCondicionesGenerales
         Exit Sub
      End If
   Next nContador
   
   BacControlWindows 100
   BacCondicionesGenerales.Show
End Sub

Private Sub Opc_40102_Click()
   
   Dim nContador  As Integer
   
   For nContador = 0 To Forms.Count - 1
      If Forms(nContador).Name = "BacCondicionesGenerales" Then
         MsgBox "Para utilizar la impresion de contratos de condiciones generales debe cerrar la aplicacion de los contratos especificos", vbExclamation + vbOKOnly
         Unload BacContratoSwap
         Exit Sub
      End If
   Next nContador
   
   BacControlWindows 100
   BacContratoSwap.Tag = "Empresa"
   BacContratoSwap.Show
End Sub

Private Sub Opc_40103_Click()
   
   Dim nContador  As Integer
   
   For nContador = 0 To Forms.Count - 1
      If Forms(nContador).Name = "BacCondicionesGenerales" Then
         MsgBox "Para utilizar la impresion de contratos especificos debe cerrar la aplicacion de contratos de condiciones generales", vbExclamation + vbOKOnly
         Unload BacContratoSwap
         Exit Sub
      End If
   Next nContador
   
   BacControlWindows 100
   BacContratoSwap.Show
End Sub

Private Sub Opc_40104_Click()
   BacControlWindows 100
   BacInformeProtocoloDef.Show
End Sub

Private Sub Opc_40106_Click()
Fax_Confirmacion.Show
End Sub

Private Sub Opc_40107_Click()
   BacControlWindows 100
   BacLiquidacionesSwaps.Show
End Sub

Private Sub Opc_40108_Click()
   BacControlWindows 100
   BacCapituloVII.Show
End Sub

Private Sub Opc_40109_Click()
   BacFiltraFechas.Tag = "CapIXA3"
   BacFiltraFechas.Show
End Sub

Private Sub Opc_40110_Click()
   FRM_INFORMES_COBERTURA.Show
End Sub

Private Sub Opc_40111_Click()
   
   BacControlWindows 100
   Frm_Reimprime_Contratos.Show
End Sub

Private Sub Opc_40112_Click()

  FRM_CAPIX_ANEXO3.Tag = "IntCapIXA3"
  FRM_CAPIX_ANEXO3.Show
  
End Sub

Private Sub Opc_40113_Click()

    FRM_FILTRA_FECHA.Tag = "IntCapIXA3Cart_Vig"
    FRM_FILTRA_FECHA.Show


End Sub

Private Sub Opc_40201_Click()
   BacInformes.Tipo_Producto = Tipo_ProductoST
   BacInformes.Tag = "TASAS"
   BacInformes.Show
End Sub

Private Sub Opc_40202_Click()
   BacControlWindows 100
   BacInformes.Tipo_Producto = Tipo_ProductoSM
   BacInformes.Tag = "MONEDAS"
   BacInformes.Show
End Sub

Private Sub Opc_40203_Click()
   BacControlWindows 100
   BacMovimientoFRA.Tag = ""
   BacMovimientoFRA.Show
End Sub

Private Sub Opc_40203A_Click()
   BacInformes.Tipo_Producto = Tipo_ProductoSPC
   BacInformes.Tag = "SPC"
   BacInformes.Show
End Sub

Private Sub Opc_40203B_Click()
    Informe_Oper_Dia.Show
End Sub

Private Sub Opc_40207_Click()
   InformeVctoFlujos.Show
End Sub

Private Sub Opc_40208_Click()
   On Error GoTo PrintError
   
'CER 28/04/2008  - Req. Pantalla Ingreso Op. Swap
   Call BacLimpiaParamCrw
   
   BACSwap.Crystal.WindowTitle = "Informe Basiles Swap"
   BACSwap.Crystal.ReportFileName = gsRPT_Path & "Flujos_Para_Fijar_Tasa.rpt"
                  '--> Store Procedure : dbo.GENERA_INFORME_BASILEA_PCS.sql
   BACSwap.Crystal.StoredProcParam(0) = gsBAC_User
   BACSwap.Crystal.Destination = crptToWindow
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Action = 1
Exit Sub
PrintError:
   MsgBox "Error Impresión" & vbCrLf & vbCrLf & BACSwap.Crystal.LastErrorString, vbExclamation, TITSISTEMA

End Sub

Private Sub Opc_40303A_Click()
   BacInformeCartera.Tipo_Producto = Tipo_ProductoSPC
   BacInformeCartera.Tag = "PromedioCamara"
   BacInformeCartera.Show
End Sub

Private Sub Opc_40301_Click()
   BacInformeCartera.Tipo_Producto = Tipo_ProductoST
   BacInformeCartera.Tag = "Tasa"
   BacInformeCartera.Show
End Sub
Private Sub Opc_40302_Click()
   BacInformeCartera.Tipo_Producto = Tipo_ProductoSM
   BacInformeCartera.Tag = "Moneda"
   BacInformeCartera.Show
End Sub
Private Sub Opc_40303_Click()
   BacControlWindows 100
   bacCarteraFRA.Show
End Sub
Private Sub Opc_40304_Click()
   BAC_INFORME_CARTERA.Show
End Sub
Private Sub Opc_40306_Click()
   frmInfValorizacion.TipoReporte = "Flu"
   frmInfValorizacion.Show
End Sub
Private Sub Opc_40307_Click()
   frmInfValorizacion.TipoReporte = "Ope"
   frmInfValorizacion.Show
End Sub
Private Sub Opc_40501_Click()
   BacInformes.Tag = "VOUCHER"
   BacInformes.Show
End Sub
Private Sub Opc_40502_Click()
   BacInformes.Tag = "CONSOLIDADO"
   BacInformes.Show
End Sub
Private Sub Opc_40503_Click()
   BacInformes.Tag = "RECUENTAS"
   BacInformes.Show
End Sub
Private Sub Opc_40600_Click()
   
''  Call FRM_INFORME_BASILEA.Show
''    20090115 -- Se elimina menú, ya que nuevo informe de Derivados se emitirá
''                se emitirá desde Renta Fija.
''    Opción Menú(Caption) : Informe Basilea Swap
''    (Name): Opc_40600
   
   
   
Exit Sub

   On Error GoTo PrintError
   Call BacLimpiaParamCrw
   
   BACSwap.Crystal.WindowTitle = "Informe Basiles Swap"
   BACSwap.Crystal.ReportFileName = gsRPT_Path & "InformeBasileaSwap.rpt"
                  '--> Store Procedure : dbo.GENERA_INFORME_BASILEA_PCS.sql
   BACSwap.Crystal.StoredProcParam(0) = gsBAC_User
   BACSwap.Crystal.Destination = crptToWindow
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Action = 1
Exit Sub
PrintError:
   MsgBox "Error Impresión" & vbCrLf & vbCrLf & BACSwap.Crystal.LastErrorString, vbExclamation, TITSISTEMA
End Sub

Private Sub Opc_40625_Click()
    BacInformeCarteraAVR.Show
End Sub

Private Sub Opc_40627_Click()
    Informe_Oper_Dia_Ticket.Show
End Sub

Private Sub Opc_40628_Click()
    BacInformeCartera_Ticket.Show
End Sub

Private Sub Opc_50100_Click()
   If gsc_Parametros.cierreMesa = "1" Then
      BacDevengamiento.Tag = "DEV"
      BacDevengamiento.Show
   Else
      MsgBox "No se puede realizar Proceso de Devengamiento, Mesa de Dinero no está Cerrada", vbExclamation, Msj
   End If
End Sub
Private Sub Opc_50200_Click()
'CER 28/04/2008  - Req. Pantalla Ingreso Op. Swap
'Se solicita eliminar opción de Valorización de Menú
'   BacControlWindows 100
'   BacDevengamiento.Tag = "VAL"
'   BacDevengamiento.Show
End Sub
Private Sub Opc_50300_Click()
   Call gsc_Parametros.DatosGenerales
   If gsc_Parametros.Devengo Then
      Call BacControlWindows(100)
      Contabilizacion_Automatica.Show
   Else
      MsgBox "Acción Cancelada." & vbCrLf & vbCrLf & "Devengamiento de Cartera No Realizado... Favor Devengar.", vbExclamation, TITSISTEMA
   End If
End Sub
Private Sub Opc_50311_Click()
   Call gsc_Parametros.DatosGenerales
   FRM_MNT_Moneda_MonedaPago.Show
End Sub
Private Sub Opc_50312_Click()
   FRM_MNT_PERIODICIDAD_TASAS.Show
End Sub
Private Sub Opc_50313_Click()
   FRM_MNT_CONVENCION_AJUSTE_INTERES.Show
End Sub

Private Sub Opc_50316_Click()

   If gsc_Parametros.cierreMesa = "1" Then
      BacDevengamiento_Ticket.Tag = "DEV"
      BacDevengamiento_Ticket.Show
   Else
      MsgBox "No se puede realizar Proceso de Devengamiento, Mesa de Dinero no está Cerrada", vbExclamation, Msj
   End If

End Sub

Private Sub Opc_50317_Click()
    BacEnvioSpot.Show
End Sub

Private Sub Opc_50318_Click()
    BacSwapFechaFijacion.Show
End Sub

Private Sub Opc_50319_Click()
BacSwapFechaLiquidacion.Show
End Sub

Private Sub Opc_50500_Click()
   Call gsc_Parametros.DatosGenerales
   If gsc_Parametros.Devengo Then
      MsgBox "Ya se ha Devengado, No se Puede utilizar esta Opción", vbOKOnly, TITSISTEMA
   Else
      BacTasaFlujo.Show
   End If
End Sub

Private Sub Opc_60100_Click()
'''''   Call gsc_Parametros.DatosGenerales
'''''   If gsc_Parametros.Contabilidad = 0 Then
'''''      MsgBox "Acción Cancelada." & vbCrLf & vbCrLf & "Contabilidad Automática No Generada.... Favor Generar.", vbExclamation, TITSISTEMA
'''''   Else
'''''      BacInterfaces.Tag = "Interfaz Contable MN"
'''''      BacInterfaces.Show
'''''   End If

End Sub
Private Sub Opc_60110_Click()
   Call gsc_Parametros.DatosGenerales
   If gsc_Parametros.Contabilidad = 0 Then
      MsgBox "No se ha realizado la contabilidad" & vbCrLf & "NO Puede Utilizar esta Opción", vbExclamation, TITSISTEMA
   Else
      BacInterfaces.Tag = "Interfaz Contable MX"
      BacInterfaces.Show
   End If
End Sub
Private Sub Opc_50600_Click()
  Call gsc_Parametros.DatosGenerales
   If gsc_Parametros.Devengo Then
      MsgBox "Ya se ha Devengado, No se Puede utilizar esta Opción", vbOKOnly, TITSISTEMA
   Else
      BacTasaFlujoVencimiento.Show
   End If
End Sub

Private Sub Opc_50700_Click()
    'Calculo de Liquidacion
    Call gsc_Parametros.DatosGenerales
    If gsc_Parametros.findia = 1 Then
       MsgBox "Dia Cerrado" & vbCrLf & "NO Puede Utilizar esta Opción", vbExclamation, TITSISTEMA
    Else
       Call EjecutaProcesoCalculoLiquidaciones 'BacGeneral.
    End If
End Sub

Private Sub Opc_60120_Click()
   Call gsc_Parametros.DatosGenerales
   If gsc_Parametros.Contabilidad = 0 Then
      MsgBox "No se ha realizado la contabilidad" & vbCrLf & "NO Puede Utilizar esta Opción", vbExclamation, TITSISTEMA
   Else
      BacInterfaces.Tag = "Interfaz xFil"
      BacInterfaces.Show
   End If
End Sub
Private Sub Opc_60130_Click()
   Call gsc_Parametros.DatosGenerales
   If gsc_Parametros.Contabilidad = 0 Then
      MsgBox "No se ha realizado la contabilidad" & vbCrLf & "NO Puede Utilizar esta Opción", vbExclamation, TITSISTEMA
   Else
      BacInterfaces.Tag = "Interfaz xFlu"
      BacInterfaces.Show
   End If
End Sub

Private Sub Opc_60140_Click()
   Call gsc_Parametros.DatosGenerales
   If gsc_Parametros.Contabilidad = 0 Then
      MsgBox "No se ha realizado la contabilidad" & vbCrLf & "NO Puede Utilizar esta Opción", vbExclamation, TITSISTEMA
   Else
      BacInterfaces.Interfaz = "Interfaz Posicion"
      BacInterfaces.Show
   End If
End Sub

Private Sub Opc_60150_Click()
   Call gsc_Parametros.DatosGenerales
   If gsc_Parametros.Contabilidad = 0 Then
      MsgBox "No se ha realizado la contabilidad" & vbCrLf & "NO Puede Utilizar esta Opción", vbExclamation, TITSISTEMA
   Else
      BacInterfaces.Interfaz = "Interfaz Operaciones"
      BacInterfaces.Show
   End If
End Sub

Private Sub Opc_60160_Click()
   Call gsc_Parametros.DatosGenerales
   If gsc_Parametros.Contabilidad = 0 Then
      MsgBox "No se ha realizado la contabilidad" & vbCrLf & "NO Puede Utilizar esta Opción", vbExclamation, TITSISTEMA
   Else
      BacInterfaces.Interfaz = "Interfaz Flujos"
      BacInterfaces.Show
   End If
End Sub

Private Sub Opc_60170_Click()
   Call gsc_Parametros.DatosGenerales
   If gsc_Parametros.Contabilidad = 0 Then
      MsgBox "No se ha realizado la contabilidad" & vbCrLf & "NO Puede Utilizar esta Opción", vbExclamation, TITSISTEMA
   Else
      BacInterfaces.Interfaz = "Interfaz direcciones"
      BacInterfaces.Show
   End If
End Sub

Private Sub Opc_60180_Click()
   Call gsc_Parametros.DatosGenerales
   If gsc_Parametros.Contabilidad = 0 Then
      MsgBox "No se ha realizado la contabilidad" & vbCrLf & "NO Puede Utilizar esta Opción", vbExclamation, TITSISTEMA
   Else
      BacInterfaces.Interfaz = "Interfaz derivados"
      BacInterfaces.Show
   End If
End Sub

Private Sub Opc_60190_Click()
   Call gsc_Parametros.DatosGenerales
   If gsc_Parametros.Contabilidad = 0 Then
      MsgBox "No se ha realizado la contabilidad" & vbCrLf & "NO Puede Utilizar esta Opción", vbExclamation, TITSISTEMA
   Else
      BacInterfaces.Interfaz = "Interfaz balance"
      BacInterfaces.Show
   End If
End Sub

Private Sub Opc_70100_Click()
   Call gsc_Parametros.DatosGenerales
   If gsc_Parametros.cierreMesa <> "1" Then
      MsgBox "No se ha realizado el cierre de mesa", vbExclamation, "Fin de Día"
   ElseIf gsc_Parametros.Devengo = 0 Then
      MsgBox "No se ha realizado el devengo", vbExclamation, "Fin de Día"
   ElseIf gsc_Parametros.Contabilidad = 0 Then
      MsgBox "No se ha realizado la contabilidad", vbExclamation, "Fin de Día"
   Else
      Call FRM_PROC_FDIA.Show
   End If
End Sub


Private Sub Vbsql1_Error(SqlConn As Integer, Severity As Integer, ErrorNum As Integer, ErrorStr As String, RetCode As Integer)
   BacLogFile "VBSQL = " & SqlConn & "-" & Severity & "-" & ErrorNum & "-" & ErrorStr & "-" & RetCode
End Sub

Private Sub VBSQL1_Message(SqlConn As Integer, Message As Long, State As Integer, Severity As Integer, MsgStr As String)
End Sub

Private Sub Opc_70201_Click()
    BacSinacofi.Show
End Sub



Private Sub OPC_CambioPassword_Click()

   If gsBAC_User = "ADMINISTRA" Then
      Call MsgBox("El Usuario ADMINISTRA, no puede cambiar la clave de acceso desde este modulo.", vbExclamation, App.Title)
   Else
       Let oBligacion = False
      Call Cambio_Password.Show(vbModal)
   End If

End Sub

Private Sub OPC_RecalcLineas_Click()
   '--> Se activa lña generación del Recalculo de Lineas
   FRM_RECALCULO_LINEAS.Show
End Sub

Private Sub Salida_Click()
   Unload Me
End Sub

Private Sub Todo_Desactivado()
   Dim i%
   Dim bSw     As Boolean
   
   ' DESHABILITA TODAS LAS OPCIONES DEL MENU
   For i% = 0 To Me.Controls.Count - 1
      bSw = ((TypeOf Me.Controls(i%) Is MENU) And i% <> 47)
      If bSw = True Then
         If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" And Me.Controls(i%).Caption <> "Salir" Then
            Me.Controls(i%).Enabled = False
         End If
      End If
   Next i%
End Sub

Sub DESHABILITA_MENU()
   On Error Resume Next
   Dim i%
    
   ' DESHABILITA TODAS LAS OPCIONES DEL MENU
   For i% = 0 To Me.Controls.Count - 1
      If TypeOf Me.Controls(i%) Is MENU Then
         If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" And Me.Controls(i%).Caption <> "Salir" And Me.Controls(i%).Caption <> "Salir del Sistema" Then
            Me.Controls(i%).Enabled = False
         End If
      End If
      If TypeOf Me.Controls(i%) Is CommandButton Then
         Me.Controls(i%).Enabled = False
      End If
   Next i%
End Sub

Sub MENU_TODOHABILITADO()
   Dim i%
   ' HABILITA TODAS LAS OPCIONES DEL MENU
   For i% = 0 To Me.Controls.Count - 1
      If TypeOf Me.Controls(i%) Is MENU Then
         If Me.Controls(i%).Caption <> "-" And Me.Controls(i%).Caption <> "?" And Me.Controls(i%).Caption <> "Salir" And Me.Controls(i%).Caption <> "Salir del Sistema" Then
            Me.Controls(i%).Enabled = True
         End If
      End If
      If TypeOf Me.Controls(i%) Is CommandButton Then
         Me.Controls(i%).Visible = True
      End If
   Next i%
End Sub

Private Sub SwapColateral_Click()
    BAC_INFORME_COLATERAL.Show
End Sub

Private Sub Tmrfecha_Timer()
Static Intervalo As Long
Intervalo = Intervalo + Tmrfecha.Interval
    If Intervalo > gsBac_Timer_Adicional Then
        Intervalo = 0
          If Not Proc_Valida_Fecha Then
            Call MISQL.SQL_Close
            End
          End If
    End If
End Sub


