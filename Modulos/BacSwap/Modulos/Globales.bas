Attribute VB_Name = "Globales"
'Type Cuentas_E
'     Cuenta As String
'     cheque As String
'End Type
'
'Public Est_Cuentas() As Cuentas_E
'
'Type Bancos_E
'     Banco As String
'     Cuenta As String
'     ncuenta As String
'     Saldo As String
'End Type
'
'Public Est_Bancos() As Bancos_E

'-------------------------------------
'Conexion a Mdb
Global db                       As DataBase
Global RecSet                   As Recordset
Global gsMDB_Path               As String
Global gsRPT_Path               As String
Global gsNombreMDB_Path         As String
'Option Explicit

'-----------------------------------

Global Prn_Tipo_Impresion       As String

' Usuario Sistema
Global Login_Usuario            As String
Global Filtro_cartera           As Integer

'conexion a sql server
Global giSQL_ConnectionMode     As Integer
Global gsSQL_DataBase           As String
Global gsSQL_Server             As String
Global gsSQL_Login              As String
Global gsSQL_Password           As String
Global giSQL_LoginTimeOut       As Long
Global giSQL_QueryTimeOut       As Long
Global giSQL_Listados           As String
Global gSQL_interfas            As String
Global GbSql                    As String
Global GbDatos()
Global sql                      As String
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

'Tipo de Datos de entrada para el valorizador
Type BacValorizaInput
    ModCal                      As Integer
    FecCal                      As String
    Codigo                      As Long
    mascara                     As String
    MonEmi                      As Integer
    fecemi                      As String
    FecVen                      As String
    TasEmi                      As Double
    BasEmi                      As Integer
    TasEst                      As Long
    Nominal                     As Double
    Tir                         As Double
    Pvp                         As Double
    Mt                          As Double
End Type

''Tipo de Datos de Salida para el valorizador
Type BacValorizaOutput
    Nominal                     As Double
    Tir                         As Double
    Pvp                         As Double
    Mt                          As Double
    MtUM                        As Double
    Mt100                       As Double
    Van                         As Double
    Vpar                        As Double
    Numucup                     As Integer
    Fecucup                     As String
    Intucup                     As Double
    Amoucup                     As Double
    Salucup                     As Double
    Numpcup                     As Integer
    Fecpcup                     As String
    Intpcup                     As Double
    Amopcup                     As Double
    Salpcup                     As Double
End Type
   

' Estructura datos de emisión.-
Type BacDatEmiType
    iOK                         As Integer
    sInstSer                    As String * 12
    lRutemi                     As Long
    iMonemi                     As Integer
    sFecEmi                     As String * 10
    sFecvct                     As String * 10
    dTasEmi                     As Double
    iBasemi                     As Integer
    sRefNomi                    As String * 1
    sLecemi                     As String * 6
    sGeneri                     As String * 6
    ' para datos extras en ventas
    sFecpcup                    As String * 10
    dNumOper                    As Double
    sTipoper                    As String * 3
    sFecvtop                    As String * 10
    iDiasdis                    As Integer
End Type
Global BacDatEmi                As BacDatEmiType

Type Papeles
   cInstr                       As String * 12
   cMascara                     As String * 10
   nCodigo                      As Integer
   cSerie                       As String * 10
   cRut                         As Long
   nMonemi                      As Integer
   nTasemi                      As Double
   nBasemi                      As Integer
   dFecemi                      As String * 10
   dFecven                      As String * 10
   cRefnomi                     As String * 1
   cGenemi                      As String * 10
   cNemo                        As String * 5
   nCortes                      As Integer
   cSeriado                     As String * 1
   sLecemi                      As String * 6
   nValmon                      As Double
   cIndte                       As String * 1
   nValte                       As Double
   TMoneda                      As String * 3
End Type
Global Pap                      As Papeles



Type ValorizaEntrada
    ModCal                      As Integer
    FecCal                      As String
    Codigo                      As Long
    mascara                     As String
    MonEmi                      As Integer
    fecemi                      As String
    FecVen                      As String
    TasEmi                      As Double
    BasEmi                      As Integer
    TasEst                      As Long
    Nominal                     As Double
    Tir                         As Double
    Pvp                         As Double
    Mt                          As Double

End Type

'Tipo de Datos de Salida para el valorizador
Type ValorizaSalida
    Nominal                     As Double
    Tir                         As Double
    Pvp                         As Double
    Mt                          As Double
    MtUM                        As Double
    Mt100                       As Double
    Van                         As Double
    Vpar                        As Double
    Numucup                     As Integer
    Fecucup                     As String
    Intucup                     As Double
    Amoucup                     As Double
    Salucup                     As Double
    Numpcup                     As Integer
    Fecpcup                     As String
    Intpcup                     As Double
    Amopcup                     As Double
    Salpcup                     As Double
End Type

'constantes
Global Const PTO_DECIMAL = "."
Global Const COD_DECIMAL = 46
Global Const TEC_PASADA = 13

''Constantes Para la Tabla de Clientes
''------------------------------------
'Global Const MDCL_TIPOCLIENTE = 7
'Global Const MDCL_SECECONOMICO = 8
'
''Constantes Para La Tabla de Emisores
''------------------------------------
'Global Const MDEM_TIPOEMISOR = 10
'
''Constantes Para la Tabla de Monedas
''-----------------------------------
'Global Const MDMN_PERIODO = 16
'Global Const MDMN_BASE = 11
'Global Const MDMN_TIPOMONEDA = 17
'
''Constantes Para la Tabla de Feriados
''------------------------------------
'Global Const MDFE_PLAZA = 15
'
''Constantes para la tabla de instrumentos
''--------------------------------------------
'Global Const MDIN_BASES = 11
'Global Const MDIN_TIPOFECHA = 20
'Global Const MDIN_TIPO = 19
'Global Const MDIN_EMISION = 21
'
'
''Constantes Para la Tabla de Series
''--------------------------------------------
'Global Const MDSE_TIPOAMORTIZACION = 12
'Global Const MDSE_TIPOPERIODO = 16
'
''----------------------------------------------------------
''Toma el valor desde la ayuda para el codigo de Emisor
'Global gsCodigo$
'
''----------------------------------------------------------
''Valor de Pantalla, control Aceptar
'Global giAceptar%

' Colores para Grillas
Global Const G_COLOR_AZUL_FUERTE = &HC00000
Global Const G_COLOR_AZUL = &H800000
Global Const G_COLOR_VERDE = &HC0C000
Global Const G_COLOR_PLOMO = &H808080
Global Const G_COLOR_BLANCO = &HFFFFFF
Global Const G_COLOR_NEGRO = &H80000008
Global Const G_COLOR_CLARO = &HC0FFFF
Global Const G_COLOR_ROJO = &H80&
Global Const G_COLOR_PLOMO_CLARO = &HC0C0C0

' Datos Generales de la Operacion PANTALLA DE OPERACIONES
'Type Estr_Datos_Operacion
'    Monto_Operacion             As Double
'    Tasa_Pacto                  As Double
'    Dias_Pacto                  As Integer
'    Base_Pacto                  As Integer
'    Moneda_Pacto                As String * 3
'    Fecha_Vencimiento           As String * 10
'    Monto_Inicio                As Double
'    Monto_Final                 As Double
'    Monto_por_Asignar           As Double
'    Rut_Cliente                 As Long
'    Codigo_rut                  As Integer
'    Agente                      As String * 6
'    Sucursal                    As Integer
'    Tipo_Liquidacion            As String * 4
'    Retiro                      As String * 4
'    Forma_Pago                  As String * 4
'    Forma_Pago_Vcto             As String * 4
'End Type
'
'Type Estr_Datos_Nemotecnico
'    Instrumento                 As String * 6
'    Moneda_Emision              As String * 3
'    Emisor                      As String * 6
'    Serie                       As String * 12
'    Fecha_Emision               As String * 10
'    Fecha_Vencimiento           As String * 10
'    Numero_cortes               As Integer
'    Monto_corte                 As Double
'    Corte_minimo                As Double
'End Type
'
'Type Estr_Gen_Parametros
'    Fec_ayer_gen                As String * 10
'    Fec_hoy_gen                 As String * 10
'    Fec_manana_gen              As String * 10
'    Fec_ayer_adm                As String * 10
'    Fec_hoy_adm                 As String * 10
'    Fec_manana_adm              As String * 10
'    Fec_ayer_accion             As String * 10
'    Fec_hoy_accion              As String * 10
'    Fec_manana_accion           As String * 10
'    Rut_Corredora               As Long
'    Fecha_ultimo_Mercado        As String * 10
'    Emisor_Central              As String * 6
'    Codigo_rut                  As Integer
'    Codigo_svs                  As String * 6
'    Agente                      As String * 5
'    Sucursal                    As Integer
'    Codigo_Comercio             As String * 4
'    Codigo_Valparaiso           As String * 4
'    Codigo_Electronica          As String * 4
'    Emisor_Corredora            As String * 6
'    Razon_Social                As String * 70
'    Monto_Minimo_Pactos         As Double
'    Moneda_Monto_Minimo         As String * 4
'    Ano_Voucher_Apertura        As Integer
'End Type
'
'Global Gen_Parametros           As Estr_Gen_Parametros
'
''-----------------------------------------------------------
'
'Global Serie_Unica              As String
'Global PosicionFecha
'Global Seriado
'Global Instrumento              As String
'Global Tabla_Desarrollo         As String
'Global Tabla_Premio             As String
'Global Emisor_Fijo              As String
'Global Emisor_Banco             As String
'
'Global Datos_Nemotecnico        As Estr_Datos_Nemotecnico

Global Cont                     As Long         'Variable de impresion

'' Ayuda de Clientes
'Global Glob_Rut_Cliente         As Long
'Global Glob_Codigo_Rut          As Integer
'
'' Ayuda General
'Global Glob_Registro_Ayuda      As String
'Global Glob_Archivo_Ayuda       As String
'Global Glob_Filtro_Ayuda        As String
'Global Glob_Registro_Ayuda_Linea As String
'
'Type Nemotecnico
'     Nemote                     As String * 12
'End Type
'
'Global CreaSerie()              As Nemotecnico
'Global CantLineas               As Long

