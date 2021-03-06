USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_P40_BANCO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_INTERFAZ_P40_BANCO]
   ( @Fecha_Interfaz   DATETIME   )  
AS  
BEGIN   
  
   SET NOCOUNT ON  
  
   DECLARE @Fecha_Proceso   DATETIME  
   DECLARE @rut_entidad     VARCHAR(12)  
   DECLARE @RutCorpBanca    VARCHAR(12)  
   DECLARE @fecha_desde     DATETIME  
   DECLARE @fecha_hasta     DATETIME  
   DECLARE @codigo_banco    VARCHAR(3)  
   DECLARE @dFechaProxima   DATETIME  
  
   SELECT  @Fecha_Proceso   = acfecproc  
      ,    @rut_entidad     = acrutprop  
      ,    @RutCorpBanca    = LTRIM(RTRIM(acrutprop)) + LTRIM(RTRIM(cldv))  
   FROM    MDAC             with(nolock)  
           INNER JOIN BacParamSuda..CLIENTE with(nolock) ON clrut = acrutprop and clcodigo = 1  
  
       SET @dFechaProxima = @Fecha_Interfaz  
   EXECUTE SP_BUSCA_FECHA_HABIL @dFechaProxima, 1, @dFechaProxima OUTPUT  
  
  
   CREATE TABLE #TABLA_P40   
   (    Tipo_Registro          varchar(2)     NOT NULL ,       --1  
 Codigo_Tenedor         varchar(12)    NOT NULL ,       --2  
 Fecha_Proceso          char(8)            NULL ,       --3  
 Fecha_Compra           char(10)           NULL ,       --4  
 Tipo_Cartera           numeric(5, 0)  NOT NULL ,       --5  
 Emisor                 varchar (11)       NULL ,       --6  
 Pais_Emisor            INTEGER        NOT NULL ,       --7  
 Familia_Instrumento    VARCHAR(2)     NOT NULL ,       --8  
 Nemotecnico            char (20)          NULL ,       --9  
 Tipo_Rendimiento       int            NOT NULL ,       --10  
 Periodicidad_Cupon     decimal(5, 0)      NULL ,       --11  
 Fecha_Ultimo_Cupon     char (8)           NULL ,       --12  
 Fecha_Proximo_Cupon    char (8)           NULL ,       --13  
 Fecha_Vcto_Instr       char (8)           NULL ,       --14  
 Derivado_Incrust_Opc   char(2)        NOT NULL ,       --15  
 Nominal_Inicial        numeric(19, 4)     NULL ,       --16  
 Nominal_Actual         numeric(19, 4)     NULL ,       --17  
 Moneda_Emision         numeric(3, 0)  NOT NULL ,       --18  
 Moneda_Reajuste        VARCHAR(4)     NOT NULL ,       --19  
 Tipo_Tasa_Emision      char(7)            NULL ,       --20  
 Tasa_Emision           numeric(9, 4)  NOT NULL ,       --21  
 Tera                   decimal(8, 4)      NULL ,       --22  
 Valor_Par              numeric(18,4)      NULL ,       --23  
 Tipo_Tasa_Compra       char(7)            NULL ,       --24  
 Tasa_Compra            numeric(9, 4)  NOT NULL ,       --25  
 Costo_Adquisicion      numeric(19, 4) NOT NULL ,       --26  
 Costo_Amortizado       numeric(14, 0)     NULL ,       --27  
 Valor_Razonable        numeric(19, 4)     NULL ,       --28  
 Tipo_Tasa_Valoriza     char(7)            NULL ,       --29  
 Tasa_Valorizacion      numeric(19, 4)     NULL ,       --30  
 Tipo_valorizacion      int            NOT NULL ,       --31  
 Precio_Instrumento     numeric(6, 2)  NOT NULL ,       --32 (19, 8)  
 Duracion_Modificada    NUMERIC(24,8)  NOT NULL , --float          NOT NULL ,       --33  
 Convexidad             NUMERIC(24,8)  NOT NULL , --float          NOT NULL ,       --34  
 Valor_Deterioro        numeric(14, 0)     NULL ,       --35  
 Condicion_Instrumento  int            NOT NULL ,       --36  
 Fecha_Inicio_Cond      char (8)           NULL ,       --37  
 Fecha_Final_Cond       char (8)           NULL ,       --38  
 Filler                 varchar (1)    NOT NULL ,                 
 numero_Documento       numeric(10, 0) NOT NULL ,    
 Correlativo            numeric(10, 0) NOT NULL ,  
 Numero_Operacion       numeric(10, 0) NOT NULL ,  
        Seriado                CHAR(1)        NOT NULL ,  
        Codigo                 INTEGER        NOT NULL ,  
        Serie                  VARCHAR(20)    NOT NULL ,  
        FecCupVen              DATETIME       NOT NULL ,  
        FechaEmision           DATETIME       NOT NULL ,  
        NomOriginal     NUMERIC(21,4)  NOT NULL ,  
   )   
  
   CREATE TABLE #CUOTAS_FONDOS_MUTUOS  
   ( tipo_registro            NUMERIC(2)  --1  
   , codigo_tenedor           CHAR(3)     --2  
   , fecha                    DATETIME    --3  
   , fecha_compra   DATETIME    --4  
  , administradora_fondo     CHAR(10)    --5  
   , pais_fondo               NUMERIC(3)  --6  
   , tipo_fondo               NUMERIC(1)  --7  
   , numero_cuotas_mantenidas NUMERIC(14) --8  
   , moneda                   NUMERIC(3)  --9  
   , valor_inicial_cuota      FLOAT       --10  
   , valor_cuota              FLOAT       --11  
   , valor_razonable          FLOAT       --12  
   , serie_fmutuo             CHAR(12)  
   )  
  
   DECLARE @fecha_desde_aux      DATETIME  
   DECLARE @fecha_hasta_aux      DATETIME  
  
       SET @fecha_desde_aux = @fecha_desde  
       SET @fecha_hasta_aux = @fecha_hasta  
  
   SELECT  MDRS.*   
   INTO    #MDRS_TMP  
   FROM    MDRS   
   WHERE   rsfecha    = @dFechaProxima --< @Fecha_Interfaz  
   AND    rstipoper  = 'DEV'  
   AND    rscartera  IN('111', '114')  
   AND    rsnominal  > 0  
   AND    rscodigo  <> 98   
   AND NOT(rscodigo   = 20 AND rsrutemis = @rut_entidad)  
