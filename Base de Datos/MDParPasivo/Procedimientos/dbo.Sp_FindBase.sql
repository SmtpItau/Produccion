USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_FindBase]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_FindBase]
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
		0               ,
		mnrrda		,
		mnfactor	,
		mnrefusd	,
		mnlocal		,
		mnextranj	,
		mnvalor		,	
		mnrefmerc	,
		0       	,
		mntipmon	,
		mnperiodo	,
		mnmx		,
		mncodfox	,
		mnvalfox	,
		mncodcor	,
		codigo_pais	,
		0 
	FROM	MONEDA
	WHERE 	ISNULL(mnmx,' ')<> 'C'	AND
		ESTADO		<> 'A'
SET NOCOUNT OFF	
END

GO
