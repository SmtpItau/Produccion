USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_MASCARA_INSTRUMENTO]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_mascara_instrumento    fecha de la secuencia de comandos: 05/04/2001 9:20:53 ******/
/****** Objeto:  vista dbo.view_mascara_instrumento    fecha de la secuencia de comandos: 07/02/2001 11:43:18 ******/
CREATE VIEW [dbo].[VIEW_MASCARA_INSTRUMENTO]
AS
SELECT msmascara,
 msnemo,
 msfamilia,
 msarchivo
FROM  BACPARAMSUDA..MASCARA_INSTRUMENTO

GO
