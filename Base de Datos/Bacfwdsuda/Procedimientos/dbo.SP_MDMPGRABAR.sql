USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDMPGRABAR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDMPGRABAR]
       (
        @ncodprod    NUMERIC(5,0)    , -- C«digo Producto
        @ncodigo     NUMERIC(5,0)    , -- C«digo Moneda
        @cestado     CHAR(01)          -- Estado de la moneda
       )
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   /*=======================================================================*/
   IF EXISTS(
              SELECT       mpestado
                     FROM  VIEW_PRODUCTO_MONEDA
                     WHERE mpproducto = @ncodprod AND 
                           mpcodigo   = @ncodigo
            ) BEGIN
      UPDATE       VIEW_PRODUCTO_MONEDA
             SET   mpestado   = @cestado
             WHERE mpproducto = @ncodprod AND 
                   mpcodigo   = @ncodigo
   END ELSE BEGIN
      INSERT INTO VIEW_PRODUCTO_MONEDA (
                        mpproducto,
                        mpcodigo,
                        mpestado
                       )
             VALUES    (
                        @ncodprod,
                        @ncodigo,
                        @cestado
                       )
   END
   /*=======================================================================*/
   /*=======================================================================*/
   
SET NOCOUNT OFF
SELECT 0
END

GO
