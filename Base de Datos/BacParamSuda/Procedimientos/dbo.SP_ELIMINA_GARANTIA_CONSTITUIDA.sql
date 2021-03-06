USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_GARANTIA_CONSTITUIDA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ELIMINA_GARANTIA_CONSTITUIDA]
	(
		@Folio NUMERIC(10)
	)
AS
BEGIN
	SET NOCOUNT ON
	--- Validar existencia en Encabezado Garantías
	IF NOT EXISTS(SELECT NumeroOperacion FROM Bacparamsuda..tbl_mov_garantia WHERE NumeroOperacion = @Folio)
	BEGIN
		SELECT 'NO'
		RETURN 1
	END
	--- Borrar el Detalle de las Garantías
	IF EXISTS(SELECT NumeroOperacion FROM Bacparamsuda..tbl_mov_garantia_detalle WHERE NumeroOperacion = @Folio)
	BEGIN
		DELETE FROM Bacparamsuda..tbl_mov_garantia_detalle
		WHERE NumeroOperacion = @Folio
		IF @@ERROR <> 0
		BEGIN
			SELECT 'NO'
			RETURN 1
		END
	END
	--- Borrar en la Cartera de las Garantías
	IF EXISTS(SELECT NumeroOperacion FROM Bacparamsuda..tbl_cartera_garantia WHERE NumeroOperacion = @Folio)
	BEGIN
		DELETE FROM Bacparamsuda..tbl_cartera_garantia
		WHERE NumeroOperacion = @Folio
		IF @@ERROR <> 0
		BEGIN
			SELECT 'NO'
			RETURN 1
		END
	END
	--- Borrar el Encabezado de las Garantías
	DELETE FROM Bacparamsuda..Tbl_mov_garantia
	WHERE NumeroOperacion = @Folio
	IF @@ERROR <> 0
	BEGIN
		SELECT 'NO'
		RETURN 1
	END	
	SELECT 'OK'
	SET NOCOUNT OFF
END
GO
