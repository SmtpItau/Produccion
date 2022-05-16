USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRUPO_MATRIZ]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GRUPO_MATRIZ]
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

	SELECT	DISTINCT
		tipo_usuario,
		tipo_usuario
	FROM MATRIZ_ATRIBUCION

END





GO
