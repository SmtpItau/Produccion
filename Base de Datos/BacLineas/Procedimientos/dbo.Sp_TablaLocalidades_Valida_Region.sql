USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Valida_Region]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_TablaLocalidades_Valida_Region    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Valida_Region] (
           @CODIGO_REGION INT
                          )
AS
BEGIN
 SET NOCOUNT OFF
  IF NOT EXISTS(SELECT codigo_region FROM REGION
     WHERE  codigo_region = @codigo_region)
      BEGIN 
      SELECT "NO EXISTE"
        END
    SET NOCOUNT ON
END






GO
