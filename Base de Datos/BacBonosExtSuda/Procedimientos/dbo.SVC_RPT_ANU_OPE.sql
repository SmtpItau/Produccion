USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_RPT_ANU_OPE]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SVC_RPT_ANU_OPE] 
(	
       @FEC1		CHAR(8)	,
       @NUM_SUCU1	FLOAT	,
       @NUM_SUCU2	FLOAT	,
	@Cartera_INV    CHAR(10)
)--
					                         --INTEGER)

AS
BEGIN

DECLARE	@NombreEntidad   char(50),	
	@DireccEntidad   char(50)
Declare @Glosa_Cartera   Char   (20)

Select @Glosa_Cartera = '' 

   SELECT Distinct
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema = 'BEX'
     And  rcrut     = @Cartera_INV
   --ORDER BY rcrut

  if @Glosa_Cartera = '' 
	SELECT @Glosa_Cartera = '< TODAS >'

	SELECT @NombreEntidad  = rcnombre
	,      @DireccEntidad = rcdirecc 
	  FROM view_entidad


	  SELECT @NombreEntidad = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
	SELECT @DireccEntidad = (SELECT DireccionLegal FROM BacParamSuda..Contratos_ParametrosGenerales)

	SET NOCOUNT ON

	CREATE TABLE #TMP_PAPELETA(	
			TEM_MOFECPRO			DATETIME	NOT NULL DEFAULT ' '	,--1
			TEM_MORUTCART			NUMERIC(9, 0)	NOT NULL DEFAULT 0	,--2
			TEM_NOMBRE_CART			CHAR (60)	NOT NULL DEFAULT ' '	,--3
			TEM_MONUMDOCU			char(12)	not null default ' '	,--4
			TEM_MONUMOPER			char(12)	not null default ' '	,--5
			TEM_MOTIPOPER			CHAR(3)		NOT NULL DEFAULT ' '	,--6
			TEM_COD_FAMILIA			NUMERIC(5, 0)	NOT NULL DEFAULT 0	,--7
			TEM_NOM_FAMILIA			CHAR (50)	NOT NULL DEFAULT ' '	,--8
			TEM_ID_INSTRUM			CHAR (20)	NOT NULL DEFAULT ' '	,--9
			TEM_MORUTCLI			NUMERIC(9, 0)	NOT NULL DEFAULT 0	,--10
			TEM_MOCODCLI			NUMERIC (1)	NOT NULL DEFAULT 0	,--11
			TEM_NOM_CLI			CHAR (60)	NOT NULL DEFAULT ' '	,--12
			TEM_MOFECEMI			CHAR(10)	NOT NULL DEFAULT ' '	,--13
			TEM_MOFECVEN			CHAR(10)	NOT NULL DEFAULT ' '	,--14
			TEM_MOMONEMI			NUMERIC(3, 0)	NOT NULL DEFAULT 0	,--15
			TEM_GLOSA_MONOEMI		CHAR	(35)	NOT NULL DEFAULT ' '	,--16
			TEM_MOTASEMI			NUMERIC(19, 4)	NOT NULL DEFAULT 0	,--17
			TEM_MOBASEMI			NUMERIC(3, 0)	NOT NULL DEFAULT 0	,--18
			TEM_MORUTEMI			NUMERIC(9, 0)	NOT NULL DEFAULT 0	,--19
			TEM_NOM_EMI			CHAR(60)	NOT NULL DEFAULT ' '	,--20
			TEM_MOFECPAGO			CHAR(100)	NOT NULL DEFAULT ' '	,--21
			TEM_MONOMINAL			NUMERIC(19, 4)	NOT NULL DEFAULT 0	,--22
			TEM_MOMTUM			NUMERIC(19, 4)	NOT NULL DEFAULT 0	,--23
			TEM_MOVALCOMU			NUMERIC(19, 4)	NOT NULL DEFAULT 0	,--24
			TEM_MOVPRESEN			NUMERIC(19, 4)	NOT NULL DEFAULT 0	,--25
			TEM_MOVALVENC			NUMERIC(19, 4)	NOT NULL DEFAULT 0	,--26
			TEM_MOMTPS			NUMERIC(19, 4)	NOT NULL DEFAULT 0	,--27
			TEM_MOTIR			NUMERIC(19, 7)	NOT NULL DEFAULT 0	,--28
			TEM_MOPVP			NUMERIC(19, 7)	NOT NULL DEFAULT 0	,--29
			TEM_MOVPAR			NUMERIC(19, 8)	NOT NULL DEFAULT 0	,--30
			TEM_MOINT_COMPRA		NUMERIC(19, 4)	NOT NULL DEFAULT 0	,--31
			TEM_MOPRINCIPAL			NUMERIC(19, 4)	NOT NULL DEFAULT 0	,--32
			TEM_MOVALVEN			NUMERIC(19, 4)	NOT NULL DEFAULT 0	,--33
			TEM_BASILEA			NUMERIC(1)	NOT NULL DEFAULT 0	,--34
			TEM_GLOSA_BASILEA		CHAR(55)	NOT NULL DEFAULT ' '	,--35
			TEM_TIPO_TASA			NUMERIC(3)	NOT NULL DEFAULT 0	,--36
			TEM_GLOSA_TIPO_TASA		CHAR(20)	NOT NULL DEFAULT ' '	,--37
			TEM_ENCAJE			CHAR(1)		NOT NULL DEFAULT ' '	,--38
			TEM_ENCA_SN			CHAR(2)		NOT NULL DEFAULT ' '	,--39
			TEM_MONTO_ENCAJE		NUMERIC(19, 4)	NOT NULL DEFAULT 0	,--40
			TEM_CODIGO_CARTERASUPER		CHAR (10)	NOT NULL DEFAULT ' '	,--41
			TEM_GLOSA_CARTERASUPER		CHAR(20)	NOT NULL DEFAULT ' '	,--42 --> VB+- 05/01/2011 Cambio
			TEM_TIPO_CARTERA_FINANCIERA	CHAR (1)	NOT NULL DEFAULT ' '	,--43
			TEM_SUCURSAL			CHAR(04)	NOT NULL DEFAULT ' '	,--44
			TEM_NOM_SUCU			CHAR(50)	NOT NULL DEFAULT ' '	,--45
			TEM_CORR_BCO_NOMBRE		CHAR(50)	NOT NULL DEFAULT ' '	,--46
			TEM_CORR_BCO_CTA		CHAR(30)	NOT NULL DEFAULT ' '	,--47
			TEM_CORR_BCO_ABA		CHAR(09)	NOT NULL DEFAULT ' '	,--48
			TEM_CORR_BCO_PAIS		CHAR(15)	NOT NULL DEFAULT ' '	,--49
			TEM_CORR_BCO_CIUD		CHAR(15)	NOT NULL DEFAULT ' '	,--50
			TEM_CORR_BCO_SWIFT		CHAR(30)	NOT NULL DEFAULT ' '	,--51
			TEM_CORR_BCO_REF		CHAR(30)	NOT NULL DEFAULT ' '	,--52
			TEM_CORR_CLI_NOMBRE		CHAR(50)	NOT NULL DEFAULT ' '	,--53
			TEM_CORR_CLI_CTA		CHAR(30)	NOT NULL DEFAULT ' '	,--54
			TEM_CORR_CLI_ABA		CHAR(09)	NOT NULL DEFAULT ' '	,--55
			TEM_CORR_CLI_PAIS		CHAR(15)	NOT NULL DEFAULT ' '	,--56
			TEM_CORR_CLI_CIUD		CHAR(15)	NOT NULL DEFAULT ' '	,--57
			TEM_CORR_CLI_SWIFT		CHAR(30)	NOT NULL DEFAULT ' '	,--58
			TEM_CORR_CLI_REF		CHAR(30)	NOT NULL DEFAULT ' '	,--59
			TEM_OPERADOR_CONTRAPARTE	CHAR(30)	NOT NULL DEFAULT ' '	,--60
			TEM_TIPO_OPERACION		CHAR(1)		NOT NULL DEFAULT ' '	,--61
			TEM_NOM_OPERACION		CHAR(20)	NOT NULL DEFAULT ' '	,--62
			TEM_PARA_QUIEN			CHAR(15)	NOT NULL DEFAULT ' '	,--63
			TEM_GLOSA_PARA_QUIEN		CHAR(15)	NOT NULL DEFAULT ' '	,--64
			TEM_GLOSA_CAR_FINANCIERA	CHAR(10)	NOT NULL DEFAULT ' '	,--65
			TEM_CALCE			CHAR(1)		NOT NULL DEFAULT ' '	,--66
			TEM_CALCE_GLOSA			CHAR(2)		NOT NULL DEFAULT ' '	,--67
			TEM_NOMBRE_CUSTODIA		CHAR(30)	NOT NULL DEFAULT ' '	,--68
			TEM_TITULO			CHAR(60)	NOT NULL DEFAULT ' '	,--69
			SW				CHAR(1)		NOT NULL DEFAULT ' '	,--70
			TEM_FEC_IMP			DATETIME	NOT NULL DEFAULT ' '	,--71
			TEM_MOSTATREG			CHAR(1)		NOT NULL DEFAULT ' '	,--72
			GLosa_Moneda			char(3)		NOT NULL DEFAULT ' '	,--73
			NombreEntidad   		char(50)	NOT NULL DEFAULT ' '	,--74
			DireccEntidad   		char(50)	NOT NULL DEFAULT ' '	,--75
			Cartera_OP			char(50)	NOT NULL DEFAULT ' '	,--76
			Cartera_Selec			char(50)	NOT NULL DEFAULT ' '	,--77
			Cartera_Super			char(50)	NOT NULL DEFAULT ' '	)--78

	DECLARE	@FECPROC DATETIME

	SELECT	@FECPROC = ACFECPROC FROM text_arc_ctl_dri

	INSERT INTO #TMP_PAPELETA
	SELECT	MOFECPRO										,	--1
		MORUTCART 										,	--2
		(SELECT SUBSTRING(CLNOMBRE,1,60) FROM VIEW_CLIENTE WHERE A.MORUTCART = CLRUT AND CLCODIGO = MOCODCLI)	,	--3
		MONUMOPER	  									,  	--4
		MONUMOPER										, 	--5
		MOTIPOPER 		 								,	--6
		A.COD_FAMILIA										,	--7
		B.DESCRIP_FAMILIA									,	--8
		ID_INSTRUM										,	--9
		MORUTCLI   										,	--10
		MOCODCLI										,	--11
		(SELECT SUBSTRING(CLNOMBRE,1,60) FROM VIEW_CLIENTE WHERE A.MORUTCLI = CLRUT AND CLCODIGO = MOCODCLI),	--12
		CONVERT(CHAR(10),MOFECEMI,103)								,	--13
		CONVERT(CHAR(10),MOFECVEN,103)								,	--14
		MOMONEMI										,	--15
		(SELECT MNGLOSA FROM VIEW_moneda WHERE MOMONEMI = MNCODMON)			,	--16
		MOTASEMI										,	--17
		MOBASEMI										,	--18
		MORUTEMI										,	--19
		ISNULL((SELECT SUBSTRING(CLNOMBRE,1,60) FROM VIEW_CLIENTE WHERE A.MORUTEMI = CLRUT AND CLCODIGO = COD_EMI), ' '),--20
		CONVERT(CHAR(10),MOFECPAGO,103)								,	--21
		MONOMINAL 										,	--22
		MOMTUM											,	--23
		MOVALCOMU										,	--24
		MOVPRESEN  										,	--25
		MOVALVENC  										,	--26
		MOMTPS											,	--27
		MOTIR     										,	--28
		MOPVP      										,	--29
		MOVPAR											,	--30
		MOINT_COMPRA										,	--31
		MOPRINCIPAL 										,	--32
		MOVALVEN										,	--33
		BASILEA											,	--34
		(SELECT	TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = 1101 AND TBCODIGO1 = BASILEA ),	--35
		TIPO_TASA										,	--36
		ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = 1102 AND	TBCODIGO1 = TIPO_TASA),' '),	--37
		ENCAJE 											,	--38
		(CASE WHEN ENCAJE = 'S' THEN 'SI' ELSE 'NO' END)					,	--39
		MONTO_ENCAJE										,	--40
		ISNULL((SELECT TBCODIGO1  FROM  VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = 1111 AND TBCODIGO1 = codigo_carterasuper), ' '),--41 
		ISNULL((SELECT TBGLOSA  FROM  VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = 1111 AND TBCODIGO1 = codigo_carterasuper), ' ' ),--42 
		TIPO_CARTERA_FINANCIERA									,	--43
		isnull(SUCURSAL,' ') 									,	--44
		isnull(	(	SELECT 	ofi_nom FROM TTAB_ofi WHERE 	ofi_cod = SUCURSAL ), ' ' )					,	--45
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
		(SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = 1104 AND TBCODIGO1=TIPO_INVERSION),	--62
		PARA_QUIEN										,	--63
		(SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = 1105 AND TBCODIGO1 = PARA_QUIEN),	--64
		' '											,	--65
		CALCE											,	--66
		(CASE WHEN CALCE = 'S' THEN 'SI' ELSE 'NO' END)						,	--67
		NOMBRE_CUSTODIA										,	--68
		'INFORME DE ANULACIÓN DE OPERACIONES DEL '+ CONVERT(CHAR(10),CONVERT(DATETIME,@FEC1),103), --69
		'1'				,	--70
		@fec1				,	--71
		MOSTATREG			,	--72
		(SELECT mnnemo FROM VIEW_moneda WHERE mncodmon = momonemi),	--73
		@NombreEntidad 			,	--74
		@DireccEntidad			,	--75
		(SELECT DISTINCT IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BEX' And rcrut = tipo_inversion),
		@Glosa_Cartera	,
		ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = 1111 AND TBCODIGO1 = codigo_carterasuper), ' ') 
	 FROM	text_mvt_dri A,
		text_fml_inm B 
	WHERE	A.COD_FAMILIA = B.COD_FAMILIA
	AND	MOSTATREG = 'A'
	AND	CONVERT(NUMERIC(03),sucursal) >= @NUM_SUCU1
	AND	CONVERT(NUMERIC(03),sucursal) <= @NUM_SUCU2
	AND 	a.mofecpro = 	@FECPROC
	AND (tipo_inversion =  @Cartera_INV or @Cartera_INV = 0)


	IF NOT EXISTS(SELECT * FROM #TMP_PAPELETA )
	BEGIN 
			INSERT INTO #TMP_PAPELETA
			SELECT  ' '	,--1
				0	,--2
				' '	,--3
				' '	,--4
				' '	,--5
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
				' '	,--68
				'INFORME DE ANULACIÓN DE OPERACIONES DEL '+ CONVERT(CHAR(10),CONVERT(DATETIME,@FEC1),103) , --69
				'0'	,--70	
				@fec1	,--71
				' '	,--72
				' '	,--73
				@NombreEntidad 	,--74
				@DireccEntidad	 ,--75
				'',
				@Glosa_Cartera,
				''

	END

	SELECT * FROM #TMP_PAPELETA 

	SET NOCOUNT OFF

END
GO
