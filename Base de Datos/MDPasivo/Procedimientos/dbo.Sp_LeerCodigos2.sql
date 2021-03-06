USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LeerCodigos2]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_LeerCodigos2] (@cod_cat  VARCHAR(5))
AS
BEGIN   

SET DATEFORMAT DMY
SET NOCOUNT ON

IF @cod_cat = '01'
BEGIN
	SELECT @cod_cat
	,	Codigo_Mercado
	,	Descripcion
	FROM
		TIPO_MERCADO
	ORDER BY Descripcion
END

IF @cod_cat = '02'
BEGIN
	SELECT @cod_cat
	,	Codigo_Calidad
	,	Descripcion
	FROM
		CALIDAD_JURIDICA
	ORDER BY Descripcion
END

IF @cod_cat = '03'
BEGIN
	SELECT @cod_cat
	,	Codigo_Relacion_IF
	,	Descripcion
	FROM
		RELACION_IF
	ORDER BY Descripcion
END

IF @cod_cat = '04'
BEGIN
	SELECT @cod_cat
	,	Codigo_Relacion_Banco
	,	Descripcion
	FROM
		RELACION_BANCO
	ORDER BY Codigo_Relacion_Banco
END

IF @cod_cat = '05'
BEGIN
	SELECT @cod_cat
	,	Codigo_Deudor
	,	Descripcion
	FROM
		CATEGORIA_DEUDOR
	ORDER BY Descripcion
END

IF @cod_cat = '06'
BEGIN
	SELECT @cod_cat
	,	Codigo_Tipo_Cliente
	,	Descripcion
	FROM
		TIPO_CLIENTE
	ORDER BY Descripcion
END

IF @cod_cat = '07'
BEGIN
	SELECT @cod_cat
	,	Codigo_Sector
	,	Descripcion
	FROM
		SECTOR_ECONOMICO
	ORDER BY Descripcion
END

IF @cod_cat = '08'
BEGIN
	SELECT @cod_cat
	,	Codigo_Actividad
	,	Descripcion
	FROM
		ACTIVIDAD_ECONOMICA
	ORDER BY Descripcion
END

IF @cod_cat = '09'
BEGIN
	SELECT @cod_cat
	,	Codigo_Cartera_Deudor
	,	Descripcion
	FROM
		CLASIFICACION_CARTERA_DEUDOR
	ORDER BY Descripcion
END
 	
IF @cod_cat = '10'
BEGIN
	SELECT @cod_cat
	,	Codigo_Letra
	,	Descripcion
	FROM
		ESTADO_LETRA_HIPOTECARIA
	ORDER BY Descripcion
END

IF @cod_cat = '11'
BEGIN
	SELECT  cod_cat=11
	,	Codigo_Mercado
	,	Descripcion
	INTO	#tmp1
	FROM	TIPO_MERCADO

	DELETE 	#tmp1
	INSERT INTO #tmp1 SELECT 11, 1, 'BCCH'
	INSERT INTO #tmp1 SELECT 11, 2, 'PUBLICO/INT.FINANCIERAS/ORG.PRIVADOS'
	INSERT INTO #tmp1 SELECT 11, 3, 'ORG.EXTERNOS'

	SELECT * FROM #tmp1


END


SET NOCOUNT OFF

END








GO
