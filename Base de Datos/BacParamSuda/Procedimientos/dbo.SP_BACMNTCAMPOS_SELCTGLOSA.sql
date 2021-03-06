USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMNTCAMPOS_SELCTGLOSA]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_BacMntCampos_SelctGlosa    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
CREATE PROCEDURE [dbo].[SP_BACMNTCAMPOS_SELCTGLOSA]
      (
       @id_sistema CHAR(3),
       @operacion CHAR(5),
       @movimiento CHAR(5)
      )
AS
BEGIN
 SET NOCOUNT ON
     SELECT glosa_operacion FROM MOVIMIENTO_CNT
     WHERE id_sistema = @id_sistema
     AND tipo_movimiento = @movimiento
     AND tipo_operacion = @operacion
 SET NOCOUNT OFF
END
GO
