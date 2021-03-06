USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SRV_CALCULO_TIBR_DEV]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SRV_CALCULO_TIBR_DEV]
   (   @iMoneda      INTEGER   
   ,   @dInicio      DATETIME
   ,   @dTermino     DATETIME
   ,   @Retorno      NUMERIC(21,4)   OUTPUT
   ,   @Fecha_Proc   DATETIME   = '19000101'
   ,   @Fecha_Prox   DATETIME   = '19000101'
   )
AS
BEGIN

   SET NOCOUNT ON 

   DECLARE @cDate_Hoy   DATETIME
   ,       @cDate_Ayer  DATETIME
   ,       @iIbr_Ayer   FLOAT
   ,       @iIbr_Hoy    FLOAT   
   ,       @iTIBR_360   FLOAT
   ,       @iCodigo_IBR INTEGER
   ,       @DifDias     FLOAT
   ,       @Retorno_129 NUMERIC(21,4)
   ,       @Ternimo     CHAR(1)
   ,       @Comienzo    CHAR(1)

   SET @iCodigo_IBR = 802
   
   IF @Fecha_Proc = '19000101' BEGIN
      SELECT  @cDate_Ayer  = fechaant 
      ,       @cDate_Hoy   = fechaproc
      FROM    BACSWAPSUDA..SWAPGENERAL  
   END
   ELSE BEGIN 
      SET @cDate_Hoy = @Fecha_Proc

      EXEC BACTRADERSUDA..SP_BUSCA_FECHA_HABIL @Fecha_Proc , -1,  @cDate_Ayer OUTPUT  
   END

   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos
   DECLARE @FechaCalculos    DATETIME
    SELECT @FechaCalculos    = CASE WHEN cierreMesa = 0 THEN fechaproc
									WHEN DATEPART(MONTH, fechaproc) = DATEPART(MONTH, fechaprox) THEN fechaproc
                                    ELSE DATEADD( DAY, DAY(DATEADD(MONTH, 1, fechaproc)) *-1, DATEADD(MONTH, 1, fechaproc) )
                               END
      FROM BacSwapSuda..SWAPGENERAL
   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos

     --> Si la Fecha de Inicio del Flujo es Igual a la Fecha de Hoy (Proceso)
   SET @Comienzo = 'N' --> Comienza Hoy SI ; NO 

      
   IF @dInicio >= @cDate_Hoy
      SET @Comienzo = 'S'

   SELECT  @iIbr_Ayer   = vmvalor
   FROM    BACPARAMSUDA..VALOR_MONEDA with(nolock)  
   WHERE   vmcodigo     = @iCodigo_IBR
   AND     vmfecha      = CASE WHEN @Comienzo = 'S' THEN CASE WHEN @cDate_Hoy < @FechaCalculos THEN @cDate_Hoy ELSE @cDate_Ayer END
                               ELSE                      @dInicio 
                          END


--	select  @iCodigo_IBR, CASE WHEN @Comienzo = 'S' THEN CASE WHEN @cDate_Hoy < @FechaCalculos THEN @cDate_Hoy ELSE @cDate_Ayer END                              ELSE                      @dInicio                           END

   SELECT  @iIbr_Hoy    = vmvalor
   FROM    BACPARAMSUDA..VALOR_MONEDA with(nolock)  
   WHERE   vmcodigo     = @iCodigo_IBR
   AND     vmfecha      = @FechaCalculos --> @cDate_Hoy

	/*
	SELECT 'SACAR', @iIbr_Ayer, fECHA = CASE WHEN @Comienzo = 'S' THEN CASE WHEN @cDate_Hoy < @FechaCalculos THEN @cDate_Hoy ELSE @cDate_Ayer END
                               ELSE                      @dInicio 
                          END
	SELECT 'SACAR', @iIbr_Hoy, FECHA = @FechaCalculos
	*/

   -- Flujo vence en fin de mes especial usa el IBR
   -- ingresado el ultimo dia del mes
   -- esto implica riesgo.
   if @cDate_hoy = @dTermino -- Flujo será liquidado
   begin
	   SELECT  @iIbr_Hoy     = vmvalor  
	   FROM    BACPARAMSUDA..VALOR_MONEDA with(nolock)    
	   WHERE   vmcodigo     = @iCodigo_IBR  
	   AND     vmfecha      = @cDate_Hoy  
   end
   if @Comienzo = 'S'
   begin
      IF @cDate_Hoy < @FechaCalculos
         SET @DifDias = DATEDIFF(DAY, @cDate_Hoy, @FechaCalculos) * 1.0 --> DATEDIFF(DAY, @cDate_Ayer, @cDate_Hoy) * 1.0
      ELSE
         SET @DifDias = DATEDIFF(DAY, @cDate_Ayer, @cDate_Hoy) * 1.0
   end else
   begin
      SET @DifDias = DATEDIFF(DAY, @dInicio, @FechaCalculos) * 1.0 --> DATEDIFF(DAY, @dInicio, @cDate_Hoy) * 1.0
	  -- Flujo vence en fin de mes especial aumenta los días del flujo
	  -- en los dias inhábiles que faltan para terminar el mes
	  if @cDate_hoy = @dTermino -- Flujo será liquidado
	  begin
		   SET @DifDias = DATEDIFF(DAY, @dInicio, @dTermino) * 1.0
	  end
   end


   IF @@ERROR <> 0
   BEGIN
      SET @Retorno = -1
      RETURN -1
   END
     
   SET  @iTIBR_360   = ((@iIbr_Hoy / @iIbr_Ayer - 1.0)  * (100.0 * 360.0 / @DifDias))

   IF @@ERROR <> 0
   BEGIN
      SET @Retorno = -1
   RETURN -1
   END

   SET  @Retorno_129 = ROUND(@iTIBR_360,3)


   IF @@ERROR <> 0
   BEGIN
      SET @Retorno = -1
      RETURN -1
   END

   SET  @Retorno     = CASE WHEN @iMoneda = 129 THEN ISNULL(@Retorno_129,0.0)                                
                          ELSE  ISNULL(@Retorno_129,0.0)
                          END
END
GO
