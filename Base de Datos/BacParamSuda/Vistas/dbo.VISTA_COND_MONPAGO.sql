USE [BacParamSuda]
GO
/****** Object:  View [dbo].[VISTA_COND_MONPAGO]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VISTA_COND_MONPAGO]
AS
	SELECT	tbcodigo1, tbglosa 
	FROM	TABLA_GENERAL_DETALLE with(nolock)
	WHERE	tbcateg = 9008
GO
