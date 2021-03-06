USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_TIPO_CLIENTE]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_DEL_TIPO_CLIENTE](@icodigo_tipo_cliente NUMERIC(5),
                                    @iconsulta	CHAR(1) = "N")	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy	
	
	IF NOT EXISTS(SELECT cltipcli
		      FROM CLIENTE
		      WHERE cltipcli = @icodigo_tipo_cliente)
	BEGIN	

  	 IF @iconsulta = "N" BEGIN		

     	   DELETE TIPO_CLIENTE WHERE Codigo_tipo_cliente = @icodigo_tipo_cliente

         END

	   SELECT "SI"
 
	END ELSE BEGIN
		
	   SELECT "NO", "No se puede eliminar código :" +  CONVERT(CHAR(5),@icodigo_tipo_cliente) +  "Datos relacionados"		  	
	
	END
	   

END

GO
