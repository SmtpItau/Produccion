USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_CARTERA_FIJACION]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MNT_CARTERA_FIJACION]
	(   
		@numero_operacion	NUMERIC(7,0)  
	,   @numero_flujo		NUMERIC(3,0) 
	,   @tipo_flujo			NUMERIC(1,0) 
	,	@fecha_rescate		DATETIME
	,   @valor_tasa			float  
	,   @digitaSN			Char(1)
	,   @iOperacion			INTEGER    = 0  
	)
AS
BEGIN
    /* Modificar para que llame al proceso que regulariza 
	   el monto de interes: SP_GRABATASASFLUJOSINICIAN */    

    SET NOCOUNT ON
	IF @iOperacion = 0
	BEGIN
		exec SP_GRABATASASFLUJOSINICIAN @numero_operacion, @numero_Flujo, @valor_tasa, @tipo_flujo
				 
		--****************** Graba en Cartera_Fijacion
		IF EXISTS(SELECT 1 FROM CARTERA_FIJACION WHERE numero_operacion = @numero_operacion AND numero_flujo = @numero_flujo AND tipo_flujo = @tipo_flujo)
			BEGIN  
				UPDATE CARTERA_FIJACION 
				SET    fecha_rescate  = @fecha_rescate  , valor_tasa = @valor_tasa, digitaSN = @digitaSN
				WHERE	numero_operacion  = @numero_operacion  AND numero_flujo = @numero_flujo AND tipo_flujo=@tipo_flujo
			END ELSE  
			BEGIN  
				INSERT INTO CARTERA_FIJACION 	( numero_operacion , numero_flujo, tipo_flujo, fecha_rescate, valor_tasa, digitaSN)
				VALUES (@numero_operacion,@numero_flujo,@tipo_flujo,@fecha_rescate,@valor_tasa,@digitaSN)
			END
	-- Registra datos en tabla Cartera_Conversion 
	END ELSE  
	BEGIN
		IF @iOperacion = 1					/*Marca PARA BORRAR REGISTRO */
		BEGIN
			DELETE FROM CARTERA_FIJACION WHERE numero_operacion = @numero_operacion AND numero_flujo = @numero_flujo AND tipo_flujo = @tipo_flujo
		END		
	END
END
GO
