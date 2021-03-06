USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_BORRAGARASOCFOLIO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_BORRAGARASOCFOLIO]
	(	@Folio		NUMERIC(18),
		@RutCliente	NUMERIC(9),
		@CodCliente	NUMERIC(5)
	)
AS
BEGIN
	SET NOCOUNT ON

	DELETE 	FROM Bacparamsuda.dbo.tbl_gar_AsociacionGtia
	WHERE 	FolioAsocia = @Folio
	AND	RutCliente  = @RutCliente
	AND	CodCliente  = @CodCliente

	SET NOCOUNT OFF
END
GO
