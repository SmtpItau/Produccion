USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacMntCampos_SelctGlosa]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Objeto:  procedimiento  almacenado dbo.Sp_BacMntCampos_SelctGlosa    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
CREATE PROCEDURE [dbo].[Sp_BacMntCampos_SelctGlosa]
      (
       @id_sistema CHAR(3),
       @operacion CHAR(5),
       @movimiento CHAR(5)
      )
AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON

     SELECT glosa_operacion FROM MOVIMIENTO_CNT
     WHERE id_sistema = @id_sistema
     AND tipo_movimiento = @movimiento
     AND tipo_operacion = @operacion
 SET NOCOUNT OFF
END
GO
