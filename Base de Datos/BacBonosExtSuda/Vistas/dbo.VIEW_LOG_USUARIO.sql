USE [BacBonosExtSuda]
GO
/****** Object:  View [dbo].[VIEW_LOG_USUARIO]    Script Date: 11-05-2022 16:32:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




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
