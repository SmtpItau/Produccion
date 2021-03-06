USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_CONTABILIZA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LLENA_CONTABILIZA]    
   (   @Fecha_Hoy   DATETIME   )            
AS            
BEGIN            
-- SP_CONTABILIZACION_MAP '20150623'     
-- truncate table dbo.BAC_CNT_CONTABILIZA    
-- SP_LLENA_CONTABILIZA '20140131'    
 SET NOCOUNT ON            
    
 DECLARE @Control_Error    INT    
 DECLARE @valor_observado  FLOAT    
 DECLARE @SwapTasa         INT    
 DECLARE @SwapMoneda       INT    
 DECLARE @FechaAnt         DATETIME    
 DECLARE @PrimerDiaMes     CHAR(08)    
 DECLARE @UltimoDiaMes     CHAR(08)    
 DECLARE @fecha_FinMes     CHAR(08)    
    
 DECLARE @dFechaMvt        DATETIME    
  SET @dFechaMvt        = @Fecha_Hoy    
    
 DECLARE @dFechaAnterior   DATETIME    
 DECLARE @dFechaProceso    DATETIME    
 DECLARE @dFechaProxima    DATETIME    
    
 SELECT @dFechaAnterior   = fechaant    
      ,  @dFechaProceso    = fechaproc    
      ,  @dFechaProxima    = fechaprox    
 FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock)    
            
 IF NOT EXISTS( SELECT 1 FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock)    
       WHERE Fecha = @dFechaProceso AND Codigo_Moneda <> 0 AND Tipo_Cambio <> 0 )    
 BEGIN            
  RAISERROR('¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY. !', 16, 6, 'ERROR.')    
  RETURN    
 END    
    
 TRUNCATE TABLE BAC_CNT_CONTABILIZA    
    
 --<< Tipos de Swaps segun MDTC    
 SET @SwapTasa        = 1    
 SET @SwapMoneda      = 2    
 SET @valor_observado = ( SELECT ISNULL(vmvalor,0.0) FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmfecha = @Fecha_Hoy AND vmcodigo = 994 )    
    
 --> Identifica si estamos en Fin de Mes Especial <--    
 DECLARE @FechaProximo   DATETIME    
 DECLARE @FechaHoy       DATETIME    
 DECLARE @FechaFinMes    DATETIME    
 DECLARE @FechaHasta     DATETIME    
    
 SET @FechaAnt       = @dFechaAnterior    
 SET @FechaHoy       = @dFechaProceso    
 SET @FechaProximo   = @dFechaProxima    
    
 SET @FechaFinMes = LTRIM(RTRIM(YEAR(@FechaHoy)))    
      + CASE WHEN LEN(MONTH(@FechaHoy)) = 1 THEN '0' + LTRIM(RTRIM(MONTH(@FechaHoy)))    
        ELSE                                      LTRIM(RTRIM(MONTH(@FechaHoy)))    
       END    
      + '01'    
 SET @FechaFinMes = DATEADD(MONTH,1,@FechaFinMes)    
 SET @FechaFinMes = DATEADD(DAY,-1,@FechaFinMes)    
 SET @FechaHasta  = @FechaHoy    
    
 IF MONTH(@FechaHoy) < MONTH(@FechaProximo)    
 BEGIN    
  IF @FechaFinMes <> @FechaHoy    
  BEGIN --> Fin de Mes Especial (Fin de Día un Día NO Habil)    
   SET @FechaHasta = @FechaHoy    
   SET @fecha_hoy  = @FechaFinMes    
  END    
 END    
   --> Identifica si estamos en Fin de Mes Especial <--            
    
 DECLARE @FechaValorMoneda DATETIME    
 DECLARE @FechaValorMonAye DATETIME    
    
 EXECUTE BacParamSuda..SP_FECHA_VALOR_MONEDA @Fecha_Hoy , @FechaValorMoneda OUTPUT    
 EXECUTE BacParamSuda..SP_FECHA_VALOR_MONEDA @FechaAnt  , @FechaValorMonAye OUTPUT    
    
 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * */            
 CREATE TABLE #VALOR_MONEDA    
  (   vmfecha      DATETIME NOT NULL DEFAULT('')    
  ,   vmcodigo     INTEGER  NOT NULL DEFAULT(0)    
  ,   vmvalor      FLOAT    NOT NULL DEFAULT(0.0)    
  /*  CONSTRAINT [Pk_#VALOR_MONEDA] PRIMARY KEY NONCLUSTERED    
   (   vmfecha, vmcodigo ) ON [PRIMARY] */    
  )   ON [PRIMARY]    
    
 INSERT INTO #VALOR_MONEDA SELECT vmfecha,         vmcodigo, vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE (vmfecha = @dFechaProceso OR vmfecha = @dFechaAnterior) AND vmcodigo NOT IN(998, 13)    
 INSERT INTO #VALOR_MONEDA SELECT @dFechaProceso,  vmcodigo, vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmfecha  = @FechaValorMoneda AND vmcodigo = 998    
 INSERT INTO #VALOR_MONEDA SELECT @dFechaAnterior, vmcodigo, vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmfecha  = @FechaValorMonAye AND vmcodigo = 998    
 INSERT INTO #VALOR_MONEDA SELECT @dFechaProceso,  999,      1.0    
 INSERT INTO #VALOR_MONEDA SELECT @dFechaAnterior, 999,      1.0    
 INSERT INTO #VALOR_MONEDA SELECT vmfecha,         13,       vmvalor FROM #VALOR_MONEDA                 WHERE vmcodigo = 994    
 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * */            
    
  CREATE TABLE #VALOR_MONEDA_LIQUIDACION    
  (   vmfecha      DATETIME NOT NULL DEFAULT('')    
  ,   vmcodigo     INTEGER  NOT NULL DEFAULT(0)    
  ,   vmvalor      FLOAT    NOT NULL DEFAULT(0.0)    
  /*  CONSTRAINT [Pk_#VALOR_MONEDA] PRIMARY KEY NONCLUSTERED    
   (   vmfecha, vmcodigo ) ON [PRIMARY] */    
  )   ON [PRIMARY]    
    
 INSERT INTO #VALOR_MONEDA_LIQUIDACION SELECT vmfecha,         vmcodigo, vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE (vmfecha = @dFechaProceso OR vmfecha = @dFechaAnterior) AND vmcodigo NOT IN(998, 13)    
 INSERT INTO #VALOR_MONEDA_LIQUIDACION SELECT @dFechaProceso,  vmcodigo, vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmfecha  = @dFechaProceso AND vmcodigo = 998    
 INSERT INTO #VALOR_MONEDA_LIQUIDACION SELECT @dFechaAnterior, vmcodigo, vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmfecha  = @FechaValorMonAye AND vmcodigo = 998    
 INSERT INTO #VALOR_MONEDA_LIQUIDACION SELECT @dFechaProceso,  999,      1.0    
 INSERT INTO #VALOR_MONEDA_LIQUIDACION SELECT @dFechaAnterior, 999,      1.0    
 INSERT INTO #VALOR_MONEDA_LIQUIDACION SELECT vmfecha,         13,       vmvalor FROM #VALOR_MONEDA                 WHERE vmcodigo = 994    
    
    
    
    
    
    
 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * */            
 -- CREA TABLA DE VALORES DE MONEDA NO REAJUSTABLES Tipo Cambio Contable --            
 CREATE TABLE #VALOR_TC_CONTABLE            
  (   vmfecha   DATETIME   NOT NULL DEFAULT('')            
  ,   vmcodigo  INTEGER    NOT NULL DEFAULT(0)            
  ,   vmvalor   FLOAT      NOT NULL DEFAULT(0.0)            
  /* CONSTRAINT [PK_TCCNT] PRIMARY KEY NONCLUSTERED    
   (   vmfecha,   vmcodigo   )   ON [PRIMARY] */    
  ) ON [PRIMARY]    
            
 INSERT INTO #VALOR_TC_CONTABLE    
 SELECT Fecha    
  ,   CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END    
  ,   Tipo_Cambio    
 FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE    
 WHERE (Fecha         = @dFechaAnterior OR Fecha = @dFechaProceso)    
    AND    Codigo_Moneda NOT IN(13,995,997,998,999)    
                  
 INSERT INTO #VALOR_TC_CONTABLE     
 SELECT vmfecha, vmcodigo, vmvalor FROM #VALOR_MONEDA WHERE vmcodigo IN(994,995,997,998,999)    
 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * */            
            
   /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * */            
 CREATE TABLE #CARTERA    
  (   numero_operacion         NUMERIC(9)  NOT NULL DEFAULT(0)    
  ,   numero_flujo             NUMERIC(9)  NOT NULL DEFAULT(0)    
  ,   tipo_flujo               INT   NOT NULL DEFAULT(0)    
  ,   tipo_swap                INT   NOT NULL DEFAULT(0)    
  ,   cartera_inversion        INT   NOT NULL DEFAULT(0)    
  ,   tipo_operacion           CHAR(1)  NOT NULL DEFAULT('')    
  ,   fecha_cierre             DATETIME  NOT NULL DEFAULT('')    
  ,   fecha_termino            DATETIME  NOT NULL DEFAULT('')    
  ,   FechaLiquidacion         DATETIME  NOT NULL DEFAULT('')    
  ,   fecha_inicio_flujo       DATETIME  NOT NULL DEFAULT('')    
  ,   fecha_vence_flujo        DATETIME  NOT NULL DEFAULT('')    
  ,   modalidad_pago           CHAR(1)  NOT NULL DEFAULT('')    
  ,   compra_capital           FLOAT   NOT NULL DEFAULT(0.0)    
  ,   compra_moneda            INT   NOT NULL DEFAULT(0)    
  ,   compra_amortiza          FLOAT   NOT NULL DEFAULT(0.0)    
  ,   compra_saldo             FLOAT   NOT NULL DEFAULT(0.0)    
  ,   compra_Flujo_adicional   FLOAT   NOT NULL DEFAULT(0.0)    
  ,   compra_interes           FLOAT   NOT NULL DEFAULT(0.0)    
  ,   Recibimos_Moneda         INT   NOT NULL DEFAULT(0)    
  ,   Recibimos_documento      INT   NOT NULL DEFAULT(0)    
  ,   venta_moneda             INT   NOT NULL DEFAULT(0)    
  ,   venta_amortiza           FLOAT   NOT NULL DEFAULT(0.0)    
  ,   venta_saldo              FLOAT   NOT NULL DEFAULT(0.0)    
  ,   venta_flujo_Adicional    FLOAT   NOT NULL DEFAULT(0.0)    
  ,   venta_interes            FLOAT   NOT NULL DEFAULT(0.0)    
  ,   Pagamos_Moneda           INT   NOT NULL DEFAULT(0)    
  ,   Pagamos_documento        INT   NOT NULL DEFAULT(0)    
  ,   valor_razonableclp       FLOAT   NOT NULL DEFAULT(0.0)    
  ,   intercprinc              INT   NOT NULL DEFAULT(0)    ,   Estado_Flujo             INT   NOT NULL DEFAULT(0)    
  ,   estado      CHAR(5)  NOT NULL DEFAULT('')    
  ,   clpais                   INT   NOT NULL DEFAULT(0)    
  ,   car_Cartera_Normativa    CHAR(1)  NOT NULL DEFAULT('')    
  ,   car_SubCartera_Normativa INT   NOT NULL DEFAULT(0)      
  --,   Modificadahis            INT   NOT NULL DEFAULT(0)     
  ,   Modificadahoy            INT   NOT NULL DEFAULT(0)     
    CONSTRAINT [PK_CARTERA_CNT_A_tmp]   PRIMARY KEY CLUSTERED    
    (   Fecha_Cierre,   Tipo_Swap,   Tipo_Flujo,   Numero_Operacion,   Numero_Flujo ) ON [PRIMARY]    
 )   ON [PRIMARY]    
    
    
      INSERT INTO #CARTERA            
      SELECT numero_operacion            
      ,      numero_flujo            
      ,      tipo_flujo            
      ,      tipo_swap            
      ,      cartera_inversion            
      ,      tipo_operacion            
      ,      fecha_cierre            
      ,      fecha_termino            
      ,      FechaLiquidacion            
      ,      fecha_inicio_flujo            
      ,      fecha_vence_flujo            
      ,      modalidad_pago            
      ,      compra_capital            
      ,      compra_moneda            
      ,      compra_amortiza            
      ,      compra_saldo            
      ,      compra_Flujo_adicional            
      ,      compra_interes            
      ,      Recibimos_Moneda            
      ,  Recibimos_documento            
      ,      venta_moneda            
     ,      venta_amortiza            
      ,      venta_saldo            
      ,      venta_flujo_Adicional            
      ,      venta_interes            
      ,      Pagamos_Moneda            
      ,      Pagamos_documento            
      ,      valor_razonableclp            
      ,      intercprinc            
      ,      Estado_Flujo            
      ,      estado            
      ,      clpais            
      ,      car_Cartera_Normativa            
      ,      car_SubCartera_Normativa        
   ,      0          
      FROM   BacSwapSuda.dbo.CARTERA            
             LEFT JOIN BacParamSuda.dbo.CLIENTE with(nolock) ON clrut = rut_cliente AND clcodigo = codigo_cliente            
      WHERE  estado <> 'C'    
           
           
   /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * */            
    
        
    
 -- A T E N C I O N --    
 --  Observaciones para el Campo :    
 -- TipOper : V --> indica que Si contabiliza y No se informa en Balance.    
 --   : N --> indica que Si contabiliza y Si se informa en Balance.    
 --   : S --> indica que No contabiliza y Si se informa en Balance.    
 --  Filtro se Aplica en dbo.SP_CONTABILIZACION    
 -- A T E N C I O N --            
    
    
   --   ***********************************************   --            
   -->    UPDATE A TODAS LAS OPERACIONES QUE EXISTAN     <--            
   ---    EN LA CARTERA MODIFICADA EL DIA DE HOY         <--    
   --   ***********************************************   --     
        UPDATE OPE    
        SET Modificadahoy   = 1    
       FROM #Cartera OPE    
      WHERE numero_operacion IN  (SELECT DISTINCT CAR.numero_operacion    
                                       FROM #Cartera             CAR    
                                      INNER JOIN     
                                            BacSwapSuda.dbo.CARTERAMODIFICADAHIS HIS    
                                         ON HIS.numero_operacion = CAR.numero_operacion    
                                        AND HIS.FechaMod >= @fecha_hoy    
                                        AND HIS.FechaMod <  DATEADD(DD,1,@FechaHasta))    
    
    
    
    
    
    
   --   ***********************************************   --            
   -->    ( 0 ) Datos Inicio Swap Inicios                <--            
   --   ***********************************************   --            
    
    
    select Xnumero_operacion = numero_operacion , xFechaTerminoContable = max(fechaLiquidacion)    
     into #CarteraFechaTermino    
    from #Cartera     
    group by numero_operacion    
    
    Update #Cartera     
        Set fecha_termino  = xFechaTerminoContable    
     from #CarteraFechaTermino where #Cartera.numero_operacion = xnumero_operacion      
     
    
          
    
    --   ***********************************************   --            
   -->    MODIFICACION SWAP                               <--            
   --   ***********************************************   --       
        EXEC BacSwapSuda.dbo.SP_LLENA_CONTABILIZA_MODIFICA @fecha_hoy ,@FechaHasta ,@FechaAnt    
    
    
    
    
    
    
            
   --   Apertura de Tipo Flujos para Todos los Productos [CCS]            
   --     PRINT 'NORMAL - A'            
   INSERT INTO BAC_CNT_CONTABILIZA            
   (   id_sistema     , tipo_movimiento , tipo_operacion    , operacion        , correlativo     , codigo_instrumento      , moneda_instrumento     , tipo_cliente            , cartera_inversion            
   ,   compra_capital , venta_capital   , venta_capital_Ant , devengo_utilidad , devengo_perdida , Monto_diferido_utilidad , Monto_diferido_perdida , Monto_Utilidad_Valoriza , Monto_Perdida_Valoriza            
   ,   Compra_Interes , Venta_Interes   , compra_moneda     , venta_moneda            
   ,   TipOper        , SubCartera            
   )            
   SELECT 'id_sistema'                  = 'PCS'            
   ,      'tipo_movimiento'             = 'MOV'            
   ,      'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'C'            
   ,      'operacion'                   = c.Numero_Operacion            
   ,      'correlativo'                 = c.tipo_flujo            
   ,      'codigo_instrumento'          = ''            
   ,      'moneda_instrumento'          = CONVERT(CHAR(03),c.Compra_Moneda)            
   ,      'tipo_cliente'                = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
   ,      'cartera_inversion'           = c.cartera_inversion            
   ,      'compra_capital_200'          = (c.compra_amortiza + c.compra_saldo + c.compra_Flujo_adicional)            
   ,      'venta_capital_201'           = (c.compra_amortiza + c.compra_saldo + c.compra_Flujo_adicional)            
                                        * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.compra_moneda)            
   ,      'venta_capital_Ant_203'       = CASE WHEN c.fecha_cierre = @fecha_hoy THEN 0.0    
            ELSE                                  (c.compra_amortiza + c.compra_saldo + c.Compra_Flujo_Adicional )  -- MAP 20080429    
           END * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior  AND vmcodigo = c.compra_moneda)            
   ,      'devengo_utilidad_204'        = CASE WHEN c.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
   ,      'devengo_perdida_205'         = CASE WHEN c.Valor_RazonableCLP <  0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
            
   ,      'Monto_diferido_utilidad_206' = isnull(CASE WHEN c.fecha_cierre = @fecha_hoy and c.fecha_cierre > @dFechaAnterior THEN 0.0            
              ELSE ( SELECT CASE WHEN r.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(r.Valor_RazonableCLP,0)) ELSE 0.0 END    
                FROM CARTERARES r with(nolock)     
                WHERE r.Fecha_Proceso = @dFechaAnterior AND r.numero_operacion = c.numero_operacion AND r.numero_flujo = c.numero_flujo)    
             END,0)    
            
   ,      'Monto_diferido_perdida_207'  = isnull(CASE WHEN c.fecha_cierre = @fecha_hoy and c.fecha_cierre > @dFechaAnterior THEN 0.0            
              ELSE ( SELECT CASE WHEN r.Valor_RazonableCLP   < 0.0 THEN ABS(ROUND(r.Valor_RazonableCLP,0)) ELSE 0.0 END    
                FROM CARTERARES r with(nolock)    
                WHERE r.Fecha_Proceso = @dFechaAnterior AND r.numero_operacion = c.numero_operacion AND r.numero_flujo = c.numero_flujo)    
             END,0)            
   ,      'Monto_Utilidad_Valoriza_208' = CASE WHEN     (c.venta_interes - c.compra_interes) <  0.0 THEN 0.0            
            ELSE ABS((c.venta_interes - c.compra_interes))            
           END            
   ,      'Monto_Perdida_Valoriza_209'  = CASE WHEN     (c.venta_interes - c.compra_interes) >= 0.0 THEN 0.0            
            ELSE ABS((c.venta_interes - c.compra_interes))            
           END            
   ,      'Compra_Interes_210'          = c.compra_interes            
   ,      'Venta_Interes_210'           = c.venta_interes            
   ,      'compra_moneda'               = c.Compra_Moneda            
   ,      'venta_moneda'                = c.Venta_Moneda            
   ,      'TipOper'                     = 'N'   --> SI Contabilizacion + SI Balance    
   ,      'SubCartera_917'              = CONVERT(NUMERIC(4), 0)            
   FROM   #CARTERA             c            
          INNER JOIN #CARTERA       v   ON c.Numero_Operacion = v.Numero_Operacion AND c.Numero_Flujo   = v.Numero_Flujo AND v.Tipo_flujo = 2            
   WHERE  c.tipo_swap                   = 2            
   AND    c.Tipo_flujo                  = 1            
   AND   (c.fecha_cierre                = @fecha_hoy             
       OR c.fecha_cierre                = @FechaHasta)            
   AND    c.Estado_Flujo                = 1            
            
    
       
    
   IF @@ERROR <> 0            
   BEGIN            
      PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. MOV CCS 1'            
      RETURN 1            
   END            
            
   -->    PRINT 'NORMAL - B'            
   INSERT INTO BAC_CNT_CONTABILIZA            
   (   id_sistema     , tipo_movimiento , tipo_operacion    , operacion        , correlativo     , codigo_instrumento      , moneda_instrumento     , tipo_cliente            , cartera_inversion            
   ,   compra_capital , venta_capital   , venta_capital_Ant , devengo_utilidad , devengo_perdida , Monto_diferido_utilidad , Monto_diferido_perdida , Monto_Utilidad_Valoriza , Monto_Perdida_Valoriza            
   ,   Compra_Interes , Venta_Interes   , compra_moneda     , venta_moneda            
   ,   TipOper        , SubCartera            
   )            
   SELECT 'id_sistema'                  = 'PCS'            
   ,      'tipo_movimiento'             = 'MOV'            
   ,      'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'V'            
   ,      'operacion'                   = c.Numero_Operacion            
   ,      'correlativo'                 = c.tipo_flujo            
   ,      'codigo_instrumento'          = ''            
   ,      'moneda_instrumento'          = CONVERT(CHAR(03),c.Venta_Moneda)            
   ,      'tipo_cliente'                = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
   ,      'cartera_inversion'           = c.cartera_inversion            
   ,      'compra_capital_200'          = (c.venta_amortiza + c.venta_saldo + c.venta_flujo_Adicional ) -- MAP 20080429             
   ,      'venta_capital_201'           = (c.venta_amortiza + c.venta_saldo + c.Venta_Flujo_Adicional ) -- MAP 20080429             
                                           * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.venta_moneda)            
   ,      'venta_capital_Ant_203'    = CASE WHEN c.fecha_cierre = @fecha_hoy THEN 0.0            
                                  ELSE                                  (c.venta_amortiza + c.venta_saldo + c.Venta_Flujo_Adicional )             
                                          END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior AND vmcodigo = c.venta_moneda)            
   ,      'devengo_utilidad_204'        = CASE WHEN c.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
   ,      'devengo_perdida_205'         = CASE WHEN c.Valor_RazonableCLP <  0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
            
   ,      'Monto_diferido_utilidad_206' = isnull(CASE WHEN c.fecha_cierre = @fecha_hoy and c.fecha_cierre >@dFechaAnterior THEN 0.0            
                                               ELSE (SELECT CASE WHEN r.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(r.Valor_RazonableCLP,0)) ELSE 0.0 END             
                                                       FROM CARTERARES r with(nolock) WHERE r.Fecha_Proceso = @dFechaAnterior AND r.numero_operacion = c.numero_operacion AND r.numero_flujo = c.numero_flujo)            
                                          END,0)            
            
   ,      'Monto_diferido_perdida_207'  = isnull(CASE WHEN c.fecha_cierre = @fecha_hoy and c.fecha_cierre >@dFechaAnterior THEN 0.0            
                                               ELSE (SELECT CASE WHEN r.Valor_RazonableCLP < 0.0 THEN ABS(ROUND(r.Valor_RazonableCLP,0)) ELSE 0.0 END             
                                                       FROM CARTERARES r with(nolock) WHERE r.Fecha_Proceso = @dFechaAnterior AND r.numero_operacion = c.numero_operacion AND r.numero_flujo = c.numero_flujo)            
                                          END,0)            
            
   ,      'Monto_Utilidad_Valoriza_208' = CASE WHEN     (c.venta_interes - c.compra_interes)  <  0.0 THEN 0.0            
                                               ELSE ABS((c.venta_interes - c.compra_interes))            
           END            
   ,      'Monto_Perdida_Valoriza_209'  = CASE WHEN     (c.venta_interes - c.compra_interes)  >= 0.0 THEN 0.0            
                                               ELSE ABS((c.venta_interes - c.compra_interes))            
           END            
   ,      'Compra_Interes_210'          = c.compra_interes            
   ,      'Venta_Interes_210'           = c.venta_interes            
   ,      'compra_moneda'     = c.Compra_Moneda            
   ,      'venta_moneda'                = c.Venta_Moneda            
   ,      'TipOper'                     = 'N'     --> SI Contabilizacion + SI Balance    
   ,      'SubCartera_917'              = CONVERT(NUMERIC(4), 0)            
   FROM   #CARTERA      c    
          INNER JOIN #CARTERA   v ON c.Numero_Operacion = v.Numero_Operacion AND c.Numero_Flujo   = v.Numero_Flujo AND v.Tipo_flujo = 2    
   WHERE  c.tipo_swap                   = 2    
   AND    c.Tipo_flujo                  = 2    
   AND   (c.fecha_cierre                = @fecha_hoy    
       OR c.fecha_cierre                = @FechaHasta)    
   AND    c.Estado_Flujo                = 1    
    
    
     
    
   IF @@ERROR <> 0    
   BEGIN    
      PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. MOV CCS 2'    
      RETURN 1    
   END    
    
   --     PRINT 'NORMAL - C'            
   INSERT INTO BAC_CNT_CONTABILIZA            
   (   id_sistema     , tipo_movimiento , tipo_operacion    , operacion        , correlativo     , codigo_instrumento      , moneda_instrumento     , tipo_cliente            , cartera_inversion            
   ,   compra_capital , venta_capital   , venta_capital_Ant , devengo_utilidad , devengo_perdida , Monto_diferido_utilidad , Monto_diferido_perdida , Monto_Utilidad_Valoriza , Monto_Perdida_Valoriza            
   ,   Compra_Interes , Venta_Interes               
   ,   TipOper        , SubCartera            
   )            
  SELECT  'id_sistema'                  = 'PCS'            
   ,      'tipo_movimiento'             = 'MOV'         
   ,      'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap)            
   ,      'operacion'                   = c.Numero_Operacion            
   ,      'correlativo'                 = c.Numero_Flujo            
   ,      'codigo_instrumento'          = ''            
   ,      'moneda_instrumento'          = CASE WHEN c.tipo_swap  = 1 THEN CONVERT(CHAR(03),c.Compra_Moneda)            
                                               WHEN c.tipo_swap  = 4 THEN CONVERT(CHAR(03),c.Compra_Moneda)            
                                               WHEN c.tipo_swap  = 2 THEN CONVERT(CHAR(03),c.Compra_Moneda)            
                                               ELSE                       ''            
           END            
   ,      'tipo_cliente'                = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
   ,      'cartera_inversion'           = c.cartera_inversion            
   ,      'compra_capital_200'          = CASE WHEN c.compra_capital <> 0.0 THEN (c.compra_amortiza + c.compra_saldo  )            
                     ELSE                              (c.venta_amortiza  + c.venta_saldo   )             
                                          END            
   ,      'venta_capital_201'           = CASE WHEN c.compra_capital <> 0.0 THEN (c.compra_amortiza + c.compra_saldo  )            
                                               ELSE                              (c.venta_amortiza  + c.venta_saldo   )            
                                          END * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.compra_moneda)            
            
  ,      'venta_capital_Ant_203'        = CASE WHEN c.fecha_cierre    = @fecha_hoy THEN 0.0            
                                               WHEN c.compra_capital <> 0.0        THEN (c.compra_amortiza + c.compra_saldo)            
                                               ELSE                                   (c.venta_amortiza  + c.venta_saldo)            
                                          END * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior AND vmcodigo = c.compra_moneda)            
   ,      'devengo_utilidad_204'        = CASE WHEN c.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
   ,      'devengo_perdida_205'         = CASE WHEN c.Valor_RazonableCLP <  0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
            
   ,      'Monto_diferido_utilidad_206' = ISNULL( CASE WHEN c.fecha_cierre = @dFechaMvt THEN 0.0            
                                                       ELSE (SELECT CASE WHEN r.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(r.Valor_RazonableCLP,0)) ELSE 0.0 END             
                                                               FROM CARTERARES r with(nolock) WHERE r.Fecha_Proceso = @dFechaAnterior AND r.numero_operacion = c.numero_operacion AND r.numero_flujo = c.numero_flujo)            
                                                   END, 0.0 )            
            
   ,      'Monto_diferido_perdida_207'  = ISNULL( CASE WHEN c.fecha_cierre = @dFechaMvt THEN 0.0            
                                                       ELSE ( SELECT CASE WHEN r.Valor_RazonableCLP  < 0.0 THEN ABS(ROUND(r.Valor_RazonableCLP,0)) ELSE 0.0 END             
                FROM CARTERARES r with(nolock) WHERE r.Fecha_Proceso = @dFechaAnterior AND r.numero_operacion = c.numero_operacion AND r.numero_flujo = c.numero_flujo)            
                                                  END, 0.0 )            
            
   ,     'Monto_Utilidad_Valoriza_208'  = CASE WHEN     (c.venta_interes - c.compra_interes) + (v.venta_interes - v.compra_interes) <  0.0 THEN 0.0            
            ELSE ABS((c.venta_interes - c.compra_interes) + (v.venta_interes - v.compra_interes))            
                                          END            
   ,      'Monto_Perdida_Valoriza_209'  = CASE WHEN     (c.venta_interes - c.compra_interes) + (v.venta_interes - v.compra_interes) >= 0.0 THEN 0.0          
            ELSE ABS((c.venta_interes - c.compra_interes) + (v.venta_interes - v.compra_interes))            
                                        END            
   ,      'Compra_Interes_210'          = c.compra_interes            
   ,      'Venta_Interes_210'           = c.venta_interes            
   ,      'TipOper'                     = 'N'      --> SI Contabilizacion + SI Balance    
   ,      'SubCartera_917'              = CONVERT(NUMERIC(4), 0)            
   FROM   #CARTERA       c            
          INNER JOIN #CARTERA      v    ON c.Numero_Operacion = v.Numero_Operacion AND c.Numero_Flujo = v.Numero_Flujo AND v.Tipo_flujo = 2            
   WHERE  c.tipo_swap                   = 4            
   AND    c.Tipo_flujo                  = 1            
   AND   (c.fecha_cierre                = @fecha_hoy             
       OR c.fecha_cierre                = @FechaHasta)            
   AND    c.Estado_flujo                = 1            
            
   IF @@ERROR <> 0            
   BEGIN            
  PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. ICP'            
  RETURN 1            
   END            
            
            
   -->>>>>>>> SEPARACION ACTIVO DEL PASIVO PARA SWAP IRS  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<--            
   INSERT INTO BAC_CNT_CONTABILIZA            
   (   id_sistema     , tipo_movimiento , tipo_operacion    , operacion        , correlativo     , codigo_instrumento      , moneda_instrumento     , tipo_cliente            , cartera_inversion            
   ,   compra_capital , venta_capital   , venta_capital_Ant , devengo_utilidad , devengo_perdida , Monto_diferido_utilidad , Monto_diferido_perdida , Monto_Utilidad_Valoriza , Monto_Perdida_Valoriza            
   ,   Compra_Interes , Venta_Interes               
   ,   TipOper        , SubCartera            
   )            
   SELECT 'id_sistema'                  = 'PCS'    
   ,      'tipo_movimiento'    = 'MOV'    
   ,      'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'C'    
   ,      'operacion'                   = c.numero_operacion    
   ,      'correlativo'                 = c.numero_flujo    
   ,      'codigo_instrumento'          = ''    
   ,      'moneda_instrumento'          = CONVERT(CHAR(03),c.compra_moneda)    
   ,      'tipo_cliente'                = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END    
   ,      'cartera_inversion'           = (c.cartera_inversion)            
   ,      'compra_capital_200'          = (c.compra_amortiza + c.compra_saldo)       
   ,      'venta_capital_201'           = (c.compra_amortiza + c.compra_saldo) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso  AND vmcodigo = c.compra_moneda)            
   ,      'venta_capital_Ant_203'       =  CASE WHEN c.fecha_cierre    = @fecha_hoy THEN 0.0            
        ELSE (c.compra_amortiza + c.compra_saldo) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior AND vmcodigo = c.compra_moneda)            
                                           END            
   ,      'devengo_utilidad_204'        = CASE WHEN c.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
   ,      'devengo_perdida_205'         = CASE WHEN c.Valor_RazonableCLP <  0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
            
   ,      'Monto_diferido_utilidad_206' = ISNULL(CASE WHEN c.fecha_cierre = @dFechaMvt THEN 0.0            
                            ELSE (SELECT CASE WHEN r.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(r.Valor_RazonableCLP,0)) ELSE 0.0 END             
                                                              FROM BacSwapSuda.dbo.CARTERARES r with(nolock)  WHERE r.Fecha_Proceso = @dFechaAnterior AND r.numero_operacion = c.numero_operacion AND r.numero_flujo = c.numero_flujo)            
                                                 END, 0.0)            
            
   ,      'Monto_diferido_perdida_207'  = ISNULL(CASE WHEN c.fecha_cierre = @dFechaMvt THEN 0.0            
                      ELSE (SELECT CASE WHEN r.Valor_RazonableCLP  < 0.0 THEN ABS(ROUND(r.Valor_RazonableCLP,0)) ELSE 0.0 END             
                                                              FROM BacSwapSuda.dbo.CARTERARES r with(nolock)  WHERE r.Fecha_Proceso = @dFechaAnterior AND r.numero_operacion = c.numero_operacion AND r.numero_flujo = c.numero_flujo)            
                                                 END, 0.0)            
            
   ,     'Monto_Utilidad_Valoriza_208'  = CASE WHEN (c.venta_interes - c.compra_interes) <  0.0 THEN 0.0 ELSE ABS((c.venta_interes - c.compra_interes)) END            
   ,     'Monto_Perdida_Valoriza_209'   = CASE WHEN (c.venta_interes - c.compra_interes) >= 0.0 THEN 0.0 ELSE ABS((c.venta_interes - c.compra_interes)) END            
   ,     'Compra_Interes_210'           = c.compra_interes            
   ,     'Venta_Interes_210'            = c.venta_interes            
   ,     'TipOper'                      = 'N'        --> SI Contabilizacion + SI Balance    
   ,     'SubCartera_917'               = CONVERT(NUMERIC(4), 0)            
   FROM   #CARTERA c            
   WHERE  c.Tipo_Swap                   = 1            
   AND    c.Tipo_Flujo                  = 1            
   AND   (c.Fecha_Cierre                = @fecha_hoy             
       OR c.Fecha_Cierre                = @FechaHasta)            
 AND    c.Estado_Flujo  = 1            
            
   IF @@ERROR <> 0            
   BEGIN            
      PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. IRS 1'            
      RETURN 1            
   END            
            
            
   INSERT INTO BAC_CNT_CONTABILIZA            
   (   id_sistema     , tipo_movimiento , tipo_operacion    , operacion        , correlativo     , codigo_instrumento      , moneda_instrumento     , tipo_cliente            , cartera_inversion            
   ,   compra_capital , venta_capital   , venta_capital_Ant , devengo_utilidad , devengo_perdida , Monto_diferido_utilidad , Monto_diferido_perdida , Monto_Utilidad_Valoriza , Monto_Perdida_Valoriza            
   ,   Compra_Interes , Venta_Interes               
   ,   TipOper        , SubCartera            
   )            
   SELECT 'id_sistema'                  =  'PCS'            
   ,      'tipo_movimiento'             =  'MOV'            
   ,      'tipo_operacion'              =  CONVERT(CHAR(1),c.tipo_swap) + 'V'            
   ,      'operacion'                   =  c.numero_operacion            
   ,      'correlativo'                 =  c.numero_flujo           
   ,      'codigo_instrumento'          =  ''            
   ,      'moneda_instrumento'          =  CONVERT(CHAR(03),c.venta_moneda)            
   ,      'tipo_cliente'                =  CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END           
  ,      'cartera_inversion'           = (c.cartera_inversion)            
   ,      'compra_capital_200'          = (c.venta_amortiza + c.venta_saldo)            
   ,      'venta_capital_201'           = (c.venta_amortiza + c.venta_saldo)             
                                        * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso  AND vmcodigo = c.venta_moneda)            
   ,      'venta_capital_Ant_203'       =  CASE WHEN c.fecha_cierre    = @fecha_hoy THEN 0.0            
                                                ELSE (c.venta_amortiza + c.venta_saldo) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior AND vmcodigo = c.venta_moneda)            
                                           END            
   ,      'devengo_utilidad_204'        = CASE WHEN c.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
   ,      'devengo_perdida_205'         = CASE WHEN c.Valor_RazonableCLP <  0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
            
   ,      'Monto_diferido_utilidad_206' = ISNULL(CASE WHEN c.fecha_cierre = @dFechaMvt THEN 0.0            
                                                      ELSE (SELECT CASE WHEN r.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(r.Valor_RazonableCLP,0)) ELSE 0.0 END            
                                                              FROM BacSwapSuda.dbo.CARTERARES r WHERE r.Fecha_Proceso = @dFechaAnterior AND r.numero_operacion = c.numero_operacion AND r.numero_flujo = c.numero_flujo)            
                                                 END, 0.0)            
            
   ,      'Monto_diferido_perdida_207'  = ISNULL(CASE WHEN c.fecha_cierre = @dFechaMvt THEN 0.0            
                                                      ELSE (SELECT CASE WHEN r.Valor_RazonableCLP < 0.0 THEN ABS(ROUND(r.Valor_RazonableCLP,0)) ELSE 0.0 END             
                                                              FROM BacSwapSuda.dbo.CARTERARES r WHERE r.Fecha_Proceso = @dFechaAnterior AND r.numero_operacion = c.numero_operacion AND r.numero_flujo = c.numero_flujo)            
                                                 END, 0.0)            
            
   ,     'Monto_Utilidad_Valoriza_208'  = CASE WHEN (c.venta_interes - c.compra_interes) <  0.0 THEN 0.0 ELSE ABS((c.venta_interes - c.compra_interes)) END     
   ,     'Monto_Perdida_Valoriza_209'   = CASE WHEN (c.venta_interes - c.compra_interes) >= 0.0 THEN 0.0 ELSE ABS((c.venta_interes - c.compra_interes)) END            
   ,     'Compra_Interes_210'           = c.compra_interes            
   ,     'Venta_Interes_210'            = c.venta_interes            
   ,     'TipOper'                      = 'V' --> 'N' --> SI Contabilizacion + NO Balance    
              -->   Genera la Duplicidad en Interfaz de Balance por Operacion     
   ,     'SubCartera_917'               = CONVERT(NUMERIC(4), 0)            
   FROM   #CARTERA c            
   WHERE  c.Tipo_Swap                   = 1    
   AND    c.Tipo_Flujo                  = 2    
   AND    c.Estado_Flujo                = 1    
   AND   (c.Fecha_Cierre = @fecha_hoy OR c.Fecha_Cierre = @FechaHasta)    
            
   IF @@ERROR <> 0            
   BEGIN     
      PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. IRS 2'            
      RETURN 1            
   END            
   -->>>>>>>> SEPARACION ACTIVO DEL PASIVO PARA SWAP IRS  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<--            
            
            
   -->    ( 1 ) Datos Devengamiento y Valorización            
   --      PRINT 'NORMAL - D'            
   INSERT INTO BAC_CNT_CONTABILIZA            
   (   id_sistema       , tipo_movimiento , tipo_operacion          , operacion              , correlativo , codigo_instrumento , moneda_instrumento , tipo_cliente , cartera_inversion            
   ,   devengo_utilidad , devengo_perdida , Monto_diferido_utilidad , Monto_diferido_perdida            
   ,   TipOper          , SubCartera            
   )                 
   SELECT distinct   -- PRD XXXX    
          'id_sistema'                  = 'PCS'            
   ,      'tipo_movimiento'             = 'DEV'            
   ,      'tipo_operacion'              = CASE WHEN c.tipo_swap = 2 THEN 'D' + LTRIM(RTRIM(c.tipo_swap))            
                                         ELSE                      'D' + LTRIM(RTRIM(c.tipo_swap))            
                                          END            
   ,      'operacion'                   = c.Numero_Operacion            
   ,      'correlativo'                 = 1            
   ,      'codigo_instrumento'          = ''            
   ,      'moneda_instrumento'          = CASE WHEN c.tipo_swap = 1 THEN CONVERT(CHAR(03),c.Compra_Moneda)            
                                               WHEN c.tipo_swap = 4 THEN CONVERT(CHAR(03),c.Compra_Moneda)            
                                               WHEN c.tipo_swap = 2 THEN '999'            
                                               ELSE                      ''            
                                          END            
   ,      'tipo_cliente'                = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
   ,      'cartera_inversion'           = c.cartera_inversion            
   ,    'devengo_utilidad_204'        = CASE WHEN c.fecha_termino      = @fecha_hoy or c.estado = 'N' THEN 0.0                    -- MAP 20081110 Problemas Anticipo            
                                            WHEN c.Valor_RazonableCLP >= 0.0           THEN ABS(ROUND(c.Valor_RazonableCLP,0))             
                                               ELSE                                            0.0             
                                          END            
   ,      'devengo_perdida_205'         = CASE WHEN c.fecha_termino       = @fecha_hoy or c.estado = 'N' THEN 0.0                    -- MAP 20081110 Problemas Anticipo                       
                                               WHEN c.Valor_RazonableCLP  <  0.0          THEN ABS(ROUND(c.Valor_RazonableCLP,0))             
                                               ELSE                                            0.0             
                                          END            
   ,      'Monto_diferido_utilidad_206' =   CASE WHEN C.Modificadahoy = 1                      THEN 0.0     
                                            ELSE ( CASE WHEN c.fecha_cierre = @fecha_hoy       THEN 0.0    
            ELSE CASE WHEN r2.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(r2.Valor_RazonableCLP,0)) ELSE 0.0 END    
                  END)    
           END    
   ,      'Monto_diferido_perdida_207'  =   CASE WHEN C.Modificadahoy = 1                      THEN 0.0     
                                            ELSE ( CASE WHEN c.fecha_cierre = @fecha_hoy       THEN 0.0    
                                               ELSE CASE WHEN r2.Valor_RazonableCLP <  0.0 THEN ABS(ROUND(r2.Valor_RazonableCLP,0)) ELSE 0.0 END    
                  END)    
           END    
   ,      'TipOper'                     = 'N' --> SI Contabilizacion + SI Balance    
   ,      'SubCartera_917'              = CONVERT(NUMERIC(4), 0)    
   FROM   #CARTERA c    
   -- PRD XXXX    
 /*         LEFT JOIN CARTERARES r  with(nolock) ON r.Fecha_Proceso = @FechaAnt AND c.Numero_Operacion = r.Numero_Operacion AND c.tipo_flujo = r.Tipo_Flujo AND c.Numero_Flujo = r.Numero_Flujo    
 */    
            LEFT JOIN (Select        distinct numero_operacion , Valor_RazonableCLP          -- PRD XXXX    
      From  BacSwapSuda.dbo.CarteraRes Aux with(nolock)         
      Where  Aux.Fecha_Proceso  =  @FechaAnt            
     )  r2   on     c.numero_operacion = r2.numero_operacion                                 -- PRD XXXX    
    
   WHERE  c.Tipo_Swap    IN(1,2,4)    
 and  (c.estado  <> 'N'  -- Descarta Anticipos        
  or (  c.Estado  = 'N'  -- Es Anticipo y...    
 and             -- Es total      
   ( select count(1) from #Cartera cc where cc.numero_operacion = c.numero_operacion and cc.estado <> 'N' ) < 1    
   )    
  )    
    
   --- PROD XXX    
   ----AND   (c.Estado_Flujo = 1 and c.fecha_termino > @FechaHasta    
   ----   OR  c.Estado_Flujo = 2 and c.fecha_Termino <= @FechaHasta) -- MAP DJ -- MAP 20080429, para que reverse AVR cuando termina el Swap    
    
   AND    c.Tipo_Flujo   = 1    
       
      
       
   IF @@ERROR <> 0    
   BEGIN    
      PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. DEV'    
      RETURN 1    
   END    
    
/*     ------------------------------------------------------------------------------    
    -- Con fecha 19-08-2013 se reira segun mail del 25-06-2013 de Elizabeth Cerda    
            
    --  PRINT 'NORMAL - F'            
    INSERT INTO BAC_CNT_CONTABILIZA            
    (      id_sistema     , tipo_movimiento , tipo_operacion , operacion , correlativo , codigo_instrumento , moneda_instrumento , tipo_cliente , cartera_inversion            
    ,      compra_capital , venta_capital   , venta_capital_Ant            
    ,      TipOper        , SubCartera            
    )              
    SELECT 'id_sistema'                  = 'PCS'            
    ,      'tipo_movimiento'             = 'REA'            
    ,      'tipo_operacion'              = 'R' + CONVERT(CHAR(1),LTRIM(RTRIM(c.Tipo_Swap)))            
    ,      'operacion'                   = Numero_Operacion            
    ,      'correlativo'                 = 1            
    ,     'codigo_instrumento'           = ''            
    ,      'moneda_instrumento'          = CONVERT(CHAR(03),c.Compra_Moneda)            
    ,      'tipo_cliente'                = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
    ,      'cartera_inversion'           = c.Cartera_Inversion            
    ,      'compra_capital_200'          = (c.compra_amortiza + c.compra_saldo )            
    ,      'venta_capital_201'           = (c.compra_amortiza + c.compra_saldo ) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso  AND vmcodigo = c.compra_moneda)            
    ,      'venta_capital_Ant_203'       = (c.compra_amortiza + c.compra_saldo ) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior AND vmcodigo = c.compra_moneda)            
    ,      'TipOper'                     = 'N'            
    ,      'SubCartera_917'              = CONVERT(NUMERIC(4), 0)            
    FROM   #CARTERA c            
    WHERE  (c.Tipo_Swap           IN(1,4))            
    AND    (c.Tipo_Flujo          = 1)       
    AND    (c.Compra_Moneda       = 998)            
    AND    (c.Fecha_Cierre        < @FechaHasta)            
    AND    (c.Estado_Flujo        = 1 and c.fecha_termino > @FechaHasta or  c.Estado_Flujo = 2 and c.fecha_termino = @FechaHasta )            
    AND     c.Estado             <> 'N'            
             
    IF @@ERROR <> 0            
    BEGIN            
   PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. REA IRS-ICP'            
   RETURN 1            
    END            
    
    
    -->     Amortizacion o Capital Reajustado (CAPREA) Flujo 1 Compra            
    --        PRINT 'NORMAL - H'            
    INSERT INTO BAC_CNT_CONTABILIZA            
    (      id_sistema     , tipo_movimiento , tipo_operacion , operacion , correlativo , codigo_instrumento , moneda_instrumento , tipo_cliente , cartera_inversion            
    ,      compra_capital , venta_capital   , venta_capital_Ant            
    ,      TipOper        , SubCartera            
    )              
    SELECT 'id_sistema'           = 'PCS'            
    ,      'tipo_movimiento'      = 'REA'            
    ,      'tipo_operacion'       = 'R' + CONVERT(CHAR(1),LTRIM(RTRIM(c.Tipo_Swap))) + CASE WHEN c.tipo_flujo = 1 THEN 'C' ELSE 'V' END            
    ,      'operacion'            = Numero_Operacion            
    ,      'correlativo'          = 1            
    ,      'codigo_instrumento'   = ''            
    ,      'moneda_instrumento'   = CONVERT(CHAR(03),c.Compra_Moneda)            
    ,      'tipo_cliente'         = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
    ,      'cartera_inversion'    = c.Cartera_Inversion            
    ,      'compra_capital_200'   = (c.compra_amortiza + c.compra_saldo + c.Compra_Flujo_Adicional )            
    ,      'venta_capital_201'    = (c.compra_amortiza + c.compra_saldo + c.Compra_Flujo_Adicional ) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso  AND vmcodigo = c.compra_moneda)            
   ,       'venta_capital_Ant_203'= (c.compra_amortiza + c.compra_saldo + c.Compra_Flujo_Adicional ) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior AND vmcodigo = c.compra_moneda)            
    ,      'TipOper'              = 'N'            
    ,      'SubCartera_917'       = CONVERT(NUMERIC(4), 0)            
    FROM    #CARTERA c            
    WHERE  (c.Tipo_Swap           IN(2))            
    AND    (c.Tipo_Flujo          = 1)            
    AND    (c.Compra_Moneda       = 998)            
    AND    (c.Fecha_Cierre        < @FechaHasta )             
    AND    (c.Estado_Flujo        = 1 and c.fecha_termino > @FechaHasta or  c.Estado_Flujo = 2 and c.fecha_termino = @FechaHasta )            
    AND    (c.Estado             <> 'C')            
             
    IF @@ERROR <> 0            
    BEGIN            
   PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. REA CCS 1'            
   RETURN 1            
    END            
    
    -->    Amortizacion o Capital Reajustado (CAPREA) Swap de Monedas Flujo 2 Venta            
    --       PRINT 'NORMAL - I'            
    INSERT INTO BAC_CNT_CONTABILIZA            
    (      id_sistema     , tipo_movimiento , tipo_operacion , operacion , correlativo , codigo_instrumento , moneda_instrumento , tipo_cliente , cartera_inversion            
    ,      compra_capital , venta_capital   , venta_capital_Ant            
    ,      TipOper        , SubCartera            
    )              
    SELECT  'id_sistema'           = 'PCS'            
    ,       'tipo_movimiento'      = 'REA'            
    ,       'tipo_operacion'       = 'R' + CONVERT(CHAR(1),LTRIM(RTRIM(c.Tipo_Swap))) + CASE WHEN c.tipo_flujo = 1 THEN 'C' ELSE 'V' END            
    ,       'operacion'            = Numero_Operacion            
    ,       'correlativo'          = 1            
    ,       'codigo_instrumento'   = ''            
    ,       'moneda_instrumento'   = CONVERT(CHAR(03),c.venta_Moneda)            
    ,       'tipo_cliente'         = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
    ,       'cartera_inversion'    = c.Cartera_Inversion            
    ,       'compra_capital_200'   = (c.venta_amortiza + c.venta_saldo + c.Venta_Flujo_Adicional )            
    ,       'venta_capital_201'    = (c.venta_amortiza + c.venta_saldo + c.Venta_Flujo_Adicional ) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso  AND vmcodigo = c.venta_moneda)            
    ,       'venta_capital_Ant_203'= (c.venta_amortiza + c.venta_saldo + c.Venta_Flujo_Adicional ) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior AND vmcodigo = c.venta_moneda)            
    ,       'TipOper'              = 'N'            
    ,       'SubCartera_917'       = CONVERT(NUMERIC(4), 0)            
    FROM    #CARTERA c            
    WHERE  (c.Tipo_Swap            IN(2))            
    AND    (c.Tipo_Flujo           = 2)            
    AND    (c.Venta_Moneda         = 998)            
    AND    (c.Fecha_Cierre         < @FechaHasta )             
    AND    (c.Estado_Flujo         = 1 and c.fecha_termino > @FechaHasta or c.Estado_Flujo = 2 and c.fecha_termino = @FechaHasta )            
    AND    (c.Estado              <> 'C')            
    --> ****************************************************************************************************            
             
    IF @@ERROR <> 0            
    BEGIN            
    PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. REA CCS 2'            
    RETURN 1            
    END            
    
 */ -- Con fecha 19-08-2013 se reira segun mail del 25-06-2013 de Elizabeth Cerda    
  ------------------------------------------------------------------------------    
    
    
 --> Genera Reversa Contable LBTR    
 EXECUTE dbo.SP_GENERA_REVERSA_LBTR @dFechaProceso /* @Fecha_Hoy */ /* no reversa cuando es fin de mes especial */    
 --> Genera Reversa Contable LBTR    
    
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * */            
 /*      DATOS QUE ESTAN VENCIENDO                 */            
 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * */            
  
  
  
 IF @UltimoDiaMes = @fecha_hoy            
 BEGIN            
  SET @fecha_hoy = (SELECT fechaproc FROM BacSwapSuda.dbo.SWAPGENERAL)            
 END            
            
 --          PRINT 'NORMAL - J'       
 INSERT INTO BAC_CNT_CONTABILIZA            
 (   id_sistema      , tipo_movimiento , tipo_operacion , operacion    , correlativo ,   codigo_instrumento   ,   moneda_instrumento   ,   tipo_cliente   ,   cartera_inversion            
 ,   Recibimos_Monto , Pagamos_Monto   , Forma_de_Pago  , compra_amortiza , compra_saldo , venta_amortiza , venta_saldo            
 ,   TipOper   , SubCartera            
 ,   Compra_Amortiza_Peso  -- MAP 20081205 Agrega concepto en ML Moneda Local, Amortización en ML            
 ,   Devengo_Compra_Peso   -- MAP 20081205 Agrega concepto en ML Moneda Local, Interes en ML            
 ,   Venta_Amortiza_Peso   -- MAP 20081205 Agrega concepto en ML Moneda Local, Amortización en ML            
 ,   Devengo_Venta_Peso    -- MAP 20081205 Agrega concepto en ML Moneda Local, Interes en ML            
    
   ,   Monto_Utilidad_Valoriza  -- <-- Mpago    
   ,   Monto_Perdida_Valoriza   -- <-- MPago    
   ,   Recibimos_Monto_Clp -- <--  ML    
   ,   Pagamos_Monto_Clp   -- <--  ML    
    
    
 )            
 SELECT TOP 0 'id_sistema'                = 'PCS'-->>DESHABILITAR ENTREGAS FISICAS            
 ,      'tipo_movimiento'           = 'VFL'  --1            
 ,      'tipo_operacion'            = 'V' + LTRIM(RTRIM(caj.Producto))            
 ,      'operacion'                 = caj.Numero_Operacion            
 ,      'correlativo'               = 1      
 ,      'codigo_instrumento'        = ''            
 ,      'moneda_instrumento'        = CONVERT(CHAR(03),case when caj.MontoM1 > 0 then caj.MonedaM1 else Caj.MonedaM2 end )            
 ,      'tipo_cliente'              = CASE WHEN cli.clpais = 6 THEN '1' ELSE '2' END            
 ,      'cartera_inversion'         = 0     
    
 ,      'Recibimos_Monto_212'       = 0.0    
 ,      'Pagamos_Monto_213'         = 0.0    
 ,      'Forma_de_Pago'             = case when caj.MontoM1 > 0 then caj.FormaPago1 else Caj.FormaPago2 end            
 ,      'Amortizacion_Compra_214'   = 0.0         
 ,      'Interes_Compra_215'        = 0.0    
 ,   'Amortizacion_Venta_216'     = 0.0            
 ,      'Interes_Venta_217'         = 0.0     
             
 ,      'TipOper'                   = 'V'      --> SI Contabilizacion + NO Balance     
 ,      'SubCartera_917'            = CONVERT(NUMERIC(4), 0)          
 ,      'AmortizaCompraPeso218'     = 0.0             
 ,      'InteresCompraPeso219'      = 0.0    
 ,      'AmortizaVentaPeso220'      = 0.0            
 ,      'InteresVentaPeso221'       = 0.0            
    
   ,     'NN Utilidad Real del Swap'       = CASE WHEN MontoM1 > 0.0 THEN MontoM1 ELSE Caj.montom2 END                  
   ,     'NN Perdida Real del Swap'        = 0.0    
   ,     'NN Utilidad Real Swap ML'        = round( case when MontoM1Local > 0 then MontoM1Local else MontoM2Local end , 0 )                
   ,     'NN Perdida  Real Swap ML'        = 0.0    
    
 FROM   BacParamSuda.dbo.TBL_CAJA_DERIVADOS Caj      
      left join BacParamSuda.dbo.cliente Cli on Cli.ClRut = Caj.Rut_Contraparte and Cli.ClCodigo = Caj.Codigo_Contraparte    
 WHERE  Caj.producto                = 2      
 and    caj.fechaLiquidacion = @dFechaProceso    -- MAP20150731 fdm         
 --AND    caj.Tipo_Flujo                = 1             
 AND    caj.modalidad_pago         = 'E'     
 and   ( caj.montoM1 > 0 or Caj.montom2 > 0 ) -- Flujo que genera utilidad    
     
 ORDER BY caj.numero_operacion  
            
   IF @@ERROR <> 0            
   BEGIN            
      PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. VFL CCS 1'            
      RETURN 1            
   END            
            
   --        PRINT 'NORMAL - K'            
   INSERT INTO BAC_CNT_CONTABILIZA            
   (   id_sistema      , tipo_movimiento , tipo_operacion , operacion    , correlativo , codigo_instrumento , moneda_instrumento , tipo_cliente , cartera_inversion            
   ,   Recibimos_Monto , Pagamos_Monto   , Forma_de_Pago  , compra_amortiza , compra_saldo , venta_amortiza , venta_saldo            
   ,   TipOper         , SubCartera             
   ,   Compra_Amortiza_Peso  -- MAP 20081205 Agrega concepto en ML Moneda Local, Amortización en ML            
   ,   Devengo_Compra_Peso   -- MAP 20081205 Agrega concepto en ML Moneda Local, Interes en ML            
   ,   Venta_Amortiza_Peso   -- MAP 20081205 Agrega concepto en ML Moneda Local, Amortización en ML            
   ,   Devengo_Venta_Peso    -- MAP 20081205 Agrega concepto en ML Moneda Local, Interes en ML            
   ,   Monto_Utilidad_Valoriza  -- <-- Mpago    
   ,   Monto_Perdida_Valoriza   -- <-- MPago    
   ,   Recibimos_Monto_Clp -- <--  ML    
   ,   Pagamos_Monto_Clp   -- <--  ML    
    
   )                
   SELECT TOP 0 'id_sistema'    = 'PCS'    -->>DESHABILITAR ENTREGAS FISICAS
   ,      'tipo_movimiento'         = 'VFL'    
   ,      'tipo_operacion'          = 'V' + LTRIM(RTRIM(caj.Producto ))    
   ,      'operacion'               = caj.Numero_Operacion    
   ,      'correlativo'             = 2           
   ,      'codigo_instrumento'      = ''            
   ,      'moneda_instrumento'      = CONVERT(CHAR(03),case when caj.MontoM1 < 0 then caj.MonedaM1 else Caj.MonedaM2 end )            
   ,      'tipo_cliente'            = CASE WHEN cli.clpais = 6 THEN '1' ELSE '2' END            
   ,      'cartera_inversion'       = 0     
   ,      'Recibimos_Monto_212'     = 0.0    
   ,      'Pagamos_Monto_213'       = 0.0    
   ,      'Forma_de_Pago'           = case when caj.MontoM1 < 0 then caj.FormaPago1 else Caj.FormaPago2 end                    
   ,      'Amortizacion_Compra_214' = 0.0            
   ,      'Interes_Compra_215'      = 0.0             
   ,      'Amortizacion_Venta_216'  = 0.0    
   ,      'Interes_Venta_217'       = 0.0    
   ,      'TipOper'                 = 'V'       --> SI Contabilizacion + NO Balance        
   ,      'SubCartera_917'          = CONVERT(NUMERIC(4), 0)            
   ,      'AmortizaCompraPeso218'   = 0.0             
   ,      'InteresCompraPeso219'    = 0.0            
   ,      'AmortizaVentaPeso220'    = 0.0    
   ,      'InteresVentaPeso221'     = 0.0           
    
   ,     'NN Utilidad Real del Swap'       = 0.0    
   ,     'NN Perdida Real del Swap'        = CASE WHEN MontoM1 < 0.0 THEN abs(MontoM1) ELSE abs(Caj.montom2) END                  
   ,     'NN Utilidad Real Swap ML'        = 0.0    
   ,     'NN Perdida  Real Swap ML'        = CASE WHEN MontoM1 < 0.0 THEN abs(MontoM1Local) ELSE abs(Caj.MontoM2Local) END                  
    
   FROM   BacParamSuda.dbo.TBL_CAJA_DERIVADOS Caj      
      left join BacParamSuda.dbo.cliente Cli on Cli.ClRut = Caj.Rut_Contraparte and Cli.ClCodigo = Caj.Codigo_Contraparte    
 WHERE  Caj.producto                = 2      
 and    caj.fechaLiquidacion = @dFechaProceso    -- MAP20150731 fdm         
 --AND    caj.Tipo_Flujo                = 1             
 AND    caj.modalidad_pago         = 'E'     
 and    ( caj.montoM1 < 0 or Caj.montom2 < 0 ) -- Flujo que genera pérdida    
    
            
 IF @@ERROR <> 0            
 BEGIN            
  PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. VFL CCS 2'            
  RETURN 1            
 END    
  
  
 /*****************************************************************************************/    
/*****      MIGRACION MUREX                ***/  
/*****  SE INHIBE CONTABILIDAD DE SPOT DESDE VENCIMIENTOS DE FLUJO DE SWAP (DERIVADOS) ***/  
/*****  ER Convivencia v6  / 2020-08-25 / INICIO            ***/  
  
  
 DELETE FROM BAC_CNT_CONTABILIZA  
 WHERE  
  id_sistema   = 'PCS' AND  
  tipo_movimiento    = 'VFL' AND  
  moneda_instrumento = 13;  
  
/*****  ER Convivencia v6 / 2020-08-25 / FIN              ***/  
/*****  SE INHIBE CONTABILIDAD DE SPOT DESDE VENCIMIENTOS DE FLUJO DE SWAP (DERIVADOS) ***/  
/*****      MIGRACION MUREX                ***/  
/*****************************************************************************************/ 

  
   -->>CAMBIO DE EJECUCION YA QUE SE DEBEN CONTABILIDAD TODOS LOS COMPENSADOS
   --> Genera Compensación para el Evento Vcto Flujo    
   --      PRINT 'NORMAL - L'    
   EXECUTE GENERA_COMPENSACION_CNT @dFechaProceso; /*@Fecha_Hoy*/ --> MAP 20081110 Problemas Anticipo Fin de Mes especial.            
  
 
    
   --> Amortizacion    
      --  PRINT 'NORMAL - M'    
   INSERT INTO BAC_CNT_CONTABILIZA            
   (      id_sistema,     tipo_movimiento, tipo_operacion,  operacion,     correlativo,          codigo_instrumento, moneda_instrumento, tipo_cliente, cartera_inversion            
   ,      compra_capital, venta_capital,   Recibimos_Monto, pagamos_monto, compra_amortiza_peso, venta_amortiza_peso         
   ,      Forma_de_Pago,  TipOper,         SubCartera            
   )             
   SELECT 'id_sistema'               = 'PCS'            
   ,      'tipo_movimiento'  = 'VCT'            
   ,      'tipo_operacion'  = 'G' + CONVERT(CHAR(1),LTRIM(RTRIM(c.Tipo_Swap)))            
   ,      'operacion'                = c.numero_operacion            
   ,      'correlativo'              = c.numero_flujo            
   ,      'codigo_instrumento'       = ''            
   ,      'moneda_instrumento'       = CONVERT(CHAR(03),c.compra_moneda)            
   ,      'tipo_cliente'             = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
   ,      'cartera_inversion'        = c.cartera_inversion            
   ,      'compra_capital_200'       = isnull((c.compra_amortiza + c.compra_saldo),0.0)            
   ,      'venta_capital_201'        = isnull((c.compra_amortiza + c.compra_saldo),0.0)             
                           * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.compra_moneda)            
   ,      'Recibimos_Monto_212'      = isnull((c.compra_amortiza),0.0)            
   ,      'Pagamos_Monto_213'        = isnull((c.compra_amortiza),0.0)             
                                     * CASE WHEN (c.compra_moneda) <> 998 THEN (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso  AND vmcodigo = c.compra_moneda)            
        ELSE                             (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior AND vmcodigo = c.compra_moneda)              
                                       END             
   ,      'Compra_Amortiza_Peso_222' = isnull((c.compra_saldo),0.0)            
   ,      'Venta_Amortiza_Peso_223'  = isnull((c.compra_saldo),0.0) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.compra_moneda)            
   ,      'Forma_de_Pago'            = c.Recibimos_documento            
   ,      'TipOper'                  = 'V'        --> SI Contabilizacion + NO Balance    
   ,      'SubCartera_917'           = CONVERT(NUMERIC(4), 0)            
   FROM    #CARTERA c            
   WHERE   c.Tipo_Swap               = 4            
   AND     c.Tipo_Flujo              = 1            
   AND     c.fecha_vence_flujo       BETWEEN  DATEADD(DAY,1,@FechaAnt)  AND  @Fecha_Hoy            
   -- AND NOT (c.fecha_cierre           = c.fecha_inicio_flujo and c.fecha_cierre = c.fecha_vence_flujo AND c.compra_amortiza < 0)            
   AND NOT ( c.fecha_inicio_flujo = c.fecha_vence_flujo )     -- MAP DJ             
   IF @@ERROR <> 0            
   BEGIN            
      PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. VCT SPC'            
      RETURN 1            
   END            
            
   --     PRINT 'NORMAL - O'            
   INSERT INTO BAC_CNT_CONTABILIZA          
   (      id_sistema,     tipo_movimiento, tipo_operacion,  operacion,     correlativo,          codigo_instrumento,  moneda_instrumento, tipo_cliente, cartera_inversion            
   ,      compra_capital, venta_capital,   Recibimos_Monto, Pagamos_Monto, compra_amortiza_peso, venta_amortiza_peso, Forma_de_Pago            
   ,      TipOper,        SubCartera            
   )             
   SELECT 'id_sistema'               = 'PCS'            
   ,      'tipo_movimiento'          = 'VCT'  --2            
   ,      'tipo_operacion'           = 'G' + CONVERT(CHAR(1),LTRIM(RTRIM(c.Tipo_Swap))) + CASE WHEN c.tipo_flujo = 1 THEN 'C' ELSE 'V' END            
   ,      'operacion'                = c.numero_operacion            
   ,      'correlativo'              = c.numero_flujo --1            
   ,      'codigo_instrumento'       = ''            
   ,      'moneda_instrumento'       = CONVERT(CHAR(03),c.compra_moneda)            
   ,      'tipo_cliente'             = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
   ,      'cartera_inversion'        = c.cartera_inversion            
   ,    'compra_capital_200'       = isnull((c.compra_amortiza  + c.compra_saldo + c.Compra_Flujo_Adicional),0.0)            
