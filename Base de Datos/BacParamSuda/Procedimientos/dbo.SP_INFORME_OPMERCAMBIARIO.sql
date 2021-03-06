USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_OPMERCAMBIARIO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFORME_OPMERCAMBIARIO]
   (   @dFechaDesde     DATETIME
   ,   @dFechaHasta     DATETIME
   ,   @Estado          CHAR(1)
   ,   @Usuario         VARCHAR(15)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso     DATETIME
   SET     @dFechaProceso     = (SELECT acfecproc FROM BacTraderSuda..MDAC)

   SELECT /*01*/ Fecha               = CONVERT(CHAR(10),MC.Fecha,103)
   ,      /*02*/ OperacionBac        = MC.OperacionBac
   ,      /*03*/ TipoOperacion       = CASE WHEN MC.TipoOperacion = 'C' THEN 'COMPRA' ELSE 'VENTA' END
   ,      /*04*/ RutCliente          = MC.RutCliente
   ,      /*05*/ CodCliente          = MC.CodCliente
   ,      /*06*/ NomCliente          = CL.clnombre
   ,      /*07*/ Moneda              = MC.Moneda
   ,      /*08*/ MontoMx             = MC.MontoMx
   ,      /*09*/ MonedaCnv           = MC.MonedaCnv
   ,      /*10*/ MontoMonedaCnv      = MC.MontoMonedaCnv
   ,      /*11*/ TipoCambio          = MC.TipoCambio
   ,      /*12*/ Paridad             = MC.Paridad
   ,      /*13*/ MercadoCambiario    = CASE WHEN MC.MercadoCambiario = 0 THEN '--'
                                            WHEN MC.MercadoCambiario = 1 THEN 'OF. CAMBIO'
                                            WHEN MC.MercadoCambiario = 2 THEN 'COMEX'
                                       END
   ,      /*14*/ FormaPago           = FP.codigo
   ,      /*15*/ GlosaPago           = FP.glosa
   ,      /*16*/ Estado              = CASE WHEN MC.Estado = ''  THEN '--'
                                            WHEN MC.Estado = 'C' THEN 'CONFIRMADAS'
                                            WHEN MC.Estado = 'P' THEN 'PENDIENTES'
                                       END
   ,      /*17*/ Usuario             = MC.Usuario
   ,      /*18*/ FechaConfirmacion   = CONVERT(CHAR(10),MC.FechaConfirmacion,103)
   ,      /*19*/ OperacionIBS        = MC.OperacionIBS
   ,      /*20*/ MontoMxLiquidado    = MC.MontoMxLiquidado
   ,      /*21*/ MontoLiquidadoEqu   = MC.MontoLiquidadoEqu
   ,      /*22*/ FechaProceso        = CONVERT(CHAR(10),@dFechaProceso,103)
   ,      /*23*/ FechaEmision        = CONVERT(CHAR(10),GETDATE(),103)
   ,      /*24*/ HoraEmision         = CONVERT(CHAR(10),GETDATE(),108)
   ,      /*25*/ Operador            = @Usuario
   ,      /*26*/ Desde               = CONVERT(CHAR(10),@dFechaDesde,103)
   ,      /*27*/ Hasta               = CONVERT(CHAR(10),@dFechaHasta,103)
   INTO   #OP_CONSULTA_INF
   FROM   MERCADO_CAMBIARIO MC
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO FP  ON FP.codigo = FormaPago
          LEFT JOIN BacParamSuda..CLIENTE       CL  ON CL.clrut  = RutCliente AND CL.clcodigo = CodCliente
   WHERE  MC.Fecha                   BETWEEN @dFechaDesde AND @dFechaHasta
   AND    MC.Estado                  = CASE WHEN @Estado = '' THEN Estado ELSE @Estado END


   IF EXISTS(SELECT DISTINCT 1 FROM #OP_CONSULTA_INF)
   BEGIN
      SELECT Fecha
      ,      OperacionBac
      ,      TipoOperacion
      ,      RutCliente
      ,      CodCliente
      ,      NomCliente
      ,      Moneda
      ,      MontoMx
      ,      MonedaCnv
      ,      MontoMonedaCnv
      ,      TipoCambio
      ,      Paridad
      ,      MercadoCambiario
      ,      FormaPago
      ,      GlosaPago
      ,      Estado
      ,      Usuario
      ,      FechaConfirmacion
      ,      OperacionIBS
      ,      MontoMxLiquidado
      ,      MontoLiquidadoEqu
      ,      FechaProceso
      ,      FechaEmision
      ,      HoraEmision
      ,      Operador
      ,      Desde
      ,      Hasta
      FROM  #OP_CONSULTA_INF
      ORDER BY Fecha, OperacionBac

   END ELSE
   BEGIN

      SELECT Fecha               = ''
      ,      OperacionBac        = 0
      ,      TipoOperacion       = ''
      ,      RutCliente          = 0
      ,      CodCliente          = 0
      ,      NomCliente          = ''
      ,      Moneda              = ''
      ,      MontoMx             = 0.0
      ,      MonedaCnv           = ''
      ,      MontoMonedaCnv      = 0.0
      ,      TipoCambio          = 0.0
      ,      Paridad             = 0.0
      ,      MercadoCambiario    = ''
      ,      FormaPago           = 0
      ,      GlosaPago           = ''
      ,      Estado              = ''
      ,      Usuario             = ''
      ,      FechaConfirmacion   = 0.0
      ,      OperacionIBS        = 0.0
      ,      MontoMxLiquidado    = 0.0
      ,      MontoLiquidadoEqu   = 0.0
      ,      FechaProceso        = CONVERT(CHAR(10),@dFechaProceso,103)
      ,      FechaEmision        = CONVERT(CHAR(10),GETDATE(),103)
      ,      HoraEmision         = CONVERT(CHAR(10),GETDATE(),108)
      ,      Operador            = @Usuario
      ,      Desde               = CONVERT(CHAR(10),@dFechaDesde,103)
      ,      Hasta               = CONVERT(CHAR(10),@dFechaHasta,103)

   END

END
GO
