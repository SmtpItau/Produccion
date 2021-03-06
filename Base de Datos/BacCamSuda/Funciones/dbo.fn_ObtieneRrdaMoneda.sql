USE [BacCamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ObtieneRrdaMoneda]    Script Date: 11-05-2022 16:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fn_ObtieneRrdaMoneda]
			  ( @moneda	int
			  ) returns varchar(30)
as			
begin

	return (select mnrrda 
			  from bacParamSuda..moneda 
			 where mncodmon = @moneda 
		   )

end

GO
