USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_USUARIO_ACTIVO]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_USUARIO_ACTIVO]
AS
   SELECT
 usuario,
 id_sistema,
 terminal,
 fechaproceso,
 fechasistema
   FROM BACPARAMSUDA..USUARIO_ACTIVO

GO
