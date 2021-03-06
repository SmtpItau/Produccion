USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUSION_REPORTE_ODS_FWD]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FUSION_REPORTE_ODS_FWD]
as 
BEGIN
	
DECLARE @Fecha_Proceso		DATETIME = NULL
DECLARE @Fecha_ProcesoAnt	DATETIME = NULL

 IF(@Fecha_Proceso IS NULL)
         BEGIN    
              SELECT    @Fecha_Proceso = M.acfecproc
						,@Fecha_ProcesoAnt = m.acfecante 
              FROM Bacfwdsuda.dbo.mfac M
         END  

SELECT DISTINCT 
 transaction_deal_num    = canumoper
,transaction_status_id	 = (CASE WHEN caestado = '' THEN '1' WHEN  caestado = 'N' THEN '2' end)
,transaction_trade_date  =  CASE WHEN cacodpos1=14 AND cacalvtadol = 14 THEN CONVERT(varchar(30), cafecha, 126)  ELSE  CONVERT(varchar(30), cafecha, 126) END
,transaction_start_date  =  CASE WHEN cacodpos1=14 AND cacalvtadol = 14 THEN CONVERT(varchar(30), CaFechaStarting, 126)  ELSE  CONVERT(varchar(30), cafecha, 126) END
,transaction_end_date	 =  CONVERT(varchar(30), cafecvcto, 126)   
,transaction_ET = CONVERT(varchar(30), FechaInicio, 126)
,transaction_modalidad_pago		=  case	when catipmoda = 'E' then 1 else 2 end 
,transaction_paymentconv_id = 1
,transaction_nemo = ''            -- No Aplica
,transaction_serie = ''			  -- No Aplica
,transaction_TIR_compra = 0       -- No Aplica
,transaction_TIR_mercado = 0      -- No Aplica
,transaction_strike = 0           -- No Aplica

,transaction_id_group = var_moneda2 --> 14-07-2017 -> Tag Relacion Arb Moneda Mx-Clp
/*
	select canumoper, var_moneda2, cacodpos1, cacodmon1, cacodmon2  from BacFwdsuda.dbo.mfca where var_moneda2 > 0 
	select * from Bacparamsuda.dbo.producto where id_sistema = 'bfw'
*/

,side_type =  CASE 
                    WHEN catipoper ='V' THEN '2'
                    WHEN catipoper ='C' THEN '1'
               END

--,side_type = 1

,side_fix_flt = 2
,side_frec_p = CONVERT(VARCHAR, caplazo) + 'd' 
,side_reset_p = '0d'                -- No Aplica

, side_notional  = convert(varchar,format(camtomon1,N'#0.########################'))

, side_notional_ccy_id  = dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon1))


, side_payment_ccy_id   = CASE WHEN catipoper ='V' THEN 

							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 13))  
																			  ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 999))   END

								ELSE		   
								CASE WHEN catipoper = 'V' THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon1))  
														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
								END
							END
							
						ELSE 
							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 13))  
																			  ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 999))   END

								ELSE		   
								CASE WHEN catipoper = 'C' THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon1))  
														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
								END
							END
						END
							



, side_rate =    catasa_efectiva_moneda1


, side_rate_spread = 0   -- No Aplica
, side_rate_type_id = 1 

, side_projection_index = CASE when cacodpos1=2 and var_moneda2<>0 
						  THEN 
												case when cacodmon1=142 and cacodmon2=13    then 'FX_EUR.CLP'
													 when cacodmon1=13	and cacodmon2=142	then 'FX_EUR.CLP'
													 when cacodmon1=102	and cacodmon2=13	then 'FX_GBP.CLP'
													 when cacodmon1=13	and cacodmon2=102	then 'FX_GBP.CLP'
													 when cacodmon1=36	and cacodmon2=13	then 'FX_AUD.CLP'
													 when cacodmon1=13	and cacodmon2=36	then 'FX_AUD.CLP'
													 when cacodmon1=72	and cacodmon2=13	then 'FX_JPY.CLP'
													 when cacodmon1=13	and cacodmon2=72	then 'FX_JPY.CLP'
													 when cacodmon1=82	and cacodmon2=13	then 'FX_CHF.CLP'
													 when cacodmon1=13	and cacodmon2=82	then 'FX_CHF.CLP'
													 when cacodmon1=113	and cacodmon2=13	then 'FX_SEK.CLP'
													 when cacodmon1=13	and cacodmon2=113	then 'FX_SEK.CLP'
													 when cacodmon1=51	and cacodmon2=13	then 'FX_DKK.CLP'
													 when cacodmon1=13	and cacodmon2=51	then 'FX_DKK.CLP'
													 when cacodmon1=96	and cacodmon2=13	then 'FX_NOK.CLP'
													 when cacodmon1=13	and cacodmon2=96	then 'FX_NOK.CLP'
													 when cacodmon1=48	and cacodmon2=13	then 'FX_CNY.CLP'
													 when cacodmon1=13	and cacodmon2=48	then 'FX_CNY.CLP'
													 when cacodmon1=132	and cacodmon2=13	then 'FX_MXN.CLP'
												     when cacodmon1=13	and cacodmon2=132	then 'FX_MXN.CLP'
													 when cacodmon1=6	and cacodmon2=13	then 'FX_CAD.CLP'
													 when cacodmon1=13	and cacodmon2=6		then 'FX_CAD.CLP'
													 when cacodmon1=5	and cacodmon2=13	then 'FX_BRL.CLP'
													 when cacodmon1=13	and cacodmon2=5		then 'FX_BRL.CLP'
													 when cacodmon1=24	and cacodmon2=13	then 'FX_PEN.CLP'
													 when cacodmon1=13	and cacodmon2=24	then 'FX_PEN.CLP'
													 when cacodmon1=129	and cacodmon2=13	then 'FX_USD.CLP'
													 when cacodmon1=13	and cacodmon2=129	then 'FX_USD.CLP'
												end	 
						ELSE	
								CASE WHEN cacodmon1 = 13 AND  cacodmon2 = 999  then 'FX_3M_USD.CLP'
									WHEN cacodmon1 = 13 AND  cacodmon2 = 5  then   'FX_3M_USD.BRL'
									WHEN cacodmon1 = 142 AND  cacodmon2 = 13  then   'FX_3M_EUR.USD'
									WHEN cacodmon1 = 13 AND  cacodmon2 = 72  then   'FX_3M_USD.JPY'
									WHEN cacodmon1 = 102 AND  cacodmon2 = 13  then   'FX_3M_GBP.USD'
									WHEN cacodmon1 = 13 AND  cacodmon2 = 6  then   'FX_3M_USD.CAD' 
									WHEN cacodmon1 = 129 AND  cacodmon2 = 13  then   'FX_3M_USD.COP' 
									WHEN cacodmon1 = 998 AND  cacodmon2 = 999  then   'FX_3M_UF.CLP' 
									WHEN cacodmon1 = 13 AND  cacodmon2 = 998  then   'FX_3M_USD.UF' 
									WHEN cacodmon1 = 72 AND  cacodmon2 = 13  then   'FX_3M_JPY.USD' 
									WHEN cacodmon1 = 132 AND  cacodmon2 = 13  then   'FX_3M_MXN.USD' 
									WHEN cacodmon1 = 6 AND  cacodmon2 = 13  then   'FX_3M_CAD.USD' 
									WHEN cacodmon1 = 5 AND  cacodmon2 = 13  then   'FX_3M_BRL.USD' 
									WHEN cacodmon1 = 36 AND  cacodmon2 = 13  then   'FX_3M_AUD.USD' 
									WHEN cacodmon1 = 113 AND  cacodmon2 = 13  then   'FX_3M_SEK.USD' 
									WHEN cacodmon1 = 999 AND  cacodmon2 = 999  then   'FX_3M_CLP.CLP' 
									WHEN cacodmon1 = 48 AND  cacodmon2 = 13  then   'FX_3M_CNY.USD' 
									WHEN cacodmon1 = 96 AND  cacodmon2 = 13  then   'FX_3M_NOK.USD' 
								END 
						END
