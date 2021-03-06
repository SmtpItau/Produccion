USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MARKTOMARKET]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MARKTOMARKET]
   (   @CodProd               INT
   ,   @Plazo                 INT
   ,   @nCodCnv               NUMERIC(03,00)
   ,   @Valor_UF              NUMERIC(12,04)
   ,   @Valor_Presente        NUMERIC(21,04)
   ,   @dFecVto               DATETIME
   ,   @cTipOpe               CHAR(01)
   ,   @PreFut                FLOAT
   ,   @nCodMon               NUMERIC(03,00)
   ,   @nNumOpe               NUMERIC(10)
   ,   @Valor_Mercado         FLOAT          OUTPUT
   ,   @PrecioFwd             FLOAT          OUTPUT
   ,   @Valor_Activo          FLOAT          OUTPUT
   ,   @Valor_Pasivo          FLOAT          OUTPUT
   ,   @Valor_Obtenido        FLOAT          OUTPUT
   ,   @ResultadoMTM          FLOAT          OUTPUT
   ,   @cModal                CHAR(01)
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
   ,   @TipoCurvaMon          VARCHAR(5)     OUTPUT
   ,   @TipoCurvaCnv          VARCHAR(5)     OUTPUT
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
   DECLARE @Valor_Futuro        FLOAT
   DECLARE @RefDol              CHAR(1)
   DECLARE @PreFutNuevo         FLOAT
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

   /*Asigna el valor a @baseclp solicitado se asigna 30(dias)       ---------------- */
   SET @BASECLP   = 360 --> 30
   SET @BASEUSD   = 360
   SET @BASEUF    = 360

   /* BUSCA FECHA DE PROCESO PARA EL CALCULO DEL VALOR DE MERCADO   ---------------- */
   SET @Fecha_Inicio           = CONVERT(CHAR(8),@dFechaproceso,112)

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

   IF @cCodigoProducto = 13
       SET @cCodigoProducto = 3

   DECLARE @cTipOper      CHAR(1)
       SET @cTipOper      = ISNULL((SELECT catipoper FROM MFCA WHERE canumoper = @nNumOpe),'C')

   DECLARE @cTipOperCnv   CHAR(1)
       SET @cTipOperCnv   = CASE WHEN @cTipOper = 'C' THEN 'V' ELSE 'C' END

   /********************************** << Seguros de Cambio >> *****************************************/
   IF @CodProd IN(12)
   BEGIN

      --> Obtiene el TCRC : Tipo de Cambio Relacion Contable
      DECLARE @nTCRC FLOAT
          SET @nTCRC = ISNULL((SELECT ISNULL(Tipo_Cambio,0.0) 
                                 FROM BacparamSuda..VALOR_MONEDA_CONTABLE with (nolock) 
                                WHERE Fecha         = @dFechaproceso
                                  AND codigo_moneda = @nCodMon),0.0)

      --> Obtiene Tasa Mx, en Base a la Interpolacion de Tasas
      DELETE FROM #TASAMONEDA
      INSERT INTO #TASAMONEDA EXECUTE SP_RetornaTasaMoneda @nCodMon, @Plazo, 'BFW', @cCodigoProducto, -1, -1, 0, @cTipOper

      DECLARE @nTASA_MX     FLOAT
      DECLARE @nSPREED_MX   FLOAT
      DECLARE @nSPOTCOM_MX  FLOAT
      DECLARE @nSPOTVEN_MX  FLOAT
 
      SELECT  @nTASA_MX     = ISNULL(Tasa, 1.0) / 100.0
      ,       @nSPREED_MX   = ISNULL(Spread, 0.0)
      ,       @nSPOTCOM_MX  = ISNULL(SpotCompra, 0.0)
      ,       @nSPOTVEN_MX  = ISNULL(SpotVenta, 0.0)
      ,       @nTasa1       = ISNULL(Tasa, 1.0)
      FROM    #TASAMONEDA

      --> Obtiene el Tipo de La Curva Asociada al Modulo + Producto + Moneda Conversion + Plazo + TipoOperacion + Fechaproceso
      EXECUTE dbo.SP_RetornaTipoOrigen_BFW 'BFW', @cCodigoProducto, @nCodMon, @Plazo, @cTipOperCnv, @dFechaProceso, @TipoCurvaMon OUTPUT
      --> 

      --> Obtiene Tasa $, en Base a la Interpolacion de Tasas
      DELETE FROM #TASAMONEDA
      INSERT INTO #TASAMONEDA EXECUTE SP_RetornaTasaMoneda @nCodCnv, @Plazo, 'BFW' , @cCodigoProducto, -1, -1, 0, @cTipOperCnv

      DECLARE @nTASA_CLP    FLOAT
      DECLARE @nSPREED_CLP  FLOAT
      DECLARE @nSPOTCOM_CLP FLOAT
      DECLARE @nSPOTVEN_CLP FLOAT

      SELECT  @nTASA_CLP    = ISNULL(Tasa + Spread, 1.0) / 100.0
      ,       @nSPREED_CLP  = ISNULL(Spread, 0.0)
      ,       @nSPOTCOM_CLP = ISNULL(SpotCompra, 0.0)
      ,       @nSPOTVEN_CLP = ISNULL(SpotVenta, 0.0)
      ,       @nTasa2       = ISNULL(Tasa, 1.0)
      FROM    #TASAMONEDA

      --> Obtiene el Tipo de La Curva Asociada al Modulo + Producto + Moneda Conversion + Plazo + TipoOperacion + Fechaproceso
      EXECUTE dbo.SP_RetornaTipoOrigen_BFW 'BFW', @cCodigoProducto, @nCodCnv, @Plazo, @cTipOperCnv, @dFechaProceso, @TipoCurvaCnv OUTPUT
      --> 

      --> Conforma el Precio MTM
      SET @Valor_Obtenido   = ISNULL(@nTCRC * ( (1.0 + ((@nTASA_CLP * @Plazo) / @BASECLP))
                                              / (1.0 + ((@nTASA_MX  * @Plazo) / @BASECLP))
                                              ),0.0)

      --> Calculos de AVR: Valor Razonable
      IF @cTipOpe = 'C'
      BEGIN
         SET @ResultadoMTM         = (@Valor_Presente  * (@Valor_Obtenido - @PreFut)) / (1.0 + ((@nTASA_CLP * @Plazo) / @BASECLP))
         SET @ValorRazonableActivo = (@Valor_Presente  * @Valor_Obtenido)             / (1.0 + ((@nTASA_CLP * @Plazo) / @BASECLP))
         SET @ValorRazonablePasivo = (@Valor_Presente  * @PreFut)                     / (1.0 + ((@nTASA_CLP * @Plazo) / @BASECLP))
      END ELSE
      BEGIN
         SET @ResultadoMTM         = (@Valor_Presente  * (@PreFut - @Valor_Obtenido)) / (1.0 + ((@nTASA_CLP * @Plazo) / @BASECLP))
         SET @ValorRazonableActivo = (@Valor_Presente  * @PreFut)                     / (1.0 + ((@nTASA_CLP * @Plazo) / @BASECLP))
         SET @ValorRazonablePasivo = (@Valor_Presente  * @Valor_Obtenido)             / (1.0 + ((@nTASA_CLP * @Plazo) / @BASECLP))
      END
      SET @CaTasaSinteticaM1       = @nTASA_MX + @nSPREED_MX
      SET @CaTasaSinteticaM2       = @nTASA_CLP
      SET @CaPrecioSpotCompraM1    = @nSPOTCOM_MX
      SET @CaPrecioSpotVentaM1     = @nSPOTVEN_MX
      SET @CaPrecioSpotCompraM2    = @nSPOTCOM_CLP
      SET @CaPrecioSpotVentaM2     = @nSPOTVEN_CLP
      SET @PrecioFwd               = @Valor_Obtenido

      IF @cTipOpe = 'C'
      BEGIN
         SET @Valor_Mercado        = ROUND(@Valor_Presente * (@PrecioFwd - @PreFut),0)
         SET @Valor_Activo         = ROUND(@Valor_Presente * @PrecioFwd,0)
         SET @Valor_Pasivo         = ROUND(@Valor_Presente * @PreFut,0)
      END ELSE
      BEGIN
         SET @Valor_Mercado        = ROUND(@Valor_Presente * (@PreFut - @PrecioFwd),0)
         SET @Valor_Activo         = ROUND(@Valor_Presente * @PreFut,0)
         SET @Valor_Pasivo         = ROUND(@Valor_Presente * @PrecioFwd,0)
      END
   END

   /**********************************---------------------------------<< Seguros de Cambio>>-----------------------*****************************************/
   /**********************************--------------------------------------------------------------------------------------------*****************************************/
   IF @CodProd IN(1, 7)
   BEGIN 
      /*****************************************************************************************************/
      /* Solo compensaciones parciales se rescata el precio a la fecha de proximo vcto. Flujo  VGS 02/2005 */
      /*****************************************************************************************************/
      IF @CodProd = 7
      BEGIN
            SET @PreFut = 0.0
         SELECT @PreFut = corprecio FROM CORTES with (nolock) WHERE cornumoper = @nNumOpe AND corfecvcto = @dFecVto
      END

      /* BUSCA DOLAR INTERBANCARIO COMPRA O VENTA -------------------------------------- */
         SET @BidAsk  = 1.0
      SELECT @BidAsk  = ISNULL(vmvalor,1.0)
      FROM   BacParamSuda..VALOR_MONEDA    with (nolock)
      WHERE  vmfecha  = CASE WHEN @nCodMon = 998 THEN @FechaCalculos ELSE @Fecha_Inicio END
      AND    vmcodigo = CASE WHEN @nCodMon <> 13 THEN @nCodMon       ELSE 994           END

      IF @nCodMon <> 13
         SET @BidAsk = ROUND(@Valor_Dolar / @BidAsk, 2)

        /* CALCULA SEGUN MONEDA DEL CONTRATO FORWARD ------------------------------------- */
      SET @Tasa_USD          = 1.0
      SET @Tasa_FWD          = 1.0
      SET @Tasa_CLP          = 1.0
      SET @Spread            = 0.0
      SET @Valor_Obtenido    = 0.0 

      DELETE FROM #TasaMoneda
      INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda 13, @Plazo, 'BFW', @cCodigoProducto, -1, -1, 0, @cTipOper

      SELECT @Tasa_USD        = ISNULL(Tasa,1.0) / 100.0
      ,      @Spread                = ISNULL(Spread,0.0)
      ,      @CaPrecioSpotCompraM1  = ISNULL(SpotCompra, 0.0)
      ,      @CaPrecioSpotVentaM1   = ISNULL(SpotVenta, 0.0)
      ,      @nTasa1                = ISNULL(Tasa,1.0) 
      FROM   #TasaMoneda 

      --> Obtiene el Tipo de La Curva Asociada al Modulo + Producto + Moneda Operacion + Plazo + TipoOperacion + Fechaproceso
      EXECUTE dbo.SP_RetornaTipoOrigen_BFW 'BFW', @cCodigoProducto, 13, @Plazo, @cTipOper, @dFechaProceso, @TipoCurvaMon OUTPUT
      --> 

      IF @nCodCnv = 999 --> PESOS
      BEGIN
         DELETE FROM #TasaMoneda
         INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda 999 , @Plazo , 'BFW' , @cCodigoProducto, -1, -1, 0, @cTipOperCnv

         SELECT @Tasa_FWD             = ISNULL(Tasa + Spread, 1.0) / 100.0
         ,      @CaPrecioSpotCompraM2 = ISNULL(SpotCompra, 0.0)
         ,      @CaPrecioSpotVentaM2  = ISNULL(SpotVenta, 0.0)
         ,      @nTasa2               = ISNULL(Tasa,1.0)
         FROM   #TasaMoneda  

         --> Obtiene el Tipo de La Curva Asociada al Modulo + Producto + Moneda Conversion + Plazo + TipoOperacion + Fechaproceso
         EXECUTE dbo.SP_RetornaTipoOrigen_BFW 'BFW', @cCodigoProducto, 999, @Plazo, @cTipOperCnv, @dFechaProceso, @TipoCurvaCnv OUTPUT
         --> 

         SET @PrecioFwd = ISNULL(@BidAsk * ( (1.0 + (@Tasa_FWD / @BASECLP) * @Plazo) / (1.0 + ((@Tasa_USD + @Spread) / @BASEUSD) * @Plazo)), 0.0)
                                                   
         IF @cTipOpe = 'C'   
         BEGIN --Compra
            SET @Valor_Obtenido       = ISNULL(@CaPrecioSpotVentaM1 * ((1.0 + (@Tasa_FWD / @BASECLP) * @Plazo) / (1.0 + ((@Tasa_USD + @Spread) / @BASEUSD) * @Plazo)), 0.0) 
            SET @ResultadoMTM         = (@Valor_Obtenido - @PreFut) * @Valor_Presente / (1 + @Tasa_Fwd * @Plazo / @BaseCLP)
            SET @ValorRazonableActivo = @Valor_Obtenido  * @Valor_Presente / (1.0 + @Tasa_Fwd * @Plazo / @BaseCLP)
            SET @ValorRazonablePasivo = @PreFut          * @Valor_Presente / (1.0 + @Tasa_Fwd * @Plazo / @BaseCLP)
         END ELSE
         BEGIN     ---Venta
            SET @Valor_Obtenido       = ISNULL(@CaPrecioSpotCompraM1 * ((1.0 +  (@Tasa_FWD / @BASECLP) * @Plazo) / (1.0 + ((@Tasa_USD + @Spread) / @BASEUSD) * @Plazo)), 0.0) 
            SET @ResultadoMTM         = (@PreFut         - @Valor_Obtenido) * @Valor_Presente / (1 + @Tasa_Fwd * @Plazo / @BaseCLP)
            SET @ValorRazonableActivo = @PreFut          * @Valor_Presente / (1.0 + @Tasa_Fwd * @Plazo / @BaseCLP)
            SET @ValorRazonablePasivo = @Valor_Obtenido  * @Valor_Presente / (1.0 + @Tasa_Fwd * @Plazo / @BaseCLP)
         END

         SET @CaTasaSinteticaM1       = @Tasa_USD + @Spread
         SET @CaTasaSinteticaM2       = @Tasa_FWD
         SET @CaPrecioSpotVentaM1     = @CaPrecioSpotVentaM1
         SET @CaPrecioSpotVentaM2     = @CaPrecioSpotVentaM2
         SET @CaPrecioSpotCompraM1    = @CaPrecioSpotCompraM1
         SET @CaPrecioSpotCompraM2    = @CaPrecioSpotCompraM2
      END ELSE 
      BEGIN  ---UF--
         DELETE FROM #TasaMoneda
         INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda 998 , @Plazo , 'BFW' , @cCodigoProducto, -1, -1, 0, @cTipOperCnv

         SELECT @Tasa_FWD             = ISNULL(Tasa + Spread , 1.0) / 100.0
         ,      @CaPrecioSpotCompraM2 = ISNULL(SpotCompra, 0.0)
         ,      @CaPrecioSpotVentaM2  = ISNULL(SpotVenta, 0.0)
         ,      @nTasa2               = ISNULL(Tasa,1.0)
         FROM   #TasaMoneda

         --> Obtiene el Tipo de La Curva Asociada al Modulo + Producto + Moneda Conversion + Plazo + TipoOperacion + Fechaproceso
         EXECUTE dbo.SP_RetornaTipoOrigen_BFW 'BFW', @cCodigoProducto, 998, @Plazo, @cTipOperCnv, @dFechaProceso, @TipoCurvaCnv OUTPUT
         --> 

         SET @PrecioFwd = (@BidAsk / @Valor_UF) * ((1.0 + (@Tasa_FWD / @BASEUF) * @Plazo) / (1.0 + ((@Tasa_USD + @Spread) / @BASEUSD) * @Plazo))

         IF @cTipOpe = 'C' --Compra
         BEGIN    
            SET @Valor_Obtenido       =  ISNULL((@CaPrecioSpotVentaM1 / @Valor_UF )* ((1.0 +  (@Tasa_FWD / @BASEUF) * @Plazo) / (1.0 + ((@Tasa_USD + @Spread) / @BASEUSD) * @Plazo)), 0.0)
            SET @ResultadoMTM         = (@Valor_Obtenido - @PreFut)        * @Valor_Presente  / (1 + @Tasa_Fwd * @Plazo / @BaseUF)
            SET @ValorRazonableActivo =  @Valor_Obtenido * @Valor_Presente / (1.0 + @Tasa_Fwd * @Plazo / @BaseUF) * @Valor_UF
            SET @ValorRazonablePasivo =  @PreFut         * @Valor_Presente / (1.0 + @Tasa_Fwd * @Plazo / @BaseUF) * @Valor_UF
         END ELSE ---Venta
         BEGIN
            SET @Valor_Obtenido       =  ISNULL((@CaPrecioSpotCompraM1 / @Valor_UF) * ((1.0 +  (@Tasa_FWD / @BASEUF) * @Plazo) / (1.0 + ((@Tasa_USD + @Spread) / @BASEUSD) * @Plazo)), 0.0)
            SET @ResultadoMTM         = (@PreFut         - @Valor_Obtenido) * @Valor_Presente  / (1 + @Tasa_Fwd * @Plazo / @BaseUF)
            SET @ValorRazonableActivo =  @PreFut         * @Valor_Presente  / (1.0 + @Tasa_Fwd * @Plazo / @BaseUF) * @Valor_UF
            SET @ValorRazonablePasivo =  @Valor_Obtenido * @Valor_Presente  / (1.0 + @Tasa_Fwd * @Plazo / @BaseUF) * @Valor_UF
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

      IF @cTipOpe = 'C'
      BEGIN
         SET @Valor_Mercado = @Valor_Presente * (@PrecioFwd - @PreFut)
         SET @Valor_Activo  = @Valor_Presente * @PrecioFwd
         SET @Valor_Pasivo  = @Valor_Presente * @PreFut
      END ELSE --VENTA
      BEGIN
         SET @Valor_Mercado = @Valor_Presente * (@PreFut - @PrecioFwd)
         SET @Valor_Activo  = @Valor_Presente * @PreFut
         SET @Valor_Pasivo  = @Valor_Presente * @PrecioFwd
      END
      IF @nCodCnv = 998
      BEGIN
         SET @Valor_Mercado  = ROUND( @Valor_Mercado, 4) * @Valor_UF
         SET @Valor_Activo   = ROUND( @Valor_Activo , 4) * @Valor_UF
         SET @Valor_Pasivo   = ROUND( @Valor_Pasivo , 4) * @Valor_UF
      END
      SET @Valor_Mercado     = ROUND( @Valor_Mercado, 0)
      SET @Valor_Activo      = ROUND( @Valor_Activo , 0)
      SET @Valor_Pasivo      = ROUND( @Valor_Pasivo , 0)
   END

   /**********************************-----------------------------------<< Arbitrajes a Futuro>>------------------------*****************************************/
   /**********************************--------------------------------------------------------------------------------------------*****************************************/
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
      INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda @nCodCnv , @Plazo , 'BFW' , @cCodigoProducto, -1, -1, 0, @cTipOperCnv

      SELECT @TasaVr_USD    = ISNULL(Tasa, 1.0) / 100.0
      ,      @SpreadVr_USD  = ISNULL(Spread, 1.0)
      ,      @nTasa1        = ISNULL(Tasa,1.0)
      FROM   #TasaMoneda

      SET @CaTasaSinteticaM2 = @TasaVr_USD

      --> Obtiene el Tipo de La Curva Asociada al Modulo + Producto + Moneda Conversion + Plazo + TipoOperacion + Fechaproceso
      EXECUTE dbo.SP_RetornaTipoOrigen_BFW 'BFW', @cCodigoProducto, @nCodCnv, @Plazo, @cTipOperCnv, @dFechaProceso, @TipoCurvaCnv OUTPUT
      --> 

      DELETE FROM #TasaMoneda
      INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda @nCodMon , @Plazo , 'BFW' , @cCodigoProducto, -1, -1, 0, @cTipOper

      SELECT @TasaVr_MX     = ISNULL(Tasa, 1.0) / 100.0
      ,      @SpreadVr_MX   = ISNULL(Spread, 1.0)
      ,      @nTasa2        = ISNULL(Tasa,1.0)
      FROM   #TasaMoneda

      SET @CaTasaSinteticaM1 = @TasaVr_MX 

      --> Obtiene el Tipo de La Curva Asociada al Modulo + Producto + Moneda Operacion + Plazo + TipoOperacion + Fechaproceso
      EXECUTE dbo.SP_RetornaTipoOrigen_BFW 'BFW', @cCodigoProducto, @nCodMon, @Plazo, @cTipOper, @dFechaProceso, @TipoCurvaMon OUTPUT
      --> 

      EXECUTE SP_BIDASK2 @nCodMon, @Fecha_Inicio, @cTipOpe, @Plazo, @Tasa_USD OUTPUT, @Tasa_FWD OUTPUT

      SET @PrecioFwd     = @Tasa_USD + @Tasa_FWD
      SET @Valor_Futuro  = 0.0

      SELECT @RefDol        = ISNULL(mnrrda,'D')
      ,      @BASEMX        = ISNULL(mnbase,0)
      FROM   BacParamSuda..MONEDA with (nolock)
      WHERE  mncodmon       = @nCodMon  --Relación con el dolar si se Mult. o Div.

      --> Se cambio pero no se Ocupa
      IF @nCodMon IN(994,995,997,998)
         SELECT @Valor_MonedaMX = ISNULL(vmvalor,0)
         FROM   BacParamSuda..VALOR_MONEDA with (nolock)
         WHERE  vmcodigo        = @nCodMon
         AND    vmfecha         = CASE WHEN @nCodMon = 998 THEN @FechaCalculos ELSE @Fecha_Inicio END
      ELSE
         SELECT @Valor_MonedaMX = ISNULL(Tipo_Cambio,0) 
         FROM   BacParamSuda..VALOR_MONEDA_CONTABLE with (nolock)
         WHERE  Codigo_Moneda   = CASE WHEN @nCodMon = 13 THEN 994 ELSE @nCodMon END
         AND    Fecha           = CASE WHEN @Indice  = 1  THEN @dFechaAnterior ELSE @dFechaProceso END -- @Fecha_Inicio

      IF @RefDol = 'D' 
      BEGIN
         SET @Valor_Futuro      = ROUND(@Valor_Presente / @PrecioFwd,2)
         SET @Valor_Mercado     = ROUND(@Valor_Presente / @PreFut   ,2)
      END ELSE
      BEGIN
         SET @Valor_Futuro      = ROUND(@Valor_Presente * @PrecioFwd,2)
         SET @Valor_Mercado     = ROUND(@Valor_Presente * @PreFut   ,2)
      END

      IF @cTipOpe = 'C' --> Compra
      BEGIN
         SET @Valor_Activo      = ROUND(@Valor_Futuro  * @Valor_Dolar,0)
         SET @Valor_Pasivo      = ROUND(@Valor_Mercado * @Valor_Dolar,0)
         SET @Valor_Mercado     = ROUND(@Valor_Activo  - @Valor_Pasivo,0)

         DELETE FROM #RESRetornaParidadForward
         INSERT INTO #RESRetornaParidadForward EXECUTE SP_RetornaParidadForward @nCodMon,@Plazo , 1 ,@Fecha_Inicio

         -- Para recuperar el Valor Razonable y los precios spot
         SELECT @Valor_Obtenido        = PrecioForward
         ,      @CaPrecioSpotVentaM1     = PrecioPunta
         ,      @CaPrecioSpotVentaM2    = 1.0
         ,      @CaPrecioSpotCompraM2    = 1.0
         FROM   #RESRetornaParidadForward

         DELETE FROM #RESRetornaParidadForward
         INSERT INTO #RESRetornaParidadForward EXECUTE SP_RetornaParidadForward @nCodMon,@Plazo , 2 ,@Fecha_Inicio

         SELECT @CaPrecioSpotCompraM1 = PrecioPunta
         FROM   #RESRetornaParidadForward

         --Compra, Compensacion
         -- 28-Jun-05 MPNG Se modifica la resta de paridades para moneda Débil (Divide paridad )
         IF @RefDol = 'D'
         BEGIN
            SET @DifPre               = (1.0 / (@Valor_Obtenido * 1.0) - 1.0 / (@PreFut * 1.0))
            SET @ValorRazonableActivo = (1.0 /  @Valor_Obtenido * 1.0) * @Valor_Presente / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
            SET @ValorRazonablePasivo = (1.0 /  @PreFut         * 1.0) * @Valor_Presente / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
         END ELSE
         BEGIN
            SET @DifPre               =  @Valor_Obtenido - @PreFut
            SET @ValorRazonableActivo =  @Valor_Obtenido * @Valor_Presente / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
            SET @ValorRazonablePasivo =  @PreFut         * @Valor_Presente / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
         END
         SET @ResultadoMTM = @Valor_Presente * @DifPre / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
      END ELSE  --Venta
      BEGIN

         SET @Valor_Activo  = ROUND(@Valor_Mercado * @Valor_Dolar,0)
         SET @Valor_Pasivo  = ROUND(@Valor_Futuro  * @Valor_Dolar,0)
         SET @Valor_Mercado = ROUND(@Valor_Activo  - @Valor_Pasivo,0)

         DELETE FROM #RESRetornaParidadForward
         INSERT INTO #RESRetornaParidadForward EXECUTE SP_RetornaParidadForward @nCodMon,@Plazo , 2 ,@Fecha_Inicio

         -- Para recuperar el Valor Razonable y los precios spot
         SELECT @Valor_Obtenido       = PrecioForward
         ,      @CaPrecioSpotCompraM1 = PrecioPunta
         ,      @CaPrecioSpotVentaM2  = 1.0
         ,      @CaPrecioSpotCompraM2 = 1.0
         FROM   #RESRetornaParidadForward

         DELETE FROM #RESRetornaParidadForward
         INSERT INTO #RESRetornaParidadForward EXECUTE SP_RetornaParidadForward @nCodMon,@Plazo , 1 ,@Fecha_Inicio

         -- Para recuperar el Precio spot  Compra
         SELECT @CaPrecioSpotVentaM1  = PrecioPunta
         FROM   #RESRetornaParidadForward

         --Venta, Compensacion
         -- 28-Jun-05 MPNG Se modifica la resta de paridades para moneda Débil (Divide paridad )

         IF @RefDol = 'D'
         BEGIN
            SET @DifPre                = (1.0 / (@PreFut * 1.0)  - 1.0 / (@Valor_Obtenido * 1.0))
            SET @ValorRazonableActivo  = (1.0 /  @PreFut * 1.0)         * @Valor_Presente / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
            SET @ValorRazonablePasivo  = (1.0 /  @Valor_Obtenido * 1.0) * @Valor_Presente / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
         END ELSE
         BEGIN
            SET @DifPre                =  @PreFut - @Valor_Obtenido
            SET @ValorRazonableActivo  =  @PreFut * @Valor_Presente         / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
            SET @ValorRazonablePasivo  =  @Valor_Obtenido * @Valor_Presente / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar
         END
         SET @ResultadoMTM =  @Valor_Presente * @DifPre / (1.0 + (@TasaVR_USD + @SpreadVR_USD) * @Plazo / @BaseUSD) * @Valor_Dolar

      END
   END

   ---------------------------------<< Seguros de Inflacion y Seguros de Inflacion Hipotecarios
   IF @CodProd = 3 OR @CodProd = 13
   BEGIN
      /* BUSCA VALOR DE UF PROYECTADA -------------------------------------------------- */
      SET     @PrecioFwd = -1
      EXECUTE SP_UFPROYECTADA @dFecVto, @PrecioFwd OUTPUT

      IF @PrecioFwd = 0 OR @PrecioFwd IS NULL
         SET  @PrecioFwd = @Valor_UF

      DELETE FROM #TasaMoneda
      INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda @nCodMon , @Plazo , 'BFW' , @cCodigoProducto, -1, -1, 0, @cTipOper

      SELECT @TasaVr_UF     = ISNULL(Tasa + spread, 1.0) / 100.0
      ,      @nTasa1        = ISNULL(Tasa,1.0)
      FROM   #TasaMoneda

      --> Obtiene el Tipo de La Curva Asociada al Modulo + Producto + Moneda Operacion + Plazo + TipoOperacion + Fechaproceso
      EXECUTE dbo.SP_RetornaTipoOrigen_BFW 'BFW', @cCodigoProducto, @nCodMon, @Plazo, @cTipOper, @dFechaProceso, @TipoCurvaMon OUTPUT
      --> 

      DELETE FROM #TasaMoneda
      INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda 999 , @Plazo , 'BFW' , @cCodigoProducto, -1, -1, 0, @cTipOperCnv

      SELECT @TasaVr_CLP    = ISNULL(Tasa + spread, 1.0) / 100.0
      ,      @nTasa2        = ISNULL(Tasa,1.0)
      FROM   #TasaMoneda

      --> Obtiene el Tipo de La Curva Asociada al Modulo + Producto + Moneda Conversion + Plazo + TipoOperacion + Fechaproceso
      EXECUTE dbo.SP_RetornaTipoOrigen_BFW 'BFW', @cCodigoProducto, 999, @Plazo, @cTipOperCnv, @dFechaProceso, @TipoCurvaCnv OUTPUT
      --> 

      --> =========================================================
      --> Se  Modifico Formula Con Fecha 23/07/2007 (Entrega Req.)
      --> =========================================================

      --> Calculo Original
          --> SET @Valor_Obtenido  = @Valor_UF * (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP) / (1.0 + @TasaVr_UF * @Plazo / @BaseUF)

      --> =========================================================
      --> Nuevo Metodo de Calculo
      DECLARE @nValorUf   FLOAT
      SET     @nValorUf   = ( SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA
                                            WHERE vmfecha = @FechaCalculos AND vmcodigo = 998 )
                                       -->  WHERE vmfecha = @dFechaProces  AND vmcodigo = 998 )

      DECLARE @Pi_k       FLOAT
      SET     @Pi_k       = POWER( 1.0 + @TasaVr_CLP, @Plazo / @BaseCLP )
                          / POWER( 1.0 + @TasaVr_UF,  @Plazo / @BaseUF  ) - 1.0

      SET     @Valor_Obtenido = @nValorUf * ( 1.0 + @Pi_k )
      --> Nuevo Metodo de Calculo
      --> =========================================================

      SET @CaTasaSinteticaM1    = @TasaVr_UF 
      SET @CaTasaSinteticaM2    = @TasaVr_CLP
      SET @CaPrecioSpotVentaM1  = @Valor_UF
      SET @CaPrecioSpotVentaM2  = 1
      SET @CaPrecioSpotCompraM1 = @Valor_UF
      SET @CaPrecioSpotCompraM2 = 1

      IF @cTipOpe = 'C' --Compra
      BEGIN
         SET @Valor_Mercado        = @Valor_Presente * (@PrecioFwd - @PreFut)
         SET @Valor_Activo         = @Valor_Presente *  @PrecioFwd
         SET @Valor_Pasivo         = @Valor_Presente *  @PreFut
         SET @ResultadoMTM         = @Valor_Presente * (@Valor_Obtenido - @PreFut ) / (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP)
         SET @ValorRazonableActivo = @Valor_Obtenido *  @Valor_Presente             / (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP)
         SET @ValorRazonablePasivo = @PreFut         *  @Valor_Presente             / (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP)
      END ELSE
      BEGIN
         SET @Valor_Mercado        = @Valor_Presente * (@PreFut - @PrecioFwd)
         SET @Valor_Activo         = @Valor_Presente *  @PreFut
         SET @Valor_Pasivo         = @Valor_Presente *  @PrecioFwd
         SET @ResultadoMTM        = @Valor_Presente  * (@PreFut - @Valor_Obtenido ) / (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP) 
         SET @ValorRazonableActivo = @PreFut         *  @Valor_Presente             / (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP)
         SET @ValorRazonablePasivo = @Valor_Obtenido *  @Valor_Presente             / (1.0 + @TasaVr_CLP * @Plazo / @BaseCLP)
      END

      SET @Valor_Mercado   = ROUND(@Valor_Mercado, 0)
      SET @Valor_Activo    = ROUND(@Valor_Activo , 0)
      SET @Valor_Pasivo    = ROUND(@Valor_Pasivo , 0)
   END

/*    --SE MUEVE ESTE UPDATE AL PROCEDIMIENTO SP_DEVENGAMIENTO 
   UPDATE MFCA           with (rowlock)
      SET catasadolar    = @nTasa1
        , catasaufclp    = @nTasa2
        , caOrgCurvaMon  = @TipoCurvaMon
        , caOrgCurvaCnv  = @TipoCurvaCnv
    WHERE canumoper      = @nNumOpe
*/

END

GO
