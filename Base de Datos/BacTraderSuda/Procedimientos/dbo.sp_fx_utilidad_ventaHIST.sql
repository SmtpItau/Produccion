USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_fx_utilidad_ventaHIST]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_fx_utilidad_ventaHIST]
	(	@origen				varchar(3)
	,	@numdocu			numeric(9)
	,	@correla			numeric(9)
	,	@nominal_venta		numeric(21,4)
	,	@valor_venta		numeric(21,4)
	,	@DiferenciaVenta	numeric(21,4)
	,   @FechaVenta			date
	--	
	,	@DiferenciaPrecio	numeric(21,4)	output
	,	@DiferenciaAvr		numeric(21,4)	output
	)
as
begin

	set nocount on

	-->		Solo para depurar ( Off = 0; On = 1	)
	declare @mostrarmensajes	int;			set @mostrarmensajes	= 0		--> Solo para visualizar los print a consola
	declare @iFound				int;			set @iFound				= -1
	declare @rsNominal			numeric(21,4);	set @rsNominal			= 0.0
	declare @rsValPresente		numeric(21,4);	set @rsValPresente		= 0.0
	declare @rmValorMercado		numeric(21,4);	set	@rmValorMercado		= 0.0
	declare @rmAvr				numeric(21,4);	set	@rmAvr				= 0.0
	declare @nEquiVP			float;			set @nEquiVP			= 0.0
	declare @nEquiVM			float;			set @nEquiVM			= 0.0
	declare @xValorPresente		numeric(21,4);	set @xValorPresente		= 0.0
	declare @xValorMercado		numeric(21,4);	set @xValorMercado		= 0.0
	declare @nIndicaCampo		int;			set @nIndicaCampo		= 0

	
	DECLARE @acfecante DATETIME,
			@acfecprox DATETIME


	select  @nIndicaCampo		= case when month(ctrl.acfecante) <> month (ctrl.acfecproc ) 
										and datediff(day, ctrl.acfecante,ctrl.acfecproc) > 1 then 1 else 2 end
	from	(	select	acfecante, acfecproc
				from	dbo.fechas_proceso fp with(nolock) 
	    	 	WHERE fp.fecha = @FechaVenta
			)	ctrl

	-->		Por defecto en el caso que corresponda a una compra del día y no tenga cartera T-1, se envia todo por Dif. Precio
		set @DiferenciaPrecio	= @DiferenciaVenta	-->	0.0
		set @DiferenciaAvr		= 0.0


	select	@acfecante = acfecante, @acfecprox = acfecproc
				from	dbo.fechas_proceso fp with(nolock) 
	    	 	WHERE fp.fecha = @FechaVenta
			
			
	-->		Por defecto en el caso que corresponda a una compra del día y no tenga cartera T-1, se envia todo por Dif. Precio
		set @DiferenciaPrecio	= @DiferenciaVenta	-->	0.0
		set @DiferenciaAvr		= 0.0

	if @origen = 'BTR'
	begin

		
			set @iFound				= -1
		select	@iFound				= 1						--> Datos de Pruebas con Planilla de Tania
			,	@rsNominal			= rsnominal				-->	200000000	-->	rsnominal
			,	@rsValPresente		= case	when @nIndicaCampo = 1 then rsvppresen
											else						rsvppresenx
										end					--> rsvppresenx			-->	221224671	-->	rsvppresenx
		from	BacTraderSuda.dbo.mdrs with(nolock)
		where	rsfecha				=  @acfecante
		and		rsnumdocu			= @numdocu
		and		rscorrela			= @correla
		

			set @iFound				= -1
		select	@iFound				= 1
			,	@rsNominal			= valor_nominal			--> Datos de Pruebas con Planilla de Tania
			,	@rsValPresente		= valor_presente
		from	BacTraderSuda.dbo.valorizacion_mercado with(nolock)
		where	fecha_valorizacion	= @acfecante
		and		tipo_operacion		= 'CP'
		and		rmnumdocu			= @numdocu
		and		rmcorrela			= @correla
		
		if (@iFound = -1) or (@rsNominal = 0.0)
		begin
				set @iFound				= -1
			select	@iFound				= 1
				,	@rsNominal			= valor_nominal			--> Datos de Pruebas con Planilla de Tania
				,	@rsValPresente		= valor_presente
			from	BacTraderSuda.dbo.valorizacion_mercado with(nolock)
			where	fecha_valorizacion	= @acfecante
			and		tipo_operacion		= 'VI'
			and		rmnumdocu			= @numdocu
			and		rmcorrela			= @correla

			if (@iFound = -1) or (@rsNominal = 0.0)
			begin
					set @iFound				= -1
				select	@iFound				= 1
					,	@rsNominal			= valor_nominal			--> Datos de Pruebas con Planilla de Tania
					,	@rsValPresente		= valor_presente
				from	BacTraderSuda.dbo.valorizacion_mercado with(nolock)
				where	fecha_valorizacion	= @acfecante
				and		tipo_operacion		= 'CG'
				and		rmnumdocu			= @numdocu
				and		rmcorrela			= @correla
				
				if (@iFound = -1) or (@rsNominal = 0.0)
				begin
					return
				end
			end
		end


			set @iFound				= -1
		select	@iFound				= 1						--> Datos de Pruebas con Planilla de Tania
			,	@rmValorMercado		= valor_mercado			-->	217856488	-->	valor_mercado
			,	@rmAvr				= Diferencia_Mercado	-->	-3368183	-->	Diferencia_Mercado
		from	BacTraderSuda.dbo.valorizacion_mercado with(nolock)
		where	fecha_valorizacion	= @acfecante
		and		tipo_operacion		= 'CP'
		and		rmnumdocu			= @numdocu
		and		rmcorrela			= @correla

		if (@iFound = -1) or (@rmValorMercado = 0.0)
		begin
				set @iFound				= -1
			select	@iFound				= 1						--> Datos de Pruebas con Planilla de Tania
				,	@rmValorMercado		= valor_mercado			-->	217856488	-->	valor_mercado
				,	@rmAvr				= Diferencia_Mercado	-->	-3368183	-->	Diferencia_Mercado
			from	BacTraderSuda.dbo.valorizacion_mercado with(nolock)
			where	fecha_valorizacion	= @acfecante
			and		tipo_operacion		= 'VI'
			and		rmnumdocu			= @numdocu
			and		rmcorrela			= @correla

			if (@iFound = -1) or (@rmValorMercado = 0.0)
			begin
				set @iFound				= -1
				select	@iFound				= 1						--> Datos de Pruebas con Planilla de Tania
					,	@rmValorMercado		= valor_mercado			-->	217856488	-->	valor_mercado
					,	@rmAvr				= Diferencia_Mercado	-->	-3368183	-->	Diferencia_Mercado
				from	BacTraderSuda.dbo.valorizacion_mercado with(nolock)
				where	fecha_valorizacion	= @acfecante
				and		tipo_operacion		= 'CG'
				and		rmnumdocu			= @numdocu
				and		rmcorrela			= @correla
				
				if (@iFound = -1) or (@rmValorMercado = 0.0)
				begin
					return
				end
			end
		end

	end else
	begin

			set @iFound				= -1
		select	@iFound				= 1						--> Datos de Pruebas con Planilla de Tania
			,	@rsNominal			= rsnominal				-->	200000000	-->	rsnominal
			,	@rsValPresente		= rsvppresen			-->	rsvppresenx -->	221224671	-->	rsvppresenx
			,	@rmValorMercado		= rsvalmerc				-->	217856488	-->	valor_mercado
			,	@rmAvr				= rsDiferenciaMerc		-->	-3368183	-->	Diferencia_Mercado
		from	BacBonosExtSuda.dbo.text_rsu with(nolock)
		where	rsfecpro			= @acfecante --( select acfecante from BacBonosExtSuda.dbo.text_arc_ctl_dri with(nolock) )
		and		rsnumdocu			= @numdocu
		and		rscorrelativo		= @correla

		if (@iFound = -1) or (@rsNominal = 0) or (@rmValorMercado = 0)
		begin
			return
		end
	end

	if @mostrarmensajes = 1
	begin
		print	' NO  : ' + ltrim(rtrim( @rsNominal		))
			+	' VP  : ' + ltrim(rtrim( @rsValPresente	))
			+	' VM  : ' + ltrim(rtrim( @rmValorMercado	))
			+	' AVR : ' + ltrim(rtrim( @rmAvr ))
	end

	-->		Control de Errores en Division por Cero
	begin try

		set @nEquiVP	=	( @rsValPresente  /	@rsNominal )
		set @nEquiVM	=	( @rmValorMercado /	@rsNominal )

	end try
	begin catch

		return
	end catch
	-->		Control de Errores en Division por Cero

	set @xValorPresente	=	( @nEquiVP * @nominal_venta )
	set @xValorMercado	=	( @nEquiVM * @nominal_venta )

	if @mostrarmensajes = 1
	begin
		print	' EQUI VP : ' + ltrim(rtrim( @nEquiVP			))
			+	' EQUI VM : ' + ltrim(rtrim( @nEquiVM			))
			+	' MTO. VP : ' + ltrim(rtrim( @xValorPresente	))
			+	' MTO. VM : ' + ltrim(rtrim( @xValorMercado		))
	end

--> set	@DiferenciaAvr		=	round((	@xValorPresente	 - @xValorMercado ), 4) --> Tania solicito invertir la Formula. 26-05-2015
	set	@DiferenciaAvr		=	round((	@xValorMercado	 - @xValorPresente), 4)
	set	@DiferenciaPrecio	=	round((	@DiferenciaVenta - @DiferenciaAvr ), 4)

	if @origen = 'BTR'
	begin
		set	@DiferenciaAvr		=	round(@DiferenciaAvr,		0)
		set	@DiferenciaPrecio	=	round(@DiferenciaPrecio,	0)
	end

	if @mostrarmensajes = 1
	begin
		print	' @DiferenciaAvr	: ' + ltrim(rtrim( @DiferenciaAvr		))
			+	' @DiferenciaPrecio : ' + ltrim(rtrim( @DiferenciaPrecio	))
	end

	if @mostrarmensajes = 1
	begin
		if @DiferenciaVenta <> (@DiferenciaAvr + @DiferenciaPrecio)
		begin
			select -1, 'Existe diferencias en el calculo de la utilidad'
			select	@DiferenciaVenta
			select	@DiferenciaAvr + @DiferenciaPrecio
		end
	end

END
GO
