USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGAVENCIMIENTOS]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGAVENCIMIENTOS]
   (   @fecha_proceso   DATETIME   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT Producto	 = b.descripcion
   ,      Folio		 = a.canumoper
   ,      Cliente	 = c.clnombre
   ,      Moneda1	 = d.mnnemo
   ,      Moneda2    = e.mnnemo
   ,      Monto		 = a.camtomon1
   ,      MedioPago	 = ISNULL(f.glosa,'')
   ,      CodigoPago = a.cafpagomn
   ,	  DesMonPago = MonPago.mnglosa
   ,	  MonPago	 = MonPago.mncodmon
   ,	  CodProducto= a.cacodpos1	
   FROM   MFCA                          a with (nolock)
          LEFT  JOIN VIEW_FORMA_DE_PAGO f with (nolock) ON a.cafpagomn  = f.codigo
          INNER JOIN VIEW_PRODUCTO      b with (nolock) ON b.id_sistema = 'BFW'      AND b.codigo_producto = a.cacodpos1
          INNER JOIN VIEW_CLIENTE       c with (nolock) ON c.clrut      = a.cacodigo AND c.clcodigo        = a.cacodcli
          INNER JOIN VIEW_MONEDA        d with (nolock) ON d.mncodmon   = a.cacodmon1
          INNER JOIN VIEW_MONEDA        e with (nolock) ON e.mncodmon   = a.cacodmon2
          LEFT  JOIN VIEW_MONEDA  MonPago with (nolock) ON MonPago.mncodmon = CASE WHEN a.cacalcmpdol                    <> 0 THEN a.cacalcmpdol
										   WHEN a.cacodpos1 = 1 AND a.cacalcmpdol = 0 THEN 999
										   WHEN a.cacodpos1 = 2 AND a.cacalcmpdol = 0 THEN case when c.clpais = 6 then 999 else 13 end
										   ELSE						   a.cacodmon2 
									      END
   WHERE  a.cacodpos1                   IN(1,2,3,7,10,11,12,14)
   AND    a.cafecvcto                   <= @fecha_proceso
   AND    a.caantici                    <> 'A'
END
GO
