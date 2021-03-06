USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_GRABA_ENCABEZADO_GARANTIAS_OTORGADAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_GRABA_ENCABEZADO_GARANTIAS_OTORGADAS](
		@nNumfolio	NUMERIC(10)
	,	@dFechaProceso	DATETIME
	,	@nRut		NUMERIC(10)
	,	@nCodigo	NUMERIC(5)
	,	@iTipoGarantia	INTEGER
	,	@dFechaVigencia	DATETIME	
	,	@FactorAditivo	NUMERIC(18,0) )
AS
BEGIN

	SET NOCOUNT ON

	IF EXISTS ( SELECT 1 FROM bacparamsuda.dbo.tbl_garantias_otorgadas WHERE folio = @nnumfolio)
	BEGIN
		
		UPDATE bacparamsuda.dbo.tbl_garantias_otorgadas
		SET 	tipoGarantia = @iTipoGarantia
		,      	fechavigencia= @dFechaVigencia
		,	FactorAditivo= @FactorAditivo
		WHERE folio = @nnumfolio		
	END ELSE 
	BEGIN 
		INSERT INTO bacparamsuda.dbo.tbl_garantias_otorgadas
		(	Folio
		,	Fecha
		,	RutCliente
		,	CodCliente
		,	TipoGarantia
		,	FechaVigencia
		,	FactorAditivo
		) VALUES (
			@nNumFolio
		,	@dFechaProceso
		,	@nRut
		,	@nCodigo
		,	@iTipoGarantia
		,	@dFechaVigencia
		,	@FactorAditivo
		)
	END
	IF @@ERROR<>0 
		SELECT -1, 'Problemas al grabar informacion del encabezado de garantias otorgadas'
	ELSE
		SELECT  0, 'OK'
	
	SET NOCOUNT OFF
END
GO
