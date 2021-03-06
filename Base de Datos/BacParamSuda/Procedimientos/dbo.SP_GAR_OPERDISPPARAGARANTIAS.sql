USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_OPERDISPPARAGARANTIAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_OPERDISPPARAGARANTIAS]
	(	@rutCliente	NUMERIC(9),
		@codCliente	INTEGER
	)
AS
BEGIN

	/* Objetivo: Obtener el listado de todas las operaciones de derivados del cliente que se encuentran disponibles */
	/*	     para ser asociadas a Garantías	PRD-5521							*/

	SET NOCOUNT ON

	CREATE TABLE #tmpOperaciones(
		TipoOperacion CHAR(3),
		NumOperacion NUMERIC(9),
		Moneda VARCHAR(5),
		MontoOperacion NUMERIC(19,4),
		FechaInicio DATETIME,
		FechaVcto DATETIME,
		ValorThreshold NUMERIC(19,4),
		ValorMTM NUMERIC(19,4),
		ValorDif NUMERIC(19,4) )
	
	/* Primero, las operaciones Forward */

	INSERT INTO #tmpOperaciones
	SELECT 	'BFW',
		a.canumoper,
		m.mnnemo,
		a.camtomon1,
		a.cafecha,
		a.cafecvcto,
		ROUND(thr.Threshold_Aplicado, 0),
		ROUND(a.fRes_Obtenido, 0),
		ROUND(a.fRes_Obtenido, 0) - ROUND(thr.Threshold_Aplicado, 0)
	FROM	Bacfwdsuda..mfca a,
		Bacparamsuda..MONEDA m,
		BacParamsuda..tbl_Threshold_Operacion thr

	WHERE	a.cacodigo  = @rutCliente
	AND	a.cacodcli  = @codCliente
	AND	a.cacodmon1 = m.mncodmon
	AND	a.canumoper = thr.Numero_Operacion
	AND	thr.Sistema = 'BFW'
	AND	thr.Rut_Cliente = @rutCliente
	AND	thr.Cod_Cliente = @codCliente
	AND	a.caestado NOT IN ('A','P')
	AND	a.canumoper NOT IN (SELECT NumeroOperacion
			FROM Bacparamsuda.dbo.tbl_gar_AsociacionOper
			WHERE Sistema = 'BFW' AND
			RutCliente = @rutCliente AND
			CodCliente = @codCliente)
	ORDER BY a.canumoper

	/* Luego, las operaciones Swaps 	*/
	INSERT INTO #tmpOperaciones
	SELECT 	'PCS',
		a.numero_operacion,
		m.mnnemo,
		CASE a.tipo_operacion WHEN 'C' THEN a.compra_capital  WHEN 'V' THEN a.venta_capital END AS 'MontoOperacion',	
		a.fecha_inicio,
		a.fecha_termino,
		ROUND(thr.Threshold_Aplicado, 0),
		ROUND(a.Valor_RazonableCLP, 0),
		ROUND(a.Valor_RazonableCLP, 0) - ROUND(thr.Threshold_Aplicado, 0)
	FROM	BacSwapSuda..Cartera a,
		Bacparamsuda..MONEDA m,
		BacParamsuda..tbl_Threshold_Operacion thr
	WHERE	a.rut_cliente = @rutCliente
	AND	a.codigo_cliente = @codCliente
	AND	m.mncodmon = CASE a.tipo_operacion WHEN 'C' THEN a.compra_moneda WHEN 'V' THEN a.venta_moneda END
	AND	a.numero_operacion = thr.Numero_Operacion
	AND	thr.Sistema = 'PCS'
	AND	thr.Rut_Cliente = @rutCliente
	AND	thr.Cod_Cliente = @codCliente
	AND	a.numero_flujo = (SELECT MIN(a1.numero_flujo) FROM BacSwapSuda..Cartera a1 WHERE a1.numero_operacion = a.numero_operacion AND a1.tipo_flujo = 1)
	AND 	a.tipo_flujo = 1
	AND	a.Estado_oper_lineas <> 'P'
	AND	a.numero_operacion NOT IN (SELECT NumeroOperacion
			FROM Bacparamsuda.dbo.tbl_gar_AsociacionOper
			WHERE Sistema = 'PCS' AND
			RutCliente = @rutCliente AND
			CodCliente = @codCliente)
	ORDER BY a.numero_operacion
	
	SELECT * FROM #tmpOperaciones
	ORDER BY TipoOperacion, NumOperacion
END
GO
