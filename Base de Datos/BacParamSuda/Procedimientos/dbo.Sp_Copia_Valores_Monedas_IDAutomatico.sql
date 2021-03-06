USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Copia_Valores_Monedas_IDAutomatico]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sp_Copia_Valores_Monedas_IDAutomatico]
as
begin

	set nocount on

	-->		Fecha de Proximo Proceso
	declare @dFecha		as datetime		;	set @dFecha		= ( select acfecprox from BacFwdSuda.dbo.Mfac with(nolock) )
	declare @nItems		as int			;	set @nItems		= 4
	declare @nItem		as int			;	set	@nItem		= 1
	declare @nCodigo	as int			;	set @nCodigo	= 0
	declare @vmValor	as float		;	set @vmValor	= 0.0
	declare @vmCodigo	as int			;	set @vmCodigo	= -1
	declare @vmglosa	as varchar(20)	;	set @vmglosa	= ''
	declare @vmFecha	as datetime		;	set @vmFecha	= @dFecha

	while @nItems >= @nItem
	begin
		set @nCodigo	= case	when @nItem = 1 then 302
								when @nItem = 2 then 800
								when @nItem = 3 then 801
								when @nItem = 4 then 802
							end

		-->		Lee el Codigo y el valor a la fecha de Proximo Proceso
		select	@vmFecha	= vmfecha
			,	@vmCodigo	= vmcodigo
			,	@vmValor	= vmvalor
			,	@vmglosa	= mnglosa
		from	BacParamSuda.dbo.Valor_Moneda 
				left join BacParamSuda.dbo.Moneda On mncodmon = vmcodigo
		where	vmcodigo	= @nCodigo
		and		vmfecha		= @dFecha

		--		select	@vmFecha, @vmCodigo, @vmValor, @vmglosa

		-->		Valida inexistencia del registro y copia el del día anterior
		if @vmCodigo	= -1
		begin
			--	select '	--> Items Creado, código : ' + ltrim(rtrim( @nCodigo ))
			insert into BacParamSuda.dbo.Valor_Moneda
				(	vmfecha, vmcodigo, vmvalor	)
			select	vmfecha		= @dFecha
				,	vmcodigo	= vmcodigo
				,	vmvalor		= vmvalor
			from	BacParamSuda.dbo.Valor_Moneda
			where	vmfecha		= ( select acfecproc from BacFwdSuda.dbo.Mfac with(nolock) )
			and		vmcodigo	= @nCodigo
		end

		-->		Valida Valor en Cero y Actualiza el valor de acuerdo al día anterior
		if @vmValor		= 0.0
		begin
			--	select '	--> Items Actualizado, código : ' + ltrim(rtrim( @nCodigo ))
			update	BacParamSuda.dbo.Valor_Moneda
				set	vmvalor		=	(	select	vmvalor
										from	BacParamSuda.dbo.Valor_Moneda
										where	vmfecha		= ( select acfecproc from BacFwdSuda.dbo.Mfac with(nolock) )
										and		vmcodigo	= @nCodigo
									)
			where	vmfecha		= @dFecha
			and		vmcodigo	= @nCodigo
		end

		set @nItem		= @nItem + 1
	end


end
GO
