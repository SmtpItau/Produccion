USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_TIPO_BASE]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_TIPO_BASE](@isistema CHAR(3))
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	SELECT  Codigo_Base,
		Descripcion,
		Base
	FROM TIPO_BASE
	WHERE id_sistema = @isistema
	ORDER by Codigo_Base


END

GO
