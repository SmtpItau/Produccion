USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETIENE_LINEAS_TRADER]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RETIENE_LINEAS_TRADER]  
   (   @dFecPro   DATETIME  
   ,   @idSistema CHAR(03)  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @Contador            INTEGER  
   DECLARE @sw                  CHAR(1)  
   DECLARE @cSistema            CHAR(03)  
   DECLARE @nNumoper            NUMERIC(10,0)  
   DECLARE @nNumdocu            NUMERIC(10,0)  
   DECLARE @nCorrela            NUMERIC(10,0)  
   DECLARE @ctranssaccion       CHAR(15)  
   DECLARE @ctipo_detalle       CHAR(1)  
   DECLARE @cactualizo_linea    CHAR(1)  
   DECLARE @nmontotransaccion   NUMERIC(19,4)  
   DECLARE @ctipo_movimiento    CHAR(1)  
   DECLARE @nrutcli             NUMERIC(09,0)  
   DECLARE @ncodigo             NUMERIC(09,0)  
   DECLARE @nplazodesde         NUMERIC(09,0)  
   DECLARE @nplazohasta         NUMERIC(09,0)  
   DECLARE @csistematras        CHAR(03)  
   DECLARE @nmonto              NUMERIC(19,4)  
   DECLARE @dfecvctop           DATETIME  
   DECLARE @dfecInip            DATETIME  
   DECLARE @ccontrolaplazo      CHAR(01)  
   DECLARE @nRutcasamatriz      NUMERIC(09,0)  
   DECLARE @nCodigocasamatriz   NUMERIC(09,0)  
   DECLARE @dfecproc  DATETIME  
   DECLARE @dFecAnt             DATETIME  
  
   DELETE FROM DATOSLINGRABAR  
/* PROD-13828 No aplica hacer esto 
   DELETE FROM BacLineas.dbo.LINEA_CHEQUEAR  
         WHERE fechaoperacion = @dfecpro  
           AND id_sistema     = 'BTR'  
  
   DELETE FROM BacLineas.dbo.LINEA_TRANSACCION  
         WHERE id_sistema  = @idSistema  
*/
   SELECT @dfecproc = acfecproc   
   ,      @dFecAnt  = acfecante  
   FROM   BacTraderSuda.dbo.MDAC  
  
   DELETE FROM BacLineas.dbo.LINEAS_RETENIDAS  
         WHERE fecha_pago <= @dfecpro  
           AND id_sistema  = 'BTR'  
  
   DECLARE @nRegs        INTEGER  
   DECLARE @nCont        INTEGER  
   DECLARE @Posicion1    CHAR(03)  
   DECLARE @Numoper      NUMERIC(10)  
   DECLARE @rut          NUMERIC(09)  
   DECLARE @CodCli       NUMERIC(09)  
   DECLARE @MtoMda1      NUMERIC(21,04)  
   DECLARE @fecvcto      CHAR(08)  
   DECLARE @fechini      CHAR(08)  
   DECLARE @MercadoLc    CHAR(01)  
   DECLARE @correla      NUMERIC(03)  
   DECLARE @moneda       NUMERIC(03)  
   DECLARE @codigo       NUMERIC(05)  
   DECLARE @seriado      CHAR(01)  
   DECLARE @nDolar       NUMERIC(19,4)  
   DECLARE @cInstser     CHAR(10)  
   DECLARE @cMascara     CHAR(10)  
   DECLARE @dFeccomp     DATETIME  
   DECLARE @nforpago     NUMERIC(03)  
   DECLARE @nmoneda      NUMERIC(05)  
  
   -->     Carga Temporal para toma de Lineas, con operaciones que no esten en Lineas Retenidas  
   SELECT  rsfecha      = rsfecha  
      ,    rsnumdocu    = rsnumdocu  
      ,    rscorrela    = rscorrela  
      ,    rsrutemis    = rsrutemis  
      ,    rsrutcli     = rsrutcli  
      ,    rscodcli     = rscodcli  
      ,    rsvppresen   = rsvppresen  
      ,    rsnominal    = rsnominal  
      ,    rstir        = rstir  
      ,    rsforpagi    = rsforpagi  
      ,    rscodigo     = rscodigo  
      ,    rsfeccomp    = rsfeccomp  
      ,    rsinstser    = rsinstser  
      ,    rsmascara    = rsmascara  
      ,    rsmonemi     = rsmonemi  
   ,        sw        = 'N'  
   INTO     #TMP_DI  
   FROM    BacTraderSuda.dbo.MDRS  
   WHERE    rsfecha   = @dFecPro  
   AND     (rscartera = '111' and rstipoper = 'VC')  
   AND      rsrutcart > 0  
   AND     rsnumdocu    NOT IN(SELECT numero_operacion FROM BacLineas.dbo.LINEAS_RETENIDAS WHERE id_sistema = 'BTR')  
   ORDER BY rsnumdocu,rscorrela  
     
   -->     Carga Lineas Retenidas con la informacion anterior  
   INSERT INTO BacLineas.dbo.LINEAS_RETENIDAS  
   SELECT rsfecha  
   ,      'BTR'  
   ,      'VC'  
   ,      'CP'  
   ,      rsnumdocu  
   ,      rsrutemis  
   ,      1  
   ,      rsrutcli  
   ,      rscodcli  
   ,      rsvppresen  
   ,      rsnominal  
   ,      rsvppresen  
   ,      rstir  
   ,      0.0  
   ,      rsforpagi  
   ,      rsfecha  
   ,      'N'  
   FROM   #TMP_DI  
  
   SET @nRegs = (SELECT COUNT(1) FROM #TMP_DI)  
   SET @nCont = 1  
  
   WHILE 1 = 1  
   BEGIN    
  
      SET ROWCOUNT 1  
      SET @seriado = '*'  
  
       SELECT @Numoper  = rsnumdocu  
      ,      @correla  = rscorrela  
      ,      @MtoMda1  = rsvppresen  
      ,      @rut  = rsrutcli  
      ,      @CodCli   = rscodcli  
      ,      @codigo   = incodigo  
      ,      @seriado  = inmdse  
      ,      @fecvcto  = CONVERT(CHAR(8),rsfecha,112)  
      ,      @fechini  = CONVERT(CHAR(8),rsfeccomp,112)  
      ,      @dFeccomp = rsfeccomp  
      ,      @nDolar   = CASE WHEN SUBSTRING(rsinstser,1,3)='DPX' THEN 0 ELSE vmvalor END  
      ,      @cInstser = rsinstser  
      ,      @cMascara = rsmascara  
      ,      @nforpago = rsforpagi  
      ,      @nmoneda  = rsmonemi  
      FROM   #TMP_DI  
             LEFT  JOIN BacParamSuda.dbo.INSTRUMENTO   ON rscodigo   = incodigo  
             LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA  ON vmcodigo   = 994   AND vmfecha = @dFecAnt  
             INNER JOIN BacLineas.dbo.LINEAS_RETENIDAS ON id_sistema = 'BTR' AND numero_operacion = rsnumdocu AND estado_liberacion = 'N'  
      WHERE  SW        = 'N'  
  
  
      SET ROWCOUNT 0  
  
      IF @seriado = '*'   
         BREAK  
  
      IF @seriado = 'N' AND @codigo <> 98  
         SELECT @moneda   = nsmonemi  
         ,      @rut    = nsrutemi  
         ,      @moneda   = nsmonemi  
         FROM   BacParamSuda.dbo.NOSERIE  
         WHERE  nsnumdocu = @Numoper  
         AND    nscorrela = @correla  
  
      IF @seriado = 'S' AND @codigo <> 98   
         SELECT @rut    = serutemi  
         ,      @moneda   = semonemi  
         FROM   BacParamSuda.dbo.SERIE  
         WHERE  semascara = @cMascara  
  
      IF EXISTS(SELECT 1 FROM BacTraderSuda.dbo.MDVI WHERE vinumdocu = @Numoper AND vicorrela = @correla)  
      BEGIN  
         SET @MtoMda1 = @MtoMda1 + (SELECT SUM(vivptirv) FROM BacTraderSuda.dbo.MDVI WHERE vinumdocu = @Numoper AND vicorrela = @correla)  
      END  
  
      SET @ncont = @ncont + 1  
  
      IF @MtoMda1 > 0   
      BEGIN  
         IF @CodCli = 10  
            SET @CodCli = 1    
  
            INSERT INTO DATOSLINGRABAR  
            SELECT  @dfecproc   
            ,       'BTR'  
            ,       'CP'  
            ,       @rut  
            ,       @CodCli  
            ,       @Numoper  
            ,       @Numoper  
            ,       @Correla  
            ,       @fechini  
            ,       @MtoMda1  
            ,       @nDolar  
            ,       @fecvcto  
            ,       ''  
            ,       @nmoneda  
            ,       'N'  
            ,       @codigo  
            ,       @nforpago  
            ,       0  
            ,       0  
  
            EXECUTE BacLineas.dbo.SP_LINEAS_GRABAR  
                    @dfecproc   
            ,       'BTR'  
            ,       'CP'  
            ,       @rut  
            ,       @CodCli  
            ,       @Numoper  
            ,       @Numoper  
            ,       @Correla  
            ,       @fechini  
            ,       @MtoMda1  
            ,       @nDolar  
            ,       @fecvcto  
            ,       ''  
            ,       @nmoneda  
            ,       'N'  
            ,       @codigo  
            ,       @nforpago  
  
            UPDATE BacTraderSuda.dbo.MDMO  
            SET    mostatreg = ''  
            WHERE  monumoper = @Numoper  
            AND    monumdocu = @Numoper  
      END  
  
      UPDATE #TMP_DI  
      SET    sw        = 'S'  
      WHERE  rsnumdocu = @Numoper  
      AND    rscorrela = @correla  
   END      
   ---------------------------------------------------------------------------------------  
  
   SELECT rsfecha    = rsfecha  
      ,   rsnumdocu  = rsnumdocu  
      ,   rscorrela  = rscorrela  
      ,   rsrutemis  = rsrutemis  
      ,   rsrutcli   = rsrutcli  
      ,   rscodcli   = rscodcli  
      ,   rsvppresen = rsvppresen  
      ,   rsnominal  = rsnominal  
      ,   rstir      = rstir  
      ,   rsforpagi  = rsforpagi  
      ,   rsmonpact  = rsmonpact  
      ,   rsmonemi   = rsmonemi  
      ,   rscodigo   = rscodigo  
      ,   rsfecvtop  = rsfecvtop  
      ,   rsfecinip  = rsfecinip  
   ,      sw        = 'N'  
   INTO   #TMP_CI  
   FROM   BacTraderSuda.dbo.MDRS  
   WHERE  rsfecha    = @dFecPro  
   AND    rstipoper  = 'VC'  
   AND    rsinstser  = 'ICOL'  
   AND    rsnumdocu  NOT IN(SELECT numero_operacion FROM BacLineas.dbo.LINEAS_RETENIDAS WHERE id_sistema = 'BTR') --> Se agrega control para Liberacion Manual  
  
   INSERT INTO BacLineas.dbo.LINEAS_RETENIDAS  
   SELECT rsfecha  
   ,      'BTR'  
   ,      'VC'  
   ,      'ICOL'  
   ,      rsnumdocu  
   ,      rsrutemis  
   ,      1  
   ,      rsrutcli  
   ,      rscodcli  
   ,      CASE WHEN mnextranj = 0 then rsvppresen                      -- Pesos,Uf,Dolar Obs, Dolar Acur.  
               ELSE                    round((rsvppresen * vmvalor),4) -- Moneda Extr.  
          END  
   ,      rsnominal  
   ,      CASE WHEN mnextranj = 0 then rsvppresen                      -- Pesos,Uf,Dolar Obs, Dolar Acur.  
               ELSE                    round((rsvppresen * vmvalor),4) -- Moneda Extr.  
          END  
   ,      rstir  
   ,      0.0  
   ,      rsforpagi  
   ,      rsfecha  
   ,      'N'  
   FROM   #TMP_CI  
          LEFT JOIN BacParamSuda.dbo.MONEDA       ON mncodmon = rsmonpact  
          LEFT JOIN BacParamSuda.dbo.VALOR_MONEDA ON vmfecha  = @dFecAnt AND vmcodigo = CASE WHEN rsmonpact = 13  THEN 994   
                                                                   when rsmonpact = 999 then 994  
                                                                   else rsmonpact  
                                                                                        END  
  
   SET @nRegs = (SELECT COUNT(1) FROM #TMP_CI)  
  
   WHILE 1 = 1  
   BEGIN    
  
      SET @seriado = '*'  
  
      SET ROWCOUNT 1  
  
      SELECT @Numoper  = rsnumdocu  
      ,      @correla  = rscorrela  
      ,      @rut      = rsrutcli  
      ,      @CodCli   = rscodcli  
      ,      @MtoMda1  = CASE WHEN mnextranj = 0 then rsvppresen                     -- Pesos,Uf,Dolar Obs, Dolar Acur.  
                              ELSE                    round((rsvppresen * vmvalor),4) -- Moneda Extr.  
                         END  
      ,      @moneda   = rsmonemi  
      ,      @codigo   = rscodigo  
      ,      @seriado  = 'N'  
      ,      @fecvcto  = CONVERT(CHAR(8),rsfecvtop,112)  
      ,      @fechini  = CONVERT(CHAR(8),rsfecinip,112)  
      ,      @nDolar   = vmvalor  
      ,      @nforpago = rsforpagi  
      ,      @nmoneda  = rsmonemi  
      FROM   #TMP_CI  
             LEFT JOIN BacParamSuda.dbo.MONEDA       ON mncodmon = rsmonpact  
             LEFT JOIN BacParamSuda.dbo.VALOR_MONEDA ON vmfecha  = @dFecAnt AND vmcodigo = CASE WHEN rsmonpact = 13  THEN 994   
                                                                      when rsmonpact = 999 then 994  
                                                                      else 994 -- rsmonpact  
                                                                                           END  
             INNER JOIN BacLineas.dbo.LINEAS_RETENIDAS ON id_sistema = 'BTR' AND numero_operacion = rsnumdocu AND estado_liberacion = 'N'  
      WHERE  sw        = 'N'  
  
      SET ROWCOUNT 0  
  
      IF @seriado = '*'   
         BREAK  
  
      IF @MtoMda1 > 0   
      BEGIN  
         INSERT INTO DATOSLINGRABAR  
         SELECT @dfecproc  
         ,       'BTR'  
         ,       'ICOL'  
         ,       @Rut  
         ,       @codcli  
         ,       @Numoper  
         ,       @Numoper  
         ,       @correla  
         ,       @fechini  
         ,       @MtoMda1  
         ,       @nDolar  
         ,       @fecvcto  
         ,       ''  
         ,       @nmoneda  
         ,       'N'  
         ,       @codigo  
         ,       @nforpago  
         ,       0  
         ,       0  
  
         EXECUTE BacLineas.dbo.SP_LINEAS_GRABAR  
                 @dfecproc  
         ,       'BTR'  
         ,       'ICOL'  
         ,       @Rut  
         ,       @codcli  
         ,       @Numoper  
         ,       @Numoper  
         ,       @correla  
         ,       @fechini  
         ,       @MtoMda1  
         ,       @nDolar  
         ,       @fecvcto  
         ,       ''  
         ,       @nmoneda  
         ,       'N'  
       ,       @codigo  
         ,       @nforpago  
  
         UPDATE BacTraderSuda.dbo.MDMO  
         SET  mostatreg = ''  
         WHERE  monumoper = @Numoper  
         AND monumdocu = @Numoper  
      END  
  
      UPDATE #TMP_CI  
      SET    sw        = 'S'  
      WHERE  rsnumdocu = @Numoper  
      AND    rscorrela = @correla  
  
   END  
  
   SELECT mofecpro    = mofecpro  
      ,   monumdocu   = monumdocu  
      ,   mocorrela   = mocorrela  
      ,   morutemi    = morutemi  
      ,   morutcli    = morutcli  
      ,   mocodcli    = mocodcli  
      ,   movpresen   = movpresen  
      ,   monominal   = monominal  
      ,   motir       = motir  
      ,   moforpagv   = moforpagv  
      ,   momonpact   = momonpact  
      ,   momonemi    = momonemi  
      ,   mocodigo    = mocodigo  
      ,   mofecvenp   = mofecvenp  
      ,   mofecinip   = mofecinip  
      ,   moforpagi   = moforpagi  
   ,      sw          = 'N'  
   INTO   #TMP_CAP  
   FROM   BactraderSuda.dbo.MDMO  
   WHERE  mofecpro    = @dFecPro  
   AND    motipoper   = 'RV'  
   AND    monominal   > 0  
   AND    mostatreg   = ''  
   AND    monumdocu   NOT IN(SELECT numero_operacion FROM BacLineas.dbo.LINEAS_RETENIDAS WHERE id_sistema = 'BTR') --> Se agrega control para Liberacion Manual  
  
   INSERT INTO BacLineas.dbo.LINEAS_RETENIDAS  
   SELECT mofecpro  
   ,      'BTR'  
   ,      'CI'  
   ,      'CI'  
   ,      monumdocu  
   ,      morutemi  
   ,      1  
   ,      morutcli  
   ,      mocodcli  
   ,      CASE WHEN mnextranj = 0 then movpresen                     -- Pesos,Uf,Dolar Obs, Dolar Acur.  
               ELSE                   round((movpresen * vmvalor),4) -- Moneda Extr.  
          END  
   ,      monominal  
   ,      movpresen  
   ,      motir  
   ,      0.0  
   ,      moforpagv  
   ,      mofecpro  
   ,      'N'  
   FROM   #TMP_CAP  
          LEFT JOIN BacParamSuda.dbo.MONEDA       ON mncodmon = momonpact  
          LEFT JOIN BacParamSuda.dbo.VALOR_MONEDA ON vmfecha  = @dFecAnt AND vmcodigo = CASE WHEN momonpact = 13  THEN 994  
                                                                          when momonpact = 999 then 994   
                                                                          else momonpact   
                                                                                        END  
  
   SELECT monumdocu  
   ,      MIN(mocorrela) AS mocorrela  
   ,      MIN(morutcli)  AS morutcli   
   ,      MIN(mocodcli)  AS mocodcli   
   ,      SUM(movpresen) AS movpresen  
   ,      MIN(momonemi)  AS momonemi  
   ,      MIN(mocodigo)  AS mocodigo  
   ,      MIN(mofecvenp) AS mofecvenp  
   ,      MIN(mofecinip) AS mofecinip  
   ,      MIN(moforpagi) AS moforpagi  
   ,      MIN(momonpact) AS momonpact  
   ,      sw             = 'N'  
   INTO   #TMP_CAP_01  
   FROM   #TMP_CAP  
   GROUP BY monumdocu  
  
   SELECT @nRegs = COUNT(1)  
   FROM   #TMP_CAP_01  
  
   WHILE 1 = 1  
   BEGIN    
  
      SET @seriado = '*'  
      SET ROWCOUNT 1  
  
      SELECT @Numoper  = monumdocu  
      ,      @correla  = mocorrela  
      ,      @rut      = morutcli  
      ,      @CodCli   = mocodcli  
      ,      @MtoMda1  = CASE WHEN mnextranj = 0 then movpresen  
                              ELSE                   round((movpresen * vmvalor),4)  
                         END  
      ,      @moneda   = momonemi  
      ,      @codigo   = mocodigo  
      ,      @seriado  = 'N'  
      ,      @fecvcto  = CONVERT(CHAR(8),mofecvenp,112)  
      ,      @fechini  = CONVERT(CHAR(8),mofecinip,112)  
      ,      @nDolar   = (SELECT c.vmvalor FROM bacparamsuda..VALOR_MONEDA c WHERE c.vmcodigo = 994 and c.vmfecha = @dFecAnt)  
      ,      @nforpago = moforpagi  
      ,      @nmoneda  = momonpact  
      FROM   #TMP_CAP_01  
             LEFT JOIN BacParamSuda.dbo.MONEDA       ON mncodmon = momonpact  
             LEFT JOIN BacParamSuda.dbo.VALOR_MONEDA ON vmfecha = @dFecAnt AND vmcodigo = CASE WHEN momonpact = 13  THEN 994  
   when momonpact = 999 then 994   
                                                                               else momonpact   
                                                                                          END  
             INNER JOIN BacLineas.dbo.LINEAS_RETENIDAS ON id_sistema = 'BTR' AND numero_operacion = monumdocu AND estado_liberacion = 'N'  
      WHERE  sw        = 'N'  
  
      SET ROWCOUNT 0  
  
      IF @seriado = '*'   
         BREAK  
  
      IF @MtoMda1 > 0   
      BEGIN  
         INSERT INTO DATOSLINGRABAR  
         SELECT  @dfecproc  
         ,       'BTR'  
         ,       'CI'  
         ,       @Rut  
         ,       @codcli  
         ,       @Numoper  
         ,       @Numoper  
         ,       @correla  
         ,       @fechini  
         ,       @MtoMda1  
         ,       @nDolar  
         ,       @fecvcto  
         ,       ''  
         ,       @nmoneda  
         ,       'N'  
         ,       @codigo  
         ,       @nforpago  
         ,       0  
         ,       0  
  
         EXECUTE BacLineas.dbo.SP_LINEAS_GRABAR  
                 @dfecproc  
         ,       'BTR'  
         ,       'CI'  
         ,       @Rut  
         ,       @codcli  
         ,       @Numoper  
         ,       @Numoper  
         ,       @correla  
         ,       @fechini  
         ,       @MtoMda1  
         ,       @nDolar  
         ,       @fecvcto  
         ,       ''  
         ,       @nmoneda  
         ,       'N'  
         ,       @codigo  
         ,       @nforpago  
  
         UPDATE bactradersuda..MDMO  
         SET  mostatreg = ''  
         WHERE  monumoper = @Numoper  
         AND monumdocu = @Numoper  
  
   END  
  
   UPDATE #TMP_CAP_01  
   SET    sw        = 'S'  
 WHERE  monumdocu = @Numoper  
   AND    mocorrela = @correla  
   END   
  
  
   -->      
   SELECT *   
   ,      identity(int) as Identificador  
   INTO   #TmpRentaFija  
   FROM   DATOSLINGRABAR  
   WHERE  dFecPro     <  @dfecproc  
   and    dFecvctop   >= @dfecproc  
  
   declare @iRegistros       Integer  
   DECLARE @iRegistro        Integer  
   DECLARE @1_dFecPro        DATETIME  
   DECLARE @1_cSistema       CHAR(03)  
   DECLARE @1_cProducto      CHAR(05)  
   DECLARE @1_nRutcli       NUMERIC(09,0)  
   DECLARE @1_nCodigo       NUMERIC(09,0)  
   DECLARE @1_nNumoper       NUMERIC(10,0)  
   DECLARE @1_nNumdocu       NUMERIC(10,0)  
   DECLARE @1_nCorrela       NUMERIC(10,0)  
   DECLARE @1_dFeciniop      DATETIME  
   DECLARE @1_nMonto        NUMERIC(19,4)  
   DECLARE @1_fTipcambio     NUMERIC(08,4)  
   DECLARE @1_dFecvctop      DATETIME  
   DECLARE @1_cUsuario       CHAR(10)  
   DECLARE @1_cMonedaOp      NUMERIC(05,00)  
   DECLARE @1_cTipo_Riesgo   CHAR(1)  
   DECLARE @1_incodigo      NUMERIC(5)  
   DECLARE @1_formapago      NUMERIC(3)  
   DECLARE @1_nContraMoneda  NUMERIC(03)  
   DECLARE @1_nMonedaOpera   NUMERIC(03)  
  
   select  @iRegistros = max(Identificador)  
   ,       @iRegistro  = 1  
   from    #TmpRentaFija  
  
  
   while @iRegistros >= @iRegistro  
   begin  
      select @1_dFecPro        = dFecPro  
      ,      @1_cSistema       = cSistema  
      ,      @1_cProducto      = cProducto  
      ,      @1_nRutcli        = nRutcli  
      ,      @1_nCodigo        = nCodigo  
      ,      @1_nNumoper       = nNumoper  
      ,      @1_nNumdocu       = nNumdocu  
      ,      @1_nCorrela       = nCorrela  
      ,      @1_dFeciniop      = dFeciniop  
      ,      @1_nMonto         = nMonto  
      ,      @1_fTipcambio     = fTipcambio  
      ,      @1_dFecvctop      = dFecvctop  
      ,      @1_cUsuario       = cUsuario  
      ,      @1_cMonedaOp      = cMonedaOp  
      ,      @1_cTipo_Riesgo   = cTipo_Riesgo  
      ,      @1_incodigo       = incodigo  
      ,      @1_formapago      = formapago  
      ,      @1_nContraMoneda  = nContraMoneda  
      ,      @1_nMonedaOpera   = nMonedaOpera  
      from   #TmpRentaFija   
      where  Identificador = @iRegistro  
  
      EXECUTE BacLineas.dbo.SP_LINEAS_GRABAR  
   @1_dFecPro  
      ,      @1_cSistema  
      ,      @1_cProducto  
      ,      @1_nRutcli  
      ,      @1_nCodigo  
      ,      @1_nNumoper  
      ,      @1_nNumdocu  
      ,      @1_nCorrela  
      ,      @1_dFeciniop  
      ,      @1_nMonto  
      ,      @1_fTipcambio  
      ,      @1_dFecvctop  
      ,      @1_cUsuario  
      ,      @1_cMonedaOp  
      ,      @1_cTipo_Riesgo  
      ,      @1_incodigo  
      ,      @1_formapago  
      ,      @1_nContraMoneda  
      ,      @1_nMonedaOpera  
  
      set @iRegistro = @iRegistro + 1   
   end  
  
   EXECUTE BacLineas.dbo.SP_LINEAS_ACTUALIZA  
   EXECUTE BacLineas.dbo.SP_RECALCULA_GENERAL  
  
   SELECT MIN(Fecha)             AS Fecha  
   ,      MIN(id_sistema)        AS id_sistema  
   ,      MIN(codigo_producto)   AS codigo_producto  
   ,      MIN(tipo_operacion)    AS tipo_operacion  
   ,      numero_operacion       AS numero_operacion  
   ,      MIN(rut_emisor)        AS rut_emisor  
   ,      MIN(cod_emisor)        AS cod_emisor  
   ,      MIN(rut_cliente)       AS rut_cliente  
   ,      MIN(cod_cliente)       AS cod_cliente  
   ,      SUM(monto_linea)       AS monto_linea  
   ,      SUM(monto_operacion)   AS monto_operacion  
   ,      SUM(monto_pesos)       AS monto_pesos  
   ,      AVG(tir)               AS tir  
   ,      AVG(porcentaje)        AS porcentaje  
   ,      MIN(forma_pago)        AS forma_pago  
   ,      MIN(fecha_pago)        AS fecha_pago  
   ,      MIN(estado_liberacion) AS estado_liberacion  
   INTO   #TEMP  
   FROM   BacLineas.dbo.LINEAS_RETENIDAS   
   WHERE  id_sistema      = 'BTR'  
   AND    codigo_producto = 'CI'  
   AND    Fecha           = @dFecPro   
   GROUP BY numero_operacion  
  
   DELETE FROM BacLineas.dbo.LINEAS_RETENIDAS   
   WHERE  id_sistema      = 'BTR'  
   AND    codigo_producto = 'CI'  
   AND    Fecha           = @dFecPro   
  
   INSERT INTO BacLineas.dbo.LINEAS_RETENIDAS   
   SELECT * FROM #TEMP  
  
END
GO
