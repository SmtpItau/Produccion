USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_TIPO_FECHA]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_DEL_TIPO_FECHA] (@icodigo_fecha NUMERIC(1),
                                   @iconsulta	      CHAR(1) = "N" )	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy
	
	
	IF NOT EXISTS(SELECT intipfec
		      FROM INSTRUMENTO
		      WHERE intipfec = @icodigo_fecha)
	BEGIN	

         IF @iconsulta = "N" BEGIN	

     	   DELETE TIPO_FECHA WHERE Codigo_tipo_fecha = @icodigo_fecha
			       
         END
	   SELECT "SI"
 
	END ELSE BEGIN
		
	   SELECT "NO", "No se puede eliminar código : " +  CONVERT(CHAR(1),@icodigo_fecha) +  " Datos relacionados"		  	
	
	END
	   

END

GO
