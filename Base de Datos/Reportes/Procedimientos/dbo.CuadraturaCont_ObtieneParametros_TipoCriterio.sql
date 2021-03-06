USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaCont_ObtieneParametros_TipoCriterio]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CuadraturaCont_ObtieneParametros_TipoCriterio] @sistema varchar(10)
AS

IF @sistema = 'PCS'

	SELECT idTipoCriterio AS id,  UPPER(RTRIM(nombre)) AS nombre
	FROM dbo.Parametros_TipoCriterio WITH (NOLOCK)
    WHERE idTipoCriterio IN(7,8,5,6, 11,12,13,14) 
    ORDER BY idTipoCriterio Desc


IF @sistema = 'BTR' OR @sistema = 'BTREX'

	SELECT idTipoCriterio AS id, UPPER(RTRIM(nombre)) AS nombre
	FROM dbo.Parametros_TipoCriterio WITH (NOLOCK)
    WHERE idTipoCriterio IN(9,10) 


IF @sistema <> 'BTR' AND  @sistema <> 'PCS' AND  @sistema <> 'BTREX' AND @sistema  <> 'PACTOS'  AND @sistema <>'PASIVOS'

	SELECT idTipoCriterio AS id, UPPER(RTRIM(nombre)) AS nombre
	FROM dbo.Parametros_TipoCriterio WITH (NOLOCK)
    WHERE idTipoCriterio NOT IN(7,8,9,10,11,12,13,14)


IF @sistema = 'PACTOS'

	SELECT idTipoCriterio AS id, UPPER(RTRIM(nombre)) AS nombre
	FROM dbo.Parametros_TipoCriterio WITH (NOLOCK)
    WHERE idTipoCriterio IN(15,16)
	ORDER BY nombre

IF @sistema = 'PASIVOS'

	SELECT idTipoCriterio AS id, UPPER(RTRIM(nombre)) AS nombre
	FROM dbo.Parametros_TipoCriterio WITH (NOLOCK)
    WHERE idTipoCriterio IN(15,16,17,18,19,20,21,22,23,25,26,27,28,29,30,31,33)
	ORDER BY nombre

GO
