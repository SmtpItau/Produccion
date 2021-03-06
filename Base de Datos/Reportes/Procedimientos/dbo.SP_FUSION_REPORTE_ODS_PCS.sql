USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUSION_REPORTE_ODS_PCS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FUSION_REPORTE_ODS_PCS]
as 
begin
/**********************************************************************************************************
Cambios aplicados 23-Oct-2017

side_frec_p	
    Versión anterior        : Cantidad de día de la operación total agregando la letra “d”.	
    Versión nueva           : Periodicidad de pago de los intereses. Se usaron días homologando FINDUR.	
    Definicion Documentada  : Frecuencia de Pagos para la pata transada. Ejemplo 6m(6 meses)	

side_reset_p	
    Versión anterior        : Días Reset (días previos a la publicación de índices variables como LIBOR EUR, etc. 
                              Por ejemplo para LIBOR es 2 días.	
    Versión nueva           : Periodo de reset para la pata transada. Ejemplo 1m(1 mes). 
                              Se usaron días homologando FINDUR.	
    Definicion Documentada  : Periodo de reset para la pata transada. Ejemplo 1m(1 mes)	

interest_rate	
    Versión anterior        : Tasa de descuento para llevar flujos a valor presente desde la fecha de pago.	
    Versión nueva           : Tasa con que se calcula el interés para homologar a FINDUR. En el caso de tasa 
	                          variable este valor es calculado por el proceso de valorización.	
    Definicion Documentada  : Indica la tasa del flujo asociado a la pata de una transacción.

interest_payment	
    Versión anterior        : Monto interés sin recalcular en patas variables en moneda origen.	
    Versión nueva           : Monto interés recalculado por si es pata variable, se multiplica por -1 
                              si es de la pata pasiva, expresado en moneda de origen. Homologadp a FINDUR.	
    Definicion Documentada  : Indica el interés calculado del flujo asociado a la pata de una transacción.

interest_df	
    Versión anterior        : Tasa con que se calcula el interés.	
    Versión nueva           : Indica el factor de descuento que se utiliza para calcular el interest_npv. 
                              Interés_npv = interest_payment * interes_df. Homologadp a FINDUR.	
    Definicion Documentada  : Indica el factor de descuento que se utiliza para calcular el interest_pv

interest_npv	
    Versión anterior        : Proporción del flujo en valor presente descartando la amortización en moneda origen.	
    Versión nueva           : Monto interest_payment llevado a valor presente expresado en moneda de pago 
	                          si es entrega física. Si es compensado el valor se convierte a CLP o USD dependiendo 
							  de cliente ext o local respectivamente. 	
    Definicion Documentada  : Indica el valor presente del interés calculado del flujo asociado a la pata de una transacción

cashflow_amount	
   Versión anterior         : Monto de amortización expresada en moneda origen.	
   Versión nueva            : Monto de amortización más el flujo adicional expresada en moneda origen. 
                              Se multiplica por -1 si la pata es pasiva. 
							  La amortización de CCS sin intercambio de principal se lleva a cero.	
   Definicion Documentada   : Indica el monto del capital amortizado.

cashflow_df	
    Version anterior        : DV01 proyectado	Lo dejé igual	
    Versión nueva           : No se modificó
    Definicion Documentada  : Indica el factor de descuento que se utiliza para calcular el cashflow_pv. FINDUR manda cero.

cashflow_npv	
    Version anterior        : Valor del campo cash_flow_amount.		                          
							  Se expresa en moneda de pago si es Entrega física y si es compensado USD o CLP 
							  dependiendo si cliente es extranjero o no.	
    Versión nueva           : se lleva a valor presente con el factor de descuento informado en campo interes_df y se 
	                          lleva a cero las amortizaciones de CCS que están sin intercambio de principal.
    Versión nueva           : Indica el valor presente del monto del capital amortizado.

Cambios 23-Mayo-2018
	Nuevos campos agregado por MGM
	
	pricing_mtm_itau: idem pricing_mtm
	
	pricing_base_mtm_itau: idem pricing_base_mtm
	
***********************************************************************************************************/

DECLARE @Fecha_Proceso DATETIME = NULL
DECLARE @Fecha_ProcesoAnt DATETIME = NULL

 IF(@Fecha_Proceso IS NULL)
         BEGIN    
              SELECT    @Fecha_Proceso = M.acfecproc
			  ,         @Fecha_ProcesoAnt = m.acfecante   

              FROM Bacfwdsuda.dbo.mfac M with(nolock)
         END  


--	insert into dbo_Tbl_Resultados_ODS
SELECT  
  transaction_deal_num = Cartera.numero_operacion
, transaction_status_id = (CASE WHEN Cartera.estado = '' THEN 1 WHEN  Cartera.estado = 'N' THEN '2' end)
,transaction_trade_date =   CONVERT(varchar(30), Cartera.fecha_cierre, 126)
--,transaction_start_date =  CONVERT(varchar(30), Cartera.fecha_inicio, 126)
,transaction_start_date =  CONVERT(varchar(30), (Select min(cartera.fecha_inicio_flujo ) From  BacSwapSuda.dbo.Cartera
										WHERE Cartera.numero_operacion = Car.OPERACION), 126)
										--and Cartera.tipo_flujo = 1)
										,transaction_end_date =  CONVERT(varchar(30), Cartera.fecha_termino, 126)
