USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_RPT_VAL_MER]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SVC_RPT_VAL_MER]	
	(	@FecPro			CHAR(8)		
	,	@NUM_SUCU1		FLOAT		
	,	@NUM_SUCU2		FLOAT		
	,	@CatLibro		CHAR(10)
	,	@CatCartNorm	CHAR(10)
	,	@CatCartFin		CHAR(10)
	,	@CatAreaResp	CHAR(10)
	,	@Libro			CHAR(10)	= ''
	,	@CartNorm		CHAR(10)	= ''
	,	@CartFin		CHAR(10)	= ''
	,	@AreaResp		CHAR(10)	= ''
)
AS 
BEGIN

	SET NOCOUNT ON

	DECLARE	@Glosa_Cartera	CHAR(20)
	DECLARE @FechaContable  DATETIME
	DECLARE @fechabil 	CHAR (02)
	DECLARE @dFecRet 	DATETIME
	SELECT  @fechabil = ' '
	SELECT  @dFecRet  = ' '	
	


	EXECUTE BacParamSuda..SP_DETECTA_FECHA_HABIL_INHABIL @FecPro, @fechabil OUTPUT


        IF @fechabil = 'NO' 
	BEGIN
		EXECUTE BacParamSuda..SP_FECHA_HABIL_ANTERIOR @FecPro, @dFecRet OUTPUT
		SELECT @FechaContable = @dFecRet

	END
	ELSE 
	BEGIN
		SELECT @FechaContable = @FecPro
	END

	IF @CartFin = '' 
		SELECT @Glosa_Cartera = '< TODAS >'
	ELSE
		SELECT	@Glosa_Cartera = ISNULL(TBGLOSA,'')
		FROM	VIEW_TABLA_GENERAL_DETALLE
		WHERE	TBCATEG		= @CatCartFin
		AND	TBCODIGO1	= @CartFin

	CREATE TABLE #TEMP_VALMERC	
	(	NUMDOCU		CHAR   (12)	NOT NULL DEFAULT ' '	--1
	,	NEMOTECNICO	CHAR   (20)	NOT NULL DEFAULT ' '	--2
	,	FEC_VCTO	DATETIME	NOT NULL DEFAULT ' '	--3
	,	NOMINAL		FLOAT		NOT NULL DEFAULT 0	--4
	,	TIR		FLOAT		NOT NULL DEFAULT 0	--5
	,	TIRMERC		FLOAT		NOT NULL DEFAULT 0	--6
	,	VALCOMU		FLOAT		NOT NULL DEFAULT 0	--7
	,	VALCOMU_MERC	FLOAT		NOT NULL DEFAULT 0	--8
	,	PVP		FLOAT		NOT NULL DEFAULT 0	--9
	,	PVP_MERC	FLOAT   	NOT NULL DEFAULT 0	--10
	,	NUM_OFI		NUMERIC(04)	NOT NULL DEFAULT 0	--11
	,	OFICINA		CHAR   (50)	NOT NULL DEFAULT 0	--12
	,	FEC_IMP		DATETIME	NOT NULL DEFAULT ' '	--13
	,	TITULO		CHAR   (70)	NOT NULL DEFAULT ' '	--14
	,	SW		NUMERIC(01)	NOT NULL DEFAULT 0	--15
	,	valor_cambio	FLOAT 		NOT NULL DEFAULT 0	--16
	,	glosa_moneda	CHAR   (60)	NOT NULL DEFAULT ' '	--17
	,	nom_familia	CHAR   (60)	NOT NULL DEFAULT ' '	--18
	,	NombreEntidad   CHAR   (50)	NOT NULL DEFAULT ' '	--19
	,	DireccEntidad   CHAR   (50)	NOT NULL DEFAULT ' '	--20
	,	TipoEmisor	CHAR   (50)	NOT NULL DEFAULT ' '	--21
	,	cartera		CHAR   (50)	NOT NULL DEFAULT ' '	--22
	,	CarteraINV_OP	CHAR   (50)	Not Null Default ' '	--23
	,	Cartera_Selec   CHAR   (50)	Not Null Default ' '	--24
	,	Nemo_Moneda	CHAR   (05)	Not Null Default ' '	--25
	,	Libro		CHAR	(50)	Not Null Default ' '	--26
	,	Cartera_Norm	CHAR	(50)	Not Null Default ' '	--27
	,	AreaResp	CHAR	(50)	Not Null Default ' '	--28
	)


	INSERT INTO #TEMP_VALMERC
	SELECT 	RSNUMDOCU			,
		a.ID_INSTRUM			,
		RSFECVCTO			,
		RSNOMINAL			,
		RSTIR				,
		RSTIRMERC			,
		rsvppresen			,
		CASE WHEN RSVALMERC <> 0 THEN RSVALMERC	ELSE rsvppresen END ,
		RSPVP				,
		RSPVPMERC			,
		CONVERT(NUMERIC(4), a.SUCURSAL)	,
		isnull( ( SELECT ofi_NOM FROM 	TTAB_ofi WHERE ofi_COD = a.SUCURSAL ), ' ' ),
		CONVERT(DATETIME,@FecPro)	,
		'VALORIZACIÓN DE MERCADO AL '+ CONVERT(CHAR(10),CONVERT(DATETIME, @FecPro),103),
		1,

