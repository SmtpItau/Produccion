USE [BacLineas]
GO
/****** Object:  View [dbo].[VIEW_MEAC]    Script Date: 13-05-2022 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE VIEW [dbo].[VIEW_MEAC]
AS SELECT
	acentida		,
	acnombre		,
	accodigo		,
	acrut			,
	acdirecc		,
	accomuna		,
	acciudad		,
	actelefo		,
	acbanco			,
	acejecut		,
	acfecpro		,
	acfecprx		,
	acfecant		,
	accorrel		,
	accorope		,
	accoraj			,
	acdskspc		,
	acobser			,
	acacuer			,
	accband			,
	acvband			,
	accbcch			,
	acvbcch			,
	acposini		,
	acpmeco			,
	acpmeve			,
	acpreini		,
	acpmecopo		,
	acprecie		,
	acpmevepo		,
	acposic			,
	acutilipo		,
	acutili			,
	acutiltot		,
	actotco			,
	actotve			,
	actotcopo		,
	actotvepo		,
	acpmecofi		,
	acpmevefi		,
	acpreinifi		,
	acpreciefi		,
	acobseraye		,
	accierrepr		,
	actotalpe		,
	actotalpef		,
	acmmonori		,
	acfindia		,
	actcamar		,
	actovern		,
	acdcamar		,
	acdovern		,
	aclogdig		,
	acusrdig		,
	acprefiun		,
	Actcierre		,
	accoscomp		,
	accosvent		,
	acvaloruf		,
	acdv			,
	acultpta		,
	acultmon		,
	acultpre		,
	accorres		,
	acfinan			,
	acmtoptas		,
	acfprptac		,
	acfpeptac		,
	acfprptav		,
	acfpeptav		,
	acfprempc		,
	acfpeempc		,
	acfprempv		,
	acfpeempv		,
	acpcierre		,
	acomac			,
	acrentab		,
	acmoneda		,
	acomav			,
	acomacpta		,
	acomavpta		,
	acrentabp		,
	acnumlogs		,
	codigo_tesoreria	,
	dolar			,
	pesos			,
	ACMININTRADAY		,
	ACMAXINTRADAY		,
	ACMINOVERNIGHT		,
	ACMAXOVERNIGHT		,
	achedgeactualfuturo	,
	achedgeactualspot
 from BACCAMSUDA..MEAC












GO
