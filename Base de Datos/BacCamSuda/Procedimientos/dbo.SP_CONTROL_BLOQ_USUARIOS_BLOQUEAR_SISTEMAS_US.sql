USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR_SISTEMAS_US]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR_SISTEMAS_US]
                        (
   @usuario char(10),
   @nombre  char(50),
   @id_sistema char(3),
   @bloqueado char(1)   )
as
begin
 set nocount on
 
 if exists (select 1 from VIEW_CONTROL_USUARIO where nombre=@nombre) begin
  update VIEW_CONTROL_USUARIO  set bloqueado  = @bloqueado
      where 
       nombre  = @nombre
  
  select 'OK'
  
 end
 else begin
  select 'ERROR'
 end
 set nocount off
end




GO
