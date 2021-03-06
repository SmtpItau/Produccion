USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_FECHAS_FLUJO_FERIADO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_FECHAS_FLUJO_FERIADO] (@NumeroOperacion	NUMERIC
												    ,@NumeroFlujo		NUMERIC
												    ,@TipoFlujo			NUMERIC
													)
 AS
 BEGIN
 SET NOCOUNT ON   

	/*
	exec SP_BUSCA_FECHAS_FLUJO_FERIADO 9645,3,2
	*/
	
	SELECT MAX(fecha_inicio_flujo)
	FROM CARTERA 
	WHERE numero_operacion=@NumeroOperacion
	AND numero_flujo<@NumeroFlujo	
	AND tipo_flujo=@TipoFlujo
		
	UNION

	SELECT MIN(fecha_inicio_flujo)
	FROM CARTERA c
	WHERE numero_operacion=@NumeroOperacion
	AND numero_flujo>@NumeroFlujo	
	AND tipo_flujo=@TipoFlujo
	
	SET NOCOUNT OFF
 END

GO
