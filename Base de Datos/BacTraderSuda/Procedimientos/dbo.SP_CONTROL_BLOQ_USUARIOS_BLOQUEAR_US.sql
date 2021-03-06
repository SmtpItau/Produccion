USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR_US]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR_US] (
       @usuario char(10),
       @id_sistema char(3),
       @terminal char(2),
       @bloqueado char(1)   )
as
begin
 set nocount on
 if exists (select 1 from VIEW_USUARIO_ACTIVO where usuario = @usuario and left(terminal,1)='N' and id_sistema = @id_sistema ) begin
      
            DELETE FROM VIEW_USUARIO_ACTIVO 
      WHERE 
       usuario = @usuario and 
       LEFT(terminal,1)='N' and
       id_sistema= @id_sistema
        end 
 
 if exists (select 1 from VIEW_USUARIO_ACTIVO where usuario = @usuario and terminal=@terminal and id_sistema = @id_sistema ) begin
  update VIEW_USUARIO_ACTIVO  set terminal  = @bloqueado + @terminal
      where 
       usuario = @usuario and 
       terminal=@terminal and
       id_sistema= @id_sistema
  
  select 'OK'
  
 end
 else begin
  select 'ERROR'
 end
 set nocount off
end
 

GO
