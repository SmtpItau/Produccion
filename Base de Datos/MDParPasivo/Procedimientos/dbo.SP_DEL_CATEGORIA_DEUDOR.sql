USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_CATEGORIA_DEUDOR]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_DEL_CATEGORIA_DEUDOR](@icodigo_cat_deudor NUMERIC(2),
                                        @iconsulta	      CHAR(1) = "N")	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy
	
	
	IF NOT EXISTS(SELECT Clcatego
		      FROM CLIENTE
		      WHERE Clcatego = @icodigo_cat_deudor)
	BEGIN	

           IF @iconsulta = "N" BEGIN		

     	     DELETE CATEGORIA_DEUDOR WHERE Codigo_deudor = @icodigo_cat_deudor

           END

	   SELECT "SI"
 
	END ELSE BEGIN
		
	   SELECT "NO", "No se puede eliminar código :" +  CONVERT(CHAR(5),@icodigo_cat_deudor) +  "Datos relacionados"		  	
	
	END
	   

END

GO
