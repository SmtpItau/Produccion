USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZC08C09]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE  [dbo].[SP_INTERFAZC08C09]   
AS
BEGIN
	SET NOCOUNT ON
-- Swap: Guardar Como
	DECLARE @dFecPro AS DATETIME
	SELECT  @dFecPro  = (Select fechaproc from swapgeneral)  

	----------------------------------------<< Intereses en Moneda del Contrato
	SELECT 	'Fecha'    =  convert (char(02),@dFecPro,103)  				,
	       	'SISTEMA'  =  'SW'                             				, 
	       	'Cuenta'   =  '0000000000' 		      				,-- falta definicion cuentas
	       	'Moneda'   =  compra_moneda                    				,
	       	'Tasa'     =  case when compra_codigo_tasa = 0 THEN 1 ELSE 2 END  	,
	       	'FechaVcto'=  convert (char(08),fecha_vence_flujo,112)			, 
	       	'Monto'    =  compra_interes                   				,
	       	'Numero'   =  numero_operacion  		      			,   
	       	'codTasa'  =  compra_codigo_tasa 	      				,
		numero_flujo            						,
		tipo_flujo								,
		'flujo_tipo' = 'N'
	INTO	#tmp
	FROM	cartera a ,view_cliente b
	WHERE	compra_codigo_tasa = 0
		AND tipo_flujo = 1
                AND a.Estado <> 'C'
		AND (a.rut_cliente = b.clrut and a.codigo_cliente = b.clcodigo )

	INSERT INTO #tmp
	sELECT 	'Fecha'    =  convert (char(02),@dFecPro,103)  				,
	       	'SISTEMA'  =  'SW'                             				, 
	       	'Cuenta'   =  '0000000000' 		      				,-- falta definicion cuentas
	       	'Moneda'   =  compra_moneda                    				,
	       	'Tasa'     =  case when compra_codigo_tasa = 0 THEN 1 ELSE 2 END        ,
	       	'FechaVcto'=  convert (char(08),fecha_vence_flujo,112)			, 
	       	'Monto'    =  compra_interes                      			,
	       	'Numero'   =  numero_operacion                    			,
	       	'codTasa'  =  compra_codigo_tasa 	         			,
		numero_flujo								,
		tipo_flujo								,
		'flujo_tipo' = 'N'
	FROM	cartera a ,view_cliente b
	WHERE	compra_codigo_tasa <> 0 
		AND tipo_flujo = 1
		and @dFecPro BETWEEN fecha_inicio_flujo and fecha_vence_flujo 
		and (a.rut_cliente= b.clrut and a.codigo_cliente = b.clcodigo )
                AND a.Estado <> 'C'

	INSERT INTO #tmp
	SELECT 	'Fecha'    =  convert (char(02),@dFecPro,103)				,
	       	'SISTEMA'  =  'SW'                             				, 
	       	'Cuenta'   =  '0000000000'		      				,	
	       	'Moneda'   =  venta_moneda                      			,
	       	'Tasa'     =  case when venta_codigo_tasa = 0 THEN 1 ELSE 2 END		,
	       	'FechaVcto'= convert (char(08),fecha_vence_flujo,112)			, 
	       	'Monto'    =  venta_interes                      			,
	       	'Numero'   =  numero_operacion                   			,   
	       	'codTasa'  =  venta_codigo_tasa 	          			,
		numero_flujo								,
		tipo_flujo								,
		'flujo_tipo' = 'N'
	FROM	cartera a ,view_cliente b
	WHERE	venta_codigo_tasa <> 0 
		AND tipo_flujo = 2
		AND @dFecPro BETWEEN fecha_inicio_flujo and fecha_vence_flujo 
		AND (a.rut_cliente = b.clrut and a.codigo_cliente = b.clcodigo )
                AND a.Estado <> 'C'

	INSERT INTO #tmp
	SELECT 	'Fecha'    =  convert (char(02),@dFecPro,103)				,
		'SISTEMA'  =  'SW'                             				, 
		'Cuenta'   =  '0000000000'		      				,	
		'Moneda'   =  venta_moneda                      			,
		'Tasa'     =  case when venta_codigo_tasa = 0 THEN 1 ELSE 2 END		,
		'FechaVcto'=  convert (char(08),fecha_vence_flujo,112)			, 
		'Monto'    =  venta_interes                      			,
		'Numero'   =  numero_operacion                   			,   
		'codTasa'  =  venta_codigo_tasa 	          			,
		numero_flujo								,
		tipo_flujo								,
		'flujo_tipo' = 'N'
	FROM  	cartera a ,view_cliente b
	WHERE 	venta_codigo_tasa = 0 
		AND tipo_flujo = 2
		AND   (a.rut_cliente = b.clrut and a.codigo_cliente = b.clcodigo )
                AND a.Estado <> 'C'

	---------------------------------------------------<< Fin Intereses en Moneda Contrato


	----------------------------------------<< Capital en Moneda del Contrato
	INSERT INTO #tmp
	SELECT 	'Fecha'    =  convert (char(02),@dFecPro,103)  				,
	       	'SISTEMA'  =  'SW'                             				, 
	       	'Cuenta'   =  '0000000000' 		      				,-- falta definicion cuentas
	       	'Moneda'   =  compra_moneda                    				,
	       	'Tasa'     =  case when compra_codigo_tasa = 0 THEN 1 ELSE 2 END  	,
	       	'FechaVcto'=  convert (char(08),fecha_vence_flujo,112)			, 
	       	'Monto'    =  compra_capital                   				,
	       	'Numero'   =  numero_operacion  		      			,   
	       	'codTasa'  =  compra_codigo_tasa 	      				,
		numero_flujo            						,
		tipo_flujo								,
		'flujo_tipo' = 'M'
	FROM	cartera a ,view_cliente b
	WHERE	compra_codigo_tasa = 0
		AND tipo_flujo = 1
		AND (a.rut_cliente = b.clrut and a.codigo_cliente = b.clcodigo )
                AND a.Estado <> 'C'

	INSERT INTO #tmp
	sELECT 	'Fecha'    =  convert (char(02),@dFecPro,103)  				,
	       	'SISTEMA'  =  'SW'                             				, 
	       	'Cuenta'   =  '0000000000' 		      				,-- falta definicion cuentas
	       	'Moneda'   =  compra_moneda                    				,
	       	'Tasa'     =  case when compra_codigo_tasa = 0 THEN 1 ELSE 2 END        ,
	       	'FechaVcto'=  convert (char(08),fecha_vence_flujo,112)			, 
	       	'Monto'    =  compra_capital                      			,
	       	'Numero'   =  numero_operacion                    			,
	       	'codTasa'  =  compra_codigo_tasa 	         			,
		numero_flujo								,
		tipo_flujo								,
		'flujo_tipo' = 'M'
	FROM	cartera a ,view_cliente b
	WHERE	compra_codigo_tasa <> 0 
		AND tipo_flujo = 1
		and @dFecPro BETWEEN fecha_inicio_flujo and fecha_vence_flujo 
		and (a.rut_cliente= b.clrut and a.codigo_cliente = b.clcodigo )
                AND a.Estado <> 'C'


	INSERT INTO #tmp
	SELECT 	'Fecha'    =  convert (char(02),@dFecPro,103)				,
	       	'SISTEMA'  =  'SW'                             				, 
	       	'Cuenta'   =  '0000000000'		      				,	
	       	'Moneda'   =  venta_moneda                      			,
	       	'Tasa'     =  case when venta_codigo_tasa = 0 THEN 1 ELSE 2 END		,
	       	'FechaVcto'= convert (char(08),fecha_vence_flujo,112)			, 
	       	'Monto'    =  venta_capital						,
	       	'Numero'   =  numero_operacion                   			,   
	       	'codTasa'  =  venta_codigo_tasa 	          			,
		numero_flujo								,
		tipo_flujo								,
		'flujo_tipo' = 'M'
	FROM	cartera a ,view_cliente b
	WHERE	venta_codigo_tasa <> 0 
		AND tipo_flujo = 2
		AND @dFecPro BETWEEN fecha_inicio_flujo and fecha_vence_flujo 
		AND (a.rut_cliente = b.clrut and a.codigo_cliente = b.clcodigo )
                AND a.Estado <> 'C'

	INSERT INTO #tmp
	SELECT 	'Fecha'    =  convert (char(02),@dFecPro,103)				,
		'SISTEMA'  =  'SW'                             				, 
		'Cuenta'   =  '0000000000'		      				,	
		'Moneda'   =  venta_moneda                      			,
		'Tasa'     =  case when venta_codigo_tasa = 0 THEN 1 ELSE 2 END		,
		'FechaVcto'=  convert (char(08),fecha_vence_flujo,112)			, 
		'Monto'    =  venta_capital						,
		'Numero'   =  numero_operacion                   			,   
		'codTasa'  =  venta_codigo_tasa 	          			,
		numero_flujo								,
		tipo_flujo								,
		'flujo_tipo' = 'M'
	FROM  	cartera a ,view_cliente b
	WHERE 	venta_codigo_tasa = 0 
		AND tipo_flujo = 2
		AND   (a.rut_cliente = b.clrut and a.codigo_cliente = b.clcodigo )
                AND a.Estado <> 'C'
	---------------------------------------------------<< Fin Capital en Moneda Contrato

	----------------------------------------<< Intereses en Moneda de Pago
	INSERT INTO	#tmp
	SELECT 	'Fecha'    =  convert (char(02),@dFecPro,103)  				,
	       	'SISTEMA'  =  'SW'                             				, 
	       	'Cuenta'   =  '0000000000' 		      				,-- falta definicion cuentas
	       	'Moneda'   =  recibimos_moneda                    				,
	       	'Tasa'     =  case when compra_codigo_tasa = 0 THEN 1 ELSE 2 END  	,
	       	'FechaVcto'=  convert (char(08),fecha_vence_flujo,112)			, 
	       	'Monto'    =  compra_interes                   				,
	       	'Numero'   =  numero_operacion  		      			,   
	       	'codTasa'  =  compra_codigo_tasa 	      				,
		numero_flujo            						,
		tipo_flujo								,
		'flujo_tipo' = 'J'
	FROM	cartera a ,view_cliente b
	WHERE	compra_codigo_tasa = 0
		AND tipo_flujo = 1
		AND (a.rut_cliente = b.clrut and a.codigo_cliente = b.clcodigo )
                AND a.Estado <> 'C'

	INSERT INTO #tmp
	sELECT 	'Fecha'    =  convert (char(02),@dFecPro,103)  				,
	       	'SISTEMA'  =  'SW'                             				, 
	       	'Cuenta'   =  '0000000000' 		      				,-- falta definicion cuentas
	       	'Moneda'   =  recibimos_moneda                    				,
	       	'Tasa'     =  case when compra_codigo_tasa = 0 THEN 1 ELSE 2 END        ,
	       	'FechaVcto'=  convert (char(08),fecha_vence_flujo,112)			, 
	       	'Monto'    =  compra_interes                      			,
	       	'Numero'   =  numero_operacion                    			,
	       	'codTasa'  =  compra_codigo_tasa 	         			,
		numero_flujo								,
		tipo_flujo								,
		'flujo_tipo' = 'J'
	FROM	cartera a ,view_cliente b
	WHERE	compra_codigo_tasa <> 0 
		AND tipo_flujo = 1
		and @dFecPro BETWEEN fecha_inicio_flujo and fecha_vence_flujo 
		and (a.rut_cliente= b.clrut and a.codigo_cliente = b.clcodigo )
                AND a.Estado <> 'C'


	INSERT INTO #tmp
	SELECT 	'Fecha'    =  convert (char(02),@dFecPro,103)				,
	       	'SISTEMA'  =  'SW'                             				, 
	       	'Cuenta'   =  '0000000000'		      				,	
	       	'Moneda'   =  pagamos_moneda                      			,
	       	'Tasa'     =  case when venta_codigo_tasa = 0 THEN 1 ELSE 2 END		,
	       	'FechaVcto'= convert (char(08),fecha_vence_flujo,112)			, 
	       	'Monto'    =  venta_interes                      			,
	       	'Numero'   =  numero_operacion                   			,   
	       	'codTasa'  =  venta_codigo_tasa 	          			,
		numero_flujo								,
		tipo_flujo								,
		'flujo_tipo' = 'J'
	FROM	cartera a ,view_cliente b
	WHERE	venta_codigo_tasa <> 0 
		AND tipo_flujo = 2
		AND @dFecPro BETWEEN fecha_inicio_flujo and fecha_vence_flujo 
		AND (a.rut_cliente = b.clrut and a.codigo_cliente = b.clcodigo )
                AND a.Estado <> 'C'

	INSERT INTO #tmp
	SELECT 	'Fecha'    =  convert (char(02),@dFecPro,103)				,
		'SISTEMA'  =  'SW'                             				, 
		'Cuenta'   =  '0000000000'		      				,	
		'Moneda'   =  pagamos_moneda                      			,
		'Tasa'     =  case when venta_codigo_tasa = 0 THEN 1 ELSE 2 END		,
		'FechaVcto'=  convert (char(08),fecha_vence_flujo,112)			, 
		'Monto'    =  venta_interes                      			,
		'Numero'   =  numero_operacion                   			,   
		'codTasa'  =  venta_codigo_tasa 	          			,
		numero_flujo								,
		tipo_flujo								,
		'flujo_tipo' = 'J'
	FROM  	cartera a ,view_cliente b
	WHERE 	venta_codigo_tasa = 0 
		AND tipo_flujo = 2
		AND   (a.rut_cliente = b.clrut and a.codigo_cliente = b.clcodigo )
                AND a.Estado <> 'C'
	----------------------------------------<< Fin Intereses en Moneda de Pago

	----------------------------------------<< Capital en Moneda de Pago
	INSERT INTO #tmp
	SELECT 	'Fecha'    =  convert (char(02),@dFecPro,103)  				,
	       	'SISTEMA'  =  'SW'                             				, 
	       	'Cuenta'   =  '0000000000' 		      				,-- falta definicion cuentas
	       	'Moneda'   =  recibimos_moneda                    				,
	       	'Tasa'     =  case when compra_codigo_tasa = 0 THEN 1 ELSE 2 END  	,
	       	'FechaVcto'=  convert (char(08),fecha_vence_flujo,112)			, 
	       	'Monto'    =  compra_capital                   				,
	       	'Numero'   =  numero_operacion  		      			,   
	       	'codTasa'  =  compra_codigo_tasa 	      				,
		numero_flujo            						,
		tipo_flujo								,
		'flujo_tipo' = 'I'
	FROM	cartera a ,view_cliente b
	WHERE	compra_codigo_tasa = 0
		AND tipo_flujo = 1
		AND (a.rut_cliente = b.clrut and a.codigo_cliente = b.clcodigo )
                AND a.Estado <> 'C'

	INSERT INTO #tmp
	sELECT 	'Fecha'    =  convert (char(02),@dFecPro,103)  				,
	       	'SISTEMA'  =  'SW'                             				, 
	       	'Cuenta'   =  '0000000000' 		      				,-- falta definicion cuentas
	       	'Moneda'   =  recibimos_moneda                    				,
	       	'Tasa'     =  case when compra_codigo_tasa = 0 THEN 1 ELSE 2 END        ,
	       	'FechaVcto'=  convert (char(08),fecha_vence_flujo,112)			, 
	       	'Monto'    =  compra_capital                      			,
	       	'Numero'   =  numero_operacion                    			,
	       	'codTasa'  =  compra_codigo_tasa 	         			,
		numero_flujo								,
		tipo_flujo								,
		'flujo_tipo' = 'I'
	FROM	cartera a ,view_cliente b
	WHERE	compra_codigo_tasa <> 0 
		AND tipo_flujo = 1
		and @dFecPro BETWEEN fecha_inicio_flujo and fecha_vence_flujo 
		and (a.rut_cliente= b.clrut and a.codigo_cliente = b.clcodigo )
                AND a.Estado <> 'C'

	INSERT INTO #tmp
	SELECT 	'Fecha'    =  convert (char(02),@dFecPro,103)				,
	       	'SISTEMA'  =  'SW'                             				, 
	       	'Cuenta'   =  '0000000000'		      				,	
	       	'Moneda'   =  pagamos_moneda                      			,
	       	'Tasa'     =  case when venta_codigo_tasa = 0 THEN 1 ELSE 2 END		,
	       	'FechaVcto'= convert (char(08),fecha_vence_flujo,112)			, 
	       	'Monto'    =  venta_capital						,
	       	'Numero'   =  numero_operacion                   			,   
	       	'codTasa'  =  venta_codigo_tasa 	          			,
		numero_flujo								,
		tipo_flujo								,
		'flujo_tipo' = 'I'
	FROM	cartera a ,view_cliente b
	WHERE	venta_codigo_tasa <> 0 
		AND tipo_flujo = 2
		AND @dFecPro BETWEEN fecha_inicio_flujo and fecha_vence_flujo 
		AND (a.rut_cliente = b.clrut and a.codigo_cliente = b.clcodigo )
                AND a.Estado <> 'C'

	INSERT INTO #tmp
	SELECT 	'Fecha'    =  convert (char(02),@dFecPro,103)				,
		'SISTEMA'  =  'SW'                             				, 
		'Cuenta'   =  '0000000000'		      				,	
		'Moneda'   =  pagamos_moneda                      			,
		'Tasa'     =  case when venta_codigo_tasa = 0 THEN 1 ELSE 2 END		,
		'FechaVcto'=  convert (char(08),fecha_vence_flujo,112)			, 
		'Monto'    =  venta_capital						,
		'Numero'   =  numero_operacion                   			,   
		'codTasa'  =  venta_codigo_tasa 	          			,
		numero_flujo								,
		tipo_flujo								,
		'flujo_tipo' = 'I'
	FROM  	cartera a ,view_cliente b
	WHERE 	venta_codigo_tasa = 0 
		AND tipo_flujo = 2
		AND   (a.rut_cliente = b.clrut and a.codigo_cliente = b.clcodigo )
                AND a.Estado <> 'C'
	---------------------------------------------------<< Fin Capital en Moneda de Pago

	SELECT		* 
	FROM 		#tmp 
	ORDER BY 	numero		,
			numero_flujo	,
			tipo_flujo

	SET NOCOUNT OFF

END
GO
