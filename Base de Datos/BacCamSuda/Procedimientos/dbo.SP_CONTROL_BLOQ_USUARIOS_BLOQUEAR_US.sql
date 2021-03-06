USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR_US]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR_US] (
       @usuario char(10),
       @id_sistema char(3),
       @terminal char(2),
       @bloqueado char(1)   )
as
begin
 set nocount on
 
 if exists (select 1 from VIEW_USUARIO_ACTIVO where usuario = @usuario and terminal=@terminal or left(usuario,len(usuario)-1) = @usuario and terminal=@terminal ) begin
  update VIEW_USUARIO_ACTIVO  set terminal  = @bloqueado + @terminal
      where 
       usuario = @usuario and 
       terminal=@terminal or 
       left(usuario,len(usuario)-1) = @usuario and 
       terminal=@terminal 
  
  select 'OK'
  
 end
 else begin
  select 'ERROR'
 end
 set nocount off
end
 




GO
