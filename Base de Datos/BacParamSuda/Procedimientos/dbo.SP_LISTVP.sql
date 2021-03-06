USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTVP]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTVP]
               (
                  @entidad      NUMERIC(9) =   0 ,
                  @carterasuper CHAR(1)    =   '',
    @titulo  VARCHAR(200) =''
               )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @ncartini  NUMERIC(10,0)
   DECLARE @ncartfin NUMERIC(10,0) 
   DECLARE @numero  INTEGER
   SELECT @ncartini  = @entidad 
   SELECT @ncartfin  = case @entidad WHEN 0 THEN 999999999 ELSE @entidad END
   DECLARE @acfecproc   CHAR(10),
           @acfecprox   CHAR(10),
           @uf_hoy      FLOAT,
           @uf_man      FLOAT,
           @ivp_hoy     FLOAT,
           @ivp_man     FLOAT,
           @do_hoy      FLOAT,
           @do_man      FLOAT,
           @da_hoy      FLOAT,
           @da_man      FLOAT,
           @acnomprop   CHAR(40),
           @rut_empresa CHAR(12),
           @hora        CHAR(8)
   EXECUTE SP_BASE_DEL_INFORME
           @acfecproc   OUTPUT,
           @acfecprox   OUTPUT,
           @uf_hoy      OUTPUT,
           @uf_man      OUTPUT,
           @ivp_hoy     OUTPUT,
           @ivp_man     OUTPUT,
           @do_hoy      OUTPUT,
           @do_man      OUTPUT,
           @da_hoy      OUTPUT,
           @da_man      OUTPUT,
           @acnomprop   OUTPUT,
           @rut_empresa OUTPUT,
           @hora        OUTPUT
 IF EXISTS(SELECT * FROM MDMO WHERE MDMO.motipoper = 'VP' AND codigo_carterasuper = @carterasuper AND mostatreg <> 'A' )
 BEGIN
         SELECT 'nomcli'  = ISNULL(VIEW_CLIENTE.clnombre , ''),--1
               'noment' = ISNULL( MDRC.rcnombre, ''),--2
  'tipcart' = ISNULL( VIEW_TABLA_GENERAL_DETALLE.tbglosa, ''),--3
               'numdocu' = ISNULL(RTRIM(CONVERT(CHAR(10),MDMO.monumdocuo))+'-'+convert(CHAR(3),MDMO.mocorrelao),''),--4
  'instser' = ISNULL( MDMO.moinstser,''), --5
--         'emisor' = ISNULL( VIEW_EMISOR.emgeneric,''),--6
  'emisor' = CASE WHEN mocodigo = 98 THEN ( SELECT clgeneric FROM view_cliente WHERE clrut=morutcli AND clcodigo=mocodcli )
     ELSE ( SELECT emgeneric FROM view_emisor WHERE emrut=morutemi )
      END           ,
  'fecemi' = ISNULL( convert(CHAR(10), MDMO.mofecemi, 103), ''),  --7
  'fecven' = ISNULL( convert(CHAR(10), MDMO.mofecven, 103), ''),--8
         'tasemi' = ISNULL( MDMO.motasemi, 0),--9
               'baseemi' = ISNULL( MDMO.mobasemi, 0),--10
               'moneda' = ISNULL( VIEW_MONEDA.mnnemo,''),--11
               'nominal' = ISNULL( MDMO.monominal,0),--12
         'tirvta' = ISNULL( MDMO.motir,  0),--13
         'valpar' = ISNULL( MDMO.mopvp, 0),--14
               'tasest' = ISNULL( MDMO.motasest, 0),--15
               'valpresen' = ISNULL( MDMO.movpresen, 0),--16
               'valventa' = ISNULL( MDMO.movalven, 0),--17
               'utilidad' = ISNULL(convert( FLOAT, case MDMO.moutilidad WHEN 0 THEN (MDMO.moperdida*-1) ELSE MDMO.moutilidad END),0),--18
           'forpago' = ISNULL( VIEW_FORMA_DE_PAGO.glosa, ''),--19
               'tipcust' = ISNULL( MDMO.mocondpacto, ''),--20
  'paghoy' = ISNULL( MDMO.mopagohoy, ''),--21
  'serie'  = ISNULL( VIEW_INSTRUMENTO.inserie, ''),--22
  'numoper' = ISNULL( MDMO.monumoper,0),
  'sw'='0',
  'titulo'=@titulo--23
  INTO #temp
  
 FROM    
  MDMO 
  LEFT JOIN VIEW_MONEDA ON MDMO.momonemi = VIEW_MONEDA.mncodmon,
  MDAC , 
