USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_SALIR]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_SALIR](
       @usuario char(10),       
       @terminal char(3),
       @sistema char(3)
        )
as
begin
 declare 
  @cont  numeric(2),
  @nombre  char(50) 
 set nocount on
  
---     set @nombre = (select nombre from control_usuario where usuario = @usuario)
  delete from VIEW_USUARIO_ACTIVO where usuario  = @usuario and
       terminal = @terminal and
       id_sistema  = @sistema
 
---  select *, @cont from control_usuario where nombre = @nombre 
  select usuario,id_sistema,terminal from VIEW_USUARIO_ACTIVO where usuario = @usuario
  
 set nocount off
end


GO
