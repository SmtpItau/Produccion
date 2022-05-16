USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_REL_USUARIO_NORMATIVO]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE VIEW [dbo].[VIEW_REL_USUARIO_NORMATIVO]
AS
	SELECT 
		Ucn_Usuario
	,	Ucn_Sistema
	,	Ucn_Producto
	,	Ucn_Codigo_Lib
	,	Ucn_Codigo_CartN
	,	Ucn_Codigo_SubCartN
	, 	Ucn_Default 
	FROM 	BACPARAMSUDA..TBL_REL_USUARIO_NORMATIVO


GO
