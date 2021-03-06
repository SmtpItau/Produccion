USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAGTIASOTORGADAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAGTIASOTORGADAS]
	(	@Fecha		DATETIME
	,	@RutCliente	NUMERIC(9)
	,	@CodCliente	NUMERIC(9)
	,	@FechaVigencia	DATETIME
	,	@Numdocu	NUMERIC(9)
	,	@Correlativo	NUMERIC(5)
	,	@Nemotecnico	VARCHAR(12)
	,	@Nominal	NUMERIC(21,4)
	,	@TIR		NUMERIC(9,4)
	,	@VPAR		NUMERIC(9,4)
	,	@ValorPresente	NUMERIC(21,4)
	)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Folio NUMERIC(9)
	SELECT @Folio = ISNULL(ACNumGarantiasOtorgadas,0) FROM Bacparamsuda..Tbl_Parametros_Gral_Garantias
	SELECT @Folio = @Folio + 1
	UPDATE Bacparamsuda..Tbl_Parametros_Gral_Garantias
	SET ACNumGarantiasOtorgadas = @Folio

	INSERT INTO Bacparamsuda..tbl_Garantias_Otorgadas(Fecha, Folio, RutCliente, CodCliente, TipoGarantia, FechaVigencia)
	VALUES(@Fecha, @Folio, @RutCliente, @CodCliente, 1, @FechaVigencia)

	INSERT INTO Bacparamsuda..tbl_Garantias_Otorgadas_Detalle(Folio, Numdocu, Correlativo, Nemotecnico, Nominal,
								  TIR, VPAR, ValorPresente, TirMercado, ValorMercado)
	VALUES(@Folio, @Numdocu, @Correlativo, @Nemotecnico, @Nominal, @TIR, @VPAR, @ValorPresente, 0, 0)
	SET NOCOUNT OFF

END
GO
