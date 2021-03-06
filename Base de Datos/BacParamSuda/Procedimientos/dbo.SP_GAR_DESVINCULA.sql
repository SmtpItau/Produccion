USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_DESVINCULA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_DESVINCULA]
	(	@FolioAsocia	NUMERIC(18),
		@RutCliente	NUMERIC(9),
		@CodCliente	NUMERIC(5),
		@NumGarantia	NUMERIC(10)
	)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE	@Ultima		CHAR(1),
		@CantGtias	NUMERIC(10)

	SELECT  @Ultima = 'N',
		@CantGtias = 0

	SELECT 	@CantGtias = COUNT(NumeroGarantia) FROM BacParamSuda.dbo.tbl_gar_AsociacionGtia
		WHERE FolioAsocia 	= @FolioAsocia
		AND RutCliente 		= @RutCliente
		AND CodCliente 		= @CodCliente

	IF @CantGtias = 1
		SELECT @Ultima = 'S'	

	IF @Ultima ='N'
		/*  Solo sacar la Garantía   */

		DELETE FROM BacParamSuda.dbo.tbl_gar_AsociacionGtia
		WHERE NumeroGarantia 	= @NumGarantia
		AND RutCliente 		= @RutCliente
		AND CodCliente 		= @CodCliente
	ELSE
	BEGIN
		DELETE FROM BacParamSuda.dbo.tbl_gar_AsociacionGtia
		WHERE NumeroGarantia 	= @NumGarantia
		AND RutCliente 		= @RutCliente
		AND CodCliente 		= @CodCliente

		/* Como es la última Garantía se deben desvincular además, todas las operaciones asociadas a esta garantía  */
		DELETE FROM BacParamSuda.dbo.tbl_gar_AsociacionOper
		WHERE FolioAsocia	= @FolioAsocia
		AND RutCliente 		= @RutCliente
		AND CodCliente 		= @CodCliente
	END	
	SET NOCOUNT OFF
END
GO
