USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_LeerValorMoneda]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fx_LeerValorMoneda]
	(	@dFecha			datetime
	,	@iMoneda		int
	,	@iContable		int
	)	returns			float	
as
begin
	
	/*
		NO MODIFICAR, SE UTILIZA EN EL PROCESO CONTABLE DE LOS SWAP
	*/
	
	declare @nvalorretorno	float
		set @nvalorretorno	= 0.0

	if (@iMoneda = 999)
		set @nvalorretorno = 1.0

	if (@iContable = 1 and (@iMoneda = 998 or @iMoneda = 997 or @iMoneda = 995 or @iMoneda = 994 ))
		set @iContable = 0

	if (@iMoneda = 13)
		set @iMoneda = 994

	if (@iContable = 0)
		set @nvalorretorno =	isnull((	select	vmvalor
											from	BacParamSuda.dbo.valor_moneda with(nolock)
											where	vmfecha			= @dFecha
											and		vmcodigo		= @iMoneda
										), 0.0)

	if (@iContable = 1)
		set @nvalorretorno =	isnull((	select	tipo_cambio 
		                    				from	BacParamSuda.dbo.Valor_Moneda_Contable with(nolock)
		                    				where	fecha			= @dFecha 
		                    				and		Codigo_Moneda	= @iMoneda
		                    			), 0.0)

	return @nvalorretorno

end

GO
