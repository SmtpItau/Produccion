USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOCPDIS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LISTADOCPDIS]	(	@entidad	NUMERIC(10)	= 0
					,	@tipocartera	CHAR(1)		= '' 
					,	@cFechaProc	CHAR(08)	= ''
					,	@cFechaProx	CHAR(08)	= ''
					,	@CDolar		CHAR(1)		= 'N'
					,	@titulo		VARCHAR(80)	= ''  
					,	@Cat_Libro	CHAR(06)	= ''
					,	@Id_Libro	CHAR(06)	= ''
					)
AS
BEGIN

 SET NOCOUNT ON

	DECLARE	@acfecproc CHAR (10) 
	,	@acfecprox CHAR (10) 
	,	@uf_hoy  FLOAT  
	,	@uf_man  FLOAT  
	,	@ivp_hoy FLOAT  
	,	@ivp_man FLOAT  
	,	@do_hoy  FLOAT  
	,	@do_man  FLOAT  
	,	@da_hoy  FLOAT  
	,	@da_man  FLOAT  
	,	@acnomprop CHAR (40) 
	,	@rut_empresa CHAR (12)
	,	@nRutemp NUMERIC (09,0)
	,	@hora  CHAR (08) 
	,	@paso  CHAR (01) 
	,	@Glosa_Libro	CHAR(50)

	SELECT	@paso = 'N'

	EXECUTE	Sp_Base_Del_Informe	@acfecproc OUTPUT 
				,	@acfecprox OUTPUT
				,	@uf_hoy  OUTPUT 
				,	@uf_man  OUTPUT 
				,	@ivp_hoy OUTPUT 
				,	@ivp_man OUTPUT 
				,	@do_hoy  OUTPUT 
				,	@do_man  OUTPUT 
				,	@da_hoy  OUTPUT 
				,	@da_man  OUTPUT 
				,	@acnomprop OUTPUT 
				,	@rut_empresa OUTPUT 
				,	@hora  OUTPUT

	IF  @id_libro = '' BEGIN
		SELECT @Glosa_libro = '< TODOS >'	
	END 
	ELSE BEGIN
		SELECT	@Glosa_libro	= tbglosa
		FROM	VIEW_TABLA_GENERAL_DETALLE
		WHERE	tbcateg		= @Cat_Libro 
		AND	tbcodigo1	= @Id_Libro
	END

	SELECT	@nRutemp = acrutprop 
	FROM	MDAC

	SELECT	'numero' = (CONVERT(VARCHAR(9),ISNULL(rsnumoper,0))+'-'+CONVERT(VARCHAR(10),ISNULL(rscorrela,0))), -- 1
		'correla' = ISNULL(rscorrela,0),
		'serie'  = ISNULL(rsinstser,' '),
		'emisor' = ISNULL((select emgeneric from view_emisor where emrut = rsrutemis),' '),
		'fecemi' = CONVERT(CHAR(10),rsfecemis,103) ,
		'fecvenc' = CONVERT(CHAR(10),rsfecvcto,103),
		'tasaemi' = ISNULL(rstasemi,0),
		'baseemi' = ISNULL(rsbasemi,0),
		'moneda' = (SELECT ISNULL(mnnemo,' ') FROM VIEW_MONEDA WHERE mncodmon=rsmonemi),
		'nominal' = ISNULL(rsnominal,0),
		'tir'  = ISNULL(convert(float,rstir),0),
		'compra' = ISNULL(rsvpcomp,0),
		'valor_pres' = rsinteres + rsreajuste +rsvppresen ,
		'inserie' = CASE	WHEN rstipoletra='E' THEN 'LCHR ESTA'
					WHEN rstipoletra='V' THEN 'LCHR VIV'
					WHEN rstipoletra='F' THEN 'LCHR F.GEN'
					WHEN rstipoletra='O' THEN 'LCHR OTROS'
					ELSE (SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo=rscodigo) END           ,
		'valorcomp' = ISNULL(rsvalcomp,0),
		'sw'        = 0,
		'titulo'    = @titulo,
		'rsfecprox' = ISNULL(CONVERT(CHAR(10),rsfecprox,103),' '), 
		'rsfecctb'  = ISNULL(CONVERT(CHAR(10),rsfecctb,103),' ')
	,	'libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND tbcodigo1 = rsid_libro),'') 
	,	'Glosa_libro'	= @Glosa_Libro
	INTO	#TEMPORAL
	FROM	MDRS
	WHERE	rsnominal  > 0 
	AND	rscartera  = '111' 
	AND	rstipoper  = 'DEV' 
	AND	rstipopero = 'CP' 
	AND	codigo_carterasuper = @tipocartera  
	AND	rsfecha    = @cFechaProx 
	AND	CHARINDEX(STR(rsmonemi,3),CASE	WHEN @cDolar = 'N' THEN '997-998-999' 
						ELSE '988-994-995- 13' END) > 0
	AND (rsid_libro	= @id_libro OR @id_libro = '')

	 IF (SELECT COUNT(1) FROM #TEMPORAL) > 0 BEGIN
  
		SELECT	inserie
		,	rsfecprox
		,	rsfecctb
		, 	'nominal' = SUM(nominal)
		,	'valorcomp' = SUM(valorcomp)
		,	'valor_pres' = SUM(valor_pres)
		,	'tir'  = SUM(valorcomp * tir) / SUM(valorcomp)
		INTO	#TOTAL
		FROM	#TEMPORAL
		GROUP
		BY	inserie
		,	rsfecprox
		,	rsfecctb
		
		INSERT INTO #TEMPORAL
		SELECT ''  , -- 1
		0  , -- 2
		inserie  , -- 3
		''  , -- 4
		''  , -- 5
		''  , -- 6
		0  , -- 7
		0  , -- 8
		''   , -- 9
		nominal  , -- 10
		tir  , -- 11
		0  , -- 12
		valor_pres ,
		'RESUMEN' ,--inserie  , -- 26
		valorcomp , -- 27
		'sw' = 1 ,  -- 28
		''  ,
		rsfecprox , -- 29
		rsfecctb   -- 30
		,	''
		,	@Glosa_Libro
		FROM	 #TOTAL
	END 
	ELSE BEGIN
	
		INSERT INTO #TEMPORAL
		SELECT ''  , -- 1
		0  , -- 2
		0  , -- 3
		''  , -- 4
		''  , -- 5
		''  , -- 6
		0  , -- 7
		0  , -- 8
		''   , -- 9
		0  , -- 10
		0  , -- 11
		0  , -- 12
		0 ,
		''  , -- 26
		0 , -- 27
		'sw' = 0 ,  -- 28
		@titulo  ,
		CONVERT(CHAR(10),CONVERT(DATETIME,@cFechaProx),103),
		CONVERT(CHAR(10),CONVERT(DATETIME,@cFechaProc),103)
		,  ''
		,  @Glosa_Libro
	
	END

	SELECT	numero, -- 1
		correla,
		serie,
		emisor,
		fecemi,
		fecvenc,
		tasaemi,
		baseemi,
		moneda,
		nominal,
		tir,
		compra,
		valor_pres,
		inserie,
		valorcomp,
		'acfecproc' = @acfecproc,
		'acfecprox' = @acfecprox   ,
		'uf_hoy' = @uf_hoy      ,
		'uf_man' = @uf_man      ,
		'ivp_hoy' = @ivp_hoy     ,
		'ivp_man' = @ivp_man     ,
		'do_hoy' = @do_hoy      ,
		'do_man' = @do_man      ,
		'da_hoy' = @da_hoy    ,
		'da_man' = @da_man      ,
		'acnomprop' = @acnomprop   ,
		'rut_empresa' = @rut_empresa,
		'hora'  = @hora,
		sw,
		CASE	WHEN sw=1 THEN 'RESUMEN '+ @titulo +SPACE(3)+'DEL'+SPACE(3)+ rsfecctb + SPACE(3)+ 'AL'+SPACE(3)+ rsfecprox
			ELSE titulo + SPACE(3)+'DEL'+SPACE(3)+ rsfecctb + SPACE(3)+ 'AL'+SPACE(3)+ rsfecprox END AS 'titulo'    , -- 27
		'fecha1'        =SUBSTRING(@cFechaProx ,7,2) + '/' +SUBSTRING(@cFechaProx ,5,2) + '/' +SUBSTRING(@cFechaProx ,1,4),
		'rsfecprox' = ISNULL(CONVERT(CHAR(10),rsfecprox,103),' ')      , --29
		'rsfecctb' = ISNULL(CONVERT(CHAR(10),rsfecctb,103),' ')
		, Libro
		, Glosa_Libro
	FROM #TEMPORAL
	ORDER 
	BY	sw, 
		serie
	
 SET NOCOUNT OFF
END



GO
