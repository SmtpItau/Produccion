USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[usp_RPT_FWK_SITIOS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_RPT_FWK_SITIOS]
	@fchProceso DATETIME = '20081124'
	 ,
	@IdAplicacion NVARCHAR(30) = 'FFMM'
	 --WITH ENCRYPTION
AS
BEGIN
	/*
	Procedimiento destinado al reporte que lleva su nombre
	
	@Autor       : Gabriel Ponce (gbrel)
	@Fecha     : Abril 2010
	@Example  :
	EXEC usp_RPT_FWK_SITIOS '20081124', 'FFMM'
	*/ 
	
	EXEC fwk_MAP_GetSiteMapByAplicacion @IdAplicacion
	    ,1
END
GO
