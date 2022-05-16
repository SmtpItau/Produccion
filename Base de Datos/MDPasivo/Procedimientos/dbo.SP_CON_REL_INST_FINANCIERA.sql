USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_REL_INST_FINANCIERA]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_REL_INST_FINANCIERA]
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	SELECT  Codigo_Relacion_IF,
		Descripcion
	FROM RELACION_IF
	ORDER BY Codigo_Relacion_IF


END

GO
