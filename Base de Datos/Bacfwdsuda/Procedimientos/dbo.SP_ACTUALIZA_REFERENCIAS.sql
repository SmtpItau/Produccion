USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_REFERENCIAS]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_ACTUALIZA_REFERENCIAS]
   (   @nNumOper         NUMERIC(10)
   ,   @TipoCambio       INTEGER
   ,   @Paridad          INTEGER
   ,   @cacosto_usdclp   FLOAT
   ,   @cacosto_mxusd    FLOAT
   ,   @cacosto_mxclp    FLOAT
   ,   @cafijaTCRef      DATETIME
   ,   @cafijaPRRef      DATETIME
   ,   @nPrecioUSDCLP    FLOAT
   ,   @RetornaDatos     INTEGER = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   --> Solicitado por 
   --> Se Actualizan Los Campos de Referencia Mercado

   --> @TipoCambio: 1 = Dolar Observado
   -->              2 = Dolar Mercado

   --> @Paridad     1 = Reuters 11 Hras
   -->              2 = Pactada
   -->              3 = Banco Central Europeo

   IF @RetornaDatos = 0
   BEGIN
      UPDATE MFCA            with (RowLock)
         SET cacodpos2       = @TipoCambio
           , cacolmon1       = @Paridad
           , cacosto_usdclp  = @cacosto_usdclp
           , cacosto_mxusd   = @cacosto_mxusd
           , cacosto_mxclp   = @cacosto_mxclp
           , cafijaTCRef     = @cafijaTCRef
           , cafijaPRRef     = @cafijaPRRef
           , cavalpre        = @nPrecioUSDCLP
       WHERE canumoper       = @nNumOper
   END ELSE
   BEGIN
      SELECT cacodpos2, cacolmon1, cafijaTCRef, cafijaPRRef 
      FROM MFCA WHERE canumoper = @nNumOper
   END

END

GO
