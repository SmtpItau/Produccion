USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[ufx_TABLA]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ufx_TABLA]
(
)
RETURNS TABLE
AS
	RETURN 
	(
	    SELECT id_aplicacion
	          ,descripcion
	    FROM   FWK_APLICACIONES
	)
GO
