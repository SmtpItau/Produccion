USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_LEE]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_LEE]
as
begin
 set nocount on
 if exists (select 1 from VIEW_CONTROL_USUARIO) begin
  select VIEW_CONTROL_USUARIO.*, VIEW_SISTEMA_CNT.nombre_sistema,  VIEW_SISTEMA_CNT.id_sistema from VIEW_CONTROL_USUARIO, VIEW_SISTEMA_CNT
   where VIEW_SISTEMA_CNT.id_sistema = VIEW_CONTROL_USUARIO.id_sistema
   order by usuario
 end
 else begin
  
  select 'ERROR'
 end
 set nocount off
end

GO
