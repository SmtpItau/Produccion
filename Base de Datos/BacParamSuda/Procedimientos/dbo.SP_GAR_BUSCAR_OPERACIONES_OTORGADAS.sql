USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_BUSCAR_OPERACIONES_OTORGADAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_BUSCAR_OPERACIONES_OTORGADAS]
		(	@nRutCliente 	NUMERIC(10)
		,	@iCodigo	NUMERIC(5)
		)	
AS
BEGIN
	SET NOCOUNT ON
	SELECT 	Fecha
	,      	Folio
	,      	(SELECT tbglosa FROM Bacparamsuda..TABLA_GENERAL_DETALLE WHERE tbcateg = 8700 AND tbcodigo1 = enc.TipoGarantia) AS TipoGarantia
	,      	TotDet.ValorPresente 
	,      	TotDet.ValorMercado
	,	FactorAditivo
	FROM bacparamsuda.dbo.tbl_Garantias_Otorgadas  enc
  	INNER JOIN (SELECT enc.Folio as FolEnc
		,      SUM(ValorPresente) AS ValorPresente
		,      SUM(ValorMercado)  AS ValorMercado
		FROM bacparamsuda.dbo.tbl_Garantias_Otorgadas  enc
		INNER JOIN bacparamsuda.dbo.tbl_Garantias_Otorgadas_Detalle det
			ON enc.folio = det.folio
		WHERE RutCliente = @nRutCliente
		AND CodCliente = @iCodigo  
		GROUP BY enc.Folio) TotDet
	ON  TotDet.FolEnc = enc.Folio
	WHERE RutCliente = @nRutCliente
  	AND CodCliente = @iCodigo

	SET NOCOUNT OFF
END
GO
