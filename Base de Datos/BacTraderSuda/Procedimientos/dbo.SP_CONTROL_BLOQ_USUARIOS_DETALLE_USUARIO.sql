USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_DETALLE_USUARIO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_DETALLE_USUARIO] 
(
        @usuario char(10)
)     
 
as
begin
 set nocount on
 if exists (select 1 from VIEW_USUARIO_ACTIVO where usuario = @usuario) begin
  select  usuario,
   id_sistema,
   terminal,
   fechaproceso,
   fechasistema
   
   from VIEW_USUARIO_ACTIVO
   where usuario  = @usuario
 end
 else begin
  select  usuario,
   id_sistema,
   terminal 
   from VIEW_CONTROL_USUARIO
   where usuario  = @usuario
  
 end
 set nocount off
end

GO
