USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SALDOS_CARTERA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_SALDOS_CARTERA]
AS
BEGIN
	SET NOCOUNT ON

	
	
	SELECT 'CUENTA' = LTRIM(RTRIM(a.cuenta)),
	       'DESCRIPCION' = LTRIM(RTRIM(isnull(b.descripcion,a.LLAVE))),
	       'UMMONTO' = LTRIM(RTRIM(a.ummonto)),
	       'mnnemo' = (
	           CASE 
	                WHEN a.ummonto IN (994, 995) THEN 'US.X'
	                ELSE mnnemo
	           END
	       ),
	       'SALDO' = (CONVERT(NUMERIC(19, 3), A.SALDO)),
	       'llave' = LTRIM(RTRIM(llave)),
	       'NomProp' = LTRIM(RTRIM(acnomprop)),
	       'RutProp' = CONVERT(
	           CHAR(12),
	           REPLACE(
	               SUBSTRING(CONVERT(CHAR(13), CONVERT(MONEY, acrutprop), 1), 1, 10),
	               ',',
	               '.'
	           ) + '-' + LTRIM(RTRIM(acdigprop))
	       ),
	       'Fecha' = CONVERT(CHAR(10), acfecproc, 103),
	       'Hora' = CONVERT(CHAR(8), GETDATE(), 108)
	       
	INTO	#Tmp
	FROM	SALDOS_CARTERA		A
	LEFT JOIN  
	       VIEW_PLAN_DE_CUENTA     B ON a.CUENTA = b.cuenta 
	     INNER JOIN  VIEW_MONEDA c ON c.mncodmon = a.UMMONTO
	,	MDAC
	ORDER BY
	       a.cuenta
	

	DECLARE @COUNT AS INT
	SET @COUNT = (SELECT COUNT(*) FROM #TMP, mdac)
	

	IF @COUNT <> 0
	BEGIN


	
	SELECT cuenta,
	       descripcion,
	       ummonto,
	       Mnnemo,
	       'SALDO' = SUM(ROUND(saldo, 2)),
	       Fecha,
	       Hora,
	       NomProp = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales),
	       RutProp
	FROM   #TMP,
	       mdac
	GROUP BY
	       cuenta,
	       descripcion,
	       ummonto,
	       mnnemo,
	       Fecha,
	       Hora,
	       NomProp,
	       RutProp 
	
	END

	ELSE

	BEGIN

	SELECT cuenta = '',
	       descripcion = '',
	       ummonto = '',
	       Mnnemo = '',
	       'SALDO' = 0,
	       Fecha = '',
	       Hora = '',
	       NomProp = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales),
	       RutProp = ''

	END
	

    
SET NOCOUNT OFF      

END
-- Base de Datos --

GO
