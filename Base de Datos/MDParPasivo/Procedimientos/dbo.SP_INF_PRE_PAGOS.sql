USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_PRE_PAGOS]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_INF_PRE_PAGOS]
					(
					@icfecha_proceso	CHAR(10)	,
					@icfecha_proxima	CHAR(10)	
					)

AS
BEGIN
	SET DATEFORMAT dmy

	SET NOCOUNT ON

	DECLARE	@ncatidad_operaciones	NUMERIC(10)	,
		@ncontador_operaciones	NUMERIC(10)


	IF EXISTS(SELECT 1 FROM	MOVIMIENTO_PASIVO a 	,
				VIEW_MONEDA  f		,
				VIEW_CLIENTE  		,
				INSTRUMENTO_PASIVO b 	,
				VIEW_DATOS_GENERALES 	,
				VIEW_FORMA_DE_PAGO d 	,
				VIEW_MONEDA e		,
				VIEW_SUCURSAL c		,
				VIEW_PRODUCTO h		,
				FLUJO_CREDITOS g

			WHERE 	a.codigo_instrumento = b.codigo_instrumento
			AND	a.numero_operacion = g.numero_operacion
			AND	g.tipo_cuota = 'P'
			AND	sucursal = codigo_sucursal
			AND	moneda_emision = f.mncodmon
			AND	clrut = rut_cliente
			AND	clcodigo = codigo_cliente
			AND	a.fecha_movimiento BETWEEN CONVERT(DATETIME,@icfecha_proceso) AND CONVERT(DATETIME,@icfecha_proxima)
			AND	(b.codigo_producto = 'CORFO' OR b.codigo_producto = 'LOCAL' OR b.codigo_producto = 'EXTRA')
			AND	b.codigo_producto = h.codigo_producto
			AND	forma_pago = d.codigo
			AND	a.numero_anterior = a.numero_operacion
			AND	tipo_tasa = e.mncodmon
			AND	a.estado_operacion = '')
	BEGIN

		SELECT 
			sucursal									,
			'nombre_sucursal' = c.nombre							,
			fecha_proceso									,
			'cuenta_contable'=' '								,
			f.mnnemo									,
			h.descripcion									,
			a.numero_operacion								,
			a.numero_contrato								,
			a.nombre_serie									,
			tasa_emision  									,
			spread										,
			d.glosa										,
			fecha_emision_papel								,
			'fecha_prepago' = g.cuota_vencimiento						,
			'monto_prepago' = g.cuota_capital						,
			'interes_prepago' = g.cuota_interes						,
			'flujo_prepago'	= g.cuota_flujo							,
			'saldo_operacion'= g.cuota_saldo						,
			'prepago_pesos' = (g.cuota_flujo * (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha = fecha_proceso AND vmcodigo = moneda_emision)),
			fecha_vencimiento								,
			numero_cuotas									,
			'fecha_desde' = CONVERT(CHAR(10),CONVERT(DATETIME,@icfecha_proceso),103)	,
			'fecha_hasta' = CONVERT(CHAR(10),CONVERT(DATETIME,@icfecha_proxima),103)	,
			'nombre' = CASE WHEN b.codigo_producto = 'CORFO' THEN nombre_acreedor 
					ELSE clnombre 
					END								,
			nombre_acreedor		,
			'tipo_tasa' = e.mnglosa	,
			clnombre		,
			'contador' = IDENTITY(int, 1,1)
		INTO 	#TEMP_PREPAGO
 		FROM	MOVIMIENTO_PASIVO a 	,
			VIEW_MONEDA  f		,
			VIEW_CLIENTE  		,
			INSTRUMENTO_PASIVO b 	,
			VIEW_DATOS_GENERALES 	,
			VIEW_FORMA_DE_PAGO d 	,
			VIEW_MONEDA e		,
			VIEW_SUCURSAL c		,
			VIEW_PRODUCTO h		,
			FLUJO_CREDITOS g

		WHERE 	a.codigo_instrumento = b.codigo_instrumento
		AND	a.numero_operacion = g.numero_operacion
		AND	g.tipo_cuota = 'P'
		AND	sucursal = codigo_sucursal
		AND	moneda_emision = f.mncodmon
		AND	clrut = rut_cliente
		AND	clcodigo = codigo_cliente
		AND	a.fecha_movimiento BETWEEN CONVERT(DATETIME,@icfecha_proceso) AND CONVERT(DATETIME,@icfecha_proxima)
		AND	(b.codigo_producto = 'CORFO' OR b.codigo_producto = 'LOCAL' OR b.codigo_producto = 'EXTRA')
		AND	b.codigo_producto = h.codigo_producto
		AND	forma_pago = d.codigo
		AND	a.numero_anterior = a.numero_operacion
		AND	tipo_tasa = e.mncodmon
		AND	a.estado_operacion = ''

		ORDER BY a.numero_operacion , a.numero_contrato

		SELECT @ncatidad_operaciones = (SELECT COUNT(sucursal)FROM #TEMP_PREPAGO)
		SELECT @ncontador_operaciones = 1

		WHILE @ncontador_operaciones <= @ncatidad_operaciones
		BEGIN
			SET ROWCOUNT @ncontador_operaciones
				


			SET ROWCOUNT 0
		
			SELECT @ncontador_operaciones = @ncontador_operaciones + 1
		END
			


		SELECT * FROM #TEMP_PREPAGO


	END
	ELSE
	BEGIN
		SELECT 
			'sucursal' 		= ' '	,
			'nombre_sucursal' 	= ' '	,
			'fecha_proceso' 	= ' '	,
			'cuenta_contable'	= ' '	,
			'mnnemo'		= ' '	,
			'descripcion'		= ' '	,
			'numero_operacion'	= 0	,
			'numero_contrato'	= 0	,
			'nombre_serie'		= ' '	,
			'tasa_emision'  	= 0	,
			'spread'		= 0	,
			'glosa'			= ' '	,
			'fecha_emision_papel'	= ' '	,
			'fecha_prepago' 	= ' '	,
			'monto_prepago' 	= 0	,
			'interes_prepago' 	= 0	,
			'flujo_prepago'		= 0	,
			'saldo_operacion'	= 0	,
			'prepago_pesos' 	= 0	,
			'fecha_vencimiento'	= ' '	,
			'numero_cuotas'		= 0	,
			'fecha_desde' 		= ' '	,
			'fecha_hasta' 		= ' '	,
			'nombre' 		= ' '	,
			'nombre_acreedor'	= ' '	,
			'tipo_tasa' 		= ' '	,
			'clnombre'		= ' '	,
			'contado'		= 0

	END	

      SET NOCOUNT OFF

END


GO
