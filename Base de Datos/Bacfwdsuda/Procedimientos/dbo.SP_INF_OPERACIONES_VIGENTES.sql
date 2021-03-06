USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_OPERACIONES_VIGENTES]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_INF_OPERACIONES_VIGENTES]( @rut    FLOAT,
                                             @codcli FLOAT
     )
AS BEGIN
DECLARE @observado    NUMERIC(12,04) ,
   @uf      NUMERIC(12,04) ,
   @fecha_observado  CHAR(10) ,
   @fecha_uf    CHAR(10) ,
 @entidad  char(40),
        @ENTDAD                 char(40)
select @entidad = acnomprop from mfac
 EXECUTE sp_parametros_reporte  @observado        OUTPUT ,
                                @uf               OUTPUT ,
                                @fecha_observado  OUTPUT ,
                                @fecha_uf         OUTPUT
SELECT  Ocacodigo   = cacodigo,
        Ocatipoper  = catipoper,
        Ocanumoper  = canumoper,
        Ocafecha    = cafecha,
        Ocafecvcto  = cafecvcto,
        Ocamtomon1  = camtomon1, -- 2 decimales
        Ocamtomon2  = camtomon2, -- si cacodmon2 = 998 4 decimales , cacodmon2 = 999 0 decimales , 2 decimales
        OtipoMon    = cacodmon2,
        Ocacodpos1  = CASE WHEN cacodpos1 = 1 THEN caprecal ELSE catipcam END,
        Ocavalordia = cavalordia,
        Ocatipmoda  = catipmoda,
        Oproducto   = ( SELECT descripcion FROM view_producto WHERE cacodpos1 = codigo_producto),
        Ocliente    = ( SELECT clnombre FROM view_cliente WHERE cacodigo = clrut and cacodcli = clcodigo ),
        OValorDO    = @observado ,
        OValorUF    = @uf  ,
        fecha_obs   = @fecha_observado ,
        fecha_uf    = @fecha_uf  ,
        Ohora       = CONVERT(CHAR(8),getdate(),108),
        Fecha_Proc  = acfecproc  ,
        'entidad' = @entidad
       INTO #OP_VIG
       FROM MFCA,MFAC --, VIEW_CLIENTE
       WHERE cafecvcto > acfecproc AND ( cacodpos1 = 1 OR cacodpos1 = 2 OR cacodpos1 =3 )
       AND ( cacodigo = @rut
       AND   cacodcli = @codcli )
 DECLARE @NETO NUMERIC
 SELECT  Ocacodigo,
           Ocatipoper,
           Ocanumoper,
           Ocafecha,
           Ocafecvcto,
           Ocamtomon1,
           Ocamtomon2,
           OtipoMon,
           Ocacodpos1,
           Ocavalordia,
           Ocatipmoda,
           Oproducto,
           Ocliente,
           OValorDO,
           OValorUF,
           fecha_obs,
           fecha_uf,
           Ohora,
           OTOTEXP = (SELECT sum(Ocavalordia) FROM #OP_VIG),
           OTOTMON = (SELECT sum(Ocamtomon1) FROM #OP_VIG),
           ONETO = isnull((SELECT sum(Ocamtomon1) FROM #OP_VIG WHERE Ocatipoper='C'),0) - isnull((SELECT sum(Ocamtomon1) FROM #OP_VIG WHERE Ocatipoper='V'),0),
           fecha_proc = fecha_proc  ,
           'entidad' = @entidad
  
 INTO #OP
 FROM #OP_VIG
 IF EXISTS( SELECT * FROM #OP ) 
  SELECT * FROM #OP --ORDER BY Ocatipoper
 ELSE
 SELECT 'Ocacodigo'       = 0,
        'Ocatipoper'      = '',
        'Ocanumoper'      =0,
        'Ocafecha'         = '',
        'Ocafecvcto'      = '',
        'Ocamtomon1'      =0,
        'Ocamtomon2'      =0,
        'OtipoMon'        =0,
        'Ocacodpos1'      =0,
        'Ocavalordia'     =0,
        'Ocatipmoda'      = '',
        'Oproducto'       ='0',
        'Ocliente'        ='',
        'OValorDO'        = @observado ,
        'OValorUF'        = @uf  ,
        'fecha_obs'       = @fecha_observado ,
        'fecha_uf'        = @fecha_uf  ,
        'Ohora'           = CONVERT(CHAR(8),getdate(),108),
        'OTOTEXP'         = 0,
        'OTOTMON'         = 0,
        'ONETO'           = 0,
        'fecha_proc'      = ACFECPROC,
        'entidad'         = @entidad
    FROM MFAC
 
 
END
/*
SELECT  catipoper, canumoper, cafecha, cafecvcto, camtomon1,  camtomon2, cacodpos1,  cavalordia, catipmoda 
FROM mfca
SP_INF_OPERACIONES_VIGENTES 97041000,1
*/

GO