--  VIEW_EMISOR , 
  VIEW_INSTRUMENTO ,
  VIEW_ENTIDAD MDRC ,
                VIEW_CLIENTE            ,
  VIEW_FORMA_DE_PAGO ,
  VIEW_TABLA_GENERAL_DETALLE
        WHERE   
  MDMO.motipoper = 'VP' 
 and MDMO.mostatreg <> 'A' 
 and     MDRC.rcrut     = MDMO.morutcart
 and     (VIEW_CLIENTE.clrut     = MDMO.morutcli
 and     VIEW_CLIENTE.clcodigo  = MDMO.mocodcli)
-- and MDMO.morutemi *= VIEW_EMISOR.emrut
 and     VIEW_INSTRUMENTO.incodigo  = MDMO.mocodigo
        and     VIEW_FORMA_DE_PAGO.codigo    = MDMO.moforpagi
 and     VIEW_TABLA_GENERAL_DETALLE.tbcateg  = 204 
 and     MDMO.motipcart = convert(NUMERIC(6),VIEW_TABLA_GENERAL_DETALLE.tbcodigo1)
 and    (MDMO.morutcart >= @ncartini
 and     MDMO.morutcart <= @ncartfin)
        and    (MDMO.codigo_carterasuper = @carterasuper)
 ORDER BY MDMO.monumoper, MDMO.monumdocu
  ----<< agrupando por instrumento
         SELECT serie, 
  'nominal' = sum(nominal),
  'valpresen' = sum(valpresen),
  'valventa' = sum(valventa),
  'utilidad' = sum(utilidad),
  'Tir'   = sum(valventa*tirvta) / sum(valventa)
       INTO #total  
       FROM #temp  
       GROUP BY serie
      INSERT INTO #temp
      SELECT ' ',--1
  '',--2
   '',--3
  '',--4
  serie,--5
  '',--6
  '',--7
  '',--8
  0,--9
  0,--10
  '',--11
  nominal,--12
  tir,--13
  0,--14
  0,--15
  valpresen,--16
  valventa,--17
  utilidad,--18
  '',--19
  '',--20
  '',--21
  'Total' ,--22
  0,--23
  'sw'='1',
  'RESUMEN ' + @titulo
   from #total
  
        ----<< Control de datos
       SELECT nomcli,--1
               noment,--2
  tipcart,--3
               numdocu,--4
  instser, --5
         emisor,--6
  fecemi,  --7
  fecven,--8
         tasemi,--9
               baseemi,--10
               moneda,--11
               nominal,--12
         tirvta,--13
         valpar,--14
               tasest,--15
               valpresen,--16
               valventa,--17
               utilidad,--18
           forpago,--19
               tipcust,--20
  paghoy,--21
  serie,--22
  numoper,
    
  'acfecproc'  = @acfecproc   ,
           'acfecprox'  = @acfecprox   ,
         'uf_hoy'     = @uf_hoy      ,
  'uf_man'     = @uf_man      ,
         'ivp_hoy'    = @ivp_hoy     ,
  'ivp_man'    = @ivp_man     ,
     'do_hoy'     = @do_hoy      ,
  'do_man'     = @do_man      ,
  'da_hoy'     = @da_hoy      ,
  'da_man'     = @da_man      ,
  'acnomprop'  = @acnomprop   ,
  'rut_empresa' = @rut_empresa,
  'hora'       = @hora,
  sw,
  titulo
           from #temp
          order by serie
 END
 ELSE
         SELECT 'nomcli'  = ' ',--1
               'noment' = ' ',--2
  'tipcart' = ' ',--3
               'numdocu' = '        ',--4
  'instser' = ' ', --5
         'emisor' = ' ',--6
  'fecemi' = '         ',  -- 7
  'fecven' = '         ',--8
         'tasemi' = 0.0,--9
               'baseemi' = 0.0,--10
               'moneda' = ' ',--11
               'nominal' = 0.0,--12
         'tirvta' = 0.0,--13
         'valpar' = 0.0,--14
               'tasest' = 0.0,--15
               'valpresen' = 0.0,--16
               'valventa' = 0.0,--17
               'utilidad' = 0.0,--18
           'forpago' = ' ',--19
               'tipcust' = ' ',--20
  'paghoy' = ' ',--21
  'serie'  = ' ',--22
  'numoper' = '         ' ,
  'acfecproc'  = @acfecproc    ,
           'acfecprox'  = @acfecprox    ,
         'uf_hoy'     = @uf_hoy       ,
  'uf_man'     = @uf_man       ,
         'ivp_hoy'    = @ivp_hoy      ,
  'ivp_man'    = @ivp_man      ,
     'do_hoy'     = @do_hoy       ,
  'do_man'     = @do_man       ,
  'da_hoy'     = @da_hoy       ,
  'da_man'     = @da_man       ,
  'acnomprop'  = @acnomprop    ,
  'rut_empresa' = @rut_empresa ,
  'hora'       = @hora  ,
  'sw'  ='0'  ,
  'titulo' = @titulo
 SET NOCOUNT OFF
END
--Sp_Listvp 0,'P','dfadf'
GO
