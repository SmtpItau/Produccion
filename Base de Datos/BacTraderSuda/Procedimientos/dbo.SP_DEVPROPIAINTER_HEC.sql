USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEVPROPIAINTER_HEC]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DEVPROPIAINTER_HEC]
                                  (
                                     @dFechoy        DATETIME     ,
                                     @dFecprox       DATETIME     ,
                                     @fTe_pcdus      FLOAT        ,	
                                     @fTe_pcduf      FLOAT        ,
                                     @fTe_ptf        FLOAT        ,
                                     @cDevengo_dolar CHAR (01)
                                  )
AS
BEGIN
 SET NOCOUNT ON
DECLARE    @cProg    CHAR (10)       ,
           @iModcal  INTEGER         ,
           @iCodigo  INTEGER         ,
           @cInstser CHAR (10)       ,
           @iMonemi  INTEGER         ,
           @dFecemi  DATETIME        ,
           @dFecven  DATETIME        ,
           @dFeccal  DATETIME        ,   
           @fTasemi  FLOAT           ,
           @fBasemi  FLOAT           ,
           @fTasest  FLOAT           ,
           @fNominal FLOAT           ,
           @fTir     FLOAT           ,
           @fTirBCaps FLOAT           ,
           @fPvp     FLOAT           ,
           @fMT      FLOAT           ,
           @fMTUM    FLOAT           ,
           @fMT_cien FLOAT           ,
           @fVan     FLOAT           ,
           @fVpar    FLOAT           ,
           @nNumucup INTEGER         ,
           @dFecucup DATETIME        ,
           @fIntucup FLOAT           ,
           @fAmoucup FLOAT           ,
           @fSalucup FLOAT           ,
           @nNumpcup INTEGER         ,
           @dFecpcup DATETIME        ,
           @fIntpcup FLOAT           ,
           @fAmopcup FLOAT           ,
           @fSalpcup FLOAT           ,
           @fDurat  FLOAT            ,
           @fConvx  FLOAT            ,
           @fDurmo  FLOAT            ,
           @nError  INTEGER


 DECLARE @cInstcam CHAR (10)         ,
        @fNomiReal FLOAT             ,
        @fValmon_Hoy FLOAT           ,
        @fValmon_Man FLOAT           ,
        @fValmon_Com FLOAT           ,
        @fValmon_Cup FLOAT           ,
        @iCupon  INTEGER             ,
        @fCapital FLOAT              ,
        @fCapital_UM FLOAT           ,
        @fFactor FLOAT               ,
        @fValcupo FLOAT              ,
        @fIntcupo FLOAT              ,
        @fAmocupo FLOAT              ,
        @nReacup NUMERIC (19,4)      ,
        @nIntcup NUMERIC (19,4)      ,
        @nDifcup NUMERIC (19,4)      ,
        @nPagCupo NUMERIC (19,4)     ,
        @nPagCup NUMERIC (19,4)      ,
        @nDifReaCup NUMERIC (19,0)   ,
        @fMonto  FLOAT               ,
        @nIntdif NUMERIC (19,0)      ,
        @nIntPordia  NUMERIC (19,0)  ,
        @nInteres_RealCup NUMERIC (19,0) 

DECLARE @nRutcart   NUMERIC (09,0)   ,
        @nTipcart   NUMERIC (05,0)   ,
        @nNumdocu   NUMERIC (10,0)   ,
        @nNumoper   NUMERIC (10,0)   ,
        @nCorrela   NUMERIC (03,0)   ,
        @nValcomp   NUMERIC (19,4)   ,
        @fValcomu   FLOAT            ,
        @dFeccomp   DATETIME         ,
        @nVpresen   NUMERIC (19,4)   ,
        @cMascara   CHAR (10)        ,
        @cSeriado   CHAR (01)        ,
        @cCartera   CHAR (03)        ,
        @nInteres   NUMERIC (19,4)   ,
        @nReajuste  NUMERIC (19,0)   ,
        @nIntMes    NUMERIC (19,4)   ,
        @nReaMes    NUMERIC (19,0)   ,
        @nIntdia    NUMERIC (19,4)   ,
        @nReadia    NUMERIC (19,0)   ,
        @fTasaFloat FLOAT            ,
        @nValoraTasaEmi NUMERIC	(19,4),
        @nPrimaDctoTot  NUMERIC	(19,0),
        @nPrimaDctoDia  NUMERIC	(19,0),
	@frutemis       NUMERIC (09)  ,
	@valorpar_lchr  NUMERIC (19,4),
        @nInteresvpar   NUMERIC (19,0),
	@xx		NUMERIC(18,4),
	@xx1		NUMERIC(18,4),
	@nPrimaDesc	NUMERIC(19,4)


     --   @fValVenc   FLOAT            --nueva
 DECLARE @nMes    INTEGER            ,
@nAno    INTEGER ,
         @nMes_a  INTEGER            ,
     	 @iAst    INTEGER            ,
   	 @cMes    CHAR (02)          ,
         @cAno    CHAR (04)          ,
         @dFecpro DATETIME           ,
         @iPago_Nohabil INTEGER      ,
         @sw_contab   CHAR (01)      ,
   	 @sw_deven    CHAR (01)      ,
         @iX          INTEGER        , 
         @nContador   INTEGER        , 
         @dFecDevengo DATETIME       ,
         @nValorpara  FLOAT          ,
         @fIpc_Mes    FLOAT          ,
         @fIpc_Hoy    FLOAT          ,
         @dFec_cp     DATETIME       ,
         @dFec_in     DATETIME       ,
         @dFec_pr     DATETIME       ,
         @fIpc_cp     FLOAT          ,
         @fIpc_in     FLOAT          ,
         @fIpc_pr     FLOAT          ,
         @nRea_cp     NUMERIC (19,0) ,
         @nRea_pr     NUMERIC (19,0) ,
         @fVparDEV    FLOAT  


        DECLARE @nRutBanco   NUMERIC(9)
        ,       @nCodBanco   NUMERIC(5)


        SELECT  @nRutBanco   = rcrut
        ,       @nCodBanco   = rccodcar
        FROM    VIEW_ENTIDAD


 IF @cDevengo_dolar='S'
  IF NOT EXISTS(SELECT * FROM MDDI WHERE CHARINDEX(RTRIM(dinemmon),'DA-DO')>0)
  BEGIN
   SELECT 'SI','No Existen Documentos en dolares'
   RETURN
  END
 ELSE
  SELECT @dFecDevengo = @dFecHoy

 --** Revision de Switch's y Respaldo automatico **--
 UPDATE MDAC SET acsw_pc='1'
 SELECT @sw_contab  = acsw_co     ,
        @sw_deven   = acsw_dvprop ,
        @fIpc_Mes   = ac_ipcmes   ,
        @dFecpro    = (CASE WHEN acsw_rc='0' AND @cDevengo_dolar='S' THEN acfecante ELSE acfecproc END)
 FROM MdAc

 --** Variables Chequeo Fin de Mes no Habil **--
 SELECT @iX    = 0  ,
        @nMes  = 0  ,
        @cMes  = ''

 SELECT @fIpc_hoy = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=DATEADD( MONTH, -1, DATEADD( DAY, (DATEPART(DAY,@dFechoy)*-1)+1, @dFechoy ) ) --(@dFechoy-DATEPART(DAY,@dFechoy))+1

 SELECT @fIpc_hoy = ISNULL( @fIpc_hoy, @fIpc_Mes )

 IF @fIpc_hoy = 0.0 SELECT @fIpc_hoy = @fIpc_Mes

 --** Se realiza la validaci¢n de las monedas necesarias para procesar devengamiento **--
 WHILE @iX<=DATEDIFF(DAY,@dFecHoy,@dFecProx)
 BEGIN
  SELECT @nValorpara = 0.0
  IF @cDevengo_dolar='N'
  BEGIN
   SELECT @nvalorpara = vmvalor FROM VIEW_VALOR_MONEDA WHERE  vmcodigo=998 AND vmfecha=DATEADD(DAY,@iX,@dFecHoy)
   IF @nValorpara IS NULL OR @nValorpara=0.0
   BEGIN
    SELECT 'NO', 'Valor U.F. '+CONVERT(CHAR(10),DATEADD(DAY,@iX,@dFecHoy),103)+' NO Existe'
    RETURN
   END
 
   SELECT @nValorpara = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=997 AND vmfecha=DATEADD(DAY,@iX,@dFecHoy) 
   IF @nvalorpara IS NULL OR @nvalorpara = 0.0
   BEGIN
    SELECT 'NO', 'Valor I.V.P. '+CONVERT(CHAR(10),DATEADD(DAY,@iX,@dFecHoy),103)+' NO Existe'
    RETURN
   END
  END
  IF @cDevengo_dolar='S'
  BEGIN
   SELECT @nValorpara = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=994 AND vmfecha=DATEADD(DAY,@iX,@dFecHoy) 
   IF @nValorpara IS NULL OR @nValorpara=0.0
   BEGIN
    SELECT 'NO', 'Valor Dolar '+CONVERT(CHAR(10),DATEADD(DAY,@iX,@dFecHoy),103)+' NO Existe'
    RETURN
   END
  END
  SELECT @iX = @iX + DATEDIFF(DAY,@dFechoy,@dFecprox)
 END
