USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_RPT_PAP_OPEIM]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_RPT_PAP_OPEIM]	
(	
        @tipoper	CHAR(3)
	,	@monumoper	FLOAT
	,	@CatLibro	CHAR(10) = '1552'
	,	@CatCartNorm	CHAR(10) = '1111'
	,	@CatCartFin	CHAR(10) = '204'
	,	@CatMesas	CHAR(10) = '245'
)
						
AS
BEGIN

Declare @firma1 CHAR(15)
Declare @firma2	 CHAR(15)
	
	   Select @firma1=res.Firma1,
		 @firma2=res.Firma2
	   From BacLineas..detalle_aprobaciones res
	   Where res.Numero_Operacion=@monumoper

	   Select @firma1=IsNull(@Firma1,''),
		  @firma2=IsNull(@Firma2,'')


	SET NOCOUNT ON


	CREATE TABLE #tmp_papeleta (	
			tem_mofecpro			DATETIME	NOT NULL DEFAULT ' '	,--1
			tem_morutcart			NUMERIC(9)	NOT NULL DEFAULT 0	,--2
			tem_nombre_cart		CHAR (70)	NOT NULL DEFAULT ' '	,--3
			tem_monumdocu		NUMERIC(12)	NOT NULL DEFAULT 0	,--4
			tem_monumoper			NUMERIC(12)	NOT NULL DEFAULT 0	,--5
			tem_Correlativo			NUMERIC(12)	NOT NULL DEFAULT 1	,--6	
			tem_motipoper			CHAR(3)	NOT NULL DEFAULT ' '	,--7
			tem_cod_familia			NUMERIC(4)	NOT NULL DEFAULT 0	,--8
			tem_nom_familia			CHAR (20)	NOT NULL DEFAULT ' '	,--9
			tem_id_instrum			CHAR (30)	NOT NULL DEFAULT ' '	,--10
			tem_morutcli			NUMERIC(9)	NOT NULL DEFAULT 0	,--11
			tem_nom_cli			CHAR (100)	NOT NULL DEFAULT ' '	,--12
			tem_mofecemi			DATETIME	NOT NULL DEFAULT ' '	,--13
			tem_mofecven			DATETIME	NOT NULL DEFAULT ' '	,--14
			tem_momonemi			NUMERIC(3, 0)	NOT NULL DEFAULT 0	,--15
			tem_glosa_monemi		CHAR(35)	NOT NULL DEFAULT 0	,	--16
			tem_motasemi			NUMERIC(19, 7)	NOT NULL DEFAULT 0	,--17
			tem_mobasemi			NUMERIC(3, 0)	NOT NULL DEFAULT 0	,--18
			tem_morutemi			NUMERIC(9)	NOT NULL DEFAULT 0	,--19
			tem_nom_emi			CHAR(100)	NULL DEFAULT ' '	,--20
			tem_mofecpago			DATETIME	NOT NULL DEFAULT ' '	,--21
			tem_monominal			NUMERIC(19, 4)	NOT NULL DEFAULT 0	,--22
			tem_movalcomu			FLOAT 		NOT NULL DEFAULT 0	,	--23
			tem_movpresen			NUMERIC(19, 4)	NOT NULL DEFAULT 0	,--24
			tem_movalvenc			NUMERIC(19, 4)	NOT NULL DEFAULT 0	,--25
			tem_motir			NUMERIC(19, 7)	NOT NULL DEFAULT 0	,--26
			tem_mopvp			NUMERIC(19, 7)	NOT NULL DEFAULT 0	,--27
			tem_movpar			NUMERIC(19, 8)	NOT NULL DEFAULT 0	,--28
			tem_moint_compra		NUMERIC(19, 4)	NOT NULL DEFAULT 0	,--29
			tem_moprincipal			NUMERIC(19, 4)	NOT NULL DEFAULT 0	,--30
			tem_movalven			NUMERIC(19, 4)	NOT NULL DEFAULT 0	,--31
			tem_basilea			NUMERIC(1)	NOT NULL DEFAULT ' '	,--32
			tem_glosa_basilea		CHAR(30)	NOT NULL DEFAULT ' '	,--33
			tem_tipo_tasa			NUMERIC(3)	NOT NULL DEFAULT ' '	,--34
			tem_glosa_tipo_tasa		CHAR(25)	NOT NULL DEFAULT ' '	,--35
			tem_encaje			CHAR(1)		NOT NULL DEFAULT ' '	,--36
			tem_enca_sn			CHAR(2)		NOT NULL DEFAULT ' '	,--37
			tem_monto_encaje		NUMERIC(19, 4)	NOT NULL DEFAULT 0	,--38
			tem_codigo_carterasuper	CHAR (1)	NOT NULL DEFAULT ' '	,--39
			tem_glosa_carterasuper		CHAR(50)	NOT NULL DEFAULT ' '	,--40
			tem_Tipo_Cartera_Financiera	CHAR (1)	NOT NULL DEFAULT ' '	,--41
			tem_sucursal			SMALLINT 	NOT NULL DEFAULT ' '	,--42
			tem_nom_sucu			CHAR(70)	NOT NULL DEFAULT ' '	,--43
			tem_corr_bco_nombre		CHAR(50)	NOT NULL DEFAULT ' '	,--44
			tem_corr_bco_cta		CHAR(30)	NOT NULL DEFAULT ' '	,--45
			tem_corr_bco_aba		CHAR(09)	NOT NULL DEFAULT ' '	,--46
			tem_corr_bco_pais		CHAR(15)	NOT NULL DEFAULT ' '	,--47
			tem_corr_bco_ciud		CHAR(15)	NOT NULL DEFAULT ' '	,--48
			tem_corr_bco_swift		CHAR(30)	NOT NULL DEFAULT ' '	,--49
			tem_corr_bco_ref		CHAR(30)	NOT NULL DEFAULT ' '	,--50
			tem_corr_cli_nombre		CHAR(50)	NOT NULL DEFAULT ' '	,--51
			tem_corr_cli_cta		CHAR(30)	NOT NULL DEFAULT ' '	,--52
			tem_corr_cli_aba		CHAR(09)	NOT NULL DEFAULT ' '	,--53
			tem_corr_cli_pais		CHAR(15)	NOT NULL DEFAULT ' '	,--54
			tem_corr_cli_ciud		CHAR(15)	NOT NULL DEFAULT ' '	,--55
			tem_corr_cli_swift		CHAR(30)	NOT NULL DEFAULT ' '	,--56
			tem_corr_cli_ref		CHAR(30)	NOT NULL DEFAULT ' '	,--57
			tem_operador_contraparte	CHAR(30)	NOT NULL DEFAULT ' '	,--58
			tem_operador_banco		CHAR(60)	NOT NULL DEFAULT ' '	,--59
			tem_tipo_operacion		NUMERIC(02)	NOT NULL DEFAULT ' '	,--60
			tem_nom_operacion		CHAR(20)	NOT NULL DEFAULT ' '	,--61
			tem_para_quien			CHAR(15)	NOT NULL DEFAULT ' '	,--62
			tem_glosa_para_quien		CHAR(15)	NOT NULL DEFAULT ' '	,	--63
			tem_glosa_car_financiera	CHAR(50)	NOT NULL DEFAULT ' '	,--64
			tem_calce			CHAR(50)	NULL DEFAULT ' '	,--65  -- JBH, 04-12-2009 era CHAR(10)
			tem_calce_glosa		char(50)		NOT NULL DEFAULT ' '	,--66  --JBH, 04-12-2009 era CHAR(10)	
			tem_nombre_custodia		char(50)		NOT NULL DEFAULT ' '	,--67
			TEM_FECHA_IMP		DATETIME	NOT NULL DEFAULT ' '	,	--68
			TITULO				char(100)	NOT NULL DEFAULT ' '	,	--69
			TEM_MONTOEMI		numeric(19,4)	NOT NULL DEFAULT 0	,	--70
			TEM_MOMONPAG		CHAR(40)	NOT NULL DEFAULT ' '	,	--71
			tem_mostatreg			char(1)		NOT NULL DEFAULT ' '	,	--72
			autori1				char(80)		NOT NULL DEFAULT ' '	,		--73
			autori2				char(80)		NOT NULL DEFAULT ' '	,		--74
			autori3				char(80)		NOT NULL DEFAULT ' '	,		--75
			TEM_moobserv			CHAR(80)	NOT NULL DEFAULT ' '	,	--76
			base_tasa			char(100)		not null default ' '	,			--77 (15)
			tem_forma_pago			char(100)		not null default ' '	,			--78 (80)
			tem_confirmacion		char(100)		not null default ' '	,			--79 (80)
			MONTO		      	NUMERIC(19,4)	NOT NULL DEFAULT 0	,	--80
			TiTulo2				char(100)		NOT NULL DEFAULT ' '	,		--81 (80)
			FECHA_NEG			DATETIME 	NOT NULL DEFAULT ' '	,	--82
			hora				CHAR(12)	NOT NULL DEFAULT ' '	,	--83
			calsificador1			char(100)		NULL DEFAULT ' '	,		--84 (30)
			calsificador2			char(100)		NULL DEFAULT ' '	,		--85 (30)
			clasif1				char(100)		NULL DEFAULT ' '	,		--86 (30)
			clasif2				char(100)		NULL DEFAULT ' '	,		--87 (30)
               		NombreEntidad                   	char(100)		NOT NULL DEFAULT ' '	,		--88 (50)
			DireccEntidad                   	char(100)		NOT NULL DEFAULT ' '	,		--89 (50)
			aprobacion			char(100)		NOT NULL DEFAULT ' '	,		--90 (15)
			observacion			char(1000)	NOT NULL DEFAULT ' '	,	--91
			utilidad	      			NUMERIC(19,4)	NOT NULL DEFAULT 0	,	--92
			perdida		      		NUMERIC(19,4)	NOT NULL DEFAULT 0	,	--93
			nemomoneda			char(30)		NOT NULL DEFAULT ' '	,		--94	(10)
			firma1				char(15)		NOT NULL DEFAULT ' '	,		--95		
			firma2				char(15)		NOT NULL DEFAULT ' '	,		--96
			Glosa_Libro			CHAR(50)	NULL	 DEFAULT ' ',			--97
			codigo_mesa_origen		SMALLINT	NOT NULL DEFAULT 0,			-- JBH, 03-11-2009  	-- 98
			codigo_mesa_destino		SMALLINT	NOT NULL DEFAULT 0,						-- 99
			codigo_cartera_destino		SMALLINT	NOT NULL DEFAULT 0,						-- 100
			nombre_mesa_origen		CHAR(50)	NULL DEFAULT ' ',						-- 101
			nombre_mesa_destino		CHAR(50)	NULL DEFAULT ' ',						-- 102
			nombre_cartera_origen		CHAR(50)	NULL DEFAULT ' ',						-- 103
			nombre_cartera_destino		CHAR(50)	NULL DEFAULT ' '   )						-- 104


	DECLARE @rut_cli	 	numeric	(9)	,
		@rut_emi		numeric	(9)	,
		@rut_car		numeric	(9)	,
		@cod_familia		numeric	(4)	,
		@cod_basilea 		NUMERIC	(1)	,
		@cod_tipo_tasa 		numeric	(3)	,
		@cod_encaje 		char	(1)	,
		@cod_sucu 		smallint	,
		@cod_tipo_inver		numeric (2)	,
		@codigo_carterasuper 	char	(5)	,
		@codigo_car_financiera  char	(1)	,
		@calce			char	(1)	,
		@nombre_custodia	char	(30)	,
		@para_quien		char	(1)	,
		@nominal		numeric(19,4)	,
		@base_tasa		char(20)	,
		@glosa_base_tasa	char(15)	,
		@cod_emi		numeric(1)	,
		@cod_cli		numeric(9)	,
		@MONTO		NUMERIC(19,4)   ,
	             @FECHA                   	DATETIME,
		@FECHAIM		DATETIME,
		@cod_mesa_origen	SMALLINT,
		@cod_mesa_destino	SMALLINT,
		@cod_cart_origen	SMALLINT,
		@cod_cart_destino	SMALLINT,
		@nom_mesa_origen	CHAR(50),
		@nom_mesa_destino	CHAR(50),
		@nom_cart_origen	CHAR(50),
		@nom_cart_destino	CHAR(50)		

  
	DECLARE @maxerrores 		INTEGER		,
		@GlosaErrores 		CHAR(1000)	,
		@GlosaErr		CHAR(1000)
	--- La Fecha de proceso viene en el archivo de control text_arc_ctl_dri (acfecproc)

	SELECT @FECHA = acfecproc
	FROM text_arc_ctl_dri 

	select 	@rut_cli 		= morutcli		,
		@rut_emi	 	= morutemi		,
		@rut_car		= morutcart		,
		@cod_familia		= cod_familia		,
		@cod_basilea 		= basilea		,
		@cod_tipo_tasa 		= tipo_tasa		,
		@cod_encaje 		= encaje		,
		@cod_tipo_inver		= convert(numeric(1),tipo_inversion)	,
		@cod_sucu 		= sucursal	,
		@codigo_carterasuper 	= codigo_carterasuper	,
		@calce			= calce			,
		@para_quien		= para_quien		,
		@base_tasa		= base_tasa		,
		@cod_cli		= mocodcli		,
		@cod_emi		= cod_emi		,
		@MONTO		= momtum		

	from 	text_mvt_dri
	WHERE 	monumoper = @monumoper
 AND     MOFECPRO  = @FECHA



