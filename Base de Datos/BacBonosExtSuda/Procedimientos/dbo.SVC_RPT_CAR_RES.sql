USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_RPT_CAR_RES]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_RPT_CAR_RES]
			(	@FecProc	CHAR(8) 	,
				@NUM_SUCU1	FLOAT		,
				@NUM_SUCU2	FLOAT		,
				@tipo_cartera	CHAR(10)	,
				@Cartera_INV    INTEGER		,
				@Cat_Cart_Norm	CHAR(10) = ''	,
				@Cat_Libro	CHAR(10) = ''	,
				@Cat_Area_Resp	CHAR(10) = ''	,
				@Id_Libro	CHAR(10) = ''	,
				@Id_Area_Resp	CHAR(10) = ''	
			)
AS
BEGIN

DECLARE @cartera 		VARCHAR(10)	,
	@NombreEntidad		CHAR(50)	,	
	@DireccEntidad		CHAR(50)	,
	@Glosa_Cartera		CHAR(50)	,
	@Glosa_Cart_Norm	CHAR(50)	,
	@Glosa_Libro		CHAR(50)	,
	@Glosa_Area_Resp	CHAR(50)	

	Select	@Glosa_Cartera		= ''
	,	@Glosa_Cart_Norm	= ''
	,	@Glosa_Libro		= ''
	,	@Glosa_Area_Resp	= ''

	SELECT	Distinct
		@Glosa_Cartera	= IsNull(rcnombre,'')
	FROM	BacParamSuda..TIPO_CARTERA
	WHERE	rcsistema	= 'BEX'
	AND	rcrut		= @cartera_inv
--	ORDER 
--	BY	rcrut

	IF @Glosa_Cartera = '' 
		Select @Glosa_Cartera = '< TODAS >'

	SELECT	@NombreEntidad  = rcnombre, @DireccEntidad = rcdirecc from view_entidad
	
	SELECT	@Glosa_Cart_Norm	= tbglosa
	FROM	VIEW_TABLA_GENERAL_DETALLE
	WHERE	tbcateg		= @Cat_Cart_Norm
	AND	tbcodigo1	= @tipo_cartera

	IF @Id_Libro	= ''
		SELECT @Glosa_Libro	= '< TODOS >'
	ELSE
		SELECT	@Glosa_Libro	= tbglosa
		FROM	VIEW_TABLA_GENERAL_DETALLE
		WHERE	tbcateg		= @Cat_Libro
		AND	tbcodigo1	= @Id_Libro

	IF @Id_Area_Resp	= ''
		SELECT @Glosa_Area_Resp = '< TODAS >'
	ELSE
		SELECT 	tbglosa
		FROM	VIEW_TABLA_GENERAL_DETALLE
		WHERE	tbcateg		= @Cat_Area_Resp
		AND	tbcodigo1	= @Id_Area_Resp

/*	IF @tipo_cartera = 'T' begin
		SELECT @cartera = 'NORMAL'
	END
	ELSE BEGIN
		SELECT @cartera = 'PERMANENTE'
	END
*/

	SET NOCOUNT ON

	CREATE	TABLE #cartera
		( 	Unidad			char(50)	not null default ' ' 	, --1
			Familia			char(40)	not null default ' ' 	, --2
			moneda			char(3)		not null default ' ' 	, --3
			t_nominal		numeric(25,4)	not null default 0 	, --4
			t_valpresen		numeric(25,4)	not null default 0 	, --5
			t_valmerc		numeric(25,4)	not null default 0 	, --6
			t_interes		numeric(25,4)	not null default 0 	, --7
			t_Int_acum		numeric(25,4)	not null default 0 	, --8
			Titulo			char(70)	not null default ' ' 	, --9
			sw			numeric(1)	not null default 0 	, --10
			NombreEntidad		char(50)	NOT NULL DEFAULT ' '	, --11
			DireccEntidad 		char(50)	NOT NULL DEFAULT ' '	, --12
			CarteraINV_OP		Char(20)	Not Null Default ' '	, --13
			Cartera_Selec		Char(20)	Not Null Default ' '	, --14
			Glosa_Cart_Norm		CHAR(50)	NOT NULL DEFAULT ' '	, --15
			Glosa_Libro		CHAR(50)	NOT NULL DEFAULT ' '	, --16 
			Glosa_Area_Resp		CHAR(50)	NOT NULL DEFAULT ' '	 --17 
		)

	INSERT 	INTO #cartera
	SELECT
	ISNULL ((select ofi_nom from ttab_ofi where (Case when a.sucursal= 0 then 1 else a.sucursal end) = ofi_cod ), ' ' ),
		(select Descrip_familia from text_fml_inm z where z.cod_familia = a.cod_familia)	,
		(select mnnemo from VIEW_moneda where MNCODMON = rsmonemi)		,	 
		'nominal'	=SUM(rsnominal) 	,
		'valor_presente'=sum(rsvppresen)	,
		'valor_meracdo'	=sum(CASE WHEN rsvalmerc <> 0 THEN rsvalmerc ELSE rsvppresen END),
		'interes'	=sum(rsinteres)		,
		'interes_acum'	=sum(rsinteres_acum)	,
