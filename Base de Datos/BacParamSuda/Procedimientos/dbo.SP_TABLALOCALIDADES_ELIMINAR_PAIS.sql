USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TABLALOCALIDADES_ELIMINAR_PAIS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_TABLALOCALIDADES_ELIMINAR_PAIS    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
CREATE PROCEDURE [dbo].[SP_TABLALOCALIDADES_ELIMINAR_PAIS](@codigo_pais int,
         @nombre char(50)
         )
AS 
BEGIN
   SET NOCOUNT OFF
   IF EXISTS(SELECT codigo_pais FROM PAIS
 WHERE codigo_pais = @codigo_pais)
 BEGIN
 IF NOT EXISTS(SELECT codigo_pais FROM REGION 
    WHERE  codigo_pais = @codigo_pais)
        BEGIN
  IF NOT EXISTS(SELECT codigo_pais FROM CORRESPONSAL 
     WHERE  codigo_pais = @codigo_pais)
         BEGIN
   IF NOT EXISTS(SELECT codigo_pais FROM RIESGO_PAIS
      WHERE  codigo_pais = @codigo_pais)
          BEGIN
    IF NOT EXISTS(SELECT codigo_pais FROM PLAZA
       WHERE  codigo_pais = @codigo_pais)
           BEGIN
        DELETE PAIS WHERE codigo_pais = @codigo_pais --AND nombre = @nombre 
 
           END ELSE
       BEGIN
           SELECT 'RELACIONADA'
    END
   END ELSE
      BEGIN
       SELECT 'RELACIONADA'
   END
  END ELSE
     BEGIN
   SELECT 'RELACIONADA'
  END
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
