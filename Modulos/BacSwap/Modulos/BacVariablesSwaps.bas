Attribute VB_Name = "BacVariablesSwaps"
Option Explicit

Global Msj          As String
Global Sistema      As String
Global Const TITSISTEMA = "BACSWAP"
Global cTipoSwap    As String
Global Entidad      As String
Global Const FEFecha = "yyyymmdd"

'JBH, 16-12-2009 Variable para operaciones Intramesas
Global ope_intramesa As Boolean
'JBH, fin

'PRD-4858, jbh, 15-02-2010 variables para uso del Threshold en operaciones
Global Thr_AplicaThreshold    As Boolean
Global Thr_GrabaThreshold     As Boolean
Global Thr_dPlazoOperacion    As Integer
Global Thr_CodProducto        As Integer
Global Thr_NumeroOperacion    As Double
Global Thr_RutCliente         As String
Global Thr_CodCliente         As Integer
Global Thr_ValorPropuesto     As Double
Global Thr_ValorAplicado      As Double
Global Thr_MostrarThreshold   As Boolean
Global Thr_OptAplicaThreshold As Boolean
Global Thr_MensajeLineas      As String
Global Thr_Cotizacion         As Boolean
'fin PRD-4858

'VERSION
Global gsPARAMS_Version       As String


'Cambios PRD 21657
Global gstrFechaOrigen       As String
Global gstrFechaFinal        As String
Global gstrModuloOrigen      As String

Global gstrFechaFijacion     As String
Global glngCodTasa           As Long
Global glngFeriadoCL         As Long
Global glngFeriadoUSA        As Long
Global glngFeriadoENG        As Long
Global glngCodMoneda         As Long
Global gdblValorTasaFlujo    As Double
Global gdblFechaTasaFlujo    As Date
Global strDigitaSN           As String 'Incorporada el día 26-03-2015
Global I_RefUSDCLP           As Integer
Global I_RefMEXUSD           As Integer
Global I_FecUSDCLP           As Date
Global I_FecMEXUSD           As Date
Global D_RefUSDCLP           As Integer
Global D_RefMEXUSD           As Integer
Global D_FecUSDCLP           As Date
Global D_FecMEXUSD           As Date
Global Referencias           As Collection

Global RefMer()             As Variant
Global Plaza                As String
Global Tasa                 As Double
Global TC                   As Double
Global filtroini            As String
Global filtrofin            As String


' fin CAMBIOS PRD21657


'Constantes Para la Tabla de Clientes
'-------------------------------------
 'Global Const MDTC_COMUNAS = 6
 'Global Const MDTC_TIPOCLIENTE = 7
 'Global Const MDTC_SECECONOMICO = 8
 'Global Const MDTC_TIPOOPERACION = 13
 'Global Const MDTC_CIUDAD = 31
 'Global Const MDTC_REGION = 32
 'Global Const MDTC_ENTIDAD = 34
 'Global Const MDTC_MERCADO = 2
 'Global Const MDTC_GRUPO = 33
 'Global Const MDTC_PAIS = 35
 'Global Const MDTC_CALIDADJURIDICA = 36
 Global Const MDTC_PRODUCTO = 1050
 Global Const MDTC_TIPOSWAP = 1050                '-- NEW cog
 'Global Const MDTC_TIPOFONO = 55
 'Global Const MDTC_CODIGOACTIVIDAD = 56
 'Global Const MDTC_CODIGOSCUENTA = 59
 'Global Const MDTC_CUENTASSBFI = 57
 'Global Const MDTC_PRODASOC = 61
 'Global Const MDTC_TIPOSALDO = 58
 'Global Const MDTC_TIPORELACION = 59

'Constantes Para la Tabla de Monedas
'-----------------------------------
 'Global Const MDMN_PERIODO = 16
 'Global Const MDMN_BASE = 11
 'Global Const MDMN_TIPOMONEDA = 17

'Constantes Para la Tabla de Monedas por Producto
'------------------------------------------------
 Global Const MDMP_TIPOPER = 1050 '---- PENDIENTE eliminar


'Constantes para la Tabla de Tasas
'--------------------------------------------
' Global Const MDTC_TASAS = 1042  'Valores Tasas por Monedas
' Global Const MDTC_MTM = 40    'Tasas MTM (zcr)
' Global Const MDTC_PERIODO = 240  'Periodo Tasas
 Global Const MDTC_TASAS = 1042  'Valores Tasas por Monedas
 Global Const MDTC_MTM = 240    'Tasas MTM (zcr)
 Global Const MDTC_PERIODO = 1044  'Periodo Tasas


'Constantes para tasas/monedas
'----------------------------------
Global Const BASE_CALCULO = 211


