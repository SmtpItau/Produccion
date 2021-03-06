USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_SISTEMA]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_SISTEMA]
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	SELECT id_sistema,
	       nombre_sistema,
               operativo, 
	       gestion 
	FROM SISTEMA
	WHERE OPERATIVO = "S"
	ORDER BY nombre_sistema

END


GO
