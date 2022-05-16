USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_MONEDA_TIPO]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_MONEDA_TIPO]
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	SELECT Codigo_Tipo_Moneda 
	       ,Descripcion
	FROM MONEDA_TIPO
	ORDER BY Codigo_Tipo_Moneda

END


GO
