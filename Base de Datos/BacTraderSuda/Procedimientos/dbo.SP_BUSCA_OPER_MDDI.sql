USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_OPER_MDDI]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_OPER_MDDI]
	(	@Num_Oper	NUMERIC(10)
	,	@User		CHAR(20)
	)
AS
BEGIN

	SET NOCOUNT ON

	CREATE TABLE #temp2 
		(	nerror				NUMERIC (02,0)  NULL,
			hwnd2				NUMERIC (09,0)  NULL,
			usuario2			CHAR    (20)	NULL,
			rutcart				NUMERIC(9,0)	NULL,
			tipcart				NUMERIC(1,0)	NULL,
			numdocu				NUMERIC(9,0)	NULL,
			correla				NUMERIC(3,0)	NULL,
			numdocuo			NUMERIC(9,0)	NULL,
			correlao			NUMERIC(3,0)	NULL,
			tipoper				CHAR    (03)	NULL,
			seserie				CHAR(12)		NULL,
			instser				CHAR(12)		NULL,
			genemi				CHAR(05)		NULL,
			nemmon				CHAR(05)		NULL,
			nominal				NUMERIC(19,4)	NULL,
			tircomp				NUMERIC(19,4)	NULL,
			pvpcomp				NUMERIC(19,4)	NULL,
			vptirc				NUMERIC(19,4)	NULL,
			pvpmcd				NUMERIC(19,4)	NULL,
			tirmcd				NUMERIC(19,4)	NULL,
			vpmcd100			NUMERIC(19,4)	NULL,
			vpmcd				NUMERIC(19,4)	NULL,
			vptirci				NUMERIC(19,4)	NULL,
			fecsal				CHAR(10)		NULL,
			numucup				NUMERIC( 5,0)	NULL,
			interesc			NUMERIC(19,4)	NULL,
			reajustc			NUMERIC(19,4)	NULL,
			intereci			NUMERIC(19,4)	NULL,
			reajusci			NUMERIC(19,4)	NULL,
			capitalc			NUMERIC(19,4)	NULL,
			capitaci			NUMERIC(19,4)	NULL,
			codigo				NUMERIC(03,0)	NULL,
			mascara				CHAR(12)		NULL,
			tasest				NUMERIC(19,4)	NULL,
			rutemi				NUMERIC( 9,0)	NULL,
			monemi				NUMERIC(03,0)	NULL,
			tasemi				NUMERIC(09,4)	NULL,
			basemi				NUMERIC(03,0)	NULL,
			fecemi				CHAR(10)		NULL,
			fecven				DATETIME		NULL,
			fecpcup				CHAR(10)		NULL,
			bloq				CHAR(1)			NULL,
			diasdisp			NUMERIC( 5,0)	NULL,
			custodia_dcv		CHAR(01)		NULL,
			seriados			CHAR(01)		NULL,
			convexidad			FLOAT			NULL,
			durationMAC			FLOAT			NULL,
			durationMOD			FLOAT			NULL,
			nombre_carterasuper CHAR(20)		NULL,
			id_libro			CHAR(06)		NULL,
			Modalidad_Pago		CHAR(1) 
		)

	SELECT	dirutcart			= dirutcart
	,		gSQLVar				= ditipcart --1
	,		gs_Cart				= 1
	,		diserie				= diserie
	,		digenemi			= digenemi
	,		dinemmon			= dinemmon
	,		diinstser			= diinstser
	,		codigo_carterasuper	= codigo_carterasuper
	,		Puntero				= Identity(INT)
	INTO	#CARTERA_INT
	FROM	MDDI 
	WHERE	dinumdocuo			= @Num_Oper
	AND		Estado_Operacion_Linea = ''

	DECLARE @iRegistros		NUMERIC(9)
	DECLARE @iRegistro		NUMERIC(9)
		SET @iRegistros		= ( SELECT MAX(Puntero) FROM #CARTERA_INT)
		SET @iRegistro		= 1

	DECLARE @rutcart1            NUMERIC(09,0)
	DECLARE @sqlvari1            NUMERIC(04,0)
	DECLARE @sqlfami1            VARCHAR(255)
	DECLARE @sqlemis1            VARCHAR(255)
	DECLARE @sqlmone1            VARCHAR(255)
	DECLARE @sqlseri1            CHAR(255)
	DECLARE @codigo_carterasuper CHAR(10)
	DECLARE @cUsuario            CHAR(10) 
	DECLARE @id_libro            CHAR(06)
	DECLARE @cModPago			 CHAR(01)
	DECLARE @iDPV                INT

	WHILE @iRegistros >= @iRegistro
	BEGIN

		SELECT	@rutcart1            = dirutcart
			,	@sqlvari1            = gSQLVar
			,	@sqlfami1            = ltrim(rtrim(diserie))   + '- '
			,	@sqlemis1            = ltrim(rtrim(digenemi))  + '- '
			,	@sqlmone1            = ltrim(rtrim(dinemmon))  + '- '
			,	@sqlseri1            = ltrim(rtrim(diinstser)) + ';'
			,	@codigo_carterasuper = codigo_carterasuper
			,	@cUsuario            = @User
		FROM	#CARTERA_INT 
		WHERE	Puntero				 = @iRegistro
		
		INSERT INTO #temp2
		EXECUTE SP_FILTRARCART_VP @rutcart1, @sqlvari1, @sqlfami1, @sqlemis1, @sqlmone1, @sqlseri1, @codigo_carterasuper, @cUsuario
		
		SET @iRegistro = @iRegistro + 1
	END

	DELETE #TEMP2 WHERE numdocu <> @Num_Oper

	SELECT * FROM #TEMP2

END
GO