'Variable donde se almacenara de que tabla salieron los datos
'se traspasa de la pantalla de filtro
Global swModTipoOpe As Integer
Global swModNumOpe  As Integer
Global swOperSwap   As String
Global swConeccion  As String

' Tipo de Operaciones
Global Const H_COMPRA = "C"
Global Const H_VENTA = "V"
Global Const H_PAGAMOS = "C"
Global Const H_RECIBIMOS = "V"

Global Const gcMaximoVentanas = 10

'Referencia a Botones.-
Global Const iGlbBotonGrabar% = 1
Global Const iGlbBotonMValr% = 2
Global Const iGlbBotonSelec% = 3
Global Const iGlbBotonNETrader% = 4
Global Const iGlbBotonAsign% = 5
Global Const iGlbBotonFloating% = 6

'SQL
Global giSQL_ConnectionMode   As Integer
Global gsSQL_Database         As String
Global gsSQL_Server           As String
Global gsSQL_Login            As String
Global gsSQL_Password         As String
Global giSQL_LoginTimeOut     As String
Global giSQL_QueryTimeOut     As String
Global giSQL_DatabaseCommon   As String
Global gsBac_LineasDb         As String

'ODBC
Global gsODBC                 As String

'MDB
Global gsMDB_Path             As String
Global gsMDB_Database         As String
'Global DB                     As Database'
'Global WS                     As Workspace

'RPT
Global gsRPT_Path             As String
'Global gsRPT_Database         As String

'CONTRATOS
Global gsDOC_Path As String

'Misceleanos
Global gsRUN_Proceso          As String
Global sFile                  As String

'Login al sistema.-
Global gsBAC_Login            As Boolean
Global gsBAC_User             As String
Global gsusuario              As String 'PROD-10967 Unifmormizar el BacCalculoREC
Global gsBAC_Term             As String
Global gsBAC_Pass             As String
Global gsBAC_IP               As String

' Variables Generales de Sistema
Global gsBAC_Version          As String
Global gsBAC_Fecp             As String
Global gsBAC_FecAnt           As String 'PROD-10967
Global gsBAC_FecConFin        As String 'PROD-10967

Global gsBAC_Clien            As String
Global gsBAC_Rut              As Double
Global gsBAC_Codigo           As String
Global gsBAC_ValmonUF         As String
Global gsBAC_DolarObs         As String
Global gsBAC_Valmonlocal      As String
Global gsBAC_Plaza            As String
Global gsBAC_acswpd           As String
Global gsBAC_acswcart         As String
Global gsBac_Tipo_Usuario     As String
Global gsBac_Path_Interfaces  As String
Global gsBac_Path_Contratos   As String 'Copia Contratos Clientes
Global gsBac_DIRIBS           As String

Global gsBac_DIREXEL          As String
Global gsBac_Office           As String

Global gsBac_Timer            As Integer ' Timer
Global gsBac_Timer_Adicional As Long ' Timer


'Variable para interfaces Contables
Global gsBac_DIRCONTA         As String


Global sSeparadorFecha$

'Variable que me indica si presiono el boton Aceptar de la pantalla de Ayuda
Global giAceptar%

'Variables usadas en la pantalla de Ayuda
Global gsCodigo         As String
Global gsDigito         As String
Global gsDescripcion    As String
Global gsFax            As String
Global gsFono           As String
Global gsSerie          As String
Global gsNemo           As String
Global gsGlosa          As String
Global gsRedondeo       As String
Global gsValor          As String
Global gsNombre         As String
Global gsCodCli         As Double
Global gsnotaria        As String
Global gsfecha_escritura As String



' FTP
Global gsNom_maq As String
Global gsUser_maq As String
Global gsPass_maq As String
Global gsPath_maq As String

'Funciones API de Windows.-
Declare Function GetPrivateProfileString Lib "Kernel" (ByVal S$, ByVal e$, ByVal D$, ByVal r$, ByVal n%, ByVal A$) As Integer
Declare Function IsIconic Lib "User" (ByVal hWnd As Integer) As Integer
Declare Function SendMessageByNum Lib "User" Alias "SendMessage" (ByVal hWnd%, ByVal wMsg%, ByVal wParam%, ByVal lParam&) As Long

'Constantes API de Windows.-

Global Const WM_USER = &H400
Global Const LB_SELECTSTRING = (WM_USER + 13)
Global Const CB_FINDSTRINGEXACT = (WM_USER + 24)
Global Const LB_FINDSTRING = (WM_USER + 16)

'Parametros globales
Global Const OP_SWAP_TASAS = 1   'ST --> Swap de tasas
Global Const OP_SWAP_MONEDAS = 2 'SM --> Swap de Monedas
Global Const OP_FRA = 3          'FR --> Forward Rate Agregement
Global Const OP_SWAP_PROMCAM = 4 'SP --> Swap Promedio Camara


