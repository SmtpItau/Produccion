USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_MTM]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




--SP_GENERA_MTM 773, '20110328'

--SP_GENERA_MTM 773, '15-01-2013'

--select convert(char(10),getdate(),23)

CREATE PROCEDURE [dbo].[SP_GENERA_MTM]
	(
		@Num_Operacion	INT
	,	@Fecha_Proceso	varchar(10)
	)
AS
BEGIN

--SELECT * FROM #TEMP_SALIDA

SET NOCOUNT ON

	CREATE TABLE #TEMP_SALIDA
		(
			ID_SECCION					INT				--> Comienzo Encabezado
		,	NUMERO_OPERACION			INT
		,	FECHA_VALORIZACION			DATETIME
		,	NOCIONAL_ACTIVO				NUMERIC(21,2)
		,	TASA_ACTIVO					NUMERIC(21,2)
		,	NOCIONAL_PASIVO				NUMERIC(21,2)
		,	TASA_PASIVO					NUMERIC(21,2)
		,	TIPO_CAMBIO					NUMERIC(21,2)	
		,	TIPO_TASA_ACTIVO			VARCHAR(10)		
		,	TIPO_TASA_PASIVO			VARCHAR(10)
		,	TIPO_NOCIONAL_ACTIVO		VARCHAR(10)
		,	TIPO_NOCIONAL_PASIVO		VARCHAR(10)		--> Fin Encabezado
		,	NOMBRE_CLIENTE				VARCHAR(90)
		,	RUT_CLIENTE					VARCHAR(10)
		
		,	FECHA_FIJACION_ACTIVO		DATETIME		--> Activos
		,	FECHA_INICIO_ACTIVO			DATETIME
		,	FECHA_VENCIMIENTO_ACTIVO	DATETIME
		,	FECHA_PAGO_ACTIVO			DATETIME
		,	SALDO_RESIDUAL_ACTIVO		NUMERIC(21,2)
		,	INTERCAMBIO_NOCIONAL_ACTIVO	VARCHAR(3)
		,	POSTPOUNDING_ACTIVO			VARCHAR(3)
		,	TASA_PORCENTAJE_ACTIVO		NUMERIC(18,2)
		,	SPREAD_PORCENTAJE_ACTIVO	NUMERIC(18,2)
		,	FLUJO_ACTIVO_VAL_PRESENTE	NUMERIC(21,2)	
		,	TOTAL_ACTIVO				NUMERIC(21,2)	--> Fin Activos
		,	FECHA_FIJACION_PASIVO		DATETIME		--> Pasivos
		,	FECHA_INICIO_PASIVO			DATETIME
		,	FECHA_VENCIMIENTO_PASIVO	DATETIME
		,	FECHA_PAGO_PASIVO			DATETIME
		,	SALDO_RESIDUAL_PASIVO		NUMERIC(21,2)
		,	INTERCAMBIO_NOCIONAL_PASIVO	VARCHAR(3)
		,	POSTPOUNDING_PASIVO			VARCHAR(3)
		,	TASA_PORCENTAJE_PASIVO		NUMERIC(18,2)
		,	SPREAD_PORCENTAJE_PASIVO	NUMERIC(18,2)
		,	FLUJO_PASIVO_VAL_PRESENTE	NUMERIC(21,2)	
		,	TOTAL_PASIVO				NUMERIC(21,2)	--> Fin Pasivos
		)
		
		 	
	--> SERVICIO 1 --> SP_ENCABEZADO_MTM
	CREATE TABLE #TEMP_SERV1
				(
					Operacion       			NUMERIC(3)
				,	FechaProceso				DATETIME       
				,	SaldoActivo	    			NUMERIC(21,2)                        
				,	SaldoPasivo					NUMERIC(21,2)
				,	TasaActivo					NUMERIC(21,2)
				,	TasaPasivo					NUMERIC(21,2)
				,	TipoCambio					NUMERIC(21,2)
				,	TIPO_TASA_ACTIVO			VARCHAR(10)		
				,	TIPO_TASA_PASIVO			VARCHAR(10)
				,	TIPO_NOCIONAL_ACTIVO		VARCHAR(10)
				,	TIPO_NOCIONAL_PASIVO		VARCHAR(10)		

				,	NOMBRE_CLIENTE				VARCHAR(90)
				,	RUT_CLIENTE					VARCHAR(10)
				)
				
	INSERT INTO #TEMP_SERV1 EXECUTE SP_ENCABEZADO_MTM @Fecha_Proceso, @Num_Operacion
	
	INSERT INTO #TEMP_SALIDA
		(
			ID_SECCION					--> Comienzo Encabezado
		,	NUMERO_OPERACION			
		,	FECHA_VALORIZACION			
		,	NOCIONAL_ACTIVO				
		,	TASA_ACTIVO					
		,	NOCIONAL_PASIVO				
		,	TASA_PASIVO					
		,	TIPO_CAMBIO					
		,	TIPO_TASA_ACTIVO	
		,	TIPO_TASA_PASIVO	
		,	TIPO_NOCIONAL_ACTIVO
		,	TIPO_NOCIONAL_PASIVO

		,	NOMBRE_CLIENTE				
		,	RUT_CLIENTE					
		
		 )
	SELECT 0
		,	Operacion
		,	convert(char(10),FechaProceso,23)
		,	SaldoActivo
		,	SaldoPasivo
		,	TasaActivo
		,	TasaPasivo
		,	TipoCambio
		,	TIPO_TASA_ACTIVO	
		,	TIPO_TASA_PASIVO	
		,	TIPO_NOCIONAL_ACTIVO
		,	TIPO_NOCIONAL_PASIVO

		,	NOMBRE_CLIENTE				
		,	RUT_CLIENTE		
		
	FROM #TEMP_SERV1
	
	DROP TABLE #TEMP_SERV1
	
	--> SERVICIO 2 --> SP_ACTIVOS_MTM	
	CREATE TABLE #TEMP_SERV2
				(
					Fecha_Fijacion				DATETIME		
				,	Fecha_Inicio				DATETIME	
				,	Fecha_Vencimiento			DATETIME
				,	Fecha_Pago					DATETIME
				,	Saldo_Residual_activo		NUMERIC(21,2)	
				,	Intercambio_Nocional		VARCHAR(2)
				,	Postpounding				VARCHAR(2)	
				,	TasaActivo					NUMERIC(21,2)
				,	Spread						NUMERIC(18,2)
				,	Flujo_ACTIVO_valor_presente	NUMERIC(21,2)
				)
				
		INSERT INTO #TEMP_SERV2 EXECUTE SP_ACTIVOS_MTM @Fecha_Proceso, @Num_Operacion
		
		INSERT INTO #TEMP_SALIDA
				(
					ID_SECCION					
				,	NUMERO_OPERACION			
				,	FECHA_VALORIZACION			
				,	NOCIONAL_ACTIVO				
				,	TASA_ACTIVO					
				,	NOCIONAL_PASIVO				
				,	TASA_PASIVO					
				,	TIPO_CAMBIO		
				
				,	TIPO_TASA_ACTIVO	
				,	TIPO_TASA_PASIVO	
				,	TIPO_NOCIONAL_ACTIVO
				,	TIPO_NOCIONAL_PASIVO	

				,	NOMBRE_CLIENTE		--> 13		
				,	RUT_CLIENTE		--> 14
						
				,	FECHA_FIJACION_ACTIVO		
				,	FECHA_INICIO_ACTIVO			
				,	FECHA_VENCIMIENTO_ACTIVO	
				,	FECHA_PAGO_ACTIVO			
				,	SALDO_RESIDUAL_ACTIVO		
				,	INTERCAMBIO_NOCIONAL_ACTIVO	
				,	POSTPOUNDING_ACTIVO			
				,	TASA_PORCENTAJE_ACTIVO		
				,	SPREAD_PORCENTAJE_ACTIVO	
				,	FLUJO_ACTIVO_VAL_PRESENTE	
				--,	TOTAL_ACTIVO				
				)
			SELECT 1
				,	''
				,	''
				,	0		
				,	0
				,	0
				,	0
				,	0
				,	''	
				,	''	
				,	''
				,	''
				,	'' --> NOMBRE_CLIENTE		--> 13		
				,	''	--> RUT_CLIENTE		--> 14

				,	Fecha_Fijacion				
				,	Fecha_Inicio				
				,	Fecha_Vencimiento			
				,	Fecha_Pago					
				,	Saldo_Residual_activo		
				,	Intercambio_Nocional		
				,	Postpounding				
				,	TasaActivo					
				,	Spread						
				,	Flujo_ACTIVO_valor_presente
			FROM #TEMP_SERV2
		--> FIN SERVICIO 2
		
		--> SUMA TOTAL ACTIVOS
		DECLARE @TOTAL_ACTIVOS AS NUMERIC(21,2)
		SET @TOTAL_ACTIVOS = (SELECT SUM(Flujo_ACTIVO_valor_presente) FROM #TEMP_SERV2)
		
		INSERT INTO #TEMP_SALIDA
				(
					ID_SECCION					
				,	NUMERO_OPERACION			
				,	FECHA_VALORIZACION			
				,	NOCIONAL_ACTIVO				
				,	TASA_ACTIVO					
				,	NOCIONAL_PASIVO				
				,	TASA_PASIVO					
				,	TIPO_CAMBIO		
				
				,	TIPO_TASA_ACTIVO	
				,	TIPO_TASA_PASIVO	
				,	TIPO_NOCIONAL_ACTIVO
				,	TIPO_NOCIONAL_PASIVO	

				,	NOMBRE_CLIENTE				
				,	RUT_CLIENTE		
							
				,	FECHA_FIJACION_ACTIVO		
				,	FECHA_INICIO_ACTIVO			
				,	FECHA_VENCIMIENTO_ACTIVO	
				,	FECHA_PAGO_ACTIVO			
				,	SALDO_RESIDUAL_ACTIVO		
				,	INTERCAMBIO_NOCIONAL_ACTIVO	
				,	POSTPOUNDING_ACTIVO			
				,	TASA_PORCENTAJE_ACTIVO		
				,	SPREAD_PORCENTAJE_ACTIVO	
				,	FLUJO_ACTIVO_VAL_PRESENTE	
				,	TOTAL_ACTIVO				
				)
			SELECT 2
				,	''
				,	''
				,	0		
				,	0
				,	0
				,	0
				,	0
				,	''	
				,	''	
				,	''
				,	''

					,	'' --> NOMBRE_CLIENTE		--> 13		
				,	''	--> RUT_CLIENTE		--> 14

				,	''				
				,	''				
				,	''			
				,	''					
				,	0		
				,	''		
				,	''				
				,	0					
				,	0					
				,	0
				,	TOTAL_ACTIVO = @TOTAL_ACTIVOS

		DROP TABLE #TEMP_SERV2
		
		--> FIN SERVICIO 2
		
		
		--> SERVICIO 3 --> SP_PASIVOS_MTM	
	CREATE TABLE #TEMP_SERV3
				(
 	    			Fecha_Fijacion_Pasivo		DATETIME		
 				,	Fecha_Inicio_Pasivo			DATETIME	
 				,	Fecha_Vencimiento_Pasivo	DATETIME	
      			,	Fecha_Pago_Pasivo			DATETIME	
      			,	Saldo_Residual_pasivo		NUMERIC(21,2)		
      			,	Intercambio_Nocional		VARCHAR(2)	
      			,	Postpounding				VARCHAR(2)		
      			,	TasaPasivo					NUMERIC(21,2)
				,	Spread						NUMERIC(18,2)
 				,	Flujo_PASIVO_valor_presente	NUMERIC(21,2)
				)
				
		INSERT INTO #TEMP_SERV3 EXECUTE SP_PASIVOS_MTM @Fecha_Proceso, @Num_Operacion
		
		INSERT INTO #TEMP_SALIDA
			(
				ID_SECCION						
				,	NUMERO_OPERACION			
				,	FECHA_VALORIZACION			
				,	NOCIONAL_ACTIVO				
				,	TASA_ACTIVO					
				,	NOCIONAL_PASIVO				
				,	TASA_PASIVO					
				,	TIPO_CAMBIO		
				
				,	TIPO_TASA_ACTIVO	
				,	TIPO_TASA_PASIVO	
				,	TIPO_NOCIONAL_ACTIVO
				,	TIPO_NOCIONAL_PASIVO
				
				,	 NOMBRE_CLIENTE		--> 13		
				,	 RUT_CLIENTE		--> 14	
							
				,	FECHA_FIJACION_ACTIVO		
				,	FECHA_INICIO_ACTIVO			
				,	FECHA_VENCIMIENTO_ACTIVO	
				,	FECHA_PAGO_ACTIVO			
				,	SALDO_RESIDUAL_ACTIVO		
				,	INTERCAMBIO_NOCIONAL_ACTIVO	
				,	POSTPOUNDING_ACTIVO			
				,	TASA_PORCENTAJE_ACTIVO		
				,	SPREAD_PORCENTAJE_ACTIVO	
				,	FLUJO_ACTIVO_VAL_PRESENTE	
				,	TOTAL_ACTIVO				
				,	FECHA_FIJACION_PASIVO		
				,	FECHA_INICIO_PASIVO			
				,	FECHA_VENCIMIENTO_PASIVO	
				,	FECHA_PAGO_PASIVO			
				,	SALDO_RESIDUAL_PASIVO		
				,	INTERCAMBIO_NOCIONAL_PASIVO	
				,	POSTPOUNDING_PASIVO			
				,	TASA_PORCENTAJE_PASIVO		
				,	SPREAD_PORCENTAJE_PASIVO	
				,	FLUJO_PASIVO_VAL_PRESENTE	
			)
				SELECT 3
				,	''
				,	''
				,	0		
				,	0
				,	0
				,	0
				,	0
				,	''				
				,	''				
				,	''			
				,	''

				,	'' --> NOMBRE_CLIENTE		--> 13		
				,	''	--> RUT_CLIENTE		--> 14

				,	''				
				,	''				
				,	''			
				,	''					
				,	0		
				,	''		
				,	''				
				,	0					
				,	0					
				,	0
				,	0
				,	Fecha_Fijacion_Pasivo
 				,	Fecha_Inicio_Pasivo			
 				,	Fecha_Vencimiento_Pasivo		
      			,	Fecha_Pago_Pasivo				
      			,	Saldo_Residual_pasivo			
      			,	Intercambio_Nocional			
      			,	Postpounding					
      			,	TasaPasivo					
				,	Spread						
 				,	Flujo_PASIVO_valor_presente
 			FROM #TEMP_SERV3
 			
 		--> SUMA TOTAL PASIVOS
		DECLARE @TOTAL_PASIVOS AS NUMERIC(21,2)
		SET @TOTAL_PASIVOS = (SELECT SUM(Flujo_PASIVO_valor_presente) FROM #TEMP_SERV3)
				
		INSERT INTO #TEMP_SALIDA
			(
				ID_SECCION						
				,	NUMERO_OPERACION			
				,	FECHA_VALORIZACION			
				,	NOCIONAL_ACTIVO				
				,	TASA_ACTIVO					
				,	NOCIONAL_PASIVO				
				,	TASA_PASIVO					
				,	TIPO_CAMBIO		
				
				,	TIPO_TASA_ACTIVO	
				,	TIPO_TASA_PASIVO	
				,	TIPO_NOCIONAL_ACTIVO
				,	TIPO_NOCIONAL_PASIVO	

				,	NOMBRE_CLIENTE		--> 13		
				,	RUT_CLIENTE		--> 14
							
				,	FECHA_FIJACION_ACTIVO		
				,	FECHA_INICIO_ACTIVO			
				,	FECHA_VENCIMIENTO_ACTIVO	
				,	FECHA_PAGO_ACTIVO			
				,	SALDO_RESIDUAL_ACTIVO		
				,	INTERCAMBIO_NOCIONAL_ACTIVO	
				,	POSTPOUNDING_ACTIVO			
				,	TASA_PORCENTAJE_ACTIVO		
				,	SPREAD_PORCENTAJE_ACTIVO	
				,	FLUJO_ACTIVO_VAL_PRESENTE	
				,	TOTAL_ACTIVO				
				,	FECHA_FIJACION_PASIVO		
				,	FECHA_INICIO_PASIVO			
				,	FECHA_VENCIMIENTO_PASIVO	
				,	FECHA_PAGO_PASIVO			
				,	SALDO_RESIDUAL_PASIVO		
				,	INTERCAMBIO_NOCIONAL_PASIVO	
				,	POSTPOUNDING_PASIVO			
				,	TASA_PORCENTAJE_PASIVO		
				,	SPREAD_PORCENTAJE_PASIVO	
				,	FLUJO_PASIVO_VAL_PRESENTE	
				,	TOTAL_PASIVO				
			)
				SELECT 4
				,	''
				,	''
				,	0		
				,	0
				,	0
				,	0
				,	0
				,	''				
				,	''				
				,	''			
				,	''
				
				,	'' --> NOMBRE_CLIENTE		--> 13		
				,	''	--> RUT_CLIENTE		--> 14
						
				,	''				
				,	''				
				,	''			
				,	''					
				,	0		
				,	''		
				,	''				
				,	0					
				,	0					
				,	0
				,	0
				,	''
 				,	''		
 				,	''	
      			,	''				
      			,	0		
      			,	''			
      			,	''					
      			,	0					
				,	0						
 				,	0
 				,  TOTAL_PASIVO = @TOTAL_PASIVOS
 				
		DROP TABLE #TEMP_SERV3
		
		--SELECT * FROM #TEMP_SALIDA
		
		
			--DROP TABLE TBL_INFORMACION_MTM
	TRUNCATE TABLE TBL_INFORMACION_MTM --dEJAR

	INSERT INTO TBL_INFORMACION_MTM SELECT * FROM #TEMP_SALIDA --dEJAR

	--SELECT * INTO  TBL_CARTOLA_AGENTES FROM #TEMP_SALIDA --WHERE 1 = 2

	SELECT * FROM TBL_INFORMACION_MTM --dEJAR
	

END
			
				
				


GO
