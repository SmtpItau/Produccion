Attribute VB_Name = "BacCalculoRec"
Option Explicit
Public EjecutaBtnREC As Boolean
Public ParamMoneda_LCR As Boolean
Public iThreshold As Double
Public iMetodologia As Integer
Public iNomCliente As String
Public iCodCliente As Long
Public iRutCliente As Long
Public iCodProd As Long
Public iResultadoREC As Double 'PROD-10967

'Public gsc_Parametros As New clsParametros


'*************************************
'Seccion propia de BacCalculoRec
'*************************************

Private FechaAnterior As Date
Const FDec4Dec = "#,##0.0000"
Const FDec2Dec = "#,##0.00"
Const FDec0Dec = "###0"
Const MailCaidaLineas = "8606"
Const MailCaidaParam = "8607"

Private Numero_Simulaciones As Long
'Constante para realizar las query
Private Conexion  As ADODB.Connection
'Constante que define la cantidad de simulaciones sobre las cuales se calulara el VaR
Const MaxNumero_Simulaciones = 300

Const Percentil = 5

Public Type Cliente_DRV
    Rut As Long
    Codigo  As Integer
    Nombre  As String
    Metodologia As Long
    Threshold As Double
End Type

Public Type Datos_Cliente_DRV
    Clie_DRV() As Cliente_DRV
End Type

Private Type MatrizMet5
    Numero_Operacion As Long
    Sistema As String
    Producto As String
    Valor_Mercado As Double
    Amortizacion As Double
    AddOn As Double
    Maximo As Double
    Prc As Double
    Plazo As Double
    ValorMoneda As Double
    LCRParMdaGruMda As String
End Type

Private Type MatrizMet2
    Numero_Operacion As Long
    Sistema As String
    Producto As String
    Valor_Mercado As Double
    Amortizacion  As Double
    AddOn As Double
    Maximo As Double
    Prc    As Double
    Plazo  As Double
    ValorMoneda As Double
    LCRParMdaGruMda As String
End Type

Private Type Valor_Mercado
    Numero_Operacion As Long
    Valor_Mercado As Double
    Sistema As String
    SistemaBAC As String
    AddOnMdaLocal   As Double
    MaxValMeryAddOn As Double
End Type

Private Type Valor_Moneda
    vmValor     As Double
    vmfecha     As Date
    vmcodigo    As Long
End Type

Private Type Valor_Moneda_Contable
    Tipo_Cambio     As Double
    Fecha           As Date
    Codigo_Moneda   As Long
End Type


Private Type Par_MonedasLcr
    LCRParMda1 As Long
    LCRParMda2 As Long
    LCRGruMdaCod As String
End Type

Private Type Producto_AsocRiesgo_PlazoMayor
    Id_sistema      As String
    Codigo_Producto As String
    LCRGruMdaCod    As String
    LCRPla          As Double
    LCRPon          As Double
    Codigo_Riesgo   As Long
End Type

Private Type Producto_AsocRiesgo_PlazoMenor
    Id_sistema      As String
    Codigo_Producto As String
    LCRGruMdaCod    As String
    LCRPla          As Double
    LCRPon          As Double
    Codigo_Riesgo   As Long
End Type


Private Type Producto_AsocRiesgo_PlazoMayor_BIDASK
    Id_sistema      As String
    Codigo_Producto As String
    LCRGruMdaCod    As String
    LCRPla          As Double
    LCRPon          As Double
    Codigo_Riesgo   As Long
    lcrTipoBID_ASK  As String
End Type

Private Type Producto_AsocRiesgo_PlazoMenor_BIDASK
    Id_sistema      As String
    Codigo_Producto As String
    LCRGruMdaCod    As String
    LCRPla          As Double
    LCRPon          As Double
    Codigo_Riesgo   As Long
    lcrTipoBID_ASK  As String
End Type



Private Type Flujos
    FechaLiquidacion As Date
    ValorMercado     As Double
End Type

Public Type Datos_Cliente
    Swap_Op_Threshold_LCR        As Double
    Swap_Op_Metodologia_LCR      As Integer
    Swap_Op_Cliente_LCR          As String
End Type

'Datos estructura para  Generar Calculo Rec
Public Type CalculaRec
    Fecha As Date
    Rut As Long
    Codigo  As Integer
    Nombre  As String
    Linea   As Double
    Treshold As Double
    Valor_Mercado As Double
    Exposicion_Maxima   As Double
    VaR90D  As Double
    Garantia_Ejecutada As String
    Consumo_Linea As Double
    Holgura As Double
    Estado_Linea As String
End Type

'B00_Swap_Estructura
Public Type Operaciones_Swap
    'Datos rescatados de consulta
    Rut As Long
    Codigo As Integer
    Numero_Operacion As Long
    Numero_flujo As Long
    Tipo_flujo As Long
    Tipo_swap As Long
    Modalidad_pago As String
    Cartera As Long
    Moneda As Long
    Moneda_Bac As Long
    Codigo_tasa As Long
    Convencion As String
    Base As Long
    PlazoFwd As Long
    IndexLag As Long
    Fecha_ini As Date
    Fecha_fin As Date
    Fecha_fija As Date
    Fecha_liq As Date
    Codigo_descuento As Long
    Codigo_forward As Long
    Tasa_flujo As Double
    Spread As Double
    Saldo As Double
    Amortizacion As Double
    Flujo_adicional As Double
    Valor_Mercado_BAC As Double
    Plazo As Long
    Duration As Double
    FlujoFuturo As Double
    'Datos calculados
    Plazo_ini As Long
    Plazo_fin As Long
    Plazo_liq As Long
    Dias As Long
    Valor_Mercado As Double
    Valor_Simulacion() As Double
    EarlyTermination As String
    
End Type
'Fin B00_Swap_Estructura

'C00_Fwd_Estructura
Public Type Operaciones_Fwd
    'Datos rescatados de consulta
    Rut As Long
    Codigo As Integer
    Numero_Operacion As Long
    Sentido_operacion As String
    Tipo_forward As Long
    Modalidad_pago As String
    Cartera As Long
    Moneda(1) As Long
    Fecha_ini As Date
    Fecha_fin As Date
    Fecha_efectiva As Date
    Fecha_fixing As Date
    Puntos_fwd As Double
    Codigo_descuento(1) As Long
    Amortizacion(1) As Double
    Valor_Mercado_BAC As Double
    Moneda_1_BAC As Long
    Moneda_2_BAC As Long
    Plazo As Long
    Duration As Double
    
    'Datos calculados
    Plazo_efectivo As Long
    Plazo_fixing As Long
    Valor_Mercado As Double
    Valor_Simulacion() As Double
    EarlyTermination As String
End Type
'Fin C00_Fwd_Estructura

Private Type Fixings
    'Datos obtenidos de consulta
    Fecha As Date
    Peso As Double
    Obs As Double
    
    'Datos calculados por macro
    Plazo As Long
End Type

'D00_Opcion_estrutura
Private Type Operaciones_Opcion
    'Datos obtenidos de consulta
    Rut As Long
    Codigo As Integer
    NumOp As Long               'Número de operación
    Cartera As Long             'Cartera
    Estructura As String        'Flag que indica si es una estructura o una operacion individual
    NumEstructura As Long       'Número dentro de la estructura
    Call_Put As String          'Flag de Call o Put
    Compra_Venta As String      'Flag de Compra o Venta
    Payoff As String            'Tipo de payoff: vanilla o asiática
    Vecto As Date               'Fecha de expiracion
    Nominal As Double           'Nominal
    X As Double                 'Strike
    Codigo_Spot As Long         'Codigo del tipo de cambio subyacente
    Cod_mon_val As Long         'Codigo de la moneda del resultado ByS
    Codigo_rd As Long           'Codigo de tasa local
    Codigo_rf As Long           'Codigo de tasa foranea
    Codigo_vol As Long          'Codigo de la superficie de volatilidad
    Valor_Mercado_BAC As Double 'Valor de Mercado en BAC
    Moneda_1_BAC As Long        'Codigo de moneda en Bac
    Moneda_2_BAC As Long        'Codigo de moneda en Bac
    Plazo_Bac As Long               'Plazo en Bac
    Duration As Double
    'Sólo opciones asiáticas
    Tabla() As Fixings          'Tabla con la información de los fixings
    
    
    'Datos calculados por macro
    Plazo As Long               'Plazo de expiración
    Valor_Mercado As Double     'Valor de mercado
    Valor_Simulacion() As Double
    EarlyTermination As String
End Type
'Fin D00_Opcion_estrutura

Private Type Carteras_AddOn
    Num_Operacion As Long
    Sistema As String
    Producto As String
    Tipo_Operacion As String
    Capital_Activo As Double
    Capital_Pasivo As Double
    Plazo_Activo As Long
    Plazo_Pasivo As Long
    Moneda_Activo As Integer
    Moneda_Pasivo As Integer
    Duration_Activo As Double
    Duration_Pasivo As Double
    Fecha_Proceso As Date
    'Monto Float
    'Prc Float
End Type

Private Type Datos_AddOn
     AddOn_Operaciones() As Carteras_AddOn
End Type


'F00_FWD_RF_estructura
Private Type Tabla_Desarrollo
    Flujo As Double
    Fecha As Date
    Plazo As Long
End Type

Public Type Operaciones_FWD_RF
    'Propiedades obtenidas de SQL
    Rut As Long
    Codigo As Integer
    Numero_Operacion As Long    'Numero de operacion
    Sentido_operacion As String 'Compra o venta
    Nemo As String              'Nemotecnico
    Cartera As Long             'Cartera a la que pertenece el instrumento
    Nominal As Double           'Nominal o principal
    Emisor As String            'Emisor
    Serie As String             'Serie, para filtro valorizacion
    Mascara As String           'Mascara, para rescatar tabla de desarrollo
    Fecha_Vecto As Date         'Fecha de Vencimiento del subyacente
    Fecha_Vecto_Fwd As Date     'Fecha de Vencimiento. Para depositos
    Tasa_Fwd As Double          'Tasa forward negociada
    Cod_Moneda As Long          'Codigo de moneda de la emision
    Cod_Tasa As Long            'Codigo de la tasa con que se descuenta
    Cod_Tasa_F As Long          'Codigo de la tasa de financiamiento
    Flujo() As Tabla_Desarrollo 'Tabla de desarrollo del instrumento
    Base As Long                'Base de calculo
    Valor_Mercado_BAC As Double 'Valor de mercado calculado por BAC
    Moneda_1_BAC As Long
    Moneda_2_BAC As Long
    Plazo_Bac As Long
    Duration As Double
    'Valores calculados en la macro
    Plazo As Long
    Valor_Mercado As Double
    Valor_Simulacion() As Double
    EarlyTermination As String
    Producto As String
End Type
'Fin F00_FWD_RF_estructura

Private Type Exp_Maxima
    Fecha As Date
    Rut As Long
    Cod As Integer
    Mtm As Double
    Operacion As Double
    EarlyTermination As String
    Tipo_Operacion As String
    Producto As String
End Type

Private Type Exp_Max_Fecha
    Max_Exp As Double
    Fecha As Date
End Type

Private Type Resultado_Exp_Max
    Result_exp_Max As Double
    Fecha_Exp_Max As Date
End Type

Private Type Procesos
    ErrorNumero          As Double
    ErrorDescripcion     As String
    ErrorSP              As String
    ErrorcargaDatos      As Boolean
End Type

'A01_Estructura_General
Public Type Negociacion

    'Almacena las fechas de los datos
    Fecha(MaxNumero_Simulaciones) As Date
    
    Threshold                  As Double
    Rut                        As Long
    Codigo                     As Integer
    Metodología                As Integer
    CLIENTE                    As String
    Exposicion_Maxima          As Double
    Fecha_Exp_Maxima           As Date
    
    'Almacena las carteras
    Cartera_Swap() As Operaciones_Swap
    Cartera_Fwd() As Operaciones_Fwd
    Cartera_Opcion() As Operaciones_Opcion
    Cartera_Fwd_RF() As Operaciones_FWD_RF
    Fecha_Exp_Max() As Exp_Max_Fecha
    Total_Exp_maxima() As Resultado_Exp_Max
    CalcRec() As CalculaRec
    'Almacena Monedas
    Par_Monedas() As Par_MonedasLcr
    Prod_AsocRiesgo_Mayor() As Producto_AsocRiesgo_PlazoMayor
    Prod_AsocRiesgo_Menor() As Producto_AsocRiesgo_PlazoMenor
    Prod_AsocRiesgo_Mayor_BIDASK() As Producto_AsocRiesgo_PlazoMayor_BIDASK
    Prod_AsocRiesgo_Menor_BIDASK() As Producto_AsocRiesgo_PlazoMenor_BIDASK
    Val_Moneda() As Valor_Moneda
    Val_Mon_Contable() As Valor_Moneda_Contable
    Val_Mercado() As Valor_Mercado
    Metodologia5() As MatrizMet5
    Metodologia2() As MatrizMet2
End Type


Private Type Exposicion_Maxima
    Exp_Max() As Exp_Maxima
End Type

Private Type DV01_Operacion
    Producto() As String
    Num_Operacion() As Long
    Matriz() As Double
    Var() As Double
    Rut() As Long
    Plazo() As Long
End Type
' Fin A01_Estructura_General

'M00_Mercado_Estructura
Private Type Tenors_Tasas
    Plazo As Long
    Tasa As Double
    dv01(3) As Double
End Type

Private Type Vector_Tasas
    Par() As Tenors_Tasas
End Type

Private Type Tabla_Datos
    Fecha As Date
    Valor As Double
End Type

Private Type Par_Vol
    Vol As Double
    Strike As Double
End Type

Private Type Tenors_Vol
    Plazo As Long
    Par(4) As Par_Vol
End Type

Private Type VolSfce
    Codigo_Moneda As Long
    Codigo_rd As Long
    Codigo_rf As Long
    Superf() As Tenors_Vol
End Type

Private Type DV01_Mon
    dv01(3) As Double
End Type

Private Type Datos_Mercado
    Fecha           As Date
    Tasas_Swap()    As Vector_Tasas
    Tasas_Opcion()  As Vector_Tasas
    Tasas_Fwd()     As Vector_Tasas
    Tasas_RF()      As Vector_Tasas
    ICP()           As Tabla_Datos
    UF()            As Tabla_Datos
    Paridad()       As Double
    TC()            As Double
    Vol()           As VolSfce
    DV01_TC()       As DV01_Mon
    IBR()           As Tabla_Datos     '-> Indicador de IBR, igualado en fechas con la UF y el ICP
End Type

Private Function AddOn_Al_Vencimiento(Cartera As Negociacion, AddOn As Datos_AddOn, iFecha As Date, Metodologia As Integer)
  
    Dim AddOn_Opciones As Double
    Dim AddOn_Carteras_Bac As Double
    'C1
    'If Metodologia = 2 Then  MAP
    'Llena Arreglo AddOn.AddOn_Operaciones,
    'para la metodologia 2 y 5
    AddOn_Al_Vencimiento_Swap Cartera, AddOn, iFecha
    'End If
    
    'Este llenando no toma los flujos adicionales
    'y los Swap Roller-coaster
    'If Metodologia = 5 Then
    '    AddOn_Al_Vencimiento_SwapMet5 cartera, AddOn, iFecha
    'End If
    
    AddOn_Al_Vencimiento_Forward Cartera, AddOn
    
    AddOn_Al_Vencimiento_Forward_RF Cartera, AddOn
    
    AddOn_Al_Vencimiento_Opciones Cartera, AddOn
    
    'C2
    AddOn_Opciones = AddOn_Consulta_Opciones(Cartera, AddOn, Metodologia)
             
    'AddOn_Al_Vencimiento = AddOn_Opciones + AddOn_Carteras_Bac
    
'   C1:  Rescate de Operaciones con los parámetros necesarios para
'   Llamar a las calculadoras de REC que aún son SP: Riesgo Potencial futuro y Calculo LCR Interno Opciones.
'
'   C2:  Ejecución de calculadoras
'   Llamar a las calculadoras de REC que aún son SP: Riesgo Potencial futuro y Calculo LCR Interno Opciones.

    'Esto calcula, para cada operacion el addOn y rescata el Valor Razonable.
    AddOn_Carteras_Bac = AddOn_Consulta_Carteras_Bac_Riesgo(Cartera, AddOn, iFecha, Metodologia)
    AddOn_Al_Vencimiento = AddOn_Carteras_Bac + AddOn_Opciones
    
End Function

Private Function AddOn_Consulta_Carteras_Bac_Riesgo(Cartera As Negociacion, AddOn As Datos_AddOn, iFecha As Date, Metodologia As Integer) As Double
   Dim i As Long
   Dim j As Long
   Dim z As Long
   
   Dim AddOnConCart As Long
   Dim AddOnErrorCart As Long
   Dim nTipoFlujo As Integer
   Dim nMaxFlujo As Integer
   Dim nMinFlujo As Integer
   Dim Capital_Activo As Long
   Dim Plazo_Activo As Double
   Dim Plazo_Pasivo As Double
   Dim InputPlazo As Double
   Dim LCRParMdaGruMda As String
   Dim Plazo1 As Double
   Dim Pond1 As Double
   Dim Plazo2 As Double
   Dim Pond2 As Double
   Dim Prc As Double
   Dim EncuentraPlazo1 As Integer
   Dim EncuentraPlazo2 As Integer
   Dim nValorMoneda As Double
   Dim Monto As Double
   
   Dim AddOnOperaciones As Long
   Dim AddOnErrorOperaciones As Long
   Dim ParMonedas As Long
   Dim ParMonedasError As Long
   Dim AsocRiesgoMenor As Long
   Dim ErrorAsocRiesgoMenor As Long
   Dim AsocRiesgoMayor As Long
   Dim ErrorAsocRiesgoMayor As Long
   
   'PRD20426
   Dim AsocRiesgoMenor_BIDASK As Long
   Dim ErrorAsocRiesgoMenor_BIDASK As Long
   Dim AsocRiesgoMayor_BIDASK As Long
   Dim ErrorAsocRiesgoMayor_BIDASK As Long
   'PRD20426
   
   Dim ValMoneda As Long
   Dim ErrorValMoneda As Long
   Dim ValMonContable As Long
   Dim ErrorValMonContable As Long
   Dim Metodologia5 As Long
   Dim ErrorMetodologia5 As Long
   Dim ContMetodologia2 As Long
   Dim ErrorContMetodologia2 As Long
   Dim Riegoproducto As String 'PRD20426
   Dim TipoOperacion As String 'PRD20426
   Dim PrioridadMoneda As Integer
    Plazo1 = 0
    Plazo2 = 0
    Pond1 = 0
    Pond2 = 0
    
    
    Call Carga_ParMonedas_Sistemas(Cartera)
    
    On Error Resume Next
        AddOnOperaciones = UBound(AddOn.AddOn_Operaciones)
        AddOnErrorOperaciones = Err.Number
    On Error GoTo 0
    
    If Not AddOnErrorOperaciones = 0 Then
        AddOnOperaciones = -1
    End If
    
    Let ContMetodologia2 = 0
    On Error Resume Next
        ContMetodologia2 = UBound(Cartera.Metodologia2)
        ErrorContMetodologia2 = Err.Number
    On Error GoTo 0
    If Not ErrorContMetodologia2 = 0 Then
        ContMetodologia2 = 0                    'Para insertar en arreglo
    Else
       Let ContMetodologia2 = ContMetodologia2 + 1 'Para insertar en arreglo
    End If
    
    
    
    On Error Resume Next
        ParMonedas = UBound(Cartera.Par_Monedas)
        ParMonedasError = Err.Number
    On Error GoTo 0
    
    If Not ParMonedasError = 0 Then
        ParMonedas = -1
    End If
    
    On Error Resume Next
        AsocRiesgoMenor = UBound(Cartera.Prod_AsocRiesgo_Menor)
        ErrorAsocRiesgoMenor = Err.Number
    On Error GoTo 0
    
    If Not ErrorAsocRiesgoMenor = 0 Then
        AsocRiesgoMenor = -1
    End If
    
    On Error Resume Next
        AsocRiesgoMayor = UBound(Cartera.Prod_AsocRiesgo_Mayor)
        ErrorAsocRiesgoMayor = Err.Number
    On Error GoTo 0
    
    If Not ErrorAsocRiesgoMayor = 0 Then
        AsocRiesgoMayor = -1
    End If
    
    'PRD20426
    On Error Resume Next
        AsocRiesgoMenor_BIDASK = UBound(Cartera.Prod_AsocRiesgo_Menor_BIDASK)
        ErrorAsocRiesgoMenor_BIDASK = Err.Number
    On Error GoTo 0
    
    If Not ErrorAsocRiesgoMenor_BIDASK = 0 Then
        AsocRiesgoMenor_BIDASK = -1
    End If
    
    On Error Resume Next
        AsocRiesgoMayor_BIDASK = UBound(Cartera.Prod_AsocRiesgo_Mayor_BIDASK)
        ErrorAsocRiesgoMayor_BIDASK = Err.Number
    On Error GoTo 0
    
    If Not ErrorAsocRiesgoMayor_BIDASK = 0 Then
        AsocRiesgoMayor_BIDASK = -1
    End If
    'PRD20426
    
    
    On Error Resume Next
        ValMoneda = UBound(Cartera.Val_Moneda)
        ErrorValMoneda = Err.Number
    On Error GoTo 0
    
    If Not ErrorValMoneda = 0 Then
        ValMoneda = -1
    End If
    
    On Error Resume Next
        ValMonContable = UBound(Cartera.Val_Mon_Contable)
        ErrorValMonContable = Err.Number
    On Error GoTo 0
    
    If Not ErrorValMonContable = 0 Then
        ValMonContable = -1
    End If
    
    Let Monto = 0 'PROD-10967
    For i = 0 To AddOnOperaciones 'UBound(AddOn.AddOn_Operaciones)
        If AddOn.AddOn_Operaciones(i).Sistema <> "OPT" Then
                    
        
            Riegoproducto = Rescata_Riesgo_Producto(AddOn.AddOn_Operaciones(i).Sistema, AddOn.AddOn_Operaciones(i).Producto) 'PRD20426
        
            nValorMoneda = 1
            Plazo_Activo = AddOn.AddOn_Operaciones(i).Plazo_Activo / 365
            Plazo_Pasivo = AddOn.AddOn_Operaciones(i).Plazo_Pasivo / 365
            
            If AddOn.AddOn_Operaciones(i).Duration_Activo = 0 Or AddOn.AddOn_Operaciones(i).Duration_Pasivo = 0 Then
                InputPlazo = AddOn.AddOn_Operaciones(i).Plazo_Activo / 365
            Else
            InputPlazo = IIf(AddOn.AddOn_Operaciones(i).Duration_Activo > AddOn.AddOn_Operaciones(i).Duration_Pasivo, _
                             AddOn.AddOn_Operaciones(i).Duration_Activo, AddOn.AddOn_Operaciones(i).Duration_Pasivo)
            End If
            
            If AddOn.AddOn_Operaciones(i).Producto = "2" And AddOn.AddOn_Operaciones(i).Sistema = "PCS" Then
                InputPlazo = AddOn.AddOn_Operaciones(i).Plazo_Activo / 365
            End If
            
            
            LCRParMdaGruMda = "MX"
             
            For j = 0 To ParMonedas 'UBound(Cartera.Par_Monedas)
                If (Cartera.Par_Monedas(j).LCRParMda1 = AddOn.AddOn_Operaciones(i).Moneda_Activo _
                   And Cartera.Par_Monedas(j).LCRParMda2 = AddOn.AddOn_Operaciones(i).Moneda_Pasivo) Or _
                   (Cartera.Par_Monedas(j).LCRParMda1 = AddOn.AddOn_Operaciones(i).Moneda_Pasivo _
                   And Cartera.Par_Monedas(j).LCRParMda2 = AddOn.AddOn_Operaciones(i).Moneda_Activo) _
                   Then
                   
                       LCRParMdaGruMda = Cartera.Par_Monedas(j).LCRGruMdaCod
                       Exit For 'MAP 08-Sep-2014 optimización
                End If
            Next
                                     
            If (Riegoproducto = "2") Then 'PRD20426
            
                If (AddOn.AddOn_Operaciones(i).Sistema = "PCS") Then
                
                    PrioridadMoneda = Rescata_Prioridad_Moneda(AddOn.AddOn_Operaciones(i).Moneda_Activo, AddOn.AddOn_Operaciones(i).Moneda_Pasivo)
                    
                    If PrioridadMoneda = AddOn.AddOn_Operaciones(i).Moneda_Activo Then
                        TipoOperacion = "C"
                    Else
                        TipoOperacion = "V"
                    End If
                                       
                Else
                
                    TipoOperacion = AddOn.AddOn_Operaciones(i).Tipo_Operacion
                
                End If
            
                                                 
                EncuentraPlazo1 = 0
                For j = 0 To AsocRiesgoMenor_BIDASK 'UBound(Cartera.Prod_AsocRiesgo_Menor)
                   
                   If Cartera.Prod_AsocRiesgo_Menor_BIDASK(j).Id_sistema = AddOn.AddOn_Operaciones(i).Sistema And _
                      Cartera.Prod_AsocRiesgo_Menor_BIDASK(j).Codigo_Producto = IIf(AddOn.AddOn_Operaciones(i).Producto = "14", "1", _
                                                                       AddOn.AddOn_Operaciones(i).Producto) And _
                      Cartera.Prod_AsocRiesgo_Menor_BIDASK(j).LCRGruMdaCod = LCRParMdaGruMda And _
                      Cartera.Prod_AsocRiesgo_Menor_BIDASK(j).LCRPla <= InputPlazo Then
                      
                       If TipoOperacion = "C" And Cartera.Prod_AsocRiesgo_Menor_BIDASK(j).lcrTipoBID_ASK = "ASK" Then
                   
                           Plazo1 = Cartera.Prod_AsocRiesgo_Menor_BIDASK(j).LCRPla
                           Pond1 = Cartera.Prod_AsocRiesgo_Menor_BIDASK(j).LCRPon
                           EncuentraPlazo1 = 1
                        End If
                        If TipoOperacion = "V" And Cartera.Prod_AsocRiesgo_Menor_BIDASK(j).lcrTipoBID_ASK = "BID" Then
                           Plazo1 = Cartera.Prod_AsocRiesgo_Menor_BIDASK(j).LCRPla
                           Pond1 = Cartera.Prod_AsocRiesgo_Menor_BIDASK(j).LCRPon
                           EncuentraPlazo1 = 1
                        
                        End If
                        
                   End If
                Next
                EncuentraPlazo2 = 0
                For j = 0 To AsocRiesgoMayor_BIDASK 'UBound(Cartera.Prod_AsocRiesgo_Mayor)
                   If Cartera.Prod_AsocRiesgo_Mayor_BIDASK(j).Id_sistema = AddOn.AddOn_Operaciones(i).Sistema And _
                      Cartera.Prod_AsocRiesgo_Mayor_BIDASK(j).Codigo_Producto = IIf(AddOn.AddOn_Operaciones(i).Producto = "14", "1", _
                                                                       AddOn.AddOn_Operaciones(i).Producto) And _
                      Cartera.Prod_AsocRiesgo_Mayor_BIDASK(j).LCRGruMdaCod = LCRParMdaGruMda And _
                      Cartera.Prod_AsocRiesgo_Mayor_BIDASK(j).LCRPla > InputPlazo Then
                      
                      If TipoOperacion = "C" And Cartera.Prod_AsocRiesgo_Menor_BIDASK(j).lcrTipoBID_ASK = "ASK" Then
                   
                           Plazo2 = Cartera.Prod_AsocRiesgo_Mayor_BIDASK(j).LCRPla
                           Pond2 = Cartera.Prod_AsocRiesgo_Mayor_BIDASK(j).LCRPon
                           EncuentraPlazo2 = 1
                      End If
                      If TipoOperacion = "V" And Cartera.Prod_AsocRiesgo_Menor_BIDASK(j).lcrTipoBID_ASK = "BID" Then
                           Plazo2 = Cartera.Prod_AsocRiesgo_Mayor_BIDASK(j).LCRPla
                           Pond2 = Cartera.Prod_AsocRiesgo_Mayor_BIDASK(j).LCRPon
                           EncuentraPlazo2 = 1
                      End If
                      
                   End If
                Next 'PRD20426
            
            Else
                                                        
            EncuentraPlazo1 = 0
            For j = 0 To AsocRiesgoMenor 'UBound(Cartera.Prod_AsocRiesgo_Menor)
               
               If Cartera.Prod_AsocRiesgo_Menor(j).Id_sistema = AddOn.AddOn_Operaciones(i).Sistema And _
                  Cartera.Prod_AsocRiesgo_Menor(j).Codigo_Producto = IIf(AddOn.AddOn_Operaciones(i).Producto = "14", "1", _
                                                                   AddOn.AddOn_Operaciones(i).Producto) And _
                  Cartera.Prod_AsocRiesgo_Menor(j).LCRGruMdaCod = LCRParMdaGruMda And _
                  Cartera.Prod_AsocRiesgo_Menor(j).LCRPla <= InputPlazo Then
               
                       Plazo1 = Cartera.Prod_AsocRiesgo_Menor(j).LCRPla
                       Pond1 = Cartera.Prod_AsocRiesgo_Menor(j).LCRPon
                       EncuentraPlazo1 = 1
               End If
            Next
            EncuentraPlazo2 = 0
            For j = 0 To AsocRiesgoMayor 'UBound(Cartera.Prod_AsocRiesgo_Mayor)
               If Cartera.Prod_AsocRiesgo_Mayor(j).Id_sistema = AddOn.AddOn_Operaciones(i).Sistema And _
                  Cartera.Prod_AsocRiesgo_Mayor(j).Codigo_Producto = IIf(AddOn.AddOn_Operaciones(i).Producto = "14", "1", _
                                                                   AddOn.AddOn_Operaciones(i).Producto) And _
                  Cartera.Prod_AsocRiesgo_Mayor(j).LCRGruMdaCod = LCRParMdaGruMda And _
                  Cartera.Prod_AsocRiesgo_Mayor(j).LCRPla > InputPlazo Then
               
                       Plazo2 = Cartera.Prod_AsocRiesgo_Mayor(j).LCRPla
                       Pond2 = Cartera.Prod_AsocRiesgo_Mayor(j).LCRPon
                       EncuentraPlazo2 = 1
               End If
            Next
                  
            End If
                        
                        
                  
            Prc = 0
                 
            If EncuentraPlazo2 = 0 Then
               Prc = Pond1
            End If
            
            If EncuentraPlazo1 = 0 Then
               Prc = Pond2
            End If
            
            If Prc = 0 Then
               'Prc = Pond1 + (Pond2 - Pond1) * (InputPlazo - Plazo1) / IIf((Plazo2 - Plazo1) = 0, 1, (Plazo2 - Plazo1))
                Prc = Pond1 + (InputPlazo - Plazo1) * (Pond2 - Pond1) / IIf((Plazo2 - Plazo1) = 0, 1, (Plazo2 - Plazo1))             
            End If
            
            For j = 0 To ValMoneda 'UBound(Cartera.Val_Moneda)
               If Cartera.Val_Moneda(j).vmcodigo = IIf(AddOn.AddOn_Operaciones(i).Moneda_Activo = 13, _
                  994, AddOn.AddOn_Operaciones(i).Moneda_Activo) Then
               
                       nValorMoneda = Cartera.Val_Moneda(j).vmValor
               
               End If
            Next
             
             
            If AddOn.AddOn_Operaciones(i).Moneda_Activo <> 998 Then
                For j = 0 To ValMonContable 'UBound(Cartera.Val_Mon_Contable)
                    If Cartera.Val_Mon_Contable(j).Codigo_Moneda = IIf(AddOn.AddOn_Operaciones(i).Moneda_Activo = 13, _
                       994, AddOn.AddOn_Operaciones(i).Moneda_Activo) Then
                            
                            nValorMoneda = Cartera.Val_Mon_Contable(j).Tipo_Cambio
                    
                    End If
                Next
             End If
             
'             If Metodologia = 5 Then
'                On Error Resume Next
'                    Metodologia5 = UBound(cartera.Metodologia5)
'                    ErrorMetodologia5 = Err.Number
'                On Error GoTo 0
'
'                If Not ErrorMetodologia5 = 0 Then
'                    Metodologia5 = -1
'                End If
'
'                For j = 0 To Metodologia5 'UBound(Cartera.Metodologia5)
'
'                    If cartera.Metodologia5(j).Numero_Operacion = AddOn.AddOn_Operaciones(I).Num_Operacion Then
'
'                       cartera.Metodologia5(j).AddOn = AddOn.AddOn_Operaciones(I).Capital_Activo * nValorMoneda * Prc
'                       cartera.Metodologia5(I).Sistema = AddOn.AddOn_Operaciones(I).Sistema
'                       cartera.Metodologia5(I).Numero_Operacion = AddOn.AddOn_Operaciones(I).Num_Operacion
'                       cartera.Metodologia5(I).Amortizacion = AddOn.AddOn_Operaciones(I).Capital_Activo
'                       cartera.Metodologia5(I).Prc = Prc
'                       cartera.Metodologia5(I).Plazo = AddOn.AddOn_Operaciones(I).Plazo_Activo
'                       cartera.Metodologia5(I).ValorMoneda = nValorMoneda
'                       cartera.Metodologia5(I).LCRParMdaGruMda = LCRParMdaGruMda
'                       cartera.Metodologia5(I).Producto = AddOn.AddOn_Operaciones(I).Producto
'                    End If
'
'                Next
'             Else
                'Verificar si esto aplica
                Monto = Monto + AddOn.AddOn_Operaciones(i).Capital_Activo * nValorMoneda * Prc
                'Prc = Prc + Prc * 100#  'No aplica, solo para la parte SQL Server TRNASACION...
                

                ReDim Preserve Cartera.Metodologia2(ContMetodologia2)
                Cartera.Metodologia2(ContMetodologia2).Sistema = AddOn.AddOn_Operaciones(i).Sistema
                Cartera.Metodologia2(ContMetodologia2).Numero_Operacion = AddOn.AddOn_Operaciones(i).Num_Operacion
                Cartera.Metodologia2(ContMetodologia2).AddOn = AddOn.AddOn_Operaciones(i).Capital_Activo * nValorMoneda * Prc
                Cartera.Metodologia2(ContMetodologia2).Amortizacion = AddOn.AddOn_Operaciones(i).Capital_Activo
                Cartera.Metodologia2(ContMetodologia2).Prc = Prc
                Cartera.Metodologia2(ContMetodologia2).Plazo = AddOn.AddOn_Operaciones(i).Plazo_Activo
                Cartera.Metodologia2(ContMetodologia2).ValorMoneda = nValorMoneda
                Cartera.Metodologia2(ContMetodologia2).LCRParMdaGruMda = LCRParMdaGruMda
                Cartera.Metodologia2(ContMetodologia2).Producto = AddOn.AddOn_Operaciones(i).Producto
                Let ContMetodologia2 = ContMetodologia2 + 1
'             End If
             
        End If
    Next
    If Metodologia = 2 Then
        AddOn_Consulta_Carteras_Bac_Riesgo = Monto
    End If
End Function

Private Sub Carga_ParMonedas_Sistemas(Cartera As Negociacion)

    Dim Datos()
    
    'MAP: Para DLL Cambio de estilo de llamada
    'Variables para la conexion
    Dim Tabla() As Variant
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    Dim ErrorEjecucion01 As Integer
    Dim ErrorEjecucion02 As Integer
    
    Dim LargoLista As Long
    Dim ErrorLargoLista As Long
    Dim i               As Long
    
    
    'Inicio de variable para ejecuta proceso almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "BACLINEAS..SP_RIEFIN_CON_PARMONEDAS"
    Set Proc_Alm.ActiveConnection = Conexion
    
    'PARAMETROS, distinto y según el procedimiento
    'TABLA PARES DE MONEDAS
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@OPCION", adInteger, adParamInput, , 1)
    
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorEjecucion01 = Err.Number
    On Error GoTo 0
    
    If ErrorEjecucion01 <> 0 Then
        Exit Sub
    End If
    
    Tabla = rs.GetRows
    rs.Close

    'Obtener largo de la lista
    'Recordar que los datos en Tabla
    'las filas son lo que se ve
    'en consola como columna y
    'vice-versa.
    On Error Resume Next
        LargoLista = UBound(Tabla, 2) '<== Cantidad de Columnas
        ErrorLargoLista = Err.Number
    On Error GoTo 0
    
    If ErrorLargoLista <> 0 Then
        Exit Sub
    End If

    For i = 0 To LargoLista
      ReDim Preserve Cartera.Par_Monedas(i)
      Cartera.Par_Monedas(i).LCRGruMdaCod = Trim(Tabla(0, i))
      Cartera.Par_Monedas(i).LCRParMda1 = Tabla(1, i)
      Cartera.Par_Monedas(i).LCRParMda2 = Tabla(2, i)
    Next i
      
      
    'Inicio de variable para ejecuta proceso almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "BACLINEAS..SP_RIEFIN_CON_PARMONEDAS"
    Set Proc_Alm.ActiveConnection = Conexion
    
    'PARAMETROS, distinto y según el procedimiento
    'TABLA PARES DE MONEDAS
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@OPCION", adInteger, adParamInput, , 2)
    
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorEjecucion01 = Err.Number
    On Error GoTo 0
    
    If ErrorEjecucion01 <> 0 Then
        Exit Sub
    End If
    
    Tabla = rs.GetRows
    rs.Close

    'Obtener largo de la lista
    'Recordar que los datos en Tabla
    'las filas son lo que se ve
    'en consola como columna y
    'vice-versa.
    On Error Resume Next
        LargoLista = UBound(Tabla, 2) '<== Cantidad de Columnas
        ErrorLargoLista = Err.Number
    On Error GoTo 0
    
    If ErrorLargoLista <> 0 Then
        Exit Sub
    End If
      
    For i = 0 To LargoLista
      ReDim Preserve Cartera.Prod_AsocRiesgo_Menor(i)
      Cartera.Prod_AsocRiesgo_Menor(i).Id_sistema = Trim(Tabla(0, i))      'DATOS(1)
      Cartera.Prod_AsocRiesgo_Menor(i).Codigo_Producto = Trim(Tabla(1, i)) 'DATOS(2)
      Cartera.Prod_AsocRiesgo_Menor(i).LCRGruMdaCod = Trim(Tabla(2, i))    'DATOS(3)
      Cartera.Prod_AsocRiesgo_Menor(i).LCRPla = CDbl(Tabla(3, i))                'DATOS(4)
      Cartera.Prod_AsocRiesgo_Menor(i).LCRPon = CDbl(Tabla(4, i))                'DATOS(5)
      Cartera.Prod_AsocRiesgo_Menor(i).Codigo_Riesgo = CInt(Tabla(5, i))         'DATOS(6)
    Next i
    
   
    'Inicio de variable para ejecuta proceso almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "BACLINEAS..SP_RIEFIN_CON_PARMONEDAS"
    Set Proc_Alm.ActiveConnection = Conexion
    
    'PARAMETROS, distinto y según el procedimiento
    'TABLA PARES DE MONEDAS
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@OPCION", adInteger, adParamInput, , 3)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@FechaProceso", adDBTimeStamp, adParamInput, , Rescata_Fecha_Sistema())
    
    
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorEjecucion01 = Err.Number
    On Error GoTo 0
    
    If ErrorEjecucion01 <> 0 Then
        Exit Sub
    End If
    
    Tabla = rs.GetRows
    rs.Close

    'Obtener largo de la lista
    'Recordar que los datos en Tabla
    'las filas son lo que se ve
    'en consola como columna y
    'vice-versa.
    On Error Resume Next
        LargoLista = UBound(Tabla, 2) '<== Cantidad de Columnas
        ErrorLargoLista = Err.Number
    On Error GoTo 0
    
    If ErrorLargoLista <> 0 Then
        Exit Sub
    End If

    For i = 0 To LargoLista
      
      ReDim Preserve Cartera.Val_Moneda(i)
      Cartera.Val_Moneda(i).vmcodigo = Tabla(0, i) 'DATOS(1)
      Cartera.Val_Moneda(i).vmfecha = Tabla(1, i)  'DATOS(2)
      Cartera.Val_Moneda(i).vmValor = Tabla(2, i)  'DATOS(3)
    Next i
    
    
    'Inicio de variable para ejecuta proceso almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "BACLINEAS..SP_RIEFIN_CON_PARMONEDAS"
    Set Proc_Alm.ActiveConnection = Conexion
    
    'PARAMETROS, distinto y según el procedimiento
    'TABLA PARES DE MONEDAS
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@OPCION", adInteger, adParamInput, , 5)
    
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorEjecucion01 = Err.Number
    On Error GoTo 0
    
    If ErrorEjecucion01 <> 0 Then
        Exit Sub
    End If
    
    Tabla = rs.GetRows
    rs.Close

    'Obtener largo de la lista
    'Recordar que los datos en Tabla
    'las filas son lo que se ve
    'en consola como columna y
    'vice-versa.
    On Error Resume Next
        LargoLista = UBound(Tabla, 2) '<== Cantidad de Columnas
        ErrorLargoLista = Err.Number
    On Error GoTo 0
    
    If ErrorLargoLista <> 0 Then
        Exit Sub
    End If
      
    FechaAnterior = Tabla(0, 0) 'DATOS(1)
    
    'Inicio de variable para ejecuta proceso almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "BACLINEAS..SP_RIEFIN_CON_PARMONEDAS"
    Set Proc_Alm.ActiveConnection = Conexion
    
    'PARAMETROS, distinto y según el procedimiento
    'TABLA PARES DE MONEDAS
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@OPCION", adInteger, adParamInput, , 4)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@FechaProceso", adDBTimeStamp, adParamInput, , gsBAC_Fecp)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@FechaAyer", adDBTimeStamp, adParamInput, , FechaAnterior)
    
    
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorEjecucion01 = Err.Number
    On Error GoTo 0
    
    If ErrorEjecucion01 <> 0 Then
        Exit Sub
    End If
    
    Tabla = rs.GetRows
    rs.Close

    'Obtener largo de la lista
    'Recordar que los datos en Tabla
    'las filas son lo que se ve
    'en consola como columna y
    'vice-versa.
    On Error Resume Next
        LargoLista = UBound(Tabla, 2) '<== Cantidad de Columnas
        ErrorLargoLista = Err.Number
    On Error GoTo 0
    
    If ErrorLargoLista <> 0 Then
        Exit Sub
    End If

    For i = 0 To LargoLista
      ReDim Preserve Cartera.Val_Mon_Contable(i)
      Cartera.Val_Mon_Contable(i).Codigo_Moneda = Tabla(0, i) 'DATOS(1)
      Cartera.Val_Mon_Contable(i).Fecha = Tabla(1, i)         'DATOS(2)
      Cartera.Val_Mon_Contable(i).Tipo_Cambio = Tabla(2, i)   'DATOS(3)
    Next i
    
    'Inicio de variable para ejecuta proceso almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "BACLINEAS..SP_RIEFIN_CON_PARMONEDAS"
    Set Proc_Alm.ActiveConnection = Conexion
    
    'PARAMETROS, distinto y según el procedimiento
    'TABLA PARES DE MONEDAS
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@OPCION", adInteger, adParamInput, , 6)
    
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorEjecucion01 = Err.Number
    On Error GoTo 0
    
    If ErrorEjecucion01 <> 0 Then
        Exit Sub
    End If
    
    Tabla = rs.GetRows
    rs.Close

    'Obtener largo de la lista
    'Recordar que los datos en Tabla
    'las filas son lo que se ve
    'en consola como columna y
    'vice-versa.
    On Error Resume Next
        LargoLista = UBound(Tabla, 2) '<== Cantidad de Columnas
        ErrorLargoLista = Err.Number
    On Error GoTo 0
    
    If ErrorLargoLista <> 0 Then
        Exit Sub
    End If

    For i = 0 To LargoLista
      ReDim Preserve Cartera.Prod_AsocRiesgo_Mayor(i)
      Cartera.Prod_AsocRiesgo_Mayor(i).Id_sistema = Trim(Tabla(0, i))      'DATOS(1)
      Cartera.Prod_AsocRiesgo_Mayor(i).Codigo_Producto = Trim(Tabla(1, i)) 'DATOS(2)
      Cartera.Prod_AsocRiesgo_Mayor(i).LCRGruMdaCod = Trim(Tabla(2, i))    'DATOS(3)
      Cartera.Prod_AsocRiesgo_Mayor(i).LCRPla = Tabla(3, i)                'DATOS(4)
      Cartera.Prod_AsocRiesgo_Mayor(i).LCRPon = Tabla(4, i)                'DATOS(5)
      Cartera.Prod_AsocRiesgo_Mayor(i).Codigo_Riesgo = Tabla(5, i)         'DATOS(6)
    Next i
    
    
    
 '=================================================================================================================
    
    'PRD20426
    
     'Inicio de variable para ejecuta proceso almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "BACLINEAS..SP_RIEFIN_CON_PARMONEDAS"
    Set Proc_Alm.ActiveConnection = Conexion
    
    'PARAMETROS, distinto y según el procedimiento
    'TABLA PARES DE MONEDAS RIESGO MENOR BID ASK
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@OPCION", adInteger, adParamInput, , 7)
    
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorEjecucion01 = Err.Number
    On Error GoTo 0
    
    If ErrorEjecucion01 <> 0 Then
        Exit Sub
    End If
    
    Tabla = rs.GetRows
    rs.Close

    'Obtener largo de la lista
    'Recordar que los datos en Tabla
    'las filas son lo que se ve
    'en consola como columna y
    'vice-versa.
    On Error Resume Next
        LargoLista = UBound(Tabla, 2) '<== Cantidad de Columnas
        ErrorLargoLista = Err.Number
    On Error GoTo 0
    
    If ErrorLargoLista <> 0 Then
        Exit Sub
    End If
      
    For i = 0 To LargoLista
      ReDim Preserve Cartera.Prod_AsocRiesgo_Menor_BIDASK(i)
      Cartera.Prod_AsocRiesgo_Menor_BIDASK(i).Id_sistema = Trim(Tabla(0, i))      'DATOS(1)
      Cartera.Prod_AsocRiesgo_Menor_BIDASK(i).Codigo_Producto = Trim(Tabla(1, i)) 'DATOS(2)
      Cartera.Prod_AsocRiesgo_Menor_BIDASK(i).LCRGruMdaCod = Trim(Tabla(2, i))    'DATOS(3)
      Cartera.Prod_AsocRiesgo_Menor_BIDASK(i).LCRPla = CDbl(Tabla(3, i))                'DATOS(4)
      Cartera.Prod_AsocRiesgo_Menor_BIDASK(i).LCRPon = CDbl(Tabla(4, i))                'DATOS(5)
      Cartera.Prod_AsocRiesgo_Menor_BIDASK(i).Codigo_Riesgo = CInt(Tabla(5, i))         'DATOS(6)
      Cartera.Prod_AsocRiesgo_Menor_BIDASK(i).lcrTipoBID_ASK = Trim(Tabla(6, i))  ' 'DATOS(7)
    Next i
    
''=================================================================================================================
    'Inicio de variable para ejecuta proceso almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "BACLINEAS..SP_RIEFIN_CON_PARMONEDAS"
    Set Proc_Alm.ActiveConnection = Conexion
       
    'PARAMETROS, distinto y según el procedimiento
    'TABLA PARES DE MONEDAS RIESGO MAYOR BID ASK
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@OPCION", adInteger, adParamInput, , 8)
    
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorEjecucion01 = Err.Number
    On Error GoTo 0
    
    If ErrorEjecucion01 <> 0 Then
        Exit Sub
    End If
    
    Tabla = rs.GetRows
    rs.Close

    'Obtener largo de la lista
    'Recordar que los datos en Tabla
    'las filas son lo que se ve
    'en consola como columna y
    'vice-versa.
    On Error Resume Next
        LargoLista = UBound(Tabla, 2) '<== Cantidad de Columnas
        ErrorLargoLista = Err.Number
    On Error GoTo 0
    
    If ErrorLargoLista <> 0 Then
        Exit Sub
    End If

    For i = 0 To LargoLista
      ReDim Preserve Cartera.Prod_AsocRiesgo_Mayor_BIDASK(i)
      Cartera.Prod_AsocRiesgo_Mayor_BIDASK(i).Id_sistema = Trim(Tabla(0, i))      'DATOS(1)
      Cartera.Prod_AsocRiesgo_Mayor_BIDASK(i).Codigo_Producto = Trim(Tabla(1, i)) 'DATOS(2)
      Cartera.Prod_AsocRiesgo_Mayor_BIDASK(i).LCRGruMdaCod = Trim(Tabla(2, i))    'DATOS(3)
      Cartera.Prod_AsocRiesgo_Mayor_BIDASK(i).LCRPla = Tabla(3, i)                'DATOS(4)
      Cartera.Prod_AsocRiesgo_Mayor_BIDASK(i).LCRPon = Tabla(4, i)                'DATOS(5)
      Cartera.Prod_AsocRiesgo_Mayor_BIDASK(i).Codigo_Riesgo = Tabla(5, i)         'DATOS(6)
      Cartera.Prod_AsocRiesgo_Mayor_BIDASK(i).lcrTipoBID_ASK = Trim(Tabla(6, i))  ' 'DATOS(7)
    Next i
    
     
End Sub


Private Function CalculaValorMercado(Cartera As Negociacion)

    Dim i As Long
    Dim indice As Long
    Dim ValorMercadoSwap As Long
    Dim ErrorValorMercadoSwap As Long
    Dim ValorMercadoFwd As Long
    Dim ErrorValorMercadoFwd As Long
    Dim ValorMercadoFwd_RF As Long
    Dim ErrorValorMercadoFwd_RF As Long
    Dim ValorMercadoOpcion As Long
    Dim ErrorValorMercadoOpcion As Long
    Dim ValorMercado As Long
    Dim ErrorValorMercado As Long

    On Error Resume Next
        ValorMercadoSwap = UBound(Cartera.Cartera_Swap)
        ErrorValorMercadoSwap = Err.Number
    On Error GoTo 0
    
    If Not ErrorValorMercadoSwap = 0 Then
        ValorMercadoSwap = -1
    End If
    
    On Error Resume Next
        ValorMercadoFwd = UBound(Cartera.Cartera_Fwd)
        ErrorValorMercadoFwd = Err.Number
    On Error GoTo 0
    
    If Not ErrorValorMercadoFwd = 0 Then
        ValorMercadoFwd = -1
    End If
    
    On Error Resume Next
        ValorMercadoFwd_RF = UBound(Cartera.Cartera_Fwd_RF)
        ErrorValorMercadoFwd_RF = Err.Number
    On Error GoTo 0
    
    If Not ErrorValorMercadoFwd_RF = 0 Then
        ValorMercadoFwd_RF = -1
    End If
    
    On Error Resume Next
        ValorMercadoOpcion = UBound(Cartera.Cartera_Opcion)
        ErrorValorMercadoOpcion = Err.Number
    On Error GoTo 0
    
    If Not ErrorValorMercadoOpcion = 0 Then
        ValorMercadoOpcion = -1
    End If
    Dim AuxHaySwap As Boolean
    Let AuxHaySwap = False
    indice = 0
    For i = 0 To ValorMercadoSwap
        Let AuxHaySwap = True
        If i = 0 Then
            ReDim Preserve Cartera.Val_Mercado(0)
        End If
    
        If Cartera.Cartera_Swap(i).Numero_Operacion = Cartera.Val_Mercado(indice).Numero_Operacion Then
        
            ReDim Preserve Cartera.Val_Mercado(indice)
        
            Cartera.Val_Mercado(indice).Numero_Operacion = Cartera.Cartera_Swap(i).Numero_Operacion
            Cartera.Val_Mercado(indice).Valor_Mercado = Cartera.Val_Mercado(indice).Valor_Mercado + Cartera.Cartera_Swap(i).Valor_Mercado
            Cartera.Val_Mercado(indice).Sistema = "Swap"
            Cartera.Val_Mercado(indice).SistemaBAC = "PCS"
        End If
        
        If Cartera.Cartera_Swap(i).Numero_Operacion <> Cartera.Val_Mercado(indice).Numero_Operacion Then
            If i <> 0 Then
            indice = indice + 1
            End If
            ReDim Preserve Cartera.Val_Mercado(indice)
            Cartera.Val_Mercado(indice).Numero_Operacion = Cartera.Cartera_Swap(i).Numero_Operacion
            Cartera.Val_Mercado(indice).Valor_Mercado = Cartera.Val_Mercado(indice).Valor_Mercado + Cartera.Cartera_Swap(i).Valor_Mercado
            Cartera.Val_Mercado(indice).Sistema = "Swap"
            Cartera.Val_Mercado(indice).SistemaBAC = "PCS"
        End If
    Next i
    
    'Para no romper con
    'la lógica de agrupacion
    If AuxHaySwap Then
        Let indice = indice + 1
    End If
    For i = 0 To ValorMercadoFwd
        ReDim Preserve Cartera.Val_Mercado(indice)
        Cartera.Val_Mercado(indice).Numero_Operacion = Cartera.Cartera_Fwd(i).Numero_Operacion
        Cartera.Val_Mercado(indice).Valor_Mercado = Cartera.Val_Mercado(indice).Valor_Mercado + Cartera.Cartera_Fwd(i).Valor_Mercado
        Cartera.Val_Mercado(indice).Sistema = "Fwd"
        Cartera.Val_Mercado(indice).SistemaBAC = "BFW"
        indice = indice + 1
    Next i
        
    For i = 0 To ValorMercadoFwd_RF
        ReDim Preserve Cartera.Val_Mercado(indice)
        Cartera.Val_Mercado(indice).Numero_Operacion = Cartera.Cartera_Fwd_RF(i).Numero_Operacion
        Cartera.Val_Mercado(indice).Valor_Mercado = Cartera.Val_Mercado(indice).Valor_Mercado + Cartera.Cartera_Fwd_RF(i).Valor_Mercado
        Cartera.Val_Mercado(indice).Sistema = "Fwd_RF"
        Cartera.Val_Mercado(indice).SistemaBAC = "BFW"
        indice = indice + 1
    Next i
        
    For i = 0 To ValorMercadoOpcion
        ReDim Preserve Cartera.Val_Mercado(indice)
        Cartera.Val_Mercado(indice).Numero_Operacion = Cartera.Cartera_Opcion(i).NumOp
        Cartera.Val_Mercado(indice).Valor_Mercado = Cartera.Val_Mercado(indice).Valor_Mercado + Cartera.Cartera_Opcion(i).Valor_Mercado
        Cartera.Val_Mercado(indice).Sistema = "Opcion"
        Cartera.Val_Mercado(indice).SistemaBAC = "OPT"
        indice = indice + 1
    Next i
    
    On Error Resume Next
        ValorMercado = UBound(Cartera.Val_Mercado)
        ErrorValorMercado = Err.Number
    On Error GoTo 0
    
    If Not ErrorValorMercado = 0 Then
        ValorMercado = -1
    End If
    
    'Aparentemente es codigo muerto, evaluar borrar
    indice = 0
    For i = 0 To ValorMercado
        ReDim Preserve Cartera.Metodologia5(i)
        Cartera.Metodologia5(indice).Sistema = Cartera.Val_Mercado(i).Sistema
        Cartera.Metodologia5(indice).Numero_Operacion = Cartera.Val_Mercado(i).Numero_Operacion
        Cartera.Metodologia5(indice).Valor_Mercado = Cartera.Val_Mercado(i).Valor_Mercado
        indice = indice + 1
    Next i
    'Aparentemente es codigo muerto, evaluar borrar

        
End Function

Private Function Func_CalculoRecMetologia5(Cartera As Negociacion) As Double
    Dim i As Long
    Dim j As Long
    Dim LarValMercado As Double
    Dim ErrorMetodologia2 As Long
    Dim ErrorValMercado As Long
    Dim LarMetodologia2 As Double
    Dim SumadorAddOn As Double
    
    On Error Resume Next
        LarValMercado = UBound(Cartera.Val_Mercado)
        ErrorValMercado = Err.Number
    On Error GoTo 0
    
    If Not ErrorValMercado = 0 Then
        LarValMercado = -1
    End If
    
    On Error Resume Next
        LarMetodologia2 = UBound(Cartera.Metodologia2)
        ErrorMetodologia2 = Err.Number
    On Error GoTo 0
    
    If Not ErrorMetodologia2 = 0 Then
        LarMetodologia2 = -1
    End If
    
    
    Let Func_CalculoRecMetologia5 = 0 'Inicialización de Acumuladores Siempre
    
    For i = 0 To LarValMercado        'Para cada Operacion
        Let SumadorAddOn = 0
        For j = 0 To LarMetodologia2
            If Cartera.Val_Mercado(i).Numero_Operacion = Cartera.Metodologia2(j).Numero_Operacion _
               And Cartera.Metodologia2(j).Sistema = Cartera.Val_Mercado(i).SistemaBAC Then
                Let SumadorAddOn = SumadorAddOn + Cartera.Metodologia2(j).AddOn
            End If
        Next j
        Cartera.Val_Mercado(i).AddOnMdaLocal = SumadorAddOn
        
        Cartera.Val_Mercado(i).MaxValMeryAddOn = Max(SumadorAddOn + Cartera.Val_Mercado(i).Valor_Mercado, 0)
               
        Func_CalculoRecMetologia5 = Func_CalculoRecMetologia5 + Cartera.Val_Mercado(i).MaxValMeryAddOn
    
    Next
    
End Function



Private Function AddOn_Consulta_Opciones(Cartera As Negociacion, AddOn As Datos_AddOn, Metodologia As Integer) As Double
   Dim i As Long
   Dim j As Long
   Dim Datos()
   Dim AddOnConOpt As Long
   Dim AddOnErrorOpt As Long
   Dim Metodologia5 As Double
   Dim ErrorMetodologia5 As Long
   Dim RetornoAddon As Double
   Dim RetornoVr    As Double
   Dim Metodologia2 As Double
   Dim ErrorMetodologia2 As Long
   
    'MAP: Para DLL Cambio de estilo de llamada
    'Variables para la conexion
    Dim Tabla() As Variant
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    Dim ErrorEjecucion01 As Integer
    Dim ErrorEjecucion02 As Integer
    
    Dim LargoLista As Long
    Dim ErrorLargoLista As Long
   
   
   
   i = 0
   
    On Error Resume Next
        AddOnConOpt = UBound(AddOn.AddOn_Operaciones)
        AddOnErrorOpt = Err.Number
    On Error GoTo 0
    
    If Not AddOnErrorOpt = 0 Then
        AddOnConOpt = -1
    End If
   
    On Error Resume Next
        Metodologia5 = UBound(Cartera.Metodologia5)
        ErrorMetodologia5 = Err.Number
    On Error GoTo 0
    
    If Not ErrorMetodologia5 = 0 Then
        Metodologia5 = -1
    End If
    
    On Error Resume Next
        Metodologia2 = UBound(Cartera.Metodologia2)
        ErrorMetodologia2 = Err.Number
    On Error GoTo 0
    
    If Not ErrorMetodologia2 = 0 Then
        Metodologia2 = 0 'Se realizarà ingreso en arreglo de trace
    End If
    
    Let AddOn_Consulta_Opciones = 0   'Inicializacion de Sumadores
    For i = 0 To AddOnConOpt
        If AddOn.AddOn_Operaciones(i).Sistema = "OPT" Then
        
            'Inicio de variable para ejecuta proceso almacenado
            Set Proc_Alm = New ADODB.Command
            Proc_Alm.CommandType = adCmdStoredProc
            Proc_Alm.CommandText = "BACLINEAS..SP_RIEFIN_CALCULO_LCR_INTERNO_OPCIONES"
            Set Proc_Alm.ActiveConnection = Conexion
            
            'PARAMETROS, distinto y según el procedimiento
            'TABLA PARES DE MONEDAS
            Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@NumOper", adInteger, adParamInput, , AddOn.AddOn_Operaciones(i).Num_Operacion)
            Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Retorno", adVarChar, adParamInput, 1, "S")
            'Ejecuta el procedimiento
            On Error Resume Next
                Set rs = Proc_Alm.Execute
                ErrorEjecucion01 = Err.Number
            On Error GoTo 0
            
            If ErrorEjecucion01 <> 0 Then
                Exit Function
            End If
            
            Tabla = rs.GetRows
            rs.Close
        
            'Obtener largo de la lista
            'Recordar que los datos en Tabla
            'las filas son lo que se ve
            'en consola como columna y
            'vice-versa.
            On Error Resume Next
                LargoLista = UBound(Tabla, 2) '<== Cantidad de Columnas
                ErrorLargoLista = Err.Number
            On Error GoTo 0
            
            If ErrorLargoLista <> 0 Then
                Exit Function
            End If
        
            For j = 0 To LargoLista
                 Let RetornoAddon = Tabla(14, j) 'CDbl(DATOS(15))
                 Let RetornoVr = Tabla(13, j)    'CDbl(DATOS(14))
                 If Metodologia = 5 Then
                    AddOn_Consulta_Opciones = AddOn_Consulta_Opciones + Max(RetornoAddon + RetornoVr, 0)
                 Else 'Metod. 2
                    AddOn_Consulta_Opciones = AddOn_Consulta_Opciones + Max(RetornoAddon, 0)
                 End If
                 
                 
                ReDim Preserve Cartera.Metodologia2(Metodologia2)
                Cartera.Metodologia2(Metodologia2).Sistema = AddOn.AddOn_Operaciones(i).Sistema
                Cartera.Metodologia2(Metodologia2).Numero_Operacion = AddOn.AddOn_Operaciones(i).Num_Operacion
                Cartera.Metodologia2(Metodologia2).AddOn = RetornoAddon
                Cartera.Metodologia2(Metodologia2).Amortizacion = AddOn.AddOn_Operaciones(i).Capital_Activo
                Cartera.Metodologia2(Metodologia2).Prc = Tabla(15, j) / 100#  'CDbl(DATOS(16)) / 100#
                Cartera.Metodologia2(Metodologia2).Plazo = Tabla(7, j)       'CDbl(DATOS(8))
                Cartera.Metodologia2(Metodologia2).ValorMoneda = 0
                Cartera.Metodologia2(Metodologia2).LCRParMdaGruMda = "USD_CLP"
                Cartera.Metodologia2(Metodologia2).Producto = AddOn.AddOn_Operaciones(i).Producto
                
                Let Metodologia2 = Metodologia2 + 1
                
            Next j
            
            
        End If
    Next
End Function
Private Sub AddOn_Al_Vencimiento_Forward(Cartera As Negociacion, AddOn As Datos_AddOn)
    Dim i As Long
    Dim AddOnFwd As Long
    Dim AddOnErrorFwd As Long
    Dim indice As Long
    Dim AddOnErrorOP As Long
    
    On Error Resume Next
        AddOnFwd = UBound(Cartera.Cartera_Fwd)
        AddOnErrorFwd = Err.Number
    On Error GoTo 0
    If Not AddOnErrorFwd = 0 Then
        AddOnFwd = -1
    End If
          
    On Error Resume Next
        indice = UBound(AddOn.AddOn_Operaciones)
        AddOnErrorOP = Err.Number
    On Error GoTo 0
    
    If Not AddOnErrorOP = 0 Then
        Let indice = 0
    Else
        Let indice = indice + 1 'Se va agregar informacion al arreglo AddOn_Operaciones
    End If
    
         
    For i = 0 To AddOnFwd

        ReDim Preserve AddOn.AddOn_Operaciones(indice)
        
        AddOn.AddOn_Operaciones(indice).Num_Operacion = Cartera.Cartera_Fwd(i).Numero_Operacion
        AddOn.AddOn_Operaciones(indice).Sistema = "BFW"
        AddOn.AddOn_Operaciones(indice).Producto = Cartera.Cartera_Fwd(i).Tipo_forward
        'AddOn.AddOn_Operaciones(indice).Tipo_Operacion = "C"
        AddOn.AddOn_Operaciones(indice).Tipo_Operacion = Cartera.Cartera_Fwd(i).Sentido_operacion '-- MAP 08-Sep-2014
        AddOn.AddOn_Operaciones(indice).Moneda_Activo = Cartera.Cartera_Fwd(i).Moneda_1_BAC
        AddOn.AddOn_Operaciones(indice).Capital_Activo = Cartera.Cartera_Fwd(i).Amortizacion(0)
        AddOn.AddOn_Operaciones(indice).Plazo_Activo = Cartera.Cartera_Fwd(i).Plazo
        '4 Decimales plis
        AddOn.AddOn_Operaciones(indice).Duration_Activo = Format(Cartera.Cartera_Fwd(i).Duration, FDec4Dec)
        AddOn.AddOn_Operaciones(indice).Moneda_Pasivo = Cartera.Cartera_Fwd(i).Moneda_2_BAC
        AddOn.AddOn_Operaciones(indice).Capital_Pasivo = Cartera.Cartera_Fwd(i).Amortizacion(0)
        AddOn.AddOn_Operaciones(indice).Plazo_Pasivo = Cartera.Cartera_Fwd(i).Plazo
        '4 Decimales plis
        AddOn.AddOn_Operaciones(indice).Duration_Pasivo = Format(Cartera.Cartera_Fwd(i).Duration, FDec4Dec)
        indice = indice + 1
    Next
End Sub

Private Sub AddOn_Al_Vencimiento_Forward_RF(Cartera As Negociacion, AddOn As Datos_AddOn)
    Dim i As Long
    Dim AddOnFwd_RF As Long
    Dim AddOnErrorFwd_RF As Long
    Dim AddOnErrorFwd_RF_OP As Long
    Dim indice As Long
    
    On Error Resume Next
        AddOnFwd_RF = UBound(Cartera.Cartera_Fwd_RF)
        AddOnErrorFwd_RF = Err.Number
    On Error GoTo 0
    
    If Not AddOnErrorFwd_RF = 0 Then
        AddOnFwd_RF = -1
    End If
    
    On Error Resume Next
        indice = UBound(AddOn.AddOn_Operaciones)
        AddOnErrorFwd_RF_OP = Err.Number
    On Error GoTo 0
    
    If Not AddOnErrorFwd_RF_OP = 0 Then
        Let indice = 0
    Else
        Let indice = indice + 1 'Se va a gregar informacion al arreglo AddOn_Operaciones
    End If
    
    
    For i = 0 To AddOnFwd_RF
        
        ReDim Preserve AddOn.AddOn_Operaciones(indice)
        
        AddOn.AddOn_Operaciones(indice).Num_Operacion = Cartera.Cartera_Fwd_RF(i).Numero_Operacion
        AddOn.AddOn_Operaciones(indice).Sistema = "BFW"
        AddOn.AddOn_Operaciones(indice).Producto = Format(Cartera.Cartera_Fwd_RF(i).Producto, "")
        'AddOn.AddOn_Operaciones(indice).Tipo_Operacion = "C"
        AddOn.AddOn_Operaciones(indice).Tipo_Operacion = Cartera.Cartera_Fwd(i).Sentido_operacion '-- MAP 08-Sep-2014
        AddOn.AddOn_Operaciones(indice).Moneda_Activo = Cartera.Cartera_Fwd_RF(i).Moneda_1_BAC
        AddOn.AddOn_Operaciones(indice).Capital_Activo = Cartera.Cartera_Fwd_RF(i).Nominal
        AddOn.AddOn_Operaciones(indice).Plazo_Activo = Cartera.Cartera_Fwd_RF(i).Plazo

        AddOn.AddOn_Operaciones(indice).Duration_Activo = Format(Cartera.Cartera_Fwd_RF(i).Duration, FDec4Dec)
        AddOn.AddOn_Operaciones(indice).Moneda_Pasivo = Cartera.Cartera_Fwd_RF(i).Moneda_2_BAC
        AddOn.AddOn_Operaciones(indice).Capital_Pasivo = Cartera.Cartera_Fwd_RF(i).Nominal
        AddOn.AddOn_Operaciones(indice).Plazo_Pasivo = Cartera.Cartera_Fwd_RF(i).Plazo
     
        AddOn.AddOn_Operaciones(indice).Duration_Pasivo = Format(Cartera.Cartera_Fwd_RF(i).Duration, FDec4Dec)
        
        indice = indice + 1
    Next
End Sub

Private Sub AddOn_Al_Vencimiento_Opciones(Cartera As Negociacion, AddOn As Datos_AddOn)
    Dim i As Long
    Dim AddOnOpcion As Long
    Dim AddOnErrorOpcion As Long
    Dim AddOnErrorOpcion_OP As Long
    Dim indice As Long
    
    On Error Resume Next
        AddOnOpcion = UBound(Cartera.Cartera_Opcion)
        AddOnErrorOpcion = Err.Number
    On Error GoTo 0
    If Not AddOnErrorOpcion = 0 Then
        AddOnOpcion = -1
    End If
    
    If AddOnOpcion <> -1 Then
        On Error Resume Next
            indice = UBound(AddOn.AddOn_Operaciones)
            AddOnErrorOpcion_OP = Err.Number
        On Error GoTo 0
        
        If Not AddOnErrorOpcion_OP = 0 Then
            Let indice = 0
        Else
            Let indice = indice + 1 'Para insertar en arreglo AddOn_Operaciones
        End If
    End If
    
    For i = 0 To AddOnOpcion
        
        ReDim Preserve AddOn.AddOn_Operaciones(indice)
        
        AddOn.AddOn_Operaciones(indice).Num_Operacion = Cartera.Cartera_Opcion(i).NumOp
        AddOn.AddOn_Operaciones(indice).Sistema = "OPT"
        AddOn.AddOn_Operaciones(indice).Producto = "OPT"
        'AddOn.AddOn_Operaciones(indice).Tipo_Operacion = ""
        AddOn.AddOn_Operaciones(indice).Tipo_Operacion = Cartera.Cartera_Opcion(i).Compra_Venta '-- MAP 08-Sep-2014
        AddOn.AddOn_Operaciones(indice).Moneda_Activo = Cartera.Cartera_Opcion(i).Moneda_1_BAC
        AddOn.AddOn_Operaciones(indice).Capital_Activo = Cartera.Cartera_Opcion(i).Nominal
        AddOn.AddOn_Operaciones(indice).Plazo_Activo = Cartera.Cartera_Opcion(i).Plazo
        
        AddOn.AddOn_Operaciones(indice).Duration_Activo = Format(Cartera.Cartera_Opcion(i).Duration, FDec4Dec)
        AddOn.AddOn_Operaciones(indice).Moneda_Pasivo = Cartera.Cartera_Opcion(i).Moneda_2_BAC
        AddOn.AddOn_Operaciones(indice).Capital_Pasivo = Cartera.Cartera_Opcion(i).Nominal
        AddOn.AddOn_Operaciones(indice).Plazo_Pasivo = Cartera.Cartera_Opcion(i).Plazo
       
        AddOn.AddOn_Operaciones(indice).Duration_Pasivo = Format(Cartera.Cartera_Opcion(i).Duration, FDec4Dec)
        
        Let indice = indice + 1
    Next
    
End Sub
Private Sub AddOn_Al_Vencimiento_Swap(Cartera As Negociacion, AddOn As Datos_AddOn, iFecha As Date)
   Dim i As Long
   Dim z As Long
    Dim k As Long
    Dim AddOnSwap As Long
    Dim AddOnErrorSwap As Long
    Dim indice As Long
    Dim AddOnErrorOpcion_OP As Double
    Dim Existe As Long
        
    On Error Resume Next
        AddOnSwap = UBound(Cartera.Cartera_Swap)
        AddOnErrorSwap = Err.Number
    On Error GoTo 0
    If Not AddOnErrorSwap = 0 Then
        AddOnSwap = -1
    End If
          
    If AddOnSwap <> -1 Then
        On Error Resume Next
            indice = UBound(AddOn.AddOn_Operaciones)
            AddOnErrorOpcion_OP = Err.Number
        On Error GoTo 0
        
        If Not AddOnErrorOpcion_OP = 0 Then
            Let indice = 0
        Else
            Let indice = indice + 1 'Para insertar en arreglo AddOn_Operaciones
        End If
    End If
          
       
    For i = 0 To AddOnSwap   'Recorrerá toda la cartera de Swap.
        If Cartera.Cartera_Swap(i).Tipo_swap = 2 Then
            If Cartera.Cartera_Swap(i).Tipo_flujo = 1 Then
                ReDim Preserve AddOn.AddOn_Operaciones(indice)
                              
                AddOn.AddOn_Operaciones(indice).Num_Operacion = Cartera.Cartera_Swap(i).Numero_Operacion
                AddOn.AddOn_Operaciones(indice).Sistema = "PCS"
                AddOn.AddOn_Operaciones(indice).Producto = Cartera.Cartera_Swap(i).Tipo_swap
                AddOn.AddOn_Operaciones(indice).Tipo_Operacion = "C"
                AddOn.AddOn_Operaciones(indice).Fecha_Proceso = iFecha
                
                If Cartera.Cartera_Swap(i).Tipo_flujo = 1 Then
                  AddOn.AddOn_Operaciones(indice).Moneda_Activo = Cartera.Cartera_Swap(i).Moneda_Bac
                  AddOn.AddOn_Operaciones(indice).Capital_Activo = Cartera.Cartera_Swap(i).FlujoFuturo
                  AddOn.AddOn_Operaciones(indice).Plazo_Activo = Cartera.Cartera_Swap(i).Plazo
           
                  AddOn.AddOn_Operaciones(indice).Duration_Activo = Format(Cartera.Cartera_Swap(i).Duration, FDec4Dec)
                End If
                
                'Codigo muerto sacar..., indexado con k ... muy raro
                'MAP 08-Sep-2014
'                If Cartera.Cartera_Swap(k).Tipo_flujo = 2 Then
'                  AddOn.AddOn_Operaciones(indice).Moneda_Pasivo = Cartera.Cartera_Swap(i).Moneda_Bac
'                  AddOn.AddOn_Operaciones(indice).Capital_Pasivo = 0 'Cartera.Cartera_Swap(i).Saldo
'                  AddOn.AddOn_Operaciones(indice).Plazo_Pasivo = Cartera.Cartera_Swap(i).Plazo
'
'                  AddOn.AddOn_Operaciones(indice).Duration_Pasivo = Format(Cartera.Cartera_Swap(i).Duration, FDec4Dec)
'                End If
                'Codigo muerto sacar...
                
            End If
            
            If Cartera.Cartera_Swap(i).Tipo_flujo = 2 Then
                indice = indice - 1
                For z = 0 To UBound(AddOn.AddOn_Operaciones)
                    If (Cartera.Cartera_Swap(i).Tipo_flujo = 2 And _
                       Cartera.Cartera_Swap(i).Numero_Operacion = AddOn.AddOn_Operaciones(z).Num_Operacion) Then
                       
                          AddOn.AddOn_Operaciones(z).Moneda_Pasivo = Cartera.Cartera_Swap(i).Moneda_Bac
                          AddOn.AddOn_Operaciones(z).Capital_Pasivo = Cartera.Cartera_Swap(i).Saldo
                          AddOn.AddOn_Operaciones(z).Plazo_Pasivo = Cartera.Cartera_Swap(i).Plazo
                       
                          AddOn.AddOn_Operaciones(z).Duration_Pasivo = Format(Cartera.Cartera_Swap(i).Duration, FDec4Dec)
                    'Else
                 
                    End If
                Next z
                
            End If
        End If  'Tipo_swap = 2
        
        If Cartera.Cartera_Swap(i).Tipo_swap <> 2 Then
            'Llenar arreglo Addon con los datos de Nocional, Moneda y plazo global
            'Busqueda en arreglo AddOn
            Existe = 0
            For z = 0 To indice 'Indice representa lo que ingresa en estructua AddOn
                ReDim Preserve AddOn.AddOn_Operaciones(indice)
                If Cartera.Cartera_Swap(i).Numero_Operacion = AddOn.AddOn_Operaciones(z).Num_Operacion Then
                    If AddOn.AddOn_Operaciones(z).Moneda_Activo <> 0 Then
                        Existe = 1
                        indice = indice - 1
                        ReDim Preserve AddOn.AddOn_Operaciones(indice)
                        Exit For
                    End If
                End If
            Next z
                    
            'Recorrer todos los flujos Swap
            For k = 0 To AddOnSwap
                If Existe = 0 Then
                    
                    'Detecta Operacion
                    If Cartera.Cartera_Swap(i).Numero_Operacion = Cartera.Cartera_Swap(k).Numero_Operacion Then
                                                                      
                        'Condicion de inclusion del flujo
                        If (Cartera.Cartera_Swap(k).Tipo_swap <> 3 And Cartera.Cartera_Swap(k).Tipo_swap <> 2 _
                                                                          And (iFecha >= Cartera.Cartera_Swap(k).Fecha_ini _
                                                                                And iFecha < Cartera.Cartera_Swap(k).Fecha_fin _
                                                                                Or _
                                                                                iFecha <= Cartera.Cartera_Swap(k).Fecha_ini _
                                                                                And Cartera.Cartera_Swap(k).Numero_flujo = 2)) _
                              Or Cartera.Cartera_Swap(k).Tipo_swap = 3 _
                              Or Cartera.Cartera_Swap(k).Tipo_swap = 2 _
                              Then
                                
                                  ReDim Preserve AddOn.AddOn_Operaciones(indice)
                                
                                  AddOn.AddOn_Operaciones(indice).Num_Operacion = Cartera.Cartera_Swap(k).Numero_Operacion
                                  AddOn.AddOn_Operaciones(indice).Sistema = "PCS"
                                  AddOn.AddOn_Operaciones(indice).Producto = Cartera.Cartera_Swap(k).Tipo_swap
                                  AddOn.AddOn_Operaciones(indice).Tipo_Operacion = "C"
                                  AddOn.AddOn_Operaciones(indice).Fecha_Proceso = iFecha
                                  
                                  If Cartera.Cartera_Swap(k).Tipo_flujo = 1 Then
                                  
                                    AddOn.AddOn_Operaciones(indice).Moneda_Activo = Cartera.Cartera_Swap(k).Moneda_Bac
                                    'Este cambia para los Swap de Moneda
                                    AddOn.AddOn_Operaciones(indice).Capital_Activo = Cartera.Cartera_Swap(k).Saldo
                                    AddOn.AddOn_Operaciones(indice).Plazo_Activo = Cartera.Cartera_Swap(k).Plazo
                                    '4 Decimales plis
                                    AddOn.AddOn_Operaciones(indice).Duration_Pasivo = Format(Cartera.Cartera_Swap(k).Duration, FDec4Dec)
                                  End If
                                  If Cartera.Cartera_Swap(k).Tipo_swap = 2 Then 'Codigo muerto
                                  
                                      AddOn.AddOn_Operaciones(indice).Capital_Activo = Cartera.Cartera_Swap(k).FlujoFuturo
                                      AddOn.AddOn_Operaciones(indice).Plazo_Activo = Cartera.Cartera_Swap(k).Plazo
                                      AddOn.AddOn_Operaciones(indice).Duration_Activo = Format(Cartera.Cartera_Swap(k).Duration, FDec4Dec)
                                   
                                  End If
                                  
                                  If Cartera.Cartera_Swap(k).Tipo_flujo = 2 Then
                                    AddOn.AddOn_Operaciones(indice).Moneda_Pasivo = Cartera.Cartera_Swap(k).Moneda_Bac
                                    AddOn.AddOn_Operaciones(indice).Capital_Pasivo = Cartera.Cartera_Swap(k).Saldo
                                    AddOn.AddOn_Operaciones(indice).Plazo_Pasivo = Cartera.Cartera_Swap(k).Plazo
                                    '4 Decimales plis
                                    AddOn.AddOn_Operaciones(indice).Duration_Pasivo = Format(Cartera.Cartera_Swap(k).Duration, FDec4Dec)
                                  End If
                        End If 'Condicion de inclusion del flujo
                         
                    End If 'Detecta Operacion
                    
                Else  'Existe
                    Exit For
                End If 'Existe
            Next k
            
        End If   'Tipo Swap <> 2
        If AddOn.AddOn_Operaciones(indice).Num_Operacion = 0 And AddOn.AddOn_Operaciones(indice).Sistema = "" Then

           indice = indice - 1
        Else
        
           indice = indice + 1
        End If
                  
    Next i
End Sub


Private Sub AddOn_Al_Vencimiento_SwapMet5(Cartera As Negociacion, AddOn As Datos_AddOn, iFecha As Date)
    Dim i As Long
    Dim k As Long
    Dim AddOnSwap As Long
    Dim AddOnErrorSwap As Long
    Dim indice As Long
        
    On Error Resume Next
        AddOnSwap = UBound(Cartera.Cartera_Swap)
        AddOnErrorSwap = Err.Number
    On Error GoTo 0
    If Not AddOnErrorSwap = 0 Then
        AddOnSwap = -1
    End If
          
    indice = 0
    
    
    For i = 0 To AddOnSwap
        If i = 0 Then
            ReDim Preserve AddOn.AddOn_Operaciones(0)
        End If
    
        If Cartera.Cartera_Swap(i).Numero_Operacion = AddOn.AddOn_Operaciones(indice).Num_Operacion Then
          
            ReDim Preserve AddOn.AddOn_Operaciones(indice)
                          
            AddOn.AddOn_Operaciones(indice).Num_Operacion = Cartera.Cartera_Swap(i).Numero_Operacion
            AddOn.AddOn_Operaciones(indice).Sistema = "PCS"
            AddOn.AddOn_Operaciones(indice).Producto = Cartera.Cartera_Swap(i).Tipo_swap
            AddOn.AddOn_Operaciones(indice).Tipo_Operacion = "C"

            If Cartera.Cartera_Swap(i).Tipo_flujo = 1 Then
              AddOn.AddOn_Operaciones(indice).Moneda_Activo = Cartera.Cartera_Swap(i).Moneda_Bac
              AddOn.AddOn_Operaciones(indice).Capital_Activo = Cartera.Cartera_Swap(i).Saldo
              AddOn.AddOn_Operaciones(indice).Plazo_Activo = Cartera.Cartera_Swap(i).Plazo
             
              AddOn.AddOn_Operaciones(indice).Duration_Activo = Format(Cartera.Cartera_Swap(i).Duration, FDec4Dec)
            
            End If
            
            If Cartera.Cartera_Swap(i).Tipo_flujo = 2 Then
              AddOn.AddOn_Operaciones(indice).Moneda_Pasivo = Cartera.Cartera_Swap(i).Moneda_Bac
              AddOn.AddOn_Operaciones(indice).Capital_Pasivo = Cartera.Cartera_Swap(i).Saldo
              AddOn.AddOn_Operaciones(indice).Plazo_Pasivo = Cartera.Cartera_Swap(i).Plazo
             
              AddOn.AddOn_Operaciones(indice).Duration_Pasivo = Format(Cartera.Cartera_Swap(i).Duration, FDec4Dec)
            End If

        End If
        
        If Cartera.Cartera_Swap(i).Numero_Operacion <> AddOn.AddOn_Operaciones(indice).Num_Operacion Then
            If i <> 0 Then
                indice = indice + 1
            End If
             ReDim Preserve AddOn.AddOn_Operaciones(indice)
            AddOn.AddOn_Operaciones(indice).Num_Operacion = Cartera.Cartera_Swap(i).Numero_Operacion
            AddOn.AddOn_Operaciones(indice).Sistema = "PCS"
            AddOn.AddOn_Operaciones(indice).Producto = Cartera.Cartera_Swap(i).Tipo_swap
            AddOn.AddOn_Operaciones(indice).Tipo_Operacion = "C"

            If Cartera.Cartera_Swap(k).Tipo_flujo = 1 Then
              AddOn.AddOn_Operaciones(indice).Moneda_Activo = Cartera.Cartera_Swap(i).Moneda_Bac
              AddOn.AddOn_Operaciones(indice).Capital_Activo = Cartera.Cartera_Swap(i).Saldo
              AddOn.AddOn_Operaciones(indice).Plazo_Activo = Cartera.Cartera_Swap(i).Plazo
             
              AddOn.AddOn_Operaciones(indice).Duration_Activo = Format(Cartera.Cartera_Swap(i).Duration, FDec4Dec)
             
            End If
            
            If Cartera.Cartera_Swap(k).Tipo_flujo = 2 Then
              AddOn.AddOn_Operaciones(indice).Moneda_Pasivo = Cartera.Cartera_Swap(i).Moneda_Bac
              AddOn.AddOn_Operaciones(indice).Capital_Pasivo = Cartera.Cartera_Swap(i).Saldo
              AddOn.AddOn_Operaciones(indice).Plazo_Pasivo = Cartera.Cartera_Swap(i).Plazo
             
              AddOn.AddOn_Operaciones(indice).Duration_Pasivo = Format(Cartera.Cartera_Swap(i).Duration, FDec4Dec)
            End If
        End If
    Next i
    
End Sub
Private Sub Carga_Detalle_ExpMax(iCliente As String, expom As Exposicion_Maxima, Cartera As Negociacion)
    'Dim miForm As New FRM_DETALLE_LCR
    Dim i As Long
    Dim Exp_Max As Long
    Dim ErrorExp_Max As Long
    Dim Lar_Met2 As Long
    Dim Error_Met2 As Long
    Dim AuxRut As String
    Dim AuxCodigo As String
    Dim nContador As Long
    
    With FRM_DETALLE_LCR.Grd_Datos
        .Rows = 2:          .FixedRows = 1
        .Cols = 14:         .FixedCols = 0
    
        .Font.Name = "Tahoma"
        .Font.Size = 8
        .RowHeightMin = 315
        .TextMatrix(0, 0) = "Fecha"
        .TextMatrix(0, 1) = "Rut"
        .TextMatrix(0, 2) = "Codigo"
        .TextMatrix(0, 3) = "Mtm"
        .TextMatrix(0, 4) = "Num Operación"
        .TextMatrix(0, 5) = "Early Term."
        .TextMatrix(0, 6) = "Tipo OP."
        .TextMatrix(0, 7) = "Cliente"
        .TextMatrix(0, 8) = "" '"No/Amt*1e15 "
        .TextMatrix(0, 9) = "" '"Plazo"
        .TextMatrix(0, 10) = "" '"Prc*1e15"
        .TextMatrix(0, 11) = "" '"AddOn"
        .TextMatrix(0, 12) = "" '"ValorMda*1e15"
        .TextMatrix(0, 13) = "" '"ParMoneda"
        
        .ColWidth(0) = 1000
        .ColWidth(1) = 1000
        .ColWidth(2) = 1000
        .ColWidth(3) = 2000
        .ColWidth(4) = 1500
        .ColWidth(5) = 1000
        .ColWidth(6) = 1000
        .ColWidth(7) = 2000
        .ColWidth(8) = 2000
        .ColWidth(9) = 1000
        .ColWidth(10) = 2000
        .ColWidth(11) = 2000
        .ColWidth(12) = 2000
        .ColWidth(13) = 2000
        .Rows = .Rows - 1
       
        On Error Resume Next
            Exp_Max = UBound(expom.Exp_Max)
            ErrorExp_Max = Err.Number
        On Error GoTo 0
    
        If Not ErrorExp_Max = 0 Then
            Exp_Max = -1
        End If
        
        On Error Resume Next
            Lar_Met2 = UBound(Cartera.Metodologia2)
            Error_Met2 = Err.Number
        On Error GoTo 0
        
        If Not Error_Met2 = 0 Then
            Lar_Met2 = -1
        End If
        
        
        Dim AuxFecha As Date
        AuxRut = ""
        AuxCodigo = ""
        For i = 0 To Exp_Max
         .Rows = .Rows + 1
         AuxFecha = expom.Exp_Max(i).Fecha
         AuxRut = expom.Exp_Max(i).Rut
         AuxCodigo = expom.Exp_Max(i).Cod
         .TextMatrix(.Rows - 1, 0) = expom.Exp_Max(i).Fecha
         .TextMatrix(.Rows - 1, 1) = expom.Exp_Max(i).Rut
         .TextMatrix(.Rows - 1, 2) = expom.Exp_Max(i).Cod
         .TextMatrix(.Rows - 1, 3) = Format(CDbl(expom.Exp_Max(i).Mtm), FDec0Dec)
         .TextMatrix(.Rows - 1, 4) = IIf(expom.Exp_Max(i).Operacion = 0, "En Curso", expom.Exp_Max(i).Operacion)
         .TextMatrix(.Rows - 1, 5) = IIf(expom.Exp_Max(i).EarlyTermination = "", "N", expom.Exp_Max(i).EarlyTermination)
         .TextMatrix(.Rows - 1, 6) = expom.Exp_Max(i).Tipo_Operacion
         .TextMatrix(.Rows - 1, 7) = iCliente
         .TextMatrix(.Rows - 1, 8) = ""
         .TextMatrix(.Rows - 1, 9) = ""
         .TextMatrix(.Rows - 1, 10) = ""
         .TextMatrix(.Rows - 1, 11) = ""
         .TextMatrix(.Rows - 1, 12) = ""
         .TextMatrix(.Rows - 1, 13) = ""
        Next
        
        If Lar_Met2 = -1 Then
            .ColWidth(8) = 0
            .ColWidth(9) = 0
            .ColWidth(10) = 0
            .ColWidth(11) = 0
            .ColWidth(12) = 0
            .ColWidth(13) = 0
        Else
            .TextMatrix(.Rows - 1, 8) = "No/Amt*1e15 "
            .TextMatrix(.Rows - 1, 9) = "Plazo"
            .TextMatrix(.Rows - 1, 10) = "Prc*1e15"
            .TextMatrix(.Rows - 1, 11) = "AddOn"
            .TextMatrix(.Rows - 1, 12) = "ValorMda*1e15"
            .TextMatrix(.Rows - 1, 13) = "ParMoneda"
        End If
        
        'Se Agrega A continuación
        For i = 0 To Lar_Met2
         .Rows = .Rows + 1
         .TextMatrix(.Rows - 1, 0) = AuxFecha
         .TextMatrix(.Rows - 1, 1) = AuxRut
         .TextMatrix(.Rows - 1, 2) = AuxCodigo
         .TextMatrix(.Rows - 1, 3) = Format(0, FDec0Dec)
         .TextMatrix(.Rows - 1, 4) = IIf(Cartera.Metodologia2(i).Numero_Operacion = 0, "En Curso", Cartera.Metodologia2(i).Numero_Operacion)
         .TextMatrix(.Rows - 1, 5) = ""
         .TextMatrix(.Rows - 1, 6) = Cartera.Metodologia2(i).Sistema + " " + Cartera.Metodologia2(i).Producto
         .TextMatrix(.Rows - 1, 7) = iCliente
         .TextMatrix(.Rows - 1, 8) = Format(CDbl(Cartera.Metodologia2(i).Amortizacion * 1E+15), FDec0Dec)
         .TextMatrix(.Rows - 1, 9) = Format(CDbl(Cartera.Metodologia2(i).Plazo), FDec0Dec)
         .TextMatrix(.Rows - 1, 10) = Format(CDbl(Cartera.Metodologia2(i).Prc * 1E+15), FDec0Dec)
         .TextMatrix(.Rows - 1, 11) = Format(CDbl(Cartera.Metodologia2(i).AddOn), FDec0Dec)
         .TextMatrix(.Rows - 1, 12) = Format(CDbl(Cartera.Metodologia2(i).ValorMoneda * 1E+15), FDec0Dec)
         .TextMatrix(.Rows - 1, 13) = Cartera.Metodologia2(i).LCRParMdaGruMda
        Next
        
        If .Rows > 1 Then
            .AllowUserResizing = flexResizeColumns
        Else
            .AllowUserResizing = flexResizeNone
        End If
            
        For nContador = 0 To .Cols - 1
             .Row = 0
             .Col = nContador
             '.TextStyle = TextStyleHeader
             .CellAlignment = flexAlignCenterCenter
             .WordWrap = True
        Next nContador

    End With
End Sub

Private Sub Carga_Grilla_AddOn(Cartera As Negociacion, iAddOn As Double, iFecha As Date)
    'Dim miForm As New FRM_DETALLE_LCR
    Dim nContador As Long
    With FRM_DETALLE_LCR.Grd_Datos
        .Rows = 2:          .FixedRows = 1
        .Cols = 13:         .FixedCols = 0
    
        .Font.Name = "Tahoma"
        .Font.Size = 8
        .RowHeightMin = 315
        .TextMatrix(0, 0) = "Fecha"
        .TextMatrix(0, 1) = "Rut"
        .TextMatrix(0, 2) = "Codigo"
        .TextMatrix(0, 3) = "AddOn"
        .TextMatrix(0, 4) = "Cliente"
        .TextMatrix(0, 5) = "Metodologia"
        .TextMatrix(0, 6) = ""
        .TextMatrix(0, 7) = ""
        .TextMatrix(0, 8) = ""
        .TextMatrix(0, 9) = ""
        .TextMatrix(0, 10) = ""
        .TextMatrix(0, 11) = ""
        .TextMatrix(0, 12) = ""
        
        .ColWidth(0) = 1000
        .ColWidth(1) = 1000
        .ColWidth(2) = 1000
        .ColWidth(3) = 2000
        .ColWidth(4) = 2000
        .ColWidth(5) = 1000
        .ColWidth(6) = 0
        .ColWidth(7) = 0
        .ColWidth(8) = 0
        .ColWidth(9) = 0
        .ColWidth(10) = 0
        .ColWidth(11) = 0
        .ColWidth(12) = 0
        .Rows = .Rows - 1
       
      
        .Rows = .Rows + 1
        .TextMatrix(.Rows - 1, 0) = iFecha 'Cartera.CalcRec(0).Fecha
        .TextMatrix(.Rows - 1, 1) = Cartera.Rut
        .TextMatrix(.Rows - 1, 2) = Cartera.Codigo
        .TextMatrix(.Rows - 1, 3) = Format(CDbl(iAddOn), FDec0Dec)
        .TextMatrix(.Rows - 1, 4) = Cartera.CLIENTE
        .TextMatrix(.Rows - 1, 5) = Cartera.Metodología
       
        If .Rows > 1 Then
           .AllowUserResizing = flexResizeColumns
        Else
           .AllowUserResizing = flexResizeNone
        End If
           
        For nContador = 0 To .Cols - 1
            .Row = 0
            .Col = nContador
           ' .TextStyle = TextStyleHeader
             .CellAlignment = flexAlignCenterCenter
            .WordWrap = True
        Next nContador
        
    End With
End Sub

Private Sub Carga_Grilla_AddOn90d(Matriz_DV01 As DV01_Operacion _
                                , AddON90d As Double _
                                , Optional iRut As Long = 0 _
                                , Optional iCodigo As Long = 0 _
                                , Optional iCliente As String = "")
    Dim i As Long
    Dim nContador As Long
    Dim Var As Long
    Dim ErrorVar As Long
    
    Dim TextAddOn90D As String
    TextAddOn90D = "Total AddON90d:"
    
   ' PRD 21119 - Consumo de Línea derivados ComDer
   ' Consulta por número de metodologia para cambiar nombre de Colum. x 3 días.
    If gsc_Parametros.iMetodologia = 6 Then
       TextAddOn90D = "Total AddON3d:"
    End If
     
    
    
    
    With FRM_DETALLE_LCR.Grd_Datos
        .Rows = 2:          .FixedRows = 1
        .Cols = 13:         .FixedCols = 0
    
        .Font.Name = "Tahoma"
        .Font.Size = 8
        .RowHeightMin = 315
        .TextMatrix(0, 0) = "Rut"
        .TextMatrix(0, 1) = "Codigo"
        .TextMatrix(0, 2) = "Cliente"
        .TextMatrix(0, 3) = "Operación"
        .TextMatrix(0, 4) = "Var"
        .TextMatrix(0, 5) = "Producto"
        .TextMatrix(0, 6) = ""
        .TextMatrix(0, 7) = ""
        .TextMatrix(0, 8) = ""
        .TextMatrix(0, 9) = ""
        .TextMatrix(0, 10) = ""
        .TextMatrix(0, 11) = ""
        .TextMatrix(0, 12) = ""
        
        .ColWidth(0) = 1500
        .ColWidth(1) = 1500
        .ColWidth(2) = 2000
        .ColWidth(3) = 2000
        .ColWidth(4) = 2000
        .ColWidth(5) = 2000
        .ColWidth(6) = 0
        .ColWidth(7) = 0
        .ColWidth(8) = 0
        .ColWidth(9) = 0
        .ColWidth(10) = 0
        .ColWidth(11) = 0
        .ColWidth(12) = 0
        
        .Rows = .Rows - 1
       
        On Error Resume Next
            Var = UBound(Matriz_DV01.Var)
            ErrorVar = Err.Number
        On Error GoTo 0
    
        If Not ErrorVar = 0 Then
            Var = -1
        End If
       
       For i = 0 To Var 'UBound(Matriz_DV01.Var)
       
        .Rows = .Rows + 1
        .TextMatrix(.Rows - 1, 0) = iRut
        .TextMatrix(.Rows - 1, 1) = iCodigo
        .TextMatrix(.Rows - 1, 2) = iCliente
        .TextMatrix(.Rows - 1, 3) = Format(CDbl(Matriz_DV01.Num_Operacion(i)), FDec0Dec)
        .TextMatrix(.Rows - 1, 4) = Format(CDbl(Matriz_DV01.Var(i)), FDec0Dec)
        .TextMatrix(.Rows - 1, 5) = Format(Matriz_DV01.Producto(i), "")
       
       Next
       FRM_DETALLE_LCR.txtExpMax.Visible = True
       FRM_DETALLE_LCR.lblExpMax.Visible = True
       FRM_DETALLE_LCR.lblExpMax = TextAddOn90D
       FRM_DETALLE_LCR.txtExpMax.Text = AddON90d
       
       If .Rows > 1 Then
            .AllowUserResizing = flexResizeColumns
       Else
            .AllowUserResizing = flexResizeNone
       End If
        
       For nContador = 0 To .Cols - 1
            .Row = 0
            .Col = nContador
           ' .TextStyle = TextStyleHeader
            .CellAlignment = flexAlignCenterCenter
            .WordWrap = True
       Next nContador
       
    End With
End Sub



Private Sub Carga_Matriz_Covarianza(Covar() As Double, Datos As Datos_Mercado)
    
    
    Dim i As Long
    Dim z As Long
    Dim Covarianza As Long
    Dim ErrorVar As Long
    Dim Corr_Variable  As Long
    Dim NomFilCol As String
    Dim nContador As Long
    
    
    With FRM_DETALLE_LCR.Grd_Datos

        
        .Rows = .Rows - 1
       
        On Error Resume Next
            Covarianza = UBound(Covar)
            ErrorVar = Err.Number
        On Error GoTo 0
    
        If Not ErrorVar = 0 Then
            Covarianza = -1
            MsgBox ("Cliente debe tener cartera derivados para obtener matriz Covarianza")
            Exit Sub
        End If
        
        .Rows = Covarianza + 2: .FixedRows = 1
        .Cols = Covarianza + 2: .FixedCols = 1
        
        For i = 0 To Covarianza
           
           Corr_Variable = i
             
           NomFilCol = Identifica_Variable_Covarianza(Datos, Corr_Variable)
             
           .TextMatrix(0, i + 1) = NomFilCol
           .TextMatrix(i + 1, 0) = NomFilCol
                         
           .ColWidth(i) = 2600
        Next
        
        
        For i = 0 To Covarianza
            For z = 0 To Covarianza
                    .TextMatrix(z + 1, i + 1) = Covar(i, z)
            Next
            
            If .Rows > 1 Then
                .AllowUserResizing = flexResizeColumns
            Else
                 .AllowUserResizing = flexResizeNone
            End If
        Next
        
        
        For nContador = 0 To .Cols - 1
            .Row = 0
            .Col = nContador
        '    .TextStyle = TextStyleHeader
            .CellAlignment = flexAlignCenterCenter
            .WordWrap = True
        Next nContador
        

       
    End With
End Sub



Private Sub Calc_MaxExp_Carteras(Fecha As Date, Cartera As Negociacion, Operacion() As Exp_Maxima _
                                            , Optional iRut As Long = 0 _
                                            , Optional iCodigo As Long = 0)
                      
        
    Dim ExpSwap As Long
    Dim ExpErrorSwap As Long
    Dim indice As Long
    Dim ExpFwd As Long
    Dim ExpErrorFwd As Long
    Dim ExpOpcion As Long
    Dim ExpErrorOpcion As Long
    Dim ExpFwd_RF As Long
    Dim ExpErrorFwd_RF As Long
    Dim i As Long

    On Error Resume Next
    ExpSwap = UBound(Cartera.Cartera_Swap)
    ExpErrorSwap = Err.Number
    On Error GoTo 0

    If Not ExpErrorSwap = 0 Then
    ExpSwap = -1
    End If
    
    
    'Almacena los datos en una estructura para la cartera swap
     
    For i = 0 To ExpSwap
        If ExpSwap >= 0 Then
            ReDim Preserve Operacion(i)
            Operacion(i).Fecha = Cartera.Cartera_Swap(i).Fecha_liq
            Operacion(i).Operacion = Cartera.Cartera_Swap(i).Numero_Operacion
            Operacion(i).Rut = iRut
            Operacion(i).Cod = iCodigo
            Operacion(i).Mtm = Round(Cartera.Cartera_Swap(i).Valor_Mercado, 0)
            Operacion(i).EarlyTermination = Cartera.Cartera_Swap(i).EarlyTermination
            Operacion(i).Tipo_Operacion = "Swap" + " " + Format(Cartera.Cartera_Swap(i).Tipo_swap, "")
        End If
    Next
              
    On Error Resume Next
        indice = UBound(Cartera.Cartera_Swap) + 1
        Error = Err.Number
    On Error GoTo 0
    
    On Error Resume Next
    ExpFwd = UBound(Cartera.Cartera_Fwd)
    ExpErrorFwd = Err.Number
    On Error GoTo 0
    If Not ExpErrorFwd = 0 Then
    ExpFwd = -1
    End If
             
    'Almacena los datos en una estructura para la cartera Fwd
    For i = 0 To ExpFwd
        If ExpFwd >= 0 Then
            ReDim Preserve Operacion(indice)
            Operacion(indice).Fecha = CDate(Cartera.Cartera_Fwd(i).Fecha_fin)
            Operacion(indice).Operacion = Cartera.Cartera_Fwd(i).Numero_Operacion
            Operacion(indice).Rut = iRut
            Operacion(indice).Cod = iCodigo
            Operacion(indice).Mtm = Round(Cartera.Cartera_Fwd(i).Valor_Mercado, 0)
            Operacion(indice).EarlyTermination = Cartera.Cartera_Fwd(i).EarlyTermination
            Operacion(indice).Tipo_Operacion = "Forward" + " " + Format(Cartera.Cartera_Fwd(i).Tipo_forward, "")
            Let indice = indice + 1
        End If
    Next
           
    On Error Resume Next
    ExpOpcion = UBound(Cartera.Cartera_Opcion)
    ExpErrorOpcion = Err.Number
    On Error GoTo 0
    If Not ExpErrorOpcion = 0 Then
    ExpOpcion = -1
    End If
                           
     'Almacena los datos en una estructura para la cartera Opcion
    For i = 0 To ExpOpcion
        If ExpOpcion >= 0 Then
            ReDim Preserve Operacion(indice)
            Operacion(indice).Fecha = Cartera.Cartera_Opcion(i).Vecto
            Operacion(indice).Operacion = Cartera.Cartera_Opcion(i).NumOp
            Operacion(indice).Rut = iRut
            Operacion(indice).Cod = iCodigo
            Operacion(indice).Mtm = Round(Cartera.Cartera_Opcion(i).Valor_Mercado, 0)
            Operacion(indice).EarlyTermination = Cartera.Cartera_Opcion(i).EarlyTermination
            Operacion(indice).Tipo_Operacion = "Opcion"
            Let indice = indice + 1
        End If
    Next
    
    
    On Error Resume Next
    ExpFwd_RF = UBound(Cartera.Cartera_Fwd_RF)
    ExpErrorFwd_RF = Err.Number
    On Error GoTo 0
    If Not ExpErrorFwd_RF = 0 Then
    ExpFwd_RF = -1
    End If
        
    'Almacena los datos en una estructura para la cartera Fwd_RF
    For i = 0 To ExpFwd_RF
        If ExpFwd_RF >= 0 Then
            ReDim Preserve Operacion(indice)
            Operacion(indice).Fecha = Cartera.Cartera_Fwd_RF(i).Fecha_Vecto_Fwd '.Fecha_Vecto  MAP
            Operacion(indice).Operacion = Cartera.Cartera_Fwd_RF(i).Numero_Operacion
            Operacion(indice).Rut = iRut
            Operacion(indice).Cod = iCodigo
            Operacion(indice).Mtm = Round(Cartera.Cartera_Fwd_RF(i).Valor_Mercado, 0)
            Operacion(indice).EarlyTermination = Cartera.Cartera_Fwd_RF(i).EarlyTermination
            Operacion(indice).Tipo_Operacion = "Forward_RF" + " " + Format(Cartera.Cartera_Fwd_RF(i).Producto, "")
            Operacion(indice).Producto = Format(Cartera.Cartera_Fwd_RF(i).Producto, "")
            Let indice = indice + 1
        End If
    Next
               
End Sub
Private Sub Carga_Grilla_ExpMaxima(Cartera As Negociacion)
    'Dim miForm As New FRM_DETALLE_LCR
    Dim i As Long
    Dim Exp_Max As Long
    Dim ErrorExp_Max As Long
    Dim nContador As Long

    With FRM_DETALLE_LCR.Grd_Datos
        .Rows = 2:          .FixedRows = 1
        .Cols = 13:         .FixedCols = 0
    
        .Font.Name = "Tahoma"
        .Font.Size = 8
        .RowHeightMin = 315
        .TextMatrix(0, 0) = "Fecha"
        .TextMatrix(0, 1) = "Rut"
        .TextMatrix(0, 2) = "Codigo"
        .TextMatrix(0, 3) = "Exposicion"
        .TextMatrix(0, 4) = "Nombre"
        .TextMatrix(0, 5) = ""
        .TextMatrix(0, 6) = ""
        .TextMatrix(0, 7) = ""
        .TextMatrix(0, 8) = ""
        .TextMatrix(0, 9) = ""
        .TextMatrix(0, 10) = ""
        .TextMatrix(0, 11) = ""
        .TextMatrix(0, 12) = ""
        
        .ColWidth(0) = 1000
        .ColWidth(1) = 1000
        .ColWidth(2) = 1000
        .ColWidth(3) = 2000
        .ColWidth(4) = 2000
        .ColWidth(5) = 0
        .ColWidth(6) = 0
        .ColWidth(7) = 0
        .ColWidth(8) = 0
        .ColWidth(9) = 0
        .ColWidth(10) = 0
        .ColWidth(11) = 0
        .ColWidth(12) = 0
        .Rows = .Rows - 1
       
        
        On Error Resume Next
            Exp_Max = UBound(Cartera.Fecha_Exp_Max)
            ErrorExp_Max = Err.Number
        On Error GoTo 0
    
        If Not ErrorExp_Max = 0 Then
            Exp_Max = -1
        End If
       
       For i = 0 To Exp_Max 'UBound(Cartera.Fecha_Exp_Max)
        If Cartera.Fecha_Exp_Max(i).Fecha <> "00:00:00" Then
            .Rows = .Rows + 1
            .TextMatrix(.Rows - 1, 0) = CDate(Cartera.Fecha_Exp_Max(i).Fecha)
            .TextMatrix(.Rows - 1, 1) = Cartera.Rut
            .TextMatrix(.Rows - 1, 2) = Cartera.Codigo
            .TextMatrix(.Rows - 1, 3) = Format(CDbl(Cartera.Fecha_Exp_Max(i).Max_Exp), FDec0Dec)
            .TextMatrix(.Rows - 1, 4) = Cartera.CLIENTE
            
        End If
       Next
       FRM_DETALLE_LCR.txtExpMax.Visible = True
       FRM_DETALLE_LCR.lblExpMax.Visible = True
       FRM_DETALLE_LCR.lblExpMax = "Exposición Maxima"
       FRM_DETALLE_LCR.txtExpMax.Text = Cartera.CalcRec(0).Exposicion_Maxima
       
       If .Rows > 1 Then
            .AllowUserResizing = flexResizeColumns
       Else
            .AllowUserResizing = flexResizeNone
       End If
       
       For nContador = 0 To .Cols - 1
            .Row = 0
            .Col = nContador
            '.TextStyle = TextStyleHeader
            .CellAlignment = flexAlignCenterCenter
            .WordWrap = True
       Next nContador
    End With
End Sub
Private Sub Carga_Grilla_Rec(Cartera As Negociacion)
    'Dim miForm As New FRM_DETALLE_LCR
    Dim CalcRec As Long
    Dim ErrorCalcRec As Long
    Dim nContador As Long
    
    Dim TextVaR As String
    TextVaR = "VaR90D"
    
   ' PRD 21119 - Consumo de Línea derivados ComDer
   ' Consulta por número de metodologia para cambiar nombre de Colum. x 3 días.
    If gsc_Parametros.iMetodologia = 6 Then
       TextVaR = "VaR3D"
    End If
     
    
    With FRM_DETALLE_LCR.Grd_Datos
        .Rows = 2:          .FixedRows = 1
        .Cols = 13:         .FixedCols = 0
    
        .Font.Name = "Tahoma"
        .Font.Size = 8
        .RowHeightMin = 315
        .TextMatrix(0, 0) = "Fecha"
        .TextMatrix(0, 1) = "Rut"
        .TextMatrix(0, 2) = "Codigo"
        .TextMatrix(0, 3) = "Cliente"
        .TextMatrix(0, 4) = "Linea"
        .TextMatrix(0, 5) = "Treshold"
        .TextMatrix(0, 6) = "Valor Mercado"
        .TextMatrix(0, 7) = "Exposicion Maxima"
        .TextMatrix(0, 8) = TextVaR
        .TextMatrix(0, 9) = "Garant.Ejec."
        .TextMatrix(0, 10) = "Consumo_Linea"
        .TextMatrix(0, 11) = "Holgura"
        .TextMatrix(0, 12) = "Estado Linea"
        
        .ColWidth(0) = 1000
        .ColWidth(1) = 1000
        .ColWidth(2) = 700
        .ColWidth(3) = 2000
        .ColWidth(4) = 1500
        .ColWidth(5) = 1500
        .ColWidth(6) = 1500
        .ColWidth(7) = 1500
        .ColWidth(8) = 1500
        .ColWidth(9) = 1000
        .ColWidth(10) = 1500
        .ColWidth(11) = 1500
        .ColWidth(12) = 2000
        .Rows = .Rows - 1
            
        .Rows = .Rows + 1
         On Error Resume Next
            CalcRec = UBound(Cartera.CalcRec)
            ErrorCalcRec = Err.Number
         On Error GoTo 0
    
         If Not ErrorCalcRec = 0 Then
            CalcRec = -1
         End If
         If CalcRec >= 0 Then
        .TextMatrix(.Rows - 1, 0) = Cartera.CalcRec(0).Fecha
        .TextMatrix(.Rows - 1, 1) = Cartera.CalcRec(0).Rut
        .TextMatrix(.Rows - 1, 2) = Cartera.CalcRec(0).Codigo
        .TextMatrix(.Rows - 1, 3) = Cartera.CalcRec(0).Nombre
        .TextMatrix(.Rows - 1, 4) = Format(CDbl(Cartera.CalcRec(0).Linea), FDec0Dec)
        .TextMatrix(.Rows - 1, 5) = Format(CDbl(Cartera.CalcRec(0).Treshold), FDec0Dec)
        .TextMatrix(.Rows - 1, 6) = Format(CDbl(Cartera.CalcRec(0).Valor_Mercado), FDec0Dec)
        .TextMatrix(.Rows - 1, 7) = Format(CDbl(Cartera.CalcRec(0).Exposicion_Maxima), FDec0Dec)
        .TextMatrix(.Rows - 1, 8) = Format(CDbl(Cartera.CalcRec(0).VaR90D), FDec0Dec)
        .TextMatrix(.Rows - 1, 9) = Cartera.CalcRec(0).Garantia_Ejecutada
        .TextMatrix(.Rows - 1, 10) = Format(CDbl(Cartera.CalcRec(0).Consumo_Linea), FDec0Dec)
        .TextMatrix(.Rows - 1, 11) = Format(CDbl(Cartera.CalcRec(0).Holgura), FDec0Dec)
        .TextMatrix(.Rows - 1, 12) = Cartera.CalcRec(0).Estado_Linea
         End If
        If .Rows > 1 Then
            .AllowUserResizing = flexResizeColumns
        Else
            .AllowUserResizing = flexResizeNone
        End If
              
        For nContador = 0 To .Cols - 1
            .Row = 0
            .Col = nContador
            '.TextStyle = TextStyleHeader
            .CellAlignment = flexAlignCenterCenter
            .WordWrap = True
        Next nContador
        
    End With
End Sub
Private Function Max(A As Double, b As Double)
    If A > b Then

        Max = A
    Else
        Max = b
    End If
End Function








Private Function Var(Matriz_DV01 As DV01_Operacion)
    Dim TotalVar As Double
    Dim i As Long
    Let TotalVar = 0
    For i = 0 To UBound(Matriz_DV01.Var)
            TotalVar = TotalVar + Matriz_DV01.Var(i)
    Next
    Var = TotalVar
End Function
Private Function Expmax(Cartera() As Resultado_Exp_Max)
    Expmax = Cartera(0).Result_exp_Max
End Function


Private Function MTMCarteraTotal(Cartera As Negociacion)
   Dim Mtm As Double
   Dim ArregloFlujos() As Flujos
   Dim i As Long
   Dim indice As Long
   
   'ArregloFlujos es la temporal
   
   Dim ErrorSwap As Integer
   Dim ErrorForward As Integer
   Dim ErrorOpcion As Integer
   Dim ErrorForward_RF As Integer
     
   Dim limSwap  As Integer
   Dim limForward  As Integer
   Dim limOpcion  As Integer
   Dim limForwar_RF  As Integer
   
   
   
   On Error Resume Next
        limSwap = UBound(Cartera.Cartera_Swap, 1)
        ErrorSwap = Err.Number
   On Error GoTo 0
   If Not ErrorSwap = 0 Then
        limSwap = -1
   End If
   
   On Error Resume Next
        limForward = UBound(Cartera.Cartera_Fwd, 1)
        ErrorForward = Err.Number
   On Error GoTo 0
   If Not ErrorForward = 0 Then
        limForward = -1
   End If
   
   
   On Error Resume Next
        limOpcion = UBound(Cartera.Cartera_Opcion, 1)
        ErrorOpcion = Err.Number
   On Error GoTo 0
   If Not ErrorOpcion = 0 Then
        limOpcion = -1
   End If
   
   On Error Resume Next
        limForwar_RF = UBound(Cartera.Cartera_Fwd_RF, 1)
        ErrorForward_RF = Err.Number
   On Error GoTo 0
   If Not ErrorForward_RF = 0 Then
        limForwar_RF = -1
   End If
   
    
   Let Mtm = 0
   'Carga de Flujos de Forward
   Let indice = 0
   For i = 0 To limForward
        Let Mtm = Mtm + Cartera.Cartera_Fwd(i).Valor_Mercado
   Next
   
   'Carga de Flujos de Swap
   For i = 0 To limSwap
        Let Mtm = Mtm + Cartera.Cartera_Swap(i).Valor_Mercado
   Next
   
   'Carga de Flujos de Opcion
   For i = 0 To limOpcion
        Let Mtm = Mtm + Cartera.Cartera_Opcion(i).Valor_Mercado
   Next
   
   'Carga de Flujos de Forward_RF
   For i = 0 To limForwar_RF
        Let Mtm = Mtm + Cartera.Cartera_Fwd_RF(i).Valor_Mercado
   Next
     
   MTMCarteraTotal = Mtm
End Function
Private Sub Rescata_Datos_Mercado(Datos() As Datos_Mercado, Numero_Simulaciones As Long _
                                 , Valdatos As Procesos)
    
    'Obtiene el vector de fechas de los datos, OK Migracion BAC
    If Valdatos.ErrorcargaDatos = False Then
        ConsultaSQL_Fechas Datos, Numero_Simulaciones, Valdatos
    End If
    'Query de tasas, OK Migracion BAC, se hizo mini modelo en BacLineas
    If Valdatos.ErrorcargaDatos = False Then
        ConsultaSQL_Tasas Datos, Valdatos, Numero_Simulaciones
    End If
    'Query de monedas, OK Migracion BAC, se hizo mini modelo en BacLineas
    If Valdatos.ErrorcargaDatos = False Then
        ConsultaSQL_Moneda Datos, Valdatos, Numero_Simulaciones
    End If
    'Query de la superficie de volatilidades, OK Migracion BAC
    If Valdatos.ErrorcargaDatos = False Then
        ConsultaSQL_VolSfce Datos, Valdatos, Numero_Simulaciones
    End If
    'Query de ICP y UF, OK Migracion BAC e IBR
    If Valdatos.ErrorcargaDatos = False Then
        ConsultaSQL_ICP_UF Datos(0), Valdatos   '-> Indicador de IBR, igualado en fechas con la UF y el ICP
    End If
    If Valdatos.ErrorcargaDatos = False Then
        Calcula_Vol_Strikes Datos(0)
    End If
    
End Sub

Private Sub ConsultaSQL_Tasas(Datos() As Datos_Mercado, Valdatos As Procesos _
                                                , Numero_Simulaciones As Long)
    Dim SAOCurvasPropias As String
    Let SAOCurvasPropias = SAOCurvasPropiasSN()
                                                           
    'Rescata tasas swap
    If Valdatos.ErrorcargaDatos = False Then
        ConsultaSQL_Tasas_Swap Datos, Valdatos, Numero_Simulaciones
    End If
    If Not SAOCurvasPropias = "N" Then
        'Rescata tasas opcion
        If Valdatos.ErrorcargaDatos = False Then
            ConsultaSQL_Tasas_Opcion Datos, Valdatos, Numero_Simulaciones
        End If
    End If
    'Rescata tasas forward
    If Valdatos.ErrorcargaDatos = False Then
        ConsultaSQL_Tasas_Fwd Datos, Valdatos, Numero_Simulaciones
    End If
    'Rescata tasas de renta fija
    If Valdatos.ErrorcargaDatos = False Then
        ConsultaSQL_Tasas_RF Datos, Valdatos, Numero_Simulaciones
    End If

End Sub
Private Sub ConsultaSQL_Tasas_Swap(Datos() As Datos_Mercado, Valdatos As Procesos _
                                                    , Numero_Simulaciones As Long)
    Dim i As Long
    Dim j As Long
    Dim k As Long
    Dim Cont As Long
    Dim Tabla() As Variant
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    
    Dim ErrorConTasasSwap As Double
    Dim ConsultaTasasSwap As Integer
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "SP_RIEFIN_CONSULTA_TASAS"
    Set Proc_Alm.ActiveConnection = Conexion
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , Datos(0).Fecha)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Producto", adVarChar, adParamInput, 31, "Swap")
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Numero_Simulaciones", adInteger, adParamInput, , Numero_Simulaciones)
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorConTasasSwap = Err.Number
        Valdatos.ErrorNumero = Err.Number
        Valdatos.ErrorDescripcion = Err.Description
        Valdatos.ErrorSP = Proc_Alm.CommandText
        Valdatos.ErrorcargaDatos = False
    On Error GoTo 0
    
    ConsultaTasasSwap = 0
    If Not ErrorConTasasSwap = 0 Then
        ConsultaTasasSwap = -1
        Valdatos.ErrorcargaDatos = True
    End If
    
    If ConsultaTasasSwap = -1 Then
         Exit Sub
    End If
        
    Tabla = rs.GetRows
    rs.Close
    
    'Almacena los datos en una estructura para tasas
    i = -1
    For k = 0 To UBound(Tabla, 2)
        
        Do While Datos(Cont).Fecha > Tabla(0, k)
        'Es una nueva fecha
            Cont = Cont + 1
            i = -1
        Loop
        
        If i < Tabla(1, k) Then
        'Es una nueva curva
            i = Tabla(1, k)
            ReDim Preserve Datos(Cont).Tasas_Swap(i)
            j = 0
        End If
        ReDim Preserve Datos(Cont).Tasas_Swap(i).Par(j)
        Datos(Cont).Tasas_Swap(i).Par(j).Plazo = Tabla(2, k)
        Datos(Cont).Tasas_Swap(i).Par(j).Tasa = Tabla(3, k) / 100
        j = j + 1
        
    Next
    
End Sub
Private Sub ConsultaSQL_Tasas_Opcion(Datos() As Datos_Mercado, Valdatos As Procesos _
                                                    , Numero_Simulaciones As Long)
    Dim i As Long
    Dim j As Long
    Dim k As Long
    Dim Cont As Long
    Dim Tabla() As Variant
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    
    Dim ErrorConTasasOpcion As Double
    Dim ConsultaTasasOpcion As Integer
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "SP_RIEFIN_CONSULTA_TASAS"
    Set Proc_Alm.ActiveConnection = Conexion
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , Datos(0).Fecha)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Producto", adVarChar, adParamInput, 31, "Opciones")
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Numero_Simulaciones", adInteger, adParamInput, , Numero_Simulaciones)
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorConTasasOpcion = Err.Number
        Valdatos.ErrorNumero = Err.Number
        Valdatos.ErrorDescripcion = Err.Description
        Valdatos.ErrorSP = Proc_Alm.CommandText
        Valdatos.ErrorcargaDatos = False
    On Error GoTo 0
    
    ConsultaTasasOpcion = 0
    If Not ErrorConTasasOpcion = 0 Then
        ConsultaTasasOpcion = -1
        Valdatos.ErrorcargaDatos = True
    End If
    
    If ConsultaTasasOpcion = -1 Then
         Exit Sub
    End If
        
    Tabla = rs.GetRows
    rs.Close
    
    'Almacena los datos en una estructura para tasas
    i = -1
    For k = 0 To UBound(Tabla, 2)
        
        Do While Datos(Cont).Fecha > Tabla(0, k)
        'Es una nueva fecha
            Cont = Cont + 1
            i = -1
        Loop
        
        If i < Tabla(1, k) Then
        'Es una nueva curva
            i = Tabla(1, k)
            ReDim Preserve Datos(Cont).Tasas_Opcion(i)
            j = 0
        End If
        ReDim Preserve Datos(Cont).Tasas_Opcion(i).Par(j)
        Datos(Cont).Tasas_Opcion(i).Par(j).Plazo = Tabla(2, k)
        Datos(Cont).Tasas_Opcion(i).Par(j).Tasa = Tabla(3, k) / 100
        j = j + 1
        
    Next
    
End Sub
Private Sub ConsultaSQL_Tasas_Fwd(Datos() As Datos_Mercado, Valdatos As Procesos _
                                                    , Numero_Simulaciones As Long)
    
    Dim i As Long
    Dim j As Long
    Dim k As Long
    Dim Cont As Long
    Dim Tabla() As Variant
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    Dim ConsultaTasasFwd As Integer
    Dim ErrorConTasasFwd As Double
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "SP_RIEFIN_CONSULTA_TASAS"
    Set Proc_Alm.ActiveConnection = Conexion
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , Datos(0).Fecha)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Producto", adVarChar, adParamInput, 31, "Forward")
     Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Numero_Simulaciones", adInteger, adParamInput, , Numero_Simulaciones)
    'Ejecuta el procedimiento
     On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorConTasasFwd = Err.Number
        Valdatos.ErrorNumero = Err.Number
        Valdatos.ErrorDescripcion = Err.Description
        Valdatos.ErrorSP = Proc_Alm.CommandText
        Valdatos.ErrorcargaDatos = False
    On Error GoTo 0
    
    ConsultaTasasFwd = 0
    If Not ErrorConTasasFwd = 0 Then
        ConsultaTasasFwd = -1
        Valdatos.ErrorcargaDatos = True
    End If
    
    If ConsultaTasasFwd = -1 Then
         Exit Sub
    End If
        
    Tabla = rs.GetRows
    rs.Close
    
    'Almacena los datos en una estructura para tasas
    i = -1
    For k = 0 To UBound(Tabla, 2)
        
        Do While Datos(Cont).Fecha > Tabla(0, k)
        'Es una nueva fecha
            Cont = Cont + 1
            i = -1
        Loop
        
        If i < Tabla(1, k) Then
        'Es una nueva curva
            i = Tabla(1, k)
            ReDim Preserve Datos(Cont).Tasas_Fwd(i)
            j = 0
        End If
        ReDim Preserve Datos(Cont).Tasas_Fwd(i).Par(j)
        Datos(Cont).Tasas_Fwd(i).Par(j).Plazo = Tabla(2, k)
        Datos(Cont).Tasas_Fwd(i).Par(j).Tasa = Tabla(3, k) / 100
        j = j + 1
        
    Next
    
End Sub
 Private Sub ConsultaSQL_Tasas_RF(Datos() As Datos_Mercado, Valdatos As Procesos _
                                                   , Numero_Simulaciones As Long)
    
    Dim i As Long
    Dim j As Long
    Dim k As Long
    Dim Cont As Long
    Dim Tabla() As Variant
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    Dim ConsultaTasasRF As Integer
    Dim ErrorConTasasRF As Double
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "SP_RIEFIN_CONSULTA_TASAS"
    Set Proc_Alm.ActiveConnection = Conexion
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , Datos(0).Fecha)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Producto", adVarChar, adParamInput, 31, "RF")
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Numero_Simulaciones", adInteger, adParamInput, , Numero_Simulaciones)

    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorConTasasRF = Err.Number
        Valdatos.ErrorNumero = Err.Number
        Valdatos.ErrorDescripcion = Err.Description
        Valdatos.ErrorSP = Proc_Alm.CommandText
        Valdatos.ErrorcargaDatos = False
    On Error GoTo 0
    
    ConsultaTasasRF = 0
    If Not ErrorConTasasRF = 0 Then
        ConsultaTasasRF = -1
        Valdatos.ErrorcargaDatos = True
    End If
    
    If ConsultaTasasRF = -1 Then
         Exit Sub
    End If
        
    Tabla = rs.GetRows
    rs.Close
    
    'Almacena los datos en una estructura para tasas
    i = -1
    For k = 0 To UBound(Tabla, 2)
        
        Do While Datos(Cont).Fecha > Tabla(0, k)
        'Es una nueva fecha
            Cont = Cont + 1
            i = -1
        Loop
        
        If i < Tabla(1, k) Then
        'Es una nueva curva
            i = Tabla(1, k)
            ReDim Preserve Datos(Cont).Tasas_RF(i)
            j = 0
        End If
        ReDim Preserve Datos(Cont).Tasas_RF(i).Par(j)
        Datos(Cont).Tasas_RF(i).Par(j).Plazo = Tabla(2, k)
        Datos(Cont).Tasas_RF(i).Par(j).Tasa = Tabla(3, k) / 100
        j = j + 1
    Next
    
End Sub
Private Sub ConsultaSQL_Moneda(Datos() As Datos_Mercado, Valdatos As Procesos _
                                                , Numero_Simulaciones As Long)
    
    Dim k As Long
    Dim i As Long
    Dim Cont As Long
    Dim Tabla() As Variant
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    Dim ConsultaMoneda As Integer
    Dim ErrorConMoneda As Double
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "SP_RIEFIN_CONSULTA_MONEDAS"
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , Datos(0).Fecha)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Numero_Simulaciones", adInteger, adParamInput, , Numero_Simulaciones)
    Set Proc_Alm.ActiveConnection = Conexion
    
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorConMoneda = Err.Number
        Valdatos.ErrorNumero = Err.Number
        Valdatos.ErrorDescripcion = Err.Description
        Valdatos.ErrorSP = Proc_Alm.CommandText
        Valdatos.ErrorcargaDatos = False
    On Error GoTo 0
    
    ConsultaMoneda = 0
    If Not ErrorConMoneda = 0 Then
        ConsultaMoneda = -1
        Valdatos.ErrorcargaDatos = True
    End If
    
    If ConsultaMoneda = -1 Then
         Exit Sub
    End If
    Tabla = rs.GetRows
    rs.Close
       
    'Inicializacion de la moneda pesos
    ReDim Datos(0).Paridad(0)
    Datos(0).Paridad(0) = 1
    
    'Almacena las monedas encontradas
    i = 1
    'Almacena los datos
    For k = 0 To UBound(Tabla, 2)
        
        Do While Datos(Cont).Fecha > Tabla(0, k)
        'Es una nueva fecha
            Cont = Cont + 1
            'Inicializacion de la moneda pesos
            ReDim Datos(Cont).Paridad(0)
            Datos(Cont).Paridad(0) = 1
        Loop
        
        i = Tabla(1, k)
        ReDim Preserve Datos(Cont).Paridad(i)
        Datos(Cont).Paridad(i) = Tabla(2, k)
        
    Next
    
    For i = 0 To UBound(Tabla) 'UBound(DATOS)
        Calcula_TCContable Datos(i), Valdatos
        If Valdatos.ErrorcargaDatos = True Then
            Exit Sub
        End If
    Next
    
End Sub
Private Sub Calcula_TCContable(Datos As Datos_Mercado, Valdatos As Procesos)
    
    Dim i As Long
    Dim Largo As Long
    Dim ErrorCont As Long
    
On Error Resume Next
    Largo = UBound(Datos.Paridad)
    ReDim Datos.TC(Largo)
    
    For i = 0 To 2
        Datos.TC(i) = Datos.Paridad(i)
    Next
    
    For i = 3 To Largo
        Datos.TC(i) = Datos.Paridad(2) * Datos.Paridad(i)
    Next
    
        ErrorCont = Err.Number
            Valdatos.ErrorNumero = Err.Number
            Valdatos.ErrorDescripcion = Err.Description
        Valdatos.ErrorcargaDatos = False

    On Error GoTo 0

    If Not ErrorCont = 0 Then
            Valdatos.ErrorcargaDatos = True
        End If

    
End Sub

Private Sub ConsultaSQL_VolSfce(Datos() As Datos_Mercado, Valdatos As Procesos _
                                                    , Numero_Simulaciones As Long)
'Funcion que rescata los datos de volatilidad de mercado y construye la superficie.
'Es muy importante que ya se hayan cargados las tasas y tipos de cambio en la estructura Datos

    Dim i As Long
    Dim j As Long
    Dim k As Long
    Dim n As Long
    Dim Cont As Long
    Dim Tabla() As Variant
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    Dim ConsultaVolSfce As Integer
    Dim ErrorConVolSfce As Double
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "SP_RIEFIN_CONSULTA_VOLSFCE"
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , Datos(0).Fecha)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Numero_Simulaciones", adInteger, adParamInput, , Numero_Simulaciones)

    Set Proc_Alm.ActiveConnection = Conexion
    
    'Ejecuta el procedimiento
    'Si asigna la matriz devuelta por GetRows a un
    'rango de celdas de la hoja de cálculo, los
    'datos va en las columnas en lugar de en las filas.
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorConVolSfce = Err.Number
        Valdatos.ErrorNumero = Err.Number
        Valdatos.ErrorDescripcion = Err.Description
        Valdatos.ErrorSP = Proc_Alm.CommandText
        Valdatos.ErrorcargaDatos = False
    On Error GoTo 0
    
    ConsultaVolSfce = 0
    If Not ErrorConVolSfce = 0 Then
        ConsultaVolSfce = -1
        Valdatos.ErrorcargaDatos = True
    End If
    
    If ConsultaVolSfce = -1 Then
         Exit Sub
    End If
   
    Tabla = rs.GetRows
    rs.Close
    
    'Tabla(0)
    
    i = -1
    'Almacena las superficies de volatilidades
    For k = 0 To UBound(Tabla, 2)
        
        Do While Datos(Cont).Fecha > Tabla(0, k)
        'Es una nueva fecha
            Cont = Cont + 1
            i = -1
        Loop
        
        If i < Tabla(1, k) Then
        'Es una nueva superficie
            i = Tabla(1, k)
            ReDim Preserve Datos(Cont).Vol(i)
            Datos(Cont).Vol(i).Codigo_Moneda = Tabla(2, k)
            Datos(Cont).Vol(i).Codigo_rd = Tabla(3, k)
            Datos(Cont).Vol(i).Codigo_rf = Tabla(4, k)
            j = 0
        End If
        ReDim Preserve Datos(Cont).Vol(i).Superf(j)
        Datos(Cont).Vol(i).Superf(j).Plazo = Tabla(5, k)
        For n = 0 To 4
            Datos(Cont).Vol(i).Superf(j).Par(n).Vol = Tabla(n + 6, k) / 100
        Next
        j = j + 1
    Next
    
        
End Sub
Private Sub ConsultaSQL_ICP_UF(ByRef Datos As Datos_Mercado, Valdatos As Procesos)
    
    Dim i As Long
    Dim j As Long
    Dim ICP() As Tabla_Datos
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    Dim ConsultaICPUF As Integer
    Dim ErrorConICPUF As Double
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "SP_RIEFIN_CONSULTA_ICP_UF"      '-> Indicador de IBR, igualado en fechas con la UF y el ICP
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , Datos.Fecha)
    Set Proc_Alm.ActiveConnection = Conexion
    'Ejecuta el procedimiento
   
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorConICPUF = Err.Number
        Valdatos.ErrorNumero = Err.Number
        Valdatos.ErrorDescripcion = Err.Description
        Valdatos.ErrorSP = Proc_Alm.CommandText
        Valdatos.ErrorcargaDatos = False
    On Error GoTo 0
    
    ConsultaICPUF = 0
    If Not ErrorConICPUF = 0 Then
        ConsultaICPUF = -1
        Valdatos.ErrorcargaDatos = True
    End If
    
    If ConsultaICPUF = -1 Then
         Exit Sub
    End If
    
    'Almacena los datos
    Do While rs.EOF = False
        ReDim Preserve Datos.ICP(i)
        ReDim Preserve Datos.UF(i)
        ReDim Preserve Datos.IBR(i)
        
        Datos.ICP(i).Fecha = rs(0)
        Datos.UF(i).Fecha = rs(0)
        Datos.IBR(i).Fecha = rs(0)  '-> MAP 08-Sep-2014
        Datos.ICP(i).Valor = rs(1)
        Datos.UF(i).Valor = rs(2)
        
        Datos.IBR(i).Valor = rs(4)  '-> Indicador de IBR, igualado en fechas con la UF y el ICP
        
        rs.MoveNext
        i = i + 1
    Loop
    rs.Close
    
End Sub
Private Sub ConsultaSQL_Fechas(Datos() As Datos_Mercado, Numero_Simulaciones As Long _
                              , Valdatos As Procesos)
    
    Dim i As Long
    Dim j As Long
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    Dim ConsultaFechas As Integer
    Dim ErrorConFechas As Double
    
    'Por indicacion Microsof
    'adDate debe ser reemplazar adDBTimeStamp
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "SP_RIEFIN_CONSULTA_FECHAS"
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , Datos(0).Fecha)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Numero_Simulaciones", adInteger, adParamInput, , Numero_Simulaciones)
    Set Proc_Alm.ActiveConnection = Conexion
    'Ejecuta el procedimiento
    
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorConFechas = Err.Number
        Valdatos.ErrorNumero = Err.Number
        Valdatos.ErrorDescripcion = Err.Description
        Valdatos.ErrorSP = Proc_Alm.CommandText
        Valdatos.ErrorcargaDatos = False
    On Error GoTo 0
    
    ConsultaFechas = 0
    If Not ErrorConFechas = 0 Then
        ConsultaFechas = -1
        Valdatos.ErrorcargaDatos = True
    End If
    
    If ConsultaFechas = -1 Then
          Exit Sub
    End If
              
    'Almacena las fechas encontradas
    For i = 0 To Numero_Simulaciones
        Datos(i).Fecha = rs(0)
        rs.MoveNext
    Next
    
    rs.Close
End Sub
Private Sub Rescata_Cartera_Trading(Datos As Datos_Mercado, Cartera As Negociacion, Valdatos As Procesos, largo_vector As Long _
                        , Optional iRut As Long = 0 _
                        , Optional iCodigo As Long = 0)
        
    'Ingresa las operaciones de la cartera swap
    If Valdatos.ErrorcargaDatos = False Then
        Erase Cartera.Cartera_Swap
        ConsultaSQL_Cartera_Swap Datos.Fecha, Cartera.Cartera_Swap, Valdatos, iRut, iCodigo
    End If
    'Ingresa las operaciones de la cartera forward
    If Valdatos.ErrorcargaDatos = False Then
        Erase Cartera.Cartera_Fwd
        ConsultaSQL_Cartera_Fwd Datos.Fecha, Cartera.Cartera_Fwd, Valdatos, iRut, iCodigo
    End If
    'Ingresa las operaciones de la cartera de opciones
    If Valdatos.ErrorcargaDatos = False Then
        Erase Cartera.Cartera_Opcion
        ConsultaSQL_Cartera_Opcion Datos.Fecha, Cartera.Cartera_Opcion, Valdatos, iRut, iCodigo
    End If
    'Ingresa las operaciones de la cartera fwd de renta fija
    If Valdatos.ErrorcargaDatos = False Then
        Erase Cartera.Cartera_Fwd_RF
        ConsultaSQL_Cartera_FWD_RF Datos.Fecha, Cartera.Cartera_Fwd_RF, Valdatos, iRut, iCodigo
    End If
    
End Sub
Private Sub Agrupa_Cartera_MaxExp(Fecha As Date, Operacion() As Exp_Max_Fecha, expom As Exposicion_Maxima, Optional iRut As Long = 0 _
                                                                                             , Optional iCodigo As Long = 0)
    Dim i As Long
    Dim j As Long
    Dim z As Long
    Dim indice As Long
    Dim Existe As Integer
    
    Dim LargoArrExpMax As Long
    Dim ErrorArrExpMax As Long
    
    
    On Error Resume Next
    LargoArrExpMax = UBound(expom.Exp_Max)
    ErrorArrExpMax = Err.Number
    On Error GoTo 0
    
    
    If ErrorArrExpMax = 0 Then
        'Suma mtm por fecha
        indice = 0
        For i = 0 To UBound(expom.Exp_Max)
            ReDim Preserve Operacion(indice)
            For z = 0 To indice
                Existe = 0
                If expom.Exp_Max(i).Fecha = Operacion(z).Fecha Then
                    Existe = 1
                    indice = indice - 1
                    Exit For
                End If
            Next z
           If Existe = 0 Then
                For j = 0 To UBound(expom.Exp_Max)
                    
                   If expom.Exp_Max(i).Fecha = expom.Exp_Max(j).Fecha Then
                                         
                        If expom.Exp_Max(j).EarlyTermination <> "S" Then
                            ReDim Preserve Operacion(indice)
                            Operacion(indice).Fecha = expom.Exp_Max(j).Fecha
                            Operacion(indice).Max_Exp = Operacion(indice).Max_Exp + expom.Exp_Max(j).Mtm
                        End If
                        
                    End If
                Next
            End If
            indice = indice + 1
        Next
    End If
End Sub
Private Sub Calc_Cons_Resul_MaxExp(Fecha As Date, Cartera As Negociacion _
                                                , expom As Exposicion_Maxima _
                                                , Optional iRut As Long = 0 _
                                                , Optional iCodigo As Long = 0)


    Calc_MaxExp_Carteras Fecha, Cartera, expom.Exp_Max, iRut, iCodigo

    Agrupa_Cartera_MaxExp Fecha, Cartera.Fecha_Exp_Max, expom, iRut, iCodigo
    
    Ordena_Cartera_MaxExp Fecha, Cartera.Total_Exp_maxima, Cartera, iRut, iCodigo

End Sub

Private Sub Ordena_Cartera_MaxExp(Fecha As Date, Operacion() As Resultado_Exp_Max, Cartera As Negociacion, Optional iRut As Long = 0 _
                                                                                              , Optional iCodigo As Long = 0)
    'Almacena y ordena datos por fecha,en una estructura para la cartera
              
    Dim Min As Long
    Dim Max As Long
    Dim actual As Long
    Dim i As Long
    Dim t As Date
    Dim r As Double
    Dim LargoAux As Long
    Dim ErrorLargoAux As Long
    Dim Num_Flujos As Long
    Dim j As Long
    Dim Existe As Long
        
    On Error Resume Next
    LargoAux = LBound(Cartera.Fecha_Exp_Max)
    ErrorLargoAux = Err.Number
    On Error GoTo 0
    
    
    Let t = "00:00:00"
    Let r = 0

    
    If ErrorLargoAux = 0 Then
    
        Max = UBound(Cartera.Fecha_Exp_Max)
        
        actual = Min + 1
        
        While actual <= Max
            i = actual
            Do
                If i > Min Then
                
                    If Cartera.Fecha_Exp_Max(i).Fecha >= Cartera.Fecha_Exp_Max(i - 1).Fecha Then
                        t = Cartera.Fecha_Exp_Max(i).Fecha
                        r = Cartera.Fecha_Exp_Max(i).Max_Exp
                        
                        Cartera.Fecha_Exp_Max(i).Fecha = Cartera.Fecha_Exp_Max(i - 1).Fecha
                        Cartera.Fecha_Exp_Max(i).Max_Exp = Cartera.Fecha_Exp_Max(i - 1).Max_Exp
                        Cartera.Fecha_Exp_Max(i - 1).Fecha = t
                        Cartera.Fecha_Exp_Max(i - 1).Max_Exp = r
                        i = i - 1
                    Else
                        Exit Do
                    End If
                      
                Else
                    Exit Do
                End If
                  
            Loop
            actual = actual + 1
        Wend
        
      'Suma lo ordenado desde la fecha mas futura a la mas reciente
        i = 0
        Num_Flujos = UBound(Cartera.Fecha_Exp_Max)
        
        For i = 0 To Num_Flujos
        
            If i = 0 Then
                Cartera.Fecha_Exp_Max(i).Max_Exp = Cartera.Fecha_Exp_Max(i).Max_Exp
            ElseIf Cartera.Fecha_Exp_Max(i).Fecha <> "00:00:00" Then
                Cartera.Fecha_Exp_Max(i).Max_Exp = Cartera.Fecha_Exp_Max(i).Max_Exp + Cartera.Fecha_Exp_Max(i - 1).Max_Exp
            End If
        
        Next
        
        i = 0
        j = 0
        t = "00:00:00"
        r = 0
        Min = 0
        Max = 0
        actual = 0
            
        For i = 0 To UBound(Cartera.Fecha_Exp_Max)
          If i = 0 Then
            r = Cartera.Fecha_Exp_Max(0).Max_Exp
            t = Cartera.Fecha_Exp_Max(0).Fecha
          End If
          
          Existe = 0
          If Cartera.Fecha_Exp_Max(i).Max_Exp > r Then
              Existe = 1
          End If
    
          If Existe = 1 Then
              For j = 1 To UBound(Cartera.Fecha_Exp_Max)
                  
                 If Cartera.Fecha_Exp_Max(i).Max_Exp > Cartera.Fecha_Exp_Max(j).Max_Exp Then
                   If Cartera.Fecha_Exp_Max(i).Fecha <> "00:00:00" Then
                        t = Cartera.Fecha_Exp_Max(i).Fecha
                        r = Cartera.Fecha_Exp_Max(i).Max_Exp
                   End If
                 End If
              Next
          End If
          
        Next
        i = 0
        ReDim Preserve Operacion(i)
       ' Operacion(i).Fecha_Exp_Max = t
       ' Operacion(i).Result_exp_Max = r
    End If
    Cartera.Fecha_Exp_Maxima = t
    Cartera.Exposicion_Maxima = r
    
End Sub
Private Sub Valoriza_Cartera_Trading(Cartera As Negociacion, Datos As Datos_Mercado, Fecha As Date, Optional Numero_Simulacion As Long = 0, Optional CurvasYield As String)
    
    
    'Valoriza la cartera swap
    Valoriza_Swap Cartera.Cartera_Swap, Datos, Fecha, Numero_Simulacion
    
    'Valoriza la cartera forward
    
    Valoriza_Fwd Cartera.Cartera_Fwd, Datos, Fecha, Numero_Simulacion, CurvasYield
    
    'Valoriza la cartera de opciones

    Valoriza_Opcion Cartera.Cartera_Opcion, Datos, Fecha, Numero_Simulacion
    
    'Valoriza la cartera de forward de renta fija
       
    Valoriza_FWD_RF Cartera.Cartera_Fwd_RF, Datos, Fecha, Numero_Simulacion, CurvasYield
    
End Sub
Private Function FormatoCompuesto() As String
    Dim Tabla() As Variant
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    Dim ErrorQuery As Integer
    
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc 'adCmdTableDirect 'adCmdTableDirect  'adCmdStoredProc 'adCmdTable
    Proc_Alm.CommandText = "SP_RIEFIN_FORMATO_COMPUESTO_CURVAS_SN"
    Set Proc_Alm.ActiveConnection = Conexion
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorQuery = Err.Number
    On Error GoTo 0
    
    If ErrorQuery <> 0 Then
       Exit Function
    End If
    
    On Error Resume Next
       Tabla = rs.GetRows
       rs.Close
    On Error GoTo salida
    
    FormatoCompuesto = Trim(Tabla(0, 0))
    Exit Function
   'Return
salida:
    FormatoCompuesto = "N"
End Function
Private Function SAOCurvasPropiasSN() As String
    Dim Tabla() As Variant
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    Dim ErrorQuery As Integer
    
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc 'adCmdTableDirect 'adCmdTableDirect  'adCmdStoredProc 'adCmdTable
    Proc_Alm.CommandText = "SP_RIEFIN_SAO_CURVAS_PROPIAS_SN"
    Set Proc_Alm.ActiveConnection = Conexion
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorQuery = Err.Number
    On Error GoTo 0
    
    If ErrorQuery <> 0 Then
       Exit Function
    End If
    
    On Error Resume Next
       Tabla = rs.GetRows
       rs.Close
    On Error GoTo salida
    
    SAOCurvasPropiasSN = Trim(Tabla(0, 0))
    Exit Function
    'Return
salida:
    SAOCurvasPropiasSN = "N"
End Function

Private Function Crea_Vector_Simplificado(Datos() As Datos_Mercado) As Double()
    
    Dim k As Long
    Dim i As Long
    Dim j As Long
    Dim Plazo() As Long
    Dim MArca As Boolean
    Dim Aux As Datos_Mercado
    
    Dim SAOCurvasPropias As String
    
    Let SAOCurvasPropias = SAOCurvasPropiasSN()
    
    
    Plazo = Rescata_Tenors
    
    ReDim Aux.Tasas_Swap(UBound(Datos(0).Tasas_Swap))
    For i = 0 To UBound(Aux.Tasas_Swap)
        MArca = False
        For j = 0 To UBound(Plazo)
            If MArca = False Then
                ReDim Preserve Aux.Tasas_Swap(i).Par(j)
                Aux.Tasas_Swap(i).Par(j).Plazo = Plazo(j)
                Aux.Tasas_Swap(i).Par(j).Tasa = InterpolaTasa(Plazo(j), Datos(0).Tasas_Swap(i))
                If Plazo(j) > Datos(0).Tasas_Swap(i).Par(UBound(Datos(0).Tasas_Swap(i).Par)).Plazo Then
                    MArca = True
                End If
            Else
                Exit For
            End If
        Next
    Next
    If Not SAOCurvasPropias = "N" Then
        ReDim Aux.Tasas_Opcion(UBound(Datos(0).Tasas_Opcion))
        For i = 0 To UBound(Aux.Tasas_Opcion)
            MArca = False
            For j = 0 To UBound(Plazo)
                If MArca = False Then
                    ReDim Preserve Aux.Tasas_Opcion(i).Par(j)
                    Aux.Tasas_Opcion(i).Par(j).Plazo = Plazo(j)
                    Aux.Tasas_Opcion(i).Par(j).Tasa = InterpolaTasa(Plazo(j), Datos(0).Tasas_Opcion(i))
                    If Plazo(j) > Datos(0).Tasas_Opcion(i).Par(UBound(Datos(0).Tasas_Opcion(i).Par)).Plazo Then
                        MArca = True
                    End If
                Else
                    Exit For
                End If
            Next
        Next
    End If
    
    ReDim Aux.Tasas_Fwd(UBound(Datos(0).Tasas_Fwd))
    For i = 0 To UBound(Aux.Tasas_Fwd)
        MArca = False
        For j = 0 To UBound(Plazo)
            If MArca = False Then
                ReDim Preserve Aux.Tasas_Fwd(i).Par(j)
                Aux.Tasas_Fwd(i).Par(j).Plazo = Plazo(j)
                Aux.Tasas_Fwd(i).Par(j).Tasa = InterpolaTasa(Plazo(j), Datos(0).Tasas_Fwd(i))
                If Plazo(j) > Datos(0).Tasas_Fwd(i).Par(UBound(Datos(0).Tasas_Fwd(i).Par)).Plazo Then
                    MArca = True
                End If
            Else
                Exit For
            End If
        Next
    Next
    
    ReDim Aux.Tasas_RF(UBound(Datos(0).Tasas_RF))
    For i = 0 To UBound(Aux.Tasas_RF)
        MArca = False
        For j = 0 To UBound(Plazo)
            If MArca = False Then
                ReDim Preserve Aux.Tasas_RF(i).Par(j)
                Aux.Tasas_RF(i).Par(j).Plazo = Plazo(j)
                Aux.Tasas_RF(i).Par(j).Tasa = InterpolaTasa(Plazo(j), Datos(0).Tasas_RF(i))
                If Plazo(j) > Datos(0).Tasas_RF(i).Par(UBound(Datos(0).Tasas_RF(i).Par)).Plazo Then
                    MArca = True
                End If
            Else
                Exit For
            End If
        Next
    Next
    
    'Ahora reasigna las tasas y plazos
    Datos(0).Tasas_Swap = Aux.Tasas_Swap
    Datos(0).Tasas_Fwd = Aux.Tasas_Fwd
    Datos(0).Tasas_RF = Aux.Tasas_RF
    Datos(0).Tasas_Opcion = Aux.Tasas_Opcion
    Calcula_Vol_Strikes Datos(0)
    
End Function
Sub Calcula_MaxExp_SQL(Fecha As Date _
                        , Optional iRut As Long = 0 _
                        , Optional iCodigo As Long = 0)
    
    Dim Proc_Alm As ADODB.Command
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Set Proc_Alm.ActiveConnection = Conexion
    Proc_Alm.CommandText = "SP_RIEFIN_MAXIMO_M2M"
    
    'Documentacion Microsof
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , Fecha)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Rut", adInteger, adParamInput, , iRut)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Codigo", adInteger, adParamInput, , iCodigo)
    
    
    'Ejecuta el procedimiento
    Proc_Alm.Execute

End Sub
Public Sub Calcula_REC_SQL(iFecha As Date, Cartera As Negociacion _
                                        , Operacion() As CalculaRec _
                                        , Val_Mercado As Double _
                                        , Val_AddON90d As Double _
                                        , Val_AddOn As Double _
                                        , Val_Exp_Maxima As Double _
                                        , iThreshold As Double _
                                        , iMetodologia As Integer _
                                        , Valdatos As Procesos _
                                        , Optional iRut As Long = 0 _
                                        , Optional iCodigo As Long = 0 _
                                        , Optional iCliente As String = "")
    
    Dim Proc_Alm As ADODB.Command
    Dim ErrorGrabaRec As Long
    Dim rs As Variant
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Set Proc_Alm.ActiveConnection = Conexion
    Proc_Alm.CommandText = "SP_RIEFIN_GRABAREC"
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , iFecha)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Rut", adInteger, adParamInput, , iRut)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Codigo", adInteger, adParamInput, , iCodigo)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Codigo_Metodologia", adInteger, adParamInput, , iMetodologia)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Nombre", adVarChar, adParamInput, 70, iCliente)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Linea", adDouble, adParamInput, , Operacion(0).Linea) 'PROD-10967
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Treshold", adDouble, adParamInput, , iThreshold)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Valor_Mercado", adDouble, adParamInput, , Val_Mercado)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Exposicion_Maxima", adDouble, adParamInput, , Val_Exp_Maxima)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@VaR90D", adDouble, adParamInput, , Val_AddON90d)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@AddOnAlVcto", adDouble, adParamInput, , Val_AddOn)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Garantia_Ejecutada", adChar, adParamInput, 2, Cartera.CalcRec(0).Garantia_Ejecutada)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Consumo_Linea", adDouble, adParamInput, , Cartera.CalcRec(0).Consumo_Linea)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Holgura", adDouble, adParamInput, , Cartera.CalcRec(0).Holgura)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Estado_Linea", adVarChar, adParamInput, 50, Cartera.CalcRec(0).Estado_Linea)

    
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorGrabaRec = Err.Number
        Valdatos.ErrorNumero = Err.Number
        Valdatos.ErrorDescripcion = Err.Description
        Valdatos.ErrorSP = Proc_Alm.CommandText
        Valdatos.ErrorcargaDatos = False
    On Error GoTo 0
    
   
    If Not ErrorGrabaRec = 0 Then
        Valdatos.ErrorcargaDatos = True
    End If
    
End Sub
Public Sub Calcula_REC(Fecha As Date, Cartera As Negociacion _
                                    , Operacion() As CalculaRec _
                                    , Val_Mercado As Double _
                                    , Val_AddON90d As Double _
                                    , Val_AddOn As Double _
                                    , Val_Exp_Maxima As Double _
                                    , ByRef iThreshold As Double _
                                    , iMetodologia As Integer _
                                    , iRecMet5 As Double _
                                    , Valdatos As Procesos _
                                    , Optional iRut As Long = 0 _
                                    , Optional iCodigo As Long = 0 _
                                    , Optional iCliente As String = "" _
                                    )
                        
    Dim i As Long
    Dim Num_Flujos As Long

    'PROD-10967
    Dim ErrorRescateThreshold As Long
    Dim Tabla() As Variant
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    Dim iLinea    As Double
    
    
    ' PRD 21119 - Consumo de Línea derivados ComDer
    Dim iThresholdMet6 As Double
    iThresholdMet6 = 0
    
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Set Proc_Alm.ActiveConnection = Conexion
    Proc_Alm.CommandText = "SP_RIEFIN_RESCATE_THRESHOLD_LINEA_DRV"  '-- Definir todo los parametros para aplicar la formuila
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , Fecha)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Rut", adInteger, adParamInput, , iRut)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Codigo", adInteger, adParamInput, , iCodigo)

    
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorRescateThreshold = Err.Number
        Valdatos.ErrorNumero = Err.Number
        Valdatos.ErrorDescripcion = Err.Description
        Valdatos.ErrorSP = Proc_Alm.CommandText
        Valdatos.ErrorcargaDatos = False
    On Error GoTo 0
    
   
    If Not ErrorRescateThreshold = 0 Then
        Valdatos.ErrorcargaDatos = True
    End If
    
    
    Tabla = rs.GetRows
    rs.Close
    
        
    If Tabla(0, 0) <> -1 Then
        Let iThreshold = Tabla(4, 0)
        Let iLinea = Tabla(6, 0)
    End If
    'PROD-10967

  ' PRD 21119 - Consumo de Línea derivados ComDer
  ' Si la metodologia es 6 el valor Threshold es seteado en cero.
    If iMetodologia = 6 Then
        iThreshold = iThresholdMet6
    End If
    
    
    

    ReDim Preserve Operacion(0)
    Operacion(i).Fecha = Fecha
    Operacion(i).Rut = iRut
    Operacion(i).Codigo = iCodigo
    Operacion(i).Nombre = iCliente
    Operacion(i).Linea = iLinea  'PROD-10967
    
    Cartera.Threshold = iThreshold
    
    Operacion(i).Treshold = iThreshold
    Operacion(i).Valor_Mercado = Val_Mercado
    Operacion(i).Exposicion_Maxima = Val_Exp_Maxima
    Operacion(i).VaR90D = Val_AddON90d
    Operacion(i).Garantia_Ejecutada = IIf(Val_Mercado > iThreshold, "SI", "NO")
    Operacion(i).Estado_Linea = ""   'PROD-10967
    
    If iMetodologia = 2 Then
        Operacion(i).Consumo_Linea = Max(Val_Exp_Maxima + Val_AddOn, 0)
        'PROD-10967
        Operacion(i).Estado_Linea = IIf(Operacion(i).Consumo_Linea <= 1.5 * iLinea, "Sujeto a UL <= 1.5 de Linea", "NO Sujeto a UL <= 1.5 de Linea")
    End If
    
    If iMetodologia = 3 Then
        Operacion(i).Consumo_Linea = IIf(Operacion(i).Garantia_Ejecutada = "SI" _
                                 , iThreshold + Val_AddON90d _
                                 , Max(Val_Exp_Maxima + Val_AddON90d, 0)) 'Por Hacer
        'PROD-10967
        Operacion(i).Estado_Linea = IIf(iThreshold + Val_AddON90d <= 1.5 * iLinea, "Sujeto a Threshold + Addon90d <= 1.5 de Linea", "NO Sujeto a Threshold + Addon90d <= 1.5 de Linea")
    End If
    
    If iMetodologia = 5 Then
        Operacion(i).Consumo_Linea = iRecMet5
    End If
    
    If iMetodologia = 6 Then ' PROD 21119 - Consumo de Línea - Cambio variación % confiabilidad al 99% y metodología VaR a 3 días
    
        Operacion(i).Consumo_Linea = IIf(Operacion(i).Garantia_Ejecutada = "SI" _
                                 , iThreshold + Val_AddON90d _
                                 , Max(Val_Exp_Maxima + Val_AddON90d, 0))
        
        Operacion(i).Estado_Linea = IIf(iThreshold + Val_AddON90d <= 1.5 * iLinea, "Sujeto a Threshold + Addon90d <= 1.5 de Linea", "NO Sujeto a Threshold + Addon3d <= 1.5 de Linea")
    End If
    
    Operacion(i).Holgura = Operacion(i).Linea - Operacion(i).Consumo_Linea
    
End Sub
' Se agrega parametro "Metodolgia" para PROD 21119 '- Consumo de Línea - cambio variación % confiabilidad al 99% y metodología VaR a 3 días
Private Sub Calcula_VaR(Cartera As Negociacion _
                        , MCovar() As Double _
                        , largo_vector As Long _
                        , Fecha As Date _
                        , Matriz_DV01 As DV01_Operacion _
                        , fRut As Long, fCodigo As Long _
                        , TipoCalculo As String _
                        , Metodologia As Integer)
    
    Dim i As Long
    Dim Vector_Pos() As Double
    'Dim Matriz_DV01 As DV01_Operacion
    Dim MatrizAux1() As Double
    Dim MatrizAux2() As Double
    Dim MatrizAux3() As Double
    Dim Datos() ' PRD 21119 - Consumo de Línea derivados ComDer
    Dim AddOn As Integer
    Dim Porc_Confianza As Double
    
    
    Dim GrabarVaR As Boolean
    Let GrabarVaR = IIf(TipoCalculo = "General", True, _
                    IIf(TipoCalculo = "APedido", True, _
                    IIf(TipoCalculo = "EnLinea", False, False)))
    
    Crea_Matriz_DV01 Cartera, Matriz_DV01, largo_vector
    
    'Solo para mirar, verificar MCovar
    'Suma = 0
    'For yy = 0 To 541
       
    '        Suma = Suma + Matriz_DV01.Matriz(yy, 25)
        
    'Next
    'Matriz MCovar varia cr a planilla
    
    
    Matriz_DV01.Var = ColxCol(Matriz_DV01.Matriz, MultM(MCovar, Matriz_DV01.Matriz))
    
 If Metodologia = 6 Then ' PRD 21119 - Consumo de Línea - cambio variación % confiabilidad al 99% y metodología VaR a 3 días
   
    Bac_Sql_Execute ("baclineas..SP_ObtieneValoresMetodologia") ' Obtiene valores de met. 6
    Do While Bac_SQL_Fetch(Datos())
        AddOn = Datos(2)  ' 3
        Porc_Confianza = Datos(3) ' 2.575
    Loop
   
   For i = 0 To UBound(Matriz_DV01.Var)
   
        If Matriz_DV01.Plazo(i) >= AddOn Then
            'En desarrollo arrojó valores negativos el VaR antes de la razi cuadrada
            Matriz_DV01.Var(i) = Porc_Confianza * (2 * AddOn / 3) ^ 0.5 * Abs(Matriz_DV01.Var(i)) ^ 0.5
        Else
            Matriz_DV01.Var(i) = Porc_Confianza * (Matriz_DV01.Plazo(i) * 2 / 3) ^ 0.5 * Abs(Matriz_DV01.Var(i)) ^ 0.5
        End If

     
   Next
   
 Else
 
    
    For i = 0 To UBound(Matriz_DV01.Var)
            'Eliminar, solo para mirar
            'If Matriz_DV01.Num_Operacion(I) = 684 Then
            '   xx = 2
            'End If
    
        If Matriz_DV01.Plazo(i) >= 90 Then
            'En desarrollo arrojó valores negativos el VaR antes de la razi cuadrada
            Matriz_DV01.Var(i) = 1.65 * 60 ^ 0.5 * Abs(Matriz_DV01.Var(i)) ^ 0.5
        Else
            Matriz_DV01.Var(i) = 1.65 * (Matriz_DV01.Plazo(i) * 2 / 3) ^ 0.5 * Abs(Matriz_DV01.Var(i)) ^ 0.5
        End If

    Next
    
  End If
   
    'Limpia la tabla para que no se multipliquen los datos
    'Evitar modificar la base de datos
    If GrabarVaR Then
          Limpia_VaR_SQL Fecha, fRut, fCodigo
    End If
    'Patricio: ideal que la cartera de operaciones
    'Producto, Numero_oepracion y el Var en Grilla
    If GrabarVaR Then
        For i = 0 To UBound(Matriz_DV01.Var)
            Inserta_VaR_SQL Fecha, fRut, Matriz_DV01.Producto(i), Matriz_DV01.Num_Operacion(i), Matriz_DV01.Var(i), fCodigo
        Next
    End If
    
End Sub
Public Sub Inserta_VaR_SQL(Fecha As Date, Rut As Long, Tipo_Operacion As String, Numero_Operacion As Long, VaR90D As Double, fCodigo As Long)
    
    Dim Proc_Alm As ADODB.Command
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Set Proc_Alm.ActiveConnection = Conexion
    Proc_Alm.CommandText = "SP_RIEFIN_ACTUALIZA_VaR"
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , Fecha)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Rut", adInteger, adParamInput, , Rut)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Tipo_Operacion", adVarChar, adParamInput, 20, Tipo_Operacion)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Numero_Operacion", adInteger, adParamInput, , Numero_Operacion)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@VaR90D", adDouble, adParamInput, , VaR90D)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Codigo", adInteger, adParamInput, , fCodigo)
    'Ejecuta el procedimiento
    Proc_Alm.Execute

End Sub
Public Sub Limpia_VaR_SQL(Fecha As Date, fRut As Long, fCodigo As Long)
    
    Dim Proc_Alm As ADODB.Command
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Set Proc_Alm.ActiveConnection = Conexion
    Proc_Alm.CommandText = "SP_RIEFIN_LIMPIA_TABLA_VaR"
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , Fecha)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Rut", adInteger, adParamInput, , fRut)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Codigo", adInteger, adParamInput, , fCodigo)
    'Ejecuta el procedimiento
    Proc_Alm.Execute

End Sub
Private Sub Calcula_DV01_Principal(Cartera As Negociacion, Datos As Datos_Mercado, Valdatos As Procesos, CurvasYield As String)
    
    'Calcula DV01
    Calcula_DV01 Cartera, Datos, Valdatos, CurvasYield
    
End Sub
Private Sub Calcula_DV01(Cartera As Negociacion, Datos As Datos_Mercado, Valdatos As Procesos, CurvasYield As String)
    
    Dim i As Long
    Dim j As Long
    Dim k As Long
    Dim limk As Long
    Dim Error As Integer
    Dim CodCart As Long
    Dim Datos_Aux As Datos_Mercado
    Dim Delta As Double
    Dim Contador As Long
    
    Dim SAOCurvasPropias As String
    
    Let SAOCurvasPropias = SAOCurvasPropiasSN()
    
    Delta = 0.0001
    'Calcula DV01 de las curvas swap
    For i = 0 To UBound(Datos.Tasas_Swap)
        For j = 0 To UBound(Datos.Tasas_Swap(i).Par)
            'Reinicia las tasas
            Datos_Aux = Datos
            'Mueve la tasa en 1 bp
            Datos_Aux.Tasas_Swap(i).Par(j).Tasa = Datos_Aux.Tasas_Swap(i).Par(j).Tasa + Delta
            'Calcula el impacto en la cartera swap
            DV01_Swap i, Cartera.Cartera_Swap, Datos_Aux, Contador, Delta
            If SAOCurvasPropias = "N" Then
            'Calcula el impacto en la cartera de opciones
                'Aca y ano se hacen porque SAO se parametriza independiente ahora
            DV01_Opcion i, Cartera.Cartera_Opcion, Datos_Aux, Contador, Delta
            End If
            Contador = Contador + 1
        Next
    Next
    If Not SAOCurvasPropias = "N" Then
        'Calcula DV01 de las curvas opciones
        For i = 0 To UBound(Datos.Tasas_Opcion)
            For j = 0 To UBound(Datos.Tasas_Opcion(i).Par)
                'Reinicia las tasas
                Datos_Aux = Datos
                'Mueve la tasa en 1 bp
                Datos_Aux.Tasas_Opcion(i).Par(j).Tasa = Datos_Aux.Tasas_Opcion(i).Par(j).Tasa + Delta
                'Calcula el impacto en la cartera de opciones
                DV01_Opcion i, Cartera.Cartera_Opcion, Datos_Aux, Contador, Delta
                Contador = Contador + 1
            Next
        Next
    End If
    'Calcula DV01 de las curvas forward
    For i = 0 To UBound(Datos.Tasas_Fwd)
        For j = 0 To UBound(Datos.Tasas_Fwd(i).Par)
            'Reinicia las tasas
            Datos_Aux = Datos
            'Mueve la tasa en 1 bp
            Datos_Aux.Tasas_Fwd(i).Par(j).Tasa = Datos_Aux.Tasas_Fwd(i).Par(j).Tasa + Delta
            'Calcula el impacto en la cartera forward
            DV01_Fwd i, Cartera.Cartera_Fwd, Datos_Aux, Contador, Delta, CurvasYield
            Contador = Contador + 1
        Next
    Next
    
    'Calcula DV01 de las curvas de renta fija
    For i = 0 To UBound(Datos.Tasas_RF)
        For j = 0 To UBound(Datos.Tasas_RF(i).Par)
            'Reinicia las tasas
            Datos_Aux = Datos
            'Mueve la tasa en 1 bp
            Datos_Aux.Tasas_RF(i).Par(j).Tasa = Datos_Aux.Tasas_RF(i).Par(j).Tasa + Delta
            'Calcula el impacto en la cartera de fwd renta fija
            DV01_FWD_RF i, Cartera.Cartera_Fwd_RF, Datos_Aux, Contador, Delta, CurvasYield
            Contador = Contador + 1
        Next
    Next
    
    'Calcula sensibilidad a las monedas
    Delta = 0.01 / 100
    ReDim Datos.DV01_TC(UBound(Datos.TC))
    'Calcula sensibilidad a las monedas
    For i = 2 To UBound(Datos.TC)
        
        'Reinicia las datos
        Datos_Aux = Datos
        'Mueve las paridades en 0.01%
        Datos_Aux.Paridad(i) = Datos.Paridad(i) * (1 + Delta)
        Calcula_TCContable Datos_Aux, Valdatos
        
        'Calcula el impacto en la cartera swap
        DV01_Swap_Mon i, Cartera.Cartera_Swap, Datos_Aux, Contador, Datos.Paridad(i) * Delta
        'Calcula el impacto en la cartera de opciones
        DV01_Opcion_Mon i, Cartera.Cartera_Opcion, Datos_Aux, Contador, Datos.Paridad(i) * Delta
        'Calcula el impacto en la cartera forward
        DV01_Fwd_Mon i, Cartera.Cartera_Fwd, Datos_Aux, Contador, Datos.Paridad(i) * Delta, CurvasYield
        'Calcula el impacto en la cartera de fwd renta fija
        DV01_FWD_RF_Mon i, Cartera.Cartera_Fwd_RF, Datos_Aux, Contador, Datos.Paridad(i) * Delta, CurvasYield
        
        Contador = Contador + 1
    Next
        
End Sub

Private Sub DV01_Swap(Codigo_Curva As Long, Operacion() As Operaciones_Swap, Datos As Datos_Mercado, Iteracion As Long, Delta As Double)
    
    Dim k As Long
    Dim limk As Long
    Dim Error As Integer
    
    On Error Resume Next
        limk = UBound(Operacion, 1)
        Error = Err.Number
    On Error GoTo 0
    If Error = 0 Then
        'Solo para mirar
        'Suma = 0
        
        For k = 0 To limk 'Para cada flujo de cartera
            ReDim Preserve Operacion(k).Valor_Simulacion(Iteracion)
            If Codigo_Curva = Operacion(k).Codigo_descuento Or Codigo_Curva = Operacion(k).Codigo_forward Then
            
                'Solo mirar
                'If Operacion(k).Numero_Operacion = 684 Then
                '   Suma = Suma + (MtM_Flujo_Swap(Operacion(k), DATOS, DATOS.Fecha) - Operacion(k).Valor_Mercado) / Delta
                '   xx = 2
                'End If
                'Solo para mirar
              
                Operacion(k).Valor_Simulacion(Iteracion) = (MtM_Flujo_Swap(Operacion(k), Datos, Datos.Fecha) - Operacion(k).Valor_Mercado) / Delta
            End If
        Next
   
    'Codigo solo para examinar resultado, no migrar
       ' For k = 0 To limk
       '     If Operacion(k).Valor_Simulacion(Iteracion) <> 0 Then
               ' MsgBox "Curva " & Codigo_Curva & " k = " & k & " " & Operacion(k).Valor_Simulacion(Iteracion) & " iteracion = " & Iteracion
       '      End If
       ' Next
             End If
    
        'Solo para mirar
    'If Suma <> 0 Then
    '   xx = 2
    'End If

    
    
    
End Sub
Private Sub DV01_Swap_Mon(Codigo_Moneda As Long, Operacion() As Operaciones_Swap, Datos As Datos_Mercado, Iteracion As Long, Delta As Double)
    
    Dim k As Long
    Dim limk As Long
    Dim Error As Integer
    
    On Error Resume Next
        limk = UBound(Operacion, 1)
        Error = Err.Number
    On Error GoTo 0
    If Error = 0 Then
        'Suma = 0
        For k = 0 To limk
            ReDim Preserve Operacion(k).Valor_Simulacion(Iteracion)
            If (Codigo_Moneda = 2 And Operacion(k).Moneda > 2) Or Codigo_Moneda = Operacion(k).Moneda Then
                'Solo para mirar
                'If Operacion(k).Numero_Operacion = 684 Then
                '   Suma = Suma + (MtM_Flujo_Swap(Operacion(k), DATOS, DATOS.Fecha) - Operacion(k).Valor_Mercado) / Delta
                '   xx = 2
                'End If
                'Solo para mirar

                Operacion(k).Valor_Simulacion(Iteracion) = (MtM_Flujo_Swap(Operacion(k), Datos, Datos.Fecha) - Operacion(k).Valor_Mercado) / Delta
            End If
        Next
    End If
    
    'Solo para mirar
    'If Suma <> 0 Then
    '   xx = 2
    'End If
    
    
End Sub
Private Sub DV01_Fwd(Codigo_Curva As Long, Operacion() As Operaciones_Fwd, Datos As Datos_Mercado, Iteracion As Long, Delta As Double, CurvasYield As String)
    
    Dim k As Long
    Dim limk As Long
    Dim Error As Integer
    
    On Error Resume Next
        limk = UBound(Operacion, 1)
        Error = Err.Number
    On Error GoTo 0
    If Error = 0 Then
        For k = 0 To limk
            ReDim Preserve Operacion(k).Valor_Simulacion(Iteracion)
            If Codigo_Curva = Operacion(k).Codigo_descuento(0) Or Codigo_Curva = Operacion(k).Codigo_descuento(1) Then
                Operacion(k).Valor_Simulacion(Iteracion) = (MtM_Fwd(Operacion(k), Datos, Datos.Fecha, CurvasYield) - Operacion(k).Valor_Mercado) / Delta
            End If
        Next
    End If
    
End Sub
Private Sub DV01_Fwd_Mon(Codigo_Moneda As Long, Operacion() As Operaciones_Fwd, Datos As Datos_Mercado, Iteracion As Long, Delta As Double, CurvasYield As String)
    
    Dim k As Long
    Dim limk As Long
    Dim Error As Integer
    
    On Error Resume Next
        limk = UBound(Operacion, 1)
        Error = Err.Number
    On Error GoTo 0
    If Error = 0 Then
        For k = 0 To limk
            ReDim Preserve Operacion(k).Valor_Simulacion(Iteracion)
            If (Codigo_Moneda = 2 And (Operacion(k).Moneda(0) > 2 Or Operacion(k).Moneda(1) > 2)) Or Codigo_Moneda = Operacion(k).Moneda(0) Or Codigo_Moneda = Operacion(k).Moneda(1) Then
                Operacion(k).Valor_Simulacion(Iteracion) = (MtM_Fwd(Operacion(k), Datos, Datos.Fecha, CurvasYield) - Operacion(k).Valor_Mercado) / Delta
            End If
        Next
    End If
    
End Sub
Private Sub DV01_Opcion(Codigo_Curva As Long, Operacion() As Operaciones_Opcion, Datos As Datos_Mercado, Iteracion As Long, Delta As Double)
    
    Dim k As Long
    Dim limk As Long
    Dim Error As Integer
    
    On Error Resume Next
        limk = UBound(Operacion, 1)
        Error = Err.Number
    On Error GoTo 0
    If Error = 0 Then
        For k = 0 To limk
            ReDim Preserve Operacion(k).Valor_Simulacion(Iteracion)
            If Codigo_Curva = Operacion(k).Codigo_rd Or Codigo_Curva = Operacion(k).Codigo_rf Then
                If Operacion(k).Payoff = "01" Then
                    Operacion(k).Valor_Simulacion(Iteracion) = (BSMercado(Operacion(k), Datos, Datos.Fecha) - Operacion(k).Valor_Mercado) / Delta
                ElseIf Operacion(k).Payoff = "02" Then
                    Operacion(k).Valor_Simulacion(Iteracion) = (BSAsiatica(Operacion(k), Datos, Datos.Fecha) - Operacion(k).Valor_Mercado) / Delta
                End If
            End If
        Next
    End If
    
End Sub
Private Sub DV01_Opcion_Mon(Codigo_Moneda As Long, Operacion() As Operaciones_Opcion, Datos As Datos_Mercado, Iteracion As Long, Delta As Double)
    
    Dim k As Long
    Dim limk As Long
    Dim Error As Integer
    Dim CodCart As Variant
    
    On Error Resume Next
        limk = UBound(Operacion, 1)
        Error = Err.Number
    On Error GoTo 0
    If Error = 0 Then
        For k = 0 To limk
            ReDim Preserve Operacion(k).Valor_Simulacion(Iteracion)
            If (Codigo_Moneda = 2 And (Operacion(k).Codigo_Spot > 2 Or Operacion(k).Cod_mon_val > 2)) Or Codigo_Moneda = Operacion(k).Codigo_Spot Or Codigo_Moneda = Operacion(k).Cod_mon_val Then
                CodCart = Operacion(k).Cartera
                If Operacion(k).Payoff = "01" Then
                    Operacion(k).Valor_Simulacion(Iteracion) = (BSMercado(Operacion(k), Datos, Datos.Fecha) - Operacion(k).Valor_Mercado) / Delta
                ElseIf Operacion(k).Payoff = "02" Then
                    Operacion(k).Valor_Simulacion(Iteracion) = (BSAsiatica(Operacion(k), Datos, Datos.Fecha) - Operacion(k).Valor_Mercado) / Delta
                End If
            End If
        Next
    End If
    
End Sub
Private Sub DV01_FWD_RF(Codigo_Curva As Long, Operacion() As Operaciones_FWD_RF, Datos As Datos_Mercado, Iteracion As Long, Delta As Double, CurvasYield As String)
    
    Dim k As Long
    Dim limk As Long
    Dim Error As Integer
    
    On Error Resume Next
        limk = UBound(Operacion, 1)
        Error = Err.Number
    On Error GoTo 0
    If Error = 0 Then
        For k = 0 To limk
            ReDim Preserve Operacion(k).Valor_Simulacion(Iteracion)
            If Codigo_Curva = Operacion(k).Cod_Tasa Or Codigo_Curva = Operacion(k).Cod_Tasa_F Then
                Operacion(k).Valor_Simulacion(Iteracion) = (MtM_FWD_RF(Operacion(k), Datos, Datos.Fecha, CurvasYield) - Operacion(k).Valor_Mercado) / Delta
            End If
        Next
    End If
    
End Sub
Private Sub DV01_FWD_RF_Mon(Codigo_Moneda As Long, Operacion() As Operaciones_FWD_RF, Datos As Datos_Mercado, Iteracion As Long, Delta As Double, CurvasYield As String)
    
    Dim k As Long
    Dim limk As Long
    Dim Error As Integer
    
    On Error Resume Next
        limk = UBound(Operacion, 1)
        Error = Err.Number
    On Error GoTo 0
    If Error = 0 Then
        For k = 0 To limk
            ReDim Preserve Operacion(k).Valor_Simulacion(Iteracion)
            If (Codigo_Moneda = 2 And Operacion(k).Cod_Moneda > 2) Or Codigo_Moneda = Operacion(k).Cod_Moneda Then
                Operacion(k).Valor_Simulacion(Iteracion) = (MtM_FWD_RF(Operacion(k), Datos, Datos.Fecha, CurvasYield) - Operacion(k).Valor_Mercado) / Delta
            End If
        Next
    End If
    
End Sub
Private Sub Crea_Matriz_DV01(Cartera As Negociacion, Matriz_DV01 As DV01_Operacion, largo_vector As Long)
    
    Dim Contador As Long
    Dim i As Long
    Dim j As Long
    Dim Num_Operacion As Long
    Dim limi As Long
    Dim Error As Integer
    Dim zz As Long
    Dim yy As Long
    
    Contador = -1
    Num_Operacion = -1
    On Error Resume Next
        limi = UBound(Cartera.Cartera_Swap)
        Error = Err.Number
    On Error GoTo 0
    If Error = 0 Then
        For i = 0 To limi
            If Num_Operacion <> Cartera.Cartera_Swap(i).Numero_Operacion Then
                Contador = Contador + 1
                ReDim Preserve Matriz_DV01.Matriz(largo_vector, Contador)
                ReDim Preserve Matriz_DV01.Num_Operacion(Contador)
                ReDim Preserve Matriz_DV01.Producto(Contador)
                ReDim Preserve Matriz_DV01.Rut(Contador)
                ReDim Preserve Matriz_DV01.Plazo(Contador)
            
                Num_Operacion = Cartera.Cartera_Swap(i).Numero_Operacion
                Matriz_DV01.Num_Operacion(Contador) = Cartera.Cartera_Swap(i).Numero_Operacion
                'Sacar solo para mirar
                'If Cartera.Cartera_Swap(I).Numero_Operacion = 684 Then
                '    xx = 2
                'End If
                
                Matriz_DV01.Producto(Contador) = "Swap"
                Matriz_DV01.Rut(Contador) = Cartera.Cartera_Swap(i).Rut
                Matriz_DV01.Plazo(Contador) = Cartera.Cartera_Swap(i).Plazo_liq
            Else
                If Matriz_DV01.Plazo(Contador) < Cartera.Cartera_Swap(i).Plazo_liq Then
                    Matriz_DV01.Plazo(Contador) = Cartera.Cartera_Swap(i).Plazo_liq
                End If
            End If
            
            For j = 0 To largo_vector
            
                'Solo para mirar
                'If Cartera.Cartera_Swap(I).Numero_Operacion = 684 And Cartera.Cartera_Swap(I).Valor_Simulacion(j) <> 0 Then
                '   xx = 2
                'End If
            
                Matriz_DV01.Matriz(j, Contador) = Matriz_DV01.Matriz(j, Contador) + Cartera.Cartera_Swap(i).Valor_Simulacion(j)
                
            Next
        Next
                
    'No migrar, es solo para mirar
    'Suma = 0
    'No migrar, es solo para mirar
    'No migrar, es solo para mirar
    'Suma = 0
    'For yy = 0 To Largo_Vector
    '        'MsgBox "Variable " & yy & " Operacion " & Contador
    '        Suma = Suma + Matriz_DV01.Matriz(yy, 17)
    '        xx = 2
    'Next
        
        
    End If
    
    
    On Error Resume Next
        limi = UBound(Cartera.Cartera_Fwd)
        Error = Err.Number
    On Error GoTo 0
    If Error = 0 Then
        For i = 0 To limi
            Contador = Contador + 1
            ReDim Preserve Matriz_DV01.Matriz(largo_vector, Contador)
            ReDim Preserve Matriz_DV01.Num_Operacion(Contador)
            ReDim Preserve Matriz_DV01.Producto(Contador)
            ReDim Preserve Matriz_DV01.Rut(Contador)
            ReDim Preserve Matriz_DV01.Plazo(Contador)
        
            Matriz_DV01.Num_Operacion(Contador) = Cartera.Cartera_Fwd(i).Numero_Operacion
            Matriz_DV01.Producto(Contador) = "Fwd"
            Matriz_DV01.Rut(Contador) = Cartera.Cartera_Fwd(i).Rut
            Matriz_DV01.Plazo(Contador) = Cartera.Cartera_Fwd(i).Plazo_efectivo
            For j = 0 To largo_vector
                If Cartera.Cartera_Fwd(i).Valor_Simulacion(j) <> 0 Then
               
                End If
                
                Matriz_DV01.Matriz(j, Contador) = Cartera.Cartera_Fwd(i).Valor_Simulacion(j)
            Next
        Next
    End If
    
    On Error Resume Next
        limi = UBound(Cartera.Cartera_Opcion)
        Error = Err.Number
    On Error GoTo 0
    If Error = 0 Then
        For i = 0 To limi
            Contador = Contador + 1
            ReDim Preserve Matriz_DV01.Matriz(largo_vector, Contador)
            ReDim Preserve Matriz_DV01.Num_Operacion(Contador)
            ReDim Preserve Matriz_DV01.Producto(Contador)
            ReDim Preserve Matriz_DV01.Rut(Contador)
            ReDim Preserve Matriz_DV01.Plazo(Contador)
            
            Matriz_DV01.Num_Operacion(Contador) = Cartera.Cartera_Opcion(i).NumOp
            Matriz_DV01.Producto(Contador) = "Opcion"
            Matriz_DV01.Rut(Contador) = Cartera.Cartera_Opcion(i).Rut
            Matriz_DV01.Plazo(Contador) = Cartera.Cartera_Opcion(i).Plazo
            
            For j = 0 To largo_vector
                Matriz_DV01.Matriz(j, Contador) = Cartera.Cartera_Opcion(i).Valor_Simulacion(j)
            Next
        Next
    End If
    
    
    On Error Resume Next
        limi = UBound(Cartera.Cartera_Fwd_RF)
        Error = Err.Number
    On Error GoTo 0
    If Error = 0 Then
        For i = 0 To limi
            Contador = Contador + 1
            ReDim Preserve Matriz_DV01.Matriz(largo_vector, Contador)
            ReDim Preserve Matriz_DV01.Num_Operacion(Contador)
            ReDim Preserve Matriz_DV01.Producto(Contador)
            ReDim Preserve Matriz_DV01.Rut(Contador)
            ReDim Preserve Matriz_DV01.Plazo(Contador)
            
            Matriz_DV01.Num_Operacion(Contador) = Cartera.Cartera_Fwd_RF(i).Numero_Operacion
            Matriz_DV01.Producto(Contador) = "Fwd_RF"
            Matriz_DV01.Rut(Contador) = Cartera.Cartera_Fwd_RF(i).Rut
            Matriz_DV01.Plazo(Contador) = Cartera.Cartera_Fwd_RF(i).Plazo
            
            For j = 0 To largo_vector
                Matriz_DV01.Matriz(j, Contador) = Cartera.Cartera_Fwd_RF(i).Valor_Simulacion(j)
            Next
        
        Next
    End If
        
End Sub
Private Function InterpolaTasa(Plazo As Long, Datos As Vector_Tasas) As Double
    
    Dim i As Long
    Dim fin As Long
    fin = UBound(Datos.Par, 1)
    
    For i = 0 To fin
        If Plazo <= Datos.Par(i).Plazo Then
            Exit For
        End If
    Next
    
    If i = 0 Then
        InterpolaTasa = Datos.Par(i).Tasa
    ElseIf i > fin Then
        InterpolaTasa = Datos.Par(fin).Tasa
    Else
        InterpolaTasa = Datos.Par(i - 1).Tasa + (Datos.Par(i).Tasa - Datos.Par(i - 1).Tasa) / (Datos.Par(i).Plazo - Datos.Par(i - 1).Plazo) * (Plazo - Datos.Par(i - 1).Plazo)
    End If
    
End Function
 Private Function InterpolaVol(Vol() As Tenors_Vol, Plazo As Long, Strike As Double)
    
    Dim Plazos(1)
    Dim Vols(1)
    Dim i As Long
    Dim Ivd As Long
    Dim Ivu As Long
    Dim limv As Long
    
    limv = UBound(Vol, 1)
    For i = 0 To limv
        If Plazo <= Vol(i).Plazo Then Exit For
    Next
    
    If i = 0 Or i > limv Then
    'Si el plazo es menor a mayor a los límites no se interpola verticalmente
        If i > limv Then i = limv
        InterpolaVol = InterpolacionVol_Horizontal(Vol(i).Par, Strike)

    Else
    'Si el plazo está dentro del arreglo de plazos
        Ivd = i - 1
        Ivu = i
        Plazos(0) = Vol(Ivd).Plazo
        Plazos(1) = Vol(Ivu).Plazo
        
        Vols(0) = InterpolacionVol_Horizontal(Vol(Ivd).Par, Strike)
        Vols(1) = InterpolacionVol_Horizontal(Vol(Ivu).Par, Strike)
        
        InterpolaVol = Vols(0) + (Vols(1) - Vols(0)) / (Plazos(1) - Plazos(0)) * (Plazo - Plazos(0))
    
    End If
    
End Function
Private Function InterpolacionVol_Horizontal(Vol() As Par_Vol, Strike As Double)
    
    Dim j As Long
    Dim limh As Long
    Dim Ihd As Long
    Dim Ihu As Long
    
    limh = UBound(Vol)
    For j = 0 To limh
        If Strike <= Vol(j).Strike Then Exit For
    Next
    
    If j = 0 Or j > limh Then
    'Si el strike esta fuera del arreglo
        If j > limh Then j = limh
        InterpolacionVol_Horizontal = Vol(j).Vol
    Else
    'Si el strike esta dentro del arreglo, se interpola
        Ihd = j - 1
        Ihu = j
        InterpolacionVol_Horizontal = Vol(Ihd).Vol + (Vol(Ihu).Vol - Vol(Ihd).Vol) / (Vol(Ihu).Strike - Vol(Ihd).Strike) * (Strike - Vol(Ihd).Strike)
    End If
    
End Function
Private Function InterpolaVol_Vertical(Vol() As Tenors_Vol, Plazo As Long, k As Long)
    
    Dim Plazos(1)
    Dim Vols(1)
    Dim i As Long
    Dim Ivd As Long
    Dim Ivu As Long
    Dim limv As Long
    
    limv = UBound(Vol, 1)
    For i = 0 To limv
        If Plazo <= Vol(i).Plazo Then Exit For
    Next
    
    If i = 0 Or i > limv Then
    'Si el plazo es menor a mayor a los límites no se interpola verticalmente
        If i > limv Then i = limv
        InterpolaVol_Vertical = Vol(i).Par(k).Vol

    Else
    'Si el plazo está dentro del arreglo de plazos
        Ivd = i - 1
        Ivu = i
        Plazos(0) = Vol(Ivd).Plazo
        Plazos(1) = Vol(Ivu).Plazo
        
        Vols(0) = Vol(Ivd).Par(k).Vol
        Vols(1) = Vol(Ivu).Par(k).Vol
        
        InterpolaVol_Vertical = Vols(0) + (Vols(1) - Vols(0)) / (Plazos(1) - Plazos(0)) * (Plazo - Plazos(0))
    
    End If
    
End Function
Private Function Busca_en_Tabla_Datos(Tabla() As Tabla_Datos, Fecha As Date) As Double
    
    Dim liminf As Long
    Dim limsup As Long
    Dim Encontrado As Boolean
    
    liminf = LBound(Tabla)
    limsup = UBound(Tabla)
    
    Do While Tabla(liminf).Fecha <> Fecha And Tabla(limsup).Fecha <> Fecha And liminf + 1 <> limsup
        If Tabla(Fix((liminf + limsup) / 2)).Fecha <= Fecha Then
            liminf = Fix((liminf + limsup) / 2)
        Else
            limsup = Fix((liminf + limsup) / 2)
        End If
    Loop
    
    
    If Tabla(liminf).Fecha = Fecha Then
        Busca_en_Tabla_Datos = Tabla(liminf).Valor
    ElseIf Tabla(limsup).Fecha = Fecha Then
        Busca_en_Tabla_Datos = Tabla(limsup).Valor
    Else
        Busca_en_Tabla_Datos = Tabla(liminf).Valor + (Tabla(limsup).Valor - Tabla(liminf).Valor) / (Tabla(limsup).Fecha - Tabla(liminf).Fecha) * (Fecha - Tabla(liminf).Fecha)
    End If
End Function
Public Function SumaFecha(Fecha As Date, Dias As Long) As Date
    
    Dim DiaSem As Long
    Dim FechaAux As Date
    
    FechaAux = DateAdd("d", Dias, Fecha)
    DiaSem = Weekday(FechaAux, vbMonday)
    
    If DiaSem >= 6 Then
        SumaFecha = DateAdd("d", Dias + 2, Fecha)
    Else
        SumaFecha = FechaAux
    End If
    
End Function

Private Function Rescata_Simulaciones(Cartera As Negociacion _
                              , Valdatos As Procesos _
                              , iMetodologia As Integer _
                              , iThreshold As Double _
                              , Optional iRut As Long = 0 _
                                        , Optional iCodigo As Long = 0 _
                              , Optional iCliente As String = "")
                            
    Dim Threshold As Double
    Dim Metodologia As Integer

    Dim Tabla() As Variant
    Dim rs As ADODB.Recordset

    Dim Proc_Alm As ADODB.Command
    Dim ErrorConMetodologia As Double
    Dim ConsultaMetodologia As Integer
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Set Proc_Alm.ActiveConnection = Conexion
    Proc_Alm.CommandText = "SP_RIEFIN_SIMULACIONES"
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Metodologia", adInteger, adParamInput, , iMetodologia)
   
    'Ejecuta el procedimiento
    
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorConMetodologia = Err.Number
        Valdatos.ErrorNumero = Err.Number
        Valdatos.ErrorSP = Err.Description
        Valdatos.ErrorDescripcion = Proc_Alm.CommandText
        Valdatos.ErrorcargaDatos = False
    On Error GoTo 0
    
    ConsultaMetodologia = 0
    If Not ErrorConMetodologia = 0 Then
        ConsultaMetodologia = -1
    End If
    
    If ConsultaMetodologia = -1 Then
         Exit Function
    End If
        
    'Set rs = Proc_Alm.Execute
      
    If Not rs.BOF Then
        Tabla = rs.GetRows
        rs.Close
        Rescata_Simulaciones = Tabla(0, 0)
    End If
    
    Cartera.Threshold = iThreshold
    Cartera.Metodología = iMetodologia
    Cartera.Rut = iRut
    Cartera.Codigo = iCodigo
    Cartera.CLIENTE = iCliente

End Function
Public Function CuentaDias(Fecha_ini As Date, Fecha_fin As Date, Convencion As String, Base As Long) As Long
    If Convencion = "A" Then
        CuentaDias = Fecha_fin - Fecha_ini
    ElseIf Convencion = "P" Then
        CuentaDias = Base * (Year(Fecha_fin) - Year(Fecha_ini)) + 30 * (Month(Fecha_fin) - Month(Fecha_ini)) + Day(Fecha_fin) - Day(Fecha_ini)
    End If
End Function
Private Sub Calcula_Vol_Strikes(ByRef Datos As Datos_Mercado)
    
    Dim i As Long
    Dim j As Long
    Dim k As Long
    Dim rd As Double
    Dim rf As Double
    Dim Tipo(4) As String
    Dim Delta(4) As Double
    
    Dim SAOCurvasPropias As String
    
    Let SAOCurvasPropias = SAOCurvasPropiasSN()
    
    
    Delta(0) = 0.1
    Delta(1) = 0.25
    Delta(2) = 0
    Delta(3) = 0.25
    Delta(4) = 0.1
    
    Tipo(0) = "PUT"
    Tipo(1) = "PUT"
    Tipo(2) = "ATM"
    Tipo(3) = "CALL"
    Tipo(4) = "CALL"
   
    
    For i = 0 To UBound(Datos.Vol)
        For j = 0 To UBound(Datos.Vol(i).Superf)
            If SAOCurvasPropias = "N" Then
        'Ojo que esta usando las tasas swap para valorizar
            rd = InterpolaTasa(Datos.Vol(i).Superf(j).Plazo, Datos.Tasas_Swap(Datos.Vol(i).Codigo_rd))
            rf = InterpolaTasa(Datos.Vol(i).Superf(j).Plazo, Datos.Tasas_Swap(Datos.Vol(i).Codigo_rf))
            Else
                rd = InterpolaTasa(Datos.Vol(i).Superf(j).Plazo, Datos.Tasas_Opcion(Datos.Vol(i).Codigo_rd))
                rf = InterpolaTasa(Datos.Vol(i).Superf(j).Plazo, Datos.Tasas_Opcion(Datos.Vol(i).Codigo_rf))
            End If
            For k = 0 To 4
                Datos.Vol(i).Superf(j).Par(k).Strike = Inversion_Strikes(Datos.Vol(i).Superf(j).Plazo, Datos.TC(Datos.Vol(i).Codigo_Moneda), Datos.Vol(i).Superf(j).Par(k).Vol, rd, rf, Delta(k), Tipo(k))
            Next
        Next
    Next
    
End Sub
Public Function Inversion_Strikes(Plazo As Long, Spot As Double, Vol As Double, rd As Double, rf As Double, Delta As Double, CalloPut As String) As Double
    
    Dim alpha As Double
    Dim Factord As Double
    Dim Factorf As Double
    
    Factord = (1 + rd) ^ (Plazo / 360)
    Factorf = (1 + rf) ^ (Plazo / 360)
    
    If CalloPut = "ATM" Then
        Inversion_Strikes = Spot * Factord / Factorf * Exp(0.5 * Vol ^ 2 * Plazo / 365)
    Else
        alpha = NAEInv(Delta * Factord)
        If CalloPut = "CALL" Then alpha = -alpha
        Inversion_Strikes = Spot * Factord / Factorf * Exp(alpha * Vol * (Plazo / 365) ^ 0.5 + 0.5 * Vol ^ 2 * Plazo / 365)
    End If
    
End Function
Public Function NAE(X As Double) As Double
'Funcion que calcula la distribución normal estándar acumulada
    Dim xabs As Double
    Dim Exponential As Variant
    Dim Build As Variant
    xabs = Abs(X)
    
    If xabs > 37 Then
        NAE = 0
    Else
        Exponential = Exp(-xabs ^ 2 / 2)
        If xabs < 7.07106781186547 Then
            Build = 3.52624965998911E-02 * xabs + 0.700383064443688
            Build = Build * xabs + 6.37396220353165
            Build = Build * xabs + 33.912866078383
            Build = Build * xabs + 112.079291497871
            Build = Build * xabs + 221.213596169931
            Build = Build * xabs + 220.206867912376
            NAE = Exponential * Build
            Build = 8.83883476483184E-02 * xabs + 1.75566716318264
            Build = Build * xabs + 16.064177579207
            Build = Build * xabs + 86.7807322029461
            Build = Build * xabs + 296.564248779674
            Build = Build * xabs + 637.333633378831
            Build = Build * xabs + 793.826512519948
            Build = Build * xabs + 440.413735824752
            NAE = NAE / Build
        Else
            Build = xabs + 0.65
            Build = xabs + 4 / Build
            Build = xabs + 3 / Build
            Build = xabs + 2 / Build
            Build = xabs + 1 / Build
            NAE = Exponential / Build / 2.506628274631
        End If
    End If
    
    If X > 0 Then NAE = 1 - NAE

End Function
Public Function NAEInv(ByVal p As Double) As Double

'  Adapted for Microsoft Visual Basic from Peter Acklam's
'  "An algorithm for computing the inverse normal cumulative distribution function"
'  (http://home.online.no/~pjacklam/notes/invnorm/)
'  by John Herrero (3-Jan-03)

    'Define coefficients in rational approximations
    Const a1 = -39.6968302866538
    Const a2 = 220.946098424521
    Const a3 = -275.928510446969
    Const a4 = 138.357751867269
    Const a5 = -30.6647980661472
    Const a6 = 2.50662827745924

    Const b1 = -54.4760987982241
    Const b2 = 161.585836858041
    Const b3 = -155.698979859887
    Const b4 = 66.8013118877197
    Const b5 = -13.2806815528857

    Const c1 = -7.78489400243029E-03
    Const c2 = -0.322396458041136
    Const c3 = -2.40075827716184
    Const c4 = -2.54973253934373
    Const c5 = 4.37466414146497
    Const c6 = 2.93816398269878

    Const d1 = 7.78469570904146E-03
    Const d2 = 0.32246712907004
    Const d3 = 2.445134137143
    Const d4 = 3.75440866190742

    'Define break-points
    Const p_low = 0.02425
    Const p_high = 1 - p_low

    'Define work variables
    Dim q As Double, r As Double

    'If argument out of bounds, raise error
    If p <= 0 Or p >= 1 Then Err.Raise 5

    If p < p_low Then
    'Rational approximation for lower region
        q = Sqr(-2 * Log(p))
        NAEInv = (((((c1 * q + c2) * q + c3) * q + c4) * q + c5) * q + c6) / _
        ((((d1 * q + d2) * q + d3) * q + d4) * q + 1)
    ElseIf p <= p_high Then
    'Rational approximation for lower region
        q = p - 0.5
        r = q * q
        NAEInv = (((((a1 * r + a2) * r + a3) * r + a4) * r + a5) * r + a6) * q / _
        (((((b1 * r + b2) * r + b3) * r + b4) * r + b5) * r + 1)
    ElseIf p < 1 Then
    'Rational approximation for upper region
        q = Sqr(-2 * Log(1 - p))
        NAEInv = -(((((c1 * q + c2) * q + c3) * q + c4) * q + c5) * q + c6) / _
        ((((d1 * q + d2) * q + d3) * q + d4) * q + 1)
    End If

End Function
Private Function Rescata_Fecha_Sistema() As Date
   
    'Dim RS As ADODB.Recordset
    'Set RS = New ADODB.Recordset
    'RS.Open "select convert( datetime , acfecproc ) from bactradersuda..mdac", Conexion
    'Rescata_Fecha_Sistema = RS(0)
    'RS.Close
    Dim Tabla() As Variant
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    Dim ErrorQuery As Integer
    
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "SP_RIEFIN_FECHA_PROCESO_REC"
    Set Proc_Alm.ActiveConnection = Conexion
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorQuery = Err.Number
    On Error GoTo 0
    
    If ErrorQuery <> 0 Then
       Exit Function
    End If
    
    Tabla = rs.GetRows
    rs.Close
    
    Rescata_Fecha_Sistema = Tabla(0, 0)
    

End Function
Public Function MultM(A() As Double, b() As Double) As Double()
    'Función que multiplica matrices y vectores
    
    Dim ColA As Integer
    Dim Fila As Integer
    Dim colB As Integer
    Dim FilB As Integer
    
    Dim i As Integer
    Dim j As Integer
    
    Dim k As Integer
    Dim m() As Double
'__________________________________________________________________________________________
'Si A y B son matrices  se ejecutarán todas las siguientes líneas
    Fila = UBound(A, 1)
    FilB = UBound(b, 1)
    
    'Si A no tiene segunda dimensión es un vector
    On Error GoTo A_es_vector:
    ColA = UBound(A, 2)
    
    'Si A no tiene el mismo número de columnas que de filas que B no se pueden multiplicar las matrices
    If ColA <> FilB Then
        MsgBox ("El número de columnas de la primera matriz es distinto al número de filas de la segunda.")
        Exit Function
    End If
    
    'Si B no tiene segunda dimensión es un vector
    On Error GoTo B_es_vector:
    colB = UBound(b, 2)
    
    ReDim m(Fila, colB)
    
    For i = 0 To Fila
        For j = 0 To colB
            For k = 0 To ColA
                m(i, j) = m(i, j) + A(i, k) * b(k, j)
                
'                If m(I, j) <> 0 Then
'                    xx = m(I, j)
'                End If
                
            Next
        Next
    Next
    
'    'para verificar M Sale distinto !!!
'    Suma = 0
'    For I = 0 To 598
'        For j = 0 To 598
'            Suma = Suma + m(I, j)
'        Next
'    Next
'    'solo para verificar
'
'    'para verificar A
'    Suma = 0
'    For I = 0 To 598
'        For j = 0 To 38
'            Suma = Suma + A(I, j)
'        Next
'    Next
'    'solo para verificar X Distinto
'
'    'para verificar B
'    Suma = 0
'    For I = 0 To 38
'        For j = 0 To 598
'            Suma = Suma + b(I, j)
'        Next
'    Next
'    'solo para verificar
    
    
    
    
    
    MultM = m
Exit Function
'__________________________________________________________________________________________
'Cuando A es un vector no se puede hacer la multiplicación
A_es_vector:
    MsgBox ("La primera matriz no puede ser un vector")
Exit Function
'____________________________________________________________________________________________
'Cuando B es un vector
B_es_vector:
    colB = 0
    
    ReDim m(Fila, colB)
    
    For i = 0 To Fila
        For j = 0 To colB
            For k = 0 To ColA
                m(i, j) = m(i, j) + A(i, k) * b(k)
            Next
        Next
    Next
    
    MultM = m
End Function
Public Function ColxCol(A() As Double, b() As Double) As Double()
    'Función que multiplica las columnas de dos matrices
    Dim i As Integer
    Dim j As Integer
    
    Dim Fila As Integer
    Dim ColA As Integer
    
    Fila = UBound(A, 1)
    ColA = UBound(A, 2)
    
    Dim Aux() As Double
    ReDim Aux(ColA)
    
    If Fila <> UBound(b, 1) Or ColA <> UBound(b, 2) Then
        MsgBox ("Las dimensiones no son compatibles para multiplicar ColxCol")
        Exit Function
    End If
    
    For j = 0 To ColA
        For i = 0 To Fila
        Aux(j) = Aux(j) + A(i, j) * b(i, j)
        Next
    Next
    ColxCol = Aux
End Function
Public Function EscalaM(Parametro As Double, Matriz() As Double) As Double()
    
    Dim ColM As Integer
    Dim FilM As Integer
    
    Dim Aux() As Double
    
    Dim i As Integer
    Dim j As Integer
    
    FilM = UBound(Matriz, 1)
    
    'Si Matriz no tiene segunda dimensión es un vector
    On Error GoTo Matriz_es_vector:
    ColM = UBound(Matriz, 2)
    
    ReDim Aux(FilM, ColM)
    
    For i = 0 To FilM
        For j = 0 To ColM
            Aux(i, j) = Parametro * Matriz(i, j)
        Next
    Next
    EscalaM = Aux
Exit Function

'Si matriz es un vector, escala el vector y devuelve un vector
Matriz_es_vector:
    
    ReDim Aux(FilM)
    
    For i = 0 To FilM
            Aux(i) = Parametro * Matriz(i)
    Next
    EscalaM = Aux
End Function
Public Function Transponer(A() As Double) As Double()
    'Función que transpone matrices y vectores
    Dim ColA As Integer
    Dim Fila As Integer
    Dim m() As Double
    
    Dim i As Integer
    Dim j As Integer
    
    Fila = UBound(A, 1)
    
    'Si no tiene segunda dimensión entonces transpone vector
    On Error GoTo Transponer_Vector:
    ColA = UBound(A, 2)
    
    ReDim m(ColA, Fila)
    
    For i = 0 To Fila
        For j = 0 To ColA
            m(j, i) = A(i, j)
        Next
    Next
    Transponer = m

Exit Function

Transponer_Vector:
    ReDim m(0, Fila)
    
    For i = 0 To Fila
        m(0, i) = A(i)
    Next
    
    Transponer = m
    
End Function
Public Function Rescata_Tenors() As Long()
    
    Dim Aux() As Long
    Dim i As Long
    
    Dim rs As ADODB.Recordset
    Set rs = New ADODB.Recordset
    rs.Open "SELECT * FROM TBL_RIEFIN_Parametros_Tenor ORDER BY DIAS", Conexion
     
    Do While rs.EOF = False
        ReDim Preserve Aux(i)
        Aux(i) = rs(1)
        i = i + 1
        rs.MoveNext
    Loop
    rs.Close
    
    Rescata_Tenors = Aux
    
End Function
Public Sub Inicia_Conexion()
    Dim Cadena_Conexion As String
    
    Set Conexion = New ADODB.Connection

    Cadena_Conexion = "Driver=SQL Server;"
    Cadena_Conexion = Cadena_Conexion & "Server=" & gsSQL_Server
    Cadena_Conexion = Cadena_Conexion & ";database=" & gsBac_LineasDb
    Cadena_Conexion = Cadena_Conexion & ";User ID=" & gsSQL_Login
    Cadena_Conexion = Cadena_Conexion & ";Password=" & gsSQL_Password
       
     Conexion.CommandTimeout = 3600
    Conexion.ConnectionTimeout = 3600
    Conexion.Open Cadena_Conexion
    
End Sub

Private Sub ConsultaSQL_Cartera_FWD_RF(Fecha As Date, Operacion() As Operaciones_FWD_RF _
                        , Valdatos As Procesos _
                        , Optional iRut As Long = 0 _
                        , Optional iCodigo As Long = 0)
    
    Dim i As Long
    Dim limi As Long
    Dim Error As Integer
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    Dim ConsultaFwd_RF As Integer
    Dim ErrorConFwd_RF As Double
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "SP_RIEFIN_CONSULTA_CARTERA_FWD_RF"
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , Fecha)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Rut", adInteger, adParamInput, , iRut)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Codigo", adInteger, adParamInput, , iCodigo)
    
    Set Proc_Alm.ActiveConnection = Conexion
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorConFwd_RF = Err.Number
        Valdatos.ErrorNumero = Err.Number
        Valdatos.ErrorDescripcion = Err.Description
        Valdatos.ErrorSP = Proc_Alm.CommandText
        Valdatos.ErrorcargaDatos = False
    On Error GoTo 0
    
    ConsultaFwd_RF = 0
    If Not ErrorConFwd_RF = 0 Then
        ConsultaFwd_RF = -1
        Valdatos.ErrorcargaDatos = True
    End If
    
    If ConsultaFwd_RF = -1 Then
         Exit Sub
    End If
        
    'Almacena los datos en una estructura para la cartera de renta fija
           
    Do While rs.EOF = False
          
        If rs(0) <> -1 Then
            ReDim Preserve Operacion(i)
            Operacion(i).Numero_Operacion = rs(0)
            Operacion(i).Sentido_operacion = rs(1)
            Operacion(i).Nemo = rs(2)
            Operacion(i).Cartera = rs(3)
            Operacion(i).Nominal = rs(4)
            Operacion(i).Emisor = rs(5)
            Operacion(i).Serie = rs(6)
            Operacion(i).Mascara = rs(7)
            Operacion(i).Fecha_Vecto_Fwd = rs(8)
            Operacion(i).Tasa_Fwd = rs(9) / 100
            Operacion(i).Cod_Moneda = rs(10)
            Operacion(i).Cod_Tasa = rs(11)
            Operacion(i).Cod_Tasa_F = rs(12)
            Operacion(i).Base = rs(13)
            Operacion(i).Valor_Mercado_BAC = rs(14)
            Operacion(i).Rut = rs(15)
            Operacion(i).Codigo = rs(16)
            Operacion(i).EarlyTermination = rs(17)
            Operacion(i).Moneda_1_BAC = rs(18)
            Operacion(i).Moneda_2_BAC = rs(19)
            Operacion(i).Plazo_Bac = rs(20)
            Operacion(i).Plazo = rs(20)
            Operacion(i).Duration = rs(21)
            Operacion(i).Producto = rs(22)
            rs.MoveNext
            i = i + 1
        Else
            Exit Do
    End If
    Loop
    rs.Close
    
    
    On Error Resume Next
        limi = UBound(Operacion, 1)
        Error = Err.Number
        On Error GoTo 0
    If Error = 0 Then
        For i = 0 To limi

            ConsultaSQL_Tabla_Desarrollo Operacion(i).Nemo, Operacion(i).Flujo
            Operacion(i).Fecha_Vecto = Operacion(i).Flujo(UBound(Operacion(i).Flujo)).Fecha
        Next
    End If
    
End Sub
Private Sub ConsultaSQL_Tabla_Desarrollo(Nemo As String, Flujo() As Tabla_Desarrollo)
    
    Dim i As Long
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "SP_RIEFIN_CONSULTA_TABLA_DESARROLLO"
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Nemo", adVarChar, adParamInput, 31, Nemo)
    Set Proc_Alm.ActiveConnection = Conexion
    'Ejecuta el procedimiento
    Set rs = Proc_Alm.Execute
    
    'Almacena los datos en una estructura para la cartera de renta fija
    Do While rs.EOF = False
        ReDim Preserve Flujo(i)
        Flujo(i).Fecha = rs(0)
        Flujo(i).Flujo = rs(1)
        rs.MoveNext
        i = i + 1
    Loop
    If rs.EOF = True Then
        ReDim Preserve Flujo(i)
        Flujo(i).Fecha = "00:00:00"
        Flujo(i).Flujo = 0
        
    End If
    
    
    rs.Close
    
End Sub
Private Sub Valoriza_FWD_RF(ByRef Operacion() As Operaciones_FWD_RF, Datos As Datos_Mercado, Fechaproc As Date, Optional ByVal XXNumero_Simulacion As Long = 0, Optional ByVal CurvasYields As String = "N")
'Funcion que valoriza
    
    Dim i As Long
    Dim limi As Long
    Dim Error As Integer
    
    On Error Resume Next
        limi = UBound(Operacion, 1)
        Error = Err.Number
        On Error GoTo 0
    If Error = 0 Then
        If XXNumero_Simulacion = 0 Then
            For i = 0 To limi
                Operacion(i).Valor_Mercado = MtM_FWD_RF(Operacion(i), Datos, Fechaproc, CurvasYields)
            Next
        Else
            For i = 0 To limi
                ReDim Preserve Operacion(i).Valor_Simulacion(1 To XXNumero_Simulacion)
                Operacion(i).Valor_Simulacion(XXNumero_Simulacion) = MtM_FWD_RF(Operacion(i), Datos, Fechaproc, CurvasYields)
            Next
        End If
    End If
    
End Sub
Private Function MtM_FWD_RF(ByRef Operacion As Operaciones_FWD_RF, Datos As Datos_Mercado, Fechaproc As Date, CurvasYields As String) As Double
'Funcion que valoriza la renta fija

    Dim Tasa_Sub As Double  'Tasa spot del subyacente
    Dim i As Long
    Dim Plazo_Sub As Long   'Plazo del subyacente
    Dim Plazo_Fwd As Long   'Plazo remanente entre el plazo forward y el plazo del flujo
    Dim MtM_Sub As Double   'MtM del subyacente
    Dim MtM_Fwd As Double   'MtM del fwd
    Dim Tasa_Fwd As Double
    
    'Calcula plazo y tasa de descuento del subyacente
    Plazo_Sub = DateDiff("d", Fechaproc, Operacion.Fecha_Vecto)
    Tasa_Sub = InterpolaTasa(Plazo_Sub, Datos.Tasas_RF(Operacion.Cod_Tasa))
    
    'Calcula valor de mercado
    For i = 0 To UBound(Operacion.Flujo)
        Plazo_Sub = DateDiff("d", Fechaproc, Operacion.Flujo(i).Fecha)
        Plazo_Fwd = DateDiff("d", Operacion.Fecha_Vecto_Fwd, Operacion.Flujo(i).Fecha)
        If Plazo_Fwd > 0 Then
            MtM_Sub = MtM_Sub + Operacion.Flujo(i).Flujo / (1 + Tasa_Sub) ^ (Plazo_Sub / Operacion.Base)
            MtM_Fwd = MtM_Fwd + Operacion.Flujo(i).Flujo / (1 + Operacion.Tasa_Fwd) ^ (Plazo_Fwd / Operacion.Base)
        End If
    Next
    
    'Aplica el costo de financiamento al forward
    Plazo_Fwd = DateDiff("d", Fechaproc, Operacion.Fecha_Vecto_Fwd)
    Tasa_Fwd = InterpolaTasa(Plazo_Fwd, Datos.Tasas_RF(Operacion.Cod_Tasa_F))
    If CurvasYields = "N" Then
    MtM_Fwd = MtM_Fwd / (1 + Tasa_Fwd * Plazo_Fwd / 360)
    Else
        MtM_Fwd = MtM_Fwd / (1 + Tasa_Fwd) ^ (Plazo_Fwd / 360)
    End If
    
    If Operacion.Sentido_operacion = "C" Then
        MtM_FWD_RF = MtM_Sub - MtM_Fwd
    ElseIf Operacion.Sentido_operacion = "V" Then
        MtM_FWD_RF = MtM_Fwd - MtM_Sub
    End If
    
    MtM_FWD_RF = Operacion.Nominal * MtM_FWD_RF / 100 * Datos.TC(Operacion.Cod_Moneda)
    
End Function

Private Sub Calcula_Covarianza(Datos() As Datos_Mercado, Covar() As Double _
                                    , Contador As Long, Valdatos As Procesos)
    
    Dim k As Long
    Dim i As Long
    Dim j As Long
    Dim Plazo As Long
    Dim Matriz() As Double
    Dim ErrorCalCov As Double
    Dim SAOCurvasPropias As String                '-- PRD20426
    
    Let SAOCurvasPropias = SAOCurvasPropiasSN()   '-- PRD20426

    For i = 0 To UBound(Datos(0).Tasas_Swap)
        For j = 0 To UBound(Datos(0).Tasas_Swap(i).Par)
            ReDim Preserve Matriz(Numero_Simulaciones, Contador)
            Plazo = Datos(0).Tasas_Swap(i).Par(j).Plazo
            Matriz(0, Contador) = Datos(0).Tasas_Swap(i).Par(j).Tasa
            For k = 1 To Numero_Simulaciones
                Matriz(k, Contador) = InterpolaTasa(Plazo, Datos(k).Tasas_Swap(i))
            Next
            Contador = Contador + 1
        Next
    Next
        
    For i = 0 To UBound(Datos(0).Tasas_Fwd)
        For j = 0 To UBound(Datos(0).Tasas_Fwd(i).Par)
            ReDim Preserve Matriz(Numero_Simulaciones, Contador)
            Plazo = Datos(0).Tasas_Fwd(i).Par(j).Plazo
            Matriz(0, Contador) = Datos(0).Tasas_Fwd(i).Par(j).Tasa
            For k = 1 To Numero_Simulaciones
                Matriz(k, Contador) = InterpolaTasa(Plazo, Datos(k).Tasas_Fwd(i))
            Next
            Contador = Contador + 1
        Next
    Next
        
    For i = 0 To UBound(Datos(0).Tasas_RF)
        For j = 0 To UBound(Datos(0).Tasas_RF(i).Par)
            ReDim Preserve Matriz(Numero_Simulaciones, Contador)
            Plazo = Datos(0).Tasas_RF(i).Par(j).Plazo
            Matriz(0, Contador) = Datos(0).Tasas_RF(i).Par(j).Tasa
            For k = 1 To Numero_Simulaciones
                Matriz(k, Contador) = InterpolaTasa(Plazo, Datos(k).Tasas_RF(i))
            Next
            Contador = Contador + 1
        Next
    Next
        
    For i = 2 To UBound(Datos(0).Paridad)
        ReDim Preserve Matriz(Numero_Simulaciones, Contador)
        For k = 0 To Numero_Simulaciones
            On Error Resume Next
                Matriz(k, Contador) = Datos(k).Paridad(i)
                ErrorCalCov = Err.Number
                Valdatos.ErrorNumero = Err.Number
                Valdatos.ErrorDescripcion = "Faltan Parametros Hist " & Datos(k).Fecha & " Moneda i-ésima " & i
                Valdatos.ErrorcargaDatos = False
            On Error GoTo 0
        Next
            Contador = Contador + 1
    Next
    
    If SAOCurvasPropias = "S" Then                  '-- PRD20426
    
        For i = 0 To UBound(Datos(0).Tasas_Opcion)
            For j = 0 To UBound(Datos(0).Tasas_Opcion(i).Par)
                ReDim Preserve Matriz(Numero_Simulaciones, Contador)
                Plazo = Datos(0).Tasas_Opcion(i).Par(j).Plazo
                Matriz(0, Contador) = Datos(0).Tasas_Opcion(i).Par(j).Tasa
                For k = 1 To Numero_Simulaciones
                    Matriz(k, Contador) = InterpolaTasa(Plazo, Datos(k).Tasas_Opcion(i))
                Next
                Contador = Contador + 1
            Next
        Next

                                   
    End If                                          '-- PRD20426
    
    If Not ErrorCalCov = 0 Then
        Valdatos.ErrorcargaDatos = True
        Exit Sub
    End If
    Covar = Covarianza(Matriz)
    Contador = Contador - 1
                
End Sub
Public Function Covarianza(Datos() As Double, Optional ByVal factor As Double = 1) As Double()
'Esta funcion acepta un panel de datos y entrega la covarianza de los retornos de los datos

    Dim i As Integer
    Dim j As Integer
    Dim X() As Double
    Dim Y() As Double 'Para poder Hacer trace
    Dim SumaFactor As Double
    
    For i = 0 To UBound(Datos, 1) - 1
        SumaFactor = SumaFactor + factor ^ i
    Next
    
    X = Calcula_Retornos(Datos, factor)
    
    'Solo para mirar
    'Suma = 0
    'For ss = 0 To 38
    '   For tt = 0 To 598
    '      Suma = Suma + X(ss, tt)
    '   Next
    'Next
    'Solo para mirar X se calcula OK
    
    
    
    Y = EscalaM(1 / SumaFactor, MultM(Transponer(X), X))
    
    'Solo para mirar
    'Dim ss As Integer
    'Dim tt As Integer
    'Suma = 0
    'For ss = 0 To 598
    '   For tt = 0 To 598
    '      Suma = Suma + Y(ss, tt)
    '   Next
    'Next
    'Solo para mirar X se calcula OK
    
    
    
    Covarianza = Y
    
End Function
Public Function Calcula_Retornos(Datos() As Double, factor As Double) As Double()
    
    Dim i As Long
    Dim limi As Long
    Dim j As Long
    Dim limj As Long
    Dim Retornos() As Double
    
    
    limi = UBound(Datos, 1) - 1
    limj = UBound(Datos, 2)
   
    ReDim Retornos(limi, limj)
    
    For i = 0 To limi
        For j = 0 To limj
            Retornos(i, j) = factor ^ (i / 2) * (Datos(i, j) - Datos(i + 1, j))
        Next
    Next
    
    Calcula_Retornos = Retornos

End Function
Private Sub ConsultaSQL_Cartera_Opcion(Fecha As Date, Operacion() As Operaciones_Opcion _
                        , Valdatos As Procesos _
                        , Optional iRut As Long = 0 _
                        , Optional iCodigo As Long = 0)
    
    Dim i As Long
    Dim j As Long
    Dim limi As Long
    Dim Error As Integer
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    Dim ConsultaOpcion As Integer
    Dim ErrorOpcion As Double
    Dim ConsultaFixing As Integer
    Dim ErrorFixing As Double
    
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Set Proc_Alm.ActiveConnection = Conexion
    Proc_Alm.CommandText = "SP_RIEFIN_CONSULTA_CARTERA_OPCIONES"
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , Fecha)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Rut", adInteger, adParamInput, , iRut)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Codigo", adInteger, adParamInput, , iCodigo)
    
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorOpcion = Err.Number
        Valdatos.ErrorNumero = Err.Number
        Valdatos.ErrorDescripcion = Err.Description
        Valdatos.ErrorSP = Proc_Alm.CommandText
        Valdatos.ErrorcargaDatos = False
    On Error GoTo 0
    
    ConsultaOpcion = 0
    If Not ErrorOpcion = 0 Then
        ConsultaOpcion = -1
        Valdatos.ErrorcargaDatos = True
    End If
    
    If ConsultaOpcion = -1 Then
         Exit Sub
    End If
    'Set rs = Proc_Alm.Execute
    
    'Ahora consulta por la cartera de opciones
    Do While rs.EOF = False
        If rs(0) <> -1 Then
            ReDim Preserve Operacion(i)
            Operacion(i).NumOp = rs(0)
            Operacion(i).Cartera = rs(1)
            Operacion(i).Estructura = rs(2)
            Operacion(i).NumEstructura = rs(3)
            Operacion(i).Call_Put = rs(4)
            Operacion(i).Payoff = rs(5)
            Operacion(i).Compra_Venta = rs(6)
            Operacion(i).Vecto = rs(7)
            Operacion(i).Nominal = rs(8)
            Operacion(i).X = rs(9)
            Operacion(i).Codigo_Spot = rs(10)
            Operacion(i).Cod_mon_val = rs(11)
            Operacion(i).Codigo_rd = rs(12)
            Operacion(i).Codigo_rf = rs(13)
            Operacion(i).Codigo_vol = rs(14)
            Operacion(i).Valor_Mercado_BAC = rs(15)
            Operacion(i).Rut = rs(16)
            Operacion(i).Codigo = rs(17)
            Operacion(i).EarlyTermination = rs(18)
            Operacion(i).Moneda_1_BAC = rs(19)
            Operacion(i).Moneda_2_BAC = rs(20)
            Operacion(i).Plazo_Bac = rs(21)
            Operacion(i).Duration = rs(22)
            
            rs.MoveNext
            i = i + 1
        Else
            Exit Do
        End If
    Loop
    rs.Close
    
    On Error Resume Next
        limi = UBound(Operacion, 1)
        Error = Err.Number
    On Error GoTo 0
    
    
    If Error = 0 Then
    'Ahora obtiene la tabla de fixings en caso de haber alguna opcion asiatica
    
        Set Proc_Alm = New ADODB.Command
        Proc_Alm.CommandType = adCmdStoredProc
        Set Proc_Alm.ActiveConnection = Conexion
    
        Proc_Alm.CommandText = "SP_RIEFIN_CONSULTA_TABLA_FIXING"
        Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , Fecha)
        Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Numero_Operacion", adInteger, adParamInput, , 0)
        Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Numero_Componente", adInteger, adParamInput, , 0)
        Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@CapturaCarteraVigente", adInteger, adParamInput, , 0)
        
        
        On Error Resume Next
            Set rs = Proc_Alm.Execute
            ErrorFixing = Err.Number
            Valdatos.ErrorNumero = Err.Number
            Valdatos.ErrorDescripcion = Err.Description
            Valdatos.ErrorSP = Proc_Alm.CommandText
            Valdatos.ErrorcargaDatos = False
        On Error GoTo 0

        ConsultaFixing = 0
        If Not ErrorFixing = 0 Then
            ConsultaFixing = -1
            Valdatos.ErrorcargaDatos = True
        End If

        If ConsultaFixing = -1 Then
             Exit Sub
        End If
       
        For i = 0 To limi
            If Operacion(i).Payoff = "02" Then
            'Consulta a la tabla de desarrollo
                Proc_Alm.Parameters.Item(1).Value = Operacion(i).NumOp
                Proc_Alm.Parameters.Item(2).Value = Operacion(i).NumEstructura
                Proc_Alm.Parameters.Item(3).Value = IIf(iRut <> 0, 1, 0) 'Cartera vigente cuando es un cliente
                                    
                Set rs = Proc_Alm.Execute
                j = 0
                Do While rs.EOF = False
                    ReDim Preserve Operacion(i).Tabla(j)
                    Operacion(i).Tabla(j).Fecha = rs(0)
                    Operacion(i).Tabla(j).Peso = rs(1)
                    Operacion(i).Tabla(j).Obs = rs(2)
                    rs.MoveNext
                    j = j + 1
                Loop
                rs.Close
            End If
        Next
    End If
    

End Sub
Private Sub Valoriza_Opcion(ByRef Operacion() As Operaciones_Opcion, Datos As Datos_Mercado, Fechaproc As Date, Optional ByVal XXNumero_Simulacion As Long = 0)

    Dim i As Long
    Dim limi As Long
    Dim Error As Integer
    
    On Error Resume Next
        limi = UBound(Operacion, 1)
        Error = Err.Number
        On Error GoTo 0
    If Error = 0 Then
        If XXNumero_Simulacion = 0 Then
            For i = 0 To limi
                If Operacion(i).Payoff = "01" Then
                    Operacion(i).Valor_Mercado = BSMercado(Operacion(i), Datos, Fechaproc)
                ElseIf Operacion(i).Payoff = "02" Then
                    Operacion(i).Valor_Mercado = BSAsiatica(Operacion(i), Datos, Fechaproc)
                End If
            Next
        Else
            For i = 0 To limi
                ReDim Preserve Operacion(i).Valor_Simulacion(1 To XXNumero_Simulacion)
                If Operacion(i).Payoff = "01" Then
                    Operacion(i).Valor_Simulacion(XXNumero_Simulacion) = BSMercado(Operacion(i), Datos, Fechaproc)
                ElseIf Operacion(i).Payoff = "02" Then
                    Operacion(i).Valor_Simulacion(XXNumero_Simulacion) = BSAsiatica(Operacion(i), Datos, Fechaproc)
                End If
            Next
        End If
    End If
    
End Sub
Private Function BSMercado(Operacion As Operaciones_Opcion, Datos As Datos_Mercado, Fecha As Date) As Double
'Función que calcula el valor de una opción usando la fórmula de Black-Scholes
    
    Dim rd As Double
    Dim rf As Double
    Dim Vol As Double
    Dim Fwd As Double
    Dim d1 As Double
    Dim d2 As Double
    Dim n1 As Double
    Dim n2 As Double
    Dim Factord As Double
    Dim Factorf As Double
    Dim Signo As Long
    Dim Aux(3) As Double
    
    Dim SAOCurvasPropias As String
    
    Let SAOCurvasPropias = SAOCurvasPropiasSN()
    
    'If Operacion.Plazo > 0 Then
        Operacion.Plazo = Operacion.Vecto - Fecha
   ' End If
    If Operacion.Plazo > 0 Then
        
        'Volatilidad implicita
        Vol = InterpolaVol(Datos.Vol(Operacion.Codigo_vol).Superf, Operacion.Plazo, Operacion.X)
        
        If SAOCurvasPropias = "N" Then
        'Calculo de tasas (ojo que esta usando las tasas swap)
        rd = InterpolaTasa(Operacion.Plazo, Datos.Tasas_Swap(Operacion.Codigo_rd))
        rf = InterpolaTasa(Operacion.Plazo, Datos.Tasas_Swap(Operacion.Codigo_rf))
        Else
            'Calculo de tasas (ojo que esta usando sus propias curvas)
            rd = InterpolaTasa(Operacion.Plazo, Datos.Tasas_Opcion(Operacion.Codigo_rd))
            rf = InterpolaTasa(Operacion.Plazo, Datos.Tasas_Opcion(Operacion.Codigo_rf))
        End If
        
        'Calculo de factor de descuento
        Factord = (1 + rd) ^ (Operacion.Plazo / 360)
        Factorf = (1 + rf) ^ (Operacion.Plazo / 360)
    
        'Precio fwd del subyacente del subyacente
        Fwd = Datos.TC(Operacion.Codigo_Spot) * Factord / Factorf

        'Variable auxiliar para calculo de B&S
        If UCase(Operacion.Call_Put) = "CALL" Then
            Signo = 1#
        ElseIf UCase(Operacion.Call_Put) = "PUT" Then
            Signo = -1#
        End If
        
        'Calculos de Black-Scholes
        d1 = (Log(Fwd / Operacion.X) + 0.5 * Vol ^ 2 * Operacion.Plazo / 365) / (Vol * (Operacion.Plazo / 365) ^ 0.5)
        d2 = d1 - Vol * (Operacion.Plazo / 365) ^ 0.5
        n1 = NAE(Signo * d1)
        n2 = NAE(Signo * d2)
    
        'Valor de mercado
        BSMercado = Signo * (Fwd * n1 - Operacion.X * n2) / Factord
        
        'Si la operacion es una venta, entonces multiplica por (-1)
        If Operacion.Compra_Venta = "C" Then
            Signo = 1
        Else
            Signo = -1
        End If
        
        'Genera el valor de mercado en pesos y con signo según compra o venta
        BSMercado = Signo * Operacion.Nominal * Datos.TC(Operacion.Cod_mon_val) * BSMercado
        
    End If

End Function
Private Function BSAsiatica(ByRef Operacion As Operaciones_Opcion, Datos As Datos_Mercado, Fecha As Date)
    'Funcion que calcula el M2M de una opcion asiatica
    
    Dim d1 As Double
    Dim d2 As Double
    Dim M1 As Double
    Dim M2 As Double
    Dim k As Double
    Dim Pond As Double
    Dim LnM1 As Double
    Dim LnM2 As Double
    Dim LnK As Double
    Dim rd As Double
    Dim Factord As Double
    Dim n1 As Variant
    Dim n2 As Variant
    
    Dim SAOCurvasPropias As String
    
    Let SAOCurvasPropias = SAOCurvasPropiasSN()
    
    
    'If Operacion.Plazo > 0 Then
        Operacion.Plazo = Operacion.Vecto - Fecha
    'End If
    If Operacion.Plazo > 0 Then
        'Calcula la volatilidad implicita ajustada
        CalculaMomentos Operacion, Datos, Fecha, M1, M2, k, Pond, SAOCurvasPropias
    
        'Calcula el factor de descuento
        If SAOCurvasPropias = "N" Then
        rd = InterpolaTasa(Operacion.Plazo, Datos.Tasas_Swap(Operacion.Codigo_rd))
        Else
            rd = InterpolaTasa(Operacion.Plazo, Datos.Tasas_Opcion(Operacion.Codigo_rd))
        End If
        Factord = (1 + rd) ^ (Operacion.Plazo / 360)
    
        If k > 0 Then
        'Si todavia existe incertidumbre respecto al ejercicio de la opcion
            LnM1 = Log(M1)
            LnM2 = Log(M2)
            LnK = Log(k)
    
            d1 = (0.5 * LnM2 - LnK) / (LnM2 - 2 * LnM1) ^ 0.5
            d2 = (2 * LnM1 - 0.5 * LnM2 - LnK) / (LnM2 - 2 * LnM1) ^ 0.5
    
            If Operacion.Call_Put = "Call" Then
                n1 = NAE(d1)
                n2 = NAE(d2)
                BSAsiatica = Pond * Operacion.Nominal * (M1 * n1 - k * n2) / Factord
            ElseIf Operacion.Call_Put = "Put" Then
                n1 = NAE(-d1)
                n2 = NAE(-d2)
                BSAsiatica = Pond * Operacion.Nominal * (k * n2 - M1 * n1) / Factord
            End If
        Else
        'Si no existe incertidumbre
            If Operacion.Call_Put = "Call" Then
                BSAsiatica = Pond * Operacion.Nominal * (M1 - k) / Factord
            End If
        End If
    
        If Operacion.Compra_Venta = "V" Then
        'Si la opcion es una venta se multiplica el valor por (-1)
            BSAsiatica = -BSAsiatica
        End If
        
        'Ahora obtiene el resultado en pesos
        BSAsiatica = Datos.TC(Operacion.Cod_mon_val) * BSAsiatica
    End If
    
End Function
Private Sub CalculaMomentos(Operacion As Operaciones_Opcion, Datos As Datos_Mercado, Fecha As Date, ByRef M1 As Double, ByRef M2 As Double, ByRef k As Double, ByRef Pond As Double, ByRef SAOCurvasPropias As String)
    
    Dim i As Long
    Dim j As Long
    Dim rd As Double
    Dim rf As Double
    Dim Largo_Tabla As Long
    Dim Fwd() As Double
    Dim Vol() As Double
    
    Largo_Tabla = UBound(Operacion.Tabla)
    ReDim Fwd(Largo_Tabla)
    ReDim Vol(Largo_Tabla)
    
    'Calculo del primer momento
    For i = 0 To Largo_Tabla
        Operacion.Tabla(i).Plazo = Operacion.Tabla(i).Fecha - Fecha
        If Operacion.Tabla(i).Plazo = 0 Then
        'Si el fixing se hace hoy
            Fwd(i) = Datos.TC(Operacion.Codigo_Spot)
            M1 = M1 + Fwd(i) * Operacion.Tabla(i).Peso
            Pond = Pond + Operacion.Tabla(i).Peso
        ElseIf Operacion.Tabla(i).Plazo > 0 Then
        'Si el fixing se hara en el futuro
            If SAOCurvasPropias = "N" Then
            rd = InterpolaTasa(Operacion.Tabla(i).Plazo, Datos.Tasas_Swap(Operacion.Codigo_rd))
            rf = InterpolaTasa(Operacion.Tabla(i).Plazo, Datos.Tasas_Swap(Operacion.Codigo_rf))
            Else
                rd = InterpolaTasa(Operacion.Tabla(i).Plazo, Datos.Tasas_Opcion(Operacion.Codigo_rd))
                rf = InterpolaTasa(Operacion.Tabla(i).Plazo, Datos.Tasas_Opcion(Operacion.Codigo_rf))
            End If
            Fwd(i) = Datos.TC(Operacion.Codigo_Spot) * ((1 + rd) / (1 + rf)) ^ (Operacion.Tabla(i).Plazo / 360)
            M1 = M1 + Fwd(i) * Operacion.Tabla(i).Peso
            Pond = Pond + Operacion.Tabla(i).Peso
        Else
        'Si el fixing ya ocurrio
            k = k + Operacion.Tabla(i).Obs * Operacion.Tabla(i).Peso
        End If
    Next
    M1 = M1 / Pond
    k = (Operacion.X - k) / Pond
    
    If k > 0 Then
    'Si todavía hay incertidumbre respecto al ejercicio de la opción
    
        'Calculo del segundo momento
        'Calcula la volatilidad implícita para cada uno de los fixings en funcion del nuevo strike
        For i = 0 To Largo_Tabla
            If Operacion.Tabla(i).Plazo >= 0 Then
                Vol(i) = InterpolaVol(Datos.Vol(Operacion.Codigo_vol).Superf, Operacion.Tabla(i).Plazo, k)
                M2 = M2 + (Operacion.Tabla(i).Peso / Pond * Fwd(i)) ^ 2 * Exp(Vol(i) ^ 2 * Operacion.Tabla(i).Plazo / 365)
            End If
        Next
    
        For i = 1 To Largo_Tabla
            If Operacion.Tabla(i).Plazo >= 0 Then
                For j = 0 To i - 1
                    If Operacion.Tabla(j).Plazo >= 0 Then
                        M2 = M2 + 2 / Pond ^ 2 * Operacion.Tabla(i).Peso * Operacion.Tabla(j).Peso * Fwd(i) * Fwd(j) * Exp(Vol(j) ^ 2 * Operacion.Tabla(j).Plazo / 365)
                    End If
                Next
            End If
        Next
    End If
    
End Sub

Private Sub ConsultaSQL_Cartera_Fwd(Fecha As Date, Operacion() As Operaciones_Fwd _
                        , Valdatos As Procesos _
                        , Optional iRut As Long = 0 _
                        , Optional iCodigo As Long = 0)
    
    
    Dim i As Long
    Dim Tabla() As Variant
    Dim Num_Flujos As Long
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    Dim ConsultaForward As Integer
    Dim ErrorConForward As Double
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "SP_RIEFIN_CONSULTA_CARTERA_FWD"
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , Fecha)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Rut", adInteger, adParamInput, , iRut)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Codigo", adInteger, adParamInput, , iCodigo)
    
    Set Proc_Alm.ActiveConnection = Conexion
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorConForward = Err.Number
        Valdatos.ErrorNumero = Err.Number
        Valdatos.ErrorDescripcion = Err.Description
        Valdatos.ErrorSP = Proc_Alm.CommandText
        Valdatos.ErrorcargaDatos = False
    On Error GoTo 0
    
    ConsultaForward = 0
    If Not ErrorConForward = 0 Then
        ConsultaForward = -1
        Valdatos.ErrorcargaDatos = True
    End If
    
    If ConsultaForward = -1 Then
         Exit Sub
    End If
    
    'Set rs = Proc_Alm.Execute
    If Not rs.BOF Then
        Tabla = rs.GetRows
        rs.Close
        'Almacena los datos en una estructura para la cartera Fwd
        
        If Tabla(0, 0) <> -1 Then
            Num_Flujos = UBound(Tabla, 2)
            ReDim Operacion(Num_Flujos)
            For i = 0 To Num_Flujos
                Operacion(i).Numero_Operacion = Tabla(0, i)
                Operacion(i).Sentido_operacion = Tabla(1, i)
                Operacion(i).Tipo_forward = Tabla(2, i)
                Operacion(i).Modalidad_pago = Tabla(3, i)
                Operacion(i).Cartera = Tabla(4, i)
                Operacion(i).Moneda(0) = Tabla(5, i)
                Operacion(i).Moneda(1) = Tabla(6, i)
                Operacion(i).Fecha_ini = Tabla(7, i)
                Operacion(i).Fecha_fin = Tabla(8, i)
                Operacion(i).Fecha_efectiva = Tabla(9, i)
                Operacion(i).Codigo_descuento(0) = Tabla(10, i)
                Operacion(i).Codigo_descuento(1) = Tabla(11, i)
                Operacion(i).Amortizacion(0) = Tabla(12, i)
                Operacion(i).Amortizacion(1) = Tabla(13, i)
                Operacion(i).Valor_Mercado_BAC = Tabla(14, i) + Tabla(15, i)
                Operacion(i).Fecha_fixing = Tabla(16, i)
                Operacion(i).Puntos_fwd = Tabla(17, i)
                Operacion(i).Rut = Tabla(18, i)
                Operacion(i).Codigo = Tabla(19, i)
                Operacion(i).EarlyTermination = Tabla(20, i)
                Operacion(i).Moneda_1_BAC = Tabla(21, i)
                Operacion(i).Moneda_2_BAC = Tabla(22, i)
                Operacion(i).Plazo = Tabla(23, i)
                Operacion(i).Duration = Format(Tabla(24, i), FDec4Dec)
            Next
        End If
    End If
End Sub

Private Sub Valoriza_Fwd(ByRef Operacion() As Operaciones_Fwd, Datos As Datos_Mercado, Fechaproc As Date, Optional ByVal XXNumero_Simulacion As Long = 0, Optional ByVal CurvasYields As String = "N")
'Funcion que valoriza los forwards

    Dim i As Long
    Dim limi As Long
    Dim Error As Integer
    
    On Error Resume Next
        limi = UBound(Operacion, 1)
        Error = Err.Number
        On Error GoTo 0
    If Error = 0 Then
       
        If XXNumero_Simulacion = 0 Then
            For i = 0 To limi
                Operacion(i).Valor_Mercado = MtM_Fwd(Operacion(i), Datos, Fechaproc, CurvasYields)
            Next
        Else
            For i = 0 To limi
                ReDim Preserve Operacion(i).Valor_Simulacion(1 To XXNumero_Simulacion)
                Operacion(i).Valor_Simulacion(XXNumero_Simulacion) = MtM_Fwd(Operacion(i), Datos, Fechaproc, CurvasYields)
            Next
        End If
    End If
    
End Sub

Private Function MtM_Fwd(ByRef Operacion As Operaciones_Fwd, Datos As Datos_Mercado, Fechaproc As Date, CurvasYields As String) As Double
'Funcion que valoriza los swaps

    Dim i As Long
    Dim Tasadesc(1) As Double
    Dim Factordesc(1) As Double
    Dim Tasafwd(1) As Double
    Dim Factorfwd(1) As Double
    Dim Valor(1) As Double
    
    'Calcula los plazos atingentes
    If Operacion.Fecha_efectiva > 0 Then
        Operacion.Plazo_efectivo = Operacion.Fecha_efectiva - Fechaproc
    End If
    If Operacion.Fecha_fixing > 0 Then
        Operacion.Plazo_fixing = Operacion.Fecha_fixing - Fechaproc
    End If
    
        
    If Operacion.Plazo_efectivo >= 0 Then
    'Si el flujo no ha sido liquidado se puede valorizar
        
        For i = 0 To 1
            Tasadesc(i) = InterpolaTasa(Operacion.Plazo_efectivo, Datos.Tasas_Fwd(Operacion.Codigo_descuento(i)))
        Next
        
        'Se hace el diferenciamiento porque existen distintas convenciones de curvas. Esto se debe modificar en BAC
        If Operacion.Tipo_forward = 1 Or Operacion.Tipo_forward = 14 Then
        'Seguro de cambio
            
            For i = 0 To 1
                'MAP: Parametrización de uso de Curva: Lineal o compuesta (Yield)
                If CurvasYields = "N" Then
                    Factordesc(i) = (1 + Tasadesc(i) * Operacion.Plazo_efectivo / 360) 'Lineal
                Else
                    Factordesc(i) = (1 + Tasadesc(i)) ^ (Operacion.Plazo_efectivo / 360) 'Compuesto o Yield
                End If
            Next
            
            If Operacion.Tipo_forward = 14 And Operacion.Plazo_fixing >= 0 Then
            'Forward observado que aun no fixea
                For i = 0 To 1
                    Tasafwd(i) = InterpolaTasa(Operacion.Plazo_fixing, Datos.Tasas_Fwd(Operacion.Codigo_descuento(i)))
                    If CurvasYields = "N" Then
                        Factorfwd(i) = (1 + Tasafwd(i) * Operacion.Plazo_fixing / 360) 'Lineal
                    Else
                        Factorfwd(i) = (1 + Tasafwd(i)) ^ (Operacion.Plazo_fixing / 360) 'Compuesto o Yield
                    End If
                Next
                'Calcula el nocional en pesos
                Operacion.Amortizacion(1) = Round(Operacion.Amortizacion(0) * (Datos.TC(Operacion.Moneda(0)) * Factorfwd(1) / Factorfwd(0) + Operacion.Puntos_fwd))
            End If
            
            For i = 0 To 1
                Valor(i) = Datos.TC(Operacion.Moneda(i)) * Operacion.Amortizacion(i) / Factordesc(i)
            Next
        
        ElseIf Operacion.Tipo_forward = 3 Or Operacion.Tipo_forward = 13 Then
        'Seguro de inflacion
            'Primero calcula el precio forward de la inflacion
            'MAP: notar que las tasas ya se tratan como fueran Yield
            Valor(0) = Datos.TC(Operacion.Moneda(0)) * ((1 + Tasadesc(1)) / (1 + Max(Tasadesc(0), -0.9999))) ^ (Operacion.Plazo_efectivo / 360)
            'Ahora descuenta el flujo en UF con la tasa en pesos
            
            If CurvasYields = "N" Then
                Valor(0) = Valor(0) * Operacion.Amortizacion(0) / (1 + Tasadesc(1) * Operacion.Plazo_efectivo / 360) 'Lineal
            Else
                Valor(0) = Valor(0) * Operacion.Amortizacion(0) / (1 + Tasadesc(1)) ^ (Operacion.Plazo_efectivo / 360) 'Compuesto o Yield
            End If
            'Descuenta el flujo en pesos
            
            'MAP: Formato Lineal deja de usarse
            'por esto se comenta la siguiente linea
            If CurvasYields = "N" Then
                Valor(1) = Operacion.Amortizacion(1) / (1 + Tasadesc(1) * Operacion.Plazo_efectivo / 360) 'Lineal
            Else
                Valor(1) = Operacion.Amortizacion(1) / (1 + Tasadesc(1)) ^ (Operacion.Plazo_efectivo / 360) 'Compuesto o Yield
            End If
        
        ElseIf Operacion.Tipo_forward = 2 Then
        'Arbitraje monedas extranjeras
            For i = 0 To 1
                If CurvasYields = "N" Then
                    Valor(i) = Datos.TC(Operacion.Moneda(i)) * Operacion.Amortizacion(i) / (1 + Tasadesc(i) * Operacion.Plazo_efectivo / 360) 'Lineal
                Else
                    Valor(i) = Datos.TC(Operacion.Moneda(i)) * Operacion.Amortizacion(i) / (1 + Tasadesc(i)) ^ (Operacion.Plazo_efectivo / 360) 'Compuesto o Yield
                End If
            Next
        
        End If
        
    End If
    
    'Define la pata activa y pasiva
    If Operacion.Sentido_operacion = "C" Then
        Valor(1) = -Valor(1)
    ElseIf Operacion.Sentido_operacion = "V" Then
        Valor(0) = -Valor(0)
    End If
    MtM_Fwd = Valor(0) + Valor(1)
    
End Function
Private Sub ConsultaSQL_Cartera_Swap(Fecha As Date, Operacion() As Operaciones_Swap _
                        , Valdatos As Procesos _
                        , Optional iRut As Long = 0 _
                        , Optional iCodigo As Long = 0)
    
    Dim i As Long
    Dim Tabla() As Variant
    Dim Num_Flujos As Long
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    Dim ConsultaSwap As Integer
    Dim ErrorConSwap As Double
    'Inicia la variable para ejecutar el procedimiento almacenado
    
    
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "SP_RIEFIN_CONSULTA_CARTERA_SWAP"
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , Fecha)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Rut", adInteger, adParamInput, , iRut)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Codigo", adInteger, adParamInput, , iCodigo)
    Set Proc_Alm.ActiveConnection = Conexion
    
    
    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorConSwap = Err.Number
        Valdatos.ErrorNumero = Err.Number
        Valdatos.ErrorDescripcion = Err.Description
        Valdatos.ErrorSP = Proc_Alm.CommandText
        Valdatos.ErrorcargaDatos = False
    On Error GoTo 0
    
    ConsultaSwap = 0
    If Not ErrorConSwap = 0 Then
        ConsultaSwap = -1
        Valdatos.ErrorcargaDatos = True
    End If
    
    If ConsultaSwap = -1 Then
         Exit Sub
    End If
    
    'Set rs = Proc_Alm.Execute
    If Not rs.BOF Then
        Tabla = rs.GetRows
        rs.Close
    'Almacena los datos en una estructura para la cartera swap
        Let i = 0
        
        If Tabla(0, i) <> -1 Then
            Num_Flujos = UBound(Tabla, 2)
            ReDim Operacion(Num_Flujos)
            
            For i = 0 To Num_Flujos
                'ReDim Preserve Operacion(i)
                Operacion(i).Numero_Operacion = Tabla(0, i)
                Operacion(i).Numero_flujo = Tabla(1, i)
                Operacion(i).Tipo_flujo = Tabla(2, i)
                Operacion(i).Tipo_swap = Tabla(3, i)
                Operacion(i).Modalidad_pago = Tabla(4, i)
                Operacion(i).Cartera = Tabla(5, i)
                Operacion(i).Moneda = Tabla(6, i)
                Operacion(i).Codigo_tasa = Tabla(7, i)
                Operacion(i).Convencion = Tabla(8, i)
                Operacion(i).Base = IIf(Tabla(9, i) = "A", 1, Tabla(9, i))
                Operacion(i).PlazoFwd = Tabla(10, i)
                Operacion(i).IndexLag = Tabla(11, i)
                Operacion(i).Fecha_ini = Tabla(12, i)
                Operacion(i).Fecha_fin = Tabla(13, i)
                Operacion(i).Fecha_fija = Tabla(14, i)
                Operacion(i).Fecha_liq = Tabla(15, i)
                Operacion(i).Codigo_descuento = Tabla(16, i)
                Operacion(i).Codigo_forward = Tabla(17, i)
                Operacion(i).Tasa_flujo = Tabla(18, i)
                Operacion(i).Spread = Tabla(19, i)
                Operacion(i).Saldo = Tabla(20, i)
                Operacion(i).Amortizacion = Tabla(21, i)
                Operacion(i).Flujo_adicional = Tabla(22, i)
                Operacion(i).Valor_Mercado_BAC = Tabla(23, i)
                                
                If Operacion(i).Codigo_tasa = 13 Then
                    Operacion(i).PlazoFwd = CuentaDias(Operacion(i).Fecha_ini, Operacion(i).Fecha_fin, Operacion(i).Convencion, Operacion(i).Base)
                End If
                Operacion(i).Rut = Tabla(24, i)
                Operacion(i).Codigo = Tabla(25, i)
                Operacion(i).EarlyTermination = Tabla(26, i)
                Operacion(i).Moneda_Bac = Tabla(27, i)
                Operacion(i).Plazo = Tabla(28, i)
                Operacion(i).Duration = Format(Tabla(29, i), FDec4Dec)
            Next
        End If
    End If
    
End Sub


Private Sub Valoriza_Swap(ByRef Operacion() As Operaciones_Swap, Datos As Datos_Mercado, Fechaproc As Date, Optional ByVal XXNumero_Simulacion As Long = 0)
'Funcion que valoriza los swaps

    Dim i As Long
    Dim limi As Long
    Dim Error As Integer
    Dim Valor_Mercado As Double
    
    On Error Resume Next
        limi = UBound(Operacion, 1)
        Error = Err.Number
        On Error GoTo 0
    If Error = 0 Then
        If XXNumero_Simulacion = 0 Then
            For i = 0 To limi
                Operacion(i).Valor_Mercado = MtM_Flujo_Swap(Operacion(i), Datos, Fechaproc)
                Operacion(i).FlujoFuturo = CalculaFlujo(Operacion(i), Datos, Fechaproc)
               
            Next
        Else
            For i = 0 To limi
                ReDim Preserve Operacion(i).Valor_Simulacion(1 To XXNumero_Simulacion)
                Operacion(i).Valor_Simulacion(XXNumero_Simulacion) = MtM_Flujo_Swap(Operacion(i), Datos, Fechaproc)
            Next
        End If
    End If
    
End Sub
Private Function MtM_Flujo_Swap(ByRef Operacion As Operaciones_Swap, Datos As Datos_Mercado, Fechaproc As Date) As Double
'Funcion que valoriza los swaps

    Dim Flujo As Double
    Dim Tasadesc As Double
    
    'Calcula los plazos atingentes
    CalculaPlazos Operacion, Fechaproc
        
    If Operacion.Plazo_liq > 0 Then
    'Si el flujo no ha sido liquidado se puede valorizar
        Flujo = Datos.TC(Operacion.Moneda) * CalculaFlujo(Operacion, Datos, Fechaproc)
        If Operacion.Tipo_flujo = 2 Then Flujo = -Flujo
            
        Tasadesc = InterpolaTasa(Operacion.Plazo_liq, Datos.Tasas_Swap(Operacion.Codigo_descuento))
        MtM_Flujo_Swap = Round(Flujo / (1 + Tasadesc) ^ (Operacion.Plazo_liq / 360), 0)
    End If
    
    
End Function
Private Sub CalculaPlazos(ByRef Operacion As Operaciones_Swap, Fecha_proc As Date)
    If Operacion.Fecha_liq > 0 Then
         Operacion.Plazo_liq = Operacion.Fecha_liq - Fecha_proc
    
    End If
   
    
    If Operacion.Plazo_liq > 0 Then
    'Si la pata es flotante
        Operacion.Dias = CuentaDias(Operacion.Fecha_ini, Operacion.Fecha_fin, Operacion.Convencion, Operacion.Base)
        
        If Operacion.Codigo_tasa = 13 Or Operacion.Codigo_tasa = 0 Or Operacion.Codigo_tasa = 21 Then '-> Indicador de IBR, igualado en fechas con la UF y el ICP
        'Si la pata es flotante cámara o IBR
            Operacion.Plazo_ini = CuentaDias(Fecha_proc, Operacion.Fecha_ini, Operacion.Convencion, Operacion.Base)
            Operacion.Plazo_fin = CuentaDias(Fecha_proc, Operacion.Fecha_fin, Operacion.Convencion, Operacion.Base)
        
        ElseIf Operacion.Codigo_forward <> -1 Then
        'Si la pata es flotante sobre tasa TAB o LIBOR
            Operacion.Plazo_ini = SumaFecha(Operacion.Fecha_fija, Operacion.IndexLag) - Fecha_proc
            Operacion.Plazo_fin = Operacion.Plazo_ini + Operacion.PlazoFwd
            
        End If
    End If
        
End Sub

Private Function CalculaFlujo(Operacion As Operaciones_Swap, Datos As Datos_Mercado, Fechaproc As Date) As Double
'Función que calcula el flujo

    Dim Tasaini As Double
    Dim Tasafin As Double
    Dim Interes As Double
    Dim Tasacorrido As Double
    
    If Operacion.Codigo_tasa <> 0 Then
        'Si la pata es flotante se calcula el interés proyectado
        Tasafin = InterpolaTasa(Operacion.Plazo_fin, Datos.Tasas_Swap(Operacion.Codigo_forward))

        If Operacion.Plazo_ini < 0 Then
            If Operacion.Codigo_tasa = 13 Then
                'Si ya comenzó a devengar el flujo (sólo para ICP)           +  Operacion.Codigo_tasa (para identificar que es ICP y no IBR
                Tasacorrido = Calcula_Tasa_Corrido(Operacion, Datos, Fechaproc, Operacion.Codigo_tasa)
                Operacion.Tasa_flujo = ((1 + Tasacorrido * (-Operacion.Plazo_ini / Operacion.Base)) * (1 + Tasafin) ^ (Operacion.Plazo_fin / 360) - 1) * Operacion.Base / Operacion.PlazoFwd
            End If
        
            '-> Indicador de IBR, igualado en fechas con la UF y el ICP
            If Operacion.Codigo_tasa = 21 Then
                'Si ya comenzó a devengar el flujo (sólo para IBR)          +   Operacion.Codigo_tasa (para identificar que es IBR y no ICP
                Tasacorrido = Calcula_Tasa_Corrido(Operacion, Datos, Fechaproc, Operacion.Codigo_tasa)
                Operacion.Tasa_flujo = ((1 + Tasacorrido * (-Operacion.Plazo_ini / Operacion.Base)) * (1 + Tasafin) ^ (Operacion.Plazo_fin / 360) - 1) * Operacion.Base / Operacion.PlazoFwd
            End If
            '-> Indicador de IBR, igualado en fechas con la UF y el ICP
        
        Else
            'Si el flujo aun no ha comenzado a devengar
            If Operacion.Plazo_fin <> Operacion.Plazo_ini Then
                Tasaini = InterpolaTasa(Operacion.Plazo_ini, Datos.Tasas_Swap(Operacion.Codigo_forward))
                Operacion.Tasa_flujo = ((1 + Tasafin) ^ (Operacion.Plazo_fin / 360) / (1 + Tasaini) ^ (Operacion.Plazo_ini / 360) - 1) * Operacion.Base / Operacion.PlazoFwd
            Else
                Operacion.Tasa_flujo = 0
            End If
            
        End If
        
    End If
    
    Interes = Operacion.Saldo * (Operacion.Tasa_flujo + Operacion.Spread) * Operacion.Dias / Operacion.Base
    CalculaFlujo = Operacion.Amortizacion + Operacion.Flujo_adicional + Interes
    
End Function

Private Function Calcula_Tasa_Corrido(Operacion As Operaciones_Swap, Datos As Datos_Mercado, Fechaproc As Date, Optional ByVal iIndicador As Integer) As Double
    Dim Corrido As Double
    
    '-> Indicador de IBR, igualado en fechas con la UF y el ICP
    If iIndicador = 21 Then
        Corrido = CalculaCorridoIBR(Operacion, Datos, Fechaproc)
        Calcula_Tasa_Corrido = Round((Corrido - 1) * Operacion.Base / (-Operacion.Plazo_ini), 4)
    Else
        Corrido = CalculaCorrido(Operacion, Datos, Fechaproc)
        Calcula_Tasa_Corrido = Round((Corrido - 1) * Operacion.Base / (-Operacion.Plazo_ini), 4)
    End If
End Function

Private Function CalculaCorrido(Operacion As Operaciones_Swap, Datos As Datos_Mercado, Fechaproc As Date) As Double
    Dim ICP0 As Double
    Dim ICP1 As Double
    Dim UF0 As Double
    Dim UF1 As Double
    
    ICP0 = Busca_en_Tabla_Datos(Datos.ICP, Operacion.Fecha_ini)
    ICP1 = Busca_en_Tabla_Datos(Datos.ICP, Fechaproc)
    
    If Operacion.Moneda = 0 Then
        CalculaCorrido = ICP1 / ICP0
    ElseIf Operacion.Moneda = 1 Then
        UF0 = Busca_en_Tabla_Datos(Datos.UF, Operacion.Fecha_ini)
        UF1 = Busca_en_Tabla_Datos(Datos.UF, Fechaproc)        
        CalculaCorrido = ICP1 / ICP0 * UF0 / UF1
    End If
End Function

'-> Indicador de IBR, igualado en fechas con la UF y el ICP
Private Function CalculaCorridoIBR(Operacion As Operaciones_Swap, Datos As Datos_Mercado, Fechaproc As Date) As Double
    Dim IBR0    As Double
    Dim IBR1    As Double
    Dim UF0     As Double
    Dim UF1     As Double

    IBR0 = Busca_en_Tabla_Datos(Datos.IBR, Operacion.Fecha_ini)
    IBR1 = Busca_en_Tabla_Datos(Datos.IBR, Fechaproc)

    If Operacion.Moneda = 0 Then
        CalculaCorridoIBR = IBR1 / IBR0
    
    ElseIf Operacion.Moneda = 1 Then
        UF0 = Busca_en_Tabla_Datos(Datos.UF, Operacion.Fecha_ini)
        UF1 = Busca_en_Tabla_Datos(Datos.UF, Fechaproc)
        
        CalculaCorridoIBR = IBR1 / IBR0 * UF0 / UF1
    End If
End Function
'-> Indicador de IBR, igualado en fechas con la UF y el ICP

Private Function HayCartera(Cartera As Negociacion) As Boolean
    Dim LarCarSwap As Long
    Dim ErrorCarSwap As Long
    Dim LarCarFwd As Long
    Dim ErrorCarFwd As Long
    Dim LarCarFwd_RF As Long
    Dim ErrorCarFwd_RF As Long
    Dim LarCarOpcion As Long
    Dim ErrorCarOpcion As Long
    
    
    HayCartera = True
    
    
    On Error Resume Next
    LarCarSwap = UBound(Cartera.Cartera_Swap)
    ErrorCarSwap = Err.Number
    On Error GoTo 0
    
    On Error Resume Next
    LarCarFwd = UBound(Cartera.Cartera_Fwd)
    ErrorCarFwd = Err.Number
    On Error GoTo 0
    
    On Error Resume Next
    LarCarFwd_RF = UBound(Cartera.Cartera_Fwd_RF)
    ErrorCarFwd_RF = Err.Number
    On Error GoTo 0
    
    
    On Error Resume Next
    LarCarOpcion = UBound(Cartera.Cartera_Opcion)
    ErrorCarOpcion = Err.Number
    On Error GoTo 0
    
    If ErrorCarSwap <> 0 And _
       ErrorCarFwd <> 0 And _
       ErrorCarFwd_RF <> 0 And _
       ErrorCarOpcion <> 0 Then
       
       HayCartera = False
       
    End If
End Function
'/* SECCION A NO COMPARAAR BacCalculoREC y DLLBacCalculoREC */
'/* SECCION A NO COMPARAAR BacCalculoREC y DLLBacCalculoREC */
'/* SECCION A NO COMPARAAR BacCalculoREC y DLLBacCalculoREC */
Private Sub AgregaFlujosCurso(Cartera As Negociacion, CarteraOperacionCurso As Negociacion, Sistema As String)
     '-- Posibilidades: Operaciones_Swap, Operaciones_Fwd, Operaciones_FWD_RF
     
     Dim EntraREC As Integer
     
     Dim i As Long
     Dim IndiceSwap As Long
     Dim IndiceFwd  As Long
     Dim IndiceFwd_RF As Long
     Dim Aux          As Long
     Dim limi As Long
     
    Dim Error As Long
    Dim ErrorCarSwap As Integer
    Dim ErrorCarFwd As Integer
    Dim ErrorCarFwd_RF As Integer
    
    Dim ErrorOpCurSwap As Integer
    Dim ErrorOpCurFwd As Integer
    Dim ErrorOpCurFwd_RF As Integer
    
     
     
     If Sistema = "Swap" Then
     On Error Resume Next
        IndiceSwap = UBound(Cartera.Cartera_Swap) + 1   'Indice para el nuevo registro
        ErrorCarSwap = Err.Number
     On Error GoTo 0
     'Puede que no exista cartera vigente Swap, copiar para Forward, Forward_RF, Opciones
   
   
     On Error Resume Next
        Aux = UBound(CarteraOperacionCurso.Cartera_Swap) + 1
        ErrorOpCurSwap = Err.Number
     On Error GoTo 0
     'Puede que no exista Operacion en Curso Swap, copiar para Forward, Forward_RF, Opciones no porque es .net
     
        If ErrorOpCurSwap <> 0 Then 'No hay Operacion en Curso, no se agrega nada
           Exit Sub
        End If
        
        If ErrorCarSwap <> 0 Then 'No hay nada, se llenará con la cartera en curso.
            IndiceSwap = 0
        End If
        

        Let EntraREC = 1
        For i = 0 To UBound(CarteraOperacionCurso.Cartera_Swap)
            'Operacion entra solo si esta parametrizada en REC
            If (CarteraOperacionCurso.Cartera_Swap(i).Codigo_descuento = -10 _
               Or CarteraOperacionCurso.Cartera_Swap(i).Codigo_forward = -10 _
               Or CarteraOperacionCurso.Cartera_Swap(i).Moneda = -10) Then
                Let EntraREC = 0
            End If
        Next i
        If EntraREC = 1 Then
        For i = 0 To UBound(CarteraOperacionCurso.Cartera_Swap)
                'Operacion entra solo si esta parametrizada en REC
            ReDim Preserve Cartera.Cartera_Swap(IndiceSwap)
            
            Cartera.Cartera_Swap(IndiceSwap).Amortizacion = CarteraOperacionCurso.Cartera_Swap(i).Amortizacion
            Cartera.Cartera_Swap(IndiceSwap).Base = CarteraOperacionCurso.Cartera_Swap(i).Base
            Cartera.Cartera_Swap(IndiceSwap).Cartera = CarteraOperacionCurso.Cartera_Swap(i).Cartera
            Cartera.Cartera_Swap(IndiceSwap).Codigo = CarteraOperacionCurso.Cartera_Swap(i).Codigo
            Cartera.Cartera_Swap(IndiceSwap).Codigo_descuento = CarteraOperacionCurso.Cartera_Swap(i).Codigo_descuento
            Cartera.Cartera_Swap(IndiceSwap).Codigo_forward = CarteraOperacionCurso.Cartera_Swap(i).Codigo_forward
            Cartera.Cartera_Swap(IndiceSwap).Codigo_tasa = CarteraOperacionCurso.Cartera_Swap(i).Codigo_tasa
            Cartera.Cartera_Swap(IndiceSwap).Convencion = CarteraOperacionCurso.Cartera_Swap(i).Convencion
            Cartera.Cartera_Swap(IndiceSwap).Dias = CarteraOperacionCurso.Cartera_Swap(i).Dias
            Cartera.Cartera_Swap(IndiceSwap).Fecha_fija = CarteraOperacionCurso.Cartera_Swap(i).Fecha_fija
            Cartera.Cartera_Swap(IndiceSwap).Fecha_fin = CarteraOperacionCurso.Cartera_Swap(i).Fecha_fin
            Cartera.Cartera_Swap(IndiceSwap).Fecha_ini = CarteraOperacionCurso.Cartera_Swap(i).Fecha_ini
            Cartera.Cartera_Swap(IndiceSwap).Fecha_liq = CarteraOperacionCurso.Cartera_Swap(i).Fecha_liq
            Cartera.Cartera_Swap(IndiceSwap).Flujo_adicional = CarteraOperacionCurso.Cartera_Swap(i).Flujo_adicional
            Cartera.Cartera_Swap(IndiceSwap).IndexLag = CarteraOperacionCurso.Cartera_Swap(i).IndexLag
            Cartera.Cartera_Swap(IndiceSwap).Modalidad_pago = CarteraOperacionCurso.Cartera_Swap(i).Modalidad_pago
            Cartera.Cartera_Swap(IndiceSwap).Moneda = CarteraOperacionCurso.Cartera_Swap(i).Moneda
            Cartera.Cartera_Swap(IndiceSwap).Numero_flujo = CarteraOperacionCurso.Cartera_Swap(i).Numero_flujo
            Cartera.Cartera_Swap(IndiceSwap).Numero_Operacion = CarteraOperacionCurso.Cartera_Swap(i).Numero_Operacion
            Cartera.Cartera_Swap(IndiceSwap).Plazo_fin = CarteraOperacionCurso.Cartera_Swap(i).Plazo_fin
            Cartera.Cartera_Swap(IndiceSwap).Plazo_ini = CarteraOperacionCurso.Cartera_Swap(i).Plazo_ini
            Cartera.Cartera_Swap(IndiceSwap).PlazoFwd = CarteraOperacionCurso.Cartera_Swap(i).PlazoFwd
            Cartera.Cartera_Swap(IndiceSwap).Rut = CarteraOperacionCurso.Cartera_Swap(i).Rut
            Cartera.Cartera_Swap(IndiceSwap).Saldo = CarteraOperacionCurso.Cartera_Swap(i).Saldo
            Cartera.Cartera_Swap(IndiceSwap).Spread = CarteraOperacionCurso.Cartera_Swap(i).Spread
            Cartera.Cartera_Swap(IndiceSwap).Tasa_flujo = CarteraOperacionCurso.Cartera_Swap(i).Tasa_flujo
            Cartera.Cartera_Swap(IndiceSwap).Tipo_flujo = CarteraOperacionCurso.Cartera_Swap(i).Tipo_flujo
            Cartera.Cartera_Swap(IndiceSwap).Tipo_swap = CarteraOperacionCurso.Cartera_Swap(i).Tipo_swap
            Cartera.Cartera_Swap(IndiceSwap).Plazo = CarteraOperacionCurso.Cartera_Swap(i).Plazo
            Cartera.Cartera_Swap(IndiceSwap).Moneda_Bac = CarteraOperacionCurso.Cartera_Swap(i).Moneda_Bac
           
            Let IndiceSwap = IndiceSwap + 1
          Next i
     End If
     End If
     If Sistema = "Forward" Then
        'MsgBox "Pendiente carga operacion en curso Forward"
        On Error Resume Next
            IndiceFwd = UBound(Cartera.Cartera_Fwd) + 1   'Indice para el nuevo registro
            ErrorCarFwd = Err.Number
        On Error GoTo 0
        'Puede que no exista cartera vigente Swap, copiar para Forward, Forward_RF, Opciones
        On Error Resume Next
            Aux = UBound(CarteraOperacionCurso.Cartera_Fwd) + 1
            ErrorOpCurFwd = Err.Number
        On Error GoTo 0
        
        If ErrorOpCurFwd <> 0 Then 'No hay Operacion en Curso, no se agrega nada
            Exit Sub
        End If
        
        If ErrorCarFwd <> 0 Then 'No hay nada, se llenará con la cartera en curso.
            IndiceFwd = 0
     End If
        Let EntraREC = 1
        For i = 0 To UBound(CarteraOperacionCurso.Cartera_Fwd)
            'Operacion entra solo si esta parametrizada en REC
            If (CarteraOperacionCurso.Cartera_Fwd(i).Moneda(0) = -10 _
                 Or CarteraOperacionCurso.Cartera_Fwd(i).Moneda(1) = -10 _
                 Or CarteraOperacionCurso.Cartera_Fwd(i).Codigo_descuento(0) = -10 _
                 Or CarteraOperacionCurso.Cartera_Fwd(i).Codigo_descuento(1) = -10) Then
                 Let EntraREC = 0
            End If
        Next i
        
        If EntraREC = 1 Then
        For i = 0 To UBound(CarteraOperacionCurso.Cartera_Fwd)
            
            ReDim Preserve Cartera.Cartera_Fwd(IndiceFwd)
            
            Cartera.Cartera_Fwd(IndiceFwd).Rut = CarteraOperacionCurso.Cartera_Fwd(i).Rut
            Cartera.Cartera_Fwd(IndiceFwd).Codigo = CarteraOperacionCurso.Cartera_Fwd(i).Codigo
            Cartera.Cartera_Fwd(IndiceFwd).Sentido_operacion = CarteraOperacionCurso.Cartera_Fwd(i).Sentido_operacion
            Cartera.Cartera_Fwd(IndiceFwd).Numero_Operacion = CarteraOperacionCurso.Cartera_Fwd(i).Numero_Operacion
            Cartera.Cartera_Fwd(IndiceFwd).Tipo_forward = CarteraOperacionCurso.Cartera_Fwd(i).Tipo_forward
            Cartera.Cartera_Fwd(IndiceFwd).Modalidad_pago = CarteraOperacionCurso.Cartera_Fwd(i).Modalidad_pago
            Cartera.Cartera_Fwd(IndiceFwd).Cartera = CarteraOperacionCurso.Cartera_Fwd(i).Cartera
            Cartera.Cartera_Fwd(IndiceFwd).Moneda(0) = CarteraOperacionCurso.Cartera_Fwd(i).Moneda(0)
            Cartera.Cartera_Fwd(IndiceFwd).Moneda(1) = CarteraOperacionCurso.Cartera_Fwd(i).Moneda(1)
            Cartera.Cartera_Fwd(IndiceFwd).Fecha_ini = CarteraOperacionCurso.Cartera_Fwd(i).Fecha_ini
            Cartera.Cartera_Fwd(IndiceFwd).Fecha_fin = CarteraOperacionCurso.Cartera_Fwd(i).Fecha_fin
            Cartera.Cartera_Fwd(IndiceFwd).Fecha_efectiva = CarteraOperacionCurso.Cartera_Fwd(i).Fecha_efectiva
            Cartera.Cartera_Fwd(IndiceFwd).Fecha_fixing = CarteraOperacionCurso.Cartera_Fwd(i).Fecha_fixing
            Cartera.Cartera_Fwd(IndiceFwd).Puntos_fwd = CarteraOperacionCurso.Cartera_Fwd(i).Puntos_fwd
            Cartera.Cartera_Fwd(IndiceFwd).Codigo_descuento(0) = CarteraOperacionCurso.Cartera_Fwd(i).Codigo_descuento(0)
            Cartera.Cartera_Fwd(IndiceFwd).Codigo_descuento(1) = CarteraOperacionCurso.Cartera_Fwd(i).Codigo_descuento(1)
            Cartera.Cartera_Fwd(IndiceFwd).Amortizacion(0) = CarteraOperacionCurso.Cartera_Fwd(i).Amortizacion(0)
            Cartera.Cartera_Fwd(IndiceFwd).Amortizacion(1) = CarteraOperacionCurso.Cartera_Fwd(i).Amortizacion(1)
            Cartera.Cartera_Fwd(IndiceFwd).Valor_Mercado = CarteraOperacionCurso.Cartera_Fwd(i).Valor_Mercado
            Cartera.Cartera_Fwd(IndiceFwd).Moneda_1_BAC = CarteraOperacionCurso.Cartera_Fwd(i).Moneda_1_BAC
            Cartera.Cartera_Fwd(IndiceFwd).Moneda_2_BAC = CarteraOperacionCurso.Cartera_Fwd(i).Moneda_2_BAC
            Cartera.Cartera_Fwd(IndiceFwd).Plazo = CarteraOperacionCurso.Cartera_Fwd(i).Plazo
            Cartera.Cartera_Fwd(IndiceFwd).Duration = CarteraOperacionCurso.Cartera_Fwd(i).Duration
            Let IndiceFwd = IndiceFwd + 1
        Next i
    End If
    End If
    
     If Sistema = "Forward_RF" Then
        'MsgBox "Pendiente carga operacion en curso Forward_RF"
        On Error Resume Next
            IndiceFwd_RF = UBound(Cartera.Cartera_Fwd_RF) + 1   'Indice para el nuevo registro
            ErrorCarFwd_RF = Err.Number
        On Error GoTo 0
        'Puede que no exista cartera vigente Swap, copiar para Forward, Forward_RF, Opciones
        On Error Resume Next
            Aux = UBound(CarteraOperacionCurso.Cartera_Fwd_RF) + 1
            ErrorOpCurFwd_RF = Err.Number
        On Error GoTo 0
        
        If ErrorOpCurFwd_RF <> 0 Then 'No hay Operacion en Curso, no se agrega nada
            Exit Sub
        End If
        
        If ErrorCarFwd_RF <> 0 Then 'No hay nada, se llenará con la cartera en curso.
            IndiceFwd_RF = 0
        End If
        
        Let EntraREC = 1
        For i = 0 To UBound(CarteraOperacionCurso.Cartera_Fwd_RF)
            'Operacion entra solo si esta parametrizada en REC
            If (CarteraOperacionCurso.Cartera_Fwd_RF(i).Cod_Moneda = -10 _
                  Or CarteraOperacionCurso.Cartera_Fwd_RF(i).Cod_Tasa = -10 _
                  Or CarteraOperacionCurso.Cartera_Fwd_RF(i).Cod_Tasa_F = -10) Then
                 Let EntraREC = 0
            End If
        Next i
        
        If EntraREC = 1 Then
        For i = 0 To UBound(CarteraOperacionCurso.Cartera_Fwd_RF)
       
            ReDim Preserve Cartera.Cartera_Fwd_RF(IndiceFwd_RF)
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Producto = CarteraOperacionCurso.Cartera_Fwd_RF(i).Producto
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Numero_Operacion = CarteraOperacionCurso.Cartera_Fwd_RF(i).Numero_Operacion
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Sentido_operacion = CarteraOperacionCurso.Cartera_Fwd_RF(i).Sentido_operacion
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Nemo = CarteraOperacionCurso.Cartera_Fwd_RF(i).Nemo
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Cartera = CarteraOperacionCurso.Cartera_Fwd_RF(i).Cartera
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Nominal = CarteraOperacionCurso.Cartera_Fwd_RF(i).Nominal
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Emisor = CarteraOperacionCurso.Cartera_Fwd_RF(i).Emisor
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Serie = CarteraOperacionCurso.Cartera_Fwd_RF(i).Serie
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Mascara = CarteraOperacionCurso.Cartera_Fwd_RF(i).Mascara
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Fecha_Vecto = CarteraOperacionCurso.Cartera_Fwd_RF(i).Fecha_Vecto
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Fecha_Vecto_Fwd = CarteraOperacionCurso.Cartera_Fwd_RF(i).Fecha_Vecto_Fwd
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Tasa_Fwd = CarteraOperacionCurso.Cartera_Fwd_RF(i).Tasa_Fwd
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Cod_Moneda = CarteraOperacionCurso.Cartera_Fwd_RF(i).Cod_Moneda
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Cod_Tasa = CarteraOperacionCurso.Cartera_Fwd_RF(i).Cod_Tasa
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Cod_Tasa_F = CarteraOperacionCurso.Cartera_Fwd_RF(i).Cod_Tasa_F
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Base = CarteraOperacionCurso.Cartera_Fwd_RF(i).Base
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Valor_Mercado_BAC = CarteraOperacionCurso.Cartera_Fwd_RF(i).Valor_Mercado
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Rut = CarteraOperacionCurso.Cartera_Fwd_RF(i).Rut
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Codigo = CarteraOperacionCurso.Cartera_Fwd_RF(i).Codigo
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).EarlyTermination = CarteraOperacionCurso.Cartera_Fwd_RF(i).EarlyTermination
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Moneda_1_BAC = CarteraOperacionCurso.Cartera_Fwd_RF(i).Moneda_1_BAC
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Moneda_2_BAC = CarteraOperacionCurso.Cartera_Fwd_RF(i).Moneda_2_BAC
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Plazo_Bac = CarteraOperacionCurso.Cartera_Fwd_RF(i).Plazo_Bac
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Plazo = CarteraOperacionCurso.Cartera_Fwd_RF(i).Plazo
            Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Duration = CarteraOperacionCurso.Cartera_Fwd_RF(i).Duration
            'Let IndiceFwd_RF = IndiceFwd_RF + 1
       
        Next i
    
        On Error Resume Next
            limi = UBound(CarteraOperacionCurso.Cartera_Fwd_RF, 1)
            Error = Err.Number
        On Error GoTo 0
        
        If Error = 0 Then
            For i = 0 To limi
    
                ConsultaSQL_Tabla_Desarrollo Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Nemo, Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Flujo
                Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Fecha_Vecto = Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Flujo(UBound(Cartera.Cartera_Fwd_RF(IndiceFwd_RF).Flujo)).Fecha
                'Operacion(i).Fecha_Vecto = Operacion(i).Flujo(UBound(Operacion(i).Flujo)).Fecha
            Next
        End If
         End If
     End If
     
End Sub
Public Function ProcesoCalculoREC(fRut As Long, fCodigo As Long, fCliente As String _
                                                                  , CarteraCurso As Negociacion _
                                                                  , Sistema As String _
                                                                  , Threshold As Double _
                                                                  , Metodologia As Integer _
                                                                  , ByRef MsgError As String _
                                                               , Optional Num As Integer) As Double
    Dim Conexion As ADODB.Connection
    Dim iRut As Long
    Dim iCodigo As Long
    Dim RecMet5 As Double
  
    'Variable para medir el tiempo de calculo
    Dim Tiempo As Date
    Tiempo = Time
   
    'Inicia Variables
    Dim Matriz_DV01 As DV01_Operacion
    Dim Exp_Max As Negociacion
    Dim Valdatos As Procesos
    Dim AddOn As Datos_AddOn
    Dim Valorizacion As Double
    Dim Cartera As Negociacion
    Dim expom As Exposicion_Maxima
    Dim Datos(MaxNumero_Simulaciones) As Datos_Mercado
    Dim MCovar() As Double
    Dim largo_vector As Long
    Dim AddON90d As Double
    Dim ExposicionMaxima As Double
    Dim Total_AddOn As Double
    Dim Valor_Mercado As Long
    Dim ClienteTieneDerivados As Boolean
   Screen.MousePointer = vbHourglass
    Dim Corr As Long
    Dim ValidarRec As Variant
    
    Dim CurvasYield As String               'Flag para usar curvas Yield en Forward
  
    
    'Rescata informacion desde las bases de datos
    Inicia_Conexion
  
    Let CurvasYield = FormatoCompuesto()    'Flag para usar curvas Yield en Forward
    
    
    'Ingresa la fecha de proceso, OK Migracion to BAC
    Datos(0).Fecha = gsBAC_FecConFin
   
    Let Valorizacion = 0
    Let AddON90d = 0
    Let Total_AddOn = 0
    Let ExposicionMaxima = 0
    Let RecMet5 = 0
   
    'Case por Metodologia para dar claridad al código
    
    '*************************************************
    ' Metodologia 2
    '*************************************************
    If Metodologia = 2 Then
    
        'Numero de dias que deben tener datos ---------------------
        Numero_Simulaciones = Rescata_Simulaciones(Cartera, Valdatos, Metodologia _
                                              , Threshold, fRut, fCodigo, fCliente)
        
        'Pesquiza de error en ValDatos del proceso anterior
        If EjecutaBtnREC = True Then
            MsgError = ""
            If Valdatos.ErrorNumero <> 0 Then
                Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
                
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        Else
            If Valdatos.ErrorNumero <> 0 Then
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        End If
        
        'Datos de mercado ----------------------------------------
        Rescata_Datos_Mercado Datos, Numero_Simulaciones, Valdatos
        
        'Pesquiza de error en ValDatos del proceso anterior
        If EjecutaBtnREC = True Then
            MsgError = ""
            If Valdatos.ErrorNumero <> 0 Then
                Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
    
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        Else
            If Valdatos.ErrorNumero <> 0 Then
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        End If
        
        'Ajuste de los Plazos standar de las curvas ---------------
        Crea_Vector_Simplificado Datos
        
        'Importa la cartera ---------------------------------------
        Rescata_Cartera_Trading Datos(0), Cartera, Valdatos, largo_vector, fRut, fCodigo
    
        'Pesquiza de error en ValDatos del proceso anterior
        If EjecutaBtnREC = True Then
            MsgError = ""
            If Valdatos.ErrorNumero <> 0 Then
                Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
                
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        Else
            If Valdatos.ErrorNumero <> 0 Then
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        End If
        
        'Agrega Operacion que usuario está ingresando -------------
        AgregaFlujosCurso Cartera, CarteraCurso, Sistema
        
        'Se verifica si hay o no cartera vigente ------------------
        ClienteTieneDerivados = HayCartera(Cartera)
        
        
        If ClienteTieneDerivados Then
             Valoriza_Cartera_Trading Cartera, Datos(0), Datos(0).Fecha, 0, CurvasYield
             Valorizacion = MTMCarteraTotal(Cartera)
             Total_AddOn = AddOn_Al_Vencimiento(Cartera, AddOn, Datos(0).Fecha, Metodologia)
             Calc_Cons_Resul_MaxExp Datos(0).Fecha, Cartera, expom, fRut, fCodigo
             ExposicionMaxima = Cartera.Exposicion_Maxima
        End If
        
    End If  'Metodologia 2
    
    '*************************************************
    ' Metodologia 3
    '*************************************************
    If Metodologia = 3 Then
        
        
        'Numero de dias que deben tener datos ---------------------
        Numero_Simulaciones = Rescata_Simulaciones(Cartera, Valdatos, Metodologia _
                                              , Threshold, fRut, fCodigo, fCliente)
        
        'Pesquiza de error en ValDatos del proceso anterior
        If EjecutaBtnREC = True Then
            MsgError = ""
            If Valdatos.ErrorNumero <> 0 Then
                Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
        
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        Else
            If Valdatos.ErrorNumero <> 0 Then
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        End If
        
        'Datos de mercado ----------------------------------------
        'Rescata_Datos_Mercado DATOS, Numero_Simulaciones, Valdatos
        '10967 Optimizacion, Matriz Cov se genera al inicio de dia
        'por tando solo se necesita DATOS para valorizar, para lo cual
        'en vez Numero_Simulaciones se pone 2.
        Rescata_Datos_Mercado Datos, 2, Valdatos
        
        'Pesquiza de error en ValDatos del proceso anterior
        If EjecutaBtnREC = True Then
            MsgError = ""
            If Valdatos.ErrorNumero <> 0 Then
                Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
    
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        Else
            If Valdatos.ErrorNumero <> 0 Then
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
             End If
        End If
    
        'Ajuste de los Plazos standar de las curvas ---------------
        Crea_Vector_Simplificado Datos
    
        'Importa la cartera ---------------------------------------
        Rescata_Cartera_Trading Datos(0), Cartera, Valdatos, largo_vector, fRut, fCodigo
    
        'Pesquiza de error en ValDatos del proceso anterior
        If EjecutaBtnREC = True Then
            MsgError = ""
            If Valdatos.ErrorNumero <> 0 Then
                Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
                
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        Else
            If Valdatos.ErrorNumero <> 0 Then
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        End If
        
        'Agrega Operacion que usuario está ingresando ------------
        AgregaFlujosCurso Cartera, CarteraCurso, Sistema
        
        'Se verifica si hay o no cartera vigente -----------------
        ClienteTieneDerivados = HayCartera(Cartera)
        
        
        If ClienteTieneDerivados Then
            
            Valoriza_Cartera_Trading Cartera, Datos(0), Datos(0).Fecha, 0, CurvasYield
            
            'Calcula la covarianza --------------------------------
            'Calcula_Covarianza DATOS, MCovar, Largo_Vector, Valdatos
            '10967 ahora se calcula al inicio de día
            Call Carga_Completa_Matriz_Covarianza_SQL(MCovar, Valdatos, largo_vector)
                                  
            'Pesquiza de error en ValDatos del proceso anterior
            If EjecutaBtnREC = True Then
                MsgError = ""
                If Valdatos.ErrorNumero <> 0 Then
                    Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                    & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
                    
                    MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                    ProcesoCalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            Else
                If Valdatos.ErrorNumero <> 0 Then
                    MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                    ProcesoCalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            End If

            'Calcula la Sensibilidad ------------------------------
            Calcula_DV01_Principal Cartera, Datos(0), Valdatos, CurvasYield
            
            'Pesquiza de error en ValDatos del proceso anterior
            If EjecutaBtnREC = True Then
                MsgError = ""
                If Valdatos.ErrorNumero <> 0 Then
                    Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                    & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
                    
                    MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                    ProcesoCalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            Else
                If Valdatos.ErrorNumero <> 0 Then
                    MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                    ProcesoCalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            End If
                                  
            'Calcula Valor en Riesgo ------------------------------
            ' PROD 21119 - Se agrega parametro Metodologia
            Calcula_VaR Cartera, MCovar, largo_vector, Datos(0).Fecha, Matriz_DV01, fRut, fCodigo, "EnLinea", Metodologia
            
            'Calcula AddOn90d : VaR de cartera del cliente --------
            AddON90d = Var(Matriz_DV01)
            
            'Rescata Valor Razonable de arreglos de valorización --
            Valorizacion = MTMCarteraTotal(Cartera)
            
            'Calcula la Exp. Máxima -------------------------------
            Calc_Cons_Resul_MaxExp Datos(0).Fecha, Cartera, expom, fRut, fCodigo
    
            ExposicionMaxima = Cartera.Exposicion_Maxima
            
         End If 'ClienteTieneDerivados
    End If  'Metodologia 3
    
    '*************************************************
    ' Metodologia 5
    '*************************************************
    If Metodologia = 5 Then
    
        'Numero de dias con datos ---------------------------------
        Numero_Simulaciones = Rescata_Simulaciones(Cartera, Valdatos, Metodologia _
                                              , Threshold, fRut, fCodigo, fCliente)
        
        'Datos de mercado -----------------------------------------
        Rescata_Datos_Mercado Datos, Numero_Simulaciones, Valdatos
        
        'Pezquiza de error en ValDatos del proceso anterior
        If EjecutaBtnREC = True Then
            MsgError = ""
            If Valdatos.ErrorNumero <> 0 Then
                Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
        
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        Else
            If Valdatos.ErrorNumero <> 0 Then
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        End If
        
        'Ajuste de los Plazos standar de las curvas ---------------
        Crea_Vector_Simplificado Datos
    
        'Importa la cartera ---------------------------------------
        Rescata_Cartera_Trading Datos(0), Cartera, Valdatos, largo_vector, fRut, fCodigo
    
        'Pezquiza de error en ValDatos del proceso anterior
        If EjecutaBtnREC = True Then
            MsgError = ""
            If Valdatos.ErrorNumero <> 0 Then
                Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
                
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        Else
            If Valdatos.ErrorNumero <> 0 Then
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        End If
        
        'Agrea Operacion que usuario está ingresando --------------
        AgregaFlujosCurso Cartera, CarteraCurso, Sistema
        
        'Se verifica si hay o no cartera vigente ------------------
        ClienteTieneDerivados = HayCartera(Cartera)
        
        If ClienteTieneDerivados Then
    
            Valoriza_Cartera_Trading Cartera, Datos(0), Datos(0).Fecha
    
            'Esto no es necesario para la metodologia 5
            'pero es para mostrar los MTM en pantalla
            Calc_Cons_Resul_MaxExp Datos(0).Fecha, Cartera, expom, fRut, fCodigo
        
            Call CalculaValorMercado(Cartera)
             
            Call AddOn_Al_Vencimiento(Cartera, AddOn, Datos(0).Fecha, Metodologia)
            
            RecMet5 = Func_CalculoRecMetologia5(Cartera)
            
        End If
        
    End If  'Metodologia 5
    
      '*************************************************
    ' Metodologia 6     PROD 21119 - Consumo de Línea -
    '                               Cambio variación % confiabilidad al 99% y metodología VaR a 3 días
    '*************************************************
    If Metodologia = 6 Then
    
        'Numero de dias que deben tener datos ---------------------
        Numero_Simulaciones = Rescata_Simulaciones(Cartera, Valdatos, Metodologia _
                                              , Threshold, fRut, fCodigo, fCliente)
        
        'Pesquiza de error en ValDatos del proceso anterior
        If EjecutaBtnREC = True Then
            MsgError = ""
            If Valdatos.ErrorNumero <> 0 Then
                Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
        
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        Else
            If Valdatos.ErrorNumero <> 0 Then
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        End If
        
        'Datos de mercado ----------------------------------------
        'Rescata_Datos_Mercado DATOS, Numero_Simulaciones, Valdatos
        '10967 Optimizacion, Matriz Cov se genera al inicio de dia
        'por tando solo se necesita DATOS para valorizar, para lo cual
        'en vez Numero_Simulaciones se pone 2.
        Rescata_Datos_Mercado Datos, 2, Valdatos
        
        'Pesquiza de error en ValDatos del proceso anterior
        If EjecutaBtnREC = True Then
            MsgError = ""
            If Valdatos.ErrorNumero <> 0 Then
                Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
    
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        Else
            If Valdatos.ErrorNumero <> 0 Then
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
             End If
        End If
    
        'Ajuste de los Plazos standar de las curvas ---------------
        Crea_Vector_Simplificado Datos
    
        'Importa la cartera ---------------------------------------
        Rescata_Cartera_Trading Datos(0), Cartera, Valdatos, largo_vector, fRut, fCodigo
    
        'Pesquiza de error en ValDatos del proceso anterior
        If EjecutaBtnREC = True Then
            MsgError = ""
            If Valdatos.ErrorNumero <> 0 Then
                Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
                
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        Else
            If Valdatos.ErrorNumero <> 0 Then
                MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
        End If
        
        'Agrega Operacion que usuario está ingresando ------------
        AgregaFlujosCurso Cartera, CarteraCurso, Sistema
        
        'Se verifica si hay o no cartera vigente -----------------
        ClienteTieneDerivados = HayCartera(Cartera)
        
        
        If ClienteTieneDerivados Then
            
            Valoriza_Cartera_Trading Cartera, Datos(0), Datos(0).Fecha, 0, CurvasYield
            
            'Calcula la covarianza --------------------------------
            'Calcula_Covarianza DATOS, MCovar, Largo_Vector, Valdatos
            '10967 ahora se calcula al inicio de día
            Call Carga_Completa_Matriz_Covarianza_SQL(MCovar, Valdatos, largo_vector)
                                  
            'Pesquiza de error en ValDatos del proceso anterior
            If EjecutaBtnREC = True Then
                MsgError = ""
                If Valdatos.ErrorNumero <> 0 Then
                    Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                    & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
                    
                    MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                    ProcesoCalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            Else
                If Valdatos.ErrorNumero <> 0 Then
                    MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                    ProcesoCalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            End If

            'Calcula la Sensibilidad ------------------------------
            Calcula_DV01_Principal Cartera, Datos(0), Valdatos, CurvasYield
            
            'Pesquiza de error en ValDatos del proceso anterior
            If EjecutaBtnREC = True Then
                MsgError = ""
                If Valdatos.ErrorNumero <> 0 Then
                    Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                    & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
                    
                    MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                    ProcesoCalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            Else
                If Valdatos.ErrorNumero <> 0 Then
                    MsgError = Valdatos.ErrorSP & " Error " & Valdatos.ErrorDescripcion
                    ProcesoCalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            End If
                                  
            'Calcula Valor en Riesgo ------------------------------
            'PROD 21119 - Se agrega parámetro Metodologia
            Calcula_VaR Cartera, MCovar, largo_vector, Datos(0).Fecha, Matriz_DV01, fRut, fCodigo, "EnLinea", Metodologia
            
            'Calcula AddOn90d : VaR de cartera del cliente --------
            AddON90d = Var(Matriz_DV01)
            
            'Rescata Valor Razonable de arreglos de valorización --
            Valorizacion = MTMCarteraTotal(Cartera)
            
            'Calcula la Exp. Máxima -------------------------------
            Calc_Cons_Resul_MaxExp Datos(0).Fecha, Cartera, expom, fRut, fCodigo
    
            ExposicionMaxima = Cartera.Exposicion_Maxima
            
         End If 'ClienteTieneDerivados
    End If  'Metodologia 6

    
    'PROD-10967
    Calcula_REC Datos(0).Fecha, Cartera, Cartera.CalcRec _
                                       , Valorizacion _
                                       , AddON90d _
                                       , Total_AddOn _
                                       , ExposicionMaxima _
                                       , Threshold, Metodologia _
                                       , RecMet5, Valdatos, fRut, fCodigo, fCliente
          
    ProcesoCalculoREC = Cartera.CalcRec(0).Consumo_Linea
    
    
    'Graba Proceso Rec en tabla TBL_RIEFIN_General_REC
    If EjecutaBtnREC = False Then
        Calcula_REC_SQL Datos(0).Fecha, Cartera, Cartera.CalcRec _
                                       , Valorizacion _
                                       , AddON90d _
                                       , Total_AddOn _
                                       , ExposicionMaxima _
                                       , Threshold, Metodologia _
                                       , Valdatos _
                                       , fRut, fCodigo, fCliente
     End If
    
     
     If EjecutaBtnREC = True Then
            MsgError = ""
            If Valdatos.ErrorNumero <> 0 Then
                Call MsgBox("Se ha originado un error. " _
                & Valdatos.ErrorDescripcion, vbInformation, App.Title)
                
                MsgError = "Error en." & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
      Else
            If Valdatos.ErrorNumero <> 0 Then
                MsgError = "Error en:" & Valdatos.ErrorDescripcion
                ProcesoCalculoREC = 0
                ValidarRec = False
                Exit Function
            End If
      End If
       
    'Cargar datos en grilla
    If EjecutaBtnREC = True Then
        If Num = 1 Then
            Carga_Grilla_AddOn90d Matriz_DV01, AddON90d, fRut, fCodigo, fCliente
            EjecutaBtnREC = False
        End If
        
        If Num = 3 Then
            Carga_Grilla_AddOn Cartera, Total_AddOn, Datos(0).Fecha
            EjecutaBtnREC = False
        End If
               
        If Num = 4 Then
            Carga_Grilla_ExpMaxima Cartera
            EjecutaBtnREC = False
        End If
        
        If Num = 6 Then
            Carga_Grilla_Rec Cartera
            EjecutaBtnREC = False
        End If
        
        If Num = 7 Then
            Carga_Detalle_ExpMax fCliente, expom, Cartera
            EjecutaBtnREC = False
        End If
           
        If Num = 8 Then
                   
            Carga_Matriz_Covarianza MCovar, Datos(0)
            EjecutaBtnREC = False
        End If
           
    End If
 Screen.MousePointer = vbDefault

End Function

Private Function Identifica_Variable_Covarianza(Datos As Datos_Mercado, _
                                     Corr_Variable As Long) As String
    
    Dim k As Long
    Dim i As Long
    Dim j As Long
    Dim Plazo As Long
    Dim Matriz() As Double
    Dim ErrorCalCov As Double
    Dim Contador As Long
    Dim Id As String
    Dim SAOCurvasPropias As String
    Let SAOCurvasPropias = SAOCurvasPropiasSN()   '-- PRD20426
    
    
    Let Contador = 0
    For i = 0 To UBound(Datos.Tasas_Swap)
        For j = 0 To UBound(Datos.Tasas_Swap(i).Par)
            If (Corr_Variable = Contador) Then
                Let Id = "Curva SWAP Nº " + Format(i, "###0") + " Tenor " + Format(j, "###0")
            End If
            Contador = Contador + 1
        Next
    Next
        
    For i = 0 To UBound(Datos.Tasas_Fwd)
        For j = 0 To UBound(Datos.Tasas_Fwd(i).Par)
            If (Corr_Variable = Contador) Then
                Let Id = "Curva Forward Nº " + Format(i, "###0") + " Tenor " + Format(j, "###0")
            End If
            Contador = Contador + 1
        Next
    Next
        
    For i = 0 To UBound(Datos.Tasas_RF)
        For j = 0 To UBound(Datos.Tasas_RF(i).Par)
            If (Corr_Variable = Contador) Then
                Let Id = "Curva Renta Fija Nº " + Format(i, "###0") + " Tenor " + Format(j, "###0")
            End If
            Contador = Contador + 1
        Next
    Next
        
    For i = 2 To UBound(Datos.Paridad)
       If (Corr_Variable = Contador) Then
           Let Id = "Paridad Nº " + Format(i, "###0")
       End If
       Contador = Contador + 1
    Next
    
    If SAOCurvasPropias = "S" Then             '-- PRD20426
        For i = 0 To UBound(Datos.Tasas_Opcion)
            For j = 0 To UBound(Datos.Tasas_Opcion(i).Par)
                If (Corr_Variable = Contador) Then
                    Let Id = "Curva Opcion Nº " + Format(i, "###0") + " Tenor " + Format(j, "###0")
                End If
                Contador = Contador + 1
            Next
        Next
    End If                                     '-- PRD20426
    Identifica_Variable_Covarianza = Id
End Function


Public Sub Proc_Recalculo_Lineas_DRV(Optional iRut As Long = 0, Optional iCodigo As Long = 0)
    Dim CalcRec As Double
    Dim Det_MsgError As String
    Dim Contador As Long
    Dim CliMet_2_5 As Long
    Dim CliMet_3  As Long
    Dim VerificaSim As String
    Dim Parametros As Boolean
    Dim iCadena As String
    Dim Titulo As String
    Dim CLIENTE As Datos_Cliente_DRV
    
    Call Proc_Rescata_Clientes_DRV(CLIENTE, iRut, iCodigo)
    
    Dim TotClieDRV As Double
    Dim ErrorTotClieDRV As Long
    Dim inicio As Variant
    Dim fin As Variant
    
    On Error Resume Next
        TotClieDRV = UBound(CLIENTE.Clie_DRV)
        ErrorTotClieDRV = Err.Number
    On Error GoTo 0
    If Not ErrorTotClieDRV = 0 Then
        TotClieDRV = -1
    End If
    
    If TotClieDRV = -1 Then
        Call MsgBox("No hay Clientes con Metodologías Netting. ", vbInformation, App.Title)
        Exit Sub
    End If
    
    Let CliMet_2_5 = 0
    Let CliMet_3 = 0
    For Contador = 0 To TotClieDRV
    
        If CLIENTE.Clie_DRV(Contador).Metodologia = 2 Or _
            CLIENTE.Clie_DRV(Contador).Metodologia = 5 Then
            
            CliMet_2_5 = CliMet_2_5 + 1
            
        End If
        
        If CLIENTE.Clie_DRV(Contador).Metodologia = 3 Then
            CliMet_3 = CliMet_3 + 1
        End If
           
    Next Contador
    
    Let Parametros = False
    Let iCadena = ""
    Let Titulo = ""
    If CliMet_3 >= 1 Then
        Let VerificaSim = "PAR_SIMULACIONES"
        Call Proc_Verifica_Parametros(VerificaSim, Parametros, iCadena)
        If Parametros = True Then
            Call MsgBox(iCadena, vbCritical, "Faltan los siguentes parametros")
            Let Titulo = "Falta Agregar los siguientes parametros: "
            Call BacCalculoRec.Proc_EnviarMail(iCadena, Titulo)
            'PROD-10967
            'Exit Sub 'debe continuar porque se cargo lo que estaba completo.
            'Con esto se cumple la presisa de avisar lo que falta
            'ignorar lo que falta para que no se caiga el análisis de sencibilidad
        End If
    Else
        Let VerificaSim = "PAR_DIA"
        Call Proc_Verifica_Parametros(VerificaSim, Parametros, iCadena)
        If Parametros = True Then
            Call MsgBox(iCadena, vbCritical, "Faltan los siguentes parametros")
            Let Titulo = "Falta Agregar los siguientes parametros: "
            Call BacCalculoRec.Proc_EnviarMail(iCadena, Titulo)
            Exit Sub
        End If
    End If
    
    Let Det_MsgError = ""
    Let inicio = Now  'PROD-10967
    Call BacCalculoRec.ProcesoRecalculoREC(CLIENTE, Det_MsgError, "General")
    Let fin = Now     'PROD-10967
    MsgBox ("Recalculo Netting demoró " + Format(Minute(fin) * 60 + Second(fin) - Minute(inicio) * 60 - Second(inicio), "######.##") + " Seg.") 'PROD-10967
    
    Let Titulo = ""
    If Det_MsgError <> "" Then
        Let Titulo = "Se generaron los siguientes Errores en Calculo REC.: "
        Call BacCalculoRec.Proc_EnviarMail(Det_MsgError, Titulo)
    End If
    Screen.MousePointer = vbDefault
End Sub

Public Sub Proc_Recalculo_LineasCF_DRV(Optional iRut As Long = 0, Optional iCodigo As Long = 0)
    Dim CalcRec As Double
    Dim Det_MsgError As String
    Dim Contador As Long
    Dim CliMet_2_5 As Long
    Dim CliMet_3  As Long
    Dim VerificaSim As String
    Dim Parametros As Boolean
    Dim iCadena As String
    Dim Titulo As String
    Dim CLIENTE As Datos_Cliente_DRV
    
    Call Proc_Rescata_Clientes_DRV(CLIENTE, iRut, iCodigo)
    
    Dim TotClieDRV As Double
    Dim ErrorTotClieDRV As Long

    
    On Error Resume Next
        TotClieDRV = UBound(CLIENTE.Clie_DRV)
        ErrorTotClieDRV = Err.Number
    On Error GoTo 0
    If Not ErrorTotClieDRV = 0 Then
        TotClieDRV = -1
    End If

    If TotClieDRV = -1 Then
        Call MsgBox("No hay Clientes con Metodologías Netting. ", vbInformation, App.Title)
        Exit Sub
    End If
    
    Let Det_MsgError = ""
    
    Call BacCalculoRec.ProcesoRecalculoREC(CLIENTE, Det_MsgError, "APedido")
    
    Let Titulo = ""
    If Det_MsgError <> "" Then
        Let Titulo = "Se generaron los siguientes Errores en Calculo REC.: "
        Call BacCalculoRec.Proc_EnviarMail(Det_MsgError, Titulo)
    End If
    Screen.MousePointer = vbDefault
End Sub
Public Function Func_BaseForward(BaseFW As Integer)
    Dim FormaBaseFW As Long
    Dim Datos()
    Envia = Array()
    AddParam Envia, BaseFW
    If Not Bac_Sql_Execute("baclineas..SP_RIEFIN_DIAS_TASA_FORWARD", Envia) Then
      Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        
        FormaBaseFW = Datos(1)
        
    Loop
        
    Func_BaseForward = FormaBaseFW
End Function
Public Function Func_BaseSwap(TipoBase As Integer)
    Dim FormaBase As Long
    Dim Datos()
    Envia = Array()
    AddParam Envia, TipoBase
    If Not Bac_Sql_Execute("baclineas..SP_RIEFIN_BASE_BASE_SWAP", Envia) Then
      Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        
        FormaBase = IIf(Datos(1) = "A", 1, Datos(1))
        
    Loop
    
    Func_BaseSwap = FormaBase
End Function
Public Function Func_CodigoDescuento(iMonedaBac As Integer _
                                    , iCodigoTasa As Long _
                                    , iTipoSwap As Integer _
                                    , iOpcion As Integer)
    Dim CodDescuento As Long
    Dim CodForward As Long
    Dim Datos()
    
    Envia = Array()
    AddParam Envia, "pcs"
    AddParam Envia, iMonedaBac
    AddParam Envia, iCodigoTasa
    AddParam Envia, iTipoSwap
    If Not Bac_Sql_Execute("baclineas..SP_RIEFIN_CURVAS_DSC_FWD", Envia) Then
      Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        
        CodDescuento = Datos(1)
        CodForward = Datos(2)
    Loop
    
    If iOpcion = 1 Then
        
        If CodDescuento = -10 Then
            'MsgBox "Curva Descuento no está parametrizada para LCR.", vbInformation
            ParamMoneda_LCR = True
            Func_CodigoDescuento = CodDescuento
            Exit Function
        Else
            Func_CodigoDescuento = CodDescuento
        End If
        
    ElseIf iOpcion = 2 Then
        
        If CodForward = -10 Then
            'MsgBox "Curva Forward no está parametrizada para LCR.", vbInformation
            ParamMoneda_LCR = True
            Func_CodigoDescuento = CodForward
            Exit Function
        Else
            Func_CodigoDescuento = CodForward
        End If
            
    End If
        
End Function
Public Function Func_Riesgo_Financiero(Moneda As Integer)
     Dim RiesgoMoneda As String
     Dim Datos()

     Envia = Array()
     AddParam Envia, Moneda
     If Not Bac_Sql_Execute("baclineas..SP_RIEFIN_MONEDA_RIEFIN", Envia) Then
       Exit Function
     End If
   
     Do While Bac_SQL_Fetch(Datos())
         
         RiesgoMoneda = Datos(1)
         
     Loop
     'RiesgoMoneda = -10
     If RiesgoMoneda = -10 Then
     '    MsgBox "Moneda no está parametrizada para LCR. no será incluida", vbInformation
         ParamMoneda_LCR = True
         Func_Riesgo_Financiero = RiesgoMoneda
         Exit Function
     Else
            Func_Riesgo_Financiero = RiesgoMoneda
     End If
End Function
Public Function Func_TipoConvencio(TipoConv As Integer)
    Dim FormaCalcDias As String
    Dim Datos()
    
    Envia = Array()
    AddParam Envia, TipoConv
    If Not Bac_Sql_Execute("baclineas..SP_RIEFIN_BASE_DIAS_SWAP", Envia) Then
      Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        
        FormaCalcDias = Datos(1)
        
    Loop
    
    Func_TipoConvencio = FormaCalcDias
      
End Function
Public Function Func_CurvasForward(iMonedaBac1 As Integer _
                                    , iMonedaBac2 As Integer _
                                    , iOpcion As Integer)  '1: Mda1, 2:Mda2 - Moneda para la que se quiere curva
    Dim CodM1 As Long
    Dim CodM2 As Long
    Dim Datos()
    
    Envia = Array()
    AddParam Envia, "BFW"
    AddParam Envia, iMonedaBac1
    AddParam Envia, iMonedaBac2
    If Not Bac_Sql_Execute("baclineas..SP_RIEFIN_CURVAS_FORWARD", Envia) Then
      Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        
        CodM1 = Datos(1)
        CodM2 = Datos(2)
    Loop
    
    If iOpcion = 1 Then
        
        If CodM1 = -10 Then
            'PROD-10967
            'MsgBox "Curva M1 no está parametrizada para LCR.", vbInformation
            ParamMoneda_LCR = True
            Exit Function
        Else
            Func_CurvasForward = CodM1
        End If
        
    ElseIf iOpcion = 2 Then
        
        If CodM2 = -10 Then
            'PROD-10967
            'MsgBox "Curva M2 no está parametrizada para LCR.", vbInformation
            ParamMoneda_LCR = True
            Exit Function
        Else
            Func_CurvasForward = CodM2
        End If
            
    End If
        
End Function
Public Function Func_CurvasForward_RF(iProducto As Integer _
                                    , iMonedaBac1 As Integer _
                                    , iMonedaBac2 As Integer _
                                    , iSerie As String _
                                    , iOpcion As Integer)  '1: Mda1, 2:Mda2 - Moneda para la que se quiere curva
    Dim CodM1 As Long
    Dim CodM2 As Long
    Dim Datos()
    
    Envia = Array()
    AddParam Envia, "BFW"
    AddParam Envia, iProducto
    AddParam Envia, iMonedaBac1
    AddParam Envia, iMonedaBac2
    AddParam Envia, iSerie
    If Not Bac_Sql_Execute("baclineas..SP_RIEFIN_CURVAS_FORWARD_RF", Envia) Then
      Exit Function
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        
        CodM1 = Datos(1)
        CodM2 = Datos(2)
    Loop
    
    If iOpcion = 1 Then
        
        If CodM1 = -10 Then
            'PROD-10967
            'MsgBox "Curva M1 no está parametrizada para LCR.", vbInformation
            ParamMoneda_LCR = True
            Exit Function
        Else
            Func_CurvasForward_RF = CodM1
        End If
        
    ElseIf iOpcion = 2 Then
        
        If CodM2 = -10 Then
            'PROD-10967
            'MsgBox "Curva M2 no está parametrizada para LCR.", vbInformation
            ParamMoneda_LCR = True
            Exit Function
        Else
            Func_CurvasForward_RF = CodM2
        End If
            
    End If
        
End Function
Public Function ProcesoRecalculoREC(CLIENTE As Datos_Cliente_DRV _
                                   , ByRef MsgError As String, TipoCalculo As String) As Double
                                                                       
    Dim Conexion As ADODB.Connection
    Dim iRut As Long
    Dim iCodigo As Long
    Dim RecMet5 As Double
    
    'Variable para medir el tiempo de calculo
    Dim Tiempo As Date
    Tiempo = Time
    
    'Inicia Variables
    Dim Matriz_DV01 As DV01_Operacion
    Dim Exp_Max As Negociacion
    Dim Valdatos As Procesos
    Dim AddOn As Datos_AddOn
    Dim Valorizacion As Double
    Dim Cartera As Negociacion
    Dim expom As Exposicion_Maxima
    Dim Datos(MaxNumero_Simulaciones) As Datos_Mercado
    Dim MCovar() As Double
    Dim largo_vector As Long
    Dim AddON90d As Double
    Dim ExposicionMaxima As Double
    Dim Total_AddOn As Double
    Dim Valor_Mercado As Long
    Dim ClienteTieneDerivados As Boolean
    Dim ErrorGeneral As Long
    
    Dim Threshold As Double
    Dim Metodologia As Integer
    Dim fCodigo As Long
    Dim fRut As Long
    Dim fCliente As String
    Dim mensaje As String
    Dim ConsideraCliente As Boolean
    Dim ValidarRec As Boolean
    
    Let fRut = 0
    Let fCodigo = 0
    Let fCliente = ""
    Let Metodologia = 0
    Let Threshold = 0
    Screen.MousePointer = vbHourglass
    
    Dim CurvasYield As String               'Flag para usar curvas Yield en Forward
   
    
    'Rescata informacion desde las bases de datos
    Inicia_Conexion
   
    Let CurvasYield = FormatoCompuesto()    'Flag para usar curvas Yield en Forward


    'Ingresa la fecha de proceso, OK Migracion to BAC
    Datos(0).Fecha = gsBAC_FecConFin
    Let Valorizacion = 0
    Let AddON90d = 0
    Let Total_AddOn = 0
    Let ExposicionMaxima = 0
    Let RecMet5 = 0
      
    'Case por Metodologia para dar claridad al código
    
    'Carga en memoria clientes DRV.
    'Proc_Rescata_Clientes_DRV CLIENTE
    
    Dim TotClieDRV As Double
    Dim ErrorTotClieDRV As Long
    Dim Contador As Long
    
    On Error Resume Next
        TotClieDRV = UBound(CLIENTE.Clie_DRV)
        ErrorTotClieDRV = Err.Number
    On Error GoTo 0
    If Not ErrorTotClieDRV = 0 Then
        TotClieDRV = -1
    End If
    
    'Se pone en duro la metodologia 3 para que busque todos los datos
    
    If TipoCalculo = "General" Then
          Numero_Simulaciones = Rescata_Simulaciones(Cartera, Valdatos, 3 _
                                                  , Threshold, fRut, fCodigo, fCliente)
    Else
          Numero_Simulaciones = 2
    End If

    Rescata_Datos_Mercado Datos, Numero_Simulaciones, Valdatos
    
    If Valdatos.ErrorcargaDatos = True Then
        MsgError = "Error: " & Valdatos.ErrorNumero & " - " & Valdatos.ErrorDescripcion
        Exit Function
    End If
    
    Crea_Vector_Simplificado Datos
    
    
    If TipoCalculo = "General" Then
        Calcula_Covarianza Datos, MCovar, largo_vector, Valdatos
       Call Graba_Matriz_Covarianza_SQL(MCovar, Datos, Datos(0).Fecha, Valdatos)     '-- Demora 3 minutos !!!
    Else
        Call Carga_Completa_Matriz_Covarianza_SQL(MCovar, Valdatos, largo_vector)  'Un segundo !!! se ejecutó aca para verificar carga despues dejar con if imposible
    End If
    
    For Contador = 0 To TotClieDRV
       
        'Let Largo_Vector = 0
        Erase Matriz_DV01.Matriz
        Erase Matriz_DV01.Num_Operacion
        Erase Matriz_DV01.Producto
        Erase Matriz_DV01.Rut
        Erase Matriz_DV01.Plazo
        Erase Matriz_DV01.Var
        Erase Cartera.CalcRec
        
        Erase Exp_Max.CalcRec
        Erase Exp_Max.Cartera_Fwd
        Erase Exp_Max.Cartera_Fwd_RF
        Erase Exp_Max.Cartera_Opcion
        Erase Exp_Max.Cartera_Swap

        Erase AddOn.AddOn_Operaciones
        Erase expom.Exp_Max

       ' Erase MCovar

        Erase Cartera.Total_Exp_maxima
        Erase Cartera.Fecha_Exp_Max
        Erase Cartera.Val_Mercado   'PROD-10967
        
        Let Valorizacion = 0
        Let AddON90d = 0
        Let Total_AddOn = 0
        Let ExposicionMaxima = 0
        Let Total_AddOn = 0
        Let RecMet5 = 0
        Let ProcesoRecalculoREC = 0

        
        Let fRut = CLIENTE.Clie_DRV(Contador).Rut
        Let fCodigo = CLIENTE.Clie_DRV(Contador).Codigo
        Let fCliente = CLIENTE.Clie_DRV(Contador).Nombre
        Let Metodologia = CLIENTE.Clie_DRV(Contador).Metodologia
        Let Threshold = CLIENTE.Clie_DRV(Contador).Threshold
        
        Let ConsideraCliente = True
        
        '*************************************************
        ' Metodologia 2
        '*************************************************
       
        
        If Metodologia = 2 Then
        
            Numero_Simulaciones = Rescata_Simulaciones(Cartera, Valdatos, Metodologia _
                                                  , Threshold, fRut, fCodigo, fCliente)
            
            'Datos de mercado
            'Rescata_Datos_Mercado DATOS, Numero_Simulaciones, Valdatos
            
            'Importa la cartera
            Rescata_Cartera_Trading Datos(0), Cartera, Valdatos, largo_vector, fRut, fCodigo
            
            
            If EjecutaBtnREC = True Then
                MsgError = ""
                If Valdatos.ErrorNumero <> 0 Then
                    Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                    & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
                    
                    MsgError = Valdatos.ErrorSP & "Error en SP:" & Valdatos.ErrorDescripcion
                    ProcesoRecalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            Else
                If Valdatos.ErrorNumero <> 0 Then
                    MsgError = Valdatos.ErrorSP & "Error en SP:" & Valdatos.ErrorDescripcion
                    ProcesoRecalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            End If
                        
             'Se verifica si hay o no cartera vigente
            ClienteTieneDerivados = HayCartera(Cartera)
    
           
            If ClienteTieneDerivados Then
             Valoriza_Cartera_Trading Cartera, Datos(0), Datos(0).Fecha, 0, CurvasYield
                Valorizacion = MTMCarteraTotal(Cartera)
                Total_AddOn = AddOn_Al_Vencimiento(Cartera, AddOn, Datos(0).Fecha, Metodologia)
                Calc_Cons_Resul_MaxExp Datos(0).Fecha, Cartera, expom, fRut, fCodigo
                ExposicionMaxima = Cartera.Exposicion_Maxima
            End If
        
        End If  'Metodologia 2
   
        '*************************************************
        ' Metodologia 3
        '*************************************************
        If Metodologia = 3 Then
                         
            Numero_Simulaciones = Rescata_Simulaciones(Cartera, Valdatos, Metodologia _
                                                  , Threshold, fRut, fCodigo, fCliente)
            
            
            'Datos de mercado
            'Rescata_Datos_Mercado DATOS, Numero_Simulaciones, Valdatos
            
            'Importa la cartera y la valoriza al dia mas reciente
            Rescata_Cartera_Trading Datos(0), Cartera, Valdatos, largo_vector, fRut, fCodigo
           
            
            If EjecutaBtnREC = True Then
                MsgError = ""
                If Valdatos.ErrorNumero <> 0 Then
                    Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                    & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
        
                    MsgError = Valdatos.ErrorSP & "Error en SP:" & Valdatos.ErrorDescripcion
                    ProcesoRecalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            Else
                If Valdatos.ErrorNumero <> 0 Then
                    MsgError = Valdatos.ErrorSP & "Error en SP:" & Valdatos.ErrorDescripcion
                    ProcesoRecalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            End If
        
               
            'Se verifica si hay o no cartera vigente
            ClienteTieneDerivados = HayCartera(Cartera)
    
    
            If ClienteTieneDerivados Then
            
            Valoriza_Cartera_Trading Cartera, Datos(0), Datos(0).Fecha, 0, CurvasYield
            
                'Calcula la covarianza
                 'Crea_Vector_Simplificado DATOS
                 'Calcula_Covarianza DATOS, MCovar, Largo_Vector, Valdatos
            
                If EjecutaBtnREC = True Then
                    MsgError = ""
                    If Valdatos.ErrorNumero <> 0 Then
                        Call MsgBox("Se ha originado un error. " _
                        & Valdatos.ErrorDescripcion, vbInformation, App.Title)
                        
                        MsgError = "Error en." & Valdatos.ErrorDescripcion
                        ProcesoRecalculoREC = 0
                        ValidarRec = False
                        Exit Function
                    End If
                Else
                    If Valdatos.ErrorNumero <> 0 Then
                        MsgError = "Error en:" & Valdatos.ErrorDescripcion
                        ProcesoRecalculoREC = 0
                        ValidarRec = False
                        Exit Function
                    End If
                End If
                

            
                Calcula_DV01_Principal Cartera, Datos(0), Valdatos, CurvasYield
                
                ' PROD 21119 - Se agrega  parámetro Metodologia
                Calcula_VaR Cartera, MCovar, largo_vector, Datos(0).Fecha, Matriz_DV01, fRut, fCodigo, TipoCalculo, Metodologia
                AddON90d = Var(Matriz_DV01)
        
                Valorizacion = MTMCarteraTotal(Cartera) 'terminado
                       
                Calc_Cons_Resul_MaxExp Datos(0).Fecha, Cartera, expom, fRut, fCodigo
                
                ExposicionMaxima = Cartera.Exposicion_Maxima
    
            End If 'ClienteTieneDerivados
        End If  'Metodologia 3
               
        '*************************************************
        ' Metodologia 5
        '*************************************************
        If Metodologia = 5 Then
        
            Numero_Simulaciones = Rescata_Simulaciones(Cartera, Valdatos, Metodologia _
                                                  , Threshold, fRut, fCodigo, fCliente)
            'Datos de mercado
            'Rescata_Datos_Mercado DATOS, Numero_Simulaciones, Valdatos
            
            'Importa la cartera y la valoriza al dia mas reciente
            Rescata_Cartera_Trading Datos(0), Cartera, Valdatos, largo_vector, fRut, fCodigo
        
            
            'Se verifica si hay o no cartera vigente
            ClienteTieneDerivados = HayCartera(Cartera)
       
            If EjecutaBtnREC = True Then
                MsgError = ""
                If Valdatos.ErrorNumero <> 0 Then
                    Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                    & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
                    
                    MsgError = Valdatos.ErrorSP & "Error en SP:" & Valdatos.ErrorDescripcion
                    ProcesoRecalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            Else
                If Valdatos.ErrorNumero <> 0 Then
                    MsgError = Valdatos.ErrorSP & "Error en SP:" & Valdatos.ErrorDescripcion
                    ProcesoRecalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            End If
            
            If ClienteTieneDerivados Then
       
                Valoriza_Cartera_Trading Cartera, Datos(0), Datos(0).Fecha
        
                'Esto no es necesario para la metodologia 5
                'pero es para mostrar los MTM en pantalla
                 Calc_Cons_Resul_MaxExp Datos(0).Fecha, Cartera, expom, fRut, fCodigo
                
                 Call CalculaValorMercado(Cartera)
                     
                 Call AddOn_Al_Vencimiento(Cartera, AddOn, Datos(0).Fecha, Metodologia)
                    
                 RecMet5 = Func_CalculoRecMetologia5(Cartera)
    
            End If
    
        End If  'Metodologia 5
        
        
        
        '*************************************************
        ' Metodologia 6    'PROD 21119 - Consumo de Línea - cambio variación % confiabilidad al 99% y metodología VaR a 3 días
        '*************************************************
        If Metodologia = 6 Then
                         
            Numero_Simulaciones = Rescata_Simulaciones(Cartera, Valdatos, Metodologia _
                                                  , Threshold, fRut, fCodigo, fCliente)
            
            
            'Datos de mercado
            'Rescata_Datos_Mercado DATOS, Numero_Simulaciones, Valdatos
            
            'Importa la cartera y la valoriza al dia mas reciente
            Rescata_Cartera_Trading Datos(0), Cartera, Valdatos, largo_vector, fRut, fCodigo
           
            
            If EjecutaBtnREC = True Then
                MsgError = ""
                If Valdatos.ErrorNumero <> 0 Then
                    Call MsgBox("Se ha originado un error al tratar de leer Datos ." _
                    & Valdatos.ErrorSP & Valdatos.ErrorDescripcion, vbInformation, App.Title)
        
                    MsgError = Valdatos.ErrorSP & "Error en SP:" & Valdatos.ErrorDescripcion
                    ProcesoRecalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            Else
                If Valdatos.ErrorNumero <> 0 Then
                    MsgError = Valdatos.ErrorSP & "Error en SP:" & Valdatos.ErrorDescripcion
                    ProcesoRecalculoREC = 0
                    ValidarRec = False
                    Exit Function
                End If
            End If
        
               
            'Se verifica si hay o no cartera vigente
            ClienteTieneDerivados = HayCartera(Cartera)
    
    
            If ClienteTieneDerivados Then
            
            Valoriza_Cartera_Trading Cartera, Datos(0), Datos(0).Fecha, 0, CurvasYield
            
                'Calcula la covarianza
                 'Crea_Vector_Simplificado DATOS
                 'Calcula_Covarianza DATOS, MCovar, Largo_Vector, Valdatos
            
                If EjecutaBtnREC = True Then
                    MsgError = ""
                    If Valdatos.ErrorNumero <> 0 Then
                        Call MsgBox("Se ha originado un error. " _
                        & Valdatos.ErrorDescripcion, vbInformation, App.Title)
                        
                        MsgError = "Error en." & Valdatos.ErrorDescripcion
                        ProcesoRecalculoREC = 0
                        ValidarRec = False
                        Exit Function
                    End If
                Else
                    If Valdatos.ErrorNumero <> 0 Then
                        MsgError = "Error en:" & Valdatos.ErrorDescripcion
                        ProcesoRecalculoREC = 0
                        ValidarRec = False
                        Exit Function
                    End If
                End If
                

            
                Calcula_DV01_Principal Cartera, Datos(0), Valdatos, CurvasYield
                
                'PROD 21119 - Se agrega parámetro metodologia
                Calcula_VaR Cartera, MCovar, largo_vector, Datos(0).Fecha, Matriz_DV01, fRut, fCodigo, TipoCalculo, Metodologia
                AddON90d = Var(Matriz_DV01)
        
                Valorizacion = MTMCarteraTotal(Cartera) 'terminado
                       
                Calc_Cons_Resul_MaxExp Datos(0).Fecha, Cartera, expom, fRut, fCodigo
                
                ExposicionMaxima = Cartera.Exposicion_Maxima
    
            End If 'ClienteTieneDerivados
        End If  'Metodologia 6

        
        
        
        
        
        
        'PROD-10967
        Calcula_REC Datos(0).Fecha, Cartera, Cartera.CalcRec _
                                           , Valorizacion _
                                           , AddON90d _
                                           , Total_AddOn _
                                           , ExposicionMaxima _
                                           , Threshold, Metodologia _
                                           , RecMet5, Valdatos, fRut, fCodigo, fCliente
              
        ProcesoRecalculoREC = Cartera.CalcRec(0).Consumo_Linea
        
        
        'Graba Proceso Rec en tabla TBL_RIEFIN_General_REC
        'If EjecutaBtnREC = False Then 'PROD-10967
           Calcula_REC_SQL Datos(0).Fecha, Cartera, Cartera.CalcRec _
                                          , Valorizacion _
                                          , AddON90d _
                                          , Total_AddOn _
                                          , ExposicionMaxima _
                                          , Threshold, Metodologia _
                                          , Valdatos _
                                          , fRut, fCodigo, fCliente
        'End If 'NO se debe condicionar la grabación 'PROD-10967
    
        If BacBeginTransaction() Then
        
              If Not Lineas_ChequearGrabarRecalculoDRV("BFW", CDbl(1), 1, 1, 0 _
                                      , CDbl(fRut), CDbl(fCodigo), 1 _
                                      , 1, (CDate(gsBAC_Fecp) + 9999), 0, 0, (CDate(gsBAC_Fecp)) _
                                      , 0, "N", CDbl(999), " ", 0, 0, 0 _
                                      , (CDate(gsBAC_Fecp)), 0, CDbl(0), 0, 0, "", ProcesoRecalculoREC _
                                      , Metodologia) Then 'PROD-10967
                  Call BacRollBackTransaction
                  MsgBox "Problemas en Procedimientos"
                  Exit Function
              End If

              mensaje = mensaje & Lineas_Chequear("BFW", CDbl(1), 1, " ", "", "")
            
              If mensaje <> "" Then
                  MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + mensaje, vbCritical
                  Call BacRollBackTransaction
                  Exit Function
              End If
              
        
              If Not Lineas_GrbOperacion("BFW", CDbl(1), 1, CDbl(1), " ", 0, 0) Then
                  Call BacRollBackTransaction
                  MsgBox "Problemas en Procedimientos"
                  'GrabarOperacion = False
                  Exit Function
              End If
              Call BacCommitTransaction
        End If
    
    Next Contador
    
    'MsgBox ("Termina Proceso")

End Function
''MAP

Public Function Rescata_Riesgo_Producto(Sistema As String, Producto As String) As String
    
    Dim Aux() As Long
    Dim i As Long
    Dim ProdAux As String
    ProdAux = Producto  'MAP 09-Sep-2014
    If (Sistema = "PCS") Then
        Select Case Producto
            Case "1"         'SWAP DE TASAS
            ProdAux = "ST"   'MAP 09-Sep-2014
            Case "2"         'SWAP DE MONEDAS"
            ProdAux = "SM"   'MAP 09-Sep-2014
            Case "3"         'FORWARD RATE AGREETMEN
            ProdAux = "FR"   'MAP 09-Sep-2014
            Case "4"         'SWAP PROMEDIO CAMARA
            ProdAux = "SP"
        End Select
    End If
    
    Dim rs As ADODB.Recordset
    Set rs = New ADODB.Recordset
    rs.Open "SELECT Riesgo_interno FROM BacParamSuda..producto WHERE id_sistema ='" + Sistema + "' AND codigo_producto = '" + ProdAux + "'", Conexion
     
    Rescata_Riesgo_Producto = rs(0)
   
    rs.Close
      
End Function


Public Function Rescata_Prioridad_Moneda(MonedaActiva As Integer, MonedaPasiva As Integer) As Integer
    Dim rs As ADODB.Recordset
    Dim Proc_Alm As ADODB.Command
    Dim ErrorEjecucion01 As Integer
    Dim ErrorEjecucion02 As Integer

    'Inicio de variable para ejecuta proceso almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "BACLINEAS..SP_OBTENER_PRIORIDAD_MONEDA "
    Set Proc_Alm.ActiveConnection = Conexion

    'PARAMETROS, distinto y según el procedimiento
    'TABLA PARES DE MONEDAS
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@MONEDA1 ", adInteger, adParamInput, , MonedaActiva)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@MONEDA2 ", adInteger, adParamInput, , MonedaPasiva)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Opcion ", adInteger, adParamInput, , 1)

    'Ejecuta el procedimiento
    On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorEjecucion01 = Err.Number
    On Error GoTo 0

    If ErrorEjecucion01 <> 0 Then
        Exit Function
    End If

    Rescata_Prioridad_Moneda = rs(0)

    rs.Close
   
End Function






Public Sub Proc_Rescata_Clientes_DRV(CLIENTE As Datos_Cliente_DRV, Optional iRut As Long = 0, Optional iCodigo As Long = 0)
    Dim Datos()
    Dim indice As Long
    Envia = Array()
    AddParam Envia, iRut
    AddParam Envia, iCodigo
    
    If Not Bac_Sql_Execute("BacTraderSuda..SP_CON_CLIENTE_DERIVADOS", Envia) Then
      Exit Sub
    End If
   
    Do While Bac_SQL_Fetch(Datos())
'    If DATOS(1) = 1826358 Then
        
        ReDim Preserve CLIENTE.Clie_DRV(indice)
        CLIENTE.Clie_DRV(indice).Rut = Datos(1)
        CLIENTE.Clie_DRV(indice).Codigo = Datos(2)
        CLIENTE.Clie_DRV(indice).Nombre = Datos(3)
        CLIENTE.Clie_DRV(indice).Metodologia = Datos(4)
        CLIENTE.Clie_DRV(indice).Threshold = Datos(5)
        indice = indice + 1
'    End If
    Loop
        
End Sub


Public Sub Proc_EnviarMail(Det_MsgError As String, Titulo As String)
    
    Dim oApp As Object  ' Objeto Application
    Dim oWorkBook As Object ' Libro de trabajo
    Dim oSheet As Object   'Hoja Activ
    Dim Datos() As Variant
    Dim ProxFHabil As Date
    Dim iCadena As String
    
    Envia = Array()
    AddParam Envia, MailCaidaLineas ' Indicador accion

    If Not Bac_Sql_Execute("exec BACPARAMSUDA..SP_LEERENVIOMAIL", Envia) Then
        Call MsgBox("Problemas al Leer Procedimiento. ", vbCritical, App.Title)
    Else
        iCadena = ""
        Do While Bac_SQL_Fetch(Datos())
        iCadena = iCadena + (Datos(5)) & ";"
        Loop
    End If
        
    Dim OutlookApp As Object
    Dim OutlookMail As Object
    Dim Outlookmailitem As Integer
    Dim MailAttach As Integer
    Set OutlookApp = CreateObject("Outlook.Application")
    Set OutlookMail = OutlookApp.CreateItem(Outlookmailitem)
    OutlookMail.To = iCadena
    OutlookMail.Subject = "Problema Lineas del " & Format(CDate(gsBAC_Fecp), "DD-MM-YYYY")
    
    OutlookMail.htmlBody = "<HTML><BODY>" & "Estimados.<br/> <br/>" & _
    "&nbsp &nbsp &nbsp &nbsp Adjunto Errores en calculo de lineas del dia. <b>" & gsBAC_Fecp & ":</b>" & "<br/> <br/>" & _
    "&nbsp &nbsp &nbsp &nbsp " & Titulo & " <br/> <br/>" & _
    "&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp " & Det_MsgError & " <br/> <br/>" & "<HTML><BODY>"
    
    
    OutlookMail.send 'Para que lo envie sin visualizar      'PROD-10967
    'OutlookMail.Display 'Para que lo pare en la pantalla   'PROD-10967

    Set OutlookApp = Nothing
    Set OutlookMail = Nothing
End Sub


Public Sub Proc_Verifica_Parametros(VerificaSim As String, Prametros As Boolean _
                                   , iCadena As String)
    Dim Datos()
    Envia = Array()
    AddParam Envia, VerificaSim ' Indicador accion

    If Not Bac_Sql_Execute("BacLineas..SP_RIEFIN_VERIFICA_PARAMETROS_VAR", Envia) Then
        Call MsgBox("Problemas al Leer Procedimiento. ", vbCritical, App.Title)
    Else
        iCadena = ""
        Do While Bac_SQL_Fetch(Datos())
            'PROD-10967
            iCadena = iCadena + (Datos(1)) & ";" & (Datos(2)) & ";" & (Datos(3)) & "  -  " & Chr$(13)
            If iCadena <> "" Then
                Prametros = True
    End If
    Loop
    End If
           
End Sub

Function Lineas_ChequearGrabarRecalculoDRV(cSist As String, cTipOper As String, nNumPantalla As Double _
                            , nNumdocu As Double, nCorrela As Double, nRut As Double _
                            , nCodigo As Double, nMonto As Double, nTipCambio As Double _
                            , dFecven As Date, nRut_emisor As Double, nMonedaEmision As Integer _
                            , dFecvenInst As Date, nIncodigo As Integer, cSeriado As String _
                            , nMonedaPago As Integer, cGarantia As String, nCodigo_pais As Integer _
                            , cPagoCheque As String, nRutCheque As Double, dFecvenCheque As Date _
                            , nFactorVenta As Double, nForPag As Integer, nTir As Double _
                            , nTasaPact As Double, cInstser As String, Optional nResultado As Double = 0 _
                            , Optional nMetodologiaLCR As Integer = 0)

    Dim Datos()

    Envia = Array()
    AddParam Envia, gsBAC_Fecp                         'Fecha de Proceso
    AddParam Envia, cSist                                    'Sistema
    AddParam Envia, cTipOper                              'Producto
    AddParam Envia, nNumPantalla                       'Numero Operacion
    AddParam Envia, nNumdocu                            'Numero Documento
    AddParam Envia, nCorrela                               'Numero Correlativo
    AddParam Envia, nRut                                    'Rut a Chequear
    AddParam Envia, nCodigo                               'Codigo a Chequear
    AddParam Envia, nMonto                               'Monto
    AddParam Envia, nTipCambio                          'Tipo Cambio
    AddParam Envia, Format(dFecven, FeFecha)   'Fecha Vencimiento
    AddParam Envia, gsUsuario                           'Usuario
    AddParam Envia, nRut_emisor                        'Emisor Instrumento (BTR)
    AddParam Envia, nMonedaEmision                  'Moneda Emision (BTR)
    AddParam Envia, dFecvenInst                         'Fecha Vencimiento Istrumento
    AddParam Envia, nIncodigo                            'Codigo Familia (BTR)
    AddParam Envia, cSeriado                             'Seriado S/N (BTR)
    AddParam Envia, nMonedaPago                     'Moneda Forward
    AddParam Envia, cGarantia                           '(C)Con Garantia   (S)Sin Garantia (BTR)
    AddParam Envia, nCodigo_pais                        'Codigo Pais (FWD-SPO)
    AddParam Envia, cPagoCheque                         'Pago con Cheque S/N
    AddParam Envia, nRutCheque                          'Rut a chequear en pago Chueque
    AddParam Envia, dFecvenCheque                       'Fecha Vcto linea Cheque
    AddParam Envia, nFactorVenta                        'Factor en Venta Definitiva
'    AddParam Envia, nCodEmisor                          'Codigo Emisor
    AddParam Envia, nForPag                             ' Forma de Pago VGS
    AddParam Envia, nTir                                ' Tir del Papel
    AddParam Envia, nTasaPact                           ' Tasa pacto
    AddParam Envia, cInstser                            ' Nemotecnico
    AddParam Envia, 0
    AddParam Envia, 0
    AddParam Envia, nResultado                         'PROD-10967
    AddParam Envia, nMetodologiaLCR                    'PROD-10967
    AddParam Envia, 0                                  'PROD-10967

    Lineas_ChequearGrabarRecalculoDRV = True
                        
    If Not Bac_Sql_Execute(gsBac_LineasDb & "..SP_LINEAS_CHEQUEARGRABAR", Envia) Then 'PROD-10967
        Lineas_ChequearGrabarRecalculoDRV = False
    End If
                        
End Function

Private Sub Graba_Matriz_Covarianza_SQL(Covar() As Double, Datos() As Datos_Mercado, Fecha As Date, Valdatos As Procesos)
    
    
    Dim i As Long
    Dim z As Long
    Dim Covarianza As Long
    Dim ErrorVar As Long
    Dim Corr_Variable  As Long
    Dim NomFilCol As String
    Dim rs As ADODB.Recordset
    Dim InsertSQL As String
    Dim Cifra As String
    Dim Lineas As Long
       
    On Error Resume Next
        Covarianza = UBound(Covar)
        ErrorVar = Err.Number
    On Error GoTo 0
    
    If Not ErrorVar = 0 Then
        Covarianza = -1
        MsgBox ("Problemas al grabar matriz covarianza en Base de Datos")
        Exit Sub
    End If
        
    Borra_Completa_Matriz_Covarianza_SQL
    InsertSQL = ""
    Lineas = 0
    For i = 0 To Covarianza
       NomFilCol = Identifica_Variable_Covarianza(Datos(0), i)
       For z = 0 To Covarianza
            If z >= i Then 'Matriz es simetrica!!!
''               Esto esta comentado porque eliminaba decimales
''               haciendo que la matriz quedara distinta al ser
''               guardada en SQLServer
''               If Covar(i, z) = 0 Then
''                   Cifra = ".0"
''               Else
''                   Valor = CDbl(Covar(i, z))
''                   Cifra = Format(CDbl(Valor), "#.#####################")  '--
''                   If InStr(Cifra, ",") <> 0 Then
''                      'Se cambia la coma por punto
''                      Cifra = Mid(Cifra, 1, InStr(1, Cifra, ",") - 1) & "." & Mid(Cifra, InStr(1, Cifra, ",") + 1)
''                   End If
''               End If
''               InsertSQL = InsertSQL + Chr(13) + "Insert into RIEFIN_Matriz_Covarianza   Select " + Format(i, "0") + ", " + Format(z, "0") + "," + Cifra + ", '" + RTrim(LTrim(NomFilCol)) + "', " + Format(Fecha, "'yyyymmdd'") + ", " + Format(Covarianza, "#")
''               Lineas = Lineas + 1
''               If Lineas >= 100 Then  'Simulacion de Commit
''                  Set rs = New ADODB.Recordset
''                  rs.Open InsertSQL, Conexion
''                  'rs.Close
''                  InsertSQL = ""
''                  Lineas = 0
''               End If

               'OJO: Muy Lento estop pero podría guardar mas decimales
               Call Actualiza_Celda_Matriz_Covarianza_SQL(i, z, Covar(i, z), NomFilCol, Fecha, Covarianza)
            End If
       Next

    Next
    ''If Len(InsertSQL) > 0 Then
    ''   Set rs = New ADODB.Recordset
    ''   rs.Open InsertSQL, Conexion
    ''   'rs.Close
    ''End If
       
End Sub

Public Sub Actualiza_Celda_Matriz_Covarianza_SQL(Fila As Long, Columna As Long, Valor As Double, Nombre As String, Fecha As Date, Dimension As Long)
    
    Dim Proc_Alm As ADODB.Command
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Set Proc_Alm.ActiveConnection = Conexion
    Proc_Alm.CommandText = "SP_RIEFIN_GRABA_MATRIZ_COVARIANZA"
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fila", adInteger, adParamInput, , Fila)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Columna", adInteger, adParamInput, , Columna)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Valor", adDouble, adParamInput, , Valor)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Nombre", adVarChar, adParamInput, 100, Nombre)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@Fecha", adDBTimeStamp, adParamInput, , Fecha)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@TamannoMatriz", adInteger, adParamInput, , Dimension)
    'Ejecuta el procedimiento
    Proc_Alm.Execute

End Sub
Public Sub Borra_Completa_Matriz_Covarianza_SQL()
    
    Dim Proc_Alm As ADODB.Command
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Set Proc_Alm.ActiveConnection = Conexion
    Proc_Alm.CommandText = "SP_RIEFIN_BORRA_MATRIZ_COVARIANZA"
    'Ejecuta el procedimiento
    Proc_Alm.Execute

End Sub
Public Sub Carga_Completa_Matriz_Covarianza_SQL(Covar() As Double, Valdatos As Procesos, largo_vector As Long)
    
    Dim Proc_Alm As ADODB.Command
    Dim rs As ADODB.Recordset
    Dim ErrorMat As Double
    Dim ConsultaMatrizCovarianza As Integer
    Dim Fila As Long
    Dim Columna As Long
    Dim Valor As Double
    Dim DimensionMatriz As Long
    Dim Tabla As Variant
    Dim k As Long
    
    
    'Inicia la variable para ejecutar el procedimiento almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Set Proc_Alm.ActiveConnection = Conexion
    Proc_Alm.CommandText = "SP_RIEFIN_LEE_MATRIZ_COVARIANZA"
    
    'Ejecuta el procedimiento
     On Error Resume Next
        Set rs = Proc_Alm.Execute
        ErrorMat = Err.Number
        Valdatos.ErrorNumero = Err.Number
        Valdatos.ErrorDescripcion = IIf(Valdatos.ErrorNumero <> 0, "Error en lectura matriz Covarianza", "")   '--Err.Description
        Valdatos.ErrorSP = Proc_Alm.CommandText
        Valdatos.ErrorcargaDatos = False
    On Error GoTo 0
    
    ConsultaMatrizCovarianza = 0
    If Not ErrorMat = 0 Then
        ConsultaMatrizCovarianza = -1
        Valdatos.ErrorcargaDatos = True
    End If
    
    If ConsultaMatrizCovarianza = -1 Then
         Exit Sub
    End If
        
    Tabla = rs.GetRows
    rs.Close
    DimensionMatriz = Tabla(3, 0)
    largo_vector = DimensionMatriz
    ReDim Covar(DimensionMatriz, DimensionMatriz)
    For k = 0 To UBound(Tabla, 2)
        Fila = Tabla(0, k)
        Columna = Tabla(1, k)
        Valor = Tabla(2, k)
        Covar(Fila, Columna) = Valor
        Covar(Columna, Fila) = Valor
    Next k
End Sub

Public Sub Genera_Matriz_Covarianza()
        
        Dim Cartera As Negociacion
        Dim Valdatos As Procesos
        Dim Datos(MaxNumero_Simulaciones) As Datos_Mercado
        Dim MCovar() As Double
        Dim largo_vector As Long
        
        'Rescata informacion desde las bases de datos
        Inicia_Conexion
        
        
        Numero_Simulaciones = Rescata_Simulaciones(Cartera, Valdatos, 3 _
                                                  , 0#, 0, 0, "")
        Datos(0).Fecha = gsBAC_FecConFin
        Rescata_Datos_Mercado Datos, Numero_Simulaciones, Valdatos


        Crea_Vector_Simplificado Datos

        Calcula_Covarianza Datos, MCovar, largo_vector, Valdatos
        Call Graba_Matriz_Covarianza_SQL(MCovar, Datos, Datos(0).Fecha, Valdatos) '-- Demora 3 minutos !!!

        Conexion.Close
End Sub


