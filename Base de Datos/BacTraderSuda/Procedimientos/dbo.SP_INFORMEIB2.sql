USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORMEIB2]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFORMEIB2] 
   (
   @ctipoper   CHAR(04)  ,
   @cfechaProc   CHAR(08)  ,
   @cfechaProx   CHAR(08)  ,
   @vTitulo         VARCHAR (80)    ,
   @cDolar    CHAR (01)
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
  @nRutemp NUMERIC (09,0) ,
  @hora  CHAR (08) ,
  @paso  CHAR (01)
 SELECT @paso = 'N'
 EXECUTE Sp_Base_Del_Informe
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
 IF EXISTS(SELECT * FROM MDRS WHERE rsfecha=@cfechaProx AND rstipoper='DEV' AND rsinstser=@ctipoper AND 
    CHARINDEX(STR(rsmonemi,3),CASE WHEN @cDolar='N' THEN '997-998-999' ELSE '988-994-995- 13' END)>0)
 BEGIN
  SELECT rcnombre         ,
   'cinumdocu' = ISNULL(rsnumdocu,' ')       ,
   'cifecinip' = CONVERT(CHAR(10),rsfecinip,103)     ,
   'cifecvenp' = rsfecvtop ,
   'clnombre' = ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut=rsrutcli),' ') ,
   'cifecinip_cifecvenp'= ISNULL(DATEDIFF(DAY,rsfecinip,rsfecvtop),0)   ,   --9  plazo
   'mnnemo'  = ISNULL((SELECT mnnemo FROM VIEW_MONEDA WHERE rsmonpact=mncodmon),' ') ,
   'citaspact'  = ISNULL(rstir,0)       ,
   'glosa'  = 0         ,
   'cicapitalc' = ISNULL(rsvalcomp,0)       , --13
   'presente' = ISNULL(rsvppresenx,0)       ,--14 monto presente,
   'civalvenp' = ISNULL(rsnominal,0)       ,--14 monto final rsvalvenc,
   'ctipoper' = ISNULL((CASE WHEN @ctipoper='ICAP' AND DATEDIFF(day,rsfecinip,rsfecvtop) <= 365 THEN 'CAPTACIONES -'
       WHEN @ctipoper='ICAP' AND DATEDIFF(day,rsfecinip,rsfecvtop) >  365 THEN 'CAPTACIONES MAS DE 1 AÑO -'
       WHEN @ctipoper='ICOL' AND DATEDIFF(day,rsfecinip,rsfecvtop) <= 365 THEN 'COLOCACIONES -'
       WHEN @ctipoper='ICOL' AND DATEDIFF(day,rsfecinip,rsfecvtop) >  365 THEN 'COLOCACIONES MAS DE 1 AÑO -'
        END),' ') + ' ' + ISNULL((SELECT mnnemo FROM VIEW_MONEDA WHERE rsmonpact=mncodmon),' '),
   'rsinteres'  = ISNULL(rsinteres,0)         ,
   'rsreajuste'  = ISNULL(rsreajuste,0)         ,
   'rsinteres_acum' = ISNULL(rsinteres_acum-rsinteres,0)      ,
   'rsreajuste_acum'= ISNULL(rsreajuste_acum-rsreajuste,0)     ,
   'Monto_Capital'  = ISNULL(rsvalcomp,0)        ,
   'Fecha1'  = SUBSTRING(@cfechaProx,7,2)+'/'+SUBSTRING(@cfechaProx,5,2)+'/'+SUBSTRING(@cfechaProx,1,4), 
   'fecproc' = @acfecproc        , -- 29
   'fecprox' = @acfecprox        , -- 30
   'uf_hoy' = @uf_hoy        , -- 31
   'uf_man' = @uf_man        , -- 32
   'ivp_hoy' = @ivp_hoy        , -- 33
   'ivp_man' = @ivp_man        , -- 34
   'do_hoy' = @do_hoy        , -- 35
   'do_man' = @do_man        , -- 36
   'da_hoy' = @da_hoy        , -- 37
   'da_man' = @da_man        , -- 38
   'acnomprop'     = (SELECT ISNULL(@acnomprop, 'NO DEFINIDO') FROM MDAC )   , -- 39
   'rut_empresa'   = @rut_empresa        , -- 40
   'nombreentidad' = (SELECT ISNULL(acnomprop, 'NO DEFINIDO') from MDAC )    , -- 41
   'hora'  = CONVERT(VARCHAR(10),GETDATE(),108)     , -- 42
   'titulo' = @vtitulo + SPACE(3)+'DEL'+SPACE(3)+ ISNULL(CONVERT(CHAR(10),rsfecctb,103),' ') + SPACE(3)+ 'AL'+ SPACE(3)+ISNULL(CONVERT(CHAR(10),rsfecprox,103),' '),
   'rutcli' = rsrutcli        ,
   'tipcli' = CASE  WHEN rsrutcli = 97029000 THEN 'BANCO CENTRAL DE CHILE'
      WHEN rsrutcli = 97030000 THEN 'BANCO DEL ESTADO DE CHILE'
      ELSE 'OTROS BANCOS'
      END,
   'forpagv' = glosa
  FROM MDRS ,VIEW_ENTIDAD, VIEW_FORMA_DE_PAGO
  WHERE rsinstser=@ctipoper AND rsfecha=@cfechaProx AND rstipoper='DEV' AND
   CHARINDEX(STR(rsmonemi,3),CASE WHEN @cDolar='N' THEN '997-998-999' ELSE '988-994-995- 13' END)>0 AND
   rsforpagv=codigo
   SELECT @paso = 'S'
 END ELSE
 BEGIN
  declare @dfechasal datetime
  execute Sp_Busca_Fecha_Habil @cfechaProx,-1, @dfechasal output
  SELECT rcnombre         ,
   'cinumdocu' = ' '        ,
   'cifecinip' = ''        ,
   'cifecvenp' = ''         ,
   'clnombre' = ''        ,
   'cifecinip_cifecvenp'= 0   ,   --9  plazo
   'mnnemo' = '' ,
   'citaspact'  = 0       ,
   'glosa'  = 0         ,
   'cicapitalc' = 0       , --13
   'presente' = 0       ,--14 monto presente,
   'civalvenp' = 0       ,--14 monto final rsvalvenc,
   'ctipoper' = ISNULL((CASE
       WHEN @ctipoper='ICAP' THEN 'CAPTACIONES'
       WHEN @ctipoper='ICOL' THEN 'COLOCACIONES'
        END),' ')       ,
   'rsinteres'  = 0         ,
   'rsreajuste'  = 0         ,
   'rsinteres_acum' = 0      ,
   'rsreajuste_acum'= 0     ,
   'Monto_Capital'  = 0        ,
   'Fecha1'  = SUBSTRING(@cfechaProx,7,2)+'/'+SUBSTRING(@cfechaProx,5,2)+'/'+SUBSTRING(@cfechaProx,1,4), 
   'fecproc' = @acfecproc        , -- 29
   'fecprox' = @acfecprox        , -- 30
   'uf_hoy' = @uf_hoy        , -- 31
   'uf_man' = @uf_man        , -- 32
   'ivp_hoy' = @ivp_hoy        , -- 33
   'ivp_man' = @ivp_man        , -- 34
   'do_hoy' = @do_hoy        , -- 35
   'do_man' = @do_man        , -- 36
   'da_hoy' = @da_hoy        , -- 37
   'da_man' = @da_man        , -- 38
   'acnomprop'     = (SELECT ISNULL(@acnomprop, 'NO DEFINIDO') FROM MDAC )   , -- 39
   'rut_empresa'   = @rut_empresa        , -- 40
   'nombreentidad' = (SELECT ISNULL(acnomprop, 'NO DEFINIDO') from MDAC )    , -- 41
   'hora'  = CONVERT(VARCHAR(10),GETDATE(),108), -- 42
   'titulo' = @vtitulo + SPACE(3)+'DEL'+SPACE(3)+ ISNULL(CONVERT(CHAR(10),CONVERT(DATETIME,@cfechaProc),103),' ') + SPACE(3)+ 'AL'+ SPACE(3)+ISNULL(CONVERT(CHAR(10),CONVERT(DATETIME,@cfechaProx),103),' '),
   'rutcli' = 0         ,
   'tipcli' = ''         ,
   'forpagv' = ''
  FROM VIEW_ENTIDAD
 END 
 SET NOCOUNT OFF
END
--- SELECT * FROM MDCI
--- Sp_Informeib 'ICAP',0,'20011116','20011119','DFEAFGAERFG','N'
--- SELECT * FROM VIEW_MONEDA


GO
