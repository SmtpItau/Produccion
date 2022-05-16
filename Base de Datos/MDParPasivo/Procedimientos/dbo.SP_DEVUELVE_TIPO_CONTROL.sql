USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEVUELVE_TIPO_CONTROL]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_DEVUELVE_TIPO_CONTROL]

AS BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy

	SELECT	codigo_control	,
		descripcion	,
		tipo_control
	FROM	TIPO_CONTROL
	ORDER BY descripcion

SET NOCOUNT OFF
END



GO
