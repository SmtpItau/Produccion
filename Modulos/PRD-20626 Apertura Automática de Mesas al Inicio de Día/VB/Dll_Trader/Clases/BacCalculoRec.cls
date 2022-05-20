VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "BacCalculoRec"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Const MaxNumero_Simulaciones = 300
Const Percentil = 5
Const FDec4Dec = "#,##0.0000"
Const FDec2Dec = "#,##0.00"
Const FDec0Dec = "###0"
Const MailCaidaLineas = "8606"
Const MailCaidaParam = "8607"

Private Type Cliente_DRV
    Rut                                 As Long
    Codigo                              As Integer
    NOMBRE                              As String
    Metodologia                         As Long
    Threshold                           As Double
End Type
Private Type Datos_Cliente_DRV
    Clie_DRV()                          As Cliente_DRV
End Type
Private Type MatrizMet5
    Numero_Operacion                    As Long
    Sistema                             As String
    Producto                            As String
    Valor_Mercado                       As Double
    Amortizacion                        As Double
    AddOn                               As Double
    Maximo                              As Double
    Prc                                 As Double
    Plazo                               As Double
    ValorMoneda                         As Double
    LCRParMdaGruMda                     As String
End Type
Private Type MatrizMet2
    Numero_Operacion                    As Long
    Sistema                             As String
    Producto                            As String
    Valor_Mercado                       As Double
    Amortizacion                        As Double
    AddOn                               As Double
    Maximo                              As Double
    Prc                                 As Double
    Plazo                               As Double
    ValorMoneda                         As Double
    LCRParMdaGruMda                     As String
End Type
Private Type Valor_Mercado
    Numero_Operacion                    As Long
    Valor_Mercado                       As Double
    Sistema                             As String
    SistemaBAC                          As String
    AddOnMdaLocal                       As Double
    MaxValMeryAddOn                     As Double
End Type
Private Type Valor_Moneda
    vmValor                             As Double
    vmfecha                             As Date
    vmcodigo                            As Long
End Type
Private Type Valor_Moneda_Contable
    Tipo_Cambio                         As Double
    Fecha                               As Date
    Codigo_Moneda                       As Long
End Type
Private Type Par_MonedasLcr
    LCRParMda1                          As Long
    LCRParMda2                          As Long
    LCRGruMdaCod                        As String
End Type
Private Type Producto_AsocRiesgo_PlazoMayor
    Id_sistema                          As String
    Codigo_Producto                     As String
    LCRGruMdaCod                        As String
    LCRPla                              As Double
    LCRPon                              As Double
    Codigo_Riesgo                       As Long
End Type
Private Type Producto_AsocRiesgo_PlazoMenor
    Id_sistema                          As String
    Codigo_Producto                     As String
    LCRGruMdaCod                        As String
    LCRPla                              As Double
    LCRPon                              As Double
    Codigo_Riesgo                       As Long
End Type
Private Type Flujos
    FechaLiquidacion                    As Date
    ValorMercado                        As Double
End Type
Private Type Datos_Cliente
    Swap_Op_Threshold_LCR               As Double
    Swap_Op_Metodologia_LCR             As Integer
    Swap_Op_Cliente_LCR                 As String
End Type
Public Type CalculaRec
    Fecha                               As Date
    Rut                                 As Long
    Codigo                              As Integer
    NOMBRE                              As String
    Linea                               As Double
    Treshold                            As Double
    Valor_Mercado                       As Double
    Exposicion_Maxima                   As Double
    VaR90D                              As Double
    Garantia_Ejecutada                  As String
    Consumo_Linea                       As Double
    Holgura                             As Double
    Estado_Linea                        As String