,      'venta_capital_201'        = isnull((c.compra_amortiza  + c.compra_saldo + c.Compra_Flujo_Adicional),0.0)             
                                     * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.compra_moneda)            
   ,      'Recibimos_Monto_212'      = isnull(( c.compra_amortiza + c.Compra_Flujo_Adicional ),0.0)            
   ,      'Pagamos_Monto_213'        = isnull(( c.compra_amortiza + c.Compra_Flujo_Adicional ),0.0)             
                                     * CASE WHEN c.compra_moneda <> 998 THEN (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso  AND vmcodigo = c.compra_moneda)            
          ELSE                             (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior AND vmcodigo = c.compra_moneda)               
                                       END            
   ,      'Compra_Amortiza_Peso_222' = isnull((c.compra_saldo ),0.0)            
   ,      'Venta_Amortiza_Peso_223'  = isnull((c.compra_saldo ),0.0) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.compra_moneda)            
   ,      'Forma_de_Pago'            = c.Recibimos_documento            
   ,      'TipOper'                  = 'V'        --> SI Contabilizacion + NO Balance    
   ,      'SubCartera_917'           = CONVERT(NUMERIC(4), 0)            
   FROM    #CARTERA c            
   WHERE   c.Tipo_Swap               = 2            
   AND     c.Tipo_Flujo              = 1            
   AND     c.fecha_vence_flujo       BETWEEN  DATEADD(DAY,1,@FechaAnt) AND @Fecha_Hoy            
   AND NOT (c.compra_amortiza         = 0 and c.compra_flujo_adicional > 0 and c.compra_moneda = 998) --> Retira la Amortizacion de las UF, dado que esto lo hace el Perfil de Reajustes            
   --AND NOT (c.fecha_cierre            = c.fecha_inicio_flujo         and c.fecha_cierre  = c.fecha_vence_flujo and c.compra_amortiza < 0)            
   AND NOT ( c.fecha_inicio_flujo = c.fecha_vence_flujo )   -- MAP DJ               
   --> Dejar fueta las amortiozaciones que se dan en el primer flujo con fecha Fence flujo = fecha Hoy            
            
            
            
   IF @@ERROR <> 0            
   BEGIN            
      PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. VCT CCS 1'            
      RETURN 1            
   END            
            
   --     PRINT 'NORMAL - P'            
   INSERT INTO BAC_CNT_CONTABILIZA       
   (      id_sistema,     tipo_movimiento, tipo_operacion,  operacion,     correlativo,     codigo_instrumento,  moneda_instrumento, tipo_cliente, cartera_inversion            
   ,      compra_capital, venta_capital,   Recibimos_Monto, Pagamos_Monto, compra_amortiza_peso, venta_amortiza_peso, Forma_de_Pago            
   ,      TipOper,     SubCartera         
   )             
   SELECT 'id_sistema'               = 'PCS'            
   ,      'tipo_movimiento'          = 'VCT'   --3            
   ,      'tipo_operacion'           = 'G' + CONVERT(CHAR(1),LTRIM(RTRIM(c.Tipo_Swap))) + CASE WHEN c.tipo_flujo = 1 THEN 'C' ELSE 'V' END            
   ,      'operacion'                = c.numero_operacion            
   ,      'correlativo'              = c.numero_flujo --1            
   ,      'codigo_instrumento'       = ''            
   ,      'moneda_instrumento'       = CONVERT(CHAR(03),c.venta_moneda)            
   ,      'tipo_cliente'             = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
   ,      'cartera_inversion'        = c.cartera_inversion            
   ,      'compra_capital_200'       = isnull((c.venta_amortiza + c.venta_saldo + c.venta_Flujo_Adicional ),0.0)            
   ,      'venta_capital_201'        = isnull((c.venta_amortiza + c.venta_saldo + c.venta_Flujo_adicional ),0.0)             
                                     * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.venta_moneda)            
   ,      'Recibimos_Monto_212'      = isnull((c.venta_amortiza + c.Venta_flujo_adicional ),0.0)            
   ,      'Pagamos_Monto_213'        = isnull((c.venta_amortiza + c.Venta_flujo_adicional ),0.0)             
                                     * CASE WHEN c.venta_moneda <> 998 THEN (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.venta_moneda)            
                                     ELSE                            (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior AND vmcodigo = c.venta_moneda)                   
             END             
   ,   'Compra_Amortiza_Peso_222' = isnull((c.venta_saldo),0.0)            
   ,      'Venta_Amortiza_Peso_223'  = isnull((c.venta_saldo),0.0) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.venta_moneda)            
   ,      'Forma_de_Pago'            = c.Pagamos_documento            
   ,      'TipOper'                  = 'V'        --> SI Contabilizacion + NO Balance    
   ,      'SubCartera_917'           = CONVERT(NUMERIC(4), 0)            
   FROM    #CARTERA c       
   WHERE   c.Tipo_Swap               = 2            
   AND     c.Tipo_Flujo              = 2            
   AND     c.fecha_vence_flujo    BETWEEN  DATEADD(DAY,1,@FechaAnt) AND @Fecha_Hoy            
   AND NOT (c.venta_amortiza         = 0 and c.venta_flujo_adicional > 0 and c.venta_moneda = 998) --> Retira la Amortizacion de las UF, dado que esto lo hace el Perfil de Reajustes            
   -- AND NOT (c.fecha_cierre           = c.fecha_inicio_flujo and c.fecha_cierre = c.fecha_vence_flujo and c.venta_amortiza < 0)            
   AND NOT ( c.fecha_inicio_flujo = c.fecha_vence_flujo )       -- MAP DJ        
   --> Dejar fueta las amortiozaciones que se dan en el primer flujo con fecha Fence flujo = fecha Hoy            
            
   IF @@ERROR <> 0            
   BEGIN            
      PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. VCT CCS 2'            
      RETURN 1            
   END            
            
   -->>>>>>>>>>>> SEGREGACION POR PATA >>>>>>>>>>>>>>>>>>>--            
   INSERT INTO BAC_CNT_CONTABILIZA            
   (      id_sistema,     tipo_movimiento, tipo_operacion,  operacion,     correlativo,          codigo_instrumento, moneda_instrumento, tipo_cliente, cartera_inversion            
   ,      compra_capital, venta_capital,   Recibimos_Monto, pagamos_monto, compra_amortiza_peso, venta_amortiza_peso             
   ,      Forma_de_Pago,  TipOper,         SubCartera            
   )            
   SELECT 'id_sistema'               = 'PCS'            
   ,      'tipo_movimiento'          = 'VCT'            
   ,      'tipo_operacion'           = 'G' + CONVERT(CHAR(1),LTRIM(RTRIM(c.Tipo_Swap))) + 'C'            
   ,      'operacion'                = c.numero_operacion            
   ,      'correlativo'              = c.numero_flujo            
