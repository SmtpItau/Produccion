USE [BacSwapSuda]
GO
/****** Object:  View [dbo].[VIEW_TABLA_MESA]    Script Date: 13-05-2022 11:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[VIEW_TABLA_MESA]
AS
	SELECT	tbcodigo1
		,tbglosa 
	FROM	BACPARAMSUDA..tabla_general_detalle  
	WHERE	tbcateg	= 245

GO
