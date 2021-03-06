USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_MONEDAPRODUCTO]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_BORRAR_MONEDAPRODUCTO    fecha de la secuencia de comandos: 03/04/2001 15:17:58 ******/
CREATE PROCEDURE [dbo].[SP_BORRAR_MONEDAPRODUCTO]( @sistema CHAR(3) ,
        @codmon  INTEGER ,
                                           @codprod CHAR(5) )
AS
BEGIN
 
     SET NOCOUNT ON
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
