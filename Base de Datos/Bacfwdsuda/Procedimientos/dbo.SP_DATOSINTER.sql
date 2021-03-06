USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOSINTER]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SP_DATOSINTER]
  (  @cfecha CHAR(8) 
  )  
AS  
BEGIN  
 
   SET NOCOUNT ON  
    -- SP_DATOSINTER '20141016' -- select * from mfac
    -- MAP 20071106 Descarta operaciones Anticipo  
  
    -- MAP 20080606 Reformula selección de Operaciones SWAP:  
    -- 1. Contrapartes recidentes en el Exterior, codigo pais <> 6  
    --    se asumirá que compensan en Mx no importando lo grabado  
    --    como moneda de pago en la operación.  
    -- 2. Swap con alguna MX involucrada con contrapartes nacionales  
    -- 3. Se usa la fecha de suscripción del contrato para seleccionar las operaciones a enviar.  
    -- CER 20080610  
    -- 4. Se modifican los Montos Entrega y Recibe con formulas solicitadas en requerimiento.  
    -- 5. Para la los Swap de Monedas se envian los montos por cada cupón  
    -- MAP 20100914  
    -- 6. El campo CatipCamSpot se ingresa en pantalla para todos los productos salvo Forward  
    --    observado, por esta razón se aplica CaPremon1 para este producto.  
  
  
   DECLARE @ntot1r      numeric(21,4) --FLOAT  
   DECLARE @ntot2e      numeric(21,4) --FLOAT  
   DECLARE @ntot3r      numeric(21,4) --FLOAT  
   DECLARE @ntot4e      numeric(21,4) --FLOAT  
   DECLARE @ncantop     NUMERIC(6,0)  
   DECLARE @nTotSwap    NUMERIC(6,0)  
   DECLARE @nTotOpc     NUMERIC(6,0)  
   DECLARE @cfecproc    CHAR(10)  
   DECLARE @ccodbcch    NUMERIC(3,0)  
   DECLARE @ncantopOPC  NUMERIC(6,0)  -- 21 Oct. 2009   
   DECLARE @ncantopSWAP NUMERIC(6,0)  -- 21 Oct. 2009   
  
   DECLARE @compra_amortiza  FLOAT,  
           @compra_interes   FLOAT,   
           @venta_amortiza   FLOAT,  
           @venta_interes    FLOAT,  
           @compra_moneda    FLOAT,  
           @venta_moneda     FLOAT,  
           @venta_valor_tasa FLOAT  
  
  declare @TotSwapRecibe     FLOAT  
  declare @TotSwapPaga       FLOAT  
  declare @TotOptRecibe      FLOAT  
  declare @TotOptPaga        FLOAT  
  
  declare @FLoatCero         FLOAT  
  declare @DoObs      FLOAT   
  select  @FLoatCero = 0.0  
  select  @DoObs = 0.0  
  
  
  
  select @DoObs = vmvalor    
  from BacParamSuda..Valor_Moneda      
  where vmFecha =@cfecha    
  And   vmcodigo =994  
  
  
    SELECT vmfecha, vmcodigo, vmvalor  
    INTO #VALOR_MONEDA  
    FROM BacParamSuda..VALOR_MONEDA  
    WHERE vmFecha    = @cfecha  
  
    INSERT INTO #VALOR_MONEDA  
    SELECT @cfecha, 999, 1.0  
  
    INSERT INTO #VALOR_MONEDA  
    SELECT @cfecha, 13, @DoObs  
  
   -- Este enredo es solo para los Forward  
  -- se trata de verticalizar las columnas de  
  -- entrada y salida.  
  SELECT @ntot1r = ISNULL ( SUM ( camtomon1 ), 0 ),    --rec  
         @ntot2e = ISNULL ( SUM ( case when cacodpos1 = 14 then 0 else camtomon2 end ), 0 )     --ent  
  FROM   MFCA  
         INNER JOIN VIEW_CLIENTE a ON a.clrut = cacodigo and a.clcodigo = cacodcli  
  WHERE  @cfecha               = CONVERT(CHAR(8), cafecha, 112)   
    AND  cacodpos1             IN(1,2,12,11,14) -->RTG  JUNIO 2010                            -->CS  
    AND  catipoper             = 'C'   
    AND  NumeroContratoCliente = 0                    -- MAP 20071106 Descarta operaciones Anticipo  


 
  SELECT @ntot3r  = ISNULL ( SUM ( case when cacodpos1 = 14 then 0 else camtomon2 end ), 0 ),   
         @ntot4e  = ISNULL ( SUM ( camtomon1 ), 0 )  
  FROM   MFCA  
         INNER JOIN VIEW_CLIENTE a ON a.clrut = cacodigo and a.clcodigo = cacodcli  
  WHERE  @cfecha               = CONVERT(CHAR(8), cafecha, 112)    
     AND cacodpos1             IN(1,2,12,11,14) -->RTG  JUNIO 2010                            -->CS  
     AND catipoper             = 'V'   
     AND NumeroContratoCliente = 0                    -- MAP 20071106 Descarta operaciones Anticipo  
  
   SELECT @ncantop= COUNT(*)  
   FROM   MFCA  
          INNER JOIN VIEW_CLIENTE a ON a.clrut = cacodigo and a.clcodigo = cacodcli  
   WHERE  @cfecha               = CONVERT(CHAR(8), cafecha, 112)   
     AND  cacodpos1             IN(1,2,12,11,14) -->RTG  JUNIO 2010                            -->CS  
     AND  NumeroContratoCliente = 0        -- MAP 20071106 Descarta operaciones Anticipo  
  
   SELECT @ncantopOPC = COUNT(*)  
   FROM   lnkOpc.CbMdbOpc.dbo.CaEncContrato A             
        , VIEW_CLIENTE D     
   WHERE  @cfecha        = CONVERT(CHAR(8),A.CaFechaContrato,112)     
     AND (A.CaRutCliente        = D.clrut and A.CaCodigo = D.clcodigo )   
     AND  A.CaTipoTransaccion <> 'ANULA'  
     AND  A.CaEstado <> 'C'                           -- 21 Oct. 2009        
  
   SELECT @ncantopSWAP = COUNT(*)  
  
  /* FROM   VIEW_CARTERA  
        , VIEW_CLIENTE a  
   where  convert(char(8), fecha_cierre, 112 ) = @cfecha   
     AND rut_cliente *= a.clrut and codigo_cliente*=a.clcodigo   
     AND Estado_Flujo = 1            
     AND Tipo_Flujo   = 1            -- 21 Oct. 2009  */   
  --RQ 7619  
     FROM  VIEW_CARTERA LEFT OUTER JOIN  VIEW_CLIENTE a   
   ON (rut_cliente = a.clrut and codigo_cliente=a.clcodigo )  
     where  convert(char(8), fecha_cierre, 112 ) = @cfecha   
     AND Estado_Flujo = 1            
     AND Tipo_Flujo   = 1              
      
  
  
  
   SELECT @cfecproc = CONVERT(CHAR(8), acfecproc, 112), @ccodbcch = accodbcch  
   FROM   MFAC  
  
   SELECT 'CANTOPERA'       = @ncantop                        ,  
          'TOTENT'          = @ntot2e + @ntot4e    ,  
          'TOTREC'          = @ntot1r + @ntot3r  ,  
          'FECHAPROC'       = @cfecha                       ,  
          'RUTPROP'         = acrutprop                       ,  
          'DIGPROP'         = acdigprop                       ,  
          'FECHAINI'        = CONVERT(CHAR(8), cafecha,112)   ,  
          'FECHAFIN'        = CONVERT(CHAR(8), cafecvcto,112) ,  
          'catipoper'       = catipoper                       ,  
          'camtomon1'       = camtomon1                       ,  
          'camtomon2'       = camtomon2                       ,  
          'RUTCLI'          = ISNULL( CASE WHEN a.clpais=acpais then cacodigo else a.clrutcliexterno END , 0 ) ,  
          'DIGCLI'          = ISNULL( CASE WHEN a.clpais=acpais then a.cldv   else a.cldvcliexterno  END , 0 ) ,  
          'NOMCLI'          = a.clnombre       ,  
          'NUMOPER'         = CONVERT (NUMERIC(8),canumoper)  ,  
          'plazo'           = caplazo                         ,  
          'catipmoda'       = catipmoda                       ,  
          'CODMREC'   = CASE WHEN catipoper = 'C'  
                             THEN cacodmon1  
                                   ELSE cacodmon2  
                              END                             ,  
          'CODMENT'   = CASE WHEN catipoper = 'C'  
                             THEN cacodmon2  
                                   ELSE cacodmon1   
                              END                             ,  
          'MTOREC'          = CASE WHEN catipoper = 'C' THEN camtomon1  
                                   ELSE  CASE WHEN cacodpos1 = 14 THEN 0.0 ELSE camtomon2 END  
                              END                              ,  
          'MTOENT'          = CASE WHEN catipoper = 'C' THEN CASE WHEN cacodpos1 = 14 THEN 0.0 ELSE camtomon2 END  
                                   ELSE camtomon1  
                              END                              ,  
          'CAPREMON1'       = Case when CaCodpos1 = 14 then CaPreMon1 else catipcamSpot end , --> capremon1,  
          'PRECIOFUT'= CASE WHEN cacodpos1 = 1  
                             THEN CASE WHEN cacodmon2 = 999  
                                      THEN caparmon2  
                                      ELSE caprecal  
                                     END   
                            WHEN  cacodpos1 = 14 THEN 0.0  
                                   ELSE caparmon2  
                              END                              ,  
          'CODBCCH'         = @ccodbcch  ,  
          'CodigoIns'       = caoperrelaspot       ,  --'01'  ,  
          'SectorEconomico' = a.clactivida ,  
          'Prima'           = CONVERT(FLOAT, 0.0),  
   'Flujos_SwapCCS'  = 0   
   INTO   #tmp  
   FROM   MFCA, MFAC , VIEW_CLIENTE a  
   WHERE  @cfecha = CONVERT(CHAR(8),cafecha,112)   
     AND  cacodpos1 IN(1,2,12,11,14) -->RTG  JUNIO 2010                            -->CS  
     AND (cacodigo = a.clrut and cacodcli = a.clcodigo)   
     AND  NumeroContratoCliente = 0                    -- MAP 20071106 Descarta operaciones Anticipo  
  
   DELETE #TMP  
  
  
   IF (@ncantop + @ncantopOPC + @ncantopSWAP) = 0   
   BEGIN     
   SELECT 'VACIO'     ='Vacio'                          ,  
          'RUTPROP'   = acrutprop                       ,  
          'DIGPROP'   = acdigprop                       ,  
          'FECHAPROC' = @cfecproc                       ,  
          'CODBCCH'   = @ccodbcch  
   FROM   MFAC  
   END  
   ELSE  
   BEGIN  
  
   INSERT INTO #TMP  
   SELECT 'CANTOPERA'       = @ncantop                        ,  
          'TOTENT'          = @ntot2e + @ntot4e    ,  
          'TOTREC'          = @ntot1r + @ntot3r  ,  
          'FECHAPROC'       = @cfecha                       ,  
          'RUTPROP'         = acrutprop                       ,  
          'DIGPROP'         = acdigprop                       ,  
          'FECHAINI'        = CONVERT(CHAR(8), cafecha,112)   ,  
          'FECHAFIN'        = CONVERT(CHAR(8), cafecvcto,112) ,  
          'catipoper'       = catipoper       ,  
          'camtomon1'       = camtomon1                       ,  
          'camtomon2'       = camtomon2                       ,  
          'RUTCLI'          = ISNULL( CASE WHEN a.clpais=acpais then cacodigo else a.clrutcliexterno END , 0 ) ,  
          'DIGCLI'          = ISNULL( CASE WHEN a.clpais=acpais then a.cldv   else a.cldvcliexterno  END , 0 ) ,  
          'NOMCLI'          = a.clnombre                      ,  
          'NUMOPER'         = CONVERT (NUMERIC(8),canumoper)  ,  
          'plazo'           = caplazo                         ,  
          'catipmoda'       = catipmoda                       ,  
          'CODMREC'   = CASE WHEN catipoper = 'C'  
                             THEN cacodmon1  
                                   ELSE cacodmon2  
                              END                             ,  
          'CODMENT'   = CASE WHEN catipoper = 'C'  
                             THEN cacodmon2  
                                   ELSE cacodmon1   
                              END                             ,  
          'MTOREC'   = CASE WHEN catipoper = 'C'  
                             THEN camtomon1  
                             ELSE   
                       CASE WHEN cacodpos1 = 14 THEN 0.0 ELSE camtomon2 END  
                              END                              ,  
          'MTOENT'   = CASE WHEN catipoper = 'C'  
                             THEN CASE WHEN cacodpos1 = 14 THEN 0.0 ELSE camtomon2 END  
                                   ELSE camtomon1  
                              END                              ,  
          'CAPREMON1'       = Case when CaCodpos1 = 14 then CaPreMon1 else catipcamSpot end , --> capremon1,  
          'PRECIOFUT'= CASE WHEN cacodpos1 = 1  
                            THEN CASE WHEN cacodmon2 = 999  
                                      THEN caparmon2  
                                      ELSE caprecal  
                                 END   
                            WHEN  cacodpos1 = 14 THEN 0.0    
                                   ELSE caparmon2  
                              END                              ,  
          'CODBCCH'         = @ccodbcch  ,  
          'CodigoIns'       = caoperrelaspot       ,  --'01'  ,  
          'SectorEconomico' = a.clactivida ,  
          'Prima'           = 0.0 ,  
   'Flujos_SwapCCS'  = 0   
   FROM   MFCA, MFAC , VIEW_CLIENTE a  
   WHERE  @cfecha               = CONVERT(CHAR(8),cafecha,112)   
     AND  cacodpos1             in(1,2,12,11,14) -->RTG  JUNIO 2010                            -->CS  
     AND (cacodigo              = a.clrut and cacodcli=a.clcodigo )   
     AND  NumeroContratoCliente = 0                    -- MAP 20071106 Descarta operaciones Anticipo  
   END  
  
   -->> ********************************************************* <<--  
   -->> SE MODIFICA LA EXTRACCION DE LAS OPERACIONES PARA EL SWAP <<--  
   -->> ********************************************************* <<--  
   -->>             A PARTIR DE ACA ES CODIGO NUEVO               <<--  
   -->> ********************************************************* <<--  
  
   ---------------------- Trae cartera SWAP a un archivo temporal ------------------------  
   -- En este nivel se aplicarán las condiciones de selección para envio al BCCH  
   -- Nace la tabla con los flujos de entrada  
   select compra_amortiza          = act.compra_amortiza  
      ,   compra_interes           = act.compra_interes  
      ,   venta_amortiza           = pas.venta_amortiza  
      ,   venta_interes            = pas.venta_interes  
      ,   fecha_inicio             = act.fecha_inicio  
      ,   tipo_operacion           = act.tipo_operacion  
      ,   tipo_swap                = act.tipo_swap  
      ,   rut_cliente              = act.rut_cliente  
      ,   codigo_cliente           = act.codigo_cliente  
      ,   fecha_termino            = act.fecha_termino  
      ,   numero_operacion         = CONVERT(NUMERIC(10),act.numero_operacion)  
      ,   modalidad_pago           = act.modalidad_pago  
      ,   compra_moneda            = act.compra_moneda  
      ,   venta_moneda             = pas.venta_moneda  
      ,   compra_valor_tasa        = act.compra_valor_tasa  
      ,   venta_valor_tasa         = pas.venta_valor_tasa  
      ,   fecha_cierre             = act.fecha_cierre  
      ,   compra_saldo             = act.compra_saldo  
      ,   venta_saldo              = pas.venta_saldo  
      ,   Compra_Flujo_Adicional   = act.Compra_Flujo_Adicional  
      ,   Venta_Flujo_Adicional    = pas.Venta_Flujo_Adicional  
      ,   SwapCCS_X_Flujo          = 0  
      ,   IntercPrinc              = act.IntercPrinc  
      ,   MontoRec                 = convert(numeric(21,4), act.compra_saldo + act.compra_amortiza )  
      ,   MontoEnt                 = convert(numeric(21,4), pas.venta_saldo  + pas.venta_amortiza )  
      ,   compra_capital           = act.compra_capital  
      ,   venta_capital            = pas.venta_capital  
      ,   CodIns                   = '07'  
   into   #CARTERA  
   from   bacswapsuda.dbo.cartera act  
          inner join bacswapsuda.dbo.cartera  pas on pas.numero_operacion  = act.numero_operacion  
                                                 and pas.numero_flujo      = act.numero_flujo  
                                                 and pas.tipo_flujo        = 2  
          inner join bacparamsuda.dbo.cliente cli on cli.clrut             = act.rut_cliente and cli.clcodigo = act.codigo_cliente  
          inner join bacparamsuda.dbo.moneda  mco on mco.mncodmon          = act.compra_moneda  
          inner join bacparamsuda.dbo.moneda  mvt on mvt.mncodmon          = pas.venta_moneda  
   where  act.fecha_cierre         = @cfecha --> @dfecha  
   and    act.tipo_flujo           = 1  
   and    act.Estado_Flujo         = 1  
   and    ( (cli.clpais           <> 6)  
         or (cli.clpais            = 6 and (mco.mnextranj = 1 or mvt.mnextranj = 1) )  
          )  
   and    act.tipo_swap            = 2     
 and   act.estado   <> 'C'  
   order by act.numero_operacion, act.tipo_flujo, act.numero_flujo  
  
  
  
   insert into #CARTERA  
   select compra_amortiza          = act.compra_amortiza  
      ,   compra_interes           = act.compra_interes  
      ,   venta_amortiza           = pas.venta_amortiza  
      ,   venta_Interes            = pas.venta_Interes  
      ,   fecha_inicio             = act.fecha_inicio  
      ,   tipo_Operacion           = act.tipo_Operacion  
      ,   tipo_Swap                = act.tipo_Swap  
      ,   Rut_Cliente              = act.Rut_Cliente  
      ,   Codigo_Cliente           = act.Codigo_Cliente  
      ,   Fecha_Termino            = act.Fecha_Termino  
      ,   numero_operacion         = RTRIM(CONVERT(CHAR(5), act.numero_operacion )) + RTRIM(CONVERT(CHAR(5), act.numero_flujo ))  
      ,   modalidad_pago           = act.modalidad_pago  
      ,   compra_moneda            = act.compra_moneda  
      ,   venta_moneda             = pas.venta_moneda  
      ,   compra_valor_tasa        = act.compra_valor_tasa  
      ,   venta_valor_tasa         = pas.venta_valor_tasa  
      ,   fecha_cierre             = act.fecha_cierre  
      ,   compra_saldo             = act.compra_saldo  
      ,   venta_saldo              = pas.venta_saldo  
      ,   Compra_Flujo_Adicional   = act.Compra_Flujo_Adicional  
      ,   Venta_Flujo_Adicional    = pas.Venta_Flujo_Adicional  
      ,   SwapCCS_X_Flujo          = 1  
      ,   IntercPrinc              = act.IntercPrinc  
      ,   MontoRec                 = convert(numeric(21,4), act.Compra_Flujo_Adicional + (act.compra_amortiza * act.IntercPrinc) + act.compra_interes )  
      ,   MontoEnt                 = convert(numeric(21,4), pas.venta_Flujo_Adicional  + (pas.venta_amortiza  * pas.IntercPrinc) + pas.venta_interes  )  
      ,   compra_capital           = act.compra_capital  
      ,   venta_capital            = pas.venta_capital  
      ,   CodIns                   = '08'  
     from bacswapsuda.dbo.cartera act  
          inner join bacswapsuda.dbo.cartera  pas on pas.numero_operacion  = act.numero_operacion  
                                                 and pas.numero_flujo      = act.numero_flujo  
                                                 and pas.tipo_flujo        = 2  
          inner join bacparamsuda.dbo.cliente cli on cli.clrut             = act.rut_cliente and cli.clcodigo = act.codigo_cliente  
          inner join bacparamsuda.dbo.moneda  mco on mco.mncodmon          = act.compra_moneda  
          inner join bacparamsuda.dbo.moneda  mvt on mvt.mncodmon          = pas.venta_moneda  
    where act.fecha_cierre         = @cfecha --> @dfecha  
      and act.tipo_flujo           = 1  
      and ( (cli.clpais           <> 6)  
         or (cli.clpais            = 6 and (mco.mnextranj = 1 or mvt.mnextranj = 1) )  
          )  
      and act.tipo_swap            = 2  
 and   act.estado    <> 'C'  
    order by act.numero_operacion, act.tipo_flujo, act.numero_flujo  
  
   -->> ********************************************************* <<--  
   -->>             HASTA ACA ES CODIGO NUEVO                     <<--  
   -->> ********************************************************* <<--  
  
   --*************************************************************************************************************************  
  
   -->> ********************************************************* <<--  
   -->>             SE COMENTA DESDE ACA                          <<--  
   -->> ********************************************************* <<--  
  
