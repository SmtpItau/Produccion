USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_TRAER_DATOS]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_TRAER_DATOS]
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	SELECT Codigo_Amortizacion 
	       ,Descripcion
	FROM TIPO_AMORTIZACION
	ORDER BY Codigo_Amortizacion 

END

GO
