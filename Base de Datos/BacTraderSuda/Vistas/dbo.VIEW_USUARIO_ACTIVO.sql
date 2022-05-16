USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_USUARIO_ACTIVO]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.VIEW_USUARIO_ACTIVO    fecha de la secuencia de comandos: 05/04/2001 9:20:55 ******/
CREATE VIEW [dbo].[VIEW_USUARIO_ACTIVO]
AS
 SELECT
  usuario,
  id_sistema,
  terminal,
  fechaproceso,
  fechasistema
 FROM    BACPARAMSUDA..USUARIO_ACTIVO

GO