,transaction_ET = CONVERT(varchar(30), Cartera.FechaInicio, 126)
,transaction_modalidad_pago  =  case when Cartera.modalidad_pago = 'E' 	then 1 
																		else 2 end 
,transaction_paymentconv_id = 1 -- Validar
,transaction_nemo = ''
,transaction_serie = ''
,transaction_TIR_compra = 0
,transaction_TIR_mercado = 0
,transaction_strike = 0
,transaction_id_group = 0
,side_type = case when tipo_flujo = 1 then 1 else 2 end  


,side_fix_flt = 
(
	case 
		when tipo_flujo =1 then 
		(case compra_codigo_tasa when 0 then 1 else 2 end)
		when tipo_flujo =2 then
		(case venta_codigo_tasa when 0 then 1 else 2 end)
	end
)

,side_frec_p = CONVERT(VARCHAR, DATEDIFF (DAY ,Cartera.Fecha_Inicio , Cartera.Fecha_Termino) ) + 'd'
,side_reset_p = CONCAT(cartera.DiasReset,'d')


--, side_notional =	CASE WHEN tipo_flujo = 1 THEN CASE WHEN cartera.Compra_Flujo_Adicional = 0 THEN  Cartera.compra_capital ELSE BacParamSuda.dbo.fx_Flujo_Adicional_Swap (cartera.numero_operacion,cartera.tipo_flujo,cartera.numero_flujo)END
--					Else CASE WHEN cartera.Venta_Flujo_Adicional = 0 THEN Cartera.venta_capital ELSE BacParamSuda.dbo.fx_Flujo_Adicional_Swap (cartera.numero_operacion,cartera.tipo_flujo,cartera.numero_flujo)END
--END


, side_notional =	 Case When Tipo_Flujo = 1 

				then convert(varchar,format( compra_capital +(Select Sum(Compra_Flujo_Adicional ) From  BacSwapSuda.dbo.Cartera
					  WHERE Cartera.numero_operacion = Car.OPERACION
					        and Cartera.tipo_flujo = Car.Tipo
					  GROUP BY numero_operacion, tipo_flujo),N'#0.########################'))
				else convert(varchar,format( venta_capital +( Select Sum(Venta_Flujo_Adicional ) From  BacSwapSuda.dbo.Cartera
					  WHERE Cartera.numero_operacion = Car.OPERACION
					        and Cartera.tipo_flujo = Car.Tipo
					  GROUP BY numero_operacion, tipo_flujo),N'#0.########################')) END


, side_notional_ccy_id  = CASE WHEN tipo_flujo = 1	THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, Cartera.compra_moneda))
													Else dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, Cartera.venta_moneda))
						  END

--, side_payment_ccy_id   = CASE WHEN tipo_flujo = 1 THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, Cartera.recibimos_moneda)) 
--						  Else dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, Cartera.pagamos_moneda)) END
						  
						  
, side_payment_ccy_id	= CASE WHEN tipo_flujo = 1 THEN 
								Case WHEN  modalidad_pago = 'C' THEN  
									CASE WHEN Clie.PaisCliente <> 6 THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 13))  
																				  ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 999))   END

									ELSE		   
										dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, Cartera.recibimos_moneda))  
															  
								END							
	
						  Else 
								Case WHEN  modalidad_pago = 'C' THEN  
									CASE WHEN Clie.PaisCliente <> 6 THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 13))  
																				  ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 999))   END

									ELSE		   
										dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, Cartera.pagamos_moneda))  
															  
								END
	                      	                      
						  END



, side_rate =			 CASE WHEN tipo_flujo = 1 THEN Cartera.compra_valor_tasa 
						 Else Cartera.venta_valor_tasa
						 END

, side_rate_spread =     CASE WHEN tipo_flujo = 1 THEN Cartera.compra_spread 
						 Else Cartera.venta_spread
						 END  

, side_rate_type_id =   case 
						when tipo_flujo =1 then 
		                (case compra_codigo_tasa when 0 then 1 else 2 end)
					    when tipo_flujo =2 then
		                (case venta_codigo_tasa when 0 then 1 else 2 end)
			             end

