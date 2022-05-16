USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TABLALOCALIDADES_VALIDA_CIUDAD]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_TABLALOCALIDADES_VALIDA_CIUDAD    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
CREATE PROCEDURE [dbo].[SP_TABLALOCALIDADES_VALIDA_CIUDAD] (
          @CODIGO_CIUDAD INT
                          )
AS
BEGIN
 SET NOCOUNT OFF
  IF NOT EXISTS(SELECT codigo_ciudad FROM CIUDAD
     WHERE  codigo_ciudad = @codigo_ciudad)
      BEGIN 
      SELECT 'NO EXISTE'
        END
    SET NOCOUNT ON
END

GO
