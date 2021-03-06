USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_ESTADO_LETRA]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_DEL_ESTADO_LETRA](@icodigo_letra CHAR(1)
                                    ,@iconsulta	CHAR(1) = "N")	
AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON
	
	
	
	IF NOT EXISTS(SELECT letra_condicion
		      FROM LETRA_HIPOTECARIA
		      WHERE letra_condicion = @icodigo_letra)
	BEGIN	

           IF @iconsulta = 'N' BEGIN	
    
         	   DELETE ESTADO_LETRA_HIPOTECARIA WHERE Codigo_letra = @icodigo_letra
	   END
 		    
	   SELECT 'SI'

	END ELSE BEGIN
		
	   SELECT 'NO', 'No se puede eliminar código : ' +  @icodigo_letra +  'Datos relacionados'		  	
	
	END
	   


END
GO
