USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REVISION_MDRS]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_REVISION_MDRS]( @feccal CHAR(10) )
AS
BEGIN

   DECLARE @xvasr_paso  NUMERIC(21,4)
       SET @xvasr_paso = 0.0

	SET NOCOUNT ON;


	DECLARE @cProg               CHAR(10)	,
		@iModcal             INTEGER	,
		@iCodigo             INTEGER	,
		@cInstser            CHAR(10)	,
		@iMonemi             INTEGER	,
		@dFecemi             CHAR(10)	,
		@dFecven             CHAR(10)	,
-->		@feccal              CHAR(10)	,
		@fTasemi             FLOAT	,
		@fBasemi             FLOAT	,
		@fTasest             FLOAT	,
		@fNominal            FLOAT	,
		@fTir                FLOAT	,
		@fPvp                FLOAT	,
		@fMT                 FLOAT	;

	DECLARE @Usuario            VARCHAR(15)	,
		@Marca              CHAR(1)	,
		@Documento          NUMERIC(9)	,
		@Correlativo        NUMERIC(9)	,
		@Serie              VARCHAR(20)	,
		@Moneda             CHAR(3)	,
		@Nominal_Compra     FLOAT	,
		@Tasa_Compra        FLOAT	,
		@Valor_Par          FLOAT	,
		@Valor_Presente     FLOAT	,
		@Margen             FLOAT	,
		@Valor_Inicial      FLOAT	,
		@Nominal_Venta      FLOAT	,
		@Tasa_Venta         FLOAT	,
		@vPar_Venta         FLOAT	,
		@vPresente_Venta    FLOAT	,
		@vInicial_Venta     FLOAT	,
		@pvp		    FLOAT	,		
		@plazo		    INTEGER	,	
		@monto		    FLOAT	,
		@VP_Actual	    FLOAT	,	
		@numoper	    NUMERIC(10) ,
		@numdocu	    NUMERIC(10) ,
		@correla	    INTEGER 	,

		@Ventana            NUMERIC(9)	;

	DECLARE @mascara 	    CHAR(10)	,
		@instser	    CHAR(10)	;

	DECLARE @Nominal_faltante   FLOAT	,
		@vInicialVenta	    FLOAT	,
		@vNominalModcal	    FLOAT	,	
		@vMT		    FLOAT	;


	DECLARE @modcal		  SMALLINT	,
		@nominal	  FLOAT		;


	DECLARE @bModulo	    CHAR(01)	;	

	    SET	@bModulo	= 0;
	    SET @modcal		= 2;  

--	    SET @feccal 	= (SELECT CONVERT(CHAR(10),acfecproc,112) FROM  mdac0721);


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


	DECLARE	@nNumucup	INTEGER		,
		@cFecucup	CHAR(10)	,
		@cFecpcup	CHAR(10)	,
		@fDurat		FLOAT		,
		@fConvx		FLOAT		,
		@fDurmo		FLOAT 		,
		@nrutemi	NUMERIC(9)	;

	DECLARE @estado INTEGER;

      -- Tabla para recibir datos de la Valorizacion
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



	DECLARE cursor_cartera	SCROLL CURSOR FOR
	SELECT	rsinstser	,  
		rsmascara	,
		rsvppresen	,
		rsnumoper	,
		rsnumdocu	,
		rscorrela	,
		rsnominal	,
		rstir	
	FROM  mdrs
       WHERE  rsfecha >'20090720'
	 AND rscodigo<>20
      	 AND rscartera in ('111','114')

	/*SELECT	instser	,  
		vimascara	,
		vivptirc	,
		vinumoper	,
		vinumdocu	,
		vicorrela	,
		vinominal	,
		vitircomp	
	FROM  mdCP0721
       WHERE  viseriado='S'
*/
	OPEN cursor_cartera

	FETCH FIRST FROM cursor_cartera
	INTO	@instser	,  
		@mascara 	,
		@VP_Actual	,
		@numoper	,                             
		@numdocu	,
		@correla	,
		@nominal	,
		@ftir		

  
	WHILE @@fetch_status = 0 
	BEGIN


		DELETE FROM #Valorizacion	
	
		DELETE FROM #DatosSerie		

select @mascara 

	     /* ________________________________________________________________________________________________}
		Cargo datos de las series para poder valorizar							|
		================================================================================================} */
		
		INSERT INTO #DatosSerie		
		EXECUTE SP_CHKINSTSER @instser;

	
		SELECT 	@cInstser=cmascara	,
			@imonemi=nmonemi	,
			@icodigo=codigo		,
			@dFecemi=CONVERT(CHAR(10),CONVERT(DATETIME,dFecemi,103),112),
			@dFecven=CONVERT(CHAR(10),CONVERT(DATETIME,dFecven,103),112),
			@ftasemi=ftasemi	,
			@fbasemi=nbasemi	,
			@ftasest=0.0		,
			@fpvp=@pvp		,
			@nrutemi=nrutemi	
		FROM #DatosSerie;		
	     -- ************************************************************************************************

 		INSERT INTO #Valorizacion
		EXECUTE SP_VALORIZAR_CLIENT
			2,
			@feccal,
			@iCodigo,
			@Mascara,
			@iMonemi,
			@dFecemi,
			@dFecven,
			@fTasemi,
			@fBasemi,
			@fTasest,
			@Nominal, 
			@fTir,
			@fPvp,
			@fMT



		SELECT 	 			(fMT  -			@VP_Actual)
		FROM    #Valorizacion;




		FETCH NEXT FROM cursor_cartera
		INTO	@instser	,  
			@mascara 	,
			@VP_Actual	,
			@numoper	,                             
			@numdocu	,
			@correla	,
			@nominal	,
			@ftir		
	END

	CLOSE cursor_cartera
	DEALLOCATE cursor_cartera 

	RETURN

END

-- select * from mdrs where rsfecha='20090721'

GO
