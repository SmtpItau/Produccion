USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADORC]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- SP_LISTADORC 0, 'MOVIMIENTO DIARIO DE RECOMPRAS', 0, 1552, ''

CREATE PROCEDURE [dbo].[SP_LISTADORC]
   (
   @entidad 	FLOAT   		,
   @titulo  	VARCHAR (200) = ''	,
   @Cartera_Inv Integer			,
   @Cat_Libro	CHAR(06)		,
   @Id_Libro	CHAR(06)		
   )
AS
BEGIN
 	SET NOCOUNT ON
 	DECLARE @ncartini NUMERIC (10,0) ,
  	@ncartfin NUMERIC (10,0) ,
  	@acfecproc    CHAR (10) ,
        @acfecprox    CHAR (10) ,
        @uf_hoy       FLOAT  ,
        @uf_man       FLOAT  ,
        @ivp_hoy      FLOAT  ,
        @ivp_man      FLOAT  ,
        @do_hoy       FLOAT  ,
        @do_man       FLOAT  ,
        @da_hoy       FLOAT  ,
        @da_man       FLOAT  ,
        @acnomprop    CHAR (40) ,
        @rut_empresa  CHAR (12) ,
        @hora         CHAR (8),
  	@Glosa_Cartera	Char   (20)	,
  	@Glosa_Libro	Char   (50)

