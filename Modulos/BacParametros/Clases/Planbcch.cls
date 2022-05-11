VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsPlanilla"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Dim nEstado%, cEstado$
Dim DATOS()

Public fecha$
Public Entidad%

'---- Planilla
Public Planilla_Original_Fecha$
Public Planilla_Original_Numero&

Public planilla_fecha$
Public planilla_numero&

'---- Interesado
Public interesado_rut&
Public interesado_dv$
Public interesado_codigo&
Public interesado_nombre$
Public interesado_direccion$
Public interesado_ciudad$

'---- Operación Spot (MEMO)
Public operacion_numero&
Public operacion_fecha$

'---- Datos de Planilla
Public Tipo_Documento%
Public Tipo_Documento_Glosa$
Public Tipo_Operacion_Cambio%
Public Tipo_Operacion_Cambio_Glosa$
Public Codigo_Comercio$
Public Concepto$
Public Glosa_Comercio$

Public Pais_Operacion%
Public Pais_Operacion_Glosa$

Public Operacion_Moneda%
Public Operacion_Moneda_Glosa$
Public Operacion_Moneda_RRDA$

Public monto_origen#
Public Paridad#
Public monto_dolares#
Public tipo_cambio#
Public monto_pesos#

Public afecto_derivados%
Public cantidad_acuerdos%

'---- Autorización BCCH
Public autBCCH_tipo$
Public autBCCH_tipo_Glosa$
Public autBCCH_numero&
Public autBCCH_fecha$

'---- Relación de planilla ...
Public rel_institucion%
Public rel_institucion_Glosa$
Public rel_fecha$
Public rel_numero&
Public rel_arbitraje%
Public rel_arbitraje_Glosa$

'---- Operaciones con Financiera Internacional
Public ofi_numero_inscripcion&
Public ofi_fecha_inscripcion$
Public ofi_fecha_vencimiento$
Public ofi_nombre_financista$
Public ofi_fecha_desembolso$
Public ofi_moneda_desembolso%
Public ofi_moneda_desembolso_Glosa$
Public ofi_monto_desembolso#
Public ofi_impuesto_adicional#

'---- Exportaciones
Public exp_codigo_aduana%
Public exp_codigo_aduana_Glosa$
Public exp_declaracion_fecha$
Public exp_declaracion_numero$
Public exp_informe_fecha$
Public exp_informe_numero$
Public exp_fecha_vence_retorno$
Public exp_valor_bruto#
Public exp_comisiones#
Public exp_otros_gastos#
Public exp_valor_total#
Public exp_plazo_financia%
Public exp_nombre_comprador$

'---- Cobertura de Importaciones
Public imp_informe_fecha$
Public imp_informe_numero&
Public imp_declaracion_numero$
Public imp_forma_pago%
Public imp_forma_pago_Glosa$
Public imp_embarque_numero&
Public imp_embarque_fecha$
Public imp_fecha_vence$
Public imp_valor_mercaderia#
Public imp_gastos_fob#
Public imp_valor_fob#
Public imp_flete#
Public imp_seguro#
Public imp_valor_cif#
Public imp_intereses#
Public imp_gastos_bancarios#

'---- Derivados (Forwards)
Public der_numero_contrato&
Public der_fecha_inicio$
Public der_fecha_vence$
Public der_instrumento%
Public der_instrumento_Glosa$
Public der_precio_contrato#
Public der_area_contable%
Public der_area_contable_Glosa$

'---- Acuerdos
Public acuerdo_codigo_1$
Public acuerdo_numero_1$
Public acuerdo_codigo_2$
Public acuerdo_numero_2$
Public acuerdo_codigo_3$
Public acuerdo_numero_3$
Public acuerdo_codigo_4$
Public acuerdo_numero_4$
Public acuerdo_codigo_5$
Public acuerdo_numero_5$

'---- Observaciones
Public obs_1$
Public obs_2$
Public obs_3$

Public IsEstadistica%