--    ---------------------- Trae cartera SWAP a un archivo temporal ------------------------  
--    -- En este nivel se aplicarán las condiciones de selección para envio al BCCH  
--    -- Nace la tabla con los flujos de entrada  
--      SELECT  compra_amortiza = compra_amortiza  ,  
--        compra_interes  = compra_interes ,  
--        venta_amortiza  = @FLoatCero ,  
--        venta_Interes   = @FLoatCero ,  
--        fecha_inicio    = fecha_inicio  ,  
--        tipo_Operacion  = tipo_operacion ,  
--        tipo_Swap       = tipo_swap ,  
--    --          numero_Flujo    = numero_flujo ,  
--    Rut_Cliente  = rut_cliente ,  
--        Codigo_Cliente  = codigo_cliente ,  
--      Fecha_Termino   = fecha_termino ,  
--        numero_operacion,  
--        modalidad_pago  = modalidad_pago ,  
--        compra_moneda   = compra_moneda ,  
--        venta_moneda    = @FLoatCero ,   
--        compra_valor_tasa = compra_valor_tasa,  
--        venta_valor_tasa  = @FLoatCero ,  
--        fecha_cierre       = fecha_cierre,  
--        EsMX_Mda_Recibe    = isnull( MR.mnextranj, 0 ),  
--        EsMX_Mda_Entrega   = @FLoatCero,  
--        ClTipCli,  
--        ClPais ,  
--        compra_saldo       = compra_saldo,    
--       venta_saldo       = @FLoatCero ,  
--        Compra_Flujo_Adicional = Compra_Flujo_Adicional,  
--        venta_Flujo_Adicional = @FLoatCero,  
--        IntercPrinc = IntercPrinc,  
--        numero_flujo = numero_flujo ,  
--        compra_capital ,  
--        venta_capital = @FLoatCero   
--      INTO   #CARTERA_Prev   
--        
--      /*FROM   VIEW_CARTERA, VIEW_CLIENTE a, view_moneda MR   
--      where  rut_cliente *= a.clrut and codigo_cliente*=a.clcodigo    
--       AND  Compra_Moneda    *= MR.MnCodMon  
--       AND convert(char(8), fecha_cierre, 112 ) = @cfecha   
--       AND Estado_Flujo = 1            
--       AND Tipo_Flujo   = 1   
--      ORDER BY numero_operacion, fecha_vence_flujo */  
--       
--      --RQ 7619  
--      FROM   VIEW_CARTERA LEFT OUTER JOIN VIEW_CLIENTE a ON (rut_cliente = a.clrut and codigo_cliente=a.clcodigo)  
--           LEFT OUTER JOIN  view_moneda MR  ON  Compra_Moneda    = MR.MnCodMon   
--      where  convert(char(8), fecha_cierre, 112 ) = @cfecha   
--      AND    Estado_Flujo = 1            
--      AND    Tipo_Flujo   = 1   
--      ORDER BY numero_operacion, fecha_vence_flujo  
--  
--  
--  
--  
--  
--      -- Se actualizan los valores de la pata pasiva  
--      Update #Cartera_Prev  
--        set venta_amortiza  = V.Venta_amortiza ,  
--         venta_Interes   = V.venta_Interes ,  
--         venta_moneda    = V.Venta_moneda ,   
--         venta_valor_tasa  = V.Venta_Valor_tasa ,  
--         EsMX_Mda_Entrega   = isnull( MP.mnextranj, 0 ),  
--        venta_saldo     = V.venta_saldo  ,  
--         venta_Flujo_Adicional = V.venta_Flujo_Adicional,  
--         venta_capital = V.venta_capital  
--     /* from    VIEW_CARTERA V , View_moneda MP where   
--         V.tipo_Flujo = 2  
--        and v.numero_operacion = #Cartera_Prev.numero_operacion  
--        and v.estado_flujo     = 1  
--        AND  v.venta_Moneda    *= MP.MnCodMon */  
--  
--      -- Rq 7619  
--      from  VIEW_CARTERA V LEFT OUTER JOIN View_moneda MP ON V.venta_Moneda  = MP.MnCodMon  
--      where V.tipo_Flujo = 2  
--      and v.numero_operacion = #Cartera_Prev.numero_operacion  
--      and v.estado_flujo     = 1  
--        
--  
--    -- Aplicar filtros del BCCH  
--      SELECT compra_amortiza,  
--       compra_interes,  
--       venta_amortiza,  
--       venta_interes,  
--       fecha_inicio,  
--       tipo_operacion,  
--       tipo_swap,  
--    --         numero_flujo,  
--       rut_cliente,  
--       codigo_cliente,  
--       fecha_termino,  
--       numero_operacion,  
--       modalidad_pago,  
--       compra_moneda,  
--       venta_moneda,  
--       compra_valor_tasa,  
--       venta_valor_tasa,  
--       fecha_cierre    ,  
--      compra_saldo   ,  
--      venta_saldo     ,  
--      Compra_Flujo_Adicional ,  
--      Venta_Flujo_Adicional ,  
--       'SwapCCS_X_Flujo'=0 ,  
--       IntercPrinc  ,  
--       'MontoRec' = compra_saldo + compra_amortiza,  
--      'MontoEnt' = venta_saldo + venta_amortiza,  
--      compra_capital,  
--       venta_capital,  
--       'CodIns' ='07'      
--  
--      INTO #CARTERA  
--      FROM   #Cartera_Prev  
--      where       
--       (   ClPais <>  6    
--        -- Cualquier entidad extranjera  
--   or  
--         -- Cualquier entidad de Chile con MX  
--        ClPais =  6 and  ( EsMX_Mda_Entrega  = 1  or EsMX_Mda_Recibe = 1  )  )  
--        and  tipo_Swap = 2  -- Swap de Monedas  
--  
--    /* -- Antes  
--      FROM   VIEW_CARTERA, VIEW_CLIENTE a  
--      WHERE  @cfecha = CONVERT(CHAR(8),fecha_inicio,112) AND  
--      numero_flujo = 1 And tipo_swap = 2 and tipo_flujo=1 AND  
--       rut_cliente = a.clrut and codigo_cliente=a.clcodigo  
--    */  
--    --*************************************************************************************************************************  
--    -- 5. Para la los Swap de Monedas se envian los montos por cada cupón  
--      Delete   #Cartera_Prev  
--      INSERT INTO #CARTERA_Prev  
--      SELECT  compra_amortiza = compra_amortiza  ,  
--        compra_interes  = compra_interes ,  
--        venta_amortiza  = @FLoatCero ,  
--        venta_Interes   = @FLoatCero ,  
--        fecha_inicio    = fecha_inicio  ,  
--        tipo_Operacion  = tipo_operacion ,  
--        tipo_Swap       = tipo_swap ,  
--    --          numero_Flujo    = numero_flujo ,  
--        Rut_Cliente     = rut_cliente ,  
--        Codigo_Cliente  = codigo_cliente ,  
--        Fecha_Termino   = fecha_vence_flujo , --fecha_termino ,  
--        numero_operacion ,  
--        modalidad_pago  = modalidad_pago ,  
--        compra_moneda   = compra_moneda ,  
--        venta_moneda    = @FLoatCero ,   
--        compra_valor_tasa = compra_valor_tasa,  
--        venta_valor_tasa  = @FLoatCero ,  
--        fecha_cierre       = fecha_cierre,  
--        EsMX_Mda_Recibe    = isnull( MR.mnextranj, 0 ),  
--        EsMX_Mda_Entrega   = @FLoatCero,  
--        ClTipCli,  
--        ClPais ,  
--        compra_saldo       = compra_saldo,  
--       venta_saldo       = @FLoatCero ,  
--        Compra_Flujo_Adicional = Compra_Flujo_Adicional,  
--        venta_Flujo_Adicional = @FLoatCero ,  
--        IntercPrinc = IntercPrinc,  
--        numero_flujo = numero_flujo ,  
--       compra_capital,  
--        venta_capital = @FLoatCero  
--  
--      /*FROM   VIEW_CARTERA, VIEW_CLIENTE a, view_moneda MR   
--      where  rut_cliente *= a.clrut and codigo_cliente*=a.clcodigo           
--    AND  Compra_Moneda    *= MR.MnCodMon  
--       AND tipo_Swap = 2  
--       AND convert(char(8), fecha_cierre, 112 ) = @cfecha   
--       AND Tipo_Flujo   = 1   
--      ORDER BY numero_operacion, fecha_vence_flujo */  
--        
--      --Rq 7619  
--        
--      FROM   VIEW_CARTERA LEFT OUTER JOIN VIEW_CLIENTE a ON (rut_cliente = a.clrut and codigo_cliente =a.clcodigo)  
--           LEFT OUTER JOIN view_moneda MR ON  Compra_Moneda = MR.MnCodMon  
--      where  tipo_Swap = 2  
--      AND  convert(char(8), fecha_cierre, 112 ) = @cfecha   
--      AND  Tipo_Flujo   = 1   
--      ORDER BY numero_operacion, fecha_vence_flujo  
--  
--  
--  
--  
--       
--      -- Se actualizan los valores de la pata pasiva  
--      Update #Cartera_Prev  
--        set venta_amortiza  = V.Venta_amortiza ,  
--         venta_Interes   = V.venta_Interes ,  
--         venta_moneda    = V.Venta_moneda ,   
--         venta_valor_tasa  = V.Venta_Valor_tasa ,  
--         EsMX_Mda_Entrega   = isnull( MP.mnextranj, 0 ),  
--        venta_saldo     = V.venta_saldo  ,  
--         venta_Flujo_Adicional = V.venta_Flujo_Adicional ,  
--        venta_capital = V.venta_capital   
--        
--    /*from      VIEW_CARTERA V  
--    ,    View_moneda MP   
--    where   
--        V.tipo_Flujo = 2  
--        and v.numero_operacion = #Cartera_Prev.numero_operacion  
--        and v.numero_flujo = #Cartera_Prev.numero_flujo  
--        AND  v.venta_Moneda    *= MP.MnCodMon */  
--    --Rq 7619  
--      from    VIEW_CARTERA V LEFT OUTER JOIN View_moneda MP ON v.venta_Moneda    = MP.MnCodMon  
--      where   
--         V.tipo_Flujo = 2  
--  and v.numero_operacion = #Cartera_Prev.numero_operacion  
--        and v.numero_flujo = #Cartera_Prev.numero_flujo  
--                
--  
--  
--      -- Aplicar filtros del BCCH  
--      INSERT INTO #CARTERA  
--      SELECT  compra_amortiza ,  
--        compra_interes  ,  
--        venta_amortiza  ,  
--        venta_Interes   ,  
--        fecha_inicio    ,  
--        tipo_Operacion  ,  
--        tipo_Swap       ,  
--      Rut_Cliente     ,  
--        Codigo_Cliente  ,  
--        Fecha_Termino   ,  
--    --          numero_operacion,  
--        'numero_operacion' = RTRIM(CONVERT(CHAR(5),numero_operacion)) + RTRIM(CONVERT(CHAR(5),numero_flujo)),  
--        modalidad_pago  ,  
--        compra_moneda   ,  
--        venta_moneda    ,  
--        compra_valor_tasa ,  
--        venta_valor_tasa  ,  
--        fecha_cierre    ,  
--       compra_saldo   ,  
--       venta_saldo     ,  
--       Compra_Flujo_Adicional ,  
--       Venta_Flujo_Adicional ,  
--        'SwapCCS_X_Flujo'=1 ,  
--        IntercPrinc       ,  
--        'MontoRec' = Compra_Flujo_Adicional + (compra_amortiza * IntercPrinc) + compra_interes,  
--       'MontoEnt' = venta_Flujo_Adicional + (venta_amortiza* IntercPrinc) + venta_interes,  
--       compra_capital,  
--        venta_capital,  
--        'CodIns' ='08'  
--      FROM   #Cartera_Prev  
--      where       
--       (   ClPais <>  6    
--        -- Cualquier entidad extranjera  
--        or  
--         -- Cualquier entidad de Chile con MX  
--        ClPais =  6 and  ( EsMX_Mda_Entrega  = 1  or EsMX_Mda_Recibe = 1  )    
--        )and  tipo_Swap = 2  -- Swap de Monedas           
--  
--  
--    --*************************************************************************************************************************  
  
   -->> ********************************************************* <<--  
   -->>             SE COMENTA HASTA ACA                          <<--  
   -->> ********************************************************* <<--  
  
  
  
  
