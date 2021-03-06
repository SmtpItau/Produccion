USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Func_Indica_Modalidad_NDF_Externa]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Func_Indica_Modalidad_NDF_Externa]
	(	@nCodMon	NUMERIC(3)	) 
		RETURNS CHAR(1)
BEGIN

	DECLARE @cModal CHAR(1)
		SET @cModal = 'E'
	SELECT	@cModal = 'C' 
	FROM	BacParamSuda.dbo.TABLA_GENERAL_DETALLE 
	WHERE	tbcateg = 7000 
	AND		tbtasa	= @nCodMon

	RETURN	@cModal
END
GO
