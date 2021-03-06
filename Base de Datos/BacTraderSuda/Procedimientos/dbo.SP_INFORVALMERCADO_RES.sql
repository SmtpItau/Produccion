USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORVALMERCADO_RES]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_INFORVALMERCADO_RES]
                                                (	@cSistema	CHAR	(3)
						,	@cFecha		CHAR	(8)
						,	@cCartera	CHAR	(1)
						,	@vTitulo	VARCHAR (200)	= 'SIN TITULO'	
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

	EXECUTE Sp_Base_Del_Informe	@acfecproc	OUTPUT		
		,			@acfecprox	OUTPUT		
		,			@uf_hoy		OUTPUT		
		,			@uf_man		OUTPUT		
		,			@ivp_hoy	OUTPUT		
		,			@ivp_man	OUTPUT		
		,			@do_hoy		OUTPUT		
		,			@do_man		OUTPUT		
		,			@da_hoy		OUTPUT		
		,			@da_man		OUTPUT		
		,			@acnomprop	OUTPUT		
		,			@rut_empresa	OUTPUT		
		,			@hora		OUTPUT

      SELECT 'rmnumdocu'	= ISNULL(RTRIM(CONVERT(CHAR(7),vm.rmnumdocu)) + '-' + CONVERT(CHAR(3),vm.rmcorrela),'*-*')
      ,      'rmnumoper'	= ISNULL(vm.rmnumoper,0)
      ,      'tminster'	        = CONVERT(VARCHAR(13),ISNULL(cp.cpinstser,'')) --> CONVERT(VARCHAR(13),ISNULL(tm.tminstser,''))
      ,      'tmfecpro'	        = ISNULL(CONVERT(CHAR(10),cp.cpfecven,103),'') --> ISNULL(CONVERT(CHAR(10),tm.tmfecvcto,103),'')
      ,      'tmnominal'	= CONVERT(NUMERIC(20), ISNULL(vm.valor_nominal,0))
      ,      'moneda'	        = ISNULL(mn.mnnemo,'')
      ,      'rmttir'	        = ISNULL(vm.tasa_compra,0)
      ,      'rmvpres'	        = CONVERT(NUMERIC(19,4),ISNULL(vm.valor_presente,0))
      ,      'rmvmerc'	        = CONVERT(NUMERIC(19,4),ISNULL(vm.valor_mercado,0))
      ,      'tmtmerc'	        = CONVERT(NUMERIC(19,4),ISNULL(vm.tasa_mercado,0))
      ,      'rmdmerc'	        = CONVERT(NUMERIC(19,4),ISNULL(vm.diferencia_mercado,0))
      ,      'tmmarket'	        = CONVERT(NUMERIC(19,4),ISNULL(tm.tasa_market,0))
      ,      'rmvmarket'	= CONVERT(NUMERIC(19,4),ISNULL(vm.valor_market,0))
      ,      'rmdmarket'	= ISNULL(vm.diferencia_market,0)
      ,      'tmmarket1'	= ISNULL(tm.tasa_market1,0)
      ,      'rmvmarket1'	= ISNULL(vm.valor_market1,0)
      ,      'rmdmarket1'	= ISNULL(vm.diferencia_market1,0)
      ,      'tmmarket2'	= ISNULL(tm.tasa_market2,0)
      ,      'rmvmarket2'	= ISNULL(vm.valor_market2,0)
      ,      'rmdmarket2'	= ISNULL(vm.diferencia_market2,0)
      ,      'inserie'          = CONVERT(CHAR(25), CASE WHEN INCODIGO = 15 AND emtipo       IN('1','3','4')	                    THEN 'BONOS OTRAS INST.'
                                                         WHEN INCODIGO = 15 AND emtipo       = '2'		                    THEN 'BONOS INST. FINANCIERAS'	
                                                         WHEN INCODIGO = 20 AND tm.tmrutemis = 97030000 AND vm.moneda_emision = 997 THEN 'LCHR ESTA IVP'
                                                         WHEN INCODIGO = 20 AND tm.tmrutemis = 97030000 AND vm.moneda_emision = 998 THEN 'LCHR ESTA UF' 
                                                         WHEN INCODIGO = 20 AND tm.tmrutemis = 97023000                             THEN 'LCHR PROPIAS'
                                                         WHEN INCODIGO = 20                                                         THEN 'LCHR OTROS' 
                                                         ELSE inserie 
                                                     END)
      ,      'sw'		= '0'
      ,      'titulo'	        = @vTitulo
      ,      'subtitulo'	= CASE WHEN vm.tipo_operacion = 'CP' THEN 'DISPONIBLE  '
				       ELSE 'INTERMEDIADO'  
                                  END
      ,      'Tipoper'	        = ISNULL(vm.tipo_operacion,'')
      ,      'TASA_EMISION'     = CASE	WHEN cpseriado = 'N' THEN (SELECT TOP 1    nstasemi FROM VIEW_NOSERIE WHERE nscodigo  = cpcodigo AND nsrutcart = cprutcart AND nsnumdocu = cpnumdocu AND nscorrela = cpcorrela)
					ELSE                      (SELECT DISTINCT setasemi FROM VIEW_SERIE   WHERE semascara = cpmascara) 
                                  END
      ,      'rsvppresen'       = ISNULL(cp.cpvalcomp,0.0)
      ,      'fechaaux'         = DATEDIFF(DAY,CONVERT(DATETIME,@cFecha,113),cp.cpfecven)
      ,      'duration'         = cp.cpdurat
      ,      'Clasificacion1'   = CASE WHEN LTRIM(CONVERT( CHAR(40),clasificacion1)) = '' THEN '---' END
      ,      'Clasificacion2'   = CASE WHEN LTRIM(CONVERT( CHAR(40),clasificacion2)) = '' THEN '---' END
      ,      'Tipo_corto1'	= CASE WHEN LTRIM(CONVERT( CHAR(40),tipo_corto1))    = '' THEN '---' END
      ,      'Tipo_largo1'	= CASE WHEN LTRIM(CONVERT( CHAR(40),tipo_largo1))    = '' THEN '---' END
      ,      'Tipo_corto2'	= CASE WHEN LTRIM(CONVERT( CHAR(40),tipo_corto1))    = '' THEN '---' END
      ,      'Tipo_largo2'	= CASE WHEN LTRIM(CONVERT( CHAR(40),tipo_largo2))    = '' THEN '---' END
      ,      'ValPresTC_LT'	= ISNULL(Clt_VPTC_ValAct,0)
      ,      'ValPresTM_LT'	= ISNULL(Clt_VPTM_ValAct,0)
      ,      'TirCompra_LT'	= ISNULL(Clt_TC_PP_Ini,0)
      ,      'TirMercado_LT'	= ISNULL(Clt_TM_PP_Val,0)
      ,      'ResDif_LT'	= ISNULL(Clt_Res_VM_VP,0)
       ,     'OrigenCurva'	= OrigenCurva 											--41
	   ,     'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
   INTO	   #TEMPORAL
   FROM    VALORIZACION_MERCADO                vm with(nolock)
           left  JOIN TASA_MERCADO             tm with(nolock) ON tm.id_sistema     = @cSistema
                                                              AND tm.fecha_proceso  = @cFecha
                                                              AND tm.tmrutcart      = vm.rmrutcart
                                                              AND tm.tmcodigo       = vm.rmcodigo
                                                              AND tm.tminstser      = vm.rminstser
							      AND tm.tmrutemis      = vm.rut_emisor
           INNER JOIN MDCP                      cp with(nolock) ON vm.rmnumdocu     = cp.cpnumdocu  AND vm.rmcorrela = cp.cpcorrela AND vm.rut_emisor <> '97023000' 
           LEFT  JOIN VIEW_MONEDA               mn with(nolock) ON mn.mncodmon      = vm.moneda_emision
           LEFT  JOIN VIEW_INSTRUMENTO          it with(nolock) ON it.incodigo      = cp.cpcodigo
           LEFT  JOIN VIEW_EMISOR               em with(nolock) ON em.emrut         = vm.rut_emisor --> AND em.emgeneric = tm.tmgenemis
           LEFT  JOIN TBL_CARTERA_LIBRE_TRADING lt with(nolock) ON lt.clt_sistema   = @cSistema
                                                               AND lt.clt_fechaproc = @cFecha
                                                               AND clt_numoper      = vm.rmnumoper
                                                               AND clt_numdocu      = vm.rmnumdocu
                                                               AND clt_numcorr      = vm.rmcorrela
   WHERE   vm.fecha_valorizacion      = @cFecha
   AND	   vm.codigo_carterasuper     = @cCartera
   AND	   CHARINDEX(STR( vm.moneda_emision, 3), CASE WHEN @cDolar = 'N' THEN '997-998-999' ELSE '988-994-995- 13-800-801' END)>0
   ORDER BY vm.rminstser


 
	IF @@ROWCOUNT > 0 BEGIN
		CREATE NONCLUSTERED INDEX TEMP_001 ON #TEMPORAL 
		(	inserie
		,	moneda
		,	tipoper
		)
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
		SELECT	''   ,		--1
			0    ,		--2
                        ''   ,		--3
			'',		--4
			tmnominal,	--5
			MONEDA   ,	--6
			0,		--7
			rmvpres, 	--8
			rmvmerc,	--9
			0,		--10
			rmdmerc,	--11
			0,		--12
			rmvmarket,	--13
			rmdmarket,	--14
			0,    		--15
			rmvmarket1,	--16
			rmDmarket1,	--17
			0,		--18
			rmvmarket2,	--19
			rmDmarket2,	--20
			INSERIE,	--21
			1,		--22
			'RESUMEN  '+ @vTitulo ,	--23
			subtitulo,	--24
			'',		--25
			0,		--26
			0,		--27
			'',		--28
			0,   		--29
			'',		--30
			'',		--31		
			'',		--32
			'',		--33
			'',		--34
			''		--35
		,	0.0		--36
		,	0.0		--37
		,	0.0		--38
		,	0.0		--39
		,	0.0		--40
                ,       '' 
				,'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)  
		FROM #TOTAL 
	END	
	ELSE BEGIN
		INSERT	INTO #TEMPORAL
		SELECT 	'',		--1
			0,		--2
			'',		--3
			'',		--4
			0,		--5
			'',		--6
			0,		--7
			0,		--8
			0,		--9
			0,		--10
			0,		--11
			0,		--12
			0,		--13
			0,		--14
			0,		--15
			0,		--16
			0,		--17
			0,		--18
			0,		--19
			0,		--20
			'',		--21
			'0',		--22
			@vTitulo,	--23
			'',		--24
			'',		--25
			0,		--26
			0,		--27
			'',		--28
			0,   		--29
           		'',		--30
           		'',		--31		
           		'',		--32
           		'',		--33
           		'',		--34
           		''		--35
		,	0.0		--36
		,	0.0		--37
		,	0.0		--38
		,	0.0		--39
		,	0.0		--40
                ,       ''
				, 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
	END
			
		SELECT	rmnumdocu,
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
			'inserie'	= ISNULL(inserie,''),
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
			'Fecha1'	= SUBSTRING(@cfecha,7,2) + '/' + SUBSTRING(@cfecha,5,2) + '/' + SUBSTRING(@cfecha,1,4),
			TASA_EMISION,
			rsvppresen,
			fechaaux,
                        duration,
			clasificacion1,
			clasificacion2,
			tipo_corto1,
			tipo_largo1,
			tipo_corto2,
			tipo_largo2
		,	ValPresTC_LT		--36
		,	ValPresTM_LT		--37
		,	TirCompra_LT		--38
		,	TirMercado_LT		--39
		,	ResDif_LT		--40
                ,	OrigenCurva
				,'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
		FROM	#TEMPORAL
		ORDER 
		BY	tminster

	SET NOCOUNT OFF

END

GO
