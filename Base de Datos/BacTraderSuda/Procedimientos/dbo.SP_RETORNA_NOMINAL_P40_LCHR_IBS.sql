USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNA_NOMINAL_P40_LCHR_IBS]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RETORNA_NOMINAL_P40_LCHR_IBS]
   (   @NominalReal         NUMERIC(21,4)
   ,   @Serie               VARCHAR(12)
   ,   @FechaEmision        DATETIME 
   ,   @FechaUltimoCupon    DATETIME
   ,   @NominalResidual     NUMERIC(21,4)   OUTPUT
   ,   @dFechaUltimoCupon   DATETIME        OUTPUT
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @InCodigo   INT
       SET @InCodigo   = (SELECT DISTINCT secodigo FROM BacParamSuda..SERIE WHERE seserie = @Serie)

   IF @InCodigo <> 20
   BEGIN
		SET		@NominalResidual	= 0
		SELECT	@dFechaUltimoCupon	= ISNULL( MAX(DATEADD(MONTH, tdcupon * 3, @FechaEmision)), @FechaEmision)
		FROM	BacParamSuda..TABLA_DESARROLLO
		WHERE	tdmascara			= @Serie
        AND		DATEADD(MONTH, tdcupon * 3, @FechaEmision) <= @dFechaUltimoCupon

		RETURN
   END

   DECLARE @nPerCupon   INT
       SET @nPerCupon   = ISNULL(( SELECT sepervcup FROM BacParamSuda.dbo.SERIE WHERE semascara = SUBSTRING(@Serie, 1, 6) ), 3)

   SELECT @dFechaUltimoCupon = MAX( DATEADD(MONTH, tdcupon * @nPerCupon, @FechaEmision) )
   FROM   BacParamSuda.dbo.TABLA_DESARROLLO
   WHERE  tdmascara    = SUBSTRING(@Serie, 1, 6)
     AND  DATEADD(MONTH, tdcupon * @nPerCupon, @FechaEmision) <= @dFechaUltimoCupon

   SELECT tdmascara
      ,   tdcupon
      ,   tdfecven = DATEADD(MONTH, tdcupon * @nPerCupon, @FechaEmision )
      ,   tdsaldo  = CASE WHEN tdsaldo = 0  THEN tdamort ELSE tdsaldo END
     INTO #INTO_TMP
     FROM BacParamSuda..TABLA_DESARROLLO
    WHERE tdmascara    = SUBSTRING(@Serie, 1, 6)

      SET  @NominalResidual = (SELECT (@NominalReal * tdsaldo) / 100 FROM #INTO_TMP WHERE tdfecven = @dFechaUltimoCupon)

END
GO