-- BEGIN TRANSACTION
  IF @cDevengo_dolar='N'
  BEGIN
   DELETE FROM MDRS
   WHERE rsfecha=@dFecprox AND (rscartera='111' OR rscartera='114') AND
    (rsmonemi=999 OR rsmonemi=998 OR rsmonemi=997)
  
   IF @@ERROR<>0
   BEGIN
--    ROLLBACK TRANSACTION
    SELECT 'NO','No se pudieron eliminar registros de tabla Resultado'
    RETURN
   END
  END
  ELSE
  BEGIN
   DELETE FROM MDRS
   WHERE (rsmonemi<>999 AND rsmonemi<>998 AND rsmonemi<>997) AND rsfecha=@dFecprox AND
         (rscartera='111' OR rscartera='114') --OR rscodigo<>13
   IF @@ERROR<>0
   BEGIN
--    ROLLBACK TRANSACTION
    SELECT 'NO','No se pudieron eliminar registros de tabla Resultado'
    RETURN
   END
  END

-- D E V E N G A M I E N T O   C A R T E R A    P R O P I A    D I S P O N I B L E    E    I N T E R M E D I A D A --  
  SELECT 'rutcart'    = cprutcart   ,
         'tipcart'    = cptipcart            ,
         'instser'    = cpinstser            ,
         'instcam'    = cpinstser            ,
         'mascara'    = cpmascara            ,
         'feccomp'    = cpfeccomp            ,
         'tircomp'    = cptircomp            ,
       	 'nominal'    = SUM(cpnominal)       ,
    	 'valcomp'    = SUM(cpcapitalc)      ,
         'valcomu'    = SUM(cpvalcomu)       ,
         'intdia'     = CONVERT(NUMERIC(19,4),0) ,
         'readia'     = CONVERT(NUMERIC(19,4),0) ,
         'interes'    = SUM(cpinteresc)      ,
         'reajuste'   = SUM(cpreajustc)      ,
         'interesmes' = SUM(cpintermes)      ,
         'reajustemes'= sum(cpreajumes)      ,
         'readifmes'  = CONVERT(NUMERIC(19,4),0) ,
         'seriado'    = cpseriado            ,
         'codigo'     = cpcodigo             ,
         'valptehoy'  = SUM(cpvptirc)        ,
         'valpteman'  = CONVERT(NUMERIC(19,2),0) ,
         'amocup'     = CONVERT(FLOAT,0)     ,
         'intcup'     = CONVERT(FLOAT,0)     ,
         'reacup'     = CONVERT(FLOAT,0)     ,
         'flujo'      = CONVERT(FLOAT,0)     ,
         'duration'   = CONVERT(FLOAT,0)     ,
         'durmodif'   = CONVERT(FLOAT,0)     ,
         'convex'     = CONVERT(FLOAT,0)     ,
         'tasa_float' = CONVERT(FLOAT,0)     ,
         'monemi'     = CONVERT(INTEGER,0)   ,
         'basemi'     = CONVERT(FLOAT,0)     ,
         'tasemi'     = CONVERT(FLOAT,0)     ,
         'fecemi'     = cpfecemi             ,
         'fecven'     = cpfecven             ,
         'cupon'      = CONVERT(INTEGER,0)   ,
         'pvpcomp'    = (CASE WHEN LEFT( cpinstser, 4 ) = 'BCAP' THEN cppvpcomp ELSE CONVERT(FLOAT,0) END),
         'numucup'    = CONVERT(FLOAT,0)     ,
         'numpcup'    = CONVERT(FLOAT,0)     ,
         'fecucup'    = cpfecucup            ,
         'fecpcup'    = cpfecpcup            ,
         'condpacto'  = CONVERT(CHAR(01),'') ,
         'flag'       = CONVERT(CHAR(01),'N'),
         'cup'        = CONVERT(FLOAT,0)     , 
         'numdocu'    = cpnumdocu            ,
         'correla'    = cpcorrela            ,
         'PrimaDcto'  = cpprimadesc	     ,
	 'tasaEmis'   = cpvaltasemi,   ---valor_compra_original,
	 'valordia'   = CONVERT(FLOAT,0)     ,
 	 'valorpar'   = CONVERT(FLOAT,0)     

  INTO #TEMPORAL
  FROM MDCP
  WHERE cprutcart>0 AND cpcodigo<>98 and cpfeccomp='20040304' and cpnumdocu= 45735
  GROUP BY cprutcart,cptipcart,cpinstser,cpmascara,cpfeccomp, cptircomp, cpseriado,cpcodigo, cpfecemi, cpfecven, cpfecucup, cpfecpcup, cpnumdocu, cpcorrela, 
           (CASE WHEN LEFT( cpinstser, 4 ) = 'BCAP' THEN cppvpcomp ELSE CONVERT(FLOAT,0) END),cpprimadesc, cpvaltasemi  --valor_compra_original 
  IF @@ERROR<>0
  BEGIN
