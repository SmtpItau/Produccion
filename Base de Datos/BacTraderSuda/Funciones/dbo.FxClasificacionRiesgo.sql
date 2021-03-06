USE [BacTraderSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[FxClasificacionRiesgo]    Script Date: 13-05-2022 11:19:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[FxClasificacionRiesgo]
	(	@nRut	numeric(20)
	)	returns varchar(10)
as
begin

	declare @cClasificacion	varchar(20)
		set @cClasificacion	= ''
		set @cClasificacion	= isnull( ( select Clasificacion_SBIF from Tbl_Clientes_Riesgo where Rut = @nRut ), '')

	return @cClasificacion
end

GO
