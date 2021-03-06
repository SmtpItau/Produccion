USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TABLALOCALIDADES_ELIMINAR_COMUNA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Objeto:  procedimiento  almacenado dbo.SP_TABLALOCALIDADES_ELIMINAR_COMUNA    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
CREATE PROCEDURE [dbo].[SP_TABLALOCALIDADES_ELIMINAR_COMUNA](@CODIGO_COMUNA  INT,
                 @NOMBRE  CHAR(50) 
                                  )
AS
BEGIN
 SET NOCOUNT OFF
  IF EXISTS(SELECT codigo_comuna FROM COMUNA
     WHERE  codigo_comuna = @codigo_comuna )
     BEGIN
     DELETE FROM COMUNA WHERE codigo_comuna = @codigo_comuna 
     END ELSE
 BEGIN
       SELECT 'NO EXISTE'
 
        END
 SET NOCOUNT ON
END
GO
