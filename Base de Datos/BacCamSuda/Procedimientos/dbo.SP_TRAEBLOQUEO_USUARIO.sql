USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAEBLOQUEO_USUARIO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_TRAEBLOQUEO_USUARIO]
            (@xusuario char(12))
                                        
as 
begin
set nocount on
  select bloqueado 
    from VIEW_USUARIO 
    where usuario = @xusuario
set nocount off
end



GO
