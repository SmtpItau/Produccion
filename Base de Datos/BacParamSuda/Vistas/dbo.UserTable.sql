USE [BacParamSuda]
GO
/****** Object:  View [dbo].[UserTable]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[UserTable]
as

	select id				= IdTuring
		 , nick				= usuario
		 , name				= nombre
		 , password			= clave
		 , status			= 'E'
		 , usertype			= 'A'
		 , enabled			= '0'
		 , creatordate		= getdate()
		 , userbac			= usuario
	  from usuario	  
	 

GO
