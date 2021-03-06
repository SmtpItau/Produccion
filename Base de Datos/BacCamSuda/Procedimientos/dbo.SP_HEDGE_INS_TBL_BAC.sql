USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGE_INS_TBL_BAC]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_HEDGE_INS_TBL_BAC]  
 @fechaproceso DATETIME,    
 @fechaHedge DATETIME      
AS    

BEGIN    
    
  SET NOCOUNT ON    
 -->BORRADO DE DATOS    
    
 DELETE TBL_HEDGE_SWAP --WHERE fecha_Proceso = @fechaproceso    
 -->LLENADO    
    
 INSERT INTO TBL_HEDGE_SWAP    
 ( fecha_Proceso    
 , numero_operacion    
 , tipo_flujo    
 , tipo_swap    
 , descripcion    
 , tipo_operacion    
 , Clnombre    
 , compra_moneda    
 , venta_moneda    
 , compra_mercado_clp    
 , venta_mercado_clp    
 , operador    
 )    
 SELECT DISTINCT CARTERARES.Fecha_Proceso    
 ,  CARTERARES.numero_operacion    
 ,  CARTERARES.tipo_flujo    
 ,  CARTERARES.tipo_swap    
 ,  PRODUCTO.descripcion    
 ,  CARTERARES.tipo_operacion     
 ,  CLIENTE.Clnombre    
 ,  CARTERARES.compra_moneda    
 ,  CARTERARES.venta_moneda    
 ,  CARTERARES.compra_mercado_clp    
 ,  CARTERARES.venta_mercado_clp    
 ,  CARTERARES.operador    
 FROM BacSwapSuda.dbo.CARTERARES CARTERARES WITH(NOLOCK)     
 INNER JOIN bacparamsuda..PRODUCTO PRODUCTO WITH(NOLOCK) ON CARTERARES.tipo_swap = CASE      
      WHEN PRODUCTO.codigo_producto = 'FR' THEN 3       
      WHEN PRODUCTO.codigo_producto = 'SM' THEN 2    
      WHEN PRODUCTO.codigo_producto = 'SP' THEN 4    
      WHEN PRODUCTO.codigo_producto = 'ST' THEN 1    
      END    
      AND PRODUCTO.id_sistema = 'PCS'     
 INNER JOIN bacparamsuda..CLIENTE CLIENTE WITH(NOLOCK) ON    CARTERARES.rut_cliente = CLIENTE.Clrut     
        AND CARTERARES.codigo_cliente = CLIENTE.Clcodigo     
    
 WHERE            
       (CARTERARES.fecha_proceso = @fechaproceso)     
  AND  (CARTERARES.estado_flujo = 1)     
  AND  (CARTERARES.tipo_swap <> 4)     
  AND  (CARTERARES.estado <> 'C')    
    
 IF @@ERROR <> 0     
 BEGIN     
  DELETE TBL_HEDGE_SWAP WHERE fecha_Proceso = @fechaproceso    
  SELECT -1,'Error: al cargar tabla de Forward Swap'    
  RETURN -1    
 END     
    
 DELETE TBL_HEDGE_FWD --WHERE caFechaProceso = @fechaproceso    
    
 INSERT INTO TBL_HEDGE_FWD    
 ( caFechaProceso     
 , canumoper    
 , cafecha    
 , catipoper    
 , catipmoda    
 , mnnemo1    
 , mnnemo2    
 , camtomon1    
 , camtomon2    
 , capremon1    
 , catipcam    
 , cafecvcto    
 , camarktomarket    
 , cacodpos1    
 , caoperador    
 , ValorRazonableActivo    
 , ValorRazonablePasivo    
 , fRes_Obtenido    
 , catasaufclp    
 , catasadolar    
 , fVal_Obtenido    
 )    
    
 SELECT  MFCARES.CaFechaProceso    
 ,  MFCARES.canumoper    
 ,  MFCARES.cafecha    
 ,  MFCARES.catipoper    
 ,  MFCARES.catipmoda    
 ,  VIEW_MONEDA.mnnemo    
 ,  VIEW_MONEDA_1.mnnemo    
 ,  MFCARES.camtomon1    
 ,  MFCARES.camtomon2    
 ,  MFCARES.capremon1    
 ,  MFCARES.catipcam    
 ,  MFCARES.cafecvcto    
 ,  MFCARES.camarktomarket    
 ,  MFCARES.cacodpos1    
 ,  MFCARES.caoperador    
 ,  ISNULL( MFCARES.ValorRazonableActivo, 0.0)    
 ,  ISNULL( MFCARES.ValorRazonablePasivo, 0.0)    
 ,  ISNULL( MFCARES.fRes_Obtenido, 0.0)    
 ,  MFCARES.catasaufclp    
 ,  MFCARES.catasadolar    
 ,  ISNULL( MFCARES.fVal_Obtenido, 0.0)    
 FROM  Bacfwdsuda.dbo.MFCARES MFCARES WITH(NOLOCK)    
 ,  Bacfwdsuda.dbo.VIEW_MONEDA VIEW_MONEDA WITH(NOLOCK)    
 ,  Bacfwdsuda.dbo.VIEW_MONEDA VIEW_MONEDA_1 WITH(NOLOCK)    
 WHERE MFCARES.cacodmon1 = VIEW_MONEDA.mncodmon      
 AND  MFCARES.cacodmon2 = VIEW_MONEDA_1.mncodmon     
 AND  MFCARES.CaFechaProceso = @fechaproceso    
 AND  cacodpos1 in (1,2,3,10,13)    

 UNION    
    
 SELECT  MFCARES.CaFechaProceso    
 ,  MFCARES.canumoper    
 ,  MFCARES.CaFechaStarting  --cafecha    
 ,  MFCARES.catipoper    
 ,  MFCARES.catipmoda    
 ,  VIEW_MONEDA.mnnemo    
 ,  VIEW_MONEDA_1.mnnemo    
 ,  MFCARES.camtomon1    
 ,  MFCARES.camtomon2    
 ,  MFCARES.capremon1    
 ,  MFCARES.catipcam   
 ,  MFCARES.cafecvcto    
 ,  MFCARES.camarktomarket    
 ,  MFCARES.cacodpos1    
 ,  MFCARES.caoperador    
	-- PRD12720
	--, 	ISNULL( MFCARES.ValorRazonableActivo, 0.0)
	--, 	ISNULL( MFCARES.ValorRazonablePasivo, 0.0)
	,	CASE when MFCARES.CaFechaStarting >= @fechaproceso then 0.0
			 when MFCARES.CaFechaStarting < @fechaproceso then ISNULL( MFCARES.ValorRazonableActivo, 0.0)
		END
	,	CASE when MFCARES.CaFechaStarting >= @fechaproceso then 0.0
			 when MFCARES.CaFechaStarting < @fechaproceso then ISNULL( MFCARES.ValorRazonablePasivo, 0.0)
		END
	-- PRD12720
 ,  ISNULL( MFCARES.fRes_Obtenido, 0.0)    
 ,  MFCARES.catasaufclp    
 ,  MFCARES.catasadolar    
	-- PRD12720
	,	CASE when MFCARES.CaFechaStarting >= @fechaproceso then ISNULL( MFCARES.caDelta, 0.0) 
			 when MFCARES.CaFechaStarting < @fechaproceso then 0.0
		END
 FROM  Bacfwdsuda.dbo.MFCARES MFCARES WITH(NOLOCK)    
 ,  Bacfwdsuda.dbo.VIEW_MONEDA VIEW_MONEDA WITH(NOLOCK)    
 ,  Bacfwdsuda.dbo.VIEW_MONEDA VIEW_MONEDA_1 WITH(NOLOCK)    
 WHERE MFCARES.cacodmon1 = VIEW_MONEDA.mncodmon      
 AND  MFCARES.cacodmon2 = VIEW_MONEDA_1.mncodmon     
 AND  MFCARES.CaFechaProceso = @fechaproceso    
	-- AND 	MFCARES.CaFechaStarting < @fechaHedge	PRD12720
 AND  cacodpos1 = 14    
 ORDER BY MFCARES.cacodpos1, MFCARES.canumoper    

   
 IF @@ERROR <> 0     
 BEGIN     
  DELETE TBL_HEDGE_FWD --WHERE caFechaProceso = @fechaproceso    
  SELECT -1,'Error: al cargar tabla de Forward Hedge'    
  RETURN -1    
 END      
    
 DELETE TBL_HEDGE_OPCION --WHERE Fecha_Proceso = @fechaproceso    
    
 INSERT INTO  TBL_HEDGE_OPCION     
 ( fecha_proceso    
 , numero_contrato    
 , numero_componente    
 , vinculacion    
 , tipo_opcion     
 , subyacente     
 , payoff    
 , compra_venta    
 , vencimiento    
 , par_monedas    
 , moneda_1    
 , monto_1    
 , moneda_2    
 , monto_2    
 , strike    
 , modalidad    
 , moneda_comp    
 , tipo_ejercicio    
 , valor_mercado_clp    
 , delta_usd    
 )    
