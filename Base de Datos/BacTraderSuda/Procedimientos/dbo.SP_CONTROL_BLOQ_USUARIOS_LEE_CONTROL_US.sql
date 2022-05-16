USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_LEE_CONTROL_US]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_LEE_CONTROL_US]
as
begin
 set nocount on
 if exists (select 1 from VIEW_CONTROL_USUARIO) begin
  select * from VIEW_CONTROL_USUARIO order by usuario
 end
 else begin
  
  select 'ERROR'
 end
 set nocount off
end


GO