--   ROLLBACK TRANSACTION
   SELECT 'NO','No se Puede Generar Tabla Temporal de Paso con CP para Devengamiento'
   RETURN
  END

  IF @dFechoy=@dFecpro
   UPDATE #TEMPORAL
   SET nominal     = nominal     + ISNULL((SELECT SUM(vinominal)   FROM MDVI WHERE rutcart=virutcart AND instser=viinstser AND feccomp=vifeccomp AND tircomp=vitircomp AND numdocu=vinumdocu AND correla=vicorrela),0)  ,
       valcomp     = valcomp     + ISNULL((SELECT SUM(vivalcomp)   FROM MDVI WHERE rutcart=virutcart AND instser=viinstser AND feccomp=vifeccomp AND tircomp=vitircomp AND numdocu=vinumdocu AND correla=vicorrela),0)  ,
       valcomu     = valcomu     + ISNULL((SELECT SUM(vivalcomu)   FROM MDVI WHERE rutcart=virutcart AND instser=viinstser AND feccomp=vifeccomp AND tircomp=vitircomp AND numdocu=vinumdocu AND correla=vicorrela),0)  ,
       valptehoy   = valptehoy   + ISNULL((SELECT SUM(vivptirc)    FROM MDVI WHERE rutcart=virutcart AND instser=viinstser AND feccomp=vifeccomp AND tircomp=vitircomp AND numdocu=vinumdocu AND correla=vicorrela),0)  ,
       interes     = interes + ISNULL((SELECT SUM(viinteresv)  FROM MDVI WHERE rutcart=virutcart AND instser=viinstser AND feccomp=vifeccomp AND tircomp=vitircomp AND numdocu=vinumdocu AND correla=vicorrela),0) ,
       reajuste    = reajuste    + ISNULL((SELECT SUM(vireajustv)  FROM MDVI WHERE rutcart=virutcart AND instser=viinstser AND feccomp=vifeccomp AND tircomp=vitircomp AND numdocu=vinumdocu AND correla=vicorrela),0) ,
       interesmes  = interesmes  + ISNULL((SELECT SUM(viintermesv) FROM MDVI WHERE rutcart=virutcart AND instser=viinstser AND feccomp=vifeccomp AND tircomp=vitircomp AND numdocu=vinumdocu AND correla=vicorrela),0) ,
       reajustemes = reajustemes + ISNULL((SELECT SUM(vireajumesv) FROM MDVI WHERE rutcart=virutcart AND instser=viinstser AND feccomp=vifeccomp AND tircomp=vitircomp AND numdocu=vinumdocu AND correla=vicorrela),0)
  ELSE
  BEGIN
   UPDATE  #TEMPORAL
   SET valptehoy   = (SELECT ISNULL(SUM(rsvppresenx),0)    FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='111' AND rstipopero='CP' AND rsfecha=@dFecHoy AND numdocu=rsnumdocu AND correla=rscorrela)  ,
       interes     = (SELECT ISNULL(SUM(rsinteres_acum),0) FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='111' AND rstipopero='CP' AND rsfecha=@dFecHoy AND numdocu=rsnumdocu AND correla=rscorrela)  ,
       reajuste    = (SELECT ISNULL(SUM(rsreajuste_acum),0)FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='111' AND rstipopero='CP' AND rsfecha=@dFecHoy AND numdocu=rsnumdocu AND correla=rscorrela) ,
       interesmes  = (SELECT ISNULL(SUM(rsintermes),0)     FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='111' AND rstipopero='CP' AND rsfecha=@dFecHoy AND numdocu=rsnumdocu AND correla=rscorrela)    ,
       reajustemes = (SELECT ISNULL(SUM(rsreajumes),0)     FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='111' AND rstipopero='CP' AND rsfecha=@dFecHoy AND numdocu=rsnumdocu AND correla=rscorrela)

   UPDATE #TEMPORAL
   SET nominal     = nominal   + (SELECT ISNULL(SUM(rsnominal),0)  FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='114' AND rstipopero='VI' AND rsfecha=@dFecHoy AND numdocu=rsnumdocu AND correla=rscorrela)  ,
      valcomp     = valcomp   + (SELECT ISNULL(SUM(rsvalcomp),0)  FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='114' AND rstipopero='VI' AND rsfecha=@dFecHoy AND numdocu=rsnumdocu AND correla=rscorrela)  ,
      valcomu     = valcomu   + (SELECT ISNULL(SUM(rsvalcomu),0)  FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='114' AND rstipopero='VI' AND rsfecha=@dFecHoy AND numdocu=rsnumdocu AND correla=rscorrela)  ,
      valptehoy   = valptehoy + (SELECT ISNULL(SUM(rsvppresenx),0)FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='114' AND rstipopero='VI' AND rsfecha=@dFecHoy AND numdocu=rsnumdocu AND correla=rscorrela)  ,
       interes     = interes   + (SELECT ISNULL(SUM(rsinteres_acum),0) FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='114' AND rstipopero='VI' AND rsfecha=@dFecHoy AND numdocu=rsnumdocu AND correla=rscorrela)  ,
       reajuste    = reajuste  + (SELECT ISNULL(SUM(rsreajuste_acum),0) FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='114' AND rstipopero='VI' AND rsfecha=@dFecHoy AND numdocu=rsnumdocu AND correla=rscorrela)  ,
       interesmes  = interesmes+ (SELECT ISNULL(SUM(rsintermes),0) FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='114' AND rstipopero='VI' AND rsfecha=@dFecHoy AND numdocu=rsnumdocu AND correla=rscorrela)  ,
       reajustemes = reajustemes+(SELECT ISNULL(SUM(rsreajumes),0) FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='114' AND rstipopero='VI' AND rsfecha=@dFecHoy AND numdocu=rsnumdocu AND correla=rscorrela)
  END
  IF @@ERROR<>0
  BEGIN
--   ROLLBACK TRANSACTION
   SELECT 'NO','No se Puede Actualizar Tabla Temporal con VI del Devengamiento'
   RETURN
  END
  UPDATE #TEMPORAL
         SET  monemi  = semonemi, 
              basemi  = sebasemi,
              tasemi  = setasemi
         from  view_serie
        WHERE semascara=Mascara AND 
               seriado = 'S'
  UPDATE #TEMPORAL
         SET   tasemi  = (select DISTINCT nstasemi FROM view_noserie WHERE nsserie=Instser),
               monemi  = (select DISTINCT nsmonemi FROM view_noserie WHERE nsserie=Instser),
               basemi  = (select DISTINCT nsbasemi FROM view_noserie WHERE nsserie=Instser)
         WHERE seriado = 'N'
  IF @cDevengo_dolar = 'N' BEGIN
     DELETE #temporal WHERE monemi <> 999 AND monemi <> 998 AND monemi <> 997
  END ELSE BEGIN
     DELETE #temporal WHERE monemi = 999 OR monemi = 998 OR monemi = 997
  END
  SELECT @iX  = 1 
  DELETE #TEMPORAL WHERE nominal<=0 --OR LEFT( instser, 3 ) <> 'DPF'

  SELECT @nContador = COUNT(*) FROM #TEMPORAL WHERE nominal>0 AND fecven>=@dFechoy


  WHILE @iX<=@nContador
  BEGIN
   SELECT @cInstser = '*'
   SET ROWCOUNT 1
   SELECT  @nRutcart   = rutcart        ,
           @nTipcart   = tipcart        ,
           @cInstser   = instser        ,
           @cInstcam   = instser        ,
           @fNominal   = nominal        ,
           @fTir       = tircomp        ,
           @iCodigo    = codigo         ,
           @dFecemi    = fecemi         ,
           @dFecven    = fecven         ,
           @fTasest    = tasa_float     ,
           @nValcomp   = valcomp        ,
           @fValcomu   = valcomu        ,
           @nVpresen   = valptehoy      ,
           @nIntMes    = interesmes     ,
           @nReaMes    = reajustemes    ,
           @nInteres   = interes        ,
           @nReajuste  = reajuste        ,
           @fPvp       = pvpcomp        ,
           @fMt        = 0.0            ,
           @fMtum      = 0.0            ,
           @fMt_cien   = 0.0            ,
           @fVan       = 0.0            ,
           @fVpar      = 0.0            ,
           @nNumucup   = 0               ,
           @dFecucup   = ISNULL(fecucup,'') ,
           @fIntucup   = 0.0             ,
           @fAmoucup   = 0.0             ,
           @fSalucup   = 0.0             ,
           @nNumpcup   = 0               ,
           @dFecpcup   = ISNULL(fecpcup,'') ,
           @fIntpcup   = 0.0             ,
           @fAmopcup   = 0.0             ,
           @fSalpcup   = 0.0             ,
           @iAst       = 0               ,
           @iPago_NoHabil = 0            ,
           @cSeriado    = seriado        ,
           @cMascara    = mascara        ,
           @dFeccomp    = feccomp        ,
           @cProg       = 'SP_'+inprog   ,
           @fDurat      = 0.0            ,
           @fConvx      = 0.0            ,
           @fDurmo      = 0.0            ,
           @fValmon_Hoy = 1.0            ,
           @fValmon_Man = 1.0            ,
           @fValmon_Com = 1.0            ,
           @fValmon_Cup = 1.0            ,
           @iMonemi     = monemi         ,
           @fTasemi     = tasemi         ,
           @fBasemi     = basemi         ,
           @fTasest     = 0.0            ,
           @nError      = 0              ,
           @iCupon      = 0              ,
           @fTasaFloat  = 0.0            ,
           @iModcal     = 2              ,
           @fAmocupo    = 0.0            ,
