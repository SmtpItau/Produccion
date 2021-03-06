USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Busca_Switch_Operativo]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Busca_Switch_Operativo]
		( @cOpcion_Menu Char(20))

AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM  SWITCH_OPERATIVO WHERE RTRIM(LTRIM(Codigo_Control)) = RTRIM(LTRIM(@cOpcion_Menu)))
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
			' '

END


GO
