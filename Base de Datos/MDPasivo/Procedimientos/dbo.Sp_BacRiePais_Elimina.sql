USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacRiePais_Elimina]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_BacRiePais_Elimina] ( @codigo	NUMERIC(5) )

AS

BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy

	DELETE FROM RIESGO_PAIS WHERE codigo_pais= @codigo 

	SET NOCOUNT OFF

END
















GO
