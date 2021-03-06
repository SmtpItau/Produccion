USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_VAR_MONEDA]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_DEL_VAR_MONEDA](@icodigo_var_mon CHAR(3),
                                  @iconsulta	      CHAR(1) = "N" )	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy
	
	
	IF NOT EXISTS(SELECT Codigo_Variabilidad
		      FROM MONEDA
		      WHERE Codigo_Variabilidad = @icodigo_var_mon)
	BEGIN	

         IF @iconsulta = "N" BEGIN	
		
     	   DELETE MONEDA_VARIABILIDAD WHERE Codigo_Variabilidad = @icodigo_var_mon

         END
	   SELECT "SI"
 
	END ELSE BEGIN
		
	   SELECT "NO", "No se puede eliminar código : " +  CONVERT(CHAR(5),@icodigo_var_mon) +  " Datos relacionados"		  	
	
	END



END

GO