,      'codigo_instrumento'   = ''            
   ,      'moneda_instrumento'       = CONVERT(CHAR(03),c.compra_moneda)            
   ,      'tipo_cliente'             = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
   ,      'cartera_inversion'        = c.cartera_inversion            
   ,      'compra_capital_200'       = isnull((c.compra_amortiza + c.compra_saldo),0.0)            
   ,      'venta_capital_201'        = isnull((c.compra_amortiza + c.compra_saldo),0.0)             
                                     * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.compra_moneda)            
   ,      'Recibimos_Monto_212'      = isnull((c.compra_amortiza),0.0)            
   ,      'Pagamos_Monto_213'        = isnull((c.compra_amortiza),0.0)             
                                     * CASE WHEN (c.compra_moneda) <> 998 THEN (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso  AND vmcodigo = c.compra_moneda)            
         ELSE                              (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior AND vmcodigo = c.compra_moneda)              
                                       END             
   ,      'Compra_Amortiza_Peso_222' = isnull((c.compra_saldo),0.0)            
   ,      'Venta_Amortiza_Peso_223'  = isnull((c.compra_saldo),0.0) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.compra_moneda)          
,      'Forma_de_Pago'            = c.Recibimos_documento            
   ,      'TipOper'                  = 'V'        --> SI Contabilizacion + NO Balance    
   ,     'SubCartera_917'         = CONVERT(NUMERIC(4), 0)            
   FROM    #CARTERA  c            
   WHERE   c.Tipo_Swap               = 1            
   AND     c.Tipo_Flujo              = 1            
   AND     c.fecha_vence_flujo       BETWEEN  DATEADD(DAY,1, @FechaAnt) AND @Fecha_Hoy            
   -- AND NOT(c.fecha_cierre            = c.fecha_inicio_flujo and c.fecha_cierre = c.fecha_vence_flujo and c.compra_amortiza < 0)            
   AND NOT ( c.fecha_inicio_flujo = c.fecha_vence_flujo )      -- MAP DJ            
   --> Dejar fueta las amortiozaciones que se dan en el primer flujo con fecha Fence flujo = fecha Hoy            
            
   IF @@ERROR <> 0            
   BEGIN            
      PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. VCT IRS 1'            
      RETURN 1            
   END            
            
   INSERT INTO BAC_CNT_CONTABILIZA            
   (      id_sistema,     tipo_movimiento, tipo_operacion,  operacion,     correlativo,          codigo_instrumento, moneda_instrumento, tipo_cliente, cartera_inversion            
   ,      compra_capital, venta_capital,   Recibimos_Monto, pagamos_monto, compra_amortiza_peso, venta_amortiza_peso             
   ,      Forma_de_Pago,  TipOper,         SubCartera            
   )             
   SELECT 'id_sistema'               = 'PCS'            
   ,      'tipo_movimiento'          = 'VCT'            
   ,      'tipo_operacion'           = 'G' + CONVERT(CHAR(1),LTRIM(RTRIM(c.Tipo_Swap))) + 'V'            
   ,      'operacion'                = c.numero_operacion            
   ,      'correlativo'              = c.numero_flujo            
   ,      'codigo_instrumento'       = ''            
   ,      'moneda_instrumento'       = CONVERT(CHAR(03),c.venta_moneda)            
   ,      'tipo_cliente'             = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
   ,      'cartera_inversion'        = c.cartera_inversion            
   ,      'compra_capital_200'       = isnull((c.venta_amortiza + c.venta_saldo),0.0)            
   ,      'venta_capital_201'        = isnull((c.venta_amortiza + c.venta_saldo),0.0)            
                                     * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.venta_moneda)            
   ,      'Recibimos_Monto_212'      = isnull((c.venta_amortiza),0.0)            
   ,      'Pagamos_Monto_213'        = isnull((c.venta_amortiza),0.0)             
 * CASE WHEN (c.venta_moneda) <> 998 THEN (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso  AND vmcodigo = c.venta_moneda)            
         ELSE    (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior AND vmcodigo = c.venta_moneda)            
   END             
   ,      'Compra_Amortiza_Peso_222' = isnull((c.venta_saldo),0.0)            
   ,      'Venta_Amortiza_Peso_223'  = isnull((c.venta_saldo),0.0) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.venta_moneda)            
   ,      'Forma_de_Pago'            = c.Pagamos_documento            
   ,      'TipOper'                  = 'V'        --> SI Contabilizacion + NO Balance    
   ,      'SubCartera_917'           = CONVERT(NUMERIC(4), 0)            
   FROM    #CARTERA  c            
   WHERE   c.fecha_vence_flujo       BETWEEN  DATEADD(DAY,1, @FechaAnt) AND @Fecha_Hoy            
   AND     c.Tipo_Swap               = 1            
   AND     c.Tipo_Flujo              = 2            
   -- AND NOT(c.fecha_cierre            = c.fecha_inicio_flujo and c.fecha_cierre = c.fecha_vence_flujo and c.venta_amortiza < 0)            
   AND NOT ( c.fecha_inicio_flujo = c.fecha_vence_flujo )    -- MAP DJ              
   --> Dejar fueta las amortiozaciones que se dan en el primer flujo con fecha Fence flujo = fecha Hoy            
            
   IF @@ERROR <> 0            
   BEGIN            
      PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. VCT IRS 2'            
      RETURN 1            
   END            
   -->>>>>>>>>>>> SEGREGACION POR PATA >>>>>>>>>>>>>>>>>>>--            
            
            
   --<<<<<<<<< Forward Rate Agreement >>>>>>>>>--             
   --> Movimiento <--            
   --     PRINT 'NORMAL - Q'            
   INSERT INTO BAC_CNT_CONTABILIZA            
   (   id_sistema     , tipo_movimiento , tipo_operacion    , operacion        , correlativo     , codigo_instrumento      , moneda_instrumento     , tipo_cliente            , cartera_inversion            
   ,   compra_capital , venta_capital   , venta_capital_Ant , devengo_utilidad , devengo_perdida , Monto_diferido_utilidad , Monto_diferido_perdida , Monto_Utilidad_Valoriza , Monto_Perdida_Valoriza            
   ,   Compra_Interes , Venta_Interes   , TipOper           , SubCartera            
   )             
   SELECT 'id_sistema'                  = 'PCS'            
   ,      'tipo_movimiento'             = 'MOV'            
   ,      'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + CONVERT(CHAR(1),c.tipo_operacion)            
   ,      'operacion'                   = c.Numero_Operacion            
   ,      'correlativo'                 = c.Numero_Flujo            
   ,      'codigo_instrumento'          = ''            
   ,      'moneda_instrumento'          = CONVERT(CHAR(03),c.Compra_Moneda)            
   ,      'tipo_cliente'                = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
   ,      'cartera_inversion'           = c.cartera_inversion            
   ,      'compra_capital_200'          = CASE WHEN c.compra_capital     <> 0.0 THEN (c.compra_amortiza + c.compra_saldo)            
                                               ELSE                                  (c.venta_amortiza  + c.venta_saldo)            
                                          END            
   ,      'venta_capital_201'           = CASE WHEN c.compra_capital     <> 0.0 THEN (c.compra_amortiza + c.compra_saldo)            
                                               ELSE                                  (c.venta_amortiza + c.venta_saldo)            
                                          END * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.compra_moneda)            
   ,      'venta_capital_Ant_203'       = CASE WHEN c.fecha_cierre    = @fecha_hoy THEN 0.0            
                                               WHEN c.compra_capital <> 0.0        THEN (c.compra_amortiza + c.compra_saldo)            
                                               ELSE                             (c.venta_amortiza  + c.venta_saldo)            
                                          END * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior  AND vmcodigo = c.compra_moneda)            
   ,      'devengo_utilidad_204'        = CASE WHEN c.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
   ,      'devengo_perdida_205'         = CASE WHEN c.Valor_RazonableCLP <  0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
   ,      'Monto_diferido_utilidad_206' = CASE WHEN c.fecha_cierre = @fecha_hoy THEN 0.0            
                                               ELSE (SELECT CASE WHEN r.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(r.Valor_RazonableCLP,0)) ELSE 0.0 END           
                                   FROM CARTERARES r WHERE r.Fecha_Proceso = @dFechaAnterior AND r.numero_operacion = c.numero_operacion AND r.numero_flujo = c.numero_flujo)            
                                          END            
   ,      'Monto_diferido_perdida_207'  = CASE WHEN c.fecha_cierre = @fecha_hoy THEN 0.0            
                                               ELSE (SELECT CASE WHEN r.Valor_RazonableCLP  < 0.0 THEN ABS(ROUND(r.Valor_RazonableCLP,0)) ELSE 0.0 END             
                                                       FROM CARTERARES r WHERE r.Fecha_Proceso = @dFechaAnterior AND r.numero_operacion = c.numero_operacion AND r.numero_flujo = c.numero_flujo)            
                                          END            
   ,      'Monto_Utilidad_Valoriza_208' = CASE WHEN     (c.venta_interes - c.compra_interes) + (v.venta_interes - v.compra_interes) <  0.0 THEN 0.0            
                                               ELSE ABS((c.venta_interes - c.compra_interes) + (v.venta_interes - v.compra_interes))            
                                          END          
   ,      'Monto_Perdida_Valoriza_209'  = CASE WHEN     (c.venta_interes - c.compra_interes) + (v.venta_interes - v.compra_interes) >= 0.0 THEN 0.0            
                                               ELSE ABS((c.venta_interes - c.compra_interes) + (v.venta_interes - v.compra_interes))            
                                          END            
   ,      'Compra_Interes_210'          = c.compra_interes         
   ,      'Venta_Interes_210'         = c.venta_interes            
 ,      'TipOper'                     = 'N'        --> SI Contabilizacion + SI Balance    
   ,  'SubCartera_917'              = CONVERT(NUMERIC(4), 0)            
   FROM   #CARTERA            c            
          INNER JOIN #CARTERA           v with(nolock) ON c.Numero_Operacion = v.Numero_Operacion AND c.Numero_Flujo = v.Numero_Flujo AND v.Tipo_flujo = 2            
   WHERE (c.fecha_cierre                = @fecha_hoy             
       OR c.fecha_cierre                = @FechaHasta)            
   AND    c.numero_flujo                = 1            
   AND    c.Tipo_flujo                  = 1            
   AND    c.tipo_swap                   = 3 --> FRA            
             
   IF @@ERROR <> 0            
   BEGIN            
      PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. MOV FRA'            
      RETURN 1            
   END            
            
   --> Devengamiento <--            
   --     PRINT 'NORMAL - R'            
   INSERT INTO BAC_CNT_CONTABILIZA            
   (   id_sistema       , tipo_movimiento , tipo_operacion          , operacion , correlativo , codigo_instrumento , moneda_instrumento , tipo_cliente , cartera_inversion            
   ,   devengo_utilidad , devengo_perdida , Monto_diferido_utilidad , Monto_diferido_perdida            
   ,   TipOper          , SubCartera            
   )             
   SELECT 'id_sistema'                  = 'PCS'            
   ,     'tipo_movimiento'              = 'DEV'      
   ,      'tipo_operacion'              = 'D' + CONVERT(CHAR(1),c.tipo_swap) + CONVERT(CHAR(1),c.tipo_operacion)            
   ,      'operacion'                   = c.Numero_Operacion            
   ,      'correlativo'                 = 1            
   ,      'codigo_instrumento'          = ''            
   ,      'moneda_instrumento'          = 999            
   ,      'tipo_cliente'                = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
   ,      'cartera_inversion'     = c.cartera_inversion            
   ,      'devengo_utilidad_204'        = CASE WHEN c.fechaliquidacion     = @fecha_hoy THEN 0.0            
                                               WHEN c.Valor_RazonableCLP  >= 0.0        THEN ABS(ROUND(c.Valor_RazonableCLP,0))             
                                               ELSE                                          0.0            
                      END            
   ,      'devengo_perdida_205'         = CASE WHEN c.fechaliquidacion     = @fecha_hoy THEN 0.0            
                                               WHEN c.Valor_RazonableCLP   < 0.0        THEN ABS(ROUND(c.Valor_RazonableCLP,0))             
                                               ELSE                                          0.0            
                                          END            
   ,      'Monto_diferido_utilidad_206' = CASE WHEN c.fecha_cierre = @fecha_hoy     THEN 0.0            
                                   ELSE CASE WHEN r.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(r.Valor_RazonableCLP,0)) ELSE 0.0 END            
                                          END            
   ,    'Monto_diferido_perdida_207'  = CASE WHEN c.fecha_cierre = @fecha_hoy           THEN 0.0            
                                               ELSE CASE WHEN r.Valor_RazonableCLP <  0.0 THEN ABS(ROUND(r.Valor_RazonableCLP,0)) ELSE 0.0 END            
                                          END            
   ,      'TipOper'                     = 'N'        --> SI Contabilizacion + SI Balance    
   ,      'SubCartera_917'              = CONVERT(NUMERIC(4), 0)            
   FROM   #CARTERA c            
          LEFT JOIN CARTERARES r          with(nolock) ON r.Fecha_Proceso = @FechaAnt AND c.Numero_Operacion = r.Numero_Operacion AND c.tipo_flujo = r.Tipo_Flujo AND c.Numero_Flujo = r.Numero_Flujo            
   WHERE  c.Tipo_Flujo                  = 1             
   AND    c.Tipo_Swap                   = 3            
   AND    c.Estado                     <> 'C'            
            
   IF @@ERROR <> 0            
   BEGIN            
      PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. DEV FRA'            
      RETURN 1            
   END            
    
 /* -- Con fecha 19-08-2013 se reira segun mail del 25-06-2013 de Elizabeth Cerda    
  --> Reajustes <--            
  --     PRINT 'NORMAL - S'            
  INSERT INTO BAC_CNT_CONTABILIZA            
  (      id_sistema     , tipo_movimiento , tipo_operacion , operacion , correlativo , codigo_instrumento , moneda_instrumento , tipo_cliente , cartera_inversion            
  ,      compra_capital , venta_capital   , venta_capital_Ant            
  ,      TipOper    , SubCartera            
  )             
  SELECT 'id_sistema'           = 'PCS'            
  ,  'tipo_movimiento'      = 'REA'            
  ,  'tipo_operacion' = 'R' + CONVERT(CHAR(1),LTRIM(RTRIM(c.Tipo_Swap))) + CONVERT(CHAR(1),c.tipo_operacion)            
  ,  'operacion'            = Numero_Operacion            
  ,  'correlativo'          = 1            
  ,  'codigo_instrumento'   = ''            
  ,  'moneda_instrumento'   = CONVERT(CHAR(03),c.Compra_Moneda)            
  ,  'tipo_cliente'         = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
  ,  'cartera_inversion'    = c.Cartera_Inversion            
  ,  'compra_capital_200'   = (c.compra_amortiza + c.compra_saldo)            
  ,  'venta_capital_201'    = (c.compra_amortiza + c.compra_saldo) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso  AND vmcodigo = c.compra_moneda)            
  ,  'venta_capital_Ant_203'= (c.compra_amortiza + c.compra_saldo) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior AND vmcodigo = c.compra_moneda)            
  ,  'TipOper'              = 'N'            
  ,  'SubCartera_917'       = CONVERT(NUMERIC(4), 0)            
  FROM #CARTERA c            
  WHERE  (c.Tipo_Swap           = 3)            
  AND    (c.Tipo_Flujo          = 1)            
  AND    (c.Compra_Moneda       = 998)            
  AND    (c.Fecha_Cierre        < @fecha_hoy and c.FechaLiquidacion > @fecha_hoy )            
    
  IF @@ERROR <> 0            
  BEGIN            
   PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. REA FRA'            
   RETURN 1            
  END            
 */ -- Con fecha 19-08-2013 se reira segun mail del 25-06-2013 de Elizabeth Cerda    
    
   --> Amortizacion <--            
   --     PRINT 'NORMAL - U'            
   INSERT INTO BAC_CNT_CONTABILIZA            
   (      id_sistema , tipo_movimiento , tipo_operacion , operacion , correlativo , codigo_instrumento , moneda_instrumento , tipo_cliente , cartera_inversion            
   ,      compra_capital , venta_capital , Recibimos_Monto , Pagamos_Monto , Compra_Amortiza_Peso , Venta_Amortiza_Peso , Forma_de_Pago            
   ,      TipOper        , SubCartera            
   )             
   SELECT 'id_sistema'               = 'PCS'            
   ,      'tipo_movimiento'          = 'VCT'  --4            
   ,      'tipo_operacion'           = 'G' + CONVERT(CHAR(1),LTRIM(RTRIM(c.Tipo_Swap))) + CONVERT(CHAR(1),c.tipo_operacion)            
   ,      'operacion'                = c.numero_operacion               
   ,      'correlativo'       = c.numero_flujo --1            
   ,      'codigo_instrumento'       = ''            
   ,      'moneda_instrumento'       = CONVERT(CHAR(03),c.compra_moneda)            
   ,      'tipo_cliente'             = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
   ,      'cartera_inversion'        = c.cartera_inversion            
   ,      'compra_capital_200'       = isnull((c.compra_amortiza + c.compra_saldo), 0.0)            
   ,   'venta_capital_201'        = isnull((c.compra_amortiza + c.compra_saldo), 0.0) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.compra_moneda)            
   ,      'Recibimos_Monto_212'      = isnull((c.compra_amortiza), 0.0)            
   ,      'Pagamos_Monto_213'        = isnull((c.compra_amortiza), 0.0) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.compra_moneda)            
   ,      'Compra_Amortiza_Peso_222' = isnull((c.compra_saldo   ), 0.0)            
   ,      'Venta_Amortiza_Peso_223'  = isnull((c.compra_saldo   ), 0.0) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.compra_moneda)            
   ,      'Forma_de_Pago'            = c.Recibimos_documento            
   ,      'TipOper'             = 'V'        --> SI Contabilizacion + NO Balance    
   ,      'SubCartera_917'           = CONVERT(NUMERIC(4), 0)            
   FROM    #CARTERA c            
   WHERE   c.fecha_vence_flujo    BETWEEN  DATEADD(DAY,1,@FechaAnt)  AND  @Fecha_Hoy  -- ' CER - 10/11/2008  - Se cambia fecha de Liquidación por fecha de vcto. y @FechaHasta por @Fecha_Hoy             
   AND     c.Tipo_Swap               = 3            
   AND     c.Tipo_Flujo              = 1            
   AND     c.Compra_Amortiza         > 0.0            
            
   IF @@ERROR <> 0            
   BEGIN            
      PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. VCT FRA'            
      RETURN 1            
   END            
   --<<<<<<<<< Forward Rate Agreement >>>>>>>>>--             
    
    
    
    
    
    
   -- === SOLO INTERFAZ === --            
   -- <<< PARA BALANCE  >>> --            
   --     PRINT 'BALANCE - A'            
   INSERT INTO BAC_CNT_CONTABILIZA            
