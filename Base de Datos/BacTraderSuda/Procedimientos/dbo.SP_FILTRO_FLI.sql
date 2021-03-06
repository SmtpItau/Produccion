USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTRO_FLI]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FILTRO_FLI]
   (   @gsbac_user   VARCHAR(15)
   ,   @Normativa    VARCHAR(255) = ''
   ,   @Financiera   VARCHAR(255) = ''
   ,   @hWnd         NUMERIC(9)
   ,   @TipOper      CHAR(3)
   ,   @FLI_Familia CHAR(5) = ''  --20190118.RCH.FLI
   )
AS 
BEGIN
 -- Se pondrá el emisor como parte de la data pero no se agrupará 
        -- por emisor.
	SET NOCOUNT ON

	DECLARE @acfecante   	DATETIME
	,	@acfecproc   		DATETIME


	DECLARE @cProg               	CHAR(10)
	,	@cInstser            	CHAR(10)
	,	@mascara             	CHAR(10)
	,	@dFeccal            	CHAR(10)	
	,	@dFecemi             	CHAR(10)	
	,	@Marca              	CHAR(01)	
	,	@Moneda             	CHAR(03)	
	,	@dFecven             	CHAR(10)	;

	DECLARE	@iModcal             	INTEGER	
	,	@iCodigo             	INTEGER	
	,	@plazo		    	INTEGER		
	,	@iMonemi             	INTEGER		;


	DECLARE	@Nominal	    	FLOAT	
	,	@Tasa_Compra        	FLOAT	
	,	@Valor_Par          	FLOAT	
	,	@Valor_Presente     	FLOAT	
	,	@Margen             	FLOAT	
	,	@Valor_Inicial      	FLOAT	
	,	@fTasemi             	FLOAT	
	,	@fBasemi             	FLOAT	
	,	@fTasest             	FLOAT	
	,	@fNominal            	FLOAT	
	,	@fTir                	FLOAT	
	,	@fPvp                	FLOAT	
	,	@fMT                 	FLOAT		;

	DECLARE @Usuario            	VARCHAR(15)	
	,	@Serie              	VARCHAR(20)	;

	DECLARE	@Documento          	NUMERIC(9)	
	,	@Correlativo        	NUMERIC(9)	
	,	@Ventana            	NUMERIC(9)	;

   DECLARE @RutBCCH                NUMERIC(13) 


   SELECT  @acfecante   = acfecante 
   ,       @acfecproc   = acfecproc
   ,       @RutBCCH     = acRutBCCH
   	  FROM dbo.MDAC WITH(NOLOCK)			;

	DECLARE @RutTGR				NUMERIC(13);  --20190118.RCH.FLI
  --20190118.RCH.FLI
	IF (@FLI_Familia !='')
	BEGIN
		IF (@FLI_Familia='TGR')
			SELECT @RutTGR=EMRUT FROM VIEW_EMISOR WHERE emgeneric=@FLI_Familia
		ELSE
			SELECT @RutBCCH=EMRUT FROM VIEW_EMISOR WHERE emgeneric=@FLI_Familia
	END		  
 --20190118.RCH.FLI

   CREATE TABLE #Detalle_FLIT_MP (
	Usuario 	varchar (15) 	NOT NULL 	,
	Marca 		char (1) 	NOT NULL 	,
	Documento 	numeric(9, 0) 	NOT NULL 	,
	Correlativo 	numeric(9, 0) 	NOT NULL 	,
	Serie 		varchar (20) 	NOT NULL 	,
	Moneda 		char (3) 	NOT NULL 	,
	Nominal_Compra 	float 		NOT NULL 	,
	Tasa_Compra 	float		NOT NULL 	,
	Valor_Par 	float 		NOT NULL 	,
	Valor_Presente 	numeric(19, 4) 	NOT NULL 	,
	Margen 		float 		NOT NULL 	,
	Valor_Inicial 	numeric(19, 4) 	NOT NULL 	,
	Nominal_Venta 	float 		NOT NULL 	,
	Tasa_Venta 	float 		NOT NULL 	,
	vPar_Venta 	float 		NOT NULL 	,
	vPresente_Venta numeric(19, 4) 	NOT NULL 	,
	vInicial_Venta 	numeric(19, 4) 	NOT NULL 	,
	Plazo 		numeric(21, 0) 	NOT NULL 	,
	Ventana 	numeric(9, 0) 	NOT NULL 	,
	CarteraSuper 	char (1) 	NOT NULL	,
	BloqueoPacto	numeric(19,4)	NOT NULL	,
	Haircut		float		NOT NULL	,
	Tipooper	char(3)		NOT NULL	,
	Rut_Emisor 	numeric(9, 0) 	NOT NULL 	,
	InCodigo	numeric(3,0)	NOT NULL	,
	InUnidadTiempoTasaRef char(3) 	NOT NULL	,
	InEstrucPlazoTasaRef  char(2) 	NOT NULL	,
	DiFecSal	datetime	NOT NULL	,
	Clasif_Riesgo   char(3)		NOT NULL	); 	

      INSERT INTO #Detalle_FLIT_MP 
   (   Usuario
   ,   Marca
   ,   Documento
   ,   Correlativo
   ,   Serie
   ,   Moneda
   ,   Nominal_Compra
   ,   Tasa_Compra
   ,   Valor_Par
   ,   Valor_Presente
   ,   Margen
   ,   Valor_Inicial
   ,   Nominal_Venta
   ,   Tasa_Venta
   ,   vPar_Venta
   ,   vPresente_Venta
   ,   vInicial_Venta
   ,   Plazo
   ,   Ventana
   ,   CarteraSuper
	,	BloqueoPacto	
	,	Haircut		
	,	Tipooper	
	,	Rut_Emisor 	
	,	InCodigo	
	,	InUnidadTiempoTasaRef 
	,	InEstrucPlazoTasaRef  
	,	DiFecSal	
	,	Clasif_Riesgo
   )

   SELECT DISTINCT 
	  Usuario            = @gsbac_user
   ,      Marca              = ISNULL(bl.blusuario,'N') --> CASE WHEN ISNULL(blusuario,'') = '' THEN 'N' ELSE 'S' END
   ,      Documento          = cp.cpnumdocu
   ,      Correlativo        = cp.cpcorrela
   ,      Serie              = cp.cpinstser
   ,      Moneda             = mn.mnnemo
   ,      Nominal_Compra     = cp.cpnominal - isnull( bpNominal , 0.0 ) -- PRD-6005
