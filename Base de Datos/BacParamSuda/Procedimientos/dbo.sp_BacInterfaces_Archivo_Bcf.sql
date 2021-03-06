USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_BacInterfaces_Archivo_Bcf]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_BacInterfaces_Archivo_Bcf](   
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
     AND codigo_area     = 'CF'
     AND id_sistema      = 'BTR'
     AND rut_entidad     = ( SELECT rcrut FROM ENTIDAD )

   SET NOCOUNT ON
END

--select * from view_interfaz where id_sistema = 'BTR'


-- Sp_BacInterfaces_Archivo_Bcf  '1'


GO
