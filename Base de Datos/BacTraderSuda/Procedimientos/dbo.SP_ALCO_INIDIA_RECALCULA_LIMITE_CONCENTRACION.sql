USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ALCO_INIDIA_RECALCULA_LIMITE_CONCENTRACION]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_ALCO_INIDIA_RECALCULA_LIMITE_CONCENTRACION]
AS BEGIN

SET NOCOUNT ON

/* LD1-COR-035 FUSION CORPBANCA - ITAU --> VALIDACION ALCO**/
/***********************************************************************/

	/*******************
		IBL_MDCA Y BISA_MDCA TABLAS TEMPORALES PARA EL CALCULO DE LA CARTERA DE PC-TRADER
	*******************/	

	DECLARE @FECHA_PROC DATETIME,
		@DO	    FLOAT

	SET @FECHA_PROC = (SELECT ACFECPROC FROM MDAC)
	SET @DO        	= ( SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE VMCODIGO = 994 AND VMFECHA = @FECHA_PROC )

	CREATE TABLE #CP_PASO
		( TAG CHAR (4) , CODIGO NUMERIC(9) , NOMINAL FLOAT , MONEMIS NUMERIC(9) , VALOR_MON_HOY FLOAT , TIPOCART CHAR(03),RutEmi Numeric(09))

	

	INSERT INTO #CP_PASO
	SELECT 	'BKB'		,
		CPCODIGO	,
		CPNOMINAL + Isnull( (Select Sum(Vinominal) FROM Mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela),0)	,
		(SELECT INMONEMI FROM VIEW_INSTRUMENTO WHERE INCODIGO = CPCODIGO),
		ISNULL ( (ISNULL((SELECT VMVALOR FROM VIEW_VALOR_MONEDA WHERE VMCODIGO = (SELECT INMONEMI FROM VIEW_INSTRUMENTO WHERE INCODIGO = CPCODIGO) AND VMFECHA= @FECHA_PROC),1) *  CPNOMINAL ) / @DO ,0), -- CBG 09/09/2004 USX
		CASE WHEN CPTIPCART = 2 THEN 'AFS'
		     WHEN CPTIPCART = 1 THEN 'TRD'
		ELSE '' END,
		'RutEmi' = (Select top 1 emrut from view_emisor Where emgeneric = digenemi)
	FROM MDCP,MDDI
	WHERE cpnumdocu = dinumdocu and cpcorrela = dicorrela AND (cpnominal>0 or EXISTS(Select * from mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela)) -- CBG 09/09/2004

	UPDATE view_LIMITE_CONCENTRACION
	SET 	Outstanding		= ISNULL((SELECT SUM(NOMINAL) FROM #CP_PASO WHERE CODIGO = INCODIGO AND RutEmi = Rut_Emisor AND TAG = 'BKB' AND TIPOCART = 'AFS'),0) 	--,

	UPDATE view_LIMITE_CONCENTRACION
	SET 	Outstandig_Total	= ISNULL((Outstanding+Outstanding_Filial),0),
		Monto_Limite		= ( Monto_Emision * Porc_Limite) / 100

	UPDATE view_LIMITE_CONCENTRACION
	SET	Disponible		= (Monto_Limite - Outstandig_Total)


DROP TABLE #CP_PASO

SELECT * FROM view_LIMITE_CONCENTRACION

SET NOCOUNT OFF

END

GO
