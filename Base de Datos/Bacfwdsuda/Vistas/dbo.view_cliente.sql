USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[view_cliente]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_cliente]
AS

	SELECT	* 
	FROM	BACPARAMSUDA.DBO.cliente

GO
