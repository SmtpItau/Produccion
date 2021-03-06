USE [BacCamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ObtieneMnemoMoneda]    Script Date: 11-05-2022 16:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fn_ObtieneMnemoMoneda]
			  ( @moneda	int
			  ) returns varchar(30)
as
begin

	return (select ltrim(rtrim(mnnemo))
		      from bacParamSuda..moneda 
		     where mncodmon = @moneda 
		    )

end
GO
