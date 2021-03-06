USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_MERCADOCAMBIARIO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_MERCADOCAMBIARIO]
   (   @iAccion      INTEGER
   ,   @FechaDesde   DATETIME
   ,   @FechaHasta   DATETIME
   ,   @Estado       CHAR(1)       = ''
   ,   @Numero       NUMERIC(10)   = 0
   ,   @iMercado     INTEGER       = 0
   ,   @iMontoIBS    NUMERIC(21,4) = 0.0
   ,   @iNumIBS      INTEGER       = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iAccion = 1
   BEGIN
      SELECT Estado      = CASE WHEN Estado        = 'P' THEN 'PENDIENTE' 
                                ELSE                          'CONFIRMADA' 
                           END
      ,      NumOper     = OperacionBac
      ,      TipOper     = CASE WHEN TipoOperacion = 'C' THEN 'COMPRA'
                                ELSE                          'VENTA'
                           END
      ,      Mercado     = CASE WHEN MercadoCambiario = 0 THEN ''
                                WHEN MercadoCambiario = 1 THEN 'OF. CAMBIO'
                                WHEN MercadoCambiario = 2 THEN 'COMEX'
                           END
      ,      Moneda      = Moneda
      ,      Monto       = MontoMx
      ,      Conversion  = MontoMonedaCnv
      ,      TCambio     = TipoCambio
      ,      Paridad     = Paridad
      ,      Operador    = Usuario
      ,      FechaIng    = Fecha
      ,      Confirma    = FechaConfirmacion
      ,      MerOper     = MercadoOperacion
      FROM   dbo.MERCADO_CAMBIARIO
      WHERE  Fecha       BETWEEN @FechaDesde AND @FechaHasta
      AND    Estado      = @Estado OR @Estado = ''
      ORDER BY Estado, MercadoOperacion, OperacionBac
   END

   IF @iAccion = 2
   BEGIN
      UPDATE MERCADO_CAMBIARIO 
      SET    FechaConfirmacion = @FechaDesde
      ,      Estado            = 'C'
      ,      OperacionIBS      = @iNumIBS
      ,      MontoMxLiquidado  = @iMontoIBS
      WHERE  OperacionBac      = @Numero
   END

   IF @iAccion = 3
   BEGIN
      UPDATE MERCADO_CAMBIARIO
      SET    MercadoCambiario  = @iMercado
      WHERE  OperacionBac      = @Numero
   END

END
GO
