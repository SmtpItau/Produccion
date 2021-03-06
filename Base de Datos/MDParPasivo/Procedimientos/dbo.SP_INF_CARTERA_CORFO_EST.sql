USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_CARTERA_CORFO_EST]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INF_CARTERA_CORFO_EST]
					(
						@icfecha_proceso	CHAR(08)
					,	@icfecha_proxima	CHAR(08)
					,	@ictipo_credito		CHAR(05)
					,	@ictipo_reporte		CHAR(01)
					)

AS
BEGIN
	SET DATEFORMAT dmy
	SET NOCOUNT ON

	DECLARE @Fecha_Proceso	CHAR(10)
	,	@Fecha_Emision	CHAR(10)
	,	@Hora_Emision	CHAR(08)
	,	@Titulo		CHAR(100)
	,	@dfecha_desde   DATETIME
	,	@dfecha_hasta   DATETIME
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
	,	@dfecha_proceso	CHAR	(10)
	,	@dfecha_proxima	CHAR	(10)
	,	@nuf_hoy	NUMERIC (21,04)
	,	@nuf_man	NUMERIC (21,04)
	,	@nivp_hoy	NUMERIC (21,04)
	,	@nivp_man	NUMERIC (21,04)
	,	@ndo_hoy	NUMERIC (21,04)
	,	@ndo_man	NUMERIC (21,04)
	,	@nda_hoy	NUMERIC (21,04)
	,	@nda_man	NUMERIC (21,04)
	,	@cnombre_entidad CHAR	(40)
	,	@crut_empresa	CHAR	(12)
	,	@nrut_empresa	NUMERIC	(09,0)
	,	@chora		CHAR	(08)
	,	@cpaso		CHAR	(01)

        SELECT  @dfecha_desde   = CONVERT(DATETIME,@icfecha_proceso)
	,	@dfecha_hasta   = CONVERT(DATETIME,@icfecha_proxima)

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
        ,       @fecha_busqueda

	IF @ictipo_reporte <> 'R'
	BEGIN
		IF @ictipo_credito = 'CORFO'
			IF @icfecha_proceso =  @icfecha_proxima
				SELECT @Titulo = 'CARTERA TASA EFECTIVA DE CREDITOS CORFO AL ' + CONVERT(CHAR(10),@dfecha_desde,103)
			ELSE
				SELECT @Titulo = 'CARTERA TASA EFECTIVA DE CREDITOS CORFO DESDE EL ' + CONVERT(CHAR(10),@dfecha_desde,103) + ' AL ' + CONVERT(CHAR(10),@dfecha_hasta,103)
		ELSE
			IF @ictipo_credito = 'LOCAL'
				IF @icfecha_proceso =  @icfecha_proxima
					SELECT @Titulo = 'CARTERA TASA EFECTIVA DE CREDITOS BANCOS LOCALES AL ' + CONVERT(CHAR(10),@dfecha_desde,103)
				ELSE
					SELECT @Titulo = 'CARTERA TASA EFECTIVA DE CREDITOS BANCOS LOCALES DESDE EL ' + CONVERT(CHAR(10),@dfecha_desde,103) + ' AL ' + CONVERT(CHAR(10),@dfecha_hasta,103)
			ELSE
				IF @icfecha_proceso =  @icfecha_proxima
					SELECT @Titulo = 'CARTERA TASA EFECTIVA DE CREDITOS BANCOS EXTRANJEROS AL ' + CONVERT(CHAR(10),@dfecha_desde,103)
				ELSE
					SELECT @Titulo = 'CARTERA TASA EFECTIVA DE CREDITOS BANCOS EXTRANJEROS DESDE EL ' + CONVERT(CHAR(10),@dfecha_desde,103) + ' AL ' + CONVERT(CHAR(10),@dfecha_hasta,103)
	END
	ELSE
	BEGIN
		IF @ictipo_credito = 'CORFO'
			IF @icfecha_proceso =  @icfecha_proxima
				SELECT @Titulo = 'RESUMEN DE CARTERA TASA EFECTIVA DE CREDITOS CORFO AL ' + CONVERT(CHAR(10),@dfecha_desde,103)
			ELSE
				SELECT @Titulo = 'RESUMEN DE CARTERA TASA EFECTIVA DE CREDITOS CORFO DESDE EL ' + CONVERT(CHAR(10),@dfecha_desde,103) + ' AL ' + CONVERT(CHAR(10),@dfecha_hasta,103)
		ELSE
			IF @ictipo_credito = 'LOCAL'
				IF @icfecha_proceso =  @icfecha_proxima
					SELECT @Titulo = 'RESUMEN CARTERA TASA EFECTIVA DE CREDITOS BANCOS LOCALES AL ' + CONVERT(CHAR(10),@dfecha_desde,103)
				ELSE
					SELECT @Titulo = 'RESUMEN CARTERA TASA EFECTIVA DE CREDITOS BANCOS LOCALES DESDE EL ' + CONVERT(CHAR(10),@dfecha_desde,103) + ' AL ' + CONVERT(CHAR(10),@dfecha_hasta,103)
			ELSE
				IF @icfecha_proceso =  @icfecha_proxima
					SELECT @Titulo = 'RESUMEN CARTERA TASA EFECTIVA DE CREDITOS BANCOS EXTRANJEROS AL ' + CONVERT(CHAR(10),@dfecha_desde,103)
				ELSE
					SELECT @Titulo = 'RESUMEN CARTERA TASA EFECTIVA DE CREDITOS BANCOS EXTRANJEROS DESDE EL ' + CONVERT(CHAR(10),@dfecha_desde,103) + ' AL ' + CONVERT(CHAR(10),@dfecha_hasta,103)
	END

	SELECT	@cpaso	= 'N'
	SELECT	@nrut_empresa	= rut_entidad FROM DATOS_GENERALES
	SELECT @dfecha_hoy = (SELECT fecha_proceso FROM DATOS_GENERALES)

	IF  @ictipo_reporte = 'N'
	BEGIN
