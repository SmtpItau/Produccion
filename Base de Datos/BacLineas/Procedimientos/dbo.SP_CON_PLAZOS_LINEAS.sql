USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_PLAZOS_LINEAS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_PLAZOS_LINEAS]	(	@IdSistema	CHAR(03)
					,	@Moneda		CHAR(10)	= ''
					,	@Codigo		CHAR(10)	= ''
					)
AS
BEGIN

	SET NOCOUNT ON 

	SELECT	Pll_IdSistema
	,	Pll_Codigo
	,	Pll_Desde
	,	Pll_Hasta
	,	Pll_Moneda
	,	LTRIM(RTRIM(A.MnNemo)) + ' DE ' + LTRIM(RTRIM(CONVERT(CHAR,Pll_Desde))) + ' A ' + LTRIM(RTRIM(CONVERT(CHAR,Pll_Hasta)))
	FROM	TBL_PLAZOS_LINEAS	LEFT JOIN BACPARAMSUDA..MONEDA	A ON	A.mncodmon	= Pll_Moneda
	WHERE	(Pll_IdSistema	= @IdSistema	OR @IdSistema	= '')
	AND	(Pll_Moneda	= @Moneda	OR @Moneda	= '')
	AND	(Pll_Codigo	= @Codigo	OR @Codigo	= '')
	ORDER
	BY	Pll_IdSistema
	,	A.mnmx
	,	A.MnNemo
	,	Pll_Desde
	,	Pll_Hasta
	
	SET NOCOUNT OFF

END

-- SP_CON_PLAZOS_LINEAS 'PCS'

GO
