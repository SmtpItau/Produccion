USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORVALMERCADO_DIA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFORVALMERCADO_DIA] 
				(
				@cSistema	CHAR	(3)	= ''	,
				@cFecha		CHAR	(8)	= ''	,
				@cCartera	CHAR	(1)	= ''	,
				@vTitulo	VARCHAR	(200)	= ''	,
				@cDolar		CHAR	(01)
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
		@hora		CHAR(8)		,
		@dFecFMesAnt    DATETIME        ,
		@fec_proc       DATETIME

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

SELECT @acfecproc = acfecproc,
       @fec_proc = acfecprox
FROM MDAC



-- SELECT @dFecFMesAnt = DATEADD( DAY, DATEPART( DAY, CONVERT(DATETIME,@fec_proc)) * -1, CONVERT(DATETIME,@fec_proc))

	SELECT distinct 'rmnumdocu'	= ISNULL(RTRIM(CONVERT(CHAR(7),VALORIZACION_MERCADO_DIARIA.rmnumdocu))+'-'+ CONVERT(CHAR(3),VALORIZACION_MERCADO_DIARIA.rmcorrela),'*-*'),--1
			'rmnumoper'	= ISNULL(VALORIZACION_MERCADO_DIARIA.rmnumoper,0)										,--2
			'tminster'	= CONVERT(VARCHAR(13),ISNULL(VALORIZACION_MERCADO_DIARIA.rminstser,''))											,--3	
			'tmfecpro'	= ISNULL(CONVERT(CHAR(10),VALORIZACION_MERCADO_DIARIA.tmfecven,103),'')								,--4
			'tmnominal'	= CONVERT(NUMERIC(20), ISNULL(VALORIZACION_MERCADO_DIARIA.valor_nominal,0))											,--5
			'moneda'	= ISNULL(VIEW_MONEDA.mnnemo,'')												,--6
			'rmttir'	= ISNULL(VALORIZACION_MERCADO_DIARIA.tasa_compra,0)										,--7
			'rmvpres'	= CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO_DIARIA.valor_presente,0))										,--8
			'rmvmerc'	= CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO_DIARIA.valor_mercado,0))										,--9
			'tmtmerc'	= CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO_DIARIA.tasa_mercado,0))											,--10
