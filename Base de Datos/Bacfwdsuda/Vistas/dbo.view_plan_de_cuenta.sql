USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[view_plan_de_cuenta]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[view_plan_de_cuenta]
AS
SELECT  * 
FROM  BACPARAMSUDA..PLAN_DE_CUENTA

GO
