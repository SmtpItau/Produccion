USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_CALIDAD_JURIDICA]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_DEL_CALIDAD_JURIDICA](@icodigo_cal_juridica NUMERIC(5),
					@iconsulta	      CHAR(1) = "N")	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy
	
	
	IF NOT EXISTS(SELECT Clcalidadjuridica
		      FROM CLIENTE
		      WHERE Clcalidadjuridica = @icodigo_cal_juridica)
	BEGIN	
	
         IF @iconsulta = "N" BEGIN	
				
     	   DELETE CALIDAD_JURIDICA WHERE Codigo_Calidad = @icodigo_cal_juridica

	 END

	   SELECT "SI"
 
	END ELSE BEGIN
		
	   SELECT "NO", "No se puede eliminar código :" +  CONVERT(CHAR(5),@icodigo_cal_juridica) +  "Datos relacionados"		  	
	
	END
	   

END

GO
