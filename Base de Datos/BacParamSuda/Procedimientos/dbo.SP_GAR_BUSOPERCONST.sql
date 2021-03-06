USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_BUSOPERCONST]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_BUSOPERCONST]
		(	@RutCliente 	NUMERIC(10)
		,	@CodCliente	NUMERIC(5)
		)	
AS
BEGIN
	SET NOCOUNT ON

	SELECT 	Fecha
	,      	NumeroOperacion
	,	enc.FactorAditivo AS 'Factor Aditivo'
	,	tgd.tbglosa
	,      	TotDet.ValorPresente
	,	TotalMovimiento
	FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE tgd,
	bacparamsuda.dbo.tbl_mov_garantia enc
  	INNER 
	  JOIN (SELECT enc.NumeroOperacion as FolEnc
		,      SUM(ValorPresente) AS ValorPresente
		  FROM bacparamsuda.dbo.tbl_mov_garantia enc
		 INNER 
		  JOIN bacparamsuda.dbo.tbl_mov_garantia_detalle det
		    ON enc.NumeroOperacion = det.NumeroOperacion
		 WHERE RutCliente = @RutCliente
		   AND CodCliente = @CodCliente  
		 GROUP 
		    BY enc.NumeroOperacion) TotDet
	    ON  TotDet.FolEnc = enc.NumeroOperacion
	WHERE RutCliente = @RutCliente
	AND CodCliente = @CodCliente
	AND tgd.tbcateg = 8700
	AND tgd.nemo = 'C'
	AND TipoGarantia = tgd.tbcodigo1
	SET NOCOUNT OFF
END
GO
