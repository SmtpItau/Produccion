USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_SERIE]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Elimina_Serie    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Elimina_Serie    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/
CREATE PROCEDURE [dbo].[SP_ELIMINA_SERIE]
                  (@xSerie  CHAR(12))
AS
BEGIN
SET NOCOUNT ON
IF EXISTS(Select 1 FROM VIEW_MDDI WHERE diinstser = @xSerie)  BEGIN
  SET NOCOUNT OFF
  SELECT 'NO'
  RETURN
END
DELETE SERIE WHERE seserie = @xSerie
DELETE TABLA_DESARROLLO WHERE tdmascara= @xSerie
IF @@error <> 0 BEGIN
 SET NOCOUNT OFF
 SELECT 'NO'
 RETURN
END
SET NOCOUNT OFF
SELECT 'SI'
END
GO
