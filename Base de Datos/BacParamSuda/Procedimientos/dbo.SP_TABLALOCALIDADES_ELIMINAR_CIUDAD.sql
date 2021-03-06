USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TABLALOCALIDADES_ELIMINAR_CIUDAD]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_TABLALOCALIDADES_ELIMINAR_CIUDAD    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
CREATE PROCEDURE [dbo].[SP_TABLALOCALIDADES_ELIMINAR_CIUDAD] ( @codigo_ciudad int,
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
        SELECT 'RELACIONADA'
   END
 
   END ELSE
   BEGIN
    SELECT 'NO EXISTE'
   END
   SET NOCOUNT ON
END
GO
