USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEERESTADOENVIO_APROBACIONES]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEERESTADOENVIO_APROBACIONES]
AS
BEGIN
	
	SET NOCOUNT ON

	SELECT	Codigo = sCodigo
	,		Descripcion = sDescripcion
	FROM	BacParamSuda.dbo.SADP_ESTADOSENVIO
	WHERE	sCodigo	NOT IN( 'A', 'E', 'R', 'I', 'APM' )
	
END 
GO
