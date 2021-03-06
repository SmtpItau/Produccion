USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_CARTERAELEGIBLES]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORME_CARTERAELEGIBLES]
AS
BEGIN

	SET NOCOUNT ON

CREATE TABLE #temp(
		codigo		NUMERIC(05)	,
		familia		CHAR(50)	,
		nemo		CHAR(12)	,
		nominal		NUMERIC(19,4)	,
		vpresen		NUMERIC(19)	,
		fecven		DATETIME	,
		rutemi		NUMERIC(09)	,
		emisor		CHAR(06)	,
		monemi		NUMERIC(03)	,
		moneda		CHAR(05)	)
		



	INSERT INTO #temp
	SELECt	cpcodigo,
		'',
		cpinstser,
		SUM(cpnominal),
		SUM(cpvptirc),
		cpfecpcup,
		nsrutemi,
		'',
		nsmonemi,
		''
	from	mdcp,
		mdac,
		VIEW_noserie
	WHERE	cpcodigo in (4,6,7,31,300,301,32,33,34)
	AND	cpnominal > 0
	AND	cpfecpcup < DATEADD(day,91,acfecproc)
	AND	cpseriado = 'N'
	AND	nsrutcart = cprutcart
	AND	nsnumdocu = cpnumdocu
	AND	nscorrela = cpcorrela
	GROUP BY
		cpcodigo,
		cpinstser,
		cpfecpcup,
		nsrutemi,
		nsmonemi


	INSERT INTO #temp
	SELECt	cpcodigo,
		'',
		cpinstser,
		SUM(cpnominal),
--		SUM(cpvptirc * ( 1 - ( tdflujo / cpnominal )  )),
		SUM(( cpnominal / 100 * tdflujo) * vmvalor) ,
		cpfecpcup,
		serutemi,
		'',
		semonemi,
		''
	from	mdcp,
		mdac,
		VIEW_serie,
		VIEW_tabla_desarrollo,
		view_valor_moneda
	WHERE	cpcodigo in (4,6,7,31,300,301,32,33,34)
	AND	cpnominal > 0
	AND	cpfecpcup < DATEADD(day,91,acfecproc)
	AND	cpseriado = 'S'
	AND	semascara = cpmascara
	AND	tdmascara = cpmascara
	and 	tdfecven  = cpfecpcup
	AND	vmcodigo  = semonemi
	AND	vmfecha   = acfecproc
	GROUP BY
		cpcodigo,
		cpinstser,
		cpfecpcup,
		serutemi,
		semonemi


	UPDATE	#temp
	SET	familia = inglosa
	FROM 	view_instrumento
	WHERE	incodigo = codigo


	UPDATE	#temp
	SET	emisor = emgeneric
	FROM 	view_emisor
	WHERE	emrut = rutemi

	UPDATE	#temp
	SET	moneda = mnnemo
	FROM 	view_moneda
	WHERE	mncodmon = monemi




	SELECT 	codigo		,
		familia		,
		nemo		,
		nominal		,
		vpresen		,
		'fecven'=CONVERT(CHAR(10),fecven,103),
		emisor		,
		moneda		,
		acnomprop	,
		acnom_resoma	,
		acfon_resoma	,
		'hora'=CONVERT(CHAR(10),GETDATE(),108),
		'fecha'=CONVERT(CHAR(10),acfecproc,103)
	FROM	#temp,
		mdac
	ORDER BY
		codigo,
		nemo


	SET NOCOUNT OFF

END

--select * from view_instrumento
-- sp_helptext Sp_Base_Del_Informe
-- select * from mdcp



GO
