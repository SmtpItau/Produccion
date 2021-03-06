USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_PAIS_PLAZAS]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_PAIS_PLAZAS]
AS BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy
	SELECT	DISTINCT
		a.codigo_pais,
		a.nombre
	FROM PAIS	AS a
	INNER JOIN  PLAZA as b ON
		a.codigo_pais = b.codigo_pais
	ORDER BY a.nombre

SET NOCOUNT OFF
END


GO
