USE [BacParamSuda]
GO
/****** Object:  View [dbo].[VIEW_CARTERA_NORMATIVA]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_CARTERA_NORMATIVA]
AS

--select * from bacparamsuda.dbo.tabla_general_global with(nolock) where ctcateg = 204 -->CARTERAS
--select * from bacparamsuda.dbo.tabla_general_detalle with(nolock) where tbcateg = 204

SELECT		General.ctcateg
		,	General.ctdescrip
		,	CONVERT(int,Detalle.tbcodigo1) AS tbcodigo1
		,	Detalle.tbglosa
	FROM	BacParamSuda.dbo.TABLA_GENERAL_GLOBAL AS General WITH(NOLOCK)
	LEFT OUTER JOIN
			BacParamSuda.dbo.TABLA_GENERAL_DETALLE AS Detalle WITH(NOLOCK)
	ON		General.ctcateg = Detalle.tbcateg
	WHERE	General.ctcateg = 204

GO