* ( case when cp.cpnominal - isnull( bpNominal , 0.0 ) < 0 then 0.0
     else 1.0 end ) 
 ,      Tasa_Compra        = cp.cptircomp-- ISNULL( TasaRef.trtasareferencial, 0 ) -- cp.cptircomp -- PROD-6007 Aplicar HairCut, Tasa Referencia
   ,      Valor_Par          = cp.cpvpcomp
   ,      Valor_Presente     = cp.cpvptirc * ( 1.0 - isnull( bpNominal, 0.0 ) * 1.0 / (DiNominal * 1.0)  ) -- PRD-6005
                               * ( case when cp.cpnominal - isnull( bpNominal , 0.0 ) < 0 then 0.0
                                   else 1.0 end )
   ,      Margen             = ISNULL( ROUND(ms.margen, 4), 1.0)
   ,      Valor_Inicial      = cp.cpvptirc * ( 1.0 - isnull( bpNominal, 0.0 ) * 1.0 / (DiNominal * 1.0)  ) * ISNULL( ROUND(ms.margen, 4), 1.0) -- PRD-6005
                               * ( case when cp.cpnominal - isnull( bpNominal , 0.0 ) < 0 then 0.0
                                   else 1.0 end )      
   ,      Nominal_Venta      = 0.0
   ,      Tasa_Venta         = ISNULL( TasaRef.trtasareferencial, 0 )  + isnull( HairCut.hchaircut , 0 )--0.0
   ,      vPar_Venta         = 0.0
   ,      vPresente_Venta    = 0.0
   ,      vInicial_Venta     = 0.0
   ,      Plazo              = DATEDIFF(DAY, @acfecproc, di.difecsal)
   ,      Ventana            = @hWnd
   ,   	  cp.Codigo_carterasuper
   ,      BloqueoPacto       = ISNULL( bpNominal, 0.0 ) * 1.0             -- PRD-6005
   ,      HairCut            = ISNULL( HairCut.hchaircut, 0.0)            -- PRD-6007
   ,      Tipoper      	     = @TipOper 
   ,      Rut_Emisor         = ISNULL( Em.EmRut, 0 ) -- PRD-6006 
   ,      InCodigo	     = fi.incodigo
   ,	  InUnidadTiempoTasaRef = ISNULL(fi.InUnidadTiempoTasaRef,'')
   ,	  InEstrucPlazoTasaRef =  ISNULL(fi.InEstrucPlazoTasaRef,'') 
   ,	  DiFecSal	= @acfecproc
   ,	  Clasif_Riesgo = em.tipo_corto1
   

   FROM   dbo.MDCP                               cp with(nolock)
         INNER JOIN dbo.MDDI                     di with(nolock) ON di.dinumdocu          = cp.cpnumdocu 
                                                                and di.dicorrela          = cp.cpcorrela 
                                                               and di.ditipoper          = 'CP'                                                                
                                                                and di.dinemmon          <> 'USD'



         -- PROD-6006
         left join  bacParamsuda..emisor Em
                    ON   Em.EmGeneric = di.digenemi 
                    and  Em.emtipo =  Em.emtipo --'2'    -- Instituciones Financieras
                    and  not ( Em.Emnombre like '%NULO%' )
                    and  not ( Em.Emnombre like '%MUTUO%' )

         left join BacParamSuda..Cliente Cli  
                    ON  Em.EmRut     = Cli.Clrut
                    and  Cli.ClCodigo = 1  -- Evita duplicados
                    and  Cli.CltipCli = 1  -- Bancos


         -- PROD-6005
         LEFT JOIN dbo.BloqueadoPacto BlPact with(nolock)  ON     BlPact.bpnumdocu = di.dinumdocu  
                                                              AND BlPact.bpcorrela = di.dicorrela


       
         INNER JOIN BacParamSuda.dbo.INSTRUMENTO fi with(nolock) ON fi.incodigo           = cp.cpcodigo
								 and di.DiSerie		  = fi.inserie


         INNER JOIN BacParamSuda..INSTRUMENTOS_SOMA       InstSoma with(nolock) 
                                                          ON InstSoma.InTipSOMA = @TipOper  
                                                           and InstSoma.InCodigo = cp.cpcodigo
          
         -- Generar Insert sobre todos los
         -- instrumentos del banco central
         


         LEFT  JOIN BacParamSuda.dbo.MONEDA      mn with(nolock) ON mn.mnnemo             = di.dinemmon
         LEFT  JOIN dbo.MDBL                     bl with(nolock) ON bl.blrutcart          = cp.cprutcart 
                                                                and bl.blnumdocu          = cp.cpnumdocu 
                                                     and bl.blcorrela      = cp.cpcorrela
