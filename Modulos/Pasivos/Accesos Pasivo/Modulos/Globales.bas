Attribute VB_Name = "Globales"
'Option Explicit
'-----------------------------------

' Usuario Sistema
Global Login_Usuario            As String
Global Login_Term               As String
Global Filtro_cartera           As Integer
Global CONECCION                As String
Global swConeccion              As String
'Conexion a sql server
Global gisql_databaseDBF As String
Global giSQL_ConnectionMode     As Integer
Global gsSQL_DataBase           As String
Global gsSQL_Server             As String
Global gsSQL_Login              As String
Global gsSQL_Password           As String
Global giSQL_LoginTimeOut       As Long
Global giSQL_QueryTimeOut       As Long
Global giSQL_Listados           As String
Global GbSql                    As String
Global GbDatos()

'Conexiones de Impresión
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

'Conexión al sistema
Public gbUser_Operador          As String
Public gbPass_Operador          As String
Public gbCapt_Operador          As String * 7

Public gbCampo_Ayuda            As String
Public gbFECHA_SISTEMA          As String
Global gbRegSVS                 As String * 4
Global Tipo_Papeletas              As Integer


'Tipo de Datos de entrada para el valorizador
Type BacValorizaInput
    ModCal                      As Integer
    FecCal                      As String
    codigo                      As Long
    Mascara                     As String
    MonEmi                      As Integer
    fecemi                      As String
    FecVen                      As String
    TasEmi                      As Double
    BasEmi                      As Integer
    TasEst                      As Long
    Nominal                     As Double
    tir                         As Double
    Pvp                         As Double
    Mt                          As Double
End Type

'Tipo de Datos de Salida para el valorizador
Type BacValorizaOutput
    Nominal                     As Double
    tir                         As Double
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
    codigo                      As Long
    Mascara                     As String
    MonEmi                      As Integer
    fecemi                      As String
    FecVen                      As String
    TasEmi                      As Double
    BasEmi                      As Integer
    TasEst                      As Long
    Nominal                     As Double
    tir                         As Double
    Pvp                         As Double
    Mt                          As Double

End Type

'Tipo de Datos de Salida para el valorizador
Type ValorizaSalida
    Nominal                     As Double
    tir                         As Double
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

'Constantes Para la Tabla de Clientes
'------------------------------------
Global Const MDCL_TIPOCLIENTE = 7
Global Const MDCL_SECECONOMICO = 8

'Constantes Para La Tabla de Emisores
'------------------------------------
Global Const MDEM_TIPOEMISOR = 10

'Constantes Para la Tabla de Monedas
'-----------------------------------
Global Const MDMN_PERIODO = 16
Global Const MDMN_BASE = 11
Global Const MDMN_TIPOMONEDA = 17

'Constantes Para la Tabla de Feriados
'------------------------------------
Global Const MDFE_PLAZA = 15

'Constantes para la tabla de instrumentos
'--------------------------------------------
Global Const MDIN_BASES = 11
Global Const MDIN_TIPOFECHA = 20
Global Const MDIN_TIPO = 19
Global Const MDIN_EMISION = 21


'Constantes Para la Tabla de Series
'--------------------------------------------
Global Const MDSE_TIPOAMORTIZACION = 12
Global Const MDSE_TIPOPERIODO = 16

'----------------------------------------------------------
'Toma el valor desde la ayuda para el codigo de Emisor
Global gsCodigo$

'----------------------------------------------------------
'Valor de Pantalla, control Aceptar


' Colores para Grillas
Global Const G_COLOR_AZUL = &H800000
Global Const G_COLOR_VERDE = &HC0C000
Global Const G_COLOR_PLOMO = &H808080
Global Const G_COLOR_BLANCO = vbWindowBackground
Global Const G_COLOR_NEGRO = &H80000008
Global Const G_COLOR_CLARO = &HC0FFFF
Global Const G_COLOR_ROJO = &H80&
Global Const G_COLOR_PLOMO_CLARO = &HC0C0C0

' Datos Generales de la Operacion PANTALLA DE OPERACIONES
Type Estr_Datos_Operacion
    Monto_Operacion             As Double
    Tasa_Pacto                  As Double
    Dias_Pacto                  As Integer
    Base_Pacto                  As Integer
    Moneda_Pacto                As String * 3
    Fecha_Vencimiento           As String * 10
    Monto_Inicio                As Double
    Monto_Final                 As Double
    Monto_por_Asignar           As Double
    Rut_Cliente                 As Long
    Codigo_rut                  As Integer
    Agente                      As String * 6
    Sucursal                    As Integer
    Tipo_Liquidacion            As String * 4
    Retiro                      As String * 4
    Forma_Pago                  As String * 4
    Forma_Pago_Vcto             As String * 4
End Type

Type Estr_Datos_Nemotecnico
    Instrumento                 As String * 6
    Moneda_Emision              As String * 3
    Emisor                      As String * 6
    Serie                       As String * 12
    Fecha_Emision               As String * 10
    Fecha_Vencimiento           As String * 10
    Numero_cortes               As Integer
    Monto_corte                 As Double
    Corte_minimo                As Double
End Type

Type Estr_Gen_Parametros
    Fec_ayer_gen                As String * 10
    Fec_hoy_gen                 As String * 10
    Fec_manana_gen              As String * 10
    Fec_ayer_adm                As String * 10
    Fec_hoy_adm                 As String * 10
    Fec_manana_adm              As String * 10
    Fec_ayer_accion             As String * 10
    Fec_hoy_accion              As String * 10
    Fec_manana_accion           As String * 10
    Rut_Corredora               As Long
    Fecha_ultimo_Mercado        As String * 10
    Emisor_Central              As String * 6
    Codigo_rut                  As Integer
    Codigo_svs                  As String * 6
    Agente                      As String * 5
    Sucursal                    As Integer
    Codigo_Comercio             As String * 4
    Codigo_Valparaiso           As String * 4
    Codigo_Electronica          As String * 4
    Emisor_Corredora            As String * 6
    Razon_Social                As String * 70
    Monto_Minimo_Pactos         As Double
    Moneda_Monto_Minimo         As String * 4
    Ano_Voucher_Apertura        As Integer
End Type

Global Gen_Parametros           As Estr_Gen_Parametros

Type Estr_Detalle_Voucher
    tipo                   As Integer
    Numero              As Double
    Correlativo          As Long
    Cuenta              As String * 12
    Tipo_Monto        As String * 1
    Monto               As String
    Centro_Costo     As String * 6
    Referencia          As Double
    Fecha_Ingreso   As String * 10
End Type

Global Con_Detalle()      As Estr_Detalle_Voucher

