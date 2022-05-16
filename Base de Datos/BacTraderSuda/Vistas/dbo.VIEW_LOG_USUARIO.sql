USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_LOG_USUARIO]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_log_usuario    fecha de la secuencia de comandos: 05/04/2001 9:20:53 ******/
/****** Objeto:  vista dbo.view_log_usuario    fecha de la secuencia de comandos: 07/02/2001 11:43:18 ******/
CREATE VIEW [dbo].[VIEW_LOG_USUARIO]
AS  
SELECT  logsistema,
 loguser,
 logfecha,
 logfechaapp,
 loghora,
 logevento
        FROM BACPARAMSUDA..LOG_USUARIO

GO
