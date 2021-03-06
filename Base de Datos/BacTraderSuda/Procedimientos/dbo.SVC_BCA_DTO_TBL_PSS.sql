USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_BCA_DTO_TBL_PSS]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SVC_BCA_DTO_TBL_PSS]
		(@Tipo	    NUMERIC(1),
		 @serie     CHAR(20),
                 @Usuario   CHAR(15))
AS
-- Autor		: MIRIAM MORENO
-- Objetivo		: BUSCA SERIE EN TABLA PASO
-- Fecha de Creacion	: 06-04-2004
-- Modificaciones	:
-- Primera Modificacion	: 17-07-2004
-- Segunda Modificacion	: 17-07-2004
-- Antecedentes Generales : 
BEGIN
SET NOCOUNT ON

CREATE TABLE #TEMP2 (
		nerror		numeric (02,0)		null,hwnd2		numeric (09,0)		null,
                usuario2	char    (20)		null,rutcart		numeric(9,0)		null,
            	tipcart		numeric(1,0)		null,numdocu		numeric(10,0)		null,
                correla		numeric(3,0)		null,numdocuo	        numeric(10,0)		null,
                correlao	numeric(3,0)		null,tipoper		char    (03)		null,
                serie		char(12)		null,instser		char(12)		null,
                genemi		char(05)		null,nemmon		char(05)		null,
                nominal		numeric(19,4)		null,tircomp		numeric(19,4)		null,
                pvpcomp		numeric(19,4)		null,vptirc		numeric(19,4)		null,
                pvpmcd		numeric(19,4)		null,tirmcd		numeric(19,4)		null,
                vpmcd100	numeric(19,4)		null,vpmcd		numeric(19,4)		null,
                vptirci		numeric(19,4)		null,fecsal		char(10)		null,
                numucup		numeric( 5,0)		null,interesc	        numeric(19,4)		null,
                reajustc	numeric(19,4)		null,intereci	        numeric(19,4)		null,
                reajusci	numeric(19,4)		null,capitalc	        numeric(19,4)		null,
                capitaci	numeric(19,4)		null,codigo		numeric(05,0)		null,
                mascara		char(12)		null,tasest		numeric(19,4)		null,
                rutemi		numeric( 9,0)		null,monemi		numeric(03,0)		null,
	        tasemi		numeric(09,4)		null,basemi		numeric(03,0)		null,
                fecemi		char(10)		null,fecven		char(10)		null,
		fecpcup		char(10)		null,bloq		char(1)			null,
		diasdisp	numeric( 5,0)		null,custodia_dcv	char(01)		null,
		seriados	char(01)		null,convexidad	        float			null,
		durationmac	float			null,durationmod	float			null,
		nombre_carterasuper char(20) 		null,clave_dcv          char(15))

IF @Tipo = 1
BEGIN
INSERT   INTO #TEMP2
   SELECT
          nerror   = 0            ,
          hwnd2    = 0            ,
          usuario2 = ''           ,
          rutcart  = A.dirutcart  ,
          tipcart  = A.ditipcart  , 
          numdocu  = A.dinumdocu  ,
          correla  = A.dicorrela  , 
          numdocuo = 0            ,
          correlao = 0            , 
          tipoper  = A.ditipoper  ,
          serie    = A.diserie    ,
          instser  = A.diinstser  ,
          genemi   = A.digenemi   ,
          nemmon   = A.dinemmon   ,
          nominal  = Nominal      , 
          tircomp  = Tir          ,
          pvpcomp  = Vpar         , 
          vptirc   = Mt           ,
          pvpmcd   = A.dipvpmcd   , 
          tirmcd   = A.ditirmcd   ,
          vpmcd100 = 0            , 
          vpmcd    = A.divpmcd    ,
          vptirci  = Mt           , 
          fecsal   = convert(char(10),A.difecsal,103),
          numucup  = A.dinumucup  , 
          interesc = 0            ,
          reajustc = 0            , 
          intereci = 0            ,
          reajusci = 0            , 
          capitalc = Mt           ,
          capitaci = Mt           , 
          codigo   = B.cpcodigo   ,
          mascara  = B.cpmascara  , 
          tasest   = B.cptasest   ,
          rutemi   = 0            ,
          monemi   = 0            ,
          tasemi   = 0            ,
          basemi   = 0            ,
          fecemi   = convert(char(10),B.cpfecemi,103),
          fecven   = convert(char(10),B.cpfecven,103),
          fecpcup  = convert(char(10),B.cpfecpcup,103),
          bloq     = Marca         ,
          diasdisp = datediff(day,acfecproc,A.difecsal),
          custodia_dcv = B.cpdcv   ,
          seriados    = B.cpseriado, 
          convexidad  = B.cpconvex ,
          durationmac = B.cpdurat  , 
          durationmod = B.cpdurmod ,   
          nombre_carterasuper = B.codigo_carterasuper,
	  clave_dcv   = ClaveDcv
           FROM    mddi A
           ,       mdcp B
           ,       mdac
           ,       VIEW_MONEDA
           ,       FLJ_LQZ_IMD
           WHERE   A.dinemmon       = mnnemo
           AND     A.dinemmon      <> 'USD'
           AND     A.dinominal      >  0  
           AND     A.ditipoper      = 'CP' 
           AND     A.digenemi       = 'BCCH'
           AND     B.cprutcart      = A.dirutcart     
           AND     B.cpnumdocu      = A.dinumdocu    
           AND     B.cpcorrela      = A.dicorrela
           AND     B.cpinstser      = DIINSTSER
           AND     B.cpdcv          = 'D'
           AND     NumeroOP         = A.dinumdocu
           AND     Correlativo      = A.dicorrela
  	   AND     Instrumento      = A.diinstser 
           AND     Usuario          = @Usuario

	ORDER BY dicontador,diinstser

