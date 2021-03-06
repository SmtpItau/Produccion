USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FORMATOBNS_LLENAR]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FORMATOBNS_LLENAR]
    (
    @nCodigo INTEGER = 0
    )
AS
BEGIN
 SET NOCOUNT ON
 CREATE TABLE
 #Temp_Cta
  (
  tipo INTEGER  ,
  tramo CHAR (02) ,
  emisor CHAR (01) ,
  cta_cap NUMERIC (10) ,
  cta_mer NUMERIC (10)
  )
 INSERT INTO #Temp_Cta SELECT  2, 'ST', 'G', 1427164, 4427165
 INSERT INTO #Temp_Cta SELECT  2, 'LT', 'G', 1427261, 4427262
 INSERT INTO #Temp_Cta SELECT  2, 'ST', 'O', 1425064, 4425065
 INSERT INTO #Temp_Cta SELECT  2, 'LT', 'O', 1426168, 4426169
 INSERT INTO #Temp_Cta SELECT  1, 'ST', 'G', 1481460, 4481461
 INSERT INTO #Temp_Cta SELECT  1, 'LT', 'G', 1483765, 4483766
 INSERT INTO #Temp_Cta SELECT  1, 'ST', 'O', 1484966, 4484967
 INSERT INTO #Temp_Cta SELECT  1, 'LT', 'O', 1485067, 4485068
 DELETE FormatoBNS
 DECLARE @RutCli  INTEGER  ,
  @NumDocu INTEGER  ,
  @Numoper INTEGER  ,
  @Correla INTEGER  ,
  @EmNombre CHAR (100) ,
  @Seriado CHAR (01)  ,
  @Mascara CHAR (15) ,
  @Nominal NUMERIC (19,4) ,
  @ValComp NUMERIC (19,4) ,
  @VpComp  NUMERIC (19,4) ,
    @ReajustC NUMERIC (19,4) ,
  @ReajustV NUMERIC (19,4) ,
  @TipCart CHAR (01) ,
  @Cartera INTEGER  ,
  @RutEmisor INTEGER  ,
  @Rate  NUMERIC (19,4) ,
  @IssueDate DATETIME ,
  @BuyDate DATETIME ,
  @MaturDate DATETIME ,
  @GlAccount NUMERIC (19,4) ,
  @Yield  NUMERIC (19,4) ,
  @TirComp NUMERIC (19,4) ,
  @Mrktprice NUMERIC (19,4) ,
  @CpRutCart INTEGER  ,
  @CpNominal NUMERIC (19,4) ,
  @TipoEmpresa INTEGER  ,
  @Industry CHAR (01) ,
  @ValorMoneda NUMERIC (19,4) ,
  @FechaProceso DATETIME ,
  @CodigoMoneda INTEGER  ,
  @CuentaBSA CHAR (20) ,
  @vpresen NUMERIC (19,4) ,
  @cta_cap  NUMERIC (10) ,
  @cta_mer  NUMERIC (10) 
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
  @dFechaFinMes DATETIME
 SELECT @FechaProceso = acfecproc ,
  @dFechaFinMes = DATEADD(MONTH,1,acfecproc)
 FROM MDAC
 SELECT @dFechaFinMes = DATEADD(DAY,DATEPART(DAY,@dFechaFinMes)*-1,@dFechaFinMes)
 DECLARE CP_Cursor SCROLL CURSOR FOR
 SELECT cprutcli  ,
  cpnumdocu  ,
  cpcorrela  ,
  cpseriado  ,
  cpmascara  ,
  cpnominal  ,
  cpfeccomp  ,
  cpvalcomp  ,
  ISNULL(cpvpcomp,0) ,
  cpreajustc  ,
  cptircomp  ,
  codigo_carterasuper ,
  cprutcart  ,
  cpnominal  ,
  ctacontable  ,
  cpinstser  ,
  cpcodigo  ,
  cpfecemi  ,
  cpFecven  ,
  cpvptirc
 FROM MDCP, CARTERA_CUENTA
 WHERE cpnumdocu=numdocu AND cpcorrela=correla AND t_operacion='CP' AND
  variable='valor_compra' AND (cpcodigo=@nCodigo OR @nCodigo=0)
 OPEN CP_Cursor
 FETCH FIRST FROM CP_Cursor INTO
  @RutCli  ,
  @NumDocu ,
  @Correla ,
  @Seriado ,
  @Mascara ,
  @Nominal ,
  @BuyDate ,
  @ValComp ,
  @VpComp  ,
  @ReajustC ,
  @TirComp ,
  @TipCart ,
  @CpRutCart ,
  @CpNominal ,
  @Cuentabsa ,
  @cInstser ,
  @iCodigo ,
  @dFecemi ,
  @dFecven ,
  @vpresen
 WHILE @@FETCH_STATUS=0
 BEGIN
  SELECT @RutEmisor = 0 ,
   @Rate  = 0 ,
   @IssueDate = '' ,
   @MaturDate = '' ,
   @Yield  = 0 ,
   @CodigoMoneda = 0 ,
   @fBasemi = 0
  IF @Seriado='S'
   SELECT  @RutEmisor = serutemi ,
    @Rate  = setasemi ,
