USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BLOQUEA_GEN_USUARIO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[SP_BLOQUEA_GEN_USUARIO]
 (
  @xusuario char(12),
                @xbloqueo char(1)
 )
as
begin
set nocount on
  update VIEW_USUARIO 
    set bloqueado = @xbloqueo 
  where usuario = @xusuario 
    AND usuario <> 'ADMINISTRA'
select 0
set nocount off
end

GO
