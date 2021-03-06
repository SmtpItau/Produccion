USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MARKTOMARKET_BACK_TEST]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_MARKTOMARKET_BACK_TEST]	(	@CodProd			INT
						,	@Plazo				INT
						,	@nCodCnv			NUMERIC(03,00)
						,	@Valor_UF			NUMERIC(12,04)
						,	@Valor_Presente			NUMERIC(21,04)
						,	@dFecVto			DATETIME
						,	@cTipOpe			CHAR(01)
						,	@PreFut				FLOAT
						,	@nCodMon			NUMERIC(03,00)
						,	@nNumOpe			NUMERIC(10)
						,	@Valor_Mercado			FLOAT		OUTPUT
						,	@PrecioFwd			FLOAT		OUTPUT
						,	@Valor_Activo			FLOAT		OUTPUT
						,	@Valor_Pasivo			FLOAT		OUTPUT
						,	@Valor_Obtenido			FLOAT		OUTPUT
						,	@ResultadoMTM			FLOAT		OUTPUT
						,	@cModal				CHAR(01)
						,	@CaTasaSinteticaM1		FLOAT		OUTPUT
						,	@CaTasaSinteticaM2		FLOAT		OUTPUT
						,	@CaPrecioSpotVentaM1		FLOAT		OUTPUT
						,	@CaPrecioSpotVentaM2		FLOAT		OUTPUT
						,	@CaPrecioSpotCompraM1		FLOAT		OUTPUT
						,	@CaPrecioSpotCompraM2		FLOAT		OUTPUT
						,	@ValorRazonableActivo		FLOAT		OUTPUT
						,	@ValorRazonablePasivo		FLOAT		OUTPUT
						,	@Indice				INT	= 0
						,	@dFechaProceso			CHAR(08)
						,	@dFechaAnterior			CHAR(08)
						,	@dFechaPrxProceso		CHAR(08)
						)
