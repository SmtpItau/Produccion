USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETIENE_LINEAS_INVEX]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RETIENE_LINEAS_INVEX]  
AS   
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @ncont   INTEGER  
   DECLARE @Posicion1   CHAR(3)  
   DECLARE @Numoper  NUMERIC(10)  
   DECLARE @nCorrela NUMERIC(09)  
   DECLARE @rut       NUMERIC(9)  
   DECLARE @CodCli      NUMERIC(9)  
   DECLARE @MtoMda1     NUMERIC(21,04)  
   DECLARE @fecvcto     CHAR(8)  
   DECLARE @fechini     CHAR(8)  
   DECLARE @MercadoLc   CHAR(1)  
   DECLARE @moneda   NUMERIC(5)  
   DECLARE @nregs   INTEGER  
   DECLARE @FecVen DATETIME  
   DECLARE @rut1        NUMERIC(9)  
   DECLARE @CodCli1     NUMERIC(9)  
  
   SELECT *  
   INTO   #tmp_car   
   FROM   BacBonosExtSuda.dbo.TEXT_CTR_INV  
   ,      BacBonosExtSuda.dbo.TEXT_ARC_CTL_DRI  
   WHERE  cpfecpago >= acfecproc  
   AND    cpnominal > 0   
  
   /*   
      Se debe actualizar el valor presente ya que los papeles que tengan ventas pueden tener fecha settlement posterior a la fecha  
      de la venta y se debe actualizar solo el valor que esta disponible en cartera VGS 17/02/2005   
   */  
   UPDATE #tmp_car  
   SET    CpVpTirc = cpvptirc * ISNULL((1 - (cpnomi_vta / cpnominal)),1)  
  
   SELECT @fechini = CONVERT(CHAR(8),acfecproc,112)      
   FROM   BacBonosExtSuda.dbo.TEXT_ARC_CTL_DRI  
  
   INSERT INTO BacLineas.dbo.LINEAS_RETENIDAS  
   SELECT cpfecven  
   ,      'BEX'  
   ,      'CPX'  
   ,      'CP'  
   ,      cpnumdocu  
   ,      cprutemi  
   ,      cpcodemi  
   ,      cprutcli  
   ,      cpcodcli  
   ,      cpvptirc  
   ,      cpvptirc  
   ,      0.0  
   ,      cptircomp  
   ,      0.0  
   ,      forma_pago  
   ,      cpfecpago  
   ,      'N'  
   FROM   #tmp_car   
   WHERE  cpnumdocu NOT IN(SELECT DISTINCT numero_operacion FROM BacLineas.dbo.LINEAS_RETENIDAS WHERE id_sistema = 'BEX')  
  
   DELETE FROM BacLineas.dbo.LINEA_CHEQUEAR  
   WHERE  FechaOperacion = @fechini  
   AND    id_sistema     = 'BEX'  
  
   SET @nregs = ( SELECT COUNT(1) FROM #TMP_CAR )  
   SET @ncont = 1  
  
   WHILE @ncont <= @nregs  
   BEGIN    
  
      SET ROWCOUNT @ncont  
  
      SELECT @Posicion1 = 'CPX'  
      ,      @Numoper   = cpnumdocu  
      ,      @nCorrela  = cpcorrelativo  
      ,      @rut      = CpRutEmi  
      ,      @CodCli    = cpcodemi  
      ,      @rut1      = CpRutEmi  
      ,      @CodCli1   = cpcodemi  
      ,      @MtoMda1   = CpVpTirc  
      ,      @fecvcto   = CONVERT(CHAR(8),CpFecVen ,112)  
      ,      @MercadoLc = CASE WHEN clpais = 6 THEN 'S' ELSE 'N' END  
      ,      @Moneda    = CpMonEmi  
      ,      @FecVen    = Cpfecven  
      FROM   #tmp_car   
             INNER JOIN BacParamSuda.dbo.CLIENTE       ON clrut = cprutemi AND clcodigo = cpcodemi  
             INNER JOIN BacLineas.dbo.LINEAS_RETENIDAS ON id_sistema = 'BEX' AND numero_operacion = cpnumdocu AND estado_liberacion = 'N'  
  
      /*
      IF EXISTS(SELECT 1 FROM BacLineas.dbo.CLIENTE_RELACIONADO WHERE clrut_hijo = @rut1 AND clcodigo_hijo = @CodCli1)  
      BEGIN  
         SELECT @rut1           = clrut_padre    
         ,      @CodCli1        = clcodigo_padre  
         FROM BacLineas.dbo.CLIENTE_RELACIONADO  
         WHERE  clrut_hijo  = @rut1   
         AND    clcodigo_hijo  = @CodCli1  
      END   
      */
        
      SET ROWCOUNT 0  
      SET @ncont = @ncont + 1  
  
      IF EXISTS(SELECT 1 FROM BacLineas.dbo.LINEA_SISTEMA WHERE @rut1 = rut_cliente AND @codcli1 = codigo_cliente AND id_sistema = 'BEX')  
      BEGIN  
         -- Esto para Imputar el Monto Ocupado a la Fecha, en el campo fecha inicio queda la fecha de proceso  
         EXECUTE BacLineas.dbo.SP_LINEAS_CHEQUEARGRABAR  
                 @fechini  
         ,       'BEX'  
         ,       @Posicion1  
         ,       @Numoper  
         ,       @Numoper  
         ,       @nCorrela  
         ,       @rut  
         ,       @CodCli  
         ,       @MtoMda1  
         ,       0  
         ,       @fecvcto  
         ,       ''  
         ,       @rut  
         ,       0  
         ,       @FecVen  
         ,       0  
         ,       'N'  
         ,       @moneda  
         ,       'C'  
         ,       0  
     ,       'N'  
         ,       0  
         ,       @fechini  
         ,       0  
         ,       0  
         ,       0  
         ,       0  
         ,       ''  
  
         EXECUTE BacLineas.dbo.SP_LINEAS_GRBOPERACION  
                'BEX'  
         ,      @Posicion1  
         ,      @Numoper  
         ,      @Numoper  
         ,      ' '  
         ,      'N'  
         ,      @MercadoLc  
      END  
   END  
  
   EXECUTE BacLineas.dbo.SP_RECALCULA_GENERAL  
  
END
GO
