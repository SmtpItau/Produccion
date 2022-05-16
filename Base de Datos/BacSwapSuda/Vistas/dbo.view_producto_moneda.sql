USE [BacSwapSuda]
GO
/****** Object:  View [dbo].[view_producto_moneda]    Script Date: 13-05-2022 11:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[view_producto_moneda]
AS
	SELECT	mpsistema	,
		mpproducto	, 
		mpcodigo	, 
		mpestado	, 
		mptipoper	, 
		mpmoneda

	FROM 	bacparamsuda..PRODUCTO_MONEDA

GO