--//////////////////////////RETORNO SI EXISTE INFORMACION EN LA RESULTADO_PASIVO/////////////////////////////////////////
		IF @dfecha_hoy = @dfecha_desde
		BEGIN

			IF EXISTS (SELECT 1  FROM CARTERA_PASIVO c			,
						  BacStockRabo..GEN_INDICADOR b		,
						  INSTRUMENTO_PASIVO d			,
						  BacStockRabo..Sucursal e		,
						  BacStockRabo..GEN_CLIENTES g		,
						  DATOS_GENERALES h			--,
--                                        	  BacSwapRabo..Tipos_de_tasas i
					WHERE  	c.nominal > 0
                            		AND	c.codigo_instrumento	= d.codigo_instrumento
                            		AND	d.codigo_producto	= @ictipo_credito
                                        AND    	c.moneda_emision	= b.mncodigo
    		                        AND    	c.numero_operacion 	= c.numero_operacion
                		        AND    	c.numero_correlativo	= c.numero_correlativo
                            		AND	c.sucursal 		= e.codigo_sucursal
                            		AND	g.Rut 		= c.rut_cliente
                            		AND    g.Codigo_Rut 		= c.codigo_cliente
--                            		AND    c.tipo_tasa 		= i.codigo_tasa	
			)
			BEGIN
		                SELECT
					'titulo'		     = @Titulo
				,	'Fecha_Proceso'		     = @Fecha_Proceso
				,	'Fecha_Emision'		     = @Fecha_Emision
				,	'Hora_Emision'		     = @Hora_Emision
				,	'numero_documento'           = c.numero_operacion--R(10),REPLICATE('0', 10 - DATALENGTH(LTRIM(STR(c.numero_operacion)))) + LTRIM(STR(c.numero_operacion)) )
				,	'numero_acuerdo'             = CONVERT(CHAR(10),REPLICATE('0', 10 - DATALENGTH(LTRIM(STR(c.numero_contrato)))) + LTRIM(STR(c.numero_contrato)))
 				,	'serie'	                     = ISNULL(c.nombre_serie,' ')
				,	'saldo_actual' 	     	     = ISNULL(c.Valor_Estimado_Um,0)
				,	'fecha_compra'	             = ISNULL(CONVERT(CHAR(10),c.fecha_emision_papel,103),' ')
				,	'fecha_ultima'	             = ISNULL(CONVERT(CHAR(10),c.fecha_anterior_cupon,103),' ')
				,	'fecha_vcto'	             = ISNULL(CONVERT(CHAR(10),c.fecha_vencimiento,103),' ')
				,	'dias_transaccion'	     = ISNULL(DATEDIFF(dd,c.fecha_emision_papel,@dfecha_desde),0)
				,	'fecha_proxima'	             = ISNULL(CONVERT(CHAR(10),c.fecha_proximo_cupon,103),' ')
				,	'otorgamiento'		     =  BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,  c.moneda_emision,'$$', CONVERT(CHAR(8),c.fecha_emision_papel,112 ))
				,	'tasa_emision'               = ISNULL(c.Tasa_Estimada,0)
				,	'spread_tasa'                = ISNULL(c.spread,0)
				,	'tasa_total'                 = ISNULL(c.Tasa_Estimada + c.spread,0)
				,	'valor_emision' 	     = ISNULL(c.Valor_Estimado_Clp,0)
				,	'valor_emision_um' 	     = CASE WHEN c.moneda_emision NOT IN (998) THEN c.Valor_Estimado_Um ELSE ISNULL((c.Valor_Estimado_Clp / BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,  c.moneda_emision,'$$', CONVERT(CHAR(8),h.fecha_proceso,112 ))),0) END
				,	'valor_presente_um'	     = CASE WHEN c.moneda_emision = 999 or moneda_emision = 888 THEN ISNULL(((Presente_Estimado) / BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,  c.moneda_emision,'$$', CONVERT(CHAR(8),h.fecha_proceso,112 ))),0.0) END
				,	'interes'	             = ISNULL(c.Interes_Estimado,0)
				,	'reajuste'	             = ISNULL(c.Reajuste_Estimado,0)
				,	'interes_um'	             = CASE WHEN c.moneda_emision NOT IN (998) THEN c.Interes_Estimado ELSE ISNULL((c.Interes_Estimado / BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,  c.moneda_emision,'$$', CONVERT(CHAR(8),h.fecha_proceso,112 ))),0) END
				,	'reajuste_um'	             = CASE WHEN c.moneda_emision NOT IN (998) THEN c.Reajuste_Estimado ELSE ISNULL((c.Reajuste_Estimado / BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,  c.moneda_emision,'$$', CONVERT(CHAR(8),h.fecha_proceso,112 ))),0) END
				,	'valor_presente'	     = ISNULL((Presente_Estimado),0.0)
				,	'fecha_desde' 		     = CONVERT(CHAR(10),CONVERT(DATETIME,@icfecha_proceso),103)
				,	'fecha_hasta' 		     = CONVERT(CHAR(10),CONVERT(DATETIME,@icfecha_proxima),103)
				,	'moneda_emision'	     = b.mnnemo
				,	'nombre_sucursal' 	     = e.nombre
				,	'cuenta_contable' 	     = c.cuenta_contable
				,	'nombre_instrumento'	     = d.nombre_instrumento
				,	'tipo_tasa'		     = 'FIJA'--i.descripcion
				,	'uf_hoy'	             = @uf_hoy
				,	'uf_man'	             = @uf_man
			 	,	'ivp_hoy'	             = @ivp_hoy
				,	'ivp_man'           	     = @ivp_man
				,	'do_hoy'	             = @do_hoy
				,	'do_man'	             = @do_man
				,	'da_hoy'	             = @da_hoy
				,	'da_man'	             = @da_man
			        ,	'periodo1'  		     = case when ISNULL(DATEDIFF(dd,c.fecha_emision_papel,c.fecha_vencimiento),0)>365 then 'Mas de 1 Año' else 'Menos de 1 Año' end
 	                	FROM	CARTERA_PASIVO c
			        ,	BacStockRabo..GEN_INDICADOR b
			        ,	INSTRUMENTO_PASIVO d
			        ,	BacStockRabo..Sucursal e
			        ,	BacStockRabo..GEN_CLIENTES g
			        ,	DATOS_GENERALES h
