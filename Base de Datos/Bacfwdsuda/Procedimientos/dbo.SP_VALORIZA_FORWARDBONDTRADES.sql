USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORIZA_FORWARDBONDTRADES]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_VALORIZA_FORWARDBONDTRADES]
   (    @NumeroOperacion   NUMERIC(9)   
   ,	@iEjecucionIniDia  INT
   ,	@Tir_Fwd	   NUMERIC(21,4) 
   ,	@fResObtenido      FLOAT OUTPUT
   ,    @fTirBenchmarck    FLOAT OUTPUT
   ,	@nFlag		       INT = 0	
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso        DATETIME
   ,       @dFechaAnterior       DATETIME

   SELECT  @dFechaProceso  = acfecproc
   ,       @dFechaAnterior = acfecante
   FROM    MFAC

   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos
   DECLARE @FechaCalculos    DATETIME
    SELECT @FechaCalculos    = CASE WHEN DATEPART(MONTH, acfecproc) = DATEPART(MONTH, acfecprox) THEN acfecproc
                                    ELSE DATEADD( DAY, DAY(DATEADD(MONTH, 1, acfecproc)) *-1, DATEADD(MONTH, 1, acfecproc) )
                               END
      FROM MFAC
   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos


   DECLARE @Valorizador          VARCHAR(50)
   ,       @nError               INT
   ,       @Mon_inst             NUMERIC(9)
   ,       @Mon_pago             NUMERIC(9)
   ,       @Fec_inic             DATETIME
   ,       @Fec_Vcto             DATETIME
   ,       @Mon_Nominal          NUMERIC(21,4)
   ,       @Mon_VpresPe          NUMERIC(21,0)
   ,       @Mon_VPresUm          NUMERIC(21,4)
   ,       @Mon_VMercado         NUMERIC(21,0)
   ,       @Tir_Forward          NUMERIC(21,4)
   ,       @Tir_Mercado          NUMERIC(21,4)
   ,       @Tir_Benchmarck       NUMERIC(21,4)
   ,       @ReajusteDia          NUMERIC(21,4)
   ,       @ReajusteAcum         NUMERIC(21,4)
   ,       @VariacionDia         NUMERIC(21,4)
   ,       @VariacionAcum        NUMERIC(21,4)
   ,       @dFechaVctoIns        DATETIME
   ,       @Seriedo              CHAR(1)
   ,       @Fec_Calc             DATETIME
   ,       @Cod_inst             NUMERIC(9)
   ,       @Ser_Inst             VARCHAR(20)
   ,       @Fec_Emis             DATETIME
   ,       @Tas_Emis             NUMERIC(21,4)
   ,       @Bas_Emis             NUMERIC(9)
   ,       @Mon_Emis             NUMERIC(9)
   ,       @Tas_Est              NUMERIC(21,4)
   ,       @Fec_UltDev           DATETIME
   ,       @fPvp                 FLOAT
   ,       @fMt                  FLOAT
   ,       @fMtum                FLOAT
   ,       @fMt_cien             FLOAT
   ,       @fVan                 FLOAT
   ,       @fVpar                FLOAT
   ,       @nNumucup             INT
   ,       @dFecucup             DATETIME
   ,       @fIntucup             FLOAT
   ,       @fAmoucup             FLOAT
   ,       @fSalucup             FLOAT
   ,       @nNumpcup             INT
   ,       @dFecpcup             DATETIME
   ,       @fIntpcup             FLOAT
   ,       @fAmopcup             FLOAT
   ,       @fSalpcup             FLOAT
   ,       @fDurat               FLOAT
   ,       @fConvx               FLOAT
   ,       @fDurmo               FLOAT
   ,       @TipoOper             CHAR(1)
   ,       @BenchMarck           CHAR(1)
   ,       @fTe_pcdus            FLOAT
   ,       @fTe_pcduf            FLOAT
   ,       @fTe_ptf              FLOAT
   ,       @ValUmTasaPact        FLOAT
   ,       @ValUmTasaCurv        FLOAT
   ,       @ValDifUm             FLOAT
   ,       @Plazo                INT
   ,       @iTasaMonedaL         FLOAT
   ,       @iTasaMonedaE         FLOAT
   ,       @mtm_hoy_moneda1      FLOAT
   ,       @mtm_hoy_moneda2      FLOAT
   ,       @ValorRazonableActivo FLOAT
   ,       @ValorRazonablePasivo FLOAT
   , 	   @fRes_Obtenido        FLOAT

   DECLARE @iValorMonedaEmi      FLOAT
   ,       @iBaseLocal           FLOAT
   ,       @imndecimal           NUMERIC(3)


   -- Forward Bond Trades --
   SELECT  @Mon_inst      = cacodmon1
   ,       @Mon_pago      = cacodmon2
   ,       @Fec_inic      = cafecha
   ,       @Fec_Vcto      = cafecvcto
 ,       @Mon_Nominal   = camtomon1
   ,       @Mon_VpresPe   = caequmon1
   ,       @Mon_VPresUm   = camtomon2
   ,       @Mon_VMercado  = caequusd2
   ,       @Tir_Forward   = @Tir_Fwd --catipcam
   ,       @Tir_Mercado   = capremon1
   ,       @Seriedo       = caseriado
   ,       @Ser_Inst      = caserie
   ,       @Cod_inst      = cabroker
   ,       @Fec_Calc      = cafecvcto 
   ,       @Tas_Est       = 0
   ,       @Fec_UltDev    = fechaemision  
   ,       @TipoOper      = catipoper
   ,       @Plazo         = DATEDIFF(DAY, @FechaCalculos, cafecEfectiva) --> DATEDIFF(DAY, @dFechaProceso, cafecEfectiva)
   ,       @BenchMarck    = '*'
   FROM    MFCA
   WHERE   canumoper      = @NumeroOperacion


 IF @Seriedo = 'S'
   BEGIN
      SELECT @Tas_Emis       = setasemi 
      ,      @Mon_Emis       = semonemi 
      ,      @Bas_Emis       = sebasemi 
      ,      @Fec_Emis       = sefecemi
      ,      @dFechaVctoIns  = sefecven
      FROM   bacparamsuda..SERIE
      WHERE  semascara       = @Ser_Inst
   END ELSE 
   BEGIN
      SET ROWCOUNT 1
      SELECT @Tas_Emis          = nstasemi 
      ,      @Mon_Emis          = nsmonemi 
      ,      @Bas_Emis          = nsbasemi 
      ,      @Fec_Emis          = nsfecemi
      ,      @dFechaVctoIns     = nsfecven
      FROM   bacparamsuda..NOSERIE
      WHERE  nsserie            = @Ser_Inst
      SET ROWCOUNT 0
   END

   IF EXISTS(SELECT 1 FROM bacparamsuda..INSTRUMENTO WHERE incodigo = @Cod_inst)
   BEGIN
      SELECT @Valorizador = 'bactradersuda..SP_' + LTRIM(RTRIM(inprog))
      FROM   bacparamsuda..INSTRUMENTO
      WHERE  incodigo     = @Cod_inst



      IF @Mon_Emis <> 999
      BEGIN
         SELECT @Tas_Est = CASE WHEN @Cod_inst = 1 THEN @fTe_pcdus
                                WHEN @Cod_inst = 2 THEN @fTe_pcduf
                                WHEN @Cod_inst = 5 THEN @fTe_ptf
                                ELSE                    CONVERT(FLOAT,0)
                           END
      END
   END

   -- Definir Tasa Mercado para la valorización (benchmarck)  --
   DECLARE @nPlazo   INT
   SET     @nPlazo   = DATEDIFF(YEAR, @FechaCalculos, @dFechaVctoIns) --> DATEDIFF(YEAR, @dFechaProceso,  @dFechaVctoIns)
-- SET     @nPlazo   = DATEDIFF(YEAR, @Fec_Emis, @dFechaVctoIns)

   IF @Ser_Inst = 'BCU0500912'
      SET @nPlazo   = 7

   -- Definir Tasa Mercado para la valorización (Curva)  --
   SELECT @Tir_Mercado    = 0.0
   SELECT @Tir_Mercado    = ISNULL(Tasa,0.0)
   ,      @BenchMarck     = ' ' 
   FROM   BENCH_MARCK
   WHERE  Instrumento     = @Cod_inst
   AND    Moneda          = @Mon_Emis
   AND    @nPlazo         BETWEEN Desde AND Hasta

   IF @BenchMarck = '*' OR @Tir_Mercado IS NULL
   BEGIN
      SELECT @Tir_Mercado = 0.0
   END

   SELECT @Tir_Benchmarck = 0.0
   SELECT @Tir_Benchmarck = ISNULL(Tasa,0.0)
   ,      @BenchMarck     = ' ' 
   FROM   BENCH_MARCK
   WHERE  Instrumento     = @Cod_inst
   AND    Moneda          = @Mon_Emis
   AND    Fecha           = CASE WHEN @iEjecucionIniDia = 0 THEN @dFechaProceso ELSE @dFechaAnterior END
   AND    @nPlazo         BETWEEN Desde AND Hasta

   IF @BenchMarck = '*' OR @Tir_Benchmarck IS NULL
   BEGIN
      SELECT @Tir_Benchmarck = 0.0
   END

   /*Creacion de tabla temporal*/	
   CREATE TABLE #TasaMoneda
   (   Tasa           	FLOAT   NOT NULL DEFAULT(0.0)
   ,   Spread         	FLOAT   NOT NULL DEFAULT(0.0)
   ,   SpotCompra   	FLOAT   NOT NULL DEFAULT(0.0)
   ,   SpotVenta      	FLOAT   NOT NULL DEFAULT(0.0)
   )

   INSERT INTO #TasaMoneda
   EXECUTE SP_RetornaTasaMoneda @Mon_Emis , @Plazo   -- SP_RetornaTasaMoneda 998 , 5

   SELECT  @Tir_Mercado = Tasa                       -- El valorizador recibe las tasas sin dividir por 100
   FROM    #TasaMoneda

   -- ******************************************* --

   EXECUTE @nError     = @Valorizador
                         2                   -- @iModcal
   ,                     @Fec_Calc           -- @dFeccal
   ,                     @Cod_inst           -- @iCodigo
   ,                     @Ser_Inst           -- @cInstser
   ,                     @Mon_Emis           -- @iMonemi
   ,                     @Fec_Emis           -- @dFecemi
   ,                     @Fec_Vcto           -- @dFecven
   ,                     @Tas_Emis           -- @fTasemi
   ,                     @Bas_Emis           -- @fBasemi
   ,                     @Tas_Est            -- @fTasest
   ,                     @Mon_Nominal OUTPUT -- @fNominal OUTPUT
   ,                     @Tir_Forward OUTPUT -- @fTir     OUTPUT
   ,                     @fPvp        OUTPUT
   ,                     @fMt         OUTPUT
   ,                     @fMtum       OUTPUT
   ,                     @fMt_cien    OUTPUT
   ,                     @fVan        OUTPUT
   ,                     @fVpar       OUTPUT
   ,                     @nNumucup    OUTPUT
   ,                     @dFecucup    OUTPUT
   ,                     @fIntucup    OUTPUT
   ,                     @fAmoucup    OUTPUT
   ,                     @fSalucup    OUTPUT
   ,                     @nNumpcup    OUTPUT
   ,                     @dFecpcup    OUTPUT
   ,                     @fIntpcup    OUTPUT
   ,                     @fAmopcup    OUTPUT
   ,                     @fSalpcup    OUTPUT
   ,                     @fDurat      OUTPUT
   ,                     @fConvx      OUTPUT
   ,                     @fDurmo      OUTPUT

   SELECT @Mon_VpresPe   = ISNULL(@fMt,0)     -- Valor fecha proc. a tasa pactada
   SELECT @ValUmTasaPact = ISNULL(@fMtum,4)   -- Valor fecha proc  a tasa pactada en UM

   EXECUTE @nError     = @Valorizador
                         2                   -- @iModcal
   ,                     @Fec_Calc           -- @dFeccal
   ,                     @Cod_inst           -- @iCodigo
   ,                     @Ser_Inst           -- @cInstser
   ,                     @Mon_Emis           -- @iMonemi
   ,                     @Fec_Emis           -- @dFecemi
   ,                     @Fec_Vcto           -- @dFecven
   ,                     @Tas_Emis           -- @fTasemi
   ,                     @Bas_Emis           -- @fBasemi
   ,                     @Tas_Est            -- @fTasest
   ,                     @Mon_Nominal OUTPUT -- @fNominal OUTPUT
   ,                     @Tir_Benchmarck OUTPUT -- @Tir_Mercado OUTPUT -- @fTir     OUTPUT
   ,                     @fPvp        OUTPUT
   ,                     @fMt         OUTPUT
   ,                     @fMtum       OUTPUT
   ,                     @fMt_cien    OUTPUT
   ,                     @fVan        OUTPUT
   ,                     @fVpar       OUTPUT
   ,                     @nNumucup    OUTPUT
   ,                     @dFecucup    OUTPUT
   ,                     @fIntucup    OUTPUT
   ,                     @fAmoucup    OUTPUT
   ,                     @fSalucup    OUTPUT
   ,                     @nNumpcup    OUTPUT
   ,                     @dFecpcup    OUTPUT
   ,                     @fIntpcup    OUTPUT
   ,                     @fAmopcup    OUTPUT
   ,                     @fSalpcup    OUTPUT
   ,                     @fDurat      OUTPUT
   ,                     @fConvx      OUTPUT
   ,                     @fDurmo      OUTPUT


   --> ********************************************
   --> Tasa Forward Teorica
   DECLARE @Error             INT
   ,       @iTasaFwdTeorica   NUMERIC(21,4)

   EXECUTE @Error           =  SP_TASAFORWARDTEORICA @dFechaProceso
                                                  , @dFechaVctoIns
                                                  , @Fec_Vcto
                                                  , @Tir_Benchmarck
                                                  , @fDurat
                                                  , @iTasaFwdTeorica OUTPUT
   IF @Error < 0.0 AND @Error <> -4
   BEGIN
      RAISERROR(15007,-1,-1,'Error al Detrminar Tasa Forward Teorica.')
      RETURN @Error
   END

   EXECUTE @nError     = @Valorizador
                         2                   -- @iModcal
   ,   @Fec_Calc     -- @dFeccal
   ,                     @Cod_inst           -- @iCodigo
   ,                     @Ser_Inst           -- @cInstser
   ,                     @Mon_Emis           -- @iMonemi
   ,                     @Fec_Emis           -- @dFecemi
   ,                     @Fec_Vcto           -- @dFecven
   ,                     @Tas_Emis           -- @fTasemi
   ,                     @Bas_Emis           -- @fBasemi
   ,                     @Tas_Est            -- @fTasest
   ,                     @Mon_Nominal     OUTPUT -- @fNominal OUTPUT
   ,                     @iTasaFwdTeorica OUTPUT -- @Tir_Mercado OUTPUT -- @fTir     OUTPUT
   ,                     @fPvp        OUTPUT
   ,                     @fMt         OUTPUT
   ,                     @fMtum       OUTPUT
   ,                     @fMt_cien    OUTPUT
   ,                     @fVan        OUTPUT
   ,                     @fVpar       OUTPUT
   ,                     @nNumucup    OUTPUT
   ,                     @dFecucup    OUTPUT
   ,                     @fIntucup    OUTPUT
   ,                     @fAmoucup    OUTPUT
   ,                     @fSalucup    OUTPUT
   ,                     @nNumpcup    OUTPUT
   ,                     @dFecpcup    OUTPUT
   ,                     @fIntpcup    OUTPUT
   ,                     @fAmopcup    OUTPUT
   ,                     @fSalpcup    OUTPUT
   ,                     @fDurat      OUTPUT
   ,                     @fConvx      OUTPUT
   ,                     @fDurmo      OUTPUT

   SELECT @Mon_VMercado    = ISNULL(@fMt,0)
   SELECT @ValUmTasaCurv   = ISNULL(@fMtum,0)

   IF @TipoOper = 'C'
   BEGIN
      SELECT @VariacionDia = ISNULL((@Mon_VMercado  - @Mon_VpresPe  ),0)
      SELECT @ValDifUm     = ISNULL((@ValUmTasaCurv - @ValUmTasaPact),0)
   END ELSE
   BEGIN
      SELECT @VariacionDia = ISNULL((@Mon_VpresPe   - @Mon_VMercado ),0)
      SELECT @ValDifUm     = ISNULL((@ValUmTasaPact - @ValUmTasaCurv),0)
   END

   --> Obtener Tasas por Moneda para la Conversionn de Valores en UM a CLP
   SELECT  @iBaseLocal      = 30.0  -- Base Moneda Local
   SELECT  @iValorMonedaEmi = 1.0

   SELECT  @iValorMonedaEmi = vmvalor
   FROM    bacparamsuda..VALOR_MONEDA 
   WHERE   vmfecha          = CASE WHEN @Mon_Emis <> 998 THEN @dFechaProceso ELSE @FechaCalculos END
   AND     vmcodigo         = CASE WHEN @Mon_Emis =  13  THEN 994            ELSE @Mon_Emis      END

   SELECT  @iTasaMonedaE    = @Tir_Mercado
   DELETE  #TasaMoneda

   INSERT INTO #TasaMoneda
   EXECUTE SP_RetornaTasaMoneda 999 , @Plazo

   SELECT  @iTasaMonedaL    = Tasa 
   FROM    #TasaMoneda

   SELECT  @iValorMonedaEmi = @iValorMonedaEmi * ( 1.0 +  @iTasaMonedaL * @Plazo / (@iBaseLocal * 1.0) / 100.0 ) 
                            / ( 1.0 + @iTasaMonedaE * @Plazo / (@Bas_Emis * 1.0 ) / 100.0 )   

   -- Decimales para redondear la moneda 
   SELECT @imndecimal      = mndecimal 
   FROM   BacParamSuda..MONEDA 
   WHERE  mncodmon         = @Mon_Emis

   SELECT @iValorMonedaEmi = ROUND(@iValorMonedaEmi, @imndecimal )
   SELECT @ValUmTasaCurv   = ROUND(@ValUmTasaCurv,   @imndecimal )
   SELECT @ValUmTasaPact   = ROUND(@ValUmTasaPact,   @imndecimal )

   SELECT @mtm_hoy_moneda1 = ROUND(CASE WHEN @TipoOper = 'C' THEN (@ValUmTasaCurv * @iValorMonedaEmi) --> Tasa Fwd Teorica
                                        ELSE                      (@ValUmTasaPact * @iValorMonedaEmi)
                                   END,0)
   SELECT @mtm_hoy_moneda2 = ROUND(CASE WHEN @TipoOper = 'C' THEN (@ValUmTasaPact * @iValorMonedaEmi)
                                        ELSE                      (@ValUmTasaCurv * @iValorMonedaEmi)
                                   END,0)




   -- ******************************************* --
 EXECUTE @nError     = @Valorizador
                         2                   -- @iModcal
   ,                     @dFechaProceso      -- @Fec_Calc           -- @dFeccal
,  @Cod_inst           -- @iCodigo
   ,                     @Ser_Inst           -- @cInstser
   ,                     @Mon_Emis           -- @iMonemi
   ,                     @Fec_Emis           -- @dFecemi
   ,                     @Fec_Vcto           -- @dFecven
   ,                     @Tas_Emis           -- @fTasemi
   ,                     @Bas_Emis           -- @fBasemi
   ,                     @Tas_Est            -- @fTasest
   ,                     @Mon_Nominal OUTPUT -- @fNominal OUTPUT
   ,                     @Tir_Forward OUTPUT -- @fTir     OUTPUT
   ,                     @fPvp        OUTPUT
   ,                     @fMt    OUTPUT
   ,                     @fMtum       OUTPUT
   ,                     @fMt_cien    OUTPUT
   ,                     @fVan        OUTPUT
   ,                     @fVpar       OUTPUT
   ,                     @nNumucup  OUTPUT
   ,                     @dFecucup    OUTPUT
   ,                     @fIntucup    OUTPUT
   ,                     @fAmoucup    OUTPUT
   ,                     @fSalucup    OUTPUT
   ,                     @nNumpcup    OUTPUT
   ,                     @dFecpcup    OUTPUT
   ,                     @fIntpcup    OUTPUT
   ,                     @fAmopcup    OUTPUT
   ,                     @fSalpcup    OUTPUT
   ,                     @fDurat      OUTPUT
   ,                     @fConvx      OUTPUT
   ,                     @fDurmo      OUTPUT

   SELECT @Mon_VpresPe   = ISNULL(@fMt,0)
   SELECT @ValUmTasaPact = ISNULL(@fMtum,4)

   EXECUTE @nError     = @Valorizador
                         2                   -- @iModcal
   ,                     @dFechaProceso      -- @Fec_Calc           -- @dFeccal
   ,                     @Cod_inst           -- @iCodigo
   ,                     @Ser_Inst           -- @cInstser
   ,                     @Mon_Emis           -- @iMonemi
   ,                     @Fec_Emis           -- @dFecemi
   ,                     @Fec_Vcto           -- @dFecven
   ,                     @Tas_Emis           -- @fTasemi
   ,                     @Bas_Emis           -- @fBasemi
   ,                     @Tas_Est            -- @fTasest
   ,                     @Mon_Nominal    OUTPUT -- @fNominal OUTPUT
   ,                     @Tir_Benchmarck OUTPUT -- @fTir     OUTPUT
   ,                     @fPvp           OUTPUT
   ,                     @fMt            OUTPUT
   ,                     @fMtum          OUTPUT
   ,                     @fMt_cien       OUTPUT
   ,                     @fVan           OUTPUT
   ,                     @fVpar          OUTPUT
   ,                     @nNumucup       OUTPUT
   ,                     @dFecucup       OUTPUT
   ,                     @fIntucup       OUTPUT
   ,                     @fAmoucup       OUTPUT
   ,                     @fSalucup       OUTPUT
   ,                     @nNumpcup       OUTPUT
   ,                     @dFecpcup       OUTPUT
   ,                     @fIntpcup       OUTPUT
   ,                     @fAmopcup       OUTPUT
   ,                     @fSalpcup       OUTPUT
   ,                     @fDurat         OUTPUT
   ,                     @fConvx         OUTPUT
   ,                     @fDurmo         OUTPUT

   --> ********************************************
   --> Tasa Forward Teorica
   EXECUTE @Error           = SP_TASAFORWARDTEORICA @dFechaProceso
                                                  , @dFechaVctoIns
                                                  , @Fec_Vcto
                                                  , @Tir_Benchmarck
                                                  , @fDurat
                                                  , @iTasaFwdTeorica OUTPUT
   IF @Error < 0.0 AND @Error <> -4
   BEGIN
      RAISERROR(15007,-1,-1,'Error al Detrminar Tasa Forward Teorica.')
      RETURN @Error
   END
   EXECUTE @nError     = @Valorizador
                         2                   -- @iModcal
   ,      @dFechaProceso      -- @Fec_Calc         -- @dFeccal
   ,                     @Cod_inst           -- @iCodigo
   ,                     @Ser_Inst           -- @cInstser
   ,                     @Mon_Emis           -- @iMonemi
   ,                     @Fec_Emis           -- @dFecemi
   ,                     @Fec_Vcto           -- @dFecven
   ,                     @Tas_Emis           -- @fTasemi
   ,                     @Bas_Emis           -- @fBasemi
   ,                     @Tas_Est            -- @fTasest
   ,                     @Mon_Nominal     OUTPUT -- @fNominal OUTPUT
   ,                     @iTasaFwdTeorica OUTPUT -- @fTir OUTPUT
   ,                     @fPvp            OUTPUT
   ,                     @fMt             OUTPUT
   ,                     @fMtum           OUTPUT
   ,                     @fMt_cien        OUTPUT
   ,                     @fVan            OUTPUT
   ,                     @fVpar           OUTPUT
   ,                     @nNumucup        OUTPUT
   ,                     @dFecucup        OUTPUT
   ,                     @fIntucup        OUTPUT
   ,                     @fAmoucup        OUTPUT
   ,                     @fSalucup        OUTPUT
   ,                     @nNumpcup        OUTPUT
   ,                     @dFecpcup        OUTPUT
   ,                     @fIntpcup        OUTPUT
   ,                     @fAmopcup        OUTPUT
   ,                     @fSalpcup        OUTPUT
   ,                     @fDurat          OUTPUT
   ,                     @fConvx          OUTPUT
   ,                     @fDurmo          OUTPUT
   --> ********************************************


   SELECT @Mon_VMercado  = ISNULL(@fMt,0)
   SELECT @ValUmTasaCurv = ISNULL(@fMtum,0)
   -- ******************************************* --

   IF @TipoOper = 'C'
   BEGIN
      SELECT @VariacionDia = ISNULL((@Mon_VMercado  - @Mon_VpresPe  ),0)
      SELECT @ValDifUm     = ISNULL((@ValUmTasaCurv - @ValUmTasaPact),0)
   END ELSE
   BEGIN
      SELECT @VariacionDia = ISNULL((@Mon_VpresPe   - @Mon_VMercado ),0)
      SELECT @ValDifUm     = ISNULL((@ValUmTasaPact - @ValUmTasaCurv),0)
   END

   -- Se vuelve a recuperar el valor de la moneda de emision
   SELECT  @iValorMonedaEmi = vmvalor
   FROM    bacparamsuda..VALOR_MONEDA
   WHERE   vmfecha          = CASE WHEN @Mon_Emis <> 998 THEN @dFechaProceso ELSE @FechaCalculos END
   AND     vmcodigo         = CASE WHEN @Mon_Emis  =  13 THEN 994            ELSE @Mon_Emis      END

  
   SELECT @ValorRazonableActivo = CASE WHEN @TipoOper = 'C' THEN (@ValUmTasaCurv * @iValorMonedaEmi) -- (@ValUmTasaCurv / ( 1 + @iTasaMonedaE * @Plazo / 100 / @Bas_Emis))
                                       ELSE                      (@ValUmTasaPact * @iValorMonedaEmi) -- (@ValUmTasaPact / ( 1 + @iTasaMonedaE * @Plazo / 100 / @Bas_Emis)) 
                                  END
   SELECT @ValorRazonablePasivo = CASE WHEN @TipoOper = 'C' THEN (@ValUmTasaPact * @iValorMonedaEmi) -- (@ValUmTasaPact / ( 1 + @iTasaMonedaE * @Plazo / 100 / @Bas_Emis))
                                       ELSE                      (@ValUmTasaCurv * @iValorMonedaEmi) -- (@ValUmTasaCurv / ( 1 + @iTasaMonedaE * @Plazo / 100 / @Bas_Emis))
                                  END


   SET	@fResObtenido      =(@ValorRazonableActivo - @ValorRazonablePasivo) 
   SET  @fTirBenchmarck    = @Tir_Benchmarck    

   IF @nFlag = 1
	   SELECT (@ValorRazonableActivo - @ValorRazonablePasivo) ,  @Tir_Benchmarck

END

GO