/*,side_projection_index = 
(
	case 
		when tipo_flujo =1 then 
		(case  WHEN compra_codigo_tasa = 0 then 'FIX' WHEN compra_codigo_tasa = 13 THEN 'FuturosICP.CLP'
		
		else (SELECT curalter FROM BacparamSuda.dbo.CURVAS_PRODUCTO  
         WHERE (producto = CASE    WHEN Cartera.tipo_swap = 1 THEN 'ST' WHEN Cartera.tipo_swap = 2 THEN 'SM' WHEN Cartera.tipo_swap = 4 THEN 'SP' END)
             AND indicador = Cartera.compra_codigo_tasa AND  Moneda = Cartera.compra_moneda)
		 end)

		when tipo_flujo =2 then
		(case  when venta_codigo_tasa  =0 then 'FIX' WHEN venta_codigo_tasa = 13 THEN 'FuturosICP.CLP'
		
		 ELSE  (SELECT curalter FROM BacparamSuda.dbo.CURVAS_PRODUCTO  
         WHERE (producto = CASE    WHEN Cartera.tipo_swap = 1 THEN 'ST' WHEN Cartera.tipo_swap = 2 THEN 'SM' WHEN Cartera.tipo_swap = 4 THEN 'SP' END)
             AND indicador = Cartera.venta_codigo_tasa AND  Moneda = Cartera.venta_moneda)
 end)
	end
)*/
,side_projection_index = 
(
	case 
		when tipo_flujo =1 then 
		(case  WHEN compra_codigo_tasa = 0 then 'FIX' WHEN compra_codigo_tasa = 13 THEN 'FuturosICP.CLP'
		
		else (SELECT curalter FROM BacparamSuda.dbo.CURVAS_PRODUCTO  CP
                                left join BacParamSuda.dbo.Definicion_Curvas df 
                                      on df.CodigoCurva = CP.CodigoCurva
         WHERE (producto = CASE    WHEN Cartera.tipo_swap = 1 THEN 'ST' WHEN Cartera.tipo_swap = 2 THEN 'SM' WHEN Cartera.tipo_swap = 4 THEN 'SP' END)
             AND indicador = Cartera.compra_codigo_tasa AND  Moneda = Cartera.compra_moneda and df.CurvaLocal = 'S')
		 end)

		when tipo_flujo =2 then
		(case  when venta_codigo_tasa  =0 then 'FIX' WHEN venta_codigo_tasa = 13 THEN 'FuturosICP.CLP'
		
		 ELSE  (SELECT curalter FROM BacparamSuda.dbo.CURVAS_PRODUCTO CP
                                left join BacParamSuda.dbo.Definicion_Curvas df 
                                      on df.CodigoCurva = CP.CodigoCurva 
         WHERE (producto = CASE    WHEN Cartera.tipo_swap = 1 THEN 'ST' WHEN Cartera.tipo_swap = 2 THEN 'SM' WHEN Cartera.tipo_swap = 4 THEN 'SP' END)
             AND indicador = Cartera.venta_codigo_tasa AND  Moneda = Cartera.venta_moneda and df.CurvaLocal = 'S')
 end)
	end
)
, side_yield_basis_id =		Case when tipo_flujo = 1 then Compra_base
							else  venta_base  END

,interest_id = Cartera.numero_flujo

,interest_start_date = CONVERT(varchar(30), cartera.Fecha_Inicio_Flujo, 126) 
,interest_end_date  =  CONVERT(varchar(30), cartera.Fecha_Vence_Flujo, 126)  
,interest_payment_date =  CONVERT(varchar(30), cartera.FechaLiquidacion, 126)  
, interest_fixing_date =  CONVERT(varchar(30), cartera.fecha_fijacion_tasa, 126)  
, interest_fixing_rate = 0
,interest_accounting_date = CONVERT(varchar(30), cartera.FechaLiquidacion, 126)  
, interest_rate				= CASE WHEN tipo_flujo = 1 THEN isnull(Cartera.Tasa_compra_Curva, 0.0) 
								   ELSE isnull(Cartera.Tasa_venta_Curva, 0.0)
					END  --> ima
,interest_payment = case when tipo_flujo = 1	then   cartera.Activo_MO_C08 
												Else - Cartera.Pasivo_MO_C08 
					end
,interest_df = CASE	WHEN Cartera.tipo_flujo = 1 THEN 1.0 / power ( 1.0 + isnull( Tasa_Compra_CurvaVR, 0.0 )/100.0,(datediff( dd, @Fecha_Proceso, FechaLiquidacion )/360.0) )
												ELSE 1.0 / power ( 1.0 + isnull( Tasa_Venta_CurvaVR, 0.0 ) /100.0,(datediff( dd, @Fecha_Proceso, FechaLiquidacion )/360.0) ) 
               END --> ima
,interest_npv				= round( CASE    WHEN Cartera.tipo_flujo = 1 THEN   cartera.Activo_MO_C08  / power ( 1.0 + Tasa_Compra_CurvaVR/100,(datediff( dd, @Fecha_Proceso, FechaLiquidacion )/360.0) )   
								             WHEN Cartera.tipo_flujo = 2 THEN - cartera.Pasivo_MO_C08  / power ( 1.0 + Tasa_Venta_CurvaVR/100, (datediff( dd, @Fecha_Proceso, FechaLiquidacion )/360.0) )   
	 	          END	--> ima
                          , 4)
,cashflow_id = Cartera.numero_flujo
,cashflowtype_id = 1
,cashflow_start_date = CONVERT(varchar(30), Cartera.Fecha_Inicio_Flujo, 126)
,cashflow_end_date = CONVERT(varchar(30), Cartera.Fecha_Vence_Flujo, 126)  
,cashflow_accounting_date = CONVERT(varchar(30), cartera.FechaLiquidacion, 126)   
,cashflow_fixing_date = CONVERT(varchar(30), Cartera.fecha_fijacion_tasa, 126) 
,cashflow_fixing_rate		=	Case  When tipo_flujo = 1	then Compra_Valor_Tasa 
									  else Venta_Valor_Tasa end
,cashflow_amount =	CASE WHEN tipo_flujo = 1 THEN  
							   convert(varchar,format( Cartera.compra_amortiza * ( case when tipo_swap = 2 then IntercPrinc else 1.0 end )
							                          +  cartera.Compra_flujo_adicional ,N'#0.########################'))
						 ELSE  
						 	   convert(varchar,format( (Cartera.venta_amortiza * ( case when tipo_swap = 2 then IntercPrinc else 1.0 end )
							                          +  cartera.Venta_flujo_adicional) * -1 ,N'#0.########################'))  
                  	END	--> ima
,cashflow_df	 = CASE WHEN tipo_flujo = 1 THEN Compra_DV01_Forward  else Venta_DV01_Forward End --> ima 

