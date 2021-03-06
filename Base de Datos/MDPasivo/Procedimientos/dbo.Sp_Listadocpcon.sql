USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Listadocpcon]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Listadocpcon]
      (         @tipo_cartera	        CHAR	(03)
            ,   @tipo_opera	        CHAR	(05)
            ,   @entidad	        NUMERIC	(09)
            ,   @titulo		        VARCHAR	(80)
            ,   @carterasuper	        CHAR	(01)
            ,   @cDolar		        CHAR	(01)
            ,   @xfecha1		CHAR    (10)
            ,   @xfecha2		CHAR    (10)
            ,   @iCodigo                NUMERIC  (5)

      )
AS
BEGIN

    SET DATEFORMAT dmy

        DECLARE  @fecha1        DATETIME
        DECLARE  @fecha2        DATETIME

        SELECT   @fecha1   =   CONVERT(DATETIME,@xfecha1)
         ,       @fecha2   =   CONVERT(DATETIME,@xfecha2)


	DECLARE	@Fecha_proceso	CHAR	(10)	,
		@Fecha_proxima	CHAR	(10)	,
		@uf_hoy		NUMERIC (21,04) ,
		@uf_man		NUMERIC (21,04) ,
		@ivp_hoy	NUMERIC (21,04) ,
		@ivp_man	NUMERIC (21,04) ,
		@do_hoy		NUMERIC (21,04) ,
		@do_man		NUMERIC (21,04) ,
		@da_hoy		NUMERIC (21,04) ,
		@da_man		NUMERIC (21,04) ,
		@Nombre_entidad	CHAR	(40)	,
		@rut_empresa	CHAR	(12)	,
		@nRutemp	NUMERIC	(09,0)	,
		@hora		CHAR	(08)	,
		@paso		CHAR	(01)    ,
                @fecha_busqueda DATETIME

	SELECT	@paso	= 'N'
        SELECT  @fecha_busqueda = @fecha1
   
        EXECUTE	Sp_Base_Del_Informe
		@Fecha_proceso	OUTPUT
	,	@Fecha_proxima	OUTPUT
	,	@uf_hoy		OUTPUT
	,	@uf_man		OUTPUT
	,	@ivp_hoy	OUTPUT
	,	@ivp_man	OUTPUT
	,	@do_hoy		OUTPUT
	,	@do_man		OUTPUT
	,	@da_hoy		OUTPUT
	,	@da_man		OUTPUT
	,	@Nombre_entidad	OUTPUT
	,	@rut_empresa	OUTPUT
	,	@hora		OUTPUT
        ,       @fecha_busqueda


        SELECT	@nRutemp	= Rut_entidad FROM VIEW_DATOS_GENERALES


	SET NOCOUNT ON
 
