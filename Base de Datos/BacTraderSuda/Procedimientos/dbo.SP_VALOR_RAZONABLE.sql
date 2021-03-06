USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALOR_RAZONABLE]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALOR_RAZONABLE]
   (   @dFecha          DATETIME
   ,   @cSistema        CHAR(3)
   ,   @nDocumento      NUMERIC(9)
   ,   @nCorrelativo    NUMERIC(9)
   )
AS
BEGIN

   SET NOCOUNT ON
   
   DECLARE @nValorRazonable   NUMERIC(21,4)

   IF @cSistema = 'BFW'
   BEGIN
      SELECT @nValorRazonable     = fRes_Obtenido 
      FROM   BacFwdSuda..MFCA                     WITH (READPAST)
      WHERE  canumoper            = @nDocumento
   END
   IF @cSistema = 'PCS'
   BEGIN
      SELECT @nValorRazonable     = Valor_RazonableCLP
      FROM   BacSwapSuda..CARTERA                 WITH (READPAST)
      WHERE  numero_operacion     = @nDocumento
   END
   IF @cSistema = 'BTR'
   BEGIN
      SELECT  @nValorRazonable    = ISNULL(diferencia_mercado,0.0) -- ISNULL(valor_mercado,0.0)
      FROM    BacTraderSuda..VALORIZACION_MERCADO WITH (READPAST)
      WHERE   fecha_valorizacion  = @dFecha
      AND     rmnumdocu           = @nDocumento
      AND     rmcorrela           = @nCorrelativo
   END
   IF @cSistema = 'BEX'
   BEGIN
      SELECT @nValorRazonable     = ISNULL(rsDiferenciaMerc,0.0)  -- ISNULL(rsvalmerc,0.0)
      FROM   BacBonosExtSuda..TEXT_RSU            WITH (READPAST)
      WHERE  rsfecpro             = @dFecha
      AND    rsnumdocu            = @nDocumento
      AND    rscorrelativo        = @nCorrelativo
   END

   SELECT @nValorRazonable

END




GO