--			        ,	BacSwapRabo..Tipos_de_tasas i
	        	        WHERE  	c.nominal 		> 0
        	            	AND    	c.codigo_instrumento	= d.codigo_instrumento
	                    	AND	d.codigo_producto	= @ictipo_credito
        	            	AND    	c.fecha_emision_papel 	<= @dfecha_desde
                	    	AND    	c.moneda_emision	= b.mncodigo
	                    	AND    	c.numero_operacion 	= c.numero_operacion
	                    	AND    	c.numero_correlativo	= c.numero_correlativo
        	            	AND	c.sucursal 		= e.codigo_sucursal
                	    	AND	g.Rut 			= c.rut_cliente
	                    	AND	g.Codigo_Rut 		= c.codigo_cliente
--   	                 	AND	c.tipo_tasa 		= i.codigo_tasa

			SELECT	@cpaso	= 'S'

			END
		END
		ELSE
		BEGIN

--//////////////////////////RETORNO SI EXISTE INFORMACION EN LA CARTERA_PASIVO///////////////////////////////

			IF EXISTS (SELECT 1 FROM CARTERA_PASIVO_HISTORICA c		,
						 BacStockRabo..GEN_INDICADOR b		,
						 INSTRUMENTO_PASIVO d			,
						 BacStockRabo..Sucursal e		,
						 BacStockRabo..GEN_CLIENTES g		,
						 DATOS_GENERALES h			--,
--        			        	 BacSwapRabo..Tipos_de_tasas i
              
          				WHERE  	c.nominal > 0
                        		AND    	c.codigo_instrumento	= d.codigo_instrumento
                        		AND	d.codigo_producto	= @ictipo_credito
                        		AND    	c.fecha_emision_papel 	<= @dfecha_desde
                        		AND    	c.moneda_emision	= b.mncodigo
                        		AND    	c.numero_operacion 	= c.numero_operacion
                       		 	AND    	c.numero_correlativo	= c.numero_correlativo
                        		AND	c.sucursal 		= e.codigo_sucursal
                        		AND	g.Rut 			= c.rut_cliente
                        		AND	g.Codigo_Rut 		= c.codigo_cliente
--                        		AND	c.tipo_tasa 		= i.codigo_tasa
				)
			BEGIN
				SELECT
					'titulo'		     = @Titulo
				,	'Fecha_Proceso'		     = @Fecha_Proceso
				,	'Fecha_Emision'		     = @Fecha_Emision
				,	'Hora_Emision'		     = @Hora_Emision
				,	'numero_documento'           = CONVERT(CHAR(07),REPLICATE('0', 07 - DATALENGTH(LTRIM(STR(c.numero_operacion)))))
				,	'numero_acuerdo'             = CONVERT(CHAR(07),REPLICATE('0', 07 - DATALENGTH(LTRIM(STR(c.numero_contrato)))))
	 			,	'serie'	                     = ISNULL(c.nombre_serie,' ')
				,	'saldo_actual' 	     	     = ISNULL(c.Valor_Estimado_Um,0)
				,	'fecha_compra'	             = ISNULL(CONVERT(CHAR(10),c.fecha_emision_papel,103),' ')
				,	'fecha_ultima'	             = ISNULL(CONVERT(CHAR(10),c.fecha_anterior_cupon,103),' ')
				,	'fecha_vcto'	             = ISNULL(CONVERT(CHAR(10),c.fecha_vencimiento,103),' ')
				,	'dias_transaccion'	     = ISNULL(DATEDIFF(dd,c.fecha_emision_papel,@dfecha_desde),0)
				,	'fecha_proxima'	             = ISNULL(CONVERT(CHAR(10),c.fecha_proximo_cupon,103),' ')
				,	'otorgamiento'		     = ISNULL((BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,  c.moneda_emision,'$$', CONVERT(CHAR(8),c.fecha_emision_papel,112 )) ),0)
				,	'tasa_emision'		     = ISNULL(c.Tasa_Estimada,0)
				,	'spread_tasa'                = ISNULL(c.spread,0)
				,	'tasa_total'                 = ISNULL(c.Tasa_Estimada + c.spread,0)
				,	'valor_emision' 	     = ISNULL(c.Valor_Estimado_Clp,0)
				,	'valor_emision_um' 	     = CASE WHEN c.moneda_emision NOT IN (998) THEN Valor_Estimado_Clp ELSE ISNULL((c.Valor_Estimado_Clp /BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,  c.moneda_emision,'$$', CONVERT(CHAR(8),h.fecha_proceso,112 ))),0) END
				,	'valor_presente_um'	     = CASE WHEN c.moneda_emision = 999 or c.moneda_emision = 998 THEN ISNULL(((c.Presente_Estimado) /BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,  c.moneda_emision,'$$', CONVERT(CHAR(8),h.fecha_proceso,112 ))),0.0) ELSE 0 END
				,	'interes'	             = ISNULL(c.Interes_Estimado,0)
				,	'reajuste'	             = ISNULL(c.Reajuste_Estimado,0)
				,	'interes_um'	             = CASE WHEN c.moneda_emision NOT IN (998) THEN c.Interes_Estimado ELSE ISNULL((c.Interes_Estimado /BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,  c.moneda_emision,'$$', CONVERT(CHAR(8),h.fecha_proceso,112 ))),0) END
				,	'reajuste_um'	             = CASE WHEN c.moneda_emision NOT IN (998) THEN c.Reajuste_Estimado ELSE ISNULL((c.Reajuste_Estimado /BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,  c.moneda_emision,'$$', CONVERT(CHAR(8),h.fecha_proceso,112 ))),0) END
				,	'valor_presente'	     = ISNULL((c.Presente_Estimado),0.0)
				,	'fecha_desde' 		     = CONVERT(CHAR(10),CONVERT(DATETIME,@icfecha_proceso),103)
				,	'fecha_hasta' 		     = CONVERT(CHAR(10),CONVERT(DATETIME,@icfecha_proxima),103)
				,	'moneda_emision'	     = b.mnnemo
				,	'nombre_sucursal' 	     = e.nombre
				,	'cuenta_contable' 	     = c.cuenta_contable
				,	'nombre_instrumento'	     = d.nombre_instrumento
				,	'tipo_tasa'		     = 'FIJA'--i.descripcion
				,	'uf_hoy'	             = @uf_hoy
				,	'uf_man'	             = @uf_man
				,	'ivp_hoy'	             = @ivp_hoy
				,	'ivp_man'           	     = @ivp_man
				,	'do_hoy'	             = @do_hoy
				,	'do_man'	             = @do_man
				,	'da_hoy'	             = @da_hoy
				,	'da_man'	             = @da_man
			        ,	'periodo1'  		     = case when ISNULL(DATEDIFF(dd,c.fecha_emision_papel,c.fecha_vencimiento),0)>365 then 'Mas de 1 Año' else 'Menos de 1 Año' end
	        		FROM	CARTERA_PASIVO_HISTORICA c
				,	BacStockRabo..GEN_INDICADOR b
				,	INSTRUMENTO_PASIVO d
				,	BacStockRabo..Sucursal e
				,	BacStockRabo..GEN_CLIENTES g
				,	DATOS_GENERALES h
