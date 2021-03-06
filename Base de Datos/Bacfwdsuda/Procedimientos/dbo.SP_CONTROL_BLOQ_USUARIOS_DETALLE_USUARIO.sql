USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_DETALLE_USUARIO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_DETALLE_USUARIO] (
        @USUARIO CHAR(10)
        )
        
 
AS
BEGIN
 SET NOCOUNT ON
 IF EXISTS (SELECT 1 FROM VIEW_USUARIO_ACTIVO WHERE USUARIO = @USUARIO) BEGIN
  SELECT  Usuario,
   Id_Sistema,
   Terminal,
   FechaProceso,
   FechaSistema
   
   FROM VIEW_USUARIO_ACTIVO
   WHERE USUARIO  = @USUARIO
 END
 ELSE BEGIN
  SELECT  Usuario,
   Id_Sistema,
   terminal 
   FROM VIEW_CONTROL_USUARIO
   WHERE USUARIO  = @USUARIO
  
 END
 SET NOCOUNT OFF
END

GO