--                                   and bl.blusuario          = ''
         LEFT JOIN  BacParamSuda.dbo.MARGEN_INSTRUMENTO_SOMA ms with(nolock) ON ms.codigo_instrumento = fi.incodigo
                                                                            and ms.Plazo_desde       <= DATEDIFF(DAY, @acfecproc, di.difecsal)
                                                                            and ms.Plazo_hasta       >= DATEDIFF(DAY, @acfecproc, di.difecsal)

         -- PROD-6007
         LEFT JOIN BacParamSuda.dbo.HAIRCUT_SOMA HairCut with(nolock)  ON HairCut.hcincodigo = fi.incodigo
                                                                      AND HairCut.hctipoper  = @TipOper  
                                                                      AND HairCut.hcClasificacionRiesgo  = '' -- Evita duplidad en Letras  
      
								     

         LEFT JOIN BacParamSuda.dbo.TASA_REFERENCIA_SOMA TasaRef with(nolock)  ON TasaRef.trincodigo = fi.incodigo
                                                                      AND TasaRef.trserie    = cp.cpinstser
                                                                      AND TasaRef.trtipoper  = @TipOper  






         -- PROD-6007

   WHERE cp.cpnominal > 0
   AND   cp.cpdcv     = 'D' -- MAP: Verificar y Por mientras ...
   AND   cp.Estado_Operacion_Linea = ''
   and   isnull(bl.blusuario,'')   = ''
   AND  (CHARINDEX( LTRIM(RTRIM(cp.cptipcart))          , @Financiera) > 0 or @Financiera = '')
   AND  (CHARINDEX( LTRIM(RTRIM(cp.codigo_carterasuper)), @Normativa)  > 0 or @Normativa  = '')
