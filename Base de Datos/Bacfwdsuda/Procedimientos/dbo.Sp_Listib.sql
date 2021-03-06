USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Listib]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Listib]
   (
   @entidad NUMERIC (9)
   )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @ncartini NUMERIC(10,0) ,
  @ncartfin NUMERIC(10,0)
 
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
  'pmnomprop' = acnomprop  ,
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
   'nomemp' = ISNULL(acnomprop,'')      ,
   'rutemp' = ISNULL(RTRIM(CONVERT(CHAR(9),acrutprop))+'-'+acdigprop,'') ,
   'fecpro' = ISNULL(CONVERT(CHAR(10),acfecproc,103),'')   ,
   'nomcli' = ISNULL(clnombre,'')      ,
   'rutcli' = ISNULL(RTRIM(CONVERT(CHAR(9),clrut))+'-'+cldv,'') ,
   'nomCART' = ISNULL(rcnombre,'')      ,
   'glosa'  = tbglosa        ,
   'numoper' = ISNULL(monumoper,0)      ,
   'instrumento' = CASE moinstser WHEN 'ICOL' THEN 'COL' ELSE 'CAP'  END  ,
   'plazo'  = CONVERT(NUMERIC(4,0),DATEDIFF(dd,mofecinip,mofecvenp)) ,
   'fecven' = ISNULL(CONVERT(CHAR(10),mofecven,103),'')   ,
   'moneda' = ISNULL(mnnemo,'')      ,
   'base'  = CONVERT(NUMERIC(3,0),mobaspact)    ,
   'valor'  = 0        , 
   'valinicial' = CONVERT(NUMERIC(19,4),movalinip)    ,
   'tasapacto' = CONVERT(NUMERIC(09,4),motaspact)    ,
   'valfinal' = CONVERT(NUMERIC(19,4),movalvenp)    ,
   'glosa_pago' = glosa        , --VIEW_FORMA_DE_PAGO.
   'tippago' = CASE mopagohoy WHEN 'N' THEN 'PAGO MAYANA' ELSE '' END ,
   'serie'  = ISNULL(inserie,'')      ,
   'tipcli' = CASE
      WHEN clrut=97029000 THEN '1'+glosa
      WHEN clrut=97030000 THEN '2'+glosa
      ELSE '3'+glosa
      END         ,
   'operador' = nombre
  INTO #temp1
  FROM MDAC, MDMO, VIEW_MONEDA , VIEW_ENTIDAD MDRC, VIEW_CLIENTE, VIEW_INSTRUMENTO,VIEW_TABLA_GENERAL_DETALLE,
   VIEW_FORMA_DE_PAGO, #PARAMETROS, VIEW_USUARIO
  WHERE motipoper='IB' AND mostatreg='' AND rcrut=morutcart AND momonpact=mncodmon AND (morutcli=clrut AND
   mocodcli=clcodigo) AND mocodigo=incodigo AND tbcateg=204 AND CONVERT(NUMERIC(6),tbcodigo1)=motipcart AND
   codigo=moforpagv AND (morutcart>=@ncartini AND morutcart<=@ncartfin) AND mousuario=VIEW_USUARIO.usuario
  ORDER BY monumoper 
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
   'nomemp' = ISNULL(acnomprop,'')      ,
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
   'operador' = ''
  FROM MDAC, #PARAMETROS
 END
 SELECT * FROM #temp1
 SET NOCOUNT OFF
END
-- Sp_Listib 0
-- SELECT CLRUT,CLNOMBRE FROM MDcl order by clnombre
GO
