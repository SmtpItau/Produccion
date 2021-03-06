USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SRV_CALCULO_TPCA_DEV]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SRV_CALCULO_TPCA_DEV]    
   (   @iMoneda				INTEGER     
   ,   @dInicio				DATETIME  
   ,   @dTermino			DATETIME  
   ,   @Retorno				NUMERIC(21,4)   OUTPUT  
   ,   @Fecha_Proc			DATETIME   = '19000101'  
   ,   @Fecha_Prox			DATETIME   = '19000101'  
   ,   @Decimales_ICP       numeric(5)
   ,   @HabilAnteriorSN     varchar(1) 
   )  
AS  
BEGIN  
	
	/*
	-- ICP's caen en dias feriado ya cumplidos
	DECLARE @iTCP FLOAT
	SET @iTCP = 0.0
	EXEC dbo.SRV_CALCULO_TPCA_DEV_MAP 998, '20141222', '20150621', @iTCP OUTPUT , '19000101', '19000101', 4, 'S' -- N da 0.283  S da 0.2336
	SELECT @iTCP
	
	-- ICP's caen en dias feriado inicio termino feriado futuro
	DECLARE @iTCP FLOAT
	SET @iTCP = 0.0
	EXEC SRV_CALCULO_TPCA_DEV_MAP 999, '20140412', '20150716',@iTCP OUTPUT , '19000101', '19000101', 2
	SELECT @iTCP

	-- ICP's revision cartera completa el 22 de Junio 
	DECLARE @iTCP FLOAT
	SET @iTCP = 0.0
	EXEC SRV_CALCULO_TPCA_DEV_MAP 999, '20150101', '20150701',@iTCP OUTPUT , '19000101', '19000101', 2
	SELECT @iTCP

	DECLARE @iTCP FLOAT
	SET @iTCP = 0.0
	EXEC SRV_CALCULO_TPCA_DEV_MAP 999, '20150201', '20150701',@iTCP OUTPUT , '19000101', '19000101', 2
	SELECT @iTCP

	DECLARE @iTCP FLOAT
	SET @iTCP = 0.0
	EXEC SRV_CALCULO_TPCA_DEV_MAP 998, '20150201', '20150701',@iTCP OUTPUT , '19000101', '19000101', 2
	SELECT @iTCP

	DECLARE @iTCP FLOAT
	SET @iTCP = 0.0
	EXEC SRV_CALCULO_TPCA_DEV_MAP 999, '20150622', '20151222',@iTCP OUTPUT , '19000101', '19000101', 3
	SELECT @iTCP


	-- Vencido el 20 !!! caso chori..
	DECLARE @iTCP FLOAT
	SET @iTCP = 0.0
	EXEC SRV_CALCULO_TPCA_DEV_MAP 999, '20141220', '20150620',@iTCP OUTPUT , '19000101', '19000101', 3
	SELECT @iTCP



	DECLARE @iTCP FLOAT
	SET @iTCP = 0.0
	EXEC SRV_CALCULO_TPCA_DEV_PRODUCCION 998, '20150201', '20150801',@iTCP OUTPUT , '19000101', '19000101'
	SELECT @iTCP

	DECLARE @iTCP FLOAT
	SET @iTCP = 0.0
	EXEC SRV_CALCULO_TPCA_DEV_PRODUCCION 998, '20150622', '20151222',@iTCP OUTPUT , '19000101', '19000101'
	SELECT @iTCP



	-- ICP's Pendiente probar cuando la fecha de proceso es fme (hay que mover Swap)
	-- Mayo 29
	-- Ojo con los cierre y apertura de mesa
	DECLARE @iTCP FLOAT 
	SET @iTCP = 0.0
	EXEC SRV_CALCULO_TPCA_DEV_MAP 999, '20140412', '20150601',@iTCP OUTPUT , '19000101', '19000101', 2
	SELECT @iTCP
	
	
	
    */
    
   SET NOCOUNT ON   
  
   DECLARE @cDate_Hoy   DATETIME  
   ,       @cDate_Ayer  DATETIME  
   ,       @iIcp_Ayer   FLOAT  
   ,       @iIcp_Hoy    FLOAT  
   ,       @iTCIP_30    FLOAT  
   ,       @iTCIP_360   FLOAT  
   ,       @iCodigo_ICP INTEGER  
   ,       @DifDias     FLOAT  
   ,       @Retorno_999 NUMERIC(21,4)  
   ,       @Retorno_998 NUMERIC(21,4)  
   ,       @Uf_Ayer     FLOAT  
   ,       @Uf_Hoy      FLOAT  
   ,       @Ternimo     CHAR(1)  
   ,       @Comienzo    CHAR(1)  
   ,	   @decimales	SMALLINT
   ,       @fechaAux    datetime
   ,       @FechaRescateICPInicio datetime
   ,       @FechaRescateICPFinal  datetime
   /*FIN ASIGNACION DECIMAL PRD - 21841********************************************************************/

	
   IF @iMoneda	 = 998
   BEGIN
		SET @decimales = 4
   END
   ELSE
   BEGIN
	   Set @decimales	= @Decimales_ICP
   END
   
   /*FIN ASIGNACION DECIMAL PRD - 21841********************************************************************/
     
   SET @iCodigo_ICP = 800  
     
   IF @Fecha_Proc = '19000101' BEGIN  
      -- POR MIENTRAS
      SELECT  @cDate_Ayer  = fechaant  
      ,       @cDate_Hoy   = fechaproc  
      FROM    BACSWAPSUDA..SWAPGENERAL    
   END  
   ELSE 
   	BEGIN   
      SET @cDate_Hoy = @Fecha_Proc  
      EXEC BACTRADERSUDA..SP_BUSCA_FECHA_HABIL @Fecha_Proc , -1,  @cDate_Ayer OUTPUT    
   END  
  
   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos  
    DECLARE @FechaCalculos    DATETIME  
    SELECT @FechaCalculos    = CASE /* WHEN cierreMesa = 0 THEN fechaproc  */ -- No debe variar el cálculo 
	                                                                          -- con mesa abierta o cerrada
							        WHEN DATEPART(MONTH, fechaproc) = DATEPART(MONTH, fechaprox) THEN fechaproc  
                               ELSE 
                               		DATEADD( DAY, DAY(DATEADD(MONTH, 1, fechaproc)) *-1, DATEADD(MONTH, 1, fechaproc) )  
                               END  
      FROM BacSwapSuda..SWAPGENERAL  

	  -- Prueba daño colateral
	  --set @FechaCalculos = '20150622'

   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos  
  
     --> Si la Fecha de Inicio del Flujo es Igual a la Fecha de Hoy (Proceso)  
   SET @Comienzo = 'N' --> Comienza Hoy SI ; NO   
  
   IF @dInicio >= @cDate_Hoy  
      SET @Comienzo = 'S'  


   -- Chequeo Inicio de Flujo en Feriado
   select @fechaAux = @dInicio 
   exec BacParamSuda.dbo.SP_MUESTRAFECHAVALIDA @fechaAux output, ';6;' , 1
   --  exec BacParamSuda.dbo.SP_MUESTRAFECHAVALIDA '20150621', ';6;', 0   -- 2015-06-22 00:00:00.000
   if @fechaAux <> @dInicio  /* Inicio es feriado. Se toma valor ICP hábil siguiente */  
      begin 
           Set  @FechaRescateICPInicio = @fechaAux 
		   if @HabilAnteriorSN = 'S' -- fecha hábil anterior
		      Select @FechaRescateICPInicio = BacParamSuda.dbo.fx_AGREGA_N_DIAS_HABILES( @dInicio, -1, ';6;' )
      end 
   else
      Set  @FechaRescateICPInicio = @dInicio
   

   SELECT  @iIcp_Ayer   = vmvalor  
   FROM    BACPARAMSUDA..VALOR_MONEDA with(nolock)    
   WHERE   vmcodigo     = @iCodigo_ICP  
   AND     vmfecha      = CASE WHEN @Comienzo = 'S' THEN CASE WHEN @cDate_Hoy < @FechaCalculos THEN @cDate_Hoy ELSE @cDate_Ayer END  
                               ELSE @FechaRescateICPInicio /*@dInicio*/   
                          END  
