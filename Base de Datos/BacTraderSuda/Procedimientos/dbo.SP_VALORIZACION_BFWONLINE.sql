USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORIZACION_BFWONLINE]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALORIZACION_BFWONLINE]
   (   @FechaProceso   DATETIME
   ,   @Operacion      NUMERIC(9)
   ,   @Sistema        CHAR(3)   = 'BFW'
   )
AS
BEGIN

   SET NOCOUNT ON
   SET TRANSACTION ISOLATION LEVEL READ COMMITTED

IF @Sistema = 'BFW'
BEGIN
   DECLARE @CodProd		   INTEGER
   ,       @Plazo          	   INTEGER
   ,       @nCodCnv		   NUMERIC(03,00)
   ,       @Valor_UF		   NUMERIC(12,04)
   ,       @Valor_Presente 	   NUMERIC(21,04)
   ,       @dFecVto		   DATETIME
   ,       @cTipOpe		   CHAR(01)
   ,       @PreFut 		   FLOAT
   ,       @nCodMon		   NUMERIC(03,00)
   ,       @nNumOpe		   NUMERIC(10)
   ,       @Valor_Mercado	   FLOAT
   ,       @PrecioFwd      	   FLOAT
   ,       @Valor_Activo   	   FLOAT
   ,       @Valor_Pasivo   	   FLOAT
   ,       @Valor_Obtenido         FLOAT
   ,       @ResultadoMTM   	   FLOAT
   ,       @cModal		   CHAR(01)
   ,       @CaTasaSinteticaM1 	   FLOAT
   ,       @CaTasaSinteticaM2 	   FLOAT
   ,       @CaPrecioSpotVentaM1    FLOAT
   ,       @CaPrecioSpotVentaM2    FLOAT
   ,       @CaPrecioSpotCompraM1   FLOAT
   ,       @CaPrecioSpotCompraM2   FLOAT
   ,       @ValorRazonableActivo   FLOAT
   ,       @ValorRazonablePasivo   FLOAT
   ,       @fResObtenido           NUMERIC(21,4)

   SELECT  @fResObtenido           = fres_obtenido
   ,       @CodProd		   = cacodpos1
   ,       @Plazo          	   = DATEDIFF(dd,@FechaProceso,cafecEfectiva)  -- caplazovto
   ,       @nCodCnv		   = cacodmon2
   ,       @Valor_UF		   = CONVERT(NUMERIC(21,4),vmvalor)
   ,       @Valor_Presente 	   = CASE WHEN cacodpos1 = 10 THEN caequusd2 ELSE camtomon1 END
   ,       @dFecVto		   = cafecvcto
   ,       @cTipOpe		   = catipoper
   ,       @PreFut 		   = caprecal
   ,       @nCodMon		   = cacodmon1
   ,       @nNumOpe		   = canumoper
   ,       @Valor_Mercado	   = 0.0
   ,       @PrecioFwd      	   = 0.0
   ,       @Valor_Activo   	   = 0.0
   ,       @Valor_Pasivo   	   = 0.0
   ,       @Valor_Obtenido         = 0.0
   ,       @ResultadoMTM   	   = 0.0
   ,       @cModal		   = catipmoda
   ,       @CaTasaSinteticaM1 	   = 0.0
   ,       @CaTasaSinteticaM2 	   = 0.0
   ,       @CaPrecioSpotVentaM1    = 0.0
   ,       @CaPrecioSpotVentaM2    = 0.0
   ,       @CaPrecioSpotCompraM1   = 0.0
   ,       @CaPrecioSpotCompraM2   = 0.0
   ,       @ValorRazonableActivo   = 0.0
   ,       @ValorRazonablePasivo   = 0.0
   FROM    BacFwdSuda..MFCA        WITH (NOLOCK)
           LEFT JOIN BacParamSuda..VALOR_MONEDA ON vmfecha = @FechaProceso AND vmcodigo = 998
   WHERE   canumoper               = @Operacion

   IF @CodProd = 10 
   BEGIN
      SELECT  @fResObtenido , @Valor_Presente
      RETURN
   END

   EXECUTE BacFwdSuda..SP_MARKTOMARKET
           @CodProd
   ,       @Plazo
   ,       @nCodCnv
   ,       @Valor_UF
   ,       @Valor_Presente
   ,       @dFecVto
   ,       @cTipOpe
   ,       @PreFut
   ,       @nCodMon
   ,       @nNumOpe
   ,       @Valor_Mercado    	   OUTPUT
   ,       @PrecioFwd       	   OUTPUT
   ,       @Valor_Activo  	   OUTPUT
   ,       @Valor_Pasivo   	   OUTPUT
   ,       @Valor_Obtenido   	   OUTPUT
   ,       @ResultadoMTM	   OUTPUT
   ,       @cModal
   ,       @CaTasaSinteticaM1 	   OUTPUT
   ,       @CaTasaSinteticaM2 	   OUTPUT
   ,       @CaPrecioSpotVentaM1	   OUTPUT
   ,       @CaPrecioSpotVentaM2    OUTPUT
   ,       @CaPrecioSpotCompraM1   OUTPUT
   ,       @CaPrecioSpotCompraM2   OUTPUT
   ,       @ValorRazonableActivo   OUTPUT
   ,       @ValorRazonablePasivo   OUTPUT

   SELECT  @fResObtenido , CONVERT(NUMERIC(21,4),ROUND(@ResultadoMTM,4))

END ELSE
BEGIN

   EXECUTE BacSwapSuda..SP_CALCULO_VRAZONABLESWAP @FechaProceso , @Operacion

   SELECT  @fResObtenido    = isnull(MIN(Valor_RazonableCLP),0.0)
   FROM    BacSwapSuda..CARTERA 
   WHERE   numero_operacion = @Operacion

   SELECT  @fResObtenido , CONVERT(NUMERIC(21,4),ROUND(@fResObtenido,4))

END

END



GO