End Type
Private Type Operaciones_Swap
    'Datos rescatados de consulta
    Rut                                 As Long
    Codigo                              As Integer
    Numero_Operacion                    As Long
    Numero_flujo                        As Long
    Tipo_flujo                          As Long
    Tipo_swap                           As Long
    Modalidad_pago                      As String
    Cartera                             As Long
    Moneda                              As Long
    Moneda_Bac                          As Long
    Codigo_tasa                         As Long
    Convencion                          As String
    Base                                As Long
    PlazoFwd                            As Long
    IndexLag                            As Long
    Fecha_ini                           As Date
    Fecha_fin                           As Date
    Fecha_fija                          As Date
    Fecha_liq                           As Date
    Codigo_descuento                    As Long
    Codigo_forward                      As Long
    Tasa_flujo                          As Double
    Spread                              As Double
    Saldo                               As Double
    Amortizacion                        As Double
    Flujo_adicional                     As Double
    Valor_Mercado_BAC                   As Double
    Plazo                               As Long
    Duration                            As Double
    FlujoFuturo                         As Double
    'Datos calculados
    Plazo_ini                           As Long
    Plazo_fin                           As Long
    Plazo_liq                           As Long
    Dias                                As Long
    Valor_Mercado                       As Double
    Valor_Simulacion()                  As Double
    EarlyTermination                    As String
End Type
Private Type Operaciones_Fwd
    'Datos rescatados de consulta
    Rut                                 As Long
    Codigo                              As Integer
    Numero_Operacion                    As Long
    Sentido_operacion                   As String
    Tipo_forward                        As Long
    Modalidad_pago                      As String
    Cartera                             As Long
    Moneda(1)                           As Long
    Fecha_ini                           As Date
    Fecha_fin                           As Date
    Fecha_efectiva                      As Date
    Fecha_fixing                        As Date
    Puntos_fwd                          As Double
    Codigo_descuento(1)                 As Long
    Amortizacion(1)                     As Double
    Valor_Mercado_BAC                   As Double
    Moneda_1_BAC                        As Long
    Moneda_2_BAC                        As Long
    Plazo                               As Long
    Duration                            As Double
   'Datos calculados
    Plazo_efectivo                      As Long
    Plazo_fixing                        As Long
    Valor_Mercado                       As Double
    Valor_Simulacion()                  As Double
    EarlyTermination                    As String
End Type
Private Type Fixings
   'Datos obtenidos de consulta
    Fecha                               As Date
    Peso                                As Double
    Obs                                 As Double
   'Datos calculados por macro
    Plazo                               As Long
End Type
Private Type Operaciones_Opcion
   'Datos obtenidos de consulta
    Rut                                 As Long
    Codigo                              As Integer
    NumOp                               As Long         'Número de operación
    Cartera                             As Long         'Cartera
    Estructura                          As String       'Flag que indica si es una estructura o una operacion individual
    NumEstructura                       As Long         'Número dentro de la estructura
    Call_Put                            As String       'Flag de Call o Put
    Compra_Venta                        As String       'Flag de Compra o Venta
    Payoff                              As String       'Tipo de payoff: vanilla o asiática
    Vecto                               As Date         'Fecha de expiracion
    Nominal                             As Double       'Nominal
    X                                   As Double       'Strike
    Codigo_Spot                         As Long         'Codigo del tipo de cambio subyacente
    Cod_mon_val                         As Long         'Codigo de la moneda del resultado ByS
    Codigo_rd                           As Long         'Codigo de tasa local
    Codigo_rf                           As Long         'Codigo de tasa foranea
    Codigo_vol                          As Long         'Codigo de la superficie de volatilidad
    Valor_Mercado_BAC                   As Double       'Valor de Mercado en BAC
    Moneda_1_BAC                        As Long         'Codigo de moneda en Bac
    Moneda_2_BAC                        As Long         'Codigo de moneda en Bac
    Plazo_Bac                           As Long         'Plazo en Bac
    Duration                            As Double
   'Sólo opciones asiáticas
    Tabla()                             As Fixings      'Tabla con la información de los fixings
   'Datos calculados por macro
    Plazo                               As Long         'Plazo de expiración
    Valor_Mercado                       As Double       'Valor de mercado
    Valor_Simulacion()                  As Double
    EarlyTermination                    As String
