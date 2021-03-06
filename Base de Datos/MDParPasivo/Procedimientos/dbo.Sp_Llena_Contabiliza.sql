USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Llena_Contabiliza]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[Sp_Llena_Contabiliza]
            ( @fecha_hoy       DATETIME
            , @fecha_Anterior  DATETIME
            , @fecha_Cierre    DATETIME
            , @id_sistema      CHAR(3)
            , @producto        VARCHAR(5)
            , @limpiacnt       NUMERIC(1)
           )
AS

BEGIN

    SET NOCOUNT ON

    SET DATEFORMAT dmy

   DECLARE @control_error	INTEGER
   DECLARE @fecha_proceso	DATETIME
   DECLARE @error	VARCHAR(512)

   SELECT  @fecha_proceso = Fecha_proceso FROM VIEW_DATOS_GENERALES
   SELECT  @error = 'SIN ERRORES'


/* ======================================================================================== */
/* limpia archivo de contabilizacion                                                        */
/* ======================================================================================== */

   IF @limpiacnt = 1
   BEGIN

        IF EXISTS ( SELECT * FROM TEMPDB..SYSOBJECTS WHERE NAME='##CONTABILIZA' ) BEGIN
            DROP TABLE [DBO].[##CONTABILIZA]
        END

        CREATE TABLE DBO.##CONTABILIZA(
                                 id_sistema	            CHAR   (3 )                                
                                ,cProducto                  VARCHAR(07)
                                ,cTipo_Plazo                VARCHAR(01)
                                ,cFinanciamiento            VARCHAR(03) 
                                ,cCodigo_Sector             VARCHAR(01)
                                ,cCodigo_Subsector          VARCHAR(02)
                                ,cBanco_Corresponsal        VARCHAR(05)
                                ,cStatus_Cuota              VARCHAR(01)
                                ,cStatus_Colocacion         VARCHAR(01)
                                ,cReajustabilidad           VARCHAR(01)
                                ,cDivisa                    VARCHAR(03)
                                ,cTipo_Divisa               VARCHAR(01)
------------------------------------------------------------------------------
                                ,valor_compra	            FLOAT DEFAULT 0
                                ,valor_presente	            FLOAT DEFAULT 0
                                ,valor_venta	            FLOAT DEFAULT 0
                                ,utilidad	            FLOAT DEFAULT 0
                                ,perdida	            FLOAT DEFAULT 0
                                ,interes_papel	            FLOAT DEFAULT 0
                                ,reajuste_papel	            FLOAT DEFAULT 0
                                ,interes_pacto	            FLOAT DEFAULT 0
                                ,reajuste_pacto	            FLOAT DEFAULT 0
                                ,valor_cupon	            FLOAT DEFAULT 0
                                ,nominalpesos	            FLOAT DEFAULT 0
                                ,nominal	            FLOAT DEFAULT 0
                                ,valor_comprahis	    FLOAT DEFAULT 0
                                ,dif_ant_pacto_pos	    FLOAT DEFAULT 0
                                ,dif_ant_pacto_neg	    FLOAT DEFAULT 0
                                ,dif_valor_mercado_pos	    FLOAT DEFAULT 0
                                ,dif_valor_mercado_neg	    FLOAT DEFAULT 0
                                ,rev_valor_mercado_pos	    FLOAT DEFAULT 0
                                ,rev_valor_mercado_neg	    FLOAT DEFAULT 0
                                ,valor_futuro	            FLOAT DEFAULT 0
                                ,Valor_perdida_usd	    NUMERIC	(19,4) DEFAULT 0
                                ,Valor_utilidad_usd	    NUMERIC	(19,4) DEFAULT 0
                                ,Valor_perdida_clp	    NUMERIC	(19) DEFAULT 0
                                ,Valor_utilidad_clp	    NUMERIC	(19) DEFAULT 0
                                ,pago_parcial		    FLOAT DEFAULT 0
                                ,recaudacion_parcial	    FLOAT DEFAULT 0
				,diferencia_recibida	    FLOAT DEFAULT 0
				,swp_utilidad_mercado		FLOAT DEFAULT 0
				,swp_perdida_mercado		FLOAT DEFAULT 0
				,swp_capital_moneda1		FLOAT DEFAULT 0
				,swp_capital_moneda2		FLOAT DEFAULT 0
				,swp_diferencia_cambio		FLOAT DEFAULT 0
				,swp_diferencia_recibida	FLOAT DEFAULT 0
				,swp_diferencia_recibida_CP	FLOAT DEFAULT 0
				,swp_diferencia_recibida_SP	FLOAT DEFAULT 0
				,swp_diferencia_recibida_LB	FLOAT DEFAULT 0
				,swp_entrega_principales_m1	FLOAT DEFAULT 0
				,swp_entrega_principales_m2	FLOAT DEFAULT 0
				,swp_interes_cobrado		FLOAT DEFAULT 0
				,swp_interes_cobrado_SP		FLOAT DEFAULT 0
				,swp_interes_cobrado_CP		FLOAT DEFAULT 0
				,swp_interes_cobrado_LB		FLOAT DEFAULT 0
				,swp_interes_pagado		FLOAT DEFAULT 0
				,swp_interes_pagado_SP		FLOAT DEFAULT 0
				,swp_interes_pagado_CP		FLOAT DEFAULT 0
				,swp_interes_pagado_LB		FLOAT DEFAULT 0
				,swp_perd_dif_pre_CP		FLOAT DEFAULT 0
				,swp_perd_dif_pre_SP		FLOAT DEFAULT 0
				,swp_perd_dif_pre_LB		FLOAT DEFAULT 0
				,swp_perd_diferida		FLOAT DEFAULT 0
				,swp_diferencia_contra		FLOAT DEFAULT 0
				,swp_dif_pagada_SP		FLOAT DEFAULT 0
				,swp_dif_pagada_CP		FLOAT DEFAULT 0
				,swp_dif_pagada_LB		FLOAT DEFAULT 0
				,swp_reajuste_dev		FLOAT DEFAULT 0
				,swp_reajuste			FLOAT DEFAULT 0
				,swp_util_dif_pre_CP		FLOAT DEFAULT 0
				,swp_util_dif_pre_SP		FLOAT DEFAULT 0
				,swp_util_dif_pre_LB		FLOAT DEFAULT 0
				,swp_util_diferida		FLOAT DEFAULT 0
				,swp_dif_recibida_SP		FLOAT DEFAULT 0
				,swp_dif_recibida_CP		FLOAT DEFAULT 0
				,swp_dif_recibida_LB		FLOAT DEFAULT 0
				,swp_diferencia_favor		FLOAT DEFAULT 0
				,fwd_capital_mx1		FLOAT DEFAULT 0
				,fwd_capital_mx2		FLOAT DEFAULT 0
				,fwd_dif_cambio			FLOAT DEFAULT 0
				,fwd_dif_pago_cp		FLOAT DEFAULT 0
				,fwd_dif_pago_sp		FLOAT DEFAULT 0
				,fwd_dif_pago_lb		FLOAT DEFAULT 0
				,fwd_perdida_cp			FLOAT DEFAULT 0
				,fwd_perdida_sp			FLOAT DEFAULT 0
				,fwd_perdida_lb			FLOAT DEFAULT 0
				,fwd_utilidad_cp		FLOAT DEFAULT 0
				,fwd_utilidad_sp		FLOAT DEFAULT 0
				,fwd_utilidad_lb		FLOAT DEFAULT 0
				,fwd_difpre_util		FLOAT DEFAULT 0
				,fwd_difval_util		FLOAT DEFAULT 0
				,fwd_difpre_Perd		FLOAT DEFAULT 0
				,fwd_difval_Perd		FLOAT DEFAULT 0
				,fwd_difpre_util_rv		NUMERIC(19,4) DEFAULT 0
				,fwd_difpre_Perd_rv		NUMERIC(19,4) DEFAULT 0
				,fwd_reajuste			NUMERIC(19,4) DEFAULT 0


------------------------------------------------------------------------------
                                ,tipo_cuenta                CHAR        (1)
                                ,cproductor                 VARCHAR     (7)
                                ,codigo_evento              CHAR        (3)
                                ,codigo_moneda1             INTEGER
                                ,codigo_moneda2             INTEGER
                                ,codigo_instrumento         INTEGER
                                ,numero_operacion           NUMERIC(10)
                                ,numero_documento           NUMERIC(10)
                                ,correlativo                NUMERIC(3)
                                ,forma_pago                 INTEGER
                                ,rut                        NUMERIC(9)
                                ,Codigo_Operacion           CHAR(3)  --codigo ISO de la Moneda
                                ,mercado                    NUMERIC(1)
                                ,fecha_contable             DATETIME --Para proceso de fin de mes especial
				,archivo_proceso	    CHAR(3)		DEFAULT ''
				,fecha_historica	    DATETIME		DEFAULT ''
				,tipoper		    CHAR(5)		DEFAULT ''
				,tipopero		    CHAR(5)		DEFAULT ''
				,cartera		    CHAR(5)		DEFAULT ''
                                ,numero_SPOT		    NUMERIC(10)		DEFAULT 0
				,fecha_referencia           CHAR(08)		DEFAULT ''
                                ,sucursal_contable          NUMERIC(5)          DEFAULT 87
				,csistema_orig			CHAR(3)		DEFAULT ''
				,cproducto_orig			CHAR(3)		DEFAULT ''
                                )

   END 



	IF @@error <> 0
	BEGIN
		PRINT 'ERROR_PROC FALLA BORRANDO ARCHIVO CONTABILIZA (RENTA FIJA).'
		RETURN 1
	END


