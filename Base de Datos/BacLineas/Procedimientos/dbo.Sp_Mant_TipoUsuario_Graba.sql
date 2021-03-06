USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Mant_TipoUsuario_Graba]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_Mant_TipoUsuario_Graba    fecha de la secuencia de comandos: 03/04/2001 15:18:08 ******/
CREATE PROCEDURE [dbo].[Sp_Mant_TipoUsuario_Graba](
       @tipousuario char(15),
       @descripcion char(40) )
AS
BEGIN
 SET NOCOUNT ON
 IF NOT EXISTS(SELECT 1 FROM GEN_TIPOS_USUARIO WHERE  tipo_usuario = @tipousuario) BEGIN
  
  INSERT INTO GEN_TIPOS_USUARIO   ( Tipo_Usuario,
                                                  Descripcion
                                                ) 
                                                 VALUES(
        @tipousuario,
        @descripcion )
  SELECT "INSERTA"
 
 END
 ELSE BEGIN
  
  UPDATE GEN_TIPOS_USUARIO SET 
       tipo_usuario  = @tipousuario,
       descripcion = @descripcion
     FROM   GEN_TIPOS_USUARIO
     WHERE  tipo_usuario = @tipousuario
 
  SELECT "MODIFICA"
 END
 SET NOCOUNT OFF
END






GO
