USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTFLI]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SP_LISTFLI 0, 'MOVIMIENTO DIARIO DE FACILIDAD DE LIQUIDEZ INTRADÍA', 1552, ''

CREATE PROCEDURE [dbo].[SP_LISTFLI] 
   (
   @entidad FLOAT		,
   @titulo  VARCHAR (200) = ''	,
   @Cat_Libro	CHAR(06)  = ''	,
   @Id_Libro	CHAR(06)  = ''
   )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE 	@acfecproc CHAR (10) ,
  		@acfecprox CHAR (10) ,
		@uf_hoy  FLOAT  ,
  		@uf_man  FLOAT  ,
  		@ivp_hoy FLOAT  ,
  		@ivp_man FLOAT  ,
  		@do_hoy  FLOAT  ,
  		@do_man  FLOAT  ,
  		@da_hoy  FLOAT  ,
  		@da_man  FLOAT  ,
  		@acnomprop CHAR (40) ,
  		@rut_empresa CHAR (12) ,
  		@hora  CHAR (08)	,
		@Glosa_Libro	CHAR(50)

 EXECUTE Sp_Base_Del_Informe
  		@acfecproc OUTPUT  ,
  		@acfecprox OUTPUT  ,
  		@uf_hoy  OUTPUT  ,
  		@uf_man  OUTPUT  ,
  		@ivp_hoy OUTPUT  ,
  		@ivp_man OUTPUT  ,
  		@do_hoy  OUTPUT  ,
  		@do_man  OUTPUT  ,
  		@da_hoy  OUTPUT  ,
  		@da_man  OUTPUT  ,
  		@acnomprop OUTPUT  ,
  		@rut_empresa OUTPUT  ,
  		@hora  OUTPUT

		-- FUSION ---
		SET @acnomprop       = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
		-------------

 DECLARE @ncartini NUMERIC (10,0) ,  @ncartfin NUMERIC (10,0)
 
 SELECT @ncartini = @entidad 
 SELECT @ncartfin = CASE @entidad WHEN 0 THEN 999999999 ELSE @entidad END

  IF  @id_libro = '' BEGIN
	SELECT @Glosa_libro = '< TODOS >'	
  END 
  ELSE BEGIN
	SELECT	@Glosa_libro	= tbglosa
	FROM	VIEW_TABLA_GENERAL_DETALLE
	WHERE	tbcateg		= @Cat_Libro 
	AND	tbcodigo1	= @Id_Libro
  END



  SELECT 	'nomcli' = ISNULL(clnombre , '')        ,--1
   		'noment' = ISNULL(rcnombre , '')        ,--2
   		'numdocu' = ISNULL(RTRIM(CONVERT(CHAR(10),monumdocu))+'-'+CONVERT(CHAR(3),mocorrela),'') ,--3
   		'instrumento' = ISNULL(moinstser, '')        ,--4
   		'emisor' = ISNULL(emgeneric, '')        ,--5
   		'fecven' = ISNULL(CONVERT(CHAR(10),mofecven,103),'')     ,--6
   		'moneda' = ISNULL(m1.mnnemo,'')        ,--7
   		'nominal' = ISNULL(monominal,0)        ,--8
   		'tirventa' = ISNULL(motir,0)        ,--9
   		'pvp'  = ISNULL(mopvp,0)        ,--10
   		'valorventa' = ISNULL(movpresen,0)          ,--11
   		'fechaini' = ISNULL(CONVERT(CHAR(10),mofecinip,103),'')     ,--12
   		'fecvtop' = ISNULL(CONVERT(CHAR(10),mofecvenp,103),'')     ,--13
   		'tasapact' = ISNULL(motaspact,0)        ,--14
   		'monpacto' = ISNULL(m2.mnnemo,'')        ,--15
   		'valinip' = ISNULL(movalinip,0)        ,--16
   		'valorven' = ISNULL(movalvenp,0)        ,--17
   		'familia' = ISNULL(inserie,'')        ,--18
   		'numoper' = ISNULL(CONVERT(CHAR(10),monumoper),'')        ,--19
   		'sw'  = '0'          ,--20
   		'titulo' = @titulo         ,--21
   		'plazo'  = CONVERT(NUMERIC(19,4),DATEDIFF(DAY,mofecinip,mofecvenp))   ,--22
   		'FormaPagoIni'  = p1.glosa,
		'tipoper' = 'FLI '	,
		'libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND tbcodigo1 = MDMO.id_libro),'') ,
		'Glosa_libro'	= @Glosa_Libro
  	INTO #TEMP
  	FROM  MDMO LEFT OUTER JOIN VIEW_EMISOR ON emrut = morutemi  
			   LEFT OUTER JOIN VIEW_MONEDA m1 ON m1.mncodmon = momonemi ,
		  VIEW_CLIENTE, VIEW_ENTIDAD
		, VIEW_INSTRUMENTO
		, VIEW_FORMA_DE_PAGO p1
		, VIEW_FORMA_DE_PAGO p2 
		, VIEW_MONEDA m2
	WHERE motipoper='FLI' 
	      AND mostatreg<>'A' 
	      AND rcrut=morutcart 
	      AND (clrut=morutcli 
   	      AND clcodigo=mocodcli) 
	      AND incodigo=mocodigo 
	      AND m2.mncodmon=momonpact 
 	      AND p1.codigo=moforpagi 
	      AND p2.codigo=moforpagv 
	      AND(morutcart>=@ncartini 
	      AND morutcart<=@ncartfin)
	      AND (MDMO.id_libro	= @id_libro	OR @id_libro	= '')

