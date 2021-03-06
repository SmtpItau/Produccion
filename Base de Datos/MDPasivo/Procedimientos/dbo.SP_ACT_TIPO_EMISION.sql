USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_TIPO_EMISION]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROC [dbo].[SP_ACT_TIPO_EMISION]	(@icodigo_emision      NUMERIC(3),		
					 @idescripcion	       CHAR(3) )	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

        DECLARE @descripcion_antigua CHAR(40)

	IF EXISTS(SELECT Codigo_Tipo_Emision
		  FROM TIPO_EMISION
		  WHERE Codigo_Tipo_Emision = @icodigo_emision )
	
	BEGIN	

            SELECT @descripcion_antigua =Nemotecnico
	    FROM TIPO_EMISION
   	    WHERE Codigo_Tipo_Emision = @icodigo_emision

	   IF @descripcion_antigua <> @idescripcion BEGIN	

    	       UPDATE TIPO_EMISION
               SET Nemotecnico = @idescripcion 
  	       WHERE Codigo_Tipo_Emision = @icodigo_emision

               SELECT "MOD"
	
           END ELSE BEGIN
    
		   SELECT "NO"		

           END		
	
	END ELSE BEGIN
	  	
	   INSERT INTO TIPO_EMISION 	 ( Codigo_Tipo_Emision
			  	          ,Nemotecnico)

		       VALUES		 ( @icodigo_emision
					  ,@idescripcion) 	
           SELECT "SI" 		
	END
	   

END

GO
