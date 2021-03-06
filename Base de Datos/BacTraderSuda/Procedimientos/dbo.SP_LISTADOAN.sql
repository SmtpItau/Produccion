USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOAN]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SP_LISTADOAN 0, 'T', 0, 1552, ''

CREATE PROCEDURE [dbo].[SP_LISTADOAN]  
   (
   @entidad  		FLOAT 	  =  0 	,
   @codigo_carterasuper CHAR (01) = 'T' ,
   @Cartera_Inv 	Integer   = 0	,
   @Cat_Libro		CHAR(06)  = ''	,
   @Id_Libro		CHAR(06)  = ''
   )
AS
BEGIN
  DECLARE @acfecproc   CHAR (10) ,
   @acfecprox   CHAR (10) ,
   @uf_hoy      FLOAT  ,
   @uf_man      FLOAT  ,
   @ivp_hoy     FLOAT  ,
   @ivp_man     FLOAT  ,
   @do_hoy      FLOAT  ,
   @do_man      FLOAT  ,
   @da_hoy      FLOAT  ,
   @da_man      FLOAT  ,
   @acnomprop   CHAR (40) ,
   @rut_empresa CHAR (12) ,
   @hora        CHAR (08),
   @Glosa_Cartera Char   (20)	,
   @Glosa_Libro Char   (50)

	Select @Glosa_Cartera = '' 

   SELECT Distinct
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema = 'BTR'
     And  rcrut     = @Cartera_INV
	 ---  ORDER BY rcrut REQ.7619

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
   SET NOCOUNT ON

   	-- FUSION ---
	SET @acnomprop       = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
	-------------
 
  IF EXISTS(SELECT * FROM MDMO WHERE mostatreg='A')
   SELECT 'acfecproc' = @acfecproc ,
      'acfecprox'  = @acfecprox ,
          'uf_hoy' = @uf_hoy ,
      'uf_man' = @uf_man ,
     'ivp_hoy' = @ivp_hoy ,
     'ivp_man' = @ivp_man ,
     'do_hoy' = @do_hoy ,
     'do_man' = @do_man ,
     'da_hoy' = @da_hoy ,
     'da_man' = @da_man ,
     'pmnomprop' = @acnomprop ,
     'rut_empresa' = @rut_empresa ,
     'hora'  = @hora           ,
     acnomprop  = ISNULL(acnomprop,' ')        ,
     acrutprop_acdigprop = RTRIM(CONVERT(CHAR(11),ISNULL(acrutprop,0)))+'-'+ISNULL(acdigprop,' ') ,
     acfecproc  = CONVERT(CHAR(10),acfecproc,103)      ,
     motipoper  = CASE motipoper
               WHEN 'CI' THEN 'COMPRAS CON PACTO'
               WHEN 'IC' THEN 'CAPTACIONES'
               WHEN 'CP' THEN 'COMPRAS DEFINITIVAS'
               WHEN 'VP' THEN 'VENTAS DEFINITIVAS'
               WHEN 'VI' THEN 'VENTAS CON PACTO'
               WHEN 'IB' THEN 'INTERBANCARIOS'
	       WHEN 'FLI' THEN 'FACILIDAD  LIQUIDEZ INTRADIA'
   ELSE ''
   END          ,
    monumdocu  = CONVERT(CHAR(10),ISNULL(monumdocu,0))      ,
    mocorrela  = CONVERT(CHAR(3),ISNULL(mocorrela,0))      ,
    monumoper  = CONVERT(CHAR(10),ISNULL(monumoper,0))      ,
    moinstser  = ISNULL(moinstser,' ')        ,
    monominal  = ISNULL(monominal,0)        ,
    motir   = ISNULL(motir,0)        ,
    mopvp   = ISNULL(mopvp,0)        ,
    movpresen  = ISNULL(movpresen,0)        ,
    clnombre  = ISNULL(clnombre,'')        ,
    rcnombre  = ISNULL(rcnombre,'')        ,
    momascara  = ISNULL(momascara,'') ,
    'glosa' = VIEW_FORMA_DE_PAGO.glosa 				,		
    'Cart_OP'  =  ISNULL(cfrf.glosa,'sin definicion'), --(SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BTR' And rcrut =  motipcart)        ,
    'Tipo_InV'	= @Glosa_Cartera	,
    'libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND tbcodigo1 = MDMO.id_libro),'') ,
    'Glosa_libro'	= @Glosa_Libro
   FROM MDAC,  MDMO
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
   , VIEW_CLIENTE , VIEW_ENTIDAD MDRC ,VIEW_FORMA_DE_PAGO
	WHERE	mostatreg  ='A' 
	AND	(morutcart = @entidad	OR  @entidad = 0) 
	AND	CHARINDEX(motipoper,'CI -CP -VI -IB -VP -FLI') > 0 
	AND	(morutcli  = clrut	AND mocodcli = clcodigo)
	AND	moforpagi  = codigo 
	AND	(MDMO.id_libro  = @id_libro	OR @id_libro	= '')
   ORDER BY motipoper
    ELSE
   SELECT 'acfecproc'  = @acfecproc  ,
    'acfecprox'   = @acfecprox  , 
    'uf_hoy'  = @uf_hoy  ,
    'uf_man'  = @uf_man  ,
    'ivp_hoy'  = @ivp_hoy  ,
    'ivp_man'  = @ivp_man  ,
    'do_hoy'  = @do_hoy  ,
    'do_man'  = @do_man  ,
    'da_hoy'  = @da_hoy  ,
    'da_man'  = @da_man  ,
    'pmnomprop'  = @acnomprop  ,
    'rut_empresa'  = @rut_empresa  ,
    'hora'   = @hora   ,
    acnomprop  = ' '   ,
    acrutprop_acdigprop = ' '   ,
    acfecproc  = ' '   ,
    motipoper  = ' '   ,
    monumdocu  = 0.0   ,
    mocorrela  = 0.0   ,
    monumoper  = 0   ,
    moinstser  = ' '    ,
    monominal  = 0.0   ,
    motir   = 0.0   ,
    mopvp   = 0.0   ,
    movpresen  = 0.0   ,
    clnombre  = ' '   ,
    rcnombre  = ' '   ,
    momascara  = ' ',
    glosa = '' 		,
  'Cart_OP'= ''		,
  'Tipo_InV'	= @Glosa_Cartera	,
  'libro'	= ''			,
  'Glosa_Libro' = @Glosa_Libro
  SET NOCOUNT OFF
END
GO
