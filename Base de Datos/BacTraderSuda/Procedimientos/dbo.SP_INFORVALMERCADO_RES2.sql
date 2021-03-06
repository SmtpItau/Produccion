USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORVALMERCADO_RES2]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFORVALMERCADO_RES2] --'BTR','20020731','T','TRANSABLE','N'
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


	
--	IF EXISTS(SELECT * FROM TASA_MERCADO WHERE id_sistema=@cSistema AND fecha_proceso=@cFecha AND
--		  CHARINDEX(STR( tmmonemis,3),CASE WHEN @cDolar='N' THEN '997-998-999' ELSE '988-994-995- 13' END)>0)
--	BEGIN

		SELECT 	'rmnumdocu'	= ISNULL(RTRIM(CONVERT(CHAR(7),VALORIZACION_MERCADO.rmnumdocu))+'-'+ CONVERT(CHAR(3),VALORIZACION_MERCADO.rmcorrela),'*-*'),--1
			'rmnumoper'	= ISNULL(VALORIZACION_MERCADO.rmnumoper,0)										,--2
			'tminster'	= ISNULL(TASA_MERCADO.tminstser,'')											,--3	
			'tmfecpro'	= ISNULL(CONVERT(CHAR(10),TASA_MERCADO.tmfecvcto,103),'')								,--4
			'tmnominal'	= CONVERT(NUMERIC(20), ISNULL(VALORIZACION_MERCADO.valor_nominal,0))											,--5
			'moneda'	= ISNULL(VIEW_MONEDA.mnnemo,'')												,--6
			'rmttir'	= ISNULL(VALORIZACION_MERCADO.tasa_compra,0)										,--7
			'rmvpres'	= CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO.valor_presente,0))										,--8
			'rmvmerc'	= CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO.valor_mercado,0))										,--9
			'tmtmerc'	= CONVERT(NUMERIC(19,4),ISNULL(TASA_MERCADO.tasa_mercado,0))											,--10
			'rmdmerc'	= CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO.diferencia_mercado,0))									,--11
			'tmmarket'	= CONVERT(NUMERIC(19,4),ISNULL(TASA_MERCADO.tasa_market,0))											,--12
			'rmvmarket'	= CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO.valor_market,0))										,--13
			'rmdmarket'	= ISNULL(VALORIZACION_MERCADO.diferencia_market,0)									,--14
			'tmmarket1'	= ISNULL(TASA_MERCADO.tasa_market1,0)											,--15
			'rmvmarket1'	= ISNULL(VALORIZACION_MERCADO.valor_market1,0)										,--16
			'rmdmarket1'	= ISNULL(VALORIZACION_MERCADO.diferencia_market1,0)									,--17
			'tmmarket2'	= ISNULL(TASA_MERCADO.tasa_market2,0)											,--18
			'rmvmarket2'	= ISNULL(VALORIZACION_MERCADO.valor_market2,0)									        ,--19
			'rmdmarket2'	= ISNULL(VALORIZACION_MERCADO.diferencia_market2,0)									,--20
			'inserie'       = CONVERT(CHAR(15), CASE WHEN TASA_MERCADO.tmrutemis = 97029000   THEN 'LCHR ESTA'
                                                WHEN TASA_MERCADO.tmrutemis = 97023000   THEN 'LCHR PROPIAS'
                                                WHEN incodigo = 15 THEN 'BONOS' 
                                               -- WHEN  TASA_MERCADO.tmrutemis <>97029000 AND TASA_MERCADO.tmrutemis <> 97023000   THEN  'LCHR OTROS' 
                                            ELSE inserie
                                           END),
/*			'inserie'	= CASE SELECT * FROM MDAC
						WHEN TASA_MERCADO.tmcodigo=20 THEN 'LCHR '+(SELECT cptipoletra FROM MDCP WHERE cpnumdocu=rmnumdocu AND cpcorrela=rmcorrela)
						ELSE  inserie
					  END															,*/
			'sw'		= '0'															,--22
			'titulo'	= @vTitulo														,--23
			'subtitulo'	= CASE
						WHEN VALORIZACION_MERCADO.tipo_operacion='CP' THEN 'DISPONIBLE  '
						ELSE 'INTERMEDIADO'
					  END															
