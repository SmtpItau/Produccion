USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_CLIENTE_RELACIONADO]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_CLIENTE_RELACIONADO]
AS
   SELECT
         clrut_padre      ,
         clcodigo_padre   ,
         clrut_hijo       ,
         clcodigo_hijo    ,
         clporcentaje
         FROM BACPARAMSUDA..CLIENTE_RELACIONADO

GO
