USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECALCULO_LINEAS_SWAP_OTRO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RECALCULO_LINEAS_SWAP_OTRO]
   (   @iRutCliente   NUMERIC(10)   = 0   
   ,   @iCodCliente   INTEGER       = 0
   ,   @Operacion     NUMERIC(9)    = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   CREATE TABLE #TMP_LINEAS_SWAP
   (   Monto         NUMERIC(21,4)
   ,   Moneda        INTEGER
   ,   Contrato      NUMERIC(10)
   ,   Rut           NUMERIC(10)
   ,   Codigo        INTEGER
   ,   FechaVcto     DATETIME
   ,   TipoSwap      INTEGER
   ,   Puntero       INTEGER Identity(1,1)
   )

   DECLARE @dFechaProceso  DATETIME
       SET @dFechaProceso  = (SELECT fechaproc FROM BacSwapSuda..SWAPGENERAL with (nolock))

   INSERT INTO #TMP_LINEAS_SWAP
   SELECT DISTINCT
          'Monto'        = compra_capital
   ,      'Moneda'       = compra_moneda
   ,      'Contrato'     = numero_operacion
   ,      'Rut'          = rut_cliente
   ,      'Codigo'       = codigo_cliente
   ,      'FechaVcto'    = fecha_termino
   ,      'TipoSwap'     = tipo_swap
   FROM   CARTERA        with (nolock)
   WHERE (compra_capital > 0 AND compra_moneda  > 0)
   AND    Estado        <> 'C' --> Del Paso a Produccion de María Paz
   AND   (rut_cliente    = @iRutCliente 
   AND    codigo_cliente = @iCodCliente 
       OR @iRutCliente   = 0 
      AND @iCodCliente   = 0)

   UPDATE BacLineas..LINEA_SISTEMA
   SET	  TotalOcupado    = 0
   ,	  TotalExceso     = 0
   ,	  TotalDisponible = TotalAsignado
   WHERE  id_sistema      = 'PCS'
   AND   (rut_cliente     = @iRutCliente 
   AND    codigo_cliente  = @iCodCliente 
       OR @iRutCliente    = 0 
      AND @iCodCliente    = 0)

   UPDATE BacLineas..LINEA_PRODUCTO_POR_PLAZO
   SET	  TotalOcupado    = 0
   ,	  TotalExceso     = 0
   ,	  TotalDisponible = TotalAsignado
   WHERE  id_sistema      = 'PCS'
   AND   (rut_cliente     = @iRutCliente 
   AND    codigo_cliente  = @iCodCliente 
       OR @iRutCliente    = 0 
      AND @iCodCliente    = 0)

   DECLARE @Posicion1     CHAR(3)
   DECLARE @Numoper       NUMERIC(10)
   DECLARE @rut           NUMERIC(9)
   DECLARE @CodCli        NUMERIC(9)
   DECLARE @MtoMda1       NUMERIC(21,04)
   DECLARE @fecvcto       CHAR(8)
   DECLARE @MercadoLc     CHAR(1)
   DECLARE @moneda        NUMERIC(5)
   DECLARE @producto      CHAR(5)
   DECLARE @rut1          NUMERIC(9)
   DECLARE @CodCli1       NUMERIC(9)

   DECLARE @iRegistros    NUMERIC(9)
   DECLARE @iRegistro     NUMERIC(9)

       SET @iRegistros    = (SELECT MAX(Puntero) FROM #TMP_LINEAS_SWAP)
       SET @iRegistro     = (SELECT MIN(Puntero) FROM #TMP_LINEAS_SWAP)

   WHILE @iRegistros >= @iRegistro
   BEGIN

      DELETE FROM BacLineas..LINEA_CHEQUEAR

      SELECT @Posicion1    = CONVERT(CHAR(3), TipoSwap)
      ,      @Numoper      = Contrato
      ,      @rut          = Rut
      ,      @CodCli       = Codigo
      ,      @MtoMda1      = Monto
      ,      @fecvcto      = CONVERT(CHAR(8), FechaVcto, 112)
      ,      @MercadoLc    = CASE WHEN clpais = 6 THEN 'S' ELSE 'N' END
      ,      @Moneda       = Moneda
      ,      @producto     = CONVERT(CHAR(5), TipoSwap)
      FROM   #TMP_LINEAS_SWAP
             INNER JOIN BacParamSuda..CLIENTE with (nolock) ON clrut = Rut AND clcodigo = Codigo
      WHERE  Puntero      = @iRegistro

      EXECUTE SP_FLUJO_VIGENTE @Numoper --> Viene del Paso a Producción de María Paz

      EXECUTE BacLineas..SP_LINEAS_CHEQUEARGRABAR  @dFechaProceso 
                                                ,  'PCS'
                                                ,  @Posicion1
                                                ,  @Numoper
                                                ,  @Numoper
                                                ,  0
                                                ,  @rut
                                                ,  @CodCli
                                                ,  @MtoMda1
                                                ,  0
                                        ,  @fecvcto
                                                ,  ''
                                                ,  0
                                                ,  0
                                                ,  @dFechaProceso
                                                ,  0
                                                ,  'N'
                                                ,  @moneda
                                                ,  'C'
                                                ,  0
                                                ,  'N'
                                                ,  0
                                                ,  @dFechaProceso
                                                ,  0
                                                ,  0
                                                ,  0
                                                ,  0
                                                ,  ''

      EXECUTE BacLineas..SP_LINEAS_CHEQUEAR       'PCS'
                                                , @producto
                                                , @Numoper
                                                , ''
                                                , 'N'
                                                , 'S'

      EXECUTE BacLineas..SP_LINEAS_GRBOPERACION 'PCS'
                                                , @Posicion1
                                                , @Numoper
                                                , @Numoper
                                                , ' '
                                                , 'N'
                                                , @MercadoLc
                                                , 0
                                                , 0
                                                , 1

      SET @iRegistro = @iRegistro + 1
   END

   UPDATE  BacLineas..MATRIZ_ATRIBUCION_INSTRUMENTO
   SET	   Acumulado_Diario = 0
   WHERE   id_sistema       = 'PCS'

   IF @Operacion = 1
   BEGIN
      UPDATE SWAPGENERAL SET tasamtm = 1
   END

END


GO
