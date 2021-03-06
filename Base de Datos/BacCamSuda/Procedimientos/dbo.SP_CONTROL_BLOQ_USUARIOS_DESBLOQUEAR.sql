USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_DESBLOQUEAR]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_DESBLOQUEAR](
       @usuario char(10),
       @nombre  char(40),
       @id_sistema char(3)
        )
as
begin
 set nocount on
 
 if exists (select 1 from VIEW_CONTROL_USUARIO where usuario=@usuario and id_sistema=@id_sistema) begin
  update VIEW_CONTROL_USUARIO  set bloqueado  = 'n'
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
