USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_GRABAR_VALOR_DEFECTO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[SP_SADP_GRABAR_VALOR_DEFECTO]
	(	@cOrigen		VARCHAR(5)
	,	@cMercado		VARCHAR(15)
	,	@iMoneda		INT
	,	@iFormPago		INT
	)
AS
BEGIN

	SET NOCOUNT ON

	IF EXISTS( SELECT 1 FROM BacParamSuda.dbo.SADP_VALORDEFAULT WHERE Origen = @cOrigen AND Mercado = @cMercado AND Moneda = @iMoneda )
	BEGIN
		DELETE FROM BacParamSuda.dbo.SADP_VALORDEFAULT WHERE Origen = @cOrigen AND Mercado = @cMercado AND Moneda = @iMoneda 
	END 

	INSERT INTO BacParamSuda.dbo.SADP_VALORDEFAULT
	SELECT	Origen			= @cOrigen
		,	Mercado			= @cMercado
		,	Moneda			= @iMoneda
		,	Rut_Cliente		= 0
		,	Codigo_Cliente	= 0
		,	Forma_Pago		= @iFormPago
		,	Rut_Banco		= 0
		,	Cod_Banco		= 0
		,	sBeneficiario	= ''  
		,	id_FormaPago	= @iFormPago
	
END 
GO
