USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_REGLA_DETALLE]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_REGLA_DETALLE]
					(
					@inumero_regla	NUMERIC(10)
					)
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

		SELECT  numero_regla		,
			nombre_regla		,
			para			,
			cc			,
			otros			,
			asunto			,
			estado			
		FROM    REGLA_MENSAJE
		WHERE   @inumero_regla = numero_regla

END


GO
