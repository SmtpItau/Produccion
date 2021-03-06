USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SRV_CALCULO_TIBR]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SRV_CALCULO_TIBR]
   (   @iMoneda           INTEGER   
   ,   @Fecha_Proc        DATETIME   = '19000101'
   ,   @Fecha_Prox        DATETIME   = '19000101'
   )
AS
BEGIN

   SET NOCOUNT ON 

   DECLARE @cDate_Hoy   DATETIME
   ,       @cDate_Ayer  DATETIME
   ,       @iIBR_Ayer   FLOAT
   ,       @iIBR_Hoy    FLOAT
   ,       @iTCIBR_30    FLOAT
   ,       @iTCIBR_360   FLOAT
   ,       @iCodigo_IBR INTEGER
   ,       @DifDias     FLOAT
   ,       @Retorno_999 FLOAT
   ,       @Retorno_998 FLOAT
   ,       @Uf_Ayer     FLOAT
   ,       @Uf_Hoy      FLOAT
   ,       @Retorno_129 FLOAT

   SELECT  @iCodigo_IBR = 802

   IF @Fecha_Proc = '19000101' BEGIN
      SELECT  @cDate_Ayer  = fechaant 
      ,       @cDate_Hoy   = fechaproc
      FROM    SWAPGENERAL
   END
   ELSE BEGIN 
	set @cDate_Ayer = @Fecha_Proc   -- MAP 20080805
	set @cDate_Hoy = @Fecha_Prox    -- MAP 20080805
   END

   SELECT  @iIBR_Ayer   = 0.0
   SELECT  @iIBR_Ayer   = isnull(vmvalor,0.0)
   FROM    bacparamsuda..VALOR_MONEDA 
   WHERE   vmcodigo     = @iCodigo_IBR
   AND     vmfecha      = @cDate_Ayer

   SELECT  @iIBR_Hoy    = 0.0
   SELECT  @iIBR_Hoy    = isnull(vmvalor,0.0)
   FROM    bacparamsuda..VALOR_MONEDA 
   WHERE   vmcodigo     = @iCodigo_IBR
   AND     vmfecha      = @cDate_Hoy

   
   if @iIBR_Ayer = 0.0
   begin
      select -1 , 'Valor para el Indice IBR es Cero para el Día ' + convert(char(10),@cDate_Ayer,103)
      return
   end
   if @iIBR_Hoy = 0.0
   begin
      select -1 , 'Valor para el Indice IBR es Cero para el Día ' + convert(char(10),@cDate_Hoy,103)
      return
   end

      
   SELECT  @DifDias     = DATEDIFF(DAY,@cDate_Ayer,@cDate_Hoy) * 1.0

   

   SELECT  @iTCIBR_360   = ((@iIBR_Hoy / @iIBR_Ayer - 1.0)  * (100.0 * 360.0 / @DifDias))

   SELECT  @Retorno_129 = ROUND(@iTCIBR_360,3)

   SELECT  CASE WHEN @iMoneda = 129 THEN isnull(@Retorno_129,0.0) END
           

END
GO
