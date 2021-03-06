USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_MARCAROPERACION]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_MARCAROPERACION]
	(	@modo CHAR(1)='M',
		@numOperacion NUMERIC(9),
		@correlativo NUMERIC(5),
		@Usuario CHAR(20),
		@Controlador NUMERIC(9),
		@numeroRut NUMERIC(9)
	)
AS
BEGIN

	SET NOCOUNT ON

	IF @modo = 'M'
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM BacTraderSuda..mdbl
				WHERE blnumdocu = @numOperacion
				AND blcorrela = @correlativo)
		BEGIN
			INSERT INTO BacTraderSuda..mdbl
			VALUES(@numeroRut, @numOperacion, @correlativo, @Controlador, @Usuario)
			SELECT 'OK'
		END
		ELSE
			SELECT 'NO'
	END				
	IF @modo = 'D'
	BEGIN
		IF EXISTS(SELECT 1 FROM BacTraderSuda..mdbl
				WHERE blnumdocu = @numOperacion
				AND blcorrela = @correlativo)
		BEGIN
			DELETE FROM BacTraderSuda..mdbl
			WHERE blnumdocu = @numOperacion
			AND blcorrela = @correlativo
			AND blrutcart = @numeroRut
			AND blusuario = @Usuario
			SELECT 'OK'
		END
		ELSE
			SELECT 'NO'
	END
	SET NOCOUNT OFF
END
GO