,cashflow_npv	 = case	when cartera.tipo_flujo = 1 then
                                  (cartera.compra_amortiza * ( case when tipo_swap = 2 then IntercPrinc else 1.0 end ) + cartera.compra_flujo_adicional)
							      / power ( 1.0 + Cartera.Tasa_Compra_CurvaVR/100, datediff( dd, @Fecha_Proceso, Cartera.FechaLiquidacion )/360.0
								          )
				else
					      -( cartera.venta_amortiza * ( case when tipo_swap = 2 then IntercPrinc else 1.0 end ) + cartera.Venta_flujo_adicional )
					       / power ( 1.0 + Cartera.Tasa_Venta_CurvaVR/100, datediff( dd, @Fecha_Proceso, Cartera.FechaLiquidacion )/360.0
						           )
									end 

,facility_id = 4
,transaction_info_tc_costo  = 0			         --No Aplica
,transaction_info_tc_cliente  = 0		         --No Aplica
,transaction_info_paridad_costo = 0		         --No Aplica
,transaction_info_paridad_cliente = 0	         --No Aplica
,transaction_info_spread_tc = 0			         --No Aplica
,transaction_info_spread_paridad = 0	         --No Aplica
,transaction_info_fx_spot_cliente = 0	         --No Aplica
,transaction_info_fx_fwd_costo = 0		         --No Aplica
,transaction_info_fx_fwd_cliente = 0             --No Aplica
,transaction_info_puntos_fwd = 0	             --No Aplica
,transaction_info_fx_uf_spot = 0		         --No Aplica
,transaction_info_fx_uf_tasa_costo = 0	         --No Aplica
,transaction_info_fx_uf_tasa_margen = 0	         --No Aplica
,transaction_info_fx_uf_tasa_cliente = 0		 --No Aplica
,transaction_info_fx_spot_margen = 0			 --No Aplica
,transaction_info_fx_fwd_margen = 0				 --No Aplica
,transaction_info_fx_uf_tasa_sucia_costo = 0     --No Aplica
,transaction_info_fx_uf_tasa_sucia_cliente = 0   --No Aplica
,equivalente_credito_corporativo = 0		      --No Aplica
,equivalente_credito_normativo =  0				  --No Aplica
,equivalente_credito_factor = 0					  --No Aplica
,equivalente_credito_factor_inter = 0			  --No Aplica
,equivalente_credito_factor_normativo = 0		  --No Aplica
,medio_transaccional_id = dbo.fx_MedioTransaccional_ID(BacParamSuda.dbo.fx_mesa_operador_ID(Cartera.Operador))
,canal_transaccional_id = BacParamSuda.dbo.fx_mesa_operador_ID(Cartera.Operador)
, profit_value       = ISNULL(ISNULL((SELECT Res_Mesa_Dist_CLP FROM BacSwapSuda.dbo.MovHistorico  WHERE numero_operacion = cartera.numero_operacion AND numero_flujo = cartera.numero_flujo AND Cartera.tipo_flujo = tipo_flujo),
							  (SELECT Res_Mesa_Dist_CLP FROM BacSwapSuda.dbo.MovDiario   WHERE numero_operacion = cartera.numero_operacion AND numero_flujo = cartera.numero_flujo AND Cartera.tipo_flujo = tipo_flujo)),0)
, profit_ccy_id  = dbo.Fx_Convalida_Pais_ODS('ODS','999')
, profit_mesa_clientes_clp = 0
, profit_mesa_trading_clp = 0
,portfolio_id = Cartera.cartera_inversion
,instrument_id = CASE	WHEN Cartera.tipo_swap = 1 THEN 2009   
						WHEN Cartera.tipo_swap = 2 THEN 2011       
						WHEN Cartera.tipo_swap = 4 THEN 2009  
						ELSE
						0
						END
,product_id = 1
,party_id = clie.clrut
,party_rut = CONVERT(VARCHAR, clie.clrut) + '-' + RTRIM(LTRIM(CONVERT(VARCHAR, Clie.cldv)))
, party_secuencia = DBO.Fx_Tipo_Contraparte_ODS (clie.clrut, clie.clcodigo)

----,pricing_mtm =  CASE WHEN tipo_flujo = 1 
----				THEN  convert(varchar,format(BacParamSuda.dbo.fx_convierte_monto_25(@Fecha_Proceso,999,activo_flujoclp,Cartera.recibimos_moneda),N'0.0########################'))                
----				 ELSE convert(varchar,format(BacParamSuda.dbo.fx_convierte_monto_25(@Fecha_Proceso,999,pasivo_flujoclp,Cartera.pagamos_moneda) *-1,N'0.0########################')) 
----                        END


,pricing_mtm =  CASE WHEN tipo_flujo = 1 
               THEN 
               		Case WHEN  modalidad_pago = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN  convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(cartera.numero_operacion,1),13),N'#0.########################')) 
																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(cartera.numero_operacion,1),999),N'#0.########################'))   END

					ELSE		   
								convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(cartera.numero_operacion,1),Cartera.recibimos_moneda),N'#0.########################')) 
											 
					END
               	
			   else 
			   		Case WHEN  modalidad_pago = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN  convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(cartera.numero_operacion,2)*-1,13),N'#0.########################')) 
																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(cartera.numero_operacion,2)*-1,999),N'#0.########################'))   END

					ELSE		   
								convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(cartera.numero_operacion,2)*-1,Cartera.pagamos_moneda),N'#0.########################')) 
											 
					END
                        END

