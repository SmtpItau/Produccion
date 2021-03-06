USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Valor_Moneda]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[Fx_Valor_Moneda]
	(	@dFecha		datetime
	,	@nCodMoneda	int
	,	@nContable	int
	)	returns		Float
as
begin

	declare @nValMon	float
		set @nValMon	= 0.0

	declare @nTipo		int
		set @nTipo		= isnull((	select isnull(mntipmon, -1) from BacParamSuda.dbo.Moneda with(nolock) where mncodmon = @nCodMoneda ), -1)

	if @nTipo = -1
	begin
		return -1
	end

	if @nCodMoneda = 999
	begin
		set @nValMon	= 1.0
		return @nValMon
	end 

	if (@nContable = 0) or ( @nTipo = 1 )
	begin
		set		@nValMon =	(	select	vmvalor
								from	BacParamSuda.dbo.Valor_Moneda with(nolock)
								where	vmfecha			= @dFecha
								and		vmcodigo		= case when @nCodMoneda = 13 then 994 else @nCodMoneda end
							)
	end
	
	if ( @nTipo > 1 )
	begin
		if (@nContable = 1) and		(@nCodMoneda = 995 or @nCodMoneda = 997 or @nCodMoneda = 998 or @nCodMoneda = 999) 
		begin
			set		@nValMon =	(	select	vmvalor
									from	BacParamSuda.dbo.Valor_Moneda with(nolock)
									where	vmfecha			= @dFecha
									and		vmcodigo		= case when @nCodMoneda = 13 then 994 else @nCodMoneda end
								)
		end 

		if (@nContable = 1) and not (@nCodMoneda = 995 or @nCodMoneda = 997 or @nCodMoneda = 998 or @nCodMoneda = 999)
		begin
			set		@nValMon =	(	select	tipo_cambio
									from	BacParamSuda.dbo.Valor_Moneda_Contable with(nolock)
									where	fecha			= @dFecha
									and		codigo_moneda	= case when @nCodMoneda = 13 then 994 else @nCodMoneda end
								)
		end
	end

	if @nValMon is null
		set @nValMon = 0.0

	return @nValMon

end
GO
