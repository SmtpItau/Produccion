USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPRIMIR_PLANILLA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IMPRIMIR_PLANILLA] 
        (
        @ENTIDAD          NUMERIC(3),
        @PLANILLA_FECHA   CHAR(8),
        @PLANILLA_NUMERO  NUMERIC(6)
 )
AS
BEGIN
SET NOCOUNT ON
 
---------------------<< VALIDA EXISTENCIA DE PLANILLA
IF NOT EXISTS (SELECT PLANILLA_NUMERO FROM VIEW_PLANILLA_SPT
         WHERE entidad    = @ENTIDAD
           AND planilla_numero = @PLANILLA_NUMERO
           AND CONVERT(CHAR(8),planilla_fecha,112) = @PLANILLA_FECHA)
BEGIN
     SELECT -1,'PLANILLA NO SE ENCONTRO'
     RETURN
END
---------------------<< INICIANDO TABLAS Y CONSULTA
DELETE FROM RPTDETALLEINTERESES
SELECT *   INTO #PLANILLA
  FROM VIEW_PLANILLA_SPT
 WHERE entidad        = @ENTIDAD
   AND planilla_numero = @PLANILLA_NUMERO
   AND CONVERT(CHAR(8),planilla_fecha,112) = @PLANILLA_FECHA
---------------------<< CARGA GLOSAS PLANILLA >>-----------------------------
DECLARE @TIPO_DOCUMENTO          VARCHAR(50),
        @TIPO_OPERACION_CAMBIO   VARCHAR(50),
        @PAIS_OPERACION          VARCHAR(50),
        @OPERACION_MONEDA        VARCHAR(50),
        @CONCEPTO                VARCHAR(50)
SELECT @TIPO_DOCUMENTO        = 'NO NAME',
 @TIPO_OPERACION_CAMBIO = 'NO NAME',
 @PAIS_OPERACION        = 'NO NAME',
 @OPERACION_MONEDA      = 'NO NAME',
 @CONCEPTO              = 'NO NAME'
SELECT @TIPO_DOCUMENTO = glosa
  FROM VIEW_AYUDA_PLANILLA, #PLANILLA
 WHERE codigo_tabla    = 1  AND
        tipo_documento  = codigo_numerico
SELECT @TIPO_OPERACION_CAMBIO = glosa
  FROM VIEW_AYUDA_PLANILLA, #PLANILLA
 WHERE codigo_tabla          = 14 AND
        tipo_operacion_cambio = codigo_numerico
SELECT @PAIS_OPERACION = NOMBRE
  FROM  VIEW_PAIS, #PLANILLA
 WHERE  pais_operacion = VIEW_PAIS.CODIGO_PAIS
SELECT @OPERACION_MONEDA = mnglosa
  FROM VIEW_MONEDA, #PLANILLA
 WHERE  operacion_moneda = mncodmon
SELECT @CONCEPTO = a.glosa 
  FROM  VIEW_CODIGO_COMERCIO A, #PLANILLA B
 WHERE a.codigo_relacion = b.codigo_comercio --and a.concepto = b.concepto
---------------------<< CARGA GLOSA RELACION
DECLARE @REL_INSTITUCION VARCHAR(50),
        @REL_FECHA       VARCHAR(10)
SELECT  @REL_INSTITUCION = '',
        @REL_FECHA       = ''
