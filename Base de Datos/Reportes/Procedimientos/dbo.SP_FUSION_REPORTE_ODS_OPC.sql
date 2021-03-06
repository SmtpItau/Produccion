USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUSION_REPORTE_ODS_OPC]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*


2020-06-12 : Se solicita informar sólo una vez por operación, las columnas equivalente_credito_corporativo, equivalente_credito_normativo,
			 equivalente_credito_factor,equivalente_credito_factor_inter,equivalente_credito_factor_normativo. 

*/

CREATE PROCEDURE [dbo].[SP_FUSION_REPORTE_ODS_OPC]  
as   
begin  
 --OPCIONES  
  
DECLARE @Fecha_Proceso DATETIME = NULL  
DECLARE @Fecha_ProcesoAnt DATETIME = NULL  
DECLARE @Contraparte INT  
DECLARE @RutContraparte INT  

DECLARE @Contratos as Table (NumContrato varchar(5)) 

IF(@Fecha_Proceso IS NULL) BEGIN  
 SET @Fecha_Proceso  = (SELECT TOP 1 M.acfecproc FROM Bacfwdsuda.DBO.mfac M WITH(NOLOCK))  
 SET @Fecha_ProcesoAnt = (SELECT TOP 1 M.acfecante from bacfwdsuda.dbo.mfac m WITH(NOLOCK))  
 --SELECT  
 -- @Fecha_Proceso = M.acfecproc,  
 -- @Fecha_ProcesoAnt = m.acfecante  
 --FROM Bacfwdsuda.dbo.mfac M  
END  
  
SELECT   
    transaction_deal_num       = CONVERT(VARCHAR, EnContrato.CaNumContrato) +  CONVERT(VARCHAR, cadet.CaNumEstructura)  
  , transaction_status_id       = (CASE WHEN caestado = '' THEN 1 WHEN  caestado = 'N' THEN '2' end)  
  , transaction_trade_date      = CONVERT(varchar(30), CaDet.CaFechaInicioOpc, 126)    
  , transaction_start_date      = CONVERT(varchar(30), CaDet.CaFechaInicioOpc, 126)    
  , transaction_end_date       = CONVERT(varchar(30), CaDet.CaFechaVcto, 126)  
  , transaction_ET        = '1900-01-01T00:00:00'    
  , transaction_modalidad_pago     = case when CaDet.CaModalidad = 'E' then 1   
               else 2 end   
  , transaction_paymentconv_id     = 1 --> Validar  
  , transaction_nemo        = ''  
  , transaction_serie        = ''  
  , transaction_TIR_compra      = 0  
  , transaction_TIR_mercado      = 0    
  , transaction_strike       = CaDet.CaStrike  
  , transaction_id_group       = CONVERT(VARCHAR, EnContrato.CaNumContrato)  
  , side_type          = case when CaDet.CaCVOpc = 'C' then 1 else 2 end     
  , side_fix_flt         = 2  
  , side_frec_p         = CONVERT(VARCHAR, DATEDIFF (DAY ,EnContrato.cafechacontrato , CaDet.caFechaVcto) ) + 'd'  
  , side_reset_p         = '0d'  
  
  , side_notional         = CaDet.CaMontoMon1  
    
  --, side_notional_ccy_id  = CaDet.CaCodMon1  
  --, side_payment_ccy_id   = CaDet.CaCodMon2  
