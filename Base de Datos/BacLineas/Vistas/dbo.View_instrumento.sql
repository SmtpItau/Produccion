USE [BacLineas]
GO
/****** Object:  View [dbo].[View_instrumento]    Script Date: 13-05-2022 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_instrumento]
AS
 SELECT * FROM bacparamsuda..instrumento
 
GO
