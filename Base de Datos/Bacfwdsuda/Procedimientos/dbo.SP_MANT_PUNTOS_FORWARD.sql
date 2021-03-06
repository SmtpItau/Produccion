USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MANT_PUNTOS_FORWARD]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MANT_PUNTOS_FORWARD] ( @FechaProceso DATETIME,
					      @cClase CHAR(2) = '',
					      @cOpc   CHAR(1) = ''
					    )
AS
BEGIN
	SET NOCOUNT ON
	
	IF @cOpc = 'C'
	BEGIN
		SELECT  Banda, 
			plazo, 
			Bid, 
			Ask, 
			SpreadCom_Compra, 
			SpreadCom_Venta, 
			SpreadTra_Compra, 
			SpreadTra_Venta 
		FROM TBL_TRXCOMEX_PUNTOS WITH(NOLOCK)
		WHERE Fecha = @FechaProceso
		AND (clase = @cClase or @cClase = '')
	END

	IF @cOpc = 'E'
	BEGIN
		DELETE FROM TBL_TRXCOMEX_PUNTOS
		WHERE Fecha = @FechaProceso
		AND clase = @cClase 
	END

	SET NOCOUNT OFF
END

GO