--		isnull((case when rsmonemi = 13 then (select Tipo_Cambio from BACPARAMSUDA..VALOR_MONEDA_CONTABLE where Codigo_Moneda = 994 and  Fecha = @FechaContable) else 0 end ),0),
		isnull( ( select Tipo_Cambio from BACPARAMSUDA..VALOR_MONEDA_CONTABLE where Codigo_Moneda = (case when rsmonemi = 13 then 994 else rsmonemi end ) and  Fecha = @FechaContable )  ,0),

		( select mnglosa from VIEW_moneda where mncodmon = rsmonemi),
		c.Descrip_familia		,
		ISNULL( (Select rcnombre from view_entidad),' '),
		ISNULL( (Select rcdirecc from view_entidad),' '),
		ISNULL(( select TBGLOSA from view_tabla_general_detalle , view_emisor where TBCATEG = 210  and TBCODIGO1 = emtipo and emrut = rsrutemis and emcodigo = rscodemi) , ''),
		case when a.codigo_carterasuper = 'T' then 'NORMAL' ELSE 'PERMANENTE' END	,
		ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartFin AND TBCODIGO1 = d.tipo_inversion),'No Especificado'),
		@Glosa_Cartera								,
		(SELECT MNNEMO FROM VIEW_MONEDA WHERE MNCODMON = RSMONEMI)
	,	ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatLibro    AND TBCODIGO1 = d.Id_Libro),'No Especificado')
	,	ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartNorm AND TBCODIGO1 = d.codigo_carterasuper),'No Especificado')
	,	ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatAreaResp AND TBCODIGO1 = d.Id_Area_Responsable),'No Especificado')
	FROM 	TEXT_RSU a
	,	text_fml_inm c 
	,	text_ctr_inv d
	WHERE 	a.rscartera		= '333'
        AND     rstipoper		= 'DEV'
	AND	a.rsfecpro		= @FecPro
	AND	CONVERT(NUMERIC(03),a.sucursal) >= @NUM_SUCU1
	AND	CONVERT(NUMERIC(03),a.sucursal) <= @NUM_SUCU2
	AND  	c.cod_familia		= a.cod_familia	 
	AND 	d.cpnumdocu		= rsnumoper
	AND	(d.id_libro		= @Libro	OR @Libro	= '')
	AND	(d.codigo_carterasuper	= @CartNorm	OR @CartNorm	= '')
	AND     (d.tipo_inversion	= @CartFin	OR @CartFin	= '')
	AND	(d.Id_Area_Responsable	= @AreaResp	OR @AreaResp	= '')


	IF ( SELECT COUNT(1) FROM #TEMP_VALMERC ) = 0 BEGIN

		INSERT INTO #TEMP_VALMERC
			SELECT 
				' '	,--1
				' '	,--2
				' '	,--3
				0	,--4
				0	,--5
				0	,--6
				0	,--7
				0	,--8
				0	,--9
				0	,--10
				0	,--11
				0	,--12
				' '	,--13
				'VALORIZACIÓN DE MERCADO AL '+CONVERT(CHAR(10),CONVERT(DATETIME, @FecPro),103),--14
				0	,--15
				0	,
				' '	,
				' '	,
				ISNULL( (Select rcnombre from view_entidad),' '),
				ISNULL( (Select rcdirecc from view_entidad),' '),
				space(50)          ,
				space(50)	   ,
				' '          	   ,
				@Glosa_Cartera		,
				' '
			,	' '
			,	' ' 
			,	' '
			FROM text_arc_ctl_dri 
	END

		SELECT 	*
			,	'RazonSocial'		= '' --> (SELECT RazonSocial	 FROM BacParamSuda..Contratos_ParametrosGenerales)
			,	'DireccionLegal'	= '' -- (SELECT DireccionLegal FROM BacParamSuda..Contratos_ParametrosGenerales)
		FROM 	#TEMP_VALMERC
		ORDER 
		BY		NUMDOCU

	SET NOCOUNT OFF
END
GO
