USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Mant_TipoUsuario_Elimina]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_Mant_TipoUsuario_Elimina    fecha de la secuencia de comandos: 03/04/2001 15:18:08 ******/
CREATE PROCEDURE [dbo].[Sp_Mant_TipoUsuario_Elimina](
       @tipousuario char(15),
       @descripcion char(40))
AS
BEGIN
 SET NOCOUNT ON
 
 IF EXISTS(SELECT 1 FROM GEN_TIPOS_USUARIO WHERE  tipo_usuario = @tipousuario) BEGIN
 
  DELETE FROM GEN_TIPOS_USUARIO WHERE 
       tipo_usuario = @tipousuario and
       descripcion  = @descripcion
  SELECT "OK"  
 END
 ELSE BEGIN
  
  SELECT "ERROR"
 END
 SET NOCOUNT OFF
 
END






GO
