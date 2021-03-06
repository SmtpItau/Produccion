USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_CMP_GRB_OPE]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE  [dbo].[SVA_CMP_GRB_OPE]
( 
			@fecpro				DATETIME	,--1
			@rutcart			NUMERIC(9, 0)	,--2
			@cod_familia		NUMERIC(5, 0)	,--3
			@cod_nemo			CHAR(20)	,--4
			@id_instrum			CHAR(20)	,--5
			@rutcli				NUMERIC(9, 0)	,--6
			@codcli				NUMERIC(9, 0)	,--7
			@fecemi				DATETIME	,--8
			@fecven				DATETIME	,--9
			@monemi				NUMERIC(3, 0)	,--10
			@monpag				NUMERIC(3, 0)	,--11
			@tasemi				NUMERIC(9, 4)	,--12
			@basemi				NUMERIC(3, 0)	,--13
			@rutemi				NUMERIC(9, 0)	,--14
			@fecpago			DATETIME	,--15
			@nominal			NUMERIC(19, 4)	,--16
			@vpresen			NUMERIC(19, 4)	,--17 
			@valvenc			NUMERIC(19, 4)	,--18
			@tir				NUMERIC(19, 7)	,--19
			@pvp				NUMERIC(19, 7)	,--20
			@vpar				NUMERIC(19, 4)	,--21
			@int_compra			NUMERIC(19, 4)	,--22
			@principal			NUMERIC(19, 4)	,--23
			@numucup			NUMERIC(3, 0)	,--24
			@numpcup			NUMERIC(3, 0)	,--25
			@fecucup			DATETIME	,--26
			@fecpcup			DATETIME	,--27
			@usuario			CHAR(15)	,--28 
			@terminal			CHAR(15)	,
			@observ				CHAR(70)	,--29
			@basilea			NUMERIC(1)	,--30
			@tipo_tasa			NUMERIC(3)	,--31 
			@encaje				CHAR(1)		,--32
			@monto_encaje		NUMERIC(19, 4)	,--33 
			
			@codigo_carterasuper		CHAR (10)	,--34
			@Tipo_Cartera_Financiera	CHAR (10)	,--35

			@sucursal				CHAR(04)	,--36
			@corr_bco_nombre		CHAR(50)	,--37
			@corr_bco_cta			CHAR(30)	,--38
			@corr_bco_aba			CHAR(09)	,--39
			@corr_bco_pais			CHAR(15)	,--40
			@corr_bco_ciud			CHAR(15)	,--41
			@corr_bco_swift			CHAR(30)	,--42
			@corr_bco_ref			CHAR(30)	,--43
			@corr_cli_nombre		CHAR(50)	,--44
			@corr_cli_cta			CHAR(30)	,--45  
			@corr_cli_aba			CHAR(09)	,--46
			@corr_cli_pais			CHAR(15)	,--47
			@corr_cli_ciud			CHAR(15)	,--48
			@corr_cli_swift			CHAR(30)	,--51
			@corr_cli_ref			CHAR(30)	,--52
			@operador_contraparte	CHAR(30)	,--53
			@operador_Banco			CHAR(30)	,--54
			@calce					CHAR(1)		,--55
			@tipo_inversion			CHAR(1)		,--56
			@para_quien				CHAR(1)		,--57
			@tipo_riesgo			CHAR(10)	,
			@grado_riesgo			CHAR(1)		,
			@codigo_riesgo			CHAR(8)		,
			@nombre_custodia		CHAR(30)	,--58
			@monto_emi				numeric(19,4)	,--59
			@confirmacion			numeric(1)	,--60
			@forma_pago				numeric(3)	,--61
			@base_tasa				char(20)	,--62
			@cod_emi				numeric(9)	,--63
			@fec_neg				datetime	,--64
			@Cusip					char(12)	,--65
			@numoper 				NUMERIC(10)	, --66
			@estadolinea			CHAR(1)		, --67
			@CapitalPeso			Numeric(24)=0   , --68
            @DurMacaulay            float      = 0.0, --69
            @DurModificada          float      = 0.0, --70
            @Convexidad             float      = 0.0	, --71
			@Id_Area_Resp			CHAR(10)	= ''	, --72
			@Id_Libro				CHAR(10)	= ''	--)--73
			--+++jcamposd deposito colombiano
			,@imPorcentajeImp		NUMERIC(5)		= 0
			,@imMtoImpuesto			NUMERIC(19,4)	= 0) --75
			-----jcamposd deposito colombiano
AS
BEGIN
SET NOCOUNT ON
--BEGIN TRANSACTION

--	DECLARE	@numoper 	NUMERIC(10)
	DECLARE	@mtps		NUMERIC(19,4)	,
		@Hora		Char	(08)	
	

