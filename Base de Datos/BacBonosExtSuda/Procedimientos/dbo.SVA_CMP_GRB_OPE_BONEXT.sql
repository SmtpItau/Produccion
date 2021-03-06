USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_CMP_GRB_OPE_BONEXT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE  [dbo].[SVA_CMP_GRB_OPE_BONEXT]
( 
			@fecpro			DATETIME	,--1
			@rutcart			NUMERIC(9, 0)	,--2
			@cod_familia			NUMERIC(5, 0)	,--3
			@cod_nemo			CHAR(20)	,--4
			@id_instrum			CHAR(20)	,--5
			@rutcli				NUMERIC(9, 0)	,--6
			@codcli				NUMERIC(9, 0)	,--7
			@fecemi			DATETIME	,--8
			@fecven			DATETIME	,--9
			@monemi			NUMERIC(3, 0)	,--10
			@monpag			NUMERIC(3, 0)	,--11
			@tasemi			NUMERIC(9, 4)	,--12
			@basemi			NUMERIC(3, 0)	,--13
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
			@observ			CHAR(70)	,--29
			@basilea			NUMERIC(1)	,--30
			@tipo_tasa			NUMERIC(3)	,--31 
			@encaje			CHAR(1)		,--32
			@monto_encaje			NUMERIC(19, 4)	,--33 
			@codigo_carterasuper		CHAR (10)	,--34
			@Tipo_Cartera_Financiera	CHAR (10)	,--35
			@operador_Banco			CHAR(30)	,--54
			@tipo_inversion			CHAR(1)		,--56
			@tipo_riesgo			CHAR(10)	,
			@grado_riesgo			CHAR(1)		,
			@codigo_riesgo			CHAR(8)		,
			@nombre_custodia		CHAR(30)	,--58
			@monto_emi			numeric(19,4)	,--59
			@forma_pago			numeric(3)	,--61
			@base_tasa			char(20)	,--62
			@cod_emi			numeric(9)	,--63
			@fec_neg			datetime	,--64
			@Cusip				char(12)	,--65
			@numoper 			NUMERIC(10)	, --66
			@estadolinea			CHAR(1)		, --67
			@CapitalPeso			Numeric(24)=0   , --68
	                        	@DurMacaulay                    	float      = 0.0, --69
             		           	@DurModificada                  	float      = 0.0, --70
                        		@Convexidad                     	float      = 0.0	, --71
			@Id_Area_Resp			CHAR(10)	= ''	, --72
			@Id_Libro			CHAR(10)	= ''	, --73
			@cod_mesa_origen		SMALLINT,
			@cod_mesa_destino		SMALLINT,
			@cod_cartera_destino		SMALLINT
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE	@mtps		NUMERIC(19,4)	,
			@Hora		Char	(08),
			@numticket	NUMERIC(10),
			@acnumticket   NUMERIC(10),
			@numopercar    NUMERIC(10)	

	SELECT	@mtps = 0				,
			@Hora = convert(Char(08),Getdate(),108),
			@numticket = @numoper

	--- PRIMERO, GRABAR LA COMPRA

	INSERT INTO MOV_ticketbonext (	
			mofecpro		, 
			morutcart		, 
			monumdocu		, 
			monumoper		,
			motipoper		,
			cod_nemo		,
			cod_familia		,
			id_instrum		,
			morutcli			,
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
			operador_banco		,
			tipo_inversion		,
			momontoemi		,
			forma_pago		,
			base_tasa		,
			cod_emi		,
			mofecneg		,
			mofecucup		,
			mofecpcup		,
			mohoraop		,
			cusip			,
			capitalpeso		,
			Hora			,
                        		DurMacaulay             	,
                        		DurModificada           	,
                        		Convexidad              	,
			Id_Area_Responsable	,
			Id_Libro			,
			mesa_origen		,
			mesa_destino		,
			cartera_destino		,
			operacion_relacionada)

	VALUES	(	@fecpro	,
			@rutcart		,
			@numoper		,
			@numoper		,
			'CP'			,
			@cod_nemo		,
			@cod_familia		,
			@id_instrum		,
			@rutcli			,
			@codcli			,
			@fecemi		,
			@fecven		,
			@monemi		,
			@monpag		,
			@tasemi		,
			@basemi		,
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
			@observ		,
			@basilea		,
			@tipo_tasa		,
			@encaje		,
			@monto_encaje		,
			@codigo_carterasuper	,
			@Tipo_Cartera_Financiera,
			@operador_banco	,
			@tipo_inversion		,
			@monto_emi		,
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
                        		@DurMacaulay            	,
                        		@DurModificada          	,
                        		@Convexidad             	,
			@Id_Area_Resp		,
			@Id_Libro		,
			@cod_mesa_origen	,
			@cod_mesa_destino	,
			@cod_cartera_destino	,
			0)

	   IF @@error <> 0 BEGIN

	      SELECT -1,
        	     'Error: al crear el nuevo registro de Compras en la tabla MOV_ticketbonext.'
	      	
	      SET NOCOUNT OFF         --ADO
	      RETURN

	   END
	-- Aqui debo generar el nuevo correlativo

	UPDATE text_arc_ctl_dri
    	SET acnumticket = acnumticket + 1
	SELECT @acnumticket = acnumticket FROM text_arc_ctl_dri

	--- SEGUNDO, GRABAR LA CONTRAPARTIDA (LA VENTA)
		INSERT INTO MOV_ticketbonext (	
			mofecpro		, 
			morutcart		, 
			monumdocu		, 
			monumoper		,
			motipoper		,
			cod_nemo		,
			cod_familia		,
			id_instrum		,
			morutcli			,
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
			operador_banco		,
			tipo_inversion		,
			momontoemi		,
			forma_pago		,
			base_tasa		,
			cod_emi		,
			mofecneg		,
			mofecucup		,
			mofecpcup		,
			mohoraop		,
			cusip			,
			capitalpeso		,
			Hora			,
                        		DurMacaulay             	,
                        		DurModificada           	,
                        		Convexidad              	,
			Id_Area_Responsable	,
			Id_Libro			,
			mesa_origen		,
			mesa_destino		,
			cartera_destino		,
			operacion_relacionada)

	VALUES	(	@fecpro	,
			@rutcart		,
			@acnumticket		,
			@acnumticket		,
			'VP'			,
			@cod_nemo		,
			@cod_familia		,
			@id_instrum		,
			@rutcli			,
			@codcli			,
			@fecemi		,
			@fecven		,
			@monemi		,
			@monpag		,
			@tasemi		,
			@basemi		,
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
			@observ		,
			@basilea		,
			@tipo_tasa		,
			@encaje		,
			@monto_encaje		,
			@codigo_carterasuper	,
			@cod_cartera_destino	,
			@operador_banco	,
			@tipo_inversion		,
			@monto_emi		,
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
                        		@DurMacaulay            	,
                        		@DurModificada          	,
                        		@Convexidad             	,
			@Id_Area_Resp		,
			@Id_Libro		,
			@cod_mesa_destino	,
			@cod_mesa_origen	,
			@Tipo_Cartera_Financiera,
			 @numticket)

	   IF @@error <> 0 BEGIN

	      SELECT -1,
        	     'Error: al crear el nuevo registro de Ventas en la tabla MOV_ticketbonext.'
	      	
	      SET NOCOUNT OFF         --ADO
	      RETURN

	   END


	--- TERCERO, GRABAR LA CARTERA, con el correlativo de la compra (@numoper)

	INSERT INTO CAR_ticketbonext (	
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
			tipo_inversion		,
			cptasemi		,
			cpbasemi		,
			forma_pago		,
			base_tasa		,
			operador_Banco		,
			monto_emision		,
			cpcodemi		,
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
			Id_Libro		,
			mesa_origen		,
			mesa_destino		,
			cartera_destino		,
			operacion_relacionada)

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
			@tipo_inversion		,
			@tasemi			,
			@basemi			,
			@forma_pago		,
			@base_tasa		,
			@operador_Banco		,
			@monto_emi		,
			@cod_emi		,
			@fec_neg		,
			0			,
			' '			,
			0			,
			@cusip			,
			@principal		,
			@usuario		,
			@Hora			,
                        		@DurMacaulay            ,
                        		@DurModificada          ,
                        		@Convexidad             ,
			@Id_Area_Resp		,
			@Id_Libro		,
			@cod_mesa_origen	,
			@cod_mesa_destino	,
			@cod_cartera_destino	,
			0)


	   IF @@error <> 0 BEGIN

	      SELECT -1,
        	     'Error: al crear el nuevo registro en la tabla CAR_ticketbonext.'
	      	
	      SET NOCOUNT OFF         --ADO
	      RETURN

	   END

	
	SELECT 'SI', @numoper, @acnumticket

	SET NOCOUNT OFF
END

GO
