USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CALIDAD_JURIDICA]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_CALIDAD_JURIDICA]
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	SELECT	Codigo_Calidad		,
	       	Descripcion		,
               	Codigo_calidad_contable	,
		sector
	FROM 	CALIDAD_JURIDICA
	ORDER BY 
		Codigo_Calidad


END



GO