--				,	BacSwapRabo..Tipos_de_tasas i
        			WHERE  	c.nominal 		> 0
        			AND    	c.codigo_instrumento	= d.codigo_instrumento
        			AND	d.codigo_producto	= @ictipo_credito
        			AND    	c.moneda_emision	= b.mncodigo
			        AND    	c.numero_operacion 	= c.numero_operacion
			        AND    	c.numero_correlativo	= c.numero_correlativo
			        AND	c.sucursal 		= e.codigo_sucursal
			        AND	g.Rut 			= c.rut_cliente
			        AND	g.Codigo_Rut 		= c.codigo_cliente
--			        AND	c.tipo_tasa 		= i.codigo_tasa
			        AND	c.fecha_cartera		= @dfecha_desde

			SELECT	@cpaso	= 'S'

			END
		END
--//////////////////////////RETORNA SOLO LOS DATOS DE LA CABECERA Y PIE DE PAGINA/////////////////////////
		IF @cpaso='N'
			SELECT	'titulo'		= @Titulo
			,	'Fecha_Proceso'		= @Fecha_Proceso
			,	'Fecha_Emision'		= @Fecha_Emision
			,	'Hora_Emision'		= @Hora_Emision
			,	'numero_documento'           = '0'
			,	'numero_acuerdo'             = '0'
 			,	'serie'	                     = ' '
			,	'saldo_actual' 	     	     = 0
			,	'fecha_compra'	             = ' '
			,	'fecha_ultima'	             = ' '
			,	'fecha_vcto'	             = ' '
			,	'dias_transaccion'	     = 0
			,	'fecha_proxima'	             = ' '
			,	'otorgamiento'		     = 0
			,	'tasa_emision'               = 0
			,	'spread_tasa'                = 0
			,	'tasa_total'                 = 0
			,	'valor_emision' 	     = 0
			,	'valor_emision_um' 	     = 0
			,	'valor_presente_um'	     = 0
			,	'interes'	             = 0
			,	'reajuste'	             = 0
			,	'interes_um'	             = 0
			,	'reajuste_um'	             = 0
			,	'valor_presente'	     = 0
			,	'fecha_desde' 		     = CONVERT(CHAR(10),CONVERT(DATETIME,@icfecha_proceso),103)
			,	'fecha_hasta' 		     = CONVERT(CHAR(10),CONVERT(DATETIME,@icfecha_proxima),103)
			,	'moneda_emision'	     = ' '
			,	'nombre_sucursal' 	     = ' '
			,	'cuenta_contable' 	     = ' '
			,	'nombre_instrumento'	     = ' '
			,	'tipo_tasa'		     = ' '
			,	'uf_hoy'	             = @uf_hoy
			,	'uf_man'	             = @uf_man
			,	'ivp_hoy'	             = @ivp_hoy
			,	'ivp_man'           	     = @ivp_man
			,	'do_hoy'	             = @do_hoy
			,	'do_man'	             = @do_man
			,	'da_hoy'	             = @da_hoy
			,	'da_man'	             = @da_man
			,	'periodo1'                   = 0
		END

	IF @ictipo_reporte = 'R'
	BEGIN
