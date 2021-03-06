USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_FORMULARIOS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_FORMULARIOS]( @tipo        char(1) ,
                                  @entidad     char(3) ,
                                  @formulario  char(20) )
as
begin
if @tipo = 'F' 
   select distinct nombre_formulario, formulario from GEN_FORMULARIOS where entidad = @entidad
else
   select nombre_opcion, opcion from GEN_FORMULARIOS where formulario = @formulario
end   /* fin procedimiento */


GO
