USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEVENGOPASIVO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DEVENGOPASIVO]
    (
    @dFechoy DATETIME ,
    @dFecprox DATETIME ,
    @fTe_pcdus FLOAT    ,
    @fTe_pcduf FLOAT    ,
    @fTe_ptf FLOAT    ,
    @cDevengo_dolar CHAR (01)
    )
AS
BEGIN
  SET NOCOUNT ON
 DECLARE @cProg  CHAR (10) ,
  @iModcal INTEGER  ,
  @iCodigo INTEGER  ,
    @cInstser CHAR (10) ,
    @iMonemi INTEGER  ,
    @dFecemi DATETIME ,
    @dFecven DATETIME ,
    @fTasemi FLOAT  ,
    @fBasemi FLOAT  ,
    @fTasest FLOAT  ,
    @fNominal FLOAT  ,
    @fTir  FLOAT  ,
    @fPvp  FLOAT  ,
    @fMT  FLOAT  ,
   @fMTUM  FLOAT  ,
    @fMT_cien FLOAT  ,
    @fVan  FLOAT  ,
    @fVpar  FLOAT  ,
    @nNumucup INTEGER  ,
    @dFecucup DATETIME ,
    @fIntucup FLOAT  ,
    @fAmoucup FLOAT  ,
    @fSalucup FLOAT  ,
    @nNumpcup INTEGER  ,
    @dFecpcup DATETIME ,
    @fIntpcup FLOAT  ,
    @fAmopcup FLOAT  ,
    @fSalpcup FLOAT  ,
    @fDurat  FLOAT  ,
    @fConvx  FLOAT  ,
    @fDurmo  FLOAT  ,
    @nError  INTEGER  ,
    @fMt_emis FLOAT
 DECLARE @fNomiReal FLOAT  ,
    @fValmon_Hoy FLOAT  ,
    @fValmon_Man FLOAT  ,
    @fValmon_Com FLOAT  ,
    @fValmon_Cup FLOAT  ,
    @iCupon  INTEGER  ,
   @fCapital FLOAT  ,
    @fCapital_UM FLOAT  ,
    @fFactor FLOAT  ,
    @fValcupo FLOAT  ,
    @fIntcupo FLOAT  ,
    @fAmocupo FLOAT  ,
    @nReacup NUMERIC (19,4) ,
   @nIntcup NUMERIC (19,4) ,
    @nDifcup NUMERIC (19,4) ,
    @nPagCupo NUMERIC (19,4) ,
    @nPagCup NUMERIC (19,4) ,
    @nDifReaCup NUMERIC (19,0)
 DECLARE @nRutcart NUMERIC (09,0) ,
    @nTipcart NUMERIC (05,0) ,
    @nNumdocu NUMERIC (10,0) ,
  @nNumoper NUMERIC (10,0) ,
    @nCorrela NUMERIC (03,0) ,
    @nValcomp NUMERIC (19,4) ,
    @fValcomu FLOAT  ,
  @dFeccomp DATETIME ,
    @nVpresen NUMERIC (19,4) ,
    @cMascara CHAR (10) ,
    @cSeriado CHAR (01) ,
    @cCartera CHAR (03) ,
    @nInteres NUMERIC (19,4) ,
    @nReajuste NUMERIC (19,0) ,
    @nIntMes NUMERIC (19,4) ,
    @nReaMes NUMERIC (19,0) ,
    @nIntdia NUMERIC (19,4) ,
    @nReadia NUMERIC (19,0) ,
    @fTasaFloat FLOAT  ,
    @nInteres_emis NUMERIC (19,4) ,
   @nReajuste_emis NUMERIC (19,0) ,
    @nValcomp_emis NUMERIC (19,4) ,
    @fValcomu_emis FLOAT  ,
    @nVpresen_emis  NUMERIC(19,4) ,
    @nIntdia_emis NUMERIC (19,4) ,
    @nReadia_emis NUMERIC (19,0) ,
    @fNominal_resi FLOAT  
  DECLARE @nMes  INTEGER  ,
    @nAno  INTEGER  ,
    @nMes_a  INTEGER  ,
    @iAst  INTEGER  ,
    @cMes  CHAR (02) ,
    @cAno  CHAR (04) ,
    @dFecpro DATETIME ,
    @iPago_Nohabil INTEGER  ,
    @sw_contab CHAR (01) ,
    @sw_deven CHAR (01) ,
    @iX  INTEGER  ,
    @nContador INTEGER  ,
    @dFecDevengo DATETIME ,
    @nValorpara FLOAT 
        --** Guarda Fecha de Devengo segun dolar **--
  IF @cDevengo_dolar='S'
    IF NOT EXISTS(SELECT * FROM MDPASIVO WHERE CHARINDEX(RTRIM(cpmonemi),'995-994')>0)
    BEGIN
      SELECT 'SI','No Existen Documentos en dolares'
      RETURN
    END
  ELSE
    SELECT @dFecDevengo = @dFecHoy
   --** Revision de Switch's y Respaldo automatico **--
   UPDATE MDAC SET acsw_pc='1'
  SELECT @sw_contab = acsw_co ,
         @sw_deven = acsw_dvprop ,
         @dFecpro = acfecproc
  FROM MdAc
   --** Variables Chequeo Fin de Mes no Habil **--
   SELECT @iX  = 0  ,
   @nMes  = 0  ,
   @cMes  = ''
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
   BEGIN TRANSACTION
    IF @cDevengo_dolar='N'
    BEGIN
       DELETE FROM MDRS
       WHERE rsfecha=@dFecprox AND (rscartera='211') AND
       (rsmonemi=999 OR rsmonemi=998 OR rsmonemi=997)
  
   IF @@ERROR<>0
   BEGIN
    ROLLBACK TRANSACTION
    SELECT 'NO','No se pudieron eliminar registros de tabla Resultado'
    RETURN
   END
  END
  ELSE
  BEGIN
   DELETE FROM MDRS
   WHERE (rsmonemi<>999 AND rsmonemi<>998 AND rsmonemi<>997) AND rsfecha=@dFecprox AND
    (rscartera='211' ) --OR rscodigo<>13
   IF @@ERROR<>0
   BEGIN
    ROLLBACK TRANSACTION
    SELECT 'NO','No se pudieron eliminar registros de tabla Resultado'
    RETURN
   END
  END
      -- D E V E N G A M I E N T O   C A R T E R A    P R O P I A    D I S P O N I B L E    E    I N T E R M E D I A D A  --  
      -- ________________________________________________________________________________________________________________ --
  SELECT 'rutcart' = cprutcart   ,
   'tipcart' = cptipcart   ,
   'instser' = cpinstser   ,
   'instcam' = cpinstser   ,
   'mascara' = cpmascara   ,
   'feccomp' = cpfeccol   ,
   'tircomp' = cptircol   ,
   'nominal' = SUM(cpnominal)  ,
   'valcomp' = SUM(cpvalcol)   ,
   'valcomu' = SUM(cpvalcomu)  ,
   'intdia' = CONVERT(NUMERIC(19,4),0) ,
   'readia' = CONVERT(NUMERIC(19,4),0) ,
   'interes' = SUM(cpinteres_col)  ,
   'reajuste' = SUM(cpreajust_col)  ,--sp_help mdpasivo
   'readifmes' = CONVERT(NUMERIC(19,4),0) ,
   'seriado' = cpseriado   ,
   'codigo' = cpcodigo   ,
   'valptehoy' = SUM(cpvptircol)  ,
   'valpteman' = CONVERT(NUMERIC(19,2),0) ,
   'amocup' = CONVERT(FLOAT,0)  ,
   'intcup' = CONVERT(FLOAT,0)  ,
   'reacup' = CONVERT(FLOAT,0)  ,
   'flujo'  = CONVERT(FLOAT,0)  ,
   'duration' = CONVERT(FLOAT,0)  ,
   'durmodif' = CONVERT(FLOAT,0)  ,
   'convex' = CONVERT(FLOAT,0)  ,
   'tasa_float' = CONVERT(FLOAT,0)  ,
   'monemi' = CONVERT(INTEGER,0)  ,
   'basemi' = CONVERT(FLOAT,0)  ,
   'tasemi' = CONVERT(FLOAT,0)  ,
   'fecemi' = cpfecemi   ,
   'fecven' = cpfecven   ,
   'cupon'  = CONVERT(INTEGER,0)  ,
   'pvpcomp' = CONVERT(FLOAT,0)  ,
   'numucup' = CONVERT(FLOAT,0)  ,
   'numpcup' =  CONVERT(FLOAT,0)  ,
   'fecucup' = cpfecucup   ,
   'fecpcup' = cpfecpcup   ,
   'condpacto' = CONVERT(CHAR(01),'')  ,
   'flag'  = CONVERT(CHAR(01),'N')  ,
   'cup'  = CONVERT(NUMERIC(19,4),0) ,
   'interes_emis' = SUM(cpinteres_emis)  ,
   'reajuste_emis' = SUM(cpreajust_emis)  ,
   'intdia_emis' = CONVERT(NUMERIC(19,4),0) ,
   'readia_emis' = CONVERT(NUMERIC(19,4),0) ,
   'valptehoy_emis'= SUM(cpvpemis)   ,
   'valpteman_emis'= CONVERT(NUMERIC(19,2),0) ,
   'valcomp_emis' = SUM(cpvalemis)  ,
   'valcomu_emis' = SUM(cpvalemimu)  ,
   'nominal_resi'  = SUM(cpnominal_r)  
  INTO #TEMPORAL
  FROM MDPASIVO
  WHERE cprutcart>0 AND cpcodigo<>98
  GROUP BY cprutcart,cptipcart,cpinstser,cpmascara,cpfeccol,cptircol,cpseriado,cpcodigo,cpfecemi,cpfecven,cpfecucup,cpfecpcup
  IF @@ERROR<>0
  BEGIN
   ROLLBACK TRANSACTION
   SELECT 'NO','No se Puede Generar Tabla Temporal de Paso con CP para Devengamiento'
   RETURN
  END
  IF @dFechoy<>@dFecpro
  BEGIN
   UPDATE  #TEMPORAL
          SET valptehoy = (SELECT ISNULL(SUM(rsvppresenx),0) FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='211' AND rstipopero='CPP' AND rsfecha=@dFecHoy)  ,
    interes  = (SELECT ISNULL(SUM(rsinteres_acum),0) FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='211' AND rstipopero='CPP' AND rsfecha=@dFecHoy)  ,
    reajuste = (SELECT ISNULL(SUM(rsreajuste_acum),0) FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='211' AND rstipopero='CPP' AND rsfecha=@dFecHoy)  ,
    valptehoy_emis = (SELECT ISNULL(SUM(rsvppresenx_emis),0) FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='211' AND rstipopero='CPP' AND rsfecha=@dFecHoy) ,
    interes_emis = (SELECT ISNULL(SUM(rsinteres_acum_emis),0) FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='211' AND rstipopero='CPP' AND rsfecha=@dFecHoy) ,
    reajuste_emis = (SELECT ISNULL(SUM(rsreajuste_acum_emis),0) FROM MDRS WHERE rutcart=rsrutcart AND instser=rsinstser AND feccomp=rsfeccomp AND tircomp=rstir AND rscartera='211' AND rstipopero='CPP' AND rsfecha=@dFecHoy)
  END
  IF @@ERROR<>0
  BEGIN
   ROLLBACK TRANSACTION
   SELECT 'NO','No se Puede Actualizar Tabla Temporal con VI del Devengamiento'
   RETURN
  END
  DELETE #TEMPORAL WHERE nominal<=0
  SELECT @iX  = 1 
  SELECT @nContador = COUNT(*) FROM #TEMPORAL WHERE nominal>0 AND fecven>=@dFechoy
  WHILE @iX<=@nContador
  BEGIN
   SELECT @cInstser = '*'
   SET ROWCOUNT 1
   SELECT  @nRutcart = rutcart  ,
    @nTipcart = tipcart  ,
    @cInstser = instser  ,
    @fNominal = nominal  ,
    @fTir  = tircomp  ,
    @iCodigo = codigo  ,
    @dFecemi = fecemi  ,
    @dFecven = fecven  ,
    @fTasest = tasa_float  ,
    @nValcomp = valcomp  ,
    @fValcomu = valcomu  ,
    @nVpresen = valptehoy  ,
    @nInteres = interes  ,
    @nReajuste = reajuste  ,
    @fPvp  = pvpcomp  ,
    @fMt  = 0.0   ,
    @fMtum  = 0.0   ,
    @fMt_cien = 0.0   ,
    @fVan  = 0.0   ,
    @fVpar  = 0.0   ,
    @nNumucup = 0   ,
    @dFecucup = ISNULL(fecucup,'') ,
    @fIntucup = 0.0   ,
    @fAmoucup = 0.0   ,
    @fSalucup = 0.0   ,
    @nNumpcup = 0   ,
    @dFecpcup = ISNULL(fecpcup,'') ,
    @fIntpcup = 0.0   ,
    @fAmopcup = 0.0   ,
    @fSalpcup = 0.0   ,
    @iAst  = 0   ,
    @iPago_NoHabil = 0   ,
    @cSeriado = seriado  ,
    @cMascara = mascara  ,
    @dFeccomp = feccomp  ,
    @cProg  = 'SP_'+inprog  ,
    @fDurat  = 0.0   ,
    @fConvx  = 0.0   ,
    @fDurmo  = 0.0   ,
    @fValmon_Hoy = 1.0   ,
    @fValmon_Man = 1.0   ,
    @fValmon_Com = 1.0   ,
    @fValmon_Cup = 1.0   ,
    @iMonemi = 0   ,
    @fTasemi = 0.0   ,
    @fBasemi = 0.0   ,
    @fTasest = 0.0   ,
    @nError  = 0   ,
    @iCupon  = 0   ,
    @fTasaFloat = 0.0   ,
    @iModcal = 2   ,
    @fAmocupo = 0.0   ,
    @fIntcupo = 0.0   ,
    @nReacup = 0.0   ,
    @nDifReaCup = 0.0   ,
    @nPagcup = 0.0   ,
    @fAmocupo = 0.0   ,
    @fValcupo = 0.0   ,
    @nIntcup = 0.0   ,
    @nReacup = 0.0   ,
    @nPagcup = 0.0   ,
    @nIntdia = 0.0   ,
    @nReadia = 0.0   ,
    @nInteres_emis = interes_emis  ,
    @nReajuste_emis = reajuste_emis  ,
    @nValcomp_emis = valcomp_emis  ,
    @fValcomu_emis = valcomu_emis  ,
    @nVpresen_emis = valptehoy_emis ,
    @nIntdia_emis = 0.0   ,
    @nReadia_emis = 0.0   ,
    @fNominal_resi = nominal_resi   
   FROM #TEMPORAL, VIEW_INSTRUMENTO
   WHERE (nominal>0 AND fecven>=@dFechoy) AND codigo=incodigo AND flag<>'S'
   SET ROWCOUNT 0
   SELECT @iX = @iX + 1
   IF @cInstser='*'
    BREAK
   IF @cSeriado='S'
    SELECT @fTasemi = setasemi ,
     @iMonemi = semonemi ,
     @fBasemi = sebasemi
    FROM VIEW_SERIE
    WHERE semascara=@cMascara
   ELSE
   BEGIN
    SET ROWCOUNT 1
    SELECT @fTasemi = nstasemi ,
     @iMonemi = nsmonemi ,
     @fBasemi = nsbasemi
    FROM VIEW_NOSERIE
    WHERE nsserie=@cInstser
    SET ROWCOUNT 0
   END
   IF @cDevengo_dolar='S'
   BEGIN
    IF @iMonemi<>994 AND @iMonemi<>995 AND @iMonemi<>988 AND @iMonemi<>13
    BEGIN
     DELETE FROM #TEMPORAL
     WHERE @nRutcart=rutcart AND @cInstser=instser AND @dFeccomp=feccomp AND @fTir=tircomp
     CONTINUE
     IF @@ERROR<>0
     BEGIN
      ROLLBACK TRANSACTION
      SELECT 'NO','Problemas al Borrar Operaciones desde Temporal'
      RETURN
     END
    END
   END
   ELSE
   BEGIN
    IF @iMonemi=994 OR @iMonemi=995 OR @iMonemi=988 OR @iMonemi=13
    BEGIN
     DELETE FROM #TEMPORAL
     WHERE @nRutcart=rutcart AND @cInstser=instser AND @dFeccomp=feccomp AND @fTir=tircomp
     CONTINUE
     IF @@ERROR<>0
     BEGIN
      ROLLBACK TRANSACTION
      SELECT 'NO','Problemas al Borrar Operaciones desde Temporal'
      RETURN
     END
    END
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
    --** Valorizaci¢n a Pr¢ximo Proceso **--
    EXECUTE @nError = @cProg @iModcal, @dFecprox, @iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest,
      @fNominal OUTPUT, @fTir OUTPUT, @fPvp OUTPUT, @fMt OUTPUT, @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,
      @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
      @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT
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
      IF @dFecucup<>@dFecprox
       SELECT @nPagcupo = ROUND( (@fIntucup + @fAmoucup) * @fValmon_Man, 0)
      ELSE
       SELECT @nPagcupo = ROUND( (@fIntucup + @fAmoucup) * @fValmon_Cup, 0)
      SELECT @fValcupo = @fIntcupo + @fAmocupo
     END
    END
    SELECT @nReadia   = ROUND(( @fValmon_Man - @fValmon_Hoy ) * @fValcomu, 0)
    SELECT @nIntdia   = @fMt - @nVpresen - @nReadia + @nPagcup
    SELECT @nInteres  = @nInteres  + @nIntdia
    SELECT @nReajuste = @nReajuste + @nReadia
    SELECT  @fNominal_resi = ((@fnominal * (select tdsaldo from view_tabla_desarrollo where tdmascara = @cMascara and tdfecven =@dFecucup) )/ 100)    
    --** Capitalizacion **--
    IF @iCupon=1
    BEGIN
     IF @cSeriado='S'
     BEGIN
      SELECT @fFactor = ((( @fIntucup * @fValmon_Cup ) - @nInteres ) / @fValmon_Cup)
      SELECT @fCapital_UM = @fAmoucup + @fFactor
      SELECT @fCapital = ROUND( @fCapital_UM * @fValmon_Com , 0)
      SELECT @nReacup = ROUND( (@fValmon_Cup-@fValmon_Com) * @fCapital_UM , 0 )
      SELECT @nIntcup = @nInteres
      SELECT @nDifcup = @nPagcup - ( @fCapital + @nReacup + @nIntcup )
      SELECT @fCapital = @fCapital + @nDifcup
      SELECT @nReacup = @nReacup + ROUND( (@fValmon_Man-@fValmon_Cup) * @fCapital_UM , 0 )
      SELECT @nIntcup = @nPagcup - @fCapital - @nReacup
      SELECT @fAmocupo = @fCapital
      SELECT @nDifReaCup = @nPagcupo-(@fAmocupo+@nIntcup+@nReacup)
      SELECT @nPagcup = @nPagcupo
     END
     ELSE
     BEGIN
      SELECT @fAmocupo = @nValcomp
      SELECT @fValcupo = @nValcomp + @nInteres + @nReajuste
      SELECT @nIntcup = @nInteres ,
       @nReacup = @nReajuste ,
       @nPagcup = @fValcupo
     END
    END
   END
   IF @iCupon=1 AND @cSeriado='S'
   BEGIN
    SELECT @nReajuste = @nReajuste - @nReacup
    SELECT @nValcomp = @nValcomp  - @fCapital
    SELECT @fValcomu = ROUND( @nValcomp / @fValmon_com ,4 )
    IF @iPago_NoHabil=0
     SELECT @nInteres = 0.0
   END
   
   UPDATE #TEMPORAL
   SET instser  = @cInstser ,
    valcomp  = @nValcomp ,
    valcomu  = @fValcomu ,
    intdia  = @nIntdia ,
    readia  = @nReadia ,
    interes  = @nInteres ,
    reajuste = @nReajuste ,
    readifmes = @nDifReaCup ,
    valptehoy = @nVpresen ,
    valpteman = @fMt  ,
    amocup  = @fAmocupo ,
    intcup  = @nIntcup ,
    reacup  = @nReacup ,
    flujo  = @nPagcup ,
    duration = @fDurat ,
    durmodif = @fDurmo ,
    convex  = @fConvx ,
    tasa_float = @fTasaFloat ,
    tasemi  = @fTasemi ,
    monemi  = @iMonemi ,
    basemi  = @fBasemi ,
    cupon  = @iCupon ,
    pvpcomp  = @fPvp  ,
    numucup  = @nNumucup ,
    numpcup  = @nNumpcup ,
    fecucup  = @dFecucup ,
    fecpcup  = @dFecpcup ,
    flag  = 'S'  ,
    cup  = @fIntpcup+@fAmopcup,
    nominal_resi = @fnominal_resi
   WHERE @nRutcart=rutcart AND @cInstser=instser AND @dFeccomp=feccomp AND @fTir=tircomp
 
   IF @@ERROR<>0
   BEGIN
    ROLLBACK TRANSACTION
    SELECT 'NO','Problemas al Actualizar Tabla Temporal de Devengamiento'
    RETURN
   END 
   --** Valorizaci¢n a Pr¢ximo Proceso MODO 1  **--
   SELECT @iModcal = 1 ,
    @fPvp  = 100
   EXECUTE @nError = @cProg @iModcal, @dFecprox, @iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest,
    @fNominal OUTPUT, @fTir OUTPUT, @fPvp OUTPUT, @fMt OUTPUT, @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,
    @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
    @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT
   SELECT @nReadia_emis   = ROUND(( @fValmon_Man - @fValmon_Hoy ) * @fValcomu_emis, 0)
   SELECT @nIntdia_emis   = @fMt - @nVpresen_emis - @nReadia_emis + @nPagcup
   SELECT @nInteres_emis  = @nInteres_emis  + @nIntdia_emis
   SELECT @nReajuste_emis = @nReajuste_emis + @nReadia_emis
   IF @iCupon=1 AND @cSeriado='S'
   BEGIN
    SELECT @nReajuste_emis = @nReajuste_emis - @nReacup
    SELECT @nValcomp_emis = @nValcomp_emis  - @fCapital
    SELECT @fValcomu_emis = ROUND( @nValcomp_emis / @fValmon_com ,4 )
    IF @iPago_NoHabil=0
     SELECT @nInteres_emis = 0.0
   END
   UPDATE #TEMPORAL
   SET interes_emis = @nInteres_emis , 
    reajuste_emis = @nReajuste_emis ,
    valptehoy_emis = @nVpresen_emis ,
    valpteman_emis = @fMt   ,
    intdia_emis = @nintdia_emis  ,
    readia_emis = @nreadia_emis  
   WHERE @nRutcart=rutcart AND @cInstser=instser AND @dFeccomp=feccomp AND @fTir=tircomp
   
   IF @@ERROR<>0
   BEGIN
    ROLLBACK TRANSACTION
    SELECT 'NO','Problemas al Actualizar Tabla Temporal de Devengamiento'
    RETURN
   END
  END
  INSERT INTO MDRS
   (
   rsfecha  ,-- 1
   rsrutcart ,-- 2
   rstipcart ,-- 3
   rsnumdocu ,-- 4
   rscorrela ,-- 5 
   rsnumoper ,-- 6
   rscartera ,-- 7
   rstipoper ,-- 8
   rsinstser ,-- 9
   rsrutcli ,-- 10
   rscodcli ,-- 11
   rsvppresen ,-- 12
   rsvppresenx ,-- 13
   rscupamo ,-- 14
   rscupint ,-- 15
   rscuprea ,-- 16
   rsflujo  ,-- 17
   rsfecprox ,-- 18
   rsfecctb ,-- 19
   rsnominal ,-- 20
   rstir  ,-- 21
   rstasfloat ,-- 22
   rsmonpact ,-- 23
   rsmonemi ,-- 24
   rstasemi ,-- 25
   rsbasemi ,-- 26
   rscodigo ,-- 27
   rsinteres ,-- 28
   rsreajuste ,-- 29
   rsintermes ,-- 30
   rsreajumes ,-- 31
   rsinteres_acum ,-- 32
   rsreajuste_acum ,-- 33
   rsforpagv ,-- 34
   rsvalcomp ,-- 35
   rsvalcomu ,-- 36
   rsvalvenc ,-- 37
   rsdurat  ,-- 38
   rsdurmod ,-- 39
   rsconvex ,-- 40
   rsnumucup ,-- 41
   rsnumpcup ,-- 42
   rsfecucup ,-- 43
   rsfecpcup ,-- 44
   rsvpcomp ,-- 45
   rstipopero ,-- 46
   rsfeccomp ,-- 47
   rsdifrea ,-- 48
   rsinstcam ,-- 49
   rsfecinip ,-- 50  
   rsfecvtop ,-- 51  
   rsvalvtop ,-- 52  
   rsrutemis  ,-- 53 
   rsvalinip ,-- 54 
   rstaspact ,-- 55
   rsmascara ,-- 56
   rsfecemis ,-- 57
   rsfecvcto ,-- 58
   rstipoletra ,-- 59
   rsvalcompcp ,-- 60
   rsvalcomucp ,-- 61
   rsinterescp ,-- 62
   rsreajustecp ,-- 63
   rsinteres_acumcp , -- 64
   rsreajuste_acumcp ,  -- 65
   rsvalor_emis  ,--66
   rsvalorum_emis  , --67
   rsvpresen_emis  , --68
   rsnominal_resi  --69
   )
  SELECT
   @dFecprox ,-- 1 rsfecha,rsrutcart,rstipcart,rsnumdocu,rscorrela,rsnumoper,rscartera,rstipoper
   cprutcart ,-- 2 
   cptipcart ,-- 3
   cpnumdocu ,-- 4
   cpcorrela ,-- 5
   cpnumdocu ,-- 6
   '211'  ,-- 7
   'DEV'  ,-- 8
   cpinstser ,-- 9
   0  ,-- 10
   0  ,-- 11
   cpvptircol ,-- 12 rsvppresen
   0.0  ,-- 13 rsvppresenx
   0.0  ,-- 14 rscupamo
   0.0  ,-- 15 rscupint
   0.0  ,-- 16 rscuprea
   0.0  ,-- 17 rsflujo
   @dFecprox ,-- 18
   @dFechoy ,-- 19
   cpnominal ,-- 20
   cptircol ,-- 21
   0.0  ,-- 22 rstasfloat
   mncodmon ,-- 23 rsmonpact
   mncodmon ,-- 24 rsmonemi  
   0.0  ,-- 25 rstasemi
   0.0  ,-- 26 rsbasemi
   cpcodigo ,-- 27
   0.0  ,-- 28 rsinteres
   0.0  ,-- 29 rsreajuste
   0.0  ,-- 30 rsintermes
   0.0  ,-- 31 rsreajumes
   0.0  ,-- 32 rsinteres
   0.0  ,-- 33 rsreajuste
   0  ,-- 34 rsforpagv
   cpvalcol ,-- 35
   cpvalcomu ,-- 36
   0  ,-- 37 rsvalvenc
   0.0  ,-- 38 rsdurat
   0.0  ,-- 39 rsdurmod
   0.0  ,-- 40 rsconvex
   0.0  ,-- 41 rsnumucup
   0.0  ,-- 42 rsnumpcup
   ''  ,-- 43 rsfecucup
   ''  ,-- 44 rsfecpcup
   0.0  ,-- 45 rsvpcomp
   'CPP'  ,-- 46
   cpfeccol ,-- 47
   0.0  ,-- 48 rsdifrea
   ''  ,-- 49 rsinstcam
   ''  ,-- 50
   ''  ,-- 51
   0.0  ,-- 52
   0.0  ,-- 53
   0.0  ,-- 54
   0.0  ,-- 55
   cpmascara ,-- 56
   cpfecemi ,-- 57
   cpfecven ,-- 58
   ' '  ,-- 59
   cpvalcol ,-- 60
   cpvalcomu ,-- 61
   0  ,-- 62
   0  ,-- 63
   0  ,-- 64
   0  , -- 65
   cpvalemis ,--66
   cpvalemimu  , --67
   cpvpemis ,--68
   cpnominal_r --69
  FROM  MDPASIVO , VIEW_MONEDA
  WHERE cpnominal>0  AND cpmonemi=mncodmon AND
   CHARINDEX(STR(mncodmon,3),CASE WHEN @cDevengo_dolar='N' THEN '997-998-999' ELSE '988-994-995- 13' END)>0
  IF @@ERROR<>0
  BEGIN
   ROLLBACK TRANSACTION
   SELECT 'NO','Problemas al Insertar Operaciones CP al MDRS'
   RETURN
  END
  UPDATE MDRS 
  SET rsinstser = rsinstser     ,--1
   rsvppresen = CASE
      WHEN rsmonemi=13 THEN ROUND(valptehoy*(rsnominal/nominal),2)
      ELSE ROUND(valptehoy*(rsnominal/nominal),0)
       END      ,--3
   rsvppresenx = CASE
      WHEN rsmonemi=13 THEN ROUND(valpteman*(rsnominal/nominal),2)
      ELSE ROUND(valpteman*(rsnominal/nominal),0)
       END      ,--4
   rsvppresenx_emis= CASE
      WHEN rsmonemi=13 THEN ROUND(valpteman_emis*(rsnominal/nominal),2)
      ELSE ROUND(valpteman_emis*(rsnominal/nominal),0)
       END      ,--4
   rscupamo = CASE
      WHEN rsmonemi=13 THEN ROUND(amocup *(rsnominal/nominal),2)
      ELSE ROUND(amocup *(rsnominal/nominal),0)
       END      ,--5
   rscupint = CASE
      WHEN rsmonemi=13 THEN ROUND(intcup *(rsnominal/nominal),2)
      ELSE ROUND(intcup *(rsnominal/nominal),0)
       END      ,--6
   rscuprea = CASE
      WHEN rsmonemi=13 THEN ROUND(reacup *(rsnominal/nominal),2)
      ELSE ROUND(reacup *(rsnominal/nominal),0)
       END      ,--7
   rsflujo  = CASE
      WHEN rsmonemi=13 THEN ROUND(flujo  *(rsnominal/nominal),2)
      ELSE ROUND(flujo  *(rsnominal/nominal),0)
       END      ,--8
   rstasfloat = tasa_float     ,--9
   rstasemi = tasemi     ,--12
   rsbasemi = basemi     ,--13
   rsinteres =  CASE
      WHEN rsmonemi=13 THEN ROUND(intdia  *(rsnominal/nominal),2)
      ELSE ROUND(intdia  *(rsnominal/nominal),0)
        END      ,--14
   rsinteres_emis =  CASE
      WHEN rsmonemi=13 THEN ROUND(intdia_emis  *(rsnominal/nominal),2)
      ELSE ROUND(intdia_emis  *(rsnominal/nominal),0)
        END      ,--14
 
   rsreajuste = ROUND(readia  *(rsnominal/nominal),0)  ,--15
   rsreajuste_emis = ROUND(readia_emis *(rsnominal/nominal),0)  ,--15
   rsinteres_acum =  CASE
      WHEN rsmonemi=13 THEN ROUND(interes *(rsnominal/nominal),2)
      ELSE ROUND(interes *(rsnominal/nominal),0)
        END      ,--18
   rsinteres_acum_emis =  CASE
      WHEN rsmonemi=13 THEN ROUND(interes_emis *(rsnominal/nominal),2)
      ELSE ROUND(interes_emis *(rsnominal/nominal),0)
            END      ,--18
   rsreajuste_acum = ROUND(reajuste*(rsnominal/nominal),0)  ,--19
   rsreajuste_acum_emis = ROUND(reajuste_emis*(rsnominal/nominal),0)  ,--19
   rsforpagv = 0.0      ,--20
   rsvalcomp = CASE
      WHEN rscodigo=13 THEN ROUND(valcomp *(rsnominal/nominal),2)
      ELSE ROUND(valcomp *(rsnominal/nominal),0)
               END      ,--21
   rsvalcomu = CASE
      WHEN rscodigo=13 THEN ROUND(valcomu *(rsnominal/nominal),2)
      WHEN monemi=999 THEN ROUND(valcomu *(rsnominal/nominal),0)
      ELSE ROUND(valcomu *(rsnominal/nominal),4)
        END      ,--22
   rsvalor_emis = CASE
      WHEN rscodigo=13 THEN ROUND(valcomp_emis *(rsnominal/nominal),2)
      ELSE ROUND(valcomp_emis *(rsnominal/nominal),0)
               END      ,--23
   rsvalorum_emis = CASE
      WHEN rscodigo=13 THEN ROUND(valcomu_emis *(rsnominal/nominal),2)
      WHEN monemi=999 THEN ROUND(valcomu_emis*(rsnominal/nominal),0)
      ELSE ROUND(valcomu_emis *(rsnominal/nominal),4)
        END      ,--24 
   rsdurat  = duration     ,--25
   rsdurmod = durmodif     ,--26
   rsconvex = convex     ,--27
   rsnumucup = numucup     ,--28
   rsnumpcup = numpcup     ,--29
   rsfecucup = fecucup     ,--30
   rsfecpcup = fecpcup     ,--31
   rsvpcomp = pvpcomp     ,--32
   rsdifrea = readifmes     ,--33
   rsvalvenc = ROUND((cup*rsnominal)/100.0,4)  , --34
   rsvpresen_emis  = CASE
      WHEN rsmonemi=13 THEN ROUND(valptehoy_emis*(rsnominal/nominal),2)
      ELSE ROUND(valptehoy_emis*(rsnominal/nominal),0)
       END      ,--35,
   rsnominal_resi = ((rsnominal * (select tdsaldo from view_tabla_desarrollo where tdmascara = rsmascara and tdfecven = fecucup) )/ 100)
 
  FROM #TEMPORAL
  WHERE rsrutcart=rutcart AND rstipcart=tipcart AND rsinstser=instser AND rsfeccomp=feccomp AND
   rstir=tircomp AND rsfecha=@dFecprox AND rscartera='211'
  IF @@ERROR<>0
  BEGIN
   ROLLBACK TRANSACTION
   SELECT 'NO','Problemas al Actualizar Tabla MDRS con Devengamiento'
   RETURN
  END
  SELECT *
  INTO #TEMPORAL2
  FROM MDRS
  WHERE rsfecha=@dFecprox AND rstipoper='DEV' AND rsflujo>0 AND (rscartera='211' ) AND
   CHARINDEX(STR(rsmonemi,3),CASE WHEN @cDevengo_dolar='N' THEN '997-998-999' ELSE '988-994-995- 13' END)>0
  IF @@ERROR<>0
  BEGIN
   ROLLBACK TRANSACTION
   SELECT 'NO','Problemas al Generar Temporal con Vencimientos'
   RETURN
  END
  UPDATE #TEMPORAL2 SET rstipoper='VC'
  INSERT INTO MDRS SELECT * FROM #TEMPORAL2
  IF @@ERROR<>0
  BEGIN
   ROLLBACK TRANSACTION
   SELECT 'NO','Problemas al Insertar Vencimientos al MDRS'
   RETURN
  END
  UPDATE MDRS
  SET rsrutemis = serutemi
  FROM VIEW_INSTRUMENTO, VIEW_SERIE
  WHERE rscodigo=incodigo AND inmdse='S' AND rsmascara=semascara
  UPDATE MDAC SET acsw_dvprop='1'
 COMMIT TRANSACTION
 SELECT 'SI','Proceso de Devengamiento ha finalizado en forma correcta'
 SET NOCOUNT OFF
 RETURN
END
--Sp_DevengoPasivo '20011203','20011204', 0,  0,  0, 'N'
--select * from mdrs where rscartera = '211'
--select rsnominal_resi from mdrs
--select tdsaldo,* from view_tabla_desarrollo where tdmascara = 'UEDW-A1291'  and tdfecven ='20010601') )/ 100)    


GO
