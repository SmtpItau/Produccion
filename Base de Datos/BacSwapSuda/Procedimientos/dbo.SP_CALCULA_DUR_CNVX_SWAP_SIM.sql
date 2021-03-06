USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULA_DUR_CNVX_SWAP_SIM]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CALCULA_DUR_CNVX_SWAP_SIM]  
		( @fecha             datetime
		, @Numero_Operacion  NUMERIC(05)   
		)
AS 
BEGIN
--> Modelo de Proceso para el Dur, Dur Modificada yCnvx
   --> Tabla de paso para calculo de datos. 
   DECLARE @DurMacActiva        FLOAT
   DECLARE @DurModActiva        FLOAT
   DECLARE @ConvexidadActiva    FLOAT
   DECLARE @DurMacPasiva        FLOAT
   DECLARE @DurModPasiva        FLOAT
   DECLARE @ConvexidadPasiva    FLOAT
   DECLARE @TipoTasaActiva      NUMERIC(3)
   DECLARE @TipoTasaPasiva      NUMERIC(3)
   DECLARE @TIRActiva           FLOAT
   DECLARE @TIRPasiva           FLOAT
   DECLARE @BaseActual          FLOAT

   DECLARE @Numero_Operacion_i  NUMERIC(5)

   SELECT  @BaseActual = DATEDIFF( dd, @fecha, DATEADD(yy, 1, @fecha) ) 

   SELECT  @DurMacActiva = 0.0                            
         , @DurModActiva = 0.0
         , @ConvexidadActiva = 0.0
         , @DurMacPasiva = 0.0                            
         , @DurModPasiva = 0.0
         , @ConvexidadPasiva = 0.0


   SELECT distinct 'Numero_Operacion'    = Numero_operacion
   ,      'Marca'               = ' ' 
   ,      'ActivoTir'           = ActivoTir
   ,      'PasivoTir'           = PasivoTir
   INTO   #Cart  
   FROM   CARTERA_SIM WHERE 
   numero_Operacion = @numero_Operacion OR @numero_Operacion = 0 -- Una o todas las operaciones
   GROUP BY  Numero_Operacion, ActivoTir, PasivoTir

   DECLARE @iRegistros        INTEGER
   ,       @iRegistro         INTEGER
   SELECT  @iRegistros       = MAX(Numero_Operacion)
   ,       @iRegistro        = MIN(Numero_Operacion)
   FROM    #Cart

   WHILE @iRegistros >= @iRegistro
   BEGIN      
      SELECT   @Numero_Operacion_i = 0
      SELECT   @Numero_Operacion_i = Numero_Operacion 
             , @TIRActiva       = ActivoTir 
             , @TIRPasiva       = PasivoTir 
      FROM #Cart   
      WHERE    Numero_Operacion = @iRegistro

      IF @Numero_Operacion_i <> 0 Begin
         SELECT  @TipoTasaActiva = MAX( compra_codigo_tasa ) 
         	FROM cartera_sim 
            WHERE numero_operacion = @numero_operacion_i 
            AND tipo_flujo = 1
         
         SELECT  @TipoTasaPasiva = MAX( venta_codigo_tasa ) 
         	FROM cartera_sim 
            WHERE numero_operacion = @numero_operacion_i 
            AND tipo_flujo = 2

         IF @TipoTasaActiva = 0   
		 BEGIN
            DECLARE @Compra_Mercado FLOAT 
            SELECT  @Compra_Mercado = 0
            SELECT  @Compra_Mercado = Compra_Mercado 
			FROM cartera_sim
			WHERE numero_operacion =  @numero_operacion_i 
			AND tipo_flujo = 1 
			AND fecha_vence_Flujo > @fecha
            IF @Compra_Mercado = 0 
                SELECT   @DurMacActiva = 0.0
                    , @DurModActiva = 0.0
                    , @ConvexidadActiva = 0.0 
            ELSE   
                SELECT 
                   @DurMacActiva = SUM( Activo_FlujoMO * DATEDIFF( dd, @fecha, fecha_Vence_Flujo ) / @BaseActual 
                                    ) / SUM(  Activo_FlujoMO )                 
                 , @DurModActiva = SUM( Activo_FlujoMO * DATEDIFF( dd, @fecha, fecha_Vence_Flujo ) / @BaseActual 
                                    ) / SUM(  Activo_FlujoMO )  / ( 1.0 + @TIRActiva/100 ) 
                 , @ConvexidadActiva = SUM( Activo_FlujoMO * DATEDIFF( dd, @fecha, fecha_Vence_Flujo )/ @BaseActual 
                                    * ( DATEDIFF( dd, @fecha, fecha_Vence_Flujo )/ @BaseActual + 1.0 )
                                   )/ SUM(  Activo_FlujoMO )  / POWER( 1.0 + @TIRActiva/100, 2 ) 
                FROM cartera_sim 
                WHERE numero_operacion = @numero_operacion_i 
                AND tipo_flujo = 1 
                AND fecha_vence_Flujo > @fecha
            END

        IF @TipoTasaActiva <> 0 
               SELECT  @DurMacActiva = MAX( DATEDIFF( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual 
           ,           @DurModActiva = MAX( DATEDIFF( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual 
                                  / ( 1 + @TIRActiva/100.0 ) 
           ,           @ConvexidadActiva = MAX( DATEDIFF( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual 
                                   * ( MAX( DATEDIFF( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual + 1.0 )
                                   / POWER( 1 + @TIRActiva/100, 2 ) 
           FROM cartera_sim 
           WHERE   numero_operacion = @numero_operacion_i
           	  AND tipo_Flujo = 1
              AND ( fecha_fijacion_tasa < @Fecha OR estado_flujo = 1 )
          IF @TipoTasaPasiva <> 0      
              SELECT @DurMacPasiva = MAX( DATEDIFF( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual 
          ,          @DurModPasiva = MAX( DATEDIFF( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual 
                     / ( 1 + @TIRActiva/100.0 ) 
          ,          @ConvexidadPasiva = MAX( DATEDIFF( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual 
                                   * ( MAX( DATEDIFF( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual + 1.0 )
                                   / POWER( 1 + @TIRActiva/100, 2 ) 
          FROM cartera_sim 
          WHERE     numero_operacion = @numero_operacion_i
              AND tipo_Flujo = 2
              AND ( fecha_fijacion_tasa < @Fecha OR estado_flujo = 1 )

          IF @TipoTasaPasiva = 0 
		  BEGIN
              DECLARE @Venta_Mercado FLOAT 
              SELECT  @Venta_Mercado = 0
              SELECT  @Venta_Mercado = Venta_Mercado 
			  FROM cartera_sim
			  WHERE numero_operacion =  @numero_operacion_i 
			  AND tipo_flujo = 2 
			  AND fecha_vence_Flujo > @fecha
              IF @Venta_Mercado = 0 
                 SELECT   @DurMacPasiva = 0.0
                        , @DurModPasiva = 0.0
                        , @ConvexidadPasiva = 0.0
                 ELSE   
                   SELECT 
                     @DurMacPasiva = SUM( Pasivo_FlujoMO * DATEDIFF( dd, @fecha, fecha_Vence_Flujo ) / @BaseActual 
                                ) / SUM(  Pasivo_FlujoMO )                   
                   , @DurModPasiva = SUM( Pasivo_FlujoMO * DATEDIFF( dd, @fecha, fecha_Vence_Flujo ) / @BaseActual
                                ) / SUM(  Pasivo_FlujoMO ) / ( 1.0 + @TIRActiva/100 ) 
                   , @ConvexidadPasiva = SUM( Pasivo_FlujoMO * DATEDIFF( dd, @fecha, fecha_Vence_Flujo ) / @BaseActual 
                                     * ( DATEDIFF( dd, @fecha, fecha_Vence_Flujo ) / @BaseActual + 1.0 )
                                    ) / SUM(  Pasivo_FlujoMO ) / POWER( 1.0 + @TIRActiva/100, 2 )    
                   FROM cartera_sim 
				   WHERE numero_operacion = @numero_operacion_i 
                          AND tipo_flujo = 2 
                          AND fecha_vence_Flujo > @fecha
			END
			UPDATE CARTERA_SIM 
			SET VDurMacaulActivo  = ISNULL( @DurMacActiva, 0 )
               , VDurModifiActivo  = ISNULL( @DurModActiva, 0 )
               , VDurConvexActivo  = ISNULL( @ConvexidadActiva, 0 )
           WHERE numero_operacion = @numero_operacion_i 
           AND tipo_flujo = 1

          UPDATE CARTERA_SIM 
		  SET VDurMacaulPasivo  = ISNULL( @DurMacPasiva, 0 )
           , VDurModifiPasivo  = ISNULL( @DurModPasiva, 0 )
               , VDurConvexPasivo  = ISNULL( @ConvexidadPasiva, 0 )
           WHERE numero_operacion = @numero_operacion_i 
           AND tipo_flujo = 2
        END
        SET @iRegistro = @iRegistro + 1
   END -- While
END
GO