--			'Tipoper'	= ISNULL(VALORIZACION_MERCADO.tipo_operacion,'')									 --24
			INTO	#TEMPORAL
			FROM 	TASA_MERCADO, VALORIZACION_MERCADO, VIEW_MONEDA, VIEW_INSTRUMENTO, VIEW_EMISOR
			WHERE	TASA_MERCADO.id_sistema      =@cSistema
			AND	TASA_MERCADO.fecha_proceso   =@cFecha
			AND	fecha_valorizacion           =@cFecha
			AND	VALORIZACION_MERCADO.codigo_carterasuper=@cCartera
			AND	TASA_MERCADO.tmrutcart=VALORIZACION_MERCADO.rmrutcart
			AND	VIEW_MONEDA.mncodmon=TASA_MERCADO.tmmonemis
			AND	VIEW_INSTRUMENTO.incodigo=TASA_MERCADO.tmcodigo
			AND	TASA_MERCADO.tminstser=VALORIZACION_MERCADO.rminstser
			AND	CHARINDEX(STR( tmmonemis,3),CASE WHEN @cDolar='N' THEN '997-998-999' ELSE '988-994-995- 13' END)>0
			AND	emrut       =   rut_emisor
			AND	emgeneric   =   tmgenemis
			ORDER BY rmnumoper,rmcorrela--,tipoper

-- SELECT * FROM VIEW_INSTRUMENTO
	IF (SELECT COUNT(*) FROM #TEMPORAL)>0
	BEGIN

		SELECT	inserie                  	        ,
			moneda					,
--			tipoper					,
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
		GROUP BY inserie,moneda--,tipoper

--		GROUP BY tipoper,inserie,moneda
--  dbo.Sp_Inforvalmercado_RES 'BTR','20020731','T','CCC','N'
 --SELECT * FROM #TOTAL                                                                               -- inserie        
-- dbo.Sp_Inforvalmercado_res2 'BTR','20020731','T','TRANSABLE','N'
INSERT INTO #TEMPORAL SELECT '',0,'','',tmnominal,MONEDA,0, rmvpres, rmvmerc,0,rmdmerc,0,rmvmarket,rmdmarket,0,rmvmarket1,rmvmarket1,0,rmvmarket2,rmvmarket2,INSERIE,1,'RESUMEN DE'+ @vTitulo ,'0'      FROM #TOTAL
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
			''
--			''

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
			'Fecha1'	= SUBSTRING(@cfecha,7,2)+'/'+SUBSTRING(@cfecha,5,2)+'/'+SUBSTRING(@cfecha,1,4)
		FROM	#TEMPORAL
           --    ORDER BY subtitulo,inserie,moneda,tminster--,tipoper


	--SET NOCOUNT OFF

END


-- Sp_Inforvalmercado 'BTR','20020331','P','TM PER','N'
-- Sp_Inforvalmercado 'BTR','20020331','T','TM TRA','N'
-- select * from valorizacion_mercado
-- select * from tasa_mercado
-- select * from view_emisor
-- SP_AUTORIZA_EJECUTAR 'BACUSER'
-- select * from mdac

/*
SELECT * FROM DROP TABLE TEMPORAL



SELECT	inserie					,
        moneda					,
        SUM(tmnominal)	,
	SUM(rmvpres)		,
	SUM(rmvmerc)		,
	SUM(rmdmerc)		,
	SUM(rmvmarket)	,
	SUM(rmdmarket)	,
	SUM(rmvmarket1)	,
	SUM(rmdmarket1)	,
	SUM(rmvmarket2)	,
	SUM(rmdmarket2)
	
		FROM	TEMPORAL
		GROUP BY inserie,moneda

SELECT * FROM DROP TABLE TOTAL
SELECT * FROM TEMPORAL
INSERT INTO TEMPORAL SELECT '',0,'','',tmnominal,moneda,0, rmvpres, rmvmerc,0,rmdmerc,0,0,0,0,0,0,0,0,0,inserie,0,'',''      FROM TOTAL
*/




GO
