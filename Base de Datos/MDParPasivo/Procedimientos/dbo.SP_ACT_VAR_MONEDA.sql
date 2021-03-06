USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_VAR_MONEDA]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_ACT_VAR_MONEDA](@icodigo_Var_mon CHAR(3),		
	   		          @idescripcion    CHAR(50) )	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	DECLARE @descripcion_antigua CHAR(50)
	
	IF EXISTS(SELECT Codigo_Variabilidad
		  FROM MONEDA_VARIABILIDAD
		  WHERE Codigo_Variabilidad = @icodigo_var_mon)
	
	BEGIN	

           SELECT @descripcion_antigua = descripcion
  	   FROM MONEDA_VARIABILIDAD
	   WHERE Codigo_Variabilidad = @icodigo_var_mon

           IF @descripcion_antigua <> @idescripcion BEGIN
	
	       UPDATE MONEDA_VARIABILIDAD
               SET descripcion = @idescripcion 
	       WHERE Codigo_Variabilidad = @icodigo_var_mon

               SELECT "MOD"
	
          END ELSE BEGIN

               SELECT "NO"		

      	  END		      
	
	END ELSE BEGIN
	  	
	   INSERT INTO MONEDA_VARIABILIDAD (Codigo_Variabilidad 
			  	    ,Descripcion)
		       VALUES	    (@icodigo_var_mon
				    ,@idescripcion) 	
   	   SELECT "SI"		
	END
	   

END

GO
