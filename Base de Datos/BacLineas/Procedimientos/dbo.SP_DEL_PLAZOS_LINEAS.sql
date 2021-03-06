USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_PLAZOS_LINEAS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_DEL_PLAZOS_LINEAS]	(	@IdSistema	CHAR(03)
					,	@Moneda		CHAR(10)
					,	@Codigo		CHAR(10)	= ''
					)
AS
BEGIN

	SET NOCOUNT ON

	DELETE	TBL_PLAZOS_LINEAS
	WHERE	Pll_IdSistema	= @IdSistema
	AND	Pll_Moneda	= @Moneda
	AND	(Pll_Codigo	= @Codigo	OR @Codigo	= '')

	SET NOCOUNT OFF

END

GO
