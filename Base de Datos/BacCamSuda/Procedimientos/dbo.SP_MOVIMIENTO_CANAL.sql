USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MOVIMIENTO_CANAL]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MOVIMIENTO_CANAL] ( @F DATETIME = '')
AS
BEGIN
SET NOCOUNT OFF

IF @F='' 
  SET @F = (SELECT ACFECPRO FROM MEAC)

SELECT Moneda, 'Origen'= nemo, MontoCompra,TCPondCompra,MontoVenta,TCPondventa
  FROM tbl_resumen INNER JOIN bacparamsuda..tabla_general_detalle ON tbcateg=2700 and CodigoOrigen=tbcodigo1
 WHERE fecha = @f  and not(MontoCompra = 0 and TCPondCompra = 0 and MontoVenta = 0 and TCPondventa = 0)                                          
ORDER BY nemo,moneda

SET NOCOUNT ON
END

GO