AS
BEGIN

   -- SE CREA ESTE NUEVO PROCEDIMIENTO PARA NO CORRER EL RIESGO CON EL PROCESO NORMAL DE DEVENGAMIENTO
   -- 02/04/2008

   SET NOCOUNT ON

   DECLARE @nTasa1      FLOAT
   DECLARE @nTasa2      FLOAT
   DECLARE @iFound      INT

   SET     @nTasa1      = 0.0
   SET     @nTasa2      = 0.0

   
  /*Creacion de tabla temporal*/	
   CREATE TABLE #TasaMoneda   --NEW
   (   Tasa           	FLOAT   NOT NULL DEFAULT(0.0)
   ,   Spread         	FLOAT   NOT NULL DEFAULT(0.0)
   ,   SpotCompra   	FLOAT   NOT NULL DEFAULT(0.0)
   ,   SpotVenta      	FLOAT   NOT NULL DEFAULT(0.0)
   )

   DECLARE @Fecha_Inicio           CHAR(8)
   ,       @BidAsk       	   FLOAT
   ,       @Tasa_USD     	   FLOAT
   ,       @Tasa_FWD     	   FLOAT
   ,       @Spread       	   FLOAT
   ,       @Valor_Dolar  	   FLOAT
   ,       @Valor_Futuro 	   FLOAT
   ,       @RefDol       	   CHAR(1)
   ,       @PreFutNuevo  	   FLOAT
   ,       @BASECLP	           FLOAT
   ,       @BASEUSD	           FLOAT
   ,       @BASEUF	           FLOAT
   ,       @Tasa_CLP 	           FLOAT
   ,       @PRECIOSPOTVENTA        FLOAT
   ,       @Tasa_UF	           FLOAT
   ,       @TasaVr_USD	           FLOAT
   ,       @SpreadVr_USD  	   FLOAT
   ,       @TasaVr_MX 	   	   FLOAT
   ,       @SpreadVr_MX		   FLOAT
   ,       @BASEMX		   FLOAT
   ,       @Valor_MonedaMX 	   FLOAT
   ,       @ValorMXFuturo	   FLOAT
   ,       @ValorMXPresente	   FLOAT
   ,       @ValorMXPresenteCLP 	   FLOAT
   ,       @ValorFutMontoCnv	   FLOAT
   ,       @ValorPreMontoCnv	   FLOAT
   ,       @ValorPreMontoCnvCLP    FLOAT
   ,       @TasaVr_CLP 		   FLOAT
   ,       @TasaVr_UF		   FLOAT
   ,       @DifPre          	   FLOAT

   /*Asigna el valor a @baseclp solicitado se asigna 30(dias)*/
   SELECT  @BASECLP	= 360 --> 30
   ,       @BASEUSD	= 360
   ,       @BASEUF	= 360

   /* BUSCA FECHA DE PROCESO PARA EL CALCULO DEL VALOR DE MERCADO ------------------- */
   SELECT @Fecha_Inicio = @dFechaProceso --CONVERT(CHAR(8),acfecproc,112) FROM MFAC

   /* BUSCA DOLAR INTERBANCARIO PARA EL CALCULO DEL VALOR DE MERCADO ---------------- */
   SET    @Valor_Dolar = 1.0
		
   SELECT @Valor_Dolar = ISNULL(vmvalor, 1.0)
   FROM   BacParamSuda..VALOR_MONEDA
   WHERE  vmcodigo = 994
   AND    vmfecha  = @Fecha_Inicio

   IF @Valor_Dolar IS NULL OR @Valor_Dolar = 0 
      SELECT @Valor_Dolar = 1.0

   DECLARE @cCodigoProducto   VARCHAR(5)
   SELECT  @cCodigoProducto   = @CodProd

   DECLARE @cTipOper      CHAR(1)
   DECLARE @cTipOperCnv   CHAR(1)

   SET     @cTipOper      = ISNULL((SELECT catipoper FROM MFCARES WHERE CaFechaProceso = @dFechaProceso AND canumoper = @nNumOpe),'C')
   SET     @cTipOperCnv   = CASE WHEN @cTipOper = 'C' THEN 'V' ELSE 'C' END 

   /**********************************---------------------------------<< Seguros de Cambio>>-----------------------*****************************************/
   /**********************************--------------------------------------------------------------------------------------------*****************************************/
   IF @CodProd IN (1, 7)  BEGIN 
      /*****************************************************************************************************/
       /* Solo compensaciones parciales se rescata el precio a la fecha de proximo vcto. Flujo  VGS 02/2005 */
       /*****************************************************************************************************/
      IF @CodProd = 7 
      BEGIN 
         SELECT @PreFut = 0.0
         SELECT @PreFut = corprecio FROM CORTES WHERE cornumoper = @nNumOpe AND corfecvcto = @dFecVto
      END	

      /* BUSCA DOLAR INTERBANCARIO COMPRA O VENTA -------------------------------------- */
      SET    @BidAsk = 1.0

      SELECT @BidAsk = ISNULL(vmvalor,1.0)
      FROM   BacParamSuda..VALOR_MONEDA
      WHERE  vmcodigo = (CASE WHEN @nCodMon <> 13 THEN @nCodMon ELSE 994 END)
      AND    vmfecha  = @Fecha_Inicio

      IF @nCodMon <> 13
         SET @BidAsk = ROUND(@Valor_Dolar / @BidAsk, 2)

        /* CALCULA SEGUN MONEDA DEL CONTRATO FORWARD ------------------------------------- */
      SET    @Tasa_USD	        = 1.0
      SET    @Tasa_FWD	        = 1.0
      SET    @Tasa_CLP	        = 1.0
      SET    @Spread		= 0.0
      SET    @Valor_Obtenido	= 0.0 

      DELETE #TasaMoneda

      INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda	13 
							,	@Plazo 
							,	'BFW' 
							,	@cCodigoProducto
							,	-1
							,	-1
							,	0
							,	@cTipOper
                                                        ,       -1                     --> Parametros Faltantes Agregado el 30-04-2008 Adrian
                                                        ,       ''                     --> Parametros Faltantes Agregado el 30-04-2008 Adrian
							,	@dFechaProceso
							,	@dFechaPrxProceso

      SELECT @Tasa_USD 		    = ISNULL(Tasa,1.0) / 100.0
      ,      @Spread  		    = ISNULL(Spread,0.0)
      ,      @CaPrecioSpotCompraM1  = ISNULL(SpotCompra,0.0)
      ,      @CaPrecioSpotVentaM1   = ISNULL(SpotVenta,0.0)
      FROM   #TasaMoneda 

      SELECT @nTasa1                = ISNULL(Tasa,1.0) FROM #TasaMoneda 

      IF @nCodCnv = 999 --PESOS
      BEGIN
         DELETE #TasaMoneda
         INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda	999 
							,	@Plazo 
							,	'BFW' 
							,	@cCodigoProducto
							,	-1
							,	-1
							,	0
							,	@cTipOperCnv
                                                        ,       -1                     --> Parametros Faltantes Agregado el 30-04-2008 Adrian
                                                        ,       ''                     --> Parametros Faltantes Agregado el 30-04-2008 Adrian
							,	@dFechaProceso
							,	@dFechaPrxProceso

         SELECT @Tasa_FWD 	      = ISNULL(Tasa + Spread,1.0) / 100.0
         ,      @CaPrecioSpotCompraM2 = ISNULL(SpotCompra,0.0)
         ,      @CaPrecioSpotVentaM2  = ISNULL(SpotVenta,0.0) 
         FROM   #TasaMoneda  
         
         SELECT @nTasa2               = ISNULL(Tasa,1.0) FROM #TasaMoneda 

         SELECT @PrecioFwd = ISNULL(@BidAsk * ((1.0 +  (@Tasa_FWD / @BASECLP) * @Plazo) / (1.0 + ((@Tasa_USD + @Spread) / @BASEUSD) * @Plazo)),0.0)

         IF @cTipOpe = 'C' BEGIN --Compra
            SELECT @Valor_Obtenido       = ISNULL(@CaPrecioSpotVentaM1  * ((1.0 +  (@Tasa_FWD / @BASECLP) * @Plazo) / (1.0 + ((@Tasa_USD + @Spread) / @BASEUSD) * @Plazo)),0.0) 
            SELECT @ResultadoMTM         = (@Valor_Obtenido-@PreFut) * @Valor_Presente / (1+@Tasa_Fwd*@Plazo / @BaseCLP)
            SELECT @ValorRazonableActivo = @Valor_Obtenido * @Valor_Presente / (1.0 + @Tasa_Fwd * @Plazo / @BaseCLP)
            SELECT @ValorRazonablePasivo = @PreFut         * @Valor_Presente / (1.0 + @Tasa_Fwd * @Plazo / @BaseCLP)
         END 
	 ELSE BEGIN	 ---Venta
	    SELECT @Valor_Obtenido       = ISNULL(@CaPrecioSpotCompraM1 * ((1.0 +  (@Tasa_FWD / @BASECLP) * @Plazo) / (1.0 + ((@Tasa_USD + @Spread) / @BASEUSD) * @Plazo)),0.0) 
            SELECT @ResultadoMTM         = (@PreFut-@Valor_Obtenido) * @Valor_Presente / (1+@Tasa_Fwd*@Plazo / @BaseCLP)
            SELECT @ValorRazonableActivo = @PreFut         * @Valor_Presente / (1.0 + @Tasa_Fwd * @Plazo / @BaseCLP)
            SELECT @ValorRazonablePasivo = @Valor_Obtenido * @Valor_Presente / (1.0 + @Tasa_Fwd * @Plazo / @BaseCLP)
         END

         SELECT @CaTasaSinteticaM1	    = @Tasa_USD+@Spread
         SELECT @CaTasaSinteticaM2	    = @Tasa_FWD
         SELECT @CaPrecioSpotVentaM1        = @CaPrecioSpotVentaM1
         SELECT @CaPrecioSpotVentaM2        = @CaPrecioSpotVentaM2
         SELECT @CaPrecioSpotCompraM1       = @CaPrecioSpotCompraM1
         SELECT @CaPrecioSpotCompraM2       = @CaPrecioSpotCompraM2
      END 
      ELSE BEGIN  ---UF--
         DELETE #TasaMoneda

         INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda	998 
							,	@Plazo 
							,	'BFW' 
							,	@cCodigoProducto
							,	-1
							,	-1
							,	0
							,	@cTipOperCnv
                                                        ,       -1                     --> Parametros Faltantes Agregado el 30-04-2008 Adrian
                                                        ,       ''                     --> Parametros Faltantes Agregado el 30-04-2008 Adrian
							,	@dFechaProceso
							,	@dFechaPrxProceso

         SELECT @Tasa_FWD 	      = ISNULL(Tasa + Spread , 1.0) / 100.0
         ,      @CaPrecioSpotCompraM2 = ISNULL(SpotCompra, 0.0)
         ,      @CaPrecioSpotVentaM2  = ISNULL(SpotVenta, 0.0)
         FROM   #TasaMoneda

         SELECT @nTasa2               = ISNULL(Tasa,1.0) FROM #TasaMoneda 

         SELECT @PrecioFwd = (@BidAsk / @Valor_UF) * ((1.0 + (@Tasa_FWD / @BASEUF) * @Plazo) / (1.0 + ((@Tasa_USD + @Spread) / @BASEUSD) * @Plazo))

         IF @cTipOpe = 'C' --Compra
         BEGIN	
            SELECT @Valor_Obtenido       = ISNULL((@CaPrecioSpotVentaM1/@Valor_UF )* ((1.0 +  (@Tasa_FWD / @BASEUF) * @Plazo) / (1.0 + ((@Tasa_USD + @Spread) / @BASEUSD) * @Plazo)),0.0)
            SELECT @ResultadoMTM         =(@Valor_Obtenido-@PreFut) * @Valor_Presente / (1+@Tasa_Fwd*@Plazo / @BaseUF)
            SELECT @ValorRazonableActivo = @Valor_Obtenido * @Valor_Presente / (1.0 + @Tasa_Fwd * @Plazo / @BaseUF) * @Valor_UF
            SELECT @ValorRazonablePasivo = @PreFut         * @Valor_Presente / (1.0 + @Tasa_Fwd * @Plazo / @BaseUF) * @Valor_UF
         END ELSE ---Venta
         BEGIN
	    SELECT @Valor_Obtenido       = ISNULL((@CaPrecioSpotCompraM1/@Valor_UF) * ((1.0 +  (@Tasa_FWD / @BASEUF) * @Plazo) / (1.0 + ((@Tasa_USD + @Spread) / @BASEUSD) * @Plazo)),0.0)
            SELECT @ResultadoMTM         =(@PreFut-@Valor_Obtenido) * @Valor_Presente / (1+@Tasa_Fwd*@Plazo / @BaseUF)
            SELECT @ValorRazonableActivo = @PreFut         * @Valor_Presente / (1.0 + @Tasa_Fwd * @Plazo / @BaseUF) * @Valor_UF
            SELECT @ValorRazonablePasivo = @Valor_Obtenido * @Valor_Presente / (1.0 + @Tasa_Fwd * @Plazo / @BaseUF) * @Valor_UF
         END
         SELECT @CaTasaSinteticaM1	 = @Tasa_USD + @Spread
         SELECT @CaTasaSinteticaM2	 = @Tasa_FWD
         SELECT @CaPrecioSpotVentaM1	 = @CaPrecioSpotVentaM1
         SELECT @CaPrecioSpotVentaM2	 = @CaPrecioSpotVentaM2
         SELECT @CaPrecioSpotCompraM1	 = @CaPrecioSpotCompraM1
         SELECT @CaPrecioSpotCompraM2	 = @CaPrecioSpotCompraM2
         SELECT @Valor_Obtenido		 = @Valor_Obtenido
         SELECT @ResultadoMTM		 = @ResultadoMTM  * @Valor_UF
      END

      IF @cTipOpe = 'C'
      BEGIN
         SELECT @Valor_Mercado = @Valor_Presente * (@PrecioFwd - @PreFut)
         SELECT @Valor_Activo  = @Valor_Presente * @PrecioFwd
         SELECT @Valor_Pasivo  = @Valor_Presente * @PreFut
      END ELSE --VENTA
      BEGIN
         SELECT @Valor_Mercado = @Valor_Presente * (@PreFut - @PrecioFwd)
         SELECT @Valor_Activo  = @Valor_Presente * @PreFut
         SELECT @Valor_Pasivo  = @Valor_Presente * @PrecioFwd
      END

      IF @nCodCnv = 998
      BEGIN
         SELECT @Valor_Mercado	= ROUND( @Valor_Mercado, 4) * @Valor_UF
         SELECT @Valor_Activo	= ROUND( @Valor_Activo , 4) * @Valor_UF
         SELECT @Valor_Pasivo  	= ROUND( @Valor_Pasivo , 4) * @Valor_UF
      END
      SELECT @Valor_Mercado 	= ROUND( @Valor_Mercado, 0)
      SELECT @Valor_Activo  	= ROUND( @Valor_Activo , 0)
      SELECT @Valor_Pasivo  	= ROUND( @Valor_Pasivo , 0)
   END

   /**********************************-----------------------------------<< Arbitrajes a Futuro>>------------------------*****************************************/
   /**********************************--------------------------------------------------------------------------------------------*****************************************/
   CREATE TABLE #RESRetornaParidadForward
   (   PrecioForward	FLOAT       NOT NULL DEFAULT(0.0)
   ,   ParidadMenor	FLOAT       NOT NULL DEFAULT(0.0)
   ,   ParidadMayor	FLOAT       NOT NULL DEFAULT(0.0)
   ,   PrecioPunta	FLOAT       NOT NULL DEFAULT(0.0)
   ,   Factor		NUMERIC(10) NOT NULL DEFAULT(0.0)
   )

   IF @CodProd = 2
   BEGIN

      SELECT @Valor_Dolar        = 1.0

      SELECT @Valor_Dolar        = ISNULL(Tipo_Cambio, 1.0)
      FROM   BacParamSuda..VALOR_MONEDA_CONTABLE , MFAC
      WHERE  Codigo_Moneda       = 994
      AND    Fecha               = CASE WHEN @dFechaPrxProceso <> '19000101' THEN @dFechaProceso
					ELSE CASE WHEN @Indice = 1 THEN acfecante ELSE acfecproc END END


      /* BUSCA PRECIO MERCADO ---------------------------------------------------------- */
      DELETE #TasaMoneda

      INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda	@nCodCnv 
							,	@Plazo 
							,	'BFW' 
							,	@cCodigoProducto
							,	-1
							,	-1
							,	0
							,	@cTipOperCnv
                                                        ,       -1                     --> Parametros Faltantes Agregado el 30-04-2008 Adrian
                                                        ,       ''                     --> Parametros Faltantes Agregado el 30-04-2008 Adrian
							,	@dFechaProceso
							,	@dFechaPrxProceso

      SELECT @TasaVr_USD   = ISNULL(Tasa, 1.0) / 100.0
      ,      @SpreadVr_USD = ISNULL(Spread, 1.0)
      FROM   #TasaMoneda

      SELECT @nTasa1       = ISNULL(Tasa,1.0) FROM #TasaMoneda 

      SELECT @CaTasaSinteticaM2 = @TasaVr_USD

      DELETE #TasaMoneda
      INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda	@nCodMon 
							,	@Plazo 
							,	'BFW' 
							,	@cCodigoProducto
							,	-1
							,	-1
							,	0
							,	@cTipOper
                                                        ,       -1                     --> Parametros Faltantes Agregado el 30-04-2008 Adrian
                                                        ,       ''                     --> Parametros Faltantes Agregado el 30-04-2008 Adrian
							,	@dFechaProceso
							,	@dFechaPrxProceso

      SELECT @TasaVr_MX   = ISNULL(Tasa, 1.0) / 100.0
      ,      @SpreadVr_MX = ISNULL(Spread, 1.0)
      FROM   #TasaMoneda

      SELECT @nTasa2       = ISNULL(Tasa,1.0) FROM #TasaMoneda 

      SELECT @CaTasaSinteticaM1 = @TasaVr_MX 

      EXECUTE SP_BIDASK2	@nCodMon
			,	@Fecha_Inicio 
			,	@cTipOpe 
			,	@Plazo 
			,	@Tasa_USD OUTPUT 
			,	@Tasa_FWD OUTPUT
			,	@dFechaPrxProceso

      SELECT @PrecioFwd     = @Tasa_USD + @Tasa_FWD
      SELECT @Valor_Futuro  = 0.0

      SELECT @RefDol        = ISNULL(MNRRDA,'D')
      ,      @BASEMX        = ISNULL(mnbase,0)
      FROM   BacParamSuda..MONEDA 
      WHERE  mncodmon       = @nCodMon  --Relación con el dolar si se Mult. o Div.

      --> Se cambio pero no se Ocupa
      IF @nCodMon IN(994,995,997,998)
         SELECT @Valor_MonedaMX = ISNULL(vmvalor,0)
         FROM   BacParamSuda..VALOR_MONEDA 
         WHERE  vmcodigo        = @nCodMon 
         AND    vmfecha         = @Fecha_Inicio
      ELSE
         SELECT @Valor_MonedaMX = ISNULL(Tipo_Cambio,0) 
         FROM   BacParamSuda..VALOR_MONEDA_CONTABLE 
         ,      MFAC
         WHERE  Codigo_Moneda   = CASE WHEN @nCodMon = 13 THEN 994 ELSE @nCodMon END
         AND    Fecha           = @dFechaProceso 

      IF @RefDol = 'D' 
      BEGIN
         SELECT @Valor_Futuro  	= ROUND(@Valor_Presente / @PrecioFwd,2)
         SELECT @Valor_Mercado 	= ROUND(@Valor_Presente / @PreFut   ,2)
      END ELSE
      BEGIN
         SELECT @Valor_Futuro  	= ROUND(@Valor_Presente * @PrecioFwd,2)
         SELECT @Valor_Mercado 	= ROUND(@Valor_Presente * @PreFut   ,2)
      END

      IF @cTipOpe = 'C' --Compra
      BEGIN
         SELECT @Valor_Activo  	= ROUND(@Valor_Futuro  * @Valor_Dolar,0) 
      	 SELECT @Valor_Pasivo  	= ROUND(@Valor_Mercado * @Valor_Dolar,0)
      	 SELECT @Valor_Mercado 	= ROUND(@Valor_Activo  - @Valor_Pasivo,0)

         DELETE #RESRetornaParidadForward

         INSERT INTO #RESRetornaParidadForward EXECUTE SP_RetornaParidadForward	@nCodMon
									,	@Plazo 
									,	1 
									,	@Fecha_Inicio
									,	@dFechaPrxProceso

         -- Para recuperar el Valor Razonable y los precios spot
         SELECT @Valor_Obtenido		= PrecioForward
         ,      @CaPrecioSpotVentaM1 	= PrecioPunta
         ,      @CaPrecioSpotVentaM2	= 1.0
         ,      @CaPrecioSpotCompraM2	= 1.0
	 FROM   #RESRetornaParidadForward

         DELETE #RESRetornaParidadForward

         INSERT INTO #RESRetornaParidadForward EXECUTE SP_RetornaParidadForward	@nCodMon
									,	@Plazo 
									,	2 
									,	@Fecha_Inicio
									,	@dFechaPrxProceso

         SELECT @CaPrecioSpotCompraM1=PrecioPunta  
         FROM   #RESRetornaParidadForward	

         --Compra, Compensacion
         -- 28-Jun-05 MPNG Se modifica la resta de paridades para moneda Débil (Divide paridad )
         IF @RefDol = 'D'
         BEGIN
            SELECT @DifPre               = (1.0 / (@Valor_Obtenido * 1.0) - 1.0 / (@PreFut * 1.0))
            SELECT @ValorRazonableActivo = (1.0 /  @Valor_Obtenido * 1.0) * @Valor_Presente / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
            SELECT @ValorRazonablePasivo = (1.0 /  @PreFut         * 1.0) * @Valor_Presente / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
         END ELSE
         BEGIN
            SELECT @DifPre               =  @Valor_Obtenido - @PreFut
            SELECT @ValorRazonableActivo =  @Valor_Obtenido * @Valor_Presente / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
            SELECT @ValorRazonablePasivo =  @PreFut         * @Valor_Presente / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
         END
         SELECT @ResultadoMTM = @Valor_Presente * @DifPre / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
      END ELSE  --Venta
      BEGIN
         SELECT @Valor_Activo  	= ROUND(@Valor_Mercado * @Valor_Dolar,0)
         SELECT @Valor_Pasivo  	= ROUND(@Valor_Futuro  * @Valor_Dolar,0)
         SELECT @Valor_Mercado 	= ROUND(@Valor_Activo  - @Valor_Pasivo,0)  

         DELETE #RESRetornaParidadForward

         INSERT INTO #RESRetornaParidadForward EXECUTE SP_RetornaParidadForward	@nCodMon
									,	@Plazo 
									,	2 
									,	@Fecha_Inicio
									,	@dFechaPrxProceso


         -- Para recuperar el Valor Razonable y los precios spot
         SELECT @Valor_Obtenido       = PrecioForward
         ,      @CaPrecioSpotCompraM1 = PrecioPunta
         ,      @CaPrecioSpotVentaM2  = 1.0
         ,      @CaPrecioSpotCompraM2 = 1.0
	 FROM   #RESRetornaParidadForward

         DELETE #RESRetornaParidadForward
	
         INSERT INTO #RESRetornaParidadForward EXECUTE SP_RetornaParidadForward	@nCodMon
									,	@Plazo 
									,	1 
									,	@Fecha_Inicio
									,	@dFechaPrxProceso


         -- Para recuperar el Precio spot  Compra
         SELECT @CaPrecioSpotVentaM1  = PrecioPunta
         FROM   #RESRetornaParidadForward	

         --Venta, Compensacion
         -- 28-Jun-05 MPNG Se modifica la resta de paridades para moneda Débil (Divide paridad )
         IF @RefDol = 'D'
         BEGIN
            SELECT @DifPre                = (1.0 / (@PreFut * 1.0)  - 1.0 / (@Valor_Obtenido * 1.0))
            SELECT @ValorRazonableActivo  = (1.0 /  @PreFut * 1.0)         * @Valor_Presente / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
            SELECT @ValorRazonablePasivo  = (1.0 /  @Valor_Obtenido * 1.0) * @Valor_Presente / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
         END ELSE 
         BEGIN
      	    SELECT @DifPre                =  @PreFut - @Valor_Obtenido
            SELECT @ValorRazonableActivo  =  @PreFut * @Valor_Presente         / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
            SELECT @ValorRazonablePasivo  =  @Valor_Obtenido * @Valor_Presente / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
         END
         SELECT @ResultadoMTM =  @Valor_Presente * @DifPre / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
      END
   END


   ---------------------------------<< Seguros de Inflacion
   IF @CodProd = 3
   BEGIN
      /* BUSCA VALOR DE UF PROYECTADA -------------------------------------------------- */
      SET     @PrecioFwd = -1

      EXECUTE SP_UFPROYECTADA @dFecVto, @PrecioFwd OUTPUT

      IF @PrecioFwd = 0 OR @PrecioFwd IS NULL
         SET  @PrecioFwd = @Valor_UF

      DELETE #TasaMoneda
      INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda	@nCodMon 
							,	@Plazo 
							,	'BFW' 
							,	@cCodigoProducto
							,	-1
							,	-1
							,	0
							,	@cTipOper
                                                        ,       -1                     --> Parametros Faltantes Agregado el 30-04-2008 Adrian
                                                        ,       ''                     --> Parametros Faltantes Agregado el 30-04-2008 Adrian
							,	@dFechaProceso
							,	@dFechaPrxProceso

      SELECT @TasaVr_UF   = ISNULL(Tasa + spread, 1.0) / 100.0
      FROM   #TasaMoneda

      SELECT @nTasa1      = ISNULL(Tasa,1.0) FROM #TasaMoneda 

      DELETE #TasaMoneda
      INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda	999 
							,	@Plazo 
							,	'BFW' 
							,	@cCodigoProducto
							,	-1
							,	-1
							,	0
							,	@cTipOperCnv
                                                        ,       -1                     --> Parametros Faltantes Agregado el 30-04-2008 Adrian
                                                        ,       ''                     --> Parametros Faltantes Agregado el 30-04-2008 Adrian
							,	@dFechaProceso
							,	@dFechaPrxProceso

      SELECT @TasaVr_CLP = ISNULL(Tasa + spread, 1.0) / 100.0
      FROM   #TasaMoneda

      SELECT @nTasa2       = ISNULL(Tasa,1.0) FROM #TasaMoneda 

      --> =========================================================
      --> Se  Modifico Formula Con Fecha 23/07/2007 (Entrega Req.)
      --> =========================================================

      --> Calculo Original
          --> SET @Valor_Obtenido  = @Valor_UF * (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP) / (1.0 + @TasaVr_UF * @Plazo / @BaseUF)

      --> =========================================================
      --> Nuevo Metodo de Calculo
      DECLARE @nValorUf   FLOAT
	
      SET     @nValorUf   = ( SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA --, MFAC 
                                            WHERE vmfecha = @dFechaProceso /*acfecproc*/ AND vmcodigo = 998 )
	
      DECLARE @Pi_k       FLOAT
      SET     @Pi_k       = POWER( 1.0 + @TasaVr_CLP, @Plazo / @BaseCLP )
                          / POWER( 1.0 + @TasaVr_UF,  @Plazo / @BaseUF  ) - 1.0

      SET     @Valor_Obtenido = @nValorUf * ( 1.0 + @Pi_k )
      --> Nuevo Metodo de Calculo
      --> =========================================================

      SELECT @CaTasaSinteticaM1	      = @TasaVr_UF 
      SELECT @CaTasaSinteticaM2	      = @TasaVr_CLP
      SELECT @CaPrecioSpotVentaM1     = @Valor_UF
      SELECT @CaPrecioSpotVentaM2     = 1
      SELECT @CaPrecioSpotCompraM1    = @Valor_UF
      SELECT @CaPrecioSpotCompraM2    = 1

      IF @cTipOpe = 'C' --Compra  
      BEGIN
         SELECT @Valor_Mercado 	      = @Valor_Presente * (@PrecioFwd - @PreFut)
         SELECT @Valor_Activo  	      = @Valor_Presente *  @PrecioFwd
         SELECT @Valor_Pasivo  	      = @Valor_Presente *  @PreFut
         SELECT @ResultadoMTM 	      = @Valor_Presente * (@Valor_Obtenido - @PreFut ) / (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP)
         SELECT @ValorRazonableActivo = @Valor_Obtenido *  @Valor_Presente             / (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP)
         SELECT @ValorRazonablePasivo = @PreFut         *  @Valor_Presente             / (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP)
      END ELSE
      BEGIN
         SELECT @Valor_Mercado 	      = @Valor_Presente * (@PreFut - @PrecioFwd)
         SELECT @Valor_Activo  	      = @Valor_Presente *  @PreFut
         SELECT @Valor_Pasivo  	      = @Valor_Presente *  @PrecioFwd
         SELECT @ResultadoMTM 	      = @Valor_Presente * (@PreFut - @Valor_Obtenido ) / (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP) 
         SELECT @ValorRazonableActivo = @PreFut         *  @Valor_Presente             / (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP)
         SELECT @ValorRazonablePasivo = @Valor_Obtenido *  @Valor_Presente             / (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP)
      END

      SELECT @Valor_Mercado 	= ROUND( @Valor_Mercado, 0)
      SELECT @Valor_Activo  	= ROUND( @Valor_Activo , 0)
      SELECT @Valor_Pasivo  	= ROUND( @Valor_Pasivo , 0)
   END

	IF @dFechaPrxProceso =  '19000101' BEGIN -- PROCESO NORMAL DE DEVENGAMIENTO SI @dFechaPrxProceso TIENE OTRO VALOR, SE ESTA CALCULANDO BACK TEST
		UPDATE	MFCA 
		SET	catasadolar	= @nTasa1
		,	catasaufclp	= @nTasa2
		WHERE	canumoper	= @nNumOpe
	END

END

GO