--select 'debug' , '@iIcp_Ayer' = @iIcp_Ayer,  '@FechaRescateICPInicio' = @FechaRescateICPInicio
--select  @iCodigo_ICP, CASE WHEN @Comienzo = 'S' THEN CASE WHEN @cDate_Hoy < @FechaCalculos THEN @cDate_Hoy ELSE @cDate_Ayer END                              ELSE                      @dInicio                           END  
  
   SELECT  @iIcp_Hoy    = vmvalor  
   FROM    BACPARAMSUDA..VALOR_MONEDA with(nolock)    
   WHERE   vmcodigo     = @iCodigo_ICP  
   AND     vmfecha      = @FechaCalculos --> @cDate_Hoy  

   -- Flujo vence en fin de mes especial usa el ICP
   -- ingresado el ultimo dia del mes
   -- esto implica riesgo.
   IF @cDate_hoy = @dTermino -- Flujo será liquidado
   BEGIN 
	   SELECT  @iIcp_Hoy    = vmvalor  
	   FROM    BACPARAMSUDA..VALOR_MONEDA with(nolock)    
	   WHERE   vmcodigo     = @iCodigo_ICP  
	   AND     vmfecha      = @cDate_Hoy  
   END 

   IF @cDate_hoy > @dTermino -- Flujo ya venció y liquida hoy
   BEGIN 
       -- Chequeo Inicio de Flujo en Feriado
       select @fechaAux = @dTermino 
       exec BacParamSuda.dbo.SP_MUESTRAFECHAVALIDA @fechaAux output, ';6;' , 1  
       if @fechaAux <> @dTermino  /* Fin es feriado. Se toma valor ICP hábil siguiente */   
	   begin
         Set  @FechaRescateICPFinal = @fechaAux
		 if @HabilAnteriorSN = 'S' -- fecha hábil anterior
		      Select @FechaRescateICPFinal = BacParamSuda.dbo.fx_AGREGA_N_DIAS_HABILES( @dTermino, -1, ';6;' )
       end 
       else
         Set  @FechaRescateICPFinal = @dTermino

	   SELECT  @iIcp_Hoy    = vmvalor  
	   FROM    BACPARAMSUDA..VALOR_MONEDA with(nolock)    
	   WHERE   vmcodigo     = @iCodigo_ICP  
	   AND     vmfecha      = @FechaRescateICPFinal /*@cDate_Hoy*/  
   END 

   --select 'debug' ,  '@FechaRescateICPFinal' = @FechaRescateICPFinal, '@FechaRescateICPInicio' = @FechaRescateICPInicio

   SELECT  @Uf_Ayer     = vmvalor  
   FROM    BacParamSuda..VALOR_MONEDA with(nolock)  
   WHERE   vmcodigo     = 998  
   AND     vmfecha      = CASE WHEN @Comienzo = 'S' THEN CASE WHEN @cDate_Hoy < @FechaCalculos THEN @cDate_Hoy 
															  ELSE @cDate_Ayer 
                                                         END  
                               ELSE @dInicio   
                          END  
  
