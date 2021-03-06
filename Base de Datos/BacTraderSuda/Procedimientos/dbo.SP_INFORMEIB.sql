USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORMEIB]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORMEIB]
   (
   @ctipoper   	 CHAR    (04)  	,
   @cfechaProc   CHAR    (08)  	,
   @cfechaProx   CHAR    (08)  	,
   @vTitulo      VARCHAR (80)   ,
   @cDolar       CHAR    (01)	,
   @Cartera_Inv  Integer	,
   @Cat_Libro	 CHAR(06)	,
   @Id_Libro	 CHAR(06)	
   )
 
AS
BEGIN
 SET NOCOUNT ON
 
 DECLARE   @acfecproc    CHAR (10)     ,
           @acfecprox    CHAR (10)     ,
           @uf_hoy       FLOAT         ,
           @uf_man       FLOAT         ,
           @ivp_hoy      FLOAT         ,
           @ivp_man      FLOAT         ,
           @do_hoy       FLOAT         ,
           @do_man       FLOAT         ,
           @da_hoy       FLOAT         ,
           @da_man       FLOAT         ,
           @acnomprop    CHAR (40)     ,
           @rut_empresa  CHAR (12)     ,
           @nRutemp      NUMERIC (09,0),
           @hora         CHAR (08)     ,
           @paso         CHAR (01)     ,
  	   @Glosa_Cartera Char   (20)  ,
  	   @Glosa_Libro	  Char   (50)

	Select @Glosa_Cartera = '' 

   SELECT Distinct
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema = 'BTR'
     And  rcrut     = @Cartera_INV
	   -- ORDER BY rcrut REQ.7619 CASS 25-01-2011

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
          
 SET @paso = 'N'

 EXECUTE Sp_Base_Del_Informe
                 @acfecproc   OUTPUT ,
                 @acfecprox   OUTPUT ,
                 @uf_hoy      OUTPUT ,
                 @uf_man      OUTPUT ,
                 @ivp_hoy     OUTPUT ,
                 @ivp_man     OUTPUT ,
                 @do_hoy      OUTPUT ,
                 @do_man      OUTPUT ,
                 @da_hoy      OUTPUT ,
                 @da_man      OUTPUT ,
                 @acnomprop   OUTPUT ,
                 @rut_empresa OUTPUT ,
                 @hora        OUTPUT
 IF EXISTS(SELECT 1 FROM MDRS WHERE rsfecha = @cfechaProx 
				AND rstipoper = 'DEV' 
				AND rsinstser = @ctipoper 
				AND CHARINDEX(STR(rsmonemi,3),CASE WHEN @cDolar='N'	THEN '997-998-999- 13-142-102- 72' 
											ELSE '988-994-995' END)>0
				AND (rsid_libro = @id_libro OR @id_libro = '')) BEGIN
  SELECT rcnombre                                          ,
         'tir'       = ISNULL(rstir,0),
         'cinumdocu' = ISNULL(rsnumdocu,' ')               ,
         'cifecinip' = CONVERT(CHAR(10),rsfecinip,103)     ,
         'cifecvenp' = CONVERT(CHAR(10),rsfecvtop,103)                          ,
         'clnombre'  = ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut=rsrutcli and clcodigo = rscodcli),' ') ,
         'Resto'     = ISNULL(DATEDIFF(DAY,CONVERT(DATETIME,@cfechaProc),rsfecvtop),0)   ,   --9  plazo
         'cifecinip_cifecvenp'= ISNULL(DATEDIFF(DAY,rsfecinip,rsfecvtop),0)   ,   --9  plazo
         'mnnemo'    = ISNULL((SELECT mnnemo FROM VIEW_MONEDA WHERE rsmonpact=mncodmon),' ') ,
         'citaspact' = ISNULL(rstir,0)                      ,
         'glosa'     = 0                                    ,
         'cicapitalc'= ROUND(ISNULL(rsvalcomp,0),mndecimal)                  , --13
         'presente'  = ROUND(ISNULL(rsvppresenx,0),mndecimal)                , --14 monto presente,   @acfecproc    POR ESTO rsfecinip
         'civalvenp' = ROUND(ISNULL(rsnominal,0),mndecimal)                  , --14 monto final rsvalvenc,
         'ctipoper'  = ISNULL((CASE WHEN @ctipoper='ICAP' AND DATEDIFF(day,CONVERT(DATETIME,@cfechaProc),rsfecvtop) <= 365 THEN 'CAPTACIONES -'
                                   WHEN @ctipoper='ICAP' AND DATEDIFF(day,CONVERT(DATETIME,@cfechaProc),rsfecvtop) >  365 THEN 'CAPTACIONES MAS DE 1 AÑO -'
                                   WHEN @ctipoper='ICOL' AND DATEDIFF(day,CONVERT(DATETIME,@cfechaProc),rsfecvtop) <= 365 THEN 'COLOCACIONES -'
                                   WHEN @ctipoper='ICOL' AND DATEDIFF(day,CONVERT(DATETIME,@cfechaProc),rsfecvtop) >  365 THEN 'COLOCACIONES MAS DE 1 AÑO -'
                                   END),' ') + ' ' + ISNULL((SELECT mnnemo FROM VIEW_MONEDA WHERE rsmonpact=mncodmon),' '),
         'rsinteres'   = ROUND(ISNULL(rsinteres,0),mndecimal)                ,
         'rsreajuste'  = ROUND(ISNULL(rsreajuste,0),mndecimal)               ,
         'rsinteres_acum' = ROUND(ISNULL(rsinteres_acum - rsinteres ,0),mndecimal)      , -- rsinteres
         'rsreajuste_acum'= ROUND(ISNULL(rsreajuste_acum - rsreajuste ,0),mndecimal)     , -- rsreajuste
         'Monto_Capital'  = ROUND(ISNULL(rsvalcomp,0),mndecimal)              ,
         'Fecha1'  = SUBSTRING(@cfechaProx,7,2)+'/'+SUBSTRING(@cfechaProx,5,2)+'/'+SUBSTRING(@cfechaProx,1,4), 
         'fecproc' = @acfecproc                 , -- 29
         'fecprox' = @acfecprox                              , -- 30
         'uf_hoy'  = @uf_hoy                                 , -- 31
         'uf_man'  = @uf_man                                 , -- 32
         'ivp_hoy' = @ivp_hoy           , -- 33
         'ivp_man' = @ivp_man                                , -- 34
         'do_hoy'  = @do_hoy                                 , -- 35
         'do_man'  = @do_man                                 , -- 36
         'da_hoy'  = @da_hoy                                 , -- 37
         'da_man'  = @da_man                                 , -- 38
         'acnomprop'     = (SELECT ISNULL(@acnomprop, 'NO DEFINIDO') FROM MDAC )   , -- 39
         'rut_empresa'   = @rut_empresa                      , -- 40
         'nombreentidad' = (SELECT ISNULL(acnomprop, 'NO DEFINIDO') from MDAC )    , -- 41
         'hora'    = CONVERT(VARCHAR(10),GETDATE(),108)      , -- 42
         'titulo'  = @vtitulo + SPACE(3)+'DEL'+SPACE(3)+ ISNULL(CONVERT(CHAR(10),rsfecctb,103),' ') + SPACE(3)+ 'AL'+ SPACE(3)+ISNULL(CONVERT(CHAR(10),rsfecprox,103),' '),
         'rutcli'  = rsrutcli                                ,
         'tipcli'  = CASE  WHEN rsrutcli = 97029000 THEN 'BANCO CENTRAL DE CHILE'
                           WHEN rsrutcli = 97030000 THEN 'BANCO DEL ESTADO DE CHILE'
                        ELSE 'OTROS BANCOS'
                     END                                     ,
         'forpagv' = VIEW_FORMA_DE_PAGO.glosa,
         'valor_proceso' = rsvppresen,
   		 'Tipo_Cart'	 = isnull(cfrf.glosa,'sin definicion'), --(SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BTR' And rcrut =  rstipcart),
   		 'Tipo_InV'		= @Glosa_Cartera
	,	 'libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND tbcodigo1 = rsid_libro),'') 
	,	 'Glosa_libro'	= @Glosa_Libro

        FROM MDRS 
			left join
			(	select	Id = cf.tbcodigo1, Glosa = cf.tbglosa
				from	BacParamSuda..TIPO_CARTERA tc
						INNER JOIN
						(	SELECT	tbcodigo1, tbglosa
							FROM	bacparamsuda.dbo.tabla_general_detalle WITH(NOLOCK) 
							WHERE	tbcateg = 204
						)	cf		ON cf.tbcodigo1	= tc.rcrut
				WHERE	tc.rcsistema = 'BTR'
				AND		tc.rccodpro='CP'
			)	cfrf	ON cfrf.Id	= MDRS.rstipcart
	,	VIEW_ENTIDAD
	,	VIEW_FORMA_DE_PAGO
	,	VIEW_MONEDA
        WHERE	rsinstser = @ctipoper 
	AND	rsfecha   = @cfechaProx 
	AND	rstipoper = 'DEV' 
	AND	rsmonpact = mncodmon 
	AND	CHARINDEX(STR(rsmonemi,3),CASE	WHEN @cDolar='N' THEN '997-998-999- 13-142-102- 72' 
						ELSE '988-994-995' END)>0 
	AND	rsforpagv  = codigo
	AND	(rstipcart = @Cartera_INV  OR @Cartera_INV = 0 ) 
	AND	(rsid_libro  = @id_libro     OR @id_libro    = '')

   SELECT @paso = 'S'
 END ELSE
 BEGIN

  declare @dfechasal datetime

  execute Sp_Busca_Fecha_Habil @cfechaProx,-1, @dfechasal output

  SELECT rcnombre                     ,
         'tir'          = 0,
         'cinumdocu'    = ' '         ,
         'cifecinip'    = ''          ,
         'cifecvenp'    = ''          ,   
         'clnombre'     = ''          ,
         'Resto'        = 0           ,
         'cifecinip_cifecvenp'= 0     ,   --9  plazo
         'mnnemo'       = ''          ,
         'citaspact'    = 0           ,
         'glosa'        = 0           ,
         'cicapitalc'   = 0           , --13
         'presente'     = 0 , --14 monto presente,
         'civalvenp'    = 0           , --14 monto final rsvalvenc,
         'ctipoper'     = ISNULL((CASE
                                  WHEN @ctipoper='ICAP' THEN 'CAPTACIONES'
                                  WHEN @ctipoper='ICOL' THEN 'COLOCACIONES'
                              END),' ')       ,
         'rsinteres'    = 0           ,
         'rsreajuste'   = 0           ,
         'rsinteres_acum' = 0         ,
         'rsreajuste_acum'= 0         ,
         'Monto_Capital'  = 0         ,
         'Fecha1'       = SUBSTRING(@cfechaProx,7,2)+'/'+SUBSTRING(@cfechaProx,5,2)+'/'+SUBSTRING(@cfechaProx,1,4), 
         'fecproc'      = @acfecproc        , -- 29
         'fecprox'      = @acfecprox        , -- 30
         'uf_hoy'       = @uf_hoy           , -- 31
         'uf_man'       = @uf_man           , -- 32
         'ivp_hoy'      = @ivp_hoy          , -- 33
         'ivp_man'      = @ivp_man          , -- 34
         'do_hoy'       = @do_hoy           , -- 35
         'do_man'       = @do_man           , -- 36
         'da_hoy'       = @da_hoy           , -- 37
         'da_man'       = @da_man           , -- 38
         'acnomprop'    = (SELECT ISNULL(@acnomprop, 'NO DEFINIDO') FROM MDAC )   , -- 39
         'rut_empresa'  = @rut_empresa      , -- 40
         'nombreentidad'= (SELECT ISNULL(acnomprop, 'NO DEFINIDO') from MDAC )    , -- 41
         'hora'       = CONVERT(VARCHAR(10),GETDATE(),108), -- 42
         'titulo'       = @vtitulo + SPACE(3)+'DEL'+SPACE(3)+ ISNULL(CONVERT(CHAR(10),CONVERT(DATETIME,@cfechaProc),103),' ') + SPACE(3)+ 'AL'+ SPACE(3)+ISNULL(CONVERT(CHAR(10),CONVERT(DATETIME,@cfechaProx),103),' '),
         'rutcli'       = 0                 ,
         'tipcli'       = ''                ,
         'forpagv'      = ''	            ,
         'valor_proceso' = 0		    ,
   	 'Tipo_Cart'	 = ''		    ,
   	 'Tipo_InV'	 = @Glosa_Cartera   ,
	 'Libro'	 = ''		    ,
	 'Glosa_Libro'	 = @Glosa_Libro
  FROM	VIEW_ENTIDAD

 END 

 SET NOCOUNT OFF

END




-- Base de Datos --
GO
