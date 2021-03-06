USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFOCARCI2]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFOCARCI2]
       (
 @tipo_cartera      CHAR(3)   = 0  ,
 @entidad      NUMERIC(9)  = 0  ,
 @FechaProc      CHAR(8)  = '' ,
 @FechaProx      CHAR(8)  = '' ,
 @Titulo       VARCHAR(200)     ,
 @CDolar       CHAR(1)  
       )
AS
BEGIN
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
  @nRutemp NUMERIC (09,0) ,
  @hora  CHAR (08) 
 
 EXECUTE SP_BASE_DEL_INFORME
  @acfecproc OUTPUT ,
  @acfecprox OUTPUT ,
  @uf_hoy  OUTPUT ,
  @uf_man  OUTPUT ,
  @ivp_hoy OUTPUT ,
  @ivp_man OUTPUT ,
  @do_hoy  OUTPUT ,
  @do_man  OUTPUT ,
  @da_hoy  OUTPUT ,
  @da_man  OUTPUT ,
  @acnomprop OUTPUT ,
  @rut_empresa OUTPUT ,
  @hora  OUTPUT
 DECLARE @paso CHAR (01)
 SELECT  @paso = 'N'
 SET NOCOUNT ON
        SELECT         'NumDoc'   = CONVERT(VARCHAR(9),rsnumoper) + '-' + CONVERT(VARCHAR(10),rscorrela), --1
   'rscorrela'    = rscorrela   , --2
         'rsinstser'   = rsinstser   , --3
   'Emisor'   = (SELECT emgeneric FROM VIEW_EMISOR WHERE emrut = rsrutcli)  , --4
   'FechaCompra'   = ISNULL(CONVERT(CHAR(10),rsfeccomp,103) ,' ')   , --5
   'FechaVctoP'   = ISNULL(CONVERT(CHAR(10),rsfecvtop,103),' ' )   , --6
   'FechaIniP'   = ISNULL(CONVERT(CHAR(10),rsfecinip,103),' ' )   , --7
   'FechaEmision'   = ISNULL(CONVERT(CHAR(10),rsfecinip,103),' ' )   , --8
   'Dias'    = ISNULL(DATEDIFF(DAY,@FechaProc,rsfecvtop),0 )   , --9
   'rsvalcomu'   = rsvalcomu   , --10
   'moneda'   = (SELECT mnnemo FROM VIEW_MONEDA WHERE MNCODMON = rsmonpact)  , --11
   'UM'    = (SELECT mnnemo FROM VIEW_MONEDA WHERE MNCODMON = rsmonpact)  , --12
   'rsnominal'   = rsnominal   , --13
   'Cupon'    = rsvalvenc  , --14
   'rscupint'   = rscupint   , --15
   'rstir'    = convert(float,rstir) , --16
   'rsvpcomp'   = rsvpcomp   , --17
   'rsvppresen'   = rsvppresen   , --18
   'rsinteres'   = rsinteres   , --19
   'rsreajuste'   = rsreajuste   , --20
   'rsintermes'   = rsintermes   , --21
   'rsreajumes'   = rsreajumes   , --22
   'rsvppresenx'   = rsvppresenx   , --23
   'rsinteres_acum'  = rsinteres_acum - rsinteres  , --24 select * from view_moneda
   'rsreajuste_acum' = rsreajuste_acum - rsreajuste  , --25
   'ValorIniPeso'   = CASE WHEN rsmonpact = 13 THEN rsvalinip
			ELSE ROUND(rsvalinip/(SELECT citcinicio FROM MDCI Where cirutcart = rsrutcart and cinumdocu = rsnumdocu and cicorrela = rscorrela),mndecimal) END,
   'ValorVctoUM'   = rsvalvtop   , --27
   'TasaPacto'   = rstaspact   , --28
   'TasaEmision'   = rstasemi   , --29
   'rutCliente'   = (CONVERT(VARCHAR(10) , rsrutcli )) + '-' + (SELECT CLDV FROM VIEW_CLIENTE where CLRUT  = rsrutcli and CLCODIGO = rscodcli) , --30
   'Cliente'   = (SELECT CLNOMBRE FROM VIEW_CLIENTE where CLRUT  = rsrutcli and CLCODIGO = rscodcli )           , --31
   'sw'    = '0'    , --32
   'suma1'    = 0     , --33
   'titulo'   = @titulo   , --34
   'rsfecprox' = ISNULL(CONVERT(CHAR(10),rsfecprox,103),' '), --29
   'rsfecctb' = ISNULL(CONVERT(CHAR(10),rsfecctb,103),' '),
   'MonedaMx' = mnmx
  INTO #TEMPORAL1
  FROM MDRS , View_Moneda
    WHERE (rsrutcart = @Entidad  OR @Entidad  =0)
   AND rsinstser  <> 'ICAP' 
   AND rsinstser  <> 'ICOL' 
   AND rscartera   = @Tipo_cartera
   AND rsfecha     = @fechaprox
   AND rsmonpact   = mncodmon
  AND  ((CHARINDEX(STR(rsmonpact,3),CASE WHEN @cDolar='N' THEN '997-998-999' ELSE '988-994-995- 13' END)>0) OR 
	(@cDolar='N' And mnmx = 'C'))

