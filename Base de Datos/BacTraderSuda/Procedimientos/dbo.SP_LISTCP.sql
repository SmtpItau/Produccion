USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTCP]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTCP]	
(
	@entidad        FLOAT,
	@carterasuper	CHAR(01),
	@titulo		    VARCHAR(200),
	@Cartera_Inv	CHAR(06),
	@Cat_Libro	    CHAR(06),
	@Cat_CartFin	CHAR(06),
	@Id_Libro	    CHAR(06)
)
AS

BEGIN

	DECLARE @acfecproc     CHAR (10),
	        @acfecprox     CHAR (10),
            @uf_hoy        FLOAT,
            @uf_man        FLOAT,
            @ivp_hoy       FLOAT,
            @ivp_man       FLOAT,
            @do_hoy        FLOAT,
            @do_man        FLOAT,
            @da_hoy        FLOAT,
            @da_man        FLOAT,
            @acnomprop     CHAR(40),
            @rut_empresa   CHAR(12),
            @hora          CHAR(8),
	        @Glosa_Cartera CHAR(20),
	        @Glosa_Libro   CHAR(50)

	IF @Cartera_Inv = ''

		Select @Glosa_Cartera = '< TODAS >'

	ELSE

		SELECT @Glosa_Cartera = ISNULL(TBGLOSA,'')
		  FROM VIEW_TABLA_GENERAL_DETALLE
		 WHERE TBCATEG		= @Cat_CartFin
		   AND TBCODIGO1	= @Cartera_INV


	IF @Id_Libro = '' 
		
		SELECT @Glosa_Libro = '< TODOS >'
	
	ELSE 
	  	SELECT @Glosa_Libro = tbglosa 
		  FROM VIEW_TABLA_GENERAL_DETALLE 
		 WHERE tbcateg   = @Cat_Libro 
		   AND tbcodigo1 = @Id_Libro


 EXECUTE Sp_Base_Del_Informe
              @acfecproc   OUTPUT    ,
              @acfecprox   OUTPUT    ,
              @uf_hoy      OUTPUT    ,
              @uf_man      OUTPUT    ,
              @ivp_hoy     OUTPUT    ,
              @ivp_man     OUTPUT    ,
              @do_hoy      OUTPUT    ,
              @do_man      OUTPUT    ,
              @da_hoy      OUTPUT    ,
              @da_man      OUTPUT    ,
              @acnomprop   OUTPUT    ,
              @rut_empresa OUTPUT    ,
              @hora  OUTPUT
      
 SET NOCOUNT ON


 IF EXISTS(SELECT 1 
             FROM MDMO 
			WHERE motipoper='CP' 
			  AND mostatreg <> 'A' 
			  AND codigo_carterasuper = @carterasuper 
			  AND (id_libro = @id_libro OR @id_libro = '') ) 
 
	BEGIN

		SELECT 'clnombre'           = ISNULL(clnombre,''),
               'rcnombre'           = ISNULL(rcnombre,''),
               'tbglosa'            = ISNULL(VIEW_TABLA_GENERAL_DETALLE.tbglosa,''),
			   'numcorrela'         = ISNULL(RTRIM(CONVERT(CHAR(7),monumoper)) + '-' + CONVERT(CHAR(3),mocorrela),''),
               'moinstser'          = ISNULL(moinstser,''),
               'emgeneric'          = CASE WHEN mocodigo = 98 THEN ( SELECT clgeneric FROM view_cliente WHERE clrut=morutcli AND clcodigo=mocodcli )
                                      ELSE ( SELECT emgeneric FROM view_emisor WHERE emrut=morutemi )
                                      END,
               'mofecemi'           = ISNULL(CONVERT(CHAR(10),mofecemi,103),'') ,
               'mofecven'           = CASE WHEN moinstser='FMUTUO' OR mofecven='19000101' THEN ' '
                                      ELSE ISNULL(CONVERT(CHAR(10),mofecven,103),'')
                                      END,
               'motasemi'           = ISNULL(motasemi,0),
               'mobasemi'           = ISNULL(mobasemi,0),
               'mnnemo'             = ISNULL(mnnemo,''),
               'monominal'          = ISNULL(monominal,0),
               'motir'              = ISNULL(motir,0),
               'mopvp'              = ISNULL(mopvp,0),
               'motasest'           = ISNULL(motasest,0),
               'movalcomp'          = ISNULL(movalcomp,0),
               'movalcomu'          = ISNULL(movalcomu,0),
               'glosa'              = ISNULL(VIEW_FORMA_DE_PAGO.glosa,''),
               'motipobono'         = CASE motipobono WHEN 'S' THEN 'SECUNDARIO' ELSE 'PRIMARIO' END,
               'propia'             = 'propia', 
               'mopagohoy'          = CASE mopagohoy WHEN 'N' THEN 'PAGO MAÑANA' ELSE ' ' END,
               'monumoper'          = ISNULL(monumoper,0),
               'mocorrela'          = ISNULL(mocorrela,0),
               'acrutpropagdigprop' = ISNULL(RTRIM(CONVERT(CHAR(9),acrutprop))+'-'+acdigprop,''),
               'inserie'            = CASE
                                      WHEN mocodigo=20 AND motipoletra='V' THEN 'LCHR VIV'
                                      WHEN mocodigo=20 AND motipoletra='F' THEN 'LCHR F.GEN'
                                      WHEN mocodigo=20 AND motipoletra='E' THEN 'LCHR ESTA'
                                      WHEN mocodigo=20 AND motipoletra='O' THEN 'LCHR OTROS'
                                      ELSE inserie
                                      END,
               'sw'                 = '0',
               'titulo'             = @titulo,
		       'prima'              = ISNULL(moprimadesc,0)                                ,
		       'Tipo_Moneda'        = CASE WHEN mnmx = 'C' THEN '0' ELSE '1' END		,
		       'Tipo_Cart'	        = (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Cat_CartFin AND TBCODIGO1 =  LTRIM(RTRIM(CONVERT(CHAR,motipcart)))),
		       'Tipo_InV'		    =  @Glosa_Cartera	,
		       'libro'		        = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND tbcodigo1 = MDMO.id_libro),''),
		       'Glosa_libro'	    = @Glosa_Libro	,
		       'TasaTran'		    = moTirTran	,
		       'PvpTran'		    = moPvpTran	,
		       'VpTran'		        = moVPTran,
		       'RazonSocial'        = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
          INTO #TEMP
          FROM MDAC, MDMO 
		           LEFT JOIN
			   (SELECT	Id = cf.tbcodigo1, Glosa = cf.tbglosa
				  FROM	BacParamSuda..TIPO_CARTERA tc
						    INNER JOIN
						(SELECT	tbcodigo1, tbglosa
						   FROM	bacparamsuda.dbo.tabla_general_detalle WITH(NOLOCK) 
						  WHERE	tbcateg = 204
						)cf	ON cf.tbcodigo1	= tc.rcrut
				WHERE	tc.rcsistema = 'BTR'
				AND		tc.rccodpro='CP'
			   )	cfrf	ON cfrf.Id	= MDMO.motipcart
			 , VIEW_CLIENTE, VIEW_ENTIDAD, VIEW_MONEDA, VIEW_TABLA_GENERAL_DETALLE, 
             VIEW_INSTRUMENTO, VIEW_FORMA_DE_PAGO 
        WHERE motipoper='CP'
              AND mostatreg    <> 'A'
              AND rcrut        = morutcart
              AND (clrut       = morutcli AND clcodigo   =   mocodcli)
              AND mncodmon     = momonemi
              AND (tbcateg     = @Cat_CartFin AND tbcodigo1 = LTRIM(RTRIM(CONVERT(CHAR,motipcart))) )
              AND incodigo     = mocodigo
              AND codigo       = moforpagi
              AND (codigo_carterasuper   =   @carterasuper)
              AND (morutcart   = @entidad OR @entidad=0) 
       	      AND (LTRIM(RTRIM(CONVERT(CHAR,motipcart)))   =  @Cartera_INV or @Cartera_INV = 0)
       	      AND (MDMO.id_libro = @id_libro OR @id_libro= '' )
	      AND CONVERT(CHAR(10),mofecpro,103) = @acfecproc 
        ORDER BY monumoper, mocorrela

	SELECT	inserie	, 
		'monominal'	= SUM(monominal) ,
		'movalcomu'	= SUM(movalcomu) ,
		'movalcomp'	= SUM(movalcomp) ,
		'tir'		= SUM(movalcomp * moTir)     / SUM(movalcomp) ,
		'PromTasaTran'	= SUM(movalcomp * TasaTran)  / SUM(movalcomp) ,
		'TotVpTran'	= SUM(VpTran)	 ,
		mnnemo
	INTO #TOTAL  
	FROM #TEMP  
	GROUP
	BY	inserie
	,	mnnemo

	INSERT INTO #TEMP
        SELECT ''        ,
               ''        ,
               ''        ,
               ''        ,
               inserie   ,  -- Instrumento
               ''        ,
               ''        ,
               ''        ,
               0         ,
               0         ,
               mnnemo    ,
               monominal ,-- Total por Instrumento, hecho arriba en 'group by'
               tir       ,
               0         ,
               0         ,
               movalcomp ,
               movalcomu ,
               ''        ,
               'TOTAL'   ,
               'total'   ,
               ''        ,
               0         ,
               0         ,
               ''        ,
               'TOTAL'   ,
               'sw'='1'  ,
               'RESUMEN ' + @titulo,
	       0         ,
               ''	 ,
	       '' 	 ,
	       @Glosa_Cartera		 ,
	       ''			 ,
	       @Glosa_Libro		 ,
	       PromTasaTran		 ,
	       0			 ,
	       TotVpTran,
		   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
	FROM #TOTAL


	IF EXISTS(SELECT TOP 1 * FROM #TEMP)

	BEGIN

	  SELECT clnombre     ,
         rcnombre     ,
         tbglosa      ,
         numcorrela   ,
         moinstser    ,
         emgeneric    ,
         mofecemi     ,
         mofecven     ,
         motasemi     ,
         mobasemi     ,
         mnnemo       ,
         monominal    ,         motir        ,
         mopvp        ,
         motasest     ,
         movalcomp    ,
         movalcomu    ,
         glosa        ,
         motipobono   ,
         propia       ,
         mopagohoy    ,--case MDMO.mopagohoy when 'N' then 'PAGO MA_ANA' else ' ' end
         monumoper    ,
         mocorrela    ,
         acrutpropagdigprop           ,
         inserie                      ,
         'acfecproc' = @acfecproc     ,
         'acfecprox' = @acfecprox     ,
         'uf_hoy'    = @uf_hoy        ,
         'uf_man'    = @uf_man        ,
         'ivp_hoy'   = @ivp_hoy       ,
         'ivp_man'   = @ivp_man       ,
         'do_hoy'    = @do_hoy        ,
         'do_man'    = @do_man        ,
         'da_hoy'    = @da_hoy        ,
         'da_man'    = @da_man        ,
         'acnomprop' = @acnomprop     ,
         'rut_empresa' = '' ,
         'hora'      = ''          ,
         sw                           ,
         titulo			      ,
	 prima      		      ,
         Tipo_Moneda		      ,	
	 Tipo_Cart  		      ,
	 Tipo_INV		      ,
	 libro			      ,
	 Glosa_libro		      ,
	 TasaTran		      ,
	 PvpTran		      ,
	 VpTran           ,
	 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
  FROM #TEMP
  ORDER BY clnombre

	END

	ELSE

	BEGIN

	  SELECT clnombre			= '',
         rcnombre				= '',
         tbglosa				= '',
         numcorrela				= '',
         moinstser				= '',
         emgeneric				= '',
         mofecemi				= '',
         mofecven				= '',
         motasemi				= 0.0,
         mobasemi				= 0.0,
         mnnemo					= '',
         monominal				= 0.0,         
		 motir                  = 0.0,
         mopvp					= 0.0,
         motasest				= 0.0,
         movalcomp				= 0.0,
         movalcomu				= 0.0,
         glosa					= '',
         motipobono				= '',
         propia					= '',
         mopagohoy				= '',--case MDMO.mopagohoy when 'N' then 'PAGO MA_ANA' else ' ' end
         monumoper				= 0,
         mocorrela				= 0,
         acrutpropagdigprop	    = '',
         inserie				= '',
         'acfecproc'			= '',
         'acfecprox'			= '',
         'uf_hoy'				= 0,
         'uf_man'				= 0,
         'ivp_hoy'				= 0,
         'ivp_man'				= 0,
         'do_hoy'				= 0,
         'do_man'				= 0,
         'da_hoy'				= 0,
         'da_man'				= 0,
         'acnomprop'			= '',
         'rut_empresa'			= '',
         'hora'					= '',
         sw                     = '0' ,
         titulo			        = '',
	     prima    		        = 0.0,
         Tipo_Moneda		    = '',	
	     Tipo_Cart  		    = '',
	     Tipo_INV		        = '',
	     libro			        = '',
	     Glosa_libro		    = '',
	     TasaTran		        = 0,
	     PvpTran		        = 0,
	     VpTran                 = 0,
	    'RazonSocial'           = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)


	END


 END 
 
 ELSE 
 begin
	  SELECT 'clnombre'          = '                      ' ,
         'rcnombre'          = ' '                      ,
         'tbglosa'           = ' '                      ,
         'numcorrela'        = '             '      ,
         'moinstser'         = '              '        ,
 	 'emgeneric'         = '              '        ,
         'mofecemi'          = ' '                     ,
         'mofecven'          = '          '            ,
         'motasemi'          = 0.0                      ,
         'mobasemi'          = 0.0                      ,
         'mnnemo'            = '            '           ,
         'monominal'         = 0.0                      ,
         'motir'             = 0.0                      ,
         'mopvp'             = 0.0                      ,
         'motasest'          = 0.0                      ,
         'movalcomp'         = 0.0                      ,
         'movalcomu'         = 0.0                      ,
         'glosa'             = ' '                      ,
         'motipobono'        = ' '                      ,
         'propia'            = ' '                      , 
         'mopagohoy'         = ' '                      ,
         'monumoper'         = 0                        ,
         'mocorrela'         = 0                        ,
         'acrutpropagdigprop' = ' '                     ,
         'inserie'              = ' '                   ,
         'acfecproc'        = @acfecproc                ,
         'acfecprox'        = @acfecprox                ,
         'uf_hoy'           = @uf_hoy                   ,
         'uf_man'           = @uf_man                   ,
         'ivp_hoy'          = @ivp_hoy                  ,
         'ivp_man'          = @ivp_man                  ,
         'do_hoy'           = @do_hoy                   ,
         'do_man'           = @do_man                   ,
         'da_hoy'           = @da_hoy                   ,
         'da_man'           = @da_man                   ,
         'acnomprop'        = @acnomprop                ,
         'rut_empresa'      = @rut_empresa              ,
         'hora'             = @hora                     ,
         sw                 =  '0'                      ,
         'titulo'           = @Titulo			,
	 'prima'            = 0.0                       ,
         'Tipo_Moneda'      = ''			,
	 'Tipo_Cart'	    = ''			,
	 'Tipo_Inv'	    = @Glosa_Cartera		,
	 'libro'	    = ''			,
	 'Glosa_libro'	    = @Glosa_Libro		,
	 'tir'		    = 0				,
	 'PromTasaTran'	    = 0				,
	 'TotVpTran'	    = 0     ,
	 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)

	 end


  SET NOCOUNT OFF 
END

GO
