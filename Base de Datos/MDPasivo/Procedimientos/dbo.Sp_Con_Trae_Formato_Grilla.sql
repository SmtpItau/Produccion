USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Con_Trae_Formato_Grilla]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Con_Trae_Formato_Grilla]
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


	SELECT Moneda_Control,
		MNNEMO
	FROM DATOS_GENERALES
	,	MONEDA
	WHERE   Moneda_Control = Mncodmon

END
GO
