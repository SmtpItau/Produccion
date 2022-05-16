USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_TBLIMPER]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_TBLIMPER]
AS
	SELECT	Cartera
		,	Instrumento
		,	Plazo_minimo
		,	Plazo_maximo
	FROM	BacParamSuda.dbo.TBLIMPER with(nolock)
-- Base de Datos --
GO
