USE [BacBonosExtSuda]
GO
/****** Object:  View [dbo].[view_entidad]    Script Date: 11-05-2022 16:32:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[view_entidad]
AS
	SELECT	
		rccodcar	,
		--'rcrut' = 	97023000	,
		rcrut		,
		rcdv		,
		rcnombre	,
		rcnumoper	,
		rctelefono	,
		rcfax		,
		rcdirecc
	FROM 	BACPARAMsuda..entidad








GO