--	SELECT @numoper = acnumoper FROM text_arc_ctl_dri

	SELECT	@mtps = 0				,
		@Hora = convert(Char(08),Getdate(),108)
-- 
 -- select * from text_mvt_dri
	INSERT INTO text_mvt_dri (	
			mofecpro		, 
			morutcart		, 
			monumdocu		, 
			monumoper		,
			motipoper		,
			cod_nemo		,
			cod_familia		,
			id_instrum		,
			morutcli		,
			mocodcli		,
			mofecemi		,
			mofecven		,
			momonemi		,
			momonpag		,
			motasemi		,
			mobasemi		,
			morutemi		,
			mofecpago		,
			monominal		,
			movpresen		,
			movalvenc		,
			momtps			,
			momtum			,
			motir			,
			mopvp			,
			movpar			,
			moint_compra		,
			moprincipal		,
			movalcomp		,
			movalcomu		,
			mointeres		,
			moreajuste		,
			moutilidad		,
			moperdida		,
			movalven		,
			monumucup		,
			monumpcup		,
			mousuario		,
			mostatreg		,
			moobserv		,
			basilea			,
			tipo_tasa		,
			encaje			,
			monto_encaje		,
			codigo_carterasuper	,
			Tipo_Cartera_Financiera	,
			sucursal		,
			corr_bco_nombre		,
			corr_bco_cta		,
			corr_bco_aba		,
			corr_bco_pais		,
			corr_bco_ciud		,
			corr_bco_swift		,
			corr_bco_ref		,
			corr_cli_nombre		,
			corr_cli_cta		,
			corr_cli_aba		,
			corr_cli_pais		,
			corr_cli_ciud		,
			corr_cli_swift		,
			corr_cli_ref		,
			operador_contraparte	,
			operador_banco		,
			calce			,
			tipo_inversion		,
			para_quien		,
			nombre_custodia		,
			momontoemi		,
			confirmacion		,
			forma_pago		,
			base_tasa		,
			cod_emi			,
			mofecneg		,
			mofecucup		,
			mofecpcup		,
			mohoraop		,
			cusip			,
			capitalpeso		,
			Hora			,
            DurMacaulay             ,
            DurModificada           ,
            Convexidad              ,
			Id_Area_Responsable	,
			Id_Libro		)

	VALUES	(	@fecpro			,
			@rutcart		,
			@numoper		,
			@numoper		,
			'CP'			,
			@cod_nemo		,
			@cod_familia		,
			@id_instrum		,
			@rutcli			,
			@codcli			,
			@fecemi			,
			@fecven			,
			@monemi			,
			@monpag			,
			@tasemi			,
			@basemi			,
			@rutemi			,
			@fecpago		,
			@nominal		,
			@vpresen		,
			@valvenc		,
			@mtps			,
			@vpresen		,
			@tir			,
			@pvp			,
			@vpar			,
			@int_compra		,
			@principal		,
			@mtps			,
			@vpresen		,
			0			,
			0			,
			0			,
			0			,
			0			,
			@numucup		,
			@numpcup		,
			@usuario		,
			@estadolinea		,
			@observ			,
			@basilea		,
			@tipo_tasa		,
			@encaje			,
			@monto_encaje		,
			@codigo_carterasuper	,
			@Tipo_Cartera_Financiera,
			@sucursal		,
			@corr_bco_nombre	,
			@corr_bco_cta		,
			@corr_bco_aba		,
			@corr_bco_pais		,
			@corr_bco_ciud		,
			@corr_bco_swift		,
			@corr_bco_ref		,
			@corr_cli_nombre	,
			@corr_cli_cta		,
			@corr_cli_aba		,
			@corr_cli_pais		,
			@corr_cli_ciud		,
			@corr_cli_swift		,
			@corr_cli_ref		,
			@operador_contraparte	,
			@operador_banco		,
			@calce			,
			@tipo_inversion		,
			@para_quien		,
			@nombre_custodia	,
			@monto_emi		,
			@confirmacion		,
			@forma_pago		,
			@base_tasa		,
			@cod_emi		,
			@fec_neg		,
			@fecucup		,
			@fecpcup		,
			(convert(char(8), getdate(),108)),
			@cusip			,
			@capitalpeso		,
			@Hora			,
            @DurMacaulay            ,
            @DurModificada          ,
            @Convexidad             ,
			@Id_Area_Resp		,
			@Id_Libro		)

	   IF @@error <> 0 BEGIN

	      SELECT -1,
        	     'Error: al crear el nuevo registro en la tabla text_mvt_dri.'
	      	
	      SET NOCOUNT OFF         --ADO
	      RETURN

	   END

		--+++jcamposd registro de impuestos en caso de ser requerido instrumentos COP
		--en peso colomabiano
		IF @cod_familia = 2006 AND @monemi = 129 and @imPorcentajeImp > 0
		BEGIN
			INSERT INTO TEXT_CTR_REG_IMP(
			imnumdocu 
			,imcorrelativo
			,imPorcentajeImp
			,imMtoImpuesto)
			VALUES(
			@numoper	
			,1
			,@imPorcentajeImp
			,@imMtoImpuesto)
		END
		-----jcamposd registro de impuestos en caso de ser requerido instrumentos COP
	

	   IF @@error <> 0 BEGIN
	      SELECT -1,'Error: al crear el nuevo registro en la tabla text_ctr_reg_imp.'
	      SET NOCOUNT OFF         
	      RETURN
	   END




	IF @fecpago > @fecpro
	BEGIN
