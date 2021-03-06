USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Listvctopact]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Listvctopact]
                                    (   @dfecdesde CHAR(10), 
                                 @dfechasta CHAR(10),
     @entidad   numeric(9)= 0 )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @nValor NUMERIC (19,0)
 SELECT @nValor = 1.0
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
 EXECUTE Sp_Base_Del_Informe
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
------------------------------------------------------------------------------------------------
 select 'nomemp' = ISNULL( MDAC.acnomprop, ''),                                                                       
 'rutemp' = ISNULL( ( rtrim (CONVERT( CHAR(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
 'fecpro' = CONVERT(CHAR(10), MDAC.acfecproc, 103),
 'fecdesde' = CONVERT(CHAR(10), @dfecdesde, 103),
 'fechasta' = CONVERT(CHAR(10), @dfechasta, 103),
 'numdoc' = ISNULL( MDCI.cinumdocu, 0),
 'rutcart' = ISNULL( MDCI.cirutcart, 0),
 'correla' = ISNULL( MDCI.cicorrela, 0),
 'numdocu' = rtrim(CONVERT(CHAR(10),ISNULL( MDCI.cinumdocu, 0))) +'-'+ CONVERT(CHAR(3),ISNULL( MDCI.cicorrela, 0)),
 'tipoper' = CASE  WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'IB' ELSE 'CI' END, 
 'serie'  = ISNULL(  MDCI.ciinstser, ''),
 'monemi' = ISNULL(  VIEW_MONEDA.mnnemo,''),
 'fecinip' = CONVERT( CHAR(10), MDCI.cifecinip, 103 ),
 'fecvenp' = CONVERT( CHAR(10), MDCI.cifecvenp, 103 ),
 'taspact' = ISNULL( MDCI.citaspact, 0 ),
 'baspact' = ISNULL( MDCI.cibaspact, 0 ),
 'monpact' = space(05),
 'codmon' = MDCI.cimonpact,
 'nominal' = ISNULL( MDCI.cinominal, 0 ),
 'valinip' = ISNULL( MDCI.civalinip, 0 ),
 'valvenp' = ISNULL( MDCI.civalvenp, 0 ),
 'interes' = CASE cimonpact 
    WHEN 999 then ROUND(ISNULL( MDCI.civalvenp, 0 ) - ISNULL( MDCI.civalinip, 0 ),0)
    ELSE ISNULL( MDCI.civalvenp, 0 ) - ISNULL(MDCI.civalcomu,0 )
     END,
 'entidad' = MDRC.rcnombre,
 'valinipum' = CASE cimonpact WHEN 999 THEN ISNULL( MDCI.civalinip, 0 )
    ELSE  ISNULL( MDCI.civalcomu,0 )
     END,
 'subtitulo' = CASE
    WHEN CHARINDEX(RTRIM(ciinstser),'ICOL')>0 THEN 'COLOCACIONES            '
    WHEN CHARINDEX(RTRIM(ciinstser),'ICAP')>0 THEN 'CAPTACIONES             '
    WHEN CHARINDEX(RTRIM(ciinstser),'ICOL-ICAP')<=0 AND cimonpact=999 THEN 'COMPRAS CON PACTO PESOS '
    ELSE 'COMPRAS CON PACTO EN UF '
     END
 INTO   #TEMP1
 FROM   MDAC, MDCI, VIEW_ENTIDAD MDRC, VIEW_MONEDA
 WHERE  
  (@entidad=0 or MDCI.cirutcart = @entidad )
 AND    MDCI.cifecvenp >= @dfecdesde
 AND    MDCI.cifecvenp <= @dfechasta
 AND    MDCI.cirutcart = MDRC.rcrut
 AND    cimonemi     *= VIEW_MONEDA.mncodmon
 ORDER BY MDCI.cinumdocu,
 MDCI.cicorrela,MDCI.tipoper
     ---------------------------------------------------
     -- seleccionamos todos los campos de la tabla MDVI
     ---------------------------------------------------
 select 'nomemp' = ISNULL( MDAC.acnomprop, ''),                                                                       
 'rutemp' = ISNULL( ( rtrim (CONVERT( CHAR(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),               
 'fecpro' = CONVERT(CHAR(10), MDAC.acfecproc, 103),                                                            
 'fecdesde' = CONVERT(CHAR(10), @dfecdesde, 103),
 'fechasta' = CONVERT(CHAR(10), @dfechasta, 103),
 'numdoc' = ISNULL( MDVI.vinumdocu, 0),
 'rutcart' = ISNULL( MDVI.virutcart, 0),
 'correla' = ISNULL( MDVI.vicorrela, 0),
 'numdocu' = rtrim(CONVERT(CHAR(10),ISNULL( MDVI.vinumdocu, 0))) +'-'+ CONVERT(CHAR(03),ISNULL( MDVI.vicorrela, 0)), 
 'tipoper' = 'VI', 
 'serie'  = MDVI.viinstser,
 'monemi' = ISNULL(VIEW_MONEDA.mnnemo,''),
 'fecinip' = CONVERT(CHAR(10),MDVI.vifecinip,103),
 'fecvenp' = CONVERT(CHAR(10),MDVI.vifecvenp,103),
 'taspact' = ISNULL(MDVI.vitaspact,0),
 'baspact' = ISNULL(MDVI.vibaspact,0),
 'monpact' = space(05),
 'codmon' = MDVI.vimonpact,
 'nominal' = ISNULL( MDVI.vinominal, 0 ),
 'valinip' = ISNULL( MDVI.vivalinip, 0 ),
 'valvenp' = ISNULL( MDVI.vivalvenp, 0 ),
 'interes' = CASE WHEN vimonpact=999                 THEN ROUND( ISNULL( MDVI.vivalvenp, 0 ) - MDVI.vivalinip ,0)
          WHEN VIEW_VALOR_MONEDA.vmvalor = 0 THEN ROUND( ISNULL( MDVI.vivalvenp, 0 ) - MDVI.vivalinip ,4)
           ELSE ROUND(ISNULL( MDVI.vivalvenp, 0 ) - ROUND(MDVI.vivalinip / ISNULL(VIEW_VALOR_MONEDA.vmvalor,@nValor),4) ,4)
     END,
 'entidad' = MDRC.rcnombre,
 'valinipum' = CASE  WHEN vimonpact=999                 THEN ROUND(MDVI.vivalinip ,0)
            WHEN VIEW_VALOR_MONEDA.vmvalor = 0 THEN ROUND( ISNULL( MDVI.vivalvenp, 0 ) - MDVI.vivalinip ,4)
    ELSE ROUND(MDVI.vivalinip / ISNULL(VIEW_VALOR_MONEDA.vmvalor,@nValor),4)
     END,
 'subtitulo' = CASE
    WHEN vimonpact=999 THEN 'VENTAS CON PACTO PESOS '
    WHEN vimonpact=998 THEN 'VENTAS CON PACTO UF    '
    ELSE 'DOLARES'
     END
 INTO #TEMP2
 FROM MDAC, MDVI, VIEW_ENTIDAD MDRC, VIEW_MONEDA, VIEW_VALOR_MONEDA
 WHERE MDVI.vifecvenp >= @dfecdesde
  AND MDVI.vifecvenp <= @dfechasta
  AND (@entidad=0 or MDVI.virutcart = @entidad )
  AND    MDVI.virutcart = MDRC.rcrut
  AND MDVI.vifecinip *= VIEW_VALOR_MONEDA.vmfecha
  AND MDVI.vimonpact *= VIEW_VALOR_MONEDA.vmcodigo
  AND MDVI.vimonemi  *= mncodmon
 ORDER BY MDVI.vinumdocu, MDVI.vicorrela
      update #TEMP1 set monpact = ISNULL(VIEW_MONEDA.mnnemo,'')
      FROM   #TEMP1, VIEW_MONEDA 
      WHERE  #TEMP1.codmon = VIEW_MONEDA.mncodmon
      update #TEMP2 set monpact = ISNULL(VIEW_MONEDA.mnnemo,'')
      FROM   #TEMP2, VIEW_MONEDA 
      WHERE  #TEMP2.codmon = VIEW_MONEDA.mncodmon
    ------------------------------------------------------
    -- traspasamos registros de la tabla temporal 2
    -- y de la tabla temporal 3 a la temporal 1
    ------------------------------------------------------
 insert INTO #TEMP1 select
 #TEMP2.nomemp  ,
 #TEMP2.rutemp  ,
 #TEMP2.fecpro  ,
 #TEMP2.fecdesde,
 #TEMP2.fechasta,
 #TEMP2.numdoc,
 #TEMP2.rutcart,
 #TEMP2.correla,
 #TEMP2.numdocu ,
 #TEMP2.tipoper ,
 #TEMP2.serie   ,
 #TEMP2.monemi  ,
 #TEMP2.fecinip ,
 #TEMP2.fecvenp ,
 #TEMP2.taspact ,
 #TEMP2.baspact ,
 #TEMP2.monpact ,
 #TEMP2.codmon,
 #TEMP2.nominal ,
 #TEMP2.valinip ,
 #TEMP2.valvenp ,
 #TEMP2.interes ,
 #TEMP2.entidad ,
 #TEMP2.valinipum,
 #TEMP2.subtitulo   
 
 FROM   #TEMP2
 ORDER BY #TEMP2.tipoper,
 #TEMP2.numdoc ,
 #TEMP2.correla
   IF EXISTS( SELECT * FROM #TEMP1 ) BEGIN
      SELECT 
 nomemp,
 rutemp,
 fecpro,
 fecdesde,
 fechasta,
 numdoc,
 rutcart,
 correla,
 numdocu,
 tipoper,
 serie,
 monemi,
 fecinip,
 fecvenp,
 taspact,
 baspact,
 monpact,
 codmon,
 nominal,
 valinip,
 valvenp,
 interes,
 entidad,
 valinipum,
 subtitulo,
 'acfecproc' = @acfecproc   ,
 'acfecprox' = @acfecprox   ,
 'uf_hoy' = @uf_hoy      ,
 'uf_man' = @uf_man      ,
 'ivp_hoy' = @ivp_hoy     ,
 'ivp_man' = @ivp_man     ,
 'do_hoy' = @do_hoy      ,
 'do_man' = @do_man      ,
 'da_hoy' = @da_hoy      ,
 'da_man' = @da_man      ,
 'acnomprop' = @acnomprop   ,
 'rut_empresa' = @rut_empresa,
 'hora'  = @hora
  
         FROM
             #TEMP1
         ORDER BY 
             TIPOPER, FECVENP, MONPACT END
   ELSE BEGIN
 SELECT
 'nomemp'=' ',
 'rutemp'=0,
 'fecpro'='  ',
 'fecdesde'=CONVERT(CHAR(10), @dfecdesde, 103),
 'fechasta'=CONVERT(CHAR(10), @dfechasta, 103),
 'numdoc'=0,
 'rutcart'=0,
 'correla'=0,
 'numdocu'='        ',
 'tipoper'='        ',
 'serie'='          ',
 'monemi'='                        ',
 'fecinip'='        ',
 'fecvenp'='        ',
 'taspact'=0.0,
 'baspact'=0.0,
 'monpact'='         ',
 'codmon'= 0,
 'nominal'=0.0,
 'valinip'=0.0,
 'valvenp'=0.0,
 'interes'=0.0,
 'entidad'=' ',
 'valinipum'=0.0,
 'subtitulo'='                    ',
 'acfecproc' = @acfecproc   ,
 'acfecprox' = @acfecprox   ,
 'uf_hoy' = @uf_hoy      ,
 'uf_man' = @uf_man      ,
 'ivp_hoy' = @ivp_hoy     ,
 'ivp_man' = @ivp_man     ,
 'do_hoy' = @do_hoy      ,
 'do_man' = @do_man      ,
 'da_hoy' = @da_hoy      ,
 'da_man' = @da_man      ,
 'acnomprop' = @acnomprop   ,
 'rut_empresa' = @rut_empresa,
 'hora'  = @hora
 END
 SET NOCOUNT OFF
end
GO
