USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR]
            (
  @usuario char(10),
  @nombre  char(50),
  @id_sistema char(3),
  @bloqueado char(1)   )
as
begin
 set nocount on
 
 if exists (select 1 from VIEW_CONTROL_USUARIO where usuario=@usuario and id_sistema=@id_sistema) begin
  update VIEW_CONTROL_USUARIO  set bloqueado  = @bloqueado
     where usuario  = @usuario and
      id_sistema = @id_sistema and
      nombre  = @nombre
  
  select 'OK'
  
 end
 else begin
  select 'ERROR'
 end
 set nocount off
end

GO
