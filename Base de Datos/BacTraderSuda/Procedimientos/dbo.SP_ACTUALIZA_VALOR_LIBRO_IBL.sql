USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_VALOR_LIBRO_IBL]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_ACTUALIZA_VALOR_LIBRO_IBL] 
( 
		@TIPO_CARTERA NUMERIC (9)
	,	@VALOR_LIBRO FLOAT OUTPUT  
)
AS BEGIN

/* LD1-COR-035 FUSION CORPBANCA - ITAU --> VALIDACION ALCO**/
/***********************************************************************/

SET NOCOUNT ON

	DECLARE @FECHA_HOY DATETIME,
		@FECHA_MAN DATETIME,
		@VAL_MON_HOY FLOAT ,
		@VAL_MON_MAN FLOAT ,
		@VAL         FLOAT ,
		@DO_HOY	     FLOAT ,
		@PASO	     FLOAT

	SET 	@VAL = 0.0
	SET 	@FECHA_HOY = (SELECT acfecproc FROM MDAC)
	SET 	@FECHA_MAN = (SELECT acfecprox FROM MDAC)
	SET	@DO_HOY    = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA WHERE VMFECHA = @FECHA_HOY AND VMCODIGO =994 )

	SELECT  TSerie 	          = cainstser			,
		TValor_Contable   = cavpresen   		,
		Tcpfeccomp	  = cafeccomp 			,
		TFecha_PagoMañana = cafeccomp			,
		Tcpcodigo  	  = cacodigo 	 		,
		TTASA_CONTRATO	  = catircomp			,
		TMoneda_Emi 	  = (select inmonemi from VIEW_instrumento where incodigo = cacodigo),		
		TVALOR_MONEDA_HOY = ( ISNULL(( select vmvalor from VIEW_valor_moneda where vmfecha = @FECHA_HOY and vmcodigo = (select inmonemi from VIEW_instrumento where incodigo = cacodigo) ),1)) ,
		TVALOR_MONEDA_MAN = ( ISNULL(( select vmvalor from VIEW_valor_moneda where vmfecha = cafeccomp  and vmcodigo = (select inmonemi from VIEW_instrumento where incodigo = cacodigo) ),1)) ,
		TVALOR_MONEDA_COM = ( ISNULL(( select vmvalor from VIEW_valor_moneda where vmfecha = cafeccomp  and vmcodigo = (select inmonemi from VIEW_instrumento where incodigo = cacodigo) ),1)),
		TKUM        = @VAL ,
		TREAJUSTE   = @VAL ,
		TINTERES_UM = @VAL ,
		TINTERES_$$ = @VAL ,
		TVLOR_LIBRO = @VAL
	INTO #PASO
	FROM IBL_MDCA
	WHERE (CACARTERA = @TIPO_CARTERA OR CACARTERA = '114') AND CATIPOPER IN('CP','VI') AND CAINDPAC <> 'S'

SELECT @VALOR_LIBRO = ISNULL( SUM( TValor_Contable ) , 0 )  / @DO_HOY  FROM #PASO

SET NOCOUNT OFF

END

GO
