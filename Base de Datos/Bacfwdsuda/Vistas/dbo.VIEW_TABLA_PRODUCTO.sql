USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_TABLA_PRODUCTO]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[VIEW_TABLA_PRODUCTO]
AS
	SELECT	descripcion,
		codigo_producto
	FROM	BacParamSuda..PRODUCTO
	WHERE	Id_Sistema       = 'BFW'



GO
