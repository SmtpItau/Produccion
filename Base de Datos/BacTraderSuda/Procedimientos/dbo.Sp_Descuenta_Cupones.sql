USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Descuenta_Cupones]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[Sp_Descuenta_Cupones] (	@xmonemi	NUMERIC(3),
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

If @xcodigo <> 20 BEGIN
	Select @nMtoCortes = (case when @xmonemi <> 13 then  Isnull(ROUND( SUM(((tdinteres*@xNomiTot/100.0) + (tdamort*@xNomiTot/100.0)) * vmvalor), 0),0) else  Isnull(ROUND(SUM((  (tdinteres*@xNomiTot/100.0) + (tdamort*@xNomiTot/100.0))), 2),0) end)
	from view_tabla_desarrollo, view_valor_moneda
	where 	tdmascara = @cMascara and
		tdfecven between @dFecMcdo and @cFecRep	and
		vmcodigo = @xmonemi and vmfecha = tdfecven
	Group By tdmascara

End Else Begin
	SET ROWCOUNT 1
	SELECT 	@nPervcup = sepervcup
	FROM VIEW_SERIE
	WHERE semascara=SUBSTRING(@cMascara,1,6)
	SET ROWCOUNT 0
				
	SELECT 	'tdmascara' = tdmascara     ,
		'tdcupon'   = tdcupon       ,
		'tdfecven'  =DATEADD(MONTH,(tdcupon * @nPervcup),@xfecemi),
		'tdinteres' = tdinteres     ,
		'tdamort'   = tdamort       ,
		'tdflujo'   = tdflujo       ,
		'tdsaldo'   = tdsaldo
	INTO #Temp
	FROM VIEW_TABLA_DESARROLLO
	WHERE tdmascara=SUBSTRING(@cMascara,1,6)

	Select @nMtoCortes = (case when @xmonemi<> 13 then  Isnull(ROUND(sum(( (tdinteres*@xNomiTot/100.0) + (tdamort*@xNomiTot/100.0)) * vmvalor), 0),0) else  Isnull(ROUND(sum(((tdinteres*@xNomiTot/100.0) + (tdamort*@xNomiTot/100.0))), 2),0) end)
	from #Temp, view_valor_moneda
	where 	tdmascara = @cMascara and
		tdfecven between @dFecMcdo and @cFecRep	and
		vmcodigo = @xmonemi and
		vmfecha = tdfecven
	Group By tdmascara
End
END
-- Base de Datos --
GO