Global WSX As Workspace
Global DBX As Database
Global WS As Workspace
Global DB As Database
Global gsMDB_Path As String
Global gsMDB_Database As String
Global gsRpt_Path As String

'-----------------------------------------------------------

Global Serie_Unica              As String
Global PosicionFecha
Global Seriado
Global Instrumento              As String
Global Tabla_Desarrollo         As String
Global Tabla_Premio             As String
Global Emisor_Fijo              As String
Global Emisor_Banco             As String
Global Datos_Nemotecnico        As Estr_Datos_Nemotecnico
Global Cont                     As Long         'Variable de impresion

' Ayuda de Clientes
Global Glob_Rut_Cliente         As Long
Global Glob_Codigo_Rut          As Integer

' Ayuda General
Global Glob_Registro_Ayuda      As String
Global Glob_Archivo_Ayuda       As String
Global Glob_Filtro_Ayuda        As String
Global Glob_Registro_Ayuda_Linea As String

Type Nemotecnico
     Nemote                     As String * 12
End Type

Global CreaSerie()              As Nemotecnico
Global CantLineas               As Long

'Variable de paso entre pantalla de operaciones y Crea Cliente rápido
Global Razon_Social             As String


Function FUNC_CARGA_CONFIGURACION() As Variant

gsSQL_DataBase = FUNC_LEE_ARCHIVO_INI("Conexion", "Database")
gsSQL_Server = FUNC_LEE_ARCHIVO_INI("Conexion", "Server")
gsSQL_Login = FUNC_LEE_ARCHIVO_INI("Conexion", "Login")
gsSQL_Password = FUNC_LEE_ARCHIVO_INI("Conexion", "Password")
giSQL_LoginTimeOut = Val(FUNC_LEE_ARCHIVO_INI("Conexion", "LoginTimeOut"))
giSQL_QueryTimeOut = Val(FUNC_LEE_ARCHIVO_INI("Conexion", "QueryTimeOut"))
giSQL_ConnectionMode = Val(FUNC_LEE_ARCHIVO_INI("Conexion", "ConnectionMode"))

FUNC_CARGA_CONFIGURACION = True

End Function
Function FUNC_LEE_ARCHIVO_INI(item As String, campo_item As String) As String

Dim campo_retorno As String * 50: campo_retorno = ""

If 0 = GetPrivateProfileString(item, campo_item, "", campo_retorno, Len(campo_retorno), App.Path + "\BddAdmin.ini") Then
   MsgBox "NO Puede Leer BddAdmin.ini", vbCritical
   End
End If

'If campo_item = "Password" Then
'   retorno$ = BacEncript(FUNC_QUITA_NULOS(campo_retorno), False)
'Else
   retorno$ = FUNC_QUITA_NULOS(campo_retorno)
'End If
   
FUNC_LEE_ARCHIVO_INI = retorno$

End Function
Function FUNC_QUITA_NULOS(campo As String) As String

For I% = Len(campo) To 1 Step -1
    If Asc(Mid(campo, I%, 1)) = 0 Then
       Mid(campo, I%, 1) = Space(1)
    End If
Next I%

FUNC_QUITA_NULOS = Trim(campo)

End Function
Function FUNC_BORRA_PAGOS_OPERACION(Origen As String, Tipo_Operacion As String, Operacion As Long, Numero_Orden As Long, Tipo_Pago As String) As Boolean

Dim Datos()

FUNC_BORRA_PAGOS_OPERACION = False

Envia = Array(Origen, _
               Tipo_Operacion, _
               Str(Operacion), _
               Str(Numero_Orden), _
               Tipo_Pago _
               )

If Not BAC_SQL_EXECUTE("SP_BORRA_PAGOS_OPERACION ", Envia) Then
   
   MsgBox "Error al Anular Pagos", 16
   Exit Function
   
End If

If BAC_SQL_FETCH(Datos()) Then
   If Datos(1) <> "OK" Then
      MsgBox Datos(2), vbCritical
      Exit Function
   End If
Else
   MsgBox "Error al Anular Pagos de Operación", vbCritical
   Exit Function
End If

FUNC_BORRA_PAGOS_OPERACION = True

End Function


Sub PROC_MARCA_FILA_GRILLA(Objeto_grid As Object, Color1, Color2, Fila, Columna)

Objeto_grid.Row = Fila
OldCol% = Objeto_grid.Col

For K& = Columna To Objeto_grid.Cols - 1
    Objeto_grid.Col = K&
    Objeto_grid.CellBackColor = Color1
    Objeto_grid.CellForeColor = Color2
Next K&
Objeto_grid.Col = OldCol%

End Sub
Function FUNC_DIVD(p1 As Double, p2 As Double) As Double

If p2# = 0# Then
   FUNC_DIVD = 0#
Else
   FUNC_DIVD = p1# / p2#
End If

End Function
Function FUNC_POSICION_COMBO(Cmb_Control As Object, Texto As String, Posicion As Integer) As Integer

FUNC_POSICION_COMBO = 0

For I% = 0 To Cmb_Control.ListCount - 1
    Cmb_Control.ListIndex = I%
    If Trim(Mid(Cmb_Control.Text, 1, Posicion)) = Trim(Texto) Then
       Encontro = True
       FUNC_POSICION_COMBO = I%
       Exit For
    End If
Next I%
 
End Function
Sub PROC_LLENA_STATUS_BAR(Stat As Object, Pict As Object)

'Stat.Panels(1) = FMT_DATE(Gen_Parametros.Fec_hoy_gen)
'Stat.Panels(2) = Login_Usuario
'Stat.Panels(1).Alignment = 0
'Stat.Panels(2).Alignment = 1

'Pict.Picture = Menu_Principal.Pict_Logo.Picture

End Sub
Function FUNC_VALIDA_CONTROL_PANTALLA(tipo As String) As Variant
FUNC_VALIDA_CONTROL_PANTALLA = False

    If (tipo = "Grabar" And Control_Pantalla.Grabar <> "S") Or _
        (tipo = "Imprimir" And Control_Pantalla.Imprimir <> "S") Or _
        (tipo = "Procesar" And Control_Pantalla.Procesar <> "S") Or _
        (tipo = "Anular" And Control_Pantalla.Anular <> "S") Or _
        (tipo = "Eliminar" And Control_Pantalla.Eliminar <> "S") Then
        MsgBox "No posee Privilegios, consulte a su administrador", vbInformation
        Exit Function
    End If

FUNC_VALIDA_CONTROL_PANTALLA = True
End Function

