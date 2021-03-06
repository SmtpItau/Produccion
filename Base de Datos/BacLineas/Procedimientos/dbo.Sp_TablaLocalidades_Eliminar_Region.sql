USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Eliminar_Region]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_TablaLocalidades_Eliminar_Region    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Eliminar_Region](@codigo_region int,
           @nombre     char(50)
          )
AS 
BEGIN
   SET NOCOUNT OFF
   IF EXISTS(SELECT codigo_region FROM REGION
  WHERE codigo_region = @codigo_region)
   BEGIN
 IF NOT EXISTS(SELECT codigo_region FROM CIUDAD
    WHERE  codigo_region = @codigo_region)
        BEGIN
        DELETE REGION WHERE codigo_region = @codigo_region --AND nombre = @nombre 
        END ELSE
    BEGIN
        SELECT "RELACIONADA"
 END
   END ELSE
   BEGIN
    SELECT "NO EXISTE"
   END
   SET NOCOUNT ON
END






GO