Public Sub Limpiar()

    fecha = ""
    'Entidad = giBAC_Entidad
    
    '---- Planilla
    planilla_fecha = ""
    planilla_numero = 0
    Planilla_Original_Fecha = ""
    Planilla_Original_Numero = 0
    
    '---- Interesado
    interesado_rut = 0
    interesado_dv = ""
    interesado_codigo = 0
    interesado_nombre = ""
    interesado_direccion = ""
    interesado_ciudad = ""
    
    '---- Operación Spot (MEMO)
    operacion_numero = 0
    operacion_fecha = ""
    
    '---- Datos de Planilla
    Tipo_Documento = 0
    Tipo_Documento_Glosa = ""
    Tipo_Operacion_Cambio = 0
    Tipo_Operacion_Cambio_Glosa = ""
    Codigo_Comercio = ""
    Concepto = ""
    Glosa_Comercio = ""
    
    Pais_Operacion = 0
    Pais_Operacion_Glosa = ""
    
    Operacion_Moneda = 0
    Operacion_Moneda_Glosa = ""
    Operacion_Moneda_RRDA = "D"
    
    monto_origen = 0
    Paridad = 0
    monto_dolares = 0
    tipo_cambio = 0
    monto_pesos = 0
    
    afecto_derivados = 0
    cantidad_acuerdos = 0
    
    '---- Autorización BCCH
    autBCCH_tipo = ""
    autBCCH_tipo_Glosa = ""
    autBCCH_numero = 0
    autBCCH_fecha = gsbac_fecp
    
    '---- Relación de planilla
    rel_institucion = 0
    rel_institucion_Glosa = ""
    rel_fecha = gsbac_fecp
    rel_numero = 0
    rel_arbitraje = False
    rel_arbitraje_Glosa = ""
    
    '---- Operaciones con Financieras Internacionales (Crédito Externo)
    ofi_numero_inscripcion = 0
    ofi_fecha_inscripcion = gsbac_fecp
    ofi_fecha_vencimiento = gsbac_fecp
    ofi_nombre_financista = ""
    ofi_fecha_desembolso = gsbac_fecp
    ofi_moneda_desembolso = 0
    ofi_moneda_desembolso_Glosa = ""
    ofi_monto_desembolso = 0
    ofi_impuesto_adicional = 0
    
    '---- Exportaciones
    exp_codigo_aduana = 0
    exp_codigo_aduana_Glosa = ""
    exp_declaracion_fecha = gsbac_fecp
    exp_declaracion_numero = ""
    exp_informe_fecha = gsbac_fecp
    exp_informe_numero = ""
    exp_fecha_vence_retorno = gsbac_fecp
    exp_valor_bruto = 0
    exp_comisiones = 0
    exp_otros_gastos = 0
    exp_valor_total = 0
    exp_plazo_financia = 0
    exp_nombre_comprador = ""
    
    '---- Cobertura de Importaciones
    imp_informe_fecha = gsbac_fecp
    imp_informe_numero = 0
    imp_declaracion_numero = ""
    imp_forma_pago = 0
    imp_forma_pago_Glosa = ""
    imp_embarque_numero = 0
    imp_embarque_fecha = gsbac_fecp
    imp_fecha_vence = gsbac_fecp
    imp_valor_mercaderia = 0
    imp_gastos_fob = 0
    imp_valor_fob = 0
    imp_flete = 0
    imp_seguro = 0
    imp_valor_cif = 0
    imp_intereses = 0
    imp_gastos_bancarios = 0
    
    '---- Derivados (Forwards)
    der_numero_contrato = 0
    der_fecha_inicio = gsbac_fecp
    der_fecha_vence = gsbac_fecp
    der_instrumento = 0
    der_instrumento_Glosa = ""
    der_precio_contrato = 0
    der_area_contable = 0
    der_area_contable_Glosa = ""
    
    '---- Acuerdos
    acuerdo_codigo_1 = ""
    acuerdo_numero_1 = ""
    acuerdo_codigo_2 = ""
    acuerdo_numero_2 = ""
    acuerdo_codigo_3 = ""
    acuerdo_numero_3 = ""
    acuerdo_codigo_4 = ""
    acuerdo_numero_4 = ""
    acuerdo_codigo_5 = ""
    acuerdo_numero_5 = ""
    
    '---- Observaciones
    obs_1 = ""
    obs_2 = ""
    obs_3 = ""
    
    IsEstadistica = False

