USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETIENE_LINEAS_SPOT]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RETIENE_LINEAS_SPOT]
   (   @nRutCliente   NUMERIC(10)   )  
AS   
BEGIN  
  
   SET NOCOUNT ON  
  
   -- PROD-13828 Analisis del Rut: El rut siempre será del cliente que operó directo.  
  
   DECLARE @dFechaProceso   DATETIME  
       SET @dFechaProceso   = (SELECT acfecpro FROM BacCamSuda.dbo.MEAC)  
  
   DECLARE @dFechaAnterior  DATETIME  
       SET @dFechaAnterior  = (SELECT acfecant FROM BacCamSuda.dbo.MEAC)  
     
     
  
   DECLARE @fechini         CHAR(8)  
       SET @fechini         = CONVERT(CHAR(8), @dFechaProceso, 112)      
  
   DECLARE @ncont           INTEGER  
   DECLARE @Posicion1       CHAR(5)  
   DECLARE @Numoper         NUMERIC(10)  
   DECLARE @rut             NUMERIC(9)  
   DECLARE @CodCli          NUMERIC(9)  
   DECLARE @MtoMda1         NUMERIC(21,04)  
   DECLARE @fecvcto         CHAR(8)  
   DECLARE @MercadoLc       CHAR(1)  
   DECLARE @moneda          NUMERIC(5)  
   DECLARE @nregs           INTEGER  
   DECLARE @producto        CHAR(5)  
   DECLARE @Operador     CHAR(10)  
   DECLARE @fPago           INTEGER  
  
   -->     Agrega las operaciones COMPRA Ingresadas ayer, con valuta Hras. 24. 0 48. Que NO se encuntren retenidas  
   SELECT  moentidad  
   ,    motipmer  
   ,    monumope  
   ,    motipope  
   ,    morutcli  
   ,    mocodcli  
   ,    monomcli  
   ,    mocodmon  
   ,    mocodcnv  
   ,    momonmo  
   ,    moticam  
   ,    motctra  
   ,    moprecio  
   ,    mopretra  
   ,    moprefi  
   ,    moussme  
   ,    mouss30  
   ,    mousstr  
   ,    moussfi  
   ,    momonpe  
   ,    moentre  
   ,    morecib  
   ,    movaluta1  
   ,    movaluta2  
   ,    mooper  
   ,    mofech  
   ,    moestatus  
   ,    mofecini  
   ,    mofecvcto  
   ,       diasvalor  
   ,       DiasLineas  
   ,       FechaPago  = movaluta2  
   ,       Puntero    = identity(int)  
   INTO    #TMP_SETEA_FECHA_OPERACIONES  
   FROM    BacCamSuda.dbo.MEMOH  -- select * from BacCamSuda.dbo.MEMOH  
           INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO ON codigo = morecib  
   WHERE   motipope   = 'C'  
   AND    mofech     = @dFechaAnterior  
   AND     moestatus <> 'A'  
   AND     monumope   NOT IN( SELECT numero_operacion FROM BacLineas.dbo.LINEAS_RETENIDAS WHERE id_sistema = 'BCC' )   
   and     morecib    <> 122  
   AND     MOTIPMER  != 'CCBB'  
   and     morutcli = @nRutCliente -- PROD-13828   
  
   -->     Agrega las operaciones VENTA Ingresadas ayer, con valuta Hras. 24. 0 48. en donde se reciba posterior al pago  
   INSERT INTO #TMP_SETEA_FECHA_OPERACIONES  
   SELECT  moentidad  
   ,    motipmer  
   ,    monumope  
   ,    motipope  
   ,    morutcli  
   ,    mocodcli  
   ,    monomcli  
   ,    mocodmon  
   ,    mocodcnv  
   ,    momonmo  
   ,    moticam  
   ,    motctra  
   ,    moprecio  
   ,    mopretra  
   ,    moprefi  
   ,    moussme  
   ,    mouss30  
   ,    mousstr  
   ,    moussfi  
   ,    momonpe  
   ,    moentre  
   ,    morecib  
   ,    movaluta1  
   ,    movaluta2  
   ,    mooper  
   ,    mofech  
   ,    moestatus  
   ,    mofecini  
   ,    mofecvcto  
   ,       diasvalor  
   ,       DiasLineas  
   ,       FechaPago   = movaluta2  
   FROM    BacCamSuda.dbo.MEMOH  
           INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO ON codigo = MoRecib  
   WHERE   mofech      = @dFechaAnterior  
   AND     motipope    = 'V'  
   AND    (movaluta2   > movaluta1)  
   AND     moestatus  <> 'A'  
   AND     monumope    NOT IN( SELECT numero_operacion FROM BacLineas.dbo.LINEAS_RETENIDAS WHERE id_sistema = 'BCC')   
   AND     moentre    <> 122  
   AND     MOTIPMER  != 'CCBB'  
   and     morutcli = @nRutCliente -- PROD-13828   
  
   -->     Agrega las operaciones de dias anteriores que se encuentren retenidas  
   INSERT INTO #TMP_SETEA_FECHA_OPERACIONES  
   SELECT  moentidad  
   ,    motipmer  
   ,    monumope  
   ,    motipope  
   ,    morutcli  
   ,    mocodcli  
   ,    monomcli  
   ,    mocodmon  
   ,    mocodcnv  
   ,    momonmo  
   ,    moticam  
   ,    motctra  
   ,    moprecio  
   ,    mopretra  
   ,    moprefi  
   ,    moussme  
   ,    mouss30  
   ,    mousstr  
   ,    moussfi  
   ,    momonpe  
   ,    moentre  
   ,    morecib  
   ,    movaluta1  
   ,    movaluta2  
   ,    mooper  
   ,    mofech  
   ,    moestatus  
   ,    mofecini  
   ,    mofecvcto  
   ,       diasvalor  
   ,       DiasLineas  
   ,       FechaPago  = movaluta2  
   FROM    BacCamSuda.dbo.MEMOH  
           INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO ON codigo = morecib  
   WHERE   moestatus <> 'A'  
   AND     monumope    IN( SELECT numero_operacion FROM BacLineas.dbo.LINEAS_RETENIDAS   
                                                  WHERE id_sistema = 'BCC' and estado_liberacion = 'N' )  
   AND     morecib    <> 122  
   AND     MOTIPMER  != 'CCBB'  
   and     morutcli = @nRutCliente -- PROD-13828   
     
  
   DECLARE @nRegistros INTEGER  
       SET @nRegistros = (SELECT MAX(Puntero) FROM #TMP_SETEA_FECHA_OPERACIONES)  
   DECLARE @nPuntero   INTEGER  
       SET @nPuntero   = (SELECT MIN(Puntero) FROM #TMP_SETEA_FECHA_OPERACIONES)  
  
   DECLARE @nDias      INTEGER  
   DECLARE @dFechaPago DATETIME  
   DECLARE @dFechaVcto DATETIME  
   DECLARE @FechaOperacion DATETIME  
  
   -->   se calcula la fecha de Pago en base a los dias lineas  
   WHILE @nRegistros >= @nPuntero  
   BEGIN  
      SELECT @nDias      = CASE WHEN DiasLineas = 0 THEN diasvalor ELSE DiasLineas END --> = + DiasLineas  
         ,   @dFechaPago = movaluta2  
         ,   @dFechaVcto = movaluta2  
         ,   @FechaOperacion  = mofech       -- CONT Correccion Calculo Valuta  
      FROM   #TMP_SETEA_FECHA_OPERACIONES  
      WHERE  Puntero     = @nPuntero  
  
      EXECUTE BacTraderSuda.dbo.SP_BUSCA_FECHA_HABIL @FechaOperacion, @nDias, @dFechaVcto OUTPUT  
        
      UPDATE #TMP_SETEA_FECHA_OPERACIONES  
         SET FechaPago = @dFechaVcto  
       WHERE Puntero   = @nPuntero  
  
         SET @nPuntero = @nPuntero + 1  
   END  
  
   -->   Elimina las operaciones que no deben imputar por fecha  
   DELETE FROM #TMP_SETEA_FECHA_OPERACIONES  
         WHERE FechaPago < @dFechaProceso -- WHERE FechaPago < @dFechaProceso  
  
   -- PROD-13828 Elimina TODAS las operaciones Retenidas  
   delete BacLineas.dbo.LINEAS_RETENIDAS where Rut_cliente = @nRutCliente   
  
   INSERT INTO BacLineas.dbo.LINEAS_RETENIDAS  
   SELECT movaluta2  
   ,      'BCC'     
   ,      motipmer  
   ,      motipope  
   ,      monumope  
   ,      0  
   ,      0  
   ,      morutcli  
   ,      mocodcli  
   ,      moussme --> Se cambio  
   ,      momonmo  
   ,      momonpe  
   ,      moticam  
   ,      0.0  
   ,      morecib  
   ,      FechaPago  
   ,      'N'  
   FROM   #TMP_SETEA_FECHA_OPERACIONES   
 --  WHERE  monumope NOT IN(SELECT DISTINCT numero_operacion FROM BacLineas.dbo.LINEAS_RETENIDAS WHERE id_sistema = 'BCC') -- PROD-13828 Codigo Muerto  
  
   -->   Elimina las operaciones que quedaron fuera de la imputación  
   -- PROD-13828 Eliminación de código  
   --DELETE FROM BacLineas.dbo.LINEAS_RETENIDAS  
   --      WHERE id_sistema  = 'BCC'  
   --        AND fecha_pago <= @dFechaProceso  
  
   SET @nregs = (SELECT COUNT(*) FROM #TMP_SETEA_FECHA_OPERACIONES)  
   SET @ncont = 1  
  
   WHILE @ncont <= @nregs  
   BEGIN    
  
      SET ROWCOUNT @ncont  
  
      SELECT @Posicion1 = CONVERT(CHAR(5),motipmer)       
      ,      @Numoper   = monumope         
      ,      @rut       = morutcli         
      ,      @CodCli    = mocodcli         
      ,      @MtoMda1   = moussme --> momonmo  
      ,      @fecvcto   = CONVERT(CHAR(8), FechaPago, 112) --> movaluta2,112)      
      ,      @MercadoLc = CASE clpais WHEN 6 THEN 'S' ELSE 'N' END     
      ,      @Moneda    = 0       --> mncodmon    
      ,      @producto  = CONVERT(CHAR(5),motipmer)  
      ,      @Operador  = mooper  
      ,      @fPago     = morecib  
      FROM   #TMP_SETEA_FECHA_OPERACIONES  
             INNER JOIN BacParamSuda.dbo.CLIENTE       ON clrut      = morutcli AND clcodigo = mocodcli  
             INNER JOIN BacParamSuda.dbo.MONEDA        ON mnnemo     = mocodmon  
             INNER JOIN BacLineas.dbo.LINEAS_RETENIDAS ON id_sistema = 'BCC' AND numero_operacion = monumope and estado_liberacion = 'N'  
  
      SET ROWCOUNT 0  
  
      SET @ncont = @ncont + 1  
  
      IF EXISTS(SELECT 1 FROM BacLineas.dbo.LINEA_SISTEMA WHERE @rut = rut_cliente AND @codcli = codigo_cliente AND id_sistema = 'BCC')  
      BEGIN  
  
         EXECUTE BacLineas.dbo.SP_LINEAS_CHEQUEARGRABAR  
                 @fechini   
            ,    'BCC'  
            ,    @Posicion1   
            ,    @Numoper    
            ,    @Numoper    
            ,    0    
            ,    @rut     
            ,    @CodCli    
            ,    @MtoMda1    
            ,    0    
            ,    @fecvcto    
            ,    @Operador    
            ,    0    
            ,    0    
            ,    @fechini   
            ,    0    
            ,    'N'  
            ,   @moneda    
            ,    'C'  
            ,    0    
            ,    'N'  
            ,    0    
            ,    @fechini   
            ,    0  
            ,    @fPago --> 0 -->    
            ,    0  
            ,    0  
            ,    ''  
  
         --  Esto para crear linea por plazo si no existe                          
         EXECUTE BacLineas.dbo.SP_LINEAS_CHEQUEAR 'BCC', @producto, @Numoper, '', 'N', 'S'  
  
         EXECUTE BacLineas.dbo.SP_LINEAS_GRBOPERACION  
                'BCC'  
         ,       @Posicion1  
         ,       @Numoper  
         ,       @Numoper  
         ,       ' '  
         ,       'N'  
         ,       @MercadoLc  
  
      END  
   END  
  
   -- PROD-13828  
   -- EXECUTE BacLineas.dbo.SP_RECALCULA_GENERAL  
  
END

GO