,side_yield_basis_id = 0  -- No Aplica


,interest_id = 0           -- No Aplica
,interest_start_date = CASE WHEN cacodpos1=14 AND cacalvtadol = 14 THEN CONVERT(varchar(30), CaFechaStarting, 126)  ELSE  CONVERT(varchar(30), cafecha, 126) END   -- No Aplica
,interest_end_date = '1900-01-01T00:00:00'     -- No Aplica
,interest_payment_date = '1900-01-01T00:00:00' -- No Aplica

,interest_fixing_date = '1900-01-01T00:00:00'   -- No Aplica
, interest_fixing_rate = catipcam
,interest_accounting_date = '1900-01-01T00:00:00'  -- No Aplica


,interest_rate = 0  -- No Aplica

,interest_payment = 0  -- No Aplica

, interest_df = 0      -- No Aplica

,interest_npv = 0      -- No Aplica    
,cashflow_id = 0       -- No Aplica


,cashflowtype_id = 1
,cashflow_start_date = '1900-01-01T00:00:00'      -- No Aplica
,cashflow_end_date = '1900-01-01T00:00:00'        -- No Aplica
,cashflow_accounting_date = '1900-01-01T00:00:00'  -- No Aplica
,cashflow_fixing_date = '1900-01-01T00:00:00'      -- No Aplica
, cashflow_fixing_rate = 0     -- No Aplica
,cashflow_amount = 0           -- No Aplica
, cashflow_df = 0              -- No Aplica
--,cashflow_npv = convert(varchar,format((valorrazonableActivo) ,N'#0.########################'))

--,cashflow_npv 			= Case WHEN  catipmoda = 'C' THEN  
--								CASE WHEN (SELECT ClPais 
--											FROM   BacParamSuda.dbo.cliente Clie with(nolock)
--											Where  Clie.Clrut = cacodigo 
--											And clie.Clcodigo = cacodcli) <> 6 THEN  convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,13),N'#0.########################')) 
--																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,999),N'#0.########################'))   END

--								ELSE		   
--								CASE WHEN catipoper = 'C' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,cacodmon1),N'#0.########################')) 
--														  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,cacodmon1),N'#0.########################'))
--								END
--              			  END
              			  
              			  
              			  
  ,cashflow_npv 	= CASE WHEN catipoper ='V' THEN 

							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablepasivo*-1,13),N'#0.########################'))   
																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablepasivo*-1,999),N'#0.########################'))   END

								ELSE		   
									CASE WHEN catipoper = 'V' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablepasivo*-1,cacodmon1),N'#0.########################'))
														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
								END
							END
							
						ELSE 
							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN  convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,13),N'#0.########################')) 
																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,999),N'#0.########################'))   END

								ELSE		   
								CASE WHEN catipoper = 'C' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,cacodmon1),N'#0.########################')) 
														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
								END
							END
						END 
              			  
              			  
              			  
              			  
              			  
              			  
              			  


, facility_id = 2


, transaction_info_tc_costo  = CASE	WHEN cacodpos1 = 1  THEN capreciopunta --catipcam
WHEN cacodpos1 = 2  THEN convert(varchar,format(caparmon1,N'#0.########################')) --caparmon1 --capremon1
WHEN cacodpos1 = 3  THEN convert(varchar,format(catipcam,N'#0.########################'))-- catipcam
WHEN cacodpos1 = 13 THEN convert(varchar,format(catipcam,N'#0.########################'))--catipcam
ELSE 0
END


, transaction_info_tc_cliente  = CASE	WHEN cacodpos1 = 1  THEN convert(varchar,format(catipcam,N'#0.########################')) --catipcam --capreciopunta        
WHEN cacodpos1 = 2  THEN convert(varchar,format(catipcam,N'#0.########################'))--catipcam --capremon2        
WHEN cacodpos1 = 3  THEN capreciopunta        
WHEN cacodpos1 = 13 THEN capreciopunta
ELSE 0       
END

,   transaction_info_paridad_costo       = CASE	WHEN cacodpos1 = 1  THEN  capreciopunta--caparmon1
WHEN cacodpos1 = 2  THEN caparmon1
WHEN cacodpos1 = 3  THEN catipcam --0.0
WHEN cacodpos1 = 13 THEN catipcam--0.0
ELSE 0
END

,   transaction_info_paridad_cliente        = CASE	WHEN cacodpos1 = 1  THEN catipcam
WHEN cacodpos1 = 2  THEN catipcam--caparmon1
WHEN cacodpos1 = 3  THEN capreciopunta--0.0
WHEN cacodpos1 = 13 THEN capreciopunta--0.0
ELSE 0
END


,transaction_info_spread_tc =  
Case  When (convert(varchar,format(caspread,N'#0.########################')))='' then '0'
else
convert(varchar,format(caspread,N'#0.########################')) 
end

,transaction_info_spread_paridad = caparmon2
,transaction_info_fx_spot_cliente = convert(varchar,format(catipcamSpot,N'#0.########################'))
,transaction_info_fx_fwd_costo = CASE	WHEN cacodpos1 = 1  THEN capreciopunta --catipcam
									WHEN cacodpos1 = 2  THEN convert(varchar,format(caparmon1,N'#0.########################')) --caparmon1 --capremon1
									WHEN cacodpos1 = 3  THEN convert(varchar,format(catipcam,N'#0.########################'))-- catipcam
									WHEN cacodpos1 = 13 THEN convert(varchar,format(catipcam,N'#0.########################'))--catipcam
									ELSE 0
									END

--,transaction_info_fx_fwd_costo =CASE	WHEN cacodpos1 = 2 then convert(varchar,format(catipcam,N'#0.########################'))ELSE (case when isnull(capreciopunta,0)=0 then '0' else convert(varchar,format(capreciopunta,N'#0.########################')) end)END 
,transaction_info_fx_fwd_cliente = convert(varchar,format(catipcam,N'#0.########################'))
,transaction_info_puntos_fwd = convert(varchar,format(abs(catipcam - case when isnull(catipcamSpot,0)=0 then '0' else catipcamSpot END),N'#0.########################'))--convert(varchar,format(catipcamPtosFwd,N'#0.########################'))

,transaction_info_fx_uf_spot =     Case  When (CACODPOS1 = 1 And CACODMON2 =998 ) then 
                                             convert(varchar,format(capremon2,N'#0.########################')) 
                                               else '0' End

,transaction_info_fx_uf_tasa_costo = 0   -- Falta
,transaction_info_fx_uf_tasa_margen = 0   -- Falta
,transaction_info_fx_uf_tasa_cliente = 0  -- Falta
,transaction_info_fx_spot_margen = 0 --Falta

,transaction_info_fx_fwd_margen = (case when isnull(resultado_mesa,0)='0' or resultado_mesa='' then '0' else convert(varchar,format(Resultado_Mesa,N'#0.########################')) end)

