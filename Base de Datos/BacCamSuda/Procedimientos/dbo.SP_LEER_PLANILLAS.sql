USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_PLANILLAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_LEER_PLANILLAS] ( @Entidad NUMERIC(2) ,
         @Fecha    CHAR(8) ,
         @NumPlan NUMERIC(7) ,
         @NumOper NUMERIC(7) ,
                                     @Interfaz     CHAR(3) = '' ) 
AS
BEGIN
 SET NOCOUNT ON
 SELECT 'fecha'                 = CONVERT(CHAR(08),fecha,112),
 entidad   ,
        'planilla_fecha'        = CONVERT(CHAR(08),planilla_fecha,112),
        planilla_numero         ,
        interesado_rut          ,
        interesado_codigo       ,
        interesado_nombre       ,
        interesado_direccion    ,
        interesado_ciudad       ,
        operacion_numero        ,
        'operacion_fecha'       = CONVERT(CHAR(08),operacion_fecha,112),
        tipo_documento          ,
        tipo_operacion_cambio   ,
        codigo_comercio         ,
        concepto                ,
        pais_operacion          ,
        operacion_moneda        ,
        monto_origen            ,
        paridad                 ,
        monto_dolares           ,
        tipo_cambio             ,
        monto_pesos             ,
        afecto_derivados        ,
        cantidad_acuerdos       ,
        autBCCH_tipo            ,
        autBCCH_numero          ,
        'autBCCH_fecha'         = ISNULL(CONVERT(CHAR(08),autBCCH_fecha,112),''),
        rel_institucion         ,
        'rel_fecha'             = ISNULL(CONVERT(CHAR(08),rel_fecha,112),''),
        rel_numero              ,
 rel_arbitraje  ,
        ofi_numero_inscripcion  ,
        'ofi_fecha_inscripcion' = ISNULL(CONVERT(CHAR(08),ofi_fecha_inscripcion,112),''),
        'ofi_fecha_vencimiento' = ISNULL(CONVERT(CHAR(08),ofi_fecha_vencimiento,112),''),
        ofi_nombre_financista   ,
        'ofi_fecha_desembolso'  = ISNULL(CONVERT(CHAR(08),ofi_fecha_desembolso,112),''),
        ofi_moneda_desembolso   ,
        ofi_monto_desembolso    ,
        ofi_impuesto_adicional  ,
        exp_codigo_aduana       ,
        'exp_declaracion_fecha' = ISNULL(CONVERT(CHAR(08),exp_declaracion_fecha,112),''),
        exp_declaracion_numero  ,
        'exp_informe_fecha'  = ISNULL(CONVERT(CHAR(08),exp_informe_fecha,112),''),
        exp_informe_numero      ,
        'exp_fecha_vence_retorno'=ISNULL(CONVERT(CHAR(08),exp_fecha_vence_retorno,112),''),
        exp_valor_bruto         ,
        exp_comisiones          ,
        exp_otros_gastos        ,
        exp_valor_total         ,
        exp_plazo_financia      ,
        exp_nombre_comprador    ,
        'imp_informe_fecha'  = ISNULL(CONVERT(CHAR(08),imp_informe_fecha,112),''),
        imp_informe_numero      ,
        imp_declaracion_numero  ,
        imp_forma_pago          ,
        imp_embarque_numero     ,
        'imp_embarque_fecha' = ISNULL(CONVERT(CHAR(08),imp_embarque_fecha,112),''),
        'imp_fecha_vence' = ISNULL(CONVERT(CHAR(08),imp_fecha_vence,112),''),
        imp_valor_mercaderia    ,
        imp_gastos_fob          ,
        imp_valor_fob           ,
        imp_flete               ,
        imp_seguro              ,
        imp_valor_cif           ,
        imp_intereses           ,
        imp_gastos_bancarios    ,
        der_numero_contrato     ,
        'der_fecha_inicio'  = ISNULL(CONVERT(CHAR(08),der_fecha_inicio,112),''),
        'der_fecha_vence'  = ISNULL(CONVERT(CHAR(08),der_fecha_vence,112),''),
        der_instrumento         ,
        der_precio_contrato     ,
        der_area_contable       ,
        acuerdo_codigo_1        ,
        acuerdo_numero_1        ,
        acuerdo_codigo_2        ,
        acuerdo_numero_2        ,
        acuerdo_codigo_3        ,
        acuerdo_numero_3        ,
        acuerdo_codigo_4        ,
        acuerdo_numero_4        ,
        acuerdo_codigo_5        ,
        acuerdo_numero_5        ,
        obs_1                   ,
        obs_2                   ,
        obs_3                   ,
        'paisBCCH'              = 'S',  -- informa Pais al BCCH
        'Estadistica'           = 'N',  -- es estadistica
        'rutBCCH'               = 'S',  -- informa Rut  al BCCH
        'planilla_original_numero' = 0,
        'planilla_orden'        = ISNULL(CONVERT(CHAR(8),planilla_fecha,112),'') 
                                + RIGHT('0000000000' + CONVERT(VARCHAR(10),planilla_numero),10),
        'Hora'                  = CONVERT(CHAR(10), GETDATE(), 108 )
   INTO #planillas
   FROM  view_planilla_spt
   WHERE (@Fecha    = ''  OR  CONVERT(CHAR(8), planilla_fecha,112) = @Fecha)
     AND (@NumPlan  =  0  OR  planilla_numero  = @NumPlan --OR planilla_original_numero = @NumPlan
      OR (@Interfaz = 'R' AND rel_numero       = @NumPlan))
     AND (@NumOper  =  0  OR  operacion_numero = @NumOper)
     AND (@Entidad  =  0  OR  entidad          = @Entidad)  
   ----<< actualiza datos según codigo planilla
   UPDATE #planillas   SET paisBCCH    = 'S', --c.pais_BCCH,
                           rutBCCH     = c.rut_BCCH,
                           Estadistica = c.estadistica
                      FROM view_codigo_comercio c
                     WHERE c.codigo_relacion = #planillas.codigo_comercio
                     --  AND c.concepto = #planillas.concepto        
   ----<< actualiza datos para Interfaz, si es R=Planillas Relacionadas
   IF @Interfaz <> '' AND @Interfaz <> 'R' BEGIN
      --<< Otros
      UPDATE #planillas   SET exp_informe_numero = SPACE(7)
                        WHERE exp_informe_numero = '0'
      --<< NO REQUIERE monto en pesos
      UPDATE #planillas   SET monto_pesos          = 0,
                              imp_valor_mercaderia = 0,
                              imp_gastos_fob       = 0
                        WHERE tipo_operacion_cambio = 300
      --<< NO REQUIERE plazo de financiamiento Retorno
      UPDATE #planillas   SET exp_plazo_financia = 0
                        WHERE tipo_operacion_cambio = 500
      --<< NO REQUIERE Valor Bruto financiamiento Anticipo Comprador
      UPDATE #planillas   SET --tipo_cambio            = 0,
                              monto_pesos            = 0,
                              exp_declaracion_fecha  = '19000101',
                              exp_declaracion_numero = '',
                              exp_informe_fecha      = '19000101',
                              exp_informe_numero     = '',
                              exp_codigo_aduana      = 0,
                              exp_valor_bruto        = 0,
                              exp_comisiones         = 0,
                              exp_otros_gastos       = 0,
                              exp_valor_total        = 0
                        WHERE tipo_operacion_cambio  = 401 
                          --AND tipo_documento IN (1,2,8,9)
      --<< NO REQUIERE para Credito Interno
      UPDATE #planillas   SET monto_pesos            = 0,
                              exp_valor_bruto        = 0,
                              exp_comisiones         = 0,
                              exp_otros_gastos       = 0,
                              exp_valor_total        = 0
                        WHERE tipo_operacion_cambio  = 403
      --<< NO REQUIERE pais de origen o de remesa
      UPDATE #planillas   SET pais_operacion = 0
                        WHERE (NOT (codigo_comercio = '10080') AND paisBCCH = 'N')
                           OR (codigo_comercio  = '10080' AND monto_dolares < 10000)
      --<< NO REQUIERE rut
      UPDATE #planillas   SET interesado_rut       =  0,
                              interesado_codigo    =  0,
                              interesado_nombre    = 'VARIAS OPERACIONES',
                              interesado_direccion = '',
                              interesado_ciudad    = ''   
                        WHERE (codigo_comercio <> '10080' AND rutBCCH = 'N')
                           OR (codigo_comercio  = '10080' AND monto_dolares < 10000)
                OR interesado_rut = 1   -- Cliente Capitulos (CAP.3 TIT.1 Anexo 2)
      --<< fechas para interfaz
      --select '3'
      UPDATE #planillas   SET planilla_fecha          = CONVERT(CHAR(8), planilla_fecha         , 112),
                              operacion_fecha         = CONVERT(CHAR(8), operacion_fecha        , 112),
                              autBCCH_fecha           = CONVERT(CHAR(8), autBCCH_fecha          , 112),
                              rel_fecha               = CONVERT(CHAR(8), rel_fecha              , 112),
                              ofi_fecha_inscripcion   = CONVERT(CHAR(8), ofi_fecha_inscripcion  , 112),
                              ofi_fecha_vencimiento   = CONVERT(CHAR(8), ofi_fecha_vencimiento  , 112),
                              ofi_fecha_desembolso    = CONVERT(CHAR(8), ofi_fecha_desembolso   , 112),
                              exp_declaracion_fecha   = CONVERT(CHAR(8), exp_declaracion_fecha  , 112),
                              exp_informe_fecha       = CONVERT(CHAR(8), exp_informe_fecha      , 112),
                              exp_fecha_vence_retorno = CONVERT(CHAR(8), exp_fecha_vence_retorno, 112),
                              imp_informe_fecha       = CONVERT(CHAR(8), imp_informe_fecha      , 112),
                              imp_embarque_fecha      = CONVERT(CHAR(8), imp_embarque_fecha     , 112),
                              imp_fecha_vence         = CONVERT(CHAR(8), imp_fecha_vence        , 112),
                              der_fecha_inicio        = CONVERT(CHAR(8), der_fecha_inicio       , 112),
                              der_fecha_vence         = CONVERT(CHAR(8), der_fecha_vence        , 112)
      --select '2'   
      UPDATE #planillas   SET autBCCH_fecha           = ISNULL( (CASE autBCCH_fecha              WHEN '19000101' THEN '00000000' ELSE autBCCH_fecha    END) , '00000000' ),
                              rel_fecha               = ISNULL( (CASE rel_fecha                  WHEN '19000101' THEN '00000000' ELSE rel_fecha        END) , '00000000' ),
                              ofi_fecha_inscripcion   = ISNULL( (CASE ofi_fecha_inscripcion      WHEN '19000101' THEN '00000000' ELSE ofi_fecha_inscripcion    END) , '00000000' ),
                              ofi_fecha_vencimiento   = ISNULL( (CASE ofi_fecha_vencimiento      WHEN '19000101' THEN '00000000' ELSE ofi_fecha_vencimiento    END) , '00000000' ),
                              ofi_fecha_desembolso    = ISNULL( (CASE ofi_fecha_desembolso       WHEN '19000101' THEN '00000000' ELSE ofi_fecha_desembolso     END) , '00000000' ),
                              exp_declaracion_fecha   = ISNULL( (CASE LEFT(exp_declaracion_fecha  ,4) WHEN '1900'     THEN '00000000' ELSE exp_declaracion_fecha   END), '00000000' ),
                              exp_informe_fecha       = ISNULL( (CASE LEFT(exp_informe_fecha      ,4) WHEN '1900'     THEN '00000000' ELSE exp_informe_fecha       END), '00000000' ),
                              exp_fecha_vence_retorno = ISNULL( (CASE LEFT(exp_fecha_vence_retorno,4) WHEN '1900'     THEN '00000000' ELSE exp_fecha_vence_retorno END), '00000000' ),
                              imp_informe_fecha       = ISNULL( (CASE      imp_informe_fecha          WHEN '19000101' THEN '00000000' ELSE imp_informe_fecha       END), '00000000' ),
                              imp_embarque_fecha      = ISNULL( (CASE      imp_embarque_fecha         WHEN '19000101' THEN '00000000' ELSE imp_embarque_fecha      END), '00000000' ),
                              imp_fecha_vence         = ISNULL( (CASE      imp_fecha_vence            WHEN '19000101' THEN '00000000' ELSE imp_fecha_vence         END), '00000000' ),
                           der_fecha_inicio        = (CASE      der_fecha_inicio           WHEN '19000101' THEN '00000000' ELSE der_fecha_inicio        END),
                              der_fecha_vence         = (CASE      der_fecha_vence            WHEN '19000101' THEN '00000000' ELSE der_fecha_vence         END)
   END 
   ----<< Resultado
   --select '1'
   IF @Interfaz IN ( 'REV' , 'POS' ) BEGIN  -- Revision de Planillon
      --<< fecha y hora de Reporte
      UPDATE #planillas   SET fecha          = CONVERT(CHAR(8), GETDATE(), 108),
                              planilla_fecha = CONVERT(CHAR(10), planilla_fecha, 103)
                           --   planilla_fecha = CONVERT(CHAR(10), CONVERT(DATETIME,planilla_fecha), 103)
      IF @Interfaz = 'REV' -- Revision de Planillon
         SELECT *   FROM #planillas   ORDER BY entidad,planilla_fecha,tipo_documento, tipo_operacion_cambio, planilla_numero
      IF @Interfaz = 'POS' -- Revision de Posiciones de Planillon
         SELECT *   FROM #planillas   WHERE tipo_documento < 8 ORDER BY entidad,planilla_fecha,operacion_moneda,planilla_numero
   END ELSE BEGIN
       SELECT *  FROM #planillas   ORDER BY entidad, planilla_orden
   END
END
-- SELECT * INTO PLATOT FROM VIEW_PLANILLA_SPT WHERE planilla_fecha = '20010831'
-- sp_Leer_Planillas 1, '20020528', 0, 0, 'POS'
-- sp_autoriza_ejecutar 'bacuser'


-- sp_Leer_Planillas 1, '20020528', 0, 0, 'POS'





GO