--  	FROM MDMO, VIEW_CLIENTE, VIEW_ENTIDAD, VIEW_EMISOR, VIEW_INSTRUMENTO,
--	     VIEW_FORMA_DE_PAGO p1, VIEW_FORMA_DE_PAGO p2 , VIEW_MONEDA m1, VIEW_MONEDA m2
--	WHERE motipoper='FLI' 
--	      AND mostatreg<>'A' 
--	      AND rcrut=morutcart 
--	      AND (clrut=morutcli 
--   	      AND clcodigo=mocodcli) 
--	      AND emrut=*morutemi 
--	      AND incodigo=mocodigo 
--	      AND m1.mncodmon=*momonemi 
--	      AND m2.mncodmon=momonpact 
-- 	      AND p1.codigo=moforpagi 
--	      AND p2.codigo=moforpagv 
--	      AND(morutcart>=@ncartini 
--	      AND morutcart<=@ncartfin)
--	      AND (MDMO.id_libro	= @id_libro	OR @id_libro	= '')


	-- SE DEBE MODIFICAR LA ESTRUCTURA DE LAS TABLAS DE MOVIMIENTO Y CARTERA PARA AGREGAR 
	-- EL CODIGO DEL CLIENTE Y ASI PODER MANEJAR LAS SUCURSALES
	INSERT #TEMP
	SELECT 	'nomcli'	= ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = morutcli AND clcodigo = 1) ,'')  
   	,	'noment'	= ISNULL(rcnombre , '')								
   	,	'numdocu'	= ISNULL(RTRIM(CONVERT(CHAR(10),panumdocu))+'-'+CONVERT(CHAR(3),pacorrela),'')	
   	,	'instrumento'	= ISNULL(painstser, '')								
   	,	'emisor'	= ISNULL((SELECT emgeneric FROM VIEW_EMISOR WHERE emrut=morutemi),'')		
   	,	'fecven'	= ISNULL(CONVERT(CHAR(10),mofecven,103),'')					
   	,	'moneda'	= ISNULL((select mnnemo FROM VIEW_MONEDA WHERE mncodmon=pamonemi),'')		
   	,	'nominal'	= ISNULL(panominal,0)								
   	,	'tirventa'	= ISNULL(patir,0)								
   	,	'pvp'		= ISNULL(pvpvent,0)								
   	,	'valorventa'	= ISNULL(pavpresen,0)								
   	,	'fechaini'	= ISNULL(CONVERT(CHAR(10),pafecpro,103),'')					
   	,	'fecvtop'	= ISNULL(CONVERT(CHAR(10),pafecpro,103),'')					
   	,	'tasapact'	= 0.0										
   	,	'monpacto'	= ISNULL((select mnnemo FROM VIEW_MONEDA WHERE mncodmon=pamonpact),'')		
   	,	'valinip'	= ISNULL(pavpresen,0)								
   	,	'valorven'	= ISNULL(pavpresen,0)								
   	,	'familia'	= ISNULL(inserie,'')								
   	,	'numoper'	= ISNULL(RTRIM(CONVERT(CHAR(10),panumoper))+'-'+CONVERT(CHAR(3),panumpago),'')	
   	,	'sw'		= '1'										
   	,	'titulo'	= 'PAGOS '+ @titulo								
   	,	'plazo'		= 0										
   	,	'FormaPagoIni'	= ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo=paforpagi),'')	
        ,	'tipoper'	= 'FLIP'									
	,	'libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND tbcodigo1 = MDMO.id_libro),'') 
	,	'Glosa_libro'	= @Glosa_Libro									
	FROM	PAGOS_FLI
	,	MDMO
	,	VIEW_ENTIDAD
	,	VIEW_INSTRUMENTO
	WHERE	pastatus	<> 'A'
	AND	paptipopago	=  'S' 
	AND	(parutcart	>= @ncartini	AND	parutcart	<= @ncartfin)
	AND	(monumdocu	=  panumdocu	AND	mocorrela	=  pacorrela	AND	monumoper	=  panumoper) 
	AND	(MDMO.id_libro	=  @id_libro	OR	@id_libro	=  '')
	AND	rcrut		=  parutcart
	AND	incodigo	=  pacodigo 


 IF (SELECT COUNT(1) FROM #TEMP ) > 0
 BEGIN
  SELECT 'monpacto1' = monpacto  ,
	 'valinip1' = ROUND(SUM(valinip),0)  ,
	 'valorventa1' = ROUND(SUM(valorventa),0) ,
	 'valorven1' = ROUND(SUM(valorven),0)  ,
	 'plazoprom1' = ROUND(SUM(plazo*valinip) / SUM(valinip),0),
	 'tasaprom1' = SUM(tasapact*valinip) / SUM(valinip)
	  INTO #TOTAL  
	  FROM #TEMP  where tipoper='FLI '
	  GROUP BY monpacto

	  INSERT INTO
	  #TEMP
  SELECT 'TOTAL FLI  '+ CASE
       WHEN monpacto1='CLP' THEN 'PESOS'
       WHEN monpacto1='UF' THEN 'UF'
       ELSE 'DOLAR'
       END,
	   ''    ,
	   ''    ,
	   ''    ,
	   ''    ,
	   ''    ,
	   ''    ,
	   0    , 
	   0    ,
	   0    ,
	   round(valorventa1,0)   ,
	   ''    ,
	   ''    ,
	   tasaprom1   ,
	   monpacto1   ,
	   round(valinip1,0)   ,
	   round(valorven1,0)   ,
	   ''    ,
	   0    ,
	   '2'    ,
	   'RESUMEN '+@titulo  ,
	   plazoprom1   ,
	   ''        ,
           ''		,
	   ''		,
	   @Glosa_Libro
	  FROM #TOTAL
	 
  
  SELECT 'monpacto1' = monpacto  ,
	 'valinip1' = ROUND(SUM(valinip),0)*-1  ,
	 'valorventa1' = ROUND(SUM(valorventa),0)*-1 ,
	 'valorven1' = ROUND(SUM(valorven),0)*-1  ,
	 'plazoprom1' = ROUND(SUM(plazo*valinip) / SUM(valinip),0),
	 'tasaprom1' = SUM(tasapact*valinip) / SUM(valinip)
	  INTO #TOTAL2            
	  FROM #TEMP  where tipoper='FLIP'
	  GROUP BY monpacto

	  INSERT INTO
	  #TEMP
  SELECT 'TOTAL PAGOS FLI '+ CASE
       WHEN monpacto1='CLP' THEN 'PESOS'
       WHEN monpacto1='UF' THEN 'UF'
       ELSE 'DOLAR'
       END,
	   ''    ,
	   ''    ,
	   ''    ,
	   ''    ,
	   ''    ,
	   ''    ,
	   0    ,
	   0    ,
	   0    ,
	   round(valorventa1,0)   ,
	   ''    ,
	   ''    ,
	   tasaprom1   ,
	   monpacto1   ,
	   round(valinip1,0)   ,
	   round(valorven1,0)   ,
	   ''    ,
	   0    ,
	   '2'    ,
	   'RESUMEN PAGOS '+@titulo  ,
	   plazoprom1   ,
	   ''        ,
           ''		,
	   ''		,
	   @Glosa_Libro
	  FROM #TOTAL2
 END

 ELSE
 BEGIN
  INSERT INTO
  #TEMP
	  SELECT ''    ,
		 ''    ,
		 ''    ,
		 ''    ,
		 ''    ,
		 ''    ,
		 ''    ,
		 0     ,
		 0     ,
		 0     ,
		 0     ,
		 ''    ,
		 ''    ,
		 0     ,
		 ''    ,
		 0     ,
		 0     ,
		 ''    ,
		 0     ,
		 '0'   ,
		 @titulo,
		 0    ,
		 ''   ,
		 ''	,
		 ''	,
		 @Glosa_Libro
	 END

	 SELECT nomcli    ,--1
		noment    ,--2
		numdocu   ,--3
		instrumento   ,--4
		emisor    ,--5
		fecven    ,--6
		moneda    ,--7
		nominal   ,--8
		tirventa  ,--9
		pvp    	  ,--10
		'valorventa' = round(valorventa,0),--11
		fechaini  ,--12
		fecvtop   ,--13
		tasapact  ,--14
		monpacto  ,--15
		'valinip' = round(valinip,0)   ,--16
		'valorven' = round(valorven,0)  ,--17
		familia   ,--18
		numoper   ,--19
		FormaPagoIni   ,   
		'acfecproc'  = @acfecproc ,
		'acfecprox'  = @acfecprox ,
		'uf_hoy'     = @uf_hoy ,
		'uf_man'     = @uf_man ,
		'ivp_hoy'    = @ivp_hoy ,
		'ivp_man'    = @ivp_man ,
		'do_hoy'     = @do_hoy ,
		'do_man'     = @do_man ,
		'da_hoy'     = @da_hoy ,
		'da_man'     = @da_man ,
		'acnomprop'  = @acnomprop ,
		'rut_empresa'= @rut_empresa ,
		'hora'       = @hora  ,
		sw    	  ,
		titulo    ,
		plazo		,
		Libro		,
		Glosa_Libro
	  FROM #TEMP
  ORDER BY tipoper,familia,monpacto
  SET NOCOUNT OFF
END
GO
