USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TABLALOCALIDADES_ELIMINAR_REGION]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_TABLALOCALIDADES_ELIMINAR_REGION    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
CREATE PROCEDURE [dbo].[SP_TABLALOCALIDADES_ELIMINAR_REGION](@codigo_region int,
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
        SELECT 'RELACIONADA'
 END
   END ELSE
   BEGIN
    SELECT 'NO EXISTE'
   END
   SET NOCOUNT ON
END

GO
