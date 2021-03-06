USE [BacSwapSuda]
GO
/****** Object:  View [dbo].[VIEW_PRODUCTO]    Script Date: 13-05-2022 11:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[VIEW_PRODUCTO]
AS 

   SELECT 'codigo_producto' = CASE WHEN codigo_producto = 'ST' THEN 1 
				   WHEN codigo_producto = 'SM' THEN 2
				   WHEN	codigo_producto = 'FR' THEN 3
                                   WHEN	codigo_producto = 'SP' THEN 4
                              END
   ,      descripcion
   ,      id_sistema
   FROM   bacparamsuda..PRODUCTO 
   WHERE  id_sistema = 'PCS'

GO