End Sub
'******************************************************************
'*  Actualiza campos de planilla
Public Sub Reemplazar(objOrigen As Object)
 
    Call Limpiar
    
    With objOrigen
    
        fecha = .fecha
        Entidad = .Entidad
        
        '---- Planilla
        planilla_fecha = .planilla_fecha
        planilla_numero = .planilla_numero
        Planilla_Original_Numero = .Planilla_Original_Numero
        Planilla_Original_Fecha = .Planilla_Original_Fecha
        
        '---- Interesado
        interesado_rut = .interesado_rut
        interesado_dv = .interesado_dv
        interesado_codigo = .interesado_codigo
        interesado_nombre = .interesado_nombre
        interesado_direccion = .interesado_direccion
        interesado_ciudad = .interesado_ciudad
        
        '---- Operacion (MEMO)
        operacion_numero = .operacion_numero
        operacion_fecha = .operacion_fecha
        
        '---- Datos de Planilla
        Tipo_Documento = .Tipo_Documento
        If Len(Trim(.Tipo_Documento_Glosa)) = 0 Then
            Tipo_Documento_Glosa = Glosa_AyudaPlanilla("tbDocumentos", Str(Tipo_Documento), "")
        Else
            Tipo_Documento_Glosa = .Tipo_Documento_Glosa
        End If
                
        Tipo_Operacion_Cambio = .Tipo_Operacion_Cambio
        If Len(Trim(.Tipo_Operacion_Cambio_Glosa)) = 0 Then
            Tipo_Operacion_Cambio_Glosa = Glosa_AyudaPlanilla("tbOperacionCambio", Str(Tipo_Operacion_Cambio), "")
        Else
            Tipo_Operacion_Cambio_Glosa = .Tipo_Operacion_Cambio_Glosa
        End If
        
        Codigo_Comercio = .Codigo_Comercio
        Concepto = .Concepto
        If Len(Trim(.Glosa_Comercio)) = 0 Then
           Glosa_Comercio = Glosa_AyudaPlanilla("tbCodigoComercio", Codigo_Comercio, Concepto)
        Else
           Glosa_Comercio = .Glosa_Comercio
        End If
        
        Pais_Operacion = .Pais_Operacion
        If Len(Trim(.Pais_Operacion_Glosa)) = 0 Then
           Pais_Operacion_Glosa = Glosa_AyudaPlanilla("tbPais", Str(Pais_Operacion), "")
        Else
           Pais_Operacion_Glosa = .Pais_Operacion_Glosa
        End If
        
        Operacion_Moneda = .Operacion_Moneda
        If Len(Trim(.Operacion_Moneda_Glosa)) = 0 Then
           Operacion_Moneda_Glosa = Glosa_AyudaPlanilla("tbMoneda", Str(Operacion_Moneda), "")
        Else
           Operacion_Moneda_Glosa = .Operacion_Moneda_Glosa
        End If
        Operacion_Moneda_RRDA = .Operacion_Moneda_RRDA
        
        monto_origen = .monto_origen
        Paridad = .Paridad
        monto_dolares = .monto_dolares
        tipo_cambio = .tipo_cambio
        monto_pesos = .monto_pesos
        afecto_derivados = .afecto_derivados
        cantidad_acuerdos = .cantidad_acuerdos
        
        '---- Autorización BCCH
        autBCCH_tipo = .autBCCH_tipo
        If Len(Trim(.autBCCH_tipo_Glosa)) = 0 Then
           autBCCH_tipo_Glosa = Glosa_AyudaPlanilla("tbAutorizacionBCCH", "-1", autBCCH_tipo)
        Else
           autBCCH_tipo_Glosa = .autBCCH_tipo_Glosa
        End If
        autBCCH_numero = .autBCCH_numero
        autBCCH_fecha = IIf(Format(.autBCCH_fecha, "yyyymmdd") <> "19000101", .autBCCH_fecha, gsbac_fecp)
        
        '---- Relación de Planillas
        rel_institucion = .rel_institucion
        If Len(Trim(.rel_institucion_Glosa)) = 0 Then
           rel_institucion_Glosa = Glosa_AyudaPlanilla("tbInstitucion", Str(rel_institucion), "")
        Else
           rel_institucion_Glosa = .rel_institucion_Glosa
        End If
        rel_fecha = IIf(Format(.rel_fecha, "yyyymmdd") <> "19000101", .rel_fecha, gsbac_fecp)
        rel_numero = .rel_numero
        rel_arbitraje = .rel_arbitraje
        rel_arbitraje_Glosa = .rel_arbitraje_Glosa
        
        '---- Operaciones con Financieras Internacionales (Créditos Externos)
        ofi_numero_inscripcion = .ofi_numero_inscripcion
        ofi_fecha_inscripcion = IIf(Format(.ofi_fecha_inscripcion, "yyyymmdd") <> "19000101", .ofi_fecha_inscripcion, gsbac_fecp)
        ofi_fecha_vencimiento = IIf(Format(.ofi_fecha_vencimiento, "yyyymmdd") <> "19000101", .ofi_fecha_vencimiento, gsbac_fecp)
        ofi_nombre_financista = .ofi_nombre_financista
        ofi_fecha_desembolso = IIf(Format(.ofi_fecha_desembolso, "yyyymmdd") <> "19000101", .ofi_fecha_desembolso, gsbac_fecp)
        ofi_moneda_desembolso = .ofi_moneda_desembolso
        If Len(Trim(.ofi_moneda_desembolso_Glosa)) = 0 Then
           ofi_moneda_desembolso_Glosa = Glosa_AyudaPlanilla("tbMoneda", Str(ofi_moneda_desembolso), "")
        Else
           ofi_moneda_desembolso_Glosa = .ofi_moneda_desembolso_Glosa
        End If
        ofi_monto_desembolso = .ofi_monto_desembolso
        ofi_impuesto_adicional = .ofi_impuesto_adicional
        
        '---- Exportaciones
        exp_codigo_aduana = .exp_codigo_aduana
        If Len(Trim(.exp_codigo_aduana_Glosa)) = 0 Then
           exp_codigo_aduana_Glosa = Glosa_AyudaPlanilla("tbAduana", Str(exp_codigo_aduana), "")
        Else
           exp_codigo_aduana_Glosa = .exp_codigo_aduana_Glosa
        End If
        exp_declaracion_fecha = IIf(Format(.exp_declaracion_fecha, "yyyymmdd") <> "19000101", .exp_declaracion_fecha, gsbac_fecp)
        exp_declaracion_numero = .exp_declaracion_numero
        exp_informe_fecha = IIf(Format(.exp_informe_fecha, "yyyymmdd") <> "19000101", .exp_informe_fecha, gsbac_fecp)
        exp_informe_numero = .exp_informe_numero
        exp_fecha_vence_retorno = IIf(Format(.exp_fecha_vence_retorno, "yyyymmdd") <> "19000101", .exp_fecha_vence_retorno, gsbac_fecp)
        exp_valor_bruto = .exp_valor_bruto
        exp_comisiones = .exp_comisiones
        exp_otros_gastos = .exp_otros_gastos
        exp_valor_total = .exp_valor_total
        exp_plazo_financia = .exp_plazo_financia
        exp_nombre_comprador = .exp_nombre_comprador
        
        '---- Cobertura de Importaciones
        imp_informe_fecha = IIf(Format(.imp_informe_fecha, "yyyymmdd") <> "19000101", .imp_informe_fecha, gsbac_fecp)
        imp_informe_numero = .imp_informe_numero
        imp_declaracion_numero = .imp_declaracion_numero
        imp_forma_pago = .imp_forma_pago
        If Len(Trim(.imp_forma_pago_Glosa)) = 0 Then
           imp_forma_pago_Glosa = Glosa_AyudaPlanilla("tbFormaPago", Str(imp_forma_pago), "")
        Else
           imp_forma_pago_Glosa = .imp_forma_pago_Glosa
        End If
        imp_embarque_numero = .imp_embarque_numero
        imp_embarque_fecha = IIf(Format(.imp_embarque_fecha, "yyyymmdd") <> "19000101", .imp_embarque_fecha, gsbac_fecp)
        imp_fecha_vence = IIf(Format(.imp_fecha_vence, "yyyymmdd") <> "19000101", .imp_fecha_vence, gsbac_fecp)
        imp_valor_mercaderia = .imp_valor_mercaderia
        imp_gastos_fob = .imp_gastos_fob
        imp_valor_fob = .imp_valor_fob
        imp_flete = .imp_flete
        imp_seguro = .imp_seguro
        imp_valor_cif = .imp_valor_cif
        imp_intereses = .imp_intereses
        imp_gastos_bancarios = .imp_gastos_bancarios
        
        '---- Derivados (Forwards)
        der_numero_contrato = .der_numero_contrato
        der_fecha_inicio = IIf(Format(.der_fecha_inicio, "yyyymmdd") <> "19000101", .der_fecha_inicio, gsbac_fecp)
        der_fecha_vence = IIf(Format(.der_fecha_vence, "yyyymmdd") <> "19000101", .der_fecha_vence, gsbac_fecp)
        der_instrumento = .der_instrumento
        If Len(Trim(.der_instrumento_Glosa)) = 0 Then
           der_instrumento_Glosa = Glosa_AyudaPlanilla("tbDerivado", Str(der_instrumento), "")
        Else
           der_instrumento_Glosa = .der_instrumento_Glosa
        End If
        der_precio_contrato = .der_precio_contrato
        der_area_contable = .der_area_contable
        If Len(Trim(.der_area_contable_Glosa)) = 0 Then
           der_area_contable_Glosa = Glosa_AyudaPlanilla("tbAreaContable", Str(der_area_contable), "")
        Else
           der_area_contable_Glosa = .der_area_contable_Glosa
        End If
        
        '---- Acuerdos
        acuerdo_codigo_1 = .acuerdo_codigo_1
        acuerdo_numero_1 = .acuerdo_numero_1
        acuerdo_codigo_2 = .acuerdo_codigo_2
        acuerdo_numero_2 = .acuerdo_numero_2
        acuerdo_codigo_3 = .acuerdo_codigo_3
        acuerdo_numero_3 = .acuerdo_numero_3
        acuerdo_codigo_4 = .acuerdo_codigo_4
        acuerdo_numero_4 = .acuerdo_numero_4
        acuerdo_codigo_5 = .acuerdo_codigo_5
        acuerdo_numero_5 = .acuerdo_numero_5
        
        '---- Observaciones
        obs_1 = .obs_1
        obs_2 = .obs_2
        obs_3 = .obs_3
        
        IsEstadistica = .IsEstadistica
    
    End With

