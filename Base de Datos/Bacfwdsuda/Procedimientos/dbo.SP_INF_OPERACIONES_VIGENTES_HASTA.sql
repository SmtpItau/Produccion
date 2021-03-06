USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_OPERACIONES_VIGENTES_HASTA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_INF_OPERACIONES_VIGENTES_HASTA] ( @rut   FLOAT,
                                          @codcli FLOAT,
                                                @dfechasta char(8)   )
AS BEGIN
SET NOCOUNT ON
 DECLARE @observado  NUMERIC(12,04) ,
  @uf   NUMERIC(12,04) ,
  @fecha_observado CHAR(10) ,
  @fecha_uf  CHAR(10) ,
  @entidad char(40)
select @entidad  = acnomprop from mfac
 EXECUTE sp_parametros_reporte  @observado  OUTPUT ,
     @uf   OUTPUT ,
     @fecha_observado OUTPUT ,
     @fecha_uf  OUTPUT
 SELECT  Ocacodigo   = cacodigo     ,
  Ocatipoper  = catipoper    ,
  Ocanumoper  = canumoper    ,
  Ocafecha    = CONVERT(CHAR(10),cafecha,103)  ,
  Ocafecvcto  = CONVERT(CHAR(10),cafecvcto,103)    ,
  Ocamtomon1  = camtomon1    , -- 2 decimales
  Ocamtomon2  = camtomon2    , -- si cacodmon2 = 998 4 decimales , cacodmon2 = 999 0 decimales , 2 decimales
  OtipoMon    = cacodmon2    ,
  Ocacodpos1  = CASE WHEN cacodpos1 = 1 THEN caprecal ELSE catipcam END   ,
  Ocavalordia = CASE WHEN caantici = 'A' THEN camtoliq ELSE camtocomp END ,
  Ocatipmoda  = catipmoda                                                 ,
  Oproducto   = ( SELECT descripcion FROM view_producto WHERE cacodpos1 = codigo_producto)          ,
  Ocliente    = ( SELECT clnombre FROM view_cliente WHERE cacodigo = clrut and cacodcli = clcodigo ),
  OValorDO    = @observado ,
  OValorUF    = @uf  ,
  fecha_obs   = @fecha_observado ,
  fecha_uf    = @fecha_uf  ,
  Ohora       = CONVERT(CHAR(8),GETDATE(),108),
                OPlazo      = caplazoope,
                OSpot       = case when cacodpos1 = 1 then (SELECT b.vmvalor from  mfac a              ,
                                                                                 view_valor_moneda b , 
                                                                                 view_valor_moneda c
                                                            where b.vmfecha  = a.acfecproc       AND
                                                                  b.vmcodigo = a.accodmondolobs  AND
                                                                  c.vmfecha  = a.acfecproc       AND
                                                                  c.vmcodigo = a.accodmonuf)
                                   when cacodpos1 = 2 then caparmon1
                                   when cacodpos1 = 3 then accodmonuf  end,
  'Fecha_repor' = CONVERT(CHAR(10),acfecproc,103),
  'ORDEN'      = CONVERT(CHAR(8),cafecvcto,112)    ,
 'entidad'    = acnomprop
  
 INTO #OP_VIG
 FROM MFCA,MFAC
 WHERE ( cacodpos1 = 1 OR cacodpos1 = 2 OR cacodpos1 =3) --cafecvcto > acfecproc AND 
 AND ( cacodigo = @rut
 AND   cacodcli = @codcli )  
        AND  cafecvcto >= @dfechasta
        AND  cafecha <= @dfechasta
 DECLARE @NETO NUMERIC
 SELECT  Ocacodigo   ,
  Ocatipoper  ,
  Ocanumoper  ,
  Ocafecha    ,
  Ocafecvcto  ,
  Ocamtomon1  ,
  Ocamtomon2  ,
  OtipoMon    ,
  Ocacodpos1  ,
  Ocavalordia ,
  Ocatipmoda  ,
  Oproducto   ,
  Ocliente    ,
  OValorDO    ,
   OValorUF    , 
  fecha_obs   ,
   fecha_uf    ,
  Ohora       ,
  OTOTEXP = (SELECT SUM(Ocavalordia) FROM #OP_VIG),
  OTOTMON = (SELECT SUM(Ocamtomon1) FROM #OP_VIG),
  ONETO = ISNULL((SELECT SUM(Ocamtomon1) FROM #OP_VIG WHERE Ocatipoper='C'),0) - ISNULL((SELECT SUM(Ocamtomon1) FROM #OP_VIG WHERE Ocatipoper='V'),0),
                fechahasta = CONVERT (datetime,@dfechasta),
                OPlazo ,
                OSpot,         
  Fecha_repor = Fecha_repor,
  ORDEN  
 INTO #OP
 FROM #OP_VIG
 SELECT  Ocacodigo   = cacodigo  ,
  Ocatipoper  = catipoper ,
  Ocanumoper  = canumoper ,
  Ocafecha    = CONVERT(CHAR(10),cafecha,103)   ,
  Ocafecvcto  = CONVERT(CHAR(10),cafecvcto,103) ,
  Ocamtomon1  = camtomon1 , -- 2 decimales
  Ocamtomon2  = camtomon2 , -- si cacodmon2 = 998 4 decimales , cacodmon2 = 999 0 decimales , 2 decimales
  OtipoMon    = cacodmon2 ,
  Ocacodpos1  = CASE WHEN cacodpos1 = 1 THEN caprecal ELSE catipcam END,
  Ocavalordia = CASE WHEN  caantici = 'A' THEN camtoliq  ELSE camtocomp END,
  Ocatipmoda  = catipmoda ,
  Oproducto   = ( SELECT descripcion FROM view_producto WHERE cacodpos1 = codigo_producto),
  Ocliente    = ( SELECT clnombre FROM view_cliente WHERE cacodigo = clrut and cacodcli = clcodigo ),
  OValorDO    = @observado ,
   OValorUF    = @uf  ,
  fecha_obs   = @fecha_observado ,
   fecha_uf    = @fecha_uf  ,
  Ohora       = CONVERT(CHAR(8),GETDATE(),108),
                OPlazo      = caplazoope,
                OSpot       = case when cacodpos1 = 1 then (SELECT b.vmvalor from  mfac a            ,
                                                                                 view_valor_moneda b , 
                                                                                 view_valor_moneda c
                                                            where b.vmfecha  = a.acfecproc       AND
                                                                  b.vmcodigo = a.accodmondolobs  AND
                                                                  c.vmfecha  = a.acfecproc       AND
                                                                  c.vmcodigo = a.accodmonuf)
                                   when cacodpos1 = 2 then caparmon1
                                   when cacodpos1 = 3 then accodmonuf  end                ,
                'Fecha_repor' = CONVERT(CHAR(10),acfecproc,103),
  'ORDEN'      = CONVERT(CHAR(8),cafecvcto,112)    ,
'entidad'    = acnomprop
 INTO #OP_VIG2
 FROM MFCAH,MFAC, view_valor_moneda
 WHERE ( cacodpos1 = 1 OR cacodpos1 = 2 OR cacodpos1 =3 ) --cafecvcto > acfecproc AND 
 AND (cacodigo = @rut
 AND  cacodcli = @codcli ) 
        AND  cafecvcto >= @dfechasta 
        AND  cafecha <= @dfechasta
 SELECT  Ocacodigo   ,
  Ocatipoper  ,
  Ocanumoper  ,
  Ocafecha    ,
  Ocafecvcto  ,
  Ocamtomon1  ,
  Ocamtomon2  ,
  OtipoMon    ,
  Ocacodpos1  ,
  Ocavalordia ,
  Ocatipmoda  ,
  Oproducto   ,
  Ocliente    ,
  OValorDO    ,
   OValorUF    ,
  fecha_obs   ,
   fecha_uf    ,
  Ohora       ,
  OTOTEXP = (SELECT SUM(Ocavalordia) FROM #OP_VIG),
  OTOTMON = (SELECT SUM(Ocamtomon1) FROM #OP_VIG),
  ONETO   = ISNULL((SELECT SUM(Ocamtomon1) FROM #OP_VIG WHERE Ocatipoper='C'),0) - ISNULL((SELECT SUM(Ocamtomon1) FROM #OP_VIG WHERE Ocatipoper='V'),0),              
                fechahasta = CONVERT (datetime,@dfechasta),
                OPlazo      ,
                OSpot  ,
                Fecha_repor = Fecha_repor,
  ORDEN
 INTO #OP2
 FROM #OP_VIG2
        IF EXISTS(  SELECT * FROM #OP 
          UNION
          SELECT * FROM #OP2  
  )
  BEGIN
   SELECT * FROM #OP 
   UNION
          SELECT * FROM #OP2  
   ORDER BY ORDEN
  END
 ELSE
  BEGIN
   SELECT  'Ocacodigo' = 0   ,
    'Ocatipoper' = ''  ,
    'Ocanumoper' = 0  ,
    'Ocafecha' = ''   ,
    'Ocafecvcto' = ''  ,
    'Ocamtomon1' = 0  ,
    'Ocamtomon2' = 0  ,
    'OtipoMon' = 0    ,
    'Ocacodpos1' = 0  ,
    'Ocavalordia' = 0 ,
    'Ocatipmoda' = ''  ,
    'Oproducto' = ''   ,
    'Ocliente' = ''    ,
    'OValorDO'    = @observado ,
     'OValorUF'    = @uf  ,
    'fecha_obs'   = @fecha_observado ,
     'fecha_uf'    = @fecha_uf  ,
    'Ohora' =    CONVERT(CHAR(8),GETDATE(),108)   ,
    'OTOTEXP' = 0,
    'OTOTMON' = 0,
    'ONETO'   = 0,              
    'fechahasta' = CONVERT (datetime,@dfechasta),
    'OPlazo' = 0      ,
    'OSpot' = 0,
    'Fecha_repor' = CONVERT(CHAR(10),acfecproc,103),
    'entidad'    = acnomprop
   FROM mfac
  END
SET NOCOUNT OFF 
END
-- SP_INF_OPERACIONES_VIGENTES_HASTA 97041000,1,'20011031'
-- select cacodigo,cacodcli,cafecvcto, cacodpos1 from mfca,mfac where (cacodpos1 = 1 or cacodpos1 = 2 or cacodpos1 = 3) and cafecvcto >= '20010523' and cafecha <= '20010523' and cacodigo = '97030000' and cacodcli = '1' and cafecvcto > acfecproc
-- select CONVERT(CHAR(10),ACFECPROC,103)  from mfaC
-- select caparmon1 from mfcah
-- select * from view_cliente where clnombre like '%BANCO DEL ESTADO%'

GO
