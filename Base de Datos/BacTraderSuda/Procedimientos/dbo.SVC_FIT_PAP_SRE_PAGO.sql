USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_FIT_PAP_SRE_PAGO]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SVC_FIT_PAP_SRE_PAGO]
   (@nnumoper numeric	(10,0), @tipo   numeric (2), @serie  char(20),  @Usuario CHAR(15))
AS
-- Autor		: MIRIAM MORENO
-- Objetivo		: FILTRA PAPELES DEL BCCH
-- Fecha de Creacion	: 12-12-2003
-- Modificaciones	:
-- Primera Modificacion	: 17-07-2003
-- Segunda Modificacion	: 17-07-2003
-- Antecedentes Generales : 
BEGIN
	declare @nerror   numeric (02,0),  @usuario2 char    (20), @hwnd2   numeric (09,0)SET NOCOUNT ON
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
		nombre_carterasuper char(20) 		null,Usuario            CHAR(15)		null,
		clave_dcv       char(15)		null,Estado	        CHAR(1) 		null)



IF (SELECT DISTINCT mostatreg FROM MDMO WHERE MONUMOPER = @nnumoper) <> ''
BEGIN
	SELECT 'P'
	RETURN -1
END


	IF @tipo = 1 or @tipo = 3
	BEGIN
		INSERT INTO #TEMP2 
		SELECT	
		@nerror			,
                @hwnd2			,
		@usuario2		,
                CONVERT(CHAR(9),virutcart),	
		1                       ,
                vinumdocu		,
		vicorrela		,
                0		        ,
		0		        ,
                vitipoper		,
		a.diserie		,
                viinstser		,
		a.digenemi		,
                mnnemo			,
		vinominal		,
                vitirvent         	,
		vipvpvent		,
                vivalvenp		,
		a.divpmcd		,
                a.ditirmcd		,
		0			,
                a.divpmcd		,
		vivalvenp		,
                CONVERT(CHAR(10),a.difecsal,103),
		a.dinumucup		,
                0			,
		0			,
                0			,
		0			,
                vivalvenp		,
		vivalvenp		,
                vicodigo		,
		vimascara		,
                vitasest		,
		0                       ,
		0                       ,
		0                       ,
		0                       ,   
		CONVERT(CHAR(10),vifecemi,103),	
                CONVERT(CHAR(10),vifecven,103),
		CONVERT(CHAR(10),vifecpcup,103),
                ISNULL((SELECT 'S' FROM MDBL WHERE blrutcart = dirutcart and blnumdocu = dinumdocu and blcorrela = dicorrela), 'N'),
		datediff(day,acfecproc,a.difecsal), 	
                cpdcv			,
		viseriado		,	
                viconvex		,
		vidurat			,	
                vidurmod		,	
		a.codigo_carterasuper   ,      
                @Usuario                ,
		moclave_dcv		,
		mostatreg

                FROM	  MDDI a ,   MDVI ,     MDAC ,   MDCP ,
		          VIEW_CLIENTE,
                          VIEW_MONEDA ,
			  MDMO
		WHERE	vinumoper      = @nnumoper 	
                  and   vinumdocu      = cpnumdocu     
		  and   vicorrela      = cpcorrela   
                  and 	virutcart      = acrutprop       
		  and 	virutcli       = clrut 	
                  and	vicodcli       = clcodigo
                  and   vinumdocu      = a.dinumdocu     
		  and   vicorrela      = a.dicorrela 
		  and	monumoper      = @nnumoper 	
                  and   monumdocu      = cpnumdocu     
		  and   mocorrela      = cpcorrela   
                  and   dinemmon       = mnnemo
                  and   digenemi       = 'BCCH'
                  and   cpdcv          = 'D'
	END



	IF @tipo = 2
	BEGIN	
		INSERT INTO #TEMP2 
		SELECT	
		@nerror			,
                @hwnd2			,
		@usuario2		,
                CONVERT(CHAR(9),virutcart),	
		1                       ,
                vinumdocu		,
		vicorrela		,
                0		        ,
		0		        ,
                vitipoper		,
		a.diserie		,
                viinstser		,
		a.digenemi		,
                mnnemo			,
		vinominal		,
                vitirvent         	,
		vipvpvent		,
                vivalvenp		,
		a.divpmcd		,
                a.ditirmcd		,
		0			,
                a.divpmcd		,
		vivalvenp		,
                CONVERT(CHAR(10),a.difecsal,103),
		a.dinumucup		,
                0			,
		0			,
                0			,
		0			,
                vivalvenp		,
		vivalvenp		,
                vicodigo		,
		vimascara		,
                vitasest		,
		0                       ,
		0                       ,
		0                       ,
		0                       ,   
		CONVERT(CHAR(10),vifecemi,103),	
                CONVERT(CHAR(10),vifecven,103),
		CONVERT(CHAR(10),vifecpcup,103),
                ISNULL((SELECT 'S' FROM MDBL WHERE blrutcart = dirutcart and blnumdocu = dinumdocu and blcorrela = dicorrela), 'N'),
		datediff(day,acfecproc,a.difecsal), 	
                cpdcv			,
		viseriado		,	
                viconvex		,
		vidurat			,	
                vidurmod		,	
		a.codigo_carterasuper   ,      
                @Usuario                ,
		moclave_dcv		,
		mostatreg
                FROM	  MDDI a ,   MDVI ,     
                          MDAC   ,   MDCP ,
		          VIEW_CLIENTE,
                          VIEW_MONEDA ,
			  MDMO
		WHERE	vinumoper      = @nnumoper 	
                  and 	virutcart      = acrutprop       
		  and 	virutcli       = clrut 	
                  and	vicodcli       = clcodigo
                  and   vinumdocu      = a.dinumdocu     
		  and   vicorrela      = a.dicorrela 
                  and   vinumdocu      = cpnumdocu     
		  and   vicorrela      = cpcorrela   
                  and   viinstser      = @serie
                  and   dinemmon       = mnnemo
		  and	monumoper      = @nnumoper 	
                  and   monumdocu      = cpnumdocu     
		  and   mocorrela      = cpcorrela   
                  and   digenemi       = 'BCCH'
                  and   cpdcv          = 'D'

	END