Global Const GFS_CURCELL = &H1

'Variables de Control de Procesos
Global Const PAR_INICIO_DIA = 1
Global Const PAR_CIERRE_MESA = 2
Global Const PAR_LIBOR = 3
Global Const PAR_PARIDAD = 4
Global Const PAR_TASAMTM = 5
Global Const PAR_TASAS = 6
Global Const PAR_FINDIA = 7

'Clase
Public gsc_Parametros      As New clsGeneral
'Public gsc_Operacion       As New clsOperacion
Public gsc_PuntoDecim      As String
Public gsc_SeparadorMiles  As String
Public gsc_FechaDMA        As String
Public gsc_FechaMDA        As String
Public gsc_FechaAMD        As String
Public gsc_FechaSeparador  As String

' PROD-19111 ini cmd ini
Public gsc_Periodo As Boolean
' PROD-19111 fin


'DMV
Public oFrmOld   As Object
Public Const GWL_STYLE = (-16)

Public Declare Function SetWindowLong Lib "User" (ByVal hWnd As Integer, ByVal nIndex As Integer, ByVal dwNewLong As Long) As Long
Public Declare Function GetWindowLong Lib "User" (ByVal hWnd As Integer, ByVal nIndex As Integer) As Long

'Proyección de la UF.
Public gsc_ValorUFProy     As Double
Public gsc_FecVcto         As String

'Variables de Acceso
Global Login_Usuario As String
Global Comando$
Global Tipo_Usuario  As String

'Definición de Impresoras
Global gsBac_IMPWIN     As String 'Por defecto de Windows
Global gsBac_QUEDEF     As String 'Para Papeletas
Global gsBac_IMPDEF     As String 'Para Papeletas



'***********************<<< Contabilidad >>>************************
'*** las puse yo
Global Const G_COLOR_AZUL_FUERTE = &HC00000
Global Const G_COLOR_AZUL = &H800000
Global Const G_COLOR_VERDE = &HC0C000
Global Const G_COLOR_PLOMO = &H808080
Global Const G_COLOR_BLANCO = &HFFFFFF
Global Const G_COLOR_NEGRO = &H80000008
Global Const G_COLOR_CLARO = &HC0FFFF
Global Const G_COLOR_ROJO = &H80&
Global Const G_COLOR_PLOMO_CLARO = &HC0C0C0
Public r%

'-----------------------------------

Global Prn_Tipo_Impresion       As String

' Usuario Sistema
Global Filtro_cartera           As Integer

'conexion a sql server
Global giSQL_Listados           As String
Global gSQL_interfas            As String
Global GbSql                    As String
Global GbDatos()
Global SQL                      As String
Global Datos()
Global gsLogo_Corredora         As Variant
Global gsTapiz                  As Variant
Global gbBac_Login              As Boolean

'Conexiones de Impresión
Global Prn_Orientacion          As Integer
Global Prn_Path                 As String  'path de impresión
Global Prn_Archivo              As String  'archivo de impresión
Global Prn_Fd                   As Integer 'area del archivo
Global Prn_Ancho                As Integer 'Ancho del Listado
Global Prn_Area                 As Integer 'nro de area del archivo
Global Prn_Lin                  As String  'Linea a grabar en archivo de impresión
Global Prn_NroLin               As Integer 'nro de linea de la impresion
Global Prn_MaxLin               As Integer 'nro de linea de la impresion
Global Prn_ContPag              As Integer 'nro de paginas del informe
Global Prn_Titulo               As String  'titulo del listado
Global Prn_hora                 As String  'hora del listado
Global Prn_fecha                As String  'fecha del listado
Global Prn_Impresora            As String  'Impresora Determinada
Global Prn_Margen_izq           As Integer
Global Prn_Tipo_papel           As String
Global Prn_Matriz_de_Punto      As Integer
Global Prn_Size_Max             As Integer
Global Prn_Titulo_Archivo       As String  'Nombre del Archivo a Imprimir
Global Prn_Numero_Linea_Titulo  As String  'Numero de Lineas que Ocupa el Titulo
Global Prn_FontSize             As Single  'Tamaño de la Letra
Global Formato_Papel            As Integer

Global Nombre                   As String
Global Nombre_Paso              As String
Global SumValOperacion          As Double
Global SumMonPacto              As Double

'conexión al sistema
Public gbUser_Operador          As String
Public gbPass_Operador          As String
Public gbCapt_Operador          As String * 7

Public gbCampo_Ayuda            As String
Public gbFECHA_SISTEMA          As String
Global gbRegSVS                 As String * 4
Global Tipo_Papeletas           As Integer
Global Glob_Archivo_ayuda       As String
Global Glob_Registro_Ayuda      As String
Global Glob_Filtro_Ayuda        As String


