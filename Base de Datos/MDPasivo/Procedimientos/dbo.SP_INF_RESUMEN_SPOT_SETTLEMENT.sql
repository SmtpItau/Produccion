USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_RESUMEN_SPOT_SETTLEMENT]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_INF_RESUMEN_SPOT_SETTLEMENT]
						(
							@rut_cliente 	NUMERIC(10)	,
							@codigo_cliente NUMERIC(10)
						)
		
AS
BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy

	DECLARE @Nombre_Cliente CHAR(70)
	DECLARE @Digito_Verif	CHAR(02)
	DECLARE @monedacontrol	NUMERIC(03)

	SELECT	@Nombre_Cliente = 'TODOS',
		@Digito_Verif	= '-0'
	
	SELECT  @monedacontrol = (SELECT moneda_control FROM DATOS_GENERALES)

	SELECT	'Rut'			= d.rut_cliente							,
		'Dv'			= '-' + cldv							,
		'Nombre'		= clnombre							,
		'Fecha Operacion'	= CONVERT(CHAR(10),d.fecha_operacion,103)			,
		'Divisa'		= LTRIM(RTRIM((SELECT mnnemo FROM MONEDA WHERE d.codigo_moneda = mncodmon))),
		'Monto'			= d.monto_original						,
		'Fecha Liquidacion'	= CONVERT(CHAR(10),d.fecha_vencimiento,103)			,
		'Nocional'		= lt.montooriginal					 	,
		'Consumo'		= lt.MontoTransaccion							,
		'InstrumPago'		= glosa								,
		'Tipo'			= c.descripcion							,
		'Ordenar'		= CONVERT(CHAR(08),d.fecha_operacion,112) + CONVERT(CHAR(08),d.fecha_vencimiento,112),
		'monedacontrol'		= @monedacontrol,
		'nombremoneda'		= (SELECT mnnemo FROM MONEDA where mncodmon = @monedacontrol)
	INTO	#TEMP
        FROM 	VIEW_TRANSFERENCIA_PENDIENTE	d	,
		CLIENTE				,
		DATOS_GENERALES				,
        	LINEA_TRANSACCION_DETALLE LTD		,
		LINEA_TRANSACCION  LT    		,
		FORMA_DE_PAGO				,
		PRODUCTO			c
	WHERE	clrut 		  = d.rut_cliente
	AND	clcodigo 	  = d.codigo_cliente
	AND	lt.id_sistema	  = 'BCC'
	AND	(d.rut_cliente	  = @rut_cliente OR @rut_cliente = 0)
	AND	(d.codigo_cliente	  = @codigo_cliente OR @codigo_cliente = 0)
	AND	d.fecha_vencimiento  > fecha_proceso
	AND 	codigo = d.forma_pago
	AND	c.codigo_producto = ltd.codigo_producto
        AND     lt.numerooperacion = ltd.numerooperacion
        AND     ltd.tipo_detalle    ='L'
        AND     ltd.tipo_movimiento = 'S'
        AND     lt.numerooperacion = d.numero_operacion
        AND     lt.codigo_grupo = ltd.codigo_grupo
        AND     ltd.Linea_Transsaccion = 'LINSIS'


	IF NOT EXISTS(SELECT 1 FROM #TEMP)
	BEGIN
		
		SELECT 	'Rut'			= @rut_cliente		,
			'Dv'			= @Digito_Verif		,
			'Nombre'		= @Nombre_Cliente	,
			'Fecha Operacion'	= ' '			,
			'Divisa'		= ' '			,
			'Monto'			= 0.0			,
			'Fecha Liquidacion'	= ' '		,
			'Nocional'		= 0.0			,
			'Consumo'		= 0.0			,
			'InstrumPago'		= ' '			,
			'Tipo'			= ' '			,
			'Ordenar'		= ' '			,
			'monedacontrol'		= @monedacontrol	,
			'nombremoneda'		= (SELECT mnnemo FROM MONEDA where mncodmon = @monedacontrol)

	END ELSE BEGIN

		SELECT * FROM #TEMP
                ORDER BY  Nombre, Tipo, Ordenar

	END

	SET NOCOUNT OFF

END




--dbo.SP_INF_RESUMEN_SPOT_SETTLEMENT 0,0


GO
