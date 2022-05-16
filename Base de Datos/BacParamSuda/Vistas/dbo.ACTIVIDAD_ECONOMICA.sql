USE [BacParamSuda]
GO
/****** Object:  View [dbo].[ACTIVIDAD_ECONOMICA]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[ACTIVIDAD_ECONOMICA]
AS

	SELECT	CODIGO		= tbcodigo1 
		,	DESCRIPCION	= tbglosa 
	FROM	BacParamSuda.dbo.TABLA_GENERAL_DETALLE WITH(NOLOCK)
	WHERE	tbcateg = 13 


GO
