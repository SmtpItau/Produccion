USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_VALORESMONEDA]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_ValoresMoneda    fecha de la secuencia de comandos: 05/04/2001 9:20:55 ******/
CREATE VIEW [dbo].[VIEW_VALORESMONEDA]
AS
SELECT
codigo,
fecha,
valor
FROM BACPARAMSUDA..VALORESMONEDA

GO