select 'prueba'

 IF (SELECT COUNT(*) FROM #TEMPORAL1)>0
 BEGIN
  SELECT moneda,rsfecprox,rsfecctb, 
   'ValorIniPeso'   = SUM(ValorIniPeso) ,
   'ValorVctoUM'   = SUM(ValorVctoUM) ,
   'rsintermes'   = SUM(rsintermes) ,
   'rsreajumes'   = SUM(rsreajumes) ,
   'rsinteres'   = SUM(rsinteres) ,
   'rsinteres_acum'  = SUM(rsinteres_acum) ,
'rsreajuste'   = SUM(rsreajuste) ,
   'rsreajuste_acum' = SUM(rsreajuste_acum) ,
   'rsvppresen'   = SUM(rsvppresen)  , --18
   'rsvppresenx'   = SUM(rsvppresenx)  , --23
   'rstasa'          = SUM(TasaPacto*rsvppresen) / SUM(rsvppresen),
   'MonedaMx'	   = Min(MonedaMx)
  INTO #TOTAL1
  FROM #TEMPORAL1
  GROUP BY moneda,rsfecprox,rsfecctb

  INSERT INTO #TEMPORAL1
  SELECT  0  , --1
   0  , --2
         ''  , --3
  ''  , --4
   ''  , --5
   ''  , --6
   ''  , --7
   ''  , --8
   0  , --9
   0  , --10
   moneda  , --11
--   'ZTOTAL' , --11
   'RESUMEN' , --12
   0  , --13
   0  , --14
   0  , --15
   0  , --16
   0  , --17
   rsvppresen , --18
   rsinteres , --19
   rsreajuste , --20
   rsintermes , --21
   rsreajumes , --22
   rsvppresenx , --23
   rsinteres_acum , --24
   rsreajuste_acum , --25
   ValorIniPeso , --26
   ValorVctoUM , --27
   rstasa    , --28
   0  , --29
   0  , --30
   ''  , --31
   'sw'='1' , --32
   ''  , --33
   '',
   Isnull(rsfecprox,' ') , -- 29
   Isnull(rsfecctb,' ')  , -- 30
   MonedaMx
  FROM #TOTAL1
  ----<< resultado para Crystal Report
 END
 ELSE
 BEGIN
  INSERT INTO #TEMPORAL1
  SELECT  0  , --1
   0  , --2
         ''  , --3
   ''  , --4
   ''  , --5
   ''  , --6
   ''  , --7
   ''  , --8
   0  , --9
   0  , --10
   ''  , --11
   ''  , --12
   0  , --13
   0  , --14
   0  , --15
   0  , --16
   0  , --17
   0  , --18
   0  , --19
   0  , --20
   0  , --21
   0  , --22
   0  , --23
   0  , --24
   0  , --25
   0  , --26
   0  , --27
   0  , --28
   0  , --29
   0  , --30
   ''  , --31
   'sw'='0' , --32
   ''  , --33
   @titulo  ,
   CONVERT(CHAR(10),CONVERT(DATETIME,@FechaProx),103),
   CONVERT(CHAR(10),CONVERT(DATETIME,@FechaProc),103),
   ' '
 END
 SELECT  NumDoc     , --1
   rscorrela    , --2
   rsinstser    , --3
   Emisor     , --4
   FechaCompra    , --5
   FechaVctoP    , --6
   FechaIniP    , --7
   FechaEmision    , --8
   Dias     , --9
   rsvalcomu    , --10
   moneda     , --11
   UM     , --12
   rsnominal    , --13
   Cupon     , --14
   rscupint    , --15
   rstir    , --16
   rsvpcomp    , --17
   rsvppresen    , --18
   rsinteres    , --19
   rsreajuste    , --20
   rsintermes    , --21
   rsreajumes    , --22
   rsvppresenx    , --23
   rsinteres_acum    , --24
   rsreajuste_acum    , --25
   ValorIniPeso    , --26
   ValorVctoUM    , --27
   tasaPacto    , --28
   TasaEmision    , --29
   rutCliente    , --30
   Cliente     , --31
   'FechProc' = SUBSTRING(@fechaProc ,7,2) + '/' +SUBSTRING(@fechaProc ,5,2) + '/' +SUBSTRING(@fechaProc ,1,4) , --32
   'FechProx' = SUBSTRING(@fechaProx ,7,2) + '/' +SUBSTRING(@fechaProx ,5,2) + '/' +SUBSTRING(@fechaProx ,1,4) , --33
   'uf_hoy' = @uf_hoy  , -- 31
   'uf_man' = @uf_man  , -- 32
   'ivp_hoy' = @ivp_hoy  , -- 33
   'ivp_man' = @ivp_man  , -- 34
   'do_hoy' = @do_hoy  , -- 35
   'do_man' = @do_man  , -- 36
   'da_hoy' = @da_hoy  , -- 37
   'da_man' = @da_man  , -- 38
   'NombreEntidad' = (SELECT ISNULL(acnomprop, 'NO DEFINIDO') FROM MDAC ) , --44
   'Hora'  = @hora   , --45
   sw         , --46
   'suma1'  = rsvppresenx     , --47
   CASE
    WHEN sw='1' THEN 'RESUMEN '+ RTRIM(@titulo) +SPACE(3)+'DEL'+SPACE(3)+ rsfecctb + SPACE(3)+ 'AL'+SPACE(3)+ rsfecprox
    ELSE RTRIM(titulo) + SPACE(3)+'DEL'+SPACE(3)+ rsfecctb + SPACE(3)+ 'AL'+SPACE(3)+ rsfecprox
   END
   AS 'titulo'        , -- 
   'rsfecprox' = ISNULL(CONVERT(CHAR(10),rsfecprox,103),' ')  , --
   'rsfecctb' = ISNULL(CONVERT(CHAR(10),rsfecctb,103),' '),
   MonedaMx
  FROM #TEMPORAL1
  ORDER BY UM
 SET NOCOUNT OFF
END
-- SELECT rsfecha,rscartera,rsinstser,rsmonpact from mdrs where rscartera = '112' and rsinstser <> 'ICAP' and rsinstser <> 'ICOL'
-- SELECT ciinstser FROM MDCI WHERE ciinstser <> 'ICAP' AND ciinstser <> 'ICOL' AND cirutcart = 0
-- Sp_Infocarci '112',0,'20010905','20010906','DFDRFSDFG','N'
-- select rsreajuste_acum,rsinteres_acum,rsvalinip,rsmonpact,* from mdrs where rsfecha = '20021022' and rsnumdocu = 40970





GO
