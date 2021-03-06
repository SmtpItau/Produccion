USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Listadorc]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Listadorc] 
         (      @entidad	   NUMERIC(9),
                @Fechacontrol_X    CHAR(10),
                @tipo              CHAR(2)  
   	 )
AS
BEGIN

   DECLARE @Fechacontrol    DATETIME
   SELECT  @Fechacontrol  = CONVERT(DATETIME,@Fechacontrol_X ,112)

   SET DATEFORMAT dmy
   SET NOCOUNT ON

	DECLARE @ncartini	NUMERIC(10,0),
		@ncartfin	NUMERIC(10,0),
		@Fecha_proceso   	CHAR(10),
	        @Fecha_proxima   	CHAR(10),
    	        @uf_hoy      	FLOAT,
     	        @uf_man      	FLOAT,
	        @ivp_hoy     	FLOAT,
	        @ivp_man     	FLOAT,
	        @do_hoy      	FLOAT,
	        @do_man      	FLOAT,
	        @da_hoy      	FLOAT,
	        @da_man      	FLOAT,
	        @Nombre_entidad   	CHAR(40),
	        @rut_empresa 	CHAR(12),
	        @hora        	CHAR(8),
                @fecha_busqueda DATETIME

	SELECT	@ncartini  = @entidad 
	SELECT	@ncartfin  = CASE @entidad WHEN 0 THEN 999999999 ELSE @entidad END
        SELECT  @fecha_busqueda = @Fechacontrol 

	EXECUTE Sp_Base_Del_Informe
	        @Fecha_proceso   OUTPUT,
	        @Fecha_proxima   OUTPUT,
	        @uf_hoy      OUTPUT,
	        @uf_man      OUTPUT,
	        @ivp_hoy     OUTPUT,
	        @ivp_man     OUTPUT,
	        @do_hoy      OUTPUT,
	        @do_man      OUTPUT,
	        @da_hoy      OUTPUT,
	        @da_man      OUTPUT,
	        @Nombre_entidad   OUTPUT,
	        @rut_empresa OUTPUT,
	        @hora        OUTPUT,
                @fecha_busqueda



      IF EXISTS(SELECT 1 
                FROM	MOVIMIENTO_TRADER

	       	WHERE  motipoper in('RC','RCA','VRP','VFL')
                AND     CONVERT(CHAR(10),mofecpro,112) = CONVERT(CHAR(10),@fechacontrol,112)
                AND     mostatreg = ' '
               )
      BEGIN
	SELECT 	'nomcli'	= ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut =  morutcli AND clcodigo = mocodcli), 'NO EXISTE'), 
              	'noment'	= ISNULL( @Nombre_entidad , ' '),
              	'numdocu'	= REPLICATE('0', 10 - LEN(LTRIM(STR(M.monumdocu)))) + LTRIM(STR(M.monumdocu)) + '-' +
                                  REPLICATE('0', 7  - LEN(LTRIM(STR(M.monumoper)))) + LTRIM(STR(M.monumoper)) + '-' +
                                  REPLICATE('0', 03 - LEN(LTRIM(STR(M.mocorrela)))) + LTRIM(STR(M.mocorrela)),
                'instrumento'	= ISNULL( M.moinstser, ' '),
             	'emisor'	= ISNULL((SELECT emgeneric FROM VIEW_EMISOR WHERE emrut = M.morutemi ), ' ') ,
          	'moneda'	= ISNULL((SELECT mnnemo    FROM VIEW_MONEDA WHERE mncodmon = M.momonemi), ' '), 
		'nominal'	= ISNULL( M.monominal,0.0),
               	'tirventa'	= ISNULL( M.motir,0.0) ,
              	'pvp'		= ISNULL( M.mopvp, 0.0),
              	'tasest'	= CONVERT(FLOAT,M.motasest),
		'interes'	= ISNULL( M.mointpac,0.0),
              	'fecinip'	= ISNULL( CONVERT ( CHAR(10), M.mofecinip, 103), ' ' ),
              	'tasapact'	= ISNULL( CASE M.motipoper WHEN 'RCA' THEN M.motasant else M.motaspact end,  0.0),
              	'basepact'	= ISNULL( M.mobaspact, 0),                                                             
            	'monpacto'	= ISNULL(( SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon = M.momonpact), ' '),
              	'valinip'	= ISNULL( M.movalinip, 0),
               	'valorven'	= ISNULL( M.movalvenp, 0),
                'valorpresente' = ISNULL( M.movpresen, 0),
                'forpagoini'	= ISNULL((SELECT perfil FROM VIEW_FORMA_DE_PAGO WHERE codigo= M.moforpagi), ' '),
                'forpagoven'	= ISNULL((SELECT perfil FROM VIEW_FORMA_DE_PAGO WHERE codigo= M.moforpagv), ' '),
		'tipoper'	= M.motipoper, 
		'numoper'	= ISNULL( M.monumoper,0),
		'entidad' 	= @Nombre_entidad,
              	'reajustes'	= ISNULL( M.moreapac,0.0),
		'inserie'       = ISNULL((select inserie from VIEW_INSTRUMENTO where incodigo = M.mocodigo),' ') ,
		'Fecha_proceso'     = @Fecha_proceso   ,
      	   	'Fecha_proxima'     = @Fecha_proxima   ,
       		'uf_hoy'        = @uf_hoy      ,
		'uf_man'        = @uf_man      ,
       		'ivp_hoy'       = @ivp_hoy     ,
		'ivp_man'       = @ivp_man     ,
   		'do_hoy'        = @do_hoy      ,
		'do_man'        = @do_man      ,
		'da_hoy'        = @da_hoy      ,
		'da_man'        = @da_man      ,
		'Nombre_entidad'     = @Nombre_entidad   ,
		'rut_empresa'   = @rut_empresa ,
		'hora'          = @hora        ,
                'carterasuper'  = ISNULL((SELECT C.nombre_carterasuper FROM VIEW_CATEGORIA_CARTERASUPER C WHERE M.codigo_carterasuper = C.codigo_carterasuper),'N / A') ,
                'resultado'     = ISNULL(moutilidad,0),
                'diaspacto'     = DATEDIFF(dd,mofecinip,mofecvenp)
               ,'tipo_cliente'    = ISNULL((CASE  WHEN cltipcli   = 2 or cltipcli   = 3 or cltipcli   = 4 or cltipcli   = 5 
                                                       THEN (SELECT descripcion
                                                               FROM VIEW_TIPO_CLIENTE
                                                              WHERE codigo_tipo_cliente = 2)
                                                  ELSE (SELECT descripcion
                                                          FROM VIEW_TIPO_CLIENTE
                                                         WHERE codigo_tipo_cliente= cltipcli)
                                                  END),' ') 
               ,'tipo_emisor'     = ISNULL((SELECT glosa FROM VIEW_TIPO_EMISOR, VIEW_EMISOR
                                            WHERE codigo_tipo = emtipo 
                                              AND emrut       = M.morutemi) ,' ')
               ,'plazo_pacto'     = ( CASE WHEN ( m.morutcli = 97029000  ) THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 7 )
                                                   WHEN DATEDIFF(DD,m.mofecinip,m.mofecvenp)  >= 0    AND DATEDIFF(DD,m.mofecinip,m.mofecvenp)   < 30  THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 3 )
                                                   WHEN DATEDIFF(DD,m.mofecinip,m.mofecvenp)  >= 30   AND DATEDIFF(DD,m.mofecinip,m.mofecvenp)  <= 89  THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 4 )
                                                   WHEN DATEDIFF(DD,m.mofecinip,m.mofecvenp)  >= 90   AND DATEDIFF(DD,m.mofecinip,m.mofecvenp)  <= 365 THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 5 )
                                                   WHEN DATEDIFF(DD,m.mofecinip,m.mofecvenp)  >= 366  THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 6 )
                                            END )
               ,'tITULO'          = 'MOVIMIENTO DE ' + ( SELECT descripcion FROM VIEW_PRODUCTO WHERE Codigo_Producto = motipoper AND iD_sistema = 'BTR' )
					--(CASE WHEN M.motipoper <> 'RCA' THEN 'INFORME DE MOVIMIENTO DIARIO DE RETROCOMPRAS' ELSE 'INFORME DE MOVIMIENTO DIARIO DE RETROCOMPRAS ANTICIPADAS' END)
               ,'tITULO2'         = 'AL ' + CONVERT(CHAR(10),@Fechacontrol,103) 
               ,'Tipo'            = CONVERT(CHAR(1),m1.mnextranj)
	       ,'CLAVE' 	  = SPACE(100)
               ,'Tipo_moneda_papel'    = m2.mnextranj
		INTO	#TEMP1
		FROM	MOVIMIENTO_TRADER M
                   ,    VIEW_CLIENTE
                   ,    VIEW_MONEDA m1
                   ,    VIEW_MONEDA m2
	       	WHERE  M.motipoper in('RC','RCA','VRP','VFL')
                AND     M.mostatreg             =  ' '
                AND     CONVERT(CHAR(10),mofecpro,112) = CONVERT(CHAR(10),@fechacontrol,112)
                AND    (clrut                  =  M.morutcli 
	        AND     clcodigo               =  M.mocodcli)
                AND     m1.mncodmon               =  M.momonpact
                AND     m2.mncodmon               =  momonemi

	UPDATE #TEMP1 SET clave = LTRIM(RTRIM(plazo_pacto)) + ' '+ LTRIM(RTRIM(tipo_cliente)) + ' '+ LTRIM(RTRIM(tipo_emisor)) + ' ' + CASE WHEN emisor IN('BCCH','INP') THEN ' ' ELSE  LTRIM(RTRIM(emisor)) END + ' ' + moneda

        SELECT *  FROM #TEMP1 ORDER BY inserie,monpacto
	
	END
	ELSE BEGIN
	SELECT 	'nomcli'	= '',
               	'noment'	= '',
              	'numdocu'	= '',
                'instrumento'	= '',
             	'emisor'	= '',
          	'moneda'	= '',
		'nominal'	= '',
               	'tirventa'	= '' ,
              	'pvp'		= '',
              	'tasest'	= '',
		'interes'	= '',
              	'fecinip'	= '',
              	'tasapact'	= '',
              	'basepact'	= '',                                                             
            	'monpacto'	= '',                                                               
              	'valinip'	= '',                                                             
               	'valorven'	= '',                                                             
                'valorpresente' = '',
                'forpagoini'	= '',
		'forpagoven'	= '',                                                              
		'tipoper'	= '', 
		'numoper'	= '',
		'entidad' 	= '',
		'reajustes'	= '',
		'inserie'       = '' ,
                'Fecha_proceso'     = @Fecha_proceso   ,
      	    	'Fecha_proxima'     = @Fecha_proxima   ,
       		'uf_hoy'        = @uf_hoy      ,
		'uf_man'        = @uf_man      ,
 		'ivp_hoy'       = @ivp_hoy     ,
		'ivp_man'       = @ivp_man     ,
   		'do_hoy'        = @do_hoy      ,
		'do_man'        = @do_man      ,
		'da_hoy'        = @da_hoy      ,
		'da_man'        = @da_man      ,
		'Nombre_entidad'     = @Nombre_entidad   ,
		'rut_empresa'   = @rut_empresa ,
		'hora'          = @hora        ,
                'carterasuper'  = ''           ,
                'resultado'     = ''            ,
                'diaspacto'     = ''
               ,'tipo_cliente'  = '' 
               ,'tipo_emisor'   = ''
               ,'plazo_pacto'   = ' '
               ,'tITULO'          = 'INFORME DE MOVIMIENTO DIARIO DE RETROCOMPRAS ' 
               ,'tITULO2'         = 'AL ' + CONVERT(CHAR(10),@Fechacontrol,103) 
               ,'CLAVE'         = ''
               ,'Tipo'          = ' '
               ,'Tipo_moneda_papel' = '' 


    END

      SET NOCOUNT OFF
END

GO
