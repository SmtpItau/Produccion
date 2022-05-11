Attribute VB_Name = "BacGeneral"
Option Explicit
Public Declare Function GetDeviceCaps Lib "gdi32" (ByVal hdc As Long, ByVal nIndex As Long) As Long

'Fecha del Sistema
Global FechaSistema As Date
Global Const FDecimal = "#,##0.0000"
Global Const FEntero = "#,##0"
Global Const FechaYMD = "yyyymmdd"

Global Const TITSISTEMA = "CONTROL FINANCIERO"
Global Const FeFecha = "yyyymmdd"

Global Const gcMaximoVentanas = 5

'VARIABLES DE ADMINISTRACION
Global gsUsuario As String
Global gsSistema As String
Global gsTerminal As String
Global gsNombreUs As String
Global gsUsuarioReal As String
Global Reporte_Error As String

'Referencia a Botones.-
Global MATRIXERROR()
Global Const iGlbBotonGrabar% = 1
Global Const iGlbBotonMValr% = 2
Global Const iGlbBotonSelec% = 3
Global Const iGlbBotonNETrader% = 4
Global Const iGlbBotonAsign% = 5
Global Const iGlbBotonFloating% = 6
Global IDTIPO As Long
Global a1 As Integer
Global i%
Global NfpER$
Global montosimula As Double
'SQL
Global giSQL_ConnectionMode   As Integer
Global gsSQL_Database         As String
Global gsSQL_Server           As String
Global gsSQL_Login            As String
Global gsSQL_Password         As String
Global giSQL_LoginTimeOut     As String
Global giSQL_QueryTimeOut     As String
Global giSQL_DatabaseCommon   As String

Global gsSQL_DatabaseBCC         As String
Global gsSQL_LoginBCC            As String
Global gsSQL_PasswordBCC         As String

Global gsSQL_DatabaseBFW         As String
Global gsSQL_LoginBFW            As String
Global gsSQL_PasswordBFW         As String

Global gsSQL_DatabaseBTR         As String
Global gsSQL_LoginBTR            As String
Global gsSQL_PasswordBTR         As String

Global gsSQL_DatabasePCS         As String
Global gsSQL_LoginPCS            As String
Global gsSQL_PasswordPCS         As String

Global gsSQL_DatabaseBEX         As String
Global gsSQL_LoginBEX            As String
Global gsSQL_PasswordBEX         As String

Global gsBac_LineasDb As String

Global gsSQL_RutaLine         As String
Global gsSQL_NombreLinea      As String

Global Panta$
Global envento$
Global Mensaje$
Global Muestra$
Global Valmod%
Global Focomonto As Boolean
Global Datos()
Global Puede As Boolean

Global gsMDB_Path             As String
Global gsMDB_Database         As String
Global DB                     As Database
Global WS                     As Workspace
Global gsc_FechaDMA           As String
Global gsRPT_Path             As String
Global gsRPT_PathBCC          As String
Global gsRPT_PathBFW          As String
Global gsRPT_PathBTR          As String
Global gsRPT_PathPCS          As String
Global gsRPT_PathBEX          As String

Global gsBac_Office      As String

Global gsBac_RutC           As String

Global gsBac_Tipo_Usuario     As String
Global gsRUN_Proceso          As String
Global pan                    As Object

Global giBAC_TCRC             As Double
Global giBAC_Entidad          As Integer
Global gsBAC_DolarOBs         As String
Global gsBAC_Ingreso          As Boolean
Global gsBAC_Login            As Boolean
Global gsBAC_User             As String
Global gsBAC_Term             As String
Global gsBAC_Pass             As String
Global gsBAC_Fecp             As Date
Global gsBAC_FecAnt           As Date '8800
Global gsBAC_FecConFin        As Date '8800

Global gsBAC_GloMon           As String
Global gsBAC_Fecpx            As String
Global gsBAC_CodCliente       As Integer
Global gsBAC_Clien            As String
Global gsBAC_ValmonUF         As String
Global gsBAC_Valmonlocal      As String
Global gsBAC_DolarAcuer       As String
Global gsBAC_BandaInfer       As String
Global gsBAC_BandaSuper       As String
Global gsBAC_Plaza            As String
Global gsBAC_acswpd           As String
Global gsBAC_acswcart         As String
Global gsBAC_SNActiva         As String
Global gsBAC_LogDig           As String
Global gsBac_IP               As String

