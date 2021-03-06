USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_GRABA_DETALLE_GARANTIAS_OTORGADAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_GRABA_DETALLE_GARANTIAS_OTORGADAS]
		(	@nNumfolio	NUMERIC(10)
		,	@nNumdocu	NUMERIC(10)
		,	@nCorrela	NUMERIC(5)
		,	@sInstser	VARCHAR(12)
		,	@nNominal	NUMERIC(21,4) 	
		,	@nTir		NUMERIC(9,4)
		,	@fVpar		NUMERIC(10,6)
		,	@fMT		NUMERIC(21,4)
		,	@FactorMulti	NUMERIC(18,0)
		)
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM bacparamsuda.dbo.tbl_garantias_otorgadas_Detalle 
		   WHERE Folio=@nNumFolio
		     AND NumDocu=@nNumdocu	
		     AND Correlativo=@nCorrela) 
	BEGIN
		UPDATE bacparamsuda.dbo.tbl_garantias_otorgadas_Detalle 
		   SET 	Nemotecnico 		= @sInstser
		,      	Nominal     		= @nNominal	
		,      	TIR 	   		= @nTir
		,      	VPAR	   		= @fVpar
  		,      	ValorPresente		= @fMT
		,	FactorMultiplicativo 	= @FactorMulti
  	   	 WHERE Folio=@nNumFolio
		   AND NumDocu=@nNumdocu	
		   AND Correlativo=@nCorrela
	END
	ELSE BEGIN

		INSERT INTO bacparamsuda.dbo.tbl_garantias_otorgadas_Detalle
		(	Folio
		,	Numdocu
		,	Correlativo
		,	Nemotecnico
		,	Nominal
		,	TIR
		,	VPAR
		,	ValorPresente
		,	TirMercado
		,	ValorMercado
		,	FactorMultiplicativo
		) VALUES 
		(	@nNumfolio
		,	@nNumdocu
		,	@nCorrela
		,	@sInstser
		,	@nNominal
		,	@nTir
		,	@fVpar
		,	@fMT
		,	@nTir
		,	@fMT
		,	@FactorMulti
		)
	END
	IF @@ERROR<>0 
		SELECT -1, 'Problemas al grabar informacion del encabezado de garantias otorgadas'
	ELSE
		SELECT  0, 'OK'
	
	SET NOCOUNT OFF
END
GO
