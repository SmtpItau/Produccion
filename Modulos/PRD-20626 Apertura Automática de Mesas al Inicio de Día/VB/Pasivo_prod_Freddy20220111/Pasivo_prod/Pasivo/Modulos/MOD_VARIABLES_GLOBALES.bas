Attribute VB_Name = "MOD_VARIABLES_GLOBALES"
Global GLB_Usuario_Bac           As String
Global GLB_Tipo_Usuario_Bac      As String
Global GLB_Login_Bac             As Boolean
Global GLB_Password_Bac          As String
Global GLB_Password              As String
Global GLB_Usuario               As String
Global GLB_Fecha_Expira          As Date
Global GLB_Fecha_Proceso         As Date
Global GLB_Fecha_FinMes          As Date
Global GLB_Cliente_Bac           As String
Global GLB_Fecha_Proxima         As Date
Global GLB_Rut_Cliente           As Double
Global GLB_Dig_Cliente           As String
Global GLB_Rut_Comision          As Double
Global GLB_Precio_Comision       As Double
Global GLB_IVA                   As Double
Global GLB_UF                    As Double
Global GLB_DO                    As Double
Global GLB_Rut_Cartera           As Double
Global GLB_Dv_Cartera            As String
Global GLB_Nombre_Cartera        As String
Global GLB_Fecha_Anterior        As Date
Global GLB_Tasa_Camara           As Double
Global GLB_Curvas_Bac            As String
Global GLB_Version_Sistema       As String
Global GLB_Formato_Numero        As String
Global GLB_Aceptar%
Global GLB_Confirmar%
Global cMiTag                    As String
Global GLB_cOptLocal             As String
Global cOpt                      As String
Global GLB_Formulario            As String
Global GLB_Frm                   As String
Global GLB_Inicio_Dia           As Integer
Global GLB_Fin_Dia              As Integer
Global GLB_Devengamiento        As Integer
Global GLB_Contabilidad         As Integer
Global GLB_Ruta_Int_Contable    As String
Global GLB_Ruta_Int_Descalce    As String
Global GLB_Tipo_llamado    As String

'DMV
Public oFrmOld   As Object
Public Const GWL_STYLE = (-16)


' Margenes
Global GLB_BacFrmPSV             As Form
'Global GLB_objControl            As New Margen
'Global GLB_objGrabar             As New BACMDL_BT_PASIVO.PASIVOS


' CONEXION SQL

Global GLB_SQL_ConnectionMode    As Integer
Global GLB_SQL_Database          As String
Global GLB_SQL_Server            As String
Global GLB_SQL_Login             As String
Global GLB_SQL_Password          As String
Global GLB_SQL_LoginTimeOut      As String
Global GLB_SQL_QueryTimeOut      As String
Global GLB_Terminal_Bac          As String
'Global GLB_Sistema               As String
Global GLB_Nombre_Computador     As String
Global GLB_Nombre_Uusario        As String
Global GLB_ODBC                  As String
Global GLB_CONECCION             As String
Global GLB_Ubicacion_Reporte     As String
Global GLB_Ubicacion_Documento   As String
Global GLB_Moneda_Local          As Integer
Global GLB_Dirin                 As String
Global GLB_Papeleta              As String
Global GLB_Punto_Decimal         As String
Global GLB_Servicio              As String
Global GLB_Lineas                As String
Global GLB_Conexion              As String
Global GLB_Login                 As Boolean

Global GLB_Opcion_Menu           As String
Global GLB_Envia()               As Variant
Global GLB_VerSql                As String


' CONEXION LLAMADO A SQL

Global GLB_Sql_Conexion As ADODB.Connection
Global GLB_Sql_Resultado As ADODB.Recordset
Global GLB_Sql_Consulta_S As String
Global GLB_Sql_Conexion_S As String


' DLL BAC-SISTEMAS

'Global objCentralizacion     As New CLS_Parametros


' VARIABLES GLOBALES CONSTANTES

Global Const GLB_Formato_Decimal = "#,##0.0000"
Global Const GLB_Formato_Dec_USD = "#,##0.00"
Global Const GLB_Formato_Entero = "#,##0"
Global Const GLB_FORMATO_FECHA_REGIONAL = "yyyymmdd"
Global GLB_Cantidad_Decimal As Integer

' TECLAS ACCESO RAPIDO

