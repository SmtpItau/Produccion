USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[TIPO_CLIENTE]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[TIPO_CLIENTE]
AS

	SELECT	CODIGO		= TBCODIGO1
		,	DESCRIPCION	= TBGLOSA
	FROM	BacParamSuda.dbo.TABLA_GENERAL_DETALLE WITH(NOLOCK)
	WHERE	tbcateg		= 72

-- Base de Datos --
GO
