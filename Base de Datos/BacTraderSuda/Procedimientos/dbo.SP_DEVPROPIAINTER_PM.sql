USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEVPROPIAINTER_PM]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DEVPROPIAINTER_PM]
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
   DECLARE @nMes                INTEGER
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
   DECLARE @nNumVenta           NUMERIC(9)

   SELECT  @nRutBanco	        = rcrut
      ,    @nCodBanco	        = rccodcar
   FROM	   BacParamSuda.dbo.ENTIDAD

   SELECT @sw_contab = acsw_co
   ,      @sw_deven  = acsw_dvprop
   ,      @fIpc_Mes  = ac_ipcmes
   ,      @dFecpro   = CASE WHEN acsw_rc = '0' AND @cDevengo_dolar = 'S' THEN acfecante ELSE acfecproc END
   FROM   BacTraderSuda.dbo.MDAC

   --** Variables Chequeo Fin de Mes no Habil **--
   SET @iX    = 0  
   SET @nMes  = 0  
   SET @cMes  = ''

   SELECT @fIpc_hoy = vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmcodigo = 502 AND vmfecha = DATEADD(MONTH, -1, DATEADD(DAY,(DATEPART(DAY,@dFechoy) * -1) +1, @dFechoy))
      SET @fIpc_hoy = ISNULL(@fIpc_hoy, @fIpc_Mes)

   IF @fIpc_hoy = 0.0 
      SET @fIpc_hoy = @fIpc_Mes


   -- D E V E N G A M I E N T O C A R T E R A    P R O P I A    D I S P O N I B L E    E    I N T E R M E D I A D A --  
   --> Inserta Registros PM desde la Tabla de Movimientos
   SELECT 'rutcart'      = m.morutcart
   ,      'tipcart'      = m.motipcart
   ,      'instser'      = m.moinstser
   ,      'instcam'      = m.moinstser
   ,      'mascara'      = m.momascara
   ,      'feccomp'      = m.fecha_compra_original
   ,      'tircomp'      = m.tir_compra_original
   ,      'nominal'      = m.monominal
   ,      'valcomp'      = m.movalcomp
   ,      'valcomu'      = m.movalcomu
   ,      'intdia'       = CONVERT(NUMERIC(19,4),0)
   ,      'readia'       = CONVERT(NUMERIC(19,4),0)
   ,      'interes'      = m.mointeres
   ,      'reajuste'     = m.moreajuste
   ,      'interesmes'   = m.mointeres
   ,      'reajustemes'  = m.moreajuste
   ,      'readifmes'    = CONVERT(NUMERIC(19,4),0)
   ,      'seriado'      = m.moseriado
   ,      'codigo'       = m.mocodigo
   ,      'valptehoy'    = m.movpresen
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
   ,      'fecemi'       = m.mofecemi
   ,      'fecven'       = m.mofecven
   ,      'cupon'        = CONVERT(INTEGER,0)
   ,      'pvpcomp'      = CASE WHEN LEFT(m.moinstser,4) = 'BCAP' THEN m.mopvp ELSE CONVERT(FLOAT,0) END
   ,      'numucup'      = CONVERT(FLOAT,0)
   ,      'numpcup'      = CONVERT(FLOAT,0)
   ,      'fecucup'      = c.cpfecucup
   ,      'fecpcup'      = c.cpfecpcup
   ,      'condpacto'    = CONVERT(CHAR(01),'')
   ,      'flag'         = CONVERT(CHAR(01),'N')
   ,      'cup'          = CONVERT(FLOAT,0)
   ,      'numdocu'      = m.monumdocu
   ,      'correla'      = m.mocorrela
   ,      'PrimaDcto'    = c.cpprimadesc
   ,      'tasaEmis'     = c.cpvaltasemi
   ,      'valordia'     = CONVERT(FLOAT,0)
   ,      'valorpar'     = CONVERT(FLOAT,0)
   ,      'Moneda_papel' = CONVERT(CHAR(01),'')
   ,      'Decimales'	 = CONVERT(INTEGER,0)
   ,      'Nreg'         = CONVERT(NUMERIC(10),0)
   ,      'FechaLiquida' = @dFechoy
   ,      'VentaPM'      = 'S'
   ,      'TipoDev'      = CAST( 'DVP'  AS CHAR(03) )
   ,      'NumVnta'      = monumoper
   INTO   #TEMPORAL_pm
   FROM   MDMOPM          m with(nolock) -->  Se obtiene informacion desde la tabla de grabacion de tx PM
          INNER JOIN MDCP c with(nolock) ON m.monumdocu = c.cpnumdocu AND m.mocorrela = c.cpcorrela
   WHERE  m.mofecpro         = @dFechoy
   AND    m.motipoper        = 'VP'
   AND    m.PagoMañana       = 'S'
   AND    m.Fecha_PagoMañana = @dFecprox

   IF @@ERROR<>0
   BEGIN
      SELECT 'NO','No se Puede Generar Tabla Temporal de Paso con VP PM para Devengamiento'
      RETURN
   END

   DELETE FROM #TEMPORAL_pm 
         WHERE nominal <= 0 --> OR LEFT( instser, 3 ) <> 'DPF'

   UPDATE MDMOPM
   SET    mocapitalp   = 0.0
   ,      mointeresp   = 0.0
   ,      moreajustp   = 0.0
   ,      movpresenp   = 0.0
   ,      monominalp   = 0.0
   ,      mointpac     = 0.0
   ,      moreapac     = 0.0
   ,      movpressb    = 0.0
   ,      mointermesvi = 0.0
   ,      moreajumesvi = 0.0
   FROM   #TEMPORAL_pm
   WHERE  monumdocu    = numdocu
     AND  mocorrela    = correla
     AND  monumoper    = NumVnta

      
   UPDATE #TEMPORAL_pm
   SET    monemi    = semonemi
   ,      basemi    = sebasemi
   ,      tasemi    = setasemi
   FROM   BacParamSuda.dbo.SERIE
   WHERE  semascara = Mascara 
   AND    seriado   = 'S'

   UPDATE #TEMPORAL_pm
   SET    tasemi    = nstasemi
   ,      monemi    = nsmonemi
   ,      basemi    = nsbasemi
   FROM   BacParamSuda.dbo.NOSERIE
   WHERE  seriado   = 'N'
   AND    rutcart   = nsrutcart
   AND    numdocu   = nsnumdocu
   AND    correla   = nscorrela

   -- VGS (29/06/2005)
   SELECT *,'nRegi'= Identity(NUMERIC(10)) INTO #TEMPORAL22_pm FROM #TEMPORAL_pm

   DELETE FROM #TEMPORAL_pm

   INSERT INTO #TEMPORAL_pm
   SELECT rutcart,    tipcart,     instser,   instcam,   mascara,  feccomp,   tircomp,   nominal,      valcomp,   valcomu, intdia,  readia,   interes,   reajuste
       ,  interesmes, reajustemes, readifmes, seriado,   codigo,   valptehoy, valpteman, amocup,       intcup,    reacup,  flujo,   duration, durmodif,  convex
       ,  tasa_float, monemi,      basemi,    tasemi,    fecemi,   fecven,    cupon,     pvpcomp,      numucup,   numpcup, fecucup, fecpcup,  condpacto, flag
       ,  cup,        numdocu,     correla,   PrimaDcto, tasaEmis, valordia,  valorpar,  Moneda_papel, Decimales, nRegi,   FechaLiquida, VentaPM, TipoDev, NumVnta
   FROM   #TEMPORAL22_pm
   ORDER BY nRegi

   SET @iX        = 0
   SET @nContador = (SELECT MAX(Nreg) FROM #TEMPORAL_pm)

   WHILE @iX <= @nContador
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
      ,      @nValcomp          = valcomp
      ,      @fValcomu          = valcomu
      ,      @nVpresen          = valptehoy
      ,      @nIntMes           = interesmes
      ,      @nReaMes           = reajustemes
      ,    @nInteres          = interes
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
      ,      @fValmon_Hoy       = 1.0
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
      ,      @nNumVenta         = NumVnta
      FROM   #TEMPORAL_pm
      ,      BacParamSuda.dbo.INSTRUMENTO
      WHERE  codigo             = incodigo 
      AND    Nreg               = @iX   -- VGS (29/06/2005)

      IF @cInstser = '*'
         BREAK

      IF @cSeriado = 'S'

         SELECT @fTasemi  = setasemi 
         ,      @iMonemi  = semonemi 
         ,      @fBasemi  = sebasemi 
         ,      @frutemis = serutemi
         FROM   BacParamSuda.dbo.SERIE
         WHERE  semascara = @cMascara
      ELSE

         SELECT @fTasemi  = nstasemi    
         ,      @iMonemi  = nsmonemi 
         ,      @fBasemi  = nsbasemi 
         ,      @dFecemi  = nsfecemi 
         ,      @frutemis = nsrutemi
         FROM   BacParamSuda.dbo.NOSERIE
         WHERE  nsrutcart = @nRutcart 
         AND    nsnumdocu = @nNumdocu 
         AND    nscorrela = @nCorrela

      SELECT @cTipo_Moneda_papel = CASE WHEN mnmx = 'C' THEN '0' ELSE '1' END
           , @nDecimal           = mndecimal
      FROM   BacParamSuda.dbo.MONEDA
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
         SET @fIpc_cp = (SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmcodigo = 502 AND vmfecha = @dFec_cp)
         SET @fIpc_in = (SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmcodigo = 502 AND vmfecha = @dFec_in)
         SET @fIpc_pr = (SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmcodigo = 502 AND vmfecha = @dFec_pr)
      END

      IF @cProg<>'SP_'
      BEGIN
         IF @iMonemi<>999
         BEGIN
            SET @fValmon_Hoy = (SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFechoy)
            SET @fValmon_Man = (SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFecprox)
            SET @fTasest     =  CASE WHEN @iCodigo=1 THEN @fTe_pcdus
                                     WHEN @iCodigo=2 THEN @fTe_pcduf
                                     WHEN @iCodigo=5 THEN @fTe_ptf
                                     ELSE CONVERT(FLOAT,0)
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
            SELECT @fValmon_Cup = vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFecucup
            SELECT @fValmon_Com = vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFeccomp
         END

         --> Se agrego validacion de Fecha de Liquidacion (Pago Mañana u Hoy) al Controp, para que no rebaje los Papeles PagoMañana
         IF (@dFecprox >= @dFecucup AND @dFechoy < @dFecucup) AND @iAst = 0 AND @dFechaLiquida = @dFechoy
         BEGIN
            SET @iCupon    = 1

            IF @iMonemi <> 999 AND @iMonemi<>13
            BEGIN
               SELECT @fValmon_Cup = vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFecucup
               SELECT @fValmon_Com = vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFeccomp
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
                  SET @nPagcupo = ROUND( (@fIntucup + @fAmoucup) * @fValmon_Man, CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END) --wms
               ELSE
                  SET @nPagcupo = ROUND( (@fIntucup + @fAmoucup) * @fValmon_Cup, CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END) --wms

               SELECT @fValcupo = @fIntcupo + @fAmocupo
            END

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
            SELECT @fIpc_cp	= ISNULL((SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=DATEADD(MONTH,-1,DATEADD(DAY,(DATEPART(DAY,@dFeccomp)*-1)+1,@dFeccomp))),0)
            IF @fIpc_cp  = 0  
            BEGIN
               SELECT @fIpc_cp	= ISNULL((SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=DATEADD(MONTH,-2,DATEADD(DAY,(DATEPART(DAY,@dFeccomp)*-1)+1,@dFeccomp))),0)
            END

            SELECT @dFec_in = DATEADD(MONTH,-2,DATEADD(DAY,(DATEPART(day,@dFechoy)*-1)+1,@dFechoy))
            SELECT @fIpc_in = ISNULL((SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dFec_in),0)
            SELECT @dFec_pr = DATEADD(MONTH,-1,DATEADD(DAY,(DATEPART(day,@dFechoy)*-1)+1,@dFechoy))
            SELECT @fIpc_pr = ISNULL((SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dFec_pr),0)
            SELECT @nReadia = 0
            ---SELECT @fIpc_pr , @fIpc_in ,@fIpc_mes , @fIpc_hoy

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

   	IF EXISTS( SELECT * 
		     FROM mdmopm 
		    WHERE motipoper='CP' 
		      AND monumdocu = @nNumdocu
		      AND mocorrela = @nCorrela
		      AND Fecha_PagoMañana = @dFecprox )
	BEGIN
            SELECT @nIntdia= 0, @nReadia=0   --> Se dejan en cero la intereses y reajustes de las transacciones VP de CP PM
	END



      UPDATE #TEMPORAL_pm
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
      ,      intcup       = @nIntcup
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
      WHERE  rutcart      = @nRutcart
      AND    numdocu      = @nNumdocu
      AND    correla      = @nCorrela
      AND    NumVnta      = @nNumVenta
      AND    Nreg         = @iX   -- VGS (29/06/2005)

      IF @@ERROR<>0
      BEGIN
         SELECT 'NO','Problemas al Actualizar Tabla Temporal de Devengamiento'
         RETURN
      END

   END

   UPDATE MDMOPM
   SET    /*rscupamo             */  mocapitalp   = ROUND(amocup * (monominal / nominal), CASE WHEN moneda_papel = '0' THEN Decimales ELSE 0 END)
   ,      /*rscupint             */  mointeresp   = ROUND(intcup * (monominal / nominal), CASE WHEN moneda_papel = '0' THEN Decimales ELSE 0 END)
   ,      /*rscuprea             */  moreajustp   = ROUND(reacup * (monominal / nominal), CASE WHEN moneda_papel = '0' THEN Decimales ELSE 0 END)
   ,      /*rsflujo              */  movpresenp   = ROUND(flujo  * (monominal / nominal), CASE WHEN moneda_papel = '0' THEN Decimales ELSE 0 END)
   ,      /*valor_tasa_emision   */  monominalp   = CASE WHEN momonemi = 13 THEN ISNULL( ROUND(tasaEmis  * (monominal / nominal), 2), 0)
                                                         ELSE                    ISNULL( ROUND(tasaEmis  * (monominal / nominal), 0), 0)
                                                    END
   ,      /*prima_descuento_total*/  mointpac     = CASE WHEN momonemi = 13 THEN ISNULL( ROUND(PrimaDcto * (monominal / nominal), 2), 0)
                                                         ELSE                    ISNULL( ROUND(PrimaDcto * (monominal / nominal), 0), 0)
                                                    END
   ,      /*prima_descuento_dia  */  moreapac     = CASE WHEN momonemi = 13 THEN ISNULL( ROUND(valordia * (monominal / nominal), 2), 0)
                        	                         ELSE                    ISNULL( ROUND(valordia * (monominal / nominal) * DATEDIFF(DAY, @dFechoy, @dFecprox),0), 0)
                      	                            END
   ,      /*valor_par            */  movpressb    = valorpar
   ,      /*rsinteres            */  mointermesvi = ROUND(intdia * (monominal / nominal), CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
   ,      /*rsreajuste           */  moreajumesvi = ROUND(readia * (monominal / nominal), 0)
   FROM   #TEMPORAL_pm
   WHERE  monumdocu = numdocu
     AND  mocorrela = correla
     and  monumoper = NumVnta

   UPDATE MDMOPM    --> rscupamo   + rscupint   + rscuprea
      SET mointermesc = mocapitalp + mointeresp + moreajustp
                        
--   SELECT 'SI','Proceso de Devengamiento Pago Mañana ha finalizado en forma correcta.-'

   SET NOCOUNT OFF

   RETURN

END

GO
