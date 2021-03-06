USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CARTERA_UNWIND]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_CARTERA_UNWIND] 
(
	@FechaIni datetime
	,@FechaFin datetime
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TMP_MONEDA TABLE(
		numero_operacion NUMERIC
		,glosa_moneda VARCHAR(40)
		,tipo_flujo INT
		)
	
	DECLARE @TMP_DESC_MONEDA TABLE(
		numero_operacion NUMERIC
		,moneda_compra VARCHAR(40)
		,moneda_venta VARCHAR(40)
		)

	INSERT INTO @TMP_MONEDA
	SELECT DISTINCT numero_operacion,dbo.ObtenerNombreMonedaByFlujo(numero_operacion, numero_flujo, 1),1
	FROM 
		BacSwapSuda.dbo.CARTERA_UNWIND
	WHERE
		FechaAnticipo BETWEEN @FechaIni AND @FechaFin
	AND tipo_flujo = 1 
	UNION ALL 
	SELECT DISTINCT numero_operacion,dbo.ObtenerNombreMonedaByFlujo(numero_operacion, numero_flujo, 2),2
	FROM 
		BacSwapSuda.dbo.CARTERA_UNWIND
	WHERE 
		FechaAnticipo BETWEEN @FechaIni AND @FechaFin
	AND tipo_flujo = 2

	INSERT INTO @TMP_DESC_MONEDA
	SELECT * 
	FROM (
		SELECT numero_operacion,[1] AS moneda_compra,[2] AS moneda_venta
		FROM (
			SELECT numero_operacion,tipo_flujo,glosa_moneda 
			FROM
				@TMP_MONEDA
			WHERE 
				glosa_moneda IS NOT NULL) as P 
				PIVOT (MAX(P.glosa_moneda) FOR P.tipo_flujo IN ([1], [2])) 
			AS PVT
	) AS T1
	
	SELECT DISTINCT
		'Estado'						= CU.Estado
		,'Swap'							= (CASE CU.Tipo_Swap
											WHEN 1 THEN 'TASA           '
											WHEN 2 THEN 'MONEDA         '
											WHEN 3 THEN 'FRA            '
											ELSE 'PROMEDIO CAMARA'
											END)
		,'Tipo_Swap'					= CU.Tipo_Swap
		,'Numero_Operacion'				= CU.Numero_Operacion
		,'Codigo_Cliente'				= CL.clcodigo
		,'rut_cliente'					= CL.clrut
		,'Nombrecli'					= ISNULL(clnombre, '')
		,'NombreOp'						=(CASE Tipo_Operacion
											WHEN 'C' THEN 'COMPRA '
											ELSE 'VENTA  '
											END)
		,'Monto_Saldo_Recibimos'		= CU.Compra_capital
		,'Monto_Amortiza_Recibimos'		= CU.compra_amortiza
		,'Moneda_Compra'				= TDM.moneda_compra				-- isnull(dbo.ObtenerNombreMonedaByFlujo(numero_operacion,numero_flujo,1), ' ')
		,'Monto_Saldo_Pagamos'			= Venta_capital
		,'Monto_Amortiza_Pagamos'		= CU.Venta_amortiza
		,'Moneda_Venta'					= TDM.moneda_venta					-- isnull(dbo.ObtenerNombreMonedaByFlujo(numero_operacion,numero_flujo,2), ' ')
		,'Fecha_Anticipo'				= CU.FechaAnticipo 
	INTO #Tabla
	FROM 
		BacSwapSuda.dbo.CARTERA_UNWIND AS CU
		LEFT JOIN 
			BacParamSuda.dbo.CLIENTE AS CL ON CL.clrut = CU.rut_cliente AND CL.clcodigo = CU.codigo_cliente
		LEFT JOIN 
			@TMP_DESC_MONEDA AS TDM ON TDM.numero_operacion = CU.numero_operacion
	WHERE 
		CU.FechaAnticipo BETWEEN @FechaIni AND @FechaFin
	ORDER BY CU.Numero_Operacion

	SELECT DISTINCT
		Estado,
		Swap,
		Tipo_Swap,
		Numero_Operacion,
		Codigo_Cliente,
		rut_cliente,
		Nombrecli,
		NombreOp,
		Moneda_Compra,
		Moneda_Venta,
		'Monto_Saldo_Recibimos'		= SUM(Monto_Saldo_Recibimos),
		'Monto_Amortiza_Recibimos'	= SUM(Monto_Amortiza_Recibimos),
		'Monto_Saldo_Pagamos'		= SUM(Monto_Saldo_Pagamos),
		'Monto_Amortiza_Pagamos'	= SUM(Monto_Amortiza_Pagamos),
		CONVERT(VARCHAR(10), Fecha_Anticipo, 103) AS Fecha_Anticipo
	FROM #Tabla
	GROUP BY
		Estado,
		Swap,
		Tipo_Swap,
		Numero_Operacion,
		Codigo_Cliente,
		rut_cliente,
		Nombrecli,
		NombreOp,
		Moneda_Compra,
		Moneda_Venta,
		Fecha_Anticipo
	END
	DROP TABLE #Tabla
GO
