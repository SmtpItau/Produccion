USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fn_Genera_TNATRA]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[Fn_Genera_TNATRA]
	(	@Contrato	numeric(21)
	,	@Flujo		numeric(21)
	,	@Pata		int
	)	returns		float
as
begin

	/*
	declare @Contrato	numeric(21);	set @Contrato	= 2026	--> 2419 --> 2888
	declare @Pata		int;			set @Pata		= 1
	declare @Flujo		numeric(21);	set @Flujo		= 6	
	*/
	
	declare @fRetorno	float;			set @fRetorno	= 0.0;
	
	declare @fMensaje	char(10);		set @fMensaje	= 's/d'
	declare @nTipoSwap	int;			set	@nTipoSwap	= 0;
	declare @nMoneda	int;			set @nMoneda	= 0;
	declare @fTna		float;			set @fTna		= 0.0; 
	declare @fTra		float;			set @fTra		= 0.0;

	select	distinct
			@nTipoSwap = c.tipo_swap
	from	BacSwapSuda.dbo.Cartera c with(nolock) where c.numero_operacion = @Contrato

	if @nTipoSwap < 4
	begin
		   set @fRetorno = 0.0
		return @fRetorno
	end

	if not exists( select 1 from BacSwapSuda.dbo.CarteraHis c where c.numero_operacion = @Contrato )
	begin
		   set @fRetorno = 1.0
		return @fRetorno
	end


	select	@nTipoSwap	= RetornoSwap.iProducto
		,	@nMoneda	= RetornoSwap.Moneda
		,	@fTna		= isnull(RetornoSwap.TNA, 0.0)
		,	@fTra		= isnull(RetornoSwap.TRA, 0.0)
		,	@fMensaje	= ltrim(rtrim( RetornoSwap.Folio ))
	from 
		(
		select	Swap.Folio
			,	Swap.Flujo
			,	Swap.Tipo
			,	Swap.Producto
			,	Swap.iProducto
			,	Swap.Moneda 
			,	Swap.Capital
			,	swap.Interes
			,	Swap.FlujoAdd
			,	Inicio		= convert(char(10), Swap.Inicio, 103)
			,	Termino		= convert(char(10), Swap.Termino, 103)
			,	Liquidacion	= convert(char(10), Swap.Liquidacion, 103)
			,	Swap.Plazo
			,	Swap.Base
			,	Swap.IcpInicial
			,	Swap.Icpfinal
			,	Swap.UfInicial
			,	Swap.UfTermino
			,	ICPPeriodo	= ((Swap.Icpfinal - Swap.IcpInicial) / Swap.IcpInicial)
			,	TNA			= ROUND(((((Swap.Icpfinal - Swap.IcpInicial) / Swap.IcpInicial) * Swap.Base / Swap.Plazo) * 100.0), 2)
			,	TRAPeriodo	= ( ROUND(((((Swap.Icpfinal - Swap.IcpInicial) / Swap.IcpInicial) * Swap.Base / Swap.Plazo) * 100.0), 2)
							  * Swap.Plazo / 360 / 100.0 - (Swap.UfTermino/Swap.UfInicial-1)
							  ) / (Swap.UfTermino/Swap.UfInicial)
			,	TRA			= ROUND(
									((	( ROUND(((((Swap.Icpfinal - Swap.IcpInicial) / Swap.IcpInicial) * Swap.Base / Swap.Plazo) * 100.0), 2)
										* Swap.Plazo / 360 / 100.0 - (Swap.UfTermino/Swap.UfInicial-1)
									) / (Swap.UfTermino/Swap.UfInicial))
									* Swap.Base / Swap.Plazo*100.0) + (Swap.IndicadorSp) --> Se descarta la Suma del Spread
									, 4
									)
			,	Interes_TRA_UF		= Swap.Capital * Swap.Plazo
									* 
								ROUND(
									((	( ROUND(((((Swap.Icpfinal - Swap.IcpInicial) / Swap.IcpInicial) * Swap.Base / Swap.Plazo) * 100.0), 2)
										* Swap.Plazo / 360 / 100.0 - (Swap.UfTermino/Swap.UfInicial-1)
									) / (Swap.UfTermino/Swap.UfInicial))
									* Swap.Base / Swap.Plazo*100.0) + (Swap.IndicadorSp) --> Se descarta la Suma del Spread
									, 4
								) / 100.0 / 360.0
			,	PAGAMOS				= 
							ROUND(		Swap.Capital * Swap.Plazo
									* 
								ROUND(
									((	( ROUND(((((Swap.Icpfinal - Swap.IcpInicial) / Swap.IcpInicial) * Swap.Base / Swap.Plazo) * 100.0), 2)
										* Swap.Plazo / 360 / 100.0 - (Swap.UfTermino/Swap.UfInicial-1)
									) / (Swap.UfTermino/Swap.UfInicial))
									* Swap.Base / Swap.Plazo*100.0) + (Swap.IndicadorSp) --> Se descarta la Suma del Spread
									, 4
								) / 100.0 / 360.0			
							,4)	*	Swap.UfTermino
		from
			(	select	Folio		= ca.numero_operacion
					,	Flujo		= ca.numero_flujo
					,	Tipo		= ca.tipo_flujo 
					,	Producto	= case when ca.tipo_swap = 1 then 'Swap de Tasas'
										   when ca.tipo_swap = 2 then 'Swap de Monedas'
										   when ca.tipo_swap = 4 then 'Swap Promedio Camara'
					 	        	  end
					,	iProducto	= ca.tipo_swap
					,	Capital		= case when ca.tipo_flujo = 1 then ca.compra_capital			else ca.venta_capital			end  
					,	FlujoAdd	= case when ca.tipo_flujo = 1 then ca.compra_flujo_adicional	else ca.venta_flujo_adicional	end
					,	Moneda		= case when ca.tipo_flujo = 1 then ca.compra_moneda				else ca.venta_moneda			end
					,	IndicadorTs	= case when ca.tipo_flujo = 1 then ca.compra_valor_tasa			else ca.venta_valor_tasa		end
					,	IndicadorSp	= case when ca.tipo_flujo = 1 then ca.compra_spread 			else ca.venta_spread			end
					,	Interes		= case when ca.tipo_flujo = 1 then ca.compra_interes			else ca.venta_interes			end
					,	Inicio		= ca.fecha_inicio_flujo
					,	Termino		= ca.fecha_vence_flujo
					,	Liquidacion	= ca.FechaLiquidacion
					,	Plazo		= case	when datediff(day,ca.fecha_inicio_flujo, ca.fecha_vence_flujo) = 0 then 1
											else datediff(day,ca.fecha_inicio_flujo, ca.fecha_vence_flujo)
										end
					,	Base		= Base.Basee
					,	IcpInicial	= isnull(icpini.vmvalor, 0.0)
					,	Icpfinal	= isnull(icpfin.vmvalor, 0.0)
					,	UfInicial	= isnull(ufini.vmvalor, 0.0)
					,	UfTermino	= isnull(uffin.vmvalor, 0.0)
		 		from	BacSwapSuda.dbo.CarteraHis ca
					inner join
					(	select	contrato			= numero_operacion
							,	Legs				= tipo_flujo
							,	flujo				= max(numero_flujo)
						from	BacSwapSuda.dbo.carteraHis with(nolock)
						where	numero_operacion	= @Contrato
					-->	and	(	numero_flujo		= @Flujo or	@Flujo = 0 )
						and	(	tipo_flujo			= @Pata  OR @Pata  = 0 )
						group
						by		numero_operacion
							,	tipo_flujo
					)	FlujoVencido	On	FlujoVencido.contrato	= ca.numero_operacion
										and	FlujoVencido.Legs		= ca.tipo_flujo
										and	FlujoVencido.flujo		= ca.numero_flujo

					left join
					(	select	Id		= codigo
							,	Basee	= case when base = 'A' then 365 else base end
						from	BacSwapSuda.dbo.base with(nolock)
					)	Base	On	Base.Id	= case when ca.tipo_flujo = 1 then ca.compra_base else ca.venta_base end
					left join
					(	select  vmfecha, vmvalor 
		 				from	BacParamSuda.dbo.valor_moneda with(nolock) 
		 				where	vmcodigo = 800
					)	icpini	on icpini.vmfecha = ca.fecha_inicio_flujo
					left join
					(	select  vmfecha, vmvalor 
		 				from	BacParamSuda.dbo.valor_moneda with(nolock) 
		 				where	vmcodigo = 800
					)	icpfin	on icpfin.vmfecha = ca.fecha_vence_flujo
					inner join
					(	select  vmfecha, vmvalor 
		 				from	BacParamSuda.dbo.valor_moneda with(nolock) 
		 				where	vmcodigo = 998
					)	ufini	on ufini.vmfecha = ca.fecha_inicio_flujo
					inner join
					(	select  vmfecha, vmvalor 
		 				from	BacParamSuda.dbo.valor_moneda with(nolock) 
		 				where	vmcodigo = 998
					)	uffin	on uffin.vmfecha = ca.fecha_vence_flujo
			)	Swap	

		)	RetornoSwap

	if @@error <> 0
	begin
		set @fRetorno = @Contrato *-1
	end

	if @nMoneda  = 999
		set @fRetorno = @fTna
	
	if @nMoneda <> 999
		set @fRetorno = @fTra

	return @fRetorno
end
GO