End Type
Private Type Carteras_AddOn
    Num_Operacion                       As Long
    Sistema                             As String
    Producto                            As String
    Tipo_Operacion                      As String
    Capital_Activo                      As Double
    Capital_Pasivo                      As Double
    Plazo_Activo                        As Long
    Plazo_Pasivo                        As Long
    Moneda_Activo                       As Integer
    Moneda_Pasivo                       As Integer
    Duration_Activo                     As Double
    Duration_Pasivo                     As Double
    Fecha_Proceso                       As Date
   'Monto Float
   'Prc Float
End Type
Private Type Datos_AddOn
     AddOn_Operaciones()                As Carteras_AddOn
End Type
Private Type Tabla_Desarrollo
    Flujo                               As Double
    Fecha                               As Date
    Plazo                               As Long
End Type
Private Type Operaciones_FWD_RF
    'Propiedades obtenidas de SQL
    Rut                                 As Long
    Codigo                              As Integer
    Numero_Operacion                    As Long    'Numero de operacion
    Sentido_operacion                   As String 'Compra o venta
    Nemo                                As String              'Nemotecnico
    Cartera                             As Long             'Cartera a la que pertenece el instrumento
    Nominal                             As Double           'Nominal o principal
    Emisor                              As String            'Emisor
    Serie                               As String             'Serie, para filtro valorizacion
    Mascara                             As String           'Mascara, para rescatar tabla de desarrollo
    Fecha_Vecto                         As Date         'Fecha de Vencimiento del subyacente
    Fecha_Vecto_Fwd                     As Date     'Fecha de Vencimiento. Para depositos
    Tasa_Fwd                            As Double          'Tasa forward negociada
    Cod_Moneda                          As Long          'Codigo de moneda de la emision
    Cod_Tasa                            As Long            'Codigo de la tasa con que se descuenta
    Cod_Tasa_F                          As Long          'Codigo de la tasa de financiamiento
    Flujo()                             As Tabla_Desarrollo        'Tabla de desarrollo del instrumento
    Base                                As Long                'Base de calculo
    Valor_Mercado_BAC                   As Double 'Valor de mercado calculado por BAC
    Moneda_1_BAC                        As Long
    Moneda_2_BAC                        As Long
    Plazo_Bac                           As Long
    Duration                            As Double
    'Valores calculados en la macro
    Plazo                               As Long
    Valor_Mercado                       As Double
    Valor_Simulacion()                  As Double
    EarlyTermination                    As String
    Producto                            As String
End Type
Private Type Exp_Maxima
    Fecha                               As Date
    Rut                                 As Long
    Cod                                 As Integer
    Mtm                                 As Double
    Operacion                           As Double
    EarlyTermination                    As String
    Tipo_Operacion                      As String
    Producto                            As String
End Type
Private Type Exp_Max_Fecha
    Max_Exp                             As Double
    Fecha                               As Date
End Type
Private Type Resultado_Exp_Max
    Result_exp_Max                      As Double
    Fecha_Exp_Max                       As Date
End Type
Private Type Procesos
    ErrorNumero                         As Double
    ErrorDescripcion                    As String
    ErrorSP                             As String
    ErrorcargaDatos                     As Boolean
End Type
Private Type Negociacion
   'Almacena las fechas de los datos
    Fecha(MaxNumero_Simulaciones)       As Date
    Threshold                           As Double
    Rut                                 As Long
    Codigo                              As Integer
    Metodología                         As Integer
    CLIENTE                             As String
    Exposicion_Maxima                   As Double
    Fecha_Exp_Maxima                    As Date
   'Almacena las carteras
    Cartera_Swap()                      As Operaciones_Swap
    Cartera_Fwd()                       As Operaciones_Fwd
    Cartera_Opcion()                    As Operaciones_Opcion
    Cartera_Fwd_RF()                    As Operaciones_FWD_RF
    Fecha_Exp_Max()                     As Exp_Max_Fecha
    Total_Exp_maxima()                  As Resultado_Exp_Max
    CalcRec()                           As CalculaRec
   'Almacena Monedas
    Par_Monedas()                       As Par_MonedasLcr
    Prod_AsocRiesgo_Mayor()             As Producto_AsocRiesgo_PlazoMayor
    Prod_AsocRiesgo_Menor()             As Producto_AsocRiesgo_PlazoMenor
    Val_Moneda()                        As Valor_Moneda
    Val_Mon_Contable()                  As Valor_Moneda_Contable
    Val_Mercado()                       As Valor_Mercado
    Metodologia5()                      As MatrizMet5
    Metodologia2()                      As MatrizMet2