(   id_sistema     , tipo_movimiento , tipo_operacion    , operacion        , correlativo , codigo_instrumento      , moneda_instrumento     , tipo_cliente            , cartera_inversion       
   ,   compra_capital , venta_capital   , venta_capital_Ant , devengo_utilidad , devengo_perdida , Monto_diferido_utilidad , Monto_diferido_perdida , Monto_Utilidad_Valoriza , Monto_Perdida_Valoriza       
   ,   Compra_Interes , Venta_Interes   , compra_moneda     , venta_moneda            
   ,   TipOper        , SubCartera            
   )             
   SELECT 'id_sistema'                  = 'PCS'            
   ,      'tipo_movimiento'             = 'MOV'            
   ,      'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'C'            
   ,      'operacion'     = c.Numero_Operacion            
   ,      'correlativo'     = c.tipo_flujo            
  ,      'codigo_instrumento'          = ''            
   ,      'moneda_instrumento'          = CONVERT(CHAR(03),c.Compra_Moneda)            
   ,      'tipo_cliente'                = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
   ,      'cartera_inversion'           = c.cartera_inversion            
   ,      'compra_capital_200'          = (c.compra_amortiza + c.compra_saldo + c.compra_flujo_adicional )            
   ,      'venta_capital_201'           = (c.compra_amortiza + c.compra_saldo + c.compra_flujo_adicional ) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.compra_moneda)            
   ,      'venta_capital_Ant_203'       = CASE WHEN c.fecha_cierre = @fecha_hoy THEN 0.0            
                                               ELSE                                  (c.compra_amortiza + c.compra_saldo)            
                                          END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior  AND vmcodigo = c.compra_moneda)            
   ,      'devengo_utilidad_204'        = CASE WHEN c.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
   ,      'devengo_perdida_205'         = CASE WHEN c.Valor_RazonableCLP <  0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
   ,      'Monto_diferido_utilidad_206' = 0.0            
   ,      'Monto_diferido_perdida_207'  = 0.0            
   ,      'Monto_Utilidad_Valoriza_208' = 0.0            
   ,      'Monto_Perdida_Valoriza_209'  = 0.0            
   ,      'Compra_Interes_210'          = c.compra_interes            
   ,      'Venta_Interes_210'           = 0.0            
   ,      'compra_moneda'               = c.Compra_Moneda            
   ,      'venta_moneda'                = 0.0            
   ,      'TipOper'                     = 'S'        --> NO Contabilizacion + SI Balance    
   ,      'SubCartera_917'              = CONVERT(NUMERIC(4), 0)            
   FROM   #CARTERA            c            
