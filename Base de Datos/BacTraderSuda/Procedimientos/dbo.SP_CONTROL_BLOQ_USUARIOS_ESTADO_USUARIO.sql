USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_ESTADO_USUARIO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_ESTADO_USUARIO] (
        @usuario char(10),
        @id_sistema char(3)
        )
        
 
as
begin
 set nocount on
 if exists (select 1 from VIEW_CONTROL_USUARIO) begin
  select bloqueado from VIEW_CONTROL_USUARIO
   where id_sistema = @id_sistema and
         usuario  = @usuario
 end
 else begin
  
  select 'ERROR'
 end
 set nocount off
end


GO