@fIntcupo    = 0.0    ,
	  @nReacup     = 0.0     ,
 	   @nDifReaCup  = 0.0            ,
           @nPagcup     = 0.0            ,
           @fAmocupo    = 0.0            ,
           @fValcupo    = 0.0            ,
           @nIntcup     = 0.0            ,
           @nReacup     = 0.0            ,
           @nPagcup     = 0.0            ,
           @nIntdia     = 0.0            ,
           @nReadia     = 0.0            ,
           @fMonto         = 0.0         ,
           @nIntdif        = 0.0         ,
           @nNumdocu       = numdocu     ,
           @nCorrela  	   = correla     ,
           @nPrimaDctoDia  = 0           ,
           @nValoraTasaEmi = tasaEmis    ,
	   @nPrimaDctoTot  = PrimaDcto   ,
	   @valorpar_lchr  = 0           


        --   @fValVenc    = 0.0      --nueva
   FROM #TEMPORAL, VIEW_INSTRUMENTO
   WHERE (nominal>0 AND fecven>=@dFechoy) AND codigo=incodigo AND flag <> 'S'
   SET ROWCOUNT 0
   SELECT @iX = @iX + 1
   IF @cInstser='*'
    BREAK


-- select * from VIEW_INSTRUMENTO
   IF @cSeriado = 'S'
    SELECT @fTasemi = setasemi ,
           @iMonemi = semonemi ,
           @fBasemi = sebasemi ,
           @frutemis = serutemi
    FROM VIEW_SERIE
    WHERE semascara=@cMascara
   ELSE
   BEGIN
    SET ROWCOUNT 1
    SELECT @fTasemi  = nstasemi ,
           @iMonemi  = nsmonemi ,
           @fBasemi  = nsbasemi ,
           @dFecemi  = nsfecemi ,
           @frutemis = nsrutemi
    FROM VIEW_NOSERIE
    WHERE nsserie=@cInstser
    SET ROWCOUNT 0
   END



   IF (@dFecprox>=@dFecpcup AND @dFecpcup>@dFechoy) AND @iCodigo=20 AND (CHARINDEX('*',@cInstser)<>0 OR CHARINDEX('&',@cInstser)<>0)
   BEGIN
    SELECT @iAst = 1
    IF CHARINDEX('*',@cInstser) <> 0 --** (*) **--
    BEGIN
     IF SUBSTRING(@cInstser,7,2)='**'
      SELECT @cInstser = SUBSTRING(@cInstser,1,6)+' *'+SUBSTRING(@cInstser,9,2)
     ELSE
      SELECT @cInstser = SUBSTRING(@cInstser,1,6)+'01'+SUBSTRING(@cInstser,9,2)
    END
    IF CHARINDEX('&',@cInstser)<>0 --** (&) **--
    BEGIN
     IF SUBSTRING(@cInstser,7,2)='&&'
      SELECT @cInstser = SUBSTRING(@cInstser,1,6)+' &'+SUBSTRING(@cInstser,9,2)
     ELSE
     BEGIN
      SELECT @nMes = CONVERT(INTEGER,SUBSTRING(@cInstser,9,2))
      SELECT @nMes_a = DATEPART(MONTH,@dFechoy)
      IF @nMes>@nMes_a
       SELECT @nAno = DATEPART(YEAR,@dFechoy) - 1
      ELSE
       SELECT @nAno = DATEPART(YEAR,@dFechoy)
       SELECT @cAno  = CONVERT(CHAR,@nAno)
       SELECT @cInstser = SUBSTRING(@cInstser,1,6)+SUBSTRING(@cInstser,9,2)+SUBSTRING(@cAno,3,2)
     END
    END
   END

   IF @iCodigo=888
   BEGIN
    SELECT @fIpc_pr = 0 ,
           @fIpc_in = 0 ,
           @fIpc_cp = 0
    SELECT @dFec_cp = @dFecemi - DATEPART(DAY,@dFecemi)
    SELECT @dFec_cp = @dFec_cp - DATEPART(DAY,@dFec_cp)+1 --** Fecha Emisi¢n BR **--
    SELECT @dFec_in = @dFechoy - DATEPART(DAY,@dFechoy)
    SELECT @dFec_in = @dFec_in - DATEPART(DAY,@dFec_in)
    SELECT @dFec_in = @dFec_in - DATEPART(DAY,@dFec_in)+1 --** Fecha Dev.2 meses atr s Ant
    SELECT @dFec_pr = @dFechoy - DATEPART(DAY,@dFechoy)
    SELECT @dFec_pr = @dFec_pr - DATEPART(DAY,@dFec_pr)+1 --** Fecha Dev.1 mes atr s
    SELECT @fIpc_cp  = 1
    SELECT @fIpc_in  = 0
    SELECT @fIpc_pr  = 0
    SELECT @fIpc_cp = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dFec_cp
    SELECT @fIpc_in = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dFec_in
    SELECT @fIpc_pr = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dFec_pr
   END
   IF @cProg<>'SP_'
   BEGIN
    IF @iMonemi<>999
    BEGIN
     SELECT @fValmon_Hoy = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND vmfecha=@dFechoy
     SELECT @fValmon_Man = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND vmfecha=@dFecprox
     SELECT @fTasest  = CASE
      WHEN @iCodigo=1 THEN @fTe_pcdus
                              WHEN @iCodigo=2 THEN @fTe_pcduf
      WHEN @iCodigo=5 THEN @fTe_ptf
        ELSE CONVERT(FLOAT,0)
                        END
    END

---  select @dFecprox,@dFecpcup,@dFechoy

    SELECT @dFeccal = @dFecprox
    IF @dFecven < @dFecprox SELECT @dFeccal = @dFecven

