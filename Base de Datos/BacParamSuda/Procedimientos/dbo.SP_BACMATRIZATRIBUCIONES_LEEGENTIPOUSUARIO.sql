USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMATRIZATRIBUCIONES_LEEGENTIPOUSUARIO]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_BacMatrizAtribuciones_LeeGenTipoUsuario    fecha de la secuencia de comandos: 03/04/2001 15:17:56 ******/
CREATE PROCEDURE [dbo].[SP_BACMATRIZATRIBUCIONES_LEEGENTIPOUSUARIO]
AS BEGIN
   SET NOCOUNT ON
      SELECT tipo_usuario, descripcion FROM GEN_TIPOS_USUARIO
   SET NOCOUNT OFF
END
GO