End Type
Private Type Exposicion_Maxima
    Exp_Max()                           As Exp_Maxima
End Type
Private Type DV01_Operacion
    Producto()                          As String
    Num_Operacion()                     As Long
    Matriz()                            As Double
    Var()                               As Double
    Rut()                               As Long
    Plazo()                             As Long
End Type
Private Type Tenors_Tasas
    Plazo                               As Long
    Tasa                                As Double
    dv01(3)                             As Double
End Type
Private Type Vector_Tasas
    Par()                               As Tenors_Tasas
End Type
Private Type Tabla_Datos
    Fecha                               As Date
    Valor                               As Double
End Type
Private Type Par_Vol
    Vol                                 As Double
    Strike                              As Double
End Type
Private Type Tenors_Vol
    Plazo                               As Long
    Par(4)                              As Par_Vol
End Type
Private Type VolSfce
    Codigo_Moneda                       As Long
    Codigo_rd                           As Long
    Codigo_rf                           As Long
    Superf()                            As Tenors_Vol
End Type
Private Type DV01_Mon
    dv01(3)                             As Double
End Type
Private Type Datos_Mercado
    Fecha                               As Date
    Tasas_Swap()                        As Vector_Tasas
    Tasas_Fwd()                         As Vector_Tasas
    Tasas_RF()                          As Vector_Tasas
    ICP()                               As Tabla_Datos
    UF()                                As Tabla_Datos
    Paridad()                           As Double
    TC()                                As Double
    Vol()                               As VolSfce
    DV01_TC()                           As DV01_Mon
End Type

Private gsSQL_Server                    As String
Private gsBac_LineasDb                  As String
Private gsSQL_Login                     As String
Private gsSQL_Password                  As String


Property Let SQL_Server(ByVal oValor As String)
    gsSQL_Server = oValor
End Property
Property Let Bac_LineasDb(ByVal oValor As String)
    gsBac_LineasDb = oValor
End Property
Property Let SQL_Login(ByVal oValor As String)
    gsSQL_Login = oValor
End Property
Property Let SQL_Password(ByVal oValor As String)
    gsSQL_Password = oValor
End Property



Private Function AddOn_Al_Vencimiento(Cartera As Negociacion, AddOn As Datos_AddOn, iFecha As Date, Metodologia As Integer)
    Dim AddOn_Opciones As Double
    Dim AddOn_Carteras_Bac As Double

    AddOn_Al_Vencimiento_Swap Cartera, AddOn, iFecha
    AddOn_Al_Vencimiento_Forward Cartera, AddOn
    AddOn_Al_Vencimiento_Forward_RF Cartera, AddOn
    AddOn_Al_Vencimiento_Opciones Cartera, AddOn

    AddOn_Opciones = AddOn_Consulta_Opciones(Cartera, AddOn, Metodologia)

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
   Dim ValMoneda As Long
   Dim ErrorValMoneda As Long
   Dim ValMonContable As Long
   Dim ErrorValMonContable As Long
   Dim Metodologia5 As Long
   Dim ErrorMetodologia5 As Long
   Dim ContMetodologia2 As Long
   Dim ErrorContMetodologia2 As Long
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
                
                End If
            Next
                                     
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
                  
            Prc = 0
                 
            If EncuentraPlazo2 = 0 Then
               Prc = Pond1
            End If
            
            If EncuentraPlazo1 = 0 Then
               Prc = Pond2
            End If
            
            If Prc = 0 Then
               Prc = Pond1 + (Pond2 - Pond1) * (InputPlazo - Plazo1) / IIf((Plazo2 - Plazo1) = 0, 1, (Plazo2 - Plazo1))
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
             
        End If
    Next
    If Metodologia = 2 Then
        AddOn_Consulta_Carteras_Bac_Riesgo = Monto
    End If
