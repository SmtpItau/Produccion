USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RPT_EXCEPCIONESPRECIOSTASAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RPT_EXCEPCIONESPRECIOSTASAS]
(	@Sistema	CHAR(3)
)
AS 
BEGIN
	SET NOCOUNT ON
	CREATE TABLE #tmpReporteTP(
	Sistema		CHAR(3),
	nomSistema	VARCHAR(30),
	codProducto	VARCHAR(5),
	nomProducto	VARCHAR(50),
	NumContrato	INTEGER,
	FechaContrato	DATETIME,
	tipoProducto	VARCHAR(10),
	nomTipoProducto	VARCHAR(50),
	Instrumento	VARCHAR(20),
	Operador	VARCHAR(20),
	RutCliente	NUMERIC(10,0),
	DVCliente	CHAR(1),
	CodCliente	INTEGER,
	nomCliente	VARCHAR(50),
	Exceso		NUMERIC(19,4),
	Leyenda	VARCHAR(255)
	)


	INSERT INTO #tmpReporteTP(Sistema, codProducto, NumContrato, RutCliente, DVCliente, CodCliente, nomCliente, Exceso, Leyenda)
	SELECT 
	a.Id_Sistema,
	a.Codigo_Producto,
	a.NumeroOperacion,
	a.Rut_Cliente,
	c.Cldv,
	a.Codigo_Cliente,
	c.Clnombre,
	a.MontoExceso,
	a.Mensaje_Error
	FROM Baclineas..LINEA_TRANSACCION_DETALLE a,
	Bacparamsuda..CLIENTE c
	WHERE a.Linea_Transsaccion = 'CTRLPR'
	AND a.Rut_Cliente = c.Clrut
	AND a.Codigo_Cliente = c.Clcodigo
	AND a.Id_Sistema = @Sistema

	UPDATE #tmpReporteTP
	SET nomSistema = nombre_sistema
	FROM Bacparamsuda..SISTEMA_CNT
	WHERE id_sistema = @Sistema

	IF @Sistema = 'BEX'
	BEGIN
		UPDATE #tmpReporteTP
		SET FechaContrato = mofecpro,
		Operador = mousuario,
		tipoProducto = cod_familia,
		Instrumento = id_instrum,
		nomProducto = (SELECT descripcion FROM Bacparamsuda..PRODUCTO WHERE codigo_producto = codProducto AND id_sistema = @Sistema)
		FROM Bacbonosextsuda..text_mvt_dri
		WHERE Sistema = @Sistema
		AND monumoper = NumContrato
		AND motipoper = SUBSTRING(codProducto,1,2)

		UPDATE #tmpReporteTP
		SET nomTipoProducto = (SELECT Descrip_familia FROM Bacbonosextsuda..text_fml_inm WHERE Cod_Familia = CONVERT(NUMERIC(5),tipoProducto))
		FROM Bacbonosextsuda..text_mvt_dri
		WHERE Sistema = @Sistema
		AND monumoper = NumContrato
		AND motipoper = SUBSTRING(codProducto,1,2)
	END

	IF @Sistema = 'BTR'
	BEGIN
		UPDATE #tmpReporteTP
		SET FechaContrato = mofecpro,
		Operador = mousuario,
		tipoProducto = mocodigo,
		Instrumento = CASE codProducto 
			WHEN 'CP' THEN moinstser 
			WHEN 'VP' THEN moinstser 
			WHEN 'CI' THEN moinstser 
			WHEN 'VI' THEN moinstser
			ELSE '' END,
		nomProducto = CASE codProducto WHEN 'IB' THEN 'INTERBANCARIOS' ELSE (SELECT descripcion FROM Bacparamsuda..PRODUCTO WHERE codigo_producto = codProducto AND id_sistema = @Sistema) END
		FROM Bactradersuda..mdmo
		WHERE Sistema = @Sistema
		AND monumoper = NumContrato
		AND motipoper = codProducto

		UPDATE #tmpReporteTP
		SET nomTipoProducto = (SELECT inglosa FROM Bacparamsuda..INSTRUMENTO WHERE incodigo = CONVERT(NUMERIC(5),tipoProducto))
		FROM Bactradersuda..mdmo
		WHERE Sistema = @Sistema
		AND monumoper = NumContrato
		AND motipoper = codProducto	
	END

	IF @Sistema = 'PCS'
	BEGIN
		UPDATE #tmpReporteTP
		SET FechaContrato = s.FechaEfectiva,
		Operador = s.operador,
		tipoProducto = s.tipo_operacion,
		nomProducto = CASE codProducto WHEN 1 THEN 'SWAP DE TASAS' WHEN 2 THEN 'SWAP DE MONEDAS' END
		FROM BacSwapsuda..MovDiario s
		WHERE Sistema = @Sistema
		AND s.numero_operacion = NumContrato
		AND s.tipo_swap = codProducto
		AND s.tipo_flujo = 1
		AND s.numero_flujo = 1

		UPDATE #tmpReporteTP
		SET nomTipoProducto = CASE tipoProducto WHEN 'C' THEN 'COMPRAS' WHEN 'V' THEN 'VENTAS' END
		FROM BacSwapsuda..MovDiario s
		WHERE Sistema = @Sistema
		AND s.numero_operacion = NumContrato
		AND s.tipo_swap = codProducto
		AND s.tipo_flujo = 1
		AND s.numero_flujo = 1
	END

	IF @Sistema = 'BFW'
	BEGIN
		UPDATE #tmpReporteTP
		SET FechaContrato = mofecha,
		Operador = mooperador,
		tipoProducto = motipoper,
		nomProducto = (SELECT descripcion FROM Bacparamsuda..PRODUCTO WHERE codigo_producto = codProducto AND id_sistema = @Sistema),
		nomTipoProducto = CASE motipoper WHEN 'C' THEN 'COMPRAS' WHEN 'V' THEN 'VENTAS' END
		FROM Bacfwdsuda..mfmo
		WHERE Sistema = @Sistema
		AND monumoper = NumContrato
		AND mocodpos1 = codProducto
	END

	IF @Sistema = 'BCC'
	BEGIN
		UPDATE #tmpReporteTP
		SET FechaContrato = mofech,
		Operador = mooper,
		tipoProducto = motipope,
		nomProducto = (SELECT descripcion FROM Bacparamsuda..PRODUCTO WHERE codigo_producto = codProducto AND id_sistema = @Sistema),
		nomTipoProducto = CASE motipope WHEN 'C' THEN 'COMPRAS' WHEN 'V' THEN 'VENTAS' END
		FROM BacCamsuda..MEMO
		WHERE Sistema = @Sistema
		AND monumope = NumContrato
	END

	DELETE #tmpReporteTP
	WHERE FechaContrato IS NULL

IF EXISTS(SELECT 1 FROM #tmpReporteTP) 
BEGIN 
	SELECT Sistema,	
	nomSistema,
	codProducto, 
	nomProducto, 
	NumContrato, 
	FechaContrato,
	tipoProducto,
	nomTipoProducto,
	Instrumento,
	Operador,
	RutCliente,
	DVCliente,
	CodCliente,
	nomCliente,
	Exceso,
	Leyenda,
	'BannerCorto' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)
	FROM #tmpReporteTP
	ORDER BY Sistema, NumContrato
END
ELSE
BEGIN
	SELECT Sistema='',	
	nomSistema='',
	codProducto='', 
	nomProducto='', 
	NumContrato='', 
	FechaContrato='',
	tipoProducto='',
	nomTipoProducto='',
	Instrumento='',
	Operador='',
	RutCliente='',
	DVCliente='',
	CodCliente='',
	nomCliente='',
	Exceso='',
	Leyenda='',
	'BannerCorto' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)
END

	DROP TABLE #tmpReporteTP
END

GO
