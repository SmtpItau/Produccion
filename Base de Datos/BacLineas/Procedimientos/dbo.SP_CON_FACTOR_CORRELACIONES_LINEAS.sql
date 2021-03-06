USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_FACTOR_CORRELACIONES_LINEAS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_CON_FACTOR_CORRELACIONES_LINEAS]	(	@IdSistema		CHAR(03)
							,	@MonedaRecibimos	CHAR(10)	= ''
							,	@CodPlazoR		CHAR(10)	= ''
							,	@MonedaEntregamos	CHAR(10)	= ''
							,	@CodPlazoE		CHAR(10)	= ''
							)
AS
BEGIN
	SET NOCOUNT ON

	SELECT	Col_MonedaAct 
	,	Col_CodigoPlazoAct
	,	Col_MonedaPas 
	,	Col_CodigoPlazoPas 
	,	Col_Factor 
	,	Col_FactorMLMX 
	,	A.MnNemo
	,	B.MnNemo
	,	A.mnmx
	,	B.mnmx
	,	"DE " + LTRIM(RTRIM(CONVERT(CHAR,C.Pll_Desde))) + " A " + LTRIM(RTRIM(CONVERT(CHAR,C.Pll_Hasta)))
	,	"DE " + LTRIM(RTRIM(CONVERT(CHAR,D.Pll_Desde))) + " A " + LTRIM(RTRIM(CONVERT(CHAR,D.Pll_Hasta)))
	FROM	TBL_CORRELACIONES_LINEAS	LEFT JOIN BACPARAMSUDA..MONEDA	A ON	A.mncodmon	= Col_MonedaAct
						LEFT JOIN BACPARAMSUDA..MONEDA	B ON	B.mncodmon	= Col_MonedaPas
						LEFT JOIN TBL_PLAZOS_LINEAS	C ON	C.Pll_IdSistema	= Col_Id_Sistema
										 AND	C.Pll_Moneda	= Col_MonedaAct
										 AND	C.Pll_Codigo	= Col_CodigoPlazoAct
						LEFT JOIN TBL_PLAZOS_LINEAS	D ON	D.Pll_IdSistema	= Col_Id_Sistema
										 AND	D.Pll_Moneda	= Col_MonedaPas
										 AND	D.Pll_Codigo	= Col_CodigoPlazoPas
	WHERE	Col_Id_Sistema		= @IdSistema
	AND	(Col_MonedaAct		= @MonedaRecibimos	OR @MonedaRecibimos	= '')
	AND	(Col_CodigoPlazoAct	= @CodPlazoR		OR @CodPlazoR		= '')
	AND	(Col_MonedaPas		= @MonedaEntregamos	OR @MonedaEntregamos	= '')
	AND	(Col_CodigoPlazoPas	= @CodPlazoE		OR @CodPlazoE		= '')
	ORDER
	BY	A.mnmx
	,	A.MnNemo
	,	C.Pll_Desde
	,	C.Pll_Hasta
	,	B.mnmx
	,	B.MnNemo
	,	D.Pll_Desde
	,	D.Pll_Hasta


	SET NOCOUNT OFF

END

-- SP_CON_FACTOR_CORRELACIONES_LINEAS 'PCS' , '999', '4', '999', '4'
-- SELECT * FROM BACPARAMSUDA..MONEDA
-- SELECT * FROM BACLINEAS..TBL_CORRELACIONES_LINEAS


GO
