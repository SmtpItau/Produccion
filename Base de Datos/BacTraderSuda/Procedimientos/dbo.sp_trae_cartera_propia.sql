USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_trae_cartera_propia]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_trae_cartera_propia]  
AS  
BEGIN  

/* LD1-COR-035 FUSION CORPBANCA - ITAU -->ACTUALIZACION CARTERA VOLCKER RULE **/
/***********************************************************************/
/*SISTEMA: BACTRADERSUDA */

	declare @sqlseri1  CHAR (255)
	select @sqlseri1  = 'vacio'
	
	DECLARE @nError  NUMERIC (02,0) ,  
		  @usuario CHAR    (20) ,  
		  @usuario2 CHAR    (20) ,  
		  @hwnd2  NUMERIC (09,0) ,  
		  @rutcart NUMERIC (09,0) ,  
		  @tipcart NUMERIC (05,0) ,  
		  @numdocu NUMERIC (10,0) ,  
		  @correla NUMERIC (03,0) ,  
		  @numdocuo NUMERIC (10,0) , -- 'Utilizado para accesar a VIEW_NOSERIE  
		  @correlao NUMERIC (03,0) , -- 'Utilizado para accesar a VIEW_NOSERIE  
		  @tipoper CHAR (03) ,  
		  @serie  CHAR (12) ,  
		  @instser CHAR (12) ,  
		  @genemi  CHAR (10) ,  
		  @nemmon  CHAR (05) ,  
		  @nominal NUMERIC (19,4) ,  
		  @tircomp NUMERIC (19,4) ,  
		  @pvpcomp NUMERIC (19,2) ,  
		  @vptirc  NUMERIC (19,4) ,  
		  @pvpmcd  NUMERIC (19,2) ,  
		  @tirmcd  NUMERIC (19,4) ,  
		  @vpmcd100 FLOAT  ,  
		  @vpmcd  NUMERIC (19,4) ,  
		  @vptirci NUMERIC (19,4) ,  
		  @fecsal  CHAR (10) ,  
		  @numucup NUMERIC (03,0) ,  
		  @interesc NUMERIC (19,4) ,  
		  @reajustc NUMERIC (19,4) ,  
		  @intereci NUMERIC (19,4) ,  
		  @reajusci NUMERIC (19,4) ,  
		  @capitalc NUMERIC (19,4) ,  
		  @capitaci NUMERIC (19,4) ,  
		  @codigo  NUMERIC (03,0) ,  
		  @mascara CHAR (12) ,  
		  @tasest  NUMERIC (09,4) ,  
		  @rutemi  NUMERIC (09,0) ,  
		  @monemi  NUMERIC (03,0) ,  
		  @tasemi  NUMERIC (09,4) ,  
		  @basemi  NUMERIC (03,0) ,  
		  @fecemi  CHAR (10) ,  
		  @fecven  CHAR (10) ,  
		  @cseriado CHAR (01) ,  
		  @fecpcup CHAR (10) ,  
		  @xfecpcup DATETIME ,  
		  @Contador NUMERIC (19,4) ,  
		  @x  INTEGER  ,  
		  @y  INTEGER  ,  
		  @sqlfijo1 VARCHAR (255) ,  
		  @sqlfijo2 VARCHAR (255) ,  
		  @sqlfijo3 VARCHAR (255) ,  
		  @fecproc DATETIME
		  
  
	SET NOCOUNT ON  
  
	SELECT @xfecpcup = ' ' ,  
		  @x  = 0 ,  
		  @y  = 0 ,  
		  @Contador = 0  
  
	SELECT @fecproc = acfecproc FROM MDAC  WITH(NOLOCK)
  
	CREATE TABLE  
	#temp2  
		  (  
		  nerror  NUMERIC (02,0) NULL ,  
		  hwnd2  NUMERIC (09,0) NULL ,  
		  usuario2 CHAR (20) NULL ,  
		  rutcart  NUMERIC (9,0) NULL ,  
		  tipcart  NUMERIC (3,0) NULL ,  
		  numdocu  NUMERIC (6,0) NULL ,  
		  correla  NUMERIC (3,0) NULL ,  
		  numdocuo NUMERIC (6,0) NULL ,  
		  correlao NUMERIC (3,0) NULL ,  
		  tipoper  CHAR (03) NULL ,  
		  seserie  CHAR (12) NULL ,  
		  instser  CHAR (12) NULL ,  
		  genemi  CHAR (05) NULL ,  
		  nemmon  CHAR (05) NULL ,  
		  nominal  NUMERIC (19,4) NULL ,  
		  tircomp  NUMERIC (19,4) NULL ,  
		  pvpcomp  NUMERIC (19,4) NULL ,  
		  vptirc  NUMERIC (19,4) NULL ,  
		  pvpmcd  NUMERIC (19,4) NULL ,  
		  tirmcd  NUMERIC (19,4) NULL ,  
		  vpmcd100 NUMERIC (19,4) NULL ,  
		  vpmcd  NUMERIC (19,4) NULL ,  
		  vptirci  NUMERIC (19,4) NULL ,  
		  fecsal  CHAR (10) NULL ,  
		  numucup  NUMERIC (05,0) NULL ,  
		  interesc NUMERIC (19,4) NULL ,  
		  reajustc NUMERIC (19,4) NULL ,  
		  intereci NUMERIC (19,4) NULL ,  
		  reajusci NUMERIC (19,4) NULL ,  
		  capitalc NUMERIC (19,4) NULL ,  
		  capitaci NUMERIC (19,4) NULL ,  
		  codigo  NUMERIC (03,0) NULL ,  
		  mascara  CHAR (12) NULL ,  
		  tasest  NUMERIC (19,4) NULL ,  
		  rutemi  NUMERIC (09,0) NULL ,  
		  monemi  NUMERIC (03,0) NULL ,  
		  tasemi  NUMERIC (09,4) NULL ,  
		  basemi  NUMERIC (03,0) NULL ,  
		  fecemi  CHAR (10) NULL ,  
		  fecven  DATETIME NULL ,  
		  fecpcup  CHAR (10) NULL ,  
		  bloq  VARCHAR (15) NULL ,  
		  diasdisp NUMERIC (05,0) NULL ,  
		  custodia_dcv CHAR (01) NULL ,  
		  seriados CHAR (01) NULL ,  
		  convexidad FLOAT  NULL ,  
		  durationMAC FLOAT  NULL ,  
		  durationMOD FLOAT  NULL ,  
		  nombre_carterasuper CHAR(20) NULL ,  
		  contrato NUMERIC (10) NULL ,  
		  diascartera NUMERIC (05,0) NULL,
		  tbglosa CHAR(50) NULL,
		  tbglosaVoucker CHAR(30) NULL   
		  )  
  
	INSERT INTO  #temp2  

	SELECT @nError  ,	--1
		  @hwnd2  ,		--2
		  @usuario2 ,	--3
		  dirutcart ,	--4
		  ditipcart ,	--5
		  dinumdocu ,	--6
		  dicorrela ,	--7
		  dinumdocuo ,  --8
		  dicorrelao ,  --9
		  ditipoper ,	--10
		  diserie  ,	--11
		  diinstser ,   --12
		  digenemi ,    --13
		  dinemmon ,    --14
		  dinominal-dinomigarantia + ISNULL((SELECT sum(vinominal) FROM mdvi WITH(NOLOCK) WHERE vitipoper  = 'CP' and vinumdocu = cpnumdocu and vicorrela = cpcorrela and viinstser = cpinstser),0),
		  ditircomp ,	--16
		  dipvpcomp ,	--17
		  (case when dinemmon<>'USD' THEN  --18
		   ROUND((((dinominal-dinomigarantia + ISNULL((SELECT sum(vinominal) FROM mdvi WITH(NOLOCK) WHERE vitipoper  = 'CP' and vinumdocu = cpnumdocu and vicorrela = cpcorrela and viinstser = cpinstser),0))
				/(dinominal + ISNULL((SELECT sum(vinominal) FROM mdvi  WITH(NOLOCK) WHERE vitipoper  = 'CP' and vinumdocu = cpnumdocu and vicorrela = cpcorrela and viinstser = cpinstser),0))
				)*divptirc),0)   
			   ELSE  
		   ROUND((((dinominal-dinomigarantia + ISNULL((SELECT sum(vinominal) FROM mdvi WITH(NOLOCK) WHERE vitipoper  = 'CP' and vinumdocu = cpnumdocu and vicorrela = cpcorrela and viinstser = cpinstser),0))
					/(dinominal + ISNULL((SELECT sum(vinominal) FROM mdvi WITH(NOLOCK) WHERE vitipoper  = 'CP' and vinumdocu = cpnumdocu and vicorrela = cpcorrela and viinstser = cpinstser),0))
					)*divptirc),2)   
			   END) ,  
		  dipvpmcd ,	--19
		  ditirmcd ,	--20
		  Case when cpfeccomp = @fecproc THEN divptirc ELSE divpmcd100 END ,  
		  Case when cpfeccomp = @fecproc THEN divptirc ELSE divpmcd100 END ,  
		  --ROUND((((dinominal-dinomigarantia + ISNULL((SELECT sum(vinominal) FROM mdvi WHERE vitipoper  = 'CP' and vinumdocu = cpnumdocu and vicorrela = cpcorrela and viinstser = cpinstser),0))
			--		/dinominal)*divptirc),0) ,  --wms  
		  (case when dinemmon<>'USD' THEN  
		   ROUND((((dinominal-dinomigarantia + ISNULL((SELECT sum(vinominal) FROM mdvi WITH(NOLOCK) WHERE vitipoper  = 'CP' and vinumdocu = cpnumdocu and vicorrela = cpcorrela and viinstser = cpinstser),0))
					)),0)--/dinominal)*divptirc),0)   
			   ELSE  
		   ROUND((((dinominal-dinomigarantia + ISNULL((SELECT sum(vinominal) FROM mdvi WITH(NOLOCK) WHERE vitipoper  = 'CP' and vinumdocu = cpnumdocu and vicorrela = cpcorrela and viinstser = cpinstser),0))
					)),2)--/dinominal)*divptirc),2)   
			   END) ,  
		  CONVERT(CHAR(10),difecsal,103) ,  
		  dinumucup ,  
		  0  , --diinteresc   ,  
		  0  , --direajustc   ,  
		  0  , --diintereci   ,  
		  0  , --direajusci   ,  
		  --ROUND((((dinominal-dinomigarantia + ISNULL((SELECT sum(vinominal) FROM mdvi WHERE vitipoper  = 'CP' and vinumdocu = cpnumdocu and vicorrela = cpcorrela and viinstser = cpinstser),0))
		  --		/dinominal)*divptirc),0) ,  --wms  
		  --ROUND((((dinominal-dinomigarantia + ISNULL((SELECT sum(vinominal) FROM mdvi WHERE vitipoper  = 'CP' and vinumdocu = cpnumdocu and vicorrela = cpcorrela and viinstser = cpinstser),0))
		  --		/dinominal)*divptirc),0) ,  --wms  
		  (case when dinemmon<>'USD' THEN  
		   ROUND((((dinominal-dinomigarantia + ISNULL((SELECT sum(vinominal) FROM mdvi WITH(NOLOCK)  WHERE vitipoper  = 'CP' and vinumdocu = cpnumdocu and vicorrela = cpcorrela and viinstser = cpinstser),0))
				)),0)--/dinominal)*divptirc),0)   
			   ELSE  
		   ROUND((((dinominal-dinomigarantia + ISNULL((SELECT sum(vinominal) FROM mdvi WITH(NOLOCK) WHERE vitipoper  = 'CP' and vinumdocu = cpnumdocu and vicorrela = cpcorrela and viinstser = cpinstser),0))
				)),2)--/dinominal)*divptirc),2)   
			   END) ,  
		  (case when dinemmon<>'USD' THEN  
		   ROUND((((dinominal-dinomigarantia + ISNULL((SELECT sum(vinominal) FROM mdvi WITH(NOLOCK) WHERE vitipoper  = 'CP' and vinumdocu = cpnumdocu and vicorrela = cpcorrela and viinstser = cpinstser),0))
				)),0)--/dinominal)*divptirc),0)   
			   ELSE  
		   ROUND((((dinominal-dinomigarantia + ISNULL((SELECT sum(vinominal) FROM mdvi WITH(NOLOCK) WHERE vitipoper  = 'CP' and vinumdocu = cpnumdocu and vicorrela = cpcorrela and viinstser = cpinstser),0))
				)),2)--/dinominal)*divptirc),2)   
			   END) ,  
		  cpcodigo ,  
		  cpmascara ,  
		  cptasest ,  
		  CASE  
		   WHEN cpseriado='S' THEN (SELECT serutemi FROM view_serie WHERE semascara=cpmascara)  
		   ELSE (SELECT nsrutemi FROM VIEW_NOSERIE WHERE nsrutcart=dirutcart AND nsnumdocu=dinumdocu AND nscorrela=dicorrela)  
		  END ,  
		  CASE  
		   WHEN cpseriado='S' THEN (SELECT semonemi FROM view_serie WHERE semascara=cpmascara)  
		   ELSE (SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsrutcart=dirutcart AND nsnumdocu=dinumdocu AND nscorrela=dicorrela)  
		  END ,  
		  CASE  
		   WHEN cpseriado='S' THEN (SELECT setasemi FROM view_serie WHERE semascara=cpmascara)  
		   ELSE (SELECT nstasemi FROM VIEW_NOSERIE WHERE nsrutcart=dirutcart AND nsnumdocu=dinumdocu AND nscorrela=dicorrela)  
		  END ,  
		  CASE  
		   WHEN cpseriado='S' THEN (SELECT sebasemi FROM view_serie WHERE semascara=cpmascara)  
		   ELSE (SELECT nsbasemi FROM VIEW_NOSERIE WHERE nsrutcart=dirutcart AND nsnumdocu=dinumdocu AND nscorrela=dicorrela)  
		  END    ,  
		  CONVERT(CHAR(10),cpfecemi,103) ,  
		  cpfecven   ,  
		  CONVERT(CHAR(10),cpfecpcup,103) ,  
		  
		  CASE  WHEN EXISTS(SELECT 1 FROM MDBL WITH(NOLOCK) WHERE blrutcart=dirutcart AND blnumdocu=dinumdocu AND blcorrela=dicorrela AND blhwnd<>0)	THEN '*'  
				WHEN EXISTS(SELECT 1 FROM MDBL WITH(NOLOCK) WHERE blrutcart=dirutcart AND blnumdocu=dinumdocu AND blcorrela=dicorrela AND blhwnd=0)		THEN 
					(SELECT blusuario FROM MDBL WITH(NOLOCK) WHERE blrutcart=dirutcart AND blnumdocu=dinumdocu AND blcorrela=dicorrela AND blhwnd=0)  
		   ELSE ' '  
		  END    ,  
		  DATEDIFF(DAY,acfecproc,difecsal),  
		  cpdcv    ,  
		  cpseriado   ,  
		  cpconvex   ,  
		  cpdurat    ,  
		  cpdurmod   ,  
		  MDCP.codigo_carterasuper ,  
		  MDCP.numero_contrato  ,  
		  Datediff(day,mdcp.cpfeccomp,acfecproc), 
		  RTRIM(tbglosa),

		  'tbglosaVoucker' = ISNULL((SELECT det.tbglosa FROM BacParamSuda..TABLA_GENERAL_DETALLE det WHERE det.tbcateg = 206 AND det.tbcodigo1 = mdcp.volcker_rule),'')

	FROM MDDI a WITH(NOLOCK) 
			INNER JOIN MDCP WITH(NOLOCK) ON cprutcart		= dirutcart AND cpnumdocu	= dinumdocu AND cpcorrela	= dicorrela
			INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE WITH(NOLOCK)  ON tbcateg = 204 AND tbcodigo1 = a.ditipcart
		,MDAC
	WHERE (dinominal-dinomigarantia + ISNULL((SELECT sum(vinominal) FROM mdvi WITH(NOLOCK)  WHERE vitipoper  = 'CP' and vinumdocu = cpnumdocu and vicorrela = cpcorrela and viinstser = cpinstser),0)) >0   
		AND ditipoper = 'CP'    
		AND difecsal > @fecproc  

  		  
 IF @sqlseri1='VACIO'  
	BEGIN  

	  SELECT * INTO #tem_seri FROM #temp2 WHERE codigo IN (6,7,9,11,13,14) ORDER BY fecven  
		

		INSERT #tem_seri 
		SELECT * FROM #temp2 WHERE codigo NOT IN (6,7,9,11,13,14) ORDER BY instser,diascartera DESC  
  
  
		SELECT nerror  ,  
			hwnd2  ,  
			usuario2 ,  
			rutcart  ,  
			tipcart  ,  
			numdocu  ,  
			correla  ,  
			numdocuo ,  
			correlao ,  
			tipoper  ,  
			seserie  ,  
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
			CONVERT(CHAR(10),fecven,103) ,  
			fecpcup  ,  
			bloq  ,  
			diasdisp ,  
			custodia_dcv ,  
			seriados ,  
			convexidad ,  
			durationMAC ,  
			durationMOD ,  
			nombre_carterasuper ,  
			contrato,  
			diascartera
			,tbglosa
			,tbglosaVoucker  
		FROM #tem_seri  
		ORDER BY codigo,diascartera DESC  

	END ELSE  
	BEGIN  
		  DECLARE @sqlaux  VARCHAR (255) ,  
		   @sqlaux2 VARCHAR (255) ,  
		   @cont  INTEGER  
		  
		  SELECT @sqlaux2 = ''  
  
		WHILE 1=1  
		BEGIN  
			SELECT @cont = CHARINDEX(';',@sqlseri1)  
			IF @cont=0  
				BREAK  

			--SELECT @sqlaux  = ''''+SUBSTRING(@sqlseri1,1,@cont-1)+''' OR instser= '  
			SELECT @sqlaux  = char(39) + SUBSTRING(@sqlseri1,1,@cont-1)+char(39)+' OR instser='  
			SELECT @sqlaux2 = @sqlaux2+@sqlaux  
			SELECT @sqlseri1 = RTRIM(SUBSTRING(@sqlseri1,@cont+1,LEN(@sqlseri1)))  
		END  	     
	  
		SELECT @sqlaux = RTRIM(SUBSTRING(@sqlaux2,1,LEN(@sqlaux2)-13))  
		EXECUTE('SELECT * FROM #temp2 WHERE instser= '''+@sqlaux+ '''')  
	END  
  
	SET NOCOUNT OFF  
  
END  
GO
