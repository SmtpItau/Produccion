USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CIERREMESA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CIERREMESA]  
AS  
BEGIN   
    -- Swap: Guardar Como, control de proceso fijacion de tasa  
    SET NOCOUNT ON    
    BEGIN TRANSACTION    
		DECLARE @nivel          CHAR(2)  
		DECLARE @msg            CHAR(80)
		DECLARE @fechaproc      DATETIME  
		DECLARE @FaltaFijarTasa CHAR(1)  
		DECLARE @ccierremesa    CHAR(01)  
		DECLARE @fechaProcAnt   Datetime  -- MAP 20081209    
	
	SELECT	@ccierremesa = cierreMesa  
			, @fechaproc   = fechaproc  
			, @fechaProcAnt = fechaant    -- MAP 20081209  
    FROM dbo.SwapGeneral    
    IF @ccierremesa = '1'  -- Mesa cerrada, se quiere abrir
		BEGIN  
        -->     Activa Control de Actualización de Lineas de Credito.
        DECLARE @Sw_Lineas   INTEGER  
            SET @Sw_Lineas   = (SELECT tasamtm FROM SWAPGENERAL )   
        /*   
        IF @Sw_Lineas = 0  
        BEGIN  
           ROLLBACK TRANSACTION  
           SELECT -1, 'No Se Ha Realizado el Proceso de Actualización de Líneas Para Swap.' 
           RETURN  
        END  
        */     
        UPDATE SWAPGENERAL 
        SET cierreMesa   = '0'  
             , contabilidad = 0  
             , devengo      = 0  
             , findia       = 0  
        SET @nivel = '0'  
        SET @msg   = 'Mesa Abierta' 
    END ELSE  
    BEGIN 
        UPDATE SWAPGENERAL  
        SET cierreMesa   = '1'  
             , contabilidad = 0  
             , devengo      = 0  
             , findia       = 0  
        SET @nivel = '1'  
        SET @msg   = 'Mesa Cerrada'  
    END  
	
    IF EXISTS( SELECT * FROM cartera WHERE ( Estado_oper_lineas = 'P' OR Estado_oper_lineas = 'R') AND Estado <> 'C'  )  
	BEGIN  
        UPDATE SwapGeneral SET cierreMesa = '0'  -- Mesa queda abierta 
		SET @nivel = '-1'  
		SET @msg = 'Operaciones con Problemas de Líneas'    
    END ELSE  
    BEGIN  
        -- Verificar si se han fijado todas las tasas a fijar  
        SET @FaltaFijarTasa = 'N'  
        SELECT @FaltaFijarTasa = 'S' 
        FROM dbo.CARTERA   
        WHERE fecha_fijacion_tasa  <= @fechaproc  AND  fecha_fijacion_tasa > @fechaProcAnt   -- MAP 20081209  
           AND tipo_flujo           = 1  
           AND Compra_Codigo_Tasa  <> 0                  -- Tasa Var.  
           AND Compra_codigo_tasa  <> 13                 -- ICP  
           AND compra_zcr           = 0                  -- Tasa no fijada  
           AND estado              <> 'C'                -- No es cotizacion 
           AND Fecha_Inicio_Flujo  <> Fecha_Vence_Flujo  -- No es flujo efectivo   
        
		SELECT @FaltaFijarTasa = 'S'  
          FROM dbo.CARTERA   
         WHERE fecha_fijacion_tasa  <= @fechaproc  AND  fecha_fijacion_tasa > @fechaProcAnt   -- MAP 20081209  
           AND tipo_flujo           = 2  
           AND Venta_Codigo_Tasa   <> 0                  -- Tasa Var.  
           AND Venta_codigo_tasa   <> 13                 -- ICP  
           AND Venta_zcr            = 0                  -- Tasa no fijada  
           AND estado              <> 'C'                -- No es cotizacion
           AND Fecha_Inicio_Flujo  <> Fecha_Vence_Flujo  -- No es flujo efectivo   
        IF @FaltaFijarTasa = 'S'   
        BEGIN  
            UPDATE SwapGeneral  
            SET cierreMesa = '0'  -- Mesa queda abierta  
            SET @nivel = '-1'  
            SET @msg = 'Hay flujos variables sin fijar Tasas'   
        END  
        -- Verificar que  no existan  estados de  envío EN ESPERA
			IF  EXISTS( SELECT 1 FROM BacSwapSuda.dbo.FLUJOS_VCTOS_SPOT WHERE EstadoEnvio = 0) 
            BEGIN
                UPDATE SwapGeneral SET cierreMesa = '0'  -- Mesa queda abierta   
			    SET @nivel = '-1'
				SET @msg = 'Existen flujos vencidos EN ESPERA debe cambiar estado o enviar a Spot'
            END
         -- Verificar que no haya fechas de liquidación en feriado, por lo menos en 1 año  		    
			declare @FechaCorteRevisaFeriados datetime
			declare @msgFeriados varchar(200)
			set @FechaCorteRevisaFeriados = dateadd( dd, 360, (SELECT fechaproc FROM BacSwapsuda..SwapGeneral WITH(NOLOCK))	)
		    set @msgFeriados = ''
			select distinct  fechaliquidacion into #FechasLiquidacion from dbo.cartera 
			 where estado <> 'C'  and fechaliquidacion <= @FechaCorteRevisaFeriados

            declare @FechaMaxProxima datetime
			declare @Advertencia varchar(1) = 'S'
			select  @FechaMaxProxima = '19000101'
			
			select @msgFeriados = @msgFeriados + convert( varchar(20), fechaliquidacion, 3 ) + ' * ' -- SP_CIERREMESA
			       -- Para obtener la fecha feriado más proxima
			     , @FechaMaxProxima = case when @FechaMaxProxima = '19000101' then fechaliquidacion else @FechaMaxProxima end
			 from #FechasLiquidacion where fechaliquidacion <> bacparamsuda.dbo.fx_regla_feriados_internacionales(  fechaliquidacion, ';6;' )
			 order by fechaLiquidacion 

			 select @Advertencia = 'N' from SwapGeneral C where @FechaMaxProxima between C.fechaproc and c.fechaprox

			 -- select '@msgFeriados', @msgFeriados
			 drop table #FechasLiquidacion
			 if @msgFeriados <> '' and @Advertencia = 'N'
			 begin
                UPDATE SwapGeneral SET cierreMesa =  '0'  -- Mesa queda siempre abierta
			    SET @nivel = '-1'
				SET @msg = substring(  'LIQUIDACIONES Feriado ' + @msgFeriados , 1, 69 ) + '...CORREGIR'              
			 end
			 if @msgFeriados <> '' and @Advertencia = 'S'
			 begin
                UPDATE SwapGeneral SET cierreMesa = case when @ccierremesa = 0 then '1' else '0' end   -- Mesa queda cerrada
			    SET @nivel = case when @ccierremesa = 0 then '1' else '0' end
				SET @msg = substring(  'ADVERTENCIA liq. caen Feriado ' + @msgFeriados , 1, 69 )               
			 end

    END  

				/*INI COMDER*/
			DECLARE @FECHA DATETIME
			SET		@FECHA  = (SELECT fechaproc FROM BacSwapsuda..SwapGeneral WITH(NOLOCK))			
			DECLARE @EXISTEN AS NUMERIC
			SET @EXISTEN = (SELECT COUNT(*) FROM bdbomesa..ComDer_SolicitudEstado se WITH(NOLOCK) INNER JOIN bdbomesa..ComDer_Solicitud s WITH(NOLOCK) ON
							s.numero_operacion = se.numero_operacion 
							WHERE se.id in
						(   SELECT MAX(id)FROM bdbomesa..ComDer_SolicitudEstado WITH(NOLOCK)
							WHERE CONVERT(VARCHAR(10), fecha, 112) = CONVERT(VARCHAR(10), @fecha, 112)
							GROUP BY numero_operacion
						)	AND id_estado IN (1,2,3,4,5,7,8,9,12,13,14,15,16,17,18,19,20,21)
						AND s.sistema = 'PCS'
						) 
					--SELECT @EXISTEN	
						
												
			IF (@EXISTEN > 0)
			BEGIN
				SELECT @nivel = '-1'
				SELECT @msg = 'Existen operaciones pendientes y/o rechazadas en ComDer'
			END			
		END   
		/*FIN COMDER*/



    IF @@ERROR <> 0 
    BEGIN   
		ROLLBACK TRANSACTION   

        SET @nivel = '-1'  
        SET @msg   = 'PROBLEMAS AL REALIZAR PROCESO'    

    END ELSE  
    BEGIN  
        COMMIT TRANSACTION   
    END   


		SELECT @nivel, @msg   
	SET NOCOUNT OFF  

	/* Generando caso de uso:
	--select * from bacSwapSuda.dbo.swapgeneral 
	update bacSwapSuda.dbo.swapgeneral 
	    set fechaprox = '20150625' 

    -- recuperar
	update bacSwapSuda.dbo.swapgeneral 
	    set fechaprox = '20150624' 

    -- crear feriado en chile el 24 de junio fijo.

	select * from cartera where fechaliquidacion ='20150626' and estado not in ( 'C', 'N')
	-- 1455
	update cartera set fechaliquidacion = '20150627' -- '20150626'
	where fechaliquidacion = '20150626' and numero_operacion = 1455


	*/
	
GO