/* ======================================================================================== */
/* llena renta fija operaciones                                                             */
/* ======================================================================================== */


IF @id_sistema = 'BTR' BEGIN


	IF @producto = 'RP'	EXECUTE	SP_Llena_Contabiliza_BTR_REPOS
					@fecha_hoy       
				,	@fecha_Anterior  
				,	@fecha_Cierre    
				,	@producto        
				,	@error            OUTPUT
				 
	ELSE 
		IF @producto = 'FLP'	EXECUTE	SP_Llena_Contabiliza_BTR_FLP
						@fecha_hoy       
					,	@fecha_Anterior  
					,	@fecha_Cierre    
					,	@producto        
					,	@error            OUTPUT
				
		ELSE 
			IF @producto = 'FPD'	EXECUTE	SP_Llena_Contabiliza_BTR_FPD
							@fecha_hoy       
						,	@fecha_Anterior  
						,	@fecha_Cierre    
						,	@producto        
						,	@error            OUTPUT

						
			ELSE			EXECUTE	SP_Llena_Contabiliza_BTR
							@fecha_hoy       
						,	@fecha_Anterior  
						,	@fecha_Cierre    
						,	@producto        
						,	@error            OUTPUT
						
	SELECT	@error            

END


/* ======================================================================================== */
/* MOVIMIENTOS DE SPOT                                      				*/
/* ======================================================================================== */