'Sub PROC_VALORIZA_PAPEL(Calcula_valor As String, Fecha_Proceso As String, Nemotecnico As String, ByRef Nominal As Double, ByRef tir As Double, ByRef Pvc As Double, ByRef Tasa_estimada As Double, ByRef Monto As Double)
'
'Dim Datos()
'
'Envia = Array(Calcula_valor, _
'               FUNC_FMT_FECHA(Fecha_Proceso), _
'               Nemotecnico, _
'               Format(Nominal, FDecimal), _
'               Format(tir, FDecimal), _
'               Format(Pvc, FDecimal), _
'               Format(Tasa_estimada, FDecimal), _
'               Format(Monto, FEntero))
'
'If Bac_Sql_Execute("SP_VALORIZA_PAPEL_CLIENTE ", Envia) And Bac_SQL_Fetch(Datos()) Then
'
'   If Datos(1) = "NO" Then
'      MsgBox Datos(2), vbInformation, App.Title
'      Exit Sub
'   End If
'
'   Nominal = FUNC_FMT_DOUBLE((Datos(1)))
'   tir = FUNC_FMT_DOUBLE((Datos(2)))
'   Pvc = FUNC_FMT_DOUBLE((Datos(3)))
'   Tasa_estimada = FUNC_FMT_DOUBLE((Datos(4)))
'   Monto = FUNC_FMT_DOUBLE((Datos(5)))
'
'   ' LLENA ESTRUCTURA VALORIZADOR (DEFINIDA GLOBAL)
'
'   Valorizador.Nemotecnico = Nemotecnico
'   Valorizador.Nominal = Nominal
'   Valorizador.tir = tir
'   Valorizador.Pvc = Pvc
'   Valorizador.Tasa_estimada = Tasa_estimada
'   Valorizador.Monto = Monto
'   Valorizador.Monto_UM = FUNC_FMT_DOUBLE((Datos(6)))
'   Valorizador.Numero_cupon = Val(Datos(7))
'   Valorizador.Fecha_cupon = Trim(Datos(8))
'   Valorizador.Interes_cupon = FUNC_FMT_DOUBLE((Datos(9)))
'   Valorizador.Amortiza_cupon = FUNC_FMT_DOUBLE((Datos(10)))
'   Valorizador.Saldo_cupon = FUNC_FMT_DOUBLE((Datos(11)))
'
'End If
'
'End Sub

Sub PROC_LLENA_COMBO(Archivo As String, Obj_Combo As Object, Filtro As String, Largo As Integer)
Dim Datos()

Envia = Array(Trim(Archivo), _
               Trim(Filtro))

If BAC_SQL_EXECUTE("SP_CONSULTA_TABLAS ", Envia) Then
   
   Obj_Combo.Clear
   
   Do While BAC_SQL_FETCH(Datos())
      
      If Archivo = "GEN_INDICADOR" Then
         
         Obj_Combo.AddItem FUNC_LARGO_ST((Datos(1)), Largo) & " " & Format(Datos(3), "000") + " " + Datos(2)
      
      Else
         
         Obj_Combo.AddItem FUNC_LARGO_ST((Datos(1)), Largo) & " " & Datos(2)
      
      End If
   
   Loop
   
   If Obj_Combo.ListCount <> 0 Then Obj_Combo.ListIndex = 0

End If

End Sub
Sub PROC_BARRA_GRILLA(Objeto_grid As Object)

Objeto_grid.Redraw = False
col_g% = Objeto_grid.Col
For I% = 0 To Objeto_grid.Cols - 1
    Objeto_grid.Col = I%
    If CLng(Objeto_grid.CellBackColor) = CLng(vbHighlight) Then
       Objeto_grid.CellBackColor = vbWindowBackground
       Objeto_grid.CellForeColor = &H80000008
    Else
       Objeto_grid.CellBackColor = vbHighlight
       Objeto_grid.CellForeColor = &H80000009
    End If
Next I%
Objeto_grid.Col = col_g%
Objeto_grid.Redraw = True

End Sub
Sub PROC_BARRA_GRILLA2(Objeto_grid As Object, ByVal inicio As Integer)

If IsNull(inicio) Then inicio = 0

Objeto_grid.Redraw = False
col_g% = Objeto_grid.Col
For I% = inicio To Objeto_grid.Cols - 1
    Objeto_grid.Col = I%
    If CLng(Objeto_grid.CellBackColor) = CLng(vbHighlight) Then
       Objeto_grid.CellBackColor = vbWindowBackground
       Objeto_grid.CellForeColor = &H80000008
    Else
       Objeto_grid.CellBackColor = vbHighlight
       Objeto_grid.CellForeColor = &H80000009
    End If
Next I%
Objeto_grid.Col = col_g%
Objeto_grid.Redraw = True

End Sub

'Function FUNC_BUSCA_AGENTE(Codigo_Agente As String, Texto As Object, ByRef Sucursal) As Variant
'
'Dim Datos()
'
'FUNC_BUSCA_AGENTE = False
'
'Envia = Array(Codigo_Agente)
'
'If Bac_Sql_Execute("SP_BUSCA_AGENTES", Envia) Then
'
'   If Bac_SQL_Fetch(Datos()) Then
'
'      Texto.Caption = Datos(1)
'      Sucursal = Datos(2)
'
'      FUNC_BUSCA_AGENTE = True
'
'      Exit Function
'
'   End If
'
'End If
'
'Texto.Caption = ""
'MsgBox "No Existe Agente.", 16
'
'End Function

'Function FUNC_BUSCA_BANCO(Codigo_Banco As String, Texto As Object) As Variant
'
'Dim Datos()
'
'FUNC_BUSCA_BANCO = False
'
'Envia = Array(Codigo_Banco)
'
'If Bac_Sql_Execute("SP_BUSCA_BANCO", Envia) Then
'
'   If Bac_SQL_Fetch(Datos()) Then
'      Texto.Caption = Datos(1)
'
'      FUNC_BUSCA_BANCO = True
'
'      Exit Function
'
'   End If
'
'End If
'
'Texto.Caption = ""
'MsgBox "No Existe Banco.", 16
'
'End Function

'Sub PROC_BUSCA_DENOMINACION_CORTE(Nominal As Double)
'Dim Datos()
'
'Envia = Array(Trim(Datos_Nemotecnico.Serie), _
'              Format(Nominal, FDecimal) _
'              )
'
'If Not Bac_Sql_Execute("SP_BUSCA_DENOMINACION_CORTE", Envia) Then
'   Datos_Nemotecnico.Numero_cortes = 1
'   Datos_Nemotecnico.Monto_corte = Nominal
'   Exit Sub
'End If
'
'If Not Bac_SQL_Fetch(Datos()) Then
'   Datos_Nemotecnico.Numero_cortes = 1
'   Datos_Nemotecnico.Monto_corte = Nominal
'Else
'   Datos_Nemotecnico.Numero_cortes = Val(Datos(1))
'   Datos_Nemotecnico.Monto_corte = Datos(2)
'End If
'
'End Sub

