USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaCont_ObtieneCriterioPasivos]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CuadraturaCont_ObtieneCriterioPasivos]
AS
BEGIN

	SELECT    'CodIBS'			= cc.codIBS
			, 'NombreCuenta'	= p.PlanCuenta
			, 'SaldoCartera'    = ABS(ISNULL(cc.saldoContable,0))
			, 'SaldoContable'	= ABS(ISNULL(cc.saldoIBS,0))
			, 'Diferencia'      = ABS(ISNULL(cc.saldoContable,0) - ISNULL(cc.saldoIBS,0))
			, 'TipoBono'		= p.Tipo_Bono
			, 'Serie'			=  p.NombreSerie
	FROM    dbo.Parametros_Detalle_Pasivos AS p INNER JOIN
			dbo.Parametros_TipoCriterio AS tc ON p.TipoCriterio = tc.IdTipoCriterio INNER JOIN
			dbo.CuadraturaContableDerivados AS cc ON p.Sistema = cc.Sistema AND p.CodIBS = cc.codIBS

 END

GO