'Variable que me indica si presiono el boton Aceptar de la pantalla de Ayuda
Global giAceptar            As Boolean
Global giPapeletaEnPantalla As Integer

'Variables usadas en la pantalla de Ayuda
Global gsCodigo         As String
Global gsDigito         As String
Global gsDescripcion    As String
Global gsfax            As String
Global gsSerie          As String
Global gsnemo           As String
Global gsglosa          As String
Global gsredondeo       As String
Global gsvalor          As String
Global gsnombre         As String
Global gsCodCli         As String '--> se declara nueva variable
   Global gsgeneric As String
   Global gsdirecc As String
   Global gsciudad As String
   Global gsPais As String
   Global gscomuna As String
   Global gsregion As String
   Global gstipocliente As String
   Global gsEntidad As String
   Global gscalidadjuridica As String
   Global gsGrupo As String
   Global gsMercado As String
   Global gsapoderado As String
   Global gsctacte As String
   Global gsfono As String
   Global gs1Nombre As String
   Global gs2Nombre As String
   Global gs1Apellido As String
   Global gs2Apellido As String
   Global gsCtausd As String
   Global gsImplic As String
   Global gsAba As String
   Global gsChips As String
   Global gsSwift As String
    '-->2021.06.16 cvegasan nGine obtiene rut con digito verificador
   Global gsRutDV As String
   '--<2021.06.16 cvegasan nGine obtiene rut con digito verificador
Public sSeparadorFecha    As String
Public gsc_PuntoDecim      As String
Public gsc_SeparadorMiles  As String
Public gsc_FechaMDA        As String
Public gsc_FechaAMD        As String
Public gsc_FechaSeparador  As String
Public gsBac_Version       As String
Public gsBac_TotalOcupado As Double
Global gbBAC_Login      As Boolean
Global gsODBC As String
Global swConeccion As String

Global swConeccionBCC As String
Global gsODBCBCC As String


Global swConeccionBFW As String
Global gsODBCBFW As String

Global swConeccionBTR As String
Global gsODBCBTR As String

Global swConeccionPCS As String
Global gsODBCPCS As String

Global swConeccionBEX As String
Global gsODBCBEX As String





'Colores
Global Const ColorNegro = &H0&
Global Const ColorAzul = &H800000
Global Const ColorBlanco = &H80000005
Global Const ColorVerde = &H808000
Global Const ColorGris = &HC0C0C0
Global Const ColorCeleste = &HFFFF00

'Verifica si existe Operacion
Global Existeope As String

 Public miSQL As New BTPADODB.CADODB

'Clases
Public gsc_Parametros      As New clsParametros

'Funciones API de Windows.-
Declare Function GetPrivateProfileString Lib "kernel32" (ByVal s$, ByVal e$, ByVal D$, ByVal r$, ByVal n%, ByVal A$) As Integer
Declare Function IsIconic Lib "User32" (ByVal hWnd As Integer) As Integer
Declare Function SendMessageByNum Lib "User32" Alias "SendMessage" (ByVal hWnd%, ByVal wMsg%, ByVal wParam%, ByVal lParam&) As Long

'Constantes API de Windows.-

Global Const WM_USER = &H400
Global Const LB_SELECTSTRING = (WM_USER + 13)
Global Const CB_FINDSTRINGEXACT = (WM_USER + 24)
Global Const LB_FINDSTRING = (WM_USER + 16)

'Parametros globales
Global Const OP_SEGCAMBIO = 1
Global Const OP_ARBITRAJE = 2
Global Const OP_SEGINFLAC = 3
Global Const OP_SINTETICO = 4
Global Const OP_OPERA1446 = 5
Global Const OP_OPERHEDGE = 6
Global Const OP_COMPPARCI = 7
Global Const OP_VENTABCCH = 8
Global Const OP_OPCIONES = 9
Global Const OP_FBT = 10
Global Const OP_OTL = 11
Global Const OP_ARBITRAJEMX$ = 12


