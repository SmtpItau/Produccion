USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_GEN_PRIVILEGIOS]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_GEN_PRIVILEGIOS    fecha de la secuencia de comandos: 05/04/2001 9:20:53 ******/
CREATE VIEW [dbo].[VIEW_GEN_PRIVILEGIOS]
AS  
select  tipo_privilegio,
 usuario,
 entidad,
 opcion,
 habilitado
from  BACPARAMsuda..GEN_PRIVILEGIOS

GO
