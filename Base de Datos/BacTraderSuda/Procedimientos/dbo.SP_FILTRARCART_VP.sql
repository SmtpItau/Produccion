USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTRARCART_VP]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FILTRARCART_VP]  
   (   @rutcart1            NUMERIC(09,0)  
   ,   @sqlvari1            NUMERIC(04,0)  
   ,   @sqlfami1            VARCHAR(255)  
   ,   @sqlemis1            VARCHAR(255)  
   ,   @sqlmone1            VARCHAR(255)  
   ,   @sqlseri1            CHAR(255)  
   ,   @codigo_carterasuper CHAR(10)  
   ,   @cUsuario            CHAR(10)   
   ,   @id_libro            CHAR(06) = ''  
   ,   @cModPago     CHAR(01) = 'T'  
   ,   @iDPV                INTEGER = 0  
   ,   @fecModPago			 cHar(10) =''   -- VFBF 11/07/2018 funcionalidad T+2 
   )  
AS  
BEGIN  
  
SET NOCOUNT ON  
  
DECLARE @nError         NUMERIC (02,0)  
DECLARE @usuario        CHAR    (20)  
DECLARE @usuario2       CHAR    (20)  
DECLARE @hwnd2          NUMERIC (09,0)  
DECLARE @rutcart        NUMERIC(09,0)  
DECLARE @tipcart        NUMERIC(05,0)  
DECLARE @numdocu        NUMERIC(10,0)  
DECLARE @correla        NUMERIC(03,0)  
DECLARE @numdocuo       NUMERIC(10,0)   -- 'Utilizado para accesar a VIEW_NOSERIE  
DECLARE @correlao       NUMERIC(03,0)   -- 'Utilizado para accesar a VIEW_NOSERIE  
DECLARE @tipoper        CHAR(03)  
DECLARE @serie          CHAR(12)  
DECLARE @instser        CHAR(12)  
DECLARE @genemi         CHAR(10)  
DECLARE @nemmon         CHAR(05)  
DECLARE @nominal        NUMERIC(19,4)  
DECLARE @tircomp        NUMERIC(19,4)  
DECLARE @pvpcomp        NUMERIC(19,2)  
DECLARE @vptirc         NUMERIC(19,4)  
DECLARE @pvpmcd         NUMERIC(19,2)  
DECLARE @tirmcd         NUMERIC(19,4)  
DECLARE @vpmcd100       REAL  
DECLARE @vpmcd          NUMERIC(19,4)  
DECLARE @vptirci        NUMERIC(19,4)  
DECLARE @fecsal         CHAR(10)  
DECLARE @numucup        NUMERIC(03,0)  
DECLARE @interesc       NUMERIC(19,4)  
DECLARE @reajustc       NUMERIC(19,4)  
DECLARE @intereci       NUMERIC(19,4)  
DECLARE @reajusci       NUMERIC(19,4)  
DECLARE @capitalc       NUMERIC(19,4)  
DECLARE @capitaci       NUMERIC(19,4)  
DECLARE @codigo         NUMERIC(03,0)  
DECLARE @mascara        CHAR(12)  
DECLARE @tasest         NUMERIC(09,4)  
DECLARE @rutemi         NUMERIC(09,0)  
DECLARE @monemi         NUMERIC(03,0)  
DECLARE @tasemi         NUMERIC(09,4)  
DECLARE @basemi         NUMERIC(03,0)  
DECLARE @fecemi         CHAR(10)  
DECLARE @fecven         CHAR(10)  
DECLARE @cseriado       CHAR(01)  
DECLARE @fecpcup        CHAR(10)  
DECLARE @xfecpcup       DATETIME  
DECLARE @Contador       NUMERIC(19,4)  
DECLARE @x              INTEGER  
DECLARE @y              INTEGER  
  
 DECLARE @xcorrelativo NUMERIC(5)  
  
SELECT  @xfecpcup = ' '  
  
  
DECLARE @sqlfijo1       VARCHAR(255)  
DECLARE @sqlfijo2       VARCHAR(255)  
DECLARE @sqlfijo3       VARCHAR(255)  
DECLARE @fecproc        DATETIME  
  
 /* PRD-5521 */  
DECLARE @nreg NUMERIC(9),  
 @treg NUMERIC(9),  
 @xnumdocu NUMERIC(9,0),  
 @xnominal NUMERIC(19,4),  
 @xinstser CHAR(12),  
 @factor NUMERIC(19,4)  
 /* fin PRD-5521 */  
  
SELECT  @fecproc        = acfecproc   
FROM    MDAC  
  