/*
Movimientos de papeles intramesas
*/

	SELECT @FECHAIM = acfecproc
	FROM text_arc_ctl_dri


select 		@rut_cli 		= morutcli		,
		@rut_emi	 	= morutemi		,
		@rut_car		= morutcart		,
		@cod_familia		= cod_familia		,
		@cod_basilea 		= basilea		,
		@cod_tipo_tasa 	= tipo_tasa		,
		@cod_encaje 		= encaje		,
		--@cod_tipo_inver	= convert(numeric(1),tipo_inversion)	,
		@cod_tipo_inver	=(CASE WHEN RTRIM(LTRIM(tipo_inversion)) ='' THEN 0 ELSE CONVERT(NUMERIC(2), tipo_inversion) END),
		@codigo_carterasuper 	= codigo_carterasuper	,
		@calce			= ' '			,
		@para_quien		=' '	,
		@base_tasa		= base_tasa		,
		@cod_cli		= mocodcli		,
		@cod_emi		= cod_emi		,
		@MONTO		= momtum		,
		@cod_mesa_origen	= mesa_origen		,
		@cod_mesa_destino 	= mesa_destino		,
		@cod_cart_origen	= CONVERT(SMALLINT, tipo_cartera_financiera),
		@cod_cart_destino 	= cartera_destino

		from 	MOV_ticketbonext
	WHERE 	monumoper = @monumoper
 AND     MOFECPRO  = @FECHA 


