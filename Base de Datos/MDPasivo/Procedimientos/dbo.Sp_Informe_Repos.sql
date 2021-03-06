USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Informe_Repos]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Informe_Repos]
         (      @tipo_cartera	CHAR	(03)	= ''
            ,   @tipo_opera	CHAR	(05)	= ''
            ,   @entidad	NUMERIC	(09)	= 0
            ,   @titulo		VARCHAR	(80)	= ''
            ,   @carterasuper	CHAR	(01)    = ''
            ,   @cDolar		CHAR	(01)
            ,   @xFechaProc	CHAR    (10)
            ,   @xFechaProx	CHAR    (10)
	)
AS
BEGIN

    SET DATEFORMAT dmy

   DECLARE @Fecha_proceso      	CHAR   (10)
      ,    @Fecha_proxima      	CHAR   (10)
      ,    @uf_hoy	   	NUMERIC(21,04)
      ,    @uf_man         	NUMERIC(21,04)
      ,    @ivp_hoy        	NUMERIC(21,04)
      ,    @ivp_man        	NUMERIC(21,04)
      ,    @do_hoy         	NUMERIC(21,04)
      ,    @do_man         	NUMERIC(21,04)
      ,    @da_hoy         	NUMERIC(21,04)
      ,    @da_man         	NUMERIC(21,04)
      ,    @nRutemp        	NUMERIC(09,00)
      ,    @Nombre_entidad      CHAR   (40)
      ,    @rut_empresa    	CHAR   (12)
      ,    @hora           	CHAR   (08)
      ,    @paso           	CHAR   (01)
      ,    @fecha_busqueda 	DATETIME
      ,    @FechaProc	   	DATETIME
      ,    @FechaProx      	DATETIME
      ,    @cTituloDolar   	VARCHAR(15)

   SELECT @FechaProc = CONVERT(DATETIME,@xFechaProc)
      ,   @FechaProx = CONVERT(DATETIME,@xFechaProx)

   SELECT  @fecha_busqueda = @FechaProc

   SELECT @cTituloDolar = CASE WHEN @CDolar = 'S' THEN ' EN DOLARES '
                               ELSE ' '
                          END

    
   SET NOCOUNT ON

   EXECUTE Sp_Base_Del_Informe
           @Fecha_proceso	OUTPUT
      ,    @Fecha_proxima	OUTPUT
      ,    @uf_hoy		OUTPUT
      ,    @uf_man		OUTPUT
      ,    @ivp_hoy		OUTPUT
      ,    @ivp_man		OUTPUT
      ,    @do_hoy		OUTPUT
      ,    @do_man		OUTPUT
      ,    @da_hoy		OUTPUT
      ,    @da_man		OUTPUT
      ,    @Nombre_entidad	OUTPUT
      ,    @rut_empresa		OUTPUT
      ,    @hora		OUTPUT
      ,    @fecha_busqueda

   SELECT @paso = 'N'
        
   IF @FechaProc = (SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES) OR @FechaProx = (SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES)
   BEGIN

      GOTO CARTERA_DEL_DIA

   END ELSE BEGIN

      GOTO CARTERA_HISTORICA_TRADER

   END

   RETURN

CARTERA_DEL_DIA:

   IF EXISTS(SELECT 1 FROM RESULTADO_DEVENGO
                           WHERE rsfecha    = @xFechaProc
	                  AND   rstipopero = 'VI' 
        	          AND   rstipoper  = 'DEV' 
	                  AND   rsrutcli   = 97029000  
	                  AND   rscartera  ='115'
                          AND   CHARINDEX(STR(rsmonemi,3), CASE WHEN @cDolar = 'N' THEN '997-998-999-503' 
                                                                  ELSE '988-994-995- 13' END)  > 0
            )
   BEGIN

      GOTO RESULTADO_DEVENGO

   END ELSE BEGIN

      GOTO CARTERA_VENTAS_CON_PACTO

   END

   RETURN

