USE [BacSwapSuda]
GO
/****** Object:  View [dbo].[view_entidad]    Script Date: 13-05-2022 11:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE VIEW [dbo].[view_entidad]
AS
	SELECT	
		rccodcar	,
		rcrut		,
		rcdv		,
		rcnombre	,
		rcnumoper	,
		rctelefono	,
		rcfax		,
		rcdirecc
	FROM 	bacparamsuda..entidad










GO