'Variable de paso entre pantalla de operaciones y Crea Cliente rápido
'Global Razon_Social             As String

'Type Control_Pantalla_Usuarios
'     Grabar   As String * 1
'     Imprimir As String * 1
'     Procesar As String * 1
'     Anular   As String * 1
'End Type
'
'Global Control_Pantalla As Control_Pantalla_Usuarios

Type Est_Perfil_Fijo
  Correlativo As String
  Campo As String
  Tipo_perfil As String
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

Public Sub MuestraReporte(cry As Control, MdbPath, MdbFile, MdbTabla, RptPath, RptFile As String)
 
  On Error GoTo RptError
  
  cry.ReportFileName = _
      RptPath & "\" & RptFile
  
  cry.PrintFileName = _
      MdbPath & "\" & MdbFile
  
  cry.WindowTitle = RptFile
  cry.Destination = crptToWindow
  cry.Action = 1

  On Error GoTo 0
  
  Exit Sub
  
RptError:
  MsgBox "Se produjo un error al intentar abrir el Archivo de Reportes" & _
    "La ruta de Acceso " & gsRPT_Path & "\" & RptFile & _
    "' especificada en Proveedor.ini, no es válida.", vbOKOnly + vbExclamation
  On Error GoTo 0
End Sub

Public Sub Coloca_Logo(ImageBox, Ajuste As Boolean, Frame)
  On Error GoTo Fallo
  ImageBox.Stretch = Ajuste
  ImageBox.Picture = LoadPicture(Logo_Path)
  ImageBox.Top = (Frame.Height - ImageBox.Height) \ 2
  ImageBox.Left = (Frame.Width - ImageBox.Width) \ 2
  On Error GoTo 0
  Exit Sub
Fallo:
  On Error GoTo 0
End Sub

Public Function ObtenerFolio()
ObtenerFolio = 0
  sql = "sp_Obtener_Folio"
    If SQL_Execute(sql) = 0 Then
      If SQL_Fetch(Datos()) = 0 Then ObtenerFolio = Val(Datos(1))
    End If
End Function

'Public Function GuardaUltimaSeleccion(Combo As Control, Start, Length As Integer)
'GuardaUltimaSeleccion = ""
'  If Combo.ListCount > 0 Then GuardaUltimaSeleccion = Trim(Mid(Combo.List(Combo.ListIndex), Start, Length))
'End Function
'
'Public Sub BuscaUltimaSeleccion(Combo As Control, Value As Variant, Start As Integer, Length As Integer)
'    If Combo.ListCount <= 0 Then Exit Sub
'  Dim a As Integer
'  a = 0
'    Do While a < Combo.ListCount
'    Dim campo As String
'        If UCase(Trim(Mid(Combo.List(a), Start, Length))) = UCase(Value) Then
'          Combo.ListIndex = a
'          Exit Sub
'        End If
'      a = a + 1
'    Loop
'  Combo.ListIndex = Combo.ListCount - 1
'End Sub

Public Sub PasaTextoAMask(Texto As Variant, masked As Control)
  Dim mascara As String
  mascara = masked.mask
  masked.mask = ""
  masked.Text = Texto
  masked.mask = mascara
End Sub

Public Sub LlenaCombo(Qry As String, Combo As Control, codSize As Integer, numCode As Boolean)
Dim myItemString As String
Dim a%
  Combo.Clear
    If SQL_Execute(Qry) <> 0 Then Exit Sub
    Do While SQL_Fetch(Datos()) = 0
        For a% = 1 To UBound(Datos, 1)
          If a% = 1 Then
            If numCode Then
              myItemString = String(1 + codSize - Len(Str(Val(Datos(a%)))), "0") & Val(Datos(a%)) & "  "
            Else
              myItemString = myItemString & Datos(a%) & Space(2 + codSize - Len(Trim(Datos(a%))))
            End If
          Else
            myItemString = myItemString & Datos(a%) & " "
          End If
        Next a%
      Combo.AddItem Trim(myItemString)
      myItemString = ""
    Loop
End Sub

Public Sub BloqueaControles(Controles() As Variant, valor As Boolean)
Dim a%
  For a% = 0 To UBound(txtBoxes, 1)
    Controles(a).Locked = valor
  Next a%
End Sub

Public Sub HabilitaControles(Controles() As Variant, valor As Boolean)
Dim a%
  For a% = 0 To UBound(Controles, 1)
    Controles(a).Enabled = valor
  Next a%
End Sub

Public Sub HabilitaBotonTB(Barra As Control, Botones() As Variant, valor As Boolean)
Dim a%
  For a% = 0 To UBound(Botones, 1)
    Barra.Buttons.item(Botones(a)).Enabled = valor
  Next a%
End Sub

Public Sub BuscaEnGrilla(Grilla As Control, valor As String, strtRow As Long, Column As Long, Message As Boolean)
  Dim a  As Long
  a = strtRow
    Do
        If Grilla.TextMatrix(a, Column) = valor Then
          Grilla.Row = a
          Grilla.Col = Column
          Grilla.SetFocus
          Exit Sub
        End If
      a = a + 1
    Loop Until a = Grilla.Rows
  If Message Then MsgBox "No se encontró ninguna coincidencia", vbOKOnly + vbExclamation
End Sub

Public Sub LlenaGrilla(query As String, Grilla As Control)
  Dim a, b As Long
    If SQL_Execute(query) = 0 Then
      Grilla.Clear
      a = 1
        Do While SQL_Fetch(Datos()) = 0
          Grilla.Rows = a + 1
            For b = 0 To Grilla.Cols - 1
              Grilla.TextMatrix(a, b) = Datos(b + 1)
            Next b
          a = a + 1
        Loop
    End If
End Sub

Public Sub SP_BUSCA_CTAS_CTES(Codigo$, cmb As Control)
  Dim Datos()
  Comando$ = "SP_BUSCA_CTAS_CTES '" + Trim(Codigo$) + "'"
    If SQL_Execute(Comando$) = 0 Then
      cmb.Clear
        Do While SQL_Fetch(Datos()) = 0
          cmb.AddItem Datos(1) + Space(100) + Datos(2)
        Loop
    End If
End Sub

Function FUNC_BUSCA_CONTROL_PROCESO(Codigo As String) As String
  Dim Datos()
  FUNC_BUSCA_CONTROL_PROCESO = "N"
  Comando$ = "SP_BUSCA_CONTROL_PROCESO '" + Codigo + "'"
    If SQL_Execute(Comando$) = 0 Then
      If SQL_Fetch(Datos()) = 0 Then
        FUNC_BUSCA_CONTROL_PROCESO = Datos(1)
      End If
    End If
End Function

Function FUNC_CARGA_CONFIGURACION() As Variant
  gSQL_interfas = FUNC_LEE_ARCHIVO_INI("Conexion", " Interfas")
  gsSQL_DataBase = FUNC_LEE_ARCHIVO_INI("Conexion", "Database")
  gsSQL_Server = FUNC_LEE_ARCHIVO_INI("Conexion", "Server")
  gsSQL_Login = FUNC_LEE_ARCHIVO_INI("Conexion", "Login")
  gsSQL_Password = FUNC_LEE_ARCHIVO_INI("Conexion", "Password")
  giSQL_LoginTimeOut = Val(FUNC_LEE_ARCHIVO_INI("Conexion", "LoginTimeOut"))
  giSQL_QueryTimeOut = Val(FUNC_LEE_ARCHIVO_INI("Conexion", "QueryTimeOut"))
  giSQL_ConnectionMode = Val(FUNC_LEE_ARCHIVO_INI("Conexion", "ConnectionMode"))
  giSQL_interfas = Val(FUNC_LEE_ARCHIVO_INI("Conexion", " Interfas"))
  gsMDB_Path = FUNC_LEE_ARCHIVO_INI("Bases MDB", "DatabaseMDB")
  gsRPT_Path = FUNC_LEE_ARCHIVO_INI("Bases MDB", "ReportesRPT")
  gsNombreMDB_Path = FUNC_LEE_ARCHIVO_INI("Bases MDB", "NombreBaseDatos")
  Logo_Path = FUNC_LEE_ARCHIVO_INI("Entorno", "Logo")
  'gsLogo_Corredora = FUNC_LEE_ARCHIVO_INI("Empresa", "Logo")
  'gsTapiz = FUNC_LEE_ARCHIVO_INI("Empresa", "Tapiz")
  FUNC_CARGA_CONFIGURACION = True
End Function

Function FUNC_LEE_ARCHIVO_INI(item As String, campo_item As String) As String
  Dim campo_retorno As String * 50: campo_retorno = ""
    If 0 = GetPrivateProfileString(item, campo_item, "", campo_retorno, Len(campo_retorno), "Proveedor.INI") Then
      MsgBox "NO Puede Leer Proveedor.INI", vbCritical
      End
    End If
    'If campo_item = "Password" Then
    '   retorno$ = BacEncript(FUNC_QUITA_NULOS(campo_retorno), False)
    'Else
        retorno$ = FUNC_QUITA_NULOS(campo_retorno)
    'End If
  FUNC_LEE_ARCHIVO_INI = retorno$
End Function

Function FUNC_QUITA_NULOS(Campo As String) As String
    For i% = Len(Campo) To 1 Step -1
      If Asc(Mid(Campo, i%, 1)) = 0 Then
         Mid(Campo, i%, 1) = Space(1)
      End If
    Next i%
  FUNC_QUITA_NULOS = Trim(Campo)
End Function