Insert into #tmp_papeleta
		SELECT	mofecpro   		,	--1
			morutcart 		,	--2
			' ' 			,	--3
			monumdocu	  	,  	--4
			monumoper		, 	--5
			mocorrelativo		,	--6
			motipoper 	 	,	--7
			cod_familia		,	--8
			' '			,	--9
			id_instrum		,	--10
			morutcli   		,	--11
			' '			,	--12
			mofecemi   		,	--13
			mofecven   		,	--14
			momonemi		,	--15
			(SELECT MNGLOSA FROM VIEW_moneda WHERE momonemi = MNCODMON),	--16
			motasemi		,	--17
			mobasemi		,	--18
			morutemi		,	--19
			(select  nom_emi from text_emi_itl where rut_emi = morutemi and codigo = cod_emi)	,	--20
			mofecpago		,	--21
			monominal 		,	--22
			--(CASE WHEN LTRIM(RTRIM(motipoper)) = 'CP' THEN movalcomu ELSE movalven END ),	--23
			movalcomu,	--23
			movpresen  		,	--24
			movalvenc  		,	--25
			motir     		,		--26
			mopvp      		,	--27
			movpar			,	--28
			moint_compra		,	--29
			moprincipal 		,	--30
			movalven		,	--31
			basilea			,	--32
			' '			,	--33
			tipo_tasa		,	--34
			' '			,	--35
			encaje 			,	--36
			' '			,	--37
			monto_encaje		,	--38
			codigo_carterasuper	,	--39
			(SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartNorm AND TBCODIGO1 = codigo_carterasuper),	--40
			Tipo_Cartera_Financiera	,	--41
			ISNULL(sucursal,0) 		,	--42
			' '			,	--43
			' ', 	--corr_bco_nombre   	,	--44
			' ',	--corr_bco_cta      	,	--45
			' ',	--corr_bco_aba		,	--46
			' ',	--corr_bco_pais		,	--47
			' ',	--corr_bco_ciud		,	--48
			' ',	--corr_bco_swift		,	--49
			' ',	--corr_bco_ref  		,	--50
			' ',	--corr_cli_nombre		,	--51
			' ',	--corr_cli_cta   		,	--52
			' ',	--corr_cli_aba		,	--53
			' ',	--corr_cli_pais		,	--54
			' ',	--corr_cli_ciud		,	--55
			' ',	--corr_cli_swift		,	--56
			' ',	--corr_cli_ref  		,	--57
			' ',	--operador_contraparte	,	--58
			operador_Banco		,		--59
			(CASE WHEN RTRIM(LTRIM(tipo_inversion)) ='' THEN 0 ELSE CONVERT(NUMERIC(2), tipo_inversion) END),
			--convert(numeric(2),tipo_inversion) 		,	--60
			' ',
			' '			,	--61
			' ',	--para_quien		,	--62
			' '			,	--63
			(SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartFin AND TBCODIGO1 = Tipo_Cartera_Financiera)	,	--64
			' ',	--calce			,	--65
			' '			,	--66

			' ',	--Nombre_custodia		,	--67
			B.ACFECPROC		,	--68
			(CASE WHEN motipoper = 'CP' THEN 'INVERSIONES EN EL EXTERIOR - COMPRA Nº ' + convert(char(10),monumoper)
			      WHEN motipoper = 'VP' THEN 'INVERSIONES EN EL EXTERIOR - VENTA  Nº ' + convert(char(10),monumoper)
			      WHEN motipoper = 'VP' AND mostatreg = 'P' THEN 'INVERSIONES EN EL EXTERIOR - VENTA PARCIAL Nº ' + convert(char(10),monumoper) END),	--69
			momontoemi,	--70
			(SELECT MNGLOSA FROM VIEW_moneda WHERE momonPAG = MNCODMON),	--71
			mostatreg,	--72
			' ',		--73
			' ',		--74
			' ',		--75
			moobserv,	--76
			base_tasa,	--77
			isnull((select glosa from VIEW_forma_de_pago where codigo = forma_pago),' '),	--78
			isnull((select tbglosa from VIEW_TABLA_GENERAL_DETALLE where tbcateg = 1107 ),' '),	--79
			0,	--80
			(CASE WHEN mostatreg = 'A' THEN 'ANULACIÓN' else ' ' end),	--81
			MOFECNEG,	--82
			(convert(char(8),mohoraop,108))	,	--83
			(select CLASIFICACION1  from text_emi_itl where morutemi = rut_emi and cod_emi = codigo ),	--84
			(select CLASIFICACION2 from text_emi_itl where morutemi = rut_emi and cod_emi = codigo ),		--85
			case 	when cod_familia  = 2000 then (select tipo_largo1 from text_emi_itl where morutemi = rut_emi and cod_emi = codigo )  else (select tipo_corto1 from text_emi_itl where morutemi = rut_emi and cod_emi = codigo ) end ,	--86
			case 	when cod_familia  = 2000 then (select tipo_largo2 from text_emi_itl where morutemi = rut_emi and cod_emi = codigo )  else (select tipo_corto2 from text_emi_itl where morutemi = rut_emi and cod_emi = codigo ) end ,	--87
                        		ISNULL( (Select rcnombre from view_entidad),' ' ),	--88
			ISNULL( (Select rcdirecc from view_entidad),' ' ),		--89
			ISNULL(CASE 	WHEN mostatreg = 'A' THEN 'ANULACION'	
					WHEN mostatreg = 'P' THEN 'PENDIENTE'	
					WHEN mostatreg = 'R' THEN 'RECHAZADO' ELSE '' END,''),	--90
			' ',	--91
			moutilidad,	--92
			moperdida,	--93
			(SELECT MNNEMO FROM VIEW_moneda WHERE momonemi = MNCODMON)	--94
			,@firma1,	--95
			@firma2		--96
		,	(SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatLibro AND TBCODIGO1 = Id_Libro)	--97
		,	@cod_mesa_origen
		,	@cod_mesa_destino
		,	@cod_cart_destino
		,	''
		,	''
		,	''
		,	''
		
	 	FROM	MOV_ticketbonext
		,	text_arc_ctl_dri B
		WHERE 	monumoper = @monumoper
                AND     MOFECPRO  = @FECHAIM
