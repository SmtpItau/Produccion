USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_TIPO_FECHA]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROC [dbo].[SP_ACT_TIPO_FECHA]	(@icodigo_fecha      NUMERIC(1),		
					 @idescripcion	       CHAR(30))	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	DECLARE @descripcion_antigua CHAR(30)

	IF EXISTS(SELECT Codigo_Tipo_Fecha
		  FROM TIPO_FECHA
		  WHERE Codigo_Tipo_Fecha = @icodigo_fecha)
	
	BEGIN	

           SELECT @descripcion_antigua = descripcion
 	   FROM TIPO_FECHA
	   WHERE Codigo_Tipo_Fecha = @icodigo_fecha
	
          IF @descripcion_antigua <> @idescripcion BEGIN

	       UPDATE TIPO_FECHA
    	       SET descripcion = @idescripcion 
               WHERE Codigo_Tipo_Fecha = @icodigo_fecha

    	       SELECT "MOD"
	
          END ELSE BEGIN

  	       SELECT "NO"		

      	  END		      
	
	END ELSE BEGIN
	  	
	   INSERT INTO TIPO_FECHA 	 ( Codigo_Tipo_Fecha
			  	          ,Descripcion)

		       VALUES		 ( @icodigo_fecha
					  ,@idescripcion) 	
           SELECT "SI"	 	
	END
	   

END

GO
