USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEROPERACIONESSINACOFI]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- sp_helptext sp_leeroperacionessinacofi '20071112'


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE PROCEDURE [dbo].[SP_LEEROPERACIONESSINACOFI] ( @cfecha CHAR ( 10 ) )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @dfecproc DATETIME
   DECLARE @cnomprop CHAR ( 40 )
   DECLARE @cdirprop CHAR ( 40 )
   SELECT @dfecproc = acfecproc,
          @cnomprop = acnomprop,
          @cdirprop = acdirprop
   FROM   MFAC
   SELECT   'NroOperacion' = a.canumoper                             ,
            'NomCliente'   = b.clnombre                              ,
            'TipoOperacion'= a.catipoper                             ,
            'FechaVcto'    = CONVERT ( CHAR(10), a.cafecvcto, 103 )  ,
            'MonedaConver' = c.mnnemo                                ,
            'MontoOrigen'  = a.camtomon1                             ,
            'Producto'     = d.descripcion                           ,
            'FechaCompra'  = CONVERT ( CHAR ( 10 ), a.cafecha, 103 ) ,
            'FechaProceso' = CONVERT ( CHAR ( 10 ), @dfecproc, 103 ) ,
            'PlazoResidual'= datediff ( dd, @dfecproc,a.cafecvcto)   ,
            'Plazo'        = a.caplazo                               ,
            'MonedaOrigen' = e.mnnemo                                ,
            'Precio'       = a.catipcam                              ,
            'MontoConver'  = a.camtomon2                             ,
            'NombrePropie' = @cnomprop                               ,
            'DireccPropie' = @cdirprop
   FROM     mfca          a,
            view_cliente  b,
            view_moneda   c,
            view_producto d,
            view_moneda   e
   WHERE    a.catipoper        = 'C'         AND  --- Filtor para Contratos SINACOFI   
	    a.cacodigo         = b.clrut     AND
            a.cacodcli         = b.clcodigo  AND
	    b.cltipcli         = 1           AND
            a.cacodmon2        = c.mncodmon  AND
            a.cacodmon1        = e.mncodmon  AND
            d.id_sistema       = 'BFW'       AND
            d.codigo_producto  = a.cacodpos1 AND
            a.cafecha          = @cFecha     AND
            a.cacodpos1       <> 8           AND
            a.cacodpos1       <> 9
   ORDER BY a.canumoper
   SET NOCOUNT OFF
END

--select Cltipcli, * from view_cliente where cltipcli in (1) order by clnombre

GO
