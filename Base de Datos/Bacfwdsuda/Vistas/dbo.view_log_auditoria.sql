USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[view_log_auditoria]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[view_log_auditoria]
AS 
 SELECT * FROM BACPARAMSUDA..log_auditoria

GO
