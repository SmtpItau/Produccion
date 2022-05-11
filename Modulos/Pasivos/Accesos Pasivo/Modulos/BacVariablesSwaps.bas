Attribute VB_Name = "BacVariablesSwaps"


' 1  Formas de Pago
' 2  Tipo de Mercado
' 3  Tipo de Custodia
' 4  Tipo de Cartera
' 5  Retiro
' 6  Comunas
' 7  Tipo de Cliente
' 8  Sector Economico
' 9  Monedas de Pacto
'10  Tipo de Emisor
'11  Base de Calculo
'12  Tipo de Amortizacion
'13  Tipo de operacion
'14  Estados de Registro
'15  Plazas
'16  Periodo
'*************de******************************************
Global Const MDTC_COMUNAS = 44
Global Const MDTC_TIPOCLIENTE = 72
Global Const MDTC_SECECONOMICO = 41
Global Const MDTC_CIUDAD = 3
'Global Const MDTC_REGION = 32
Global Const MDTC_ENTIDAD = 234
Global Const MDTC_MERCADO = 202
Global Const MDTC_GRUPO = 233
'Global Const MDTC_Pais = 180
Global Const MDTC_CALIDADJURIDICA = 39 'antes 36
Global Const MDTC_RGBANCO = 40
Global Const MDTC_RELACION = 32
Global Const MDTC_CATEGORIADEUDOR = 42
Global Const MDTC_COMINSTITUCIONAL = 41
Global Const MDTC_CLASIFICACION = 103
Global Const MDTC_ACTIVIDADECONOMICA = 13

'Global Const MDCL_TIPOCLIENTE = 7
'Global Const MDCL_SECECONOMICO = 8
'Global Const MDCL_COMUNAS = 6

'Constantes Para La Tabla de Emisores
'------------------------------------
Global Const MDEM_TIPOEMISOR = 10

'Constantes Para la Tabla de Monedas
'-----------------------------------
Global Const MDMN_PERIODO = 216
Global Const MDMN_BASE = 211
Global Const MDMN_TIPOMONEDA = 217

'Constantes Para la Tabla de Feriados
'------------------------------------
Global Const MDFE_PLAZA = 215

'Constantes para la tabla de instrumentos
'--------------------------------------------
Global Const MDIN_BASES = 211
Global Const MDIN_TIPOFECHA = 220
Global Const MDIN_TIPO = 219
Global Const MDIN_EMISION = 221

'Constantes Para la Tabla de Series
'--------------------------------------------
Global Const MDSE_TIPOAMORTIZACION = 212
Global Const MDSE_TIPOPERIODO = 216

Global Xentidad                     As String
Global xRut                         As Long
Global xCodigo                      As Long
Global xFecha                       As Date
'Constantes para Form. de Plan de Cuentas

Global Const MDPC_TIPO = 23
Global Glob_Archivo_Ayuda           As String
Global Glob_Filtro_Ayuda            As String
Global Glob_Registro_Ayuda          As String
Global Fecha_Expira                 As Date
Global DIAS_PACTO_PAPEL_NO_CENTRAL  As Integer
Global MONTO_PATRIMONIO_EFECTIVO    As Double

'***************hasta****************************************

'Constantes Para La Tabla de Emisores
'------------------------------------
'Global Const MDEM_TIPOEMISOR = 10

'Constantes Para la Tabla de Monedas
'-----------------------------------
Global Const MDTB_PERIODO = 16
Global Const MDTB_BASE = 11
Global Const MDTB_TIPOPER = 50
Global Const MDTB_TIPVAL = 51
Global Const MDTB_TIPOMONEDA = 52
Global Const MDTB_PAIS = 53

'Constantes Para la Tabla de Feriados
'------------------------------------
'Global Const MDFE_PLAZA = 15

'Constantes para la tabla de instrumentos
'--------------------------------------------
'Global Const MDIN_BASES = 11
'Global Const MDIN_TIPOFECHA = 20
'Global Const MDIN_TIPO = 19
'Global Const MDIN_EMISION = 21


'Constantes Para la Tabla de Series
'--------------------------------------------
'Global Const MDSE_TIPOAMORTIZACION = 12
'Global Const MDSE_TIPOPERIODO = 16

'Constantes para Form. de Plan de Cuentas
'Global Const MDPC_TIPO = 23

'Constantes Para la Tabla de Clientes
'-------------------------------------
' 'Global Const MDTC_COMUNAS = 6
' ''Global Const MDTC_TIPOCLIENTE = 7
' Global Const MDTC_SECECONOMICO = 8
' 'Global Const MDTC_TIPOOPERACION = 13
' Global Const MDTC_CIUDAD = 31
' Global Const MDTC_REGION = 32
' Global Const MDTC_ENTIDAD = 34
' 'Global Const MDTC_MERCADO = 2
' Global Const MDTC_GRUPO = 33
' 'Global Const MDTC_Pais = 35
' 'Global Const MDTC_CALIDADJURIDICA = 36
' Global Const MDTC_PRODUCTO = 50
 Global Const MDTC_TIPOSWAP = 50      'ojo          '-- NEW cog
' Global Const MDTC_TIPOFONO = 55
' Global Const MDTC_CODIGOACTIVIDAD = 56
' Global Const MDTC_CODIGOSCUENTA = 59
 Global Const MDTC_CUENTASSBFI = 57