,transaction_info_fx_uf_tasa_sucia_costo = 0 -- Falta
,transaction_info_fx_uf_tasa_sucia_cliente = 0 -- Falta





,equivalente_credito_corporativo = 0       -- No Aplica
,equivalente_credito_normativo =  0        -- No Aplica
,equivalente_credito_factor = 0            -- No Aplica
,equivalente_credito_factor_inter = 0      -- No Aplica
,equivalente_credito_factor_normativo = 0  -- No Aplica



,medio_transaccional_id = dbo.fx_MedioTransaccional_ID(BacParamSuda.dbo.fx_mesa_operador_ID(caoperador))
,canal_transaccional_id =   Case WHEN dbo.Fx_Valida_OperacionComder_ODS(canumoper)  <> 0 
							THEN 
							7
							ELSE
							BacParamSuda.dbo.fx_mesa_operador_ID(caoperador)
							END



,profit_value= 
(CASE 
	WHEN (
CASE WHEN cacodpos1 = 2 THEN convert(varchar,format(ROUND(Resultado_Mesa * capremon1, 0),N'#0.########################'))
ELSE convert(varchar,format(Resultado_Mesa,N'#0.########################')) END
) = '' THEN '0'
ELSE
(CASE WHEN cacodpos1 = 2 THEN convert(varchar,format(ROUND(Resultado_Mesa * capremon1, 0),N'#0.########################'))
ELSE convert(varchar,format(Resultado_Mesa,N'#0.########################')) END)
END)



, profit_ccy_id  = dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon1))


, profit_mesa_clientes_clp = 0 -- No Aplica
, profit_mesa_trading_clp = 0 --No Aplica

,portfolio_id = cacodcart


,instrument_id = case when cacodpos1 =1 THEN '1000001'
   WHEN cacodpos1=14 AND cacalvtadol = 14 THEN  '1000002'
   WHEN cacodpos1 =14 AND cacalvtadol = 16	THEN	'1000002'
   when cacodpos1 =10 THEN '1000001'
   when cacodpos1 =11 THEN '1000001'
   when cacodpos1 = 2 THEN '1000001'
   when cacodpos1 = 3 THEN '1000001'
   ELSE '00000' End


,product_id = 1


,party_id = clie.clrut
,party_rut = CONVERT(VARCHAR, clie.clrut) + '-' + RTRIM(LTRIM(CONVERT(VARCHAR, Clie.cldv)))

, party_secuencia = DBO.Fx_Tipo_Contraparte_ODS (clie.clrut, clie.clcodigo)

--, pricing_mtm  = convert(varchar,format(BacParamSuda.dbo.fx_convierte_monto_25(@Fecha_Proceso,999,valorrazonableActivo,cacodmon1),N'#0.########################')) 

--, pricing_mtm  = convert(varchar,format(CASE WHEN cacodmon1 = 999  then valorrazonableActivo  WHEN  cacodmon1=998 THEN valorrazonableActivo /(select vmvalor FROM bacparamsuda.dbo.valor_moneda WHERE vmfecha = @Fecha_Proceso AND vmcodigo = cacodmon1)
-- else  (valorrazonableActivo /(select Tipo_cambio FROM bacparamsuda.dbo.valor_moneda_contable WHERE Fecha = @Fecha_Proceso AND Codigo_Moneda = case when cacodmon1 = 13 THEN 994 ELSE cacodmon1  END ))END,N'#0.########################')) 


--,pricing_mtm  = convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,cacodmon1),N'#0.########################'))


--,pricing_mtm  = Case WHEN  catipmoda = 'C' THEN  
--								CASE WHEN (SELECT ClPais 
--											FROM   BacParamSuda.dbo.cliente Clie with(nolock)
--											Where  Clie.Clrut = cacodigo 
--											And clie.Clcodigo = cacodcli) <> 6 THEN  convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,13),N'#0.########################')) 
--																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,999),N'#0.########################'))   END

--								ELSE		   
--								CASE WHEN catipoper = 'C' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,cacodmon1),N'#0.########################')) 
--														  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,cacodmon2),N'#0.########################'))
--								END
--                END


,pricing_mtm  = CASE WHEN catipoper ='V' THEN 

							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablepasivo*-1,13),N'#0.########################'))   
																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablepasivo*-1,999),N'#0.########################'))   END

								ELSE		   
											CASE WHEN catipoper = 'V' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablepasivo*-1,cacodmon1),N'#0.########################'))
														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
								END
							END
							
						ELSE 
							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN  convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,13),N'#0.########################')) 
																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,999),N'#0.########################'))   END

								ELSE		   
								CASE WHEN catipoper = 'C' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,cacodmon1),N'#0.########################')) 
														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
								END
								END
                END



 ,pricing_mtm_ccy_id      = CASE WHEN catipoper ='V' THEN 

							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 13))  
																			  ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 999))   END

								ELSE		   
								CASE WHEN catipoper = 'V' THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon1))  
														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
								END
							END
							
						ELSE 
							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 13))  
																			  ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 999))   END

								ELSE		   
								CASE WHEN catipoper = 'C' THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon1))  
														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
								END
							END
						END



--,pricing_mtm_ccy_id   = Case WHEN  catipmoda = 'C' THEN  
--								CASE WHEN (SELECT ClPais 
--											FROM   BacParamSuda.dbo.cliente Clie with(nolock)
--											Where  Clie.Clrut = cacodigo 
--											And clie.Clcodigo = cacodcli) <> 6 THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 13))  
--																			  ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 999))   END

--								ELSE		   
--								CASE WHEN catipoper = 'C' THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon1))  
--														 -- ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
--								END
			--end



--, pricing_base_mtm = convert(varchar,format((valorrazonableActivo) ,N'#0.########################'))

 , pricing_base_mtm =	CASE 
						WHEN catipoper ='V' THEN convert(varchar,format((valorrazonablepasivo *-1  ) ,N'#0.########################'))
						WHEN catipoper ='C' THEN convert(varchar,format((valorrazonableActivo) ,N'#0.########################'))
						END

--, pricing_base_mtm = convert(varchar,format((valorrazonableActivo) ,N'#0.########################'))
	


,pricing_pnl = 0      -- Falta
,pricing_pnl_fx_unrealized = 0 -- Falta



,pricing_delta = 
(case 
	when isnull(cadelta,0)=0 or cadelta='' then '0'
	else convert(varchar,format(CaDelta,N'#0.########################'))
end)

,pricing_gamma = 0            --No Aplica
,pricing_vega = 0			  --No Aplica
, pricing_beta = 0		      --No Aplica
,pricing_rho_local = 0        --No Aplica
,pricing_rho_foranea = 0      --No Aplica

,pricing_theta = 0            --No Aplica
,pricing_volga = 0            --No Aplica

,side_id =  CASE	WHEN cacodmon1 <> 13 AND  cacodmon2 = 13  then 1 
					WHEN cacodmon1 = 13 AND  cacodmon2 = 999  then 1  
					WHEN cacodmon1 = 13 AND  cacodmon2 = 998  then 1 
					WHEN cacodmon1 = 998 AND  cacodmon2 = 13  then 1 ELSE 1 END

,call_put_id									= 0

,CASE WHEN catipoper = 'V' then  3 WHEN catipoper ='C' THEN 1 END AS Orden