-- ojo aquiiiiiii
    IF LEFT( @cInstser, 4 ) = 'BCAP' 
       BEGIN    
       EXECUTE @nError = @cProg 1, @dFeccal, @iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest,
                         @fNominal OUTPUT, @fTirBCaps OUTPUT, @fPvp OUTPUT, @fMt OUTPUT, @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,
                         @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
                         @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT
      END 
    ELSE IF @frutemis=@nRutBanco AND @iCodigo=20
	 begin	
		select @fVparDEV=0.0	
		EXECUTE	@nError	= @cProg @iModcal, @dFeccal, @iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest,
		        @fNominal OUTPUT, @fTir OUTPUT, @fPvp OUTPUT, @fMt OUTPUT, @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,
			@nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
	       		@fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT	
			select @fVparDEV=round(@fVpar,8)
			select @fMt = ROUND((@fNominal * (@fVparDEV / 100.0)) *  @fValmon_Man,0)
      end else
      
       EXECUTE @nError = @cProg @iModcal, @dFeccal,@iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest,
                         @fNominal OUTPUT, @fTir OUTPUT, @fPvp OUTPUT, @fMt OUTPUT, @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,
                         @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
                         @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT
    
    --** Valorizaci¢n a Pago de Cupon **--

     

     IF @iMonemi<>999 AND @iMonemi<>13
     BEGIN
      SELECT @fValmon_Cup = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND vmfecha=@dFecucup
      SELECT @fValmon_Com = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND vmfecha=@dFeccomp
     END
    IF (@dFecprox>=@dFecucup AND @dFechoy<@dFecucup) AND @iAst=0	
    BEGIN
     SELECT @iCupon    = 1
     IF @iMonemi<>999 AND @iMonemi<>13
     BEGIN
      SELECT @fValmon_Cup = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND vmfecha=@dFecucup
    SELECT @fValmon_Com = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND vmfecha=@dFeccomp
     END
   
     IF @cSeriado='S'
     BEGIN
      --** Pago Inhabil **--
      IF @dFecucup>@dFechoy AND @dFecucup<@dFecprox
         SELECT @iPago_Nohabil = 1
         SELECT @fIntucup = ((@fIntucup * @fNominal) / CONVERT(FLOAT,100))
         SELECT @fAmoucup = ((@fAmoucup * @fNominal) / CONVERT(FLOAT,100))
         SELECT @fIntcupo = ROUND( @fIntucup * @fValmon_Cup, 0)
         SELECT @fAmocupo = ROUND( @fAmoucup * @fValmon_Cup, 0)
         SELECT @nPagcup  = ROUND( (@fIntucup + @fAmoucup) * @fValmon_Man, 0)
     --    SELECT @fValVenc = ( (@fIntpcup+@fAmopcup) * @fNominal ) / CONVERT(FLOAT,100) --nueva
         IF @dFecucup<>@dFecprox
             SELECT @nPagcupo = ROUND( (@fIntucup + @fAmoucup) * @fValmon_Man, 0)
            ELSE
             SELECT @nPagcupo = ROUND( (@fIntucup + @fAmoucup) * @fValmon_Cup, 0)
             SELECT @fValcupo = @fIntcupo + @fAmocupo
       
   
         END

    END
    SELECT @nReadia   = ROUND(( @fValmon_Man - @fValmon_Hoy ) * @fValcomu, 0)

    IF @iCodigo=888 AND @fIpc_mes<>@fIpc_hoy AND @dFeccomp<@dFechoy
    BEGIN
 SELECT @nRea_cp = ROUND((@fIpc_pr/isnull(@fIpc_cp,1))*@fNominal,0)
     SELECT @nRea_pr    = ROUND((@fIpc_in/isnull(@fIpc_cp,1))*@fNominal,0)
     SELECT @nReadia    = @nRea_cp - @nRea_pr
     SELECT @nIntdia    = @fMt - @nVpresen - @nReadia
     SELECT @nInteres   = @nInteres  + @nIntdia
     SELECT @nReajuste  = @nReajuste + @nReadia
    END
    ELSE
    BEGIN
     SELECT @nIntdia   = @fMt - @nVpresen - @nReadia + @nPagcup
     SELECT @nInteres  = @nInteres  + @nIntdia
     SELECT @nReajuste = @nReajuste + @nReadia
    END
    IF DATEPART(MONTH,@dFechoy)<>DATEPART(MONTH,@dFecprox)
     SELECT @nIntMes   = 0.0 ,
        @nReaMes   = 0.0
     SELECT @nIntMes   = @nIntMes   + @nIntdia
     SELECT @nReaMes   = @nReaMes   + @nReadia
 
    --** Capitalizacion **--
    IF @iCupon=1
    BEGIN
     IF @cSeriado='S'
     BEGIN
      SELECT @nInteres_RealCup =  @nInteres 
      IF @iPago_NoHabil=1
      BEGIN
       SELECT @nIntPordia = @nIntdia / DATEDIFF(DAY,@dFechoy,@dFecprox)
       SELECT @nInteres_RealCup =  @nInteres - @nIntdia + ( @nIntPordia * DATEDIFF(DAY,@dFechoy,@dFecucup ) ) 
      END

--      SELECT 'VALORMONEDACUPON' = @fValmon_Cup , @iMonemi , @dFecucup
	

      SELECT @fFactor  = ((( @fIntucup * @fValmon_Cup ) - @nInteres_RealCup ) / isnull(@fValmon_Cup,1))
      SELECT @fCapital_UM = @fAmoucup + @fFactor
      SELECT @fCapital = ROUND( @fCapital_UM * @fValmon_Com , 0)
      SELECT @nReacup  = ROUND( (@fValmon_Cup-@fValmon_Com) * @fCapital_UM , 0 )
      SELECT @nIntcup  = @nInteres_RealCup
      SELECT @nDifcup  = @nPagcup - ( @fCapital + @nReacup + @nIntcup )
      SELECT @fCapital = @fCapital + @nDifcup
      SELECT @nReacup  = @nReacup + ROUND( (@fValmon_Man-@fValmon_Cup) * @fCapital_UM , 0 )
      SELECT @nIntcup  = @nPagcup - @fCapital - @nReacup
      SELECT @fAmocupo = @fCapital
      SELECT @nDifReaCup = @nPagcupo-(@fAmocupo+@nIntcup+@nReacup)
      SELECT @nPagcup  = @nPagcupo

     END
     ELSE
     BEGIN
      SELECT @fAmocupo = @nValcomp
      SELECT @fValcupo = @nValcomp + @nInteres + @nReajuste
      SELECT @nIntcup  = @nInteres ,
             @nReacup  = @nReajuste ,
             @nPagcup  = @fValcupo
     END
    END
   END
   IF @iCupon=1 AND @cSeriado='S'
   BEGIN
    SELECT @nReajuste = @nReajuste - @nReacup
    SELECT @nValcomp  = isnull(@nValcomp  - isnull(@fCapital,1),1)
    SELECT @fValcomu  = ROUND( @nValcomp / isnull(@fValmon_com,1) ,4 )
    SELECT @nInteres  = @nInteres  - @nIntcup
   END


 IF @frutemis = @nRutBanco AND @iCodigo = 20
   BEGIN 
	
	SELECT @nPrimaDctoDia = ROUND(@nPrimaDctoTot / DATEDIFF(day, @dFeccomp, @dFecven),0)
	       
 END

  -- SACAR --
  -- SELECT * FROM #TEMPORAL WHERE instser = 'PRD04C0901'
  -- SACAR --


   UPDATE #TEMPORAL
   SET    instser     = @cInstcam ,
          instcam     = @cInstser ,
          valcomp     = @nValcomp ,
          valcomu     = @fValcomu ,
          intdia      = @nIntdia ,
          readia      = @nReadia ,
          interesmes  = @nIntMes ,
          reajustemes = @nReaMes ,
          interes     = @nInteres ,
          reajuste    = @nReajuste ,
          readifmes   = @nDifReaCup ,
          valptehoy   = @nVpresen ,
          valpteman   = @fMt  ,
          amocup      = @fAmocupo ,
          intcup      = @nIntcup ,
          reacup      = @nReacup ,
          flujo       = @nPagcup ,
          duration    = @fDurat ,
          durmodif    = @fDurmo ,
          convex      = @fConvx ,
          tasa_float  = @fTasaFloat ,
          tasemi      = @fTasemi ,
          monemi      = @iMonemi ,
          basemi      = @fBasemi ,
          cupon       = @iCupon ,
          pvpcomp     = @fPvp  ,
          numucup     = @nNumucup ,
          numpcup     = @nNumpcup ,
          fecucup     = @dFecucup ,
          fecpcup     = @dFecpcup ,
          flag        = 'S'  ,
          cup         = @fIntpcup+@fAmopcup  ,
          PrimaDcto  = @nPrimaDctoTot       ,
          tasaEmis    = @nValoraTasaEmi      ,
	  valordia    = @nPrimaDctoDia       ,
	  valorpar    = @fVpar               


   WHERE @nRutcart=rutcart AND @cInstcam=instser AND @dFeccomp=feccomp AND @fTir=tircomp AND 
     @nNumdocu=numdocu AND @nCorrela=correla



   IF @@ERROR<>0
   BEGIN

    SELECT 'NO','Problemas al Actualizar Tabla Temporal de Devengamiento'
    RETURN
   END
