USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_REL_INST_FINANCIERA]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_ACT_REL_INST_FINANCIERA](@icodigo_if NUMERIC(5),		
	 		  	           @idescripcion	       CHAR(40) )	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

        DECLARE @descripcion_antigua CHAR(40)
	
	IF EXISTS(SELECT Codigo_Relacion_IF
		  FROM RELACION_IF
		  WHERE Codigo_Relacion_IF = @icodigo_if)
	
	BEGIN	

                   SELECT @descripcion_antigua = descripcion
		   FROM RELACION_IF
	           WHERE Codigo_Relacion_IF = @icodigo_if

                  IF @descripcion_antigua <> @idescripcion BEGIN	
	
	               UPDATE RELACION_IF
        	       SET descripcion = @idescripcion 
        	       WHERE Codigo_Relacion_IF = @icodigo_if

                       SELECT "MOD" 

                  END ELSE BEGIN
    
	               SELECT "NO"		
    
                  END		  
	END ELSE BEGIN
	  	
	   INSERT INTO RELACION_IF (Codigo_Relacion_IF 
 		  	            ,Descripcion)
		       VALUES	    (@icodigo_if
 				    ,@idescripcion) 	

           SELECT "SI" 	 
	
	END
	   

END

GO