End Function


Private Function Carga_ParMonedas_Sistemas(Cartera As Negociacion)

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
      
    FechaAnterior = Tabla(0, 0) 'DATOS(1)
    
    'Inicio de variable para ejecuta proceso almacenado
    Set Proc_Alm = New ADODB.Command
    Proc_Alm.CommandType = adCmdStoredProc
    Proc_Alm.CommandText = "BACLINEAS..SP_RIEFIN_CON_PARMONEDAS"
    Set Proc_Alm.ActiveConnection = Conexion
    
    'PARAMETROS, distinto y según el procedimiento
    'TABLA PARES DE MONEDAS
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@OPCION", adInteger, adParamInput, , 4)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@FechaProceso", adDBTimeStamp, adParamInput, , gsBac_Fecp)
    Proc_Alm.Parameters.Append Proc_Alm.CreateParameter("@FechaAyer", adDBTimeStamp, adParamInput, , FechaAnterior)
    
    
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

    For i = 0 To LargoLista
      ReDim Preserve Cartera.Prod_AsocRiesgo_Mayor(i)
      Cartera.Prod_AsocRiesgo_Mayor(i).Id_sistema = Trim(Tabla(0, i))      'DATOS(1)
      Cartera.Prod_AsocRiesgo_Mayor(i).Codigo_Producto = Trim(Tabla(1, i)) 'DATOS(2)
      Cartera.Prod_AsocRiesgo_Mayor(i).LCRGruMdaCod = Trim(Tabla(2, i))    'DATOS(3)
      Cartera.Prod_AsocRiesgo_Mayor(i).LCRPla = Tabla(3, i)                'DATOS(4)
      Cartera.Prod_AsocRiesgo_Mayor(i).LCRPon = Tabla(4, i)                'DATOS(5)
      Cartera.Prod_AsocRiesgo_Mayor(i).Codigo_Riesgo = Tabla(5, i)         'DATOS(6)
    Next i
End Function

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


Private Function AddOn_Al_Vencimiento_Forward(Cartera As Negociacion, AddOn As Datos_AddOn)
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
        AddOn.AddOn_Operaciones(indice).Tipo_Operacion = "C"
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
End Function

Private Function AddOn_Al_Vencimiento_Forward_RF(Cartera As Negociacion, AddOn As Datos_AddOn)
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
        AddOn.AddOn_Operaciones(indice).Tipo_Operacion = "C"
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
End Function

Private Function AddOn_Al_Vencimiento_Opciones(Cartera As Negociacion, AddOn As Datos_AddOn)
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
        AddOn.AddOn_Operaciones(indice).Tipo_Operacion = ""
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
End Function

Private Function AddOn_Al_Vencimiento_Swap(Cartera As Negociacion, AddOn As Datos_AddOn, iFecha As Date)
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
                If Cartera.Cartera_Swap(k).Tipo_flujo = 2 Then
                  AddOn.AddOn_Operaciones(indice).Moneda_Pasivo = Cartera.Cartera_Swap(i).Moneda_Bac
                  AddOn.AddOn_Operaciones(indice).Capital_Pasivo = 0 'Cartera.Cartera_Swap(i).Saldo
                  AddOn.AddOn_Operaciones(indice).Plazo_Pasivo = Cartera.Cartera_Swap(i).Plazo
             
                  AddOn.AddOn_Operaciones(indice).Duration_Pasivo = Format(Cartera.Cartera_Swap(i).Duration, FDec4Dec)
                End If
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
End Function

