USE [BacParamSuda]
GO
/****** Object:  View [dbo].[UserMenuOptionSp1]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[UserMenuOptionSp1]
as

	select id			 = opcion
		 , userid		 = us.idTuring
		 , menuoptionid  = opcion
	  from gen_privilegios		priv
	     , usuario				us
	 where priv.usuario = us.usuario
	   and priv.entidad = 'TUR'
		 
	  
GO
