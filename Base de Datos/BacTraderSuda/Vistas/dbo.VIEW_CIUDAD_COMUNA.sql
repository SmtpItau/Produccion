USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_CIUDAD_COMUNA]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_ciudad_comuna    fecha de la secuencia de comandos: 05/04/2001 9:20:53 ******/
/****** Objeto:  vista dbo.view_ciudad_comuna    fecha de la secuencia de comandos: 07/02/2001 11:43:18 ******/
CREATE VIEW [dbo].[VIEW_CIUDAD_COMUNA]
AS 
select cod_pai,
 cod_ciu,
 cod_com,
 nom_ciu
from  BACPARAMsuda..CIUDAD_COMUNA

GO