IF (SELECT REL_INSTITUCION FROM #PLANILLA) <> 0
   SELECT @REL_INSTITUCION = CONVERT(CHAR( 3),rel_institucion) + ' - ' + clnombre,
          @REL_FECHA       = CONVERT(CHAR(10),rel_fecha,103)
     FROM  VIEW_CLIENTE , #PLANILLA
    WHERE  rel_institucion = isnull(clcodban,0)
---------------------<< CARGA GLOSA CREDITO EXTERNO
DECLARE @OFI_MONEDA_DESEMBOLSO VARCHAR(50),
        @OFI_FECHA_INSCRIPCION VARCHAR(10),
        @OFI_FECHA_VENCIMIENTO VARCHAR(10),
        @OFI_FECHA_DESEMBOLSO  VARCHAR(10)
SELECT  @OFI_MONEDA_DESEMBOLSO = '',
        @OFI_FECHA_INSCRIPCION = '',
        @OFI_FECHA_VENCIMIENTO = '',
        @OFI_FECHA_DESEMBOLSO  = ''
IF (SELECT OFI_MONEDA_DESEMBOLSO FROM #PLANILLA) <> 0
   SELECT @OFI_MONEDA_DESEMBOLSO = CONVERT(CHAR( 3),ofi_moneda_desembolso) + ' - ' + mnglosa,
          @OFI_FECHA_INSCRIPCION = convert(char(10),ofi_fecha_inscripcion,103),
          @OFI_FECHA_VENCIMIENTO = convert(char(10),ofi_fecha_vencimiento,103),
          @OFI_FECHA_DESEMBOLSO  = convert(char(10),ofi_fecha_desembolso ,103)
     FROM  VIEW_MONEDA , #PLANILLA
    WHERE  ofi_moneda_desembolso = mncodmon
---------------------<< CARGA GLOSA ADUANA
DECLARE @EXP_CODIGO_ADUANA       VARCHAR(50),
        @EXP_DECLARACION_FECHA   VARCHAR(10),
        @EXP_INFORME_FECHA       VARCHAR(10),
        @EXP_FECHA_VENCE_RETORNO VARCHAR(10)
SELECT  @EXP_CODIGO_ADUANA       = '',
        @EXP_DECLARACION_FECHA   = '',
        @EXP_INFORME_FECHA       = '',
        @EXP_FECHA_VENCE_RETORNO = ''
IF (SELECT EXP_CODIGO_ADUANA FROM #PLANILLA) <> 0
   SELECT @EXP_CODIGO_ADUANA       = CONVERT(CHAR( 3),exp_codigo_aduana) + ' - ' + glosa,
          @EXP_DECLARACION_FECHA   = CONVERT(CHAR(10),exp_declaracion_fecha  ,103),
          @EXP_INFORME_FECHA    = convert(char(10),exp_informe_fecha      ,103),
          @EXP_FECHA_VENCE_RETORNO = convert(char(10),exp_fecha_vence_retorno,103)
     FROM  TBADUANAS , #PLANILLA
    WHERE  exp_codigo_aduana = codigo_numerico
---------------------<< CARGA GLOSA FORMA DE PAGO
DECLARE @IMP_FORMA_PAGO          VARCHAR(50),
        @IMP_INFORME_FECHA       VARCHAR(10),
        @IMP_EMBARQUE_FECHA      VARCHAR(10),
        @IMP_FECHA_VENCE         VARCHAR(10)
SELECT  @IMP_FORMA_PAGO     = '',
        @IMP_INFORME_FECHA  = '',
        @IMP_EMBARQUE_FECHA = '',
        @IMP_FECHA_VENCE    = ''
IF (SELECT IMP_FORMA_PAGO FROM #PLANILLA) <> 0
   SELECT @IMP_FORMA_PAGO     = CONVERT(CHAR( 3),imp_forma_pago) + ' - ' + glosa,
          @IMP_INFORME_FECHA  = convert(char(10),imp_informe_fecha ,103),
          @IMP_EMBARQUE_FECHA = convert(char(10),imp_embarque_fecha,103),
          @IMP_FECHA_VENCE    = convert(char(10),imp_fecha_vence   ,103)
     FROM  VIEW_FORMA_DE_PAGO , #PLANILLA
    WHERE  imp_forma_pago = codigo
---------------------<< CARGA GLOSA INSTRUMENTO
DECLARE @DER_INSTRUMENTO   VARCHAR(50),
        @DER_AREA_CONTABLE VARCHAR(50),
        @DER_FECHA_INICIO  VARCHAR(10),
        @DER_FECHA_VENCE   VARCHAR(10)
SELECT  @DER_INSTRUMENTO   = '',
        @DER_AREA_CONTABLE = '',
        @DER_FECHA_INICIO  = '',
        @DER_FECHA_VENCE   = ''
IF (SELECT DER_INSTRUMENTO FROM #PLANILLA) <> 0
   SELECT @DER_INSTRUMENTO  = convert(char( 3),der_instrumento) + ' - ' + glosa,
          @DER_FECHA_INICIO = convert(char(10),der_fecha_inicio,103),
          @DER_FECHA_VENCE  = convert(char(10),der_fecha_vence ,103)
     FROM  VIEW_TBINSTRUMENTODERIVADO , #PLANILLA
    WHERE  DER_INSTRUMENTO = CODIGO_NUMERICO
---------------------<< CARGA GLOSA AREA CONTABLE
IF (SELECT der_area_contable FROM #PLANILLA) <> 0
   SELECT @DER_AREA_CONTABLE = CONVERt(char(3),der_area_contable) + ' - ' + glosa,
          @DER_FECHA_INICIO = convert(char(10),der_fecha_inicio,103),
          @DER_FECHA_VENCE  = convert(char(10),der_fecha_vence ,103)
     FROM  VIEW_TBAREACONTABLE , #PLANILLA
    WHERE  der_area_contable = codigo_numerico
---------------------<< COMPLETA CODIGO + GLOSA
SELECT @TIPO_DOCUMENTO       = convert(char(3),tipo_documento      ) + ' - ' + @TIPO_DOCUMENTO,
       @TIPO_OPERACION_CAMBIO = convert(char(3),tipo_operacion_cambio) + ' - ' + @TIPO_OPERACION_CAMBIO,
       @PAIS_OPERACION       = convert(char(3),pais_operacion      ) + ' - ' + @PAIS_OPERACION,
       @OPERACION_MONEDA      = convert(char(3),operacion_moneda     ) + ' - ' + @OPERACION_MONEDA
  FROM #PLANILLA
---------------------<< CARGANDO PLANILLA >>---------------------------------
     select acnombre   ,
     'planilla_fecha '           = convert(char(10),planilla_fecha,103),
     planilla_numero  ,
     interesado_rut  ,
            interesado_dv = isnull((select cldv from VIEW_CLIENTE where clcodigo = interesado_codigo and clrut = interesado_rut),'*'),
     interesado_codigo  ,
     interesado_nombre  ,
     interesado_direccion ,
     interesado_ciudad  ,
     operacion_numero  ,
            'operacion_fecha'           = convert(char(10),operacion_fecha,103),
     'tipo_documento'            = @TIPO_DOCUMENTO      ,
     'tipo_operacion_cambio'     = @TIPO_OPERACION_CAMBIO     ,
     codigo_comercio  ,
     'concepto' =  concepto  + ' ' + @CONCEPTO  ,
     'pais_operacion'            = @PAIS_OPERACION      ,
     'operacion_moneda'          = @OPERACION_MONEDA          ,
     monto_origen  ,
     paridad   ,
     monto_dolares  ,
     tipo_cambio   ,
     monto_pesos   ,
     afecto_derivados  ,
     cantidad_acuerdos  ,
     autbcch_tipo  ,
     autbcch_numero  ,
            'aut_bcch'                  = (case autbcch_numero when 0 then '' else convert(char(10),autbcch_fecha,103) end),
     'rel_institucion'           = @REL_INSTITUCION            ,
            'rel_fecha'    = @REL_FECHA        ,
     rel_numero   ,
     rel_arbitraje  ,
ofi_numero_inscripcion ,
            'ofi_fecha_inscripcion'     = @OFI_FECHA_INSCRIPCION      ,
            'ofi_fecha_vencimiento'     = @OFI_FECHA_VENCIMIENTO      ,
     ofi_nombre_financista ,
            'ofi_fecha_desembolso'      = @OFI_FECHA_DESEMBOLSO       ,
     'ofi_moneda_desembolso'     = @OFI_MONEDA_DESEMBOLSO      ,
     ofi_monto_desembolso ,
     ofi_impuesto_adicional ,
     'exp_codigo_aduana'         = @EXP_CODIGO_ADUANA       ,
            'exp_declaracion_fecha'     = @EXP_DECLARACION_FECHA      ,
     exp_declaracion_numero ,
            'exp_informe_fecha'         = @EXP_INFORME_FECHA          ,
     exp_informe_numero  ,
            'exp_fecha_vence_retorno'   =@EXP_FECHA_VENCE_RETORNO     ,
     exp_valor_bruto  ,
     exp_comisiones  ,
     exp_otros_gastos  ,
     exp_valor_total  ,
     exp_plazo_financia  ,
     exp_nombre_comprador ,
            'imp_informe_fecha '        = @IMP_INFORME_FECHA          ,
     imp_informe_numero  ,
     imp_declaracion_numero ,
     'imp_forma_pago'            = @IMP_FORMA_PAGO       ,
     imp_embarque_numero  ,
            'imp_embarque_fecha'        = @IMP_EMBARQUE_FECHA         ,
            'imp_fecha_vence '          = @IMP_FECHA_VENCE            ,
     imp_valor_mercaderia ,
     imp_gastos_fob  ,
     imp_valor_fob  ,
     imp_flete   ,
     imp_seguro   ,
     imp_valor_cif  ,
     imp_intereses  ,
     imp_gastos_bancarios ,
     der_numero_contrato  ,
            'der_fecha_inicio '         = @DER_FECHA_INICIO            ,
            'der_fecha_vence  '         = @DER_FECHA_VENCE             ,
     'der_instrumento'           = @DER_INSTRUMENTO        , 
     der_precio_contrato  ,
     'der_area_contable '        = @DER_AREA_CONTABLE           ,
     acuerdo_codigo_1  ,
     acuerdo_numero_1  ,
     acuerdo_codigo_2  ,
     acuerdo_numero_2  ,
     acuerdo_codigo_3  ,
     acuerdo_numero_3  ,
     acuerdo_codigo_4  ,
     acuerdo_numero_4  ,
     acuerdo_codigo_5  ,
     acuerdo_numero_5  ,
     obs_1   ,
     obs_2   ,
     obs_3   ,
     'hora' = convert(char(08),getdate(),108)
           
       FROM #PLANILLA, MEAC
-- DROP TABLE #PLANILLA
--------------<< CARGANDO DETALLE DE INTERESES >>----------------------------
---------------------<< VALIDA EXISTENCIA INTERESES DE COBERTURA
IF EXISTS (SELECT planilla_numero FROM TBDETALLEINTERESES
     where planilla_numero = @PLANILLA_NUMERO
       AND planilla_fecha  = @PLANILLA_FECHA)
BEGIN
     SELECT *   INTO #DETALLE
       FROM TBDETALLEINTERESES
      where planilla_numero = @PLANILLA_NUMERO
 AND planilla_fecha  = @PLANILLA_FECHA
     DECLARE @CONCEPTO_CAPITAL     VARCHAR(50),
             @TIPO_INTERES         VARCHAR(50),
             @CODIGO_BASE_TASA     VARCHAR(50),
             @INDICA_PAGO_EXTERIOR VARCHAR(50),
      @CORRELATIVO    INTEGER    ,
      @TOTAL     INTEGER    ,
      @CONT     INTEGER
     SELECT  @TOTAL = COUNT(*) FROM #DETALLE
     SELECT  @CONT  = 1
     WHILE @CONT <= @TOTAL
     BEGIN
   SET ROWCOUNT @CONT
   SELECT @CONCEPTO_CAPITAL     = convert(char(3),concepto_capital),
   @TIPO_INTERES        = convert(char(3),tipo_interes),
   @CODIGO_BASE_TASA     = convert(char(3),codigo_base_tasa),
   @INDICA_PAGO_EXTERIOR = convert(char(3),indica_pago_exterior),
   @CORRELATIVO        = correlativo
     FROM #DETALLE
   ---------------------<< CARGA GLOSA CONCEPTO CAPITAL
   IF (SELECT concepto_capital FROM #DETALLE) <> ''
      SELECT @CONCEPTO_CAPITAL = @CONCEPTO_CAPITAL + ' - ' + glosa
        FROM  TBCONCEPTOCAPITAL , #DETALLE
       WHERE  concepto_capital = codigo_caracter
   ---------------------<< CARGA GLOSA TIPO DE INTERES
   IF (SELECT tipo_interes FROM #DETALLE) <> ''
      SELECT @TIPO_INTERES = @TIPO_INTERES + ' - ' + glosa
        FROM  TBINTERESES , #DETALLE
       WHERE  TIPO_INTERES = CODIGO_CARACTER
   ---------------------<< CARGA GLOSA BASE DE TASA
IF (SELECT codigo_base_tasa FROM #DETALLE) <> 0
      SELECT @CODIGO_BASE_TASA = @CODIGO_BASE_TASA + ' - ' + glosa
        FROM  TBBASESTASA , #DETALLE
       WHERE  codigo_base_tasa = codigo_numerico
   ---------------------<< CARGA GLOSA PAGO EN EL EXTERIOR
   IF (SELECT indica_pago_exterior FROM #DETALLE) <> 0
      SELECT @INDICA_PAGO_EXTERIOR = SUbstring(rtrim(codigo_caracter),1,10)
        FROM  TBPAGOEXTERIOR , #DETALLE
       where  indica_pago_exterior = codigo_numerico
   ------------------<< CARGANDO DETALLE >>------------------------
          insert RPTDETALLEINTERESES
                (
            planilla_fecha      ,
        planilla_numero   ,
        correlativo        ,
        concepto_capital   ,        
        capital            ,
        tipo_interes       ,       
        codigo_base_tasa   ,    
        tasa_interes_anual  ,
        fecha_inicial   , 
        fecha_final   ,
        monto_interes   ,
                      dias    ,
        indica_pago_exterior
                    )
               SELECT 
                    convert(char(10),planilla_fecha,103),
                    planilla_numero         ,
                    correlativo             ,
                    @CONCEPTO_CAPITAL       ,
                    CAPITAL                 ,
                    @TIPO_INTERES           ,
                    @codigo_base_tasa       ,
      tasa_interes_anual  ,                    
                    convert(char(10),fecha_inicial ,103),
                    convert(char(10),fecha_final   ,103),
                    convert(numeric(8),convert(char(8),fecha_final,112)) - convert(numeric(8),convert(char(8),fecha_inicial,112)),
                    monto_interes           ,
                    @INDICA_PAGO_EXTERIOR
/*                    'PLANILLA_FECHA'   = @PLANILLA_FECHA   ,
      'PLANILLA_NUMERO'   = @PLANILLA_NUMERO  ,
      'CORRELATIVO'       = @CORRELATIVO      ,
        'CONCEPTO_CAPITAL'  = @CONCEPTO_CAPITAL ,        
        CAPITAL              ,
        'TIPO_INTERES'      = @TIPO_INTERES     ,       
        'CODIGO_BASE_TASA'  = @CODIGO_BASE_TASA ,    
        TASA_INTERES_ANUAL  ,
        'FECHA_INICIAL'   = CONVERT(CHAR(10),FECHA_INICIAL ,103), 
        'FECHA_FINAL'   = CONVERT(CHAR(10),FECHA_FINAL   ,103),
        MONTO_INTERES       ,
                      DIAS    ,
        @INDICA_PAGO_EXTERIOR*/
                 FROM #DETALLE
  WHERE correlativo = @CORRELATIVO
   SELECT @CONT = @CONT + 1
     END  -- WHILE
     SET ROWCOUNT 0
     -- DROP TABLE #DETALLE
END -- DETALLE DE INTERESES
ELSE
    INSERT INTO RPTDETALLEINTERESES VALUES( '',0,0,'',0,'','',0,'','',0,0,'')
--------------------------------<< FIN DE PROCESO >>-------------------------
-- SELECT * FROM RPTPLANILLAS
SET NOCOUNT OFF
END
GO
