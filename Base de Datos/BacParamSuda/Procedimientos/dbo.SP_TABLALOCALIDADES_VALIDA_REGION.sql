USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TABLALOCALIDADES_VALIDA_REGION]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_TABLALOCALIDADES_VALIDA_REGION    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
CREATE PROCEDURE [dbo].[SP_TABLALOCALIDADES_VALIDA_REGION] (
           @CODIGO_REGION INT
                          )
AS
BEGIN
 SET NOCOUNT OFF
  IF NOT EXISTS(SELECT codigo_region FROM REGION
     WHERE  codigo_region = @codigo_region)
      BEGIN 
      SELECT 'NO EXISTE'
        END
    SET NOCOUNT ON
END

GO
