USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_PRODUCTO]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_PRODUCTO]
AS 
SELECT codigo_producto ,
descripcion  ,
id_sistema
FROM BACPARAMSUDA..PRODUCTO
-- select * from VIEW_LINEA_GENERAL
-- select * from VIEW_LINEA_SISTEMA
-- select * from VIEW_LINEA_TRANSACCION
-- select * from VIEW_LINEA_POR_PLAZO
-- select * from VIEW_LINEA_PRODUCTO
-- select * from VIEW_LINEA_AFILIADO
-- select * from VIEW_LINEA_TRASPASO
-- select * from VIEW_PRODUCTO
-- select * from VIEW_

GO
