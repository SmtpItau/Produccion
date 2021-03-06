USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_TIPO_CONTROL]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_DEL_TIPO_CONTROL](@icodigo_control CHAR(5),
                                    @iconsulta	CHAR(1) = "N")	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy
	
	
	IF NOT EXISTS(SELECT codigo_control
		      FROM PRODUCTO_CONTROL
		      WHERE codigo_control = @icodigo_control)
	BEGIN	

           IF @iconsulta = "N" BEGIN		

                DELETE TIPO_CONTROL WHERE Codigo_control = @icodigo_control
	   END
		    
	   SELECT "SI"

	END ELSE BEGIN
		
	   SELECT "NO", "No se puede eliminar código : " +  @icodigo_control +  " Datos relacionados"		  	
	
	END
	   


END

GO
