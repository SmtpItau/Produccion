USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULOBRSSSSSSSSS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- dbo.Sp_CALCULOBRSSSSSSSSS  '20100308','20100309',0,0,0
CREATE PROCEDURE [dbo].[SP_CALCULOBRSSSSSSSSS] 
   (   @dFechoy        DATETIME
   ,   @dFecprox       DATETIME
   ,   @fTe_pcdus      FLOAT
   ,   @fTe_pcduf      FLOAT
   ,   @fTe_ptf        FLOAT
   ,   @cDevengo_dolar CHAR(01)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @TipDev              CHAR(03)
   DECLARE @cProg               CHAR(10)
   DECLARE @iModcal             INTEGER
   DECLARE @iCodigo             INTEGER
   DECLARE @cInstser            CHAR(10)
   DECLARE @iMonemi             INTEGER
   DECLARE @dFecemi             DATETIME
   DECLARE @dFecven             DATETIME
   DECLARE @dFeccal             DATETIME
   DECLARE @fTasemi             FLOAT
   DECLARE @fBasemi             FLOAT
   DECLARE @fTasest             FLOAT
   DECLARE @fNominal            FLOAT
   DECLARE @fTir                FLOAT
   DECLARE @fTirBCaps           FLOAT
   DECLARE @fPvp                FLOAT
   DECLARE @fMT                 FLOAT
   DECLARE @fMTUM               FLOAT
   DECLARE @fMT_cien            FLOAT
   DECLARE @fVan                FLOAT
   DECLARE @fVpar               FLOAT
   DECLARE @nNumucup            INTEGER
   DECLARE @dFecucup            DATETIME
   DECLARE @fIntucup            FLOAT
   DECLARE @fAmoucup            FLOAT
   DECLARE @fSalucup            FLOAT
   DECLARE @nNumpcup            INTEGER
   DECLARE @dFecpcup            DATETIME
   DECLARE @fIntpcup            FLOAT
   DECLARE @fAmopcup            FLOAT
   DECLARE @fSalpcup            FLOAT
   DECLARE @fDurat              FLOAT
   DECLARE @fConvx              FLOAT
   DECLARE @fDurmo              FLOAT
   DECLARE @nError              INTEGER

   DECLARE @cInstcam            CHAR(10)
   DECLARE @fNomiReal           FLOAT
   DECLARE @fValmon_Hoy         FLOAT
   DECLARE @fValmon_Man         FLOAT
   DECLARE @fValmon_Com         FLOAT
   DECLARE @fValmon_Cup         FLOAT
   DECLARE @iCupon              INTEGER
   DECLARE @fCapital            FLOAT
   DECLARE @fCapital_UM         FLOAT
   DECLARE @fFactor             FLOAT
   DECLARE @fValcupo            FLOAT
   DECLARE @fIntcupo            FLOAT
   DECLARE @fAmocupo            FLOAT
   DECLARE @nReacup             NUMERIC(19,4)
   DECLARE @nIntcup             NUMERIC(19,4)
   DECLARE @nDifcup             NUMERIC(19,4)
   DECLARE @nPagCupo            NUMERIC(19,4)
   DECLARE @nPagCup             NUMERIC(19,4)
   DECLARE @nDifReaCup          NUMERIC(19,0)
   DECLARE @fMonto              FLOAT
   DECLARE @nIntdif             NUMERIC(19,0)
   DECLARE @nIntPordia          NUMERIC(19,0)
   DECLARE @nInteres_RealCup    NUMERIC(19,0)

   DECLARE @nRutcart            NUMERIC(09,0)
   DECLARE @nTipcart            NUMERIC(05,0)
   DECLARE @nNumdocu            NUMERIC(10,0)
   DECLARE @nNumoper            NUMERIC(10,0)
   DECLARE @nCorrela            NUMERIC(03,0)
   DECLARE @nValcomp            NUMERIC(19,4)
   DECLARE @fValcomu            FLOAT
   DECLARE @dFeccomp            DATETIME
   DECLARE @nVpresen            NUMERIC(19,4)
   DECLARE @cMascara            CHAR(10)
   DECLARE @cSeriado            CHAR(01)
   DECLARE @cCartera            CHAR(03)
   DECLARE @nInteres            NUMERIC(19,4)
   DECLARE @nReajuste           NUMERIC(19,0)
   DECLARE @nIntMes             NUMERIC(19,4)
   DECLARE @nReaMes             NUMERIC(19,0)
   DECLARE @nIntdia             NUMERIC(19,4)
   DECLARE @nReadia             NUMERIC(19,0)
   DECLARE @fTasaFloat          FLOAT
   DECLARE @nValoraTasaEmi      NUMERIC(19,4)
   DECLARE @nPrimaDctoTot       NUMERIC(19,0)
   DECLARE @nPrimaDctoDia       NUMERIC(19,0)
   DECLARE @frutemis            NUMERIC(09)
   DECLARE @valorpar_lchr       NUMERIC(19,4)
   DECLARE @nInteresvpar        NUMERIC(19,0)
   DECLARE @xx		        NUMERIC(18,4)
   DECLARE @xx1		        NUMERIC(18,4)
   DECLARE @nPrimaDesc	        NUMERIC(19,4)

   DECLARE @nMes        INTEGER
   DECLARE @nAno                INTEGER
   DECLARE @nMes_a              INTEGER
   DECLARE @iAst                INTEGER
   DECLARE @cMes                CHAR(02)
   DECLARE @cAno                CHAR(04)
   DECLARE @dFecpro             DATETIME
   DECLARE @iPago_Nohabil       INTEGER
   DECLARE @sw_contab           CHAR(01)
   DECLARE @sw_deven            CHAR(01)
   DECLARE @iX                  INTEGER
   DECLARE @nContador           INTEGER
   DECLARE @dFecDevengo         DATETIME
   DECLARE @nValorpara          FLOAT
   DECLARE @fIpc_Mes            FLOAT
   DECLARE @fIpc_Hoy            FLOAT
   DECLARE @dFec_cp             DATETIME
   DECLARE @dFec_in             DATETIME
   DECLARE @dFec_pr             DATETIME
   DECLARE @fIpc_cp             FLOAT
   DECLARE @fIpc_in             FLOAT
   DECLARE @fIpc_pr             FLOAT
   DECLARE @nRea_cp             NUMERIC(19,0)
   DECLARE @nRea_pr             NUMERIC(19,0)
   DECLARE @fVparDEV            FLOAT

   DECLARE @nRutBanco		NUMERIC(09)
   DECLARE @nCodBanco		NUMERIC(05)
   DECLARE @cTipo_Moneda_papel	CHAR(01)
   DECLARE @nDecimal		INTEGER

   DECLARE @dFechaLiquida       DATETIME
   DECLARE @fNocionalPm         FLOAT

   SELECT  @nRutBanco	        = rcrut
      ,    @nCodBanco	        = rccodcar
   FROM	   VIEW_ENTIDAD

   SELECT @dFecDevengo = @dFecHoy

   SELECT @sw_contab = acsw_co
   ,      @sw_deven  = acsw_dvprop
   ,      @fIpc_Mes  = ac_ipcmes
   ,      @dFecpro   = CASE WHEN acsw_rc = '0' AND @cDevengo_dolar = 'S' THEN acfecante ELSE acfecproc END
   FROM   MDAC0308

   --** Variables Chequeo Fin de Mes no Habil **--
   SET @iX    = 0  
   SET @nMes  = 0  
   SET @cMes  = ''


   SELECT @fIpc_hoy = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 502 AND vmfecha = DATEADD(MONTH, -1, DATEADD(DAY,(DATEPART(DAY,@dFechoy) * -1) +1, @dFechoy))
      SET @fIpc_hoy = ISNULL(@fIpc_hoy, @fIpc_Mes)

   IF @fIpc_hoy = 0.0 
      SET @fIpc_hoy = @fIpc_Mes



   -- D E V E N G A M I E N T O C A R T E R A    P R O P I A    D I S P O N I B L E    E    I N T E R M E D I A D A --  
   SELECT 'rutcart'      = cprutcart
   ,      'tipcart'      = cptipcart
   ,      'instser'      = cpinstser
   ,      'instcam'      = cpinstser
   ,      'mascara'      = cpmascara
   ,      'feccomp'      = cpfeccomp
   ,      'tircomp'      = cptircomp
   ,      'nominal'      = SUM(cpnominal)
   ,      'valcomp'      = SUM(cpcapitalc)
   ,      'valcomu'      = SUM(cpvalcomu)
   ,      'intdia'       = CONVERT(NUMERIC(19,4),0)
   ,      'readia'       = CONVERT(NUMERIC(19,4),0)
   ,      'interes'      = SUM(cpinteresc)
   ,      'reajuste'     = SUM(cpreajustc)
   ,      'interesmes'   = SUM(cpintermes)
   ,      'reajustemes'  = sum(cpreajumes)
   ,      'readifmes'    = CONVERT(NUMERIC(19,4),0)
   ,      'seriado'      = cpseriado
   ,      'codigo'       = cpcodigo
   ,      'valptehoy'    = SUM(cpvptirc)
   ,      'valpteman'    = CONVERT(NUMERIC(19,2),0)
   ,      'amocup'       = CONVERT(FLOAT,0)
   ,      'intcup'       = CONVERT(FLOAT,0)
   ,      'reacup'       = CONVERT(FLOAT,0)
   ,      'flujo'        = CONVERT(FLOAT,0)
   ,      'duration'     = CONVERT(FLOAT,0)
   ,      'durmodif'     = CONVERT(FLOAT,0)
   ,      'convex'       = CONVERT(FLOAT,0)
   ,      'tasa_float'   = CONVERT(FLOAT,0)
   ,      'monemi'       = CONVERT(INTEGER,0)
   ,      'basemi'       = CONVERT(FLOAT,0)
   ,      'tasemi'       = CONVERT(FLOAT,0)
   ,      'fecemi'       = cpfecemi
   ,      'fecven'       = cpfecven
   ,      'cupon'        = CONVERT(INTEGER,0)
   ,      'pvpcomp'      = (CASE WHEN LEFT(cpinstser, 4 ) = 'BCAP' THEN cppvpcomp ELSE CONVERT(FLOAT,0) END)
   ,      'numucup'      = CONVERT(FLOAT,0)
   ,      'numpcup'      = CONVERT(FLOAT,0)
   ,      'fecucup'      = cpfecucup
   ,      'fecpcup'      = cpfecpcup
   ,      'condpacto'    = CONVERT(CHAR(01),'')
   ,      'flag'       = CONVERT(CHAR(01),'N')
   ,      'cup'          = CONVERT(FLOAT,0)
   ,      'numdocu'      = cpnumdocu
   ,      'correla'      = cpcorrela
   ,      'PrimaDcto'    = cpprimadesc
   ,      'tasaEmis'     = cpvaltasemi
   ,      'valordia'     = CONVERT(FLOAT,0)
   ,      'valorpar'     = CONVERT(FLOAT,0)
   ,      'Moneda_papel' = CONVERT(CHAR(01),'')
   ,      'Decimales'	 = CONVERT(INTEGER,0)
   ,      'Nreg'         = CONVERT(NUMERIC(10),0)
   ,      'FechaLiquida' = CASE WHEN Fecha_PagoMañana > @dFechoy THEN Fecha_PagoMañana ELSE @dFechoy END
   ,      'VentaPM'      = 'N'
   ,      'TipoDev'      = CAST( 'DEV' AS CHAR(03) )
   ,      'Ipc_Emision'  = CONVERT(FLOAT,0)
   ,      'Ipc_2Ant'     = CONVERT(FLOAT,0)
   ,      'Ipc_1Ant'     = CONVERT(FLOAT,0)
   INTO   #TEMPORAL
   FROM   MDCP0308 where cpcodigo=888 and cpnominal>0
   AND    cpfecven      >= @dFechoy
   GROUP BY cprutcart
         ,  cptipcart
         ,  cpinstser
         ,  cpmascara
         ,  cpfeccomp
         ,  cptircomp
         ,  cpseriado
         ,  cpcodigo
         ,  cpfecemi
         ,  cpfecven
         ,  cpfecucup
         ,  cpfecpcup
         ,  cpnumdocu
         ,  cpcorrela
         , (CASE WHEN LEFT(cpinstser,4) = 'BCAP' THEN cppvpcomp ELSE CONVERT(FLOAT,0) END)
         ,  cpprimadesc
         ,  cpvaltasemi
         ,  Fecha_PagoMañana

   IF @@ERROR<>0
   BEGIN
      SELECT 'NO','No se Puede Generar Tabla Temporal de Paso con CP para Devengamiento'
      RETURN
   END

   --------------------------------------------------------------------
   DELETE FROM #TEMPORAL WHERE nominal <= 0 --> OR LEFT( instser, 3 ) <> 'DPF'

   UPDATE #TEMPORAL
   SET    monemi    = semonemi
   ,      basemi    = sebasemi
   ,      tasemi    = setasemi
   FROM   VIEW_SERIE
   WHERE  semascara = Mascara 
   AND    seriado   = 'S'

   UPDATE #TEMPORAL
   SET    tasemi    = nstasemi
   ,      monemi    = nsmonemi
   ,      basemi    = nsbasemi
   FROM   VIEW_NOSERIE
   WHERE  seriado   = 'N'
   AND    rutcart   = nsrutcart
   AND    numdocu   = nsnumdocu
   AND    correla   = nscorrela

   IF @cDevengo_dolar = 'N'
   BEGIN
      DELETE FROM #temporal 
             WHERE monemi <> 999 AND monemi <> 998 AND monemi <> 997 AND monemi <> 13 -- wms
   END ELSE
   BEGIN
      DELETE FROM #temporal 
            WHERE monemi = 999 OR monemi = 998 OR monemi = 997 OR monemi = 13 -- wms
   END

   -- VGS (29/06/2005)
   SELECT *,'nRegi'= IDENTITY(NUMERIC(10)) INTO #TEMPORAL22 FROM #TEMPORAL

   DELETE FROM #TEMPORAL

   INSERT INTO #TEMPORAL
   SELECT rutcart,    tipcart,     instser,   instcam,   mascara,  feccomp,   tircomp,   nominal,      valcomp,   valcomu, intdia,  readia,   interes,   reajuste
       ,  interesmes, reajustemes, readifmes, seriado,   codigo,   valptehoy, valpteman, amocup,       intcup,    reacup,  flujo,   duration, durmodif,  convex
       ,  tasa_float, monemi,      basemi,    tasemi,    fecemi,   fecven,    cupon,     pvpcomp,      numucup,   numpcup, fecucup, fecpcup,  condpacto, flag
       ,  cup,        numdocu,     correla,   PrimaDcto, tasaEmis, valordia,  valorpar,  Moneda_papel, Decimales, nRegi,   FechaLiquida, VentaPM, TipoDev, 0.0, 0.0, 0.0
   FROM #TEMPORAL22 
   ORDER BY nRegi

   SET @iX        = 0
   SET @nContador = (SELECT MAX(Nreg) FROM #TEMPORAL)

   declare @nValPste_Pagomañana	NUMERIC(19,4)
	SET @nValPste_Pagomañana = 0.0

   WHILE @iX<=@nContador
   BEGIN
         SET @iX                = @iX + 1
         SET @cInstser          = '*'
      SELECT @nRutcart          = rutcart
      ,      @nTipcart          = tipcart
      ,      @cInstser          = instser
      ,      @cInstcam          = instser
      ,      @fNominal          = nominal
      ,      @fTir              = tircomp
      ,      @iCodigo           = codigo
      ,      @dFecemi           = fecemi
      ,      @dFecven           = fecven
,      @fTasest           = tasa_float
      ,      @nValcomp = valcomp
      ,      @fValcomu          = valcomu
      ,      @nVpresen          = valptehoy
      ,      @nIntMes           = interesmes
      ,      @nReaMes           = reajustemes
      ,      @nInteres          = interes
      ,      @nReajuste         = reajuste
      ,      @fPvp              = pvpcomp
      ,      @fMt               = 0.0
      ,      @fMtum             = 0.0
      ,      @fMt_cien          = 0.0
      ,      @fVan              = 0.0
      ,      @fVpar             = 0.0
      ,      @nNumucup          = 0
      ,      @dFecucup          = ISNULL(fecucup,'')
      ,      @fIntucup          = 0.0
      ,      @fAmoucup          = 0.0
      ,      @fSalucup          = 0.0
      ,      @nNumpcup          = 0
      ,      @dFecpcup          = ISNULL(fecpcup,'')
      ,      @fIntpcup          = 0.0
      ,      @fAmopcup          = 0.0
      ,      @fSalpcup          = 0.0
      ,      @iAst              = 0
      ,      @iPago_NoHabil     = 0
      ,      @cSeriado          = seriado
      ,      @cMascara          = mascara
      ,      @dFeccomp          = feccomp
      ,      @cProg             = 'SP_' + inprog
      ,      @fDurat            = 0.0
      ,      @fConvx            = 0.0
      ,      @fDurmo            = 0.0
      ,    @fValmon_Hoy       = 1.0
      ,      @fValmon_Man       = 1.0
      ,      @fValmon_Com       = 1.0
      ,      @fValmon_Cup       = 1.0
      ,      @iMonemi           = monemi
      ,      @fTasemi           = tasemi
      ,      @fBasemi           = basemi
      ,      @fTasest           = 0.0
      ,      @nError            = 0
      ,      @iCupon            = 0
      ,      @fTasaFloat        = 0.0
      ,      @iModcal           = 2
      ,      @fAmocupo          = 0.0
      ,      @fIntcupo          = 0.0
      ,      @nReacup           = 0.0
      ,      @nDifReaCup        = 0.0
      ,      @nPagcup           = 0.0
      ,      @fAmocupo          = 0.0
      ,      @fValcupo          = 0.0
      ,      @nIntcup           = 0.0
      ,      @nReacup           = 0.0
      ,      @nPagcup           = 0.0
      ,      @nIntdia           = 0.0
      ,      @nReadia           = 0.0
      ,      @fMonto            = 0.0
      ,      @nIntdif           = 0.0
      ,      @nNumdocu          = numdocu
      ,      @nCorrela          = correla
      ,      @nPrimaDctoDia     = 0
      ,      @nValoraTasaEmi    = tasaEmis
      ,      @nPrimaDctoTot     = PrimaDcto
      ,      @valorpar_lchr     = 0
      ,      @dFechaLiquida     = FechaLiquida     
      ,      @nValPste_Pagomañana = valptehoy
      FROM   #TEMPORAL
      ,      VIEW_INSTRUMENTO
      WHERE  codigo             = incodigo 
      AND    Nreg               = @iX   -- VGS (29/06/2005)

    if @cInstser = '*'
    begin
        break

    end

      IF @cSeriado = 'S'
         SELECT @fTasemi  = setasemi 
         ,      @iMonemi  = semonemi 
         ,      @fBasemi  = sebasemi 
         ,      @frutemis = serutemi
         FROM   VIEW_SERIE
         WHERE  semascara = @cMascara
      ELSE 
      BEGIN
         SELECT @fTasemi  = nstasemi    
         ,      @iMonemi  = nsmonemi 
         ,      @fBasemi  = nsbasemi 
         ,      @dFecemi  = nsfecemi 
         ,      @frutemis = nsrutemi
         FROM   VIEW_NOSERIE
         WHERE  nsrutcart = @nRutcart 
         AND    nsnumdocu = @nNumdocu 
         AND    nscorrela = @nCorrela
      END

      SELECT @cTipo_Moneda_papel = CASE WHEN mnmx = 'C' THEN '0' ELSE '1' END
           , @nDecimal           = mndecimal
      FROM   VIEW_MONEDA
      WHERE  mncodmon            = @iMonemi

      IF (@dFecprox >= @dFecpcup AND @dFecpcup > @dFechoy) AND @iCodigo = 20 AND (CHARINDEX('*',@cInstser) <> 0 OR CHARINDEX('&',@cInstser) <> 0)
      BEGIN
         SET @iAst = 1
         IF CHARINDEX('*',@cInstser) <> 0 --** (*) **--
         BEGIN
    IF SUBSTRING(@cInstser,7,2)='**'
               SET @cInstser = SUBSTRING(@cInstser,1,6)+' *'+SUBSTRING(@cInstser,9,2)
            ELSE
               SET @cInstser = SUBSTRING(@cInstser,1,6)+'01'+SUBSTRING(@cInstser,9,2)
         END

         IF CHARINDEX('&',@cInstser)<>0 --** (&) **--
         BEGIN
            IF SUBSTRING(@cInstser,7,2)='&&'
               SET @cInstser = SUBSTRING(@cInstser,1,6)+' &'+SUBSTRING(@cInstser,9,2)
            ELSE 
            BEGIN
               SET @nMes   = CONVERT(INTEGER,SUBSTRING(@cInstser,9,2))
               SET @nMes_a = DATEPART(MONTH,@dFechoy)
               IF @nMes>@nMes_a
                  SET @nAno = DATEPART(YEAR,@dFechoy) - 1
               ELSE
                  SET @nAno = DATEPART(YEAR,@dFechoy)

               SET @cAno  = CONVERT(CHAR,@nAno)
               SET @cInstser = SUBSTRING(@cInstser,1,6)+SUBSTRING(@cInstser,9,2)+SUBSTRING(@cAno,3,2)
            END
         END
      END

      IF @iCodigo = 888
      BEGIN
         SET @fIpc_pr = 0 
         SET @fIpc_in = 0 
         SET @fIpc_cp = 0

         SET @dFec_cp = @dFeccomp - DATEPART(DAY,@dFeccomp)
         SET @dFec_cp = @dFec_cp  - DATEPART(DAY,@dFec_cp) + 1 --** Fecha Emisi¢n BR **--

         SET @dFec_in = @dFechoy  - DATEPART(DAY,@dFechoy)
         SET @dFec_in = @dFec_in  - DATEPART(DAY,@dFec_in)
         SET @dFec_in = @dFec_in  - DATEPART(DAY,@dFec_in) + 1 --** Fecha Dev.2 meses atr s Ant

         SET @dFec_pr = @dFechoy  - DATEPART(DAY,@dFechoy)
         SET @dFec_pr = @dFec_pr  - DATEPART(DAY,@dFec_pr) + 1 --** Fecha Dev.1 mes atr s


         SET @fIpc_cp = 1
         SET @fIpc_in = 0
         SET @fIpc_pr = 0
         SET @fIpc_cp = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 502 AND vmfecha = @dFec_cp)
         SET @fIpc_in = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 502 AND vmfecha = @dFec_in)
         SET @fIpc_pr = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 502 AND vmfecha = @dFec_pr)
      END

      IF @cProg<>'SP_'
      BEGIN
         IF @iMonemi<>999
         BEGIN
            SET @fValmon_Hoy = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFechoy)
            SET @fValmon_Man = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFecprox)
            SET @fTasest     =  CASE WHEN @iCodigo=1 THEN @fTe_pcdus
                                     WHEN @iCodigo=2 THEN @fTe_pcduf
                                     WHEN @iCodigo=5 THEN @fTe_ptf
                                     ELSE                  CONVERT(FLOAT,0)
                                END
         END

         SET @dFeccal = @dFecprox

         IF @dFecven < @dFecprox
            SET @dFeccal = @dFecven

         IF LEFT( @cInstser, 4 ) = 'BCAP' 
         BEGIN    
            EXECUTE @nError = @cProg 1, @dFeccal, @iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
                            , @fNominal OUTPUT, @fTirBCaps OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT, @fVan     OUTPUT, @fVpar OUTPUT
                            , @nNumucup OUTPUT, @dFecucup  OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT
                            , @fIntpcup OUTPUT, @fAmopcup  OUTPUT, @fSalpcup OUTPUT, @fDurat   OUTPUT, @fConvx   OUTPUT, @fDurmo   OUTPUT
         END ELSE 
         IF @frutemis=@nRutBanco AND @iCodigo=20
	 BEGIN
            SELECT @fVparDEV=0.0	
            EXECUTE @nError = @cProg @iModcal, @dFeccal, @iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
                            , @fNominal OUTPUT, @fTir     OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT, @fVan     OUTPUT, @fVpar OUTPUT
                            , @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT
          , @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat   OUTPUT, @fConvx   OUTPUT, @fDurmo   OUTPUT	
            SELECT @fVparDEV = ROUND( @fVpar,8)
            SELECT @fMt      = ROUND((@fNominal * (@fVparDEV / 100.0)) *  @fValmon_Man,0)
         END ELSE
            EXECUTE @nError = @cProg @iModcal, @dFeccal,@iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
                            , @fNominal OUTPUT, @fTir     OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT, @fVan     OUTPUT, @fVpar OUTPUT
                            , @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT
                            , @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat   OUTPUT, @fConvx   OUTPUT, @fDurmo   OUTPUT
    

         --** Valorizaci¢n a Pago de Cupon **--
         IF @iMonemi <> 999 AND @iMonemi <> 13
         BEGIN
            SELECT @fValmon_Cup = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFecucup
            SELECT @fValmon_Com = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFeccomp
         END

         --> Se agrego validacion de Fecha de Liquidacion (Pago Mañana u Hoy) al Controp, para que no rebaje los Papeles PagoMañana
         IF (@dFecprox >= @dFecucup AND @dFechoy < @dFecucup) AND @iAst = 0 AND @dFechaLiquida = @dFechoy
         BEGIN
            SET @iCupon    = 1

            IF @iMonemi <> 999 AND @iMonemi<>13
            BEGIN
               SELECT @fValmon_Cup = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFecucup
               SELECT @fValmon_Com = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFeccomp
            END

            IF @cSeriado = 'S'
            BEGIN
               --** Pago Inhabil **--
               IF @dFecucup > @dFechoy AND @dFecucup < @dFecprox
                  SET @iPago_Nohabil = 1

               SET @fIntucup =      ((@fIntucup * @fNominal) / CONVERT(FLOAT,100))
               SET @fAmoucup =      ((@fAmoucup * @fNominal) / CONVERT(FLOAT,100))
               SET @fIntcupo = ROUND( @fIntucup * @fValmon_Cup, CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END) -- wms
               SET @fAmocupo = ROUND( @fAmoucup * @fValmon_Cup, CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END) -- wms
               SET @nPagcup  = ROUND((@fIntucup + @fAmoucup) * @fValmon_Man, CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END) --wms

               IF @dFecucup <> @dFecprox
                  SELECT @nPagcupo = ROUND( (@fIntucup + @fAmoucup) * @fValmon_Man, CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END) --wms
               ELSE
                  SELECT @nPagcupo = ROUND( (@fIntucup + @fAmoucup) * @fValmon_Cup, CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END) --wms

               SELECT @fValcupo = @fIntcupo + @fAmocupo

            END
         END

	 IF @dFechaLiquida > @dFechoy
	 BEGIN
	    SET @fMt 	  = @nValPste_Pagomañana
	    SET @nVpresen = @nValPste_Pagomañana
	 END

         --> Segun Carlos Basterrica Debiera quedar en Cero el Reajuste
         IF @dFechaLiquida > @dFechoy
            SET @nReadia   = 0
         ELSE
            SET @nReadia   = ROUND((@fValmon_Man - @fValmon_Hoy) * @fValcomu, 0)
         --************************************************************************************
         --************************************************************************************
         --************************************************************************************

         IF @iCodigo=888
         BEGIN
            SELECT @fIpc_cp	= ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=DATEADD(MONTH,-1,DATEADD(DAY,(DATEPART(day,@dFeccomp)*-1)+1,@dFeccomp))),0)
            IF @fIpc_cp  = 0  
            BEGIN
               SELECT @fIpc_cp	= ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=DATEADD(MONTH,-2,DATEADD(DAY,(DATEPART(day,@dFeccomp)*-1)+1,@dFeccomp))),0)
            END

            SELECT @dFec_in = DATEADD(MONTH,-2,DATEADD(DAY,(DATEPART(day,@dFechoy)*-1)+1,@dFechoy))
            SELECT @fIpc_in = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dFec_in),0)

            SELECT @dFec_pr = DATEADD(MONTH,-1,DATEADD(DAY,(DATEPART(day,@dFechoy)*-1)+1,@dFechoy))
            SELECT @fIpc_pr = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dFec_pr),0)
            SELECT @nReadia = 0
            ---SELECT @fIpc_pr , @fIpc_in ,@fIpc_mes , @fIpc_hoy

            -->   select @fIpc_pr , @fIpc_in , @nValcomp,@fIpc_cp

            IF @fIpc_pr <> 0 AND @fIpc_pr <> @fIpc_in
            BEGIN
               --> Segun Carlos Basterrica Debiera quedar en Cero el Reajuste
               IF @dFechaLiquida > @dFechoy
                  SET @nReadia = 0
               ELSE
                  SET @nReadia = ROUND(( @fIpc_pr - @fIpc_in ) * ROUND(@nValcomp/@fIpc_cp, CASE WHEN @ctipo_moneda_papel ='0' THEN @ndecimal ELSE 0 END),  (CASE WHEN @ctipo_moneda_papel ='0' THEN @ndecimal ELSE 0 END) )
            END ELSE 
            BEGIN
               SELECT @nReadia = 0
            END

	    -->   SELECT @nReadia 

            -- VGS 16/03/2005 Se incorpora esta pregunta para que genere el regisrto de VC en la MDRS
            IF @dFecven < @dFecprox 
               SELECT @iCupon = 1
         END

         IF @iCodigo = 888 AND @fIpc_mes <> @fIpc_hoy AND @dFeccomp < @dFechoy
         BEGIN
            IF @dFechaLiquida > @dFechoy
               SET @nIntdia = 0
            ELSE               
               SET @nIntdia = @fMt - @nVpresen - @nReadia

            SET @nInteres   = @nInteres  + @nIntdia
            SET @nReajuste  = @nReajuste + @nReadia
         END ELSE
         BEGIN

            IF @iCodigo = 888
               SET @nReadia = 0

            IF @dFechaLiquida > @dFechoy
               SET @nIntdia = 0
            ELSE               
               SET @nIntdia = ROUND(@fMt - @nVpresen - @nReadia + @nPagcup,CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END)

            SET @nInteres   = @nInteres  + @nIntdia
            SET @nReajuste  = @nReajuste + @nReadia
         END

