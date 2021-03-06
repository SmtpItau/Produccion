USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_BacInterfaces_Archivo_PCA]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_BacInterfaces_Archivo_PCA](   
	@codigo_Interfaz  NUMERIC(05) 
)

AS
BEGIN
   SET NOCOUNT ON

   SELECT codigo_Interfaz 
      ,   nombre
      ,   descripcion
      ,   ruta_acceso

    FROM INTERFAZ 
   WHERE codigo_Interfaz = @codigo_Interfaz
     AND codigo_area     = 'TCRC'
     AND id_sistema      = 'PCA'
     AND rut_entidad     = ( SELECT rcrut FROM ENTIDAD )

   SET NOCOUNT ON
END


GO
