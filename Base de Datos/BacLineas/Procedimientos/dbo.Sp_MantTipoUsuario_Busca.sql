USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MantTipoUsuario_Busca]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_MantTipoUsuario_Busca    fecha de la secuencia de comandos: 03/04/2001 15:18:08 ******/
CREATE PROCEDURE [dbo].[Sp_MantTipoUsuario_Busca]
AS
BEGIN
 SET NOCOUNT ON
 IF EXISTS(SELECT * FROM GEN_TIPOS_USUARIO) BEGIN
  SELECT *
  FROM GEN_TIPOS_USUARIO
  ORDER BY tipo_usuario
 
 END 
 ELSE BEGIN
  
  SELECT "ERROR"
 END
 
 SET NOCOUNT OFF
END






GO
