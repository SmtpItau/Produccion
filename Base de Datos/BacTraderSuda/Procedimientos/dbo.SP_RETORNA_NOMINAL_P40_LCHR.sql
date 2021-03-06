USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNA_NOMINAL_P40_LCHR]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RETORNA_NOMINAL_P40_LCHR]
   (   @NominalReal         NUMERIC(21,4)
   ,   @Serie               VARCHAR(12)
   ,   @FechaEmision        DATETIME 
   ,   @FechaUltimoCupon    DATETIME
   ,   @NominalResidual     NUMERIC(21,4)   OUTPUT
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @nPerCupon   INTEGER
       SET @nPerCupon   = ISNULL((SELECT sepervcup FROM BacParamSuda.dbo.SERIE WHERE semascara = SUBSTRING(@Serie, 1, 6) ), 3)

   SELECT tdmascara
      ,   tdcupon
      ,   tdfecven = DATEADD(MONTH, tdcupon * @nPerCupon, @FechaEmision)
      ,   tdsaldo  = CASE WHEN tdsaldo = 0  THEN tdamort ELSE tdsaldo END
   INTO   #INTO_TMP
   FROM   BacParamSuda..TABLA_DESARROLLO
   WHERE  tdmascara    = SUBSTRING(@Serie, 1, 6)

   SET    @NominalResidual = (SELECT (@NominalReal * tdsaldo) / 100 FROM #INTO_TMP WHERE tdfecven = @FechaUltimoCupon)

END


GO
