USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_TICKER]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGA_TICKER]  
 ( @nemotecnico CHAR(30) = '' )     
AS     
BEGIN    
    
 SET NOCOUNT ON    
    
 DECLARE  @modcal  INTEGER    
 DECLARE  @mascara  CHAR(10)    
 DECLARE  @feccal  CHAR(10)    
 SET @feccal = (select convert(char(8),acfecproc,112) from MDAC)     
    
 CREATE TABLE #TMP_ERRORES    
  ( Codigo   VARCHAR(10)    
  , Descripcion  VARCHAR(100)    
  , Serie   VARCHAR(20)    
  , iContador  INT  IDENTITY NOT FOR REPLICATION    
  )    
    
 CREATE TABLE #TMP_RET_CHKINSTSER    
  ( Error   INT    
  , Mascara   VARCHAR(20)    
  , Codigo   INT    
  , Serie   VARCHAR(20)    
  , RutEmision  varchar(12)    
  , MonEmision  NUMERIC(5)    
  , TasEmision  FLOAT    
  , BasEmision  NUMERIC(5)    
  , FecEmision  CHAR(10)    
  , FecVcto   CHAR(10)    
  , Refmonemi  CHAR(5)    
  , GenEmi   VARCHAR(10)    
  , NemoMon   VARCHAR(5)    
  , Cortes   FLOAT    
  , Seriado   CHAR(1)    
  , LecEmi   CHAR(10)    
  , FecProc   CHAR(10)    
      
  )     
    
  CREATE TABLE  #ClaveDCV    
  ( ClaveDCV   varchar(12)    
  )    
    
 CREATE TABLE  #Valorizacion(    
  fError   INTEGER  ,    
  fNominal FLOAT  ,    
  fTir  FLOAT  ,     
  fPvp  FLOAT  ,    
  fMT  FLOAT  ,    
  fMTUM  FLOAT  ,    
  fMT_cien FLOAT  ,    
  fVan  FLOAT  ,    
  fVpar  FLOAT  ,    
  nNumucup INTEGER  ,    
  cFecucup CHAR(10) ,    
  fIntucup FLOAT  ,    
  fAmoucup FLOAT  ,    
  fSalucup FLOAT  ,    
  nNumpcup FLOAT  ,    
  cFecpcup CHAR(10) ,    
  fIntpcup FLOAT  ,    
  fAmopcup FLOAT  ,    
  fSalpcup FLOAT  ,    
  fDurat  FLOAT  ,    
  fConvx  FLOAT  ,    
  fDurmo  FLOAT   );    
    
    
 DECLARE @cProg               CHAR(10) ,    
  @iModcal             INTEGER ,    
  @iCodigo             INTEGER ,    
  @cInstser            CHAR(10) ,    
  @iMonemi             INTEGER ,    
  @dFecemi             CHAR(10) ,    
  @dFecven             CHAR(10) ,    
  @fTasemi             FLOAT ,    
  @fBasemi             FLOAT ,    
  @fTasest             FLOAT ,    
  @fNominal            FLOAT ,    
  @zNominal      FLOAT  ,    
  @fTir                FLOAT ,    
  @fPvp                FLOAT ,    
  @fMT                 FLOAT ;    
    
    
 SELECT   Nemo = Nemotecnico    
  --,  sgenemi = convert(char(5), '')    
  ,  sgenemi = CASE WHEN emisor <> '' THEN emisor ELSE convert(char(5), '') END     
  ,       stasemi = 0    
  ,       sbasemi = 0    
  ,  Cod  = codigo_ticker    
   --,  Nominal = CASE WHEN SUM(cantidad) > 0 THEN SUM(cantidad) ELSE SUM(val_resc) END  
     ,      Nominal = sum(val_resc)    
  ,  Tir  = tir    
  ,  um  = convert(char(10), '')    
  ,  CodInst = convert(numeric(9), 0)    
  ,  Id  = identity(int)    
        ,       Monto   = SUM(Monto)    
  ,       precio    
  ,  codserie = convert(char(9), '')    
  ,       rut     =  convert(numeric(9),0)    
  ,  monemi  =  convert(numeric(3),0)    
  ,  sfecemi  =  convert(char(10), '')       
  ,  sfecven = convert(char(10), '')    
  ,       srefmonemi=convert(char(3),0)    
  ,  scorte = convert(numeric(15,3),0)    
  ,       sseriado=convert(char(1),0)    
  ,  slecemi=convert(char(9),0)    
  ,  sfecpro=convert(char(10),0)    
  ,       stmpvp=convert(numeric(5,2),0)    
  ,       svpar=convert(numeric(5,2),0)    
  ,  stmmt=convert(numeric(5,2),0)    
  ,  stmmt100=convert(numeric(5,2),0)    
  ,  stirmcd=convert(numeric(5,2),0)    
  ,  spvpmcd=convert(numeric(5,2),0)    
  ,  smtmcd=convert(numeric(5,2),0)    
  ,  smtmcd100=convert(numeric(5,2),0)    
  ,  smtml=convert(numeric(5,2),0)    
  ,  stcmcl=convert(numeric(5,2),3)    
  ,       hndw  = convert(numeric(15), 0)    
  ,  smasc=convert(char(20), 0)    
  ,  estado    