-- select * from text_ctr_cpr 
		INSERT INTO text_ctr_cpr (
			mofecpro		,
			morutcart		,
			monumdocu		,
			monumoper		,
			motipoper		,
			cod_nemo		,
			cod_familia		,
			id_instrum		,
			morutcli		,
			mocodcli		,
			mofecemi		,
			mofecven		,
			momonemi		,
			momonpag		,
			motasemi		,
			mobasemi		,
			morutemi		,
			mofecpago		,
			monominal		,
			movpresen		,
			movalvenc		,
			momtps			,
			momtum			,
			motir			,
			mopvp			,
			movpar			,
			moint_compra		,
			moprincipal		,
			movalcomp		,
			movalcomu		,
			mointeres		,
			moreajuste		,
			moutilidad		,
			moperdida		,
			movalven		,
			monumucup		,
			monumpcup		,
			mousuario		,
			mostatreg		,
			moobserv		,
			basilea			,
			tipo_tasa		,
			encaje			,
			monto_encaje		,
			codigo_carterasuper	,
			Tipo_Cartera_Financiera	,
			sucursal		,
			corr_bco_nombre		,
			corr_bco_cta		,
			corr_bco_aba		,
			corr_bco_pais		,
			corr_bco_ciud		,
			corr_bco_swift		,
			corr_bco_ref		,
			corr_cli_nombre		,
			corr_cli_cta		,
			corr_cli_aba		,
			corr_cli_pais		,
			corr_cli_ciud		,
			corr_cli_swift		,
			corr_cli_ref		,
			operador_contraparte	,
			operador_banco	,
			calce			,
			tipo_inversion	,
			para_quien		,
			nombre_custodia	,
			momontoemi		,
			confirmacion	,
			forma_pago		,
			base_tasa		,
			cod_emi			,
			mofecneg		,
			mofecucup		,
			mofecpcup		,
			mohoraop		,
			cusip			,
			capitalpeso		,
			Hora			,
            DurMacaulay     ,
            DurModificada   ,
            Convexidad      ,
			Id_Area_Responsable	,
			Id_Libro		)

	VALUES		(@fecpro		,
			@rutcart		,
			@numoper		,
			@numoper		,
			'CP'			,
			@cod_nemo		,
			@cod_familia		,
			@id_instrum		,
			@rutcli			,
			@codcli			,
			@fecemi			,
			@fecven			,
			@monemi			,
			@monpag			,
			@tasemi			,
			@basemi			,
			@rutemi			,
			@fecpago		,
			@nominal		,
			@vpresen		,
			@valvenc		,
			@mtps			,
			@vpresen		,
			@tir			,
			@pvp			,
			@vpar			,
			@int_compra		,
			@principal		,
			@mtps			,
			@vpresen		,
			0				,
			0				,
			0				,
			0				,
			0				,
			@numucup		,
			@numpcup		,
			@usuario		,
			''				,
			@observ			,
			@basilea		,
			@tipo_tasa		,
			@encaje			,
			@monto_encaje		,
			@codigo_carterasuper	,
			@Tipo_Cartera_Financiera,
			@sucursal			,
			@corr_bco_nombre	,
			@corr_bco_cta		,
			@corr_bco_aba		,
			@corr_bco_pais		,
			@corr_bco_ciud		,
			@corr_bco_swift		,
			@corr_bco_ref		,
			@corr_cli_nombre	,
			@corr_cli_cta		,
			@corr_cli_aba		,
			@corr_cli_pais		,
			@corr_cli_ciud		,
			@corr_cli_swift		,
			@corr_cli_ref		,
			@operador_contraparte	,
			@operador_banco		,
			@calce				,
			@tipo_inversion		,
			@para_quien			,
			@nombre_custodia	,
			@monto_emi			,
			@confirmacion		,
			@forma_pago			,
			@base_tasa			,
			@cod_emi			,
			@fec_neg			,
			@fecucup			,
			@fecpcup			,
			(convert(char(8), getdate(), 108)),
			@cusip				,
			@capitalpeso		,
			@Hora				,
			@DurMacaulay        ,
            @DurModificada      ,
            @Convexidad         ,
			@Id_Area_Resp		,
			@Id_Libro		)

	   IF @@error <> 0 BEGIN
	      SELECT -1,'Error: al crear el nuevo registro en la tabla text_ctr_cpr.'
	      SET NOCOUNT OFF         --ADO
	      RETURN
	   END

	END