--////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////RETORNO SI EXISTE INFORMACION EN LA RESULTADO_DEVENGO/////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////

   IF @fecha1 <> @fecha2 BEGIN
      SET @titulo = @titulo + ' DESDE ' + CONVERT(CHAR(10),@fecha1,103) + ' AL ' + CONVERT(CHAR(10),@fecha2,103)
   END ELSE BEGIN
      SET @titulo = @titulo + ' AL ' + CONVERT(CHAR(10),@fecha1,103) 
   END




	IF EXISTS(SELECT 1 FROM RESULTADO_DEVENGO 
                           WHERE  rsfecha                       = @fecha1                 
                           AND    rsnominal                     > 0
                           AND    ( (rscartera = '111' AND rstipopero = 'CP' ) OR (rscartera = '114' AND rstipopero IN('RP','FLP' )) )
                           AND    rstipoper                     = 'DEV'
                           AND    codigo_carterasuper           = @carterasuper
                           AND    CHARINDEX(LTRIM(RTRIM(STR(rsmonemi,3))),CASE WHEN @cDolar = 'N' THEN '997-998-999-503' ELSE '988-994-995- 13' END)  > 0            
                           AND    rsrutemis <>  (CASE WHEN rscodigo = 20 THEN @nRutemp ELSE 0 END )
                           AND    (rscodigo = @iCodigo or @icodigo = 0) )

            BEGIN  




                SELECT  'numdoc'           = CONVERT(CHAR(12),REPLICATE('0', 07 - LEN(LTRIM(STR(rsnumdocu)))) + LTRIM(STR(rsnumdocu)) + '-' +
                                             REPLICATE('0', 03 - LEN(LTRIM(STR(rscorrela)))) + LTRIM(STR(rscorrela)))
                ,       'rscorrela'	   = ISNULL(rscorrela,0)
		,	'rsinstser'	   = ISNULL(rsinstser,' ')

		,	'emisor'	   = ISNULL((SELECT emgeneric FROM VIEW_EMISOR WHERE rsrutemis=emrut),'')

		,	'fechacompra'	   = ISNULL(CONVERT(CHAR(10),rsfeccomp,103),' ')
		,	'fechavcto'	   = ISNULL(CONVERT(CHAR(10),rsfecvcto,103),' ')
		,	'dt'		   = ISNULL(DATEDIFF(dd,rsfeccomp,rsfecvcto),0)
		,	'dd'		   = ISNULL(DATEDIFF(dd,rsfeccomp,@fecha1),0)
                ,	'rsvalcomu' 	   = ISNULL(rspvpcomp,0)
		,	'um'		   = (SELECT ISNULL(mnnemo,' ') FROM VIEW_MONEDA WHERE mncodmon=rsmonemi)
		,	'rsnominal'	   = ISNULL(rsnominal,0)
		,	'cupon' 	   = ISNULL(rsvalvenc,0)
		,	'rscupint' 	   = ISNULL(rscupint,0)
		,	'rstir'    	   = ISNULL(rstir,0)
                ,       'rstasemi'         = CASE WHEN rsseriado = 'S' THEN
                                             ISNULL((SELECT DISTINCT setasemi FROM VIEW_SERIE WHERE rsmascara = semascara),0)
                                             ELSE
                                                ISNULL((SELECT DISTINCT nstasemi FROM NOSERIE WHERE rsinstser = nsserie),0)
                                             END          

                ,       'rsfecpcup'        = ISNULL(CONVERT(CHAR(10),rsfecpcup,103),'')
		,	'rsvpcomp' 	   = ISNULL(rsvalcomp,0)
		,	'rsvppresen'	   = ISNULL((rsvalcomp+rsinteres_acum+rsreajuste_acum),0.0)
		,	'rsinteres'	   = ISNULL(rsinteres,0.0)
		,	'rsreajuste'	   = ISNULL(rsreajuste,0)
		,	'rsintermes'	   = ISNULL(rsintermes,0)
		,	'rsreajumes'	   = ISNULL(rsreajumes,0)
		,	'rsvppresenx'	   = ISNULL(rsvppresenx,0)
		,	'rsinteres_acum'   = ISNULL(rsinteres_acum,0)
		,	'rsreajuste_acum'  = ISNULL(rsreajuste_acum,0)
		,	'rscodigo'	   = ISNULL((rstir*rsvalcomp),0)
		,	'instrumento'	   = (SELECT ISNULL(inglosa,'*') FROM VIEW_INSTRUMENTO WHERE incodigo=rscodigo)
		,	'inserie'	   = ISNULL((SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo=rscodigo), ' ')
		,	'titulo'	   = @titulo
		,	'sw'		   = CASE WHEN rsfecvcto <= @fecha2 THEN '*'
                                                  ELSE ''
                                             END
                ,	'fecproc'	   = @Fecha_proceso
		,	'fecprox'	   = @Fecha_proxima
		,	'uf_hoy'	   = @uf_hoy
		,	'uf_man'	   = @uf_man
		,	'ivp_hoy'	   = @ivp_hoy
		,	'ivp_man'	   = @ivp_man
		,	'do_hoy'	   = @do_hoy
		,	'do_man'	   = @do_man
		,	'da_hoy'	   = @da_hoy
		,	'da_man'	   = @da_man
		,	'Nombre_entidad'        = (SELECT ISNULL(@Nombre_entidad, 'NO DEFINIDO') FROM VIEW_DATOS_GENERALES )
		,	'rut_empresa'      = @rut_empresa
		,	'nombreentidad'    = (SELECT ISNULL(Nombre_entidad, 'NO DEFINIDO') from VIEW_DATOS_GENERALES )
		,	'hora'		   = @hora
		,	'tirXnominal'	   = rstir * rsnominal
		,	'Fecha1x'	   = CONVERT(CHAR(10),@fecha1,103)
		,	'Fecha1'	   = CONVERT(CHAR(10),@fecha1,103)
		,	'Fecha2'	   = CONVERT(CHAR(10),@fecha2,103)
                ,       'datos'            = CONVERT(CHAR(30),'TOTAL')
                ,       'Serie_Orden'      = CASE WHEN rsseriado = 'S' THEN SUBSTRING(rsinstser,1,5)
                                                  ELSE CONVERT(CHAR(10),rsfecvcto,112)
                                                  END

		,	'fechacomprao'	   = ISNULL(CONVERT(CHAR(10),rsfeccomp,112),' ')
		,	'plazo'		   = ISNULL(CONVERT(NUMERIC(05),rsfecvcto - @fecha1),0)
                ,       'Tipo_moneda'      = mnextranj

		FROM	RESULTADO_DEVENGO,VIEW_MONEDA
                WHERE  rsfecha                       = @fecha1                 
                AND    rsnominal                     > 0
                AND    ( (rscartera = '111' AND rstipopero = 'CP' ) OR (rscartera = '114' AND rstipopero IN('RP','FLP' )) )
                AND    rstipoper                     = 'DEV'
                AND    codigo_carterasuper           = @carterasuper
                AND    CHARINDEX(STR(rsmonemi,3), CASE WHEN @cDolar = 'N' THEN '997-998-999-503' 
                                                                  ELSE '988-994-995- 13' END) > 0
		AND   rsfeccomp <= @fecha1
                AND   rsrutemis <>  (CASE WHEN rscodigo = 20 THEN @nRutemp ELSE 0 END )
                AND   (rscodigo = @iCodigo or @icodigo = 0)
                AND   rsmonemi = mncodmon
                ORDER BY Serie_Orden              