END
---OJO MYMY

--SELECT * FROM #TEMPORAL

  INSERT INTO MDRS
   (
         rsfecha   ,-- 1
         rsrutcart    ,-- 2
         rstipcart    ,-- 3
         rsnumdocu    ,-- 4
         rscorrela    ,-- 5 
         rsnumoper    ,-- 6
         rscartera    ,-- 7
         rstipoper    ,-- 8
         rsinstser    ,-- 9
         rsrutcli     ,-- 10
         rscodcli     ,-- 11
         rsvppresen   ,-- 12
         rsvppresenx  ,-- 13
         rscupamo     ,-- 14
         rscupint ,-- 15
         rscuprea     ,-- 16
         rsflujo      ,-- 17
         rsfecprox    ,-- 18
         rsfecctb     ,-- 19
         rsnominal    ,-- 20
         rstir        ,-- 21
         rstasfloat   ,-- 22
         rsmonpact    ,-- 23
         rsmonemi     ,-- 24
         rstasemi     ,-- 25
         rsbasemi     ,-- 26
         rscodigo     ,-- 27
         rsinteres    ,-- 28
         rsreajuste   ,-- 29
         rsintermes   ,-- 30
         rsreajumes   ,-- 31
         rsinteres_acum   ,-- 32
         rsreajuste_acum  ,-- 33
         rsforpagv    ,-- 34
         rsvalcomp    ,-- 35
         rsvalcomu    ,-- 36
         rsvalvenc    ,-- 37
         rsdurat      ,-- 38
         rsdurmod     ,-- 39
         rsconvex     ,-- 40
         rsnumucup    ,-- 41
         rsnumpcup    ,-- 42
         rsfecucup    ,-- 43
         rsfecpcup    ,-- 44
         rsvpcomp     ,-- 45
         rstipopero   ,-- 46
         rsfeccomp    ,-- 47
         rsdifrea     ,-- 48
         rsinstcam    ,-- 49
         rsfecinip    ,-- 50  
         rsfecvtop    ,-- 51  
         rsvalvtop    ,-- 52  
         rsrutemis    ,-- 53 
         rsvalinip    ,-- 54 
         rstaspact    ,-- 55
         rsmascara    ,-- 56
         rsfecemis    ,-- 57
         rsfecvcto    ,-- 58
         rstipoletra  ,-- 59
         rsvalcompcp  ,-- 60
         rsvalcomucp  ,-- 61
         rsinterescp  ,-- 62
         rsreajustecp ,-- 63
         rsinteres_acumcp        , -- 64
         rsreajuste_acumcp       , -- 65
         MDRS.codigo_carterasuper  ,-- 66
         prima_descuento_dia  ,-- 62
         prima_descuento_total,-- 63
         valor_tasa_emision   , -- 64
         valor_par
   )
  SELECT
         @dFecprox    ,-- 1 rsfecha,rsrutcart,rstipcart,rsnumdocu,rscorrela,rsnumoper,rscartera,rstipoper
         cprutcart    ,-- 2 
         cptipcart    ,-- 3
         cpnumdocu    ,-- 4
         cpcorrela    ,-- 5
         cpnumdocu    ,-- 6
         '111'        ,-- 7
         'DEV'        ,-- 8
         cpinstser    ,-- 9
         cprutcli     ,-- 10
         cpcodcli     ,-- 11
         isnull(cpvptirc,0)     ,-- 12 rsvppresen
         0.0          ,-- 13 rsvppresenx
         0.0          ,-- 14 rscupamo
         0.0          ,-- 15 rscupint
         0.0          ,-- 16 rscuprea
         0.0        ,-- 17 rsflujo
         @dFecprox    ,-- 18
         @dFechoy     ,-- 19
         cpnominal   ,-- 20
         cptircomp    ,-- 21
         0.0          ,-- 22 rstasfloat
         mncodmon     ,-- 23 rsmonpact
         mncodmon     ,-- 24 rsmonemi  
         0.0          ,-- 25 rstasemi
         0.0          ,-- 26 rsbasemi
         cpcodigo     ,-- 27
         0.0       ,-- 28 rsinteres
         0.0          ,-- 29 rsreajuste
         0.0          ,-- 30 rsintermes
         0.0  ,-- 31 rsreajumes
         0.0          ,-- 32 rsinteres
         0.0          ,-- 33 rsreajuste
         0            ,-- 34 rsforpagv
         cpvalcomp    ,-- 35
         cpvalcomu    ,-- 36
         0            ,-- 37 rsvalvenc
         0.0          ,-- 38 rsdurat
         0.0          ,-- 39 rsdurmod
         0.0          ,-- 40 rsconvex
         0.0          ,-- 41 rsnumucup
         0.0          ,-- 42 rsnumpcup
	 ''           ,-- 43 rsfecucup
         ''           ,-- 44 rsfecpcup
         0.0          ,-- 45 rsvpcomp
         'CP'         ,-- 46
         cpfeccomp    ,-- 47
	 0.0    ,-- 48 rsdifrea
         ''           ,-- 49 rsinstcam
         ''           ,-- 50
         ''           ,-- 51
         0.0          ,-- 52
         0.0          ,-- 53
         0.0          ,-- 54
         0.0          ,-- 55
         cpmascara    ,-- 56
         cpfecemi     ,-- 57
         cpfecven     ,-- 58
         cptipoletra  ,-- 59
         cpvalcomp    ,-- 60
         cpvalcomu    ,-- 61
         0            ,-- 62
         0            ,-- 63
         cpinteresc   ,-- 64
     cpreajustc   ,-- 65
  MDCP.codigo_carterasuper,  -- 66,
	 0.0,
	 0.0,
	 0.0,
	 0.0
  FROM  MDCP, MDDI, VIEW_MONEDA
  WHERE cpnominal>0 AND (dirutcart=cprutcart AND dinumdocu=cpnumdocu AND dicorrela=cpcorrela) AND dinemmon=mnnemo AND cpfeccomp='20040304' and cpnumdocu= 45735 and
   CHARINDEX(STR(mncodmon,3),CASE WHEN @cDevengo_dolar='N' THEN '997-998-999' ELSE '988-994-995- 13' END)>0
  IF @@ERROR<>0
  BEGIN
--   ROLLBACK TRANSACTION
   SELECT 'NO','Problemas al Insertar Operaciones CP al MDRS'
   RETURN
  END

