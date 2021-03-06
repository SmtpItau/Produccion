USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_RESUMEN_FORWARD_DERIVADOS]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INF_RESUMEN_FORWARD_DERIVADOS] 
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
 
	SELECT  @monedacontrol = (SELECT moneda_control FROM DATOS_GENERALES) 
 
	SELECT	@Nombre_Cliente = clnombre	, 
		@Digito_Verif	= '-' + cldv 
	FROM	CLIENTE 
	WHERE	clrut		= @rut_cliente 
	AND	clcodigo 	= @codigo_cliente 
 
	SELECT  'Rut'			= Rut_Cliente		, 
		'Dv'			= '-' + cldv		, 
		'Nombre'		= clnombre		, 
		'Codigo Producto'	= cacodpos1		, 
		'Producto'		= (SELECT c.descripcion FROM PRODUCTO c WHERE c.codigo_producto = cacodpos1 AND Id_Sistema = 'BFW' ), 
		'Contrato'		= canumoper 		, 
		'Tipo'			= (LTRIM(RTRIM(CASE WHEN catipoper = 'C' THEN 'COMPRA' ELSE 'VENTA' END))) + ' ' + LTRIM(RTRIM((SELECT mnnemo FROM MONEDA WHERE cacodmon1 = mncodmon)))+ '/' + LTRIM(RTRIM((SELECT mnnemo FROM MONEDA WHERE cacodmon2 = mncodmon))), 
		'Nocional'		= LT.MontoOriginal	, 
		'Consumo'		= LTD.MontoTransaccion	, 
		'Fecha Emision'		= CONVERT(CHAR(10),fechaemision,101)		, 
		'Plazo'			= caplazo		, 
		'Delivery/Compens.'	= (LTRIM(RTRIM(CASE WHEN catipmoda = 'C' THEN 'COMPENSACION' ELSE 'DELIVERY' END))), 
		'Codigo grupo'		= lt.codigo_grupo , 
		'monedacontrol'		= @monedacontrol , 
		'nombremoneda'		= (SELECT mnnemo FROM MONEDA WHERE mncodmon = @monedacontrol), 
                'Sistema'               = 'BFW'		, 
                'Factor_Riesgo'         = LFRP.Factor_Riesgo 
	INTO 	#TEMP 
	FROM	VIEW_CARTERA_FORWARD	a     , 
		CLIENTE			      ,	 
		DATOS_GENERALES		      , 
                LINEA_TRANSACCION_DETALLE LTD , 
                LINEA_TRANSACCION LT 	      ,
                LINEAS_OPERACION_FRP LFRP
 	WHERE	clrut 		  = cacodigo 
	AND	clcodigo 	  = cacodcli 
	AND	lt.id_sistema	  = 'BFW' 
	AND	ltd.codigo_producto = cacodpos1 
	AND	LT.rut_cliente	  = cacodigo 
	AND	LT.codigo_cliente  = cacodcli 
	AND	(cacodigo	  = @rut_cliente OR @rut_cliente = 0)
 
	AND	(cacodcli 	  = @codigo_cliente OR @codigo_cliente = 0) 
        AND     ltd.tipo_detalle       = 'L' 
        AND     ltd.tipo_movimiento    = 'S' 
        AND     ltd.Linea_Transsaccion  = 'LINSIS' 
        AND     lt.NumeroOperacion     = canumoper 
        AND     lt.codigo_grupo        = ltd.codigo_grupo              
        AND     ltd.NumeroOperacion    = canumoper
	AND	LFRP.id_sistema		= lt.id_sistema
	AND	LFRP.Codigo_Grupo	= lt.Codigo_Grupo
	AND	LFRP.NumeroOperacion	= lt.NumeroOperacion
	AND	LFRP.NumeroDocumento	= lt.Numerodocumento 
	AND	LFRP.NumeroCorrelativo	= lt.NumeroCorrelativo

-- select * from LINEA_TRANSACCION
-- select * from LINEAS_OPERACION_FRP

