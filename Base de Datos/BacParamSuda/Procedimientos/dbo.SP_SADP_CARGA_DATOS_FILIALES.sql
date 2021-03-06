USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_CARGA_DATOS_FILIALES]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_CARGA_DATOS_FILIALES]( @dFechaProceso	DATETIME, @sUsuario VARCHAR(15) )
AS   
BEGIN  
 SET NOCOUNT ON;  
  
 SELECT *, 'Estado'=CONVERT(CHAR(1),''), 'Nombre'=CONVERT(CHAR(50),''), 'DV'=CONVERT(CHAR(1),'') INTO #t_mdlbtr FROM MDLBTR WHERE 1=2  
   
 DECLARE @sFecha DATETIME  
  SET @sFecha  =(SELECT sc.dFechaProceso FROM SADP_Control sc);  
   
 INSERT INTO #t_mdlbtr  
  ( fecha                     
  , sistema   
  , tipo_mercado   
  , tipo_operacion   
  , estado_envio   
  , numero_operacion                          
  , rut_cliente                               
  , codigo_cliente                            
  , moneda                                    
  , monto_operacion                           
  , forma_pago                                
  , fecha_operacion           
  , fecha_vencimiento         
  , Liquidada   
  , RecRutBanco                               
  , RecCodBanco                               
  , RecCodSwift            
  , RecDireccion                                                             
  , RecCtaCte              
  , Tipo_Movimiento   
  , GlosaAnticipo                                                                                  
  , Id_Paquete                                
  , Estado_Paquete   
  , Reservado  
  , Nombre  
  , Dv  
  ,   secuencia)  
    
 SELECT @sFecha     
 , 'GPI'  
 , scpg.sCodigo  
 , scpg.sCodigo  
 , 'PF2'  
 , o.id_operacion  
 , CONVERT(INT,SUBSTRING(LTRIM(RTRIM(c2.rut_cliente)),1,LEN(LTRIM(RTRIM(c2.rut_cliente)))-2))
 , 1  
 , CASE o.cod_moneda WHEN 'CLP' THEN 999 WHEN 'USD' THEN 13 END
 ,   o.monto_operacion  
 , 0     
 , o.fecha_liquidacion  
 , o.fecha_liquidacion  
 , ''  
 , CONVERT(INT,SUBSTRING(LTRIM(RTRIM(c2.rut_cliente)),1,LEN(LTRIM(RTRIM(c2.rut_cliente)))-2))
 , 0  
 , ''  
 , 'S/D'  
 , ''  
 , 'C'  
 , ''  
 , 0  
 , 'D'  
 , ''  
 ,  substring(c2.RAZON_SOCIAL,1,30)
 ,  RIGHT(c2.RUT_CLIENTE,1),1
	  FROM GPIMAS.dbo.operacion o 
	 INNER 
	  JOIN GPIMAS.dbo.CUENTA c 
		ON c.ID_CUENTA = o.ID_CUENTA
	 INNER 
	  JOIN GPIMAS.dbo.CLIENTE c2 
		ON c2.ID_CLIENTE = c.ID_CLIENTE
	 INNER 
	  JOIN bacparamsuda.dbo.SADP_COD_PRODUCTO_GPI scpg 
		ON scpg.cCodigo = o.COD_TIPO_OPERACION   
    WHERE  O.COD_ESTADO <> 'A'      
   AND o.MONTO_OPERACION<>0  
	  AND o.cod_tipo_operacion<>'SORLET'
	  AND o.fecha_liquidacion = @dFechaProceso
  
 INSERT INTO #t_mdlbtr  
  ( fecha      --1           
  , sistema      --2  
  , tipo_mercado    --3  
  , tipo_operacion    --4  
  , estado_envio    --5  
  , numero_operacion   --6              
  , rut_cliente     --7             
  , codigo_cliente    --8             
  , moneda                      --9           
  , monto_operacion             --10         
  , forma_pago                  --11  
  , fecha_operacion    --12  
  , fecha_vencimiento   --13  
  , liquidada     --14  
  , RecRutBanco                 --15              
  , RecCodBanco                 --16          
  , RecCodSwift     --17  
  , RecDireccion    --18                                                
  , RecCtaCte     --19  
  , Tipo_Movimiento    --20  
  , GlosaAnticipo    --21                                                                                                                                     
  , Id_Paquete     --22                  
  , Estado_Paquete    --23  
  , Reservado     --24  
  , Nombre      --25  
  ,   Dv       --26  
  , secuencia)     --27  
 SELECT @sFecha     ,  --1  
   'FFMM'     ,  --2  
   mov.mer_codigo   ,  --3  
   mov.tip_codigo   ,  --4  
   'PF2'     ,  --5   
   detmov.mov_operacion ,  --6  
   cli.cli_rut    ,  --7  
   1      ,  --8  
   iCodSADP    ,  --9  
   SUM(detmov.det_monto_operacion),--10  
   CASE WHEN srfp.nCodInterno =0 THEN ISNULL((SELECT id_formapago FROM SADP_VALORDEFAULT sv where sv.origen='FFMM' AND sv.Mercado=mov.mer_codigo AND sv.Moneda =icodsadp),0)  
     ELSE srfp.nCodInterno   
   END ,       --11  
   mov.mov_fecha_liquidacion,  --12  
   mov.mov_fecha_liquidacion,  --13  
   '',        --14  
    CASE WHEN mov.man_codigo ='' THEN cli.cli_rut   
     ELSE (SELECT rut FROM SADP_REL_BCOFFMM_BANCOS WHERE codigo = mov.man_codigo)   
    END        , --15    
   0         ,  
   ''         ,  
   SUBSTRING(cli.cli_direccion,1,30) ,  
   mov.cue_numero_cuenta    ,  
   'C'         ,  
   ''         ,   
   0         ,  
   'D'         ,  
   ''         ,  
   SUBSTRING(cli.cli_razon_social,1,30),  
   cli.cli_dv       ,  
   mov.Emp_Codigo  
 FROM bacinver.dbo.INV_MOVIMIENTOS mov,  
   BACINVER.DBO.INV_DET_MOVIMIENTOS detmov,  
   bacinver.dbo.inv_clientes cli,  
   --fmparticipes.dbo.fmp_fondos fon,  
   fmparticipes.dbo.fmp_monedas mon,   
   bacinver.dbo.INV_NEMOTECNICOS nemo,  
   bacparamsuda.dbo.SADP_ConversionMoneda scm,  
   SADP_RELACION_FPAGO srfp  
 WHERE mov.mov_fecha_liquidacion = @dFechaProceso  
 AND  mov.mov_estado_inversion  = 'ACTU'  
 -- AND  fon.cod_fondo     = mov.emp_codigo  
 AND  mon.cod_mon_bacinver     = nemo.ind_codigo  
 AND  cli.cli_rut      = mov.cli_rut  
 AND  scm.sSistema     = 'FFMM'  
 AND  scm.iCodMoneda     = CASE mon.cod_moneda WHEN 998 THEN 999 ELSE mon.cod_moneda  end   
 AND  mov_tipo_operacion_rel   <>'VRRF'  
 AND     tip_codigo     <>'VRRF'  
 AND     srfp.cOrigen ='FFMM'  
 AND  mov.Emp_Codigo = detmov.emp_codigo  
 AND  mov.mov_operacion= detmov.mov_operacion  
 AND  srfp.nCodExterno =mov.mov_forma_pago  
 AND  nemo.nem_nemotecnico=detmov.nem_nemotecnico  
	AND		mov.mov_operacion NOT IN (SELECT DISTINCT a.mov_operacion FROM bacinver.dbo.INV_DET_MOVIMIENTOS a, bacinver.dbo.INV_MOVIMIENTOS b WHERE a.mov_operacion=b.mov_operacion and nem_nemotecnico IN ('CTELEHMAN','DIV INTER') AND mov.cli_rut=101 and b.mov_fecha_liquidacion = @dFechaProceso)   
	GROUP BY detmov.mov_operacion, CASE nemo.ind_codigo WHEN 'UF' THEN '$$' ELSE nemo.ind_codigo END           , mov.mer_codigo			,			mov.tip_codigo			, cli.cli_rut,icodsadp,ncodinterno, mov_fecha_liquidacion, man_codigo,cli_direccion, cue_numero_cuenta, cli_razon_social, cli_dv,mov.Emp_Codigo
  
  
 DELETE FROM #t_mdlbtr  
	WHERE numero_operacion IN (SELECT DISTINCT a.mov_operacion FROM bacinver.dbo.INV_DET_MOVIMIENTOS a, bacinver.dbo.INV_MOVIMIENTOS b WHERE a.mov_operacion=b.mov_operacion and nem_nemotecnico IN ('CTELEHMAN','DIV INTER') AND b.cli_rut=101 and b.mov_fecha_liquidacion = @dFechaProceso)
     
 UPDATE #t_mdlbtr   
    SET RecCodBanco= VSB.Cod_Inst   
 ,  RecCodSwift=VSB.Clswift   
   FROM #t_mdlbtr INNER JOIN view_sadp_bancos vsb ON vsb.Clrut = RecRutBanco  
   
 UPDATE #t_mdlbtr  SET forma_pago = 134 WHERE (forma_pago=103 OR forma_pago=105) AND (RecCodBanco <> 27)  
  
    UPDATE #t_mdlbtr  SET forma_pago = 128 WHERE forma_pago = 134 AND monto_operacion>1000000000  --Mayor a 1000000000 se cambia a LBTR  
  
 UPDATE #t_mdlbtr  set RecCtaCte = REPLACE(RecCtaCte ,'-','');  
  