WHERE  c.tipo_swap                   = 2            
   AND    c.Tipo_flujo                  = 1               
   AND    c.compra_moneda               NOT IN(998,997,994)            
   AND   (c.fecha_cierre                < @fecha_hoy AND c.fecha_termino > @Fecha_Hoy)                     
   and c.fecha_cierre <> @dFechaProceso      
   AND    c.Estado_Flujo                = 1            
       
 --     PRINT 'BALANCE - B'            
   INSERT INTO BAC_CNT_CONTABILIZA            
   (   id_sistema     , tipo_movimiento , tipo_operacion    , operacion        , correlativo     , codigo_instrumento      , moneda_instrumento  , tipo_cliente            , cartera_inversion            
   ,   compra_capital , venta_capital   , venta_capital_Ant , devengo_utilidad , devengo_perdida , Monto_diferido_utilidad , Monto_diferido_perdida , Monto_Utilidad_Valoriza , Monto_Perdida_Valoriza            
   ,   Compra_Interes , Venta_Interes   , compra_moneda     , venta_moneda            
   ,   TipOper        , SubCartera             
   )             
            
   SELECT 'id_sistema'                  = 'PCS'            
   ,      'tipo_movimiento'             = 'MOV'            
   ,      'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'V'            
   ,      'operacion'              = c.Numero_Operacion            
   ,      'correlativo'                 = c.tipo_flujo            
   ,      'codigo_instrumento'          = ''            
   ,      'moneda_instrumento'          = CONVERT(CHAR(03),c.Venta_Moneda)            
   ,      'tipo_cliente'                = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
   ,      'cartera_inversion'           = c.cartera_inversion            
   ,      'compra_capital_200'          = (c.venta_amortiza + c.venta_saldo + c.venta_flujo_adicional)            
   ,      'venta_capital_201'           = (c.venta_amortiza + c.venta_saldo + c.venta_flujo_adicional) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.venta_moneda)            
   ,      'venta_capital_Ant_203'       = CASE WHEN c.fecha_cierre = @fecha_hoy THEN 0.0            
                                               ELSE                                  (c.venta_amortiza + c.venta_saldo + c.venta_flujo_adicional)             
                                          END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior AND vmcodigo = c.venta_moneda)            
   ,      'devengo_utilidad_204'        = CASE WHEN c.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
   ,      'devengo_perdida_205'         = CASE WHEN c.Valor_RazonableCLP <  0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
   ,      'Monto_diferido_utilidad_206' = 0.0            
   ,    'Monto_diferido_perdida_207'  = 0.0            
   ,      'Monto_Utilidad_Valoriza_208' = CASE WHEN     (c.venta_interes - c.compra_interes)  <  0.0 THEN 0.0          
                                               ELSE ABS((c.venta_interes - c.compra_interes))            
                                          END            
   ,      'Monto_Perdida_Valoriza_209'  = CASE WHEN     (c.venta_interes - c.compra_interes)  >= 0.0 THEN 0.0            
                                               ELSE ABS((c.venta_interes - c.compra_interes))            
                                          END            
   ,      'Compra_Interes_210'          = c.compra_interes            
   ,      'Venta_Interes_210'           = c.venta_interes            
   ,      'compra_moneda'               = c.Compra_Moneda            
   ,      'venta_moneda'                = c.Venta_Moneda            
   ,      'TipOper'                     = 'S'        --> NO Contabilizacion + SI Balance    
   ,      'SubCartera_917'              = CONVERT(NUMERIC(4), 0)            
   FROM   #CARTERA                 c            
   WHERE  c.tipo_swap                   = 2            
   AND    c.Tipo_flujo                  = 2            
   AND    c.venta_moneda                NOT IN(998,997,994)        
   AND   (c.fecha_cierre                < @fecha_hoy AND c.fecha_termino > @Fecha_Hoy)            
   AND    c.Estado_Flujo                = 1            
   AND    c.fecha_cierre               <> @dFechaMvt            
            
   --     PRINT 'BALANCE - C'            
   INSERT INTO BAC_CNT_CONTABILIZA            
   (   id_sistema     , tipo_movimiento, tipo_operacion,    operacion,        correlativo,     codigo_instrumento,      moneda_instrumento, tipo_cliente,            cartera_inversion            
   ,   compra_capital , venta_capital,   venta_capital_Ant, devengo_utilidad, devengo_perdida, Monto_diferido_utilidad, Monto_diferido_perdida, Monto_Utilidad_Valoriza, Monto_Perdida_Valoriza            
   ,   Compra_Interes , Venta_Interes            
   ,   TipOper        , SubCartera            
   )             
   SELECT 'id_sistema'                  = 'PCS'            
   ,      'tipo_movimiento'             = 'MOV'            
   ,      'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap)            
   ,      'operacion'                   = c.Numero_Operacion            
   ,      'correlativo'                 = c.Numero_Flujo            
   ,     'codigo_instrumento'           = ''            
   ,      'moneda_instrumento'          = CASE WHEN c.tipo_swap = 1 THEN CONVERT(CHAR(03),c.Compra_Moneda)            
            WHEN c.tipo_swap  = 4 THEN CONVERT(CHAR(03),c.Compra_Moneda)            
            WHEN c.tipo_swap  = 2 THEN CONVERT(CHAR(03),c.Compra_Moneda)            
            ELSE                     ''            
  END            
   ,      'tipo_cliente'                = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
   ,      'cartera_inversion'           = c.cartera_inversion            
   ,      'compra_capital_200'          = CASE WHEN c.compra_capital <> 0.0 THEN (c.compra_amortiza + c.compra_saldo)            
           ELSE        (c.venta_amortiza  + c.venta_saldo)            
                                          END            
   ,      'venta_capital_201'           = CASE WHEN c.compra_capital <> 0.0 THEN (c.compra_amortiza + c.compra_saldo)            
                                               ELSE                              (c.venta_amortiza  + c.venta_saldo)            
                                          END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso  AND vmcodigo = c.compra_moneda)            
   ,      'venta_capital_Ant_203'       = CASE WHEN c.fecha_cierre    = @fecha_hoy THEN 0.0            
                                               WHEN c.compra_capital <> 0.0        THEN (c.compra_amortiza + c.compra_saldo)            
                                               ELSE                                     (c.venta_amortiza  + c.venta_saldo)            
                                          END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior AND vmcodigo = c.compra_moneda)            
   ,      'devengo_utilidad_204'        = CASE WHEN c.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
   ,      'devengo_perdida_205'         = CASE WHEN c.Valor_RazonableCLP <  0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
   ,      'Monto_diferido_utilidad_206' = 0.0            
   ,      'Monto_diferido_perdida_207'  = 0.0            
   ,      'Monto_Utilidad_Valoriza_208' = 0.0            
   ,      'Monto_Perdida_Valoriza_209'  = 0.0             
   ,      'Compra_Interes_210'          = c.compra_interes            
   ,      'Venta_Interes_210'           = c.venta_interes            
   ,      'TipOper'                     = 'S'        --> NO Contabilizacion + SI Balance    
   ,      'SubCartera_917'              = CONVERT(NUMERIC(4), 0)            
   FROM   #CARTERA      c            
   WHERE  c.tipo_swap                   = 4    
   AND    c.Tipo_flujo                  = 1            
   AND    c.compra_moneda               NOT IN(998,997,994)            
   AND   (c.fecha_cierre                < @dFechaMvt AND c.fecha_termino > @dFechaMvt)            
   AND    c.Estado_Flujo                = 1            
            
            
   --->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>            
   INSERT INTO BAC_CNT_CONTABILIZA            
   (   id_sistema     , tipo_movimiento, tipo_operacion,    operacion,        correlativo,     codigo_instrumento,      moneda_instrumento,     tipo_cliente,            cartera_inversion            
   ,   compra_capital , venta_capital,   venta_capital_Ant, devengo_utilidad, devengo_perdida, Monto_diferido_utilidad, Monto_diferido_perdida, Monto_Utilidad_Valoriza, Monto_Perdida_Valoriza            
   ,   Compra_Interes , Venta_Interes            
   ,   TipOper        , SubCartera            
   )             
   SELECT 'id_sistema'     = 'PCS'            
   ,      'tipo_movimiento'             = 'MOV'            
   ,      'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'C'            
   ,      'operacion'                   = c.Numero_Operacion            
   ,      'correlativo'                 = c.Numero_Flujo            
   ,      'codigo_instrumento'          = ''            
   ,      'moneda_instrumento'          = CONVERT(CHAR(03),c.Compra_Moneda)            
   ,      'tipo_cliente'                = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END        
   ,      'cartera_inversion'           = c.cartera_inversion            
   ,      'compra_capital_200'          = (c.compra_amortiza + c.compra_saldo)            
   ,      'venta_capital_201'           = (c.compra_amortiza + c.compra_saldo) * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso  AND vmcodigo = c.compra_moneda)            
   ,      'venta_capital_Ant_203'       = CASE WHEN c.fecha_cierre  = @fecha_hoy THEN 0.0            
            ELSE                   (c.compra_amortiza + c.compra_saldo)       
                                          END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior AND vmcodigo = c.compra_moneda)            
   ,      'devengo_utilidad_204'        = CASE WHEN c.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
   ,      'devengo_perdida_205'         = CASE WHEN c.Valor_RazonableCLP <  0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
   ,      'Monto_diferido_utilidad_206' = 0.0            
   ,      'Monto_diferido_perdida_207'  = 0.0            
   ,      'Monto_Utilidad_Valoriza_208' = 0.0            
   ,      'Monto_Perdida_Valoriza_209'  = 0.0             
   ,      'Compra_Interes_210'          = c.compra_interes            
   ,      'Venta_Interes_210'           = c.venta_interes            
   ,      'TipOper'                     = 'S'  --> NO Contabilizacion + SI Balance    
   ,      'SubCartera_917'              = CONVERT(NUMERIC(4), 0)            
   FROM   #CARTERA      c            
   WHERE  c.tipo_swap                   = 1            
   AND    c.Tipo_flujo                  = 1            
   AND    c.compra_moneda            NOT IN(998,997,994)            
   AND   (c.fecha_cierre                < @dFechaMvt AND c.fecha_termino > @dFechaMvt)            
   AND    c.Estado_Flujo                = 1            
    
  /*    
  -->   Genera la Duplicidad en Interfaz de Balance por Operacion    
  INSERT INTO BAC_CNT_CONTABILIZA            
  (   id_sistema     , tipo_movimiento, tipo_operacion,    operacion,        correlativo,     codigo_instrumento,      moneda_instrumento, tipo_cliente,            cartera_inversion            
  ,   compra_capital , venta_capital,   venta_capital_Ant, devengo_utilidad, devengo_perdida, Monto_diferido_utilidad, Monto_diferido_perdida, Monto_Utilidad_Valoriza, Monto_Perdida_Valoriza            
  ,   Compra_Interes , Venta_Interes            
  ,   TipOper        , SubCartera            
  )             
  SELECT 'id_sistema'                  = 'PCS'            
  ,      'tipo_movimiento'             = 'MOV'            
  ,      'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + 'V'            
  ,      'operacion'               = c.Numero_Operacion            
  ,      'correlativo'                 = c.Numero_Flujo            
  ,      'codigo_instrumento'          = ''            
  ,      'moneda_instrumento'          = CONVERT(CHAR(03),c.venta_Moneda)            
  ,      'tipo_cliente'                = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
  ,      'cartera_inversion'           =  c.cartera_inversion            
  ,      'compra_capital_200'          = (c.venta_amortiza + c.venta_saldo)            
  ,      'venta_capital_201'           = (c.venta_amortiza + c.venta_saldo)     
            * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.venta_moneda)    
  ,      'venta_capital_Ant_203'       = CASE  WHEN c.fecha_cierre = @fecha_hoy THEN 0.0    
              ELSE                                  (c.venta_amortiza + c.venta_saldo)    
            END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior AND vmcodigo = c.venta_moneda)    
  ,      'devengo_utilidad_204'        = CASE  WHEN c.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
  ,      'devengo_perdida_205'         = CASE  WHEN c.Valor_RazonableCLP <  0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
  ,      'Monto_diferido_utilidad_206' = 0.0    
  ,      'Monto_diferido_perdida_207'  = 0.0    
  ,      'Monto_Utilidad_Valoriza_208' = 0.0    
  ,    'Monto_Perdida_Valoriza_209'  = 0.0    
  ,      'Compra_Interes_210'          = c.compra_interes    
  ,      'Venta_Interes_210'           = c.venta_interes    
  ,      'TipOper'                     = 'S'        --> NO Contabilizacion + SI Balance    
  ,      'SubCartera_917'           = CONVERT(NUMERIC(4), 0)            
  FROM   #CARTERA       c    
  WHERE  c.tipo_swap                   = 1            
  AND    c.Tipo_flujo                  = 2            
  AND    c.compra_moneda    NOT IN(998,997,994)            
  AND   (c.fecha_cierre                < @dFechaMvt AND c.fecha_termino > @dFechaMvt)            
  AND    c.Estado_Flujo                = 1            
  -->   Genera la Duplicidad en Interfaz de Balance por Operacion    
  */    
    
   --->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>            
    
    
   --     PRINT 'BALANCE - D'            
   INSERT INTO BAC_CNT_CONTABILIZA            
   (   id_sistema     , tipo_movimiento , tipo_operacion    , operacion        , correlativo     , codigo_instrumento      , moneda_instrumento  , tipo_cliente            , cartera_inversion            
   ,   compra_capital , venta_capital   , venta_capital_Ant , devengo_utilidad , devengo_perdida , Monto_diferido_utilidad , Monto_diferido_perdida , Monto_Utilidad_Valoriza , Monto_Perdida_Valoriza            
   ,   Compra_Interes , Venta_Interes            
   ,   TipOper        , SubCartera            
   )             
   SELECT 'id_sistema'                  = 'PCS'            
   ,   'tipo_movimiento'             = 'MOV'            
   ,      'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap) + CONVERT(CHAR(1),c.tipo_operacion)            
   ,      'operacion'                   = c.Numero_Operacion            
   ,      'correlativo'                 = c.Numero_Flujo            
   ,      'codigo_instrumento'          = ''            
   ,      'moneda_instrumento'          = CONVERT(CHAR(03),c.Compra_Moneda)            
   ,      'tipo_cliente'       = CASE WHEN c.clpais = 6 THEN '1' ELSE '2' END            
   ,      'cartera_inversion'           = c.cartera_inversion            
   ,      'compra_capital_200'          = CASE WHEN c.compra_capital     <> 0.0 THEN (c.compra_amortiza + c.compra_saldo)            
                                               ELSE                                  (c.venta_amortiza  + c.venta_saldo)            
                                          END            
   ,      'venta_capital_201'           = CASE WHEN c.compra_capital     <> 0.0 THEN (c.compra_amortiza + c.compra_saldo)            
                                               ELSE                    (c.venta_amortiza  + c.venta_saldo)            
                                          END * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaProceso AND vmcodigo = c.compra_moneda)            
   ,      'venta_capital_Ant_203'       = CASE WHEN c.fecha_cierre    = @fecha_hoy THEN 0.0            
                                               WHEN c.compra_capital <> 0.0        THEN (c.compra_amortiza + c.compra_saldo)            
                                               ELSE                                     (c.venta_amortiza  + c.venta_saldo)            
                                          END * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dFechaAnterior AND vmcodigo = c.compra_moneda)            
   ,      'devengo_utilidad_204'        = CASE WHEN c.Valor_RazonableCLP >= 0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
   ,      'devengo_perdida_205'         = CASE WHEN c.Valor_RazonableCLP <  0.0 THEN ABS(ROUND(c.Valor_RazonableCLP,0)) ELSE 0.0 END            
   ,      'Monto_diferido_utilidad_206' = 0.0            
   ,      'Monto_diferido_perdida_207'  = 0.0            
   ,      'Monto_Utilidad_Valoriza_208' = 0.0            
   ,      'Monto_Perdida_Valoriza_209'  = 0.0            
   ,      'Compra_Interes_210'          = c.compra_interes           
 ,      'Venta_Interes_210'           = c.venta_interes            
   ,      'TipOper'                     = 'S'     --> NO Contabilizacion + SI Balance       
   ,      'SubCartera_917'              = CONVERT(NUMERIC(4), 0)            
   FROM   #CARTERA      c       
   WHERE  c.fecha_cierre               < @fecha_hoy AND  c.fechaLiquidacion > @Fecha_Hoy and c.tipo_Swap = 3             
   AND    c.numero_flujo                = 1            
   AND    c.Tipo_flujo                  = 1            
   AND    c.tipo_swap                   = 3 --> FRA            
   AND    c.compra_moneda               NOT IN(998,997,994)     
   -- <<< PARA BALANCE >>> ---            
    
    
    
   -->    Genera Separacion de Cartera Normativa y Sub-Cartera            
   CREATE TABLE #TMP_CLASIFICA_CARTERA    
   (   Contrato      NUMERIC(10)    
   ,   Pais          INT    
   ,   Normativa     CHAR(1)    
   ,   SubCartera    INT    
   ,   CodContable   INT    
   ,   Puntero       NUMERIC(9) Identity(1,1)    
   )            
            
   CREATE INDEX #idptro_TMP_CLASIFICA_CARTERA ON #TMP_CLASIFICA_CARTERA (Puntero)            
            
   INSERT INTO #TMP_CLASIFICA_CARTERA            
   SELECT DISTINCT numero_operacion, clpais, car_Cartera_Normativa, car_SubCartera_Normativa, 0            
     FROM #CARTERA            
