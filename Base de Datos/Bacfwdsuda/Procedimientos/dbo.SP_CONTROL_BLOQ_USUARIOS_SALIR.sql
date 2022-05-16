USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_SALIR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_SALIR](
       @USUARIO CHAR(10),       
       @TERMINAL Char(3),
       @SISTEMA Char(3)
        )
AS
BEGIN
 DECLARE 
  @CONT  NUMERIC(2),
  @NOMBRE  Char(50) 
 SET NOCOUNT ON
  
---     SET @NOMBRE = (SELECT NOMBRE FROM CONTROL_USUARIO WHERE USUARIO = @USUARIO)
  DELETE FROM VIEW_USUARIO_ACTIVO WHERE USUARIO  = @USUARIO AND
       TERMINAL = @TERMINAL AND
       ID_SISTEMA  = @SISTEMA
 
---  SELECT *, @CONT FROM CONTROL_USUARIO WHERE NOMBRE = @NOMBRE 
  SELECT USUARIO,Id_Sistema,Terminal FROM VIEW_USUARIO_ACTIVO WHERE USUARIO = @USUARIO
  
 SET NOCOUNT OFF
END

GO