--		'RESUMEN DE CARTERA VIGENTE ' + @cartera + 'AL ' + convert(char(10),convert(datetime, @fecproc),103),
		'RESUMEN DE CARTERA VIGENTE AL ' + convert(char(10),convert(datetime, @fecproc),103),
		1					,
		@NombreEntidad   			,	
		@DireccEntidad				,
		(SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BEX' And rcrut = tipo_inversion),		
		@Glosa_Cartera				,
		@Glosa_Cart_Norm			,
		@Glosa_Libro				,
		@Glosa_Area_Resp			
	FROM 	text_rsu a 	,
		text_ctr_inv	b
	WHERE	rscartera = '333'
	AND	rsfecpro = @Fecproc
	AND 	a.codigo_carterasuper = @tipo_cartera
	AND	CONVERT(NUMERIC(03),a.sucursal) >= @NUM_SUCU1
	AND	CONVERT(NUMERIC(03),a.sucursal) <= @NUM_SUCU2
	AND 	rsnumoper      = cpnumdocu
	AND     (tipo_inversion 	= @Cartera_INV	OR @Cartera_INV 	= 0 )
	AND	(Id_Libro		= @Id_Libro	OR @Id_Libro		= '')
	AND	(Id_Area_Responsable	= @Id_Area_Resp	OR @Id_Area_Resp	= '')
	GROUP 
	BY	a.sucursal
	,	a.cod_familia
	,	rsmonemi
	,	tipo_inversion

	INSERT 	INTO #cartera
	SELECT
	ISNULL(	(select	ofi_nom from ttab_ofi	where 	a.sucursal = ofi_cod), ' ' )		,
		'Total unidad'				,	 
		(select mnnemo from VIEW_moneda where MNCODMON = rsmonemi)		,
		'nominal'	=SUM(rsnominal) 	,
		'valor_presente'=sum(rsvppresen)	,
		'valor_meracdo'	=sum(CASE WHEN rsvalmerc <> 0 THEN rsvalmerc ELSE rsvppresen END)		,
		'interes'	=sum(rsinteres)		,
		'interes_acum'	=sum(rsinteres_acum)	,
--		'RESUMEN DE CARTERA VIGENTE ' + @cartera + ' AL ' + convert(char(10),convert(datetime, @fecproc),103),
		'RESUMEN DE CARTERA VIGENTE AL ' + convert(char(10),convert(datetime, @fecproc),103),
		1					,
		@NombreEntidad   			,	
		@DireccEntidad				,
		(SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BEX' And rcrut = tipo_inversion),		
		@Glosa_Cartera				,
		@Glosa_Cart_Norm			,
		@Glosa_Libro				,
		@Glosa_Area_Resp			
	from 	text_rsu 	a	,
		text_ctr_inv	b

	where 	rscartera = '333'
	AND	rsfecpro = @Fecproc
	AND 	a.codigo_carterasuper = @tipo_cartera
	AND	CONVERT(NUMERIC(03),a.sucursal) >= @NUM_SUCU1
	AND	CONVERT(NUMERIC(03),a.sucursal) <= @NUM_SUCU2
	AND 	rsnumoper      = cpnumdocu
	AND     (tipo_inversion 	= @Cartera_INV	OR @Cartera_INV 	= 0 )
	AND	(Id_Libro		= @Id_Libro	OR @Id_Libro		= '')
	AND	(Id_Area_Responsable	= @Id_Area_Resp	OR @Id_Area_Resp	= '')
	GROUP 
	BY	a.sucursal
	,	rsmonemi
	,	tipo_inversion


	IF NOT EXISTS(SELECT 1 FROM #cartera) BEGIN
		INSERT INTO #Cartera
		(	titulo
		,	sw
		,	NombreEntidad
		,	DireccEntidad
		,	CarteraINV_OP
		,	Cartera_Selec
		,	Glosa_Cart_Norm
		,	Glosa_Libro
		,	Glosa_Area_Resp
		)
		VALUES	
-- 'RESUMEN DE CARTERA VIGENTE ' + @cartera + ' AL ' + convert(char(10),convert(datetime, @fecproc),103)
		(	'RESUMEN DE CARTERA VIGENTE AL ' + convert(char(10),convert(datetime, @fecproc),103)
		,	0
		,	@NombreEntidad 
		,	@DireccEntidad
		,	'' 
		,	@GLOSA_CARTERA
		,	@Glosa_Cart_Norm
		,	@Glosa_Libro
		,	@Glosa_Area_Resp
		)
	END 

	SELECT * FROM #cartera

	SET NOCOUNT OFF
END

GO
