USE [BacTraderSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Sw_Garantias]    Script Date: 13-05-2022 11:19:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[Fx_Sw_Garantias]
	(	@SwId	int = 4
	)	Returns	int
as
begin

	-->		Lee el Sw de Configuracion de Garantias
	declare @iActivaCicloGarantias	int
		set @iActivaCicloGarantias	= ( SELECT TOP 1 tbtasa FROM BacParamSuda.dbo.Tabla_General_Detalle with(nolock) WHERE tbcateg = @SwId ORDER BY tbtasa )
	-->		Si @iActivaCicloGarantias = 0 ; esta Apagado	Garantias
	-->		Si @iActivaCicloGarantias = 1 ; esta Encendido	Garantias

	return @iActivaCicloGarantias

end
GO
