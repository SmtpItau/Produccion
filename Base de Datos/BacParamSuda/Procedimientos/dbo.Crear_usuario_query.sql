USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Crear_usuario_query]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Crear_usuario_query]
	(	@cName	varchar(15)	)
as
begin

	set @cName = upper( ltrim(rtrim( @cName )) )

	if 	len( @cName ) = 0
	begin
		select -1, 'Usuario a crear viene en blanco'
		return 
	end

	declare @nId	int
		set @nId	= (select max( convert(int, tbcodigo1) ) from BacParamSuda.dbo.Tabla_General_Detalle where tbcateg = 9000)
		set @nId	= @nId + 1

	if not exists( select 1 from BacParamSuda.dbo.Tabla_General_Detalle where tbcateg = 9000 and tbglosa = @cName )
	begin
		insert into BacParamSuda.dbo.Tabla_General_Detalle
		select 9000, @nId, 0.0, acfecproc, 0.0, @cName, ''
		from	BacTraderSuda.dbo.Mdac
	end else
	begin
		select 'Usuario ya existe en la query.' 
	end

end
GO