/*         SELECT '@nReadia'  = @nReadia
            ,   '@fIpc_mes' = @fIpc_mes
            ,   '@fIpc_hoy' = @fIpc_hoy
            ,   '@dFeccomp' = @dFeccomp
            ,   '@dFechoy'  = @dFechoy,  '\\', @fIpc_pr, @fIpc_in, @nValcomp, @fIpc_cp
*/
         IF DATEPART(MONTH,@dFechoy)<>DATEPART(MONTH,@dFecprox)
         BEGIN
            SET @nIntMes = 0.0 
            SET @nReaMes = 0.0
         END

         SET @nIntMes = @nIntMes + @nIntdia
         SET @nReaMes = @nReaMes + @nReadia
 
         --** Capitalizacion **--
         IF @iCupon=1
         BEGIN
            IF @cSeriado='S'
            BEGIN
               SET @nInteres_RealCup = @nInteres 

               IF @iPago_NoHabil=1
               BEGIN
                  SET @nIntPordia       = @nIntdia  / DATEDIFF(DAY,@dFechoy,@dFecprox)
                  SET @nInteres_RealCup = @nInteres - @nIntdia + (@nIntPordia * DATEDIFF(DAY,@dFechoy,@dFecucup) )
               END

               SET @fFactor     = (((@fIntucup * @fValmon_Cup) - @nInteres_RealCup) / ISNULL(@fValmon_Cup,1))

               SET @fCapital_UM = @fAmoucup + @fFactor
               SET @fCapital    = ROUND( @fCapital_UM * @fValmon_Com, CASE WHEN @cTipo_moneda_papel = '0' THEN @nDecimal ELSE 0 END)
               SET @nReacup     = ROUND((@fValmon_Cup - @fValmon_Com) * @fCapital_UM, 0)
             SET @nIntcup     = @nInteres_RealCup

               SET @nDifcup     = @nPagcup  - (@fCapital + @nReacup + @nIntcup)
               SET @fCapital    = @fCapital + @nDifcup
               SET @nReacup     = @nReacup  + ROUND((@fValmon_Man-@fValmon_Cup) * @fCapital_UM, CASE WHEN @cTipo_moneda_papel = '0' THEN @nDecimal ELSE 0 END)
               SET @nIntcup     = @nPagcup  - @fCapital - @nReacup
               SET @fAmocupo    = @fCapital
               SET @nDifReaCup  = @nPagcupo - (@fAmocupo + @nIntcup + @nReacup)
               SET @nPagcup     = @nPagcupo

            END ELSE
            BEGIN
               SET @fAmocupo    = @nValcomp
               SET @fValcupo    = @nValcomp + @nInteres + @nReajuste
               SET @nIntcup     = @nInteres
               SET @nReacup     = @nReajuste
               SET @nPagcup     = @fValcupo

            END
         END
      END

      IF @iCupon=1 AND @cSeriado='S'
      BEGIN
         SET @nReajuste = @nReajuste - @nReacup
         SET @nValcomp  = ISNULL(@nValcomp - ISNULL(@fCapital,1),1)
         SET @fValcomu  = ROUND(@nValcomp / ISNULL(@fValmon_com,1) ,4 )
         SET @nInteres  = @nInteres  - @nIntcup
      END

      IF @frutemis = @nRutBanco AND @iCodigo = 20
      BEGIN 
         SELECT @nPrimaDctoDia = ROUND(@nPrimaDctoTot / DATEDIFF(day, @dFeccomp, @dFecven),0)
      END

      UPDATE #TEMPORAL
      SET    instser      = @cInstcam
      ,      instcam      = @cInstser
      ,      valcomp      = @nValcomp
      ,      valcomu      = @fValcomu
      ,      intdia       = @nIntdia
      ,      readia       = @nReadia
      ,      interesmes   = @nIntMes
      ,      reajustemes  = @nReaMes
      ,      interes      = @nInteres
      ,      reajuste     = @nReajuste
      ,      readifmes    = @nDifReaCup
      ,      valptehoy    = @nVpresen
      ,      valpteman    = @fMt
      ,      amocup       = @fAmocupo
      ,      intcup      = @nIntcup
      ,      reacup       = @nReacup
      ,      flujo        = @nPagcup
      ,      duration     = @fDurat
      ,      durmodif     = @fDurmo
      ,      convex       = @fConvx
      ,      tasa_float   = @fTasaFloat
      ,      tasemi       = @fTasemi
      ,      monemi       = @iMonemi
      ,      basemi       = @fBasemi
      ,      cupon        = @iCupon
      ,      pvpcomp      = @fPvp
      ,      numucup      = @nNumucup
      ,      numpcup      = @nNumpcup
      ,      fecucup      = @dFecucup
      ,      fecpcup      = @dFecpcup
      ,      flag         = 'S'
      ,      cup          = @fIntpcup+@fAmopcup
      ,      PrimaDcto    = @nPrimaDctoTot
      ,      tasaEmis     = @nValoraTasaEmi
      ,      valordia     = @nPrimaDctoDia
      ,      valorpar     = @fVpar
      ,      Moneda_papel = @cTipo_moneda_papel
      ,      Decimales    = @nDecimal

      ,      Ipc_Emision  = @fIpc_cp
      ,      Ipc_2Ant     = @fIpc_in
      ,      Ipc_1Ant     = @fIpc_pr
      WHERE  @nRutcart    = rutcart 
      AND    @nNumdocu    = numdocu 
      AND    @nCorrela    = correla
      AND    Nreg         = @iX   -- VGS (29/06/2005)

      IF @@ERROR<>0
      BEGIN
         SELECT 'NO','Problemas al Actualizar Tabla Temporal de Devengamiento'
         RETURN
      END

   END


   SELECT * INTO total_BR FROM #temporal  

   SELECT 'SI','Proceso de Devengamiento ha finalizado en forma correcta'

   SET NOCOUNT OFF

   RETURN

END

GO
