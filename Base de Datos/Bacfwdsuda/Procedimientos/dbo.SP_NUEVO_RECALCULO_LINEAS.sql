USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NUEVO_RECALCULO_LINEAS]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_NUEVO_RECALCULO_LINEAS]
   (   @cSistema   CHAR(3)  
   ,   @nCliente   NUMERIC(10)  
   ,   @nCodigo    INTEGER
   ,   @iRecGrl    INTEGER = 0
   )  
AS   
BEGIN  
  
   SET NOCOUNT ON  

   TRUNCATE TABLE BacLineas.dbo.LINEA_CHEQUEAR
  
   INSERT INTO LOG_AUDITORIA_FWD  
   SELECT 2, acfecproc, GETDATE(), CONVERT(CHAR(10),GETDATE(),108), 'RECALCULO', 'LGUERRA', 'BFW', '--', '00', 'RECALCULOD E LINEAS', 'LINEAS', '', ''  
   FROM   MFAC WITH (NOLOCK)  
  
   CREATE TABLE #TMP_MENSAJE  
   (   xMensaje   VARCHAR(255)  
   ,   xGlosa     VARCHAR(255)  
   )  
  
   DECLARE @ncont  	   INTEGER
   DECLARE @Posicion1      CHAR(03)  
   DECLARE @Numoper     NUMERIC(10)  
   DECLARE @rut          NUMERIC(9)  
   DECLARE @CodCli         NUMERIC(09)  
   DECLARE @rut1          NUMERIC(9)  
   DECLARE @CodCli1        NUMERIC(09)  
   DECLARE @MtoMda1        NUMERIC(21,04)  
   DECLARE @fecvcto        CHAR(08)  
   DECLARE @fechini        CHAR(08)  
   DECLARE @MercadoLc      CHAR(01)  
   DECLARE @moneda      NUMERIC(05)  
   DECLARE @nregs  	   INTEGER
   DECLARE @producto     CHAR(05)  
   DECLARE @fecpro    DATETIME  
   DECLARE @nContraMoneda  NUMERIC(03)  
   DECLARE @nMonedaOpera   NUMERIC(03)  
   DECLARE @nPerdidaDev    NUMERIC(21,04)  
   DECLARE @nTipoOperacion NUMERIC(05)  
   DECLARE @nPlazoResidual NUMERIC(05)  
   DECLARE @nTipoCam    FLOAT  
   DECLARE @nDolarHoy    FLOAT  
   DECLARE @Moneda_Sis    NUMERIC(10)  
   DECLARE @PERDIDALIM    FLOAT  
   DECLARE @Monto_Ori    FLOAT  
   DECLARE @Monto_USD    FLOAT  
   DECLARE @Clase_Op     CHAR(1)  
  
   TRUNCATE TABLE BacLineas.dbo.debug_valores
  
   CREATE TABLE #TMP_MONEDA  
   (   Codigo NUMERIC(10)  
   ,   TCambio FLOAT  
   ,   Tipo CHAR(01)  
   )  
  
   SET @fecpro    = (SELECT acfecproc                      FROM BacFwdSuda.dbo.MFAC with(nolock) )
   SET @fechini   = (SELECT CONVERT(CHAR(8),acfecproc,112) FROM BacFwdSuda.dbo.MFAC with(nolock) )
   SET @nDolarHoy = (SELECT vmvalor                        FROM BacParamSuda.dbo.VALOR_MONEDA with(nolock)
                                                                    WHERE vmcodigo = 994 AND vmfecha = @fecpro)  
   INSERT INTO #TMP_MONEDA (Codigo,   TCambio, Tipo)  
                     SELECT mncodmon, 1.0    , mnrrda FROM BacParamSuda.dbo.MONEDA
  
   UPDATE #TMP_MONEDA  
      SET TCambio   = CASE WHEN Codigo = 13 THEN @nDolarHoy  
                           ELSE CASE WHEN vmvalor = 0.0 THEN 1.0 ELSE vmvalor END  
                      END  
     FROM BacparamSuda.dbo.VALOR_MONEDA
    WHERE vmcodigo  = Codigo  
      AND vmfecha   = @fecpro  
  
   SELECT  MFCA.*  
   ,       'Id_Puntero' = Identity(INT)  
   INTO    #TMP_CAR  
   FROM    BacFwdSuda.dbo.MFCA
           INNER JOIN BacParamSuda.dbo.CLIENTE    ON cacodigo     = clrut     AND cacodcli        = clcodigo
           INNER JOIN BacParamSuda.dbo.PRODUCTO P ON P.id_sistema = @cSistema AND Codigo_producto = cacodpos1
   WHERE   cafecvcto > @fecpro  
   AND     cacodpos1 IN(1,2,3,7,10,14)  -- 5522  
      AND  cacodigo  = @nCliente  
      AND  cacodcli  = @nCodigo  
   ORDER BY canumoper  
  
   SELECT 'Numero'   = canumoper  
   ,      'fecha'    = MIN(corfecvcto)  
   ,      'fechaven' = cafecvcto  
   INTO    #CORTES  
   FROM    MFCA  
           INNER JOIN CORTES ON canumoper = cornumoper AND corfecvcto > @fecpro  
   WHERE   cacodigo  = @nCliente  
   AND     cacodcli  = @nCodigo  
   GROUP BY canumoper, cafecvcto  
   
   UPDATE #TMP_CAR  
   SET    cafecvcto = CASE WHEN fechaven >= fecha THEN fechaven ELSE fecha END  
   FROM   #CORTES  
   WHERE  canumoper = Numero  
  
   SET @nregs = (SELECT MAX(Id_Puntero) FROM #TMP_CAR)  
   SET @ncont = (SELECT MIN(Id_Puntero) FROM #TMP_CAR)  
  
   WHILE @nregs >= @ncont  
   BEGIN    
        
      SELECT @Posicion1      = CONVERT(CHAR(3),cacodpos1)  
      ,      @Numoper        = canumoper  
      ,      @rut            = cacodigo  
      ,      @CodCli         = cacodcli  
      ,      @rut1           = cacodigo  
      ,      @CodCli1        = cacodcli  
      ,      @MtoMda1        = CASE WHEN cacodpos1 = 2  THEN camtomon2  
                                    WHEN cacodpos1 = 3  THEN caequusd1  
                                    WHEN cacodpos1 = 10 THEN caequusd2  
                                    ELSE camtomon1  
                   END  
      ,      @fecvcto        = CONVERT(CHAR(8),cafecvcto,112)  
      ,      @MercadoLc      = CASE WHEN clpais = 6 THEN 'S' ELSE 'N' END  
      ,      @Moneda         = cacodmon1  
      ,      @producto       = CONVERT(CHAR(5),cacodpos1)  
      ,      @nMonedaOpera   = ISNULL(CASE WHEN cacodpos1 = 2 THEN cacodmon2 ELSE cacodmon1 END,0)  
      ,      @nContraMoneda  = ISNULL(CASE WHEN Contra_Moneda = 'S' THEN ISNULL(CASE WHEN cacodpos1 = 2 THEN cacodmon1 ELSE cacodmon2 END,0)  
               ELSE                          0   
          END,0)  
      ,      @nPerdidaDev    = CASE WHEN ROUND(fRes_Obtenido,0) > 0.0 THEN ROUND(fRes_Obtenido,0) ELSE 0.0 END  
      ,      @nTipoOperacion = cacodpos1  
      ,      @nPlazoResidual = DATEDIFF(DAY, @fecpro, cafecvcto) --> caplazovto  
      ,      @Monto_Ori      = camtomon1  
      ,      @Clase_Op      = catipoper  
      FROM   #TMP_CAR    
             INNER JOIN BacParamSuda.dbo.PRODUCTO P ON P.id_sistema = @cSistema AND Codigo_producto = cacodpos1 
             INNER JOIN BacParamSuda.dbo.CLIENTE    ON cacodigo     = clrut     AND cacodcli        = clcodigo
      WHERE  Id_Puntero      = @ncont  
  
      /******* Actualiza el Monto Origen a Dolar con la Paridad del día *******/  
      SET @Monto_USD = @MtoMda1  
      IF @Posicion1 IN(2,3)  
      BEGIN  
         SELECT @Monto_USD = CASE WHEN @Posicion1 In(2) THEN (@Monto_Ori * Tcambio) / @nDolarHoy  
                      WHEN @Posicion1 In(3) THEN (@Monto_Ori * Tcambio) / @nDolarHoy  
                  END  
           FROM #TMP_MONEDA  
          WHERE Codigo     = @Moneda  
      END  
      SET @MtoMda1 = @Monto_USD  
      /******************************* FIN ***********************************/  
  
      SET @ncont   = @ncont + 1  
  
      SET @rut1    = @nCliente  
      SET @CodCli1 = @nCodigo  
  
      IF (1 = 1)
      BEGIN  
  
         EXECUTE BacLineas.dbo.SP_LINEAS_CHEQUEARGRABAR @fechini
                                                ,    @cSistema  
                                                ,    @Posicion1  
                                                ,    @Numoper  
                                                ,    @Numoper  
                                                ,    0  
                                                ,    @rut1  
                                                ,    @CodCli1  
                                                ,    @MtoMda1  
                                                ,    0  
                                                ,    @fecvcto  
                                                ,    ''  
                                                ,    0  
                                                ,    0  
                                                ,    @fechini  
                                                ,    0  
                                                ,    'N'  
                                                ,    @moneda  
                                                ,    'C'  
                                                ,    0  
                                                ,    'N'  
                                                ,    0  
             ,    @fechini  
                                         ,    0  
                           ,    0  
                                                ,    0  
                                                ,    0  
                                                ,    ''  

         EXECUTE BacLineas.dbo.SP_LINEAS_CHEQUEAR      @cSistema
                                                ,   @producto  
                                                ,   @Numoper  
                                                ,   ''  
                                                ,   'N'  
                                                ,   'S'  

  
         INSERT INTO #TMP_MENSAJE  
         EXECUTE BacLineas.dbo.SP_LINEAS_GRBOPERACION  @cSistema
                                                ,   @Posicion1  
                                                ,   @Numoper  
                                                ,   @Numoper  
                                                ,   ' '  
                                                ,   'N'  
                                                ,   @MercadoLc  
                                                ,   @nContraMoneda  
                                                ,   @nMonedaOpera  
  
  
  
         /***************** Fin LINEA_PRODUCTO_POR_PLAZO **************************/  
         EXECUTE SP_Graba_Registro_Utilidad_Banco  @Numoper  
                                                ,  @nTipoOperacion  
                                                ,  @rut  
                                                ,  @CodCli  
                                                ,  @nMonedaOpera  
                                                ,  @nPerdidaDev  
                                                ,  @nContraMoneda  
                                                ,  @nPlazoResidual  
                                                ,  @Monto_Ori  
                                                ,  @MtoMda1  
                                                ,  @Clase_Op  
  
      END -- If  
   END -- While  
  
  
   IF @iRecGrl = 1  
   BEGIN  
      EXECUTE BacLineas.dbo.SP_RECALCULA_GENERAL
  
       UPDATE BacLineas.dbo.MATRIZ_ATRIBUCION_INSTRUMENTO 
          SET Acumulado_Diario = 0  
        WHERE Id_Sistema       = @cSistema  
   END  
  
   DROP TABLE #TMP_MENSAJE  
  
END  
GO