--   ORDER BY  cp.cpnumdocu, cp.cpcorrela

    CREATE INDEX #Ix001_Optimiza ON #Detalle_FLIT_MP (Tipooper, Usuario, InCodigo )


   -- select Incodigo, * from bacParamSuda..instrumentos_soma where InTipSOMA = 'FLI' 

   DELETE #Detalle_FLIT_MP --dbo.DETALLE_FLI
   FROM MDBL 
   WHERE (Documento = blnumdocu 
   AND Correlativo = blcorrela 
   AND blusuario = Usuario)
   AND  Usuario   = @gsbac_user
   AND  Tipooper  = @TipOper
   
 
   -- Eliminar todas las #Detalle_FLIT_MP con 
   -- Clasif_Riesgo = 'A' o Clasif_Riesgo = 'AA'
   --Elimina todos los registros de la temporal que sean letra 20 qu no tengan clasificación A o AA
   
   -- Req: Eleiminar todas las letras que no sean A y no sean AA
   --                                     no ( Sean A o sea AA )
   DELETE #Detalle_FLIT_MP 
   WHERE InCodigo = 20 
   AND Usuario = @gsbac_user
   AND  Tipooper  = @TipOper
   AND  not   (    Clasif_Riesgo <> 'A' 
                OR Clasif_Riesgo <> 'AA')



   -- Rescate de HC para Letras
   UPDATE #Detalle_FLIT_MP --HairCut
   SET HairCut = ISNULL(( SELECT hchaircut 
                 	  FROM 	 BacParamSuda..HAIRCUT_SOMA 
                  	  WHERE  hcincodigo = InCodigo	
                          and 	 hcClasificacionRiesgo = Clasif_Riesgo
                          and 	 hctipoper = @TipOper),0.0)
   WHERE InCodigo = 20 -- Solo para Letras A y AA 
   AND Usuario = @gsbac_user 
   AND  Tipooper  = @TipOper
   
   UPDATE #Detalle_FLIT_MP --  Margen 
   SET PLAZO = (PLAZO/360)
   WHERE Tipooper = @TipOper AND  InUnidadTiempoTasaRef ='ANO'
   AND Usuario = @gsbac_user 


   UPDATE #Detalle_FLIT_MP --  Margen 
   SET  Margen = ISNULL((SELECT MARG.MARGEN
		 	 FROM   BacParamSuda.dbo.MARGEN_INSTRUMENTO_SOMA MARG
    		 	 WHERE  MARG.Codigo_Instrumento = #Detalle_FLIT_MP.InCodigo 
		 	 AND    MARG.Tipo_OpSoma = @TipOper 
		 	 AND    PLAZO BETWEEN MARG.Plazo_Desde AND  MARG.Plazo_Hasta),1.0) 
   WHERE InCodigo <> 20 
   AND Usuario = @gsbac_user 
   AND  Tipooper  = @TipOper

   
   UPDATE #Detalle_FLIT_MP --  Margen 
   SET  Margen = ISNULL((SELECT MARG.MARGEN
		 	 FROM   BacParamSuda.dbo.MARGEN_INSTRUMENTO_SOMA MARG
    		 	 WHERE  MARG.Codigo_Instrumento = InCodigo 
		 	 AND    Clasificacion_Riesgo = Clasif_Riesgo
		 	 AND    MARG.Tipo_OpSoma = @TipOper 
		 	 AND    PLAZO BETWEEN Plazo_Desde AND  Plazo_Hasta),1.0) 
   WHERE InCodigo = 20 
   AND Usuario = @gsbac_user 
   AND  Tipooper  = @TipOper


   UPDATE #Detalle_FLIT_MP --  Actualiza Tasa Referencial(Tasa_Venta)Soma tabla temporal Detalle_Fli
   SET  Tasa_Venta = ((ISNULL((	SELECT TASA_REF.trtasareferencial
		 	  	FROM   BacParamSuda.dbo.TASA_REFERENCIA_SOMA TASA_REF
    		 	  	WHERE  TASA_REF.trincodigo  = InCodigo
				AND    TASA_REF.trserie = Serie
		 	  	AND    TASA_REF.trClasificacionriesgo = Clasif_Riesgo
		 	  	AND    Tasa_Ref.trtipoper = @TipOper ),0.0))
		      + 
			
		     (ISNULL(( 	SELECT hchaircut 
                 	  	FROM   BacParamSuda..HAIRCUT_SOMA 
                  	  	WHERE  hcincodigo = InCodigo	
                          	AND    hcClasificacionRiesgo = Clasif_Riesgo
                          	AND    hctipoper = @TipOper),0.0))) 
   WHERE Tipooper = @TipOper 
   AND Usuario = @gsbac_user 
   AND  Tipooper  = @TipOper
  

   DELETE #Detalle_FLIT_MP
   FROM MDBL
   WHERE (Documento = blnumdocu 
   AND Correlativo = blcorrela 
   AND blusuario = Usuario)
   AND  Usuario   = @gsbac_user


   DELETE 
   FROM  dbo.DETALLE_FLI
   WHERE Usuario = @gsbac_user
   AND Ventana = @hWnd		

    INSERT INTO dbo.DETALLE_FLI  -- select * from detalle_FLI
   (   Usuario
   ,   Marca
   ,   Documento
   ,   Correlativo
   ,   Serie
   ,   Moneda
   ,   Nominal_Compra
   ,   Tasa_Compra
   ,   Valor_Par
   ,   Valor_Presente
   ,   Margen
   ,   Valor_Inicial
   ,   Nominal_Venta
   ,   Tasa_Venta
   ,   vPar_Venta
   ,   vPresente_Venta
   ,   vInicial_Venta
   ,   Plazo
   ,   Ventana
   ,   CarteraSuper 
   ,   BloqueoPacto    -- PRD-6005  
   ,   HairCut         -- PRD-6007
   ,   Tipoper         -- PRD-6007
   ,   Rut_Emisor      -- PRD-6006
   ) 

  SELECT DISTINCT 
	  Usuario            =  Usuario 
   ,      Marca              =  Marca
   ,      Documento          =  Documento
   ,      Correlativo        =  Correlativo
   ,      Serie              =  Serie
   ,      Moneda             =  Moneda
   ,      Nominal_Compra     =  Nominal_Compra                               
   ,      Tasa_Compra        =  Tasa_Compra 
   ,      Valor_Par          =  Valor_Par
   ,      Valor_Presente     =  Valor_Presente                                                           
   ,      Margen             =  Margen
   ,      Valor_Inicial      =  Valor_Inicial                             
   ,      Nominal_Venta      =  Nominal_Venta
   ,      Tasa_Venta         =  Tasa_Venta
   ,      vPar_Venta         =  vPar_Venta
   ,      vPresente_Venta    =  vPresente_Venta
   ,      vInicial_Venta     =  vInicial_Venta
   ,      Plazo              =  Plazo 
   ,      Ventana            =  Ventana
   ,   	  carterasuper	     =  carterasuper
   ,      BloqueoPacto       =  BloqueoPacto             -- PRD-6005
   ,      HairCut            =  HairCut           -- PRD-6007
   ,      Tipoper            = 	Tipooper
   ,      Rut_Emisor         =  Rut_Emisor
   FROM   #Detalle_FLIT_MP



   SELECT Serie    = Serie
   ,      Moneda   = Moneda
   ,      Nominal  = SUM( Nominal_Compra )
