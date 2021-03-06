USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MARKTOMARKET_TICKET_MAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MARKTOMARKET_TICKET_MAP]
   (   @CodProd               INT
   ,   @Plazo                 INT
   ,   @CodMoneda2            NUMERIC(03,00)
   ,   @Valor_UF              NUMERIC(12,04)
   ,   @MontoMoneda1          NUMERIC(21,04)
   ,   @dFecVto               DATETIME
   ,   @cTipOpe               CHAR(01)
   ,   @TipoCambio            FLOAT
   ,   @CodMoneda1            NUMERIC(03,00)
   ,   @nNumOpe               NUMERIC(10)
   ,   @PrecioFwd             FLOAT          OUTPUT
   ,   @Valor_Obtenido        FLOAT          OUTPUT
   ,   @ResultadoMTM          FLOAT          OUTPUT
   ,   @Modalidad             CHAR(01)
   ,   @CaTasaSinteticaM1     FLOAT          OUTPUT
   ,   @CaTasaSinteticaM2     FLOAT          OUTPUT
   ,   @CaPrecioSpotVentaM1   FLOAT          OUTPUT
   ,   @CaPrecioSpotVentaM2   FLOAT          OUTPUT
   ,   @CaPrecioSpotCompraM1  FLOAT          OUTPUT
   ,   @CaPrecioSpotCompraM2  FLOAT          OUTPUT
   ,   @ValorRazonableActivo  FLOAT          OUTPUT
   ,   @ValorRazonablePasivo  FLOAT          OUTPUT
   ,   @nTasa1                FLOAT          OUTPUT
   ,   @nTasa2                FLOAT          OUTPUT
   ,   @Indice                INT = 0
   )