Private Function AddOn_Al_Vencimiento_SwapMet5(Cartera As Negociacion, AddOn As Datos_AddOn, iFecha As Date)
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
End Function

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
        .cols = 14:         .FixedCols = 0
    
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
            
        For nContador = 0 To .cols - 1
             .Row = 0
             .Col = nContador
             '.TextStyle = TextStyleHeader
             .CellAlignment = flexAlignCenterCenter
             .WordWrap = True
        Next nContador

    End With
End Sub


Private Function Proc_Rescata_Clientes_DRV(CLIENTE As Datos_Cliente_DRV, Optional iRut As Long = 0, Optional iCodigo As Long = 0)
    Dim Datos()
    Dim indice As Long
    
    Envia = Array()
    AddParam Envia, iRut
    AddParam Envia, iCodigo
    If Not Bac_Sql_Execute("BacTraderSuda..SP_CON_CLIENTE_DERIVADOS", Envia) Then
      Exit Function
    End If
   
    Do While Bac_SQL_Fetch(Datos())
        ReDim Preserve CLIENTE.Clie_DRV(indice)
        CLIENTE.Clie_DRV(indice).Rut = Datos(1)
        CLIENTE.Clie_DRV(indice).Codigo = Datos(2)
        CLIENTE.Clie_DRV(indice).NOMBRE = Datos(3)
        CLIENTE.Clie_DRV(indice).Metodologia = Datos(4)
        CLIENTE.Clie_DRV(indice).Threshold = Datos(5)
        indice = indice + 1
    Loop
        
End Function


Public Function Proc_Recalculo_Lineas_DRV(Optional iRut As Long = 0, Optional iCodigo As Long = 0) As Boolean
    Dim CalcRec             As Double
    Dim Det_MsgError        As String
    Dim Contador            As Long
    Dim CliMet_2_5          As Long
    Dim CliMet_3            As Long
    Dim VerificaSim         As String
    Dim Parametros          As Boolean
    Dim iCadena             As String
    Dim Titulo              As String
    Dim CLIENTE             As Datos_Cliente_DRV
    Dim TotClieDRV          As Double
    Dim ErrorTotClieDRV     As Long
    Dim inicio              As Variant
    Dim fin                 As Variant

    Call Proc_Rescata_Clientes_DRV(CLIENTE, iRut, iCodigo)

    On Error Resume Next
    TotClieDRV = UBound(CLIENTE.Clie_DRV)
    ErrorTotClieDRV = Err.Number
    On Error GoTo 0

    If Not ErrorTotClieDRV = 0 Then
        TotClieDRV = -1
    End If

    If TotClieDRV = -1 Then
        Call MsgBox("No hay Clientes con Metodologías Netting. ", vbInformation, App.Title)
        Exit Function
    End If

    Let CliMet_2_5 = 0
    Let CliMet_3 = 0
    
    For Contador = 0 To TotClieDRV
        If CLIENTE.Clie_DRV(Contador).Metodologia = 2 Or CLIENTE.Clie_DRV(Contador).Metodologia = 5 Then
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
            Call Proc_EnviarMail(iCadena, Titulo)
        End If
    Else
        Let VerificaSim = "PAR_DIA"
        Call Proc_Verifica_Parametros(VerificaSim, Parametros, iCadena)
        If Parametros = True Then
            Call MsgBox(iCadena, vbCritical, "Faltan los siguentes parametros")
            Let Titulo = "Falta Agregar los siguientes parametros: "
            Call Proc_EnviarMail(iCadena, Titulo)
            Exit Function
        End If
    End If
    
    Let Det_MsgError = ""
    Let inicio = Now  'PROD-10967
    Call ProcesoRecalculoREC(CLIENTE, Det_MsgError, "General")
    Let fin = Now     'PROD-10967
    MsgBox ("Recalculo Netting demoró " + Format(Minute(fin) * 60 + Second(fin) - Minute(inicio) * 60 - Second(inicio), "######.##") + " Seg.") 'PROD-10967

    Let Titulo = ""
    If Det_MsgError <> "" Then
        Let Titulo = "Se generaron los siguientes Errores en Calculo REC.: "
        Call Proc_EnviarMail(Det_MsgError, Titulo)
    End If
    Screen.MousePointer = vbDefault