-------------------------- Acumula Valores -----------------------  
-- Codigo Muerto, no se utiliza  
/*  
  SELECT @compra_amortiza = SUM(a.compra_amortiza),  
         @compra_interes  = SUM(a.compra_interes),   
         @venta_amortiza  = SUM(a.venta_amortiza),  
         @venta_interes   = SUM(a.venta_interes),  
         @compra_moneda   = max(a.compra_moneda),  
         @venta_moneda    = max(a.venta_moneda),  
         @venta_valor_tasa = SUM(a.venta_valor_tasa)  
  
  FROM   VIEW_MOVDIARIO a, #CARTERA b  
  WHERE  a.numero_operacion=b.numero_operacion and a.numero_flujo = 1 And a.tipo_swap = 2  
*/  
  
  
--  Este código ya no aplica  
/*  
  SELECT @compra_amortiza = SUM(a.compra_amortiza),  
         @compra_interes  = SUM(a.compra_interes),   
         @venta_amortiza  = SUM(a.venta_amortiza),  
         @venta_interes   = SUM(a.venta_interes),  
         @compra_moneda   = max(a.compra_moneda),  
         @venta_moneda    = max(a.venta_moneda),  
         @venta_valor_tasa = SUM(a.venta_valor_tasa)  
  
  FROM   BACSWAPSUDA..MOVHISTORICO a, #CARTERA b  
  WHERE  a.numero_operacion=b.numero_operacion and a.numero_flujo = 1 And a.tipo_swap = 2  
*/  
  