-- delete from text_mvt_dri where monumdocu = 64
-- delete select * from TEXT_CTR_INV where cpnumdocu= 64


	INSERT INTO TEXT_CTR_INV (	
			cprutcart		,
			cpnumdocu		,
			cprutcli		,
			cpcodcli		,
			cod_familia		,
			cod_nemo		,
			id_instrum		,
			cpnominal		,
			cpvalvenc		,
			cpfecpago		,
			cpfeccomp		,
			cpint_compra		,
			cpprincipal		,
			cpvalcomp		,
			cpvalcomu		,
			cptircomp		,
			cppvpcomp		,
			cpvpcomp		,
			cpfecemi		,
			cpfecven		,
			cprutemi		,
			cpmonemi		,
			cpmonpag		,
			cpvptirc		,
			cpcapital		,
			cpinteres		,
			cpreajust		,
			cpnumucup		,
			cpnumpcup		,
			cpfecucup		,
			cpfecpcup		,
			cptirmerc		,
			cpvalmerc		,
			basilea			,
			tipo_tasa		,
			encaje			,
			monto_encaje		,
			codigo_carterasuper	,
			Tipo_Cartera_Financiera	,
			sucursal		,
			calce			,
			tipo_inversion		,
			para_quien		,
			nombre_custodia		,
			cptasemi		,
			cpbasemi		,
			forma_pago		,
			confirmacion		,
			base_tasa		,
			operador_Banco		,
			operador_contra		,
			monto_emision		,
			cpcodemi		,
			corr_cli_nombre		,
			corr_cli_cta		,
			corr_cli_aba		,
			corr_cli_pais		,
			corr_cli_ciud		,
			corr_cli_swift		,
			corr_cli_ref		,
			cpfecneg		,
			cpajuste_traspaso	,
			cpfectraspaso		,
			cppvpmerc		,
			cusip			,
			princdia		,
			mousuario		,
			Hora                    ,
			DurMacaulay             ,
            DurModificada           ,
            Convexidad              ,
			Id_Area_Responsable	,
			Id_Libro		)

	VALUES	(	@rutcart		,
			@numoper		,
			@rutcli			,
			@codcli			,
			@cod_familia		,
			@cod_nemo		,
			@id_instrum		,
			@nominal		,
			@valvenc		,
			@fecpago		,
			@fecpro			,
			@int_compra		,
			@principal		,
			@mtps			,
			@vpresen		,
			@tir			,
			@pvp			,
			@vpar			,
			@fecemi			,
			@fecven			,
			@rutemi			,
			@monemi			,
			@monpag			,
			@vpresen		,
			@vpresen		,
			0			,
			0			,
			@numucup		,
			@numpcup		,
			@fecucup		,
			@fecpcup		,
			0			,
			0			,
			@basilea		,
			@tipo_tasa		,
			@encaje			,
			@monto_encaje		,
			@codigo_carterasuper	,
			@tipo_Cartera_Financiera,
			@sucursal		,
			@calce			,
			@tipo_inversion		,
			@para_quien		,
			@nombre_custodia	,
			@tasemi			,
			@basemi			,
			@forma_pago		,
			@confirmacion		,
			@base_tasa		,
			@operador_Banco		,
			@operador_contraparte	,
			@monto_emi		,
			@cod_emi		,
			@corr_cli_nombre	,
			@corr_cli_cta		,
			@corr_cli_aba		,
			@corr_cli_pais		,
			@corr_cli_ciud		,
			@corr_cli_swift		,
			@corr_cli_ref		,
			@fec_neg		,
			0			,
			' '			,
			0			,
			@cusip			,
			@principal		,
			@usuario		,
			@Hora			,
			@DurMacaulay    ,
            @DurModificada  ,
            @Convexidad     ,
			@Id_Area_Resp	,
			@Id_Libro		)

--	COMMIT TRANSACTION

	   IF @@error <> 0 BEGIN

	      SELECT -1,
        	     'Error: al crear el nuevo registro en la tabla TEXT_CTR_INV .'
	      	
	      SET NOCOUNT OFF         --ADO
	      RETURN

	   END

	UPDATE 	text_arc_ctl_dri SET acnumoper = @numoper

	SELECT 'SI', @numoper 

	SET NOCOUNT OFF
END
GO
