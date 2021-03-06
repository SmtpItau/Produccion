USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERTA_PUNTOS_FORWARD]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INSERTA_PUNTOS_FORWARD]  ( 	
  	 @nBanda		Numeric (3,0)		
	,@nMoneda		Numeric (3,0)	
	,@dFecha		Datetime		
	,@nPlazo		Numeric (3,0) 		
	,@fBid			Float			
	,@fAsk			Float			
	,@fSpreadCom_Compra	Float			
	,@fSpreadCom_Venta	Float			
	,@fSpreadTra_Compra	Float			
	,@fSpreadTra_Venta	Float			
	,@cClase		Char(2)			
					   	 )
AS
BEGIN
	SET NOCOUNT ON
	
	INSERT INTO TBL_TRXCOMEX_PUNTOS
	VALUES( @nBanda				
		,@nMoneda			
		,@dFecha				
		,@nPlazo		 		
		,@fBid						
		,@fAsk						
		,@fSpreadCom_Compra				
		,@fSpreadCom_Venta				
		,@fSpreadTra_Compra				
		,@fSpreadTra_Venta				
		,@cClase				
	)
	SET NOCOUNT OFF
END

GO