Sub BARRA_GRID(Grilla As Object, modo As Variant)

Grilla.SelStartRow = Grilla.Row
Grilla.SelEndRow = Grilla.Row
Grilla.SelStartCol = 0
Grilla.SelEndCol = (Grilla.Cols - 1)
Grilla.HighLight = modo

End Sub

'Function FUNC_BUSCA_SUCURSAL(Codigo_Sucursal As Long, Texto As Object) As Variant
'
'Dim Datos()
'
'FUNC_BUSCA_SUCURSAL = False
'
'Envia = Array(Str(Codigo_Sucursal))
'
'If Bac_Sql_Execute("SP_BUSCA_SUCURSAL ", Envia) Then
'
'   If Bac_SQL_Fetch(Datos()) = 0 Then
'
'      Texto.Caption = Datos(1)
'
'      FUNC_BUSCA_SUCURSAL = True
'
'      Exit Function
'
'   End If
'
'End If
'
'Texto.Caption = ""
'MsgBox "No Existe Sucursal.", 16
'
'End Function

'Function FUNC_VALIDA_NEMO(Fecha_Calculo As String, Nemo As String) As Variant
'
'Dim Datos()
'
'FUNC_VALIDA_NEMO = True
'
'Envia = Array(FUNC_FMT_FECHA(Fecha_Calculo), Trim(Nemo))
'
'If Bac_Sql_Execute("SP_VALIDA_NEMOTECNICO_IRF", Envia) And Bac_SQL_Fetch(Datos()) Then
'
'   If Datos(1) = "ERROR" Then
'      MsgBox "Nemotecnico NO encontrado o mal Ingresado", vbInformation
'      FUNC_VALIDA_NEMO = False
'      Exit Function
'   End If
'
'   Datos_Nemotecnico.Instrumento = Datos(2)
'   Datos_Nemotecnico.Moneda_Emision = Datos(3)
'   Datos_Nemotecnico.Emisor = Datos(4)
'   Datos_Nemotecnico.Serie = Datos(5)
'   Datos_Nemotecnico.Fecha_Emision = Datos(6)
'   Datos_Nemotecnico.Fecha_Vencimiento = Datos(7)
'   Datos_Nemotecnico.Corte_minimo = IIf(Trim(Datos(8)) = "", 0, Datos(8))
'
'   If Datos_Nemotecnico.Corte_minimo = 0# Then Datos_Nemotecnico.Corte_minimo = 1#
'
'   If Trim(Datos_Nemotecnico.Fecha_Vencimiento) = "" Then
'      MsgBox "Nemotecnico NO Existe ó Mal Ingresado.", vbCritical
'      FUNC_VALIDA_NEMO = False
'      Exit Function
'   End If
'
'   If DateDiff("d", Gen_Parametros.Fec_hoy_gen, Datos_Nemotecnico.Fecha_Vencimiento) <= 0 Then
'      MsgBox "Instrumento Esta Vencido.", vbCritical
'      FUNC_VALIDA_NEMO = False
'      Exit Function
'   End If
'
'Else
'
'   MsgBox "No Existe Nemotecnico.", vbCritical
'
'   FUNC_VALIDA_NEMO = False
'
'End If
'
'End Function

'Function FUNC_BUSCA_VAL_INDICADOR(codigo_indicador As String, Fecha As String) As Double
'
'Dim Datos()
'
'If Trim(codigo_indicador) = "$$" Then
'   FUNC_BUSCA_VAL_INDICADOR = 1
'   Exit Function
'End If
'
'Comando$ = "SP_BUSCA_VAL_INDICADOR "
'Comando$ = Comando$ & "'" & codigo_indicador & "',"
'Comando$ = Comando$ & "'" & FUNC_FMT_FECHA(Fecha) & "'"
'
'Envia = Array(codigo_indicador, _
'               FUNC_FMT_FECHA(Fecha))
'
'FUNC_BUSCA_VAL_INDICADOR = 0#
'
'If Bac_Sql_Execute("SP_BUSCA_VAL_INDICADOR ", Envia) Then
'
'   If Bac_SQL_Fetch(Datos()) Then
'
'      FUNC_BUSCA_VAL_INDICADOR = Datos(1)
'
'   End If
'
'End If
'
'End Function

Sub BORRA_GRID(Grilla As Object)

Grilla.SelStartCol = 0
Grilla.SelEndCol = (Grilla.Cols - 1)
Grilla.SelStartRow = 1
Grilla.SelEndRow = Grilla.Rows - 1
Grilla.Clip = ""
Grilla.HighLight = False


End Sub

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

'Public Function Verifica_Fecha_Feriado(Fecha As String) As String
'Dim Sql$
'Dim Datos()
'
'Envia = Array(Fecha)
'
'If Not Bac_Sql_Execute("Sp_Llama_Dias_Feriados", Envia) Then
'   Exit Function
'End If
'
'If Bac_SQL_Fetch(Datos()) Then
'   Verifica_Fecha_Feriado = Datos(1)
'End If
'
'End Function

Function FMT_DATE(p1 As Variant) As String
Static st1, st2 As String
                                                                              
st1 = Trim(Mid("Domingo  Lunes    Martes   Miercoles Jueves   Viernes  Sabado   ", ((Weekday(p1) - 1) * 9) + 1, 9))
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
Public Function BuscaCodigo(Obj As Object, Codi As Integer) As Long
        Dim F   As Long
        Dim Max As Long
        
            BuscaCodigo = -1
            
            Max = Obj.coleccion.Count
            
            For F = 1 To Max
                If Obj.coleccion(F).codigo = Codi Then
                   BuscaCodigo = F - 1
                   Exit For
                End If
            Next F

End Function
Public Function BuscaGlosa(Obj As Object, Codi As String) As Long

        Dim F   As Long
        Dim Max As Long
        
            BuscaGlosa = -1
            
            Max = Obj.coleccion.Count
            
            For F = 1 To Max
                If Trim$(Obj.coleccion(F).glosa) = Trim(Codi) Then
                   BuscaGlosa = F - 1
                   Exit For
                End If
            Next F
            
End Function
Public Function Dia_De_La_Semana(Fecha_Parametro As String) As String

    Dia_De_La_Semana = ""
    
    If IsDate(Fecha_Parametro) Then
        Select Case Weekday(Fecha_Parametro)
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
Public Function VALIDA_RUT(Rut As String, dig As String) As Integer

