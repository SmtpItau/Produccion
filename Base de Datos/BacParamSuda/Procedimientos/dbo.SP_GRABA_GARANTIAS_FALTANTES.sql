USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_GARANTIAS_FALTANTES]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GRABA_GARANTIAS_FALTANTES]
AS
BEGIN
	SET NOCOUNT ON
	CREATE TABLE #GtiasFaltantes(
		numGarantia	NUMERIC(9),
		fecEmision	DATETIME,
		rutCliente	NUMERIC(9),
		codCliente	INTEGER,
		sistema		VARCHAR(3),
		numOperacion	NUMERIC(10),
		ValorThreshold	NUMERIC(21,4),
		ValorMTM	NUMERIC(21,4),
		AcumVP		NUMERIC(21,4),
		ValorDif	NUMERIC(21,4),
		faltante	NUMERIC(21,4),
		requerido	NUMERIC(21,4),
		faltaGtia	CHAR(1)
		)

/*
	Primero las operaciones Forward
*/

	INSERT INTO #GtiasFaltantes
	SELECT 	rg.NumeroOperacion,	--- numGarantia
		mg.Fecha,		--- fecEmision
		rg.RutCliente,		--- rutCliente
		rg.CodCliente,		--- codCliente
		rg.Sistema,		--- sistema
		rg.OperacionSistema,	--- numOperacion
		thr.Threshold_Aplicado,	--- ValorThreshold
		0.0,			--- AcumVP
		ca.fRes_Obtenido,	--- ValorMTM
		0.0,			--- ValorDif
		0.0,			--- faltante
		0.0,			--- requerido
		'S'			--- faltaGtia		
	FROM	BacParamsuda.dbo.tbl_registro_garantias rg,
		BacParamsuda.dbo.tbl_Mov_Garantia mg,
		BacParamSuda.dbo.Tbl_Threshold_Operacion thr,
		BacFwdSuda.dbo.mfca ca

	WHERE	mg.NumeroOperacion = rg.NumeroOperacion
	AND	rg.Sistema = 'BFW'
	AND	mg.RutCliente = rg.RutCliente
	AND	mg.CodCliente = rg.CodCliente
	AND	mg.Estado = 'V'
	AND	mg.TipoMovimiento = 'I'
	AND	thr.Sistema = 'BFW'
	AND	thr.Numero_Operacion = rg.NumeroOperacion
	AND	thr.Rut_Cliente = rg.RutCliente
	AND	thr.Cod_Cliente = rg.CodCliente
	AND	ca.canumoper = rg.NumeroOperacion
	

/*
	Ahora, las operaciones Swap
*/

	INSERT INTO #GtiasFaltantes
	SELECT 	rg.NumeroOperacion,	--- numGarantia
		mg.Fecha,		--- fecEmision
		rg.RutCliente,		--- rutCliente
		rg.CodCliente,		--- codCliente
		rg.Sistema,		--- sistema
		rg.OperacionSistema,	--- numOperacion	
		thr.Threshold_Aplicado,	--- ValorThresold
		0.0,			--- AcumVP
		ca.Valor_RazonableCLP,	--- ValorMTM
		0.0,			--- ValorDif
		0.0,			--- faltante
		0.0,			--- requerido
		'S'			--- faltaGtia
	FROM	BacParamsuda.dbo.tbl_registro_garantias rg,
		BacParamsuda.dbo.tbl_Mov_Garantia mg,
		BacParamSuda.dbo.Tbl_Threshold_Operacion thr,
		BacSwapSuda.dbo.Cartera ca

	WHERE	mg.NumeroOperacion = rg.NumeroOperacion
	AND	rg.Sistema = 'PCS'
	AND	mg.RutCliente = rg.RutCliente
	AND	mg.CodCliente = rg.CodCliente
	AND	mg.Estado = 'V'
	AND	mg.TipoMovimiento = 'I'
	AND	thr.Sistema = 'PCS'
	AND	thr.Numero_Operacion = rg.NumeroOperacion
	AND	thr.Rut_Cliente = rg.RutCliente
	AND	thr.Cod_Cliente = rg.CodCliente
	AND	ca.numero_operacion = rg.NumeroOperacion
	AND	ca.tipo_flujo = 1
	AND	ca.numero_flujo = (SELECT MIN(ca1.numero_flujo) FROM BacSwapSuda.dbo.Cartera ca1 WHERE ca1.numero_operacion = ca.numero_operacion AND ca1.tipo_flujo = 1)


	UPDATE #GtiasFaltantes
	SET faltaGtia = 'N'
	WHERE ValorMTM <= 0

	/*
	Calculo del el valor de VP acum para cada operacion
	*/

	UPDATE #GtiasFaltantes
	SET AcumVP = (SELECT SUM(ValorPresente * FactorMultiplicativo) from Bacparamsuda..tbl_mov_garantia_detalle WHERE NumeroOperacion = numGarantia)
	WHERE ValorMTM > 0

	UPDATE #GtiasFaltantes
	SET AcumVP = AcumVP + (SELECT FactorAditivo FROM Bacparamsuda..tbl_mov_garantia WHERE NumeroOperacion = numGarantia)
	WHERE ValorMTM > 0

	UPDATE #GtiasFaltantes
	SET ValorDif = ValorMTM - ValorThreshold,
	faltante = CASE WHEN ValorDif > AcumVP THEN ValorDif - AcumVP ELSE 0 END,
	faltaGtia = CASE WHEN faltante > 0 THEN 'S' ELSE 'N' END
	WHERE ValorMTM > 0	

	UPDATE #GtiasFaltantes
	SET requerido = ISNULL(MontoRequerido, faltante)
	FROM BacParamSuda.dbo.tbl_gar_fRedondeo,
	#GtiasFaltantes
	WHERE faltante <= MontoFinal
	AND faltante >= MontoInicio
	AND faltaGtia = 'S'

	INSERT INTO BacParamsuda.dbo.tbl_Garantias_Faltantes
	SELECT 	rutCliente,
		codCliente,
		numGarantia,
		fecEmision,
		'N',
		faltante,
		requerido
	FROM #GtiasFaltantes
	WHERE faltaGtia = 'S'

	SET NOCOUNT OFF
END
GO