--campos nuevos
,	[transaction_emisor_id]						='' 
,	[transaction_plazo_pacto]					=0 
,	[transaction_tasa_costo_pacto]				=0 
,	[transaction_tasa_pacto]					=0 
,	[transaction_tir_compra_origen]				=0 
,	[transaction_tir_compra_ppa]				=0 
,	[transaction_dev_tir_compra]				=0 
,	[transaction_tipo_operacion_id]				=0
,	[transaction_fecha_compra_ins]				='1900-01-01T00:00:00'
,	[transaction_fecha_cupon]					='1900-01-01T00:00:00'
-------------------------------------------------------------------------------------------------------------
,	[Cuenta_GL]							= FwdCuentas.Cta
,	[Cuenta_SBIF]						= '0'
,	[cashflow_amount_add]				= '0'
,	[portfolio_super]					= ltrim(rtrim( substring(isnull(FwdCuentas.Id_Descripcion, ''), 1,250) ))
,	[portfolio_scn]						= ltrim(rtrim( substring(isnull(FwdCuentas.Id_Descrip_SCN, ''), 1,250)))
-------------------------------------------------------------------------------------------------------------
,	[side_discount_index]				= dbo.fx_leer_curva_forward(cacodpos1, cacodmon1,isnull(o.cod_colateral,''))
,	[interest_rate_icp]					= '0'


,	[TRANSACTION_OPTION_DESC]			= ''
--,	[Valor_Nocional_pagado]				= '0'
,	[TRANSACTION_OPTION_CV]				= '' --mgc.11.08.2017 Se agrega Columna
/* Nuevos Campos */
,pricing_mtm_itau  = CASE WHEN catipoper ='V' THEN 

							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablepasivo*-1,13),N'#0.########################'))   
																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablepasivo*-1,999),N'#0.########################'))   END

								ELSE		   
											CASE WHEN catipoper = 'V' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablepasivo*-1,cacodmon1),N'#0.########################'))
								END
							END
							
						ELSE 
							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN  convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,13),N'#0.########################')) 
																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,999),N'#0.########################'))   END

								ELSE		   
								CASE WHEN catipoper = 'C' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,cacodmon1),N'#0.########################')) 
								END
								END
                END
 , pricing_base_mtm_itau =	CASE 
						WHEN catipoper ='V' THEN convert(varchar,format((valorrazonablepasivo *-1  ) ,N'#0.########################'))
						WHEN catipoper ='C' THEN convert(varchar,format((valorrazonableActivo) ,N'#0.########################'))
						END
 , transaction_info_party_original = clie.clrut
--fmo 20190704 agregar IDD
-- , transaction_info_codigo_idd = ISNULL(nNumeroIdd,0)
--fmo 20190704 agregar IDD
from Bacfwdsuda.dbo.mfca with(nolock)
LEFT JOIN BacParamSuda..OPE_COLATERAL o ON o.id_sistema='FWD' and o.rut_cliente=cacodigo and o.cod_cliente=cacodcli and o.numero_operacion=canumoper
inner join	

(	select	codigo_producto, descripcion 

from	BacParamSuda.dbo.Producto with(nolock)

where	Id_Sistema = 'BFW'

)	Prod	On Prod.codigo_producto = cacodpos1


inner join 

(	select	clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100), PaisCliente = clpais 

from	BacParamSuda.dbo.cliente with(nolock)

)	Clie	On	Clie.clrut		=cacodigo

and Clie.clcodigo	= cacodcli

INNER JOIN
(	select	distinct 
			Folio			= FwdCtaSbif.Id_Folio
		,	Id_Descripcion	= FwdCtaSbif.Id_Descripcion
		,	Id_Descrip_SCN	= FwdCtaSbif.Id_Descrip_SCN
		,	Cta				= Reportes.dbo.fx_leer_cuentas_sbif_ima	
							(	FwdCtaSbif.Id_sistema
							,	FwdCtaSbif.Id_Movimiento
							,	FwdCtaSbif.Id_Operacion
							,	FwdCtaSbif.Id_Instrumento
							,	FwdCtaSbif.Id_Moneda
							,	FwdCtaSbif.Id_Pata
							,	FwdCtaSbif.id_signo
							,	FwdCtaSbif.Id_Pais
							,	FwdCtaSbif.Id_Normativa
							,	FwdCtaSbif.Id_Subcartera
							,	FwdCtaSbif.Id_Visualizar
							)
	from 
	(	select	distinct 
				Id_Folio		= car.canumoper
			,	Id_sistema		= 'BFW'
			,	Id_Movimiento	= 'DEV'
			,	Id_Operacion	= case	when car.cacodpos1 = 10 then ltrim(rtrim( car.cacodpos1 )) + ltrim(rtrim( car.catipoper ))
										when car.cacodpos1 = 11 then ltrim(rtrim( car.cacodpos1 )) + ltrim(rtrim( car.catipoper ))
										else 'D' + ltrim(rtrim( car.cacodpos1 )) + ltrim(rtrim( car.catipoper ))
		 	            			end
			,	Id_Instrumento	= case	when car.cacodpos1 = 10 then car.cacodmon1
										else car.cacodmon2
		 	              			end
			,	Id_Moneda		= case	when car.cacodpos1 = 2 then ltrim(rtrim( car.cacodmon1 ))
										else ''
		 	         				end
			,	Id_Pata			= 1
			,	id_signo		= case when car.fres_obtenido >= 0 then '+' else '-' end
			,	Id_Pais			= cli.clpais
			,	Id_Normativa	= car.cacartera_normativa
			,	Id_Subcartera	= car.casubcartera_normativa
			,	Id_Visualizar	= 1
			,	Id_Descripcion	= isnull(cNorma.Descripcion, '')
			,	Id_Descrip_SCN	= isnull(cSubNor.Descripcion, '')
		from	BacfwdSuda.dbo.mfca car with(nolock)
	 			inner join
	 			(	select	clrut, clcodigo, clpais = case when clpais = 6 then 2 else 1 end 
	 				from	Bacparamsuda.dbo.cliente with(nolock)
	 			)	cli		On	cli.clrut		= car.cacodigo
	 						and	cli.clcodigo	= car.cacodcli
				left join
				(	select	Id			= tbcodigo1
						,	Descripcion	= tbglosa
				 	from	BacParamSuda.dbo.Tabla_General_Detalle with(nolock)
				 	where	tbcateg		= 1111
				)	cNorma	On cNorma.Id=car.cacartera_normativa
				left join
				(	select	Id				= tbcodigo1
						,	Descripcion		= tbglosa
				 	from	BacParamSuda.dbo.Tabla_General_Detalle with(nolock)
				 	where	tbcateg			= 1554
				)	cSubNor	On cSubNor.Id	= car.casubcartera_normativa

				inner join	
				(	select	codigo_producto, descripcion
					from	BacParamSuda.dbo.Producto with(nolock)
					where	Id_Sistema = 'BFW'
				)	Prod	On Prod.codigo_producto = cacodpos1
	 	where	caestado  <> 'A'
		and		caestado  <> 'P'
		and		cafecvcto <> @Fecha_Proceso 
--		and		cacodpos1 <> 10  -- Eliminacion Fwd Bnd Trd

	)	FwdCtaSbif
)	FwdCuentas		On FwdCuentas.Folio	= canumoper
--fmo 20190704 agregar IDD
left join baclineas.dbo.transacciones_idd with(nolock) on cModulo='BFW' and nOperacion=canumoper
--fmo 20190704 agregar IDD