SELECT [Fecha_Proceso] = @fechaproceso
, [Numero Contrato] = det.CaNumContrato       
 , [Numero Componente] = det.CaNumEstructura       
 , [Vinculacion] = cavinculacion       
 , [Tipo Opcion] = ISNULL(CASE WHEN CaTipoOpc = 'V' THEN 'Vanilla' WHEN CaTipoOpc = 'E' THEN 'Exotica' END, '')    
   , [Subyacente] = CaSubyacente       
 , [PayOff] = CASE WHEN CaTipoPayOff = '01' THEN 'Vanilla' WHEN CaTipoPayOff = '02' THEN 'Asiatica' END       
 , [Compra/Venta] = CaCVOpc       
 , [Vencimiento] = CaFechaVcto       
 , [Par Monedas] = CaParStrike       
 , [Moneda 1] = CaCodMon1       
 , [Monto 1] = CaMontoMon1       
 , [Moneda 2] = CaCodMon2       
 , [Monto 2] = CaMontoMon2       
 , [Strike] = CaStrike       
 , [Modalidad] = CaModalidad       
 , [Moneda Compensacion] = CaMdaCompensacion       
 , [Tipo Ejercicio] = CaTipoEjercicio       
 , [Valor Mercado (CLP)] = CaVrDetML       
 , [Delta (USD)] = CASE WHEN CaTipoPayOff = '01' THEN CaDelta_spot WHEN CaTipoPayOff = '02' THEN CaDelta_spot_num END       
 FROM  LNKOPC.CbMdbOpc.dbo.CaResDetContrato            det     
       INNER JOIN LNKOPC.CbMdbOpc.dbo.CaResEncContrato enc  ON     enc.CaEncFechaRespaldo     = det.CaDetFechaRespaldo 
       AND enc.CaNumContrato          = det.CaNumContrato
 ,     LNKOPC.CbMdbOpc.dbo.OpcionesGeneral    
 WHERE       CaFechaInicioOpc    < @fechaHedge    
 AND   (   (  CaModalidad = 'C' AND CaBenchComp = 994 AND CaFechaVcto >= FechaProx ) -- @fechaproceso )
       OR  (  CaModalidad = 'E' AND CaFechaVcto > @fechaHedge) -- @fechaproceso
             )
