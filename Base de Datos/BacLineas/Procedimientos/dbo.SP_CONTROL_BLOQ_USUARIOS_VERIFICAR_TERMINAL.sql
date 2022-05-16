USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_VERIFICAR_TERMINAL]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_VERIFICAR_TERMINAL]
               (
                 @USUARIO    CHAR(10)
               , @ID_SISTEMA CHAR(3)
               , @TERMINAL   CHAR(2)
               )
        
 
AS
BEGIN
 SET NOCOUNT ON

 IF EXISTS (SELECT 1 FROM VIEW_USUARIO_ACTIVO) BEGIN
  SELECT usuario
  ,      terminal
  ,      id_sistema 
    FROM VIEW_USUARIO_ACTIVO
   WHERE Id_Sistema = @ID_SISTEMA 
     AND usuario    = @USUARIO
 END

 ELSE BEGIN
  SELECT 'ERROR'
 END

 SET NOCOUNT OFF
END

GO
