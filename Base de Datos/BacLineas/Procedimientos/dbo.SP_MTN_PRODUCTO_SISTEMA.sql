USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_MTN_PRODUCTO_SISTEMA]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[SP_MTN_PRODUCTO_SISTEMA]
                  (
                    @iFlag           CHAR(01)
                  , @id_sistema      CHAR(03)
                  , @CodigoProducto  CHAR(05)
                  , @Descripcion     CHAR(50) = ''
                  , @Moneda          INTEGER  = 0
                  , @FormaPago       INTEGER  = 0
                  )
AS
BEGIN

 IF @iFlag = '1' 
  BEGIN
   IF EXISTS(SELECT 1 FROM PRODUCTO_SISTEMA
                     WHERE @id_sistema     = Id_Sistema
                       AND @CodigoProducto = Codigo_Producto)
      BEGIN
         UPDATE PRODUCTO_SISTEMA
            SET ControlMoneda    = @Moneda
            ,   ControlFormaPago = @FormaPago
          WHERE @id_sistema      = Id_Sistema
            AND @CodigoProducto  = Codigo_Producto
      END
   ELSE
      BEGIN
         INSERT INTO PRODUCTO_SISTEMA
               (
                  Id_Sistema
               ,  Codigo_Producto
               ,  Descripcion
               ,  ControlMoneda
               ,  ControlFormaPago
               )
          VALUES
               (
                  @id_sistema
               ,  @CodigoProducto
               ,  @Descripcion
               ,  @Moneda
               ,  @FormaPago
               )
      END
      
      SELECT 0,'La Grabacion fue correcta'
  END

 IF @iFlag = '2' 
  BEGIN

   DELETE PRODUCTO_SISTEMA
    WHERE @id_sistema      = Id_Sistema
      AND @CodigoProducto  = Codigo_Producto

  END

 IF @iFlag = '3'

  BEGIN
      SELECT ControlMoneda
      ,      ControlFormaPago
        FROM PRODUCTO_SISTEMA
       WHERE @id_sistema      = Id_Sistema
         AND @CodigoProducto  = Codigo_Producto
  END

END
GO
