USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_TIPO_OPERACION_SPOT]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DEL_TIPO_OPERACION_SPOT]
                      (
                          @Codigo NUMERIC(5)
                      )	
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

	
	
	IF EXISTS(SELECT 1
		  FROM   PRODUCTO_DESCALCE
		  WHERE  Codigo = @Codigo Or  @Codigo = -1 )
	BEGIN	
		
       	   DELETE PRODUCTO_DESCALCE
           WHERE  Codigo = @Codigo

           If @@Error <> 0 
           Begin
   	      SELECT 'NO', 'No se puede eliminar código : ' +  CONVERT(CHAR(5),@Codigo) +  ' Datos relacionados'		  	
           End
           Else
           Begin
	      SELECT 'SI'  
           End

	END
        ELSE
        BEGIN
		
	      SELECT 'XX'  
	
	END

END


GO
