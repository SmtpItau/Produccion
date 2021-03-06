USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COPROPIASYVEPACTO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_COPROPIASYVEPACTO]
AS
BEGIN
 CREATE TABLE #Tempo
  (
  Ndocumento INTEGER  ,
  RutEmisor INTEGER  ,
  Origen  CHAR(3)  ,
  Refe  CHAR(1)  ,
  Trans  INTEGER  ,
  Glaccount INTEGER  ,
  Currency CHAR(3)  ,
  Issuer  CHAR(60) ,
  Rate  NUMERIC(19,4) ,
  IssueDate DATETIME ,
  Maturdate DATETIME ,
  Parvalue NUMERIC(19,4) ,
  Bookvalue NUMERIC(19,4) ,
  Mrktprice NUMERIC(19,4) ,
  Risk  NUMERIC(19,4) ,
  Residency CHAR(2)  ,
  Ctryrisk CHAR(2)  ,
  Industry CHAR(1)  ,
  Cusip  CHAR(1)  ,
  Isin  CHAR(1)  ,
  SicCode  CHAR(1)  ,
  Yield  NUMERIC(19,4) ,
  PortFolio INTEGER   )
 DECLARE @RutCli  INTEGER  ,
  @NumDocu INTEGER  ,
  @Correla INTEGER  ,
  @EmNombre CHAR(100) ,
  @Seriado CHAR(1)  ,
  @Mascara CHAR(15) ,
  @Nominal NUMERIC(19,4) ,
  @ValComp NUMERIC(19,4) ,
  @VpComp  NUMERIC(19,4) ,
  @ReajustC NUMERIC(19,4) ,
  @ReajustV NUMERIC(19,4) ,
  @TipCart CHAR(1)  ,
  @Cartera INTEGER  ,
  @RutEmisor INTEGER  ,
  @Rate  NUMERIC(19,4) ,
  @IssueDate DATETIME ,
  @MaturDate DATETIME ,
  @GlAccount INTEGER  ,
  @Yield  NUMERIC(19,4) ,
  @TirComp NUMERIC(19,4) ,
  @CpRutCart INTEGER  ,
  @CpNominal NUMERIC(19,4) ,
  @TipoEmpresa INTEGER  ,
  @Industry CHAR(1)  ,
  @ValorMoneda NUMERIC(19,4) ,
  @FechaProceso DATETIME ,
  @CodigoMoneda INTEGER
 DECLARE CP_Cursor SCROLL CURSOR FOR
  SELECT cprutcli  ,
   cpnumdocu  ,
   cpcorrela  ,
   cpseriado  ,
   cpmascara  ,
   cpnominal  ,
   cpvalcomp  ,
   cpvpcomp  ,
   cpreajustc  ,
   cptircomp  ,
   codigo_carterasuper ,
   cprutcart  ,
   cpnominal
  FROM MDCP
 SELECT @FechaProceso = (SELECT acfecproc FROM MDAC)
 OPEN CP_Cursor
 FETCH FIRST FROM CP_Cursor INTO
  @RutCli  ,
  @NumDocu ,
  @Correla ,
  @Seriado ,
  @Mascara ,
  @Nominal ,
  @ValComp ,
  @VpComp  ,
  @ReajustC ,
  @TirComp ,
  @TipCart ,
  @CpRutCart ,
  @CpNominal
 WHILE @@FETCH_STATUS = 0
 BEGIN
  IF @Seriado='S'
   SELECT  @RutEmisor = serutemi ,
    @Rate  = setasemi ,
    @IssueDate = sefecemi ,
    @MaturDate = sefecven ,
    @Yield  = (@Rate * 12) ,
    @CodigoMoneda = semonemi
   FROM VIEW_SERIE
   WHERE @Mascara = semascara
  ELSE
   SELECT @RutEmisor = nsrutemi ,
    @Rate  = nstasemi ,
    @IssueDate = nsfecemi ,
    @MaturDate = nsfecven ,
    @Yield  = @TirComp ,
    @CodigoMoneda = nsmonemi
   FROM VIEW_NOSERIE
   WHERE @Correla = nscorrela AND @NumDocu = nsnumdocu
  SELECT @GlAccount   = CASE WHEN @RutCli = 97018000 THEN 1481460 ELSE 1484966 END
  SELECT @Cartera     = CASE WHEN @TipCart = 'T' THEN 1 ELSE 2 END
  SELECT @EmNombre    = emnombre,
         @TipoEmpresa = ISNULL(emtipo,1)
  FROM VIEW_EMISOR WHERE @RutEmisor = emrut
  SELECT @ValorMoneda = (SELECT vmvalor FROM VIEW_VALOR_MONEDA
   WHERE @CodigoMoneda = vmcodigo AND @FechaProceso = vmfecha)
  SELECT @ValorMoneda = CASE WHEN @ValorMoneda = 0 OR @ValorMoneda IS NULL THEN 1 ELSE @ValorMoneda END
  SELECT @Industry    = CASE 
     WHEN @TipoEmpresa = 2 AND @RutEmisor  = 97029000  THEN 'Z'
     WHEN @TipoEmpresa = 2 AND @RutEmisor <> 97029000  THEN 'X'
     WHEN @TipoEmpresa = 1 AND @RutEmisor  = 6  THEN 'O' -- INP Ver!
     ELSE 'N'
          END
  IF @CpRutCart > 0 AND @CpNominal > 0
   INSERT INTO #TEMPO
   VALUES ( 
    @NumDocu     ,
    @RutEmisor     ,
    'BSA'      ,
    ''      ,
    57885      ,
    @GlAccount     ,
    'CLP'      ,
    @EmNombre     ,
    (ISNULL(@Rate,0))    ,
    @IssueDate     ,
    @MaturDate     ,
    (ISNULL(ROUND(@VpComp * @Nominal / 100 * @ValorMoneda,0),0)) ,
    (ISNULL(@ValComp + @ReajustC,0))  ,
    0      ,
    0      ,
    'CL'      ,
    'CL'      ,
    @Industry     ,
    ''      ,
    ''      ,
    ''      ,
    (ISNULL(@Yield,0))    ,
    @Cartera )
  FETCH NEXT FROM CP_Cursor INTO
   @RutCli  ,
   @NumDocu ,
   @Correla ,
   @Seriado ,
   @Mascara ,
   @Nominal ,
   @ValComp ,
   @VpComp  ,
   @ReajustC ,
   @TirComp ,
   @TipCart ,
   @CpRutCart ,
   @CpNominal
 END
 CLOSE CP_Cursor
 DEALLOCATE CP_Cursor
 DECLARE VI_Cursor SCROLL CURSOR FOR
 SELECT virutcli  ,
  vinumdocu  ,
  vicorrela  ,
  viseriado  ,
  vimascara  ,
  vinominal  ,
  vivalcomp  ,
  vivpcomp  ,
  vireajustv  ,
  tir_compra_original ,
  codigo_carterasuper
 FROM MDVI
 OPEN VI_Cursor
 FETCH FIRST FROM VI_Cursor INTO 
  @RutCli  ,
  @NumDocu ,
  @Correla ,
  @Seriado ,
  @Mascara ,
  @Nominal ,
  @ValComp ,
  @VpComp  ,
  @ReajustV ,
  @TirComp ,
  @TipCart
 WHILE @@FETCH_STATUS = 0
 BEGIN
  IF @Seriado='S'
   SELECT  @RutEmisor = serutemi ,
    @Rate  = setasemi ,
    @IssueDate = sefecemi ,
    @MaturDate = sefecven ,
    @Yield  = (@Rate * 12) ,
    @CodigoMoneda = semonemi
   FROM VIEW_SERIE
   WHERE @Mascara = semascara
  ELSE
   SELECT @RutEmisor = nsrutemi ,
    @Rate  = nstasemi ,
    @IssueDate = nsfecemi ,
    @MaturDate = nsfecven ,
    @Yield  = @TirComp ,
    @CodigoMoneda = nsmonemi
   FROM VIEW_NOSERIE
   WHERE @Correla = nscorrela AND @NumDocu = nsnumdocu
  SELECT @GlAccount   = CASE WHEN @RutCli = 97018000 THEN 1481460 ELSE 1484966 END
  SELECT @Cartera     = CASE WHEN @TipCart = 'T' THEN 1 ELSE 2 END
  SELECT @EmNombre    = emnombre,
         @TipoEmpresa = ISNULL(emtipo,1)
  FROM VIEW_EMISOR WHERE @RutEmisor = emrut
  SELECT @ValorMoneda = (SELECT vmvalor FROM VIEW_VALOR_MONEDA
   WHERE @CodigoMoneda = vmcodigo AND @FechaProceso = vmfecha)
  SELECT @ValorMoneda = CASE WHEN @ValorMoneda = 0 OR @ValorMoneda IS NULL THEN 1 ELSE @ValorMoneda END
  SELECT @Industry    = CASE
     WHEN @TipoEmpresa = 2 AND @RutEmisor  = 97029000 THEN 'Z'
     WHEN @TipoEmpresa = 2 AND @RutEmisor <> 97029000 THEN 'X'
     WHEN @TipoEmpresa = 1 AND @RutEmisor  = 6        THEN 'O'  -- INP VER!
     ELSE 'N'
          END
  INSERT INTO #TEMPO
  VALUES ( 
   @NumDocu    ,
   @RutEmisor    ,
   'BSA'     ,
   ''     ,
   57885     ,
   @GlAccount    ,
   'CLP'     ,
   @EmNombre    ,
   @Rate     ,
   @IssueDate    ,
   @MaturDate    ,
   (ROUND(@VpComp * @Nominal / 100 * @ValorMoneda,0)) ,
   (@ValComp + @ReajustV)   ,
   0     ,
   0     ,
   'CL'     ,
   'CL'     ,
   @Industry    ,
   ''     ,
   ''     ,
   ''     ,
   @Yield     ,
   @Cartera )
  FETCH NEXT FROM VI_Cursor INTO 
   @RutCli  ,
   @NumDocu ,
   @Correla ,
   @Seriado ,
   @Mascara ,
   @Nominal ,
   @ValComp ,
   @VpComp  ,
   @ReajustV ,
   @TirComp ,
   @TipCart
 END
 CLOSE VI_Cursor
 DEALLOCATE VI_Cursor
 
 SELECT * FROM #TEMPO
END


GO
