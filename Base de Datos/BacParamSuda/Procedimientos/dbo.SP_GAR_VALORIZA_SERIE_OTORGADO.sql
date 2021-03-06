USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_VALORIZA_SERIE_OTORGADO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GAR_VALORIZA_SERIE_OTORGADO]
   	(   	@fFeccal	DATETIME
	,	@nNumdocu	NUMERIC(10)
	,	@nCorrelativo	NUMERIC(05)   
	,   	@nNominal	FLOAT	
	,   	@nTir		FLOAT
	,   	@nVpresen	FLOAT
	,   	@iModcal	INTEGER	)
AS 
BEGIN

	SET NOCOUNT ON					;

	DECLARE @cProg               	CHAR(10)
	,	@cInstser            	CHAR(10)
	,	@mascara             	CHAR(10)
	,	@dFecemi             	CHAR(10)	
	,	@dFeccal		CHAR(10)
	,	@dFecven             	CHAR(10)	;

	DECLARE	@iCodigo             	INTEGER	
	,	@iMonemi             	INTEGER		;


	DECLARE	@fTasemi             	FLOAT	
	,	@fBasemi             	FLOAT	
	,	@fTasest             	FLOAT	
	,	@fNominal            	FLOAT	
	,	@fTir                	FLOAT	
	,	@fPvp                	FLOAT	
	,	@fMT                 	FLOAT		;

	DECLARE	@nNumucup		INTEGER		
	,	@cFecucup		CHAR(10)	
	,	@cFecpcup		CHAR(10)	
	,	@fDurat			FLOAT		
	,	@fConvx			FLOAT		
	,	@fDurmo			FLOAT 		
	,	@nrutemi		NUMERIC(9)	


	CREATE TABLE 
	#DatosSerie( 
	   		nerror      	INTEGER		,
			cmascara    	CHAR(12)	,
			codigo		INTEGER		,
			cserie      	CHAR(12)	,
			nrutemi     	NUMERIC(9,0)	,
			nmonemi     	INTEGER		,
			ftasemi     	FLOAT		,
			nbasemi     	NUMERIC(3,0)	,
			dfecemi     	CHAR(10)	,
			dfecven     	CHAR(10)	,
			crefnomi    	CHAR(1)		,
			cgenemi     	CHAR(10)	,
			cnemmon     	CHAR(5) 	,
			ncorte      	NUMERIC(19,4)	,
			cseriado    	CHAR(1)		,
			clecemi     	CHAR(6)		,
			fecpro	    	CHAR(10)	);
	
	CREATE TABLE 
	 #Valorizacion(
			fError 		INTEGER 	,
			fNominal	FLOAT		,
			fTir		FLOAT		,	
			fPvp		FLOAT		,
			fMT		FLOAT		,
			fMTUM		FLOAT		,
			fMT_cien	FLOAT		,
			fVan		FLOAT		,
			fVpar		FLOAT		,
			nNumucup	INTEGER		,
			cFecucup	CHAR(10)	,
			fIntucup	FLOAT		,
			fAmoucup	FLOAT		,
			fSalucup	FLOAT		,
			nNumpcup	FLOAT		,
			cFecpcup	CHAR(10)	,
			fIntpcup	FLOAT		,
			fAmopcup	FLOAT		,
			fSalpcup	FLOAT		,
			fDurat		FLOAT		,
			fConvx		FLOAT		,
			fDurmo		FLOAT 		);



		
	SET @mascara  = (SELECT TOP 1 cpinstser /*CASE WHEN cpcodigo = 20 THEN cpmascara ELSE cpinstser END*/
			   FROM bactradersuda.dbo.mdcp
			  WHERE cpnumdocu = @nnumdocu 
			    AND cpcorrela = @ncorrelativo);
		

	INSERT INTO #DatosSerie		
	EXECUTE bactradersuda.dbo.SP_CHKINSTSER @mascara;

	SELECT 	@mascara=cmascara	,
		@imonemi=nmonemi	,
		@icodigo=codigo		,
		@dFecemi=CONVERT(CHAR(10),CONVERT(DATETIME,dFecemi,103),112),
		@dFecven=CONVERT(CHAR(10),CONVERT(DATETIME,dFecven,103),112),
		@ftasemi=ftasemi	,
		@fbasemi=nbasemi	,
		@nrutemi=nrutemi	
	FROM #DatosSerie;		

	SET @ftasest=0.0		

	SET @dfeccal = CONVERT(CHAR(10),@fFeccal,112);


	INSERT INTO  #Valorizacion
	EXECUTE bactradersuda.dbo.SP_VALORIZAR_CLIENT
		@iModcal,
		@dfeccal,
		@iCodigo,
		@Mascara,
		@iMonemi,
		@dFecemi,
		@dFecven,
		@fTasemi,
		@fBasemi,
		@fTasest,
		@nNominal,
		@nTir,
		@fPvp,
		@nVpresen

	SELECT 	@fmt = FMT 		,
		@fPvp= fPvp		,
		@nNumucup=nNumucup 	,
		@cFecucup=cFecucup 	,
		@cFecpcup=cFecpcup 	,
		@fDurat=fDurat		,
		@fConvx=fConvx		,
		@fDurmo=fDurmo		,
		@fTir =CAST(fTir AS NUMERIC(10,4))
	FROM #Valorizacion;

	SELECT 	0
	,	@nNominal
	,	@fTir 
	,	@fPvp
	,	@fmt

END
GO
