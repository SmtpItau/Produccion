USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Descuenta_Cupones_tcrc]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE  PROCEDURE [dbo].[Sp_Descuenta_Cupones_tcrc] (@xmonemi	NUMERIC(3),
													@xNomiTot	NUMERIC(19,4),
													@dFecMcdo	DATETIME,
													@cFecRep	DATETIME,
													@cMascara	CHAR(10),
													@xfecemi	DATETIME,
													@xcodigo	NUMERIC(5),
													@nMtoCortes	NUMERIC(19,4) OUTPUT)
AS


 BEGIN
	DECLARE	@nPervcup	INTEGER

	IF @xcodigo <> 20 
	 BEGIN
		SELECT @nMtoCortes = (CASE WHEN @xmonemi <> 13 THEN  ISNULL(ROUND( SUM(((tdinteres*@xNomiTot/100.0) + (tdamort*@xNomiTot/100.0)) * Tipo_Cambio), 0),0) ELSE  Isnull(ROUND(SUM((  (tdinteres*@xNomiTot/100.0) + (tdamort*@xNomiTot/100.0))), 2),0) END)
		FROM  view_tabla_desarrollo, BacParamSuda..VALOR_MONEDA_CONTABLE
		WHERE 	tdmascara = @cMascara and
			tdfecven between @dFecMcdo and @cFecRep	and
			Codigo_Moneda = @xmonemi and Fecha = tdfecven
		GROUP BY tdmascara

	 END
	 ELSE 
	  BEGIN
		SET ROWCOUNT 1
		SELECT 	@nPervcup = sepervcup
		FROM VIEW_SERIE
		WHERE semascara=SUBSTRING(@cMascara,1,6)
		SET ROWCOUNT 0
				
		SELECT 	'tdmascara' = tdmascara     ,
				'tdcupon'   = tdcupon       ,
				'tdfecven'  = DATEADD(MONTH,(tdcupon * @nPervcup),@xfecemi),
				'tdinteres' = tdinteres     ,
				'tdamort'   = tdamort       ,
				'tdflujo'   = tdflujo       ,
				'tdsaldo'   = tdsaldo
		INTO #Temp
		FROM VIEW_TABLA_DESARROLLO
		WHERE tdmascara=SUBSTRING(@cMascara,1,6)

		SELECT @nMtoCortes = (CASE WHEN @xmonemi<> 13 THEN  ISNULL(ROUND(SUM(( (tdinteres * @xNomiTot/100.0) + (tdamort*@xNomiTot/100.0)) * Tipo_Cambio), 0),0) ELSE  ISNULL(ROUND(SUM(((tdinteres*@xNomiTot/100.0) + (tdamort*@xNomiTot/100.0))), 2),0) END)
		FROM #Temp, BacParamSuda..VALOR_MONEDA_CONTABLE
		WHERE 	tdmascara = @cMascara and
			tdfecven between @dFecMcdo and @cFecRep	and
			Codigo_Moneda = @xmonemi and
			Fecha = tdfecven
		GROUP BY tdmascara
	END
END-- Base de Datos --
GO