Global Const vbKeySalir = vbKeyEscape
Global Const vbKeyGrabar = vbKeyG
Global Const vbKeyBuscar = vbKeyB
Global Const vbKeyLimpiar = vbKeyL
Global Const vbKeyEliminar = vbKeyE
Global Const vbKeyFiltrar = vbKeyF
Global Const vbKeyAyuda = vbKeyF3
Global Const VbKeyProcesar = vbKeyP
Global Const VbKeyImprimir = vbKeyI
Global Const VbKeyAnular = vbKeyA
Global Const VbKeyNuevo = vbKeyL
Global Const VbKeyDetalle = vbKeyD
Global Const vbKeyVistaPrevia = vbKeyV
Global Const vbKeyDesMarca = vbKeyR
Global Const VbkeyAceptar = vbKeyF10
Global Const VbKeyRepartir = vbKeyR
Global Const VbKeyRefrescar = vbKeyF5
Global Const vbKeyGeneraInterfaz = vbKeyF12
Global Const vbKeyCalcular = vbKeyF12

Global Const vbKeyTabular = 0
Global Const vbKeyValorizar = vbKeyF7
Global Const vbKeyTotales = 0
Global Const vbKeyTraspaso = vbKeyT
Global Const vbKeyCortes = vbKeyF4
Global Const vbKeyCalzar = 0
Global Const vbKeyModificar = 0
Global Const vbKeyAnticipar = 0
Global Const vbKeyCargaInterfaz = 0
Global Const vbKeyCarga = 0
Global Const vbKeyFecha = 0


' CONSTANTES DE COLOR

Global Const GLB_Cafe = &H40&
Global Const GLB_Blanco = &HFFFFFF
Global Const GLB_Verde = &H808000
Global Const GLB_Gris = &H80000004
Global Const GLB_Azul = &HFF0000
Global Const GLB_Celeste = &HFFFF00
Global Const GLB_Plomo = &H808080
Global Const GLB_AzulOsc = &H800000
Global Const GLB_Rojo = &HC0&
Global Const GLB_Negro = &H80000012
Global Const GLB_Amarillo = &HC0FFFF
Global Const GLB_GrisOsc = &H808080
Global Const GLB_ColorPendiente = &H80000012
Global Const GLB_ColorRechazada = &HC0&


'Variables usadas en la pantalla de Ayuda
Global GLB_codigo            As String
Global GLB_Digito            As String
Global GLB_Descripcion       As String
Global GLB_Serie             As String
Global GLB_Generico          As String
Global GLB_rut               As String
Global GLB_valor             As String
Global GLB_fax               As String
Global GLB_nombre            As String
Global GLB_generic           As String
Global GLB_direcc            As String
Global GLB_ciudad            As String
Global GLB_Pais              As String
Global GLB_comuna            As String
Global GLB_region            As String
Global GLB_tipocliente       As String
Global GLB_Entidad           As String
Global GLB_calidadjuridica   As String
Global GLB_Grupo             As String
Global GLB_Mercado           As String
Global GLB_apoderado         As String
Global GLB_ctacte            As String
Global GLB_fono              As String
Global GLB_1Nombre           As String
Global GLB_2Nombre           As String
Global GLB_1Apellido         As String
Global GLB_2Apellido         As String
Global GLB_Ctausd            As String
Global GLB_Implic            As String
Global GLB_Aba               As String
Global GLB_Chips             As String
Global GLB_Swift             As String
Global GLB_glosa             As String
Global GLB_redondeo          As String
Global GLB_nemo              As String
Global GLB_Instrumento       As String
Global GLB_Oopcion_Tlb       As Integer
Global GLB_Titulo_Consulta   As String


Global Const GLB_nPais_Chile = 1
Global Const GLB_nPlaza_Stgo = 22
' variables de cambio ingreso cartera corfo

Global GLB_lc_tasa As String
Global GLB_lc_fecha_cuota As String
Global GLB_lc_cuota As String
Global GLB_lc_fecha_otor As String
Global GLB_lc_monto As String
Global GLB_lc_gracia As String
Global GLB_lc_moneda As String
Global GLB_lc_base As String
Global GLB_lc_periodo As String
Global GLB_lc_tipo_tasa As String
Global GLB_lc_spread As String
Global GLB_lc_fecha_vencim As String

'******************************
'Variables para los bonos
Global GLB_FecpCupon As Date
Global GLB_FecuCupon As Date

Global Const GLB_Sistema = "PSV"

Global gsIp_MaqCtbNeo              As String
Global gsUser_maqNeo               As String
Global gsPass_maqNeo               As String
Global gsPath_maqNeo               As String

Global GLB_Ruta_Int_C40    As String
Global GLB_Ruta_Int_P36   As String
Global GLB_Ruta_Int_Operaciones As String
Global GLB_Ruta_Int_Flujos As String
Global GLB_Ruta_Int_Balance As String
Global GLB_Ruta_Int_ClienteOperacion As String
