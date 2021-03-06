USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTIB]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SP_LISTIB 0, 0, 1552, ''

CREATE PROCEDURE [dbo].[SP_LISTIB]
   (
   @entidad 	NUMERIC (9)	,
   @Cartera_Inv Integer		,
   @Cat_Libro	CHAR(06)= ''	,
   @Id_Libro	CHAR(06)= ''
   )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @ncartini 	NUMERIC(10,0) ,
  	 @ncartfin 	NUMERIC(10,0) ,
	 @Glosa_Cartera CHAR   (20)	,
	 @Glosa_libro	CHAR   (50)

	Select @Glosa_Cartera = '' 

   SELECT Distinct
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema = 'BTR'
     And  rcrut     = @Cartera_INV
--	   ORDER BY rcrut REQ.7619 CASS 25-01-2011

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

  			-- FUSION ---
			declare @acnomprop as varchar(60)
			SET @acnomprop       = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
			-------------
 
 SELECT @ncartini = @entidad 
 SELECT @ncartfin = CASE @entidad
     WHEN 0 THEN 999999999
     ELSE @entidad
      END
 SELECT 'pmfecproc' = acfecproc  ,
  'pmfecprox' = acfecprox  ,
  'uf_hoy' = CONVERT(FLOAT,0) ,
  'uf_man' = CONVERT(FLOAT,0) ,
  'ivp_hoy' = CONVERT(FLOAT,0) ,
  'ivp_man' = CONVERT(FLOAT,0) ,
  'do_hoy' = CONVERT(FLOAT,0) ,
  'do_man' = CONVERT(FLOAT,0) ,
  'da_hoy' = CONVERT(FLOAT,0) ,
  'da_man' = CONVERT(FLOAT,0) ,
 -- 'pmnomprop' = acnomprop  ,
  'pmnomprop' = @acnomprop , -- Fusion
  'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop))+'-'+acdigprop
 INTO #PARAMETROS
 FROM MDAC
 
 UPDATE #PARAMETROS
 SET uf_hoy = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA
 WHERE vmfecha=pmfecproc AND vmcodigo=998
 UPDATE #PARAMETROS
 SET uf_man = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA
 WHERE vmfecha=pmfecprox AND vmcodigo=998
 UPDATE #PARAMETROS
 SET ivp_hoy = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA
 WHERE vmfecha=pmfecproc AND vmcodigo=997
 UPDATE #PARAMETROS
 SET ivp_man = ISNULL(vmvalor, 0.0)
 FROM VIEW_VALOR_MONEDA
 WHERE vmfecha=pmfecprox AND vmcodigo=997
 UPDATE #PARAMETROS
 SET do_hoy = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA
 WHERE vmfecha=pmfecproc AND vmcodigo=994
 UPDATE #PARAMETROS
 SET do_man = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA
 WHERE vmfecha=pmfecprox AND vmcodigo=994
 UPDATE #PARAMETROS
 SET da_hoy = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA
 WHERE vmfecha=pmfecproc AND vmcodigo=995
 UPDATE #PARAMETROS SET da_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
 FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
 WHERE VIEW_VALOR_MONEDA.vmfecha  = pmfecprox AND VIEW_VALOR_MONEDA.vmcodigo = 995

  SELECT 'pmfecproc' = CONVERT(CHAR(10),pmfecproc,103) ,
   'pmfecprox' = CONVERT(CHAR(10), pmfecprox, 103)     ,
   uf_hoy          ,
   uf_man          ,
   ivp_hoy          ,
   ivp_man          ,
   do_hoy          ,
   do_man          ,
   da_hoy          ,
   da_man          ,
   pmnomprop         ,
   rut_empresa         ,
   'hora'  = CONVERT(VARCHAR(10), GETDATE(), 108)    ,
  -- 'nomemp' = ISNULL(acnomprop,'')      ,
   'nomemp' = ISNULL(@acnomprop,'')      ,  -- Fusion
   'rutemp' = ISNULL(RTRIM(CONVERT(CHAR(9),acrutprop))+'-'+acdigprop,'') ,
   'fecpro' = ISNULL(CONVERT(CHAR(10),acfecproc,103),'')   ,
   'nomcli' = ISNULL(clnombre,'')      ,
   'rutcli' = ISNULL(RTRIM(CONVERT(CHAR(9),clrut))+'-'+cldv,'') ,
   'nomCART' = ISNULL(rcnombre,'')      ,
   'glosa'  =  ISNULL(cfrf.glosa,'sin definicion'), -- (SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BTR' And rcrut =  motipcart)        ,
   'numoper' = ISNULL(monumoper,0)      ,
   'instrumento' = CASE moinstser WHEN 'ICOL' THEN 'COL' ELSE 'CAP'  END  ,
   'plazo'  = CONVERT(NUMERIC(4,0),DATEDIFF(dd,mofecinip,mofecvenp)) ,
   'fecven' = ISNULL(CONVERT(CHAR(10),mofecven,103),'')   ,
   'moneda' = ISNULL(mnnemo,'')      ,
   'base'  = CONVERT(NUMERIC(3,0),mobaspact)    ,
   'valor'  = 0        , 
   'valinicial' = CONVERT(NUMERIC(19,4),case when momonpact=994 or momonpact=998 then round(movalinip/isnull((select vmvalor from view_valor_moneda where vmcodigo=momonpact and vmfecha=mofecinip),1),mndecimal)
                  else round(movalinip,mndecimal) end),
   'tasapacto' = CONVERT(NUMERIC(09,4),motaspact)    ,
   'valfinal' = ROUND(CONVERT(NUMERIC(19,4),movalvenp),mndecimal)    ,
   'glosa_pago' = VIEW_FORMA_DE_PAGO.glosa        , --VIEW_FORMA_DE_PAGO.
   'tippago' = CASE mopagohoy WHEN 'N' THEN 'PAGO MAYANA' ELSE '' END ,
   'serie'  = ISNULL(inserie,'')      ,
   'tipcli' = CASE
			  WHEN clrut=97029000 THEN '1'+VIEW_FORMA_DE_PAGO.glosa
			  WHEN clrut=97030000 THEN '2'+VIEW_FORMA_DE_PAGO.glosa
			  ELSE '3'+VIEW_FORMA_DE_PAGO.glosa
			  END         ,
   'operador' = nombre,
   'cod_ini_pag'= mdmo.moforpagi,
   'glosa_pagoini' =convert(nvarchar(100),''),
   'Tipo_InV'		= @Glosa_Cartera	,
   'libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND tbcodigo1 = MDMO.id_libro),'') ,
   'Glosa_libro'	= @Glosa_Libro
  INTO #temp1
  FROM MDAC, MDMO
   LEFT JOIN
			(	SELECT	Id = cf.tbcodigo1, Glosa = cf.tbglosa
				from	BacParamSuda..TIPO_CARTERA tc
						INNER JOIN
						(	SELECT	tbcodigo1, tbglosa
							FROM	bacparamsuda.dbo.tabla_general_detalle WITH(NOLOCK) 
							WHERE	tbcateg = 204
						)	cf		ON cf.tbcodigo1	= tc.rcrut
				WHERE	tc.rcsistema = 'BTR'
				AND		tc.rccodpro='CP'
			)	cfrf	ON cfrf.Id	= MDMO.motipcart
  , VIEW_MONEDA , VIEW_ENTIDAD MDRC, VIEW_CLIENTE, VIEW_INSTRUMENTO,--VIEW_TABLA_GENERAL_DETALLE,
   VIEW_FORMA_DE_PAGO, #PARAMETROS, VIEW_USUARIO
	WHERE	motipoper	=  'IB' 
	AND	mostatreg	=  '' 
	AND	rcrut		=  morutcart 
	AND	momonpact	=  mncodmon 
	AND	(morutcli	=  clrut	AND	mocodcli = clcodigo)
	AND	mocodigo	=  incodigo 
	AND	codigo		=  moforpagv 
	AND	(morutcart	>= @ncartini	AND	morutcart <= @ncartfin) 
	AND	mousuario	=  VIEW_USUARIO.usuario
	AND	(motipcart	=  @Cartera_INV	OR	@Cartera_INV = 0) 
	AND	(MDMO.id_libro	=  @id_libro	OR	@id_libro = '')
  ORDER BY monumoper 

update #temp1 set glosa_pagoini =  VIEW_FORMA_DE_PAGO.glosa  from VIEW_FORMA_DE_PAGO where  codigo = cod_ini_pag

-- select * from VIEW_FORMA_DE_PAGO
 IF (SELECT COUNT(*) FROM #temp1 ) = 0
 BEGIN
  INSERT INTO #temp1
  SELECT 'pmfecproc' = CONVERT(CHAR(10),pmfecproc,103) ,
   'pmfecprox' = CONVERT(CHAR(10), pmfecprox, 103)     ,
   uf_hoy          ,
   uf_man          ,
   ivp_hoy          ,
   ivp_man          ,
   do_hoy          ,
   do_man          ,
   da_hoy          ,
   da_man          ,
   pmnomprop         ,
   rut_empresa         ,
   'hora'  = CONVERT(VARCHAR(10), GETDATE(), 108)    ,
   --'nomemp' = ISNULL(acnomprop,'')      ,
    'nomemp' = ISNULL(@acnomprop,'')      , -- Fusion
   'rutemp' = ISNULL(RTRIM(CONVERT(CHAR(9),acrutprop))+'-'+acdigprop,'') ,
   'fecpro' = ISNULL(CONVERT(CHAR(10),acfecproc,103),'')   ,
   'nomcli' = ''        ,
   'rutcli' = ''        ,
   'nomemp' = ''        ,
   'glosa'  = ''        ,
   'numoper' = 0        ,
   'instrumento' = ''        ,
   'plazo'  = 0        ,
   'fecven' = ''        ,
   'moneda' = ''        ,
   'base'  = 0        ,
   'valor'  = 0        , 
   'valinicial' = 0        ,
   'tasapacto' = 0        ,
   'valfinal' = 0        ,
   'glosa_pago' = ''        ,
   'tippago' = ''        ,
   'serie'  = ''        ,
   'tipcli' = ''        ,
   'operador' = '',
   'cod_ini_pag'= 0,
   'glosa_pagoini' =convert(nvarchar(100),''),
   'Tipo_InV'	= @Glosa_Cartera	,
   'libro'	= ''		,
   'Glosa_Libro'= @Glosa_Libro
  FROM MDAC, #PARAMETROS
 END
 SELECT * FROM #temp1
 SET NOCOUNT OFF
END
GO
