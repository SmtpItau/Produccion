USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_VENCIMIENTOS]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFORME_VENCIMIENTOS]
   (   @dFechaVcto   DATETIME   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso   DATETIME
   SET     @dFechaProceso   = (SELECT acfecproc FROM BacFwdSuda..MFAC)

   IF @dFechaProceso = @dFechaVcto
   BEGIN
      SELECT 'Producto'           = d.descripcion
      ,      'Tipo Operacion'     = a.catipoper
      ,      'Nombre Cliente'     = c.clnombre
      ,      'Moneda M/X'         = CASE WHEN a.cacodpos1 = 10 THEN e.mnnemo               ELSE e.mnnemo    END
      ,      'Monto M/X'          = CASE WHEN a.cacodpos1 = 10 THEN a.camtomon1            ELSE a.camtomon1 END
      ,      'Tipo Cambio'        = CASE WHEN a.cacodpos1 = 10 THEN a.catipcam             ELSE a.catipcam  END
      ,      'Valor Futuro'       = CASE WHEN a.cacodpos1 = 10 THEN a.devengo_acum_usd_hoy ELSE a.caprecal  END
      ,      'Moneda CNV'         = CASE WHEN a.cacodpos1 = 10 THEN f.mnnemo               ELSE f.mnnemo    END
      ,      'Monto Final'        = CASE WHEN a.cacodpos1 = 10 THEN A.camtoliq             ELSE a.camtomon2 END
      ,      'NumeroOperacion'    = a.canumoper
      ,      'Fecha Inicio'       = CONVERT(CHAR(10),a.cafecha,103)
      ,      'Fecha Proceso'      = CONVERT(CHAR(10),@dFechaProceso,103)
      ,      'Monto Compensado'   = CASE WHEN a.cacodpos1 = 10  THEN a.camtocomp
                                         WHEN a.caantici  = 'A' THEN a.camtoliq
                                         WHEN a.catipmoda = 'C' THEN a.camtocomp
                                         ELSE                        0.0
                                    END
      ,      'Fecha Vcto'         = CONVERT(CHAR(10),a.cafecvcto,103)
      ,      'Modalidad'          = CASE WHEN a.catipmoda = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
      ,      'Hora'               = CONVERT(CHAR(10),GETDATE(),108)
      ,      'FechaEmision'       = CONVERT(CHAR(10),GETDATE(),103)
      ,      'HoraEmision'        = CONVERT(CHAR(10),GETDATE(),108)
      ,      'RutCliente'         = LTRIM(RTRIM(a.cacodigo)) + '-' + CONVERT(CHAR(1),c.cldv)
      FROM   MFCA a   
             LEFT JOIN BacParamSuda..CLIENTE  c ON a.cacodigo   = c.clrut AND a.cacodcli        = c.clcodigo
             LEFT JOIN BacParamSuda..PRODUCTO d ON d.id_sistema = 'BFW'   AND d.codigo_producto = a.cacodpos1
             LEFT JOIN BacParamSuda..MONEDA   e ON e.mncodmon   = a.cacodmon1
             LEFT JOIN BacParamSuda..MONEDA   f ON f.mncodmon   = a.cacodmon2
      WHERE  a.cafecvcto       <= @dFechaVcto
      ORDER BY a.cacodigo, a.cacodcli, a.cacodpos1, a.catipoper

   END ELSE
   BEGIN

      SELECT 'Producto'           = d.descripcion
      ,      'Tipo Operacion'     = a.catipoper
      ,      'Nombre Cliente'     = c.clnombre
      ,      'Moneda M/X'         = CASE WHEN a.cacodpos1 = 10 THEN e.mnnemo               ELSE e.mnnemo    END
      ,      'Monto M/X'          = CASE WHEN a.cacodpos1 = 10 THEN a.camtomon1            ELSE a.camtomon1 END
      ,      'Tipo Cambio'        = CASE WHEN a.cacodpos1 = 10 THEN a.catipcam             ELSE a.catipcam  END
      ,      'Valor Futuro'       = CASE WHEN a.cacodpos1 = 10 THEN a.devengo_acum_usd_hoy ELSE a.caprecal  END
      ,      'Moneda CNV'         = CASE WHEN a.cacodpos1 = 10 THEN f.mnnemo               ELSE f.mnnemo    END
      ,      'Monto Final'        = CASE WHEN a.cacodpos1 = 10 THEN A.camtoliq             ELSE a.camtomon2 END
      ,      'NumeroOperacion'    = a.canumoper
      ,      'Fecha Inicio'       = CONVERT(CHAR(10),a.cafecha,103)
      ,      'Fecha Proceso'      = CONVERT(CHAR(10),@dFechaProceso,103)
      ,      'Monto Compensado'   = CASE WHEN a.cacodpos1 = 10  THEN a.camtocomp
                                         WHEN a.caantici  = 'A' THEN a.camtoliq
                                         WHEN a.catipmoda = 'C' THEN a.camtocomp
                                         ELSE                        0.0
                                    END
      ,      'Fecha Vcto'         = CONVERT(CHAR(10),a.cafecvcto,103)
      ,      'Modalidad'          = CASE WHEN a.catipmoda = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
      ,      'Hora'               = CONVERT(CHAR(10),GETDATE(),108)
      ,      'FechaEmision'       = CONVERT(CHAR(10),GETDATE(),103)
      ,      'HoraEmision'        = CONVERT(CHAR(10),GETDATE(),108)
      ,      'RutCliente'         = LTRIM(RTRIM(a.cacodigo)) + '-' + CONVERT(CHAR(1),c.cldv)
      FROM   MFCARES a   
             LEFT JOIN BacParamSuda..CLIENTE  c ON a.cacodigo   = c.clrut AND a.cacodcli        = c.clcodigo
             LEFT JOIN BacParamSuda..PRODUCTO d ON d.id_sistema = 'BFW'   AND d.codigo_producto = a.cacodpos1
             LEFT JOIN BacParamSuda..MONEDA   e ON e.mncodmon   = a.cacodmon1
             LEFT JOIN BacParamSuda..MONEDA   f ON f.mncodmon   = a.cacodmon2
      WHERE  a.CaFechaProceso   = @dFechaVcto
      AND    a.cafecvcto       <= @dFechaVcto
      ORDER BY a.cacodigo, a.cacodcli, a.cacodpos1, a.catipoper

   END

END
GO
