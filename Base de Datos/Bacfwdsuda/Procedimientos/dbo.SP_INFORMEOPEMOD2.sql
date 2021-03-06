USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORMEOPEMOD2]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORMEOPEMOD2] ( @dfecha   char( 8 ) )
AS
BEGIN
   SET NOCOUNT ON
   SELECT 'Numoper'      = a.canumoper                                                     ,
          'Nombre'       = b.clnombre                                                      ,
          'TipOper'      = a.catipoper                                                     ,
          'Plazo'        = a.caplazo                                                       ,
          'FecVen'       = CONVERT(CHAR(10),a.cafecvcto,103)                               ,
          'Nemo'         = ISNULL ( c.mnnemo, ' ' )                                        ,
          'MtoMex'       = a.camtomon1                                                     ,
          'Precio'       = CASE a.cacodpos1 WHEN 2 THEN a.caparmon1 ELSE a.capremon1 END   ,
          'Preciofinal'  = a.catipcam                                                      ,
          'MtoCnv'       = a.camtomon2                                                     ,
          'Modal'        = a.catipmoda                                                     ,
          'FPMN'         = ISNULL( d.glosa,'N/A' )                                         ,
          'FPMX'         = ISNULL( e.glosa,'N/A' )                                         ,
          'Operador'     = a.caoperador                                                    ,
          'NomProp'      = (Select rcnombre from VIEW_ENTIDAD)                             ,
          'FecPro'       = CONVERT(CHAR(10),f.acfecproc,103)                               ,
          'CodMon'       = g.mnnemo                                                        ,
          'CodCnv'       = h.mnnemo                                                        ,
          'Estado'       = ' '                                                             ,
          'Hora'         = CONVERT(CHAR(08),GETDATE(),108)
   INTO   #tabla_temporal
   FROM   MFCA_LOG           a,
          VIEW_CLIENTE       b,
          VIEW_MONEDA        c,
          VIEW_FORMA_DE_PAGO d,
          VIEW_FORMA_DE_PAGO e,
          MFAC               f,
          VIEW_MONEDA        g,
          VIEW_MONEDA        h
   WHERE  a.cafecmod  = @dfecha      AND
         (a.cacodigo  = b.clrut      AND
          a.cacodcli  = b.clcodigo ) AND
          a.caestado  = 'M'          AND
          a.cacodmon1 = c.mncodmon   AND
          a.cafpagomn = d.codigo     AND
          a.cafpagomx = e.codigo     AND
          a.cacodmon1 = g.mncodmon   AND
          a.cacodmon2 = h.mncodmon  
   INSERT INTO #tabla_temporal ( Numoper    ,
                                 Nombre     ,
                                 TipOper    ,
                                 Plazo      ,
                                 FecVen     ,
                                 Nemo       ,
                                 MtoMex     ,
                                 Precio     ,
                                 Preciofinal,
                                 MtoCnv     ,
                                 Modal      ,
                                 FPMN       ,
                                 FPMX       ,
                                 Operador   ,
                                 NomProp    ,
                                 FecPro     ,
                                 CodMon     ,
                                 CodCnv     ,
                                 Estado     ,
                                 Hora
                               )
   SELECT a.canumoper                                                  ,
          b.clnombre                                                   ,
          a.catipoper                                                  ,
          a.caplazo                                                    ,
          CONVERT(CHAR(10),a.cafecvcto,103)                            ,
          ISNULL ( c.mnnemo, ' ' )                                     ,
          a.camtomon1                                                  ,
          CASE a.cacodpos1 WHEN 2 THEN a.caparmon1 ELSE a.capremon1 END,
          a.catipcam                                                   ,
          a.camtomon2                                                  ,
          a.catipmoda                                                  ,
          ISNULL( d.glosa,'N/A' )                                      ,
          ISNULL( e.glosa,'N/A' )                                      ,
          a.caoperador                                                 ,
          (Select rcnombre from VIEW_ENTIDAD)                          ,
          CONVERT(CHAR(10),f.acfecproc,103)                            ,
          g.mnnemo                                                     ,
          h.mnnemo                                                     ,
          ' '                                                          ,
          CONVERT(CHAR(08),GETDATE(),108)
   FROM   MFCA               a,
          VIEW_CLIENTE       b,
          VIEW_MONEDA        c,
          VIEW_FORMA_DE_PAGO d,
          VIEW_FORMA_DE_PAGO e,
          MFAC               f,
          VIEW_MONEDA        g,
          VIEW_MONEDA        h,
          #tabla_temporal    i
   WHERE  a.cafecmod  = @dfecha      AND
         ( a.cacodigo = b.clrut      AND
          a.cacodcli  = b.clcodigo ) AND
          a.cacodmon1 = c.mncodmon   AND
          a.caestado  = 'M'          AND
          a.cafpagomn = d.codigo     AND
          a.cafpagomx = e.codigo     AND
          a.cacodmon1 = g.mncodmon   AND
          a.cacodmon2 = h.mncodmon   AND
          i.numoper   = a.canumoper
   SET NOCOUNT OFF
   SELECT *
   FROM   #tabla_temporal
END

GO