-- ,      Tir      = AVG( Tasa_Compra )     -- PROD-6007 HairCut, Aplicar Tasa Referencia, única para la serie
   ,      Tir      = Tasa_venta --Tasa_Compra              -- PROD-6007 HairCut, Aplicar Tasa Referencia, única para la serie

   ,      vPar     = AVG( Valor_Par )
   ,      vPresent = SUM( Valor_Presente )
   ,      Plazo    = Plazo
   ,      Margen   = Margen                  --  PRD-6007  antes AVG( Margen )
   ,      vinicial = SUM( Valor_Inicial )
   ,      Cartera  = CarteraSuper
   ,      IDENTITY(NUMERIC(10))  AS Registro
   ,      BloqueoPacto  = SUM(BloqueoPacto)  -- PRD-6005
   ,      HairCut       = HairCut            -- PRD-6007 
   ,      Rut_Emisor    = Rut_Emisor    -- PRD-6006
   INTO   #TemporalFli
   FROM   dbo.DETALLE_FLI
   WHERE  Marca    = 'N'
   AND    Ventana  = @hWnd
   AND    Usuario  = @gsbac_user
   --GROUP BY CarteraSuper, Serie, Moneda, Plazo, Margen, HairCut, Tasa_Compra , Rut_Emisor -- PRD-6007 Haircut Aplicar Tasa Referencia
   GROUP BY CarteraSuper, Serie, Moneda, Plazo, Margen, HairCut, Tasa_Venta , Rut_Emisor
	DECLARE @Registro NUMERIC(10)

   CREATE INDEX #Ix002_Optimiza ON #TemporalFLI (registro )

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

		DECLARE	@nNumucup	INTEGER		,
			@cFecucup	CHAR(10)	,
			@cFecpcup	CHAR(10)	,
			@fDurat		FLOAT		,
			@fConvx		FLOAT		,
			@fDurmo		FLOAT 		,
			@nrutemi	NUMERIC(9)	,
			@modcal 	SMALLINT	


		DECLARE @estado INTEGER;
	
	DECLARE @itotal  INTEGER 
	DECLARE @imenor  INTEGER 

	SET @itotal = (SELECT MAX(registro) FROM #TemporalFli)
	SET @imenor = (SELECT MIN(registro) FROM #TemporalFli)


	WHILE  1 = 2 --@itotal >= @imenor  -- 6007 se valorizará solamente lo que se compra
	BEGIN 

	 SELECT	@Serie		= serie		,  
		@registro	= registro	,
		@Nominal	= Nominal       ,         -- PRD-6005
--		@fmt		= vPresent	,         -- PROD 6007 Aplicar HairCut
		@fmt		= 0     	,         -- PROD 6007 Aplicar HairCut
                @ftir           = Tir  -- + HairCut       -- PROD 6007 Aplicar HairCut -- se sumó arriba
	   FROM #TemporalFli
	  WHERE registro	=@imenor

        if @nominal <> 0     
        BEGIN 		
		SET @mascara  = @serie
		

	     /* ________________________________________________________________________________________________}
		Cargo datos de las series para poder valorizar							|
		================================================================================================} */
		DELETE FROM #DatosSerie;

		INSERT INTO #DatosSerie		
		EXECUTE sp_chkinstser @mascara;


		SELECT 	@mascara=cmascara	,
			@imonemi=nmonemi	,
			@icodigo=codigo		,
			@dFecemi=CONVERT(CHAR(10),CONVERT(DATETIME,dFecemi,103),112),
			@dFecven=CONVERT(CHAR(10),CONVERT(DATETIME,dFecven,103),112),
			@ftasemi=ftasemi	,
			@fbasemi=nbasemi	,
			@ftasest=0.0		,
			@fnominal=@nominal	,
--			@ftir=0.0		,    -- PROD 6007 Aplicar HairCut, se valoriza por tasa
			@fpvp=0.0		,
--			@fmt=@fmt		,    -- PROD 6007 Aplicar HairCut, se valoriza por tasa
			@fmt=0.0		,    -- PROD 6007 Aplicar HairCut, se valoriza por tasa

			@nrutemi=nrutemi	
		FROM #DatosSerie;		

                -- PROD 6007 Aplicar Hair-Cut
                -- La primera valorización debe ser por indicación de tasa ref + Haircut
                -- no por el valor presente 
		-- SET @modcal=3
                -- Faltaria aplicar los efectos del margen 
                SET @modcal=2

	SET @dfeccal = CONVERT(CHAR(10),@acfecproc,112);


      

	DELETE FROM #Valorizacion;

	INSERT INTO  #Valorizacion
	EXECUTE sp_valorizar_client
		@modcal,
		@dfeccal,
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

	SELECT 	@fmt = FMT 		,
		@fPvp= fPvp		,
		@nNumucup=nNumucup 	,
		@cFecucup=cFecucup 	,
		@cFecpcup=cFecpcup 	,
		@fDurat=fDurat		,
		@fConvx=fConvx		,
			@fDurmo=fDurmo       --	,  -- PROD 6007	 
	-- PROD 6007 Aplicar HairCut, se valoriza por tasa
	--		@fTir =CAST(fTir AS NUMERIC(10,4))

	FROM #Valorizacion;

	--	UPDATE 	#TemporalFli SET tir = @fTir, vpar=@fPvp   -- PROD 6007 Aplicar HairCut
		UPDATE 	#TemporalFli SET  vpar=@fPvp               -- PROD 6007 Aplicar HairCut
                                , vPresent = @fmt          -- PROD 6007 Aplicar HairCut
                                , vInicial = @fmt * Margen -- PROD 6007 Aplicar HairCut
	WHERE registro=@registro


	UPDATE dbo.DETALLE_FLI
	SET Valor_Presente = @fmt * ( nominal_compra / @nominal )
	            , Valor_Inicial  = @fmt * Margen * ( nominal_compra / @nominal )   -- PROD 6007 Aplicar HairCut 
	            , Valor_Par      = @fPvp                                           -- PROD 6007 Aplicar HairCut
	WHERE  Marca    = 'N'
	AND    Ventana  = @hWnd
	AND    Usuario  = @gsbac_user
	AND    serie    = @Serie
		
	END -- IF Nominal <> 0	

	SET @imenor=@imenor+1		
	
END 
-----------------------------
/****20190119.RCH.FLI***********/
IF (@FLI_Familia !='')
BEGIN
	IF (@FLI_Familia='TGR')

		   SELECT Serie 
		   ,      Moneda
		   ,      Case when Nominal < 0 then 0 else Nominal end
		   ,      CAST( ( Tir - HairCut) AS NUMERIC(10,4))   -- PROD-6007 Por presentación, se seprar el Haircut. 
		   ,      vPar
		   ,      Case when Nominal < 0 then 0 else vPresent end
		   ,      Plazo 
		   ,      Margen
		   ,      Case when Nominal < 0 then 0 else vinicial end
			,      tbglosa
			,      cartera  --> Corresponde al código de Cartera
		   ,      BloqueoPacto  -- PRD-6005
		   ,      HairCut       -- PRD-6007
		   ,      Rut_Emisor    -- PRD-6006  será necesario llenar la grilla 
		   ,	  EmGeneric     = isnull( ( select max( A.emgeneric ) 
											from BACPARAMSUDA..EMISOR A WITH(NOLOCK) 
											where RUT_EMISOR = A.EMRUT) , 'N/E' )  
		   FROM #TemporalFli
			INNER JOIN VIEW_TABLA_GENERAL_DETALLE ON tbcateg = '1111' AND tbcodigo1 = Cartera
		  WHERE   Rut_Emisor = @RutTGR 
		ORDER BY 
				serie, tbglosa 
	ELSE  
		   SELECT Serie 
		   ,      Moneda
		   ,      Case when Nominal < 0 then 0 else Nominal end
		   ,      CAST( ( Tir - HairCut) AS NUMERIC(10,4))   -- PROD-6007 Por presentación, se seprar el Haircut. 
		   ,      vPar
		   ,      Case when Nominal < 0 then 0 else vPresent end
		   ,      Plazo 
		   ,      Margen
		   ,      Case when Nominal < 0 then 0 else vinicial end
			,      tbglosa
			,      cartera  --> Corresponde al código de Cartera
		   ,      BloqueoPacto  -- PRD-6005
		   ,      HairCut       -- PRD-6007
		   ,      Rut_Emisor    -- PRD-6006  será necesario llenar la grilla 
		   ,	  EmGeneric     = isnull( ( select max( A.emgeneric ) 
											from BACPARAMSUDA..EMISOR A WITH(NOLOCK) 
											where RUT_EMISOR = A.EMRUT) , 'N/E' )  
		   FROM #TemporalFli
			INNER JOIN VIEW_TABLA_GENERAL_DETALLE ON tbcateg = '1111' AND tbcodigo1 = Cartera
		 WHERE   Rut_Emisor = @RutBCCH 
			ORDER BY serie, tbglosa  
END		
       
   
END
GO
