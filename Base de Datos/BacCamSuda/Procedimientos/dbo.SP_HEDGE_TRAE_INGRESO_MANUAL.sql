USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGE_TRAE_INGRESO_MANUAL]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HEDGE_TRAE_INGRESO_MANUAL]
	@fecha_proceso DATETIME
AS
BEGIN
	SELECT 	Fecha_Proceso,
		id_hedge,
		Origen,
		Concepto,
		Moneda,
		Monto_Compra,
		Monto_Venta
	FROM tbl_hedge_ingreso_manual WITH(NOLOCK)
	WHERE Fecha_Proceso = @fecha_proceso
	ORDER BY Fecha_Proceso,id_hedge
END

GO
