USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_TIPO_MERCADO]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_TIPO_MERCADO]
AS
BEGIN

   	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	SELECT  Codigo_mercado,
		Descripcion
	FROM TIPO_MERCADO
	ORDER BY Codigo_mercado
END

GO
