USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_VAR_MONEDA]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_VAR_MONEDA]
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	SELECT  Codigo_Variabilidad,
		Descripcion
	FROM MONEDA_VARIABILIDAD
	ORDER BY Codigo_Variabilidad


END

GO
