USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_SISTEMA_CNT]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_SISTEMA_CNT]
AS  
   SELECT id_sistema,
   nombre_sistema,
   operativo,
          gestion
     FROM BACPARAMSUDA..SISTEMA_CNT

GO
