USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTRADAY_CARGA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_INTRADAY_CARGA] 
         (   @fechaproceso DATETIME
         )
AS
BEGIN
   SET NOCOUNT ON
   SELECT   'canumoper' = isnull(a.canumoper,0),
            'catipoper' = isnull(a.catipoper,''),
            'catipoper' = isnull(a.cacodpos1,0),
            'caplazo' = isnull(a.caplazo,0)  ,
            'catipcam' = isnull(a.catipcam,0) ,
            'precio_spot' = isnull(a.precio_spot,0),
            'camtomon1' = isnull(a.camtomon1,0) ,  
            'datatec'   = isnull(b.datatec,'')    ,
            'tipodolar' = isnull((SELECT mnnemo FROM VIEW_MONEDA 
                                WHERE mncodmon = a.cacodmon1) + SPACE(15) + '/' + STR(a.cacodmon1), 'USD' + SPACE(15) + '/' + '13'),
            'moneda'    = isnull((SELECT mnnemo FROM VIEW_MONEDA 
                                WHERE mncodmon = a.cacodmon2) + SPACE(15) + '/' + STR(a.cacodmon2), 'USD' + SPACE(15) + '/' + '13'),
            'calzado'   = isnull(a.calzada,'N')      ,
            'modalidad' = isnull(a.catipmoda,'C')     ,
            'area resp' = isnull(a.id_sistema,'BFW') ,
            'prec. transf'   = isnull(a.precio_transferencia,0) ,
            'forma pago M/N' = isnull(a.cafpagomn,2) ,
            'forma pago M/X' = isnull(a.cafpagomx,2) ,
            'observaciones'  = isnull(a.caobserv,'') ,
            'rut cliente '   = isnull(b.clrut,0)     ,
            'cod cliente '   = isnull(b.clcodigo,0)  ,
            'tasa dolar'     = isnull(a.catasadolar,0)      ,
            'tasa pesos'     = isnull(a.catasaufclp,0)      ,
            'riesgo asumido' = isnull(a.riesgo_sintetico,'') ,
            'tipo sintetico' = isnull(a.tipo_sintetico,'')   ,
            'marca'          = isnull(a.marca,'')
      FROM  MFCA a,
            VIEW_SINACOFI b
      WHERE ( CONVERT( CHAR(10),a.cafecha,112) = CONVERT(CHAR(10),@fechaproceso,112) )
        AND ( a.caestado  <> 'A' )
        AND ( a.cacodpos1 = 1  OR a.cacodpos1 = 4 OR a.cacodpos1 = 5 )
        AND ( a.cacodigo  = b.clrut )
      ORDER BY a.canumoper DESC
   SET NOCOUNT OFF
END

GO
