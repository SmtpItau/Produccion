USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GLOSA_MENU]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_GLOSA_MENU    fecha de la secuencia de comandos: 03/04/2001 15:18:04 ******/
create procedure [dbo].[SP_GLOSA_MENU]
  (@glosa_menu char(30))
as 
begin
 set nocount on
 select nombre_opcion,nombre_objeto
 from GEN_MENU 
 where nombre_opcion=@glosa_menu 
 set nocount off
end
GO
