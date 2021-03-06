USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_REGLA_DETALLE_SWITCH]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_REGLA_DETALLE_SWITCH]
					(
					@inumero_regla	NUMERIC(10)
					)
AS
BEGIN

		SET DATEFORMAT dmy
		SET NOCOUNT ON

		SELECT 
			numero_regla		,
			id_sistema		,
			Opcion_menu		,
			Descripcion
		FROM REGLA_MENSAJE_DETALLE, SWITCH_OPERATIVO
		WHERE id_sistema = sistema AND Opcion_menu = codigo_control AND @inumero_regla = numero_regla

END


GO
