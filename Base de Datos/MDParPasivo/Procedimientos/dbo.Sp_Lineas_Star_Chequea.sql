USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lineas_Star_Chequea]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Lineas_Star_Chequea]( @Fecha_Proceso DATETIME)
AS BEGIN

	SET DATEFORMAT dmy
	SET NOCOUNT ON


	IF EXISTS(	SELECT	1
			FROM	CARTERA_LINEAS_STAR
			WHERE	fecha_proceso = @Fecha_Proceso )

		SELECT 'SI'	
	ELSE
		SELECT 'NO'	


	SET NOCOUNT OFF

END



GO
