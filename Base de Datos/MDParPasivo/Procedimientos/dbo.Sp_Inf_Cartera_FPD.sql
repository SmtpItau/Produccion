USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Inf_Cartera_FPD]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Inf_Cartera_FPD]
	     (  
		@cDolar         CHAR(01),
             	@xcfecha	CHAR(10),
                @xcfecha1       CHAR(10)
             )  	
AS
BEGIN

        SET DATEFORMAT dmy
	SET NOCOUNT ON

        DECLARE @cfecha		DATETIME
           ,    @cfecha1        DATETIME
        SELECT  @cfecha       = CONVERT(DATETIME,@xcfecha,112)
           ,    @cfecha1      = CONVERT(DATETIME,@xcfecha1,112)
     
        DECLARE	@Fecha_proceso	CHAR (10)
	,	@Fecha_proxima	CHAR (10)
	,	@uf_hoy		FLOAT
	,	@uf_man		FLOAT
	,	@ivp_hoy	FLOAT
	,	@ivp_man	FLOAT
	,	@do_hoy		FLOAT
	,	@do_man		FLOAT
	,	@da_hoy		FLOAT
	,	@da_man		FLOAT
	,	@Nombre_entidad	CHAR(40)
	,	@rut_empresa	CHAR(12)
	,	@nRutemp	NUMERIC	(09,0)
	,	@hora		CHAR(08)
	,	@paso		CHAR(01)
        ,       @fecha_busqueda DATETIME

        SELECT  @fecha_busqueda = @cfecha

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