where LTRIM(RTRIM(caestado)) <> 'A'
 --and    not    (var_moneda2  <> 0 and cacodpos1 = 1)
 and	LTRIM(RTRIM(caestado)) <> 'P'
 and	cafecvcto <> @Fecha_Proceso 
-- AND    cacodpos1 <> 10 -- Eliminacion Fwd Bnd Trd


--=======================================================================================================================================
--=======================================================================================================================================
UNION
 

 SELECT distinct 
  transaction_deal_num    = canumoper
, transaction_status_id = (CASE WHEN caestado = '' THEN 1 WHEN  caestado = 'N' THEN '2' end)
, transaction_trade_date   =	CASE WHEN cacodpos1=14 AND cacalvtadol = 14 THEN CONVERT(varchar(30), cafecha, 126)  ELSE  CONVERT(varchar(30), cafecha, 126) END
, transaction_start_date   =	CASE WHEN cacodpos1=14 AND cacalvtadol = 14 THEN CONVERT(varchar(30), CaFechaStarting, 126)  ELSE  CONVERT(varchar(30), cafecha, 126) END 
, transaction_end_date	= CONVERT(varchar(30), cafecvcto, 126)   
, transaction_ET = CONVERT(varchar(30), FechaInicio, 126)
, transaction_modalidad_pago =  case when catipmoda = 'E' then 1 
else 2 end 

,transaction_paymentconv_id = 1
,transaction_nemo = ''            -- No Aplica
,transaction_serie = ''			  -- No Aplica
,transaction_TIR_compra = 0       -- No Aplica
,transaction_TIR_mercado = 0      -- No Aplica
,transaction_strike = 0           -- No Aplica
,transaction_id_group = var_moneda2 --> 14-07-2017 -> Tag Relacion Arb Moneda Mx-Clp
  ,side_type = CASE 
                 WHEN catipoper ='C' THEN '2'
                    WHEN catipoper ='V' THEN '1'
                    END
  

,side_fix_flt = 2
,side_frec_p = CONVERT(VARCHAR, caplazo) + 'd' 
,side_reset_p = '0d'                -- No Aplica

, side_notional  = convert(varchar,format(camtomon2,N'#0.########################'))



, side_notional_ccy_id  = dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))


, side_payment_ccy_id  = CASE WHEN catipoper ='V' THEN 

							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 13))  
																			  ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 999))   END

								ELSE		   
								CASE WHEN catipoper = 'V' THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))  
														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
								END
							END
							
						ELSE 
							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 13))  
																			  ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 999))   END

								ELSE		   
								CASE WHEN catipoper = 'C' THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))  
														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
								END
							END
						END



--, side_payment_ccy_id   = Case WHEN  catipmoda = 'C' THEN  
--								CASE WHEN (SELECT ClPais 
--											FROM   BacParamSuda.dbo.cliente Clie with(nolock)
--											Where  Clie.Clrut = cacodigo 
--											And clie.Clcodigo = cacodcli) <> 6 THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 13))  
--																			  ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 999))   END

--									ELSE		   
--								CASE WHEN catipoper = 'V' THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon1))  
--														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon1))
--								END
--							END

--, side_payment_ccy_id   = dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))

, side_rate =  catasa_efectiva_moneda2


, side_rate_spread = 0   -- No Aplica
, side_rate_type_id = 1 

, side_projection_index = CASE when cacodpos1=2 and var_moneda2<>0 
						  THEN 
												case when cacodmon1=142 and cacodmon2=13    then 'FX_EUR.CLP'
													 when cacodmon1=13	and cacodmon2=142	then 'FX_EUR.CLP'
													 when cacodmon1=102	and cacodmon2=13	then 'FX_GBP.CLP'
													 when cacodmon1=13	and cacodmon2=102	then 'FX_GBP.CLP'
													 when cacodmon1=36	and cacodmon2=13	then 'FX_AUD.CLP'
													 when cacodmon1=13	and cacodmon2=36	then 'FX_AUD.CLP'
													 when cacodmon1=72	and cacodmon2=13	then 'FX_JPY.CLP'
													 when cacodmon1=13	and cacodmon2=72	then 'FX_JPY.CLP'
													 when cacodmon1=82	and cacodmon2=13	then 'FX_CHF.CLP'
													 when cacodmon1=13	and cacodmon2=82	then 'FX_CHF.CLP'
													 when cacodmon1=113	and cacodmon2=13	then 'FX_SEK.CLP'
													 when cacodmon1=13	and cacodmon2=113	then 'FX_SEK.CLP'
													 when cacodmon1=51	and cacodmon2=13	then 'FX_DKK.CLP'
													 when cacodmon1=13	and cacodmon2=51	then 'FX_DKK.CLP'
													 when cacodmon1=96	and cacodmon2=13	then 'FX_NOK.CLP'
													 when cacodmon1=13	and cacodmon2=96	then 'FX_NOK.CLP'
													 when cacodmon1=48	and cacodmon2=13	then 'FX_CNY.CLP'
													 when cacodmon1=13	and cacodmon2=48	then 'FX_CNY.CLP'
													 when cacodmon1=132	and cacodmon2=13	then 'FX_MXN.CLP'
												     when cacodmon1=13	and cacodmon2=132	then 'FX_MXN.CLP'
													 when cacodmon1=6	and cacodmon2=13	then 'FX_CAD.CLP'
													 when cacodmon1=13	and cacodmon2=6		then 'FX_CAD.CLP'
													 when cacodmon1=5	and cacodmon2=13	then 'FX_BRL.CLP'
													 when cacodmon1=13	and cacodmon2=5		then 'FX_BRL.CLP'
													 when cacodmon1=24	and cacodmon2=13	then 'FX_PEN.CLP'
													 when cacodmon1=13	and cacodmon2=24	then 'FX_PEN.CLP'
													 when cacodmon1=129	and cacodmon2=13	then 'FX_USD.CLP'
													 when cacodmon1=13	and cacodmon2=129	then 'FX_USD.CLP'
												end	 
						ELSE	
								CASE WHEN cacodmon1 = 13 AND  cacodmon2 = 999  then 'FX_3M_USD.CLP'
									WHEN cacodmon1 = 13 AND  cacodmon2 = 5  then   'FX_3M_USD.BRL'
									WHEN cacodmon1 = 142 AND  cacodmon2 = 13  then   'FX_3M_EUR.USD'
									WHEN cacodmon1 = 13 AND  cacodmon2 = 72  then   'FX_3M_USD.JPY'
									WHEN cacodmon1 = 102 AND  cacodmon2 = 13  then   'FX_3M_GBP.USD'
									WHEN cacodmon1 = 13 AND  cacodmon2 = 6  then   'FX_3M_USD.CAD' 
									WHEN cacodmon1 = 129 AND  cacodmon2 = 13  then   'FX_3M_USD.COP' 
									WHEN cacodmon1 = 998 AND  cacodmon2 = 999  then   'FX_3M_UF.CLP' 
									WHEN cacodmon1 = 13 AND  cacodmon2 = 998  then   'FX_3M_USD.UF' 
									WHEN cacodmon1 = 72 AND  cacodmon2 = 13  then   'FX_3M_JPY.USD' 
									WHEN cacodmon1 = 132 AND  cacodmon2 = 13  then   'FX_3M_MXN.USD' 
									WHEN cacodmon1 = 6 AND  cacodmon2 = 13  then   'FX_3M_CAD.USD' 
									WHEN cacodmon1 = 5 AND  cacodmon2 = 13  then   'FX_3M_BRL.USD' 
									WHEN cacodmon1 = 36 AND  cacodmon2 = 13  then   'FX_3M_AUD.USD' 
									WHEN cacodmon1 = 113 AND  cacodmon2 = 13  then   'FX_3M_SEK.USD' 
									WHEN cacodmon1 = 999 AND  cacodmon2 = 999  then   'FX_3M_CLP.CLP' 
									WHEN cacodmon1 = 48 AND  cacodmon2 = 13  then   'FX_3M_CNY.USD' 
									WHEN cacodmon1 = 96 AND  cacodmon2 = 13  then   'FX_3M_NOK.USD' 
							   END 
						END

