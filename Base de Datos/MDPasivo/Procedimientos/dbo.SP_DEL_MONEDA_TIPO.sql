USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_MONEDA_TIPO]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_DEL_MONEDA_TIPO](@icodigo_tipo_moneda NUMERIC(1),
                                   @iconsulta	      CHAR(1) = "N" )	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy
	
	
	IF NOT EXISTS(SELECT mntipmon
		      FROM MONEDA
		      WHERE mntipmon = @icodigo_tipo_moneda)
	BEGIN	

          IF @iconsulta = "N" BEGIN	
		
         	   DELETE MONEDA_TIPO WHERE Codigo_Tipo_Moneda = @icodigo_tipo_moneda
          END

        	   SELECT "SI"
 
	END ELSE BEGIN
		
	   SELECT "NO", "No se puede eliminar código : " +  CONVERT(CHAR(5),@icodigo_tipo_moneda) +  " Datos relacionados"		  	
	
	END



END

GO
