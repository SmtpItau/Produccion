USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_RPT_MVT_VLU]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SVC_RPT_MVT_VLU]

				(	@FEC_PRO	CHAR(8)		,
					@NUM_SUCU1	FLOAT		,
					@NUM_SUCU2	FLOAT		,
					@Cartera_INV    CHAR(10))
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
	Select @Glosa_Cartera = '< TODAS >'


select	@NombreEntidad  = rcnombre, @DireccEntidad = rcdirecc from view_entidad

	SET NOCOUNT ON
	CREATE TABLE #TEMP_DETALLE
		(	FEC_VAL		DATETIME	NOT NULL DEFAULT ' '	,--1
			MONEDA		CHAR(3)		NOT NULL DEFAULT ' '	,--2
			MONTO		NUMERIC(19,4)	NOT NULL DEFAULT 0	,--3
			MOVIMIENTO	CHAR(10)	NOT NULL DEFAULT ' '	,--4
			BANCO		CHAR(70)	NOT NULL DEFAULT ' '	,--5
			CONTRAPARTE	CHAR(70)	NOT NULL DEFAULT ' '	,--6
			NUM_OPE		CHAR(12)	NOT NULL DEFAULT ' '	,--7
			FEC_CIERRE	DATETIME	NOT NULL DEFAULT ' '	,--8
			TITULO		CHAR(60)	NOT NULL DEFAULT ' '	,--9
			SW		NUMERIC(1)	NOT NULL DEFAULT 0	,--10
			SUCURSAL	CHAR(70)	NOT NULL DEFAULT ' '	,--11
			COD_SUCU	CHAR(4)		NOT NULL DEFAULT 0 	,--12
			NombreEntidad   char(50)	NOT NULL DEFAULT ' '	,--13
			DireccEntidad  	char(50)	NOT NULL DEFAULT ' '	,--14
			Instrumento  	char(25)	NOT NULL DEFAULT ' '	,--15

			Cartera_OP	char(50)	NOT NULL DEFAULT ' '	,--16
			Cartera_Selec	char(50)	NOT NULL DEFAULT ' '	,--17
			Cartera_Super	char(50)	NOT NULL DEFAULT ' '	)--18

	INSERT  INTO 	#TEMP_DETALLE
	SELECT	MOFECPRO	,
		(CASE WHEN MOTIPOPER = 'CP' THEN (SELECT MNNEMO FROM VIEW_moneda WHERE MNCODMON = MOMONEMI) ELSE (SELECT MNNEMO FROM VIEW_moneda WHERE MNCODMON = MOMONPAG) END),
		momtum /*MOVALCOMU*/   ,
		(CASE 	WHEN MOTIPOPER = 'CP' OR MOTIPOPER = 'VCP' THEN 'COMPRA' ELSE 'VENTA' END),
		corr_bco_nombre	,
		ISNULL((SELECT CLNOMBRE FROM VIEW_CLIENTE WHERE CLRUT = morutcli  AND CLCODIGO =  mocodcli), ' '),
		MONUMOPER	,
		MOFECneg	,
		'INFORME DE MOVIMIENTO DE VALUTA AL ' + CONVERT(CHAR(10),CONVERT(DATETIME,@FEC_PRO),103),
		1		,
		ISNULL ( (SELECT ofi_NOM  FROM  TTAB_ofi WHERE ofi_cod = SUCURSAL ), ' ' ),
		SUCURSAL ,
		@NombreEntidad 	, 	
		@DireccEntidad	,
		id_instrum	,
		(SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BEX' And rcrut = tipo_inversion),
		@Glosa_Cartera	,
		ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = 1111 AND TBCODIGO1 = codigo_carterasuper), ' ') 
	FROM 	TEXT_MVT_DRI
	WHERE	MOFECPRO = @FEC_PRO 
	and	MOSTATREG != 'A'
	AND 	MOFECPAGO = @FEC_PRO 
	AND	CONVERT(NUMERIC(03),sucursal) >= @NUM_SUCU1
	AND	CONVERT(NUMERIC(03),sucursal) <= @NUM_SUCU2
	AND    (tipo_inversion =  @Cartera_INV or @Cartera_INV = 0)

	IF NOT EXISTS(SELECT * FROM #TEMP_DETALLE )
	BEGIN
		INSERT INTO #TEMP_DETALLE
		SELECT	' '	,
			' '	,
			0	,
			' '	,
			' '	,
			' '	,
			' '	,
			' '	,
			'INFORME DE MOVIMIENTO DE VALUTA AL ' + CONVERT(CHAR(10),CONVERT(DATETIME,@FEC_PRO),103),
			0	,
			' '	,
			0	,
			@NombreEntidad 	, 	
			@DireccEntidad	,
			space(25)	,
			''		,
			@Glosa_Cartera	,
			''

	END

	SELECT 	*,'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales),'DireccionLegal' = (SELECT DireccionLegal FROM BacParamSuda..Contratos_ParametrosGenerales)  FROM	#TEMP_DETALLE ORDER BY MOVIMIENTO


END
GO
