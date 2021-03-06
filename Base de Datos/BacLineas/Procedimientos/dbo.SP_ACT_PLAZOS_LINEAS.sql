USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_PLAZOS_LINEAS]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_ACT_PLAZOS_LINEAS]	(	@IdSistema	CHAR(03)
					,	@Moneda		CHAR(10)
					,	@Codigo		CHAR(10)
					,	@Desde		NUMERIC(9,4)
					,	@Hasta		NUMERIC(9,4)
					)
AS
BEGIN

	SET NOCOUNT ON

	INSERT INTO TBL_PLAZOS_LINEAS
	(	Pll_IdSistema
	,	Pll_Moneda
	,	Pll_Codigo
	,	Pll_Desde
	,	Pll_Hasta
	)
	VALUES
	(	@IdSistema
	,	@Moneda
	,	@Codigo
	,	@Desde
	,	@Hasta
	)

	SET NOCOUNT OFF

END

GO
