USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_TIPO_AMORTIZACION]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_DEL_TIPO_AMORTIZACION](@icodigo_amortizacion NUMERIC(5),
                                          @iconsulta	CHAR(1) = "N")
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy
	
	
	IF NOT EXISTS(SELECT setipamort
		      FROM SERIE
		      WHERE setipamort = @icodigo_amortizacion)
	BEGIN	

           IF @iconsulta = "N" BEGIN	  
 
         	   DELETE TIPO_AMORTIZACION WHERE Codigo_Amortizacion = @icodigo_amortizacion
           END 
        	   SELECT "SI"
 
	END ELSE BEGIN
		
	           SELECT "NO", "No se puede eliminar código :" +  CONVERT(CHAR(5),@icodigo_amortizacion) +  "Datos relacionados"		  	
	
	END
	   

END

GO
