USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OBTAVR_SIM]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_OBTAVR_SIM]  
	(	@Operacion NUMERIC(9)
	)
AS
BEGIN
	SET NOCOUNT ON
	SELECT Valor_RazonableCLP
	FROM Cartera_Sim
	WHERE Numero_operacion = @Operacion
	AND numero_flujo = 1
	AND tipo_flujo = 1	
	SET NOCOUNT OFF
END

GO