,side_yield_basis_id = 0  -- No Aplica


,interest_id = 0           -- No Aplica
,interest_start_date = CASE WHEN cacodpos1=14 AND cacalvtadol = 14 THEN CONVERT(varchar(30), CaFechaStarting, 126)  ELSE  CONVERT(varchar(30), cafecha, 126) END  -- No Aplica
,interest_end_date = '1900-01-01T00:00:00'     -- No Aplica
,interest_payment_date = '1900-01-01T00:00:00' -- No Aplica

,interest_fixing_date = '1900-01-01T00:00:00'   -- No Aplica
,interest_fixing_rate = catipcam
,interest_accounting_date = '1900-01-01T00:00:00'  -- No Aplica

--,interest_rate =  case when var_moneda2 <> 0 then segcam.TasaEfectiva1_SegCambio 
--else catasa_efectiva_moneda1 end 

,interest_rate = 0  -- No Aplica

,interest_payment = 0  -- No Aplica

, interest_df = 0      -- No Aplica

,interest_npv = 0      -- No Aplica    
,cashflow_id = 0       -- No Aplica


,cashflowtype_id = 1
,cashflow_start_date = '1900-01-01T00:00:00'      -- No Aplica
,cashflow_end_date = '1900-01-01T00:00:00'        -- No Aplica
,cashflow_accounting_date = '1900-01-01T00:00:00'  -- No Aplica
,cashflow_fixing_date = '1900-01-01T00:00:00'      -- No Aplica
, cashflow_fixing_rate = 0     -- No Aplica
,cashflow_amount = 0           -- No Aplica
, cashflow_df = 0              -- No Aplica
--,cashflow_npv = convert(varchar,format((valorrazonablePasivo)*-1 ,N'#0.########################'))

--,cashflow_npv = Case WHEN  catipmoda = 'C' THEN  
--								CASE WHEN (SELECT ClPais 
--											FROM   BacParamSuda.dbo.cliente Clie with(nolock)
--											Where  Clie.Clrut = cacodigo 
--											And clie.Clcodigo = cacodcli) <> 6 THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo *-1,13),N'#0.########################')) 
--																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo *-1,999),N'#0.########################'))   END

--									ELSE		   
--								CASE WHEN catipoper = 'C' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo *-1,cacodmon2),N'#0.########################'))  
--														  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo *-1,cacodmon2),N'#0.########################'))
--								END
--                END




,cashflow_npv =  CASE WHEN catipoper ='V' THEN 

							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,13),N'#0.########################'))  
																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,999),N'#0.########################'))   END

								ELSE		   
								CASE WHEN catipoper = 'V' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo ,cacodmon2),N'#0.########################')) 
														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
								END
							END
							
						ELSE 
							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo *-1,13),N'#0.########################')) 
																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo *-1,999),N'#0.########################'))   END

									ELSE		   
								CASE WHEN catipoper = 'C' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo *-1,cacodmon2),N'#0.########################'))  
														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
								END
								END
                END

, facility_id = 2


, transaction_info_tc_costo  = CASE	WHEN cacodpos1 = 1  THEN capreciopunta  --catipcam
WHEN cacodpos1 = 2  THEN caparmon1  --capremon1
WHEN cacodpos1 = 3  THEN catipcam
WHEN cacodpos1 = 13 THEN catipcam
ELSE 0
END

, transaction_info_tc_cliente  = CASE	WHEN cacodpos1 = 1  THEN catipcam  --capreciopunta        
WHEN cacodpos1 = 2  THEN catipcam --capremon2        
WHEN cacodpos1 = 3  THEN capreciopunta        
WHEN cacodpos1 = 13 THEN capreciopunta
ELSE 0       
END

,transaction_info_paridad_costo   = CASE	WHEN cacodpos1 = 1  THEN  capreciopunta--caparmon1
WHEN cacodpos1 = 2  THEN caparmon1
WHEN cacodpos1 = 3  THEN catipcam --0.0
WHEN cacodpos1 = 13 THEN catipcam--0.0
ELSE 0
END

,   transaction_info_paridad_cliente        = CASE	WHEN cacodpos1 = 1  THEN catipcam
WHEN cacodpos1 = 2  THEN catipcam--caparmon1
WHEN cacodpos1 = 3  THEN capreciopunta--0.0
WHEN cacodpos1 = 13 THEN capreciopunta--0.0
ELSE 0
END



,transaction_info_spread_tc =  
Case  When (convert(varchar,format(caspread,N'#0.########################')))='' then '0'
else
convert(varchar,format(caspread,N'#0.########################')) 
end


, transaction_info_spread_paridad =caparmon2


,transaction_info_fx_spot_cliente = convert(varchar,format(catipcamSpot,N'#0.########################'))
--,transaction_info_fx_fwd_costo = CASE	WHEN cacodpos1 = 2 then convert(varchar,format(catipcam,N'#0.########################'))ELSE (case when isnull(capreciopunta,0)=0 then '0' else convert(varchar,format(capreciopunta,N'#0.########################')) end)END --(case when isnull(capreciopunta,0)=0 then '0' else convert(varchar,format(capreciopunta,N'#0.########################')) end)
,transaction_info_fx_fwd_costo = CASE	WHEN cacodpos1 = 1  THEN capreciopunta --catipcam
									WHEN cacodpos1 = 2  THEN convert(varchar,format(caparmon1,N'#0.########################')) --caparmon1 --capremon1
									WHEN cacodpos1 = 3  THEN convert(varchar,format(catipcam,N'#0.########################'))-- catipcam
									WHEN cacodpos1 = 13 THEN convert(varchar,format(catipcam,N'#0.########################'))--catipcam
									ELSE 0
									END

,transaction_info_fx_fwd_cliente = convert(varchar,format(catipcam,N'#0.########################'))
,transaction_info_puntos_fwd = convert(varchar,format(abs(catipcam - case when isnull(catipcamSpot,0)=0 then '0' else catipcamSpot END),N'#0.########################'))
,transaction_info_fx_uf_spot = 	Case  When (CACODPOS1 = 1 And CACODMON2 =998 ) then 
							    convert(varchar,format(catipcamSpot,N'#0.########################')) 
								else '0' End
,transaction_info_fx_uf_tasa_costo = 0   -- Falta
,transaction_info_fx_uf_tasa_margen = 0   -- Falta
,transaction_info_fx_uf_tasa_cliente = 0  -- Falta
,transaction_info_fx_spot_margen = 0 --Falta

,transaction_info_fx_fwd_margen = (case when isnull(resultado_mesa,0)='0' or resultado_mesa='' then '0' else convert(varchar,format(Resultado_Mesa,N'#0.########################')) end)

,transaction_info_fx_uf_tasa_sucia_costo = 0 -- Falta
,transaction_info_fx_uf_tasa_sucia_cliente = 0 -- Falta





