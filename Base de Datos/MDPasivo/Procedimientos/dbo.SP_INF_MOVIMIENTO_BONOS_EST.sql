USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_MOVIMIENTO_BONOS_EST]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INF_MOVIMIENTO_BONOS_EST]
					(
						@icfecha_proceso	CHAR(08)
					,	@icfecha_proxima	CHAR(08)
					)

AS
BEGIN
	SET DATEFORMAT dmy
	SET NOCOUNT ON

	DECLARE	@Fecha_Proceso	CHAR(10)
	,	@Fecha_Emision	CHAR(10)
	,	@Hora_Emision	CHAR(08)
	,	@Usuario	CHAR(30)
	,	@Titulo		CHAR(80)
	,	@dfecha_desde	DATETIME
	,	@dfecha_hasta	DATETIME
	,	@dfecha_hoy	DATETIME
	,	@acfecproc	CHAR(10)
	,	@acfecprox	CHAR(10)
	,	@uf_hoy		FLOAT
	,	@uf_man		FLOAT
	,	@ivp_hoy	FLOAT
	,	@ivp_man	FLOAT
	,	@do_hoy		FLOAT
	,	@do_man		FLOAT
	,	@da_hoy		FLOAT
	,	@da_man		FLOAT
	,	@acnomprop	CHAR(40)
	,	@rut_empresa	CHAR(12)
	,	@nRutemp	NUMERIC(09,0)
	,	@hora		CHAR(08)
	,	@paso		CHAR(01)
	,	@fecha_busqueda DATETIME

	SELECT  @dfecha_desde   =   CONVERT(DATETIME,@icfecha_proceso)
	,	@dfecha_hasta   =   CONVERT(DATETIME,@icfecha_proxima)


	SELECT  @Fecha_Proceso 	= CONVERT(CHAR(10),fecha_proceso,103)
	,	@fecha_busqueda = fecha_proceso
	,	@Fecha_Emision 	= CONVERT(CHAR(10),GETDATE(),103)
	,	@Hora_Emision 	= CONVERT(CHAR(10),GETDATE(),108)
	FROM    DATOS_GENERALES

	EXECUTE	SP_BASE_DEL_INFORME
		@acfecproc	OUTPUT
	,	@acfecprox	OUTPUT
	,	@uf_hoy		OUTPUT
	,	@uf_man		OUTPUT
	,	@ivp_hoy	OUTPUT
	,	@ivp_man	OUTPUT
	,	@do_hoy		OUTPUT
	,	@do_man		OUTPUT
	,	@da_hoy		OUTPUT
	,	@da_man		OUTPUT
	,	@acnomprop	OUTPUT
	,	@rut_empresa	OUTPUT
	,	@hora		OUTPUT
	,	@fecha_busqueda 



	IF @icfecha_proceso =  @icfecha_proxima
		SELECT @Titulo = 'MOVIMIENTO TASA EFECTIVA DE BONOS PROPIA EMISION AL ' + CONVERT(CHAR(10),@dfecha_desde,103)
	ELSE
		SELECT @Titulo = 'MOVIMIENTO TASA EFECTIVA DE BONOS PROPIA EMISION DESDE ' + CONVERT(CHAR(10),@dfecha_desde,103) + ' AL ' + CONVERT(CHAR(10),@dfecha_hasta,103)

	IF EXISTS(SELECT 1  FROM MOVIMIENTO_PASIVO a, 
				 BacStockRabo..Gen_Indicador, 
				 BacStockRabo..GEN_CLIENTES cl, 
				 INSTRUMENTO_PASIVO b, 
				 DATOS_GENERALES , 
 				 BacStockRabo..RFI_EMISOR em, 
				 BacStockRabo..mdfp d , 
				 SERIE_PASIVO e
		 WHERE 	a.codigo_instrumento = b.codigo_instrumento
		 AND	moneda_emision = mncodigo
		 AND	cl.rut = rut_cliente
		 AND	codigo_rut = codigo_cliente
		 AND	a.fecha_movimiento BETWEEN CONVERT(DATETIME,@icfecha_proceso) AND CONVERT(DATETIME,@icfecha_proxima)
		 AND	a.codigo_instrumento = 1
		 AND	EM.rut = a.rut_emisor
		 AND	a.rut_emisor = EM.rut
		 AND	a.forma_pago = d.codigo
		 AND	a.nombre_serie = e.nombre_serie
		 AND	a.estado_operacion = '')
	BEGIN
		SELECT 	'titulo'		= @Titulo
		,	'Fecha_Proceso'		= @Fecha_Proceso
		,	'Fecha_Emision'		= @Fecha_Emision
		,	'Hora_Emision'		= @Hora_Emision
		,	'numero_operacion'	= CONVERT(CHAR(12),REPLICATE('0', 07 - DATALENGTH(LTRIM(STR(a.numero_operacion)))) + LTRIM(STR(a.numero_operacion))+ '-' +
	        	                          REPLICATE('0', 03 - DATALENGTH(LTRIM(STR(a.numero_correlativo)))) + LTRIM(STR(a.numero_correlativo)))
		,	numero_correlativo
		,	a.nombre_serie
		,	'emgeneric'		= Codigo_emisor
		,	mnnemo
		,	nominal
		,	a.tasa_emision
		,	'tasa_colocacion'	= A.Tasa_Estimada
		,	valor_par_emision
		,	'valor_par_colocacion'	= A.Valor_Par_Estimado
		,	presente_emision
		,	'presente_colocacion'	= A.Presente_Estimado
		,	cl.Razon_Social
		,	'pago'			= CASE WHEN pago_hoy_man = '' THEN 'Hoy' ELSE 'Ma¤ana' END
		,	d.glosa
		,	codigo_rut
		,	cl.dv
		,	entidad_cartera
		,	tipo_mercado
		,	a.codigo_area
		,	a.sucursal
		,	retiro_documento
		,	'fecha_emision'		= CONVERT(CHAR(10),CONVERT(DATETIME,e.fecha_emision),103)
		,	'fecha_vencimiento'	= CONVERT(CHAR(10),CONVERT(DATETIME,e.fecha_vencimiento),103)
		,	'fecha_desde'		= CONVERT(CHAR(10),CONVERT(DATETIME,@icfecha_proceso),103)
		,	'fecha_hasta'		= CONVERT(CHAR(10),CONVERT(DATETIME,@icfecha_proxima),103)
		,	'prima_descuento'	= A.Presente_Estimado - presente_emision
		,	a.operador
		,	a.terminal
		,	a.cuenta_contable
		,	'uf_hoy'		= @uf_hoy
		,	'uf_man'		= @uf_man
		,	'ivp_hoy'		= @ivp_hoy
		,	'ivp_man'		= @ivp_man
		,	'do_hoy'		= @do_hoy
		,	'do_man'		= @do_man
		,	'da_hoy'		= @da_hoy
		,	'da_man'		= @da_man
		,	'nombre_sucursal'	= f.nombre
		,	Valor_Estimado_1
		,	Valor_Estimado_2
		,	Valor_Estimado_3
		,	Valor_Estimado_4
 		FROM 	MOVIMIENTO_PASIVO A
		,	BACSTOCKRABO..GEN_INDICADOR
		,	BACSTOCKRABO..GEN_CLIENTES CL
		,	INSTRUMENTO_PASIVO B
		,	DATOS_GENERALES 
		,	BACSTOCKRABO..RFI_EMISOR EM
		,	BACSTOCKRABO..MDFP D
		,	SERIE_PASIVO E
		,	BACSTOCKRABO..SUCURSAL F
		WHERE 	a.codigo_instrumento = b.codigo_instrumento
		AND	moneda_emision = mncodigo
		AND	cl.rut = rut_cliente
		AND	codigo_rut = codigo_cliente
		AND	a.fecha_movimiento BETWEEN CONVERT(DATETIME,@icfecha_proceso) AND CONVERT(DATETIME,@icfecha_proxima)
		AND	b.codigo_producto = 'BONOS'
		AND	em.rut = a.rut_emisor
		AND	a.rut_emisor = em.rut
		AND	a.forma_pago = d.codigo
		AND	a.nombre_serie = e.nombre_serie
		AND	a.estado_operacion = ''
		AND	f.codigo_sucursal = a.sucursal
		ORDER BY
			numero_operacion
		,	numero_correlativo

	END
	ELSE
	BEGIN
		SELECT	'TITULO'		= @Titulo
		,	'Fecha_Proceso'		= @Fecha_Proceso
		,	'Fecha_Emision'		= @Fecha_Emision
		,	'Hora_Emision'		= @Hora_Emision
		,	numero_operacion	= '0'
		,	numero_correlativo	= 0
		,	nombre_serie		= ' '
		,	emgeneric		= ' '
		,	mnnemo			= ' '
		,	nominal			= 0
		,	tasa_emision		= 0
		,	tasa_colocacion		= 0
		,	valor_par_emision	= 0
		,	valor_par_colocacion	= 0
		,	presente_emision	= 0
		,	presente_colocacion	= 0
		,	clnombre		= ' '
		,	'pago' 			= ' '
		,	glosa			= ' '
		,	clcodigo		= 0
		,	cldv			= ' '
		,	entidad_cartera		= 0
		,	tipo_mercado		= 0
		,	codigo_area 		= 0
		,	sucursal		= 0
		,	retiro_documento	= 0
		,	fecha_emision		= ' '
		,	fecha_vencimiento	= ' '
		,	'fecha_desde' 		= CONVERT(CHAR(10),CONVERT(DATETIME,@icfecha_proceso),103)
		,	'fecha_hasta' 		= CONVERT(CHAR(10),CONVERT(DATETIME,@icfecha_proxima),103)
		,	'prima_descuento'	= 0
		,	operador		= ' '
		,	terminal		= ' '
		,	cuenta_contable		= ' '	
		,	'uf_hoy'	        = @uf_hoy
		,	'uf_man'	        = @uf_man
		,	'ivp_hoy'	        = @ivp_hoy
		,	'ivp_man'           	= @ivp_man
		,	'do_hoy'	        = @do_hoy
		,	'do_man'	        = @do_man
		,	'da_hoy'	        = @da_hoy
		,	'da_man'	        = @da_man
		,	'nombre_sucursal'   	= ' '
		,	'Valor_Estimado_1'	= 0
		,	'Valor_Estimado_2'	= 0
		,	'Valor_Estimado_3'	= 0
		,	'Valor_Estimado_4'	= 0
	END	

      SET NOCOUNT OFF
END





GO