Sub PROC_CARGA_PARAMETROS()
  Dim Datos()
  Dim sql As String
  sql = "SP_BUSCA_GEN_PARAMETROS "
    If SQL_Execute(sql) = 0 Then
      If SQL_Fetch(Datos()) = 0 Then
        Gen_Parametros.Fec_ayer_gen = Datos(1)
        Gen_Parametros.Fec_hoy_gen = Datos(2)
        Gen_Parametros.Fec_manana_gen = Datos(3)
        Gen_Parametros.Fec_ayer_adm = Datos(4)
        Gen_Parametros.Fec_hoy_adm = Datos(5)
        Gen_Parametros.Fec_manana_adm = Datos(6)
        Gen_Parametros.Fec_ayer_accion = Datos(7)
        Gen_Parametros.Fec_hoy_accion = Datos(8)
        Gen_Parametros.Fec_manana_accion = Datos(9)
        Gen_Parametros.Rut_Corredora = Datos(10)
        Gen_Parametros.Fecha_ultimo_Mercado = Datos(11)
        Gen_Parametros.Emisor_Central = Datos(12)
        Gen_Parametros.Codigo_rut = Val(Datos(13))
        Gen_Parametros.Agente = Datos(14)
        Gen_Parametros.Sucursal = Val(Datos(15))
        Gen_Parametros.Codigo_svs = Datos(16)
        Gen_Parametros.Codigo_Comercio = Datos(17)
        Gen_Parametros.Codigo_Valparaiso = Datos(18)
        Gen_Parametros.Codigo_Electronica = Datos(19)
        Gen_Parametros.Emisor_Corredora = Datos(20)
        Gen_Parametros.Razon_Social = Datos(21)
        Gen_Parametros.Monto_Minimo_Pactos = Datos(22)
        Gen_Parametros.Moneda_Monto_Minimo = Datos(23)
        Gen_Parametros.Ano_Voucher_Apertura = Val(Datos(24))
        ' SETEA HORA DEL PC CON HORA DEL SERVIDOR
          If Trim(Datos(25)) <> "" Then Time = Trim(Datos(25))
      End If
    End If
End Sub


Function FUNC_BORRA_PAGOS_OPERACION(Origen As String, Tipo_Operacion As String, Operacion As Long, Numero_Orden As Long, Tipo_Pago As String) As Boolean
  Dim Datos()
  FUNC_BORRA_PAGOS_OPERACION = False
  Comando$ = "SP_BORRA_PAGOS_OPERACION_TES "
  Comando$ = Comando$ + "'" + Origen + "',"
  Comando$ = Comando$ + "'" + Tipo_Operacion + "',"
  Comando$ = Comando$ + Str(Operacion) + ","
  Comando$ = Comando$ + Str(Numero_Orden) + ","
  Comando$ = Comando$ + "'" + Tipo_Pago + "'"
    If SQL_Execute(Comando$) <> 0 Then
      MsgBox "Error al Anular Pagos", 16
      Exit Function
    End If
    'If SQL_Fetch(Datos()) = 0 Then
    '  If Datos(1) <> "OK" Then
    '    MsgBox Datos(2), vbCritical
    '    Exit Function
    '  End If
    'Else
    '  MsgBox "Error al Anular Pagos de Operación", vbCritical
    '  Exit Function
    'End If
  FUNC_BORRA_PAGOS_OPERACION = True
End Function

Function FUNC_ENTREGA_FOLIO(Tipo_Folio As String, Actualiza_Folio As String) As Long
  Dim Datos()
  Dim Numero_Folio As Long
  FUNC_ENTREGA_FOLIO = 0
  Comando$ = "SP_ENTREGA_FOLIO " + "'" + Tipo_Folio + "','" + Actualiza_Folio + "'"
    If SQL_Execute(Comando$) = 0 Then
      If SQL_Fetch(Datos()) = 0 Then
        Numero_Folio = Val(Datos(1))
      End If
    End If
  FUNC_ENTREGA_FOLIO = Numero_Folio
End Function

Sub PROC_MARCA_FILA_GRILLA(Objeto_grid As Control, Color1, Color2, fila, columna)
  fila_actual% = Objeto_grid.Row
  fila_rango% = Objeto_grid.RowSel
  columna_actual% = Objeto_grid.Col
  columna_rango% = Objeto_grid.ColSel
  estilo_fila% = Objeto_grid.FillStyle
  Objeto_grid.Row = fila
  Objeto_grid.RowSel = fila
  Objeto_grid.Col = columna
  Objeto_grid.ColSel = Objeto_grid.Cols - 1
  Objeto_grid.FillStyle = flexFillRepeat
  Objeto_grid.CellBackColor = Color1
  Objeto_grid.CellForeColor = Color2
  Objeto_grid.Row = fila_actual%
  Objeto_grid.RowSel = fila_rango%
  Objeto_grid.Col = columna_actual%
  Objeto_grid.ColSel = columna_rango%
  Objeto_grid.FillStyle = estilo_fila%
End Sub

Function FUNC_DIVD(p1 As Double, p2 As Double) As Double
  If p2# = 0# Then
    FUNC_DIVD = 0#
  Else
    FUNC_DIVD = p1# / p2#
  End If
End Function

Function FUNC_POSICION_COMBO(Cmb_Control As Control, Texto As String, Posicion As Integer) As Integer
  FUNC_POSICION_COMBO = 0
    For i% = 0 To Cmb_Control.ListCount - 1
      Cmb_Control.ListIndex = i%
        If Trim(Mid(Cmb_Control.Text, 1, Posicion)) = Trim(Texto) Then
          Encontro = True
          FUNC_POSICION_COMBO = i%
          Exit For
        End If
    Next i%
End Function

Function FUNC_VALIDA_CONTROL_PANTALLA(Tipo As String) As Variant
  FUNC_VALIDA_CONTROL_PANTALLA = True
  Exit Function

  FUNC_VALIDA_CONTROL_PANTALLA = False
    If Tipo = "Grabar" And Control_Pantalla.Grabar <> "S" Then
      MsgBox "dddd", vbInformation
      Exit Function
    End If
    
    If (Tipo = "Eliminar" Or Tipo = "Anular") And Control_Pantalla.Anular <> "S" Then
      MsgBox "No Tampoco", vbInformation
      Exit Function
    End If

    If Tipo = "Procesar" And Control_Pantalla.Procesar <> "S" Then
      MsgBox "Menos po' H...", vbInformation
      Exit Function
    End If

    If Tipo = "Imprimir" And Control_Pantalla.Imprimir <> "S" Then
      MsgBox "Menos po' H...", vbInformation
      Exit Function
    End If

    If Tipo = "Buscar" And Control_Pantalla.Imprimir <> "S" Then
      MsgBox "Menos po' H...", vbInformation
      Exit Function
    End If
  FUNC_VALIDA_CONTROL_PANTALLA = True
End Function

Sub PROC_VALORIZA_PAPEL(Calcula_valor As String, Fecha_Proceso As String, Nemotecnico As String, ByRef Nominal As Double, ByRef Tir As Double, ByRef Pvc As Double, ByRef Tasa_estimada As Double, ByRef Monto As Double)
  Dim Datos()
  Comando$ = "SP_VALORIZA_PAPEL_CLIENTE "
  Comando$ = Comando$ + "'" + Calcula_valor + "',"
  Comando$ = Comando$ + "'" + FmtFecha(Fecha_Proceso) + "',"
  Comando$ = Comando$ + "'" + Nemotecnico + "',"
  Comando$ = Comando$ + Format(Nominal, "##0.0000") + ","
  Comando$ = Comando$ + Format(Tir, "##0.0000") + ","
  Comando$ = Comando$ + Format(Pvc, "##0.0000") + ","
  Comando$ = Comando$ + Format(Tasa_estimada, "##0.0000") + ","
  Comando$ = Comando$ + Format(Monto, "##0")
    If SQL_Execute(Comando$) <> 0 Then Exit Sub
    If SQL_Fetch(Datos()) = 0 Then
        If Trim(Mid(Datos(2), 1, 2)) = "La" Then
          MsgBox Datos(2), vbCritical, "Pc-Trader"
          Exit Sub
        End If
      Nominal = FUNC_FMT_DOUBLE((Datos(1)))
      Tir = FUNC_FMT_DOUBLE((Datos(2)))
      Pvc = FUNC_FMT_DOUBLE((Datos(3)))
      Tasa_estimada = FUNC_FMT_DOUBLE((Datos(4)))
      Monto = FUNC_FMT_DOUBLE((Datos(5)))
      ' LLENA ESTRUCTURA VALORIZADOR (DEFINIDA GLOBAL)
      Valorizador.Nemotecnico = Nemotecnico
      Valorizador.Nominal = Nominal
      Valorizador.Tir = Tir
      Valorizador.Pvc = Pvc
      Valorizador.Tasa_estimada = Tasa_estimada
      Valorizador.Monto = Monto
      Valorizador.Monto_UM = FUNC_FMT_DOUBLE((Datos(6)))
      Valorizador.Numero_Act_Cupon = Val(Datos(7))
      Valorizador.Fecha_Act_Cupon = Trim(Datos(8))
      Valorizador.Interes_Act_Cupon = FUNC_FMT_DOUBLE((Datos(9)))
      Valorizador.Amortiza_Act_Cupon = FUNC_FMT_DOUBLE((Datos(10)))
      Valorizador.Saldo_Act_Cupon = FUNC_FMT_DOUBLE((Datos(11)))
      Valorizador.Numero_Prx_Cupon = Val(Datos(12))
      Valorizador.Fecha_Prx_Cupon = Trim(Datos(13))
      Valorizador.Interes_Prx_Cupon = FUNC_FMT_DOUBLE((Datos(14)))
      Valorizador.Amortiza_Prx_Cupon = FUNC_FMT_DOUBLE((Datos(15)))
      Valorizador.Saldo_Prx_Cupon = FUNC_FMT_DOUBLE((Datos(16)))
    End If
End Sub

Sub PROC_LLENA_COMBO(Archivo As String, Obj_Combo As Control, Filtro As String, Largo As Integer)
  Dim Datos()
  If Trim(Archivo) = "ENTIDADES" Then
    Comando$ = ""
    Comando$ = Comando$ & "Sp_Leer_Entidades "
      If SQL_Execute(Comando$) = 0 Then
        Obj_Combo.Clear
          Do While SQL_Fetch(Datos()) = 0
            Obj_Combo.AddItem Datos(2) & Space(200) & Val(Datos(1))
          Loop
      End If
    Exit Sub
  Else
    Comando$ = ""
    Comando$ = Comando$ & "SP_CONSULTATABLAS "
    Comando$ = Comando$ & "'" & Trim(Archivo) & "',"
    Comando$ = Comando$ & "'" & Trim(Filtro) & "'"
  End If
  If SQL_Execute(Comando$) = 0 Then
    Obj_Combo.Clear
      Do While SQL_Fetch(Datos()) = 0
        If Archivo = "GEN_INDICADOR" Then
          Obj_Combo.AddItem FUNC_LARGO_ST((Datos(1)), Largo) & " " & Format(Datos(3), "000") + " " + Datos(2)
        ElseIf Archivo = "GEN_CLIENTES" Then
          If Datos(5) = "N" Then
            Obj_Combo.AddItem Datos(10) + Datos(11) + Datos(12) & Space(30) & Datos(1) & "-" & Datos(2)
          Else
            Obj_Combo.AddItem Datos(9) & Space(60) & Datos(1) & "-" & Datos(2)
          End If
        Else
          Obj_Combo.AddItem FUNC_LARGO_ST((Datos(1)), Largo) & " " & Datos(2)
        End If
      Loop
      If Obj_Combo.ListCount <> 0 Then Obj_Combo.ListIndex = 0
  End If