Dim I       As Integer
Dim D       As Integer
Dim Divi    As Long
Dim Suma    As Long
Dim digito  As String
Dim multi   As Double

    VALIDA_RUT = False
    
    If Trim$(Rut) = "" Or Trim$(dig) = "" Then
       Exit Function
    End If
    
    Rut = Format(Rut, "00000000")
    D = 2
    For I = 8 To 1 Step -1
        multi = Val(Mid$(Rut, I, 1)) * D
        Suma = Suma + multi
        D = D + 1
        If D = 8 Then
           D = 2
        End If
    Next I
    
    Divi = (Suma \ 11)
    multi = Divi * 11
    digito = Trim$(Str$(11 - (Suma - multi)))
    
    If digito = "10" Then
       digito = "K"
    End If
    
    If digito = "11" Then
       digito = "0"
    End If
    
    If Trim$(UCase$(digito)) = UCase$(Trim$(dig)) Then
       VALIDA_RUT = True
    End If

End Function
Function CHECK_RUT(Rut As Long) As String
Dim p1$

p1 = String(9 - Len(Trim(Str(Rut))), "0") + Trim(Str(Rut))

CHECK_RUT = Mid("0K987654321", (Val(Mid(p1, 1, 1)) * 4 + Val(Mid(p1, 1)) * 3 + Val(Mid(p1, 3, 1)) * 2 + Val(Mid(p1, 4, 1)) * 7 + Val(Mid(p1, 5, 1)) * 6 + Val(Mid(p1, 6, 1)) * 5 + Val(Mid(p1, 7, 1)) * 4 + Val(Mid(p1, 8, 1)) * 3 + Val(Mid(p1, 9, 1)) * 2) Mod 11 + 1, 1)
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
Dim ss As Integer

If Len(Trim(p1$)) < 8 Then
   VALTIME = False
   Exit Function
End If

hh% = Val(Mid(p1, 1, 2))
mm% = Val(Mid(p1, 4, 2))
ss% = Val(Mid(p1, 7, 2))

VALTIME = IIf((hh% >= 0 And hh% < 24) And (mm% >= 0 And mm% < 60) And (ss% >= 0 And ss% < 60), True, False)

End Function

'Public Function BuscaFecha()
'
'Dim GbSql As String
'Dim GbDatos()
'
'If Not Bac_Sql_Execute("sp_proc_buscafecha") Then
'
'   MsgBox "Error en Busqueda de Fecha", 48
'   Exit Function
'
'Else
'
'   If Bac_SQL_Fetch(GbDatos()) = 0 Then
'
'      gbFECHA_SISTEMA = CONVIERTE_FECHA(Trim(GbDatos(1)), False)
'      gbRegSVS = GbDatos(2)
'
'   Else
'
'      MsgBox "Fecha Se Encuemtra Vacia", 48
'      Exit Function
'
'   End If
'
'End If
'
'End Function

'Public Function BuscaCliente(Rut As Long, CodRut As Long) As String
'
'Dim GbSql As String
'Dim GbDatos()
'
'BusCliente = True
'
'Envia = Array(Str(Rut), Str(CodRut))
'
'If Not Bac_Sql_Execute("SP_BUSCA_CLIENTE ", Envia) Then
'   MsgBox "Error en Busqueda de Cliente", 48
'   Exit Function
'Else
'   If Bac_SQL_Fetch(GbDatos()) Then
'      Nombre_Paso = GbDatos(1)
'   Else
'      Nombre_Paso = ""
'      Exit Function
'   End If
'End If
'
'End Function

Function MONTO_ESCRITO(N As Double) As String

ReDim uni(15) As String
ReDim dec(9) As String
Dim z, Num, Var   As Variant
Dim C, D, u, v, I As Integer
Dim K

If N = 0 Or N > 1E+17 Then
   MONTO_ESCRITO = IIf(N = 0, "CERO", "*")
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

Num = String$(19 - Len(Str(Trim(N))), Space(1))
Num = Num + Trim(Str(N))
I = 1
z = ""

Do While True
   K = Mid(Num, 18 - (I * 3 - 1), 3)

   If K = Space(3) Then
      Exit Do
   End If

   C = Val(Mid(K, 1, 1))
   D = Val(Mid(K, 2, 1))
   u = Val(Mid(K, 3, 1))
   v = Val(Mid(K, 2, 2))

   If I > 1 Then
      If (I = 2 Or I = 4) And Val(K) > 0 Then
         z = " MIL " + z
      End If
      If I = 3 And Val(Mid(Num, 7, 6)) > 0 Then
         If Val(K) = 1 Then
            z = " MILLON " + z
         Else
            z = " MILLONES " + z
         End If
      End If
      If I = 5 And Val(K) > 0 Then
         If Val(K) = 1 Then
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
                     z = dec(D) + z
                  Else
                     z = dec(D) + " Y " + uni(u) + z
                  End If
      End Select
   End If

   If C > 0 Then
      If C = 1 Then
         If v = 0 Then
            z = " CIEN " + z
         Else
            z = " CIENTO " + z
         End If
      End If
      If C = 2 Or C = 3 Or C = 4 Or C = 6 Or C = 8 Then
         z = uni(C) + "CIENTOS " + z
      End If
      If C = 5 Then
         z = " QUINIENTOS " + z
      End If
      If C = 7 Then
         z = " SETECIENTOS " + z
      End If
      If C = 9 Then
         z = " NOVECIENTOS " + z
      End If
   End If

   I = I + 1
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
Public Function VALIDAFECHA(Fecha As String) As Boolean

Dim LcFecha As String
Dim dd, mm, aa As String

dd = Mid(Fecha, 1, 2)
mm = Mid(Fecha, 4, 2)
aa = Mid(Fecha, 7, 4)
LcFecha = mm & "/" & dd & "/" & aa
If Not IsDate(LcFecha) Then
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

For I% = 1 To Len(Tpaso)
    If Mid(Tpaso, I%, 1) = "0" Then Mid(Tpaso, I%, 1) = " " Else Exit For
Next I%

If Trim(Tpaso) = "" Or Trim(Tpaso) = "." Then
   FUNC_FMT_DOUBLE = 0#
Else
   FUNC_FMT_DOUBLE = CDbl(Tpaso)
End If

End Function


