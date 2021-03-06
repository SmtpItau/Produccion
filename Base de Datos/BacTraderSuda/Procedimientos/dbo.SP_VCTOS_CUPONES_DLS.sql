USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VCTOS_CUPONES_DLS]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_VCTOS_CUPONES_DLS]
		(
		@Fecha	 CHAR(10)    
		)
AS BEGIN
SET NOCOUNT ON
        DECLARE @Titulo2    VARCHAR(100)
         ,      @Fecpro_x   DATETIME
         ,      @Fecha_x    DATETIME
	 ,	@Fecpro	    DATETIME

	 SELECT @Fecpro         = CONVERT(CHAR(10),acfecproc,112) from mdac
         SELECT @Fecpro_x       = CONVERT(DATETIME,@Fecpro, 112),
		@fecha_x	= CONVERT(DATETIME,@Fecha, 112)


        SELECT @Titulo2 = CASE WHEN  @Fecpro  =  @Fecha  THEN 'AL ' + CONVERT(CHAR(10),@Fecpro_x,103)
                               ELSE 'DESDE EL  ' + CONVERT(CHAR(10),@Fecpro_x,103) + ' HASTA EL ' + CONVERT(CHAR(10),@fecha_x,103)
                          END

        
	DECLARE	@Fecha_proceso	CHAR	(10)	,
		@Fecha_proxima	CHAR	(10)	,
		@uf_hoy		FLOAT		,
		@uf_man		FLOAT		,
		@ivp_hoy	FLOAT		,
		@ivp_man	FLOAT		,
		@do_hoy		FLOAT		,
		@do_man		FLOAT		,
		@da_hoy		FLOAT		,
		@da_man		FLOAT		,
		@Nombre_entidad	CHAR	(40)	,
		@rut_empresa	CHAR	(12)	,
		@nRutemp	NUMERIC	(09,0)	,
		@hora		CHAR	(08)	,
		@paso		CHAR	(01)    ,
                @fecha_busqueda DATETIME

	SELECT @fecha_busqueda = CONVERT(DATETIME,@Fecpro,112)


	EXECUTE SP_BASE_DEL_INFORME
		@Fecha_proceso OUTPUT   ,
		@Fecha_proxima OUTPUT   ,
		@uf_hoy  OUTPUT         ,
		@uf_man  OUTPUT         ,
		@ivp_hoy OUTPUT         ,
		@ivp_man OUTPUT         ,
		@do_hoy  OUTPUT         ,
		@do_man  OUTPUT         ,
		@da_hoy  OUTPUT         ,
		@da_man  OUTPUT         ,
		@Nombre_entidad OUTPUT  ,      
		@rut_empresa OUTPUT     ,
		@hora  OUTPUT

	SELECT	@paso	= 'N'

         SELECT         'numdocu'       = REPLICATE('0', 7 - LEN(RTRIM(LTRIM(STR(rsnumdocu))))) + RTRIM(LTRIM(STR(rsnumdocu))) + '-' +
                                          REPLICATE('0', 3 - LEN(RTRIM(LTRIM(STR(rscorrela))))) + RTRIM(LTRIM(STR(rscorrela)))
                ,       'serie'         = ISNULL(rsmascara,'')
                ,       'instrumento'   = ISNULL(rsinstser,'')
                ,       'emisor'        = ISNULL((SELECT emgeneric FROM VIEW_EMISOR WHERE emrut=rsrutemis ),'N/A')
                ,       'UM'            = (SELECT mnnemo FROM VIEW_MONEDA  WHERE mncodmon = rsmonemi)
                ,       'Monemi'        = rsmonemi
                ,       'valornominal'  = rsnominal
                ,       'flujo'         = rsvalvenc
                ,       'Valor_Moneda'   = CASE WHEN vmvalor = 0 
                                               THEN (CASE WHEN rsmonemi = 998 THEN @uf_hoy
                                                          WHEN rsmonemi = 13  THEN @do_hoy 
                                                          WHEN rsmonemi = 994 THEN @do_hoy
                                                          WHEN rsmonemi = 995 THEN @da_hoy
                                                          WHEN rsmonemi = 997 THEN @ivp_hoy
                                                          ELSE 1
                                                     END  )
                                               ELSE vmvalor
                                          END 
                ,       'fechamoneda'   = @Fecha_x
                ,       'valorcupon'    = CONVERT(NUMERIC(19,4),0)
                ,       'tipo'          = 'PROPIA'
                ,       'cartera'       = CASE codigo_carterasuper WHEN 'T' THEN 'TRANSABLE'
                                                                   ELSE 'PERMANENTE'
                                          END 
                ,       'fechacupon'    = CONVERT(CHAR(10),rsfecpcup,103)
                ,       'fechacorte'    = CONVERT(CHAR(10),rsfecucup,103)
		,       'rsvpcomp'      = ISNULL(rsvpcomp,0.0)                               
		,       'rsvpproceso'   = ISNULL(rsvppresen,0.0)  
		,       'rstir'         = ISNULL(rstir,0.0)  
		,       'rsvppresen'    = ISNULL(rsvalcomp,0.0)
		,       'rsfecemis'	= CONVERT(CHAR(10),rsfecemis,103)
		,       'rsfecvcto'	= CONVERT(CHAR(10),rsfecvcto,103)
		,	'tasa_emision'  = rstasemi 
		,	'Tipo_Operacion'= 'CP'
		,	'Fecha_hasta'   = CONVERT(CHAR(10),@fecha_x,103)
		,	'rscodigo'	= rscodigo
		,       'indice'        = IDENTITY (INT )
		
                INTO	#TEMPORAL1
                FROM	--  REQ. 7619
                          MDRS LEFT OUTER JOIN VIEW_VALOR_MONEDA ON rsfecpcup = vmfecha
                                            AND   rsmonemi  = vmcodigo 