End Sub

Sub PROC_BARRA_GRILLA(Objeto_grid As Control)
  Objeto_grid.Redraw = False
  col_g% = Objeto_grid.Col
    For i% = 0 To Objeto_grid.Cols - 1
      Objeto_grid.Col = i%
        If CLng(Objeto_grid.CellBackColor) = 8421504 Then
          Objeto_grid.CellBackColor = &H80000009
          Objeto_grid.CellForeColor = &H80000008
        Else
          Objeto_grid.CellBackColor = &H808080
          Objeto_grid.CellForeColor = &H80000009
        End If
    Next i%
  Objeto_grid.Col = col_g%
  Objeto_grid.Redraw = True
End Sub

Function FUNC_BUSCA_AGENTE(Codigo_Agente As String, Texto As Control, ByRef Sucursal) As Variant
  Dim Datos()
  FUNC_BUSCA_AGENTE = False
  Comando$ = "SP_BUSCA_AGENTES '" & Codigo_Agente & "'"
    If SQL_Execute(Comando$) = 0 Then
      If SQL_Fetch(Datos()) = 0 Then
        Texto.Caption = Datos(1)
        Sucursal = Datos(2)
        FUNC_BUSCA_AGENTE = True
        Exit Function
      End If
    End If
  Texto.Caption = ""
  MsgBox "No Existe Agente.", 16
End Function

Function FUNC_BUSCA_BANCO(Codigo_Banco As String, Texto As Control) As Variant
  Dim Datos()
  FUNC_BUSCA_BANCO = False
  Comando$ = "sp_BuscaBanco '" & Codigo_Banco & "'"
    If SQL_Execute(Comando$) = 0 Then
      If SQL_Fetch(Datos()) = 0 Then
        Texto.Caption = Datos(1)
        FUNC_BUSCA_BANCO = True
        Exit Function
      End If
    End If
  Texto.Caption = ""
  MsgBox "No Existe Banco.", 16
End Function

Sub PROC_BUSCA_DENOMINACION_CORTE(Nominal As Double)
  Dim Datos()
  Comando$ = "SP_BUSCA_DENOMINACION_CORTE '" + Trim(Datos_Nemotecnico.Serie) + "'," + Format(Nominal, "##0.0000")
    If SQL_Execute(Comando$) <> 0 Then
      Datos_Nemotecnico.Numero_cortes = 1
      Datos_Nemotecnico.Monto_corte = Nominal
      Exit Sub
    End If
    If SQL_Fetch(Datos()) = -1 Then
      Datos_Nemotecnico.Numero_cortes = 1
      Datos_Nemotecnico.Monto_corte = Nominal
    Else
      Datos_Nemotecnico.Numero_cortes = Val(Datos(1))
      Datos_Nemotecnico.Monto_corte = Datos(2)
    End If
End Sub

Sub BARRA_GRID(Grilla As Control, modo As Variant)
  Grilla.SelStartRow = Grilla.Row
  Grilla.SelEndRow = Grilla.Row
  Grilla.SelStartCol = 0
  Grilla.SelEndCol = (Grilla.Cols - 1)
  Grilla.HighLight = modo
End Sub


Function FUNC_BUSCA_SUCURSAL(Codigo_Sucursal As Long, Texto As Control) As Variant
  Dim Datos()
  FUNC_BUSCA_SUCURSAL = False
  Comando$ = "SP_BUSCA_SUCURSAL " & Str(Codigo_Sucursal)
    If SQL_Execute(Comando$) = 0 Then
      If SQL_Fetch(Datos()) = 0 Then
        Texto.Caption = Datos(1)
        FUNC_BUSCA_SUCURSAL = True
        Exit Function
      End If
    End If
  Texto.Caption = ""
  MsgBox "No Existe Sucursal.", 16
End Function

Function FUNC_VALIDA_NEMO(Fecha_Calculo As String, Nemo As String) As Variant
Dim Datos()
FUNC_VALIDA_NEMO = True
Comando$ = "SP_VALIDA_NEMOTECNICO_IRF '" & FmtFecha(Fecha_Calculo) + "','" & Trim(Nemo) & "'"
  If SQL_Execute(Comando$) <> 0 Then Exit Function
  If SQL_Fetch(Datos()) = 0 Then
    If Datos(1) = "ERROR" Then
      MsgBox "Nemotecnico NO Existe ó Mal Ingresado.", vbCritical
      FUNC_VALIDA_NEMO = False
      Exit Function
   End If
  Datos_Nemotecnico.Instrumento = Datos(2)
  Datos_Nemotecnico.Moneda_Emision = Datos(3)
  Datos_Nemotecnico.Emisor = Datos(4)
  Datos_Nemotecnico.Serie = Datos(5)
  Datos_Nemotecnico.Fecha_Emision = Datos(6)
  Datos_Nemotecnico.Fecha_Vencimiento = Datos(7)
  Datos_Nemotecnico.Corte_minimo = IIf(Trim(Datos(8)) = "", 0, Datos(8))
    If Datos_Nemotecnico.Corte_minimo = 0# Then Datos_Nemotecnico.Corte_minimo = 1#
    If Trim(Datos_Nemotecnico.Fecha_Vencimiento) = "" And Datos(2) <> "FMUTUO" Then
      MsgBox "Nemotecnico NO Existe ó Mal Ingresado.", vbCritical
      FUNC_VALIDA_NEMO = False
      Exit Function
    End If
    If Datos(2) <> "FMUTUO" Then
      If DateDiff("d", Gen_Parametros.Fec_hoy_gen, Datos_Nemotecnico.Fecha_Vencimiento) <= 0 Then
        MsgBox "Instrumento Esta Vencido.", vbCritical
        FUNC_VALIDA_NEMO = False
        Exit Function
      End If
    End If
  Else
    MsgBox "No Existe Nemotecnico.", vbCritical
    FUNC_VALIDA_NEMO = False
  End If
End Function

Function FUNC_BUSCA_VAL_INDICADOR(codigo_indicador As String, fecha As String) As Double
  Dim Datos()
    If Trim(codigo_indicador) = "$$" Then
      FUNC_BUSCA_VAL_INDICADOR = 1
      Exit Function
    End If
  Comando$ = "SP_BUSCA_VAL_INDICADOR "
  Comando$ = Comando$ & "'" & codigo_indicador & "',"
  Comando$ = Comando$ & "'" & FmtFecha(fecha) & "'"
  FUNC_BUSCA_VAL_INDICADOR = 0#
    If SQL_Execute(Comando$) = 0 Then
      If SQL_Fetch(Datos()) = 0 Then
        FUNC_BUSCA_VAL_INDICADOR = Datos(1)
      End If
    End If
End Function

Sub BORRA_GRID(Grilla As Control)
  Grilla.SelStartCol = 0
  Grilla.SelEndCol = (Grilla.Cols - 1)
  Grilla.SelStartRow = 1
  Grilla.SelEndRow = Grilla.Rows - 1
  Grilla.Clip = ""
  Grilla.HighLight = False
End Sub

Public Function BAC_Login() As Boolean
  BAC_Login = False
    If giSQL_ConnectionMode = 1 Then
      If SQL_Open(gsSQL_Server$, gsSQL_Login$, gsSQL_Password$, gsSQL_DataBase, giSQL_LoginTimeOut, giSQL_QueryTimeOut) <> 0 Then
        End
      End If
    Else
      If SQL_Open(gsSQL_Server, sUser$, sPWD$, gsSQL_DataBase, giSQL_LoginTimeOut, giSQL_QueryTimeOut) <> 0 Then
        End
      End If
    End If
End Function

Function CONVIERTE_FECHA(Text As String, modo As Boolean) As String
  If modo Then
  '     1234567890
  '    "dd/mm/yyyy" --> "yyyymmdd"
    CONVIERTE_FECHA = Mid(Text, 7, 4) + Mid(Text, 4, 2) + Mid(Text, 1, 2)
  Else
  '     1234567890
  '    "yyyymmdd" -- >> "dd/mm/yyyy"
    CONVIERTE_FECHA = Mid(Text, 7, 2) + "/" + Mid(Text, 5, 2) + "/" + Mid(Text, 1, 4)
  End If
End Function

Public Function FUNC_VALIDA_DIA_FERIADO(fecha As String) As String
  Dim sql$
  Dim Datos()
  sql = "SP_LLAMA_DIAS_FERIADOS '" + FmtFecha(fecha) + "'"
    If SQL_Execute(sql) <> 0 Then
      Exit Function
    End If

    If SQL_Fetch(Datos()) = 0 Then
      FUNC_VALIDA_DIA_FERIADO = Datos(1)
    End If
End Function

Function FMT_DATE(p1 As Variant) As String
  Static st1, st2 As String
  'FMT_DATE = Format(p1, " dddd  dd   " & DE & "  mmmm   " & DE & "  yyyy ")

  st1 = Trim(Mid("Domingo  Lunes    Martes   Miercoles Jueves   Viernes  Sabado   ", ((WeekDay(p1) - 1) * 9) + 1, 9))
  st2 = Trim(Mid("Enero     Febrero   Marzo     Abril     Mayo      Junio     Julio     Agosto    Septiembre Octubre   Noviembre Diciembre ", ((Month(p1) - 1) * 10) + 1, 10))
  FMT_DATE = st1 & " " & Day(p1) & " de " & st2 & " de " & Year(p1)
