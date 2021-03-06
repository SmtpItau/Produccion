USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARVI]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABARVI]
			(
			@nNumoper	NUMERIC	(10,0)  ,  -- numero de operaci«n de venta
			@nRutcart	NUMERIC	(09,0)  ,  -- rut de la cartera
			@cTipcart	NUMERIC	(05,0)  ,  -- codigo del tipo de cartera
			@nNumdocu	NUMERIC	(10,0)  ,  -- numero del documento
			@nCorrela	NUMERIC	(03,0)  ,  -- correlativo de la operaci«n
			@nNominal	NUMERIC	(19,4)  ,  -- nominales vENDidos
			@nTir		NUMERIC	(19,4)  ,  -- tir de venta
			@nPvp		NUMERIC	(19,2)  ,  -- porcentaje valor par (v)
			@nVptirv	FLOAT		,  -- valor presente a tir de venta(v)
			@nVp100		FLOAT		,  -- valor presente venta en base 100 (v)
			@nTasest	NUMERIC	(09,4)	,  -- tasa estimada (v)
			@nVpar		NUMERIC	(19,8)	,  -- valor par (v)          
			@nNumucup	NUMERIC	(03,0)	,  -- numero del oltimo cup«n vencido (v)
			@nRutcli	NUMERIC	(09,0)	,  -- rut del cliente (v)
			@nCodcli	NUMERIC	(09,0)	,  -- rut del cliente (v)
			@cTipcust	CHAR	(03)	,  -- tipo de custodia
			@nForpagi	NUMERIC	(05,0)	,  -- forma de pago al inicio
			@nForpagv	NUMERIC	(05,0)	,  -- forma de pago al vencimiento
			@cRetiro	CHAR	(01)	,  -- tipo de retiro
			@cUsuario	CHAR	(12)	,  -- usuario
			@cTerminal	CHAR	(12)	,  -- terminal
			@cFecvtop	CHAR	(10)	,  -- fecha de vencimiento del pacto
			@nMonpact	NUMERIC	(3,0)	,  -- moneda del pacto 
			@nTaspact	NUMERIC	(9,4)	,  -- tasa del pacto
			@nBaspact	NUMERIC	(3,0)	,  -- base del pacto
			@nValinip	NUMERIC	(19,4)	,  -- valor inicial del pacto en moneda del pacto
			@nValvtop	NUMERIC (19,04) ,  -- valor vencimiento del pacto en moneda del pacto*
			@cInstser	CHAR	(12)	,  -- serie
			@nRutemi	NUMERIC	(09,00)	,  -- rut del emisor
			@nMonemi	NUMERIC	(03,00)	,  -- moneda de emisi«n
			@dFecemi	DATETIME	, -- fecha de emisi«n  *
			@dFecven	DATETIME	,  -- feeeeeeeeeeeecha de vcto. *
			@nCorrvent	NUMERIC	(03,0)	,  -- correlativo venta con pacto
			@dFecpcup	DATETIME	,  -- fecha de proximo cupon 	*
			@dConvex	FLOAT		,
			@dDurmod	FLOAT		,
			@dDurmac	FLOAT		,
			@cCustodia	CHAR	(01)	,
			@cClavedcv	CHAR	(15)	,
			@fTotalpfe	FLOAT		,
			@fTotalcce	FLOAT		,
			@codigo_carterasuper		CHAR	(01)	,
			@tipo_cartera_financiera	CHAR	(01)	,
			@mercado			CHAR	(01)	,
			@sucursal			VARCHAR	(05)	,
			@id_sistema			CHAR	(03)	,
			@fecha_pagomañana		DATETIME	,
			@laminas			CHAR	(01)	,
			@tipo_inversion			CHAR	(01)	,
			@cuenta_corriente_inicio	CHAR	(15)	,
			@sucursal_inicio		VARCHAR	(05)	,
			@cuenta_corriente_final		CHAR	(15)	,
			@sucursal_final			VARCHAR	(05)	,
			@observacion			CHAR	(70)    ,
                        @precio_transferencia           FLOAT           ,
                        @codigo_area                    VARCHAR (05)    ,
                        @codigo_corresponsal_bco        VARCHAR (20)    = '',
                        @codigo_corresponsal_cli        VARCHAR (20)    = '',
                        @deskmngr_keyid                 NUMERIC (09)    = 0 ,
                        @deskmngr_libro                 INTEGER         = 0 ,
                        @libro_transferencia           FLOAT  = 0          ,
                        @interes_transferencia	        FLOAT  = 0	,
			@nNominal_FLI			NUMERIC(22,4) = 0,
			@cTipo_Operacion		VARCHAR(03)=' '
			)