End Function


Private Function Proc_Verifica_Parametros(VerificaSim As String, Prametros As Boolean, iCadena As String) As Boolean
    Dim Datos()
    
    Proc_Verifica_Parametros = False
    
    Envia = Array()
    AddParam Envia, VerificaSim ' Indicador accion
    If Not Bac_Sql_Execute("BacLineas..SP_RIEFIN_VERIFICA_PARAMETROS_VAR", Envia) Then
        Exit Function
    Else
        iCadena = ""
        Do While Bac_SQL_Fetch(Datos())
            iCadena = iCadena + (Datos(1)) & ";" & (Datos(2)) & ";" & (Datos(3)) & "  -  " & Chr$(13)
            If iCadena <> "" Then
                Prametros = True
            End If
        Loop
    End If
    Proc_Verifica_Parametros = True
End Function

'Private Sub Proc_EnviarMail(Det_MsgError As String, Titulo As String)
'    Dim oApp            As Object  ' Objeto Application
'    Dim oWorkBook       As Object ' Libro de trabajo
'    Dim oSheet          As Object   'Hoja Activ
'    Dim Datos()         As Variant
'    Dim ProxFHabil      As Date
'    Dim iCadena         As String
'
'    Envia = Array()
'    AddParam Envia, MailCaidaLineas ' Indicador accion
'
'    If Not Bac_Sql_Execute("exec BACPARAMSUDA..SP_LEERENVIOMAIL", Envia) Then
'        Call MsgBox("Problemas al Leer Procedimiento. ", vbCritical, App.Title)
'    Else
'        iCadena = ""
'        Do While Bac_SQL_Fetch(Datos())
'        iCadena = iCadena + (Datos(5)) & ";"
'        Loop
'    End If
'
'    Dim OutlookApp As Object
'    Dim OutlookMail As Object
'    Dim Outlookmailitem As Integer
'    Dim MailAttach As Integer
'    Set OutlookApp = CreateObject("Outlook.Application")
'    Set OutlookMail = OutlookApp.CreateItem(Outlookmailitem)
'    OutlookMail.To = iCadena
'    OutlookMail.Subject = "Problema Lineas del " & Format(CDate(gsBac_Fecp), "DD-MM-YYYY")
'
'    OutlookMail.htmlBody = "<HTML><BODY>" & "Estimados.<br/> <br/>" & _
'    "&nbsp &nbsp &nbsp &nbsp Adjunto Errores en calculo de lineas del dia. <b>" & gsBac_Fecp & ":</b>" & "<br/> <br/>" & _
'    "&nbsp &nbsp &nbsp &nbsp " & Titulo & " <br/> <br/>" & _
'    "&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp " & Det_MsgError & " <br/> <br/>" & "<HTML><BODY>"
'
'
'    OutlookMail.send 'Para que lo envie sin visualizar      'PROD-10967
'    'OutlookMail.Display 'Para que lo pare en la pantalla   'PROD-10967
'
'    Set OutlookApp = Nothing
'    Set OutlookMail = Nothing
'End Sub



