USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Busca_Acceso_Usuario]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[Sp_Busca_Acceso_Usuario]
   (   @tipo      CHAR(01)
   ,   @entidad   CHAR(03)
   )
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   IF @Tipo = 'S' 
      SELECT nombre_sistema,id_sistema
      FROM SISTEMA
      WHERE operativo ='S'
      ORDER BY nombre_sistema

   IF @Tipo = 'T' 
      SELECT tipo_usuario
      FROM TIPO_USUARIO
      WHERE Activo = 'S'
      ORDER BY tipo_usuario

   IF @Tipo = 'U' 
      SELECT usuario
      FROM usuario
      WHERE usuario <> 'ADMINISTRA' AND activo='S'
      ORDER BY usuario

   IF @Tipo = 'M' 
      SELECT nombre_opcion, nombre_objeto, posicion
      FROM MENU
      WHERE entidad = @entidad AND entidadfox <> 2

END




GO
