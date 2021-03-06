USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_MOVIMIENTO_DIARIO_DLS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFORME_MOVIMIENTO_DIARIO_DLS]
                  (
                  @FECHA_DESDE_X   CHAR(10),
                  @FECHA_HASTA_X   CHAR(10)
                  )
AS BEGIN
SET NOCOUNT ON
   DECLARE @cMXRrda       CHAR(01)
   DECLARE @nPosInic      NUMERIC(19,4)
   DECLARE @nPCierre      NUMERIC(19,4)
   DECLARE @cFuturo       CHAR(01)
   DECLARE @cTipMer       CHAR(05)
   DECLARE @nNumOpe       NUMERIC(07)
   DECLARE @cTipOpe       CHAR(01)
   DECLARE @nMonto        NUMERIC(19,4)
   DECLARE @nMtoUssME     NUMERIC(19,4)
   DECLARE @nMtoUss30     NUMERIC(19,4)
   DECLARE @cMoneda       CHAR(03)
   DECLARE @cMonedaCNV    CHAR(03)
   DECLARE @nParTr        NUMERIC(19,4)
   DECLARE @nParMe        NUMERIC(19,4)
   DECLARE @nTcTra        NUMERIC(19,4)
   DECLARE @nTiCam        NUMERIC(19,4)
   DECLARE @cCliente      CHAR(35)
   DECLARE @nPrSpread     NUMERIC(19,8)
   DECLARE @VAL1          NUMERIC(19,8)
   DECLARE @VAL2          NUMERIC(19,8)
   DECLARE @nPrResult     NUMERIC(19,4)
   DECLARE @nTcSpread     NUMERIC(19,8)
   DECLARE @nTcResult     NUMERIC(19,2)
   DECLARE @nAcResult     NUMERIC(19,2)
   DECLARE @nFlujo        NUMERIC(19,4)
   DECLARE @nAcCLPco      NUMERIC(19,0)
   DECLARE @nAcUSDco      NUMERIC(19,4)
   DECLARE @nAcCLPve      NUMERIC(19,0)
   DECLARE @nAcUSDve      NUMERIC(19,4)
   DECLARE @nAcFlujo      NUMERIC(19,4)
   DECLARE @TcReal        NUMERIC(19,4)
   DECLARE @FECHA_DESDE   DATETIME
   DECLARE @FECHA_HASTA   DATETIME
   
   SELECT  @nPosInic    = acposini,
           @nPCierre    = acprecie,
           @FECHA_DESDE = @FECHA_DESDE_X,
           @FECHA_HASTA = @FECHA_HASTA_X
   FROM meac

   CREATE TABLE #Resultado
          (
           Tipo_Mercado      CHAR(05),
           Tipo_Operacion    CHAR(01),
           Numero_Operacion  NUMERIC(07),
           Correlativo       NUMERIC(1),
           Nombre_Cliente    VARCHAR(35),
           Monedas           CHAR(07),
           Monto_MX          NUMERIC(19,4),
           T_Cambio_Cierre   NUMERIC(19,4),
           Paridad_Cierre    NUMERIC(19,4),
           T_Cambio_Costo    NUMERIC(19,4),
           Paridad_Costo     NUMERIC(19,4),
           Spread            NUMERIC(19,4),
           Resultado_USD     NUMERIC(19,4),
           Flujo_Posicion    NUMERIC(19,4),
           Total_Compra_USD  NUMERIC(19,4),
           P_Medio_Compra    NUMERIC(19,4),
           Total_Compra_CLP  NUMERIC(19,0),
           Total_Venta_USD   NUMERIC(19,4),
           P_Medio_Venta     NUMERIC(19,4),
           Total_Venta_CLP   NUMERIC(19,0),
           U_Traiding_CLP    NUMERIC(19,0),
           U_Corporate_CLP   NUMERIC(19,0),
           T_Cambio_Real     NUMERIC(19,4)
          )

      SELECT   motipmer,
               motipope,
               monumope,
               monomcli,
               mocodmon,
               mocodcnv,
               momonmo,
               moussme,
               mouss30,
               moticam,
               moparme,
               motctra,
               mopartr,
               momonpe,
               mocostofo,
               'mofuturo' = CASE WHEN monumfut = 0 THEN '0' ELSE '1' END,
               'mostatus' = ' '
      INTO  #tmpmemo
      FROM  memo
      WHERE (moestatus   <> 'R'       AND
             moestatus   <> 'P'       AND
             moestatus   <> 'A')      AND 
            (motipmer    =  'PTAS'    OR
             motipmer    =  'EMPR'    OR
             motipmer    =  'ARBI')   AND
            (mofech     >=  @FECHA_DESDE   AND
             mofech     <=  @FECHA_HASTA)

      UNION
      SELECT   motipmer,
               motipope,
               monumope,
               monomcli,
               mocodmon,
               mocodcnv,
               momonmo,
               moussme,
               mouss30,
               moticam,
               moparme,
               motctra,
               mopartr,
               momonpe,
               mocostofo,
               CASE WHEN monumfut = 0 THEN '0' ELSE '1' END,
               ' '
      FROM  memoh
      WHERE  moestatus   <> 'A'       AND 
            (motipmer    =  'PTAS'    OR
             motipmer    =  'EMPR'    OR
             motipmer    =  'ARBI')   AND
            (mofech     >=  @FECHA_DESDE   AND
             mofech     <=  @FECHA_HASTA)
      ORDER BY monumope

      SELECT @nPrSpread = 0.0,
             @nTcSpread = 0.0,
             @nTcResult = 0.0,
             @nAcResult = 0.0,
             @nFlujo    = 0.0,
             @nAcCLPco  = 0.0,
             @nAcUSDco  = 0.0,
             @nAcCLPve  = 0.0,
             @nAcUSDve  = 0.0,
             @nAcFlujo  = @nPosInic
   
      INSERT INTO #Resultado
      VALUES ('',
              '',
              0,
              0,
              'POSICION DE CAMBIOS INCIAL EQU. USD',
              '',
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              @nAcFlujo,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0
              )

      WHILE (1=1) BEGIN
            SELECT @nNumOpe = -1
            SET ROWCOUNT 1
            SELECT @nNumOpe    = monumope, 
                   @cTipMer    = motipmer,
                   @cTipOpe    = motipope,
                   @cFuturo    = mofuturo,
                   @cCliente   = monomcli,
                   @nMonto     = momonmo,
                   @nMtoUssME  = moussme,
                   @nMtoUss30  = mouss30,
                   @nParTr     = mopartr,
                   @nParMe     = moparme,
                   @nTcTra     = motctra,
                   @nTiCam     = CASE WHEN motipmer = 'EMPR' THEN mocostofo ELSE moticam END,
                   @cMoneda    = mocodmon,
                   @cMonedaCNV = mocodcnv,
                   @TcReal     = moticam
            FROM  #tmpmemo
            WHERE mostatus = ' '
            SET ROWCOUNT 0

            IF @nNumOpe = -1 BEGIN
               BREAK
            END
            
            -- Recupera si la moneda se multiplica o se divide
            SELECT @cMXRrda = mnrrda FROM view_moneda WHERE mnnemo = @cMoneda
            -- Operaciones de Punta y Empresa
            IF @cTipMer <> 'ARBI' BEGIN
                  IF @cMXRrda = 'D' BEGIN
                        EXECUTE SP_DIV 1 , @nParTr , @VAL1 OUT 
                        EXECUTE SP_DIV 1 , @nParMe , @VAL2 OUT 
                        SELECT @nPrSpread = @VAL1 - @VAL2 
                  END ELSE BEGIN
                        SELECT @nPrSpread = @nParTr - @nParMe
                  END
               
                  SELECT @nTcSpread = @nTcTra - @TcReal
                  SELECT @VAL1 = (@nTcSpread * @nMtoUssME)
                  EXECUTE SP_DIV @VAL1 , @nPCierre , @VAL2 OUT
                  SELECT @nTcResult = ROUND( @VAL2 , 2)
                  SELECT @nPrResult = ROUND( (@nPrSpread * @nMonto), 2)
               
                  IF @cTipOpe = 'C' BEGIN
                        IF @cFuturo = '0' BEGIN
                              SELECT @nAcCLPco = @nAcCLPco + ROUND( (@nMtoUss30 * @nTiCam), 0 )
                              SELECT @nAcUSDco = @nAcUSDco + @nMtoUss30
                        END
                        SELECT @nFlujo = @nMtoUss30
                  END ELSE BEGIN
                        IF @cFuturo = '0' BEGIN
                              SELECT @nAcCLPve = @nAcCLPve + ROUND( (@nMtoUss30 * @nTiCam), 0 )
                              SELECT @nAcUSDve = @nAcUSDve + @nMtoUss30
                        END
                        SELECT @nFlujo = @nMtoUss30 * -1
                        SELECT @nPrSpread = @nPrSpread * -1
                        SELECT @nTcSpread = @nTcSpread * -1
                  END
               
                  IF @cMonedaCnv = 'USD' BEGIN
                        IF @cTipOpe = 'V' BEGIN
                              IF @cFuturo = '0' BEGIN
                                    SELECT @nAcCLPco = @nAcCLPco + ROUND( (@nMtoUssMe * @nTiCam), 0 )
                                    SELECT @nAcUSDco = @nAcUSDco + @nMtoUssMe
                              END
                              SELECT @nFlujo = @nFlujo + @nMtoUssMe
                              SELECT @nPrSpread = @nPrSpread * -1
                              SELECT @nTcSpread = @nTcSpread * -1
                        END ELSE BEGIN
                              IF @cFuturo = '0' BEGIN
                                    SELECT @nAcCLPve = @nAcCLPve + ROUND( (@nMtoUssMe * @nTiCam), 0 )
                                    SELECT @nAcUSDve = @nAcUSDve + @nMtoUssMe
                              END
                              SELECT @nFlujo = @nFlujo + (@nMtoUssMe * -1)
                        END
                  END
                  SELECT @nFlujo    = ROUND( @nFlujo, 2 )
                  SELECT @nAcFlujo  = @nAcFlujo + @nFlujo
                  SELECT @nAcResult = @nAcResult + (@nTcResult + @nPrResult)
               
                  IF (@nPrSpread <> 0 OR @nPrResult <> 0) AND @cMonedaCnv = 'CLP' BEGIN
                        INSERT INTO #Resultado
                        VALUES ( @cTipMer,
                                 @cTipOpe,
                                 @nNumOpe,
                                 1,
                                 @cCliente,
                                 @cMoneda + '/' + @cMonedaCnv,
                                 @nMonto,
                                 @nTiCam,
                                 @nParMe,
                                 @nTcTra,
                                 @nParTr,
                                 CASE WHEN @cMonedaCnv = 'CLP' THEN @nTcSpread ELSE @nPrSpread END,
                                 CASE WHEN @cMonedaCnv = 'CLP' THEN @nTcResult ELSE @nPrResult END,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 @TcReal
                               ) 
                        INSERT INTO #Resultado
                        VALUES ( @cTipMer,
                                 @cTipOpe,
                                 @nNumOpe,
                                 2,
                                 'Resultado por la paridad',
                                 @cMoneda + '/' + @cMonedaCnv,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 @nPrSpread,
                                 @nPrResult,
                                 @nAcFlujo,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0
                               )
                  END ELSE BEGIN
                        INSERT INTO #Resultado
                        VALUES ( @cTipMer,
                                 @cTipOpe,
                                 @nNumOpe,
                                 1,
                                 @cCliente,
                                 @cMoneda + '/' + @cMonedaCnv,
                                 @nMonto,
                                 @nTiCam,
                                 @nParMe,
                                 @nTcTra,
                                 @nParTr,
                                 CASE WHEN @cMonedaCnv = 'CLP' THEN @nTcSpread ELSE @nPrSpread END,
                                 CASE WHEN @cMonedaCnv = 'CLP' THEN @nTcResult ELSE @nPrResult END,
                                 @nAcFlujo,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 @TcReal
                               )
                  END      
            -- Operaciones de Arbitraje
            END ELSE BEGIN
                  IF @cMXRrda = 'D' BEGIN
                        EXECUTE SP_DIV 1 ,@nParTr, @VAL1 OUTPUT
                        EXECUTE SP_DIV 1 ,@nParMe, @VAL2 OUTPUT
                        SELECT @nPrSpread = @VAL1 - @VAL2
                  END ELSE BEGIN
                        SELECT @nPrSpread = @nParTr - @nParMe
                  END
                  SELECT @nTcSpread = 0
                  SELECT @VAL1 = (@nTcSpread * @nMtoUssME)
                  EXECUTE SP_DIV  @VAL1, @nPCierre ,@nTcResult out
                  SELECT @nTcResult = ROUND( @nTcResult, 2)
                  SELECT @nPrResult = ROUND( (@nPrSpread * @nMonto), 2)
                  SELECT @VAL1 = vmparmes
                  FROM view_posicion_spt, meac
                  WHERE vmfecha  = acfecpro AND
                        vmcodigo = @cMoneda
                  
                  IF @cTipOpe = 'C' BEGIN
                        SELECT @nAcCLPco = @nAcCLPco + ROUND((@nMtoUss30 * @nTiCam), 0)
                        SELECT @nAcUSDco = @nAcUSDco + @nMtoUss30
                        SELECT @nFlujo = @nMtoUss30
                  END ELSE BEGIN
                        SELECT @nAcCLPve = @nAcCLPve + ROUND( (@nMtoUss30 * @nTiCam), 0 )
                        SELECT @nAcUSDve = @nAcUSDve + @nMtoUss30
                        SELECT @nFlujo = @nMtoUss30 * -1
                        SELECT @nPrSpread = @nPrSpread * -1
                        SELECT @nTcSpread = @nTcSpread * -1
                  END
                  IF @cTipOpe = 'V' BEGIN
                        SELECT @nAcCLPco = @nAcCLPco + ROUND( (@nMtoUssMe * @nTiCam), 0 )
                        SELECT @nAcUSDco = @nAcUSDco + @nMtoUssMe
                        SELECT @nFlujo = @nFlujo + @nMtoUssMe
                        SELECT @nPrSpread = @nPrSpread * -1
                        SELECT @nTcSpread = @nTcSpread * -1
                  END ELSE BEGIN
                        SELECT @nAcCLPve = @nAcCLPve + ROUND( (@nMtoUssMe * @nTiCam), 0 )
                        SELECT @nAcUSDve = @nAcUSDve + @nMtoUssMe
                        SELECT @nFlujo = @nFlujo + (@nMtoUssMe * -1)
                  END
                  SELECT @nFlujo    = ROUND( @nFlujo, 2 )
                  SELECT @nAcFlujo  = @nAcFlujo + @nFlujo
                  SELECT @nAcResult = @nAcResult + (@nTcResult + @nPrResult)
                  
                  INSERT INTO #Resultado
                  VALUES ( @cTipMer,
                           @cTipOpe,
                           @nNumOpe,
                           1,
                           @cCliente,
                           @cMoneda + '/' + @cMonedaCnv,
                           @nMonto,
                           @nTiCam,
                           @nParMe,
                           @nTcTra,
                           @nParTr,
                           CASE WHEN @cMonedaCnv = 'CLP' THEN @nTcSpread ELSE @nPrSpread END,
                           CASE WHEN @cMonedaCnv = 'CLP' THEN @nTcResult ELSE @nPrResult END,
                           @nAcFlujo,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           @TcReal
                         )
            END
            UPDATE #tmpmemo SET mostatus = '1' WHERE monumope = @nNumOpe
      END               

      UPDATE #Resultado
      SET   Total_Compra_USD = @nAcUSDco,
            P_Medio_Compra   = (CASE @nAcUSDco WHEN 0 THEN 0 ELSE ROUND(@nAcCLPco / @nAcUSDco, 4) END),
            Total_Compra_CLP = @nAcCLPco,
            Total_Venta_USD  = @nAcUSDve,
            P_Medio_Venta    = (CASE @nAcUSDve WHEN 0 THEN 0 ELSE ROUND(@nAcCLPve / @nAcUSDve, 4) END),
            Total_Venta_CLP  = @nAcCLPve
      
      UPDATE #Resultado
      SET   U_Traiding_CLP   = ROUND((P_Medio_Venta - P_Medio_Compra)* (CASE WHEN Total_Compra_USD > Total_Venta_USD THEN Total_Venta_USD
                                                                             ELSE Total_Compra_USD
                                                                        END), 0)
      UPDATE #Resultado
      SET   U_Corporate_CLP  = ROUND(@nAcResult * @nPCierre, 0)

      SELECT #Resultado.*, 
            'Fecha_Proceso'      = CONVERT(CHAR(10), acfecpro, 103),
            'Nombre_Propietario' = acnombre,
            'Direccion'          = acdirecc,
            'Hora'               = CONVERT(CHAR(08), GETDATE(), 108)
      FROM  #Resultado, meac 
      ORDER BY Numero_Operacion, Correlativo

   DROP TABLE #tmpmemo
   DROP TABLE #Resultado
SET NOCOUNT OFF
END

GO
