USE [BacSwapSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[FX_ObtieneParidad_Conversion]    Script Date: 13-05-2022 10:59:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FX_ObtieneParidad_Conversion]
(
	@numero_operacion numeric(7,0),
	@numero_flujo numeric (3,0),
	@tipo_flujo	numeric(1,0)
)
RETURNS DECIMAL(18, 6)
AS
BEGIN

	-- Declare the return variable here
	declare @ReturnValue float

	-- Add the T-SQL statements to compute the return value here

	SELECT @ReturnValue = max(valor) FROM [CARTERA_CONVERSION]
	 where numero_operacion = @numero_operacion AND numero_flujo  = @numero_flujo AND tipo_flujo = @tipo_flujo
	    and ( TCMoParidad = 'PARIDAD2' or TCMoParidad = 'PARIDAD3' )
	 	
	-- Return the result of the function
	RETURN @ReturnValue

END

GO
