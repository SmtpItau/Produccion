USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_REGLA]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_REGLA]
			
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

		SELECT 
			numero_regla		,
			nombre_regla		,
			para			,
			cc			,
			otros			,
			asunto			,
			estado			
		FROM REGLA_MENSAJE
		ORDER BY numero_regla
END


GO
