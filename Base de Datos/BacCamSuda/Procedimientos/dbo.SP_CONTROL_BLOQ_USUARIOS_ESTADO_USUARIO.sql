USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_ESTADO_USUARIO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_ESTADO_USUARIO]
            (   
                @USUARIO CHAR(15),
  @ID_SISTEMA CHAR(3)   
            )
AS
BEGIN
SET NOCOUNT ON
   IF EXISTS (SELECT 1 FROM VIEW_CONTROL_USUARIO ) 
   BEGIN
   
      SELECT BLOQUEADO 
      FROM   VIEW_CONTROL_USUARIO
      WHERE  id_sistema   = @ID_SISTEMA 
        AND  usuario   = @USUARIO
   END   ELSE    BEGIN
   
      SELECT 'ERROR'
   END
SET NOCOUNT OFF
END



GO