-- select * from VIEW_CARTERA_FORWARD_PAPEL
	INSERT  INTO #TEMP 
	SELECT  'Rut'			= a.Rut_Cliente		, 
		'Dv'			= '-' + cldv		, 
		'Nombre'		= clnombre		, 
		'Codigo Producto'	= a.codigo_producto	, 
		'Producto'		= (SELECT c.descripcion FROM PRODUCTO c WHERE c.codigo_producto = a.codigo_producto AND Id_Sistema = 'BFW' ), 
		'Contrato'		= a.numero_operacion	, 
		'Tipo'			= CASE WHEN a.tipo_operacion = 'C' THEN 'COMPRA' ELSE 'VENTA' END,
		'Nocional'		= LT.MontoOriginal	, 
		'Consumo'		= LTD.MontoTransaccion	, 
		'Fecha Emision'		= CONVERT(CHAR(10),a.fecha_cierre,101)		, 
		'Plazo'			= DATEDIFF(day, a.fecha_cierre, a.fecha_termino), 
		'Delivery/Compens.'	= CASE WHEN a.modalidad_pago = 'C' THEN 'COMPENSACION' ELSE 'DELIVERY' END, 
		'Codigo grupo'		= lt.codigo_grupo , 
		'monedacontrol'		= @monedacontrol , 
		'nombremoneda'		= (SELECT mnnemo FROM MONEDA WHERE mncodmon = @monedacontrol), 
                'Sistema'               = 'BFW'		, 
                'Factor_Riesgo'         = LFRP.Factor_Riesgo
	FROM	VIEW_CARTERA_FORWARD_PAPEL	a     , 
		CLIENTE			      ,	 
		DATOS_GENERALES		      , 
                LINEA_TRANSACCION_DETALLE LTD , 
                LINEA_TRANSACCION LT 	      ,
                LINEAS_OPERACION_FRP LFRP
 	WHERE	clrut 		  = a.rut_cliente
	AND	clcodigo 	  = a.codigo_cliente
	AND	lt.id_sistema	  = 'BFW' 
	AND	ltd.codigo_producto = a.codigo_producto
	AND	LT.rut_cliente	  = a.rut_cliente
	AND	LT.codigo_cliente = a.codigo_cliente
	AND	(a.rut_cliente	  = @rut_cliente OR @rut_cliente = 0)
	AND	(a.codigo_cliente = @codigo_cliente OR @codigo_cliente = 0) 
        AND     ltd.tipo_detalle       = 'L' 
        AND     ltd.tipo_movimiento    = 'S' 
        AND     ltd.Linea_Transsaccion  = 'LINSIS' 
        AND     lt.NumeroOperacion     = a.numero_operacion
        AND     lt.codigo_grupo        = ltd.codigo_grupo              
        AND     ltd.NumeroOperacion    = a.numero_operacion
	AND	LFRP.id_sistema		= lt.id_sistema
	AND	LFRP.Codigo_Grupo	= lt.Codigo_Grupo
	AND	LFRP.NumeroOperacion	= lt.NumeroOperacion
	AND	LFRP.NumeroDocumento	= lt.Numerodocumento 
	AND	LFRP.NumeroCorrelativo	= lt.NumeroCorrelativo




	INSERT  INTO #TEMP 
	SELECT 
		d.rut_cliente		, 
		 '-' + cldv		, 
		clnombre		, 
		d.tipo_swap		, 
		(SELECT c.descripcion FROM PRODUCTO c WHERE c.codigo_producto = d.tipo_swap AND Id_Sistema = 'SWP' ), 
		d.numero_operacion	, 
		LTRIM(RTRIM(m1.mnnemo)) + '/' + LTRIM(RTRIM(m2.mnnemo)), 
		SUM(lt.MontoOriginal)	, 
                SUM(ltd.MontoTransaccion), 
		CONVERT(CHAR(10),lt.fechainicio,101)				, 
		DATEDIFF(DAY,lt.fechainicio,lt.FechaVencimiento)		, 
		(LTRIM(RTRIM(CASE WHEN F1.modalidad_interes = 'C' THEN 'COMPENSACION' ELSE 'DELIVERY' END))), 
		lt.codigo_grupo	, 
		@monedacontrol , 
		(SELECT mnnemo FROM MONEDA WHERE mncodmon = @monedacontrol), 
                 'SWP', 
                LFRP.Factor_Riesgo 
	FROM	VIEW_CONTRATO D		, 
		VIEW_CONTRATO_FLUJO F1	, 
		VIEW_CONTRATO_FLUJO F2	, 
		CLIENTE			, 
		DATOS_GENERALES		, 
		LINEA_TRANSACCION LT	, 
		LINEA_TRANSACCION_DETALLE LTD ,
		MONEDA	M1,
		MONEDA	M2,
                LINEAS_OPERACION_FRP LFRP
	WHERE	clrut 		  = d.rut_cliente 
	AND	clcodigo 	  = d.codigo_cliente 
	AND	d.numero_operacion = F1.numero_operacion
	AND	F1.tipo_flujo = 1
	AND	F1.numero_flujo = 1
	AND	d.numero_operacion = F2.numero_operacion
	AND	F2.tipo_flujo = 1
	AND	F2.numero_flujo = 1
	AND	lt.id_sistema	  = 'SWP' 
	AND	(d.rut_cliente	  = @rut_cliente OR @rut_cliente = 0) 
	AND	(d.codigo_cliente      = @codigo_cliente OR @codigo_cliente = 0) 
        AND     ltd.tipo_detalle       = 'L' 
        AND     ltd.tipo_movimiento    = 'S' 
        AND     ltd.Linea_Transsaccion  = 'LINSIS' 
        AND     lt.NumeroOperacion     = D.numero_operacion 
        AND     lt.codigo_grupo        = ltd.codigo_grupo              
        AND     ltd.NumeroOperacion    = lt.NumeroOperacion   
	AND	m1.mncodmon = F1.moneda_flujo
	AND	m2.mncodmon = F2.moneda_flujo
	AND	LFRP.id_sistema		= lt.id_sistema
	AND	LFRP.Codigo_Grupo	= lt.Codigo_Grupo
	AND	LFRP.NumeroOperacion	= lt.NumeroOperacion
	AND	LFRP.NumeroDocumento	= lt.Numerodocumento 
	AND	LFRP.NumeroCorrelativo	= lt.NumeroCorrelativo
	GROUP BY d.rut_cliente, cldv, clnombre, moneda_control, d.numero_operacion, clnombre, d.tipo_swap,lt.fechavencimiento, lt.fechainicio, F1.modalidad_interes, lt.codigo_grupo, LFRP.Factor_Riesgo, m1.mnnemo, m2.mnnemo

 
	--****************************************** 
	-- MANUALES 
	--****************************************** 
	INSERT  INTO #TEMP 
	SELECT	d.rut_cliente		, 
		'-' + cldv		, 
		clnombre		, 
		d.producto		, 
		(SELECT c.descripcion FROM PRODUCTO c WHERE c.codigo_producto = d.producto AND Id_Sistema = 'MAN' ), 
		d.numero_operacion	, 
		LTRIM(RTRIM((SELECT mnnemo FROM MONEDA WHERE moneda_primaria = mncodmon)))+ '/' + LTRIM(RTRIM((SELECT mnnemo FROM MONEDA WHERE moneda_secundaria = mncodmon))), 
		sum(lt.MontoOriginal)	, 
                SUM(ltd.MontoTransaccion), 
		CONVERT(CHAR(10),lt.fechainicio,101)			, 
		DATEDIFF(DAY,lt.fechainicio,lt.FechaVencimiento)		, 
		(LTRIM(RTRIM(CASE WHEN d.modalidad_pago = 'C' THEN 'COMPENSACION' ELSE 'DELIVERY' END))), 
		lt.codigo_grupo	, 
		@monedacontrol , 
		(SELECT mnnemo FROM MONEDA WHERE mncodmon = @monedacontrol), 
                 'MAN', 
                LFRP.Factor_Riesgo 
	FROM	CARTERA_MANUAL d		, 
		CLIENTE				, 
		DATOS_GENERALES		dg	, 
		LINEA_TRANSACCION LT            , 
		LINEA_TRANSACCION_DETALLE LTD   ,
                LINEAS_OPERACION_FRP LFRP
	WHERE	clrut 		  = d.rut_cliente 
	AND	clcodigo 	  = d.codigo_cliente 
	AND	lt.id_sistema	  = 'MAN' 
	AND	(d.rut_cliente	  = @rut_cliente OR @rut_cliente = 0) 
	AND	(d.codigo_cliente      = @codigo_cliente OR @codigo_cliente = 0) 
        AND     ltd.tipo_detalle       = 'L' 
        AND     ltd.tipo_movimiento    = 'S' 
        AND     ltd.Linea_Transsaccion  = 'LINSIS' 
        AND     lt.NumeroOperacion     = numero_operacion 
        AND     lt.codigo_grupo        = ltd.codigo_grupo              
        AND     ltd.NumeroOperacion    = lt.NumeroOperacion 
	AND	d.fecha_proceso	       = dg.fecha_proceso 
	AND	LFRP.id_sistema		= lt.id_sistema
	AND	LFRP.Codigo_Grupo	= lt.Codigo_Grupo
	AND	LFRP.NumeroOperacion	= lt.NumeroOperacion
	AND	LFRP.NumeroDocumento	= lt.Numerodocumento 
	AND	LFRP.NumeroCorrelativo	= lt.NumeroCorrelativo

	GROUP BY  
		d.rut_cliente		,  
		d.moneda_primaria	, 
		d.moneda_secundaria	, 
		cldv			,  
		clnombre		,  
		moneda_control		,  
		d.numero_operacion	,  
