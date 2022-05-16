USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_PRODUCTO_CNT]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_PRODUCTO_CNT    fecha de la secuencia de comandos: 05/04/2001 9:20:54 ******/
/****** Objeto:  vista dbo.view_PRODUCTO_CNT    fecha de la secuencia de comandos: 07/02/2001 11:43:19 ******/
CREATE VIEW [dbo].[VIEW_PRODUCTO_CNT]
AS  
SELECT id_sistema,
 tipo_operacion,
 origen_instrumentos,
 datos_instrumentos,
 cond_instrumentos,
 origen_monedas,
 datos_monedas,
 cond_monedas
FROM BACPARAMSUDA..PRODUCTO_CNT

GO
