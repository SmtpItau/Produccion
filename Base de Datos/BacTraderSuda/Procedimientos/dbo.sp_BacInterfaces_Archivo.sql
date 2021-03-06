USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_BacInterfaces_Archivo]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_BacInterfaces_Archivo]
(@codigo_Interfaz  NUMERIC(05))
AS
BEGIN
SET NOCOUNT ON

SELECT    codigo_Interfaz
		, nombre
		, descripcion
		, ruta_acceso
FROM VIEW_INTERFAZ
WHERE codigo_Interfaz = @codigo_Interfaz
	  AND codigo_area     = 'PFIN'
	  AND id_sistema      = 'BTR'
	  AND rut_entidad     = ( SELECT rcrut FROM VIEW_ENTIDAD )

SET NOCOUNT ON
END


-- Base de Datos --
GO
