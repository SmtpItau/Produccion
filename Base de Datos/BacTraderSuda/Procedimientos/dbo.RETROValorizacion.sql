USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[RETROValorizacion]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[RETROValorizacion]
AS         
BEGIN
	SET NOCOUNT ON ;

	DECLARE    
		   @modcal				INTEGER
	   ,   @mascara 			CHAR(10)
	   ,   @nominal				FLOAT
	   ,   @tir					FLOAT
	   ,   @pvp					FLOAT
	   ,   @monto				FLOAT
	   ,   @fValComu			FLOAT
	   ,   @feccal				CHAR(10)
	   ,   @feccomp				CHAR(10)
	   ,   @nNominalORIG		FLOAT		--> Nominal Original
	   ,   @fMontoORIG			FLOAT		--> Valor Presente Original
	   ,   @sCartera			VARCHAR(1)	--> Codigo de Cartera Super
	   ,   @fHairCut			FLOAT      = 0
	   ,   @folioSOMA			NUMERIC(9) = 0    --> PRD-6010
	   ,   @CorrelaSOMA			NUMERIC(3) = 0    --> PRD-6010
	   ,   @dRutEmisor			NUMERIC(10) = 0  --> Rut del Emisor que ahora participa en la agrupación

  DECLARE    @numdocu	NUMERIC(10,0),
			 @correla	INT 

	DECLARE @reajuste FLOAT 
		DECLARE @interes FLOAT
		
	TRUNCATE TABLE dbo.FinalSerie

	DECLARE @cProg               CHAR(10)	,
		@iModcal             INTEGER	,
		@iCodigo             INTEGER	,
		@cInstser            CHAR(10)	,
		@iMonemi             INTEGER	,
		@dFecemi             CHAR(10)	,
		@dFecven             CHAR(10)	,
		@fTasemi             FLOAT	,
		@fBasemi             FLOAT	,
		@fTasest             FLOAT	,
		@fNominal            FLOAT	,
		@zNominal	     FLOAT 	,
		@fTir                FLOAT	,
		@fPvp                FLOAT	,
		@fmtA                FLOAT	,
		@fMT                 FLOAT	,
		
				@fMTum                 FLOAT	;

	DECLARE @Usuario            VARCHAR(15)	,
		@Marca              CHAR(1)	,
		@zdocumento	    NUMERIC(9)	,
 		@zcorrelativo	    NUMERIC(9)	,
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
		@plazo		    INTEGER	,	
		@Ventana            NUMERIC(9)	;

	DECLARE @Nominal_faltante   FLOAT	,
		@vInicialVenta	    FLOAT	,
		@vNominalModcal	    FLOAT	,	
		@vMT		    FLOAT	;

	DECLARE @bModulo	    CHAR(01)	;	
      -- Tabla para recibir datos de la serie	

	    SET	@bModulo	= 0		;

	DECLARE @iContadorReg	    INTEGER 
	,	@iContadorTot	    INTEGER	;		


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
		ncorte      	NUMERIC(21,4)	,
		cseriado    	CHAR(1)		,
		clecemi     	CHAR(6)		,
		fecpro	    	CHAR(10)	)	;

	DECLARE	@nNumucup	INTEGER		,
		@cFecucup	CHAR(10)	,
		@cFecpcup	CHAR(10)	,
		@fDurat		FLOAT		,
		@fConvx		FLOAT		,
		@fDurmo		FLOAT 		,
		@fechaAntes		CHAR(10)	,
		@nrutemi	NUMERIC(9)		;

	DECLARE @estado 	INTEGER			;

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

			DECLARE @fValmonHOY		FLOAT
			DECLARE @fValmonAYER	FLOAT

		DECLARE @tblFechas	TABLE (fechaRevision	date)
		DECLARE @i  INT 
		DECLARE @fIni date 

		SET @fIni ='2015-07-13'
		SET @i=0


		WHILE (@fIni <'2016-04-01')
		BEGIN 
	
			SET @fIni = DATEADD(DAY,1,@fIni)
	
			INSERT INTO @tblFechas VALUES(@fIni)
		END 


		
			SELECT	
					distinct s.Operacion, 
					s.Correla, 
					s.serie, 
					CONVERT(CHAR(10),r.rsfecha,112)			AS rsfecha, 
					r.rstir,
					ISNULL(r.rsnominal,0)					AS NominalDisponible,
					CONVERT(CHAR(10),r.rsfecctb,112)		AS rsfechaAnt,
					CONVERT(CHAR(10),tdfecven,112)			AS tdfecven,		
					ROW_NUMBER() OVER (ORDER BY s.Operacion, Correla, serie,r.rsfecha) AS iRegistro
			INTO #Cartera		   			 
			FROM   dbo.SerieGarantia s 
				   INNER JOIN (
							SELECT rsfecha, 
								   rsfecctb, 
								   rsnumdocu, 
								   rscorrela, 
								   rstir, 
								   SUM(rsnominal) AS rsnominal
							  FROM bactradersuda.dbo.mdrs rx
							 INNER 
							  JOIN dbo.SerieGarantia sx
							    ON sx.operacion = rx.rsnumdocu  
							 WHERE rx.rscartera IN (111, 114,159)
							   AND rx.rstipoper ='DEV'
							   AND rx.rsfecha IN ( SELECT fechaRevision FROM @tblFechas) 
							GROUP BY rsfecha, rsfecctb, rsnumdocu, rscorrela,rstir
						)  AS r
						ON  r.rsnumdocu = s.operacion
						AND r.rscorrela = s.correla
		    INNER 
			JOIN bactradersuda.dbo.mdmh h
				ON  h.monumoper = s.operacion
				AND h.mocorrela = s.correla
				AND motipoper = 'CP'
		   INNER 
		    JOIN VIEW_TABLA_DESARROLLO vtd1
				  on  VTD1.tdmascara = s.serie
		   AND vtd1.tdcupon = (
				   SELECT TOP 1 tdcupon
				   FROM   VIEW_TABLA_DESARROLLO vtd
				   WHERE  VTD.tdmascara = s.serie
						  AND vtd.tdfecven > GETDATE() ) -1




	DECLARE @iRow	NUMERIC(10,0)
	DECLARE @iTotal	NUMERIC(10,0) 
		SET @iRow	= 1
		SET @iTotal = (SELECT MAX(iRegistro) FROM #Cartera); 
	
	WHILE (@iRow <=@iTotal)
	BEGIN

 	--> Carga de Resgistro 			
		SELECT 
			@mascara		= serie				,
			@fNominal		= NominalDisponible , 
			@fTir			= rstir				, 
			@fechaAntes		= rsfechaAnt		,
			@feccal			= rsfecha			, 
			@numdocu		= operacion			, 
			@correla		= correla			,
			@feccomp		= tdfecven    
		FROM #Cartera
  	   WHERE iRegistro = @irow  		
			
		SET @modcal= 2


		--> SELECT * FROM BacTraderSuda.dbo.mdrs WITH(NOLOCK) WHERE rsfecha = @feccal AND rsnumdocu = @numdocu AND rscorrela = @correla
		
			 /* ________________________________________________________________________________________________}
			Cargo datos de las series para poder valorizar							|
			================================================================================================} */
			INSERT INTO #DatosSerie		
			EXECUTE sp_chkinstser @mascara;

			SELECT 	@cInstser=cmascara	,
				@imonemi=nmonemi	,
				@icodigo=codigo		,
				@dFecemi=CONVERT(CHAR(10),CONVERT(DATETIME,dFecemi,103),112),
				@dFecven=CONVERT(CHAR(10),CONVERT(DATETIME,dFecven,103),112),
				@ftasemi=ftasemi	,
				@fbasemi=nbasemi	,
				@ftasest=0.0		,
		   -->  @fNominal=@nominal	,
				@fpvp=@pvp		,
				@fmt=@monto		,
				@nrutemi=nrutemi	
			FROM #DatosSerie;		

			SET @fValComu =0 ; 
		
			/*	 
			IF @iMonemi <> 999
			BEGIN 
			*/	
				truncate table #Valorizacion
				INSERT INTO  #Valorizacion
				EXECUTE sp_valorizar_client
					@modcal,
					@feccomp ,
					@iCodigo,
					@Mascara,
					@iMonemi,
					@dFecemi,
					@dFecven,
					@fTasemi,
					@fBasemi,
					@fTasest,
					@fNominal,
					@fTir,
					@fPvp,
					@fMT

				SELECT @fValComu = fmtum    FROM 			#Valorizacion
		    --> END 

		--> Fecha Ayer
			truncate table #Valorizacion
			INSERT INTO  #Valorizacion
			EXECUTE sp_valorizar_client
				@modcal,
				@fechaAntes,
				@iCodigo,
				@Mascara,
				@iMonemi,
				@dFecemi,
				@dFecven,
				@fTasemi,
				@fBasemi,
				@fTasest,
				@fNominal,
				@fTir,
				@fPvp,
				@fMT
				SELECT @fmtA = fmt  FROM 			#Valorizacion
				
				
		--> Fecha Hoy 			
			truncate table #Valorizacion
			INSERT INTO  #Valorizacion
			EXECUTE sp_valorizar_client
				@modcal,
				@feccal,
				@iCodigo,
				@Mascara,
				@iMonemi,
				@dFecemi,
				@dFecven,
				@fTasemi,
				@fBasemi,
				@fTasest,
				@fNominal,
				@fTir,
				@fPvp,
				@fMT

			  
			SELECT @fmt = fmt, @fmtum = fmtum    FROM 			#Valorizacion
			
			SET @reajuste =0
			
			IF @iMonemi <> 999 
			BEGIN 
				SELECT @fValmonHOY = ISNULL(vvm.vmvalor,1) FROM  VIEW_VALOR_MONEDA vvm WHERE vvm.vmcodigo = @iMonemi AND vvm.vmfecha = @feccal
				SELECT @fValmonAYER= ISNULL(vvm.vmvalor,1) FROM  VIEW_VALOR_MONEDA vvm WHERE vvm.vmcodigo = @iMonemi AND vvm.vmfecha = @fechaAntes
			
				SET @reajuste = (@fValmonHOY - @fValmonAYER) * @fValComu
			END 			
			
--select @feccal ,@numdocu,@correla,@cInstser, @iMonemi ,@fNominal, @fTir, @fMT, @fValComu , 0,@reajuste
			
			INSERT INTO dbo.FinalSerie
			     VALUES( @feccal ,@numdocu,@correla,@cInstser, @iMonemi ,@fNominal, @fTir, @fMT, @fValComu , @fmt-@reajuste-@fmtA,@reajuste,@fmtA )  
  
  			/*
  			SELECT rsfecha, 
  				   @feccal		AS  FECHA, 
  				   rsnumdocu, 
  				   @numdocu		AS NUMDOCU, 
  				   rscorrela,	
  				   @correla		AS CORRELA,
  				   rsnominal	
  				   @nominal		AS NOMINAL,
  				   rsinteres,
  				   	
  				   
  				    
  			  FROM BacTraderSuda.dbo.mdrs WITH(NOLOCK) WHERE rsfecha = @feccal AND rsnumdocu = @numdocu AND rscorrela = @correla
  			*/
  		
			SET @iRow =@iRow+1
	END
	
;WITH CTE 
	AS 
(
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY numdocu,
               correla ORDER BY numdocu,
               correla,
               fecha
           ) AS reg
    FROM   dbo.FinalSerie
)
	SELECT ori.Fecha,
	       ori.numdocu,
	       ori.correla,
	       ori.serie,
	       ori.nominal,
	       ori.tasa,
	       ori.vp,
	       interes = CASE 
	                      WHEN desp.vp = 0 THEN 0
	                      ELSE ((desp.vp + ISNULL(ValCupon, 0)) -ori.vp) -ori.reajuste
	                 END,
	       ori.reajuste,
	       ISNULL(ValCupon, 0)  AS ValCupon, ori.vp_um AS Capital ,
	       IDENTITY(INT) AS Registro 
	INTO dbo.CarteraArreglo	       
	FROM   cte ori
	       LEFT JOIN cte desp
	            ON  desp.numdocu = ori.numdocu
	            AND desp.correla = ori.correla
	            AND desp.reg = ori.reg + 1
	       LEFT JOIN (
	                SELECT r.rsfecha,
	                       r.rsnumdocu,
	                       r.rscorrela,
	                       SUM(r.rsflujo) AS ValCupon
	                FROM   dbo.SerieGarantia sg
	                       INNER JOIN dbo.mdrs r
	                            ON  r.rscorrela = sg.correla
	                            AND r.rsnumdocu = sg.operacion
	                            AND r.rstipoper = 'VC'
	                GROUP BY
	                       rsfecha,
	                       rsnumdocu,
	                       r.rscorrela
	            )               AS Cupon
	            ON  Cupon.rsfecha = desp.fecha
	            AND Cupon.rsnumdocu = ori.numdocu
	            AND Cupon.rscorrela = ori.correla
	ORDER BY
	       numdocu,
	       correla,
	       fecha  
   
END
GO
