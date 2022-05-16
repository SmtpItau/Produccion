USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CATEGORIA_DEUDOR]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_CATEGORIA_DEUDOR]
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	SELECT Codigo_Deudor,
		Descripcion
	FROM CATEGORIA_DEUDOR
	ORDER BY Codigo_Deudor


END

GO
