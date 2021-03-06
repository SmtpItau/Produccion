USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_TIPO_MERCADO]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_ACT_TIPO_MERCADO](@icodigo_mercado NUMERIC(5),		
			  	    @idescripcion	       CHAR(40) )	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	DECLARE @descripcion_antigua CHAR(40)
	
	IF EXISTS(SELECT codigo_mercado
		  FROM TIPO_MERCADO
		  WHERE codigo_mercado = @icodigo_mercado)
	
	BEGIN	

           SELECT @descripcion_antigua =descripcion
	   FROM TIPO_MERCADO
	   WHERE codigo_mercado = @icodigo_mercado

    	   IF @descripcion_antigua <> @idescripcion BEGIN

       	       UPDATE TIPO_MERCADO
	       SET descripcion = @idescripcion 
               WHERE codigo_mercado = @icodigo_mercado

               SELECT "MOD"
	
          END ELSE BEGIN

               SELECT "NO"		
      	  END		      
	
	END ELSE BEGIN
	  	
	   INSERT INTO TIPO_MERCADO (codigo_mercado
 		  	            ,Descripcion)
		       VALUES	    (@icodigo_mercado
 				    ,@idescripcion) 	
   	   SELECT "SI"	
	END
	   

END

GO
