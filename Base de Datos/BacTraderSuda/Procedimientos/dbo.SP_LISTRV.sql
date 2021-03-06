USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTRV]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SP_LISTRV 0, 'MOVIMIENTO DIARIO DE REVENTAS', 0, 1552, ''

CREATE PROCEDURE [dbo].[SP_LISTRV] --0,'GSFGSFG',0,'1552',''
   (
   @entidad 	FLOAT 			,
   @titulo  	VARCHAR (200)= ''	,
   @Cartera_Inv Integer			,
   @Cat_Libro	CHAR(06)= ''		,
   @Id_Libro	CHAR(06)= ''
   )
AS
BEGIN
        SET NOCOUNT ON
 	DECLARE @ncartini NUMERIC(10,0),
  	@ncartfin NUMERIC(10,0),
  	@acfecproc    CHAR(10),
        @acfecprox    CHAR(10),
        @uf_hoy       FLOAT,
        @uf_man       FLOAT,
        @ivp_hoy      FLOAT,
        @ivp_man      FLOAT,
        @do_hoy       FLOAT,
        @do_man       FLOAT,
        @da_hoy       FLOAT,
        @da_man       FLOAT,
        @acnomprop    CHAR(40),
        @rut_empresa  CHAR(12),
        @hora         CHAR(8),
	@Glosa_Cartera		Char   (20)	,
	@Glosa_Libro		Char   (50)

   SELECT @Glosa_Cartera = '' 

   SELECT Distinct
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema = 'BTR'
     And  rcrut     = @Cartera_INV