AS
BEGIN

    SET TRANSACTION ISOLATION LEVEL READ COMMITTED
    SET DATEFORMAT dmy
    SET NOCOUNT ON

	--* variables para obtener datos de la tabla CARTERA_DISPONIBLE

	DECLARE	@fcapitalc	NUMERIC(19,4)	-- capitaldela compra CARTERA_DISPONIBLE actual     a tasa compra
	DECLARE	@finteresc	NUMERIC(19,4)	-- intereses de la compra CARTERA_DISPONIBLE actuales a tasa compra
	DECLARE	@freajustc	NUMERIC(19,4)	-- reajustes de la compra CARTERA_DISPONIBLE actuales a tasa compra
	DECLARE	@fcapitalci	NUMERIC(19,4)	-- capital de la compra CARTERA_DISPONIBLE actual     a tasa pacto
	DECLARE	@finteresci	NUMERIC(19,4)	-- intereses de la compra CARTERA_DISPONIBLE actuales a tasa pacto
	DECLARE	@freajustci	NUMERIC(19,4)	-- reajustes de la compra CARTERA_DISPONIBLE actuales a tasa pacto
	DECLARE	@fNominal	NUMERIC(19,4)	-- nominales disponibles CARTERA_DISPONIBLE actuales 
	DECLARE	@ncapitalc	NUMERIC(19,4)	-- nuevo capital disponible a tasa compra
	DECLARE	@ninteresc	NUMERIC(19,4)	-- nuevos intereses CARTERA_DISPONIBLE    a tasa compra
	DECLARE	@nreajustc	NUMERIC(19,4)	-- nuevos reajustes CARTERA_DISPONIBLE    a tasa compra
	DECLARE	@ncapitalci	NUMERIC(19,4)	-- nuevo capital disponible a tasa pacto
	DECLARE	@ninteresci	NUMERIC(19,4)	-- nuevos intereses CARTERA_DISPONIBLE    a tasa pacto
	DECLARE	@nreajustci	NUMERIC(19,4)	-- nuevos reajustes CARTERA_DISPONIBLE    a tasa pacto 
	DECLARE	@ctipoper	CHAR(03)	-- tipo operaci«n 'cp' « 'ci'

	DECLARE @fFactor	FLOAT
	DECLARE @xFactor	FLOAT

	--* variables para obtener datos de la tabla CARTERA_PROPIA / CARTERA_COMPRA_PACTO

        DECLARE	@fcapitalo	NUMERIC(19,4)	-- capital de la compra a tasa compra
        DECLARE	@fintereso	NUMERIC(19,4)	-- intereses de la compra a tasa compra
        DECLARE	@freajusto	NUMERIC(19,4)	-- reajustes de la compra a tasa compra
        DECLARE	@fNominalo	NUMERIC(19,4)	-- nominales originales
        DECLARE	@fcapitaloci	NUMERIC(19,4)	-- capital de la compra   a tasa pacto
        DECLARE	@finteresoci	NUMERIC(19,4)	-- intereses de la compra a tasa pacto
        DECLARE	@freajustoci	NUMERIC(19,4)	-- reajustes de la compra a tasa pacto
	DECLARE @fNominalp	NUMERIC(19,4)	-- nominal $$ de la ci
	DECLARE @fvalcomp	NUMERIC(19,4)	-- capital $$
	DECLARE @fvalcompori	NUMERIC(19,4)	-- capital $$
	DECLARE @fvalcomu	NUMERIC(19,4)	-- capital um
	DECLARE	@ncapitalo	NUMERIC(19,4)	-- nuevo capital de la compra   a tasa compra
	DECLARE	@nintereso	NUMERIC(19,4)	-- nuevo intereses de lacompra a tasa compra
	DECLARE	@nreajusto	NUMERIC(19,4)	-- nuevo reajustes de la compra a tasa compra
	DECLARE @nNominalp 	NUMERIC(19,0)   -- nuevo capital nominal $$ ci
	DECLARE	@ncapitaloci	NUMERIC(19,4)	-- nuevo capital de la compra   a tasa pacto
	DECLARE	@ninteresoci	NUMERIC(19,4)	-- nuevo intereses de la compra a tasa pacto
	DECLARE	@nreajustoci	NUMERIC(19,4)   -- nuevo reajustes de la compra a tasa pacto

	DECLARE @nvalcomuo	NUMERIC(19,4)	-- nuevo capital um CARTERA_PROPIA original
	DECLARE @nvalcompo	NUMERIC(19,4)	-- nuevo capital $$ CARTERA_PROPIA original
	DECLARE @nvalcompvo	NUMERIC(19,4)	-- capital $$ venta
	DECLARE @nvalcomuvo	NUMERIC(19,4)	-- capital um venta
	DECLARE @fvalcompo	NUMERIC(19,4)	-- capital $$ venta
	DECLARE @fvalcomuo	NUMERIC(19,4)	-- capital um venta
	DECLARE @nfeccompo      DATETIME
	DECLARE @nTircompo      NUMERIC(8,4)
	DECLARE @nVparo         NUMERIC(19,4)
	DECLARE @nPvparo        NUMERIC(8,4)

	DECLARE	@valvenc	NUMERIC(19,6)	-- 


	--* datos referenciales en regla 3
	DECLARE	@nvptirc	NUMERIC(19,4)	-- valor presente a tir compra en funcion de los nomimales intermediados
	DECLARE	@nvptirci	NUMERIC(19,4)	-- valor presente a tasa de compra con pacto  en funcion de los nomimales intermediados
	DECLARE	@nNumucupc	NUMERIC(3,0)	-- numero del ultimo cupon vencido a la fecha de compra

	--* datos complementarios
	DECLARE	@nNumdocuo	NUMERIC(10,0)	-- numero de documento original
	DECLARE	@nCorrelao	NUMERIC(3,0)	-- correlativo original
	DECLARE	@cmascara	CHAR(12)	-- serie generica del instrumento
	DECLARE	@ncodigo	NUMERIC(3,0)	-- c«digo de la familia
	DECLARE	@cseriado	CHAR(1)		-- indica si es seriado o no
	DECLARE	@ntasemi	NUMERIC(9,4)	-- tasa de emisi«n
	DECLARE	@nbasemi	NUMERIC(3,0)    -- base emisi«n

	--** base de emisi¢n
	DECLARE	@chora		VARCHAR(15)	-- hora
	DECLARE	@dfecpro	DATETIME	-- fecha de proceso
	DECLARE	@dfecvtop	DATETIME	-- fecha de vencimiento del pacto
	DECLARE	@cok		INTEGER
	DECLARE	@nTirc		NUMERIC(08,04)	-- tir de compra.
	DECLARE	@dfeccomp	DATETIME	-- fecha de compra.
	DECLARE @dfecucup	DATETIME	-- ultimo cup«n pagado
	DECLARE	@nvalcomp	NUMERIC(19,04)	-- valor de compra.
	DECLARE	@nvalcompori	NUMERIC(19,04)	-- valor de compra.
	DECLARE	@nvalcomu	NUMERIC(19,04)	-- valor de compra um.
	DECLARE	@nvalmon	NUMERIC(19,04)	-- valor de moneda (pacto)
        DECLARE @cTipo_Moneda   CHAR(01)  --Si es extranjera
        DECLARE @cTipo_Moneda_papel   CHAR(01)  --Si es extranjera
        DECLARE @vptircomp      NUMERIC(19,4)
        DECLARE @tircomp        FLOAT
        DECLARE @vmonto_Traspaso FLOAT                   ,
                @vDiferencia_Traspaso FLOAT              ,
                @monto_Traspaso FLOAT                   ,
                @Diferencia_Traspaso FLOAT              ,
                @Tir_Traspaso Float                    ,
                @Libro_Origen_Traspaso  INT

	SELECT	@nNominalp	= 0.0					,
		@nvalmon	= 1.0					,
		@chora		= CONVERT(CHAR(15),GETDATE(),114)

        SELECT @dfecpro		= Fecha_proceso FROM VIEW_DATOS_GENERALES

        SELECT  @cTipo_Moneda = mnextranj
        FROM    VIEW_MONEDA
        WHERE   mncodmon = @nMonpact


	IF @nMonpact=999 
		SELECT	@nValvtop	= ROUND(@nValvtop,0)
	ELSE IF @ctipo_moneda <> '0' BEGIN
		SELECT	@nvalmon	= vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nMonpact AND vmfecha=@dfecpro
        END 

	SELECT	@dfecvtop	= CONVERT(DATETIME,@cFecvtop,101)

	SELECT	@fcapitalc	= dicapitalc		,
		@finteresc	= diinteresc		,
		@freajustc	= direajustc		,
		@fNominal	= dinominal		,
		@fcapitalci	= dicapitaci		,
		@finteresci	= diintereci		,       
		@freajustci	= direajusci		,
		@ctipoper	= RTRIM(ditipoper),
                @vptircomp      = divptirc,
                @tircomp        = ditircomp

	FROM	CARTERA_DISPONIBLE WITH (NOLOCK)
	WHERE	dirutcart=@nRutcart AND dinumdocu=@nNumdocu AND dicorrela=@nCorrela

	SELECT	@fFactor	= 1.0 - ( @nNominal / @fNominal )
	SELECT	@xFactor	= @nNominal / @fNominal


	SELECT	@ncapitalc	= ROUND(@fcapitalc * @fFactor,0)
	SELECT	@ninteresc	= ROUND(@finteresc * @fFactor,0)
	SELECT	@nreajustc	= ROUND(@freajustc * @fFactor,0)
	SELECT	@ncapitalci	= ROUND(@fcapitalci * @fFactor,0)
	SELECT	@ninteresci	= ROUND(@finteresci * @fFactor,0)
	SELECT	@nreajustci	= ROUND(@freajustci * @fFactor,0)
	SELECT  @nvptirci       = @ncapitalci + @ninteresci + @nreajustci


	UPDATE	CARTERA_DISPONIBLE WITH (ROWLOCK)
	SET 	dinominal	= @fNominal - CASE WHEN @nNominal_FLI = 0 THEN @nNominal ELSE 0 END,
		dicapitalc	= CASE WHEN @nNominal_FLI = 0 THEN @ncapitalc ELSE dicapitalc END,
		diinteresc	= CASE WHEN @nNominal_FLI = 0 THEN @ninteresc ELSE diinteresc END,
		direajustc	= CASE WHEN @nNominal_FLI = 0 THEN @nreajustc ELSE direajustc END,
		divptirc	= CASE WHEN @nNominal_FLI = 0 THEN @ncapitalc + @ninteresc + @nreajustc ELSE divptirc END,
		dicapitaci	= CASE WHEN @nNominal_FLI = 0 THEN @ncapitalci ELSE dicapitaci END,
		diintereci	= CASE WHEN @nNominal_FLI = 0 THEN @ninteresci ELSE diintereci END,
		direajusci	= CASE WHEN @nNominal_FLI = 0 THEN @nreajustci ELSE direajusci END,
		divptirci	= CASE WHEN @nNominal_FLI = 0 THEN @nvptirci ELSE divptirci END,
		monto_fli	= isnull(monto_fli,0) + @nNominal_FLI
	WHERE	dirutcart=@nRutcart AND dinumdocu=@nNumdocu AND dicorrela=@nCorrela
 
	SELECT	@nvalcomp	= 0.0	,
		@nvalcomu	= 0.0	,
		@dfecucup	= ''	,
		@fNominalp	= 0	,
		@nNominalp	= 0

	IF @ctipoper='CP'
	BEGIN
		SELECT  @fcapitalo	= cpcapitalc	,
			@fintereso	= cpinteresc	,
			@freajusto	= cpreajustc	,
			@fcapitaloci	= 0		,
			@finteresoci	= 0		,
			@freajustoci	= 0		,
			@fNominal	= cpnominal	,
			@nNumdocuo	= cpnumdocuo	,
			@nCorrelao	= cpcorrelao	,
			@cInstser	= cpinstser	,
			@cmascara	= cpmascara	,
			@ncodigo	= cpcodigo	,
			@cseriado	= cpseriado	,
			@dFecemi	= cpfecemi	,
			@dFecven	= cpfecven	,
			@nNumucupc	= cpnumucup	,
			@nTirc		= cptircomp	,
			@dfeccomp	= cpfeccomp	,
			@fvalcomp	= cpvalcomp	,
			@fvalcomu	= cpvalcomu	,
			@dfecucup	= cpfecucup     ,
			@fvalcompori	= cpvcompori	,
			@fvalcomuo	= valor_compra_um_original  ,
			@fvalcompo	= valor_compra_original     ,
			@nfeccompo      = fecha_compra_original     ,
			@nTircompo      = tir_compra_original       ,
			@nVparo         = valor_par_compra_original ,
			@nPvparo        = porcentaje_valor_par_compra_original ,
                        @valvenc        = cpvalvenc,
                        @Tipo_Inversion = Tipo_Inversion,
			@tipo_cartera_financiera = Tipo_Cartera_Financiera,
                        @tir_Traspaso    = Tir_traspaso,
                        @Libro_Origen_Traspaso = Libro_Origen_Traspaso,
                        @monto_Traspaso  = monto_traspaso,
                        @Diferencia_Traspaso = Diferencia_traspaso
		FROM	CARTERA_PROPIA WITH (NOLOCK)
		WHERE	cprutcart=@nRutcart AND cpnumdocu=@nNumdocu AND cpcorrela=@nCorrela

		SELECT	@ncapitalc	= ROUND(@fcapitalc   * @fFactor,0)
		SELECT	@ninteresc	= ROUND(@finteresc   * @fFactor,0)
		SELECT	@nreajustc	= ROUND(@freajustc   * @fFactor,0)
		SELECT	@nvalcomp	= ROUND(@fvalcomp    * @fFactor,0)
		SELECT	@nvalcompori	= ROUND(@fvalcompori * @fFactor,0)
		SELECT	@nvalcomu	= ROUND(@fvalcomu    * @fFactor,4)

		SELECT  @nvalcomuo	= ROUND(@fvalcomuo * @fFactor,4)--29/01/2001
		SELECT  @nvalcompo	= ROUND(@fvalcompo * @fFactor,0)--29/01/2001
                SELECT  @vmonto_Traspaso = ROUND(@monto_traspaso * @fFactor,0)
                SELECT  @vDiferencia_Traspaso = ROUND(@Diferencia_traspaso * @fFactor,0)
        
		IF @nNominal_FLI = 0
		UPDATE	CARTERA_PROPIA WITH (ROWLOCK)
  		SET	cpnominal			= @fNominal - @nNominal,
			cpvalcomp			= @nvalcomp 				,
			cpvalcomu			= @nvalcomu				,
			cpcapitalc			= @ncapitalc				,
			cpinteresc			= @ninteresc				,
			cpreajustc			= @nreajustc				,
			cpvptirc			= @nvalcomp + @ninteresc + @nreajustc	,
			cpvcompori			= @nvalcompori,
			valor_compra_um_original	= @nvalcomuo,
         		valor_compra_original		= @nvalcompo,
                        monto_traspaso                  = @monto_traspaso - @vmonto_Traspaso	,
                        Diferencia_traspaso             = @Diferencia_traspaso - @vDiferencia_Traspaso
        	WHERE	cprutcart=@nRutcart AND cpnumdocu=@nNumdocu AND cpcorrela=@nCorrela
	END
        ELSE
	BEGIN
		SELECT  @fcapitalo	= cicapitalc	,
			@fintereso	= ciinteresc	,
			@freajusto	= cireajustc	,
			@fcapitaloci	= cicapitalci	,
			@finteresoci	= ciinteresci	,
			@freajustoci	= cireajustci	,
			@fNominal	= cinominal	,
			@nNumdocuo	= cinumdocuo	,
			@nCorrelao	= cicorrelao	,
			@cInstser	= ciinstser	,
			@cmascara	= cimascara	,
			@ncodigo	= cicodigo	,
			@cseriado	= ciseriado	,
			@dFecemi	= cifecemi	,
			@dFecven	= cifecven	,
			@nTirc		= citircomp 	,
			@nNumucupc	= cinumucup	,
			@fNominalp	= cinominalp	,
			@fvalcomuo	= valor_compra_um_original  ,
			@nvalcomuo	= valor_compra_um_original  ,
			@fvalcomuo	= valor_compra_um_original  ,
			@fvalcompo	= valor_compra_original     ,
			@nvalcompo	= valor_compra_original     ,
			@nfeccompo      = fecha_compra_original     ,
			@nTircompo      = tir_compra_original       ,
			@nVparo         = valor_par_compra_original ,
			@nPvparo        = porcentaje_valor_par_compra_original ,
                        @valvenc        = civalvenc ,
                        @Tipo_Inversion = Tipo_Inversion ,
			@dfeccomp	= cifeccomp	,
			@fvalcomp	= civalcomp	,
			@fvalcomu	= civalcomu	,
			@tipo_cartera_financiera = Tipo_Cartera_Financiera,
                        @tir_Traspaso    = 0,
                        @Libro_Origen_Traspaso = 0,
                        @monto_Traspaso  = 0,
                        @Diferencia_Traspaso = 0
		FROM	CARTERA_COMPRA_PACTO WITH (NOLOCK)
		WHERE	cirutcart=@nRutcart AND cinumdocu=@nNumdocu AND cicorrela=@nCorrela

		SELECT	@xFactor	= @nNominal /  @fNominal
		SELECT	@nNominalp	= ISNULL(ROUND(@fNominalp * @xFactor,0),0)
		SELECT	@nvalcomu	= ISNULL(ROUND(@fvalcomu    * @fFactor,4),0)

		SELECT	@ncapitalc	= ROUND(@fcapitalc   * @fFactor,0)
		SELECT	@ninteresc	= ROUND(@finteresc   * @fFactor,0)
		SELECT	@nreajustc	= ROUND(@freajustc   * @fFactor,0)
		SELECT	@nvalcomp	= ROUND(@fvalcomp    * @fFactor,0)
		SELECT	@nvalcompori	= ROUND(@fvalcompori * @fFactor,0)
		SELECT	@nvalcomu	= ROUND(@fvalcomu    * @fFactor,4)

		SELECT  @nvalcomuo	= ROUND(@fvalcomuo * @fFactor,4)
		SELECT  @nvalcompo	= ROUND(@fvalcompo * @fFactor,0)
                SELECT  @vmonto_Traspaso = 0
                SELECT  @vDiferencia_Traspaso = 0


	END
	/*------------------------------------------------------
		 nominal, capital, intereses y reajustes a MOVIMIENTO_DIA_TRADER y CARTERA_VENTA_PACTO	
        --------------------------------------------------------*/


	SELECT	@fFactor	= @nNominal / @fNominal
	SELECT	@ncapitalo	= @fcapitalo   - @ncapitalc
	SELECT	@nintereso	= @fintereso   - @ninteresc
	SELECT	@nreajusto	= @freajusto   - @nreajustc
	SELECT	@nvptirc	= @ncapitalo+@nintereso+@nreajusto