End Function

Sub BacFrmCentrar(fForm As Form)
  Dim lLeft&, lTop&
  lTop = (Screen.Height - fForm.Height) / 2
  lLeft = (Screen.Width - fForm.Width) / 2
    If lTop And lLeft Then
      fForm.Move lLeft, lTop
    End If
End Sub

Public Function BuscaCodigo(obj As Object, Codi As Integer) As Long
  Dim F   As Long
  Dim Max As Long
  BuscaCodigo = -1
  Max = obj.Coleccion.Count
    For F = 1 To Max
      If obj.Coleccion(F).Codigo = Codi Then
        BuscaCodigo = F - 1
        Exit For
      End If
    Next F
End Function

Public Function BuscaGlosa(obj As Object, Codi As String) As Long
  Dim F   As Long
  Dim Max As Long
  BuscaGlosa = -1
  Max = obj.Coleccion.Count
    For F = 1 To Max
      If Trim$(obj.Coleccion(F).Glosa) = Trim(Codi) Then
        BuscaGlosa = F - 1
        Exit For
      End If
    Next F
End Function

Public Function Dia_De_La_Semana(Fecha_Parametro As String) As String
  Dia_De_La_Semana = ""
    If IsDate(Fecha_Parametro) Then
      Select Case WeekDay(Fecha_Parametro)
        Case 1
          Dia_De_La_Semana = "Domingo"
        Case 2
          Dia_De_La_Semana = "Lunes"
        Case 3
          Dia_De_La_Semana = "Martes"
        Case 4
          Dia_De_La_Semana = "Miércoles"
        Case 5
          Dia_De_La_Semana = "Jueves"
        Case 6
          Dia_De_La_Semana = "Viernes"
        Case 7
          Dia_De_La_Semana = "Sábado"
      End Select
    End If
End Function

'Elimina los caracteres no numericos de un string
Public Function EatChars(cad As String) As String
  Dim a%
  Dim c$, newcad$
  newcad$ = ""
    For a% = 1 To Len(cad)
      c$ = Mid(cad, a%, 1)
        If InStr(1, "1234567890", c$, vbTextCompare) <> 0 Then newcad$ = newcad$ & c$
    Next a%
  EatChars = newcad$
End Function

Public Function OkRut(rut As String, Digito As String)
  Dim a As Integer
  Dim Results As Integer
  Dim mask As String
  Dim EvalDigit, GivenDigit As String
  mask = "432765432"
  GivenDigit = Trim(Digito)
  rut = EatChars(rut)
  rut = String(9 - Len(rut), "0") & rut
    For a = Len(rut) To 1 Step -1
      Results = Results + (Val(Mid(rut, a, 1)) * Val(Mid(mask, a, 1)))
    Next a
  Results = 11 - (Results Mod 11)
  
    If Results < 10 Then
      EvalDigit = Str(Results)
    ElseIf Results = 10 Then
      EvalDigit = "K"
    ElseIf Results = 11 Then
      EvalDigit = "0"
    End If
    
    If Trim(GivenDigit) = "" Then
      OkRut = UCase(EvalDigit)
    Else
      If UCase(Trim(GivenDigit)) = UCase(Trim(EvalDigit)) Then
        OkRut = True
      Else
        OkRut = False
        MsgBox "Rut no Valido.", vbOKOnly + vbExclamation, "Valida Rut"
      End If
    End If
End Function

Public Function RELLENA_STRING(Dato As String, Pos As String, Largo As Integer) As String
'rellena con blancos y completa el largo requerido
' Ejemplo : x$ = RELLENA_STRING(CStr(i#), "I", 10)
' Ejemplo : x$ = RELLENA_STRING(i$, "D", 10)
  If Trim(Pos$) = "" Then Pos$ = "I"
  If Largo < Len(Trim(Dato)) Then
    RELLENA_STRING = Mid(Trim(Dato), 1, Largo)
    Exit Function
  End If

  If Mid(Pos$, 1, 1) = "I" Then 'IZQUIERDA
    RELLENA_STRING = String(Largo - Len(Trim(Dato)), " ") + Trim(Dato)
  Else                          'DERECHA
    RELLENA_STRING = Trim(Dato) + String(Largo - Len(Trim(Dato)), " ")
  End If
  RELLENA_STRING = Mid(RELLENA_STRING, 1, Largo)
End Function

Public Function VALTIME(p1 As String) As Boolean
  Dim hh As Integer
  Dim mm As Integer
  Dim SS As Integer
    If Len(Trim(p1$)) < 8 Then
      VALTIME = False
      Exit Function
    End If
  hh% = Val(Mid(p1, 1, 2))
  mm% = Val(Mid(p1, 4, 2))
  SS% = Val(Mid(p1, 7, 2))
  VALTIME = IIf((hh% >= 0 And hh% < 24) And (mm% >= 0 And mm% < 60) And (SS% >= 0 And SS% < 60), True, False)
End Function

Public Function BuscaFecha()
  Dim GbSql As String
  Dim GbDatos()
  GbSql = "sp_proc_buscafecha"
    If SQL_Execute(GbSql) <> 0 Then
      MsgBox "Error en Busqueda de Fecha", 48
      Exit Function
    Else
      If SQL_Fetch(GbDatos()) = 0 Then
        gbFECHA_SISTEMA = CONVIERTE_FECHA(Trim(GbDatos(1)), False)
        gbRegSVS = GbDatos(2)
      Else
        MsgBox "Fecha Se Encuemtra Vacia", 48
        Exit Function
      End If
    End If
End Function


Public Function BuscaCliente(rut As Long, CodRut As Long) As String
  Dim GbSql As String
  Dim GbDatos()
  BusCliente = True
  GbSql = "SP_BUSCA_CLIENTE " + Str(rut) + "," + Trim(Str(CodRut)) + ""
    If SQL_Execute(GbSql) <> 0 Then
      MsgBox "Error en Busqueda de Cliente", 48
      Exit Function
    Else
      If SQL_Fetch(GbDatos()) = 0 Then
        Nombre_Paso = GbDatos(1)
        BuscaCliente = GbDatos(1)
      Else
        Nombre_Paso = ""
        Exit Function
      End If
    End If
End Function

Public Sub Marca_Fila(ByRef Grilla As Control, Back, Fore)
  Dim Col As Long
    Do While Col < Grilla.Cols
      Grilla.Col = Col
      Grilla.CellBackColor = Back
      Grilla.CellForeColor = Fore
      Col = Col + 1
    Loop
End Sub

Function MONTO_ESCRITO(n As Double) As String
  ReDim uni(15) As String
  ReDim dec(9) As String
  Dim z, Num, Var   As Variant
  Dim c, d, u, v, i As Integer
  Dim k
    If n = 0 Or n > 1E+17 Then
      MONTO_ESCRITO = IIf(n = 0, "CERO", "*")
      Exit Function
    End If
  uni(1) = "UN"
  uni(2) = "DOS"
  uni(3) = "TRES"
  uni(4) = "CUATRO"
  uni(5) = "CINCO"
  uni(6) = "SEIS"
  uni(7) = "SIETE"
  uni(8) = "OCHO"
  uni(9) = "NUEVE"
  uni(10) = "DIEZ"
  uni(11) = "ONCE"
  uni(12) = "DOCE"
  uni(13) = "TRECE"
  uni(14) = "CATORCE"
  uni(15) = "QUINCE"
  dec(3) = "TREINTA"
  dec(4) = "CUARENTA"
  dec(5) = "CINCUENTA"
  dec(6) = "SESENTA"
  dec(7) = "SETENTA"
  dec(8) = "OCHENTA"
  dec(9) = "NOVENTA"
  Num = String$(19 - Len(Str(Trim(n))), Space(1))
  Num = Num + Trim(Str(n))
  i = 1
  z = ""
    Do While True
      k = Mid(Num, 18 - (i * 3 - 1), 3)
        If k = Space(3) Then
          Exit Do
        End If
      c = Val(Mid(k, 1, 1))
      d = Val(Mid(k, 2, 1))
      u = Val(Mid(k, 3, 1))
      v = Val(Mid(k, 2, 2))
        If i > 1 Then
          If (i = 2 Or i = 4) And Val(k) > 0 Then
            z = " MIL " + z
          End If
          If i = 3 And Val(Mid(Num, 7, 6)) > 0 Then
            If Val(k) = 1 Then
              z = " MILLON " + z
            Else
              z = " MILLONES " + z
          End If
        End If
      If i = 5 And Val(k) > 0 Then
        If Val(k) = 1 Then
          z = " BILLON " + z
        Else
          z = " BILLONES " + z
        End If
      End If
   End If

   If v > 0 Then
      Select Case v
             Case 0 To 15
                  z = uni(v) + z
             Case 0 To 19
                  z = " DIECI" + uni(u) + z
             Case 20
                  z = " VEINTE " + z
             Case 0 To 29
                  z = " VEINTI" + uni(u) + z
             Case Else
                  If u = 0 Then
                     z = dec(d) + z
                  Else
                     z = dec(d) + " Y " + uni(u) + z
                  End If
      End Select
   End If

   If c > 0 Then
      If c = 1 Then
         If v = 0 Then
            z = " CIEN " + z
         Else
            z = " CIENTO " + z
         End If
      End If
      If c = 2 Or c = 3 Or c = 4 Or c = 6 Or c = 8 Then
         z = uni(c) + "CIENTOS " + z
      End If
      If c = 5 Then
         z = " QUINIENTOS " + z
      End If
      If c = 7 Then
         z = " SETECIENTOS " + z
      End If
      If c = 9 Then
         z = " NOVECIENTOS " + z
      End If
   End If

   i = i + 1
Loop
MONTO_ESCRITO = Trim(z)
End Function

Public Function LETRA_UPPER(KeyAscii As Integer) As Integer
  If KeyAscii = 39 Then KeyAscii = 0
  LETRA_UPPER = Asc(UCase(Chr(KeyAscii)))
End Function

Sub Read_Ini()
  Dim sFile$, Datos()
  sFile$ = "Accion.INI"