--			'tmtmerc'	= ISNULL(VALORIZACION_MERCADO_DIARIA.tasa_compra,0),
			'rmdmerc'	= CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO_DIARIA.diferencia_mercado,0))									,--11
			'tmmarket'	= CONVERT(NUMERIC(19,4),tasa_market )		,--12
			'rmvmarket'	= CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO_DIARIA.valor_market,0))										,--13
			'rmdmarket'	= ISNULL(VALORIZACION_MERCADO_DIARIA.diferencia_market,0)									,--14
			'tmmarket1'	= CONVERT(NUMERIC(19,4),0)											,--15
			'rmvmarket1'	= ISNULL(VALORIZACION_MERCADO_DIARIA.valor_market1,0)										,--16
			'rmdmarket1'	= ISNULL(VALORIZACION_MERCADO_DIARIA.diferencia_market1,0)									,--17
			'tmmarket2'	= CONVERT(NUMERIC(19,4),0)											,--18
			'rmvmarket2'	= ISNULL(VALORIZACION_MERCADO_DIARIA.valor_market2,0)									        ,--19
			'rmdmarket2'	= ISNULL(VALORIZACION_MERCADO_DIARIA.diferencia_market2,0)	
								,--20
			'inserie'       = CONVERT(CHAR(15), 
                                          CASE WHEN INCODIGO = 20 AND valorizacion_mercado_DIARIA.rut_emisor = 97030000 AND  valorizacion_mercado_DIARIA.moneda_emision = 997 THEN 'LCHR ESTA IVP'
                                               WHEN INCODIGO = 20 AND valorizacion_mercado_DIARIA.rut_emisor = 97030000 AND  valorizacion_mercado_DIARIA.moneda_emision = 998 THEN 'LCHR ESTA UF' 
                                               WHEN valorizacion_mercado_DIARIA.rut_emisor = 97023000  AND  INCODIGO = 20 THEN 'LCHR PROPIAS'
                                               WHEN INCODIGO = 20                                         THEN 'LCHR OTROS' 
                                            ELSE inserie
                                          END),

         		'sw'		= '0'															,--22
			'titulo'	= @vTitulo														,--23
			'subtitulo'	= CASE
						WHEN VALORIZACION_MERCADO_DIARIA.tipo_operacion = 'CP' THEN 'DISPONIBLE  '
						ELSE 'INTERMEDIADO'
					  END	,														
			'Tipoper'	= ISNULL(VALORIZACION_MERCADO_DIARIA.tipo_operacion,'')									, --24
			'rsvppresen'    = ISNULL(cpvalcomp,0.0),
			'fechaaux'      = datediff(DAY,convert(datetime,@cFecha,113),cpfecven),
                        'duration'      = cpdurat,
			'TASA_EMISION'  = CASE
                                             WHEN cpseriado='N' THEN (SELECT top 1 nstasemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
                                             ELSE (SELECT DISTINCT setasemi FROM VIEW_SERIE WHERE semascara=cpmascara)
                                         END,
			'fechacompra'	= cpfeccomp

			INTO	#TEMPORAL
			FROM 	VALORIZACION_MERCADO_DIARIA, VIEW_MONEDA, VIEW_INSTRUMENTO , VIEW_EMISOR,MDCP
			WHERE	VALORIZACION_MERCADO_DIARIA.fecha_valorizacion  = @cfecha                     	
			AND	VALORIZACION_MERCADO_DIARIA.codigo_carterasuper = @cCartera
			AND	VIEW_MONEDA.mncodmon                     	= VALORIZACION_MERCADO_DIARIA.moneda_emision
			AND	VIEW_INSTRUMENTO.incodigo                	= VALORIZACION_MERCADO_DIARIA.rmcodigo
			AND	CHARINDEX(STR( moneda_emision,3),CASE WHEN @cDolar='N' THEN '997-998-999' ELSE '988-994-995- 13' END)>0
			AND	emrut                                    	=   rut_emisor
			AND     VALORIZACION_MERCADO_DIARIA.rmnumdocu          	= cpnumdocu and VALORIZACION_MERCADO_DIARIA.rmcorrela = cpcorrela
			order by inserie

/*UPDATE #TEMPORAL SET tmtmerc = ISNULL(tasa_mercado,0) FROM TASA_MERCADO
                                         WHERE  fecha_proceso = @dFecFMesAnt
                                          and  id_sistema     = 'BTR' 
                                          AND  tminstser      = tminster 
                                         -- AND  tmgenemis      = digenemi   
                                        --AND  nominal        = tmnominal
					  AND  fechacompra    <=@dFecFMesAnt */


/*----------------------------------------------------------------------------------------*/
/*           CUANDO NO ES FIN DE MES, SI LA TASA ES CERO SE COLOCA LA TIR DE COMPRA       */
  UPDATE #TEMPORAL SET tmtmerc = rmttir where  tmtmerc = 0
/*-----------------------------------------------------------------------------------------*/

	IF (SELECT COUNT(*) FROM #TEMPORAL)>0
	BEGIN

		SELECT	distinct inserie                  	        ,
			moneda					,
			tipoper					,
                        subtitulo                               ,
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
		GROUP BY inserie , moneda , tipoper , subtitulo
                                                                                                                                                                 --  1
INSERT INTO #TEMPORAL SELECT '',0,'','',tmnominal,MONEDA,0, rmvpres, rmvmerc,0,rmdmerc,0,rmvmarket,rmdmarket,0,rmvmarket1,rmvmarket1,0,rmvmarket2,rmvmarket2,INSERIE,1,'RESUMEN  '+ @vTitulo ,subtitulo,'',0,0,0,0,''     FROM #TOTAL



--UPDATE #TEMPORAL SET  tminster = 'DISPONIBLE  '  WHERE subtitulo = 'DISPONIBLE  ' AND SW = 1
--UPDATE #TEMPORAL SET  tminster = 'INTERMEDIADO'  WHERE subtitulo = 'INTERMEDIADO' AND SW = 1

--CASE WHEN subtitulo = 'INTERMEDIADO' THEN  'INTERMEDIADO' ELSE 'DISPONIBLE' END
/*

		INSERT	INTO
		#TEMPORAL
		SELECT 	'',
			0,
			'inserie' = ISNULL(inserie,''),
		        '',
			tmnominal,
			'',
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
			rmdmarket1,
		0,
			rmvmarket2,
			rmdmarket2,
			'TOTAL',
			'sw'= '1',
			'RESUMEN ' + @vTitulo,
			'subtitulo'= CASE 
			             WHEN tipoper ='CP' THEN 'DISPONIBLE' ELSE 'INTERMEDIADO' END
--			tipoper
		FROM	#TOTAL
*/

	END	ELSE
	BEGIN

		INSERT	INTO
		#TEMPORAL
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
			0,
			0,
			''
	END

--------------------------------------------- mmp 

-- UPDATE #TEMPORAL SET tmmarket   = ISNULL((SELECT top 1  tasa_market  FROM TASA_MERCADO WHERE fecha_proceso= @cFecha AND id_sistema = @cSistema AND tminstser = tminstser AND tmnominal = tmnominal ),0)
 UPDATE #TEMPORAL SET tmmarket1  = ISNULL((SELECT top 1  tasa_market1 FROM TASA_MERCADO WHERE fecha_proceso= @cFecha AND id_sistema = @cSistema AND tminstser = tminstser AND tmnominal = tmnominal ),0)
 UPDATE #TEMPORAL SET tmmarket2  = ISNULL((SELECT top 1  tasa_market2 FROM TASA_MERCADO WHERE fecha_proceso= @cFecha AND id_sistema = @cSistema AND tminstser = tminstser AND tmnominal = tmnominal ),0)

----------------------------------------
			
		SELECT distinct  rmnumdocu,
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
--			tipoper				,
			'Fecha1'	= SUBSTRING(@cfecha,7,2)+'/'+SUBSTRING(@cfecha,5,2)+'/'+SUBSTRING(@cfecha,1,4),
			rsvppresen,
			fechaaux,
                        duration,
			TASA_EMISION,
			fechacompra
		FROM	#TEMPORAL
               ORDER BY subtitulo,inserie,moneda,tminster--,tipoper


	--SET NOCOUNT OFF

END


-- Sp_Inforvalmercado 'BTR','20020331','P','TM PER','N'
-- Sp_Inforvalmercado 'BTR','20020331','T','TM TRA','N'
-- select * from valorizacion_mercado_diaria where fecha_valorizacion = '20021216' ORDER BY rminstser
-- select * from tasa_mercado_DIARIA WHERE FECHA
-- select * from view_emisor
-- SP_AUTORIZA_EJECUTAR 'BACUSER'
-- select * from mdac
----------------------------
/*		SELECT distinct 'rmnumdocu'	= ISNULL(RTRIM(CONVERT(CHAR(7),VALORIZACION_MERCADO_DIARIA.rmnumdocu))+'-'+ CONVERT(CHAR(3),VALORIZACION_MERCADO_DIARIA.rmcorrela),'*-*'),--1
			'rmnumoper'	= ISNULL(VALORIZACION_MERCADO_DIARIA.rmnumoper,0)										,--2
			'tminster'	= CONVERT(VARCHAR(13),ISNULL(TASA_MERCADO_DIARIA.tminstser,''))											,--3	
			'tmfecpro'	= ISNULL(CONVERT(CHAR(10),TASA_MERCADO_DIARIA.tmfecvcto,103),'')								,--4
			'tmnominal'	= CONVERT(NUMERIC(20), ISNULL(VALORIZACION_MERCADO_DIARIA.valor_nominal,0))											,--5
			'moneda'	= ISNULL(VIEW_MONEDA.mnnemo,'')												,--6
			'rmttir'	= ISNULL(VALORIZACION_MERCADO_DIARIA.tasa_compra,0)										,--7
			'rmvpres'	= CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO_DIARIA.valor_presente,0))										,--8
			'rmvmerc'	= CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO_DIARIA.valor_mercado,0))										,--9
			'tmtmerc'	= CONVERT(NUMERIC(19,4),ISNULL(TASA_MERCADO_DIARIA.tasa_mercado,0))											,--10
			'rmdmerc'	= CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO_DIARIA.diferencia_mercado,0))									,--11
			'tmmarket'	= CONVERT(NUMERIC(19,4),ISNULL(TASA_MERCADO_DIARIA.tasa_market,0))											,--12
			'rmvmarket'	= CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO_DIARIA.valor_market,0))										,--13
			'rmdmarket'	= ISNULL(VALORIZACION_MERCADO_DIARIA.diferencia_market,0)									,--14
			'tmmarket1'	= ISNULL(TASA_MERCADO_DIARIA.tasa_market1,0)											,--15
			'rmvmarket1'	= ISNULL(VALORIZACION_MERCADO_DIARIA.valor_market1,0)										,--16
			'rmdmarket1'	= ISNULL(VALORIZACION_MERCADO_DIARIA.diferencia_market1,0)									,--17
			'tmmarket2'	= ISNULL(TASA_MERCADO_DIARIA.tasa_market2,0)											,--18
			'rmvmarket2'	= ISNULL(VALORIZACION_MERCADO_DIARIA.valor_market2,0)									        ,--19
			'rmdmarket2'	= ISNULL(VALORIZACION_MERCADO_DIARIA.diferencia_market2,0)	
								,--20
			'inserie'       = CONVERT(CHAR(15), 
                                          CASE WHEN INCODIGO = 20 AND TASA_MERCADO_DIARIA.tmrutemis = 97030000 AND  valorizacion_mercado_DIARIA.moneda_emision = 997 THEN 'LCHR ESTA IVP'
                                               WHEN INCODIGO = 20 AND TASA_MERCADO_DIARIA.tmrutemis = 97030000 AND  valorizacion_mercado_DIARIA.moneda_emision = 998 THEN 'LCHR ESTA UF' 
                                               WHEN TASA_MERCADO_DIARIA.tmrutemis = 97023000  AND  INCODIGO = 20 THEN 'LCHR PROPIAS'
                                               WHEN INCODIGO = 20                                         THEN 'LCHR OTROS' 
                                            ELSE inserie
                              END),

         		'sw'		= '0'															,--22
			'titulo'	= @vTitulo														,--23
			'subtitulo'	= CASE
						WHEN VALORIZACION_MERCADO_DIARIA.tipo_operacion = 'CP' THEN 'DISPONIBLE  '
						ELSE 'INTERMEDIADO'
					  END	,														
			'Tipoper'	= ISNULL(VALORIZACION_MERCADO_DIARIA.tipo_operacion,'')									 --24
			INTO	#TEMPORAL
			FROM 	TASA_MERCADO_DIARIA, VALORIZACION_MERCADO_DIARIA, VIEW_MONEDA, VIEW_INSTRUMENTO, VIEW_EMISOR
			WHERE	TASA_MERCADO_DIARIA.id_sistema                  = @cSistema
			AND	TASA_MERCADO_DIARIA.fecha_proceso               = @cFecha
			AND	fecha_valorizacion                       = @cFecha
			AND	VALORIZACION_MERCADO_DIARIA.codigo_carterasuper = @cCartera
			AND	TASA_MERCADO_DIARIA.tmrutcart                   = VALORIZACION_MERCADO_DIARIA.rmrutcart
			AND	VIEW_MONEDA.mncodmon                     = TASA_MERCADO_DIARIA.tmmonemis
			AND	VIEW_INSTRUMENTO.incodigo                = TASA_MERCADO_DIARIA.tmcodigo
			AND	TASA_MERCADO_DIARIA.tminstser            = VALORIZACION_MERCADO_DIARIA.rminstser
			AND	CHARINDEX(STR( tmmonemis,3),CASE WHEN @cDolar='N' THEN '997-998-999' ELSE '988-994-995- 13' END)>0
			AND	emrut                                    =   rut_emisor
			AND	emgeneric                                =   tmgenemis*/

-----------------------------------------------








--TRUNCATE TABLE MDCP
--DELETE MDCP WHERE cpcodigo = 20
--DELETE MDDI WHERE diserie = 'LCHR'
--SELECT * FROM MDDI







GO
