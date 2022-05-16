USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_REL_BANCO]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_REL_BANCO]
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	SELECT  Codigo_Relacion_Banco,
		Descripcion
	FROM RELACION_BANCO
	ORDER BY Codigo_Relacion_Banco


END

GO