--,pricing_mtm =  CASE WHEN tipo_flujo = 1 
--				THEN  convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(cartera.numero_operacion,1) ,Cartera.recibimos_moneda),N'#0.########################'))
--				ELSE  convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(cartera.numero_operacion,2)*-1,Cartera.pagamos_moneda),N'#0.########################'))
--                        END


--,pricing_mtm_ccy_id = CASE WHEN tipo_flujo = 1 THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, Cartera.recibimos_moneda)) 
--					  Else dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, Cartera.pagamos_moneda)) END
					  
,pricing_mtm_ccy_id = CASE WHEN tipo_flujo = 1 THEN 
							Case WHEN  modalidad_pago = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 13))  
																			  ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 999))   END

								ELSE		   
									dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, Cartera.recibimos_moneda))  
														  
						    END
							
	
					  Else 
							 Case WHEN  modalidad_pago = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 13))  
																			  ELSE dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, 999))   END

								ELSE		   
									dbo.Fx_Convalida_Pais_ODS('ODS', Convert(Varchar, Cartera.pagamos_moneda))  
														  
						    END
                      
                      
                      END

,pricing_base_mtm =  CASE WHEN tipo_flujo = 1 THEN 
					 convert(varchar,format(BacparamSuda.DBO.fx_SumatoriaFlujosSwap(cartera.numero_operacion,1),N'0.0########################')) 
					 ELSE convert(varchar,format(BacparamSuda.DBO.fx_SumatoriaFlujosSwap(cartera.numero_operacion,2) *-1,N'0.0########################')) 
                              END


,pricing_pnl  = CASE WHEN cartera.tipo_flujo = 1 THEN (SELECT (a.compra_amortiza + a.compra_interes)
                         FROM BacSwapSuda.dbo.CarteraHis a WHERE numero_operacion IN (Cartera.numero_operacion)
                         AND a.fecha_vence_flujo = (SELECT MAX (fecha_vence_flujo) FROM BacSwapSuda.dbo.CarteraHis h WHERE h.numero_operacion = cartera.numero_operacion and tipo_flujo = 1)
                         AND a.tipo_flujo = 1)
                         ELSE 
                              
                        (SELECT (a.venta_amortiza + a.venta_interes)
                         FROM BacSwapSuda.dbo.CarteraHis a WHERE numero_operacion IN (Cartera.numero_operacion)
                         AND a.fecha_vence_flujo = (SELECT MAX (fecha_vence_flujo) FROM BacSwapSuda.dbo.CarteraHis h WHERE h.numero_operacion = cartera.numero_operacion  and tipo_flujo = 2 )
                         AND a.tipo_flujo = 2) END 



,pricing_pnl_fx_unrealized =       ISNULL(     (SELECT (ISNULL(compra.compra_valor_presente,0)-ISNULL(venta.venta_valor_presente ,0))
                                                           FROM   bacswapsuda.dbo.Cartera compra
                                                           LEFT  JOIN (
                                                                       SELECT *
                                                                       FROM   bacswapsuda.dbo.Cartera
                                                                       WHERE  tipo_flujo = 2
                                                                 )     AS Venta
                                                                 ON  venta.numero_operacion = compra.numero_operacion
                                                                 AND  venta.fecha_vence_flujo = compra.fecha_vence_flujo
                                                           WHERE  compra.tipo_flujo = 1
                                                           AND COMPRA.NUMERO_OPERACION IN (Cartera.numero_operacion)
                                                           AND compra.numero_flujo = Cartera.numero_flujo),0)




,pricing_delta = 0				  --No Aplica
,pricing_gamma = 0			      --No Aplica
,pricing_vega = 0				  --No Aplica
,pricing_beta = 0				  --No Aplica
,pricing_rho_local = 0			  --No Aplica
,pricing_rho_foranea = 0		  --No Aplica
,pricing_theta = 0			      --No Aplica
,pricing_volga = 0				  --No Aplica
,side_id =  CASE WHEN tipo_flujo = 1  THEN 
				CASE	WHEN CARTERA.compra_moneda <> 13 AND  CARTERA.venta_moneda = 13  then 1 
						WHEN CARTERA.compra_moneda = 13 AND  CARTERA.venta_moneda = 999  then 1  
						WHEN CARTERA.compra_moneda = 13 AND  CARTERA.venta_moneda = 998  then 1 
						WHEN CARTERA.compra_moneda = 998 AND  CARTERA.venta_moneda = 13  then 1 ELSE 1 END
			ELSE
				CASE	WHEN CARTERA.compra_moneda <> 13 AND  CARTERA.venta_moneda = 13  then 2
						WHEN CARTERA.compra_moneda = 13 AND  CARTERA.venta_moneda = 999  then 2  
						WHEN CARTERA.compra_moneda = 13 AND  CARTERA.venta_moneda = 998  then 2 
						WHEN CARTERA.compra_moneda = 998 AND  CARTERA.venta_moneda = 13  then 2 ELSE 2 END					
				
			END 

,call_put_id									= 0
, 1 AS Orden

