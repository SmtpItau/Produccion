USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGEACTMONEDAORDEN]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HEDGEACTMONEDAORDEN]
   (   @Codigo	     	NUMERIC(5,0)	
   ,   @OrdenMoneda     NUMERIC(5,0)		   	
   )


	
AS
BEGIN

   SET NOCOUNT ON 
   	DECLARE @EXISTE AS INT
        SET @EXISTE = 0

	SELECT @EXISTE =1 
	FROM TBL_HEDGE_ORDEN_MONEDAS
     	WHERE CODIGO_MONEDA = @CODIGO
   
   IF  @EXISTE = 0
   BEGIN
	   INSERT INTO TBL_HEDGE_ORDEN_MONEDAS
	   (     CODIGO_MONEDA	
	   ,	 ORDEN_MONEDA	
	   )
	   VALUES 
	   (   	@Codigo	     		
	   ,   	@OrdenMoneda    	   	
	   )
   END 
END
GO