and  rsfecvcto >= @dFechaProxima  
  
   INSERT INTO  #TABLA_P40  
   SELECT 'Tipo_Registro'  = '01'                                                 -- 1  
   ,   'Codigo_Tenedor'  = @RutCorpBanca --> 27 --> Cod_Inst                    -- 2 --> '000'  
   ,   'Fecha_Proceso'  = CONVERT(CHAR(8),@Fecha_Interfaz,112)                 -- 3 CONVERT(CHAR(08),@Fecha_Proceso,112)                 --3  
   ,   'Fecha_Compra'  = CONVERT(CHAR(10),rsfeccomp,112)                      -- 4  
   ,   'Tipo_Cartera'  = rstipcart                                            -- 5  
   ,   'Emisor'   = LTRIM(RTRIM(STR(rsrutemis)))+ emdv                   -- 6  
   ,   'Pais_Emisor'   = 160                                                  -- 7  
   ,   'Familia_Instrumento'  = CASE WHEN emrut = 97029000 OR emrut = 60805000 THEN '01'  
                                        WHEN emrut = 61533000      THEN '03'   
                                        WHEN rscodigo = 20     THEN '04'  
                                        WHEN rscodigo IN (9,11)     THEN '10'  
                                        WHEN rscodigo = 15 AND emtipo = 1    THEN '06'  
                                        WHEN rscodigo = 15 AND emtipo = 2    THEN '08'  
                                        WHEN rscodigo = 15 AND emtipo = 4    THEN '52'  
                                        ELSE '00'  
                                   END             -- Familia_instrumentos --8  
   ,   'Nemotecnico'   = CONVERT(CHAR(20),rsinstser)                         -- 09  
   ,   'Tipo_Rendimiento'  = CASE WHEN inmdse     = 'N'  THEN 1  
                                        WHEN secupones <= 1    THEN 1  
                                        WHEN senumamort = 1    THEN 2  
                                        WHEN incodigo   = 20   THEN 3  
                                        ELSE                        9  
                                   END  
   ,   'Periodicidad_Cupon'  = CASE WHEN inmdse = 'N' THEN 0   
                                        ELSE CASE WHEN sepervcup = 1  THEN 1  
                                                  WHEN sepervcup = 3  THEN 2  
                                                  WHEN sepervcup = 4  THEN 3  
                                                  WHEN sepervcup = 6  THEN 4  
                                                  WHEN sepervcup = 12 THEN 5   
                                                  ELSE 6  
          END   
                                   END                                                -- 11  
   ,   'Fecha_Ultimo_Cupon'  = CONVERT(CHAR(08),rsfecucup,112)                    -- 12  
   ,   'Fecha_Proximo_Cupon'  = CONVERT(CHAR(08),rsfecpcup,112)                    -- 13  
   ,   'Fecha_Vcto_Instr'  = CONVERT(CHAR(08),rsfecvcto,112)                    -- 14  
   ,   'Derivado_Incrust_Opc' = CASE WHEN rscodigo = 20 THEN '02' ELSE '01' END    -- 15  
   ,   'Nominal_Inicial'  = CONVERT(NUMERIC(19,4),rsnominal)                   -- 16  
   ,   'Nominal_Actual'  = CONVERT(NUMERIC(19,4),rsnominal)   -- 17  
   ,   'Moneda_Emision'  = CASE WHEN rscodigo = 20 THEN 998 ELSE inmonemi END -- 18  
   ,   'Moneda_Reajuste'  = CASE WHEN rscodigo = 20 THEN 998 ELSE inmonemi END -- 19  
   ,   'Tipo_Tasa_Emision'  = CASE WHEN inmdse = 'N' THEN '1N9C000'   
                                        ELSE CASE WHEN DATEDIFF(DAY, VIEW_SERIE.sefecemi, VIEW_SERIE.sefecven) > 365 THEN '12PC000' ELSE '11PC000' END  
                                   END                                               -- 20 tipo_tasa_emision  
   ,   'Tasa_Emision'  = rstasemi                                           -- 21  
   ,   'Tera'   = CASE WHEN inmdse = 'N' THEN 0 ELSE setera END      -- 22  
   ,   'Valor_Par'   = MDRS.valor_tasa_emision     /*MDRS.valor_par*/     -- 23  
   ,   'Tipo_Tasa_Compra'  = CASE WHEN inmdse = 'N' THEN '1N9C000'   
                                        ELSE CASE WHEN DATEDIFF(DAY, VIEW_SERIE.sefecemi, VIEW_SERIE.sefecven) > 365 THEN '12PC000' ELSE '11PC000' END  
                                   END                                               -- 24   
   ,   'Tasa_Compra'   = rstir                                              -- 25  
   ,   'Costo_Adquisicion'  = rsvalcomp                                          -- 26  
   ,   'Costo_Amortizado'  = CASE WHEN MDRS.codigo_carterasuper = 'A' THEN rsvalcomp   
                                        ELSE                                     0   
                                   END                                                -- 27 --> CASE WHEN rstipcart = 3 THEN rsvalcomp ELSE 0 END  
   ,   'Valor_Razonable'  = valor_mercado                                      -- 28  
   ,   'Tipo_Tasa_Valoriza'  = CASE WHEN inmdse = 'N' THEN '1N9C000'   
                                        ELSE CASE WHEN DATEDIFF(DAY, VIEW_SERIE.sefecemi, VIEW_SERIE.sefecven) > 365 THEN '12PC000' ELSE '11PC000' END  
                                   END                                               -- 29 tipo_tasa_valoracion  
   ,   'Tasa_Valorizacion'  = ISNULL(tasa_mercado, 0)                            -- 30  
   ,   'Tipo_valorizacion'  = CASE WHEN OrigenCurva = 'MC' THEN 3 ELSE 2 END     -- 31  
   ,   'Precio_Instrumento'  = round(MDRS.Valor_Par,2)                            -- valor_presente      -- SACAR DESPUES DE VALORIZACION MERCADO --32  
   ,   'Duracion_Modificada'  = CONVERT(NUMERIC(24,8),isnull(Duration_Mod, 0))     -- SACAR DESPUES DE VALORIZACION MERCADO --33  
   ,   'Convexidad'   = CONVERT(NUMERIC(24,8),isnull(Convexidad,   0))     -- SACAR DESPUES DE VALORIZACION MERCADO --34  
   ,   'Valor_Deterioro'  = CONVERT(NUMERIC(14),0)                             -- 35  
   ,   'Condicion_Instrumento'= CASE WHEN rscartera ='111' THEN 1 ELSE 2 END       -- 36  
   ,   'Fecha_Inicio_Cond'  = CASE WHEN rscartera ='114' THEN CONVERT(CHAR(08),rsfecinip,112)  
                          ELSE '        '   
       END         --37  
   ,   'Fecha_Final_Cond'  = CASE WHEN rscartera ='114' THEN CONVERT(CHAR(08),rsfecvtop,112)  
                          ELSE '        '   
       END  
                                 --38  
   ,   'Filler'   = ' '  
   ,   'Numero_Documento'  = rsnumdocu  
   ,   'Correlativo'   = rscorrela  
   ,   'Numero_Operacion'  = CASE WHEN rscartera ='111' THEN rsnumdocu ELSE rsnumoper END  
   -->>>> Agregado para su uso mas adelante <<<<--  
   ,      'Seriado'              = inmdse  
   ,      'Codigo'               = incodigo  
   ,      'Serie'                = rsinstser  
   ,      'FecCupVen'            = rsfecucup  
   ,      'FechaEmision'         = rsfecemis  
   ,      'NomOriginal'          = rsnominal  
   -->>>> Agregado para su uso mas adelante <<<<--  
   FROM   #MDRS_TMP  AS MDRS  
          LEFT  JOIN VIEW_EMISOR           ON emrut    = rsrutemis  
          LEFT  JOIN VIEW_INSTRUMENTO      ON incodigo = rscodigo  
          LEFT  JOIN VIEW_SERIE            ON secodigo = rscodigo and seserie  = CASE WHEN rscodigo = 20 THEN SUBSTRING(rsinstser,1,6) ELSE rsinstser END  
          LEFT  JOIN BacParamSuda..CLIENTE ON clrut    = rsrutcli and clcodigo = rscodcli  
          LEFT  JOIN VALORIZACION_MERCADO ON fecha_valorizacion = @Fecha_Interfaz AND id_sistema = 'BTR'  
                                   AND rmnumdocu = rsnumdocu AND rmcorrela = rscorrela AND rsnumoper = rmnumoper AND tipo_operacion = CASE WHEN rscartera = '111' THEN 'CP' ELSE 'VI' END  
   WHERE   rsfecha      = @dFechaProxima --> @Fecha_Interfaz   
   AND    rstipoper    = 'DEV'  
   AND    rscartera   IN('111', '114')  
   AND    rsnominal    > 0   
   AND    rscodigo    <> 98   
   AND    NOT(rscodigo = 20 AND rsrutemis = @rut_entidad)  
  
      /************************************  
      actualiza  
      ************************************/  
       
      UPDATE #TABLA_P40   
         SET Moneda_Reajuste = CASE WHEN Moneda_Reajuste = 998 THEN '2'  
                                    WHEN Moneda_Reajuste = 997 THEN '3'  
                                    WHEN Moneda_Reajuste = 994 THEN '4'  
                                    WHEN Moneda_Reajuste = 994 THEN '4'  
                                    WHEN Moneda_Reajuste = 999 THEN 'CLP'  
                                    ELSE                            mnnemo  
                               END  
       FROM  BacParamSuda..MONEDA  
      WHERE  mncodmon        = Moneda_Reajuste  
  
  
      UPDATE #TABLA_P40   
         SET Tipo_Tasa_Emision = REPLACE(Tipo_Tasa_Emision, 'PC' , CASE WHEN sepervcup = 1  THEN '1'  
         WHEN sepervcup = 3  THEN '2'  
         WHEN sepervcup = 4  THEN '3'  
         WHEN sepervcup = 6  THEN '4'  
         WHEN sepervcup = 12 THEN '5'  
         ELSE '9'  
           END   
                                                                 + CASE WHEN sebasemi = 360 THEN '1'  
         WHEN sebasemi = 365 THEN '2'  
         WHEN sebasemi = 30  THEN '3'  
         ELSE '9'  
           END )  
  
         ,   Tipo_Tasa_Compra  = REPLACE(Tipo_Tasa_Compra,  'PC' , CASE WHEN sepervcup = 1  THEN '1'  
         WHEN sepervcup = 3  THEN '2'  
         WHEN sepervcup = 4  THEN '3'  
         WHEN sepervcup = 6  THEN '4'  
         WHEN sepervcup = 12 THEN '5'  
         ELSE '9'  
           END   
                                                                 + CASE WHEN sebasemi = 360 THEN '1'  
         WHEN sebasemi = 365 THEN '2'  
         WHEN sebasemi = 30  THEN '3'  
         ELSE '9'  
           END )  
  
         ,  Tipo_Tasa_Valoriza = REPLACE(Tipo_Tasa_Valoriza,'PC' , CASE WHEN sepervcup = 1  THEN '1'  
         WHEN sepervcup = 3  THEN '2'  
         WHEN sepervcup = 4  THEN '3'  
         WHEN sepervcup = 6  THEN '4'  
         WHEN sepervcup = 12 THEN '5'  
         ELSE '9'  
           END   
                                                                 + CASE WHEN sebasemi = 360 THEN '1'  
         WHEN sebasemi = 365 THEN '2'  
         WHEN sebasemi = 30  THEN '3'  
         ELSE '9'  
           END )  
      FROM  VIEW_SERIE   
      WHERE seserie            = CASE WHEN familia_instrumento = '04' THEN SUBSTRING(nemotecnico,1,6) ELSE nemotecnico END  
  
      UPDATE #TABLA_P40   
         SET Tipo_Tasa_Emision = REPLACE(Tipo_Tasa_Emision, 'C',  CASE WHEN nsbasemi = 360 THEN '1'  
                                                                       WHEN nsbasemi = 365 THEN '2'  
               WHEN nsbasemi = 30  THEN '3'  
               ELSE '9'  
           END),  
             Tipo_Tasa_Compra   = REPLACE(Tipo_Tasa_Compra, 'C',   CASE WHEN nsbasemi = 360 THEN '1'  
         WHEN nsbasemi = 365 THEN '2'  
         WHEN nsbasemi = 30  THEN '3'  
         ELSE '9'  
           END),  
             Tipo_Tasa_Valoriza = REPLACE(Tipo_Tasa_Valoriza, 'C', CASE WHEN nsbasemi = 360 THEN '1'  
         WHEN nsbasemi = 365 THEN '2'  
         WHEN nsbasemi = 30  THEN '3'  
         ELSE '9'  
           END)  