--    @IssueDate = sefecemi ,
--    @MaturDate = sefecven ,
    @Yield  = setasemi ,
    @CodigoMoneda = semonemi ,
    @fBasemi = sebasemi
   FROM VIEW_SERIE
   WHERE @Mascara=semascara
  ELSE
   SELECT @RutEmisor = nsrutemi ,
    @Rate  = nstasemi ,
--    @IssueDate = nsfecemi ,
--    @MaturDate = nsfecven ,
    @Yield  = @TirComp ,
    @CodigoMoneda = nsmonemi ,
    @fBasemi = nsbasemi
   FROM VIEW_NOSERIE
   WHERE @Correla=nscorrela AND @NumDocu=nsnumdocu
  SELECT @IssueDate = @dFecemi
  SELECT @MaturDate = @dFecven
  IF @CodigoMoneda=999 AND @iCodigo<>888
   SELECT @Yield = @Yield*12
  SELECT @GlAccount = CASE WHEN @RutCli=97018000 THEN 1481460 ELSE 1484966 END
  SELECT @Cartera   = CASE WHEN @TipCart='T' THEN 1 ELSE 2 END
  SELECT @EmNombre = emnombre  ,
   @TipoEmpresa = ISNULL(emtipo,1)
  FROM VIEW_EMISOR
  WHERE @RutEmisor=emrut
  SELECT @cta_cap = cta_cap ,
   @cta_mer = cta_mer
  FROM #TEMP_CTA
  WHERE tipo=@Cartera AND
   tramo=CASE WHEN DATEDIFF(DAY,@FechaProceso,@dFecven)<=365  THEN 'ST' ELSE 'LT' END AND
   emisor=CASE WHEN @RutEmisor=61533000 OR @RutEmisor=97029000 OR @RutEmisor=2 THEN 'G' ELSE 'O' END
  SELECT @ValorMoneda = vmvalor
  FROM VIEW_VALOR_MONEDA
  WHERE @CodigoMoneda=vmcodigo AND @FechaProceso=vmfecha
  SELECT @ValorMoneda = CASE
      WHEN @ValorMoneda=0 OR @ValorMoneda IS NULL THEN 1 
      ELSE @ValorMoneda
       END
  SELECT @Industry = CASE
      WHEN @TipoEmpresa=2 AND @RutEmisor=97029000  THEN 'Z'
      WHEN @TipoEmpresa=2 AND @RutEmisor<>97029000  THEN 'X'
      WHEN @TipoEmpresa=1 AND @RutEmisor=6  THEN 'O' -- INP Ver!
      ELSE 'N'
       END
  SELECT @cProg  = 'SP_'+inprog  ,
   @fNominal = @Nominal  ,
   @iModcal = 2   ,
   @iMonemi = @CodigoMoneda  ,
   @fTasemi = @Rate   ,
   @fTasest = 0   ,
   @fTir  = @Rate   ,
   @fPvp  = 0   ,
   @fMt  = 0.0   ,
   @fMtum  = 0.0   ,
   @fMt_cien = 0.0   ,
   @fVan  = 0.0   ,
   @fVpar  = 0.0   ,
   @nNumucup = 0   ,
   @dFecucup = ''   ,
   @fIntucup = 0.0   ,
   @fAmoucup = 0.0   ,
   @fSalucup = 0.0   ,
   @nNumpcup = 0   ,
   @dFecpcup = ''   ,
   @fIntpcup = 0.0   ,
   @fAmopcup = 0.0   ,
   @fSalpcup = 0.0   ,
   @fDurat  = 0.0   ,
   @fConvx  = 0.0   ,
   @fDurmo  = 0.0
  FROM VIEW_INSTRUMENTO
  WHERE @icodigo=incodigo
  IF @CpRutCart>0 AND @CpNominal>0
  BEGIN
    --** Valorizaci¢n a Pr¢ximo Proceso **--
   EXECUTE @nError = @cProg @iModcal, @FechaProceso, @iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest,
      @fNominal OUTPUT, @fTir OUTPUT, @fPvp OUTPUT, @fMt OUTPUT, @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,
      @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
                @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT
   SELECT @Mrktprice = 0
   SELECT @Mrktprice = valor_mercado 
   FROM VALORIZACION_MERCADO 
   WHERE fecha_valorizacion=@dFechaFinMes AND rmnumdocu=@NumDocu AND
    rmnumoper=@NumDocu AND rmcorrela=@Correla 
   IF @Mrktprice=0
    SELECT @Mrktprice = @vpresen
   SELECT @Rate = @Rate * 12
   WHERE @CodigoMoneda=999 AND @iCodigo<>888
                        if @vpresen = 0 
      set @vpresen = 0.01
   INSERT INTO FormatoBNS
   VALUES
    (
    @NumDocu   ,
    @RutEmisor   ,
    'BSA'    ,
    ''    ,
    57885    ,
    'CLP'    ,
    @EmNombre   ,
    ISNULL(@Rate,0)   ,
    @IssueDate   ,
    @BuyDate   ,
    @MaturDate   ,
    @fMt    ,
    ISNULL(@ValComp+@ReajustC,0) ,
    ISNULL((@Mrktprice/@vpresen*100),0),
    'CHILE'    ,
    'CL'    ,
    @Industry   ,
    ISNULL(@Yield,0)  ,
    @Cartera   ,
    @CuentaBSA   ,
    @GlAccount   ,
    @Mrktprice - @vpresen  ,
    @cta_cap    ,
    @cta_mer
    )
  END
 
  FETCH NEXT FROM CP_Cursor
  INTO
  @RutCli  ,
  @NumDocu ,
  @Correla ,
  @Seriado ,
  @Mascara ,
  @Nominal ,
  @BuyDate ,
  @ValComp ,
  @VpComp  ,
  @ReajustC ,
  @TirComp ,
  @TipCart ,
  @CpRutCart ,
  @CpNominal ,
  @Cuentabsa ,
  @cInstser ,
  @iCodigo ,
  @dFecemi ,
  @dFecven ,
  @vpresen
 END
 
 CLOSE CP_Cursor
 DEALLOCATE CP_Cursor
