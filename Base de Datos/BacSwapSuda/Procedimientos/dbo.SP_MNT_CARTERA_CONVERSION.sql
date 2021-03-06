USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_CARTERA_CONVERSION]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MNT_CARTERA_CONVERSION]
	(   
		@numero_operacion	NUMERIC(7,0)  
	,   @numero_flujo		NUMERIC(3,0) 
	,   @tipo_flujo			NUMERIC(1,0) 
	,	@fecha_rescate		DATETIME
	,   @valor_moneda		float  
	,   @digitaSN			Char(1)
	,   @TCMoParidad        VArchar(10)
	,   @iOperacion			INTEGER    = 0  
	)
AS
BEGIN
    -- dbo.SP_MNT_CARTERA_CONVERSION
	SET NOCOUNT ON
	IF @iOperacion = 0
	BEGIN
		IF EXISTS(SELECT 1 FROM CARTERA_CONVERSION WHERE numero_operacion = @numero_operacion AND numero_flujo = @numero_flujo AND tipo_flujo = @tipo_flujo and TCMoParidad = @TCMoParidad)
			BEGIN  
				UPDATE CARTERA_CONVERSION 
				SET    fecha_rescate  = @fecha_rescate  , valor = @valor_moneda, digitaSN = @digitaSN, TCMoParidad = @TCMoParidad				       
				WHERE	numero_operacion  = @numero_operacion  AND numero_flujo = @numero_flujo AND tipo_flujo=@tipo_flujo and TCMoParidad = @TCMoParidad
			END ELSE  
			BEGIN  
				INSERT INTO CARTERA_CONVERSION 	( numero_operacion , numero_flujo, tipo_flujo, fecha_rescate, valor, digitaSN, TCMoParidad)
				VALUES (@numero_operacion,@numero_flujo,@tipo_flujo,@fecha_rescate,@valor_moneda,@digitaSN, @TCMoParidad)
			END
	-- Registra datos en tabla Cartera_Conversion 
	END ELSE  
	BEGIN
		IF @iOperacion = 1					/*Marca PARA BORRAR REGISTRO */
		BEGIN
			DELETE FROM CARTERA_CONVERSION WHERE numero_operacion = @numero_operacion AND numero_flujo = @numero_flujo AND tipo_flujo = @tipo_flujo and TCMoParidad = @TCMoParidad
		END		
	END
END  
GO
