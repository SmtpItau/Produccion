USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAEBLOQUEO_USUARIO]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAEBLOQUEO_USUARIO]
                 (
                  @xusuario CHAR(15)
                  )
                                        
AS 
BEGIN
   SET NOCOUNT ON
      SELECT bloqueado FROM VIEW_USUARIO 
       WHERE usuario = @xusuario
   SET NOCOUNT OFF
END
GO
