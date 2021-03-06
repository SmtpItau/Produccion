USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_TIPO_EMISION]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_DEL_TIPO_EMISION](@icodigo_emision NUMERIC(3),
                                    @iconsulta	CHAR(1) = "N" )	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy
	
	
	IF NOT EXISTS(SELECT inemision
		      FROM INSTRUMENTO
		      WHERE inemision = @icodigo_emision)
	BEGIN	

         IF @iconsulta = "N" BEGIN		

         	   DELETE TIPO_EMISION WHERE Codigo_tipo_emision = @icodigo_Emision
         END

	   SELECT "SI"
 
	END ELSE BEGIN
		
	   SELECT "NO", "No se puede eliminar código :" +  CONVERT(CHAR(3),@icodigo_emision) +  "Datos relacionados"		  	
	
	END
	   

END

GO
