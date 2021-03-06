USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_ACCESO_USUARIO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Busca_Acceso_Usuario    fecha de la secuencia de comandos: 03/04/2001 15:17:59 ******/
CREATE PROCEDURE [dbo].[SP_BUSCA_ACCESO_USUARIO]( @tipo CHAR(1),@entidad CHAR(03))
AS
BEGIN
IF @Tipo = 'S' 
   SELECT nombre_sistema,id_sistema FROM SISTEMA_CNT WHERE operativo ='S' ORDER BY nombre_sistema
IF @Tipo = 'T' 
   SELECT tipo_usuario FROM GEN_TIPOS_USUARIO 
IF @Tipo = 'U' 
   SELECT usuario FROM usuario WHERE usuario <> 'ADMINISTRA' 
IF @Tipo = 'M' 
   SELECT nombre_opcion, nombre_objeto, posicion FROM GEN_MENU Where entidad = @entidad 
END   /* FIN PROCEDIMIENTO */
--SELECT * FROM GEN_MENU
--Sp_Busca_Acceso_Usuario 'M','CNF'
--Sp_Busca_Acceso_Usuario 'M','CON'
GO