-- +++ VFBF 11/07/2018 se agrega funcionalidad t+2
IF @fecModPago ='' SET @fecModPago = CONVERT(CHAR(10),@fecproc,103)        

  
-- --- VFBF 11/07/2018 se agrega funcionalidad t+2
SELECT @x = 0  
SELECT @y = 0  
SELECT @Contador = 0  
  
   CREATE TABLE #temp2 (  
  nerror  NUMERIC (02,0)  NULL,  
                hwnd2  NUMERIC (09,0)  NULL,  
                usuario2 CHAR    (20)  NULL,  
                rutcart  NUMERIC(9,0)  NULL,  
                tipcart  NUMERIC(4,0)  NULL,  
                numdocu  NUMERIC(9,0)  NULL,  
                correla  NUMERIC(3,0)  NULL,  
                numdocuo NUMERIC(9,0)  NULL,  
                correlao NUMERIC(3,0)  NULL,  
                tipoper  CHAR    (03)  NULL,  
                seserie  CHAR(12)  NULL,  
                instser  CHAR(12)  NULL,  
                genemi  CHAR(05)  NULL,  
                nemmon  CHAR(05)  NULL,  
                nominal  NUMERIC(19,4)  NULL,  
                tircomp  NUMERIC(19,4)  NULL,  
                pvpcomp  NUMERIC(19,4)  NULL,  
                vptirc  NUMERIC(19,4)  NULL,  
                pvpmcd  NUMERIC(19,4)  NULL,  
                tirmcd  NUMERIC(19,4)  NULL,  
                vpmcd100 NUMERIC(19,4)  NULL,  
                vpmcd  NUMERIC(19,4)  NULL,  
                vptirci  NUMERIC(19,4)  NULL,  
                fecsal  CHAR(10)  NULL,  
                numucup  NUMERIC( 5,0)  NULL,  
  interesc NUMERIC(19,4)  NULL,  
                reajustc NUMERIC(19,4)  NULL,  
                intereci NUMERIC(19,4)  NULL,  
                reajusci NUMERIC(19,4)  NULL,  
    capitalc NUMERIC(19,4)  NULL,  
                capitaci NUMERIC(19,4)  NULL,  
                codigo  NUMERIC(03,0)  NULL,  
                 mascara  CHAR(12)  NULL,  
      tasest  NUMERIC(19,4)  NULL,  
                rutemi  NUMERIC( 9,0)  NULL,  
                monemi  NUMERIC(03,0)  NULL,  
                tasemi  NUMERIC(09,4)  NULL,  
                basemi  NUMERIC(03,0)  NULL,  
                fecemi  CHAR(10)  NULL,  
                fecven  DATETIME  NULL,  
  fecpcup  CHAR(10)  NULL,  
  bloq  CHAR(1)   NULL,  
  diasdisp NUMERIC( 5,0)  NULL,  
  custodia_dcv CHAR(01)  NULL,  
  seriados CHAR(01)  NULL,  
  convexidad FLOAT   NULL,  
  durationMAC FLOAT   NULL,  
  durationMOD FLOAT   NULL,  
  nombre_carterasuper CHAR(20)  NULL,  
  id_libro CHAR(06) NULL ,  
  Modalidad_Pago CHAR(1)   
  )  
 INSERT INTO #temp2   
        SELECT isnull(@nError,0) ,  
               isnull(@hwnd2,0)      ,         
               isnull(@usuario2,'')   ,         
               dirutcart    ,  
               ditipcart    ,  
               dinumdocu    ,  
               dicorrela    ,  
               dinumdocuo   ,  
               dicorrelao   ,  
               ditipoper    ,  
               diserie      ,  
               diinstser    ,  
               digenemi     ,  
               dinemmon     ,  
               dinominal    ,  
               ditircomp    ,  
               dipvpcomp    ,  
               divptirc     ,  
               dipvpmcd     ,  
               ditirmcd     ,  
               0     ,  --divpmcd100   ,  
               divpmcd      ,  
               divptirc     ,  --divptirci  
               CONVERT(CHAR(10),difecsal,103),  
               dinumucup    ,  
               0            ,   --diinteresc   ,  
               0,    --direajustc   ,  
               0,   --diintereci   ,  
               0,   --direajusci   ,  
               divptirc     ,  --dicapitalc   ,  
               divptirc     ,  --dicapitaci ,  
   cpcodigo      ,  
  cpmascara     ,  
  cptasest      ,  
  CASE   
     WHEN cpseriado = 'S'  THEN (SELECT distinct serutemi FROM view_serie WHERE semascara = cpmascara)  
      ELSE (SELECT distinct nsrutemi FROM VIEW_NOSERIE WHERE nsrutcart = dirutcart AND nsnumdocu = dinumdocu AND nscorrela = dicorrela) END,  
  CASE   
     WHEN cpseriado = 'S'  THEN (SELECT distinct semonemi FROM view_serie WHERE semascara = cpmascara)  
      ELSE (SELECT distinct nsmonemi FROM VIEW_NOSERIE WHERE nsrutcart = dirutcart AND nsnumdocu = dinumdocu AND nscorrela = dicorrela) END,  
  CASE   
     WHEN cpseriado = 'S'  THEN (SELECT distinct setasemi FROM view_serie WHERE semascara = cpmascara)  
      ELSE (SELECT distinct nstasemi FROM VIEW_NOSERIE WHERE nsrutcart = dirutcart AND nsnumdocu = dinumdocu AND nscorrela = dicorrela) END,  
  CASE   
     WHEN cpseriado = 'S'  THEN (SELECT distinct sebasemi FROM view_serie WHERE semascara = cpmascara)  
      ELSE (SELECT distinct nsbasemi FROM VIEW_NOSERIE WHERE nsrutcart = dirutcart AND nsnumdocu = dinumdocu AND nscorrela = dicorrela) END,  
  CONVERT(CHAR(10),cpfecemi,103),  
  cpfecven,  
  CONVERT(CHAR(10),cpfecpcup,103),  
  CASE   
     WHEN EXISTS( SELECT * FROM mdbl WHERE blrutcart = dirutcart AND blnumdocu = dinumdocu AND blcorrela = dicorrela AND blhwnd <> 0 ) THEN '*'  
     WHEN EXISTS( SELECT * FROM mdbl WHERE blrutcart = dirutcart AND blnumdocu = dinumdocu AND blcorrela = dicorrela AND blhwnd  = 0 AND blusuario <> @cUsuario) THEN '*'  
     WHEN EXISTS( SELECT * FROM mdbl WHERE blrutcart = dirutcart AND blnumdocu = dinumdocu AND blcorrela = dicorrela AND blhwnd  = 0 AND blusuario = @cUsuario)  THEN 'B'  
    ELSE ' ' END,  
  DATEDIFF(day,acfecproc,difecsal),  
  mdcp.cpdcv,  
  mdcp.cpseriado,  
  mdcp.cpconvex   ,  
  mdcp.cpdurat   ,  
  mdcp.cpdurmod   ,  
  mdcp.codigo_carterasuper,  
  mdcp.id_libro,  
  CASE WHEN EXISTS( SELECT 1 FROM MDMOPM WHERE monumdocu = dinumdocu and mocorrela = dicorrela and mofecpro = acfecproc and motipoper = 'CP' and PagoMañana = 'S' and SorteoLCHR = 'N') THEN 'M'  
       ELSE 'H'  
  END  
  FROM MDDI a, MDCP, MDAC  
  WHERE dirutcart = @rutcart1   
  AND   ditipcart = @sqlvari1  
  AND   CHARINDEX(RTRIM(LTRIM(diserie)),@sqlfami1) > 0  
  AND   CHARINDEX(RTRIM(LTRIM(digenemi)),@sqlemis1) > 0  
  AND CHARINDEX(RTRIM(LTRIM(dinemmon)),@sqlmone1) > 0  
  AND dinominal > 0  
  AND ditipoper = 'CP'  
  AND cprutcart = dirutcart       
  AND cpnumdocu = dinumdocu       
  AND cpcorrela = dicorrela  
