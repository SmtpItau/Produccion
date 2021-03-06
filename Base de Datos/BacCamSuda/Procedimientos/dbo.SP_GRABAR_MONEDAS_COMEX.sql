USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_MONEDAS_COMEX]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_MONEDAS_COMEX]	
	(	@moUNegocios	CHAR(3)
	,	@mpproducto		CHAR(5)
	,	@mpcodmon		NUMERIC(5)
	,	@mpestado		CHAR(1)
	)
AS
BEGIN
	SET NOCOUNT ON

	INSERT INTO dbo.MONEDAS_COMEX
	(	mpUnegocio 
	,	mpproducto 
	,	mpcodmon                                
	,	mpestado
	)
	VALUES
	(	@moUNegocios
	,	@mpproducto
	,	@mpcodmon
	,	1 --< @mpestado
	)

END
GO
