USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_AGREGADISPFOLIO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_AGREGADISPFOLIO]
	(	@nFolio		NUMERIC(18),
		@RutCliente	NUMERIC(9),
		@CodCliente	NUMERIC(5),
		@numGarantia	NUMERIC(10)
	)
AS
BEGIN
	SET NOCOUNT ON
	INSERT INTO Bacparamsuda.dbo.tbl_gar_AsociacionGtia(
		FolioAsocia,
		RutCliente,
		CodCliente,
		NumeroGarantia)		

	VALUES(	@nFolio,
		@RutCliente,
		@CodCliente,
		@NumGarantia)


	SET NOCOUNT OFF
END
GO
