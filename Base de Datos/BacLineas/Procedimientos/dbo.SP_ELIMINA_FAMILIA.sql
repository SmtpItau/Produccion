USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_FAMILIA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_ELIMINA_FAMILIA    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_ELIMINA_FAMILIA    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/
CREATE PROCEDURE [dbo].[SP_ELIMINA_FAMILIA](@xSerie  CHAR(12))
AS
BEGIN
SET NOCOUNT ON
 DELETE INSTRUMENTO WHERE inserie = @xSerie
IF @@ERROR <> 0 BEGIN
  SELECT 'NO'
  RETURN
END
SELECT 'SI'
SET NOCOUNT OFF
END
GO
