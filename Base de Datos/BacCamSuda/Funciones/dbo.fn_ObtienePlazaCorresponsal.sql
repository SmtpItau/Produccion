USE [BacCamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ObtienePlazaCorresponsal]    Script Date: 11-05-2022 16:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fn_ObtienePlazaCorresponsal] ( @corresponsal	int ) returns int
as
begin

	return isnull((select codigo_plaza from bacParamSuda..Corresponsal where cod_corresponsal = @corresponsal),0)

end
	
GO
