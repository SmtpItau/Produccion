USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_NUM_OPERACIONES]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CARGA_NUM_OPERACIONES]
AS
BEGIN

	SELECT DISTINCT numero_operacion
     FROM BacSwapSuda.dbo.CARTERA 
    WHERE estado	 = '' 
	 AND  tipo_flujo = 1
	order by numero_operacion

END
GO
