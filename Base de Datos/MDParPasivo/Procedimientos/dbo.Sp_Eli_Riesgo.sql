USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Eli_Riesgo]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Eli_Riesgo]
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


	DECLARE @fecha_proceso DATETIME

	SELECT 	@fecha_proceso = Fecha_Proceso
	FROM	DATOS_GENERALES

	DELETE	CARTERA_MANUAL
	WHERE	fecha_proceso	= @fecha_proceso 

	SET NOCOUNT OFF

END


GO
