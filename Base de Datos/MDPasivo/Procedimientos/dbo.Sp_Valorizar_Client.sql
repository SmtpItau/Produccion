USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Valorizar_Client]    Script Date: 16-05-2022 11:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Valorizar_Client]
			(	@modcal		integer		,
				@cfeccal	char	(10)	,
				@ncodigo	integer		,
				@cmascara	char	(12)	,
				@nmonemi	integer		,
				@cfecemi	char	(10)	,
				@cfecven	char	(10)	,
				@ftasemi	float		,
				@fbasemi	float		,
				@ftasest	float		,
				@fnominal	float		,
				@ftir		float		,
				@fpvp		float		,
				@fmt		float		)
AS
BEGIN
        SET NOCOUNT ON
        SET DATEFORMAT dmy

	DECLARE	@fmtum		float		,
		@fmt_cien	float		,
		@fvan		float		,
		@fvpar		float		,
		@nnumucup	integer		,
		@dfecucup	datetime	,
		@fintucup	float		,
		@famoucup	float		,
		@fsalucup	float		,
		@nnumpcup	integer		,
		@dfecpcup	datetime	,
		@fintpcup	float		,
		@famopcup	float		,
		@fsalpcup	float		,
		@nerror		integer		,
		@cprog		varchar	(20)	,
		@dfeccal	datetime	,
		@dfecemi	datetime	,
		@dfecven	datetime	,
		@fdurat		float		,
		@fconvx		float		,
		@fdurmo		float
	SELECT	@dfeccal	= CONVERT(DATETIME,@cfeccal,101)	,
		@dfecemi	= CONVERT(DATETIME,@cfecemi,101)	,
		@dfecven	= CONVERT(DATETIME,@cfecven,101)
	SELECT	@cprog	= 'SP_'+RTRIM(inprog) FROM INSTRUMENTO WHERE incodigo=@ncodigo

	/*------------------------------------------------------------------------------*
	*										*
	* Llamada generica a valorizadores de instrumentos , por generalidad		*
	* se definen todos los parametros necesarios para valorizar cualquier		*
	* instrumento, sin importar si una rutina en particular los utiliza		*
	* o no.-									*
	*										*
	*-------------------------------------------------------------------------------*/
	IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='P' AND NAME=@cProg)
	BEGIN
		EXECUTE	@nerror	= 	@cprog
					@modcal			,
					@dfeccal		,
					@ncodigo		,
					@cmascara		,
					@nmonemi		,
					@dfecemi		,
					@dfecven		,
					@ftasemi		,
					@fbasemi		,
					@ftasest		,
					@fnominal	output	,
					@ftir		output	,
					@fpvp		output	,
					@fmt		output	,
					@fmtum		output	,
					@fmt_cien	output	,
					@fvan		output	,
					@fvpar		output	, 
					@nnumucup	output	,
					@dfecucup	output	,
					@fintucup	output	,
					@famoucup	output	,
					@fsalucup	output	,
					@nnumpcup	output	,
					@dfecpcup	output	,
					@fintpcup	output	,
					@famopcup	output	,
					@fsalpcup	output	,
					@fdurat		output	,

					@fconvx		output	,
					@fdurmo		output
	END

	SELECT	'fError'	= @nerror				,
		'fNominal'	= ISNULL( @fnominal, 0.0 )		,
		'fTir'		= ISNULL( @ftir, 0.0 )			,
		'fPvp'		= ISNULL( @fpvp, 0.0 )			,
		'fMT '		= ISNULL( @fmt, 0.0 )			,
		'fMTUM'		= ISNULL( @fmtum, 0.0 )			,
		'fMT_cien'	= ISNULL( @fmt_cien, 0.0 )		,
		'fVan'		= ISNULL( @fvan, 0.0 )			,
		'fVpar'		= ISNULL( @fvpar, 0.0 )			,
		'nNumucup'	= ISNULL( @nnumucup, 0 )		,
		'cFecucup'	= isnull(CONVERT(CHAR(10),@dfecucup,103)," ")	,
		'fIntucup'	= ISNULL( @fintucup, 0.0 )		,
		'fAmoucup'	= ISNULL( @famoucup, 0.0 )		,
		'fSalucup'	= ISNULL( @fsalucup, 0.0 )		,
		'nNumpcup'	= ISNULL( @nnumpcup, 0.0 )		,
		'cFecpcup'	= isnull(CONVERT(CHAR(10),@dfecpcup,103)," ")	,
		'fIntpcup'	= ISNULL( @fintpcup, 0.0 )		,
		'fAmopcup'	= ISNULL( @famopcup, 0.0 )		,
		'fSalpcup'	= ISNULL( @fsalpcup, 0.0 )		,
		'fDurat'	= ISNULL( @fdurat, 0.0 )		,
		'fConvx'	= ISNULL( @fconvx, 0.0 )		,
		'fDurmo'	= ISNULL( @fdurmo, 0.0 )

      SET NOCOUNT OFF

      RETURN

END








GO
