USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Valida_Pais]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_TablaLocalidades_Valida_Pais    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Valida_Pais] (
         @codigo_pais int
                        )
AS
BEGIN
 SET NOCOUNT OFF
  IF NOT EXISTS(SELECT codigo_pais FROM PAIS
     WHERE  codigo_pais = @codigo_pais
     )
      BEGIN 
      SELECT "NO EXISTE"
        END
    SET NOCOUNT ON
END






GO
