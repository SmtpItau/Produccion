USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[CARTERA_REVISION_MDVI_110516]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CARTERA_REVISION_MDVI_110516]
AS
BEGIN
	SET NOCOUNT ON ;
	
	
	DECLARE @modcal INTEGER,
	        @mascara CHAR(10),
	        @nominal FLOAT,
	        @tir FLOAT,
	        @pvp FLOAT,
	        @monto FLOAT,
	        @fValComu FLOAT,
	        @feccal CHAR(10),
	        @feccomp CHAR(10)
	
	
	DECLARE @numdocu NUMERIC(10, 0),
	        @correla INT 
	
	
	
	DECLARE @reajuste FLOAT 
	
	DECLARE @interes FLOAT
	
	
	
	--> 	TRUNCATE TABLE dbo.FinalSerie
	
	
	
	DECLARE @cProg CHAR(10),
	        @iModcal INTEGER,
	        @iCodigo INTEGER,
	        @cInstser CHAR(10),
	        @iMonemi INTEGER,
	        @dFecemi CHAR(10),
	        @dFecven CHAR(10),
	        @fTasemi FLOAT,
	        @fBasemi FLOAT,
	        @fTasest FLOAT,
	        @fNominal FLOAT,
	        @zNominal FLOAT,
	        @fTir FLOAT,
	        @fPvp FLOAT,
	        @fmtA FLOAT,
	        @fMT FLOAT,
	        @fMTum FLOAT ;
	
	
	
	DECLARE @Usuario VARCHAR(15),
	        @Marca CHAR(1),
	        @zdocumento NUMERIC(9),
	        @zcorrelativo NUMERIC(9),
	        @Documento NUMERIC(9),
	        @Correlativo NUMERIC(9),
	        @Serie VARCHAR(20),
	        @Moneda CHAR(3),
	        @Nominal_Compra FLOAT,
	        @Tasa_Compra FLOAT,
	        @Valor_Par FLOAT,
	        @Valor_Presente FLOAT,
	        @Margen FLOAT,
	        @Valor_Inicial FLOAT,
	        @Nominal_Venta FLOAT,
	        @Tasa_Venta FLOAT,
	        @vPar_Venta FLOAT,
	        @vPresente_Venta FLOAT,
	        @vInicial_Venta FLOAT,
	        @plazo INTEGER,
	        @Ventana NUMERIC(9) ;
	
	
	
	
	
	DECLARE @iContadorReg INTEGER,
	        @iContadorTot INTEGER ;		
	
	
	
	
	
	CREATE TABLE #DatosSerie
	(
		nerror       INTEGER,
		cmascara     CHAR(12),
		codigo       INTEGER,
		cserie       CHAR(12),
		nrutemi      NUMERIC(9, 0),
		nmonemi      INTEGER,
		ftasemi      FLOAT,
		nbasemi      NUMERIC(3, 0),
		dfecemi      CHAR(10),
		dfecven      CHAR(10),
		crefnomi     CHAR(1),
		cgenemi      CHAR(10),
		cnemmon      CHAR(5),
		ncorte       NUMERIC(21, 4),
		cseriado     CHAR(1),
		clecemi      CHAR(6),
		fecpro       CHAR(10)
	) ;
	
	
	
	DECLARE @nNumucup INTEGER,
	        @cFecucup CHAR(10),
	        @cFecpcup CHAR(10),
	        @fDurat FLOAT,
	        @fConvx FLOAT,
	        @fDurmo FLOAT,
	        @fechaAntes CHAR(10),
	        @nrutemi NUMERIC(9) ;

	declare @fMTAyer FLOAT;
	
	
	DECLARE @estado INTEGER ;
	
	
	
	-- Tabla para recibir datos de la Valorizacion
	
	CREATE TABLE #Valorizacion
	(
		fError       INTEGER,
		fNominal     FLOAT,
		fTir         FLOAT,
		fPvp         FLOAT,
		fMT          FLOAT,
		fMTUM        NUMERIC(21, 8),
		fMT_cien     FLOAT,
		fVan         FLOAT,
		fVpar        FLOAT,
		nNumucup     INTEGER,
		cFecucup     CHAR(10),
		fIntucup     FLOAT,
		fAmoucup     FLOAT,
		fSalucup     FLOAT,
		nNumpcup     FLOAT,
		cFecpcup     CHAR(10),
		fIntpcup     FLOAT,
		fAmopcup     FLOAT,
		fSalpcup     FLOAT,
		fDurat       FLOAT,
		fConvx       FLOAT,
		fDurmo       FLOAT
	);
	
	
	
	DECLARE @fValmonHOY FLOAT
	DECLARE @fValmonAYER FLOAT
	DECLARE @fValorVenta FLOAT
	DECLARE @fResultado FLOAT
	DECLARE @fMTComp FLOAT
	DECLARE @fTirM	FLOAT
	
	
	
	DECLARE @tblFechas TABLE (fechaRevision date)
	DECLARE @i INT 
	DECLARE @fIni date 
	
	
	SELECT cp.*, 
			CONVERT(FLOAT,0) as NewVPhOY	,
			CONVERT(FLOAT,0) as NewVPAyer	,
			CONVERT(FLOAT,0) as NewVPComp	,
			CONVERT(FLOAT,0) as NewVPComu	,
			CONVERT(FLOAT,0) as Interes	,
			CONVERT(FLOAT,0) as Reajuste	, dimoneda,
			 

	    ROW_NUMBER() OVER(ORDER BY vinumdocu, vicorrela) AS iRegistro
	    INTO #Cartera
	FROM bactradersuda.dbo.mdVI cp
	 inner join bactradersuda.dbo.mddi di
	 on dinumdocu= vinumdocu
	 and dicorrela = vicorrela 

	/*
	AND rsfecha ='2016-05-11' 
	AND RSCARTERA IN ('111','114','159')	 
--	and rsnumdocu =101344
	*/

	DECLARE @fNomiVentas NUMERIC(24, 4)
	
	DECLARE @iRow NUMERIC(10, 0)
	
	DECLARE @iTotal NUMERIC(10, 0) 
	
	SET @iRow = 1
	
	SET @iTotal = (
	        SELECT MAX(iRegistro)
	        FROM   #Cartera
	    ); 
	
	/*  	
	*   =========================================================================================================================================================		
	*														CICLO PRINCIPAL PARA PROCESAR INFROMACION
	*   =========================================================================================================================================================
	*/
	DECLARE @rscartera CHAR(3) 
	WHILE (@iRow <= @iTotal)
	BEGIN
	    --- ------------------------------------------------
	    --> Carga 1e Resgistro 			
	    
	    SELECT @mascara			= viinstser , -->serie,
