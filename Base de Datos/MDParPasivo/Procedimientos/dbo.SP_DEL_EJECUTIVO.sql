USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_EJECUTIVO]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_DEL_EJECUTIVO](@iRut_ejecutivo NUMERIC(10)
				 ,@iCodigo_ejecutivo   NUMERIC(10)
                                 ,@iconsulta	CHAR(1) = "N")	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy
	
	
        /*IF NOT EXISTS("VALIDACION ")

	BEGIN	

           IF @iconsulta = "N" BEGIN	
*/
         	   DELETE EJECUTIVO --WHERE Rut_ejecutivo = @iRut_ejecutivo
	        		    --AND   Codigo_ejecutivo = @iCodigo_Ejecutivo
/*           END 

           SELECT "SI"
 
	END ELSE BEGIN
		
	   SELECT "NO", "No se puede eliminar código :" +  CONVERT(CHAR(5),@iRut_Ejecutivo) +  "Datos relacionados"		  	
	
	END
*/	   


END

GO