WITH RECOMPILE
AS
BEGIN
	SET NOCOUNT ON

	SET @nTasa1      = 0.0
	SET @nTasa2      = 0.0

	--> Se ReDefinen Fechas Para Evitar Ir a la tabla de Control den cada uno de los Select
	DECLARE @dFechaAnterior  DATETIME
	DECLARE @dFechaProceso   DATETIME
	DECLARE @dFechaProxima   DATETIME

	SELECT  @dFechaAnterior  = acfecante
	,       @dFechaProceso   = acfecproc
	,       @dFechaProxima   = acfecprox
	FROM    MFAC             WITH (NOLOCK)
	--> -----------------------------------------------------------------------------------

	--> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos
	DECLARE @FechaCalculos    DATETIME
	SET @FechaCalculos    = CASE WHEN DATEPART(MONTH, @dFechaProceso) = DATEPART(MONTH, @dFechaProxima) THEN @dFechaProceso
							ELSE DATEADD( DAY, DAY(DATEADD(MONTH, 1, @dFechaProceso)) *-1, DATEADD(MONTH, 1, @dFechaProceso) )
							END
	--> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos

	DECLARE @iFound      INT
	SET @iFound      = -1

	SELECT  @iFound      = 0
	FROM    BacParamSuda..VALOR_MONEDA_CONTABLE with (nolock)
	WHERE   Fecha        = CASE WHEN @Indice = 1 THEN @dFechaAnterior ELSE @dFechaProceso END
	AND     Tipo_Cambio <> 0

	IF @iFound = -1
	BEGIN
		RAISERROR('¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA. ! ',16,6,'ERROR.')
		RETURN
	END
	   
	/*Creacion de tabla temporal*/    
	CREATE TABLE #TasaMoneda   --NEW
	(   Tasa               FLOAT   NOT NULL DEFAULT(0.0)
	,   Spread             FLOAT   NOT NULL DEFAULT(0.0)
	,   SpotCompra         FLOAT   NOT NULL DEFAULT(0.0)
	,   SpotVenta          FLOAT   NOT NULL DEFAULT(0.0)
	)

	DECLARE @Fecha_Inicio        CHAR(8)
	DECLARE @BidAsk              FLOAT
	DECLARE @Tasa_USD            FLOAT
	DECLARE @Tasa_FWD            FLOAT
	DECLARE @Spread              FLOAT
	DECLARE @Valor_Dolar         FLOAT
	DECLARE @RefDol              CHAR(1)
	DECLARE @BASECLP             FLOAT
	DECLARE @BASEUSD             FLOAT
	DECLARE @BASEUF              FLOAT
	DECLARE @Tasa_CLP            FLOAT
	DECLARE @PRECIOSPOTVENTA     FLOAT
	DECLARE @Tasa_UF             FLOAT
	DECLARE @TasaVr_USD          FLOAT
	DECLARE @SpreadVr_USD        FLOAT
	DECLARE @TasaVr_MX           FLOAT
	DECLARE @SpreadVr_MX         FLOAT
	DECLARE @BASEMX              FLOAT
	DECLARE @Valor_MonedaMX      FLOAT
	DECLARE @ValorMXFuturo       FLOAT
	DECLARE @ValorMXPresente     FLOAT
	DECLARE @ValorMXPresenteCLP  FLOAT
	DECLARE @ValorFutMontoCnv    FLOAT
	DECLARE @ValorPreMontoCnv    FLOAT
	DECLARE @ValorPreMontoCnvCLP FLOAT
	DECLARE @TasaVr_CLP          FLOAT
	DECLARE @TasaVr_UF           FLOAT
	DECLARE @DifPre              FLOAT

	/*  Asigna el valor a @baseclp solicitado se asigna 30(dias)       ---------------- */

	SET @BASECLP   = 360 --> 30
	SET @BASEUSD   = 360
	SET @BASEUF    = 360

	/* BUSCA FECHA DE PROCESO PARA EL CALCULO DEL VALOR DE MERCADO   ---------------- */

	SET @Fecha_Inicio = CONVERT(CHAR(8),@dFechaproceso,112)

	/* BUSCA DOLAR INTERBANCARIO PARA EL CALCULO DEL VALOR DE MERCADO --------------- */

	SET @Valor_Dolar = 1.0

	SELECT @Valor_Dolar = ISNULL(vmvalor, 1.0)
	FROM   BacParamSuda..VALOR_MONEDA with (nolock)
	WHERE  vmcodigo     = 994
	AND    vmfecha      = @dFechaproceso --> @Fecha_Inicio

	IF @Valor_Dolar IS NULL OR @Valor_Dolar = 0 
		SET @Valor_Dolar = 1.0

	DECLARE @cCodigoProducto VARCHAR(5)
	SET @cCodigoProducto = @CodProd

	DECLARE @cTipOper      CHAR(1)
	SET @cTipOper      = ISNULL((SELECT Tipo_Operacion FROM TBL_CarTicketFwd WHERE Numero_Operacion = @nNumOpe),'C')

	DECLARE @cTipOperCnv   CHAR(1)
	SET @cTipOperCnv   = CASE WHEN @cTipOper = 'C' THEN 'V' ELSE 'C' END

	/********************************** << ARBITRAJES MX-CLP >> *****************************************/

	IF @CodProd = 12		--- ARBITRAJE MX-CLP
	BEGIN

	--> Obtiene el TCRC : Tipo de Cambio Relacion Contable

		DECLARE @nTCRC FLOAT
		SET @nTCRC = ISNULL((SELECT ISNULL(Tipo_Cambio,0.0) 
			FROM BacparamSuda..VALOR_MONEDA_CONTABLE with (nolock) 
			WHERE Fecha         = @dFechaproceso
			AND codigo_moneda = @CodMoneda1),0.0)

			--> Obtiene Tasa Mx, en Base a la Interpolacion de Tasas

		DELETE FROM #TASAMONEDA
		INSERT INTO #TASAMONEDA EXECUTE SP_RetornaTasaMoneda @CodMoneda1, @Plazo, 'BFW', @cCodigoProducto, -1, -1, 0, @cTipOper

		DECLARE @nTASA_MX     FLOAT
		DECLARE @nSPREAD_MX   FLOAT
		DECLARE @nSPOTCOM_MX  FLOAT
		DECLARE @nSPOTVEN_MX  FLOAT

		SELECT  @nTASA_MX     = ISNULL(Tasa, 1.0) / 100.0
		,       @nSPREAD_MX   = ISNULL(Spread, 0.0)
		,       @nSPOTCOM_MX  = ISNULL(SpotCompra, 0.0)
		,       @nSPOTVEN_MX  = ISNULL(SpotVenta, 0.0)
		,       @nTasa1       = ISNULL(Tasa, 1.0)
		FROM    #TASAMONEDA

		--> Obtiene Tasa $, en Base a la Interpolacion de Tasas
		DELETE FROM #TASAMONEDA
		INSERT INTO #TASAMONEDA EXECUTE SP_RetornaTasaMoneda @CodMoneda2, @Plazo, 'BFW' , @cCodigoProducto, -1, -1, 0, @cTipOperCnv

		DECLARE @nTASA_CLP    FLOAT
		DECLARE @nSPREAD_CLP  FLOAT
		DECLARE @nSPOTCOM_CLP FLOAT
		DECLARE @nSPOTVEN_CLP FLOAT

		SELECT  @nTASA_CLP    = ISNULL(Tasa + Spread, 1.0) / 100.0
		,       @nSPREAD_CLP  = ISNULL(Spread, 0.0)
		,       @nSPOTCOM_CLP = ISNULL(SpotCompra, 0.0)
		,       @nSPOTVEN_CLP = ISNULL(SpotVenta, 0.0)
		,       @nTasa2       = ISNULL(Tasa, 1.0)
		FROM    #TASAMONEDA
	
