USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_PORCENTAJE_VARIACION]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_porcentaje_variacion    fecha de la secuencia de comandos: 05/04/2001 9:20:54 ******/
/****** Objeto:  vista dbo.view_porcentaje_variacion    fecha de la secuencia de comandos: 07/02/2001 11:43:19 ******/
CREATE VIEW [dbo].[VIEW_PORCENTAJE_VARIACION]
AS
SELECT 
 pvcodigo,
 pvserie,
 pvporcentaje
FROM BACPARAMSUDA..PORCENTAJE_VARIACION

GO
