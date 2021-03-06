USE [BacSwapSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_minimoflujoswap]    Script Date: 13-05-2022 10:59:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fx_minimoflujoswap]
	(	@nFolio		numeric(9)
	,	@nTipo		int	
	)	RETURNS		numeric(9) 
AS
BEGIN
	
	DECLARE @nNumeroFlujo	NUMERIC(9)
	SET		@nNumeroFlujo	=	0
	SET		@nNumeroFlujo	=	isnull((	SELECT	MIN( numero_flujo )
											FROM	BacSwapSuda.dbo.Cartera with(nolock)
											WHERE	numero_operacion	= @nFolio
											AND		tipo_flujo			= @nTipo
										), 0)

	RETURN @nNumeroFlujo

END
GO
