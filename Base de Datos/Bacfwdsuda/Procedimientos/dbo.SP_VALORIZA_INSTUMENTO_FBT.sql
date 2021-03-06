USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORIZA_INSTUMENTO_FBT]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_VALORIZA_INSTUMENTO_FBT]
(   @Fec_Calc  DATETIME
,   @iNumOpe   NUMERIC(9)
,   @iTasFwd   FLOAT
,   @iTasMerc  FLOAT
,   @vPres     FLOAT OUTPUT
,   @vMerc     FLOAT OUTPUT
,   @vDif      FLOAT OUTPUT
)
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @fTe_pcdus       FLOAT
   ,       @fTe_pcduf       FLOAT
   ,       @fTe_ptf         FLOAT
   DECLARE @ValorMoneda_Hoy FLOAT
   ,       @ValorMoneda_Mañ FLOAT
   DECLARE @Valorizador     VARCHAR(50)
   ,       @nError          INT
   ,       @Mon_inst        NUMERIC(9)
   ,       @Mon_pago        NUMERIC(9)
   ,       @Fec_inic        DATETIME
   ,       @Fec_Vcto        DATETIME
   ,       @Mon_Nominal     NUMERIC(21,4)
   ,       @Mon_VpresPe     NUMERIC(21,0)
   ,       @Mon_VPresUm     NUMERIC(21,4)
   ,       @Mon_VMercado    NUMERIC(21,0)
   ,       @Tir_Forward     NUMERIC(21,4)
   ,       @Tir_Mercado     NUMERIC(21,4)
   ,       @Seriedo         CHAR(1)
   ,       @Cod_inst        NUMERIC(9)
   ,       @Ser_Inst        VARCHAR(20)
   ,       @Fec_Emis        DATETIME
   ,       @Tas_Emis        NUMERIC(21,4)
   ,       @Bas_Emis        NUMERIC(9)
   ,       @Mon_Emis        NUMERIC(9)
   ,       @Tas_Est         NUMERIC(21,4)
   ,       @Fec_UltDev      DATETIME
   ,       @fPvp            FLOAT
   ,       @fMt             FLOAT
   ,       @fMtum           FLOAT
   ,       @fMt_cien        FLOAT
   ,       @fVan            FLOAT
   ,       @fVpar           FLOAT
   ,       @nNumucup        INT
   ,       @dFecucup        DATETIME
   ,       @fIntucup        FLOAT
   ,       @fAmoucup        FLOAT
   ,       @fSalucup        FLOAT
   ,       @nNumpcup        INT
   ,       @dFecpcup        DATETIME
   ,       @fIntpcup        FLOAT
   ,       @fAmopcup        FLOAT
   ,       @fSalpcup        FLOAT
   ,       @fDurat          FLOAT
   ,       @fConvx          FLOAT
   ,       @fDurmo          FLOAT
   ,       @TipoOper        char(1)
   ,       @BenchMarck      CHAR(1)
   ,       @iCalculaVAyer   INT
   ,       @ReajusteDia     NUMERIC(21,4)
   ,       @ReajusteAcum    NUMERIC(21,4)
   ,       @VariacionDia    NUMERIC(21,4)
   ,       @VariacionAcum   NUMERIC(21,4)
   ,       @dFechaVctoIns   DATETIME

   SELECT  @vPres           = 0.0
   ,       @vMerc           = 0.0
   ,       @vDif            = 0.0
   SELECT  @fTe_pcdus       = 0.0
   ,       @fTe_pcduf       = 0.0
   ,       @fTe_ptf         = 0.0
   SELECT  @ValorMoneda_Hoy = 0.0
   ,       @ValorMoneda_Mañ = 0.0

   SELECT @fTe_pcdus        = ISNULL(vmvalor,0.0)
   FROM   bacparamsuda..VALOR_MONEDA
   WHERE  vmcodigo          = 300 
   AND    vmfecha           = @Fec_Calc

   SELECT @fTe_pcduf        = ISNULL(vmvalor,0.0)
   FROM   bacparamsuda..VALOR_MONEDA
   WHERE  vmcodigo          = 301
   AND    vmfecha           = @Fec_Calc

   SELECT @fTe_ptf          = ISNULL(vmvalor,0.0)
   FROM   bacparamsuda..VALOR_MONEDA 
   WHERE  vmcodigo          = 302
   AND    vmfecha           = @Fec_Calc


   -- Forward Bond Trades --
   SELECT  @Mon_inst      = cacodmon1
   ,       @Mon_pago      = cacodmon2
   ,       @Fec_inic      = cafecha
   ,       @Fec_Vcto      = cafecvcto
   ,       @Mon_Nominal   = camtomon1
   ,       @Mon_VpresPe   = caequmon1
   ,       @Mon_VPresUm   = camtomon2
   ,       @Mon_VMercado  = caequusd2
   ,       @Tir_Forward   = @iTasFwd  -- catipcam
   ,       @Tir_Mercado   = @iTasMerc -- capremon1
   ,       @Seriedo       = caseriado
   ,       @Ser_Inst      = caserie
   ,       @Cod_inst      = cabroker
   ,       @Tas_Est       = 0
   ,       @Fec_UltDev    = fechaemision  
   ,       @ReajusteAcum  = pesos_devengo_acum_cnv
   ,       @VariacionAcum = pesos_devengo_acum_usd
   ,       @ReajusteDia   = 0.0
   ,       @VariacionDia  = 0
   ,       @TipoOper      = catipoper
   ,       @BenchMarck    = '*'
   FROM    MFCA
   WHERE   canumoper      = @iNumOpe

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
                                ELSE               CONVERT(FLOAT,0)
                           END
      END

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

      SELECT @Mon_VpresPe = ISNULL(@fMt,0)

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
      ,                     @Tir_Mercado OUTPUT -- @fTir     OUTPUT
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

      SELECT @Mon_VMercado = ISNULL(@fMt,0)
      SELECT @VariacionDia = ISNULL((@Mon_VpresPe - @Mon_VMercado),0)

      if @TipoOper = 'C'
      begin
         SELECT @VariacionDia = ISNULL((@Mon_VMercado  - @Mon_VpresPe),0)
      end else
      begin
         SELECT @VariacionDia = ISNULL((@Mon_VpresPe   - @Mon_VMercado),0)
      end

      SELECT @vPres  = @Mon_VpresPe
      ,      @vMerc  = @Mon_VMercado
      ,      @vDif   = @VariacionDia

   END


END

GO
