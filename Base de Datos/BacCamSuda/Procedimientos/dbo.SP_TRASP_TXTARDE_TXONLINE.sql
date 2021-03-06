USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRASP_TXTARDE_TXONLINE]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[SP_TRASP_TXTARDE_TXONLINE]
AS 
BEGIN

	DECLARE @Nombre VARCHAR(255)

	SET NOCOUNT ON 	

	INSERT INTO tbtxonline 
	SELECT 	Fecha    	,
		Hora     	,
		Origen		,
		Codigo		,
		Numero		,
		Mercado 	,
		Tipo 		,
		Moneda 		,
		MonedaCnv 	,
		Monto		,
		Precio 		,
		Equivalente	,
		Rut		,
		CodigoCliente	,
		Contraparte	,
		Contrausuario	,
		Usuario		,
		Estado		,
		Operacion	,
		'T'
	FROM 	tbtxonline_tarde

	SELECT COUNT(*) FROM tbtxonline_tarde	

	SET NOCOUNT ON 	

	DELETE FROM tbtxonline_tarde

	SET NOCOUNT OFF

END




GO
