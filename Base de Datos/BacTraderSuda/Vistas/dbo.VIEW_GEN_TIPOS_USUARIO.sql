USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_GEN_TIPOS_USUARIO]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_GEN_TIPOS_USUARIO    fecha de la secuencia de comandos: 05/04/2001 9:20:53 ******/
CREATE VIEW [dbo].[VIEW_GEN_TIPOS_USUARIO]
AS  
select tipo_usuario,
 descripcion
from BACPARAMsuda..GEN_TIPOS_USUARIO

GO
