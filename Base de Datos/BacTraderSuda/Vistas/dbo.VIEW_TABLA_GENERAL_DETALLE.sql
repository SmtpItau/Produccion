USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_TABLA_GENERAL_DETALLE]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_tabla_general_detalle    fecha de la secuencia de comandos: 05/04/2001 9:20:55 ******/
/****** Objeto:  vista dbo.view_tabla_general_detalle    fecha de la secuencia de comandos: 07/02/2001 11:43:19 ******/
CREATE VIEW [dbo].[VIEW_TABLA_GENERAL_DETALLE]
AS
SELECT
tbcateg,
tbcodigo1,
tbtasa,
tbfecha,
tbvalor,
tbglosa,
nemo
FROM BACPARAMSUDA..TABLA_GENERAL_DETALLE

GO