--  , side_notional_ccy_id       = dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, CaDet.CaCodMon1)) -->mgc.06.09.2017.Cambio Solicitado por V.Gonzales  
--  , side_notional_ccy_id       = CASE WHEN cadet.CaTipoOpc   = 'C' THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, CaDet.CaCodMon1))   
     , side_notional_ccy_id       = case when cadet.CaCVOpc   = 'C' THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, CaDet.CaCodMon1))   
                        ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, CaDet.CaCodMon2))  
                END  
  , side_payment_ccy_id       = case when Cadet.CaModalidad = 'C' THEN  dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, CaDet.CaMdaCompensacion))ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar,  CaDet.CaCodMon1)) END   
  , side_rate          = 0  
  , side_rate_spread        = 0  
  , side_rate_type_id        = 0    
  , side_projection_index       = 0    
  , side_yield_basis_id       = 2  
  , interest_id         = 0      
  , interest_start_date       = CONVERT(varchar(30), CaDet.CaFechaInicioOpc, 126)    
  , interest_end_date        = CONVERT(varchar(30), EnContrato.CaFechaUnwind, 126)    
  , interest_payment_date       = CONVERT(varchar(30), CaDet.CaFechaPagMon1, 126)    
  , interest_fixing_date       = CONVERT(varchar(30), CaDet.CaFechaFijacion, 126)     
  , interest_fixing_rate       = Fix.CaFijacion  
  , interest_accounting_date      = '1900-01-01T00:00:00'      
  , interest_rate         = 0  
  , interest_payment        = 0         
  , interest_df         = 0      
  , interest_npv         = 0   
  , cashflow_id         = 0  
  , cashflowtype_id        = 2  
  , cashflow_start_date       = '1900-01-01T00:00:00'  
  , cashflow_end_date        = '1900-01-01T00:00:00'  
  , cashflow_accounting_date      = '1900-01-01T00:00:00'  
  , cashflow_fixing_date       = '1900-01-01T00:00:00'  
  , cashflow_fixing_rate       = 0  
  , cashflow_amount        = 0  
  , cashflow_df         = 0  
  , cashflow_npv         = case when Cadet.CaModalidad = 'C' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,CaDet.CaVrDet,CaDet.CaMdaCompensacion),N'#0.########################')) ELSE   
                         convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,CaDet.CaVrDet, CaDet.CaCodMon1),N'#0.########################')) END  
  , facility_id         = 5     
  , transaction_info_tc_costo      = 0  
  , transaction_info_tc_cliente     = 0  
  , transaction_info_paridad_costo    = 0  
  , transaction_info_paridad_cliente    = 0  
  , transaction_info_spread_tc     = 0  
  , transaction_info_spread_paridad    = 0      
  , transaction_info_fx_spot_cliente    = 0  
  , transaction_info_fx_fwd_costo     = 0  
  , transaction_info_fx_fwd_cliente    = 0  
  , transaction_info_puntos_fwd     = 0  
  , transaction_info_fx_uf_spot     = 0  
  , transaction_info_fx_uf_tasa_costo    = 0  
  , transaction_info_fx_uf_tasa_margen   = 0  
  , transaction_info_fx_uf_tasa_cliente   = 0  
  , transaction_info_fx_spot_margen    = 0  
  , transaction_info_fx_fwd_margen    = 0  
  , transaction_info_fx_uf_tasa_sucia_costo  = 0  
  , transaction_info_fx_uf_tasa_sucia_cliente  = 0  
  --,equivalente_credito_corporativo = format(Monto_Matriz,N'#.############')  
  --,equivalente_credito_normativo =  format(Equiv_Credito,N'#.############')  
  --,equivalente_credito_factor = Factor  
  , equivalente_credito_corporativo    = convert(varchar,format(ISNULL((SELECT top 1  MontoOriginal + MontoTransaccion FROM Baclineas.dbo.LINEA_TRANSACCION WHERE id_sistema = 'opt'   
                                                                                    AND NumeroOperacion = EnContrato.CaNumContrato   
                        AND EnContrato.CaRutCliente = Rut_Cliente    
                        AND EnContrato.CaCodigo = Codigo_Cliente ),0),N'#0.########################'))  
  , equivalente_credito_normativo     = convert(varchar,format(ISNULL((SELECT top 1 Equiv_Credito FROM  Bactradersuda.dbo.ART84_DERIVADOS_OPCIONES   
                                                                                    WHERE Fecha_Proc = @Fecha_ProcesoAnt   
                        AND NumOpe = EnContrato.CaNumContrato),0),N'#0.########################'))  
  , equivalente_credito_factor     = convert(varchar,format(ISNULL((SELECT top 1 MatrizRiesgo FROM Baclineas.dbo.LINEA_TRANSACCION   
                                                                                    WHERE id_sistema = 'opt'   
                        AND NumeroOperacion = EnContrato.CaNumContrato   
                        AND  EnContrato.CaRutCliente = Rut_Cliente   
                        AND EnContrato.CaCodigo = Codigo_Cliente),0),N'#0.########################'))       
  , equivalente_credito_factor_inter    = convert(varchar,format(ISNULL((SELECT top 1 MatrizRiesgo FROM Baclineas.dbo.LINEA_TRANSACCION   
                                                                                   WHERE id_sistema = 'opt'   
                       AND NumeroOperacion = EnContrato.CaNumContrato   
                       AND  EnContrato.CaRutCliente = Rut_Cliente   
                                                                                         AND  EnContrato.CaCodigo = Codigo_Cliente),0),N'#0.########################'))  
  , equivalente_credito_factor_normativo   = convert(varchar,format(ISNULL((SELECT top 1 Factor FROM  Bactradersuda.dbo.ART84_DERIVADOS_OPCIONES   
                                                                                    WHERE Fecha_Proc = @Fecha_ProcesoAnt   
                        AND NumOpe = EnContrato.CaNumContrato),0),N'#0.########################'))  
  , medio_transaccional_id      = dbo.fx_MedioTransaccional_ID(BacParamSuda.dbo.fx_mesa_operador_ID(EnContrato.CaOperador))  
  , canal_transaccional_id      = BacParamSuda.dbo.fx_mesa_operador_ID(EnContrato.CaOperador)      
  , profit_value         = (case when convert(varchar,format(EnContrato.CaResultadoVentasML,N'#0.########################')) ='' then '0'  
               else convert(varchar,format(EnContrato.CaResultadoVentasML,N'#0.########################'))  
               end)    
  , profit_ccy_id         = dbo.Fx_Convalida_Pais_ODS('ODS', '999')    
  , profit_mesa_clientes_clp      = 0  
  , profit_mesa_trading_clp      = 0    
  , portfolio_id         = EnContrato.CaCarteraFinanciera  
  , instrument_id         = 1000003  
  , product_id         = 2  
  , party_id          = clie.clrut  
  , party_rut          = CONVERT(VARCHAR, clie.clrut) + '-' + RTRIM(LTRIM(CONVERT(VARCHAR, Clie.cldv)))  
  , party_secuencia        = DBO.Fx_Tipo_Contraparte_ODS (clie.clrut, clie.clcodigo)  
  --, pricing_mtm         =  convert(varchar,format( (CaDet.CaVrDet /(select Tipo_cambio   
  -- FROM bacparamsuda.dbo.valor_moneda_contable WHERE Fecha = @Fecha_Proceso AND Codigo_Moneda = case when   
  -- CaDet.CaCodMon1 = 13 THEN 994 ELSE CaDet.CaCodMon1  END )),N'#0.########################'))    
  , pricing_mtm         = case when Cadet.CaModalidad = 'C' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,CaDet.CaVrDet,CaDet.CaMdaCompensacion),N'#0.########################')) ELSE   
                         convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,CaDet.CaVrDet, CaDet.CaCodMon1),N'#0.########################')) END  
    
  , pricing_mtm_ccy_id       = case when Cadet.CaModalidad = 'C' THEN  dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, CaDet.CaMdaCompensacion))ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar,  CaDet.CaCodMon1)) END   
  
  , pricing_base_mtm        = convert(varchar,format(CaDet.CaVrDet,N'#0.########################'))  
  
  
  
     , pricing_pnl         = convert(varchar,format(isnull( (   CaDet.CaPrimaInicialDetML   
                                                                                     + ISNULL((SELECT sum(CaMTMImplicito)  
                            FROM CbMdbOpc.dbo.CaResCaja   
                         WHERE CaNumContrato = CaDet.CaNumContrato    
                         AND CaCajOrigen = 'PV' GROUP BY CaNumContrato),0)), 0),N'#0.########################'))  
  , pricing_pnl_fx_unrealized      = convert(varchar,format(CaDet.CaVrDet,N'#0.########################'))  
  
  , pricing_delta         = convert(varchar,format(EnContrato.CaDeltaForwardCont,N'#0.########################'))  
   
  , pricing_gamma         = convert(varchar,format(EnContrato.CaGammaSpotCont,N'#0.########################'))  
  , pricing_vega         = convert(varchar,format(EnContrato.CaVegaCont,N'#0.########################'))  
  , pricing_beta         = 0  
  , pricing_rho_local        = 0    
  , pricing_rho_foranea       = convert(varchar,format(EnContrato.CaRhoForCont,N'#0.########################'))  
  , pricing_theta         = convert(varchar,format(EnContrato.CaThetaCont,N'#0.########################'))  
  , pricing_volga         = convert(varchar,format(EnContrato.CaVolgaCont,N'#0.########################'))  
  , side_id = 1  
  , call_put_id         = CASE WHEN Cadet.CaCallPut = 'Call' THEN 1 ELSE 2 END  
  , 1 As Orden  
  --campos nuevos  
  ,[transaction_emisor_id]      = ''   
  ,[transaction_plazo_pacto]      = 0   
  ,[transaction_tasa_costo_pacto]     = 0   
  ,[transaction_tasa_pacto]      = 0   
  ,[transaction_tir_compra_origen]    = 0   
  ,[transaction_tir_compra_ppa]     = 0   
  ,[transaction_dev_tir_compra]     = 0   
  ,[transaction_tipo_operacion_id]    = 0   
  ,[transaction_fecha_compra_ins]     = '1900-01-01T00:00:00'  
  ,[transaction_fecha_cupon]      = '1900-01-01T00:00:00'  
 ----------------------------------------------------------------------------  
  , [Cuenta_GL]         = convert(varchar(20), '0')  
  , [Cuenta_SBIF]        = convert(varchar(20), '0')  
  , [cashflow_amount_add]      = convert(varchar(20), '0')  
  , [portfolio_super]       = substring(ltrim(rtrim( isnull(cNorma.Descripcion,  '') )), 1,250)  
  , [portfolio_scn]        = substring(ltrim(rtrim( isnull(cSubCar.Descripcion, '') )), 1,250)  
  , [side_discount_index]      = ''  
  , [interest_rate_icp]       = '0'  
  
