USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_GENERAUS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_GENERAUS] (
       @usuario char(10),
       @nombre  char(3)
          )
as
begin
 declare 
   @terminal  char(6),
   @cont   numeric(2), 
   @tmp   char(6),
   @tmp2   char(6)
 set nocount on
 
 if exists (select usuario,nombre from VIEW_CONTROL_USUARIO where usuario = @usuario and nombre = @nombre  ) begin
  
  delete from VIEW_CONTROL_USUARIO
         where usuario = @usuario and nombre = @nombre  
  
 end
  insert into  control_usuario 
   values (
    @usuario,
    'BTR',
                                @nombre,
    '000000',
    'N'
    )
 
 set nocount off
end


GO