,equivalente_credito_corporativo = 0       -- No Aplica
,equivalente_credito_normativo =  0        -- No Aplica
,equivalente_credito_factor = 0            -- No Aplica
,equivalente_credito_factor_inter = 0      -- No Aplica
,equivalente_credito_factor_normativo = 0  -- No Aplica



,medio_transaccional_id = dbo.fx_MedioTransaccional_ID(BacParamSuda.dbo.fx_mesa_operador_ID(caoperador))
,canal_transaccional_id =   Case WHEN dbo.Fx_Valida_OperacionComder_ODS(canumoper)  <> 0 
							THEN 
							7
							ELSE
							BacParamSuda.dbo.fx_mesa_operador_ID(caoperador)
							END

,profit_value= 
(CASE 
	WHEN (
CASE WHEN cacodpos1 = 2 THEN convert(varchar,format(ROUND(Resultado_Mesa * capremon1, 0),N'#0.########################'))
ELSE convert(varchar,format(Resultado_Mesa,N'#0.########################')) END
) = '' THEN '0'
ELSE
(CASE WHEN cacodpos1 = 2 THEN convert(varchar,format(ROUND(Resultado_Mesa * capremon1, 0),N'#0.########################'))
ELSE convert(varchar,format(Resultado_Mesa,N'#0.########################')) END)
END)



, profit_ccy_id  = dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))


, profit_mesa_clientes_clp = 0 -- No Aplica
, profit_mesa_trading_clp = 0 --No Aplica

,portfolio_id = cacodcart


,instrument_id = case when cacodpos1 =1 THEN '1000001'
   WHEN cacodpos1=14 AND cacalvtadol = 14 THEN  '1000002'
   WHEN cacodpos1 =14 AND cacalvtadol = 16 THEN  '1000002'
   when cacodpos1 =10 THEN '1000001'
   WHEN cacodpos1 =11 THEN '1000001'
   when cacodpos1 = 2 THEN '1000001'
   when cacodpos1 = 3 THEN '1000001'
   ELSE '00000' End


,product_id = 1


,party_id = clie.clrut
,party_rut = CONVERT(VARCHAR, clie.clrut) + '-' + RTRIM(LTRIM(CONVERT(VARCHAR, Clie.cldv)))

, party_secuencia = DBO.Fx_Tipo_Contraparte_ODS (clie.clrut, clie.clcodigo)


--,pricing_mtm = convert(varchar,format(CASE WHEN cacodmon2 = 999 THEN valorrazonablePasivo *-1 WHEN cacodmon2 = 998 THEN valorrazonableActivo*-1 /(select vmvalor FROM bacparamsuda.dbo.valor_moneda WHERE vmfecha = @Fecha_Proceso AND vmcodigo = cacodmon2)



--else(valorrazonablePasivo/(select Tipo_cambio FROM bacparamsuda.dbo.valor_moneda_contable WHERE Fecha = @Fecha_Proceso AND Codigo_Moneda = case when cacodmon2 = 13 THEN 994 ELSE cacodmon2  END ))*-1 END ,N'#0.########################'))  


--,pricing_mtm  = convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo *-1,cacodmon2),N'#0.########################'))
			

--,pricing_mtm  = Case WHEN  catipmoda = 'C' THEN  
--								CASE WHEN (SELECT ClPais 
--											FROM   BacParamSuda.dbo.cliente Clie with(nolock)
--											Where  Clie.Clrut = cacodigo 
--											And clie.Clcodigo = cacodcli) <> 6 THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo *-1,13),N'#0.########################')) 
--																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo *-1,999),N'#0.########################'))   END

--									ELSE		   
--								CASE WHEN catipoper = 'C' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo *-1,cacodmon2),N'#0.########################'))  
--														  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo *-1,cacodmon1),N'#0.########################'))
--								END
--                END
                
                
 ,pricing_mtm  = CASE WHEN catipoper ='V' THEN 

							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,13),N'#0.########################'))  
																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo ,999),N'#0.########################'))   END

								ELSE		   
								CASE WHEN catipoper = 'V' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,cacodmon2),N'#0.########################')) 
														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
								END
							END
							
						ELSE 
							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo *-1,13),N'#0.########################')) 
																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo *-1,999),N'#0.########################'))   END

									ELSE		   
								CASE WHEN catipoper = 'C' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo *-1,cacodmon2),N'#0.########################'))  
														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
								END
								END
                END


--,pricing_mtm_ccy_id  = Case WHEN  catipmoda = 'C' THEN  
--								CASE WHEN (SELECT ClPais 
--											FROM   BacParamSuda.dbo.cliente Clie with(nolock)
--											Where  Clie.Clrut = cacodigo 
--											And clie.Clcodigo = cacodcli) <> 6 THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 13))  
--																			  ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 999))   END

--									ELSE		   
--								CASE WHEN catipoper = 'V' THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon1))  
--														--  ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon1))
--								END
--                       END


, pricing_mtm_ccy_id  = CASE WHEN catipoper ='V' THEN 

							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 13))  
																			  ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 999))   END

								ELSE		   
								CASE WHEN catipoper = 'V' THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))  
														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
								END
							END
							
						ELSE 
							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 13))  
																			  ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 999))   END

								ELSE		   
								CASE WHEN catipoper = 'C' THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))  
														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
								END
							END
						END
                       


--,pricing_mtm_ccy_id = dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))

, pricing_base_mtm =  CASE 
						WHEN catipoper ='C' THEN   convert(varchar,format((valorrazonablePasivo*-1) ,N'#0.########################'))
						WHEN catipoper ='V' THEN  convert(varchar,format((valorrazonableactivo ) ,N'#0.########################'))
						END
--, pricing_base_mtm =  case  when convert(varchar,format((valorrazonablePasivo)*-1 ,N'#0.########################'))


,pricing_pnl = 0      -- Falta
,pricing_pnl_fx_unrealized = 0 -- Falta



,pricing_delta = 
(case 
	when isnull(cadelta,0)=0 or cadelta='' then '0'
	else convert(varchar,format(CaDelta,N'#0.########################'))
end)

,pricing_gamma = 0            --No Aplica
,pricing_vega = 0			  --No Aplica
, pricing_beta = 0		      --No Aplica
,pricing_rho_local = 0        --No Aplica
,pricing_rho_foranea = 0      --No Aplica

,pricing_theta = 0            --No Aplica
,pricing_volga = 0            --No Aplica

,side_id = CASE	WHEN cacodmon1 <> 13 AND  cacodmon2 = 13  then 2 
					WHEN cacodmon1 = 13 AND  cacodmon2 = 999  then 2  
					WHEN cacodmon1 = 13 AND  cacodmon2 = 998  then 2 
					WHEN cacodmon1 = 998 AND  cacodmon2 = 13  then 2 ELSE 2 END

,call_put_id									= 0

, CASE WHEN catipoper = 'V' then  4 WHEN catipoper ='C' THEN 2 END AS Orden


--campos nuevos
,	[transaction_emisor_id]							=  '' 
,	[transaction_plazo_pacto]						=  0 
,	[transaction_tasa_costo_pacto]					=  0 
,	[transaction_tasa_pacto]						=  0 
,	[transaction_tir_compra_origen]					=  0 
,	[transaction_tir_compra_ppa]					=  0 
,	[transaction_dev_tir_compra]					=  0 
,	[transaction_tipo_operacion_id]					=  0 
,	[transaction_fecha_compra_ins]					='1900-01-01T00:00:00'
,	[transaction_fecha_cupon]						='1900-01-01T00:00:00'


