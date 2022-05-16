USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOS_TIR_CORFO]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DATOS_TIR_CORFO]
			(
				@numero_operacion NUMERIC (19)
			)
AS
BEGIN
	DECLARE @Cant_flujos INTEGER

	SELECT @Cant_flujos = COUNT(1) FROM FLUJO_CREDITOS WHERE numero_operacion = @numero_operacion


	SELECT @Cant_flujos , cuota_flujo FROM FLUJO_CREDITOS WHERE numero_operacion =@numero_operacion ORDER BY cuota_correlativo


END

GO
