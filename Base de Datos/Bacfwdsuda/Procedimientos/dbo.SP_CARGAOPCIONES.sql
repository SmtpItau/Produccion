USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGAOPCIONES]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CARGAOPCIONES]( @fecha_proceso     DATETIME,
         @ultimo_dia_habil  CHAR(2) )
AS
BEGIN
SET NOCOUNT ON
IF @ultimo_dia_habil = 'SI'
 BEGIN
  SELECT b.descripcion  ,
   a.canumoper  ,
   c.clnombre  ,
   d.mnnemo  ,
   e.mnnemo  ,
   a.camtomon1  ,
   a.tc_calculo_mes_actual
  FROM mfca  a ,
   VIEW_PRODUCTO b ,
   VIEW_CLIENTE c ,
   VIEW_MONEDA d ,
   VIEW_MONEDA e
  WHERE  (a.cacodpos1  = 8   OR 
   a.cacodpos1  = 9 )   AND
   (a.cacodigo = c.clrut  AND
   a.cacodcli = c.clcodigo)  AND
   a.cacodmon1 = d.mncodmon  AND
   a.cacodmon2 = e.mncodmon  AND
   a.cacodpos1  = b.codigo_producto
 END
--     b.tc_calculo_mes_actual 
ELSE
 BEGIN
  SELECT b.descripcion  ,
   a.canumoper  ,
   c.clnombre  ,
   d.mnnemo  ,
   e.mnnemo  ,
   a.camtomon1  ,
   a.tc_calculo_mes_actual
  FROM mfca  a ,
   VIEW_PRODUCTO b ,
   VIEW_CLIENTE c ,
   VIEW_MONEDA d ,
   VIEW_MONEDA e
  WHERE  (a.cacodpos1  = 8   OR 
   a.cacodpos1  = 9 )   AND
   (a.cacodigo = c.clrut  AND
   a.cacodcli = c.clcodigo)  AND
   a.cacodmon1 = d.mncodmon  AND
   a.cacodmon2 = e.mncodmon  AND
   a.cacodpos1  = b.codigo_producto AND
   CONVERT(VARCHAR(8),cafecvcto,112) = CONVERT(VARCHAR(8),@fecha_proceso,112)
 END
SET NOCOUNT OFF
END

GO