-------------------------------------------------------------------------------------------------------------
,	[Cuenta_GL]							= FwdCuentas.Cta
,	[Cuenta_SBIF]						= '0'
,	[cashflow_amount_add]				= '0'
,	[portfolio_super]					= ltrim(rtrim( substring(isnull(FwdCuentas.Id_Descripcion, ''), 1,250) ))
,	[portfolio_scn]						= ltrim(rtrim( substring(isnull(FwdCuentas.Id_Descrip_SCN, ''), 1,250)))
-------------------------------------------------------------------------------------------------------------
,	[side_discount_index]				= dbo.fx_leer_curva_forward(cacodpos1, cacodmon2,ISNULL(o.cod_colateral,''))
,	[interest_rate_icp]					= '0'

,	[TRANSACTION_OPTION_DESC]			= ''
--,	[Valor_Nocional_pagado]				= '0'
,	[TRANSACTION_OPTION_CV]				= '' --mgc.11.08.2017 Se agrega Columna
/* Nuevos Campos */
,pricing_mtm_itau  = CASE WHEN catipoper ='V' THEN 

							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,13),N'#0.########################'))  
																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo ,999),N'#0.########################'))   END

								ELSE		   
								CASE WHEN catipoper = 'V' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonableActivo,cacodmon2),N'#0.########################')) 
														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
								END
							END
							
						ELSE 
							Case WHEN  catipmoda = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo *-1,13),N'#0.########################')) 
																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo *-1,999),N'#0.########################'))   END

									ELSE		   
								CASE WHEN catipoper = 'C' THEN convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,valorrazonablePasivo *-1,cacodmon2),N'#0.########################'))  
														  --ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, cacodmon2))
								END
								END
                END
, pricing_base_mtm_itau =  CASE 
						WHEN catipoper ='C' THEN   convert(varchar,format((valorrazonablePasivo*-1) ,N'#0.########################'))
						WHEN catipoper ='V' THEN  convert(varchar,format((valorrazonableactivo ) ,N'#0.########################'))
						END
, transaction_info_party_original = clie.clrut
--fmo 20190704 agregar IDD
--, transaction_info_codigo_idd = ISNULL(nNumeroIdd,0)
--fmo 20190704 agregar IDD
from Bacfwdsuda.dbo.mfca with(nolock)
LEFT JOIN BacParamSuda..OPE_COLATERAL o ON o.id_sistema='FWD' and o.rut_cliente=cacodigo and o.cod_cliente=cacodcli and o.numero_operacion=canumoper
inner join	

(	select	codigo_producto, descripcion 

from	BacParamSuda.dbo.Producto with(nolock)

where	Id_Sistema = 'BFW'

)	Prod	On Prod.codigo_producto = cacodpos1


inner join 

(	select	clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100), PaisCliente = clpais

from	BacParamSuda.dbo.cliente with(nolock)

)	Clie	On	Clie.clrut		=cacodigo

and Clie.clcodigo	= cacodcli



INNER JOIN
(	select	distinct 
			Folio			= FwdCtaSbif.Id_Folio
		,	Id_Descripcion	= FwdCtaSbif.Id_Descripcion
		,	Id_Descrip_SCN	= FwdCtaSbif.Id_Descrip_SCN
		,	Cta				= Reportes.dbo.fx_leer_cuentas_sbif_ima	
							(	FwdCtaSbif.Id_sistema
							,	FwdCtaSbif.Id_Movimiento
							,	FwdCtaSbif.Id_Operacion
							,	FwdCtaSbif.Id_Instrumento
							,	FwdCtaSbif.Id_Moneda
							,	FwdCtaSbif.Id_Pata
							,	FwdCtaSbif.id_signo
							,	FwdCtaSbif.Id_Pais
							,	FwdCtaSbif.Id_Normativa
							,	FwdCtaSbif.Id_Subcartera
							,	FwdCtaSbif.Id_Visualizar
							)
	from 
	(	select	distinct 
				Id_Folio		= car.canumoper
			,	Id_sistema		= 'BFW'
			,	Id_Movimiento	= 'DEV'
			,	Id_Operacion	= case	when car.cacodpos1 = 10 then ltrim(rtrim( car.cacodpos1 )) + ltrim(rtrim( car.catipoper ))
										when car.cacodpos1 = 11 then ltrim(rtrim( car.cacodpos1 )) + ltrim(rtrim( car.catipoper ))
										else 'D' + ltrim(rtrim( car.cacodpos1 )) + ltrim(rtrim( car.catipoper ))
		 	            			end
			,	Id_Instrumento	= case	when car.cacodpos1 = 10 then car.cacodmon1
										else car.cacodmon2
		 	              			end
			,	Id_Moneda		= case	when car.cacodpos1 = 2 then ltrim(rtrim( car.cacodmon1 ))
										else ''
		 	         				end
			,	Id_Pata			= 1
			,	id_signo		= case when car.fres_obtenido >= 0 then '+' else '-' end
			,	Id_Pais			= cli.clpais
			,	Id_Normativa	= car.cacartera_normativa
			,	Id_Subcartera	= car.casubcartera_normativa
			,	Id_Visualizar	= 1
			,	Id_Descripcion	= isnull(cNorma.Descripcion, '')
			,	Id_Descrip_SCN	= isnull(cSubNor.Descripcion, '')
		from	BacfwdSuda.dbo.mfca car with(nolock)
	 			inner join
	 			(	select	clrut, clcodigo, clpais = case when clpais = 6 then 2 else 1 end 
	 				from	Bacparamsuda.dbo.cliente with(nolock)
	 			)	cli		On	cli.clrut		= car.cacodigo
	 						and	cli.clcodigo	= car.cacodcli
				left join
				(	select	Id			= tbcodigo1
						,	Descripcion	= tbglosa
				 	from	BacParamSuda.dbo.Tabla_General_Detalle with(nolock)
				 	where	tbcateg		= 1111
				)	cNorma	On cNorma.Id=car.cacartera_normativa
				left join
				(	select	Id				= tbcodigo1
						,	Descripcion		= tbglosa
				 	from	BacParamSuda.dbo.Tabla_General_Detalle with(nolock)
				 	where	tbcateg			= 1554
				)	cSubNor	On cSubNor.Id	= car.casubcartera_normativa
				inner join	
				(	select	codigo_producto, descripcion 
					from	BacParamSuda.dbo.Producto with(nolock)
					where	Id_Sistema = 'BFW'
				)	Prod	On Prod.codigo_producto = cacodpos1

		where	caestado  <> 'A'
		and		caestado  <> 'P'
		and		cafecvcto <> @Fecha_Proceso 
-- and		cacodpos1 <> 10 -- Eliminacion Fwd Bnd Trd
	)	FwdCtaSbif
)	FwdCuentas		On FwdCuentas.Folio	= canumoper
--fmo 20190704 agregar IDD
left join baclineas.dbo.transacciones_idd with(nolock) on cModulo='BFW' and nOperacion=canumoper
--fmo 20190704 agregar IDD
 where LTRIM(RTRIM(caestado)) <> 'A'
 --and    not    (var_moneda2  <> 0 and cacodpos1 = 1)
 and	LTRIM(RTRIM(caestado)) <> 'P'
 and	cafecvcto <> @Fecha_Proceso 
 -- AND    cacodpos1 <> 10 -- Eliminacion Fwd Bnd Trd

 ORDER BY transaction_deal_num , Orden

	--	select 'sss'


END
GO
