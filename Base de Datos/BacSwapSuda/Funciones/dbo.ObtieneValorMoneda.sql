USE [BacSwapSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[ObtieneValorMoneda]    Script Date: 13-05-2022 10:59:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ObtieneValorMoneda]
(
	@Date datetime,
	@CodMoneda int
)
RETURNS DECIMAL(18, 4)
AS
BEGIN

	-- Declare inner variables here
	declare @CodMonPaso int

	-- set temporal variable with the value of the enter parameters
	IF(@CodMoneda = 13)
		BEGIN
			set @CodMonPaso = 994	/*DOLAR OBS*/
		END
	ELSE
		BEGIN
			set @CodMonPaso = @CodMoneda
		END

	-- Declare the return variable here
	declare @ReturnValue decimal(18,4)

	-- Add the T-SQL statements to compute the return value here

	SELECT @ReturnValue = vmvalor FROM [BacSwapSuda].[dbo].[view_Valor_Moneda]
	 where CONVERT(CHAR(8),vmfecha,112) = CONVERT(CHAR(8),@Date,112) 
	 AND vmcodigo = @CodMonPaso 
	
	
	-- Return the result of the function
	RETURN isnull(@ReturnValue, 0)

END
GO