--	   ORDER BY rcrut  REQ.7619 CASS 25-01-2011

  if @Glosa_Cartera = '' 
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

        IF EXISTS(SELECT 1 FROM MDMO WHERE MDMO.motipoper = 'RV' or MDMO.motipoper = 'RVA' AND MDMO.mostatreg <> 'A') 
 	BEGIN
  		SELECT  'nomcli' = ISNULL( VIEW_CLIENTE.clnombre , ''),
            'noment' = ISNULL( VIEW_ENTIDAD.rcnombre , ''),
   			'tipcart' = isnull(cfrf.glosa,'sin definicion'), --ISNULL((SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BTR' And rcrut =  motipcart),''),
            'numdocu' = ISNULL( RTRIM(CONVERT(CHAR(10),monumdocu))+'-'+CONVERT(CHAR(3),MDMO.mocorrela),''),
            'instrumento' = ISNULL( moinstser, ''),
            'emisor' = ISNULL( VIEW_EMISOR.emgeneric, ''),
            'moneda' = ISNULL( Mon_A.mnnemo, ''),
   			'nominal' = ISNULL( monominal,0.0),
            'tirventa' = ISNULL( motir,0.0) ,
            'pvp'  = ISNULL( mopvp, 0.0),
            'tasest' = CONVERT(FLOAT,motasest),
   			'interes' = ISNULL( mointpac,0.0),
            'fecinip' = ISNULL( CONVERT ( CHAR(10), MDMO.mofecinip, 103), '' ),
            'tasapact' = ISNULL( CASE motipoper WHEN 'RV' THEN MDMO.motaspact else MDMO.motasant end,  0.0),
            'basepact' = ISNULL( MDMO.mobaspact, 0),
            'monpacto' = ISNULL( Mon_B.mnnemo, ''),
            'valinip' = CASE WHEN Mon_B.mnmx = 'C' AND MDMO.momonpact <> 13 Then ISNULL(Round(MDMO.movalinip/MDMO.momtoPFE,2),0) ELSE ISNULL( MDMO.movalinip, 0) END,
            'valorven' = ISNULL( MDMO.movalvenp, 0),                                                             
   			'forpagoven' = ISNULL( VIEW_FORMA_DE_PAGO.glosa, '') ,                                                              
   			'tipoper' = MDMO.motipoper, 
   			'numoper' = ISNULL( MDMO.monumoper,0),
   			'entidad'  = VIEW_ENTIDAD.rcnombre,
   			'reajustes' = ISNULL( MDMO.moreapac,0.0),
   			'inserie'       = ISNULL(VIEW_INSTRUMENTO.inserie,'') ,
   			'sw'  = '0',
   			'titulo' = @titulo,
   			'FormaPagoIni'  = f2.Glosa,
  			'mnmx' = Mon_B.mnmx,
			'Tipo_InV'	= @Glosa_Cartera	,
			'libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND tbcodigo1 = id_libro),'') ,
			'Glosa_libro'	= @Glosa_Libro
  		INTO #TEMP
  		FROM --  REQ. 7619 
            MDMO  
				LEFT JOIN
				(	select	Id = cf.tbcodigo1, Glosa = cf.tbglosa
					from	BacParamSuda..TIPO_CARTERA tc
							INNER JOIN
							(	SELECT	tbcodigo1, tbglosa
								FROM	bacparamsuda.dbo.tabla_general_detalle WITH(NOLOCK) 
								WHERE	tbcateg = 204
							)	cf		ON cf.tbcodigo1	= tc.rcrut
					WHERE	tc.rcsistema = 'BTR'
					AND		tc.rccodpro='CP'
				)	cfrf	ON cfrf.Id	= MDMO.motipcart
				RIGHT OUTER JOIN VIEW_EMISOR ON VIEW_EMISOR.emrut = MDMO.morutemi 
                RIGHT OUTER JOIN VIEW_FORMA_DE_PAGO ON VIEW_FORMA_DE_PAGO.codigo = MDMO.moforpagv ,
   			VIEW_CLIENTE,
   			VIEW_ENTIDAD, 
--  REQ. 7619
--   			VIEW_EMISOR       , 
   			VIEW_INSTRUMENTO  ,
--  REQ. 7619
--   			VIEW_FORMA_DE_PAGO  ,
--   			VIEW_TABLA_GENERAL_DETALLE,
   			VIEW_MONEDA  Mon_A,
   			VIEW_MONEDA  Mon_B,
   			VIEW_FORMA_DE_PAGO f2

         	WHERE  (MDMO.motipoper = 'RV'  or MDMO.motipoper = 'RVA')
   		AND  	MDMO.mostatreg <> 'A'
   		AND    	VIEW_ENTIDAD.rcrut    = MDMO.morutcart
   		AND 	(VIEW_CLIENTE.clrut    = MDMO.morutcli 
   		AND    	VIEW_CLIENTE.clcodigo  = MDMO.mocodcli)
--  REQ. 7619
--   		AND     VIEW_EMISOR.emrut=*MDMO.morutemi  
   		AND     VIEW_INSTRUMENTO.incodigo = MDMO.mocodigo  
   		AND     Mon_A.mncodmon  = MDMO.momonemi
   		AND 	Mon_B.mncodmon  = MDMO.momonpact
--  REQ. 7619
--   		AND     VIEW_FORMA_DE_PAGO.codigo=*MDMO.moforpagv
   		AND     (MDMO.morutcart >= @ncartini
   		AND     MDMO.morutcart <= @ncartfin)
   		AND 	moforpagi = f2.codigo
	        AND    (motipcart   =  @Cartera_INV or @Cartera_INV = 0) 
		AND	(id_libro   =  @id_libro    OR @id_libro	= '')

          	SELECT 	'valinip'  = SUM(valinip),
   			'interes'  = SUM(interes),
    			'reajustes'= SUM(reajustes),
   			'valorven' = SUM(valorven),
                        'tasa'     = SUM(valinip*tasapact) / SUM(valinip),
   			'monedapac'= monpacto,
   			'mnmx'      = Max(mnmx)
            	INTO #TOTAL  
            	FROM #TEMP  
           	GROUP BY monpacto

          	INSERT INTO #TEMP
          	SELECT 	'',
   			'',
   			'',
   			'',
   			'',
   			'',
   			'',
   			0,
   			0,
   			0,
   			0,
   			interes,
   			'',
   			tasa,
   			0,
   			monedapac,
   			valinip,
   			valorven,
   			'',
   			'',
   			0,
   			'',
   			reajustes,
         		'TOTAL',
   			'sw'='1',
   			'RESUMEN ' + @titulo,
   			'',
   			mnmx,
			@Glosa_Cartera	,
			''		,
			@Glosa_Libro
            	FROM #TOTAL
-- Datos para Cristal
  		SELECT  nomcli,
                	noment,
   			tipcart,
                	numdocu,
                 	instrumento,
               		emisor,
      			moneda,
   			nominal,
                 	tirventa,
                	pvp,
          		tasest,
   			interes,
                	fecinip,
                	tasapact,
                	basepact,
          		monpacto,
                	valinip,
                 	valorven,
   			forpagoven,
   			tipoper,
   			numoper,
   			entidad,
   			reajustes,
   			inserie ,
   			FormaPagoIni,
   			'acfecproc'   = @acfecproc   ,
             		'acfecprox'   = @acfecprox   ,
          		'uf_hoy'      = @uf_hoy      ,
   			'uf_man'      = @uf_man      ,
          		'ivp_hoy'     = @ivp_hoy     ,
   			'ivp_man'     = @ivp_man     ,
      			'do_hoy'      = @do_hoy      ,
   			'do_man'      = @do_man      ,
   			'da_hoy'      = @da_hoy      ,
   			'da_man'      = @da_man      ,
   			'acnomprop'   = @acnomprop   ,
   			'rut_empresa' = @rut_empresa ,
   			'hora'        = @hora,
   			sw,
   			titulo,
   			mnmx,
			Tipo_InV	,
			Libro		,
			Glosa_Libro	
            	FROM #TEMP
  		ORDER BY inserie,monpacto
 	END
 	ELSE
  		SELECT  'nomcli'='                                          ',
                 	'noment'='  ',
   			'tipcart'='  ',
      	'numdocu'='        ',
                 	'instrumento'='            ',
               		'emisor'='            ',
      			'moneda'='       ',
   			'nominal'=0.0,
                 	'tirventa'=0.0,
                	'pvp'=0.0,
          		'tasest'=0,
   			'interes'=0.0,
                	'fecinip'='          ',
                	'tasapact'=0.0,
   	'basepact'=0,
          		'monpacto'='        ',
                	'valinip'=0.0,
                 	'valorven'=0.0,
   			'forpagoven'='  ',
   			'tipoper'='  ',
   			'numoper'=0,
   			'entidad'='  ',
  	 		'reajustes'=0.0,
   			'inserie'='  ' ,
   			'FormaPagoIni' ='', 
   			'acfecproc'   = @acfecproc   ,
             		'acfecprox'   = @acfecprox   ,
          		'uf_hoy'      = @uf_hoy      ,
   			'uf_man'      = @uf_man      ,
          		'ivp_hoy'     = @ivp_hoy     ,
   			'ivp_man'     = @ivp_man     ,
      			'do_hoy'      = @do_hoy      ,
   			'do_man'      = @do_man      ,
   			'da_hoy'      = @da_hoy      ,
   			'da_man'      = @da_man      ,
   			'acnomprop'   = @acnomprop   ,
   			'rut_empresa' = @rut_empresa ,
   			'hora'        = @hora,
   			sw       = '0',
   			'titulo'      = @Titulo,
   			'mnmx'	      = '',
			'Tipo_InV'	= @Glosa_Cartera	,
			'Libro'		= ''			,
			'Glosa_libro'	= @Glosa_Libro		

  SET NOCOUNT OFF
END
GO
