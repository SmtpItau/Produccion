USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_TABLA_DESARROLLO]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_Tabla_Desarrollo    fecha de la secuencia de comandos: 05/04/2001 9:20:55 ******/
/****** Objeto:  vista dbo.view_Tabla_Desarrollo    fecha de la secuencia de comandos: 07/02/2001 11:43:19 ******/
CREATE VIEW [dbo].[VIEW_TABLA_DESARROLLO]
AS
select
tdmascara,
tdcupon,
tdfecven,
tdinteres,
tdamort,
tdflujo,
tdsaldo
FROM BACPARAMSUDA..TABLA_DESARROLLO

GO
