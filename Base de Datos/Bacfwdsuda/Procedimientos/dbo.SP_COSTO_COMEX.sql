USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COSTO_COMEX]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[SP_COSTO_COMEX] (	@CompVenta	Char(1),
					@Fecha       	CHAR(8),
					@Monto		NUMERIC(18,4))	
AS
BEGIN
	SET NOCOUNT ON

	IF  @CompVenta= 'V' 
		SELECT	Costo_Venta,
			Entre_Desde,
			Entre_Hasta,
			Spread_Venta,
			Spread_Trading_Venta,
			perfil_comercial
		FROM	BacCamSuda..COSTOS_COMEX
		WHERE	Fecha		= @Fecha

	IF  @CompVenta= 'C' 
		SELECT	Costo_COMPRA,
			Entre_Desde,
			Entre_Hasta,
			Spread_Compra,
			Spread_Trading_Compra,
			perfil_comercial
		FROM	BacCamSuda..COSTOS_COMEX
		WHERE	Fecha		= @Fecha

	SET NOCOUNT OFF
END

GO
