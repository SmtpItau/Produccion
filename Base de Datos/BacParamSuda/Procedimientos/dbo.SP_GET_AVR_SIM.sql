USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_AVR_SIM]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GET_AVR_SIM]  

	(	
		@Operacion NUMERIC(9)

	)

AS

BEGIN

	SET NOCOUNT ON

	SELECT TOP 1 Valor_RazonableCLP

	FROM Cartera_Sim

	WHERE Numero_operacion = @Operacion

	--AND numero_flujo = 1

	AND tipo_flujo = 1	
	ORDER BY numero_flujo

	SET NOCOUNT OFF

END
GO
