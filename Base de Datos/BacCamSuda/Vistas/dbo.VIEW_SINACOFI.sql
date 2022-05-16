USE [BacCamSuda]
GO
/****** Object:  View [dbo].[VIEW_SINACOFI]    Script Date: 11-05-2022 16:45:04 ******/
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
 FROM 
  bacparamsuda..SINACOFI



GO
