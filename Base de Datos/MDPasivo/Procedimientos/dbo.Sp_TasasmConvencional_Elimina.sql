USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TasasmConvencional_Elimina]    Script Date: 16-05-2022 11:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_TasasmConvencional_Elimina]

		(	@codigo_producto	CHAR(5)		,
			@codigo_moneda		NUMERIC(5,0)	
		)

AS 
BEGIN

   SET NOCOUNT OFF
   SET DATEFORMAT dmy

   IF EXISTS(SELECT codigo_producto FROM TASAS_MAXIMAS_CONVENCIONAL 
		WHERE	codigo_producto	= @codigo_producto 	
		    AND	codigo_moneda	= @codigo_moneda)

   BEGIN

	   DELETE TASAS_MAXIMAS_CONVENCIONAL 
		WHERE	codigo_producto	= @codigo_producto 	
		    AND	codigo_moneda	= @codigo_moneda

   END

   SET NOCOUNT ON

END

















GO
