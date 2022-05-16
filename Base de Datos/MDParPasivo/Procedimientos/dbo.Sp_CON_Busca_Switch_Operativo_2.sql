USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_CON_Busca_Switch_Operativo_2]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_CON_Busca_Switch_Operativo_2]
		( @cSistema Char(03))

AS
BEGIN

   SET DATEFORMAT dmy

	IF EXISTS(SELECT * FROM  SWITCH_OPERATIVO WHERE RTRIM(LTRIM(Sistema)) = RTRIM(LTRIM(@cSistema)))
	BEGIN
		SELECT 	Codigo_Control	,
			Orden 		,
			Orden_Especial	,
			1
		FROM  SWITCH_OPERATIVO
		WHERE RTRIM(LTRIM(Sistema)) = RTRIM(LTRIM(@cSistema))
	END
	ELSE
		SELECT 	""	,
			0	,
			0	,
			0
END






GO
