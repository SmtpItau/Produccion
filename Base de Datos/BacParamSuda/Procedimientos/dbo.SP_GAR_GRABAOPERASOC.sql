USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_GRABAOPERASOC]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_GRABAOPERASOC]
	(	@Folio		NUMERIC(18),
		@Sistema	VARCHAR(3),
		@numeroOp	NUMERIC(9),
		@RutCliente	NUMERIC(9),
		@CodCliente	NUMERIC(5)
	)
AS
BEGIN
	SET NOCOUNT ON
	INSERT INTO BacParamsuda.dbo.tbl_gar_AsociacionOper(
		FolioAsocia,
		Sistema,
		NumeroOperacion,
		RutCliente,
		CodCLiente)
	VALUES (
		@Folio,
		@Sistema,
		@numeroOp,
		@RutCliente,
		@CodCliente
		)
	SET NOCOUNT OFF
END
GO
