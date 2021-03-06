USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_VNT_GRB_OPE]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SVA_VNT_GRB_OPE]
	(	@fecpro					DATETIME		,
		@rutcart				NUMERIC(9, 0)	,
		@numdocu				NUMERIC(10, 0)	,
		@cod_familia			NUMERIC(5, 0)	,
		@cod_nemo				CHAR(20)		,
		@id_instrum				CHAR(20)		,
		@rutcli					NUMERIC(9, 0)	,
		@codcli					NUMERIC(9, 0)	,
		@fecpago				DATETIME		,
		@nominal				NUMERIC(19, 4)	,
		@valor_venta			NUMERIC(19, 4)	,
		
		@tir_venta				NUMERIC(19, 7)	,
		@pvp_venta				NUMERIC(19, 7)	,
		@vpar_venta				NUMERIC(19, 8)	,
		@int_venta				NUMERIC(19, 4)	,
		@principal_venta		NUMERIC(19, 4)	,
		@usuario				CHAR(15)		,
		@terminal				CHAR(15)		,
		@observ					CHAR(70)		,
		@corr_bco_nombre		CHAR(50)		,
		@corr_bco_cta			CHAR(30)		,
		@corr_bco_aba			CHAR(09)		,
		@corr_bco_pais			CHAR(15)		,
		@corr_bco_ciud			CHAR(15)		,
		@corr_bco_swift			CHAR(30)		,
		@corr_bco_ref			CHAR(30)		,
		@corr_cli_nombre		CHAR(50)		,
		@corr_cli_cta			CHAR(30)		,
		@corr_cli_aba			CHAR(09)		,
		@corr_cli_pais			CHAR(15)		,
		@corr_cli_ciud			CHAR(15)		,
		@corr_cli_swift			CHAR(30)		,
		@corr_cli_ref			CHAR(30)		,
		@operador_contraparte	CHAR(30)		,
		@operador_bech			char(30)		,
		@monpag					numeric(3)		,
		@confirmacion			char(10)		,
		@forma_pago				char(15)		,
		@cod_emi				numeric(9)		,
		@Fec_neg				datetime		,
		@PagarPeso				Numeric(24)		,
		@correlativo			Numeric(9)		,
		@numoper 				NUMERIC(10)     ,
		@DurMacaulay            FLOAT      = 0.0,
		@DurModificada          FLOAT      = 0.0,
		@Convexidad             FLOAT      = 0.0
	)