'
' SQL
'''''gbSQL_DataBase$ = ReadINI("SQL", "SQL_Database", sFile$)
'''''gbSQL_Server$ = ReadINI("SQL", "SQL_Server", sFile$)
'''''gbSQL_Login$ = ReadINI("SQL", "SQL_Login", sFile$)
'''''gbSQL_Password$ = ReadINI("SQL", "SQL_Password", sFile$)
'DESENCRIPTA LA PASSWORD DEL SERVIDOR
'''''gbSQL_Password$ = BacEncript(gbBAC_Password$, False)

'Leer INI para setear variables de Trabajo con Listados
'gbRptList_Path$ = ReadINI("LISTADOS", "List_Path", sFile$)
End Sub

Public Function VALIDAFECHA(fecha As String) As Boolean
  Dim LcFecha As String
  Dim dd, mm, aa As String
  dd = Mid(fecha, 1, 2)
  mm = Mid(fecha, 4, 2)
  aa = Mid(fecha, 7, 4)
  LcFecha = mm & "/" & dd & "/" & aa
    If Not IsDate(fecha) Then
      VALIDAFECHA = False
    Else
      VALIDAFECHA = True
    End If
End Function

Function FUNC_DIV(p1 As Variant, p2 As Variant) As Double
  If p2 = 0# Then
    FUNC_DIV = 0#
  Else
    FUNC_DIV = p1 / p2
  End If
End Function

Function FUNC_FMT_DOUBLE(Tpaso As String) As Double
  For i% = 1 To Len(Tpaso)
    If Mid(Tpaso, i%, 1) = "0" Then Mid(Tpaso, i%, 1) = " " Else Exit For
  Next i%
  If Trim(Tpaso) = "" Or Trim(Tpaso) = "." Then
    FUNC_FMT_DOUBLE = 0#
  Else
    FUNC_FMT_DOUBLE = CDbl(Tpaso)
  End If
End Function

Function FUNC_BLOQUEA_CARTERA(Tipo_Cartera As String, Tipo_Operacion As String, Operacion As Long, Correlativo As Integer, Estado As String, ByRef Nominal, ByRef Tir, ByRef Pvc, ByRef Valor_Presente) As Integer
  Dim Datos()
  FUNC_BLOQUEA_CARTERA = False
  Comando$ = "SP_BLOQUEO_CARTERA "
' Tipo cartera
  Comando$ = Comando$ + "'" + Trim(Tipo_Cartera) + "',"
' Tipo Operacion
  Comando$ = Comando$ + "'" + Trim(Tipo_Operacion) + "',"
' N. Operacion
  Comando$ = Comando$ + Str(Operacion) + ","
' Correlativo
  Comando$ = Comando$ + Str(Correlativo) + ","
' Estado
  Comando$ = Comando$ + "'" + Trim(Estado) + "'"
    If SQL_Execute(Comando$) <> 0 Then
      MsgBox "Registro NO Bloqueado.", vbCritical, "Mensaje"
      Exit Function
    End If
    If SQL_Fetch(Datos()) = -1 Then
      MsgBox "Registro NO Bloqueado.", vbCritical, "Mensaje"
      Exit Function
    Else
        If Datos(1) = "N" Then
          MsgBox Datos(2), vbCritical, "Mensaje"
          FUNC_BLOQUEA_CARTERA = False
          Exit Function
        End If
      Nominal = Datos(3)
      Tir = Datos(4)
      Pvc = Datos(5)
      Valor_Presente = Datos(6)
    End If
  FUNC_BLOQUEA_CARTERA = True
End Function

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

Function FmtFecha(fecha) As String
  FmtFecha = Mid(fecha, 7, 4) + Mid(fecha, 4, 2) + Mid(fecha, 1, 2)
End Function

Function FUNC_LARGO_ST(cadena As String, Largo As Integer) As String
  FUNC_LARGO_ST = Mid(Trim(cadena) + Space(Largo - Len(Trim(cadena))), 1, Largo)
End Function

Sub PROC_POSICIONA_TEXTO(Grilla As Control, Texto As Control)
  Texto.Top = Grilla.CellTop + Grilla.Top + 20
  Texto.Left = Grilla.CellLeft + Grilla.Left + 20
  Texto.Width = Grilla.CellWidth - 20
End Sub

Sub PROC_POSICIONA_COMBO(Grilla As Control, Combo As Control)
  Combo.Top = Grilla.CellTop + Grilla.Top + 20
  Combo.Left = Grilla.CellLeft + Grilla.Left + 20
End Sub

Function FUNC_BUSCA_CLIENTE(Campo As Integer, rut As Long, Codigo_rut As Integer, Texto As Control) 'As Variant
  Dim Datos()
  FUNC_BUSCA_CLIENTE = False
  Comando$ = "SP_BUSCA_CLIENTE "
  Comando$ = Comando$ & Str(rut) & ","
  Comando$ = Comando$ & Str(Codigo_rut)
    If SQL_Execute(Comando$) = 0 Then
      If SQL_Fetch(Datos()) = 0 Then
        Texto.Caption = Trim(Datos(1))
        FUNC_BUSCA_CLIENTE = True
      Else
        If Campo = 2 Then
          Texto.Caption = ""
          MsgBox "No Existe Cliente.", 16
        End If
      End If
    End If
End Function

Public Function FMT_DDMMYYYY(fecha) As String
  Dim lcdd, Lcmm As String * 2
  Dim lcaa As String * 4
    If fecha <> "" Then
      lcdd = Mid(fecha, 7, 2)
      Lcmm = Mid(fecha, 5, 2)
      lcaa = Mid(fecha, 1, 4)
      FMTDDMMYYYY = lcdd & "/" & Lcmm & "/" & lcaa
    Else
      FMTDDMMYYYY = ""
    End If
End Function

Function FORMATODBL(Texto As Control) As Double
  Dim Tpaso$, i%
    If TypeOf Texto Is Label Then
      Tpaso$ = Texto.Caption
    Else
      Tpaso$ = Texto.Text
    End If

    For i% = 1 To Len(Tpaso$)
      If Mid(Tpaso$, i%, 1) = "0" Then Mid(Tpaso$, i%, 1) = " " Else Exit For
    Next i%

    If Trim(Tpaso$) = "" Then
      FORMATODBL = 0#
    Else
      FORMATODBL = CDbl(Tpaso$)
    End If
End Function

Sub CargaMenu(Sistema As String, Formulario As Object)
  Dim i%
  Dim sOpcion As String * 50
  Dim nOpcion As String * 20
  On Error GoTo oError
  Open "C:\" + Sistema + ".TXT" For Output As #1
    For i% = 0 To Formulario.Controls.Count - 1
      If TypeOf Formulario.Controls(i%) Is Menu Then
        If Left(Formulario.Controls(i%).Caption, 1) <> "-" Then
          nOpcion = Formulario.Controls(i%).Name
          sOpcion = String(Formulario.Controls(i%).HelpContextID, ".") & String(Formulario.Controls(i%).HelpContextID, ".") & Left(Tran(Formulario.Controls(i%).Caption) & Space(50), 50)
          Print #1, sOpcion & nOpcion & Left(CStr(Formulario.Controls(i%).Index) & "  ", 2)
        End If
      End If
    Next
  Close #1
  Exit Sub
oError:
  If Err.Number = 343 Then
    Print #1, sOpcion & nOpcion & "  "
    Resume Next
  End If
End Sub

Private Function Tran(strin As String)
  Dim sTran$
  sTran = ""
    For i% = 1 To Len(strin)
      If Mid(strin, i%, 1) <> "&" Then
        sTran = sTran & Mid(strin, i%, 1)
      End If
    Next
  Tran = sTran
End Function

Function FORMATOLNG(Texto As Control) As Long
  Dim Tpaso$, i%
    If TypeOf Texto Is Label Then
      Tpaso$ = Texto.Caption
    Else
      Tpaso$ = Texto.Text
    End If
    
    For i% = 1 To Len(Tpaso$)
      If Mid(Tpaso$, i%, 1) = "0" Then Mid(Tpaso$, i%, 1) = " " Else Exit For
    Next i%

    If Trim(Tpaso$) = "" Then
      FORMATOLNG = 0#
    Else
      FORMATOLNG = CLng(Tpaso$)
    End If
End Function


Public Function BacEncript(sPassword$, bEncript As Boolean) As String
  Const LEN_PSW = 15
  Const KEY_PSW = "jm*sx/ch^yr<=ze"
  Const nMAGIC1 = 5
  Const nMAGIC2 = 11
  Const nMAGIC3 = 253
  Dim iDir%, jDir%, kDir%, nAnt%, nAsc%, nKey%, nPsw%, cPsw$
  nAnt% = nMAGIC1
  jDir% = IIf(bEncript, Len(sPassword$), 1)
  kDir% = 0
    For iDir% = 1 To Len(sPassword$)
      If iDir% > LEN_PSW Then kDir% = 1 Else kDir% = kDir% + 1
        nAsc% = Asc(Mid$(sPassword$, jDir%, 1))
        nKey% = Asc(Mid$(KEY_PSW$, kDir%, 1))
        nPsw% = nAsc% Xor nKey% Xor nAnt% Xor ((i% / nMAGIC2) Mod nMAGIC3)
          If bEncript Then
            cPsw$ = cPsw$ & Chr$(nPsw%)
            nAnt% = nAsc%
            jDir% = jDir% - 1
          Else
            cPsw$ = Chr$(nPsw%) & cPsw$
            nAnt% = nPsw%
            jDir% = jDir% + 1
          End If
    Next
  BacEncript = cPsw$
End Function

Public Function BacExtraer(ByRef sBuff$) As String
  Dim iPos%
  iPos% = InStr(sBuff$, "|")
    If iPos% > 0 Then
      BacExtraer = Mid$(sBuff$, 1, iPos% - 1)
      sBuff$ = Mid$(sBuff$, iPos% + 1)
    Else
      BacExtraer = sBuff$
      sBuff$ = ""
    End If
End Function

Public Function BacStrTran(sCadena$, sFind$, sReplace$) As String
'Función que quita las comas dependiendo del formato windows
'Al SqlServer no se le puede pasar un valor numérico con comas
  Dim iPos%
  Dim iLen%
    If Trim$(sCadena$) = "" Then
      sCadena$ = "0"
    End If
  iPos% = 1
  iLen% = Len(sFind$)
    Do While True
      iPos% = InStr(1, sCadena$, sFind$)
        If iPos% = 0 Then Exit Do
      sCadena$ = Mid$(sCadena$, 1, iPos% - 1) + sReplace$ + Mid$(sCadena$, iPos% + iLen%)
    Loop
  BacStrTran = Trim$(CStr(sCadena$))
End Function

Public Function BacDiaSemana(sfec$) As String
  BacDiaSem = ""
    If IsDate(sfec$) Then
      BacDiaSem = Mid("Domingo   Lunes     Martes    Miércoles Jueves    Viernes   Sábado", (WeekDay(sfec$) * 10) - 9, 10)
    End If
End Function

'Public Sub BacLLenaComboMes(cbx As ComboBox)
'  cbx.Clear
'  cbx.AddItem "Enero"
'  cbx.ItemData(cbx.NewIndex) = 1
'  cbx.AddItem "Febrero"
'  cbx.ItemData(cbx.NewIndex) = 2
'  cbx.AddItem "Marzo"
'  cbx.ItemData(cbx.NewIndex) = 3
'  cbx.AddItem "Abril"
'  cbx.ItemData(cbx.NewIndex) = 4
'  cbx.AddItem "Mayo"
'  cbx.ItemData(cbx.NewIndex) = 5
'  cbx.AddItem "Junio"
'  cbx.ItemData(cbx.NewIndex) = 6
'  cbx.AddItem "Julio"
'  cbx.ItemData(cbx.NewIndex) = 7
'  cbx.AddItem "Agosto"
'  cbx.ItemData(cbx.NewIndex) = 8
'  cbx.AddItem "Septiembre"
'  cbx.ItemData(cbx.NewIndex) = 9
'  cbx.AddItem "Octubre"
'  cbx.ItemData(cbx.NewIndex) = 10
'  cbx.AddItem "Noviembre"
'  cbx.ItemData(cbx.NewIndex) = 11
'  cbx.AddItem "Diciembre"
'  cbx.ItemData(cbx.NewIndex) = 12
'  cbx.ListIndex = -1
'End Sub

Public Function BacValidaRut(rut As String) As Boolean
  Dim dig As String
  Dim i       As Integer
  Dim d       As Integer
  Dim Divi    As Long
  Dim Suma    As Long
  Dim Digito  As String
  Dim multi   As Double
  dig = Right(rut, 1)
  BacValidaRut = False
    If Trim$(rut) = "" Or Trim$(dig) = "" Then
      Exit Function
    End If
  rut = Format(rut, "00000000")
  d = 2
    For i = 8 To 1 Step -1
      multi = Val(Mid$(rut, i, 1)) * d
      Suma = Suma + multi
      d = d + 1
        If d = 8 Then
          d = 2
        End If
    Next i
  Divi = (Suma \ 11)
  multi = Divi * 11
  Digito = Trim$(Str$(11 - (Suma - multi)))
    If Digito = "10" Then
      Digito = "K"
    End If
    
    If Digito = "11" Then
      Digito = "0"
    End If
    
    If Trim$(UCase$(Digito)) = UCase$(Trim$(dig)) Then
      BacValidaRut = True
    End If
End Function

Public Sub BacControlWindows(n%)
  Dim i%
    For i% = 1 To n%
      DoEvents
    Next
End Sub

Function fmtFecha_2000(fecha As Control) As Boolean
  fmtFecha_2000 = False

   'If Trim$(Fecha) = "/  /" Then
   '   MsgBox "No se Ha Ingresado la Fecha"
   '   Fecha.SetFocus
   '   Exit Function
   'End If
   
  If Not IsDate(fecha) Then
    MsgBox "La Fecha Ingresada NO es Correcta", vbCritical '16, "Cheque el Año"
    'Fecha.SetFocus
    Exit Function
  End If
  If Val(Mid$(fecha, 9, 2)) >= 70 And Val(Mid$(fecha, 9, 2)) <= 99 Then
    fecha = Format(fecha, "dd/mm/yyyy")
  ElseIf Val(Mid$(fecha, 7, 2)) >= 70 And Val(Mid$(fecha, 7, 2)) <= 99 Then
    fecha = Format(fecha, "dd/mm/yyyy")
  Else
'      Fecha.Text = t(Fecha, "dd/mm/yyyy")
  End If
  fmtFecha_2000 = True
End Function

Function TransFechas(fecha As String) As String
  Dim NuevaFecha$
  Dim AMes As Variant
  Dim ADia As Variant
  TransFechas = fecha
  AMes = Array("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre")
  ADia = Array("Lunes", "Martes", "Miercoles", "Jueves", "Viernes")
  'NuevaFecha = ADia(WeekDay(Fecha) - 1) & " " & Day(Fecha) & " De " & AMes(Month(Fecha) - 1) & " " & Year(Fecha)NuevaFecha = "Santiago ," & Day(Fecha) & " De " & AMes(Month(Fecha) - 1) & " " & Year(Fecha)
  NuevaFecha = "Santiago ," & Day(fecha) & " De " & AMes(Month(fecha) - 1) & " De " & Year(fecha)
  TransFechas = NuevaFecha
End Function

Public Function BacValorizar(ByRef Ent As BacValorizaInput, ByRef Sal As BacValorizaOutput)
  'Rutina que valoriza tanto para las compras como para las ventas
  On Error GoTo ValorizarError
  Dim nError%
  Dim sql$
  BacValorizar = False
  Screen.MousePointer = 11
    If Ent.Nominal# = 0 Then
      Screen.MousePointer = 0
      Exit Function
    End If
  sql$ = "EXECUTE sp_Valorizar_Client " & Chr$(10)
  sql$ = sql$ & Ent.ModCal% & "," & Chr$(10)
  sql$ = sql$ & "'" & Ent.FecCal$ & "'," & Chr$(10)
  sql$ = sql$ & Ent.Codigo& & "," & Chr$(10)
  sql$ = sql$ & "'" & Ent.mascara$ & "'," & Chr$(10)
  sql$ = sql$ & BacFormatoSQL(Ent.MonEmi) & "," & Chr$(10)
  sql$ = sql$ & "'" & Ent.fecemi & "'," & Chr$(10)
  sql$ = sql$ & "'" & Ent.FecVen & "'," & Chr$(10)
  sql$ = sql$ & BacFormatoSQL(Ent.TasEmi) & "," & Chr$(10)
  sql$ = sql$ & BacFormatoSQL(Ent.BasEmi) & "," & Chr$(10)
  sql$ = sql$ & BacFormatoSQL(Ent.TasEst&) & "," & Chr$(10)
  sql$ = sql$ & BacFormatoSQL(Ent.Nominal#) & "," & Chr$(10)
  sql$ = sql$ & BacFormatoSQL(Ent.Tir#) & "," & Chr$(10)
  sql$ = sql$ & BacFormatoSQL(Ent.Pvp#) & "," & Chr$(10)
  sql$ = sql$ & BacFormatoSQL(Ent.Mt#)
    If SQL_Execute(sql) <> 0 Then
      GoTo ValorizarError
    End If
  Dim Datos()
    If SQL_Fetch(Datos()) = 0 Then
      nError = Val(Datos(1))
        If nError = 0 Then
          Sal.Nominal# = Val(Datos(2))
          Sal.Tir# = Val(Datos(3))
          Sal.Pvp# = Val(Datos(4))
          Sal.Mt# = Val(Datos(5))
          Sal.MtUM# = Val(Datos(6))
          Sal.Mt100# = Val(Datos(7))
          Sal.Van# = Val(Datos(8))
          Sal.Vpar# = Val(Datos(9))
          Sal.Numucup% = Val(Datos(10))
          Sal.Fecucup$ = Datos(11)
          Sal.Intucup# = Val(Datos(12))
          Sal.Amoucup# = Val(Datos(13))
          Sal.Salucup# = Val(Datos(14))
          Sal.Numpcup% = Val(Datos(15))
          Sal.Fecpcup$ = Datos(16)
          Sal.Intpcup# = Val(Datos(17))
          Sal.Amopcup# = Val(Datos(18))
          Sal.Salpcup# = Val(Datos(19))
          BacValorizar = True
        Else
          Screen.MousePointer = 0
          MsgBox Datos(2), 48, "Valorizador"
          Exit Function
        End If
    End If
  Screen.MousePointer = 0
  Exit Function
ValorizarError:
  Screen.MousePointer = 0
    If Err <> 0 Then
      MsgBox error(Err)
    End If
  Exit Function
End Function

Sub BacCaracterNumerico(ByRef KeyAscii As Integer)
'--------------------------------------------------------------
'Validación de ingreso de datos para Números con decimales
'--------------------------------------------------------------
    'si <> Enter <> BackSpace <> .
    If KeyAscii <> 13 And KeyAscii <> 8 And KeyAscii <> 46 Then
        'Si no es numerico
        If Not IsNumeric(Chr$(KeyAscii)) Then
            KeyAscii = 0
        End If
    End If
End Sub

Sub BacCaracterAlfanumerico(ByRef KeyAscii As Integer)
  If KeyAscii <> 13 And KeyAscii <> 8 Then
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
  End If
End Sub

Sub BacToUCase(ByRef KeyAscii As Integer)
'Convierte el caracter a mayuscula y devuelve el codigo asccii
'97=a ---- 122=z
  If KeyAscii >= 97 Or KeyAscii <= 122 Then
    KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
  End If
End Sub

Public Function BacFormatoSQL(ByVal Numero As Double) As String
  Dim sCadena$
  sCadena = Str$(CDbl(Numero))
  BacFormatoSQL = sCadena$
End Function

Function BacNumeroVentana(TipOpe As String) As Integer

'Calcula el numero de ventana que corresponde
'En el Tag de guarda el tipo de ventana (Ej.: CP,CI,...) mas el correlativo
'de la ventana (CP01,CI03)
'De hecho el gcNumeroMaximo de ventanas debe ser menor a 10 y mayor a uno
'Devuelve 0 si excedió el numero maximo de ventanas

Dim i%, Contador%, NumeroActual%
Dim FormTag As String

    Contador% = 0
    For i% = 1 To Forms.Count
        FormTag = Forms(i% - 1).Tag
        If Mid$(FormTag, 1, 2) = TipOpe Then
            Contador% = Contador% + 1
            NumeroActual% = Val(Mid$(FormTag, 3, 2))
        End If
    Next i%
    
    If Contador% > gcMaximoVentanas Then
        MsgBox "NUMERO MAXIMO DE VENTANAS ABIERTAS EXCEDIDO", 48, "MENSAJE"
        BacNumeroVentana = 0
    Else
        If Contador% = 0 Then
            BacNumeroVentana = 1
        Else
            BacNumeroVentana = NumeroActual% + 1
        End If
    End If

End Function

Public Function ChequeaSerie(ByVal cInstser As String, ByRef Pap As Papeles)
'Funcion común para compras propias y compras con pacto
  On Error GoTo BacErrorHandler
  Dim sql$
  ChequeaSerie = False
  sql$ = "EXECUTE sp_chkinstser  '" & cInstser & "'" '," & variable & "'"
    If SQL_Execute(sql) <> 0 Then
      MsgBox "SERIE NO PUDO SER VALIDADA", 48, "Series"
      Exit Function
    End If
  ChequeaSerie = True
  Dim Datos()
    If SQL_Fetch(Datos()) = 0 Then
      Entrada% = Val(Datos(1))
        If Entrada% = 0 Then
          With Pap
            .cMascara = UCase(Datos(2))
            .nCodigo = Val(Datos(3))
            .cSerie = Datos(4)
            .cRut = Val(Datos(5))
            .nMonemi = Val(Datos(6))
            .nTasemi = Val(Datos(7))
            .nBasemi = Val(Datos(8))
            .dFecemi = Datos(9)
            .dFecven = Datos(10)
            .cRefnomi = Datos(11)
            .cGenemi = Datos(12)
            .cNemo = Datos(13)
            .nCortes = Val(Datos(14))
            .cSeriado = Datos(15)
            .sLecemi = Datos(16)
          End With
        Else
      'MsgBox Datos(2), 48, "Valorizador"
      'Exit Sub
          Select Case Entrada%
            Case 1: MsgBox "'DD' NO ES DIA", 48, "MENSAJE"
            Case 2: MsgBox "'MM' NO ES FECHA", 48, "MENSAJE"
            Case 3: MsgBox "'YY' NO ES AÑO", 48, "MENSAJE"
            Case 4: MsgBox "'DDMMAA' O 'AAMMDD' NO ES FECHA", 48, "MENSAJE"
            Case 5: MsgBox "' ' NO ES BLANCO", 48, "MENSAJE"
            Case 6: MsgBox "'N' NO ES NUMERO", 48, "MENSAJE"
            Case 7: MsgBox "NO COINCIDIO CON NINGUNA MASCARA", 48, "MENSAJE"
            Case 8: MsgBox "EXISTE LA MASCARA PERO NO ESTA EN FAMILIAS DE INSTRUMENTOS", 48, "MENSAJE"
            Case 9: MsgBox "EXISTE LA MASCARA PERO NO ESTA EN SERIES", 48, "MENSAJE"
            Case 10: MsgBox "NO FUE POSIBLE DETERMINAR FECHA DE VENCIMIENTO", 48, "MENSAJE"
            Case Else: MsgBox "NO SE ENCONTRO MASCARA", 48, "MENSAJE"
          End Select
        End If
    Else
      MsgBox "NO SE PUDO CHEQUEAR LA SERIE", 48, "Series"
    End If
  Exit Function
BacErrorHandler:
  MsgBox Err.Description
  Exit Function
End Function

Public Function Valorizando(ByRef Ent As ValorizaEntrada, ByRef Sal As ValorizaSalida)
'Rutina que valoriza tanto para las compras como para las ventas
  On Error GoTo ValorizarError
  Dim nError%
  Dim sql$
  Valorizando = False
  Screen.MousePointer = 11
    If Ent.Nominal# = 0 Then
      Screen.MousePointer = 0
      Exit Function
    End If
  sql$ = "EXECUTE sp_Valorizar_Client " & Chr$(10)
  sql$ = sql$ & Ent.ModCal% & "," & Chr$(10)
  sql$ = sql$ & "'" & Ent.FecCal$ & "'," & Chr$(10)
  sql$ = sql$ & Ent.Codigo& & "," & Chr$(10)
  sql$ = sql$ & "'" & Ent.mascara$ & "'," & Chr$(10)
  sql$ = sql$ & BacFormatoSQL(Ent.MonEmi) & "," & Chr$(10)
  sql$ = sql$ & "'" & Ent.fecemi & "'," & Chr$(10)
  sql$ = sql$ & "'" & Ent.FecVen & "'," & Chr$(10)
  sql$ = sql$ & BacFormatoSQL(Ent.TasEmi) & "," & Chr$(10)
  sql$ = sql$ & BacFormatoSQL(Ent.BasEmi) & "," & Chr$(10)
  sql$ = sql$ & BacFormatoSQL(Ent.TasEst&) & "," & Chr$(10)
  sql$ = sql$ & BacFormatoSQL(Ent.Nominal#) & "," & Chr$(10)
  sql$ = sql$ & BacFormatoSQL(Ent.Tir#) & "," & Chr$(10)
  sql$ = sql$ & BacFormatoSQL(Ent.Pvp#) & "," & Chr$(10)
  sql$ = sql$ & BacFormatoSQL(Ent.Mt#)
    If SQL_Execute(sql) <> 0 Then
      GoTo ValorizarError
    End If
  Dim Datos()
    If SQL_Fetch(Datos()) = 0 Then
      Entrada% = Val(Datos(1))
        If Entrada% = 0 Then
          Sal.Nominal# = Val(Datos(2))
          Sal.Tir# = Val(Datos(3))
          Sal.Pvp# = Val(Datos(4))
          Sal.Mt# = Val(Datos(5))
          Sal.MtUM# = Val(Datos(6))
          Sal.Mt100# = Val(Datos(7))
          Sal.Van# = Val(Datos(8))
          Sal.Vpar# = Val(Datos(9))
          Sal.Numucup% = Val(Datos(10))
          Sal.Fecucup$ = Datos(11)
          Sal.Intucup# = Val(Datos(12))
          Sal.Amoucup# = Val(Datos(13))
          Sal.Salucup# = Val(Datos(14))
          Sal.Numpcup% = Val(Datos(15))
          Sal.Fecpcup$ = Datos(16)
          Sal.Intpcup# = Val(Datos(17))
          Sal.Amopcup# = Val(Datos(18))
          Sal.Salpcup# = Val(Datos(19))
          Valorizando = True
        Else
          Screen.MousePointer = 0
          MsgBox Datos(2), 48, "Valorizador"
          Exit Function
        End If
    End If
  Screen.MousePointer = 0
    Exit Function
ValorizarError:
  Screen.MousePointer = 0
    If Err <> 0 Then MsgBox error(Err)
  Exit Function
End Function




Sub Resalta_Texto(objeto As Control)
'  objeto.SelStart = 0
'  objeto.SelLength = Len(objeto)
End Sub


Function FUNC_BUSCA_EMISOR(codigo_emisor As String, objeto As Control) As Variant
  Dim Datos()
  FUNC_BUSCA_EMISOR = False
  Comando$ = "SP_BUSCA_EMISOR '" + codigo_emisor + "'"
    If SQL_Execute(Comando$) = 0 Then
      If SQL_Fetch(Datos()) = 0 Then
        objeto.Caption = Datos(1)
        FUNC_BUSCA_EMISOR = True
        Exit Function
      End If
    End If
  MsgBox "No Existe Emisor", 16
End Function

Function FUNC_BUSCA_INSTRUMENTO(codigo_instrumento As String, objeto As Control) As Variant
  Dim Datos()
  FUNC_BUSCA_INSTRUMENTO = False
  Comando$ = "SP_BUSCA_INSTRUMENTO '" + codigo_instrumento + "'"
    If SQL_Execute(Comando$) = 0 Then
      If SQL_Fetch(Datos()) = 0 Then
        objeto.Caption = Datos(1)
        Serie_Unica = Datos(2)
        PosicionFecha = Datos(3)
        Seriado = Datos(4)
        Tabla_Desarrollo = Datos(5)
        Tabla_Premio = Datos(6)
        Emisor_Fijo = Datos(7)
        Emisor_Banco = Datos(8)
        FUNC_BUSCA_INSTRUMENTO = True
        Exit Function
      End If
    End If
  MsgBox "No Existe Instrumento", 16
End Function



Function FUNC_BUSCA_RUT_CORREDORA(Bolsa As String, Codigo As String) As Long
  Dim Datos()
  Comando$ = "SP_BUSCA_RUT_CORREDORA "
  Comando$ = Comando$ & "'" & Bolsa & "',"
  Comando$ = Comando$ & "'" & Codigo & "'"
  FUNC_BUSCA_RUT_CORREDORA = 0
    If SQL_Execute(Comando$) = 0 Then
      If SQL_Fetch(Datos()) = 0 Then
        FUNC_BUSCA_RUT_CORREDORA = Val(Datos(1))
      End If
    End If
End Function

Function FUNC_BUSCA_GEN_VALORES(Tipo As String) As Double
  Dim Datos()
  FUNC_BUSCA_GEN_VALORES = 0#
  Comando$ = "SP_BUSCA_VALORES '" + Tipo + "'"
    If SQL_Execute(Comando$) <> 0 Then
      MsgBox "Error al Buscar Valores"
      Exit Function
    End If
    If SQL_Fetch(Datos()) <> 0 Then
      MsgBox "Error al Buscar Valores"
      Exit Function
    End If
  FUNC_BUSCA_GEN_VALORES = Datos(1)
End Function


Function FUNC_BUSCA_GEN_CANAL(codigo_canal As String) As Boolean
  Dim Datos()
  FUNC_BUSCA_GEN_CANAL = False
  Comando$ = "SP_BUSCA_CANAL '" + codigo_canal + "'"
    If SQL_Execute(Comando$) = 0 Then
      If SQL_Fetch(Datos()) = 0 Then
        FUNC_BUSCA_GEN_CANAL = True
        Exit Function
      End If
    End If
  MsgBox "No Existe Canal", 16
End Function