--   select 'debug' , '@Uf_Ayer' = @Uf_Ayer,  '@dInicio' = @dInicio, '@cDate_Hoy' = @cDate_Hoy, '@cDate_Ayer', @cDate_Ayer

   SELECT  @Uf_Hoy      = vmvalor  
   FROM    BacParamSuda..VALOR_MONEDA with(nolock)  
   WHERE   vmcodigo     = 998  
   AND     vmfecha      = @FechaCalculos --> @cDate_Hoy  
  

   -- Flujo vence en fin de mes especial usa UF del 
   -- ultimo día del mes y no la UF del día vencimiento
   -- del flujo   
   IF @cDate_hoy = @dTermino -- Flujo será liquidado
   BEGIN 
	   SELECT  @Uf_Hoy    = vmvalor  
	   FROM    BACPARAMSUDA..VALOR_MONEDA with(nolock)    
	   WHERE   vmcodigo     = 998  
	   AND     vmfecha      = @cDate_Hoy  
   END 

   IF @cDate_hoy > @dTermino -- Flujo será liquidado
   BEGIN 
	   SELECT  @Uf_Hoy    = vmvalor  
	   FROM    BACPARAMSUDA..VALOR_MONEDA with(nolock)    
	   WHERE   vmcodigo     = 998  
	   AND     vmfecha      = @dTermino /* @cDate_Hoy  */
   END    
   