--                ORDER BY rsfecvcto,rsinstser

--		ORDER BY rsinstser,CONVERT(CHAR(12),REPLICATE('0', 07 - LEN(LTRIM(STR(rsnumdocu)))) + LTRIM(STR(rsnumdocu)) + '-' +
--                                                    REPLICATE('0', 03 - LEN(LTRIM(STR(rscorrela)))) + LTRIM(STR(rscorrela)))




		SELECT	@paso	= 'S'

	   END ELSE 
--////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////RETORNO SI EXISTE INFORMACION EN LA CARTERA_DISPONIBLE Y CARTERA_PROPIA///////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////



	   IF @fecha1 = (SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES) BEGIN
           BEGIN 


		IF EXISTS(SELECT 1 FROM CARTERA_DISPONIBLE
                                   ,    CARTERA_PROPIA ,VIEW_EMISOR
                                  WHERE CARTERA_DISPONIBLE.codigo_carterasuper   =   @carterasuper 
                                  AND    cpnominal                 >   0
                                  AND	(cpnumdocu                 =   dinumdocu
                                  AND    cpcorrela                 =   dicorrela
                                  AND    ditipoper           =   'CP') 
				  AND    CHARINDEX(STR(dimoneda,3), CASE WHEN @cDolar = 'N' THEN '997-998-999-503' 
			                ELSE '988-994-995- 13' END) > 0
				  AND cpfeccomp <= @xfecha1
                                  AND digenemi = emgeneric  
                                  AND emrut <> (CASE WHEN cpcodigo = 20 THEN @nRutemp ELSE 0 END)
                                  AND (cpcodigo = @iCodigo or @icodigo = 0)  
                        )
                

               BEGIN
                SELECT          'numdoc'            = CONVERT(CHAR(12),REPLICATE('0', 07 - LEN(LTRIM(STR(cpnumdocu)))) + LTRIM(STR(cpnumdocu)) + '-' +
                                                      REPLICATE('0', 03 - LEN(LTRIM(STR(cpcorrela)))) + LTRIM(STR(cpcorrela)))
         	        ,	'rscorrela'	    = cpcorrela
			,	'rsinstser'	    = ISNULL(cpinstser,'')
			,	'emisor'	    = ISNULL(digenemi,'')
			,	'fechacompra'	    = ISNULL(CONVERT(CHAR(10),cpfeccomp,103),' ')
			,	'fechavcto'	    = ISNULL(CONVERT(CHAR(10),cpfecven,103),' ')
			,	'dt'		    = ISNULL(DATEDIFF(dd,cpfecven,cpfeccomp),0)
			,	'dd'		    = ISNULL(DATEDIFF(dd,cpfecven,cpfeccomp),0)
			,	'rsvalcomu' 	    = cppvpcomp  
			,	'um'		    = (SELECT ISNULL(mnnemo,'') FROM VIEW_MONEDA WHERE dinemmon = mnnemo)
			,	'rsnominal'	    = cpnominal
			,	'cupon' 	    = 0
			,	'rscupint'	    = 0
			,	'rstir'  	    = cptircomp
                        ,       'rstasemi'          = CASE WHEN cpseriado = 'S' THEN
                                                         ISNULL((SELECT DISTINCT setasemi FROM VIEW_SERIE WHERE cpmascara = semascara),'N/A')
                                                      ELSE
                                                         ISNULL((SELECT DISTINCT nstasemi FROM NOSERIE WHERE cpinstser = nsserie),'N/A')
                                                      END
                        ,       'rsfecpcup'         = CONVERT(CHAR(10),'')
			,	'rsvpcomp' 	    = cpvalcomp   
			,	'rsvppresen' 	    = cpvalcomp+cpinteresc+cpreajustc
			,	'rsinteres'	    = 0.0
			,	'rsreajuste'	    = 0
			,	'rsintermes'	    = cpintermes
			,	'rsreajumes'	    = cpreajumes
			,	'rsvppresenx'	    = cpvptirc
			,	'rsinteres_acum'    = cpinteresc
			,	'rsreajuste_acum'   = cpreajustc
			,	'rscodigo'	    = cptircomp*cpvalcomp
			,	'instrumento'	    = (SELECT ISNULL(inglosa,'*') FROM VIEW_INSTRUMENTO WHERE incodigo=cpcodigo)
			,	'inserie'	    = ISNULL((SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo=cpcodigo), ' ')
			,	'titulo'	    = @titulo
			,	'sw'		    = CASE WHEN cpfecven <= @fecha2 THEN '*'
                                                           ELSE ''
                                                      END
			,	'fecproc'	    = @Fecha_proceso
			,	'fecprox'	    = @Fecha_proxima
			,	'uf_hoy'	    = @uf_hoy
			,	'uf_man'	    = @uf_man
			,	'ivp_hoy'	    = @ivp_hoy
			,	'ivp_man'	    = @ivp_man
			,	'do_hoy'	    = @do_hoy
			,	'do_man'	    = @do_man
			,	'da_hoy'	    = @da_hoy
			,	'da_man'	    = @da_man
			,	'Nombre_entidad'	  = (SELECT ISNULL(@Nombre_entidad, 'NO DEFINIDO') FROM VIEW_DATOS_GENERALES )
			,	'rut_empresa'	    = @rut_empresa
			,	'nombreentidad'	    = (SELECT ISNULL(Nombre_entidad, 'NO DEFINIDO') FROM VIEW_DATOS_GENERALES )
			,	'hora'		    = @hora
			,	'tirXnominal'	    = cptircomp * cpnominal
          		,	'Fecha1x'	    = CONVERT(CHAR(10),@fecha1,103)
			,	'Fecha1'	    = CONVERT(CHAR(10),@fecha1,103)
			,	'Fecha2'	    = CONVERT(CHAR(10),@fecha2,103)
                        ,       'datos'             = CONVERT(CHAR(30),'TOTAL')
                        ,       'Serie_Orden'       = CASE WHEN cpseriado = 'S' THEN SUBSTRING(cpinstser,1,5)
                                                           ELSE CONVERT(CHAR(10),cpfecven,112)
                                                           END
			,	'fechacomprao'	    = ISNULL(CONVERT(CHAR(10),cpfeccomp,112),' ')
			,	'plazo'		    = ISNULL(CONVERT(NUMERIC(05),cpfecven - @fecha1),0)
                        ,       'Tipo_moneda'       = mnextranj

			FROM	CARTERA_DISPONIBLE, CARTERA_PROPIA,VIEW_EMISOR,VIEW_MONEDA
			WHERE	CARTERA_DISPONIBLE.codigo_carterasuper   =   @carterasuper 
                        AND     cpnominal                  >   0
                        AND    (cpnumdocu                  =   dinumdocu 
                        AND     cpcorrela                  =   dicorrela 
                        AND     ditipoper                  =   'CP') 
        	        AND    CHARINDEX(STR(dimoneda,3), CASE WHEN @cDolar = 'N' THEN '997-998-999-503' 
	                                                              ELSE '988-994-995- 13' END) > 0
   		        AND    cpfeccomp <= @xfecha1	
                        AND    emrut <> (CASE WHEN cpcodigo = 20 THEN @nRutemp ELSE 0 END)
                        AND    digenemi = emgeneric
                        AND   (cpcodigo = @iCodigo or @icodigo = 0)  
                        AND    mncodmon = dimoneda
