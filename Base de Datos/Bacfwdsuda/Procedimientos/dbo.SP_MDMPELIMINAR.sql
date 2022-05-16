USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDMPELIMINAR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDMPELIMINAR]
       (
        @ncodprod    NUMERIC(5,0)      -- C«digo Producto
       )
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   /*=======================================================================*/
   IF EXISTS(
              SELECT * FROM VIEW_PRODUCTO_MONEDA WHERE mpproducto = @ncodprod
            ) BEGIN
      DELETE FROM VIEW_PRODUCTO_MONEDA WHERE mpproducto = @ncodprod
   END
   /*=======================================================================*/
   /*=======================================================================*/
   
SET NOCOUNT OFF
SELECT 0
END

GO
