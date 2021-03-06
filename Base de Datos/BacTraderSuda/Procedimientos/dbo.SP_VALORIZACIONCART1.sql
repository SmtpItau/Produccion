USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORIZACIONCART1]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALORIZACIONCART1]
   (   @dFecpro        DATETIME
   ,   @Serie          CHAR(12)
   ,   @Emisor         CHAR(10)
   ,   @TipoValoriza   CHAR(02)= ''

   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @cProg	      CHAR(10)
   DECLARE @cInstser	      CHAR(10)
   DECLARE @cMascara	      CHAR(10)
   DECLARE @cSeriado	      CHAR(01)
   DECLARE @cCartSbif	      CHAR(01)
   DECLARE @tipoper	      CHAR(03)
   DECLARE @fTasemi	      FLOAT
   DECLARE @fBasemi	      FLOAT
   DECLARE @fTasest	      FLOAT
   DECLARE @fNominal	      FLOAT
   DECLARE @fTir	      FLOAT
   DECLARE @fPvp	      FLOAT
   DECLARE @fMT		      FLOAT
   DECLARE @fMTUM	      FLOAT
   DECLARE @fMT_cien          FLOAT
   DECLARE @fVan	      FLOAT
   DECLARE @fVpar	      FLOAT
   DECLARE @fIntucup	      FLOAT
   DECLARE @fAmoucup	      FLOAT
   DECLARE @fSalucup	      FLOAT
   DECLARE @fIntpcup	      FLOAT
   DECLARE @fAmopcup	      FLOAT
   DECLARE @fSalpcup	      FLOAT
   DECLARE @fDurat	      FLOAT
   DECLARE @fConvx	      FLOAT
   DECLARE @fDurmo	      FLOAT
   DECLARE @fTe_pcdus	      FLOAT
   DECLARE @fTe_pcduf	      FLOAT
   DECLARE @fTe_ptf	      FLOAT
   DECLARE @fTasaMercado      FLOAT
   DECLARE @fTasaMark	      FLOAT
   DECLARE @fTasaMark1	      FLOAT
   DECLARE @fTasaMark2	      FLOAT
   DECLARE @nRutcart	      NUMERIC(09,0)
   DECLARE @nRutemi	      NUMERIC(09,0)
   DECLARE @nNumdocu	      NUMERIC(10,0)
   DECLARE @nNumoper	      NUMERIC(10,0)
   DECLARE @nCorrela	      NUMERIC(03,0)
   DECLARE @nVpresen	      NUMERIC(19,4)
   DECLARE @nValMercado	      NUMERIC(19,4)
   DECLARE @nValMark	      NUMERIC(19,4)
   DECLARE @nValMark1	      NUMERIC(19,4)
   DECLARE @nValMark2	      NUMERIC(19,4)
   DECLARE @nDifValMerc	      NUMERIC(19,4)
   DECLARE @dDifTasMark	      NUMERIC(19,4)
   DECLARE @dDifTasMark1      NUMERIC(19,4)
   DECLARE @dDifTasMark2      NUMERIC(19,4)
   DECLARE @iModcal	      INTEGER
   DECLARE @nCodigo	      INTEGER
   DECLARE @nNumucup	      INTEGER
   DECLARE @nNumpcup          INTEGER
   DECLARE @nError	      INTEGER
   DECLARE @nMonemi	      INTEGER
   DECLARE @acfecproc	      DATETIME
   DECLARE @acfecprox	      DATETIME
   DECLARE @dFecemi	      DATETIME
   DECLARE @dFecven	      DATETIME
   DECLARE @dFecpcup	      DATETIME
   DECLARE @dFecucup	      DATETIME
   DECLARE @dfecfmes	      DATETIME
   DECLARE @dfec_mdrs	      DATETIME
   DECLARE @dFecFMesProx      DATETIME
   DECLARE @ix		      INTEGER
   DECLARE @nContador	      INTEGER
   DECLARE @dFechaProcVal     DATETIME

   IF @TipoValoriza = '' 
   BEGIN -- VALORIZACION NORMAL
      UPDATE MDCP SET cpcontador = 0 
   END

   SELECT  @acfecproc = acfecproc
   ,	   @acfecprox = acfecprox
   FROM	   MDAC

   SELECT @dfecfmes     = DATEADD(DAY,DATEPART(DAY,@acfecprox) * -1,@acfecprox)		     -- Primer dia del mes siguiente
   SELECT @dFecFMesProx = DATEADD( MONTH, 1, @acfecprox )				     -- Suma 1 mes a la fecha proxima que deberia ser el primer dia habil del mes siguiente
   SELECT @dFecFMesProx = DATEADD( DAY, DATEPART( DAY, @dFecFMesProx ) * -1, @dFecFMesProx ) -- fin de mes siguiente
		
   IF @acfecproc = @dFecpro OR ( DATEPART(MONTH,@acfecproc) <> DATEPART(MONTH,@acfecprox) AND @dfecfmes = @dFecpro ) 
   BEGIN
CREATE TABLE #TMP_CARTCP	
      (   cpinstser		CHAR(12)
      ,   cptircomp		NUMERIC(19,4)
      ,   cpcodigo		NUMERIC(05,0)
      ,   cpfecemi		DATETIME
      ,   cpfecven		DATETIME 
      ,   cptasest		FLOAT
      ,   cpnominal		NUMERIC(19,4)
      ,   tmrutemis		NUMERIC(09,0)
      ,   tasa_mercado		NUMERIC(08,4)
      ,   tasa_market		NUMERIC(08,4)
      ,   tasa_market1		NUMERIC(08,4)
      ,   tasa_market2		NUMERIC(08,4)
      ,   cpvptirc		NUMERIC(19,4)
      ,   cpfecucup		DATETIME
      ,   cpfecpcup		DATETIME
      ,   cpseriado		CHAR(01)
      ,   cprutcart		NUMERIC(09,0)
      ,   cpnumdocu		NUMERIC(10,0)
      ,   cpcorrela		NUMERIC(03,0)
      ,   codigo_carterasuper	CHAR(10)
      ,   cpmascara		CHAR(12)
      ,   sw			CHAR(01)
      ,   FPagoMañana           DATETIME
      )
					
CREATE TABLE #TMP_CARTVI	
      (   viinstser		CHAR(12)
      ,   vicodigo		NUMERIC(05,0)
      ,   vifecemi		DATETIME
      ,   vifecven		DATETIME 
      ,   vitasest		FLOAT
      ,   vinominal		NUMERIC(19,4)
      ,   vitircomp		NUMERIC(19,4)
      ,   tmrutemis		NUMERIC(09,0)
      ,   tasa_mercado		NUMERIC(08,4)
      ,   tasa_market		NUMERIC(08,4)
      ,   tasa_market1		NUMERIC(08,4)
      ,   tasa_market2		NUMERIC(08,4)
      ,   vivptirc		NUMERIC(19,4)
      ,   vifecucup		DATETIME
      ,   vifecpcup		DATETIME
      ,   viseriado		CHAR(01)
      ,   virutcart		NUMERIC(09,0)
      ,   vinumdocu		NUMERIC(10,0)
      ,   vinumoper		NUMERIC(10,0)
      ,   vicorrela		NUMERIC(03,0)
      ,   codigo_carterasuper	CHAR(10)
      ,   vimascara		CHAR(12)
      ,   sw			CHAR(01)
      ,   FPagoMañana           DATETIME
      )

      SET @dfec_mdrs = @acfecprox


      IF DATEPART(MONTH,@acfecproc) <> DATEPART(MONTH,@acfecprox)
         SELECT @dfec_mdrs = @dfecfmes

      IF @TipoValoriza = ''
      BEGIN --> VALORIZACION NORMAL
         DELETE	VALORIZACION_MERCADO 
         FROM   VIEW_EMISOR
         WHERE  fecha_valorizacion = @dFecpro 
         AND	id_sistema	   = 'BTR'
         AND	rminstser	   = @Serie
         AND	emrut		   = rut_emisor
         AND	emgeneric	   = @Emisor


         -- Cuenta los registros de la tabla MDCP CARTERA
         INSERT INTO #TMP_CARTCP		
         SELECT 'cpinstser'           = cpinstser
         ,      'cptircomp'           = cptircomp
         ,      'cpcodigo'            = cpcodigo
         ,      'cpfecemi'            = cpfecemi
         ,      'cpfecven'            = cpfecven
         ,      'cptasest'            = CONVERT(FLOAT,0.0)
         ,      'cpnominal'           = cpnominal+ ISNULL(vinominal,0)
         ,      'tmrutemis'           = tmrutemis
         ,      'tasa_mercado'        = tasa_mercado
         ,      'tasa_market'         = tasa_market
         ,      'tasa_market1'        = tasa_market1
         ,      'tasa_market2'        = tasa_market2
         ,      'cpvptirc'            = cpvptirc+ ISNULL(vivptirc,0)
         ,      'cpfecucup'           = cpfecucup
         ,      'cpfecpcup'           = cpfecpcup
         ,      'cpseriado'           = cpseriado
         ,      'cprutcart'           = cprutcart
         ,      'cpnumdocu'           = cpnumdocu
         ,      'cpcorrela'           = cpcorrela
         ,      'codigo_carterasuper' = mdcp.codigo_carterasuper
         ,      'cpmascara'           = cpmascara
         ,      'sw'                  = 'N'
         ,      'FPagoMañana'         = CASE WHEN MDCP.Fecha_PagoMañana > @dFecpro THEN MDCP.Fecha_PagoMañana ELSE @dFecpro END
         FROM	MDCP left join  MDVI on vinumdocu=cpnumdocu AND  vicorrela=cpcorrela AND vitipoper='CP'
         ,      MDDI
         ,      TASA_MERCADO 
         WHERE  cpnominal             > 0
         AND	fecha_proceso         = @dFecpro
         AND	cpinstser             = tminstser
         AND	cpcodigo             <> 98
         AND	dinumdocu             = cpnumdocu
         AND	dicorrela             = cpcorrela
         AND	tmgenemis             = digenemi
         AND	digenemi              = @Emisor
         AND	diinstser             = @Serie

      END ELSE

      IF @TipoValoriza = 'LT' 
      BEGIN -- VALORIZACION LIBRE DE TRADING	**********************************
         INSERT	INTO #TMP_CARTCP
         SELECT 'cpinstser'          = Clt_Instrum
         ,      'cptircomp'          = Clt_TC_PP_INI
         ,      'cpcodigo'           = Clt_Codigo
         ,      'cpfecemi'           = Clt_FechaIni	
         ,      'cpfecven'           = Clt_FechaFin
         ,      'cptasest'           = CONVERT(FLOAT,0.0)
         ,  'cpnominal'          = Clt_Nominal_MonCont
         ,      'tmrutemis'          = tmrutemis
         ,      'tasa_mercado'  = tasa_mercado
         ,      'tasa_market'        = tasa_market
         ,      'tasa_market1'       = tasa_market1
         ,      'tasa_market2'       = tasa_market2
         ,      'cpvptirc'           = Clt_VPTC_ValAct		
         ,      'cpfecucup'          = Clt_FecUCup
         ,      'cpfecpcup'          = Clt_FecPCup
         ,      'cpseriado'          = Clt_Seriado
         ,      'cprutcart'          = Clt_RutCart
         ,      'cpnumdocu'          = Clt_NumDocu	
         ,      'cpcorrela'          = Clt_NumCorr
         ,      'codigo_carterasuper'= Clt_CarteraSuper	
         ,      'cpmascara'          = Clt_Mascara	
         ,      'sw'                 = 'N'
         ,      'FPagoMañana'        = @dFecpro
         FROM   TBL_CARTERA_LIBRE_TRADING
         ,      TASA_MERCADO 
         WHERE  Clt_FechaProc        = @dFecpro
         AND    Clt_Sistema          = 'BTR'
         AND    Clt_TipOper	     = 'CP'
         AND    Clt_Nominal_MonCont  > 0
         AND    Clt_Codigo          <> 98		
         AND    fecha_proceso	     = Clt_FechaProc
         AND    tminstser	     = Clt_Instrum
         AND    tmgenemis	     = Clt_GenEmi	
         AND    tmcodigo	     = Clt_codigo
         AND    id_sistema	     = Clt_Sistema
         AND    Clt_GenEmi           = @Emisor
         AND    Clt_Instrum          = @Serie
      END



      IF @acfecproc < @dFecpro 
      BEGIN
         UPDATE	#tmp_cartcp
         SET	cpvptirc    = rsvppresenx
         FROM	MDRS
         WHERE	rsfecha     = @dfec_mdrs
         AND	rscodigo   <> 98
         AND	rscartera   = '111'
         AND	rstipoper   = 'DEV'
         AND	rsnumdocu   = cpnumdocu
         AND	rscorrela   = cpcorrela
      END

      WHILE 1 = 1 
      BEGIN

         SET @cInstser = '*'
         SET ROWCOUNT 1

         SELECT @cInstser       = cpinstser
         ,      @fTir		= cptircomp
         ,      @nCodigo	= cpcodigo
         ,      @dFecemi	= cpfecemi
         ,      @dFecven	= cpfecven
         ,      @fTasest	= cptasest
         ,      @fNominal	= cpnominal
         ,      @fTir		= cptircomp
         ,      @nRutemi	= tmrutemis
         ,      @fTasaMercado	= tasa_mercado
         ,      @fTasaMark	= tasa_market
         ,      @fTasaMark1	= tasa_market1
         ,      @fTasaMark2	= tasa_market2
         ,      @nVpresen	= cpvptirc
         ,      @nValMercado	= 0.0
         ,      @nValMark	= 0.0
         ,      @nValMark1	= 0.0
         ,      @nValMark2	= 0.0
         ,      @nDifValMerc	= 0.0
         ,      @dDifTasMark	= 0.0
         ,      @dDifTasMark1	= 0.0
         ,      @dDifTasMark2	= 0.0
         ,      @fMt		= 0.0
         ,      @fMtum		= 0.0
         ,      @fMt_cien	= 0.0
         ,      @fVan		= 0.0
         ,      @fVpar		= 0.0
         ,      @nNumucup	= 0
         ,      @dFecucup	= ISNULL(cpfecucup,'')
         ,      @fIntucup	= 0.0
         ,      @fAmoucup	= 0.0
         ,      @fSalucup	= 0.0
         ,      @nNumpcup	= 0
         ,      @dFecpcup	= ISNULL(cpfecpcup,'')
         ,      @fIntpcup	= 0.0
         ,      @fAmopcup	= 0.0
         ,      @fSalpcup	= 0.0
         ,      @cSeriado	= cpseriado
         ,      @nRutcart	= cprutcart
         ,      @nNumdocu	= cpnumdocu
         ,      @nNumoper	= cpnumdocu
         ,      @nCorrela	= cpcorrela
         ,      @cCartSbif	= codigo_carterasuper
         ,      @cMascara	= cpmascara
         ,      @dFechaProcVal  = FPagoMañana
         FROM   #TMP_CARTCP
         WHERE  sw              = 'N'

         SET ROWCOUNT 0

      
         IF @cInstser = '*'
         BREAK
            IF @cSeriado = 'S' 
            BEGIN
               SELECT @fTasemi = setasemi
               ,      @nMonemi = semonemi
               ,      @fBasemi = sebasemi
      ,      @nRutemi = serutemi
               FROM   VIEW_SERIE
               WHERE  semascara= @cMascara
  END ELSE 
         BEGIN
               SELECT @fTasemi  = nstasemi
               ,      @nMonemi  = nsmonemi
               ,      @fBasemi	= nsbasemi
               ,      @nRutemi	= nsrutemi
               FROM   VIEW_NOSERIE
               WHERE  nsrutcart	= @nRutcart
               AND    nsnumdocu	= @nNumdocu 
               AND    nscorrela	= @nCorrela
            END

            SELECT @cProg   = 'SP_' + inprog 
            FROM   VIEW_INSTRUMENTO 
            WHERE  incodigo = @nCodigo


            IF @cProg <> 'SP_' 
            BEGIN
               SELECT @fTasest = CASE WHEN @nCodigo=1 THEN @fTe_pcdus
                                      WHEN @nCodigo=2 THEN @fTe_pcduf
                                      WHEN @nCodigo=5 THEN @fTe_ptf
                                      ELSE CONVERT(FLOAT,0) 
                                 END


               --** Valorizaci¢n a Tasa de Mercado **--

                                        
               EXECUTE @nError = @cProg 2, /*@dFecpro*/ @dFechaProcVal, @nCodigo, @cInstser, @nMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
                               , @fNominal OUTPUT, @fTasaMercado OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT
                               , @fVan     OUTPUT, @fVpar        OUTPUT, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT
                               , @fSalucup OUTPUT, @nNumpcup     OUTPUT, @dFecpcup OUTPUT, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT
                               , @fDurat   OUTPUT, @fConvx       OUTPUT, @fDurmo   OUTPUT
               --************************************--



               SELECT @nValMercado = @fMt
               SELECT @nDifValMerc = @nValMercado-@nVpresen

               IF @fTasaMark <> 0 
               BEGIN --** Valorizaci¢n a Tasa de Mark to Market **--
                  EXECUTE @nError = @cProg 2, /*@dFecpro*/ @dFechaProcVal, @nCodigo, @cInstser, @nMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
                        , @fNominal OUTPUT, @fTasaMark OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT
                        , @fVan     OUTPUT, @fVpar     OUTPUT, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT
                        , @fSalucup OUTPUT, @nNumpcup  OUTPUT, @dFecpcup OUTPUT, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT
                        , @fDurat   OUTPUT, @fConvx    OUTPUT, @fDurmo   OUTPUT

                  SELECT @nValMark    = @fMt
                  SELECT @dDifTasMark = @nValMark-@nVpresen
               END

               IF @fTasaMark1 <> 0 
               BEGIN --** Valorizaci¢n a Tasa de Mark to Market 1**--
                  EXECUTE @nError = @cProg 2, /*@dFecpro*/ @dFechaProcVal, @nCodigo, @cInstser, @nMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
                        , @fNominal OUTPUT, @fTasaMark1 OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT
                        , @fVan     OUTPUT, @fVpar      OUTPUT, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT
                        , @fSalucup OUTPUT, @nNumpcup   OUTPUT, @dFecpcup OUTPUT, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT
                        , @fDurat   OUTPUT, @fConvx     OUTPUT, @fDurmo   OUTPUT
						
                  SELECT @nValMark1    = @fMt
                  SELECT @dDifTasMark1 = @nValMark1-@nVpresen
               END

               IF @fTasaMark2<>0 
               BEGIN --** Valorizaci¢n a Tasa de Mark to Market 1**--
                  EXECUTE @nError = @cProg 2, /*@dFecpro*/ @dFechaProcVal, @nCodigo, @cInstser, @nMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
          , @fNominal OUTPUT, @fTasaMark2 OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT
         , @fVan     OUTPUT, @fVpar      OUTPUT, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT
                        , @fSalucup OUTPUT, @nNumpcup   OUTPUT, @dFecpcup OUTPUT, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT
                        , @fDurat   OUTPUT, @fConvx     OUTPUT, @fDurmo   OUTPUT

                  SELECT @nValMark2    = @fMt
                  SELECT @dDifTasMark2 = @nValMark2-@nVpresen
               END

               IF @TipoValoriza = '' 
               BEGIN
                  INSERT INTO VALORIZACION_MERCADO
                  (   fecha_valorizacion
                  ,   id_sistema
                  ,   tipo_operacion
                  ,   codigo_carterasuper
                  ,   rmrutcart
                  ,   rmnumdocu
                  ,   rmnumoper
                  ,   rmcorrela
                  ,   rmcodigo
                  ,   rminstser
                  ,   rut_emisor
                  ,   moneda_emision
                  ,   valor_nominal
                  ,   tasa_compra
                  ,   tasa_mercado
                  ,   tasa_market
                  ,   tasa_market1
                  ,   tasa_market2
                  ,   valor_presente
                  ,   valor_mercado
                  ,   valor_market
                  ,   valor_market1
                  ,   valor_market2
                  ,   diferencia_mercado
                  ,   diferencia_market
                  ,   diferencia_market1
                  ,   diferencia_market2
                  ,   tmfecemi
                  ,   tmfecven
                  ,   tmseriado
                  ,   tmmascara
		  ,   Convexidad
		  ,   Duration_Mod
                  )
                  VALUES
                  (   @dFecpro
                  ,   'BTR'
                  ,   'CP'
                  ,   @cCartSbif
                  ,   @nRutcart
                  ,   @nNumdocu
                  ,   @nNumoper
                  ,   @nCorrela
                  ,   @nCodigo
                  ,   @cInstser
                  ,   @nRutemi
                  ,   @nMonemi
                  ,   @fNominal
                  ,   @fTir
                  ,   @fTasaMercado
                  ,   @fTasaMark
                  ,   @fTasaMark1
                  ,   @fTasaMark2
                  ,   @nVpresen
                  ,   @nValMercado
                  ,   @nValMark
                  ,   @nValMark1
                  ,   @nValMark2
                  ,   @nDifValMerc
                  ,   @dDifTasMark
                  ,   @dDifTasMark1
                  ,   @dDifTasMark2
                  ,   @dfecemi
                  ,   @dfecven
                  ,   @cseriado
                  ,   @cmascara
		  ,   @fConvx
		  ,   @fDurmo
                  )
               END ELSE 
               IF @TipoValoriza = 'LT' 
               BEGIN -- VALORIZACION LIBRE DE TRADING
                  UPDATE TBL_CARTERA_LIBRE_TRADING
                  SET    Clt_VPTC_ValAct   = @nVpresen
                  ,      Clt_VPTM_ValAct   = @nValMercado
                  ,      Clt_TC_PP_Ini	   = @fTir
                  ,      Clt_TM_PP_Val	   = @fTasaMercado
                  ,      Clt_Res_VM_VP	   = (@nValMercado - @nVpresen)
                  WHERE	 Clt_FechaProc	   = @dFecpro
                  AND    Clt_Sistema	   = 'BTR'
                  AND    Clt_NumDocu	   = @nNumdocu
                  AND    Clt_NumCorr	   = @nCorrela
                  AND    Clt_NumOper	   = @nNumoper
               END

               UPDATE #tmp_cartcp
               SET    sw = 'S'
               WHERE  @nNumdocu	= cpnumdocu
               AND  @nNumoper	= cpnumdocu
               AND    @nCorrela	= cpcorrela
            END
         END

     IF @TipoValoriza = '' 
         BEGIN
            INSERT INTO #TMP_CARTVI
            SELECT 'viinstser'  = viinstser
            ,      'vicodigo'            = vicodigo
            ,      'vifecemi'            = vifecemi
            ,      'vifecven'            = vifecven
            ,      'vitasest'            = CONVERT(FLOAT,0)
            ,      'vinominal'           = vinominal
            ,      'vitircomp'           = vitircomp
            ,      'tmrutemis'           = tmrutemis
            ,      'tasa_mercado'        = tasa_mercado
            ,      'tasa_market'         = tasa_market
            ,      'tasa_market1'        = tasa_market1
            ,      'tasa_market2'        = tasa_market2
            ,      'vivptirc'            = vivptirc
            ,      'vifecucup'           = vifecucup
            ,      'vifecpcup'           = vifecpcup
            ,      'viseriado'           = viseriado
            ,      'virutcart'           = virutcart
            ,      'vinumdocu'           = vinumdocu
            ,      'vinumoper'           = vinumoper
            ,      'vicorrela'           = vicorrela
            ,      'codigo_carterasuper' = codigo_carterasuper
            ,      'vimascara'           = vimascara
            ,      'sw'                  = 'N'
            ,      'FPagoMañana'         = @dFecpro
            FROM   MDVI
            ,      TASA_MERCADO
            ,      VIEW_EMISOR
            WHERE  fecha_proceso         = @dFecpro
            AND	   viinstser             = tminstser
            AND    vitipoper	         = 'CP'   
            AND    viinstser             = @Serie
            AND    emrut	         = virutemi
            AND    emgeneric	         = @Emisor
         END ELSE 
         IF @TipoValoriza = 'LT' 
         BEGIN -- VALORIZACION LIBRE DE TRADING
            INSERT INTO #TMP_CARTVI						
            SELECT 'viinstser'           = Clt_Instrum
            ,	   'vicodigo'            = Clt_Codigo
            ,	   'vifecemi'            = Clt_FechaIni	
            ,	   'vifecven'            = Clt_FechaFin
            ,	   'vitasest'            = CONVERT(FLOAT,0.0)
            ,	   'vinominal'           = Clt_Nominal_MonCont
            ,	   'vitircomp'           = Clt_TC_PP_INI
            ,	   'tmrutemis'           = tmrutemis
            ,	   'tasa_mercado'        = tasa_mercado
            ,	   'tasa_market'         = tasa_market
            ,	   'tasa_market1'        = tasa_market1
            ,	   'tasa_market2'        = tasa_market2
            ,	   'vivptirc'            = Clt_VPTC_ValAct		
            ,	   'vifecucup'           = Clt_FecUCup
            ,	   'vifecpcup'           = Clt_FecPCup
            ,	   'viseriado'           = Clt_Seriado
            ,	   'virutcart'           = Clt_RutCart
            ,	   'vinumdocu'           = Clt_NumDocu	
            ,	   'vinumoper'           = Clt_NumOper
            ,	   'vicorrela'           = Clt_NumCorr
            ,	   'codigo_carterasuper' = Clt_CarteraSuper	
            ,	   'vimascara'           = Clt_Mascara	
            ,	   'sw'                  = 'N'
            ,      'FPagoMañana'         = @dFecpro
            FROM  TBL_CARTERA_LIBRE_TRADING
            ,	  TASA_MERCADO 
            WHERE Clt_FechaProc	         = @dFecpro
            AND	  Clt_Sistema	         = 'BTR'
            AND	  Clt_TipOper	         = 'VI'
            AND	  Clt_Nominal_MonCont    > 0
            AND	  fecha_proceso	         = Clt_FechaProc
            AND	  tminstser	         = Clt_Instrum
            AND	  tmgenemis	         = Clt_GenEmi	
            AND	  tmcodigo	         = Clt_codigo
            AND	  id_sistema	         = Clt_Sistema
            AND	  Clt_GenEmi             = @Emisor
            AND	  Clt_Instrum            = @Serie
     END			

         IF @acfecproc < @dFecpro 
         BEGIN
            UPDATE #tmp_cartvi
            SET	   vivptirc   = rsvppresenx
            FROM   MDRS
            WHERE  rsfecha    = @dfec_mdrs
            AND	   rscodigo  <> 98
            AND	   rscartera  = '114'
     AND	   rstipoper  = 'DEV'
            AND	   rsnumdocu  = vinumdocu
            AND	   rsnumoper  = vinumoper
            AND	   rscorrela  = vicorrela
         END

         WHILE 1 = 1 
         BEGIN
            SELECT @cInstser = '*'
            SET ROWCOUNT 1

            SELECT @cInstser     = viinstser
            ,      @fTir	 = vitircomp
            ,      @nCodigo	 = vicodigo
            ,      @dFecemi	 = vifecemi
            ,      @dFecven	 = vifecven
            ,      @fTasest	 = vitasest
            ,      @fNominal	 = vinominal
            ,      @fTir	 = vitircomp
            ,      @nRutemi	 = tmrutemis
            ,      @fTasaMercado = tasa_mercado
            ,      @fTasaMark	 = tasa_market
            ,      @fTasaMark1	 = tasa_market1
            ,      @fTasaMark2	 = tasa_market2
            ,      @nVpresen	 = vivptirc
            ,      @nValMercado	 = 0.0
            ,      @nValMark	 = 0.0
            ,      @nValMark1	 = 0.0
            ,      @nValMark2	 = 0.0
            ,      @nDifValMerc	 = 0.0
            ,      @dDifTasMark	 = 0.0
            ,      @dDifTasMark1 = 0.0
            ,      @dDifTasMark2 = 0.0
            ,      @fMt		 = 0.0
            ,      @fMtum	 = 0.0
            ,      @fMt_cien	 = 0.0
            ,      @fVan	 = 0.0
            ,      @fVpar	 = 0.0
            ,      @nNumucup	 = 0
            ,      @dFecucup	 = ISNULL(vifecucup,'')
            ,      @fIntucup	 = 0.0
            ,      @fAmoucup	 = 0.0
            ,      @fSalucup	 = 0.0
            ,      @nNumpcup	 = 0
            ,      @dFecpcup	 = ISNULL(vifecpcup,'')
            ,      @fIntpcup	 = 0.0
            ,      @fAmopcup	 = 0.0
            ,      @fSalpcup	 = 0.0
            ,      @cSeriado	 = viseriado
            ,      @nRutcart	 = virutcart
            ,      @nNumdocu	 = vinumdocu
            ,      @nNumoper	 = vinumoper
            ,      @nCorrela	 = vicorrela
            ,      @cCartSbif	 = codigo_carterasuper
            ,      @cMascara	 = vimascara
            ,      @dFechaProcVal= FPagoMañana
            FROM   #tmp_cartvi
            WHERE  sw           = 'N'

            SET ROWCOUNT 0

            IF @cInstser='*'
            BREAK
               IF @cSeriado = 'S' 
               BEGIN
                  SELECT @fTasemi = setasemi
                  ,      @nMonemi = semonemi
                  ,      @fBasemi = sebasemi
                  ,      @nRutemi = serutemi
                  FROM	 VIEW_SERIE
                  WHERE	 semascara = @cMascara
               END ELSE 
               BEGIN
                  SELECT @fTasemi   = nstasemi	
                  ,      @nMonemi   = nsmonemi	
                  ,      @fBasemi   = nsbasemi	
                  ,      @nRutemi   = nsrutemi
                  FROM	 VIEW_NOSERIE
                  WHERE	 nsrutcart  = @nRutcart
                  AND    nsnumdocu  = @nNumdocu
                  AND    nscorrela  = @nCorrela
               END

               SELECT @cProg   = 'SP_' + inprog
               FROM   VIEW_INSTRUMENTO 
               WHERE  incodigo = @nCodigo

               IF @cProg <> 'SP_' 
               BEGIN
                  SELECT @fTasest = CASE WHEN @nCodigo=1 THEN @fTe_pcdus
                                         WHEN @nCodigo=2 THEN @fTe_pcduf
                                         WHEN @nCodigo=5 THEN @fTe_ptf
                                         ELSE                 CONVERT(FLOAT,0) 
                                    END

                  IF @fTasaMercado > 0 
                  BEGIN --** Valorizaci¢n a Tasa de Mercado **--
                     EXECUTE @nError = @cProg 2, /*@dFecpro*/ @dFechaProcVal, @nCodigo, @cInstser, @nMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
                           , @fNominal OUTPUT, @fTasaMercado OUTPUT, @fPvp    OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT
                           , @fVan     OUTPUT, @fVpar        OUTPUT, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT
                           , @fSalucup OUTPUT, @nNumpcup     OUTPUT, @dFecpcup OUTPUT, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT
                           , @fDurat   OUTPUT, @fConvx       OUTPUT, @fDurmo   OUTPUT
									
                     SELECT @nValMercado = @fMt
                     SELECT @nDifValMerc = @nValMercado-@nVpresen
                  END
                  IF @fTasaMark<>0 
                  BEGIN	--** Valorizaci¢n a Tasa de Mark to Market **--
                     EXECUTE @nError = @cProg 2, /*@dFecpro*/ @dFechaProcVal, @nCodigo, @cInstser, @nMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
                           , @fNominal OUTPUT, @fTasaMark OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT
                           , @fVan     OUTPUT, @fVpar     OUTPUT, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT
                           , @fSalucup OUTPUT, @nNumpcup  OUTPUT, @dFecpcup OUTPUT, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT
                           , @fDurat   OUTPUT, @fConvx    OUTPUT, @fDurmo   OUTPUT
                        --************************************--
                     SELECT @nValMark    = @fMt
                     SELECT @dDifTasMark = @nValMark-@nVpresen
                  END

                  IF @fTasaMark1<>0 
                  BEGIN --** Valorizaci¢n a Tasa de Mark to Market 1**--
                     EXECUTE @nError = @cProg 2, /*@dFecpro*/ @dFechaProcVal, @nCodigo, @cInstser, @nMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
                           , @fNominal OUTPUT, @fTasaMark1 OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT
                           , @fVan     OUTPUT, @fVpar      OUTPUT, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT
                           , @fSalucup OUTPUT, @nNumpcup   OUTPUT, @dFecpcup OUTPUT, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT
                           , @fDurat   OUTPUT, @fConvx     OUTPUT, @fDurmo   OUTPUT

                     SELECT @nValMark1	  = @fMt
                     SELECT @dDifTasMark1 = @nValMark1-@nVpresen
                  END
								
                  IF @fTasaMark2 <> 0 
                  BEGIN	--** Valorizaci¢n a Tasa de Mark to Market 1**--
                     EXECUTE @nError = @cProg 2, /*@dFecpro*/ @dFechaProcVal, @nCodigo, @cInstser, @nMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
                           , @fNominal OUTPUT, @fTasaMark2 OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT
                           , @fVan     OUTPUT, @fVpar      OUTPUT, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT
                           , @fSalucup OUTPUT, @nNumpcup   OUTPUT, @dFecpcup OUTPUT, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT
                           , @fDurat   OUTPUT, @fConvx     OUTPUT, @fDurmo   OUTPUT

                     SELECT @nValMark2	   = @fMt
                     SELECT @dDifTasMark2  = @nValMark2-@nVpresen
                  END

                  IF @TipoValoriza = '' 
                  BEGIN
                     INSERT INTO VALORIZACION_MERCADO 
                     (   fecha_valorizacion
                     ,   id_sistema
                     ,   tipo_operacion
                     ,   codigo_carterasuper
                     ,   rmrutcart
                     ,   rmnumdocu
                     ,   rmnumoper
                     ,   rmcorrela
                     ,   rmcodigo
 ,   rminstser
                     ,   rut_emisor
                     ,   moneda_emision
  ,   valor_nominal
                     ,   tasa_compra
                     ,   tasa_mercado
                     ,   tasa_market
                     ,   tasa_market1
                     ,   tasa_market2
                     ,   valor_presente
                     ,   valor_mercado
                     ,   valor_market
                     ,   valor_market1
                     ,   valor_market2
                     ,   diferencia_mercado
                     ,   diferencia_market
                     ,   diferencia_market1
                     ,   diferencia_market2
                     ,   tmfecemi
                     ,   tmfecven
                     ,   tmseriado
                     ,   tmmascara
		     ,   Convexidad
		     ,   Duration_Mod

                     )
                     VALUES
                     (   @dFecpro
                     ,   'BTR'
                     ,   'VI'
                     ,   @cCartSbif
                     ,   @nRutcart
                     ,   @nNumdocu
                     ,   @nNumoper
                     ,   @nCorrela
                     ,   @nCodigo
                     ,   @cInstser
                     ,   @nRutemi
                     ,   @nMonemi
                     ,   @fNominal
                     ,   @fTir
                     ,   @fTasaMercado
                     ,   @fTasaMark
                     ,   @fTasaMark1
                     ,   @fTasaMark2
                     ,   @nVpresen
                     ,   @nValMercado
                     ,   @nValMark
                     ,   @nValMark1
                     ,   @nValMark2
                     ,   @nDifValMerc
                     ,   @dDifTasMark
                     ,   @dDifTasMark1
                     ,   @dDifTasMark2
                     ,   @dfecemi
                     ,   @dfecven
                     ,   @cseriado
                     ,   @cmascara
		     ,   isnull(@fConvx,0)
		     ,   isnull(@fDurmo,0)

                     )
                  END ELSE 

                  IF @TipoValoriza = 'LT' 
                  BEGIN -- VALORIZACION LIBRE DE TRADING
                     UPDATE TBL_CARTERA_LIBRE_TRADING
                     SET    Clt_VPTC_ValAct = @nVpresen
                     ,      Clt_VPTM_ValAct = @nValMercado
                     ,      Clt_TC_PP_Ini   = @fTir
                     ,      Clt_TM_PP_Val   = @fTasaMercado
                     ,      Clt_Res_VM_VP   = (@nValMercado - @nVpresen)
                     WHERE  Clt_FechaProc   = @dFecpro
                     AND    Clt_Sistema	    = 'BTR'
                     AND    Clt_NumDocu	    = @nNumdocu
                     AND    Clt_NumCorr	    = @nCorrela
                     AND    Clt_NumOper	    = @nNumoper
                  END

                  UPDATE #tmp_cartvi
                  SET    SW        = 'S'
                  WHERE  vinumdocu = @nNumdocu
                  AND    vinumoper = @nNumoper
                  AND    vicorrela = @nCorrela
               END
            END
         END ELSE 
         BEGIN

            IF @TipoValoriza = 'BT' BEGIN
               DECLARE @FechaProxProc   DATETIME

               EXEC Sp_Busca_Fecha_Habil @dFecpro,  1, @FechaProxProc OUTPUT
            END

CREATE TABLE #TMP_CART	
            (   cpinstser            CHAR(12)	        -- 1
            ,   cptircomp            NUMERIC(19,4)	-- 2
            ,   cpcodigo             NUMERIC(05,0)	-- 3 
            ,   cpfecemi             DATETIME	        -- 4
            ,   cpfecven             DATETIME 	        -- 5
            ,   cpnominal            NUMERIC(19,4)	-- 6
            ,   tmrutemis            NUMERIC(09,0)	-- 7
            ,   tasa_mercado         NUMERIC(08,4)	-- 8
            ,   tasa_market          NUMERIC(08,4)	-- 9
      ,   tasa_market1         NUMERIC(08,4)	-- 10
            ,   tasa_market2         NUMERIC(08,4)	-- 11
      ,   cpvptirc             NUMERIC(19,4)	-- 12
            ,   cpseriado            CHAR(01)	        -- 13
            ,   cprutcart            NUMERIC(09,0)	-- 14
            ,   cpnumdocu            NUMERIC(10,0)	-- 15
            ,   numoper              NUMERIC(10,0)	-- 16
            ,   cpcorrela            NUMERIC(03,0)	-- 17
            ,   codigo_carterasuper  CHAR(10)	        -- 18
            ,   cpmascara            CHAR(12)	        -- 19
            ,   tipo_operacion       CHAR(5)		-- 20
            ,   sw                   CHAR(01)	        -- 21
            )

            IF @TipoValoriza = '' 
            BEGIN
               SELECT *
               INTO   #TEMP_VALMERC
               FROM   VALORIZACION_MERCADO
               WHERE  fecha_valorizacion  = @dFecpro
               AND    id_sistema          = 'BTR'
        		  			
               DELETE FROM #TEMP_VALMERC

               -- Aqui Comienza la valorizacion cuando no es la fecha de Proceso del sistema
               INSERT INTO #TMP_CART				
               SELECT rminstser	                -- 1
               ,      tasa_compra               -- 2
               ,      rmcodigo                  -- 3
               ,      tmfecemi                  -- 4 
               ,      tmfecven                  -- 5 
               ,      valor_nominal             -- 6 
               ,      rut_emisor                -- 7 
               ,      TASA_MERCADO.tasa_mercado	-- 8 
               ,      TASA_MERCADO.tasa_market	-- 9 
               ,      TASA_MERCADO.tasa_market1	-- 10 
               ,      TASA_MERCADO.tasa_market2	-- 11 
               ,      valor_presente            -- 12 
               ,      tmseriado                 -- 13 
               ,      rmrutcart                 -- 14 
               ,      rmnumdocu                 -- 15 
               ,      rmnumoper                 -- 16 
               ,      rmcorrela                 -- 17 
               ,      codigo_carterasuper       -- 18 
               ,      tmmascara                 -- 19 
               ,      tipo_operacion            -- 20 
               ,      'N'                       -- 21 
               FROM   VALORIZACION_MERCADO
               ,      TASA_MERCADO
               WHERE  fecha_valorizacion    = @dFecpro 
               AND    rminstser             = tminstser
               AND    fecha_proceso         = @dFecpro 
               AND    tmrutemis             = rut_emisor	
               AND    tminstser             = @Serie
               AND    tmgenemis	            = @Emisor

            END	ELSE 
            IF @TipoValoriza = 'LT' 
            BEGIN -- VALORIZACION LIBRE DE TRADING	**********************************
               INSERT INTO #tmp_cart	
               SELECT 'cpinstser'            = Clt_Instrum         -- 1
               ,      'cptircomp'           = Clt_TC_PP_INI        -- 2
               ,      'cpcodigo'            = Clt_Codigo           -- 3
               ,      'cpfecemi'            = Clt_FechaIni         -- 4
               ,      'cpfecven'            = Clt_FechaFin         -- 5
               ,      'cpnominal'           = Clt_Nominal_MonCont  -- 6
               ,      tmrutemis                                    -- 7
               ,      tasa_mercado                                 -- 8
               ,      tasa_market                                  -- 9
               ,      tasa_market1                                 -- 10
               ,      tasa_market2                                 -- 11
               ,      'cpvptirc'            = Clt_VPTC_ValAct      -- 12
               ,      'cpseriado'           = Clt_Seriado          -- 13
               ,      'cprutcart'           = Clt_RutCart          -- 14
               ,      'cpnumdocu'           = Clt_NumDocu          -- 15
               ,      Clt_NumOper   -- 16
               ,      'cpcorrela'           = Clt_NumCorr          -- 17
               ,      'codigo_carterasuper' = Clt_CarteraSuper	   -- 18
               ,      'cpmascara'           = Clt_Mascara          -- 19
               ,      Clt_TipOper                                  -- 20
               ,      sw                    = 'N'                  -- 21
               FROM  TBL_CARTERA_LIBRE_TRADING
               ,     TASA_MERCADO 
               WHERE Clt_FechaProc	    = @dFecpro
               AND   Clt_Sistema	    = 'BTR'
               AND   Clt_TipOper	    = 'CP'
               AND   Clt_Nominal_MonCont    > 0
               AND   Clt_Codigo            <> 98		
               AND   fecha_proceso          = Clt_FechaProc
               AND   tminstser	            = Clt_Instrum
               AND   tmgenemis	            = Clt_GenEmi	
               AND   tmcodigo	            = Clt_codigo
               AND   id_sistema	            = Clt_Sistema
               AND   Clt_GenEmi             = @Emisor
               AND   Clt_Instrum            = @Serie
            END 
            ELSE IF @TipoValoriza = 'BT' BEGIN -- VALORIZACION LIBRE DE TRADING	**********************************
               INSERT INTO #tmp_cart	
               SELECT rminstser	                -- 1
               ,      tasa_compra               -- 2
               ,      rmcodigo                  -- 3
               ,      tmfecemi                  -- 4 
               ,      tmfecven                  -- 5 
               ,      valor_nominal             -- 6 
               ,      rut_emisor                -- 7 
               ,      TASA_MERCADO.tasa_mercado	-- 8 
               ,      TASA_MERCADO.tasa_market	-- 9 
               ,      TASA_MERCADO.tasa_market1	-- 10 
               ,      TASA_MERCADO.tasa_market2	-- 11
               ,      valor_presente            -- 12
               ,      tmseriado                 -- 13
               ,      rmrutcart                 -- 14
               ,      rmnumdocu                 -- 15
               ,      rmnumoper                 -- 16
               ,      rmcorrela                 -- 17
               ,      codigo_carterasuper       -- 18
               ,      tmmascara                 -- 19
               ,      tipo_operacion            -- 20
               ,      'N'                       -- 21
               FROM   VALORIZACION_MERCADO
               ,      TASA_MERCADO
               WHERE  fecha_valorizacion    = @dFecpro
               AND    rminstser             = tminstser
               AND    fecha_proceso         = CONVERT(CHAR(08),@FechaProxProc,112)
               AND    tmrutemis             = rut_emisor
               AND    tminstser             = @Serie
               AND    tmgenemis	            = @Emisor
            END

            WHILE 1 = 1 
            BEGIN
               SELECT @cInstser	= '*'
               SET ROWCOUNT 1

               SELECT @cInstser	         = cpinstser
               ,      @fTir		 = cptircomp
               ,      @nCodigo	         = cpcodigo
               ,      @dFecemi	         = cpfecemi
               ,      @dFecven	         = cpfecven
               ,      @fTasest	         = 0
               ,      @fNominal	         = cpnominal
               ,      @nRutemi	         = tmrutemis
               ,      @fTasaMercado	 = tasa_mercado
               ,      @fTasaMark	 = tasa_market
               ,      @fTasaMark1	 = tasa_market1
               ,      @fTasaMark2	 = tasa_market2
               ,      @nVpresen	         = cpvptirc
               ,      @nValMercado	 = 0.0
               ,      @nValMark	         = 0.0
               ,      @nValMark1	 = 0.0
               ,      @nValMark2	 = 0.0
               ,      @nDifValMerc	 = 0.0
               ,      @dDifTasMark	 = 0.0
               ,      @dDifTasMark1	 = 0.0
               ,      @dDifTasMark2	 = 0.0
  ,      @fMt		 = 0.0
               ,      @fMtum		 = 0.0
               ,      @fMt_cien	         = 0.0
               ,      @fVan		 = 0.0
               ,      @fVpar		 = 0.0
               ,      @nNumucup	         = 0
               ,      @dFecucup	         = ''
               ,      @fIntucup	         = 0.0
               ,      @fAmoucup	         = 0.0
               ,      @fSalucup	         = 0.0
               ,      @nNumpcup	         = 0
               ,      @dFecpcup	         = ''
               ,      @fIntpcup	         = 0.0
               ,      @fAmopcup	         = 0.0
               ,      @fSalpcup	         = 0.0
               ,      @cSeriado	         = cpseriado
               ,      @nRutcart	         = cprutcart
               ,      @nNumdocu	         = cpnumdocu
               ,      @nNumoper	         = numoper
               ,      @nCorrela          = cpcorrela
               ,      @cCartSbif         = codigo_carterasuper
               ,      @cMascara	         = cpmascara
               ,      @tipoper	         = tipo_operacion
               FROM   #tmp_cart
               WHERE  sw                 = 'N'

               SET ROWCOUNT 0

               IF @cInstser='*'
                  BREAK
						
               IF @cSeriado = 'S' 
               BEGIN
                  SELECT @fTasemi  = setasemi	
                  ,      @nMonemi  = semonemi
                  ,      @fBasemi  = sebasemi
                  ,      @nRutemi  = serutemi
                  FROM   VIEW_SERIE
                  WHERE	 semascara = @cMascara
               END ELSE
               BEGIN
                  SELECT @fTasemi = nstasemi
                  ,      @nMonemi = nsmonemi
                  ,      @fBasemi = nsbasemi
                  ,      @nRutemi = nsrutemi
                  FROM	 VIEW_NOSERIE
                  WHERE	 nsrutcart = @nRutcart 
                  AND    nsnumdocu = @nNumdocu 
                  AND	 nscorrela = @nCorrela
               END

               SELECT @cProg   = 'SP_' + inprog 
               FROM   VIEW_INSTRUMENTO
               WHERE  incodigo = @nCodigo

               IF @cProg <> 'SP_' 
               BEGIN
                  SELECT @fTasest = CASE WHEN @nCodigo = 1 THEN @fTe_pcdus
                                         WHEN @nCodigo = 2 THEN @fTe_pcduf
                                         WHEN @nCodigo = 5 THEN @fTe_ptf
                                         ELSE                 CONVERT(FLOAT,0)
                                    END


                  IF @fTasaMercado > 0 
                  BEGIN --** Valorizaci¢n a Tasa de Mercado **--
                     EXECUTE @nError = @cProg 2, @dFecpro, @nCodigo, @cInstser, @nMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
                           , @fNominal OUTPUT, @fTasaMercado OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT
                           , @fVan     OUTPUT, @fVpar        OUTPUT, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT
                           , @fSalucup OUTPUT, @nNumpcup     OUTPUT, @dFecpcup OUTPUT, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT
                           , @fDurat   OUTPUT, @fConvx       OUTPUT, @fDurmo   OUTPUT

                     SELECT @nValMercado = @fMt
                     SELECT @nDifValMerc = @nValMercado-@nVpresen

                  END

                  IF @fTasaMark <> 0 
                  BEGIN --** Valorizaci¢n a Tasa de Mark to Market **--
                     EXECUTE @nError = @cProg 2, @dFecpro, @nCodigo, @cInstser, @nMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
                           , @fNominal OUTPUT, @fTasaMark OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT
           , @fVan     OUTPUT, @fVpar     OUTPUT, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT
                           , @fSalucup OUTPUT, @nNumpcup  OUTPUT, @dFecpcup OUTPUT, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT
                           , @fDurat   OUTPUT, @fConvx    OUTPUT, @fDurmo OUTPUT

                     SELECT @nValMark      = @fMt
                     SELECT @dDifTasMark   = @nValMark-@nVpresen
                  END

                  IF @fTasaMark1<>0 
                  BEGIN --** Valorizaci¢n a Tasa de Mark to Market 1**--
                     EXECUTE @nError = @cProg 2, @dFecpro, @nCodigo, @cInstser, @nMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
                           , @fNominal OUTPUT, @fTasaMark1 OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT
                           , @fVan     OUTPUT, @fVpar      OUTPUT, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT
                           , @fSalucup OUTPUT, @nNumpcup   OUTPUT, @dFecpcup OUTPUT, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT
                           , @fDurat   OUTPUT, @fConvx     OUTPUT, @fDurmo   OUTPUT

                     SELECT @nValMark1    = @fMt
                     SELECT @dDifTasMark1 = @nValMark1-@nVpresen
                  END

                  IF @fTasaMark2 <> 0 
                  BEGIN --** Valorizaci¢n a Tasa de Mark to Market 1**--
                     EXECUTE @nError = @cProg 2, @dFecpro, @nCodigo, @cInstser, @nMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
                           , @fNominal OUTPUT, @fTasaMark2 OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT
                           , @fVan     OUTPUT, @fVpar      OUTPUT, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT
                           , @fSalucup OUTPUT, @nNumpcup   OUTPUT, @dFecpcup OUTPUT, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT
                           , @fDurat   OUTPUT, @fConvx     OUTPUT, @fDurmo   OUTPUT

                     SELECT @nValMark2	  = @fMt
                     SELECT @dDifTasMark2 = @nValMark2-@nVpresen
                  END

                  IF @TipoValoriza = '' 
                  BEGIN
                     INSERT INTO #TEMP_VALMERC
                     (   fecha_valorizacion
                     ,   id_sistema
                     ,   tipo_operacion
                     ,   codigo_carterasuper
                     ,   rmrutcart
                     ,   rmnumdocu
                     ,   rmnumoper
                     ,   rmcorrela
                     ,   rmcodigo
                     ,   rminstser
                     ,   rut_emisor
                     ,   moneda_emision
                     ,   valor_nominal
                     ,   tasa_compra
                     ,   tasa_mercado
                     ,   tasa_market
                     ,   tasa_market1
                     ,   tasa_market2
                     ,   valor_presente
                     ,   valor_mercado
                     ,   valor_market
                     ,   valor_market1
                     ,   valor_market2
                     ,   diferencia_mercado
                     ,   diferencia_market
                     ,   diferencia_market1
                     ,   diferencia_market2
                     ,   tmfecemi
                     ,   tmfecven
                     ,   tmseriado
                     ,   tmmascara
		     ,   Convexidad
		     ,   Duration_Mod

                     )
                     VALUES
                     (   @dFecpro
                     ,   'BTR'
                     ,   @tipoper
                     ,   @cCartSbif
                     ,   @nRutcart
                     ,   @nNumdocu
                     ,   @nNumoper
                     ,   @nCorrela
                   ,   @nCodigo
                     ,   @cInstser
                     ,   @nRutemi
                     ,   @nMonemi
                     ,   @fNominal
                     ,   @fTir
                     ,   @fTasaMercado
                     ,  @fTasaMark
                     ,   @fTasaMark1
                     ,   @fTasaMark2
                     ,   @nVpresen
                     ,   @nValMercado
                     ,   @nValMark
                     ,   @nValMark1
                     ,   @nValMark2
                     ,   @nDifValMerc
                     ,   @dDifTasMark
                     ,   @dDifTasMark1
                     ,   @dDifTasMark2
                     ,   @dfecemi
                     ,   @dfecven
                     ,   @cseriado
                     ,   @cmascara
		     ,   @fConvx
		     ,   @fDurmo

                     )
                  END ELSE 
                  IF @TipoValoriza = 'LT' 
                  BEGIN -- VALORIZACION LIBRE DE TRADING
                     UPDATE TBL_CARTERA_LIBRE_TRADING
                     SET    Clt_VPTC_ValAct   = @nVpresen
                     ,      Clt_VPTM_ValAct   = @nValMercado
                     ,      Clt_TC_PP_Ini     = @fTir
                     ,      Clt_TM_PP_Val     = @fTasaMercado
                     ,      Clt_Res_VM_VP     = (@nValMercado - @nVpresen)
                     WHERE  Clt_FechaProc     = @dFecpro
                     AND    Clt_Sistema	      = 'BTR'
                     AND    Clt_NumDocu	      = @nNumdocu
                     AND    Clt_NumCorr	      = @nCorrela
                     AND    Clt_NumOper	      = @nNumoper
                  END 
                  ELSE IF @TipoValoriza = 'BT' 
                  BEGIN -- VALORIZACION BACK TEST
                     UPDATE   VALORIZACION_MERCADO
                     SET      ValorMercadoCLPParPrx      = @nValMercado
                     ,        ValorMercadoParPrx         = @nValMercado / CASE WHEN @nMonemi = 999 THEN 1 ELSE ISNULL(vmvalor,1) END
                     FROM   VALORIZACION_MERCADO   LEFT JOIN BACPARAMSUDA..VALOR_MONEDA
                                                   ON     vmFecha              = @dFecpro
                                                   AND    vmCodigo             = @nMonemi
                     WHERE  Fecha_Valorizacion   = @dFecpro
                     AND    id_sistema	         = 'BTR'
                     AND    rmnumdocu	         = @nNumdocu
                     AND    rmcorrela	         = @nCorrela
                     AND    rmnumoper	         = @nNumoper
                     AND    rminstser            = @cInstser

                  END 

                  UPDATE #tmp_cart
                  SET	 sw = 'S'
                  WHERE  @nNumdocu = cpnumdocu
                  AND    @nNumoper	= numoper
                  AND   @nCorrela	= cpcorrela
               END
            END
            IF @TipoValoriza = '' 
            BEGIN
               DELETE VALORIZACION_MERCADO 
               FROM   VIEW_EMISOR
               WHERE  fecha_valorizacion = @dFecpro 
               AND    id_sistema         = 'BTR'
               AND    rminstser          = @Serie
               AND    emrut              = rut_emisor
               AND    emgeneric	         = @Emisor
					
               INSERT INTO VALORIZACION_MERCADO 
               SELECT *  FROM #TEMP_VALMERC
            END

      END
END

-- Sp_ValorizacionCart '20100203', 'DPR-040610', 'CHI'
-- select * from mdcp where cpinstser='DPR-040610'




GO
