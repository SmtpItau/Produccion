USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_GARANTIA_OTORGADA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ELIMINA_GARANTIA_OTORGADA]
	(
		@Folio	NUMERIC(10)
	)
AS
BEGIN
	SET NOCOUNT ON
	IF NOT EXISTS(SELECT Folio FROM Bacparamsuda..tbl_Garantias_Otorgadas WHERE Folio = @Folio)
	BEGIN
		SELECT 'NO'
		RETURN 1
	END
	IF EXISTS(SELECT Folio FROM Bacparamsuda..tbl_Garantias_Otorgadas_Detalle WHERE Folio = @Folio)
	BEGIN
		DELETE FROM Bacparamsuda..tbl_Garantias_Otorgadas_Detalle
		WHERE Folio = @Folio
		IF @@ERROR <> 0
		BEGIN
			SELECT 'NO'
			RETURN 1
		END
	END
	DELETE FROM Bacparamsuda..Tbl_Garantias_Otorgadas
	WHERE Folio = @Folio
	IF @@ERROR <> 0
	BEGIN
		SELECT 'NO'
		RETURN 1
	END	
	SELECT 'OK'
	SET NOCOUNT OFF
END
GO