--  AND SUBSTRING( diserie, 1, 3 ) <> 'DPX'  
  AND   a.Estado_Operacion_Linea = ''  
  AND (MDCP.id_libro = @id_libro OR @id_libro = '')  
  AND  (a.codigo_carterasuper = @codigo_carterasuper OR @codigo_carterasuper = '')  
  /* +++ VB 05/07/2018 SE AGREGA CONDICION PARA CN */
  AND A.Fecha_PagoMañana <= CONVERT(DATETIME,@fecModPago ,103)  -- VB
  
  
   IF @iDPV = 1  
   BEGIN  
      DELETE #TEMP2  
      WHERE  LTRIM(RTRIM(custodia_dcv)) NOT IN('D')  
   END  
  
   IF @cModPago = 'H'   
   BEGIN  
      DELETE #TEMP2  
      WHERE  EXISTS( SELECT 1 FROM MDMOPM a , MDAC WHERE numdocu      = a.monumdocu   
                                              AND correla      = a.mocorrela   
                                              AND a.mofecpro   = acfecproc   
                                              AND a.motipoper  = 'CP'   
                                              AND a.PagoMañana = 'S'   
                                              AND a.SorteoLCHR = 'N')  
   END  
  
      /*  
   IF @cModPago = 'M'   
   BEGIN  
  
      DELETE #TEMP2  
      WHERE  NOT EXISTS( SELECT 1 FROM MDMOPM a , MDAC WHERE numdocu      = a.monumdocu   
                                                  AND correla      = a.mocorrela   
                                                  AND a.mofecpro   = acfecproc   
                                                  AND a.motipoper  = 'CP'   
                                                  AND a.PagoMañana = 'S'   
                                                  AND a.SorteoLCHR = 'N')  
  
   END   
      */  
  
  
  /* Inicio PRD-5521 */  
  
   CREATE TABLE #temp3(  
 tnumdocu NUMERIC(9,0) NULL,  
 tcorrela NUMERIC(3,0) NULL,  
 tinstser CHAR(12) NULL,  
 tnominal NUMERIC(19,4) NULL,  
 tfactor  NUMERIC(19,4) NULL,  
 tnumreg  NUMERIC(9,0) IDENTITY)  
  
   INSERT INTO #temp3  
   SELECT numdocu, correla, instser, nominal, 1 FROM #temp2  
   SELECT @nreg = 0  
   SELECT @treg = COUNT(*) FROM #temp3   
   WHILE @nreg < @treg  
   BEGIN  
 SELECT @nreg = @nreg + 1  
 SELECT @xnumdocu = tnumdocu,  
        @xinstser = tinstser,  
        @xnominal = tnominal,   
        @xcorrelativo=tcorrela  
 FROM #temp3  
 WHERE tnumreg = @nreg  
  
 SELECT @factor = 0.0000  
 EXECUTE Bacparamsuda..SP_CALCULAFACTOR @xnumdocu, @xcorrelativo, @xinstser, @xnominal, @factor OUTPUT  
  
 UPDATE #temp3  
 SET tfactor = CASE  WHEN @factor = 0 THEN 1 ELSE @factor END   
 WHERE tnumreg = @nreg  
   END  
  
   UPDATE #temp2  
   SET  vptirc   = vptirc * tfactor,  
 interesc = interesc * tfactor,  
 capitalc = capitalc * tfactor,  
 reajustc = reajustc * tfactor  
   FROM #temp2, #temp3  
   WHERE numdocu = tnumdocu  
   AND correla   = tcorrela  
   AND instser   = tinstser  
  
  /* Fin PRD-5521 */  
  
  
 IF @sqlseri1 = 'VACIO'  
 BEGIN  
  
  
     SELECT * into #tem_seri from #temp2 where codigo in (6,7,9,11,13,14) order by fecven  
            INSERT #tem_seri select * from #temp2 where codigo not in (6,7,9,11,13,14) ORDER BY instser   
     SELECT   nerror ,   
                hwnd2,  
                usuario2,  
                rutcart,  
                tipcart,  
                numdocu,  
                correla,  
                numdocuo,  
                correlao,  
                tipoper,  
                seserie,  
                instser  ,  
                genemi  ,  
  nemmon  ,  
                nominal  ,  
                tircomp  ,  
                pvpcomp  ,  
                vptirc  ,  
                pvpmcd  ,  
                tirmcd  ,  
                vpmcd100 ,  
                vpmcd  ,  
  vptirci  ,  
                fecsal  ,  
                numucup  ,  
                interesc ,  
    reajustc ,  
                intereci ,  
                reajusci ,  
                capitalc ,  
                capitaci ,  
                codigo  ,  
                mascara  ,  
                tasest  ,  
                rutemi  ,  
         monemi  ,  
                tasemi  ,  
                basemi  ,  
                fecemi  ,  
                convert(char(10),fecven,103),  
  fecpcup  ,  
  bloq  ,  
  diasdisp ,  
  custodia_dcv ,  
  seriados ,  
  convexidad ,  
  durationMAC ,  
  durationMOD ,  
  nombre_carterasuper ,  
  id_libro ,  
  Modalidad_Pago  
FROM #tem_seri order by instser  
 END ELSE BEGIN  
 declare @sqlaux varchar(255)  
 declare @sqlaux2 varchar(255)  
 declare @cont INTEGER  
 select @sqlaux2 = ''  
         WHILE 1 = 1  
         begin  
            select @cont =  CHARINDEX(';',@sqlseri1)  
            if @cont = 0  
            begin  
               break  
            end  
            select @sqlaux = char(39) + SUBSTRING( @sqlseri1, 1, @cont - 1) + char(39) + ' OR instser = '  
            select @sqlaux2 = @sqlaux2 + @sqlaux  
            select @sqlseri1 = RTRIM(SUBSTRING(@sqlseri1,@cont + 1,LEN(@sqlseri1)))   
         
         end  
         SELECT @sqlaux = RTRIM(SUBSTRING(@sqlaux2,1,LEN(@sqlaux2)-13))   
      EXECUTE ('SELECT * FROM #temp2 WHERE instser = ' + @sqlaux + ' ORDER BY instser' )  
 End  
 DROP TABLE #temp3  
 SET NOCOUNT OFF  
END
GO