IF @id_sistema = 'BCC' BEGIN

	IF @producto = 'OVER'	
		EXECUTE SP_Llena_Contabiliza_BCC_OVER
			@fecha_hoy       
			, @fecha_Anterior  
			, @fecha_Cierre    
			, @producto        
			, @error            OUTPUT

	ELSE	EXECUTE SP_Llena_Contabiliza_BCC
			@fecha_hoy       
			, @fecha_Anterior  
			, @fecha_Cierre    
			, @producto        
			, @error            OUTPUT

      SELECT @error            

--   END

END


/* ======================================================================================== */
/* MOVIMIENTOS DE FUTUROS Y DERIVADOS                                                                      */
/* ======================================================================================== */


IF @id_sistema = 'BFW' BEGIN


	IF @producto = '2'	EXECUTE	SP_Llena_Contabiliza_BFW_MXMX
					@fecha_hoy       
				,	@fecha_Anterior  
				,	@fecha_Cierre    
				,	@producto        
				,	@error	OUTPUT
	ELSE IF @producto = '7'
				EXECUTE	SP_Llena_Contabiliza_BFW_FBT
					@fecha_hoy       
				,	@fecha_Anterior  
				,	@fecha_Cierre    
				,	@producto        
				,	@error	OUTPUT
	ELSE			EXECUTE	SP_Llena_Contabiliza_BFW
					@fecha_hoy       
				,	@fecha_Anterior  
				,	@fecha_Cierre    
				,	@producto        
				,	@error	OUTPUT

      SELECT @error            