--        INNER JOIN BacParamSuda..CLIENTE with(nolock) ON clrut = rut_cliente and clcodigo = codigo_cliente            
   ORDER BY numero_operacion            
            
   DECLARE @nContador   NUMERIC(9)            
   DECLARE @nRegistros   NUMERIC(9)            
            
       SET @nContador    = ( SELECT MIN(Puntero) FROM #TMP_CLASIFICA_CARTERA )            
       SET @nRegistros   = ( SELECT MAX(Puntero) FROM #TMP_CLASIFICA_CARTERA )            
            
   DECLARE @xContraparte INTEGER            
   DECLARE @xCartera     CHAR(1)            
   DECLARE @xSubCartera  INTEGER            
   DECLARE @xCodigo      INTEGER            
            
   WHILE @nRegistros >= @nContador            
   BEGIN            
            
      SELECT @xContraparte = Pais            
         ,   @xCartera     = Normativa            
         ,   @xSubCartera  = SubCartera            
  ,   @xCodigo      = 0         
      FROM   #TMP_CLASIFICA_CARTERA             
      WHERE  Puntero       = @nContador            
            
      EXECUTE BacParamSuda.dbo.SP_CON_CLASIFICACION_CARTERA_DERIVADOS 'PCS', @xContraparte, @xCartera, @xSubCartera, @xCodigo OUTPUT            
            
      UPDATE #TMP_CLASIFICA_CARTERA             
         SET CodContable   = @xCodigo            
      WHERE  Puntero       = @nContador            
            
      SET @nContador = @nContador + 1            
   END            
            
   UPDATE BAC_CNT_CONTABILIZA            
      SET SubCartera = CodContable            
     FROM #TMP_CLASIFICA_CARTERA             
    WHERE operacion  = Contrato            
   -->    Genera Separacion de Cartera Normativa y Sub-Cartera            
            
   RETURN 0            
END    
GO
