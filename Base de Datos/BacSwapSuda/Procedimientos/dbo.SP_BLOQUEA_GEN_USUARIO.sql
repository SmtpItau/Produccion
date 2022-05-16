USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BLOQUEA_GEN_USUARIO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BLOQUEA_GEN_USUARIO]  
                                       (@xUsuario CHAR(12),
                                        @xBloqueo CHAR(1))
AS
BEGIN

   SET NOCOUNT ON

  	UPDATE VIEW_USUARIO SET Bloqueado = @xBloqueo 
		WHERE Usuario = @xUsuario 
		AND USUARIO <> 'ADMINISTRA'
	
   SET NOCOUNT OFF

   SELECT 'OK'  
 
END
GO
