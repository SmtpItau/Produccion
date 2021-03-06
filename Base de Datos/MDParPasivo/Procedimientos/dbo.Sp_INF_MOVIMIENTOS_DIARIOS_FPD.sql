USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_INF_MOVIMIENTOS_DIARIOS_FPD]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_INF_MOVIMIENTOS_DIARIOS_FPD]
               ( @entidad         NUMERIC(9) ,
                 @producto        VARCHAR(5) ,
                 @fechacontrol_X  CHAR(10)   ,
                 @tipo            CHAR(2)
               )

AS
BEGIN

SET DATEFORMAT dmy

   DECLARE @fechacontrol DATETIME
   SELECT  @fechacontrol = CONVERT(DATETIME, @fechacontrol_X ,112)
   DECLARE @AuxTipo      CHAR(15)
   SELECT  @AuxTipo = case @tipo 
                      when 'T' then  'TRANSABLE'
                      ELSE 'PERMANENTE' END



    
SET NOCOUNT ON

   DECLARE  @Fecha_proceso      CHAR(10)
   ,        @Fecha_proxima      CHAR(10)
   ,        @uf_hoy         FLOAT
   ,        @uf_man         FLOAT
   ,        @ivp_hoy        FLOAT
   ,        @ivp_man        FLOAT
   ,        @do_hoy         FLOAT
   ,        @do_man         FLOAT
   ,        @da_hoy         FLOAT
   ,        @da_man         FLOAT
   ,        @Nombre_entidad      CHAR(40)
   ,        @rut_empresa    CHAR(12)
   ,        @hora           CHAR(8)
   ,        @fecha_busqueda DATETIME 

  SELECT    @fecha_busqueda= @fechacontrol

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
	
	SELECT @ncartini  = @entidad 
	SELECT @ncartfin  = CASE @entidad WHEN 0 THEN 999999999 ELSE @entidad END





 IF EXISTS(SELECT *   FROM VIEW_DATOS_GENERALES, 
		           MOVIMIENTO_TRADER, 

		           VIEW_MONEDA , 
		           VIEW_ENTIDAD MDRC, 
		           VIEW_CLIENTE, 
		           VIEW_INSTRUMENTO,
		           VIEW_FORMA_DE_PAGO
	             WHERE motipoper	              =  @producto
	              and  mostatreg	              =  " "
	              and  MDRC.rcrut                 =  MOVIMIENTO_TRADER.morutcart
                      and  MOVIMIENTO_TRADER.mofecpro              =  @fechacontrol
                      and  momonpact	              =  mncodmon 
                      and (morutcli	              =  clrut 
                      and  mocodcli	              =  clcodigo )
                      and  mocodigo	              =  incodigo

                      and  VIEW_FORMA_DE_PAGO.codigo  =  moforpagv
	              and (MOVIMIENTO_TRADER.morutcart             >= @ncartini
	              and  MOVIMIENTO_TRADER.morutcart             <= @ncartfin))
         BEGIN
       	   SELECT  
                'Fecha_proceso' = @Fecha_proceso
	      , 'Fecha_proxima' = @Fecha_proxima
	      ,	'uf_hoy'    	= @uf_hoy
	      ,	'uf_man'    	= @uf_man
	      ,	'ivp_hoy'   	= @ivp_hoy
	      ,	'ivp_man'   	= @ivp_man
	      ,	'do_hoy'    	= @do_hoy
	      ,	'do_man'    	= @do_man
	      ,	'da_hoy'    	= @da_hoy
	      ,	'da_man'    	= @da_man
	      ,	'Nombre_entidad'= @Nombre_entidad
	      ,	'rut_empresa' 	= @rut_empresa
	      ,	'hora'      	= @hora
	      ,	'nomemp'	= isnull(VIEW_DATOS_GENERALES.Nombre_entidad,'')
	      ,	'rutemp'	= isnull(rtrim(convert(char(9),Rut_entidad))+'-'+Digito_entidad,'')
	      ,	'fecpro'	= isnull(convert(char(10),Fecha_proceso,103),'')
	      ,	'nomcli'	= isnull(clnombre,'')
	      ,	'nomemp'	= isnull(rcnombre,'')
              , 'numdocu'       = REPLICATE('0', 07 - LEN(LTRIM(STR(monumdocu)))) + LTRIM(STR(monumdocu)) + '-' +
                                  REPLICATE('0', 03 - LEN(LTRIM(STR(mocorrela)))) + LTRIM(STR(mocorrela))
	      ,	'numoper'	= isnull(monumoper,0)
	      ,	'instrumento'	= case when moinstser = 'ICOL' then 'COL'
				       when moinstser = 'ICOLX' then 'COLX'
                                       when moinstser = 'ICAP' then 'CAP'
                                       when moinstser = 'ICAPX' then 'CAPX'   end
	      ,	'plazo'		= convert(numeric(4,0),datediff(dd,mofecinip,mofecvenp))
	      ,	'fecven'	= isnull(convert(char(10),mofecven,103),'')
	      ,	'moneda'	= isnull(mnnemo,'')

	      ,	'base'		= convert(numeric(3,0),mobaspact)
	      ,	'valor'		= 0

              , 'valinicial'    = isnull(movalinip,0) 
	      ,	'tasapacto'	= CONVERT(NUMERIC(09,4),motaspact)
	      ,	'valfinal'	= CONVERT(NUMERIC(19,4),movalvenp)
	      ,	'pagoinicio'	= (SELECT glosa2 FROM VIEW_FORMA_DE_PAGO WHERE codigo	= moforpagi)
              , 'pagofinal'	= (SELECT glosa2 FROM VIEW_FORMA_DE_PAGO WHERE codigo	= moforpagv)
	      ,	'tippago'	= CASE mopagohoy WHEN 'N' THEN 'PAGO MAÑANA' ELSE '' END

	      ,	'serie'		= isnull(inserie,'')
              , 'tir'           = isnull(motir,0)
              , 'interes'       = isnull(mointeres,0)
              ,  'valornominal' = CASE WHEN momonemi <> 999 AND mnextranj <> 0  THEN
                                   isnull(monominal,0) * ISNULL((SELECT vmvalor 
                                                                   FROM VIEW_VALOR_MONEDA 
                                                                   WHERE vmcodigo = momonemi AND vmfecha = mofecemi),0)
                                  ELSE monominal END
       	   , 	'glosa_instru'	= CASE WHEN moinstser = 'ICOL' THEN 'COLOCACION' 
                                       WHEN moinstser = 'ICOLX'THEN 'COLOCACION EN MX'   
                                       WHEN moinstser = 'ICAP' THEN 'CAPTACION'  
                                       WHEN moinstser = 'ICAPX' THEN 'CAPTACION EN MX'   END
           ,    'titulo'        = CASE WHEN @producto = 'FPD'  THEN 'INFORME DE OPERACIONES FACILIDAD PERMANENTE DE DEPOSITO ' 
                                       ELSE ' '
                                   END
           ,    'TITULO2'       = 'AL ' + CONVERT(CHAR(10),@fechacontrol,103)


	FROM	VIEW_DATOS_GENERALES, 
		MOVIMIENTO_TRADER, 
		VIEW_MONEDA , 
		VIEW_ENTIDAD MDRC,  
		VIEW_CLIENTE, 
		VIEW_INSTRUMENTO
	WHERE	motipoper	= @producto
	and	mostatreg	= " "
	and   	MDRC.rcrut     	= MOVIMIENTO_TRADER.morutcart
        and     CONVERT(CHAR(10),MOVIMIENTO_TRADER.mofecpro,103)= CONVERT(CHAR(10),@fechacontrol,103)
        and 	momonpact	= mncodmon 
        and 	(morutcli	= clrut 
        and 	mocodcli	= clcodigo )
        and 	mocodigo	= incodigo

        and     (MOVIMIENTO_TRADER.morutcart >= @ncartini
	and     MOVIMIENTO_TRADER.morutcart  <= @ncartfin)
      ORDER BY 	monumoper 


     END ELSE
     BEGIN     
	   SELECT  
                'Fecha_proceso' 	= @Fecha_proceso                                                    ,                           
	        'Fecha_proxima' 	= @Fecha_proxima                                                    ,
		'uf_hoy'    	= @uf_hoy                                                       ,
		'uf_man'    	= @uf_man                                                       ,   
		'ivp_hoy'   	= @ivp_hoy                                                      ,    
		'ivp_man'   	= @ivp_man                                                      , 
		'do_hoy'    	= @do_hoy                               ,
		'do_man'    	= @do_man                                                       ,   
		'da_hoy'    	= @da_hoy                                                       ,
		'da_man'    	= @da_man                                                       ,      
		'Nombre_entidad' 	= @Nombre_entidad                                                    ,
		'rut_empresa' 	= @rut_empresa                                                  , 
		'hora'      	= @hora                                                         ,
		'nomemp'	= ''                     					,
		'rutemp'	= ''	,
		'fecpro'	= ''			,
		'nomcli'	= ''						,
		'nomemp'	= ''						,
                'numdocu'       = '',
		'numoper'	= ''						,
		'instrumento'	= ''	,
		'plazo'		= ''		,
		'fecven'	= '',
		'moneda'	= '',
		'base'		= '',
		'valor'		= '',
		'valinicial'	= '',
		'tasapacto'	= '',
		'valfinal'	= '',
		'pagoinicio'	= '', 
                'pagofinal'	= '', 
		'tippago'	= '',

		'serie'		= ''                                            ,
                'tir'           = ''                                               ,
                'interes'       = ''                                           ,
                'valornominal'  = ''                                      ,
		'glosa_instru'	= ''                           ,
                'titulo'        = CASE WHEN @producto = 'FPD'  THEN 'INFORME DE OPERACIONES FACILIDAD PERMANENTE DE DEPOSITO ' 
                                       ELSE ' '
                                   END
           ,    'TITULO2'       = 'AL ' + CONVERT(CHAR(10),@fechacontrol,103)

         END
           



SET NOCOUNT OFF

END


GO
