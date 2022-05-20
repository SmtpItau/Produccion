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
Dim Datos()

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