--  ,  operador_interno_comprador  
--  ,  operador_interno_vendedor  
  ,  ind_dcv    
  ,  moneda    
  ,  monto_moneda_liquidacion     
 ,fTir = convert(float,0)  
  ,fPvp = convert(float,0)  
  ,fMT = convert(float,0)  
  ,fMTUM = convert(float,0)  
  ,fMT_cien = convert(float,0)  
  ,fVan = convert(float,0)  
  ,fVpar = convert(float,0)  
  ,nNumucup = 0  
  ,cFecucup = getdate()  
  ,fIntucup = convert(float,0)  
  ,fAmoucup = convert(float,0)  
  ,fSalucup = convert(float,0)  
  ,nNumpcup = 0  
  ,cFecpcup = getdate()  
  ,fIntpcup = convert(float,0)  
  ,fAmopcup = convert(float,0)  
  ,fSalpcup = convert(float,0)  
  ,fDurat = convert(float,0)  
  ,fConvx = convert(float,0)  
  ,fDurmo = convert(float,0)  
  ,ClaveDCV  = convert(char(20), 0)    
  ,codigo_operador_comprador  
   
    
 INTO  #TMP_PASO_RET    
 FROM  tbl_tickers_bolsa    
 WHERE ( nemotecnico               = @nemotecnico   
      or @nemotecnico              = ''   
       )    
 AND     estado                    in (0, 2)    
 AND     codigo_ticker             = 'IF'  
 and     codigo_operador_comprador = 105  -->17-04-2012 ARM Filtra que solo sean compras  
  
 -->     AND CONVERT(CHAR(10), hora_recepcion, 112) >= (SELECT acfecproc from BacTraderSuda.dbo.mdac)  
 and     convert(datetime, substring( hora_transaccion, 1, 8)) = (SELECT acfecproc from BacTraderSuda.dbo.mdac)  
  
 GROUP BY  Nemotecnico,val_resc,codigo_ticker,emisor,tir,estado ,  
     ind_dcv,moneda, monto_moneda_liquidacion,codigo_operador_comprador ,precio  
    
 --SP_CARGA_TICKER ''  
    
 DECLARE @nReg  NUMERIC(9)    
  SET @nReg  = (SELECT MAX( id ) FROM #TMP_PASO_RET )    
 DECLARE @iCont  NUMERIC(9)    
  SET @iCont  = 1    
 DECLARE @cSerie  VARCHAR(14)    
 DECLARE @TipoError VARCHAR(10)    
 DECLARE @cEmisor CHAR(10)    
    
 DECLARE @nNumucup INTEGER  ,    
  @cFecucup CHAR(10) ,    
  @cFecpcup CHAR(10) ,    
  @fDurat  FLOAT  ,    
  @fConvx  FLOAT  ,    
  @fDurmo  FLOAT   ,    
  @fmtRestante FLOAT  ,    
  @nrutemi NUMERIC(9)  ;    
    
 DELETE FROM #TMP_RET_CHKINSTSER --    
 DELETE FROM #TMP_ERRORES    
    
 WHILE @nReg >= @iCont    
 BEGIN    
  delete from #valorizacion    
    
  SELECT @cSerie = Nemo  ,    
    @modcal=3,    
    @fNominal= nominal,    
    @fTir=tir,    
    @fMT=monto,    
    @cEmisor = sgenemi    
  FROM   #TMP_PASO_RET     
  WHERE  Id  = @iCont    
    
  INSERT INTO #TMP_ERRORES    
  EXECUTE BacTraderSuda.dbo.SP_CHEQUEA_SERIE_INSTRUMENTO @cSerie, '', 'S', @cEmisor    
     
  --SP_CHEQUEA_SERIE_INSTRUMENTO 'DPK-100212', '', 'S'    
  IF NOT EXISTS (SELECT CODIGO FROM #TMP_ERRORES WHERE CODIGO > 0 AND iContador = @iCont)     
  BEGIN    
       
    DELETE FROM #TMP_RET_CHKINSTSER -->     
    
   INSERT INTO #TMP_RET_CHKINSTSER    
   EXECUTE BacTraderSuda.dbo.SP_CHEQUEA_SERIE_INSTRUMENTO @cSerie, '', '', @cEmisor    
       
   UPDATE #TMP_PASO_RET     
      SET sgenemi    = GenEmi    
    ,  um    = NemoMon    
    ,  CodInst   = Codigo    
    ,  codserie   = Serie    
    ,  rut    = RutEmision    
    ,  monemi     = MonEmision    
    ,  stasemi   = TasEmision    
    ,  sbasemi   = BasEmision    
    ,  sfecemi   = FecEmision    
    ,  sfecven   = FecVcto     
    ,  srefmonemi = Refmonemi    
    ,  scorte     = Cortes    
    ,  sseriado   = Seriado    
    ,  slecemi    = LecEmi    
    ,  sfecpro    = FecProc    
    ,  smasc      = Mascara    
   FROM   #TMP_RET_CHKINSTSER    
   WHERE id    = @iCont    
    
   SELECT  @mascara=Serie ,    
    @imonemi=MonEmision ,    
    @icodigo=codigo  ,    
    @dFecemi=CONVERT(CHAR(10),CONVERT(DATETIME,FecEmision,103),112),    
    @dFecven=CONVERT(CHAR(10),CONVERT(DATETIME,FecVcto,103),112),    
    @ftasemi=TasEmision ,    
    @fbasemi=BasEmision ,    
    @ftasest=0.0  ,    
    @fpvp=0  ,    
    @nrutemi=RutEmision     
   from #TMP_RET_CHKINSTSER    
       
   IF @fNominal > 0    
   BEGIN    
    INSERT INTO  #Valorizacion    
    EXECUTE sp_valorizar_client    
     3,    
     @feccal,    
     @iCodigo,    
     @cSerie,    
     @iMonemi,    
     @dFecemi,    
     @dFecven,    
     @fTasemi,    
     @fBasemi,    
     @fTasest,    
     @fNominal,    
     @fTir,    
     @fPvp,    
     @fMT    
      
    
    UPDATE #TMP_PASO_RET     
    SET    
     fTir = r.fTir,  
     fPvp = r.fPvp,  
     fMT = r.fMT,  
     fMTUM = r.fMTUM,  
     fMT_cien = r.fMT_cien,  
     fVan = r.fVan,  
     fVpar = r.fVpar,  
     nNumucup = r.nNumucup,  
     cFecucup = convert(datetime,r.cFecucup,103),  
     fIntucup = r.fIntucup,  
    
    
    
    
     fAmoucup = r.fAmoucup,  
     fSalucup = r.fSalucup,  
     nNumpcup = r.nNumpcup,  
     cFecpcup = convert(datetime, r.cFecpcup,103),  
     fIntpcup = r.fIntpcup,  
     fAmopcup = r.fAmopcup,  
     fSalpcup = r.fSalpcup,  
     fDurat = r.fDurat,  
     fConvx = r.fConvx,  
     fDurmo = r.fDurmo  
    FROM #Valorizacion r    
    WHERE id    = @iCont    
    ------    
    INSERT INTO  #ClaveDCV    
    EXECUTE SP_ENTREGA_FOLIO 'DCV'    
        
    UPDATE #TMP_PASO_RET     
    SET    
     ClaveDCV = 'CORP' + c.ClaveDCV  
    FROM #ClaveDCV c  
    WHERE id  = @iCont    
        
    DELETE FROM #ClaveDCV    
    ------    
   END    
    SET @iCont = @iCont + 1    
        
    END    
    BEGIN    
    DELETE FROM #TMP_ERRORES WHERE Codigo = '0'    
    
    IF EXISTS(SELECT 1 FROM #TMP_ERRORES )    
    BEGIN    
     SELECT 'NoIngresada',* FROM #TMP_ERRORES    
     RETURN    
    END    
  END      
 END     
    
    
  SELECT Nemo--1    
  , sgenemi     
  , um          
  , Nominal    
  , tir     
  , stmpvp    
  , svpar    
  , stmmt    
  , stmmt100--10    
  , stirmcd    
  , spvpmcd    
  , smtmcd    
  , smtmcd100    
  , smtml    
  , stcmcl    
  , rut     
  , monemi    
  , sbasemi    
  , sfecemi--20    
  , sfecven    
  , stasemi    
  , Nemo    
  , stmmt    
  , Cod    
  , CodInst     
  , Id    
  , Monto--28    
  , codserie    
  , srefmonemi--30    
  , scorte--31    
  , sseriado    
  , slecemi--33    
  , sfecpro    
  , hndw    
  , precio    
  , smasc--36    
  , estado    
  , fTir  
  , fPvp  
  , fMT  
  , fMTUM  
  , fMT_cien  
  , fVan  
  , fVpar  
  , nNumucup  
  , cFecucup  
  , fIntucup  
  , fAmoucup  
  , fSalucup  
  , nNumpcup  
  , cFecpcup  
  , fIntpcup  
  , fAmopcup  
  , fSalpcup  
  , fDurat  
  , fConvx  
  , fDurmo  
  , ClaveDCV    
  , codigo_operador_comprador  
   
    FROM #TMP_PASO_RET     
   WHERE nominal <> 0    
    
END  
GO
