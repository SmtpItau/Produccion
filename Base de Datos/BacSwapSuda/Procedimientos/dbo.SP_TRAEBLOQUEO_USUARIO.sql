USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAEBLOQUEO_USUARIO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAEBLOQUEO_USUARIO]  
                  (@xUsuario CHAR(12))
                                        
AS 
BEGIN
   SET NOCOUNT ON
   SELECT bloqueado FROM VIEW_USUARIO WHERE usuario = @xUsuario  
   SET NOCOUNT OFF
END


GO
