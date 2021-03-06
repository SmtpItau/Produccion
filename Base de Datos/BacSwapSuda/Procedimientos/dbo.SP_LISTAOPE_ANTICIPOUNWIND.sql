USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAOPE_ANTICIPOUNWIND]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LISTAOPE_ANTICIPOUNWIND](
	@FechaInicio 	DATETIME,
	@FechaTermino 	DATETIME
)
AS

BEGIN
	SELECT CAR.FechaAnticipo
	, CAR.numero_operacion
	, 'RutCliente' = ltrim(rtrim(convert(char(10),CLI.Clrut))) + '-' +CLI.Cldv
	, CLI.Clnombre 
	, mon.mnnemo
	, CAR.compra_capital 
	FROM cartera_UNWIND CAR
		LEFT  JOIN BacParamSuda.dbo.CLIENTE CLI ON CLI.clrut = CAR.rut_cliente AND CLI.clrut = CAR.rut_cliente
		LEFT  JOIN BacParamSuda.dbo.MONEDA  MON ON MON.mncodmon = CAR.compra_moneda
	WHERE CAR.tipo_flujo = 1 AND FechaAnticipo BETWEEN @FechaInicio AND @FechaTermino
	GROUP BY CAR.FechaAnticipo,CAR.numero_operacion,CLI.Clrut,CLI.Cldv, CLI.Clnombre ,mon.mnnemo , CAR.compra_capital 
END

GO
