USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_NUM_COTIZACIONES]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGA_NUM_COTIZACIONES]
AS
BEGIN

	SELECT DISTINCT numero_operacion
    FROM	BacSwapSuda.dbo.CARTERA 
    WHERE	estado	   = 'C' 
	AND		tipo_flujo = 1
	ORDER BY numero_operacion

END
GO
