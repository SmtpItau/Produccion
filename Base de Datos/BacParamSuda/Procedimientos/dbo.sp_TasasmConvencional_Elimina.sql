USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_TasasmConvencional_Elimina]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_TasasmConvencional_Elimina] 

		(	
			@codigo_moneda		NUMERIC(5,0)	,
			@diasdesde		NUMERIC(5,0)	,
			@DiasHasta 		NUMERIC(6,0)    ,
			@MontoMinimo            NUMERIC(19,4)   ,
			@MontoMaximo            NUMERIC(19,4)   ,
			@TasaMinima 		NUMERIC(8,4)   
			 
		)

AS 
BEGIN

   SET NOCOUNT OFF
   IF EXISTS(SELECT * FROM TASAS_MAXIMAS_CONVENCIONAL 
		WHERE	
		     codigo_moneda	= @codigo_moneda
		    AND	diasdesde	= @diasdesde
		    AND	DiasHasta 	= @DiasHasta 		
		    AND	MontoMinimo	= @MontoMinimo            
		    AND	MontoMaximo	= @MontoMaximo            
							)

   BEGIN
	   DELETE TASAS_MAXIMAS_CONVENCIONAL 
		WHERE	
			codigo_moneda	= @codigo_moneda
		    AND	diasdesde	= @diasdesde		
		    AND	DiasHasta 	= @DiasHasta 		
		    AND	MontoMinimo	= @MontoMinimo            
		    AND	MontoMaximo	= @MontoMaximo            

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

   SET NOCOUNT ON

END
GO
