USE [BacParamSuda]
GO
/****** Object:  View [dbo].[UserMenuOption]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[UserMenuOption]
as

	select id			 = opcion
		 , userid		 = us.idTuring
		 , menuoptionid  = opcion
	  from gen_privilegios		priv
	     , usuario				us
	 where priv.usuario = us.usuario
	   and priv.entidad = 'TUR'
	   and habilitado = 'S'
	 union
	select id			 = opcion
		 , userid		 = us.idTuring
		 , menuoptionid  = opcion
	  from gen_privilegios		priv
	     , usuario				us
	 where priv.usuario = us.tipo_usuario
	   and priv.entidad = 'TUR'
	   and habilitado = 'S'
	   and not us.idTuring is null
	   and not exists(select 1 from gen_privilegios where gen_privilegios.usuario = us.usuario and gen_privilegios.entidad = 'TUR')
GO