-- Esto no tiene sentido  
/*  
  UPDATE #CARTERA  
  SET compra_amortiza = @compra_amortiza,  
      compra_interes  = @compra_interes,   
      venta_amortiza  = @venta_amortiza,  
      venta_interes   = @venta_interes,  
      compra_moneda   = @compra_moneda,  
      venta_moneda    = @venta_moneda  
*/  
--------------------------------------------------------------------  
  select @TotSwapRecibe = 0  
  select @TotSwapPaga   = 0  
  SELECT   @TotSwapRecibe = ISNULL ( SUM ( MontoRec ), 0 ),  --rec ISNULL ( SUM ( compra_amortiza + Compra_interes ), 0 )  
           @TotSwapPaga   = ISNULL ( SUM ( MontoEnt ), 0 )     --ent ISNULL ( SUM ( venta_amortiza + Venta_interes  ), 0 )  
  FROM   #CARTERA  
  where  MontoRec<>0   --cbb  
  
  
-- Aplica solo para Forward  
/*  
  SELECT @ntot1r = ISNULL ( SUM ( compra_amortiza + compra_interes ), 0 ),  --rec  
         @ntot2e = ISNULL ( SUM ( venta_amortiza + venta_interes ), 0 )     --ent  
  FROM   #CARTERA, VIEW_CLIENTE a  
  WHERE  @cfecha = CONVERT(CHAR(8),fecha_inicio,112) AND tipo_operacion = 'C' and  
         ( tipo_swap = 2 and numero_flujo = 1 ) And  
         ( rut_cliente = a.clrut and codigo_cliente=a.clcodigo )  
*/  
  
