USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_TIPO_INSTRUMENTO]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_TIPO_INSTRUMENTO]
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	SELECT Codigo_Tipo_instrumento,
		Nemotecnico
	FROM TIPO_INSTRUMENTO
	ORDER by Codigo_Tipo_instrumento


END

GO
