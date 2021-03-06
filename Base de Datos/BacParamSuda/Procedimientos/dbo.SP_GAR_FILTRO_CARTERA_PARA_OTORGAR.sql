USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_FILTRO_CARTERA_PARA_OTORGAR]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_FILTRO_CARTERA_PARA_OTORGAR]
   (   @gsbac_user   VARCHAR(15)
   ,   @Normativa    VARCHAR(255) = ''
   ,   @Financiera   VARCHAR(255) = ''
   ,   @hWnd         NUMERIC(9)
   )
AS 
BEGIN
	SET NOCOUNT ON
	DECLARE @acfecante   		DATETIME
	,	@acfecproc   		DATETIME

	SELECT 
	       	Usuario             = @gsbac_user
	,      	Marca               = ISNULL(bl.blusuario,'N') --> CASE WHEN ISNULL(blusuario,'') = '' THEN 'N' ELSE 'S' END
	,      	Documento           = cp.cpnumdocu
	,      	Correlativo         = cp.cpcorrela
	,      	Serie               = cp.cpinstser
	,      	Moneda              = mn.mnnemo
	,      	Nominal_Compra      = cp.cpnominal
	,      	Tasa_Compra         = cp.cptircomp
	,      	Valor_Par           = cp.cpvpcomp
	,      	Valor_Presente      = cp.cpvptirc
	,      	Nominal_Venta       = 0.0
	,      	Tasa_Venta          = 0.0
	,      	vPar_Venta          = 0.0
	,      	vPresente_Venta     = 0.0
	,	FactorMultiplicativo= 1.0
	,      	Ventana             = @hWnd
	,	acumNominal	    = ISNULL(tDet.sNominal, 0)
	,	acumMercado	    = ISNULL(tDet.sValorMercado, 0)
	,	FecVcto		    = cp.cpfecven
	  INTO #TempDisponible
   	  FROM bactradersuda.dbo.MDCP cp with(nolock)
         INNER JOIN bactradersuda.dbo.MDDI di WITH(NOLOCK) 
	         ON di.dinumdocu = cp.cpnumdocu 
	        AND di.dicorrela = cp.cpcorrela 
         INNER JOIN BacParamSuda.dbo.INSTRUMENTO fi WITH(NOLOCK) 
	         ON fi.incodigo = cp.cpcodigo
          LEFT JOIN BacParamSuda.dbo.MONEDA mn WITH(NOLOCK) 
	         ON mn.mnnemo = di.dinemmon
          LEFT JOIN bactradersuda.dbo.MDBL bl WITH(NOLOCK) 
	         ON bl.blrutcart = cp.cprutcart 
	        AND bl.blnumdocu = cp.cpnumdocu 
                AND bl.blcorrela = cp.cpcorrela
	LEFT JOIN (SELECT det1.Numdocu, 
		det1.Correlativo, 
		SUM(det1.Nominal) AS sNominal,
		SUM(det1.ValorMercado) AS sValorMercado
		FROM BacParamSuda.dbo.tbl_garantias_otorgadas_detalle det1
		GROUP BY det1.NumDocu, det1.Correlativo ) tDet
		ON tDet.Numdocu = cp.cpnumdocu
		AND tDet.Correlativo = cp.cpcorrela
  	 WHERE cp.cpnominal > 0
   	   AND cp.cpdcv     = 'D'
	   AND cp.Estado_Operacion_Linea = ''
	   AND ISNULL(bl.blusuario,'')   = ''
   	   AND (CHARINDEX( LTRIM(RTRIM(cp.cptipcart))          , @Financiera) > 0 or @Financiera = '')
	   AND (CHARINDEX( LTRIM(RTRIM(cp.codigo_carterasuper)), @Normativa)  > 0 or @Normativa  = '')
         ORDER 
	    BY cp.cpnumdocu, cp.cpcorrela


	UPDATE 	#TempDisponible
	   SET 	Nominal_Compra = Nominal_Compra - acumNominal		---Nominal
	,      	Valor_Presente = Valor_Presente - acumMercado		---ValorMercado
 	FROM 	#TempDisponible td,
		tbl_garantias_otorgadas_detalle god
	WHERE	god.numdocu = td.documento
	AND	god.correlativo = td.correlativo


	DELETE #TempDisponible 
	 WHERE Nominal_Compra <= 0

	SELECT Serie
	,      Moneda
	,      Nominal_Compra
	,      Tasa_Compra
	,      Valor_Par
	,      Valor_Presente
	,      FactorMultiplicativo
	,      ROUND(Valor_Presente * FactorMultiplicativo, 0)
	,      Nominal_Compra
	,      Tasa_Compra
	,      Valor_Par
	,      Valor_Presente
	,      Documento
	,      Correlativo
	,      Fecvcto

	FROM #TempDisponible
	ORDER BY Serie ASC

END
GO