End Sub
'******************************************************************
'*  Actualiza campos de planilla
Public Function Leer(xentidad%, xNumOpe&, xNumPla&, xFecPla$) As Boolean
Dim DATOS()
Dim objBuffer As Object
 
    Leer = False
    
    Call Limpiar
    
''''''''''''''''''''''    Sql = "EXECUTE SP_LEER_PLANILLAS " & xentidad
''''''''''''''''''''''    Sql = Sql & ",'" & xFecPla & "'"
''''''''''''''''''''''    Sql = Sql & ", " & xNumPla
''''''''''''''''''''''    Sql = Sql & ", " & xNumOpe
    Envia = Array()
    
    AddParam Envia, xentidad
    AddParam Envia, xFecPla
    AddParam Envia, xNumPla
    AddParam Envia, xNumOpe
   
   
    If Not Bac_Sql_Execute("SP_LEER_PLANILLAS", Envia) Then
        
        Exit Function
    
    End If
    
    Do While Bac_SQL_Fetch(DATOS())

        fecha = DATOS(1)
        Entidad = DATOS(2)
        
        '---- Planilla
        planilla_fecha = DATOS(3)
        planilla_numero = DATOS(4)
        If rel_numero > 0 And Format(planilla_fecha, "yyyymmdd") = Format(gsbac_fecp, "yyyymmdd") Then
            Planilla_Original_Numero = rel_numero
            Planilla_Original_Fecha = rel_fecha
        Else
            Planilla_Original_Numero = planilla_numero
            Planilla_Original_Fecha = planilla_fecha
        End If
        
        '---- Interesado
        interesado_rut = DATOS(5)
        interesado_dv = Valida_Mod11(Str(interesado_rut))
        interesado_codigo = DATOS(6)
        interesado_nombre = DATOS(7)
        interesado_direccion = DATOS(8)
        interesado_ciudad = DATOS(9)
        
        '---- Operacion (MEMO)
        operacion_numero = DATOS(10)
        operacion_fecha = DATOS(11)
        
        '---- Datos de Planilla
        Tipo_Documento = DATOS(12)
        Tipo_Documento_Glosa = Glosa_AyudaPlanilla("tbDocumentos", Str(Tipo_Documento), "")
        
        Tipo_Operacion_Cambio = DATOS(13)
        Tipo_Operacion_Cambio_Glosa = Glosa_AyudaPlanilla("tbOperacionCambio", Str(Tipo_Operacion_Cambio), "")
        
        Codigo_Comercio = DATOS(14)
        Concepto = DATOS(15)
        Glosa_Comercio = Glosa_AyudaPlanilla("tbCodigoComercio", Codigo_Comercio, Concepto)
        
        Pais_Operacion = DATOS(16)
        Pais_Operacion_Glosa = Glosa_AyudaPlanilla("tbPais", Str(Pais_Operacion), "")
        
        Operacion_Moneda = DATOS(17)
        Operacion_Moneda_Glosa = Glosa_AyudaPlanilla("tbMoneda", Str(Operacion_Moneda), "")
        Operacion_Moneda_RRDA = bacMonedaRRDA(Operacion_Moneda)
        
        monto_origen = DATOS(18)
        Paridad = DATOS(19)
        monto_dolares = DATOS(20)
        tipo_cambio = DATOS(21)
        monto_pesos = DATOS(22)
        
        afecto_derivados = DATOS(23)
        cantidad_acuerdos = DATOS(24)
        
        '---- Autorización BCCH
        autBCCH_tipo = DATOS(25)
        autBCCH_tipo_Glosa = Glosa_AyudaPlanilla("tbAutorizacionBCCH", "-1", autBCCH_tipo)
        autBCCH_numero = DATOS(26)
        autBCCH_fecha = IIf(Format(DATOS(27), "yyyymmdd") <> "19000101", DATOS(27), gsbac_fecp)
        
        '---- Relación de Planillas
        rel_institucion = DATOS(28)
        rel_institucion_Glosa = Glosa_AyudaPlanilla("tbInstitucion", Str(rel_institucion), "")
        rel_fecha = IIf(Format(DATOS(29), "yyyymmdd") <> "19000101", DATOS(29), gsbac_fecp)
        rel_numero = DATOS(30)
        rel_arbitraje = (DATOS(31) = "A")
        rel_arbitraje_Glosa = IIf(rel_arbitraje, "Arbitraje", "Anulación o Reemplazo")
        
        '---- Operaciones con Financieras Internacionales (Créditos Externos)
        ofi_numero_inscripcion = DATOS(32)
        ofi_fecha_inscripcion = IIf(Format(DATOS(33), "yyyymmdd") <> "19000101", DATOS(33), gsbac_fecp)
        ofi_fecha_vencimiento = IIf(Format(DATOS(34), "yyyymmdd") <> "19000101", DATOS(34), gsbac_fecp)
        ofi_nombre_financista = DATOS(35)
        ofi_fecha_desembolso = IIf(Format(DATOS(36), "yyyymmdd") <> "19000101", DATOS(36), gsbac_fecp)
        ofi_moneda_desembolso = DATOS(37)
        ofi_moneda_desembolso_Glosa = Glosa_AyudaPlanilla("tbMoneda", Str(ofi_moneda_desembolso), "")
        ofi_monto_desembolso = DATOS(38)
        ofi_impuesto_adicional = DATOS(39)
        
        '---- Exportaciones
        exp_codigo_aduana = DATOS(40)
        exp_codigo_aduana_Glosa = Glosa_AyudaPlanilla("tbAduana", Str(exp_codigo_aduana), "")
        exp_declaracion_fecha = DATOS(41)
        exp_declaracion_numero = DATOS(42)
        exp_informe_fecha = IIf(Format(DATOS(43), "yyyymmdd") <> "19000101", DATOS(43), gsbac_fecp)
        exp_informe_numero = DATOS(44)
        exp_fecha_vence_retorno = IIf(Format(DATOS(45), "yyyymmdd") <> "19000101", DATOS(45), gsbac_fecp)
        exp_valor_bruto = DATOS(46)
        exp_comisiones = DATOS(47)
        exp_otros_gastos = DATOS(48)
        exp_valor_total = DATOS(49)
        exp_plazo_financia = DATOS(50)
        exp_nombre_comprador = DATOS(51)
        
        '---- Cobertura de Importaciones
        imp_informe_fecha = IIf(Format(DATOS(52), "yyyymmdd") <> "19000101", DATOS(52), gsbac_fecp)
        imp_informe_numero = DATOS(53)
        imp_declaracion_numero = DATOS(54)
        imp_forma_pago = DATOS(55)
        imp_forma_pago_Glosa = Glosa_AyudaPlanilla("tbFormaPago", Str(imp_forma_pago), "")
        imp_embarque_numero = DATOS(56)
        imp_embarque_fecha = IIf(Format(DATOS(57), "yyyymmdd") <> "19000101", DATOS(57), gsbac_fecp)
        imp_fecha_vence = IIf(Format(DATOS(58), "yyyymmdd") <> "19000101", DATOS(58), gsbac_fecp)
        imp_valor_mercaderia = DATOS(59)
        imp_gastos_fob = DATOS(60)
        imp_valor_fob = DATOS(61)
        imp_flete = DATOS(62)
        imp_seguro = DATOS(63)
        imp_valor_cif = DATOS(64)
        imp_intereses = DATOS(65)
        imp_gastos_bancarios = DATOS(66)
        
        '---- Derivados (Forwards)
        der_numero_contrato = DATOS(67)
        der_fecha_inicio = IIf(Format(DATOS(68), "yyyymmdd") <> "19000101", DATOS(68), gsbac_fecp)
        der_fecha_vence = IIf(Format(DATOS(69), "yyyymmdd") <> "19000101", DATOS(69), gsbac_fecp)
        der_instrumento = DATOS(70)
        der_instrumento_Glosa = Glosa_AyudaPlanilla("tbDerivado", Str(der_instrumento), "")
        der_precio_contrato = DATOS(71)
        der_area_contable = DATOS(72)
        der_area_contable_Glosa = Glosa_AyudaPlanilla("tbAreaContable", Str(der_area_contable), "")
        
        '---- Acuerdos
        acuerdo_codigo_1 = DATOS(73)
        acuerdo_numero_1 = DATOS(74)
        acuerdo_codigo_2 = DATOS(75)
        acuerdo_numero_2 = DATOS(76)
        acuerdo_codigo_3 = DATOS(77)
        acuerdo_numero_3 = DATOS(78)
        acuerdo_codigo_4 = DATOS(79)
        acuerdo_numero_4 = DATOS(80)
        acuerdo_codigo_5 = DATOS(81)
        acuerdo_numero_5 = DATOS(82)
        
        '---- Observaciones
        obs_1 = DATOS(83)
        obs_2 = DATOS(84)
        obs_3 = DATOS(85)
        
        IsEstadistica = False
        
        Exit Do

    Loop

    Leer = True

