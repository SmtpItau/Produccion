USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR_SISTEMAS_US]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_BLOQUEAR_SISTEMAS_US](
       @Usuario Char(10),
       @Nombre  Char(50),
       @Id_Sistema Char(3),
       @Bloqueado Char(1)   )
AS
BEGIN
 SET NOCOUNT ON
 
 IF EXISTS (SELECT 1 FROM VIEW_CONTROL_USUARIO WHERE NOMBRE=@NOMBRE) BEGIN
  UPDATE VIEW_CONTROL_USUARIO  SET BLOQUEADO  = @Bloqueado
      WHERE 
       NOMBRE  = @NOMBRE
  
  SELECT 'OK'
  
 END
 ELSE BEGIN
  SELECT 'ERROR'
 END
 SET NOCOUNT OFF
END

GO