--//////////////////////////RETORNO SI EXISTE INFORMACION EN LA RESULTADO_DEVENGO/////////////////////////////////////////
	 	IF EXISTS(SELECT 1 FROM	RESULTADO_PASIVO a, BacStockRabo..GEN_INDICADOR b, CARTERA_PASIVO c, INSTRUMENTO_PASIVO d
        	        	WHERE	a.fecha_calculo			= @dfecha_desde
                            	AND    	a.nominal 		        > 0
    				AND    	a.codigo_instrumento		= d.codigo_instrumento
                            	AND	d.codigo_producto		= @ictipo_credito
                            	AND    	c.fecha_emision_papel 		= @dfecha_desde
	                        AND    	a.moneda_emision		= b.mncodigo
                            	AND    	a.numero_operacion 		= c.numero_operacion
                            	AND    	a.numero_correlativo		= c.numero_correlativo
                            	AND	a.tipo_operacion		= 'DEV'
			 )
		BEGIN
			SELECT	'titulo'		     = @Titulo
			,	'Fecha_Proceso'		     = @Fecha_Proceso
			,	'Fecha_Emision'		     = @Fecha_Emision
			,	'Hora_Emision'		     = @Hora_Emision
			,	'numero_documento'           = CONVERT(CHAR(12),REPLICATE('0', 07 - DATALENGTH(LTRIM(STR(a.numero_operacion)))) + LTRIM(STR(a.numero_operacion)))
			,	'numero_acuerdo'             = CONVERT(CHAR(12),REPLICATE('0', 07 - DATALENGTH(LTRIM(STR(c.numero_contrato)))) + LTRIM(STR(c.numero_contrato)))
 			,	'serie'	                     = ISNULL(d.nombre_instrumento,' ')
			,	'saldo_actual' 	     	     = ISNULL(a.Valor_Estimado_Um,0)
			,	'fecha_compra'	             = ISNULL(CONVERT(CHAR(10),c.fecha_emision_papel,103),' ')
			,	'fecha_ultima'	             = ISNULL(CONVERT(CHAR(10),c.fecha_anterior_cupon,103),' ')
			,	'fecha_vcto'	             = ISNULL(CONVERT(CHAR(10),c.fecha_vencimiento,103),' ')
			,	'dias_transaccion'	     = ISNULL(DATEDIFF(dd,c.fecha_emision_papel,@dfecha_desde),0)
			,	'fecha_proxima'	             = ISNULL(CONVERT(CHAR(10),c.fecha_proximo_cupon,103),' ')
			,	'otorgamiento'		     = ISNULL(BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,a.moneda_emision,'$$',CONVERT(CHAR(8),c.fecha_emision_papel,112)),0)
			,	'tasa_emision'               = ISNULL(a.Tasa_Estimada,0)
			,	'valor_emision' 	     = ISNULL(c.Valor_Estimado_Clp,0)
			,	'valor_emision_um' 	     = CASE WHEN c.moneda_emision NOT IN (998) THEN c.Valor_Estimado_Clp ELSE ISNULL((c.Valor_Estimado_Clp / BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,a.moneda_emision,'$$',CONVERT(CHAR(8),h.fecha_proceso,112))),0) END
			,	'valor_presente_um'	     = CASE WHEN c.moneda_emision = 999 or c.moneda_emision = 998 THEN ISNULL(((c.Presente_Estimado) / BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,a.moneda_emision,'$$',CONVERT(CHAR(8),h.fecha_proceso,112))),0.0) END
			,	'interes'	 	     = ISNULL(a.Interes_Acum_Estimado,0)
			,	'reajuste'	             = ISNULL(a.Reajuste_Acum_Estimado,0)
			,	'interes_um'	             = CASE WHEN a.moneda_emision NOT IN (998) THEN a.Interes_Acum_Estimado ELSE ISNULL((a.interes_acumulado / BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,a.moneda_emision,'$$',CONVERT(CHAR(8),h.fecha_proceso,112))),0) END
			,	'reajuste_um'	             = CASE WHEN a.moneda_emision NOT IN (998) THEN a.Reajuste_Acum_Estimado ELSE ISNULL((a.reajuste_acumulado / BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,a.moneda_emision,'$$',CONVERT(CHAR(8),h.fecha_proceso,112))),0) END
			,	'valor_presente'	     = ISNULL((c.Presente_Estimado),0.0)
			,	'fecha_desde' 		     = CONVERT(CHAR(10),CONVERT(DATETIME,@icfecha_proceso),103)
			,	'fecha_hasta' 		     = CONVERT(CHAR(10),CONVERT(DATETIME,@icfecha_proxima),103)
			,	'moneda_emision'	     = b.mnnemo
			,	'nombre_sucursal' 	     = e.nombre
			,	'cuenta_contable' 	     = c.cuenta_contable
			,	'nombre_instrumento'	     = d.nombre_instrumento
			INTO	#TEMP_CARTERA_R1
			FROM	RESULTADO_PASIVO a
			,	BacStockRabo..GEN_INDICADOR b
			,	CARTERA_PASIVO c
			,	INSTRUMENTO_PASIVO d
			,	BacStockRabo..Sucursal e
			,	BacStockRabo..GEN_CLIENTES g
			,	DATOS_GENERALES h
			WHERE  	a.fecha_calculo		= @dfecha_desde
            		AND    	a.nominal 		> 0
            		AND    	a.codigo_instrumento	= d.codigo_instrumento
			AND 	d.codigo_producto	= @ictipo_credito
            		AND    	c.fecha_emision_papel 	= @dfecha_desde
            		AND    	a.moneda_emision	= b.mncodigo
            		AND    	a.numero_operacion 	= c.numero_operacion
           		AND    	a.numero_correlativo	= c.numero_correlativo
            		AND	c.sucursal 		= e.codigo_sucursal
		        AND	g.Rut 			= c.rut_cliente
		    	AND	g.Codigo_Rut 		= c.codigo_cliente
			AND	a.tipo_operacion	= 'DEV'

			SELECT
				'titulo'		= @Titulo
			,	'Fecha_Proceso'		= @Fecha_Proceso
			,	'Fecha_Emision'		= @Fecha_Emision
			,	'Hora_Emision'		= @Hora_Emision
			,	'saldo_actual' 		= SUM(saldo_actual)
			,	'valor_emision' 	= SUM(valor_emision)
			,	'valor_emision_um' 	= SUM(valor_emision_um)
			,	'valor_presente_um'	= SUM(valor_presente_um)
			,	'interes' 		= SUM(interes)
			,	'reajuste' 		= SUM(reajuste)
			,	'interes_um' 		= SUM(interes_um)
			,	'reajuste_um' 		= SUM(reajuste_um)
			,	'valor_presente'	= SUM(valor_presente)
			,	fecha_desde
			,	fecha_hasta
			,	moneda_emision
			,	nombre_sucursal
			,	cuenta_contable
			,	'uf_hoy'	        = @uf_hoy
			,	'uf_man'	        = @uf_man
			,	'ivp_hoy'	        = @ivp_hoy
			,	'ivp_man'           	= @ivp_man
			,	'do_hoy'	        = @do_hoy
			,	'do_man'	        = @do_man
			,	'da_hoy'	        = @da_hoy
			,	'da_man'	        = @da_man
			FROM #TEMP_CARTERA_R1
			GROUP BY
				titulo
			,	Fecha_Proceso
			,	Fecha_Emision
			,	Hora_Emision
			,	fecha_desde
			,	fecha_hasta
			,	moneda_emision
			,	nombre_sucursal
			,	cuenta_contable

			SELECT	@cpaso	= 'S'

		END
		ELSE
		BEGIN
