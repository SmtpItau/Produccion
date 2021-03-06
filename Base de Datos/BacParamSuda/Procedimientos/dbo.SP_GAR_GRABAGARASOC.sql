USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_GRABAGARASOC]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_GRABAGARASOC]
	(	@Folio		NUMERIC(18),
		@numeroGar	NUMERIC(9),
		@RutCliente	NUMERIC(9),
		@CodCliente	NUMERIC(5)
	)
AS
BEGIN
	SET NOCOUNT ON
	INSERT INTO BacParamsuda.dbo.tbl_gar_AsociacionGtia(
		FolioAsocia,
		NumeroGarantia,
		RutCliente,
		CodCliente)
	VALUES (
		@Folio,
		@numeroGar,
		@RutCliente,
		@CodCliente
		)
	SET NOCOUNT OFF
END
GO
