USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacMntmp_Sistema]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_BacMntmp_Sistema]
AS
BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy

	IF EXISTS(SELECT 1 FROM SISTEMA WHERE operativo='S') BEGIN

		SELECT  id_sistema,
			nombre_sistema,
			operativo,
			gestion

		 FROM SISTEMA

			 WHERE operativo='S' AND gestion = 'N'
			 ORDER BY nombre_sistema

	END

	ELSE BEGIN
		
		SELECT "ERROR"

	END

	SET NOCOUNT ON

END



GO
