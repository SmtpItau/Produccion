USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETIENE_LINEAS_SWAP]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RETIENE_LINEAS_SWAP]
AS 
BEGIN
-- Swap: Guardar Como
   SET NOCOUNT ON

   DECLARE @FechaProc   DATETIME
   SELECT  @FechaProc   = acfecproc
   FROM    BacTraderSuda..MDAC

   DECLARE @ncont       INTEGER
   ,       @Posicion1   CHAR(3)
   ,       @Numoper     NUMERIC(10)
   ,       @rut         NUMERIC(9)
   ,       @CodCli      NUMERIC(9)
   ,       @MtoMda1     NUMERIC(21,04)
   ,       @fecvcto     CHAR(8)
   ,       @fechini     CHAR(8)
   ,       @MercadoLc   CHAR(1)
   ,       @moneda      NUMERIC(5)
   ,       @nregs       INTEGER
   ,       @producto    CHAR(5)
   ,       @rut1        NUMERIC(9)
   ,       @CodCli1     NUMERIC(9)

   SELECT DISTINCT
          c.compra_capital
   ,	  c.compra_moneda
   ,	  c.numero_operacion
   ,	  c.rut_cliente
   ,	  c.codigo_cliente
   ,	  c.fecha_termino
   ,	  c.tipo_swap
   INTO   #tmp_car
   FROM   bacswapsuda..CARTERA      c
   WHERE (c.fechaliquidacion = @FechaProc OR c.fechaliquidacion = DATEADD(DAY,-4,@FechaProc))
   AND    c.tipo_flujo        = 1
   AND    c.Estado <> 'C'
   

   INSERT INTO BacLineas..LINEAS_RETENIDAS
   SELECT c.fecha_vence_flujo
   ,      'PCS'
   ,      c.tipo_swap
   ,      c.tipo_operacion
   ,      c.numero_operacion
   ,      0
   ,      0
   ,      c.rut_cliente
   ,      c.codigo_cliente
   ,      c.compra_capital
   ,      c.compra_interes
   ,      0.0
   ,      c.compra_valor_tasa
   ,      0.0
   ,      c.recibimos_documento
   ,      c.fecha_vence_flujo
   ,      'N'
   FROM   BacSwapSuda..CARTERA  c
   WHERE (c.fechaliquidacion = @FechaProc OR c.fechaliquidacion = DATEADD(DAY,-4,@FechaProc))
   AND    c.tipo_flujo        = 1
   AND    c.Estado <> 'C'

   SELECT @fechini        = CONVERT(CHAR(8),fechaproc ,112)    
   FROM   BacSwapSuda..SWAPGENERAL

   SELECT @fechini        = CONVERT(CHAR(8),@FechaProc,112)    
   FROM   BacSwapSuda..SWAPGENERAL


   SELECT @nregs = COUNT(*)
   FROM   #tmp_car

   SELECT @ncont = 1

   WHILE @ncont <= @nregs
   BEGIN  
      SET ROWCOUNT @ncont

      SELECT @Posicion1     = CONVERT(CHAR(3),tipo_swap)
      ,      @Numoper       = numero_operacion
      ,      @rut           = rut_cliente
      ,      @CodCli        = codigo_cliente
      ,      @MtoMda1       = compra_capital
      ,      @fecvcto       = CONVERT(CHAR(8),fecha_termino,112)
      ,      @MercadoLc     = CASE WHEN clpais = 6 THEN 'S' ELSE 'N' END
      ,      @Moneda        = compra_moneda
      ,      @producto      = CONVERT(CHAR(5),tipo_swap)
      FROM   #tmp_car
             LEFT JOIN BacParamSuda..CLIENTE ON rut_cliente = clrut AND codigo_cliente = clcodigo

      IF EXISTS(SELECT 1 FROM BacLineas..CLIENTE_RELACIONADO WHERE clrut_hijo = @rut AND clcodigo_hijo = @CodCli)
      BEGIN
         SELECT @rut1         = clrut_padre
         ,      @CodCli1      = clcodigo_padre
         FROM	BacLineas..CLIENTE_RELACIONADO
         WHERE 	clrut_hijo    = @rut1
         AND    clcodigo_hijo = @CodCli1
      END ELSE
      BEGIN
         SELECT	@rut1         = @rut
         SELECT	@CodCli1      = @CodCli
      END

      SET ROWCOUNT 0
      SELECT @ncont = @ncont + 1

      IF EXISTS(SELECT 1 FROM BacLineas..LINEA_SISTEMA WHERE @rut1 = rut_cliente AND @codcli1 = codigo_cliente AND id_sistema = 'PCS' )
      BEGIN
         EXECUTE BacLineas..SP_LINEAS_CHEQUEARGRABAR
                 @fechini    ,
                 'PCS'       ,
                 @Posicion1  ,
                 @Numoper    ,
                 @Numoper    ,
                 0   ,
                 @rut        ,
                 @CodCli     ,
                 @MtoMda1    ,
                 0           ,
                 @fecvcto    ,
                 ''          ,
                 0           ,
                 0           ,
                 @fechini    ,
                 0           ,
                 'N'         ,
                 @moneda     ,
                 'C'         ,
                 0           ,
                 'N'  	     ,
                 0	     ,
                 @fechini    ,
                 0	     , 
                 0	     ,
                 0	     ,
                 0	     ,
                 ''

         EXECUTE BacLineas..SP_LINEAS_CHEQUEAR
                 'PCS'       ,
                 @producto   ,
                 @Numoper    ,
                 ''          ,
                 'N'         ,
                 'S'

         EXECUTE BacLineas..SP_LINEAS_GRBOPERACION
                 'PCS'      ,
                 @Posicion1 ,
                 @Numoper   ,
                 @Numoper   ,
                 ' '        ,
                 'N'        ,
                 @MercadoLc
      END
   END

   EXECUTE BacLineas..SP_RECALCULA_GENERAL

   UPDATE  BacLineas..MATRIZ_ATRIBUCION_INSTRUMENTO
   SET	   Acumulado_Diario = 0
   WHERE   id_sistema       = 'PCS'

END
GO