--                        ORDER BY Serie_Orden
--         		ORDER BY cpinstser,CONVERT(CHAR(12),REPLICATE('0', 07 - LEN(LTRIM(STR(cpnumdocu)))) + LTRIM(STR(cpnumdocu)) + '-' +
--                                                            REPLICATE('0', 03 - LEN(LTRIM(STR(cpcorrela)))) + LTRIM(STR(cpcorrela)))

			union all

                	SELECT  'numdoc'            = CONVERT(CHAR(12),REPLICATE('0', 07 - LEN(LTRIM(STR(vinumdocu)))) + LTRIM(STR(vinumdocu)) + '-' +
                                                      REPLICATE('0', 03 - LEN(LTRIM(STR(vicorrela)))) + LTRIM(STR(vicorrela)))
         	        ,	'rscorrela'	    = vicorrela
			,	'rsinstser'	    = ISNULL(viinstser,'')
			,	'emisor'	    = ISNULL(emgeneric,'')
			,	'fechacompra'	    = ISNULL(CONVERT(CHAR(10),vifeccomp,103),' ')
			,	'fechavcto'	    = ISNULL(CONVERT(CHAR(10),vifecven,103),' ')
			,	'dt'		    = ISNULL(DATEDIFF(dd,vifecven,vifeccomp),0)
			,	'dd'		    = ISNULL(DATEDIFF(dd,vifecven,vifeccomp),0)
			,	'rsvalcomu' 	    = vipvpvent  
			,	'um'		    = (SELECT ISNULL(mnnemo,'') FROM VIEW_MONEDA WHERE vimonemi = mnnemo)
			,	'rsnominal'	    = vinominal
			,	'cupon' 	    = 0
			,	'rscupint'	    = 0
			,	'rstir'  	    = vitircomp
                        ,       'rstasemi'          = CASE WHEN viseriado = 'S' THEN
                                                         ISNULL((SELECT DISTINCT setasemi FROM VIEW_SERIE WHERE vimascara = semascara),'N/A')
                                                      ELSE
                                                         ISNULL((SELECT DISTINCT nstasemi FROM NOSERIE WHERE viinstser = nsserie),'N/A')
                                                      END
                        ,       'rsfecpcup'         = CONVERT(CHAR(10),'')
			,	'rsvpcomp' 	    = vivalcomp   
			,	'rsvppresen' 	    = vivalcomp+viinteresv+vireajustv
			,	'rsinteres'	    = 0.0
			,	'rsreajuste'	    = 0
			,	'rsintermes'	    = viintermesv
			,	'rsreajumes'	    = vireajumesv
			,	'rsvppresenx'	    = vivptirv
			,	'rsinteres_acum'    = viinteresv
			,	'rsreajuste_acum'   = vireajustv
			,	'rscodigo'	    = vitircomp*vivalcomp
			,	'instrumento'	    = (SELECT ISNULL(inglosa,'*') FROM VIEW_INSTRUMENTO WHERE incodigo=vicodigo)
			,	'inserie'	    = ISNULL((SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo=vicodigo), ' ')
			,	'titulo'	    = @titulo
			,	'sw'		    = CASE WHEN vifecven <= @fecha2 THEN '*'
                                                           ELSE ''
                                                      END
			,	'fecproc'	    = @Fecha_proceso
			,	'fecprox'	    = @Fecha_proxima
			,	'uf_hoy'	    = @uf_hoy
			,	'uf_man'	    = @uf_man
			,	'ivp_hoy'	    = @ivp_hoy
			,	'ivp_man'	    = @ivp_man
			,	'do_hoy'	    = @do_hoy
			,	'do_man'	    = @do_man
			,	'da_hoy'	    = @da_hoy
			,	'da_man'	    = @da_man
			,	'Nombre_entidad'	  = (SELECT ISNULL(@Nombre_entidad, 'NO DEFINIDO') FROM VIEW_DATOS_GENERALES )
			,	'rut_empresa'	    = @rut_empresa
			,	'nombreentidad'	    = (SELECT ISNULL(Nombre_entidad, 'NO DEFINIDO') FROM VIEW_DATOS_GENERALES )
			,	'hora'		    = @hora
			,	'tirXnominal'	    = vitircomp * vinominal
          		,	'Fecha1x'	    = CONVERT(CHAR(10),@fecha1,103)
			,	'Fecha1'	    = CONVERT(CHAR(10),@fecha1,103)
			,	'Fecha2'	    = CONVERT(CHAR(10),@fecha2,103)
                        ,       'datos'             = CONVERT(CHAR(30),'TOTAL')
                        ,       'Serie_Orden'       = CASE WHEN viseriado = 'S' THEN SUBSTRING(viinstser,1,5)
                                                           ELSE CONVERT(CHAR(10),vifecven,112)
                                                           END
			,	'fechacomprao'	    = ISNULL(CONVERT(CHAR(10),vifeccomp,112),' ')
			,	'plazo'		    = ISNULL(CONVERT(NUMERIC(05),vifecven - @fecha1),0)
                        ,       'Tipo_moneda'       = mnextranj

			FROM	CARTERA_VENTA_PACTO,VIEW_EMISOR,VIEW_MONEDA
			WHERE	codigo_carterasuper   =   @carterasuper 
                        AND     vinominal                  >   0
                        AND     vitipoper                  IN   ('CP')
        	        AND    CHARINDEX(STR(vimonemi,3), CASE WHEN @cDolar = 'N' THEN '997-998-999-503' 
	                                                              ELSE '988-994-995- 13' END) > 0
   		        AND    vifeccomp <= @xfecha1	
                        AND    emrut <> (CASE WHEN vicodigo = 20 THEN @nRutemp ELSE 0 END)
                        AND    virutemi = emgeneric
                        AND   (vicodigo = @iCodigo or @icodigo = 0)  
                        AND    mncodmon = vimonemi
                        ORDER BY Serie_Orden
	

			SELECT	@paso	= 'S'
                  END

            END
        END 

