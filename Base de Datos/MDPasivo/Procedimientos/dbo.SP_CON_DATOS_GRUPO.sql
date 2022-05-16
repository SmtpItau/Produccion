USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_DATOS_GRUPO]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_DATOS_GRUPO]
		(
		@tipo_usuario	CHAR(15)
		)
AS BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy
	IF EXISTS(SELECT 1 FROM	MATRIZ_ATRIBUCION WHERE	tipo_usuario = @tipo_usuario) BEGIN
		SELECT 'SI'
	END ELSE BEGIN
		SELECT 'NO'
	END
SET NOCOUNT OFF
END
		






GO
