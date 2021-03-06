USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_CALCXCUBRIRGTIAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_CALCXCUBRIRGTIAS]
	(
		@Folio		NUMERIC(18),
		@xCubrir	NUMERIC(24) OUTPUT,
		@cubrenGtias	NUMERIC(24) OUTPUT
	)
AS
BEGIN
	SET NOCOUNT ON
	CREATE TABLE #tmpMinutaOper(
		FolioAsocia	NUMERIC(18),
		RutCliente	NUMERIC(9),
		CodCliente	NUMERIC(5),
		Sistema		CHAR(3),
		NumeroOperacion	NUMERIC(10),
		ValorMTM	NUMERIC(21),
		ValorThr	NUMERIC(21),
		Diferencia	NUMERIC(24),
		ValorCubrir	NUMERIC(24)
			)

	INSERT INTO #tmpMinutaOper
	SELECT 	FolioAsocia,
		RutCliente,
		CodCliente,
		Sistema,
		NumeroOperacion,
		0,
		0,
		0,
		0
	FROM BacParamsuda.dbo.tbl_gar_AsociacionOper
	WHERE FolioAsocia = @Folio

/*  Obtención del ValorMTM, operaciones Forward, Sistema = 'BFW'    */

	UPDATE	#tmpMinutaOper
	SET	ValorMTM = m.fRes_Obtenido,
		ValorThr = th.Threshold_Aplicado
		FROM BacFwdSuda.dbo.mfca m,
		BacParamSuda.dbo.tbl_Threshold_Operacion th,
		#tmpMinutaOper t
		WHERE t.Sistema   = 'BFW'
		AND m.canumoper = t.NumeroOperacion
		AND m.cacodigo  = t.RutCliente
		AND m.cacodcli  = t.CodCliente
		AND m.caestado NOT IN ('A','P')
		AND th.Numero_Operacion = t.NumeroOperacion
		AND th.Sistema = 'BFW'
		AND th.Rut_Cliente = t.RutCliente
		AND th.Cod_Cliente = t.CodCliente
		
/*  Obtención del ValorMTM, operaciones Swaps, Sistema = 'PCS'    */

	UPDATE	#tmpMinutaOper
	SET	ValorMTM = ROUND(c.Valor_RazonableCLP, 0),
		ValorThr = th.Threshold_Aplicado
		FROM BacSwapSuda..Cartera c,
		BacParamSuda.dbo.tbl_Threshold_Operacion th,
		#tmpMinutaOper t
		WHERE t.Sistema   = 'PCS'
		AND c.numero_operacion = t.NumeroOperacion
		AND c.rut_cliente = t.RutCliente
		AND c.codigo_cliente = t.CodCliente
		AND c.Estado_oper_lineas <> 'P'
		AND th.Numero_Operacion = t.NumeroOperacion
		AND c.numero_flujo = (SELECT MIN(c1.numero_flujo) FROM BacSwapSuda.dbo.Cartera c1 WHERE c1.numero_operacion = c.numero_operacion AND c1.tipo_flujo = 1)
		AND th.Sistema = 'PCS'
		AND th.Rut_Cliente = t.RutCliente
		AND th.Cod_Cliente = t.CodCliente


	/* Aplicación Minuta    */

	UPDATE #tmpMinutaOper
		SET ValorMTM = 0,
		ValorThr = 0
		WHERE ValorMTM < 0

	UPDATE #tmpMinutaOper
		SET Diferencia = ValorMTM - ValorThr
		WHERE ValorMTM >= 0

	SELECT @xCubrir = SUM(Diferencia) FROM #tmpMinutaOper

	SELECT 	@cubrenGtias = SUM(c.ValorPresente + c.FactorMultiplicativo + b.FactorAditivo)
	from	tbl_gar_asociaciongtia a,
		tbl_mov_garantia b,
		tbl_mov_garantia_detalle c
	WHERE 	a.FolioAsocia = @Folio
	AND	b.NumeroOperacion = a.NumeroGarantia
	AND	b.RutCliente = a.RutCliente
	AND	b.CodCliente = a.CodCliente
	AND	c.NumeroOperacion = b.NumeroOperacion

	SET NOCOUNT OFF
END
GO
