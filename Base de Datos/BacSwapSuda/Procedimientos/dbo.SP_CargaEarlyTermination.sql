USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CargaEarlyTermination]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CargaEarlyTermination]
(
	@numoper    NUMERIC(10)	
)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT bEarlyTermination
	,      Periodicidad
	,      FechaInicio 
	FROM   Cartera 
	WHERE  numero_operacion = @numoper
END

GO