Select @Glosa_Cartera = '' 

   SELECT Distinct
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema = 'BTR'
     And  rcrut     = @Cartera_INV
	 --  ORDER BY rcrut  REQ.7619 CASS 25-01-2011

   IF @Glosa_Cartera = '' 
	Select @Glosa_Cartera = '< TODAS >'

   IF  @id_libro = '' BEGIN
	SELECT @Glosa_libro = '< TODOS >'	
   END 
   ELSE BEGIN
	SELECT	@Glosa_libro	= tbglosa
	FROM	VIEW_TABLA_GENERAL_DETALLE
	WHERE	tbcateg		= @Cat_Libro 
	AND	tbcodigo1	= @Id_Libro
   END

 	SELECT @ncartini  = @entidad 
 	SELECT @ncartfin  = CASE @entidad WHEN 0 THEN 999999999 ELSE @entidad END
 	EXECUTE Sp_Base_Del_Informe
  		@acfecproc   OUTPUT,
  		@acfecprox   OUTPUT,
  		@uf_hoy      OUTPUT,
  		@uf_man      OUTPUT,
  		@ivp_hoy     OUTPUT,
  		@ivp_man     OUTPUT,
  		@do_hoy      OUTPUT,
  		@do_man      OUTPUT,
  		@da_hoy      OUTPUT,
  		@da_man      OUTPUT,
  		@acnomprop   OUTPUT,
  		@rut_empresa OUTPUT,
  		@hora        OUTPUT

	-- FUSION ---
	SET @acnomprop       = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
	-------------

 	SELECT  'nomcli' = ISNULL(clnombre,'')        ,
               	'noment' = ISNULL(acnomprop,'')        ,
               	'numdocu' = ISNULL(RTRIM(CONVERT(CHAR(10),monumdocu))+'-'+CONVERT(CHAR(3),mocorrela),'') ,
                'instrumento' = ISNULL(moinstser,'')        ,
              	'emisor' = ISNULL(emgeneric,'')        ,
           	'moneda' = ISNULL((SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon=momonemi),'')  ,
  		'nominal' = ISNULL(monominal,0.0)        ,
                'tirventa' = ISNULL(motir,0.0)         ,
               	'pvp'  = ISNULL(mopvp, 0.0)        ,
               	'tasest' = CONVERT(FLOAT,motasest)       ,
  		'interes' = ISNULL(mointpac,0.0)        ,
               	'fecinip' = ISNULL(CONVERT(CHAR(10),mofecinip,103),'')     ,
               	'tasapact' = ISNULL(CASE motipoper WHEN 'RC' THEN motaspact ELSE motasant END,0.0)  ,
               	'basepact' = ISNULL(mobaspact,0)        ,
             	'monpacto' = ISNULL((SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon=momonpact),'')  ,
               	'valinip' = CASE WHEN a.mnmx = 'C' AND momonpact <> 13 Then ISNULL(Round(movalinip/momtoPFE,2),0) ELSE ISNULL(movalinip,0) END       ,
                'valorven' = ISNULL(movalvenp,0)        ,
  		'forpagoven' = CASE moforpagv WHEN 6 THEN Clctacte
              			WHEN 7 THEN Clctacte
              			ELSE v.glosa END, --ISNULL(v.glosa,'')        ,
  		'tipoper' = motipoper         ,
  		'numoper' = ISNULL(monumoper,0)        ,
  		'entidad'  = acnomprop         ,
  		'reajustes' = ISNULL(moreapac,0.0)        ,
  		'inserie'       = ISNULL((SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo=mocodigo),'') ,
  		'sw'  = '0'          ,
  		'titulo' = @titulo         ,
  		'plazo'  = DATEDIFF(DAY,mofecinip,mofecvenp)      ,
  		'formapagoini'  = ISNULL(i.glosa,''),
  		mnmx	,
		'Tipo_Cart'	= ISNULL(cfrf.glosa, 'sin definicion'), --(SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BTR' And rcrut =  motipcart),
		'Tipo_InV'	= @Glosa_Cartera	,
		'libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND tbcodigo1 = MDMO.id_libro),'') ,
		'Glosa_libro'	= @Glosa_Libro
  	INTO #TEMP
  	FROM --  REQ. 7619
         MDMO   RIGHT OUTER JOIN VIEW_EMISOR ON emrut = morutemi 
				LEFT JOIN (
							select Id = cf.tbcodigo1, Glosa = cf.tbglosa
							from BacParamSuda..TIPO_CARTERA tc with(nolock)
							INNER JOIN (
										select tbcodigo1, tbglosa
										from BacParamSuda..TABLA_GENERAL_DETALLE with(nolock)
										where tbcateg  = 204
										) cf on cf.tbcodigo1 = tc.rcrut
							where tc.rcsistema = 'BTR'
							AND tc.rccodpro = 'RC'

							) cfrf on cfrf.Id = motipcart,

         VIEW_CLIENTE, 
         MDAC, 
--  REQ. 7619
--         VIEW_EMISOR, 
         VIEW_FORMA_DE_PAGO i, 
         VIEW_FORMA_DE_PAGO v , 
         View_moneda a
        WHERE	(motipoper	=  'RC'		OR motipoper	= 'RCA') 
	AND	acrutprop	=  morutcart 
	AND	(clrut		=  morutcli	AND clcodigo	= mocodcli) 
--  REQ. 7619
--	AND	emrut		=* morutemi 
	AND	(morutcart	>= @ncartini	AND morutcart	<= @ncartfin) 
	AND	moforpagv	=  v.codigo 
	AND	moforpagi	=  i.codigo 
	AND	momonpact	=  a.mncodmon
	AND	(motipcart	=  @Cartera_INV	OR @Cartera_INV	= 0) 
	AND	(id_libro	=  @id_libro	OR @id_libro	= '')

 	IF (SELECT COUNT(1) FROM #TEMP)>0
 	BEGIN
  		SELECT 	'valinip' = SUM(valinip) ,
   			'interes' = SUM(interes) ,
   			'reajustes' = SUM(reajustes),
   			'valorven' = SUM(valorven) ,
                        'tasa'         = SUM(valinip*tasapact) / SUM(valinip),
   			'monedapac' = monpacto,
   			'mnmx'      = Max(mnmx)
  		INTO #TOTAL 
  		FROM #TEMP
  		GROUP BY monpacto

  		INSERT INTO #TEMP
  		SELECT 	''  ,
   			''  ,
   			''  ,
   			''  ,
   			''  ,
   			''  ,
   			0  ,
   			0  ,
   			0  ,
   			0  ,
   			interes  ,
   			''  ,
   			tasa  ,
   			0  ,
   			monedapac ,
   			valinip  ,
 			valorven ,
   			''  ,
   			''  ,
   			0  ,
   			''  ,
   			reajustes ,
         		'TOTAL'  ,
   			'sw' = '1' ,
   			'RESUMEN '+@titulo ,
   			0   ,
   			'',
   			mnmx	,
			''	,
			@glosa_cartera	,
			''		,
			@glosa_libro
  		FROM #TOTAL
 	END
 	ELSE
 	BEGIN
          	INSERT INTO #TEMP
          	SELECT 	''  ,
   			''  ,
   			''  ,
   			''  ,
   			''  ,
   			''  ,
   			0  ,
   			0  ,
   			0  ,
   			0  ,
   			0  ,
   			''  ,
   			0  ,
   			0  ,
   			''  ,
   			0  ,
   			0  ,
   			''  ,
   			''  ,
   			0  ,
   			''  ,
   			0  ,
         		''  ,
   			'sw' = '0' ,
   			@titulo  ,
   			0  ,
   			'' ,
   			'' ,
			'' ,
			@glosa_cartera	,
			''		,
			@glosa_libro
 	END

 	SELECT  nomcli  ,
                noment  ,
  		numdocu  ,
                instrumento ,
              	emisor  ,
     		moneda  ,
  		nominal  ,
    		tirventa ,
               	pvp  ,
         	tasest  ,
  		interes  ,
               	fecinip  ,
               	tasapact ,
               	basepact ,
         	monpacto ,
        	valinip  ,
                valorven ,
  		forpagoven ,
  		tipoper  ,
  		numoper  ,
  		entidad  ,
  		reajustes ,
  		inserie  ,
  		FormaPagoIni ,
  		'acfecproc'   = @acfecproc    ,
            	'acfecprox'   = @acfecprox    ,
         	'uf_hoy'      = @uf_hoy       ,
  		'uf_man'      = @uf_man       ,
         	'ivp_hoy'     = @ivp_hoy      ,
  		'ivp_man'     = @ivp_man      ,
     		'do_hoy'      = @do_hoy       ,
  		'do_man'      = @do_man       ,
  		'da_hoy'      = @da_hoy       ,
  		'da_man'      = @da_man       ,
  		'acnomprop'   = @acnomprop    ,
  		'rut_empresa' = @rut_empresa  ,
  		'hora'        = @hora  ,
  		sw    ,
  		titulo    ,
  		plazo	,
  		mnmx	,
		Tipo_Cart,
		Tipo_INV	,
		Libro		,
		Glosa_Libro
        FROM #TEMP
 	ORDER BY inserie,monpacto
 
 SET NOCOUNT OFF
END
GO
