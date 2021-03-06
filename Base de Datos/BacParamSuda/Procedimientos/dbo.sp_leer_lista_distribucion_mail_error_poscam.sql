USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_leer_lista_distribucion_mail_error_poscam]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_leer_lista_distribucion_mail_error_poscam]
as
begin

	set nocount on
	
	-->		1. Valida que no exista la categoria, para crear la lista de distribucion de Mail
	if not exists ( select 1 from BacParamSuda.dbo.Tabla_General_Global where ctcateg = 56 )
	begin
		insert	into BacParamSuda.dbo.Tabla_General_Global
		select	ctcateg		= 56
			,	ctdescrip	= 'Mail Servico Poscam'
			,	ctindcod	= 1
			,	ctindtasa	= 1
			,	ctindfech	= 0
			,	ctindvalor	= 0
			,	ctindglosa	= 0
			,	tbSistema	= ''
			,	tbcodtab	= 0
			,	tbglosa		= 0
			,	tbtipmnt	= ''
	end

	-->		2. Valida que no exista la categoria, para crear los miembros de lista de distribucion de Mail
	if not exists ( select 1 from BacParamSuda.dbo.Tabla_General_detalle where tbcateg = 56 )
	begin
		insert	into BacParamSuda.dbo.Tabla_General_detalle
			(	tbcateg, tbcodigo1, tbtasa, tbfecha, tbvalor, tbglosa, nemo	)
		select	56, 1, 1, '20150318', 0, 'adrian.gonzalez@corpbanca.cl'		, ''		union
		select	56, 2, 0, '20150318', 0, 'alan.shomaly@corpbanca.cl'		, ''		union
		select	56, 3, 0, '20150318', 0, 'carlos.basterrica@corpbanca.cl'	, ''		union
		select	56,	4, 0, '20150318', 0, 'claudia.bravo@corpbanca.cl'		, ''
	end



	if not exists(	select	1 
					from	BacParamSuda.dbo.Tabla_General_detalle with(nolock)
					where	tbcateg = 56 
					and		nemo	= 'S' 
					and		tbfecha	= (	select acfecproc from BacTraderSuda.dbo.mdac with(nolock) )
					)
	begin

		update	BacParamSuda.dbo.Tabla_General_detalle
		set		nemo	= 'S'
			,	tbfecha	= (	select acfecproc from BacTraderSuda.dbo.mdac with(nolock) )
		where	tbcateg = 56
		and		tbtasa	= 1

		-->		3. Genera la lista de miembros, para distribuir Mail por problema en el servicio
		select	'Distribucion' = ltrim(rtrim( lower(tbglosa) ))
		from	BacParamSuda.dbo.Tabla_General_detalle with(nolock)
		where	tbcateg = 56
		and		tbtasa	= 1

	end else
	begin
		select	'Distribucion' = ''
	end

end
GO