END


/* ======================================================================================== */
/* MOVIMIENTOS DE SWAP                                                                      */
/* ======================================================================================== */


IF @id_sistema = 'SWP' BEGIN

	IF @producto = 'ST'		EXECUTE SP_Llena_Contabiliza_SWP_ST
						@fecha_hoy       
					,	@fecha_Anterior  
					,	@fecha_Cierre    
					,	@producto        
					,	@error	OUTPUT

	ELSE IF @producto = 'SM'	EXECUTE SP_Llena_Contabiliza_SWP_SM
						@fecha_hoy
					,	@fecha_Anterior
					,	@fecha_Cierre
					,	@producto
			        	,	@error	OUTPUT

	ELSE IF @producto = 'SC'	EXECUTE SP_Llena_Contabiliza_SWP_SC
						@fecha_hoy
					,	@fecha_Anterior
					,	@fecha_Cierre
					,	@producto
			        	,	@error	OUTPUT


      SELECT @error            

END


/* ======================================================================================== */
/* llena inversiones exterior operaciones                                                   */
/* ======================================================================================== */


IF @id_sistema = 'INV' BEGIN

      EXECUTE SP_Llena_Contabiliza_INV
                 @fecha_hoy       
               , @fecha_Anterior  
               , @fecha_Cierre    
               , @producto        
               , @error            OUTPUT

      SELECT @error            

END

/* ======================================================================================== */
/* Llena Pasivo operaciones                                                                 */
/* ======================================================================================== */

IF @id_sistema = 'PSV' BEGIN

      EXECUTE SP_Llena_Contabiliza_PAS
                 @fecha_hoy       
               , @fecha_Anterior  
               , @fecha_Cierre    
               , @producto        
               , @error            OUTPUT

      SELECT @error            

END

/* ======================================================================================== */
/* Llena Valorizacion Mercado                                                               */
/* ======================================================================================== */

IF @id_sistema = 'SVL' BEGIN

	IF @producto = 'VRF'		EXECUTE SP_Llena_Contabiliza_VAL
						@fecha_hoy       
					,	@fecha_Anterior  
					,	@fecha_Cierre    
					,	@producto        
					,	@error            OUTPUT
	ELSE IF @producto = 'VDR'	EXECUTE SP_Llena_Contabiliza_VAL_DRV
						@fecha_hoy       
					,	@fecha_Anterior  
					,	@fecha_Cierre    
					,	@producto        
					,	@error            OUTPUT

      SELECT @error            

END


	UPDATE	##CONTABILIZA
	SET	cDivisa = LEFT(b.mnsimbol,3)
	FROM	VIEW_MONEDA A,
		VIEW_MONEDA B
	WHERE	a.mnsimbol = cDivisa
	AND	a.canasta = 'S'
	AND	b.mncodmon = a.moneda_canasta


	UPDATE	##CONTABILIZA
	SET	codigo_operacion = LEFT(b.mnsimbol,3)
	FROM	VIEW_MONEDA A,
		VIEW_MONEDA B
	WHERE	a.mnsimbol = codigo_operacion
	AND	a.canasta = 'S'
	AND	b.mncodmon = a.moneda_canasta


	UPDATE	##CONTABILIZA
	SET	codigo_moneda1 = a.moneda_canasta
	FROM	VIEW_MONEDA A
	WHERE	a.mncodmon = codigo_moneda1
	AND	a.canasta = 'S'


	UPDATE	##CONTABILIZA
	SET	codigo_moneda2 = a.moneda_canasta
	FROM	VIEW_MONEDA A
	WHERE	a.mncodmon = codigo_moneda2
	AND	a.canasta = 'S'


