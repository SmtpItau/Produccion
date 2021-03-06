USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORIZAR_CLIENT_upd]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_VALORIZAR_CLIENT_upd]  
	(	@modcal		INTEGER			,
		@cFeccal	CHAR (10)		,
		@nCodigo	INTEGER			,
		@cMascara	CHAR (12)		,
		@nMonemi	INTEGER			,
		@cFecemi	CHAR (10)		,
		@cFecven	CHAR (10)		,
		@fTasemi	FLOAT			,	
		@fBasemi	FLOAT			,
		@fTasest	FLOAT			,
		@fNominal	FLOAT			,
		@fTir		FLOAT			,
		@fPvp		FLOAT			,
		@fMT		FLOAT	output	,
		@fMTUM		FLOAT	output
	)
AS
BEGIN

	SET NOCOUNT ON

--	DECLARE @fMTUM		FLOAT  

	DECLARE @fMT_cien	FLOAT  ,
			@fVan		FLOAT  ,
			@fVpar		FLOAT  ,
			@nNumucup	INTEGER  ,
			@dFecucup	DATETIME ,
			@fIntucup	FLOAT  ,
			@fAmoucup	FLOAT  ,
			@fSalucup	FLOAT  ,
			@nNumpcup	INTEGER  ,
			@dFecpcup	DATETIME ,
			@fIntpcup	FLOAT  ,
			@fAmopcup	FLOAT  ,
			@fSalpcup	FLOAT  ,
			@nError		INTEGER  ,
			@cProg		VARCHAR (20) ,
			@dFeccal	DATETIME ,
			@dFecemi	DATETIME ,
			@dFecven	DATETIME ,
			@fDurat		FLOAT  ,
			@fConvx		FLOAT  ,
			@fDurmo		FLOAT
 
	SELECT	@dFeccal	= CONVERT(DATETIME,@cFeccal,101) ,
			@dFecemi	= CONVERT(DATETIME,@cFecemi,101) ,
			@dFecven	= CONVERT(DATETIME,@cFecven,101)
			
	SELECT	@cProg = 'SP_'+RTRIM(inprog) FROM VIEW_INSTRUMENTO WHERE incodigo=@nCodigo
	
	IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE='P' AND NAME=@cProg)
	BEGIN
  
		EXECUTE @nError =	@cProg
							@modcal				,
							@dFeccal			,
							@nCodigo			,
							@cMascara			,
							@nMonemi			,
							@dFecemi			,
							@dFecven			,
							@fTasemi			,
							@fBasemi			,
							@fTasest			,
							@fNominal	OUTPUT	,
							@fTir		OUTPUT	,
							@fPvp		OUTPUT	,
							@fMT		OUTPUT	,
							@fMTUM		OUTPUT	,
							@fMT_cien	OUTPUT	,
							@fVan		OUTPUT	,
							@fVpar		OUTPUT	, 
							@nNumucup	OUTPUT	,
							@dFecucup	OUTPUT	,
							@fIntucup	OUTPUT	,
							@fAmoucup	OUTPUT	,
							@fSalucup	OUTPUT	,
							@nNumpcup	OUTPUT	,
							@dFecpcup	OUTPUT	,
							@fIntpcup	OUTPUT	,
							@fAmopcup	OUTPUT	,
							@fSalpcup	OUTPUT	,
							@fDurat		OUTPUT	,
							@fConvx		OUTPUT	,
							@fDurmo		OUTPUT
							
		if @fMT is null
			set @fMT = 0.0;
		
		if @fMTUM is null 
			set @fMTUM = 0.0  

	END

 
 /*
 SELECT 'fError'	= ISNULL( @nError, 0 )   ,
		'fNominal'	= ISNULL( @fNominal, 0.0 )  ,
		'fTir'		= ISNULL( @fTir, 0.0 )   ,
		'fPvp'		= ISNULL( @fPvp, 0.0 )   ,
		'fMT'		= ISNULL( @fMT, 0.0 )   ,
		'fMTUM'		= ISNULL( @fMTUM, 0.0 )   ,
		'fMT_cien'	= ISNULL( @fMT_cien, 0.0 )  ,
		'fVan'		= ISNULL( @fVan, 0.0 )   ,
		'fVpar'		= ISNULL( @fVpar, 0.0 )   ,
		'nNumucup'	= ISNULL( @nNumucup, 0 )  ,
		'cFecucup'	= isnull(CONVERT(CHAR(10),@dFecucup,103),' ') ,
		'fIntucup'	= ISNULL( @fIntucup, 0.0 )  ,
		'fAmoucup'	= ISNULL( @fAmoucup, 0.0 )  ,
		'fSalucup'	= ISNULL( @fSalucup, 0.0 )  ,
		'nNumpcup'	= ISNULL( @nNumpcup, 0.0 )  ,
		'cFecpcup'	= isnull(CONVERT(CHAR(10),@dFecpcup,103),' ') ,
		'fIntpcup'	= ISNULL( @fIntpcup, 0.0 )  ,
		'fAmopcup'	= ISNULL( @fAmopcup, 0.0 )  ,
		'fSalpcup'	= ISNULL( @fSalpcup, 0.0 )  ,
		'fDurat'	= ISNULL( @fDurat, 0.0 )  ,
		'fConvx'	= ISNULL( @fConvx, 0.0 )  ,
		'fDurmo'	= ISNULL( @fDurmo, 0.0 )
*/

	SET NOCOUNT OFF

	RETURN

END
GO