Global gsBac_Lineas As String

'LD1-COR-035
Global Const gsBac_Parametros = "BacParamSuda"


Type Excesos_Lineas
     Cod_Exceso    As Integer
     Msg_Exceso    As String
     Monto         As Double
     Plazo         As Integer
     Monto_Ocupado As Double
End Type

Public Excesos(5) As Excesos_Lineas


Global nPanta As Integer
Global RetornoAyuda  As String
Global RetornoAyuda2 As String
Global RetornoAyuda3 As String
Global RetornoAyuda4 As String

'PROD-10967
Global Operacion_DRV As String
Global FechaVenc_DRV As Date
Global Clie_Operacion_Midd As String

Global N_Contrato As String
Global Rut_Origen As String
Global Nombre_Origen As String
Global Codigo_Origen As String
Global Rut_Destino As String
Global Nombre_Destino As String
Global Codigo_Destino As String

'PROD-10967

'Definición de Impresoras
Global gsBac_IMPWIN     As String 'Por defecto de Windows
Global gsBac_QUEDEF     As String 'Para Papeletas
Global gsBac_IMPDEF     As String 'Para Papeletas

Global SwImprimir    As String

Global gsTipoPapeleta As String

Global Numero_O               As Double

Global Const Glb_Sistema_Spot = "BCC"
Global Const Glb_Sistema_Trader = "BTR"
Global Const Glb_Sistema_Bonos = "BEX"
Global Const Glb_Sistema_Swap = "PCS"
Global Const Glb_Sistema_Forward = "BFW"

Global Const GLB_CARTERA = "204"
Global Const GLB_CARTERA_NORMATIVA = "1111"
Global Const GLB_LIBRO = "1552"
Global Const GLB_AREA_RESPONSABLE = "1553"
Global Const GLB_SUB_CARTERA_NORMATIVA = "1554"



