USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MXUTRADING]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MXUTRADING](
                               @total_compra   NUMERIC(19,4)  ,
                  @precio_medio_compra NUMERIC(19,4)  ,
          @total_venta  NUMERIC(19,4)  ,
          @precio_medio_venta NUMERIC(19,4)   ,
                               @resultado_trading NUMERIC(19,4) OUTPUT
               )
AS
BEGIN
SET NOCOUNT ON
   IF @total_compra > @total_venta
      SELECT @resultado_trading = ( @precio_medio_venta - @precio_medio_compra ) * @total_venta
   ELSE
      SELECT @resultado_trading = ( @precio_medio_venta - @precio_medio_compra ) * @total_compra
SET NOCOUNT OFF  
End

GO
