USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_TBSINACOFI]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_TBSINACOFI]
AS
   SELECT
         clrut,
         clcodigo,
         clnumSinacofi,
         clnomSinacofi
   FROM BACPARAMSUDA..SINACOFI

GO
