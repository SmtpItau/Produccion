USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGEDELMONEDAORDEN]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HEDGEDELMONEDAORDEN]( @CODIGO NUMERIC(5,0) )
AS
BEGIN
 
     SET NOCOUNT ON
     
     	DECLARE @EXISTE AS INT
        SET @EXISTE = 0

	SELECT @EXISTE =1 
	FROM TBL_HEDGE_ORDEN_MONEDAS
     	WHERE CODIGO_MONEDA = @CODIGO
 	
	

	IF @EXISTE = 1 
	BEGIN
 
		DELETE FROM TBL_HEDGE_ORDEN_MONEDAS 
		WHERE CODIGO_MONEDA  = @CODIGO 
	END
	ELSE
		BEGIN  RETURN
	END 
                        
     IF @@ERROR <> 0  
     BEGIN
        SELECT -1, 'ERROR no se puede eliminar esta Moneda Hedge'
     END  -- IF
END
GO