--////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////RETORNA SOLO LOS DATOS DE LA CABECERA Y PIE DE PAGINA/////////////////////////	
--////////////////////////////////////////////////////////////////////////////////////////////////////////	

   IF @paso='N' 

         	SELECT	'numdoc'		= CONVERT(CHAR(12),'')
		,	'rscorrela'		= 0
		,	'rsinstser'		= ''
		,	'emisor'		= ''
		,	'fechacompra'		= ''
		,	'fechavcto'		= ''
		,	'dt'			= 0.0
		,	'dd'			= 0.0
		,	'rsvalcomu'		= 0.0
		,	'um'			= ''
		,	'rsnominal'		= 0.0
		,	'cupon'			= 0.0
		,	'rscupint'		= 0.0
		,	'rstir'			= 0.0
                ,       'rstasemi'              = 0.0
                ,       'rsfecpcup'             = CONVERT(CHAR(10),'')
		,	'rsvpcomp'		= 0.0
		,	'rsvppresen'		= 0.0
		,	'rsinteres'		= 0.0
		,	'rsreajuste'		= 0.0
		,	'rsintermes'		= 0.0
		,	'rsreajumes'		= 0.0
		,	'rsvppresenx'		= 0.0
		,	'rsinteres_acum'	= 0.0
		,	'rsreajuste_acum'	= 0.0
		,	'rscodigo'		= 0.0
		,	'instrumento'		= ''
		,	'inserie'		= ''
		,	'titulo'		= @titulo
		,	'sw'			= ''
      	        ,       'fecproc'		= @Fecha_proceso
          	,	'fecprox'		= @Fecha_proxima
	       	,	'uf_hoy'		= @uf_hoy
		,	'uf_man'		= @uf_man
       		,	'ivp_hoy'		= @ivp_hoy
		,	'ivp_man'		= @ivp_man
   		,	'do_hoy'		= @do_hoy
		,	'do_man'		= @do_man
		,	'da_hoy'		= @da_hoy
		,	'da_man'		= @da_man
		,	'Nombre_entidad'	= (SELECT ISNULL(@Nombre_entidad, 'NO DEFINIDO') FROM VIEW_DATOS_GENERALES )
		,	'rut_empresa'		= @rut_empresa
		,	'nombreentidad'		= (SELECT ISNULL(Nombre_entidad, 'NO DEFINIDO') FROM VIEW_DATOS_GENERALES )
		,	'hora'			= @hora
		,	'tirXnominal'		= 0.0
                ,       'Fecha1x'               = CONVERT(CHAR(10),@fecha1,103)
		,	'Fecha1'	        = CONVERT(CHAR(10),@fecha1,103)
		,	'Fecha2'	        = CONVERT(CHAR(10),@fecha2,103)
                ,       'datos'                 = CONVERT(CHAR(30),'NO EXISTE INFORMACION')
                ,       'Serie_Orden'           =''
		,	'fechacomprao'		= ''
		,	'plazo'		        = 0.0
                ,       'Tipo_moneda'           = ' '

END




GO