--             Nemotecnico = CASE WHEN nscodigo = 9  THEN 'FN' + SUBSTRING(bolsa,1,3) + '-' + SUBSTRING(nsserie,5,6)  
--           WHEN nscodigo = 11 THEN 'FU' + SUBSTRING(bolsa,1,3) + '-' + SUBSTRING(nsserie,5,6)  
--           ELSE   Nemotecnico  
--      END  
      FROM  VIEW_NOSERIE  
--      ,     BacParamSuda..SINACOFI  
      WHERE nsnumdocu             = numero_documento  
        AND nscorrela             = correlativo  
--        AND clrut            = nsrutemi  
  
--*======================================================================================================================= cambio  
      UPDATE #TABLA_P40   
         SET Nemotecnico = CASE WHEN nscodigo = 9  THEN 'FN' + SUBSTRING(bolsa,1,3) + '-' + SUBSTRING(nsserie,5,6)  
           WHEN nscodigo = 11 THEN 'FU' + SUBSTRING(bolsa,1,3) + '-' + SUBSTRING(nsserie,5,6)  
           ELSE                     Nemotecnico  
      END  
      FROM  VIEW_NOSERIE  
      ,     BacParamSuda..SINACOFI  
      WHERE nsnumdocu             = numero_documento  
        AND nscorrela             = correlativo  
        AND clrut            = nsrutemi  
  
  
      UPDATE #TABLA_P40   
         SET Tipo_Tasa_Emision    = REPLACE(Tipo_Tasa_Emision,  'N', CASE WHEN DATEDIFF(DAY, nsfecemi, nsfecven) > 365 THEN '2' ELSE '1' END )  
           , Tipo_Tasa_Compra     = REPLACE(Tipo_Tasa_Compra,   'N', CASE WHEN DATEDIFF(DAY, nsfecemi, nsfecven) > 365 THEN '2' ELSE '1' END )  
           , Tipo_Tasa_Valoriza   = REPLACE(Tipo_Tasa_Valoriza, 'N', CASE WHEN DATEDIFF(DAY, nsfecemi, nsfecven) > 365 THEN '2' ELSE '1' END )  
           , Moneda_Emision       = nsmonemi  
        FROM VIEW_NOSERIE  
