USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SRV_CALCULO_TPCA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SRV_CALCULO_TPCA]  
   (   @iMoneda           INTEGER   
   ,   @Fecha_Proc        DATETIME   = '19000101'
   ,   @Fecha_Prox        DATETIME   = '19000101'
   )
AS
BEGIN

   SET NOCOUNT ON 

   DECLARE @cDate_Hoy   DATETIME
   ,       @cDate_Ayer  DATETIME
   ,       @iIcp_Ayer   FLOAT
   ,       @iIcp_Hoy    FLOAT
   ,       @iTCIP_30    FLOAT
   ,       @iTCIP_360   FLOAT
   ,       @iCodigo_ICP INTEGER
   ,       @DifDias     FLOAT
   ,       @Retorno_999 FLOAT
   ,       @Retorno_998 FLOAT
   ,       @Uf_Ayer     FLOAT
   ,       @Uf_Hoy      FLOAT

   SELECT  @iCodigo_ICP = 800

   IF @Fecha_Proc = '19000101' BEGIN
      SELECT  @cDate_Ayer  = fechaant 
      ,       @cDate_Hoy   = fechaproc
      FROM    SWAPGENERAL
   END
   ELSE BEGIN -- CALCULO BACK TEST
--      SELECT  @cDate_Hoy   = @Fecha_Proc

--      EXEC BACTRADERSUDA..Sp_Busca_Fecha_Habil @Fecha_Proc , -1,  @cDate_Ayer OUTPUT    
--      MAP 20080805 Este proceso no debe ser utilizado por back-test
--                   por favor hacer cross-referenciae de este proceso en BacSwapSUda.
	set @cDate_Ayer = @Fecha_Proc   -- MAP 20080805
	set @cDate_Hoy = @Fecha_Prox    -- MAP 20080805
   END

   SELECT  @iIcp_Ayer   = 0.0
   SELECT  @iIcp_Ayer   = isnull(vmvalor,0.0)
   FROM    bacparamsuda..VALOR_MONEDA 
   WHERE   vmcodigo     = @iCodigo_ICP
   AND     vmfecha      = @cDate_Ayer

   SELECT  @iIcp_Hoy    = 0.0
   SELECT  @iIcp_Hoy    = isnull(vmvalor,0.0)
   FROM    bacparamsuda..VALOR_MONEDA 
   WHERE   vmcodigo     = @iCodigo_ICP
   AND     vmfecha      = @cDate_Hoy

   if @iIcp_Ayer = 0.0
   begin
      select -1 , 'Valor para el Indice Camara Promedio es Cero para el Día ' + convert(char(10),@cDate_Ayer,103)
      return
   end
   if @iIcp_Hoy = 0.0
   begin
      select -1 , 'Valor para el Indice Camara Promedio es Cero para el Día ' + convert(char(10),@cDate_Hoy,103)
      return
   end

   SELECT  @Uf_Ayer     = vmvalor
   FROM    bacparamsuda..VALOR_MONEDA 
   WHERE   vmcodigo     = 998
   AND     vmfecha      = @cDate_Ayer

   SELECT  @Uf_Hoy      = vmvalor
   FROM    bacparamsuda..VALOR_MONEDA 
   WHERE   vmcodigo     = 998
   AND     vmfecha      = @cDate_Hoy


   SELECT  @DifDias     = DATEDIFF(DAY,@cDate_Ayer,@cDate_Hoy) * 1.0
   SELECT  @iTCIP_30    = ((@iIcp_Hoy / @iIcp_Ayer - 1.0)  * (100.0 * 30.0 / @DifDias))
-- SELECT  @iTCIP_360   = ((POWER( (1 + @iTCIP_30 / 100.0) , (360.0/30.0) ) - 1.0) * 100.0)
   SELECT  @iTCIP_360   = ((@iIcp_Hoy / @iIcp_Ayer - 1.0)  * (100.0 * 360.0 / @DifDias))

   SELECT  @Retorno_999 = @iTCIP_360
   SELECT  @Retorno_999 = round( @Retorno_999, 2 ) -- Según documento especificacion producto, R. Arteche.
   SELECT  @Retorno_998 = ( round( @iTCIP_360,2)  * (@DifDias)      /36000.0 - (@Uf_Hoy/@Uf_Ayer -1.0)) / (@Uf_Hoy/@Uf_Ayer)*36000.0/(@DifDias)


   SELECT  @Retorno_998 = round( @Retorno_998, 4 )   -- Segun e-mail de G. Silva 14 Marzo 2007 se transfiere a 4 decimales la tasa reajustable


   SELECT  CASE WHEN @iMoneda = 999 THEN isnull(@Retorno_999,0.0)
                WHEN @iMoneda = 998 THEN isnull(@Retorno_998,0.0)
           END

END
GO