--campos nuevos
,[transaction_emisor_id]					=  '' 
,[transaction_plazo_pacto]					=  0 
,[transaction_tasa_costo_pacto]				=  0 
,[transaction_tasa_pacto]					=  0 
,[transaction_tir_compra_origen]			=  0 
,[transaction_tir_compra_ppa]				=  0 
,[transaction_dev_tir_compra]				=  0 
,[transaction_tipo_operacion_id]			=  0 
,[transaction_fecha_compra_ins]				='1900-01-01T00:00:00'
,[transaction_fecha_cupon]					='1900-01-01T00:00:00'

	-------------------------------------------------------------------------------------------------------------
	,	[Cuenta_GL]							= SwapCtasSbif.CtaBac
	,	[Cuenta_SBIF]						= '0'
	,	[cashflow_amount_add]				= case	when cartera.tipo_flujo = 1 then cartera.Compra_Flujo_Adicional
													else cartera.Venta_Flujo_Adicional
	 	                     				  end
	,	[portfolio_super]					= ltrim(rtrim( substring(isnull(SwapCtasSbif.Normativa, ''),	  1,250) ))
	,	[portfolio_scn]						= ltrim(rtrim( substring(isnull(SwapCtasSbif.Id_Descrip_SCN, ''), 1,250) ))
	-------------------------------------------------------------------------------------------------------------
/*
	,	[side_discount_index]	= Reportes.dbo.fx_leer_curva_swap	(	Cartera.tipo_swap
																	,	case	when Cartera.tipo_flujo = 1 then Cartera.compra_moneda
																				when Cartera.tipo_flujo = 2 then Cartera.venta_moneda
																			end
																	,	case	when Cartera.tipo_flujo = 1 then Cartera.compra_codigo_tasa
																				when Cartera.tipo_flujo = 2 then Cartera.venta_codigo_tasa
																			end
																	)
*/
	,	[side_discount_index]	= Reportes.dbo.fx_leer_curva_swap	(	Cartera.tipo_swap
																	,	case	when Cartera.tipo_flujo = 1 then Cartera.compra_moneda
																				when Cartera.tipo_flujo = 2 then Cartera.venta_moneda
																			end
																	,	case	when Cartera.tipo_flujo = 1 then Cartera.compra_codigo_tasa
																				when Cartera.tipo_flujo = 2 then Cartera.venta_codigo_tasa
																			end, isnull( cod_Colateral,'' ) )
	,	[interest_rate_icp]		= Reportes.dbo.Fn_Genera_TNATRA	(	cartera.numero_operacion
																,	cartera.numero_flujo
																,	cartera.tipo_flujo
																) 
	,	[TRANSACTION_OPTION_DESC]	= ''
	--,	[Valor_Nocional_pagado]		= '0'
	,	[TRANSACTION_OPTION_CV]		= '' --mgc.11.08.2017 Se agrega Columna
	,pricing_mtm_itau =  CASE WHEN tipo_flujo = 1 
               THEN 
               		Case WHEN  modalidad_pago = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN  convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(cartera.numero_operacion,1),13),N'#0.########################')) 
																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(cartera.numero_operacion,1),999),N'#0.########################'))   END

					ELSE		   
								convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(cartera.numero_operacion,1),Cartera.recibimos_moneda),N'#0.########################')) 
											 
					END
               	
			   else 
			   		Case WHEN  modalidad_pago = 'C' THEN  
								CASE WHEN Clie.PaisCliente <> 6 THEN  convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(cartera.numero_operacion,2)*-1,13),N'#0.########################')) 
																			  ELSE convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(cartera.numero_operacion,2)*-1,999),N'#0.########################'))   END

					ELSE		   
								convert(varchar,format(BacParamsuda.DBO.fx_PesosaMX(@Fecha_Proceso,999,BacparamSuda.DBO.fx_SumatoriaFlujosSwap(cartera.numero_operacion,2)*-1,Cartera.pagamos_moneda),N'#0.########################')) 
											 
					END
               END
	,pricing_base_mtm_itau =  CASE WHEN tipo_flujo = 1 THEN 
					 convert(varchar,format(BacparamSuda.DBO.fx_SumatoriaFlujosSwap(cartera.numero_operacion,1),N'0.0########################')) 
					 ELSE convert(varchar,format(BacparamSuda.DBO.fx_SumatoriaFlujosSwap(cartera.numero_operacion,2) *-1,N'0.0########################')) 
                              END
	,transaction_info_party_original = clie.clrut
--fmo 20190704 agregar IDD
--    ,transaction_info_codigo_idd = ISNULL(nNumeroIdd,0)
--fmo 20190704 agregar IDD

	-- MAP 20171020 Ini
	-- Conceptos para realizar conversión a moneda de pago 
	-- y monitorear comportamiento
	,   Moneda_Origen_SONDA     = isnull( case when tipo_Flujo = 1 then Compra_moneda else venta_moneda end  										
											   , 999 )
	,   Moneda_Pago_SONDA       = isnull( case when tipo_Flujo = 1 then Recibimos_moneda else pagamos_moneda end  															   
											   , 999 )
	,   Codigo_Periodo_pago_interes_SONDA = case when Cartera.Tipo_flujo = 1 then Cartera.Compra_CodAmo_interes else Cartera.Venta_CodAmo_interes end 
	,   Codigo_tasa_SONDA                 = case when Cartera.Tipo_flujo = 1 then Cartera.Compra_codigo_tasa    else Cartera.Venta_Codigo_tasa    end
	,   Modalidad_pago_SONDA              = modalidad_pago
	,   Clie.PaisCliente
        -- MAP 20171020 Fin
															  
	INTO #Resultado
