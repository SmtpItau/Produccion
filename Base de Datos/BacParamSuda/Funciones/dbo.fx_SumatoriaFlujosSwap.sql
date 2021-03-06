USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_SumatoriaFlujosSwap]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION  [dbo].[fx_SumatoriaFlujosSwap]
	(	@nNumeroOperacion		numeric(10)
	,   @iFlujo				int
	)	returns		numeric(25,4)
as
begin

	declare @nMontoRetorno	numeric(25,4);	set @nMontoRetorno	= 0.0


	-->	Indicadores
	if @iFlujo = 1
	begin
		SET  @nMontoRetorno = (SELECT sum(activo_flujoclp) FROM BacSwapSuda.dbo.cartera with(nolock)WHERE numero_operacion = @nNumeroOperacion AND tipo_flujo = 1 GROUP BY numero_operacion)
	END
	
	if @iFlujo = 2
	BEGIN
		SET  @nMontoRetorno = (SELECT sum(pasivo_flujoclp) FROM BacSwapSuda.dbo.cartera with(nolock)WHERE numero_operacion = @nNumeroOperacion AND tipo_flujo = 2 GROUP BY numero_operacion)

	END
		
	
	return @nMontoRetorno
END


GO