select 'Debug Proceso Arbitraje MX-CLP', @nTCRC, 'Sobre este se futuriza con tasa CLP y M1', '@CodMoneda1', @CodMoneda1

		--> Conforma el Precio MTM
		SET @Valor_Obtenido   = ISNULL(@nTCRC * ( (1.0 + ((@nTASA_CLP * @Plazo) / @BASECLP))
											/ (1.0 + ((@nTASA_MX  * @Plazo) / @BASECLP))
											),0.0)

		--> Calculos de AVR: Valor Razonable
		IF @cTipOpe = 'C'
		BEGIN
			SET @ResultadoMTM         = (@MontoMoneda1  * (@Valor_Obtenido - @TipoCambio)) / (1.0 + ((@nTASA_CLP * @Plazo) / @BASECLP))
			SET @ValorRazonableActivo = (@MontoMoneda1  * @Valor_Obtenido)        	       / (1.0 + ((@nTASA_CLP * @Plazo) / @BASECLP))
			SET @ValorRazonablePasivo = (@MontoMoneda1  * @TipoCambio)                     / (1.0 + ((@nTASA_CLP * @Plazo) / @BASECLP))
		END 
		ELSE
		BEGIN
			SET @ResultadoMTM         = (@MontoMoneda1  * (@TipoCambio - @Valor_Obtenido)) / (1.0 + ((@nTASA_CLP * @Plazo) / @BASECLP))
			SET @ValorRazonableActivo = (@MontoMoneda1  * @TipoCambio)                     / (1.0 + ((@nTASA_CLP * @Plazo) / @BASECLP))
			SET @ValorRazonablePasivo = (@MontoMoneda1  * @Valor_Obtenido)                 / (1.0 + ((@nTASA_CLP * @Plazo) / @BASECLP))
		END
		SET @CaTasaSinteticaM1       = @nTASA_MX + @nSPREAD_MX
		SET @CaTasaSinteticaM2       = @nTASA_CLP
		SET @CaPrecioSpotCompraM1    = @nSPOTCOM_MX
		SET @CaPrecioSpotVentaM1     = @nSPOTVEN_MX
		SET @CaPrecioSpotCompraM2    = @nSPOTCOM_CLP
		SET @CaPrecioSpotVentaM2     = @nSPOTVEN_CLP
		SET @PrecioFwd               = @Valor_Obtenido
	END

	/* ---------------------------------<< SEGUROS DE CAMBIO >>-----------------------*/
	IF @CodProd = 1
	BEGIN 
		/* BUSCA DOLAR INTERBANCARIO COMPRA O VENTA -------------------------------------- */
		SET @BidAsk  = 1.0
		SELECT @BidAsk  = ISNULL(vmvalor,1.0)
		FROM   BacParamSuda..VALOR_MONEDA    with (nolock)
		WHERE  vmfecha  = CASE WHEN @CodMoneda1 = 998 THEN @FechaCalculos ELSE @Fecha_Inicio END
		AND    vmcodigo = CASE WHEN @CodMoneda1 <> 13 THEN @CodMoneda1       ELSE 994           END

		IF @CodMoneda1 <> 13
			SET @BidAsk = ROUND(@Valor_Dolar / @BidAsk, 2)

		/* CALCULA SEGUN MONEDA DEL CONTRATO FORWARD ------------------------------------- */
		SET @Tasa_USD          = 1.0
		SET @Tasa_FWD          = 1.0
		SET @Tasa_CLP          = 1.0
		SET @Spread            = 0.0
		SET @Valor_Obtenido    = 0.0 

		DELETE FROM #TasaMoneda
		INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda 13, @Plazo, 'BFW', @cCodigoProducto, -1, -1, 0, @cTipOper

		SELECT @Tasa_USD  = ISNULL(Tasa,1.0) / 100.0
		,      @Spread                = ISNULL(Spread,0.0)
		,      @CaPrecioSpotCompraM1  = ISNULL(SpotCompra, 0.0)
		,      @CaPrecioSpotVentaM1   = ISNULL(SpotVenta, 0.0)
		,      @nTasa1                = ISNULL(Tasa,1.0) 
		FROM   #TasaMoneda 

		IF @CodMoneda2 = 999 --> PESOS
		BEGIN
			DELETE FROM #TasaMoneda
			INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda 999 , @Plazo , 'BFW' , @cCodigoProducto, -1, -1, 0, @cTipOperCnv

			SELECT @Tasa_FWD             = ISNULL(Tasa + Spread, 1.0) / 100.0
			,      @CaPrecioSpotCompraM2 = ISNULL(SpotCompra, 0.0)
			,      @CaPrecioSpotVentaM2  = ISNULL(SpotVenta, 0.0)
			,      @nTasa2               = ISNULL(Tasa,1.0)
			FROM   #TasaMoneda  

			SET @PrecioFwd = ISNULL(@BidAsk * ( (1.0 + (@Tasa_FWD / @BASECLP) * @Plazo) / (1.0 + ((@Tasa_USD + @Spread) / @BASEUSD) * @Plazo)), 0.0)
												   
			IF @cTipOpe = 'C'   
			BEGIN --Compra
				SET @Valor_Obtenido       = ISNULL(@CaPrecioSpotVentaM1 * ((1.0 + (@Tasa_FWD / @BASECLP) * @Plazo) / (1.0 + ((@Tasa_USD + @Spread) / @BASEUSD) * @Plazo)), 0.0) 
				SET @ResultadoMTM         = (@Valor_Obtenido - @TipoCambio) * @MontoMoneda1 / (1 + @Tasa_Fwd * @Plazo / @BaseCLP)
				SET @ValorRazonableActivo = @Valor_Obtenido  * @MontoMoneda1 / (1.0 + @Tasa_Fwd * @Plazo / @BaseCLP)
				SET @ValorRazonablePasivo = @TipoCambio          * @MontoMoneda1 / (1.0 + @Tasa_Fwd * @Plazo / @BaseCLP)
			END 
			ELSE
			BEGIN     ---Venta
				SET @Valor_Obtenido       = ISNULL(@CaPrecioSpotCompraM1 * ((1.0 +  (@Tasa_FWD / @BASECLP) * @Plazo) / (1.0 + ((@Tasa_USD + @Spread) / @BASEUSD) * @Plazo)), 0.0) 
				SET @ResultadoMTM         = (@TipoCambio         - @Valor_Obtenido) * @MontoMoneda1 / (1 + @Tasa_Fwd * @Plazo / @BaseCLP)
				SET @ValorRazonableActivo = @TipoCambio          * @MontoMoneda1 / (1.0 + @Tasa_Fwd * @Plazo / @BaseCLP)
				SET @ValorRazonablePasivo = @Valor_Obtenido  * @MontoMoneda1 / (1.0 + @Tasa_Fwd * @Plazo / @BaseCLP)
			END

			SET @CaTasaSinteticaM1       = @Tasa_USD + @Spread
			SET @CaTasaSinteticaM2       = @Tasa_FWD
			SET @CaPrecioSpotVentaM1     = @CaPrecioSpotVentaM1
			SET @CaPrecioSpotVentaM2     = @CaPrecioSpotVentaM2
			SET @CaPrecioSpotCompraM1    = @CaPrecioSpotCompraM1
			SET @CaPrecioSpotCompraM2    = @CaPrecioSpotCompraM2
		END 
		ELSE 
		BEGIN  ---Moneda UF--
			DELETE FROM #TasaMoneda
			INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda 998 , @Plazo , 'BFW' , @cCodigoProducto, -1, -1, 0, @cTipOperCnv
	
			SELECT @Tasa_FWD             = ISNULL(Tasa + Spread , 1.0) / 100.0
			,      @CaPrecioSpotCompraM2 = ISNULL(SpotCompra, 0.0)
			,      @CaPrecioSpotVentaM2  = ISNULL(SpotVenta, 0.0)
			,      @nTasa2               = ISNULL(Tasa,1.0)
			FROM   #TasaMoneda

			SET @PrecioFwd = (@BidAsk / @Valor_UF) * ((1.0 + (@Tasa_FWD / @BASEUF) * @Plazo) / (1.0 + ((@Tasa_USD + @Spread) / @BASEUSD) * @Plazo))

			IF @cTipOpe = 'C' --Compra
			BEGIN    
				SET @Valor_Obtenido       =  ISNULL((@CaPrecioSpotVentaM1 / @Valor_UF )* ((1.0 +  (@Tasa_FWD / @BASEUF) * @Plazo) / (1.0 + ((@Tasa_USD + @Spread) / @BASEUSD) * @Plazo)), 0.0)
				SET @ResultadoMTM         = (@Valor_Obtenido - @TipoCambio)        * @MontoMoneda1  / (1 + @Tasa_Fwd * @Plazo / @BaseUF)
				SET @ValorRazonableActivo =  @Valor_Obtenido * @MontoMoneda1 / (1.0 + @Tasa_Fwd * @Plazo / @BaseUF) * @Valor_UF
				SET @ValorRazonablePasivo =  @TipoCambio         * @MontoMoneda1 / (1.0 + @Tasa_Fwd * @Plazo / @BaseUF) * @Valor_UF
			END 
			ELSE ---Venta
			BEGIN
				SET @Valor_Obtenido       =  ISNULL((@CaPrecioSpotCompraM1 / @Valor_UF) * ((1.0 +  (@Tasa_FWD / @BASEUF) * @Plazo) / (1.0 + ((@Tasa_USD + @Spread) / @BASEUSD) * @Plazo)), 0.0)
				SET @ResultadoMTM         = (@TipoCambio         - @Valor_Obtenido) * @MontoMoneda1  / (1 + @Tasa_Fwd * @Plazo / @BaseUF)
				SET @ValorRazonableActivo =  @TipoCambio         * @MontoMoneda1  / (1.0 + @Tasa_Fwd * @Plazo / @BaseUF) * @Valor_UF
				SET @ValorRazonablePasivo =  @Valor_Obtenido * @MontoMoneda1  / (1.0 + @Tasa_Fwd * @Plazo / @BaseUF) * @Valor_UF
			END

			SET @CaTasaSinteticaM1       = @Tasa_USD + @Spread
			SET @CaTasaSinteticaM2       = @Tasa_FWD
			SET @CaPrecioSpotVentaM1     = @CaPrecioSpotVentaM1
			SET @CaPrecioSpotVentaM2     = @CaPrecioSpotVentaM2
			SET @CaPrecioSpotCompraM1    = @CaPrecioSpotCompraM1
			SET @CaPrecioSpotCompraM2    = @CaPrecioSpotCompraM2
			SET @Valor_Obtenido          = @Valor_Obtenido
			SET @ResultadoMTM            = @ResultadoMTM * @Valor_UF
		END
	END

	/* ---------<< ARBITRAJES A FUTURO >>------------*/
	
	CREATE TABLE #RESRetornaParidadForward
		(   PrecioForward    FLOAT       NOT NULL DEFAULT(0.0)
		,   ParidadMenor     FLOAT       NOT NULL DEFAULT(0.0)
		,   ParidadMayor     FLOAT       NOT NULL DEFAULT(0.0)
		,   PrecioPunta      FLOAT       NOT NULL DEFAULT(0.0)
		,   Factor           NUMERIC(10) NOT NULL DEFAULT(0.0)
		)

	IF @CodProd = 2
	BEGIN
		SET    @Valor_Dolar        = 1.0
		SELECT @Valor_Dolar        = ISNULL(Tipo_Cambio, 1.0)
		FROM   BacParamSuda..VALOR_MONEDA_CONTABLE with (nolock)
		WHERE  Codigo_Moneda       = 994
		AND    Fecha               = CASE WHEN @Indice = 1 THEN @dFechaAnterior ELSE @dFechaProceso END

		/* BUSCA PRECIO MERCADO ---------------------------------------------------------- */
		DELETE FROM #TasaMoneda
		INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda @CodMoneda2 , @Plazo , 'BFW' , @cCodigoProducto, -1, -1, 0, @cTipOperCnv

		SELECT @TasaVr_USD    = ISNULL(Tasa, 1.0) / 100.0
		,      @SpreadVr_USD  = ISNULL(Spread, 1.0)
		,      @nTasa1        = ISNULL(Tasa,1.0)
		FROM   #TasaMoneda

		SET @CaTasaSinteticaM2 = @TasaVr_USD

		DELETE FROM #TasaMoneda
		INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda @CodMoneda1 , @Plazo , 'BFW' , @cCodigoProducto, -1, -1, 0, @cTipOper
		
		SELECT @TasaVr_MX     = ISNULL(Tasa, 1.0) / 100.0
		,      @SpreadVr_MX   = ISNULL(Spread, 1.0)
		,      @nTasa2        = ISNULL(Tasa,1.0)
		FROM   #TasaMoneda

		SET @CaTasaSinteticaM1 = @TasaVr_MX 
	
		EXECUTE SP_BIDASK2 @CodMoneda1, @Fecha_Inicio, @cTipOpe, @Plazo, @Tasa_USD OUTPUT, @Tasa_FWD OUTPUT

		SET @PrecioFwd     = @Tasa_USD + @Tasa_FWD
		
		SELECT @RefDol        = ISNULL(mnrrda,'D')
		,      @BASEMX        = ISNULL(mnbase,0)
		FROM   BacParamSuda..MONEDA with (nolock)
		WHERE  mncodmon       = @CodMoneda1  --Relación con el dolar si se Mult. o Div.

		--> Se cambio pero no se Ocupa
		IF @CodMoneda1 IN(994,995,997,998)
			SELECT @Valor_MonedaMX = ISNULL(vmvalor,0)
			FROM   BacParamSuda..VALOR_MONEDA with (nolock)
			WHERE  vmcodigo        = @CodMoneda1
			AND    vmfecha         = CASE WHEN @CodMoneda1 = 998 THEN @FechaCalculos ELSE @Fecha_Inicio END
		ELSE
			SELECT @Valor_MonedaMX = ISNULL(Tipo_Cambio,0) 
			FROM   BacParamSuda..VALOR_MONEDA_CONTABLE with (nolock)
			WHERE  Codigo_Moneda   = CASE WHEN @CodMoneda1 = 13 THEN 994 ELSE @CodMoneda1 END
			AND    Fecha           = CASE WHEN @Indice  = 1  THEN @dFechaAnterior ELSE @dFechaProceso END -- @Fecha_Inicio

		IF @cTipOpe = 'C' --> Compra
		BEGIN
			DELETE FROM #RESRetornaParidadForward
			INSERT INTO #RESRetornaParidadForward EXECUTE SP_RetornaParidadForward @CodMoneda1, @Plazo, 1, @Fecha_Inicio

			-- Para recuperar el Valor Razonable y los precios spot
			SELECT @Valor_Obtenido        = PrecioForward
			,      @CaPrecioSpotVentaM1     = PrecioPunta
			,      @CaPrecioSpotVentaM2    = 1.0
			,      @CaPrecioSpotCompraM2    = 1.0
			FROM   #RESRetornaParidadForward

			DELETE FROM #RESRetornaParidadForward
			INSERT INTO #RESRetornaParidadForward EXECUTE SP_RetornaParidadForward @CodMoneda1, @Plazo, 2, @Fecha_Inicio

			SELECT @CaPrecioSpotCompraM1 = PrecioPunta
			FROM   #RESRetornaParidadForward

			--Compra, Compensacion
			-- 28-Jun-05 MPNG Se modifica la resta de paridades para moneda Débil (Divide paridad )
			IF @RefDol = 'D'
			BEGIN
				SET @DifPre               = (1.0 / (@Valor_Obtenido * 1.0) - 1.0 / (@TipoCambio * 1.0))
				SET @ValorRazonableActivo = (1.0 /  @Valor_Obtenido * 1.0) * @MontoMoneda1 / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
				SET @ValorRazonablePasivo = (1.0 /  @TipoCambio         * 1.0) * @MontoMoneda1 / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
			END 
			ELSE
			BEGIN
				SET @DifPre               =  @Valor_Obtenido - @TipoCambio
				SET @ValorRazonableActivo =  @Valor_Obtenido * @MontoMoneda1 / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
				SET @ValorRazonablePasivo =  @TipoCambio         * @MontoMoneda1 / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
			END
			SET @ResultadoMTM = @MontoMoneda1 * @DifPre / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
		END 
		ELSE  --Venta
		BEGIN
			DELETE FROM #RESRetornaParidadForward
			INSERT INTO #RESRetornaParidadForward EXECUTE SP_RetornaParidadForward @CodMoneda1,@Plazo , 2 ,@Fecha_Inicio

			-- Para recuperar el Valor Razonable y los precios spot
			SELECT @Valor_Obtenido       = PrecioForward
			,      @CaPrecioSpotCompraM1 = PrecioPunta
			,      @CaPrecioSpotVentaM2  = 1.0
			,      @CaPrecioSpotCompraM2 = 1.0
			FROM   #RESRetornaParidadForward

			DELETE FROM #RESRetornaParidadForward
			INSERT INTO #RESRetornaParidadForward EXECUTE SP_RetornaParidadForward @CodMoneda1,@Plazo , 1 ,@Fecha_Inicio

			-- Para recuperar el Precio spot  Compra
			SELECT @CaPrecioSpotVentaM1  = PrecioPunta
			FROM   #RESRetornaParidadForward

			--Venta, Compensacion
			-- 28-Jun-05 MPNG Se modifica la resta de paridades para moneda Débil (Divide paridad )

			IF @RefDol = 'D'
			BEGIN
				SET @DifPre                = (1.0 / (@TipoCambio * 1.0)  - 1.0 / (@Valor_Obtenido * 1.0))
				SET @ValorRazonableActivo  = (1.0 /  @TipoCambio * 1.0)         * @MontoMoneda1 / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
				SET @ValorRazonablePasivo  = (1.0 /  @Valor_Obtenido * 1.0) * @MontoMoneda1 / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
			END 
			ELSE
			BEGIN
				SET @DifPre                =  @TipoCambio - @Valor_Obtenido
				SET @ValorRazonableActivo  =  @TipoCambio * @MontoMoneda1         / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
				SET @ValorRazonablePasivo  =  @Valor_Obtenido * @MontoMoneda1 / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
			END
			SET @ResultadoMTM =  @MontoMoneda1 * @DifPre / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
		END
	END

	---------------<< SEGUROS DE INFLACION >>--------------------
	IF @CodProd = 3
	BEGIN
		/* BUSCA VALOR DE UF PROYECTADA -------------------------------------------------- */
		SET @PrecioFwd = -1

		EXECUTE SP_UFPROYECTADA @dFecVto, @PrecioFwd OUTPUT

		IF @PrecioFwd = 0 OR @PrecioFwd IS NULL
			SET  @PrecioFwd = @Valor_UF

		DELETE FROM #TasaMoneda
		INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda @CodMoneda1 , @Plazo , 'BFW' , @cCodigoProducto, -1, -1, 0, @cTipOper

		SELECT @TasaVr_UF     = ISNULL(Tasa + spread, 1.0) / 100.0
		,      @nTasa1        = ISNULL(Tasa,1.0)
		FROM   #TasaMoneda

		DELETE FROM #TasaMoneda
		INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda 999 , @Plazo , 'BFW' , @cCodigoProducto, -1, -1, 0, @cTipOperCnv

		SELECT @TasaVr_CLP    = ISNULL(Tasa + spread, 1.0) / 100.0
		,      @nTasa2        = ISNULL(Tasa,1.0)
		FROM   #TasaMoneda

		--> Nuevo Metodo de Calculo
		DECLARE @nValorUf   FLOAT
		SET     @nValorUf   = ( SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA
									WHERE vmfecha = @FechaCalculos AND vmcodigo = 998 )
		DECLARE @Pi_k       FLOAT
		SET     @Pi_k       = POWER( 1.0 + @TasaVr_CLP, @Plazo / @BaseCLP )
								/ POWER( 1.0 + @TasaVr_UF,  @Plazo / @BaseUF  ) - 1.0

		SET     @Valor_Obtenido = @nValorUf * ( 1.0 + @Pi_k )
		  
		SET @CaTasaSinteticaM1    = @TasaVr_UF 
		SET @CaTasaSinteticaM2    = @TasaVr_CLP
		SET @CaPrecioSpotVentaM1  = @Valor_UF
		SET @CaPrecioSpotVentaM2  = 1
		SET @CaPrecioSpotCompraM1 = @Valor_UF
		SET @CaPrecioSpotCompraM2 = 1

		IF @cTipOpe = 'C' --Compra
		BEGIN
			SET @ResultadoMTM         = @MontoMoneda1   * (@Valor_Obtenido - @TipoCambio ) / (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP)
			SET @ValorRazonableActivo = @Valor_Obtenido *  @MontoMoneda1                   / (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP)
			SET @ValorRazonablePasivo = @TipoCambio     *  @MontoMoneda1                   / (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP)
		END 
		ELSE
		BEGIN
			SET @ResultadoMTM        = @MontoMoneda1    * (@TipoCambio - @Valor_Obtenido ) / (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP) 
			SET @ValorRazonableActivo = @TipoCambio     *  @MontoMoneda1                   / (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP)
			SET @ValorRazonablePasivo = @Valor_Obtenido *  @MontoMoneda1                   / (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP)
		END
	END
END
GO
