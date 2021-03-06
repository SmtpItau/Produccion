USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_OPERASOC_FOLIO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_OPERASOC_FOLIO]
	(	@numFolio	NUMERIC(18),
		@rutCliente	NUMERIC(9),
		@codCliente	NUMERIC(5)
	)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE	@fechavcto	DATETIME

	CREATE TABLE #tmpOperAsoc(
		Sistema		VARCHAR(3),
		NumeroOperacion	NUMERIC(9),
		FechaVcto	DATETIME,
		MayorFechaVcto	DATETIME,
		MTM		NUMERIC(18,0),
		Threshold	NUMERIC(18,0),
		DifCubrir	NUMERIC(18,0)
	)
	/*
		Primero, las operaciones BFW
	*/
	INSERT INTO #tmpOperAsoc

	SELECT 	ao.Sistema,
		ao.NumeroOperacion,
		c.cafecvcto,
		c.cafecvcto,
		ROUND(ISNULL(c.fRes_Obtenido, 0), 0),
		ROUND(ISNULL(th.Threshold_Aplicado, 0), 0),
		( ROUND(ISNULL(c.fRes_Obtenido, 0), 0) - ROUND(ISNULL(th.Threshold_Aplicado, 0), 0) )
	FROM 	BacParamsuda.dbo.tbl_gar_AsociacionOper ao,
		BacFwdSuda.dbo.mfca c,
		BacParamsuda.dbo.tbl_Threshold_Operacion th
	WHERE 	ao.FolioAsocia 		= @numFolio
	AND	ao.RutCliente  		= @rutCliente
	AND	ao.CodCliente  		= codCliente
	AND	c.canumoper 		= ao.NumeroOperacion
	AND	c.cacodigo 		= ao.RutCliente
	AND	c.cacodcli 		= ao.CodCliente
	AND	th.Numero_Operacion 	= ao.NumeroOperacion
	AND	th.Sistema 		= ao.Sistema
	AND	ao.Sistema 		= 'BFW'
	AND	th.Rut_Cliente 		= @rutCliente
	AND	th.cod_Cliente 		= @codCliente
	
	/*
		Luego las operaciones PCS
	*/

	INSERT INTO #tmpOperAsoc

	SELECT 	ao.Sistema,
		ao.NumeroOperacion,
		c.fecha_termino,
		c.fecha_termino,
		ROUND(ISNULL(c.Valor_RazonableCLP, 0), 0),
		ROUND(ISNULL(th.Threshold_Aplicado, 0), 0),
		( ROUND(ISNULL(c.Valor_RazonableCLP, 0), 0) - ROUND(ISNULL(th.Threshold_Aplicado, 0), 0) )
	FROM 	BacParamsuda.dbo.tbl_gar_AsociacionOper ao,
		BacSwapSuda..Cartera c,
		BacParamsuda.dbo.tbl_Threshold_Operacion th
	WHERE 	ao.FolioAsocia 		= @numFolio
	AND	ao.RutCliente  		= @rutCliente
	AND	ao.CodCliente  		= codCliente
	AND	c.numero_operacion 	= ao.NumeroOperacion
	AND	c.rut_cliente		= ao.RutCliente
	AND	c.codigo_cliente	= ao.CodCliente
	AND	th.Numero_Operacion 	= ao.NumeroOperacion
	AND	th.Sistema 		= ao.Sistema
	AND	ao.Sistema 		= 'PCS'
	AND	th.Rut_Cliente 		= @rutCliente
	AND	th.cod_Cliente 		= @codCliente
	AND 	c.tipo_flujo = 1
	AND	c.numero_flujo = (SELECT MIN(c1.numero_flujo) FROM BacSwapSuda..Cartera c1 
					WHERE c1.numero_operacion = c.numero_operacion AND c1.tipo_flujo = 1)
	AND	c.Estado_oper_lineas <> 'P'
	SELECT	@fechavcto = (SELECT TOP 1 FechaVcto FROM #tmpOperAsoc ORDER BY FechaVcto DESC)
	UPDATE	#tmpOperAsoc
	SET	MayorFechaVcto = @fechavcto
	SELECT * FROM #tmpOperAsoc
	SET NOCOUNT OFF
END
GO
