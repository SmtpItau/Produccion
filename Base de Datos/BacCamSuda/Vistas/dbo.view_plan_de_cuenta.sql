USE [BacCamSuda]
GO
/****** Object:  View [dbo].[view_plan_de_cuenta]    Script Date: 11-05-2022 16:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[view_plan_de_cuenta]
AS
SELECT  * 
FROM  bacparamsuda..PLAN_DE_CUENTA

GO
