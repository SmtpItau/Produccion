USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_CmbSistema]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_CmbSistema]
AS 
BEGIN
	SET NOCOUNT ON
        SET DATEFORMAT dmy

	SELECT id_sistema,nombre_sistema
	FROM SISTEMA  WHERE operativo='S' and  gestion ='N'
	ORDER BY  nombre_sistema
	SET NOCOUNT OFF
END



GO