AS 
BEGIN

	SET NOCOUNT ON

	DECLARE	@mtps			NUMERIC(19,4)	,
			@Hora			CHAR(08)

	DECLARE	@nFactor_v		NUMERIC(19,4)	,
			@nFactor_c		NUMERIC(19,4)	,
			@Status_Reg		CHAR(1)

	DECLARE	@c_cpnominal	NUMERIC(19,4)	,
			@c_cpvalvenc	NUMERIC(19,4)	,
			@c_cpvalcomp	NUMERIC(19,4)	,
			@c_cpvalcomu	NUMERIC(19,4)	,
			@c_cpvptirc		NUMERIC(19,7)	,
			@c_cpcapital	NUMERIC(19,4)	,
			@c_cpinteres	NUMERIC(19,4)	,
			@c_cpreajust	NUMERIC(19,4)	,
			@c_cpvalmerc	NUMERIC(19,4)	,
			@c_monto_encaje	NUMERIC(19,4)	,
			@c_cpprincipal	NUMERIC(19,4)	,
			@v_cpnominal	NUMERIC(19,4)	,
			@v_cpvalvenc	NUMERIC(19,4)	,
			@v_cpvalcomp	NUMERIC(19,4)	,
			@v_cpvalcomu	NUMERIC(19,4)	,
			@v_cpvptirc		NUMERIC(19,7)	,
			@v_cpcapital	NUMERIC(19,4)	,
			@v_cpinteres	NUMERIC(19,4)	,
			@v_cpreajust	NUMERIC(19,4)	,
			@v_cpvalmerc	NUMERIC(19,4)	,
			@v_monto_encaje	NUMERIC(19,4)	,
			@v_cpprincipal	NUMERIC(19,4)	,
			@nUtilidad		NUMERIC(19,4)	,
			@nPerdida		NUMERIC(19,4)	,
			@monemi			NUMERIC(5)		,
			@Valormoneda	NUMERIC(19,4)	,
			@montopeso		NUMERIC(24)

	SET		@Status_Reg		= ''
	SET		@Hora			= CONVERT(CHAR(08),GETDATE(),108)

	IF @fecpago > @fecpro 
		SET @Status_Reg = 'P'

	SELECT	@c_cpnominal	= cpnominal
		,	@monemi			= cpmonemi
	FROM	text_ctr_inv
	WHERE	cprutcart		= @rutcart
	AND		cpnumdocu		= @numdocu

	declare @nNominalDisp	numeric(19,4)
		set @nNominalDisp	= @c_cpnominal

	SELECT	@nFactor_v		=  @nominal / @c_cpnominal
		,	@nFactor_c		= (@c_cpnominal - @nominal) / @c_cpnominal

	SELECT	
		-- 	@v_cpnominal	= cpnominal    * @nFactor_v		,
			@v_cpvalvenc	= cpvalvenc    * @nFactor_v		,
			@v_cpvalcomp	= cpvalcomp    * @nFactor_v		,
			@v_cpvalcomu	= cpvalcomu    * @nFactor_v		,
			@v_cpvptirc		= cpvptirc     * @nFactor_v		,
			@v_cpcapital	= cpcapital    * @nFactor_v		,
			@v_cpinteres	= cpinteres    * @nFactor_v		,
			@v_cpreajust	= cpreajust    * @nFactor_v		,
			@v_cpvalmerc	= cpvalmerc    * @nFactor_v		,
			@v_monto_encaje = monto_encaje * @nFactor_v		,
			@v_cpprincipal  = cpprincipal  * @nFactor_v	
	FROM	TEXT_CTR_INV
	WHERE	cprutcart		= @rutcart
	AND		cpnumdocu		= @numdocu