-- ********************************
-- MDVI
-- ********************************
 DECLARE vi_Cursor SCROLL CURSOR FOR
 SELECT virutcli  ,
  vinumdocu  ,
  vinumoper  ,
  vicorrela  ,
  viseriado  ,
  vimascara  ,
  vinominal  ,
  vifeccomp  ,
 vivalcomp  ,
  ISNULL(vivpcomp,0) ,
  vireajustv  ,
  vitircomp    ,
  codigo_carterasuper ,
  virutcart  ,
  vinominal  ,
  ctacontable  ,
  viinstser  ,
  vicodigo  ,
  vifecemi  ,
  viFecven  ,
  vivptirv
 FROM MDVI, CARTERA_CUENTA
 WHERE vinumdocu=numdocu AND vicorrela=correla AND vinumoper=numoper AND
  t_operacion='VI' AND variable='valor_compra' AND (vicodigo=@nCodigo OR @nCodigo=0)
--and cpcodigo = 4 
 OPEN vi_Cursor
 FETCH FIRST FROM vi_Cursor INTO
  @RutCli  ,
  @NumDocu ,
  @Numoper ,
  @Correla ,
  @Seriado ,
  @Mascara ,
  @Nominal ,
  @BuyDate ,
  @ValComp ,
  @VpComp  ,
  @ReajustC ,
  @TirComp ,
  @TipCart ,
  @CpRutCart ,
  @CpNominal ,
  @Cuentabsa ,
  @cInstser ,
  @iCodigo ,
  @dFecemi ,
  @dFecven ,
  @vpresen
 WHILE @@FETCH_STATUS=0
 BEGIN
  IF @Seriado='S'
   SELECT  @RutEmisor = serutemi ,
    @Rate  = setasemi ,
