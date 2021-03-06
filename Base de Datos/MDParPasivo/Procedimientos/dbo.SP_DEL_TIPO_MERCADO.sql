USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_TIPO_MERCADO]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_DEL_TIPO_MERCADO](@icodigo_mercado NUMERIC(5),
                                    @iconsulta	      CHAR(1) = "N")	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy
	
	
	IF NOT EXISTS(SELECT Clmercado
		      FROM CLIENTE
		      WHERE Clmercado = @icodigo_mercado)
	BEGIN	
		
         IF @iconsulta = "N" BEGIN	

     	   DELETE TIPO_MERCADO WHERE Codigo_mercado = @icodigo_mercado

         END
	   SELECT "SI"
 
	END ELSE BEGIN
		
	   SELECT "NO", "No se puede eliminar código : " +  CONVERT(CHAR(5),@icodigo_mercado) +  " Datos relacionados"		  	
	
	END
	   

END

GO
