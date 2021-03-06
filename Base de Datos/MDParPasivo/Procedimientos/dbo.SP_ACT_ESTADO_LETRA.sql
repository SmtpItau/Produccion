USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_ESTADO_LETRA]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_ACT_ESTADO_LETRA](@icodigo_letra   CHAR(1),		
				    @idescripcion    CHAR(40) )	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	DECLARE @descripcion_antigua CHAR(40)

	IF EXISTS(SELECT codigo_letra
		  FROM ESTADO_LETRA_HIPOTECARIA
		  WHERE Codigo_letra = @icodigo_letra)
	
	BEGIN	

            SELECT @descripcion_antigua = descripcion
            FROM ESTADO_LETRA_HIPOTECARIA
	    WHERE Codigo_letra = @icodigo_letra
	
          IF @descripcion_antigua <> @idescripcion BEGIN	
                
        	   UPDATE ESTADO_LETRA_HIPOTECARIA
	           SET descripcion = @idescripcion 
            	   WHERE Codigo_letra = @icodigo_letra

	           SELECT "MOD"
	
          END ELSE BEGIN

		   SELECT "NO"		

      	  END	
	END ELSE BEGIN
	  	
	   INSERT INTO ESTADO_LETRA_HIPOTECARIA (Codigo_letra
	  	  			  	    ,Descripcion)
			       VALUES	        (@icodigo_letra
					        ,@idescripcion) 	
           SELECT "SI"		
	END
	   

END

GO
