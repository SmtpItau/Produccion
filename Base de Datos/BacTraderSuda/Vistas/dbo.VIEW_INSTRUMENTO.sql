USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_INSTRUMENTO]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_INSTRUMENTO]
AS
SELECT incodigo,
	inserie,
	inglosa,
	inrutemi,
	inmonemi,
	inbasemi,
	inprog,
	inrefnomi,
	inmdse,
	inmdtd,
	inmdpr,
	intipfec,
	intasest,
	intipo,
	inemision,
	ineleg,
	inlargoms,
	inedw,
	incontab, 
	intiporig,
	intotalemitido,
	insecuritytype,
	insecuritytype2,
	ISNULL(cod_clasificacion,2) as cod_clasificacion
FROM  BacParamSuda..INSTRUMENTO

-- Base de Datos --
GO