--//////////////////////////RETORNO SI EXISTE INFORMACION EN LA CARTERA_PASIVO///////////////////////////////
			IF EXISTS(SELECT 1 FROM	CARTERA_PASIVO c, INSTRUMENTO_PASIVO d
                        		WHERE   c.nominal 		        > 0
		                        AND    	c.codigo_instrumento		= d.codigo_instrumento
                		        AND	d.codigo_producto		= @ictipo_credito
		                        AND    	c.fecha_colocacion 		<= @dfecha_desde)
			BEGIN
				SELECT	'titulo'		     = @Titulo
				,	'Fecha_Proceso'		     = @Fecha_Proceso
				,	'Fecha_Emision'		     = @Fecha_Emision
				,	'Hora_Emision'		     = @Hora_Emision
				,	'numero_documento'           = CONVERT(CHAR(12),REPLICATE('0', 07 - DATALENGTH(LTRIM(STR(c.numero_operacion)))) + LTRIM(STR(c.numero_operacion)))
				,	'numero_acuerdo'             = CONVERT(CHAR(12),REPLICATE('0', 07 - DATALENGTH(LTRIM(STR(c.numero_contrato)))) + LTRIM(STR(c.numero_contrato)))
 				,	'serie'	                     = ISNULL(d.nombre_instrumento,' ')
				,	'saldo_actual' 	     	     = ISNULL(c.Valor_Estimado_Um,0)
				,	'fecha_compra'	             = ISNULL(CONVERT(CHAR(10),c.fecha_emision_papel,103),' ')
				,	'fecha_ultima'	             = ISNULL(CONVERT(CHAR(10),c.fecha_anterior_cupon,103),' ')
				,	'fecha_vcto'	             = ISNULL(CONVERT(CHAR(10),c.fecha_vencimiento,103),' ')
				,	'dias_transaccion'	     = ISNULL(DATEDIFF(dd,c.fecha_emision_papel,@dfecha_desde),0)
				,	'fecha_proxima'	             = ISNULL(CONVERT(CHAR(10),c.fecha_proximo_cupon,103),' ')
				,	'otorgamiento'		     = ISNULL(BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,c.moneda_emision,'$$',CONVERT(CHAR(8),c.fecha_emision_papel,112)),0)
				,	'tasa_emision'               = ISNULL(c.Tasa_Estimada,0)
				,	'valor_emision' 	     = ISNULL(c.Valor_Estimado_Clp,0)
				,	'valor_emision_um' 	     = CASE WHEN c.moneda_emision NOT IN (998) THEN c.Valor_Estimado_Clp ELSE ISNULL((c.Valor_Estimado_Clp / BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,c.moneda_emision,'$$',CONVERT(CHAR(8),h.fecha_proceso,112))),0) END
				,	'valor_presente_um'	     = CASE WHEN c.moneda_emision = 999 or c.moneda_emision = 998 THEN ISNULL(((c.Presente_Estimado) / BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,c.moneda_emision,'$$',CONVERT(CHAR(8),h.fecha_proceso,112))),0.0) ELSE 0 END
				,	'interes'	             = ISNULL(c.Interes_Estimado,0)
				,	'reajuste'	             = ISNULL(c.Reajuste_Estimado,0)
				,	'interes_um'	             = CASE WHEN c.moneda_emision NOT IN (998) THEN c.Interes_Estimado ELSE ISNULL((c.Interes_Estimado / BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,c.moneda_emision,'$$',CONVERT(CHAR(8),h.fecha_proceso,112))),0) END
				,	'reajuste_um'	             = CASE WHEN c.moneda_emision NOT IN (998) THEN c.Reajuste_Estimado ELSE ISNULL((c.Reajuste_Estimado / BacStockRabo.dbo.FN_CONVIERTE_MONTO(1,c.moneda_emision,'$$',CONVERT(CHAR(8),h.fecha_proceso,112))),0) END
				,	'valor_presente'	     = ISNULL((c.Presente_Estimado),0.0)
				,	'fecha_desde' 		     = CONVERT(CHAR(10),CONVERT(DATETIME,@icfecha_proceso),103)
				,	'fecha_hasta' 		     = CONVERT(CHAR(10),CONVERT(DATETIME,@icfecha_proxima),103)
				,	'moneda_emision'	     = b.mnnemo
				,	'nombre_sucursal' 	     = e.nombre
				,	'cuenta_contable' 	     = c.cuenta_contable
				,	'nombre_instrumento'	     = d.nombre_instrumento
				INTO	#TEMP_CART_R2
		                FROM	BacStockRabo..GEN_INDICADOR b
		                ,       CARTERA_PASIVO c
                		,       INSTRUMENTO_PASIVO d
                        	,	BacStockRabo..Sucursal e
                        	,	BacStockRabo..GEN_CLIENTES g
		                ,       DATOS_GENERALES h
		                WHERE  	c.nominal 		    > 0
                		AND    	c.codigo_instrumento	= d.codigo_instrumento
		                AND	d.codigo_producto	= @ictipo_credito
                		AND    	c.fecha_emision_papel 	<= @dfecha_desde
		                AND    	c.moneda_emision	= b.mncodigo
                		AND	c.sucursal 		= e.codigo_sucursal
		                AND	g.Rut 		        = c.rut_cliente
                		AND	g.Codigo_Rut 		= c.codigo_cliente

				SELECT	'titulo'		= @Titulo
				,	'Fecha_Proceso'		= @Fecha_Proceso
				,	'Fecha_Emision'		= @Fecha_Emision
				,	'Hora_Emision'		= @Hora_Emision
				,	'saldo_actual' 		= SUM(saldo_actual)
				,	'valor_emision' 	= SUM(valor_emision)
				,	'valor_emision_um' 	= SUM(valor_emision_um)
				,	'valor_presente_um'	= SUM(valor_presente_um)
				,	'interes' 		= SUM(interes)
				,	'reajuste' 		= SUM(reajuste)
				,	'interes_um' 		= SUM(interes_um)
				,	'reajuste_um' 		= SUM(reajuste_um)
				,	'valor_presente'	= SUM(valor_presente)
				,	fecha_desde
				,	fecha_hasta
				,	moneda_emision
				,	nombre_sucursal
				,	cuenta_contable
				,	'uf_hoy'	        = @uf_hoy
				,	'uf_man'	        = @uf_man
				,	'ivp_hoy'	        = @ivp_hoy
				,	'ivp_man'           	= @ivp_man
				,	'do_hoy'	        = @do_hoy
				,	'do_man'	        = @do_man
				,	'da_hoy'	        = @da_hoy
				,	'da_man'	        = @da_man
				FROM #TEMP_CART_R2
				GROUP BY
					titulo
				,	Fecha_Proceso
				,	Fecha_Emision
				,	Hora_Emision
				,	fecha_desde
				,	fecha_hasta
				,	moneda_emision
				,	nombre_sucursal
				,	cuenta_contable

				SELECT	@cpaso	= 'S'

			END

		END