'constantes
Global Const PTO_DECIMAL = "."
Global Const COD_DECIMAL = 46
Global Const TEC_PASADA = 13

Global Cont                     As Long         'Variable de impresion

Type Est_Perfil_Fijo
  Correlativo As String
  campo As String
  tipo_perfil As String
  Tipo_cuenta As String
  Numero_cuenta As String
  Nombre_cuenta As String
End Type

Type Est_Perfil_Variable
  Correlativo As String
  CCosto As String
  Numero_cuenta As String
  Nombre_cuenta As String
End Type

'CONSTANTES DE COLOR
Global Const BlancoBajo = &HC0C0C0
Global Const Blanco = &HE0E0E0
Global Const BlancoAlto = &HFFFFFF
Global Const Negro = &H0&
Global Const AzulBajo = &H800000
Global Const Azul = &HC00000
Global Const AzulAlto = &HFF0000
Global Const VerdeBajo = &H8000&
Global Const Verde = &HC000&
Global Const VerdeAlto = &HFF00&
Global Const RojoBajo = &H80&
Global Const Rojo = &HC0&
Global Const RojoAlto = &HFF&
Global Const AmarilloBajo = &H8080&
Global Const Amarillo = &HC0C0&
Global Const AmarilloAlto = &HFFFF&
Global Const Celeste = &HC0C000
Global Const Morado = &H800080
Global Const Rosado = &H8080FF


Global Logo_Path As String
Global UserName As String
Global ctrlArray()

Global Fecha_Expira As Date

Global MISQL As New BTPADODB.CADODB

Global ValorA, ValorN As String


'Lineas
Global gsBac_Lineas As String

'AS400
    Global gsSQL_ServerAS400      As String
    
'Public miSQLAS400 As New BTPADOAS400.CADOAS400

'****'Login al sistema As/400 *****************
Global gsBac_as400_biblioteca   As String
Global gsBac_as400_Password     As String
Global gsBac_as400_usuario      As String
'*********************************************

Public SwUnload       As Boolean


'Constantes para llenar combos
'********************************************
Global Const GLB_CARTERA = "204"
Global Const GLB_CATEG = "245"
Global Const GLB_CARTERA_NORMATIVA = "1111"
Global Const GLB_LIBRO = "1552"
Global Const GLB_AREA_RESPONSABLE = "1553"
Global Const GLB_SUB_CARTERA_NORMATIVA = "1554"
'Global Const GLB_ENLACE_CARTERA_SUBCARTERA = "1556"

Global Const GLB_ID_SISTEMA = "PCS"

Global Const Tipo_ProductoST = "ST"
Global Const Tipo_ProductoSM = "SM"
Global Const Tipo_ProductoSPC = "SPC"

'********************************************

Global oFormulario As Object
Global GLB_bCancelar As Boolean

Global cTipoOperacion$

Global cOperSwap           As String
Global nNumoper            As Integer
Global OperSwap            As String
Global cModalidad          As String
Global nPaisOrigen         As Integer
Global DesgloseAmort       As String
Global Operacion As String

Global cOperSwapST         As String
Global nNumoperST          As Integer
Global nPaisOrigenST       As Integer
Global DesgloseAmortST     As String
Global OperacionST         As String
Global GlbNumeroAnticipo    As Long


'CER 29/04/2008  - Req. Pantalla Ingreso Op. Swap
Global OptCargaExcel       As Long
Global BotCargaExcel       As Long

'Numero de Ticket de IntraMesa
Global nNumOpeTicket        As Long
Global nCantidadFlujos      As Long
Global gnCodCarteraOrigen    As Long
Global gnCodMesaOrigen       As Long
Global gnCodCarteraDestino   As Long
Global gnCodMesaDestino      As Long


' para igualar formatos
Global gsFormatoTasa        As String

'JBH, 22-12-2009
Public auxUser  As String
'fin JBH, 22-12-2009

Global EnviarCF As String   'PRD-9287

' --> PRD 12712
Global giAceptar_EarlyTermination           As Boolean
Global giMarca_EarlyTermination             As Integer
Global giPeriodicidad_EarlyTermination      As Integer
Global giFechaInicio_EarlyTermination       As Date

Global giMarcaInterNocIni As Boolean
Global giInterNocIni As Integer

Global giMarcaInterNocFin As Boolean
Global giInterNocFin As Integer
' --> Fin PRD 12712

'--+++CONTROL IDD, jcamposd variable global de marca de línea
Global MarcaAplicaLinea As Integer
'-----CONTROL IDD, jcamposd variable global de marca de línea
'+++ cvegasan 2017.08.08 Control Lineas IDD
Global gsBac_Url_WebService As String
Global gsBac_Url_WebMethod As String
'--- cvegasan 2017.08.08 Control Lineas IDD
