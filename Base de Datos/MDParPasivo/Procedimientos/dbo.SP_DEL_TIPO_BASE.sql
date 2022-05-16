USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_TIPO_BASE]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_DEL_TIPO_BASE](@icodigo_base NUMERIC(5)
				 ,@isistema    CHAR(3)
                                 ,@iconsulta	CHAR(1) = "N")	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy
	
	
-- 	 IF NOT EXISTS(SELECT COMPRA_BASE,VENTA_BASE 
-- 		      FROM VIEW_MOVIMIENTO_SWAP,TIPO_BASE
-- 		      WHERE COMPRA_BASE = base 
-- 		      AND   codigo_base = @icodigo_base
-- 		      AND   id_sistema = @isistema	
--                       AND   @isistema = "SWP")
-- 
-- 	  AND NOT EXISTS(SELECT COMPRA_BASE,VENTA_BASE 
-- 		      FROM VIEW_MOVIMIENTO_SWAP,TIPO_BASE
-- 		      WHERE VENTA_BASE = base 
-- 		      AND   codigo_base = @icodigo_base
-- 		      AND   id_sistema = @isistema
--                       AND   @isistema = "SWP" )
-- 
-- 	  AND NOT EXISTS(SELECT base_tasa
-- 		      FROM VIEW_MOVIMIENTO_INVERSION_EXTERIOR,TIPO_BASE
-- 		      WHERE BASE_TASA = rtrim(descripcion) + " - " + ltrim(codigo_base)
-- 		      AND   codigo_base =  @icodigo_base
-- 		      AND   id_sistema = @isistema
--                       AND   @isistema = "INV")
-- 
-- 	BEGIN	
-- 
--            IF @iconsulta = "N" BEGIN	

         	   DELETE TIPO_BASE WHERE Codigo_base = @icodigo_base
	        		    AND   id_sistema  = @isistema	
--           END 

           SELECT "SI"
 
-- 	END ELSE BEGIN
-- 		
-- 	   SELECT "NO", "No se puede eliminar código :" +  CONVERT(CHAR(5),@icodigo_base) +  "Datos relacionados"		  	
-- 	
-- 	END
	   


END
GO
