USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ClienteRela]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_ClienteRela]
		(@rut_padre 	NUMERIC(10),
		 @codigo_padre 	NUMERIC(10),
		 @rut_hijo 	NUMERIC(10),
		 @codigo_hijo 	NUMERIC(10))
AS 
BEGIN
	SET NOCOUNT ON
        SET DATEFORMAT dmy

	SELECT 	clrut_padre,
		clcodigo_padre,
		clrut_hijo,
		clcodigo_hijo,
		clporcentaje

	FROM CLIENTE_RELACIONADO

	WHERE clrut_padre =@rut_padre
	AND   clcodigo_padre = @codigo_padre
	AND   clrut_hijo =@rut_hijo 
	AND   clcodigo_hijo =@codigo_hijo

	SET NOCOUNT OFF
END



GO
