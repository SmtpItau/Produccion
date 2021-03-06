USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_INSTRUMENTO_FBT]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_CON_INSTRUMENTO_FBT]	( @NumeroOpeFbt	NUMERIC(10,0)	)
AS
BEGIN

	SET NOCOUNT ON 

	DECLARE	@Nemotecnico	CHAR(12)
	,	@Seriado	CHAR(1)
	,	@CodigoInst	INT
	,	@FecVctoInst	CHAR(10)

	SELECT	@Nemotecnico	= caserie
	,	@Seriado	= caseriado
	FROM	BACFWDSUDA..MFCA 
	WHERE	cacodpos1	= 10
	AND	canumoper	= @NumeroOpeFbt

	IF @Seriado = 'S' BEGIN
		SELECT	DISTINCT
			@CodigoInst	= secodigo
		,	@FecVctoInst	= CONVERT(CHAR,sefecven,103)
		FROM	BACPARAMSUDA..SERIE 
		WHERE	seserie	= @Nemotecnico
	END
	ELSE BEGIN
		SELECT	DISTINCT 
			@CodigoInst	= nscodigo
		,	@FecVctoInst	= CONVERT(CHAR,nsfecven,103)
		FROM	BACPARAMSUDA..NOSERIE 
		WHERE	nsserie	= @Nemotecnico
	END

	SELECT	'Nemotecnico'		= @Nemotecnico
	,	intipo
	,	inmonemi
	,	'TipoInstrumento'	= CASE @Seriado	WHEN 'S' THEN	'RENTA FIJA'
							WHEN 'N' THEN	'INTERMEDIACION FINANCIERA'
							ELSE intipo END	
	,	'MonReajustabiliad'	= CASE inmonemi	WHEN 999	THEN 'N/R'
							ELSE (SELECT mnglosa FROM BACPARAMSUDA..MONEDA WHERE mncodmon = inmonemi) END
	,	'FecVencimientoInst'	= @FecVctoInst
	,	'CodigoInstrumento'	= inserie
	FROM	BACPARAMSUDA..INSTRUMENTO
	WHERE	incodigo	= @CodigoInst

/*
	SELECT	* 
	FROM	BACPARAMSUDA..INSTRUMENTO



	SELECT * FROM BACPARAMSUDA..SERIE WHERE SUBSTRING(semascara,1,3) = 'BTU'
	SELECT * FROM BACPARAMSUDA..NOSERIE 

	SELECT * FROM BACPARAMSUDA..FAMILIA

	SELECT	*
	,	@Nemotecnico	= caserie
	,	@Seriado	= caseriado
	FROM	BACFWDSUDA..MFCA 
	WHERE	cacodpos1	= 10
	AND	canumoper	= @NumeroOpeFbt
	
	SP_HELP SERIE

	SELECT NAME FROM BACPARAMSUDA..SYSOBJECTS A,BACPARAMSUDA..SYSCOMMENTS B WHERE A.ID = B.ID AND B.TEXT LIKE '%intipo%'


*/
	SET NOCOUNT OFF
END
GO
