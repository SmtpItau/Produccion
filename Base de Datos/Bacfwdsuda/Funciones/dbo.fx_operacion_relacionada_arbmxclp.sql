USE [Bacfwdsuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_operacion_relacionada_arbmxclp]    Script Date: 13-05-2022 9:09:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fx_operacion_relacionada_arbmxclp]
	(	@nFolio		numeric(9)	)	returns	int
as
begin

	declare @iEstado	int
		set @iEstado	=	isnull((	select	iEstado		=	case when var_moneda2 > 0 then 1 else 0 end
										from	BacFwdSuda.dbo.Mfca with(nolock) 
										where	canumoper	= @nFolio
									),	0)

	return @iEstado
end
GO
