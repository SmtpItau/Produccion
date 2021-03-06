USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_TIPO_CONTROL]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_ACT_TIPO_CONTROL](@icodigo_control CHAR(5),		
				    @idescripcion    CHAR(40) )	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

        DECLARE @descripcion_antigua CHAR(40)
	
	IF EXISTS(SELECT codigo_control
		  FROM TIPO_CONTROL
		  WHERE Codigo_control = @icodigo_control)
	
	BEGIN	

            SELECT @descripcion_antigua =descripcion
	    FROM TIPO_CONTROL
	    WHERE Codigo_control = @icodigo_control

          IF @descripcion_antigua <> @idescripcion BEGIN		

	    UPDATE TIPO_CONTROL
 	    SET descripcion = @idescripcion 
	    WHERE Codigo_control = @icodigo_control

  	    SELECT "MOD"
	
          END ELSE BEGIN
    
 	    SELECT "NO"		

          END	

	END ELSE BEGIN
	  	
	   INSERT INTO TIPO_CONTROL (Codigo_control
			  	    ,Descripcion)
		       VALUES	    (@icodigo_control
				    ,@idescripcion) 	

            SELECT "SI" 		
	END
	   

END

GO
