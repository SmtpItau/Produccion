USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_TIPO_BASILEA]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_ACT_TIPO_BASILEA](@icodigo_basilea NUMERIC(5),		
				    @idescripcion    CHAR(40) )	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

        DECLARE @descripcion_antigua CHAR(40)
	
	IF EXISTS(SELECT codigo_basilea
		  FROM TIPO_BASILEA
		  WHERE Codigo_basilea = @icodigo_basilea)
	
	BEGIN	
            
           SELECT @descripcion_antigua  = descripcion
		  FROM TIPO_BASILEA
		  WHERE Codigo_basilea = @icodigo_basilea  

           IF @descripcion_antigua <> @idescripcion BEGIN	

        	   UPDATE TIPO_BASILEA
	           SET descripcion = @idescripcion 
        	   WHERE Codigo_basilea = @icodigo_basilea

            	   SELECT "MOD"
	
            END ELSE BEGIN
    
		   SELECT "NO"		

            END	

	END ELSE BEGIN
	  	
	   INSERT INTO TIPO_BASILEA (Codigo_basilea
			  	          ,Descripcion)
		       VALUES		 (@icodigo_Basilea
					  ,@idescripcion) 	
           SELECT "SI" 
	
	END
	   

END

GO
