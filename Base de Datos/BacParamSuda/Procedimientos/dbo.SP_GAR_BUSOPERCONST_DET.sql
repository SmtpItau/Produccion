USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_BUSOPERCONST_DET]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_BUSOPERCONST_DET]
	(	
		@Folio		NUMERIC(10)
	)	
AS
BEGIN
	SET NOCOUNT ON
	SELECT  NumeroOperacion
	,       Correlativo
	,       Instrumento
	,       Nominal
	,       Tir
	,       VPAR
	,       ValorPresente
	,	FactorMultiplicativo
	,	(ValorPresente * FactorMultiplicativo)
	FROM bacparamsuda.dbo.tbl_mov_garantia_detalle det
	WHERE det.NumeroOperacion =  @Folio
	SET NOCOUNT OFF
END
GO
