USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULA_DUR_CNVX_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CALCULA_DUR_CNVX_SWAP]( 
	@fecha             datetime  
       ,@Numero_Operacion  numeric(05)   
                                             )
AS 
BEGIN
--> Modelo de Proceso para el Dur, Dur Modificada yCnvx
   --> Tabla de paso para calculo de datos. 
   DECLARE @DurMacActiva        float
   DECLARE @DurModActiva        float
   DECLARE @ConvexidadActiva    float
   DECLARE @DurMacPasiva        float
   DECLARE @DurModPasiva        float
   DECLARE @ConvexidadPasiva    float
   DECLARE @TipoTasaActiva      numeric(3)
   DECLARE @TipoTasaPasiva      numeric(3)
   DECLARE @TIRActiva           float
   DECLARE @TIRPasiva           float
   DECLARE @BaseActual          float

   DECLARE @Numero_Operacion_i  numeric(5)

   select  @BaseActual = datediff( dd, @fecha, DATEADD(yy, 1, @fecha) ) 


   select  @DurMacActiva = 0.0                            
         , @DurModActiva = 0.0
         , @ConvexidadActiva = 0.0
         , @DurMacPasiva = 0.0                            
         , @DurModPasiva = 0.0
         , @ConvexidadPasiva = 0.0


   SELECT distinct 'Numero_Operacion'    = Numero_operacion
   ,      'Marca'               = ' ' 
   ,      'ActivoTir'           = ActivoTir
   ,      'PasivoTir'           = PasivoTir