--    @IssueDate = sefecemi ,
--    @MaturDate = sefecven ,
    @Yield  = setasemi ,
    @CodigoMoneda = semonemi ,
    @fBasemi = sebasemi
   FROM VIEW_SERIE
   WHERE @Mascara=semascara
  ELSE
   SELECT @RutEmisor = nsrutemi ,
    @Rate  = nstasemi ,
--    @IssueDate = nsfecemi ,
--    @MaturDate = nsfecven ,
    @Yield  = @TirComp ,
    @CodigoMoneda = nsmonemi ,
    @fBasemi = nsbasemi
   FROM VIEW_NOSERIE
   WHERE @Correla=nscorrela AND @NumDocu=nsnumdocu
  SELECT @IssueDate = @dFecemi
  SELECT @MaturDate = @dFecven
  IF @CodigoMoneda=999 AND @iCodigo<>888
   SELECT @Yield = @Yield*12
  SELECT @GlAccount = CASE WHEN @RutCli=97018000 THEN 1481460 ELSE 1484966 END
  SELECT @Cartera = CASE WHEN @TipCart='T' THEN 1 ELSE 2 END
  SELECT @EmNombre = emnombre,
           @TipoEmpresa = ISNULL(emtipo,1)
  FROM VIEW_EMISOR
  WHERE @RutEmisor=emrut
  SELECT @cta_cap = cta_cap ,
   @cta_mer = cta_mer
  FROM #TEMP_CTA
  WHERE tipo=@Cartera AND
   tramo=CASE WHEN DATEDIFF(DAY,@FechaProceso,@dFecven)<=365 THEN 'ST' ELSE 'LT' END AND
   emisor=CASE WHEN @RutEmisor=61533000 OR @RutEmisor=97029000 OR @RutEmisor=2 THEN 'G' ELSE 'O' END
  SELECT @ValorMoneda = vmvalor
  FROM VIEW_VALOR_MONEDA
  WHERE @CodigoMoneda=vmcodigo AND @FechaProceso=vmfecha
  SELECT @ValorMoneda = CASE
      WHEN @ValorMoneda=0 OR @ValorMoneda IS NULL THEN 1
      ELSE @ValorMoneda
       END
  SELECT @Industry = CASE
      WHEN @TipoEmpresa=2 AND @RutEmisor=97029000 THEN 'Z'
      WHEN @TipoEmpresa=2 AND @RutEmisor<>97029000 THEN 'X'
      WHEN @TipoEmpresa=1 AND @RutEmisor=6 THEN 'O'
      ELSE 'N'
       END
  SELECT @cProg  = 'SP_'+inprog  ,
   @fNominal = @Nominal  ,
   @iModcal = 2   ,
   @iMonemi = @CodigoMoneda  ,
   @fTasemi = @Rate   ,
   @fTasest = 0   ,
   @fTir  = @Rate   ,
   @fPvp  = 0   ,
   @fMt  = 0.0   ,
   @fMtum  = 0.0   ,
   @fMt_cien = 0.0   ,
   @fVan  = 0.0   ,
   @fVpar  = 0.0   ,
   @nNumucup = 0   ,
   @dFecucup = ''   ,
   @fIntucup = 0.0   ,
   @fAmoucup = 0.0   ,
   @fSalucup = 0.0   ,
   @nNumpcup = 0   ,
   @dFecpcup = ''   ,
   @fIntpcup = 0.0   ,
   @fAmopcup = 0.0   ,
   @fSalpcup = 0.0   ,
   @fDurat  = 0.0   ,
   @fConvx  = 0.0   ,
   @fDurmo  = 0.0
  FROM VIEW_INSTRUMENTO
  WHERE @icodigo=incodigo
  IF @CpRutCart>0 AND @CpNominal>0
  BEGIN
    --** Valorizaci¢n a Pr¢ximo Proceso **--
   EXECUTE @nError = @cProg @iModcal, @FechaProceso, @iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest,
      @fNominal OUTPUT, @fTir OUTPUT, @fPvp OUTPUT, @fMt OUTPUT, @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,
      @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
               @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT
   SELECT @Mrktprice = 0
   SELECT @Mrktprice = valor_mercado 
   FROM VALORIZACION_MERCADO 
   WHERE fecha_valorizacion=@dFechaFinMes AND rmnumdocu=@NumDocu AND
    rmnumoper=@Numoper AND rmcorrela=@Correla 
   IF @Mrktprice=0
    SELECT @Mrktprice = @vpresen
   SELECT @Rate = @Rate * 12
   WHERE @CodigoMoneda=999 AND @iCodigo<>888
   if @vpresen = 0
    set @vpresen = 0.01
   INSERT INTO FormatoBNS
   VALUES (
    @NumDocu   ,
    @RutEmisor   ,
    'BSA'    ,
    ''    ,
    57885    ,
    'CLP'    ,
    @EmNombre   ,
    ISNULL(@Rate,0)   ,
    @IssueDate   ,
    @BuyDate   ,
    @MaturDate   ,
    @fMt    ,
    ISNULL(@ValComp + @ReajustC,0) ,
    ISNULL((@Mrktprice/@vpresen*100),0),
    'CHILE'    ,
    'CL'    ,
    @Industry   ,
    ISNULL(@Yield,0)  ,
    @Cartera   ,
    @CuentaBSA   ,
    @GlAccount   ,
    @Mrktprice - @vpresen  ,
    @cta_cap   ,
    @cta_mer
    )
  END
 
  FETCH NEXT FROM vi_Cursor
  INTO
  @RutCli  ,
  @NumDocu ,
  @Numoper ,
  @Correla ,
  @Seriado ,
  @Mascara ,
  @Nominal ,
  @BuyDate ,
  @ValComp ,
  @VpComp  ,
  @ReajustC ,
  @TirComp ,
  @TipCart ,
  @CpRutCart ,
  @CpNominal ,
  @Cuentabsa ,
  @cInstser ,
  @iCodigo ,
  @dFecemi ,
  @dFecven ,
  @vpresen
 END
 
 CLOSE vi_Cursor
 DEALLOCATE vi_Cursor
 SET NOCOUNT OFF
END
-- select * from FormatoBNS where CuentaBSA =0
-- select * from FormatoBNS where Ndocumento = 48972
-- select * from cartera_cuenta where t_operacion = 'VI' AND Variable = 'valor_compra'
-- select * from cartera_cuenta where t_operacion = 'CP' AND Variable = 'valor_compra'
-- select * from cartera_cuenta where numdocu = 49199
-- select * from mdcp where cpnumdocu = 49247
-- select * from VALORIZACION_MERCADO where rmnumdocu = 49431
-- select * from view_serie where semascara = 'EDWS40'
-- select * from view_serie where semascara = 'EDWI30'
-- select * from mdvi
/*create table #n (n float)
declare @n  float
insert #n  values( 284876549139500.000000)
select * from #n*/
-- sp_Buscador_de_cuentas
-- select * from mdcp where cpnumdocu=49459
-- update mdcp set cpinstser = 'SUD040 *01' where cpinstser = 'SUD040*01'
--
-- Sp_FormatoBNS_llenar 0
-- Sp_FormatoBNS
-- select * from view_emisor

GO