-- No aplica el tipo de operación  
/*  
  SELECT @ntot3r  = ISNULL ( SUM ( venta_amortiza + venta_interes ), 0 ),  
         @ntot4e  = ISNULL ( SUM ( compra_amortiza + compra_interes ), 0 )  
  FROM   #CARTERA, VIEW_CLIENTE a  
  WHERE  @cfecha = CONVERT(CHAR(8),fecha_inicio,112) AND tipo_operacion = 'V' and  
         ( tipo_swap = 2 and numero_flujo = 1 ) And  
       ( rut_cliente = a.clrut and codigo_cliente=a.clcodigo )  
*/  
  
  SELECT @nTotSwap = COUNT(*)  
  FROM   #CARTERA   
  WHERE  NOT(MontoRec = 0 AND  MontoEnt =0) and MontoRec <> 0  
/* -- Antes  
  FROM   #CARTERA, VIEW_CLIENTE a  
  WHERE  @cfecha = CONVERT(CHAR(8),fecha_inicio,112)AND  
         ( tipo_swap = 2 and numero_flujo = 1 ) And  
         ( rut_cliente = a.clrut and codigo_cliente=a.clcodigo )  
*/  
  
   IF @nTotSwap > 0   
   BEGIN  
  
         INSERT INTO #TMP  
         SELECT 'CANTOPERA' = 0             ,  
         'TOTENT'    = 0.0             ,  
                'TOTREC'    = 0.0        ,  
                'FECHAPROC' = @cfecha                            ,  
                'RUTPROP'   = acrutprop                          ,  
                'DIGPROP'   = acdigprop                          ,  
                'FECHAINI'  = CONVERT(CHAR(8), fecha_cierre,112) ,  
                'FECHAFIN'  = CONVERT(CHAR(8), fecha_termino,112),  
                'catipoper' = 'C' , -- tipo_operacion      , -- Ya no aplica para Swap, podrian ser dos MX  
                'camtomon1' = MontoRec , --compra_amortiza + compra_interes   ,  
                'camtomon2' = MontoEnt , --venta_amortiza + venta_interes     ,  
