USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_FindBaseSerie]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_FindBaseSerie]
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON
	SELECT	mncodmon	,
		mnnemo		,
		mnsimbol	,
		mnglosa		,
		mncodsuper	,
		mnnemsuper	,
		mncodbanco	,
		mnnembanco	,
		mnbase		,
		mnredondeo	,
		mndecimal	,
	--	mncodpais	,
		mnrrda		,
		mnfactor	,
		mnrefusd	,
		mnlocal		,
		mnextranj	,
		mnvalor		,	
		mnrefmerc	,
	--	mningval	,
		mntipmon	,
		mnperiodo	,
		mnmx		,
		mncodfox	,
		mnvalfox	,
		mncodcor	,
		codigo_pais	
	--	mniso_coddes

	FROM	MONEDA
	WHERE 
               mntipmon = 3	AND
		ESTADO<>'A'
END
SET NOCOUNT OFF

GO
