USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_TASA_BENCHMARK]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_BUSCA_TASA_BENCHMARK]
   (   @dFechaProceso     DATETIME
   ,   @iMonedaEmision    INT
   ,   @iCodInstrumento   INT
   ,   @dFechaEmision     DATETIME
   ,   @dFechaVencimiento DATETIME
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iDifDias        NUMERIC(9)
   DECLARE @nTasaBenchMarck NUMERIC(21,4)

   SELECT  @iDifDias        = DATEDIFF(DAY,@dFechaEmision,@dFechaVencimiento)

   SELECT  @nTasaBenchMarck = 0.0
   SELECT  @nTasaBenchMarck = ISNULL(Tasa,0.0)
   FROM    BENCH_MARCK
   WHERE   Instrumento      = @iCodInstrumento
   AND     Moneda           = @iMonedaEmision
   AND     Fecha            = @dFechaProceso
   AND     @iDifDias        BETWEEN Desde AND Hasta

   SELECT  @nTasaBenchMarck

END


GO