--                'RUTCLI'    = ISNULL( CASE WHEN a.clpais=acpais then rut_cliente else a.clrutcliexterno END , 0 ),  
--                'DIGCLI'    = ISNULL( CASE WHEN a.clpais=acpais then a.cldv   else a.cldvcliexterno  END , 0 )   ,  
                'RUTCLI'    = rut_cliente,  
                'DIGCLI'    = a.cldv,  
                'NOMCLI'    = a.clnombre                         ,  
                'NUMOPER'   = CONVERT (NUMERIC(8),numero_operacion),  
                'PLAZO'     = datediff(day,fecha_cierre,fecha_termino),  
                'CATIPMODA' = modalidad_pago                     ,  
                'CODMREC'   = compra_moneda                      ,  
                'CODMENT'   = venta_moneda                       ,  
                'MTOREC'    = MontoRec ,  --compra_amortiza + compra_interes   ,  
                'MTOENT'    = MontoEnt ,  --venta_amortiza + venta_interes     ,  
--                'CAPREMON1' = @DoObs  ,   --compra_valor_tasa                ,  
  
  'CAPREMON1' = case when tipo_swap in ( 1, 4)   
                                        then @DoObs   
                                   -- MN x MX  
                                   when compra_moneda in ( 998, 999 ) and venta_moneda not in ( 998, 999 )   
                                        then  isnull(c.vmvalor ,0)   
                                   -- MX x MN  
                                   when Venta_moneda in ( 998, 999 ) and compra_moneda not in ( 998, 999 )    
                                        then  isnull(b.vmvalor ,0)   
    -- MN x MN  
             when compra_moneda in ( 999 )  
                                        then isnull(b.vmvalor ,0)   
                                   when venta_moneda in ( 999 )  
        then isnull(c.vmvalor ,0)   
                                 -- MX x USD  
       when compra_moneda not in ( 13 )  and  venta_moneda in ( 13 )  
                                        then isnull(c.vmvalor ,0)/isnull(b.vmvalor ,0)  
                                   -- USD x MX  
                                   when venta_moneda  not in ( 13 )  and  compra_moneda in  ( 13 )  
                                        then isnull(b.vmvalor ,0)/isnull(c.vmvalor ,0)  
                                   -- MX x MX  
                                   else isnull(b.vmvalor ,0)/isnull(c.vmvalor ,0)  
                              end ,  
  