'Function FUNC_BLOQUEA_CARTERA(Tipo_Cartera As String, Tipo_Operacion As String, Operacion As Long, Correlativo As Integer, Estado As String, ByRef Nominal, ByRef tir, ByRef Pvc, ByRef Valor_Presente) As Integer
'Dim Datos()
'
'FUNC_BLOQUEA_CARTERA = False
'
'''''''''''''Comando$ = "SP_BLOQUEO_CARTERA "
'''''''''''''
'''''''''''''' Tipo cartera
'''''''''''''Comando$ = Comando$ + "'" + Trim(Tipo_Cartera) + "',"
'''''''''''''
'''''''''''''' Tipo Operacion
'''''''''''''Comando$ = Comando$ + "'" + Trim(Tipo_Operacion) + "',"
'''''''''''''
'''''''''''''' N. Operacion
'''''''''''''Comando$ = Comando$ + Str(Operacion) + ","
'''''''''''''
'''''''''''''' Correlativo
'''''''''''''Comando$ = Comando$ + Str(Correlativo) + ","
'''''''''''''
'''''''''''''' Estado
'''''''''''''Comando$ = Comando$ + "'" + Trim(Estado) + "'"
'
'enviac = Array(Trim(Tipo_Cartera), _
'                     Trim(Tipo_Operacion), _
'                     Str(Operacion), _
'                     Str(Correlativo), _
'                     Trim(Estado))
'
'If Not Bac_Sql_Execute("SP_BLOQUEO_CARTERA ", Envia) Then
'   MsgBox "Registro NO Bloqueado.", vbCritical
'   Exit Function
'End If
'
'If Not Bac_SQL_Fetch(Datos()) Then
'   MsgBox "Registro NO Bloqueado.", vbCritical
'   Exit Function
'Else
'   If Datos(1) = "N" Then
'      MsgBox Datos(2), vbCritical
'      FUNC_BLOQUEA_CARTERA = False
'      Exit Function
'   End If
'   Nominal = Datos(3)
'   tir = Datos(4)
'   Pvc = Datos(5)
'   Valor_Presente = Datos(6)
'End If
'
'FUNC_BLOQUEA_CARTERA = True
'
'End Function


Sub PROC_FMT_NUMERICO(Texto As Object, NEnteros, NDecs As Integer, ByRef Tecla, Signo As String)

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
Function FUNC_FMT_FECHA(Fecha As String) As String

FUNC_FMT_FECHA = Mid(Fecha, 7, 4) + Mid(Fecha, 4, 2) + Mid(Fecha, 1, 2)

End Function
Function FUNC_LARGO_ST(Cadena As String, Largo As Integer) As String

FUNC_LARGO_ST = Mid(Trim(Cadena) + Space(Largo - Len(Trim(Cadena))), 1, Largo)

End Function
Sub PROC_POSICIONA_TEXTO(Grilla As Object, Texto As Object, Fila As Integer, Columna As Integer)

Texto.Top = Grilla.Top
Texto.Left = Grilla.Left
Texto.Width = Grilla.ColWidth(Columna) - 60
Tope% = 0
Grilla.Row = Fila
Tope% = Grilla.Left

For I% = 0 To Columna - 1
    Tope% = Tope% + Grilla.ColWidth(I%)
Next I%

If Grilla.TopRow = 1 Then
   Posi% = Grilla.Top + (240 * Grilla.Row)
Else
   Posi% = Grilla.Top
   cfil1% = Grilla.Row - Grilla.TopRow
   For I% = 0 To cfil1%
       Posi% = Posi% + 240
   Next I%
End If

Texto.Top = Posi% + 35
Texto.Left = Tope% + 60

End Sub

'Function FUNC_BUSCA_CLIENTE(campo As Integer, Rut As Long, Codigo_rut As Integer, Texto As Object) 'As Variant
'
'Dim Datos()
'
'FUNC_BUSCA_CLIENTE = False
'
'Envia = Array(Str(Rut), Str(Codigo_rut))
'
'If Bac_Sql_Execute("SP_BUSCA_CLIENTE ", Envia) Then
'
'   If Bac_SQL_Fetch(Datos()) Then
'
'      Texto.Caption = Datos(1)
'      FUNC_BUSCA_CLIENTE = True
'
'   Else
'
'      If campo = 2 Then
'         Texto.Caption = ""
'         MsgBox "No Existe Cliente.", 16
'     End If
'
'   End If
'
'End If
'
'End Function

Public Function FMTDDMMYYYY(Fecha) As String
Dim lcdd, Lcmm As String * 2
Dim lcaa As String * 4

If Fecha <> "" Then
   lcdd = Mid(Fecha, 7, 2)
   Lcmm = Mid(Fecha, 5, 2)
   lcaa = Mid(Fecha, 1, 4)
   FMTDDMMYYYY = lcdd & "/" & Lcmm & "/" & lcaa
 Else
   FMTDDMMYYYY = ""
 End If

End Function
Function FORMATODBL(Texto As Object) As Double

Dim Tpaso$, I%

If TypeOf Texto Is Label Then
   Tpaso$ = Texto.Caption
Else
   Tpaso$ = Texto.Text
End If

For I% = 1 To Len(Tpaso$)
    If Mid(Tpaso$, I%, 1) = "0" Then Mid(Tpaso$, I%, 1) = " " Else Exit For
Next I%

If Trim(Tpaso$) = "" Then
   FORMATODBL = 0#
Else
   FORMATODBL = CDbl(Tpaso$)
End If

End Function
Function FORMATOLNG(Texto As Object) As Long

Dim Tpaso$, I%

If TypeOf Texto Is Label Then
   Tpaso$ = Texto.Caption
Else
   Tpaso$ = Texto.Text
End If

For I% = 1 To Len(Tpaso$)
    If Mid(Tpaso$, I%, 1) = "0" Then Mid(Tpaso$, I%, 1) = " " Else Exit For
Next I%

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
           nPsw% = nAsc% Xor nKey% Xor nAnt% Xor ((I% / nMAGIC2) Mod nMAGIC3)

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
   BacDiaSem = Mid("Domingo   Lunes     Martes    Miércoles Jueves    Viernes   Sábado", (Weekday(sfec$) * 10) - 9, 10)
End If

End Function
Public Sub BacLLenaComboMes(cbx As ComboBox)
   
   cbx.Clear
   
   cbx.AddItem "Enero"
   cbx.ItemData(cbx.NewIndex) = 1
   cbx.AddItem "Febrero"
   cbx.ItemData(cbx.NewIndex) = 2
   cbx.AddItem "Marzo"
   cbx.ItemData(cbx.NewIndex) = 3
   cbx.AddItem "Abril"
   cbx.ItemData(cbx.NewIndex) = 4
   cbx.AddItem "Mayo"
   cbx.ItemData(cbx.NewIndex) = 5
   cbx.AddItem "Junio"
   cbx.ItemData(cbx.NewIndex) = 6
   cbx.AddItem "Julio"
   cbx.ItemData(cbx.NewIndex) = 7
   cbx.AddItem "Agosto"
   cbx.ItemData(cbx.NewIndex) = 8
   cbx.AddItem "Septiembre"
   cbx.ItemData(cbx.NewIndex) = 9
   cbx.AddItem "Octubre"
   cbx.ItemData(cbx.NewIndex) = 10
   cbx.AddItem "Noviembre"
   cbx.ItemData(cbx.NewIndex) = 11
   cbx.AddItem "Diciembre"
   cbx.ItemData(cbx.NewIndex) = 12
   
   cbx.ListIndex = -1

