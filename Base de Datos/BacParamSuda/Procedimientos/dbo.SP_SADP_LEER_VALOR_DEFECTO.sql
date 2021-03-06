USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEER_VALOR_DEFECTO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEER_VALOR_DEFECTO]
	(	@cOrigen		VARCHAR(5)
	,	@cMercado		VARCHAR(15)
	)
AS
BEGIN

	SET NOCOUNT ON

	SELECT	GloMon			= isnull(mnnemo, '')
		,	Moneda			= mncodmon
		,	GloFPago		= ISNULL(glosa, '')
		,	Forma_Pago		= Forma_Pago
	FROM	BacParamSuda.dbo.SADP_VALORDEFAULT
			LEFT  JOIN BacParamSuda.dbo.MONEDA			ON mncodmon = Moneda
			LEFT  JOIN BacParamSuda.dbo.FORMA_DE_PAGO	ON codigo	= Forma_Pago  
	WHERE	Origen			= @cOrigen 
	AND		Mercado			= @cMercado	
	
END
GO
