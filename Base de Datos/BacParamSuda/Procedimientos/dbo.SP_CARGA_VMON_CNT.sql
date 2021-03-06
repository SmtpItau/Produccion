USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_VMON_CNT]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CARGA_VMON_CNT]
   (   @Accion     INTEGER
   ,   @Fecha      DATETIME
   ,   @Moneda     INTEGER   = 0
   ,   @Valor      FLOAT     = 0.0
   ,   @Compra     FLOAT     = 0.0
   ,   @Venta      FLOAT     = 0.0
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @NemoMoneda      VARCHAR(3)
   DECLARE @CodigoContable  INTEGER
   DECLARE @iFound          INTEGER

   DECLARE @Variacion       INTEGER
   SET     @Variacion       = 20.0

   IF @Accion = 0
   BEGIN
      DELETE FROM BacParamSuda..VALOR_MONEDA_CONTABLE
            WHERE Fecha = @Fecha
   END
 
   IF @Accion = 1
   BEGIN  
      SET    @iFound         = -1
      SELECT @iFound         = 0
      ,      @NemoMoneda     = mnnemo
      ,      @CodigoContable = mncodfox
      FROM   BacParamSuda..MONEDA 
      WHERE  mncodmon        = @Moneda
      
      IF @iFound = 0
      BEGIN
         INSERT INTO BacParamSuda..VALOR_MONEDA_CONTABLE
         SELECT @Fecha, @Moneda, @NemoMoneda, @CodigoContable, @Valor, @Variacion, @Compra, @Venta
      END
   END

END




GO