End Sub
Public Function BacValidaRut(Rut As String, dig As String) As Integer

Dim I       As Integer
Dim D       As Integer
Dim Divi    As Long
Dim Suma    As Long
Dim digito  As String
Dim multi   As Double

    BacValidaRut = False
    
    If Trim$(Rut) = "" Or Trim$(dig) = "" Then
       Exit Function
    End If
    
    If CHECK_RUT(Val(Rut)) = dig Then
        BacValidaRut = True
        Exit Function
    End If
    
    
    Rut = Format(Rut, "00000000")
    
    D = 2
    For I = 8 To 1 Step -1
        multi = Val(Mid$(Rut, I, 1)) * D
        Suma = Suma + multi
        D = D + 1
        If D = 8 Then
           D = 2
        End If
    Next I
    
    Divi = (Suma \ 11)
    multi = Divi * 11
    digito = Trim$(Str$(11 - (Suma - multi)))
    
    If digito = "10" Then
       digito = "K"
    End If
    
    If digito = "11" Then
       digito = "0"
    End If
    
    If Trim$(UCase$(digito)) = UCase$(Trim$(dig)) Then
       BacValidaRut = True
    End If

End Function

Function FUNC_FMT_FECHA_2000(Fecha As Object) As Boolean

FUNC_FMT_FECHA_2000 = False

   'If Trim$(Fecha) = "/  /" Then
   '   MsgBox "No se Ha Ingresado la Fecha"
   '   Fecha.SetFocus
   '   Exit Function
   'End If
   
   If Not IsDate(Fecha) Then
      MsgBox "La Fecha Ingresada NO es Correcta", vbCritical '16, "Cheque el Año"
      'Fecha.SetFocus
      Exit Function
   End If
   
   If Val(Mid$(Fecha, 9, 2)) >= 70 And Val(Mid$(Fecha, 9, 2)) <= 99 Then
      Fecha = Format(Fecha, "dd/mm/yyyy")
   ElseIf Val(Mid$(Fecha, 7, 2)) >= 70 And Val(Mid$(Fecha, 7, 2)) <= 99 Then
      Fecha = Format(Fecha, "dd/mm/yyyy")
   Else
      Fecha = Format(Fecha, "dd/mm/20yy")
   End If
   
FUNC_FMT_FECHA_2000 = True

End Function

Function TransFechas(Fecha As String) As String
Dim NuevaFecha$
Dim AMes As Variant
Dim ADia As Variant

TransFechas = Fecha

   AMes = Array("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre")
   ADia = Array("Lunes", "Martes", "Miercoles", "Jueves", "Viernes")
   
   'NuevaFecha = ADia(WeekDay(Fecha) - 1) & " " & Day(Fecha) & " De " & AMes(Month(Fecha) - 1) & " " & Year(Fecha)NuevaFecha = "Santiago ," & Day(Fecha) & " De " & AMes(Month(Fecha) - 1) & " " & Year(Fecha)
   NuevaFecha = "Santiago ," & Day(Fecha) & " De " & AMes(Month(Fecha) - 1) & " De " & Year(Fecha)
   
TransFechas = NuevaFecha
End Function

Public Function BacValorizar(ByRef Ent As BacValorizaInput, ByRef Sal As BacValorizaOutput)

'Rutina que valoriza tanto para las compras como para las ventas

On Error GoTo ValorizarError

