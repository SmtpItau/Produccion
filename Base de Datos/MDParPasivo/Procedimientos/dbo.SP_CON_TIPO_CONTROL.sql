USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_TIPO_CONTROL]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_TIPO_CONTROL]
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	SELECT  codigo_control,
		Descripcion
	FROM TIPO_CONTROL
	ORDER BY codigo_control	 


END

GO
