USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_MODIFICACION_FECHA_FIJACION]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_MODIFICACION_FECHA_FIJACION] (@C_FECHA_FIJACION	DATETIME
														  ,@C_NUMERO_OPERACION	NUMERIC(7,0)
														  ,@C_NUMERO_FLUJO		NUMERIC(3,0)
														  ,@C_RUT_CLIENTE		NUMERIC(9,0)
														  ,@C_TIPO_FLUJO		NUMERIC(1,0))
 AS
 BEGIN
 	
	UPDATE Cartera
	SET fecha_fijacion_tasa = @C_FECHA_FIJACION
	   ,FechaReset			= @C_FECHA_FIJACION
	WHERE numero_operacion	= @C_NUMERO_OPERACION
	  AND numero_flujo		= @C_NUMERO_FLUJO
	  -- AND rut_cliente		= @C_RUT_CLIENTE evitar poner esto como condición
	  AND tipo_flujo		= @C_TIPO_FLUJO
	
 END

GO
