USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_SALIR]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_SALIR] 
        --'ADMINISTRA','1','BCC'
 (    @USUARIO CHAR(10),       
      @TERMINAL CHAR(3),
      @SISTEMA CHAR(3)  )
AS
BEGIN
 DECLARE 
  @CONT  NUMERIC(2),
  @NOMBRE  CHAR(50) 
 SET NOCOUNT ON
  
  DELETE FROM VIEW_USUARIO_ACTIVO WHERE usuario     = @USUARIO 
                                                  AND terminal    = @TERMINAL
                                                  AND id_sistema  = @SISTEMA
 SET NOCOUNT OFF
END



GO
