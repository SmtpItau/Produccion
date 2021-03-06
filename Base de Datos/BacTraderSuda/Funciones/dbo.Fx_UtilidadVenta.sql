USE [BacTraderSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_UtilidadVenta]    Script Date: 13-05-2022 11:19:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Fx_UtilidadVenta]
	(	@cOrigen		char(3)
	,	@nOperacion		numeric(9)
	,	@nDocumento		numeric(9)
	,	@nCorrelativo	numeric(9)
	-----------------------------------	
	,	@nNominalVenta	numeric(19,4)
	,	@nValorVenta	numeric(19,4)
	-----------------------------------
	,	@iRetorno		int			-->	1: Diferencia Precio	(Valor Venta   - Valor Mercado)
									--> 2: Diferencia Mercado	(Valor Mercado - Valor Presente)
	,	@nValPresntePM	numeric(21,4)
	)	Returns			numeric(21,4)
as
begin

	-->		1.0	variable de retorno final
	Declare @nRetorno			Numeric(19,4)
	-------------------------------------------------------------------------------------------------------------

	-->		2.0 para leer el nominal original y el valor presente a tir de compra (al ultimo devengo realizado)
	Declare @nNominalOriginal	Numeric(19,4)
	Declare @nValorPresente		Numeric(19,4)
	declare @nTirMercado		numeric(21,4)
	Declare @nValorMercado		Numeric(19,4)
	declare @nValPresT0			Numeric(19,4)
	declare @dFechaCompra		datetime
	declare @nvalor_market		Numeric(19,4)

	if @cOrigen = 'BTR'
	begin
		select	@dFechaCompra		= cpfeccomp
		from	BacTraderSuda.dbo.Mdcp with(nolock)
		where	cpnumdocu			= @nDocumento
		and		cpcorrela			= @nCorrelativo

		select	@nNominalOriginal	= dinominal
			,	@nValorPresente		= case when @nValPresntePM <> 0 then @nValPresntePM else divptirc end
		from	BacTraderSuda.dbo.Mddi with(nolock)
		where	dinumdocu			= @nDocumento
		and		dicorrela			= @nCorrelativo
	end

	if @cOrigen = 'BEX'
	begin
		select	@nNominalOriginal	= cpnominal
			,	@nValorPresente		= cpvptirc 
			,	@dFechaCompra		= cpfeccomp
		from	BacBonosExtSuda.dbo.text_ctr_inv with(nolock)
		where	cpnumdocu			= @nDocumento 
--		and		cpcorrelativo		= @nCorrelativo
	end
	-------------------------------------------------------------------------------------------------------------

	-->		3.0 para leer el valor a tir de mercado mas reciente calculado.
	if @cOrigen = 'BTR'
	begin
		if exists(	select	1 
					from	BacTraderSuda.dbo.Valorizacion_Mercado with(nolock)
					where	fecha_valorizacion	= (select acfecante from BacTraderSuda.dbo.Mdac with(nolock) )
					and		rmnumdocu			= @nDocumento
					and		rmcorrela			= @nCorrelativo
				)
		begin
			select	@nvalor_market		= valor_market
				,	@nValorMercado		= valor_mercado
			from	BacTraderSuda.dbo.Valorizacion_Mercado with(nolock)
			where	fecha_valorizacion	= (select acfecante from BacTraderSuda.dbo.Mdac with(nolock) )
			and		rmnumdocu			= @nDocumento
			and		rmcorrela			= @nCorrelativo

			if	@nvalor_market <> 0.0
			begin
				set	@nValorMercado = @nvalor_market
			end
		end
	end
	
	if @cOrigen = 'BEX'
	begin
		set @nValorMercado		=	isnull((	select		cpvalmerc
												from		BacBonosExtSuda.dbo.text_ctr_inv with(nolock)
												where		cpnumdocu		= @nDocumento
--												and			cpcorrelativo	= @nCorrelativo
											), 0.0)
	end
	-------------------------------------------------------------------------------------------------------------

	-->		5.0 Determina el Factor de Prorrateo por si el nominal de la venta fue menor al nominal de la ultima valorizacion
	Declare @nFactor			numeric(21,4)
		set @nFactor			= case	when @nNominalOriginal = 0.0 then 0.0
										else							 round((@nNominalVenta * 100.0) / @nNominalOriginal, 4)
									end
	-------------------------------------------------------------------------------------------------------------

	/* CUANDO LA VENTA ES EL MISMO DÍA DE LA COMPRA, NO HAY VALOR MERCADO, POR LO TANTO TODO SE VA POR UTILIDAD POR DIF. PRECIO	*/
	
	if (@nValorMercado <> 0.0)
	begin
		-->		6.0 Rebaja proporcional del valor de mercado y valor presente, de acuerdo a la referencia de los nominales (original y vendido)
		set @nValorMercado	= round((@nValorMercado		* @nFactor / 100.0), 4)
		set @nValorPresente	= round((@nValorPresente	* @nFactor / 100.0), 4)
		----------------------------------------------------------------------------	---------------------------------
		-->		7.0 Retorno final ( Valor de Venta )
		if @iRetorno = 1
			set @nRetorno	= round((@nValorVenta - @nValorMercado), 4)
		-------------------------------------------------------------------------------------------------------------

		-->		8.0 Retorno final ( Valor de Mercado de la Venta )
		if @iRetorno = 2
			set @nRetorno	= round((@nValorMercado - @nValorPresente), 4)
		-------------------------------------------------------------------------------------------------------------
	end else
	begin 
		-->		7.0 Retorno final ( Valor de Venta )
		if @iRetorno = 1
			set @nRetorno	= round((@nValorVenta - @nValorPresente), 4)
		-------------------------------------------------------------------------------------------------------------
		-->		8.0 Retorno final ( Valor de Mercado de la Venta )
		if @iRetorno = 2
			set @nRetorno	= 0.0
		-------------------------------------------------------------------------------------------------------------
	end


	declare @nRetornoPaso	numeric(21,0)
		set @nRetornoPaso	= 0

	if @cOrigen = 'BTR'
	begin
		if @iRetorno = 1 or @iRetorno = 2
		begin
			set @nRetornoPaso	= Round(@nRetorno, 0)
			set @nRetorno		= @nRetornoPaso
		end
	end

	return  @nRetorno

end

GO
