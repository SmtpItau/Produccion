USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fnObtienePadreMenuTuring]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fnObtienePadreMenuTuring] 
			  ( @idMenu		int )
	   returns int
as
begin

   declare @posicion		int
   
	select @posicion = posicion -1
	  from gen_menu
	 where entidad					  = 'TUR'
	   and convert(int,nombre_objeto) = @idMenu

	return isnull((	
			    select top 1 convert(int,nombre_objeto)
				  from gen_menu
				 where entidad					   = 'TUR'
				   and convert(int,nombre_objeto) <= @idMenu
				   and posicion					   = @posicion
				 order by convert(int,nombre_objeto) desc
		   ),0)
end

GO