--	SELECT	@nNominalp	= @fNominalp   - @nNominalp
	SELECT	@ncapitaloci	= 0
	SELECT	@ninteresoci	= 0
	SELECT	@nreajustoci	= 0

	SELECT	@nvalcomp	= ISNULL(@fvalcomp    - @nvalcomp,0)
	SELECT	@nvalcomu	= ISNULL(ROUND( @fvalcomu - @nvalcomu , 4),0)
	SELECT	@fvalcompo	= ISNULL(@fvalcompo    - @nvalcompo,0)
	SELECT	@fvalcomuo	= ISNULL(ROUND( @fvalcomuo - @nvalcomuo , 4),0)


	IF @cseriado='S'

		SELECT	@nRutemi	= serutemi	,
			@nMonemi	= semonemi	,
			@ntasemi	= SETasemi	,
			@nbasemi	= sebasemi
		FROM	VIEW_SERIE
		WHERE	semascara=@cmascara
	ELSE

		SELECT  @nRutemi	= nsrutemi	,
			@nMonemi	= nsmonemi	,
			@ntasemi	= nstasemi	,
			@nbasemi	= nsbasemi
		FROM	NOSERIE WITH (NOLOCK)
		WHERE	@nRutcart=nsrutcart AND @nNumdocuo=nsnumdocu AND @nCorrelao= nscorrela



        IF @nnominal <> @fnominal BEGIN

                CREATE TABLE #VALORIZAR (fError INTEGER,
                          		 fNominal FLOAT,
                                         fTir  FLOAT,
                            		 fPvp  FLOAT,
                            		 fMT   FLOAT,
                            		 fMTUM FLOAT,
		                         fMT_cien FLOAT,
                                         fVan FLOAT,
                        		 Vpar FLOAT,
                   		 	 nNumucup INTEGER,
                          		 cFecucup DATETIME,
		                    	 fIntucup FLOAT,
                        		 fAmoucup FLOAT,
                        		 fSalucup FLOAT,
                            		 nNumpcup INTEGER,
                        		 cFecpcup DATETIME,
	                        	 fIntpcup FLOAT,
                            		 fAmopcup FLOAT,
                                         fSalpcup FLOAT,
                        		 fDurat  FLOAT,
                                         fConvx  FLOAT,
                                         fDurmo FLOAT)
                            
              DECLARE @FECHA_HOY CHAR(10), @FECHA_EMISION CHAR(10),@FECHA_VENC CHAR(10)
              SELECT @FECHA_HOY = CONVERT(CHAR(10),@dfecpro,112)  
              SELECT @fecha_emision = CONVERT(CHAR(10),@dfecemi,112)
              SELECT @fecha_venc = CONVERT(CHAR(10),@dfecven,112)


              INSERT #VALORIZAR  EXEC sp_valorizar_client
                                      2,
                                      @fecha_hoy,
                                      @ncodigo,
                                      @cinstser,
                                      @nmonemi,
                                      @fecha_emision,
                                      @fecha_venc,
                                      @ntasemi,
                                      @nbasemi,
                                      @ntasest,
                                      @nnominal,
                                      @tircomp ,
                                      0,  
                                      0   
           SELECT @vptircomp = fmt from #VALORIZAR            

        END


	--******************************--
	--** grabar movimiento diario **--
	--******************************--
	INSERT INTO MOVIMIENTO_TRADER WITH (ROWLOCK)
			(
			mofecpro	,
			morutcart	,
			motipcart	,
			monumdocu	,
			mocorrela	,
			monumdocuo	,
			mocorrelao	,                   
			monumoper	,
			motipoper	,
			motipopero	,
			moinstser	,
			momascara	,
			mocodigo	,
			moseriado	,
			mofecemi	,
			mofecven	,
			morutemi	,
			momonemi	,
			motasemi	,
			mobasemi	,
			monominal	,
			movpresen	,
			monumucup	,
			motir		,
			mopvp		,          
			movpar		,
			motasest	,
			mofecinip	,
			mofecvenp	,
			movalinip	,                    
			movalvenp	,
			motaspact	,
			mobaspact	,
			momonpact	,
			moforpagi	,              
			moforpagv	,
			mocondpacto	,
			morutcli	,
			mocodcli	,
			motipret	,
			mohora		,
			mousuario	,
			moterminal	,
			mocapitali	,
			movpreseni	,
			mocapitalp	,
			movpresenp	,
			monominalp	,
			movalcomp	,
			movalcomu	,
			mointeres	,
			moreajuste	,
			movalven	,
			mocorvent	,
			modcv		,
			moclave_dcv 	,
			momtopfe	,
			momtocce        ,
			fecha_compra_original		,
			valor_compra_original		,
			valor_compra_um_original	,
			tir_compra_original		,
			valor_par_compra_original	,
			porcentaje_valor_par_compra_original,
			codigo_carterasuper		,
			tipo_cartera_financiera		,
			mercado				,
			sucursal			,
			id_sistema			,
			fecha_pagomañana		,
			laminas				,
			tipo_inversion			,
			cuenta_corriente_inicio		,
			sucursal_inicio			,
			cuenta_corriente_final		,
			sucursal_final			,
			moobserv                        ,
			Codigo_subproducto              ,
                        Precio_Transferencia            ,
                        codigo_area                     ,
                        Swift_Corresponsal              ,
                        Swift_Pagamos                   ,
                        keyid_desk_manager              ,
                        libro_desk_manager              ,
                        Monto_Traspaso          ,
                        Diferencia_Traspaso     ,
                        Tir_Traspaso            ,
                        Libro_Origen_Traspaso ,
                        libro_transferencia ,
                        interes_transferencia
			)
	VALUES
			(
			@dfecpro	,
			@nRutcart	,
			@cTipcart 	,
			@nNumdocu	,
			@nCorrela	,
			@nNumdocuo	,
			@nCorrelao	,
			@nNumoper	,
			(CASE WHEN @cTipo_Moneda  = '0' THEN 'VIX' ELSE @cTipo_Operacion END),
			@ctipoper       ,
			@cInstser	,

			@cmascara	,
			@ncodigo	,
			@cseriado	,
			@dFecemi	,
			@dFecven	,
			@nRutemi	,      
			@nMonemi	,
			ISNULL(@ntasemi,0)	,
			ISNULL(@nbasemi,0)	,
			ISNULL(@nNominal,0)	,
			ISNULL(@vptircomp,0)	,                 
			@nNumucup		,
			ISNULL(@nTir,0)		,                              
			ISNULL(@nPvp,0)		,
			ISNULL(@nVpar,0)	,
			ISNULL(@nTasest,0)	,
			@dfecpro	,
			@dfecvtop	,
			@nValinip	,
			ISNULL(@nValvtop,0)	,
			ISNULL(@nTaspact,0)	,
			ISNULL(@nBaspact,0)	,
			ISNULL(@nMonpact,0)	,
			@nForpagi	, 
			@nForpagv	,
			@cTipcust	,
			@nRutcli	,           
			@nCodcli        ,
			@cRetiro	,
			@chora		,
			@cUsuario	,
			@cTerminal	,
			@nVptirv	,                
			@nVptirv	,
			ISNULL(@nValinip,0)	,
			ISNULL(@nValinip,0)	,
			@nNominalp		,
			ISNULL(@nvalcomp,0)	,
			ISNULL(@nvalcomu,0)	,
		        ISNULL(@nintereso,0)	,
			ISNULL(@nreajusto,0)	,
			ISNULL(@nValinip,0)	,
			@nCorrvent		,
			@cCustodia		,
			@cClavedcv		,
			@fTotalpfe		,
			@fTotalcce		,		
			@nfeccompo		,		
			@fvalcompo 		,
		 	@fvalcomuo	        ,
			@nTircompo              ,
			@nVparo                 ,
			@nPvparo                ,
			@codigo_carterasuper		,
			@tipo_cartera_financiera	,
			@mercado			,
			@sucursal			,
			@id_sistema			,
			@fecha_pagomañana		,
			@laminas			,
			@tipo_inversion			,
			@cuenta_corriente_inicio	,
			@sucursal_inicio		,
			@cuenta_corriente_final		,
			@sucursal_final			,
			@observacion            	,
    	        	(CASE WHEN @cTipo_Moneda  = '0' THEN 'VIX' ELSE @cTipo_Operacion END),
                        @precio_transferencia           ,
                        @codigo_area                    ,
                        @codigo_corresponsal_bco        ,
                        @codigo_corresponsal_cli        ,
                        @deskmngr_keyid                 ,
                        @deskmngr_libro                 ,
                        @vMonto_Traspaso                        ,
                        @vDiferencia_Traspaso                   ,
                        @Tir_Traspaso                           ,
                        @Libro_Origen_Traspaso   ,
                        @libro_transferencia ,
                        @interes_transferencia

			)


	--******************************--
	--** agregar ventas con pacto **--	--******************************--
	IF @nNominal_FLI = 0
		INSERT INTO CARTERA_VENTA_PACTO WITH (ROWLOCK)
			(
			virutcart	,
			vinumdocu	,
			vicorrela	,
			vinumoper	,
			vitipoper	,
			virutcli	,
			vicodcli	,
			vinominal	,

			vivalvent	,
			vivalvemu	,
			vivvum100	, 
			vitirvent	,
			vitasest	,
			vipvpvent	,
			vivpvent	,
			vifecinip	,
			vifecvenp	,
			vivalinip	,
			vivalvenp	,
			vitaspact	,
			vibaspact	,
			vimonpact	,
			vivptirc	,
			vivptirci	,

			vivptirv	,
			vivptirvi	,
			vicapitalv	,
 			viinteresv	,
			vireajustv	,
			vicapitalvi	,
			viinteresvi	,
			vireajustvi	,
			vinumucupc	,
			vinumucupv	, 
              		viinstser	,
			virutemi	,
			vimonemi	,
			vifecemi	,
			vifecven	,
			vicodigo	,
			vitircomp	,
			vifeccomp 	,
			vivalcomu	,
			vivalcomp	,
			viseriado	,
			vimascara	,
			vinominalp	,--47
			viforpagi	,
			viforpagv	,
			vicorvent	,
	 		vifecucup	,
			vifecpcup	,
			vivcompori	,
			vidurat		,
			vidurmod	,
			viconvex	,
			viinteresci	,
			vivalinipci	,
			vivalvenpci	,
			fecha_compra_original		,
			valor_compra_original		,
			valor_compra_um_original	,
			tir_compra_original		,
			valor_par_compra_original	,
			porcentaje_valor_par_compra_original,
			codigo_carterasuper		,
			tipo_cartera_financiera		,
			mercado				,
			sucursal			,
			id_sistema			,
			fecha_pagomañana		,
			laminas				,
			tipo_inversion			,
			cuenta_corriente_inicio		,
			sucursal_inicio			,
			cuenta_corriente_final		,
			sucursal_final		        ,
                        vivalvenc			,
			tipo_operacion			,
			codigo_subproducto              ,
                        Precio_Transferencia            ,
                        codigo_area                     ,
                        Swift_Corresponsal              ,
                        Swift_Pagamos                   ,
                        keyid_desk_manager              ,
                        libro_desk_manager              ,
                        Monto_Traspaso          ,
                        Diferencia_Traspaso     ,
                        Tir_Traspaso            ,
                        Libro_Origen_Traspaso ,
                        libro_transferencia ,
                        interes_transferencia
			)
		VALUES
			(
			@nRutcart	,
			@nNumdocu	,
			@nCorrela	,
			@nNumoper	,
			@ctipoper	,
			@nRutcli	,
                        @nCodcli	,	 
			@nNominal	,
			@nVptirv	,
			ROUND(@nVptirv / @nvalmon,4),
			@nVp100		,
			@nTir		,
			@nTasest	,
			@nPvp		,
			@nVptirv	,
			@dfecpro	,
			@dfecvtop	,
			@nValinip	,
			@nValvtop	,
			@nTaspact	,
			@nBaspact	,
			@nMonpact	,
			@nvptirc	,
			@nvptirci	,
			@nVptirv	,
			@nValinip	,
			@nvalcomp	,
			@nintereso	,
			@nreajusto	,
			@nValinip	,
			0		,

			0		,
			@nNumucupc	,
			@nNumucup	,
			@cInstser	,
			@nRutemi	,
			@nMonemi	,
			@dFecemi	,
			@dFecven	,
			@ncodigo	,
			@nTirc		,
			@dfeccomp	,
			ISNULL(@nvalcomu,0) 	,
			ISNULL(@nvalcomp,0)	,
			@cseriado	,
			@cmascara	,
			@nNominalp	,--47
			@nForpagi 	,
			@nForpagv	,
			@nCorrvent	,
			@dfecucup	,
			@dFecpcup	,
--			@nvalcompori
			0.0		,
			@dDurmac	,
			@dDurmod	,
			@dConvex	,
			0		,
			0		,
			0			,
			@nfeccompo		,
			@fvalcompo 		,
		 	@fvalcomuo	        ,
			@nTircompo              ,
			@nVparo                 ,
			@nPvparo                ,
			@codigo_carterasuper	,
			@tipo_cartera_financiera,
			@mercado		,
			@sucursal		,
			@id_sistema		,
			@fecha_pagomañana	,
			@laminas		,
			@tipo_inversion		,
			@cuenta_corriente_inicio,
			@sucursal_inicio	,
			@cuenta_corriente_final	,
			@sucursal_final         ,
                        @valvenc		,
        		(CASE WHEN @cTipo_Moneda  = '0' THEN 'VIX' ELSE @cTipo_Operacion END),
    			(CASE WHEN @cTipo_Moneda = '0' THEN 'VIX' ELSE @cTipo_Operacion END),
                        @precio_transferencia   ,
                        @codigo_area,
                        @codigo_corresponsal_bco        ,
                        @codigo_corresponsal_cli        ,
                        @deskmngr_keyid                 ,
                        @deskmngr_libro                 ,
                        @vMonto_Traspaso                        ,
                        @vDiferencia_Traspaso                   ,
                        @Tir_Traspaso                           ,
                        @Libro_Origen_Traspaso    ,
                        @libro_transferencia ,
                        @interes_transferencia

			)

	IF @@error=0
                SELECT	@cok = 1
	ELSE
		SELECT	@cok = -1

	SELECT Estado = @cok

END

GO
