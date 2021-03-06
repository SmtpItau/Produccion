USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Borrar_MonedaProducto]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[Sp_Borrar_MonedaProducto]( @sistema CHAR(3) ,
					   @codmon  INTEGER ,
                                           @codprod CHAR(5) )
AS
BEGIN
 
     SET NOCOUNT ON
     SET DATEFORMAT dmy

     IF EXISTS (SELECT 1 FROM PRODUCTO_MONEDA WHERE mpsistema  = @sistema 
                                     AND mpproducto = @codprod
                                     AND mpcodigo   = @codmon )
     BEGIN
	
     DELETE FROM PRODUCTO_MONEDA WHERE mpsistema  = @sistema 
                        AND mpproducto = @codprod
                        AND mpcodigo   = @codmon

     IF @@ERROR <> 0  
        SELECT -1, 'ERROR no se puede eliminar esta Relacion Moneda/Producto'

     END  -- IF

END



GO
