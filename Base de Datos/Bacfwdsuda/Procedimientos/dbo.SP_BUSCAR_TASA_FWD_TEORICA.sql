USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_TASA_FWD_TEORICA]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_BUSCAR_TASA_FWD_TEORICA]
   (   @dFechaProceso   DATETIME   
   ,   @dFechaVctoInst  DATETIME
   ,   @dFechaVctoOper  DATETIME
   ,   @iTasaBenchMark  NUMERIC(21,4)
   ,   @iDuration       FLOAT   = 0.0
   )
AS
BEGIN

   SET NOCOUNT ON    

   DECLARE @Error             INTEGER
   ,       @iTasaFwdTeorica   NUMERIC(21,4)

   EXECUTE @Error           = SP_TASAFORWARDTEORICA @dFechaProceso
                                                  , @dFechaVctoInst
                                                  , @dFechaVctoOper
                                                  , @iTasaBenchMark
                                                  , @iDuration
                                                  , @iTasaFwdTeorica OUTPUT
   IF @Error < 0.0 AND @Error <> -4
   BEGIN
      SELECT @iTasaFwdTeorica = 0.0
      RAISERROR(15007,-1,-1,'Error al Detrminar Tasa Forward Teorica.')
      RETURN @Error
   END

   SELECT @iTasaFwdTeorica 

END




GO