----   select 'debug' , '@Uf_Hoy' = @Uf_Hoy , '@FechaCalculos' = @FechaCalculos, '@cDate_Hoy'= @cDate_Hoy, '@dTermino'= @dTermino
--   select 'debug', '@cDate_Hoy' = @cDate_Hoy, '@FechaCalculos' = @FechaCalculos, '@cDate_Ayer' = @cDate_Ayer, '@dInicio'= @dInicio, '@dTermino' = @dTermino,@Comienzo

   IF @Comienzo = 'S'  
	   BEGIN   
		  IF @cDate_Hoy < @FechaCalculos  
			 SET @DifDias = DATEDIFF(DAY, @cDate_Hoy, @FechaCalculos) * 1.0 --> DATEDIFF(DAY, @cDate_Ayer, @cDate_Hoy) * 1.0  
		  ELSE  
			 SET @DifDias = DATEDIFF(DAY, @cDate_Ayer, @cDate_Hoy) * 1.0  
	   END 
   ELSE   
   BEGIN   
      SET @DifDias = DATEDIFF(DAY, @dInicio, @FechaCalculos) * 1.0 --> DATEDIFF(DAY, @dInicio, @cDate_Hoy) * 1.0  
	  -- Flujo vence en fin de mes especial aumenta los días del flujo
	  -- en los dias inhábiles que faltan para terminar el mes
	  IF @cDate_hoy >= @dTermino -- Flujo será liquidado
	  BEGIN 
		   SET @DifDias = DATEDIFF(DAY, @dInicio, @dTermino) * 1.0		   
	  END 
   END    
  
--  select 'debug', '@DifDias' = @DifDias
--  select 'vb', @iIcp_Ayer   ,@iIcp_Hoy
  
   SET  @iTCIP_30    = ((@iIcp_Hoy / @iIcp_Ayer - 1.0)  * (100.0 * 30.0 / @DifDias))  
  
   IF @@ERROR <> 0  
   BEGIN  
      SET @Retorno = -9999
      RETURN -1  
   END  
  
   SET  @iTCIP_360   = ((@iIcp_Hoy / @iIcp_Ayer - 1.0)  * (100.0 * 360.0 / @DifDias))  


----   select 'debug', '@iTCIP_360', @iTCIP_360
-- select ((16521.35 / 16286.2 - 1.0)  * (100.0 * 360.0 / 172.0))  
-- select ((16521.35 / 16286.2 - 1.0)  )  

   IF @@ERROR <> 0  
   BEGIN  
      SET @Retorno = -9999
      RETURN -1  
   END  
  
   SET  @Retorno_999 = ROUND(@iTCIP_360,  @Decimales_ICP )  
  
   -- Por norma al aplicar la tasa TNA a la TRA se debe redondear a dos decimales 
   -- No también se usará con 4 decimales para calcular el TRA 
   SET  @Retorno_998 = ( ROUND( @iTCIP_360, @Decimales_ICP ) * (@DifDias) /36000.0000 - (@Uf_Hoy/@Uf_Ayer -1.0)) / (@Uf_Hoy/@Uf_Ayer)*36000.0000/(@DifDias)  
   
   --select 'debug', @DifDias, '@iIcp_Hoy', @iIcp_Hoy, '@iIcp_ayer', @iIcp_ayer
   --select 'debug', @Retorno_998, '@iTCIP_360', @iTCIP_360, '@Uf_Hoy', @Uf_Hoy, '@Uf_Ayer', @Uf_Ayer, '( ROUND( @iTCIP_360, 2 ) * (@DifDias) /36000.0000 - (@Uf_Hoy/@Uf_Ayer -1.0))', ( ROUND( @iTCIP_360, 2 ) * (@DifDias) /36000.0000 - (@Uf_Hoy/@Uf_Ayer -1.0))
  
   IF @@ERROR <> 0  
   BEGIN  
      SET @Retorno = -9999
      RETURN -1  
   END  
  
--   SET  @Retorno_998 = ROUND(@Retorno_998,2)   -- MAP 20060802 Solicitado formalmente por R. Arteche  
   SET  @Retorno_998 = ROUND(@Retorno_998,4 )     -- MAP 20070314   Solicitado formalmente por G. Silva  
  
--   select 'debug', '@Retorno_998', @Retorno_998

   SET  @Retorno     = CASE WHEN @iMoneda = 999 THEN ISNULL(@Retorno_999,0.0) -- isnull(@iTCIP_360  ,0.0)  
                            WHEN @iMoneda = 998 THEN isnull(@Retorno_998,0.0)  
                       END  
END

GO