--   ,      'registrocorrelativo'  = identity(INT)
   INTO   #Cart   ---SELECT  *  FROM   #Cart
   FROM   CARTERA where 
   numero_Operacion = @numero_Operacion or @numero_Operacion = 0 -- Una o todas las operaciones
   group by  Numero_Operacion, ActivoTir, PasivoTir


   DECLARE @iRegistros        INTEGER
   ,       @iRegistro         INTEGER

   SELECT  @iRegistros       = MAX(Numero_Operacion)
   ,       @iRegistro        = MIN(Numero_Operacion)
   FROM    #Cart


   WHILE @iRegistros >= @iRegistro -- 1 = 1
   BEGIN      
      select   @Numero_Operacion_i = 0
      select   @Numero_Operacion_i = Numero_Operacion 
             , @TIRActiva       = ActivoTir 
             , @TIRPasiva       = PasivoTir 
      from #Cart   
      WHERE    Numero_Operacion = @iRegistro

      if @Numero_Operacion_i <> 0 Begin
         select  @TipoTasaActiva = max( compra_codigo_tasa ) from cartera 
                                where numero_operacion = @numero_operacion_i and tipo_flujo = 1
         select  @TipoTasaPasiva = max( venta_codigo_tasa ) from cartera 
                                where numero_operacion = @numero_operacion_i and tipo_flujo = 2



         if @TipoTasaActiva = 0   begin
            declare @Compra_Mercado float 
            select  @Compra_Mercado = 0
            select  @Compra_Mercado = Compra_Mercado from cartera where numero_operacion =  @numero_operacion_i and tipo_flujo = 1 and fecha_vence_Flujo > @fecha
            if @Compra_Mercado = 0 
                select   @DurMacActiva = 0.0
                    , @DurModActiva = 0.0
                    , @ConvexidadActiva = 0.0 
            else   
                select 
                   @DurMacActiva = sum( Activo_FlujoMO * datediff( dd, @fecha, fecha_Vence_Flujo ) / @BaseActual 
                                    ) / sum(  Activo_FlujoMO )                 
                 , @DurModActiva = sum( Activo_FlujoMO * datediff( dd, @fecha, fecha_Vence_Flujo ) / @BaseActual 
                                    ) / sum(  Activo_FlujoMO )  / ( 1.0 + @TIRActiva/100 ) 
                 , @ConvexidadActiva = sum( Activo_FlujoMO * datediff( dd, @fecha, fecha_Vence_Flujo )/ @BaseActual 
                                    * ( datediff( dd, @fecha, fecha_Vence_Flujo )/ @BaseActual + 1.0 )
                                   )/ sum(  Activo_FlujoMO )  / power( 1.0 + @TIRActiva/100, 2 ) 
                from cartera where numero_operacion = @numero_operacion_i and tipo_flujo = 1 and fecha_vence_Flujo > @fecha
      
            end


            if @TipoTasaActiva <> 0 
               select  @DurMacActiva = max( datediff( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual 
           ,           @DurModActiva = max( datediff( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual 
                                  / ( 1 + @TIRActiva/100.0 ) 
           ,           @ConvexidadActiva = max( datediff( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual 
                                   * ( max( datediff( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual + 1.0 )
                                   / power( 1 + @TIRActiva/100, 2 ) 
           from cartera 
           where   numero_operacion = @numero_operacion_i
              and ( fecha_fijacion_tasa < @Fecha or estado_flujo = 1 )
              and tipo_Flujo = 1


          if @TipoTasaPasiva <> 0      
              select @DurMacPasiva = max( datediff( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual 
          ,          @DurModPasiva = max( datediff( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual 
                     / ( 1 + @TIRActiva/100.0 ) 
          ,          @ConvexidadPasiva = max( datediff( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual 
                                   * ( max( datediff( dd, @fecha, fecha_vence_Flujo ) ) / @BaseActual + 1.0 )
                                   / power( 1 + @TIRActiva/100, 2 ) 
          from cartera 
          where     numero_operacion = @numero_operacion_i
              and ( fecha_fijacion_tasa < @Fecha or estado_flujo = 1 )
              and tipo_Flujo = 2

          if @TipoTasaPasiva = 0 begin
              declare @Venta_Mercado float 
              select  @Venta_Mercado = 0
              select  @Venta_Mercado = Venta_Mercado from cartera where numero_operacion =  @numero_operacion_i and tipo_flujo = 2 and fecha_vence_Flujo > @fecha
              if @Venta_Mercado = 0 
                 select   @DurMacPasiva = 0.0
                        , @DurModPasiva = 0.0
                        , @ConvexidadPasiva = 0.0
                 else   
                   select 
                     @DurMacPasiva = sum( Pasivo_FlujoMO * datediff( dd, @fecha, fecha_Vence_Flujo ) / @BaseActual 
                                ) / sum(  Pasivo_FlujoMO )                   
                   , @DurModPasiva = sum( Pasivo_FlujoMO * datediff( dd, @fecha, fecha_Vence_Flujo ) / @BaseActual
                                ) / sum(  Pasivo_FlujoMO ) / ( 1.0 + @TIRActiva/100 ) 

                   , @ConvexidadPasiva = sum( Pasivo_FlujoMO * datediff( dd, @fecha, fecha_Vence_Flujo ) / @BaseActual 
                                     * ( datediff( dd, @fecha, fecha_Vence_Flujo ) / @BaseActual + 1.0 )
                                    ) / sum(  Pasivo_FlujoMO ) / power( 1.0 + @TIRActiva/100, 2 )    
                   from cartera where numero_operacion = @numero_operacion_i 
                          and tipo_flujo = 2 
                          and fecha_vence_Flujo > @fecha
           end


          UPDATE CARTERA SET
                 VDurMacaulActivo  = isnull( @DurMacActiva, 0 )
               , VDurModifiActivo  = isnull( @DurModActiva, 0 )
               , VDurConvexActivo  = isnull( @ConvexidadActiva, 0 )
           where numero_operacion = @numero_operacion_i and tipo_flujo = 1

          UPDATE CARTERA SET
                 VDurMacaulPasivo  = isnull( @DurMacPasiva, 0 )
               , VDurModifiPasivo  = isnull( @DurModPasiva, 0 )
               , VDurConvexPasivo  = isnull( @ConvexidadPasiva, 0 )
           where numero_operacion = @numero_operacion_i and tipo_flujo = 2

           -->Actualizando marca en cartera temporal
           /*
           UPDATE #Cart 
           SET    Marca   = '-'
           WHERE  Numero_Operacion = @Numero_Operacion_i
           */
        END
        SET @iRegistro = @iRegistro + 1
   END -- While

END

GO
