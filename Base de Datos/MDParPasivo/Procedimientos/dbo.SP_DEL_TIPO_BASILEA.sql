USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_TIPO_BASILEA]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_DEL_TIPO_BASILEA](@icodigo_basilea NUMERIC(5),
                                     @iconsulta	CHAR(1) = "N")	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy
	
	
	IF NOT EXISTS(SELECT *
		      FROM PORCENTAJE_COMPUTABLE
		      WHERE codigo_canasta = @icodigo_basilea)
	BEGIN	

           IF @iconsulta = "N" BEGIN	 		

        	   DELETE TIPO_BASILEA WHERE Codigo_basilea = @icodigo_basilea
           END 

	   SELECT "SI"
 
	END ELSE BEGIN
		
	   SELECT "NO", "No se puede eliminar código :" +  CONVERT(CHAR(5),@icodigo_basilea) +  "Datos relacionados"		  	
	
	END
	   

END

GO
