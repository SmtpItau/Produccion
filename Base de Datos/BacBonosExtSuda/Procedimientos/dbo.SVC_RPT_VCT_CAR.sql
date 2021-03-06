USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_RPT_VCT_CAR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SVC_RPT_VCT_CAR]
			(	@FEC1	CHAR(8)		,
				@FEC2	CHAR(8)		)
AS
BEGIN

DECLARE	@NombreEntidad   char(50),	
	@DireccEntidad   char(50)

--select	@NombreEntidad  = rcnombre, @DireccEntidad = rcdirecc from view_entidad
SELECT @NombreEntidad = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
SELECT @DireccEntidad = (SELECT DireccionLegal FROM BacParamSuda..Contratos_ParametrosGenerales)

	SET NOCOUNT ON
	CREATE TABLE #CARTERA(	
		NUMDOCU		CHAR(12)	NOT NULL DEFAULT ' '	,
		FECPRO		CHAR(10)	NOT NULL DEFAULT ' '	,
		INSTRUMENTO	CHAR(20)	NOT NULL DEFAULT ' '	,
		FECVCTO		datetime	NOT NULL DEFAULT ' '	,
		FECVCTO2	char(10)	NOT NULL DEFAULT ' '	,
		EMISOR		CHAR(60)	NOT NULL DEFAULT ' '	,
		TIR		NUMERIC(19,7)	NOT NULL DEFAULT 0	,
		PVP		NUMERIC(19,7)	NOT NULL DEFAULT 0	,
		NOMINAL		NUMERIC(19,4)	NOT NULL DEFAULT 0	,
		VALOR_VENC	NUMERIC(19,4)	NOT NULL DEFAULT 0	,
		TITULO		CHAR(90)	NOT NULL DEFAULT ' '	,
		SW		CHAR(1)		NOT NULL DEFAULT ' '	,
		COD_FAMI	CHAR(35)	NOT NULL DEFAULT ' '	,
		glosa_moneda	char(3)		NOT NULL DEFAULT ' '	,
		NombreEntidad	char(50)	NOT NULL DEFAULT ' '	,
		DireccEntidad	char(50)	NOT NULL DEFAULT ' '	)

	INSERT INTO #CARTERA 
		SELECT	Distinct rsnumdocu 	,
			CONVERT(CHAR(10),CONVERT(DATETIME,rsfecpro	),103) ,
			id_instrum	,
			(CASE WHEN A.COD_FAMILIA = 2000 THEN rsfecucup /*rsfecpcup*/	ELSE rsfecvcto end ),
			(CASE WHEN A.COD_FAMILIA = 2000 THEN CONVERT(CHAR(10),CONVERT(DATETIME, rsfecucup /*rsfecpcup*/),103)
			      ELSE                           CONVERT(CHAR(10),CONVERT(DATETIME,rsfecvcto 	),103)
                        end ),
			ISNULL((SELECT CLNOMBRE FROM VIEW_CLIENTE WHERE CLRUT = rsrutemis AND CLCODIGO = rscodemi), ' ' ),
			RSTIR		,
			RSPVP		,
			RSNOMINAL	,
			RSVALVENC	,
			'INFORME DE VENCIMIENTOS ENTRE EL ' + CONVERT(CHAR(10),CONVERT(DATETIME,@FEC1),103) + ' AL ' + CONVERT(CHAR(10),CONVERT(DATETIME,@FEC2),103),
			'1'		,
			B.DESCRIP_FAMILIA ,
			( select MNNEMO from VIEW_moneda where MNCODMON = rsmonemi),
			@NombreEntidad 	, 	
			@DireccEntidad		

		FROM 	TEXT_RSU A, text_fml_inm B, text_arc_ctl_dri C
		WHERE 	A.COD_FAMILIA = B.COD_FAMILIA
		and	rscartera = '333'
		AND	RSFECPRO = C.ACFECPROC

--SELECT * FROM text_arc_ctl_dri
-- select a.rsfecpcup , a.* , b.* from TEXT_RSU a ,text_fml_inm  b  where a.rscartera = '333'and  a.RSFECPRO = '20020925' and  A.COD_FAMILIA = B.COD_FAMILIA
	IF NOT EXISTS(SELECT * FROM #CARTERA where FECVCTO BETWEEN @FEC1 AND @FEC2) BEGIN
		delete from #cartera
		INSERT INTO #CARTERA
			SELECT	' '	,
				' '	,
				' '	,
				' '	,
				' '	,
				' '	,
				0	,
				0	,
				0	,
				0	,
				'INFORME DE VENCIMIENTOS ENTRE EL ' + CONVERT(CHAR(10),CONVERT(DATETIME,@FEC1),103) + ' AL ' + CONVERT(CHAR(10),CONVERT(DATETIME,@FEC2),103),
				'0'	,
				' '	,
				' '	,
				@NombreEntidad 	, 	
				@DireccEntidad		

		select * from #CARTERA 
	END
	else begin
		SELECT	*
		FROM 	#CARTERA 
		WHERE 	FECVCTO BETWEEN @FEC1 AND @FEC2
		ORDER 	BY	COD_FAMI
	end
	
	SET NOCOUNT OFF
END
GO