--                      , VIEW_VALOR_MONEDA      
               WHERE    CONVERT(CHAR(10),rsfecha,112) = @Fecpro
--                  AND   rsfecpcup <= @fecha_x
--  REQ. 7619
--                  AND   rsfecpcup *= vmfecha
--                  AND   rsmonemi  *= vmcodigo
                  AND   (rscartera ='111' OR rscartera ='114')
                  AND   rstipoper = 'DEV'
                  AND   rsfecvcto <= @fecha_x

               IF (SELECT COUNT(1) FROM #TEMPORAL1 ) = 0       
                  GOTO SIN_INFORMACION

  	        SELECT  'numdocu'       = numdocu
                ,       'serie'         = serie
                ,       'instrumento'   = instrumento
                ,       'emisor'        = emisor
                ,       'UM'            = um
                ,       'valornominal'  = valornominal
                ,       'flujo'         = flujo               
                ,       'Valor_Moneda'   = CASE WHEN ( SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE fechamoneda = vmfecha AND monemi = vmcodigo ) = 0 
                                               THEN ( CASE WHEN monemi = 998 THEN @uf_hoy
                                                           WHEN monemi = 13  THEN @do_hoy 
                                                           WHEN monemi = 994 THEN @do_hoy
                                                           WHEN monemi = 995 THEN @da_hoy
                                                           WHEN monemi = 997 THEN @ivp_hoy
                                                           ELSE 1
                                                      END  )
                                               ELSE ( SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE fechamoneda = vmfecha AND monemi = vmcodigo )
                                          END 
                ,       'fechamoneda'   = CONVERT(CHAR(10),fechamoneda,103)
                ,       'valorcupon'    = (CASE WHEN ( SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE fechamoneda = vmfecha AND monemi = vmcodigo ) = 0 
                                                THEN ( CASE WHEN monemi = 998 THEN @uf_hoy
                                                            WHEN monemi = 13  THEN @do_hoy 
                                                            WHEN monemi = 994 THEN @do_hoy
                                                            WHEN monemi = 995 THEN @da_hoy
                                                            WHEN monemi = 997 THEN @ivp_hoy
                                                            ELSE 1
                                                       END  )
                                                ELSE ( SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE fechamoneda = vmfecha AND monemi = vmcodigo )
                                           END)  * flujo 
		,       'tipo'          = tipo
                ,       'cartera'       = cartera
                ,       'fechacupon'    = fechacupon
                ,       'fechacorte'    = fechacorte
		,       'rsvpcomp'      = rsvpcomp
		,       'rsvpproceso'   = rsvpproceso  
		,       'rstir'         = rstir  
		,       'rsvppresen'    = rsvppresen
		,       'rsfecemis'	= rsfecemis
		,       'rsfecvcto'	= rsfecvcto
		,	'tasa_emision'  = tasa_emision
		,	'Tipo_Operacion'= Tipo_Operacion
		,	'Fecha_hasta'   = Fecha_hasta 
		,	'rscodigo'	= rscodigo
                ,	'fecproc'	= @Fecha_proceso
		,	'fecprox'	= @Fecha_proxima
		,	'uf_hoy'	= @uf_hoy
		,	'uf_man'	= @uf_man
		,	'ivp_hoy'	= @ivp_hoy
		,	'ivp_man'	= @ivp_man
		,	'do_hoy'	= @do_hoy
		,	'do_man'	= @do_man
		,	'da_hoy'	= @da_hoy
		,	'da_man'	= @da_man
		,	'Nombre_entidad'= @Nombre_entidad
		,	'rut_empresa'   = @rut_empresa
		,	'hora'		= @hora
                ,       'titulo'        = 'VENCIMIENTO DE CARTERA PROPIA'
                ,       'titulo2'       = @Titulo2
		INTO #PASO
                FROM #TEMPORAL1
                
   		DELETE  #PASO 
		WHERE   rscodigo = 20
		AND     (CHARINDEX('*',Instrumento) > 0 OR CHARINDEX('&',Instrumento) > 0)


                SELECT * FROM #PASO  ORDER BY instrumento
		SELECT	@paso	= 'S'
   

   IF @paso	= 'N' BEGIN

   SIN_INFORMACION:

       	SELECT	'numdocu'       = ''
        ,       'serie'         = ''
        ,       'instrumento'   = ''
        ,       'emisor'        = ''
        ,       'UM'            = ''
        ,       'valornominal'  = ''
        ,       'flujo'         = ''
        ,       'Valor_Moneda'  = ''
        ,       'fechamoneda'   = ''
        ,       'valorcupon'    = ''
        ,       'tipo'          = ''
        ,       'cartera'       = ''
        ,       'fechacupon'    = ''
        ,       'fechacorte'    = ''
	,       'rsvpcomp'      = ''
	,       'rsvpproceso'   = ''
	,       'rstir'         = ''
	,       'rsvppresen'    = ''
	,       'rsfecemis'	= ''
	,       'rsfecvcto'	= ''
	,	'tasa_emision'  = ''
	,	'Tipo_Operacion'= ''
	,	'Fecha_hasta'	= ''
	,	'rscodigo'	= ''
        ,	'fecproc'	= @Fecha_proceso
	,	'fecprox'	= @Fecha_proxima
	,	'uf_hoy'	= @uf_hoy
	,	'uf_man'	= @uf_man
	,	'ivp_hoy'	= @ivp_hoy
	,	'ivp_man'	= @ivp_man
	,	'do_hoy'	= @do_hoy
	,	'do_man'	= @do_man
	,	'da_hoy'	= @da_hoy
	,	'da_man'	= @da_man
	,	'Nombre_entidad'= @Nombre_entidad
	,	'rut_empresa'   = @rut_empresa
	,	'hora'		= @hora
        ,       'titulo'        = 'VENCIMIENTO DE CARTERA PROPIA'
        ,       'titulo2'       = @Titulo2

   END
END

GO