from BacSwapSuda.dbo.Cartera Cartera
LEFT JOIN BacParamSuda..OPE_COLATERAL o ON o.id_sistema='SWP' and o.rut_cliente=cartera.rut_cliente and o.cod_cliente=cartera.codigo_cliente and o.numero_operacion=cartera.numero_operacion
inner join 
(Select	clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) , PaisCliente = clpais
from	BacParamSuda.dbo.cliente with(nolock)
)	
Clie	On	Clie.clrut		= Cartera.rut_cliente
and Clie.clcodigo	= Cartera.codigo_cliente


  LEFT  JOIN
       (Select  numero_operacion  AS OPERACION              
               ,tipo_flujo        AS TIPO
			   ,numero_flujo      AS FLUJO
          from BacSwapSuda.dbo.Cartera Cartera
             ) CAR
              ON Cartera.numero_operacion = CAR.OPERACION
         AND Cartera.tipo_flujo       = CAR.TIPO 
		 AND Cartera.numero_flujo = CAR.FLUJO

	left join
	(	select  Folio			= SwapCtas.folio
			,	Normativa		= SwapCtas.Id_Descripcion
			,	Id_Descrip_SCN	= SwapCtas.Id_Descrip_SCN
			,	CtaBac			= Reportes.dbo.fx_leer_cuentas_sbif_ima	
									(	SwapCtas.Id_Sistema
									,	SwapCtas.Id_Movimiento
									,	SwapCtas.Id_Operacion
									,	SwapCtas.Id_Instrumento
									,	SwapCtas.Id_Moneda
									,	SwapCtas.Id_Pata
									,	SwapCtas.Id_signo
									,	SwapCtas.Id_Pais
									,	SwapCtas.Id_Normativa
									,	SwapCtas.Id_Subcartera
									,	1
									)
		from
	
		(	select	distinct 
					Folio				= cartera.numero_operacion
				,	Id_Sistema			= 'PCS'
				,	Id_Movimiento		= 'DEV'
				,	Id_Operacion		= 'D' + ltrim(rtrim( cartera.tipo_swap ))
				,	Id_Instrumento		= ''
				,	Id_Moneda			= case when cartera.tipo_swap = 2 then '999' else cartera.compra_moneda end
				,	Id_Pata				= cartera.tipo_flujo
				,	Id_signo			= case when cartera.Valor_RazonableCLP >= 0 then '+' else '-' end
				,	Id_Pais				= cli.clpais
				,	Id_Normativa		= cartera.car_Cartera_Normativa
				,	Id_Subcartera		= cartera.car_SubCartera_Normativa
				,	Id_Descripcion		= isnull(cNormativa.Descripcion, '')
				,	Id_Descrip_SCN		= isnull(sSubCartera.Descripcion, '')

	 		from	BacSwapSuda.dbo.cartera cartera with(nolock)
	 				inner join
	 				(	select	clrut, clcodigo, clpais = case when clpais = 6 then 2 else 1 end 
	 				 	from	Bacparamsuda.dbo.cliente with(nolock)
	 				)	cli		On	cli.clrut		= cartera.rut_cliente
	 							and	cli.clcodigo	= cartera.codigo_cliente

	 				left join
	 				(	select	id = tbcodigo1
	 						,	Descripcion	= tbglosa
	 				 	from	BacParamSuda.dbo.Tabla_General_Detalle with(nolock)
	 				 	where	tbcateg = 1111
	 				)	cNormativa On cNormativa.id = cartera.car_Cartera_Normativa

	 				left join
	 				(	select	id = tbcodigo1
	 						,	Descripcion	= tbglosa
	 				 	from	BacParamSuda.dbo.Tabla_General_Detalle with(nolock)
	 				 	where	tbcateg = 1554
	 				)	sSubCartera On sSubCartera.id = cartera.car_SubCartera_Normativa

	 		where	cartera.tipo_flujo = 1
	 		and		cartera.estado	  <> 'C'
		)	SwapCtas
	)	SwapCtasSbif	On SwapCtasSbif.folio =  Cartera.numero_operacion

--fmo 20190704 agregar IDD
 left join baclineas.dbo.transacciones_idd with(nolock) on cModulo='PCS' and nOperacion=Cartera.numero_operacion
--fmo 20190704 agregar IDD
where Cartera.estado <> 'C'
And Cartera.fecha_vence_flujo <> @Fecha_Proceso 
ORDER BY cartera.numero_operacion, tipo_flujo, numero_flujo

