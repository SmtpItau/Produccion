USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_ACTUALIZA_VALOR_LIBRO]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_ACTUALIZA_VALOR_LIBRO]
(		@TIPO_CARTERA NUMERIC (1) 
	,	@VALOR_LIBRO FLOAT OUTPUT  
)
AS 

BEGIN

SET NOCOUNT ON

	DECLARE @FECHA_HOY DATETIME,
		@FECHA_MAN DATETIME,
		@VAL_MON_HOY FLOAT ,
		@VAL_MON_MAN FLOAT ,
		@VAL         FLOAT ,
		@DO_HOY	     FLOAT

	SET 	@VAL = 0.0
	SET 	@FECHA_HOY = (SELECT acfecproc FROM view_MDAC)
	SET 	@FECHA_MAN = (SELECT acfecprox FROM view_MDAC)
	SET	@DO_HOY    = (SELECT VMVALOR FROM VALOR_MONEDA WHERE VMFECHA = @FECHA_HOY AND VMCODIGO =994 )

	SELECT  TSerie 	          = cpinstser			,
		TValor_Contable   = (CASE WHEN @TIPO_CARTERA = 2 THEN (CASE WHEN cpcodigo Not in(9,11,14) THEN (cpvptirc + isnull((select Sum(vivptirc) From View_Mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela) ,0)) ELSE 0 END)
                                         ELSE (CASE WHEN cpfeccomp = @FECHA_HOY THEN (cpvptirc + isnull((select Sum(vivptirc) From View_Mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela) ,0))
                                                    ELSE (cpvcum100 + isnull((select Sum(vivvum100) From View_Mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela) ,0)) END) 
				    END),  --Valor_Contable,
		Tcpfeccomp	  = cpfeccomp 			,
		TFecha_PagoMañana = Fecha_PagoMañana		,
		Tcpcodigo  	  = cpcodigo 	 		,
		TTASA_CONTRATO	  = Tasa_Contrato		,
		TMoneda_Emi 	  = (select inmonemi from instrumento where incodigo = cpcodigo),		
		TVALOR_MONEDA_HOY = ( ISNULL(( select vmvalor from valor_moneda where vmfecha = @FECHA_HOY and vmcodigo = (select inmonemi from instrumento where incodigo = cpcodigo) ),1)) ,
		TVALOR_MONEDA_MAN = ( ISNULL(( select vmvalor from valor_moneda where vmfecha = Fecha_PagoMañana and vmcodigo = (select inmonemi from instrumento where incodigo = cpcodigo) ),1)) ,
		TVALOR_MONEDA_COM = ( ISNULL(( select vmvalor from valor_moneda where vmfecha = cpfeccomp  and vmcodigo = (select inmonemi from instrumento where incodigo = cpcodigo) ),1)),
		TKUM        = @VAL ,
		TREAJUSTE   = @VAL ,
		TINTERES_UM = @VAL ,
		TINTERES_$$ = @VAL ,
		TVLOR_LIBRO = @VAL 
	INTO #PASO
	FROM BacTraderSuda..VIEW_MDCP
	WHERE cptipcart = @TIPO_CARTERA and (Exists(Select * from View_mdvi where vinumdocu = cpnumdocu and vicorrela = cpcorrela) or cpnominal > 0)
	      


SELECT @VALOR_LIBRO = Isnull(SUM(TValor_Contable ) / @DO_HOY,0)   FROM #PASO  WHERE TMoneda_Emi <> 13  
SELECT @VALOR_LIBRO = @VALOR_LIBRO + Isnull(SUM(TValor_Contable),0)  FROM #PASO  WHERE TMoneda_Emi = 13 


SET NOCOUNT OFF

END



GO
