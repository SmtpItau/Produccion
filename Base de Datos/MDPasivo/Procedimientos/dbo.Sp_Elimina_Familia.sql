USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Elimina_Familia]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Elimina_Familia]
		(@xCodigo	CHAR(03))
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM VIEW_MOVIMIENTO_TRADER WHERE mocodigo = @xCodigo)
	OR EXISTS(SELECT 1 FROM SERIE WHERE secodigo = @xCodigo) BEGIN
	   SELECT 'NO'
	   RETURN
	END

	 DELETE INSTRUMENTO WHERE incodigo = @xCodigo

	IF @@ERROR <> 0 BEGIN
	  SELECT 'NO'
	  RETURN
	END
	SELECT 'SI'
SET NOCOUNT OFF
END

GO