--->mgc.18.10.2017.campos solo considerados para desarrollo MTM.  
  , [TRANSACTION_OPTION_DESC]     = Estructura.Descripcion  
  --, [Valor_Nocional_pagado]      = convert(varchar,format( cadet.MontoNocionalPagado ,N'#0.########################'))  
  , [TRANSACTION_OPTION_CV]         = EnContrato.CaCVEstructura --'mgc.11.08.2017 Se agrega Columna  
  /* Nuevos Campos */  
  , pricing_mtm_itau        = case when Cadet.CaModalidad = 'C' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,CaDet.CaVrDet,CaDet.CaMdaCompensacion),N'#0.########################')) ELSE   
                         convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,CaDet.CaVrDet, CaDet.CaCodMon1),N'#0.########################')) END  
  , pricing_base_mtm_itau       = convert(varchar,format(CaDet.CaVrDet,N'#0.########################'))  
  , transaction_info_party_original    = clie.clrut  
  into #ODS_OPC
 from CbMdbOpc.dbo.CaEncContrato EnContrato with(NOLOCK)  
 left join  
     ( select ID     = OpcEstCod  
       , Descripcion   = OpcEstDsc  
       from CbMdbOpc.dbo.OpcionEstructura  
     ) Estructura On Estructura.ID = EnContrato.CaCodEstructura   
  
 Inner Join (Select CaNumContrato  
     , CaFechaInicioOpc  
     , CaModalidad  
     , CaStrike  
     , CaCVOpc  
     , CaCodMon1  
     , CaCodMon2  
     , CaMontoMon1  
     , CaFechaPagMon1  
     , CaFechaFijacion  
     , caFechaVcto  
     , CaNumEstructura   
     , CaVrDet   
     , CaPrimaInicialDetML    
     , CaMdaCompensacion   
     , CaFormaPagoMon1   
     , CaCallPut  
     , CaTipoOpc -->MGC.SE AGREGA CAMPO   
     --, MontoNocionalPagado = Round((CaMontoMon1 * CaStrike), 0)   
             From CbMdbOpc.dbo.CaDetContrato  
    )  CaDet On CaDet.CaNumContrato = EnContrato.CaNumContrato  
    --AND HisDet.MoFechaInicioOpc = @Fecha_Proceso  
 inner join ( Select clrut  
     , clcodigo  
     , cldv  
     , clnombre = substring(clnombre, 1,100)   
    from BacParamSuda.dbo.cliente with(nolock)  
   ) Clie On Clie.clrut  = EnContrato.CaRutCliente 
      and Clie.clcodigo = EnContrato.CaCodigo  
  
 left join (select CaNumContrato   
    ,   CaNumEstructura  
    ,   CaFijacion  
    ,   CaFixFecha      
   from CbMdbOpc.dbo.CaFixing with(nolock)   
   ) Fix on Fix.CaNumContrato   = EnContrato.CaNumContrato  
     and Fix.CaNumEstructura =  CaDet.CaNumEstructura  
     and fix.CaFixFecha   = (select fecha   = MAX(CaFixFecha)   
            from CbMdbOpc.dbo.CaFixing with(nolock)   
            where CaNumContrato  = EnContrato.CaNumContrato  
            and  CaNumEstructura =  CaDet.CaNumEstructura)  
  
  left join  
  ( select id = tbcodigo1  
    , Descripcion = tbglosa  
    from BacparamSuda.dbo.Tabla_general_detalle   
    where tbcateg = 1111  
  ) cNorma On cNorma.id = EnContrato.CaCarNormativa  
  
  left join  
  ( select id = tbcodigo1  
    , Descripcion = tbglosa  
    from BacparamSuda.dbo.Tabla_general_detalle   
    where tbcateg = 1554  
  ) cSubCar On cSubCar.id = EnContrato.CaSubCarNormativa  
  
Where CaDet.caFechaVcto <> @Fecha_Proceso and EnContrato.CaEstado <> 'C' --Se excluiyen las Cotizaciones  
  
 --actualizo tx_deal_num para conjunto de operaciones que si informaran el equivalente de crédito
 INSERT INTO @Contratos 
	SELECT  DISTINCT substring(transaction_deal_num,1,4) +'1' 
 FROM #ODS_OPC

--actualizo campos de equivalente de crédito en cero.
UPDATE #ODS_OPC  
SET equivalente_credito_corporativo=0, equivalente_credito_normativo=0,
	equivalente_credito_factor=0,equivalente_credito_factor_inter=0,
	equivalente_credito_factor_normativo=0
WHERE transaction_deal_num NOT in (SELECT numcontrato FROM @Contratos )
--listo resultados
SELECT * FROM #ODS_OPC 
--libero tabla temporal 
DROP TABLE #ODS_OPC
  
end  



GO