CARTERA_HISTORICA_TRADER:

   IF EXISTS(SELECT 1 FROM RESULTADO_DEVENGO
                WHERE   rsfecha    = @xFechaProc
	                  AND   rstipopero = 'RP' 
        	          AND   rstipoper  = 'DEV' 
	                  AND   rsrutcli   = 97029000  
	                  AND   rscartera  ='115'
                  AND   CHARINDEX(STR(rsmonemi,3), CASE WHEN @cDolar = 'N' THEN '997-998-999-503' 
                                                              ELSE '988-994-995- 13' END)  > 0)
   BEGIN

      GOTO RESULTADO_DEVENGO

   END ELSE BEGIN

      GOTO VALORES_POR_DEFECTO

   END 

   RETURN

RESULTADO_DEVENGO:

      SELECT 'NumDoc'            = CONVERT(CHAR(20),REPLICATE('0', 7 - LEN(LTRIM(STR(rsnumoper)))) + LTRIM(STR(rsnumdocu)) + '-' +
                                            REPLICATE('0', 7 - LEN(LTRIM(STR(rsnumdocu)))) + LTRIM(STR(rsnumoper)) + '-' +
                                            REPLICATE('0', 3 - LEN(LTRIM(STR(rscorrela)))) + LTRIM(STR(rscorrela)))
         ,   'rscorrela'         = ISNULL(rscorrela,0)
         ,   'rsinstser'	 = ISNULL(rsinstser,'')
         ,   'Emisor'	         = ISNULL((SELECT emgeneric FROM VIEW_EMISOR WHERE emrut = rsrutemis), ' ')
         ,   'FechaCompra'	 = ISNULL(CONVERT(CHAR(10) ,rsfeccomp, 103) ,' ')
         ,   'FechaVctoP'	 = ISNULL(CONVERT(CHAR(10) ,rsfecvtop, 103) ,' ' )
         ,   'FechaIniP'	 = ISNULL(CONVERT(CHAR(10) ,rsfecinip, 103) ,' ' )
         ,   'FechaVcto'         = ISNULL(CONVERT(CHAR(10) ,rsfecvcto, 103) ,' ' )
         ,   'Dias'              = ISNULL(DATEDIFF(dd,rsfecinip,rsfecvtop) ,0 )
         ,   'rsvalcomu'         = CONVERT(FLOAT,ISNULL(rsvalcomu,0))
         ,   'monedapacto'       = ISNULL((SELECT mnsimbol FROM VIEW_MONEDA WHERE mncodmon = rsmonpact),'')
         ,   'UM'                = ISNULL((SELECT mnsimbol FROM VIEW_MONEDA WHERE mncodmon = rsmonemi),'')
         ,   'rsnominal'         = CONVERT(FLOAT,ISNULL(rsnominal,0))
         ,   'Cupon'             = CONVERT(FLOAT,ISNULL((rsflujo - rscupint ),0))
         ,   'rscupint'          = CONVERT(FLOAT,ISNULL(rscupint,0))
         ,   'rstir'             = CONVERT(FLOAT,ISNULL(rstir,0))
         ,   'rsvpcomp'          = CONVERT(FLOAT,ISNULL(rsvalinip,0))
         ,   'rsvppresen'        = CONVERT(FLOAT,ISNULL(rsvppresen,0))
         ,   'rsinteres'         = CONVERT(FLOAT,ISNULL(rsinteres,0))
         ,   'rsreajuste'        = CONVERT(FLOAT,ISNULL(rsreajuste,0))
         ,   'rsintermes'        = CONVERT(FLOAT,ISNULL(rsintermes,0))
         ,   'rsreajumes'        = CONVERT(FLOAT,ISNULL(rsreajumes,0))
         ,   'rsvppresenx'       = CONVERT(FLOAT,ISNULL(rsvppresenx,0))
         ,   'rsinteres_acum'    = CONVERT(FLOAT,ISNULL(rsinteres_acum,0))
         ,   'rsreajuste_acum'   = CONVERT(FLOAT,ISNULL(rsreajuste_acum,0))
         ,   'ValorIniPeso'      = CONVERT(FLOAT,ISNULL(rsvalinip,0))
         ,   'ValorVctoUM'       = CONVERT(FLOAT,ISNULL(rsvalvtop,0))
         ,   'TasaPacto'         = CONVERT(FLOAT,ISNULL(rstaspact,0))
         ,   'TasaEmision'       = CONVERT(FLOAT,ISNULL(rstasemi,0))
         ,   'rutCliente'        = ISNULL((CONVERT(VARCHAR(10) , rsrutcli )) + '-' + (SELECT cldv FROM VIEW_CLIENTE WHERE clrut  = rsrutcli AND CLCODIGO = rscodcli),"*-*")
         ,   'Cliente'           = ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut  = rsrutcli and clcodigo = rscodcli )," ")
         ,   'base_emision'      = ISNULL(rsbasemi,0)
         ,   'carterasuper'      = ISNULL((SELECT c.nombre_carterasuper FROM VIEW_CATEGORIA_CARTERASUPER c WHERE  RESULTADO_DEVENGO.codigo_carterasuper = c.codigo_carterasuper),'')
         ,   'FECHA_EMI'         = CONVERT(CHAR(10) , GETDATE() , 103 )
         ,   'HORA_EMI'          = CONVERT(CHAR(08) , GETDATE() , 108 )
         ,   'FECHA_PROC'        = CONVERT(CHAR(10),@FechaProc,103)  
         ,   'USUARIO'           = ' ' ---@USUARIO + ' / BAC-TRADER'
         ,   'tipo_cliente'      = ISNULL((CASE WHEN cltipcli IN(2,3,4,5) THEN
                                                (SELECT descripcion FROM VIEW_TIPO_CLIENTE 
                                                 WHERE codigo_tipo_cliente =2  )
                                           ELSE (SELECT descripcion FROM VIEW_TIPO_CLIENTE 
                                                 WHERE codigo_tipo_cliente= cltipcli)
                                           END),'')
         ,   'tipo_emisor'       = ISNULL((SELECT glosa FROM VIEW_TIPO_EMISOR, VIEW_EMISOR
                                            WHERE codigo_tipo = emtipo 
                                              AND emrut       = rsrutemis) ,'')
         ,   'plazo_pacto'       = (CASE WHEN (rsrutcli = 97029000) THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 7 )
                                        WHEN DATEDIFF(DD,rsfecinip,rsfecvtop)  >= 0    AND DATEDIFF(DD,rsfecinip,rsfecvtop)   < 30  THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 3 )
                                         WHEN DATEDIFF(DD,rsfecinip,rsfecvtop)  >= 30   AND DATEDIFF(DD,rsfecinip,rsfecvtop)  <= 89  THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 4 )
                                         WHEN DATEDIFF(DD,rsfecinip,rsfecvtop)  >= 90   AND DATEDIFF(DD,rsfecinip,rsfecvtop)  <= 365 THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 5 )
                                         WHEN DATEDIFF(DD,rsfecinip,rsfecvtop)  >= 366  THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 6 )
                                    END)
         ,   'vi'                = 0
         ,   'vf'                = 0
         ,   'titulo1'	         = @titulo
         ,   'fecproc'	         = @Fecha_proceso
         ,   'fecprox'	         = @FechaProx 
         ,   'uf_hoy'	         = @uf_hoy
         ,   'uf_man'	         = @uf_man
         ,   'ivp_hoy'	         = @ivp_hoy
         ,   'ivp_man'	         = @ivp_man
         ,   'do_hoy'	         = @do_hoy
         ,   'do_man'	         = @do_man
         ,   'da_hoy'	         = @da_hoy
         ,   'da_man'	         = @da_man
         ,   'Nombre_entidad'    = (SELECT ISNULL(@Nombre_entidad, 'NO DEFINIDO') FROM VIEW_DATOS_GENERALES )
         ,   'rut_empresa'       = @rut_empresa
         ,   'nombreentidad'     = (SELECT ISNULL(Nombre_entidad, 'NO DEFINIDO') from VIEW_DATOS_GENERALES )
         ,   'hora'		 = @hora
         ,   'datos'             = CONVERT(CHAR(21),'TOTAL')
         ,   'tas_por_valor'     = CONVERT(FLOAT, ISNULL(rstaspact,0) * ISNULL(rsvalinip,0))
         ,   'tipo'              = (CASE WHEN MNEXTRANJ = "0" then "VIX" else "VI" end)
	 ,   'moneda'		 = rsmonpact
	 ,   'Tir_Pon'           = CONVERT(FLOAT,ISNULL(rstir,0) * ISNULL(rsnominal,0))
      INTO   #INFORME_CARTERA
      FROM   RESULTADO_DEVENGO, VIEW_CLIENTE,view_moneda
     WHERE   (clrut =* rsrutcli AND clcodigo =* rscodcli)
	     AND   mncodmon = rsmonpact                   
	     AND   rsfecha    = @xFechaProc
	     AND   rstipopero = 'RP' 
	     AND   rstipoper  = 'DEV' 
	     AND   rsrutcli   = 97029000  
	     AND   rscartera  ='115'
             AND   CHARINDEX(STR(rsmonemi,3), CASE WHEN @cDolar = 'N' THEN '997-998-999-503' 
                                                              ELSE '988-994-995- 13' END)  > 0
