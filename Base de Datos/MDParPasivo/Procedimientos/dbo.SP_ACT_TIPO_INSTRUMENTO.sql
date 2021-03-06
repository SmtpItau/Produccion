USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_TIPO_INSTRUMENTO]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROC [dbo].[SP_ACT_TIPO_INSTRUMENTO]	(@icodigo_tipo_instrumento      NUMERIC(3),		
					 @idescripcion	       CHAR(3) )	
AS
BEGIN


	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	DECLARE @descripcion_antigua CHAR(3)

	IF EXISTS(SELECT Codigo_Tipo_instrumento
		  FROM TIPO_INSTRUMENTO
		  WHERE Codigo_Tipo_instrumento = @icodigo_tipo_instrumento )
	
	BEGIN	

           SELECT @descripcion_antigua =Nemotecnico
  	   FROM TIPO_INSTRUMENTO
	   WHERE Codigo_Tipo_instrumento = @icodigo_tipo_instrumento

  	   IF @descripcion_antigua <> @idescripcion BEGIN

        	   UPDATE TIPO_INSTRUMENTO
	           SET Nemotecnico = @idescripcion 
            	   WHERE Codigo_Tipo_instrumento = @icodigo_tipo_instrumento

                   SELECT "MOD"
	
          END ELSE BEGIN

		   SELECT "NO"		

      	  END		          
	
	END ELSE BEGIN
	  	
	   INSERT INTO TIPO_INSTRUMENTO	 ( codigo_tipo_instrumento
			  	          ,Nemotecnico)

		       VALUES		 ( @icodigo_tipo_instrumento
					  ,@idescripcion) 	
        	   	           	   	   
   	   SELECT "SI"	
	END
	   

END

GO
