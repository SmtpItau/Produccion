USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_ACCESO_USUARIO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_BUSCA_ACCESO_USUARIO]( @Tipo CHAR(1),@Entidad CHAR(03))
AS
BEGIN
IF @Tipo = 'S' 
   SELECT sistema, entidad FROM VIEW_GEN_SISTEMAS
IF @Tipo = 'T' 
   SELECT tipo_usuario FROM VIEW_GEN_TIPOS_USUARIO
IF @Tipo = 'U' 
   SELECT usuario FROM VIEW_USUARIO WHERE usuario <> 'ADMINISTRA'
IF @Tipo = 'M' 
   SELECT nombre_opcion, nombre_objeto, posicion FROM VIEW_GEN_MENU Where entidad = @Entidad
END   


GO
