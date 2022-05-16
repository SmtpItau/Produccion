USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Selecciona_Pais]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Selecciona_Pais]
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

		SELECT	codigo_pais,
			nombre
		FROM	PAIS
		ORDER BY nombre

END


GO
