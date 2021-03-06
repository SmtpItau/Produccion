USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Consulta_Usuarios_Query]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Consulta_Usuarios_Query] 
	(	@cName	varchar(15)	)
as
begin

	set @cName = ltrim(rtrim( @cName )) 

	if 	len( @cName ) > 0
		begin
			if exists( select 1 from BacParamSuda.dbo.Tabla_General_Detalle where tbcateg = 9000 and tbglosa = @cName )
				select 'Usuario no existe en la tabla'
			else
				select 'Usuario Existe en la tabla'
		end
	else
		select Id = tbcodigo1, Usuario = tbglosa from BacParamSuda.dbo.Tabla_General_Detalle where tbcateg = 9000 order by convert(int, tbcodigo1)
end
GO