--print 'INSERT 2'
  INSERT INTO MDRS
   (
         rsfecha     ,-- 1
         rsrutcart   ,-- 2
         rstipcart   ,-- 3
         rsnumdocu   ,-- 4
         rscorrela   ,-- 5
         rsnumoper   ,-- 6
         rscartera   ,-- 7
         rstipoper   ,-- 8
         rsinstser   ,-- 9
         rsrutcli    ,-- 10
         rscodcli    ,-- 11
         rsvppresen  ,-- 12
         rsvppresenx ,-- 13
         rscupamo    ,-- 14
         rscupint    ,-- 15
         rscuprea    ,-- 16
         rsflujo     ,-- 17
         rsfecprox   ,-- 18
         rsfecctb    ,-- 19
         rsnominal   ,-- 20
         rstir       ,-- 21
         rstasfloat  ,-- 22
         rsmonpact   ,-- 23
         rsmonemi    ,-- 24
         rstasemi    ,-- 25
         rsbasemi    ,-- 26
         rscodigo    ,-- 27
         rsinteres   ,-- 28
         rsreajuste  ,-- 29
         rsintermes  ,-- 30
         rsreajumes  ,-- 31
         rsinteres_acum ,-- 32
         rsreajuste_acum ,-- 33
         rsforpagv    ,-- 34
         rsvalcomp    ,-- 35
         rsvalcomu    ,-- 36
         rsvalvenc    ,-- 37
         rsdurat     ,-- 38
         rsdurmod    ,-- 39 
         rsconvex    ,-- 40
         rsnumucup   ,-- 41
         rsnumpcup   ,-- 42
         rsfecucup   ,-- 43
         rsfecpcup   ,-- 44
         rsvpcomp    ,-- 45
         rstipopero  ,-- 46
         rsfeccomp   ,-- 47
         rsdifrea    ,-- 48
         rsinstcam   ,-- 49
         rsfecinip   ,-- 50
         rsfecvtop   ,-- 51  
         rsvalvtop   ,-- 52  
         rsrutemis   ,-- 53  
         rsvalinip   ,-- 54 
         rstaspact   ,-- 55
         rsmascara   ,-- 56
         rsfecemis   ,-- 57
         rsfecvcto   ,-- 58
         rsvalcompcp ,-- 59
         rsvalcomucp ,-- 60
         rsinterescp ,-- 61
         rsreajustecp        , -- 62
         rsinteres_acumcp        , -- 63
         rsreajuste_acumcp       , -- 64
         MDRS.codigo_carterasuper,  -- 65
         prima_descuento_dia  ,-- 62
         prima_descuento_total,-- 63
         valor_tasa_emision   , -- 64
	 valor_par
   )


  SELECT
         @dFecprox    ,-- 1
         virutcart    ,-- 2
         1.0          ,-- 3
         vinumdocu    ,-- 4
         vicorrela    ,-- 5
         vinumoper    ,-- 6
         '114'        ,-- 7
         'DEV'        ,-- 8
         viinstser    ,-- 9
         virutcli     ,-- 10
         vicodcli     ,-- 11
         isnull(vivptirc,0)     ,-- 12 rsvppresen
         0.0          ,-- 13 rsvppresenx
         0.0   ,-- 14 rscupamo
         0.0          ,-- 15 rscupint
         0.0          ,-- 16 rscuprea
         0.0          ,-- 17 rsflujo
         @dFecprox    ,-- 18
         @dFechoy     ,-- 19
         vinominal     ,-- 20
         vitircomp   ,-- 21
         0.0          ,-- 22 rstasfloat
         vimonpact    ,-- 23 rsmonpact
         vimonemi     ,-- 24 rsmonemi
         0.0          ,-- 25 rstasemi
        0.0          ,-- 26 rsbasemi
         vicodigo     ,-- 27
         0.0          ,-- 28 rsinteres
         0.0          ,-- 29 rsreajuste
         0.0          ,-- 30 rsintermes
         0.0          ,-- 31 rsreajumes
         0.0          ,-- 32 rsinteres
         0.0          ,-- 33 rsreajuste
         0            ,-- 34 rsforpagv
         vivalcomp    ,-- 35
         vivalcomu    ,-- 36
         0            ,-- 37 rsvalvenc
         0.0          ,-- 38 rsdurat
         0.0     ,-- 39 rsdurmod
         0.0    ,-- 40 rsconvex
         0.0          ,-- 41 rsnumucup
         0.0          ,-- 42 rsnumpcup
         ''           ,-- 43 rsfecucup
         ''           ,-- 44 rsfecpcup
         0.0          ,-- 45 rsvpcomp
         'VI'         ,-- 46
         vifeccomp    ,-- 47
         0.0          ,-- 48 rsdifrea
         ''           ,-- 49 rsinstcam
         vifecinip    ,-- 50 
         vifecvenp    ,-- 51  
         vivalvenp    ,-- 52
         virutemi     ,-- 53
         vivalinip    ,-- 54
         0.0          ,-- 55
         vimascara    ,-- 56
         vifecemi     ,-- 57
         vifecven     ,-- 58
         vivalcomp    ,-- 59
         vivalcomu    ,-- 60
         0            ,-- 61
         0            ,-- 62
         viinteresv   ,-- 63
         vireajustv   ,-- 64
         MDVI.codigo_carterasuper, -- 65
	 0.0,
	 0.0,
	 0.0,
	 0.0
  FROM MDVI
  WHERE vitipoper='CP' AND CHARINDEX(STR(vimonemi,3),CASE WHEN @cDevengo_dolar='N' THEN '997-998-999' ELSE '988-994-995- 13' END)>0

  IF @@ERROR<>0
  BEGIN

   SELECT 'NO','Problemas al Insertar Operaciones IN al MDRS'
   RETURN
  END

   --CBG
