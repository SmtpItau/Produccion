USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTVI]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SP_LISTVI 0, 'MOVIMIENTO DIARIO DE VENTAS CON PACTO', 0, 1552, ''

CREATE PROCEDURE [dbo].[SP_LISTVI] 
   (
   @entidad 	FLOAT    		,
   @titulo  	VARCHAR (200) = ''	,
   @Cartera_Inv Integer			,
   @Cat_Libro	CHAR(06)		,
   @Id_Libro	CHAR(06)
   )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @acfecproc CHAR (10) ,
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
  @Glosa_Cartera   Char   (20)	,
  @Glosa_Libro	CHAR(50)

 Select @Glosa_Cartera = '' 

   SELECT Distinct 
          @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema = 'BTR'
   AND  rcrut     = @Cartera_INV
   --ORDER BY rcrut --REQ.7619 CASS 25-01-2011

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
 DECLARE @ncartini NUMERIC (10,0) ,
  @ncartfin NUMERIC (10,0),
  @DolarObs FLOAT

   -- FUSION ---
  SET @acnomprop       = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
 -------------

 SELECT @DolarObs = vmvalor from View_Valor_moneda,mdac Where vmcodigo = 994 and vmfecha = acfecproc

 SELECT @ncartini = @entidad 
 SELECT @ncartfin = CASE @entidad WHEN 0 THEN 999999999 ELSE @entidad END

  SELECT 
   'nomcli' 	= ISNULL(clnombre , '')        ,--1
   'noment' 	= ISNULL(rcnombre , '')        ,--2
   'numdocu' 	= ISNULL(RTRIM(CONVERT(CHAR(10),monumdocu))+'-'+CONVERT(CHAR(3),mocorrela),'') ,--3
   'instrumento'= ISNULL(moinstser, '')        ,--4
   'emisor' 	= ISNULL(emgeneric, '')        ,--5
   'fecven' 	= ISNULL(CONVERT(CHAR(10),mofecven,103),'')     ,--6
   'moneda' 	= ISNULL(m1.mnnemo,'')        ,--7
   'nominal' 	= ISNULL(monominal,0)        ,--8
   'tirventa' 	= ISNULL(motir,0)        ,--9
   'pvp'  	= ISNULL(mopvp,0)        ,--10
   'valorventa' = CASE 	WHEN momonpact = 13 AND momonemi = 13 Then ISNULL(Round(movpresen*momtoPFE,0),0) 
			WHEN momonpact <> 13 AND momonemi = 13 THEN ISNULL(Round(movpresen* (Select vmvalor from View_valor_moneda, mdac Where vmcodigo = 994 And Vmfecha=acfecproc ),0),0) 
			ELSE ISNULL(movpresen,0) END ,--11
   'fechaini' 	= ISNULL(CONVERT(CHAR(10),mofecinip,103),'')     ,--12
   'fecvtop' 	= ISNULL(CONVERT(CHAR(10),mofecvenp,103),'')     ,--13
   'tasapact' 	= ISNULL(motaspact,0)        ,--14
   'monpacto' 	= ISNULL(m2.mnnemo,'')        ,--15
   'valinip' 	= CASE WHEN  m2.mnmx = 'C' AND momonpact <> 13 THEN isnull(Round(movalinip/momtoPFE,m2.mndecimal),0)
		    	ELSE isnull( movalinip, 0)
	       	    END,--16
   'valorven' 	= ISNULL(movalvenp,0)        ,--17
   'familia' 	= ISNULL(inserie,'')        ,--18
   'numoper' 	= ISNULL(monumoper,0)        ,--19
   'sw'  	= '0'          ,--20
   'titulo' 	= @titulo         ,--21
   'plazo'  	= CONVERT(NUMERIC(19,4),DATEDIFF(DAY,mofecinip,mofecvenp))   ,--22
   'FormaPagoIni' = p1.glosa,
   'mnmx'      	= m2.mnmx,
   'Tipo_Cart'	= isnull(cfrf.glosa,'sin definicion'), --(SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BTR' And rcrut =  motipcart),
   'Tipo_InV'	= @Glosa_Cartera	,
   'libro'		= (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND tbcodigo1 = MDMO.id_libro),
   'Glosa_libro'	= @Glosa_Libro	,
   'Tasa_Trans'		= moTirTran	,
   'VF_Trans_MO'	= moVPTran	
  INTO #TEMP
 FROM  MDMO
			LEFT JOIN
			(	select	Id = cf.tbcodigo1, Glosa = cf.tbglosa
				from	BacParamSuda..TIPO_CARTERA tc
						INNER JOIN
						(	SELECT	tbcodigo1, tbglosa
							FROM	bacparamsuda.dbo.tabla_general_detalle WITH(NOLOCK) 
							WHERE	tbcateg = 204
						)	cf		ON cf.tbcodigo1	= tc.rcrut
				WHERE	tc.rcsistema = 'BTR'
				AND		tc.rccodpro='CP'
			)	cfrf	ON cfrf.Id	= MDMO.motipcart 
			
			LEFT OUTER JOIN VIEW_EMISOR    ON emrut = morutemi 
			LEFT OUTER JOIN VIEW_MONEDA m1 ON m1.mncodmon = momonemi 
, VIEW_CLIENTE
, VIEW_ENTIDAD
--, VIEW_EMISOR
, VIEW_INSTRUMENTO
, VIEW_FORMA_DE_PAGO p1
, VIEW_FORMA_DE_PAGO p2
--, VIEW_MONEDA m1
, VIEW_MONEDA m2
  WHERE motipoper = 'VI' 
   AND mostatreg <> 'A' 
   AND rcrut	=	morutcart 
   AND (clrut	=	morutcli 
   AND clcodigo	=	mocodcli) 
   --AND emrut	=*	morutemi 
   AND incodigo	=	mocodigo 
   --AND m1.mncodmon	=*	momonemi 
   AND m2.mncodmon	=	momonpact 
   AND p1.codigo	=	moforpagi 
   AND p2.codigo	=	moforpagv 
   AND(morutcart	>=	@ncartini 
   AND morutcart	<=	@ncartfin)
   AND (motipcart   =  @Cartera_INV or @Cartera_INV = 0) 
   AND (mdmo.id_libro = @id_libro OR @id_libro	= '')


--  REQ.7619 CASS 27-01-2011
--  FROM  MDMO, VIEW_CLIENTE, VIEW_ENTIDAD, VIEW_EMISOR, VIEW_INSTRUMENTO,
--   VIEW_FORMA_DE_PAGO p1, VIEW_FORMA_DE_PAGO p2, 
--   VIEW_MONEDA m1, VIEW_MONEDA m2
--  WHERE motipoper='VI' 
--   AND mostatreg<>'A' 
--   AND rcrut=morutcart 
--   AND (clrut=morutcli 
--   AND clcodigo=mocodcli) 
--   AND emrut=*morutemi 
--   AND incodigo=mocodigo 
--   AND m1.mncodmon=*momonemi 
--   AND m2.mncodmon=momonpact 
--   AND p1.codigo=moforpagi 
--   AND p2.codigo=moforpagv 
--   AND(morutcart>=@ncartini 
--   AND morutcart<=@ncartfin)
--   AND (motipcart   =  @Cartera_INV or @Cartera_INV = 0) 
--   AND (mdmo.id_libro		        = @id_libro	OR @id_libro	= '')

 IF (SELECT COUNT(1) FROM #TEMP ) > 0
 BEGIN
	 SELECT	'monpacto1' 	= monpacto					,
	 	'valinip1'	= SUM(valinip)					,
	 	'valorventa1'	= SUM(valorventa)				,
	 	'valorven1'	= SUM(valorven)					,
	 	'plazoprom1'	= ROUND(SUM(plazo * valinip) / SUM(valinip),0)	,
	 	'tasaprom1'	= SUM(tasapact    * valinip) / SUM(valinip)	,
	 	'mnmx'		= Max(MnMx)					,
	 	'TasaPromTran'	= SUM(Tasa_Trans  * valinip) / SUM(valinip)	,
	 	'TotVfTran'	= SUM(VF_Trans_MO)
	INTO	#TOTAL  
	FROM	#TEMP
	GROUP 
	BY	monpacto

  INSERT INTO
  #TEMP
  SELECT 'TOTAL VENTAS CON PACTO '+ (CASE
       WHEN monpacto1='CLP' THEN 'PESOS'
       WHEN monpacto1='UF' THEN 'UF'
       WHEN monpacto1='EUR' THEN 'EUROS'
       WHEN monpacto1='JPY' THEN 'YENES'
       ELSE 'DOLAR'
         END)	,
   ''   	,
   ''  	  	,
   ''    	,
   ''    	,
   ''    	,
   ''    	,
   0    	,
   0    	,
   0    	,
   valorventa1 	,
   ''    	,
   ''    	,
   tasaprom1   	,
   monpacto1   	,
   valinip1   	,
   valorven1   	,
   ''    	,
   0    	,
   '1'    	,
   'RESUMEN '+@titulo  ,
   plazoprom1   ,
   ''		,
   mnmx		,
   ''		,
   @Glosa_Cartera	,
   ''		,
   @Glosa_Libro	,
   TasaPromTran	,
   TotVfTran	
  FROM #TOTAL
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
   0    ,
   0    ,
   0    ,
   0    ,
   ''    ,
   ''    ,
   0    ,
   ''    ,
   0    ,
   0    ,
   ''    ,
   0  ,
   '0'    ,
   @titulo    ,
   0    ,
   ''	,
   ''	,
   ''	,
   @Glosa_Cartera	,
   ''			,
   @Glosa_Libro		,
   0			,
   0
 END
  SELECT nomcli    ,--1
   noment    ,--2
   numdocu     ,--3
   instrumento   ,--4
   emisor    ,--5
   fecven    ,--6
   moneda    ,--7
   nominal    ,--8
   tirventa   ,--9
   pvp    ,--10
   valorventa   ,--11
   fechaini   ,--12
   fecvtop    ,--13
   tasapact   ,--14
   monpacto   ,--15
   valinip    ,--16
   valorven   ,--17
   familia    ,--18
   numoper    ,--19
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
   'rut_empresa'  = @rut_empresa ,
   'hora'       = @hora  ,
   sw    ,
   titulo    ,
   plazo     ,
   mnmx	     ,
   Tipo_Cart ,
   Tipo_INV	,
   Libro		,
   Glosa_Libro		,
   Tasa_Trans		,
   VF_Trans_MO	
  FROM #TEMP
  ORDER BY familia,monpacto
  SET NOCOUNT OFF
END
GO
