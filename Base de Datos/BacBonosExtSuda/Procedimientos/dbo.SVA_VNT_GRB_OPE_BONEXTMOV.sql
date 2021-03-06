USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_VNT_GRB_OPE_BONEXTMOV]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE  [dbo].[SVA_VNT_GRB_OPE_BONEXTMOV]
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
			@operador_Banco		CHAR(30)	,--54
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
			@cod_cartera_destino		SMALLINT,
			@CorrelVenta			SMALLINT,
			@Numdocu			NUMERIC(9,0))
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

	--- PRIMERO, GRABAR LA VENTA

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
                        		DurMacaulay            	,
                        		DurModificada          	,
                        		Convexidad             	,
			Id_Area_Responsable	,
			Id_Libro		,
			mesa_origen		,
			mesa_destino		,
			cartera_destino		,
			operacion_relacionada,
			correl_relacion)

	VALUES	(	@fecpro	,
			@rutcart		,
			@Numdocu		,
			@numoper		,
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
                      		@DurMacaulay           	,
                       		@DurModificada         	,
                       		@Convexidad            	,
			@Id_Area_Resp		,
			@Id_Libro		,
			@cod_mesa_origen	,
			@cod_mesa_destino	,
			@cod_cartera_destino	,
			@numticket,
			@CorrelVenta)


	   IF @@error <> 0 BEGIN

	      SELECT -1,
        	     'Error: al crear el nuevo registro de Ventas en la tabla MOV_ticketbonext.'
	      	
	      SET NOCOUNT OFF         --ADO
	      RETURN

	   END
	-- Aqui debo generar el nuevo correlativo

	UPDATE text_arc_ctl_dri
    	SET acnumticket = acnumticket + 1
	SELECT @acnumticket = acnumticket FROM text_arc_ctl_dri

	--- SEGUNDO, GRABAR LA CONTRAPARTIDA (LA COMPRA)
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
			operacion_relacionada,
			correl_relacion)

	VALUES	(	@fecpro	,
			@rutcart		,
			@acnumticket		,
			@acnumticket		,
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
                        		@DurMacaulay            ,
                        		@DurModificada          ,
                        		@Convexidad             ,
			@Id_Area_Resp		,
			@Id_Libro		,
			@cod_mesa_destino	,
			@cod_mesa_origen	,
			@Tipo_Cartera_Financiera,
			0,
			1)

	-- TERCERO, ACTUALIZAR CAR_ticketbonext modificando los valores según si se vendió total o parcial
	-- Buscar el movimiento por @Numdocu y @rutcart
	
	
		DECLARE
			@valor_venta	NUMERIC(19,4),	
			@nFactor_v	NUMERIC(19,4),
			@nFactor_c	NUMERIC(19,4),
			@Status_Reg	CHAR(1)

		DECLARE	
			@c_cpnominal		NUMERIC(19,4),
			@c_cpvalvenc		NUMERIC(19,4),
			@c_cpvalcomp		NUMERIC(19,4),
			@c_cpvalcomu		NUMERIC(19,4),
			@c_cpvptirc		NUMERIC(19,7),
			@c_cpcapital		NUMERIC(19,4),
			@c_cpinteres		NUMERIC(19,4),
			@c_cpreajust		NUMERIC(19,4),
			@c_cpvalmerc		NUMERIC(19,4),
			@c_monto_encaje	NUMERIC(19,4),
			@c_cpprincipal		NUMERIC(19,4),
			@v_cpnominal		NUMERIC(19,4),
			@v_cpvalvenc		NUMERIC(19,4),
			@v_cpvalcomp		NUMERIC(19,4),
			@v_cpvalcomu		NUMERIC(19,4),
			@v_cpvptirc		NUMERIC(19,7),
			@v_cpcapital		NUMERIC(19,4),
			@v_cpinteres		NUMERIC(19,4),
			@v_cpreajust		NUMERIC(19,4),
			@v_cpvalmerc		NUMERIC(19,4),
			@v_monto_encaje	NUMERIC(19,4),
			@v_cpprincipal		NUMERIC(19,4),
			@nUtilidad		NUMERIC(19,4),
			@nPerdida		NUMERIC(19,4),
			--@monemi		NUMERIC(5),
			@Valormoneda		NUMERIC(19,4),
			@montopeso		NUMERIC(24 )

	SELECT	@Status_Reg = ''		,
			@Hora = convert(Char(08),Getdate(),108)

	IF @fecpago > @fecpro SELECT @Status_Reg = 'P'

	SELECT	@c_cpnominal = cpnominal,
			@monemi	     = cpmonemi 	
			FROM	CAR_ticketbonext
			WHERE	cprutcart = @rutcart
			AND	cpnumdocu = @Numdocu

	SELECT	@nFactor_v =  @nominal / @c_cpnominal,
			@nFactor_c = (@c_cpnominal - @nominal) / @c_cpnominal 

	SELECT
			@v_cpvalvenc	= cpvalvenc    * @nFactor_v,
			@v_cpvalcomp	= cpvalcomp    * @nFactor_v,
			@v_cpvalcomu	= cpvalcomu    * @nFactor_v,
			@v_cpvptirc	= cpvptirc     * @nFactor_v,
			@v_cpcapital	= cpcapital    * @nFactor_v,
			@v_cpinteres	= cpinteres    * @nFactor_v,
			@v_cpreajust	= cpreajust    * @nFactor_v,
			@v_cpvalmerc	= cpvalmerc    * @nFactor_v,
			@v_monto_encaje = monto_encaje * @nFactor_v,
			@v_cpprincipal  = cpprincipal  * @nFactor_v	

		 	FROM	CAR_ticketbonext
			WHERE	cprutcart = @rutcart
		AND	cpnumdocu = @Numdocu

	SELECT 	@c_cpnominal	= cpnominal    -  ( case when @fecpago > @fecpro then 0 else @nominal end ) ,
			@c_cpvalvenc	= cpvalvenc    -  @v_cpvalvenc,
			@c_cpvalcomp	= cpvalcomp    -  @v_cpvalcomp,
			@c_cpvalcomu	= cpvalcomu    -  @v_cpvalcomu,
			@c_cpvptirc	= cpvptirc     -  @v_cpvptirc,
			@c_cpcapital	= cpcapital    -  @v_cpcapital,
			@c_cpinteres	= cpinteres    -  @v_cpinteres,
			@c_cpreajust	= cpreajust    -  @v_cpreajust,
			@c_cpvalmerc	= cpvalmerc    -  @v_cpvalmerc,
			@c_monto_encaje = monto_encaje -  @v_monto_encaje

			FROM	CAR_ticketbonext
			WHERE	cprutcart = @rutcart
			AND	cpnumdocu = @Numdocu


	SELECT	
		@nUtilidad = 0,
		@nPerdida = 0

        	SELECT @valor_venta = ROUND(@valor_venta ,2)
	SELECT @v_cpvptirc  = ROUND(@v_cpvptirc ,2)

	IF @v_cpvptirc < @valor_venta 	SELECT @nUtilidad = @valor_venta - @v_cpvptirc
	IF @v_cpvptirc > @valor_venta 	SELECT @nPerdida = @v_cpvptirc  - @valor_venta


	IF @Status_Reg = 'P'
		UPDATE CAR_ticketbonext
		SET	cpnomi_vta	= cpnomi_vta + @nominal
		WHERE cprutcart = @rutcart
		AND	 cpnumdocu = @Numdocu
	ELSE
		UPDATE CAR_ticketbonext
		SET	cpnominal	= @c_cpnominal,
			cpvalvenc	= @c_cpvalvenc,
			cpvalcomp	= @c_cpvalcomp,
			cpvalcomu	= @c_cpvalcomu,
			cpvptirc 	= @c_cpvptirc,
			cpcapital	= @c_cpcapital,
			cpinteres	= @c_cpinteres,
			cpreajust	= @c_cpreajust,
			cpvalmerc 	= @c_cpvalmerc,
			monto_encaje	= @c_monto_encaje,
			cpprincipal     = (@c_cpnominal	* cppvpcomp / 100 )

		WHERE cprutcart = @rutcart
		AND	 cpnumdocu = @Numdocu

	
	  IF @@error <> 0 BEGIN
	   	SELECT -1, 'Error: al crear el nuevo registro de Ventas en la tabla MOV_ticketbonext.'
	      	SET NOCOUNT OFF         --ADO
	      	RETURN
	 END

	SELECT 'SI', @numoper, @acnumticket

	SET NOCOUNT OFF
END

GO
