USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_RPA_BUS_CAR_IM]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SVC_RPA_BUS_CAR_IM]
(
   @fecpro		DATETIME
)

AS
SET NOCOUNT ON
BEGIN	
	CREATE TABLE #tempoMov
	(monumoper	NUMERIC(9),
	motipoper	CHAR(4),
	nomfamilia	CHAR(20),
	blanco1		CHAR(1),
	mofecpago	DATETIME,
	blanco2		CHAR(1),
	cero1		NUMERIC(1),
	suma1		NUMERIC(12),--> jcamposd COP (se agranda monto)
	suma2		FLOAT,
	cliente		CHAR(70),
	mostatreg	CHAR(1),
	confirmacion	NUMERIC(5))

	INSERT INTO #tempoMov
		SELECT 	monumoper	,--1
			motipoper	,--2
			b.nom_familia	,--3
			''		,--4	
			a.mofecpago	,--5
			''		,--6
			0		,--
			sum(a.monominal),--8
			sum(a.movalcomu),--9
			'cliente' = isnull((SELECT clnombre  FROM VIEW_CLIENTE WHERE a.morutcli = clrut and a.mocodcli = clcodigo ),'NO EXISTE')	,--10
			a.mostatreg 	,--11
			a.confirmacion	--12

			FROM	text_mvt_dri a, text_fml_inm b
			WHERE	mofecpro= @fecpro
			AND	a.cod_familia = b.cod_familia
			AND	motipoper IN ('CP','VP')
			GROUP BY monumoper,motipoper,b.nom_familia,a.mofecpago,a.morutcli,a.mocodcli,a.mostatreg,a.confirmacion
			ORDER 	BY monumoper
	
	INSERT INTO #tempoMov
		SELECT 	monumoper	,--1
			RTRIM(LTRIM(motipoper)) + 'I'	,--2
			b.nom_familia	,--3
			''		,--4	
			a.mofecpago	,--5
			''		,--6
			0		,--
			sum(a.monominal),--8
			sum(a.movalcomu),--9
			'cliente' = isnull((SELECT clnombre  FROM VIEW_CLIENTE WHERE a.morutcli = clrut and a.mocodcli = clcodigo ),'NO EXISTE')	,--10
			a.mostatreg, 	--11
			0
			FROM	MOV_ticketbonext a, text_fml_inm b
			WHERE	a.mofecpro= @fecpro
			AND	a.cod_familia = b.cod_familia
			AND	a.motipoper IN ('CP','VP')
			GROUP BY monumoper,motipoper,b.nom_familia,a.mofecpago,a.morutcli,a.mocodcli,a.mostatreg
			ORDER 	BY monumoper

	if exists(select count(*) from #tempoMov)
		SELECT * FROM #tempoMov
	else
		SELECT 'NO', 'No hay operaciones para esta fecha'

	SET NOCOUNT OFF
	--SELECT * FROM #tempoMov
	DROP TABLE #tempoMov
END
GO