' Global Const MDTC_PRODASOC = 61
' Global Const MDTC_TIPOSALDO = 58
' Global Const MDTC_TIPORELACION = 59

'Constantes Para la Tabla de Monedas
'-----------------------------------
' Global Const MDMN_PERIODO = 16
' Global Const MDMN_BASE = 11
' Global Const MDMN_TIPOMONEDA = 17

'Constantes Para la Tabla de Monedas por Producto
'------------------------------------------------
 Global Const MDMP_TIPOPER = 50 '---- PENDIENTE eliminar

'Constantes para la Tabla de Tasas
'--------------------------------------------
 Global Const MDTC_TASAS = 240  'Valores Tasas por Monedas
 Global Const MDTC_MTM = 40    'Tasas MTM (zcr)
 Global Const MDTC_PERIODO = 44  'Periodo Tasas


Global Const MDTC_SISTEMA = 49
Global Const MDTC_PRODUCTOFWD = 50
Global Const MDTC_PRODUCTOSWP = 51


'VERSION
'------------------------------------------------
Global gsPARAMS_Version       As String

Global Msj       As String
Global Sistema   As String

Global cTipoSwap As String
Global Entidad   As String

'Global xentidad As String

'Variable donde se almacenara de que tabla salieron los datos
'se traspasa de la pantalla de filtro
'Global swModTipoOpe As Integer
'Global swModNumOpe  As Integer
'Global swOperSwap   As String
'Global swConeccion  As String

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
'Global giSQL_ConnectionMode   As Integer
'Global gsSQL_Database         As String
'Global gsSQL_Server           As String
'Global gsSQL_Login            As String
'Global gsSQL_Password         As String
'Global giSQL_LoginTimeOut     As String
'Global giSQL_QueryTimeOut     As String


'ODBC
Global gsODBC                 As String

'MDB
'Global gsMDB_Path             As String
'Global gsMDB_Database         As String
'Global DB                     As Database
'Global WS                     As Workspace

'RPT
'Global gsRPT_Path             As String
'Global gsRPT_Database         As String

'Misceleanos
'Global gsRUN_Proceso          As String
'Global gsFileINI              As String

'Login al sistema.-
'Global gsBAC_Login            As Boolean
'Global gsBAC_User             As String
Global gsBAC_Term             As String
Global gsBAC_Pass             As String

' Variables Generales de Sistema
Global gsbac_fecp             As Date
Global gsBAC_Clien            As String
Global gsBAC_Rut              As Double
Global gsBAC_ValmonUF         As String
Global gsBAC_DolarObs         As String
Global gsBAC_Valmonlocal      As String
Global gsBAC_Plaza            As String
Global gsBAC_acswpd           As String
Global gsBAC_acswcart         As String
Global gsBac_Tipo_Usuario     As String

Global sSeparadorFecha$

'Variable que me indica si presiono el boton Aceptar de la pantalla de Ayuda
Global giAceptar%
Global gsDescripcion$


'Constantes API de Windows.-

Global Const WM_USER = &H400
Global Const LB_SELECTSTRING = (WM_USER + 13)
Global Const CB_FINDSTRINGEXACT = (WM_USER + 24)
Global Const LB_FINDSTRING = (WM_USER + 16)

'Parametros globales
Global Const OP_SWPA_TASAS = 1
Global Const OP_SWAP_MONEDAS = 2
Global Const OP_FRA = 3

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
'Public gsc_Parametros      As New clsGeneral
'Public gsc_Operacion       As New clsOperacion
Public gsc_PuntoDecim      As String
Public gsc_SeparadorMiles  As String
Public gsc_FechaDMA        As String
Public gsc_FechaMDA        As String
Public gsc_FechaAMD        As String
Public gsc_FechaSeparador  As String

'DMV
Public oFrmOld   As Object
Public Const GWL_STYLE = (-16)


'Proyección de la UF.
Public gsc_ValorUFProy     As Double
Public gsc_FecVcto         As String

'Variables de Acceso
'Global Login_Usuario As String
'Global Comando$
'Global Tipo_Usuario  As String



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
'insertado
Global gsBac_Version    As String
'Global gsBAC_Fecp    As Date


Global Prn_Tipo_Impresion       As String

' Usuario Sistema
Global Filtro_cartera           As Integer

'conexion a sql server
Global giSQL_Listados           As String
Global gSQL_interfas            As String
Global GbSql                    As String
Global GbDatos()
Global Sql                      As String
Global Datos()
Global Datos_Recibidos()
Global Datos_Recibidos_1()
Global Datos_Recibidos_2()
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

Global nombre                   As String
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
'Global Glob_Archivo_Ayuda       As String
'Global Glob_Registro_Ayuda      As String
'Global Glob_Filtro_Ayuda        As String


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

'INSERTADO
Type BacValorizaInput
    ModCal    As Integer
    FecCal    As String
    codigo    As Long
    Mascara   As String
    MonEmi    As Integer
    fecemi    As String
    FecVen    As String
    TasEmi    As Double
    BasEmi    As Integer
    TasEst    As Long
    Nominal   As Double
    tir       As Double
    Pvp       As Double
    Mt        As Double
End Type
'CONSTANTES DE COLOR
Global Const BlancoBajo = &HC0C0C0
Global Const blanco = &HE0E0E0
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