/* Ajustes varios para cumplir definiciones 
*/
    update #Resultado
	   set interest_npv     = case when modalidad_pago_sonda = 'C' then 
	                             case when PaisCliente <> 6 then round(BacParamSuda.dbo.fx_convierte_monto(@Fecha_Proceso, Moneda_Origen_SONDA,interest_npv, 13), 4)
								 else  round(BacParamSuda.dbo.fx_convierte_monto(@Fecha_Proceso, Moneda_Origen_SONDA,interest_npv,999), 0) 
								 end
	                          else 
							     round(BacParamSuda.dbo.fx_convierte_monto(@Fecha_Proceso, Moneda_Origen_SONDA,interest_npv, Moneda_pago_SONDA), 4)
							  end
		 , side_frec_p  = rtrim( isnull( (select convert( varchar(10), dias ) 
		                           from BacParamSuda..PERIODO_AMORTIZACION Per 
								   where Per.tabla = 1044 and Per.codigo = Codigo_Periodo_pago_interes_SONDA ) , '0' ) ) + 'd'
		 , side_reset_p = isnull( ( select convert( varchar(10), dias ) from BacParamSuda..PERIODO_AMORTIZACION Per,  
                          BacParamsuda..tabla_general_Detalle Tas  
                           where tabla = 1044   and tbcateg = 1042 and  per.codigo = Tas.tbtasa  and   tbcodigo1 = Codigo_tasa_SONDA )
						   , '0' ) + 'd'
                 , cashflow_npv = 
					case	when modalidad_pago_SONDA = 'C' then 
								case	when PaisCliente <> 6 then round(BacParamSuda.dbo.fx_convierte_monto(@Fecha_Proceso, Moneda_Origen_SONDA,cashflow_npv, 13), 4)
										else							round(BacParamSuda.dbo.fx_convierte_monto(@Fecha_Proceso, Moneda_Origen_SONDA,cashflow_npv,999), 0)
								end 
							else										round(BacParamSuda.dbo.fx_convierte_monto(@Fecha_Proceso, Moneda_Origen_SONDA,cashflow_npv,Moneda_pago_SONDA), 4)
					end 	 



 	select transaction_deal_num
	      ,transaction_status_id
		  ,transaction_trade_date
		  ,transaction_start_date
		  ,transaction_end_date
		  ,transaction_ET
		  ,transaction_modalidad_pago
		  ,transaction_paymentconv_id
		  ,transaction_nemo
		  ,transaction_serie
		  ,transaction_TIR_compra
		  ,transaction_TIR_mercado
		  ,transaction_strike
		  ,transaction_id_group
		  ,side_type
		  ,side_fix_flt
		  ,side_frec_p
		  ,side_reset_p
		  ,side_notional
		  ,side_notional_ccy_id
		  ,side_payment_ccy_id
		  ,side_rate
		  ,side_rate_spread
		  ,side_rate_type_id
		  ,side_projection_index
		  ,side_yield_basis_id
		  ,interest_id
		  ,interest_start_date
		  ,interest_end_date
		  ,interest_payment_date
		  ,interest_fixing_date
		  ,interest_fixing_rate
		  ,interest_accounting_date
		  ,interest_rate
		  ,interest_payment
		  ,interest_df
		  ,interest_npv
		  ,cashflow_id
		  ,cashflowtype_id
		  ,cashflow_start_date
		  ,cashflow_end_date
		  ,cashflow_accounting_date
		  ,cashflow_fixing_date
		  ,cashflow_fixing_rate
		  ,cashflow_amount
		  ,cashflow_df
		  ,cashflow_npv
		  ,facility_id
		  ,transaction_info_tc_costo
		  ,transaction_info_tc_cliente
		  ,transaction_info_paridad_costo
		  ,transaction_info_paridad_cliente
		  ,transaction_info_spread_tc
		  ,transaction_info_spread_paridad
		  ,transaction_info_fx_spot_cliente
		  ,transaction_info_fx_fwd_costo
		  ,transaction_info_fx_fwd_cliente
		  ,transaction_info_puntos_fwd
		  ,transaction_info_fx_uf_spot
		  ,transaction_info_fx_uf_tasa_costo
		  ,transaction_info_fx_uf_tasa_margen
		  ,transaction_info_fx_uf_tasa_cliente
		  ,transaction_info_fx_spot_margen
		  ,transaction_info_fx_fwd_margen
		  ,transaction_info_fx_uf_tasa_sucia_costo
		  ,transaction_info_fx_uf_tasa_sucia_cliente
		  ,equivalente_credito_corporativo
		  ,equivalente_credito_normativo
		  ,equivalente_credito_factor
		  ,equivalente_credito_factor_inter
		  ,equivalente_credito_factor_normativo
		  ,medio_transaccional_id
		  ,canal_transaccional_id
		  ,profit_value
		  ,profit_ccy_id
		  ,profit_mesa_clientes_clp
		  ,profit_mesa_trading_clp
		  ,portfolio_id
		  ,instrument_id
		  ,product_id
		  ,party_id
		  ,party_rut
		  ,party_secuencia
		  ,pricing_mtm
		  ,pricing_mtm_ccy_id
		  ,pricing_base_mtm
		  ,pricing_pnl
		  ,pricing_pnl_fx_unrealized
		  ,pricing_delta
		  ,pricing_gamma
		  ,pricing_vega
		  ,pricing_beta
		  ,pricing_rho_local
		  ,pricing_rho_foranea
		  ,pricing_theta
		  ,pricing_volga
		  ,side_id
		  ,call_put_id
		  ,Orden
		  ,transaction_emisor_id
		  ,transaction_plazo_pacto
		  ,transaction_tasa_costo_pacto
		  ,transaction_tasa_pacto
		  ,transaction_tir_compra_origen
		  ,transaction_tir_compra_ppa
		  ,transaction_dev_tir_compra
		  ,transaction_tipo_operacion_id
		  ,transaction_fecha_compra_ins
		  ,transaction_fecha_cupon
		  ,Cuenta_GL
		  ,Cuenta_SBIF
		  ,cashflow_amount_add
		  ,portfolio_super
		  ,portfolio_scn
		  ,side_discount_index
		  ,interest_rate_icp
		  ,TRANSACTION_OPTION_DESC
		  ,TRANSACTION_OPTION_CV
		  ,pricing_mtm_itau
		  ,pricing_base_mtm_itau
		  ,transaction_info_party_original
--fmo 20190704 agregar IDD
--          ,transaction_info_codigo_idd
--fmo 20190704 agregar IDD
	  from #Resultado
Fin:
	  drop table #Resultado

END

GO
