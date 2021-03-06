USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_INICIO_DIA_PSV]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACT_INICIO_DIA_PSV]
   				(   @id_fecpro   CHAR(08)
				,   @id_fecprx   CHAR(08)
				)
AS
BEGIN 

   SET DATEFORMAT dmy
   SET NOCOUNT ON


DECLARE @dfecha_proceso 	DATETIME
,	@dfecha_proximo		DATETIME
,	@dfecha_anterior	DATETIME

	SELECT @dfecha_proceso = CONVERT(DATETIME,@id_fecpro)
	SELECT @dfecha_proximo = CONVERT(DATETIME,@id_fecprx)
	SELECT @dfecha_anterior= fecha_proceso FROM VIEW_DATOS_GENERALES

	EXEC SP_DEVENGO_CREDITOS @dfecha_proceso, @dfecha_proximo, 'CORFO', 'S'
	EXEC SP_DEVENGO_CREDITOS @dfecha_proceso, @dfecha_proximo, 'LOCAL', 'S'
--	EXEC SP_DEVENGO_CREDITOS @dfecha_proceso, @dfecha_proximo, 'EXTRA', 'S'

	UPDATE CARTERA_PASIVO 
	SET 	CARTERA_PASIVO.interes_emision  	= RESULTADO_PASIVO.interesdiaemision + RESULTADO_PASIVO.interes_acumulado
	,	CARTERA_PASIVO.reajuste_emision 	= RESULTADO_PASIVO.reajustediaemision + RESULTADO_PASIVO.reajuste_acumulado
	,	CARTERA_PASIVO.interes_colocacion 	= RESULTADO_PASIVO.interesdiacolocacion + RESULTADO_PASIVO.interes_acum_colocacion
	,	CARTERA_PASIVO.reajuste_colocacion 	= RESULTADO_PASIVO.reajustediacolocacion + RESULTADO_PASIVO.reajuste_acum_colocacion
	,	CARTERA_PASIVO.valor_emision_um		= RESULTADO_PASIVO.valor_emision_um
	,	CARTERA_PASIVO.valor_emision_pesos	= RESULTADO_PASIVO.valor_emision--_pesos
	,	CARTERA_PASIVO.valor_colocacion_um	= RESULTADO_PASIVO.valor_colocacion_um
	,	CARTERA_PASIVO.valor_colocacion_clp	= RESULTADO_PASIVO.valor_colocacion--_pesos
	,	CARTERA_PASIVO.presente_emision		= RESULTADO_PASIVO.valor_proximaemision
	,	CARTERA_PASIVO.presente_colocacion	= RESULTADO_PASIVO.valor_proximacolocacion
	,	CARTERA_PASIVO.fecha_proximo_cupon 	= RESULTADO_PASIVO.fecha_proximo_cupon
	,	CARTERA_PASIVO.fecha_anterior_cupon	= RESULTADO_PASIVO.fecha_ultimo_cupon
        ,       CARTERA_PASIVO.premio_acum   	        = CARTERA_PASIVO.premio_acum + RESULTADO_PASIVO.prima_interesdia
        ,       CARTERA_PASIVO.descto_acum              = CARTERA_PASIVO.descto_acum + RESULTADO_PASIVO.descuento_interesdia   	        
	,	CARTERA_PASIVO.descuento                = CARTERA_PASIVO.presente_colocacion - CARTERA_PASIVO.presente_emision
	FROM	RESULTADO_PASIVO	
	WHERE	CARTERA_PASIVO.numero_operacion		= RESULTADO_PASIVO.numero_operacion
	AND	CARTERA_PASIVO.numero_correlativo	= RESULTADO_PASIVO.numero_correlativo
	AND	RESULTADO_PASIVO.fecha_proxima 		= @dfecha_proximo
	AND	RESULTADO_PASIVO.tipo_operacion		= 'DEV'


	IF @@ERROR<>0
	BEGIN
--		ROLLBACK TRANSACTION
		SELECT 1,'Problema al actualizar Pasivo'
		RETURN
	END


	UPDATE  CARTERA_PASIVO SET
		CARTERA_PASIVO.interes_emision  = 0,
		CARTERA_PASIVO.reajuste_emision = ROUND((CARTERA_PASIVO.presente_emision - CARTERA_PASIVO.valor_emision_pesos),0)
	FROM	RESULTADO_PASIVO
	,	CARTERA_PASIVO
	WHERE	CARTERA_PASIVO.numero_operacion		= RESULTADO_PASIVO.numero_operacion
	AND	CARTERA_PASIVO.numero_correlativo	= RESULTADO_PASIVO.numero_correlativo
	AND	RESULTADO_PASIVO.tipo_operacion = 'VC'
	AND	RESULTADO_PASIVO.fecha_calculo = @dfecha_proceso


	IF @@ERROR<>0
	BEGIN
--		ROLLBACK TRANSACTION
		SELECT 1,'Problema al actualizar vencimientos de Pasivo'
		RETURN
	END

	INSERT INTO MOVIMIENTO_PASIVO

	SELECT 
		C.entidad_cartera
	,	C.codigo_instrumento
	,	C.numero_operacion
	,	C.numero_correlativo
	,	@dfecha_proximo
	,	'VEN'
	,	C.numero_contrato
	,	C.nombre_serie
	,	C.fecha_emision_papel
	,	C.fecha_vencimiento
	,	C.fecha_proximo_cupon
	,	C.fecha_anterior_cupon
	,	C.fecha_colocacion
	,	C.rut_emisor
	,	C.rut_cliente
	,	C.codigo_cliente
	,	C.numero_cuotas
	,	C.perido_amortizacion
	,	C.moneda_emision
	,	C.nominal
	,	C.nominal_pesos
	,	C.tasa_emision
	,	C.codigo_base
	,	C.valor_emision_pesos
	,	C.valor_emision_um
	,	C.saldo_flujo_emision
	,	C.presente_emision
	,	C.proximo_emision
	,	C.valor_par_emision
	,	C.tasa_colocacion
	,	C.base_colocacion
	,	C.valor_colocacion_clp
	,	C.valor_colocacion_um
	,	C.presente_colocacion
	,	C.proximo_colocacion
	,	C.valor_par_colocacion
	,	C.forma_pago
	,	C.tipo_tasa
	,	C.spread
	,	0
	,	0
	,	''
	,	''
	,	''
	,	'' --0  
	,	'' 
	,	'' --0  
	,	0  
	,	C.rut_acreedor
	,	C.dv_acreedor
	,	C.nombre_acreedor
	,	C.codigo_area
	,	C.sucursal
	,	C.observacion
	,	C.numero_pu
	,	C.keyid_deskmanager
	,	C.libro_deskmanager
	,	C.premio
	,	''
	,	C.numero_anterior
	,	''
	,	''
	,	''
	,	0 --''
	,	0 --''	
	,	0
        ,       0 --new
        ,       0 --new 
	FROM  	CARTERA_PASIVO C
	,	RESULTADO_PASIVO R
	WHERE 	C.numero_operacion = R.numero_operacion
	AND     C.numero_correlativo = R.numero_correlativo
	AND	R.fecha_calculo = @dfecha_proceso
	AND	R.tipo_operacion = 'VC'

	DELETE CARTERA_PASIVO_HISTORICA
	WHERE	fecha_vencimiento <= @dfecha_proximo

	DELETE CARTERA_PASIVO
	WHERE	fecha_vencimiento <= @dfecha_proximo

	SELECT * FROM RESULTADO_PASIVO
	SELECT * FROM CARTERA_PASIVO


	SELECT 0

END


GO
