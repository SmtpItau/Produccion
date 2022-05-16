USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_TIPO_CUENTA]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CON_TIPO_CUENTA]
AS 
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON


	SELECT	codigo	,
		descripcion
	FROM	TIPO_CUENTA

END

GO
