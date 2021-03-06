USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_convierte_monto_25]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fx_convierte_monto_25]
	(	@dFecha			datetime
	,	@iMoneda		int
	,	@nMontoiMoneda	numeric(25,4)
	,	@xMoneda		int
	)	returns			numeric(25,4)
as
begin

	declare @nMontoRetorno	numeric(25,4);	set @nMontoRetorno	= 0.0

	declare @xConversion	numeric(25,4);	set @xConversion	= 0.0
	declare @nMontoDolar	numeric(25,4);	set @nMontoDolar	= 0.0
	declare @nMontoPesos	numeric(25,4);	set	@nMontoPesos	= 0.0
	declare @nUnidadFomento	numeric(25,4);	set	@nUnidadFomento	= 0.0
	declare @nTipoCambio	numeric(25,4);	set	@nTipoCambio	= 0.0
	declare @nParidad		numeric(25,4);	set	@nParidad		= 0.0
	declare @mnrrda			char(1);		set @mnrrda			= ''

	-->	Indicadores
	set	@nUnidadFomento		= isnull((	select vmvalor from BacParamSuda.dbo.valor_moneda with(nolock)
										where  vmfecha = @dFecha and vmcodigo = 998), 0.0)

	set @nTipoCambio		= isnull((	select tipo_cambio from BacParamSuda.dbo.valor_moneda_contable with(nolock)
										where fecha	= @dFecha and codigo_moneda = 994), 0.0)

	if @nTipoCambio = 0.0
		set @nTipoCambio	= isnull((	select vmvalor from BacParamSuda.dbo.valor_moneda with(nolock)
										where vmfecha = @dFecha and vmcodigo = 994), 0.0)

	if @nTipoCambio = 0.0
	begin
		return @nMontoRetorno
	end

	-->		A Moneda comun Dólar.
	if (@iMoneda = 13 or @iMoneda = 994 or @iMoneda = 995)
	begin
		set @nMontoDolar = @nMontoiMoneda
		set @nMontoPesos = @nMontoDolar * @nTipoCambio
	end
	if (@iMoneda = 998)
	begin
		set	@nMontoPesos = @nMontoiMoneda * @nUnidadFomento
		set @nMontoDolar = @nMontoPesos / @nTipoCambio
	end
	if (@iMoneda = 999)
	begin
		set @nMontoPesos = @nMontoiMoneda
		set @nMontoDolar = @nMontoPesos / @nTipoCambio
	end

	if @iMoneda not in(13,994,995,998,999)
	begin
		set @mnrrda		= isnull((	select mnrrda from BacParamSuda.dbo.moneda with(nolock) where mncodmon = @iMoneda), '')
		set @nParidad	= isnull((	select SpotCompra from BacParamSuda.dbo.valor_moneda_contable with(nolock) 
									where  fecha = @dFecha and codigo_moneda = @iMoneda), 0.0)
		if @nParidad = 0.0
			set @nParidad = isnull((	select	vmparmes
										from	BacParamSuda.dbo.posicion_spt with(nolock) 
												inner join 
												(	select	mnnemo 
													from	BacParamSuda.dbo.moneda with(nolock) 
													where	mncodmon = @iMoneda
												)	mon		On mon.mnnemo = vmcodigo
										where	vmfecha = @dFecha
									),0.0)
		if @nParidad = 0.0
			set @nParidad = 1.0

		set @nMontoDolar	= case when @mnrrda = 'D' then (@nMontoiMoneda / @nParidad) else (@nMontoiMoneda * @nParidad) end
		set @nMontoPesos	= @nMontoDolar * @nTipoCambio
	end


	-->		A Moneda conversión ??
	if (@xMoneda = 999)
	begin
		set @xConversion = @nMontoPesos
	end
	if (@xMoneda = 998)
	begin
		set @xConversion = @nMontoPesos / @nUnidadFomento
	end
	if (@xMoneda = 13 or @xMoneda = 994 or @xMoneda = 995)
	begin
		set @xConversion = @nMontoDolar
	end

	if not (@xMoneda = 13 or @xMoneda = 994 or @xMoneda = 995 or @xMoneda = 998 or @xMoneda = 999)
	begin
		set @mnrrda		= isnull((	select mnrrda from BacParamSuda.dbo.moneda with(nolock) where mncodmon = @xMoneda), '')
		set @nParidad	= isnull((	select SpotCompra from BacParamSuda.dbo.valor_moneda_contable with(nolock) 
									where  fecha = @dFecha and codigo_moneda = @xMoneda), 0.0)
		if @nParidad = 0.0
			set @nParidad = isnull((	select	vmparmes
										from	BacParamSuda.dbo.posicion_spt with(nolock) 
												inner join (	select	mnnemo 
																from	BacParamSuda.dbo.moneda with(nolock) 
																where	mncodmon = @xMoneda
															)	mon		On mon.mnnemo = vmcodigo
										where	vmfecha = @dFecha
									),0.0)
		if @nParidad = 0.0
			set @nParidad = 1.0

		set @xConversion	= case when @mnrrda = 'M' then (@nMontoDolar * @nParidad)	else (@nMontoDolar / @nParidad)		end
	end

	set @nMontoRetorno		= @xConversion
	
	return @nMontoRetorno
end



GO
