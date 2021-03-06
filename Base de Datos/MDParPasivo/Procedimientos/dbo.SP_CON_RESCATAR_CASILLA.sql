USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_RESCATAR_CASILLA]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CON_RESCATAR_CASILLA]
   (   @cId_Sistema      CHAR(03)
   ,   @cCodigo_Interfaz CHAR(30)
   )
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

   SELECT c.nombre_host
      ,   c.direccion_host
      ,   c.usuario_host
      ,   c.clave_host
      ,   CASE WHEN i.tipo_interfaz = 2 THEN i.path_inicio    ELSE i.path_final    END AS path_uno
      ,   CASE WHEN i.tipo_interfaz = 2 THEN i.archivo_inicio ELSE i.archivo_final END AS archivo_uno
      ,   CASE WHEN i.tipo_interfaz = 1 THEN i.path_inicio    ELSE i.path_final    END AS path_dos
      ,   CASE WHEN i.tipo_interfaz = 1 THEN i.archivo_inicio ELSE i.archivo_final END AS archivo_dos
   FROM   INTERFAZ i
          LEFT JOIN CASILLA_TRANSMISION c ON i.codigo_interfaz = c.codigo_interfaz AND i.casilla = c.nombre_host
   WHERE  i.id_sistema      = @cId_Sistema
     AND  i.codigo_interfaz = @cCodigo_Interfaz

END

GO