End Function
'******************************************************************
'*  Graba planilla
Public Function grabar(objPlanilla As Object) As Boolean
Dim lNew As Boolean

    grabar = False
    
'''''''''''''''''''''''''''''''''''    Sql = "EXECUTE SP_GRABA_PLANILLA "
'''''''''''''''''''''''''''''''''''
'''''''''''''''''''''''''''''''''''    With objPlanilla
'''''''''''''''''''''''''''''''''''        lNew = (.planilla_numero = 0)
'''''''''''''''''''''''''''''''''''        If .planilla_fecha = "" Then .planilla_fecha = gsbac_fecp
'''''''''''''''''''''''''''''''''''
'''''''''''''''''''''''''''''''''''        '---- Armando grabado de Planilla
'''''''''''''''''''''''''''''''''''        Sql = Sql & .Entidad
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Format(.planilla_fecha, "yyyymmdd") & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .planilla_numero
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .interesado_rut
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .interesado_codigo
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .interesado_nombre & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .interesado_direccion & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .interesado_ciudad & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .operacion_numero
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Format(.operacion_fecha, "yyyymmdd") & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .Tipo_Documento
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .Tipo_Operacion_Cambio
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .Codigo_Comercio & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .Concepto & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .Pais_Operacion
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .Operacion_Moneda
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .monto_origen
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .Paridad
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .monto_dolares
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .tipo_cambio
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .monto_pesos
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .afecto_derivados
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .cantidad_acuerdos
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .autBCCH_tipo & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .autBCCH_numero
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Format(.autBCCH_fecha, "yyyymmdd") & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .rel_institucion
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Format(.rel_fecha, "yyyymmdd") & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .rel_numero
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & IIf(.rel_arbitraje = True, "A", "P") & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .ofi_numero_inscripcion
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Format(.ofi_fecha_inscripcion, "yyyymmdd") & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Format(.ofi_fecha_vencimiento, "yyyymmdd") & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .ofi_nombre_financista & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Format(.ofi_fecha_desembolso, "yyyymmdd") & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .ofi_moneda_desembolso
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .ofi_monto_desembolso
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .ofi_impuesto_adicional
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .exp_codigo_aduana
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Format(.exp_declaracion_fecha, "yyyymmdd") & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .exp_declaracion_numero & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Format(.exp_informe_fecha, "yyyymmdd") & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .exp_informe_numero & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Format(.exp_fecha_vence_retorno, "yyyymmdd") & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .exp_valor_bruto
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .exp_comisiones
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .exp_otros_gastos
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .exp_valor_total
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .exp_plazo_financia
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .exp_nombre_comprador & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Format(.imp_informe_fecha, "yyyymmdd") & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .imp_informe_numero
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .imp_declaracion_numero & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .imp_forma_pago
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .imp_embarque_numero
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Format(.imp_embarque_fecha, "yyyymmdd") & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Format(.imp_fecha_vence, "yyyymmdd") & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .imp_valor_mercaderia
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .imp_gastos_fob
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .imp_valor_fob
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .imp_flete
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .imp_seguro
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .imp_valor_cif
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .imp_intereses
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .imp_gastos_bancarios
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .der_numero_contrato
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Format(.der_fecha_inicio, "yyyymmdd") & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Format(.der_fecha_vence, "yyyymmdd") & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .der_instrumento
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .der_precio_contrato
'''''''''''''''''''''''''''''''''''        Sql = Sql & ", " & .der_area_contable
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .acuerdo_codigo_1 & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .acuerdo_numero_1 & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .acuerdo_codigo_2 & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .acuerdo_numero_2 & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .acuerdo_codigo_3 & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .acuerdo_numero_3 & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .acuerdo_codigo_4 & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .acuerdo_numero_4 & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .acuerdo_codigo_5 & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & .acuerdo_numero_5 & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Trim(.obs_1) & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Trim(.obs_2) & "'"
'''''''''''''''''''''''''''''''''''        Sql = Sql & ",'" & Trim(.obs_3) & "'"
'''''''''''''''''''''''''''''''''''    End With

    Envia = Array()
    
    With objPlanilla
        
        lNew = (.planilla_numero = 0)
        
        If .planilla_fecha = "" Then .planilla_fecha = gsbac_fecp
        
        '---- Armando grabado de Planilla
        
        AddParam Envia, .Entidad
        AddParam Envia, Format(.planilla_fecha, "yyyymmdd")
        AddParam Envia, .planilla_numero
        AddParam Envia, .interesado_rut
        AddParam Envia, .interesado_codigo
        AddParam Envia, .interesado_nombre
        AddParam Envia, .interesado_direccion
        AddParam Envia, .interesado_ciudad
        AddParam Envia, .operacion_numero
        AddParam Envia, Format(.operacion_fecha, "yyyymmdd")
        AddParam Envia, .Tipo_Documento
        AddParam Envia, .Tipo_Operacion_Cambio
        AddParam Envia, .Codigo_Comercio
        AddParam Envia, .Concepto
        AddParam Envia, .Pais_Operacion
        AddParam Envia, .Operacion_Moneda
        AddParam Envia, .monto_origen
        AddParam Envia, .Paridad
        AddParam Envia, .monto_dolares
        AddParam Envia, .tipo_cambio
        AddParam Envia, .monto_pesos
        AddParam Envia, .afecto_derivados
        AddParam Envia, .cantidad_acuerdos
        AddParam Envia, .autBCCH_tipo
        AddParam Envia, .autBCCH_numero
        AddParam Envia, Format(.autBCCH_fecha, "yyyymmdd")
        AddParam Envia, .rel_institucion
        AddParam Envia, Format(.rel_fecha, "yyyymmdd")
        AddParam Envia, .rel_numero
        AddParam Envia, IIf(.rel_arbitraje = True, "A", "P")
        AddParam Envia, .ofi_numero_inscripcion
        AddParam Envia, Format(.ofi_fecha_inscripcion, "yyyymmdd")
        AddParam Envia, Format(.ofi_fecha_vencimiento, "yyyymmdd")
        AddParam Envia, .ofi_nombre_financista
        AddParam Envia, Format(.ofi_fecha_desembolso, "yyyymmdd")
        AddParam Envia, .ofi_moneda_desembolso
        AddParam Envia, .ofi_monto_desembolso
        AddParam Envia, .ofi_impuesto_adicional
        AddParam Envia, .exp_codigo_aduana
        AddParam Envia, Format(.exp_declaracion_fecha, "yyyymmdd")
        AddParam Envia, .exp_declaracion_numero
        AddParam Envia, Format(.exp_informe_fecha, "yyyymmdd")
        AddParam Envia, .exp_informe_numero
        AddParam Envia, Format(.exp_fecha_vence_retorno, "yyyymmdd")
        AddParam Envia, .exp_valor_bruto
        AddParam Envia, .exp_comisiones
        AddParam Envia, .exp_otros_gastos
        AddParam Envia, .exp_valor_total
        AddParam Envia, .exp_plazo_financia
        AddParam Envia, .exp_nombre_comprador
        AddParam Envia, Format(.imp_informe_fecha, "yyyymmdd")
        AddParam Envia, .imp_informe_numero
        AddParam Envia, .imp_declaracion_numero
        AddParam Envia, .imp_forma_pago
        AddParam Envia, .imp_embarque_numero
        AddParam Envia, Format(.imp_embarque_fecha, "yyyymmdd")
        AddParam Envia, Format(.imp_fecha_vence, "yyyymmdd")
        AddParam Envia, .imp_valor_mercaderia
        AddParam Envia, .imp_gastos_fob
        AddParam Envia, .imp_valor_fob
        AddParam Envia, .imp_flete
        AddParam Envia, .imp_seguro
        AddParam Envia, .imp_valor_cif
        AddParam Envia, .imp_intereses
        AddParam Envia, .imp_gastos_bancarios
        AddParam Envia, .der_numero_contrato
        AddParam Envia, Format(.der_fecha_inicio, "yyyymmdd")
        AddParam Envia, Format(.der_fecha_vence, "yyyymmdd")
        AddParam Envia, .der_instrumento
        AddParam Envia, .der_precio_contrato
        AddParam Envia, .der_area_contable
        AddParam Envia, .acuerdo_codigo_1
        AddParam Envia, .acuerdo_numero_1
        AddParam Envia, .acuerdo_codigo_2
        AddParam Envia, .acuerdo_numero_2
        AddParam Envia, .acuerdo_codigo_3
        AddParam Envia, .acuerdo_numero_3
        AddParam Envia, .acuerdo_codigo_4
        AddParam Envia, .acuerdo_numero_4
        AddParam Envia, .acuerdo_codigo_5
        AddParam Envia, .acuerdo_numero_5
        AddParam Envia, Trim(.obs_1)
        AddParam Envia, Trim(.obs_2)
        AddParam Envia, Trim(.obs_3)
    End With


Retry_Save:
    
    If Not Bac_Sql_Execute("SP_GRABA_PLANILLA", Envia) Then
        
        If MsgBox("Planilla No pudo ser Grabada ...", vbRetryCancel + vbInformation, TITSISTEMA) = vbRetry Then
            
            GoTo Retry_Save
        
        End If
        
        Exit Function
    
    End If
    
    grabar = True

End Function
Public Function Borrar() As Boolean
    
    Borrar = False
    
    nEstado = -1
    cEstado = "No se pudo Eliminar Planilla # " & planilla_numero & vbCrLf
    
''''''''''''    Sql = "EXECUTE SP_BORRAR_PLANILLA " & Entidad
''''''''''''    Sql = Sql & ",'" & Format(planilla_fecha, "yyyymmdd") & "'"
''''''''''''    Sql = Sql & ", " & planilla_numero
   
    Envia = Array()
   
    AddParam Envia, Entidad
    AddParam Envia, Format(planilla_fecha, "yyyymmdd") & "'"
    AddParam Envia, planilla_numero
   
Retry_Load:
    
    nEstado = Bac_Sql_Execute("SP_BORRAR_PLANILLA", Envia)
    
    If nEstado <> 0 Then
        
        '---- Captura Error
        
        If Bac_SQL_Fetch(DATOS()) Then
            
            nEstado = DATOS(1)
            cEstado = DATOS(2)
        
        End If
    
    End If
    
    If nEstado <> 0 Then
        
        If MsgBox(cEstado, vbRetryCancel + vbInformation, TITSISTEMA) = vbRetry Then
            
            GoTo Retry_Load
        
        End If
        
        Exit Function
    
    End If
    
    Borrar = True

End Function
