USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[FORMA_DE_PAGO]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[FORMA_DE_PAGO]
AS

	SELECT	CODIGO	= codigo
		,	GLOSA	= glosa 
		,	cc2756	= cc2756
	FROM	BacParamSuda.DBO.FORMA_DE_PAGO with(nolock)
-- Base de Datos --
GO
