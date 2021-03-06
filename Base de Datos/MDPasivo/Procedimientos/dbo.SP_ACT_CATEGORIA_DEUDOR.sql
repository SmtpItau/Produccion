USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_CATEGORIA_DEUDOR]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_ACT_CATEGORIA_DEUDOR](@icodigo_cat_deudor NUMERIC(2),		
					@idescripcion    CHAR(40) )	
AS
BEGIN



	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	DECLARE @descripcion_antigua CHAR(40)
	
	IF EXISTS(SELECT Codigo_Deudor
		  FROM CATEGORIA_DEUDOR
		  WHERE Codigo_deudor = @icodigo_cat_deudor)
	
	BEGIN	
    
            SELECT @descripcion_antigua = descripcion
	    FROM CATEGORIA_DEUDOR
	    WHERE Codigo_deudor = @icodigo_cat_deudor    


          IF @descripcion_antigua <> @idescripcion BEGIN		  

	       UPDATE CATEGORIA_DEUDOR
               SET descripcion = @idescripcion 
               WHERE Codigo_Deudor= @icodigo_cat_deudor

               SELECT "MOD"

          END ELSE BEGIN

               SELECT "NO"		

      	  END		
	
	END ELSE BEGIN
	  	
	   INSERT INTO CATEGORIA_DEUDOR(Codigo_Deudor
			  	    ,Descripcion)
		       VALUES	    (@icodigo_cat_deudor
				    ,@idescripcion) 	
        
            SELECT "SI"	
 	
	END
	   

END

GO