-- El Precio Futuro se calcula con los nocionales   
-- para todos los flujos  cuando estos son Swap de Monedas   
  
                'PRECIOFUT' = case when tipo_swap in ( 1, 4)   
                                        then compra_valor_tasa   
                                   -- MN x MX  
                                   when compra_moneda in ( 998, 999 ) and venta_moneda not in ( 998, 999 )   
               then compra_capital / venta_capital  
                                   -- MX x MN  
                                   when Venta_moneda in ( 998, 999 ) and compra_moneda not in ( 998, 999 )    
                                        then venta_capital / compra_capital  
                                   -- MN x MN  
                                   when compra_moneda in ( 999 )  
                                        then compra_capital / venta_capital  
                                   when venta_moneda in ( 999 )  
       then venta_capital / compra_capital  
                                   -- MX x USD  
       when compra_moneda not in ( 13 )  and  venta_moneda in ( 13 )  
                                        then compra_capital / venta_capital  
                                   -- USD x MX  
                                   when venta_moneda  not in ( 13 )  and  compra_moneda in  ( 13 )  
                                        then compra_capital / venta_capital   
                                   -- MX x MX  
                                   else compra_capital / venta_capital  
                              end ,  
                'CODBCCH'  = @ccodbcch                        ,  
                'CodigoIns'= CodIns, --> '05'   , -- Deberá ser reclasificado deacuerdo al tipo de swap  
                'SectorEconomico' = a.clactivida              ,  
                'Prima'           = 0.0  ,  
                'Flujos_SwapCCS' = SwapCCS_X_Flujo    
          FROM BacFwdSuda.dbo.MFAC  
   , #CARTERA  
    INNER JOIN BacParamSuda.dbo.CLIENTE      a ON a.clrut  = rut_cliente AND a.clcodigo = codigo_cliente  
    LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA b ON b.vmfecha  = @cfecha  AND b.vmcodigo = (CASE WHEN compra_moneda = 13 THEN 994 ELSE compra_moneda END)  
    LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA c ON c.vmfecha  = @cfecha  AND c.vmcodigo = (CASE WHEN venta_moneda  = 13 THEN 994 ELSE venta_moneda  END)  
  WHERE NOT(MontoRec = 0 AND MontoEnt = 0)  
  
   END  
  
  
/**************************************************OPCIONES*************************************************************/  
  
         SELECT 'FECINI'  = CONVERT(CHAR(8), B.CaFechaInicioOpc,112)   ,  
                'FECFIN'  = CONVERT(CHAR(8), B.CaFechaPagoEjer,112) ,  
                'CaCVOpc' = B.CaCVOpc,   
                'MtoMon1' = B.CaMontoMon1                       ,  
                'MtoMon2' = B.CaMontoMon2                       ,  
                'RutCliente'  = ISNULL( CASE WHEN D.clpais = 6 then A.CaRutCliente else D.clrutcliexterno END , 0 ) ,  
                'DigCliente'  = ISNULL( CASE WHEN D.clpais = 6 then D.cldv         else D.cldvcliexterno  END , 0 ) ,  
                'NomCliente'  = D.clnombre                      ,  
                'NumOpe'      = RTRIM(CONVERT(CHAR(5),A.CaNumContrato)) + RTRIM(CONVERT(CHAR(5),B.CaNumEstructura)),   
                'Plazo'   = DATEDIFF(DD,B.CaFechaInicioOpc, B.CaFechaPagoEjer) ,  
                'TipModa'     = B.CaModalidad ,   
                'CodMdaRec'   = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Call') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Put')  
                                   THEN B.CaCodMon1  
                                   ELSE B.CaCodMon2  
                              END                             ,  
                'CodMdaEnt'   = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Put') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Call')  
                                   THEN B.CaCodMon1  
                                   ELSE B.CaCodMon2   
                              END                             ,  
                'MtoRecibe'   = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Call') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Put')  
                                  THEN B.CaMontoMon1  
                                  ELSE B.CaMontoMon2  
                              END                             ,  
       'MtoEntrega'  = CASE WHEN (B.CaCVOpc = 'C' AND  B.CaCallPut = 'Put') OR (B.CaCVOpc = 'V' AND  B.CaCallPut = 'Call')  
                                  THEN B.CaMontoMon1  
                                  ELSE B.CaMontoMon2   
                             END       ,  
                'CaStrike'  = B.CaStrike,    
                'PrecFut'   = B.CaStrike,   
                'CodigoBCCH'= @ccodbcch ,  
                'CodIns'    = (CASE WHEN CaCallPut = 'Call' THEN '03' ELSE '04' END),        
                'SectorEcon'= D.clactivida ,  
                'PrimaOpc'       = ROUND(B.CaPrimaInicialDet,4)  ,  
                'NumEstructura'  = B.CaNumEstructura ,  
                'DetalleAvr'  = B.CaVrDet ,  
                'TotalAvr'  = A.CaVr    ,  
                'MdaPrimaOpc'    = A.CaCodMonPagPrima  
         INTO  #CARTERA_OPC  
         FROM   lnkOpc.CbMdbOpc.dbo.CaEncContrato A     
              , lnkOpc.CbMdbOpc.dbo.CaDetContrato B  
              , MFAC C  
              , VIEW_CLIENTE D     
         WHERE  A.CaNumContrato       =  B.CaNumContrato   
           AND  @cfecha               = CONVERT(CHAR(8),A.CaFechaContrato,112)     
           AND (A.CaRutCliente        = D.clrut and A.CaCodigo = D.clcodigo )   