--		clnombre		,  
		d.producto		, 
		lt.fechavencimiento	,  
		lt.fechainicio		,  
		d.modalidad_pago	,  
		lt.codigo_grupo		, 
		LFRP.Factor_Riesgo 
 
/*
        UPDATE #TEMP SET TIPO = mnnemo 
        FROM MONEDA , VIEW_CARTERA_SWAP 
        WHERE mncodmon = compra_moneda 
        and  numero_operacion = contrato 
        and  tipo_flujo = 1 
        and sistema ='SWP' 


 
        UPDATE #TEMP SET TIPO = tipo + '/' + mnnemo 
        FROM MONEDA , VIEW_CARTERA_SWAP 
        WHERE mncodmon = venta_moneda 
        and  numero_operacion = contrato 
        and  tipo_flujo = 2 
        and sistema ='SWP' 
*/
 
 
	IF NOT EXISTS(SELECT 1 FROM #TEMP) 
	BEGIN 
 
		SELECT  'Rut'			= @rut_cliente		, 
			'Dv'			= @Digito_Verif		, 
			'Nombre'		= @Nombre_Cliente	, 
			'Codigo Producto'	= ' '			, 
			'Producto'		= ' '			, 
			'Contrato'		= CONVERT(NUMERIC(10),0), 
			'Tipo'			= ' '			, 
			'Nocional'		= 0.0			, 
			'Consumo'		= 0.0			, 
			'Fecha Emision'		= ' '			, 
			'Plazo'			= 0.0			, 
			'Delivery/Compens.'	= ' '			, 
			'Codigo grupo'		= ' '			, 
			'monedacontrol'		= @monedacontrol 	, 
			'nombremoneda'		= (SELECT mnnemo FROM MONEDA WHERE mncodmon = @monedacontrol), 
                        'Sistema'               = '   ', 
                        'Factor_Riesgo'         = 0.0 
 
	END ELSE BEGIN 
 
		SELECT * FROM #TEMP 
		ORDER BY producto, contrato, Tipo, [Delivery/Compens.] 
 
	END 
 
	SET NOCOUNT OFF 
 
END 
 
 
 

-- SP_INF_RESUMEN_FORWARD_DERIVADOS  97080000, 1


GO