Public Const GWL_STYLE = (-16)
Public Declare Function SetWindowLong Lib "User32" (ByVal hWnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Public Declare Function GetWindowLong Lib "User32" (ByVal hWnd As Long, ByVal nIndex As Long) As Long

Sub PROC_LLENA_COMBOS(Combo As Object, opcion As Integer, bTodos As Boolean, cParametro1 As String, Optional cParametro2 As String, Optional cParametro3 As String, Optional cParametro4 As String, Optional cParametro5 As String)

    Dim Datos()

    Envia = Array()
    AddParam Envia, opcion
    AddParam Envia, IIf(Trim(cParametro1) <> "", Trim(cParametro1), "")
    AddParam Envia, IIf(Trim(cParametro2) <> "", Trim(cParametro2), "")
    AddParam Envia, IIf(Trim(cParametro3) <> "", Trim(cParametro3), "")
    AddParam Envia, IIf(Trim(cParametro4) <> "", Trim(cParametro4), "")
    AddParam Envia, IIf(Trim(cParametro5) <> "", Trim(cParametro5), "")
        
    If Not Bac_Sql_Execute("sp_con_info_combo", Envia) Then
        MsgBox "Problemas al Intentar llanar el combo", vbCritical
        Exit Sub
    End If
    
    Combo.Clear
    
    If bTodos = True Then
        Combo.AddItem "< TODOS [AS] >" & Space(110)
    End If
    
    Do While Bac_SQL_Fetch(Datos())
            Combo.AddItem Datos(6) & Space(110) & Datos(2)
    Loop
    
    If Combo.ListCount > 0 Then
        Combo.ListIndex = 0
    End If

End Sub


Public Function BacControlIni() As Boolean
   BacControlIni = True
End Function


Public Function BacInit() As Boolean
   Dim sFile$
   Dim sFile1$
   Dim sSeparadorFecha$
   Dim Directorio       As String

   BacInit = True
   
   'Traer datos generales del Sistema
   sFile$ = "Bac-Sistemas.ini"
   If Dir("C:\WINNT\" & sFile$) <> "" Then
      sFile = "C:\WINNT\" & sFile$
   ElseIf Dir("C:\WINDOWS\" & sFile$) <> "" Then
      sFile = "C:\WINDOWS\" & sFile$
   ElseIf Dir("C:\BTRADER\" & sFile$) <> "" Then
      sFile = "C:\BTRADER\" & sFile$
   ElseIf Dir("C:\" & sFile$) <> "" Then
      sFile = "C:\" & sFile$
   ElseIf Dir(App.Path & "\" & sFile$) <> "" Then
      sFile = App.Path & "\" & sFile$
   Else
      MsgBox "Archivo de Configuraciones No existe.", vbCritical, TITSISTEMA
      End
   End If
      
   'NET y Datos Grales.
   gsBAC_User = Func_Read_INI("NET", "NET_UserName", sFile$)
   gsBAC_Term = Func_Read_INI("NET", "NET_ComputerName", sFile$)
   sFile1$ = Func_Read_INI("INI", "DBO_PATH", sFile$) & "DBO.INI"
   gsBAC_Pass$ = ""

   'SQL
   gsSQL_Database = Func_Read_INI("SQL", "DB_Lineas", sFile$)
   gsBac_LineasDb = Func_Read_INI("SQL", "DB_Lineas", sFile$)
   gsSQL_Server = Func_Read_INI("SQL", "Server_Name", sFile$)
   '+++cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
   gsSQL_Login = Func_Read_INI("usuario", "usuario", sFile1$)
   gsSQL_Password = Encript(Trim(Func_Read_INI("usuario", "password", sFile1$)), False)
   '---cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
   giSQL_LoginTimeOut = Val(Func_Read_INI("SQL", "Login_TimeOut", sFile$))
   giSQL_QueryTimeOut = Val(Func_Read_INI("SQL", "Query_TimeOut", sFile$))
   giSQL_ConnectionMode = Val(Func_Read_INI("SQL", "Connection_Mode", sFile$))
   gsODBC = Func_Read_INI("SQL", "ODBC_Lineas", sFile$)
   
   
   'Coneción Aa reportes de Spot
   gsSQL_DatabaseBCC = Func_Read_INI("SQL", "DB_Cambio", sFile$)
   gsODBCBCC = Func_Read_INI("SQL", "ODBC_Cambio", sFile$)
   gsSQL_LoginBCC = Func_Read_INI("usuario", "usuario", sFile1$)
   gsSQL_PasswordBCC = Encript(Trim(Func_Read_INI("usuario", "password", sFile1$)), False)
   
   'Coneción a reportes de Forward
   gsSQL_DatabaseBFW = Func_Read_INI("SQL", "DB_Futuro", sFile$)
   gsODBCBFW = Func_Read_INI("SQL", "ODBC_Futuro", sFile$)
   gsSQL_LoginBFW = Func_Read_INI("usuario", "usuario", sFile1$)
   gsSQL_PasswordBFW = Encript(Trim(Func_Read_INI("usuario", "password", sFile1$)), False)

   'Coneción a reportes de Renta Fija
   gsSQL_DatabaseBTR = Func_Read_INI("SQL", "DB_Trader", sFile$)
   gsODBCBTR = Func_Read_INI("SQL", "ODBC_Trader", sFile$)
   gsSQL_LoginBTR = Func_Read_INI("usuario", "usuario", sFile1$)
   gsSQL_PasswordBTR = Encript(Trim(Func_Read_INI("usuario", "password", sFile1$)), False)

   'Coneción a reportes de Swap
   gsSQL_DatabasePCS = Func_Read_INI("SQL", "DB_Swap", sFile$)
   gsODBCPCS = Func_Read_INI("SQL", "ODBC_Swap", sFile$)
   gsSQL_LoginPCS = Func_Read_INI("usuario", "usuario", sFile1$)
   gsSQL_PasswordPCS = Encript(Trim(Func_Read_INI("usuario", "password", sFile1$)), False)

   'Coneción a reportes de Bonos exterior
   gsSQL_DatabaseBEX = Func_Read_INI("SQL", "DB_Invext", sFile$)
   gsODBCBEX = Func_Read_INI("SQL", "ODBC_Invex", sFile$)
   gsSQL_LoginBEX = Func_Read_INI("usuario", "usuario", sFile1$)
   gsSQL_PasswordBEX = Encript(Trim(Func_Read_INI("usuario", "password", sFile1$)), False)

   
   'Impresoras
   gsBac_QUEDEF = Func_Read_INI("PRINTERS", "QUEDEF", sFile$)
   gsBac_IMPDEF = Func_Read_INI("PRINTERS", "PRNDEF", sFile$)
   gsBac_IMPWIN = Func_Read_INI("windows", "device", "WIN.INI")
   
   

   'INTERFAZ LINEAS
   gsSQL_RutaLine = Func_Read_INI("INTERFAZ", "INTERFAZ_LINEAS", sFile$)
   gsSQL_NombreLinea = Func_Read_INI("INTERFAZ", "NOMBRE_INT_LINEAS", sFile$)
   
   If gsSQL_Database = "" Or gsSQL_Server = "" Then
      MsgBox "Servidor No esta definido para conectarse con Base de Datos", vbCritical, TITSISTEMA
      Exit Function
   '+++cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
   'ElseIf gsSQL_Login = "" Or (gsSQL_Password = "" And gsSQL_Login <> "SA") Then
   '   MsgBox "Usuario No esta definido para conectarse con Base de Datos", vbCritical + vbOKOnly, TITSISTEMA
   '   Exit Function
   '---cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
   ElseIf giSQL_LoginTimeOut <= 0 Or giSQL_QueryTimeOut <= 0 Then
      MsgBox "Tiempos de Respuesta No son los apropiados para conectarse con Base de Datos", vbCritical + vbOKOnly, TITSISTEMA
      Exit Function
   End If
   
   If gsODBC = "" Then
      MsgBox "Coneccion ODBC No esta definida en archivo INI para conectarse con Base de Datos", vbCritical + vbOKOnly, TITSISTEMA
      Exit Function
   End If
   
   'Visualiza el nombre del servidor en el borde superior de la pantalla
   BacControlFinanciero.Caption = "Control Financiero ( Sql Server )  " & gsSQL_Server
   
    '+++cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
    'swConeccion = "DSN=" & gsODBC
    'swConeccion = swConeccion & ";UID=" & gsSQL_Login
    'swConeccion = swConeccion & ";PWD=" & gsSQL_Password
    'swConeccion = swConeccion & ";DSQ=" & gsSQL_Database
    'swConeccion = "DSN=" & gsODBC
    'swConeccion = swConeccion & ";TRUSTED_CONNECTION = yes"
    'swConeccion = swConeccion & ";DSQ=" & gsSQL_Database
    '---cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
    swConeccion = "DSN=" & gsODBC & ";UID=" & gsSQL_LoginBCC & ";PWD=" & gsSQL_PasswordBCC & ";DSQ=" & gsSQL_Database
   
    swConeccionBCC = "DSN=" & gsODBCBCC & ";UID=" & gsSQL_LoginBCC & ";PWD=" & gsSQL_PasswordBCC & ";DSQ=" & gsSQL_DatabaseBCC
    swConeccionBFW = "DSN=" & gsODBCBFW & ";UID=" & gsSQL_LoginBFW & ";PWD=" & gsSQL_PasswordBFW & ";DSQ=" & gsSQL_DatabaseBFW
    swConeccionBTR = "DSN=" & gsODBCBTR & ";UID=" & gsSQL_LoginBTR & ";PWD=" & gsSQL_PasswordBTR & ";DSQ=" & gsSQL_DatabaseBTR
    swConeccionPCS = "DSN=" & gsODBCPCS & ";UID=" & gsSQL_LoginPCS & ";PWD=" & gsSQL_PasswordPCS & ";DSQ=" & gsSQL_DatabasePCS
    swConeccionBEX = "DSN=" & gsODBCBEX & ";UID=" & gsSQL_LoginBEX & ";PWD=" & gsSQL_PasswordBEX & ";DSQ=" & gsSQL_DatabaseBEX
   
    gsRPT_Path = Func_Read_INI("REPORTES", "RPT_Lineas", sFile$)
    gsRPT_PathBCC = Func_Read_INI("REPORTES", "RPT_Cambio", sFile$)
    gsRPT_PathBFW = Func_Read_INI("REPORTES", "RPT_Futuro", sFile$)
    gsRPT_PathBTR = Func_Read_INI("REPORTES", "RPT_Trader", sFile$)
    gsRPT_PathPCS = Func_Read_INI("REPORTES", "RPT_Swap", sFile$)
    gsRPT_PathBEX = Func_Read_INI("REPORTES", "RPT_Invex", sFile$)
    
    gsBac_Office = Trim(Func_Read_INI("PROGRAM_EXTER", "RUTA_OFFICE", sFile$))
    
    giPapeletaEnPantalla = Val(Func_Read_INI("REPORTES", "PAP_Lineas", sFile$))

    gsc_PuntoDecim = Mid$(Format(0#, "0.0"), 2, 1)
   
    sSeparadorFecha$ = "/"
   
   If gsc_PuntoDecim = "." Then
      gsc_SeparadorMiles = ","
   Else
      gsc_SeparadorMiles = "."
   End If
   
   gsc_FechaDMA = "DD" + sSeparadorFecha$ + "MM" + sSeparadorFecha$ + "YYYY"
   gsc_FechaMDA = "MM" + sSeparadorFecha$ + "DD" + sSeparadorFecha$ + "YYYY"
   gsc_FechaAMD = "YYYY" + sSeparadorFecha$ + "MM" + sSeparadorFecha$ + "DD"
   gsc_FechaSeparador = sSeparadorFecha$
   
   If gsc_PuntoDecim = gsc_SeparadorMiles Then
      MsgBox "El símbolo utilizado en el separador de miles" & vbCrLf & "y del punto decimal son iguales.", vbOKOnly + vbCritical, TITSISTEMA
      BacInit = False
      Exit Function
   End If
   
   If sSeparadorFecha$ <> gsc_FechaSeparador And sSeparadorFecha$ <> "-" Then
      MsgBox "El simbolo utilizado en la separación " & vbCrLf & "de la fecha no corresponde.", vbOKOnly + vbCritical, TITSISTEMA
      BacInit = False
      Exit Function
   End If
   
   If gsODBC = "" Then
      BacInit = False
      MsgBox "Coneccion ODBC No esta definida para conectarse con Base de Datos", vbCritical + vbOKOnly, TITSISTEMA
      Exit Function
   End If
   
   '--------------------------------------------------
   'Creación automatica de ODBC
   Dim Attribs As String
   Dim MyWorkspace As Workspace
   Set MyWorkspace = Workspaces(0)

   Attribs = "Description=Control Finannciero" & Chr$(13)
   Attribs = Attribs & "Server=" & gsSQL_Server & Chr$(13)
   Attribs = Attribs & "Database=" & gsSQL_Database

   DBEngine.RegisterDatabase gsODBC, "SQL Server", True, Attribs

   MyWorkspace.Close
   'Fin
   
   '--------------------------------------------------
   gbBAC_Login = False
   
   giBAC_Entidad = 1
   
   
 
End Function



Function Valida_Configuracion_Regional() As Boolean

Valida_Configuracion_Regional = False

If CStr(Format(CDate("31/12/2000"), FeFecha)) <> Format("31/12/2000", FeFecha) Then
   MsgBox "Debe cambiar el formato de fecha como dd/mm/aaaa antes de ejecutar el sistema.", vbCritical, "Mensaje"
   Exit Function
End If

Valida_Configuracion_Regional = True

End Function

Sub PROC_POSICIONA_TEXTO(Grilla As Control, Texto As Control)
    
   If Not TypeOf Texto Is ComboBox Then
      Texto.Height = 270
   End If
   Texto.top = Grilla.CellTop + Grilla.top + 20
   Texto.Left = Grilla.CellLeft + Grilla.Left + 20
   Texto.Width = Grilla.CellWidth - 20

Dim n As Integer
Dim i As Integer
Dim F As Integer

End Sub

Sub CellPintaCelda(Grilla As Control)
    Grilla.CellForeColor = &HC00000
    Grilla.CellBackColor = &H8000000F
End Sub

Sub PintaCelda(Grilla As Control)
    Grilla.CellForeColor = 16777215
    Grilla.CellBackColor = &H80000002
End Sub
Sub CalculoN1(txttotasi As Control, LabTotOcu As Control, LabTotDis As Control, LabTotExe As Control)
On Error GoTo ErrorF:
'    txttotasi = CDbl(txttotasi)
'    LabTotOcu = CDbl(LabTotOcu)
'    LabTotDis = CDbl(LabTotDis)
'    LabTotExe = CDbl(LabTotExe)
    
    txttotasi = CDbl(Format(txttotasi, FDecimal))
    LabTotOcu = CDbl(Format(LabTotOcu, FDecimal))
    LabTotDis = CDbl(LabTotDis)
    LabTotExe = CDbl(Format(LabTotExe, FDecimal))
        
    LabTotOcu = Format(gsc_Parametros.gsBac_TotalOcupado, FDecimal)
    If CDbl(txttotasi) >= CDbl(LabTotOcu) Then
        LabTotDis = CDbl(txttotasi) - CDbl(LabTotOcu)
        LabTotExe = 0
    Else
        LabTotDis.Caption = 0
        LabTotExe.Caption = CDbl(LabTotOcu) - CDbl(txttotasi)
    End If

'    txttotasi = txttotasi
'    LabTotOcu = LabTotOcu
'    LabTotDis = LabTotDis
'    LabTotExe = LabTotExe
    
    txttotasi = Format(txttotasi, FDecimal)
    LabTotOcu = Format(LabTotOcu, FDecimal)
    LabTotDis = Format(LabTotDis, FDecimal)
    LabTotExe = Format(LabTotExe, FDecimal)


ErrorF:
End Sub

'Sub FormatoNumeroSCalculoN1(txttotasi As Control, LabTotOcu As Control, LabTotDis As Control, LabTotExe As Control)
'    txttotasi.Text = BacCtrlTransMonto(txttotasi.Text)
'    LabTotOcu.Caption = CDbl(LabTotOcu)
'    LabTotDis.Caption = CDbl(LabTotDis)
'    LabTotExe.Caption = CDbl(LabTotExe)
'End Sub                                     'Caro

Sub CambioColor(CambioColor As Control, VerdaderoFalso As Boolean)
    If VerdaderoFalso = False Then
        
        CambioColor.BackColor = ColorBlanco
        CambioColor.ForeColor = ColorAzul
        'BacInvExterior.SelColor = ColorAzul
        'CambioColor.SelColor = ColorAzul
    Else
        CambioColor.BackColor = ColorAzul
        CambioColor.ForeColor = ColorBlanco
        'CambioColor.SelColor = ColorCeleste
    End If
End Sub

Sub PROC_CARGARGRILLA(Grid As MSFlexGrid, AltoRow As Integer, AltoRowFlex As Integer, Anchos As Variant, Titulos1 As Variant, Optional nRow As Integer, Optional Titulos2 As Variant, Optional NcolFlex As Integer)

   Dim i%
   Dim NrowFlex As Integer
   Dim nCol As Integer
   With Grid
      NrowFlex = 1
      nCol = UBound(Titulos1) + 1
      If Not IsMissing(Titulos2) Then
         NrowFlex = NrowFlex + 1
      End If

      If nRow = 0 Then
         nRow = NrowFlex + 1
      End If
      .RowHeightMin = 315
      .Rows = nRow
      .Cols = nCol
      .FixedCols = NcolFlex
      .FixedRows = NrowFlex
      .BackColor = ColorGris
      .BackColorFixed = ColorVerde
      .BackColorBkg = ColorGris
      .BackColorSel = ColorAzul
      .ForeColor = ColorAzul
      .ForeColorFixed = ColorBlanco
      .ForeColorSel = ColorBlanco
      .GridColor = ColorGris
      .GridColorFixed = ColorBlanco
      .Gridlines = flexGridInset
      .GridLinesFixed = flexGridNone
      .FocusRect = flexFocusNone
      .GridColor = ColorBlanco
      For i% = 0 To .Rows - 1
          If i% <= NrowFlex - 1 Then
             .RowHeight(i%) = AltoRowFlex
          Else
             .RowHeight(i%) = AltoRow
          End If
      Next i%
      For i% = NcolFlex To nCol - 1
         .Row = 0
         .Col = i%
         .CellFontBold = True
         .ColWidth(i%) = Anchos(i%)
         .TextMatrix(0, i%) = Titulos1(i%)
         If NrowFlex > 1 Then
            .Row = 1
            .CellFontBold = True
            .TextMatrix(1, i%) = Titulos2(i%)
         End If
      Next i%
   End With

End Sub

Sub GRABA_LOG_AUDITORIA(Optional entidad As String, Optional Fechaproc As String, Optional Terminal As String _
                         , Optional Usuario As String, Optional Sistema As String, Optional codigoMenu As String _
                         , Optional Evento As String, Optional Detalletransac As String _
                         , Optional TablaInvolucrada As String, Optional ValorAntiguo As String _
                         , Optional ValorNuevo As String)


Dim Tran As String

Tran = "Sp_Log_Auditoria " & "'" & entidad & "'" & "," & _
        "'" & Fechaproc & "'" & "," & "'" & gsBac_IP & "'" & "," & _
        "'" & Usuario & "'" & "," & "'" & Sistema & "'" & "," & _
        "'" & codigoMenu & "'" & "," & "'" & Evento & "'" & "," & _
        "'" & Detalletransac & "'" & "," & "'" & TablaInvolucrada & "'" & "," & _
        "'" & ValorAntiguo & "'" & "," & "'" & ValorNuevo & "'"

If Not Bac_Sql_Execute(Tran) Then
    MsgBox "Problemas al Grabar Log de Auditoria.", vbCritical, TITSISTEMA
End If

End Sub


Public Sub DetectarResolucion(MDIFormx As Object, Formx As Object)
   Dim ancho As Integer, alto As Integer
   ancho = GetDeviceCaps(Formx.hdc, 8)

   alto = GetDeviceCaps(Formx.hdc, 10)
   If ancho <> 800 And alto <> 600 Then
      MDIFormx.Picture = Formx.Picture
      Unload Formx
   End If
End Sub


Public Function BacFormatoMonto(nMonto As Variant, nDecimales As Integer) As String

    nMonto = Val(Str(nMonto))
   
   
    If gsc_PuntoDecim = "," Then
    
        Select Case nDecimales
            Case 0
                BacFormatoMonto = Format(nMonto, "#,##0")
            Case Else
                BacFormatoMonto = Format(nMonto, "#,##0." & String(nDecimales - 1, "#") & "0")
    
        End Select
    Else
        Select Case nDecimales
            Case 0
                BacFormatoMonto = Format(nMonto, "#.##0")
            Case Else
                BacFormatoMonto = Format(nMonto, "#.##0," & String(nDecimales - 1, "#") & "0")
    
        End Select
    
    End If
    
    
   
End Function


Public Function BacRuta(sCadena As String) As String

    Dim nCarac  As Integer
    Dim ccadena As String
    nCarac = Len(sCadena)
    ccadena = Mid(sCadena, nCarac, 1)
    If ccadena <> "\" Then
       BacRuta = sCadena + "\"
    Else
       BacRuta = sCadena
    End If

End Function

Public Function UsuarioConfirma(x As Long, Y As Long, Titulo As String, Solicitud As String, tiempoMinutos As Double)
    Dim Msg        As Form
    Set Msg = New MsgBoxTemporalizado
    Let Msg.Titulo = Titulo
    Let Msg.Solicitud = Solicitud
    Let Msg.CoorX = x
    Let Msg.CoorY = Y
    Let Msg.Temporalizador.Interval = tiempoMinutos * 60 * 1000 'Expresar en milisegundos
    Let Msg.CuentaRegresiva.Interval = tiempoMinutos * 60 * 1000 / 30  'Expresar en milisegundos
    Msg.Show vbModal
    UsuarioConfirma = Msg.Respuesta
End Function
