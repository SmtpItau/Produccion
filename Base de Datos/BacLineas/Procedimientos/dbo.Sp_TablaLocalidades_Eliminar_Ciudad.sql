USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Eliminar_Ciudad]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_TablaLocalidades_Eliminar_Ciudad    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Eliminar_Ciudad] ( @codigo_ciudad int,
             @nombre     char(50)
           )
AS 
BEGIN
   SET NOCOUNT OFF
   IF EXISTS(SELECT codigo_ciudad FROM CIUDAD
  WHERE codigo_ciudad = @codigo_ciudad)
   BEGIN
 IF NOT EXISTS(SELECT codigo_ciudad FROM COMUNA
    WHERE  codigo_ciudad = @codigo_ciudad)
        BEGIN
        DELETE CIUDAD WHERE codigo_ciudad = @codigo_ciudad --AND nombre = @nombre 
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
