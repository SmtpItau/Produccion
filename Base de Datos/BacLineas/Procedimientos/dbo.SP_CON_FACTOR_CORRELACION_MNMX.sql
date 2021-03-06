USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_FACTOR_CORRELACION_MNMX]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_CON_FACTOR_CORRELACION_MNMX]	(	@IdSistema		CHAR(03)
						,	@MonedaRecibimos	CHAR(10)	= ''
						,	@CodPlazoR		CHAR(10)	= ''
						)
AS 
BEGIN

	SET NOCOUNT ON

	SELECT	DISTINCT
		LTRIM(RTRIM(A.MnNemo)) + " DE " + LTRIM(RTRIM(CONVERT(CHAR,C.Pll_Desde))) + " A " + LTRIM(RTRIM(CONVERT(CHAR,C.Pll_Hasta)))
	,	Col_FactorMLMX 
	,	A.mnmx
	,	A.MnNemo
	,	C.Pll_Desde
	,	C.Pll_Hasta
	FROM	TBL_CORRELACIONES_LINEAS	LEFT JOIN BACPARAMSUDA..MONEDA	A ON	A.mncodmon	= Col_MonedaAct
						LEFT JOIN TBL_PLAZOS_LINEAS	C ON	C.Pll_IdSistema	= Col_Id_Sistema
										 AND	C.Pll_Moneda	= Col_MonedaAct
										 AND	C.Pll_Codigo	= Col_CodigoPlazoAct

	WHERE	Col_Id_Sistema		= @IdSistema
	AND	(Col_MonedaAct		= @MonedaRecibimos	OR @MonedaRecibimos	= '')
	AND	(Col_CodigoPlazoAct	= @CodPlazoR		OR @CodPlazoR		= '')
	ORDER
	BY	A.mnmx
	,	A.MnNemo
	,	C.Pll_Desde
	,	C.Pll_Hasta

	SET NOCOUNT OFF	

END

--	SP_CON_FACTOR_CORRELACION_MNMX 'PCS'

GO
