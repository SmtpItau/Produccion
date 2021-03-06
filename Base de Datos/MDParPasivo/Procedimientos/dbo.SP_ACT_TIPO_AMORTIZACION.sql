USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_TIPO_AMORTIZACION]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_ACT_TIPO_AMORTIZACION](@icodigo_amortizacion NUMERIC(5),		
					 @idescripcion	       CHAR(40) )	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

        DECLARE @descripcion_antigua CHAR(40)
	
	IF EXISTS(SELECT codigo_amortizacion 
		  FROM TIPO_AMORTIZACION 
		  WHERE Codigo_Amortizacion = @icodigo_amortizacion)
	
	BEGIN	
           
           SELECT @descripcion_antigua = descripcion
  	   FROM TIPO_AMORTIZACION 
	   WHERE Codigo_Amortizacion = @icodigo_amortizacion  

           IF @descripcion_antigua <> @idescripcion BEGIN
	
    	           UPDATE TIPO_AMORTIZACION 
        	   SET descripcion = @idescripcion 
        	   WHERE Codigo_Amortizacion = @icodigo_amortizacion

                   SELECT "MOD" 

            END ELSE BEGIN
    
	           SELECT "NO"		
    
            END		  
	END ELSE BEGIN
	  	
	   INSERT INTO TIPO_AMORTIZACION (Codigo_Amortizacion 
			  	          ,Descripcion)
		       VALUES		 (@icodigo_amortizacion
					  ,@idescripcion) 	

            SELECT "SI" 	 	
	END
	   

END

GO
