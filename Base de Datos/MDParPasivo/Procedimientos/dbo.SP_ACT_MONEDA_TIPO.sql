USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_MONEDA_TIPO]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_ACT_MONEDA_TIPO](@icodigo_tipo_moneda NUMERIC(1),		
			  	    @idescripcion       CHAR(30) )	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

        DECLARE @descripcion_antigua CHAR(30)
	
	IF EXISTS(SELECT Codigo_Tipo_Moneda
		  FROM MONEDA_TIPO
		  WHERE Codigo_Tipo_Moneda = @icodigo_tipo_moneda)
	
	BEGIN	

              SELECT  @descripcion_antigua= descripcion
	      FROM MONEDA_TIPO
              WHERE Codigo_Tipo_Moneda = @icodigo_tipo_moneda
    
             IF @descripcion_antigua <> @idescripcion BEGIN	

		   UPDATE MONEDA_TIPO
	           SET descripcion = @idescripcion 
        	   WHERE Codigo_Tipo_Moneda = @icodigo_tipo_moneda

                   SELECT "MOD"
	
              END ELSE BEGIN
    
		   SELECT "NO"		

              END		        
	
	END ELSE BEGIN
	  	
	   INSERT INTO MONEDA_TIPO (Codigo_Tipo_Moneda 
 		  	            ,Descripcion)
		       VALUES	    (@icodigo_tipo_moneda
 				    ,@idescripcion) 	
            
           SELECT "SI" 	
	END
	   

END

GO
