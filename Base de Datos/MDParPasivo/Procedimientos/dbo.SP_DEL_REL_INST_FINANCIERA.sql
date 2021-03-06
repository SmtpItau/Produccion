USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_REL_INST_FINANCIERA]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_DEL_REL_INST_FINANCIERA](@icodigo_if NUMERIC(5),
                                           @iconsulta  CHAR(1) = "N"      )	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy
	
	
	IF NOT EXISTS(SELECT Clrelacion
		      FROM CLIENTE
		      WHERE Clrelacion = @icodigo_if)
	BEGIN	

         IF @iconsulta = "N" BEGIN	
		
           	   DELETE RELACION_IF WHERE Codigo_Relacion_IF = @icodigo_if

         END

        	   SELECT "SI"
 
	END ELSE BEGIN
		
	           SELECT "NO", "No se puede eliminar código : " +  CONVERT(CHAR(5),@icodigo_if) +  " Datos relacionados"		  	
	
	END



END

GO
