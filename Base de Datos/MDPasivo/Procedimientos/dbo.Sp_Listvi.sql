USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Listvi]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Listvi]
       (      
              @entidad       NUMERIC(9)
          ,   @fecha_X       CHAR(8)
          ,   @tipo          CHAR(2) 
       )
AS
BEGIN

SET DATEFORMAT dmy

   DECLARE @fecha  DATETIME
   SELECT  @fecha  = CONVERT(DATETIME,@fecha_X,112)

   --JAN 10/07/2001

  SET NOCOUNT ON

  /*PROCEDIMIENTO DEL INFORME DE MOVIMIENTO DIARIO DE VENTAS CON PACTO*/

  DECLARE   @Fecha_proceso      CHAR(10)
   ,        @Fecha_proxima      CHAR(10)
   ,        @uf_hoy         NUMERIC(21,04)
   ,        @uf_man         NUMERIC(21,04)
   ,        @ivp_hoy        NUMERIC(21,04)
   ,        @ivp_man        NUMERIC(21,04)
   ,        @do_hoy         NUMERIC(21,04)
   ,        @do_man         NUMERIC(21,04)
   ,        @da_hoy         NUMERIC(21,04)
   ,        @da_man         NUMERIC(21,04)
   ,        @Nombre_entidad      CHAR(40)
   ,        @rut_empresa    CHAR(12)
   ,        @hora           CHAR(8)
   ,        @fecha_busqueda DATETIME
   ,        @titulo         VARCHAR(255)

  SELECT    @fecha_busqueda = @fecha

  EXECUTE Sp_Base_Del_Informe
           @Fecha_proceso   OUTPUT
   ,       @Fecha_proxima   OUTPUT
   ,       @uf_hoy      OUTPUT
   ,       @uf_man      OUTPUT
   ,       @ivp_hoy     OUTPUT
   ,       @ivp_man     OUTPUT
   ,       @do_hoy      OUTPUT
   ,       @do_man      OUTPUT
   ,       @da_hoy      OUTPUT
   ,       @da_man      OUTPUT
   ,       @Nombre_entidad   OUTPUT
   ,       @rut_empresa OUTPUT
   ,       @hora        OUTPUT     
   ,       @fecha_busqueda

   DECLARE @ncartini	NUMERIC(10,0)
   DECLARE @ncartfin	NUMERIC(10,0)
   SELECT  @ncartini     = @entidad 
   SELECT  @ncartfin     = CASE @entidad WHEN 0 then 999999999 ELSE @entidad END