--//////////////////////////RETORNA SOLO LOS DATOS DE LA CABECERA Y PIE DE PAGINA/////////////////////////
		IF @cpaso='N'
	                SELECT
				'titulo'		= @Titulo
			,	'Fecha_Proceso'		= @Fecha_Proceso
			,	'Fecha_Emision'		= @Fecha_Emision
			,	'Hora_Emision'		= @Hora_Emision
			,	'saldo_actual' 	     	= 0
			,	'valor_emision' 	= 0
			,	'valor_emision_um' 	= 0
			,	'valor_presente_um'	= 0
			,	'interes'	        = 0
			,	'reajuste'	        = 0
			,	'interes_um'	        = 0
			,	'reajuste_um'	        = 0
			,	'valor_presente'	= 0
			,	'fecha_desde' 		= CONVERT(CHAR(10),CONVERT(DATETIME,@icfecha_proceso),103)
			,	'fecha_hasta' 		= CONVERT(CHAR(10),CONVERT(DATETIME,@icfecha_proxima),103)
			,	'moneda_emision'	= ' '
			,	'nombre_sucursal' 	= ' '
			,	'cuenta_contable' 	= ' '
			,	'uf_hoy'	        = @uf_hoy
			,	'uf_man'	        = @uf_man
			,	'ivp_hoy'	        = @ivp_hoy
			,	'ivp_man'               = @ivp_man
			,	'do_hoy'	        = @do_hoy
			,	'do_man'	        = @do_man
			,	'da_hoy'	        = @da_hoy
			,	'da_man'	        = @da_man
	END

	SET NOCOUNT OFF
END

GO
