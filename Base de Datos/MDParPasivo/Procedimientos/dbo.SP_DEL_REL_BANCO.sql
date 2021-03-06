USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_REL_BANCO]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_DEL_REL_BANCO](@icodigo_Banco NUMERIC(2),
                                 @iconsulta	CHAR(1) = "N")	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy
	
	
	IF NOT EXISTS(SELECT Relbco
		      FROM CLIENTE
		      WHERE Relbco = @icodigo_Banco)
	BEGIN	
		
           IF @iconsulta = "N" BEGIN	  

         	   DELETE RELACION_BANCO WHERE Codigo_Relacion_banco = @icodigo_banco
           END
 
        	   SELECT "SI"
 
	END ELSE BEGIN
		
        	   SELECT "NO", "No se puede eliminar código : " +  CONVERT(CHAR(5),@icodigo_banco) +  " Datos relacionados"		  	
	
	END



END

GO
