USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ULTIMAOPERACION_SIM]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ULTIMAOPERACION_SIM]
	( @Codigo  CHAR(03),
      @Entidad CHAR(02) 
	)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @cantidad NUMERIC(7)
	SELECT @cantidad = COUNT(*) FROM SWAPGENERAL_SIM  
	IF @cantidad = 0
	BEGIN
		INSERT INTO SWAPGENERAL_SIM(numero_operacion)  
		VALUES(0)
	END
	
	UPDATE SWAPGENERAL_SIM   
    SET numero_operacion = numero_operacion + 1

	IF @@ERROR <> 0  BEGIN
		SELECT -1, 'No se puede capturar Correlativo de Operacion'
		SET NOCOUNT OFF
		RETURN
	END
	DECLARE @NumOperacion NUMERIC(7)
	SELECT numero_operacion
	FROM SWAPGENERAL_SIM  
	SET NOCOUNT OFF
END

GO