---- Completa Información ----



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
   AND    rutcart       = nsrutcart     
   AND    numdocu       = nsnumdocu     
   AND    correla       = nscorrela

	IF @Tipo = 1
	BEGIN  
   		select nerror,hwnd2,usuario2,rutcart,0	,MIN(numdocu),MIN(correla),MIN(numdocuo),MIN(correlao),tipoper,serie,instser,
                       genemi,nemmon,SUM(nominal),AVG(tircomp),AVG(pvpcomp),SUM(vptirc),AVG(pvpmcd),AVG(tirmcd),SUM(vpmcd100),SUM(vpmcd),
                       SUM(vptirci),fecsal,0, SUM(interesc),SUM(reajustc),SUM(intereci),SUM(reajusci),SUM(capitalc),SUM(capitaci),codigo,
                       mascara,AVG(tasest),rutemi,monemi,AVG(tasemi),basemi,'',fecven,fecpcup,bloq,diasdisp,custodia_dcv,seriados,0,0,0,''
     		from #TEMP2 
      		GROUP BY nerror,hwnd2,usuario2,rutcart,tipoper,serie,instser,genemi,nemmon,fecsal,codigo,mascara,rutemi,monemi,basemi,fecven,fecpcup,bloq,diasdisp,custodia_dcv,seriados order by instser
	END

	IF @Tipo = 2 or  @tipo = 3
	BEGIN
	    select nerror,hwnd2,usuario2,rutcart,tipcart,numdocu,correla,numdocuo,correlao,tipoper,serie,instser,genemi,nemmon,nominal,
                   tircomp,    pvpcomp,	  vptirc,     pvpmcd,	  tirmcd,     vpmcd100,	    vpmcd,     vptirci, fecsal,numucup,interesc,
                   reajustc,     intereci,     reajusci,     capitalc,     capitaci, codigo,mascara,    tasest ,rutemi,monemi,    tasemi,
                   basemi,fecemi,fecven,fecpcup,bloq,diasdisp,custodia_dcv,seriados,convexidad,durationmac,durationmod,nombre_carterasuper,clave_dcv
            from #TEMP2  order by instser,nominal DESC
	END
        IF @tipo = 3
        BEGIN
        /*    IF NOT EXISTS(SELECT name FROM sysobjects WHERE name = 'FLJ_LQZ_MOD' AND type = 'U')      
   		CREATE TABLE  tempdb.guest.FLJ_LQZ_MOD
			(			Marca		CHAR(01),
			Instrumento    	CHAR(20),
			Moneda		CHAR(03),
			Emisor		CHAR(10),
			Nominal		NUMERIC(21,8),
			Tir		NUMERIC(19,4),
			Vpar		NUMERIC(19,4),
			Mt		NUMERIC(19,4),
			Custodia	CHAR(15),
			ClaveDcv	CHAR(15),
			TirCmp		NUMERIC(19,4),
			VparCmp		NUMERIC(19,4),
			MTCmp		NUMERIC(19,4),
			Utilidad	NUMERIC(19,4),
			Clasificacion	CHAR(15),
			NumeroOP	NUMERIC(10),
			Correlativo	NUMERIC(03),
                        Usuario         CHAR(15)
			) */             
              delete FLJ_LQZ_MOD
              INSERT INTO FLJ_LQZ_MOD
             select 'V',instser,nemmon,genemi,nominal,tircomp,pvpcomp,vptirc,custodia_dcv,'', tircomp,pvpcomp,vptirc,0,nombre_carterasuper,numdocu,correla,@Usuario    from #TEMP2  

        END
	
END

GO
