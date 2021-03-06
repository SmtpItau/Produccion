USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacInterfaces_Archivo]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_BacInterfaces_Archivo]
      (   @codigo_Interfaz    CHAR(30) = ' ' 
      ,   @id_sistema         CHAR(03) = 'BTR'
      ,   @codigo_area        CHAR(05) = 'PFIN'  )
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

      IF EXISTS(SELECT 1 FROM INTERFAZ
                         WHERE codigo_Interfaz = @codigo_Interfaz
                          AND  id_sistema      = @id_sistema
                          AND  rut_entidad     = (SELECT rcrut FROM ENTIDAD))
      BEGIN

            SELECT codigo_Interfaz 
             ,     nombre
             ,     descripcion
             ,     ruta_acceso
             FROM  INTERFAZ 
             WHERE codigo_Interfaz = @codigo_Interfaz
             AND   id_sistema      = @id_sistema
             AND   rut_entidad     = (SELECT rcrut FROM ENTIDAD)

      END ELSE 
      BEGIN

         SELECT 'N','No existe interfaz, verifique la ruta de acceso'

      END

END

GO
