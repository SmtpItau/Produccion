USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_RPT_OPE_DIA]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SVC_RPT_OPE_DIA]
	(	@TIPO					CHAR(03)	,
		@FEC1					CHAR(8)		,
		@NUM_SUCU1				FLOAT		,
		@NUM_SUCU2				FLOAT		,
		@Cartera_INV    		INTEGER		,
		@Tipo_Oper				CHAR(10)= '',

		@Id_Cartera_Normativa	CHAR(10)= '',
		@Id_Libro				CHAR(10)= '',
		@Id_Area_Responsable	CHAR(10)= '',

		@Cat_Cartera_Normativa	CHAR(10)= '0',
		@Cat_Libro				CHAR(10)= '0',
		@Cat_Area_Responsable	CHAR(10)= '0'
	)
AS
BEGIN

	DECLARE	@NombreEntidad				char(50),
			@DireccEntidad				char(50)

	DECLARE @Glosa_Cartera				CHAR(20),
			@Glosa_Cartera_Normativa	CHAR(50),
			@Glosa_Libro				CHAR(50),
			@Glosa_Area_Responsable		CHAR(50)

	Select	@Glosa_Cartera				= ''
	,		@Glosa_Cartera_Normativa	= ''
	,		@Glosa_Libro				= ''
	,		@Glosa_Area_Responsable		= ''

	SELECT	@Glosa_Cartera				= IsNull(rcnombre,'')
	FROM	VIEW_TIPO_CARTERA
	WHERE	rcsistema					= 'BEX'
	AND		rccodpro					= @Tipo_Oper
	AND		rcrut						= @Cartera_INV

	IF @Glosa_Cartera = ''
		SELECT @Glosa_Cartera = '< TODAS >'

	IF @Id_Cartera_Normativa = ''
	BEGIN
		SELECT @Glosa_Cartera_Normativa		= '< TODAS >'
	END ELSE
	BEGIN
		SELECT	@Glosa_Cartera_Normativa	= ISNULL(TBGLOSA,'GLOSA NO ENCONTRADA')
		FROM	VIEW_TABLA_GENERAL_DETALLE
		WHERE	TBCATEG						= @Cat_Cartera_Normativa
		AND		TBCODIGO1					= @Id_Cartera_Normativa
	END

	IF @Id_Libro = '' 
	BEGIN
		SELECT	@Glosa_Libro = '< TODAS >'
	END	ELSE
	BEGIN
		SELECT	@Glosa_Libro				= ISNULL(TBGLOSA,'GLOSA NO ENCONTRADA')
		FROM	VIEW_TABLA_GENERAL_DETALLE
		WHERE	TBCATEG						= @Cat_Libro
		AND		TBCODIGO1					= @Id_Libro
	END

	IF @Id_Area_Responsable = ''
	BEGIN 
		SELECT @Glosa_Area_Responsable	= '< TODAS >'
	END	ELSE 
	BEGIN
		SELECT	@Glosa_Area_Responsable = ISNULL(TBGLOSA,'GLOSA NO ENCONTRADA')
		FROM	VIEW_TABLA_GENERAL_DETALLE
		WHERE	TBCATEG					= @Cat_Area_Responsable
		AND		TBCODIGO1				= @Id_Area_Responsable
	END

	SELECT	@NombreEntidad  = rcnombre
	,		@DireccEntidad	= rcdirecc 
	FROM	view_entidad

	SET NOCOUNT ON

	CREATE TABLE #TMP_PAPELETA (	
			TEM_MOFECPRO				DATETIME		NOT NULL DEFAULT ' '	,--1
			TEM_MORUTCART				NUMERIC(9, 0)	NOT NULL DEFAULT 0		,--2
			TEM_NOMBRE_CART				CHAR (60)		NOT NULL DEFAULT ' '	,--3
			TEM_MONUMDOCU				NUMERIC(12, 0)	NOT NULL DEFAULT 0		,--4
			TEM_MONUMOPER				NUMERIC(12, 0)	NOT NULL DEFAULT 0		,--5
			TEM_MOTIPOPER				CHAR(3)			NOT NULL DEFAULT ' '	,--6
			TEM_COD_FAMILIA				NUMERIC(5, 0)	NOT NULL DEFAULT 0		,--7
			TEM_NOM_FAMILIA				CHAR (40)		NOT NULL DEFAULT ' '	,--8
			TEM_ID_INSTRUM				CHAR (20)		NOT NULL DEFAULT ' '	,--9
			TEM_MORUTCLI				NUMERIC(9, 0)	NOT NULL DEFAULT 0		,--10
			TEM_MOCODCLI				NUMERIC (1)		NOT NULL DEFAULT 0		,--11
			TEM_NOM_CLI					CHAR (60)		NOT NULL DEFAULT ' '	,--12
			TEM_MOFECEMI				CHAR(10)		NOT NULL DEFAULT ' '	,--13
			TEM_MOFECVEN				CHAR(10)		NOT NULL DEFAULT ' '	,--14
			TEM_MOMONEMI				NUMERIC(3)		NOT NULL DEFAULT 0		,--15
			TEM_GLOSA_MONOEMI			CHAR(30)		NOT NULL DEFAULT ' '	,--16
			TEM_MOTASEMI				NUMERIC(19, 4)	NOT NULL DEFAULT 0		,--17
			TEM_MOBASEMI				NUMERIC(3, 0)	NOT NULL DEFAULT 0		,--18
			TEM_MORUTEMI				NUMERIC(9, 0)	NOT NULL DEFAULT 0		,--19
			TEM_NOM_EMI					CHAR(60)		NOT NULL DEFAULT ' '	,--20
			TEM_MOFECPAGO				CHAR(10)		NOT NULL DEFAULT ' '	,--21
			TEM_MONOMINAL				NUMERIC(19, 4)	NOT NULL DEFAULT 0		,--22
			TEM_MOMTUM					NUMERIC(19, 4)	NOT NULL DEFAULT 0		,--23
			TEM_MOVALCOMU				NUMERIC(19, 4)	NOT NULL DEFAULT 0		,--24
			TEM_MOVPRESEN				NUMERIC(19, 4)	NOT NULL DEFAULT 0		,--25
			TEM_MOVALVENC				NUMERIC(19, 4)	NOT NULL DEFAULT 0		,--26
			TEM_MOMTPS					NUMERIC(19, 4)	NOT NULL DEFAULT 0		,--27
			TEM_MOTIR					NUMERIC(19, 7)	NOT NULL DEFAULT 0		,--28
			TEM_MOPVP					NUMERIC(19, 7)	NOT NULL DEFAULT 0		,--29
			TEM_MOVPAR					NUMERIC(19, 9)	NOT NULL DEFAULT 0		,--30
			TEM_MOINT_COMPRA			NUMERIC(19, 4)	NOT NULL DEFAULT 0		,--31
			TEM_MOPRINCIPAL				NUMERIC(19, 4)	NOT NULL DEFAULT 0		,--32
			TEM_MOVALVEN				NUMERIC(19, 4)	NOT NULL DEFAULT 0		,--33
			TEM_BASILEA					NUMERIC(1)		NOT NULL DEFAULT 0		,--34
			TEM_GLOSA_BASILEA			CHAR(30)		NOT NULL DEFAULT ' '	,--35
			TEM_TIPO_TASA				NUMERIC(3)		NOT NULL DEFAULT 0		,--36
			TEM_GLOSA_TIPO_TASA			CHAR(30)		NOT NULL DEFAULT ' '	,--37
			TEM_ENCAJE					CHAR(1)			NOT NULL DEFAULT ' '	,--38
			TEM_ENCA_SN					CHAR(2)			NOT NULL DEFAULT ' '	,--39
			TEM_MONTO_ENCAJE			NUMERIC(19, 4)	NOT NULL DEFAULT 0		,--40
			TEM_CODIGO_CARTERASUPER		CHAR(1)			NOT NULL DEFAULT ' '	,--41
			TEM_GLOSA_CARTERASUPER		CHAR(50)		NOT NULL DEFAULT ' '	,--42
			
			TEM_TIPO_CARTERA_FINANCIERA	CHAR(2)			NOT NULL DEFAULT ' '	,--43
			
			TEM_SUCURSAL				CHAR(4)			NOT NULL DEFAULT ' '	,--44
			TEM_NOM_SUCU				CHAR(50)		NOT NULL DEFAULT ' '	,--45
			TEM_CORR_BCO_NOMBRE			CHAR(50)		NOT NULL DEFAULT ' '	,--46
			TEM_CORR_BCO_CTA			CHAR(30)		NOT NULL DEFAULT ' '	,--47
			TEM_CORR_BCO_ABA			CHAR(09)		NOT NULL DEFAULT ' '	,--48
			TEM_CORR_BCO_PAIS			CHAR(15)		NOT NULL DEFAULT ' '	,--49
			TEM_CORR_BCO_CIUD			CHAR(15)		NOT NULL DEFAULT ' '	,--50
			TEM_CORR_BCO_SWIFT			CHAR(30)		NOT NULL DEFAULT ' '	,--51
			TEM_CORR_BCO_REF			CHAR(30)		NOT NULL DEFAULT ' '	,--52
			TEM_CORR_CLI_NOMBRE			CHAR(50)		NOT NULL DEFAULT ' '	,--53
			TEM_CORR_CLI_CTA			CHAR(30)		NOT NULL DEFAULT ' '	,--54
			TEM_CORR_CLI_ABA			CHAR(09)		NOT NULL DEFAULT ' '	,--55
			TEM_CORR_CLI_PAIS			CHAR(15)		NOT NULL DEFAULT ' '	,--56
			TEM_CORR_CLI_CIUD			CHAR(15)		NOT NULL DEFAULT ' '	,--57
			TEM_CORR_CLI_SWIFT			CHAR(30)		NOT NULL DEFAULT ' '	,--58
			TEM_CORR_CLI_REF			CHAR(30)		NOT NULL DEFAULT ' '	,--59
			TEM_OPERADOR_CONTRAPARTE	CHAR(60)		NOT NULL DEFAULT ' '	,--60
			TEM_TIPO_OPERACION			CHAR(1)			NOT NULL DEFAULT ' '	,--61
			TEM_NOM_OPERACION			CHAR(20)		NOT NULL DEFAULT ' '	,--62
			TEM_PARA_QUIEN				CHAR(15)		NOT NULL DEFAULT ' '	,--63
			TEM_GLOSA_PARA_QUIEN		CHAR(15)		NOT NULL DEFAULT ' '	,--64
			TEM_GLOSA_CAR_FINANCIERA	CHAR(10)		NOT NULL DEFAULT ' '	,--65
			TEM_CALCE					CHAR(1)			NOT NULL DEFAULT ' '	,--66
			TEM_CALCE_GLOSA				CHAR(2)			NOT NULL DEFAULT ' '	,--67
			TEM_NOMBRE_CUSTODIA			CHAR(30)		NOT NULL DEFAULT ' '	,--68
			TEM_TITULO					CHAR(70)		NOT NULL DEFAULT ' '	,--69
			SW							CHAR(1)			NOT NULL DEFAULT ' '	,--70
			TEM_FEC_IMP					DATETIME		NOT NULL DEFAULT ' '	,--71
			GLOSA_MONEDA				CHAR(3)			NOT NULL DEFAULT ' '	,--72
			NombreEntidad   			char(50)		NOT NULL DEFAULT ' '	,--73
			DireccEntidad   			char(50)		NOT NULL DEFAULT ' '	,--74
			Correlativo					NUMERIC(10)		NOT NULL DEFAULT 0		,--75
			TEM_MOUTILIDAD				NUMERIC(19, 4)	NOT NULL DEFAULT 0		,--76
			TEM_MOPERDIDA				NUMERIC(19, 4)	NOT NULL DEFAULT 0		,--77
			Cartera_OP					char(50)		NOT NULL DEFAULT ' '	,--78
			Cartera_Selec				char(50)		NOT NULL DEFAULT ' '	,--79
			HoraOp						Char(10)		Not Null DEFAULT ' ' 	,--80
			ESTADOG						CHAR(02)        NOT NULL DEFAULT '  '	,--81
			TEM_TIPOPROD				CHAR(3)			NOT NULL DEFAULT ' '	,--82
			TEM_GLOSA_CARTERA_NORMATIVA	CHAR(50)		NOT NULL DEFAULT ' '	,--83
			TEM_GLOSA_LIBRO				CHAR(50)		NOT NULL DEFAULT ' '	,--84
			TEM_GLOSA_AREA_RESPONSABLE	CHAR(50)		NOT	NULL DEFAULT ' '	)--85

	DECLARE	@FECPROC DATETIME

	SELECT	@FECPROC = ACFECPROC FROM text_arc_ctl_dri

	INSERT INTO #TMP_PAPELETA
	SELECT	
			MOFECPRO																							,	--1
			MORUTCART 																							,	--2
			(SELECT CLNOMBRE FROM VIEW_CLIENTE WHERE A.MORUTCART = CLRUT AND CLCODIGO = 1)						,	--3
			CONVERT(NUMERIC(12),MONUMDOCU)	  																	,  	--4
			CONVERT(NUMERIC(12),MONUMOPER)																		, 	--5
			MOTIPOPER 		 																					,	--6
			A.COD_FAMILIA																						,	--7
			B.DESCRIP_FAMILIA																					,	--8
			ID_INSTRUM																							,	--9
			MORUTCLI   																							,	--10
			MOCODCLI																							,	--11
			ISNULL((SELECT CLNOMBRE FROM VIEW_CLIENTE WHERE A.MORUTCLI = CLRUT AND CLCODIGO = MOCODCLI),' ' )	,	--12
			CONVERT(CHAR(10),MOFECEMI,103)																		,	--13
			CONVERT(CHAR(10),MOFECVEN,103)																		,	--14
			MOMONEMI																							,	--15
			(SELECT MNGLOSA FROM VIEW_moneda WHERE MOMONEMI = MNCODMON)											,	--16
			MOTASEMI																							,	--17
			MOBASEMI																							,	--18
			MORUTEMI																							,	--19
			ISNULL((SELECT CLNOMBRE FROM VIEW_CLIENTE WHERE A.MORUTEMI = CLRUT AND CLCODIGO = a.cod_emi), ' ' )	,	--20
			CONVERT(CHAR(10),MOFECPAGO,103)																		,	--21
			MONOMINAL 																							,	--22
			MOMTUM																								,	--23
			(CASE WHEN @TIPO = 'CP' THEN 
				CASE WHEN a.cod_familia = 2006 THEN
					movalvenc 
				ELSE
					movalcomu
				END 
				ELSE movalven END)																				,	--24
			MOVPRESEN  																							,	--25
			MOVALVENC  																							,	--26
			MOMTPS																								,	--27
			MOTIR     																							,	--28
			MOPVP      																							,	--29
			MOVPAR																								,	--30
			MOINT_COMPRA																						,	--31
			MOPRINCIPAL 																						,	--32
			MOVALVEN																							,	--33
			BASILEA																								,	--34
		(SELECT	TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = 1101 AND TBCODIGO1 = BASILEA )			,	--35
		TIPO_TASA																								,	--36
		ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = 1102 AND	TBCODIGO1 = TIPO_TASA),' '),	--37
		ENCAJE 																									,	--38
		(CASE WHEN ENCAJE = 'S' THEN 'SI' ELSE 'NO' END)														,	--39
		MONTO_ENCAJE																							,	--40
		ISNULL((SELECT	tbcodigo1 FROM 	VIEW_TABLA_GENERAL_DETALLE  WHERE tbcateg = @Cat_Cartera_Normativa AND TBCODIGO1 = codigo_carterasuper) , 0 ), --41
		ISNULL((SELECT tbglosa   FROM 	VIEW_TABLA_GENERAL_DETALLE  WHERE tbcateg = @Cat_Cartera_Normativa AND TBCODIGO1 = codigo_carterasuper), '') , --42
		TIPO_CARTERA_FINANCIERA																					,	--43
		
		SUCURSAL 																								,	--44
		isnull( (SELECT ofi_NOM FROM TTAB_ofi WHERE ofi_cod = SUCURSAL ), ' ' )									,	--45
		CORR_BCO_NOMBRE   									,	--46
		CORR_BCO_CTA      									,	--47
		CORR_BCO_ABA										,	--48
		CORR_BCO_PAIS										,	--49
		CORR_BCO_CIUD										,	--50
		CORR_BCO_SWIFT										,	--51
		CORR_BCO_REF  										,	--52
		CORR_CLI_NOMBRE										,	--53
		CORR_CLI_CTA   										,	--54
		CORR_CLI_ABA										,	--55
		CORR_CLI_PAIS										,	--56
		CORR_CLI_CIUD										,	--57
		CORR_CLI_SWIFT										,	--58
		CORR_CLI_REF  										,	--59
		OPERADOR_CONTRAPARTE									,	--60
		TIPO_INVERSION 										,	--61
		(SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = 1104 AND TBCODIGO1= case when TIPO_INVERSION = 1 then 1 else 2 end),	--62
		PARA_QUIEN										,	--63
		(SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = 1105 AND TBCODIGO1 = PARA_QUIEN),	--64
		' '											,	--65
		CALCE											,	--66
		(CASE WHEN CALCE = 'S' THEN 'SI' ELSE 'NO' END)						,	--67
		NOMBRE_CUSTODIA										,	--68
		(CASE WHEN @TIPO = 'CP' THEN 'INFORME DE COMPRAS DEL '+ CONVERT(CHAR(10),CONVERT(DATETIME,@FEC1),103) ELSE 'INFORME DE VENTAS DEL '+ CONVERT(CHAR(10),CONVERT(DATETIME,@FEC1),103) END), --69
		'1'		,--70
		@fec1		,--71
		(select MNNEMO from VIEW_moneda where mncodmon = momonemi), --72
		@NombreEntidad 	, 	--73
		@DireccEntidad	,	--74
		mocorrelativo	,  --75
		moutilidad	,--76
	        moperdida	,--77
		(SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BEX' And rcrut = tipo_cartera_financiera), -- tipo_inversion),		--78
		@Glosa_Cartera	,--79
		CONVERT(CHAR(08),A.mohoraop,108), --80
		CONVERT(CHAR(02),'  ')		, --81
		RTRIM(LTRIM(MOTIPOPER)) + 'X'	, --82
		LTRIM(RTRIM(@Glosa_Cartera_Normativa))	, --83
		LTRIM(RTRIM(@Glosa_Libro))		, --84
		LTRIM(RTRIM(@Glosa_Area_responsable))	  --85
	FROM	text_mvt_dri A
		,	text_fml_inm B 
	WHERE	A.COD_FAMILIA					= B.COD_FAMILIA
	AND		MOSTATREG != 'A' 
	AND		motipoper						= @TIPO
	AND		CONVERT(NUMERIC(03),sucursal)  >= @NUM_SUCU1
	AND		CONVERT(NUMERIC(03),sucursal)  <= @NUM_SUCU2
	AND		(MOFECPRO						= @fec1	)

--	AND     (tipo_inversion					= @Cartera_INV			OR @Cartera_INV			=  0 )
	AND     (tipo_cartera_financiera		= @Cartera_INV			OR @Cartera_INV			=  0 )

	AND		(A.Id_Libro						= @Id_Libro				OR @Id_Libro			= '0' )
	AND		(A.Id_Area_Responsable			= @Id_Area_Responsable	OR @Id_Area_Responsable	= ''  )
	AND		(A.codigo_carterasuper			= @Id_Cartera_Normativa	OR @Id_Cartera_Normativa= '0' )		
	AND	NOT (MOFECPRO <> MOFECNEG)

	UPDATE  #TMP_PAPELETA
	SET		EstadoG = (CASE WHEN HoraOp BETWEEN DESDE AND HASTA THEN 'SI' ELSE 'NO' END)	
	FROM	#TMP_PAPELETA
			INNER JOIN mdgestion..hora_producto ON sistema = 'BEX' AND producto = TEM_TIPOPROD

	IF NOT EXISTS(SELECT 1 FROM #TMP_PAPELETA )
	BEGIN

	INSERT INTO #TMP_PAPELETA
	SELECT  ' '	,--1
		0	,--2
		' '	,--3
		0	,--4
		0	,--5
		' '	,--6
		0	,--7
		' '	,--8
		' '	,--9
		0	,--10
		0	,--11
		' '	,--12
		' '	,--13
		' '	,--14
		0	,--15
		' '	,--16
		0	,--17
		0	,--18
		0	,--19
		' '	,--20
		' '	,--21
		0	,--22	
		0	,--23
		0	,--24
		0	,--25
		0	,--26
		0	,--27
		0	,--28
		0	,--29
		0	,--30
		0	,--31
		0	,--32
		0	,--33
		0	,--34
		' '	,--35
		0	,--36
		' '	,--37
		' '	,--38
		' '	,--39
		0	,--40
		' '	,--41
		' '	,--42
		' '	,--43
		' '	,--44
		' '	,--45
		' '	,--46
		' '	,--47
		' '	,--48
		' '	,--49
		' '	,--50
		' '	,--51
		' '	,--52
		' '	,--53
		' '	,--54
		' '	,--55
		' '	,--56
		' '	,--57
		' '	,--58
		' '	,--59
		' '	,--60
		' '	,--61
		' '	,--62
		' '	,--63
		' '	,--64
		' '	,--65
		' '	,--66
		' '	,--67
		' '		,--68
		(CASE WHEN @TIPO = 'CP' THEN 'INFORME DE COMPRAS DEL '+ CONVERT(CHAR(10),CONVERT(DATETIME,@FEC1),103) ELSE 'INFORME DE VENTAS '+ CONVERT(CHAR(10),CONVERT(DATETIME,@FEC1),103) END), --69
		'0'		,--68
		@fec1		,
		' '  		,
		@NombreEntidad 	, 	--17
		@DireccEntidad	,	--18
		0		,
		0		,
		0		,
		''		,
		@Glosa_Cartera	,
		''		,
		'  '		,
		' '		,
		LTRIM(RTRIM(@Glosa_Cartera_Normativa))	, --83
		LTRIM(RTRIM(@Glosa_Libro))		, --84
		LTRIM(RTRIM(@Glosa_Area_responsable))	  --85

	END

	SELECT *,'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales),'DireccionEntidad' = (SELECT DireccionLegal FROM BacParamSuda..Contratos_ParametrosGenerales) FROM #TMP_PAPELETA

	SET NOCOUNT OFF
END
GO
