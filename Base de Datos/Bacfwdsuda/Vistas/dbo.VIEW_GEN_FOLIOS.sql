USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_GEN_FOLIOS]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_GEN_FOLIOS]
AS 
   SELECT 
         codigo, 
         folio 
   FROM BACTRADERSUDA..GEN_FOLIOS

GO