Private Function ProcesoRecalculoREC(CLIENTE As Datos_Cliente_DRV, ByRef MsgError As String, TipoCalculo As String) As Double
    Dim Conexion                            As ADODB.Connection
    Dim iRut                                As Long
    Dim iCodigo                             As Long
    Dim RecMet5                             As Double
    Dim Matriz_DV01                         As DV01_Operacion
    Dim Exp_Max                             As Negociacion
    Dim Valdatos                            As Procesos
    Dim AddOn                               As Datos_AddOn
    Dim Valorizacion                        As Double
    Dim Cartera                             As Negociacion
    Dim expom                               As Exposicion_Maxima
    Dim Datos(MaxNumero_Simulaciones)       As Datos_Mercado
    Dim MCovar()                            As Double
    Dim largo_vector                        As Long
    Dim AddON90d                            As Double
    Dim ExposicionMaxima                    As Double
    Dim Total_AddOn                         As Double
    Dim Valor_Mercado                       As Long
    Dim ClienteTieneDerivados               As Boolean
    Dim ErrorGeneral                        As Long
    Dim Threshold                           As Double
    Dim Metodologia                         As Integer
    Dim fCodigo                             As Long
    Dim fRut                                As Long
    Dim fCliente                            As String
    Dim Mensaje                             As String
    Dim ConsideraCliente                    As Boolean
    Dim ValidarRec                          As Boolean
    Dim Tiempo                              As Date
    
    Let Tiempo = Time

    Let fRut = 0
    Let fCodigo = 0
    Let fCliente = ""
    Let Metodologia = 0
    Let Threshold = 0
    Screen.MousePointer = vbHourglass
    
   'Rescata informacion desde las bases de datos

    Inicia_Conexion

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
        Let fCliente = CLIENTE.Clie_DRV(Contador).NOMBRE
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
                Valoriza_Cartera_Trading Cartera, Datos(0), Datos(0).Fecha
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
            
                Valoriza_Cartera_Trading Cartera, Datos(0), Datos(0).Fecha
            
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
                

            
                Calcula_DV01_Principal Cartera, Datos(0), Valdatos
                
                Calcula_VaR Cartera, MCovar, largo_vector, Datos(0).Fecha, Matriz_DV01, fRut, fCodigo, TipoCalculo
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
                                      , 1, (CDate(gsBac_Fecp) + 9999), 0, 0, (CDate(gsBac_Fecp)) _
                                      , 0, "N", CDbl(999), " ", 0, 0, 0 _
                                      , (CDate(gsBac_Fecp)), 0, CDbl(0), 0, 0, "", ProcesoRecalculoREC _
                                      , Metodologia) Then 'PROD-10967
                  Call BacRollBackTransaction
                  MsgBox "Problemas en Procedimientos"
                  Exit Function
              End If

              Mensaje = Mensaje & Lineas_Chequear("BFW", CDbl(1), 1, " ", "", "")
            
              If Mensaje <> "" Then
                  MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical
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

End Function


Private Sub Proc_EnviarMail(Det_MsgError As String, Titulo As String)
    Dim oApp            As Object  ' Objeto Application
    Dim oWorkBook       As Object ' Libro de trabajo
    Dim oSheet          As Object   'Hoja Activ
    Dim Datos()         As Variant
    Dim ProxFHabil      As Date
    Dim iCadena         As String
    Dim OutlookApp      As Object
    Dim OutlookMail     As Object
    Dim Outlookmailitem As Integer
    Dim MailAttach      As Integer
    
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
        
    Set OutlookApp = CreateObject("Outlook.Application")
    Set OutlookMail = OutlookApp.CreateItem(Outlookmailitem)
    OutlookMail.To = iCadena
    OutlookMail.Subject = "Problema Lineas del " & Format(CDate(gsBac_Fecp), "DD-MM-YYYY")
    
    OutlookMail.htmlBody = "<HTML><BODY>" & "Estimados.<br/> <br/>" & _
    "&nbsp &nbsp &nbsp &nbsp Adjunto Errores en calculo de lineas del dia. <b>" & gsBac_Fecp & ":</b>" & "<br/> <br/>" & _
    "&nbsp &nbsp &nbsp &nbsp " & Titulo & " <br/> <br/>" & _
    "&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp " & Det_MsgError & " <br/> <br/>" & "<HTML><BODY>"
    
    
    OutlookMail.send 'Para que lo envie sin visualizar      'PROD-10967
    'OutlookMail.Display 'Para que lo pare en la pantalla   'PROD-10967

    Set OutlookApp = Nothing
    Set OutlookMail = Nothing
End Sub