--      ORDER BY rsnumoper,rsfecvtop,rsinstser
--	

	IF @cDolar = 'N'
	BEGIN
		DELETE #INFORME_CARTERA WHERE CHARINDEX(STR(moneda, 3),'988-994-995- 13') > 0
	END

	IF EXISTS(SELECT 1 FROM #INFORME_CARTERA)
	BEGIN
		SELECT * FROM #INFORME_CARTERA
	END
	ELSE
	BEGIN
		GOTO VALORES_POR_DEFECTO
	END

   RETURN

CARTERA_VENTAS_CON_PACTO:


   IF EXISTS(SELECT 1 FROM CARTERA_VENTA_PACTO
             WHERE CHARINDEX(STR(vimonpact, 3),CASE WHEN @cDolar = 'N' THEN STR(vimonpact) ELSE '988-994-995- 13' END) > 0
			AND Tipo_Operacion = 'RP'
		)
   BEGIN
		
      SELECT	 	'NumDoc'	        =   CONVERT(CHAR(20),REPLICATE('0', 7 - LEN(LTRIM(STR(vinumoper)))) + LTRIM(STR(vinumdocu)) + '-' +
		                                            REPLICATE('0', 7 - LEN(LTRIM(STR(vinumdocu)))) + LTRIM(STR(vinumoper)) + '-' 
+
                		                            REPLICATE('0', 3 - LEN(LTRIM(STR(vicorrela)))) + LTRIM(STR(vicorrela)))
		,       'rscorrela' 	        =   ISNULL(vicorrela,0)
		,	'rsinstser'	        =   ISNULL(viinstser,'')
		,	'Emisor'	        =   ISNULL((SELECT emgeneric FROM VIEW_EMISOR WHERE emrut = virutemi),' ')
                ,	'FechaCompra'	        =   ISNULL(CONVERT(CHAR(10),vifeccomp,103) ,' ')
		,	'FechaVctoP'	        =   ISNULL(CONVERT(CHAR(10),vifecvenp,103),' ' )
             	,	'FechaIniP'	        =   ISNULL(CONVERT(CHAR(10),vifecinip,103),' ' )
                ,	'FechaVcto'	        =   ISNULL(CONVERT(CHAR(10),vifecven,103),' ' )
		,	'Dias'		        =   ISNULL(DATEDIFF(dd,vifecinip,vifecvenp),0 )
		,	'rsvalcomu'	        =   CONVERT(FLOAT,ISNULL(vivalcomu,0))
		,	'monedapacto'	        =   ISNULL((SELECT mnnemo FROM VIEW_MONEDA WHERE MNCODMON = vimonpact),' ')
		,	'UM'		        =   ISNULL((SELECT mnnemo FROM VIEW_MONEDA WHERE MNCODMON = vimonemi),' ')
		,	'rsnominal'	        =   CONVERT(FLOAT,ISNULL(vinominal,0))
		,	'Cupon' 	        =   CONVERT(FLOAT,0)
		,	'rscupint'	        =   CONVERT(FLOAT,0)
		,	'rstir'		        =   CONVERT(FLOAT,ISNULL(vitirvent,0))
		,	'rsvpcomp'	        =   CONVERT(FLOAT,ISNULL(vivalinip,0))
		,	'rsvppresen'	        =   CONVERT(FLOAT,ISNULL(vivptirvi,0))
		,	'rsinteres'	        =   0.0
		,	'rsreajuste'	        =   0.0
		,	'rsintermes'	        =   CONVERT(FLOAT,ISNULL(viintermesvi,0))
		,	'rsreajumes'	        =   CONVERT(FLOAT,ISNULL(vireajumesvi,0))
		,	'rsvppresenx'	        =   CONVERT(FLOAT,ISNULL(vivptirvi,0))
		,	'rsinteres_acum'        =   CONVERT(FLOAT,ISNULL(viinteresvi,0))
		,	'rsreajuste_acum'       =   CONVERT(FLOAT,ISNULL(vireajustvi,0))
		,	'ValorIniPeso'	        =   CONVERT(FLOAT,ISNULL(vivalinip,0))
		,	'ValorVctoUM'	        =   CONVERT(FLOAT,ISNULL(vivalvenp,0))
		,	'TasaPacto'	        =   CONVERT(FLOAT,ISNULL(vitaspact,0))
		,	'TasaEmision'	        =   CONVERT(FLOAT,0)
		,	'rutCliente'	        =   ISNULL((CONVERT(VARCHAR(10) , virutcli )) + '-' + (SELECT CLDV FROM VIEW_CLIENTE WHERE CLRUT  = virutcli and CLCODIGO = vicodcli),'*-*')
		,	'Cliente'	        =   ISNULL((SELECT CLNOMBRE FROM VIEW_CLIENTE WHERE CLRUT  = virutcli and CLCODIGO = vicodcli ),' ')
		,	'base_emision'	        =   ISNULL(vibaspact,0)
    		,	'carterasuper'          =   ISNULL((select c.nombre_carterasuper from view_categoria_carterasuper c where CARTERA_VENTA_PACTO.codigo_carterasuper=c.codigo_carterasuper),'')
                ,       'FECHA_EMI'             =   CONVERT(CHAR(10) , GETDATE() , 103 )
                ,       'HORA_EMI'              =   CONVERT(CHAR(08) , GETDATE() , 108 )
                ,       'FECHA_PROC'            =   CONVERT(CHAR(10),@FechaProc,103)
                ,       'USUARIO'               =   ' ' --@usuario + ' / BAC-TRADER'
                ,       'tipo_cliente'          =   ISNULL((CASE WHEN cltipcli = 2 or cltipcli = 3 or cltipcli = 4 or cltipcli = 5 
                                                                 THEN (SELECT descripcion
                                                                         FROM VIEW_TIPO_CLIENTE
                                                                        WHERE codigo_tipo_cliente = 2         )
                                                                 ELSE (SELECT descripcion
                                                                         FROM VIEW_TIPO_CLIENTE
                                                                        WHERE codigo_tipo_cliente = cltipcli)
                                                            END ),'')

                ,       'tipo_emisor'           =  ISNULL(( SELECT glosa
                                                         FROM VIEW_TIPO_EMISOR, VIEW_EMISOR
                                                         WHERE codigo_tipo  = emtipo 
                                                         AND   emrut        = virutemi) ,'') 



                ,       'plazo_pacto'           = ( CASE WHEN ( virutcli = 97029000 )  THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 7 ) 
                                                         ELSE
                                                     CASE
                                                         WHEN DATEDIFF(DD,vifecinip,vifecvenp)  >= 0    AND DATEDIFF(DD,vifecinip,vifecvenp)   < 30  THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 3 )
                                                         WHEN DATEDIFF(DD,vifecinip,vifecvenp)  >= 30   AND DATEDIFF(DD,vifecinip,vifecvenp)  <= 89  THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 4 )
                                                         WHEN DATEDIFF(DD,vifecinip,vifecvenp)  >= 90   AND DATEDIFF(DD,vifecinip,vifecvenp)  <= 365 THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 5 )
                                                         WHEN DATEDIFF(DD,vifecinip,vifecvenp)  >= 366  THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 6  )
                                                      END
                                                     END )
                ,       'vi'                    = 0
                ,       'vf'                    = 0
		,	'titulo1'	        = @titulo

		,	'fecproc'	        = @Fecha_proceso
		,	'fecprox'	        = @FechaProx 
		,	'uf_hoy'	        = @uf_hoy
		,	'uf_man'	        = @uf_man
		,	'ivp_hoy'	        = @ivp_hoy
		,	'ivp_man'	        = @ivp_man
		,	'do_hoy'	        = @do_hoy
		,	'do_man'	        = @do_man
		,	'da_hoy'	        = @da_hoy
		,	'da_man'	        = @da_man
		,	'Nombre_entidad'        = (SELECT ISNULL(@Nombre_entidad, 'NO DEFINIDO') FROM VIEW_DATOS_GENERALES )
		,	'rut_empresa'           = @rut_empresa
		,	'nombreentidad'         = (SELECT ISNULL(Nombre_entidad, 'NO DEFINIDO') from VIEW_DATOS_GENERALES )
		,	'hora'		        = @hora
                ,       'datos'                 = CONVERT(CHAR(21),'TOTAL')
                ,       'tas_por_valor'         = CONVERT(FLOAT,ISNULL(vitaspact,0) * ISNULL(vivalinip,0))
                ,       'tipo'                  = Tipo_Operacion
		,   	'moneda'		= vimonpact
		,	'Tir_Pon'               = CONVERT(FLOAT,ISNULL(vitirvent,0) * ISNULL(vinominal,0))
		INTO   #INFORME_CARTERA_2
		FROM CARTERA_VENTA_PACTO, VIEW_CLIENTE	
	  	WHERE clrut    =* virutcli 
                  AND clcodigo =* vicodcli
                  AND CHARINDEX(STR(vimonpact,3),CASE WHEN @cDolar='N' THEN STR(vimonpact) ELSE '988-994-995- 13' END)>0
		  AND Tipo_Operacion = 'RP'
		ORDER BY vinumoper,vifecvenp,viinstser

	IF @cDolar = 'N'
	BEGIN
		DELETE #INFORME_CARTERA_2 WHERE CHARINDEX(STR(moneda, 3),'988-994-995- 13') > 0
	END

	IF EXISTS(SELECT 1 FROM  #INFORME_CARTERA_2)
	BEGIN
		SELECT * FROM  #INFORME_CARTERA_2
	END
	ELSE
	BEGIN
		GOTO VALORES_POR_DEFECTO
	END
-- select * from cartera_venta_pacto

   END ELSE BEGIN

      GOTO VALORES_POR_DEFECTO

   END

   RETURN

VALORES_POR_DEFECTO:

   SET NOCOUNT OFF

   SELECT 'NumDoc'              = CONVERT(CHAR(20),'')
      ,   'rscorrela' 	        = 0
      ,   'rsinstser'	        = ''
      ,   'Emisor'	        = ''
      ,   'FechaCompra'	        = ''
      ,   'FechaVctoP'	        = ''
      ,   'FechaIniP'	        = ''
      ,   'FechaVcto'      	= ''
      ,   'Dias'		= 0
      ,   'rsvalcomu'	        = CONVERT(FLOAT,0)
      ,   'monedapacto'	        = ''
      ,   'UM'		        = ''
      ,   'rsnominal'	        = CONVERT(FLOAT,0)
      ,   'Cupon' 	        = CONVERT(FLOAT,0)
      ,   'rscupint'	        = CONVERT(FLOAT,0)
      ,   'rstir'		= CONVERT(FLOAT,0)
      ,   'rsvpcomp'	        = CONVERT(FLOAT,0)
      ,   'rsvppresen'	        = CONVERT(FLOAT,0)
      ,   'rsinteres'	        = CONVERT(FLOAT,0)
      ,   'rsreajuste'	        = CONVERT(FLOAT,0)
      ,   'rsintermes'	        = CONVERT(FLOAT,0)
      ,   'rsreajumes'	        = CONVERT(FLOAT,0)
      ,   'rsvppresenx'	        = CONVERT(FLOAT,0)
      ,   'rsinteres_acum'      = CONVERT(FLOAT,0)
      ,   'rsreajuste_acum'     = CONVERT(FLOAT,0)
      ,   'ValorIniPeso'	= CONVERT(FLOAT,0)
      ,   'ValorVctoUM'	        = CONVERT(FLOAT,0)
      ,   'TasaPacto'	        = CONVERT(FLOAT,0)
      ,   'TasaEmision'	        = CONVERT(FLOAT,0)
      ,   'rutCliente'	        = ''
      ,   'Cliente'	        = ''
      ,   'base_emision'	= 0.0
      ,   'carterasuper'        = ''
      ,   'FECHA_EMI'           = CONVERT(CHAR(10) , GETDATE() , 103 )
      ,   'HORA_EMI'            = CONVERT(CHAR(08) , GETDATE() , 108 )
      ,   'FECHA_PROC'          = CONVERT(CHAR(10),@FechaProc,103)  
      ,   'USUARIO'             = ' ' --@USUARIO + ' / BAC-TRADER'
      ,   'tipo_cliente'        = ''
      ,   'tipo_emisor'         = ''
      ,   'plazo_pacto'         = ''
      ,   'vi'                  = 0
      ,   'vf'                  = 0
      ,   'titulo1'	        = @titulo
      ,   'fecproc'	        = @Fecha_proceso
      ,   'fecprox'	        = @FechaProx 
      ,   'uf_hoy'	        = @uf_hoy
      ,   'uf_man'	        = @uf_man
      ,   'ivp_hoy'	        = @ivp_hoy
      ,   'ivp_man'	        = @ivp_man
      ,   'do_hoy'	        = @do_hoy
      ,   'do_man'	        = @do_man
      ,   'da_hoy'	        = @da_hoy
      ,   'da_man'	        = @da_man
      ,   'Nombre_entidad'      = (SELECT ISNULL(@Nombre_entidad, 'NO DEFINIDO') FROM VIEW_DATOS_GENERALES )
      ,   'rut_empresa'         = @rut_empresa
      ,   'nombreentidad'       = (SELECT ISNULL(Nombre_entidad, 'NO DEFINIDO') from VIEW_DATOS_GENERALES )
      ,   'hora'		= @hora
      ,   'datos'               = CONVERT(CHAR(21),'NO EXISTE INFORMACION')
      ,   'tas_por_valor'       = CONVERT(FLOAT,0)
      ,   'tipo'                = ''
      ,   'moneda'		= 0 
      ,   'Tir_Pon'             = CONVERT(FLOAT,0)
END


GO
