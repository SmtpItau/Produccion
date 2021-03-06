USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORVALMERCADO_DIARIA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- Sp_Inforvalmercado_Diaria 'BTR' , '20060202' , 't' , 'TITULO' , 'N'
CREATE PROCEDURE [dbo].[SP_INFORVALMERCADO_DIARIA]	(	@cSistema	CHAR	(3)	
						,	@cFecha		CHAR	(8)	
						,	@cCartera	CHAR	(10)	
						,	@vTitulo	VARCHAR	(200)	= ''	
						,	@cDolar		CHAR	(01)	= 'N'
						) 
AS
BEGIN
	SET NOCOUNT ON 
			
	DECLARE @acfecproc	CHAR(10)	,
		@acfecprox	CHAR(10)	,
		@uf_hoy		FLOAT		,
		@uf_man		FLOAT		,
		@ivp_hoy	FLOAT		,
		@ivp_man	FLOAT		,
		@do_hoy		FLOAT		,
		@do_man		FLOAT		,
		@da_hoy		FLOAT		,
		@da_man		FLOAT		,
		@acnomprop	CHAR(40)	,
		@rut_empresa	CHAR(12)	,
		@hora		CHAR(8)

	EXECUTE Sp_Base_Del_Informe
		@acfecproc	OUTPUT		,
		@acfecprox	OUTPUT		,
		@uf_hoy		OUTPUT		,
		@uf_man		OUTPUT		,
		@ivp_hoy	OUTPUT		,
		@ivp_man	OUTPUT		,
		@do_hoy		OUTPUT		,
		@do_man		OUTPUT		,
		@da_hoy		OUTPUT		,
		@da_man		OUTPUT		,
		@acnomprop	OUTPUT		,
		@rut_empresa	OUTPUT		,
		@hora		OUTPUT

        SELECT DISTINCT 'rmnumdocu'	= ISNULL(RTRIM(CONVERT(CHAR(7),VALORIZACION_MERCADO_DIARIA.rmnumdocu))+'-'+ CONVERT(CHAR(3),VALORIZACION_MERCADO_DIARIA.rmcorrela),'*-*')	,--1
			'rmnumoper'	= ISNULL(VALORIZACION_MERCADO_DIARIA.rmnumoper,0)												,--2
			'tminster'	= CONVERT(VARCHAR(13),ISNULL(TASA_MERCADO_DIARIA.tminstser,''))											,--3	
			'tmfecpro'	= ISNULL(CONVERT(CHAR(10),TASA_MERCADO_DIARIA.tmfecvcto,103),'')										,--4
			'tmnominal'	= CONVERT(NUMERIC(20), ISNULL(VALORIZACION_MERCADO_DIARIA.valor_nominal,0))									,--5
			'moneda'	= ISNULL(VIEW_MONEDA.mnnemo,'')															,--6
			'rmttir'	= ISNULL(VALORIZACION_MERCADO_DIARIA.tasa_compra,0)												,--7
			'rmvpres'	= CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO_DIARIA.valor_presente,0))									,--8
			'rmvmerc'	= CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO_DIARIA.valor_mercado,0))									,--9
			'tmtmerc'	= CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO_DIARIA.tasa_mercado,0))									,--10
			'rmdmerc'	= CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO_DIARIA.diferencia_mercado,0))								,--11
			'tmmarket'	= CONVERT(NUMERIC(19,4),ISNULL(TASA_MERCADO_DIARIA.tasa_market,0))										,--12
			'rmvmarket'	= CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO_DIARIA.valor_market,0))									,--13
			'rmdmarket'	= ISNULL(VALORIZACION_MERCADO_DIARIA.diferencia_market,0)											,--14
			'tmmarket1'	= ISNULL(TASA_MERCADO_DIARIA.tasa_market1,0)													,--15
			'rmvmarket1'	= ISNULL(VALORIZACION_MERCADO_DIARIA.valor_market1,0)												,--16
			'rmdmarket1'	= ISNULL(VALORIZACION_MERCADO_DIARIA.diferencia_market1,0)											,--17
			'tmmarket2'	= ISNULL(TASA_MERCADO_DIARIA.tasa_market2,0)													,--18
			'rmvmarket2'	= ISNULL(VALORIZACION_MERCADO_DIARIA.valor_market2,0)									        		,--19
			'rmdmarket2'	= ISNULL(VALORIZACION_MERCADO_DIARIA.diferencia_market2,0)											,--20
			'inserie'       = CONVERT(CHAR(25)																,--21 
                                          CASE WHEN INCODIGO = 15 AND emtipo IN('1','3','4')  THEN 'BONOS OTRAS INST.'
					       WHEN INCODIGO = 15 AND emtipo ='2'  THEN 'BONOS INST. FINANCIERAS'	
					       WHEN INCODIGO = 20 AND TASA_MERCADO_DIARIA.tmrutemis = 97030000 AND  VALORIZACION_MERCADO_DIARIA.moneda_emision = 997 THEN 'LCHR ESTA IVP'
                                               WHEN INCODIGO = 20 AND TASA_MERCADO_DIARIA.tmrutemis = 97030000 AND  VALORIZACION_MERCADO_DIARIA.moneda_emision = 998 THEN 'LCHR ESTA UF' 
                                               WHEN TASA_MERCADO_DIARIA.tmrutemis = 97023000  AND  INCODIGO = 20 THEN 'LCHR PROPIAS'
                                               WHEN INCODIGO = 20                                         THEN 'LCHR OTROS' 
						ELSE inserie END)																						,--21
			'sw'		= '0'																		,--22
			'titulo'	= @vTitulo																	,--23
			'subtitulo'	= CASE	WHEN VALORIZACION_MERCADO_DIARIA.tipo_operacion = 'CP' THEN 'DISPONIBLE  '
						ELSE 'INTERMEDIADO'  END														,--24
			'Tipoper'	= ISNULL(VALORIZACION_MERCADO_DIARIA.tipo_operacion,'')												,--25
			'TASA_EMISION'  = CASE	WHEN cpseriado='N' THEN (SELECT top 1 nstasemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
                                             	ELSE (SELECT DISTINCT setasemi FROM VIEW_SERIE WHERE semascara=cpmascara) END								,--26
			'rsvppresen'    = ISNULL(cpvalcomp,0.0)																,--27
			'fechaaux'      = datediff(DAY,convert(datetime,@cFecha,113),cpfecven)												,--28
              		'duration'      = cpdurat																	,--29
			'Clasificacion1'=CASE WHEN LTRIM(CONVERT( CHAR(40),clasificacion1)) = '' THEN '---' END										,--30
			'Clasificacion2'=CASE WHEN LTRIM(CONVERT( CHAR(40),clasificacion2)) = '' THEN '---' END										,--31
			'Tipo_corto1'= 	CASE WHEN LTRIM(CONVERT( CHAR(40),tipo_corto1)) = '' THEN '---' END										,--32
			'Tipo_largo1'=	CASE WHEN LTRIM(CONVERT( CHAR(40),tipo_largo1)) = '' THEN '---' END										,--33	
			'Tipo_corto2'= 	CASE WHEN LTRIM(CONVERT( CHAR(40),tipo_corto1)) = '' THEN '---' END										,--34
			'Tipo_largo2'= 	CASE WHEN LTRIM(CONVERT( CHAR(40),tipo_largo2)) = '' THEN '---' END  										--35	
	,		'ValPresTC_LT'	= Clt_VPTC_ValAct																--36
	,		'ValPresTM_LT'	= Clt_VPTM_ValAct																--37
	,		'TirCompra_LT'	= Clt_TC_PP_Ini																	--38
	,		'TirMercado_LT'	= Clt_TM_PP_Val																	--39
	,		'ResDif_LT'	= Clt_Res_VM_VP																	--40
	INTO	#TEMPORAL
	FROM 	TASA_MERCADO_DIARIA
     --  REQ. 7619
	,	VALORIZACION_MERCADO_DIARIA LEFT OUTER JOIN TBL_CARTERA_LIBRE_TRADING  ON
                                                    rmnumoper = clt_numoper
												AND	rmnumdocu = clt_numdocu
												AND	rmcorrela = clt_numcorr
    AND	(clt_sistema					= 'BTR'
	AND	clt_fechaproc					= @cFecha)
	,	VIEW_MONEDA
	,	VIEW_EMISOR
	,	VIEW_INSTRUMENTO
	,	MDCP 
--  REQ. 7619 
--	,	TBL_CARTERA_LIBRE_TRADING 
	WHERE	TASA_MERCADO_DIARIA.id_sistema			= @cSistema
	AND	TASA_MERCADO_DIARIA.fecha_proceso		= @cFecha
	AND	fecha_valorizacion				= @cFecha
	AND	VALORIZACION_MERCADO_DIARIA.codigo_carterasuper	= @cCartera
	AND	TASA_MERCADO_DIARIA.tmrutcart			= VALORIZACION_MERCADO_DIARIA.rmrutcart
	AND	VIEW_MONEDA.mncodmon				= TASA_MERCADO_DIARIA.tmmonemis
	AND	VIEW_INSTRUMENTO.incodigo			= TASA_MERCADO_DIARIA.tmcodigo
	AND	TASA_MERCADO_DIARIA.tmcodigo			= VALORIZACION_MERCADO_DIARIA.rmcodigo  
	AND	TASA_MERCADO_DIARIA.tminstser			= VALORIZACION_MERCADO_DIARIA.rminstser
	AND	CHARINDEX(STR( tmmonemis,3), CASE WHEN @cDolar = 'N' THEN '997-998-999' ELSE '988-994-995- 13' END) > 0
	AND	emrut						= rut_emisor
	AND	emgeneric					= tmgenemis
	AND     VALORIZACION_MERCADO_DIARIA.rmnumdocu		= cpnumdocu 
	AND	VALORIZACION_MERCADO_DIARIA.rmcorrela		= cpcorrela
--  REQ. 7619
/*
	AND	(clt_sistema					= 'BTR'
	AND	clt_fechaproc					= @cFecha)
	AND	rmnumoper					*= clt_numoper
	AND	rmnumdocu					*= clt_numdocu
	AND	rmcorrela					*= clt_numcorr)
*/
	ORDER
	BY	tminster

--	IF (SELECT COUNT(1) FROM #TEMPORAL) > 0 BEGIN			
	IF @@ROWCOUNT > 0 BEGIN

		CREATE NONCLUSTERED INDEX TEMP_001 ON #TEMPORAL (inserie
		,	moneda
		,	tipoper)

		SELECT	inserie                  	        ,
			moneda					,
			tipoper					,
			subtitulo				,
			'tmnominal'	= SUM(tmnominal)	,
			'rmvpres'	= SUM(rmvpres)		,
			'rmvmerc'	= SUM(rmvmerc)		,
			'rmdmerc'	= SUM(rmdmerc)		,
			'rmvmarket'	= SUM(rmvmarket)	,
			'rmdmarket'	= SUM(rmdmarket)	,
			'rmvmarket1'	= SUM(rmvmarket1)	,
			'rmdmarket1'	= SUM(rmdmarket1)	,
			'rmvmarket2'	= SUM(rmvmarket2)	,
			'rmdmarket2'	= SUM(rmdmarket2)
		INTO	#TOTAL
		FROM	#TEMPORAL
		GROUP
		BY	inserie
		,	moneda
		,	tipoper
		,	subtitulo
                                                                                                                                                                 --  1
               INSERT INTO #TEMPORAL
               SELECT    ''   ,
                         0    ,
                         ''   ,
                         '',
                         tmnominal,
                         MONEDA   ,
                          0,
                         rmvpres, 
                         rmvmerc,
                         0,
                         rmdmerc,
                         0,
			 rmvmarket,
                         rmdmarket,
                         0,    
                         rmvmarket1,
                         rmDmarket1,
                         0,
                         rmvmarket2,
                         rmDmarket2,
                         INSERIE,
                         1,
                         'RESUMEN  '+ @vTitulo ,
                         subtitulo,
                         '',
                         0,
                         0,
                         '',
                         0,
			 '',
			 '',
			 '',
			 '',
			 '',
			 ''   
		,	0.0		--36
		,	0.0		--37
		,	0.0		--38
		,	0.0		--39
		,	0.0		--40
               FROM #TOTAL 

	END	
	ELSE BEGIN

		INSERT INTO #TEMPORAL
		SELECT 	'',
			0,
			'',
			'',
			0,
			'',
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			'',
			'0',
			@vTitulo,
			'',
			'',
			0,
			0,
			'',
			0,
			'',
			'',
			'',
			'',
			'',
			''
		,	0.0		--36
		,	0.0		--37
		,	0.0		--38
		,	0.0		--39
		,	0.0		--40

	END
			
		SELECT	DISTINCT rmnumdocu,
			rmnumoper,
			tminster,
			tmfecpro,
			tmnominal,
			moneda,
			rmttir,
			rmvpres,
			rmvmerc,
			tmtmerc,
			rmdmerc,
			tmmarket,
			rmvmarket,
			rmdmarket,
			tmmarket1,
			rmvmarket1,
			rmdmarket1,
			tmmarket2,
			rmvmarket2,
			rmdmarket2,
			'inserie' = ISNULL(inserie,''),
			'acfecproc'	= @acfecproc	,
			'acfecprox'	= @acfecprox	,
			'uf_hoy'	= @uf_hoy	,	
			'uf_man'	= @uf_man	,
			'ivp_hoy'	= @ivp_hoy	,
			'ivp_man'	= @ivp_man	,
			'do_hoy'	= @do_hoy	,
			'do_man'	= @do_man	,
			'da_hoy'	= @da_hoy	,
			'da_man'	= @da_man	,
			'acnomprop'	= @acnomprop	,
			'rut_empresa'	= @rut_empresa	,
			'hora'		= @hora		,
			sw				,
			titulo				,
			subtitulo			,
			'Fecha1'	= SUBSTRING(@cfecha,7,2)+'/' + SUBSTRING(@cfecha,5,2)+ '/' +SUBSTRING(@cfecha,1,4),
			ISNULL(TASA_EMISION,0),
			rsvppresen,
			fechaaux,
                        duration,
			Clasificacion1,
			Clasificacion2,
			Tipo_corto1,
			Tipo_largo1,
			Tipo_corto2,
			Tipo_largo2
		,	ValPresTC_LT		--36
		,	ValPresTM_LT		--37
		,	TirCompra_LT		--38
		,	TirMercado_LT		--39
		,	ResDif_LT		--40
		FROM	#TEMPORAL
		ORDER 
		BY	tminster

END




GO
