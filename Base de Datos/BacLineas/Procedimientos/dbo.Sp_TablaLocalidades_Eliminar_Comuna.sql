USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Eliminar_Comuna]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_TablaLocalidades_Eliminar_Comuna    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Eliminar_Comuna](@CODIGO_COMUNA  INT,
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
       SELECT "NO EXISTE"
 
        END
 SET NOCOUNT ON
END






GO
