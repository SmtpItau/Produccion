USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_SINACOFI]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_SINACOFI]
AS 
   SELECT 
         clrut        
         ,clcodigo     
         ,clnumsinacofi 
         ,clnomsinacofi 
         ,datatec
         ,bolsa      
   FROM BACPARAMSUDA..SINACOFI

GO
