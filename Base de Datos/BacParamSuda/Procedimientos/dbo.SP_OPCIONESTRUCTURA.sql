USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPCIONESTRUCTURA]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_OPCIONESTRUCTURA]   
	AS    
	BEGIN          
		SELECT	OpcEstCod
		,		OpcEstDsc 
		FROM	LnkOpc.CbMdbOpc.dbo.OpcionEstructura 
		ORDER BY CONVERT(INT,OpcEstCod)
	END
GO