/*
Actualizar tmp_papeleta con los codigos y nombres de las mesas y las carteras, JBH, 03-11-2009
*/
		UPDATE #tmp_papeleta
		SET nombre_mesa_origen = tbglosa 
		FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE 
		WHERE tbcateg = @CatMesas AND tbcodigo1 = codigo_mesa_origen

		UPDATE #tmp_papeleta
		SET nombre_mesa_destino = tbglosa 
		FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE 
		WHERE tbcateg = @CatMesas AND tbcodigo1 = codigo_mesa_destino

		UPDATE #tmp_papeleta
		SET nombre_cartera_origen = tbglosa 
		FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE 
		WHERE tbcateg = @CatCartFin AND tbcodigo1 = CONVERT(SMALLINT, tem_Tipo_cartera_financiera)

		UPDATE #tmp_papeleta
		SET nombre_cartera_destino = tbglosa 
		FROM bacparamsuda.dbo.TABLA_GENERAL_DETALLE 
		WHERE tbcateg = @CatCartFin AND tbcodigo1 = codigo_cartera_destino

/*
Fin actualización, JBH, 03-11-2009
*/
	declare	@nom_cli		 	char	(70)	,
		@nom_cod			char 	(15)	,
		@nom_emi       			char	(60)	,
		@nom_car			char	(70)	,
		@nom_basilea			char	(20)	,
		@nom_tip_tasa			char	(35)	,
		@nom_encaje			char	(20) 	,
		@nom_sucu			char	(70)	,
		@nom_inversion			char	(30)	,
		@glosa_carterasuper 		char 	(30)	,
		@calce_glosa			char	(10)	,
		@glosa_para_quien		char	(35)	,
		@max               		INTEGER		,
		@x                 		INTEGER


	select	@nom_cli = clnombre  
	from  	VIEW_CLIENTE
	where	clrut = @rut_cli
	and 	clcodigo =  @cod_cli

	select	@nom_car = clnombre  
	from  	VIEW_CLIENTE
	where	clrut = @rut_car	
	select  @nom_cod = nom_familia
	from	text_fml_inm 
	where 	cod_familia = @cod_familia

	select 	@nom_basilea = tbglosa 
	from 	VIEW_TABLA_GENERAL_DETALLE 
	where 	tbcateg = 1101 and tbcodigo1 = @cod_basilea 

	select 	@glosa_para_quien = ISNULL(tbglosa, ' ')	 
	from 	VIEW_TABLA_GENERAL_DETALLE 
	where 	tbcateg = 1105
	AND	tbcodigo1 = @para_quien

	select 	@nom_tip_tasa = tbglosa
	from 	VIEW_TABLA_GENERAL_DETALLE 
	where 	tbcateg = 1102 and tbcodigo1 = @cod_tipo_tasa


	if @cod_encaje = 'S' 
		select @nom_encaje = 'SI'
	else begin
		select @nom_encaje = 'NO'
	end 

	if @calce= 'S' 
		select @calce_glosa = 'SI'

	else begin
		select @calce_glosa = 'NO'
	end 

	select @nom_sucu  = ISNULL (ofi_nom, ' ' )
	from ttab_ofi 
	where ofi_cod = @cod_sucu

	Select @nom_inversion = tbglosa
	From 	VIEW_TABLA_GENERAL_DETALLE 
	Where tbcateg = 1104 and tbcodigo1 = @cod_tipo_inver

	SELECT @nom_inversion = ISNULL(@nom_inversion,'')

	update 	#tmp_papeleta  set
		autori1 = autoriza1	,
		autori2 = autoriza2	,
		autori3 = autoriza3
	from 	text_ctl_fir_ope
	where	tem_monominal > Menor
	and	tem_monominal < Mayor
	or	mayor = 0

	SELECT @x = 1

	SELECT @maxerrores = count(*) FROM VIEW_LINEA_TRANSACCION_DETALLE WHERE NumeroOperacion = @monumoper and Id_Sistema = 'BEX'

	Select @GlosaErrores = ''

	WHILE @x <= @maxerrores
		BEGIN  
			
			SELECT  @GlosaErr  = Mensaje_Error
 			FROM 	VIEW_LINEA_TRANSACCION_DETALLE
			WHERE 	NumeroOperacion 	= @monumoper 
			and   	Error			= 'S'
			and 	NumeroCorre_Detalle 	= @x
			and	Id_Sistema 		= 'BEX'

			Select @GlosaErrores = RTRIM(@GlosaErrores) + ' - ' + RTRIM(@GlosaErr)

		        SELECT @x = @x + 1
		END


	UPDATE 	#tmp_papeleta 
	SET	tem_nom_cli 		= @nom_cli,
		tem_nom_familia 	= @nom_cod,
		tem_glosa_basilea 	= @nom_basilea,					 
		tem_glosa_tipo_tasa 	= isnull(@nom_tip_tasa,' ') ,
		tem_enca_sn		= @nom_encaje,
		--tem_nom_sucu 		= ISNULL (@nom_sucu , ' '),
		tem_nom_operacion 	= @nom_inversion,
		tem_nombre_cart 	= @nom_car,
		tem_calce_glosa 	= @calce_glosa,
		--tem_glosa_para_quien 	= @glosa_para_quien ,
		tem_glosa_para_quien 	= ' ',
		MONTO 		= @MONTO,
		observacion		= ISNULL(@GlosaErrores,'')
	WHERE 	tem_monumoper = @monumoper


	select	* 
	from #tmp_papeleta 
	where tem_monumoper = @monumoper	

	SET NOCOUNT OFF

END

GO