--	           @feccal          = CONVERT(CHAR(10), rsfecha, 112),	--> Fecha Hoy
	           @fNominal        = vinominal,	--NominalDisponible , 
	           @fTir            = vitircomp,
	           @numdocu         = vinumdocu,
	           @correla         = vicorrela,
			   @fvalcomu		= vivalcomu,
	           @fTirM			= vitircomp,
			   @iMonemi			= dimoneda,
			   @dFecemi     = CONVERT(CHAR(10), CONVERT(DATETIME, vifecemi, 103), 112),
	           @dFecven     = CONVERT(CHAR(10), CONVERT(DATETIME, vifecven , 103), 112)
		 FROM   #Cartera
	    WHERE  iRegistro        = @irow  		
	    
	    set @interes=0
		set @reajuste=0
	    
	    SET @modcal = 2
	    
	    
	    /* ________________________________________________________________________________________________}
	    Cargo datos de las series para poder valorizar							|
	    ================================================================================================} */
	    
	    INSERT INTO #DatosSerie
	    EXECUTE sp_chkinstser @mascara;
	    
	    SELECT @cInstser = cmascara,
	           --@imonemi     = nmonemi,
	           @icodigo     = codigo,
	           @ftasemi     = ftasemi,
	           @fbasemi     = nbasemi,
	           @ftasest     = 0.0,
	           @fpvp        = @pvp,
	           @fmt         = @monto,
	           @nrutemi     = nrutemi
	    FROM   #DatosSerie;		
	    
	    
	    
	    -->SET @fValComu = 0 ; 
	    
	    
	    TRUNCATE TABLE #Valorizacion
	    	    
	    INSERT INTO #Valorizacion
	    EXECUTE sp_valorizar_client
	    @modcal,
	    '2016-04-01', 
	    @iCodigo,
		@mascara,
	    @iMonemi,
	    @dFecemi,
	    @dFecven,
	    @fTasemi,
	    @fBasemi,
	    @fTasest,
	    @fNominal, 
	    @fTirM,
	    @fPvp,
	    @fMT

	    	    
	    	    SELECT @fMTComp = fmt, @fMTum =fMTum 
	    	    FROM   #Valorizacion

	    	    UPDATE #cartera
	    	    SET    NewVPComp			= @fMTComp ,NewVPComu = @fMTum			 
	    	    WHERE  iRegistro         = @irow
	    	    

	    
	    TRUNCATE TABLE #Valorizacion
	    	    
	    INSERT INTO #Valorizacion
	    EXECUTE sp_valorizar_client
	    @modcal,
	    '2016-05-10', 
	    @iCodigo,
		@mascara,
	    @iMonemi,
	    @dFecemi,
	    @dFecven,
	    @fTasemi,
	    @fBasemi,
	    @fTasest,
	    @fNominal, 
	    @fTirM,
	    @fPvp,
	    @fMT

	    	    
	    	    SELECT @fMTAyer = fmt
	    	    FROM   #Valorizacion

	    	    UPDATE #cartera
	    	    SET    NewVPHoy			= @fMTAyer 
	    	    WHERE  iRegistro         = @irow
	    	    

	    TRUNCATE TABLE #Valorizacion
	    	    
	    INSERT INTO #Valorizacion
	    EXECUTE sp_valorizar_client
	    @modcal,
	    '2016-05-11', 
	    @iCodigo,
	    @Mascara,
	    @iMonemi,
	    @dFecemi,
	    @dFecven,
	    @fTasemi,
	    @fBasemi,
	    @fTasest,
	    @fNominal, 
	    @fTirM,
	    @fPvp,
	    @fMT


				IF @iMonemi <> 999
				BEGIN
					SELECT @fValmonHOY = ISNULL(vvm.vmvalor, 1)
					FROM   VIEW_VALOR_MONEDA vvm
					WHERE  vvm.vmcodigo = @iMonemi
						AND vvm.vmfecha = '2016-05-11'
	    	        
					SELECT @fValmonAYER = ISNULL(vvm.vmvalor, 1)
					FROM   VIEW_VALOR_MONEDA vvm
					WHERE  vvm.vmcodigo = @iMonemi
						AND vvm.vmfecha = '2016-05-10'
	    	        
					SET @reajuste = ROUND((@fValmonHOY - @fValmonAYER) * @fValComu,0)
				END 
				--> -------------------------------------------------------------------------------------------------------------------------------------

				
	    	    
	    	    SELECT @fmtA = fmt
	    	    FROM   #Valorizacion

				SET @interes = ( @fmtA-@fMTAyer ) - @reajuste


-->				select @fmtA,@fMTAyer , @reajuste, @fvalcomu,				@interes


	    	    UPDATE #cartera
	    	    SET    NewVPAyer		= @fmtA,
						interes			= @interes,
						reajuste		= @reajuste
	    	    WHERE  iRegistro         = @irow



	    	
	    	SET @iRow = @iRow + 1
	    END
	    
	    
	    

	    SELECT *
	           
	           INTO dbo.ResultadoCorregidaCompra_vi
	    FROM   #cartera c
	
	END
GO
