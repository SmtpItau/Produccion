USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_ESTADO_LETRA]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_ESTADO_LETRA]
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	SELECT  codigo_letra,
		Descripcion
	FROM ESTADO_LETRA_HIPOTECARIA
	ORDER BY codigo_letra	 


END

GO