END

IF @Tipo = 2
BEGIN
INSERT  INTO #TEMP2
        SELECT 0            ,   
               0            ,
               ''           ,
               A.dirutcart    ,
               A.ditipcart    ,
               A.dinumdocu    ,
               A.dicorrela    ,
               0            ,
               0            ,
               A.ditipoper    ,
               A.diserie      ,
               A.diinstser    ,
               A.digenemi     ,
               A.dinemmon     ,
               Nominal      ,
               Tir          ,
               Vpar         ,
               Mt           ,
               A.dipvpmcd     ,
               A.ditirmcd     ,
               0	    ,
               A.divpmcd      ,
               Mt           ,
               convert(char(10),A.difecsal,103),
               A.dinumucup    ,
               0            ,
               0            ,
               0            ,
               0            ,
               Mt           ,
               Mt           ,
	       B.cpcodigo     ,
	       B.cpmascara    ,
	       B.cptasest     ,
               0            ,
               0            ,
               0            ,
               0            ,
	       convert(char(10),B.cpfecemi,103)	,
	       convert(char(10),B.cpfecven,103)	,
	       convert(char(10),B.cpfecpcup,103)	,
	       Marca				,
	       datediff(day,acfecproc,A.difecsal) ,
               Custodia			        ,
	       B.cpseriado			,
	       B.cpconvex			        ,
	       B.cpdurat			        ,
	       B.cpdurmod			        ,	
               B.codigo_carterasuper		,
	       ClaveDcv
           FROM    mddi A
           ,       mdcp B
           ,       mdac
           ,       VIEW_MONEDA
           ,       FLJ_LQZ_IMD
           WHERE   dinemmon       = mnnemo
           AND     dinemmon      <> 'USD'
           AND     dinominal      >  0  
           AND     ditipoper      = 'CP' 
           AND     digenemi       = 'BCCH'
           AND     cprutcart      = dirutcart     
           AND     cpnumdocu      = dinumdocu    
           AND     cpcorrela      = dicorrela
           AND     cpinstser      = DIINSTSER
           AND     cpdcv          = 'D'
           AND     NumeroOP       = dinumdocu
           AND     Correlativo    = dicorrela
  	   AND     Instrumento    = diinstser 
  	   AND     Instrumento    = @serie
           AND     Usuario        = @Usuario

	ORDER BY dicontador,diinstser


    END

UPDATE #temp2
SET    rutemi  = serutemi,
       monemi  = semonemi,
       tasemi  = setasemi,
       basemi  = sebasemi
FROM   VIEW_SERIE
WHERE  seriados = 'S'           
AND    mascara  = seserie

UPDATE #temp2
SET    rutemi  = nsrutemi,
       monemi  = nsmonemi,
       tasemi  = nstasemi,
       basemi  = nsbasemi
FROM   VIEW_NOSERIE
WHERE  seriados      = 'N'           
AND rutcart       = nsrutcart     
AND    numdocu       = nsnumdocu     
AND    correla       = nscorrela


 SELECT nerror, hwnd2, usuario2, rutcart,tipcart,numdocu,correla,numdocuo,correlao,tipoper,serie,instser,genemi,nemmon,nominal      ,tircomp,    pvpcomp,     vptirc,     pvpmcd,     tirmcd,     vpmcd100,       vpmcd,     vptirci, fecsal,numucup,interesc,


 reajustc, intereci,    reajusci,     capitalc,     capitaci, codigo,mascara,    tasest ,rutemi,monemi,    tasemi, basemi,fecemi,fecven,fecpcup,bloq,diasdisp,custodia_dcv,seriados,convexidad,durationmac,durationmod,nombre_carterasuper,clave_dcv 
 FROM #TEMP2 
 ORDER BY nominal DESC


END

GO