--           , BacParamSuda..SINACOFI  
       WHERE nsnumdocu            = numero_documento  
         AND nscorrela            = correlativo  
--         AND clrut            = nsrutemi  
  
  
   /** Fondos Mutuos **/  
      SET @fecha_desde = @fecha_desde_aux  
      SET @fecha_hasta = @fecha_hasta_aux  
  
      INSERT INTO #CUOTAS_FONDOS_MUTUOS  
      (   tipo_registro  
      ,   codigo_tenedor  
      ,   fecha  
      ,   fecha_compra  
      ,   administradora_fondo  
      ,   pais_fondo  
      ,   tipo_fondo  
      ,   numero_cuotas_mantenidas  
      ,   moneda  
      ,   valor_inicial_cuota  
      ,   valor_cuota  
      ,   valor_razonable  
      ,   serie_fmutuo  
      )  
      SELECT '02'                              --(1)Tipo de Registro  
      ,      ''                                --(2)Codigo Tenedor  
      ,      rsfecha                           --(3)Fecha  
      ,      rsfeccomp                         --(4)Fecha de Compra  
      ,      CONVERT(VARCHAR(9),E.emrut) + CONVERT(VARCHAR(1),E.emdv)  --(5)Administradora de Fondo  
      ,      '160'                             --(6)Pais de Fondo  
      ,      CASE WHEN DATEDIFF(DAY, rsfecemis, rsfecvcto) >  90 AND DATEDIFF(DAY, rsfecemis, rsfecvcto) <= 365 THEN 2   
                  WHEN DATEDIFF(DAY, rsfecemis, rsfecvcto) <= 90 THEN 1   
                  WHEN DATEDIFF(DAY, rsfecemis, rsfecvcto) > 365 THEN 3   
                  ELSE 0   
             END                               --(7)Tipo de Fondo  
      ,      rsnominal                         --(8)Numero de Cuotas mantenidas  
      ,      rsmonemi                          --(9)Moneda  
      ,      rstir                             --(10)Valor Inicial Cuota  
      ,      rstir                             --(11)Valor Cuota  
      ,      (rsnominal * rstir)               --(12)Valor Razonable  
      ,      rsinstser  
      FROM   MDRS A  
 INNER JOIN VIEW_EMISOR E ON E.emrut = A.rsrutemis  
      WHERE  A.rsfecha   = @fecha_desde  
      AND    A.rscodigo  = 98   
  
      SET @fecha_desde = DATEADD(DAY,1,@Fecha_Interfaz)  
  
      UPDATE #TABLA_P40   
      SET    Fecha_Inicio_Cond   = CONVERT(CHAR(08),vifecinip,112) --> vifecinip  
      ,      Fecha_Final_Cond    = CONVERT(CHAR(08),vifecvenp,112) --> vifecvenp  
      FROM   MDVI                with(nolock)  
      WHERE  vinumoper           = numero_operacion  
  
      CREATE TABLE #FINAL (INTERFAZ_P40 VARCHAR (414))  
  
      UPDATE #TABLA_P40  
         SET Valor_Par       = Valor_Par / vmvalor  
        FROM BacParamSuda..VALOR_MONEDA  
       WHERE Moneda_Emision <> 999  
         AND vmfecha         = @Fecha_Proceso  
         AND vmcodigo        = Moneda_Emision  
              
      /**********************************************************************************************************************************************************  
                                                         FIN ACTUALIZACIONES DE CARTERA  
  
                                                FIN ACTUALIZACIONES DE DATOS DE LA SERIE Y CARTERA  
      **********************************************************************************************************************************************************/  
  
      UPDATE #TABLA_P40 SET Fecha_Inicio_Cond = CONVERT(CHAR(08), Fecha_Inicio_Cond, 112)  
      UPDATE #TABLA_P40 SET Fecha_Final_Cond  = CONVERT(CHAR(08), Fecha_Final_Cond,  112)  
      UPDATE #TABLA_P40 SET Fecha_Inicio_Cond = '00000000' WHERE Fecha_Inicio_Cond = ''  
      UPDATE #TABLA_P40 SET Fecha_Final_Cond  = '00000000' WHERE Fecha_Final_Cond  = ''  
  
      -->>>> Recalculo de los nominales  
      UPDATE #TABLA_P40  
         SET NOMINAL_ACTUAL  = (NOMINAL_ACTUAL * tdsaldo) / 100.0  
         ,   NOMINAL_INICIAL = (NOMINAL_ACTUAL * tdsaldo) / 100.0  
        FROM #TABLA_P40  
             INNER JOIN BacParamSuda..TABLA_DESARROLLO ON tdmascara = Serie AND tdfecven = FecCupVen  
       WHERE Seriado         = 'S'  
       AND   codigo         <> 20   
  
      SELECT nominal_actual  
         ,   Seriado  
         ,   FecCupVen  
         ,   FechaEmision  
         ,   Codigo  
         ,   Serie  
         ,   Numero_Documento  
         ,   Correlativo  
         ,   Numero_Operacion  
         ,   Puntero  = Identity(Int)  
      INTO   #TMP_PASO_CALCULO  
      FROM   #TABLA_P40  
      WHERE  Seriado  = 'S'  
      AND    codigo   = 20   
  
      DECLARE @iRegistros   NUMERIC(9)  
          SET @iRegistros   = (SELECT MAX(Puntero) FROM #TMP_PASO_CALCULO)  
      DECLARE @iContador    NUMERIC(9)  
          SET @iContador    = (SELECT MIN(Puntero) FROM #TMP_PASO_CALCULO)  
  
      DECLARE @nNominal     NUMERIC(21,4)  
      DECLARE @Serie        VARCHAR(12)  
      DECLARE @FecEmision   DATETIME  
      DECLARE @dFecCucup    DATETIME  
      DECLARE @Documento    NUMERIC(9)  
      DECLARE @Correlativo  NUMERIC(9)  
      DECLARE @Operacion    NUMERIC(9)  
      DECLARE @xNominal     NUMERIC(21,4)  
  
      WHILE @iRegistros >= @iContador  
      BEGIN  
         SELECT @nNominal     = nominal_actual  
         ,      @Serie        = Serie  
         ,      @FecEmision   = FechaEmision  
         ,      @dFecCucup    = FecCupVen  
         ,      @Documento    = Numero_Documento  
         ,      @Correlativo  = Correlativo  
         ,      @Operacion    = Numero_Operacion  
         FROM   #TMP_PASO_CALCULO  
         WHERE  Puntero       = @iContador  
  
         EXECUTE BacTraderSuda.dbo.SP_RETORNA_NOMINAL_P40_LCHR @nNominal, @Serie, @FecEmision, @dFecCucup, @xNominal OUTPUT  
  
         UPDATE #TABLA_P40  
            SET NOMINAL_ACTUAL    = @xNominal  
              , NOMINAL_INICIAL   = @xNominal  
          WHERE Numero_Documento  = @Documento  
            AND Correlativo       = @Correlativo  
           AND Numero_Operacion  = @Operacion  
            AND Seriado           = 'S'  
            AND Codigo            = 20  
            AND Serie             = @Serie  
  
         SET @iContador = @iContador + 1  
      END  
      -->>>> Recalculo de los nominales  
  
      DECLARE @iCantidad   NUMERIC(9)  
          SET @iCantidad   = (SELECT COUNT(1) FROM #TABLA_P40)  
  
      DECLARE @TOTALNOMINAL FLOAT  
          SET @TOTALNOMINAL = ISNULL((SELECT SUM(NOMINAL_ACTUAL) FROM #TABLA_P40), 0)  
  
      SELECT '01' = 'CL '                                                                                                         -- 01. Código ISO de País  
      ,      '02' = CONVERT(CHAR(08),Fecha_Proceso,112)                                                                           -- 02. Fecha de la Interfase  
      ,      '03' = 'ND15'+ SPACE(10)                        -- 03. Numero de identificador de la Fuente  
      ,      '04' = '001'                                                                                                         -- 04. Codigo de empresa  
      ,      '05' = LEFT('MD01' + SPACE(16),16)                                                                                   -- 05. Codigo interno de producto  
      ,      '06' = CONVERT(CHAR(08),Fecha_Proceso,112)                                                                           -- 06. Fecha Contable  
      ,      '08' = NUMERO_OPERACION                                                                                              --   
      ,      '09' = NUMERO_DOCUMENTO                                                                                              --   
      ,      '10' = CORRELATIVO                                                                                                   -- 07. Número de la operación   
      ,      '11' = CODIGO_TENEDOR                                                                                                -- 08. Identificacion del tenedor  
      ,      '12' = TIPO_REGISTRO                                                                                 -- 09. Tipo de Registro  
      ,      '13' = FAMILIA_INSTRUMENTO                                                                                           -- 10. Familia de instrumentos  
      ,      '14' = TIPO_RENDIMIENTO                                                                                              -- 11. Tipo Rendimiento  
      ,      '15' = CONVERT(CHAR(08),FECHA_PROXIMO_CUPON,112)                                                                     -- 12. FECHA DE PRóXIMO CORTE CUPóN  
      ,      '16' = DERIVADO_INCRUST_OPC                                                                                          -- 13. DERIVADOS INCRUSTADOS U OPCIONALIDAD  
      ,      '17' = NOMINAL_ACTUAL                                                                                                -- 14. NOMINAL ACTUAL  
      ,      '18' = MONEDA_REAJUSTE                                                                                               -- 15. MONEDA DE REAJUSTE  
      ,      '19' = TIPO_TASA_EMISION                                                                                             -- 16. TIPO DE TASA DE EMISIóN  
      ,      '20' = isnull(TERA,0)                                                                                                          -- 17. TERA  
      ,      '21' = VALOR_PAR                                                                                                     -- 18. VALOR PAR  
      ,      '22' = TIPO_TASA_COMPRA                                                                                              -- 19. TIPO DE TASA DE COMPRA  
      ,      '23' = TASA_COMPRA                                                                                                  -- 20. TASA DE COMPRA  
      ,      '24' = COSTO_ADQUISICION                                                  -- 21. COSTO DE ADQUISICIóN  
      ,      '25' = COSTO_AMORTIZADO                                                                                              -- 22. COSTO AMORTIZADO  
      ,      '26' = Tipo_Tasa_Valoriza                                                                                            -- 23. TIPO DE TASA DE VALORACIóN  

      ,      '27' = case	when Tasa_Valorizacion > 100 then Tasa_Valorizacion - abs((100 - Tasa_Valorizacion)-1)
							else Tasa_Valorizacion
						end																										-- 24. TASA DE VALORACIóN  
      ,      '28' = Tipo_valorizacion       -- 25. TIPO DE VALORACIóN  
      ,      '29' = PRECIO_INSTRUMENTO                                                                                            -- 26. PRECIO DEL INSTRUMENTO  
      ,      '30' = DURACION_MODIFICADA                                                          -- 27. DURACIóN MODIFICADA  
      ,      '31' = CONVEXIDAD                                                                                                    -- 28. CONVEXIDAD  
      ,      '32' = VALOR_DETERIORO                                                                                               -- 29. VALOR DE DETERIORO  
      ,      '33' = CONDICION_INSTRUMENTO                                                                                   -- 30. CONDICIóN DEL INSTRUMENTO  
      ,      '34' = CONVERT(CHAR(08),Fecha_Inicio_Cond,112)           -- 31. FECHA INICIO CONDICION  
      ,      '35' = CONVERT(CHAR(08),Fecha_Final_Cond,112)           -- 32. FECHA FINAL DE CONDICION  
      ,      '36' = CONVERT(VARCHAR(20),RTRIM(LTRIM(NEMOTECNICO)) + REPLICATE(' ', 20 - LEN(RTRIM(LTRIM(NEMOTECNICO))) ))         -- 33. NEOTECNICO DE INSTRUMENTO  

	  ,      '37' = CAST(NUMERO_DOCUMENTO AS VARCHAR(6)) +  CAST(CORRELATIVO AS VARCHAR(3))+ CAST(NUMERO_DOCUMENTO AS VARCHAR(6)) -- 34. Numero de Operacion REEMPLAZA 7  

      ,      '38' = @iCantidad  
      ,      '39' = CASE WHEN TASA_COMPRA       >= 0 THEN '+' ELSE '-' END                                                        -- 35. Signo Tasa Compra  
      ,      '40' = CASE WHEN Tasa_Valorizacion >= 0 THEN '+' ELSE '-' END                                                        -- 36. Signo Tasa Valorizacion  
      ,      '41' = @TOTALNOMINAL  
      FROM   #TABLA_P40  
      ORDER BY Fecha_Proceso   
      ,        CONDICION_INSTRUMENTO  
      ,        FAMILIA_INSTRUMENTO  
      ,        NUMERO_OPERACION  
      ,        NUMERO_DOCUMENTO  
      ,        CORRELATIVO  
  
   /*********************/  
   SET NOCOUNT OFF  
  
END  


GO
