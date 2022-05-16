USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELI_REGLA]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ELI_REGLA]
					(
					@nNumero_Regla	Numeric(10)	
					)
AS
BEGIN

	SET DATEFORMAT dmy
	SET NOCOUNT ON

	DELETE REGLA_MENSAJE_DETALLE 	WHERE numero_regla = @nNumero_Regla
	DELETE REGLA_MENSAJE 		WHERE numero_regla = @nNumero_Regla

END


GO
