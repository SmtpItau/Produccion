USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGE_GRABA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HEDGE_GRABA] 	(	@Fecha	DATETIME		
				 	,	@Hedge	FLOAT
					 )
AS BEGIN

	DELETE TBL_HEDGE WHERE Fecha = @Fecha
	
	INSERT INTO TBL_HEDGE 
	VALUES	 (@Fecha		
		 ,@Hedge
		 )
END

GO
