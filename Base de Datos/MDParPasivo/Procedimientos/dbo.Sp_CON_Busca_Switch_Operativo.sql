USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_CON_Busca_Switch_Operativo]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_CON_Busca_Switch_Operativo]
		( @cOpcion_Menu Char(20))

AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

	IF EXISTS(SELECT * FROM  SWITCH_OPERATIVO WHERE RTRIM(LTRIM(Codigo_Control)) = RTRIM(LTRIM(@cOpcion_Menu)))
	BEGIN
		SELECT 	Orden 		,
			Orden_Especial	,
			Descripcion 
		FROM  SWITCH_OPERATIVO
		WHERE RTRIM(LTRIM(Codigo_Control)) = RTRIM(LTRIM(@cOpcion_Menu))
	END
	ELSE
		SELECT 	0	,
			0	,
			''
END




GO