--           AND  B.CaModalidad         = 'C'   21 Oct. 2009 Solicitud MAP  
           AND  A.CaTipoTransaccion <> 'ANULA'  
           AND  A.CaEstado <> 'C'  
  
  
         SELECT  @TotOptRecibe = 0.0  
         SELECT  @TotOptPaga   = 0.0  
         SELECT  @TotOptRecibe = ISNULL ( SUM ( MtoRecibe ), 0 ),    
                 @TotOptPaga   = ISNULL ( SUM ( MtoEntrega ), 0 )     
         FROM   #CARTERA_OPC  
  
  
          SELECT @nTotOpc = COUNT(*)  
          FROM   #CARTERA_OPC  
          WHERE  NOT(MtoRecibe = 0 AND  MtoEntrega =0)  
  
  
   IF @nTotOpc > 0   
   BEGIN  
  
         INSERT INTO #TMP  
         SELECT 'CANTOPERA' = 0,   
                'TOTENT'    = 0.0,  
                'TOTREC'    = 0.0,  
                'FECHAPROC' = @cfecha                         ,  
                'RUTPROP'   = B.acrutprop                     ,  
                'DIGPROP'   = B.acdigprop                     ,  
                'FECHAINI'  = CONVERT(CHAR(8), A.FECINI,112)  ,  
                'FECHAFIN'  = CONVERT(CHAR(8), A.FECFIN,112)  ,  
                'catipoper' = A.CaCVOpc,   
                'camtomon1' = A.MtoMon1                       ,  
                'camtomon2' = A.MtoMon2                       ,  
                'RUTCLI'    = A.RutCliente ,  
                'DIGCLI'    = A.DigCliente ,  
                'NOMCLI'    = A.NomCliente     ,  
                'NUMOPER'   = CONVERT (NUMERIC(8),A.NumOpe)    ,  
                'plazo'     = DATEDIFF(DD, A.FECINI, A.FECFIN) ,  
                'catipmoda' = A.TipModa   ,   
'CODMREC' = A.CodMdaRec     ,  
                'CODMENT'   = A.CodMdaEnt     ,  
                'MTOREC'    = A.MtoRecibe     ,  
                'MTOENT'    = A.MtoEntrega    ,  
                'CAPREMON1' = A.CaStrike      ,    
                'PRECIOFUT' = A.PrecFut     ,   
                'CODBCCH'   = A.CodigoBCCH    ,  
                'CodigoIns' = A.CodIns        ,        
                'SectorEconomico'= A.SectorEcon ,  
                'Prima'          = ROUND((C.vmvalor * A.PrimaOpc / @DoObs),4) ,  
                'Flujos_SwapCCS' = 0  
          FROM   #CARTERA_OPC       A  
           ,     MFAC               B  
    ,     #VALOR_MONEDA      C  
          WHERE NOT(A.MtoRecibe = 0 AND  A.MtoEntrega =0)  
   AND  A.MdaPrimaOpc  =C.vmcodigo  
   AND  C.vmfecha      = @cfecha  
  
   END  
  
 /**************************************************OPCIONES*************************************************************/  
  
          UPDATE #TMP  
          SET CANTOPERA = @ncantop + @nTotSwap + @nTotOpc   ,  
              TOTENT    = @ntot2e + @ntot4e + round( @TotSwapPaga, 4 )+ @TotOptPaga  ,  
         TOTREC    = @ntot1r + @ntot3r + round( @TotSwapRecibe, 4 ) + @TotOptRecibe   
/* --Antes  
          SET CANTOPERA = CANTOPERA + @nTotSwap            ,  
              TOTENT    = TOTENT + @ntot2e + @ntot4e       ,  
              TOTREC    = TOTREC + @ntot1r + @ntot3r  
*/  
     
-- INI COMDER
IF EXISTS(SELECT 1 FROM BDBOMESA.dbo.COMDER_RelacionMarcaComder a, #TMP b WHERE a.nReNumOper = b.NUMOPER AND a.iReNovacion = 1 AND a.vReEstado = 'V' AND CONVERT(CHAR(8),a.dReFecha,112)= @cfecha )
BEGIN
	UPDATE #TMP
	SET	NOMCLI	= b.Clnombre
		,DIGCLI	= b.Cldv
		,RUTCLI	= b.Clrut
		,SectorEconomico = b.clactivida
   FROM		BDBOMESA.dbo.COMDER_RelacionMarcaComder a, VIEW_CLIENTE b  
   WHERE	a.nReNumOper = #TMP.NUMOPER
   AND		#TMP.RUTCLI = (select acRutComder from MFAC)  
   AND		(a.nReRutCliente = b.clrut and a.nReCodCliente=b.clcodigo )
   AND		a.iReNovacion = 1 
   AND		a.vReEstado = 'V' 
   AND		CONVERT(CHAR(8),a.dReFecha,112)= @cfecha
      
END
-- FIN COMDER
   
        
   IF (SELECT COUNT(*) FROM #TMP) > 0  
      SELECT * FROM #TMP WHERE camtomon1 <> 0 ORDER BY   Flujos_SwapCCS, CodigoIns, NUMOPER, FECHAFIN     
    
END

GO