AND  ( CaEstado <> 'C' ) 
AND  det.CaDetFechaRespaldo = @fechaproceso




/*
WHERE ((CaModalidad = 'C'AND CaBenchComp = 994 AND CaFechaVcto >= FechaProx ) OR (CaModalidad = 'E' AND CaFechaVcto > FechaProc )) 
AND Det.CanumCOntrato = Enc.CaNumContrato           
AND Enc.CaEstado <> 'C'


AND   (   (  CaModalidad = 'C'  AND CaBenchComp = 994 AND CaFechaVcto >= FechaProx ) -- @fechaproceso )
       OR ( CaModalidad = 'E' AND CaFechaVcto > @fechaproceso )
             )
AND  ( CaEstado <> 'C' ) 
AND  det.CaDetFechaRespaldo = @fechaproceso



 SELECT [Fecha_Proceso] = @fechaproceso    
 , [Numero Contrato] = det.CaNumContrato       
 , [Numero Componente] = det.CaNumEstructura       
 , [Vinculacion] = cavinculacion       
 , [Tipo Opcion] = ISNULL(CASE WHEN CaTipoOpc = 'V' THEN 'Vanilla' WHEN CaTipoOpc = 'E' THEN 'Exotica' END, '')    
   , [Subyacente] = CaSubyacente       
 , [PayOff] = CASE WHEN CaTipoPayOff = '01' THEN 'Vanilla' WHEN CaTipoPayOff = '02' THEN 'Asiatica' END       
 , [Compra/Venta] = CaCVOpc       
 , [Vencimiento] = CaFechaVcto       
 , [Par Monedas] = CaParStrike       
 , [Moneda 1] = CaCodMon1       
 , [Monto 1] = CaMontoMon1       
 , [Moneda 2] = CaCodMon2       
 , [Monto 2] = CaMontoMon2       
 , [Strike] = CaStrike       
 , [Modalidad] = CaModalidad       
 , [Moneda Compensacion] = CaMdaCompensacion       
 , [Tipo Ejercicio] = CaTipoEjercicio       
 , [Valor Mercado (CLP)] = CaVrDetML       
 , [Delta (USD)] = CASE WHEN CaTipoPayOff = '01' THEN CaDelta_spot WHEN CaTipoPayOff = '02' THEN CaDelta_spot_num END       
 FROM    
       LNKOPC.CbMdbOpc.dbo.CaDetContrato            det     
              INNER JOIN LNKOPC.CbMdbOpc.dbo.CaEncContrato enc ON enc.CaNumContrato = det.CaNumContrato    
 ,     LNKOPC.CbMdbOpc.dbo.OpcionesGeneral    
 WHERE   CaFechaInicioOpc < @fechaHedge    
 AND  (  (CaModalidad = 'C'AND CaBenchComp = 994 AND   CaFechaVcto > FechaProx )    
       OR    
                (CaModalidad = 'E' AND CaFechaVcto > FechaProc )    
             )    
        AND     (CaEstado   <> 'C') -->  Para sacar las cotizaciones    
  */
  
    
 IF @@ERROR <> 0     
 BEGIN     
  DELETE TBL_HEDGE_OPCION --WHERE fecha_proceso <= @fechaproceso    
  SELECT -1,'Error: al cargar tabla de Opcion Hedge'    
  RETURN -1     
 END     
    
  SET NOCOUNT OFF    
 SELECT 'OK'    
END 








GO
