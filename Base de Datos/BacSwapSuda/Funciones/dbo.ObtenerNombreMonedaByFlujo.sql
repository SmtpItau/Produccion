USE [BacSwapSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[ObtenerNombreMonedaByFlujo]    Script Date: 13-05-2022 10:59:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE FUNCTION [dbo].[ObtenerNombreMonedaByFlujo]
(
	-- Add the parameters for the function here

	 @numero_operacion numeric(7,0)
	,@numero_flujo	numeric (3,0)
	,@tipo_flujo	numeric (1,0)
)
RETURNS NVARCHAR(40)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Name NVARCHAR(40)

	-- Add the T-SQL statements to compute the return value here
	
	IF @tipo_flujo = 1 
	BEGIN 
		SET @Name = (
		SELECT mnglosa FROM VIEW_MONEDA 
			INNER JOIN CARTERA_UNWIND  ON mncodmon = compra_moneda
			WHERE numero_operacion = @numero_operacion
				AND numero_flujo = @numero_flujo
				AND tipo_flujo = @tipo_flujo )
	END
	ELSE
	BEGIN
		SET @Name = (
		SELECT mnglosa FROM VIEW_MONEDA 
			INNER JOIN CARTERA_UNWIND  ON mncodmon = venta_moneda
			WHERE numero_operacion = @numero_operacion
				AND numero_flujo = @numero_flujo
				AND tipo_flujo = @tipo_flujo )
	
	END
	-- Return the result of the function
	RETURN @Name

END


GO
