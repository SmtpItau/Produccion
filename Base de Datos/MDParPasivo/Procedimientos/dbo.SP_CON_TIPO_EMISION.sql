USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_TIPO_EMISION]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_TIPO_EMISION]
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	SELECT  Codigo_Tipo_Emision,
		Nemotecnico
	FROM TIPO_EMISION
	ORDER by Codigo_Tipo_Emision


END

GO
