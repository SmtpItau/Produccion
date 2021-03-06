USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_CONTABILIZA_FAMERICANO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LLENA_CONTABILIZA_FAMERICANO]
   (   @Fecha_Hoy   DATETIME   )    
AS    
BEGIN    
    
   SET NOCOUNT ON    
    
   -->     PROCESO SE UTILIZARA PARA CONTABILIZAR MAS PRODUCTOS:  
   -->                - Forward Americano  
   -->                - Forward Sintético Asiático  
   -->     SP_LLENA_CONTABILIZA_FAMERICANO '20140408' -- select * from BacFwdSuda.dbo.Mfac  
   -->     SP_LLENA_CONTABILIZA_FAMERICANO_MAP '20120312'  
   --> delete  BAC_CNT_CONTABILIZA where tipo_operacion like '%15%'  or tipo_operacion like '%17%'  
   --> select * from   BAC_CNT_CONTABILIZA where  tipo_operacion like '%15%' or tipo_operacion like '%17%'  -- 62 sin cambio
   -->     EXECUTE SP_CARGA_CARTERA_OPCIONES    
    
   DECLARE @dAcfecproc   DATETIME      
       SET @dAcfecproc   = (SELECT acfecproc FROM MFAC with (nolock) )    
    
   DECLARE @dAcfecante   DATETIME    
       SET @dAcfecante   = (SELECT acfecante FROM MFAC with (nolock) )    
    
   DECLARE @FechaAnt     CHAR(8)    
       SET @FechaAnt     = CONVERT(CHAR(8), @dAcfecante ,112)    
    
   DECLARE @Fecha_Ayer   DATETIME    
       SET @Fecha_Ayer   = @dAcfecante    
    
   DECLARE @iFound       INTEGER    
      SET  @iFound       = -1    
    
   SELECT  @iFound       = 0     
   FROM    BacParamSuda..VALOR_MONEDA_CONTABLE with(nolock)    
   WHERE   Fecha         = @dAcfecproc    
   AND     Tipo_Cambio  <> 0    
    
   IF @iFound = -1    
   BEGIN    
      RAISERROR('¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY. ! ',16,6,'ERROR.')    
      RETURN    
   END    

   DECLARE @vDoDia   FLOAT    
       SET @vDoDia   = ( SELECT vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmfecha = @dAcfecproc AND vmcodigo = 994 )    
    
   DECLARE @Control_Error     INTEGER    
   DECLARE @diasdevengar      INTEGER    
   DECLARE @correla       NUMERIC(3)    
    
   DECLARE @FechaActual       CHAR(08)    
       SET @FechaActual       = CONVERT(CHAR(8),@Fecha_Hoy,112)    
    
   DECLARE @PrimerDiaMes      CHAR(08)    
       SET @PrimerDiaMes      = SUBSTRING(@FechaActual,1,6) + '01'    
    
   DECLARE @FechaValorMoneda  DATETIME    
   DECLARE @FechaValorMonAye  DATETIME    
    
   EXECUTE BacParamSuda..SP_FECHA_VALOR_MONEDA @Fecha_Hoy, @FechaValorMoneda OUTPUT    
   EXECUTE BacParamSuda..SP_FECHA_VALOR_MONEDA @FechaAnt,  @FechaValorMonAye OUTPUT    
    
   ----<< Chequea si es el Primer dia del Mes    
   IF SUBSTRING(@PrimerDiaMes,5,2) <> SUBSTRING(@FechaAnt,5,2)    
   BEGIN    
      SET @FechaAnt     = CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(DAY,-1,@PrimerDiaMes)),112)    
      SET @diasdevengar = DATEDIFF(DAY, @FechaAnt, @PrimerDiaMes)    
   END    
    
   --|========================================================================================|    
   --| LLENADO DE ARCHIVO DE CONTABILIZACION         |    
   --|========================================================================================|    
    
   -->   TRUNCATE TABLE BAC_CNT_CONTABILIZA    
    
   IF @@ERROR <> 0    
   BEGIN    
      PRINT 'ERROR_PROC FALLA BORRANDO ARCHIVO CONTABILIZA (FORWARD).'    
      RETURN 1    
   END    
    
   IF @Control_Error <> 0    
      RETURN 1    
    
   SELECT vmfecha    
        , vmcodigo    
        , vmvalor    
   INTO   #VALOR_MONEDA    
   FROM   BacParamSuda..VALOR_MONEDA with (nolock)    
   WHERE (vmfecha   = @dAcfecproc OR vmfecha = @dAcfecante)    
   AND    vmcodigo  NOT IN(999,998)    
       
   INSERT INTO #VALOR_MONEDA    
   SELECT @dAcfecproc    
   ,      vmcodigo    
   ,      vmvalor    
   FROM   BacParamSuda..VALOR_MONEDA with (nolock)    
   WHERE  vmfecha   = @FechaValorMoneda    
   AND    vmcodigo  = 998    
    
   INSERT INTO #VALOR_MONEDA    
   SELECT @dAcfecante    
   ,      vmcodigo    
   ,      vmvalor    
   FROM   BacParamSuda..VALOR_MONEDA with (nolock)    
   WHERE  vmfecha   = @FechaValorMonAye    
   AND    vmcodigo  = 998    
    
   INSERT INTO #VALOR_MONEDA     
      SELECT @dAcfecproc, 999, 1.0    
       
   INSERT INTO #VALOR_MONEDA    
        SELECT @dAcfecante, 999, 1.0    
    
   --     CREA TABLA DE VALORES DE MONEDA NO REAJUSTABLES Tipo Cambio Contable --    
   SELECT vmfecha       = Fecha    
   ,      vmcodigo      = CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END    
   ,      vmvalor       = Tipo_Cambio    
   INTO   #VALOR_TC_CONTABLE    
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE WITH (NOLOCK)    
   WHERE (Fecha         = @dAcfecproc OR Fecha = @dAcfecante)    
   AND    Codigo_Moneda NOT IN(13,995,997,998,999)    
    
   --     INSERTA VALORES DE MONEDA REAJUSTABLES Tipo Cambio del día          --    
   INSERT INTO #VALOR_TC_CONTABLE    
   SELECT vmfecha    
   ,      vmcodigo    
   ,      vmvalor    
   FROM   #VALOR_MONEDA     
   WHERE  vmcodigo  IN(994,995,997,998,999)    
    
   DECLARE @fValorDo_Hoy   FLOAT    
       SET @fValorDo_Hoy   = (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc AND vmcodigo = 994)    
    
   DECLARE @fValorIvp_Hoy  FLOAT    
       SET @fValorIvp_Hoy  = (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc AND vmcodigo = 997)    
    
   DECLARE @fValorUf_Hoy   FLOAT    
       SET @fValorUf_Hoy   = (SELECT ISNULL(vmvalor,0.0) FROM #VALOR_TC_CONTABLE WHERE vmfecha = @dAcfecproc AND vmcodigo = 998)    
    
   -- MAP 20130220 Cambios realizados  
   -- El MontoMon2 lo saca de la cartera, hay que hacer que lo saque del  
   -- movimiento, esto es indiferente para todas las estructuras en que  
   -- no varia el Monto2, si es relevante para las que van cambiando su  
   -- Strike y por ende su monto2.  
  
   INSERT INTO BAC_CNT_CONTABILIZA -- select * from BAC_CNT_CONTABILIZA  
   (      id_sistema    
   ,      tipo_movimiento    
   ,      tipo_operacion    
   ,      operacion    
   ,      correlativo    
   ,      codigo_instrumento    
   ,      moneda_instrumento    
   ,      forma_pago    
   ,      Moneda_Compra    
   ,      Moneda_Venta    
   ,      tipo_cliente    
   ,      CarteraNormativa    
   ,      SubCarteraNormativa    
   ,      Valor_Compra    
   ,      Valor_Venta    
   ,      Valor_Hoy_Recompra    
   ,      Utilidad_Valorizacion    
   ,      Perdida_Valorizacion    
   ,      Reversa_Valorizacion_Utilidad    
   ,      Reversa_Valorizacion_Perdida    
   ,      Utilidad    
   ,      Perdida    
   ,      UtilidadEFisica    
   ,      PerdidaEFisica    
   ,      Valor_Presente    
   ,      Valor_Usd    
   ,      Mx_Recompra    
   ,      cantidad_cortes    
   )    
   SELECT DISTINCT  
          'id_sistema'                    = 'BFW' --> 'OPT'  
   ,      'tipo_movimiento'               = 'MOV'    
   ,      'tipo_operacion'                = ltrim(rtrim(Con.OpcContabExternaProd)) + LTRIM(RTRIM( con.cacvestructura ))  
   ,      'operacion'                     = con.canumcontrato    
   ,      'correlativo'                   = 1    
   ,      'codigo_instrumento'            = det.cacodmon2    
   ,      'moneda_instrumento'            = ''    
   ,      'forma_pago'                    = CASE WHEN det.camodalidad = 'C' THEN det.caformapagocomp    
                                                 ELSE                            det.caformapagomon2    
                                            END    
   ,      'Moneda_Compra'                 = det.cacodmon1    
   ,      'Moneda_Venta'                  = det.cacodmon2    
   ,      'tipo_cliente'                  = CASE WHEN cli.clpais = 6 THEN 2 ELSE 1 END    
   ,      'CarteraNormativa'              = con.cacarnormativa    
   ,      'SubCarteraNormativa'           = con.casubcarnormativa    
   ,      'Valor_Compra'                  = CASE WHEN det.cacodmon1 = 994 THEN ISNULL( det.camontomon1 * @fValorDo_Hoy  ,0.0)    
                                                 ELSE                    det.camontomon1    
                                            END    
   ,      'Valor_Venta'                   = isnull( det.camontomon1 * ISNULL( tcc.vmvalor, 0.0), 0.0)    
   ,      'Valor_Hoy_Recompra'            = CASE WHEN con.cafechacontrato = @Fecha_Hoy THEN 0.0     
                                                 ELSE         isnull(det.camontomon1 * isnull(tcc.vmvalor, 0.0), 0.0)    
                                            END    
   ,      'Utilidad_Valorizacion'         = 0.0    
   ,      'Perdida_Valorizacion'          = 0.0    
   ,      'Reversa_Valorizacion_Utilidad' = 0.0    
   ,      'Reversa_Valorizacion_Perdida'  = 0.0    
   ,      'Utilidad'                      = 0.0    
   ,      'Perdida'                       = 0.0    
   ,      'UtilidadEFisica'               = 0.0    
   ,      'PerdidaEFisica'                = 0.0    
   ,      'Valor_Presente'                = DetMov.Momontomon2    
   ,      'Valor_Usd'                     = ISNULL( DetMov.Momontomon2 * ISNULL( tcx.vmvalor, 0.0), 0.0)    
   ,      'Mx_Recompra'                   = CASE WHEN con.cafechacontrato = @Fecha_Hoy THEN 0.0     
                                                 ELSE                                       ISNULL( det.camontomon2 * ISNULL( tcx.vmvalor, 0.0), 0.0)    
                                            END    
   ,      'cantidad_cortes'               = 1    
   FROM    OPTcaEncContrato                     con     
           LEFT JOIN OPTMoEncContrato EncMov ON EncMov.MoNumContrato = Con.CaNumContrato and EncMov.MoTipoTransaccion = 'CREACION'  
           LEFT JOIN OPTMoDetContrato DetMov ON DetMov.MoNumFolio    = EncMov.MoNumFolio    
           INNER JOIN OPTcaDetContrato          det ON con.canumcontrato      = det.canumcontrato    
		   INNER JOIN BacParamSuda.dbo.CLIENTE  cli ON cli.clrut              = con.carutcliente AND cli.clcodigo    = con.cacodigo    
           INNER JOIN #VALOR_TC_CONTABLE        tcc ON tcc.vmfecha            = @dAcfecproc      AND tcc.vmcodigo      = det.cacodmon1    
           INNER JOIN #VALOR_TC_CONTABLE        tcx ON tcx.vmfecha            = @dAcfecproc      AND tcx.vmcodigo      = det.cacodmon2    
   WHERE   con.cafechacontrato            = @Fecha_Hoy    
    
   --> ( 5 ) Devengamiento y Valorización    
   -- MAP 20130220 Cambios realizados  
   -- Reversa el Monto2 de la carteraRes y si la operacon está en su   
   -- primer día lo reversa del movimiento.  
   -- Imputa el Monto2 sacándolo de la cartera.  
  
   INSERT INTO BAC_CNT_CONTABILIZA    
   (      id_sistema    
   ,      tipo_movimiento    
   ,      tipo_operacion    
   ,      operacion    
   ,      correlativo    
   ,      codigo_instrumento    
   ,      moneda_instrumento    
   ,      forma_pago    
   ,      Moneda_Compra    
   ,      Moneda_Venta    
   ,      tipo_cliente    
   ,      CarteraNormativa    
   ,      SubCarteraNormativa    
   ,      Valor_Compra    
   ,      Valor_Venta    
   ,      Valor_Hoy_Recompra    
   ,      Utilidad_Valorizacion    
   ,      Perdida_Valorizacion    
   ,      Reversa_Valorizacion_Utilidad    
   ,      Reversa_Valorizacion_Perdida    
   ,      Utilidad    
   ,      Perdida    
   ,      UtilidadEFisica    
   ,      PerdidaEFisica    
   ,      Valor_Presente    
   ,      Valor_Usd    
   ,      Mx_Recompra    
   ,      cantidad_cortes    
   )    
   SELECT DISTINCT  
          'id_sistema'                    = 'BFW'  
   ,      'tipo_movimiento'               = 'DEV'    
   ,      'tipo_operacion'                = 'D' + ltrim(rtrim(con.OpcContabExternaProd))   
                                                +  LTRIM(RTRIM( con.cacvestructura  ) )  
   ,      'operacion'                     = con.canumcontrato    
   ,      'correlativo'                   = 1 -- select * from OPTcaDetContrato  
   ,      'codigo_instrumento'            = det.cacodmon2    
  ,      'moneda_instrumento'            = ''    
   ,      'forma_pago'                    = CASE WHEN det.camodalidad = 'C' THEN det.caformapagocomp    
                                                 ELSE                            det.caformapagomon2    
                                            END    
   ,      'Moneda_Compra'                 = det.cacodmon1    
   ,      'Moneda_Venta'                  = det.cacodmon2    
   ,      'tipo_cliente'                  = CASE WHEN cli.clpais = 6 THEN 2 ELSE 1 END    
   ,      'CarteraNormativa'              = con.cacarnormativa    
   ,      'SubCarteraNormativa'           = con.casubcarnormativa    
   ,      'Valor_Compra'                  = ISNULL( det.camontomon1 * @fValorDo_Hoy  ,0.0)    
   ,      'Valor_Venta'                   = isnull( det.camontomon1 * ISNULL( tcc.vmvalor, 0.0), 0.0)    
   ,      'Valor_Hoy_Recompra'            = CASE WHEN con.cafechacontrato = @Fecha_Hoy THEN 0.0     
                                                 ELSE                                       ISNULL( det.camontomon1 * ISNULL( tcc.vmvalor, 0.0), 0.0)    
                                            END    
    
   ,      'Utilidad_Valorizacion'         = CASE WHEN det.CaFechaPagoEjer = @Fecha_Hoy THEN 0     
                                                 ELSE CASE WHEN Con.cavr >= 0 THEN ABS( ROUND(Con.cavr, 0) ) ELSE 0.0 END   
                                            END    
   ,      'Perdida_Valorizacion'          = CASE WHEN det.CaFechaPagoEjer = @Fecha_Hoy THEN 0     
                                                 ELSE CASE WHEN Con.cavr <  0 THEN ABS( ROUND(Con.cavr, 0) ) ELSE 0.0 END  
                                            END    
    
   ,      'Reversa_Valorizacion_Utilidad' = ISNULL(CASE WHEN con.cafechacontrato = @Fecha_Hoy THEN 0.0     
                                                        ELSE CASE WHEN res.cavr >= 0 THEN ABS( ROUND(res.cavr, 0)) ELSE 0.0 END  
                                                   END, 0.0)    
   ,      'Reversa_Valorizacion_Perdida'  = ISNULL(CASE WHEN con.cafechacontrato = @Fecha_Hoy THEN 0.0     
                                                        ELSE CASE WHEN res.cavr <  0 THEN ABS( ROUND(res.cavr, 0)) ELSE 0.0 END  
                           END, 0.0)    
    
   ,      'Utilidad'       = 0.0 --> CASE WHEN det.camodalidad = 'C' AND xxmonto >= 0 THEN ABS( xxmonto ) ELSE 0.0 END    
   ,      'Perdida'                       = 0.0 --> CASE WHEN det.camodalidad = 'C' AND xxmonto <  0 THEN ABS( xxmonto ) ELSE 0.0 END    
   ,      'UtilidadEFisica'               = 0.0 --> CASE WHEN det.camodalidad = 'E' AND xxmonto >= 0 THEN ABS( xxmonto ) ELSE 0.0 END    
   ,      'PerdidaEFisica'                = 0.0 --> CASE WHEN det.camodalidad = 'E' AND xxmonto <  0 THEN ABS( xxmonto ) ELSE 0.0 END    
    
                                            -- debe grabarse el monto 2, uno de los dos conceptos se debe multiplica por le valor de moneda2  
   ,      'Valor_Presente'                = CASE WHEN det.CaFechaPagoEjer = @Fecha_Hoy THEN 0.0    
                                                     ELSE round( ISNULL( det.camontomon2, 0 ) , 0.0 )      
                                            END  
  
                                            -- Contabiliza Monto 2   
   ,      'Valor_Usd'                     = CASE WHEN det.CaFechaPagoEjer = @Fecha_Hoy THEN 0.0    
                                                 ELSE ROUND(ISNULL( det.camontomon2 * ISNULL( tcx.vmvalor, 0.0), 0.0),0)    
                                            END    
  
                                            -- Reverso Monto 2  
  
   ,      'Mx_Recompra'                   = CASE WHEN con.cafechacontrato = @Fecha_Hoy	THEN  round( ISNULL( detMov.MoMontoMon2 , 0 ) , 0 )  
																						ELSE  CASE WHEN det.CaFechaPagoEjer = @Fecha_Hoy THEN 0.0                                         
																								ELSE round( ISNULL( resDet.camontomon2 , 0 ) , 0 ) END  
                                            END    
  
   ,      'cantidad_cortes'               = 1  -- select * from OPTMoDetContrato  
   FROM   OPTcaEncContrato                     con     
          INNER JOIN OPTcaDetContrato          det ON con.canumcontrato      = det.canumcontrato    
          LEFT  JOIN OPTcaResEncContrato       res ON res.caEncfecharespaldo = @dAcfecante      AND res.canumcontrato = con.canumcontrato  
          LEFT  JOIN OPTcaResDetContrato       resDet ON resDet.caDetfecharespaldo = @dAcfecante      AND resDet.canumcontrato = con.canumcontrato AND resDet.caNumEstructura = det.CaNumEstructura  
          LEFT  JOIN OPTMoEncContrato          conMOV ON con.CanumContrato   = conMov.MoNumCOntrato  AND conMOV.moTipoTransaccion = 'CREACION'   
          LEFT  JOIN OPTMoDetContrato          detMov ON conMov.MonumFolio    = detMov.MoNumFolio  AND detMOV.moNumEstructura = det.CaNumEstructura   
          INNER JOIN BacParamSuda.dbo.CLIENTE  cli ON cli.clrut              = con.carutcliente AND cli.clcodigo      = con.cacodigo    
          INNER JOIN #VALOR_TC_CONTABLE        tcc ON tcc.vmfecha            = @dAcfecproc      AND tcc.vmcodigo      = det.cacodmon1    
          INNER JOIN #VALOR_TC_CONTABLE        tcx ON tcx.vmfecha            = @dAcfecproc      AND tcx.vmcodigo      = det.cacodmon2    
    
  
   -->    Vencimiento Fwd Americano  
   -->    Por aplicarse estructura con mas de un componente  
   -->    se prefiere contabilizar como un evento aparte  
  
   update BAC_CNT_CONTABILIZA   
       set  Valor_Presente = 0  
          , Valor_Usd      = 0  
          , Mx_Recompra    = 0   
  where     id_sistema = 'BFW'   
        and tipo_movimiento = 'DEV'     
        and Valor_Usd = Mx_Recompra  -- Si no hubo variacion de MontoMon2 no se genera imputacion y reverso de nominales  
          
-- select * from bac_cnt_contabiliza where operacion = 1754  
  
  
   INSERT INTO BAC_CNT_CONTABILIZA    
   (      id_sistema    
   ,      tipo_movimiento    
   ,      tipo_operacion    
   ,      operacion    
   ,      correlativo    
   ,      codigo_instrumento    
   ,      moneda_instrumento    
   ,      forma_pago    
   ,      Moneda_Compra    
   ,      Moneda_Venta    
   ,      tipo_cliente    
   ,      CarteraNormativa    
   ,      SubCarteraNormativa    
   ,      Valor_Compra    
   ,      Valor_Venta    
   ,      Valor_Hoy_Recompra    
   ,      Utilidad_Valorizacion    
   ,      Perdida_Valorizacion    
   ,      Reversa_Valorizacion_Utilidad    
   ,      Reversa_Valorizacion_Perdida    
   ,      Utilidad    
   ,      Perdida    
   ,      UtilidadEFisica    
   ,      PerdidaEFisica    
   ,      Valor_Presente    
   ,      Valor_Usd    
   ,      Mx_Recompra    
   ,      Acumulado_Utili_Corte    
-- ,      Tipo_Opcion    
   ,      cantidad_cortes    
   )    
   SELECT 'id_sistema'                    = 'BFW'    
   ,      'tipo_movimiento'               = 'MOV'    
   ,      'tipo_operacion'                = 'V' + Ltrim(rtrim(OpcContabExternaProd)) + LTRIM(RTRIM( con.CaCVEstructura ))   
   ,      'operacion'                     = eje.CaNumContrato    
   ,      'correlativo'                   = 1    
   ,      'codigo_instrumento'            = eje.CaCodMon2    
   ,      'moneda_instrumento'            = ''    
   ,      'forma_pago'                    = CASE WHEN eje.CaModalidad = 'C' THEN eje.CaFormaPagoComp    
                                                 ELSE                            eje.CaFormaPagoMon1    
                                            END    
   ,      'Moneda_Compra'                 = eje.CaCodMon1    
   ,  'Moneda_Venta'                  = eje.CaCodMon2    
   , 'tipo_cliente'                  = CASE WHEN cli.clpais = 6 THEN 2 ELSE 1 END    
   ,      'CarteraNormativa'              = con.CaCarNormativa    
   ,      'SubCarteraNormativa'           = con.CaSubCarNormativa    
   ,      'Valor_Compra'                  = eje.CaMontoMon1 --> ROUND( ISNULL( det.MoMontoMon1 * @fValorDo_Hoy  ,0.0), 0)    
   ,      'Valor_Venta'                   = eje.CaMontoMon1 --> ROUND( ISNULL( det.MoMontoMon1 * ISNULL( tcc.vmvalor, 0.0), 0.0), 0)    
   ,      'Valor_Hoy_Recompra'            = eje.CaMontoMon1 --> CASE WHEN eje.MoFechaContrato = @Fecha_Hoy THEN 0.0     
                                                            -->      ELSE                                 ISNULL( det.MoMontoMon1 * ISNULL( tcc.vmvalor, 0.0), 0.0)    
                                                            --> END    
   ,      'Utilidad_Valorizacion'         = 0.0    
   ,      'Perdida_Valorizacion'          = 0.0    
   ,      'Reversa_Valorizacion_Utilidad' = 0.0    
   ,      'Reversa_Valorizacion_Perdida'  = 0.0    

   ,      'Utilidad'                      = CASE	WHEN caj.CaCajMdaM1 = 999	and eje.CaModalidad = 'C' AND caj.CaCajMtoMon1 >= 0 THEN ABS( caj.CaCajMtoMon1 )
													WHEN caj.CaCajMdaM1 = 13	and eje.CaModalidad = 'C' AND caj.CaCajMtoMon1 >= 0 THEN ABS( caj.CaCajMtoMon1 * @vDoDia )
													ELSE 0.0 
											END
   ,      'Perdida'                       = CASE	WHEN caj.CaCajMdaM1 = 999	and eje.CaModalidad = 'C' AND caj.CaCajMtoMon1 <  0 THEN ABS( caj.CaCajMtoMon1 )
													WHEN caj.CaCajMdaM1 = 13	and eje.CaModalidad = 'C' AND caj.CaCajMtoMon1 <  0 THEN ABS( caj.CaCajMtoMon1 * @vDoDia )
													ELSE 0.0
											END

-- ,      'UtilidadEFisica'               = CASE WHEN eje.CaModalidad = 'E' AND eje.CaMontoMon1 >= 0 THEN ABS( eje.CaMontoMon1 ) ELSE 0.0 END    
-- ,      'PerdidaEFisica'                = CASE WHEN eje.CaModalidad = 'E' AND eje.CaMontoMon1 <  0 THEN ABS( eje.CaMontoMon1 ) ELSE 0.0 END    
    
   ,      'UtilidadEFisica'               = CASE WHEN eje.CaModalidad = 'E' AND con.CaCVEstructura = 'V' AND ((eje.CaStrike - @vDoDia) * eje.CaMontoMon1) >= 0 THEN ABS( ((eje.CaStrike - @vDoDia) * eje.CaMontoMon1) )    
                                                 WHEN eje.CaModalidad = 'E' AND con.CaCVEstructura = 'C' AND ((@vDoDia - eje.CaStrike) * eje.CaMontoMon1) >= 0 THEN ABS( ((@vDoDia - eje.CaStrike) * eje.CaMontoMon1) )    
                                                 ELSE 0.0    
                                            END    
--                                          CASE WHEN eje.CaModalidad = 'E' AND ((eje.CaStrike - @vDoDia) * eje.CaMontoMon1) >= 0 THEN ABS( ((eje.CaStrike - @vDoDia) * eje.CaMontoMon1) ) ELSE 0.0 END    
   ,      'PerdidaEFisica'                = CASE WHEN eje.CaModalidad = 'E' AND con.CaCVEstructura = 'V' AND ((eje.CaStrike - @vDoDia) * eje.CaMontoMon1) < 0 THEN ABS( ((eje.CaStrike - @vDoDia) * eje.CaMontoMon1) )    
                                                 WHEN eje.CaModalidad = 'E' AND con.CaCVEstructura = 'C' AND ((@vDoDia - eje.CaStrike) * eje.CaMontoMon1) < 0 THEN ABS( ((@vDoDia - eje.CaStrike) * eje.CaMontoMon1) )    
                                                 ELSE 0.0    
                                            END    
--                                          CASE WHEN eje.CaModalidad = 'E' AND ((eje.CaStrike - @vDoDia) * eje.CaMontoMon1) <  0 THEN ABS( ((eje.CaStrike - @vDoDia) * eje.CaMontoMon1) ) ELSE 0.0 END    
   ,      'Valor_Presente'                = 0.0    
   ,      'Valor_Usd'                     = ROUND( eje.CaMontoMon1 * eje.CaStrike, 0)    
   ,      'Mx_Recompra'                   = 0.0    
   ,      'Acumulado_Utili_Corte'         = 0.0    
-- ,      'Tipo_Opcion'                   = 0.0    
   ,      'cantidad_cortes'               = 1    
   FROM   OPTcaDetContrato    eje  
          INNER JOIN OPTcaEncContrato          con ON con.CaNumContrato = eje.CaNumContrato  
  INNER JOIN OPTCaCaja                 caj ON caj.CaNumContrato = eje.CaNumContrato AND caj.CaCajFecPago  = @Fecha_Hoy    
          INNER JOIN BacParamSuda.dbo.CLIENTE  cli ON cli.clrut         = con.CaRutCliente  AND cli.clcodigo      = con.CaCodigo    
   WHERE  eje.CaFechaVcto                = @Fecha_Hoy    
     AND  con.OpcContabExternaTip        = 'FWD_AMERICANO'       
     AND  caj.CaCajEstado                = 'E'    
     AND  con.CaNumContrato              NOT IN(SELECT MoNumContrato FROM OPTmoEncContrato WHERE MoTipoTransaccion = 'EJERCE' )    
    
   -->    Vencimiento Otros Fwd  
   INSERT INTO BAC_CNT_CONTABILIZA  
   (      id_sistema  
   ,      tipo_movimiento  
   ,      tipo_operacion  
   ,      operacion  
   ,      correlativo  
   ,      codigo_instrumento  
   ,      moneda_instrumento  
   ,      forma_pago  
   ,      Moneda_Compra  
   ,      Moneda_Venta  
   ,      tipo_cliente  
   ,      CarteraNormativa  
   ,      SubCarteraNormativa  
   ,      Valor_Compra  
   ,      Valor_Venta  
   ,      Valor_Hoy_Recompra  
   ,      Utilidad_Valorizacion  
   ,      Perdida_Valorizacion  
   ,      Reversa_Valorizacion_Utilidad  
   ,      Reversa_Valorizacion_Perdida  
   ,      Utilidad  
   ,      Perdida  
   ,      UtilidadEFisica  
   ,      PerdidaEFisica  
   ,      Valor_Presente  
   ,      Valor_Usd  
   ,      Mx_Recompra  
   ,      Acumulado_Utili_Corte  
   ,      cantidad_cortes  
   )    
   SELECT  
          'id_sistema'                    = 'BFW'  
   ,      'tipo_movimiento'               = 'MOV'  
   ,      'tipo_operacion'                = 'V' + ltrim(rtrim(con.OpcContabExternaProd))  + LTRIM(RTRIM( con.CaCVEstructura ))   
   ,      'operacion'                     = Con.CaNumContrato  
   ,      'correlativo'                   = 1 -- eje.CaNumEstructura  
   ,      'codigo_instrumento'            = Eje.CaCodMon2   
   ,      'moneda_instrumento'            = ''  
   ,      'forma_pago'                    = CASE WHEN eje.CaModalidad = 'C' THEN eje.CaFormaPagoComp  
                                                 ELSE                            eje.CaFormaPagoMon1  
                                            END   
   ,      'Moneda_Compra'                 = eje.CaCodMon1   
   ,      'Moneda_Venta'                  = eje.CaCodMon2   
   ,      'tipo_cliente'                  = CASE WHEN cli.clpais = 6 THEN 2 ELSE 1 END  
   ,      'CarteraNormativa'              = con.CaCarNormativa  
   ,      'SubCarteraNormativa'           = con.CaSubCarNormativa  
   ,      'Valor_Compra'                  = eje.CaMontoMon1   
   ,      'Valor_Venta'                   = eje.CaMontoMon1   
   ,      'Valor_Hoy_Recompra'            = eje.CaMontoMon1  
   ,      'Utilidad_Valorizacion'         = 0.0  
   ,      'Perdida_Valorizacion'          = 0.0  
   ,      'Reversa_Valorizacion_Utilidad' = 0.0  
   ,      'Reversa_Valorizacion_Perdida'  = 0.0  
  
   ,      'Utilidad'                      = CASE	WHEN caj.CaCajMdaM1 = 999	and eje.CaModalidad = 'C' AND SUM( caj.CaCajMtoMon1	)	>= 0 THEN ABS( SUM( caj.CaCajMtoMon1) ) 
													WHEN caj.CaCajMdaM1 = 13	and eje.CaModalidad = 'C' AND SUM( caj.CaCajMtoMon1 )	>= 0 THEN ABS( SUM( caj.CaCajMtoMon1) * @vDoDia )
													ELSE 0.0 
											END  
											
   ,      'Perdida'                       = CASE	WHEN caj.CaCajMdaM1 = 999	and eje.CaModalidad = 'C' AND SUM(caj.CaCajMtoMon1)		< 0  THEN ABS( SUM( caj.CaCajMtoMon1) ) 
													WHEN caj.CaCajMdaM1 = 13	and eje.CaModalidad = 'C' AND SUM(caj.CaCajMtoMon1)		< 0  THEN ABS( SUM( caj.CaCajMtoMon1) * @vDoDia )
													ELSE 0.0 
											END  
  
   ,      'UtilidadEFisica'               = CASE WHEN eje.CaModalidad = 'E' AND con.CaCVEstructura = 'V' AND ( (eje.CaStrike - @vDoDia) * eje.CaMontoMon1) >= 0 THEN ABS( ((eje.CaStrike - @vDoDia ) * eje.CaMontoMon1 ) )  
                                                 WHEN eje.CaModalidad = 'E' AND con.CaCVEstructura = 'C' AND ((@vDoDia - eje.CaStrike) * eje.CaMontoMon1) >= 0 THEN ABS( ((@vDoDia - eje.CaStrike ) * eje.CaMontoMon1 ) )  
                                                 ELSE 0.0  
                                            END   
  
   ,      'PerdidaEFisica'                = CASE WHEN eje.CaModalidad = 'E' AND con.CaCVEstructura = 'V' AND ((eje.CaStrike - @vDoDia) * eje.CaMontoMon1 ) < 0 THEN ABS( (( eje.CaStrike - @vDoDia) * eje.CaMontoMon1) )  
                                                 WHEN eje.CaModalidad = 'E' AND con.CaCVEstructura = 'C' AND ((@vDoDia - eje.CaStrike) * eje.CaMontoMon1 ) < 0 THEN ABS( ((@vDoDia - eje.CaStrike) * eje.CaMontoMon1) )  
                                                 ELSE 0.0  
                                            END   
  
   ,      'Valor_Presente'                = 0.0  
   ,      'Valor_Usd'					  = ROUND( eje.CaMontoMon1 *  eje.CaStrike , 0)   
   ,      'Mx_Recompra'                   = 0.0  
   ,      'Acumulado_Utili_Corte'         = 0.0  
   ,      'cantidad_cortes'               = 1  
   FROM   OPTcaEncContrato                     Con  
          INNER JOIN OPTcaDetContrato          eje ON con.CaNumContrato = eje.CaNumContrato  
          INNER JOIN OPTCaCaja                 caj ON caj.CaNumContrato = eje.CaNumContrato AND  Caj.CaNumEstructura = eje.CaNumEstructura and caj.CaCajFecPago  = @Fecha_Hoy -- select * from OPTCaCaja   
          INNER JOIN BacParamSuda.dbo.CLIENTE  cli ON cli.clrut         = con.CaRutCliente  AND cli.clcodigo      = con.CaCodigo  
   WHERE  eje.CaFechaVcto                = @Fecha_Hoy  
     AND  Con.OpcContabExternaTip        = 'OTROS_FWD'   
     AND  caj.CaCajEstado                = 'E'  
     AND  con.CaNumContrato              NOT IN (SELECT MoNumContrato FROM OPTmoEncContrato WHERE MoTipoTransaccion in ( 'ANTICIPA' ))  
   GROUP BY   
        Con.CaCodEstructura  
      , Con.CaCVEstructura  
      , Con.CaNumContrato  
      , Eje.CaNumContrato  
--    , Eje.CaNumEstructura  
      , Eje.CacodMon1      
      , Eje.CaMontoMon1   
      , eje.CaStrike  
      , Eje.CaCodMon2  
      , eje.CaModalidad    
      , Caj.CaCajModalidad    
      , Eje.CaFormaPagoComp  
      , Eje.CaFormaPagoMon1  
      , Cli.ClPais  
      , Con.CaCarNormativa  
      , Con.CaSubCarNormativa  
      , con.OpcContabExternaProd
	  , caj.CaCajMdaM1

  
   -->    Anticipo    
   INSERT INTO BAC_CNT_CONTABILIZA    
   (      id_sistema    
   ,      tipo_movimiento    
   ,      tipo_operacion    
   ,      operacion    
   ,      correlativo    
   ,      codigo_instrumento    
   ,      moneda_instrumento    
   ,      forma_pago    
   ,      Moneda_Compra    
   ,      Moneda_Venta    
   ,      tipo_cliente    
   ,      CarteraNormativa    
   ,      SubCarteraNormativa    
   ,      Valor_Compra    
   ,      Valor_Venta    
   ,      Valor_Hoy_Recompra    
   ,      Utilidad_Valorizacion    
   ,      Perdida_Valorizacion    
   ,      Reversa_Valorizacion_Utilidad    
   ,      Reversa_Valorizacion_Perdida    
   ,      Utilidad    
   ,      Perdida    
   ,      UtilidadEFisica    
   ,      PerdidaEFisica    
   ,      Valor_Presente    
   ,      Valor_Usd    
   ,      Mx_Recompra    
   ,      Acumulado_Utili_Corte    
-- ,      Tipo_Opcion    
   ,      cantidad_cortes    
   )    
   SELECT    
          'id_sistema'                    = 'BFW'  
   ,      'tipo_movimiento'               = 'ANT'    
   ,      'tipo_operacion'                = ltrim(rtrim(Eje.OpcContabExternaProd)) + LTRIM(RTRIM( eje.MoCVEstructura ))  
   ,      'operacion'                     = eje.MoNumContrato    
   ,      'correlativo'                   = 1    
   ,      'codigo_instrumento'            = det.MoCodMon2    
   ,      'moneda_instrumento'            = ''    
   ,      'forma_pago'                    = CASE WHEN caj.CaCajModalidad = 'C' THEN caj.CaCajFormaPagoMon1    
                                                 ELSE                               caj.CaCajFormaPagoMon2    
                                            END    
   ,      'Moneda_Compra'                 = det.MoCodMon1    
   ,      'Moneda_Venta'                  = det.MoCodMon2    
   ,      'tipo_cliente'                  = CASE WHEN cli.clpais = 6 THEN 2 ELSE 1 END    
   ,      'CarteraNormativa'              = eje.MoCarNormativa    
   ,      'SubCarteraNormativa'           = eje.MoSubCarNormativa    
   ,      'Valor_Compra'                  = det.MoMontoMon1 --> ROUND( ISNULL( det.MoMontoMon1 * @fValorDo_Hoy  ,0.0), 0)    
   ,      'Valor_Venta'                   = det.MoMontoMon1 --> ROUND( ISNULL( det.MoMontoMon1 * ISNULL( tcc.vmvalor, 0.0), 0.0), 0)    
   ,      'Valor_Hoy_Recompra'            = det.MoMontoMon1 --> CASE WHEN eje.MoFechaContrato = @Fecha_Hoy THEN 0.0     
                                                            -->      ELSE                                       ISNULL( det.MoMontoMon1 * ISNULL( tcc.vmvalor, 0.0), 0.0)    
                                                            --> END    
   ,      'Utilidad_Valorizacion'         = 0.0    
   ,      'Perdida_Valorizacion'          = 0.0    
   ,      'Reversa_Valorizacion_Utilidad' = 0.0    
   ,      'Reversa_Valorizacion_Perdida'  = 0.0    
    
   ,      'Utilidad'                      = CASE	WHEN caj.CaCajMdaM1 = 999	and caj.CaCajModalidad = 'C' AND sum(caj.CaCajMtoMon1) >= 0 THEN ABS( sum(caj.CaCajMtoMon1) )
													WHEN caj.CaCajMdaM1 = 13	and caj.CaCajModalidad = 'C' AND sum(caj.CaCajMtoMon1) >= 0 THEN ABS( sum( round(caj.CaCajMtoMon1 * @vDoDia,0) ) )
													ELSE 0.0
												END
   ,      'Perdida'                       = CASE	WHEN caj.CaCajMdaM1 = 999	and caj.CaCajModalidad = 'C' AND sum(caj.CaCajMtoMon1) <  0 THEN ABS( Sum(caj.CaCajMtoMon1) )
													WHEN caj.CaCajMdaM1 = 13	and caj.CaCajModalidad = 'C' AND sum(caj.CaCajMtoMon1) <  0 THEN ABS( Sum( round(caj.CaCajMtoMon1 * @vDoDia,0) ) )
													ELSE 0.0
												END

-- ,      'UtilidadEFisica'               = CASE WHEN caj.CaCajModalidad = 'E' AND caj.CaCajMtoMon1 >= 0 THEN ABS( caj.CaCajMtoMon1 ) ELSE 0.0 END    
-- ,      'PerdidaEFisica'                = CASE WHEN caj.CaCajModalidad = 'E' AND caj.CaCajMtoMon1 <  0 THEN ABS( caj.CaCajMtoMon1 ) ELSE 0.0 END    
    
   ,      'UtilidadEFisica'               = CASE WHEN eje.MoCVEstructura = 'V' AND caj.CaCajModalidad = 'E' AND ((det.MoStrike - @vDoDia) * det.MoMontoMon1) >= 0 THEN ABS( ((det.MoStrike - @vDoDia) * det.MoMontoMon1) )    
                                                 WHEN eje.MoCVEstructura = 'C' AND caj.CaCajModalidad = 'E' AND ((@vDoDia - det.MoStrike) * det.MoMontoMon1) >= 0 THEN ABS( ((@vDoDia - det.MoStrike) * det.MoMontoMon1) )    
                                                 ELSE 0.0    
                                            END    
--                                          CASE WHEN caj.CaCajModalidad = 'E' AND ((det.MoStrike - @vDoDia) * det.MoMontoMon1) >= 0 THEN ABS( ((det.MoStrike - @vDoDia) * det.MoMontoMon1) ) ELSE 0.0 END    
   ,      'PerdidaEFisica'                = CASE WHEN eje.MoCVEstructura = 'V' AND caj.CaCajModalidad = 'E' AND ((det.MoStrike - @vDoDia) * det.MoMontoMon1) <  0 THEN ABS( ((det.MoStrike - @vDoDia) * det.MoMontoMon1) )    
                                                 WHEN eje.MoCVEstructura = 'C' AND caj.CaCajModalidad = 'E' AND ((@vDoDia - det.MoStrike) * det.MoMontoMon1) <  0 THEN ABS( ((@vDoDia - det.MoStrike) * det.MoMontoMon1) )                                    





												 ELSE 0.0
                                            END    
--                                          CASE WHEN caj.CaCajModalidad = 'E' AND ((det.MoStrike - @vDoDia) * det.MoMontoMon1) <  0 THEN ABS( ((det.MoStrike - @vDoDia) * det.MoMontoMon1) ) ELSE 0.0 END    
   ,     'Valor_Presente'                = 0.0    
   ,      'Valor_Usd'                     = ROUND( det.MoMontoMon1 * MoStrike, 0)    
   ,      'Mx_Recompra'                   = 0.0    
   ,      'Acumulado_Utili_Corte'         = 0.0    
-- ,      'Tipo_Opcion'                   = 0.0    
   ,      'cantidad_cortes'               = 1    
   FROM   OPTmoEncContrato                     eje    
          INNER JOIN OPTmoDetContrato          det ON det.MoNumFolio    = eje.MoNumFolio    
          INNER JOIN OPTCaCaja                 caj ON caj.CaNumContrato = eje.MoNumContrato AND caj.CaNumEstructura = Det.MoNumEstructura AND caj.CaCajFecPago  = @Fecha_Hoy  
          INNER JOIN BacParamSuda.dbo.CLIENTE  cli ON cli.clrut         = eje.MoRutCliente  AND cli.clcodigo      = eje.MoCodigo    
          LEFT JOIN #VALOR_TC_CONTABLE        tcc ON tcc.vmfecha       = MoFechaContrato   AND tcc.vmcodigo      = det.MoCodMon1    
          LEFT JOIN #VALOR_TC_CONTABLE        tcx ON tcx.vmfecha       = MoFechaContrato   AND tcx.vmcodigo      = det.MoCodMon2    
   WHERE  eje.MoTipoTransaccion          in (  'ANTICIPA', 'EJERCE' )   
    group by   
        Eje.MoCodEstructura  
      , Eje.MoCVEstructura  
      , eje.MoNumContrato        
      , Det.MocodMon1      
      , Det.moMontoMon1   
      , Det.moStrike  
      , Det.moCodMon2  
      , Det.moModalidad    
      , Caj.CaCajModalidad    
      , Det.moFormaPagoComp  
      , Det.moFormaPagoMon1  
      , Cli.ClPais  
      , Eje.moCarNormativa  
      , Eje.moSubCarNormativa  
      , Eje.OpcContabExternaProd  
      , Caj.CaCajFormaPagoMon1  
      , Caj.CaCajFormaPagoMon2
	  , caj.CaCajMdaM1
    
END
GO