IF @cFecha = (SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES)

      IF EXISTS(SELECT 1 FROM RESULTADO_DEVENGO  WHERE  rsfecha = @cfecha 	AND 
                                           	rstipopero 	= 'FPD'		AND
                                            	rstipoper 	= 'DEV'   	AND 
                                            	rscartera 	= '121'   
                                          AND  ( CHARINDEX(STR(rsmonemi,3), CASE WHEN @cDolar = 'N' THEN '997-998-999' 
                                                                            ELSE '988-994-995- 13' END) > 0)

                                          AND (  ( @cDolar = 'S' and CHARINDEX( STR(rsmonemi,3), '994- 13-995-988' ) > 0 ) or 
                                              ( @cDolar = 'N' and CHARINDEX( STR(rsmonemi,3), '994- 13-995-988' ) = 0 ) ) )


      BEGIN
		SELECT	
                        'numdocu'          = CONVERT(CHAR(12),REPLICATE('0', 7 - LEN(LTRIM(STR(rsnumdocu)))) + LTRIM(STR(rsnumdocu)) + '-' +
                                                              REPLICATE('0', 3 - LEN(LTRIM(STR(rscorrela)))) + LTRIM(STR(rscorrela)))
                ,       'tipooperacion'    = ISNULL(rstipoper, '')
                ,       'serie'            = ISNULL(rsinstser,'')
                ,       'emisor'           = ISNULL((select emnombre from view_emisor where rsrutemis=emrut),'')
                ,       'nombrecliente'    = ISNULL((select clnombre from view_cliente where rsrutcli=clrut AND rscodcli = clcodigo),'NO EXISTE') 
                ,       'fechacompra'      = ISNULL(convert(char(10),rsfeccomp,103),'')
                ,       'fechavcto'        = ISNULL(convert(char(10),rsfecvtop,103),'')
                ,       'tasaemision'      = ISNULL(rstasemi,0)
                ,       'base'             = ISNULL(rsbasemi,0)
                ,       'moneda'           = ISNULL((SELECT mnnemo FROM VIEW_MONEDA WHERE rsmonpact=mncodmon),'')	
                ,       'nominal'          = ISNULL(rsnominal,0)
                ,       'cupon'            = ISNULL(rscupamo,0)
                ,       'tir'              = ISNULL(rstir,0)
                ,       '%vc'              = ISNULL(rsvpcomp,0)
                ,       'valorini'         = ISNULL(rsvalcomp,0)
                ,       'valorfinal'       = ISNULL(rsvalcomp,0)
                ,       'proceso'          = ISNULL(rsvppresen,0)
                ,       'interes'          = ISNULL(rsinteres,0)
                ,       'reajuste'         = ISNULL(rsreajuste,0)
                ,       'interes_acum'     = ISNULL(rsinteres_acum,0)
                ,       'reajuste_acum'    = ISNULL(rsreajuste_acum,0)


                ,       'procesoprox'      = ISNULL(rsvppresenx,0)
                ,       'valorxponde'      = ISNULL((rstir*rsvalcomp),0)
                ,       'fecproc'	   = @Fecha_proceso
		,	'fecprox'	   = @Fecha_proxima
		,	'uf_hoy'	   = @uf_hoy
		,	'uf_man'	   = @uf_man
		,	'ivp_hoy'	   = @ivp_hoy

		,	'ivp_man'	   = @ivp_man
		,	'do_hoy'	   = @do_hoy
		,	'do_man'	   = @do_man
		,	'da_hoy'	   = @da_hoy
		,	'da_man'	   = @da_man
                ,       'hora'             = @hora
                ,       'fecha1'           = CONVERT(CHAR(10),@cfecha,103)
                ,       'fecha2'           = CONVERT(CHAR(10),@cfecha1,103)
                ,       'fecha_emision'    = convert(char(10),getdate(),103)
                ,       'hora_emision'     = convert(char(10),getdate(),108)
                ,       'Forma_pago '      = ISNULL((SELECT perfil FROM VIEW_FORMA_DE_PAGO WHERE rsforpagi = codigo ),'')
                ,       'Forma_pagov'      = ISNULL((SELECT perfil FROM VIEW_FORMA_DE_PAGO WHERE rsforpagv = codigo ),'')
                ,       'mv'               = CASE WHEN rsfecvcto = (SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES) THEN '*'
                                                  ELSE ''
                                                  END
		,	'PLAZO'		   = datediff(dd,rsfeccomp,rsfecvtop)


      		FROM	RESULTADO_DEVENGO 
		WHERE	rsfecha	= @cfecha
                  	AND   rstipopero = 'FPD' 
                  	AND   rstipoper   = 'DEV'
                  	AND   rscartera   = '121'   
                 	AND(  ( @cDolar = 'S' and CHARINDEX( STR(rsmonemi,3), '994- 13-995-988' ) > 0 ) or 
                      ( @cDolar = 'N' and CHARINDEX( STR(rsmonemi,3), '994- 13-995-988' ) = 0 )  )

	END 
	ELSE
		IF EXISTS ( 
				SELECT 1 
				FROM	CARTERA_INTERBANCARIA
                                WHERE   Codigo_Subproducto = 'FPD' 
					and (  ( @cDolar = 'S' and CHARINDEX( STR(moneda_pacto,3), '994- 13-995-988' ) > 0 ) 
					or ( @cDolar = 'N' and CHARINDEX( STR(moneda_pacto,3), '994- 13-995-988' ) = 0 )  ))


		BEGIN

			SELECT	
			        'numdocu'          = CONVERT(CHAR(12),REPLICATE('0', 7 - LEN(LTRIM(STR(numero_documento)))) + LTRIM(STR(numero_documento)) + '-' +
                                                              REPLICATE('0', 3 - LEN(LTRIM(STR(correlativo_operacion)))) + LTRIM(STR(correlativo_operacion)))
	                ,       'tipooperacion'    = ISNULL(Serie, '')
        		,       'serie'            = ISNULL(mascara,'')
	                ,       'emisor'           = ISNULL((select emnombre from view_emisor where Rut_Cliente=emrut),'')
        	        ,       'nombrecliente'    = ISNULL((select clnombre from view_cliente where Rut_Cliente=clrut AND codigo_cliente = clcodigo),'NO EXISTE') 
                	,       'fechacompra'      = ISNULL(convert(char(10),Fecha_Inicio_Pacto,103),'')
	                ,       'fechavcto'        = ISNULL(convert(char(10),Fecha_Vencimiento_Pacto,103),'')
        	        ,       'tasaemision'      = ISNULL(tasa_pacto,0)
                	,       'base'             = ISNULL(base_pacto,0)
	                ,       'moneda'           = ISNULL((SELECT mnnemo FROM VIEW_MONEDA WHERE moneda_pacto=mncodmon),'')	
        	        ,       'nominal'          = ISNULL(nominal,0)
                	,       'cupon'            = ISNULL(nominal,0)
	                ,       'tir'              = ISNULL(tasa_pacto,0)
        	        ,       '%vc'              = 0
                	,       'valorini'         = ISNULL(valor_inicial,0)  
	                ,       'valorfinal'       = ISNULL(Capital_Compra,0) 
        	        ,       'proceso'          = ISNULL(Valor_Presente_Tir_Compra,0)
                	,       'interes'          = 0
	                ,       'reajuste'    	   = 0
        	        ,       'interes_acum'     = ISNULL(Interes_compra,0)
                	,       'reajuste_acum'    = ISNULL(Reajuste_compra,0)
	                ,       'procesoprox'      = ISNULL(Capital_Compra,0)
        	        ,       'valorxponde'      = ISNULL((tasa_pacto*valor_compra),0)
                	,       'fecproc'	   = @Fecha_proceso
			,	'fecprox'	   = @Fecha_proxima
			,	'uf_hoy'	   = @uf_hoy
			,	'uf_man'	   = @uf_man
			,	'ivp_hoy'	   = @ivp_hoy
			,	'ivp_man'	   = @ivp_man
			,	'do_hoy'	   = @do_hoy

			,	'do_man'	   = @do_man
			,	'da_hoy'	   = @da_hoy
			,	'da_man'	   = @da_man
	                ,       'hora'             = @hora
        	        ,       'fecha1'           = CONVERT(CHAR(10),@cfecha,103)
                	,       'fecha2'           = CONVERT(CHAR(10),@cfecha1,103)
	                ,       'fecha_emision'    = convert(char(10),getdate(),103)
        	        ,       'hora_emision'     = convert(char(10),getdate(),108)
                	,       'Forma_pago '      = ISNULL((SELECT perfil FROM VIEW_FORMA_DE_PAGO WHERE forma_pago_inicio = codigo ),'')               
	                ,       'Forma_pagov'      = ISNULL((SELECT perfil FROM VIEW_FORMA_DE_PAGO WHERE Forma_Pago_Vencimiento = codigo ),'')
        	        ,       'mv'               = CASE WHEN fecha_vencimiento_pacto = (SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES) THEN '*'
                	                                  ELSE ''
                        	                          END
			,	'PLAZO'		   = datediff(dd,Fecha_Inicio_Pacto,Fecha_Vencimiento_Pacto)

		 	FROM	CARTERA_INTERBANCARIA
        	        WHERE   Codigo_Subproducto = 'FPD' 
				AND (  ( @cDolar = 'S' and CHARINDEX( STR(moneda_pacto,3), '994- 13-995-988' ) > 0 ) or 
                	    	( @cDolar = 'N' and CHARINDEX( STR(moneda_pacto,3), '994- 13-995-988' ) = 0 )  )


		END   
		ELSE
	               SELECT
        	                'numdocu'          = ''
                	,       'tipooperacion'    = ''
	                ,       'serie'            = ''
        	        ,       'emisor'           = ''
                	,       'nombrecliente'    = '' 
	                ,       'fechacompra'      = ''
        	        ,       'fechavcto'        = ''
                	,       'tasaemision'      = ''
	                ,       'base'             = ''
        	        ,       'moneda'           = ''
                	,       'nominal'          = ''
	                ,       'cupon'            = ''
        	        ,       'tir'              = ''
                	,       '%vc'              = ''
	                ,       'valorini'         = ''
        	        ,       'valorfinal'       = ''
                	,       'proceso'          = ''
	                ,       'interes'          = ''
        	        ,       'reajuste'         = ''
                	,       'interes_acum'     = ''
	                ,       'reajuste_acum'    = ''
        	        ,       'procesoprox'      = ''
                	,       'valorxponde'      = ''
	                ,       'fecproc'	   = @Fecha_proceso
			,	'fecprox'	   = @Fecha_proxima
			,	'uf_hoy'	   = @uf_hoy
			,	'uf_man'	   = @uf_man
			,	'ivp_hoy'	   = @ivp_hoy
			,	'ivp_man'	   = @ivp_man
			,	'do_hoy'	   = @do_hoy
			,	'do_man'	   = @do_man
			,	'da_hoy'	   = @da_hoy
			,	'da_man'	   = @da_man
        	        ,       'hora'             = @hora
                	,       'fecha1'           = CONVERT(CHAR(10),@cfecha,103)
	                ,       'fecha2'           = CONVERT(CHAR(10),@cfecha1,103)
       			,       'fecha_emision'    = CONVERT(CHAR(10),GETDATE(),103)
	                ,       'hora_emision'     = CONVERT(CHAR(10),GETDATE(),108)
        	        ,       'Forma_pago '      = ''
                	,       'Forma_pagov'      = ''
	                ,       'mv'               = ''	
			,	'PLAZO'		   = 0

	ELSE 
		IF EXISTS(SELECT 1 FROM RESULTADO_DEVENGO  WHERE  rsfecha = @cfecha 
                            	AND (rstipopero ='FPD') 
                                AND rscartera = '121'    
                                AND rstipoper = 'DEV' 
				AND (  ( @cDolar = 'S' and CHARINDEX( STR(rsmonemi,3), '994- 13-995-988' ) > 0 ) or 
                                 	( @cDolar = 'N' and CHARINDEX( STR(rsmonemi,3), '994- 13-995-988' ) = 0 )  )
				)
		BEGIN
			SELECT	
        	                'numdocu'          = CONVERT(CHAR(12),REPLICATE('0', 7 - LEN(LTRIM(STR(rsnumdocu)))) + LTRIM(STR(rsnumdocu)) + '-' +
                	                                              REPLICATE('0', 3 - LEN(LTRIM(STR(rscorrela)))) + LTRIM(STR(rscorrela)))
	                ,       'tipooperacion'    = ISNULL(rstipoper, '')
        	        ,       'serie'            = ISNULL(rsinstser,'')
                	,       'emisor'           = ISNULL((select emnombre from view_emisor where rsrutemis=emrut),'')
	                ,       'nombrecliente'    = ISNULL((select clnombre from view_cliente where rsrutcli=clrut AND rscodcli = clcodigo),'NO EXISTE')
        	        ,       'fechacompra'      = ISNULL(convert(char(10),rsfeccomp,103),'')
                	,       'fechavcto'        = ISNULL(convert(char(10),rsfecvtop,103),'')
	                ,       'tasaemision'      = ISNULL(rstasemi,0)
        	        ,       'base'             = ISNULL(rsbasemi,0)
                	,       'moneda'           = ISNULL((SELECT mnnemo FROM VIEW_MONEDA WHERE rsmonpact=mncodmon),'')	
	                ,       'nominal'          = ISNULL(rsnominal,0)
        	        ,       'cupon'            = ISNULL(rscupamo,0)
                	,       'tir'              = ISNULL(rstir,0)
	                ,       '%vc'              = ISNULL(rsvpcomp,0)
        	        ,       'valorini'         = ISNULL(rsvalcomp,0)
                	,       'valorfinal'       = ISNULL(rsvalcomp,0)
	                ,       'proceso'          = ISNULL(rsvppresen,0)
        	        ,       'interes'          = ISNULL(rsinteres,0)
                	,       'reajuste'         = ISNULL(rsreajuste,0)
	                ,       'interes_acum'     = ISNULL(rsinteres_acum,0)
        	        ,       'reajuste_acum'    = ISNULL(rsreajuste_acum,0)
                	,       'procesoprox'      = ISNULL(rsvppresenx,0)
	                ,       'valorxponde'      = ISNULL((rstir*rsvalcomp),0)
        	        ,       'fecproc'	   = @Fecha_proceso
			,	'fecprox'	   = @Fecha_proxima
			,	'uf_hoy'	   = @uf_hoy
			,	'uf_man'	   = @uf_man
			,	'ivp_hoy'	   = @ivp_hoy
			,	'ivp_man'	   = @ivp_man
			,	'do_hoy'	   = @do_hoy
			,	'do_man'	   = @do_man
			,	'da_hoy'	   = @da_hoy
			,	'da_man'	   = @da_man
                	,       'hora'             = @hora
	                ,       'fecha1'           = CONVERT(CHAR(10),@cfecha,103)
        	        ,       'fecha2'           = CONVERT(CHAR(10),@cfecha1,103)
                	,       'fecha_emision'    = convert(char(10),getdate(),103)
	                ,       'hora_emision'     = convert(char(10),getdate(),108)
        	        ,       'Forma_pago '      = ISNULL((SELECT perfil FROM VIEW_FORMA_DE_PAGO WHERE rsforpagi = codigo ),'')
                	,       'Forma_pagov'      = ISNULL((SELECT perfil FROM VIEW_FORMA_DE_PAGO WHERE rsforpagv = codigo ),'')
	                ,       'mv'               = CASE WHEN rsfecvcto = (SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES) THEN '*'
        	                                          ELSE ''
                	                                  END
			,	'PLAZO'		   = datediff(dd,rsfeccomp,rsfecvtop)

	      		FROM	RESULTADO_DEVENGO 
        	    	WHERE	rsfecha 	= @cfecha
                	  AND   (rstipopero 	= 'FPD') 
	                  AND   rstipoper 	= 'DEV'
        	          AND   rscartera 	= '121'    
                	  AND  (  ( @cDolar = 'S' and CHARINDEX( STR(rsmonemi,3), '994- 13-995-988' ) > 0 ) or 
	                     ( @cDolar = 'N' and CHARINDEX( STR(rsmonemi,3), '994- 13-995-988' ) = 0 )  )


            	END   
		ELSE
   	            SELECT
	                        'numdocu'          = ''
                	,       'tipooperacion'    = ''
        	        ,       'serie'            = ''
	                ,       'emisor'           = ''
                	,       'nombrecliente'    = ''
        	        ,       'fechacompra'      = ''
	                ,       'fechavcto'        = ''
                	,       'tasaemision'      = ''
        	        ,       'base'             = ''
	                ,       'moneda'           = ''
                	,       'nominal'          = ''
        	        ,       'cupon'            = ''
	                ,       'tir'              = ''
                	,       '%vc'              = ''
		        ,       'valorini'         = ''
                	,       'valorfinal'       = ''
        	        ,       'proceso'          = ''
	                ,       'interes'          = ''
                	,       'reajuste'         = ''
        	        ,       'interes_acum'     = ''
	                ,       'reajuste_acum'    = ''
                	,       'procesoprox'      = ''
        	        ,       'valorxponde'      = ''
	                ,       'fecproc'	   = @Fecha_proceso
			,	'fecprox'	   = @Fecha_proxima
			,	'uf_hoy'	   = @uf_hoy
			,	'uf_man'	   = @uf_man
			,	'ivp_hoy'	   = @ivp_hoy
			,	'ivp_man'	   = @ivp_man
			,	'do_hoy'	   = @do_hoy
			,	'do_man'	   = @do_man
			,	'da_hoy'	   = @da_hoy
			,	'da_man'	   = @da_man
                	,       'hora'             = @hora
        	        ,       'fecha1'           = CONVERT(CHAR(10),@cfecha,103)
	                ,       'fecha2'           = CONVERT(CHAR(10),@cfecha1,103)
                	,       'fecha_emision'    = convert(char(10),getdate(),103)
        	        ,       'hora_emision'     = convert(char(10),getdate(),108)
	                ,       'Forma_pago '      = ''
                	,       'Forma_pagov'      = ''
        	        ,       'mv'               = ''
			,	'PLAZO'		   = 0

	SET NOCOUNT OFF
END


GO
