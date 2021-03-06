USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_VERIFICAR_TERMINAL]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_VERIFICAR_TERMINAL] (
        @usuario char(10),
        @id_sistema char(3),
        @terminal char(2)
        )
        
 
as
begin
 set nocount on
 ---delete from VIEW_USUARIO_ACTIVO where left(terminal,1)='N'  
 if exists (select 1 from VIEW_USUARIO_ACTIVO) begin
  select usuario,terminal,id_sistema from VIEW_USUARIO_ACTIVO
   where id_sistema = @id_sistema and
         usuario  = @usuario
 end
 else begin
  
  select 'ERROR'
 end
 set nocount off
end


GO
