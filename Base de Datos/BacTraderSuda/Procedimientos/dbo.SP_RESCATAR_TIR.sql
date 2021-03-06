USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESCATAR_TIR]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RESCATAR_TIR]
AS
BEGIN
	SET NOCOUNT ON
	DECLARE	@cProg		CHAR	(10)	,
		@iModcal	INTEGER		,
		@iCodigo	INTEGER		,
		@cInstser	CHAR	(10)	,
		@iMonemi	INTEGER		,
		@dFecemi	DATETIME	,
		@dFecven	DATETIME	,
		@fTasemi	FLOAT		,
		@fBasemi	FLOAT		,
		@fTasest	FLOAT		,
		@fNominal	FLOAT		,
		@fTir		FLOAT		,
		@fPvp		FLOAT		,
		@fMT		FLOAT		,
		@fMTUM		FLOAT		,
		@fMT_cien	FLOAT		,
		@fVan		FLOAT		,
		@fVpar		FLOAT		,
		@nNumucup	INTEGER		,
		@dFecucup	DATETIME	,
		@fIntucup	FLOAT		,
		@fAmoucup	FLOAT		,
		@fSalucup	FLOAT		,
		@nNumpcup	INTEGER		,
		@dFecpcup	DATETIME	,
		@fIntpcup	FLOAT		,
		@fAmopcup	FLOAT		,
		@fSalpcup	FLOAT		,
		@fDurat		FLOAT		,
		@fConvx		FLOAT		,
		@fDurmo		FLOAT		,
		@nError		INTEGER 
  
	DECLARE	@fValmon_Hoy	NUMERIC	(19,4)	,
		@fValmon_Man	NUMERIC	(19,4)	,
		@fValmon_Com	NUMERIC	(19,4)	,
		@nNumdocu	NUMERIC	(10,0)	,
		@nNumoper	NUMERIC	(10,0)	,
		@nCorrela	NUMERIC	(03,0)	,
		@nValcomp	NUMERIC	(19,0)	,
		@fValcomu	FLOAT		,
		@dFeccomp	DATETIME	,
		@dFechoy	DATETIME	,
		@dFecprox	DATETIME	,
		@dFecante	DATETIME	,
		@dFecinip	DATETIME	,
		@dFecvtop	DATETIME	,
		@nVpresen	NUMERIC	(19,0)	,
		@nValpacto	NUMERIC	(19,0)	,
		@cMascara	CHAR	(10)	,
		@cSeriado	CHAR	(01)	,
		@nInteres	NUMERIC	(19,0)	,
		@nReajuste	NUMERIC	(19,0)	,
		@nIntpacto	NUMERIC	(19,0)	,
		@nReapacto	NUMERIC	(19,0)	,
		@fTe_pcdus	FLOAT		,
		@fTe_pcduf	FLOAT		,
		@fTe_ptf	FLOAT		,
		@nValinip	NUMERIC	(19,4)	,
		@nBaspacto	INTEGER		,
		@nTaspacto	NUMERIC	(08,4)	,
		@nMonpacto	INTEGER		,
		@iBusca		INTEGER		,
		@iMesman	INTEGER		,
		@cFecman	CHAR	(10)	,
		@fIpcemi	FLOAT		,
		@fIpccal	FLOAT		,
		@dFecman	DATETIME	,
		@iMescp		INTEGER		,
		@cFeccp		CHAR	(10)	,
		@dFeccp		DATETIME	,
		@iExtrae	INTEGER		,
		@cFecemi	CHAR	(10)	,
		@cMesemi	CHAR	(02)	,
		@iAnoemi	INTEGER		,
		@iMesemi	INTEGER		,
		@nIntdia	NUMERIC	(19,0)	,
		@nReadia	NUMERIC	(19,0)	,
		@nValvtop	NUMERIC	(19,4)	,
 		@nInterpacto	NUMERIC	(19,0)	,
		@nReajpacto	NUMERIC	(19,0)	,
		@fIntmes	FLOAT		,
		@fReames	FLOAT		,
		@iX		INTEGER		,
		@nContador	INTEGER		,
		@nVpresvpar	NUMERIC	(19,0)	,
		@nPrimDescto	NUMERIC	(19,0)	,
		@nVpMercado	NUMERIC	(19,0)	,
		@fTasMercado	FLOAT		


	SELECT	@iX		= 1		,
		@dFechoy	= acfecproc	,
		@dFecprox	= acfecprox	,
		@dFecante	= acfecante
	FROM	MDAC

--	SELECT @iMesman	= DATEPART(DAY,@dFechoy)*-1
--	SELECT @cFecman = CONVERT(CHAR(08),DATEADD(DAY,@iMesman,@dFechoy),112)
--	SELECT @dFecman = CONVERT(DATETIME,SUBSTRING(@cFecman,1,4)+SUBSTRING(@cFecman,5,2)+'01')
--	SELECT @fIpccal = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dFecman

	--*******************************--
	--** Cartera Propia Disponible **--
	--*******************************--

	SELECT	@nContador = COUNT(*) FROM MDCP where  cpnominal>0 and (SUBSTRING(cpinstser,1,3)='COR' OR SUBSTRING(cpinstser,1,3)='BCO') AND cpcodigo = 20 AND cpfeccomp > '20021031'

	WHILE @iX<=@nContador
	BEGIN
  

		SET ROWCOUNT @iX
		SELECT	@fTir		= motir		,
			@nValcomp	= movalcomp	,
			@nNumdocu       = monumoper     ,
			@nCorrela	= mocorrela	,
			@cMascara       = moinstser
		FROM	MDCP,MDMH
		WHERE	cpnominal>0 AND  motipoper='CP' and 
			mocodigo=20 and morutemi=97023000 and 
			mofecpro>'20021031' and monumdocu = cpnumdocu and cpcorrela = mocorrela

			
		SET ROWCOUNT 0
  
		SELECT @iX = @iX + 1

		
		IF @cInstser='*'
			BREAK

			SELECT @fTir,
			@nValcomp	,
			@nNumdocu       ,
			@nCorrela	,
			@cMascara       

		UPDATE MDCP SET 
			tir_compra_original = @fTir,
			valor_compra_original =	@nValcomp
		where 
		cpnumdocu=@nNumdocu AND cpcorrela=@nCorrela

	END
	
	SET NOCOUNT OFF
END

--truncate table mdmh
--truncate table mdcp
--truncate table mddi
--delete mdac
--truncate table tabla_desarrollo
--truncate table serie
--truncate table noserie
--truncate table valor_moneda
--select * from mdcp
--select * from mdmh
--select * from mddi
--select * from serie



GO
