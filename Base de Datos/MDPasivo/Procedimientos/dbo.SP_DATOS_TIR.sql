USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOS_TIR]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DATOS_TIR]
			(
				@serie 		CHAR(15)
			,	@nominal	FLOAT
			)
AS
BEGIN
	DECLARE @Cant_flujos INTEGER

	SELECT @Cant_flujos = COUNT(1) FROM FLUJO_BONOS WHERE LTRIM(RTRIM(nombre_serie)) = LTRIM(RTRIM(@serie))


	SELECT @Cant_flujos , ((flujo /100) * @nominal),* FROM FLUJO_BONOS WHERE LTRIM(RTRIM(nombre_serie)) = LTRIM(RTRIM(@serie))


END
GO