--
	SELECT 	@c_cpnominal	= cpnominal    -  ( case when @fecpago > @fecpro then 0 else @nominal end ) ,
			@c_cpvalvenc	= cpvalvenc    - @v_cpvalvenc	,
			@c_cpvalcomp	= cpvalcomp    - @v_cpvalcomp	,
			@c_cpvalcomu	= cpvalcomu    - @v_cpvalcomu	,
			@c_cpvptirc		= cpvptirc     - @v_cpvptirc	,
			@c_cpcapital	= cpcapital    - @v_cpcapital	,
			@c_cpinteres	= cpinteres    - @v_cpinteres	,
			@c_cpreajust	= cpreajust    - @v_cpreajust	,
			@c_cpvalmerc	= cpvalmerc    - @v_cpvalmerc	,
			@c_monto_encaje = monto_encaje - @v_monto_encaje
	--		@c_cpprincipal  = cpprincipal  - @v_cpprincipal
	FROM	TEXT_CTR_INV
	WHERE	cprutcart		= @rutcart
	AND		cpnumdocu		= @numdocu

	SET		@nUtilidad		= 0
	SET		@nPerdida		= 0

	SELECT	@valor_venta	= ROUND(@valor_venta ,2)
    SELECT	@v_cpvptirc		= ROUND(@v_cpvptirc ,2)

	IF @v_cpvptirc < @valor_venta 	
		SET	@nUtilidad		= @valor_venta - @v_cpvptirc
	
	IF @v_cpvptirc > @valor_venta 	
		SET @nPerdida		= @v_cpvptirc  - @valor_venta

	IF @Status_Reg = 'P'
		UPDATE	TEXT_CTR_INV
		SET		cpnomi_vta	= cpnomi_vta + @nominal
		WHERE	cprutcart	= @rutcart
		AND		cpnumdocu	= @numdocu
	
	ELSE
		UPDATE	TEXT_CTR_INV
		SET		cpnominal	= @c_cpnominal	,
				cpvalvenc	= @c_cpvalvenc	,
				cpvalcomp	= @c_cpvalcomp	,
				cpvalcomu	= @c_cpvalcomu	,
				cpvptirc 	= @c_cpvptirc	,
				cpcapital	= @c_cpcapital	,
				cpinteres	= @c_cpinteres	,
				cpreajust	= @c_cpreajust	,
				cpvalmerc 	= @c_cpvalmerc	,
				monto_encaje= @c_monto_encaje,
				cpprincipal	= (@c_cpnominal	* cppvpcomp / 100 )-- @c_cpprincipal  
		WHERE	cprutcart	= @rutcart
		AND		cpnumdocu	= @numdocu

	IF @@error <> 0
	BEGIN
		SELECT -1
			,	'Error: al actualizar dato en tabla TEXT_CTR_INV.'
		SET NOCOUNT OFF
		RETURN
	END

	SET	@mtps = 0

	IF @monemi = 994 Or @monemi = 13
	BEGIN
		-- se modifica a dolar mes anterior (definicion origen)
		SELECT  @valormoneda = dolarObsFinMes FROM TEXT_ARC_CTL_DRI
		-- Monto en peso con tipo cambio del dia (solicitado por el banco)
	END ELSE
	BEGIN
		SELECT  @valormoneda = isnull (vmvalor, 0) FROM VIEW_VALOR_MONEDA WHERE vmfecha = @fecpro and vmcodigo = @monemi
	END 

	SET	@MontoPeso	= Round( @v_cpvptirc * @valormoneda, 0)

	--> Ventas AFS
	declare @nDif						numeric(21,4);	
		set	@nDif						= case when @nUtilidad > 0 then @nUtilidad else (@nPerdida*-1) end

	declare @Resultado_Dif_Precio		numeric(21,4);	set @Resultado_Dif_Precio		= 0.0
	declare @Resultado_Dif_Mercado		numeric(21,4);	set @Resultado_Dif_Mercado		= 0.0
	declare @nValMercadoProporcional	numeric(21,4);	set @nValMercadoProporcional	= 0.0

	Execute BacTraderSuda.dbo.sp_fx_utilidad_venta	'BEX'
												,	@numdocu
												,	@correlativo
												,	@nominal
												,	@valor_venta
												,	@nDif
												,	@Resultado_Dif_Precio	output
												,	@Resultado_Dif_Mercado	output
	--> Ventas AFS

	INSERT INTO TEXT_MVT_DRI 
		(	mofecpro					,	--1
			morutcart					,	--2
			monumdocu					,	--3
			monumoper					,	--4
			motipoper					,	--5
			cod_nemo					,	--6
			cod_familia					,	--7
			id_instrum					,	--8
			morutcli					,	--9
			mocodcli					,	--10
			mofecemi					,	--1
			mofecven					,	--2
			momonemi					,	--3
			motasemi					,	--4
			mobasemi					,	--5
			morutemi					,	--6
			mofecpago					,	--7
			monominal					,	--8
			movpresen					,	--9
			movalvenc					,	--20
			momtps						,	--1
			momtum						,	--2
			motir						,	--3
			mopvp						,	--4
			movpar						,	--5
			moint_compra				,	--6
			moprincipal					,	--7
			movalcomp					,	--8
			movalcomu					,	--9
			mointeres					,	--30
			moreajuste					,	--1
			moutilidad					,	--2
			moperdida					,	--3
			movalven					,	--4
			monumucup					,	--6
			monumpcup					,	--7
			mousuario					,	--8
			mostatreg					,	--40
			moobserv					,	--1
			basilea						,
			tipo_tasa					,
			encaje						,
			monto_encaje				,
			codigo_carterasuper			,	--2
			Tipo_Cartera_Financiera		,	--3
			sucursal					,	--4
			corr_bco_nombre				,	--5
			corr_bco_cta				,	--6
			corr_bco_aba				,	--7
			corr_bco_pais				,	--8
			corr_bco_ciud				,	--9
			corr_bco_swift				,	--50
			corr_bco_ref				,	--1
			corr_cli_nombre				,	--2
			corr_cli_cta				,	--3
			corr_cli_aba				,	--4
			corr_cli_pais				,	--5
			corr_cli_ciud				,	--6
			corr_cli_swift				,	--7
			corr_cli_ref				,	--8
			operador_contraparte		,	--9
			operador_banco				,
			calce						,	--6
			tipo_inversion				,	--1
			para_quien					,	--2
			nombre_custodia				,
			momonpag					,
			confirmacion				,
			forma_pago					,
			base_tasa					,
			momontoemi					,
			cod_emi						,
			mofecneg					,
			mofecucup					,
			mofecpcup					,
			mohoraop					,
			cusip						,
			capitalpeso					,
			mocorrelativo				,
			Hora						,
			DurMacaulay					,
			DurModificada				,
			Convexidad					,
			Id_Area_Responsable			,
			Id_Libro					,
			Resultado_Dif_Precio		,		--> Ventas AFS
			Resultado_Dif_Mercado		,		--> Ventas AFS
			ValorMercado_prop					--> Ventas AFS
	)	
	SELECT	@fecpro								,	--1
			@rutcart							,	--2
			cpnumdocu							,	--3
			@numoper							,	--4
			'VP'								,	--5
			@cod_nemo							,	--6
			@cod_familia						,	--7
			@id_instrum							,	--8
			@rutcli								,	--9
			@codcli								,	--10
			cpfecemi							,	--1
			cpfecven							,	--2
			cpmonemi							,	--3
			cptasemi							,	--4
			cpbasemi							,	--5
			cprutemi							,	--6
			@fecpago							,	--7
			@nominal							,	--8
			@v_cpvptirc							,	--9
			@v_cpvalvenc						,	--20
			@mtps								,	--1
			@valor_venta						,	--2
			@tir_venta							,	--3
			@pvp_venta							,	--4
			@vpar_venta							,	--5
			@int_venta							,	--6
			@principal_venta					,	--7
			@v_cpvalcomp						,	--8
			@v_cpvalcomu						,	--9
			@v_cpinteres						,	--30
			@v_cpreajust						,	--1
			@nUtilidad							,	--2 
			@nPerdida							,	--3
			@valor_venta						,	--4
			cpnumucup							,					
			cpnumpcup							,	--7
			@usuario							,	--8
			@Status_Reg							,	--40
			@observ								,	--1
			TEXT_CTR_INV.basilea				,
			TEXT_CTR_INV.tipo_tasa				,
			TEXT_CTR_INV.encaje					,
			@v_monto_encaje						,
			TEXT_CTR_INV.codigo_carterasuper	,	--2
			TEXT_CTR_INV.Tipo_Cartera_Financiera,	--3
			TEXT_CTR_INV.sucursal				,	--4
			@corr_bco_nombre					,	--5
			@corr_bco_cta						,	--6
			@corr_bco_aba						,	--7
			@corr_bco_pais						,	--8
			@corr_bco_ciud						,	--9
			@corr_bco_swift						,	--50
			@corr_bco_ref						,	--1
			@corr_cli_nombre					,	--2
			@corr_cli_cta						,	--3
			@corr_cli_aba						,	--4
			@corr_cli_pais						,	--5
			@corr_cli_ciud						,	--6
			@corr_cli_swift						,	--7
			@corr_cli_ref						,	--8
			@operador_contraparte				,	--9
			@operador_bech						,
			TEXT_CTR_INV.calce					,	--60
			TEXT_CTR_INV.tipo_inversion			,	--1
			TEXT_CTR_INV.para_quien				,	--2
			TEXT_CTR_INV.nombre_custodia		,
			@monpag								,
			@confirmacion						,
			@forma_pago							,
			base_tasa							,
			monto_emision						,
			cpcodemi							,
			@fec_neg							,
			cpfecucup							,
			cpfecpcup							,
			(convert(char(8), getdate(), 108))	,
			cusip								,
			@MontoPeso  						,
			@correlativo						,
			@Hora								,
			@DurMacaulay                        ,
			@DurModificada                      ,
			@Convexidad							,
			TEXT_CTR_INV.Id_Area_Responsable	,
			TEXT_CTR_INV.Id_Libro				,
			@Resultado_Dif_Precio				,	--> Ventas AFS
			@Resultado_Dif_Mercado				,	--> Ventas AFS
			@nValMercadoProporcional				--> Ventas AFS
	FROM 	TEXT_CTR_INV					
	WHERE	cprutcart	= @rutcart
	AND		cpnumdocu	= @numdocu

	IF @@error <> 0 
	BEGIN
		SELECT	-1
			,	'Error: al crear el nuevo registro en la tabla TEXT_CTR_INVr.'
		SET NOCOUNT OFF
	    RETURN
	END

	IF @fecpago > @fecpro
	BEGIN
		INSERT INTO TEXT_CTR_CPR
		(		mofecpro				,	--1
				morutcart				,	--2
				monumdocu				,	--3
				monumoper				,	--4
				motipoper				,	--5
				cod_nemo				,	--6
				cod_familia				,	--7
				id_instrum				,	--8
				morutcli				,	--9
				mocodcli				,	--10
				mofecemi				,	--1
				mofecven				,	--2
				momonemi				,	--3
				motasemi				,	--4
				mobasemi				,	--5
				morutemi				,	--6
				mofecpago				,	--7
				monominal				,	--8
				movpresen				,	--9
				movalvenc				,	--20
				momtps					,	--1
				momtum					,	--2
				motir					,	--3
				mopvp					,	--4
				movpar					,	--5
				moint_compra			,	--6
				moprincipal				,	--7
				movalcomp				,	--8
				movalcomu				,	--9
				mointeres				,	--30
				moreajuste				,	--1
				moutilidad				,	--2
				moperdida				,	--3
				movalven				,	--4
				monumucup				,	--6
				monumpcup				,	--7
				mousuario				,	--8
				mostatreg				,	--40
				moobserv				,	--1
				basilea					,
				tipo_tasa				,
				encaje					,
				monto_encaje			,
				codigo_carterasuper		,	--2
				Tipo_Cartera_Financiera	,	--3
				sucursal				,	--4
				corr_bco_nombre			,	--5
				corr_bco_cta			,	--6
				corr_bco_aba			,	--7
				corr_bco_pais			,	--8
				corr_bco_ciud			,	--9
				corr_bco_swift			,	--50
				corr_bco_ref			,	--1
				corr_cli_nombre			,	--2
				corr_cli_cta			,	--3
				corr_cli_aba			,	--4
				corr_cli_pais			,	--5
				corr_cli_ciud			,	--6
				corr_cli_swift			,	--7
				corr_cli_ref			,	--8
				operador_contraparte	,	--9
				operador_banco			,
				calce					,	--6
				tipo_inversion			,	--1
				para_quien				,	--2
				nombre_custodia			,
				momonpag				,
				confirmacion			,
				forma_pago				,
				base_tasa				,
				momontoemi				,
				cod_emi					,
				mofecneg				,
				mofecucup				,
				mofecpcup				,
				mohoraop				,
				cusip					,
				capitalpeso				,
				mocorrelativo			,
				Hora					,
				DurMacaulay             ,
				DurModificada           ,
				Convexidad              ,
				Id_Area_Responsable		,
				Id_Libro				,
				Resultado_Dif_Precio	,		--> Ventas AFS
				Resultado_Dif_Mercado	,		--> Ventas AFS
				ValorMercado_prop				--> Ventas AFS
		)
		SELECT	@fecpro								,	--1
				@rutcart							,	--2
				cpnumdocu							,	--3
				@numoper							,	--4
				'VP'								,	--5
				@cod_nemo							,	--6
				@cod_familia						,	--7
				@id_instrum							,	--8
				@rutcli								,	--9
				@codcli								,	--10
				cpfecemi							,	--1
				cpfecven							,	--2
				cpmonemi							,	--3
				cptasemi							,	--4
				cpbasemi							,	--5
				cprutemi							,	--6
				@fecpago							,	--7
				@nominal							,	--8
				@v_cpvptirc							,	--9
				@v_cpvalvenc						,	--20
				@mtps								,	--1
				@valor_venta						,	--2
				@tir_venta							,	--3
				@pvp_venta							,	--4
				@vpar_venta							,	--5
				@int_venta							,	--6
				@principal_venta					,	--7
				@v_cpvalcomp						,	--8
				@v_cpvalcomu						,	--9
				@v_cpinteres						,	--30
				@v_cpreajust						,	--1
				@nUtilidad							,	--2
				@nPerdida							,	--3
				@valor_venta						,	--4
				cpnumucup							,					
                cpnumpcup							,	--7
				@usuario							,	--8
				@Status_Reg							,	--40
				@observ								,	--1
				text_ctr_inv.basilea				,
				text_ctr_inv.tipo_tasa				,
				text_ctr_inv.encaje					,
				@v_monto_encaje						,
				text_ctr_inv.codigo_carterasuper	,	--2
				text_ctr_inv.Tipo_Cartera_Financiera,	--3
				text_ctr_inv.sucursal				,	--4
				@corr_bco_nombre					,	--5
				@corr_bco_cta						,	--6
				@corr_bco_aba						,	--7
				@corr_bco_pais						,	--8
				@corr_bco_ciud						,	--9
				@corr_bco_swift						,	--50
				@corr_bco_ref						,	--1
				@corr_cli_nombre					,	--2
				@corr_cli_cta						,	--3
				@corr_cli_aba						,	--4
				@corr_cli_pais						,	--5
				@corr_cli_ciud						,	--6
				@corr_cli_swift						,	--7
				@corr_cli_ref						,	--8
				@operador_contraparte				,	--9
				@operador_bech						,
				text_ctr_inv.calce					,	--60
				text_ctr_inv.tipo_inversion			,	--1
				text_ctr_inv.para_quien				,	--2
				text_ctr_inv.nombre_custodia		,
				@monpag								,
				@confirmacion						,
				@forma_pago							,
				base_tasa							,
				monto_emision						,
				cpcodemi							,
				@fec_neg							,
				cpfecucup							,
				cpfecpcup							,
				(CONVERT(CHAR(8), GETDATE(), 108))	,
				cusip								,
				@MontoPeso  						,
				@correlativo						,
				@Hora								,
				@DurMacaulay						,
				@DurModificada						,
				@Convexidad							,
				Id_Area_Responsable					,
				Id_Libro							,
				@Resultado_Dif_Precio				,	--> Ventas AFS
				@Resultado_Dif_Mercado				,	--> Ventas AFS
				@nValMercadoProporcional				--> Ventas AFS
		FROM 	TEXT_CTR_INV
		WHERE	cprutcart	= @rutcart
		AND		cpnumdocu	= @numdocu

		IF @@error <> 0 
		BEGIN
			SELECT	-1
				,	'Error: al crear el nuevo registro en la tabla TEXT_CTR_CPR.'
			SET NOCOUNT OFF         --ADO
			RETURN
		END

	END

	SELECT 'OK'

	SET NOCOUNT OFF
END
GO