--  SELECT * FROM   #TEMPORAL

  UPDATE MDRS
  SET    rsinstser = instser           ,--1
         rsinstcam = instcam           ,--2
         rsvppresen = CASE
                           WHEN rsmonemi=13 THEN ROUND(valptehoy*(rsnominal/nominal),2)
                           ELSE ROUND(valptehoy*(rsnominal/nominal),0)
                      END                              ,--3
         rsvppresenx = CASE
                           WHEN rsmonemi=13 THEN ROUND(valpteman*(rsnominal/nominal),2)
                           ELSE ROUND(valpteman*(rsnominal/nominal),0)
                       END               ,--4
         rscupamo = CASE
                        WHEN rsmonemi=13 THEN ROUND(amocup *(rsnominal/nominal),2)
                        ELSE ROUND(amocup *(rsnominal/nominal),0)
                   END                  ,--5
         rscupint = CASE
                        WHEN rsmonemi=13 THEN ROUND(intcup *(rsnominal/nominal),2)
                        ELSE ROUND(intcup *(rsnominal/nominal),0)
                      END               , --6
         rscuprea = CASE
                        WHEN rsmonemi=13 THEN ROUND(reacup *(rsnominal/nominal),2)
   			ELSE ROUND(reacup *(rsnominal/nominal),0)
                   END                             ,--7
         rsflujo  = CASE
         WHEN rsmonemi=13 THEN ROUND(flujo  *(rsnominal/nominal),2)
                        ELSE ROUND(flujo  *(rsnominal/nominal),0)
                    END                            ,--8
         rstasfloat = tasa_float                   ,--9
         rstasemi   = isnull(tasemi,0.0)           ,--12
         rsbasemi   = ISNULL(basemi,0.0)           ,--13
         rsinteres  =  CASE
        WHEN rsmonemi=13 THEN ROUND(intdia  *(rsnominal/nominal),2)
                        ELSE ROUND(intdia  *(rsnominal/nominal),0)
                       END                         ,--14
 rsreajuste = ROUND(readia  *(rsnominal/nominal),0)  ,--15
         rsintermes = CASE
                        WHEN rsmonemi=13 THEN isnull( ROUND(interesmes  *(rsnominal/nominal),2), 0 )
                        ELSE ROUND(interesmes  *(rsnominal/nominal),0)
            END                           ,--16
         rsreajumes = ROUND(reajustemes  *(rsnominal/nominal),0) ,--17
         rsinteres_acum =  (CASE
    WHEN rsmonemi=13 THEN ISNULL( ROUND(interes *(rsnominal/nominal),2), 0 )
                              ELSE ISNULL( ROUND(interes *(rsnominal/nominal),0), 0 )
                             END)                   ,--18
         rsreajuste_acum = isnull( ROUND(reajuste*(rsnominal/nominal),0), 0 )  ,--19
         rsforpagv = 0.0                            ,--20
         rsvalcomp = CASE
                        WHEN rscodigo=13 AND cupon=1 THEN ROUND(valcomp *(rsnominal/nominal),2)
                        WHEN rscodigo<>13 AND cupon=1 THEN ROUND(valcomp *(rsnominal/nominal),0)
                     ELSE rsvalcomp
                     END               ,--21
         rsvalcomu = CASE WHEN rscodigo=13 AND cupon=1 THEN ROUND(valcomu *(rsnominal/nominal),2)
                          WHEN monemi=999 AND cupon=1  THEN ROUND(valcomu *(rsnominal/nominal),0)
                          WHEN monemi<>999 AND cupon=1 THEN ROUND(valcomu *(rsnominal/nominal),4)
                          ELSE ISNULL(rsvalcomu,1)      END            ,--22
         rsdurat   = duration        ,--23
         rsdurmod  = durmodif        ,--24
         rsconvex  = convex          ,--25
         rsnumucup = numucup         ,--26
         rsnumpcup = numpcup         ,--27
         rsfecucup = fecucup         ,--28
         rsfecpcup = fecpcup         ,--29
         rsvpcomp  = pvpcomp         ,--30
         rsdifrea  = ISNULL(readifmes,0)       ,--31
         rsvalvenc = CASE
                        WHEN @cSeriado='N' AND rscodigo<>888 THEN rsnominal
                        WHEN rscodigo<>888 THEN ROUND((cup*rsnominal)/100.0,4)
                        eLSE cup
                   END,                --32
        prima_descuento_total =  CASE
                        		WHEN rsmonemi=13 THEN isnull( ROUND(PrimaDcto  *(rsnominal/nominal),2), 0 )
                        		ELSE ROUND(PrimaDcto  *(rsnominal/nominal),0)
                      	       END  ,   --33
        prima_descuento_dia  = CASE
                        	WHEN rsmonemi=13 THEN isnull( ROUND(valordia *(rsnominal/nominal),2), 0 )
                        	ELSE ROUND(valordia *(rsnominal/nominal) * DATEDIFF(day, @dFechoy, @dFecprox),0)
                      	      END ,    --34
        valor_tasa_emision    = CASE
                        		WHEN rsmonemi=13 THEN isnull( ROUND(tasaEmis *(rsnominal/nominal),2), 0 )
                        		ELSE ROUND(tasaEmis *(rsnominal/nominal),0)
                      	        END     , --35
	valor_par             =  valorpar
	

     FROM #TEMPORAL

     WHERE rsrutcart=rutcart AND rstipcart=tipcart AND rsinstser=instser AND rsfeccomp=feccomp AND
         rstir=tircomp AND rsfecha=@dFecprox AND (rscartera='111' OR rscartera='114') AND
         numdocu=rsnumdocu AND correla=rscorrela

  IF @@ERROR<>0
  BEGIN

   SELECT 'NO','Problemas al Actualizar Tabla MDRS con Devengamiento'
   RETURN
  END
  SELECT *
  INTO #TEMPORAL2
  FROM MDRS
  WHERE rsfecha=@dFecprox AND rstipoper='DEV' AND rsflujo>0 AND (rscartera='111' OR rscartera='114') AND
CHARINDEX(STR(rsmonemi,3),CASE WHEN @cDevengo_dolar='N' THEN '997-998-999' ELSE '988-994-995- 13' END)>0
  IF @@ERROR<>0
  BEGIN

   SELECT 'NO','Problemas al Generar Temporal con Vencimientos'
   RETURN
  END
  UPDATE #TEMPORAL2 SET rstipoper='VC'

  INSERT INTO MDRS SELECT * FROM #TEMPORAL2
  IF @@ERROR<>0
  BEGIN

   SELECT 'NO','Problemas al Insertar Vencimientos al MDRS'
   RETURN
  END
  UPDATE mdrs
  SET rsflujo=rscupamo+rscupint+rscuprea
  WHERE rstipoper = 'VC' AND rsfecha = @dFecprox 
  IF @@ERROR<>0
  BEGIN

   SELECT 'NO','Problemas al Insertar Vencimientos al MDRS'
   RETURN
  END
  SELECT @ix  = 1
  SELECT @nContador = COUNT(*)
  FROM MDRS
  WHERE rsfecha=@dFecprox AND rstipoper='VC' AND (rscartera='111' OR rscartera='114') AND
   CHARINDEX(STR(rsmonemi,3),CASE WHEN @cDevengo_dolar='N' THEN '997-998-999' ELSE '988-994-995- 13' END)>0
  IF @nContador>0
  BEGIN
   WHILE @ix<=@nContador
   BEGIN
    SELECT @cInstser = '*'
    SET ROWCOUNT @ix
    SELECT    @cInstser = rsinstser             ,
              @nRutcart = rsrutcart             ,
              @cCartera = rscartera             ,
              @nNumdocu = rsnumdocu             ,
              @nNumoper = rsnumoper             ,
              @nCorrela = rscorrela             ,
              @nValcomp = rsvalcompcp           ,
              @fValcomu = rsvalcomucp           ,
              @nInteres = rsinteres_acumcp      ,
              @nReajuste = rsreajuste_acumcp    ,
              @nIntdia  = rsinteres             ,
              @nReadia  = rsreajuste            ,
              @cSeriado = inmdse
    FROM MDRS, VIEW_INSTRUMENTO
    WHERE rsfecha=@dFecprox AND rstipoper='VC' AND (rscartera='111' OR rscartera='114') AND
          rscodigo=incodigo AND
          CHARINDEX(STR(rsmonemi,3),CASE WHEN @cDevengo_dolar='N' THEN '997-998-999' ELSE '988-994-995- 13' END)>0

    SET ROWCOUNT 0
    SELECT @ix = @ix + 1
    IF @cInstser='*'
        BREAK
    UPDATE MDRS

    SET rsvalcomp = @nValcomp                    ,
        rsvalcomu = @fValcomu                    ,
        rsinteres_acum = @nInteres+@nIntdia      ,
        rsreajuste_acum = @nReajuste+@nReadia    ,
        rscupamo = 0                             ,
        rscupint = 0                             ,
        rscuprea = 0 ,
        rsvppresenx = CASE WHEN @cSeriado='N' THEN 0
                           ELSE rsvppresenx
                      END
    WHERE rsfecha=@dFecprox AND rscartera=@cCartera AND rstipoper='DEV' AND rsnumdocu=@nNumdocu AND
       rsnumoper=@nNumoper AND rscorrela=@nCorrela
    IF @@ERROR<>0
    BEGIN

     SELECT 'NO','Problemas al Actualizar Tabla MDRS con K Devengamiento'
     RETURN
    END
   END
  END
  UPDATE MDRS
  SET rsrutemis = nsrutemi
  FROM VIEW_INSTRUMENTO, VIEW_NOSERIE
  WHERE rscodigo=incodigo AND inmdse='N' AND rsrutcart=nsrutcart AND rsnumoper=nsnumdocu AND rscorrela=nscorrela and rsfecha = @dFecprox
  UPDATE MDRS
  SET rsrutemis = serutemi
  FROM VIEW_INSTRUMENTO, VIEW_SERIE
  WHERE rscodigo=incodigo AND inmdse='S' AND rsmascara=semascara and rsfecha = @dFecprox

  EXECUTE SP_BUSCA_TASA @dFecprox,@dFecpcup,@dFechoy
                                       
  UPDATE MDAC SET acsw_dvprop='1'

  SELECT 'SI','Proceso de Devengamiento ha finalizado en forma correcta'
  SET NOCOUNT OFF
  RETURN
END

GO
