USE [BacParamSuda]
GO
/****** Object:  View [dbo].[MenuOption]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[MenuOption]
as

	select 'ID'            = nombre_objeto
         , 'MNEMONIC'      = nombre_opcion
         , 'DESCRIPTION'   = nombre_opcion
         , 'MENUID'        = 1
         , 'LEVELID'       = posicion + 1
         , 'STATUSID'      = 1
         , 'FATHERID'	   = dbo.fnObtienePadreMenuTuring(convert(int,nombre_objeto))
         , 'ORDER'		   = indice
	  from gen_menu
	 where entidad = 'TUR'



GO
