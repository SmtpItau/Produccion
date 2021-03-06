USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_PesosaMX]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION  [dbo].[fx_PesosaMX]
	(	@dFecha			datetime
	,	@iMoneda		int
	,	@nMontoiMoneda	numeric(25,4)
	,	@xMoneda		int
	)	returns			numeric(25,4)
as
begin

	declare @nMontoRetorno	numeric(25,4);	set @nMontoRetorno	= 0.0

	declare @nUnidadFomento	numeric(25,4);	set	@nUnidadFomento	= 0.0
	declare @nTipoCambio	numeric(25,4);	set	@nTipoCambio	= 0.0
	

	-->	Indicadores
	if @xMoneda = 999
	begin
		SET  @nMontoRetorno = @nMontoiMoneda
	END
	
	
	if @xMoneda = 998
	BEGIN
		
		set	@nUnidadFomento		= isnull((	select vmvalor from BacParamSuda.dbo.valor_moneda with(nolock)
											where  vmfecha = @dFecha and vmcodigo = 998), 0.0)
		
		SET  @nMontoRetorno =@nMontoiMoneda /@nUnidadFomento
	END
	
			
	
	if (@xMoneda = 13 or @xMoneda = 994 or @xMoneda = 995)
	BEGIN
		
		set @nTipoCambio		= isnull((	select tipo_cambio from BacParamSuda.dbo.valor_moneda_contable with(nolock)
											where fecha	= @dFecha and codigo_moneda = 994), (	select tipo_cambio from BacParamSuda.dbo.valor_moneda_contable with(nolock)
																								where fecha	= (SELECT  acfecante FROM Bacfwdsuda.dbo.mfac with(NOLOCK)) and codigo_moneda = 994))
		
		SET  @nMontoRetorno = @nMontoiMoneda /  @nTipoCambio
	END
	
	if @xMoneda not in(13,994,995,998,999)
	
	BEGIN
		
		set @nTipoCambio		= isnull((	select tipo_cambio from BacParamSuda.dbo.valor_moneda_contable with(nolock)
											where fecha	= @dFecha and codigo_moneda = @xMoneda),(	select tipo_cambio from BacParamSuda.dbo.valor_moneda_contable with(nolock)
																									where fecha	= (SELECT acfecante FROM Bacfwdsuda.dbo.mfac with(NOLOCK)) and codigo_moneda = @xMoneda))
		
		SET  @nMontoRetorno = @nMontoiMoneda /  @nTipoCambio
	END
	
	
	return @nMontoRetorno
END	


GO
