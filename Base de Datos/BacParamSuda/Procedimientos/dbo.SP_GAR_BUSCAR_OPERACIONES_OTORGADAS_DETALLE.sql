USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_BUSCAR_OPERACIONES_OTORGADAS_DETALLE]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_BUSCAR_OPERACIONES_OTORGADAS_DETALLE]
		(	@nFolio		NUMERIC(10)
		)	
AS
BEGIN
	SET NOCOUNT ON
	SELECT 	Numdocu
	,      	Correlativo
	,      	Nemotecnico
	,      	Nominal
	,      	TirMercado
	,      	VPAR
	,      	ValorMercado
	,	FactorMultiplicativo
	,	(ValorMercado * FactorMultiplicativo)
	  FROM bacparamsuda.dbo.tbl_Garantias_Otorgadas_detalle  det
	 WHERE det.folio =  @nFolio
	SET NOCOUNT OFF
END
GO
