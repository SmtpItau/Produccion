USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_TIPO_INSTRUMENTO]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_DEL_TIPO_INSTRUMENTO](@icodigo_tipo_instrumento NUMERIC(3),
                                        @iconsulta	      CHAR(1) = "N")	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy
	
	
	IF NOT EXISTS(SELECT intipo
		      FROM INSTRUMENTO
		      WHERE intipo = @icodigo_tipo_instrumento)
	BEGIN	

         IF @iconsulta = "N" BEGIN	

     	   DELETE TIPO_INSTRUMENTO WHERE Codigo_tipo_instrumento = @icodigo_tipo_instrumento

         END

	   SELECT "SI"
 
	END ELSE BEGIN
		
	   SELECT "NO", "No se puede eliminar código :" +  CONVERT(CHAR(3),@icodigo_tipo_instrumento) +  "Datos relacionados"		  	
	
	END
	   

END

GO