/*  
    --> ELIMINO REGISTROS PENDIENTES PARA CARGAR NUEVAMENTE     
    --  ========================================================================================================================  
  DELETE SADP_DETALLE_PAGOS  
    FROM SADP_DETALLE_PAGOS sdp  
   INNER   
    JOIN MDLBTR lt  
      ON lt.sistema     = sdp.cModulo  
     AND lt.numero_operacion = sdp.nContrato  
     AND lt.Secuencia     = sdp.iSecuencia  
   WHERE sdp.cEstado <>'E'  
     AND lt.fecha = @dFechaProceso  
     AND lt.sistema IN('FFMM','GPI')  
    
  DELETE   
    FROM MDLBTR   
   WHERE fecha= @dFechaProceso   
     AND sistema IN('FFMM','GPI')  
     AND estado_envio <> 'E'  
 --  ========================================================================================================================     
 -->  
       
	
	    
*/  

	
 DELETE #t_mdlbtr     
   FROM #t_mdlbtr PAGOS   
  INNER   
   JOIN mdlbtr Pago  
     ON pago.fecha = pagos.fecha  
    AND pago.sistema=pagos.sistema  
    AND pago.numero_operacion = pagos.numero_operacion  
        
  
  
 INSERT INTO mdlbtr  
  ( fecha                     
  , sistema   
  , tipo_mercado   
  , tipo_operacion   
  , estado_envio   
  , numero_operacion                          
  , rut_cliente                       
  , codigo_cliente                            
  , moneda                                    
  , monto_operacion                           
  , forma_pago                                
  , fecha_operacion           
  , fecha_vencimiento         
  , liquidada   
  , RecRutBanco                               
  , RecCodBanco                               
  , RecCodSwift            
  , RecDireccion                                                             
  , RecCtaCte              
  , Tipo_Movimiento   
  , GlosaAnticipo            
  , Id_Paquete                                
  , Estado_Paquete   
  , Reservado  
  , Secuencia )  
  
 SELECT a.fecha                     
  , a.sistema   
  , a.tipo_operacion --, a.tipo_mercado   
  , ISNULL(b.CodInterno,'')   
  , a.estado_envio   
  , a.numero_operacion                          
  , a.rut_cliente                               
  , a.codigo_cliente                            
  , a.moneda                                    
  , a.monto_operacion                           
  ,   CASE when a.forma_pago = 0 THEN isnull(sv.id_FormaPago,0) ELSE a.forma_pago END  
  , a.fecha_operacion           
  , a.fecha_vencimiento         
  , a.liquidada   
  , a.RecRutBanco                               
  , a.RecCodBanco                          
  , a.RecCodSwift            
  , a.RecDireccion                                             
  , a.RecCtaCte              
  , ISNULL(b.sMovimiento,'N')  
  -->, a.Tipo_Movimiento   
  , a.GlosaAnticipo                                                                                                                                            
  , a.Id_Paquete                                
  , a.Estado_Paquete   
  , a.Reservado  
   , a.secuencia  
  FROM #t_mdlbtr a  
  LEFT     
   JOIN dbo.SADP_PRODUCTO_MODULOEXTERNO b  
     ON b.Modulo=a.sistema  
    AND b.Codigo = tipo_operacion  
   LEFT      
   JOIN SADP_VALORDEFAULT sv  
     ON sv.Origen  = a.sistema  
       AND sv.Mercado = a.tipo_mercado  
       AND sv.Moneda  = a.moneda  
  
  
  
  INSERT INTO SADP_DETALLE_PAGOS  
  ( nContrato                                 
  , cModulo   
  , iMoneda   
  , iFormaPago   
  , nMonto                                    
  , iRutBeneficiario                          
  , sDigBeneficiario   
  , sNomBeneficiario                                     
  , sNomBanco                                            
  , sSwift                 
  , sCtaCte                
  , sUsuario          
  , sFirma1      
  , sFirma2           
  , cEstado   
  , cObservaciones                                                                                                                                                                                                                                             
  
  , iRutCliente                               
  , iCodigo  
  , iRutBanco  
  ,   sDvBanco  
  , iSecuencia  
  )  
  SELECT  
   a.numero_operacion  
  , a.sistema  
  , a.moneda  
  ,   CASE when a.forma_pago = 0 THEN isnull(sv.id_FormaPago,0) ELSE a.forma_pago END      
  , a.monto_operacion        /* nMonto    */  
  , CONVERT(INT,a.rut_cliente)                      /* iRutBeneficiario  */         
  , a.dv           /* sDigBeneficiario  */  
  , ISNULL(SUBSTRING(a.Nombre,1,30),'')    /* sNomBeneficiario  */  
  , ISNULL(vsb.clnombre,'')       /* sNomBanco   */  
  ,   RecCodSwift  
  , a.RecCtaCte--ISNULL(scc.sCuentaCorriente,'')    /* sCtaCte    */  
  , @sUsuario          /* sUsuario    */  
  , @sUsuario          /* sFirma1    */     
  , ''            /* sFirma2    */  
  , 'PF2'           /* cEstado    */  
  ,   ''            /* cObservaciones  */    
  ,   CONVERT(INT,a.rut_cliente)      /* iRutCliente   */  
  ,   1            /* iCodigo    */  
  , ISNULL(clrut,0)  
  , ISNULL(cldv,'')  
  , a.secuencia  
  FROM #t_mdlbtr a  
     LEFT      
     JOIN SADP_CuentasCorrientes scc  
    ON iRutCliente     = CONVERT(INT,a.rut_cliente)  
      AND scc.iCodCliente = 1  
      AND scc.bPrincipal = 1 --> Indica que es la principal   
     LEFT  
     JOIN VIEW_SADP_BANCOS vsb  
       ON vsb.Clrut = a.RecRutBanco    
  LEFT   
     JOIN SADP_VALORDEFAULT sv  
       ON sv.Origen  = a.sistema  
         AND sv.Mercado = a.tipo_mercado  
         AND sv.Moneda  = a.moneda  
        
  -- EXECUTE SP_SADP_GRABA_RESCATES_A_PAGO_REV  @dFechaProceso    
  
    
END   



-- execute SP_SADP_CARGA_DATOS_FILIALES '20111011','GPITEST'  
-- SELECT * FROM MDLBTR m WHERE m.sistema='GPI' and fecha='20111011'

GO
