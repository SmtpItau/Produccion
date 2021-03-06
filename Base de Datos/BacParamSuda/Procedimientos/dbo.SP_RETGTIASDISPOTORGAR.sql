USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETGTIASDISPOTORGAR]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RETGTIASDISPOTORGAR]
   (   @gsbac_user   VARCHAR(15)
   ,   @Financiera   VARCHAR(255) = ''
   ,   @Normativa    VARCHAR(255) = ''
   )
AS 
BEGIN
	SET NOCOUNT ON

	SELECT 
	       Usuario            = @gsbac_user
	,      Marca              = ISNULL(bl.blusuario,'N')
	,      Documento          = cp.cpnumdocu
	,      Correlativo        = cp.cpcorrela
	,      Serie              = cp.cpinstser
	,      Moneda             = mn.mnnemo
	,      Nominal_Compra     = cp.cpnominal
	,      TIR	          = cp.cptircomp
	,      VPAR	          = cp.cpvpcomp
	,      Valor_Presente     = cp.cpvptirc

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
  	 WHERE cp.cpnominal > 0
   	   AND cp.cpdcv     = 'D'
	   AND cp.Estado_Operacion_Linea = ''
	   AND ISNULL(bl.blusuario,'')   = ''
   	   AND (CHARINDEX(LTRIM(RTRIM(cp.cptipcart)), @Normativa) > 0 OR @Financiera = ''  )
	   AND (CHARINDEX(LTRIM(RTRIM(cp.codigo_carterasuper)), @Financiera)  > 0 or @Normativa  = '')
         ORDER 
	    BY cp.cpnumdocu, cp.cpcorrela

	/*
	*	Descontar nominales garantias otorgadas
	*/
	UPDATE #TempDisponible
	   SET Nominal_Compra = Nominal_Compra - Nominal
	,      Valor_Presente = Valor_Presente - ValorMercado
 	  FROM #TempDisponible td
	 INNER 
   	  JOIN tbl_garantias_otorgadas_detalle  god
	    ON god.numdocu     = td.documento 
	   AND god.correlativo = td.correlativo

	/*
	*	Descontar Nominales Vtas cortas
	*/
	
	--- Verificar si existe la tabla de Venta Corta

	if exists (select * from sysobjects where id = object_id(N'[BacTradersuda].[dbo].[tbl_vc_arrendadas_detalle]') 
	and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		UPDATE #TempDisponible
		SET Nominal_Compra = Nominal_Compra - Nominal
		,      Valor_Presente = Valor_Presente - ValorPresente
 		FROM #TempDisponible td
		INNER JOIN BacTraderSuda..tbl_vc_arrendadas_detalle  god
		ON god.numdocu     = td.documento 
		AND god.correlativo = td.correlativo
	END
	
	DELETE #TempDisponible 
	 WHERE Nominal_Compra <= 0

	SELECT	Serie
	,	Moneda
	,	Nominal_Compra
	,	TIR
	,	VPAR
	,	Valor_Presente
	,	ROUND(Valor_Presente, 0) AS 'Valor_Presente_Act'
	,	Documento
	,	Correlativo
	FROM #TempDisponible
	ORDER BY Documento, Correlativo
END
GO
