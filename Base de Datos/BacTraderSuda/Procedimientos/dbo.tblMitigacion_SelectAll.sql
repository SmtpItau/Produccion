USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[tblMitigacion_SelectAll]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
			
CREATE PROCEDURE [dbo].[tblMitigacion_SelectAll] 	
AS
	
	SELECT * FROM dbo.tblMitigacion;
	
GO
