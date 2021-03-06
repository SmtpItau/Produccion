USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TABLALOCALIDADES_VALIDA_PAIS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_TABLALOCALIDADES_VALIDA_PAIS    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
CREATE PROCEDURE [dbo].[SP_TABLALOCALIDADES_VALIDA_PAIS] (
         @codigo_pais int
                        )
AS
BEGIN
 SET NOCOUNT OFF
  IF NOT EXISTS(SELECT codigo_pais FROM PAIS
     WHERE  codigo_pais = @codigo_pais
     )
      BEGIN 
      SELECT 'NO EXISTE'
        END
    SET NOCOUNT ON
END

GO
