USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULA_DUR_CNVX_SWAP_TIM]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CALCULA_DUR_CNVX_SWAP_TIM](  @fecha              DATETIME  
						,	@Numero_Operacion_i	NUMERIC(05)   )
AS 
BEGIN
	DECLARE @DurMacActiva        	FLOAT
	,	@DurModActiva        	FLOAT
	,	@ConvexidadActiva    	FLOAT
	,	@DurMacPasiva        	FLOAT
	,	@DurModPasiva        	FLOAT
	,	@ConvexidadPasiva    	FLOAT
	,	@TIRActiva           	FLOAT
	,	@TIRPasiva           	FLOAT
	,	@Compra_Mercado 	FLOAT 
	,	@Venta_Mercado 		FLOAT 
	,	@BaseActual          	FLOAT			;

	DECLARE @TipoTasaActiva      	NUMERIC(3)
	,	@TipoTasaPasiva      	NUMERIC(3)		;

--	DECLARE @Numero_Operacion_i  	NUMERIC(5)		;


	SELECT  @BaseActual = DATEDIFF( dd, @fecha, DATEADD(yy, 1, @fecha) ) 	;

	SELECT  @DurMacActiva 		= 0.0                            
        ,	@DurModActiva 		= 0.0
        , 	@ConvexidadActiva 	= 0.0
        , 	@DurMacPasiva 		= 0.0                            
        , 	@DurModPasiva 		= 0.0
        , 	@ConvexidadPasiva 	= 0.0		;


	SELECT  DISTINCT 
		@TIRActiva       = ActivoTir 
	,	@TIRPasiva       = PasivoTir 
	  FROM  tbl_CARticketswap
	WHERE   Numero_Operacion = @Numero_Operacion_i  ;
	



      IF @Numero_Operacion_i <> 0 BEGIN

		SELECT  @TipoTasaActiva = MAX( compra_codigo_tasa ) 
	  	  FROM cartera 
		 WHERE numero_operacion = @numero_operacion_i 
		   AND tipo_flujo = 1
         
		SELECT @TipoTasaPasiva = MAX( venta_codigo_tasa ) 
		  FROM cartera 
    		 WHERE numero_operacion = @numero_operacion_i 
 		   AND tipo_flujo = 2

	IF @TipoTasaActiva = 0   
	BEGIN

		SET @Compra_Mercado = 0		;
	
		
		SELECT @Compra_Mercado = Compra_Mercado 
	      	  FROM cartera 
	         WHERE numero_operacion =  @numero_operacion_i 
	          AND tipo_flujo = 1 
	         AND fecha_vence_Flujo > @fecha	;
	
		IF @Compra_Mercado = 0 
			SELECT  @DurMacActiva = 0.0
                    	, 	@DurModActiva = 0.0
                    	,	@ConvexidadActiva = 0.0 				;
		ELSE   
			SELECT 
				@DurMacActiva = sum( Activo_FlujoMO * datediff( dd, @fecha, fecha_Vence_Flujo ) / @BaseActual ) / sum( Activo_FlujoMO )                 
			, 	@DurModActiva = sum( Activo_FlujoMO * datediff( dd, @fecha, fecha_Vence_Flujo ) / @BaseActual ) / sum(  Activo_FlujoMO )  / ( 1.0 + @TIRActiva/100 ) 
			,	@ConvexidadActiva = sum( Activo_FlujoMO * datediff( dd, @fecha, fecha_Vence_Flujo )/ @BaseActual * ( datediff( dd, @fecha, fecha_Vence_Flujo )/ @BaseActual + 1.0 ) )/ sum(  Activo_FlujoMO )  / power( 1.0 + @TIRActiva/100, 2 ) 
			  FROM tbl_fljticketswap 
			 WHERE numero_operacion = @numero_operacion_i 
			   AND tipo_flujo = 1 
			   AND fecha_vence_Flujo > @fecha				;
	END

	IF @TipoTasaActiva <> 0 
		SELECT	@DurMacActiva = MAX( DATEDIFF( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual 
		,	@DurModActiva = MAX( DATEDIFF( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual  / ( 1 + @TIRActiva/100.0 ) 
		,	@ConvexidadActiva = MAX( DATEDIFF( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual  * ( MAX( DATEDIFF( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual + 1.0 ) / power( 1 + @TIRActiva/100, 2 ) 
		  FROM tbl_fljticketswap 
		 WHERE numero_operacion = @numero_operacion_i
           	   AND tipo_Flujo = 1
                   AND (fecha_fijacion_tasa < @Fecha or estado_flujo = 1)		;
            

	IF @TipoTasaPasiva <> 0      
		SELECT 	@DurMacPasiva = MAX( DATEDIFF( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual 
		,	@DurModPasiva = MAX( DATEDIFF( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual / ( 1 + @TIRActiva/100.0 ) 
		,	@ConvexidadPasiva = MAX( DATEDIFF( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual * ( MAX( DATEDIFF( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual + 1.0 ) / POWER( 1 + @TIRActiva/100, 2 ) 
		  FROM tbl_fljticketswap 
		 WHERE numero_operacion = @numero_operacion_i
		   AND tipo_Flujo = 2
		   AND ( fecha_fijacion_tasa < @Fecha or estado_flujo = 1 )		;
              

	IF @TipoTasaPasiva = 0 
	BEGIN
		SET @Venta_Mercado = 0		;				

		SET @Venta_Mercado = ( SELECT Venta_Mercado 
					 FROM tbl_fljticketswap
					WHERE numero_operacion =  @numero_operacion_i 
					  AND tipo_flujo = 2 
					  AND fecha_vence_Flujo > @fecha )		;

		IF @Venta_Mercado = 0 	
			SELECT  @DurMacPasiva		= 0.0
                        ,	@DurModPasiva 		= 0.0
                        , 	@ConvexidadPasiva	= 0.0
		ELSE   
			SELECT 	@DurMacPasiva     = SUM( Pasivo_FlujoMO * datediff( dd, @fecha, fecha_Vence_Flujo ) / @BaseActual ) / sum(  Pasivo_FlujoMO )                   
                   	,	@DurModPasiva 	  = SUM( Pasivo_FlujoMO * datediff( dd, @fecha, fecha_Vence_Flujo ) / @BaseActual ) / sum(  Pasivo_FlujoMO ) / ( 1.0 + @TIRActiva/100 ) 
--			,	@ConvexidadPasiva = SUM( Pasivo_FlujoMO * datediff( dd, @fecha, fecha_Vence_Flujo ) / @BaseActual  * ( datediff( dd, @fecha, fecha_Vence_Flujo ) / @BaseActual + 1.0 ) / sum(  Pasivo_FlujoMO ) / power( 1.0 + @TIRActiva/100, 2 )    
			  FROM 	tbl_fljticketswap 
			 WHERE numero_operacion = @numero_operacion_i 
                           AND tipo_flujo = 2 
                           AND fecha_vence_Flujo > @fecha
		END


          UPDATE CARTERA SET
                 VDurMacaulActivo  = isnull( @DurMacActiva, 0 )
               , VDurModifiActivo  = isnull( @DurModActiva, 0 )
               , VDurConvexActivo  = isnull( @ConvexidadActiva, 0 )
           where numero_operacion = @numero_operacion_i 
           and tipo_flujo = 1

          UPDATE CARTERA SET
                 VDurMacaulPasivo  = isnull( @DurMacPasiva, 0 )
               , VDurModifiPasivo  = isnull( @DurModPasiva, 0 )
               , VDurConvexPasivo  = isnull( @ConvexidadPasiva, 0 )
           where numero_operacion = @numero_operacion_i 
           and tipo_flujo = 2

        END

END
GO
