USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGE_GRABA_POSMX]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_HEDGE_GRABA_POSMX] 	(	@Fecha	DATETIME
						,	@Moneda CHAR(3)		
				 		,	@PosMX	FLOAT
						)
AS BEGIN

	DELETE TBL_HEDGE_POSICION_MX WHERE Hedge_Fecha = @Fecha
								 AND   Hedge_Moneda= @Moneda
	
	INSERT INTO TBL_HEDGE_POSICION_MX
	( 	Hedge_Fecha
	,	Hedge_Moneda
	,	Hedge_PosMX		
	)
	VALUES	
	(	@Fecha	
	,	@Moneda 
	,	@PosMX	
	) 
	
END
GO