/*

SELECT	
id_sistema,
cProducto,
cTipo_Plazo,
cFinanciamiento,
cCodigo_Sector,
cCodigo_Subsector,
cBanco_Corresponsal,
cStatus_Cuota,
cStatus_Colocacion,
cReajustabilidad,
cDivisa,
cTipo_Divisa,
valor_compra=SUM(valor_compra),
valor_presente=SUM(valor_presente),
valor_venta=SUM(valor_venta),
utilidad=SUM(utilidad),
perdida=SUM(perdida),
interes_papel=SUM(interes_papel),
reajuste_papel=SUM(reajuste_papel),
interes_pacto=SUM(interes_pacto),
reajuste_pacto=SUM(reajuste_pacto),
valor_cupon=SUM(valor_cupon),
nominalpesos=SUM(nominalpesos),
nominal=SUM(nominal),
valor_comprahis=SUM(valor_comprahis),
dif_ant_pacto_pos=SUM(dif_ant_pacto_pos),
dif_ant_pacto_neg=SUM(dif_ant_pacto_neg),
dif_valor_mercado_pos=SUM(dif_valor_mercado_pos),
dif_valor_mercado_neg=SUM(dif_valor_mercado_neg),
rev_valor_mercado_pos=SUM(rev_valor_mercado_pos),
rev_valor_mercado_neg=SUM(rev_valor_mercado_neg),
valor_futuro=SUM(valor_futuro),
Valor_perdida_usd=SUM(Valor_perdida_usd),
Valor_utilidad_usd=SUM(Valor_utilidad_usd),
Valor_perdida_clp=SUM(Valor_perdida_clp),
Valor_utilidad_clp=SUM(Valor_utilidad_clp),
swp_utilidad_mercado=SUM(swp_utilidad_mercado),
swp_perdida_mercado=SUM(swp_perdida_mercado),
swp_capital_moneda1=SUM(swp_capital_moneda1),
swp_capital_moneda2=SUM(swp_capital_moneda2),
swp_diferencia_cambio=SUM(swp_diferencia_cambio),
swp_diferencia_recibida=SUM(swp_diferencia_recibida),
swp_diferencia_recibida_CP=SUM(swp_diferencia_recibida_CP),
swp_diferencia_recibida_SP=SUM(swp_diferencia_recibida_SP),
swp_diferencia_recibida_LB=SUM(swp_diferencia_recibida_LB),
swp_entrega_principales_m1=SUM(swp_entrega_principales_m1),
swp_entrega_principales_m2=SUM(swp_entrega_principales_m2),
swp_interes_cobrado=SUM(swp_interes_cobrado),
swp_interes_cobrado_SP=SUM(swp_interes_cobrado_SP),
swp_interes_cobrado_CP=SUM(swp_interes_cobrado_CP),
swp_interes_cobrado_LB=SUM(swp_interes_cobrado_LB),
swp_interes_pagado=SUM(swp_interes_pagado),
swp_interes_pagado_SP=SUM(swp_interes_pagado_SP),
swp_interes_pagado_CP=SUM(swp_interes_pagado_CP),
swp_interes_pagado_LB=SUM(swp_interes_pagado_LB),
swp_perd_dif_pre_CP=SUM(swp_perd_dif_pre_CP),
swp_perd_dif_pre_SP=SUM(swp_perd_dif_pre_SP),
swp_perd_dif_pre_LB=SUM(swp_perd_dif_pre_LB),
swp_perd_diferida=SUM(swp_perd_diferida),
swp_diferencia_contra=SUM(swp_diferencia_contra),
swp_dif_pagada_SP=SUM(swp_dif_pagada_SP),
swp_dif_pagada_CP=SUM(swp_dif_pagada_CP),
swp_dif_pagada_LB=SUM(swp_dif_pagada_LB),
swp_reajuste_dev=SUM(swp_reajuste_dev),
swp_reajuste=SUM(swp_reajuste),
swp_util_dif_pre_CP=SUM(swp_util_dif_pre_CP),
swp_util_dif_pre_SP=SUM(swp_util_dif_pre_SP),
swp_util_dif_pre_LB=SUM(swp_util_dif_pre_LB),
swp_util_diferida=SUM(swp_util_diferida),
swp_dif_recibida_SP=SUM(swp_dif_recibida_SP),
swp_dif_recibida_CP=SUM(swp_dif_recibida_CP),
swp_dif_recibida_LB=SUM(swp_dif_recibida_LB),
swp_diferencia_favor=SUM(swp_diferencia_favor),
pago_parcial=SUM(pago_parcial),
recaudacion_parcial=SUM(recaudacion_parcial),
diferencia_recibida=SUM(diferencia_recibida),
fwd_capital_mx1=SUM(fwd_capital_mx1),
fwd_capital_mx2=SUM(fwd_capital_mx2),
fwd_dif_cambio=SUM(fwd_dif_cambio),
fwd_dif_pago_cp=SUM(fwd_dif_pago_cp),
fwd_dif_pago_sp=SUM(fwd_dif_pago_sp),
fwd_dif_pago_lb=SUM(fwd_dif_pago_lb),
fwd_perdida_cp=SUM(fwd_perdida_cp),
fwd_perdida_sp=SUM(fwd_perdida_sp),
fwd_perdida_lb=SUM(fwd_perdida_lb),
fwd_utilidad_cp=SUM(fwd_utilidad_cp),
fwd_utilidad_sp=SUM(fwd_utilidad_sp),
fwd_utilidad_lb=SUM(fwd_utilidad_lb),
fwd_difpre_util=SUM(fwd_difpre_util),
fwd_difval_util=SUM(fwd_difval_util),
fwd_difpre_Perd=SUM(fwd_difpre_Perd),
fwd_difval_Perd=SUM(fwd_difval_Perd),
fwd_difpre_util_rv=SUM(fwd_difpre_util_rv),
fwd_difpre_Perd_rv=SUM(fwd_difpre_Perd_rv),
fwd_reajuste=SUM(fwd_reajuste),
tipo_cuenta,
cproductor,
codigo_evento,
codigo_moneda1,
codigo_moneda2,
codigo_instrumento,
numero_operacion,
numero_documento,
correlativo,
forma_pago,
rut,
Codigo_Operacion,
mercado,
fecha_contable,
archivo_proceso,
fecha_historica,
tipoper,
tipoperO,
cartera,
numero_SPOT,
fecha_referencia,
sucursal_contable,
csistema_orig,
cproducto_orig,
contador = COUNT(*)
INTO	#TMP1
FROM 	##CONTABILIZA
GROUP BY 
id_sistema,
cProducto,
cTipo_Plazo,
cFinanciamiento,
cCodigo_Sector,
cCodigo_Subsector,
cBanco_Corresponsal,
cStatus_Cuota,
cStatus_Colocacion,
cReajustabilidad,
cDivisa,
cTipo_Divisa,
tipo_cuenta,
cproductor,
codigo_evento,
codigo_moneda1,
codigo_moneda2,
codigo_instrumento,
numero_operacion,
numero_documento,
correlativo,
forma_pago,
rut,
Codigo_Operacion,
mercado,
fecha_contable,
archivo_proceso,
fecha_historica,
tipoper,
tipoperO,
cartera,
numero_SPOT,
fecha_referencia,
sucursal_contable,
csistema_orig,
cproducto_orig 


--drop table #tmp1
--select * from #tmp1

DELETE #TMP1 WHERE CONTADOR = 1


DELETE	A
FROM	##CONTABILIZA A,
	#TMP1 B
WHERE	
A.id_sistema = B.id_sistema
AND A.cProducto = B.cProducto
AND A.cTipo_Plazo = B.cTipo_Plazo
AND A.cFinanciamiento = B.cFinanciamiento
AND A.cCodigo_Sector = B.cCodigo_Sector
AND A.cCodigo_Subsector = B.cCodigo_Subsector
AND A.cBanco_Corresponsal = B.cBanco_Corresponsal
AND A.cStatus_Cuota = B.cStatus_Cuota
AND A.cStatus_Colocacion = B.cStatus_Colocacion
AND A.cReajustabilidad = B.cReajustabilidad
AND A.cDivisa = B.cDivisa
AND A.cTipo_Divisa = B.cTipo_Divisa
AND A.tipo_cuenta = B.tipo_cuenta
AND A.cproductor = B.cproductor
AND A.codigo_evento = B.codigo_evento
AND A.codigo_moneda1 = B.codigo_moneda1
AND A.codigo_moneda2 = B.codigo_moneda2
AND A.codigo_instrumento = B.codigo_instrumento
AND A.numero_operacion = B.numero_operacion
AND A.numero_documento = B.numero_documento
AND A.correlativo = B.correlativo
AND A.forma_pago = B.forma_pago
AND A.rut = B.rut
AND A.Codigo_Operacion = B.Codigo_Operacion
AND A.mercado = B.mercado
AND A.fecha_contable = B.fecha_contable
AND A.archivo_proceso = B.archivo_proceso
AND A.fecha_historica = B.fecha_historica
AND A.tipoper = B.tipoper
AND A.tipoperO = B.tipoperO
AND A.cartera = B.cartera
AND A.numero_SPOT = B.numero_SPOT
AND A.fecha_referencia = B.fecha_referencia
AND A.sucursal_contable = B.sucursal_contable
AND A.csistema_orig = B.csistema_orig
AND A.cproducto_orig = B.cproducto_orig


INSERT INTO ##contabiliza
SELECT 
id_sistema,
cProducto,
cTipo_Plazo,
cFinanciamiento,
cCodigo_Sector,
cCodigo_Subsector,
cBanco_Corresponsal,
cStatus_Cuota,
cStatus_Colocacion,
cReajustabilidad,
cDivisa,
cTipo_Divisa,
valor_compra=valor_compra,
valor_presente=valor_presente,
valor_venta=valor_venta,
utilidad=utilidad,
perdida=perdida,
interes_papel=interes_papel,
reajuste_papel=reajuste_papel,
interes_pacto=interes_pacto,
reajuste_pacto=reajuste_pacto,
valor_cupon=valor_cupon,
nominalpesos=nominalpesos,
nominal=nominal,
valor_comprahis=valor_comprahis,
dif_ant_pacto_pos=dif_ant_pacto_pos,
dif_ant_pacto_neg=dif_ant_pacto_neg,
dif_valor_mercado_pos=dif_valor_mercado_pos,
dif_valor_mercado_neg=dif_valor_mercado_neg,
rev_valor_mercado_pos=rev_valor_mercado_pos,
rev_valor_mercado_neg=rev_valor_mercado_neg,
valor_futuro=valor_futuro,
Valor_perdida_usd=Valor_perdida_usd,
Valor_utilidad_usd=Valor_utilidad_usd,
Valor_perdida_clp=Valor_perdida_clp,
Valor_utilidad_clp=Valor_utilidad_clp,
swp_utilidad_mercado=swp_utilidad_mercado,
swp_perdida_mercado=swp_perdida_mercado,
swp_capital_moneda1=swp_capital_moneda1,
swp_capital_moneda2=swp_capital_moneda2,
swp_diferencia_cambio=swp_diferencia_cambio,
swp_diferencia_recibida=swp_diferencia_recibida,
swp_diferencia_recibida_CP=swp_diferencia_recibida_CP,
swp_diferencia_recibida_SP=swp_diferencia_recibida_SP,
swp_diferencia_recibida_LB=swp_diferencia_recibida_LB,
swp_entrega_principales_m1=swp_entrega_principales_m1,
swp_entrega_principales_m2=swp_entrega_principales_m2,
swp_interes_cobrado=swp_interes_cobrado,
swp_interes_cobrado_SP=swp_interes_cobrado_SP,
swp_interes_cobrado_CP=swp_interes_cobrado_CP,
swp_interes_cobrado_LB=swp_interes_cobrado_LB,
swp_interes_pagado=swp_interes_pagado,
swp_interes_pagado_SP=swp_interes_pagado_SP,
swp_interes_pagado_CP=swp_interes_pagado_CP,
swp_interes_pagado_LB=swp_interes_pagado_LB,
swp_perd_dif_pre_CP=swp_perd_dif_pre_CP,
swp_perd_dif_pre_SP=swp_perd_dif_pre_SP,
swp_perd_dif_pre_LB=swp_perd_dif_pre_LB,
swp_perd_diferida=swp_perd_diferida,
swp_diferencia_contra=swp_diferencia_contra,
swp_dif_pagada_SP=swp_dif_pagada_SP,
swp_dif_pagada_CP=swp_dif_pagada_CP,
swp_dif_pagada_LB=swp_dif_pagada_LB,
swp_reajuste_dev=swp_reajuste_dev,
swp_reajuste=swp_reajuste,
swp_util_dif_pre_CP=swp_util_dif_pre_CP,
swp_util_dif_pre_SP=swp_util_dif_pre_SP,
swp_util_dif_pre_LB=swp_util_dif_pre_LB,
swp_util_diferida=swp_util_diferida,
swp_dif_recibida_SP=swp_dif_recibida_SP,
swp_dif_recibida_CP=swp_dif_recibida_CP,
swp_dif_recibida_LB=swp_dif_recibida_LB,
swp_diferencia_favor=swp_diferencia_favor,
pago_parcial=pago_parcial,
recaudacion_parcial=recaudacion_parcial,
diferencia_recibida=diferencia_recibida,
fwd_capital_mx1=fwd_capital_mx1,
fwd_capital_mx2=fwd_capital_mx2,
fwd_dif_cambio=fwd_dif_cambio,
fwd_dif_pago_cp=fwd_dif_pago_cp,
fwd_dif_pago_sp=fwd_dif_pago_sp,
fwd_dif_pago_lb=fwd_dif_pago_lb,
fwd_perdida_cp=fwd_perdida_cp,
fwd_perdida_sp=fwd_perdida_sp,
fwd_perdida_lb=fwd_perdida_lb,
fwd_utilidad_cp=fwd_utilidad_cp,
fwd_utilidad_sp=fwd_utilidad_sp,
fwd_utilidad_lb=fwd_utilidad_lb,
fwd_difpre_util=fwd_difpre_util,
fwd_difval_util=fwd_difval_util,
fwd_difpre_Perd=fwd_difpre_Perd,
fwd_difval_Perd=fwd_difval_Perd,
fwd_difpre_util_rv=fwd_difpre_util_rv,
fwd_difpre_Perd_rv=fwd_difpre_Perd_rv,
fwd_reajuste=fwd_reajuste,
tipo_cuenta,
cproductor,
codigo_evento,
codigo_moneda1,
codigo_moneda2,
codigo_instrumento,
numero_operacion,
numero_documento,
correlativo,
forma_pago,
rut,
Codigo_Operacion,
mercado,
fecha_contable,
archivo_proceso,
fecha_historica,
tipoper,
tipoperO,
cartera,
numero_SPOT,
fecha_referencia,
sucursal_contable,
csistema_orig,
cproducto_orig
from #tmp1

*/

	SET NOCOUNT ON

END

GO