IF EXISTS(SELECT 1 FROM MOVIMIENTO_TRADER	                    a
                   ,	VIEW_CLIENTE	            c
	           ,	VIEW_ENTIDAD	            r
	           ,	VIEW_EMISOR	            e
                   ,	VIEW_INSTRUMENTO	    i
	           ,	VIEW_FORMA_DE_PAGO          p1
	           ,	VIEW_FORMA_DE_PAGO	    p2
                   ,	VIEW_MONEDA	            m1
                ,	VIEW_MONEDA	            m2
                  WHERE a.motipoper in('VI', 'VIX')
                  AND 	a.mostatreg                       = ''
                  AND   r.rcrut                           = a.morutcart
                  AND	(c.clrut                          = a.morutcli 
		  AND   c.clcodigo                        = a.mocodcli)
                  AND   e.emrut                           =*a.morutemi  
                  AND   i.incodigo            		  = a.mocodigo  
                  AND   m1.mncodmon                       =*a.momonemi
                  AND	m2.mncodmon  			  = a.momonpact
                  AND   p1.codigo                         = a.moforpagi
                  AND   p2.codigo                         = a.moforpagv
                  AND   CONVERT(CHAR(10),a.mofecpro,103)  = CONVERT(CHAR(10),@FECHA,103) 
         )
   BEGIN
        SELECT  'nomcli'	   = ISNULL( c.clnombre , ' ')
        ,       'noment'	   = ISNULL( r.rcnombre , ' ')
	,       'numdocu'	   = REPLICATE('0', 7  - LEN(LTRIM(STR(monumoper)))) + LTRIM(STR(monumoper)) + '-' +
                                     REPLICATE('0', 10 - LEN(LTRIM(STR(monumdocu)))) + LTRIM(STR(monumdocu)) + '-' +
                                     REPLICATE('0', 03 - LEN(LTRIM(STR(mocorrela)))) + LTRIM(STR(mocorrela))
        ,       'instrumento'	   = ISNULL( a.moinstser, ' ')
        ,       'emisor'	   = ISNULL( e.emgeneric, ' ')
        ,       'fecven'	   = ISNULL( CONVERT(CHAR(10), a.mofecven, 103), ' ')
	,       'moneda'	   = ISNULL( m1.mnsimbol, ' ')
        ,       'nominal'	   = ISNULL( a.monominal,0)
        ,       'tirventa'	   = ISNULL( a.motir, 0)
        ,       'pvp'		   = ISNULL( a.mopvp, 0)
	,       'valorventa'	   = ISNULL( a.movpresen, 0)
	,       'fechaini'	   = ISNULL( convert ( CHAR(10), a.mofecinip, 103), ' ' )
        ,       'fecvtop'	   = ISNULL( convert ( CHAR(10), a.mofecvenp, 103), ' ' )
        ,       'tasapact'	   = ISNULL( a.motaspact, 0)
        ,       'monpacto'	   = ISNULL( m2.mnnemo, ' ')
        ,       'valinip'	   = ISNULL( a.movalinip, 0)
        ,       'valorven'	   = ISNULL( a.movalvenp, 0)
        ,       'familia'	   = ISNULL( i.inserie,' ')
	,       'numoper'	   = ISNULL( a.monumoper,0)
	,       'sw'		   = '0'
        ,       'base'             = ISNULL(mobasemi,0)
        ,       'basepacto'        = ISNULL(mobaspact,0)
        ,       'diaspacto'        = DATEDIFF(dd,mofecinip,mofecvenp)
        ,       'pagoinicio'       = p1.glosa2
        ,       'pagovencimiento'  = p2.glosa2
      	,       'Fecha_proceso' 	   = @Fecha_proceso
	,       'Fecha_proxima' 	   = @Fecha_proxima
	,	'uf_hoy'    	   = @uf_hoy
	,	'uf_man'    	   = @uf_man
	,	'ivp_hoy'   	   = @ivp_hoy
	,	'ivp_man'   	   = @ivp_man
	,	'do_hoy'    	   = @do_hoy
	,	'do_man'    	   = @do_man
	,	'da_hoy'    	   = @da_hoy
	,	'da_man'    	   = @da_man
	,	'Nombre_entidad' 	   = @Nombre_entidad
	,	'rut_empresa' 	   = @rut_empresa
	,	'hora'      	   = @hora
        ,       'FECHA_EMISION'    = CONVERT( CHAR(10) , GETDATE() , 103)
        ,       'HORA_EMISION'     = CONVERT( CHAR(8)  , GETDATE() , 108)
        ,       'FECHA_PROC'       = CONVERT( CHAR(10) , (SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES) , 103)
        ,       'FECHA_FILTRO'     = CONVERT( CHAR(10) , @FECHA ,103 )
        ,       'PLAZO_CARTERA'    = ( SELECT CS.nombre_carterasuper FROM VIEW_CATEGORIA_CARTERASUPER CS WHERE CS.codigo_carterasuper =  a.codigo_carterasuper )
        ,       'PLAZO_PACTO'      = ( CASE WHEN ( a.morutcli = 97029000  ) THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 7 )
                                                   WHEN DATEDIFF(DD,a.mofecinip,a.mofecvenp)  >= 0    AND DATEDIFF(DD,a.mofecinip,a.mofecvenp)   < 30  THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 3 )
                                                   WHEN DATEDIFF(DD,a.mofecinip,a.mofecvenp)  >= 30   AND DATEDIFF(DD,a.mofecinip,a.mofecvenp)  <= 89  THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 4 )
                                                   WHEN DATEDIFF(DD,a.mofecinip,a.mofecvenp)  >= 90   AND DATEDIFF(DD,a.mofecinip,a.mofecvenp)  <= 365 THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 5 )
                                             WHEN DATEDIFF(DD,a.mofecinip,a.mofecvenp)  >= 366  THEN ( SELECT descripcion FROM VIEW_PLAZO_PACTO WHERE codigo_plazo = 6 )
                                            END )

        ,       'TIPO_CLIENTE'     =    ISNULL((CASE  WHEN cltipcli   = 2 or cltipcli   = 3 or cltipcli   = 4 or cltipcli   = 5 
                                                                  THEN (SELECT descripcion
                                                                          FROM VIEW_TIPO_CLIENTE
                                                                         WHERE codigo_tipo_cliente= 2)
                                                                   ELSE (SELECT descripcion
                                                                           FROM VIEW_TIPO_CLIENTE
                                                                          WHERE codigo_tipo_cliente = cltipcli)
                                                        END),' ')

        ,       'TIPO_EMISOR'      =    ISNULL(( SELECT glosa
                                                         FROM VIEW_TIPO_EMISOR, VIEW_EMISOR
                                                         WHERE codigo_tipo  = emtipo 
                                                         AND   emrut        = a.morutemi) ,' ') 
        ,       'titulo'           =   'MOVIMIENTO DIARIO DE VENTAS CON PACTO ' 
        ,       'Titulo2'          =    ' AL ' + CONVERT(CHAR(10),@fecha,103)
        ,       'TIPO'             = motipoper
        ,       'Clave_Dcv'        = moclave_dcv

        INTO    #TEMPH
	FROM    MOVIMIENTO_TRADER	                    a
	,	VIEW_CLIENTE	            c
	,	VIEW_ENTIDAD	            r
	,	VIEW_EMISOR	            e
	,	VIEW_INSTRUMENTO	    i
	,	VIEW_FORMA_DE_PAGO          p1
	,	VIEW_FORMA_DE_PAGO	    p2
	,	VIEW_MONEDA	            m1
	,	VIEW_MONEDA	            m2

       	WHERE  	a.motipoper                      in('VI', 'VIX')
	AND 	a.mostatreg                       = ' '
	AND   	r.rcrut                           =  a.morutcart
	AND	(c.clrut                          =  a.morutcli 
	AND   	c.clcodigo                        =  a.mocodcli)
	AND     e.emrut                           =*a.morutemi  
	AND     i.incodigo                        =  a.mocodigo  
	AND     m1.mncodmon                       =*a.momonemi
	AND	m2.mncodmon                       = a.momonpact
	AND     p1.codigo                         = a.moforpagi
	AND     p2.codigo                         = a.moforpagv
        AND     CONVERT(CHAR(10),a.mofecpro,103)  = CONVERT(CHAR(10),@FECHA,103) 

   SELECT * FROM #TEMPH

   END ELSE
   BEGIN

        SELECT  'nomcli'	   = ' '
        ,       'noment'	   = ' '
	,       'numdocu'	   = ' '
        ,       'instrumento'	   = ' '
        ,       'emisor'	   = ' '
        ,       'fecven'	   = ' '
	,       'moneda'	   = ' '
	,       'nominal'	   = 0.0
        ,       'tirventa'	   = 0.0
        ,       'pvp'		   = 0.0
	,       'valorventa'	   = 0.0
	,       'fechaini'	   = ' '
        ,       'fecvtop'	   = ' '
        ,       'tasapact'	   = 0.0
        ,       'monpacto'	   = 0
        ,       'valinip'	   = 0.0
        ,       'valorven'	   = 0.0
        ,       'familia'	   = ' '
	,       'numoper'	   = 0
	,       'sw'		   = '0'
        ,       'base'             = ' '
        ,       'basepacto'        = ' '
        ,       'diaspacto'        = ' '
        ,       'pagoinicio'       = ' '
        ,       'pagovencimiento'  = ' '
      	,       'Fecha_proceso'    = @Fecha_proceso
	,       'Fecha_proxima'    = @Fecha_proxima
	,	'uf_hoy'    	   = @uf_hoy
	,	'uf_man'    	   = @uf_man
	,	'ivp_hoy'   	   = @ivp_hoy
	,	'ivp_man'   	   = @ivp_man
	,	'do_hoy'    	   = @do_hoy
	,	'do_man'    	   = @do_man
	,	'da_hoy'    	   = @da_hoy
	,	'da_man'    	   = @da_man
	,	'Nombre_entidad'   = @Nombre_entidad
	,	'rut_empresa' 	   = @rut_empresa
	,	'hora'      	   = @hora
        ,       'FECHA_EMISION'    = CONVERT( CHAR(10) , GETDATE() , 103)
        ,       'HORA_EMISION'     = CONVERT( CHAR(8)  , GETDATE() , 108)
        ,       'FECHA_PROC'       = CONVERT( CHAR(10) , (SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES) , 103)
        ,       'FECHA_FILTRO'     = CONVERT( CHAR(10) , @FECHA ,103 )
        ,       'PLAZO_CARTERA'    = ' '
        ,       'PLAZO_PACTO'      = ' '
        ,       'TIPO_CLIENTE'     = ' '
        ,       'TIPO_EMISOR'      = ' '
        ,       'titulo'           = 'MOVIMIENTO DIARIO DE VENTAS CON PACTO ' 
        ,       'Titulo2'          = ' AL ' + CONVERT(CHAR(10),@fecha,103)
        ,       'TIPO'             = '     '
        ,       'Clave_Dcv'        = CONVERT(CHAR(12),'')

END

  SET NOCOUNT OFF

END

GO
