USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_TasasmConvencional_Elimina1]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_TasasmConvencional_Elimina1] 
		(	
		@codigo_moneda		NUMERIC(5,0)	
		)
AS 
BEGIN

SET NOCOUNT ON
   IF EXISTS(SELECT codigo_moneda FROM TASAS_MAXIMAS_CONVENCIONAL 
		WHERE	codigo_moneda	= @codigo_moneda)
		    
   BEGIN

	   DELETE TASAS_MAXIMAS_CONVENCIONAL 
		WHERE	codigo_moneda	= @codigo_moneda
		    	

	   IF @@ERROR <> 0 
	   BEGIN
 
	   	SELECT 'ERROR'

	   END ELSE
	   BEGIN

		SELECT 'OK'

	   END

   END ELSE
   BEGIN

   	SELECT 'NO EXISTE'

   END

SET NOCOUNT OFF

END

GO
