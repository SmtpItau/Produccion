USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_MFCA]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RPT_MFCA]
   (   @Fecha   CHAR(8)   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT 'canumoper'      = c.canumoper
   ,	  'cacodmon1'      = c.cacodmon1
   ,	  'mnnemo'         = m.mnnemo
   ,      'cacodigo'       = c.cacodigo
   ,      'clnombre'       = l.clnombre
   ,	  'cafecha'        = c.cafecha
   ,	  'fecharecepcion' = c.fecharecepcion
   ,	  'fVal_Obtenido'  = c.fVal_Obtenido
   ,	  'fRes_Obtenido'  = c.fRes_Obtenido
   ,	  'caobservlin'    = c.caobservlin
   ,	  'Modalidad'      = CASE WHEN c.catipmoda = 'C' THEN 'COMPENSACION' ELSE 'E. FISICA' END
   ,	  'TipoOpera'      = CASE WHEN c.catipoper = 'C' THEN 'COMPRA'       ELSE 'VENTA'     END
   ,	  'cacodpos1'      = c.cacodpos1
   ,      'descripcion'    = p.descripcion
   ,	  'VAPC'           = ISNULL(clt_vptc_valact,0)
   ,	  'VAPM'           = ISNULL(clt_vptm_valact,0)
   ,	  'DIFERENCIA'     = ISNULL(clt_res_vm_vp,0)
   FROM   MFCA   c
          LEFT JOIN BacParamSuda..CLIENTE                    l ON c.cacodigo    = l.clrut AND c.cacodcli    = l.clcodigo
          LEFT JOIN BacParamSuda..MONEDA                     m ON c.cacodmon1   = m.mncodmon
          LEFT JOIN BacParamSuda..PRODUCTO                   p ON p.id_sistema  = 'BFW'   AND c.cacodpos1   = CONVERT(INT,codigo_producto)
          LEFT JOIN BacTraderSuda..TBL_CARTERA_LIBRE_TRADING t ON t.Clt_Sistema = 'BFW'   AND t.Clt_NumOper = c.canumoper AND t.Clt_FechaProc = @Fecha
   WHERE  c.cafecha      <= @Fecha

END

GO
