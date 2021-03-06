USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOCARTERAINTER]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LISTADOCARTERAINTER]	(	
							@entidad 		NUMERIC (09)		,
							@fechaProc 		CHAR    (08)		,
							@fechaProx 		CHAR    (08)		,
							@titulo  		VARCHAR (80)		,
							@carterasuper		CHAR    (10)		,
							@cDolar  		CHAR    (01)		,
							@Cartera_Inv		CHAR	(10)		,
							@Cat_Libro		CHAR    (06)		,
							@Id_Libro		CHAR    (06) = ''	
						)
AS
BEGIN
	DECLARE	@acfecproc	CHAR (10)	,
		@acfecprox	CHAR (10)	,
		@uf_hoy		FLOAT 		,
		@uf_man		FLOAT		,
		@ivp_hoy	FLOAT		,
		@ivp_man	FLOAT		,
		@do_hoy		FLOAT		,
		@do_man		FLOAT		,
		@da_hoy		FLOAT		,
		@da_man		FLOAT		,
		@acnomprop	CHAR (40)	,
		@rut_empresa	CHAR (12)	,
		@nRutemp	NUMERIC (09,0)	,
		@hora		CHAR (08)	,
		@paso		CHAR (01)	,
		@Glosa_Cartera	Char(20)	,
		@Glosa_Libro	Char(50)

	SELECT @Glosa_Cartera = '' 

	IF @Cartera_INV = '' 
		SELECT @Glosa_Cartera = '< TODAS >'
                ,      @Cartera_Inv   = '0'

	ELSE 
		SELECT	@Glosa_Cartera	= ISNULL(TBGLOSA,'')
		FROM	VIEW_TABLA_GENERAL_DETALLE
		WHERE	TBCATEG		= '204'
		AND	TBCODIGO1	= @Cartera_INV


	IF  @id_libro = '' BEGIN
		SELECT @Glosa_libro = '< TODOS >'	
	END 
	ELSE BEGIN
		SELECT	@Glosa_libro	= tbglosa
		FROM	VIEW_TABLA_GENERAL_DETALLE
		WHERE	tbcateg		= @Cat_Libro 
		AND	tbcodigo1	= @Id_Libro
	END

	SELECT	@paso = 'N'

	EXECUTE	Sp_Base_Del_Informe
		@acfecproc	OUTPUT ,
		@acfecprox	OUTPUT ,
		@uf_hoy		OUTPUT ,
		@uf_man		OUTPUT ,
		@ivp_hoy	OUTPUT ,
		@ivp_man	OUTPUT ,
		@do_hoy		OUTPUT ,
		@do_man		OUTPUT ,
		@da_hoy		OUTPUT ,
		@da_man		OUTPUT ,
		@acnomprop	OUTPUT ,
		@rut_empresa	OUTPUT ,
		@hora		OUTPUT

	CREATE TABLE #TEMPORAL2(	numdoc			VARCHAR(15) 
				,	rscorrela		INT   
				,	rsinstser		CHAR(30)
				,	emisor			CHAR(30)
				,	fechacompra		CHAR(10)
				,	fechavcto		CHAR(10)
				,	fechacontab		CHAR(10)
				,	rsvalcomu		FLOAT
				,	um			CHAR(10)
				,	rsnominal		FLOAT
				,	cupon			FLOAT
				,	rscupint		FLOAT
				,	rstir			FLOAT
				,	rsvpcomp		FLOAT
				,	rsvppresen		FLOAT
				,	rsinteres		FLOAT
				,	rsreajuste		FLOAT
				,	rsintermes		FLOAT
				,	rsreajumes		FLOAT
				,	rsvppresenx		FLOAT
				,	rsinteres_acum		FLOAT
				,	rsreajuste_acum		FLOAT
				,	rscodigo		INT
				,	instrumento		CHAR(30)
				,	inserie			CHAR(30)
				,	titulo			CHAR(80)
				,	sw			INT 
				,	rsfecprox		CHAR(10)
				,	rsfecctb		CHAR(10)
				,	rsvpproceso		FLOAT 
				,	rsfeccupon		CHAR(19)
				,	fechaaux		DATETIME
				,	Tipo_Cart		Char(60)
				,	Tipo_InV		Char(60)
				,	clasificacion1		CHAR(40)
 				,	clasificacion2		CHAR(40)
				,	tipo_corto1		CHAR(30)
				,	tipo_largo1		CHAR(30)
				,	tipo_corto2		CHAR(30)
				,	tipo_largo2		CHAR(30)
				,	Libro			CHAR(50)
				,	Glosa_Libro		CHAR(50)
				)

	CREATE TABLE #TEMPORAL3(	numdoc			VARCHAR(15)
				,	rscorrela		INT	 
				,	rsinstser		CHAR(30)
				,	emisor			CHAR(30)
				,	fechacompra		CHAR(10)
				,	fechavcto		CHAR(10)
				,	fechacontab		CHAR(10)
				,	rsvalcomu		FLOAT
				,	um			CHAR(10)
				,	rsnominal		FLOAT
				,	cupon			FLOAT
				,	rscupint		FLOAT
				,	rstir			FLOAT
				,	rsvpcomp		FLOAT
				,	rsvppresen		FLOAT
				,	rsinteres		FLOAT
				,	rsreajuste		FLOAT
				,	rsintermes		FLOAT
				,	rsreajumes		FLOAT
				,	rsvppresenx		FLOAT
				,	rsinteres_acum		FLOAT
				,	rsreajuste_acum		FLOAT
				,	rscodigo		INT
				,	instrumento		CHAR(30)
				,	inserie			CHAR(30)
				,	titulo			CHAR(80)
				,	sw			INT
				,	rsfecprox		CHAR(10)
				,	rsfecctb		CHAR(10)
				,	rsvpproceso		FLOAT
				,	rsfeccupon		CHAR(10)
				,	fechaaux		DATETIME
				,	Tipo_Cart		Char(60)
				,	Tipo_InV		Char(60)
				,	clasificacion1		CHAR(40)
				,	clasificacion2		CHAR(40)
				,	tipo_corto1		CHAR(30)
				,	tipo_largo1		CHAR(30)
				,	tipo_corto2		CHAR(30)
				,	tipo_largo2		CHAR(30)
				,	Libro			CHAR(50)
				,	Glosa_Libro		CHAR(50)
				)

	SELECT	@nRutemp = acrutprop 
	FROM	MDAC

	SET NOCOUNT ON

	SELECT	'numdoc'	= STR(rsnumdocu,7) + '-' + STR(rscorrela,2)    -- 1
	,	'rscorrela'	= ISNULL(rscorrela,0)          -- 2
	,	'rsinstser'	= ISNULL(rsinstser,' ')        -- 3
	,	'emisor'	= ISNULL(emgeneric,' ')        -- 4
	,	'fechacompra'	= ISNULL(CONVERT(CHAR(10),rsfeccomp,103),' ')  -- 5
	,	'fechavcto'	= ISNULL(CONVERT(CHAR(10),rsfecvcto,103),' ' ) -- 6
	,	'fechacontab'	= ISNULL(CONVERT(CHAR(10),rsfecctb,103),' ')   -- 7
	,	'rsvalcomu'	= ISNULL(CONVERT(NUMERIC(19,4),rsvalcomu),0)   -- 8
	,	'um'		= (SELECT ISNULL(mnnemo,' ') FROM VIEW_MONEDA WHERE mncodmon=rsmonemi) -- 9
	,	'rsnominal'	= ISNULL(rsnominal,0.0)        -- 10
	,	'cupon'		= ISNULL(rsvalvenc,0.0)        -- 11
	,	'rscupint'	= ISNULL(rscupint,0.0)         -- 12
	,	'rstir'		= ISNULL(rstir,0.0)            -- 13
	,	'rsvpcomp'	= ISNULL(rsvpcomp,0.0)         -- 14
	,	'rsvppresen'	= ISNULL(rsvalcomp,0.0)        -- 15
	,	'rsinteres'	= ISNULL(rsinteres,0.0)        -- 16
	,	'rsreajuste'	= ISNULL(rsreajuste,0.0)       -- 17
	,	'rsintermes'	= ISNULL(rsintermes,0.0)       -- 18
	,	'rsreajumes'	= ISNULL(rsreajumes,0.0)       -- 19
	,	'rsvppresenx'	= ISNULL(rsvppresenx,0.0)      -- 20
	,	'rsinteres_acum'= ISNULL(rsinteres_acum-rsinteres,0.0)         -- 21
	,	'rsreajuste_acum'= ISNULL(rsreajuste_acum-rsreajuste,0.0)      -- 22
	,	'rscodigo'	= ISNULL(rscodigo,0)           -- 23
	,	'instrumento'	= (SELECT ISNULL(inglosa,'*') FROM VIEW_INSTRUMENTO WHERE incodigo=rscodigo) -- 24
	,	'inserie'	= ISNULL(CASE WHEN rsrutcli = '97029000' THEN 'REPOS'
                                              ELSE (SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo=rscodigo)
                                              END,' ')         -- 25
	,	'titulo'	= @titulo                      -- 26
	,	'sw'		= '0'                          -- 27
	,	'rsfecprox'	= ISNULL(CONVERT(CHAR(10),rsfecprox,103),' ')  -- 28
	,	'rsfecctb'	= ISNULL(CONVERT(CHAR(10),rsfecctb,103),' ')   -- 29
	,	'rsvpproceso'	= ISNULL(rsvppresen,0.0)                       -- 30 
	,	'rsfeccupon'	= ISNULL(CONVERT(CHAR(10),rsfecpcup,103),' ')  -- 31
	,	'fechaaux'	= rsfecvcto                                    -- 32
	,	'Tipo_Cart'	= isnull(cfrf.glosa,'sin definicion') --(SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BTR' And rcrut =  rstipcart) -- 33
	,	'Tipo_InV'	= @Glosa_Cartera               -- 34	
	,	'clasificacion1'= CASE WHEN LTRIM(CONVERT( CHAR(40),clasificacion1)) = '' THEN '---' ELSE LTRIM(CONVERT( CHAR(40),clasificacion1)) END	---35
	,	'clasificacion2'= CASE WHEN LTRIM(CONVERT( CHAR(40),clasificacion2)) = '' THEN '---' ELSE LTRIM(CONVERT( CHAR(40),clasificacion2)) END	 --36
	,	'tipo_corto1'	= CASE WHEN LTRIM(CONVERT( CHAR(40),tipo_corto1)) = '' THEN '---' ELSE LTRIM(CONVERT( CHAR(40),tipo_corto1)) END 	 --37
	,	'tipo_largo1'	= CASE WHEN LTRIM(CONVERT( CHAR(40),tipo_largo1)) = '' THEN '---' ELSE LTRIM(CONVERT( CHAR(40),tipo_largo1)) END  	 --38
	,	'tipo_corto2'	= CASE WHEN LTRIM(CONVERT( CHAR(40),tipo_corto1)) = '' THEN '---' ELSE LTRIM(CONVERT( CHAR(40),tipo_corto1)) END 	 --39
	,	'tipo_largo2'	= CASE WHEN LTRIM(CONVERT( CHAR(40),tipo_largo2)) = '' THEN '---' ELSE LTRIM(CONVERT( CHAR(40),tipo_largo2)) END    	 --40
	,	'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND tbcodigo1 = rsid_libro),'')	 --41
	,	'Glosa_libro'	= @Glosa_Libro	-- 42
	INTO	#TEMPORAL
 	FROM	MDRS
 			left join
			(	select	Id = cf.tbcodigo1, Glosa = cf.tbglosa
				from	BacParamSuda..TIPO_CARTERA tc
						INNER JOIN
						(	SELECT	tbcodigo1, tbglosa
							FROM	bacparamsuda.dbo.tabla_general_detalle WITH(NOLOCK) 
							WHERE	tbcateg = 204
						)	cf		ON cf.tbcodigo1	= tc.rcrut
				WHERE	tc.rcsistema = 'BTR'
				AND		tc.rccodpro='CP'
			)	cfrf	ON cfrf.Id	= MDRS.rstipcart
	,	VIEW_EMISOR
	WHERE	rsfecha = @fechaProx 
	AND	emrut   = rsrutemis 
	AND	CHARINDEX(STR(rsmonemi,3),CASE WHEN @cDolar='N' THEN '997-998-999' ELSE '988-994-995- 13-800-801' END)>0 
	AND	rsnominal  > 0 
	AND	rscartera  = '114' 
	AND	rstipoper  = 'DEV' 
	AND	rstipopero = 'VI'
	AND	(rstipcart  = @Cartera_INV OR @Cartera_INV = 0 )
	AND	codigo_carterasuper	= @carterasuper	
	AND	(rsid_libro = @id_libro    OR @id_libro    = '')

	IF (SELECT COUNT(1) FROM #TEMPORAL) > 0 BEGIN
		INSERT INTO #TEMPORAL2
		SELECT	numdoc
		,	rscorrela
		,	rsinstser    
		,	emisor     
		,	fechacompra    
		,	fechavcto    
		,	fechacontab    
		,	'rsvalcomu'	 = rsvalcomu  
		,	um     
		,	'rsnominal'	 = rsnominal  
		,	'cupon'		 = cupon  
		,	'rscupint'	 = rscupint  
		,	'rstir'		 = rstir   
		,	'rsvpcomp'	 = rsvpcomp  
		,	'rsvppresen'	 = rsvppresen  
		,	'rsinteres'	 = rsinteres  
		,	'rsreajuste'	 = rsreajuste  
		,	'rsintermes'	 = rsintermes  
		,	'rsreajumes'	 = rsreajumes  
		,	'rsvppresenx'	 = rsvppresenx  
		,	'rsinteres_acum' = rsinteres_acum 
		,	'rsreajuste_acum'= rsreajuste_acum 
		,	rscodigo    
		,	instrumento    
		,	inserie     
		,	'titulo'	 = @Titulo  
		,	'sw'		 = '0'   
		,	rsfecprox    
		,	rsfecctb    
		,	'rsvpproceso'	 = rsvpproceso  
		,	rsfeccupon    
		,	fechaaux	
		,	Tipo_Cart	
		,	Tipo_InV	
 		,	clasificacion1
 		,	clasificacion2
 		,	tipo_corto1
 		,	tipo_largo1
 		,	tipo_corto2
 		,	tipo_largo2
		,	Libro
		,	Glosa_Libro
		FROM	#TEMPORAL

		SELECT	inserie
		,	fechacontab
		,	rsfecprox
		,	rsfecctb
		,	'rsnominal'		= SUM(rsnominal) 
		,	'rsvalcomu'		= SUM(rsvalcomu) 
		,	'rsvppresen'		= SUM(rsvppresen) 
		,	'rsvpproceso'		= SUM(rsvpproceso) 
		,	'rsinteres'		= SUM(rsinteres) 
		,	'rsreajuste'		= SUM(rsreajuste) 
		,	'rsintermes'		= SUM(rsintermes) 
		,	'rsreajumes'		= SUM(rsreajumes) 
		,	'rsvppresenx'		= SUM(rsvppresenx) 
		,	'rsinteres_acum'	= SUM(rsinteres_acum) 
		,	'rsreajuste_acum'	= SUM(rsreajuste_acum)  
		,	'rstir'			= SUM(rstir*rsvppresen) / SUM(rsvppresen)
		INTO	#TOTAL
		FROM	#TEMPORAL2
		GROUP 
		BY	inserie
		,	fechacontab
		,	rsfecprox
		,	rsfecctb

		INSERT INTO #TEMPORAL2
		SELECT	'Total'		-- 1
		,	0		-- 2
		,	inserie		-- 3
		,	'01011900'	-- 4
		,	'01011900'	-- 5
		,	'01011900'	-- 6
		,	fechacontab	-- 7
		,	rsvalcomu	-- 9
		,	''		-- 10
		,	rsnominal	-- 11
		,	0		-- 12
		,	0		-- 13
		,	rstir		-- 14
		,	0		-- 15
		,	rsvppresen	-- 16
		,	rsinteres	-- 17
		,	rsreajuste	-- 18
		,	rsintermes	-- 19
		,	rsreajumes	-- 20
		,	rsvppresenx	-- 21
		,	rsinteres_acum	-- 22
		,	rsreajuste_acum	-- 23
		,	0		-- 24
		,	'TOTAL'		-- 25
		,	inserie		-- 26
		,	''		-- 27
		,	'sw'	= '1'	-- 28
		,	rsfecprox	-- 30
		,	rsfecctb	-- 31
		,	rsvpproceso	-- 32
		,	''		-- 33
		,	''		-- 34
		,	''		-- 35
		,	@Glosa_Cartera  -- 36
		,	''
		,	''
		,	''
		,	''
		,	''
		,	''
		,	''		-- 37
		,	@Glosa_Libro	-- 38
		FROM	#TOTAL

	END
	ELSE  BEGIN
		INSERT INTO #TEMPORAL2
		SELECT ''  , -- 1
		0  , -- 2
		''  , -- 3
		''  , -- 4
		'01011900'  , -- 5
		'01011900'  , -- 6
		'01011900'  , -- 7
		0  , -- 9
		''  , -- 10
		0  , -- 11
		0  , -- 12
		0  , -- 13
		0  , -- 14
		0  , -- 15
		0  , -- 16
		0  , -- 17
		0  , -- 18
		0  , -- 19
		0  , -- 20
		0  , -- 21
		0  , -- 22
		0   , -- 23
		0  , -- 24
		''  , -- 25
		''  , -- 26
		@titulo  ,
		'0'  , -- 28
		CONVERT(CHAR(10),CONVERT(DATETIME,@fechaProx),103),
		CONVERT(CHAR(10),CONVERT(DATETIME,@fechaProc),103),
		0.0  ,
		''  	,
		''	,
		''	,
		@Glosa_Cartera
		,	''
		,	''
		,	''
		,	''
		,	''
		,	''
		,	''  
		,	@Glosa_Libro 

	END

	SELECT  numdoc	, -- 1
	rscorrela	, -- 2
	rsinstser	, -- 3
	emisor		, -- 4
	'fechacompra' = ISNULL(fechacompra,'01011900')	, -- 5
	'fechavcto' = ISNULL(fechavcto,'01011900')	, -- 6
	'fechacontab' = ISNULL(fechacontab,'01011900')	, -- 7
	rsvalcomu	, -- 9
	um		, -- 10
	rsnominal	, -- 11
	cupon AS 'cupon', -- 12
	rscupint	, -- 13
	rstir		, -- 14
	rsvpcomp	, -- 15
	rsvppresen	, -- 16
	rsinteres	, -- 17
	rsreajuste	, -- 18
	rsintermes	, -- 19
	rsreajumes	, -- 20
	rsvppresenx	, -- 21
	rsinteres_acum	, -- 22
	rsreajuste_acum	, -- 23
	rscodigo	, -- 24
	instrumento	, -- 25
	inserie		, -- 26
	CASE	WHEN sw = '1' THEN 'RESUMEN '+ RTRIM(@titulo) + SPACE(3) + 'DEL'+ SPACE(3) + rsfecctb + SPACE(3)+ 'AL'+SPACE(3)+ rsfecprox
		ELSE RTRIM(titulo) + SPACE(3) + 'DEL' + SPACE(3) + rsfecctb + SPACE(3)+ 'AL'+SPACE(3)+ rsfecprox END  AS 'titulo'  , -- 27
	sw		, -- 28
	'fecproc'	= @acfecproc	, -- 29
	'fecprox'	= @acfecprox	, -- 30
	'uf_hoy'	= @uf_hoy	, -- 31
	'uf_man'	= @uf_man	, -- 32
	'ivp_hoy'	= @ivp_hoy	, -- 33
	'ivp_man'	= @ivp_man	, -- 34
	'do_hoy'	= @do_hoy	, -- 35
	'do_man'	= @do_man	, -- 36
	'da_hoy'	= @da_hoy	, -- 37
	'da_man'	= @da_man	, -- 38
	'acnomprop'     = (SELECT ISNULL(@acnomprop, 'NO DEFINIDO') FROM MDAC )	, -- 39
	'rut_empresa'   = @rut_empresa	, -- 40
	'nombreentidad' = (SELECT ISNULL(acnomprop, 'NO DEFINIDO') from MDAC )	, -- 41
	'hora'		= @hora	, -- 42
	'fecha1' = SUBSTRING(@fechaProc ,7,2) + '/' +SUBSTRING(@fechaProc ,5,2) + '/' +SUBSTRING(@fechaProc ,1,4)	, -- 44
	'fecha2' = SUBSTRING(@fechaProx ,7,2) + '/' +SUBSTRING(@fechaProx ,5,2) + '/' +SUBSTRING(@fechaProx ,1,4)	,-- 45
	rsfecprox	,
	rsfecctb	,
	rsvpproceso	,
	rsfeccupon	,
	fechaaux	,
	Tipo_Cart	,
	Tipo_InV	,
	clasificacion1	, 
 	clasificacion2	, 
	tipo_corto1	, 
	tipo_largo1	, 
	tipo_corto2	, 
	tipo_largo2	,
	Libro		,
	Glosa_Libro
	FROM #TEMPORAL2
	ORDER
	BY	numdoc
	,	sw
	,	rsinstser
	,	inserie
 
END




-- Base de Datos --
GO
