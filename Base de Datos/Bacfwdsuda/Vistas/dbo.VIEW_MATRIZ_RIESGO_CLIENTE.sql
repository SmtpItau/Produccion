USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_MATRIZ_RIESGO_CLIENTE]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_MATRIZ_RIESGO_CLIENTE]
AS 
select * from bacparamsuda..MATRIZ_RIESGO_CLIENTE

GO
