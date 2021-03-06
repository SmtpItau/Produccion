USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[MonitorFX_TblOperacionesSelectALL]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MonitorFX_TblOperacionesSelectALL] (@TipoOperacion SMALLINT=0)
AS
/*
exec MonitorFX_TblOperacionesSelectALL 0
*/
	IF (@TipoOperacion =0)
	BEGIN 
		SELECT top 1 ISNULL(ARR_numero_operacion, 0)										AS ARR_numero_operacion,
			   ISNULL(ARR_tipo_producto_nombre, '')											AS ARR_tipo_producto_nombre,
			   ISNULL(ARR_compra_venta, '')													AS ARR_compra_venta,
			   ISNULL(ARR_cliente_rut, 0)													AS ARR_cliente_rut,
			   ISNULL(ARR_cliente_Codigo, 0)												AS ARR_cliente_Codigo,
			   ISNULL(ARR_cliente, '')														AS ARR_cliente,
			   ISNULL(ARR_moneda, '')														AS ARR_moneda,
			   ISNULL(ARR_moneda_conversion, '')											AS ARR_moneda_conversion,
			   ISNULL(ARR_monto, 0)															AS ARR_monto,
			   
			   
			   /*CASE WHEN O.idArchivo IN(4,5,6) THEN 
	       		ISNULL(ARR_tipo_cambio_cierre,0)
	       		ELSE 
			   ISNULL(ARR_precio_cierre_clp, 0)	END*/ 										
			   
			   (SELECT Tipo_Cambio
	            FROM BacParamSuda.DBO.VALOR_MONEDA_CONTABLE 
	            WHERE Fecha = Oper_sfecha AND Nemo_Moneda = Oper_sCodComprador) AS ARR_tipo_cambio_cierre,
	            
			   /*ISNULL(ARR_tipo_cambio_transferencia, 0)										*/
			   
			   (SELECT vmvalor 
	            FROM BacParamSuda.DBO.VALOR_MONEDA  
			    WHERE vmcodigo = 994 
	            AND	 vmfecha = Oper_sfecha)													AS ARR_tipo_cambio_transferencia,
	            
	            
			   /*ISNULL(ARR_paridad_cierre_usd, 0)*/											
			   
			   CASE WHEN O.idArchivo IN(4,5,6) THEN 
	       		ISNULL(ARR_tipo_cambio_cierre,0)
	       		ELSE 
			   ISNULL(ARR_precio_cierre_clp, 0)	END											AS ARR_paridad_cierre_usd,
			   
			   
			   
			   ISNULL(ARR_paridad_transferencia_usd, 0)										AS ARR_paridad_transferencia_usd,
			   ISNULL(ARR_equivalente_cierre_us, 0)											AS ARR_equivalente_cierre_us,
			   ISNULL(ARR_equivalente_transferencia_us, 0)									AS ARR_equivalente_transferencia_us,
			   ISNULL(ARR_equivalente_transferencia_peso, 0)								AS ARR_equivalente_transferencia_pe,
			   CASE 
					WHEN o.idarchivo > 3 THEN 130
					ELSE ISNULL(ARR_forma_pago_entregamos, 0)
			   END																			AS ARR_forma_pago_entregamos,
			   CASE 
					WHEN o.idarchivo > 3 THEN 130
					ELSE ISNULL(ARR_forma_pago_recibimos, 0)
			   END																			AS ARR_forma_pago_recibimos,
			   ISNULL(ARR_usuario, '')														AS ARR_usuario,
			   ISNULL(ARR_origen, '')														AS ARR_origen,
			   ISNULL(ARR_fecha_proceso, '1900-01-01')										AS ARR_fecha_proceso,
			   ISNULL(ARR_codigo_oma, 0)													AS ARR_codigo_oma,
			   ISNULL(ARR_estado, '')														AS ARR_estado,
			   ISNULL(ARR_codeject, 0)														AS ARR_codeject,
			   ISNULL(ARR_valuta_entregamos, '')											AS ARR_valuta_entregamos,
			   ISNULL(ARR_valuta_recibimos, '')												AS ARR_valuta_recibimos,
			   ISNULL(ARR_rentabilidad, 0)													AS ARR_rentabilidad,
			   ISNULL(ARR_linea, 0)															AS ARR_linea,
			   ISNULL(ARR_entidad, 0)														AS ARR_entidad,
			   ISNULL(ARR_precio_cierre_clp, 0)												AS ARR_precio_cierre_clp,
			   ISNULL(ARR_precio_transferencia_clp, 0)										AS ARR_precio_transferencia_clp,
			   ISNULL(ARR_estado_captura_fwd, 0)											AS ARR_estado_captura_fwd,
			   ISNULL(ARR_tipo_operacion, '')												AS ARR_tipo_operacion,
			   ISNULL(ARR_contabiliza, 'N')													AS ARR_contabiliza,
			   ISNULL(ARR_observacion, '')													AS ARR_observacion,
			   ISNULL(ARR_en_donde_recibe_corresponsal, '')									AS ARR_en_donde_recibe_corresponsal,
			   ISNULL(ARR_quien_entrega_corresponsal, '')									AS ARR_quien_entrega_corresponsal,
			   ISNULL(ARR_desde_entrega_corresponsal, '')									AS ARR_desde_entrega_corresponsal,
			   ISNULL(ARR_plaza_corrdonde, 0)												AS ARR_plaza_corrdonde,
			   ISNULL(ARR_plaza_corrquien, 0)												AS ARR_plaza_corrquien,
			   ISNULL(ARR_plaza_corrdesde, 0)												AS ARR_plaza_corrdesde,
			   ISNULL(ARR_fpagomxcli, 0)													AS ARR_fpagomxcli,
			   ISNULL(ARR_fpagomncli, 0)													AS ARR_fpagomncli,
			   ISNULL(ARR_fechaMnCl, '')													AS ARR_fechaMnCl,
			   ISNULL(ARR_fechaMxCl, '')													AS ARR_fechaMxCl,
			   ISNULL(ARR_codigo_area, '')													AS ARR_codigo_area,
			   ISNULL(ARR_codigo_Comercio, '')												AS ARR_codigo_Comercio,
			   ISNULL(ARR_codigo_concepto, '')												AS ARR_codigo_concepto,
			   ISNULL(ARR_casamatriz, '')													AS ARR_casamatriz,
			   ISNULL(ARR_montofinal, 0)													AS ARR_montofinal,
			   ISNULL(ARR_dias, 0)															AS ARR_dias,
			   ISNULL(ARR_girador_rut, 0)													AS ARR_girador_rut,
			   ISNULL(ARR_girador_codigo, 0)												AS ARR_girador_codigo,
			   ISNULL(ARR_costofondo, 0)													AS ARR_costofondo,
			   ISNULL(ARR_arb_utilidad_peso, 0)												AS ARR_arb_utilidad_peso,
			   ISNULL(ARR_arb_tipo_cambio_MX, 0)											AS ARR_arb_tipo_cambio_MX,
			   ISNULL(ARR_fechavcto, '')													AS ARR_fechavcto,
			   ISNULL(ARR_vamos, '')														AS ARR_vamos,
			   ISNULL(ARR_cod_corresponsal, '')												AS ARR_cod_corresponsal,
			   ISNULL(ARR_p_indFWD, '')														AS ARR_p_indFWD,
			   ISNULL(ARR_p_numFWD, 0)														AS ARR_p_numFWD,
			   ISNULL(ARR_fechaFwdini, '')													AS ARR_fechaFwdini,
			   ISNULL(ARR_fechaFwdvcto, '')													AS ARR_fechaFwdvcto,
			   ISNULL(ARR_mtipo_cambioFwd, 0)												AS ARR_mtipo_cambioFwd,
			   ISNULL(ARR_prodFWD, 0)														AS ARR_prodFWD,
			   ISNULL(ARR_netting, '')														AS ARR_netting,
			   ISNULL(ARR_numero_tbtx, 0)													AS ARR_numero_tbtx,
			   ISNULL(ARR_controla_tran, '')												AS ARR_controla_tran,
			   ISNULL(ARR_gs_Corresponsal, '')												AS ARR_gs_Corresponsal,
			   ISNULL(ARR_p_ind_origen_manual, 0)											AS ARR_p_ind_origen_manual,
			   ISNULL(ARR_cmx_punta_pizarra, 0)												AS ARR_cmx_punta_pizarra,
			   ISNULL(ARR_cmx_tc_costo_trad, 0)												AS ARR_cmx_tc_costo_trad,
			   ISNULL(ARR_nResultadoTrans_Mo, 0)											AS ARR_nResultadoTrans_Mo,
			   ISNULL(ARR_nResultadoTrans_Clp, 0)											AS ARR_nResultadoTrans_Clp,
			   ISNULL(ARR_sCanal, '')														AS ARR_sCanal,
			   ISNULL(ARR_usuario_digitador, '')											AS ARR_usuario_digitador,
			   idPosicion
		FROM   dbo.MonitorFX_TblOperaciones o WITH(NOLOCK)
		INNER JOIN dbo.MonitorFX_TblConfArchivos mftca WITH(NOLOCK) ON mftca.idArchivo = o.idArchivo 
		AND mftca.Arch_bHabilitado=1 
		WHERE  (o.IDARCHIVO = 1
				AND NOT(ARR_cliente IS NULL)
				AND NUMEROBAC IS NULL 
				AND oper_snula='I'
				AND Oper_sNemoComprador <>''
				AND Oper_sNemoVendedor<>'')
			   OR  (o.IDARCHIVO = 3 AND  NUMEROBAC IS NULL AND arr_fecha_proceso= (SELECT acfecpro FROM  baccamsuda.dbo.meac))
			   OR  (o.IDARCHIVO = 5 AND o.Oper_sNemoVendedor =2 AND ARR_CLIENTE_RUT <>0 AND NUMEROBAC IS NULL)
			   OR  (o.IDARCHIVO = 4 AND ARR_CLIENTE_RUT <>0 AND NUMEROBAC IS NULL)
			   OR  (o.IDARCHIVO = 6 AND ARR_CLIENTE_RUT <>0 AND NUMEROBAC IS NULL)
	END 
	ELSE
	BEGIN

		SELECT TOP 1 [idPosicion]
			  ,O.idArchivo
			  ,[Oper_dFecha]
			  ,[Oper_Hora]
			  ,[Oper_sCodComprador]
			  ,[Oper_sNemoComprador]
			  ,[Oper_sCodVendedor]
			  ,[Oper_sNemoVendedor]
			  ,[Oper_fMontoOrigen]
			  ,[Oper_fPrecio]
			  ,[Oper_sOperacion]
			  ,[Oper_sNula]
			  ,[Oper_sEquivalencia]
			  ,[Oper_sIdentificacion]
			  ,[Oper_sCliente]
			  ,[Oper_sUsuario]
			  ,[Oper_sContraparte]
			  ,[Oper_sMercado]
			  ,[Oper_sFecha]
			  ,[ARR_numero_operacion]
			  ,[ARR_tipo_producto_nombre]
			  ,[ARR_compra_venta]
			  ,[ARR_cliente_rut]
			  ,[ARR_cliente_Codigo]
			  ,[ARR_cliente]
			  ,[ARR_moneda]
			  ,[ARR_moneda_conversion]
			  ,[ARR_monto]
			  ,[ARR_tipo_cambio_cierre]
			  ,[ARR_tipo_cambio_transferencia]
			  ,[ARR_paridad_cierre_usd]
			  ,[ARR_paridad_transferencia_usd]
			  ,[ARR_equivalente_cierre_us]
			  ,[ARR_equivalente_transferencia_us]
			  ,[ARR_equivalente_transferencia_peso]
			  ,[ARR_forma_pago_entregamos]
			  ,[ARR_forma_pago_recibimos]
			  ,[ARR_usuario]
			  ,[ARR_origen]
			  ,[ARR_fecha_proceso]
			  ,[ARR_codigo_oma]
			  ,[ARR_estado]		  
			  , 	CASE	WHEN ARR_CODEJECT = 0 THEN '19000101'
					ELSE CONVERT(DATETIME, CONVERT(VARCHAR(8), ARR_CODEJECT), 112)
				END  AS ARR_codeject
			  ,[ARR_valuta_entregamos]
			  ,[ARR_valuta_recibimos]
			  ,[ARR_rentabilidad]
			  ,[ARR_linea]
			  ,[ARR_entidad]
			  ,[ARR_precio_cierre_clp]
			  ,[ARR_precio_transferencia_clp]
			  ,[ARR_estado_captura_fwd]
			  ,[ARR_tipo_operacion]
			  ,[ARR_contabiliza]
			  ,[ARR_observacion]
			  ,[ARR_en_donde_recibe_corresponsal]
			  ,[ARR_quien_entrega_corresponsal]
			  ,[ARR_desde_entrega_corresponsal]
			  ,[ARR_plaza_corrdonde]
			  ,[ARR_plaza_corrquien]
			  ,[ARR_plaza_corrdesde]
			  ,[ARR_fpagomxcli]
			  ,[ARR_fpagomncli]
			  ,[ARR_fechaMnCl]
			  ,[ARR_fechaMxCl]
			  ,[ARR_codigo_area]
			  ,[ARR_codigo_Comercio]
			  ,[ARR_codigo_concepto]
			  ,[ARR_casamatriz]
			  ,[ARR_montofinal]
			  ,[ARR_dias]
			  ,[ARR_girador_rut]
			  ,[ARR_girador_codigo]
			  ,[ARR_costofondo]
			  ,[ARR_arb_utilidad_peso]
			  ,[ARR_arb_tipo_cambio_MX]
			  ,[ARR_fechavcto]
			  ,[ARR_vamos]
			  ,[ARR_cod_corresponsal]
			  ,[ARR_p_indFWD]
			  ,[ARR_p_numFWD]
			  ,[ARR_fechaFwdini]
			  ,[ARR_fechaFwdvcto]
			  ,[ARR_mtipo_cambioFwd]
			  ,[ARR_prodFWD]
			  ,[ARR_netting]
			  ,[ARR_numero_tbtx]
			  ,[ARR_controla_tran]
			  ,[ARR_gs_Corresponsal]
			  ,[ARR_p_ind_origen_manual]
			  ,[ARR_cmx_punta_pizarra]
			  ,[ARR_cmx_tc_costo_trad]
			  ,[ARR_nResultadoTrans_Mo]
			  ,[ARR_nResultadoTrans_Clp]
			  ,[ARR_sCanal]
			  ,[ARR_usuario_digitador]
			  ,[NUMEROBAC]
			  ,[ARR_cAreaResponsable]
			  ,[ARR_cCodCartNorm]
			  ,[ARR_cCodSubCartNorm]
			  ,[ARR_cCodLibro]
			  ,[ARR_nCodCart]
			  ,[ARR_nBroker]
			  ,[ARR_cTipRetiro]
			  ,[ARR_nEquMda1]
			  ,[ARR_nMtoMda2]
			  ,[ARR_nEquUSD2]
			  ,[ARR_nEquMda2]
			  ,[ARR_nParMda1]
			  ,[ARR_nPreMda1]
			  ,[ARR_nParMda2]
			  ,[ARR_nPreMda2]
			  ,[ARR_nSpread]
			  ,[ARR_nPrecal]
			  ,[ARR_nPlazo]
			  ,[ARR_nTasaUSD]
			  ,[ARR_nTasaCon]
			  ,[ARR_nMtoInMon1]
			  ,[ARR_nMtoFiMon1]
			  ,[ARR_nMtoInMon2]
			  ,[ARR_nMtoFiMon2]
			  ,[ARR_nMtodif]
			  ,[ARR_nPrecioTransfer]
			  ,[ARR_cTipoSintetico]
			  ,[ARR_nPrecioSpot]
			  ,[ARR_nPaisOrigen]
			  ,[ARR_nMonedaCompensacion]
			  ,[ARR_cRiesgoSintetico]
			  ,[ARR_nPrecioReversaSint]
			  ,[ARR_nPremio]
			  ,[ARR_cTipOpc]
			  ,[ARR_nPrecioPunta]
			  ,[ARR_nRemunera]
			  ,[ARR_nTasa_Efectiva_Moneda1]
			  ,[ARR_nTasa_Efectiva_Moneda2]
			  ,[ARR_cOper_Rela_Spot]
			  ,[ARR_nEquUSD1]
			  ,[ARR_iMoneda1]
			  ,[ARR_iMoneda2]
			  ,[ARR_TipModa]
		FROM   dbo.MonitorFX_TblOperaciones o WITH(NOLOCK)
		INNER JOIN dbo.MonitorFX_TblConfArchivos mftca WITH(NOLOCK) ON mftca.idArchivo = o.idArchivo 
		AND mftca.Arch_bHabilitado=1 
		WHERE  (o.IDARCHIVO = 5 AND o.Oper_sNemoVendedor =4 AND ARR_CLIENTE_RUT <>0 AND NUMEROBAC IS NULL)
			   OR  (o.IDARCHIVO = 4 AND ARR_CLIENTE_RUT <>0 AND NUMEROBAC IS NULL)
			   OR  (o.IDARCHIVO = 6 AND ARR_CLIENTE_RUT <>0 AND NUMEROBAC IS NULL)
	
			
	END 
GO