Dim nError%
Dim Sql$

    BacValorizar = False
    
    Screen.MousePointer = 11
    
    If Ent.Nominal# = 0 Then
        Screen.MousePointer = 0
       Exit Function
    End If
       
    Sql$ = "EXECUTE sp_Valorizar_Client " & Chr$(10)
    Sql$ = Sql$ & Ent.ModCal% & "," & Chr$(10)
    Sql$ = Sql$ & "'" & Ent.FecCal$ & "'," & Chr$(10)
    Sql$ = Sql$ & Ent.codigo& & "," & Chr$(10)
    Sql$ = Sql$ & "'" & Ent.Mascara$ & "'," & Chr$(10)
    Sql$ = Sql$ & BacFormatoSQL(Ent.MonEmi) & "," & Chr$(10)
    Sql$ = Sql$ & "'" & Ent.fecemi & "'," & Chr$(10)
    Sql$ = Sql$ & "'" & Ent.FecVen & "'," & Chr$(10)
    Sql$ = Sql$ & BacFormatoSQL(Ent.TasEmi) & "," & Chr$(10)
    Sql$ = Sql$ & BacFormatoSQL(Ent.BasEmi) & "," & Chr$(10)
    Sql$ = Sql$ & BacFormatoSQL(Ent.TasEst&) & "," & Chr$(10)
    Sql$ = Sql$ & BacFormatoSQL(Ent.Nominal#) & "," & Chr$(10)
    Sql$ = Sql$ & BacFormatoSQL(Ent.tir#) & "," & Chr$(10)
    Sql$ = Sql$ & BacFormatoSQL(Ent.Pvp#) & "," & Chr$(10)
    Sql$ = Sql$ & BacFormatoSQL(Ent.Mt#)
    
    If Not BAC_SQL_EXECUTE(Sql) Then
       GoTo ValorizarError
    End If
       
    Dim Datos()
    If BAC_SQL_FETCH(Datos()) Then
        nError = Val(Datos(1))
        If nError = 0 Then
            Sal.Nominal# = Val(Datos(2))
            Sal.tir# = Val(Datos(3))
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
           MsgBox Datos(2), 48
           Exit Function
        End If
    
    End If
   
    Screen.MousePointer = 0
  
    Exit Function
    
ValorizarError:

    Screen.MousePointer = 0

    If Err <> 0 Then
        MsgBox Error(Err)
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
    'si <> Enter y BackSpace
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

Dim I%, Contador%, NumeroActual%
Dim FormTag As String

    Contador% = 0
    For I% = 1 To Forms.Count
        FormTag = Forms(I% - 1).Tag
        If Mid$(FormTag, 1, 2) = TipOpe Then
            Contador% = Contador% + 1
            NumeroActual% = Val(Mid$(FormTag, 3, 2))
        End If
    Next I%
    
    If Contador% > gcMaximoVentanas Then
        MsgBox "NUMERO MAXIMO DE VENTANAS ABIERTAS EXCEDIDO", 48
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

Dim Sql$

    ChequeaSerie = False

    Sql$ = "EXECUTE sp_chkinstser  '" & cInstser & "'" '," & variable & "'"
    
    Envia = Array(cInstser)
    
    If Not BAC_SQL_EXECUTE("EXECUTE sp_chkinstser", Envia) Then
       MsgBox "SERIE NO PUDO SER VALIDADA", 48
       Exit Function
    End If
    
    ChequeaSerie = True
       
    Dim Datos()
    If BAC_SQL_FETCH(Datos()) Then
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
          'MsgBox Datos(2), 48
          'Exit Sub
          Select Case Entrada%
            Case 1: MsgBox "'DD' NO ES DIA", 48
            Case 2: MsgBox "'MM' NO ES FECHA", 48
            Case 3: MsgBox "'YY' NO ES AÑO", 48
            Case 4: MsgBox "'DDMMAA' O 'AAMMDD' NO ES FECHA", 48
            Case 5: MsgBox "' ' NO ES BLANCO", 48
            Case 6: MsgBox "'N' NO ES NUMERO", 48
            Case 7: MsgBox "NO COINCIDIO CON NINGUNA MASCARA", 48
            Case 8: MsgBox "EXISTE LA MASCARA PERO NO ESTA EN FAMILIAS DE INSTRUMENTOS", 48
            Case 9: MsgBox "EXISTE LA MASCARA PERO NO ESTA EN SERIES", 48
            Case 10: MsgBox "NO FUE POSIBLE DETERMINAR FECHA DE VENCIMIENTO", 48
            Case Else: MsgBox "NO SE ENCONTRO MASCARA", 48
          End Select
        End If
    Else
        MsgBox "NO SE PUDO CHEQUEAR LA SERIE", 48
    End If
    
    Exit Function

BacErrorHandler:

    MsgBox Err.Description, 16
    Exit Function

End Function

Public Function Valorizando(ByRef Ent As ValorizaEntrada, ByRef Sal As ValorizaSalida)

'Rutina que valoriza tanto para las compras como para las ventas

On Error GoTo ValorizarError

Dim nError%
Dim Sql$

    Valorizando = False
    
    Screen.MousePointer = 11
    
    If Ent.Nominal# = 0 Then
        Screen.MousePointer = 0
       Exit Function
    End If
       
    Sql$ = "EXECUTE sp_Valorizar_Client " & Chr$(10)
    Sql$ = Sql$ & Ent.ModCal% & "," & Chr$(10)
    Sql$ = Sql$ & "'" & Ent.FecCal$ & "'," & Chr$(10)
    Sql$ = Sql$ & Ent.codigo& & "," & Chr$(10)
    Sql$ = Sql$ & "'" & Ent.Mascara$ & "'," & Chr$(10)
    Sql$ = Sql$ & BacFormatoSQL(Ent.MonEmi) & "," & Chr$(10)
    Sql$ = Sql$ & "'" & Ent.fecemi & "'," & Chr$(10)
    Sql$ = Sql$ & "'" & Ent.FecVen & "'," & Chr$(10)
    Sql$ = Sql$ & BacFormatoSQL(Ent.TasEmi) & "," & Chr$(10)
    Sql$ = Sql$ & BacFormatoSQL(Ent.BasEmi) & "," & Chr$(10)
    Sql$ = Sql$ & BacFormatoSQL(Ent.TasEst&) & "," & Chr$(10)
    Sql$ = Sql$ & BacFormatoSQL(Ent.Nominal#) & "," & Chr$(10)
    Sql$ = Sql$ & BacFormatoSQL(Ent.tir#) & "," & Chr$(10)
    Sql$ = Sql$ & BacFormatoSQL(Ent.Pvp#) & "," & Chr$(10)
    Sql$ = Sql$ & BacFormatoSQL(Ent.Mt#)
    
    If Not BAC_SQL_EXECUTE(Sql) Then
       GoTo ValorizarError
    End If
       
    Dim Datos()
    If BAC_SQL_FETCH(Datos()) Then
        Entrada% = Val(Datos(1))
        If Entrada% = 0 Then
            Sal.Nominal# = Val(Datos(2))
            Sal.tir# = Val(Datos(3))
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
           MsgBox Datos(2), 48
           Exit Function
        End If
    
    End If
   
    Screen.MousePointer = 0
  
    Exit Function
    
ValorizarError:

    Screen.MousePointer = 0

    If Err <> 0 Then
        MsgBox Error(Err), 16
    End If
    Exit Function
    
End Function
Sub Resalta_Texto(objeto As Object)
    objeto.SelStart = 0
    objeto.SelLength = Len(objeto)
End Sub


'Function FUNC_BUSCA_EMISOR(codigo_emisor As String, objeto As Object) As Variant
'
'Dim Datos()
'
'FUNC_BUSCA_EMISOR = False
'
'Comando$ = "SP_BUSCA_EMISOR '" + codigo_emisor + "'"
'
'Envia = Array(codigo_emisor)
'
'If Bac_Sql_Execute("SP_BUSCA_EMISOR", Envia) Then
'
'   If Bac_SQL_Fetch(Datos()) = 0 Then
'      objeto.Caption = Datos(1)
'      FUNC_BUSCA_EMISOR = True
'
'      Exit Function
'
'   End If
'
'End If
'
'MsgBox "No Existe Emisor", 16
'
'End Function

'Function FUNC_BUSCA_INSTRUMENTO(codigo_instrumento As String, objeto As Object) As Variant
'
'Dim Datos()
'
'FUNC_BUSCA_INSTRUMENTO = False
'
'Envia = Array(codigo_instrumento)
'
'If Bac_Sql_Execute("SP_BUSCA_INSTRUMENTO", eniva) Then
'
'   If Bac_SQL_Fetch(Datos()) = 0 Then
'
'      objeto.Caption = Datos(1)
'      Serie_Unica = Datos(2)
'      PosicionFecha = Datos(3)
'      Seriado = Datos(4)
'      Tabla_Desarrollo = Datos(5)
'      Tabla_Premio = Datos(6)
'      Emisor_Fijo = Datos(7)
'      Emisor_Banco = Datos(8)
'      FUNC_BUSCA_INSTRUMENTO = True
'
'      Exit Function
'
'   End If
'
'End If
'
'MsgBox "No Existe Instrumento", 16
'
'End Function
'


'Function FUNC_BUSCA_RUT_CORREDORA(Bolsa As String, codigo As String) As Long
'
'Dim Datos()
'
'Comando$ = "SP_BUSCA_RUT_CORREDORA "
'Comando$ = Comando$ & "'" & Bolsa & "',"
'Comando$ = Comando$ & "'" & codigo & "'"
'
'Envia = Array(Bolsa, codigo)
'
'FUNC_BUSCA_RUT_CORREDORA = 0
'
'If Bac_Sql_Execute("SP_BUSCA_RUT_CORREDORA ", Envia) Then
'
'   If Bac_SQL_Fetch(Datos()) Then
'
'      FUNC_BUSCA_RUT_CORREDORA = Val(Datos(1))
'
'   End If
'
'End If
'
'End Function
'
